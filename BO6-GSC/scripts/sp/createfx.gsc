/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\createfx.gsc
**************************************/

#using scripts\common\createfx;
#using scripts\engine\utility;
#using scripts\sp\trigger;
#namespace createfx;

function createfx() {
  if(!level.createfx_enabled) {
    return;
  }

  clearstartpointtransients();
  level.func_position_player = &func_position_player;
  level.func_position_player_get = &func_position_player_get;
  level.func_updatefx = &restart_fx_looper;
  level.func_process_fx_rotater = &process_fx_rotater;
  level.func_player_speed = &func_player_speed;
  level.mp_createfx = 0;
  utility::array_call(getaiarray(), &delete);
  utility::array_call(getspawnerarray(), &delete);
  ai = getaiarray();
  utility::array_call(ai, &delete);
  createfx_common();
  thread createfxlogic();
  thread func_get_level_fx();
  level.player allowcrouch(0);
  level.player allowprone(0);
  createfx_only_triggers();
  level waittill("~r\xf3|_!\xe8\xb7");
}

function createfx_only_triggers() {
  trigger_classes = [];
  trigger_classes["%\xc1\xe4\xa1x\x154 &e\x01\xe3>\xc0\x8c\x99Dvf~\x8a\xcb/h\xbf\x94\xc0\x10z\xb9P\rw\xcdx)"] = &trigger::trigger_createart_transient;

  foreach(function in trigger_classes) {
    triggers = getEntArray(classname, #classname);
    utility::array_levelthread(triggers, function);
  }
}

function func_position_player_get(lastplayerorigin) {
  if(distancesquared(lastplayerorigin, level.player.origin) > 4096) {
    setDvar(@ "hash_57b68f9976f53f0d", level.player.origin[0]);
    setDvar(@ "hash_57b68e9976f53cda", level.player.origin[1]);
    setDvar(@ "hash_57b68d9976f53aa7", level.player.origin[2]);
  }

  return level.player.origin;
}

function func_position_player() {
  playerpos = [];
  playerpos[0] = getdvarint(@ "hash_57b68f9976f53f0d");
  playerpos[1] = getdvarint(@ "hash_57b68e9976f53cda");
  playerpos[2] = getdvarint(@ "hash_57b68d9976f53aa7");
  level.player setOrigin((playerpos[0], playerpos[1], playerpos[2]));
  level.player setplayerangles((0, level.player.angles[1], 0));
}

function func_player_speed() {
  setsaveddvar(@ "g_speed", level._createfx.player_speed);
}