/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_createfx.gsc
**************************************/

createfx() {
  level.func_position_player = ::scripts\engine\utility::void;
  level.func_position_player_get = ::func_position_player_get;
  level.func_loopfxthread = ::scripts\common\fx::loopfxthread;
  level.func_oneshotfxthread = ::scripts\common\fx::oneshotfxthread;
  level.func_create_loopsound = ::scripts\common\fx::create_loopsound;
  level.func_updatefx = ::scripts\common\createfx::restart_fx_looper;
  level.func_process_fx_rotater = ::scripts\common\createfx::process_fx_rotater;
  level.func_player_speed = ::func_player_speed;
  level.mp_createfx = 1;
  level.callbackstartgametype = ::scripts\engine\utility::void;
  level.callbackplayerconnect = ::scripts\engine\utility::void;
  level.callbackplayerdisconnect = ::scripts\engine\utility::void;
  level.callbackplayerdamage = ::scripts\engine\utility::void;
  level.callbackplayerkilled = ::scripts\engine\utility::void;
  level.var_375C = ::scripts\engine\utility::void;
  level.callbackplayerlaststand = ::scripts\engine\utility::void;
  level.callbackplayerconnect = ::callback_playerconnect;
  level.callbackplayermigrated = ::scripts\engine\utility::void;
  thread scripts\common\createfx::func_get_level_fx();
  scripts\common\createfx::createfx_common();
  level waittill("eternity");
}

func_position_player_get(param_00) {
  return level.player.origin;
}

callback_playerconnect() {
  self waittill("begin");
  if(!isDefined(level.player)) {
    var_00 = getEntArray("mp_global_intermission", "classname");
    self spawn(var_00[0].origin, var_00[0].angles);
    scripts\cp\utility::updatesessionstate("playing", "");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread scripts\common\createfx::createfxlogic();
    return;
  }

  kick(self getentitynumber());
}

func_player_speed() {
  var_00 = level._createfx.player_speed / 190;
  level.player setmovespeedscale(var_00);
}