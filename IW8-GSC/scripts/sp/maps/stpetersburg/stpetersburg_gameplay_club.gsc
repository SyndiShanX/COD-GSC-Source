/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_gameplay_club.gsc
***********************************************************************/

function bar_init() {
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

function intro_stakeout_main() {
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
  thread scripts\sp\maps\stpetersburg\stpetersburg_vig_script_street_intro::vig_street_intro_start();
  thread intro_stakeout_wait_swap_butcher_vehicle();
  thread alley_stealth_bar_entrance_door_handler();
}

function intro_scene_fake_player() {
  level.fake_player = scripts\engine\sp\utility::spawn_targetname("stakeout_fake_player", 1);
  level.fake_player.name = "Kyle";
  level.fake_player.animname = "fake_player";
  level.fake_player.script_friendname = "Kyle";
  level.fake_player visiblenotsolid();
  level.fake_player scripts\engine\sp\utility::name_hide();
  thread intro_scene_end_skip();
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var0 scripts\common\anim::anim_single_solo(level.fake_player, "intro_scene");
  level.player scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::smart_player_dialogue_interrupt, "dx_vom_kyle_stakeout_gear_40");

  if(isDefined(level.fake_player)) {
    level.fake_player delete();
  }

  scripts\engine\utility::flag_set("flag_stakeout_fake_player_deleted");
}

function intro_scene_end_skip() {
  var0 = getanimlength(scripts\engine\utility::getanim("intro_scene"));
  wait var0 - 5.5;
  scripts\sp\utility::userskip_stop();
}

function intro_stakeout_player_movement() {
  level.player allowfire(0);
  scripts\sp\player::player_movement_state("creep");
  setsaveddvar("MNPNORMOMP", 0.65);

  if(getdvarint("stp_intro_cinematic") > 0) {
    scripts\engine\sp\utility::player_speed_set(10, 0.5);
    scripts\engine\utility::flag_wait("flag_stakeout_fake_player_deleted");
  }

  scripts\engine\sp\utility::player_speed_set(60, 2);
  scripts\engine\utility::flag_wait("flag_stakeout_player_has_weapon");
  level.player allowfire(1);
  thread intro_stakeout_player_muzzle_discipline();
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_1");
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_stairs");
  level.player allowjump(1);
}

function intro_stakeout_player_muzzle_discipline() {
  level endon("missionfailed");
  level.player endon("death");

  while(!scripts\engine\utility::flag("flag_alley_stealth_price_opening_door")) {
    var0 = 1;
    var1 = 1;

    if(distance2dsquared(level.player.origin, level.price.origin) < squared(128)) {
      if(scripts\engine\sp\utility::within_fov_of_players(level.price getEye(), cos(45))) {
        var0 = 0;
      }
    }

    if(isDefined(level.nikolai)) {
      if(distance2dsquared(level.player.origin, level.nikolai.origin) < squared(128)) {
        if(scripts\engine\sp\utility::within_fov_of_players(level.nikolai getEye(), cos(45))) {
          var1 = 0;
        }
      }
    }

    if(var0 == 0 || var1 == 0) {
      if(level.player scripts\engine\sp\utility::get_player_demeanor() != "relaxed") {
        level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
        wait 0.5;
      }
    } else if(level.player scripts\engine\sp\utility::get_player_demeanor() != "normal") {
      level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    }

    wait 0.1;
  }

  if(level.player scripts\engine\sp\utility::get_player_demeanor() != "normal") {
    level.player scripts\engine\sp\utility::set_player_demeanor("normal");
    return;
  }
}

function alley_stealth_player_movement() {
  scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  scripts\sp\player::player_movement_state("cqb");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

function intro_scene_butcher_aq() {
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  wait 2;
  scripts\engine\sp\utility::array_spawn_function_targetname("enforcer_truck_spawner", &intro_back_alley_enforcer_setup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("intro_back_alley_guys", &intro_alley_aq_setup);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq1_spawner", &scripts\sp\maps\stpetersburg\stpetersburg_utility::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq2_spawner", &scripts\sp\maps\stpetersburg\stpetersburg_utility::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq3_spawner", &scripts\sp\maps\stpetersburg\stpetersburg_utility::aq_override_pistol_silenced);
  scripts\engine\sp\utility::array_spawn_function_targetname("aq4_spawner", &intro_alley_guard_setup);
  var1 = scripts\engine\sp\utility::spawn_targetname("aq1_spawner");
  var1 setModel("body_al_qatala_urban_lmg_variants_2_2");
  var2 = scripts\engine\sp\utility::spawn_targetname("aq2_spawner");
  var2 setModel("body_al_qatala_urban_a6_variants_1_2");
  var3 = scripts\engine\sp\utility::spawn_targetname("aq3_spawner");
  var3 setModel("body_al_qatala_urban_lmg_variants_2_1");
  var4 = scripts\engine\sp\utility::spawn_targetname("aq4_spawner");
  var4 setModel("body_al_qatala_urban_cqb_variants_1_2");
  var5 = scripts\engine\sp\utility::spawn_targetname("enforcer_truck_spawner");
  level.enforcer = var5;
  level.aq1 = var1;
  var6 = getEnt("stakeout_enforcer_truck", "targetname");
  var6.animname = "techo";
  var6 scripts\engine\sp\utility::assign_animtree("techo");
  var5.name = "Butcher";
  var5.script_friendname = "Butcher";
  scripts\engine\utility::exploder("birds_fly");
  scripts\engine\utility::kill_exploder("birds_cluster");
  var5 scripts\sp\maps\stpetersburg\stpetersburg_utility::disable_breath_fx();
  var1 scripts\sp\maps\stpetersburg\stpetersburg_utility::disable_breath_fx();
  var2 scripts\sp\maps\stpetersburg\stpetersburg_utility::disable_breath_fx();
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_aq_truck_arrived", 8);
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_enforcer_visible", 19);
  var7 = getanimlength(var5 scripts\engine\utility::getanim("intro_scene"));
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_enforcer_left_alley", var7);
  var8 = scripts\engine\sp\utility::get_living_ai_array("intro_back_alley_guys", "script_noteworthy");
  scripts\engine\utility::array_thread(var8, &intro_alley_aq_handler);
  var9 = [var5, var1, var2, var6];
  var0 thread scripts\common\anim::anim_single_solo(var6, "intro_scene");
  var0 thread scripts\common\anim::anim_single_solo_run(var1, "intro_scene");
  var0 thread scripts\common\anim::anim_single_solo_run(var2, "intro_scene");
  var0 scripts\common\anim::anim_single_solo(var5, "intro_scene");
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  var8 = scripts\engine\utility::array_removedead_or_dying(var8);
  scripts\engine\utility::array_delete(var8);

  if(isDefined(var5)) {
    var5 delete();
    return;
  }
}

function intro_scene_truck_sound() {
  waitframe();
  level.player playSound("stp_intro_truck_by", "stop_intro_truck_by_sound");
}

function intro_alley_guard_setup() {
  self endon("death");
  self endon("entitydeleted");
  level endon("missionfailed");
  scripts\common\ai::gun_remove();
  scripts\common\utility::demeanor_override("casual");
  self.animname = "aq4";
  var0 = scripts\engine\utility::getStruct("intro_guard_org", "targetname");
  var0 thread scripts\common\anim::anim_loop_solo(self, "civ_casual_idle");
}

function intro_alley_aq_handler() {
  self endon("entitydeleted");
  level endon("missionfailed");
  var0 = scripts\engine\utility::waittill_any_return("damage", "death", "bulletwhizby");
  level.player notify("shot_at_aq");
}

function intro_scene_binocs() {
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  level.binocs = getEnt("intro_stakeout_binocs_free", "targetname");
  level.binocs.animname = "binocs";
  level.binocs scripts\engine\sp\utility::assign_animtree("binocs");

  if(getdvarint("stp_intro_cinematic") > 0) {
    var0 scripts\common\anim::anim_single_solo(level.binocs, "intro_scene");
  }

  var0 scripts\common\anim::anim_last_frame_solo(level.binocs, "intro_scene");
  scripts\engine\utility::flag_wait("flag_stakeout_end");
  level.binocs delete();
}

function intro_stakeout_weapon_select() {
  level.player giveweapon("iw8_gunless");
  level.player switchtoweaponimmediate("iw8_gunless");
  level.player scripts\common\utility::allow_weapon_switch(0);
  thread initial_loadout_init();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_fire_weapon_indoors();
  scripts\engine\utility::flag_wait("flag_stakeout_player_in_kitchen");
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_guns");
  level.player waittill("initial_loadout_selected");
  scripts\engine\utility::flag_set("flag_stakeout_player_has_weapon");
  level.player scripts\common\utility::allow_weapon_switch(1);
  scripts\engine\utility::flag_wait_any("flag_stakeout_nikolai_closed_door", "flag_stakeout_end", "flag_alley_stealth_begin");
  level notify("initial_loadout_disable");
}

function initial_loadout_init() {
  thread remove_gunless_monitor();
  var0 = getEnt("price_gun_pickup", "targetname");
  var0 makeunusable();
  var1 = getEnt("papa320", "targetname");
  var2 = getEnt("decho", "targetname");
  var3 = getEnt("golf21", "targetname");
  var1.base = "iw8_pi_papa320";
  var1.attachments = ["silencerpstl_west01", "reflex_west01_pstl"];
  var2.base = "iw8_pi_decho";
  var2.attachments = ["silencerpstl_west01", "xmags_decho"];
  var3.base = "iw8_pi_golf21";
  var3.attachments = ["silencerpstl_west01", "minireddot_golf21"];
  var1.string = &"STPETERSBURG/PICKUP_PI_PAPA320_SUPPRESSED";
  var2.string = &"STPETERSBURG/PICKUP_PI_DECHO_SUPPRESSED";
  var3.string = &"STPETERSBURG/PICKUP_PI_GOLF21_SUPPRESSED";
  var4 = [var1, var2, var3];

  foreach(var6 in var4) {
    var6 makeunusable();
  }

  var8 = spawn("script_origin", var1 gettagorigin("j_gun"));
  var9 = spawn("script_origin", var2 gettagorigin("j_gun"));
  var10 = spawn("script_origin", var3 gettagorigin("j_gun"));
  var8.gun = var1;
  var9.gun = var2;
  var10.gun = var3;
  var11 = [var8, var9, var10];

  if(getdvarint("stp_intro_cinematic") > 0) {
    scripts\engine\utility::flag_wait("flag_stakeout_allow_weapon_select");
  }

  foreach(var13 in var11) {
    thread initial_loadout_manager();
  }

  scripts\engine\utility::flag_wait_any("flag_stakeout_nikolai_closed_door", "flag_stakeout_end", "flag_alley_stealth_begin");
  wait 1;

  foreach(var13 in var11) {
    var13 delete();
  }
}

function remove_gunless_monitor() {
  level.player waittill("initial_loadout_selected");
  level.player takeweapon("iw8_gunless");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::holster_logic();
}

function initial_loadout_manager() {
  level endon("initial_loadout_disable");
  self.gun show();
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 3), self.gun.string, 10, 80, 40, 1);
  self waittill("trigger");
  level.player notify("initial_loadout_selected");

  if(isDefined(level.player.initial_loadout_weapon)) {
    level.player takeweapon(level.player.initial_loadout_weapon);
  }

  var0 = scripts\sp\utility::make_weapon(self.gun.base, self.gun.attachments);
  level.player giveweapon(var0);
  level.player switchtoweapon(var0);
  level.player givemaxammo(var0);
  level.player.initial_loadout_weapon = var0;
  self.gun hide();
  self.gun.hidden = 1;

  if(isDefined(level.player.initial_loadout)) {
    thread initial_loadout_manager();
  }

  level.player.initial_loadout = self;
}

function intro_stakeout_fire_weapon_check() {
  scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
  var0 = getglassarray("stakeout_window");

  foreach(var2 in var0) {
    thread intro_stakeout_window_monitor(var2);
  }

  thread intro_stakeout_dmg_trig_monitor();
  var4 = getaiarray("axis");

  foreach(var6 in var4) {
    thread intro_stakeout_enemy_monitor();
  }
}

function intro_stakeout_window_monitor(var0) {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_price_move_down_stairs_1");

  for(;;) {
    if(isglassdestroyed(var0)) {
      break;
    }

    wait 0.1;
  }

  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

function intro_stakeout_dmg_trig_monitor() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_end");
  var0 = getEnt("stakeout_window_dmg_trig", "targetname");
  var0 waittill("trigger");
  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

function intro_stakeout_enemy_monitor() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_stakeout_end");
  self endon("entitydeleted");
  scripts\engine\utility::waittill_any("death", "damage", "bulletwhizby");
  level.player notify("shot_out_window");
  thread fire_weapon_fail();
}

function fire_weapon_fail() {
  level.player endon("death");
  level endon("missionfailed");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_player_crazy_fail();
  wait 1;
  scripts\sp\player_death::set_custom_death_quote(426);
  thread scripts\sp\utility::missionfailedwrapper();
}

function intro_stakeout_holster_weapon_check() {
  wait 3;

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0) {
    thread scripts\engine\sp\utility::display_hint_forced("holster_weapon", undefined, 0, level.player, "player_holsterWeapon");
    return;
  }
}

