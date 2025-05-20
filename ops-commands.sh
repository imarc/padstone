ops-craft() {
    cmd-doc "Run craft commands within ops more easily."
    ops shell php ./craft "$@"
}

ops-padstone-install() {
    cmd-doc "Run this only once per project to complete the Padstone install."

    if [[ ! -e .env ]]; then
        echo "Copying .env.example to .env..."
        cp .env.example .env
    fi

    PROJECT=$(ops project name)

    DEFAULT=${DB_SERVER:-postgres16}
    read -p "Database Server [$DEFAULT]: " INPUT
    ops env CRAFT_DB_SERVER ${INPUT:-$DEFAULT}

    DEFAULT=${PROJECT//[^a-zA-Z0-9]/_}
    DEFAULT=${DB_DATABASE:-$DEFAULT}
    read -p "Database Name [$DEFAULT]: " INPUT
    ops env CRAFT_DB_DATABASE ${INPUT:-$DEFAULT}

    echo "Calling $(tput smul)npx @imarc/pronto@latest$(tput rmul)..."
    npx @imarc/pronto@latest --non-interactive y ./resources y y y ./web

    ops install
}

ops-install() {
    cmd-doc "Run this after cloning the project to setup the project for local development on Ops."

    if [[ ! -e .env ]]; then
        echo "Copying .env.example to .env..."
        cp .env.example .env
    fi

    echo "Calling $(tput smul)composer install$(tput rmul)..."
    composer install --ignore-platform-reqs

    echo "Calling $(tput smul)npm install$(tput rmul)..."
    npm install

    # get updated settings; unusual syntax for bash 3.2.57
    source /dev/stdin <<<"$(ops env)"

    if [[ -e ./padstone.sql ]] && [[ -n "$CRAFT_DB_DATABASE" ]]; then
        echo "Importing padstone.sql into $DB_DATABASE..."
        ops psql import $CRAFT_DB_DATABASE padstone.sql
    fi

    if [[ -z "$CRAFT_SECURITY_KEY" ]] && [[ -n "$CRAFT_DB_DATABASE" ]]; then
        echo "Running $(tput smul)ops craft setup/keys$(tput rmul)..."
        ops craft setup/keys
    fi

    echo "Calling $(tput smul)npm run dev$(tput rmul)..."
    npm run build

    echo -en "\nVisit your site at https://$(ops project name).$OPS_DOMAIN/\n"
}
