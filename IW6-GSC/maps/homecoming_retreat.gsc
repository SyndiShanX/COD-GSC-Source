/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_retreat.gsc
***************************************/

retreat_spawn_functions() {
  maps\_utility::array_spawn_function_targetname("tower_hesco_guys", ::tower_entrance_hesco_guys);
  maps\_utility::array_spawn_function_targetname("tower_entrance_attackers", ::tower_entrance_attackers_think);
  maps\_utility::array_spawn_function_noteworthy("tower_retreaters", ::tower_retreaters);
  maps\_utility::array_spawn_function_targetname("tower_nh90_guys", ::tower_nh90_guys);
  maps\_utility::array_spawn_function_noteworthy("elias_street_dead_runners", ::elias_street_dead_runners);
  maps\_utility::array_spawn_function_targetname("tower_courtyard_advancing_mid_flooders", ::tower_courtyard_advancing_mid_flooders);
  getent("elias_street_artemis", "targetname") maps\_utility::add_spawn_function(::elias_street_artemis);
  maps\_utility::array_spawn_function_targetname("tower_retreat_hind", ::tower_retreat_hind);
  maps\_utility::array_spawn_function_noteworthy("retreat_hovercraft", ::retreat_hovercraft);
}

tower_retreat_sequence() {
  level.mortarearthquakeradius = 3000;
  level.mortarwithinfov = cos(65);
  level.mortarmininterval = 0.2;
  level.mortarmaxinterval = 0.5;
  level.nomaxmortardist = undefined;
  level.mortar_min_dist = 400;
  level.mortar_max_dist = 1000;
  level.mortarexcluders = [level.player, level.hesh];
  common_scripts\utility::flag_wait("FLAG_start_tower_retreat");
  var_0 = getEntArray("tower_post_explosion_trigs", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, common_scripts\utility::trigger_on);
  thread tower_dialogue();
  var_1 = maps\_utility::array_spawn(getEntArray("trench_retreat_enemies_1", "targetname"));

  foreach(var_3 in var_1) {
    var_3 maps\homecoming_util::set_ai_array("tower_entrance_attackers");
    level.mortarexcluders = common_scripts\utility::array_add(level.mortarexcluders, var_3);
  }

  level.mortarexcluders = [level.player, level.hesh];
  thread maps\homecoming_util::set_mortar_on(16);
  thread tower_entrance_door();
  thread tower_sprinker_screeneffect();
  thread tower_helicopter_flyover();
  thread tower_entrance_fakeshooters();
  thread tower_entrance_attackers();
  thread tower_hesh_help_wounded();
  thread tower_firefighter();
  thread tower_dying_guy();
  thread tower_pickup_b();
  thread maps\homecoming_util::create_dead_guys("tower_dead_bodies", "TRIGFLAG_tower_entrance");
  thread tower_courtyard_advancing_enemies();
  level.player thread maps\_utility::ignore_me_timer(5);
  thread tower_hesh_wave();
  common_scripts\utility::flag_wait("TRIGFLAG_kill_tower_attackers");
  level notify("stop_main_friendlies_respawning");
  var_5 = maps\homecoming_util::get_ai_array("trench_main_friendlies");
  var_5 = common_scripts\utility::array_remove(var_5, level.hesh);
  thread maps\homecoming_util::kill_over_time(var_5, 5, 10);
  var_6 = maps\homecoming_util::get_ai_array("tower_entrance_attackers");
  thread maps\homecoming_util::kill_over_time(var_6, 8, 15);
  common_scripts\utility::flag_wait("TRIGFLAG_tower_entrance");
  thread maps\homecoming_util::ambient_smallarms_fire("tower_courtyard_fakefire", "tower_fakefire_stop");
  thread maps\_utility::music_play("mus_homecoming_tower_battle");
  maps\_utility::array_spawn(getEntArray("tower_retreat_runners", "targetname"));
  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_tower");
  maps\_utility::array_spawn(getEntArray("tower_retreat_runners_murdered", "targetname"));
  maps\_utility::array_spawn(getEntArray("tower_courtyard_enemies", "targetname"));
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "FLAG_start_retreat_paths");
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, "tower_start_mortars");
  maps\_utility::do_wait_any();
  level notify("tower_fakefire_stop");
  thread tower_retreat_mortars();
  thread tower_retreat_mortar_kill_player();
  var_7 = maps\homecoming_util::get_ai_array("tower_courtyard_enemies");
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, "player_leaving_tower_trig_3");
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "FLAG_start_retreat_paths");
  maps\_utility::do_wait_any();

  if(!common_scripts\utility::flag("FLAG_start_retreat_paths"))
    common_scripts\utility::flag_set("FLAG_start_retreat_paths");

  maps\homecoming_util::notify_trigger(getent("player_leaving_tower_trig_3", "targetname"));
  thread maps\homecoming_util::kill_over_time(maps\homecoming_util::get_ai_array("tower_courtyard_enemies"), 0.5, 2);
  level.hesh maps\homecoming_util::ignore_everything();
  thread tower_mortar_allow_target_ai();

  if(isDefined(level.hovercrafts)) {
    level.hovercrafts = common_scripts\utility::array_removeundefined(level.hovercrafts);

    foreach(var_9 in level.hovercrafts) {
      if(!isDefined(var_9.i_delete_myself))
        var_9 delete();
    }
  }

  level notify("stop_tower_flyovers");
  common_scripts\utility::flag_set("FLAG_start_elias_street");
}

tower_dialogue() {
  common_scripts\utility::flag_wait("FLAG_tower_explosion_done");
  wait 1.5;
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_dronecontrolcomein");
  common_scripts\utility::flag_set("FLAG_start_retreat_friendly_movement");
  common_scripts\utility::flag_wait("FLAG_hesh_retreat_wave_dialog");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_shitcomeonlets");
  common_scripts\utility::flag_wait("FLAG_tower_entrance_enemies_dead");

  if(!common_scripts\utility::flag("TRIGFLAG_tower_entrance"))
    level.hesh maps\_utility::dialogue_queue("homcom_hsh_thatsthelastof");

  common_scripts\utility::flag_wait("TRIGFLAG_tower_entrance");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_commandthisisraptor_2");
  maps\_utility::smart_radio_dialogue("homcom_com_allunitsthisis");
  common_scripts\utility::flag_set("FLAG_start_retreat_paths");

  for(;;) {
    level.retreat_waver waittill("starting_anim", var_0);

    if(var_0 == "payback_escape_forward_wave_right_price") {
      break;
    }
  }

  level.retreat_waver maps\_utility::dialogue_queue("homcom_us3_fallbackfallback");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_comeonadamwe");
}

tower_sprinker_screeneffect() {
  var_0 = getent("tower_sprinkler_trigger", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = level.player getEye();
    var_1.angles = level.player.origin;
    var_1 linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
    playFXOnTag(common_scripts\utility::getfx("sprinkler_screeneffect"), var_1, "tag_origin");

    while(level.player istouching(var_0))
      wait 0.05;

    stopFXOnTag(common_scripts\utility::getfx("sprinkler_screeneffect"), var_1, "tag_origin");
    var_1 delete();
  }
}

tower_entrance_door() {
  thread maps\homecoming_util::function_trigger_switch("tower_mid_trigger", "tower_entrance_trigger", ::tower_entrance_door_close_true, ::tower_entrance_door_close_false, "tower_garage_door_closed");
  var_0 = getent("trench_tower_garage_entrance", "targetname");
  var_1 = var_0.origin;
  var_0 moveto(var_0.origin + (0, 0, 75), 1, 0.5, 0);
  var_0 connectpaths();
  common_scripts\utility::exploder("tower_entrance_smoke");
  common_scripts\utility::flag_wait_any("FLAG_tower_entrance_enemies_dead", "TRIGFLAG_player_entering_tower");
  maps\_utility::stop_exploder("tower_entrance_smoke");
  common_scripts\utility::exploder("tower_entrance_smoke_light");
  common_scripts\utility::flag_wait("FLAG_allow_garage_door_close");
  var_2 = cos(65);
  var_3 = getent("player_in_tower_check", "targetname");

  for(;;) {
    if(common_scripts\utility::flag("FLAG_allow_garage_door_close")) {
      if(!maps\_utility::within_fov_2d(level.player getEye(), level.player.angles, var_0.origin, var_2)) {
        if(!common_scripts\utility::flag("FLAG_hesh_inside_tower")) {
          if(!maps\_utility::within_fov_2d(level.player getEye(), level.player.angles, level.hesh.origin + (0, 0, 80), var_2)) {
            break;
          }
        } else
          break;
      }
    }

    wait 0.05;
  }

  maps\_utility::stop_exploder("tower_entrance_smoke_light");
  var_0.origin = var_1;
  var_0 disconnectpaths();
  var_4 = common_scripts\utility::getstruct("hesh_inside_tower_struct", "targetname");

  if(!common_scripts\utility::flag("FLAG_hesh_inside_tower")) {
    level.hesh forceteleport(var_4.origin, var_4.angles);
    level.hesh notify("stop_path");
    level.hesh thread maps\_utility::follow_path_and_animate(var_4, 0);
  }

  level notify("tower_garage_door_closed");
  level notify("stop_mortars 16");
}

tower_entrance_door_close_true() {
  common_scripts\utility::flag_set("FLAG_allow_garage_door_close");
}

tower_entrance_door_close_false() {
  common_scripts\utility::flag_clear("FLAG_allow_garage_door_close");
}

tower_entrance_attackers() {
  common_scripts\utility::exploder("tower_entrance_smoke");
  var_0 = getEntArray("tower_entrance_respawners", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::tower_entrance_attackers_think);
    var_2.spawningguy = 0;
  }

  level.tower_entrance_respawners = var_0;
  var_4 = getent("tower_attackers_target", "targetname");
  var_5 = maps\_utility::array_spawn(getEntArray("tower_entrance_attackers", "targetname"));

  foreach(var_7 in var_5)
  var_7 setentitytarget(var_4);

  common_scripts\utility::flag_wait("TRIGFLAG_kill_tower_attackers");
  var_9 = getent("tower_entrance_goalvolume", "targetname");
  var_5 = maps\_utility::array_removedead_or_dying(var_5);

  foreach(var_7 in var_5) {
    var_7 clearentitytarget();
    var_7 setgoalvolumeauto(var_9);
  }

  var_4 delete();
}

