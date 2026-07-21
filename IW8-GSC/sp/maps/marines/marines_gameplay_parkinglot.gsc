/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_gameplay_parkinglot.gsc
***********************************************************/

retreat_init() {
  scripts\engine\utility::flag_init("flag_retreat_player_response");
  scripts\engine\utility::flag_init("flag_retreat_player_on_stairs");
  scripts\engine\utility::flag_init("flag_retreat_spawn_initial_aq");
  scripts\engine\utility::flag_init("flag_retreat_initial_runto_cover");
  scripts\engine\utility::flag_init("flag_retreat_spawn_vehicles");
  scripts\engine\utility::flag_init("flag_retreat_exiting_mg_house");
  scripts\engine\utility::flag_init("flag_retreat_exiting_mg_house_vehicle_move");
  scripts\engine\utility::flag_init("flag_retreat_smash_gate_tank_hitting_gate");
  scripts\engine\utility::flag_init("warning_fire_at_gate");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_heli_left_spawn");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_heli_left_complete");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_heli_right_complete");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_start");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_kill_player");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_cease_fire");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_tank_advance");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_complete");
  scripts\engine\utility::flag_init("flag_retreat_advance_vo_complete");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_tank_stop");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_tank_stop_2");
  scripts\engine\utility::flag_init("flag_retreat_bombardment_tank_stop_3");
  scripts\engine\utility::flag_init("flag_set_push_hospital_objective");
  scripts\engine\utility::flag_init("flag_retreat_advance_2");
  scripts\engine\utility::flag_init("flag_retreat_trigger_counterattack");
  scripts\engine\utility::flag_init("flag_retreat_trigger_counterattack_timer");
  scripts\engine\utility::flag_init("flag_retreat_counterattack_refresh");
  scripts\engine\utility::flag_init("flag_retreat_aq_fallback_spawn");
  scripts\engine\utility::flag_init("flag_retreat_rooftop_cleanup");
  scripts\engine\utility::flag_init("flag_retreat_marines_advance_to_lobby_1");
  scripts\engine\utility::flag_init("flag_retreat_marines_advance_to_lobby_2");
  scripts\engine\utility::flag_init("flag_retreat_rpg_killed");
  scripts\engine\utility::flag_init("flag_vo_retreat_griggs_heli_fast");
}

retreat_main() {
  thread scripts\sp\maps\marines\marines_utility.gsc::transient_waittill("flag_retreat_advance_2", "marines_convoy_geo_tr", undefined);
  thread scripts\sp\maps\marines\marines_utility.gsc::propane_rockets_init();
  thread delete_alley_trucks_monitor();
  thread scripts\sp\analytics::analytics_kleenex_update("Start to End Murderhole");
  thread scripts\sp\maps\marines\marines_utility.gsc::autosave();
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.manpile_monitor.maximum = 22;
  level.manpile_monitor.maximum_in_fov = 10;
  level.manpile_monitor.ideal = 16;
  level.manpile_monitor.safe_delete_distance = 4000;
  level.manpile_monitor.maximum_weapons = 8;
  level.manpile_monitor.wait_time = 0.3;
  scripts\engine\utility::flag_clear("flag_retreat_exiting_mg_house");
  var_0 = getEnt("retreat_tank_stackup_clip_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("retreat_tank_stackup_clip_1_enable_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("retreat_tank_stackup_clip_1_disable_struct", "targetname");
  thread enable_retreat_exterior_triggers();
  thread retreat_allied_nav_clip_disable();
  thread retreat_body_cleanup();
  scripts\engine\sp\utility::array_spawn_function_targetname("ally_marine_retreat", ::setup_support_marines);
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_stackup_initial_trigger");
  retreat_marine_setup();
  thread marine_mghouse_stackup();
  thread mh_rendevous_dialogue();
  thread spawn_bombardment_aq();
  thread enable_tank_stackup(var_0, var_1, var_2);
  thread enable_runout_bullet_clip();
  thread warning_shots_at_gate();
  thread green_marines_move_to_hospital();
  thread blue_marines_move_to_hospital();
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_griggs_advance_dialogue();
  thread scripts\sp\maps\marines\marines_lighting.gsc::sun_adjustments_hospital_trigger("lighting_hospital", -1);
  level.bombardment_window_ground_bullet_spawners = scripts\engine\utility::getStructArray("bombardment_window_ground_bullet_spawners", "targetname");
  level.bombardment_window_ground_bullet_targets = getEntArray("bombardment_window_ground_bullet_targets", "targetname");
  scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, ::retreat_building_magic_bullets, level.bombardment_window_ground_bullet_targets, undefined, undefined, 0, 0, 1.0, 4.0);
  level.bombardment_window_air_bullet_spawners = scripts\engine\utility::getStructArray("bombardment_window_air_bullet_spawners", "targetname");
  var_3 = getEntArray("bombardment_window_air_bullet_targets", "targetname");
  scripts\engine\utility::array_thread(level.bombardment_window_air_bullet_spawners, ::retreat_building_magic_bullets, var_3, undefined, undefined, 0, 0, 0.1, 1.0);
  scripts\engine\utility::flag_wait("flag_retreat_spawn_vehicles");
  level.manpile_monitor.maximum_weapons = 22;
  setsaveddvar("TLOLRMSL", 0.01);
  level.retreat_assault_vehicle = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_assault_vehicle", "Dirt Diggler", "retreat_start_node_apc", 0, 1, 0);
  level.retreat_assault_vehicle.targetname = "retreat_assault_vehicle";
  level.retreat_assault_vehicle.godmode = 1;
  level.retreat_assault_vehicle thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  thread scripts\common\vehicle_paths::gopath(level.retreat_assault_vehicle);
  thread tank_vfx_handler();
  thread retreat_backup_apc_handler();
  thread mh_civilian_cleanup();
  level.player scripts\sp\player::player_movement_state("cqb");
  var_4 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");

  foreach(var_6 in var_4) {
    if(isalive(var_6) && isDefined(var_6.asmname))
      var_6 scripts\common\utility::demeanor_override("combat");
  }

  var_8 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("b");

  foreach(var_6 in var_8) {
    if(isalive(var_6) && isDefined(var_6.asmname))
      var_6 scripts\common\utility::demeanor_override("combat");
  }

  var_11 = level.allymarines["all"];

  foreach(var_6 in var_11) {
    if(isalive(var_6)) {
      if(!isDefined(var_6.magic_bullet_shield))
        var_6 scripts\common\ai::magic_bullet_shield();
    }
  }

  level.griggs.ignoreall = 1;
  level.griggs.pacifist = 1;

  if(isalive(level.griggs) && isDefined(level.griggs.asmname))
    level.griggs scripts\common\utility::demeanor_override("combat");

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread scripts\sp\maps\marines\marines_utility.gsc::griggs_supplies_refill();
  scripts\engine\sp\utility::activate_trigger_with_targetname("reteat_blue_marines_exit_house");
  thread scripts\common\vehicle_paths::gopath(level.retreat_support_apc_2);
  level.retreat_assault_vehicle.dontdisconnectpaths = 1;
  level.retreat_assault_vehicle.script_badplace = 1;
  level.retreat_assault_vehicle scripts\common\vehicle_code::vehicle_remove_badplace();
  destroynavrepulsor("vehicle " + level.retreat_assault_vehicle getentitynumber());
  thread retreat_heli_right_deploy();
  thread retreat_gate_breach_marines();
  thread retreat_gate_breach_griggs_runby();
  thread retreat_heli_left_deploy();
  thread retreat_hospital_gate_distance_check();
  scripts\engine\utility::flag_wait("flag_retreat_smash_gate_tank_hitting_gate");
  thread scripts\sp\maps\marines\marines_utility.gsc::autosave();
  waitframe();
  thread retreat_bombardment_player_monitor();
  var_11 = level.allymarines["all"];
  var_11 = scripts\engine\utility::array_remove(var_11, level.griggs);

  foreach(var_6 in var_11) {
    if(isalive(var_6)) {
      if(isDefined(var_6.asmname))
        var_6 scripts\common\utility::demeanor_override("combat");

      var_6.ignoreme = 1;

      if(!isDefined(var_6.magic_bullet_shield))
        var_6 scripts\common\ai::magic_bullet_shield();
    }
  }

  level.griggs.ignoreme = 1;
  var_16 = getEntArray("tank_bombardment_targets", "targetname");
  level.retreat_assault_vehicle thread apc_turret_behavior(var_16, 1);
  wait 2;
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_bombardment_initial_trigger");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_start");
  scripts\engine\utility::exploder("lobby_breach");
  thread retreat_marine_bombardment_reaction_dialogue();
  wait 10;
  scripts\engine\utility::flag_wait_all("flag_retreat_bombardment_heli_left_complete", "flag_retreat_bombardment_heli_right_complete");
  scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 2);
  scripts\engine\utility::array_thread(level.bombardment_window_air_bullet_spawners, scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 0);
  thread retreat_allied_nav_clip_enable();
  scripts\engine\utility::flag_set("flag_retreat_bombardment_cease_fire");
  var_11 = level.allymarines["all"];
  var_11 = scripts\engine\utility::array_remove(var_11, level.griggs);
  waitframe();

  foreach(var_6 in var_11) {
    if(isalive(var_6)) {
      if(isDefined(var_6.asmname))
        var_6 scripts\common\utility::demeanor_override("cqb");

      var_6.ignoreme = 0;

      if(isDefined(var_6.magic_bullet_shield))
        var_6 scripts\common\ai::stop_magic_bullet_shield();
    }
  }

  level.griggs.ignoreme = 0;
  level.griggs.ignoreall = 0;
  level.griggs.pacifist = 0;

  if(isalive(level.griggs) && isDefined(level.griggs.asmname))
    level.griggs scripts\common\utility::demeanor_override("cqb");

  wait 1;
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_griggs_advance_bombardment_dialogue();
  thread scripts\sp\maps\marines\marines_utility.gsc::autosave();
  wait 2;
  thread retreat_aq_counterattack_timeout();
  thread retreat_aq_counterattack_handler();
  thread retreat_tank_advance();
  scripts\engine\utility::flag_set("flag_retreat_bombardment_complete");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_advance_vo_complete", 5.0);
  level notify("bombardment_complete");
  thread marine_retreat_advance();
  thread clear_tank_stackup(var_0, var_1, var_2);
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  thread retreat_tank_rpg_hit();
  level.player.ignoreme = 1;
  var_11 = level.allymarines["all"];

  foreach(var_6 in var_11) {
    if(isDefined(var_6) && isalive(var_6)) {
      if(istrue(var_6.poi_enabled))
        var_6 thread scripts\common\ai::poi_enable(0);

      var_6 setgoalpos(var_6.origin);
    }
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_counter_attack_marines");
  scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_retreat_counterattack");
  thread scripts\sp\maps\marines\marines_utility.gsc::autosave();
  thread retreat_aq_counterattack_rooftop_handler();
  scripts\engine\sp\utility::battlechatter_on("allies");
  var_11 = level.allymarines["all"];
  var_11 = scripts\engine\utility::array_remove(var_11, level.griggs);

  foreach(var_6 in var_11) {
    if(isalive(var_6)) {
      if(isDefined(var_6.asmname))
        var_6 scripts\common\utility::demeanor_override("combat");

      var_6.ignoreme = 0;
      var_6.ignoreall = 0;
      var_6.pacifist = 0;
    }
  }

  if(isalive(level.griggs) && isDefined(level.griggs.asmname))
    level.griggs scripts\common\utility::demeanor_override("combat");

  var_23 = getspawnerarray("aq_retreat_laststand_spawner");
  scripts\engine\utility::flag_wait("flag_retreat_aq_fallback_spawn");
  scripts\sp\spawner::killspawner(61);
  scripts\sp\spawner::killspawner(62);
  var_24 = getaiarray("axis");

  if(var_24.size < 15)
    var_25 = scripts\engine\sp\utility::array_spawn(var_23);
}

