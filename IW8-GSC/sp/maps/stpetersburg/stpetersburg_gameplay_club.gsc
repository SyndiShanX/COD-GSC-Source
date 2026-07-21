/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc
***************************************************************/

bar_init() {
  scripts\engine\utility::flag_init("flag_player_in_escort");
  scripts\engine\utility::flag_init("flag_end_player_wander_fail");
  scripts\engine\utility::flag_init("flag_bink_active");
  scripts\engine\utility::flag_init("intro_bink_done");
  scripts\engine\utility::flag_init("flag_stakeout_camera_in_apartment");
  scripts\engine\utility::flag_init("flag_stakeout_camera_finished");
  scripts\engine\utility::flag_init("flag_stakeout_fake_player_deleted");
  scripts\engine\utility::flag_init("flag_stakeout_allow_weapon_select");
  scripts\engine\utility::flag_init("flag_stakeout_aq_truck_arrived");
  scripts\engine\utility::flag_init("flag_stakeout_enforcer_visible");
  scripts\engine\utility::flag_init("flag_stakeout_enforcer_left_alley");
  scripts\engine\utility::flag_init("flag_stakeout_player_near_kitchen");
  scripts\engine\utility::flag_init("flag_stakeout_nikolai_kitchen_ready");
  scripts\engine\utility::flag_init("flag_stakeout_nikolai_kitchen_extra_ready");
  scripts\engine\utility::flag_init("flag_stakeout_nikolai_stairs_ready");
  scripts\engine\utility::flag_init("flag_stakeout_nikolai_closed_door");
  scripts\engine\utility::flag_init("flag_stakeout_player_in_kitchen");
  scripts\engine\utility::flag_init("flag_stakeout_player_has_weapon");
  scripts\engine\utility::flag_init("flag_stakeout_player_ready_to_move");
  scripts\engine\utility::flag_init("flag_stakeout_price_kitchen_ready");
  scripts\engine\utility::flag_init("flag_stakeout_price_stairs_ready");
  scripts\engine\utility::flag_init("flag_stakeout_price_warning");
  scripts\engine\utility::flag_init("flag_stakeout_price_move_down_stairs_1");
  scripts\engine\utility::flag_init("flag_stakeout_price_move_down_stairs_2");
  scripts\engine\utility::flag_init("flag_stakeout_price_exit_quick");
  scripts\engine\utility::flag_init("flag_stakeout_end");
  scripts\engine\utility::flag_init("flag_alley_stealth_begin");
  scripts\engine\utility::flag_init("flag_stealth_start_patrols_1");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_killed_aq");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_ready");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_fired");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_ambush_setup");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_ambush_begin");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_ambush_end");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_near_exit_door");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_bottom_stairs");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_at_door");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_opening_door");
  scripts\engine\utility::flag_init("flag_alley_stealth_price_kicking_door");
  scripts\engine\utility::flag_init("flag_alley_stealth_near_fail");
  scripts\engine\utility::flag_init("flag_alley_stealth_cover_blown");
  scripts\engine\utility::flag_init("flag_alley_stealth_mission_fail");
  scripts\engine\utility::flag_init("flag_alley_stealth_aq_dead");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_near_bar_door");
  scripts\engine\utility::flag_init("flag_alley_stealth_player_opens_bar_door");
  scripts\engine\utility::flag_init("flag_bar_alley_entrance_door_opened");
  scripts\engine\utility::flag_init("flag_vo_stp_no_step_hadir_line");
  scripts\engine\utility::flag_init("flag_player_blew_backroom_stealth");
  scripts\engine\utility::flag_init("flag_player_shoots_in_backroom");
  scripts\engine\utility::flag_init("flag_player_jumps_in_backroom");
  scripts\engine\utility::flag_init("flag_enforcer_flees_backroom");
  scripts\engine\utility::flag_init("flag_backroom_player_rushes");
  scripts\engine\utility::flag_init("flag_backroom_player_seen_standing");
  scripts\engine\utility::flag_init("flag_backroom_butcher_convo_half");
  scripts\engine\utility::flag_init("flag_backroom_butcher_convo_over");
  scripts\engine\utility::flag_init("flag_enforcer_exit_shootout_door");
  scripts\engine\utility::flag_init("flag_shootout_turn_off_player_kill");
  scripts\engine\utility::flag_init("flag_unlock_critical_bar_doors");
  scripts\engine\utility::flag_init("flag_backroom_player_downstairs");
  scripts\engine\utility::flag_init("flag_bomb_room_player_enter");
  scripts\engine\utility::flag_init("flag_bomb_room_enforcer_clear");
  scripts\engine\utility::flag_init("flag_bomb_room_exit_clear");
  scripts\engine\utility::flag_init("flag_bomb_room_price_advance");
  scripts\engine\utility::flag_init("flag_bomb_room_enemies_dead");
  scripts\engine\utility::flag_init("flag_shootout_enemies_shot_early");
  scripts\engine\utility::flag_init("flag_bar_shootout_enter");
  scripts\engine\utility::flag_init("flag_bar_shootout_close_door");
  scripts\engine\utility::flag_init("flag_bar_shootout_bash_door");
  scripts\engine\utility::flag_init("flag_bar_shootout_through_door");
  scripts\engine\utility::flag_init("flag_bar_shootout_one_dead");
  scripts\engine\utility::flag_init("flag_bar_shootout_one_alive");
  scripts\engine\utility::flag_init("flag_bar_shootout_enemies_follow_enforcer");
  scripts\engine\utility::flag_init("flag_bar_shootout_player_advance");
  scripts\engine\utility::flag_init("flag_bar_shootout_player_exit");
  scripts\engine\utility::flag_init("flag_bar_shootout_some_enemies_dead");
  scripts\engine\utility::flag_init("flag_bar_shootout_enemies_dead");
  scripts\engine\utility::flag_init("flag_bar_shootout_player_done_speaking");
  scripts\engine\utility::flag_init("flag_aq_ambusher_dead");
  scripts\engine\utility::flag_init("flag_player_exit_back_room");
  scripts\engine\utility::flag_init("flag_ambusher_blindfire_start");
  scripts\engine\utility::flag_init("flag_ambusher_blindfire_end");
  scripts\engine\utility::flag_init("flag_price_triggers_ambusher_blindfire");
  scripts\engine\utility::flag_init("flag_bar_price_at_stairs");
  scripts\engine\utility::flag_init("flag_kitchen_aq_shoots_down_stairs");
  scripts\engine\utility::flag_init("flag_player_near_exit_club");
  scripts\engine\utility::flag_init("flag_player_exit_club");
  scripts\engine\utility::flag_init("flag_bar_street_player_at_corner");
  scripts\engine\utility::flag_init("flag_bar_street_price_at_corner");
  scripts\engine\utility::flag_init("flag_bar_street_aq_some_dead");
  scripts\engine\utility::flag_init("flag_bar_street_aq_all_dead");
  scripts\engine\utility::flag_init("flag_bar_street_price_advance");
  scripts\engine\utility::flag_init("flag_bar_street_enter");
  scripts\engine\utility::flag_init("flag_bar_street_around_corner");
  scripts\engine\utility::flag_init("flag_bar_street_player_advance");
  scripts\engine\utility::flag_init("flag_bar_street_enforcer_to_apt");
  scripts\engine\utility::flag_init("flag_bar_street_enforcer_in_apt");
  scripts\engine\utility::flag_init("flag_bar_street_player_near_apt");
  scripts\engine\utility::flag_init("flag_bar_street_civs_cleanup");
  scripts\engine\utility::flag_init("flag_bar_street_alley_corpses_bagged");
  scripts\engine\utility::flag_init("flag_bar_street_end");
}

intro_stakeout_main() {
  if(getdvarint("stp_intro_cinematic") > 0) {
    thread intro_scene_camera();
    thread intro_scene_skip();
    thread intro_scene_butcher_aq();
    thread intro_scene_truck_sound();
  }

  thread intro_scene_nikolai();
  thread intro_scene_price();
  thread intro_scene_binocs();
  thread intro_scene_guncase();
  thread intro_stakeout_weapon_select();
  thread intro_stakeout_player_movement();
  thread intro_stakeout_fire_weapon_check();
  thread alley_car_alarm_setup();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_street_intro.gsc::vig_street_intro_start();
  thread intro_stakeout_wait_swap_butcher_vehicle();
  thread alley_stealth_bar_entrance_door_handler();
}

intro_scene_fake_player() {
  level.fake_player = scripts\engine\sp\utility::spawn_targetname("stakeout_fake_player", 1);
  level.fake_player.name = "Kyle";
  level.fake_player.animname = "fake_player";
  level.fake_player.script_friendname = "Kyle";
  level.fake_player visiblenotsolid();
  level.fake_player scripts\engine\sp\utility::name_hide();
  level.fake_player thread intro_scene_end_skip();
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_0 scripts\common\anim::anim_single_solo(level.fake_player, "intro_scene");
  level.player scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::smart_player_dialogue_interrupt, "dx_vom_kyle_stakeout_gear_40");

  if(isDefined(level.fake_player))
    level.fake_player delete();

  scripts\engine\utility::flag_set("flag_stakeout_fake_player_deleted");
}

intro_scene_end_skip() {
  var_0 = getanimlength(scripts\engine\utility::getanim("intro_scene"));
  wait(var_0 - 5.5);
  scripts\sp\utility::userskip_stop();
}

intro_stakeout_player_movement() {
  level.player allowfire(0);
  scripts\sp\player::player_movement_state("creep");
  setsaveddvar("MNPNORMOMP", 0.65);

  if(getdvarint("stp_intro_cinematic") > 0) {
    scripts\engine\sp\utility::player_speed_set(10, 0.5);
    scripts\engine\utility::flag_wait("flag_stakeout_fake_player_deleted");
  }

  scripts\engine\sp\utility::player_speed_set(60, 2.0);
  scripts\engine\utility::flag_wait("flag_stakeout_player_has_weapon");
  level.player allowfire(1);
  thread intro_stakeout_player_muzzle_discipline();
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_1");
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_stairs");
  level.player allowjump(1);
}

