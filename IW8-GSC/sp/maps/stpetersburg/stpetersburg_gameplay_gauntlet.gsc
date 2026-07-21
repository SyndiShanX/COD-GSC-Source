/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc
*******************************************************************/

gauntlet_init() {
  scripts\engine\utility::flag_init("flag_gauntlet_start");
  scripts\engine\utility::flag_init("flag_gauntlet_complete");
  scripts\engine\utility::flag_init("flag_gauntlet_stop_civ_spawns");
  scripts\engine\utility::flag_init("flag_gauntlet_start_civs");
  scripts\engine\utility::flag_init("flag_gauntlet_enforcer_hit_vig");
  scripts\engine\utility::flag_init("flag_gauntlet_enforcer_van_hit");
  scripts\engine\utility::flag_init("flag_gauntlet_enforcer_ground_impact");
  scripts\engine\utility::flag_init("flag_gauntlet_enforcer_recovered");
  scripts\engine\utility::flag_init("flag_gauntlet_enemies_spawn");
  scripts\engine\utility::flag_init("flag_gauntlet_battle_begin");
  scripts\engine\utility::flag_init("flag_gauntlet_battle_over");
  scripts\engine\utility::flag_init("flag_gauntlet_player_in_van");
  scripts\engine\utility::flag_init("flag_gauntlet_player_returning_fire");
  scripts\engine\utility::flag_init("flag_gauntlet_price_move_to_van");
  scripts\engine\utility::flag_init("flag_gauntlet_price_at_van");
  scripts\engine\utility::flag_init("flag_gauntlet_price_in_van");
  scripts\engine\utility::flag_init("flag_gauntlet_nikolai_carrying_enforcer");
  scripts\engine\utility::flag_init("flag_gauntlet_nikolai_in_van");
  scripts\engine\utility::flag_init("flag_gauntlet_nikolai_start_van");
  scripts\engine\utility::flag_init("flag_player_hit_by_first_car");
  scripts\engine\utility::flag_init("flag_gauntlet_van_smoking");
  scripts\engine\utility::flag_init("flag_gauntlet_van_damaged");
  scripts\engine\utility::flag_init("flag_gauntlet_van_on_fire");
  scripts\engine\utility::flag_init("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_init("flag_gauntlet_van_moving");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_car_1_stops");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_car_2_stops");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_car_3_stops");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_car_3_incoming");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_wave_1_dead");
  scripts\engine\utility::flag_init("flag_gauntlet_aq_wave_2_dead");
  scripts\engine\utility::flag_init("flag_gauntlet_van_damage_warning_playing");
  scripts\engine\utility::flag_init("flag_gauntlet_end_player_enter_van_fail");
  scripts\engine\utility::flag_init("flag_enforcer_custom_death");
  scripts\engine\utility::flag_init("flag_enforcer_anim_death");
  scripts\engine\utility::flag_init("flag_enforcer_killed");
  precachemodel("uk_storage_wall_light_01");
  precachemodel("uk_storage_wall_light_01_on");
}

gauntlet_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_gauntlet_player_in_van", "stpetersburg_cafe_script_tr", ["stpetersburg_interrogation_shared_script_tr", "stpetersburg_interrogation_intro_script_tr", "stpetersburg_interrogation_geo_tr"]);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("interrogation_start", ["stpetersburg_gauntlet_script_tr", "stpetersburg_periph_geo_tr"], undefined);
  thread gauntlet_vfx();
  thread gauntlet_hack_bench_badplace();
  setsaveddvar("TLOLRMSL", 0.01);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_gauntlet.gsc::gauntlet_vig_start();
  thread scripts\sp\analytics::analytics_kleenex_update("Van to interrogation");
  scripts\engine\utility::flag_set("flag_gauntlet_start_civs");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_price_heading_for_river();
  thread gauntlet_van_hit_vignette();
  thread gauntlet_weapon_pickup_handler();
  thread gauntlet_price_handler();
  thread gauntlet_containment_handler();
  thread gauntlet_enforcer_ragdoll_handler();
  scripts\engine\utility::flag_wait_all("flag_gauntlet_player_in_van", "flag_gauntlet_nikolai_in_van");
}

gauntlet_enforcer_ragdoll_handler() {
  level.player endon("death");
  level endon("missionfailed");

  while(!isDefined(level.enforcer))
    waitframe();

  scripts\engine\utility::flag_set("flag_enforcer_custom_death");
  level.enforcer.noragdoll = 1;
  level.enforcer scripts\engine\sp\utility::set_deathanim("run_death_facedown");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  scripts\engine\utility::flag_clear("flag_enforcer_custom_death");

  if(isDefined(level.enforcer)) {
    level.enforcer scripts\engine\sp\utility::clear_deathanim();
    level.enforcer.noragdoll = undefined;
  }
}

gauntlet_enforcer_ragdoll_clamp() {
  scripts\common\anim::anim_single_solo(self, "run_death_facedown");
}

gauntlet_vfx() {
  scripts\engine\utility::exploder("van_fx");
  scripts\engine\utility::exploder("birds_cluster");
  wait 1.75;
  scripts\engine\utility::exploder("birds_fly");
  scripts\engine\utility::kill_exploder("birds_cluster");
}

gauntlet_containment_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  scripts\engine\utility::flag_set("flag_start_gauntlet_containment");
}

gauntlet_price_handler() {
  level.player endon("death");
  level.enforcer endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("gauntlet_price_colors_1", "targetname", "activate");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::disable_ai_color();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  level.price scripts\common\utility::demeanor_override("sprint");
  var_0 = getnode("price_gauntlet_near_butcher_node", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var_0);
  var_1 = scripts\engine\utility::spawn_tag_origin(level.enforcer getEye(), level.enforcer.angles);
  var_1.origin = level.enforcer getEye();
  var_1 linkTo(level.enforcer, "tag_eye");
  level.price setentitytarget(var_1);
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  level.price clearentitytarget();
  var_1 delete();

  if(distance2dsquared(level.price.origin, level.enforcer.origin) < squared(200))
    level.price scripts\common\utility::demeanor_override("cqb");

  var_2 = scripts\engine\utility::getStruct("gauntlet_price_poi_south", "targetname");
  level.price scripts\common\ai::poi_enable(1, var_2);
  scripts\engine\utility::flag_wait("flag_gauntlet_price_move_to_van");
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price scripts\common\ai::poi_enable(0);
  var_3 = getEnt("car_hit_enforcer_org", "targetname");
  var_3 scripts\sp\anim::anim_reach_and_approach_solo(level.price, "stp_street_car_hit");
  var_3 scripts\common\anim::anim_single_solo(level.price, "stp_street_car_hit");
  var_3 thread scripts\common\anim::anim_loop_solo(level.price, "stp_street_car_hit_pickup_idle", "price_loop_end01");
  level.price scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\utility::flag_set("flag_gauntlet_price_at_van");
}