retreat_tank_advance() {
  wait 1;
  level.retreat_assault_vehicle thread apc_disable_turret();
  wait 3;
  scripts\engine\utility::flag_set("flag_retreat_bombardment_tank_advance");
  wait 4;
  thread advance_tank_bullet_pings();
}

advance_tank_bullet_pings() {
  var_0 = scripts\engine\utility::getStructArray("bombardment_window_air_bullet_spawners", "targetname");
  var_1 = scripts\engine\utility::getStructArray("bombardment_window_ground_bullet_spawners", "targetname");
  waitframe();
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  while(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack")) {
    var_3 = scripts\engine\utility::random(var_2);
    var_3 retreat_building_magic_bullets_fire_bradley_ping(level.retreat_assault_vehicle, randomintrange(2, 5));
    wait(randomfloatrange(2.0, 5.0));
  }

  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  scripts\engine\utility::array_thread(var_2, scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 1);
}

retreat_door_bash_monitor() {
  while(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
    if(level.murderhole_bldg_door_retreat.bashed == 1)
      scripts\engine\utility::flag_set("flag_retreat_exiting_mg_house");

    waitframe();
  }
}

retreat_aq_counterattack_timeout() {
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  scripts\engine\utility::flag_wait_any_timeout(2.0, "flag_retreat_trigger_counterattack_timer", "flag_retreat_trigger_counterattack");

  if(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack_timer"))
    scripts\engine\utility::flag_set("flag_retreat_trigger_counterattack_timer");
}

enable_runout_bullet_clip() {
  var_0 = getEnt("retreat_runout_bullet_clip", "targetname");
  var_1 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_enable_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_disable_struct", "targetname");
  var_0 moveTo(var_1.origin, 0.1);
  wait 0.2;
  var_0 disconnectPaths();
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  wait 1.0;
  var_0 moveTo(var_2.origin, 0.1);
  wait 0.2;
  var_0 connectpaths();
}

retreat_marine_setup() {
  var_0 = scripts\engine\utility::getStruct("start_retreat_griggs", "targetname");
  scripts\sp\maps\marines\marines_utility.gsc::switch_marines_from_color_to_color("y", "b");
  scripts\sp\maps\marines\marines_utility.gsc::switch_marines_from_color_to_color("c", "b");
  scripts\sp\maps\marines\marines_utility.gsc::switch_marines_from_color_to_color("r", "b");
  level.griggs forceteleport(var_0.origin, var_0.angles);
  thread scripts\sp\maps\marines\marines_utility.gsc::setup_marine_allies("ally_marine_retreat");
}

retreat_aq_counterattack_handler() {
  var_0 = getspawnerarray("aq_retreat_counterattack_spawner");
  var_1 = getspawnerarray("aq_retreat_counterattack_initial_spawner");
  var_2 = getspawnerarray("aq_retreat_reinforce_spawner");
  var_3 = getspawnerarray("aq_retreat_counterattack_outside_spawner");
  var_0 scripts\engine\sp\utility::array_spawn_function(var_0, ::ai_frontline_behavior);
  var_3 scripts\engine\sp\utility::array_spawn_function(var_3, ::ai_frontline_behavior);
  var_1 scripts\engine\sp\utility::array_spawn_function(var_1, ::ai_frontline_initial_behavior);
  waitframe();

  foreach(var_5 in var_1) {
    var_5 scripts\engine\sp\utility::spawn_ai();
    wait(randomfloatrange(0.5, 1.5));
  }

  scripts\engine\utility::flag_wait_any("flag_retreat_trigger_counterattack_timer", "flag_retreat_trigger_counterattack");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_marine_advance_ambush_initial_dialogue();
  scripts\engine\utility::flag_set("flag_set_push_hospital_objective");
  thread scripts\engine\sp\utility::flood_spawn(var_0);
  var_7 = scripts\engine\sp\utility::array_spawn(var_3);
  thread retreat_aq_counterattack_flank_retreat_monitor();

  foreach(var_9 in var_7)
  var_9 thread outside_spawner_cleanup();

  wait 5;
  scripts\engine\utility::flag_set("flag_retreat_trigger_counterattack");

  for(var_11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"); var_11.size > 5; var_11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"))
    wait 0.1;

  scripts\engine\utility::flag_set("flag_retreat_marines_advance_to_lobby_1");
  scripts\engine\utility::flag_wait("flag_retreat_counterattack_refresh");
  var_12 = scripts\engine\sp\utility::array_spawn(var_2);
  wait 5;

  for(var_11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"); var_11.size > 4; var_11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"))
    wait 0.1;

  scripts\engine\utility::flag_set("flag_retreat_marines_advance_to_lobby_2");
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_2");
}

