/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc
***********************************************************************/

function hospital_upper_init() {
  scripts\engine\utility::flag_init("flag_mghall_vo_skip");
  scripts\engine\utility::flag_init("flag_mghall_shouter_start");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_bait");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_spawn");
  scripts\engine\utility::flag_init("upperfloor_murderhole_intro_complete");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_flank_left");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_flank_right");
  scripts\engine\utility::flag_init("flag_mg_gunner_alert_logic");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_abandon");
  scripts\engine\utility::flag_init("flag_upperfloor_murderhole_gunner_dead");
  scripts\engine\utility::flag_init("flag_mghall_rusher_a");
  scripts\engine\utility::flag_init("flag_mghall_rusher_b");
  scripts\engine\utility::flag_init("mg_hall_gunner_dead");
  scripts\engine\utility::flag_init("flag_mg_gunner_alert_reinforcement_spawns");
  scripts\engine\utility::flag_init("flag_mg_gunner_alert_reinforcement_spawns_2");
  scripts\engine\utility::flag_init("flag_mg_gunner_alert_reinforcement_right_side_spawns");
  scripts\engine\utility::flag_init("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");
  scripts\engine\utility::flag_init("flag_mg_gunner_proximity_alert_left");
  scripts\engine\utility::flag_init("flag_mg_gunner_proximity_alert_right");
  scripts\engine\utility::flag_init("flag_mg_gunner_center");
  scripts\engine\utility::flag_init("flag_mg_gunner_react");
  scripts\engine\utility::flag_init("flag_mg_hall_autosave_mid");
  scripts\engine\utility::flag_init("flag_mg_closet_target");
  scripts\engine\utility::flag_init("flag_mg_hall_closet_spawn");
  scripts\engine\utility::flag_init("flag_mg_hall_closet_spawn_skipped");
  scripts\engine\utility::flag_init("flag_mg_hall_after_closet_reinforcements");
  scripts\engine\utility::flag_init("flag_sign_bullet_trigger");
  scripts\engine\utility::flag_init("flag_mg_hall_ally_color_trigger_deleter");
  scripts\engine\utility::flag_init("flag_upperfloor_pediatrics_reached");
  scripts\engine\utility::flag_init("flag_mg_hall_cleared");
  scripts\engine\utility::flag_init("flag_mghall_tripwire_l_defused");
  scripts\engine\utility::flag_init("flag_mghall_tripwire_r_defused");
  scripts\engine\utility::flag_init("flag_snakecam_griggs_tripwire_vo");
  scripts\engine\utility::flag_init("flag_snakecam_tripwire_cleared");
  scripts\engine\utility::flag_init("flag_snakecam_tripwire_defused");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_moved");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_id_aq");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_id_hostages");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_id_cameraman");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_id_wolf");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_starting");
  scripts\engine\utility::flag_init("flag_wolf_snakecam_complete");
  scripts\engine\utility::flag_init("flag_wolf_ai_breached");
  scripts\engine\utility::flag_init("marinesBreach");
  scripts\engine\utility::flag_init("flag_marines_cleanup");
  scripts\engine\utility::flag_init("snakecam_enable_flag");
  scripts\engine\utility::flag_init("flag_wolf_disallow_tripwire_save");
  scripts\engine\utility::flag_init("flag_wolf_breach_gundown");
  scripts\engine\utility::flag_init("flag_wolf_open_alternate_path");
  scripts\engine\utility::flag_init("flag_wolf_alternate_route_opened");
  scripts\engine\utility::flag_init("flag_wolf_roof_advance");
  scripts\engine\utility::flag_init("flag_wolf_roof_door_check");
  scripts\engine\utility::flag_init("flag_wolf_tripwire_cleared");
  scripts\engine\utility::flag_init("flag_wolf_tripwire_tripped");
  scripts\engine\utility::flag_init("flag_wolf_breach_countdown_start");
  scripts\engine\utility::flag_init("flag_wolf_breach_start");
  scripts\engine\utility::flag_init("flag_wolf_cleanup_snakecam_marine");
  scripts\engine\utility::flag_init("flag_wolf_performing_takedown");
  scripts\engine\utility::flag_init("flag_wolf_alerted_early");
  scripts\engine\utility::flag_init("flag_wolf_breach_allow_aq_sight");
  scripts\engine\utility::flag_init("flag_wolf_breach_allow_aq_sight_forced");
  scripts\engine\utility::flag_init("flag_wolf_player_hit_ground");
  scripts\engine\utility::flag_init("flag_wolf_shelf_moved_done");
  scripts\engine\utility::flag_init("flag_nonShelfSoldierBack_moved");
  scripts\engine\utility::flag_init("flag_wolf_shooting_alert");
  scripts\engine\utility::flag_init("flag_wolf_vo_expire");
  scripts\engine\utility::flag_init("flag_vo_final_line_done");
  scripts\engine\utility::flag_init("flag_wolf_ziptie_complete");
  scripts\engine\utility::flag_init("flag_wolf_balcony_advance");
  scripts\engine\utility::flag_init("deathflag_wolf_guard");
  scripts\engine\utility::flag_init("flag_snakecam_hostage_kicked");
  scripts\sp\maps\marines\marines_civilians::civilians_init();
  scripts\sp\drone_civilian::init();
  precachemodel("body_al_qatala_desert_09_b");
  precachemodel("head_al_qatala_desert_06");
  precachemodel("body_al_qatala_4_ar");
  precachemodel("head_al_qatala_desert_05");
  precachemodel("head_sc_m_colvin");
}

function mg_hall_main() {
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_containment_civambush", ["marines_lobby_geo_tr", "marines_groundfloor_geo_tr"], undefined);
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_mg_gunner_alert_reinforcement_right_side_spawns_2", "marines_stairwell_geo_tr", undefined);
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_upperfloor_pediatrics_reached", undefined, "marines_wolf_script_tr");
  scripts\engine\sp\utility::array_spawn_function_targetname("spawner_mg_hall_closet", &closet_runner_ignore_manager);
  thread mg_autosave();
  thread mg_hall_shouter_handler();
  scripts\sp\spawner::killspawner(110);
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_mg_hall");
  thread mg_hall_break_windows();
  thread scripts\sp\maps\marines\marines_utility::griggs_supplies_refill();
  thread mg_hall_ally_color_trigger_deleter();
  thread mg_hall_ally_blindfire_handler();
  thread mg_hall_breakable_door_remove_interact();
  thread mg_hall_closet_magic_bullets();
  thread mg_hall_closet_spawn_handler();
  thread mg_hall_damage_nag_monitor();
  thread mg_hall_flank_cover_trigger_handler();
  thread scripts\sp\maps\marines\marines_vo::vo_mghall_marine_reloading_dialogue();
  thread mg_hall_marine_spawner_handler();
  thread mg_hall_reinforcement_handler();
  thread mg_hall_reinforcement_handler_right_side();
  thread mg_hall_rusher_handler();
  thread mg_hall_snakecam_marine_monitor();
  thread mg_hall_tripwire_handler();
  thread monitor_smoke();
  thread scripts\sp\maps\marines\marines_utility::spawn_corpses("mg_hall_dead_body", "flag_wolf_snakecam_starting");
  thread upperfloor_murderhole_handler();
  thread scripts\sp\maps\marines\marines_vo::mus_mghall_clear();
  thread scripts\sp\maps\marines\marines_lighting::wolf_takedown_cam_start();
  thread wolf_balcony_player_clip_handler();
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_left");
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_right");
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\sp\utility::battlechatter_on("allies");
  var0 = getspawnerarray("ai_aq_upperfloor_spawner");
  var1 = scripts\engine\utility::getStruct("snakecam_tripwire_struct", "targetname");
  var2 = getEnt("snakecam_tripwire_nav_clip", "targetname");
  var3 = scripts\engine\utility::getStruct("snakecam_tripwire_nav_clear_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("snakecam_tripwire_nav_block_struct", "targetname");
  thread mg_hall_ally_color_assign();
  scripts\engine\utility::flag_wait("flag_upperfloor_murderhole_spawn");
  thread scripts\sp\maps\marines\marines_utility::marines_tripwire_monitor(var1, "flag_snakecam_tripwire_cleared", var2, var4, var3, 1, "flag_snakecam_tripwire_defused");

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("combat");
  }

  scripts\engine\sp\utility::array_spawn(var0);
  wait 1;
  thread scripts\sp\maps\marines\marines_vo::vo_mghall_marines_intro_dialogue();
  scripts\engine\utility::flag_wait("flag_upperfloor_pediatrics_reached");
  level notify("mg_hall_generic_anims_stop");
}

function mg_hall_shouter_handler() {
  var0 = getspawner("aq_mghall_shouter", "targetname");
  var1 = var0 scripts\engine\sp\utility::spawn_ai();
  var1.ignoreall = 1;
  var2 = getEnt("mg_hall_closet_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_mghall_shouter_start");

  if(isDefined(var1) && isalive(var1)) {
    thread scripts\sp\maps\marines\marines_vo::vo_mghall_enemy_trap_shout(var1);
  }

  scripts\engine\utility::flag_wait("flag_sign_bullet_trigger");

  if(isDefined(var1) && isalive(var1)) {
    var1.ignoreall = 0;
  }

  scripts\engine\utility::flag_wait("flag_mg_hall_closet_spawn");

  if(isDefined(var1) && isalive(var1)) {
    var1 cleargoalvolume();
    waitframe();
    var1 setgoalvolumeauto(var2);
    return;
  }
}

function mg_hall_break_windows() {
  var0 = getglassarray("mg_hall_windows");

  foreach(var2 in var0) {
    if(isDefined(var2) && !isglassdestroyed(var2)) {
      destroyglass(var2);
    }
  }
}

function closet_runner_ignore_manager() {
  scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\sp\utility::set_ignoreme(1);
  self waittill("goal");
  scripts\engine\sp\utility::set_ignoreall(0);
  scripts\engine\sp\utility::set_ignoreme(0);
}

function mg_hall_snakecam_marine_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");
  thread snakecam_marine_spawner();
}

function mg_hall_marine_spawner_handler() {
  scripts\engine\utility::flag_wait("flag_upperfloor_murderhole_flank_left");
  scripts\sp\spawner::killspawner(120);
  waitframe();
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_mg_hall_reinforce");
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");
  thread containment_mghall();
  thread containment_mghall_teleport();
}

function mg_hall_reinforcement_handler() {
  thread mg_hall_after_closet_reinforcement_handler();
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_spawns");
  var0 = getspawnerarray("ai_aq_upperfloor_reinforcement_spawner");
  scripts\engine\sp\utility::array_spawn(var0);
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_spawns_2");
  var1 = getspawnerarray("ai_aq_upperfloor_reinforcement_spawner_2");
  var2 = scripts\engine\sp\utility::array_spawn(var1);

  foreach(var4 in var2) {
    var4 getenemyinfo(level.player);
  }
}

function mg_hall_after_closet_reinforcement_handler() {
  scripts\engine\utility::flag_wait("flag_mg_hall_after_closet_reinforcements");
  var0 = getspawnerarray("after_closet_reinforcements");
  var1 = scripts\engine\sp\utility::array_spawn(var0);

  foreach(var3 in var1) {
    thread mg_hall_after_closet_ignoreme_handler();
  }
}

function mg_hall_after_closet_ignoreme_handler() {
  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 1;
  }

  wait 5;

  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 0;
    return;
  }
}

function mg_hall_breakable_door_remove_interact() {
  var0 = scripts\sp\door::get_interactive_door("mg_hall_breakable_door");
  var0.open_struct scripts\sp\door::remove_open_interact_hint();
}

function mg_hall_damage_nag_monitor() {
  level endon("flag_upperfloor_pediatrics_reached");
  var0 = getEnt("mg_hall_gunner_damage_monitor", "targetname");
  var1 = 0;
  var2 = 0;

  for(;;) {
    var0 waittill("damage", var3, var4);

    if(var4 == level.player) {
      var1 += var3;

      if(var1 >= 1000) {
        wait 1;
        var2++;

        if(var2 == 1) {
          thread scripts\sp\maps\marines\marines_vo::vo_mghall_griggs_shoot_nag_1_dialogue();
        } else if(var2 == 2) {
          thread scripts\sp\maps\marines\marines_vo::vo_mghall_griggs_shoot_nag_2_dialogue();
          var2 = 0;
        }

        wait 5;
        var1 = 0;
      }
    }
  }
}

function mg_hall_reinforcement_handler_right_side() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns");
  var0 = getspawnerarray("ai_aq_upperfloor_reinforcement_right_side_spawner");
  scripts\engine\sp\utility::array_spawn(var0);
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_reinforcement_right_side_spawns_2");
  var1 = getspawnerarray("ai_aq_upperfloor_reinforcement_right_side_spawner_2");
  scripts\engine\sp\utility::array_spawn(var1);
}

function mg_hall_flank_cover_trigger_handler() {
  var0 = getEnt("mg_flank_color_a1", "targetname");
  var1 = getEnt("mg_flank_color_a2", "targetname");
  var2 = getEnt("mg_flank_color_a2", "targetname");
  var3 = getEnt("mg_flank_color_b1", "targetname");
  var4 = getEnt("mg_flank_color_b2", "targetname");
  scripts\engine\utility::flag_wait("flag_upperfloor_murderhole_abandon");

  if(isDefined(var0)) {
    var0 scripts\engine\utility::trigger_off();
  }

  if(isDefined(var1)) {
    var1 scripts\engine\utility::trigger_off();
  }

  if(isDefined(var2)) {
    var2 scripts\engine\utility::trigger_off();
  }

  if(isDefined(var3)) {
    var3 scripts\engine\utility::trigger_off();
  }

  if(isDefined(var4)) {
    var4 scripts\engine\utility::trigger_off();
    return;
  }
}

function mg_hall_rusher_handler() {
  var0 = getspawner("ai_aq_mghall_rusher_spawner", "targetname");
  var1 = getEnt("mg_rusher_node_a", "targetname");
  var2 = getEnt("auto13467", "targetname");
  scripts\engine\utility::flag_wait_any("flag_mghall_rusher_a", "flag_mghall_rusher_b");
  var3 = var0 scripts\engine\sp\utility::spawn_ai();

  if(scripts\engine\utility::flag("flag_mghall_rusher_a")) {
    var3 cleargoalvolume();
    waitframe();
    var3 setgoalvolumeauto(var1);
    return;
  }
}

function mg_hall_cleanup() {
  var0 = [];
  var0 = scripts\engine\sp\utility::get_living_ai_array("ai_upperfloor_1", "script_noteworthy");
  scripts\engine\utility::array_delete(var0);
}

function mg_hall_tripwire_handler() {
  var0 = scripts\engine\utility::getStruct("mghall_left_tripwire_struct", "targetname");
  var1 = getEnt("mghall_left_tripwire_nav_clip", "targetname");
  var2 = scripts\engine\utility::getStruct("mghall_right_tripwire_nav_clear_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("mghall_right_tripwire_struct", "targetname");
  var4 = getEnt("mghall_right_tripwire_nav_clip", "targetname");
  var5 = scripts\engine\utility::getStruct("mghall_right_tripwire_nav_clear_struct", "targetname");
  thread scripts\sp\maps\marines\marines_vo::vo_mghall_alex_tripwire_l_defused_dialogue();
  thread scripts\sp\maps\marines\marines_vo::vo_mghall_alex_tripwire_r_defused_dialogue();
  thread scripts\sp\maps\marines\marines_utility::marines_tripwire_monitor(var0, undefined, var1, undefined, var2, undefined, "flag_mghall_tripwire_l_defused");
  thread scripts\sp\maps\marines\marines_utility::marines_tripwire_monitor(var3, undefined, var4, undefined, var5, undefined, "flag_mghall_tripwire_r_defused");
}

function mg_hall_closet_magic_bullets() {
  level endon("mg_hall_gunner_dead");
  var0 = getEnt("mg_hall_trashcan_clip", "targetname");
  var1 = scripts\engine\utility::getStructArray("mg_hall_closet_target", "targetname");
  var2 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");
  var3 = "iw8_ar_akilo47_marines";
  scripts\engine\utility::flag_wait("flag_mg_closet_target");
  var0 delete();
  var4 = 0;
  wait 0.3;

  foreach(var6 in var1) {
    magicbullet(var3, var2.origin, var6.origin);
    wait 0.1;
  }
}

function snakecam_main() {
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_wolf_snakecam_complete", ["marines_streets_hospital_shared_script_tr", "marines_hospital_script_tr", "marines_civambush_geo_tr"], undefined);
  scripts\sp\maps\marines\marines_utility::autosave();
  thread scripts\sp\analytics::analytics_kleenex_update("Stairwell to Wolf Room");
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.griggs notify("remove_equipment");
  setsaveddvar("LKNNQPSPNL", 0.1);
  var0 = getEnt("wolf_door_faketarget", "targetname");
  var1 = getnode("snakecam_post_node", "targetname");
  waitframe();
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_snakecam");
  var1 disconnectnode();
  thread snakecam_griggs_find();

  foreach(var3 in getaiarray("allies")) {
    var3.ignoreplayersuppressionlines = 1;
    var3.disableplayeradsloscheck = 1;
  }

  scripts\engine\utility::flag_wait("flag_snakecam_tripwire_cleared");
  thread rally_to_snakecam_door_monitor();

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("cqb");
  }

  foreach(var3 in getaiarray("allies")) {
    var3.no_pistol_switch = 1;
    var3.sidearm = isundefinedweapon();
    var3.sidearm = "none";
  }

  var7 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
  var8 = scripts\engine\sp\utility::get_living_ai_array("ai_upperfloor_1", "script_noteworthy");

  foreach(var10 in var7) {
    if(isDefined(var10) && isalive(var10)) {
      thread rally_to_snakecam_door_monitor();

      if(var8.size < 1) {
        var10 scripts\engine\sp\utility::enable_dontevershoot();
        var10 setentitytarget(var0);
      }
    }
  }

  var12 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  foreach(var10 in var12) {
    if(isDefined(var10) && isalive(var10)) {
      thread rally_to_snakecam_door_monitor();

      if(var8.size < 1) {
        var10 scripts\engine\sp\utility::enable_dontevershoot();
        var10 setentitytarget(var0);
      }
    }
  }

  if(!isDefined(level.fail_state_active)) {
    level.fail_state_active = 0;
  }

  snakecam_sequence();
  scripts\engine\utility::flag_wait("flag_wolf_snakecam_complete");

  if(isDefined(level.proxy_wolf)) {
    level.proxy_wolf stopsounds();
  }

  setsaveddvar("LKNNQPSPNL", 1);
  level notify("snakecam_done");
}

