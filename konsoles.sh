#!/bin/bash
#
# Functions from creating konsoles.


#####################################################################
# Create new console.
function create_konsole()
{
    local basename=$(date +"%D%M%N")
    local name=$basename"_konsoleX1_"
    local kstart_options=$1
    local konsole_options=$2
    kstart $kstart_options --window $name konsole $konsole_options --script -T $name >/dev/null 2>&1
    local konsole_id=konsole-$(ps aux | grep konsole | grep -v grep | grep $name | awk '{print $2}')
    echo $konsole_id
}

#####################################################################
# Wait to make sure the session count equals $1.
function wait_for_session()
{
    local konsole_id=$1
    local count=$2
    local session_count=$(dcop $konsole_id konsole sessionCount 2>/dev/null)
    while [[ $session_count -ne $count ]]
    do
        sleep 0.1
        session_count=$(dcop $konsole_id konsole sessionCount)
    done
}

#####################################################################
# Start sessions in konsole.
function start_sessions()
{
    local konsole_id=$1
    local nsessions=1
    local session_count=${#sessions[*]}
    local i=0

    while [[ $i -lt $session_count ]]
    do
        local name=${sessions[$i]}
        let i++
        local schema=${sessions[$i]}
        let i++
        local command=${sessions[$i]}
        let i++
        dcop $konsole_id $session_id renameSession "$name"
        sleep 0.1
        dcop $konsole_id $session_id setSchema "$schema"
        sleep 0.1
        dcop $konsole_id $session_id sendSession "$command"
        sleep 0.1

        if [[ $i -lt $session_count ]]; then
            let nsessions++
            local session_id=$(dcop $konsole_id konsole newSession)
            wait_for_session $konsole_id $nsessions
        fi
    done
}

# vim: tabstop=4: shiftwidth=4: noexpandtab:
# kate: tab-width 4; indent-width 4; replace-tabs false;