retreat_aq_counterattack_flank_retreat_monitor() {
  var_0 = getEnt("counterattack_left_monitor", "targetname");
  var_1 = getEnt("counterattack_right_monitor", "targetname");
  var_2 = getEnt("retreat_aq_volume_left_retreat", "targetname");
  var_3 = getEnt("retreat_aq_volume_right_retreat", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_aq_fallback_spawn");
  var_4 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_outside_spawner", "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && isalive(var_6)) {
      if(ispointinvolume(var_6.origin, var_0)) {
        var_6 setgoalvolumeauto(var_2);
        continue;
      }

      if(ispointinvolume(var_6.origin, var_1))
        var_6 setgoalvolumeauto(var_3);
    }
  }
}

retreat_aq_counterattack_rooftop_handler() {
  var_0 = getspawnerarray("aq_hospital_laststand_roof_spawner");
  var_0 scripts\engine\sp\utility::array_spawn_function(var_0, ::ai_rpg_behavior);
  var_1 = 1;
  waitframe();
  var_2 = scripts\engine\sp\utility::array_spawn(var_0);
  thread retreat_rpg_detonation_manager();
  thread hospital_laststand_roof_alive_monitor();
  scripts\engine\utility::flag_wait("flag_retreat_rooftop_cleanup");
  var_3 = [];
  var_3 = scripts\engine\sp\utility::get_living_ai_array("aq_hospital_laststand_roof_spawner", "targetname");

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 thread rpg_guy_force_kill(var_1);

    var_1++;
    wait 1;
  }
}

rpg_guy_force_kill(var_0) {
  var_1 = scripts\engine\utility::getStruct("rooftop_kill_magicbullet_fov_struct", "targetname");
  var_2 = cos(90);
  var_3 = getEnt("rooftop_kill_magicbullet_org_" + var_0, "targetname");

  while(isDefined(self) && isalive(self)) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, var_2)) {
      if(var_0 == 1)
        magicbullet("iw8_ar_akilo47", var_3.origin, self gettagorigin("j_head"));
      else
        magicgrenade("frag", self.origin, (0, 0, 20), 0.05, 0);
    }

    wait 0.5;
  }
}

hospital_laststand_roof_alive_monitor() {
  var_0 = 0;

  while(!scripts\engine\utility::flag("flag_retreat_rooftop_cleanup") && var_0 == 0) {
    var_1 = scripts\engine\sp\utility::get_living_ai_array("aq_hospital_laststand_roof_spawner", "targetname");

    if(var_1.size < 1) {
      thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_marine_rpgs_clear_dialogue();
      var_0 = 1;
      scripts\engine\utility::flag_set("flag_retreat_rpg_killed");
    }

    waitframe();
  }
}

retreat_rpg_detonation_manager() {
  var_0 = getEnt("retreat_rpg_detonation_volume", "targetname");

  while(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
    level.player waittill("missile_fire", var_1, var_2);
    var_1 thread retreat_rpg_detonation_monitor(var_0, var_2);
    waitframe();
  }
}

retreat_rpg_detonation_monitor(var_0, var_1) {
  while(isDefined(self)) {
    if(ispointinvolume(self.origin, var_0)) {
      if(var_1.basename == "iw8_la_rpapa7") {
        playFX(level._effect["vfx_explo_rpg"], self.origin);
        playworldsound("frag_grenade_expl_trans", self.origin);

        if(isDefined(self))
          self detonate(level.player);
      } else if(var_1.basename == "iw8_ar_mike4") {
        playFX(level._effect["vfx_explo_rpg"], self.origin);
        playworldsound("frag_grenade_expl_trans", self.origin);
        radiusdamage(self.origin, 500, 200, 200, level.player, "MOD_EXPLOSIVE");

        if(isDefined(self))
          self delete();
      }
    }

    waitframe();
  }
}

retreat_allied_nav_clip_enable() {
  var_0 = getEnt("retreat_bombardment_allied_nav_clip", "targetname");
  var_1 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_enable_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_disable_struct", "targetname");
  var_0 moveTo(var_1.origin, 0.1);
  wait 0.2;
  var_0 connectpaths();
}

retreat_allied_nav_clip_disable() {
  var_0 = getEnt("retreat_bombardment_allied_nav_clip", "targetname");
  var_1 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_enable_struct", "targetname");
  var_2 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_disable_struct", "targetname");
  var_0 moveTo(var_2.origin, 0.1);
  wait 0.2;
  var_0 disconnectPaths();
}

retreat_tank_rpg_hit() {
  var_0 = scripts\engine\utility::getStruct("retreat_tank_magicbullet_rpg_source", "targetname");
  level.vehicle.templates.vehicle_death_fx["script_vehicle_bromeo"][0] = scripts\common\vehicle_build::build_fx("vfx/iw8/level/marines/vfx_explo_tank_rpg.vfx", "tag_origin", "veh_bradley_expl_destr");
  waitframe();
  level.vehicle.templates.vehicle_death_fx["script_vehicle_bromeo"][1] = scripts\common\vehicle_build::build_fx("vfx/iw8/level/marines/vfx_tank_death_fire.vfx", "tag_origin");
  waitframe();

  if(isDefined(level.retreat_assault_vehicle)) {
    level.retreat_assault_vehicle.script_badplace = 0;
    level.retreat_assault_vehicle scripts\common\vehicle_code::vehicle_badplace();
  }

  var_1 = magicbullet("iw8_la_rpapa7_straight_ai", var_0.origin, level.retreat_assault_vehicle.origin);
  var_1 thread ambush_rpg_monitor();
}

ambush_rpg_monitor() {
  var_0 = getEnt("retreat_assault_vehicle_destroyed_clip", "targetname");
  var_1 = 0;
  var_2 = distance2d(self.origin, level.retreat_assault_vehicle.origin);

  while(isDefined(self) && isDefined(level.retreat_assault_vehicle) && var_2 > 150) {
    var_2 = distance(self.origin, level.retreat_assault_vehicle.origin);
    level.rpg_impact_source = self.origin;
    waitframe();
  }

  var_3 = level.retreat_assault_vehicle.origin;
  var_0.origin = level.retreat_assault_vehicle.origin + (-4, 0, 70);
  var_0.angles = level.retreat_assault_vehicle.angles + (0, -104, 0);
  waitframe();
  level.vehicle.templates.deathmodel["veh8_mil_lnd_bromeo"] = "veh8_mil_lnd_bromeo_animated_dst";
  playworldsound("frag_grenade_expl_trans", level.rpg_impact_source);
  earthquake(0.5, 3, level.player.origin, 100);
  level.player playRumbleOnEntity("heavy_2s");
  level.player.ignoreme = 0;
  var_4 = level.retreat_assault_vehicle;
  var_4 scripts\engine\sp\utility::assign_animtree("retreat_tank");
  var_4.animname = "retreat_tank";
  var_4 thread scripts\common\anim::anim_single_solo(var_4, "retreat_assault_vehicle_destroyed");

  if(isDefined(level.retreat_assault_vehicle)) {
    level.retreat_assault_vehicle.godmode = 0;
    level.retreat_assault_vehicle scripts\sp\utility::do_damage(9999, level.retreat_assault_vehicle.origin);
  }
}

marine_mghouse_stackup() {
  var_0 = getnode("retreat_mghouse_exit_node_1a", "targetname");
  var_1 = getnode("retreat_mghouse_exit_node_1b", "targetname");
  var_2 = getnode("retreat_mghouse_exit_node_2a", "targetname");
  var_3 = getnode("retreat_mghouse_exit_node_2b", "targetname");
  var_4 = getnode("retreat_mghouse_exit_node_3", "targetname");
  var_5 = getnode("retreat_mghouse_exit_node_4", "targetname");
  var_6 = scripts\engine\utility::getStruct("retreat_mghouse_stackup_distance_ref", "targetname");
  var_7 = 0;
  wait 1.0;
  var_8 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("b");
  var_9 = sortbydistance(var_8, var_6.origin);

  foreach(var_11 in var_9) {
    if(isDefined(var_11) && isalive(var_11) && var_7 < 4) {
      if(var_7 == 0 && !scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var_11 setgoalnode(var_0);
        var_11 thread player_using_staircase_monitor(var_0, var_1);
      } else if(var_7 == 0 && scripts\engine\utility::flag("flag_retreat_player_on_stairs"))
        var_11 setgoalnode(var_1);

      if(var_7 == 1 && !scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var_11 setgoalnode(var_2);
        var_11 thread player_using_staircase_monitor(var_2, var_3);
      } else if(var_7 == 1 && scripts\engine\utility::flag("flag_retreat_player_on_stairs"))
        var_11 setgoalnode(var_3);

      if(var_7 == 2)
        var_11 setgoalnode(var_4);

      if(var_7 == 3)
        var_11 setgoalnode(var_5);

      var_7++;
    }

    waitframe();
  }
}

