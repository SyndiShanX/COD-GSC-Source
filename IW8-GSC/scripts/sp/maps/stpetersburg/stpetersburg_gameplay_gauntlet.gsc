/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_gameplay_gauntlet.gsc
***************************************************************************/

function gauntlet_init() {
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

function gauntlet_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_gauntlet_player_in_van", "stpetersburg_cafe_script_tr", ["stpetersburg_interrogation_shared_script_tr", "stpetersburg_interrogation_intro_script_tr", "stpetersburg_interrogation_geo_tr"]);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("interrogation_start", ["stpetersburg_gauntlet_script_tr", "stpetersburg_periph_geo_tr"], undefined);
  thread gauntlet_vfx();
  thread gauntlet_hack_bench_badplace();
  setsaveddvar("TLOLRMSL", 0.01);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_gauntlet::gauntlet_vig_start();
  thread scripts\sp\analytics::analytics_kleenex_update("Van to interrogation");
  scripts\engine\utility::flag_set("flag_gauntlet_start_civs");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_price_heading_for_river();
  thread gauntlet_van_hit_vignette();
  thread gauntlet_weapon_pickup_handler();
  thread gauntlet_price_handler();
  thread gauntlet_containment_handler();
  thread gauntlet_enforcer_ragdoll_handler();
  scripts\engine\utility::flag_wait_all("flag_gauntlet_player_in_van", "flag_gauntlet_nikolai_in_van");
}

function gauntlet_enforcer_ragdoll_handler() {
  level.player endon("death");
  level endon("missionfailed");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  scripts\engine\utility::flag_set("flag_enforcer_custom_death");
  level.enforcer.noragdoll = 1;
  level.enforcer scripts\engine\sp\utility::set_deathanim("run_death_facedown");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  scripts\engine\utility::flag_clear("flag_enforcer_custom_death");

  if(isDefined(level.enforcer)) {
    level.enforcer scripts\engine\sp\utility::clear_deathanim();
    level.enforcer.noragdoll = undefined;
    return;
  }
}

function gauntlet_enforcer_ragdoll_clamp() {
  scripts\common\anim::anim_single_solo(self, "run_death_facedown");
}

function gauntlet_vfx() {
  scripts\engine\utility::exploder("van_fx");
  scripts\engine\utility::exploder("birds_cluster");
  wait 1.75;
  scripts\engine\utility::exploder("birds_fly");
  scripts\engine\utility::kill_exploder("birds_cluster");
}

function gauntlet_containment_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  scripts\engine\utility::flag_set("flag_start_gauntlet_containment");
}

function gauntlet_price_handler() {
  level.player endon("death");
  level.enforcer endon("death");
  level endon("missionfailed");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("gauntlet_price_colors_1", "targetname", "activate");
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_hit_vig");
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::disable_ai_color();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  level.price scripts\common\utility::demeanor_override("sprint");
  var0 = getnode("price_gauntlet_near_butcher_node", "targetname");
  level.price scripts\engine\sp\utility::set_goal_node(var0);
  var1 = scripts\engine\utility::spawn_tag_origin(level.enforcer getEye(), level.enforcer.angles);
  var1.origin = level.enforcer getEye();
  var1 linkTo(level.enforcer, "tag_eye");
  level.price setentitytarget(var1);
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_van_hit");
  level.price clearentitytarget();
  var1 delete();

  if(distance2dsquared(level.price.origin, level.enforcer.origin) < squared(200)) {
    level.price scripts\common\utility::demeanor_override("cqb");
  }

  var2 = scripts\engine\utility::getStruct("gauntlet_price_poi_south", "targetname");
  level.price scripts\common\ai::poi_enable(1, var2);
  scripts\engine\utility::flag_wait("flag_gauntlet_price_move_to_van");
  level.price scripts\common\utility::demeanor_override("cqb");
  level.price scripts\common\ai::poi_enable(0);
  var3 = getEnt("car_hit_enforcer_org", "targetname");
  var3 scripts\sp\anim::anim_reach_and_approach_solo(level.price, "stp_street_car_hit");
  var3 scripts\common\anim::anim_single_solo(level.price, "stp_street_car_hit");
  var3 thread scripts\common\anim::anim_loop_solo(level.price, "stp_street_car_hit_pickup_idle", "price_loop_end01");
  level.price scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\utility::flag_set("flag_gauntlet_price_at_van");
}

function gauntlet_shootout_setup_van() {
  thread gauntlet_hack_bench_badplace();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("evade_enforcer_flee_node");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_monitor_health_handler(10);
  level.enforcer scripts\common\ai::gun_remove();

  if(!isDefined(level.nikolai)) {
    gauntlet_spawn_nikolai();
  }

  var0 = getEnt("car_hit_enforcer_org", "targetname");
  var1 = getEnt("car_hit_enforcer", "targetname");
  var1 scripts\engine\sp\utility::assign_animtree("car");
  var1.animname = "car";
  var1.godmode = 1;
  var2 = [];
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_machinegun", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_rpg", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_grenades", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_shooting_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_entry_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_rack_l", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_rack_r", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_light", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_light_sparks_spot", "targetname"));

  foreach(var4 in getEntArray("gauntlet_moving_van_clip", "targetname")) {
    var4 scripts\engine\sp\utility::show_solid();
    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  foreach(var4 in getEntArray("van_item_clip", "targetname")) {
    var4 scripts\engine\sp\utility::show_solid();
    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  foreach(var9 in getEntArray("van_impact_spot", "targetname")) {
    var2 = scripts\engine\utility::array_add(var2, var9);
  }

  foreach(var12 in var2) {
    var12 linkTo(var1, "tag_body_animate");
  }

  gauntlet_van_attach_windows();
  level thread scripts\sp\utility::context_melee_enable(0);
  var0 scripts\common\anim::anim_last_frame_solo(var1, "stp_street_car_hit_exit");
  var0 scripts\common\anim::anim_last_frame_solo(level.price, "stp_street_car_hit_pickup");
  var0 scripts\common\anim::anim_last_frame_solo(level.nikolai, "stp_street_car_hit_pickup");
  var0 thread scripts\common\anim::anim_loop_solo(level.enforcer, "stp_street_car_hit_idle02", "enforcer_loop_end02");
  waitframe();
  level.enforcer linkTo(var1);
  thread gauntlet_enforcer_in_van_handler();
  thread gauntlet_weapon_pickup_handler();
  thread gauntlet_remove_enforcer_clip();
  scripts\engine\utility::flag_set("flag_gauntlet_player_in_van");
}

function gauntlet_shootout_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_player_in_van();
  thread gauntlet_autosave_weapon_pickup();
  thread gauntlet_shootout_combat_handler();
  thread gauntlet_shootout_price_handler();
  thread gauntlet_shootout_police_arrive();
  thread gauntlet_shootout_autosave();
  scripts\engine\utility::flag_set("flag_end_player_wander_fail");
  gauntlet_set_van_health();
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
}

function gauntlet_shootout_combat_handler() {
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
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_police_incoming();
  thread gauntlet_aq_fighting_police();
  wait 10;
  scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_van_leaves();
  scripts\engine\utility::flag_set("flag_gauntlet_van_moving");
  thread gauntlet_swap_van_clip();
  thread gauntlet_aq_chasing_player_van();
  var0 = getEnt("car_hit_enforcer_org", "targetname");
  var1 = getEnt("car_hit_enforcer", "targetname");
  var0 linkTo(var1);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var1.link_org = spawn("script_origin", var1.origin);
  thread originlink(var1.link_org);
  level.player playersetgroundreferenceent(var1.link_org);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player enablehealthshield(1);
  scripts\sp\player::player_movement_state("creep");
  var2 = getweaponarray();
  var3 = getEnt("weapon_link", "targetname");

  foreach(var5 in var2) {
    if(ispointinvolume(var5.origin, var3)) {
      var5 linkTo(var1);
    }
  }

  var7 = getEnt("van_machinegun", "targetname");
  var8 = getEnt("van_rpg", "targetname");

  if(isDefined(var7)) {
    var7 linkTo(var1);
  }

  if(isDefined(var8)) {
    var8 linkTo(var1);
  }

  thread audio_gauntlet_leave_sfx_transition();
  var0 thread scripts\common\anim::anim_single_solo(var1, "stp_street_car_drive");
  var9 = getanimlength(var1 scripts\engine\utility::getanim("stp_street_car_drive")) - 5.25;
  wait var9 - 1;
  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  thread gauntlet_aq_clean_up_handler();
  thread gauntlet_van_to_interrogation();
  thread gauntlet_van_cleanup();
}

function audio_gauntlet_leave_sfx_transition() {
  level.transition_snd_org = spawn("script_origin", level.player.origin);
  level.transition_snd_org linkTo(level.player);
  level.transition_snd_org thread scripts\engine\sp\utility::sound_fade_in("stp_canal_gauntlet_fade_out", 1, 3, 1);
  level.player setsoundsubmix("sp_st_pete_gauntlet_fade_outs", 2, 1);
  wait 3;
  level.transition_snd_org thread scripts\engine\sp\utility::sound_fade_and_delete(6, 1);
  wait 3;
  level.player clearsoundsubmix("sp_st_pete_gauntlet_fade_outs", 4);
}

function originlink(var0) {
  for(;;) {
    self.origin = var0.origin;
    waitframe();
  }
}

function gauntlet_player_attackeraccuracy_handler() {
  var0 = scripts\common\utility::getdifficulty();

  if(var0 == "easy") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.1);
    return;
  }

  if(var0 == "medium") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.2);
    return;
  }

  if(var0 == "hard") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.3);
    return;
  }

  if(var0 == "fu") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(0.4);
    return;
  }
}

