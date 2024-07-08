# Data Base Version Control + Migration

Example of a database version control based on migrations to facilitate distribution and development. 

## Installation

Instructions for installing and configuring the project.

```sh
# Clone the repository
git clone https://github.com/jespinales/db-migrations-vcs.git

# Enter the project directory
cd db-migrations-vcs

# Install dependencies
composer install

# Run the first migration
# This will run the initial database schema and fill the database with the first data.
php .\vendor\bin\phinx migrate

# Establish the first breakpoint
# This will allow you to rollback only to this point so that the schema and initial data are not deleted.
php .\vendor\bin\phinx breakpoint
```