intro_stakeout_player_muzzle_discipline() {
  level endon("missionfailed");
  level.player endon("death");

  while(!scripts\engine\utility::flag("flag_alley_stealth_price_opening_door")) {
    var_0 = 1;
    var_1 = 1;

    if(distance2dsquared(level.player.origin, level.price.origin) < squared(128)) {
      if(scripts\engine\sp\utility::within_fov_of_players(level.price getEye(), cos(45)))
        var_0 = 0;
    }

    if(isDefined(level.nikolai)) {
      if(distance2dsquared(level.player.origin, level.nikolai.origin) < squared(128)) {
        if(scripts\engine\sp\utility::within_fov_of_players(level.nikolai getEye(), cos(45)))
          var_1 = 0;
      }
    }

    if(var_0 == 0 || var_1 == 0) {
      if(level.player scripts\engine\sp\utility::get_player_demeanor() != "relaxed") {
        level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
        wait 0.5;
      }
    } else if(level.player scripts\engine\sp\utility::get_player_demeanor() != "normal")
      level.player scripts\engine\sp\utility::set_player_demeanor("normal");

    wait 0.1;
  }

  if(level.player scripts\engine\sp\utility::get_player_demeanor() != "normal")
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

alley_stealth_player_movement() {
  scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  scripts\sp\player::player_movement_state("cqb");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

intro_scene_butcher_aq() {
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  wait 2;
  scripts\engine\sp\utility::array_spawn_function_targetname("enforcer_truck_spawner", ::intro_back_alley_enforcer_setup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("intro_back_alley_guys", ::intro_alley_aq_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq1_spawner", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq2_spawner", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq3_spawner", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq4_spawner", ::intro_alley_guard_setup);
  var_1 = scripts\engine\sp\utility::spawn_targetname("aq1_spawner");
  var_1 setModel("body_al_qatala_urban_lmg_variants_2_2");
  var_2 = scripts\engine\sp\utility::spawn_targetname("aq2_spawner");
  var_2 setModel("body_al_qatala_urban_a6_variants_1_2");
  var_3 = scripts\engine\sp\utility::spawn_targetname("aq3_spawner");
  var_3 setModel("body_al_qatala_urban_lmg_variants_2_1");
  var_4 = scripts\engine\sp\utility::spawn_targetname("aq4_spawner");
  var_4 setModel("body_al_qatala_urban_cqb_variants_1_2");
  var_5 = scripts\engine\sp\utility::spawn_targetname("enforcer_truck_spawner");
  level.enforcer = var_5;
  level.aq1 = var_1;
  var_6 = getEnt("stakeout_enforcer_truck", "targetname");
  var_6.animname = "techo";
  var_6 scripts\engine\sp\utility::assign_animtree("techo");
  var_5.name = "Butcher";
  var_5.script_friendname = "Butcher";
  scripts\engine\utility::exploder("birds_fly");
  scripts\engine\utility::kill_exploder("birds_cluster");
  var_5 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::disable_breath_fx();
  var_1 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::disable_breath_fx();
  var_2 scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::disable_breath_fx();
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_aq_truck_arrived", 8.0);
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_enforcer_visible", 19.0);
  var_7 = getanimlength(var_5 scripts\engine\utility::getanim("intro_scene"));
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_enforcer_left_alley", var_7);
  var_8 = scripts\engine\sp\utility::get_living_ai_array("intro_back_alley_guys", "script_noteworthy");
  scripts\engine\utility::array_thread(var_8, ::intro_alley_aq_handler);
  var_9 = [var_5, var_1, var_2, var_6];
  var_0 thread scripts\common\anim::anim_single_solo(var_6, "intro_scene");
  var_0 thread scripts\common\anim::anim_single_solo_run(var_1, "intro_scene");
  var_0 thread scripts\common\anim::anim_single_solo_run(var_2, "intro_scene");
  var_0 scripts\common\anim::anim_single_solo(var_5, "intro_scene");
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  var_8 = scripts\engine\utility::array_removedead_or_dying(var_8);
  scripts\engine\utility::array_delete(var_8);

  if(isDefined(var_5))
    var_5 delete();
}

intro_scene_truck_sound() {
  waitframe();
  level.player playSound("stp_intro_truck_by", "stop_intro_truck_by_sound");
}

intro_alley_guard_setup() {
  self endon("death");
  self endon("entitydeleted");
  level endon("missionfailed");
  scripts\common\ai::gun_remove();
  scripts\common\utility::demeanor_override("casual");
  self.animname = "aq4";
  var_0 = scripts\engine\utility::getStruct("intro_guard_org", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "civ_casual_idle");
}

intro_alley_aq_handler() {
  self endon("entitydeleted");
  level endon("missionfailed");
  var_0 = scripts\engine\utility::waittill_any_return("damage", "death", "bulletwhizby");
  level.player notify("shot_at_aq");
}

intro_scene_binocs() {
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  level.binocs = getEnt("intro_stakeout_binocs_free", "targetname");
  level.binocs.animname = "binocs";
  level.binocs scripts\engine\sp\utility::assign_animtree("binocs");

  if(getdvarint("stp_intro_cinematic") > 0)
    var_0 scripts\common\anim::anim_single_solo(level.binocs, "intro_scene");

  var_0 scripts\common\anim::anim_last_frame_solo(level.binocs, "intro_scene");
  scripts\engine\utility::flag_wait("flag_stakeout_end");
  level.binocs delete();
}

intro_stakeout_weapon_select() {
  level.player giveweapon("iw8_gunless");
  level.player switchtoweaponimmediate("iw8_gunless");
  level.player scripts\common\utility::allow_weapon_switch(0);
  thread initial_loadout_init();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_fire_weapon_indoors();
  scripts\engine\utility::flag_wait("flag_stakeout_player_in_kitchen");
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_guns");
  level.player waittill("initial_loadout_selected");
  scripts\engine\utility::flag_set("flag_stakeout_player_has_weapon");
  level.player scripts\common\utility::allow_weapon_switch(1);
  scripts\engine\utility::flag_wait_any("flag_stakeout_nikolai_closed_door", "flag_stakeout_end", "flag_alley_stealth_begin");
  level notify("initial_loadout_disable");
}

initial_loadout_init() {
  thread remove_gunless_monitor();
  var_0 = getEnt("price_gun_pickup", "targetname");
  var_0 makeunusable();
  var_1 = getEnt("papa320", "targetname");
  var_2 = getEnt("decho", "targetname");
  var_3 = getEnt("golf21", "targetname");
  var_1.base = "iw8_pi_papa320";
  var_1.attachments = ["silencerpstl_west01", "reflex_west01_pstl"];
  var_2.base = "iw8_pi_decho";
  var_2.attachments = ["silencerpstl_west01", "xmags_decho"];
  var_3.base = "iw8_pi_golf21";
  var_3.attachments = ["silencerpstl_west01", "minireddot_golf21"];
  var_1.string = &"STPETERSBURG/PICKUP_PI_PAPA320_SUPPRESSED";
  var_2.string = &"STPETERSBURG/PICKUP_PI_DECHO_SUPPRESSED";
  var_3.string = &"STPETERSBURG/PICKUP_PI_GOLF21_SUPPRESSED";
  var_4 = [var_1, var_2, var_3];

  foreach(var_6 in var_4)
  var_6 makeunusable();

  var_8 = spawn("script_origin", var_1 gettagorigin("j_gun"));
  var_9 = spawn("script_origin", var_2 gettagorigin("j_gun"));
  var_10 = spawn("script_origin", var_3 gettagorigin("j_gun"));
  var_8.gun = var_1;
  var_9.gun = var_2;
  var_10.gun = var_3;
  var_11 = [var_8, var_9, var_10];

  if(getdvarint("stp_intro_cinematic") > 0)
    scripts\engine\utility::flag_wait("flag_stakeout_allow_weapon_select");

  foreach(var_13 in var_11)
  var_13 thread initial_loadout_manager();

  scripts\engine\utility::flag_wait_any("flag_stakeout_nikolai_closed_door", "flag_stakeout_end", "flag_alley_stealth_begin");
  wait 1;

  foreach(var_13 in var_11)
  var_13 delete();
}

remove_gunless_monitor() {
  level.player waittill("initial_loadout_selected");
  level.player takeweapon("iw8_gunless");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::holster_logic();
}

initial_loadout_manager() {
  level endon("initial_loadout_disable");
  self.gun show();
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 3), self.gun.string, 10, 80, 40, 1);
  self waittill("trigger");
  level.player notify("initial_loadout_selected");

  if(isDefined(level.player.initial_loadout_weapon))
    level.player takeweapon(level.player.initial_loadout_weapon);

  var_0 = scripts\sp\utility::make_weapon(self.gun.base, self.gun.attachments);
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player givemaxammo(var_0);
  level.player.initial_loadout_weapon = var_0;
  self.gun hide();
  self.gun.hidden = 1;

  if(isDefined(level.player.initial_loadout))
    level.player.initial_loadout thread initial_loadout_manager();

  level.player.initial_loadout = self;
}

intro_stakeout_fire_weapon_check() {
  scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
  var_0 = getglassarray("stakeout_window");

  foreach(var_2 in var_0)
  thread intro_stakeout_window_monitor(var_2);

  thread intro_stakeout_dmg_trig_monitor();
  var_4 = getaiarray("axis");

  foreach(var_6 in var_4)
  var_6 thread intro_stakeout_enemy_monitor();
}

intro_stakeout_window_monitor(var_0) {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_price_move_down_stairs_1");

  for(;;) {
    if(isglassdestroyed(var_0)) {
      break;
    }

    wait 0.1;
  }

  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

intro_stakeout_dmg_trig_monitor() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_end");
  var_0 = getEnt("stakeout_window_dmg_trig", "targetname");
  var_0 waittill("trigger");
  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

intro_stakeout_enemy_monitor() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_end");
  self endon("entitydeleted");
  scripts\engine\utility::waittill_any("death", "damage", "bulletwhizby");
  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

fire_weapon_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_player_crazy_fail();
  wait 1.0;
  scripts\sp\player_death::set_custom_death_quote(426);
  thread scripts\sp\utility::missionfailedwrapper();
}

intro_stakeout_holster_weapon_check() {
  wait 3;

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 0)
    thread scripts\engine\sp\utility::display_hint_forced("holster_weapon", undefined, 0, level.player, "player_holsterWeapon");
}

intro_stakeout_wait_swap_butcher_vehicle() {
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  intro_stakeout_swap_butcher_vehicle();
}

intro_stakeout_swap_butcher_vehicle() {
  var_0 = getEnt("butcher_truck_scriptable", "targetname");
  var_1 = getEnt("stakeout_enforcer_truck", "targetname");

  if(isDefined(var_1)) {
    var_0 notify("stop_alarm");
    var_2 = scripts\engine\utility::getStruct("intro_butcher_truck_placed", "targetname");
    var_0.origin = var_2.origin;
    var_0.angles = var_2.angles;
    waitframe();
    var_1 delete();
  }

  var_3 = getEnt("butcher_car_scriptable", "targetname");
  var_3 notify("stop_alarm");
  var_4 = scripts\engine\utility::getStruct("intro_butcher_car_placed", "targetname");
  var_3.origin = var_4.origin;
  var_3.angles = var_4.angles;
}

alley_car_alarm_setup() {
  var_0 = getscriptablearray("no_alarm_vehicles", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("car_alarm", "off");
}

intro_scene_nikolai() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_nikolai();
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");

  if(getdvarint("stp_intro_cinematic") > 0)
    var_0 scripts\common\anim::anim_single_solo(level.nikolai, "intro_scene");

  var_1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle", "end_nikolai_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_kitchen_ready");

  if(!scripts\engine\utility::flag("flag_stakeout_player_has_weapon")) {
    scripts\engine\utility::flag_wait_all("flag_stakeout_player_has_weapon", "flag_stakeout_nikolai_kitchen_ready");
    var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
    var_1 notify("end_nikolai_kitchen_idle");
    var_1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_kitchen_exit_alt");

    if(!scripts\engine\utility::flag("flag_stakeout_player_ready_to_move") || !scripts\engine\utility::flag("flag_stakeout_price_kitchen_ready"))
      var_1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle", "end_nikolai_kitchen_idle");
  }

  scripts\engine\utility::flag_set("flag_stakeout_nikolai_kitchen_extra_ready");
  scripts\engine\utility::flag_wait_all("flag_stakeout_player_ready_to_move", "flag_stakeout_price_kitchen_ready", "flag_stakeout_nikolai_kitchen_ready", "flag_stakeout_nikolai_kitchen_extra_ready");
  var_1 notify("end_nikolai_kitchen_idle");
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_kitchen_exit");
  var_1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle02", "end_nikolai_kitchen_idle02");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_stairs_ready");
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  var_1 notify("end_nikolai_kitchen_idle02");
  thread bar_animate_door("stakeout_apt_scene_org", "stakeout_apt_exit_door", "stakeout_door_close", 1);
  var_1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_door_close");
  level.nikolai scripts\engine\sp\utility::hide_notsolid();
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_closed_door");
}

#using_animtree("script_model");