function snakecam_griggs_find() {
  scripts\engine\utility::flag_wait("flag_snakecam_griggs_tripwire_vo");
  thread scripts\sp\maps\marines\marines_vo::vo_snakecam_griggs_tripwire_start_dialogue();
}

function snakecam_to_wolf() {
  var0 = scripts\engine\utility::getStruct("shelf_struct", "targetname");
  var1 = getEnt("pushShelf", "targetname");
  var2 = scripts\engine\utility::getStruct("shelf_soldier_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("non_shelf_soldier_struct_back", "targetname");
  var4 = scripts\engine\utility::getStruct("non_shelf_soldier_struct_front", "targetname");
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = getnode("window_exit_marine_01", "targetname");
  var9 = getnode("window_exit_marine_03", "targetname");
  var10 = getnode("window_exit_marine_02", "targetname");
  var11 = getEnt("wolf_door_faketarget", "targetname");
  scripts\engine\sp\utility::activate_trigger("color_trigger_snakecam_setup", "targetname");
  scripts\engine\sp\utility::activate_trigger("color_trigger_griggs_relocate", "targetname");
  thread scripts\sp\maps\marines\marines_background::wolf_balcony_apc_handler();
  var12 = 0;
  var13 = [];
  var14 = 0;

  while(var14 == 0) {
    var13 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("r");

    if(var13.size >= 3) {
      var14 = 1;
      continue;
    }

    waitframe();
  }

  var15 = 0;

  foreach(var17 in var13) {
    var17.script_pushable = 0;
    var17 pushplayer(1);

    if(var15 == 0) {
      var5 = var17;
      var5 scripts\common\ai::magic_bullet_shield();
    } else if(var15 == 1) {
      var6 = var17;
      var6 scripts\common\ai::magic_bullet_shield();
    } else if(var15 == 2) {
      var7 = var17;
      var7 scripts\common\ai::magic_bullet_shield();
    }

    var15++;
  }

  var19 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  foreach(var17 in var19) {
    if(isDefined(var17) && isalive(var17)) {
      if(isDefined(var17.dontevershoot)) {
        if(var17.dontevershoot == 0) {
          var17 scripts\engine\sp\utility::enable_dontevershoot();
        }
      }

      var17 clearentitytarget();
      waitframe();
      var17 setentitytarget(var11);
    }
  }

  foreach(var23 in getaiarray("allies")) {
    var23.script_pushable = 0;
    var23.no_pistol_switch = 1;
    var23.sidearm = isundefinedweapon();
    var23.sidearm = "none";
  }

  thread shelfexit(var2, var4, var3, var0, var1, var5, var7, var6);
}

function wolf_main() {
  scripts\engine\sp\utility::battlechatter_off("axis");
  scripts\engine\sp\utility::battlechatter_off("allies");
  thread containment_wolf();
  thread wolf_fail_and_save_manager();
  thread scripts\sp\maps\marines\marines_utility::spawn_corpse("wolf_dead_bodies", "flag_marines_cleanup");
  scripts\engine\utility::flag_wait("flag_wolf_alternate_route_opened");
  var0 = getEnt("wolf_breach_door", "targetname");
  var1 = getEnt("wolf_breach_door_window_cover", "targetname");
  var2 = getEnt("wolf_door_weapon_clip", "targetname");
  var3 = getEnt("wolf_door_glass_left", "targetname");
  var4 = getEnt("wolf_door_glass_right", "targetname");
  var5 = scripts\engine\utility::getStruct("wolf_door_glass_left_goto_struct", "targetname");
  var6 = scripts\engine\utility::getStruct("wolf_door_glass_right_goto_struct", "targetname");
  level.wolf_flank_tripwire_door = scripts\sp\door::get_interactive_door("wolf_flank_tripwire_door");
  level.wolf_flank_tripwire_door.door_ajar_custom_func = &wolf_flank_tripwire_door_ajar_handler;
  level.wolf_flank_tripwire_door.lockedforai = 1;
  level.wolf_flank_tripwire_door.nohint = 1;
  level.wolf_flank_tripwire_door.script_max_left_angle = 120;
  level.wolf_flank_tripwire_door.script_max_right_angle = 120;
  level.wolf_flank_tripwire_door scripts\sp\door::init_max_yaws();
  level.wolf_flank_tripwire_door scripts\game\sp\door::remove_door_snake_cam_ability();
  thread wolf_flank_tripwire_door_monitor();
  thread setup_combatant_wolf_aq();
  wait 1;
  var7 = level.allymarines["all"];

  foreach(var9 in var7) {
    if(isalive(var9) && isDefined(var9.asmname)) {
      var9 scripts\common\utility::demeanor_override("cqb");
    }
  }

  var11 = getaiarray("allies");

  foreach(var13 in var11) {
    if(isDefined(var13.script_forcecolor)) {
      var13.grenadeawareness = 0;
      var13.script_pushable = 0;
    }
  }

  wait 2;
  pacify_allies();
  thread wolf_tripwire_approach_monitor();
  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");
  thread scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_wait("flag_wolf_performing_takedown");
  thread scripts\sp\maps\marines\marines_vo::mus_wolf_captured();
  var15 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  foreach(var9 in var15) {
    if(isDefined(var9) && isalive(var9)) {
      if(isDefined(var9.dontevershoot)) {
        if(var9.dontevershoot == 1) {
          var9 scripts\engine\sp\utility::disable_dontevershoot();
        }
      }

      var9 clearentitytarget();
    }
  }

  marines_breach();
  scripts\engine\utility::flag_set("flag_wolf_ai_breached");
  level notify("ai_breaching_wolfroom");
  wait 2.37;
  var18 = getEnt("wolf_doors_clip", "targetname");
  var18 connectpaths();
  var18 delete();
  showmayhem("my_vfx_mayh_marines_wolfroom_door_breach_left");
  showmayhem("my_vfx_mayh_marines_wolfroom_door_breach_right");
  scripts\engine\utility::exploder("wolfroom_door_breach");
  playmayhem("my_vfx_mayh_marines_wolfroom_door_breach_left");
  playmayhem("my_vfx_mayh_marines_wolfroom_door_breach_right");
  level.wolf_door_a_explosion = scripts\engine\utility::getStruct("wolf_door_a_explosion", "targetname");
  level.wolf_door_b_explosion = scripts\engine\utility::getStruct("wolf_door_b_explosion", "targetname");
  level.player playSound("scn_marines_breach_wolf_door_lr");
  earthquake(0.45, 1, level.player.origin, 100);
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.45, 1, level.player.origin, 100);
  level.player playRumbleOnEntity("grenade_rumble");
  scripts\engine\utility::exploder("ceiling_falling_dust_debris");
  scripts\engine\utility::exploder("ceiling_falling_dust_debris_delay");
  level scripts\engine\utility::delaythread(2, &scripts\engine\utility::play_sound_in_space, "scn_marines_breach_wolf_aftermath_dust", level.wolf_door_a_explosion.origin);
  var0 delete();
  var1 delete();
  var2 delete();
  var3 moveTo(var5.origin, 0.1);
  var4 moveTo(var6.origin, 0.1);
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::activate_trigger, "color_trigger_wolf_breach_door_stand", "targetname");
  scripts\engine\utility::flag_wait("deathflag_wolf_guard");
  scripts\sp\maps\marines\marines_utility::marines_autosave();
  wait 1;

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("patrol");
  }

  var15 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  foreach(var9 in var15) {
    if(isalive(var9) && isDefined(var9.asmname)) {
      var9 scripts\common\utility::demeanor_override("combat");
    }
  }

  var21 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");

  foreach(var9 in var21) {
    if(isalive(var9) && isDefined(var9.asmname)) {
      var9 scripts\common\utility::demeanor_override("patrol");
    }
  }

  wait 2;
  scripts\engine\utility::flag_wait("flag_wolf_ziptie_complete");
  level.player clearsoundsubmix("sp_npc_steps_down", 1);
  thread scripts\sp\analytics::analytics_kleenex_update("Wolf room to End");
  marines_end_mission();
}

function rally_to_snakecam_door_monitor() {
  self endon("death");
  self endon("entitydeleted");
  self endon("close_to_door");
  var0 = getEnt("snakecam_door_ref", "targetname");
  waitframe();

  if(isDefined(self) && isalive(self)) {
    for(var1 = distance2d(self.origin, var0.origin); var1 > 500; var1 = distance2d(self.origin, var0.origin)) {
      wait 1;

      if(isDefined(self) && isalive(self)) {}
    }

    self.grenadeawareness = 0;
    self.script_pushable = 1;

    if(isDefined(self.asmname)) {
      scripts\common\utility::demeanor_override("cqb");
      return;
    }

    return;
  }
}

function wolf_tripwire_approach_monitor() {
  scripts\engine\utility::flag_wait("flag_wolf_roof_door_check");
  thread scripts\sp\maps\marines\marines_vo::vo_wolf_alex_tripwire_approach_dialogue();
  thread wolf_tripwire_handler();
  thread wolf_player_weapon_fired_monitor();
  scripts\engine\utility::flag_wait("flag_wolf_tripwire_cleared");
  level notify("wolf_tripwire_hint_disabled");
  thread scripts\sp\maps\marines\marines_vo::vo_wolf_alex_tripwire_cleared_dialogue();
}

function wolf_tripwire_handler() {
  var0 = scripts\engine\utility::getStruct("wolf_tripwire_struct", "targetname");
  thread scripts\sp\maps\marines\marines_utility::marines_tripwire_monitor(var0, "flag_wolf_tripwire_cleared");
  thread wolf_tripwire_player_weapon_monitor();
  thread wolf_tripwire_trigger_immediate();
  scripts\engine\utility::flag_wait("flag_wolf_tripwire_cleared");
}

function wolf_tripwire_player_weapon_monitor() {
  level.player scripts\engine\utility::waittill_any_return("weapon_fired", "grenade_fire");

  if(!scripts\engine\utility::flag("flag_wolf_tripwire_cleared")) {
    scripts\engine\utility::flag_set("flag_wolf_disallow_tripwire_save");
    return;
  }
}

function wolf_tripwire_trigger_immediate() {
  while(!scripts\engine\utility::flag("flag_wolf_tripwire_cleared") && !scripts\engine\utility::flag("flag_wolf_tripwire_tripped")) {
    if(level.wolf_flank_tripwire_door.bashed == 1) {
      foreach(var1 in level.tripwires.tripwires) {
        var1 notify("trigger", level.player, 1, 1);
      }

      scripts\engine\utility::flag_set("flag_wolf_tripwire_tripped");
      wait 0.5;

      if(isalive(level.player)) {
        level.player kill();
      }

      waitframe();
      scripts\sp\player_death::set_custom_death_quote(402);
      scripts\sp\utility::missionfailedwrapper();
      return;
    }

    waitframe();
  }
}

function defuse_tripwires() {
  foreach(var1 in level.tripwires.traps) {
    var2 = distance2d(var1.origin, level.player.origin);

    if(var2 < 500) {
      var1.defusehintstruct notify("trigger", level.player, 0);
      var1.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
  }
}

function setup_combatant_wolf_aq() {
  wolf_handler();
  thread wolf_cameraman_handler();
  thread wolf_executioner_handler();
  thread wolf_hostage_handler();
  thread wolf_guard_sighting_force();
  level waittill("wolfguard_alerted");
  wait 0.5;
  thread scripts\sp\maps\marines\marines_vo::vo_wolf_aq_takedown_alerted_dialogue();
}

function marines_end_mission() {
  wait 3;
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(2);
  var0.alpha = 1;
  wait 1;
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 3);
  wait 3;
  scripts\engine\sp\utility::nextmission();
}