gauntlet_shootout_setup_van() {
  thread gauntlet_hack_bench_badplace();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("evade_enforcer_flee_node");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_monitor_health_handler(10);
  level.enforcer scripts\common\ai::gun_remove();

  if(!isDefined(level.nikolai))
    gauntlet_spawn_nikolai();

  var_0 = getEnt("car_hit_enforcer_org", "targetname");
  var_1 = getEnt("car_hit_enforcer", "targetname");
  var_1 scripts\engine\sp\utility::assign_animtree("car");
  var_1.animname = "car";
  var_1.godmode = 1;
  var_2 = [];
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_machinegun", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_rpg", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_grenades", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_shooting_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_entry_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_rack_l", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_rack_r", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_light", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_light_sparks_spot", "targetname"));

  foreach(var_4 in getEntArray("gauntlet_moving_van_clip", "targetname")) {
    var_4 scripts\engine\sp\utility::show_solid();
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  foreach(var_4 in getEntArray("van_item_clip", "targetname")) {
    var_4 scripts\engine\sp\utility::show_solid();
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  foreach(var_9 in getEntArray("van_impact_spot", "targetname"))
  var_2 = scripts\engine\utility::array_add(var_2, var_9);

  foreach(var_12 in var_2)
  var_12 linkTo(var_1, "tag_body_animate");

  gauntlet_van_attach_windows();
  level thread scripts\sp\utility::context_melee_enable(0);
  var_0 scripts\common\anim::anim_last_frame_solo(var_1, "stp_street_car_hit_exit");
  var_0 scripts\common\anim::anim_last_frame_solo(level.price, "stp_street_car_hit_pickup");
  var_0 scripts\common\anim::anim_last_frame_solo(level.nikolai, "stp_street_car_hit_pickup");
  var_0 thread scripts\common\anim::anim_loop_solo(level.enforcer, "stp_street_car_hit_idle02", "enforcer_loop_end02");
  waitframe();
  level.enforcer linkTo(var_1);
  thread gauntlet_enforcer_in_van_handler();
  thread gauntlet_weapon_pickup_handler();
  thread gauntlet_remove_enforcer_clip();
  scripts\engine\utility::flag_set("flag_gauntlet_player_in_van");
}

gauntlet_shootout_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_player_in_van();
  thread gauntlet_autosave_weapon_pickup();
  thread gauntlet_shootout_combat_handler();
  thread gauntlet_shootout_price_handler();
  thread gauntlet_shootout_police_arrive();
  thread gauntlet_shootout_autosave();
  scripts\engine\utility::flag_set("flag_end_player_wander_fail");
  gauntlet_set_van_health();
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
}

gauntlet_shootout_combat_handler() {
  level endon("flag_gauntlet_van_destroyed");

  if(scripts\engine\utility::flag("flag_gauntlet_battle_begin")) {
    return;
  }
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\engine\utility::flag_set("flag_gauntlet_battle_begin");
  thread gauntlet_init_threatbias();
  thread gauntlet_van_health_monitor();
  thread gauntlet_aq_spawn_handler();
  thread gauntlet_player_attackeraccuracy_handler();
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
  thread gauntlet_check_player_returning_fire();
  level.player allowjump(0);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_heavy"), level.van_smoke_fx_tag, "tag_origin");
  level.player.og_attackeraccuracy = level.player.attackeraccuracy;
  level.player scripts\sp\utility::set_player_attacker_accuracy(0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_police_incoming();
  thread gauntlet_aq_fighting_police();
  wait 10;
  scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_van_leaves();
  scripts\engine\utility::flag_set("flag_gauntlet_van_moving");
  thread gauntlet_swap_van_clip();
  thread gauntlet_aq_chasing_player_van();
  var_0 = getEnt("car_hit_enforcer_org", "targetname");
  var_1 = getEnt("car_hit_enforcer", "targetname");
  var_0 linkTo(var_1);
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var_1.link_org = spawn("script_origin", var_1.origin);
  var_1.link_org thread originlink(var_1);
  level.player playersetgroundreferenceent(var_1.link_org);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player enablehealthshield(1);
  scripts\sp\player::player_movement_state("creep");
  var_2 = getweaponarray();
  var_3 = getEnt("weapon_link", "targetname");

  foreach(var_5 in var_2) {
    if(ispointinvolume(var_5.origin, var_3))
      var_5 linkTo(var_1);
  }

  var_7 = getEnt("van_machinegun", "targetname");
  var_8 = getEnt("van_rpg", "targetname");

  if(isDefined(var_7))
    var_7 linkTo(var_1);

  if(isDefined(var_8))
    var_8 linkTo(var_1);

  thread audio_gauntlet_leave_sfx_transition();
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "stp_street_car_drive");
  var_9 = getanimlength(var_1 scripts\engine\utility::getanim("stp_street_car_drive")) - 5.25;
  wait(var_9 - 1.0);
  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  thread gauntlet_aq_clean_up_handler();
  thread gauntlet_van_to_interrogation();
  thread gauntlet_van_cleanup();
}

audio_gauntlet_leave_sfx_transition() {
  level.transition_snd_org = spawn("script_origin", level.player.origin);
  level.transition_snd_org linkTo(level.player);
  level.transition_snd_org thread scripts\engine\sp\utility::sound_fade_in("stp_canal_gauntlet_fade_out", 1.0, 3.0, 1);
  level.player setsoundsubmix("sp_st_pete_gauntlet_fade_outs", 2.0, 1.0);
  wait 3.0;
  level.transition_snd_org thread scripts\engine\sp\utility::sound_fade_and_delete(6, 1);
  wait 3.0;
  level.player clearsoundsubmix("sp_st_pete_gauntlet_fade_outs", 4.0);
}

originlink(var_0) {
  for(;;) {
    self.origin = var_0.origin;
    waitframe();
  }
}

gauntlet_player_attackeraccuracy_handler() {
  var_0 = scripts\common\utility::getdifficulty();

  if(var_0 == "easy")
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.1);
  else if(var_0 == "medium")
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.2);
  else if(var_0 == "hard")
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.3);
  else if(var_0 == "fu")
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.4);
}

gauntlet_check_player_returning_fire() {
  level endon("flag_gauntlet_complete");
  level.player endon("death");
  level endon("missionfailed");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("flag_gauntlet_player_returning_fire");
}

gauntlet_swap_van_clip() {
  var_0 = getEnt("gauntlet_van_clip", "targetname");
  var_0 movez(128, 0.1);
  var_1 = getEnt("gauntlet_van_drive_clip", "targetname");
  var_1 movez(128, 0.1);
  wait 0.2;
  var_0 connectpaths();
  var_1 disconnectPaths();
}

gauntlet_weapon_pickup_handler() {
  level endon("flag_gauntlet_complete");
  var_0 = getEnt("car_hit_enforcer", "targetname");
  var_1 = getEnt("van_machinegun", "targetname");
  var_2 = getEnt("van_rpg", "targetname");
  var_1 makeunusable();
  var_2 makeunusable();
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");

  if(!scripts\engine\utility::flag("flag_gauntlet_aq_car_1_stops"))
    thread scripts\engine\sp\utility::autosave_now_silent();

  var_1 unlink();
  var_2 unlink();
  var_1 makeusable();
  var_2 makeusable();
  thread gauntlet_increase_player_lmg_ammo();
  thread gauntlet_increase_player_grenades();
  thread gauntlet_grenade_interact();
}

gauntlet_grenade_interact() {
  var_0 = getEnt("van_grenades", "targetname");
  var_0.string = &"STPETERSBURG/PICKUP_FRAGS";
  var_1 = spawn("script_origin", var_0.origin);
  var_1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 4), var_0.string, undefined, 60, 120, 1);
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "trigger", level, "flag_gauntlet_van_moving");

  if(var_2 == "trigger")
    level.player scripts\engine\sp\utility::give_offhand("frag");

  var_1 delete();
}

gauntlet_autosave_weapon_pickup() {
  level endon("flag_gauntlet_aq_car_1_stops");
  level endon("flag_gauntlet_complete");
  level.player waittill("pickup");
  thread gauntlet_shootout_mb_windows();

  if(!scripts\engine\utility::flag("flag_gauntlet_aq_car_1_stops"))
    scripts\engine\sp\utility::autosave_or_timeout("van_weapon_pickedup", 3);
}

gauntlet_shootout_mb_windows() {
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_begin");
  wait 1.0;
  var_0 = scripts\engine\utility::getStruct("van_mb_source", "targetname");
  var_1 = [];
  var_2 = getscriptablearray("car_hit_enforcer_window_left", "targetname");

  while(var_2.size == 0) {
    var_2 = getscriptablearray("car_hit_enforcer_window_left", "targetname");
    waitframe();
  }

  var_1 = scripts\engine\utility::array_combine(var_1, var_2);
  var_3 = getscriptablearray("car_hit_enforcer_window_right", "targetname");

  while(var_3.size == 0) {
    var_3 = getscriptablearray("car_hit_enforcer_window_right", "targetname");
    waitframe();
  }

  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  var_1 = scripts\engine\utility::get_array_of_closest(level.player.origin, var_1);

  foreach(var_5 in var_1) {
    var_6 = var_5 getscriptablepartstate("base", 1);

    if(isDefined(var_6) && var_6 != "dead") {
      magicbullet("iw8_ar_akilo47", var_0.origin, var_5.origin + (0, 0, 8), level.price);
      wait(randomfloatrange(1.0, 2.0));
    }
  }
}

gauntlet_aq_fighting_police() {
  wait 1;
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_3", ::gauntlet_aq_chasing_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_3", ::gauntlet_aq_force_target_police_cars);
  scripts\engine\sp\utility::array_spawn_targetname("gauntlet_shootout_aq_wave_3");
}

gauntlet_aq_chasing_player_van() {
  wait 1;
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_4", ::gauntlet_aq_chasing_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_4", ::gauntlet_aq_force_target_police_cars);
  scripts\engine\sp\utility::array_spawn_targetname("gauntlet_shootout_aq_wave_4");
}

gauntlet_aq_chasing_handler() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_pacifist(1);
  var_0 = getnode(self.target, "targetname");

  if(isDefined(var_0)) {
    scripts\engine\sp\utility::set_goal_node(var_0);
    scripts\engine\sp\utility::set_goal_radius(16);
  } else {
    scripts\engine\sp\utility::set_goal_entity(level.player);
    scripts\engine\sp\utility::set_goal_radius(128);
  }

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  self delete();
}

