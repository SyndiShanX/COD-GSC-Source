/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_parking_lot.gsc
****************************************/

start() {
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "parking_lot_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "parking_lot_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "parking_lot_start_charlie");
  level.player maps\factory_util::move_player_to_start_point("playerstart_parking_lot");
  thread parking_lot_blockade_vehicle_1("blockade_vehicle_1");
  thread maps\factory_chase::car_chase_intro_car_crash_setup();
  thread maps\factory_chase::chase_ally_vehicle_setup();
  common_scripts\utility::flag_set("player_near_rooftop_end");
}

main() {
  maps\_utility::autosave_by_name("rooftop_complete");
  var_0 = getEntArray("parking_lot_truck_blocker", "targetname");

  foreach(var_2 in var_0) {
    var_2 notsolid();
    var_2 delete();
  }

  thread parking_lot_player_death_trigger();
  thread parking_lot_ally_location_check();
  thread load_outro_transients();
  maps\_utility::wait_for_flag_or_timeout("player_near_rooftop_end", 30);
  parking_lot_vehicle_setup();
}

load_outro_transients() {
  common_scripts\utility::flag_wait("player_off_roof");
  maps\_utility::transient_unloadall_and_load("factory_outro_tr");
  level waittill("semi_trailer_entrance");
  maps\factory_util::sync_transients();
}

section_flag_init() {
  common_scripts\utility::flag_init("allies_in_loading_dock");
}

section_

parking_lot_vehicle_setup() {
  parking_lot_blockade();
  thread parking_lot_dialog();

  foreach(var_1 in level.squad) {
  var_1.grenadeammo = 0;
  }

  common_scripts\utility::flag_wait("allies_in_loading_dock");
  wait 4;
  level notify("here_comes_the_truck");
}

parking_lot_dialog() {
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_rgs_vehiclesincoming");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_gettocover2");
  common_scripts\utility::flag_wait("allies_in_loading_dock");
  level.squad["ALLY_ALPHA"] maps\_utility::smart_dialogue("factory_bkr_staydown");
  level.squad["ALLY_CHARLIE"] maps\_utility::smart_dialogue("factory_hsh_arclightisstartingwheres");
  maps\_utility::smart_radio_dialogue("factory_diz_iseeemstayclear");
}

parking_lot_enemy_dialog() {
  level waittill("here_comes_the_truck");
  var_0 = maps\_utility::get_living_ai_array("blockade_enemy", "script_noteworthy");
  var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0);
  var_0[0] thread enemy_alive_dialog("factory_gs1_what");
  wait 0.2;
  var_0[1] thread enemy_alive_dialog("factory_gs1_lookout");
  wait 0.1;
  var_0[2] thread enemy_alive_dialog("factory_gs1_run");
  wait 0.3;
  var_0[3] thread enemy_alive_dialog("factory_gs1_shootit");
}

enemy_alive_dialog(var_0) {
  if(isDefined(self) && isalive(self)) {
    self.animname = "enemy";
    maps\_utility::smart_dialogue(var_0);
  }
}

parking_lot_blockade() {
  wait 0.1;
  thread parking_lot_blockade_vehicle_2("blockade_vehicle_2");
  wait 0.1;
  thread parking_lot_blockade_vehicle_3("blockade_vehicle_3");

  foreach(var_1 in level.squad) {
  var_1 thread parking_lot_allies_take_cover();
  }
}

parking_lot_allies_take_cover() {
  maps\_utility::enable_sprint();
  maps\_utility::disable_pain();
  self.ignoresuppression = 1;
  level.ai_friendlyfireblockduration = getdvarfloat("ai_friendlyFireBlockDuration");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  common_scripts\utility::flag_wait("allies_in_loading_dock");
  maps\_utility::disable_sprint();
  self allowedstances("crouch");
}

parking_lot_ally_location_check() {
  var_0 = getent("loading_dock_cover", "targetname");

  for(;;) {
    var_1 = var_0 maps\_utility::get_ai_touching_volume("allies");

    if(var_1.size == 3) {
      common_scripts\utility::flag_set("allies_in_loading_dock");
      break;
    }

    wait 0.1;
  }

  thread parking_lot_timeout();
}

parking_lot_timeout() {
  level endon("player_off_roof");
  wait 10;
  maps\factory_util::safe_trigger_by_targetname("start_chase_sequence_trigger");
  level waittill("semi_trailer_entrance");
  level notify("player_off_roof");
}