function wolf_handler() {
  level.wolf_machete_prop = getEnt("preBreachMacheteProp", "targetname");
  level.wolf_execute_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_wolf", "targetname");
  level.wolf_machete_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_machete", "targetname");
  var0 = getEnt("wolf_machete_table", "targetname");
  var1 = scripts\engine\utility::getStruct("wolf_machete_table_hide_struct", "targetname");
  var2 = scripts\engine\utility::getStruct("wolf_machete_table_show_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("wolf_machete_table_fallover_struct", "targetname");
  level.wolf_fail_state_active = 0;
  level.wolf = scripts\engine\sp\utility::spawn_targetname("wolf_spawner", 1);

  while(!isDefined(level.wolf)) {
    waitframe();
  }

  level.wolf.animname = "wolf";
  level.wolf.name = "^1The Wolf";
  level.wolf.callsign = "^1Omar Sulaman";
  level.wolf.team = "axis";
  level.wolf.context_melee_victim_lives = 1;
  level.wolf.death_stance = "standing";
  level.wolf.disableplayeradsloscheck = 1;
  level.wolf.ignoreall = 1;
  level.wolf.ignoreme = 1;
  level.wolf.noragdoll = 1;
  level.wolf actoraimassistoff();
  level.wolf scripts\sp\utility::context_melee_allow(0);
  level.wolf scripts\common\ai::gun_remove();
  level.wolf scripts\engine\sp\utility::set_allowdeath(1);

  if(isDefined(level.wolf.asmname)) {
    level.wolf scripts\common\utility::demeanor_override("casual");
  }

  level.wolf_machete_prop linkTo(level.wolf, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.wolf_machete_prop.animname = "machete";
  level.wolf_machete_prop scripts\engine\sp\utility::assign_animtree("machete");
  level.wolf_machete_prop show();
  level.wolf_execute_struct thread scripts\common\anim::anim_loop_solo(level.wolf, "postBreachIdle", "raiseMachete");
  var0 moveTo(var2.origin, 0.1);
  thread table_knockdown_handler(var0, var3);
  thread wolf_damage_monitor();
  thread wolf_executes_hostage();
  thread wolf_player_demeanor_manager();
  thread wolf_takedown_monitor();
  thread hostage_1_death_monitor();
}

function hostage_1_death_monitor() {
  level.wolf endon("deadWolf");
  level waittill("hostage1Dead");

  if(isDefined(level.wolf) && isalive(level.wolf)) {
    level.wolf stopanimScripted();
    level.wolf notify("shotHostage");
    level.wolf_execute_struct notify("disable_wolf_machete_threaten");
    level.wolf_machete_struct notify("disable_wolf_machete_threaten");
    level.wolf.diequietly = 1;
    level.wolf.skip_friendly_fire_check = 1;
    level.wolf.skipdeathanim = 1;
    level.wolf stopsounds();
    level.wolf_killed = 1;
    thread play_and_hold_anim(level.wolf_execute_struct, level.wolf);
  }

  level.wolf_machete_prop hide();
}

function table_knockdown_handler(var0, var1) {
  scripts\engine\utility::flag_wait("flag_wolf_breach_start");
  thread move_machete_table(var0, var1);
  var0 rotatepitch(-90, 0.5);
}

function move_machete_table(var0, var1) {
  var0 moveTo(var1.origin, 0.5);
}

function wolf_executes_hostage() {
  level.wolf endon("death");
  level.wolf endon("deadWolf");
  level endon("shotHostage");
  level endon("hostage1Dead");
  level endon("wolfTakedown");
  scripts\engine\utility::flag_init("executeEarly");
  scripts\engine\utility::flag_init("Hostage_4_Executed");
  scripts\engine\utility::flag_init("pointofnoreturn");
  var0 = 0;
  var1 = 4;
  var2 = 4;
  scripts\engine\utility::flag_wait_any("flag_wolf_breach_countdown_start", "flag_wolf_alerted_early");

  if(scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {}

  scripts\engine\utility::flag_wait_or_timeout("flag_wolf_alerted_early", var2);
  level.wolf_execute_struct notify("raiseMachete");
  level.wolf_machete_struct notify("raiseMachete");
  level.wolf_hostage_1_struct notify("raiseMachete");
  level.wolf stopanimScripted();
  level.wolf_execute_struct scripts\common\anim::anim_single_solo(level.wolf, "postBreachRaiseMachete");
  level.wolf_execute_struct thread scripts\common\anim::anim_loop_solo(level.wolf, "postBreachMacheteIdle", "disable_wolf_machete_threaten");

  if(scripts\engine\utility::flag("flag_wolf_performing_takedown")) {
    return;
  }

  if(scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
    var1 = 1.25;
    thread point_of_no_return();
  } else if(scripts\engine\utility::flag("flag_wolf_alerted_early")) {
    var1 = 1;
  }

  while(var0 <= var1 && !scripts\engine\utility::flag("flag_wolf_shooting_alert")) {
    wait 0.1;
    var0 += 0.1;
  }

  if(isalive(level.wolf)) {
    if(!scripts\engine\utility::flag("executeEarly")) {
      level.wolf_execute_struct notify("disable_wolf_machete_threaten");
      level.wolf stopanimScripted();
    }
  }

  if(!scripts\engine\utility::flag("flag_wolf_performing_takedown")) {
    if(isDefined(level.wolf) && isalive(level.wolf)) {
      level.wolf scripts\sp\maps\marines\marines_utility::dialogue_stop();
      level.wolf_execute_struct thread scripts\common\anim::anim_single_solo(level.wolf, "postBreachMacheteSlash");
      level.wolf_hostage_1_struct notify("executeHostage");
      level.wolf_hostage_2_struct notify("executeHostage");
      scripts\engine\utility::flag_set("Hostage_4_Executed");
      level notify("missionfailed");
      level.wolf_executioner notify("wolfguard_alerted");
      level.wolf_executioner_struct notify("exitanim");
      thread anim_hold_last_frame_solo(level.wolf_hostage_1_struct, level.wolf_hostage_1);
      wait 2;
      hostage_executed_fail_state();
      return;
    }

    return;
  }
}

function anim_hold_last_frame_solo(var0, var1) {
  var0 endon("death");
  scripts\common\anim::anim_single_solo(var0, var1);
  scripts\common\anim::anim_last_frame_solo(var0, var1);
}

function point_of_no_return() {
  wait 4.5 - getanimlength(level.wolf scripts\engine\utility::getanim("postBreachFlinch"));
  scripts\engine\utility::flag_set("pointofnoreturn");
}

function wolf_raised_flinch() {
  level.wolf endon("deadWolf");
  level.wolf endon("wolfCaptured");
  level endon("hostage1Dead");
  level.player waittill("weapon_fired");

  if(!scripts\engine\utility::flag("pointofnoreturn")) {
    level.wolf_execute_struct notify("disable_wolf_machete_threaten");
    level.wolf_machete_struct notify("disable_wolf_machete_threaten");
    level.wolf stopanimScripted();
    level.wolf_execute_struct thread scripts\common\anim::anim_single_solo(level.wolf, "postBreachFlinch");
    scripts\engine\utility::flag_set("executeEarly");
    return;
  }
}

function wolf_takedown_monitor() {
  level endon("missionfailed");
  thread wolf_takedown_hint_manager();
  var0 = 0;

  while(!scripts\engine\utility::flag("flag_wolf_ziptie_complete")) {
    if(istrue(level.player.takedown_available) && !level.wolf_killed) {
      if(var0 == 0) {
        level.player allowmelee(0);
        var0 = 1;
      }

      if((level.player useButtonPressed() || level.player meleeButtonPressed()) && isalive(level.wolf) && level.wolf_killed == 0 && isalive(level.player)) {
        thread scripts\sp\utility::delete_live_grenades();
        thread takedown_grenade_monitor();
        level.wolf_execute_struct notify("disable_wolf_machete_threaten");
        level.wolf_machete_struct notify("disable_wolf_machete_threaten");
        level.wolf scripts\common\ai::magic_bullet_shield();
        level.player.ignoreme = 1;
        thread wolf_takedown();
        return;
      }
    } else if(var0 == 1) {
      var0 = 0;
      level.player allowmelee(1);
    }

    waitframe();
  }
}

function wolf_takedown_hint_manager() {
  level endon("missionfailed");
  level endon("flag_wolf_performing_takedown");
  level.player endon("death");
  var0 = level.player getEye();
  var1 = level.wolf getEye();
  var2 = getEntArray("wolf_takedown_hint_info_volume", "targetname");
  var3 = scripts\engine\utility::getStruct("wolf_takedown_fov_ref", "targetname");
  level.player.takedown_available = 0;

  for(;;) {
    if(wolf_takedown_hint_check(var2, var3)) {
      if(level.player.takedown_available == 0) {
        scripts\engine\sp\utility::display_hint_forced("marines_wolf_takedown_hint", undefined, 0, level, ["missionfailed", "wolf_takedown_hint_disabled", "flag_wolf_performing_takedown"]);
        level.player.takedown_available = 1;
      }
    } else if(level.player.takedown_available == 1) {
      level notify("wolf_takedown_hint_disabled");
      level.player.takedown_available = 0;
    }

    waitframe();
  }
}

function wolf_takedown_hint_check(var0, var1) {
  var2 = 0;

  foreach(var4 in var0) {
    if(ispointinvolume(level.player.origin, var4)) {
      var2 = 1;
    }
  }

  if(!var2) {
    return false;
  }

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, var1.origin, cos(90))) {
    return false;
  }

  return true;
}

function takedown_guards() {
  level notify("wolfTakedown");
  var0 = [level.wolf_cameraman, level.wolf_executioner];
  var1 = [scripts\engine\utility::getStruct("takeDownGuardStruct_cameraman", "targetname"), scripts\engine\utility::getStruct("takeDownGuardStruct_executioner", "targetname"), scripts\engine\utility::getStruct("takeDownGuardStruct_aq01", "targetname")];

  for(var2 = 0; var2 < var0.size; var2++) {
    thread guard_takedown_anim(var1[var2], var0[var2]);
  }

  wait 5.83;
  scripts\engine\utility::flag_set("deathflag_wolf_guard");
}

function guard_takedown_anim(var0, var1) {
  if(isalive(var0) && isDefined(var0)) {
    var0 stopanimScripted();
    var0.ignoreme = 1;

    if(var0.animname == "cameraman") {
      scripts\common\anim::anim_single_solo(var0, var1);
      scripts\common\anim::anim_last_frame_solo(var0, var1);
      return;
    }

    var2 = 2.5;
    var3 = getanimlength(scripts\engine\utility::getanim_from_animname(var1, var0.animname));
    wait var2;
    thread scripts\common\anim::anim_single_solo(var0, var1);
    waitframe();
    var4 = 1 - (var3 - var2 + 0.0333333) / var3;
    var0 setanimtime(scripts\engine\utility::getanim_from_animname(var1, var0.animname), var4);
    wait var3 * (1 - var4);
    scripts\common\anim::anim_last_frame_solo(var0, var1);
    return;
  }
}

function takedown_hostages() {
  level notify("wolfTakedown");
  var0 = [level.wolf_hostage_1, level.wolf_hostage_2, level.wolf_hostage_3];
  var1 = [scripts\engine\utility::getStruct("takedown_hostage1_struct", "targetname"), scripts\engine\utility::getStruct("takedown_hostage2_struct", "targetname"), scripts\engine\utility::getStruct("takedown_hostage3_struct", "targetname")];
  thread singleanimtohold(var1[0], var0[0]);
  thread singleanimtohold(var1[1], var0[1]);
}

function singleanimtohold(var0, var1) {
  if(isDefined(var0) && isalive(var0)) {
    scripts\common\anim::anim_single_solo(var0, var1);
    scripts\common\anim::anim_last_frame_solo(var0, var1);
    return;
  }
}

function wolf_takedown() {
  level endon("missionfailed");
  level endon("shotHostage");
  level.player endon("deadwolf");
  level.player endon("death");
  level.wolf notify("wolfCaptured");
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 = 45;

  if(!isalive(level.player)) {
    return;
  }

  if(!isalive(level.wolf)) {
    return;
  }

  level thread scripts\sp\utility::context_melee_enable(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player allowcrouch(0);
  level.player allowmovement(0);
  level.player allowprone(0);
  level.player disableoffhandprimaryweapons();
  level.shadowcaster = getEnt("takedownShadow", "targetname");
  level.shadowcaster.animname = "shadowCaster";
  level.shadowcaster scripts\engine\sp\utility::assign_animtree("shadowCaster");
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  level.player.rig hide();
  level.player.rig dontcastshadows();
  thread wolf_takedown_scene_hide_names();
  scripts\engine\utility::flag_set("flag_wolf_performing_takedown");
  var1 = scripts\engine\utility::getStruct("takedown_struct2", "targetname");
  var2 = [level.wolf, level.player.rig, level.shadowcaster];
  var3 = "vig_acquire_takedown_right";
  var4 = getanimlength(level.wolf scripts\engine\utility::getanim(var3));
  var5 = 0.5;

  if(distance(level.player.origin, level.wolf.origin) > var0) {
    var6 = scripts\engine\utility::spawn_tag_origin(level.player.origin, level.player getplayerangles());
    level.player playersetgroundreferenceent(var6);
    level.player playerlinktoabsolute(var6, "tag_origin");
    level.player disableweapons();
    var7 = scripts\engine\utility::getStruct("takedown_prep_position", "targetname");
    var6 moveTo(var7.origin, 0.4, 0.15, 0);
    var6 rotateTo(var7.angles, 0.4, 0.15, 0);
    wait 0.5;
    level.player unlink();
    var6 delete();
    var5 = 0.25;
  }

  var1 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, var3);

  if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
    level.wolf_cameraman scripts\engine\sp\utility::enable_dontevershoot();
  }

  if(isDefined(level.wolf_executioner) && isalive(level.wolf_executioner)) {
    level.wolf_executioner scripts\engine\sp\utility::enable_dontevershoot();
  }

  thread wolf_takedown_rumble_handler();
  scripts\sp\maps\marines\marines_utility::put_player_into_rig(level.player.rig, var5, 30, 30, 0, 0);
  thread wolf_takedown_input_lerp();
  level.player scripts\engine\utility::delaycall(0.3, &lerpfovscalefactor, 0, 0.6);
  level.wolf_execute_struct notify("disable_wolf_machete_threaten");
  level.wolf_machete_struct notify("disable_wolf_machete_threaten");
  thread hide_machete();
  level.player allowfire(0);
  level.player allowmelee(0);

  if(!scripts\engine\utility::flag("flag_wolf_breach_start")) {
    scripts\engine\utility::flag_set("flag_wolf_breach_start");
  }

  thread cine_settings();
  thread takedown_wrapup_logic();
  var8 = 19;
  var1 thread scripts\common\anim::anim_single(var2, var3);
  thread takedown_guards();
  thread takedown_hostages();
  scripts\engine\utility::flag_set("marinesBreach");
  wait var8;
  scripts\engine\utility::flag_set("flag_wolf_ziptie_complete");
  wait 25.83 - var8;
  var1 thread scripts\common\anim::anim_last_frame_solo(level.player.rig, var3);
  var1 thread scripts\common\anim::anim_last_frame_solo(level.wolf, var3);
}

function proxy_execution_fail_hide_names() {
  wait 0.5;
  var0 = scripts\engine\sp\utility::get_living_ai_array("wolf_proxy_ai", "script_noteworthy");

  foreach(var2 in var0) {
    if(isDefined(var2) && isalive(var2)) {
      var2 scripts\engine\sp\utility::name_hide();
    }
  }
}

function wolf_takedown_scene_hide_names() {
  if(isDefined(level.wolf) && isalive(level.wolf)) {
    level.wolf scripts\engine\sp\utility::name_hide();
  }

  if(isDefined(level.griggs) && isalive(level.griggs)) {
    level.griggs scripts\engine\sp\utility::name_hide();
  }

  var0 = scripts\engine\sp\utility::get_living_ai_array("wolf_hostage_ai", "script_noteworthy");

  foreach(var2 in var0) {
    if(isDefined(var2) && isalive(var2)) {
      var2 scripts\engine\sp\utility::name_hide();
    }
  }

  var4 = level.allymarines["all"];

  foreach(var6 in var4) {
    if(isDefined(var6) && isalive(var6) && var6 != level.griggs) {
      var6 scripts\engine\sp\utility::name_hide();
    }
  }
}

function wolf_takedown_rumble_handler() {
  wait 0.5;
  level.player playRumbleOnEntity("light_1s");
  wait 2.5;
  level.player playRumbleOnEntity("heavy_1s");
  scripts\engine\utility::flag_set("flag_wolf_player_hit_ground");
}

function takedown_wrapup_logic() {
  wait 1.75;
  scripts\engine\utility::exploder("wolf_fx");
  wait 20.25;
  scripts\engine\utility::flag_set("flag_wolf_ziptie_complete");
}

function cine_settings() {
  level.player modifybasefov(55, 1);
  level.wolf thread scripts\engine\sp\utility::dof_enable_autofocus(22, 3, undefined, undefined, "tag_eye");
  wait 3;
  level.griggs thread scripts\engine\sp\utility::dof_enable_autofocus(2, 5, undefined, undefined, "tag_eye");
  wait 3;
  wait 1.5;
  hidecinematicletterboxing(1, 0);
  level.wolf thread scripts\engine\sp\utility::dof_enable_autofocus(22, 4, undefined, undefined, "tag_eye");
  wait 2.5;
  level.wolf thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 2, undefined, undefined, "tag_eye");
  wait 9;
  level.griggs thread scripts\engine\sp\utility::dof_enable_autofocus(2, 3, undefined, undefined, "tag_eye");
  wait 3;
  wait 5;
  scripts\engine\sp\utility::dof_disable();
}

function takedown_grenade_monitor() {
  while(!scripts\engine\utility::flag("flag_wolf_ziptie_complete")) {
    thread scripts\sp\utility::delete_live_grenades();
    wait 0.2;
  }
}

function hide_machete() {
  level.wolf_machete_prop linkTo(level.wolf, "tag_accessory_right", (0, 0, 0), (-90, 0, 0));
  wait 0.75;
  level.wolf_machete_prop unlink();
  level.wolf_machete_prop hide();
}

function wolf_cameraman_handler() {
  level endon("wolfTakedown");
  var0 = getspawner("wolf_cameraman_spawner", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&wolf_guard_behavior_setup, "casual_killer");
  level.wolf_cameraman = var0 scripts\engine\sp\utility::spawn_ai();
  level.wolf_cameraman scripts\sp\utility::context_melee_allow(0);
  level.wolf_cameraman_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_cameraman", "targetname");
  level.wolf_cameraman endon("death");
  level.wolf_cameraman.animname = "cameraman";
  var1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.wolf_cameraman scripts\anim\shared::forceuseweapon(var1, "primary");
  level.wolf_cameraman.no_pistol_switch = 1;
  level.wolf_cameraman.sidearm = isundefinedweapon();
  level.wolf_cameraman.sidearm = "none";
  var2 = getEnt("cameraman_gun_prop", "targetname");
  waitframe();
  thread wolf_cameraman_camera_handler();
  level.wolf_cameraman scripts\common\ai::gun_remove();
  setcharmodels(level.wolf_cameraman, "body_al_qatala_desert_09_b", "head_al_qatala_desert_06", undefined);
  level.wolf_cameraman endon("damage");
  thread guard_damage(level.wolf_cameraman, level.wolf_cameraman_struct);
  level.wolf_cameraman_struct thread scripts\common\anim::anim_loop_solo(level.wolf_cameraman, "postBreachIdle", "exitAnim");
  level.wolf_cameraman scripts\engine\utility::waittill_any("wolfguard_alerted", "damage");
  level.wolf_cameraman_struct notify("exitAnim");
  level.wolf_cameraman stopanimScripted();
  level.wolf_cameraman_struct thread scripts\common\anim::anim_single_solo(level.wolf_cameraman, "postBreachFlinch");
  wait 1.9;
  var2 hide();
  level.wolf_cameraman scripts\common\ai::gun_recall();
  level.wolf_cameraman scripts\engine\utility::waittill_any("damage", "death");
}

function wolf_cameraman_camera_handler() {
  var0 = getEnt("wolf_camera_prebreach_top", "targetname");
  var1 = getEnt("wolf_camera_prebreach_bot", "targetname");
  var2 = scripts\engine\utility::getStruct("wolf_camera_prebreach_top_hide_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("wolf_camera_prebreach_top_show_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("wolf_camera_prebreach_bot_hide_struct", "targetname");
  var5 = scripts\engine\utility::getStruct("wolf_camera_prebreach_bot_show_struct", "targetname");
  var6 = getEnt("wolf_camera_breach_top", "targetname");
  var7 = getEnt("wolf_camera_breach_bot", "targetname");
  var8 = scripts\engine\utility::getStruct("wolf_camera_breach_top_hide_struct", "targetname");
  var9 = scripts\engine\utility::getStruct("wolf_camera_breach_top_show_struct", "targetname");
  var10 = scripts\engine\utility::getStruct("wolf_camera_breach_bot_hide_struct", "targetname");
  var11 = scripts\engine\utility::getStruct("wolf_camera_breach_bot_show_struct", "targetname");
  var1 linkTo(var0);
  var7 linkTo(var6);
  var0 moveTo(var3.origin, 0.1);
  scripts\engine\utility::flag_wait("flag_wolf_breach_start");
  var0 moveTo(var2.origin, 0.1);
  var6 moveTo(var9.origin, 0.1);
}

function wolf_executioner_handler() {
  level endon("wolfTakedown");
  var0 = getEnt("wolf_executioner_breach_volume", "targetname");
  var1 = getspawner("wolf_executioner_spawner", "targetname");
  var1 scripts\engine\sp\utility::add_spawn_function(&wolf_guard_behavior_setup, "combat", var0);
  level.wolf_executioner = var1 scripts\engine\sp\utility::spawn_ai();
  level.wolf_executioner endon("damage");
  level.wolf_executioner endon("death");
  level.wolf_executioner.animname = "executioner";
  level.wolf_executioner scripts\sp\utility::context_melee_allow(0);
  level.wolf_executioner.no_pistol_switch = 1;
  level.wolf_executioner.sidearm = isundefinedweapon();
  level.wolf_executioner.sidearm = "none";
  setcharmodels(level.wolf_executioner, "body_al_qatala_4_ar", "head_al_qatala_desert_05", undefined);
  level.wolf_executioner_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_aq01", "targetname");
  thread guard_damage(level.wolf_executioner, level.wolf_executioner_struct);
  level.wolf_executioner_struct thread scripts\common\anim::anim_loop_solo(level.wolf_executioner, "postBreachIdle", "exitAnim");
  level.wolf_executioner scripts\engine\utility::waittill_any("wolfguard_alerted", "damage");
  level.wolf_executioner_struct notify("exitAnim");
  level.wolf_executioner stopanimScripted();

  if(scripts\engine\utility::flag("Hostage_4_Executed")) {
    level.wolf_executioner_struct thread scripts\common\anim::anim_single_solo(level.wolf_executioner, "postBreachHostageDeath");
    level.wolf_executioner waittill("damage");
    level.wolf_executioner stopanimScripted();
    return;
  }

  level.wolf_executioner_struct scripts\common\anim::anim_single_solo(level.wolf_executioner, "postBreachFlinch");
}

function guard_damage(var0, var1) {
  level endon("wolfTakedown");
  self waittill("damage");
  var0 notify(var1);
  self stopanimScripted();
}

function wolf_player_weapon_fired_monitor() {
  level endon("wolfTakedown");
  level.player waittill("weapon_fired");
  level notify("wolfguard_alerted");
  level.wolf_cameraman notify("wolfguard_alerted");
  level.wolf_executioner notify("wolfguard_alerted");
  scripts\engine\utility::flag_set("flag_wolf_alerted_early");
}

function wolf_guard_behavior_setup(var0, var1) {
  level endon("wolfTakedown");
  self.dontmelee = 1;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.pacifist = 1;
  scripts\sp\utility::context_melee_allow(0);
  thread wolf_guards_breach_reaction_flag(var1);
  thread wolf_guards_breach_reaction_notify(var1);
  thread wolf_guard_grenade_alert();
  thread wolf_guard_shooting_alert();
  thread wolf_guard_sighting_alert();
  self.goalradius = 1;

  if(isDefined(self.asmname)) {
    scripts\common\utility::demeanor_override(var0);
  }

  self waittill("wolfguard_alerted");

  if(self.pacifist == 1) {
    self.pacifist = 0;
    return;
  }
}

function wolf_guard_shooting_alert() {
  level endon("wolfTakedown");
  scripts\engine\utility::flag_wait("flag_wolf_tripwire_cleared");
  scripts\engine\utility::waittill_any("damage", "pain", "death", "bulletwhizby");
  level notify("wolfguard_alerted");
  level.wolf_cameraman notify("wolfguard_alerted");
  level.wolf_executioner notify("wolfguard_alerted");
  scripts\engine\utility::flag_set("flag_wolf_shooting_alert");
}

function wolf_guard_sighting_alert() {
  level endon("wolfTakedown");
  scripts\engine\utility::flag_wait("flag_wolf_breach_allow_aq_sight");

  if(isDefined(self) && isalive(self)) {
    if(self.pacifist == 1) {
      self.pacifist = 0;
    }
  }

  scripts\engine\utility::waittill_any("enemy_visible", "flag_wolf_breach_allow_aq_sight_forced");
  level notify("wolfguard_alerted");

  if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
    level.wolf_cameraman notify("wolfguard_alerted");
  }

  if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
    level.wolf_executioner notify("wolfguard_alerted");
    return;
  }
}

