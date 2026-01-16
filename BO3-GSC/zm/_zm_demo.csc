/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_demo.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace _zm_demo;

function autoexec __init__sytem__() {
  system::register("zm_demo", & __init__, undefined, undefined);
}

function __init__() {
  if(isdemoplaying()) {
    if(!isdefined(level.demolocalclients)) {
      level.demolocalclients = [];
    }
    callback::on_localclient_connect( & player_on_connect);
  }
}

function player_on_connect(localclientnum) {
  level thread watch_predicted_player_changes(localclientnum);
}

function watch_predicted_player_changes(localclientnum) {
  level.demolocalclients[localclientnum] = spawnstruct();
  level.demolocalclients[localclientnum].nonpredicted_local_player = getnonpredictedlocalplayer(localclientnum);
  level.demolocalclients[localclientnum].predicted_local_player = getlocalplayer(localclientnum);
  while (true) {
    nonpredicted_local_player = getnonpredictedlocalplayer(localclientnum);
    predicted_local_player = getlocalplayer(localclientnum);
    if(nonpredicted_local_player !== level.demolocalclients[localclientnum].nonpredicted_local_player) {
      level notify("demo_nplplayer_change", localclientnum, level.demolocalclients[localclientnum].nonpredicted_local_player, nonpredicted_local_player);
      level notify("demo_nplplayer_change" + localclientnum, level.demolocalclients[localclientnum].nonpredicted_local_player, nonpredicted_local_player);
      level.demolocalclients[localclientnum].nonpredicted_local_player = nonpredicted_local_player;
    }
    if(predicted_local_player !== level.demolocalclients[localclientnum].predicted_local_player) {
      level notify("demo_plplayer_change", localclientnum, level.demolocalclients[localclientnum].predicted_local_player, predicted_local_player);
      level notify("demo_plplayer_change" + localclientnum, level.demolocalclients[localclientnum].predicted_local_player, predicted_local_player);
      level.demolocalclients[localclientnum].predicted_local_player = predicted_local_player;
    }
    wait(0.016);
  }
}