tower_entrance_attackers_think() {
  level endon("tower_attackers_stop");
  level.mortarexcluders = common_scripts\utility::array_add(level.mortarexcluders, self);
  maps\homecoming_util::set_ai_array("tower_entrance_attackers");
  self waittill("death");
  var_0 = undefined;

  for(;;) {
    level.tower_entrance_respawners = common_scripts\utility::array_removeundefined(level.tower_entrance_respawners);

    if(level.tower_entrance_respawners.size == 0) {
      return;
    }
    var_1 = level.tower_entrance_respawners;

    foreach(var_3 in var_1) {
      if(var_3.count == 0) {
        continue;
      }
      if(var_3.spawningguy == 1)
        var_1 = common_scripts\utility::array_remove(var_1, var_3);
    }

    var_0 = common_scripts\utility::random(level.tower_entrance_respawners);
    var_0.spawningguy = 1;
    var_5 = var_0 maps\_utility::spawn_ai();
    common_scripts\utility::waitframe();
    var_0.spawningguy = 0;

    if(isDefined(var_5)) {
      break;
    }

    wait 0.2;
  }

  if(var_0.count == 0)
    level.tower_entrance_respawners = common_scripts\utility::array_remove(level.tower_entrance_respawners, var_0);

  if(level.tower_entrance_respawners.size == 0)
    level notify("tower_attackers_stop");
}

tower_entrance_fakeshooters() {
  thread maps\homecoming_util::ambient_smallarms_fire("tower_fake_shootspot", "stop_tower_entrance_shooters", 0.1, 0.2, "mg_tracer");
  common_scripts\utility::flag_wait_any("FLAG_tower_entrance_enemies_dead", "TRIGFLAG_tower_entrance");
  level notify("stop_tower_entrance_shooters");
}

tower_hesh_wave() {
  level.hesh maps\_utility::disable_ai_color();
  var_0 = getnode("hesh_wave_tele_node", "targetname");
  level.hesh maps\_utility::teleport_ai(var_0);
  level.hesh maps\homecoming_util::disable_arrivals_and_exits(0);
  level.hesh maps\homecoming_util::ignore_everything();
  common_scripts\utility::flag_wait("FLAG_start_retreat_friendly_movement");
  var_1 = common_scripts\utility::getstruct("tower_hesh_wavespot", "targetname");
  var_1 maps\_anim::anim_reach_solo(level.hesh, "tower_hesh_wave");
  common_scripts\utility::flag_set("FLAG_hesh_retreat_wave_dialog");
  var_1 maps\_anim::anim_single_solo(level.hesh, "tower_hesh_wave");
  level.hesh maps\_utility::enable_ai_color();
  level.hesh maps\homecoming_util::clear_ignore_everything();
  maps\homecoming_util::notify_trigger(getent("post_explosion_movetrig_start", "script_noteworthy"));
}

tower_retreaters() {
  var_0 = self.spawner;
  self endon("death");
  maps\_utility::disable_long_death();
  self.grenadeawareness = 0;
  level.tower_retreaters = common_scripts\utility::array_add(level.tower_retreaters, self);

  if(isDefined(var_0.targetname) && var_0.targetname == "tower_retreat_runners_murdered") {
    maps\homecoming_util::disable_arrivals_and_exits();
    maps\homecoming_util::ignore_everything();
  }

  maps\_utility::magic_bullet_shield(1);
  var_1 = maps\_utility::getent_or_struct_or_node(var_0.script_linkto, "script_linkname");
  thread maps\_utility::follow_path_and_animate(var_1, 0);

  if(maps\homecoming_util::parameters_check("sprint"))
    maps\_utility::enable_sprint();
  else if(maps\homecoming_util::parameters_check("combat_jog"))
    maps\_utility::set_generic_run_anim("combat_jog");
  else if(maps\homecoming_util::parameters_check("scared_run")) {
    maps\_utility::set_generic_run_anim("scared_run");
    maps\_utility::set_moveplaybackrate(0.9);
  }

  if(maps\homecoming_util::parameters_check("killme")) {
    wait(randomfloatrange(2, 3));
    maps\homecoming_util::kill_safe();
  }

  common_scripts\utility::flag_wait("FLAG_start_retreat_paths");
  maps\homecoming_util::ignore_everything();
}

tower_hesh_help_wounded() {
  common_scripts\utility::flag_wait_any("FLAG_tower_entrance_enemies_dead", "TRIGFLAG_tower_entrance");
  var_0 = getent("tower_inside_wounded_hesh", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1.animname = "wounded";
  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 thread maps\_anim::anim_generic_loop(var_1, "tower_pickup_wounded_idle");
  var_3 = getnode("hesh_retreat_path", "targetname");
  level.hesh thread maps\_utility::follow_path_and_animate(var_3, 0);
  level.hesh maps\homecoming_util::ignore_everything();
  thread maps\homecoming_util::func_waittill_msg(level.hesh, "at_tower_node", maps\homecoming_util::clear_ignore_everything);

  for(;;) {
    level.hesh waittill("starting_anim", var_4);

    if(var_4 == "tower_pickup_soldier") {
      break;
    }
  }

  var_2 notify("stop_loop");
  var_1 maps\_utility::anim_stopanimscripted();
  var_2 maps\_anim::anim_generic_run(var_1, "tower_pickup_wounded");
  var_5 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");
  var_1 thread maps\_utility::follow_path_and_animate(var_5, 0);
  var_1 maps\homecoming_util::ignore_everything();
}

tower_pickup_b() {
  common_scripts\utility::flag_wait("TRIGFLAG_tower_entrance");
  var_0 = getEntArray("tower_pickup_2_guys", "targetname");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    var_6 = var_5 maps\_utility::spawn_ai();
    var_6.movestruct = var_5 maps\homecoming_util::get_linked_struct();
    var_6 maps\_utility::magic_bullet_shield();
    var_6 maps\homecoming_util::ignore_everything();

    if(var_5 maps\homecoming_util::parameters_check("wounded")) {
      var_2 = var_6;
      var_1 = common_scripts\utility::getstruct(var_5.target, "targetname");
      level.tower_retreaters = common_scripts\utility::array_add(level.tower_retreaters, var_6);
      continue;
    }

    var_3 = var_6;
  }

  var_2.animname = "wounded";
  var_3.animname = "helper";
  level.retreat_waver = var_2;
  var_8 = [var_2, var_3];
  var_1 maps\_anim::anim_first_frame(var_8, "tower_pickup_b");

  while(!maps\_utility::player_looking_at(var_1.origin))
    wait 0.05;

  var_1 maps\_anim::anim_single_run(var_8, "tower_pickup_b");

  foreach(var_6 in var_8)
  var_6 thread maps\_utility::follow_path_and_animate(var_6.movestruct, 0);

  var_2.animname = "generic";
  var_3 waittill("path_end_reached");
  playFXOnTag(common_scripts\utility::getfx("headshot_blood"), var_3, "j_head");
  var_3 maps\homecoming_util::kill_safe();
}