function wolf_guard_sighting_force() {
  scripts\engine\utility::flag_wait("flag_wolf_breach_allow_aq_sight");
  wait 1;
  scripts\engine\utility::flag_set("flag_wolf_breach_allow_aq_sight_forced");
  level notify("wolfguard_alerted");

  if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
    level.wolf_cameraman notify("wolfguard_alerted");
  }

  if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
    level.wolf_executioner notify("wolfguard_alerted");
    return;
  }
}

function wolf_guard_grenade_alert() {
  level endon("wolfTakedown");
  var0 = getEnt("wolf_grenade_volume_a", "targetname");
  var1 = getEnt("wolf_grenade_volume_b", "targetname");

  for(;;) {
    level.player waittill("grenade_fire", var2, var3);

    if(!isDefined(var2)) {
      return;
    } else {
      thread grenade_location_monitor();
    }

    if(!isDefined(var3.basename)) {
      return;
    }

    if(var3.basename == "smoke_tall") {
      var2 waittill("explode", var4);

      if(ispointinvolume(var4, var0)) {
        level notify("wolfguard_alerted");

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_cameraman notify("wolfguard_alerted");
        }

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_executioner notify("wolfguard_alerted");
        }

        if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
          scripts\engine\utility::flag_set("flag_wolf_alerted_early");
        }
      } else if(ispointinvolume(var4, var1)) {
        level notify("wolfguard_alerted");

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_cameraman notify("wolfguard_alerted");
        }

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_executioner notify("wolfguard_alerted");
        }

        if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
          scripts\engine\utility::flag_set("flag_wolf_alerted_early");
        }
      }
    } else if(var3.basename == "frag") {
      var2 waittill("explode", var4);

      if(ispointinvolume(var4, var0)) {
        level notify("wolfguard_alerted");

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_cameraman notify("wolfguard_alerted");
        }

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_executioner notify("wolfguard_alerted");
        }

        if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
          scripts\engine\utility::flag_set("flag_wolf_alerted_early");
        }
      }

      if(ispointinvolume(var4, var1)) {
        level notify("wolfguard_alerted");

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_cameraman notify("wolfguard_alerted");
        }

        if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
          level.wolf_executioner notify("wolfguard_alerted");
        }

        if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
          scripts\engine\utility::flag_set("flag_wolf_alerted_early");
        }
      }
    }

    wait 1;
  }
}

function grenade_location_monitor() {
  self endon("entitydeleted");
  level endon("wolfguard_alerted");
  var0 = getEnt("wolf_grenade_volume_a", "targetname");
  var1 = getEnt("wolf_grenade_volume_b", "targetname");
  wait 1;

  for(;;) {
    if(ispointinvolume(self.origin, var0)) {
      level notify("wolfguard_alerted");

      if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
        level.wolf_cameraman notify("wolfguard_alerted");
      }

      if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
        level.wolf_executioner notify("wolfguard_alerted");
      }

      if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
        scripts\engine\utility::flag_set("flag_wolf_alerted_early");
      }
    }

    if(ispointinvolume(self.origin, var1)) {
      level notify("wolfguard_alerted");

      if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
        level.wolf_cameraman notify("wolfguard_alerted");
      }

      if(isDefined(level.wolf_cameraman) && isalive(level.wolf_cameraman)) {
        level.wolf_executioner notify("wolfguard_alerted");
      }

      if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
        scripts\engine\utility::flag_set("flag_wolf_alerted_early");
      }
    }

    waitframe();
  }
}

function wolf_guards_breach_reaction_flag(var0) {
  scripts\engine\utility::flag_wait("flag_wolf_ai_breached");

  if(isDefined(self) && isalive(self)) {
    self clearentitytarget();
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.pacifist = 0;

    if(isDefined(self.asmname)) {
      scripts\common\utility::demeanor_override("combat");
    }

    if(isDefined(var0)) {
      self aisetdesiredspeed(200);
      self cleargoalvolume();
      waitframe();
      self setgoalvolumeauto(var0);
      return;
    }

    return;
  }
}

function wolf_guards_breach_reaction_notify(var0) {
  level waittill("wolfguard_alerted");

  if(isDefined(self) && isalive(self)) {
    self clearentitytarget();
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.pacifist = 0;

    if(isDefined(self.asmname)) {
      scripts\common\utility::demeanor_override("combat");
    }

    if(isDefined(var0)) {
      self cleargoalvolume();
      waitframe();
      self setgoalvolumeauto(var0);
    }
  }

  if(!scripts\engine\utility::flag("flag_wolf_breach_countdown_start")) {
    var1 = scripts\engine\sp\utility::get_living_ai_array("wolf_hostages", "targetname");

    if(var1.size > 0) {
      self getenemyinfo(scripts\engine\utility::random(var1));
      return;
    }

    return;
  }
}

