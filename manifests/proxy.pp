define haproxy::proxy ($type='',
                       $port=80,
                       $ordering=999
                     ) {
    if ($type == '') {
        fail('You probably want to set a proxy type: frontend, backend, listen') }

    $userlist = $namevar
    file { "{/$haproxy::confdir}/${ordering}-${namevar}":
        ensure  => present,
        content => template("haproxy/proxy.erb"),
        require => File['haproxy-confdir'];
    }
}