function gauntlet_check_player_returning_fire() {
  level endon("flag_gauntlet_complete");
  level.player endon("death");
  level endon("missionfailed");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("flag_gauntlet_player_returning_fire");
}

function gauntlet_swap_van_clip() {
  var0 = getEnt("gauntlet_van_clip", "targetname");
  var0 movez(128, 0.1);
  var1 = getEnt("gauntlet_van_drive_clip", "targetname");
  var1 movez(128, 0.1);
  wait 0.2;
  var0 connectpaths();
  var1 disconnectPaths();
}

function gauntlet_weapon_pickup_handler() {
  level endon("flag_gauntlet_complete");
  var0 = getEnt("car_hit_enforcer", "targetname");
  var1 = getEnt("van_machinegun", "targetname");
  var2 = getEnt("van_rpg", "targetname");
  var1 makeunusable();
  var2 makeunusable();
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");

  if(!scripts\engine\utility::flag("flag_gauntlet_aq_car_1_stops")) {
    thread scripts\engine\sp\utility::autosave_now_silent();
  }

  var1 unlink();
  var2 unlink();
  var1 makeusable();
  var2 makeusable();
  thread gauntlet_increase_player_lmg_ammo();
  thread gauntlet_increase_player_grenades();
  thread gauntlet_grenade_interact();
}

function gauntlet_grenade_interact() {
  var0 = getEnt("van_grenades", "targetname");
  var0.string = &"STPETERSBURG/PICKUP_FRAGS";
  var1 = spawn("script_origin", var0.origin);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 4), var0.string, undefined, 60, 120, 1);
  var2 = scripts\engine\utility::waittill_any_ents_return(var1, "trigger", level, "flag_gauntlet_van_moving");

  if(var2 == "trigger") {
    level.player scripts\engine\sp\utility::give_offhand("frag");
  }

  var1 delete();
}

function gauntlet_autosave_weapon_pickup() {
  level endon("flag_gauntlet_aq_car_1_stops");
  level endon("flag_gauntlet_complete");
  level.player waittill("pickup");
  thread gauntlet_shootout_mb_windows();

  if(!scripts\engine\utility::flag("flag_gauntlet_aq_car_1_stops")) {
    scripts\engine\sp\utility::autosave_or_timeout("van_weapon_pickedup", 3);
    return;
  }
}

function gauntlet_shootout_mb_windows() {
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_begin");
  wait 1;
  var0 = scripts\engine\utility::getStruct("van_mb_source", "targetname");
  var1 = [];
  var2 = getscriptablearray("car_hit_enforcer_window_left", "targetname");

  while(var2.size == 0) {
    var2 = getscriptablearray("car_hit_enforcer_window_left", "targetname");
    waitframe();
  }

  var1 = scripts\engine\utility::array_combine(var1, var2);
  var3 = getscriptablearray("car_hit_enforcer_window_right", "targetname");

  while(var3.size == 0) {
    var3 = getscriptablearray("car_hit_enforcer_window_right", "targetname");
    waitframe();
  }

  var1 = scripts\engine\utility::array_combine(var1, var3);
  var1 = scripts\engine\utility::get_array_of_closest(level.player.origin, var1);

  foreach(var5 in var1) {
    var6 = var5 getscriptablepartstate("base", 1);

    if(isDefined(var6) && var6 != "dead") {
      magicbullet("iw8_ar_akilo47", var0.origin, var5.origin + (0, 0, 8), level.price);
      wait randomfloatrange(1, 2);
    }
  }
}

function gauntlet_aq_fighting_police() {
  wait 1;
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_3", &gauntlet_aq_chasing_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_3", &gauntlet_aq_force_target_police_cars);
  scripts\engine\sp\utility::array_spawn_targetname("gauntlet_shootout_aq_wave_3");
}

function gauntlet_aq_chasing_player_van() {
  wait 1;
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_4", &gauntlet_aq_chasing_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname("gauntlet_shootout_aq_wave_4", &gauntlet_aq_force_target_police_cars);
  scripts\engine\sp\utility::array_spawn_targetname("gauntlet_shootout_aq_wave_4");
}

function gauntlet_aq_chasing_handler() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_pacifist(1);
  var0 = getnode(self.target, "targetname");

  if(isDefined(var0)) {
    scripts\engine\sp\utility::set_goal_node(var0);
    scripts\engine\sp\utility::set_goal_radius(16);
  } else {
    scripts\engine\sp\utility::set_goal_entity(level.player);
    scripts\engine\sp\utility::set_goal_radius(128);
  }

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  self delete();
}