function mg_hall_start() {
  scripts\engine\sp\utility::set_start_location("start_mg_hall", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility::setup_named_ai("griggs", "Sgt. Griggs", "start_mg_hall_griggs", undefined, undefined, undefined, "Demon 1-2");
  var0 = getspawnerarray("ally_marine_mg_hall");
  thread scripts\sp\maps\marines\marines_utility::marines_checkpoint_forcespawn_allies(var0);
  thread scripts\sp\maps\marines\marines_utility::ally_equipment_backpack(level.griggs, "smoke_tall");
  scripts\sp\maps\marines\marines_lighting::sun_adjustments_hospital_force("lighting_hospital", 4);
}

function mg_hall_catchup() {
  thread containment_mghall();
  thread mg_hall_breakable_door_remove_interact();
  thread scripts\sp\maps\marines\marines_lighting::wolf_takedown_cam_start();
}

function mg_hall_ally_color_trigger_deleter() {
  scripts\engine\utility::flag_wait("flag_mg_hall_ally_color_trigger_deleter");
  var0 = getEntArray("mg_hall_allied_color_volumes", "script_noteworthy");

  foreach(var2 in var0) {
    var2 delete();
  }
}

function snakecam_start() {
  scripts\engine\sp\utility::set_start_location("start_snakecam", [level.player]);
  level.griggs = scripts\sp\maps\marines\marines_utility::setup_named_ai("griggs", "Sgt. Griggs", "start_snakecam_griggs", undefined, undefined, undefined, "Demon 1-2");
  var0 = getspawnerarray("ally_marine_snakecam");
  thread scripts\sp\maps\marines\marines_utility::marines_checkpoint_forcespawn_allies(var0);
  thread wolf_balcony_player_clip_handler();
  thread snakecam_marine_spawner_immediate();
  var1 = scripts\engine\utility::getStruct("snakecam_tripwire_struct", "targetname");
  var2 = getEnt("snakecam_tripwire_nav_clip", "targetname");
  var3 = scripts\engine\utility::getStruct("snakecam_tripwire_nav_clear_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("snakecam_tripwire_nav_block_struct", "targetname");
  scripts\sp\maps\marines\marines_lighting::sun_adjustments_hospital_force("lighting_hospital", 6);
  thread scripts\sp\maps\marines\marines_utility::marines_tripwire_monitor(var1, "flag_snakecam_tripwire_cleared", var2, var4, var3, 1, "flag_snakecam_tripwire_defused");
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_left");
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_right");
  scripts\engine\utility::flag_set("flag_mg_hall_cleared");
}

function snakecam_catchup() {
  thread snakecam_to_wolf();
  scripts\engine\utility::flag_set("flag_wolf_snakecam_complete");
}

function wolf_start() {
  scripts\engine\sp\utility::set_start_location("start_wolf", [level.player]);
  scripts\engine\sp\utility::activate_trigger_with_targetname("color_trigger_sledge_done");
  level.griggs = scripts\sp\maps\marines\marines_utility::setup_named_ai("griggs", "Sgt. Griggs", "start_snakecam_griggs", undefined, undefined, undefined, "Demon 1-2");
  var0 = getspawnerarray("ally_marine_snakecam");
  var1 = getspawner("ally_marine_wolf_extra_spawner", "targetname");
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_snakecam");
  thread scripts\sp\maps\marines\marines_utility::marines_checkpoint_forcespawn_allies(var0);
  thread snakecam_make_yellow_marine();
  thread wolf_balcony_player_clip_handler();
  var1 scripts\engine\sp\utility::spawn_ai();
  level.fail_state_active = 0;
  defuse_tripwires();
  scripts\sp\maps\marines\marines_lighting::sun_adjustments_hospital_force("lighting_hospital", 6);
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_left");
  hidemayhem("my_vfx_mayh_marines_wolfroom_door_breach_right");
  scripts\engine\utility::flag_set("flag_wolf_alternate_route_opened");
  level.wolf_nag_count = 0;
}

function wolf_catchup() {}

function wolf_hostage_handler() {
  var0 = getspawner("wolf_hostage_1_spawner", "targetname");
  var1 = getspawner("wolf_hostage_2_spawner", "targetname");
  var2 = getspawner("wolf_hostage_3_spawner", "targetname");
  level.wolf_hostages = [];
  var0 scripts\engine\sp\utility::add_spawn_function(&hostage_1_handler);
  var1 scripts\engine\sp\utility::add_spawn_function(&hostage_2_handler);
  var2 scripts\engine\sp\utility::add_spawn_function(&hostage_3_handler);
  level.wolf_hostage_1 = var0 scripts\engine\sp\utility::spawn_ai();
  level.wolf_hostage_2 = var1 scripts\engine\sp\utility::spawn_ai();
  level.wolf_hostage_3 = var2 scripts\engine\sp\utility::spawn_ai();
  waitframe();
  level.wolf_hostage_1.name = "Sgt. Norman";
  level.wolf_hostage_1.callsign = "Demon 3-2";
  level.wolf_hostage_2.name = "Cpl. Lee";
  level.wolf_hostage_2.callsign = "Demon 3-5";
  level.wolf_hostage_3.name = "Pvt. Hughes";
  level.wolf_hostage_3.callsign = "Demon 3-6";
  var3 = scripts\engine\sp\utility::get_living_ai_array("wolf_hostage_ai", "script_noteworthy");

  foreach(var5 in var3) {
    thread hostage_init();
    var5.sidearm = isundefinedweapon();
    var5.sidearm = "none";
    level.wolf_hostages = scripts\engine\utility::array_add(level.wolf_hostages, var5);
  }

  wait 2;

  foreach(var5 in var3) {
    var5.team = "allies";
  }

  scripts\engine\utility::flag_wait("flag_marines_cleanup");
  var3 = scripts\engine\sp\utility::get_living_ai_array("wolf_hostage_ai", "script_noteworthy");
  scripts\engine\utility::array_delete(var3);
}

function hostage_1_handler() {
  self endon("death");
  self endon("dead");
  self endon("wolfTakedown");
  self.allowdeath = 1;
  self.animname = "hostage01";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.pacifist = 1;
  self.ragdoll_immediate = 1;
  self.team = "neutral";
  level.wolf_hostage_1_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_hostage01", "targetname");
  level.wolf_hostage_1_struct thread scripts\common\anim::anim_loop_solo(self, "postBreachIdle", "raiseMachete");
  thread damagewatch(level.wolf_hostage_1_struct);
  level.wolf_hostage_1_struct waittill("raiseMachete");
  self stopanimScripted();
  level.wolf_hostage_1_struct scripts\common\anim::anim_single_solo(self, "postBreachRaiseMachete");
  level.wolf_hostage_1_struct scripts\common\anim::anim_loop_solo(self, "postBreachMacheteIdle", "executeHostage");
  self notify("newIdle");
  level.wolf_hostage_1_struct waittill("executeHostage");
  self stopanimScripted();
}

function hostage_2_handler() {
  self endon("death");
  self endon("wolfTakedown");
  self.allowdeath = 1;
  self.animname = "hostage02";
  self.ignoreall = 1;
  self.pacifist = 1;
  self.ragdoll_immediate = 1;
  self.team = "neutral";
  thread wolf_hostage_ignoreme_monitor();
  level.wolf_hostage_2_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_hostage02", "targetname");
  level.wolf_hostage_2_struct thread scripts\common\anim::anim_loop_solo(self, "postBreachIdle", "executeHostage");
  thread damagewatch(level.wolf_hostage_2_struct);
  level.wolf_hostage_2_struct waittill("executeHostage");
  self stopanimScripted();

  if(scripts\engine\utility::flag(self.animname + "_damaged")) {
    level.wolf_hostage_2_struct scripts\common\anim::anim_single_solo(self, "postBreachDeath");
    level.wolf_hostage_2_struct scripts\common\anim::anim_last_frame_solo(self, "postBreachDeath");
    return;
  }

  level.wolf_hostage_2_struct scripts\common\anim::anim_single_solo(self, "postBreachHostageDeath");
  level.wolf_hostage_2_struct thread scripts\common\anim::anim_loop_solo(self, "postBreachIdle");
}

function hostage_3_handler() {
  self endon("death");
  self endon("wolfTakedown");
  self.allowdeath = 1;
  self.animname = "hostage03";
  self.ignoreall = 1;
  self.pacifist = 1;
  self.ragdoll_immediate = 1;
  self.team = "neutral";
  thread wolf_hostage_ignoreme_monitor();
  thread wolf_hostage_takedown_monitor();
  level.wolf_hostage_3_struct = scripts\engine\utility::getStruct("wolfroom_breach_struct_hostage03", "targetname");
  level.wolf_hostage_3_struct thread scripts\common\anim::anim_loop_solo(self, "postBreachIdle", "executeHostage");
  thread damagewatch(level.wolf_hostage_3_struct);
  level.wolf_hostage_3_struct waittill("executeHostage");
  self stopanimScripted();

  if(scripts\engine\utility::flag(self.animname + "_damaged")) {
    level.wolf_hostage_3_struct scripts\common\anim::anim_single_solo(self, "postBreachDeath");
    level.wolf_hostage_3_struct scripts\common\anim::anim_last_frame_solo(self, "postBreachDeath");
    return;
  }

  level.wolf_hostage_3_struct scripts\common\anim::anim_single_solo(self, "postBreachHostageDeath");
  level.wolf_hostage_3_struct thread scripts\common\anim::anim_loop_solo(self, "postBreachIdle");
}

function wolf_hostage_ignoreme_monitor() {
  self.ignoreme = 1;
  level waittill("wolfguard_alerted");
  wait 1;
  self.ignoreme = 0;
}

function wolf_hostage_takedown_monitor() {
  self endon("death");
  level waittill("wolfTakedown");
  scripts\common\ai::magic_bullet_shield();
}

function damagewatch(var0) {
  self endon("wolfTakedown");
  scripts\engine\utility::flag_init(var0.animname + "_damaged");
  var0 waittill("damage", var1, var2, var3, var4, var5);
  level notify("missionfailed");

  if(var0.animname == "hostage01" && var2 == level.player && var5 != "MOD_IMPACT") {
    var0 kill();
    level notify("hostage1Dead");
    hostage_killed_fail_state();
    return;
  }

  scripts\engine\utility::flag_set(var0.animname + "_damaged");
  self notify("executeHostage");
  hostage_killed_fail_state();
}

function hostage_death(var0, var1) {
  scripts\common\anim::anim_single_solo(var0, var1);
  scripts\common\anim::anim_last_frame_solo(var0, var1);
}

function hostage_kill() {
  self.ignoreme = 1;
  hostage_killed_fail_state();
}

function hostage_init() {
  self endon("entitydeleted");
  self endon("death");
  self endon("dead");

  for(;;) {
    self.health = 9999;
    self waittill("damage", var0, var1, var2, var3, var4);

    if(var1 == level.wolf) {
      break;
    }

    if(scripts\engine\utility::flag("flag_wolf_alerted_early") && self != level.wolf_hostage_1) {
      if(var1 == level.wolf_cameraman || var1 == level.wolf_executioner) {
        thread hostage_kill();
        break;
      }
    }

    if(var1 == level.player) {
      if(self == level.wolf_hostage_1 && var4 != "MOD_MELEE") {
        level.wolf_hostage_1 notify("dead");
        hostage_death(level.wolf_hostage_1_struct, level.wolf_hostage_1, "postBreachDeath");
      }

      break;
    }
  }
}

function monitor_smoke() {
  level.b_smoke = 0;
  level.hospital_upperfloor_mg_los = 1;
  level.mg_hall_griggs_smoke_vo_done = 1;
  scripts\engine\utility::flag_clear("get_to_mgs");
  self endon("death");
  var0 = getEnt("hospital_upperfloor_smoke_grenade_volume", "targetname");

  for(;;) {
    level.player waittill("grenade_fire", var1, var2);

    if(!isDefined(var1)) {
      return;
    }

    if(!isDefined(var2.basename)) {
      return;
    }

    if(var2.basename == "smoke_tall") {
      var1 waittill("explode", var3);

      if(ispointinvolume(var3, var0)) {
        thread scripts\sp\maps\marines\marines_vo::vo_mghall_smoked_dialogue_handler();
        thread successful_smoke();
      }
    }

    wait 1;
  }
}

function successful_smoke() {
  wait 1;
  level.hospital_upperfloor_mg_los--;

  if(level.hospital_upperfloor_mg_los < 1) {
    level.b_smoke = 1;
  }

  var0 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");

  for(var1 = 0; var1 < 10; var1++) {
    if(sighttracepassed(var0.origin, level.player getEye(), 0, level.player, 1)) {
      break;
    }

    wait 1;
  }

  level.hospital_upperfloor_mg_los++;

  if(level.hospital_upperfloor_mg_los > 0) {
    level.b_smoke = 0;
    return;
  }
}

function upperfloor_murderhole_handler() {
  thread mg_hall_rpg_monitor();
  thread mg_sprint_trigger_monitor();
  scripts\engine\utility::flag_wait("flag_upperfloor_murderhole_spawn");
  wait randomfloatrange(0.25, 0.75);
  var0 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");
  var1 = spawn("script_origin", var0.origin);
  var1.angles = var0.angles;
  thread mg_hall_sign_magic_bullets();
  var2 = getspawner("aq_upperfloor_murderhole_gunner_spawner", "targetname");
  var3 = getEnt("info_volume_upperfloor_mg_gunner_abandon", "targetname");
  var4 = getEnt("mg_hall_gunner_damage_monitor", "targetname");
  var5 = getEnt("mg_hall_gunner_fake_target", "targetname");
  var6 = var2 scripts\engine\sp\utility::spawn_ai();
  var6.dummy_target = scripts\engine\utility::getStruct("aq_mghall_bait_a1_clip_block_struct", "targetname").origin;
  var6.ignoreme = 1;
  var6.no_pistol_switch = 1;
  var6.sidearm = isundefinedweapon();
  var6 scripts\engine\utility::disable_pain();
  var6 scripts\common\ai::magic_bullet_shield();
  var6 scripts\engine\sp\utility::set_allowdeath(1);
  var6 setentitytarget(var5);
  thread death_hint_watcher_marines_machinegun_death();
  thread mg_hall_gunner_death_monitor();
  thread mg_hall_gunner_idle_anim();
  var7 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var6 scripts\anim\shared::forceuseweapon(var7, "primary");
  waitframe();
  level.mg_damage_owner = var6;
  level.target_player_volumes = getEntArray("mg_hall_target_player", "targetname");
  thread mg_rotation(var1);
  thread ally_move_with_purpose();
  var8 = scripts\engine\utility::getStructArray("mg_dummy_target_mghall", "targetname");
  var1 scripts\sp\maps\marines\marines_utility::mg_gunner("iw8_ar_akilo47_marines_mghall", var8, &scripts\sp\maps\marines\marines_utility::mg_damage_smoke_nag_mghall, &scripts\sp\maps\marines\marines_utility::mg_intro_sequence_mg_hall, "upperfloor_murderhole_intro_complete", var4, ["flag_upperfloor_murderhole_flank_left", "flag_upperfloor_murderhole_flank_right", "mg_hall_gunner_dead", "flag_upperfloor_murderhole_abandon"], 120, undefined, 1, -1, 1);
  level notify("mg_ceasefire");

  if(isalive(var6)) {
    thread mg_hall_gunner_alert_monitor();
    var1 scripts\sp\maps\marines\marines_utility::mg_gunner("iw8_ar_akilo47_marines_mghall", var8, &scripts\sp\maps\marines\marines_utility::mg_damage_smoke_nag_mghall, undefined, "upperfloor_murderhole_intro_complete", var4, ["flag_mg_gunner_react", "mg_hall_gunner_dead"], 120, undefined, 1, -1, 1);
    level notify("mg_ceasefire");
  }

  if(isalive(var6)) {
    var6 unlink();
    var6.ignoreme = 0;
    var6.pacifist = 0;
    var6 clearentitytarget();
    var6 cleargoalvolume();
    var6 getenemyinfo(level.player);
    waitframe();
    var6 setgoalvolumeauto(var3);
    return;
  }
}

function ally_move_with_purpose() {
  wait 0.5;

  foreach(var1 in getaiarray("allies")) {
    var1 aisetdesiredspeed(200);
  }
}

function mg_sprint_trigger_monitor() {
  var0 = getEnt("trigger_allies_color_122", "targetname");
  var0 waittill("trigger");

  if(level.player issprinting()) {
    scripts\engine\utility::flag_set("flag_upperfloor_murderhole_spawn");
    return;
  }
}

function mg_hall_gunner_death_monitor() {
  for(;;) {
    jumpiftrue(isDefined(self)) LOC_0000000a;
    waitframe();
  }

  self waittill("death", var0);
  scripts\engine\utility::flag_set("mg_hall_gunner_dead");

  if(var0 == level.player) {
    thread scripts\sp\maps\marines\marines_vo::vo_mghall_griggs_gunner_dead_alex_dialogue();
  } else {
    thread scripts\sp\maps\marines\marines_vo::vo_mghall_marine_clear_dialogue();
  }

  var1 = scripts\engine\sp\utility::get_living_ai_array("ai_upperfloor_1", "script_noteworthy");

  if(var1.size > 0) {
    thread mg_hall_aq_killoff();
  }

  while(var1.size > 0) {
    var1 = scripts\engine\sp\utility::get_living_ai_array("ai_upperfloor_1", "script_noteworthy");
    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_mg_hall_cleared");
}

function mg_hall_aq_killoff() {
  var0 = getEnt("mghall_killoff_player_monitor", "targetname");
  var1 = getEnt("mghall_killoff_ai_monitor", "targetname");

  while(!scripts\engine\utility::flag("flag_mg_hall_cleared")) {
    if(ispointinvolume(level.player.origin, var0)) {
      var2 = scripts\engine\sp\utility::get_living_ai_array("ai_upperfloor_1", "script_noteworthy");

      if(var2.size > 0) {
        foreach(var4 in var2) {
          if(isDefined(var4) && isalive(var4) && !ispointinvolume(var4.origin, var1)) {
            var4 kill();
          }
        }

        waitframe();
      } else {
        break;
      }

      continue;
    }

    waitframe();
  }
}

function mg_hall_gunner_alert_monitor() {
  scripts\engine\utility::flag_wait("flag_mg_gunner_alert_logic");
  thread mg_hall_gunner_alert_proximity_monitor();
  thread mg_hall_gunner_reaction_animations();
  scripts\engine\utility::flag_wait_any("flag_mg_gunner_proximity_alert_right", "flag_mg_gunner_proximity_alert_left");
  scripts\engine\utility::waittill_any("bullethit", "bulletwhizby", "damage", "death", "grenade danger", "projectile_impact");
  scripts\engine\utility::flag_set("flag_upperfloor_murderhole_abandon");

  if(isalive(self)) {
    self clearentitytarget();
    waitframe();
    self getenemyinfo(level.player);
    self.ignoreall = 0;
    return;
  }
}

function mg_hall_gunner_alert_proximity_monitor() {
  scripts\engine\utility::flag_wait_any("flag_mg_gunner_proximity_alert_right", "flag_mg_gunner_proximity_alert_left");

  if(isDefined(self) && isalive(self)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\engine\utility::flag_set("flag_upperfloor_murderhole_abandon");

  if(isDefined(self) && isalive(self)) {
    self.ignoreall = 0;
    return;
  }
}

function pacify_allies() {
  var0 = getaiarray("allies");

  foreach(var2 in var0) {
    var2.pacifist = 1;
  }
}

function marines_breach() {
  scripts\engine\utility::flag_wait("marinesBreach");
  var0 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  if(var0.size < 3) {
    var1 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
    var0 = scripts\engine\utility::array_combine(var0, var1);
  }

  for(var0 = scripts\engine\utility::array_insert(var0, level.griggs, 0); var0.size > 3; var0 = scripts\engine\utility::array_remove(var0, var0[var0.size - 1])) {}

  for(var2 = 1; var2 < var0.size; var2++) {
    var0[var2].animname = "marine0" + var2;

    if(isDefined(var0[var2].asmname)) {
      var0[var2] scripts\common\utility::demeanor_override("casual");
    }
  }

  var3 = scripts\engine\utility::getStruct("breachMarinesStruct", "targetname");
  var3 thread scripts\common\anim::anim_single(var0, "takedown");
}

function wolf_player_demeanor_manager() {
  scripts\engine\utility::flag_wait("flag_wolf_breach_gundown");

  if(level.player scripts\engine\sp\utility::get_player_demeanor() != "relaxed") {
    level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
    return;
  }
}

function wolf_damage_monitor() {
  level endon("shotHostage");
  level.wolf.health = 9999;
  level.wolf_killed = 0;

  while(isDefined(level.wolf) && isalive(level.wolf)) {
    level.wolf waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7);

    if(var1 == level.player && var4 != "MOD_MELEE" && var4 != "MOD_IMPACT") {
      level.wolf notify("deadWolf");
      level.wolf_execute_struct notify("disable_wolf_machete_threaten");
      level.wolf_machete_struct notify("disable_wolf_machete_threaten");
      level.wolf thread scripts\sp\maps\marines\marines_utility::dialogue_stop();
      level.wolf.diequietly = 1;
      level.wolf.skip_friendly_fire_check = 1;
      level.wolf.skipdeathanim = 1;
      level.wolf stopsounds();
      level.wolf_killed = 1;
      thread play_and_hold_anim(level.wolf_execute_struct, level.wolf);
      thread wolf_killed_fail_state();
      break;
    }
  }
}

function play_and_hold_anim(var0, var1) {
  scripts\common\anim::anim_single_solo(var0, var1);
  scripts\common\anim::anim_last_frame_solo(var0, var1);
}

function wolf_killed_fail_state() {
  level.wolf_fail_state_active = 1;
  scripts\sp\player_death::set_custom_death_quote(406);
  scripts\sp\utility::missionfailedwrapper();
}

function hostage_executed_fail_state() {
  if(isDefined(level.wolf_fail_state_active) == 0 || level.wolf_fail_state_active == 0) {
    scripts\sp\player_death::set_custom_death_quote(411);
    scripts\sp\utility::missionfailedwrapper();
    return;
  }
}

function hostage_killed_fail_state() {
  wait 1.5;

  if(isDefined(level.wolf_fail_state_active) == 0 || level.wolf_fail_state_active == 0) {
    scripts\sp\player_death::set_custom_death_quote(412);
    scripts\sp\utility::missionfailedwrapper();
    return;
  }
}

function proxy_hostage_killed_fail_state() {
  if(isDefined(level.wolf_fail_state_active) == 0 || level.wolf_fail_state_active == 0) {
    level.wolf_fail_state_active = 1;
    thread proxy_execution_fail_hide_names();
    wait 1.5;
    scripts\sp\player_death::set_custom_death_quote(414);
    scripts\sp\utility::missionfailedwrapper();
    return;
  }
}

function death_hint_watcher_marines_machinegun_death() {
  level endon("mg_ceasefire");
  level.player waittill("death", var0);

  if(var0 == self) {
    scripts\sp\player_death::set_custom_death_quote(404);
    return;
  }
}

function snakecam_marine_spawner() {
  var0 = getspawner("snakecam_marine_left_spawner", "targetname");
  var1 = getspawner("snakecam_marine_right_spawner", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&snakecam_marine_behavior);
  var1 scripts\engine\sp\utility::add_spawn_function(&snakecam_marine_behavior);
  level.snakecam_marine_spawned = 0;
  thread snakecam_marine_spawn_monitor("flag_mg_gunner_proximity_alert_left", var0);
  thread snakecam_marine_spawn_monitor("flag_mg_gunner_proximity_alert_right", var1);
  thread snakecam_marine_forcespawn(var0, var1);
}

function snakecam_marine_spawner_immediate() {
  var0 = getspawner("snakecam_marine_left_spawner", "targetname");
  var1 = getspawner("snakecam_marine_right_spawner", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&snakecam_marine_behavior);
  var1 scripts\engine\sp\utility::add_spawn_function(&snakecam_marine_behavior);

  if(scripts\engine\utility::cointoss()) {
    var0.script_forcespawn = 1;
    level.snakecam_marine = var0 scripts\engine\sp\utility::spawn_ai();
    return;
  }

  var1.script_forcespawn = 1;
  level.snakecam_marine = var1 scripts\engine\sp\utility::spawn_ai();
}

function snakecam_marine_spawn_monitor(var0, var1) {
  scripts\engine\utility::flag_wait(var0);

  if(level.snakecam_marine_spawned == 0) {
    level.snakecam_marine = var1 scripts\engine\sp\utility::spawn_ai();
    return;
  }
}

function snakecam_marine_behavior() {
  self endon("death");
  self endon("entitydeleted");
  level.snakecam_marine_spawned = 1;
  self.animname = "snakecam03";
  self.dontavoidplayer = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.doavoidanceblocking = 0;
  self.dontchangepushplayer = undefined;
  self.ignoreplayersuppressionlines = 1;
  self.disableplayeradsloscheck = 1;
  scripts\engine\utility::disable_pain();
  scripts\common\ai::magic_bullet_shield();
  thread scripts\sp\maps\marines\marines_utility::marine_callsign_picker();
  setcharmodels("body_usmc_basic_ar_1", "head_sc_m_colvin", undefined);
}

function snakecam_marine_forcespawn(var0, var1) {
  scripts\engine\utility::flag_wait_all("flag_snakecam_tripwire_cleared", "flag_snakecam_griggs_tripwire_vo");

  if(level.snakecam_marine_spawned == 0) {
    if(scripts\engine\utility::cointoss()) {
      var0.script_forcespawn = 1;
      level.snakecam_marine = var0 scripts\engine\sp\utility::spawn_ai();
      return;
    }

    var1.script_forcespawn = 1;
    level.snakecam_marine = var1 scripts\engine\sp\utility::spawn_ai();
    return;
  }
}

function wolf_room_pre_breach_door() {
  var0 = getEnt("color_trigger_snakecam_start", "targetname");
  var1 = getEnt("snakeCam", "targetname");
  var2 = getnode("snakecam_marine_post_node", "targetname");
  var3 = scripts\engine\utility::getStruct("wolfroom_snakecam_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("snakecam_marine_teleport_struct", "targetname");
  var1.animname = "snakecam";
  var1 scripts\engine\sp\utility::assign_animtree("snakecam");

  while(!isDefined(level.snakecam_marine)) {
    waitframe();
  }

  var5 = [level.snakecam_marine, var1];

  if(isDefined(var0)) {
    var0 scripts\engine\utility::trigger_off();
  }

  waitframe();

  if(scripts\engine\utility::flag("flag_snakecam_tripwire_defused")) {
    level.snakecam_marine forceteleport(var4.origin, var4.angles);
    level.snakecam_marine setgoalpos(var4.origin);
  } else {
    snakecam_marine_moveto_node(var3);
  }

  thread snakecam_make_yellow_marine();
  scripts\engine\sp\utility::activate_trigger("color_trigger_snakecam_setup", "targetname");
  var6 = 0.2;
  var3 scripts\common\anim::anim_single(var5, "wolf_room_snakecam_enter");
  level.snakecam_marine setgoalpos(level.snakecam_marine.origin);
  var3 thread scripts\common\anim::anim_loop(var5, "wolf_room_snakecam_enter_idle", "endSnakeCamLoop");
  scripts\engine\utility::flag_set("snakecam_enable_flag");
  scripts\engine\utility::flag_wait("flag_wolf_snakecam_starting");
  thread scripts\sp\maps\marines\marines_vo::mus_snakecam_enter();
  level.snakecam_marine scripts\sp\maps\marines\marines_utility::marines_stoplookat();
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  scripts\engine\utility::flag_wait("exit_snakecam_immediately");
  var3 notify("endSnakeCamLoop");
  var3 thread scripts\common\anim::anim_single_solo(var1, "wolf_room_snakecam_exit");
  var3 scripts\common\anim::anim_single_solo(level.snakecam_marine, "wolf_room_snakecam_exit");
  level.snakecam_marine scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  scripts\engine\sp\utility::activate_trigger("color_trigger_snakecam_relocate", "targetname");
  level.snakecam_marine scripts\common\ai::stop_magic_bullet_shield();
  level.snakecam_marine scripts\engine\utility::set_movement_speed(100);
  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");

  if(isDefined(level.snakecam_marine) && isalive(level.snakecam_marine)) {
    level.snakecam_marine scripts\sp\maps\marines\marines_utility::switch_marine_color("p", "g");
    level.snakecam_marine scripts\common\utility::clear_movement_speed();
  }

  var7 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");
  var8 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
  var9 = [];
  var9 = scripts\engine\utility::array_add(var7, var9);
  var9 = scripts\engine\utility::array_add(var8, var9);

  foreach(var11 in var9) {
    if(isDefined(var11) && isalive(var11)) {
      if(isDefined(var11.dontevershoot)) {
        if(var11.dontevershoot == 1) {
          var11 scripts\engine\sp\utility::disable_dontevershoot();
        }

        var11 clearentitytarget();
      }
    }
  }
}

function snakecam_marine_moveto_node(var0) {
  self endon("snakecam_marine_at_node");
  thread snakecam_marine_timer();
  var0 scripts\sp\anim::anim_reach_solo(level.snakecam_marine, "wolf_room_snakecam_enter");
  level.snakecam_marine_reached_node = 1;
}

function snakecam_marine_timer() {
  var0 = scripts\engine\utility::getStruct("snakecam_marine_teleport_struct", "targetname");
  level.snakecam_marine_reached_node = 0;
  var1 = 0;
  var2 = 10;

  while(level.snakecam_marine_reached_node == 0 && var1 < var2) {
    wait 0.1;
    var1 += 0.1;
  }

  if(isDefined(level.snakecam_marine) && isalive(level.snakecam_marine) && level.snakecam_marine_reached_node == 0) {
    level.snakecam_marine forceteleport(var0.origin, var0.angles);
    level.snakecam_marine setgoalpos(var0.origin);
    self notify("snakecam_marine_at_node");
    return;
  }
}

function snakecam_make_yellow_marine() {
  var0 = getnode("snakecam_post_node", "targetname");
  var1 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");

  while(var1.size < 1) {
    waitframe();
  }

  var2 = sortbydistance(var1, var0.origin);
  var2[0] scripts\sp\maps\marines\marines_utility::switch_marine_color("g", "y");
  scripts\engine\utility::flag_wait("exit_snakecam_immediately");

  if(isDefined(var2[0]) && isalive(var2[0])) {
    var2[0] scripts\engine\utility::set_movement_speed(100);
  }

  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");

  if(isDefined(var2[0]) && isalive(var2[0])) {
    var2[0] scripts\sp\maps\marines\marines_utility::switch_marine_color("y", "g");
    var2[0] scripts\common\utility::clear_movement_speed();
    return;
  }
}

function wolf_room_pre_breach_scene() {
  var0 = getspawner("wolf_proxy_hostage_1_spawner", "targetname");
  var1 = getspawner("wolf_proxy_hostage_3_spawner", "targetname");
  var2 = getspawner("wolf_proxy_hostage_2_spawner", "targetname");
  var3 = getEnt("wolf_proxy_machete_table", "targetname");
  var4 = scripts\engine\utility::getStruct("wolf_proxy_machete_table_hide_struct", "targetname");
  var5 = scripts\engine\utility::getStruct("wolf_proxy_machete_table_show_struct", "targetname");
  level.wolf_proxy_hostage_1 = var0 scripts\engine\sp\utility::spawn_ai();
  level.wolf_proxy_hostage_2 = var1 scripts\engine\sp\utility::spawn_ai();
  level.wolf_proxy_hostage_3 = var2 scripts\engine\sp\utility::spawn_ai();
  level.wolf_proxy_hostage_1.sidearm = isundefinedweapon();
  level.wolf_proxy_hostage_2.sidearm = isundefinedweapon();
  level.wolf_proxy_hostage_3.sidearm = isundefinedweapon();
  level.wolf_proxy_hostage_1.sidearm = "none";
  level.wolf_proxy_hostage_2.sidearm = "none";
  level.wolf_proxy_hostage_3.sidearm = "none";
  level.wolf_proxy_hostage_1.name = "Sgt. Norman";
  level.wolf_proxy_hostage_1.callsign = "Demon 3-2";
  level.wolf_proxy_hostage_2.name = "Cpl. Lee";
  level.wolf_proxy_hostage_2.callsign = "Demon 3-5";
  level.wolf_proxy_hostage_3.name = "Pvt. Hughes";
  level.wolf_proxy_hostage_3.callsign = "Demon 3-6";
  var3 moveTo(var5.origin, 0.1);
  level.player waittill("enter_cam");
  thread snakecam_exit_manager();
  thread wolf_proxy_cameraman_handler();
  thread wolf_proxy_executioner_handler();
  thread wolf_proxy_handler();
  thread proxy_hostage_1_handler();
  thread proxy_hostage_2_handler();
  thread proxy_hostage_3_handler();
  scripts\engine\utility::flag_wait("flag_wolf_cleanup_snakecam_marine");
  level.wolf_machete_prop hide();
  level.wolf_machete_prop unlink();
  waitframe();
  var6 = scripts\engine\sp\utility::get_living_ai_array("wolf_proxy_ai", "script_noteworthy");
  scripts\engine\utility::array_delete(var6);
  var3 moveTo(var4.origin, 0.1);
}

function wolf_proxy_cameraman_handler() {
  var0 = getEnt("wolf_camera_proxy_top", "targetname");
  var1 = getEnt("wolf_camera_proxy_bot", "targetname");
  var2 = scripts\engine\utility::getStruct("wolf_camera_proxy_top_hide_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("wolf_camera_proxy_top_show_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("wolf_camera_proxy_bot_hide_struct", "targetname");
  var5 = scripts\engine\utility::getStruct("wolf_camera_proxy_bot_show_struct", "targetname");
  var6 = getspawner("wolf_proxy_cameraman_spawner", "targetname");
  var7 = scripts\engine\utility::getStruct("wolf_proxy_cameraman_struct", "targetname");
  var6 scripts\engine\sp\utility::add_spawn_function(&proxyaniminit);
  level.wolf_proxy_cameraman = var6 scripts\engine\sp\utility::spawn_ai();
  var8 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  level.wolf_proxy_cameraman scripts\anim\shared::forceuseweapon(var8, "primary");
  var1 linkTo(var0);
  waitframe();
  setcharmodels(level.wolf_proxy_cameraman, "body_al_qatala_desert_09_b", "head_al_qatala_desert_06", undefined);
  var0 moveTo(var3.origin, 0.1);
  thread proxy_cameraman_handler();
  scripts\engine\utility::flag_wait("flag_wolf_cleanup_snakecam_marine");
  var0 moveTo(var2.origin, 0.1);
}

function wolf_proxy_executioner_handler() {
  var0 = getspawner("wolf_proxy_executioner_spawner", "targetname");
  var0 scripts\engine\sp\utility::add_spawn_function(&proxyaniminit);
  level.wolf_proxy_executioner = var0 scripts\engine\sp\utility::spawn_ai();
  waitframe();

  if(isDefined(level.wolf_proxy_executioner.asmname)) {
    level.wolf_proxy_executioner scripts\common\utility::demeanor_override("casual_gun");
  }

  setcharmodels(level.wolf_proxy_executioner, "body_al_qatala_4_ar", "head_al_qatala_desert_05", undefined);
  level.wolf_proxy_executioner.setgoalpos = level.wolf_proxy_executioner.origin;
  thread proxy_executioner_handler();
}

function proxy_hostage_1_handler() {
  level.player endon("leave_cam");
  self.animname = "hostage01Proxy";
  level.wolf_proxy_hostage_1_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_hostage01", "targetname");
  level.wolf_proxy_hostage_1_struct thread scripts\common\anim::anim_loop_solo(self, "preBreachIdle", "wolf_done_speaking");
  level.wolf_proxy_hostage_1_struct waittill("wolf_done_speaking");
  self stopanimScripted();
  level.wolf_proxy_hostage_1_struct scripts\common\anim::anim_single_solo(self, "preBreachKick");
  level.wolf_proxy_hostage_1_struct scripts\common\anim::anim_loop_solo(self, "preBreachKickedGrab");
}

function proxy_hostage_2_handler() {
  level.player endon("leave_cam");
  self.animname = "hostage02Proxy";
  level.wolf_proxy_hostage_2_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_hostage02", "targetname");
  applyoffset(level.wolf_proxy_hostage_2_struct, (0, 0, -0.5));
  level.wolf_proxy_hostage_2_struct scripts\common\anim::anim_single_solo(self, "preBreachIdle1Pass");
  level.wolf_proxy_hostage_2_struct scripts\common\anim::anim_single_solo(self, "preBreachSlump");
  level.wolf_proxy_hostage_2_struct scripts\common\anim::anim_loop_solo(self, "preBreachIdle");
}

function proxy_hostage_3_handler() {
  level.player endon("leave_cam");
  self.animname = "hostage03Proxy";
  level.wolf_proxy_hostage_3_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_hostage03", "targetname");
  applyoffset(level.wolf_proxy_hostage_3_struct, (0, 0, 1));
  level.wolf_proxy_hostage_3_struct scripts\common\anim::anim_loop_solo(self, "preBreachIdle");
}

function proxy_executioner_handler() {
  level.player endon("leave_cam");
  self.animname = "executionerProxy";
  level.wolf_proxy_executioner_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_executioner", "targetname");
  level.wolf_proxy_executioner_struct scripts\common\anim::anim_single_solo(self, "preBreachIdle1Pass");
  level.wolf_proxy_executioner_struct scripts\common\anim::anim_single_solo(self, "preBreachHostageGrab");
  level.wolf_proxy_executioner_struct thread scripts\common\anim::anim_loop_solo(self, "preBreachIdle", "wolf_done_speaking");
  level.wolf_proxy_executioner_struct waittill("wolf_done_speaking");
  self stopanimScripted();
  level.wolf_proxy_executioner_struct scripts\common\anim::anim_single_solo(self, "preBreachKick");
  level.wolf_proxy_executioner_struct scripts\common\anim::anim_loop_solo(self, "preBreachIdle");
}

function proxy_cameraman_handler() {
  level.player endon("leave_cam");
  self.animname = "cameramanProxy";
  level.wolf_proxy_cameraman_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_cameraman", "targetname");
  level.wolf_proxy_cameraman_struct scripts\common\anim::anim_loop_solo(self, "preBreachIdle");
}

function applyoffset(var0) {
  self.origin += var0;
}

function setcharmodels(var0, var1, var2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var0);

  if(isDefined(var1) && var1 != "") {
    self attach(var1, "", 1);
    self.headmodel = var1;
    return;
  }

  self.headmodel = undefined;
}

function wolf_proxy_handler() {
  level.player endon("leave_cam");
  var0 = getEnt("aq_proxy_wolf_goto_volume", "targetname");
  var1 = getspawner("proxy_wolf_spawner", "targetname");
  level.wolf_machete_prop = getEnt("preBreachMacheteProp", "targetname");
  level.machete_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_machete", "targetname");
  level.wolf_proxy_talk_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_wolf", "targetname");
  level.wolf_proxy_execute_struct = scripts\engine\utility::getStruct("wolfroom_prebreach_struct_wolf_execute", "targetname");
  level.wolf_nag_count = 0;
  waitframe();
  var1 scripts\engine\sp\utility::add_spawn_function(&proxyaniminit);
  level.proxy_wolf = var1 scripts\engine\sp\utility::spawn_ai();
  level.proxy_wolf.animname = "wolfProxy";
  level.proxy_wolf.name = "^1The Wolf";
  level.proxy_wolf.callsign = "^1Omar Sulaman";
  level.proxy_wolf.team = "allies";
  level.proxy_wolf scripts\common\ai::gun_remove();

  if(isDefined(level.proxy_wolf.asmname)) {
    level.proxy_wolf scripts\common\utility::demeanor_override("casual");
  }

  level.wolf_machete_prop.animname = "machete";
  level.wolf_machete_prop scripts\engine\sp\utility::assign_animtree("machete");
  var2 = [level.proxy_wolf];
  thread scripts\sp\maps\marines\marines_vo::vo_snakecam_hostage_dialogue();
  level.wolf_proxy_talk_struct scripts\common\anim::anim_single_solo(level.proxy_wolf, "preBreachSpeechIdle");
  level.machete_struct notify("wolf_done_speaking");
  level.wolf_proxy_executioner_struct notify("wolf_done_speaking");
  level.wolf_proxy_hostage_1_struct notify("wolf_done_speaking");
  level.wolf_machete_prop stopanimScripted();
  var3 = 8.5;
  level.wolf_proxy_talk_struct thread scripts\common\anim::anim_single(var2, "preBreachHostageGrab");
  wait var3;
  level.wolf_machete_prop linkTo(level.proxy_wolf, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  wait getanimlength(scripts\engine\utility::getanim_from_animname("preBreachHostageGrab", "wolfProxy")) - var3;
  level.wolf_proxy_talk_struct scripts\common\anim::anim_single(var2, "preBreachHostageGrabIdle");
  level.wolf_proxy_talk_struct thread scripts\common\anim::anim_loop(var2, "preBreachHostageGrabIdle2", "disable_wolf_proxy_machete_threaten");
  thread scripts\sp\maps\marines\marines_vo::vo_snakecam_wolf_dialogue();
  level.proxy_wolf waittill("execute_hostage");
  thread wolf_proxy_execute_hostage();
}

function wolf_proxy_execute_hostage() {
  thread proxy_hostage_killed_fail_state();
  thread wolf_proxy_execute_hostage_wolf_proxy_animation();
  thread wolf_proxy_execute_hostage_hostage_animation();
}

function wolf_proxy_execute_hostage_wolf_proxy_animation() {
  self notify("disable_wolf_proxy_machete_threaten");
  level.wolf_proxy_execute_struct scripts\common\anim::anim_single_solo(self, "preBreachExecute");
  level.wolf_proxy_execute_struct scripts\common\anim::anim_single_solo(self, "preBreachMacheteSlash");
}

function wolf_proxy_execute_hostage_hostage_animation() {
  anim_hold_last_frame_solo(level.wolf_proxy_execute_struct, self, "preBreachExecute");
}

function proxyaniminit() {
  self.animname = "generic";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.pacifist = 1;
  self.ragdoll_immediate = 1;
  self.team = "neutral";
}

function mg_autosave() {
  scripts\engine\utility::flag_wait("flag_upperfloor_murderhole_bait");
  level.player.health = 100;
  scripts\sp\maps\marines\marines_utility::marines_autosave([scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname")]);
  scripts\engine\utility::flag_wait_any("flag_mg_hall_autosave_mid", "flag_upperfloor_murderhole_flank_right");
  scripts\sp\maps\marines\marines_utility::marines_autosave([scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname")]);
}

function snakecam_sequence() {
  level.player endon("death");
  var0 = getnode("snakecam_post_node", "targetname");
  childthread scripts\sp\maps\marines\marines_vo::vo_snakecam_griggs_snakecam_start_dialogue();
  GscBinSkip4(0x35);
}

function snakecam_exit_monitor() {
  scripts\engine\utility::ent_flag_init("leave_cam");
  self waittill("leave_cam");
  scripts\engine\utility::ent_flag_set("leave_cam");
}

function snakecam_enter_fadein(var0) {
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(0.4);
  var0.alpha = 1;
  wait 0.5;
  var0 fadeovertime(0.15);
  var0.alpha = 0;
}

function fake_snake_cam_logic() {
  var0 = getEnt("wolf_breach_door", "targetname");
  var1 = anglestoup(self.angles * -1);
  var2 = 0;
  snakecam_cursor_hint();
  level.player allowmovement(0);
  level.player freezelookcontrols(1);
  self notify("stop_cursor_hint_thread");
  level.player scripts\engine\utility::ent_flag_set("using_snakecam");
  waitframe();
  level.player freezelookcontrols(0);
  scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 0);

  if(level.player isnightvisionon()) {
    var2 = 1;
    level.player nightvisiongogglesforceoff();
  }

  level.player scripts\engine\sp\utility::allow_nvg(0, "snakeCam", 1);
  level.player modifybasefov(45, 0.4);
  level thread scripts\game\sp\door::static_burst(0.2);
  thread snakecam_enter_fadein();
  level.player notify("enter_cam");
  level.player.og_origin = level.player.origin;
  level.player.og_angles = level.player getplayerangles();
  level.player.og_stance = level.player getstance();
  level.player freezecontrols(1);
  level.player disableweapons();

  if(scripts\engine\utility::flag_exist("hold_context_melee")) {
    scripts\engine\utility::flag_set("hold_context_melee");
  }

  level.player.ignore_stealth_sight = 1;
  level.player.ignoreme = 1;
  scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.5);
  var3 = anglesToForward(self.angles);
  var4 = vectorNormalize(self.origin - level.player getorigin());
  var5 = vectordot(var3, var4);
  var6 = level.player scripts\engine\utility::spawn_tag_origin();
  var6.origin = var0.origin + (0, 10, 0);
  var6.angles = var0.angles + (0, 180, 0);
  level.snakecam = var6;

  if(isDefined(self.target)) {
    var7 = scripts\engine\utility::getStruct(self.target, "targetname");

    if(!isDefined(var7)) {
      var7 = getEnt(self.target, "targetname");
    }

    if(isDefined(var7)) {
      var6.origin = var7.origin;
      var6.angles = var7.angles;
    }
  }

  if(isDefined(self.door)) {
    self.door.clip disconnectPaths();
  }

  scripts\game\sp\door::put_player_on_cam(var6);
  level.player hideviewmodel();
  level.proxy_wolf thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, 2, undefined, "tag_eye");
  var8 = level.player scripts\engine\utility::spawn_script_origin();
  var6.tempmovesoundent = level.player scripts\engine\utility::spawn_script_origin();
  var6.rumbleent = level.player scripts\engine\utility::spawn_script_origin();
  var8 scalevolume(0, 0);
  var8 playLoopSound("snake_cam_roomtone");
  var8 scalevolume(1, 1);
  var6.tempmovesoundent playLoopSound("snake_cam_foley");
  var6 thread scripts\game\sp\door::snake_cam_control();
  scripts\game\sp\door::set_snake_cam_vision("snake_cam_v2");
  level.cam_hud = snake_door_cam_hud_blur_v3();
  thread snakecam_dialogue_manager();

  while(level.player useButtonPressed()) {
    if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_wait("snakecam_allow_exit");
  waittill_player_exits_cam();

  if(isDefined(level.proxy_wolf) && isalive(level.proxy_wolf)) {
    level.proxy_wolf thread scripts\sp\maps\marines\marines_utility::dialogue_stop();
  }

  level notify("kill_snakecam_timer_fail_logic");
  level thread scripts\game\sp\door::static_burst(0.1);
  var9 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var9 fadeovertime(0.4);
  var9.alpha = 1;
  wait 0.5;
  level.marines_snakecam_exit_cleared = 1;
  var10 = var6.origin + anglesToForward(var6.angles) * -20;

  if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
    var6 moveTo(var10, 0.05);
  } else {
    var6 moveTo(var10, 0.5, 0.125);
  }

  scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
  level.player notify("leave_cam");

  foreach(var12 in level.cam_hud) {
    var12 destroy();
  }

  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "exit_snakecam_immediately");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "static_faded_in");
  scripts\engine\sp\utility::do_wait_any();
  scripts\sp\outline::outline_fade_alpha_for_index(6, 0.8, 0);
  var8 stoploopsound("snake_cam_roomtone");
  var6.tempmovesoundent stoploopsound("snake_cam_foley");
  visionsetfadetoblack("", 0.05);
  setsaveddvar("OMRQKMSSPP", 0);
  setsaveddvar("MLTTMLTKOR", 0);
  setsaveddvar("NKTRSSTMRQ", 0);
  setsaveddvar("LSOPQMRPNR", 0);
  level.player scripts\engine\sp\utility::allow_nvg(1, "snakeCam");

  if(var2) {
    level.player nightvisiongogglesforceon();
  }

  scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.1);

  if(!isDefined(level.fov_default)) {
    level.fov_default = 65;
  }

  level.player modifybasefov(level.fov_default, 0.05);
  thread snakecam_to_wolf();
  wait 0.25;
  remove_player_from_cam();
  var9 fadeovertime(0.15);
  var9.alpha = 0;
  level.player showviewmodel();
  scripts\engine\sp\utility::dof_disable();

  if(scripts\engine\utility::flag_exist("hold_context_melee")) {
    scripts\engine\utility::flag_clear("hold_context_melee");
  }

  if(isDefined(self.door)) {
    self.door.clip connectpaths();
  }

  level.player.ignore_stealth_sight = undefined;
  level.player.ignoreme = 0;
  var6.tempmovesoundent delete();
  var6.rumbleent delete();
  var6 delete();
  var8 delete();

  if(isDefined(self.door)) {
    self.door.snakecam_active = 0;
  }

  while(level.player useButtonPressed()) {
    if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      break;
    }

    wait 0.05;
  }

  level.player scripts\engine\utility::ent_flag_clear("using_snakecam");
  scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 6);
}

function snakecam_cursor_hint() {
  var0 = getEnt("snakeCam", "targetname");
  var1 = spawn("script_origin", var0.origin);
  var1.angles = (0, 100, 0);
  var1 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"MARINES/HINT_USE_SNAKECAM", undefined, 150 * level.interactive_doors.hint_dist_scale, 100 * level.interactive_doors.hint_dist_scale, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 120);
  var1.cursor_hint_ent linkTo(var0);
  var1 waittill("trigger");
  var1 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function snake_door_cam_hud_blur_v3() {
  var0 = newhudelem();
  var0.archived = 0;
  var0.location = 0;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.foreground = 1;
  var0.fontscale = 1;
  var0.sort = 20;
  var0.alpha = 0.5;
  var0.x = 320;
  var0.y = 240;
  var0 settext("+");
  var1 = newhudelem();
  var1.x = 400;
  var1.y = 180;
  var1.alignx = "center";
  var1.aligny = "middle";
  var1.font = "smallfixed";
  var1.fontscale = 0.75;
  var2 = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar("OMRQKMSSPP", 0.5);
  setsaveddvar("MLTTMLTKOR", 0.2);
  setsaveddvar("NKTRSSTMRQ", -0.75);
  setsaveddvar("LSOPQMRPNR", 0.011);
  return [var0, var2, var1];
}

function waittill_player_exits_cam() {
  for(;;) {
    if(player_is_trying_to_exit_camera()) {
      break;
    }

    if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      break;
    }

    waitframe();
  }
}

