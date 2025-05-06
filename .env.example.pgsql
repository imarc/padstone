# Read about configuration, here:
# https://craftcms.com/docs/5.x/configure.html

# The application ID used to to uniquely store session and cache data, mutex locks, and more
CRAFT_APP_ID=CraftCMS--5e7572b1-05ae-4696-9e81-17947f37bf19

# The environment Craft is currently running in (dev, staging, production, etc.)
CRAFT_ENVIRONMENT=dev

# Database connection settings
CRAFT_DB_DRIVER=pgsql
CRAFT_DB_SERVER=postgres16
CRAFT_DB_PORT=5432
CRAFT_DB_DATABASE=padstone
CRAFT_DB_USER=postgres
CRAFT_DB_PASSWORD=
CRAFT_DB_SCHEMA=public
CRAFT_DB_TABLE_PREFIX=

# General settings
CRAFT_SECURITY_KEY=
CRAFT_DEV_MODE=true
CRAFT_ALLOW_ADMIN_CHANGES=true
CRAFT_DISALLOW_ROBOTS=true

# Volume permissions plugin
VOLUME_FILE_PUBLIC_PERMISSION=664
VOLUME_FILE_PRIVATE_PERMISSION=660
VOLUME_DIR_PUBLIC_PERMISSION=775
VOLUME_DIR_PRIVATE_PERMISSION=770



## Ops Settings

# Document root for ops (usually this is 'web')
OPS_PROJECT_DOCROOT="web"

# Database type (usually is 'mariadb')
OPS_PROJECT_DB_TYPE="pgsql"

# Database name (leave like this is use the value of $DB_DATABASE)
OPS_PROJECT_DB_NAME="$CRAFT_DB_DATABASE"

# Remote host for ops sync
OPS_PROJECT_REMOTE_HOST=

# Remote user for ops sync
OPS_PROJECT_REMOTE_USER=

# Remote path for ops sync
OPS_PROJECT_REMOTE_PATH=

# Remote database name for ops sync
OPS_PROJECT_REMOTE_DB_NAME=

# Remote directories for ops to sync
OPS_PROJECT_SYNC_DIRS=

OPS_PROJECT_BACKEND="apache-php83"

PRIMARY_SITE_URL=

USE_VITE_DEV_SERVER=true