gauntlet_van_hit_vignette() {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer scripts\common\ai::gun_remove();
  level.enforcer.animname = "enforcer";
  level.enforcer scripts\engine\sp\utility::set_allowdeath(1);
  var_0 = getEnt("car_hit_enforcer_org", "targetname");

  if(!isDefined(level.nikolai))
    gauntlet_spawn_nikolai();

  waitframe();
  level.nikolai scripts\engine\sp\utility::show_solid();
  var_1 = getEnt("car_hit_enforcer", "targetname");
  var_1 scripts\engine\sp\utility::assign_animtree("car");
  var_1.animname = "car";
  var_1.godmode = 1;
  var_2 = [];
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_machinegun", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_rpg", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_grenades", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_shooting_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_entry_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_spot", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_rack_l", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_weapon_rack_r", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_light", "targetname"));
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("van_light_sparks_spot", "targetname"));

  foreach(var_4 in getEntArray("gauntlet_moving_van_clip", "targetname")) {
    var_4 scripts\engine\sp\utility::show_solid();
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  foreach(var_4 in getEntArray("van_item_clip", "targetname")) {
    var_4 scripts\engine\sp\utility::show_solid();
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  foreach(var_9 in getEntArray("van_impact_spot", "targetname"))
  var_2 = scripts\engine\utility::array_add(var_2, var_9);

  foreach(var_12 in var_2)
  var_12 linkTo(var_1, "tag_body_animate");

  var_14 = getEnt("van_nikolai_door_clip", "targetname");
  var_15 = getEnt("van_price_door_clip", "targetname");
  var_14 linkTo(var_1, "tag_door_front_left");
  var_15 linkTo(var_1, "tag_door_front_right");
  gauntlet_van_attach_windows();
  var_16 = [var_1, level.enforcer, level.nikolai];
  var_0 scripts\common\anim::anim_first_frame(var_16, "stp_street_car_hit");

  while(!scripts\engine\utility::flag("flag_gauntlet_enforcer_hit_vig")) {
    var_17 = scripts\engine\sp\utility::within_fov_of_players(level.enforcer getEye(), cos(45));

    if(scripts\engine\utility::flag("flag_evade_cafe_pursuit_end") && var_17) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("flag_gauntlet_enforcer_hit_vig");
  thread walla_van_accident();
  thread gauntlet_police_sirens();
  var_1 thread gauntlet_van_engine();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_player_chase_enforcer();
  scripts\sp\player::player_movement_state("cqb");
  level.enforcer.skipdeathanim = 1;
  level thread scripts\sp\utility::context_melee_enable(0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::mus_enforcer_hit();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_player_approach_enforcer();
  thread gauntlet_enforcer_force_cold_breath();
  var_18 = getanimlength(level.nikolai scripts\engine\utility::getanim("stp_street_car_hit")) - 2.0;
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_nikolai_carrying_enforcer", var_18);
  var_0 thread scripts\common\anim::anim_single_solo(level.enforcer, "stp_street_car_hit");
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "stp_street_car_hit");
  var_0 scripts\common\anim::anim_single_solo(level.nikolai, "stp_street_car_hit");
  thread gauntlet_van_sunblocker_handler();
  thread gauntlet_remove_enforcer_clip();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_monitor_health_handler(10);
  thread gauntlet_enforcer_health_check_during_van_load();
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_price_move_to_van", 4.0);
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_enforcer_recovered", 9.0);
  thread gauntlet_enter_van_timer();
  thread gauntlet_enter_van_handler();
  scripts\engine\utility::flag_set("flag_gauntlet_nikolai_carrying_enforcer");
  level.enforcer thread gauntlet_actor_animate_single_then_loop("stp_street_car_hit_pickup", "stp_street_car_hit_idle02", "enforcer_loop_end02", "enforcer_loop_end", undefined, 1);
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "stp_street_car_hit_pickup");
  var_0 scripts\common\anim::anim_single_solo(level.nikolai, "stp_street_car_hit_pickup");
  scripts\engine\utility::flag_clear("flag_gauntlet_nikolai_carrying_enforcer");
  level.enforcer linkTo(var_1);
  thread gauntlet_enforcer_in_van_handler();
  level.nikolai thread gauntlet_actor_animate_single_then_loop("stp_street_car_hit_get_in", "stp_street_car_hit_idle02", "nikolai_loop_end02", undefined, "flag_gauntlet_nikolai_in_van", 1);
  level.nikolai scripts\engine\sp\utility::set_ignoreme(1);

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van"))
    var_0 scripts\common\anim::anim_single_solo(var_1, "stp_street_car_hit_nik_get_in");

  thread gauntlet_price_get_in_van();
}

walla_van_accident() {
  wait 1.9;
  var_0 = spawn("script_origin", (-3924, 2386, 114));
  var_0 playSound("stp_walla_crash_civs_grp_01", "sounddone");
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("stp_walla_crash_civs_man_01", (-3334, 2286, 114));
  wait 2;
  var_0 moveTo((-4284, 2712, 114), 3);
  var_0 waittill("sounddone");
  var_0 delete();
}

gauntlet_enforcer_force_cold_breath() {
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("cold_breath_run"), level.enforcer, "j_head");
}

gauntlet_enforcer_in_van_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.enforcer endon("death");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_set_low_fake_health();
  scripts\engine\utility::flag_set("flag_enforcer_custom_death");
  scripts\engine\utility::flag_set("flag_enforcer_anim_death");
  var_0 = getEnt("car_hit_enforcer_org", "targetname");
  var_1 = scripts\engine\utility::flag_wait_any_return("flag_enforcer_killed", "flag_gauntlet_van_moving");

  if(var_1 == "flag_enforcer_killed") {
    level.enforcer.noragdoll = 1;
    var_0 scripts\common\anim::anim_single_solo(level.enforcer, "stp_street_car_hit_death_enf");
  } else
    level notify("end_enforcer_monitor_health");

  scripts\engine\utility::flag_clear("flag_enforcer_custom_death");
}

gauntlet_price_get_in_van() {
  scripts\engine\utility::flag_wait("flag_gauntlet_price_at_van");
  var_0 = getEnt("car_hit_enforcer_org", "targetname");
  var_1 = getEnt("car_hit_enforcer", "targetname");
  var_0 notify("price_loop_end01");

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van"))
    var_0 thread scripts\common\anim::anim_single_solo(var_1, "stp_street_car_hit_price_get_in");

  var_0 scripts\common\anim::anim_single_solo(level.price, "stp_street_car_hit_get_in");
  level.price scripts\common\ai::gun_remove();
  scripts\engine\utility::flag_set("flag_gauntlet_price_in_van");
  var_0 notify("price_loop_end01");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "stp_street_car_hit_idle02", "price_loop_end02");
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
  level.price scripts\common\utility::clear_demeanor_override();
}

gauntlet_actor_animate_single_then_loop(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  var_6 = getEnt("car_hit_enforcer_org", "targetname");
  waitframe();

  if(isDefined(var_3))
    var_6 notify(var_3);

  var_6 endon(var_2);
  var_6 scripts\common\anim::anim_single_solo(self, var_0);

  if(isDefined(var_4))
    scripts\engine\utility::flag_set(var_4);

  if(isDefined(var_5)) {
    var_6 thread scripts\common\anim::anim_loop_solo(self, var_1, var_2);
    var_7 = getEnt("car_hit_enforcer", "targetname");
    self linkTo(var_7);
  } else
    var_6 thread scripts\common\anim::anim_loop_solo(self, var_1, var_2);
}

gauntlet_enforcer_health_check_during_van_load() {
  level endon("flag_gauntlet_complete");
  level endon("missionfailed");
  level.enforcer waittill("death");
  waitframe();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
}

gauntlet_remove_enforcer_clip() {
  var_0 = getEnt("gauntlet_butcher_collision_clip", "targetname");
  var_0 movez(-128, 0.1);
  wait 0.2;
  var_0 connectpaths();
}

gauntlet_enter_van_timer() {
  level endon("missionfailed");
  level.player endon("death");
  level.enforcer endon("death");
  level endon("flag_gauntlet_player_in_van");
  scripts\engine\utility::flag_wait("flag_gauntlet_price_in_van");
  thread gauntlet_shootout_combat_handler();
  scripts\engine\utility::flag_set("flag_gauntlet_enemies_spawn");
}

gauntlet_enter_van_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_recovered");
  var_0 = getEnt("gauntlet_moving_van_door_clip", "script_noteworthy");
  var_0 unlink();
  waitframe();
  var_0 movez(-512, 0.15, 0.05, 0.05);
  scripts\engine\sp\utility::trigger_wait_targetname("gauntlet_van_interior_trig");
  scripts\engine\utility::flag_set("flag_gauntlet_player_in_van");
  var_1 = getEnt("car_hit_enforcer_org", "targetname");
  var_2 = getEnt("car_hit_enforcer", "targetname");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  var_2 scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "stp_street_car_hit_exit");
  var_0.origin = var_0.origin + (0, 0, 512);
  var_2 = getEnt("car_hit_enforcer", "targetname");
  var_0 linkTo(var_2);
}