intro_scene_guncase() {
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_1 = getEnt("intro_stakeout_guncase", "targetname");
  var_1.animname = "guncase";
  var_1 useanimtree(#animtree);

  if(getdvarint("stp_intro_cinematic") > 0) {
    var_0 scripts\common\anim::anim_first_frame_solo(var_1, "intro_scene");
    var_0 scripts\common\anim::anim_single_solo(var_1, "intro_scene");
  }

  var_0 scripts\common\anim::anim_last_frame_solo(var_1, "intro_scene");
}

intro_scene_price() {
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  level.price scripts\common\utility::demeanor_override("casual");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\common\ai::gun_remove();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");

  if(getdvarint("stp_intro_cinematic") > 0) {
    var_0 scripts\common\anim::anim_single_solo(level.price, "intro_scene");
    level.price notify("end_silenced_pistol_hack");
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_choose_weapon();
  var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_kitchen_idle", "end_price_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_price_kitchen_ready");
  thread intro_stakeout_kitchen_clip();
  scripts\engine\utility::flag_wait("flag_stakeout_player_has_weapon");
  scripts\engine\utility::flag_set("flag_stakeout_player_ready_to_move");
  thread intro_stakeout_holster_weapon_check();
  scripts\engine\utility::flag_wait_all("flag_stakeout_player_ready_to_move", "flag_stakeout_price_kitchen_ready", "flag_stakeout_nikolai_kitchen_ready", "flag_stakeout_nikolai_kitchen_extra_ready");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_quickly_and_quietly();
  var_1 notify("end_price_kitchen_idle");
  thread bar_animate_door("stakeout_apt_scene_org", "stakeout_apt_exit_door", "stakeout_kitchen_exit", 0);
  var_1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit");
  thread intro_stakeout_landing_clip();

  if(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1")) {
    var_1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit_to_idle");

    if(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1")) {
      var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_idle_stairs", "end_stairs_idle");
      scripts\engine\utility::flag_set("flag_stakeout_price_stairs_ready");
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_exit_apartment();
      scripts\engine\utility::flag_wait_all("flag_stakeout_price_move_down_stairs_1", "flag_stakeout_price_stairs_ready");
      var_1 notify("end_stairs_idle");
      level.price scripts\engine\sp\utility::anim_stopanimScripted();
    }

    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_start_down_stairs();
    var_1 scripts\common\anim::anim_single_solo(level.price, "stakeout_idle_exit_stairs");
  } else {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_start_down_stairs();
    var_1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit_to_stairs");
  }

  thread intro_stakeout_stairs_clip();
  var_1 scripts\common\anim::anim_single_solo(level.price, "stakeout_descend_stairs");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_at_door");

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 1 && scripts\engine\utility::flag("flag_alley_stealth_player_near_exit_door"))
    scripts\engine\utility::flag_set("flag_stakeout_price_exit_quick");
  else
    var_1 thread scripts\common\anim::anim_loop_solo(level.price, "stealth_door_idle", "end_door_idle");
}

price_silenced_pistol_hack() {
  level.price endon("end_silenced_pistol_hack");

  while(!isDefined(level.price.weapon))
    waitframe();

  while(createheadicon(level.price.weapon) == "iw8_pi_papa320+mag_papa320+rec_papa320+silencerpstl_west01+slide_papa320")
    waitframe();

  level.price scripts\anim\shared.gsc::forceuseweapon(level.price.silenced_pistol, "primary");
}

#using_animtree("generic_human");

intro_scene_skip() {
  wait 1;
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  level notify("intro_scene_skipped");
  level.player stopsounds();
  var_1 = getanimlength(level.fake_player scripts\engine\utility::getanim("intro_scene"));
  var_2 = [];
  var_2[0] = level.price;
  var_2[1] = level.nikolai;
  var_2[2] = level.binocs;
  var_2[3] = getEnt("intro_stakeout_guncase", "targetname");
  var_2[4] = level.fake_player;
  var_3 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");

  foreach(var_5 in var_2) {
    var_6 = var_5 getanimtime(var_5 scripts\engine\utility::getanim("intro_scene"));
    var_7 = var_6 * getanimlength(var_5 scripts\engine\utility::getanim("intro_scene")) * 30;

    if(var_7 >= 778) {
      switch (var_5.animname) {
        case "price":
          var_8 = % stp_bar_010_intro_scene_price_face;
          var_5 scripts\sp\anim_notetrack::mayhem_end(var_8);
          break;
        case "nikolai":
          var_8 = % stp_bar_010_intro_scene_nikolai_face;
          var_5 scripts\sp\anim_notetrack::mayhem_end(var_8);
          break;
        case "fake_player":
          var_8 = % stp_bar_010_intro_scene_kyle_face;
          var_5 scripts\sp\anim_notetrack::mayhem_end(var_8);
          break;
        default:
          break;
      }
    }

    var_5 stopanimScripted();
    var_3 thread scripts\common\anim::anim_single_solo(var_5, "intro_scene2");
  }

  var_10 = [];
  var_10[0] = getEnt("aq1_spawner", "targetname");
  var_10[1] = getEnt("aq2_spawner", "targetname");
  var_10[2] = getEnt("stakeout_enforcer_truck", "targetname");

  foreach(var_5 in var_10)
  var_5 setanimtime(var_5 scripts\engine\utility::getanim("intro_scene"), 0.9);

  scripts\engine\utility::delaythread(0.5, scripts\sp\hud_util::fade_in, 0.1);
  level.nikolai scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  level.price scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::dialogue_stop();
  thread scripts\sp\maps\stpetersburg\stpetersburg_anim.gsc::car_brakelights_off(var_10[2]);
  var_13 = getEnt("enforcer_truck_spawner", "targetname");

  if(isDefined(var_13))
    var_13 delete();

  scripts\engine\utility::flag_set("motion_blur_off");
  scripts\engine\utility::flag_set("camera_intro_dof_off");
  scripts\engine\sp\utility::dof_disable();
  scripts\engine\sp\utility::motion_blur_disable(0.5);
  level notify("cine_letterboxing");
  intro_scene_end(1);
}

intro_stakeout_kitchen_clip() {
  var_0 = getEnt("stakeout_kitchen_clip", "targetname");
  var_0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var_0 connectpaths();
  wait 0.5;
  var_0 delete();
}

intro_stakeout_landing_clip() {
  var_0 = getEnt("stakeout_stairs_landing_clip", "targetname");
  var_0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var_0 connectpaths();
  wait 0.5;
  var_0 delete();
}

intro_stakeout_stairs_clip() {
  var_0 = getEnt("stakeout_stairs_top_clip", "targetname");
  var_0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var_0 connectpaths();
  wait 0.5;
  var_0 delete();
}

intro_stakeout_door_clip(var_0) {
  var_1 = getEnt("stakeout_bedroom_door_clip", "targetname");

  if(var_0 == 1) {
    var_1 movez(128, 0.1, 0.05, 0.05);
    var_1 connectpaths();
  } else {
    var_1 movez(-128, 0.1, 0.05, 0.05);
    var_1 disconnectPaths();
  }
}

waittill_lookat_price_or_door_or_delay(var_0, var_1) {
  level endon(var_0);
  level endon("missionfailed");
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_player_ready_to_move", var_1);
  var_2 = scripts\engine\utility::getStruct("stakeout_exit_door_lookat", "targetname");

  for(;;) {
    var_3 = scripts\engine\sp\utility::within_fov_of_players(level.price getEye(), cos(45));
    var_4 = scripts\engine\sp\utility::within_fov_of_players(var_2.origin, cos(45));

    if(var_3 == 1 || var_4 == 1) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set(var_0);
}

waittill_player_weapon_holstered() {
  for(;;) {
    if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered()) {
      break;
    }

    waitframe();
  }
}

bar_rotate_door(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = getEnt(var_0, "targetname");
  var_4 = getEnt(var_0 + "_clip", "targetname");
  var_4 linkTo(var_3);
  var_3 rotateYaw(var_1, 1.0, 0.05, 0.05);
  wait 1.0;

  if(var_2 == 0)
    var_4 connectpaths();
  else
    var_4 disconnectPaths();
}

#using_animtree("script_model");

bar_animate_door(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_7 = getEnt(var_1, "targetname");
  var_8 = getEnt(var_1 + "_clip", "targetname");

  if(var_8 islinked() == 0)
    var_8 linkTo(var_7);

  var_7.animname = "door";
  var_7 useanimtree(#animtree);

  if(var_4 == 1)
    var_6 scripts\common\anim::anim_first_frame_solo(var_7, var_2);
  else if(var_5 == 1) {
    var_9 = var_7 getanimtime(var_7 scripts\engine\utility::getanim(var_2));
    var_6 thread scripts\common\anim::anim_single_solo(var_7, var_2);
    var_7 setanimrate(var_7 scripts\engine\utility::getanim(var_2), 2.0);
    wait(var_9 * 0.5);
  } else
    var_6 scripts\common\anim::anim_single_solo(var_7, var_2);

  if(var_3 == 0)
    var_8 connectpaths();
  else
    var_8 disconnectPaths();
}

intro_alley_aq_setup() {
  self endon("death");
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_enemy_low_health();
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
}

alley_stealth_aq_setup() {
  self endon("death");
  self endon("entitydeleted");
  thread alley_stealth_check_for_player_kill();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler(0.5, 1.0, ["flag_alley_stealth_player_killed_aq", "flag_alley_stealth_price_ambush_end"]);
  scripts\engine\sp\utility::set_battlechatter(0);
  self.script_longdeath = 0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_enemy_low_health();
  scripts\common\utility::demeanor_override("casual_gun");
  scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\sp\utility::set_dontmelee(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\engine\sp\utility::disable_danger_react();
  scripts\engine\sp\utility::disable_surprise();
  self.anim_react_skip_stopanimscripted = 1;
  thread alley_stealth_aq_alert();
  thread alley_stealth_aq_prox_check();
  var_0 = level scripts\engine\utility::waittill_any_return("alley_alert", "price_ambush");

  if(var_0 == "price_ambush") {
    if(scripts\engine\utility::is_equal(self.targetname, "alley_stealth_aq01")) {
      return;
    }
    self getenemyinfo(level.price);
  } else {
    var_1 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis");

    if(isDefined(var_1) && self == var_1) {
      waitframe();
      var_2 = vectorNormalize(level.player.origin - self.origin);
      var_3 = anglesToForward(self.angles);
      var_4 = anglestoright(self.angles);
      var_5 = vectordot(var_2, var_3);
      var_6 = vectordot(var_2, var_4);
      var_7 = undefined;

      if(var_5 > 0.7)
        var_7 = "reb_stl_patrol_pstl_idle_react_md_8";
      else if(var_5 < -0.7)
        var_7 = "reb_stl_patrol_pstl_idle_react_md_2";
      else if(var_6 > 0.7)
        var_7 = "reb_stl_patrol_pstl_idle_react_md_6";
      else if(var_6 < -0.7)
        var_7 = "reb_stl_patrol_pstl_idle_react_md_4";
      else
        iprintlnbold("Fwd = " + var_5 + " ... Right = " + var_6);

      if(isDefined(var_7)) {
        self.animname = "aq01";
        scripts\common\anim::anim_single_solo_run(self, var_7);
      }
    } else {
      scripts\engine\sp\utility::anim_stopanimScripted();
      self notify("stop_first_frame");
    }

    self getenemyinfo(level.player);
  }

  var_8 = getEnt("alley_stealth_enemy_vol", "targetname");
  self setgoalvolumeauto(var_8);
  scripts\common\utility::clear_demeanor_override();
  scripts\engine\sp\utility::set_ignoreme(0);
  scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\sp\utility::set_pacifist(1);
  scripts\engine\sp\utility::disable_dontevershoot();
  self.dontshootwhilemoving = 0;
  self.allowstrafe = 1;
  var_9 = scripts\common\utility::getdifficulty();
  var_10 = randomfloatrange(1.0, 3.0);

  if(var_0 == "price_ambush" && var_9 == "easy")
    var_10 = randomfloatrange(5.0, 8.0);
  else if(var_0 == "price_ambush" && var_9 == "medium")
    var_10 = randomfloatrange(3.0, 5.0);

  wait(var_10);
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\sp\utility::set_dontmelee(0);
  scripts\engine\sp\utility::set_pacifist(0);
  scripts\engine\sp\utility::set_battlechatter(1);
}

alley_stealth_check_for_player_kill() {
  self endon("entitydeleted");
  self waittill("death", var_0);

  if(isDefined(var_0) && var_0 == level.player)
    scripts\engine\utility::flag_set("flag_alley_stealth_player_killed_aq");
}

alley_stealth_aq_alert() {
  level endon("flag_alley_stealth_aq_dead");
  level endon("price_ambush");
  level endon("pre_price_ambush");
  level endon("alley_alert");
  level endon("flag_alley_stealth_mission_fail");
  self endon("death");
  var_0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby", "weapon_fired", "player_prox");
  level notify("alley_alert");
}

alley_stealth_aq_prox_check() {
  level endon("flag_alley_stealth_aq_dead");
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("flag_alley_stealth_mission_fail");
  self endon("death");
  self endon("entitydeleted");
  wait 0.1;
  var_0 = 128;

  if(isDefined(self.animname) && self.animname == "aq01")
    var_0 = 64;

  for(;;) {
    if(scripts\engine\sp\utility::players_within_distance(var_0, self.origin)) {
      self notify("player_prox");
      return;
    }

    wait 0.1;
  }
}

intro_back_alley_enforcer_setup() {
  self endon("entitydeleted");
  var_0 = getEnt("enforcer_exit_goal", "targetname");
  scripts\common\utility::demeanor_override("casual");
  scripts\engine\sp\utility::set_pacifist(1);

  if(self.animname == "enforcer")
    scripts\common\ai::gun_remove();

  waitframe();
  scripts\engine\utility::flag_wait("flag_stakeout_enforcer_left_alley");
  self delete();
}

alley_stealth_player_fail_handler() {
  level.player endon("death");
  level endon("flag_alley_stealth_aq_dead");
  level endon("flag_alley_stealth_mission_fail");
  level endon("flag_backroom_player_rushes");
  var_0 = level scripts\engine\utility::waittill_any_return("alley_alert", "price_ambush");
  var_1 = getEntArray("stealth_alley_nosight_clip", "targetname");
  scripts\engine\utility::array_delete(var_1);
  var_2 = 7;
  var_3 = scripts\common\utility::getdifficulty();

  if(var_3 == "medium")
    var_2 = 6;
  else if(var_3 == "hard")
    var_2 = 5;
  else if(var_3 == "fu")
    var_2 = 4;

  var_4 = getEntArray("alley_stealth_player_exposed_vol", "targetname");

  foreach(var_6 in var_4) {
    if(level.player istouching(var_6))
      var_2 = var_2 + 2;
  }

  if(var_0 == "price_ambush") {
    scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_end");
    var_2 = var_2 + 2;
    thread scripts\engine\utility::flag_set_delayed("flag_alley_stealth_near_fail", var_2 * 0.75);
    wait(var_2);
  } else {
    scripts\engine\utility::flag_set("flag_alley_stealth_cover_blown");
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_cover_blown();
    thread scripts\engine\utility::flag_set_delayed("flag_alley_stealth_near_fail", var_2 * 0.75);
    wait(var_2);
  }

  if(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    var_8 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");
    scripts\engine\utility::array_thread(var_8, ::enemy_magic_bullet_shield);
    thread alley_stealth_player_fail();
  }
}

enemy_magic_bullet_shield() {
  if(!isDefined(self.melee))
    thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
}

alley_stealth_player_fail() {
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_set("flag_alley_stealth_mission_fail");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_butcher_alerted_fail();
  wait 2.0;
  scripts\sp\player_death::set_custom_death_quote(426);
  thread scripts\sp\utility::missionfailedwrapper();
}

alley_stealth_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_alley_stealth_player_opens_bar_door", "stpetersburg_stakeout_script_tr", "stpetersburg_bar_script_tr");
  thread alley_stealth_player_movement();
  thread alley_stealth_enemies();
  thread alley_stealth_player_fail_handler();
  thread alley_stealth_check_player();
  thread alley_stealth_price_setup();
  thread alley_stealth_stakeout_exit_door_handler();
  thread move_speed_reset();
}

move_speed_reset() {
  while(level.price.ignoreall)
    waitframe();

  setsaveddvar("MNPNORMOMP", 1);
}

alley_stealth_enemies() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", ::alley_stealth_aq_setup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::aq_override_pistol_silenced);
  var_0 = scripts\engine\sp\utility::array_spawn_noteworthy("alley_stealth_aq");
  var_1 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");
  var_1.animname = "aq01";
  var_1.script_animname = "aq01";
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1 setModel("body_al_qatala_urban_a6_variants");
  var_2 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq02", "targetname");
  var_2.animname = "aq02";
  var_2.script_animname = "aq02";
  var_2 scripts\engine\sp\utility::set_allowdeath(1);
  var_2 setModel("body_al_qatala_urban_lmg_variants_2_2");
  var_3 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq03", "targetname");
  var_3.animname = "aq03";
  var_3.script_animname = "aq03";
  var_3 scripts\engine\sp\utility::set_allowdeath(1);
  var_3 setModel("body_al_qatala_urban_lmg_variants_2_1");
  var_4 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq04", "targetname");
  var_4.animname = "aq04";
  var_4.script_animname = "aq04";
  var_4 scripts\engine\sp\utility::set_allowdeath(1);
  var_4 setModel("body_al_qatala_urban_cqb_variants_1_2");
  var_1 thread alley_stealth_grabbed_enemy_handler();
  var_2 thread alley_stealth_background_enemy_handler();
  var_3 thread alley_stealth_background_enemy_handler();
  var_4 thread alley_stealth_background_enemy_handler();
  thread alley_stealth_remove_dead_bodies();
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_end", "flag_alley_stealth_aq_dead");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_clean_up_last_enemy(var_0, randomfloatrange(4.0, 6.0));

  if(var_0.size > 0) {
    foreach(var_6 in var_0) {
      if(scripts\engine\utility::flag("flag_alley_stealth_price_ambush_begin") && var_6.targetname == "alley_stealth_aq01")
        continue;
      else
        var_6 scripts\engine\sp\utility::anim_stopanimScripted();
    }
  }
}

alley_stealth_grabbed_enemy_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  self endon("death");
  self endon("entitydeleted");
  var_0 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "stealth_alley_intro");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  var_0 scripts\common\anim::anim_single_solo(self, "stealth_alley_intro");
  var_0 scripts\common\anim::anim_single_solo(self, "stealth_alley_shootout");
  self.skipdeathanim = 1;
  self.diequietly = 1;
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\sp\utility::die();
}

alley_stealth_background_enemy_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  self endon("death");
  self endon("entitydeleted");
  var_0 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  var_0 scripts\common\anim::anim_first_frame_solo(self, "stealth_alley_intro");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  var_0 scripts\common\anim::anim_single_solo(self, "stealth_alley_intro");
  var_0 scripts\common\anim::anim_single_solo_run(self, "stealth_alley_shootout");
}

