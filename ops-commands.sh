ops-craft() {
    ops shell php ./craft "$@"
}

ops-clear-cache() {
    ops-craft cache/flush-all
    ops craft clear-caches/template-caches
}

ops-install() {
    local email=$1
    local password=$2

    if [[ -z "$email" ]] || [[ -z "$password" ]]; then
        echo "Usage: ops install <email> <password>"
        exit 1
    fi

    # copy .env if necessary
    if [[ ! -e '.env' ]]; then
        cp .env.example .env
    fi

    local project_name="$(ops project name)"

    # set .env info
    ops env OPS_PROJECT_DB_NAME $project_name
    ops env OPS_PROJECT_DOCROOT web
    ops env DB_SERVER mariadb
    ops env DB_DATABASE $project_name

    # create database
    ops mariadb create $project_name

    # generate security key
    ops craft setup/security-key

    # import db dump
    ops mariadb import $project_name padstone.sql

    # remove db dump
    rm padstone.sql

    # build assets
    ops build
}

ops-build() {
    # install composer deps
    ops composer install --ignore-platform-reqs

    # install npm deps & run build
    ops npm install
    ops npm run prod
}

ops-dev() {
    ops npm run watch
}
