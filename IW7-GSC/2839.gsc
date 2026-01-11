/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2839.gsc
***************************************/

createfx() {
  if(!level.createfx_enabled) {
    return;
  }
  _clearstartpointtransients();
  level.func_position_player = ::func_position_player;
  level.func_position_player_get = ::func_position_player_get;
  level.func_updatefx = scripts\common\createfx::restart_fx_looper;
  level.func_process_fx_rotater = scripts\common\createfx::process_fx_rotater;
  level.func_player_speed = ::func_player_speed;
  level.mp_createfx = 0;
  scripts\engine\utility::array_call(_getaiarray(), ::delete);
  scripts\engine\utility::array_call(_getspawnerarray(), ::delete);
  var_00 = _getaiarray();
  scripts\engine\utility::array_call(var_00, ::delete);
  scripts\common\createfx::createfx_common();
  thread scripts\common\createfx::createfxlogic();
  thread scripts\common\createfx::func_get_level_fx();
  level.player getnumberoffrozenticksfromwave(0);
  level.player getnumownedactiveagents(0);
  func_49C3();
  level waittill("eternity");
}

func_49C3() {
  var_00 = [];
  var_0["trigger_multiple_createart_transient"] = ::scripts\sp\trigger::func_1272E;

  foreach(var_04, var_02 in var_00) {
    var_03 = getEntArray(var_04, "classname");
    scripts\engine\utility::array_levelthread(var_03, var_02);
  }
}

func_position_player_get(var_00) {
  if(distancesquared(var_00, level.player.origin) > 4096) {
    setdvar("createfx_playerpos_x", level.player.origin[0]);
    setdvar("createfx_playerpos_y", level.player.origin[1]);
    setdvar("createfx_playerpos_z", level.player.origin[2]);
  }

  return level.player.origin;
}

func_position_player() {
  var_00 = [];
  var_0[0] = getdvarint("createfx_playerpos_x");
  var_0[1] = getdvarint("createfx_playerpos_y");
  var_0[2] = getdvarint("createfx_playerpos_z");
  level.player setorigin((var_0[0], var_0[1], var_0[2]));
  level.player setplayerangles((0, level.player.angles[1], 0));
}

func_player_speed() {
  _setsaveddvar("g_speed", level._createfx.player_speed);
}