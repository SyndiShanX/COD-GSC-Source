/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_panic_room.gsc
*************************************************/

start() {
  maps\oilrocks_infantry_code::infantry_teleport_start("infantry_panic_room_start");
  level.panic_room_startpoint = 1;
  maps\_utility::delaythread(1, maps\_utility::music_stop);
}

start2() {
  maps\oilrocks_infantry_code::infantry_teleport_start("infantry_panic_room2_start");
  level.panic_room_startpoint = 1;
  thread choppers_setup();
  maps\_utility::delaythread(1, maps\_utility::music_stop);
  spawn_rorke();
  vacate_enemies();
  level.keegan thread dude_kicks_in_the_door_setup(1);
  level.merrick thread guy_goes_to_struct_animates("breach_stance_right_one", "pre_breach_set", 1);
  level.hesh thread guy_goes_to_struct_animates("breach_stance_right_two", "pre_breach_set", 1);
}

start_chopper_test() {
  level.testingapache_animations = 1;
  start2();
}

main_chopper_test() {}

main() {
  common_scripts\utility::flag_wait("FLAG_rorke_triggered");
  thread maps\_utility::battlechatter_off();
  thread choppers_setup();
  spawn_rorke();
  thread vacate_enemies();
  thread dudes_in_place_cover();
  common_scripts\utility::flag_wait("FLAG_enemies_at_breach_vacated");
  level.keegan thread dude_kicks_in_the_door_setup();
}

main2() {
  rorke_take_down();

  if(!isalive(level.rorke)) {
    level waittill("forever_cause_rork_is_dead_and_mission_fails");
  }

  if(!isDefined(level.panic_room_startpoint)) {
    maps\_utility::nextmission();
  }
  else {
    iprintlnbold("started at panic room, skipping nextmission!");
  }
}

dudes_in_place_cover() {
  var_0 = [level.merrick, level.hesh];
  var_1 = common_scripts\utility::getstruct("panic_room_node", "targetname");
  level.merrick thread announce_past_those_doors();
  common_scripts\utility::flag_wait("FLAG_enemies_at_breach_vacated");
  level.merrick thread guy_goes_to_struct_animates("breach_stance_right_one", "pre_breach_set");
  level.hesh thread guy_goes_to_struct_animates("breach_stance_right_two", "pre_breach_set");
}

guy_goes_to_struct_animates(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct(var_0, "targetname");
  self.idle_struct_animating_node = var_3;
  getent("payer_in_breach_zone", "targetname") endon("trigger");

  if(isDefined(var_2)) {
    return;
  }
  var_3 maps\_anim::anim_reach_solo(self, var_1);
  var_3 thread maps\_anim::anim_loop_solo(self, var_1, "dude_kicking_in_door");
}

dude_kicks_in_the_door_setup(var_0) {
  level.keegan thread guy_goes_to_struct_animates("breach_stance", "pre_breach_set", var_0);
  getent("payer_in_breach_zone", "targetname") waittill("trigger");
  dude_kicks_in_the_door();
}

dude_kicks_in_the_door() {
  level.merrick.idle_struct_animating_node notify("dude_kicking_in_door");
  level.hesh.idle_struct_animating_node notify("dude_kicking_in_door");
  level.keegan.idle_struct_animating_node notify("dude_kicking_in_door");
  var_0 = common_scripts\utility::getstruct("door_kick_node", "targetname");
  var_0 maps\_anim::anim_reach_solo(self, "dude_door_kick");
  common_scripts\utility::flag_set("FLAG_dude_kicked_the_door");
  level.player common_scripts\utility::delaycall(0.8, ::setclienttriggeraudiozonepartial, "oilrocks_ground_end_hallway_scene", "mix");
  var_0 maps\_anim::anim_single_solo(self, "dude_door_kick");
}

announce_past_those_doors() {
  common_scripts\utility::flag_wait("FLAG_enemies_at_breach_vacated");
  var_0 = common_scripts\utility::getstruct("door_kick_node", "targetname");

  while(distance(self.origin, var_0.origin) > 500) {
    wait 0.05;
  }

  maps\_utility::smart_dialogue("oilrocks_mrk_hesjustpastthose");
}

