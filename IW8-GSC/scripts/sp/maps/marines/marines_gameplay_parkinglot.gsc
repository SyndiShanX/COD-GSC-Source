/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc
*******************************************************************/

function retreat_init() {
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

function retreat_main() {
  thread scripts\sp\maps\marines\marines_utility::transient_waittill("flag_retreat_advance_2", "marines_convoy_geo_tr", undefined);
  thread scripts\sp\maps\marines\marines_utility::propane_rockets_init();
  thread delete_alley_trucks_monitor();
  thread scripts\sp\analytics::analytics_kleenex_update("Start to End Murderhole");
  thread scripts\sp\maps\marines\marines_utility::autosave();
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.manpile_monitor.maximum = 22;
  level.manpile_monitor.maximum_in_fov = 10;
  level.manpile_monitor.ideal = 16;
  level.manpile_monitor.safe_delete_distance = 4000;
  level.manpile_monitor.maximum_weapons = 8;
  level.manpile_monitor.wait_time = 0.3;
  scripts\engine\utility::flag_clear("flag_retreat_exiting_mg_house");
  var0 = getEnt("retreat_tank_stackup_clip_1", "targetname");
  var1 = scripts\engine\utility::getStruct("retreat_tank_stackup_clip_1_enable_struct", "targetname");
  var2 = scripts\engine\utility::getStruct("retreat_tank_stackup_clip_1_disable_struct", "targetname");
  thread enable_retreat_exterior_triggers();
  thread retreat_allied_nav_clip_disable();
  thread retreat_body_cleanup();
  scripts\engine\sp\utility::array_spawn_function_targetname("ally_marine_retreat", &setup_support_marines);
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_stackup_initial_trigger");
  retreat_marine_setup();
  thread marine_mghouse_stackup();
  thread mh_rendevous_dialogue();
  thread spawn_bombardment_aq();
  thread enable_tank_stackup(var0, var1, var2);
  thread enable_runout_bullet_clip();
  thread warning_shots_at_gate();
  thread green_marines_move_to_hospital();
  thread blue_marines_move_to_hospital();
  thread scripts\sp\maps\marines\marines_vo::vo_retreat_griggs_advance_dialogue();
  thread scripts\sp\maps\marines\marines_lighting::sun_adjustments_hospital_trigger("lighting_hospital", -1);
  level.bombardment_window_ground_bullet_spawners = scripts\engine\utility::getStructArray("bombardment_window_ground_bullet_spawners", "targetname");
  level.bombardment_window_ground_bullet_targets = getEntArray("bombardment_window_ground_bullet_targets", "targetname");
  scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, &retreat_building_magic_bullets, level.bombardment_window_ground_bullet_targets, undefined, undefined, 0, 0, 1, 4);
  level.bombardment_window_air_bullet_spawners = scripts\engine\utility::getStructArray("bombardment_window_air_bullet_spawners", "targetname");
  var3 = getEntArray("bombardment_window_air_bullet_targets", "targetname");
  scripts\engine\utility::array_thread(level.bombardment_window_air_bullet_spawners, &retreat_building_magic_bullets, var3, undefined, undefined, 0, 0, 0.1, 1);
  scripts\engine\utility::flag_wait("flag_retreat_spawn_vehicles");
  level.manpile_monitor.maximum_weapons = 22;
  setsaveddvar("TLOLRMSL", 0.01);
  level.retreat_assault_vehicle = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("retreat_assault_vehicle", "Dirt Diggler", "retreat_start_node_apc", 0, 1, 0);
  level.retreat_assault_vehicle.targetname = "retreat_assault_vehicle";
  level.retreat_assault_vehicle.godmode = 1;
  level.retreat_assault_vehicle thread scripts\sp\maps\marines\marines_background::ground_vehicle_sound_handler();
  thread scripts\common\vehicle_paths::gopath(level.retreat_assault_vehicle);
  thread tank_vfx_handler();
  thread retreat_backup_apc_handler();
  thread mh_civilian_cleanup();
  level.player scripts\sp\player::player_movement_state("cqb");
  var4 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");

  foreach(var6 in var4) {
    if(isalive(var6) && isDefined(var6.asmname)) {
      var6 scripts\common\utility::demeanor_override("combat");
    }
  }

  var8 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");

  foreach(var6 in var8) {
    if(isalive(var6) && isDefined(var6.asmname)) {
      var6 scripts\common\utility::demeanor_override("combat");
    }
  }

  var11 = level.allymarines["all"];

  foreach(var6 in var11) {
    if(isalive(var6)) {
      if(!isDefined(var6.magic_bullet_shield)) {
        var6 scripts\common\ai::magic_bullet_shield();
      }
    }
  }

  level.griggs.ignoreall = 1;
  level.griggs.pacifist = 1;

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("combat");
  }

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread scripts\sp\maps\marines\marines_utility::griggs_supplies_refill();
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
  thread scripts\sp\maps\marines\marines_utility::autosave();
  waitframe();
  thread retreat_bombardment_player_monitor();
  var11 = level.allymarines["all"];
  var11 = scripts\engine\utility::array_remove(var11, level.griggs);

  foreach(var6 in var11) {
    if(isalive(var6)) {
      if(isDefined(var6.asmname)) {
        var6 scripts\common\utility::demeanor_override("combat");
      }

      var6.ignoreme = 1;

      if(!isDefined(var6.magic_bullet_shield)) {
        var6 scripts\common\ai::magic_bullet_shield();
      }
    }
  }

  level.griggs.ignoreme = 1;
  var16 = getEntArray("tank_bombardment_targets", "targetname");
  thread apc_turret_behavior(level.retreat_assault_vehicle, var16);
  wait 2;
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_bombardment_initial_trigger");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_start");
  scripts\engine\utility::exploder("lobby_breach");
  thread retreat_marine_bombardment_reaction_dialogue();
  wait 10;
  scripts\engine\utility::flag_wait_all("flag_retreat_bombardment_heli_left_complete", "flag_retreat_bombardment_heli_right_complete");
  scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, &scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 2);
  scripts\engine\utility::array_thread(level.bombardment_window_air_bullet_spawners, &scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 0);
  thread retreat_allied_nav_clip_enable();
  scripts\engine\utility::flag_set("flag_retreat_bombardment_cease_fire");
  var11 = level.allymarines["all"];
  var11 = scripts\engine\utility::array_remove(var11, level.griggs);
  waitframe();

  foreach(var6 in var11) {
    if(isalive(var6)) {
      if(isDefined(var6.asmname)) {
        var6 scripts\common\utility::demeanor_override("cqb");
      }

      var6.ignoreme = 0;

      if(isDefined(var6.magic_bullet_shield)) {
        var6 scripts\common\ai::stop_magic_bullet_shield();
      }
    }
  }

  level.griggs.ignoreme = 0;
  level.griggs.ignoreall = 0;
  level.griggs.pacifist = 0;

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("cqb");
  }

  wait 1;
  thread scripts\sp\maps\marines\marines_vo::vo_retreat_griggs_advance_bombardment_dialogue();
  thread scripts\sp\maps\marines\marines_utility::autosave();
  wait 2;
  thread retreat_aq_counterattack_timeout();
  thread retreat_aq_counterattack_handler();
  thread retreat_tank_advance();
  scripts\engine\utility::flag_set("flag_retreat_bombardment_complete");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_advance_vo_complete", 5);
  level notify("bombardment_complete");
  thread marine_retreat_advance();
  thread clear_tank_stackup(var0, var1, var2);
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  thread retreat_tank_rpg_hit();
  level.player.ignoreme = 1;
  var11 = level.allymarines["all"];

  foreach(var6 in var11) {
    if(isDefined(var6) && isalive(var6)) {
      if(istrue(var6.poi_enabled)) {
        var6 thread scripts\common\ai::poi_enable(0);
      }

      var6 setgoalpos(var6.origin);
    }
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_counter_attack_marines");
  scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_retreat_counterattack");
  thread scripts\sp\maps\marines\marines_utility::autosave();
  thread retreat_aq_counterattack_rooftop_handler();
  scripts\engine\sp\utility::battlechatter_on("allies");
  var11 = level.allymarines["all"];
  var11 = scripts\engine\utility::array_remove(var11, level.griggs);

  foreach(var6 in var11) {
    if(isalive(var6)) {
      if(isDefined(var6.asmname)) {
        var6 scripts\common\utility::demeanor_override("combat");
      }

      var6.ignoreme = 0;
      var6.ignoreall = 0;
      var6.pacifist = 0;
    }
  }

  if(isalive(level.griggs) && isDefined(level.griggs.asmname)) {
    level.griggs scripts\common\utility::demeanor_override("combat");
  }

  var23 = getspawnerarray("aq_retreat_laststand_spawner");
  scripts\engine\utility::flag_wait("flag_retreat_aq_fallback_spawn");
  scripts\sp\spawner::killspawner(61);
  scripts\sp\spawner::killspawner(62);
  var24 = getaiarray("axis");

  if(var24.size < 15) {
    var25 = scripts\engine\sp\utility::array_spawn(var23);
    return;
  }
}

