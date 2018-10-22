# Methods to run this image ( openstack-mariadb:10.2 )

## Introduce for this image:
> This image is for openstack services , building from the official image mariadb:10.2 , appending scripts to creating db / clusters

## normal run
- docker run -d -e MYSQL_ROOT_PASSWORD=123456 --name mariadb --hostname=mariadb -p 3306:3306 -v `pwd`/data:/var/lib/mysql openstack-mariadb:10.2

## using customize mariadb conf :
- $ docker run --name some-mariadb -v /my/custom:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:tag

## Env Introduce 
> Environment Variables
- When you start the mariadb image, you can adjust the configuration of the MariaDB instance by passing one or more environment variables on the docker run command line. Do note that none of the variables below will have any effect if you start the container with a data directory that already contains a database: any pre-existing database will always be left untouched on container startup.

## MYSQL_ROOT_PASSWORD
This variable is mandatory and specifies the password that will be set for the MariaDB root superuser account. In the above example, it was set to my-secret-pw.

## MYSQL_DATABASE
This variable is optional and allows you to specify the name of a database to be created on image startup. If a user/password was supplied (see below) then that user will be granted superuser access (corresponding to GRANT ALL) to this database.

## MYSQL_USER, MYSQL_PASSWORD
These variables are optional, used in conjunction to create a new user and to set that user's password. This user will be granted superuser permissions (see above) for the database specified by the MYSQL_DATABASE variable. Both variables are required for a user to be created.

Do note that there is no need to use this mechanism to create the root superuser, that user gets created by default with the password specified by the MYSQL_ROOT_PASSWORD variable.

## MYSQL_ALLOW_EMPTY_PASSWORD
This is an optional variable. Set to yes to allow the container to be started with a blank password for the root user. NOTE: Setting this variable to yes is not recommended unless you really know what you are doing, since this will leave your MariaDB instance completely unprotected, allowing anyone to gain complete superuser access.

## MYSQL_RANDOM_ROOT_PASSWORD
This is an optional variable. Set to yes to generate a random initial password for the root user (using pwgen). The generated root password will be printed to stdout (GENERATED ROOT PASSWORD: .....).
