/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_188008b85f8b14d4.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_973ecfc2f54e9ac3;

function function_ed4c2d913d203bf(players, notifytype, timeoutoverride) {
  if(!isarray(players)) {
    players = [players];
  }

  foreach(player in players) {
    function_2a728f0062b4e436(player, notifytype, timeoutoverride);
  }
}

function function_2a728f0062b4e436(player, notifytype, timeoutoverride) {
  switch (notifytype) {
    case #"hash_ec031320eb0c7285":
      notifytype = 1;
      break;
    case #"hash_eb8c170bf600e214":
      notifytype = 2;
      break;
    case #"hash_772448618dee9a9":
      notifytype = 3;
      break;
    case #"hash_33270e8005317cc4":
      notifytype = 4;
      break;
    case #"hash_10eb6d629315a914":
      notifytype = 5;
      break;
    default:
      notifytype = 0;
      break;
  }

  if(notifytype > 0) {
    player setclientomnvar("ui_upper_notification_type", notifytype);
    dangernotifyresetforplayer(player, timeoutoverride);
  }
}

function dangernotifyresetforplayer(player, timeoutoverride) {
  playerid = player getxuid();

  if(!isDefined(timeoutoverride)) {
    timeoutoverride = 4;
  }

  level notify("upper_notification_start_" + playerid);
  level thread watchdangerresetaction(player, playerid, "death_or_disconnect");
  level thread watchdangerresetaction(player, playerid, undefined, timeoutoverride);
}

function watchdangerresetaction(player, playerid, action, timeout) {
  level endon("upper_notification_start_" + playerid);
  level endon("upper_notification_finished_" + playerid);
  level endon("game_ended");

  if(isDefined(action)) {
    player waittill(action);
  } else if(isDefined(timeout)) {
    wait timeout;
  }

  if(isDefined(player)) {
    player setclientomnvar("ui_upper_notification_type", 0);
  }

  level notify("upper_notification_finished_" + playerid);
}