function player_is_trying_to_exit_camera() {
  return level.player useButtonPressed() || level.player buttonPressed("BUTTON_B");
}

function snakecam_dialogue_manager() {
  level.player endon("leave_cam");
  wait 1;
  thread snakecam_hint_timer();
}

function snakecam_hint_timer() {
  thread snakecam_movement_monitor();
  wait 2;

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_moved")) {
    thread snakecam_controls_hint_handler();
    scripts\engine\utility::flag_set("flag_wolf_snakecam_moved");
    return;
  }
}

function snakecam_movement_monitor() {
  wait 0.5;

  while(!scripts\engine\utility::flag("flag_wolf_snakecam_moved")) {
    [var2, var1] = level.player getnormalizedcameramovement();

    if(var1 != 0 || var2 != 0) {
      scripts\engine\utility::flag_set("flag_wolf_snakecam_moved");
    }

    waitframe();
  }
}

function snakecam_exit_manager() {
  level endon("kill_snakecam_timer_fail_logic");
  thread snakecam_exit_input_manager();
  scripts\engine\utility::flag_wait("flag_vo_final_line_done");
  level.fail_state_active = 1;
  level.proxy_wolf notify("execute_hostage");
}

function snakecam_exit_input_manager() {
  level endon("exit_snakecam_immediately");
  wait 0.75;
  level.player enableusability();
  var0 = spawn("script_model", level.player.origin + (0, 0, -128));
  var0 makeusable();
  var0 setCursorHint("HINT_NOICON");
  var0 setHintString(&"MENU/EXIT_SNAKECAM");
  var0 sethintonobstruction("show");
  var0 sethintrequiresholding(1);
  var0 setuseholdduration("duration_medium");
  var0 sethintdisplayrange(1200);
  var0 setuserange(12000);
  var0 waittill("trigger");
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
  scripts\game\sp\door::snakecam_allow_exit();
  scripts\engine\utility::flag_set("exit_snakecam_immediately");
}