tower_dying_guy() {
  common_scripts\utility::flag_wait("TRIGFLAG_tower_entrance");
  var_0 = getent("tower_dying_guy", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1.animname = "cougher";
  var_1 maps\_utility::magic_bullet_shield();
  var_2 = var_0 maps\homecoming_util::get_linked_struct();
  var_2 thread maps\_anim::anim_single_solo(var_1, "tower_coughing_death");
  common_scripts\utility::waitframe();
  var_2 maps\_anim::anim_set_time([var_1], "tower_coughing_death", 0.2);
  var_2 maps\_anim::anim_set_rate_single(var_1, "tower_coughing_death", 0);

  while(!maps\_utility::player_looking_at(var_1 gettagorigin("j_head")))
    wait 0.05;

  var_2 maps\_anim::anim_set_rate_single(var_1, "tower_coughing_death", 1);
  wait 5.6;
  var_2 maps\_anim::anim_set_rate_single(var_1, "tower_coughing_death", 0);
  var_1 maps\homecoming_drones::drone_setname("");
  var_1 notsolid();
}

tower_firefighter() {
  common_scripts\utility::flag_wait("TRIGFLAG_tower_entrance");
  var_0 = getent("tower_firefighter", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_1 maps\_utility::magic_bullet_shield();
  var_1.animname = "firefighter";
  var_2 = maps\_utility::spawn_anim_model("extinguisher");
  var_3 = [var_2, var_1];
  var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_4 thread maps\_anim::anim_loop(var_3, "extinguisher_loop");
  var_2 thread maps\homecoming_util::playloopingfx("extinguisher_spray", 0.1, undefined, "tag_fx", 1);
  var_5 = spawn("script_origin", var_2.origin);
  var_5 linkto(var_2);
  var_5 thread common_scripts\utility::play_loop_sound_on_entity("scn_home_fire_extinguisher");
  common_scripts\utility::flag_wait("FLAG_start_retreat_paths");
  var_2 notify("stop_looping_fx");
  var_4 notify("stop_loop");
  var_5 delete();
  var_4 maps\_anim::anim_single(var_3, "extinguisher_out");
  var_6 = var_0 maps\homecoming_util::get_linked_struct();
  var_1 maps\_utility::follow_path_and_animate(var_6, 0);
  var_1 maps\homecoming_util::kill_safe();
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  var_2 delete();
}

tower_explosion_guy() {
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, "tower_explosion_guy_trigger");
  maps\_utility::do_wait_any();
  var_0 = getent("tower_explosion_guy", "script_noteworthy");
  var_1 = var_0 maps\homecoming_util::get_linked_struct();
  var_2 = var_0 maps\_utility::spawn_ai();
  var_3 = common_scripts\utility::getstruct("tower_door_explosion_spot", "targetname");
  var_4 = anglesToForward(var_3.angles);
  playFX(common_scripts\utility::getfx("vfx_hallway_explosion"), var_3.origin, var_4);
  var_5 = getEntArray("tower_interior_doors", "targetname");

  foreach(var_7 in var_5) {
    var_7.originalangles = var_7.angles;

    if(var_7 maps\homecoming_util::parameters_check("left")) {
      var_7 rotateto(var_7.angles + (0, -95, 0), 0.15);
      continue;
    }

    var_7 rotateto(var_7.angles + (0, 90, 0), 0.15);
  }

  thread common_scripts\utility::play_sound_in_space("artillery_explosion", var_1.origin);
  var_1 thread maps\_anim::anim_generic(var_2, "tower_explosion_death");
  wait 0.15;

  foreach(var_7 in var_5) {
    var_10 = undefined;

    if(var_7 maps\homecoming_util::parameters_check("left"))
      var_10 = var_7.originalangles + (0, randomintrange(-10, 0), 0);
    else
      var_10 = var_7.originalangles + (0, randomintrange(0, 10), 0);

    var_7 rotateto(var_10, randomfloatrange(0.75, 1), 0, 0.5);
  }

  wait 0.85;
  var_2.allowdeath = 1;
  var_2.a.nodeath = 1;
  var_2 kill();
}

tower_broken_support() {
  var_0 = getent("tower_broken_support", "targetname");
  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_tower");
  earthquake(0.3, 0.8, var_0.origin, 800);
  wait 0.15;
  var_0 rotateto(var_0.angles + (0, 0, 17), 0.65, 0.6);
  var_0 waittill("movedone");
  var_0 rotateto(var_0.angles + (0, 0, -5), 0.65, 0.6);
}

tower_inside_hurt_guys() {
  var_0 = getEntArray("tower_inside_hurt_guys", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 maps\homecoming_util::get_linked_struct();
    var_5 = var_3 maps\_utility::spawn_ai();
    var_5 maps\_utility::gun_remove();
    var_5 maps\_utility::magic_bullet_shield(1);
    var_5.animname = "generic";
    var_5 thread maps\_anim::anim_generic_loop(var_5, "HC_wounded_D");
    var_1 = common_scripts\utility::array_add(var_1, var_5);
  }

  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_tower");
  var_7 = getEntArray("tower_inside_hurt_guys_helper", "targetname");
  var_8 = [];

  foreach(var_3 in var_7) {
    var_5 = var_3 maps\_utility::spawn_ai();
    var_5 maps\homecoming_util::ignore_everything();
    var_5 maps\_utility::magic_bullet_shield(1);
    var_8 = common_scripts\utility::array_add(var_8, var_5);
  }

  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  maps\_utility::array_delete(var_8);
  maps\_utility::array_delete(var_1);
}

tower_helicopter_flyover() {
  level endon("stop_tower_flyovers");
  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_tower");
  var_0 = getEntArray("tower_flyover_choppers", "targetname");

  for(;;) {
    var_1 = 0;
    var_2 = undefined;

    foreach(var_4 in var_0) {
      var_5 = 0;

      if(isDefined(var_4.script_wait))
        var_5 = var_4.script_wait;

      if(var_5 > var_1)
        var_1 = var_5;

      maps\_utility::delaythread(var_5, ::elias_street_helicopter_spawn, var_4, undefined);
    }

    wait(var_1 + randomfloatrange(1, 3));
  }
}

tower_retreat_hind() {
  self waittill("missile_fired", var_0);
  var_0 waittill("death");
  level.retreat_artemis notify("death");
  level.retreat_artemis maps\_vehicle::godoff();
}

tower_nh90_guys() {
  self endon("death");
  self waittill("jumpedout");
  var_0 = getent("tower_front_center_goalvolume", "targetname");
  self setgoalvolumeauto(var_0);
}

tower_retreat_mortars() {
  level endon("stop_tower_retreat_mortars");
  var_0 = level.tower_courtyard_mortars;
  var_1 = getent("tower_courtyard_mortar_volume", "targetname");
  var_2 = cos(50);
  var_3 = cos(35);
  var_4 = squared(200);
  var_5 = squared(700);
  var_6 = 1;
  level.tower_mortars_target_ai = 0;
  var_7 = 0;
  var_8 = var_0;

  for(;;) {
    var_9 = anglesToForward(level.player.angles);
    var_10 = level.player.origin + var_9 * 150;
    common_scripts\utility::play_sound_in_space("mortar_incoming", var_10);
    var_11 = undefined;

    if(level.tower_mortars_target_ai == 1 && var_7 < 3) {
      level.tower_retreaters = maps\_utility::array_removedead_or_dying(level.tower_retreaters);
      level.tower_retreaters = common_scripts\utility::array_randomize(level.tower_retreaters);

      foreach(var_13 in level.tower_retreaters) {
        if(!var_13 istouching(var_1)) {
          continue;
        }
        if(maps\_utility::within_fov_2d(level.player getEye(), level.player.angles, var_13.origin, var_2)) {
          var_14 = distance2dsquared(level.player.origin, var_13.origin);

          if(var_14 > var_4 && var_14 < var_5) {
            var_11 = var_13;
            var_7++;
            var_6 = 1;
            break;
          }
        }
      }
    }

    if(!isDefined(var_11)) {
      var_8 = common_scripts\utility::array_randomize(var_8);
      var_16 = [];

      foreach(var_18 in var_8) {
        var_14 = distance2dsquared(level.player.origin, var_18.origin);

        if(var_14 > var_4 && var_14 < var_5)
          var_16 = common_scripts\utility::array_add(var_16, var_18);
      }

      foreach(var_18 in var_16) {
        var_21 = maps\homecoming_util::get_fov_2d(level.player getEye(), level.player.angles, var_18.origin);

        if(var_21 >= var_2) {
          if(!common_scripts\utility::flag("FLAG_start_retreat_paths")) {
            if(var_3 <= var_21)
              continue;
          }

          var_11 = var_18;
          break;
        }
      }
    }

    var_23 = undefined;

    if(!isDefined(var_11)) {
      var_23 = sortbydistance(var_8, level.player.origin);

      foreach(var_18 in var_23) {
        if(!common_scripts\utility::flag("FLAG_start_retreat_paths")) {
          var_21 = maps\homecoming_util::get_fov_2d(level.player getEye(), level.player getplayerangles(), var_18.origin);

          if(var_3 <= var_21)
            continue;
        }

        var_14 = distance2dsquared(level.player.origin, var_18.origin);

        if(var_14 > var_4) {
          var_11 = var_18;
          break;
        }
      }
    }

    if(!isDefined(var_11))
      var_11 = var_23[var_23.size - 1];

    if(!isai(var_11))
      var_7 = 0;

    tower_retreat_mortars_hit(var_11);
    var_8 = common_scripts\utility::array_remove(var_0, var_11);
    wait(randomfloatrange(0.2, 0.6));
  }
}

tower_retreat_mortars_hit(var_0) {
  var_1 = var_0.origin;

  if(isai(var_0)) {
    if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield == 1)
      var_0 maps\_utility::stop_magic_bullet_shield();

    var_0 maps\homecoming_util::clear_ignore_everything();
    var_0 dodamage(99999, var_1, var_0, var_0, "MOD_EXPLOSIVE");
  }

  if(level.player.health > 30 && common_scripts\utility::flag("FLAG_start_retreat_paths"))
    radiusdamage(var_1, 700, 25, 12.5);

  playFX(common_scripts\utility::getfx("mortar_sm"), var_1);
  playrumbleonposition("artillery_rumble", var_1);
  earthquake(0.65, 0.8, var_1, 700);
  thread common_scripts\utility::play_sound_in_space("mortar_explosion_dirt", var_1);
}

tower_retreat_mortar_kill_player() {
  var_0 = getent("tower_courtyard_mortar_volume", "targetname");
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, "elias_street_trig_1");
  maps\_utility::add_wait(maps\_utility::timeout, 10);
  maps\_utility::do_wait_any();
  level notify("stop_tower_retreat_mortars");
  level.mortarearthquakeradius = 3000;
  level.mortarwithinfov = cos(35);
  level.mortarmininterval = 0.2;
  level.mortarmaxinterval = 0.5;
  level.nomaxmortardist = 1;
  level.mortarexcluders = [level.hesh];
  thread maps\homecoming_util::set_mortar_on(15);

  for(;;) {
    while(!level.player istouching(var_0))
      wait 0.05;

    wait 2;

    if(level.player istouching(var_0)) {
      level.player maps\_utility::play_sound_on_entity("mortar_incoming");
      thread common_scripts\utility::play_sound_in_space("mortar_explosion_dirt", level.player.origin);
      playFX(common_scripts\utility::getfx("mortar_sm"), level.player.origin);
      wait 0.1;
      radiusdamage(level.player.origin, 99999, 99999, 99999);
      return;
    }
  }
}

tower_mortar_allow_target_ai() {
  wait 3;
  level.tower_mortars_target_ai = 1;
}

tower_entrance_hesco_guys() {
  var_0 = self.spawner;
  var_1 = var_0 maps\homecoming_util::get_linked_struct();
  var_2 = self;
  var_2.grenadeawareness = 0;
  var_2.badplaceawareness = 0;
  var_1 thread maps\_anim::anim_generic(var_2, "traverse_stepup_52");
  maps\homecoming_util::set_ai_array("tower_entrance_attackers");
}

tower_vista_retreat_tank() {
  self.firetime = [];
  self.firetime[0] = 0.5;
  self.firetime[1] = 1;
  var_0 = common_scripts\utility::getstruct(self.script_linkto, "script_linkname");
  self setturrettargetvec(var_0.origin);
  common_scripts\utility::flag_wait("FLAG_player_leaving_tower");
  maps\_vehicle::gopath(self);
}

tower_ally_retreaters_wave1() {
  level endon("stop_tower_ally_retreaters_wave1");
  var_0 = getEntArray("tower_exit_ally_retreater", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_utility::spawn_ai();
    var_4 = common_scripts\utility::getstruct(var_2.target, "targetname");
    var_3 thread maps\homecoming_util::move_on_path(var_4, 1);
    common_scripts\utility::waitframe();
  }
}

tower_courtyard_advancing_enemies() {
  var_0 = getent("tower_exit_enemy_goalvolume_mid", "targetname");
  var_1 = getent("tower_front_center_goalvolume", "targetname");
  var_2 = getent("tower_courtyard_front_goalvolume", "targetname");
  level.tower_enemies_volume = var_0;
  common_scripts\utility::flag_wait("TRIGFLAG_start_tower_advancing_enemies");
  maps\_spawner::flood_spawner_scripted(getEntArray("tower_courtyard_advancing_mid_flooders", "targetname"));
  maps\_spawner::flood_spawner_scripted(getEntArray("tower_courtyard_advancing_top_flooders", "targetname"));
  common_scripts\utility::flag_wait("TRIGFLAG_player_end_elias_street");
  maps\_spawner::killspawner(1099);
  maps\_utility::array_delete(maps\homecoming_util::get_ai_array("tower_enemy_advancers"));
}

tower_courtyard_advancing_mid_flooders() {
  self endon("death");

  for(;;) {
    self setgoalvolumeauto(level.tower_enemies_volume);
    level waittill("advancers_new_goalvolume");
  }
}

retreat_hovercraft() {
  self.i_delete_myself = 1;
  common_scripts\utility::flag_wait("TRIGFLAG_player_entering_tower");
  maps\homecoming_util::hovercraft_delete();
}

elias_street_sequence() {
  common_scripts\utility::flag_wait("FLAG_start_elias_street");
  thread maps\_utility::autosave_by_name("elias_street");
  common_scripts\utility::exploder("elias_entrance_smoke_start");
  thread elias_street_dialogue();
  thread green_house_ladder();
  thread elias_house_window_explosion();
  thread elias_street_helicopter_flyover();
  thread dog_reunite();
  maps\homecoming_util::waittill_trigger("elias_street_trig_1");
  common_scripts\utility::flag_set("FLAG_player_at_elias_street");
  thread maps\homecoming_util::ambient_smallarms_fire("elias_street_fakefire", "elias_street_fakefire_stop", 0.09, 0.2);
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "elias_street_heli_unload");
  maps\_utility::add_wait(maps\homecoming_util::waittill_trigger, "elias_street_flee_guys_trig");
  maps\_utility::do_wait_any();
  thread maps\homecoming_util::player_push_quad((-1328, 10844, 148), (-1280, 11244, 292), (0, 0, 0), "whatever");
  thread elias_street_dragging_wounded();
  thread elias_street_flee_guys_enemies();
  common_scripts\utility::array_thread(getEntArray("elias_street_scared_runners", "targetname"), ::elias_street_flee_guys);
  common_scripts\utility::flag_wait("FLAG_elias_street_ground_enemies");
  var_0 = maps\homecoming_util::get_ai_array("elias_street_street_allies");
  thread maps\homecoming_util::kill_over_time(var_0, 5, 15, 1);
  var_1 = maps\homecoming_util::get_ai_array("elias_street_enemies");
  maps\_utility::waittill_dead_or_dying(var_1, var_1.size - 2);
  common_scripts\utility::flag_wait("FLAG_dog_reunite_done");
  level.hesh maps\_utility::set_ignoresuppression(1);
  level.hesh.grenadeawareness = 0;
  level.hesh thread maps\homecoming_util::heroes_move("movespot_elias_street_3");
  var_1 = maps\homecoming_util::get_ai_array("elias_street_enemies");
  var_2 = common_scripts\utility::getclosest(level.dog.origin, var_1);

  if(isDefined(var_2)) {
    common_scripts\utility::flag_set("FLAG_elias_street_cairo_attack");
    level.dog setgoalentity(var_2);
    level.dog setdogattackradius(512);
    level.dog.meleealwayswin = 1;
  }

  var_1 = maps\homecoming_util::get_ai_array("elias_street_enemies");
  maps\_utility::waittill_dead_or_dying(var_1, var_1.size);
  level.hesh maps\_utility::set_ignoresuppression(0);
  common_scripts\utility::flag_set("FLAG_start_elias_house");
}