function retreat_tank_advance() {
  wait 1;
  thread apc_disable_turret();
  wait 3;
  scripts\engine\utility::flag_set("flag_retreat_bombardment_tank_advance");
  wait 4;
  thread advance_tank_bullet_pings();
}

function advance_tank_bullet_pings() {
  var0 = scripts\engine\utility::getStructArray("bombardment_window_air_bullet_spawners", "targetname");
  var1 = scripts\engine\utility::getStructArray("bombardment_window_ground_bullet_spawners", "targetname");
  waitframe();
  var2 = scripts\engine\utility::array_combine(var0, var1);

  while(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack")) {
    var3 = scripts\engine\utility::random(var2);
    retreat_building_magic_bullets_fire_bradley_ping(var3, level.retreat_assault_vehicle, randomintrange(2, 5));
    wait randomfloatrange(2, 5);
  }

  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  scripts\engine\utility::array_thread(var2, &scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 1);
}

function retreat_door_bash_monitor() {
  while(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
    if(level.murderhole_bldg_door_retreat.bashed == 1) {
      scripts\engine\utility::flag_set("flag_retreat_exiting_mg_house");
    }

    waitframe();
  }
}

function retreat_aq_counterattack_timeout() {
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  scripts\engine\utility::flag_wait_any_timeout(2, "flag_retreat_trigger_counterattack_timer", "flag_retreat_trigger_counterattack");

  if(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack_timer")) {
    scripts\engine\utility::flag_set("flag_retreat_trigger_counterattack_timer");
    return;
  }
}

function enable_runout_bullet_clip() {
  var0 = getEnt("retreat_runout_bullet_clip", "targetname");
  var1 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_enable_struct", "targetname");
  var2 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_disable_struct", "targetname");
  var0 moveTo(var1.origin, 0.1);
  wait 0.2;
  var0 disconnectPaths();
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  wait 1;
  var0 moveTo(var2.origin, 0.1);
  wait 0.2;
  var0 connectpaths();
}

function retreat_marine_setup() {
  var0 = scripts\engine\utility::getStruct("start_retreat_griggs", "targetname");
  scripts\sp\maps\marines\marines_utility::switch_marines_from_color_to_color("y", "b");
  scripts\sp\maps\marines\marines_utility::switch_marines_from_color_to_color("c", "b");
  scripts\sp\maps\marines\marines_utility::switch_marines_from_color_to_color("r", "b");
  level.griggs forceteleport(var0.origin, var0.angles);
  thread scripts\sp\maps\marines\marines_utility::setup_marine_allies("ally_marine_retreat");
}

function retreat_aq_counterattack_handler() {
  var0 = getspawnerarray("aq_retreat_counterattack_spawner");
  var1 = getspawnerarray("aq_retreat_counterattack_initial_spawner");
  var2 = getspawnerarray("aq_retreat_reinforce_spawner");
  var3 = getspawnerarray("aq_retreat_counterattack_outside_spawner");
  var0 scripts\engine\sp\utility::array_spawn_function(var0, &ai_frontline_behavior);
  var3 scripts\engine\sp\utility::array_spawn_function(var3, &ai_frontline_behavior);
  var1 scripts\engine\sp\utility::array_spawn_function(var1, &ai_frontline_initial_behavior);
  waitframe();

  foreach(var5 in var1) {
    var5 scripts\engine\sp\utility::spawn_ai();
    wait randomfloatrange(0.5, 1.5);
  }

  scripts\engine\utility::flag_wait_any("flag_retreat_trigger_counterattack_timer", "flag_retreat_trigger_counterattack");
  thread scripts\sp\maps\marines\marines_vo::vo_retreat_marine_advance_ambush_initial_dialogue();
  scripts\engine\utility::flag_set("flag_set_push_hospital_objective");
  thread scripts\engine\sp\utility::flood_spawn(var0);
  var7 = scripts\engine\sp\utility::array_spawn(var3);
  thread retreat_aq_counterattack_flank_retreat_monitor();

  foreach(var9 in var7) {
    thread outside_spawner_cleanup();
  }

  wait 5;
  scripts\engine\utility::flag_set("flag_retreat_trigger_counterattack");

  for(var11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"); var11.size > 5; var11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname")) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_retreat_marines_advance_to_lobby_1");
  scripts\engine\utility::flag_wait("flag_retreat_counterattack_refresh");
  var12 = scripts\engine\sp\utility::array_spawn(var2);
  wait 5;

  for(var11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname"); var11.size > 4; var11 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_spawner", "targetname")) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_retreat_marines_advance_to_lobby_2");
  scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_2");
}

function retreat_aq_counterattack_flank_retreat_monitor() {
  var0 = getEnt("counterattack_left_monitor", "targetname");
  var1 = getEnt("counterattack_right_monitor", "targetname");
  var2 = getEnt("retreat_aq_volume_left_retreat", "targetname");
  var3 = getEnt("retreat_aq_volume_right_retreat", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_aq_fallback_spawn");
  var4 = scripts\engine\sp\utility::get_living_ai_array("aq_retreat_counterattack_outside_spawner", "targetname");

  foreach(var6 in var4) {
    if(isDefined(var6) && isalive(var6)) {
      if(ispointinvolume(var6.origin, var0)) {
        var6 setgoalvolumeauto(var2);
        continue;
      }

      if(ispointinvolume(var6.origin, var1)) {
        var6 setgoalvolumeauto(var3);
      }
    }
  }
}

function retreat_aq_counterattack_rooftop_handler() {
  var0 = getspawnerarray("aq_hospital_laststand_roof_spawner");
  var0 scripts\engine\sp\utility::array_spawn_function(var0, &ai_rpg_behavior);
  var1 = 1;
  waitframe();
  var2 = scripts\engine\sp\utility::array_spawn(var0);
  thread retreat_rpg_detonation_manager();
  thread hospital_laststand_roof_alive_monitor();
  scripts\engine\utility::flag_wait("flag_retreat_rooftop_cleanup");
  var3 = [];
  var3 = scripts\engine\sp\utility::get_living_ai_array("aq_hospital_laststand_roof_spawner", "targetname");

  foreach(var5 in var3) {
    if(isDefined(var5)) {
      thread rpg_guy_force_kill(var5);
    }

    var1++;
    wait 1;
  }
}

function rpg_guy_force_kill(var0) {
  var1 = scripts\engine\utility::getStruct("rooftop_kill_magicbullet_fov_struct", "targetname");
  var2 = cos(90);
  var3 = getEnt("rooftop_kill_magicbullet_org_" + var0, "targetname");

  while(isDefined(self) && isalive(self)) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var1.origin, var2)) {
      if(var0 == 1) {
        magicbullet("iw8_ar_akilo47", var3.origin, self gettagorigin("j_head"));
      } else {
        magicgrenade("frag", self.origin, (0, 0, 20), 0.05, 0);
      }
    }

    wait 0.5;
  }
}

function hospital_laststand_roof_alive_monitor() {
  var0 = 0;

  while(!scripts\engine\utility::flag("flag_retreat_rooftop_cleanup") && var0 == 0) {
    var1 = scripts\engine\sp\utility::get_living_ai_array("aq_hospital_laststand_roof_spawner", "targetname");

    if(var1.size < 1) {
      thread scripts\sp\maps\marines\marines_vo::vo_retreat_marine_rpgs_clear_dialogue();
      var0 = 1;
      scripts\engine\utility::flag_set("flag_retreat_rpg_killed");
    }

    waitframe();
  }
}