blackhawk_into_position() {
  var_0 = common_scripts\utility::getstruct("blackhawk_panic_room_entrance", "targetname");
  var_1 = maps\oilrocks_apache_code::get_blackhawk_ally();

  if(!isDefined(var_1)) {
    var_1 = maps\oilrocks_apache_code::spawn_blackhawk_ally("blackhawk_panic_room_entrance", undefined, undefined, 0);
  }

  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_1 vehicle_teleport(var_0.origin, vectortoangles(var_2.origin - var_0.origin));
  var_1 vehicle_turnengineoff();
}

choppers_setup() {
  maps\oilrocks_apache_code::spawn_apache_allies("apache_panic_room_ally0");
  var_0 = maps\oilrocks_apache_code::get_apache_ally(1);
  var_1 = maps\oilrocks_apache_code::get_apache_ally(2);
  stop_chopper_bosses();
  var_0 thread chopper_start_at_path("apache_panic_room_ally01");
  var_1 thread chopper_start_at_path("apache_panic_room_ally02");
  maps\_utility::array_delete(getEntArray("script_vehicle_hind_battle_oilrocks", "classname"));
  maps\_utility::array_delete(getEntArray("script_vehicle_zpu4_oilrocks", "classname"));
}

chopper_start_at_path(var_0) {
  var_1 = common_scripts\utility::getstruct(var_0, "targetname");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin;
  maps\_vehicle::vehicle_paths(var_2);
  self vehicle_turnengineoff();
}

stop_chopper_bosses() {
  var_0 = maps\oilrocks_apache_code::get_apache_ally(1);
  var_1 = maps\oilrocks_apache_code::get_apache_ally(2);
  level notify("stop_chopper_boss_forever");
  var_0 clearlookatent();
  var_1 clearlookatent();
  var_0 cleartargetyaw();
  var_1 cleartargetyaw();
  var_0 maps\_vehicle::mgoff();
  var_1 maps\_vehicle::mgoff();
}

choppers_fly_in() {
  var_0 = common_scripts\utility::getstruct("blackhawk_panic_room_entrance", "targetname");
  var_1 = maps\oilrocks_apache_code::get_blackhawk_ally();

  if(!isDefined(level.testingapache_animations)) {
    var_1 maps\_utility::delaythread(3, maps\_vehicle::vehicle_paths, var_0);
  }

  var_1 vehicle_turnengineon();
  var_2 = maps\oilrocks_apache_code::get_apache_ally(1);
  var_3 = maps\oilrocks_apache_code::get_apache_ally(2);
  stop_chopper_bosses();
  var_2 vehicle_turnengineon();
  var_3 vehicle_turnengineon();

  if(!isDefined(level.testingapache_animations)) {
    var_2 thread maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("apache_panic_room_ally01", "targetname"));
    var_3 maps\_vehicle::vehicle_paths(common_scripts\utility::getstruct("apache_panic_room_ally02", "targetname"));
    common_scripts\utility::flag_set("FLAG_choppers_arrived");
    return;
  }

  var_4 = [var_1, var_2, var_3];
  var_1.animname = "silenthawk";
  var_2.animname = "apache_1";
  var_3.animname = "apache_2";
  var_5 = common_scripts\utility::getstruct("chopper_fly_in_node", "targetname");
  common_scripts\utility::array_thread(var_4, maps\_vehicle_code::suspend_drive_anims);
  var_6 = var_1 maps\_utility::getanim("choppers_fly_in");
  var_7 = getanimlength(var_6);
  maps\_utility::delaythread(var_7 - 2, common_scripts\utility::flag_set, "FLAG_choppers_arrived");
  var_5 maps\_anim::anim_single(var_4, "choppers_fly_in");
}