crack_exploder_test() {
  for(;;) {
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0.origin = level.player.origin;
    var_0.angles = level.player.angles;
    playFXOnTag(common_scripts\utility::getfx("vfx_ceiling_cracks"), var_0, "tag_origin");
    wait 3;
    stopFXOnTag(common_scripts\utility::getfx("vfx_ceiling_cracks"), var_0, "tag_origin");
    var_0 delete();
    iprintlnbold("off");
    wait 3;
  }
}

elias_street_dialogue() {
  common_scripts\utility::flag_wait("FLAG_player_at_elias_street");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_overlordraptor21have");
  common_scripts\utility::flag_wait("FLAG_dog_reunite_started");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_theresriley");
  common_scripts\utility::flag_wait("FLAG_hesh_at_riley");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_rileycmonboy");
  common_scripts\utility::flag_wait("FLAG_cairo_reunite_complete");

  if(!common_scripts\utility::flag("FLAG_elias_street_cairo_attack") && !common_scripts\utility::flag("TRIGFLAG_player_end_elias_street")) {
    level.hesh maps\_utility::dialogue_queue("homcom_hsh_enemiesendofthe");
    wait 0.2;
    var_0 = maps\homecoming_util::get_ai_array("elias_street_street_allies");
    var_1 = maps\homecoming_util::getclosest2d(level.player.origin, var_0);

    if(isDefined(var_1))
      var_1 maps\_utility::play_sound_on_tag("homcom_us1_wegotenemiesfast", "j_head");
    else
      level.hesh maps\_utility::play_sound_on_tag("homcom_us1_wegotenemiesfast", "j_head");

    level.hesh maps\_utility::dialogue_queue("homcom_hqr_sorryraptor21nothing");
  }

  common_scripts\utility::flag_wait("FLAG_elias_street_cairo_attack");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_cairogo");
}

elias_street_artemis() {
  maps\_vehicle::godon();
  thread maps\homecoming_util::artemis_think();
  level.retreat_artemis = self;
}

elias_house_window_explosion() {
  maps\homecoming_util::waittill_trigger("elias_house_windows_explosion");
  var_0 = getglass("house_glass_1");
  var_1 = getglassarray("house_glass_2");
  common_scripts\utility::exploder("house_window_smash");
  var_2 = anglesToForward((0, 0, 0));
  destroyglass(var_0, var_2);

  foreach(var_4 in var_1)
  common_scripts\utility::noself_delaycall(0.1, ::destroyglass, var_4, var_2);

  common_scripts\utility::flag_wait("FLAG_garage_door_closed");
  maps\_utility::stop_exploder("house_window_smash");
}

green_house_ladder() {
  maps\homecoming_util::waittill_trigger("green_house_ladder_guy_trig");
  var_0 = getent("green_house_ladder_spawner", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 maps\_anim::anim_generic_reach(var_1, "ladder_climbon");
  var_2 thread maps\_anim::anim_generic(var_1, "ladder_climbon");
  var_3 = var_0 maps\_utility::spawn_ai();
  var_3.animname = "generic";
  var_3 hide();
  var_4 = common_scripts\utility::getstruct(var_2.target, "targetname");
  var_4 thread maps\_anim::anim_generic(var_3, "ladder_slide");
  common_scripts\utility::waitframe();
  var_3 setanimtime(maps\_utility::getanim_generic("ladder_slide"), 0.17);
  thread maps\_anim::anim_set_rate_single(var_3, "ladder_slide", 0);
  wait 0.65;

  if(!isDefined(var_1) && !isalive(var_1)) {
    var_3 delete();
    return;
  }

  var_3 show();
  var_1 delete();
  thread maps\_anim::anim_set_rate_single(var_3, "ladder_slide", 0.62);
  wait 1;
  thread maps\_anim::anim_set_rate_single(var_3, "ladder_slide", 1);
  wait 1.15;
  var_3 stopanimscripted();
  var_3 endon("death");
  var_5 = common_scripts\utility::getstruct(var_3.script_linkto, "script_linkname");
  var_3 thread maps\_utility::follow_path_and_animate(var_5, 0);
}

#using_animtree("generic_human");

elias_street_dead_runners() {
  var_0 = self.spawner;
  maps\_utility::magic_bullet_shield();
  self.noragdoll = 1;
  self.runanim = level.drone_anims["allies"]["stand"]["run_n_gun"];
  self.weaponsound = "drone_r5rgp_fire_npc";
  thread maps\homecoming_drones::drone_fire_randomly_loop();
  self.deathanim = common_scripts\utility::random([ % stand_death_tumbleback, % stand_death_headshot_slowfall, % stand_death_shoulderback]);
  self waittill("goal");
  var_1 = ["j_head", "tag_weapon_chest", "j_SpineUpper", "J_SpineLower"];
  var_2 = common_scripts\utility::random(var_1);
  var_3 = randomintrange(1, 3);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_2 = common_scripts\utility::random(var_1);
    var_5 = "body_impact1";

    if(var_2 == "j_head")
      var_5 = "headshot_blood";

    playFXOnTag(common_scripts\utility::getfx(var_5), self, var_2);
  }

  maps\homecoming_util::kill_safe();

  if(!isDefined(level.elias_street_dead_runners))
    level.elias_street_dead_runners = 0;

  level.elias_street_dead_runners++;

  if(level.elias_street_dead_runners == 3) {
    wait 0.2;
    level notify("elias_street_fakefire_stop");
  }
}

dog_reunite() {
  common_scripts\utility::flag_init("dog_at_animspot");
  common_scripts\utility::flag_init("hesh_at_animspot");
  var_0 = getent("dog_reunite_marine", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2 = common_scripts\utility::getstruct("dog_reunite_spot", "targetname");
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_tower_parking_area");
  var_3 = var_0 maps\_utility::spawn_ai();
  level.dog = maps\homecoming_util::dog_spawn();
  var_2 thread maps\_anim::anim_loop_solo(level.dog, "attackidle_bark");
  level.dog thread dog_bark(1);
  maps\homecoming_util::waittill_trigger("elias_street_start_dog_reunite");
  var_4 = common_scripts\utility::getstruct("dog_reunite_spot_2", "targetname");
  thread dog_reunite_hesh(var_4);
  var_5 = getent("dog_reunite_trigger", "targetname");

  for(;;) {
    var_5 waittill("trigger", var_6);

    if(var_6 == level.hesh) {
      break;
    }
  }

  level.dog notify("stop_barking");
  var_2 notify("stop_loop");
  level.dog stopanimscripted();
}

dog_reunite_hesh(var_0) {
  level.hesh notify("stop_path");
  var_1 = common_scripts\utility::getstruct("hesh_dog_reunite_goal_1", "targetname");
  level.hesh setgoalpos(var_1.origin);
  level.hesh.goalradius = 56;
  level.hesh maps\_utility::enable_sprint();
  level.hesh maps\homecoming_util::ignore_everything();
  level.hesh maps\homecoming_util::disable_arrivals_and_exits();
  level.hesh maps\_utility::walkdist_zero();
  level.hesh waittill("goal");
  common_scripts\utility::flag_set("FLAG_dog_reunite_started");
  var_2 = common_scripts\utility::getstruct("dog_reunite_hesh_corner", "targetname");
  var_2 maps\_anim::anim_reach_solo(level.hesh, "hesh_dog_reunite_corner");
  common_scripts\utility::flag_set("FLAG_hesh_at_riley");
  var_2 thread maps\_anim::anim_generic_gravity(level.hesh, "hesh_dog_reunite_corner");
  var_3 = getanimlength(maps\_utility::getanim_generic("hesh_dog_reunite_corner"));
  maps\_utility::delaythread(var_3, common_scripts\utility::flag_set, "FLAG_cairo_reunite_complete");
  level.hesh maps\_utility::disable_sprint();
  level.hesh maps\homecoming_util::clear_ignore_everything();
  level.hesh maps\_utility::walkdist_reset();
  wait 0.5;
  level.dog thread maps\homecoming_util::move_to_goal("movespot_elias_street_2");
  level.hesh thread maps\homecoming_util::move_to_goal("movespot_elias_street_2");
  common_scripts\utility::flag_set("FLAG_dog_reunite_done");
}

dog_bark(var_0, var_1, var_2) {
  self endon("stop_barking");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0.2;

  if(!isDefined(var_2))
    var_2 = 0.4;

  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    if(var_0)
      maps\_utility::play_sound_on_entity("anml_dog_bark_attention_npc");
    else
      maps\_utility_dogs::dog_bark("anml_dog_bark_attention_npc");

    wait(randomfloatrange(var_1, var_2));
  }
}

dog_whine(var_0, var_1) {
  self endon("stop_whining");
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 0.2;

  if(!isDefined(var_1))
    var_1 = 0.4;

  for(;;) {
    maps\_utility::play_sound_on_entity("anml_dog_whine");
    wait(randomfloatrange(var_0, var_1));
  }
}

#using_animtree("vehicles");

elias_street_helicopter_flyover() {
  level endon("stop_street_flyovers");
  maps\homecoming_util::waittill_trigger("elias_street_flyover");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("elias_street_unload_chopper");
  var_0 setanim( % nh90_left_door_open);
  var_0 setanim( % nh90_right_door_open);
  var_1 = getent("helicopter_check_volume", "targetname");
  var_2 = getEntArray("elias_street_flyover_choppers", "targetname");

  for(;;) {
    var_3 = 0;
    var_4 = undefined;

    foreach(var_6 in var_2) {
      var_7 = 0;

      if(isDefined(var_6.script_wait))
        var_7 = var_6.script_wait;

      if(var_7 > var_3)
        var_3 = var_7;

      maps\_utility::delaythread(var_7, ::elias_street_helicopter_spawn, var_6, var_1);
    }

    wait(var_3 + randomfloatrange(1, 3));
  }
}

