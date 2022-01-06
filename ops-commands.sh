ops-craft() {
    cmd-doc "Run craft commands within ops more easily."
    ops shell ./craft "$@"
}

ops-configure() {
    cmd-doc "Interactively configure ops settings in your .env file."

    PROJECT=$(ops project name)

    DEFAULT=${DB_SERVER:-mariadb}
    read -p "Database Server [$DEFAULT]: " INPUT
    ops env DB_SERVER ${INPUT:-$DEFAULT}

    DEFAULT=${PROJECT//[^a-zA-Z0-9]/_}
    DEFAULT=${DB_DATABASE:-$DEFAULT}
    read -p "Database Name [$DEFAULT]: " INPUT
    ops env DB_DATABASE ${INPUT:-$DEFAULT}

    read -p "Remote host [$OPS_PROJECT_REMOTE_HOST]: " INPUT
    ops env OPS_PROJECT_REMOTE_HOST ${INPUT:-$OPS_PROJECT_REMOTE_HOST}

    if [[ -n "$OPS_PROJECT_REMOTE_HOST" ]]; then

        read -p "Remote user [$OPS_PROJECT_REMOTE_USER]: " INPUT
        ops env OPS_PROJECT_REMOTE_USER ${INPUT:-$OPS_PROJECT_REMOTE_USER}

        read -p "Remote path [$OPS_PROJECT_REMOTE_PATH]: " INPUT
        ops env OPS_PROJECT_REMOTE_PATH ${INPUT:-$OPS_PROJECT_REMOTE_PATH}

        read -p "Remote database name [$OPS_PROJECT_REMOTE_DB_NAME]: " INPUT
        ops env OPS_PROJECT_REMOTE_DB_NAME ${INPUT:-$OPS_PROJECT_REMOTE_DB_NAME}

        read -p "Sync dirs [$OPS_PROJECT_SYNC_DIRS]: " INPUT
        ops env OPS_PROJECT_SYNC_DIRS ${INPUT:-$OPS_PROJECT_SYNC_DIRS}

    fi
}

ops-padstone-install() {
    cmd-doc "Run this only once per project to complete the Padstone install."

    echo "Installing imarc-boilerplate..."
    npm install imarc-boilerplate -y

    echo "Running $(tput smul)npx imarc-boilerplate$(tput rmul)..."
    npx imarc-boilerplate -y

    ops install
}

ops-install() {
    cmd-doc "Run this after cloning the project to setup the project for local development on Ops."

    if [[ ! -e .env ]]; then
        echo "Copying .env.example to .env..."
        cp .env.example .env
    fi

    if [ -t 1 ]; then
        echo "Calling $(tput smul)ops configure$(tput rmul)..."
        ops configure
    else
        echo You may wish to run $(tput smul)ops configure$(tput rmul) after this.
    fi

    # get updated settings; unusual syntax for bash 3.2.57
    source /dev/stdin <<<"$(ops env)"

    if [[ -n "$DB_DATABASE" ]] && [[ -n "$OPS_PROJECT_REMOTE_DB_NAME" ]]; then
        read -p "Run ops sync now [Yn]: " INPUT
        if [[ $INPUT == 'Y' ]]; then
            echo "Running $(tput smul)ops sync$(tput rmul)..."
            ops sync
        fi

    elif [[ -e ./padstone.sql ]] && [[ -n "$DB_DATABASE" ]]; then
        echo "Importing padstone.sql into $DB_DATABASE..."
        ops craft db/restore padstone.sql

        echo "Running craft migrations..."
        ops craft migrate/all --no-backup=1 --interactive=0
    else
        echo "Skipping syncing or importing padstone.sql..."
    fi

    if [[ -z "$SECURITY_KEY" ]] && [[ -n "$DB_DATABASE" ]]; then
        echo "Running $(tput smul)ops craft setup/security-key$(tput rmul)..."
        ops craft setup/security-key
    else
        echo "Skipping generating security key ($(tput smul)ops craft setup/security-key$(tput rmul))  because DB_DATABASE is not set."
    fi

    echo "Calling $(tput smul)composer install$(tput rmul)..."
    composer install
    echo "Calling $(tput smul)npm install$(tput rmul)..."
    npm install
    echo "Calling $(tput smul)npm run dev$(tput rmul)..."
    npm run dev

    echo -en "\nVisit your site at https://$(ops project name).imarc.io/\n"
}