alley_stealth_bar_entrance_door_handler() {
  var_0 = scripts\sp\door::get_interactive_door("bar_alley_entrance_interactive_door");
  var_1 = getEntArray("bar_alley_entrance_interactive_door", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  var_0.script_max_left_angle = 100;
  var_0.script_max_right_angle = 100;
  var_0 scripts\sp\door::init_max_yaws();
  var_0 scripts\game\sp\door::remove_door_c4_ability();
  scripts\engine\utility::flag_wait("flag_alley_stealth_begin");
  var_5 = getEnt("bar_alley_entrance_door", "targetname");
  var_5 delete();

  foreach(var_3 in var_1)
  var_3 show();

  scripts\engine\utility::flag_wait_any("flag_alley_stealth_aq_dead", "flag_alley_stealth_player_near_bar_door");
  var_8 = getEnt("bar_alley_entrance_door_clip", "targetname");
  var_8 movez(-256, 0.1, 0.05, 0.05);
  var_8 connectpaths();
  thread alley_stealth_monitor_door_bash();
  var_0 thread player_weapon_holstered_door_bash_monitor();
  var_0 thread bar_alley_entrance_door_interacted();
  scripts\engine\utility::flag_wait("flag_bomb_room_enforcer_clear");
  var_0 scripts\sp\door::reset_door();
  var_0 scripts\sp\door::remove_open_ability();
  var_0.max_yaw_left = 110;
  var_0.max_yaw_right = 110;
  var_0 scripts\sp\door::init_max_yaws();
  var_8 movez(256, 0.1, 0.05, 0.05);
  var_8 disconnectPaths();
  wait 0.2;
  var_8 delete();
  var_9 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  if(var_9.size > 0)
    scripts\engine\utility::array_delete(var_9);
}

alley_stealth_door_hint_handler() {
  level endon("flag_alley_stealth_player_opens_bar_door");
  scripts\engine\utility::flag_wait("flag_alley_stealth_aq_dead");
  self.no_bash = 1;
  self.open_struct.no_open_interact = undefined;
  self.open_struct scripts\sp\door::create_open_interact_hint();
}

alley_stealth_monitor_door_bash() {
  level endon("missionfailed");
  level.player endon("death");
  var_0 = scripts\engine\utility::flag_wait_any_return("door_bashed", "flag_alley_stealth_player_opens_bar_door");

  if(scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    return;
  }
  scripts\engine\utility::flag_set("flag_backroom_player_rushes");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_player_rushed_door();
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  scripts\engine\utility::flag_set("flag_player_blew_backroom_stealth");
}

replace_door_open_interact_hint() {
  var_0 = "Open";

  if(!istrue(self.openinteract) || !isDefined(self.cursor_hint_ent)) {
    self.open_struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var_0, 45, 600, 80, 1);
    self.open_struct.cursor_hint_ent setusewhenhandsoccupied(1);
    self.open_struct.openinteract = 1;
  }
}

alley_stealth_check_player() {
  thread alley_stealth_check_if_player_shoots();
  thread alley_stealth_check_if_player_unholsters();
}

alley_stealth_check_if_player_shoots() {
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  level.player waittill("weapon_fired");
  level notify("alley_alert");
}

alley_stealth_check_if_player_unholsters() {
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  var_0 = getEntArray("alley_stealth_player_exposed_vol", "targetname");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");

  for(;;) {
    foreach(var_2 in var_0) {
      if(level.player istouching(var_2) && scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 0) {
        level notify("alley_alert");
        return;
      }
    }

    wait 0.1;
  }
}

alley_stealth_reset_enemy_alert_level() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "alertreset");
  scripts\stealth\enemy::set_alert_level("reset");
  scripts\stealth\enemy::bt_set_stealth_state("idle");
}

alley_place_truck_start() {
  var_0 = getEnt("stakeout_enforcer_truck", "targetname");
  var_0.animname = "techo";
  var_0 scripts\engine\sp\utility::assign_animtree("techo");
  var_1 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_1 scripts\common\anim::anim_last_frame_solo(var_0, "intro_scene");
}

alley_stealth_start_function() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stakeout_fire_weapon_indoors();
  thread intro_stakeout_player_muzzle_discipline();
  thread alley_stealth_price_from_start_point();
  thread alley_stealth_bar_entrance_door_handler();
  thread alley_place_truck_start();
  thread alley_car_alarm_setup();
}

alley_stealth_price_from_start_point() {
  var_0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_0 thread scripts\common\anim::anim_loop_solo(level.price, "stealth_door_idle", "end_door_idle");
  level.price scripts\common\ai::gun_remove();
  scripts\engine\utility::flag_set("flag_alley_stealth_price_at_door");
}

alley_stealth_price_setup() {
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  thread alley_stealth_price_combat();
  thread alley_stealth_price_adjust_ff_penalty();
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\common\utility::demeanor_override("casual_killer");
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  level.price scripts\engine\sp\utility::set_ignoreme(1);
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\engine\sp\utility::set_goal_radius(16);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  scripts\engine\utility::flag_set("flag_alley_stealth_begin");
  var_0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_1 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_at_door");
  thread alley_stealth_price_alert_end_door_idle();
  scripts\engine\utility::flag_wait("flag_alley_stealth_player_near_exit_door");
  alley_stealth_price_check_player();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_price_at_door();
  var_0 notify("end_door_idle");
  level notify("stealth_alley_intro_door");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_opening_door");
  scripts\engine\utility::flag_set("flag_start_alley_containment");
  thread scripts\engine\sp\utility::autosave_by_name("alley_stealth_price_opens_door");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_price_conversation();
  thread alley_stealth_draw_weapon_check();
  thread alley_stealth_pre_price_ambush_notify();
  var_1 scripts\common\anim::anim_single_solo(level.price, "stealth_alley_intro");
  level notify("price_ambush");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_begin");
  var_2 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");

  if(isDefined(var_2) && isalive(var_2)) {
    var_2 scripts\engine\sp\utility::set_allowdeath(0);
    var_2 actoraimassistoff();
    var_1 scripts\common\anim::anim_single_solo_run(level.price, "stealth_alley_shootout");
  }

  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_end");
}

alley_stealth_price_check_player() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_alley_stealth_cover_blown");
  level endon("alley_alert");

  if(scripts\engine\utility::flag("flag_stakeout_price_exit_quick")) {
    return;
  }
  if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 0) {
    thread intro_stakeout_holster_weapon_check();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_stealth_again_holster_weapon_nag();

    for(;;) {
      if(scripts\engine\sp\utility::players_within_distance(180, level.price.origin) && scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered()) {
        level notify("weapon_holstered");
        break;
      }

      waitframe();
    }
  }
}

alley_stealth_price_alert_end_door_idle() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_price_opening_door");
  level waittill("alley_alert");
  scripts\engine\utility::flag_set("flag_alley_stealth_cover_blown");
  var_0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var_0 notify("end_door_idle");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 0, 0, 1);
}

alley_stealth_draw_weapon_check() {
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_setup");
  wait 0.1;

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 1) {
    thread scripts\engine\sp\utility::display_hint("draw_weapon", undefined, 0, level.player, "draw_weapon");

    for(;;) {
      if(scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::player_weapon_holstered() == 0) {
        level.player notify("draw_weapon");
        return;
      }

      wait 0.1;
    }
  }
}

alley_stealth_pre_price_ambush_notify() {
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  wait(getanimlength(level.price scripts\engine\utility::getanim("stealth_alley_intro")));
  level notify("pre_price_ambush");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_setup");
}

get_aq_for_shootout_anim(var_0) {
  var_1 = scripts\engine\sp\utility::get_living_ai(var_0 + "_spawner_alt", "targetname");

  if(isDefined(var_1))
    return var_1;
}

kill_aq_for_shootout_anim() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("alley_alert");
  self endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_begin");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");
  var_0 = scripts\engine\utility::array_remove(var_0, self);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::waittill_alive_count(var_0, 0);
  scripts\engine\utility::flag_set("flag_alley_stealth_aq_dead");
}

alley_stealth_price_combat() {
  level endon("missionfailed");
  level.player endon("death");
  var_0 = scripts\engine\utility::flag_wait_any_return("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_end");

  if(scripts\engine\utility::flag("flag_alley_stealth_price_at_door"))
    level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(var_0 == "flag_alley_stealth_cover_blown") {
    var_1 = scripts\sp\utility::make_weapon("iw8_pi_papa320", ["silencerpstl_west01"]);
    level.price.silenced_pistol = var_1;
    level.price scripts\anim\shared.gsc::forceuseweapon(var_1, "sidearm");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_average();
    level.player.og_attackeraccuracy = level.player.attackeraccuracy;
    var_2 = scripts\common\utility::getdifficulty();

    if(var_2 == "medium")
      level.player scripts\sp\utility::set_player_attacker_accuracy(2);
    else if(var_2 == "hard")
      level.player scripts\sp\utility::set_player_attacker_accuracy(3);
    else if(var_2 == "fu")
      level.player scripts\sp\utility::set_player_attacker_accuracy(5);

    level.price scripts\engine\sp\utility::enable_ai_color();
    scripts\engine\sp\utility::activate_trigger_with_targetname("price_alley_combat_colors");
  } else {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_high();
    var_3 = getnode("alley_stealth_price_node", "targetname");
    level.price scripts\engine\sp\utility::disable_ai_color();
    level.price scripts\engine\sp\utility::set_goal_radius(32);
    level.price scripts\engine\sp\utility::set_goal_node(var_3);
  }

  var_4 = getEnt("alley_stealth_interior_vol", "targetname");

  if(level.price istouching(var_4))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();

  level.price scripts\engine\sp\utility::set_ignoreall(0);
  level.price scripts\engine\sp\utility::set_ignoreme(0);
  level.price scripts\common\utility::clear_demeanor_override();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  thread alley_stealth_price_clean_house();
  var_0 = scripts\engine\utility::flag_wait_any_return("flag_alley_stealth_aq_dead", "flag_backroom_player_rushes");

  if(var_0 == "flag_alley_stealth_aq_dead") {
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_enemies_dead();
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_average();
    alley_stealth_price_post_at_door();
    scripts\engine\utility::flag_wait("flag_alley_stealth_player_opens_bar_door");
    level.price scripts\common\utility::demeanor_override("cqb");
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  }

  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("price_move_to_alley_door_colors", "targetname", "activate");
  level.player notify("remove_gunless");
  scripts\engine\sp\utility::trigger_wait_targetname("trig_send_price_down_backaroom_stairs");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
}

alley_stealth_price_adjust_ff_penalty() {
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_begin", "flag_alley_stealth_price_opening_door");
  level.price.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.1);
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_aq_dead", "flag_backroom_player_rushes");
  level.price.friend_kill_points = undefined;
}

alley_stealth_price_post_at_door() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_player_opens_bar_door");
  scripts\engine\sp\utility::autosave_by_name("alley_stealth_complete");
  var_0 = scripts\engine\utility::getStruct("price_alley_struct_midpoint", "targetname");
  level.price scripts\sp\spawner::go_to_node(var_0);
  level.price scripts\engine\sp\utility::set_goal_node_targetname("enter_alley_bar_node");
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_alley_stealth_move_to_bar_door();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
}

waittill_struct_within_fov(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getEnt(var_1, "targetname");
  var_4 = cos(35);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, var_4) && level.player istouching(var_3)) {
      break;
    } else
      waitframe();
  }
}

alley_stealth_price_clean_house() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_aq_dead");
  level endon("flag_alley_stealth_player_opens_bar_door");
  wait 1.0;
  var_0 = scripts\common\utility::getdifficulty();
  var_1 = 1;

  if(var_0 == "easy")
    var_1 = 2;
  else
    return;

  var_2 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  while(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    waitframe();
    var_2 = scripts\engine\utility::array_removedead_or_dying(var_2);

    if(var_2.size > var_1)
      continue;
    else if(var_2.size == 0) {
      break;
    }

    var_3 = scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_get_los_enemy(var_2);
    level.price shoot(100, var_3 getEye());
    var_3 waittill("death");
    wait 1.0;
  }
}

alley_stealth_remove_dead_bodies() {
  level endon("flag_bar_shootout_enter");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  var_0 = getcorpsearray();

  foreach(var_2 in var_0)
  var_2 delete();
}

alley_stealth_stakeout_exit_door_handler() {
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 1, 1);
  var_0 = level scripts\engine\utility::waittill_any_return("stealth_alley_intro_door", "stealth_alley_cancel_door");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 0);
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 1, 1);
}

bar_interior_exit_door_handler() {
  scripts\engine\utility::flag_wait("flag_enforcer_exit_shootout_door");
  thread bar_rotate_door("bar_interior_exit_door", 105);
}

bar_enforcer_second_handler() {
  var_0 = scripts\engine\utility::getStruct("backroom_enforcer_anim_struct", "targetname");

  if(!isDefined(level.enforcer))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("node_enforcer_bomb_room");

  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  level.enforcer endon("death");
  var_1 = getnode("node_enforcer_bomb_room", "script_noteworthy");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var_1);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var_0 thread scripts\common\anim::anim_loop_solo(level.enforcer, "backroom_idle", "startled");
  thread enforcer_backroom_shot();
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_player_blew_cover();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var_0 notify("startled");
  thread bomb_room_spawn_extra_guy();
  thread scripts\engine\utility::flag_set_delayed("flag_enforcer_flees_backroom", 1.0);
  var_0 scripts\common\anim::anim_single_solo(level.enforcer, "backroom_react");
  scripts\engine\utility::flag_set("flag_bomb_room_enforcer_clear");
  var_1 = getnode("node_enforcer_exit_bomb_room", "targetname");
  level.enforcer setgoalnode(var_1);
  thread bar_enforcer_third_handler();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_player_exit_back_room", 20);
}

enforcer_backroom_shot() {
  level endon("flag_enforcer_flees_backroom");
  level.enforcer endon("death");
  var_0 = 200;
  level.enforcer.fake_health = var_0;

  while(isalive(level.enforcer) && level.enforcer.fake_health > 0) {
    level.enforcer waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_2) && var_2 != level.player) {
      continue;
    }
    level.enforcer.fake_health = 0;
    waitframe();
  }
}

