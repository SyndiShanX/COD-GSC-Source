/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\coop_createfx.gsc
***********************************************/



#using scripts\common\createfx;
#using scripts\common\createfxmenu;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace coop_createfx;

function createfx() {
  level.func_position_player = &void;
  level.func_position_player_get = &func_position_player_get;
  level.func_loopfxthread = &loopfxthread;
  level.func_oneshotfxthread = &oneshotfxthread;
  level.func_create_loopsound = &create_loopsound;
  level.func_updatefx = &restart_fx_looper;
  level.func_process_fx_rotater = &process_fx_rotater;
  level.func_player_speed = &func_player_speed;
  level.mp_createfx = 1;
  level.callbackstartgametype = &void;
  level.callbackplayeractive = &void;
  level.callbackplayerconnect = &void;
  level.callbackplayerdisconnect = &void;
  level.callbackplayerdamage = &void;
  level.callbackplayerkilled = &void;
  level.callbackcodeendgame = &void;
  level.callbackplayerlaststand = &void;
  level.callbackplayerconnect = &callback_playerconnect;
  level.callbackplayermigrated = &void;
  level.var_42d9b617bbca6a42 = &void;
  level.var_935c97aa3757676f = &void;
  level.var_cda3af1f73639c7c = &void;
  thread func_get_level_fx();
  createfx_common();
  level waittill("eternity");
}

function func_position_player_get(lastplayerorigin) {
  return level.player.origin;
}

function callback_playerconnect() {
  self waittill("begin");

  if(!isDefined(level.player)) {
    spawnpoints = getEntArray("mp_global_intermission", "classname");
    self spawn(spawnpoints[0].origin, spawnpoints[0].angles);
    updatesessionstate("playing", "");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread createfxlogic();
    return;
  }

  kick(self getentitynumber());
}

function func_player_speed() {
  scale = level._createfx.player_speed / 190;
  level.player setmovespeedscale(scale);
}