function intro_stakeout_wait_swap_butcher_vehicle() {
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  intro_stakeout_swap_butcher_vehicle();
}

function intro_stakeout_swap_butcher_vehicle() {
  var0 = getEnt("butcher_truck_scriptable", "targetname");
  var1 = getEnt("stakeout_enforcer_truck", "targetname");

  if(isDefined(var1)) {
    var0 notify("stop_alarm");
    var2 = scripts\engine\utility::getStruct("intro_butcher_truck_placed", "targetname");
    var0.origin = var2.origin;
    var0.angles = var2.angles;
    waitframe();
    var1 delete();
  }

  var3 = getEnt("butcher_car_scriptable", "targetname");
  var3 notify("stop_alarm");
  var4 = scripts\engine\utility::getStruct("intro_butcher_car_placed", "targetname");
  var3.origin = var4.origin;
  var3.angles = var4.angles;
}

function alley_car_alarm_setup() {
  var0 = getscriptablearray("no_alarm_vehicles", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("car_alarm", "off");
  }
}

function intro_scene_nikolai() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_nikolai();
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");

  if(getdvarint("stp_intro_cinematic") > 0) {
    var0 scripts\common\anim::anim_single_solo(level.nikolai, "intro_scene");
  }

  var1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle", "end_nikolai_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_kitchen_ready");

  if(!scripts\engine\utility::flag("flag_stakeout_player_has_weapon")) {
    scripts\engine\utility::flag_wait_all("flag_stakeout_player_has_weapon", "flag_stakeout_nikolai_kitchen_ready");
    var1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
    var1 notify("end_nikolai_kitchen_idle");
    var1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_kitchen_exit_alt");

    if(!scripts\engine\utility::flag("flag_stakeout_player_ready_to_move") || !scripts\engine\utility::flag("flag_stakeout_price_kitchen_ready")) {
      var1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle", "end_nikolai_kitchen_idle");
    }
  }

  scripts\engine\utility::flag_set("flag_stakeout_nikolai_kitchen_extra_ready");
  scripts\engine\utility::flag_wait_all("flag_stakeout_player_ready_to_move", "flag_stakeout_price_kitchen_ready", "flag_stakeout_nikolai_kitchen_ready", "flag_stakeout_nikolai_kitchen_extra_ready");
  var1 notify("end_nikolai_kitchen_idle");
  level.nikolai scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_kitchen_exit");
  var1 thread scripts\common\anim::anim_loop_solo(level.nikolai, "stakeout_kitchen_idle02", "end_nikolai_kitchen_idle02");
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_stairs_ready");
  scripts\engine\utility::flag_wait("flag_stakeout_price_move_down_stairs_2");
  var1 notify("end_nikolai_kitchen_idle02");
  thread bar_animate_door("stakeout_apt_scene_org", "stakeout_apt_exit_door", "stakeout_door_close", 1);
  var1 scripts\common\anim::anim_single_solo(level.nikolai, "stakeout_door_close");
  level.nikolai scripts\engine\sp\utility::hide_notsolid();
  scripts\engine\utility::flag_set("flag_stakeout_nikolai_closed_door");
}

#using_animtree("script_model");

function intro_scene_guncase() {
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var1 = getEnt("intro_stakeout_guncase", "targetname");
  var1.animname = "guncase";
  var1 useanimtree(#animtree);

  if(getdvarint("stp_intro_cinematic") > 0) {
    var0 scripts\common\anim::anim_first_frame_solo(var1, "intro_scene");
    var0 scripts\common\anim::anim_single_solo(var1, "intro_scene");
  }

  var0 scripts\common\anim::anim_last_frame_solo(var1, "intro_scene");
}

function intro_scene_price() {
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  level.price scripts\common\utility::demeanor_override("casual");
  level.price scripts\engine\sp\utility::clear_force_color();
  level.price scripts\common\ai::gun_remove();
  level.price scripts\engine\sp\utility::name_hide();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var1 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");

  if(getdvarint("stp_intro_cinematic") > 0) {
    var0 scripts\common\anim::anim_single_solo(level.price, "intro_scene");
    level.price notify("end_silenced_pistol_hack");
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_choose_weapon();
  var1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_kitchen_idle", "end_price_kitchen_idle");
  scripts\engine\utility::flag_set("flag_stakeout_price_kitchen_ready");
  thread intro_stakeout_kitchen_clip();
  scripts\engine\utility::flag_wait("flag_stakeout_player_has_weapon");
  scripts\engine\utility::flag_set("flag_stakeout_player_ready_to_move");
  thread intro_stakeout_holster_weapon_check();
  scripts\engine\utility::flag_wait_all("flag_stakeout_player_ready_to_move", "flag_stakeout_price_kitchen_ready", "flag_stakeout_nikolai_kitchen_ready", "flag_stakeout_nikolai_kitchen_extra_ready");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_quickly_and_quietly();
  var1 notify("end_price_kitchen_idle");
  thread bar_animate_door("stakeout_apt_scene_org", "stakeout_apt_exit_door", "stakeout_kitchen_exit", 0);
  var1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit");
  thread intro_stakeout_landing_clip();

  if(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1")) {
    var1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit_to_idle");

    if(!scripts\engine\utility::flag("flag_stakeout_price_move_down_stairs_1")) {
      var1 thread scripts\common\anim::anim_loop_solo(level.price, "stakeout_idle_stairs", "end_stairs_idle");
      scripts\engine\utility::flag_set("flag_stakeout_price_stairs_ready");
      thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_exit_apartment();
      scripts\engine\utility::flag_wait_all("flag_stakeout_price_move_down_stairs_1", "flag_stakeout_price_stairs_ready");
      var1 notify("end_stairs_idle");
      level.price scripts\engine\sp\utility::anim_stopanimScripted();
    }

    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_start_down_stairs();
    var1 scripts\common\anim::anim_single_solo(level.price, "stakeout_idle_exit_stairs");
  } else {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_start_down_stairs();
    var1 scripts\common\anim::anim_single_solo(level.price, "stakeout_kitchen_exit_to_stairs");
  }

  thread intro_stakeout_stairs_clip();
  var1 scripts\common\anim::anim_single_solo(level.price, "stakeout_descend_stairs");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_at_door");

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 1 && scripts\engine\utility::flag("flag_alley_stealth_player_near_exit_door")) {
    scripts\engine\utility::flag_set("flag_stakeout_price_exit_quick");
    return;
  }

  var1 thread scripts\common\anim::anim_loop_solo(level.price, "stealth_door_idle", "end_door_idle");
}

function price_silenced_pistol_hack() {
  level.price endon("end_silenced_pistol_hack");

  while(!isDefined(level.price.weapon)) {
    waitframe();
  }

  while(createheadicon(level.price.weapon) == "iw8_pi_papa320+mag_papa320+rec_papa320+silencerpstl_west01+slide_papa320") {
    waitframe();
  }

  level.price scripts\anim\shared::forceuseweapon(level.price.silenced_pistol, "primary");
}

function intro_scene_skip() {
  wait 1;
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  scripts\sp\hud_util::fade_out(0);
  level notify("intro_scene_skipped");
  level.player stopsounds();
  var1 = getanimlength(level.fake_player scripts\engine\utility::getanim("intro_scene"));
  var2 = [];
  GscBinSkip0(0x2e, 0, level.price);
}

function intro_stakeout_kitchen_clip() {
  var0 = getEnt("stakeout_kitchen_clip", "targetname");
  var0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var0 connectpaths();
  wait 0.5;
  var0 delete();
}

function intro_stakeout_landing_clip() {
  var0 = getEnt("stakeout_stairs_landing_clip", "targetname");
  var0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var0 connectpaths();
  wait 0.5;
  var0 delete();
}

function intro_stakeout_stairs_clip() {
  var0 = getEnt("stakeout_stairs_top_clip", "targetname");
  var0 movez(256, 0.15, 0.05, 0.05);
  wait 0.2;
  var0 connectpaths();
  wait 0.5;
  var0 delete();
}

function intro_stakeout_door_clip(var0) {
  var1 = getEnt("stakeout_bedroom_door_clip", "targetname");

  if(var0 == 1) {
    var1 movez(128, 0.1, 0.05, 0.05);
    var1 connectpaths();
    return;
  }

  var1 movez(-128, 0.1, 0.05, 0.05);
  var1 disconnectPaths();
}

function waittill_lookat_price_or_door_or_delay(var0, var1) {
  level endon(var0);
  level endon("missionfailed");
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_player_ready_to_move", var1);
  var2 = scripts\engine\utility::getStruct("stakeout_exit_door_lookat", "targetname");

  for(;;) {
    var3 = scripts\engine\sp\utility::within_fov_of_players(level.price getEye(), cos(45));
    var4 = scripts\engine\sp\utility::within_fov_of_players(var2.origin, cos(45));

    if(var3 == 1 || var4 == 1) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set(var0);
}

function waittill_player_weapon_holstered() {
  for(;;) {
    if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered()) {
      break;
    }

    waitframe();
  }
}

function bar_rotate_door(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = getEnt(var0, "targetname");
  var4 = getEnt(var0 + "_clip", "targetname");
  var4 linkTo(var3);
  var3 rotateYaw(var1, 1, 0.05, 0.05);
  wait 1;

  if(var2 == 0) {
    var4 connectpaths();
    return;
  }

  var4 disconnectPaths();
}

function bar_animate_door(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  var6 = scripts\engine\utility::getStruct(var0, "targetname");
  var7 = getEnt(var1, "targetname");
  var8 = getEnt(var1 + "_clip", "targetname");

  if(var8 islinked() == 0) {
    var8 linkTo(var7);
  }

  var7.animname = "door";
  var7 useanimtree(#animtree);

  if(var4 == 1) {
    var6 scripts\common\anim::anim_first_frame_solo(var7, var2);
  } else if(var5 == 1) {
    var9 = var7 getanimtime(var7 scripts\engine\utility::getanim(var2));
    var6 thread scripts\common\anim::anim_single_solo(var7, var2);
    var7 setanimrate(var7 scripts\engine\utility::getanim(var2), 2);
    wait var9 * 0.5;
  } else {
    var6 scripts\common\anim::anim_single_solo(var7, var2);
  }

  if(var3 == 0) {
    var8 connectpaths();
    return;
  }

  var8 disconnectPaths();
}

function intro_alley_aq_setup() {
  self endon("death");
  scripts\engine\sp\utility::set_battlechatter(0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::set_enemy_low_health();
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
}

function alley_stealth_aq_setup() {
  self endon("death");
  self endon("entitydeleted");
  thread alley_stealth_check_for_player_kill();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler(0.5, 1, ["flag_alley_stealth_player_killed_aq", "flag_alley_stealth_price_ambush_end"]);
  scripts\engine\sp\utility::set_battlechatter(0);
  self.script_longdeath = 0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility::set_enemy_low_health();
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
  var0 = level scripts\engine\utility::waittill_any_return("alley_alert", "price_ambush");

  if(var0 == "price_ambush") {
    if(scripts\engine\utility::is_equal(self.targetname, "alley_stealth_aq01")) {
      return;
    }

    self getenemyinfo(level.price);
  } else {
    var1 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis");

    if(isDefined(var1) && self == var1) {
      waitframe();
      var2 = vectorNormalize(level.player.origin - self.origin);
      var3 = anglesToForward(self.angles);
      var4 = anglestoright(self.angles);
      var5 = vectordot(var2, var3);
      var6 = vectordot(var2, var4);
      var7 = undefined;

      if(var5 > 0.7) {
        var7 = "reb_stl_patrol_pstl_idle_react_md_8";
      } else if(var5 < -0.7) {
        var7 = "reb_stl_patrol_pstl_idle_react_md_2";
      } else if(var6 > 0.7) {
        var7 = "reb_stl_patrol_pstl_idle_react_md_6";
      } else if(var6 < -0.7) {
        var7 = "reb_stl_patrol_pstl_idle_react_md_4";
      } else {
        iprintlnbold("Fwd = " + var5 + " ... Right = " + var6);
      }

      if(isDefined(var7)) {
        self.animname = "aq01";
        scripts\common\anim::anim_single_solo_run(self, var7);
      }
    } else {
      scripts\engine\sp\utility::anim_stopanimScripted();
      self notify("stop_first_frame");
    }

    self getenemyinfo(level.player);
  }

  var8 = getEnt("alley_stealth_enemy_vol", "targetname");
  self setgoalvolumeauto(var8);
  scripts\common\utility::clear_demeanor_override();
  scripts\engine\sp\utility::set_ignoreme(0);
  scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\sp\utility::set_pacifist(1);
  scripts\engine\sp\utility::disable_dontevershoot();
  self.dontshootwhilemoving = 0;
  self.allowstrafe = 1;
  var9 = scripts\common\utility::getdifficulty();
  var10 = randomfloatrange(1, 3);

  if(var0 == "price_ambush" && var9 == "easy") {
    var10 = randomfloatrange(5, 8);
  } else if(var0 == "price_ambush" && var9 == "medium") {
    var10 = randomfloatrange(3, 5);
  }

  wait var10;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\engine\sp\utility::set_dontmelee(0);
  scripts\engine\sp\utility::set_pacifist(0);
  scripts\engine\sp\utility::set_battlechatter(1);
}

function alley_stealth_check_for_player_kill() {
  self endon("entitydeleted");
  self waittill("death", var0);

  if(isDefined(var0) && var0 == level.player) {
    scripts\engine\utility::flag_set("flag_alley_stealth_player_killed_aq");
    return;
  }
}

function alley_stealth_aq_alert() {
  level endon("flag_alley_stealth_aq_dead");
  level endon("price_ambush");
  level endon("pre_price_ambush");
  level endon("alley_alert");
  level endon("flag_alley_stealth_mission_fail");
  self endon("death");
  var0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby", "weapon_fired", "player_prox");
  level notify("alley_alert");
}

function alley_stealth_aq_prox_check() {
  level endon("flag_alley_stealth_aq_dead");
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("flag_alley_stealth_mission_fail");
  self endon("death");
  self endon("entitydeleted");
  wait 0.1;
  var0 = 128;

  if(isDefined(self.animname) && self.animname == "aq01") {
    var0 = 64;
  }

  for(;;) {
    if(scripts\engine\sp\utility::players_within_distance(var0, self.origin)) {
      self notify("player_prox");
      return;
    }

    wait 0.1;
  }
}

function intro_back_alley_enforcer_setup() {
  self endon("entitydeleted");
  var0 = getEnt("enforcer_exit_goal", "targetname");
  scripts\common\utility::demeanor_override("casual");
  scripts\engine\sp\utility::set_pacifist(1);

  if(self.animname == "enforcer") {
    scripts\common\ai::gun_remove();
  }

  waitframe();
  scripts\engine\utility::flag_wait("flag_stakeout_enforcer_left_alley");
  self delete();
}

function alley_stealth_player_fail_handler() {
  level.player endon("death");
  level endon("flag_alley_stealth_aq_dead");
  level endon("flag_alley_stealth_mission_fail");
  level endon("flag_backroom_player_rushes");
  var0 = level scripts\engine\utility::waittill_any_return("alley_alert", "price_ambush");
  var1 = getEntArray("stealth_alley_nosight_clip", "targetname");
  scripts\engine\utility::array_delete(var1);
  var2 = 7;
  var3 = scripts\common\utility::getdifficulty();

  if(var3 == "medium") {
    var2 = 6;
  } else if(var3 == "hard") {
    var2 = 5;
  } else if(var3 == "fu") {
    var2 = 4;
  }

  var4 = getEntArray("alley_stealth_player_exposed_vol", "targetname");

  foreach(var6 in var4) {
    if(level.player istouching(var6)) {
      var2 += 2;
    }
  }

  if(var0 == "price_ambush") {
    scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_end");
    var2 += 2;
    thread scripts\engine\utility::flag_set_delayed("flag_alley_stealth_near_fail", var2 * 0.75);
    wait var2;
  } else {
    scripts\engine\utility::flag_set("flag_alley_stealth_cover_blown");
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_cover_blown();
    thread scripts\engine\utility::flag_set_delayed("flag_alley_stealth_near_fail", var2 * 0.75);
    wait var2;
  }

  if(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    var8 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");
    scripts\engine\utility::array_thread(var8, &enemy_magic_bullet_shield);
    thread alley_stealth_player_fail();
    return;
  }
}

function enemy_magic_bullet_shield() {
  if(!isDefined(self.melee)) {
    thread scripts\engine\sp\utility::deletable_magic_bullet_shield();
    return;
  }
}

function alley_stealth_player_fail() {
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_set("flag_alley_stealth_mission_fail");
  scripts\engine\utility::flag_set("disable_autosaves");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_butcher_alerted_fail();
  wait 2;
  scripts\sp\player_death::set_custom_death_quote(426);
  thread scripts\sp\utility::missionfailedwrapper();
}

function alley_stealth_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_alley_stealth_player_opens_bar_door", "stpetersburg_stakeout_script_tr", "stpetersburg_bar_script_tr");
  thread alley_stealth_player_movement();
  thread alley_stealth_enemies();
  thread alley_stealth_player_fail_handler();
  thread alley_stealth_check_player();
  thread alley_stealth_price_setup();
  thread alley_stealth_stakeout_exit_door_handler();
  thread move_speed_reset();
}

function move_speed_reset() {
  while(level.price.ignoreall) {
    waitframe();
  }

  setsaveddvar("MNPNORMOMP", 1);
}

function alley_stealth_enemies() {
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", &scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", &alley_stealth_aq_setup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("alley_stealth_aq", &scripts\sp\maps\stpetersburg\stpetersburg_utility::aq_override_pistol_silenced);
  var0 = scripts\engine\sp\utility::array_spawn_noteworthy("alley_stealth_aq");
  var1 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");
  var1.animname = "aq01";
  var1.script_animname = "aq01";
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1 setModel("body_al_qatala_urban_a6_variants");
  var2 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq02", "targetname");
  var2.animname = "aq02";
  var2.script_animname = "aq02";
  var2 scripts\engine\sp\utility::set_allowdeath(1);
  var2 setModel("body_al_qatala_urban_lmg_variants_2_2");
  var3 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq03", "targetname");
  var3.animname = "aq03";
  var3.script_animname = "aq03";
  var3 scripts\engine\sp\utility::set_allowdeath(1);
  var3 setModel("body_al_qatala_urban_lmg_variants_2_1");
  var4 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq04", "targetname");
  var4.animname = "aq04";
  var4.script_animname = "aq04";
  var4 scripts\engine\sp\utility::set_allowdeath(1);
  var4 setModel("body_al_qatala_urban_cqb_variants_1_2");
  thread alley_stealth_grabbed_enemy_handler();
  thread alley_stealth_background_enemy_handler();
  thread alley_stealth_background_enemy_handler();
  thread alley_stealth_background_enemy_handler();
  thread alley_stealth_remove_dead_bodies();
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_end", "flag_alley_stealth_aq_dead");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_clean_up_last_enemy(var0, randomfloatrange(4, 6));

  if(var0.size > 0) {
    foreach(var6 in var0) {
      if(scripts\engine\utility::flag("flag_alley_stealth_price_ambush_begin") && var6.targetname == "alley_stealth_aq01") {
        continue;
      }

      var6 scripts\engine\sp\utility::anim_stopanimScripted();
    }

    return;
  }
}

function alley_stealth_grabbed_enemy_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  self endon("death");
  self endon("entitydeleted");
  var0 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(self, "stealth_alley_intro");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  var0 scripts\common\anim::anim_single_solo(self, "stealth_alley_intro");
  var0 scripts\common\anim::anim_single_solo(self, "stealth_alley_shootout");
  self.skipdeathanim = 1;
  self.diequietly = 1;
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\sp\utility::die();
}

function alley_stealth_background_enemy_handler() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  self endon("death");
  self endon("entitydeleted");
  var0 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(self, "stealth_alley_intro");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  var0 scripts\common\anim::anim_single_solo(self, "stealth_alley_intro");
  var0 scripts\common\anim::anim_single_solo_run(self, "stealth_alley_shootout");
}