bomb_room_check_if_enforcer_clear() {
  var_0 = getnodearray("post_enforcer_node", "targetname");

  foreach(var_2 in var_0)
  var_2 disconnectnode();

  var_4 = [];
  var_4[0] = getEnt("enemy_bomb_room_left", "script_noteworthy");
  var_4 = scripts\engine\utility::array_removedead_or_dying(var_4);
  scripts\engine\sp\utility::waittill_dead(var_4, var_4.size);
  scripts\engine\utility::flag_wait("flag_bomb_room_enforcer_clear");
  scripts\engine\utility::flag_set("flag_bomb_room_exit_clear");

  foreach(var_2 in var_0)
  var_2 connectnode();
}

bar_enforcer_third_handler() {
  if(!isDefined(level.enforcer))
    scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("node_enforcer_club");
  else {
    var_0 = getnode("node_enforcer_club", "targetname");
    level.enforcer scripts\engine\sp\utility::teleport_ai(var_0);
  }

  level.enforcer endon("death");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  level.enforcer scripts\engine\sp\utility::clear_force_color();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var_1 = scripts\engine\utility::getStruct("enforcer_bar_slide_anim_org", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(level.enforcer, "bar_escape_slide");
  scripts\engine\utility::flag_wait_either("flag_bar_shootout_enter", "flag_shootout_enemies_shot_early");
  thread bar_shootout_enforcer_impulse();
  scripts\engine\utility::delaythread(4.5, scripts\engine\utility::flag_set, "flag_enforcer_exit_shootout_door");
  var_2 = scripts\engine\utility::getStruct("enforcer_bar_exit_anim_org", "targetname");
  var_2 scripts\common\anim::anim_single_solo(level.enforcer, "bar_escape_exit");
  scripts\engine\utility::flag_set("flag_shootout_turn_off_player_kill");
  var_0 = getnode("node_enforcer_alley", "targetname");
  level.enforcer setgoalnode(var_0);
  level.enforcer stopanimScripted();
  level.enforcer scripts\engine\sp\utility::teleport_ai(var_0);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::trigger_wait_targetname("enforcer_exit_to_alley_trig");
  thread kitchen_aq_shoots_down_stairs();
  scripts\engine\utility::flag_set("flag_kitchen_aq_shoots_down_stairs");
}

bar_shootout_enforcer_impulse() {
  wait 2.7;
  var_0 = scripts\engine\utility::getStruct("chair_impulse", "targetname");
  radiusdamage(var_0.origin, 20, 20, 15, undefined, undefined, undefined, 1);
  var_1 = scripts\engine\utility::getStruct("bottle_impulse", "targetname");
  radiusdamage(var_1.origin, 30, 20, 15, undefined, undefined, undefined, 1);
}

bar_pooltable_aq_anim() {
  var_0 = getEnt("pooltable_aq", "targetname");
  var_0.animname = "generic";
  var_0 endon("death");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  var_0.skipdeathanim = 1;
  var_0.orig_health = var_0.health;
  var_0.health = 1;
  var_1 = scripts\engine\utility::getStruct("pooltable_aq_anim_org", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "bar_pooltable_aq");
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var_1 scripts\common\anim::anim_single_solo(var_0, "bar_pooltable_aq");
  var_0.health = var_0.orig_health;
}

bar_right_aq_anim() {
  var_0 = getEnt("bar_right", "targetname");
  var_0.animname = "generic";
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStruct("bar_right_aq", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "bar_right_aq");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var_1 scripts\common\anim::anim_single_solo(var_0, "bar_right_aq");
  var_0 stopanimScripted();
}

bar_back_aq_anim() {
  var_0 = getEnt("bar_back", "targetname");
  var_0.animname = "generic";
  var_0 endon("death");
  var_1 = scripts\engine\utility::getStruct("bar_back_aq", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(var_0, "bar_back_aq");
  var_0 scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var_1 scripts\common\anim::anim_single_solo(var_0, "bar_back_aq");
  var_0 stopanimScripted();
}

kitchen_toggle_containment() {
  scripts\engine\utility::flag_wait("flag_ambusher_blindfire_end");
  scripts\engine\utility::flag_set("flag_start_bar_street_containment");
}

bar_backroom_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("Bar entrance to bar street");
  thread bar_backroom_player_speed_handler();
  thread bar_enforcer_second_handler();
  thread backroom_price_follow_player();
  thread backroom_check_if_player_shoots();
  thread backroom_check_if_player_jumps();
  thread backroom_pre_combat_handler();
  setsaveddvar("NQNQPRLRQM", 0.05);
}

backroom_check_if_player_shoots() {
  level endon("flag_player_exit_back_room");
  level endon("flag_enforcer_flees_backroom");
  level endon("flag_player_blew_backroom_stealth");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("flag_player_shoots_in_backroom");
}

backroom_check_if_player_jumps() {
  level endon("flag_player_exit_back_room");
  level endon("flag_enforcer_flees_backroom");
  level endon("flag_player_blew_backroom_stealth");
  var_0 = getEnt("check_if_player_jumps_trig_1", "targetname");
  var_1 = getEnt("check_if_player_jumps_trig_2", "targetname");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  var_2 = 1;

  while(var_2) {
    if(level.player istouching(var_0) || level.player istouching(var_1)) {
      if(level.player jumpbuttonPressed() || level.player getstance() == "stand") {
        scripts\engine\utility::flag_set("flag_player_jumps_in_backroom");
        var_2 = 0;
        return;
      } else
        waitframe();
    }

    waitframe();
  }
}

back_backroom_player_standing_handler() {
  level endon("flag_player_exit_back_room");
  level endon("flag_player_shoots_in_backroom");
  level endon("flag_player_blew_backroom_stealth");
  level endon("flag_backroom_butcher_convo_over");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_backroom_butcher_convo_half");

  for(;;) {
    if(level.player getstance() == "stand")
      scripts\engine\utility::flag_set("flag_backroom_player_seen_standing");

    wait 0.5;
  }
}

backroom_price_follow_player() {
  level.price scripts\common\utility::demeanor_override("cqb");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  scripts\engine\utility::flag_set("flag_start_bar_backroom_containment");

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes"))
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_price_dont_kill_butcher();

  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes"))
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_butcher_conversation();
}

bar_backroom_player_speed_handler() {
  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    scripts\sp\player::player_movement_state("creep");
    scripts\engine\utility::flag_wait_any("flag_unlock_critical_bar_doors", "flag_player_shoots_in_backroom", "flag_backroom_player_rushes");
  }

  scripts\sp\player::player_movement_state("default");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

bomb_room_spawn_extra_guy() {
  level endon("flag_player_exit_back_room");
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  wait 2.5;
  var_0 = scripts\engine\sp\utility::spawn_targetname("spawner_bomb_room_extra");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = getnode("enemy_bomb_room_back_goal_node", "targetname");
  var_0 getenemyinfo(level.player);
  var_0 scripts\engine\sp\utility::set_goal_radius(16);
  var_0 scripts\engine\sp\utility::set_goal_node(var_1);
  var_0 waittill("goal");
  var_0 scripts\engine\sp\utility::set_goal_radius(400);
  var_0 scripts\engine\sp\utility::set_goal_entity(level.player);
}

bar_price_handler() {
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  thread bar_shootout_price_advance();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_shootout_enemies_cleared();
  level.price scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_wait_any("flag_bar_shootout_enemies_dead", "flag_bar_shootout_player_exit");
  level.price.dontmelee = 0;
  level.price scripts\common\utility::demeanor_override("sprint");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_shootout_move_up_trig", "targetname", "disable");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("push_past_bar_trig", "targetname", "activate");
}

bar_shootout_price_advance() {
  level endon("flag_bar_shootout_enemies_dead");
  level endon("flag_bar_shootout_price_exit");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_high();
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  scripts\engine\sp\utility::activate_trigger_with_targetname("bar_shootout_initial_price_colors");
  childthread trigger_array_wait_then_delete("bar_shootout_price_advance_1", "script_noteworthy");
  childthread trigger_array_wait_then_delete("bar_shootout_price_advance_2", "script_noteworthy");
  childthread trigger_array_wait_then_delete("bar_shootout_price_advance_3", "script_noteworthy");
  childthread trigger_array_wait_then_delete("bar_shootout_price_advance_4", "script_noteworthy");
  thread bar_shootout_price_pain_handler();
}

trigger_array_wait_then_delete(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  if(var_2.size > 0) {
    scripts\engine\utility::waittill_any_ents_array(var_2, "trigger");
    waitframe();
    var_2 = getEntArray(var_0, var_1);

    if(var_2.size > 0)
      scripts\engine\utility::array_delete(var_2);
  }
}

bar_shootout_price_pain_handler() {
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  level.price.dontmelee = 1;
  level.price scripts\engine\utility::disable_pain();
  wait 10;
  level.price scripts\engine\utility::enable_pain();
}

backroom_pre_combat_handler() {
  thread bomb_room_enemies_handler();

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
    var_0 = getEnt("price_stacks_on_bombroom_door_colors", "targetname");
    scripts\engine\sp\utility::autosave_by_name("bar_backroom_enter");
    level.price scripts\engine\sp\utility::enable_dontevershoot();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_enemy_engaged();
    thread bar_backroom_player_kill();
  }

  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  thread bar_shootout_handler();
}

optional_stealth_handler() {
  level.player endon("weapon_fired");
  var_0 = getEnt("price_optional_dialogue_trig", "targetname");

  for(;;) {
    wait 0.2;

    if(level.player istouching(var_0)) {
      break;
    }
  }

  scripts\engine\utility::flag_wait("flag_vo_stp_no_step_hadir_line");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_price_on_your_mark();
}

bar_backroom_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_bomb_room_enemies_dead");
  level endon("flag_bomb_room_enforcer_clear");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer))
    waitframe();

  var_0 = getEnt("player_bar_backroom_kill_trig", "targetname");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");

  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var_1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

bomb_room_enemies_handler() {
  var_0 = getEnt("bar_backroom_nosight_clip", "targetname");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  scripts\engine\sp\utility::array_spawn_function_targetname("spawner_bomb_room", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("backroom_front_enemies", ::bomb_room_front_enemies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("enemy_bomb_room_left", ::bomb_room_enemy_anim_new, "enemy1");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("enemy_bomb_room_right", ::bomb_room_enemy_anim_new, "enemy4");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bomb_room");
  scripts\engine\utility::array_thread(var_1, scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::battlechatter_off("axis");
  var_2 = getEnt("enemy_bomb_room_right", "script_noteworthy");
  var_2 setModel("body_al_qatala_urban_ar_variants");
  var_3 = getEnt("enemy_bomb_room_left", "script_noteworthy");
  var_3 setModel("body_al_qatala_urban_ar_variants_2_1");
  var_4 = getEnt("backroom_front_enemies", "script_noteworthy");
  var_4 setModel("body_al_qatala_urban_lmg_variants_2_1");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_clean_up_last_enemy(var_1, randomfloatrange(4.0, 6.0));
  thread bomb_room_price_advance(var_1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing");
  var_1 = scripts\engine\utility::array_removedead_or_dying(var_1);
  scripts\engine\utility::array_thread(var_1, scripts\engine\sp\utility::set_battlechatter, 1);
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler, 0.5, 1.0, "flag_bomb_room_enforcer_clear", 1.0);

  foreach(var_6 in var_1)
  var_6 scripts\asm\shared\utility::shouldinitiallyattackfromexposed();

  var_0 delete();
  level.player.og_attackeraccuracy = level.player.attackeraccuracy;
  var_8 = scripts\common\utility::getdifficulty();

  if(var_8 == "medium")
    level.player scripts\sp\utility::set_player_attacker_accuracy(1.5);
  else if(var_8 == "hard")
    level.player scripts\sp\utility::set_player_attacker_accuracy(2);
  else if(var_8 == "fu")
    level.player scripts\sp\utility::set_player_attacker_accuracy(3);

  scripts\engine\utility::flag_wait("flag_bomb_room_enemies_dead");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_back_room_enemies_dead();
  scripts\engine\sp\utility::autosave_by_name("bomb_room_enemies_dead");
  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  scripts\engine\utility::trigger_off("trig_price_at_backroom_intro_door", "targetname");
  scripts\engine\utility::trigger_off("price_stacks_on_bombroom_door_colors", "targetname");
}

bomb_room_front_enemies() {
  self endon("death");
  self endon("entitydeleted");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_enemy_low_health();
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  scripts\engine\sp\utility::set_ignoreall(0);
  level notify("cover_blown");
  scripts\engine\sp\utility::set_goal_radius(400);
  scripts\engine\sp\utility::set_goal_ent(level.player);
  self getenemyinfo(level.player);
  scripts\engine\utility::delaycall(0.05, ::aieventlistenerevent, "combat", level.player, level.player.origin);
}

bomb_room_enemy_anim_new(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self.animname = var_0;
  var_1 = scripts\engine\utility::getStruct("backroom_enemies_anim_org", "targetname");
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\sp\utility::disable_danger_react();
  scripts\engine\sp\utility::disable_surprise();
  self.anim_react_skip_stopanimscripted = 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_enemy_low_health();
  self.ignoreme = 1;
  var_1 thread scripts\common\anim::anim_loop_solo(self, "backroom_idle", "startled");
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  var_1 notify("startled");
  self stopanimScripted();
  waitframe();
  self.ignoreme = 0;
  var_1 scripts\common\anim::anim_single_solo(self, "backroom_react");
  scripts\engine\sp\utility::set_goalRadius(400);
  var_2 = getEnt("enemy_bomb_room_mid_goal", "targetname");
  self setgoalvolumeauto(var_2);
  self getenemyinfo(level.player);
  scripts\common\utility::demeanor_override("combat");
  self clearpath();
  self stopanimScripted();
}

bomb_room_set_enemy_model() {
  var_0 = ["body_al_qatala_urban_ar_variants", "body_al_qatala_urban_ar_variants_2_1", "body_al_qatala_urban_lmg"];
  self setModel(scripts\engine\utility::random(var_0));
}

bomb_room_price_advance(var_0) {
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  scripts\sp\player::player_movement_state("default");
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price scripts\common\utility::clear_demeanor_override();
  scripts\engine\sp\utility::activate_trigger_with_targetname("enter_bomb_room");
  level.price scripts\engine\utility::disable_pain();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_average();
  scripts\engine\utility::delaythread(12.0, scripts\engine\utility::flag_set, "flag_bomb_room_price_advance");

  while(var_0.size > 1 && !scripts\engine\utility::flag("flag_bomb_room_price_advance")) {
    var_1 = getEntArray("spawner_bomb_room_extra", "targetname");

    if(isDefined(var_1) && isalive(var_1))
      var_0 = scripts\engine\utility::array_add(var_0, var_1);

    var_0 = scripts\engine\utility::array_remove_duplicates(var_0);
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    wait 0.1;
  }

  level.price scripts\engine\utility::enable_pain();
  scripts\engine\sp\utility::activate_trigger_with_targetname("trig_price_advance_bomb_room");
  thread post_bomb_room_price_anim();
}

post_bomb_room_price_anim() {
  var_0 = scripts\engine\utility::getStruct("post_backroom_anim_org", "targetname");
  scripts\engine\utility::flag_wait("flag_bomb_room_enemies_dead");
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_on();
  scripts\engine\sp\utility::activate_trigger_with_targetname("trig_price_ready_to_leave_room");
}

bar_shootout_main() {
  thread bar_shootout_door_handler();
  thread bar_price_handler();
  thread bar_enforcer_third_handler();
  thread bar_shootout_handler();
}

bar_shootout_special_mb() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_bar_shootout_player_advance");
  level endon("flag_bar_shootout_enemies_dead");
  scripts\engine\utility::flag_wait("flag_bar_shootout_through_door");
  var_0 = getEnt("bar_shootout_player_hide_vol", "targetname");
  var_1 = scripts\engine\utility::getStruct("bar_shootout_mb_source", "targetname");
  var_2 = scripts\engine\utility::getStructArray("bar_shootout_mb_target", "targetname");
  var_3 = getcompleteweaponname("iw8_ar_akilo47");
  var_4 = weaponfiretime(var_3);
  var_5 = weaponclipsize(var_3);

  for(;;) {
    wait 0.1;

    if(bar_shootout_player_hiding()) {
      for(var_6 = 0; var_6 < var_5; var_6++) {
        if(var_2.size > 0)
          var_7 = scripts\engine\sp\utility::get_closest_to_player_view(var_2, level.player, 1);
        else
          return;

        if(bar_shootout_player_hiding()) {
          magicbullet(var_3, var_1.origin, var_7.origin);
          var_2 = scripts\engine\utility::array_remove(var_2, var_7);
        } else
          wait 1.0;

        wait(var_4 * randomfloatrange(1.0, 3.0));
      }

      return;
    }
  }
}

bar_shootout_player_hiding() {
  var_0 = getEnt("bar_shootout_player_hide_vol", "targetname");

  if(level.player istouching(var_0) && level.player getstance() != "stand" && level.player playermount() < 0.5)
    return 1;

  return 0;
}

bar_shootout_exit_alley_door_handler() {
  var_0 = getEnt("bar_alley_exit_door", "targetname");
  var_1 = getEnt("bar_alley_exit_door_clip", "targetname");
  var_2 = getEntArray("alley_junk", "targetname");
  var_3 = getEntArray("alley_junk_clip", "targetname");

  foreach(var_5 in var_2) {
    if(isDefined(var_5))
      var_5 delete();
  }

  var_0 delete();

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 movez(-512, 0.15, 0.05, 0.05);
  }

  var_1 movez(-512, 0.15, 0.05, 0.05);
  wait 0.2;
  var_1 connectpaths();

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 connectpaths();
  }
}

