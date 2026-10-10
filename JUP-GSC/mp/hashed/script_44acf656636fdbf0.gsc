/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_44acf656636fdbf0.gsc
*************************************************/

#using script_44acf656636fdbf0;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\utility\connect_event_aggregator;
#namespace namespace_8089669b072e0a9f;

function main() {
  level.var_cdc15ee14362fbf = &namespace_bd2df931a45390c::init;
  scripts\mp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect);
  scripts\mp\gametypes\br::main();
}

function init() {
  scripts\mp\gametypes\br_gametype_resurgence::init();
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("getPlacementXPShareValues");
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getPlacementXPShareValues", &function_b0bb8889afbb0c83);
  scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af("getBRBonusXPperMillisecond");
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("getBRBonusXPperMillisecond", &function_843d05502816cbce);
  level thread function_616dc995608c8f34();
}

function onplayerconnect() {
  function_d00f5e738d7fb50d();
}

function function_616dc995608c8f34() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_fade_done");

  foreach(player in level.players) {
    player thread function_9c0a51de4eba66f3();
  }
}

function function_9c0a51de4eba66f3() {
  level endon("game_ended");
  self endon("disonnect");

  if(isbot(self)) {
    return;
  }

  br::function_258c4f40dee8189a(-1, -1, -1);

  if(!self istacmapactive()) {
    self notifyonplayercommand("tac_map_toggle", "togglemap");
    self waittill("tac_map_toggle");
  }

  waitframe();
  function_d00f5e738d7fb50d();
}

function function_d00f5e738d7fb50d() {
  endpos = getdvarvector(@ "hash_d125978f792e63d0", (0, 0, 0));
  br::function_258c4f40dee8189a(endpos[0], endpos[1], 0.5);
}

function function_b0bb8889afbb0c83() {
  var_e0f4d3685ff5c5bc = 50000;
  var_2121aa51c2c8132e = 80;
  var_409d356961c27474 = 15;
  return [var_e0f4d3685ff5c5bc, var_2121aa51c2c8132e, var_409d356961c27474];
}

function function_843d05502816cbce() {
  return 0.001;
}