function alley_stealth_bar_entrance_door_handler() {
  var0 = scripts\sp\door::get_interactive_door("bar_alley_entrance_interactive_door");
  var1 = getEntArray("bar_alley_entrance_interactive_door", "targetname");

  foreach(var3 in var1) {
    var3 hide();
  }

  var0.script_max_left_angle = 100;
  var0.script_max_right_angle = 100;
  var0 scripts\sp\door::init_max_yaws();
  var0 scripts\game\sp\door::remove_door_c4_ability();
  scripts\engine\utility::flag_wait("flag_alley_stealth_begin");
  var5 = getEnt("bar_alley_entrance_door", "targetname");
  var5 delete();

  foreach(var3 in var1) {
    var3 show();
  }

  scripts\engine\utility::flag_wait_any("flag_alley_stealth_aq_dead", "flag_alley_stealth_player_near_bar_door");
  var8 = getEnt("bar_alley_entrance_door_clip", "targetname");
  var8 movez(-256, 0.1, 0.05, 0.05);
  var8 connectpaths();
  thread alley_stealth_monitor_door_bash();
  thread player_weapon_holstered_door_bash_monitor();
  thread bar_alley_entrance_door_interacted();
  scripts\engine\utility::flag_wait("flag_bomb_room_enforcer_clear");
  var0 scripts\sp\door::reset_door();
  var0 scripts\sp\door::remove_open_ability();
  var0.max_yaw_left = 110;
  var0.max_yaw_right = 110;
  var0 scripts\sp\door::init_max_yaws();
  var8 movez(256, 0.1, 0.05, 0.05);
  var8 disconnectPaths();
  wait 0.2;
  var8 delete();
  var9 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  if(var9.size > 0) {
    scripts\engine\utility::array_delete(var9);
    return;
  }
}

function alley_stealth_door_hint_handler() {
  level endon("flag_alley_stealth_player_opens_bar_door");
  scripts\engine\utility::flag_wait("flag_alley_stealth_aq_dead");
  self.no_bash = 1;
  self.open_struct.no_open_interact = undefined;
  self.open_struct scripts\sp\door::create_open_interact_hint();
}

function alley_stealth_monitor_door_bash() {
  level endon("missionfailed");
  level.player endon("death");
  var0 = scripts\engine\utility::flag_wait_any_return("door_bashed", "flag_alley_stealth_player_opens_bar_door");

  if(scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    return;
  }

  scripts\engine\utility::flag_set("flag_backroom_player_rushes");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_player_rushed_door();
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  scripts\engine\utility::flag_set("flag_player_blew_backroom_stealth");
}

function replace_door_open_interact_hint() {
  var0 = "Open";

  if(!istrue(self.openinteract) || !isDefined(self.cursor_hint_ent)) {
    self.open_struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var0, 45, 600, 80, 1);
    self.open_struct.cursor_hint_ent setusewhenhandsoccupied(1);
    self.open_struct.openinteract = 1;
    return;
  }
}

function alley_stealth_check_player() {
  thread alley_stealth_check_if_player_shoots();
  thread alley_stealth_check_if_player_unholsters();
}

function alley_stealth_check_if_player_shoots() {
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");
  level.player waittill("weapon_fired");
  level notify("alley_alert");
}

function alley_stealth_check_if_player_unholsters() {
  level endon("pre_price_ambush");
  level endon("price_ambush");
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  var0 = getEntArray("alley_stealth_player_exposed_vol", "targetname");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_opening_door");

  for(;;) {
    foreach(var2 in var0) {
      if(level.player istouching(var2) && scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0) {
        level notify("alley_alert");
        return;
      }
    }

    wait 0.1;
  }
}

function alley_stealth_reset_enemy_alert_level() {
  self endon("death");
  self endon("entitydeleted");
  thread scripts\stealth\utility::addeventplaybcs("stealth", "announce5", "alertreset");
  scripts\stealth\enemy::set_alert_level("reset");
  scripts\stealth\enemy::bt_set_stealth_state("idle");
}

function alley_place_truck_start() {
  var0 = getEnt("stakeout_enforcer_truck", "targetname");
  var0.animname = "techo";
  var0 scripts\engine\sp\utility::assign_animtree("techo");
  var1 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var1 scripts\common\anim::anim_last_frame_solo(var0, "intro_scene");
}

function alley_stealth_start_function() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stakeout_fire_weapon_indoors();
  thread intro_stakeout_player_muzzle_discipline();
  thread alley_stealth_price_from_start_point();
  thread alley_stealth_bar_entrance_door_handler();
  thread alley_place_truck_start();
  thread alley_car_alarm_setup();
}

function alley_stealth_price_from_start_point() {
  var0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var0 thread scripts\common\anim::anim_loop_solo(level.price, "stealth_door_idle", "end_door_idle");
  level.price scripts\common\ai::gun_remove();
  scripts\engine\utility::flag_set("flag_alley_stealth_price_at_door");
}

function alley_stealth_price_setup() {
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
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  scripts\engine\utility::flag_set("flag_alley_stealth_begin");
  var0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var1 = scripts\engine\utility::getStruct("price_stealth_alley_door_org", "targetname");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_at_door");
  thread alley_stealth_price_alert_end_door_idle();
  scripts\engine\utility::flag_wait("flag_alley_stealth_player_near_exit_door");
  alley_stealth_price_check_player();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_price_at_door();
  var0 notify("end_door_idle");
  level notify("stealth_alley_intro_door");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_opening_door");
  scripts\engine\utility::flag_set("flag_start_alley_containment");
  thread scripts\engine\sp\utility::autosave_by_name("alley_stealth_price_opens_door");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_price_conversation();
  thread alley_stealth_draw_weapon_check();
  thread alley_stealth_pre_price_ambush_notify();
  var1 scripts\common\anim::anim_single_solo(level.price, "stealth_alley_intro");
  level notify("price_ambush");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_begin");
  var2 = scripts\engine\sp\utility::get_living_ai("alley_stealth_aq01", "targetname");

  if(isDefined(var2) && isalive(var2)) {
    var2 scripts\engine\sp\utility::set_allowdeath(0);
    var2 actoraimassistoff();
    var1 scripts\common\anim::anim_single_solo_run(level.price, "stealth_alley_shootout");
  }

  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_end");
}