bar_shootout_handler() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_shootout_through_door();
  thread bar_interior_exit_door_handler();
  thread bar_shootout_player_kill();
  thread bar_shootout_exit_alley_door_handler();
  thread bar_shootout_enemies();
  thread bar_street_swap_corpses_with_trash();
  thread bar_shootout_special_mb();
  thread kitchen_toggle_containment();
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_bar_shootout_through_door", 15);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_bar_shootout_player_exit", 35, "flag_enforcer_exit_shootout_door", 1, "flag_bar_shootout_enemies_dead");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_player_exit_club", 30, undefined, 1, "flag_aq_ambusher_dead");
}

bar_shootout_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_shootout_turn_off_player_kill");

  while(!isDefined(level.enforcer))
    waitframe();

  level.enforcer endon("death");
  var_0 = getEnt("player_bar_shootout_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var_1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

bar_shootout_door_handler() {
  var_0 = scripts\sp\door::get_interactive_door("bar_new_entrance_door");
  var_0 scripts\game\sp\door::remove_door_c4_ability();
  var_0.script_max_left_angle = 110;
  var_0.script_max_right_angle = 110;
  var_0 scripts\sp\door::init_max_yaws();
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  var_0 thread bar_shootout_door_close();
  var_0 thread bar_shootout_door_bash_monitor();
  thread bar_shootout_door_sight_trace_monitor();
  scripts\engine\utility::flag_wait_any("flag_bar_shootout_through_door", "flag_bar_shootout_bash_door");
  var_1 = getEnt("bar_shootout_door_clip", "targetname");
  var_1 movez(-256, 0.1, 0.05, 0.05);
  var_1 connectpaths();
  wait 0.2;
  var_1 delete();
}

bar_shootout_door_close() {
  level endon("flag_bar_shootout_through_door");
  level endon("flag_bar_shootout_bash_door");
  scripts\sp\door::door_close(level.enforcer, 1.5, 0.2, 1.0);
  scripts\engine\utility::flag_set("flag_bar_shootout_close_door");
  scripts\sp\door::reset_door();
  scripts\engine\utility::waittill_any("bashed", "open_completely", "first_interact");
  scripts\engine\utility::flag_set("flag_bar_shootout_enter");
}

bar_shootout_door_bash_monitor() {
  level endon("flag_bar_shootout_through_door");
  level endon("flag_bar_shootout_close_door");
  scripts\engine\utility::flag_wait("flag_bar_shootout_bash_door");

  if(level.player issprinting())
    scripts\sp\door::door_bash_open(level.player);
  else
    scripts\sp\utility::door_force_open_fully();

  scripts\engine\utility::flag_set("flag_bar_shootout_enter");
}

bar_shootout_door_sight_trace_monitor() {
  level endon("missionfailed");
  level endon("flag_bar_shootout_enter");
  var_0 = getaiarray("axis");

  for(;;) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

    foreach(var_2 in var_0) {
      var_3 = sighttracepassed(level.player getEye(), var_2 getEye(), 0, undefined);
      var_4 = scripts\engine\sp\utility::within_fov_of_players(var_2 getEye(), cos(45));

      if(var_3 == 1 && var_4 == 1) {
        scripts\engine\utility::flag_set("flag_bar_shootout_enter");
        break;
      }
    }

    waitframe();
  }
}

bar_shootout_enemies() {
  scripts\engine\sp\utility::array_spawn_function_targetname("spawner_bar_retreat_enemies", ::bar_shootout_aq_retreater);
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bar_retreat_enemies", 1);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("spawner_bar_enemies", ::bar_ai_combat_behavior);
  var_1 = scripts\engine\sp\utility::array_spawn_noteworthy("spawner_bar_enemies", 1);
  thread bar_pooltable_aq_anim();
  thread bar_right_aq_anim();
  thread bar_back_aq_anim();
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_shootout_entrance();
  setmusicstate("mx_stpete_tmp_bar_tension");
  level.bar_shootout_aq = scripts\engine\utility::array_combine(var_1, var_0);
  level.bar_shootout_aq = scripts\engine\utility::array_removedead_or_dying(level.bar_shootout_aq);
  scripts\engine\utility::array_thread(level.bar_shootout_aq, scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler, 0.5, 1.0, ["flag_bar_shootout_one_dead", "flag_bar_shootout_player_advance"]);
  thread bar_shootout_ai_dead_check();
  thread bar_shootout_retreat_enemy_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_clean_up_last_enemy(level.bar_shootout_aq, randomfloatrange(8.0, 10.0));
  waitframe();
  scripts\engine\utility::waittill_any_ents_array(level.bar_shootout_aq, "death");
  scripts\engine\utility::flag_set("flag_bar_shootout_one_dead");
  scripts\engine\utility::flag_wait("flag_player_exit_club");
  level.bar_shootout_aq = scripts\engine\utility::array_removedead_or_dying(level.bar_shootout_aq);
  scripts\engine\utility::array_delete(level.bar_shootout_aq);
}

bar_shootout_ai_dead_check() {
  level endon("flag_player_exit_club");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::waittill_alive_count(level.bar_shootout_aq, 2);
  scripts\engine\utility::flag_set("flag_bar_shootout_some_enemies_dead");
}

bar_ai_combat_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("bar_mid_goal", "targetname");
  scripts\engine\utility::set_movement_speed(180);
  scripts\engine\sp\utility::set_goalRadius(16);
  scripts\engine\sp\utility::enable_dontevershoot();
  scripts\engine\sp\utility::set_battlechatter(1);
  self.no_pistol_switch = 1;
  self.sidearm = isundefinedweapon();
  self.sidearm = "none";
  thread bar_shootout_enemy_shot_earlier();
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  self._blackboard.shouldinitiallyattackfromexposed = 1;
  self._blackboard.shouldinitiallyattackfromexposedtime = gettime() + 10000;
  scripts\engine\utility::delaythread(2.3, scripts\engine\sp\utility::disable_dontevershoot);

  if(isDefined(self.target))
    scripts\engine\utility::waittill_any("goal", "damage", "whizby");

  if(isDefined(self.script_goalvolume)) {
    self setgoalvolumeauto(var_0);
    scripts\engine\sp\utility::trigger_wait_targetname("enforcer_exit_to_alley_trig");

    if(isalive(self)) {
      self.diequietly = 1;
      scripts\engine\sp\utility::die();
    }
  }
}

bar_shootout_enemy_shot_earlier() {
  level endon("missionfailed");
  level endon("flag_bar_shootout_enter");
  scripts\engine\utility::waittill_any("damage", "whizby", "death");
  scripts\engine\utility::flag_set("flag_shootout_enemies_shot_early");
}

bar_shootout_aq_regular() {
  self endon("death");
  self endon("entitydeleted");
  self endon("fallback");
  scripts\engine\sp\utility::set_pacifist(1);
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\common\utility::demeanor_override("sprint");
  self.baseaccuracy = 0.3;
  self waittill("reached_path_end");
  scripts\common\utility::clear_demeanor_override();
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  scripts\engine\sp\utility::set_pacifist(0);
}

bar_shootout_aq_retreater() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_pacifist(1);
  scripts\engine\sp\utility::set_goal_radius(64);
  scripts\common\utility::demeanor_override("sprint");
  self.dontmeleeme = 1;
  self.dontmelee = 1;
  thread bar_shootout_enemy_shot_earlier();
  scripts\engine\sp\utility::trigger_wait_targetname("enforcer_exit_to_alley_trig");

  if(isalive(self)) {
    self.diequietly = 1;
    self kill();
  }
}

bar_shootout_retreat_enemy_handler() {
  scripts\engine\utility::flag_wait("flag_enforcer_exit_shootout_door");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("spawner_bar_retreat_enemies", "targetname");

  foreach(var_2 in var_0)
  var_2 thread bar_shootout_send_retreater_to_goal(1);

  scripts\engine\utility::flag_wait_any("flag_bar_shootout_some_enemies_dead", "flag_bar_shootout_player_advance");
  var_4 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bar_reinforce_enemies", 1);
  level.bar_shootout_aq = scripts\engine\utility::array_combine(level.bar_shootout_aq, var_4);
}

bar_shootout_send_retreater_to_goal(var_0) {
  self endon("death");
  self endon("entitydeleted");
  var_1 = getnode("node_enforcer_club_exited", "targetname");
  var_2 = getnode("bar_kitchen_doorway_node", "targetname");
  wait 1.0;

  if(var_0 == 0) {
    scripts\engine\sp\utility::set_goal_node(var_1);
    scripts\engine\sp\utility::set_goalRadius(16);
    scripts\engine\utility::disable_pain();
    scripts\engine\sp\utility::set_ignoreme(1);
    scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\sp\utility::set_pacifist(1);
    waitframe();
    self waittill("goal");
    var_3 = 0;
    var_3 = sighttracepassed(level.player getEye(), self getEye(), 0, undefined);

    if(var_3 == 1) {
      scripts\engine\utility::enable_pain();
      scripts\engine\sp\utility::set_ignoreme(0);
      scripts\engine\sp\utility::set_ignoreall(0);
      scripts\engine\sp\utility::set_pacifist(0);
      scripts\engine\sp\utility::set_goal_pos(self.origin);
      return;
    }

    self delete();
    return;
  } else {
    self.combatmode = "ambush";
    scripts\engine\sp\utility::set_pacifist(0);
    scripts\engine\sp\utility::set_goalRadius(32);
    self setgoalvolumeauto(getEnt("last_guy_goal", "targetname"));
    self getenemyinfo(level.player);
  }
}

bar_shootout_aq_fallback() {
  self endon("death");
  self endon("death");
  var_0 = getEnt("bar_back_goal", "targetname");
  var_1 = scripts\engine\utility::getStruct("bar_shootout_fallback_org", "targetname");
  self notify("fallback");
  self cleargoalvolume();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\sp\utility::set_goal_pos(var_1.origin);
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_enemy_low_health();
}