elias_street_helicopter_spawn(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!level.player istouching(var_1)) {
      if(!common_scripts\utility::flag("FLAG_garage_door_closed"))
        return;
    }
  }

  if(level.player maps\_utility::player_looking_at(var_0.origin)) {
    return;
  }
  var_2 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();

  if(!var_0 maps\homecoming_util::parameters_check("engine_on"))
    var_2 vehicle_turnengineoff();

  wait 0.1;
  var_2 notify("stop_kicking_up_dust");
}

elias_street_flee_guys() {
  var_0 = self;

  if(isDefined(var_0.script_wait))
    wait(var_0.script_wait);

  var_1 = var_0 maps\_utility::spawn_ai();

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  var_1 maps\homecoming_util::ignore_everything();
  var_1.ignoreme = 1;
  var_1 maps\_utility::magic_bullet_shield();
  var_1 maps\_utility::pathrandompercent_zero();
  var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");

  if(var_0 maps\homecoming_util::noteworthy_check("shoot_behind")) {
    var_1 maps\_utility::set_generic_deathanim("run_death_roll");
    var_2 maps\_anim::anim_generic_reach(var_1, "flee_run_shoot_behind");
    var_2 thread maps\_anim::anim_generic(var_1, "flee_run_shoot_behind");
    wait 1.3;
    playFXOnTag(common_scripts\utility::getfx("headshot_blood"), var_1, "j_head");
    var_1 stopanimscripted();
    var_1 maps\_utility::stop_magic_bullet_shield();
    var_1 maps\_utility::die();
  } else {
    if(var_0 maps\homecoming_util::parameters_check("killme"))
      var_1 maps\_utility::delaythread(randomfloatrange(0.5, 1), maps\homecoming_util::kill_safe);

    var_1 setgoalpos(var_2.origin);
    var_1.goalradius = 56;
    var_1 waittill("goal");
    var_1 maps\homecoming_util::delete_safe();
  }
}

elias_street_flee_guys_enemies() {
  var_0 = getEntArray("street_flee_guys_enemy_spawner", "targetname");
  thread elias_street_flee_guys_enemies_fakeshots(var_0);
  level thread maps\_utility::notify_delay("stop_fake_street_shots", 2.5);
  wait 2.2;
  var_1 = 0;

  foreach(var_3 in var_0) {
    wait(var_1);
    var_4 = var_3 maps\_utility::spawn_ai();
    var_4 maps\homecoming_util::ignore_everything();
    var_4 maps\_utility::magic_bullet_shield();
    var_4 maps\_utility::delaythread(1, maps\homecoming_util::clear_ignore_everything);
    var_4 maps\_utility::delaythread(1, maps\_utility::stop_magic_bullet_shield);
    var_1 = randomfloatrange(0.4, 0.6);
  }

  common_scripts\utility::flag_set("FLAG_elias_street_ground_enemies");
}

elias_street_flee_guys_enemies_fakeshots(var_0) {
  level endon("stop_fake_street_shots");
  var_1 = common_scripts\utility::getstruct("elias_street_shoot_spot", "targetname");
  var_2 = ["sc2010", "honeybadger"];

  for(;;) {
    var_3 = var_0[randomint(var_0.size)];
    var_4 = randomintrange(6, 8);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = maps\homecoming_util::return_point_in_circle(var_1.origin, var_1.radius, var_1.height);
      var_7 = var_2[randomint(var_2.size)];
      magicbullet(var_7, var_3.origin + (0, 0, 46), var_6);
      wait 0.1;
    }

    wait(randomfloatrange(0.3, 0.6));
  }
}

#using_animtree("generic_human");

elias_street_dragging_wounded() {
  var_0 = getent("elias_street_dragger_spawner", "targetname");
  var_1 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");
  var_2 = var_0 maps\_utility::spawn_ai();
  var_2.animname = "dragger";
  var_2.deathanim = % stand_death_tumbleback;
  var_2 maps\_utility::magic_bullet_shield();
  var_3 = var_0 maps\_utility::spawn_ai();
  var_3.animname = "wounded";
  var_3 maps\_utility::magic_bullet_shield();
  var_3.deathanim = % airport_civ_dying_groupb_wounded_death;
  var_4 = [var_2, var_3];
  var_1 thread maps\_anim::anim_single(var_4, "elias_street_drag_wounded_drag");

  foreach(var_6 in var_4)
  var_6 setanimtime(var_6 maps\_utility::getanim("elias_street_drag_wounded_drag"), 0.2);

  var_1 waittill("elias_street_drag_wounded_drag");
  playFXOnTag(common_scripts\utility::getfx("headshot_blood"), var_2, "j_head");

  foreach(var_6 in var_4) {
    var_6.noragdoll = 1;
    var_6 maps\_utility::stop_magic_bullet_shield();
    var_6 maps\_utility::die();
  }
}

elias_house_sequence() {
  common_scripts\utility::flag_wait("FLAG_start_elias_house");
  thread maps\_utility::autosave_by_name("elias_street_2");
  maps\_utility::flavorbursts_off();
  level.hesh maps\homecoming_util::ignore_everything();
  level.dog maps\homecoming_util::ignore_everything();
  level.hesh pushplayer(1);
  level.dog pushplayer(1);
  level.hesh maps\_utility::pathrandompercent_zero();
  level.dog maps\_utility::pathrandompercent_zero();
  thread maps\homecoming_util::create_dead_guys("house_dead_bodies", undefined, "FLAG_elias_house_attack_began");
  thread elias_house_dialogue();
  thread elias_house_dog_logic();
  var_0 = getent("elias_house_garage_ai_blocker", "targetname");
  var_0 connectpaths();
  var_0 maps\_utility::hide_entity();
  var_1 = common_scripts\utility::getstruct("elias_garage_hesh_spot", "targetname");
  var_1 maps\_anim::anim_reach_solo(level.hesh, "elias_garage_lift");
  common_scripts\utility::flag_set("FLAG_allow_dog_scratch");
  thread elias_street_advancing_enemies();
  var_2 = getent("elias_house_garage_door", "targetname");
  level.garagedoor = var_2;
  var_1 thread maps\_anim::anim_single_solo(level.hesh, "elias_garage_lift");
  getent("house_downstairs_effects_on", "script_noteworthy") notify("trigger");
  thread maps\homecoming_util::function_trigger_switch("house_fx_firstfloor_on", "house_fx_secondfloor_on", ::house_firstfloor_exploder, ::house_firstfloor_exploder_off, "elias_house_exploder_switch_off", 1);
  thread maps\homecoming_util::function_trigger_switch("house_fx_secondfloor_on", "house_fx_firstfloor_on", ::house_secondfloor_exploder, ::house_secondfloor_exploder_off, "elias_house_exploder_switch_off");
  maps\_utility::delaythread(1.1, common_scripts\utility::flag_set, "FLAG_dont_allow_dog_scratch");
  maps\_utility::delaythread(2.5, maps\_utility::stop_exploder, "elias_entrance_smoke_start");
  maps\_utility::delaythread(2.5, common_scripts\utility::exploder, "elias_entrance_smoke");
  wait 2;
  level.hesh thread garage_door_logic(var_2);
  var_3 = var_2.origin;
  wait 1;
  var_1 waittill("elias_garage_lift");
  var_1 thread maps\_anim::anim_loop_solo(level.hesh, "elias_garage_idle");
  thread garage_door_nag();
  common_scripts\utility::flag_set("FLAG_garage_door_open");
  maps\homecoming_util::waittill_trigger("elias_house_garage_trig");
  level notify("player_in_elias_garage");
  var_4 = getent("elias_house_bottomfloor_check", "targetname");

  while(!level.dog istouching(var_4))
    wait 0.05;

  var_0 disconnectpaths();
  var_0 maps\_utility::show_entity();

  while(!level.player istouching(var_4))
    wait 0.05;

  getent("elias_house_garage_player_blocker", "targetname") maps\_utility::show_entity();
  var_1 notify("stop_loop");
  level.hesh maps\_utility::anim_stopanimscripted();
  var_1 thread maps\_anim::anim_single_solo_run(level.hesh, "elias_garage_thru");
  level.hesh.garagetag = "j_wrist_ri";
  var_2 thread maps\_utility::play_sound_on_entity("scn_home_garage_close");
  wait 1.6;
  level notify("stop_elias_garage_door_logic");
  var_5 = (var_3[0], var_3[1], 16);
  var_2 moveto(var_5, 0.2);
  var_2 disconnectpaths();
  maps\_utility::stop_exploder("elias_entrance_smoke");
  level.hesh thread maps\homecoming_util::move_to_goal("movespot_elias_house_2");
  thread maps\_utility::autosave_by_name("elias_house");
  common_scripts\utility::flag_set("FLAG_garage_door_closed");
  common_scripts\utility::flag_set("FLAG_hesh_inside_elias_house");
  common_scripts\utility::flag_set("FLAG_stop_elias_street_ambient_retreaters");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("neutral");
  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_elias_garage");
  thread elias_street_advancing_drones();
  thread elias_house_lift_rubble_scene();
  common_scripts\utility::flag_wait("TRIGFLAG_player_elias_secondfloor");
  common_scripts\utility::flag_set("FLAG_start_elias_house_attack");
}

elias_house_dialogue() {
  common_scripts\utility::flag_wait_all("TRIGFLAG_player_leaving_elias_garage", "FLAG_garage_dialoge_done");
  wait 0.2;

  if(!common_scripts\utility::flag("TRIGFLAG_player_elias_secondfloor"))
    level.hesh maps\_utility::dialogue_queue("homcom_hsh_upthestairs");

  common_scripts\utility::flag_wait("FLAG_hesh_dropped_beam");
  level.hesh thread maps\_utility::dialogue_queue("homcom_hsh_watchout");
}

garage_door_logic(var_0) {
  level endon("stop_elias_garage_door_logic");
  level.hesh.garagetag = "j_wrist_le";
  var_1 = self gettagorigin(level.hesh.garagetag)[2];

  for(;;) {
    var_2 = var_1;
    wait 0.05;
    var_1 = self gettagorigin(level.hesh.garagetag);
    var_1 = var_1[2];
    var_3 = var_1 - var_2;

    if(abs(var_3) > 5) {
      continue;
    }
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, var_3);
  }
}

garage_door_nag() {
  level endon("player_in_elias_garage");
  var_0 = [];
  var_0[0] = "homcom_hsh_getinside";
  var_0[1] = "homcom_hsh_comeonadamwe";
  var_0[2] = "homcom_hsh_adamgetinhere";
  var_0[3] = "homcom_hsh_adamweneedto";
  var_1 = var_0;

  for(;;) {
    var_2 = var_1[randomint(var_1.size)];
    level.hesh maps\_utility::dialogue_queue(var_2);
    wait(randomintrange(4, 7));
    var_1 = var_0;
    var_1 = common_scripts\utility::array_remove(var_0, var_2);
  }
}