gauntlet_van_sunblocker_handler() {
  var_0 = getEnt("car_hit_enforcer", "targetname");
  var_1 = getEnt("gauntlet_moving_van_left_door_clip", "script_noteworthy");
  var_2 = getEnt("gauntlet_moving_van_top_clip", "script_noteworthy");
  var_1 hide();
  var_2 hide();

  while(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    var_3 = anglestoleft(var_0.angles);
    var_4 = vectorNormalize(level.player getorigin() - var_0.origin);
    var_5 = vectordot(var_3, var_4);

    if(var_5 < 0) {
      var_1 show();
      var_2 show();
    } else {
      var_1 hide();
      var_2 hide();
    }

    waitframe();
  }
}

gauntlet_aq_spawn_handler() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");
  scripts\engine\utility::flag_wait("flag_gauntlet_enemies_spawn");
  thread gauntlet_civilian_vehicles();
  wait 1;
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(0);
  thread gauntlet_aq_on_foot_spawner("gauntlet_shootout_aq_wave_1");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("gauntlet_aq_vehicle_riders", ::gauntlet_aq_state_handler);
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_1");
  var_0.animname = "skilo";
  var_0 thread gauntlet_aq_vehicle_movement_handler("stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  var_0 thread gauntlet_car_death_monitor(0);
  var_0 thread guantlet_first_car_collision_kill();
  wait 5;
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_2");
  var_1.animname = "skilo";
  var_1 thread gauntlet_aq_vehicle_movement_handler("stp_gauntlet_shootout_010_AQ_fight_arrive_VehB");
  var_1 thread gauntlet_car_death_monitor(0);
  wait 5;
  scripts\engine\utility::flag_wait_or_timeout("flag_gauntlet_aq_wave_1_dead", 5.0);
  var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_3");
  var_2.animname = "decho";
  var_2 thread gauntlet_aq_vehicle_movement_handler("stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  var_2.health = int(var_2.health * 1.2);
  var_2 thread gauntlet_car_death_monitor(1);
  scripts\engine\utility::flag_set("flag_gauntlet_aq_car_3_incoming");

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van"))
    level.van_health = -100;

  thread gauntlet_aq_on_foot_spawner("gauntlet_shootout_aq_wave_2");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_van_almost_leaves();
  wait 5;
  scripts\engine\utility::flag_wait_or_timeout("flag_gauntlet_aq_wave_2_dead", 5.0);
  thread gauntlet_aq_death_count_monitor();
  var_3 = scripts\common\utility::getdifficulty();
  var_4 = 20;

  if(var_3 == "hard" || var_3 == "fu")
    var_4 = 20;

  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_battle_over", var_4);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
}

gauntlet_police_sirens() {
  var_0 = spawn("script_origin", (-5700, 5300, 150));
  var_0 playLoopSound("stp_gauntlet_police_sirens_dist_lp");
  var_0 scalevolume(0);
  waitframe();
  var_0 scalevolume(0.3, 60);
  scripts\engine\utility::flag_wait("flag_gauntlet_enemies_spawn");
  var_0 scalevolume(1, 30);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
  var_0 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
  var_1 = spawn("script_origin", (-4200, 4400, 150));
  var_1 playLoopSound("stp_gauntlet_police_sirens_close_lp");
  var_1 scalevolume(0);
  waitframe();
  var_1 scalevolume(1, 10);
}

gauntlet_van_engine() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  waitframe();
  var_0 = 1;
  var_1 = ["gauntlet_van_engine_turn_over_01", "gauntlet_van_engine_turn_over_02", "gauntlet_van_engine_turn_over_03", "gauntlet_van_engine_turn_over_04", "gauntlet_van_engine_turn_over_05", "gauntlet_van_engine_turn_over_06", "gauntlet_van_engine_turn_over_07", "gauntlet_van_engine_turn_over_08"];
  var_2 = self;
  var_3 = var_2 gettagorigin("tag_hood");
  var_4 = spawn("script_model", var_3);
  var_4 linkTo(var_2, "tag_hood");
  var_5 = spawn("script_model", var_3);
  var_5 linkTo(var_2, "tag_hood");
  var_6 = var_2 gettagorigin("tag_light_back_right");
  var_7 = spawn("script_model", var_6 + (33, 25, -15));
  var_7 linkTo(var_2, "tag_light_back_right");
  var_8 = spawn("script_model", var_6 + (33, 25, -15));
  var_8 linkTo(var_2, "tag_light_back_right");
  var_2 playSound("stp_gauntlet_van_incoming");
  thread scripts\engine\utility::play_sound_in_space("stp_gauntlet_van_incoming_skid_echo", (-4583, 1434, 436));
  scripts\engine\utility::flag_wait("flag_gauntlet_nikolai_start_van");
  thread gauntlet_van_takeoff(var_5, var_8);

  while(!scripts\engine\utility::flag("flag_gauntlet_van_moving")) {
    var_9 = get_random_array_element_no_repeat(var_1, "engine_turn_over_aliases", 4);
    var_4 playSound(var_9 + "_front");
    var_7 playSound(var_9 + "_rear");

    if(!var_0) {
      wait(randomfloatrange(2, 3.5));
      continue;
    }

    wait 4;
    var_0 = 0;
  }

  var_4 scripts\engine\sp\utility::sound_fade_and_delete(1);
  var_7 scripts\engine\sp\utility::sound_fade_and_delete(1);
}

gauntlet_van_takeoff(var_0, var_1) {
  scripts\engine\utility::flag_wait("flag_gauntlet_van_moving");
  var_0 playSound("gauntlet_van_engine_takeoff_front");
  var_1 playSound("gauntlet_van_engine_takeoff_rear");
  level.player waittill("fade_out_van_engine");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(2);
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(2);
}

get_random_array_element_no_repeat(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 2;

  if(!isDefined(level._audio_random_array_dict))
    level._audio_random_array_dict = [];

  if(!isDefined(level._audio_random_array_dict[var_1]))
    level._audio_random_array_dict[var_1] = scripts\engine\utility::array_randomize(getarraykeys(var_0));

  if(level._audio_random_array_dict[var_1].size <= var_2) {
    var_3 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_array(getarraykeys(var_0), level._audio_random_array_dict[var_1]));
    level._audio_random_array_dict[var_1] = scripts\engine\utility::array_combine(var_3, level._audio_random_array_dict[var_1]);
  }

  var_4 = level._audio_random_array_dict[var_1][level._audio_random_array_dict[var_1].size - 1];
  level._audio_random_array_dict[var_1][level._audio_random_array_dict[var_1].size - 1] = undefined;
  return var_0[var_4];
}

gauntlet_car_death_monitor(var_0) {
  self endon("entitydeleted");

  if(var_0)
    var_1 = int(self.health * 0.2);
  else
    var_1 = int(self.health * 0.15);

  self.godmode = 1;

  if(!isDefined(level.gauntlet_aq_vehicle_destroyed))
    level.gauntlet_aq_vehicle_destroyed = 0;

  var_2 = getEnt(self.script_noteworthy + "_explosion_org", "targetname");
  var_2 linkTo(self);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_3 linkTo(self);
  var_4 = 80.0;
  var_5 = 24.0;
  var_6 = scripts\engine\utility::spawn_tag_origin(self.origin + anglesToForward(self.angles) * var_4 + (0, 0, var_5), self.angles);
  var_6 linkTo(self);
  var_7 = var_1 * 0.9;
  var_8 = var_1 * 0.6;
  var_9 = 0;
  var_10 = 0;

  while(var_1 > 0) {
    self waittill("damage", var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_12) && isDefined(var_15) && var_12 == level.player) {
      if(var_15 == "MOD_EXPLOSIVE" || var_15 == "MOD_PROJECTILE")
        var_11 = var_11 * 100;

      if(var_15 == "MOD_PROJECTILE_SPLASH" || var_15 == "MOD_GRENADE_SPLASH")
        var_11 = var_11 * 100;
    }

    var_1 = var_1 - var_11;

    if(var_1 < var_7 && var_9 == 0) {
      var_16 = playFXOnTag(scripts\engine\utility::getfx("vfx_car_fire_linger"), var_6, "tag_origin");
      var_9 = 1;
    }

    if(var_1 < var_8 && var_10 == 0) {
      var_16 = stopFXOnTag(scripts\engine\utility::getfx("vfx_car_fire_linger"), var_6, "tag_origin");
      var_17 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_smoke_large"), var_6, "tag_origin");
      var_10 = 1;
    }
  }

  scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  self.isdriving = 0;
  gauntlet_car_fx_stopper();
  self.godmode = 0;
  var_18 = getcorpsearrayinradius(self.origin, 128);
  thread scripts\engine\utility::array_call(var_18, ::setcorpseremovetimer, 0.1);
  waitframe();
  scripts\engine\sp\utility::die();
  var_17 = stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_smoke_large"), var_6, "tag_origin");
  var_19 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_fire_spread_decho"), var_3, "tag_origin");
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.4, 0.5, level.player.origin, 400);
  var_2 radiusdamage(var_2.origin, 300, 50, 1, undefined, "MOD_EXPLOSIVE", undefined, undefined, 0);
  level.gauntlet_aq_vehicle_destroyed++;
  var_20 = 5;
  var_21 = 250;
  badplace_cylinder("", var_20, var_2.origin, var_21, var_21, "axis");
  thread gauntlet_set_ai_in_range_to_pacifist(var_2.origin);
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var_2 delete();
  var_3 delete();
  var_6 delete();
}

