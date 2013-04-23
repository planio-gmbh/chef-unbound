default["unbound"]["pidfile"] = "/var/run/unbound.pid"
default["unbound"]["bindir"] = "/usr/sbin"


# If true, we will setup unbound in a chroot in ["unbound"]["server"]["directory"]
default["unbound"]["setup_chroot"] = true

# Init style, can be either "init" or "runit"
default["unbound"]["init_style"] = "init"

# specify the interfaces to answer queries from by ip-address.
# The default is to listen to localhost (127.0.0.1 and ::1).
# specify 0.0.0.0 and ::0 to bind to all available interfaces.
# You can specify interfaces as ipaddress[@port].
# The listen interfaces are not changed on reload, only on restart.
default["unbound"]["server"]["interface"] = ["127.0.0.1", "::1"]
# port to answer queries from
default["unbound"]["server"]["port"] = 53
# Enable IPv4
default["unbound"]["server"]["do-ip4"] = true
# Enable IPv6
default["unbound"]["server"]["do-ip6"] = true
# Enable UDP
default["unbound"]["server"]["do-udp"] = true
# Enable TCP
default["unbound"]["server"]["do-tcp"] = true

# control which clients are allowed to make (recursive) queries
# to this server. Specify classless netblocks with /size and action.
# By default everything is refused, except for localhost.
# Choose deny (drop message), refuse (polite error reply),
# allow (recursive ok), allow_snoop (recursive and nonrecursive ok)
default["unbound"]["server"]["access-control"] = [
  %w[0.0.0.0/0 refuse],
  %w[127.0.0.0/8 allow],
  %w[::0/0 refuse],
  %w[::1 allow],
  %w[::ffff:127.0.0.1 allow]
]
# enable this feature to copy the source address of queries to reply.
# Socket options are not supported on all platforms. experimental.
default["unbound"]["server"]["interface-automatic"] = false
# specify the interfaces to send outgoing queries to authoritative
# server from by ip-address. If none, the default (all) interface is used
default["unbound"]["server"]["outgoing-interface"] = []
# number of ports to allocate per thread, determines the size of the
# port range that can be open simultaneously.  About double the
# num-queries-per-thread, or, use as many as the OS will allow you.
default["unbound"]["server"]["outgoing-range"] = nil
# permit unbound to use this port number or port range for
# making outgoing queries, using an outgoing interface.
default["unbound"]["server"]["outgoing-port-permit"] = nil
# deny unbound the use this of port number or port range for
# making outgoing queries, using an outgoing interface.
# Use this to make sure unbound does not grab a UDP port that some
# other server on this computer needs. The default is to avoid
# IANA-assigned port numbers.
default["unbound"]["server"]["outgoing-port-avoid"] = nil


# if given, user privileges are dropped (after binding port),
# and the given username is assumed. Default is user "unbound".
# If you give "" no privileges are dropped.
default["unbound"]["server"]["username"] = "unbound"

# the working directory. The relative files in this config are
# relative to this directory. If you give "" the working directory
# is not changed.
default["unbound"]["server"]["directory"] = "/etc/unbound"

# the pid file. Can be an absolute path outside of chroot/work dir.
default["unbound"]["server"]["pidfile"] = "/var/run/unbound.pid"

# the log file, "" means log to stderr.
# Use of this option sets use-syslog to "no".
default["unbound"]["server"]["logfile"] = nil
# Log to syslog(3) if yes. The log facility LOG_DAEMON is used to
# log to, with identity "unbound". If yes, it overrides the logfile.
default["unbound"]["server"]["use-syslog"] = true
# print UTC timestamp in ascii to logfile, default is epoch in seconds.
default["unbound"]["server"]["log-time-ascii"] = false
# verbosity number, 0 is least verbose. 1 is default.
default["unbound"]["server"]["verbosity"] = 1
# print statistics to the log (for every thread) every N seconds.
# Set to "" or 0 to disable. Default is disabled.
default["unbound"]["server"]["statistics-interval"] = 0
# enable cumulative statistics, without clearing them after printing.
default["unbound"]["server"]["statistics-cumulative"] = false
# enable extended statistics (query types, answer codes, status)
# printed from unbound-control. default off, because of speed.
default["unbound"]["server"]["extended-statistics"] = false

# module configuration of the server. A string with identifiers
# separated by spaces. "iterator" or "validator iterator"
default["unbound"]["server"]["module-config"] = "validator iterator"

