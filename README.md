Description
===========

Installs and manages the [unbound DNS server](http://unbound.net).

This cookbook is based on the one by [Joshua Timberman](http://community.opscode.com/cookbooks/unbound)
but tries to be more lean. The intended usage is to setup a local DNS resolver.
If you actually need to "fake" DNS queries, you should setup a full DNS server.

Requirements
============

This cookbook is only tested on Debian 6.0 (Squeeze) and 7.0 (Wheezy) as well
as Ubuntu 12.04 (Precise Pangolin).