function retreat_rpg_detonation_manager() {
  var0 = getEnt("retreat_rpg_detonation_volume", "targetname");

  while(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
    level.player waittill("missile_fire", var1, var2);
    thread retreat_rpg_detonation_monitor(var1, var0);
    waitframe();
  }
}

function retreat_rpg_detonation_monitor(var0, var1) {
  while(isDefined(self)) {
    if(ispointinvolume(self.origin, var0)) {
      if(var1.basename == "iw8_la_rpapa7") {
        playFX(level._effect["vfx_explo_rpg"], self.origin);
        playworldsound("frag_grenade_expl_trans", self.origin);

        if(isDefined(self)) {
          self detonate(level.player);
        }
      } else if(var1.basename == "iw8_ar_mike4") {
        playFX(level._effect["vfx_explo_rpg"], self.origin);
        playworldsound("frag_grenade_expl_trans", self.origin);
        radiusdamage(self.origin, 500, 200, 200, level.player, "MOD_EXPLOSIVE");

        if(isDefined(self)) {
          self delete();
        }
      }
    }

    waitframe();
  }
}

function retreat_allied_nav_clip_enable() {
  var0 = getEnt("retreat_bombardment_allied_nav_clip", "targetname");
  var1 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_enable_struct", "targetname");
  var2 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_disable_struct", "targetname");
  var0 moveTo(var1.origin, 0.1);
  wait 0.2;
  var0 connectpaths();
}

function retreat_allied_nav_clip_disable() {
  var0 = getEnt("retreat_bombardment_allied_nav_clip", "targetname");
  var1 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_enable_struct", "targetname");
  var2 = scripts\engine\utility::getStruct("retreat_bombardment_allied_nav_clip_disable_struct", "targetname");
  var0 moveTo(var2.origin, 0.1);
  wait 0.2;
  var0 disconnectPaths();
}

function retreat_tank_rpg_hit() {
  var0 = scripts\engine\utility::getStruct("retreat_tank_magicbullet_rpg_source", "targetname");
  level.vehicle.templates.vehicle_death_fx["script_vehicle_bromeo"][0] = scripts\common\vehicle_build::build_fx("vfx/iw8/level/marines/vfx_explo_tank_rpg.vfx", "tag_origin", "veh_bradley_expl_destr");
  waitframe();
  level.vehicle.templates.vehicle_death_fx["script_vehicle_bromeo"][1] = scripts\common\vehicle_build::build_fx("vfx/iw8/level/marines/vfx_tank_death_fire.vfx", "tag_origin");
  waitframe();

  if(isDefined(level.retreat_assault_vehicle)) {
    level.retreat_assault_vehicle.script_badplace = 0;
    level.retreat_assault_vehicle scripts\common\vehicle_code::vehicle_badplace();
  }

  var1 = magicbullet("iw8_la_rpapa7_straight_ai", var0.origin, level.retreat_assault_vehicle.origin);
  thread ambush_rpg_monitor();
}

function ambush_rpg_monitor() {
  var0 = getEnt("retreat_assault_vehicle_destroyed_clip", "targetname");
  var1 = 0;
  var2 = distance2d(self.origin, level.retreat_assault_vehicle.origin);

  while(isDefined(self) && isDefined(level.retreat_assault_vehicle) && var2 > 150) {
    var2 = distance(self.origin, level.retreat_assault_vehicle.origin);
    level.rpg_impact_source = self.origin;
    waitframe();
  }

  var3 = level.retreat_assault_vehicle.origin;
  var0.origin = level.retreat_assault_vehicle.origin + (-4, 0, 70);
  var0.angles = level.retreat_assault_vehicle.angles + (0, -104, 0);
  waitframe();
  level.vehicle.templates.deathmodel["veh8_mil_lnd_bromeo"] = "veh8_mil_lnd_bromeo_animated_dst";
  playworldsound("frag_grenade_expl_trans", level.rpg_impact_source);
  earthquake(0.5, 3, level.player.origin, 100);
  level.player playRumbleOnEntity("heavy_2s");
  level.player.ignoreme = 0;
  var4 = level.retreat_assault_vehicle;
  var4 scripts\engine\sp\utility::assign_animtree("retreat_tank");
  var4.animname = "retreat_tank";
  var4 thread scripts\common\anim::anim_single_solo(var4, "retreat_assault_vehicle_destroyed");

  if(isDefined(level.retreat_assault_vehicle)) {
    level.retreat_assault_vehicle.godmode = 0;
    level.retreat_assault_vehicle scripts\sp\utility::do_damage(9999, level.retreat_assault_vehicle.origin);
    return;
  }
}

function marine_mghouse_stackup() {
  var0 = getnode("retreat_mghouse_exit_node_1a", "targetname");
  var1 = getnode("retreat_mghouse_exit_node_1b", "targetname");
  var2 = getnode("retreat_mghouse_exit_node_2a", "targetname");
  var3 = getnode("retreat_mghouse_exit_node_2b", "targetname");
  var4 = getnode("retreat_mghouse_exit_node_3", "targetname");
  var5 = getnode("retreat_mghouse_exit_node_4", "targetname");
  var6 = scripts\engine\utility::getStruct("retreat_mghouse_stackup_distance_ref", "targetname");
  var7 = 0;
  wait 1;
  var8 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");
  var9 = sortbydistance(var8, var6.origin);

  foreach(var11 in var9) {
    if(isDefined(var11) && isalive(var11) && var7 < 4) {
      if(var7 == 0 && !scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var11 setgoalnode(var0);
        thread player_using_staircase_monitor(var11, var0);
      } else if(var7 == 0 && scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var11 setgoalnode(var1);
      }

      if(var7 == 1 && !scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var11 setgoalnode(var2);
        thread player_using_staircase_monitor(var11, var2);
      } else if(var7 == 1 && scripts\engine\utility::flag("flag_retreat_player_on_stairs")) {
        var11 setgoalnode(var3);
      }

      if(var7 == 2) {
        var11 setgoalnode(var4);
      }

      if(var7 == 3) {
        var11 setgoalnode(var5);
      }

      var7++;
    }

    waitframe();
  }
}

function player_using_staircase_monitor(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  var2 = getEnt("marine_stairwell_monitor_a", "targetname");
  var3 = getEnt("marine_stairwell_monitor_b", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_player_on_stairs");

  if(isDefined(self) && isalive(self)) {
    var4 = distance(self.origin, var0.origin);

    if(var4 < 100) {
      return;
    }

    if(ispointinvolume(self.origin, var2) || ispointinvolume(self.origin, var3)) {
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
        return;
      }

      return;
    }

    self setgoalnode(var1);
    return;
  }
}

function marine_retreat_advance() {
  var0 = scripts\engine\utility::getStructArray("retreat_advance_left_poi_struct", "targetname");
  var1 = scripts\engine\utility::getStructArray("retreat_advance_right_poi_struct", "targetname");
  level.retreat_advance_available_left_paths = [];
  level.retreat_advance_available_right_paths = [];
  var2 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_1", "targetname");
  var3 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_2", "targetname");
  var4 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_3", "targetname");
  var5 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_4", "targetname");
  var6 = scripts\engine\utility::getStruct("retreat_advance_left_path_struct_5", "targetname");
  var7 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_1", "targetname");
  var8 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_2", "targetname");
  var9 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_3", "targetname");
  var10 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_4", "targetname");
  var11 = scripts\engine\utility::getStruct("retreat_advance_right_path_struct_5", "targetname");
  waitframe();
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var2);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var4);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var3);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var5);
  level.retreat_advance_available_left_paths = scripts\engine\utility::array_add(level.retreat_advance_available_left_paths, var6);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var8);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var10);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var9);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var11);
  level.retreat_advance_available_right_paths = scripts\engine\utility::array_add(level.retreat_advance_available_right_paths, var7);
  var12 = scripts\engine\utility::getStruct("retreat_advance_distance_ref", "targetname");
  var13 = [];
  var14 = [];
  level.retreat_advance_available_left_paths_index = 0;
  level.retreat_advance_available_right_paths_index = 0;
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  level.retreat_assault_vehicle.dontdisconnectpaths = undefined;
  level.retreat_assault_vehicle.script_badplace = 1;
  var13 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("b");
  var14 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
  var14 = scripts\engine\utility::array_add(var14, level.griggs);
  var15 = sortbydistance(var13, var12.origin);
  var16 = sortbydistance(var14, var12.origin);
  thread marine_advance_with_util(var15, var1, level.retreat_advance_available_right_paths, level.retreat_advance_available_right_paths_index);
  thread marine_advance_with_util(var16, var0, level.retreat_advance_available_left_paths, level.retreat_advance_available_left_paths_index);
}