kitchen_aq_shoots_down_stairs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_shootout_approaching_kitchen();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("aq_ambusher", ::kitchen_aq_ambusher_fallback);
  var_0 = scripts\engine\sp\utility::spawn_script_noteworthy("aq_ambusher", 1);
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0 scripts\engine\sp\utility::disable_long_death();
  var_0 scripts\engine\sp\utility::set_battlechatter(1);
  var_0.script_ammo_clip = 100;
  var_0.script_ammo_extra = 100;
  level.price scripts\engine\utility::disable_pain();
  scripts\engine\utility::flag_wait_any("flag_price_triggers_ambusher_blindfire", "flag_ambusher_blindfire_start");
  var_1 = scripts\sp\utility::make_weapon("iw8_sm_papa90", ["holo_west01"]);
  var_0 scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
  var_0 thread kitchen_aq_ambusher_magicbullet();
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_set_accuracy_average();
  scripts\engine\utility::flag_wait("flag_kitchen_aq_shoots_down_stairs");

  if(isalive(var_0)) {
    var_0.ignoreall = 0;
    var_0.ignoreme = 0;
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_shootout_kitchen_clear();
  scripts\engine\sp\utility::wait_for_flag_or_timeout("flag_aq_ambusher_dead", 6);
  scripts\engine\sp\utility::activate_trigger_with_targetname("move_price_up_bar_backstairs_trig");
  thread bar_street_main();
}

kitchen_aq_ambusher_magicbullet() {
  self endon("death");
  level endon("flag_ambusher_blindfire_end");
  var_0 = scripts\engine\utility::getStruct("ambusher_magicbullet_start", "targetname");
  var_1 = [];
  var_1[0] = scripts\engine\utility::getStruct("ambusher_magicbullet_end_1", "targetname");
  var_1[1] = scripts\engine\utility::getStruct("ambusher_magicbullet_end_2", "targetname");
  var_1[2] = scripts\engine\utility::getStruct("ambusher_magicbullet_end_3", "targetname");
  var_1[3] = scripts\engine\utility::getStruct("ambusher_magicbullet_end_4", "targetname");
  var_2 = getcompleteweaponname("iw8_sm_papa90");
  var_3 = weaponfiretime(var_2);
  var_4 = weaponclipsize(var_2);
  var_5 = scripts\engine\utility::spawn_script_origin(var_1[0].origin, var_1[0].angles);

  while(!scripts\engine\utility::flag("flag_ambusher_blindfire_end")) {
    var_6 = scripts\engine\utility::random(var_1);
    var_5 moveTo(var_6.origin, 1.0, 0.05, 0.05);

    for(var_7 = 0; var_7 < var_4; var_7++) {
      var_8 = scripts\engine\utility::random(var_1);
      magicbullet(var_2, var_0.origin, var_8.origin + scripts\engine\utility::randomvectorrange(0, 5));
      wait(var_3);
    }

    wait(randomfloatrange(0.5, 1.0));
  }
}

kitchen_aq_ambusher_fallback() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("flag_bar_price_at_stairs", "flag_kitchen_aq_shoots_down_stairs");
  scripts\engine\sp\utility::wait_for_flag_or_timeout("flag_aq_ambusher_dead", 4);
  var_0 = getnode("ambusher_fallback", "targetname");
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\engine\sp\utility::set_goal_node(var_0);
  scripts\engine\utility::disable_pain();
  self waittill("goal");
  scripts\engine\utility::enable_pain();
}

bar_street_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::transient_waittill("flag_bar_street_enter", "stpetersburg_alley_script_tr", "stpetersburg_apartment_script_tr");
  scripts\engine\utility::exploder("pool_fx");
  thread scripts\sp\analytics::analytics_kleenex_update("Bar street to canal");
  thread bar_street_price_intro_gopath();
  thread bar_street_dead_bodies();
  thread bar_street_turn_car_alarms_off();
  thread bar_street_timer_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_street_civilians();
  thread bar_street_combat_handler();
  thread bar_street_fleeing_civs_vignettes();
  thread bar_street_enforcer_flee();
  thread bar_street_player_kill();
  thread bar_street_swap_corpses_with_trash();
  scripts\engine\utility::flag_wait_any("flag_bar_street_aq_all_dead", "flag_bar_street_player_near_apt");
  scripts\engine\utility::flag_set("flag_bar_street_end");
}

bar_street_swap_corpses_with_trash() {
  if(scripts\engine\utility::flag("flag_bar_street_alley_corpses_bagged")) {
    return;
  }
  scripts\engine\utility::flag_set("flag_bar_street_alley_corpses_bagged");
  var_0 = getEnt("alley_stealth_trash_bag_clip", "targetname");
  var_1 = getEntArray("alley_stealth_trash_bag", "targetname");
  var_0 movez(256, 0.1, 0.05, 0.05);
  var_0 disconnectPaths();

  foreach(var_3 in var_1)
  var_3 thread bar_street_garbage_bag_place();
}

bar_street_garbage_bag_place() {
  self endon("entitydeleted");
  self movez(256, 0.2, 0.05, 0.05);
  wait 0.3;
  playFX(scripts\engine\utility::getfx("vfx_stpburg_blood_pool"), self.origin);
  self.health = 999999;
  self setCanDamage(1);
  thread bar_street_garbage_bag_blood();
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_stairs_vignette");
  self delete();
}

bar_street_garbage_bag_blood() {
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_apartment_enforcer_stairs_vignette")) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(scripts\engine\utility::cointoss())
      playFX(scripts\engine\utility::getfx("vfx_blood_hit_01"), var_3, var_2 + scripts\engine\utility::randomvectorrange(0, 20));
    else
      playFX(scripts\engine\utility::getfx("vfx_bd_blood_hit_01"), var_3, var_2 + scripts\engine\utility::randomvectorrange(0, 20));

    playFX(scripts\engine\utility::getfx("vfx_stpburg_blood_splat_light"), var_3, var_2 + scripts\engine\utility::randomvectorrange(0, 20));
    wait 0.1;
  }
}

bar_street_dead_bodies() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_dead_bodies("bar_street_dead_bodies", "flag_apartment_grenade_explosion");
}

bar_street_extra_car() {
  var_0 = scripts\common\vehicle::spawn_vehicles_from_targetname("bar_street_extra_car");
  waitframe();

  foreach(var_2 in var_0) {
    var_2.dontdisconnectpaths = 1;
    var_2.script_badplace = 1;
    var_2 scripts\common\vehicle_code::vehicle_remove_badplace();

    if(var_2.classname == "script_vehicle_iw8_car_civilian_skilo_blue") {
      var_2.animname = "skilo";
      var_2 scripts\common\anim::anim_last_frame_solo(var_2, "fr_door_open");
      continue;
    }

    if(var_2.classname == "script_vehicle_iw8_decho_green") {
      var_2.animname = "decho";
      var_2 scripts\common\anim::anim_last_frame_solo(var_2, "fl_door_open");
    }
  }
}

bar_street_turn_car_alarms_off() {
  var_0 = getscriptablearray("street_no_alarm_vehicles", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("car_alarm", "off");
}

bar_street_enforcer_spawn() {
  level.enforcer endon("death");
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::spawn_enforcer("node_enforcer_alley");
  level.enforcer scripts\engine\utility::disable_pain();
  level.enforcer scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  level.price scripts\common\utility::demeanor_override("sprint");
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer.ignoreall = 0;
  level.enforcer.ignoreme = 0;
}

bar_street_timer_handler() {
  level endon("flag_bar_street_end");
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_street_wheres_enforcer();
  setmusicstate("mx_stpete_tmp_bar_street_chase");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_bar_street_player_at_corner", 20, undefined, 0);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_in_apt");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pursuit_timer("flag_bar_street_player_near_apt", 35, undefined, 0);
}

bar_street_fleeing_civs_vignettes() {
  scripts\engine\utility::flag_wait_any("flag_enforcer_run_into_alley", "flag_player_near_exit_club");
  thread street_couple_vig();
  thread street_backshot_vig();
  thread street_civ_run_cower_vig();
  thread street_civ_run_cower_handler();
  thread street_civ_mag_bullet();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_civ_flee", 1);

  foreach(var_2 in var_0)
  var_2 scripts\asm\asm_bb::bb_setcivilianstate("panic");

  wait 3.5;
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0) {
    var_2 kill();
    wait 0.1;
  }
}

street_civ_run_cower_handler() {
  level endon("flag_apartment_end");
  level endon("entitydeleted");
  level endon("death");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bar_street_civ_cower_04", ::street_civ_cower_04_behavior);
  scripts\engine\sp\utility::array_spawn_targetname("bar_street_civ_cower", 1);
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  var_0 = scripts\engine\sp\utility::get_living_ai_array("bar_street_civ_cower", "targetname");
  scripts\engine\utility::array_delete(var_0);
}

street_civ_cower_01_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("bar_street_civ_cower_01_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait(randomfloatrange(0.2, 1.0));
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var_0 notify("ender");
}

street_civ_cower_02_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("bar_street_civ_cower_02_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait(randomfloatrange(0.2, 1.0));
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower_alt", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var_0 notify("ender");
}

street_civ_cower_03_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("bar_street_civ_cower_03_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait(randomfloatrange(0.2, 1.0));
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var_0 notify("ender");
}

street_civ_cower_04_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("bar_street_civ_cower_04_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 3;
  wait(randomfloatrange(0.2, 1.0));
  var_0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower_alt2", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var_0 notify("ender");
}

street_civ_run_cower_vig() {
  var_0 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("streetciv_gate", 1);
  var_1.animname = "civ03";
  var_1 endon("entitydeleted");
  var_1 endon("death");
  var_1 setModel("body_civ_london_female_8_1");
  var_1 scripts\engine\utility::delaythread(4, scripts\engine\sp\utility::set_allowdeath, 1);
  var_0 scripts\common\anim::anim_single_solo(var_1, "bar_street_flee");
  var_1.civ_ff_idle = 1;
  var_0 thread scripts\common\anim::anim_loop_solo(var_1, "bar_street_flee_idle");
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");

  if(isDefined(var_1))
    var_1 delete();
}

street_backshot_vig() {
  var_0 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("streetciv_run", 1);
  var_1 scripts\engine\utility::delaythread(4, scripts\engine\sp\utility::set_allowdeath, 1);
  var_1.animname = "streetciv01";
  wait 0.1;
  var_0 scripts\common\anim::anim_single_solo(var_1, "stp_bar_street_run");
  var_0 scripts\common\anim::anim_last_frame_solo(var_1, "stp_bar_street_run");
  waitframe();
  var_1.forceragdollimmediate = 1;
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();
  var_1 scripts\engine\sp\utility::set_allowdeath(1);
  var_1.skipdeathanim = 1;
  var_1 scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");

  if(isDefined(var_1))
    var_1 delete();
}

street_couple_vig() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("streetcivcouple_civ01", 1);
  var_0 setModel("body_civ_stpeterburg_male_4_1");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0.allowdeath = 1;
  var_0.animname = "streetcouplemale";
  var_1 = scripts\engine\sp\utility::spawn_targetname("streetcivcouple_civ02", 1);
  var_1 setModel("body_civ_stpeterburg_female_1_1");
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1.allowdeath = 1;
  var_1.animname = "streetcouplefemale";
  var_2 = scripts\engine\utility::getStruct("streetciv_struct02", "targetname");
  var_3 = [var_0, var_1];
  var_2 scripts\common\anim::anim_single(var_3, "stp_bar_street_couple_run");
  var_0.civ_ff_idle = 1;
  var_1.civ_ff_idle = 1;
  var_2 thread scripts\common\anim::anim_loop(var_3, "stp_bar_street_couple_idle");
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");
  scripts\engine\utility::array_delete(var_3);
}

street_civs_flee(var_0, var_1, var_2, var_3, var_4) {
  wait(var_4);
  var_5 = scripts\engine\sp\utility::spawn_targetname(var_0, 1);
  var_5.animname = var_2;
  var_1 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_1 scripts\common\anim::anim_single_solo(var_5, "bar_street_flee", undefined, var_3);
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), var_5, "j_head");
  waitframe();
  var_5 kill();
}

street_death_civ_vig() {
  scripts\engine\sp\utility::wait_for_targetname_trigger("streetciv_trigger2");
  var_0 = scripts\engine\sp\utility::spawn_targetname("streetciv_dead", 1);
  var_0.animname = "streetcivdead";
  var_1 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var_1 scripts\common\anim::anim_single_solo(var_0, "stp_bar_street_shot");
  var_1 scripts\common\anim::anim_last_frame_solo(var_0, "stp_bar_street_shot");
  var_0 visiblenotsolid();
}

bar_street_combat_handler() {
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  thread bar_street_mag_bullet();
  level.player scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::array_spawn_function_targetname("bar_street_aq", ::bar_street_ai_combat_behavior);
  scripts\engine\sp\utility::array_spawn_function_targetname("bar_street_aq", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::setup_enemy_for_price_clean_up);
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_aq");
  thread bar_street_aq_handler(var_0);
  thread bar_street_price_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_clean_up_last_enemy(var_0, randomfloatrange(10.0, 15.0));
  scripts\engine\utility::flag_wait("flag_bar_street_player_at_corner");
  scripts\engine\utility::flag_wait_or_timeout("flag_bar_street_around_corner", 3.0);
  level.player scripts\engine\sp\utility::set_ignoreme(0);
}

bar_street_ai_combat_behavior() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_street_combat_behavior");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::set_attackeraccuracy_handler(0.5, 1.0, ["flag_bar_street_enforcer_to_apt", "flag_bar_street_around_corner"]);
  scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\sp\utility::set_battlechatter(1);

  if(isDefined(self.target))
    self waittill("goal");

  scripts\engine\sp\utility::set_goalRadius(800);
  scripts\engine\sp\utility::set_goal_entity(level.player);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_to_apt");
  wait(randomfloatrange(5, 8));

  if(scripts\engine\utility::cointoss())
    self.favoriteenemy = level.player;

  wait(randomfloatrange(8, 12));
  scripts\engine\sp\utility::set_goalRadius(500);

  while(self.goalradius > 100) {
    wait(randomfloatrange(2, 5));
    self.goalradius = self.goalradius - 100;
  }
}

