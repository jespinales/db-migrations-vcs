# Database Version Control + Migration

This project provides an example of database version control using migrations to facilitate distribution and development.

## Installation

Follow these instructions to install and configure the project:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/jespinales/db-migrations-vcs.git
    ```

2. **Enter the project directory**:
    ```sh
    cd db-migrations-vcs
    ```

3. **Install dependencies**:
    ```sh
    composer install
    ```

4. **Create database**:
    ```sh
    mysql -u root -p
    # Enter your password or press enter if you do not have a password
    CREATE DATABASE sakila;
    ```

5. **Run the initial migration**:
    ```sh
    # This will set up the initial database schema and populate it with the initial data.
    php vendor/bin/phinx migrate
    ```

6. **Set the initial breakpoint**:
    ```sh
    # This will establish a rollback point so that the initial schema and data are not deleted.
    php vendor/bin/phinx breakpoint
    ```

## Keeping Your Local Database Updated

To ensure your local database is up-to-date when pulling a branch and switching between branches, follow these steps:

### Pre-Merge and Post-Merge Hooks

1. **Create or edit the `.git/hooks/pre-merge` file** and add the following lines:
    ```sh
    #!/bin/sh
    php vendor/bin/phinx rollback -e development
    ```

2. **Create or edit the `.git/hooks/post-merge` file** and add the following lines:
    ```sh
    #!/bin/sh
    php vendor/bin/phinx migrate -e development
    ```

### Handling Branch Switches

Since there is no `pre-checkout` hook in Git, you have two options:

**Option 1: Local Alias for Checkout**

1. Create a local alias for the checkout command:
    ```sh
    # Use "co" instead of "checkout" to switch branches.
    git config --local alias.co '!f() { ./checkout.sh "$@"; }; f'
    ```

**Option 2: Manual Commands**

1. Manually execute the rollback command before changing branches and the migrate command after changing branches:
    ```sh
    php vendor/bin/phinx rollback -e development
    git checkout <your-branch>
    php vendor/bin/phinx migrate -e development
    ```

### Updating Breakpoints

Breakpoints should be updated in the master branch once changes have been committed to production. This prevents significant changes from being reverted when switching between branches.

## Summary

- Clone the repository.
- Install dependencies.
- Create database.
- Run the initial migration and set the breakpoint.
- Use Git hooks and aliases to manage database state during merges and branch switches.
- Keep breakpoints updated in the master branch to prevent major reversions.

For more details, refer to the [Phinx documentation](https://book.cakephp.org/phinx/0/en/index.html).