gauntlet_civilian_vehicles() {
  var_0 = [];

  while(var_0.size == 0) {
    var_0 = getscriptablearray("gauntlet_civilian_vehicle", "targetname");
    wait 0.1;
  }

  foreach(var_2 in var_0)
  var_2 thread gauntlet_civilian_vehicle_explosion_handler();
}

gauntlet_aq_death_count_monitor() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");

  if(!isDefined(level.gauntlet_aq_dead))
    level.gauntlet_aq_dead = 0;

  if(!isDefined(level.gauntlet_aq_vehicle_destroyed))
    level.gauntlet_aq_vehicle_destroyed = 0;

  var_0 = scripts\common\utility::getdifficulty();
  var_1 = 10;

  if(var_0 == "easy")
    var_1 = 6;
  else if(var_0 == "medium" || var_0 == "hard")
    var_1 = 8;

  var_2 = 10;

  if(var_0 == "easy")
    var_2 = 2;
  else if(var_0 == "medium")
    var_2 = 3;

  while(!scripts\engine\utility::flag("flag_gauntlet_complete")) {
    if(level.gauntlet_aq_dead >= var_1 || level.gauntlet_aq_vehicle_destroyed >= var_2) {
      break;
    } else if(level.gauntlet_aq_dead >= var_1 * 0.8)
      scripts\engine\utility::flag_set("flag_gauntlet_aq_wave_2_dead");
    else if(level.gauntlet_aq_dead >= var_1 * 0.4)
      scripts\engine\utility::flag_set("flag_gauntlet_aq_wave_1_dead");

    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_gauntlet_battle_over");
}

gauntlet_increase_player_lmg_ammo() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_gauntlet_complete");
  var_0 = getEnt("van_machinegun", "targetname");
  var_0 waittill("trigger");

  for(;;) {
    var_1 = level.player getcurrentweapon();

    if(getweaponbasename(var_1) == "iw8_lm_kilo121") {
      break;
    }

    waitframe();
  }

  level.player setweaponammoclip(level.player.currentweapon, 120);
  level.player givemaxammo(level.player.currentweapon);
}

gauntlet_increase_player_grenades() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_gauntlet_complete");

  for(;;) {
    if(scripts\engine\sp\utility::player_has_equipment("frag")) {
      break;
    }

    waitframe();
  }

  var_0 = weaponmaxammo("frag");
  level.player setweaponammoclip("frag", var_0);
}

gauntlet_aq_on_foot_spawner(var_0) {
  scripts\engine\sp\utility::array_spawn_function_targetname(var_0, ::gauntlet_aq_runner_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname(var_0, ::gauntlet_aq_state_handler);
  var_0 = scripts\engine\sp\utility::array_spawn_targetname(var_0);
}

gauntlet_aq_state_handler() {
  self endon("death");
  self endon("entitydeleted");
  self.dontmelee = 1;
  scripts\engine\sp\utility::set_battlechatter(1);
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  self.forcelongdeath = 0;
  self setthreatbiasgroup("gauntlet_aq");
  thread gauntlet_aq_create_badplace_on_death();
  thread gauntlet_aq_force_target_van();
  var_0 = getEnt("gauntlet_aq_combat_vol", "targetname");
  self setgoalvolumeauto(var_0);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");

  for(;;) {
    wait 0.1;

    if(!isDefined(level.gauntlet_police_cars)) {
      continue;
    }
    if(level.gauntlet_police_cars.size > 0) {
      break;
    }
  }

  thread gauntlet_aq_force_target_police_cars();
}

gauntlet_aq_runner_handler() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::waittill_any_timeout(6.0, "damage");
  scripts\common\utility::clear_demeanor_override();
}

gauntlet_police_vehicle_lights(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = undefined;
  var_2 = undefined;

  if(var_0) {
    var_3 = (0, 0, 0);
    var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var_1 linkTo(self, "tag_origin", (8, 0, 61.25), var_3);
    var_1 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var_2 linkTo(self, "tag_origin", (-68, 0, 60.75), var_3);
    var_2 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  } else {
    var_3 = (0, 0, 0);
    var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var_1 linkTo(self, "tag_origin", (0, 0, 32.25), var_3);
    var_1 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  }

  scripts\engine\utility::waittill_any("death", "entitydeleted");

  if(isDefined(var_1)) {
    var_1 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var_2 delete();
  }
}

gauntlet_van_health_monitor() {
  level endon("flag_gauntlet_battle_over");
  level endon("flag_gauntlet_complete");
  level endon("flag_gauntlet_van_destroyed");
  level.player endon("death");
  level endon("missionfailed");
  gauntlet_set_van_health();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_init_van_damage_nags();
  var_0 = level.van_health * 0.8;
  var_1 = level.van_health * 0.6;
  var_2 = level.van_health * 0.4;
  var_3 = getEnt("car_hit_enforcer", "targetname");
  var_4 = getEntArray("gauntlet_moving_van_clip", "targetname");
  scripts\engine\utility::array_thread(var_4, ::gauntlet_van_bullethit_monitor);
  var_5 = getEnt("van_shooting_spot", "targetname");
  level.van_smoke_fx_tag = scripts\engine\utility::spawn_tag_origin(var_5.origin, var_5.angles);
  level.van_smoke_fx_tag linkTo(var_3, "tag_body_animate");
  level.van_bullethole_fx_tag = scripts\engine\utility::spawn_tag_origin(var_5.origin + (0, 0, 0), var_5.angles + (0, 180, 0));
  level.van_bullethole_fx_tag linkTo(var_3, "tag_body_animate");
  level.van_impact_ents = getEntArray("van_impact_spot", "targetname");
  waitframe();

  while(!scripts\engine\utility::flag("flag_gauntlet_van_destroyed")) {
    if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van") && scripts\engine\utility::flag("flag_gauntlet_battle_over"))
      level.van_health = 0;

    if(level.van_health <= var_0 && !scripts\engine\utility::flag("flag_gauntlet_van_smoking")) {
      var_6 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_light"), level.van_smoke_fx_tag, "tag_origin");
      var_7 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_lite"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(0);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_van_damage_warning();
      thread scripts\engine\utility::play_sound_in_space("scn_stp_van_tire_pop_hiss", level.player.origin + (100, 0, 0));
      thread audio_play_bullet_impacts_around_player(0);
      scripts\engine\utility::flag_set("flag_gauntlet_van_smoking");

      if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van"))
        level.van_health = 0;
    }

    if(level.van_health <= var_1 && !scripts\engine\utility::flag("flag_gauntlet_van_damaged")) {
      var_8 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_med"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(1);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_van_damage_warning();
      thread scripts\engine\utility::play_sound_in_space("scn_stp_van_radiator_pop_hiss", level.player.origin + (100, 100, 0));
      thread audio_play_bullet_impacts_around_player(1);
      scripts\engine\utility::flag_set("flag_gauntlet_van_damaged");
    }

    if(level.van_health <= var_2 && !scripts\engine\utility::flag("flag_gauntlet_van_on_fire")) {
      var_9 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_heavy"), level.van_smoke_fx_tag, "tag_origin");
      var_10 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_high"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(2);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_gauntlet_van_damage_warning();
      thread scripts\engine\utility::play_sound_in_space("scn_stp_van_fire_startup", level.player.origin + (-100, 100, 0));
      thread audio_play_bullet_impacts_around_player(2);
      scripts\engine\utility::flag_set("flag_gauntlet_van_on_fire");
    }

    if(level.van_health <= 0) {
      break;
    }

    wait 0.1;
  }

  thread gauntlet_shootout_van_destroyed();
  scripts\engine\utility::flag_set("flag_gauntlet_van_destroyed");
}

