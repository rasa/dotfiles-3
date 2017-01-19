#autoload -Uz compinit
#autoload -Uz bashcompinit

#bashcompinit

_lxd_complete()
{
    _lxd_names()
    {
        local state=$1
        local keys=$2

        local cmd="lxc list --fast"
        [ -n "$state" ] && cmd="$cmd | grep -E '$state'"

        COMPREPLY=( $( compgen -W \
            "$( eval $cmd | grep -Ev '(+--|NAME)' | awk '{print $2}' ) $keys" "$cur" )
        )
    }

    _lxd_images()
    {
        COMPREPLY=( $( compgen -W \
            "$( lxc image list | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)' )" "$cur" )
        )
    }

    _lxd_remotes()
    {
        COMPREPLY=( $( compgen -W \
            "$( lxc remote list | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)' )" "$cur" )
        )
    }

    _lxd_profiles()
    {
        COMPREPLY=( $( compgen -W "$( lxc profile list | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)' )" "$cur" ) )
    }

    _lxd_networks()
    {
        COMPREPLY=( $( compgen -W \
            "$( lxc network list | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)' )" "$cur" )
        )
    }

    COMPREPLY=()
    # ignore special --foo args
    if [[ ${COMP_WORDS[COMP_CWORD]} == -* ]]; then
        return 0
    fi

    lxc_cmds="config copy delete exec file help image info init launch \
        list move network profile publish remote restart restore shell snapshot \
        start stop version"

    global_keys="core.https_address core.https_allowd_origin \
        core.https_allowed_methods core.https_allowed_headers  \
        core.https_allowed_credentials core.proxy_https \
        core.proxy_http core.proxy_ignore_host core.trust_password \
        storage.lvm_vg_name storage.lvm_thinpool_name storage.lvm_fstype \
        storage.lvm_volume_size storage.lvm_mount_options storage.zfs_pool_name \
        storage.zfs_remove_snapshots storage.zfs_use_refquota \
        images.compression_algorithm \
        images.remote_cache_expiry images.auto_update_interval \
        images.auto_update_cached"

    container_keys="boot.autostart boot.autostart.delay boot.autostart.priority \
        boot.host_shutdown_timeout limits.cpu limits.cpu.allowance limits.cpu.priority \
        limits.disk.priority limits.memory limits.memory.enforce limits.memory.swap \
        limits.memory.swap.priority limits.network.priority limits.processes \
        linux.kernel_modules raw.apparmor raw.lxc raw.seccomp security.nesting \
        security.privileged security.syscalls.blacklist_default \
        security.syscalls.blacklist_compat security.syscalls.blacklist \
        security.syscalls.whitelist volatile.apply_template volatile.base_image \
        volatile.last_state.idmap volatile.last_state.power user.network_mode \
        user.meta-data user.user-data user.vendor-data"

    networks_keys="bridge.driver bridge.external_interfaces bridge.mtu bridge.mode \
        fan.underlay_subnet fan.overlay_subnet fan.type ipv4.address ipv4.nat ipv4.dhcp \
        ipv4.dhcp.ranges ipv4.routing ipv6.address ipv6.nat ipv6.dhcp ipv6.dhcp.stateful \
        ipv6.dhcp.ranges ipv6.routing dns.domain dns.mode raw.dnsmasq"

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$lxc_cmds" -- ${COMP_WORDS[COMP_CWORD]}) )
        return 0
    fi

    local no_dashargs
    cur=${COMP_WORDS[COMP_CWORD]}

    no_dashargs=(${COMP_WORDS[@]// -*})
    pos=$((COMP_CWORD - (${#COMP_WORDS[@]} - ${#no_dashargs[@]})))
    if [ -z "$cur" ]; then
        pos=$(($pos + 1))
    fi

    case ${no_dashargs[1]} in
        "config")
            case $pos in
                2)
                    COMPREPLY=( $(compgen -W "device edit get set show trust" -- $cur) )
                    ;;
                3)
                    case ${no_dashargs[2]} in
                        "trust")
                            COMPREPLY=( $(compgen -W "list add remove" -- $cur) )
                            ;;
                        "device")
                            COMPREPLY=( $(compgen -W "add get set unset list show remove" -- $cur) )
                            ;;
                        "show"|"edit")
                            _lxd_names
                            ;;
                        "get"|"set"|"unset")
                            _lxd_names "" "$global_keys"
                            ;;
                    esac
                    ;;
                4)
                    case ${no_dashargs[2]} in
                        "trust")
                            _lxd_remotes
                            ;;
                        "device")
                            _lxd_names
                            ;;
                        "get"|"set"|"unset")
                            COMPREPLY=( $(compgen -W "$container_keys" -- $cur) )
                            ;;
                    esac
                    ;;
            esac
            ;;
        "copy")
            if [ $pos -lt 4 ]; then
                _lxd_names
            fi
            ;;
        "delete")
            _lxd_names
            ;;
        "exec")
            _lxd_names "RUNNING"
            ;;
        "file")
            COMPREPLY=( $(compgen -W "pull push edit" -- $cur) )
            ;;
        "help")
            COMPREPLY=( $(compgen -W "$lxc_cmds" -- $cur) )
            ;;
        "image")
            COMPREPLY=( $(compgen -W "import copy delete edit export info list show alias" -- $cur) )
            ;;
        "info")
            _lxd_names
            ;;
        "init")
            _lxd_images
            ;;
        "launch")
            _lxd_images
            ;;
        "move")
            _lxd_names
            ;;
        "network")
            case $pos in
                2)
                    COMPREPLY=( $(compgen -W "list show create get set unset delete edit attach attach-profile detach detach-profile" -- $cur) )
                    ;;
                3)
                    case ${no_dashargs[2]} in
                        "show"|"get"|"set"|"unset"|"delete"|"edit"|"attach"|"attach-profile"|"detach"|"detach-profile")
                            _lxd_networks
                            ;;
                    esac
                    ;;
                4)
                    case ${no_dashargs[2]} in
                        "get"|"set"|"unset")
                            COMPREPLY=( $(compgen -W "$networks_keys" -- $cur) )
                            ;;
                        "attach"|"detach"|"detach-profile")
                            _lxd_names
                            ;;
                        "attach-profile")
                            _lxd_profiles
                            ;;
                    esac
            esac
            ;;
        "profile")
            case $pos in
                2)
                    COMPREPLY=( $(compgen -W "list copy delete apply device edit get set show" -- $cur) )
                    ;;
                3)
                    case ${no_dashargs[2]} in
                        "device")
                            COMPREPLY=( $(compgen -W "add get set unset list show remove" -- $cur) )
                            ;;
                        *)
                            _lxd_profiles
                            ;;
                    esac
                    ;;
                4)
                    case ${no_dashargs[2]} in
                        "device")
                            _lxd_profiles
                            ;;
                        *)
                            COMPREPLY=( $(compgen -W "$container_keys" -- $cur) )
                            ;;
                    esac
                    ;;
            esac
            ;;
        "publish")
            _lxd_names
            ;;
        "remote")
            COMPREPLY=( $(compgen -W \
                "add remove list rename set-url set-default get-default" -- $cur) )
            ;;
        "restart")
            _lxd_names
            ;;
        "restore")
            _lxd_names
            ;;
        "shell")
            _lxd_names "RUNNING"
            ;;
        "snapshot")
            _lxd_names
            ;;
        "start")
            _lxd_names "STOPPED|FROZEN"
            ;;
        "stop")
            _lxd_names "RUNNING"
            ;;
        *)
            ;;
    esac

    return 0
}

complete -o default -F _lxd_complete lxc
#bashcompinit