function marine_advance_with_util(var0, var1, var2, var3) {
  var4 = 1;
  var5 = 0;
  var6 = getEntArray("retreat_marine_advance_faketarget", "targetname");

  foreach(var8 in var0) {
    if(isDefined(var8) && isalive(var8)) {
      if(var3 <= var2.size) {
        if(var5 < var4) {
          var9 = scripts\engine\utility::random(var6);
          thread marine_advance_faketarget_shoot_handler(var8);
          var5++;
          var8.poi_enabled = 0;
        }

        if(!isDefined(var8.poi_enabled) || var8.poi_enabled == 0) {
          var10 = scripts\engine\utility::random(var1);
          var8 thread scripts\common\ai::poi_enable(1, var10);
          var8.poi_enabled = 1;
        }

        if(isDefined(var8.goalnode)) {
          if(isDefined(var8.goalnode.target)) {
            var11 = scripts\engine\utility::getStruct(var8.goalnode.target, "targetname");
            var8 thread scripts\sp\maps\marines\marines_utility::marine_path_util(var11, undefined, undefined, undefined, undefined, 0);

            foreach(var13 in var2) {
              if(var13 == var11) {
                var2 = scripts\engine\utility::array_remove(var2, var11);
              }
            }
          }
        } else {
          var8 thread scripts\sp\maps\marines\marines_utility::marine_path_util(var2[var3], undefined, undefined, undefined, undefined, 0);
          var8.script_index = var3;
          var3++;
        }
      }
    }

    wait randomfloatrange(0.5, 2);
  }

  wait 10;
}

function marine_advance_faketarget_shoot_handler(var0) {
  self endon("death");
  self endon("entitydeleted");
  wait randomfloatrange(1, 4);

  while(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack_timer") && isDefined(self) && isalive(self)) {
    self setentitytarget(var0);
    wait 3;

    if(isDefined(self) && isalive(self)) {
      self clearentitytarget();
    }
  }
}

function spawn_bombardment_aq() {
  var0 = getspawnerarray("retreat_aq_bombardment_initial");
  var1 = getspawnerarray("retreat_aq_bombardment_reinforce");
  scripts\engine\sp\utility::array_spawn_function(var0, &bombardment_aq_behavior);
  scripts\engine\sp\utility::array_spawn_function(var1, &bombardment_aq_behavior);
  var2 = [];
  thread bombardment_aq_window_target_player_manager();
  thread bombardment_aq_run_to_cover_monitor();
  scripts\engine\utility::flag_wait("flag_retreat_spawn_initial_aq");
  var3 = scripts\engine\sp\utility::array_spawn(var0);

  foreach(var5 in getaiarray("axis")) {
    if(isDefined(var5.script_index) && var5.script_index == 1334913) {
      thread scripted_longdeath_3();
    }
  }

  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  var2 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
  waitframe();

  foreach(var5 in var2) {
    if(isDefined(var5) && isalive(var5)) {
      if(var5.health > 100) {
        var5.health = 100;
      }
    }
  }

  foreach(var10 in var1) {
    if(var2.size < 17) {
      var10.count = 1;
      waitframe();
      var5 = var10 scripts\engine\sp\utility::spawn_ai();
      waitframe();
      var2 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
      waitframe();
    }
  }

  scripts\engine\utility::flag_wait("flag_retreat_smash_gate_tank_hitting_gate");
  wait 2;
  var12 = 1;
  var13 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
  var14 = [];

  foreach(var5 in var13) {
    if(!isDefined(var5.forcelongdeath)) {
      if(!(isDefined(var5.script_index) && var5.script_index == 1334913)) {
        var14 = var5;
      }
    }
  }

  while(var14.size > var12) {
    var17 = 0;
    var18 = 0;
    var19 = 0;

    foreach(var5 in var14) {
      if(isDefined(var5.node)) {
        switch (var5.node.type) {
          case "Cover Stand":
            var17++;
            break;
          case "Cover Left":
            var18++;
            break;
          case "Cover Right":
            var19++;
            break;
        }
      }
    }

    var5 = scripts\engine\utility::random(var14);

    if(isDefined(var5.node)) {
      switch (var5.node.type) {
        case "Cover Stand":
          if(var17 == 1) {
            var5 scripts\sp\maps\marines\marines_utility::force_long_death(7);
          } else {
            var5 kill();
          }

          break;
        case "Cover Left":
          if(var18 == 1) {
            var5 scripts\sp\maps\marines\marines_utility::force_long_death(9);
          } else {
            var5 kill();
          }

          break;
        case "Cover Right":
          if(var19 == 1) {
            var5 scripts\sp\maps\marines\marines_utility::force_long_death(13);
          } else {
            var5 kill();
          }

          break;
        default:
          var5 kill();
          break;
      }
    } else {
      var5 kill();
    }

    wait 0.8;
    var13 = scripts\engine\sp\utility::get_living_ai_array("retreat_bombardment_aq", "script_noteworthy");
    var14 = [];

    foreach(var5 in var13) {
      if(!isDefined(var5.forcelongdeath)) {
        if(!(isDefined(var5.script_index) && var5.script_index == 1334913)) {
          var14 = var5;
        }
      }
    }
  }

  foreach(var5 in var14) {
    thread retreat_crawling_deaths_handler();
  }
}

function bombardment_aq_behavior() {
  var0 = getEntArray("bombardment_aq_infantry_returning_fire_targets", "targetname");
  var1 = getEntArray("bombardment_aq_infantry_air_bullet_targets", "targetname");
  self.ignoreall = 0;
  self.ignoreme = 1;
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  jumpiftrue(scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) LOC_0000004a;
  thread bombardment_aq_hit_monitor();

  while(isDefined(self) && isalive(self)) {
    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
      var2 = scripts\engine\utility::random(var0);
    } else {
      var2 = scripts\engine\utility::random(var1);
    }

    self setentitytarget(var2);
    wait 2.5;

    if(isDefined(self) && isalive(self)) {
      self clearentitytarget();
    }
  }
}

