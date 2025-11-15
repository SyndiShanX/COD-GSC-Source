/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_nuketown_sign.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_nuketown_sign;

autoexec __init__system__() {
  system::register(#"wz_nuketown_sign", undefined, &__main__, undefined);
}

__main__() {
  callback::on_gameplay_started(&on_gameplay_started);
  util::waitforclient(0);
}

on_gameplay_started(localclientnum) {
  level thread nuked_population_sign_think(localclientnum);
}

nuked_population_sign_think(localclientnum) {
  tens_model = getent(localclientnum, "counter_tens", "targetname");
  ones_model = getent(localclientnum, "counter_ones", "targetname");
  zone = getent(localclientnum, "nuketown_island_zone", "targetname");
  time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");

  level thread function_102a701c(tens_model, ones_model);

    step = 36;
  ones = 0;
  tens = 0;
  tens_model rotateroll(step, 0.05);
  ones_model rotateroll(step, 0.05);

  for(;;) {
    wait 1;
    dosign = 0;
    players = getlocalplayers();

    foreach(localplayer in players) {
      if(!isDefined(localplayer)) {
        continue;
      }

      if(istouching(localplayer.origin, zone) && !localplayer isplayerswimming()) {
        dosign = 1;
        break;
      }
    }

    if(!dosign) {
      continue;
    }

    players = [];

    foreach(player in getplayers(localclientnum)) {
      if(istouching(player.origin, zone) && !player isplayerswimming()) {
        if(!isDefined(players)) {
          players = [];
        } else if(!isarray(players)) {
          players = array(players);
        }

        players[players.size] = player;
      }
    }

    for(dial = ones + tens * 10; players.size < dial; dial = ones + tens * 10) {
      ones--;

      if(ones < 0) {
        ones = 9;
        tens_model rotateroll(0 - step, time);
        tens--;
      }

      ones_model rotateroll(0 - step, time);
      ones_model waittill(#"rotatedone");
    }

    while(players.size > dial) {
      ones++;

      if(ones > 9) {
        ones = 0;
        tens_model rotateroll(step, time);
        tens++;
      }

      ones_model rotateroll(step, time);
      ones_model waittill(#"rotatedone");
      dial = ones + tens * 10;
    }
  }
}

set_dvar_float_if_unset(dvar, value) {
  if(getdvarstring(dvar) == "") {
    setdvar(dvar, value);
  }

  return getdvarfloat(dvar, 0);
}

function_102a701c(tens, ones) {
  while(!isDefined(tens) || !isDefined(ones)) {
    iprintlnbold("<dev string:x38>");
    wait 2;
  }
}