bar_street_aq_handler(var_0) {
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  thread bar_street_aq_door_extra();
  thread bar_street_aq_door(var_0);
  thread bar_street_aq_hangback();
  thread bar_street_aq_death_check(var_0);
}

bar_street_aq_death_check(var_0) {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::waittill_alive_count(var_0, 2);
  scripts\engine\utility::flag_set("flag_bar_street_aq_some_dead");
}

bar_street_aq_door(var_0) {
  var_1 = getEnt("bar_street_enemy_back_vol", "targetname");
  var_2 = undefined;

  while(!isDefined(var_2)) {
    var_2 = getEnt("bar_street_aq_door", "script_noteworthy");
    waitframe();
  }

  var_2 scripts\engine\sp\utility::set_goalRadius(16);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_to_apt");

  if(isDefined(var_2)) {
    var_2 endon("death");
    var_2 endon("entitydeleted");
    var_2 scripts\engine\sp\utility::set_goal_pos(var_2.origin);
    var_2 notify("stop_street_combat_behavior");
    wait 2.0;
    var_2 scripts\common\utility::demeanor_override("sprint");
    var_2 setgoalvolumeauto(var_1);
    wait(randomfloatrange(2, 5));
  }

  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  var_2 delete();
}

bar_street_aq_hangback() {
  var_0 = getEnt("bar_street_enemy_hangback_vol", "targetname");
  var_1 = undefined;

  while(!isDefined(var_1)) {
    var_1 = getEnt("bar_street_aq_hangback", "script_noteworthy");
    waitframe();
  }

  var_1.animname = "generic";
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 scripts\engine\sp\utility::set_ignoreme(1);
  var_2 = scripts\engine\utility::getStruct("bar_street_aq_car_climb_org", "targetname");
  var_3 = getanimlength(var_1 scripts\engine\utility::getanim("traverse_stepup_52"));
  var_3 = 2.5;
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_2 scripts\sp\anim::anim_reach_solo(var_1, "traverse_stepup_52");

  if(!scripts\engine\utility::flag("flag_bar_street_player_near_apt")) {
    var_1 scripts\engine\sp\utility::set_allowdeath(1);
    var_1.skipdeathanim = 1;
    var_2 thread scripts\common\anim::anim_single_solo(var_1, "traverse_stepup_52");
    wait(var_3);
    var_1 scripts\engine\sp\utility::anim_stopanimScripted();
    var_4 = getnode("bar_street_aq_car_climb_node", "targetname");
    var_1 scripts\engine\sp\utility::set_goal_node(var_4);
    var_1 waittill("goal");
    var_1.skipdeathanim = undefined;
    var_5 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
    var_1 linkTo(var_5);
    scripts\engine\utility::flag_wait_any_timeout(5.0, "flag_bar_street_player_near_apt", "flag_bar_street_aq_some_dead");
    wait(randomfloatrange(2, 5));
    var_1 scripts\engine\sp\utility::set_ignoreme(0);
  }

  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  var_1 delete();
}

bar_street_aq_door_extra() {
  scripts\engine\utility::flag_wait_any("flag_bar_street_player_advance", "flag_bar_street_aq_some_dead");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_aq_extra");
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  scripts\engine\utility::array_delete(var_0);
}

bar_street_price_intro_gopath() {
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  scripts\engine\sp\utility::trigger_wait_targetname("price_street_runto_start");
  level.price scripts\engine\sp\utility::disable_ai_color();
  level.price scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("price_street_intro_runto", "targetname"));
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  level.price scripts\engine\sp\utility::enable_ai_color();
}

bar_street_price_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::price_push_off();
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price.ignoreall = 1;
  bar_street_price_wait();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price.ignoreall = 0;
  level.price scripts\engine\utility::enable_pain();
  thread bar_street_price_advance();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_street_enemies_cleared();
  level.price scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_wait_any("flag_bar_street_aq_all_dead", "flag_bar_street_player_near_apt");
  level.price.dontmelee = 0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::trigger_safe_function("bar_street_triggers", "script_noteworthy", "disable");
}

bar_street_price_wait() {
  level endon("flag_bar_street_player_near_apt");
  level.price endon("goal");

  for(;;)
    waitframe();
}

bar_street_price_advance() {
  level endon("flag_bar_street_end");
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  childthread trigger_array_wait_then_delete("bar_street_price_advance_1", "targetname");
  childthread trigger_array_wait_then_delete("bar_street_price_advance_2", "targetname");
  childthread trigger_array_wait_then_delete("bar_street_price_advance_3", "targetname");
}

street_civ_mag_bullet() {
  level endon("flag_bar_street_enter");
  level endon("flag_bar_street_price_at_corner");
  scripts\engine\sp\utility::wait_for_targetname_trigger("streetciv_trigger");
  var_0 = scripts\engine\utility::getStruct("street_civ_magicbullet_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("street_civ_magicbullet_end", "targetname");
  var_2 = getcompleteweaponname("iw8_ar_akilo47");
  var_3 = weaponfiretime(var_2);
  var_4 = weaponclipsize(var_2);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    magicbullet(var_2, var_0.origin, var_1.origin + scripts\engine\utility::randomvectorrange(0, 20));
    wait(var_3 * randomfloatrange(1.0, 3.0));
  }
}

bar_street_mag_bullet() {
  level endon("flag_bar_street_player_at_corner");
  level endon("flag_bar_street_price_at_corner");
  scripts\engine\sp\utility::wait_for_targetname_trigger("price_moves_out_to_bar_street_colors");
  var_0 = scripts\engine\utility::getStruct("street_pursuit_magicbullet_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("street_pursuit_magicbullet_end", "targetname");
  var_2 = getcompleteweaponname("iw8_ar_akilo47");
  var_3 = weaponfiretime(var_2);
  var_4 = weaponclipsize(var_2);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    magicbullet(var_2, var_0.origin, var_1.origin + scripts\engine\utility::randomvectorrange(0, 20));
    wait(var_3 * randomfloatrange(1.0, 3.0));
  }
}

bar_street_enforcer_flee() {
  level.enforcer endon("death");
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.enforcer scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
  var_1 = scripts\engine\utility::getStruct("bar_street_enforcer_run_org", "targetname");
  var_1 scripts\common\anim::anim_first_frame_solo(level.enforcer, "bar_street_run_3");
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enforcer_safe_run();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer endon("death");
  level.enforcer scripts\engine\sp\utility::set_ignoreall(1);
  level.enforcer scripts\engine\sp\utility::enable_dontevershoot();
  var_2 = 0;

  while(var_2 == 0 && !scripts\engine\utility::flag("flag_bar_street_player_at_corner")) {
    var_2 = sighttracepassed(level.player gettagorigin("j_gun"), level.enforcer getEye(), 0, undefined);
    waitframe();
  }

  var_1 thread scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_3");
  wait 1.0;
  scripts\engine\utility::flag_set("flag_bar_street_enforcer_to_apt");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_bar_street_enforcer_flee();
  var_3 = scripts\engine\utility::getStruct("struct_enforcer_bar_street_to_apartment", "targetname");
  level.enforcer scripts\sp\spawner::go_to_node(var_3);
  var_4 = getnode("apartment_stairs_blindfire_position", "targetname");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var_4);
  scripts\engine\utility::flag_set("flag_bar_street_enforcer_in_apt");
}

bar_street_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_bar_street_enforcer_in_apt");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer))
    waitframe();

  var_0 = getEnt("player_bar_street_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      var_1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var_1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

bar_street_enforcer_mb() {
  level.enforcer endon("death");
  level.enforcer endon("stop_shooting");
  var_0 = getanimlength(level.enforcer scripts\engine\utility::getanim("bar_street_run_2"));
  level.enforcer thread scripts\engine\sp\utility::notify_delay("stop_shooting", var_0);
  wait 0.1;
  var_1 = getcompleteweaponname("iw8_ar_akilo47");
  var_2 = weaponfiretime(var_1);
  var_3 = weaponclipsize(var_1);
  var_4 = level.enforcer gettagorigin(getweaponflashtagname(var_1));
  var_5 = level.enforcer gettagangles(getweaponflashtagname(var_1));
  var_6 = var_4 + anglesToForward(var_5) * 100;

  for(var_7 = 0; var_7 < var_3; var_7++) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), level.enforcer, getweaponflashtagname(var_1));
    magicbullet("iw8_ar_akilo47", var_4, var_6 + scripts\engine\utility::randomvectorrange(0, 5), level.enforcer);
    wait(var_2 * 2);
  }
}

move_enforcer_fake_target() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var_0 = randomfloatrange(2.0, 4.0);
    self movez(64, var_0);
    wait(var_0);
    var_1 = randomfloatrange(2.0, 6.0);
    self movez(-64, var_1);
    wait(var_1);
  }
}

alley_stealth_price_takedown_fire() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  level.price scripts\common\ai::gun_recall();
  wait 0.8;
  var_0 = getcompleteweaponname("iw8_pi_golf21", ["silencerpstl_west01"]);

  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = level.price gettagorigin(getweaponflashtagname(var_0));
    var_3 = level.price gettagangles(getweaponflashtagname(var_0));
    var_4 = var_2 + anglesToForward(var_3) * 100;
    magicbullet(var_0, var_2, var_4, level.price);
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), level.price, getweaponflashtagname(var_0));
    wait 0.2;
  }

  wait 0.8;
  var_2 = level.price gettagorigin(getweaponflashtagname(var_0));
  var_3 = level.price gettagangles(getweaponflashtagname(var_0));
  var_4 = var_2 + anglesToForward(var_3) * 100;
  magicbullet(var_0, var_2, var_4, level.price);
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), level.price, getweaponflashtagname(var_0));
}

intro_scene_camera() {
  level endon("stop_intro_end");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\sp\maps\stpetersburg\stpetersburg_lighting.gsc::flycam_intro_start();
  thread intro_scene_bink();
  thread intro_scene_fake_player();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::put_player_into_cam_rig(level.player.rig, 0.25, 0, 0, 0, 0);
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_camera_in_apartment", 6.0);
  scripts\sp\hud_util::start_overlay();
  scripts\engine\utility::delaythread(0.5, scripts\sp\hud_util::fade_in, 0.5);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player lerpfovscalefactor(0, 0);
  level.player lerpfov(45.48, 0.001);
  var_0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var_0 scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_intro");
  var_0 scripts\common\anim::anim_last_frame_solo(level.player.rig, "new_camera_intro");
  level.player unlink();
  var_1 = level.player.rig scripts\engine\utility::getanim("new_camera_window");
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  level.player setOrigin(var_2);
  level.player setplayerangles(var_3);
  var_0 scripts\common\anim::anim_first_frame_solo(level.player.rig, "new_camera_window");
  level.player playerlinktoabsolute(level.player.rig, "tag_player");
  var_0 notify("stop_first_frame");
  level.player lerpfov(50, 0.001);
  var_0 scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_window");
  thread intro_scene_end(0);
}

intro_scene_end(var_0) {
  level notify("stop_intro_end");
  level endon("stop_intro_end");

  if(var_0) {
    level.player lerpfov(65.0, 0.1);
    scripts\engine\utility::flag_set("intro_bink_done");
    scripts\engine\utility::flag_set("flag_stakeout_camera_finished");
    var_1 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
    var_1 thread scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_window");
    level.player.rig setanimtime(level.player.rig scripts\engine\utility::getanim("new_camera_window"), 0.8);
    level.player.rig waittillmatch("single anim", "end");
  }

  scripts\engine\utility::flag_wait("flag_stakeout_fake_player_deleted");
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  level.player scripts\common\utility::allow_cinematic_motion(1);
  level.player lerpfovscalefactor(1, 1.5);
  level notify("slam_zoom_complete");
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::flag_set("flag_stakeout_camera_finished");
  level.price scripts\engine\utility::delaythread(1.0, scripts\engine\sp\utility::name_show);
  level.nikolai scripts\engine\utility::delaythread(1.0, scripts\engine\sp\utility::name_show);
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_start");
}

fovshift(var_0) {
  wait(var_0);
  level.player lerpfov(65, 3);
}

intro_scene_bink() {
  thread cine_letterboxing();
  scripts\engine\utility::flag_set("flag_bink_active");
  wait 0.5;

  if(!iscinematicplaying()) {
    setsaveddvar("MMRNLMPPLT", "1");
    setsaveddvar("RKMNLRNS", "1");
  }

  level.player cleardamageindicators();
  level.player enableplayerbreathsystem(0);
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  wait 2.0;

  if(!iscinematicplaying())
    cinematicingame("sp_st_petersburg_title");

  scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
  stopcinematicingame();
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::flag_clear("flag_bink_active");
  level.player enableplayerbreathsystem(1);
  setomnvar("ui_hide_hud", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
}

cine_letterboxing() {
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

alley_stealth_aq_create_badplace_in_combat() {
  level endon("flag_alley_stealth_aq_dead");
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    var_0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby");

    switch (var_0) {
      case "damage":
        var_1 = 64;
        var_2 = 6.0;
        break;
      case "bulletwhizby":
        var_1 = 32;
        var_2 = 4.0;
        break;
      default:
        var_1 = 48;
        var_2 = 2.0;
    }

    badplace_cylinder("", var_2, self.origin, var_1, var_1, "axis");
    wait(randomfloatrange(3.0, 5.0));
  }
}

alley_stealth_aq_create_badplace_on_death() {
  self endon("entitydeleted");
  self waittill("death");
  var_0 = 96;
  var_1 = 4.0;
  badplace_cylinder("", var_1, self.origin, var_0, var_0, "axis");
}

player_weapon_holstered_door_bash_monitor() {
  level endon("flag_enforcer_flees_backroom");

  for(;;) {
    if(!istrue(self.bashed) && scripts\sp\door::bash_door_isplayerclose() && level.player meleeButtonPressed() && level.player getcurrentweapon().basename == "iw8_holstered") {
      scripts\sp\door::door_bash_open();
      return;
    }

    waitframe();
  }
}

bar_alley_entrance_door_interacted() {
  level endon("flag_enforcer_flees_backroom");
  self waittill("trigger");
  scripts\engine\utility::flag_set("flag_bar_alley_entrance_door_opened");
}