function bombardment_aq_run_to_cover_monitor() {
  var0 = getEntArray("bombardment_initial_cover_volume", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_initial_runto_cover");
  var1 = scripts\engine\sp\utility::get_living_ai_array("retreat_aq_bombardment_initial", "targetname");
  var2 = ["dx_cbc_aq4_order_move_combat", "dx_cbc_aq4_exposed_movement", "dx_cbc_aq4_exposed_movement_group"];

  foreach(var4 in var1) {
    if(isDefined(var4) && isalive(var4)) {
      if(var0.size > 0) {
        var5 = scripts\engine\utility::getclosest(var4.origin, var0);
        var4 scripts\sp\maps\marines\marines_utility::add_dialogue_line_aq(scripts\engine\utility::random(var2));
        var4 cleargoalvolume();
        var4 setgoalvolumeauto(var5);
        var0 = scripts\engine\utility::array_remove(var0, var5);
      } else {
        var1 = getEntArray("bombardment_initial_cover_volume", "targetname");
        waitframe();
        var5 = scripts\engine\utility::getclosest(var6.origin, var1);
        var6 cleargoalvolume();
        var6 setgoalvolumeauto(var5);
        var1 = scripts\engine\utility::array_remove(var1, var5);
      }

      wait randomfloatrange(0.25, 1);
    }
  }

  var4 = undefined;
  var5 = undefined;
}

function bombardment_aq_hit_monitor() {
  self endon("entitydeleted");
  self endon("death");
  self endon("reset_health");
  self endon("flag_retreat_exiting_mg_house");
  scripts\engine\utility::disable_pain();
  self.health = 9999;
  var0 = 0;

  for(;;) {
    self waittill("damage", var1, var2, var3, var3, var3, var3, var3, var4);

    if(scripts\engine\utility::flag("flag_retreat_bombardment_complete")) {
      break;
    }

    if(var2 == level.player && isDefined(self) && isalive(self)) {
      scripts\engine\utility::enable_pain();
      var5 = level.player getcurrentweapon();

      if(isDefined(var4) && scripts\sp\damagefeedback::isheadshot(var4)) {
        self.health = 1;
        level.bombardment_window_kills++;
        waitframe();
        thread scripts\sp\utility::do_damage(100, self.origin, level.player, undefined, undefined, var5, var4);
      } else {
        var0 = var1 + var0;

        if(isDefined(var4) && var0 < 100) {
          self.health = 50;
          level.bombardment_window_kills++;
          waitframe();
          thread scripts\sp\utility::do_damage(1, self.origin, level.player);
        }

        if(isDefined(var4) && var0 > 100) {
          self.health = 50;
          level.bombardment_window_kills++;
          waitframe();
          thread scripts\sp\utility::do_damage(var0, self.origin, level.player, undefined, undefined, var5, var4);
          break;
        }
      }
    }
  }
}

function bombardment_aq_window_target_player_manager() {
  level.bombardment_window_kills = 0;

  while(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
    while(level.bombardment_window_kills < 2 || scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
      waitframe();
    }

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
      var0 = scripts\engine\utility::random(level.bombardment_window_ground_bullet_spawners);
      var0 notify("disable_magic_bullets");
      wait 1;

      if(!scripts\engine\utility::flag("flag_retreat_initial_runto_cover")) {
        scripts\engine\utility::flag_set("flag_retreat_initial_runto_cover");
      }

      thread retreat_building_magic_bullets(var0, undefined, undefined, undefined, 1, 1, 1);
      level.bombardment_window_kills = 0;
      wait randomfloatrange(5, 7.5);
      var0 notify("disable_magic_bullets");
      thread retreat_building_magic_bullets(var0, level.bombardment_window_ground_bullet_targets, undefined, undefined, 0, 0, 1);
    }
  }

  waitframe();
}

function scripted_longdeath_3() {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreme = 1;
  var0 = scripts\engine\utility::getStruct("retreat_runout_bullet_clip_enable_struct", "targetname");
  var1 = spawn("script_origin", var0.origin);
  self setlookatentity(var1);
  self setentitytarget(var1);
  self.forcelongdeath = 3;
  scripts\engine\sp\utility::enable_long_death();
  self.a.force_num_crawls = 4;
  scripts\sp\maps\marines\marines_utility::waittill_or_timeout("damage", 7);

  if(self.currentpose == "prone") {
    self.forcelongdeath = undefined;
    self kill();
    return;
  }

  self.ignoreme = 1;
  self asmsetstate(self.asmname, "choose_long_death");
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  wait 2;

  if(isDefined(self) && isalive(self)) {
    self kill();
    return;
  }
}

function retreat_crawling_deaths_handler() {
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

  if(isDefined(self) && isalive(self)) {
    self kill();
    return;
  }
}

function retreat_backup_apc_handler() {
  level.retreat_support_apc_1 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("retreat_support_apc_1", "Goosetickler", "retreat_support_apc_1_start", 1, 0);
  level.retreat_support_apc_1.targetname = "retreat_support_apc_1";
  level.retreat_support_apc_2 = scripts\sp\maps\marines\marines_utility::setup_named_vehicle("retreat_support_apc_2", "Stormin Norman", "retreat_support_apc_2_start", 0, 0);
  level.retreat_support_apc_2.targetname = "retreat_support_apc_2";
  level.retreat_support_apc_1.dontdisconnectpaths = 1;
  level.retreat_support_apc_2.dontdisconnectpaths = 1;
  level.retreat_support_apc_1.script_badplace = 1;
  level.retreat_support_apc_2.script_badplace = 1;
  level.retreat_support_apc_1 scripts\common\vehicle_code::vehicle_remove_badplace();
  level.retreat_support_apc_2 scripts\common\vehicle_code::vehicle_remove_badplace();
  level.retreat_support_apc_1 thread scripts\sp\maps\marines\marines_background::ground_vehicle_sound_handler();
  level.retreat_support_apc_2 thread scripts\sp\maps\marines\marines_background::ground_vehicle_sound_handler();
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  thread scripts\common\vehicle_paths::gopath(level.retreat_support_apc_1);
  scripts\engine\utility::flag_wait("flag_groundfloor_hallway_ambush_start");

  if(isDefined(level.retreat_support_apc_1)) {
    level.retreat_support_apc_1 delete();
  }

  hidemayhem("my_vfx_mayh_marines_retreat_fence_left");
  hidemayhem("my_vfx_mayh_marines_retreat_fence_right");
  waitframe();
  scripts\engine\utility::flag_wait("flag_groundfloor_flank_fallback");

  if(isDefined(level.retreat_support_apc_2)) {
    level.retreat_support_apc_2 delete();
  }

  if(isDefined(level.retreat_assault_vehicle)) {
    level.retreat_assault_vehicle delete();
    return;
  }
}

function enable_tank_stackup(var0, var1, var2) {
  waitframe();
  var0 moveTo(var1.origin, 0.1);
  wait 1;
  var0 disconnectPaths();
}

function clear_tank_stackup(var0, var1, var2) {
  waitframe();
  var0 moveTo(var2.origin, 0.1);
  wait 1;
  var0 connectpaths();
}

function disable_retreat_exterior_triggers() {
  var0 = getEnt("retreat_exterior_trigger", "targetname");
  waitframe();

  if(isDefined(var0)) {
    var0 scripts\engine\utility::trigger_off();
    return;
  }
}

function enable_retreat_exterior_triggers() {
  var0 = getEnt("retreat_exterior_trigger", "targetname");
  waitframe();

  if(isDefined(var0)) {
    var0 scripts\engine\utility::trigger_on();
    return;
  }
}

function retreat_bombardment_player_monitor() {
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_kill_player");

  if(!scripts\engine\utility::flag("flag_retreat_bombardment_cease_fire")) {
    scripts\sp\player_death::set_custom_death_quote(413);
    scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, &scripts\engine\sp\utility::notify_delay, "disable_magic_bullets", 0);
    waitframe();
    scripts\engine\utility::array_thread(level.bombardment_window_ground_bullet_spawners, &retreat_building_magic_bullets, undefined, undefined, undefined, 1, 0, 1, 1.5);
    return;
  }
}

function retreat_gate_breach_griggs_runby() {
  var0 = scripts\engine\utility::getStruct("rally_struct_griggs", "targetname");
  var1 = getnode("rally_gate_breach_griggs_node", "targetname");
  level.griggs.animname = "griggs";
  thread scripts\sp\maps\marines\marines_vo::vo_retreat_helo_air_support_intro_dialogue();
  var0 scripts\common\anim::anim_single_solo_run(level.griggs, "rally_retreat");
  level.griggs scripts\engine\utility::set_movement_speed(80);
  level.griggs setgoalnode(var1);
  wait 1;
  level.griggs scripts\asm\gesture::ai_request_gesture("hold", undefined, 10000);
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  level.griggs scripts\common\utility::clear_movement_speed();
  level.griggs allowedstances("stand", "crouch", "prone");
}

