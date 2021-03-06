# Class: cspace_environment::env
#
# This class manages environment variables used during the build and deployment
# of a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_environment::env {

	# ---------------------------------------------------------
	# Declare environment variables
	# ---------------------------------------------------------

	# Declare default values
	
	# FIXME: The values below should be reviewed and changed as needed.
	# In particular, password values below are set to easily-guessable
	# defaults and MUST be changed before use.
	#
	# We might instead consider generating per-execution values for
	# password defaults that are pseudo-random and not easily guessed.
	#
	# One simple way - compatible with at least some Linux distros and OS X,
	# and reliant only on 'uuidgen', 'tr', and 'cut', rather than on the
	# presence of any particular hash utility - is by extracting a slice from
	# a Type 4 UUID and incorporating into a generated password; e.g.:
	# "uuidgen | tr '[:upper:]' '[:lower:]' | cut -c 1-8"
	
	# FIXME: the values below are hard-coded global defaults. They
	# could more flexibly be read in from a per-node Environment,
	# from other external configuration, or from Heira.
	#
	# See, for instance:
	# http://puppetlabs.com/blog/the-problem-with-separating-data-from-puppet-code
	# and specifically:
	# http://docs.puppetlabs.com/guides/environment.html
	# http://docs.puppetlabs.com/hiera/1/
	#
	$default_ant_opts              = '-Xmx768m -XX:MaxPermSize=512m XY'
	$default_catalina_home         = '/usr/local/share/apache-tomcat-6.0.33'
	$default_catalina_opts         = '-Xmx1024m -XX:MaxPermSize=384m'
	$default_catalina_pid          = "${default_catalina_home}/bin/tomcat.pid"
	$default_cspace_jeeserver_home = $default_catalina_home
	$default_db_password_cspace    = 'cspace'
	$default_db_password_nuxeo     = 'nuxeo'
	$default_db_password           = 'postgres'
	$default_lc_all                = 'LC_ALL=en_US.UTF-8'
	$default_maven_opts            = '-Xmx768m -XX:MaxPermSize=512m -Dfile.encoding=UTF-8'

	# Pick up environment values from values already present in the environment,
	# if available, or use defaults if not.
	#
	# The environment variables below have been added as custom Facter facts
	# via the lib/facter/env.rb script in this module.

	if "${env_ant_opts}" != undef {
	    $ant_opts = "ANT_OPTS=${env_ant_opts}"
	}
	else {
	    $ant_opts = "ANT_OPTS=${default_ant_opts}"
	}

	if "${env_catalina_home}" != undef {
	    $catalina_home = "CATALINA_HOME=${env_catalina_home}"
	}
	else {
	    $catalina_home = "CATALINA_HOME=${default_catalina_home}"
	}

	if "${env_catalina_opts}" != undef {
	    $catalina_opts = "CATALINA_OPTS=${env_catalina_opts}"
	}
	else {
	    $catalina_opts = "CATALINA_OPTS=${default_catalina_opts}"
	}

	if "${env_catalina_pid}" != undef {
	    $catalina_pid = "CATALINA_PID=${env_catalina_pid}"
	}
	else {
	    $catalina_pid = "CATALINA_PID=${default_catalina_pid}"
	}

	if "${env_cspace_jeeserver_home}" != undef {
	    $cspace_jeeserver_home = "CSPACE_JEESERVER_HOME=${env_cspace_jeeserver_home}"
	}
	else {
	    $cspace_jeeserver_home = "CSPACE_JEESERVER_HOME=${default_cspace_jeeserver_home}"
	}

	if "${env_db_password_cspace}" != undef {
	    $db_password_cspace = "DB_PASSWORD_CSPACE=${env_db_password_cspace}"
	}
	else {
	    $db_password_cspace = "DB_PASSWORD_CSPACE=${default_db_password_cspace}"
	}

	if "${env_db_password_nuxeo}" != undef {
	    $db_password_nuxeo = "DB_PASSWORD_NUXEO=${env_db_password_nuxeo}"
	}
	else {
	    $db_password_nuxeo = "DB_PASSWORD_NUXEO=${default_db_password_nuxeo}"
	}

	if "${env_db_password}" != undef {
	    $db_password = "DB_PASSWORD=${env_db_password}"
	}
	else {
	    $db_password = "DB_PASSWORD=${default_db_password}"
	}

	if "${env_lc_all}" != undef {
	    $lc_all = "LC_ALL=${env_lc_all}"
	}
	else {
	    $lc_all = "LC_ALL=${default_lc_all}"
	}

	if "${env_maven_opts}" != undef {
	    $maven_opts = "MAVEN_OPTS=${env_maven_opts}"
	}
	else {
	    $maven_opts = "MAVEN_OPTS=${default_maven_opts}"
	}

	# The value of JAVA_HOME is not set here; it is assumed to be present
	# in Ant and Maven's environments.

	# Add each value to the $cspace_env_vars array
	$cspace_env_vars = [
	    $ant_opts,
		$catalina_home,
		$catalina_pid,
		$cspace_jeeserver_home,
		$db_password_cspace,
		$db_password_nuxeo,
		$db_password,
		$lc_all,
		$maven_opts
	]
	# notify { "${cspace_env_vars}": }
	
}