function gauntlet_van_hit_vignette() {
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  level.enforcer scripts\common\ai::gun_remove();
  level.enforcer.animname = "enforcer";
  level.enforcer scripts\engine\sp\utility::set_allowdeath(1);
  var0 = getEnt("car_hit_enforcer_org", "targetname");

  if(!isDefined(level.nikolai)) {
    gauntlet_spawn_nikolai();
  }

  waitframe();
  level.nikolai scripts\engine\sp\utility::show_solid();
  var1 = getEnt("car_hit_enforcer", "targetname");
  var1 scripts\engine\sp\utility::assign_animtree("car");
  var1.animname = "car";
  var1.godmode = 1;
  var2 = [];
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_machinegun", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_rpg", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_grenades", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_shooting_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_entry_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_spot", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_rack_l", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_weapon_rack_r", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_light", "targetname"));
  var2 = scripts\engine\utility::array_add(var2, getEnt("van_light_sparks_spot", "targetname"));

  foreach(var4 in getEntArray("gauntlet_moving_van_clip", "targetname")) {
    var4 scripts\engine\sp\utility::show_solid();
    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  foreach(var4 in getEntArray("van_item_clip", "targetname")) {
    var4 scripts\engine\sp\utility::show_solid();
    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  foreach(var9 in getEntArray("van_impact_spot", "targetname")) {
    var2 = scripts\engine\utility::array_add(var2, var9);
  }

  foreach(var12 in var2) {
    var12 linkTo(var1, "tag_body_animate");
  }

  var14 = getEnt("van_nikolai_door_clip", "targetname");
  var15 = getEnt("van_price_door_clip", "targetname");
  var14 linkTo(var1, "tag_door_front_left");
  var15 linkTo(var1, "tag_door_front_right");
  gauntlet_van_attach_windows();
  var16 = [var1, level.enforcer, level.nikolai];
  var0 scripts\common\anim::anim_first_frame(var16, "stp_street_car_hit");

  while(!scripts\engine\utility::flag("flag_gauntlet_enforcer_hit_vig")) {
    var17 = scripts\engine\sp\utility::within_fov_of_players(level.enforcer getEye(), cos(45));

    if(scripts\engine\utility::flag("flag_evade_cafe_pursuit_end") && var17) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("flag_gauntlet_enforcer_hit_vig");
  thread walla_van_accident();
  thread gauntlet_police_sirens();
  thread gauntlet_van_engine();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_player_chase_enforcer();
  scripts\sp\player::player_movement_state("cqb");
  level.enforcer.skipdeathanim = 1;
  level thread scripts\sp\utility::context_melee_enable(0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::mus_enforcer_hit();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_player_approach_enforcer();
  thread gauntlet_enforcer_force_cold_breath();
  var18 = getanimlength(level.nikolai scripts\engine\utility::getanim("stp_street_car_hit")) - 2;
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_nikolai_carrying_enforcer", var18);
  var0 thread scripts\common\anim::anim_single_solo(level.enforcer, "stp_street_car_hit");
  var0 thread scripts\common\anim::anim_single_solo(var1, "stp_street_car_hit");
  var0 scripts\common\anim::anim_single_solo(level.nikolai, "stp_street_car_hit");
  thread gauntlet_van_sunblocker_handler();
  thread gauntlet_remove_enforcer_clip();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_monitor_health_handler(10);
  thread gauntlet_enforcer_health_check_during_van_load();
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_price_move_to_van", 4);
  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_enforcer_recovered", 9);
  thread gauntlet_enter_van_timer();
  thread gauntlet_enter_van_handler();
  scripts\engine\utility::flag_set("flag_gauntlet_nikolai_carrying_enforcer");
  thread gauntlet_actor_animate_single_then_loop(level.enforcer, "stp_street_car_hit_pickup", "stp_street_car_hit_idle02", "enforcer_loop_end02", "enforcer_loop_end", undefined);
  var0 thread scripts\common\anim::anim_single_solo(var1, "stp_street_car_hit_pickup");
  var0 scripts\common\anim::anim_single_solo(level.nikolai, "stp_street_car_hit_pickup");
  scripts\engine\utility::flag_clear("flag_gauntlet_nikolai_carrying_enforcer");
  level.enforcer linkTo(var1);
  thread gauntlet_enforcer_in_van_handler();
  thread gauntlet_actor_animate_single_then_loop(level.nikolai, "stp_street_car_hit_get_in", "stp_street_car_hit_idle02", "nikolai_loop_end02", undefined, "flag_gauntlet_nikolai_in_van");
  level.nikolai scripts\engine\sp\utility::set_ignoreme(1);

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    var0 scripts\common\anim::anim_single_solo(var1, "stp_street_car_hit_nik_get_in");
  }

  thread gauntlet_price_get_in_van();
}

function walla_van_accident() {
  wait 1.9;
  var0 = spawn("script_origin", (-3924, 2386, 114));
  var0 playSound("stp_walla_crash_civs_grp_01", "sounddone");
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("stp_walla_crash_civs_man_01", (-3334, 2286, 114));
  wait 2;
  var0 moveTo((-4284, 2712, 114), 3);
  var0 waittill("sounddone");
  var0 delete();
}

function gauntlet_enforcer_force_cold_breath() {
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("cold_breath_run"), level.enforcer, "j_head");
}

function gauntlet_enforcer_in_van_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.enforcer endon("death");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_set_low_fake_health();
  scripts\engine\utility::flag_set("flag_enforcer_custom_death");
  scripts\engine\utility::flag_set("flag_enforcer_anim_death");
  var0 = getEnt("car_hit_enforcer_org", "targetname");
  var1 = scripts\engine\utility::flag_wait_any_return("flag_enforcer_killed", "flag_gauntlet_van_moving");

  if(var1 == "flag_enforcer_killed") {
    level.enforcer.noragdoll = 1;
    var0 scripts\common\anim::anim_single_solo(level.enforcer, "stp_street_car_hit_death_enf");
  } else {
    level notify("end_enforcer_monitor_health");
  }

  scripts\engine\utility::flag_clear("flag_enforcer_custom_death");
}

function gauntlet_price_get_in_van() {
  scripts\engine\utility::flag_wait("flag_gauntlet_price_at_van");
  var0 = getEnt("car_hit_enforcer_org", "targetname");
  var1 = getEnt("car_hit_enforcer", "targetname");
  var0 notify("price_loop_end01");

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    var0 thread scripts\common\anim::anim_single_solo(var1, "stp_street_car_hit_price_get_in");
  }

  var0 scripts\common\anim::anim_single_solo(level.price, "stp_street_car_hit_get_in");
  level.price scripts\common\ai::gun_remove();
  scripts\engine\utility::flag_set("flag_gauntlet_price_in_van");
  var0 notify("price_loop_end01");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "stp_street_car_hit_idle02", "price_loop_end02");
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
  level.price scripts\common\utility::clear_demeanor_override();
}

function gauntlet_actor_animate_single_then_loop(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  level.enforcer endon("death");
  level.player endon("death");
  level endon("missionfailed");
  var6 = getEnt("car_hit_enforcer_org", "targetname");
  waitframe();

  if(isDefined(var3)) {
    var6 notify(var3);
  }

  var6 endon(var2);
  var6 scripts\common\anim::anim_single_solo(self, var0);

  if(isDefined(var4)) {
    scripts\engine\utility::flag_set(var4);
  }

  if(isDefined(var5)) {
    var6 thread scripts\common\anim::anim_loop_solo(self, var1, var2);
    var7 = getEnt("car_hit_enforcer", "targetname");
    self linkTo(var7);
    return;
  }

  var6 thread scripts\common\anim::anim_loop_solo(self, var1, var2);
}

function gauntlet_enforcer_health_check_during_van_load() {
  level endon("flag_gauntlet_complete");
  level endon("missionfailed");
  level.enforcer waittill("death");
  waitframe();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
}

function gauntlet_remove_enforcer_clip() {
  var0 = getEnt("gauntlet_butcher_collision_clip", "targetname");
  var0 movez(-128, 0.1);
  wait 0.2;
  var0 connectpaths();
}

function gauntlet_enter_van_timer() {
  level endon("missionfailed");
  level.player endon("death");
  level.enforcer endon("death");
  level endon("flag_gauntlet_player_in_van");
  scripts\engine\utility::flag_wait("flag_gauntlet_price_in_van");
  thread gauntlet_shootout_combat_handler();
  scripts\engine\utility::flag_set("flag_gauntlet_enemies_spawn");
}

function gauntlet_enter_van_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_enforcer_recovered");
  var0 = getEnt("gauntlet_moving_van_door_clip", "script_noteworthy");
  var0 unlink();
  waitframe();
  var0 movez(-512, 0.15, 0.05, 0.05);
  scripts\engine\sp\utility::trigger_wait_targetname("gauntlet_van_interior_trig");
  scripts\engine\utility::flag_set("flag_gauntlet_player_in_van");
  var1 = getEnt("car_hit_enforcer_org", "targetname");
  var2 = getEnt("car_hit_enforcer", "targetname");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  var2 scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  var1 thread scripts\common\anim::anim_single_solo(var2, "stp_street_car_hit_exit");
  var0.origin += (0, 0, 512);
  var2 = getEnt("car_hit_enforcer", "targetname");
  var0 linkTo(var2);
}

function gauntlet_van_sunblocker_handler() {
  var0 = getEnt("car_hit_enforcer", "targetname");
  var1 = getEnt("gauntlet_moving_van_left_door_clip", "script_noteworthy");
  var2 = getEnt("gauntlet_moving_van_top_clip", "script_noteworthy");
  var1 hide();
  var2 hide();

  while(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    var3 = anglestoleft(var0.angles);
    var4 = vectorNormalize(level.player getorigin() - var0.origin);
    var5 = vectordot(var3, var4);

    if(var5 < 0) {
      var1 show();
      var2 show();
    } else {
      var1 hide();
      var2 hide();
    }

    waitframe();
  }
}

