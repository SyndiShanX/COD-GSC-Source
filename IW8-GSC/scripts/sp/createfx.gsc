/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\createfx.gsc
***********************************************/

function createfx() {
  if(!level.createfx_enabled) {
    return;
  }

  clearstartpointtransients();
  level.func_position_player = &func_position_player;
  level.func_position_player_get = &func_position_player_get;
  level.func_updatefx = &scripts\common\createfx::restart_fx_looper;
  level.func_process_fx_rotater = &scripts\common\createfx::process_fx_rotater;
  level.func_player_speed = &func_player_speed;
  level.mp_createfx = 0;
  scripts\engine\utility::array_call(getaiarray(), &delete);
  scripts\engine\utility::array_call(getspawnerarray(), &delete);
  var0 = getaiarray();
  scripts\engine\utility::array_call(var0, &delete);
  scripts\common\createfx::createfx_common();
  thread scripts\common\createfx::createfxlogic();
  thread scripts\common\createfx::func_get_level_fx();
  level.player allowcrouch(0);
  level.player allowprone(0);
  createfx_only_triggers();
  level waittill("eternity");
}

function createfx_only_triggers() {
  var0 = [];
  GscBinSkip0(0x2e, "trigger_multiple_createart_transient", &scripts\sp\trigger::trigger_createart_transient);
}

function func_position_player_get(var0) {
  if(distancesquared(var0, level.player.origin) > 4096) {
    setDvar("createfx_playerpos_x", level.player.origin[0]);
    setDvar("createfx_playerpos_y", level.player.origin[1]);
    setDvar("createfx_playerpos_z", level.player.origin[2]);
  }

  return level.player.origin;
}

function func_position_player() {
  var0 = [];
  GscBinSkip0(0x2e, 0, getdvarint("createfx_playerpos_x"));
}

function func_player_speed() {
  setsaveddvar("NSRPQNLSNK", level._createfx.player_speed);
}