player_using_staircase_monitor(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  var_2 = getEnt("marine_stairwell_monitor_a", "targetname");
  var_3 = getEnt("marine_stairwell_monitor_b", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_player_on_stairs");

  if(isDefined(self) && isalive(self)) {
    var_4 = distance(self.origin, var_0.origin);

    if(var_4 < 100) {
      return;
    }
    if(ispointinvolume(self.origin, var_2) || ispointinvolume(self.origin, var_3)) {
      self.dontavoidplayer = 1;
      self.disablebulletwhizbyreaction = 1;
      self.script_pushable = 0;
      self enableavoidance(0);
      self.doavoidanceblocking = 0;
      self.dontchangepushplayer = undefined;
      scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");

      if(isDefined(self) && isalive(self)) {
        self.dontavoidplayer = 0;
        self.disablebulletwhizbyreaction = 0;
        self.script_pushable = 1;
        self enableavoidance(1);
        self.doavoidanceblocking = 1;
        self.dontchangepushplayer = 1;
      }
    } else {
      self setgoalnode(var_1);
      return;
    }
  }
}

marine_retreat_advance() {
  var_0 = scripts\engine\utility::getStructArray("retreat_advance_left_poi_struct", "targetname");
  var_1 = scripts\engine\utility::getStructArray("retreat_advance_right_poi_struct", "targetname");
  level.retreat_advance_available_left_paths = [];
  level.retreat_advance_available_right_paths = [];
  var_2 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_1", "targetname");
  var_3 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_3", "targetname");
  var_5 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_4", "targetname");
  var_6 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_5", "targetname");
  var_7 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_1", "targetname");
  var_8 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_2", "targetname");
  var_9 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_3", "targetname");
  var_10 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_4", "targetname");
  var_11 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_5", "targetname");
  waitframe();
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var_2);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var_4);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var_3);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var_5);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var_6);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var_8);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var_10);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var_9);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var_11);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var_7);
  var_12 = scripts\engine\utility::getStruct("retreat_advance_distance_ref", "targetname");
  var_13 = [];
  var_14 = [];
  level.retreat_advance_available_left_paths_index = 0;
  level.retreat_advance_available_right_paths_index = 0;
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  level.retreat_assault_vehicle.dontdisconnectpaths = undefined;
  level.retreat_assault_vehicle.script_badplace = 1;
  var_13 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("b");
  var_14 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");
  var_14 = scripts\engine\utility::array_add(var_14, level.griggs);
  var_15 = sortbydistance(var_13, var_12.origin);
  var_16 = sortbydistance(var_14, var_12.origin);
  thread marine_advance_with_util(var_15, var_1, level.retreat_advance_available_right_paths, level.retreat_advance_available_right_paths_index);
  thread marine_advance_with_util(var_16, var_0, level.retreat_advance_available_left_paths, level.retreat_advance_available_left_paths_index);
}

marine_advance_with_util(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = 0;
  var_6 = getEntArray("retreat_marine_advance_faketarget", "targetname");

  foreach(var_8 in var_0) {
    if(isDefined(var_8) && isalive(var_8)) {
      if(var_3 <= var_2.size) {
        if(var_5 < var_4) {
          var_9 = scripts\engine\utility::random(var_6);
          var_8 thread marine_advance_faketarget_shoot_handler(var_9);
          var_5++;
          var_8.poi_enabled = 0;
        }

        if(!isDefined(var_8.poi_enabled) || var_8.poi_enabled == 0) {
          var_10 = scripts\engine\utility::random(var_1);
          var_8 thread scripts\common\ai::poi_enable(1, var_10);
          var_8.poi_enabled = 1;
        }

        if(isDefined(var_8.goalnode)) {
          if(isDefined(var_8.goalnode.target)) {
            var_11 = scripts\engine\utility::getStruct(var_8.goalnode.target, "targetname");
            var_8 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(var_11, undefined, undefined, undefined, undefined, 0);

            foreach(var_13 in var_2) {
              if(var_13 == var_11)
                var_2 = scripts\engine\utility::array_remove(var_2, var_11);
            }
          }
        } else {
          var_8 thread scripts\sp\maps\marines\marines_utility.gsc::marine_path_util(var_2[var_3], undefined, undefined, undefined, undefined, 0);
          var_8.script_index = var_3;
          var_3++;
        }
      }
    }

    wait(randomfloatrange(0.5, 2.0));
  }

  wait 10;
}

marine_advance_faketarget_shoot_handler(var_0) {
  self endon("death");
  self endon("entitydeleted");
  wait(randomfloatrange(1.0, 4.0));

  while(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack_timer") && isDefined(self) && isalive(self)) {
    self setentitytarget(var_0);
    wait 3;

    if(isDefined(self) && isalive(self))
      self clearentitytarget();
  }
}

spawn_bombardment_aq() {
  var_0 = getspawnerarray("retreat_aq_bombardment_initial");
  var_1 = getspawnerarray("retreat_aq_bombardment_reinforce");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::bombardment_aq_behavior);
  scripts\engine\sp\utility::array_spawn_function(var_1, ::bombardment_aq_behavior);
  var_2 = [];
  thread bombardment_aq_window_target_player_manager();
  thread bombardment_aq_run_to_cover_monitor();
  scripts\engine\utility::flag_wait("flag_retreat_spawn_initial_aq");
  var_3 = scripts\engine\sp\utility::array_spawn(var_0);

  foreach(var_5 in getaiarray("axis")) {
    if(isDefined(var_5.script_index) && var_5.script_index == 1334913)
      var_5 thread scripted_longdeath_3();
  }

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  var_2 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
  waitframe();

  foreach(var_5 in var_2) {
    if(isDefined(var_5) && isalive(var_5)) {
      if(var_5.health > 100)
        var_5.health = 100;
    }
  }

  foreach(var_10 in var_1) {
    if(var_2.size < 17) {
      var_10.count = 1;
      waitframe();
      var_5 = var_10 scripts\engine\sp\utility::spawn_ai();
      waitframe();
      var_2 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
      waitframe();
    }
  }

  scripts\engine\utility::flag_wait("flag_retreat_smash_gate_tank_hitting_gate");
  wait 2;
  var_12 = 1;
  var_13 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
  var_14 = [];

  foreach(var_5 in var_13) {
    if(!isDefined(var_5.forcelongdeath)) {
      if(!(isDefined(var_5.script_index) && var_5.script_index == 1334913))
        var_14[var_14.size] = var_5;
    }
  }

  while(var_14.size > var_12) {
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;

    foreach(var_5 in var_14) {
      if(isDefined(var_5.node)) {
        switch (var_5.node.type) {
          case "Cover Stand":
            var_17++;
            break;
          case "Cover Left":
            var_18++;
            break;
          case "Cover Right":
            var_19++;
            break;
        }
      }
    }

    var_5 = scripts\engine\utility::random(var_14);

    if(isDefined(var_5.node)) {
      switch (var_5.node.type) {
        case "Cover Stand":
          if(var_17 == 1)
            var_5 scripts\sp\maps\marines\marines_utility.gsc::force_long_death(7);
          else
            var_5 kill();

          break;
        case "Cover Left":
          if(var_18 == 1)
            var_5 scripts\sp\maps\marines\marines_utility.gsc::force_long_death(9);
          else
            var_5 kill();

          break;
        case "Cover Right":
          if(var_19 == 1)
            var_5 scripts\sp\maps\marines\marines_utility.gsc::force_long_death(13);
          else
            var_5 kill();

          break;
        default:
          var_5 kill();
      }
    } else
      var_5 kill();

    wait 0.8;
    var_13 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
    var_14 = [];

    foreach(var_5 in var_13) {
      if(!isDefined(var_5.forcelongdeath)) {
        if(!(isDefined(var_5.script_index) && var_5.script_index == 1334913))
          var_14[var_14.size] = var_5;
      }
    }
  }

  foreach(var_5 in var_14)
  var_5 thread retreat_crawling_deaths_handler();
}