function alley_stealth_price_check_player() {
  level.player endon("death");
  level endon("missionfailed");
  level endon("flag_alley_stealth_cover_blown");
  level endon("alley_alert");

  if(scripts\engine\utility::flag("flag_stakeout_price_exit_quick")) {
    return;
  }

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0) {
    thread intro_stakeout_holster_weapon_check();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_stealth_again_holster_weapon_nag();

    for(;;) {
      if(scripts\engine\sp\utility::players_within_distance(180, level.price.origin) && scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered()) {
        level notify("weapon_holstered");
        break;
      }

      waitframe();
    }

    return;
  }
}

function alley_stealth_price_alert_end_door_idle() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_price_opening_door");
  level waittill("alley_alert");
  scripts\engine\utility::flag_set("flag_alley_stealth_cover_blown");
  var0 = scripts\engine\utility::getStruct("stakeout_apt_scene_org", "targetname");
  var0 notify("end_door_idle");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 0, 0, 1);
}

function alley_stealth_draw_weapon_check() {
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_setup");
  wait 0.1;

  if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 1) {
    thread scripts\engine\sp\utility::display_hint("draw_weapon", undefined, 0, level.player, "draw_weapon");

    for(;;) {
      if(scripts\sp\maps\stpetersburg\stpetersburg_utility::player_weapon_holstered() == 0) {
        level.player notify("draw_weapon");
        return;
      }

      wait 0.1;
    }

    return;
  }
}

function alley_stealth_pre_price_ambush_notify() {
  level endon("alley_alert");
  level endon("missionfailed");
  level.player endon("death");
  wait getanimlength(level.price scripts\engine\utility::getanim("stealth_alley_intro"));
  level notify("pre_price_ambush");
  scripts\engine\utility::flag_set("flag_alley_stealth_price_ambush_setup");
}

function get_aq_for_shootout_anim(var0) {
  var1 = scripts\engine\sp\utility::get_living_ai(var0 + "_spawner_alt", "targetname");

  if(isDefined(var1)) {
    return var1;
  }
}

function kill_aq_for_shootout_anim() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("alley_alert");
  self endon("death");
  scripts\engine\utility::flag_wait("flag_alley_stealth_price_ambush_begin");
  var0 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");
  var0 = scripts\engine\utility::array_remove(var0, self);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::waittill_alive_count(var0, 0);
  scripts\engine\utility::flag_set("flag_alley_stealth_aq_dead");
}

function alley_stealth_price_combat() {
  level endon("missionfailed");
  level.player endon("death");
  var0 = scripts\engine\utility::flag_wait_any_return("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_end");

  if(scripts\engine\utility::flag("flag_alley_stealth_price_at_door")) {
    level.price scripts\engine\sp\utility::anim_stopanimScripted();
  }

  if(var0 == "flag_alley_stealth_cover_blown") {
    var1 = scripts\sp\utility::make_weapon("iw8_pi_papa320", ["silencerpstl_west01"]);
    level.price.silenced_pistol = var1;
    level.price scripts\anim\shared::forceuseweapon(var1, "sidearm");
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_average();
    level.player.og_attackeraccuracy = level.player.attackeraccuracy;
    var2 = scripts\common\utility::getdifficulty();

    if(var2 == "medium") {
      level.player scripts\sp\utility::set_player_attacker_accuracy(2);
    } else if(var2 == "hard") {
      level.player scripts\sp\utility::set_player_attacker_accuracy(3);
    } else if(var2 == "fu") {
      level.player scripts\sp\utility::set_player_attacker_accuracy(5);
    }

    level.price scripts\engine\sp\utility::enable_ai_color();
    scripts\engine\sp\utility::activate_trigger_with_targetname("price_alley_combat_colors");
  } else {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_high();
    var3 = getnode("alley_stealth_price_node", "targetname");
    level.price scripts\engine\sp\utility::disable_ai_color();
    level.price scripts\engine\sp\utility::set_goal_radius(32);
    level.price scripts\engine\sp\utility::set_goal_node(var3);
  }

  var4 = getEnt("alley_stealth_interior_vol", "targetname");

  if(level.price istouching(var4)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  }

  level.price scripts\engine\sp\utility::set_ignoreall(0);
  level.price scripts\engine\sp\utility::set_ignoreme(0);
  level.price scripts\common\utility::clear_demeanor_override();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  thread alley_stealth_price_clean_house();
  var0 = scripts\engine\utility::flag_wait_any_return("flag_alley_stealth_aq_dead", "flag_backroom_player_rushes");

  if(var0 == "flag_alley_stealth_aq_dead") {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_enemies_dead();
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_average();
    alley_stealth_price_post_at_door();
    scripts\engine\utility::flag_wait("flag_alley_stealth_player_opens_bar_door");
    level.price scripts\common\utility::demeanor_override("cqb");
    scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  }

  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  level.price scripts\engine\sp\utility::enable_ai_color();
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("price_move_to_alley_door_colors", "targetname", "activate");
  level.player notify("remove_gunless");
  scripts\engine\sp\utility::trigger_wait_targetname("trig_send_price_down_backaroom_stairs");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
}

function alley_stealth_price_adjust_ff_penalty() {
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_cover_blown", "flag_alley_stealth_price_ambush_begin", "flag_alley_stealth_price_opening_door");
  level.price.friend_kill_points = int(level.friendlyfire["friend_kill_points"] * 0.1);
  scripts\engine\utility::flag_wait_any("flag_alley_stealth_aq_dead", "flag_backroom_player_rushes");
  level.price.friend_kill_points = undefined;
}

function alley_stealth_price_post_at_door() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_player_opens_bar_door");
  scripts\engine\sp\utility::autosave_by_name("alley_stealth_complete");
  var0 = scripts\engine\utility::getStruct("price_alley_struct_midpoint", "targetname");
  level.price scripts\sp\spawner::go_to_node(var0);
  level.price scripts\engine\sp\utility::set_goal_node_targetname("enter_alley_bar_node");
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_alley_stealth_move_to_bar_door();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
}

function waittill_struct_within_fov(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var3 = getEnt(var1, "targetname");
  var4 = cos(35);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var2.origin, var4) && level.player istouching(var3)) {
      break;
    }

    waitframe();
  }
}

function alley_stealth_price_clean_house() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_alley_stealth_aq_dead");
  level endon("flag_alley_stealth_player_opens_bar_door");
  wait 1;
  var0 = scripts\common\utility::getdifficulty();
  var1 = 1;

  if(var0 == "easy") {
    var1 = 2;
  } else {
    return;
  }

  var2 = scripts\engine\sp\utility::get_living_ai_array("alley_stealth_aq", "script_noteworthy");

  while(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    waitframe();
    var2 = scripts\engine\utility::array_removedead_or_dying(var2);

    if(var2.size > var1) {
      continue;
    } else if(var2.size == 0) {
      break;
    }

    var3 = scripts\sp\maps\stpetersburg\stpetersburg_utility::price_get_los_enemy(var2);
    level.price shoot(100, var3 getEye());
    var3 waittill("death");
    wait 1;
  }
}

function alley_stealth_remove_dead_bodies() {
  level endon("flag_bar_shootout_enter");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  var0 = getcorpsearray();

  foreach(var2 in var0) {
    var2 delete();
  }
}

function alley_stealth_stakeout_exit_door_handler() {
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 1, 1);
  var0 = level scripts\engine\utility::waittill_any_return("stealth_alley_intro_door", "stealth_alley_cancel_door");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 0);
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  thread bar_animate_door("price_stealth_alley_door_org", "stealth_exit_door", "stealth_alley_intro", 1, 1);
}

function bar_interior_exit_door_handler() {
  scripts\engine\utility::flag_wait("flag_enforcer_exit_shootout_door");
  thread bar_rotate_door("bar_interior_exit_door", 105);
}

function bar_enforcer_second_handler() {
  var0 = scripts\engine\utility::getStruct("backroom_enforcer_anim_struct", "targetname");

  if(!isDefined(level.enforcer)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("node_enforcer_bomb_room");
  }

  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  level.enforcer endon("death");
  var1 = getnode("node_enforcer_bomb_room", "script_noteworthy");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var1);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var0 thread scripts\common\anim::anim_loop_solo(level.enforcer, "backroom_idle", "startled");
  thread enforcer_backroom_shot();
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_player_blew_cover();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var0 notify("startled");
  thread bomb_room_spawn_extra_guy();
  thread scripts\engine\utility::flag_set_delayed("flag_enforcer_flees_backroom", 1);
  var0 scripts\common\anim::anim_single_solo(level.enforcer, "backroom_react");
  scripts\engine\utility::flag_set("flag_bomb_room_enforcer_clear");
  var1 = getnode("node_enforcer_exit_bomb_room", "targetname");
  level.enforcer setgoalnode(var1);
  thread bar_enforcer_third_handler();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_player_exit_back_room", 20);
}

function enforcer_backroom_shot() {
  level endon("flag_enforcer_flees_backroom");
  level.enforcer endon("death");
  var0 = 200;
  level.enforcer.fake_health = var0;

  while(isalive(level.enforcer) && level.enforcer.fake_health > 0) {
    level.enforcer waittill("damage", var1, var2, var3, var4, var5);

    if(isDefined(var2) && var2 != level.player) {
      continue;
    }

    level.enforcer.fake_health = 0;
    waitframe();
  }
}

function bomb_room_check_if_enforcer_clear() {
  var0 = getnodearray("post_enforcer_node", "targetname");

  foreach(var2 in var0) {
    var2 disconnectnode();
  }

  var4 = [];
  GscBinSkip0(0x2e, 0, getEnt("enemy_bomb_room_left", "script_noteworthy"));
}

function bar_enforcer_third_handler() {
  if(!isDefined(level.enforcer)) {
    scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("node_enforcer_club");
  } else {
    var0 = getnode("node_enforcer_club", "targetname");
    level.enforcer scripts\engine\sp\utility::teleport_ai(var0);
  }

  level.enforcer endon("death");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  level.enforcer scripts\engine\sp\utility::clear_force_color();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  var1 = scripts\engine\utility::getStruct("enforcer_bar_slide_anim_org", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(level.enforcer, "bar_escape_slide");
  scripts\engine\utility::flag_wait_either("flag_bar_shootout_enter", "flag_shootout_enemies_shot_early");
  thread bar_shootout_enforcer_impulse();
  scripts\engine\utility::delaythread(4.5, &scripts\engine\utility::flag_set, "flag_enforcer_exit_shootout_door");
  var2 = scripts\engine\utility::getStruct("enforcer_bar_exit_anim_org", "targetname");
  var2 scripts\common\anim::anim_single_solo(level.enforcer, "bar_escape_exit");
  scripts\engine\utility::flag_set("flag_shootout_turn_off_player_kill");
  var0 = getnode("node_enforcer_alley", "targetname");
  level.enforcer setgoalnode(var0);
  level.enforcer stopanimScripted();
  level.enforcer scripts\engine\sp\utility::teleport_ai(var0);
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::trigger_wait_targetname("enforcer_exit_to_alley_trig");
  thread kitchen_aq_shoots_down_stairs();
  scripts\engine\utility::flag_set("flag_kitchen_aq_shoots_down_stairs");
}

function bar_shootout_enforcer_impulse() {
  wait 2.7;
  var0 = scripts\engine\utility::getStruct("chair_impulse", "targetname");
  radiusdamage(var0.origin, 20, 20, 15, undefined, undefined, undefined, 1);
  var1 = scripts\engine\utility::getStruct("bottle_impulse", "targetname");
  radiusdamage(var1.origin, 30, 20, 15, undefined, undefined, undefined, 1);
}

function bar_pooltable_aq_anim() {
  var0 = getEnt("pooltable_aq", "targetname");
  var0.animname = "generic";
  var0 endon("death");
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  var0.skipdeathanim = 1;
  var0.orig_health = var0.health;
  var0.health = 1;
  var1 = scripts\engine\utility::getStruct("pooltable_aq_anim_org", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "bar_pooltable_aq");
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var1 scripts\common\anim::anim_single_solo(var0, "bar_pooltable_aq");
  var0.health = var0.orig_health;
}

function bar_right_aq_anim() {
  var0 = getEnt("bar_right", "targetname");
  var0.animname = "generic";
  var0 endon("death");
  var1 = scripts\engine\utility::getStruct("bar_right_aq", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "bar_right_aq");
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var1 scripts\common\anim::anim_single_solo(var0, "bar_right_aq");
  var0 stopanimScripted();
}

function bar_back_aq_anim() {
  var0 = getEnt("bar_back", "targetname");
  var0.animname = "generic";
  var0 endon("death");
  var1 = scripts\engine\utility::getStruct("bar_back_aq", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(var0, "bar_back_aq");
  var0 scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  var1 scripts\common\anim::anim_single_solo(var0, "bar_back_aq");
  var0 stopanimScripted();
}

function kitchen_toggle_containment() {
  scripts\engine\utility::flag_wait("flag_ambusher_blindfire_end");
  scripts\engine\utility::flag_set("flag_start_bar_street_containment");
}

function bar_backroom_main() {
  thread scripts\sp\analytics::analytics_kleenex_update("Bar entrance to bar street");
  thread bar_backroom_player_speed_handler();
  thread bar_enforcer_second_handler();
  thread backroom_price_follow_player();
  thread backroom_check_if_player_shoots();
  thread backroom_check_if_player_jumps();
  thread backroom_pre_combat_handler();
  setsaveddvar("NQNQPRLRQM", 0.05);
}

function backroom_check_if_player_shoots() {
  level endon("flag_player_exit_back_room");
  level endon("flag_enforcer_flees_backroom");
  level endon("flag_player_blew_backroom_stealth");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("flag_player_shoots_in_backroom");
}

function backroom_check_if_player_jumps() {
  level endon("flag_player_exit_back_room");
  level endon("flag_enforcer_flees_backroom");
  level endon("flag_player_blew_backroom_stealth");
  var0 = getEnt("check_if_player_jumps_trig_1", "targetname");
  var1 = getEnt("check_if_player_jumps_trig_2", "targetname");
  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  var2 = 1;

  while(var2) {
    if(level.player istouching(var0) || level.player istouching(var1)) {
      if(level.player jumpbuttonPressed() || level.player getstance() == "stand") {
        scripts\engine\utility::flag_set("flag_player_jumps_in_backroom");
        var2 = 0;
        return;
      } else {
        waitframe();
      }
    }

    waitframe();
  }
}

function back_backroom_player_standing_handler() {
  level endon("flag_player_exit_back_room");
  level endon("flag_player_shoots_in_backroom");
  level endon("flag_player_blew_backroom_stealth");
  level endon("flag_backroom_butcher_convo_over");
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_backroom_butcher_convo_half");

  for(;;) {
    if(level.player getstance() == "stand") {
      scripts\engine\utility::flag_set("flag_backroom_player_seen_standing");
    }

    wait 0.5;
  }
}

function backroom_price_follow_player() {
  level.price scripts\common\utility::demeanor_override("cqb");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  scripts\engine\utility::flag_set("flag_start_bar_backroom_containment");

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_price_dont_kill_butcher();
  }

  scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_butcher_conversation();
    return;
  }
}