# file to read root hints from.
# get one from ftp://FTP.INTERNIC.NET/domain/named.cache
default["unbound"]["server"]["root-hints"] = nil

# File with DLV trusted keys. Same format as trust-anchor-file.
# There can be only one DLV configured, it is trusted from root down.
# Download http://ftp.isc.org/www/dlv/dlv.isc.org.key
default["unbound"]["server"]["dlv-anchor-file"] = nil
# File with trusted keys for validation. Specify more than one file
# with several entries, one file per entry.
# Zone file format, with DS and DNSKEY entries.
default["unbound"]["server"]["trust-anchor-file"] = nil
# File with trusted keys, kept uptodate using RFC5011 probes,
# initial file like trust-anchor-file, then it stores metadata.
# Use several entries, one per domain name, to track multiple zones.
default["unbound"]["server"]["auto-trust-anchor-file"] = []
# Trusted key for validation. DS or DNSKEY. specify the RR on a
# single line, surrounded by "". TTL is ignored. class is IN default.
# Examples:
# nlnetlabs.nl. DNSKEY 257 3 5 AQPzzTWMz8qSWIQlfRnPckx2BiVmkVN6LPupO3mbz7FhLSnm26n6iG9N Lby97Ji453aWZY3M5/xJBSOS2vWtco2t8C0+xeO1bc/d6ZTy32DHchpW 6rDH1vp86Ll+ha0tmwyy9QP7y2bVw5zSbFCrefk8qCUBgfHm9bHzMG1U BYtEIQ==
# jelte.nlnetlabs.nl. DS 42860 5 1 14D739EB566D2B1A5E216A0BA4D17FA9B038BE4A
default["unbound"]["server"]["trust-anchor"] = []
# File with trusted keys for validation. Specify more than one file
# with several entries, one file per entry. Like trust-anchor-file
# but has a different file format. Format is BIND-9 style format,
# the trusted-keys { name flag proto algo "key"; }; clauses are read.
default["unbound"]["server"]["trusted-keys-file"] = []
# Ignore chain of trust. Domain is treated as insecure.
default["unbound"]["server"]["domain-insecure"] = []

# enable to not answer id.server and hostname.bind queries.
default["unbound"]["server"]["hide-identity"] = false
# enable to not answer version.server and version.bind queries.
default["unbound"]["server"]["hide-version"] = false
# the identity to report. Leave "" or default to return hostname.
default["unbound"]["server"]["identity"] = nil
# the version to report. Leave "" or default to return package version.
default["unbound"]["server"]["version"] = nil

# number of threads to create. 1 disables threading.
default["unbound"]["server"]["num-threads"] = 1
# number of outgoing simultaneous tcp buffers to hold per thread.
default["unbound"]["server"]["outgoing-num-tcp"] = 10
# number of incoming simultaneous tcp buffers to hold per thread.
default["unbound"]["server"]["incoming-num-tcp"] = 10
# buffer size for UDP port 53 incoming (SO_RCVBUF socket option).
# 0 is system default.  Use 4m to catch query spikes for busy servers.
default["unbound"]["server"]["so-rcvbuf"] = 0
# EDNS reassembly buffer to advertise to UDP peers (the actual buffer
# is set with msg-buffer-size). 1480 can solve fragmentation (timeouts).
default["unbound"]["server"]["edns-buffer-size"] = 4096
# buffer size for handling DNS data. No messages larger than this
# size can be sent or received, by UDP or TCP. In bytes.
default["unbound"]["server"]["msg-buffer-size"] = 65552
# the amount of memory to use for the message cache.
# plain value in bytes or you can append k, m or G. default is "4Mb".
default["unbound"]["server"]["msg-cache-size"] = "4m"
# the number of slabs to use for the message cache.
# the number of slabs must be a power of 2.
# more slabs reduce lock contention, but fragment memory usage.
default["unbound"]["server"]["msg-cache-slabs"] = 4
# the number of queries that a thread gets to service.
default["unbound"]["server"]["num-queries-per-thread"] = 1024
# if very busy, 50% queries run to completion, 50% get the timeout specified
# here in msec
default["unbound"]["server"]["jostle-timeout"] = nil
# the amount of memory to use for the RRset cache.
# plain value in bytes or you can append k, m or G. default is "4Mb".
default["unbound"]["server"]["rrset-cache-size"] = "4m"
# the number of slabs to use for the RRset cache.
# the number of slabs must be a power of 2.
# more slabs reduce lock contention, but fragment memory usage.
default["unbound"]["server"]["rrset-cache-slabs"] = 4
# the time to live (TTL) value lower bound, in seconds. Default 0.
# If more than an hour could easily give trouble due to stale data.
default["unbound"]["server"]["cache-min-ttl"] = 0
# the time to live (TTL) value cap for RRsets and messages in the
# cache. Items are not cached for longer. In seconds.
default["unbound"]["server"]["cache-max-ttl"] = 86400
# the time to live (TTL) value for cached roundtrip times and
# EDNS version information for hosts. In seconds.
default["unbound"]["server"]["infra-host-ttl"] = 900
# the time to live (TTL) value for cached lame delegations. In sec.
default["unbound"]["server"]["infra-lame-ttl"] = 900
# the number of slabs to use for the Infrastructure cache.
# the number of slabs must be a power of 2.
# more slabs reduce lock contention, but fragment memory usage.
default["unbound"]["server"]["infra-cache-slabs"] = 4
# the maximum number of hosts that are cached (roundtrip times, EDNS).
default["unbound"]["server"]["infra-cache-numhosts"] = 10000
# the maximum size of the lame zones cached per host. in bytes.
default["unbound"]["server"]["infra-cache-lame-size"] = "10k"