function gauntlet_aq_spawn_handler() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");
  scripts\engine\utility::flag_wait("flag_gauntlet_enemies_spawn");
  thread gauntlet_civilian_vehicles();
  wait 1;
  level.player scripts\sp\utility::allow_weapon_first_raise_anims(0);
  thread gauntlet_aq_on_foot_spawner("gauntlet_shootout_aq_wave_1");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("gauntlet_aq_vehicle_riders", &gauntlet_aq_state_handler);
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_1");
  var0.animname = "skilo";
  thread gauntlet_aq_vehicle_movement_handler(var0);
  thread gauntlet_car_death_monitor(var0);
  thread guantlet_first_car_collision_kill();
  wait 5;
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_2");
  var1.animname = "skilo";
  thread gauntlet_aq_vehicle_movement_handler(var1);
  thread gauntlet_car_death_monitor(var1);
  wait 5;
  scripts\engine\utility::flag_wait_or_timeout("flag_gauntlet_aq_wave_1_dead", 5);
  var2 = scripts\common\vehicle::spawn_vehicle_from_targetname("gauntlet_aq_car_3");
  var2.animname = "decho";
  thread gauntlet_aq_vehicle_movement_handler(var2);
  var2.health = int(var2.health * 1.2);
  thread gauntlet_car_death_monitor(var2);
  scripts\engine\utility::flag_set("flag_gauntlet_aq_car_3_incoming");

  if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
    level.van_health = -100;
  }

  thread gauntlet_aq_on_foot_spawner("gauntlet_shootout_aq_wave_2");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_van_almost_leaves();
  wait 5;
  scripts\engine\utility::flag_wait_or_timeout("flag_gauntlet_aq_wave_2_dead", 5);
  thread gauntlet_aq_death_count_monitor();
  var3 = scripts\common\utility::getdifficulty();
  var4 = 20;

  if(var3 == "hard" || var3 == "fu") {
    var4 = 20;
  }

  thread scripts\engine\utility::flag_set_delayed("flag_gauntlet_battle_over", var4);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
}

function gauntlet_police_sirens() {
  var0 = spawn("script_origin", (-5700, 5300, 150));
  var0 playLoopSound("stp_gauntlet_police_sirens_dist_lp");
  var0 scalevolume(0);
  waitframe();
  var0 scalevolume(0.3, 60);
  scripts\engine\utility::flag_wait("flag_gauntlet_enemies_spawn");
  var0 scalevolume(1, 30);
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
  var0 thread scripts\engine\sp\utility::sound_fade_and_delete(10, 1);
  var1 = spawn("script_origin", (-4200, 4400, 150));
  var1 playLoopSound("stp_gauntlet_police_sirens_close_lp");
  var1 scalevolume(0);
  waitframe();
  var1 scalevolume(1, 10);
}

function gauntlet_van_engine() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  waitframe();
  var0 = 1;
  var1 = ["gauntlet_van_engine_turn_over_01", "gauntlet_van_engine_turn_over_02", "gauntlet_van_engine_turn_over_03", "gauntlet_van_engine_turn_over_04", "gauntlet_van_engine_turn_over_05", "gauntlet_van_engine_turn_over_06", "gauntlet_van_engine_turn_over_07", "gauntlet_van_engine_turn_over_08"];
  var2 = self;
  var3 = var2 gettagorigin("tag_hood");
  var4 = spawn("script_model", var3);
  var4 linkTo(var2, "tag_hood");
  var5 = spawn("script_model", var3);
  var5 linkTo(var2, "tag_hood");
  var6 = var2 gettagorigin("tag_light_back_right");
  var7 = spawn("script_model", var6 + (33, 25, -15));
  var7 linkTo(var2, "tag_light_back_right");
  var8 = spawn("script_model", var6 + (33, 25, -15));
  var8 linkTo(var2, "tag_light_back_right");
  var2 playSound("stp_gauntlet_van_incoming");
  thread scripts\engine\utility::play_sound_in_space("stp_gauntlet_van_incoming_skid_echo", (-4583, 1434, 436));
  scripts\engine\utility::flag_wait("flag_gauntlet_nikolai_start_van");
  thread gauntlet_van_takeoff(var5, var8);

  while(!scripts\engine\utility::flag("flag_gauntlet_van_moving")) {
    var9 = get_random_array_element_no_repeat(var1, "engine_turn_over_aliases", 4);
    var4 playSound(var9 + "_front");
    var7 playSound(var9 + "_rear");

    if(!var0) {
      wait randomfloatrange(2, 3.5);
      continue;
    }

    wait 4;
    var0 = 0;
  }

  var4 scripts\engine\sp\utility::sound_fade_and_delete(1);
  var7 scripts\engine\sp\utility::sound_fade_and_delete(1);
}

function gauntlet_van_takeoff(var0, var1) {
  scripts\engine\utility::flag_wait("flag_gauntlet_van_moving");
  var0 playSound("gauntlet_van_engine_takeoff_front");
  var1 playSound("gauntlet_van_engine_takeoff_rear");
  level.player waittill("fade_out_van_engine");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(2);
  var1 scripts\engine\sp\utility::sound_fade_and_delete(2);
}

function get_random_array_element_no_repeat(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 2;
  }

  if(!isDefined(level._audio_random_array_dict)) {
    level._audio_random_array_dict = [];
  }

  if(!isDefined(level._audio_random_array_dict[var1])) {
    level._audio_random_array_dict[var1] = scripts\engine\utility::array_randomize(getarraykeys(var0));
  }

  if(level._audio_random_array_dict[var1].size <= var2) {
    var3 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_array(getarraykeys(var0), level._audio_random_array_dict[var1]));
    level._audio_random_array_dict[var1] = scripts\engine\utility::array_combine(var3, level._audio_random_array_dict[var1]);
  }

  var4 = level._audio_random_array_dict[var1][level._audio_random_array_dict[var1].size - 1];
  level._audio_random_array_dict[var1][level._audio_random_array_dict[var1].size - 1] = undefined;
  return var0[var4];
}

function gauntlet_car_death_monitor(var0) {
  self endon("entitydeleted");

  if(var0) {
    var1 = int(self.health * 0.2);
  } else {
    var1 = int(self.health * 0.15);
  }

  self.godmode = 1;

  if(!isDefined(level.gauntlet_aq_vehicle_destroyed)) {
    level.gauntlet_aq_vehicle_destroyed = 0;
  }

  var2 = getEnt(self.script_noteworthy + "_explosion_org", "targetname");
  var2 linkTo(self);
  var3 = scripts\engine\utility::spawn_tag_origin(var2.origin, var2.angles);
  var3 linkTo(self);
  var4 = 80;
  var5 = 24;
  var6 = scripts\engine\utility::spawn_tag_origin(self.origin + anglesToForward(self.angles) * var4 + (0, 0, var5), self.angles);
  var6 linkTo(self);
  var7 = var1 * 0.9;
  var8 = var1 * 0.6;
  var9 = 0;

  for(var10 = 0; var1 > 0; var10 = 1) {
    self waittill("damage", var11, var12, var13, var14, var15);

    if(isDefined(var12) && isDefined(var15) && var12 == level.player) {
      if(var15 == "MOD_EXPLOSIVE" || var15 == "MOD_PROJECTILE") {
        var11 *= 100;
      }

      if(var15 == "MOD_PROJECTILE_SPLASH" || var15 == "MOD_GRENADE_SPLASH") {
        var11 *= 100;
      }
    }

    var1 -= var11;

    if(var1 < var7 && var9 == 0) {
      var16 = playFXOnTag(scripts\engine\utility::getfx("vfx_car_fire_linger"), var6, "tag_origin");
      var9 = 1;
    }

    if(var1 < var8 && var10 == 0) {
      var16 = stopFXOnTag(scripts\engine\utility::getfx("vfx_car_fire_linger"), var6, "tag_origin");
      var17 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_smoke_large"), var6, "tag_origin");
    }
  }

  scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  self.isdriving = 0;
  gauntlet_car_fx_stopper();
  self.godmode = 0;
  var18 = getcorpsearrayinradius(self.origin, 128);
  thread scripts\engine\utility::array_call(var18, &setcorpseremovetimer, 0.1);
  waitframe();
  scripts\engine\sp\utility::die();
  var17 = stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_smoke_large"), var6, "tag_origin");
  var19 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_fire_spread_decho"), var3, "tag_origin");
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.4, 0.5, level.player.origin, 400);
  var2 radiusdamage(var2.origin, 300, 50, 1, undefined, "MOD_EXPLOSIVE", undefined, undefined, 0);
  level.gauntlet_aq_vehicle_destroyed++;
  var20 = 5;
  var21 = 250;
  badplace_cylinder("", var20, var2.origin, var21, var21, "axis");
  thread gauntlet_set_ai_in_range_to_pacifist(var2.origin);
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var2 delete();
  var3 delete();
  var6 delete();
}