gauntlet_van_damage_impact(var_0) {
  switch (var_0) {
    case 0:
      var_1 = "vfx_stpburg_door_impact_lite";
      var_2 = 0.3;
      var_3 = 0.5;
      var_4 = "damage_light";
      break;
    case 1:
      var_1 = "vfx_stpburg_door_impact_med";
      var_2 = 0.5;
      var_3 = 0.8;
      var_4 = "damage_bullet";
      var_5 = getEnt("van_light_sparks_spot", "targetname");
      playFX(scripts\engine\utility::getfx("vfx_stpburg_van_light_sparks"), var_5.origin);
      break;
    case 2:
      var_1 = "vfx_stpburg_door_impact_high";
      var_2 = 0.8;
      var_3 = 1.0;
      var_4 = "grenade_rumble";
      break;
    default:
      var_1 = "vfx_stpburg_door_impact_lite";
      var_2 = 0.3;
      var_3 = 0.5;
      var_4 = "damage_light";
  }

  var_6 = scripts\engine\utility::get_array_of_closest(level.player getEye(), level.van_impact_ents);
  playrumbleonposition(var_4, var_6[0].origin);
  earthquake(var_2, var_3, var_6[0].origin, 400);
  playFX(scripts\engine\utility::getfx(var_1), var_6[0].origin);
  level.van_impact_ents = scripts\engine\utility::array_remove(level.van_impact_ents, var_6[0]);
}

audio_play_bullet_impacts_around_player(var_0) {
  var_1 = randomfloatrange(-120.0, 120.0);
  var_2 = randomfloatrange(-120.0, 120.0);
  var_3 = var_0 * 2 + randomintrange(2, 4);

  for(var_4 = 0; var_4 <= var_3; var_4 = var_4 + 1) {
    thread scripts\engine\utility::play_sound_in_space("scn_stp_bullet_impact_on_van", level.player.origin + (var_1, var_2, 0));
    wait(randomfloatrange(0.08, 0.12));
  }
}

gauntlet_shootout_van_destroyed() {
  var_0 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_fire"), level.van_smoke_fx_tag, "tag_origin");
  wait 1;
  playrumbleonposition("heavy_1s", level.player.origin);
  earthquake(0.8, 1.0, level.player.origin, 800);
  var_1 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_explosion_civ"), level.van_smoke_fx_tag, "tag_origin");
  var_2 = getEnt("car_hit_enforcer", "targetname");
  var_2 setModel("veh8_civ_lnd_palfa_static_dst_east");
  var_2 radiusdamage(var_2.origin, 150, 400, 200, undefined, undefined, undefined, undefined, 0);
  physicsexplosionsphere(var_2.origin, 600, 200, 30);
  wait 0.1;

  if(isDefined(level.player)) {
    if(scripts\engine\utility::flag("flag_gauntlet_player_in_van"))
      level.player kill();
    else {
      var_3 = scripts\engine\utility::distance_2d_squared(level.player.origin, var_2.origin);

      if(var_3 < squared(200)) {
        var_4 = level.player.origin - var_2.origin;
        var_4 = vectorNormalize(var_4);
        var_5 = (squared(250) - var_3) * 0.0005;
        level.player pushplayervector(var_4 * var_5 + (0, 0, 5), 1);
      }
    }
  }

  scripts\sp\player_death::set_custom_death_quote(90);
  thread scripts\sp\utility::missionfailedwrapper();
}

gauntlet_van_bullethit_monitor() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flag_gauntlet_complete");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");
  self setCanDamage(1);
  self.health = 999999999;
  var_0 = 5.0;
  var_1 = 4.0;
  var_2 = 2.0;
  var_3 = 0.2;

  while(!scripts\engine\utility::flag("flag_gauntlet_battle_over")) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_5)) {
      if(var_5 == level.player)
        var_4 = var_4 * var_3;
      else if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
        var_4 = var_4 * var_0;
        var_0 = var_0 * 2.0;
      } else {
        if(level.player getstance() == "prone")
          var_4 = var_4 * var_1;

        if(level.player getstance() == "crouch")
          var_4 = var_4 * var_2;
      }

      level.van_health = level.van_health - var_4;
    }

    wait 0.1;
  }
}

gauntlet_van_create_bullethole(var_0) {
  var_1 = "vfx_stpburg_door_bullethole_ch_1";

  if(scripts\engine\utility::cointoss())
    var_1 = "vfx_stpburg_door_bullethole_ch_2";

  var_2 = getEnt("car_hit_enforcer", "targetname");
  var_3 = var_0 + anglesToForward(var_2.angles) * 80;
  var_4 = scripts\engine\trace::ray_trace(var_3, var_0);

  if(isDefined(var_4["entity"])) {
    var_5 = var_4["entity"];

    if(!isDefined(var_5.script_noteworthy) || var_5.script_noteworthy != "gauntlet_moving_van_clip_back") {
      if(scripts\engine\utility::cointoss())
        gauntlet_van_create_random_bullethole();

      return;
    }
  }

  var_6 = var_4["position"];
  var_7 = anglesToForward(vectortoangles(var_4["normal"]));
  var_8 = playFX(scripts\engine\utility::getfx(var_1), var_6, var_7);
}

gauntlet_van_create_random_bullethole() {
  var_0 = getEntArray("gauntlet_moving_van_clip_back", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0].origin;
  var_1 = var_1 + (randomintrange(-15, 15), 0, randomintrange(-15, 15));
  thread gauntlet_van_create_bullethole(var_1);
}

gauntlet_civilian_vehicle_explosion_handler() {
  level endon("flag_gauntlet_complete");
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt(self.script_noteworthy + "_center", "targetname");
  self waittillmatch("scriptableNotification", "onfire");
  var_1 = 5;
  var_2 = 200;
  badplace_cylinder("", var_1, var_0.origin, var_2, var_2, "axis");
  self waittillmatch("scriptableNotification", "anim_explosion");
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.4, 0.5, level.player.origin, 400);
  var_0 radiusdamage(var_0.origin, 250, 20, 1, undefined, "MOD_EXPLOSIVE", undefined, undefined, 0);
  thread gauntlet_set_ai_in_range_to_pacifist(var_0.origin);
}

gauntlet_set_ai_in_range_to_pacifist(var_0) {
  var_1 = scripts\common\utility::getdifficulty();
  var_2 = squared(400);
  var_3 = randomfloatrange(6.0, 9.0);

  if(var_1 == "easy") {
    var_2 = squared(450);
    var_3 = randomfloatrange(8.0, 12.0);
  } else if(var_1 == "fu") {
    var_2 = squared(350);
    var_3 = randomfloatrange(4.0, 6.0);
  }

  var_4 = var_2 * 0.5;
  var_5 = var_3 * 0.5;
  var_6 = getaiarray("axis");
  var_6 = scripts\engine\utility::array_removedead_or_dying(var_6);

  foreach(var_8 in var_6) {
    var_9 = distance2dsquared(var_0, var_8.origin);

    if(var_9 <= var_4)
      var_8 thread scripts\anim\combat_utility.gsc::flashbangstart(var_5);

    if(var_9 <= var_2) {
      var_8 scripts\engine\sp\utility::set_pacifist(1);
      var_8 scripts\engine\sp\utility::enable_dontevershoot();
      var_8 scripts\engine\utility::delaythread(var_3, scripts\engine\sp\utility::set_pacifist, 0);
      var_8 scripts\engine\utility::delaythread(var_5, scripts\engine\sp\utility::disable_dontevershoot);
    }
  }
}

gauntlet_aq_vehicle_movement_handler(var_0) {
  self endon("entitydeleted");
  self endon("death");
  var_1 = undefined;

  while(!isDefined(self))
    waitframe();

  var_2 = getEnt(self.script_noteworthy + "_drive_vol", "targetname");
  var_3 = scripts\engine\utility::getStruct("aq_vehicle_drive_struct", "targetname");
  wait 0.2;
  var_4 = "flag_" + self.script_noteworthy + "_stops";
  thread gauntlet_aq_vehicle_driver_death_handler(var_0, var_4);
  thread gauntlet_aq_vehicle_cleanup(var_4);
  var_5 = "vehA_";

  if(var_0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA") {
    var_1 = "stp_car1_gauntlet_drive_in";
    var_5 = "vehA_";
  } else if(var_0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB") {
    var_1 = "stp_car2_gauntlet_drive_in";
    var_5 = "vehB_";
  } else if(var_0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC") {
    var_1 = "stp_car3_gauntlet_drive_in";
    var_5 = "vehC_";
  }

  if(isDefined(var_1))
    self playSound(var_1);

  self.isdriving = 1;
  gauntlet_car_fx_handler(var_5);
  var_3 scripts\common\anim::anim_single_solo(self, var_0);
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_set(var_4);
  self.isdriving = 0;
  gauntlet_car_fx_stopper();
  wait 0.1;

  if(isDefined(self.riders) && self.riders.size > 0)
    scripts\common\vehicle::vehicle_unload();
}

