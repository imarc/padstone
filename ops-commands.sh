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

    npx imarc/boilerplate-components
    echo -e "\n@import \"~bootstrap/scss/bootstrap\";" >> resources/styles/main.scss
    echo -e "\nimport \"bootstrap\"" >> resources/js/main.js

    ops install
}

ops-install() {
    cmd-doc "Run this after cloning the project to setup the project for local development on Ops."

    if [[ ! -e .env ]]; then
        cp .env.example .env
    fi

    if [ -t 1 ]; then
        ops configure
    else
        echo You may wish to run $(tput smul)ops configure$(tput rmul) after this.
    fi

    # get updated settings
    DB_DATABASE=$(ops env DB_DATABASE)
    OPS_PROJECT_REMOTE_DB_NAME=$(ops env OPS_PROJECT_REMOTE_DB_NAME)
    SECURITY_KEY=$(ops env SECURITY_KEY)

    if [[ -n "$DB_DATABASE" ]] && [[ -n "$OPS_PROJECT_REMOTE_DB_NAME" ]]; then
        read -p "Run ops sync now [Yn]: " INPUT
        if [[ $INPUT == 'Y' ]]; then
            ops sync
        fi

    elif [[ -e ./padstone.sql ]] && [[ -n "$DB_DATABASE" ]]; then
        echo "Importing padstone.sql into $DB_DATABASE..."
        ops mariadb import $DB_DATABASE < ./padstone.sql
        ops craft migrate
    fi

    if [[ -z "$SECURITY_KEY" ]]; then
        ops craft setup/security-key
    fi

    ops composer install
    ops npm install
    ops npm run dev

    echo -n "\nVisit your site at https://$(ops project name).imarc.io/"
}