elias_house_dog_logic() {
  if(!common_scripts\utility::flag("FLAG_allow_dog_scratch")) {
    level.dog thread maps\homecoming_util::move_to_goal("movespot_elias_street_3");
    level.dog waittill("goal");
  }

  common_scripts\utility::flag_wait("FLAG_allow_dog_scratch");

  if(!common_scripts\utility::flag("FLAG_dont_allow_dog_scratch")) {
    var_0 = common_scripts\utility::getstruct("garage_dog_scratch_spot", "targetname");
    level maps\_utility::add_wait(common_scripts\utility::flag_wait, "FLAG_garage_door_open");
    var_0 maps\_utility::add_wait(maps\_anim::anim_reach_solo, level.dog, "dog_scratch_door");
    maps\_utility::do_wait_any();

    if(common_scripts\utility::flag("FLAG_garage_door_open"))
      self notify("new_anim_reach");
    else {
      level.dog thread maps\_utility::play_sound_on_entity("scn_home_dog_scratching_door");
      level.dog thread maps\_utility::play_sound_on_entity("anml_dog_whine");
      var_0 maps\_anim::anim_single_solo(level.dog, "dog_scratch_door");
    }
  }

  level.dog thread dog_bark();
  level.dog thread maps\_utility::notify_delay("stop_barking", 2);
  var_1 = common_scripts\utility::getstruct("garage_dog_path", "targetname");
  level.dog thread maps\_utility::follow_path_and_animate(var_1, 0);
  var_2 = getnode("house_bottom_stairs_dog_node", "targetname");
  common_scripts\utility::flag_wait("FLAG_dog_allow_teleport");
  var_3 = 0;
  var_4 = cos(65);

  for(;;) {
    wait 0.05;

    if(common_scripts\utility::flag("FLAG_dog_garage_end_goal")) {
      var_3 = 1;
      break;
    }

    if(common_scripts\utility::flag("TRIGFLAG_player_leaving_elias_garage")) {
      var_3 = 1;
      break;
    }

    if(common_scripts\utility::within_fov(level.player getEye(), level.player.angles, level.dog.origin, var_4)) {
      continue;
    }
    if(level.player maps\_utility::player_looking_at(level.dog.origin)) {
      continue;
    }
    break;
  }

  if(!var_3) {
    level.dog notify("stop_path");
    level.dog maps\_utility::teleport_ai(var_2);
  }

  common_scripts\utility::flag_wait("TRIGFLAG_player_leaving_elias_garage");
  level.dog thread dog_bark();
  level.dog thread maps\_utility::notify_delay("stop_barking", 2);
  var_5 = common_scripts\utility::getstruct("house_dog_hop1", "targetname");
  var_5 maps\_anim::anim_reach_solo(level.dog, "dog_hop_1");
  level.dog thread dog_whine();
  var_5 thread maps\_anim::anim_loop_solo(level.dog, "casualidle");

  if(!common_scripts\utility::flag("TRIGFLAG_player_elias_secondfloor")) {
    level.dog thread dog_bark();
    level.dog thread maps\_utility::notify_delay("stop_barking", 2);
  }

  common_scripts\utility::flag_wait("FLAG_rubble_scene_started");
  wait 2.5;
  level.dog notify("stop_whining");
  var_5 notify("stop_loop");
  level.dog thread maps\_utility::play_sound_on_entity("anml_dog_whine");
  var_5 maps\_anim::anim_single_solo(level.dog, "dog_hop_1");
  level.dog thread dog_whine(0.4, 1);
  level.dog thread maps\_anim::anim_loop_solo(level.dog, "casualidle");
  common_scripts\utility::flag_wait("FLAG_hesh_dropped_beam");
  level.dog notify("stop_whining");
  wait 2;
  level.dog thread dog_bark();
  var_5 notify("stop_loop");
  level.dog maps\_utility::anim_stopanimscripted();
  level.dog thread elias_house_heroes_delete();
}

#using_animtree("vehicles");

elias_street_advancing_enemies() {
  common_scripts\utility::flag_wait("TRIGFLAG_player_end_elias_street");
  maps\_spawner::flood_spawner_scripted(getEntArray("elias_street_advancing_enemy_spawner", "targetname"));
  var_0 = getent("advancing_enemies_accuracy_high", "targetname");
  var_0 common_scripts\utility::trigger_on();
  var_1 = getent("advancing_enemies_accuracy_low", "targetname");
  var_1 common_scripts\utility::trigger_on();
  thread maps\homecoming_util::function_trigger_switch(var_0, var_1, ::elias_street_advancing_accuracy_high, ::elias_street_advancing_accuracy_low, "FLAG_stop_elias_street_ambient_retreaters");
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("elias_street_enemy_heli_2");
  var_2 setanim( % nh90_left_door_open);
  var_2 setanim( % nh90_right_door_open);
  common_scripts\utility::flag_wait("FLAG_stop_elias_street_ambient_retreaters");
  maps\_spawner::killspawner(405);
  maps\_utility::array_delete(maps\homecoming_util::get_ai_array("elias_street_advancing_enemies"));

  if(isDefined(var_2))
    var_2 delete();
}

elias_street_advancing_accuracy_high() {
  var_0 = maps\homecoming_util::get_ai_array("elias_street_advancing_enemies");

  foreach(var_2 in var_0) {
    var_2.advancer_oldaccuraccy = var_2.baseaccuracy;
    var_2 maps\_utility::set_baseaccuracy(9999);
    var_2.favoriteenemy = level.player;
  }
}

elias_street_advancing_accuracy_low() {
  var_0 = maps\homecoming_util::get_ai_array("elias_street_advancing_enemies");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.advancer_oldaccuraccy)) {
      var_2 maps\_utility::set_baseaccuracy(var_2.advancer_oldaccuraccy);
      var_2.favoriteenemy = undefined;
    }
  }
}

elias_street_advancing_drones() {
  var_0 = getEntArray("elias_street_advancing_drones", "targetname");
  var_1 = ["run"];
  var_2 = [2.5, 5];
  common_scripts\utility::array_thread(var_0, maps\homecoming_drones::drone_infinite_runners, "FLAG_elias_house_attack_began", var_2, var_1);
}

elias_house_lift_rubble_scene() {
  var_0 = common_scripts\utility::getstruct("elias_house_rubble_lift", "targetname");
  var_1 = getent("beam_player_blocker", "targetname");
  var_2 = getent("falling_beam", "targetname");
  var_3 = maps\_utility::spawn_anim_model("blocker");
  var_2 linkto(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 = common_scripts\utility::getstructarray("beam_fx_spot", "script_noteworthy");
  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8.origin = var_7.origin;
    var_8.angles = var_7.angles;
    var_8 linkto(var_2);
    var_8 thread maps\homecoming_util::playloopingfx("beam_fire", 0.05, undefined, "tag_origin", 1);
    var_5 = common_scripts\utility::array_add(var_5, var_8);
  }

  var_0 maps\_anim::anim_first_frame_solo(var_3, "elais_house_blocker_in");
  var_10 = [level.hesh, var_3];
  var_0 maps\_anim::anim_reach_solo(level.hesh, "elais_house_blocker_in");
  common_scripts\utility::flag_set("FLAG_rubble_scene_started");
  var_11 = cos(45);

  if(!common_scripts\utility::flag("TRIGFLAG_player_elias_secondfloor")) {
    var_0 maps\_anim::anim_first_frame(var_10, "elais_house_blocker_in");

    while(!common_scripts\utility::flag("TRIGFLAG_player_elias_secondfloor")) {
      if(level.player maps\_utility::player_looking_at(level.hesh gettagorigin("j_head"), var_11)) {
        break;
      }

      wait 0.05;
    }
  }

  var_12 = 4.5;
  thread elias_house_lift_prone_hint(var_12);
  var_1 maps\_utility::delaythread(var_12, maps\_utility::hide_entity);
  var_0 thread maps\_anim::anim_single(var_10, "elais_house_blocker_in");
  var_0 maps\_utility::add_wait(maps\_utility::waittill_msg, "elais_house_blocker_in");
  maps\_utility::add_wait(common_scripts\utility::flag_wait, "TRIGFLAG_player_through_beam_blocker");
  maps\_utility::do_wait_any();

  if(!common_scripts\utility::flag("TRIGFLAG_player_through_beam_blocker")) {
    var_0 thread maps\_anim::anim_loop(var_10, "elais_house_blocker_idle");
    common_scripts\utility::flag_wait("TRIGFLAG_player_through_beam_blocker");
    var_0 notify("stop_loop");
  }

  var_1 maps\_utility::show_entity();
  var_0 thread maps\_anim::anim_single(var_10, "elais_house_blocker_out");
  common_scripts\utility::waitframe();
  var_0 maps\_anim::anim_set_time(var_10, "elais_house_blocker_out", 0.18);
  thread elias_house_lift_rubble_collapse();
  common_scripts\utility::flag_set("FLAG_hesh_dropped_beam");
  common_scripts\utility::trigger_on("beam_hurt_trigger", "targetname");
  getent("house_downstairs_effects_off", "script_noteworthy") notify("trigger");
  getent("house_topfloor_effects_on", "script_noteworthy") notify("trigger");
  level.hesh thread elias_house_heroes_delete();
  common_scripts\utility::flag_wait("FLAG_elias_house_attack_began");
  maps\_utility::stop_exploder("beam_drop_fire");
  maps\_utility::array_delete(var_5);
  var_2 unlink();
  var_3 delete();
  var_2 delete();
}

elias_house_lift_rubble_collapse() {
  var_0 = (-1305.33, 11798, 258.165);
  thread maps\homecoming_util::earthquake_loop(0.2, var_0);
  wait 0.2;
  level.player notify("stop_earthquake_loop");
  earthquake(0.6, 2.5, var_0, 50000);
  level.player playrumbleonentity("artillery_rumble");
  common_scripts\utility::exploder("elias_house_beam_collapse");
  common_scripts\utility::exploder("beam_drop_fire");
  level.player shellshock("homecoming_attack", 3);
}

elias_house_lift_prone_hint(var_0) {
  wait(var_0);
  maps\homecoming_util::waittill_trigger("elias_house_player_at_beam");
  common_scripts\utility::flag_clear("FLAG_player_went_prone");
  var_1 = getkeybinding("+stance");
  var_2 = getkeybinding("toggleprone");
  var_3 = getkeybinding("+prone");

  if(isDefined(var_1) && var_1["count"] > 0)
    maps\_utility::display_hint("prone_hint_hold");
  else if(isDefined(var_2) && var_2["count"] > 0)
    maps\_utility::display_hint("prone_hint_toggle");
  else if(isDefined(var_3) && var_3["count"] > 0)
    maps\_utility::display_hint("prone_hint");
}

elias_house_heroes_delete() {
  var_0 = common_scripts\utility::getstruct("elias_house_blocker_delete_spot", "targetname");
  maps\_utility::follow_path_and_animate(var_0, 0);
  maps\homecoming_util::delete_safe();
}

#using_animtree("generic_human");