function retreat_gate_breach_marines() {
  var0 = scripts\engine\utility::getStruct("rally_struct_marine1", "targetname");
  var1 = scripts\engine\utility::getStruct("rally_struct_marine2", "targetname");
  var2 = scripts\engine\utility::getStruct("rally_struct_marine3", "targetname");
  var3 = getnode("rally_gate_breach_marine1_node", "targetname");
  var4 = getnode("rally_gate_breach_marine2_node", "targetname");
  var5 = getnode("rally_gate_breach_marine3_node", "targetname");
  var6 = getnode("rally_gate_breach_marine4_node", "targetname");
  var7 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
  waitframe();

  while(var7.size < 4) {
    var7 = scripts\sp\maps\marines\marines_utility::get_array_of_living_allies_by_color("g");
    waitframe();
  }

  var8 = 0;

  foreach(var10 in var7) {
    if(isDefined(var10) && isalive(var10) && !isDefined(var10.magic_bullet_shield)) {
      var10 scripts\common\ai::magic_bullet_shield();
    }

    if(var8 == 0) {
      if(weaponclass(var10.weapon) != "mg") {
        var7 = scripts\engine\utility::array_remove(var7, var10);
        var7 = scripts\engine\utility::array_insert(var7, var10, 0);
        var8 = 1;
      }
    }
  }

  if(var8 == 0) {
    var12 = scripts\sp\utility::make_weapon("iw8_ar_mike4");
    var7[0] scripts\anim\shared::forceuseweapon(var12, "primary");
  }

  if(isDefined(var7[0]) && isalive(var7[0])) {
    var7[0].animname = "rallyMarine2";
    var7[0] scripts\engine\sp\utility::set_goal_radius(250);
    var7[0] allowedstances("crouch");
    var7[0] setgoalnode(var4);
  }

  if(isDefined(var7[1]) && isalive(var7[1])) {
    var7[1].animname = "rallyMarine1";
    var7[1] scripts\engine\sp\utility::set_goal_radius(250);
    var7[1] allowedstances("crouch");
    var7[1] setgoalnode(var3);
  }

  if(isDefined(var7[2]) && isalive(var7[2])) {
    var7[2].animname = "rallyMarine3";
    var7[2] scripts\engine\sp\utility::set_goal_radius(250);
    var7[2] allowedstances("crouch");
    var7[2] setgoalnode(var5);
  }

  if(isDefined(var7[3]) && isalive(var7[3])) {
    var7[3] setgoalnode(var6);
  }

  if(isDefined(var7[0]) && isalive(var7[0])) {
    var0 thread scripts\common\anim::anim_single_solo(var7[0], "rally_retreat");
  }

  if(isDefined(var7[2]) && isalive(var7[2])) {
    var0 thread scripts\common\anim::anim_single_solo(var7[2], "rally_retreat");
  }

  if(isDefined(var7[1]) && isalive(var7[1])) {
    var0 scripts\common\anim::anim_single_solo(var7[1], "rally_retreat");
  }

  if(isDefined(var7[0]) && isalive(var7[0])) {
    var7[0] stopanimScripted();
  }

  if(isDefined(var7[1]) && isalive(var7[1])) {
    var7[1] stopanimScripted();
  }

  if(isDefined(var7[2]) && isalive(var7[2])) {
    var7[2] stopanimScripted();
  }

  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");

  if(isDefined(var7[0]) && isalive(var7[0])) {
    var7[0] allowedstances("stand", "crouch", "prone");
  }

  if(isDefined(var7[0]) && isalive(var7[1])) {
    var7[1] allowedstances("stand", "crouch", "prone");
  }

  if(isDefined(var7[0]) && isalive(var7[2])) {
    var7[2] allowedstances("stand", "crouch", "prone");
    return;
  }
}

function apc_turret_behavior(var0, var1) {
  self endon("disable_apc_turret_behavior");
  self.mainturret setconvergencetime(0.5, "yaw");
  self.mainturret setconvergencetime(0.05, "pitch");
  thread scripts\vehicle\bromeo::mainturret_attack();
  self.mainturret setmode("manual");
  wait 1;

  for(;;) {
    var2 = scripts\engine\utility::random(var0);
    apc_fire_main_cannon(var2, var1);
  }
}

function apc_fire_main_cannon(var0, var1) {
  self.mainturret settargetentity(var0);

  while(!scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var0.origin, cos(10))) {
    wait 0.1;
  }

  var2 = 3;

  for(var3 = 0; var3 < var2; var3++) {
    self.mainturret shootturret();
    earthquake(0.15, 0.5, self.origin, 400);
    var4 = distance2d(self.mainturret.origin, level.player.origin);

    if(var4 <= 500 && var4 > 250) {
      level.player playRumbleOnEntity("light_1s");
    }

    if(var4 < 250) {
      level.player playRumbleOnEntity("heavy_1s");
    }

    wait 0.2;
  }

  if(var1 == 1) {
    wait randomfloatrange(0.25, 0.75);
  } else {
    wait randomfloatrange(4, 8);
  }

  thread scripts\engine\utility::play_sound_in_space("claymore_expl_debris", var0.origin);
}

function apc_disable_turret() {
  var0 = getEntArray("tank_final_target_sweep", "targetname");
  self notify("disable_apc_turret_behavior");
  thread scripts\vehicle\bromeo::mainturret_idle();
  waitframe();
  thread apc_turret_scanning_behavior(var0);
}

function apc_turret_scanning_behavior(var0) {
  self endon("death");
  self endon("entitydeleted");
  var1 = undefined;
  var2 = undefined;

  while(isDefined(self) && isalive(self)) {
    if(isDefined(var2)) {
      while(var1 == var2) {
        var1 = scripts\engine\utility::random(var0);
        waitframe();
      }
    } else {
      var1 = scripts\engine\utility::random(var0);
    }

    var2 = var1;
    self.mainturret settargetentity(var1);
    wait 2;
  }
}

function retreat_building_magic_bullets(var0, var1, var2, var3, var4, var5, var6) {
  self endon("disable_magic_bullets");

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(isDefined(var3)) {
    if(var3 == 1) {
      var1 = level.player;
    }
  } else if(!isDefined(var1)) {
    var1 = getaiarray("allies");
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  thread retreat_building_magic_bullets_damage_monitor();

  for(;;) {
    self.suppressed = 0;

    if(self.suppressed == 1) {
      continue;
    }

    if(isarray(var1)) {
      var7 = scripts\engine\utility::random(var1);

      if(isDefined(var7.script_forcecolor)) {
        while(isDefined(var7.script_forcecolor) && var7.script_forcecolor == "y") {
          var7 = scripts\engine\utility::random(var1);
        }
      }
    } else {
      var7 = var1;
    }

    retreat_building_magic_bullets_fire(var7, randomintrange(5, 15), var3, var4);

    if(var2) {
      break;
    }

    wait randomfloatrange(var5, var6);
  }
}

function retreat_building_magic_bullets_fire(var0, var1, var2, var3) {
  self endon("disable_magic_bullets");
  var4 = var0.origin;
  var5 = undefined;
  var6 = scripts\engine\utility::getStruct("window_target_1", "targetname");
  var7 = scripts\engine\utility::getStruct("window_target_2", "targetname");

  if(!isDefined(var4)) {
    return;
  }

  if(var2 == 1 && var3 == 1 && isalive(level.player)) {
    if(closer(level.player.origin, var6.origin, var7.origin)) {
      var5 = var6.origin;
    } else {
      var5 = var7.origin;
    }
  }

  for(var8 = 0; var8 < var1; var8++) {
    wait 0.15;
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.origin, vectortoangles(self.origin - var4));

    if(var2 == 1 && var3 == 1 && isalive(level.player)) {
      magicbullet("iw8_ar_akilo47_low_damage", self.origin, var5 + scripts\engine\utility::randomvectorrange(8, 14));
    } else if(var2 == 1 && var3 == 0 && isalive(level.player)) {
      magicbullet("iw8_ar_akilo47", self.origin, level.player getEye());
    } else {
      magicbullet("iw8_ar_akilo47", self.origin, var4 + scripts\engine\utility::randomvectorrange(-50, 50));
    }

    if(self.suppressed == 1) {
      break;
    }
  }
}

function retreat_building_magic_bullets_fire_bradley_ping(var0, var1) {
  var2 = var0.origin + (0, 0, 50);
  var3 = undefined;

  if(!isDefined(var2)) {
    return;
  }

  for(var4 = 0; var4 < var1; var4++) {
    wait 0.15;
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.origin, vectortoangles(self.origin - var2));
    magicbullet("iw8_ar_akilo47", self.origin, var2 + scripts\engine\utility::randomvectorrange(-50, 50));

    if(self.suppressed == 1) {
      break;
    }
  }
}