function bar_backroom_player_speed_handler() {
  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    scripts\sp\player::player_movement_state("creep");
    scripts\engine\utility::flag_wait_any("flag_unlock_critical_bar_doors", "flag_player_shoots_in_backroom", "flag_backroom_player_rushes");
  }

  scripts\sp\player::player_movement_state("default");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

function bomb_room_spawn_extra_guy() {
  level endon("flag_player_exit_back_room");
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  wait 2.5;
  var0 = scripts\engine\sp\utility::spawn_targetname("spawner_bomb_room_extra");
  var0 endon("death");
  var0 endon("entitydeleted");
  var1 = getnode("enemy_bomb_room_back_goal_node", "targetname");
  var0 getenemyinfo(level.player);
  var0 scripts\engine\sp\utility::set_goal_radius(16);
  var0 scripts\engine\sp\utility::set_goal_node(var1);
  var0 waittill("goal");
  var0 scripts\engine\sp\utility::set_goal_radius(400);
  var0 scripts\engine\sp\utility::set_goal_entity(level.player);
}

function bar_price_handler() {
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  thread bar_shootout_price_advance();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_shootout_enemies_cleared();
  level.price scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_wait_any("flag_bar_shootout_enemies_dead", "flag_bar_shootout_player_exit");
  level.price.dontmelee = 0;
  level.price scripts\common\utility::demeanor_override("sprint");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("bar_shootout_move_up_trig", "targetname", "disable");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("push_past_bar_trig", "targetname", "activate");
}

function bar_shootout_price_advance() {
  level endon("flag_bar_shootout_enemies_dead");
  level endon("flag_bar_shootout_price_exit");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_high();
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  scripts\engine\sp\utility::activate_trigger_with_targetname("bar_shootout_initial_price_colors");
  GscBinSkip4(0x35, "bar_shootout_price_advance_1", "script_noteworthy");
}

function trigger_array_wait_then_delete(var0, var1) {
  var2 = getEntArray(var0, var1);

  if(var2.size > 0) {
    scripts\engine\utility::waittill_any_ents_array(var2, "trigger");
    waitframe();
    var2 = getEntArray(var0, var1);

    if(var2.size > 0) {
      scripts\engine\utility::array_delete(var2);
      return;
    }

    return;
  }
}

function bar_shootout_price_pain_handler() {
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  level.price.dontmelee = 1;
  level.price scripts\engine\utility::disable_pain();
  wait 10;
  level.price scripts\engine\utility::enable_pain();
}

function backroom_pre_combat_handler() {
  thread bomb_room_enemies_handler();

  if(!scripts\engine\utility::flag("flag_backroom_player_rushes")) {
    scripts\engine\utility::flag_wait("flag_bomb_room_player_enter");
    var0 = getEnt("price_stacks_on_bombroom_door_colors", "targetname");
    scripts\engine\sp\utility::autosave_by_name("bar_backroom_enter");
    level.price scripts\engine\sp\utility::enable_dontevershoot();
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_enemy_engaged();
    thread bar_backroom_player_kill();
  }

  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  thread bar_shootout_handler();
}

function optional_stealth_handler() {
  level.player endon("weapon_fired");
  var0 = getEnt("price_optional_dialogue_trig", "targetname");

  for(;;) {
    wait 0.2;

    if(level.player istouching(var0)) {
      break;
    }
  }

  scripts\engine\utility::flag_wait("flag_vo_stp_no_step_hadir_line");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_price_on_your_mark();
}

function bar_backroom_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_bomb_room_enemies_dead");
  level endon("flag_bomb_room_enforcer_clear");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  var0 = getEnt("player_bar_backroom_kill_trig", "targetname");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");

  for(;;) {
    if(level.player istouching(var0)) {
      var1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

function bomb_room_enemies_handler() {
  var0 = getEnt("bar_backroom_nosight_clip", "targetname");
  scripts\engine\utility::flag_wait("flag_backroom_player_downstairs");
  scripts\engine\sp\utility::array_spawn_function_targetname("spawner_bomb_room", &scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_enemy_for_price_clean_up);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("backroom_front_enemies", &bomb_room_front_enemies);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("enemy_bomb_room_left", &bomb_room_enemy_anim_new, "enemy1");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("enemy_bomb_room_right", &bomb_room_enemy_anim_new, "enemy4");
  var1 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bomb_room");
  scripts\engine\utility::array_thread(var1, &scripts\engine\sp\utility::set_battlechatter, 0);
  scripts\engine\sp\utility::battlechatter_off("axis");
  var2 = getEnt("enemy_bomb_room_right", "script_noteworthy");
  var2 setModel("body_al_qatala_urban_ar_variants");
  var3 = getEnt("enemy_bomb_room_left", "script_noteworthy");
  var3 setModel("body_al_qatala_urban_ar_variants_2_1");
  var4 = getEnt("backroom_front_enemies", "script_noteworthy");
  var4 setModel("body_al_qatala_urban_lmg_variants_2_1");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_clean_up_last_enemy(var1, randomfloatrange(4, 6));
  thread bomb_room_price_advance(var1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing");
  var1 = scripts\engine\utility::array_removedead_or_dying(var1);
  scripts\engine\utility::array_thread(var1, &scripts\engine\sp\utility::set_battlechatter, 1);
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\utility::array_thread(var1, &scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler, 0.5, 1, "flag_bomb_room_enforcer_clear", 1);

  foreach(var6 in var1) {
    var6 scripts\asm\shared\utility::shouldinitiallyattackfromexposed();
  }

  var0 delete();
  level.player.og_attackeraccuracy = level.player.attackeraccuracy;
  var8 = scripts\common\utility::getdifficulty();

  if(var8 == "medium") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(1.5);
  } else if(var8 == "hard") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(2);
  } else if(var8 == "fu") {
    level.player scripts\sp\utility::set_player_attacker_accuracy(3);
  }

  scripts\engine\utility::flag_wait("flag_bomb_room_enemies_dead");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_back_room_enemies_dead();
  scripts\engine\sp\utility::autosave_by_name("bomb_room_enemies_dead");
  level.player scripts\sp\utility::set_player_attacker_accuracy(level.player.og_attackeraccuracy);
  scripts\engine\utility::trigger_off("trig_price_at_backroom_intro_door", "targetname");
  scripts\engine\utility::trigger_off("price_stacks_on_bombroom_door_colors", "targetname");
}

function bomb_room_front_enemies() {
  self endon("death");
  self endon("entitydeleted");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::set_enemy_low_health();
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  scripts\engine\sp\utility::set_ignoreall(0);
  level notify("cover_blown");
  scripts\engine\sp\utility::set_goal_radius(400);
  scripts\engine\sp\utility::set_goal_ent(level.player);
  self getenemyinfo(level.player);
  scripts\engine\utility::delaycall(0.05, &aieventlistenerevent, "combat", level.player, level.player.origin);
}

function bomb_room_enemy_anim_new(var0) {
  self endon("death");
  self endon("entitydeleted");
  self.animname = var0;
  var1 = scripts\engine\utility::getStruct("backroom_enemies_anim_org", "targetname");
  scripts\engine\sp\utility::set_allowdeath(1);
  scripts\engine\sp\utility::disable_danger_react();
  scripts\engine\sp\utility::disable_surprise();
  self.anim_react_skip_stopanimscripted = 1;
  scripts\sp\maps\stpetersburg\stpetersburg_utility::set_enemy_low_health();
  self.ignoreme = 1;
  var1 thread scripts\common\anim::anim_loop_solo(self, "backroom_idle", "startled");
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  var1 notify("startled");
  self stopanimScripted();
  waitframe();
  self.ignoreme = 0;
  var1 scripts\common\anim::anim_single_solo(self, "backroom_react");
  scripts\engine\sp\utility::set_goalRadius(400);
  var2 = getEnt("enemy_bomb_room_mid_goal", "targetname");
  self setgoalvolumeauto(var2);
  self getenemyinfo(level.player);
  scripts\common\utility::demeanor_override("combat");
  self clearpath();
  self stopanimScripted();
}

function bomb_room_set_enemy_model() {
  var0 = ["body_al_qatala_urban_ar_variants", "body_al_qatala_urban_ar_variants_2_1", "body_al_qatala_urban_lmg"];
  self setModel(scripts\engine\utility::random(var0));
}

function bomb_room_price_advance(var0) {
  level.price scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\utility::flag_wait_any("flag_player_blew_backroom_stealth", "flag_player_shoots_in_backroom", "flag_backroom_butcher_convo_over", "flag_backroom_player_seen_standing", "flag_player_jumps_in_backroom");
  scripts\sp\player::player_movement_state("default");
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price scripts\common\utility::clear_demeanor_override();
  scripts\engine\sp\utility::activate_trigger_with_targetname("enter_bomb_room");
  level.price scripts\engine\utility::disable_pain();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_average();
  scripts\engine\utility::delaythread(12, &scripts\engine\utility::flag_set, "flag_bomb_room_price_advance");

  while(var0.size > 1 && !scripts\engine\utility::flag("flag_bomb_room_price_advance")) {
    var1 = getEntArray("spawner_bomb_room_extra", "targetname");

    if(isDefined(var1) && isalive(var1)) {
      var0 = scripts\engine\utility::array_add(var0, var1);
    }

    var0 = scripts\engine\utility::array_remove_duplicates(var0);
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);
    wait 0.1;
  }

  level.price scripts\engine\utility::enable_pain();
  scripts\engine\sp\utility::activate_trigger_with_targetname("trig_price_advance_bomb_room");
  thread post_bomb_room_price_anim();
}

function post_bomb_room_price_anim() {
  var0 = scripts\engine\utility::getStruct("post_backroom_anim_org", "targetname");
  scripts\engine\utility::flag_wait("flag_bomb_room_enemies_dead");
  level.price scripts\engine\sp\utility::set_ignoreall(0);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_on();
  scripts\engine\sp\utility::activate_trigger_with_targetname("trig_price_ready_to_leave_room");
}

function bar_shootout_main() {
  thread bar_shootout_door_handler();
  thread bar_price_handler();
  thread bar_enforcer_third_handler();
  thread bar_shootout_handler();
}

function bar_shootout_special_mb() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_bar_shootout_player_advance");
  level endon("flag_bar_shootout_enemies_dead");
  scripts\engine\utility::flag_wait("flag_bar_shootout_through_door");
  var0 = getEnt("bar_shootout_player_hide_vol", "targetname");
  var1 = scripts\engine\utility::getStruct("bar_shootout_mb_source", "targetname");
  var2 = scripts\engine\utility::getStructArray("bar_shootout_mb_target", "targetname");
  var3 = getcompleteweaponname("iw8_ar_akilo47");
  var4 = weaponfiretime(var3);
  var5 = weaponclipsize(var3);

  for(;;) {
    wait 0.1;

    if(bar_shootout_player_hiding()) {
      for(var6 = 0; var6 < var5; var6++) {
        if(var2.size > 0) {
          var7 = scripts\engine\sp\utility::get_closest_to_player_view(var2, level.player, 1);
        } else {
          return;
        }

        if(bar_shootout_player_hiding()) {
          magicbullet(var3, var1.origin, var7.origin);
          var2 = scripts\engine\utility::array_remove(var2, var7);
        } else {
          wait 1;
        }

        wait var4 * randomfloatrange(1, 3);
      }

      return;
    }
  }
}

function bar_shootout_player_hiding() {
  var0 = getEnt("bar_shootout_player_hide_vol", "targetname");

  if(level.player istouching(var0) && level.player getstance() != "stand" && level.player playermount() < 0.5) {
    return true;
  }

  return false;
}

