/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\266.gsc
**************************************/

createfx() {
  level.func_position_player = ::func_position_player;
  level.func_position_player_get = ::func_position_player_get;
  level.func_loopfxthread = common_scripts\_fx::loopfxthread;
  level.func_oneshotfxthread = common_scripts\_fx::oneshotfxthread;
  level.func_create_loopsound = common_scripts\_fx::create_loopsound;
  level.func_updatefx = common_scripts\_createfx::restart_fx_looper;
  level.func_process_fx_rotater = common_scripts\_createfx::process_fx_rotater;
  level.mp_createfx = 0;
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }
  thread common_scripts\_createfx::createfxlogic();
  thread common_scripts\_createfx::func_get_level_fx();
  common_scripts\_createfx::createfx_common();
  level waittill("eternity");
}

func_position_player_get(var_0) {
  if(distance(var_0, level.player.origin) > 64) {
    setDvar("createfx_playerpos_x", level.player.origin[0]);
    setDvar("createfx_playerpos_y", level.player.origin[1]);
    setDvar("createfx_playerpos_z", level.player.origin[2]);
  }

  return level.player.origin;
}

func_position_player() {
  var_0 = [];
  var_0[0] = getdvarint("createfx_playerpos_x");
  var_0[1] = getdvarint("createfx_playerpos_y");
  var_0[2] = getdvarint("createfx_playerpos_z");
  level.player setorigin((var_0[0], var_0[1], var_0[2]));
}