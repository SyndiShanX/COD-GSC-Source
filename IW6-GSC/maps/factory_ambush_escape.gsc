/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\factory_ambush_escape.gsc
******************************************/

start() {
  maps\factory_util::actor_teleport(level.squad["ALLY_ALPHA"], "ambush_escape_start_alpha");
  maps\factory_util::actor_teleport(level.squad["ALLY_BRAVO"], "ambush_escape_start_bravo");
  maps\factory_util::actor_teleport(level.squad["ALLY_CHARLIE"], "ambush_escape_start_charlie");
  common_scripts\utility::flag_set("lgt_ambush_escape_jump");
  maps\factory_util::safe_trigger_by_targetname("ambush_escape_allies_goto_office");
  level.player maps\factory_util::move_player_to_start_point("playerstart_ambush_escape");
  thread maps\factory_audio::sfx_pa_bursts();
  thread maps\factory_rooftop::rooftop_heli();
  thread maps\factory_fx::rooftop_wind_gusts();
  thread maps\factory_intro::train_cleanup();
}

section_

section_flag_init() {
  common_scripts\utility::flag_init("ambush_escape_clear");
  common_scripts\utility::flag_init("spawn_loading_dock_vehicles ");
  common_scripts\utility::flag_init("lgt_ambush_escape_jump");
}

main() {
  level.use_animated_ambush_escape_chopper = 1;
  maps\_utility::autosave_by_name("ambush_escape");
  common_scripts\utility::flag_wait("ambush_player_in_office");
  thread ambush_escape_dialogue();

  if(level.player.thermal == 1) {
    level.player notify("use_thermal");
    level.player maps\factory_util::turn_off_thermal_vision();
  }

  foreach(var_1 in level.squad) {
    var_1 pushplayer(1);
  }

  maps\factory_util::safe_trigger_by_targetname("ambush_escape_allies_stop_midway");
  common_scripts\utility::flag_wait("spawn_loading_dock_vehicles");
  thread loading_dock_vehicles();
  maps\factory_util::safe_trigger_by_targetname("ambush_escape_allies_rooftop");
  thread maps\factory_rooftop::rooftop_door_breach();
  common_scripts\utility::flag_wait("ambush_escape_clear");
}

ambush_escape_dialogue() {
  common_scripts\utility::flag_wait("ambush_escape_dialogue_trigger");
  maps\_utility::smart_radio_dialogue("factory_kck_merrickimsecuring");
}

loading_dock_vehicles() {
  thread maps\factory_chase::chase_ally_vehicle_setup();
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambush_escape_vehicle");

  foreach(var_2 in var_0) {
    var_2 thread loading_dock_vehicle_setup();
  }

  common_scripts\utility::flag_wait("ambush_escape_clear");
  var_4 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("ambush_escape_vehicle_second_wave");

  foreach(var_2 in var_4) {
    var_2 thread loading_dock_vehicle_setup();
  }
}

loading_dock_vehicle_setup() {
  maps\_vehicle::vehicle_lights_on("headlights");
  thread maps\factory_chase::vehicle_catch_fire_when_shot();
  self waittill("reached_end_node");
  wait(randomfloatrange(1.0, 2.0));
  maps\_vehicle::vehicle_lights_off("headlights");

  foreach(var_1 in self.riders) {
    var_1 thread loading_dock_enemies();
  }

  level waittill("rooftop_complete");
  self delete();
}

loading_dock_enemies() {
  self endon("death");
  self.health = 1;
  var_0 = getent("loading_dock_enemies_goal", "targetname");
  self setgoalvolume(var_0);

  while(!self istouching(var_0)) {
    wait 0.25;
  }

  self delete();
}