/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\load.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_lights;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_clientfaceanim;

levelNotifyHandler(clientNum, state, oldState) {
  if(state != "") {
    level notify(state, clientNum);
  }
}
end_last_stand(clientNum) {
  self waittill("lastStandEnd");
  println("Last stand ending for client " + clientNum);
  if(getlocalplayers().size == 1) {
    setBusState("return_default");
  }
  realwait(0.7);
  println("Gasp.");
  playsound(clientNum, "revive_gasp");
}
last_stand_thread(clientNum) {
  self thread end_last_stand(clientNum);
  self endon("lastStandEnd");
  println("*** Client : Last stand starts on client " + clientNum);
  if(isDefined(level.zombie_intermission) && level.zombie_intermission) {
    setBusState("zombie_death");
  } else if(getlocalplayers().size == 1) {
    setBusState("last_stand_start");
    realWait(0.1);
    setBusState("last_stand_duration");
  }
  startVol = 0.5;
  maxVol = 1.0;
  startPause = 0.5;
  maxPause = 2.0;
  pause = startPause;
  vol = startVol;
  while (1) {
    id = playsound(clientNum, "chr_heart_beat");
    setSoundVolume(id, vol);
    realWait(pause);
    if(pause < maxPause) {
      pause *= 1.05;
      if(pause > maxPause) {
        pause = maxPause;
      }
    }
    if(vol < maxVol) {
      vol *= 1.05;
      if(vol > maxVol) {
        vol = maxVol;
      }
    }
  }
}
last_stand_monitor(clientNum, state, oldState) {
  player = getlocalplayers()[clientNum];
  players = getlocalplayers();
  if(!isDefined(level._laststand)) {
    level._laststand = [];
  }
  if(!isDefined(level._laststand[clientNum])) {
    level._laststand[clientNum] = 0;
  }
  if(state == "1") {
    if(!level._laststand[clientNum]) {
      if(!isDefined(level.lslooper)) {
        level.lslooper = spawn(0, player.origin, "script.origin");
      }
      player thread last_stand_thread(clientNum);
      if(players.size <= 1) {
        level.lslooper playloopsound("evt_laststand_loop", 0.3);
      }
      level._laststand[clientNum] = true;
    }
  } else {
    if(level._laststand[clientNum]) {
      if(isDefined(level.lslooper)) {
        level.lslooper stoploopsound(0.7);
      }
      player notify("lastStandEnd");
      level._laststand[clientNum] = false;
    }
  }
}
damage_visionset_think(local_client_num) {
  player = getlocalplayers()[local_client_num];
  player endon("disconnect");
  level endon("save_restore");
  wait(1.0);
  max_health = 100;
  health_threshold = max_health * 0.75;
  health_threshold_off = max_health;
  visionset = false;
  PrintLn("*** HTH " + health_threshold);
  while (1) {
    health = GetLocalClientHealth(local_client_num);
    if(visionset == false) {
      if(health < health_threshold) {
        VisionSetDamage(local_client_num, 1, "low_health", 2);
        visionset = true;
      }
    } else {
      if(health >= max_health) {
        PrintLn("*** VS OFF");
        VisionSetDamage(local_client_num, 0, "low_health", 2);
        visionset = false;
      }
    }
    realWait(0.01);
  }
}
effects_init_thread(client, notify_name) {
  if(level.zombiemode && IsSplitscreen() && client == 1) {
    level.effects_init = undefined;
    level thread effects_init_failsafe();
  }
  level waittill(notify_name);
  println("*** Client : Starting effects system for client " + client);
  if(level.zombiemode && IsSplitscreen() && client == 1) {
    level.effects_init = true;
  }
  clientscripts\_fx::fx_init(client);
  clientscripts\_ambient::init(client);
}
effects_init_failsafe() {
  wait(1);
  if(!isDefined(level.effects_init)) {
    println("**** Client : Effects never started for client 1");
    level notify("effects_init_1");
  }
}
default_flag_change_handler(localClientNum, flag, set, newEnt) {}
init_client_flags() {
  level.CF_PLAYER_UNDERWATER = 15;
}
register_default_vehicle_callbacks() {
  level._client_flag_callbacks["vehicle"] = [];
  register_clientflag_callback("vehicle", 0, clientscripts\_vehicle::vehicle_flag_0_handler);
  register_clientflag_callback("vehicle", 1, clientscripts\_vehicle::vehicle_flag_1_handler);
  register_clientflag_callback("vehicle", 2, clientscripts\_vehicle::vehicle_flag_toggle_sounds);
  register_clientflag_callback("vehicle", 3, clientscripts\_vehicle::vehicle_flag_3_handler);
  register_clientflag_callback("vehicle", 4, clientscripts\_vehicle::vehicle_flag_4_handler);
  register_clientflag_callback("vehicle", 6, clientscripts\_vehicle::vehicle_flag_turn_off_treadfx);
  register_clientflag_callback("vehicle", 7, clientscripts\_vehicle::vehicle_flag_change_treadfx_handler);
  register_clientflag_callback("vehicle", 8, clientscripts\_vehicle::vehicle_flag_toggle_exhaustfx_handler);
  register_clientflag_callback("vehicle", 9, clientscripts\_vehicle::vehicle_flag_change_exhaustfx_handler);
  register_clientflag_callback("vehicle", 10, clientscripts\_vehicle::vehicle_flag_toggle_lights_handler);
  register_clientflag_callback("vehicle", 11, clientscripts\_vehicle::vehicle_flag_toggle_siren_lights_handler);
  register_clientflag_callback("vehicle", 12, clientscripts\_vehicle::vehicle_flag_toggle_interior_lights_handler);
}
register_default_actor_callbacks() {
  level._client_flag_callbacks["actor"] = [];
}
register_default_player_callbacks() {
  level._client_flag_callbacks["player"] = [];
  register_clientflag_callback("player", level.CF_PLAYER_UNDERWATER, ::player_underwater_flag_handler);
}
register_default_NA_callbacks() {
  level._client_flag_callbacks["NA"] = [];
}
register_default_general_callbacks() {
  level._client_flag_callbacks["general"] = [];
}
register_default_missile_callbacks() {
  level._client_flag_callbacks["missile"] = [];
}
register_default_scriptmover_callbacks() {
  level._client_flag_callbacks["scriptmover"] = [];
}
register_default_mg42_callbacks() {
  level._client_flag_callbacks["mg42"] = [];
}
register_default_plane_callbacks() {
  level._client_flag_callbacks["plane"] = [];
  register_clientflag_callback("plane", 6, clientscripts\_vehicle::vehicle_flag_turn_off_treadfx);
}
setup_default_client_flag_callbacks() {
  init_client_flags();
  level._client_flag_callbacks = [];
  register_default_vehicle_callbacks();
  register_default_actor_callbacks();
  register_default_player_callbacks();
  register_default_NA_callbacks();
  register_default_general_callbacks();
  register_default_missile_callbacks();
  register_default_scriptmover_callbacks();
  register_default_mg42_callbacks();
  register_default_plane_callbacks();
}
player_underwater_flag_handler(localClientNum, set, newEnt) {
  action = "SET";
  if(!set) {
    action = "CLEAR";
  }
  if(action == "SET") {
    if(isDefined(level.swimming_underwater_func)) {
      self[[level.swimming_underwater_func]]();
    } else {
      self clientscripts\_swimming::underwater();
    }
  } else {
    if(isDefined(level.swimming_surface_func)) {
      self[[level.swimming_surface_func]]();
    } else {
      self clientscripts\_swimming::surface();
    }
  }
}
main() {
  clientscripts\_utility_code::struct_class_init();
  clientscripts\_utility::registerSystem("levelNotify", ::levelNotifyHandler);
  clientscripts\_utility::registerSystem("lsm", ::last_stand_monitor);
  level.createFX_enabled = (getdvar(#"createfx") != "");
  level.zombiemode = (GetDvar(#"zombiemode") == "1");
  if(!isDefined(level.scr_anim))
    level.scr_anim[0][0] = 0;
  setup_default_client_flag_callbacks();
  clientscripts\_global_fx::main();
  clientscripts\_busing::busInit();
  clientscripts\_ambientpackage::init();
  clientscripts\_music::music_init();
  clientscripts\_vehicle::init_vehicles();
  clientscripts\_contextual_melee::main();
  clientscripts\_footsteps::init();
  clientscripts\_helicopter_sounds::init();
  clientscripts\_face_generichuman::init();
  clientscripts\_clientfaceanim::init_clientfaceanim();
  if(isDefined(level._uses_crossbow) && level._uses_crossbow == true) {
    level thread clientscripts\_explosive_bolt::main();
  }
  for (i = 0; i < 4; i++) {
    level thread effects_init_thread(i, "effects_init_" + i);
  }
  add_listen_thread("rfo1", clientscripts\_utility::loop_sound_on_client, "chr_breathing_hurt", 0.3, 0.7, "rfo2");
  add_listen_thread("rfo3", clientscripts\_utility::play_sound_on_client, "chr_breathing_better");
  add_listen_thread("zi", ::zombie_intermission);
  level.onlineGame = GetDvarInt(#"onlinegame");
  level._load_done = 1;
}
zombie_intermission() {
  level.zombie_intermission = true;
}