bombardment_aq_behavior() {
  var_0 = getEntArray("bombardment_aq_infantry_returning_fire_targets", "targetname");
  var_1 = getEntArray("bombardment_aq_infantry_air_bullet_targets", "targetname");
  self.ignoreall = 0;
  self.ignoreme = 1;
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();

  if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
    thread bombardment_aq_hit_monitor();

  while(isDefined(self) && isalive(self)) {
    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      var_2 = scripts\engine\utility::random(var_0);
    else
      var_2 = scripts\engine\utility::random(var_1);

    self setentitytarget(var_2);
    wait 2.5;

    if(isDefined(self) && isalive(self))
      self clearentitytarget();
  }
}

bombardment_aq_run_to_cover_monitor() {
  var_0 = getEntArray("bombardment_initial_cover_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_initial_runto_cover");
  var_1 = scripts\engine\sp\utility::get_living_ai_array("retreat_aq_bombardment_initial", "targetname");
  var_2 = ["dx_cbc_aq4_order_move_combat", "dx_cbc_aq4_exposed_movement", "dx_cbc_aq4_exposed_movement_group"];

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && isalive(var_4)) {
      if(var_0.size > 0) {
        var_5 = scripts\engine\utility::getclosest(var_4.origin, var_0);
        var_4 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_aq(scripts\engine\utility::random(var_2));
        var_4 cleargoalvolume();
        var_4 setgoalvolumeauto(var_5);
        var_0 = scripts\engine\utility::array_remove(var_0, var_5);
      } else {
        var_0 = getEntArray("bombardment_initial_cover_volume", "targetname");
        waitframe();
        var_5 = scripts\engine\utility::getclosest(var_4.origin, var_0);
        var_4 cleargoalvolume();
        var_4 setgoalvolumeauto(var_5);
        var_0 = scripts\engine\utility::array_remove(var_0, var_5);
      }

      wait(randomfloatrange(0.25, 1.0));
    }
  }
}

bombardment_aq_hit_monitor() {
  self endon("entitydeleted");
  self endon("death");
  self endon("reset_health");
  self endon("flag_retreat_exiting_mg_house");
  scripts\engine\utility::disable_pain();
  self.health = 9999;
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_3, var_3, var_3, var_3, var_4);

    if(scripts\engine\utility::flag("flag_retreat_bombardment_complete")) {
      break;
    }

    if(var_2 == level.player && isDefined(self) && isalive(self)) {
      scripts\engine\utility::enable_pain();
      var_5 = level.player getcurrentweapon();

      if(isDefined(var_4) && scripts\sp\damagefeedback::isheadshot(var_4)) {
        self.health = 1;
        level.bombardment_window_kills++;
        waitframe();
        thread scripts\sp\utility::do_damage(100, self.origin, level.player, undefined, undefined, var_5, var_4);
      } else {
        var_0 = var_1 + var_0;

        if(isDefined(var_4) && var_0 < 100) {
          self.health = 50;
          level.bombardment_window_kills++;
          waitframe();
          thread scripts\sp\utility::do_damage(1, self.origin, level.player);
        }

        if(isDefined(var_4) && var_0 > 100) {
          self.health = 50;
          level.bombardment_window_kills++;
          waitframe();
          thread scripts\sp\utility::do_damage(var_0, self.origin, level.player, undefined, undefined, var_5, var_4);
          break;
        }
      }
    }
  }
}

bombardment_aq_window_target_player_manager() {
  level.bombardment_window_kills = 0;

  while(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
    while(level.bombardment_window_kills < 2 || scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      waitframe();

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
      var_0 = scripts\engine\utility::random(level.bombardment_window_ground_bullet_spawners);
      var_0 notify("disable_magic_bullets");
      wait 1;

      if(!scripts\engine\utility::flag("flag_retreat_initial_runto_cover"))
        scripts\engine\utility::flag_set("flag_retreat_initial_runto_cover");

      var_0 thread retreat_building_magic_bullets(undefined, undefined, undefined, 1, 1, 1.0, 1.5);
      level.bombardment_window_kills = 0;
      wait(randomfloatrange(5.0, 7.5));
      var_0 notify("disable_magic_bullets");
      var_0 thread retreat_building_magic_bullets(level.bombardment_window_ground_bullet_targets, undefined, undefined, 0, 0, 1.0, 1.5);
    }
  }

  waitframe();
}

scripted_longdeath_3() {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreme = 1;
  var_0 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_enable_struct", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  self setlookatentity(var_1);
  self setentitytarget(var_1);
  self.forcelongdeath = 3;
  scripts\engine\sp\utility::enable_long_death();
  self.a.force_num_crawls = 4;
  scripts\sp\maps\marines\marines_utility.gsc::waittill_or_timeout("damage", 7);

  if(self.currentpose == "prone") {
    self.forcelongdeath = undefined;
    self kill();
    return;
  }

  self.ignoreme = 1;
  self asmsetstate(self.asmname, "choose_long_death");
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  wait 2;

  if(isDefined(self) && isalive(self))
    self kill();
}

retreat_crawling_deaths_handler() {
  self endon("death");
  self endon("entitydeleted");

  if(self.currentpose == "prone") {
    self kill();
    return;
  }

  self.forcelongdeath = 2;
  self.baseaccuracy = 0;
  self.ignoreme = 1;
  scripts\engine\sp\utility::enable_long_death();
  self setlookatentity(level.player);
  waitframe();
  self.leghit = 1;
  self asmsetstate(self.asmname, "choose_long_death");
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  wait 2;

  if(isDefined(self) && isalive(self))
    self kill();
}

retreat_backup_apc_handler() {
  level.retreat_support_apc_1 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_1", "Goosetickler", "retreat_support_apc_1_start", 1, 0);
  level.retreat_support_apc_1.targetname = "retreat_support_apc_1";
  level.retreat_support_apc_2 = scripts\sp\maps\marines\marines_utility.gsc::setup_named_vehicle("retreat_support_apc_2", "Stormin Norman", "retreat_support_apc_2_start", 0, 0);
  level.retreat_support_apc_2.targetname = "retreat_support_apc_2";
  level.retreat_support_apc_1.dontdisconnectpaths = 1;
  level.retreat_support_apc_2.dontdisconnectpaths = 1;
  level.retreat_support_apc_1.script_badplace = 1;
  level.retreat_support_apc_2.script_badplace = 1;
  level.retreat_support_apc_1 scripts\common\vehicle_code::vehicle_remove_badplace();
  level.retreat_support_apc_2 scripts\common\vehicle_code::vehicle_remove_badplace();
  level.retreat_support_apc_1 thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  level.retreat_support_apc_2 thread scripts\sp\maps\marines\marines_background.gsc::ground_vehicle_sound_handler();
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread scripts\common\vehicle_paths::gopath(level.retreat_support_apc_1);
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(level.retreat_support_apc_1))
    level.retreat_support_apc_1 delete();

  hidemayhem("my_vfx_mayh_marines_retreat_fence_left");
  hidemayhem("my_vfx_mayh_marines_retreat_fence_right");
  waitframe();
  scripts\engine\utility::flag_wait("flag_groundfloor_flank_fallback");

  if(isDefined(level.retreat_support_apc_2))
    level.retreat_support_apc_2 delete();

  if(isDefined(level.retreat_assault_vehicle))
    level.retreat_assault_vehicle delete();
}

enable_tank_stackup(var_0, var_1, var_2) {
  waitframe();
  var_0 moveTo(var_1.origin, 0.1);
  wait 1.0;
  var_0 disconnectPaths();
}

clear_tank_stackup(var_0, var_1, var_2) {
  waitframe();
  var_0 moveTo(var_2.origin, 0.1);
  wait 1.0;
  var_0 connectpaths();
}

disable_retreat_exterior_triggers() {
  var_0 = getEnt("retreat_exterior_trigger", "targetname");
  waitframe();

  if(isDefined(var_0))
    var_0 scripts\engine\utility::trigger_off();
}

enable_retreat_exterior_triggers() {
  var_0 = getEnt("retreat_exterior_trigger", "targetname");
  waitframe();

  if(isDefined(var_0))
    var_0 scripts\engine\utility::trigger_on();
}

retreat_bombardment_player_monitor() {
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_kill_player");

  if(!scripts\engine\utility::flag("flag_retreat_bombardment_cease_fire")) {
    scripts\sp\player_death::set_custom_death_quote(413);
    scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 0);
    waitframe();
    scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, ::retreat_building_magic_bullets, undefined, undefined, undefined, 1, 0, 1.0, 1.5);
  }
}