function bar_shootout_exit_alley_door_handler() {
  var0 = getEnt("bar_alley_exit_door", "targetname");
  var1 = getEnt("bar_alley_exit_door_clip", "targetname");
  var2 = getEntArray("alley_junk", "targetname");
  var3 = getEntArray("alley_junk_clip", "targetname");

  foreach(var5 in var2) {
    if(isDefined(var5)) {
      var5 delete();
    }
  }

  var0 delete();

  foreach(var5 in var3) {
    if(isDefined(var5)) {
      var5 movez(-512, 0.15, 0.05, 0.05);
    }
  }

  var1 movez(-512, 0.15, 0.05, 0.05);
  wait 0.2;
  var1 connectpaths();

  foreach(var5 in var3) {
    if(isDefined(var5)) {
      var5 connectpaths();
    }
  }
}

function bar_shootout_handler() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_shootout_through_door();
  thread bar_interior_exit_door_handler();
  thread bar_shootout_player_kill();
  thread bar_shootout_exit_alley_door_handler();
  thread bar_shootout_enemies();
  thread bar_street_swap_corpses_with_trash();
  thread bar_shootout_special_mb();
  thread kitchen_toggle_containment();
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_bar_shootout_through_door", 15);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_bar_shootout_player_exit", 35, "flag_enforcer_exit_shootout_door", 1, "flag_bar_shootout_enemies_dead");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_player_exit_club", 30, undefined, 1, "flag_aq_ambusher_dead");
}

function bar_shootout_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_shootout_turn_off_player_kill");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  level.enforcer endon("death");
  var0 = getEnt("player_bar_shootout_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      var1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

function bar_shootout_door_handler() {
  var0 = scripts\sp\door::get_interactive_door("bar_new_entrance_door");
  var0 scripts\game\sp\door::remove_door_c4_ability();
  var0.script_max_left_angle = 110;
  var0.script_max_right_angle = 110;
  var0 scripts\sp\door::init_max_yaws();
  scripts\engine\utility::flag_wait("flag_player_exit_back_room");
  thread bar_shootout_door_close();
  thread bar_shootout_door_bash_monitor();
  thread bar_shootout_door_sight_trace_monitor();
  scripts\engine\utility::flag_wait_any("flag_bar_shootout_through_door", "flag_bar_shootout_bash_door");
  var1 = getEnt("bar_shootout_door_clip", "targetname");
  var1 movez(-256, 0.1, 0.05, 0.05);
  var1 connectpaths();
  wait 0.2;
  var1 delete();
}

function bar_shootout_door_close() {
  level endon("flag_bar_shootout_through_door");
  level endon("flag_bar_shootout_bash_door");
  scripts\sp\door::door_close(level.enforcer, 1.5, 0.2, 1);
  scripts\engine\utility::flag_set("flag_bar_shootout_close_door");
  scripts\sp\door::reset_door();
  scripts\engine\utility::waittill_any("bashed", "open_completely", "first_interact");
  scripts\engine\utility::flag_set("flag_bar_shootout_enter");
}

function bar_shootout_door_bash_monitor() {
  level endon("flag_bar_shootout_through_door");
  level endon("flag_bar_shootout_close_door");
  scripts\engine\utility::flag_wait("flag_bar_shootout_bash_door");

  if(level.player issprinting()) {
    scripts\sp\door::door_bash_open(level.player);
  } else {
    scripts\sp\utility::door_force_open_fully();
  }

  scripts\engine\utility::flag_set("flag_bar_shootout_enter");
}

function bar_shootout_door_sight_trace_monitor() {
  level endon("missionfailed");
  level endon("flag_bar_shootout_enter");
  var0 = getaiarray("axis");

  for(;;) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);

    foreach(var2 in var0) {
      var3 = sighttracepassed(level.player getEye(), var2 getEye(), 0, undefined);
      var4 = scripts\engine\sp\utility::within_fov_of_players(var2 getEye(), cos(45));

      if(var3 == 1 && var4 == 1) {
        scripts\engine\utility::flag_set("flag_bar_shootout_enter");
        break;
      }
    }

    waitframe();
  }
}

function bar_shootout_enemies() {
  scripts\engine\sp\utility::array_spawn_function_targetname("spawner_bar_retreat_enemies", &bar_shootout_aq_retreater);
  var0 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bar_retreat_enemies", 1);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("spawner_bar_enemies", &bar_ai_combat_behavior);
  var1 = scripts\engine\sp\utility::array_spawn_noteworthy("spawner_bar_enemies", 1);
  thread bar_pooltable_aq_anim();
  thread bar_right_aq_anim();
  thread bar_back_aq_anim();
  scripts\engine\utility::flag_wait("flag_bar_shootout_enter");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_shootout_entrance();
  setmusicstate("mx_stpete_tmp_bar_tension");
  level.bar_shootout_aq = scripts\engine\utility::array_combine(var1, var0);
  level.bar_shootout_aq = scripts\engine\utility::array_removedead_or_dying(level.bar_shootout_aq);
  scripts\engine\utility::array_thread(level.bar_shootout_aq, &scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler, 0.5, 1, ["flag_bar_shootout_one_dead", "flag_bar_shootout_player_advance"]);
  thread bar_shootout_ai_dead_check();
  thread bar_shootout_retreat_enemy_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_clean_up_last_enemy(level.bar_shootout_aq, randomfloatrange(8, 10));
  waitframe();
  scripts\engine\utility::waittill_any_ents_array(level.bar_shootout_aq, "death");
  scripts\engine\utility::flag_set("flag_bar_shootout_one_dead");
  scripts\engine\utility::flag_wait("flag_player_exit_club");
  level.bar_shootout_aq = scripts\engine\utility::array_removedead_or_dying(level.bar_shootout_aq);
  scripts\engine\utility::array_delete(level.bar_shootout_aq);
}

function bar_shootout_ai_dead_check() {
  level endon("flag_player_exit_club");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::waittill_alive_count(level.bar_shootout_aq, 2);
  scripts\engine\utility::flag_set("flag_bar_shootout_some_enemies_dead");
}

function bar_ai_combat_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("bar_mid_goal", "targetname");
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
  scripts\engine\utility::delaythread(2.3, &scripts\engine\sp\utility::disable_dontevershoot);

  if(isDefined(self.target)) {
    scripts\engine\utility::waittill_any("goal", "damage", "whizby");
  }

  if(isDefined(self.script_goalvolume)) {
    self setgoalvolumeauto(var0);
    scripts\engine\sp\utility::trigger_wait_targetname("enforcer_exit_to_alley_trig");

    if(isalive(self)) {
      self.diequietly = 1;
      scripts\engine\sp\utility::die();
      return;
    }

    return;
  }
}

function bar_shootout_enemy_shot_earlier() {
  level endon("missionfailed");
  level endon("flag_bar_shootout_enter");
  scripts\engine\utility::waittill_any("damage", "whizby", "death");
  scripts\engine\utility::flag_set("flag_shootout_enemies_shot_early");
}

function bar_shootout_aq_regular() {
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

function bar_shootout_aq_retreater() {
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
    return;
  }
}

function bar_shootout_retreat_enemy_handler() {
  scripts\engine\utility::flag_wait("flag_enforcer_exit_shootout_door");
  var0 = scripts\engine\sp\utility::get_living_ai_array("spawner_bar_retreat_enemies", "targetname");

  foreach(var2 in var0) {
    thread bar_shootout_send_retreater_to_goal(var2);
  }

  scripts\engine\utility::flag_wait_any("flag_bar_shootout_some_enemies_dead", "flag_bar_shootout_player_advance");
  var4 = scripts\engine\sp\utility::array_spawn_targetname("spawner_bar_reinforce_enemies", 1);
  level.bar_shootout_aq = scripts\engine\utility::array_combine(level.bar_shootout_aq, var4);
}

function bar_shootout_send_retreater_to_goal(var0) {
  self endon("death");
  self endon("entitydeleted");
  var1 = getnode("node_enforcer_club_exited", "targetname");
  var2 = getnode("bar_kitchen_doorway_node", "targetname");
  wait 1;

  if(var0 == 0) {
    scripts\engine\sp\utility::set_goal_node(var1);
    scripts\engine\sp\utility::set_goalRadius(16);
    scripts\engine\utility::disable_pain();
    scripts\engine\sp\utility::set_ignoreme(1);
    scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\sp\utility::set_pacifist(1);
    waitframe();
    self waittill("goal");
    var3 = 0;
    var3 = sighttracepassed(level.player getEye(), self getEye(), 0, undefined);

    if(var3 == 1) {
      scripts\engine\utility::enable_pain();
      scripts\engine\sp\utility::set_ignoreme(0);
      scripts\engine\sp\utility::set_ignoreall(0);
      scripts\engine\sp\utility::set_pacifist(0);
      scripts\engine\sp\utility::set_goal_pos(self.origin);
      return;
    }

    self delete();
    return;
  }

  self.combatmode = "ambush";
  scripts\engine\sp\utility::set_pacifist(0);
  scripts\engine\sp\utility::set_goalRadius(32);
  self setgoalvolumeauto(getEnt("last_guy_goal", "targetname"));
  self getenemyinfo(level.player);
}

function bar_shootout_aq_fallback() {
  self endon("death");
  self endon("death");
  var0 = getEnt("bar_back_goal", "targetname");
  var1 = scripts\engine\utility::getStruct("bar_shootout_fallback_org", "targetname");
  self notify("fallback");
  self cleargoalvolume();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\sp\utility::set_goal_pos(var1.origin);
  scripts\sp\maps\stpetersburg\stpetersburg_utility::set_enemy_low_health();
}

function kitchen_aq_shoots_down_stairs() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_shootout_approaching_kitchen();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("aq_ambusher", &kitchen_aq_ambusher_fallback);
  var0 = scripts\engine\sp\utility::spawn_script_noteworthy("aq_ambusher", 1);
  var0.ignoreall = 1;
  var0.ignoreme = 1;
  var0 scripts\engine\sp\utility::disable_long_death();
  var0 scripts\engine\sp\utility::set_battlechatter(1);
  var0.script_ammo_clip = 100;
  var0.script_ammo_extra = 100;
  level.price scripts\engine\utility::disable_pain();
  scripts\engine\utility::flag_wait_any("flag_price_triggers_ambusher_blindfire", "flag_ambusher_blindfire_start");
  var1 = scripts\sp\utility::make_weapon("iw8_sm_papa90", ["holo_west01"]);
  var0 scripts\anim\shared::forceuseweapon(var1, "primary");
  thread kitchen_aq_ambusher_magicbullet();
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_set_accuracy_average();
  scripts\engine\utility::flag_wait("flag_kitchen_aq_shoots_down_stairs");

  if(isalive(var0)) {
    var0.ignoreall = 0;
    var0.ignoreme = 0;
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_shootout_kitchen_clear();
  scripts\engine\sp\utility::wait_for_flag_or_timeout("flag_aq_ambusher_dead", 6);
  scripts\engine\sp\utility::activate_trigger_with_targetname("move_price_up_bar_backstairs_trig");
  thread bar_street_main();
}

function kitchen_aq_ambusher_magicbullet() {
  self endon("death");
  level endon("flag_ambusher_blindfire_end");
  var0 = scripts\engine\utility::getStruct("ambusher_magicbullet_start", "targetname");
  var1 = [];
  GscBinSkip0(0x2e, 0, scripts\engine\utility::getStruct("ambusher_magicbullet_end_1", "targetname"));
}

function kitchen_aq_ambusher_fallback() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("flag_bar_price_at_stairs", "flag_kitchen_aq_shoots_down_stairs");
  scripts\engine\sp\utility::wait_for_flag_or_timeout("flag_aq_ambusher_dead", 4);
  var0 = getnode("ambusher_fallback", "targetname");
  scripts\engine\sp\utility::set_goal_radius(16);
  scripts\engine\sp\utility::set_goal_node(var0);
  scripts\engine\utility::disable_pain();
  self waittill("goal");
  scripts\engine\utility::enable_pain();
}

function bar_street_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("flag_bar_street_enter", "stpetersburg_alley_script_tr", "stpetersburg_apartment_script_tr");
  scripts\engine\utility::exploder("pool_fx");
  thread scripts\sp\analytics::analytics_kleenex_update("Bar street to canal");
  thread bar_street_price_intro_gopath();
  thread bar_street_dead_bodies();
  thread bar_street_turn_car_alarms_off();
  thread bar_street_timer_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_street_civilians();
  thread bar_street_combat_handler();
  thread bar_street_fleeing_civs_vignettes();
  thread bar_street_enforcer_flee();
  thread bar_street_player_kill();
  thread bar_street_swap_corpses_with_trash();
  scripts\engine\utility::flag_wait_any("flag_bar_street_aq_all_dead", "flag_bar_street_player_near_apt");
  scripts\engine\utility::flag_set("flag_bar_street_end");
}

function bar_street_swap_corpses_with_trash() {
  if(scripts\engine\utility::flag("flag_bar_street_alley_corpses_bagged")) {
    return;
  }

  scripts\engine\utility::flag_set("flag_bar_street_alley_corpses_bagged");
  var0 = getEnt("alley_stealth_trash_bag_clip", "targetname");
  var1 = getEntArray("alley_stealth_trash_bag", "targetname");
  var0 movez(256, 0.1, 0.05, 0.05);
  var0 disconnectPaths();

  foreach(var3 in var1) {
    thread bar_street_garbage_bag_place();
  }
}

