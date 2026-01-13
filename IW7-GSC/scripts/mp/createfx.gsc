/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\createfx.gsc
*********************************************/

createfx() {
  level.var_position_player = ::scripts\engine\utility::void;
  level.var_position_player_get = ::func_position_player_get;
  level.var_loopfxthread = ::scripts\common\fx::loopfxthread;
  level.var_oneshotfxthread = ::scripts\common\fx::oneshotfxthread;
  level.var_create_loopsound = ::scripts\common\fx::create_loopsound;
  level.var_updatefx = ::scripts\common\createfx::restart_fx_looper;
  level.var_process_fx_rotater = ::scripts\common\createfx::process_fx_rotater;
  level.var_player_speed = ::func_player_speed;
  level.mp_createfx = 1;
  level.callbackstartgametype = ::scripts\engine\utility::void;
  level.callbackplayerconnect = ::scripts\engine\utility::void;
  level.callbackplayerdisconnect = ::scripts\engine\utility::void;
  level.callbackplayerdamage = ::scripts\engine\utility::void;
  level.callbackplayerkilled = ::scripts\engine\utility::void;
  level.callbackplayerlaststand = ::scripts\engine\utility::void;
  level.callbackplayerconnect = ::callback_playerconnect;
  level.callbackplayermigrated = ::scripts\engine\utility::void;
  thread reflectionprobe_hide_hp();
  thread reflectionprobe_hide_front();
  thread scripts\common\createfx::func_get_level_fx();
  scripts\common\createfx::createfx_common();
  level waittill("eternity");
}

func_position_player_get(var_0) {
  return level.player.origin;
}

callback_playerconnect() {
  self waittill("begin");
  if(!isDefined(level.player)) {
    var_0 = getEntArray("mp_global_intermission", "classname");
    self spawn(var_0[0].origin, var_0[0].angles);
    scripts\mp\utility::updatesessionstate("playing", "");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread scripts\common\createfx::createfxlogic();
    return;
  }

  kick(self getentitynumber());
}

func_player_speed() {
  var_0 = level._createfx.player_speed / 190;
  level.player setmovespeedscale(var_0);
}

reflectionprobe_hide_hp() {}

reflectionprobe_hide_front() {}