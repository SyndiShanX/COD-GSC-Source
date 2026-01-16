/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_load.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_lights;
#include clientscripts\_music;
#include clientscripts\_busing;
#include clientscripts\_clientfaceanim;
#include clientscripts\_filter;
#include clientscripts\_wiiu_audio_optimizations;
#include clientscripts\_vehicle;
#include clientscripts\_utility_code;
#include clientscripts\_global_fx;
#include clientscripts\_ambientpackage;
#include clientscripts\_footsteps;
#include clientscripts\_helicopter_sounds;
#include clientscripts\_qrcode;
#include clientscripts\_radiant_live_update;
#include clientscripts\_face_generichuman;
#include clientscripts\_explosive_bolt;
#include clientscripts\_explosive_dart;
#include clientscripts\_sticky_grenade;
#include clientscripts\_fx;
#include clientscripts\_ambient;
#include clientscripts\_empgrenade;

levelnotifyhandler(clientnum, state, oldstate) {
  if(state != "")
    level notify(state, clientnum);
}

end_last_stand(clientnum) {
  self waittill("lastStandEnd");

  println("Last stand ending for client " + clientnum);

  if(level.localplayers.size == 1)
    setbusstate("return_default");

  waitrealtime(0.7);

  println("Gasp.");

  playsound(clientnum, "revive_gasp");
}

last_stand_thread(clientnum) {
  self thread end_last_stand(clientnum);
  self endon("lastStandEnd");

  println("*** Client : Last stand starts on client " + clientnum);

  if(level.localplayers.size == 1) {
    setbusstate("last_stand_start");
    waitrealtime(0.1);
    setbusstate("last_stand_duration");
  }

  pause = 0.5;
  vol = 0.5;

  while(true) {
    id = playsound(clientnum, "chr_heart_beat");
    setsoundvolume(id, vol);
    waitrealtime(pause);

    if(pause < 2.0) {
      pause = pause * 1.05;

      if(pause > 2.0)
        pause = 2.0;
    }

    if(vol < 1.0) {
      vol = vol * 1.05;

      if(vol > 1.0)
        vol = 1.0;
    }
  }
}

last_stand_monitor(clientnum, state, oldstate) {
  player = level.localplayers[clientnum];
  players = level.localplayers;

  if(state == "1") {
    if(!level._laststand[clientnum]) {
      if(!isDefined(level.lslooper))
        level.lslooper = spawn(0, player.origin, "script.origin");

      player thread last_stand_thread(clientnum);

      if(players.size <= 1)
        level.lslooper playloopsound("evt_laststand_loop", 0.3);

      level._laststand[clientnum] = 1;
    }
  } else if(level._laststand[clientnum]) {
    if(isDefined(level.lslooper))
      level.lslooper stoploopsound(0.7);

    player notify("lastStandEnd");
    level._laststand[clientnum] = 0;
  }
}

damage_visionset_think(local_client_num) {
  player = level.localplayers[local_client_num];
  player endon("disconnect");
  wait 1.0;
  health_threshold = 100 * 0.75;
  health_threshold_off = 100;
  visionset = 0;

  println("*** HTH " + health_threshold);

  while(true) {
    health = getlocalclienthealth(local_client_num);

    if(visionset == 0) {
      if(health < health_threshold) {
        visionsetdamage(local_client_num, 1, "low_health", 2);
        visionset = 1;
      }
    } else if(health >= 100) {
      println("*** VS OFF");

      visionsetdamage(local_client_num, 0, "low_health", 2);
      visionset = 0;
    }

    waitrealtime(0.01);
  }
}

default_flag_change_handler(localclientnum, flag, set, newent) {
}

init_client_flags() {
  level.cf_player_underwater = 15;
}