function bar_street_garbage_bag_place() {
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

function bar_street_garbage_bag_blood() {
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_apartment_enforcer_stairs_vignette")) {
    self waittill("damage", var0, var1, var2, var3, var4);

    if(scripts\engine\utility::cointoss()) {
      playFX(scripts\engine\utility::getfx("vfx_blood_hit_01"), var3, var2 + scripts\engine\utility::randomvectorrange(0, 20));
    } else {
      playFX(scripts\engine\utility::getfx("vfx_bd_blood_hit_01"), var3, var2 + scripts\engine\utility::randomvectorrange(0, 20));
    }

    playFX(scripts\engine\utility::getfx("vfx_stpburg_blood_splat_light"), var3, var2 + scripts\engine\utility::randomvectorrange(0, 20));
    wait 0.1;
  }
}

function bar_street_dead_bodies() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_dead_bodies("bar_street_dead_bodies", "flag_apartment_grenade_explosion");
}

function bar_street_extra_car() {
  var0 = scripts\common\vehicle::spawn_vehicles_from_targetname("bar_street_extra_car");
  waitframe();

  foreach(var2 in var0) {
    var2.dontdisconnectpaths = 1;
    var2.script_badplace = 1;
    var2 scripts\common\vehicle_code::vehicle_remove_badplace();

    if(var2.classname == "script_vehicle_iw8_car_civilian_skilo_blue") {
      var2.animname = "skilo";
      var2 scripts\common\anim::anim_last_frame_solo(var2, "fr_door_open");
      continue;
    }

    if(var2.classname == "script_vehicle_iw8_decho_green") {
      var2.animname = "decho";
      var2 scripts\common\anim::anim_last_frame_solo(var2, "fl_door_open");
    }
  }
}

function bar_street_turn_car_alarms_off() {
  var0 = getscriptablearray("street_no_alarm_vehicles", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("car_alarm", "off");
  }
}

function bar_street_enforcer_spawn() {
  level.enforcer endon("death");
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::spawn_enforcer("node_enforcer_alley");
  level.enforcer scripts\engine\utility::disable_pain();
  level.enforcer scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  level.price scripts\common\utility::demeanor_override("sprint");
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer.ignoreall = 0;
  level.enforcer.ignoreme = 0;
}

function bar_street_timer_handler() {
  level endon("flag_bar_street_end");
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_street_wheres_enforcer();
  setmusicstate("mx_stpete_tmp_bar_street_chase");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_bar_street_player_at_corner", 20, undefined, 0);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_in_apt");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pursuit_timer("flag_bar_street_player_near_apt", 35, undefined, 0);
}

function bar_street_fleeing_civs_vignettes() {
  scripts\engine\utility::flag_wait_any("flag_enforcer_run_into_alley", "flag_player_near_exit_club");
  thread street_couple_vig();
  thread street_backshot_vig();
  thread street_civ_run_cower_vig();
  thread street_civ_run_cower_handler();
  thread street_civ_mag_bullet();
  var0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_civ_flee", 1);

  foreach(var2 in var0) {
    var2 scripts\asm\asm_bb::bb_setcivilianstate("panic");
  }

  wait 3.5;
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  foreach(var2 in var0) {
    var2 kill();
    wait 0.1;
  }
}

function street_civ_run_cower_handler() {
  level endon("flag_apartment_end");
  level endon("entitydeleted");
  level endon("death");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("bar_street_civ_cower_04", &street_civ_cower_04_behavior);
  scripts\engine\sp\utility::array_spawn_targetname("bar_street_civ_cower", 1);
  scripts\engine\utility::flag_wait("flag_apartment_enforcer_grenade_vignette");
  var0 = scripts\engine\sp\utility::get_living_ai_array("bar_street_civ_cower", "targetname");
  scripts\engine\utility::array_delete(var0);
}

function street_civ_cower_01_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var0 = scripts\engine\utility::getStruct("bar_street_civ_cower_01_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait randomfloatrange(0.2, 1);
  var0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var0 notify("ender");
}

function street_civ_cower_02_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var0 = scripts\engine\utility::getStruct("bar_street_civ_cower_02_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait randomfloatrange(0.2, 1);
  var0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower_alt", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var0 notify("ender");
}

function street_civ_cower_03_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var0 = scripts\engine\utility::getStruct("bar_street_civ_cower_03_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 6;
  wait randomfloatrange(0.2, 1);
  var0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var0 notify("ender");
}

function street_civ_cower_04_behavior() {
  level endon("flag_apartment_end");
  self endon("entitydeleted");
  self endon("death");
  var0 = scripts\engine\utility::getStruct("bar_street_civ_cower_04_anim_org", "targetname");
  self.animname = "generic";
  scripts\engine\sp\utility::set_allowdeath(1);
  wait 3;
  wait randomfloatrange(0.2, 1);
  var0 thread scripts\common\anim::anim_loop_solo(self, "bar_street_civ_cower_alt2", "ender");
  scripts\engine\utility::flag_wait("flag_apartment_end");
  var0 notify("ender");
}

function street_civ_run_cower_vig() {
  var0 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("streetciv_gate", 1);
  var1.animname = "civ03";
  var1 endon("entitydeleted");
  var1 endon("death");
  var1 setModel("body_civ_london_female_8_1");
  var1 scripts\engine\utility::delaythread(4, &scripts\engine\sp\utility::set_allowdeath, 1);
  var0 scripts\common\anim::anim_single_solo(var1, "bar_street_flee");
  var1.civ_ff_idle = 1;
  var0 thread scripts\common\anim::anim_loop_solo(var1, "bar_street_flee_idle");
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function street_backshot_vig() {
  var0 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("streetciv_run", 1);
  var1 scripts\engine\utility::delaythread(4, &scripts\engine\sp\utility::set_allowdeath, 1);
  var1.animname = "streetciv01";
  wait 0.1;
  var0 scripts\common\anim::anim_single_solo(var1, "stp_bar_street_run");
  var0 scripts\common\anim::anim_last_frame_solo(var1, "stp_bar_street_run");
  waitframe();
  var1.forceragdollimmediate = 1;
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::set_allowdeath(1);
  var1.skipdeathanim = 1;
  var1 scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function street_couple_vig() {
  var0 = scripts\engine\sp\utility::spawn_targetname("streetcivcouple_civ01", 1);
  var0 setModel("body_civ_stpeterburg_male_4_1");
  var0 endon("death");
  var0 endon("entitydeleted");
  var0.allowdeath = 1;
  var0.animname = "streetcouplemale";
  var1 = scripts\engine\sp\utility::spawn_targetname("streetcivcouple_civ02", 1);
  var1 setModel("body_civ_stpeterburg_female_1_1");
  var1 endon("death");
  var1 endon("entitydeleted");
  var1.allowdeath = 1;
  var1.animname = "streetcouplefemale";
  var2 = scripts\engine\utility::getStruct("streetciv_struct02", "targetname");
  var3 = [var0, var1];
  var2 scripts\common\anim::anim_single(var3, "stp_bar_street_couple_run");
  var0.civ_ff_idle = 1;
  var1.civ_ff_idle = 1;
  var2 thread scripts\common\anim::anim_loop(var3, "stp_bar_street_couple_idle");
  scripts\engine\utility::flag_wait("flag_bar_street_civs_cleanup");
  scripts\engine\utility::array_delete(var3);
}

function street_civs_flee(var0, var1, var2, var3, var4) {
  wait var4;
  var5 = scripts\engine\sp\utility::spawn_targetname(var0, 1);
  var5.animname = var2;
  var1 = scripts\engine\utility::getStruct(var1, "targetname");
  var1 scripts\common\anim::anim_single_solo(var5, "bar_street_flee", undefined, var3);
  playFXOnTag(scripts\engine\utility::getfx("vfx_blood_hit_01"), var5, "j_head");
  waitframe();
  var5 kill();
}

function street_death_civ_vig() {
  scripts\engine\sp\utility::wait_for_targetname_trigger("streetciv_trigger2");
  var0 = scripts\engine\sp\utility::spawn_targetname("streetciv_dead", 1);
  var0.animname = "streetcivdead";
  var1 = scripts\engine\utility::getStruct("streetciv_struct01", "targetname");
  var1 scripts\common\anim::anim_single_solo(var0, "stp_bar_street_shot");
  var1 scripts\common\anim::anim_last_frame_solo(var0, "stp_bar_street_shot");
  var0 visiblenotsolid();
}

function bar_street_combat_handler() {
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  thread bar_street_mag_bullet();
  level.player scripts\engine\sp\utility::set_ignoreme(1);
  scripts\engine\sp\utility::array_spawn_function_targetname("bar_street_aq", &bar_street_ai_combat_behavior);
  scripts\engine\sp\utility::array_spawn_function_targetname("bar_street_aq", &scripts\sp\maps\stpetersburg\stpetersburg_utility::setup_enemy_for_price_clean_up);
  var0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_aq");
  thread bar_street_aq_handler(var0);
  thread bar_street_price_handler();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::price_clean_up_last_enemy(var0, randomfloatrange(10, 15));
  scripts\engine\utility::flag_wait("flag_bar_street_player_at_corner");
  scripts\engine\utility::flag_wait_or_timeout("flag_bar_street_around_corner", 3);
  level.player scripts\engine\sp\utility::set_ignoreme(0);
}

function bar_street_ai_combat_behavior() {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_street_combat_behavior");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::set_attackeraccuracy_handler(0.5, 1, ["flag_bar_street_enforcer_to_apt", "flag_bar_street_around_corner"]);
  scripts\engine\sp\utility::set_goalRadius(32);
  scripts\engine\sp\utility::set_battlechatter(1);

  if(isDefined(self.target)) {
    self waittill("goal");
  }

  scripts\engine\sp\utility::set_goalRadius(800);
  scripts\engine\sp\utility::set_goal_entity(level.player);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_to_apt");
  wait randomfloatrange(5, 8);

  if(scripts\engine\utility::cointoss()) {
    self.favoriteenemy = level.player;
  }

  wait randomfloatrange(8, 12);
  scripts\engine\sp\utility::set_goalRadius(500);

  while(self.goalradius > 100) {
    wait randomfloatrange(2, 5);
    self.goalradius -= 100;
  }
}

function bar_street_aq_handler(var0) {
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  thread bar_street_aq_door_extra();
  thread bar_street_aq_door(var0);
  thread bar_street_aq_hangback();
  thread bar_street_aq_death_check(var0);
}

function bar_street_aq_death_check(var0) {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::waittill_alive_count(var0, 2);
  scripts\engine\utility::flag_set("flag_bar_street_aq_some_dead");
}

function bar_street_aq_door(var0) {
  var1 = getEnt("bar_street_enemy_back_vol", "targetname");
  var2 = undefined;

  while(!isDefined(var2)) {
    var2 = getEnt("bar_street_aq_door", "script_noteworthy");
    waitframe();
  }

  var2 scripts\engine\sp\utility::set_goalRadius(16);
  scripts\engine\utility::flag_wait("flag_bar_street_enforcer_to_apt");

  if(isDefined(var2)) {
    var2 endon("death");
    var2 endon("entitydeleted");
    var2 scripts\engine\sp\utility::set_goal_pos(var2.origin);
    var2 notify("stop_street_combat_behavior");
    wait 2;
    var2 scripts\common\utility::demeanor_override("sprint");
    var2 setgoalvolumeauto(var1);
    wait randomfloatrange(2, 5);
  }

  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  var2 delete();
}

function bar_street_aq_hangback() {
  var0 = getEnt("bar_street_enemy_hangback_vol", "targetname");
  var1 = undefined;

  while(!isDefined(var1)) {
    var1 = getEnt("bar_street_aq_hangback", "script_noteworthy");
    waitframe();
  }

  var1.animname = "generic";
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 scripts\engine\sp\utility::set_ignoreme(1);
  var2 = scripts\engine\utility::getStruct("bar_street_aq_car_climb_org", "targetname");
  var3 = getanimlength(var1 scripts\engine\utility::getanim("traverse_stepup_52"));
  var3 = 2.5;
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var2 scripts\sp\anim::anim_reach_solo(var1, "traverse_stepup_52");

  if(!scripts\engine\utility::flag("flag_bar_street_player_near_apt")) {
    var1 scripts\engine\sp\utility::set_allowdeath(1);
    var1.skipdeathanim = 1;
    var2 thread scripts\common\anim::anim_single_solo(var1, "traverse_stepup_52");
    wait var3;
    var1 scripts\engine\sp\utility::anim_stopanimScripted();
    var4 = getnode("bar_street_aq_car_climb_node", "targetname");
    var1 scripts\engine\sp\utility::set_goal_node(var4);
    var1 waittill("goal");
    var1.skipdeathanim = undefined;
    var5 = scripts\engine\utility::spawn_tag_origin(var4.origin, var4.angles);
    var1 linkTo(var5);
    scripts\engine\utility::flag_wait_any_timeout(5, "flag_bar_street_player_near_apt", "flag_bar_street_aq_some_dead");
    wait randomfloatrange(2, 5);
    var1 scripts\engine\sp\utility::set_ignoreme(0);
  }

  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  var1 delete();
}

function bar_street_aq_door_extra() {
  scripts\engine\utility::flag_wait_any("flag_bar_street_player_advance", "flag_bar_street_aq_some_dead");
  var0 = scripts\engine\sp\utility::array_spawn_targetname("bar_street_aq_extra");
  scripts\engine\utility::flag_wait("flag_apartment_grenade_explosion");
  scripts\engine\utility::array_delete(var0);
}

function bar_street_price_intro_gopath() {
  scripts\engine\utility::flag_wait("flag_enforcer_run_into_alley");
  scripts\engine\sp\utility::trigger_wait_targetname("price_street_runto_start");
  level.price scripts\engine\sp\utility::disable_ai_color();
  level.price scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("price_street_intro_runto", "targetname"));
  level.price scripts\engine\sp\utility::set_goal_radius(64);
  level.price scripts\engine\sp\utility::enable_ai_color();
}

function bar_street_price_handler() {
  scripts\sp\maps\stpetersburg\stpetersburg_utility::price_push_off();
  level.price scripts\engine\sp\utility::enable_dontevershoot();
  level.price.ignoreall = 1;
  bar_street_price_wait();
  level.price scripts\engine\sp\utility::disable_dontevershoot();
  level.price.ignoreall = 0;
  level.price scripts\engine\utility::enable_pain();
  thread bar_street_price_advance();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_street_enemies_cleared();
  level.price scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::flag_wait_any("flag_bar_street_aq_all_dead", "flag_bar_street_player_near_apt");
  level.price.dontmelee = 0;
  scripts\sp\maps\stpetersburg\stpetersburg_utility::trigger_safe_function("bar_street_triggers", "script_noteworthy", "disable");
}

function bar_street_price_wait() {
  level endon("flag_bar_street_player_near_apt");
  level.price endon("goal");

  for(;;) {
    waitframe();
  }
}

function bar_street_price_advance() {
  level endon("flag_bar_street_end");
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  GscBinSkip4(0x35, "bar_street_price_advance_1", "targetname");
}

function street_civ_mag_bullet() {
  level endon("flag_bar_street_enter");
  level endon("flag_bar_street_price_at_corner");
  scripts\engine\sp\utility::wait_for_targetname_trigger("streetciv_trigger");
  var0 = scripts\engine\utility::getStruct("street_civ_magicbullet_start", "targetname");
  var1 = scripts\engine\utility::getStruct("street_civ_magicbullet_end", "targetname");
  var2 = getcompleteweaponname("iw8_ar_akilo47");
  var3 = weaponfiretime(var2);
  var4 = weaponclipsize(var2);

  for(var5 = 0; var5 < var4; var5++) {
    magicbullet(var2, var0.origin, var1.origin + scripts\engine\utility::randomvectorrange(0, 20));
    wait var3 * randomfloatrange(1, 3);
  }
}

function bar_street_mag_bullet() {
  level endon("flag_bar_street_player_at_corner");
  level endon("flag_bar_street_price_at_corner");
  scripts\engine\sp\utility::wait_for_targetname_trigger("price_moves_out_to_bar_street_colors");
  var0 = scripts\engine\utility::getStruct("street_pursuit_magicbullet_start", "targetname");
  var1 = scripts\engine\utility::getStruct("street_pursuit_magicbullet_end", "targetname");
  var2 = getcompleteweaponname("iw8_ar_akilo47");
  var3 = weaponfiretime(var2);
  var4 = weaponclipsize(var2);

  for(var5 = 0; var5 < var4; var5++) {
    magicbullet(var2, var0.origin, var1.origin + scripts\engine\utility::randomvectorrange(0, 20));
    wait var3 * randomfloatrange(1, 3);
  }
}

function bar_street_enforcer_flee() {
  level.enforcer endon("death");
  var0 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.enforcer scripts\anim\shared::forceuseweapon(var0, "primary");
  var1 = scripts\engine\utility::getStruct("bar_street_enforcer_run_org", "targetname");
  var1 scripts\common\anim::anim_first_frame_solo(level.enforcer, "bar_street_run_3");
  scripts\engine\utility::flag_wait("flag_bar_street_enter");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::enforcer_safe_run();
  level.enforcer scripts\common\utility::demeanor_override("sprint");
  level.enforcer scripts\engine\sp\utility::set_goal_radius(32);
  level.enforcer endon("death");
  level.enforcer scripts\engine\sp\utility::set_ignoreall(1);
  level.enforcer scripts\engine\sp\utility::enable_dontevershoot();
  var2 = 0;

  while(var2 == 0 && !scripts\engine\utility::flag("flag_bar_street_player_at_corner")) {
    var2 = sighttracepassed(level.player gettagorigin("j_gun"), level.enforcer getEye(), 0, undefined);
    waitframe();
  }

  var1 thread scripts\common\anim::anim_single_solo_run(level.enforcer, "bar_street_run_3");
  wait 1;
  scripts\engine\utility::flag_set("flag_bar_street_enforcer_to_apt");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_bar_street_enforcer_flee();
  var3 = scripts\engine\utility::getStruct("struct_enforcer_bar_street_to_apartment", "targetname");
  level.enforcer scripts\sp\spawner::go_to_node(var3);
  var4 = getnode("apartment_stairs_blindfire_position", "targetname");
  level.enforcer scripts\engine\sp\utility::teleport_ai(var4);
  scripts\engine\utility::flag_set("flag_bar_street_enforcer_in_apt");
}

function bar_street_player_kill() {
  level endon("mission_fail");
  level.player endon("death");
  level endon("flag_bar_street_enforcer_in_apt");
  level.enforcer endon("death");

  while(!isDefined(level.enforcer)) {
    waitframe();
  }

  var0 = getEnt("player_bar_street_kill_trig", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      var1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * -10;
      magicbullet("iw8_ar_akilo47", var1, level.player getEye(), level.enforcer);
      level.player kill();
      break;
    }

    wait 0.2;
  }
}