function snakecam_exit_ui_manager() {
  level endon("exit_snakecam_immediately");
  wait 0.5;
  setomnvar("ui_snakecam", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var0, var1);

    if(var0 == "snakecam_exit") {
      setomnvar("ui_snakecam", 0);
      scripts\game\sp\door::snakecam_allow_exit();
      scripts\engine\utility::flag_set("exit_snakecam_immediately");
    }
  }
}

function remove_player_from_cam() {
  level.player setOrigin(level.player.og_origin);
  level.player setplayerangles(level.player.og_angles);
  level.player setstance(level.player.og_stance);
  level.player unlink();
  level.player.cam_ent delete();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player allowprone(1);
  level.player enableusability();
  level.player playerenabletriggers();
  scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
  level.player.ignoreme = 0;
  level.player enableweapons();
  level.player allowmovement(1);
  level.player enableoffhandprimaryweapons();
  level.player enableoffhandsecondaryweapons();
  level.player allowfire(1);
  level.player allowmelee(1);
}

function rally_to_snakecam_door() {
  var0 = getEnt("wolf_door_faketarget", "targetname");
  var1 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");
  var2 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
  var3 = [];
  var3 = scripts\engine\utility::array_add(var1, var3);
  var3 = scripts\engine\utility::array_add(var2, var3);

  foreach(var5 in var3) {
    if(isDefined(var5) && isalive(var5)) {
      thread rally_to_snakecam_door_monitor();

      if(!isDefined(var5.dontevershoot)) {
        var5 scripts\engine\sp\utility::enable_dontevershoot();
      } else if(var5.dontevershoot == 0) {
        var5 scripts\engine\sp\utility::enable_dontevershoot();
      }

      var5 clearentitytarget();
      waitframe();
      var5 setentitytarget(var0);
    }
  }
}

function shelfexit(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = getnode("wolf_alternate_path_advance_arrival_node_r2", "targetname");
  var9 = getEnt("wolf_alternate_path_marine_faketarget", "targetname");
  var10 = getEnt("wolf_balcony_player_blocker_1", "targetname");
  var11 = getEnt("wolf_balcony_player_blocker_2", "targetname");
  var12 = getnode("nonShelfSoldierBack_node", "targetname");
  var13 = getnode("nonShelfMarineFront_node", "targetname");
  var5.animname = "shelfMarine";
  var6.animname = "nonShelfMarineBack";
  var7.animname = "nonShelfMarineFront";
  var4.animname = "shelf";
  var4 scripts\engine\sp\utility::assign_animtree("shelf");
  var0 thread scripts\common\anim::anim_loop_solo(var5, "shelfPrePushIdle", "exitWindow");
  var1 thread scripts\common\anim::anim_loop_solo(var7, "shelfPrePushIdle", "exitWindow");
  var2 thread scripts\common\anim::anim_loop_solo(var6, "shelfPrePushIdle", "exitWindow");

  if(isDefined(var7) && isalive(var7)) {
    var7 allowedstances("stand");
  }

  if(isDefined(var6) && isalive(var6)) {
    var6 allowedstances("stand");
  }

  scripts\engine\utility::flag_set("flag_wolf_cleanup_snakecam_marine");
  wait 1;

  if(level.fail_state_active == 0) {
    thread scripts\sp\maps\marines\marines_vo::vo_wolf_alex_start_dialogue();
  }

  thread wolf_barricade_lookat_monitor();
  thread wolf_barricade_lookat_timeout();
  scripts\engine\utility::flag_wait("flag_wolf_open_alternate_path");
  var3 thread scripts\common\anim::anim_single_solo(var4, "shelfPush");
  thread barricade_player_crushed_monitor(var4);
  thread wolf_clear_window_barricade();
  scripts\engine\utility::flag_set("flag_wolf_alternate_route_opened");
  scripts\engine\sp\utility::activate_trigger("color_trigger_sledge_done", "targetname");
  var0 notify("exitWindow");
  var2 notify("exitWindow");
  var1 notify("exitWindow");
  waitframe();
  thread front_mantle_handler_right(var6, var2, 14.9, "twoMarinesWindowExit", var10, 8);
  thread front_mantle_handler_left(var7, var1, 11.16, "twoMarinesWindowExit", var11, 10.5);
  var0 scripts\common\anim::anim_single_solo(var5, "shelfPush");
  var0 thread scripts\common\anim::anim_loop_solo(var5, "postPushIdle", "windowExitAdvance");
  scripts\engine\utility::flag_wait("flag_wolf_roof_advance");

  if(isDefined(var6) && isalive(var6)) {
    thread scripts\sp\maps\marines\marines_vo::vo_wolf_marine_balcony_advance_dialogue(var6);
  }

  scripts\engine\utility::flag_wait("flag_wolf_balcony_advance");
  var0 notify("windowExitAdvance");

  if(isDefined(var5) && isalive(var5)) {
    var5 stopanimScripted();
    thread rear_mantle_handler(var5, var0, 3.2);
    var5 setgoalnode(var8);
    var5 scripts\engine\sp\utility::enable_dontevershoot();
    var5 setentitytarget(var9);
    var5.cautiousnavigation = 1;
    return;
  }
}

function front_mantle_handler_left(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("entitydeleted");
  var6 = getnode("wolf_alternate_path_advance_arrival_node_l", "targetname");
  var0 thread scripts\common\anim::anim_single_solo(self, var2);
  waitframe();
  var7 = getanimlength(scripts\engine\utility::getanim(var2));
  var8 = 0;

  for(var9 = 0; var8 < var7; var9 = 1) {
    wait 0.1;

    if(var8 < var1) {
      var8 += 0.1;
    } else {
      var0 notify("windowExitAdvance");
      self stopanimScripted();
      break;
    }

    if(isDefined(var3)) {
      if(var9 == 0 && var8 > var4) {
        var3 movez(1000, 0.1);
      }
    }
  }

  if(isDefined(var5)) {
    self setgoalnode(var5);
  }

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self.dontavoidplayer = 0;
  self.friend_kill_points = -100000;
  self.script_pushable = 1;
  self pushplayer(0);
  scripts\engine\utility::flag_wait("flag_wolf_balcony_advance");
  scripts\engine\utility::flag_wait("flag_nonShelfSoldierBack_moved");
  self.cautiousnavigation = 1;
  self setgoalnode(var6);
  scripts\common\ai::set_gunpose("ready", 1);
  thread marine_cowabunga_advance();
  wait 2;
  self allowedstances("stand", "crouch", "prone");
}

function front_mantle_handler_right(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("entitydeleted");
  var6 = getnode("wolf_alternate_path_advance_arrival_node_r1", "targetname");
  var0 thread scripts\common\anim::anim_single_solo(self, var2);
  waitframe();
  var7 = getanimlength(scripts\engine\utility::getanim(var2));
  var8 = 0;

  for(var9 = 0; var8 < var7; var9 = 1) {
    wait 0.1;

    if(var8 < var1) {
      var8 += 0.1;
    } else {
      var0 notify("windowExitAdvance");
      self stopanimScripted();
      break;
    }

    if(isDefined(var3)) {
      if(var9 == 0 && var8 > var4) {
        var3 movez(1000, 0.1);
      }
    }
  }

  if(isDefined(var5)) {
    self setgoalnode(var5);
  }

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self.dontavoidplayer = 0;
  self.friend_kill_points = -100000;
  self.script_pushable = 1;
  self pushplayer(0);
  scripts\engine\utility::flag_wait("flag_wolf_balcony_advance");
  self.cautiousnavigation = 1;
  self setgoalnode(var6);
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\common\ai::set_gunpose("ads", 1);
  thread marine_cowabunga_advance();
  thread balcony_marine_advancing("flag_nonShelfSoldierBack_moved");
  wait 2;
  self allowedstances("stand", "crouch", "prone");
  self waittill("goal");
  scripts\asm\gesture::ai_request_gesture("hold");
  thread marine_aim_at_door();
}

function rear_mantle_handler(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("entitydeleted");
  var0 thread scripts\common\anim::anim_single_solo(self, var2);
  waitframe();
  var6 = getanimlength(scripts\engine\utility::getanim(var2));
  var7 = 0;

  for(var8 = 0; var7 < var6; var8 = 1) {
    wait 0.1;

    if(scripts\engine\utility::flag("flag_wolf_roof_advance")) {
      if(var7 < var1) {
        var7 += 0.1;
      } else {
        break;
      }
    } else {
      var7 += 0.1;
    }

    if(isDefined(var3)) {
      if(var8 == 0 && var7 > var4) {
        var3 movez(1000, 0.1);
      }
    }
  }

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self.dontavoidplayer = 0;
  self.friend_kill_points = -100000;
  self.script_pushable = 1;
  self pushplayer(0);

  if(!scripts\engine\utility::flag("flag_wolf_balcony_advance")) {
    if(isDefined(var5)) {
      self setgoalnode(var5);
    } else {
      var0 thread scripts\common\anim::anim_loop_solo(self, "twoMarinesWindowOutsideIdle", "windowExitAdvance");
    }
  }

  scripts\common\ai::set_gunpose("ads", 1);
}

function wolf_balcony_player_clip_handler() {
  var0 = getEnt("wolf_balcony_player_blocker_1", "targetname");
  var1 = getEnt("wolf_balcony_player_blocker_2", "targetname");
  var0 movez(1000, 0.1);
  var1 movez(1000, 0.1);
  wait 0.2;
  scripts\engine\utility::flag_wait("flag_wolf_snakecam_complete");
  var0 movez(-1000, 0.1);
  var1 movez(-1000, 0.1);
}

function barricade_player_crushed_monitor(var0) {
  var1 = getEnt("player_crushed_volume", "targetname");
  wait 5.17;

  if(level.player istouching(var1)) {
    scripts\sp\player_death::set_custom_death_quote(415);
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    level.wolf_barricade_clip delete();
    level.player kill();
    return;
  }
}

function balcony_marine_advancing(var0) {
  self endon("death");
  self endon("entitydeleted");
  var1 = 20;
  var2 = self.origin;

  while(isalive(self) && !scripts\engine\utility::flag(var0)) {
    if(distance2d(var2, self.origin) > var1) {
      scripts\engine\utility::flag_set(var0);
    }

    waitframe();
  }
}

function marine_cowabunga_advance() {
  if(isDefined(self) && isalive(self)) {
    self.dontavoidplayer = 1;
    self.disablebulletwhizbyreaction = 1;
    self.script_pushable = 0;
    self enableavoidance(0);
    self.doavoidanceblocking = 0;
    self.dontchangepushplayer = undefined;
  }

  wait 3;

  if(isDefined(self) && isalive(self)) {
    self.dontavoidplayer = 0;
    self.disablebulletwhizbyreaction = 0;
    self.script_pushable = 1;
    self enableavoidance(1);
    self.doavoidanceblocking = 1;
    self.dontchangepushplayer = 1;
    return;
  }
}

