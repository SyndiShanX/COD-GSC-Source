/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_createfx.gsc
*****************************************/

createfx() {
  level.func_position_player = common_scripts\utility::_id_A60A;
  level.func_position_player_get = ::func_position_player_get;
  level._id_3F09 = common_scripts\_fx::_id_5EF5;
  level._id_3F0A = common_scripts\_fx::_id_6B11;
  level._id_3F04 = common_scripts\_fx::create_loopsound;
  level.func_updatefx = common_scripts\_createfx::restart_fx_looper;
  level.func_process_fx_rotater = common_scripts\_createfx::process_fx_rotater;
  level.func_player_speed = ::func_player_speed;
  level._id_3F0F = ::_id_3F0F;
  level.mp_createfx = 1;
  level.callbackstartgametype = common_scripts\utility::_id_A60A;
  level.callbackplayerconnect = common_scripts\utility::_id_A60A;
  level.callbackplayerdisconnect = common_scripts\utility::_id_A60A;
  level.callbackplayerdamage = common_scripts\utility::_id_A60A;
  level.callbackplayerkilled = common_scripts\utility::_id_A60A;
  level.callbackentityoutofworld = common_scripts\utility::_id_A60A;
  level.callbackcodeendgame = common_scripts\utility::_id_A60A;
  level.callbackplayerlaststand = common_scripts\utility::_id_A60A;
  level.callbackplayerconnect = ::callback_playerconnect;
  level.callbackplayermigrated = common_scripts\utility::_id_A60A;
  _id_04D1::main([]);

  if(isDefined(level._id_27F3))
    [[level._id_27F3]]();

  thread common_scripts\_createfx::func_get_level_fx();
  common_scripts\_createfx::createfx_common();
  level waittill("eternity");
}

func_position_player_get(var_0) {
  return level.player.origin;
}

callback_playerconnect() {
  self waittill("begin");

  if(!isDefined(level.player)) {
    var_0 = getEntArray("mp_global_intermission", "classname");
    var_1 = (var_0[0].angles[0], var_0[0].angles[1], 0.0);
    self _meth_826B(var_0[0].origin, var_1);
    maps\mp\_utility::_id_A165("playing");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread common_scripts\_createfx::createfxlogic();
  } else
    _func_134(self getentitynumber());
}

func_player_speed() {
  var_0 = level._createfx.player_speed / 190;
  level.player _meth_81E1(var_0);
}

_id_3F0F() {
  return;
}