function bar_street_enforcer_mb() {
  level.enforcer endon("death");
  level.enforcer endon("stop_shooting");
  var0 = getanimlength(level.enforcer scripts\engine\utility::getanim("bar_street_run_2"));
  level.enforcer thread scripts\engine\sp\utility::notify_delay("stop_shooting", var0);
  wait 0.1;
  var1 = getcompleteweaponname("iw8_ar_akilo47");
  var2 = weaponfiretime(var1);
  var3 = weaponclipsize(var1);
  var4 = level.enforcer gettagorigin(getweaponflashtagname(var1));
  var5 = level.enforcer gettagangles(getweaponflashtagname(var1));
  var6 = var4 + anglesToForward(var5) * 100;

  for(var7 = 0; var7 < var3; var7++) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), level.enforcer, getweaponflashtagname(var1));
    magicbullet("iw8_ar_akilo47", var4, var6 + scripts\engine\utility::randomvectorrange(0, 5), level.enforcer);
    wait var2 * 2;
  }
}

function move_enforcer_fake_target() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var0 = randomfloatrange(2, 4);
    self movez(64, var0);
    wait var0;
    var1 = randomfloatrange(2, 6);
    self movez(-64, var1);
    wait var1;
  }
}

function alley_stealth_price_takedown_fire() {
  level endon("missionfailed");
  level.player endon("death");
  level.price endon("death");
  level endon("alley_alert");
  level.price scripts\common\ai::gun_recall();
  wait 0.8;
  var0 = getcompleteweaponname("iw8_pi_golf21", ["silencerpstl_west01"]);

  for(var1 = 0; var1 < 3; var1++) {
    var2 = level.price gettagorigin(getweaponflashtagname(var0));
    var3 = level.price gettagangles(getweaponflashtagname(var0));
    var4 = var2 + anglesToForward(var3) * 100;
    magicbullet(var0, var2, var4, level.price);
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), level.price, getweaponflashtagname(var0));
    wait 0.2;
  }

  wait 0.8;
  var2 = level.price gettagorigin(getweaponflashtagname(var0));
  var3 = level.price gettagangles(getweaponflashtagname(var0));
  var4 = var2 + anglesToForward(var3) * 100;
  magicbullet(var0, var2, var4, level.price);
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), level.price, getweaponflashtagname(var0));
}

function intro_scene_camera() {
  level endon("stop_intro_end");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  thread scripts\sp\maps\stpetersburg\stpetersburg_lighting::flycam_intro_start();
  thread intro_scene_bink();
  thread intro_scene_fake_player();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::put_player_into_cam_rig(level.player.rig, 0.25, 0, 0, 0, 0);
  thread scripts\engine\utility::flag_set_delayed("flag_stakeout_camera_in_apartment", 6);
  scripts\sp\hud_util::start_overlay();
  scripts\engine\utility::delaythread(0.5, &scripts\sp\hud_util::fade_in, 0.5);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player lerpfovscalefactor(0, 0);
  level.player lerpfov(45.48, 0.001);
  var0 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
  var0 scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_intro");
  var0 scripts\common\anim::anim_last_frame_solo(level.player.rig, "new_camera_intro");
  level.player unlink();
  var1 = level.player.rig scripts\engine\utility::getanim("new_camera_window");
  var2 = getstartorigin(var0.origin, var0.angles, var1);
  var3 = getstartangles(var0.origin, var0.angles, var1);
  level.player setOrigin(var2);
  level.player setplayerangles(var3);
  var0 scripts\common\anim::anim_first_frame_solo(level.player.rig, "new_camera_window");
  level.player playerlinktoabsolute(level.player.rig, "tag_player");
  var0 notify("stop_first_frame");
  level.player lerpfov(50, 0.001);
  var0 scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_window");
  thread intro_scene_end(0);
}

function intro_scene_end(var0) {
  level notify("stop_intro_end");
  level endon("stop_intro_end");

  if(var0) {
    level.player lerpfov(65, 0.1);
    scripts\engine\utility::flag_set("intro_bink_done");
    scripts\engine\utility::flag_set("flag_stakeout_camera_finished");
    var1 = scripts\engine\utility::getStruct("enforcer_truck_anim_org", "targetname");
    var1 thread scripts\common\anim::anim_single_solo(level.player.rig, "new_camera_window");
    level.player.rig setanimtime(level.player.rig scripts\engine\utility::getanim("new_camera_window"), 0.8);
    level.player.rig waittillmatch("single anim", "end");
  }

  scripts\engine\utility::flag_wait("flag_stakeout_fake_player_deleted");
  scripts\sp\maps\stpetersburg\stpetersburg_utility::pull_player_out_of_rig_hide_rig(level.player.rig);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  level.player scripts\common\utility::allow_cinematic_motion(1);
  level.player lerpfovscalefactor(1, 1.5);
  level notify("slam_zoom_complete");
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::flag_set("flag_stakeout_camera_finished");
  level.price scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::name_show);
  level.nikolai scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::name_show);
  scripts\engine\sp\utility::autosave_by_name("intro_stakeout_start");
}

function fovshift(var0) {
  wait var0;
  level.player lerpfov(65, 3);
}

function intro_scene_bink() {
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
  wait 2;

  if(!iscinematicplaying()) {
    cinematicingame("sp_st_petersburg_title");
  }

  scripts\engine\utility::flag_wait("flag_stakeout_camera_finished");
  stopcinematicingame();
  scripts\engine\utility::flag_set("intro_bink_done");
  scripts\engine\utility::flag_clear("flag_bink_active");
  level.player enableplayerbreathsystem(1);
  setomnvar("ui_hide_hud", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
}

function cine_letterboxing() {
  level.player setcinematicmotionoverride("disabled");
  hidecinematicletterboxing(0, 0);
  level waittill("cine_letterboxing");
  getrandomnodedestination(1.5, 0);
  level.player clearcinematicmotionoverride();
}

function alley_stealth_aq_create_badplace_in_combat() {
  level endon("flag_alley_stealth_aq_dead");
  self endon("death");
  self endon("entitydeleted");

  while(!scripts\engine\utility::flag("flag_alley_stealth_aq_dead")) {
    var0 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby");

    switch (var0) {
      case "damage":
        var1 = 64;
        var2 = 6;
        break;
      case "bulletwhizby":
        var1 = 32;
        var2 = 4;
        break;
      default:
        var1 = 48;
        var2 = 2;
        break;
    }

    badplace_cylinder("", var2, self.origin, var1, var1, "axis");
    wait randomfloatrange(3, 5);
  }
}

function alley_stealth_aq_create_badplace_on_death() {
  self endon("entitydeleted");
  self waittill("death");
  var0 = 96;
  var1 = 4;
  badplace_cylinder("", var1, self.origin, var0, var0, "axis");
}

function player_weapon_holstered_door_bash_monitor() {
  level endon("flag_enforcer_flees_backroom");

  for(;;) {
    if(!istrue(self.bashed) && scripts\sp\door::bash_door_isplayerclose() && level.player meleeButtonPressed() && level.player getcurrentweapon().basename == "iw8_holstered") {
      scripts\sp\door::door_bash_open();
      return;
    }

    waitframe();
  }
}

function bar_alley_entrance_door_interacted() {
  level endon("flag_enforcer_flees_backroom");
  self waittill("trigger");
  scripts\engine\utility::flag_set("flag_bar_alley_entrance_door_opened");
}