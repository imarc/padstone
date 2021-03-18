ops-craft() {
    cmd-doc "Run craft commands within ops more easily."
    ops shell ./craft "$@"
}

ops-padstone-install() {
    cmd-doc "Run this only once per project to complete the Padstone install."

    ops composer install
    ops npm install
    ops npm run dev

    if [[ ! -e .env ]]; then
        cp .env.example .env
    fi

    ops craft setup/security-key


    # "npx imarc/boilerplate-components",
    # "echo \"\n@import \\\"~bootstrap/scss/bootstrap\\\";\" >> resources/styles/main.scss",
    # "echo \"\nimport \\\"bootstrap\\\";\" >> resources/js/main.js"
}

ops-install() {
    cmd-doc "Run this after cloning the project to setup the project for local development on Ops."
}
