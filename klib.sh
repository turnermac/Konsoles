#!/bin/bash
#
# Create my standard konsole windows.

source ~/bin/konsoles.sh

if [[ ! "$schema" ]]; then
    #schema=XTerm.schema
    #schema=BlackOnLightColor.schema
    #schema=Linux.schema
    #schema=GreenTint.schema
    #schema=syscolor.schema
    #schema=LightPicture.schema
    #schema=DarkPicture.schema
    schema=GreenOnBlack.schema
    #schema=BlackOnLightYellow.schema
    #schema=LightPaper.schema
    #schema=WhiteOnBlack.schema
    #schema=BlackOnWhite.schema
    #schema=Transparent.schema
    #schema=Transparent_MC.schema
    #schema=Transparent_lightbg.schema
    #schema=GreenTint_MC.schema
    #schema=vim.schema
    #schema=Transparent_darkbg.schema
fi

sessions=(
    sh1   $schema   'clear; bash'
    sh1   $schema   'clear; bash'
    su1   $schema   'clear; su'
    ssh1  $schema   'clear; ssh 127.0.0.1'
    )

konsole_id=$(create_konsole '--iconify')
wait_for_session 1

session_id=$(dcop $konsole_id konsole currentSession)
first_session_id=$session_id

start_sessions $konsole_id

dcop $konsole_id konsole activateSession $first_session_id
sleep 0.1
dcop $konsole_id 'konsole-mainwindow#1' restore
sleep 0.1
dcop $konsole_id 'konsole-mainwindow#1' setGeometry 100 100 600 400

# vim: tabstop=4: shiftwidth=4: noexpandtab:
# kate: tab-width 4; indent-width 4; replace-tabs false;