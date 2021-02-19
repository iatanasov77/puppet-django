define vs_django::virtualenv(
	String $venv,
	Integer $pythonVersion,
	Array $packages
) {
	/*
    	$env_path = '/opt/${venv}'
		$path_exists = find_file( $env_path )
		
		if ! $path_exists  {
			notify{"Path ${dir_path} exist":}
		}
	*/
	
	file { "/opt/${venv}":
        ensure	=> directory,
        mode    => '0777',
        owner  	=> 'apache',
		group  	=> 'root',
    } ->
	Exec { "Create Python virtualenv: ${venv}":
		command	=> "virtualenv --python=/usr/bin/python${pythonVersion} /opt/${venv}/venv"
	} ->
	
	Exec { "Install Django for project ${hostName}":
		command	=> "/opt/${venv}/venv/bin/pip${pythonVersion} install ${join($packages, ' ')}"
	}
}