# the target fetch policy.
# series of integers describing the policy per dependency depth.
# The number of values in the list determines the maximum dependency
# depth the recursor will pursue before giving up. Each integer means:
#   -1 : fetch all targets opportunistically,
#   0: fetch on demand,
# positive value: fetch that many targets opportunistically.
default["unbound"]["server"]["target-fetch-policy"] = "3 2 1 0 0"

# Harden against very small EDNS buffer sizes.
default["unbound"]["server"]["harden-short-bufsize"] = false
# Harden against unseemly large queries.
default["unbound"]["server"]["harden-large-queries"] = false
# Harden against out of zone rrsets, to avoid spoofing attempts.
default["unbound"]["server"]["harden-glue"] = true
# Harden against receiving dnssec-stripped data. If you turn it
# off, failing to validate dnskey data for a trustanchor will
# trigger insecure mode for that zone (like without a trustanchor).
# Default on, which insists on dnssec data for trust-anchored zones.
default["unbound"]["server"]["harden-dnssec-stripped"] = true
# Harden the referral path by performing additional queries for
# infrastructure data. Validates the replies (if possible).
# Default off, because the lookups burden the server.  Experimental
# implementation of draft-wijngaards-dnsext-resolver-side-mitigation.
default["unbound"]["server"]["harden-referral-path"] = false
# Use 0x20-encoded random bits in the query to foil spoof attempts.
# This feature is an experimental implementation of draft dns-0x20.
default["unbound"]["server"]["use-caps-for-id"] = false

# Enforce privacy of these addresses. Strips them away from answers.
# It may cause DNSSEC validation to additionally mark it as bogus.
# Protects against 'DNS Rebinding' (uses browser as network proxy).
# Only 'private-domain' and 'local-data' names are allowed to have
# these private addresses.
# Specify classless netblocks with /size.
default["unbound"]["server"]["private-address"] = []
# Allow the domain (and its subdomains) to contain private addresses.
# local-data statements are allowed to contain private addresses too.
default["unbound"]["server"]["private-domain"] = []
# If nonzero, unwanted replies are not only reported in statistics,
# but also a running total is kept per thread. If it reaches the
# threshold, a warning is printed and a defensive action is taken,
# the cache is cleared to flush potential poison out of it.
# A suggested value is 10000000, the default is 0 (turned off).
default["unbound"]["server"]["unwanted-reply-threshold"] = 0

# Do not query the following addresses. No DNS queries are sent there.
# List one address per entry. List classless netblocks with /size,
default["unbound"]["server"]["do-not-query-address"] = []
# if true, the following default do-not-query-address entries are present:
#  127.0.0.1/8
#  ::1
# if false, localhost can be queried (for testing and debugging).
default["unbound"]["server"]["do-not-query-localhost"] = true

# if true, perform prefetching of almost expired message cache entries.
default["unbound"]["server"]["prefetch"] = false
# if true, perform key lookups adjacent to normal lookups.
default["unbound"]["server"]["prefetch-key"] = false