function retreat_building_magic_bullets_damage_monitor() {
  jumpiftrue(isDefined(self.target)) LOC_0000000b;
  return;
}

function retreat_body_cleanup() {
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  scripts\sp\maps\marines\marines_manpile_monitor::manpile_monitor_flush_all();
}

function setup_support_marines() {
  self endon("death");
  self endon("entitydeleted");
  self setthreatbiasgroup("retreat_allies");
}

function retreat_heli_left_deploy() {
  var0 = getEnt("retreat_heli_left_exit_node", "targetname");
  var1 = getEnt("retreat_heli_left_exit_node_final", "targetname");
  scripts\engine\utility::flag_wait_or_timeout("flag_retreat_bombardment_heli_left_spawn", 5);
  level.retreat_heli_left = scripts\common\vehicle::spawn_vehicle_from_targetname("retreat_heli_left");
  level.retreat_heli_left.ignore_background_tracers = 1;
  level.retreat_heli_left.godmode = 1;
  thread heli_strafing_run(level.retreat_heli_left, 0, 50, 10, 5, 500, 0, 1, undefined, "flag_retreat_bombardment_heli_left_complete", var0);
}

function retreat_heli_right_deploy() {
  var0 = getEnt("retreat_heli_right_exit_node", "targetname");
  var1 = getEnt("retreat_heli_right_exit_node_final", "targetname");
  scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
  level.retreat_heli_right = scripts\common\vehicle::spawn_vehicle_from_targetname("retreat_heli_right");
  level.retreat_heli_right.ignore_background_tracers = 1;
  level.retreat_heli_right.godmode = 1;
  thread heli_strafing_run(level.retreat_heli_right, 1, 100, 15, 10, 500, 1, 1, "flag_retreat_bombardment_heli_left_complete", "flag_retreat_bombardment_heli_right_complete", var0);
}

function heli_strafing_run(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = getEntArray(self.target, "targetname");
  var12 = scripts\engine\sp\utility::getfarthest(level.player.origin, var11);
  self vehicle_setspeed(var1, var2, var3);
  self setvehgoalpos(var12.origin, 1);
  self setneargoalnotifydist(var4);
  self waittill("near_goal");
  var13 = getEnt("heli_rocket_org", "targetname");
  self.mainturret setmode("manual");
  wait 0.5;

  if(var5 == 1) {
    heli_fire_rocket_at_building(var0, var12, var6, var7);
  } else {
    heli_fire_rocket_at_building(var0, var12, var6);
  }

  scripts\engine\utility::flag_set(var8);
  wait 1.25;
  self clearlookatent();
  self.mainturret setmode("sentry_offline");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_cease_fire");
  wait randomfloatrange(0.5, 2);
  self vehicle_setspeed(100, 10, 5);
  self setvehgoalpos(var9.origin, 1);
  self waittill("near_goal");
  self setvehgoalpos(var10.origin, 1);
  self waittill("near_goal");
  self.mainturret delete();
  self delete();
}

function heli_fire_rocket_at_building(var0, var1, var2, var3) {
  var4 = self.origin;
  var5 = self.angles;
  self vehicle_setspeed(5, 2.5, 1.5);
  self.mainturret setmode("manual");
  var6 = getEntArray(var1.target, "targetname");
  var7 = 0;

  foreach(var9 in var6) {
    if(isDefined(var3) && scripts\engine\utility::flag(var3)) {
      break;
    }

    self setlookatent(var9);
    self.mainturret settargetentity(var9);

    while(!scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var9.origin, cos(10))) {
      wait 0.25;
    }

    heli_rocket_fire(var9);
    var7++;

    if(var2 == 1) {
      heli_idle_movement(var4);
    }

    wait randomfloatrange(0.5, 1.25);
  }
}

function heli_idle_movement(var0) {
  var1 = undefined;

  if(scripts\engine\utility::cointoss()) {
    var2 = anglestoright(self.angles);
    var1 = var0 + var2 * randomintrange(50, 100);
  } else {
    var3 = anglestoleft(self.angles);
    var1 = var0 + var3 * randomintrange(50, 100);
  }

  self setvehgoalpos(var1, 1);
}

function heli_rocket_fire(var0) {
  var1 = self gettagangles("tag_gun_l");
  var2 = self gettagorigin("tag_gun_l") + (-21, 10, 8) + anglestoleft(var1) * -100;
  var3 = self gettagangles("tag_gun_r");
  var4 = self gettagorigin("tag_gun_r") + (21, 10, 8) + anglestoright(var3) * -100;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_l");
  thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_l");
  var5 = magicbullet("apache_proj_sp", var2, var0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
  thread missile_impact_rumble();
  wait randomfloatrange(0.15, 0.25);
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_r");
  thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_r");
  var5 = magicbullet("apache_proj_sp", var4, var0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
  thread missile_impact_rumble();

  if(scripts\engine\utility::cointoss()) {
    wait randomfloatrange(0.15, 0.25);
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_wheelmg_w"), self, "tag_gun_l");
    thread scripts\engine\utility::playsoundontag("weap_marines_apache_proj_launch", "tag_gun_l");
    var5 = magicbullet("apache_proj_sp", var2, var0.origin + scripts\engine\utility::randomvectorrange(-100, 100));
    thread missile_impact_rumble();
    return;
  }
}

function missile_impact_rumble() {
  wait 2;

  if(scripts\engine\utility::cointoss()) {
    earthquake(0.25, 1, level.player.origin, 100);
    return;
  }

  earthquake(0.25, 2, level.player.origin, 100);
}

function ai_rpg_behavior() {
  self.grenadeammo = 0;
  scripts\engine\sp\utility::disable_long_death();
  self.animname = "generic";
  scripts\engine\sp\utility::set_deathanim("rpg_stand_death");
}

function ai_frontline_initial_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("hospital_counterattack_aq_volume_center_front", "targetname");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");

  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 0;
    self.ignoreall = 0;
    self cleargoalvolume();
  }

  waitframe();

  if(isDefined(self) && isalive(self)) {
    self setgoalvolumeauto(var0);
    return;
  }
}

function ai_frontline_behavior() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("hospital_fallback_laststand", "targetname");
  self.balwayscoverexposed = 1;
}

function retreat_hospital_gate_distance_check() {
  var0 = scripts\engine\utility::getStruct("hospital_gate_clip_block_struct", "targetname");
  var1 = 1000;

  while(var1 > 160) {
    var1 = distance2d(level.retreat_assault_vehicle.origin, var0.origin);
    waitframe();
  }

  retreat_open_hospital_gate();
}

