#!/bin/bash

version="1.0"

flush()
{
	for config in /etc/X11/xorg.conf.d/*.conf; do
		if [[[ $(readlink $config) == /usr/lib/xstart/config/* ]]]; then
			sudo unlink $config
		fi
	done
}

remove_config()
{
	for config in /etc/X11/xorg.conf.d/*.conf; do
		if [[[ $(readlink $config) == /usr/lib/xstart/config/$1/* ]]]; then
			sudo unlink $config
		fi
	done
}

add_config()
{
	sudo ln -s /usr/lib/xstart/config/$1/*.conf /etc/X11/xorg.conf.d/
}

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.8.0
# ARG_OPTIONAL_REPEATED([add], [a], [Add configuration files to Xorg config cache], [])
# ARG_OPTIONAL_REPEATED([remove], [r], [Remove configuration files from Xorg config cache], [])
# ARG_OPTIONAL_BOOLEAN([startx], [x], [Start an Xorg session], [off])
# ARG_OPTIONAL_BOOLEAN([flush], [f], [Flush Xorg config cache of files added by xconf], [off])
# ARG_VERBOSE([v])
# ARG_HELP([Configure and manage Xorg sessions. Version $version])
# ARGBASH_GO

# [ <-- needed because of Argbash
if [[ $_arg_flush == "on" ]]; then flush; fi
for config in $_arg_remove; do remove_config $config; done
for config in $_arg_add; do add_config $config; done
if [[ $_arg_startx == "on" ]]; then startx; fi

# ] <-- needed because of Argbash