function marine_cowabunga_advance_to_goal() {
  self endon("death");
  self endon("entitydeleted");
  self.dontavoidplayer = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_pushable = 0;
  self enableavoidance(0);
  self.doavoidanceblocking = 0;
  self.dontchangepushplayer = undefined;

  while(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > 10000) {
    waitframe();
  }

  self.dontavoidplayer = 0;
  self.disablebulletwhizbyreaction = 0;
  self.script_pushable = 1;
  self enableavoidance(1);
  self.doavoidanceblocking = 1;
  self.dontchangepushplayer = 1;
}

function marine_aim_at_door() {
  var0 = getEnt("wolf_alternate_path_marine_faketarget_low", "targetname");
  wait 2;

  if(isDefined(self) && isalive(self)) {
    self.no_pistol_switch = 1;
    self.sidearm = isundefinedweapon();
    self.sidearm = "none";
    scripts\engine\sp\utility::enable_dontevershoot();
    self setentitytarget(var0);
    return;
  }
}

function wolf_barricade_lookat_monitor() {
  var0 = scripts\engine\utility::getStruct("barricade_lookat", "targetname");
  var1 = cos(35);

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
      break;
    }

    waitframe();
  }

  if(!scripts\engine\utility::flag("flag_wolf_open_alternate_path")) {
    scripts\engine\utility::flag_set("flag_wolf_open_alternate_path");
    return;
  }
}

function wolf_barricade_lookat_timeout() {
  wait 5;

  if(!scripts\engine\utility::flag("flag_wolf_open_alternate_path")) {
    scripts\engine\utility::flag_set("flag_wolf_open_alternate_path");
    return;
  }
}

function wolf_clear_window_barricade() {
  var0 = scripts\engine\utility::getStruct("wolf_barricade_clip_moveto_struct", "targetname");
  level.wolf_barricade_clip = getEnt("wolf_barricade_clip", "targetname");
  wait 2.5;

  if(isDefined(level.wolf_barricade_clip)) {
    level.wolf_barricade_clip moveTo(var0.origin, 4);
  }

  wait 2;

  if(isDefined(level.wolf_barricade_clip)) {
    level.wolf_barricade_clip connectpaths();
    return;
  }
}

function wolf_flank_tripwire_door_ajar_handler() {
  waitframe();
  self notify("bashed");
  thread wolf_flank_tripwire_door_dialogue();
}

function wolf_flank_tripwire_door_dialogue() {
  thread scripts\sp\maps\marines\marines_vo::vo_wolf_wolf_tripwire_cleared_speech_dialogue();
  wait 1;
  var0 = self.zero_angle - 15;

  while(scripts\sp\door::get_door_angles()[1] > var0) {
    waitframe();
  }

  while(!scripts\sp\door::bash_door_isplayerclose()) {
    waitframe();
  }

  if(isalive(level.player)) {
    thread scripts\sp\maps\marines\marines_vo::vo_wolf_alex_tripwire_encountered_dialogue();
    wait 0.5;
    thread wolf_tripwire_hint_handler();
    return;
  }
}

function snakecam_controls_hint_handler() {
  if(level.player usinggamepad()) {
    scripts\engine\sp\utility::display_hint("snakecam_controls_hint");
  } else {
    scripts\engine\sp\utility::display_hint("snakecam_controls_hint_kbm");
  }

  thread snakecam_controls_hint_timeout();
  level waittill("snakecam_controls_hint_disabled");
  level.snakecam_controls_hint_cleared = 1;
}

function wolf_tripwire_hint_handler() {
  scripts\engine\sp\utility::display_hint("marines_wolf_tripwire_hint");
  thread wolf_tripwire_hint_timeout();
  level waittill("wolf_tripwire_hint_disabled");
  level.marines_wolf_tripwire_cleared = 1;
}

function marines_wolf_takedown_hint_clear() {
  return istrue(level.marines_wolf_takedown_cleared);
}

function marines_snakecam_exit_clear() {
  return istrue(level.marines_snakecam_exit_cleared);
}

function wolf_flank_tripwire_door_monitor() {
  self.zero_angle = scripts\sp\door::get_door_angles()[1];
  var0 = self.zero_angle - 55;

  while(!scripts\engine\utility::flag("flag_wolf_tripwire_cleared") && !scripts\engine\utility::flag("flag_wolf_tripwire_tripped")) {
    if(scripts\sp\door::get_door_angles()[1] < var0) {
      foreach(var2 in level.tripwires.tripwires) {
        var2 notify("trigger", level.player, 1, 1);
      }

      scripts\engine\utility::flag_set("flag_wolf_tripwire_tripped");

      if(!self.bashed) {
        thread scripts\sp\maps\marines\marines_vo::vo_wolf_marine_tripwire_triggered_dialogue();
        wait 0.5;

        if(isalive(level.player)) {
          level.player kill();
        }

        waitframe();
        scripts\sp\player_death::set_custom_death_quote(402);
        scripts\sp\utility::missionfailedwrapper();
      }

      return;
    }

    waitframe();
  }
}

function snakecam_controls_hint_timeout() {
  level.player scripts\sp\maps\marines\marines_utility::waittill_or_timeout("leave_cam", 3);
  level.snakecam_controls_hint_cleared = 1;
}

function snakecam_controls_hint_clear() {
  return istrue(level.snakecam_controls_hint_cleared);
}

function wolf_tripwire_hint_timeout() {
  wait 5;
  level.marines_wolf_tripwire_cleared = 1;
}

function marines_wolf_tripwire_hint_clear() {
  return istrue(level.marines_wolf_tripwire_cleared);
}

function containment_mghall() {
  if(!isDefined(level.civ_ambush_exit_door_left)) {
    level.civ_ambush_exit_door_left = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_left");
  }

  if(!isDefined(level.civ_ambush_exit_door_right)) {
    level.civ_ambush_exit_door_right = scripts\sp\door::get_interactive_door("civ_ambush_exit_door_right");
  }

  scripts\engine\utility::flag_wait("civ_ambush_exit_door_setup");
  level.civ_ambush_exit_door_left thread scripts\sp\door::reset_door();
  level.civ_ambush_exit_door_right thread scripts\sp\door::reset_door();
  level.civ_ambush_exit_door_left thread scripts\sp\door::remove_open_ability();
  level.civ_ambush_exit_door_right thread scripts\sp\door::remove_open_ability();
  level.civ_ambush_exit_door_left.locked = 1;
  level.civ_ambush_exit_door_right.locked = 1;
  level.civ_ambush_exit_door_left.lockedforai = 1;
  level.civ_ambush_exit_door_right.lockedforai = 1;
  level.civ_ambush_exit_door_left notify("stop_push_open");
  level.civ_ambush_exit_door_right notify("stop_push_open");
  level.civ_ambush_exit_door_left scripts\sp\utility::door_ai_allowed(0);
  level.civ_ambush_exit_door_right scripts\sp\utility::door_ai_allowed(0);
}

function containment_mghall_teleport() {
  var0 = getEnt("containment_mghall_teleport_volume", "targetname");
  wait 1;
  var1 = getaiarray("allies");
  var2 = 0;

  foreach(var4 in var1) {
    if(isDefined(var4) && isalive(var4)) {
      if(!var4 istouching(var0)) {
        if(var2 <= 8) {
          var5 = scripts\engine\utility::getStruct("containment_mghall_teleport_destination_" + var2, "targetname");

          if(isDefined(var4) && isalive(var4)) {
            var4 teleport(var5.origin);
            var2++;
          }
        }
      }
    }
  }
}

function containment_wolf() {
  thread containment_wolf_warn_monitor();
  thread containment_wolf_fail_monitor();
}

function containment_wolf_warn_monitor() {
  var0 = getEnt("containment_wolf_warn_volume", "targetname");
  waitframe();
  level.wander_nag_volumes = scripts\engine\utility::array_add(level.wander_nag_volumes, var0);
}

function containment_wolf_fail_monitor() {
  var0 = getEnt("containment_wolf_fail_volume", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      scripts\sp\player_death::set_custom_death_quote(409);
      scripts\sp\utility::missionfailedwrapper();
      level.player freezecontrols(1);
      level notify("mission_failed");
      setomnvar("ui_out_of_bounds_countdown", 0);
    }

    wait 0.1;
  }
}

function mg_hall_gunner_reaction_animations() {
  self endon("death");
  self endon("entitydeleted");
  self endon("end_reaction_monitor");
  var0 = "mar_hos_mg_hall_crouch_exit_06_aq";
  var1 = "mar_hos_mg_hall_crouch_exit_04_aq";
  var2 = undefined;
  var3 = getEnt("mg_gunner_exit_left", "targetname");
  var4 = getEnt("mg_gunner_exit_right", "targetname");
  self.animname = "generic";
  var5 = self.anim_origin;

  for(;;) {
    waitframe();

    if(level.player istouching(var3)) {
      scripts\engine\utility::flag_set("flag_mg_gunner_center");
      var2 = var0;
    } else if(level.player istouching(var4)) {
      scripts\engine\utility::flag_set("flag_mg_gunner_center");
      var2 = var1;
    } else {
      scripts\engine\utility::flag_clear("flag_mg_gunner_center");
      continue;
    }

    while(level.player istouching(var3) || level.player istouching(var4)) {
      if(sighttracepassed(level.player getEye(), self getEye(), 0, self)) {
        scripts\engine\utility::flag_set("flag_mg_gunner_react");
        var5 scripts\common\anim::anim_single_solo(self, var2);
        self notify("end_reaction_monitor");
        continue;
      }

      waitframe();
    }
  }
}

function mg_hall_gunner_idle_anim() {
  self.animname = "generic";
  var0 = scripts\engine\utility::getStruct("mg_hall_gunner_anim_origin", "targetname");
  var1 = spawn("script_origin", var0.origin);
  self.anim_origin = var1;
  var2 = getEnt("mg_hall_mg_pivot", "targetname");
  var1 linkTo(var2);
  var1 scripts\common\anim::anim_loop_solo(self, "mar_hos_mg_hall_crouch_idle_02_aq", "stop_mg_hall_gunner_idle_anim");
  scripts\engine\utility::flag_wait_any("flag_mg_gunner_proximity_alert_right", "flag_mg_gunner_proximity_alert_left");
  var1 notify("stop_mg_hall_gunner_idle_anim");
}

function mg_hall_sign_magic_bullets() {
  level endon("mg_hall_gunner_dead");
  scripts\engine\utility::flag_wait("flag_sign_bullet_trigger");
  var0 = scripts\engine\utility::getStruct("sign_bullet_source", "targetname");
  var1 = scripts\engine\utility::getStructArray("sign_bullet_target", "targetname");
  var2 = "iw8_ar_akilo47_marines_mghall";
  var3 = scripts\engine\utility::getStruct("door_bullet_source", "targetname");
  var4 = scripts\engine\utility::getStructArray("door_bullet_target", "targetname");
  var5 = "iw8_ar_akilo47_marines_mghall";
  var6 = scripts\engine\utility::getStruct("upperfloor_murderhole_struct", "targetname");

  while(!isDefined(self.ammo)) {
    waitframe();
  }

  while(!isDefined(self.burst)) {
    waitframe();
  }

  while(!(self.ammo && self.burst)) {
    waitframe();
  }

  foreach(var8 in var1) {
    magicbullet(var2, var0.origin, var8.origin);
    magicbullet(var2, var0.origin, var8.origin);
    magicbullet(var2, var6.origin, var8.origin);
    wait 0.3;
  }

  foreach(var11 in var4) {
    magicbullet(var5, var3.origin, var11.origin);
    magicbullet(var5, var3.origin, var11.origin);
    magicbullet(var5, var6.origin, var11.origin);
    earthquake(0.25, 0.25, var11.origin, 200);
    wait 0.3;
  }
}

function mg_hall_closet_spawn_handler() {
  scripts\engine\utility::flag_wait("flag_mg_hall_closet_spawn");

  if(!scripts\engine\utility::flag("flag_mg_hall_closet_spawn_skipped")) {
    var0 = getspawnerarray("spawner_mg_hall_closet");

    foreach(var2 in var0) {
      var2 scripts\engine\sp\utility::spawn_ai();
    }

    return;
  }
}

function mg_rotation(var0) {
  level endon("flag_mg_gunner_react");

  while(!isDefined(self.target_actual)) {
    waitframe();
  }

  var1 = getEnt("mg_hall_mg_pivot", "targetname");
  self linkTo(var1);
  var2 = getEnt("mg_hall_mg", "targetname");
  var2 linkTo(var1);

  if(isDefined(var0)) {
    var0 linkTo(var1);
  }

  for(;;) {
    while(!scripts\engine\utility::flag("flag_mg_gunner_center")) {
      var1.angles = vectortoangles(self.target_actual - var1.origin);
      var1.angles = (0, var1.angles[1], 0);

      if(var1.angles[1] > 23 && var1.angles[1] < 180) {
        var1.angles = (0, 23, 0);
      }

      if(var1.angles[1] < 318 && var1.angles[1] > 180) {
        var1.angles = (0, 318, 0);
      }

      waitframe();
    }

    var1.angles = (0, 0, 0);
    self.target_player_stop_min = 0.05;
    self.target_player_stop_max = 0.1;
    thread scripts\sp\maps\marines\marines_utility::mg_target_other();

    while(scripts\engine\utility::flag("flag_mg_gunner_center")) {
      waitframe();
    }
  }
}

function mg_hall_rpg_monitor() {
  var0 = getEnt("mg_hall_gunner_damage_monitor", "targetname");

  for(;;) {
    var0 waittill("damage", var1, var2, var1, var1, var3);

    if(var2 == level.player) {
      if(var3 == "MOD_PROJECTILE_SPLASH") {
        while(!isDefined(level.mg_damage_owner)) {
          waitframe();
        }

        if(isDefined(level.mg_damage_owner.magic_bullet_shield)) {
          level.mg_damage_owner scripts\common\ai::stop_magic_bullet_shield();
        }

        level.mg_damage_owner kill();
      }
    }
  }
}

function mg_hall_ally_blindfire_handler() {
  wait 1;
  scripts\engine\utility::array_thread(level.allymarines["all"], &mg_hall_ally_blindfire);
  var0 = getspawnerarray("ally_marine_mg_hall");
  var1 = getspawnerarray("ally_marine_mg_hall_reinforce");
  var2 = scripts\engine\utility::array_combine(var0, var1);
  scripts\engine\sp\utility::array_spawn_function(var2, &mg_hall_ally_blindfire);
}

function mg_hall_ally_blindfire() {
  self endon("death");
  self endon("entitydeleted");

  if(scripts\engine\utility::flag("mg_hall_gunner_dead") || scripts\engine\utility::flag("flag_upperfloor_murderhole_abandon")) {
    return;
  }

  self.aggressiveblindfire = 1;
  self.forcesuppression = 1;
  self.allowallyblindfire = 1;
  scripts\engine\utility::flag_wait_any("mg_hall_gunner_dead", "flag_upperfloor_murderhole_abandon");
  self.aggressiveblindfire = 0;
  self.forcesuppression = undefined;
  self.allowallyblindfire = undefined;
}

function wolf_takedown_input_lerp() {
  wait 23;
  var0 = 30;

  while(var0 > 0) {
    waitframe();
    var0 -= 0.5;
    level.player playerlinktodelta(level.player.rig, "tag_player", 1, var0, var0, 0, 0, 1);
  }
}

function mg_hall_ally_color_assign() {
  var0 = level.allymarines["all"];
  var0 = scripts\engine\utility::array_remove(var0, level.griggs);
  scripts\sp\maps\marines\marines_utility::switch_marines_from_color_to_color("b", "g");

  foreach(var2 in var0) {
    if(isDefined(var2) && isalive(var2)) {
      var2 setgoalpos(var2.origin);
    }
  }
}

function wolf_fail_and_save_manager() {
  if(isDefined(level.fail_state_active) && level.fail_state_active == 0) {
    scripts\sp\maps\marines\marines_utility::autosave();
  }

  wolf_fail_timer_logic("flag_wolf_roof_advance", 30, 0.7, 0);

  if(!scripts\engine\utility::flag("flag_wolf_alerted_early") && (!isDefined(level.fail_state_active) || level.fail_state_active == 0)) {
    scripts\engine\sp\utility::autosave_now();
  }

  wolf_fail_timer_logic("flag_wolf_roof_door_check", 20, 0.6, 0);
  wolf_fail_timer_logic("flag_wolf_tripwire_cleared", 20, 0.5, 1);

  if(!scripts\engine\utility::flag("flag_wolf_alerted_early") && !scripts\engine\utility::flag("flag_wolf_disallow_tripwire_save")) {
    scripts\engine\sp\utility::autosave_now();
  }

  wolf_fail_timer_logic("flag_wolf_performing_takedown", 30, 0.5, 1);
}

function wolf_fail_timer_logic(var0, var1, var2, var3) {
  level endon(var0);
  wait var1 * var2;

  if(var3) {
    thread scripts\sp\maps\marines\marines_vo::vo_wolf_fail_timer_radio_nag();
  } else {
    thread scripts\sp\maps\marines\marines_vo::vo_wolf_fail_timer_nag();
  }

  wait var1 * (1 - var2);
  wolf_timer_fail_state();
}

function wolf_timer_fail_state() {
  level endon("flag_wolf_performing_takedown");
  scripts\engine\utility::flag_set("flag_wolf_alerted_early");
  wait 4;

  if(isDefined(level.wolf_fail_state_active) == 0 || level.wolf_fail_state_active == 0) {
    scripts\sp\player_death::set_custom_death_quote(408);
    scripts\sp\utility::missionfailedwrapper();
    return;
  }
}