retreat_gate_breach_griggs_runby() {
  var_0 = scripts\engine\utility::getStruct("rally_struct_griggs", "targetname");
  var_1 = getnode("rally_gate_breach_griggs_node", "targetname");
  level.griggs.animname = "griggs";
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_helo_air_support_intro_dialogue();
  var_0 scripts\common\anim::anim_single_solo_run(level.griggs, "rally_retreat");
  level.griggs scripts\engine\utility::set_movement_speed(80);
  level.griggs setgoalnode(var_1);
  wait 1.0;
  level.griggs scripts\asm\gesture::ai_request_gesture("hold", undefined, 10000);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  level.griggs scripts\common\utility::clear_movement_speed();
  level.griggs allowedstances("stand", "crouch", "prone");
}

retreat_gate_breach_marines() {
  var_0 = scripts\engine\utility::getStruct("rally_struct_marine1", "targetname");
  var_1 = scripts\engine\utility::getStruct("rally_struct_marine2", "targetname");
  var_2 = scripts\engine\utility::getStruct("rally_struct_marine3", "targetname");
  var_3 = getnode("rally_gate_breach_marine1_node", "targetname");
  var_4 = getnode("rally_gate_breach_marine2_node", "targetname");
  var_5 = getnode("rally_gate_breach_marine3_node", "targetname");
  var_6 = getnode("rally_gate_breach_marine4_node", "targetname");
  var_7 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");
  waitframe();

  while(var_7.size < 4) {
    var_7 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("g");
    waitframe();
  }

  var_8 = 0;

  foreach(var_10 in var_7) {
    if(isDefined(var_10) && isalive(var_10) && !isDefined(var_10.magic_bullet_shield))
      var_10 scripts\common\ai::magic_bullet_shield();

    if(var_8 == 0) {
      if(weaponclass(var_10.weapon) != "mg") {
        var_7 = scripts\engine\utility::array_remove(var_7, var_10);
        var_7 = scripts\engine\utility::array_insert(var_7, var_10, 0);
        var_8 = 1;
      }
    }
  }

  if(var_8 == 0) {
    var_12 = scripts\sp\utility::make_weapon("iw8_ar_mike4");
    var_7[0] scripts\anim\shared.gsc::forceuseweapon(var_12, "primary");
  }

  if(isDefined(var_7[0]) && isalive(var_7[0])) {
    var_7[0].animname = "rallyMarine2";
    var_7[0] scripts\engine\sp\utility::set_goal_radius(250);
    var_7[0] allowedstances("crouch");
    var_7[0] setgoalnode(var_4);
  }

  if(isDefined(var_7[1]) && isalive(var_7[1])) {
    var_7[1].animname = "rallyMarine1";
    var_7[1] scripts\engine\sp\utility::set_goal_radius(250);
    var_7[1] allowedstances("crouch");
    var_7[1] setgoalnode(var_3);
  }

  if(isDefined(var_7[2]) && isalive(var_7[2])) {
    var_7[2].animname = "rallyMarine3";
    var_7[2] scripts\engine\sp\utility::set_goal_radius(250);
    var_7[2] allowedstances("crouch");
    var_7[2] setgoalnode(var_5);
  }

  if(isDefined(var_7[3]) && isalive(var_7[3]))
    var_7[3] setgoalnode(var_6);

  if(isDefined(var_7[0]) && isalive(var_7[0]))
    var_0 thread scripts\common\anim::anim_single_solo(var_7[0], "rally_retreat");

  if(isDefined(var_7[2]) && isalive(var_7[2]))
    var_0 thread scripts\common\anim::anim_single_solo(var_7[2], "rally_retreat");

  if(isDefined(var_7[1]) && isalive(var_7[1]))
    var_0 scripts\common\anim::anim_single_solo(var_7[1], "rally_retreat");

  if(isDefined(var_7[0]) && isalive(var_7[0]))
    var_7[0] stopanimScripted();

  if(isDefined(var_7[1]) && isalive(var_7[1]))
    var_7[1] stopanimScripted();

  if(isDefined(var_7[2]) && isalive(var_7[2]))
    var_7[2] stopanimScripted();

  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");

  if(isDefined(var_7[0]) && isalive(var_7[0]))
    var_7[0] allowedstances("stand", "crouch", "prone");

  if(isDefined(var_7[0]) && isalive(var_7[1]))
    var_7[1] allowedstances("stand", "crouch", "prone");

  if(isDefined(var_7[0]) && isalive(var_7[2]))
    var_7[2] allowedstances("stand", "crouch", "prone");
}

apc_turret_behavior(var_0, var_1) {
  self endon("disable_apc_turret_behavior");
  self.mainturret setconvergencetime(0.5, "yaw");
  self.mainturret setconvergencetime(0.05, "pitch");
  thread scripts\vehicle\bromeo::mainturret_attack();
  self.mainturret setmode("manual");
  wait 1;

  for(;;) {
    var_2 = scripts\engine\utility::random(var_0);
    apc_fire_main_cannon(var_2, var_1);
  }
}

apc_fire_main_cannon(var_0, var_1) {
  self.mainturret settargetentity(var_0);

  while(!scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var_0.origin, cos(10)))
    wait 0.1;

  var_2 = 3;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self.mainturret shootturret();
    earthquake(0.15, 0.5, self.origin, 400);
    var_4 = distance2d(self.mainturret.origin, level.player.origin);

    if(var_4 <= 500 && var_4 > 250)
      level.player playRumbleOnEntity("light_1s");

    if(var_4 < 250)
      level.player playRumbleOnEntity("heavy_1s");

    wait 0.2;
  }

  if(var_1 == 1)
    wait(randomfloatrange(0.25, 0.75));
  else
    wait(randomfloatrange(4, 8));

  thread scripts\engine\utility::play_sound_in_space("claymore_expl_debris", var_0.origin);
}

apc_disable_turret() {
  var_0 = getEntArray("tank_final_target_sweep", "targetname");
  self notify("disable_apc_turret_behavior");
  thread scripts\vehicle\bromeo::mainturret_idle();
  waitframe();
  thread apc_turret_scanning_behavior(var_0);
}

apc_turret_scanning_behavior(var_0) {
  self endon("death");
  self endon("entitydeleted");
  var_1 = undefined;
  var_2 = undefined;

  while(isDefined(self) && isalive(self)) {
    if(isDefined(var_2)) {
      while(var_1 == var_2) {
        var_1 = scripts\engine\utility::random(var_0);
        waitframe();
      }
    } else
      var_1 = scripts\engine\utility::random(var_0);

    var_2 = var_1;
    self.mainturret settargetentity(var_1);
    wait 2;
  }
}

retreat_building_magic_bullets(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disable_magic_bullets");

  if(isDefined(var_0))
    var_1 = var_0;

  if(isDefined(var_3)) {
    if(var_3 == 1)
      var_1 = level.player;
  } else if(!isDefined(var_1))
    var_1 = getaiarray("allies");

  if(!isDefined(var_2))
    var_2 = 0;

  thread retreat_building_magic_bullets_damage_monitor();

  for(;;) {
    self.suppressed = 0;

    if(self.suppressed == 1) {
      continue;
    }
    if(isarray(var_1)) {
      var_7 = scripts\engine\utility::random(var_1);

      if(isDefined(var_7.script_forcecolor)) {
        while(isDefined(var_7.script_forcecolor) && var_7.script_forcecolor == "y")
          var_7 = scripts\engine\utility::random(var_1);
      }
    } else
      var_7 = var_1;

    retreat_building_magic_bullets_fire(var_7, randomintrange(5, 15), var_3, var_4);

    if(var_2) {
      break;
    }

    wait(randomfloatrange(var_5, var_6));
  }
}

retreat_building_magic_bullets_fire(var_0, var_1, var_2, var_3) {
  self endon("disable_magic_bullets");
  var_4 = var_0.origin;
  var_5 = undefined;
  var_6 = scripts\engine\utility::getStruct("window_target_1", "targetname");
  var_7 = scripts\engine\utility::getStruct("window_target_2", "targetname");

  if(!isDefined(var_4)) {
    return;
  }
  if(var_2 == 1 && var_3 == 1 && isalive(level.player)) {
    if(closer(level.player.origin, var_6.origin, var_7.origin))
      var_5 = var_6.origin;
    else
      var_5 = var_7.origin;
  }

  for(var_8 = 0; var_8 < var_1; var_8++) {
    wait 0.15;
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.origin, vectortoangles(self.origin - var_4));

    if(var_2 == 1 && var_3 == 1 && isalive(level.player))
      magicbullet("iw8_ar_akilo47_low_damage", self.origin, var_5 + scripts\engine\utility::randomvectorrange(8, 14));
    else if(var_2 == 1 && var_3 == 0 && isalive(level.player))
      magicbullet("iw8_ar_akilo47", self.origin, level.player getEye());
    else
      magicbullet("iw8_ar_akilo47", self.origin, var_4 + scripts\engine\utility::randomvectorrange(-50, 50));

    if(self.suppressed == 1) {
      break;
    }
  }
}

