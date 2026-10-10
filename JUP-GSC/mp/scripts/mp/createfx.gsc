/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\createfx.gsc
***********************************************/

#using scripts\common\createfx;
#using scripts\common\createfxmenu;
#using scripts\common\fx;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace createfx;

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
  level.callbackplayerlaststand = &void;
  level.callbackplayerconnect = &callback_playerconnect;
  level.callbackplayermigrated = &void;
  level.var_42d9b617bbca6a42 = &void;
  level.var_935c97aa3757676f = &void;
  level.var_cda3af1f73639c7c = &void;
  thread reflectionprobe_hide_hp();
  thread reflectionprobe_hide_front();
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
  setDvar(@ "g_speed", level._createfx.player_speed);
}

function reflectionprobe_hide_hp() {
  neutralpoint = getEntArray("<dev string:x1c>", "<dev string:x35>");
  enemypoint = getEntArray("<dev string:x43>", "<dev string:x35>");
  friendpoint = getEntArray("<dev string:x62>", "<dev string:x35>");
  contestpoint = getEntArray("<dev string:x82>", "<dev string:x35>");

  foreach(zone in neutralpoint) {
    zone hide();
  }

  foreach(zone in enemypoint) {
    zone hide();
  }

  foreach(zone in friendpoint) {
    zone hide();
  }

  foreach(zone in contestpoint) {
    zone hide();
  }
}

function reflectionprobe_hide_front() {
  var_a5d9ff994b1d7ab6 = getEnt("<dev string:xa3>", "<dev string:x35>");

  if(isDefined(var_a5d9ff994b1d7ab6)) {
    var_a5d9ff994b1d7ab6 hide();
  }

  var_a5d9fe994b1d7883 = getEnt("<dev string:xc6>", "<dev string:x35>");

  if(isDefined(var_a5d9fe994b1d7883)) {
    var_a5d9fe994b1d7883 hide();
  }

  var_a5da04994b1d85b5 = getEnt("<dev string:xe8>", "<dev string:x35>");

  if(isDefined(var_a5da04994b1d85b5)) {
    var_a5da04994b1d85b5 hide();
  }

  var_a57411994aac8dfb = getEnt("<dev string:x10c>", "<dev string:x35>");

  if(isDefined(var_a57411994aac8dfb)) {
    var_a57411994aac8dfb hide();
  }

  var_a57412994aac902e = getEnt("<dev string:x12d>", "<dev string:x35>");

  if(isDefined(var_a57412994aac902e)) {
    var_a57412994aac902e hide();
  }

  var_a57414994aac9494 = getEnt("<dev string:x14d>", "<dev string:x35>");

  if(isDefined(var_a57414994aac9494)) {
    var_a57414994aac9494 hide();
  }
}