elias_house_attack() {
  level.player endon("player_knife_failed");
  attack_sound_setup();
  common_scripts\utility::flag_wait("FLAG_start_elias_house_attack");
  thread maps\homecoming_recruits::recruits_dog_spawn();
  var_0 = common_scripts\utility::getstruct("elias_house_attack_sequence", "targetname");
  var_1 = getent("house_attack_enemy", "targetname");
  var_2 = getent("start_house_attack_trig", "targetname");

  for(;;) {
    wait 0.05;

    if(!level.player istouching(var_2)) {
      continue;
    }
    var_3 = level.player getstance();

    if(var_3 == "prone") {
      continue;
    }
    if(elias_house_attack_pangles_check()) {
      break;
    }
  }

  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  var_3 = level.player getstance();

  while(var_3 != "stand") {
    var_3 = level.player getstance();
    wait 0.05;
  }

  common_scripts\utility::flag_set("FLAG_elias_house_attack_began");
  level.player setclienttriggeraudiozone("homecoming_upstairs_fight", 0.5);
  thread common_scripts\utility::play_sound_in_space("scn_home_upstairs_fight", level.player.origin);
  maps\_utility::delaythread(5.5, common_scripts\utility::play_sound_in_space, "scn_home_upstairs_fight_02", level.player.origin);
  maps\_utility::music_play("mus_homecoming_upstairs");
  common_scripts\utility::exploder("house_ambient_thirdfloor");
  level notify("stop_street_flyovers");
  var_4 = spawn("script_model", level.player.origin);
  var_4 character\character_elite_pmc_assault_a_black::main();
  var_4 useanimtree(#animtree);
  var_4.animname = "elite";
  level.attacker = var_4;
  level.knife = spawn("script_model", var_4.origin);
  level.knife setModel("weapon_parabolic_knife");
  level.knife linkto(var_4, "tag_inhand", (0, 0, 0), (0, 0, 0));
  var_4 thread maps\_utility::play_sound_on_entity("homcom_fs4_grabthrow");
  var_5 = maps\homecoming_util::dog_spawn();
  var_5 maps\_utility::delaythread(6.0, ::dog_bark, 0, 0.1, 0.2);
  var_5 thread maps\_utility::notify_delay("stop_barking", 7.5);
  var_6 = getanimlength(var_5 maps\_utility::getanim("house_attack_grab"));
  var_5 maps\_utility::delaythread(var_6, maps\homecoming_util::delete_safe);
  var_7 = maps\_utility::spawn_anim_model("player_rig");
  var_8 = [var_4, var_7, var_5];
  common_scripts\utility::array_call(var_8, ::hide);
  var_0 thread maps\_anim::anim_first_frame(var_8, "house_attack_grab");
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.origin = var_7.origin;
  var_9.angles = var_7.angles;
  var_9 linkto(var_7, "tag_player", (0, 0, 0), (0, 0, 0));
  maps\homecoming_util::cinematicmode_on(1);

  if(level.player ismeleeing() || level.player isthrowinggrenade())
    level.player takeallweapons();

  var_9 maps\_utility::lerp_player_view_to_tag(level.player, "tag_origin", 0.15, 1, 0, 0, 0, 0);
  level.player playerlinktoabsolute(var_9, "tag_origin");
  thread elias_house_attack_door();
  thread elias_house_attack_wall();
  thread elias_house_attack_grab_dof();
  thread elias_house_attack_grab_sound();

  foreach(var_11 in var_8) {
    if(var_11 == var_7) {
      var_7 common_scripts\utility::delaycall(0.45, ::show);
      continue;
    }

    var_11 show();
  }

  var_0 thread maps\_anim::anim_single(var_8, "house_attack_grab");
  level.player common_scripts\utility::delaycall(0.2, ::playrumbleonentity, "damage_light");
  level.player common_scripts\utility::delaycall(1.1, ::playrumbleonentity, "damage_light");
  maps\_utility::delaythread(4.5, maps\_utility::autosave_by_name_silent, "elias_house_attack");
  var_13 = 2.7;
  wait(var_13);
  thread elias_house_attack_hit_ground();
  wait(9 - var_13);
  var_8 = common_scripts\utility::array_remove(var_8, var_5);
  elias_house_attack_knife_think(var_0, var_8);
  maps\_utility::delaythread(0.2, maps\_art::dof_disable_script, 1);
  var_14 = getent("house_attack_hesh", "targetname");
  var_15 = var_14 maps\_utility::spawn_ai();
  level.hesh = var_15;
  var_15.animname = "hesh";
  var_15 maps\_utility::magic_bullet_shield();
  var_15.weaponsound = "scn_home_r5rgp_hesh_fire";
  var_15 animscripts\init::initweapon("r5rgp+eotech_sp");
  var_15 animscripts\shared::placeweaponon("r5rgp+eotech_sp", "right");
  var_8 = common_scripts\utility::array_add(var_8, var_15);
  common_scripts\utility::flag_set("FLAG_house_attack_hesh_enter");
  maps\_utility::delaythread(1.2, common_scripts\utility::play_sound_in_space, "scn_home_upstairs_chopper_in", level.player.origin);
  level.player common_scripts\utility::delaycall(2.0, ::setclienttriggeraudiozone, "homecoming_upstairs_post_fight", 3.5);
  level.player notify("stop_player_heartbeat");
  maps\_utility::delaythread(3, maps\homecoming_util::player_hurt, undefined, 1);
  var_0 thread maps\_anim::anim_single(var_8, "house_attack_save");
  thread elias_house_attack_roof_explosion();
  common_scripts\utility::flag_wait("FLAG_house_attack_heli_over");
  var_16 = maps\_vehicle::spawn_vehicle_from_targetname("house_attack_ghost_heli");
  var_16 vehicle_turnengineoff();
  common_scripts\utility::flag_wait("FLAG_house_attack_ghosts_enter");
  level.player notify("stop_player_breathing");
  var_17 = getEntArray("house_attack_ghosts", "targetname");
  var_8 = [];
  var_18 = undefined;

  foreach(var_21, var_1 in var_17) {
    var_20 = var_1 maps\_utility::spawn_ai();
    var_20.animname = var_1.script_noteworthy;

    if(var_1.script_noteworthy == "merrick")
      var_18 = var_20;

    var_8 = common_scripts\utility::array_add(var_8, var_20);
  }

  var_8 = common_scripts\utility::array_add(var_8, maps\_utility::spawn_anim_model("rope1", (0, 0, 0)));
  var_8 = common_scripts\utility::array_add(var_8, maps\_utility::spawn_anim_model("rope2", (0, 0, 0)));
  var_0 thread maps\_anim::anim_single(var_8, "house_attack_save");
  var_22 = getanimlength(var_18 maps\_utility::getanim("house_attack_save"));
  var_23 = 1;
  var_24 = var_22 - var_23;
  wait(var_24);
  level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, level.player);
  level.black_overlay thread maps\_hud_util::fade_over_time(1, var_23);
  wait(var_23);
  setslowmotion(0.45, 1, 1);
  level.player lerpfov(65, 0.05);
  maps\_utility::array_delete(var_8);
  level.knife delete();
  var_16 delete();
  var_4 delete();
  maps\_utility::transient_switch("homecoming_transient_beach_tr", "homecoming_transient_recruits_tr");
  common_scripts\utility::flag_wait("homecoming_transient_recruits_tr_loaded");
  wait 0.5;
  common_scripts\utility::flag_set("FLAG_start_recruit_scene");
}

elias_house_attack_dialogue() {
  common_scripts\utility::flag_wait("FLAG_house_attack_hesh_enter");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_logan");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_shityourebleeding");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_holdonillget");
  common_scripts\utility::flag_wait("FLAG_house_attack_heli_over");
  level.hesh maps\_utility::dialogue_queue("homcom_hsh_getdown");
}

elias_house_attack_grab_sound() {
  common_scripts\utility::flag_wait("FLAG_house_attack_through_wall");
  level.player thread common_scripts\utility::play_sound_in_space("house_attack_wall");
}

elias_house_attack_grab_dof() {
  var_0 = 0.8;
  wait(var_0);
  thread maps\_art::dof_enable_script(0, 0, 0, 15, 25, 15, 0.1);
  maps\_utility::delaythread(1, maps\_art::dof_disable_script, 0.5);
  wait(9 - var_0);
  thread maps\_art::dof_enable_script(0, 0, 0, 15, 50, 15, 3);
}

elias_house_attack_hit_ground() {
  level.player shellshock("homecoming_attack", 60);
  setslowmotion(1, 0.3, 0.5);
  level.player dodamage(50 / level.player.damagemultiplier, level.player.origin);
  level.player lerpfov(45, 0.05);
  common_scripts\utility::waitframe();
  level.player lerpfov(65, 4);
  var_0 = maps\_hud_util::create_client_overlay("black", 0, level.player);
  var_0 thread maps\_hud_util::fade_over_time(0.4, 0.15);
  wait 0.3;
  level.player playrumbleonentity("damage_light");
  var_0 thread maps\_hud_util::fade_over_time(0, 0.15);
  wait 0.4;
  level.player playrumbleonentity("damage_light");
  wait 1.2;
  wait 0.65;
  setslowmotion(0.2, 1, 0.4);
  level.player fadeoutshellshock();
}

elias_house_attacker_breath_sequence(var_0) {
  wait 0.5;
  elias_house_attacker_breath(var_0);
}

elias_house_attack_knife_think(var_0, var_1) {
  level.player endon("player_knife_failed");
  level.player notifyonplayercommand("resist", "+activate");
  level.player notifyonplayercommand("resist", "+usereload");
  thread elias_house_attack_knife_hint_logic();
  thread elias_house_attack_knife_vision();
  setslowmotion(1, 0.1, 0.1);
  common_scripts\utility::flag_wait_or_timeout("FLAG_first_resist_press", 0.15);
  setslowmotion(0.1, 1, 0.1);
  level.player playrumblelooponentity("steady_rumble");
  var_0 waittill("house_attack_grab");

  if(!common_scripts\utility::flag("FLAG_first_resist_press")) {
    thread elias_house_attack_knife_fail_killplayer(var_0, var_1);
    return;
  }

  var_0 thread maps\_anim::anim_single(var_1, "house_attack_knife");
  thread elias_house_attack_knife_anim_logic(var_0, var_1);
  var_2 = getanimlength(var_1[0] maps\_utility::getanim("house_attack_knife"));
  wait 5;
  level.player notify("player_knife_resisted");
  level.player notify("stop_earthquake_loop");
  level.player common_scripts\utility::delaycall(0.7, ::stoprumble, "steady_rumble");
  level.resisthint destroy();
}