retreat_building_magic_bullets_fire_bradley_ping(var_0, var_1) {
  var_2 = var_0.origin + (0, 0, 50);
  var_3 = undefined;

  if(!isDefined(var_2)) {
    return;
  }
  for(var_4 = 0; var_4 < var_1; var_4++) {
    wait 0.15;
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.origin, vectortoangles(self.origin - var_2));
    magicbullet("iw8_ar_akilo47", self.origin, var_2 + scripts\engine\utility::randomvectorrange(-50, 50));

    if(self.suppressed == 1) {
      break;
    }
  }
}

retreat_building_magic_bullets_damage_monitor() {
  if(!isDefined(self.target)) {
    return;
  }
  for(;;) {
    getEnt(self.target, "targetname") waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_PROJECTILE_SPLASH") {
      self notify("disable_magic_bullets");
      break;
    } else
      self.suppressed = 1;
  }
}

retreat_body_cleanup() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  scripts\sp\maps\marines\marines_manpile_monitor.gsc::manpile_monitor_flush_all();
}

setup_support_marines() {
  self endon("death");
  self endon("entitydeleted");
  self setthreatbiasgroup("retreat_allies");
}

retreat_heli_left_deploy() {
  var_0 = getEnt("retreat_heli_left_exit_node", "targetname");
  var_1 = getEnt("retreat_heli_left_exit_node_final", "targetname");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_bombardment_heli_left_spawn", 5.0);
  level.retreat_heli_left = scripts\common\vehicle::spawn_vehicle_from_targetname("retreat_heli_left");
  level.retreat_heli_left.ignore_background_tracers = 1;
  level.retreat_heli_left.godmode = 1;
  level.retreat_heli_left thread heli_strafing_run(0, 50, 10, 5, 500, 0, 1, undefined, "flag_retreat_bombardment_heli_left_complete", var_0, var_1);
}

retreat_heli_right_deploy() {
  var_0 = getEnt("retreat_heli_right_exit_node", "targetname");
  var_1 = getEnt("retreat_heli_right_exit_node_final", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  level.retreat_heli_right = scripts\common\vehicle::spawn_vehicle_from_targetname("retreat_heli_right");
  level.retreat_heli_right.ignore_background_tracers = 1;
  level.retreat_heli_right.godmode = 1;
  level.retreat_heli_right thread heli_strafing_run(1, 100, 15, 10, 500, 1, 1, "flag_retreat_bombardment_heli_left_complete", "flag_retreat_bombardment_heli_right_complete", var_0, var_1);
}

heli_strafing_run(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = getEntArray(self.target, "targetname");
  var_12 = scripts\engine\sp\utility::getfarthest(level.player.origin, var_11);
  self vehicle_setspeed(var_1, var_2, var_3);
  self setvehgoalpos(var_12.origin, 1);
  self setneargoalnotifydist(var_4);
  self waittill("near_goal");
  var_13 = getEnt("heli_rocket_org", "targetname");
  self.mainturret setmode("manual");
  wait 0.5;

  if(var_5 == 1)
    heli_fire_rocket_at_building(var_0, var_12, var_6, var_7);
  else
    heli_fire_rocket_at_building(var_0, var_12, var_6);

  scripts\engine\utility::flag_set(var_8);
  wait 1.25;
  self clearlookatent();
  self.mainturret setmode("sentry_offline");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_cease_fire");
  wait(randomfloatrange(0.5, 2.0));
  self vehicle_setspeed(100, 10, 5);
  self setvehgoalpos(var_9.origin, 1);
  self waittill("near_goal");
  self setvehgoalpos(var_10.origin, 1);
  self waittill("near_goal");
  self.mainturret delete();
  self delete();
}

heli_fire_rocket_at_building(var_0, var_1, var_2, var_3) {
  var_4 = self.origin;
  var_5 = self.angles;
  self vehicle_setspeed(5, 2.5, 1.5);
  self.mainturret setmode("manual");
  var_6 = getEntArray(var_1.target, "targetname");
  var_7 = 0;

  foreach(var_9 in var_6) {
    if(isDefined(var_3) && scripts\engine\utility::flag(var_3)) {
      break;
    } else {
      self setlookatent(var_9);
      self.mainturret settargetentity(var_9);

      while(!scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var_9.origin, cos(10)))
        wait 0.25;

      heli_rocket_fire(var_9);
      var_7++;

      if(var_2 == 1)
        heli_idle_movement(var_4);

      wait(randomfloatrange(0.5, 1.25));
    }
  }
}

heli_idle_movement(var_0) {
  var_1 = undefined;

  if(scripts\engine\utility::cointoss()) {
    var_2 = anglestoright(self.angles);
    var_1 = var_0 + var_2 * randomintrange(50, 100);
  } else {
    var_3 = anglestoleft(self.angles);
    var_1 = var_0 + var_3 * randomintrange(50, 100);
  }

  self setvehgoalpos(var_1, 1);
}

heli_rocket_fire(var_0) {
  var_1 = self gettagangles("tag_gun_l");
  var_2 = self gettagorigin("tag_gun_l") + (-21, 10, 8) + anglestoleft(var_1) * -100;
  var_3 = self gettagangles("tag_gun_r");
  var_4 = self gettagorigin("tag_gun_r") + (21, 10, 8) + anglestoright(var_3) * -100;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_l");
  thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_l");
  var_5 = magicbullet("apache_proj_sp", var_2, var_0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
  thread missile_impact_rumble();
  wait(randomfloatrange(0.15, 0.25));
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_r");
  thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_r");
  var_5 = magicbullet("apache_proj_sp", var_4, var_0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
  thread missile_impact_rumble();

  if(scripts\engine\utility::cointoss()) {
    wait(randomfloatrange(0.15, 0.25));
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_l");
    thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_l");
    var_5 = magicbullet("apache_proj_sp", var_2, var_0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
    thread missile_impact_rumble();
  }
}

missile_impact_rumble() {
  wait 2;

  if(scripts\engine\utility::cointoss())
    earthquake(0.25, 1, level.player.origin, 100);
  else
    earthquake(0.25, 2, level.player.origin, 100);
}

ai_rpg_behavior() {
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  self.animname = "generic";
  scripts\engine\sp\utility::set_deathanim("rpg_stand_death");
}

ai_frontline_initial_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("hospital_counterattack_aq_volume_center_front", "targetname");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");

  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 0;
    self.ignoreall = 0;
    self cleargoalvolume();
  }

  waitframe();

  if(isDefined(self) && isalive(self))
    self setgoalvolumeauto(var_0);
}

ai_frontline_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("hospital_fallback_laststand", "targetname");
  self.balwayscoverexposed = 1;
}

retreat_hospital_gate_distance_check() {
  var_0 = scripts\engine\utility::getStruct("hospital_gate_clip_block_struct", "targetname");
  var_1 = 1000;

  while(var_1 > 160) {
    var_1 = distance2d(level.retreat_assault_vehicle.origin, var_0.origin);
    waitframe();
  }

  retreat_open_hospital_gate();
}

retreat_open_hospital_gate() {
  var_0 = getEnt("hospital_gate_clip", "targetname");
  var_1 = getEnt("hospital_gate_missile_clip", "targetname");
  var_2 = scripts\engine\utility::getStruct("hospital_gate_clip_block_struct", "targetname");
  var_3 = scripts\engine\utility::getStruct("hospital_gate_clip_unblock_struct", "targetname");
  thread gate_collapse_rumble_handler(var_2);
  playmayhem("my_vfx_mayh_marines_retreat_fence_left");
  playmayhem("my_vfx_mayh_marines_retreat_fence_right");
  scripts\engine\utility::exploder("chain_link_collapse_sparks");
  var_0 moveTo(var_3.origin, 0.1);
  var_1 moveTo(var_3.origin, 0.1);
  waitframe();
  var_0 connectpaths();
}

gate_collapse_rumble_handler(var_0) {
  var_1 = distance2d(var_0.origin, level.player.origin);

  if(var_1 > 250)
    level.player playRumbleOnEntity("light_3s");
  else {
    level.player playRumbleOnEntity("heavy_3s");
    earthquake(0.5, 2, level.player.origin, 100);
  }
}