gauntlet_car_fx_handler(var_0) {
  self.fx_tags = [];
  self.fx_tags["front_right"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_front_right"), self gettagangles("tag_wheel_front_right"));
  self.fx_tags["front_right"] linkTo(self, "tag_wheel_front_right");
  self.fx_tags["back_right"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_back_right"), self gettagangles("tag_wheel_back_right"));
  self.fx_tags["back_right"] linkTo(self, "tag_wheel_back_right");
  self.fx_tags["front_left"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_front_left"), self gettagangles("tag_wheel_front_left"));
  self.fx_tags["front_left"] linkTo(self, "tag_wheel_front_left");
  self.fx_tags["back_left"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_back_left"), self gettagangles("tag_wheel_back_left"));
  self.fx_tags["back_left"] linkTo(self, "tag_wheel_back_left");

  foreach(var_3, var_2 in self.fx_tags)
  var_2 thread gauntlet_car_wheel_fx_handler(var_0, var_3, self);
}

gauntlet_car_wheel_fx_handler(var_0, var_1, var_2) {
  self endon("entitydeleted");
  var_3 = var_0 + var_1;
  var_4 = var_3 + "_splash_on";
  var_5 = var_3 + "_splash_off";
  var_6 = var_3 + "_splash02_on";
  var_7 = var_3 + "_splash02_off";
  var_8 = var_3 + "_dust_on";
  var_9 = var_3 + "_dust_off";

  while(isDefined(var_2) && var_2.isdriving == 1) {
    var_10 = level scripts\engine\utility::waittill_any_return(var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_10 == var_4)
      self.splashfx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");
    else if(var_10 == var_5)
      self.splashfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");
    else if(var_10 == var_6)
      self.splash02fx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");
    else if(var_10 == var_7)
      self.splash02fx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");
    else if(var_10 == var_8)
      self.dustfx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");
    else if(var_10 == var_9)
      self.dustfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");

    waitframe();
  }

  thread gauntlet_car_wheel_fx_stopper();
}

gauntlet_car_fx_stopper() {
  if(!isDefined(self)) {
    return;
  }
  foreach(var_1 in self.fx_tags)
  var_1 thread gauntlet_car_wheel_fx_stopper();
}

gauntlet_car_wheel_fx_stopper() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.splashfx))
    self.splashfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");

  if(isDefined(self.splash02fx))
    self.splash02fx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");

  if(isDefined(self.dustfx))
    self.dustfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");

  self delete();
}

gauntlet_aq_vehicle_driver_death_handler(var_0, var_1) {
  self endon("entitydeleted");
  self endon("death");
  level endon(var_1);
  self.donotunloadondriverdeath = 1;
  var_2 = get_vehicle_driver();

  if(isDefined(var_2)) {
    var_2 waittill("death");

    if(self getanimtime(scripts\engine\utility::getanim(var_0)) < 0.9) {
      var_3 = 1.0;

      for(var_4 = 0; var_4 < 5; var_4++) {
        self setanimrate(scripts\engine\utility::getanim(var_0), var_3 - 0.2);
        wait 0.1;
      }

      scripts\engine\sp\utility::anim_stopanimScripted();
      self.isdriving = 0;
      thread gauntlet_vehicle_unload();
      self notify("driver_killed");
    }
  }
}

gauntlet_vehicle_unload() {
  self endon("entitydeleted");
  self endon("death");
  wait 1;

  if(isDefined(self.riders) && self.riders.size > 0)
    scripts\common\vehicle::vehicle_unload();
}

get_vehicle_driver() {
  foreach(var_1 in self.riders) {
    if(isDefined(var_1.vehicle_position) && var_1.vehicle_position == 0)
      return var_1;
  }

  return undefined;
}

gauntlet_aq_vehicle_cleanup(var_0) {
  var_1 = scripts\engine\utility::waittill_any_ents_return(self, "death", self, "driver_killed", level, var_0);
  var_2 = getEnt(self.script_noteworthy + "_clip", "targetname");

  if(isDefined(self))
    self disconnectPaths();
  else
    var_2 disconnectPaths();

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var_2 delete();

  if(isDefined(self))
    self delete();
}

gauntlet_aq_create_badplace_in_combat() {
  level endon("flag_gauntlet_complete");
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_gauntlet_complete")) {
    var_0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby");
    scripts\engine\sp\utility::set_force_cover(1);
    scripts\engine\sp\utility::enable_dontevershoot();

    switch (var_0) {
      case "damage":
        var_1 = 128;
        var_2 = 6.0;
        break;
      case "bulletwhizby":
        var_1 = 96;
        var_2 = 4.0;
        break;
      default:
        var_1 = 64;
        var_2 = 2.0;
    }

    badplace_cylinder("", var_2, self.origin, var_1, var_1, "axis");
    wait(randomfloatrange(7.0, 13.0));
    scripts\engine\sp\utility::set_force_cover(0);
    scripts\engine\sp\utility::disable_dontevershoot();
  }
}

gauntlet_aq_create_badplace_on_death() {
  self endon("entitydeleted");

  if(!isDefined(level.gauntlet_aq_dead))
    level.gauntlet_aq_dead = 0;

  self waittill("death");
  var_0 = 96;
  var_1 = 4.0;
  badplace_cylinder("", var_1, self.origin, var_0, var_0, "axis");
  level.gauntlet_aq_dead++;
}

gauntlet_van_to_interrogation() {
  level endon("flag_gauntlet_van_destroyed");
  level endon("missionfailed");
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.blackoverlay fadeovertime(2);
  level.blackoverlay.alpha = 1;
  level.player notify("fade_out_van_engine");
  wait 2;
  level.player enabledeathshield(1);
  level.player enableinvulnerability();
  level.player disableweapons();
  level.player allowmounttop(0);
  level.player allowmountside(0);

  if(isDefined(level.van_smoke_fx_tag))
    level.van_smoke_fx_tag delete();

  wait 2;

  if(!isalive(level.player)) {
    return;
  }
  var_0 = getEnt("car_hit_enforcer_org", "targetname");
  var_0 notify("van_loop_end02");
  var_0 notify("nikolai_loop_end02");
  var_0 notify("enforcer_loop_end02");
  var_0 notify("price_loop_end02");

  if(isDefined(level.van_fx_tag))
    level.van_fx_tag delete();

  level.enforcer unlink();
  level.nikolai unlink();
  level.price unlink();
  level.player unlink();
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(1);
  level.player scripts\sp\player::set_normalhealth(1);
  level.player enablehealthshield(0);
  level.player allowmounttop(1);
  level.player allowmountside(1);
  level.player allowmovement(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowjump(1);
  scripts\sp\player::player_movement_state("default");
  scripts\sp\utility::delete_live_grenades();
  clearallcorpses();
  level.player scripts\sp\player::remove_damage_effects_instantly();
  level.player takeallweapons();
  level.player clearhudtutorialmessage();
  level.player enableweapons();
  level.player enabledeathshield(0);
  level.player disableinvulnerability();
  scripts\engine\utility::flag_set("flag_gauntlet_complete");
}

gauntlet_aq_clean_up_handler() {
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var_0 = getaiarray("axis", "neutral");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  scripts\engine\utility::array_delete(var_0);
}

gauntlet_van_cleanup() {
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var_0 = getEnt("van_machinegun", "targetname");
  var_1 = getEnt("van_rpg", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(var_1))
    var_1 delete();
}

gauntlet_shootout_price_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
  level.price scripts\engine\sp\utility::hide_notsolid();
  level.nikolai scripts\engine\sp\utility::hide_notsolid();
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  level.price scripts\engine\sp\utility::show_solid();
  level.nikolai scripts\engine\sp\utility::show_solid();
  level.price scripts\engine\sp\utility::set_ignoreme(0);
  level.nikolai scripts\engine\sp\utility::set_ignoreme(0);
}

gauntlet_spawn_nikolai() {
  scripts\engine\sp\utility::array_spawn_function_targetname("nikolai", scripts\common\utility::demeanor_override, "casual");
  level.nikolai = scripts\engine\sp\utility::spawn_targetname("nikolai", 1);
  level.nikolai.name = "Nikolai";
  level.nikolai.animname = "nikolai";
  level.nikolai.script_friendname = "Nikolai";
  level.nikolai.script_parameters = "Nikolai";
  level.nikolai.disableplayeradsloscheck = 1;
  level.nikolai.script_pushable = 0;
  level.nikolai.disablebulletwhizbyreaction = 1;
  level.nikolai.dontavoidplayer = 1;
  level.nikolai pushplayer(1);
  level.nikolai thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
}