parking_lot_blockade_vehicle_1(var_0) {
  level.blockade_vehicle_1 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  level.blockade_vehicle_1 maps\_vehicle::vehicle_lights_on("running");
  level.blockade_vehicle_1 thread maps\factory_audio::sfx_jeep_drive_up_01();
  level.blockade_vehicle_1 maps\_vehicle::godon();
  level.blockade_vehicle_1.animname = "first_opfor_car";
  var_1 = getent("car_chase_intro", "script_noteworthy");
  level.blockade_vehicle_1 notify("suspend_drive_anims");
  var_1 thread maps\_anim::anim_single_solo(level.blockade_vehicle_1, "car_chase_intro_pullup");
  wait 3;
  level.blockade_vehicle_1 maps\_vehicle::godoff();
  level.blockade_vehicle_1 thread maps\factory_chase::vehicle_catch_fire_when_shot();
  level.blockade_vehicle_1 maps\_vehicle::vehicle_unload("all");
  level waittill("hit_vehicle_01");
  level.blockade_vehicle_1 thread parking_lot_blockade_vehicle_death_radius();
  level.factory_car_chase_intro_side_car01 thread parking_lot_blockade_vehicle_death_radius();
  level.factory_car_chase_intro_side_car02 thread parking_lot_blockade_vehicle_death_radius();
}

parking_lot_blockade_vehicle_2(var_0) {
  level.blockade_vehicle_2 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  level.blockade_vehicle_2 maps\_vehicle::vehicle_lights_on("running");
  level.blockade_vehicle_2 thread maps\factory_audio::sfx_jeep_drive_up_02();
  level.blockade_vehicle_2 maps\_vehicle::godon();
  level.blockade_vehicle_2.animname = "second_opfor_car";
  var_1 = getent("car_chase_intro", "script_noteworthy");
  level.blockade_vehicle_2 notify("suspend_drive_anims");
  var_1 thread maps\_anim::anim_single_solo(level.blockade_vehicle_2, "car_chase_intro_pullup");
  wait 3.5;
  level.blockade_vehicle_2 maps\_vehicle::godoff();
  level.blockade_vehicle_2 thread maps\factory_chase::vehicle_catch_fire_when_shot();
  level.blockade_vehicle_2 maps\_vehicle::vehicle_unload("all_but_gunner");
  level waittill("hit_vehicle_02");
  level.blockade_vehicle_2 thread parking_lot_blockade_vehicle_death_radius();
}

parking_lot_blockade_vehicle_3(var_0) {
  level.blockade_vehicle_3 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  level.blockade_vehicle_3 maps\_vehicle::vehicle_lights_on("running");
  level.blockade_vehicle_3 thread maps\factory_audio::sfx_tank_drive_up();
  level.blockade_vehicle_3 maps\_vehicle::godon();
  level.blockade_vehicle_3.animname = "heavy_weapon_opfor_car";
  var_1 = getent("car_chase_intro", "script_noteworthy");
  level.blockade_vehicle_3 notify("suspend_drive_anims");
  var_1 thread maps\_anim::anim_single_solo(level.blockade_vehicle_3, "car_chase_intro_pullup");
  wait 2.5;
  level.blockade_vehicle_3 maps\_vehicle::godoff();
  level.blockade_vehicle_3 thread maps\factory_chase::vehicle_catch_fire_when_shot();
  level.blockade_vehicle_3 maps\_vehicle::vehicle_unload("all");
  level waittill("hit_vehicle_03");
  level.blockade_vehicle_3 thread parking_lot_blockade_vehicle_death_radius();
}

parking_lot_blockade_vehicle_death_radius() {
  level endon("semi_stopped");

  for(;;) {
    var_0 = distance(self.origin, level.player.origin);

    if(var_0 < 256) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", &"FACTORY_FAIL_HIT_BY_TRAILER");
      level.player kill();
      maps\_utility::missionfailedwrapper();
    }

    wait 0.1;
  }
}

parking_lot_fire_hydrant_explodes() {
  var_0 = getent("parking_lot_apc_target_02", "targetname");
  radiusdamage(var_0.origin, 100, 5000, 5000, level.player);
}

parking_lot_player_death_trigger() {
  level endon("semi_stopped");
  maps\_utility::trigger_wait_targetname("parking_lot_kill_trigger");
  var_0 = maps\_utility::get_living_ai_array("blockade_enemy", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.favoriteenemy = level.player;
    var_2.accuracy = 10000;
  }

  while(level.player.health > 25) {
    level.player dodamage(75, level.blockade_vehicle_1.origin, level.blockade_vehicle_1, level.blockade_vehicle_1, "MOD_RIFLE_BULLET");
    wait 0.2;
  }

  level.player kill();
}