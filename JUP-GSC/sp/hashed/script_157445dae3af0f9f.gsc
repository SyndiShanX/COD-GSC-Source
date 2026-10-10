/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_157445dae3af0f9f.gsc
*************************************************/

#using scripts\cp\utility;
#namespace namespace_5d586b5c0318efbd;

function init() {
  level.var_b20ff0025288ef0b = [];
  level thread runupdates();
}

function runupdates() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");

  while(true) {
    for(i = 0; i < level.players.size; i++) {
      for(j = 0; j < level.var_b20ff0025288ef0b.size; j++) {
        level.players[i][[level.var_b20ff0025288ef0b[j]]]();
      }
    }

    wait 1;
  }
}

function function_3ae366ec2732af83(callback) {
  level.var_b20ff0025288ef0b[level.var_b20ff0025288ef0b.size] = callback;
}