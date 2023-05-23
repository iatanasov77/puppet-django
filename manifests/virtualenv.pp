define vs_django::virtualenv(
	String $venv,
	Integer $pythonVersion,
	Array $packages
) {
	file { '/opt/python_virtual_environements':
        ensure	=> directory,
        mode    => '0777',
        owner  	=> 'apache',
		group  	=> 'root',
    }
    
	$env_path = "/opt/python_virtual_environements/${venv}"
	$runActivate   = "${env_path}/venv/bin/activate"
	file { "${env_path}":
        ensure	=> directory,
        mode    => '0777',
        owner  	=> 'apache',
		group  	=> 'root',
    } ->
	Exec { "Create Python virtualenv: ${venv}":
		command	=> "virtualenv --python=/usr/bin/python${pythonVersion} ${env_path}/venv"
	} ->	
	Exec { "Install Django for project ${hostName}":
		command	=> "${env_path}/venv/bin/pip${pythonVersion} install ${join($packages, ' ')}"
	} ->
	file { "${env_path}/venv/bin/activate.sh":
        ensure  => file,
        path    => "${env_path}/venv/bin/activate.sh",
        content => template( 'vs_django/activate.sh.erb' ),
        mode    => '0777',
        owner   => 'apache',
        group   => 'root',
    } ->
	Exec { "Activate Venv for ${venv}":
		command	=> "${env_path}/venv/bin/activate.sh"
	}
}