_precache() {
  common_scripts\utility::flag_init("FLAG_rorke_triggered");
  common_scripts\utility::flag_init("FLAG_guys_in_circle");
  common_scripts\utility::flag_init("FLAG_dudes_ready_for_door_kick");
  common_scripts\utility::flag_init("FLAG_dude_kicked_the_door");
  common_scripts\utility::flag_init("FLAG_enemies_at_breach_vacated");
  common_scripts\utility::flag_init("FLAG_choppers_arrived");
  maps\oilrocks_infantry_panic_room_anim::main();
}

spawn_rorke() {
  level.rorke = maps\_utility::spawn_targetname("rorke", 1);
  level.rorke.health = 1;
  level.rorke.ignoreall = 1;
  level.rorke.ignoreme = 1;
  level.rorke.animname = "rorke";
  level.rorke.team = "neutral";
  level.rorke.a.nodeath = 1;
  level.rorke.flashbangimmunity = 1;
  level.rorke thread fail_mission_on_death();
  var_0 = "panic_room";
  var_1 = common_scripts\utility::getstruct("panic_room_node", "targetname");
  var_1 maps\_anim::anim_first_frame([level.rorke], var_0);
}

fail_mission_on_death() {
  self.forceragdollimmediate = 1;
  self.ragdoll_directionscale = 100;
  self waittill("death");
  thread ragdollme();
  missionfail_rorke();
}

ragdollme() {
  while(!self isragdoll()) {
    self startragdoll();
    wait 0.05;
  }
}

missionfail_rorke() {
  level.player endon("death");

  if(!isalive(level.player)) {
    return;
  }
  level endon("mine death");
  level notify("mission failed");
  level notify("friendlyfire_mission_fail");
  waittillframeend;
  setsaveddvar("hud_missionFailed", 1);

  if(isDefined(level.player.failingmission)) {
    return;
  }
  maps\_player_death::set_deadquote(&"OILROCKS_FAILED_TO_CAPTURE_RORKE");
  maps\_utility::missionfailedwrapper();
}

rorke_take_down() {
  var_0 = [level.merrick, level.rorke, level.hesh];

  foreach(var_2 in var_0) {
    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
  }

  if(maps\_utility::obj_exists("find_rorke")) {
    maps\_utility::objective_complete(maps\_utility::obj("find_rorke"));
  }

  common_scripts\utility::flag_wait("FLAG_dude_kicked_the_door");

  if(!isalive(level.rorke)) {
    return;
  }
  level.rorke endon("death");
  level.rorke.team = "axis";
  level.rorke setCanDamage(1);
  thread keegan_stands_behind_desk();
  var_4 = "panic_room";
  var_5 = common_scripts\utility::getstruct("panic_room_node", "targetname");
  var_5 thread anim_reach_failsafe_hideprint(var_0, 10);
  var_6 = spawnStruct();
  var_6.origin = maps\_utility::add_z(var_5.origin, -10);
  var_6.angles = var_5.angles;
  thread choppers_in_position();
  var_6 anim_reach_together_local(var_0, var_4);
  maps\_utility::delaychildthread(9, ::window_crash);
  var_5 thread maps\_anim::anim_single(var_0, var_4);
  level.rorke thread maps\_utility::play_sound_on_tag("oilrocks_rke_outro_efforts", "J_Neck");
  level.merrick thread maps\_utility::play_sound_on_tag("oilrocks_mrk_outro_efforts", "J_Neck");
  level.merrick maps\_utility::delaychildthread(15, ::stop_notetracks);
  level.rorke maps\_utility::delaychildthread(12, ::stop_notetracks);
  level.rorke.allowdeath = 1;
  dialogue();
}

anim_reach_failsafe_hideprint(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0) {
    thread maps\_anim::anim_reach_failsafe(var_3, var_1);
    }

    return;
  }

  var_3 = var_0;
  var_3 endon("new_anim_reach");
  wait(var_1);
  var_3 notify("goal");
}

anim_reach_together_local(var_0, var_1, var_2, var_3) {
  thread modify_moveplaybackrate_together_local(var_0);
  maps\_anim::anim_reach_with_funcs(var_0, var_1, var_2, var_3, maps\_anim::reach_with_standard_adjustments_begin, maps\_anim::reach_with_standard_adjustments_end);
  self notify("stop_modifying_moveplayback");
}

