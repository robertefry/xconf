#!/bin/bash

version="1.0"

flush()
{
	for config in /etc/X11/xorg.conf.d/*.conf; do
		if [[[ $(readlink $config) == /usr/lib/xconf/config/* ]]]; then
			if [[[ $_arg_verbose == "on" ]]]; then printf '\t--> %s\n' "flushing $config"; fi
			sudo unlink $config
		fi
	done
}

remove_config()
{
	for config in /etc/X11/xorg.conf.d/*.conf; do
		if [[[ $(readlink $config) == /usr/lib/xconf/config/$1/* ]]]; then
			if [[[ $_arg_verbose == "on" ]]]; then printf '\t--> %s\n' "unlinking $config"; fi
			sudo unlink $config
		fi
	done
}

add_config()
{
	for config in /usr/lib/xconf/config/$1/*.conf; do
		if [[[ $_arg_verbose == "on" ]]]; then printf '\t--> %s\n' "linking $config"; fi
		sudo ln -s $config /etc/X11/xorg.conf.d/
	done
}

list_linked_config()
{
	printf '%s\n' "Currently linked configuration files include:"
	cd /etc/X11/xorg.conf.d
	for config in *.conf; do
		printf '\t%s\n' $config
	done
}

print_config_options()
{
	printf '%s\n' "Configuration groups include:"
	cd /usr/lib/xconf/config
	for config in */; do
		printf '\t%s\n' $config
	done
}

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.8.0
# ARG_OPTIONAL_REPEATED([add], [a], [Add configuration files to Xorg config cache], [])
# ARG_OPTIONAL_REPEATED([remove], [r], [Remove configuration files from Xorg config cache], [])
# ARG_OPTIONAL_BOOLEAN([startx], [x], [Start an Xorg session], [off])
# ARG_OPTIONAL_BOOLEAN([flush], [f], [Flush Xorg config cache of files added by xconf], [off])
# ARG_OPTIONAL_BOOLEAN([verbose], [v], [Set verbose output], [off])
# ARG_OPTIONAL_ACTION([list], [l], [List currently linked configuration files], [list_linked_config])
# ARG_OPTIONAL_ACTION([options], [o], [Prints configuration options], [print_config_options])
# ARG_HELP([Configure and manage Xorg sessions. Version $version])
# ARGBASH_GO

# [ <-- needed because of Argbash
if [[ $_arg_flush == "on" ]]; then flush; fi
for config in $_arg_remove; do remove_config $config; done
for config in $_arg_add; do add_config $config; done
if [[ $_arg_startx == "on" ]]; then startx; fi

# ] <-- needed because of Argbash