function gauntlet_civilian_vehicles() {
  var0 = [];

  while(var0.size == 0) {
    var0 = getscriptablearray("gauntlet_civilian_vehicle", "targetname");
    wait 0.1;
  }

  foreach(var2 in var0) {
    thread gauntlet_civilian_vehicle_explosion_handler();
  }
}

function gauntlet_aq_death_count_monitor() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");

  if(!isDefined(level.gauntlet_aq_dead)) {
    level.gauntlet_aq_dead = 0;
  }

  if(!isDefined(level.gauntlet_aq_vehicle_destroyed)) {
    level.gauntlet_aq_vehicle_destroyed = 0;
  }

  var0 = scripts\common\utility::getdifficulty();
  var1 = 10;

  if(var0 == "easy") {
    var1 = 6;
  } else if(var0 == "medium" || var0 == "hard") {
    var1 = 8;
  }

  var2 = 10;

  if(var0 == "easy") {
    var2 = 2;
  } else if(var0 == "medium") {
    var2 = 3;
  }

  while(!scripts\engine\utility::flag("flag_gauntlet_complete")) {
    if(level.gauntlet_aq_dead >= var1 || level.gauntlet_aq_vehicle_destroyed >= var2) {
      break;
    } else if(level.gauntlet_aq_dead >= var1 * 0.8) {
      scripts\engine\utility::flag_set("flag_gauntlet_aq_wave_2_dead");
    } else if(level.gauntlet_aq_dead >= var1 * 0.4) {
      scripts\engine\utility::flag_set("flag_gauntlet_aq_wave_1_dead");
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_gauntlet_battle_over");
}

function gauntlet_increase_player_lmg_ammo() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_gauntlet_complete");
  var0 = getEnt("van_machinegun", "targetname");
  var0 waittill("trigger");

  for(;;) {
    var1 = level.player getcurrentweapon();

    if(getweaponbasename(var1) == "iw8_lm_kilo121") {
      break;
    }

    waitframe();
  }

  level.player setweaponammoclip(level.player.currentweapon, 120);
  level.player givemaxammo(level.player.currentweapon);
}

function gauntlet_increase_player_grenades() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_gauntlet_complete");

  for(;;) {
    if(scripts\engine\sp\utility::player_has_equipment("frag")) {
      break;
    }

    waitframe();
  }

  var0 = weaponmaxammo("frag");
  level.player setweaponammoclip("frag", var0);
}

function gauntlet_aq_on_foot_spawner(var0) {
  scripts\engine\sp\utility::array_spawn_function_targetname(var0, &gauntlet_aq_runner_handler);
  scripts\engine\sp\utility::array_spawn_function_targetname(var0, &gauntlet_aq_state_handler);
  var0 = scripts\engine\sp\utility::array_spawn_targetname(var0);
}

function gauntlet_aq_state_handler() {
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
  var0 = getEnt("gauntlet_aq_combat_vol", "targetname");
  self setgoalvolumeauto(var0);
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

function gauntlet_aq_runner_handler() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::waittill_any_timeout(6, "damage");
  scripts\common\utility::clear_demeanor_override();
}

function gauntlet_police_vehicle_lights(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var1 = undefined;
  var2 = undefined;

  if(var0) {
    var3 = (0, 0, 0);
    var1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var1 linkTo(self, "tag_origin", (8, 0, 61.25), var3);
    var1 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var2 linkTo(self, "tag_origin", (-68, 0, 60.75), var3);
    var2 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  } else {
    var3 = (0, 0, 0);
    var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
    var2 linkTo(self, "tag_origin", (0, 0, 32.25), var3);
    var2 scripts\engine\sp\utility::fx_playontag_safe("vfx_stpburg_police_lights", "tag_origin");
  }

  scripts\engine\utility::waittill_any("death", "entitydeleted");

  if(isDefined(var2)) {
    var2 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var2 delete();
  }

  if(isDefined(var3)) {
    var3 scripts\engine\sp\utility::fx_stopontag_safe("vfx_stpburg_police_lights", "tag_origin");
    var3 delete();
    return;
  }
}

