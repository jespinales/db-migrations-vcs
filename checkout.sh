#!/bin/sh
php ./vendor/bin/phinx rollback -e development
git checkout "$@"
php ./vendor/bin/phinx migrate -e development