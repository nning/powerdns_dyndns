powerdns_dyndns
===============

Sinatra app that implements DynDNS (dyn.com DNS update API) for SQL backed PowerDNS setups. Uses [powerdns_db_cli](https://github.com/nning/powerdns_db_cli) for the models.

Installation
------------

From source:

    rake install

Or from rubygems.org:

	gem install powerdns_dyndns

Usage
-----

Configure in `settings.yml` and start with a Rack compatible server.