retreat_start() {
  scripts\engine\sp\utility::set_start_location("start_retreat", [level.player]);
  scripts\engine\utility::flag_set("player_ready_for_marine");
  scripts\engine\utility::flag_set("checkpoint_jumped");
  level.griggs = scripts\sp\maps\marines\marines_utility.gsc::setup_named_ai("griggs", "Sgt. Griggs", "start_retreat_griggs", undefined, undefined, undefined, "Demon 1-2");
  var_0 = getspawnerarray("ally_marine_retreat");
  thread scripts\sp\maps\marines\marines_utility.gsc::marines_checkpoint_forcespawn_allies(var_0);
  thread scripts\sp\maps\marines\marines_utility.gsc::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread mh_house_exit_door_blocker_clear_path();
  thread scripts\sp\maps\marines\marines_gameplay_streets.gsc::stair_blocking_marine_handler();
  level.griggs.support_equipment = 0;
}

retreat_catchup() {
  scripts\engine\utility::flag_set("flag_retreat_smash_gate_tank_hitting_gate");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_complete");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_tank_advance");
  scripts\engine\utility::flag_set("flag_retreat_advance_2");
  thread mh_house_exit_door_blocker_clear_path();
  thread retreat_open_hospital_gate();
  thread scripts\sp\maps\marines\marines_gameplay_hospital.gsc::hospital_exterior_vehicle_monitor();
  setsaveddvar("TLOLRMSL", 0.01);
}

mh_civilian_cleanup() {
  var_0 = [];
  var_0 = scripts\engine\sp\utility::get_living_ai_array("MH_civilian", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
}

mh_house_exit_door_blocker_block_path() {
  var_0 = getEnt("mghouse_blocker_blocked_pallet", "targetname");
  var_1 = getEnt("mghouse_blocker_blocked_pallet_clip", "targetname");
  var_2 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_hide_struct", "targetname");
  var_3 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_show_struct", "targetname");
  var_4 = getEnt("mghouse_blocker_cleared_pallet", "targetname");
  var_5 = getEnt("mghouse_blocker_cleared_pallet_clip", "targetname");
  var_6 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_hide_struct", "targetname");
  var_7 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_show_struct", "targetname");
  level.murderhole_bldg_door_retreat = scripts\sp\door::get_interactive_door("murderhole_bldg_door_retreat");
  level.murderhole_bldg_door_retreat.lockedforai = 1;
  level.murderhole_bldg_door_retreat scripts\game\sp\door::remove_door_snake_cam_ability();
  level.murderhole_bldg_door_retreat.script_max_left_angle = 120;
  level.murderhole_bldg_door_retreat.script_max_right_angle = 120;
  level.murderhole_bldg_door_retreat scripts\sp\door::init_max_yaws();
  level.murderhole_bldg_door_retreat scripts\sp\door::reset_door();
  level.murderhole_bldg_door_retreat scripts\sp\door::remove_open_ability();
  waitframe();
  var_0 moveTo(var_3.origin, 0.1);
  var_1 moveTo(var_3.origin, 0.1);
  wait 0.2;
  var_1 disconnectPaths();
  var_4 moveTo(var_6.origin, 0.1);
  var_5 moveTo(var_6.origin, 0.1);
  wait 0.2;
  var_1 connectpaths();
}

mh_house_exit_door_blocker_clear_path() {
  var_0 = getEnt("mghouse_blocker_blocked_crate", "targetname");
  var_1 = getEnt("mghouse_blocker_blocked_pallet", "targetname");
  var_2 = getEnt("mghouse_blocker_blocked_pallet_clip", "targetname");
  var_3 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_hide_struct", "targetname");
  var_4 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_show_struct", "targetname");
  var_5 = getEnt("mghouse_blocker_cleared_pallet", "targetname");
  var_6 = getEnt("mghouse_blocker_cleared_pallet_clip", "targetname");
  var_7 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_hide_struct", "targetname");
  var_8 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_show_struct", "targetname");

  if(!isDefined(level.murderhole_bldg_door_retreat))
    level.murderhole_bldg_door_retreat = scripts\sp\door::get_interactive_door("murderhole_bldg_door_retreat");

  level.murderhole_bldg_door_retreat.lockedforai = 0;
  level.murderhole_bldg_door_retreat scripts\game\sp\door::remove_door_snake_cam_ability();
  level.murderhole_bldg_door_retreat.script_max_left_angle = 112;
  level.murderhole_bldg_door_retreat scripts\sp\door::init_max_yaws();
  level.murderhole_bldg_door_retreat scripts\sp\door::reset_door();
  waitframe();
  level.murderhole_bldg_door_retreat.script_spawn_open_yaw = 20;
  level.murderhole_bldg_door_retreat notify("first_interact");
  level.murderhole_bldg_door_retreat.open_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
  level.murderhole_bldg_door_retreat thread scripts\sp\door_internal::monitor_door_push();
  waitframe();
  var_0 delete();
  var_1 moveTo(var_3.origin, 0.1);
  var_2 moveTo(var_3.origin, 0.1);
  wait 0.2;
  var_2 connectpaths();
  var_5 moveTo(var_8.origin, 0.1);
  var_6 moveTo(var_8.origin, 0.1);
  wait 0.2;
  var_2 disconnectPaths();
  thread retreat_door_bash_monitor();
}

warning_shots_at_gate() {
  level endon("bombardment_complete");
  var_0 = getEnt("warning_sweep_origin", "targetname");
  var_1 = getEnt("warning_sweep_destination", "targetname");
  scripts\engine\utility::flag_wait("warning_fire_at_gate");

  for(var_2 = 0; var_2 < 50; var_2++) {
    var_3 = randomfloatrange(-30, 50);
    var_4 = randomfloatrange(-30, 50);
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var_0.origin, self.warning_sweep_origin);
    magicbullet("iw8_ar_akilo47", var_0.origin, var_1.origin + (var_3, var_4, 0));
    playFX(scripts\engine\utility::getfx("vfx_hammer_door_hit"), var_1.origin + (var_3, var_4, 0), self.warning_sweep_destination);
    var_2++;
    wait 0.15;
  }
}

mh_rendevous_dialogue() {
  scripts\engine\utility::flag_wait("mg_guys_dead");
  thread scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_alex_mh_clear_dialogue();
}

outside_spawner_cleanup() {
  scripts\engine\utility::flag_wait("flag_lobby_exiting");

  if(isDefined(self))
    self kill();
}

tank_vfx_handler() {
  var_0 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_2");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var_0, level.retreat_assault_vehicle, "tread_le_013_jnt");
}

delete_alley_trucks_monitor() {
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_all_script_models_with_modelname("veh8_civ_lnd_techo_static_dst_black");

  foreach(var_2 in var_0)
  var_2 thread scripts\sp\maps\marines\marines_utility.gsc::delete_when_offscreen(1500);
}

green_marines_move_to_hospital() {
  scripts\engine\utility::flag_wait("flag_retreat_marines_advance_to_lobby_1");
  var_0 = getEnt("counterattack_left_monitor", "targetname");

  while(!scripts\engine\utility::flag("flag_retreat_marines_advance_to_lobby_2")) {
    var_1 = 1;

    foreach(var_3 in getaiarray("axis")) {
      if(ispointinvolume(var_3.origin, var_0))
        var_1 = 0;
    }

    if(var_1 == 1) {
      scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_green_1");
      break;
    }

    waitframe();
  }

  wait 0.1;
}

blue_marines_move_to_hospital() {
  scripts\engine\utility::flag_wait("flag_retreat_marines_advance_to_lobby_1");
  var_0 = getEnt("blue_check_monitor", "targetname");

  while(!scripts\engine\utility::flag("flag_retreat_marines_advance_to_lobby_2")) {
    var_1 = 1;

    foreach(var_3 in getaiarray("axis")) {
      if(ispointinvolume(var_3.origin, var_0))
        var_1 = 0;
    }

    if(var_1 == 1) {
      scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_blue_1");
      break;
    }

    waitframe();
  }

  wait 0.1;
}

retreat_marine_bombardment_reaction_dialogue() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_retreat_bombardment_cease_fire");
  wait 5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_marine_bombardment_reaction_dialogue();
  wait 4;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_marine_bombardment_reaction_dialogue();
  wait 4;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_vo.gsc::vo_retreat_marine_bombardment_reaction_dialogue();
}