/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\shellshock_utility.gsc
***********************************************************/

#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace shellshock_utility;

function _shellshock(name, category, duration, animationresponse, interruptdelayms) {
  scripts\common\shellshock_utility::_shellshock(name, category, duration, animationresponse, interruptdelayms);
}

function _stopshellshock(fromdeath) {
  scripts\common\shellshock_utility::_stopshellshock();
}

function shellshock_artilleryearthquake(position, scale, duration, radius, ignoreclients) {
  playrumbleonposition("artillery_rumble", position);

  if(!isDefined(scale)) {
    scale = 0.7;
  }

  if(!isDefined(duration)) {
    duration = 0.5;
  }

  if(!isDefined(radius)) {
    radius = 800;
  }

  earthquake(scale, duration, position, radius);
  shellshock_screenshakeonposition(position, radius, ignoreclients);
}

function shellshock_screenshakeonposition(position, radius, ignoreclients) {
  shockplayers = utility::playersinsphere(position, radius);

  foreach(player in shockplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(ignoreclients)) {
      if(isarray(ignoreclients)) {
        if(array_contains(ignoreclients, player)) {
          continue;
        }
      } else if(player == ignoreclients) {
        continue;
      }
    }

    if(player isusingremote()) {
      continue;
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}