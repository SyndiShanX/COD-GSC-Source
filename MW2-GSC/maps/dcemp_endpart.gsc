/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\dcemp_endpart.gsc
********************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_anim;
#include maps\_weather;
#include maps\_slowmo_breach;
#include maps\dcemp_endpart_code;
#include maps\dcemp_code;
#using_animtree("generic_human");

start_tunnels() {
  maps\dcemp::start_common_dcemp();
  flag_set("rain_fx");
  flag_set("tunnels_main");

  vision_set_tunnels();
  waittillframeend;

  delaythread(0.5, maps\_weather::rainHard, 0.1);
  delaythread(0.5, maps\_weather::lightning, maps\dcemp_fx::lightning_normal, maps\dcemp_fx::lightning_flash);

  emp_teleport_team(level.team, getStructArray("tunnels_start_points", "targetname"));
  emp_teleport_player();

  level.sky delete();

  delayThread(0.25, ::activate_trigger_with_noteworthy, "tunnels_spawn_trigger");
}

tunnels_flags() {
  flag_init("tunnels_teleport_done");
  flag_init("tunnels_teleport");
  flag_init("tunnels_door_open");
  flag_init("tunnels_door_open_done");

  if(!flag_exist("dc_emp_bunker"))
    flag_init("dc_emp_bunker");
}

tunnels_main() {
  level.cosine["60"] = cos(60);

  tunnels_flags();

  level.drone_spawn_func = ::simple_drone_init;

  array_spawn_function_noteworthy("tunnels_dead_guy", ::tunnels_dead_guy);
  array_spawn_function_noteworthy("tunnels_dead_check", ::tunnels_dead_check);

  wait 0.2;

  add_wait(::trigger_wait_targetname, "tunnels_first_color_trig");
  add_func(::vision_set_tunnels);
  thread do_wait();

  level thread tunnels_door_scene();

  flag_wait("tunnels_main");

  level thread tunnels_dialogues();

  force_flash_setup();

  thread battlechatter_off("allies");

  level.team["marine1"] set_force_color("g");
  level.foley set_force_color("y");
  level.dunn set_force_color("o");

  if(!flag("tunnels_indoor"))
    activate_trigger_with_targetname("tunnels_color_trigger");

  level thread tunnels_rain();
  level thread tunnels_end();

  flag_wait("tunnels_foley_dialogue");
  delayThread(9, maps\_ambient::set_ambience_blend_over_time, 6, "dcemp_heavy_rain_int", "dcemp_heavy_rain_tunnel");

  flag_wait_either("tunnels_door_open", "tunnels_teleport_done");
  if(flag("tunnels_door_open")) {
    activate_trigger_with_targetname("pre_teleport_color_trigger");
    level.foley delayThread(7, ::enable_ai_color);
    level.dunn delayThread(4, ::enable_ai_color);
  }

  level waittill("wait_for_ever");
}

tunnels_end() {
  trigger = getent("tunnels_teleport_trigger", "targetname");
  trigger waittill("trigger");

  wait 1;

  maps\_loadout::SavePlayerWeaponStatePersistent("dcemp");

  if(is_default_start()) {
    nextmission();
  } else
    IPrintLnBold("DEVELOPER: END OF SCRIPTED LEVEL");
}

tunnels_rain() {
  flag_wait("tunnels_indoor");
  flag_clear("_weather_lightning_enabled");

  flag_wait("tunnels_teleport_done");
  flag_set("_weather_lightning_enabled");
}

tunnels_door_scene() {
  level endon("tunnels_teleport");

  anim_ent = getent("tunnel_door_animent", "targetname");
  door_ent = tunnels_door_setup(anim_ent);

  flag_wait("tunnels_main");
  flag_wait("tunnels_door_start");
  level thread tunnels_friendlies_teleport();

  guys = [];
  guys[0] = level.dunn;
  guys[1] = door_ent;

  level threadtunnels_door_scene_interrupt(anim_ent);

  level.dunn walkdist_zero();
  level.foley walkdist_zero();

  anim_ent anim_reach_solo(level.foley, "DCemp_door_sequence_foley_approch");
  anim_ent add_func(::anim_single_solo, level.foley, "DCemp_door_sequence_foley_approch");
  anim_ent add_func(::anim_loop_solo, level.foley, "DCemp_door_sequence_foley_idle", "foley_idle_end");
  level thread do_funcs();

  anim_ent anim_reach_solo(level.dunn, "DCemp_door_sequence");
  anim_ent anim_single(guys, "DCemp_door_sequence");

  flag_set("tunnels_door_open");

  anim_ent notify("foley_idle_end");
  anim_ent thread anim_single_solo(level.foley, "DCemp_door_sequence_foley_wave");
  level.foley setgoalpos(level.foley.origin);
}