function gauntlet_van_health_monitor() {
  level endon("flag_gauntlet_battle_over");
  level endon("flag_gauntlet_complete");
  level endon("flag_gauntlet_van_destroyed");
  level.player endon("death");
  level endon("missionfailed");
  gauntlet_set_van_health();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_init_van_damage_nags();
  var0 = level.van_health * 0.8;
  var1 = level.van_health * 0.6;
  var2 = level.van_health * 0.4;
  var3 = getEnt("car_hit_enforcer", "targetname");
  var4 = getEntArray("gauntlet_moving_van_clip", "targetname");
  scripts\engine\utility::array_thread(var4, &gauntlet_van_bullethit_monitor);
  var5 = getEnt("van_shooting_spot", "targetname");
  level.van_smoke_fx_tag = scripts\engine\utility::spawn_tag_origin(var5.origin, var5.angles);
  level.van_smoke_fx_tag linkTo(var3, "tag_body_animate");
  level.van_bullethole_fx_tag = scripts\engine\utility::spawn_tag_origin(var5.origin + (0, 0, 0), var5.angles + (0, 180, 0));
  level.van_bullethole_fx_tag linkTo(var3, "tag_body_animate");
  level.van_impact_ents = getEntArray("van_impact_spot", "targetname");
  waitframe();

  while(!scripts\engine\utility::flag("flag_gauntlet_van_destroyed")) {
    if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van") && scripts\engine\utility::flag("flag_gauntlet_battle_over")) {
      level.van_health = 0;
    }

    if(level.van_health <= var0 && !scripts\engine\utility::flag("flag_gauntlet_van_smoking")) {
      var6 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_light"), level.van_smoke_fx_tag, "tag_origin");
      var7 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_lite"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(0);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_van_damage_warning();
      thread scripts\engine\utility::play_sound_in_space("scn_stp_van_tire_pop_hiss", level.player.origin + (100, 0, 0));
      thread audio_play_bullet_impacts_around_player(0);
      scripts\engine\utility::flag_set("flag_gauntlet_van_smoking");

      if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
        level.van_health = 0;
      }
    }

    if(level.van_health <= var1 && !scripts\engine\utility::flag("flag_gauntlet_van_damaged")) {
      var8 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_med"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(1);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_van_damage_warning();
      thread scripts\engine\utility::play_sound_in_space("scn_stp_van_radiator_pop_hiss", level.player.origin + (100, 100, 0));
      thread audio_play_bullet_impacts_around_player(1);
      scripts\engine\utility::flag_set("flag_gauntlet_van_damaged");
    }

    if(level.van_health <= var2 && !scripts\engine\utility::flag("flag_gauntlet_van_on_fire")) {
      var9 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_heavy"), level.van_smoke_fx_tag, "tag_origin");
      var10 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_door_bullethole_high"), level.van_bullethole_fx_tag, "tag_origin");
      thread gauntlet_van_damage_impact(2);
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_gauntlet_van_damage_warning();
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

function gauntlet_van_damage_impact(var0) {
  switch (var0) {
    case 0:
      var1 = "vfx_stpburg_door_impact_lite";
      var2 = 0.3;
      var3 = 0.5;
      var4 = "damage_light";
      break;
    case 1:
      var1 = "vfx_stpburg_door_impact_med";
      var2 = 0.5;
      var3 = 0.8;
      var4 = "damage_bullet";
      var5 = getEnt("van_light_sparks_spot", "targetname");
      playFX(scripts\engine\utility::getfx("vfx_stpburg_van_light_sparks"), var5.origin);
      break;
    case 2:
      var1 = "vfx_stpburg_door_impact_high";
      var2 = 0.8;
      var3 = 1;
      var4 = "grenade_rumble";
      break;
    default:
      var1 = "vfx_stpburg_door_impact_lite";
      var2 = 0.3;
      var3 = 0.5;
      var4 = "damage_light";
      break;
  }

  var6 = scripts\engine\utility::get_array_of_closest(level.player getEye(), level.van_impact_ents);
  playrumbleonposition(var4, var6[0].origin);
  earthquake(var2, var3, var6[0].origin, 400);
  playFX(scripts\engine\utility::getfx(var1), var6[0].origin);
  level.van_impact_ents = scripts\engine\utility::array_remove(level.van_impact_ents, var6[0]);
}

function audio_play_bullet_impacts_around_player(var0) {
  var1 = randomfloatrange(-120, 120);
  var2 = randomfloatrange(-120, 120);
  var3 = var0 * 2 + randomintrange(2, 4);
  var4 = 0;

  while(var4 <= var3) {
    thread scripts\engine\utility::play_sound_in_space("scn_stp_bullet_impact_on_van", level.player.origin + (var1, var2, 0));
    wait randomfloatrange(0.08, 0.12);
    var4 += 1;
  }
}

function gauntlet_shootout_van_destroyed() {
  var0 = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_van_smoke_fire"), level.van_smoke_fx_tag, "tag_origin");
  wait 1;
  playrumbleonposition("heavy_1s", level.player.origin);
  earthquake(0.8, 1, level.player.origin, 800);
  var1 = playFXOnTag(scripts\engine\utility::getfx("vfx_veh_explosion_civ"), level.van_smoke_fx_tag, "tag_origin");
  var2 = getEnt("car_hit_enforcer", "targetname");
  var2 setModel("veh8_civ_lnd_palfa_static_dst_east");
  var2 radiusdamage(var2.origin, 150, 400, 200, undefined, undefined, undefined, undefined, 0);
  physicsexplosionsphere(var2.origin, 600, 200, 30);
  wait 0.1;

  if(isDefined(level.player)) {
    if(scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
      level.player kill();
    } else {
      var3 = scripts\engine\utility::distance_2d_squared(level.player.origin, var2.origin);

      if(var3 < squared(200)) {
        var4 = level.player.origin - var2.origin;
        var4 = vectorNormalize(var4);
        var5 = (squared(250) - var3) * 0.0005;
        level.player pushplayervector(var4 * var5 + (0, 0, 5), 1);
      }
    }
  }

  scripts\sp\player_death::set_custom_death_quote(90);
  thread scripts\sp\utility::missionfailedwrapper();
}

function gauntlet_van_bullethit_monitor() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flag_gauntlet_complete");
  level endon("flag_gauntlet_van_destroyed");
  level endon("flag_gauntlet_battle_over");
  self setCanDamage(1);
  self.health = 999999999;
  var0 = 5;
  var1 = 4;
  var2 = 2;
  var3 = 0.2;

  while(!scripts\engine\utility::flag("flag_gauntlet_battle_over")) {
    self waittill("damage", var4, var5, var6, var7, var8);

    if(isDefined(var5)) {
      if(var5 == level.player) {
        var4 *= var3;
      } else if(!scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
        var4 *= var0;
        var0 *= 2;
      } else {
        if(level.player getstance() == "prone") {
          var4 *= var1;
        }

        if(level.player getstance() == "crouch") {
          var4 *= var2;
        }
      }

      level.van_health -= var4;
    }

    wait 0.1;
  }
}

function gauntlet_van_create_bullethole(var0) {
  var1 = "vfx_stpburg_door_bullethole_ch_1";

  if(scripts\engine\utility::cointoss()) {
    var1 = "vfx_stpburg_door_bullethole_ch_2";
  }

  var2 = getEnt("car_hit_enforcer", "targetname");
  var3 = var0 + anglesToForward(var2.angles) * 80;
  var4 = scripts\engine\trace::ray_trace(var3, var0);

  if(isDefined(var4["entity"])) {
    var5 = var4["entity"];

    if(!isDefined(var5.script_noteworthy) || var5.script_noteworthy != "gauntlet_moving_van_clip_back") {
      if(scripts\engine\utility::cointoss()) {
        gauntlet_van_create_random_bullethole();
      }

      return;
    }
  }

  var6 = var4["position"];
  var7 = anglesToForward(vectortoangles(var4["normal"]));
  var8 = playFX(scripts\engine\utility::getfx(var1), var6, var7);
}

function gauntlet_van_create_random_bullethole() {
  var0 = getEntArray("gauntlet_moving_van_clip_back", "script_noteworthy");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0[0].origin;
  var1 += (randomintrange(-15, 15), 0, randomintrange(-15, 15));
  thread gauntlet_van_create_bullethole(var1);
}

function gauntlet_civilian_vehicle_explosion_handler() {
  level endon("flag_gauntlet_complete");
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt(self.script_noteworthy + "_center", "targetname");
  self waittillmatch("scriptableNotification", "onfire");
  var1 = 5;
  var2 = 200;
  badplace_cylinder("", var1, var0.origin, var2, var2, "axis");
  self waittillmatch("scriptableNotification", "anim_explosion");
  playrumbleonposition("grenade_rumble", level.player.origin);
  earthquake(0.4, 0.5, level.player.origin, 400);
  var0 radiusdamage(var0.origin, 250, 20, 1, undefined, "MOD_EXPLOSIVE", undefined, undefined, 0);
  thread gauntlet_set_ai_in_range_to_pacifist(var0.origin);
}

function gauntlet_set_ai_in_range_to_pacifist(var0) {
  var1 = scripts\common\utility::getdifficulty();
  var2 = squared(400);
  var3 = randomfloatrange(6, 9);

  if(var1 == "easy") {
    var2 = squared(450);
    var3 = randomfloatrange(8, 12);
  } else if(var1 == "fu") {
    var2 = squared(350);
    var3 = randomfloatrange(4, 6);
  }

  var4 = var2 * 0.5;
  var5 = var3 * 0.5;
  var6 = getaiarray("axis");
  var6 = scripts\engine\utility::array_removedead_or_dying(var6);

  foreach(var8 in var6) {
    var9 = distance2dsquared(var0, var8.origin);

    if(var9 <= var4) {
      var8 thread scripts\anim\combat_utility::flashbangstart(var5);
    }

    if(var9 <= var2) {
      var8 scripts\engine\sp\utility::set_pacifist(1);
      var8 scripts\engine\sp\utility::enable_dontevershoot();
      var8 scripts\engine\utility::delaythread(var3, &scripts\engine\sp\utility::set_pacifist, 0);
      var8 scripts\engine\utility::delaythread(var5, &scripts\engine\sp\utility::disable_dontevershoot);
    }
  }
}

function gauntlet_aq_vehicle_movement_handler(var0) {
  self endon("entitydeleted");
  self endon("death");
  var1 = undefined;

  while(!isDefined(self)) {
    waitframe();
  }

  var2 = getEnt(self.script_noteworthy + "_drive_vol", "targetname");
  var3 = scripts\engine\utility::getStruct("aq_vehicle_drive_struct", "targetname");
  wait 0.2;
  var4 = "flag_" + self.script_noteworthy + "_stops";
  thread gauntlet_aq_vehicle_driver_death_handler(var0, var4);
  thread gauntlet_aq_vehicle_cleanup(var4);
  var5 = "vehA_";

  if(var0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA") {
    var1 = "stp_car1_gauntlet_drive_in";
    var5 = "vehA_";
  } else if(var0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB") {
    var1 = "stp_car2_gauntlet_drive_in";
    var5 = "vehB_";
  } else if(var0 == "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC") {
    var1 = "stp_car3_gauntlet_drive_in";
    var5 = "vehC_";
  }

  if(isDefined(var1)) {
    self playSound(var1);
  }

  self.isdriving = 1;
  gauntlet_car_fx_handler(var5);
  var3 scripts\common\anim::anim_single_solo(self, var0);
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_set(var4);
  self.isdriving = 0;
  gauntlet_car_fx_stopper();
  wait 0.1;

  if(isDefined(self.riders) && self.riders.size > 0) {
    scripts\common\vehicle::vehicle_unload();
    return;
  }
}