modify_moveplaybackrate_together_local(var_0) {
  self endon("stop_modifying_moveplayback");
  var_1 = 0.3;
  waittillframeend;

  for(;;) {
    var_0 = maps\_utility::remove_dead_from_array(var_0);
    var_2 = [];
    var_3 = 0;

    foreach(var_8, var_5 in var_0) {
      var_5.goalradius = 32;
      var_6 = var_5.goalpos;

      if(isDefined(var_5.reach_goal_pos)) {
        var_6 = var_5.reach_goal_pos;
      }

      var_7 = distance2d(var_5.origin, var_6);
      var_2[var_5.unique_id] = var_7;

      if(var_7 <= 4) {
        var_0[var_8] = undefined;
        continue;
      }

      var_3 = var_3 + var_7;
    }

    if(var_0.size <= 1) {
      break;
    }

    var_3 = var_3 / var_0.size;

    foreach(var_5 in var_0) {
      var_10 = var_2[var_5.unique_id] - var_3;
      var_11 = var_10 * 0.003;

      if(var_11 > var_1) {
        var_11 = var_1;
      }
      else if(var_11 < var_1 * -1) {
        var_11 = var_1 * -1;
      }

      var_5.moveplaybackrate = 1 + var_11;
    }

    wait 0.05;
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5)) {
      var_5.moveplaybackrate = 1;
    }
  }
}

stop_notetracks() {
  self notify("stop_sequencing_notetracks");
}

keegan_goes_behind_the_door() {
  var_0 = "panic_room";
  var_1 = common_scripts\utility::getstruct("panic_room_node", "targetname");
  var_1 maps\_anim::anim_reach([level.keegan], "keegan_jumps_out_window");
  wait 20;
  var_1 maps\_anim::anim_single([level.keegan], "keegan_jumps_out_window");
}

keegan_stands_behind_desk() {
  var_0 = common_scripts\utility::getstruct("keegan_stands_here", "targetname");
  level.keegan maps\_utility::set_goal_pos(var_0.origin);
  level.keegan maps\_utility::set_goal_radius(128);
  level.keegan waittill("goal");
  level.keegan orientmode("face angle", var_0.angles[1]);
}

choppers_in_position() {
  blackhawk_into_position();
}

window_crash() {
  if(!isalive(level.rorke)) {
    return;
  }
  level.rorke endon("death");
  thread common_scripts\utility::play_sound_in_space("scn_oilrocks_ending_window_bust", (17048.6, 6957.76, 1558));
  common_scripts\utility::exploder("rorke_smash_glass");
  var_0 = getglassarray("rorke_glass");
  var_1 = getglassorigin(var_0[0]);

  foreach(var_3 in var_0) {
  destroyglass(var_3, anglesToForward(level.rorke.angles));
  }
}

dialogue() {
  var_0 = gettime();
  maps\_utility::wait_for_buffer_time_to_pass(var_0, 11);
  var_1 = common_scripts\utility::ter_op(isDefined(level.testingapache_animations), 7, 1);
  maps\_utility::delaythread(var_1, ::choppers_fly_in);
  wait 2;
  level.merrick maps\_utility::smart_dialogue("oilrocks_mrk_piratetheballoonsup");
  maps\_utility::smart_radio_dialogue("oilrocks_plt_rogerthatwereinbound");
  wait 1;
  thread maps\_hud_util::fade_out(1.5, "black");
}

vacate_enemies() {
  maps\_utility::array_delete(getEntArray("trigger_multiple_spawn", "classname"));
  maps\_utility::array_delete(getspawnerteamarray("axis"));
  thread maps\_utility::ai_delete_when_out_of_sight(getaiarray("axis"), 750);
  getent("enemy_clearance", "targetname") maps\_utility::waittill_volume_dead_or_dying();
  wait 0.05;
  common_scripts\utility::flag_set("FLAG_enemies_at_breach_vacated");
}