tunnels_door_scene_interrupt(anim_ent) {
  flag_wait("tunnels_teleport");
  anim_ent notify("foley_idle_end");

  level.dunn anim_stopanimscripted();
  level.foley anim_stopanimscripted();
}

tunnels_door_setup(anim_ent) {
  anim_ent_2 = getent("tunnel_door_animent_2", "targetname");

  door_ent = spawn_anim_model("tunnel_door", anim_ent.origin);

  brush_door = getent("tunnel_door", "targetname");
  brush_door linkto(door_ent);

  brush_door connectpaths();

  anim_ent anim_first_frame_solo(door_ent, "DCemp_door_sequence");

  return door_ent;
}

tunnels_friendlies_teleport() {
  flag_wait("tunnels_door_teleport");

  foley_dest = getstruct("tunnels_door_foley", "script_noteworthy");
  dunn_dest = getstruct("tunnels_door_dunn", "script_noteworthy");

  volume = getent("tunnels_door_volume", "targetname");
  if(!level.foley IsTouching(volume))
    level.foley ForceTeleport(foley_dest.origin, foley_dest.angles);
  if(!level.dunn IsTouching(volume))
    level.dunn ForceTeleport(dunn_dest.origin, dunn_dest.angles);
}

tunnels_dialogues() {
  flag_wait("tunnels_indoor");

  level.team["marine1"] dialogue_queue("dcemp_ar1_feetdry");

  wait 0.5;

  level.dunn dialogue_queue("dcemp_cpd_huah3");

  level.foley dialogue_queue("dcemp_fly_cutchatter");

  flag_wait("tunnels_door_start");
  flag_set("dc_emp_bunker");

  level.dunn waittill_any_timeout(4, "goal");

  flag_wait("tunnels_foley_dialogue");

  wait .65;

  level.foley dialogue_queue("dcemp_fly_fortourists");

  flag_wait("tunnels_teleport_done");
  wait 0.5;

  flag_wait("whitehouse_ambience");

  level.dunn dialogue_queue("dcemp_cpd_partystarted");

  level.foley dialogue_queue("dcemp_fly_rogerstayfrosty");
}

tunnels_dead_guy() {
  self remove_drone_weapon();
  animent = getent(self.target, "targetname");
  animent anim_generic_first_frame(self, "death_sitting_pose_v1");

  flag_wait("tunnels_dunn_anim_end");
  self delete();
}

tunnels_dead_check() {
  level endon("tunnels_teleport");
  level endon("tunnels_dunn_anim_end");

  self.animname = "dead_guy";
  self remove_drone_weapon();

  animent = getent(self.target, "targetname");
  animent thread anim_loop_solo(self, "hunted_woundedhostage_idle_start");

  level thread tunnels_dead_check_clear(self, animent);

  flag_wait("tunnels_main");
  wait 0.1;
  flag_wait("tunnels_dead_check");

  level.dunn disable_ai_color();
  level.dunn walkdist_zero();

  animent anim_reach_solo(level.dunn, "hunted_woundedhostage_check");
  animent anim_stopanimscripted();

  guys = [];
  guys[0] = level.dunn;
  guys[1] = self;

  level.dunn walkdist_reset();

  animent anim_single(guys, "hunted_woundedhostage_check");
  animent thread anim_first_frame_solo(self, "hunted_woundedhostage_idle_end");

  level.dunn enable_ai_color();
  animent anim_single_solo(level.dunn, "hunted_woundedhostage_check_soldier_end");
  level notify("tunnels_dead_check_done");
}

tunnels_dead_check_clear(drone, animent) {
  level endon("tunnels_dead_check_done");

  flag_wait("tunnels_dunn_anim_end");
  level.dunn anim_stopanimscripted();
  if(flag("tunnels_main"))
    level.dunn enable_ai_color();

  drone anim_stopanimscripted();
  animent anim_stopanimscripted();
  drone delete();
}

vision_set_tunnels() {
  flag_clear("spotlight_lightning");
  thread lerp_saveddvar("r_specularColorScale", 2.5, 2);
  lights = getEntArray("parking_lighting_primary", "script_noteworthy");
  array_call(lights, ::setLightIntensity, 0);

  thread maps\_utility::set_vision_set("dcemp_tunnels", 4);
  thread maps\_utility::vision_set_fog_changes("dcemp_tunnels", 4);
}