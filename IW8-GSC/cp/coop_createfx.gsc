/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\coop_createfx.gsc
***********************************************/

createfx() {
  level.func_position_player = scripts\engine\utility::void;
  level.func_position_player_get = ::func_position_player_get;
  level.func_loopfxthread = scripts\common\fx::loopfxthread;
  level.func_oneshotfxthread = scripts\common\fx::oneshotfxthread;
  level.func_create_loopsound = scripts\common\fx::create_loopsound;
  level.func_updatefx = scripts\common\createfx::restart_fx_looper;
  level.func_process_fx_rotater = scripts\common\createfx::process_fx_rotater;
  level.func_player_speed = ::func_player_speed;
  level.mp_createfx = 1;
  level.callbackstartgametype = scripts\engine\utility::void;
  level.frontend4 = scripts\engine\utility::void;
  level.callbackplayerconnect = scripts\engine\utility::void;
  level.callbackplayerdisconnect = scripts\engine\utility::void;
  level.callbackplayerdamage = scripts\engine\utility::void;
  level.callbackplayerkilled = scripts\engine\utility::void;
  level.callbackcodeendgame = scripts\engine\utility::void;
  level.callbackplayerlaststand = scripts\engine\utility::void;
  level.callbackplayerconnect = ::callback_playerconnect;
  level.callbackplayermigrated = scripts\engine\utility::void;
  thread scripts\common\createfx::func_get_level_fx();
  scripts\common\createfx::createfx_common();
  level waittill("_encstr_9140093575E183DD9398A3");
}

func_position_player_get(var_0) {
  return level.player.origin;
}

callback_playerconnect() {
  self waittill("_encstr_845E066177577837");

  if(!isDefined(level.player)) {
    var_0 = getEntArray("_encstr_B4D317B607EBB336DE4C0B63FAA5CDD12BE4DA4BDC6E2DBD37", "_encstr_AC110A7F14873B5B3D073009");
    self spawn(var_0[0].origin, var_0[0].angles);
    scripts\cp\utility::updatesessionstate("_encstr_877508C1D8C22F2DDC3B", "_encstr_B40101");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread scripts\common\createfx::createfxlogic();
  } else
    kick(self getentitynumber());
}

func_player_speed() {
  var_0 = level._createfx.player_speed / 190;
  level.player setmovespeedscale(var_0);
}