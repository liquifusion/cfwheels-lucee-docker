# cfwheels-lucee-docker

A [Docker][1] container for [CFWheels][2] applications running on [Lucee][3] and [NGINX][5].

## What you get

-   Ready (and intended) for use with [Docker Compose][6] in development
-   Lucee 5 scripting engine
-   Latest version of CFWheels, modified to use environment variables for configuration
-   NGINX web server with URL rewriting enabled for CFWheels
-   Lucee administrator blocked from web access completely. (Data source and SMTP settings are configured in
    `docker-compose.yml` in development and environment variables in production.)

## Development requirements

You must have the following installed on your development machine:

-  Docker
-  Docker Compose
-  RDBMS compatible with CFWheels

I also recommend Docker Machine for provisioning and managing your dev VMs.

## Installation

1.  [Download the source][7] and unzip anywhere on your system where you want to do development.
2.  Copy the contents of `docker-compose.yml.sample` into a new file called `docker-compose.yml`. (Note: do not delete
    the sample file after doing this because it stays in source control.)
3.  In `docker-compose.yml`:
    1.  Configure values for your data source (`DB_TYPE`, `DB_HOST`, etc.) according to
        [Lucee's format for Application.cfc][8]. It is recommended that you connect to a database on your host system
        via your LAN IP address.
    2.  Configure SMTP server settings (if any) according to attributes in `<cfmail>` tag. (You can safely remove
        settings not in use.)
    3.  Add any other environment-specific settings that you'd like for your development environment.
4.  From the project root, run `docker-compose build`. Docker will install and configure Ubuntu, NGINX, and Lucee.

## Running the application

From the project root, run this command:

```bash
$ docker-compose up
```

You then can access your project at `http://192.168.99.100/`.

(Note: if you can't connect to your application, try running `boot2docker ip` (or `docker-machine ls` if you followed
my advice and installed Docker Machine) to make sure you should in fact be hitting the standard `192.168.99.100` IP
address.)

To stop the application, press `Ctrl + C`.

## Developing your application

Continue coding your CFWheels application as normal in the `app/` subfolder.

Here are some bonus features that make life easier :party::

-  The `reloadPassword` is now configured in `docker-compose.yml` via `WHEELS_RELOAD_PW` instead of being hardcoded
   into an environment file in the `config/` folder. This means you can develop without a `reloadPassword` and
   configure it as an environment variable in production (where it actually matters).
-  The CFWheels `envionment` is also configured in `docker-compose.yml` via `WHEELS_ENV`. No more accidentally
   deploying a `config/environment.cfm` file to production with a setting of `development`!
-  There is no Lucee Administrator. Everything is configured "headless" via environment variables. This makes Lucee
   work in a Docker-friendly way where the app can be wiped and rebuilt completely on each deploy.


[1]: https://www.docker.com/
[2]: http://cfwheels.org/
[3]: http://lucee.org/
[5]: http://nginx.org/
[6]: https://docs.docker.com/compose/
[7]: https://github.com/liquifusion/cfwheels-lucee-docker/archive/master.zip
[8]: https://bitbucket.org/lucee/lucee/wiki/Cookbook_Datasource_Define_Datasource#markdown-header-create-a-datasource-in-the-applicationcfc
[9]: http://phusion.github.io/baseimage-docker/
