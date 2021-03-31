ops-craft() {
    cmd-doc "Run craft commands within ops more easily."
    ops shell ./craft "$@"
}

ops-configure() {
    cmd-doc "Interactively configure ops settings in your .env file."

    BASENAME=$(basename $0)

    DEFAULT=${BASENAME//[^a-zA-Z0-9-]/_}
    DEFAULT=${DB_DATABASE:-$DEFAULT}
    read -p "Database Name [$DEFAULT]: " INPUT
    ops env DB_DATABASE ${INPUT:-$DEFAULT}

    read -p "Remote host [$OPS_PROJECT_REMOTE_HOST]: " INPUT
    ops env OPS_PROJECT_REMOTE_HOST ${INPUT:-$OPS_PROJECT_REMOTE_HOST}

    read -p "Remote user [$OPS_PROJECT_REMOTE_USER]: " INPUT
    ops env OPS_PROJECT_REMOTE_USER ${INPUT:-$OPS_PROJECT_REMOTE_USER}

    read -p "Remote path [$OPS_PROJECT_REMOTE_PATH]: " INPUT
    ops env OPS_PROJECT_REMOTE_PATH ${INPUT:-$OPS_PROJECT_REMOTE_PATH}

    read -p "Remote database name [$OPS_PROJECT_REMOTE_DB_NAME]: " INPUT
    ops env OPS_PROJECT_REMOTE_DB_NAME ${INPUT:-$OPS_PROJECT_REMOTE_DB_NAME}

    read -p "Sync dirs [$OPS_PROJECT_SYNC_DIRS]: " INPUT
    ops env OPS_PROJECT_SYNC_DIRS ${INPUT:-$OPS_PROJECT_SYNC_DIRS}
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

    if [[ -z "$SECURITY_KEY" ]]; then
        ops craft setup/security-key
    fi

    if [ -t 1 ]; then
        ops configure
    else
        echo You may wish to run $(tput smul)ops configure$(tput rmul) after this.
    fi

    if [[ -n "$DB_DATABASE" ]] && [[ -n "$OPS_PROJECT_REMOTE_DB_NAME" ]]; then
        read -p "Run ops sync now [Yn]: " INPUT
        if [[ $INPUT == 'Y' ]]; then
            ops sync
        fi

    elif [[ -e padstone.sql ]] && [[ -n "$DB_DATABASE" ]]; then
        ops mariadb import $DB_DATABASE < padstone.sql
    fi

    ops composer install
    ops npm install
    ops npm run dev

    echo -n "\nVisit your site at https://$(basename $0).imarc.io/"
}