register_default_vehicle_callbacks() {
  level._client_flag_callbacks["vehicle"] = [];
  register_clientflag_callback("vehicle", 0, clientscripts\_vehicle::vehicle_flag_toggle_lockon_handler);
  register_clientflag_callback("vehicle", 2, clientscripts\_vehicle::vehicle_flag_toggle_sounds);
  register_clientflag_callback("vehicle", 3, clientscripts\_vehicle::vehicle_flag_3_handler);
  register_clientflag_callback("vehicle", 4, clientscripts\_vehicle::vehicle_flag_4_handler);
  register_clientflag_callback("vehicle", 6, clientscripts\_vehicle::vehicle_flag_turn_off_treadfx);
  register_clientflag_callback("vehicle", 8, clientscripts\_vehicle::vehicle_flag_toggle_exhaustfx_handler);
  register_clientflag_callback("vehicle", 10, clientscripts\_vehicle::vehicle_flag_toggle_lights_handler);
}

register_default_actor_callbacks() {
  level._client_flag_callbacks["actor"] = [];
}

register_default_player_callbacks() {
  level._client_flag_callbacks["player"] = [];
}

register_default_na_callbacks() {
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
  register_default_na_callbacks();
  register_default_general_callbacks();
  register_default_missile_callbacks();
  register_default_scriptmover_callbacks();
  register_default_mg42_callbacks();
  register_default_plane_callbacks();
  level._client_flag_callbacks["helicopter"] = [];
}

main() {
  clientscripts\_utility_code::init_session_mode_flags();
  clientscripts\_utility_code::struct_class_init();
  clientscripts\_utility::initlocalplayers();
  clientscripts\_utility::registersystem("levelNotify", ::levelnotifyhandler);
  clientscripts\_utility::registersystem("lsm", ::last_stand_monitor);
  level.createfx_enabled = getdvar(#"createfx") != "";
  level.xenon = getdvar(#"xenonGame") == "true";
  level.ps3 = getdvar(#"ps3Game") == "true";
  level.wiiu = getdvar(#"wiiuGame") == "true";
  level.console = level.xenon || level.ps3 || level.wiiu;

  if(!isDefined(level.scr_anim))
    level.scr_anim[0][0] = 0;

  setup_default_client_flag_callbacks();
  onplayerconnect_callback(::on_player_connect);
  clientscripts\_global_fx::main();
  clientscripts\_busing::businit();
  clientscripts\_ambientpackage::init();
  clientscripts\_music::music_init();
  clientscripts\_vehicle::init_vehicles();
  clientscripts\_footsteps::init();
  clientscripts\_helicopter_sounds::init();
  clientscripts\_qrcode::init();

  if(level.wiiu)
    clientscripts\_wiiu_audio_optimizations::main();

  clientscripts\_radiant_live_update::main();

  clientscripts\_face_generichuman::init();
  clientscripts\_clientfaceanim::init_clientfaceanim();
  level thread clientscripts\_explosive_bolt::main();
  level thread clientscripts\_explosive_dart::main();
  level thread clientscripts\_sticky_grenade::main();
  add_listen_thread("rfo1", clientscripts\_utility::loop_sound_on_client, "chr_breathing_hurt", 0.3, 0.7, "rfo2");
  add_listen_thread("rfo3", clientscripts\_utility::play_sound_on_client, "chr_breathing_better");
  level.onlinegame = sessionmodeisonlinegame();
  level._load_done = 1;
  waitforclient(0);
  init_code_filters(getlocalplayers()[0]);
  setup_default_ui3d();
}

setup_default_ui3d() {
  ui3dsetwindow(0, 0, 0, 0.125, 0.125);
  ui3dsetwindow(1, 0, 0.25, 0.125, 0.125);
  ui3dsetwindow(2, 0.125, 0, 0.125, 0.5);
  ui3dsetwindow(3, 0.25, 0, 0.25, 0.5);
  ui3dsetwindow(4, 0, 0.5, 0.5, 0.5);
  ui3dsetwindow(5, 0.5, 0, 0.5, 1);
}

on_player_connect(n_client) {
  clientscripts\_fx::fx_init(n_client);
  clientscripts\_ambient::init(n_client);
  level thread clientscripts\_empgrenade::init();
}