elias_house_attack_knife_anim_logic(var_0, var_1) {
  level.player endon("player_knife_failed");
  level.player endon("player_knife_resisted");
  elias_house_attack_knife_setupvariables();
  thread maps\homecoming_util::earthquake_loop(level.knifevariables["earthquake"]["current"]);
  level.player common_scripts\utility::waittill_notify_or_timeout("resist", 2);
  thread elias_house_attack_knife_fail(var_0, var_1);

  for(;;) {
    var_2 = level.player common_scripts\utility::waittill_notify_or_timeout_return("resist", 0.3);
    var_3 = 0;

    if(isDefined(var_2) && var_2 == "timeout")
      var_3 = 1;
    else
      thread elias_house_attack_knife_fail(var_0, var_1);

    var_4 = elias_house_attack_knife_getvariable("animrate", var_3);
    var_0 maps\_anim::anim_set_rate(var_1, "house_attack_knife", var_4);
    var_5 = elias_house_attack_knife_getvariable("earthquake", var_3);
    thread maps\homecoming_util::earthquake_loop(var_5);
  }
}

elias_house_attack_knife_fail(var_0, var_1) {
  level.player endon("resist");
  level.player endon("player_knife_resisted");
  wait 1;
  thread elias_house_attack_knife_fail_killplayer(var_0, var_1);
}

elias_house_attack_knife_fail_killplayer(var_0, var_1) {
  level.player notify("stop_earthquake_loop");
  level.player notify("player_knife_failed");
  thread maps\_art::dof_disable_script(0.05);
  level.player stoprumble("steady_rumble");
  var_0 thread maps\_anim::anim_single(var_1, "house_attack_knife_fail");
  common_scripts\utility::flag_wait("FLAG_attack_fail_kill_player");
  thread common_scripts\utility::play_sound_in_space("scn_home_upstairs_fight_stab_death", level.player.origin);
  var_0 maps\_anim::anim_set_rate(var_1, "house_attack_knife_fail", 0.5);
  var_2 = level.knife gettagorigin("TAG_FX");
  var_3 = anglesToForward(level.knife gettagangles("TAG_FX"));
  playFXOnTag(common_scripts\utility::getfx("player_stabbed"), level.knife, "tag_fx");
  wait 0.05;
  level.player playrumbleonentity("damage_heavy");
  level.player dodamage(999999, level.player.origin);
  wait 0.5;
  missionfailed();

  if(getdvarint("daniel"))
    iprintln("failed");
}

elias_house_attack_knife_getvariable(var_0, var_1) {
  var_2 = level.knifevariables[var_0];
  var_3 = level.knifevariables[var_0]["current"];

  if(var_1)
    var_3 = var_3 + var_2["increase"];
  else
    var_3 = var_3 - var_2["decrease"];

  if(var_3 >= var_2["max"])
    var_3 = var_2["max"];
  else if(var_3 <= var_2["min"])
    var_3 = var_2["min"];

  if(getdvarint("daniel"))
    iprintln(var_0 + " : " + var_3);

  level.knifevariables[var_0]["current"] = var_3;
  return var_3;
}

elias_house_attack_knife_setupvariables() {
  var_0 = [];
  var_0["animrate"] = [];
  var_0["animrate"]["current"] = 1;
  var_0["animrate"]["increase"] = 0.5;
  var_0["animrate"]["decrease"] = -0.01;
  var_0["animrate"]["max"] = 2;
  var_0["animrate"]["min"] = 0.2;
  var_0["earthquake"]["current"] = 0.1;
  var_0["earthquake"]["increase"] = 0.01;
  var_0["earthquake"]["decrease"] = -0.01;
  var_0["earthquake"]["max"] = 0.25;
  var_0["earthquake"]["min"] = 0.1;
  level.knifevariables = var_0;
}

elias_house_attack_knife_vision() {
  common_scripts\utility::flag_wait("FLAG_attacker_killing_player");
  level.player stoprumble("steady_rumble");
  level.player common_scripts\utility::delaycall(0.3, ::playrumblelooponentity, "steady_rumble");
  thread common_scripts\utility::play_sound_in_space("scn_home_upstairs_fight_stab", level.player.origin);
  level.player dodamage(25 / level.player.damagemultiplier, level.player.origin);
  playFXOnTag(common_scripts\utility::getfx("player_stabbed"), level.knife, "tag_origin");
  thread elias_house_blood_overlay();
  level.player maps\_utility::set_vision_set("homecoming_tower_middle", 0);
  var_0 = "homecoming_tower_middle";

  if(maps\_utility::game_is_current_gen())
    var_0 = "aftermath_hurt";

  while(!common_scripts\utility::flag("FLAG_house_attack_hesh_enter")) {
    var_1 = randomfloatrange(0.7, 0.9);
    level.player maps\_utility::set_vision_set(var_0, var_1);
    wait(var_1);

    if(var_0 == "homecoming_tower_middle") {
      var_0 = "homecoming_elias_secondfloor";
      continue;
    }

    var_0 = "homecoming_tower_middle";
  }

  if(var_0 == "homecoming_tower_middle") {
    var_1 = randomfloatrange(0.8, 1.2);
    level.player maps\_utility::set_vision_set(var_0, var_1);
    wait(var_1);
  }

  level.player maps\_utility::set_vision_set("", 2);
}

elias_house_blood_overlay() {
  var_0 = newclienthudelem(level.player);
  var_0.x = 0;
  var_0.y = 0;
  var_0.splatter = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.foreground = 0;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.enablehudlighting = 1;
  var_0 setshader("vfx_blood_screen_overlay", 640, 480);

  while(!common_scripts\utility::flag("FLAG_house_attack_hesh_enter")) {
    var_1 = randomfloatrange(0.5, 1);
    var_2 = randomfloatrange(0.5, 0.7);
    var_0 fadeovertime(var_1);
    var_0.alpha = var_2;
    wait(var_1);
    var_1 = randomfloatrange(0.5, 1);
    var_0 fadeovertime(var_1);
    var_0.alpha = 1;
    wait(var_1);
  }

  var_1 = 8;
  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 destroy();
}

elias_house_attack_knife_hint_logic() {
  level.player endon("player_knife_failed");
  level.player endon("player_knife_resisted");
  var_0 = elias_house_attack_knife_hint();
  level.resisthint = var_0;
  wait 0.1;
  level.player waittill("resist");
  common_scripts\utility::flag_set("FLAG_first_resist_press");
  thread common_scripts\utility::play_sound_in_space("scn_home_upstairs_fight_03", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("homcom_plyr_knifed", level.player.origin);
  thread common_scripts\utility::play_sound_in_space("homcom_death_justgiveupamerican", (-1381, 11982, 324));
  var_1 = 1;

  for(;;) {
    var_0.alpha = 0;
    wait 0.15;
    var_0.alpha = 1;
    wait 0.15;
  }
}

elias_house_attack_knife_hint() {
  var_0 = 90;
  var_1 = 35;
  var_2 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_2.y = var_0;
  var_2 set_default_hud_stuff();
  var_2.alpha = 1;
  var_2 settext(&"HOMECOMING_HINT_KNIFE_RESIST");
  return var_2;
}

set_default_hud_stuff() {
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 1;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0;
}

elias_house_attacker_breath_knife() {
  level.player endon("player_knife_resisted");

  for(;;) {
    elias_house_attacker_breath(level.attacker);
    wait(randomfloatrange(1, 1.5));
  }
}

elias_house_attack_door() {
  var_0 = getEntArray("elias_house_attack_door", "targetname");
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 maps\homecoming_util::parameters_check("model")) {
      var_2 = common_scripts\utility::array_add(var_2, var_4);
      continue;
    }

    var_1 = var_4;
  }

  foreach(var_4 in var_2)
  var_4 linkto(var_1);

  wait 0.7;
  var_8 = var_1.angles + (0, -50, 0);
  var_9 = 1.5;
  var_1 rotateto(var_8, 1.5, 0, var_9 / 2);
}

elias_house_attacker_breath(var_0) {
  var_1 = var_0 gettagorigin("j_head");
  var_2 = anglesToForward(var_0 gettagangles("tag_eye"));
  var_3 = anglestoup(var_0 gettagangles("tag_eye"));
  var_4 = var_1 + var_2 * -5 + var_3 * 1;
  playFX(common_scripts\utility::getfx("enemy_mask_breath"), var_4, var_2);
  wait 0.6;
  var_0 maps\_utility::play_sound_on_entity("house_attacker_breath");
}

elias_house_attack_pangles_check() {
  var_0 = level.player.angles;
  var_0 = var_0[1];

  if(var_0 <= -150 && var_0 >= -180)
    return 1;

  if(var_0 <= 180 && var_0 >= 160)
    return 1;

  return 0;
}

elias_house_attack_wall() {
  common_scripts\utility::flag_wait("FLAG_house_attack_through_wall");
  common_scripts\utility::exploder("house_wall_breach");
  level.player playrumbleonentity("artillery_rumble");
}

elias_house_attack_roof_explosion() {
  wait 9.5;
  common_scripts\utility::exploder("house_ceiling_breach");
  var_0 = (-1436, 11992, 548);
  maps\_utility::delaythread(0.8, common_scripts\utility::play_sound_in_space, "scn_homecoming_roof_entry", var_0);
  maps\_utility::delaythread(1.2, common_scripts\utility::play_sound_in_space, "scn_home_upstairs_transition_to_recruits_lr", var_0);
  maps\_utility::delaythread(5.0, common_scripts\utility::play_sound_in_space, "homcom_els_easysonyoullbeok", level.player.origin);
  level.player setclienttriggeraudiozone("homecoming_transition_to_black", 3.0);
  wait 1.2;
  level.player lerpfov(55, 0.05);
  level.player common_scripts\utility::delaycall(0.05, ::lerpfov, 65, 6.5);
  playrumbleonposition("artillery_rumble", var_0);
  level.player shellshock("homecoming_attack", 60);
  setblur(4.5, 0.05);
  common_scripts\utility::noself_delaycall(0.05, ::setblur, 0, 0.5);
  level.player thread maps\_gameskill::grenade_dirt_on_screen("right");
  earthquake(0.45, 1, var_0, 500);
  maps\_utility::stop_exploder("house_ceiling_breach");
  getent("elias_house_roof_dmg", "targetname") show();
  getent("elias_house_roof_intact", "targetname") delete();
}

attack_sound_setup() {
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.0);
  soundsettimescalefactor("Voice", 0.0);
  soundsettimescalefactor("effects2", 0.0);
  soundsettimescalefactor("local", 0.0);
  soundsettimescalefactor("physics", 0.0);
  soundsettimescalefactor("ambient", 0.0);
  soundsettimescalefactor("auto", 0.0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("shellshock", 0);
  soundsettimescalefactor("hurt", 0.25);
  soundsettimescalefactor("vehicle", 0.5);
  soundsettimescalefactor("effects1", 0);
}

house_firstfloor_exploder() {
  common_scripts\utility::exploder("house_ambient_firstfloor");
}

house_firstfloor_exploder_off() {
  maps\_utility::stop_exploder("house_ambient_firstfloor");
}

house_secondfloor_exploder() {
  common_scripts\utility::exploder("house_ambient_secondfloor");
}

house_secondfloor_exploder_off() {
  maps\_utility::stop_exploder("house_ambient_secondfloor");
}