function gauntlet_car_fx_handler(var0) {
  self.fx_tags = [];
  self.fx_tags["front_right"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_front_right"), self gettagangles("tag_wheel_front_right"));
  self.fx_tags["front_right"] linkTo(self, "tag_wheel_front_right");
  self.fx_tags["back_right"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_back_right"), self gettagangles("tag_wheel_back_right"));
  self.fx_tags["back_right"] linkTo(self, "tag_wheel_back_right");
  self.fx_tags["front_left"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_front_left"), self gettagangles("tag_wheel_front_left"));
  self.fx_tags["front_left"] linkTo(self, "tag_wheel_front_left");
  self.fx_tags["back_left"] = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_wheel_back_left"), self gettagangles("tag_wheel_back_left"));
  self.fx_tags["back_left"] linkTo(self, "tag_wheel_back_left");

  foreach(var2 in self.fx_tags) {
    thread gauntlet_car_wheel_fx_handler(var2, var0, var3);
  }
}

function gauntlet_car_wheel_fx_handler(var0, var1, var2) {
  self endon("entitydeleted");
  var3 = var0 + var1;
  var4 = var3 + "_splash_on";
  var5 = var3 + "_splash_off";
  var6 = var3 + "_splash02_on";
  var7 = var3 + "_splash02_off";
  var8 = var3 + "_dust_on";
  var9 = var3 + "_dust_off";

  while(isDefined(var2) && var2.isdriving == 1) {
    var10 = level scripts\engine\utility::waittill_any_return(var4, var5, var6, var7, var8, var9);

    if(var10 == var4) {
      self.splashfx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");
    } else if(var10 == var5) {
      self.splashfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");
    } else if(var10 == var6) {
      self.splash02fx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");
    } else if(var10 == var7) {
      self.splash02fx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");
    } else if(var10 == var8) {
      self.dustfx = playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");
    } else if(var10 == var9) {
      self.dustfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");
    }

    waitframe();
  }

  thread gauntlet_car_wheel_fx_stopper();
}

function gauntlet_car_fx_stopper() {
  if(!isDefined(self)) {
    return;
  }

  foreach(var1 in self.fx_tags) {
    thread gauntlet_car_wheel_fx_stopper();
  }
}

function gauntlet_car_wheel_fx_stopper() {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.splashfx)) {
    self.splashfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash"), self, "tag_origin");
  }

  if(isDefined(self.splash02fx)) {
    self.splash02fx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tire_skidding_splash_02"), self, "tag_origin");
  }

  if(isDefined(self.dustfx)) {
    self.dustfx = stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_vehicle_skidding_dust_01"), self, "tag_origin");
  }

  self delete();
}

function gauntlet_aq_vehicle_driver_death_handler(var0, var1) {
  self endon("entitydeleted");
  self endon("death");
  level endon(var1);
  self.donotunloadondriverdeath = 1;
  var2 = get_vehicle_driver();

  if(isDefined(var2)) {
    var2 waittill("death");

    if(self getanimtime(scripts\engine\utility::getanim(var0)) < 0.9) {
      var3 = 1;

      for(var4 = 0; var4 < 5; var4++) {
        self setanimrate(scripts\engine\utility::getanim(var0), var3 - 0.2);
        wait 0.1;
      }

      scripts\engine\sp\utility::anim_stopanimScripted();
      self.isdriving = 0;
      thread gauntlet_vehicle_unload();
      self notify("driver_killed");
      return;
    }

    return;
  }
}

function gauntlet_vehicle_unload() {
  self endon("entitydeleted");
  self endon("death");
  wait 1;

  if(isDefined(self.riders) && self.riders.size > 0) {
    scripts\common\vehicle::vehicle_unload();
    return;
  }
}

function get_vehicle_driver() {
  foreach(var1 in self.riders) {
    if(isDefined(var1.vehicle_position) && var1.vehicle_position == 0) {
      return var1;
    }
  }

  return undefined;
}

function gauntlet_aq_vehicle_cleanup(var0) {
  var1 = scripts\engine\utility::waittill_any_ents_return(self, "death", self, "driver_killed", level, var0);
  var2 = getEnt(self.script_noteworthy + "_clip", "targetname");

  if(isDefined(self)) {
    self disconnectPaths();
  } else {
    var2 disconnectPaths();
  }

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var2 delete();

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function gauntlet_aq_create_badplace_in_combat() {
  level endon("flag_gauntlet_complete");
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_gauntlet_complete")) {
    var0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby");
    scripts\engine\sp\utility::set_force_cover(1);
    scripts\engine\sp\utility::enable_dontevershoot();

    switch (var0) {
      case "damage":
        var1 = 128;
        var2 = 6;
        break;
      case "bulletwhizby":
        var1 = 96;
        var2 = 4;
        break;
      default:
        var1 = 64;
        var2 = 2;
        break;
    }

    badplace_cylinder("", var2, self.origin, var1, var1, "axis");
    wait randomfloatrange(7, 13);
    scripts\engine\sp\utility::set_force_cover(0);
    scripts\engine\sp\utility::disable_dontevershoot();
  }
}

function gauntlet_aq_create_badplace_on_death() {
  self endon("entitydeleted");

  if(!isDefined(level.gauntlet_aq_dead)) {
    level.gauntlet_aq_dead = 0;
  }

  self waittill("death");
  var0 = 96;
  var1 = 4;
  badplace_cylinder("", var1, self.origin, var0, var0, "axis");
  level.gauntlet_aq_dead++;
}

function gauntlet_van_to_interrogation() {
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

  if(isDefined(level.van_smoke_fx_tag)) {
    level.van_smoke_fx_tag delete();
  }

  wait 2;

  if(!isalive(level.player)) {
    return;
  }

  var0 = getEnt("car_hit_enforcer_org", "targetname");
  var0 notify("van_loop_end02");
  var0 notify("nikolai_loop_end02");
  var0 notify("enforcer_loop_end02");
  var0 notify("price_loop_end02");

  if(isDefined(level.van_fx_tag)) {
    level.van_fx_tag delete();
  }

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

function gauntlet_aq_clean_up_handler() {
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var0 = getaiarray("axis", "neutral");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  scripts\engine\utility::array_delete(var0);
}

function gauntlet_van_cleanup() {
  level endon("flag_gauntlet_van_destroyed");
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var0 = getEnt("van_machinegun", "targetname");
  var1 = getEnt("van_rpg", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function gauntlet_shootout_price_handler() {
  scripts\engine\utility::flag_wait("flag_gauntlet_player_in_van");
  level.price scripts\engine\sp\utility::hide_notsolid();
  level.nikolai scripts\engine\sp\utility::hide_notsolid();
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  level.price scripts\engine\sp\utility::show_solid();
  level.nikolai scripts\engine\sp\utility::show_solid();
  level.price scripts\engine\sp\utility::set_ignoreme(0);
  level.nikolai scripts\engine\sp\utility::set_ignoreme(0);
}

function gauntlet_spawn_nikolai() {
  scripts\engine\sp\utility::array_spawn_function_targetname("nikolai", &scripts\common\utility::demeanor_override, "casual");
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

function gauntlet_init_threatbias() {
  createthreatbiasgroup("gauntlet_police");
  createthreatbiasgroup("gauntlet_aq");
  createthreatbiasgroup("gauntlet_allies");
  setthreatbias("gauntlet_police", "gauntlet_aq", 1000);
  setthreatbias("gauntlet_aq", "gauntlet_police", 1000);
  setthreatbias("gauntlet_police", "gauntlet_allies", -1000);
}

function gauntlet_shootout_police_arrive() {
  scripts\engine\utility::flag_wait("flag_gauntlet_battle_over");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("gauntlet_police", &gauntlet_police_handler);
  var0 = vehicle_getspawnerarray("gauntlet_police_car_1");
  var0[0].script_dontunloadonend = 1;
  var1 = vehicle_getspawnerarray("gauntlet_police_car_2");
  var1[0].script_dontunloadonend = 1;
  var2 = vehicle_getspawnerarray("gauntlet_police_car_3");
  var2[0].script_dontunloadonend = 1;
  var3 = vehicle_getspawnerarray("gauntlet_police_car_4");
  var3[0].script_dontunloadonend = 1;
  var4 = vehicle_getspawnerarray("gauntlet_police_car_5");
  var4[0].script_dontunloadonend = 1;
  waitframe();
  var5 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_1");
  var5.godmode = 1;
  var5 vehicle_setspeed(35, 32, 16);
  thread gauntlet_police_vehicle_lights(var5);
  thread gauntlet_police_car_array_setup(var5);
  var6 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_2");
  var6.godmode = 1;
  var6 vehicle_setspeed(30, 28, 14);
  thread gauntlet_police_vehicle_lights(var6);
  var7 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_3");
  var7.godmode = 1;
  var7 vehicle_setspeed(25, 22, 11);
  thread gauntlet_police_vehicle_lights(var7);
  var8 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_4");
  var8.godmode = 1;
  var8 vehicle_setspeed(35, 30, 15);
  thread gauntlet_police_vehicle_lights(var8);
  thread gauntlet_police_car_array_setup(var8);
  scripts\engine\utility::flag_wait("flag_gauntlet_van_moving");
  var9 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("gauntlet_police_car_5");
  var9.godmode = 1;
  var9 vehicle_setspeed(25, 22, 11);
  thread gauntlet_police_vehicle_lights(var9);
  thread gauntlet_police_car_array_setup(var9);
}

function gauntlet_police_car_array_setup(var0) {
  self endon("death");
  self endon("entitydeleted");
  self waittill("reached_end_node");

  if(!isDefined(level.gauntlet_police_cars)) {
    level.gauntlet_police_cars = [];
  }

  var1 = anglestoup(self.angles);
  var2 = anglestoright(self.angles);
  var3 = scripts\engine\utility::spawn_script_origin(self.origin + var1 * abs(var0) + var2 * var0);
  level.gauntlet_police_cars = scripts\engine\utility::array_add(level.gauntlet_police_cars, var3);
  scripts\engine\utility::flag_wait("flag_gauntlet_complete");
  var3 delete();
}

function gauntlet_police_handler() {
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

function gauntlet_van_light_on() {
  var0 = getEnt("van_light", "targetname");
  var0 setModel("uk_storage_wall_light_01_on");
}

function gauntlet_van_light_off() {
  var0 = getEnt("van_light", "targetname");
  var0 setModel("uk_storage_wall_light_01");
}

function gauntlet_van_attach_windows() {
  var0 = getEnt("car_hit_enforcer", "targetname");
  var1 = getscriptablearray("car_hit_enforcer_window_left", "targetname");

  while(var1.size == 0) {
    var1 = getscriptablearray("car_hit_enforcer_window_left", "targetname");
    waitframe();
  }

  foreach(var3 in var1) {
    var3 enablelinkTo();
    var3 linkTo(var0, "tag_window_rear_left");
  }

  var5 = getscriptablearray("car_hit_enforcer_window_right", "targetname");

  while(var5.size == 0) {
    var5 = getscriptablearray("car_hit_enforcer_window_right", "targetname");
    waitframe();
  }

  foreach(var3 in var5) {
    var3 enablelinkTo();
    var3 linkTo(var0, "tag_window_rear_right");
  }
}

function gauntlet_set_van_health() {
  var0 = scripts\common\utility::getdifficulty();
  level.van_health = 24000;

  if(var0 == "easy") {
    level.van_health = 28000;
    return;
  }

  if(var0 == "medium") {
    level.van_health = 26000;
    return;
  }
}

function spawnlootitemsuspended(var0, var1, var2, var3, var4) {
  if(tolower(var0) == "ballistic vest" && !scripts\common\utility::playerarmorenabled()) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::randomvectorrange(0, 360);
  }

  var5 = scripts\sp\script_items::scriptitem_buildspawnflags(1, 0, 1, 0, 1);
  var6 = level.loot.types[var0].model;
  var7 = (randomfloat(0.5), randomfloat(0.5), 1) * var3;
  var8 = spawnscriptitem("script_item_" + var0, var1, var2, var5, var6, "", var7, var1);

  if(getdvarint("loot_beam_test") == 1) {
    switch (var8.model) {
      case "loot_frag":
        playFXOnTag(scripts\engine\utility::getfx("loot_grenade"), var8, getpartname(var8.model, 0));
        break;
      case "loot_flash":
        playFXOnTag(scripts\engine\utility::getfx("loot_grenade"), var8, getpartname(var8.model, 0));
        break;
      case "loot_armor":
        playFXOnTag(scripts\engine\utility::getfx("loot_armor"), var8, getpartname(var8.model, 0));
        break;
      default:
        playFXOnTag(scripts\engine\utility::getfx("loot_armor"), var8, getpartname(var8.model, 0));
        break;
    }
  }

  if(isDefined(var8)) {
    scripts\sp\loot::setitemasloot(var8, var0, var4);
    return var8;
  }
}

function gauntlet_civ_car_climb_handler() {
  wait 1;
  var0 = getscriptablearray("gauntlet_civ_car_2", "script_noteworthy");

  while(isDefined(var0[0])) {
    var1 = var0[0] getscriptablepartstate("body");

    if(var1 == "dead") {
      break;
    }

    wait 0.1;
  }

  var2 = getEntArray("gauntlet_civ_mantle_car_clip", "targetname");

  foreach(var4 in var2) {
    var4 movez(-200, 0.1, 0.05, 0.05);
  }
}

function guantlet_first_car_collision_kill() {
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

function gauntlet_aq_force_target_van() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("van_shooting_spot", "targetname");
  var1 = getEnt("car_hit_enforcer", "targetname");
  var2 = getEntArray("van_impact_spot", "targetname");

  while(isDefined(var0)) {
    if(scripts\engine\utility::flag("flag_gauntlet_player_in_van")) {
      self clearentitytarget();
      return;
    }

    var3 = self canshoot(level.player getEye());

    if(var3 && scripts\engine\utility::cointoss()) {
      self clearentitytarget();
    } else {
      var4 = scripts\engine\utility::random(var2);
      self setentitytarget(var4);

      if(self canshoot(var4.origin)) {
        self shoot(1, var4.origin);
      }
    }

    wait 1;
  }
}

function gauntlet_aq_force_target_police_cars() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(!isDefined(level.gauntlet_police_cars)) {
      wait 0.1;
      continue;
    }

    if(level.gauntlet_police_cars.size > 0 && scripts\engine\utility::cointoss()) {
      var0 = scripts\engine\utility::random(level.gauntlet_police_cars);

      if(isDefined(var0) && self canshoot(var0.origin)) {
        self setentitytarget(var0);
      }

      wait 3;
    } else {
      self clearentitytarget();
    }

    wait 1;
  }
}

function gauntlet_shootout_autosave() {
  level endon("missionfailed");
  level.player endon("death");
  wait 1;

  if(!scripts\engine\utility::flag("flag_gauntlet_enemies_spawn")) {
    thread scripts\engine\sp\utility::autosave_now();
    return;
  }
}

function gauntlet_hack_bench_badplace() {
  wait 5;
  var0 = getscriptablearray("scriptable_cp_disco_bus_bench", "classname");
  var1 = [];

  foreach(var3 in var0) {
    var1 = createnavbadplacebybounds(var3.origin, (4, 18, 64), var3.angles);
  }

  scripts\engine\utility::flag_wait("flag_gauntlet_complete");

  foreach(var6 in var1) {
    destroynavobstacle(var6);
  }
}