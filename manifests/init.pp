# Class: haproxy
#
# This module manages haproxy
#
# Parameters:
#   autoupdate: Whether to autoupdate packages (default: False)
#   global_options: Hash of global options for haproxy config
#       General options:
#           chroot: jailed dir to run process in (default: '')
#           daemon: Makes process fork into background (default: true)
#           debug: debug mode, everything to stdout (default: false)
#           description: text describing instance (default: unused)
#           gid: gid that process runs as (default: haproxy gid)
#           group: group name process runs as (default: haproxy group)
#           log: global syslog server address/facility (default: '')
#           log-send-hostname: hostname field in syslog header (default: auto)
#           log-tag: Set's tag field in syslog header (default: 'haproxy')
#           nbproc: # of procs in daemon mode, not recommended (default: 1)
#           node: unique name (default: unused)
#           pidfile: path to write PIDs of daemons (default: '')
#           quiet: nothing displayed at startup (default: false)
#           stats-socket: arguments to stats socket (default: unused)
#           stats-timeout: default timeout on stats socket (default: 10s)
#           stats-maxconns: concurrent conns to stats socket (default: 10)
#           uid: user id of haproxy process (default: haproxy user)
#           ulimit-n: max number of pre-process FDs (default: auto)
#           user: user name of haproxy process (default: haproxy)
#
#       Performance options:
#           maxconn: max number of concurrent conns (default: 2000)
#           maxpipes: max per-proc number of pipes (default: maxconn/4)
#           noepoll: diables use of epoll polling (default: false)
#           nokqueue: disables use of kqueue polling (default: false)
#           nopoll: disables use of poll polling (default: false)
#           nosepoll: disables use of speculative epoll system (default: false)
#           nosplice: disables use of kernel tcp splicing between
#               sockets (default: false)
#           spread-checks: random wait time between checks in % (default: 0)
#           tune.bufsize: buffer size, in bytes (default: 16384)
#           tune.chksize: check buffer size, in bytes (default: 16384)
#           tune.maxaccept: # of consecutive accepts a proc may
#               perform on wakeup (default: 100, 8, or -1)
#           tune.maxpollevents: max # of events handled in poll() (default: ?)
#           tune.maxrewrite: reserved buffer
#               space, in bytes (default: bufsize*0.5)
#           tune.rcvbuf.client
#           tune.rcvbuf.server: kernel socket receive buffer
#               size, in bytes (default: 0)
#           tune.sndbuf.client
#           tune.sndbuf.server: kernel socket send buffer
#               size, in bytes (default: 0)
#
#   default_options: Hash of default options for each proxy config
#       omg there are a ton of these
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class haproxy ($enable=true,
                $autoupdate=false,
                $global_options=[],
                $default_options=[]
    ) {

    if ($autoupdate == True) {
        $pkgstatus = 'latest'
    } else { $pkgstatus = 'installed' }

    package {
        'haproxy':
            ensure => $enable ? {
                true  => $pkgstatus,
                false => 'absent',
            }
    }

    service {
        'haproxy':
            ensure     => $enable ? {
                true   => 'running',
                false  => 'stopped' }
            enable     => $enable,
            hasrestart => true,
            hasstatus  => true,
            require    => Package['haproxy'],

}