gauntlet_init_threatbias() {
  createthreatbiasgroup("gauntlet_police");
  createthreatbiasgroup("gauntlet_aq");
  createthreatbiasgroup("gauntlet_allies");
  setthreatbias("gauntlet_police", "gauntlet_aq", 1000);
  setthreatbias("gauntlet_aq", "gauntlet_police", 1000);
  setthreatbias("gauntlet_police", "gauntlet_allies", -1000);
}

gauntlet_shootout_police_arrive() {
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("gauntlet_police", ::gauntlet_police_handler);
  var_0 = vehicle_getspawnerarray("gauntlet_police_car_1");
  var_0[0].script_dontunloadonend = 1;
  var_1 = vehicle_getspawnerarray("gauntlet_police_car_2");
  var_1[0].script_dontunloadonend = 1;
  var_2 = vehicle_getspawnerarray("gauntlet_police_car_3");
  var_2[0].script_dontunloadonend = 1;
  var_3 = vehicle_getspawnerarray("gauntlet_police_car_4");
  var_3[0].script_dontunloadonend = 1;
  var_4 = vehicle_getspawnerarray("gauntlet_police_car_5");
  var_4[0].script_dontunloadonend = 1;
  waitframe();
  var_5 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_1");
  var_5.godmode = 1;
  var_5 vehicle_setspeed(35, 32, 16);
  var_5 thread gauntlet_police_vehicle_lights(1);
  var_5 thread gauntlet_police_car_array_setup(100);
  var_6 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_2");
  var_6.godmode = 1;
  var_6 vehicle_setspeed(30, 28, 14);
  var_6 thread gauntlet_police_vehicle_lights(0);
  var_7 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_3");
  var_7.godmode = 1;
  var_7 vehicle_setspeed(25, 22, 11);
  var_7 thread gauntlet_police_vehicle_lights(1);
  var_8 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_4");
  var_8.godmode = 1;
  var_8 vehicle_setspeed(35, 30, 15);
  var_8 thread gauntlet_police_vehicle_lights(0);
  var_8 thread gauntlet_police_car_array_setup(80);
  scripts\engine\utility::flag_wait("flag_gauntlet_van_moving");
  var_9 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_5");
  var_9.godmode = 1;
  var_9 vehicle_setspeed(25, 22, 11);
  var_9 thread gauntlet_police_vehicle_lights(1);
  var_9 thread gauntlet_police_car_array_setup(-100);
}

gauntlet_police_car_array_setup(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self waittill("reached_end_node");

  if(!isDefined(level.gauntlet_police_cars))
    level.gauntlet_police_cars = [];

  var_1 = anglestoup(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = scripts\engine\utility::spawn_script_origin(self.origin + var_1 * abs(var_0) + var_2 * var_0);
  level.gauntlet_police_cars = scripts\engine\utility::array_add(level.gauntlet_police_cars, var_3);
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var_3 delete();
}

gauntlet_police_handler() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_baseaccuracy(0.3);
  scripts\engine\sp\utility::set_attackeraccuracy(0.5);
  self.dontmelee = 1;
  scripts\engine\sp\utility::set_battlechatter(1);
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  self.forcelongdeath = 0;
  self.setciviliankillcount = 1;
  self setthreatbiasgroup("gauntlet_police");
  self.health = 300;
  self.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.5);
  self actoraimassistoff();
  thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  self delete();
}

gauntlet_van_light_on() {
  var_0 = getEnt("van_light", "targetname");
  var_0 setModel("uk_storage_wall_light_01_on");
}

gauntlet_van_light_off() {
  var_0 = getEnt("van_light", "targetname");
  var_0 setModel("uk_storage_wall_light_01");
}

gauntlet_van_attach_windows() {
  var_0 = getEnt("car_hit_enforcer", "targetname");
  var_1 = getscriptablearray("car_hit_enforcer_window_left", "targetname");

  while(var_1.size == 0) {
    var_1 = getscriptablearray("car_hit_enforcer_window_left", "targetname");
    waitframe();
  }

  foreach(var_3 in var_1) {
    var_3 enablelinkTo();
    var_3 linkTo(var_0, "tag_window_rear_left");
  }

  var_5 = getscriptablearray("car_hit_enforcer_window_right", "targetname");

  while(var_5.size == 0) {
    var_5 = getscriptablearray("car_hit_enforcer_window_right", "targetname");
    waitframe();
  }

  foreach(var_3 in var_5) {
    var_3 enablelinkTo();
    var_3 linkTo(var_0, "tag_window_rear_right");
  }
}

gauntlet_set_van_health() {
  var_0 = scripts\common\utility::getdifficulty();
  level.van_health = 24000;

  if(var_0 == "easy")
    level.van_health = 28000;
  else if(var_0 == "medium")
    level.van_health = 26000;
}

spawnlootitemsuspended(var_0, var_1, var_2, var_3, var_4) {
  if(tolower(var_0) == "ballistic vest" && !scripts\common\utility::playerarmorenabled()) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = scripts\engine\utility::randomvectorrange(0, 360);

  var_5 = scripts\sp\script_items::scriptitem_buildspawnflags(1, 0, 1, 0, 1);
  var_6 = level.loot.types[var_0].model;
  var_7 = (randomfloat(0.5), randomfloat(0.5), 1) * var_3;
  var_8 = spawnscriptitem("script_item_" + var_0, var_1, var_2, var_5, var_6, "", var_7, var_1);

  if(getdvarint("loot_beam_test") == 1) {
    switch (var_8.model) {
      case "loot_frag":
        playFXOnTag(scripts\engine\utility::getfx("loot_grenade"), var_8, getpartname(var_8.model, 0));
        break;
      case "loot_flash":
        playFXOnTag(scripts\engine\utility::getfx("loot_grenade"), var_8, getpartname(var_8.model, 0));
        break;
      case "loot_armor":
        playFXOnTag(scripts\engine\utility::getfx("loot_armor"), var_8, getpartname(var_8.model, 0));
        break;
      default:
        playFXOnTag(scripts\engine\utility::getfx("loot_armor"), var_8, getpartname(var_8.model, 0));
    }
  }

  if(isDefined(var_8)) {
    scripts\sp\loot::setitemasloot(var_8, var_0, var_4);
    return var_8;
  }
}

gauntlet_civ_car_climb_handler() {
  wait 1;
  var_0 = getscriptablearray("gauntlet_civ_car_2", "script_noteworthy");

  while(isDefined(var_0[0])) {
    var_1 = var_0[0] getscriptablepartstate("body");

    if(var_1 == "dead") {
      break;
    }

    wait 0.1;
  }

  var_2 = getEntArray("gauntlet_civ_mantle_car_clip", "targetname");

  foreach(var_4 in var_2)
  var_4 movez(-200, 0.1, 0.05, 0.05);
}

guantlet_first_car_collision_kill() {
  level endon("flag_gauntlet_player_in_van");
  level endon("flag_player_hit_by_first_car");

  while(isalive(level.player) && !scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    if(level.player istouching(self)) {
      level.player kill();
      scripts\engine\utility::flag_set("flag_player_hit_by_first_car");
      continue;
    }

    waitframe();
  }
}

gauntlet_aq_force_target_van() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("van_shooting_spot", "targetname");
  var_1 = getEnt("car_hit_enforcer", "targetname");
  var_2 = getEntArray("van_impact_spot", "targetname");

  while(isDefined(var_0)) {
    if(scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
      self clearentitytarget();
      return;
    }

    var_3 = self canshoot(level.player getEye());

    if(var_3 && scripts\engine\utility::cointoss())
      self clearentitytarget();
    else {
      var_4 = scripts\engine\utility::random(var_2);
      self setentitytarget(var_4);

      if(self canshoot(var_4.origin))
        self shoot(1.0, var_4.origin);
    }

    wait 1.0;
  }
}

gauntlet_aq_force_target_police_cars() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(!isDefined(level.gauntlet_police_cars)) {
      wait 0.1;
      continue;
    }

    if(level.gauntlet_police_cars.size > 0 && scripts\engine\utility::cointoss()) {
      var_0 = scripts\engine\utility::random(level.gauntlet_police_cars);

      if(isDefined(var_0) && self canshoot(var_0.origin))
        self setentitytarget(var_0);

      wait 3.0;
    } else
      self clearentitytarget();

    wait 1.0;
  }
}

gauntlet_shootout_autosave() {
  level endon("missionfailed");
  level.player endon("death");
  wait 1;

  if(!scripts\engine\utility::flag("flag_gauntlet_enemies_spawn"))
    thread scripts\engine\sp\utility::autosave_now();
}

gauntlet_hack_bench_badplace() {
  wait 5.0;
  var_0 = getscriptablearray("scriptable_cp_disco_bus_bench", "classname");
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_4] = createnavbadplacebybounds(var_3.origin, (4, 18, 64), var_3.angles);

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");

  foreach(var_6 in var_1)
  destroynavobstacle(var_6);
}