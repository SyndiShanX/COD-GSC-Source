/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_createfx.gsc
********************************/

createfx() {
  level.func_position_player = common_scripts\utility::void;
  level.func_position_player_get = ::func_position_player_get;
  level.func_loopfxthread = common_scripts\_fx::loopfxthread;
  level.func_oneshotfxthread = common_scripts\_fx::oneshotfxthread;
  level.func_create_loopsound = common_scripts\_fx::create_loopsound;
  level.func_updatefx = common_scripts\_createfx::restart_fx_looper;
  level.func_process_fx_rotater = common_scripts\_createfx::process_fx_rotater;
  level.func_player_speed = ::func_player_speed;
  level.mp_createfx = 1;
  level.callbackstartgametype = common_scripts\utility::void;
  level.callbackplayerconnect = common_scripts\utility::void;
  level.callbackplayerdisconnect = common_scripts\utility::void;
  level.callbackplayerdamage = common_scripts\utility::void;
  level.callbackplayerkilled = common_scripts\utility::void;
  level.callbackentityoutofworld = common_scripts\utility::void;
  level.callbackcodeendgame = common_scripts\utility::void;
  level.callbackplayerlaststand = common_scripts\utility::void;
  level.callbackplayerconnect = ::callback_playerconnect;
  level.callbackplayermigrated = common_scripts\utility::void;
  maps\mp\gametypes\_gameobjects::main([]);
  maps\mp\gametypes\_oldschool::deletepickups();
  thread common_scripts\_createfx::func_get_level_fx();
  common_scripts\_createfx::createfx_common();
  level waittill("eternity");
}

func_position_player_get(var_0) {
  return level.player.origin;
}

callback_playerconnect() {
  self waittill("begin");

  if(!isdefined(level.player)) {
    var_0 = getentarray("mp_global_intermission", "classname");
    var_1 = (var_0[0].angles[0], var_0[0].angles[1], 0.0);
    self spawn(var_0[0].origin, var_1);
    maps\mp\_utility::updatesessionstate("playing");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread common_scripts\_createfx::createfxlogic();
  } else
    kick(self getentitynumber());
}

func_player_speed() {
  var_0 = level._createfx.player_speed / 190;
  level.player setmovespeedscale(var_0);
}