function retreat_open_hospital_gate() {
  var0 = getEnt("hospital_gate_clip", "targetname");
  var1 = getEnt("hospital_gate_missile_clip", "targetname");
  var2 = scripts\engine\utility::getStruct("hospital_gate_clip_block_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("hospital_gate_clip_unblock_struct", "targetname");
  thread gate_collapse_rumble_handler(var2);
  playmayhem("my_vfx_mayh_marines_retreat_fence_left");
  playmayhem("my_vfx_mayh_marines_retreat_fence_right");
  scripts\engine\utility::exploder("chain_link_collapse_sparks");
  var0 moveTo(var3.origin, 0.1);
  var1 moveTo(var3.origin, 0.1);
  waitframe();
  var0 connectpaths();
}

function gate_collapse_rumble_handler(var0) {
  var1 = distance2d(var0.origin, level.player.origin);

  if(var1 > 250) {
    level.player playRumbleOnEntity("light_3s");
    return;
  }

  level.player playRumbleOnEntity("heavy_3s");
  earthquake(0.5, 2, level.player.origin, 100);
}

function retreat_start() {
  scripts\engine\sp\utility::set_start_location("start_retreat", [level.player]);
  scripts\engine\utility::flag_set("player_ready_for_marine");
  scripts\engine\utility::flag_set("checkpoint_jumped");
  level.griggs = scripts\sp\maps\marines\marines_utility::setup_named_ai("griggs", "Sgt. Griggs", "start_retreat_griggs", undefined, undefined, undefined, "Demon 1-2");
  var0 = getspawnerarray("ally_marine_retreat");
  thread scripts\sp\maps\marines\marines_utility::marines_checkpoint_forcespawn_allies(var0);
  thread scripts\sp\maps\marines\marines_utility::ally_equipment_backpack(level.griggs, "smoke_tall");
  thread mh_house_exit_door_blocker_clear_path();
  thread scripts\sp\maps\marines\marines_gameplay_streets::stair_blocking_marine_handler();
  level.griggs.support_equipment = 0;
}

function retreat_catchup() {
  scripts\engine\utility::flag_set("flag_retreat_smash_gate_tank_hitting_gate");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_complete");
  scripts\engine\utility::flag_set("flag_retreat_bombardment_tank_advance");
  scripts\engine\utility::flag_set("flag_retreat_advance_2");
  thread mh_house_exit_door_blocker_clear_path();
  thread retreat_open_hospital_gate();
  thread scripts\sp\maps\marines\marines_gameplay_hospital::hospital_exterior_vehicle_monitor();
  setsaveddvar("TLOLRMSL", 0.01);
}

function mh_civilian_cleanup() {
  var0 = [];
  var0 = scripts\engine\sp\utility::get_living_ai_array("MH_civilian", "script_noteworthy");
  scripts\engine\utility::array_delete(var0);
}

function mh_house_exit_door_blocker_block_path() {
  var0 = getEnt("mghouse_blocker_blocked_pallet", "targetname");
  var1 = getEnt("mghouse_blocker_blocked_pallet_clip", "targetname");
  var2 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_hide_struct", "targetname");
  var3 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_show_struct", "targetname");
  var4 = getEnt("mghouse_blocker_cleared_pallet", "targetname");
  var5 = getEnt("mghouse_blocker_cleared_pallet_clip", "targetname");
  var6 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_hide_struct", "targetname");
  var7 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_show_struct", "targetname");
  level.murderhole_bldg_door_retreat = scripts\sp\door::get_interactive_door("murderhole_bldg_door_retreat");
  level.murderhole_bldg_door_retreat.lockedforai = 1;
  level.murderhole_bldg_door_retreat scripts\game\sp\door::remove_door_snake_cam_ability();
  level.murderhole_bldg_door_retreat.script_max_left_angle = 120;
  level.murderhole_bldg_door_retreat.script_max_right_angle = 120;
  level.murderhole_bldg_door_retreat scripts\sp\door::init_max_yaws();
  level.murderhole_bldg_door_retreat scripts\sp\door::reset_door();
  level.murderhole_bldg_door_retreat scripts\sp\door::remove_open_ability();
  waitframe();
  var0 moveTo(var3.origin, 0.1);
  var1 moveTo(var3.origin, 0.1);
  wait 0.2;
  var1 disconnectPaths();
  var4 moveTo(var6.origin, 0.1);
  var5 moveTo(var6.origin, 0.1);
  wait 0.2;
  var1 connectpaths();
}

function mh_house_exit_door_blocker_clear_path() {
  var0 = getEnt("mghouse_blocker_blocked_crate", "targetname");
  var1 = getEnt("mghouse_blocker_blocked_pallet", "targetname");
  var2 = getEnt("mghouse_blocker_blocked_pallet_clip", "targetname");
  var3 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_hide_struct", "targetname");
  var4 = scripts\engine\utility::getStruct("mghouse_blocker_blocked_pallet_clip_show_struct", "targetname");
  var5 = getEnt("mghouse_blocker_cleared_pallet", "targetname");
  var6 = getEnt("mghouse_blocker_cleared_pallet_clip", "targetname");
  var7 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_hide_struct", "targetname");
  var8 = scripts\engine\utility::getStruct("mghouse_blocker_cleared_pallet_clip_show_struct", "targetname");

  if(!isDefined(level.murderhole_bldg_door_retreat)) {
    level.murderhole_bldg_door_retreat = scripts\sp\door::get_interactive_door("murderhole_bldg_door_retreat");
  }

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
  var0 delete();
  var1 moveTo(var3.origin, 0.1);
  var2 moveTo(var3.origin, 0.1);
  wait 0.2;
  var2 connectpaths();
  var5 moveTo(var8.origin, 0.1);
  var6 moveTo(var8.origin, 0.1);
  wait 0.2;
  var2 disconnectPaths();
  thread retreat_door_bash_monitor();
}

function warning_shots_at_gate() {
  level endon("bombardment_complete");
  var0 = getEnt("warning_sweep_origin", "targetname");
  var1 = getEnt("warning_sweep_destination", "targetname");
  scripts\engine\utility::flag_wait("warning_fire_at_gate");

  for(var2 = 0; var2 < 50; var2++) {
    var3 = randomfloatrange(-30, 50);
    var4 = randomfloatrange(-30, 50);
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var0.origin, self.warning_sweep_origin);
    magicbullet("iw8_ar_akilo47", var0.origin, var1.origin + (var3, var4, 0));
    playFX(scripts\engine\utility::getfx("vfx_hammer_door_hit"), var1.origin + (var3, var4, 0), self.warning_sweep_destination);
    var2++;
    wait 0.15;
  }
}

function mh_rendevous_dialogue() {
  scripts\engine\utility::flag_wait("mg_guys_dead");
  thread scripts\sp\maps\marines\marines_vo::vo_retreat_alex_mh_clear_dialogue();
}

function outside_spawner_cleanup() {
  scripts\engine\utility::flag_wait("flag_lobby_exiting");

  if(isDefined(self)) {
    self kill();
    return;
  }
}

function tank_vfx_handler() {
  var0 = scripts\engine\utility::getfx("vfx_vehicle_treadfx_dust");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_advance");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_2");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  playFXOnTag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_bombardment_tank_stop_3");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_ri_013_jnt");
  killfxontag(var0, level.retreat_assault_vehicle, "tread_le_013_jnt");
}

function delete_alley_trucks_monitor() {
  scripts\engine\utility::flag_wait("flag_retreat_trigger_counterattack");
  var0 = scripts\sp\maps\marines\marines_utility::get_all_script_models_with_modelname("veh8_civ_lnd_techo_static_dst_black");

  foreach(var2 in var0) {
    var2 thread scripts\sp\maps\marines\marines_utility::delete_when_offscreen(1500);
  }
}

function green_marines_move_to_hospital() {
  scripts\engine\utility::flag_wait("flag_retreat_marines_advance_to_lobby_1");
  var0 = getEnt("counterattack_left_monitor", "targetname");

  while(!scripts\engine\utility::flag("flag_retreat_marines_advance_to_lobby_2")) {
    var1 = 1;

    foreach(var3 in getaiarray("axis")) {
      if(ispointinvolume(var3.origin, var0)) {
        var1 = 0;
      }
    }

    if(var1 == 1) {
      scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_green_1");
      break;
    }

    waitframe();
  }

  wait 0.1;
}

function blue_marines_move_to_hospital() {
  scripts\engine\utility::flag_wait("flag_retreat_marines_advance_to_lobby_1");
  var0 = getEnt("blue_check_monitor", "targetname");

  while(!scripts\engine\utility::flag("flag_retreat_marines_advance_to_lobby_2")) {
    var1 = 1;

    foreach(var3 in getaiarray("axis")) {
      if(ispointinvolume(var3.origin, var0)) {
        var1 = 0;
      }
    }

    if(var1 == 1) {
      scripts\engine\sp\utility::activate_trigger_with_targetname("retreat_marines_advance_to_lobby_blue_1");
      break;
    }

    waitframe();
  }

  wait 0.1;
}

function retreat_marine_bombardment_reaction_dialogue() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_retreat_bombardment_cease_fire");
  wait 5;
  var0 = scripts\sp\maps\marines\marines_utility::get_closest_marine();
  var0 scripts\sp\maps\marines\marines_vo::vo_retreat_marine_bombardment_reaction_dialogue();
  wait 4;
  var0 = scripts\sp\maps\marines\marines_utility::vo_get_closest_available_marine();
  var0 scripts\sp\maps\marines\marines_vo::vo_retreat_marine_bombardment_reaction_dialogue();
  wait 4;
  var0 = scripts\sp\maps\marines\marines_utility::vo_get_closest_available_marine();
  var0 scripts\sp\maps\marines\marines_vo::vo_retreat_marine_bombardment_reaction_dialogue();
}