/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_air_strip.gsc
**************************************/

air_strip_init() {
  level.start_point = "air_strip";
  objective_add(maps\_utility::obj("rendesvouz"), "invisible", &"SATFARM_OBJ_RENDESVOUZ");
  objective_state_nomessage(maps\_utility::obj("rendesvouz"), "done");
  objective_add(maps\_utility::obj("reach_air_strip"), "current", &"SATFARM_OBJ_REACH_AIR_STRIP");
  thread maps\satfarm_code::follow_icon_manager();
  thread maps\satfarm_m880::setup_ambient_missile_launches("ambient_missile_launch_spot", "base_array_end");
  maps\satfarm_code::kill_spawners_per_checkpoint("air_strip");
}

air_strip_main() {
  if(!isDefined(level.playertank)) {
    maps\satfarm_code::spawn_player_checkpoint("air_strip_");
    maps\satfarm_code::spawn_heroes_checkpoint("air_strip_");
    common_scripts\utility::array_thread(level.allytanks, maps\satfarm_code::npc_tank_combat_init);
  } else {
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[0], "", "switch_air_strip_path_hero0", "air_strip_path_hero0");
    thread maps\satfarm_code::switch_node_on_flag(level.herotanks[1], "", "switch_air_strip_path_hero1", "air_strip_path_hero1");
  }

  level.herotanks[0] thread maps\satfarm_code::tank_relative_speed("air_strip_end_relative_speed", "stop_air_strip_relative_speed", 200, 15, 2);
  level.herotanks[1] thread maps\satfarm_code::tank_relative_speed("air_strip_end_relative_speed", "stop_air_strip_relative_speed", 250, 13.5, 1.5);
  objective_onentity(maps\_utility::obj("reach_air_strip"), level.herotanks[1], (0, 0, 60));
  objective_setpointertextoverride(maps\_utility::obj("reach_air_strip"), &"SATFARM_FOLLOW");
  thread air_strip_begin();
  thread satfarm_transient_sync();
  common_scripts\utility::flag_wait("air_strip_end");
  level.playertank.prevent_sabot_firing = 1;
  maps\_spawner::killspawner(40);
  maps\satfarm_code::kill_vehicle_spawners_now(40);
  air_strip_cleanup();
}

satfarm_transient_sync() {
  common_scripts\utility::flag_wait("satfarm_transient_sync");

  while(!synctransients()) {
    wait 0.01;
  }
}

air_strip_begin() {
  common_scripts\utility::flag_set("air_strip_begin");
  common_scripts\utility::flag_init("1_air_strip_bunker_destroyed");
  common_scripts\utility::flag_init("2_air_strip_bunkers_destroyed");
  common_scripts\utility::flag_init("3_air_strip_bunkers_destroyed");
  common_scripts\utility::flag_init("4_air_strip_bunkers_destroyed");
  thread respawn_test_trig_setup();
  thread air_strip_temp_dialog();
  thread falling_sat_dish();
  thread hangar_entrance_setup();
  thread fennce_smash_setup();
  thread setup_hangar_truck_pre_loaded();
  thread setup_hangar_truck_to_load();
  thread air_strip_choppers();
  thread air_strip_trucks_static_setup();
  thread maps\satfarm_code::saf_streetlight_dynamic_setup("air_strip", "air_strip_end");
  thread maps\satfarm_code::saf_concrete_barrier_dynamic_setup("air_strip", "air_strip_end");
  thread maps\satfarm_code::saf_large_sign_01_dynamic_setup("air_strip", "air_strip_end");
  thread air_strip_hints();
  thread air_strip_obj_markers();
  thread air_strip_ambient_dogfight_1();
  thread air_strip_ambient_dogfight_2();
  thread air_strip_ambient_dogfight_3();
  thread setup_windsocks();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("air_strip_take_off_mig_01");
  var_0 thread air_strip_take_off_mig_01();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("air_strip_take_off_mig_02");
  var_0 thread air_strip_take_off_mig_02();
  thread setup_air_strip_m880();
  var_1 = getEntArray("air_strip_sandbag_bunker_turret", "script_noteworthy");
  common_scripts\utility::array_thread(var_1, ::turret_waittill_damage, "air_strip_take_off_mig_01_go");
  level.playertank thread maps\satfarm_code::tank_save("air_strip");
  wait 1.0;
  level.herotanks[0] thread maps\satfarm_code::move_ally_to_mesh("switch_bridge_deploy_path_hero0", "air_strip_exit_hero0", "air_strip_end");
  level.herotanks[1] thread maps\satfarm_code::move_ally_to_mesh("switch_bridge_deploy_path_hero1", "air_strip_exit_hero1", "air_strip_end");
}

air_strip_trucks_static_setup() {
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname("air_strip_trucks_static");
  common_scripts\utility::array_thread(var_0, maps\satfarm_code::gaz_spawn_setup);
  common_scripts\utility::flag_wait("air_strip_end");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && var_2.classname != "script_vehicle_corpse") {
      var_2 delete();
    }
  }
}

air_strip_temp_dialog() {
  common_scripts\utility::flag_wait("1_air_strip_bunker_destroyed");
  objective_string(maps\_utility::obj("air_strip_defenses"), &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES_REMAINING", 3);
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_onedowntwoto");
  level.playertank thread maps\satfarm_code::tank_save("1_air_strip_bunker_destroyed");
  common_scripts\utility::flag_wait("2_air_strip_bunkers_destroyed");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_goodshootingonemore");
  objective_string(maps\_utility::obj("air_strip_defenses"), &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES_REMAINING", 2);
  level.playertank thread maps\satfarm_code::tank_save("2_air_strip_bunker_destroyed");
  common_scripts\utility::flag_wait("3_air_strip_bunkers_destroyed");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_td1_thatsahitone");
  objective_string(maps\_utility::obj("air_strip_defenses"), &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES_REMAINING", 1);
  level.playertank thread maps\satfarm_code::tank_save("3_air_strip_bunker_destroyed");
  common_scripts\utility::flag_wait("4_air_strip_bunkers_destroyed");
  common_scripts\utility::flag_set("air_strip_end");
  objective_string(maps\_utility::obj("air_strip_defenses"), &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES_REMAINING", 0);
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_boom");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_allenemybunkersdestroyed");
  maps\_utility::objective_complete(maps\_utility::obj("air_strip_defenses"));
}

falling_sat_dish() {
  setup_falling_sat_dish("hangar_dish_crash_org", "spawn_air_strip_a10_gun_dive_entrance", 1);
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_mig29_missile_entrance");
  var_0 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_theairstripis");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_td1_punchthroughthewall");
}

air_strip_take_off_mig_01() {
  self endon("death");
  thread mig_damage_watcher();
  common_scripts\utility::flag_wait("air_strip_take_off_mig_01_go");
  thread maps\_vehicle::gopath(self);
  wait 2.0;
  thread common_scripts\utility::play_sound_in_space("satf_mig29_sonic_boom", self.origin);
  thread vehicle_scripts\_mig29::playafterburner();
}

air_strip_take_off_mig_02() {
  self endon("death");
  thread mig_damage_watcher();
  common_scripts\utility::flag_wait("air_strip_take_off_mig_02_go");
  thread maps\_vehicle::gopath(self);
  wait 2.0;
  thread common_scripts\utility::play_sound_in_space("satf_mig29_sonic_boom", self.origin);
  thread vehicle_scripts\_mig29::playafterburner();
}

mig_damage_watcher() {
  maps\_utility::ent_flag_init("off_ground");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4)) {
      var_4 = tolower(var_4);

      if(var_4 == "mod_projectile" || var_4 == "mod_projectile_splash") {
        thread common_scripts\utility::play_sound_in_space("satf_tank_death_player", self.origin);
        playFXOnTag(level._effect["aerial_explosion_mig29"], self, "tag_origin");
        wait 0.1;
        playFXOnTag(level._effect["jet_crash_dcemp"], self, "tag_origin");
        maps\_vehicle::godoff();
        self kill();
        wait 0.25;

        if(isDefined(self)) {
          self delete();
        }
      }
    }
  }
}

shoot_hangar(var_0) {
  maps\_utility::ent_flag_init("blast_hangar");
  maps\_utility::ent_flag_wait("blast_hangar");

  if(!common_scripts\utility::flag("hangar_blasted")) {
    if(isDefined(var_0)) {
      maps\satfarm_code::fire_on_non_vehicle(var_0, (0, 0, 128));
    }
  }
}

hangar_entrance_setup() {
  thread hangar_baddies();
  thread hangar_wall_smash_setup();
  level.herotanks[0] thread shoot_hangar("hangar_wall_unbroken");
  level.herotanks[1] thread shoot_hangar("hangar_wall_unbroken");
}

hangar_baddies() {
  common_scripts\utility::flag_wait("hangar_blasted");
  var_0 = maps\_utility::array_spawn_targetname("hangar_baddies");
}

setup_hangar_truck_pre_loaded() {
  common_scripts\utility::flag_wait("hangar_blasted");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("hangar_truck_02");
  var_0 thread maps\satfarm_code::gaz_spawn_setup();
}

setup_hangar_truck_to_load() {
  common_scripts\utility::flag_wait("hangar_blasted");
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname("hangar_truck_01");
  var_0 thread maps\satfarm_code::gaz_spawn_setup();
  var_1 = maps\_utility::array_spawn_targetname("hangar_truck_01_loaders");
  var_0 thread maps\_vehicle::vehicle_load_ai(var_1);
  var_0 maps\_utility::ent_flag_wait("loaded");
  thread maps\_vehicle::gopath(var_0);
}

air_strip_choppers() {
  maps\_chopperboss::chopper_boss_locs_populate("script_noteworthy", "heli_nav_mesh_air_strip_array");
  common_scripts\utility::flag_wait_either("spawn_air_strip_choppers", "1_air_strip_bunker_destroyed");
  var_0 = maps\satfarm_code_heli::spawn_hind_enemies(3, "heli_nav_mesh_air_strip_array_start");

  foreach(var_2 in var_0) {
    var_2 thread maps\satfarm_code::chopper_insta_kill();
  }

  wait 4.0;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_enemyattackchoppersmoving");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_laydownsomesmoke");

  if(!common_scripts\utility::flag("PLAYER_POPPED_SMOKE_ONCE")) {
    level.player maps\_utility::display_hint_timeout("HINT_SMOKE", 8.0);
  }

  wait 0.1;
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_switchtothermals");

  if(!common_scripts\utility::flag("PLAYER_TURNED_ON_THERMAL_ONCE")) {
    level.player thread maps\_utility::display_hint_timeout("HINT_THERMAL", 8.0);
  }

  maps\satfarm_code::radio_dialog_add_and_go("satfarm_td2_fedhelosinthe");
  maps\satfarm_code::waittillhelisdead(maps\satfarm_code::get_hinds_enemy_active(), 2);
  wait 3.0;
  var_0 = maps\satfarm_code::get_hinds_enemy_active();

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      level thread maps\satfarm_audio::chopper_death_player(var_2.origin);
      var_2 kill();
      wait 0.1;

      if(isDefined(var_2)) {
        var_2 delete();
      }
    }
  }
}

air_strip_hints() {
  common_scripts\utility::flag_wait("air_strip_mg_hint");

  if(!common_scripts\utility::flag("PLAYER_FIRED_MG_ONCE")) {
    level.player thread maps\_utility::display_hint_timeout("HINT_MACHINE_GUN", 8.0);
  }
}

air_strip_obj_markers() {
  common_scripts\utility::flag_wait("air_strip_take_off_mig_01_go");
  maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_wevegottatakeout");
  maps\_utility::objective_complete(maps\_utility::obj("reach_air_strip"));
  objective_add(maps\_utility::obj("air_strip_defenses"), "current", &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES");
  objective_string_nomessage(maps\_utility::obj("air_strip_defenses"), &"SATFARM_OBJ_DESTROY_AIR_STRIP_DEFENSES_REMAINING", 4 - level.air_strip_m880_death_count);
}

fennce_smash_setup() {
  var_0 = getEntArray("fence_smash_trigger", "targetname");
  common_scripts\utility::array_thread(var_0, ::fence_smash_wait);
}

fence_smash_wait() {
  var_0 = getent(self.target, "targetname");
  var_1 = undefined;
  var_2 = undefined;
  self waittill("trigger", var_3);

  if(!isDefined(level.gate_being_used)) {
    var_2 = getent(var_0.target, "targetname");
    level.gate_being_used = 1;
  }

  if(isDefined(var_3)) {
    if(var_3 == level.playertank) {
      thread common_scripts\utility::play_sound_in_space("satf_fence_crush_plr", level.player.origin);
      level.player thread maps\_gameskill::display_screen_effect("dirt", "bottom", "fullscreen_dirt_bottom", "fullscreen_dirt_bottom_b", randomfloatrange(0.55, 0.66));
      level.player screenshakeonentity(4.0, 1.0, 1.0, 0.5, 0, 0.25, 0, 2.0, 0.5, 0.5);
      level.player playrumbleonentity("damage_light");
    } else
      var_0 thread maps\_utility::play_sound_on_entity("satf_fence_crush");
  }

  if(isDefined(var_0.model)) {
    var_0.animname = var_0.model;
    var_0 maps\_utility::assign_animtree();
    var_0 maps\_utility::assign_model();
    var_1 = var_0.model;
  }

  if(isDefined(var_2)) {
    if(isDefined(var_2.model)) {
      var_2.animname = "saf_hangar_fence_breach_gate";
      var_2 maps\_utility::assign_animtree();
      var_2 maps\_utility::assign_model();
    }
  }

  if(var_1 == "saf_hangar_fence_breach_fence_left") {
    common_scripts\utility::exploder(5011);
  } else if(var_1 == "saf_hangar_fence_breach_fence_right") {
    common_scripts\utility::exploder(5012);
  }

  var_0 thread maps\_anim::anim_single_solo(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 thread maps\_anim::anim_single_solo(var_2, var_1);
  }
}

hangar_wall_smash_setup() {
  var_0 = getent("hangar_door_breakable", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 = getent("hangar_wall_unbroken", "targetname");
  var_1 thread hangar_wall_unbroken_wait();
  var_2 = getent("hangar_wall_broken", "targetname");
  var_2 hide();
  var_3 = getEntArray("hangar_wall_section", "script_noteworthy");

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  common_scripts\utility::flag_wait("hangar_blasted");

  if(isDefined(var_1)) {
    var_1 delete();
  }

  var_2 show();
  thread maps\satfarm_audio::walldowncheck();

  foreach(var_5 in var_3) {
    var_5 show();
  }

  var_9 = getEntArray("hangar_wall_smash_trigger", "targetname");
  common_scripts\utility::array_thread(var_9, ::hangar_wall_smash_wait);
}

hangar_wall_smash_wait() {
  var_0 = getent(self.target, "targetname");
  var_0 maps\_utility::ent_flag_init("destroyed");
  var_0 thread destroy_all_hangar_walls_wait();
  thread hangar_wall_trigger_wait(var_0);
  var_0 thread hangar_wall_broken_wait();
  var_0 maps\_utility::ent_flag_wait("destroyed");

  if(isDefined(var_0.target)) {
    var_1 = getent(var_0.target, "targetname");

    if(isDefined(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(var_0.animation)) {
    if(isDefined(var_0.script_parameters)) {
      common_scripts\utility::exploder(var_0.script_parameters);
    }

    var_0.animname = var_0.animation;
    var_0 maps\_utility::assign_animtree();
    var_0 maps\_utility::assign_model();

    switch (var_0.animname) {
      case "satfarm_hangar_breach_s1":
        var_0 thread hangar_wall_debris_fx("j_s1_p3", "j_s1_p4", "j_s1_p6", "j_s1_p14");
        break;
      case "satfarm_hangar_breach_s2":
        var_0 thread hangar_wall_debris_fx("j_s2_p4", "j_s2_p17", "j_s2_p21", "j_s2_p23");
        break;
      case "satfarm_hangar_breach_s3":
        var_0 thread hangar_wall_debris_fx("j_s3_p7", "j_s3_p19", "j_s3_p26", "j_s3_p36");
        break;
      case "satfarm_hangar_breach_s4":
        var_0 thread hangar_wall_debris_fx("j_s4_p9", "j_s4_p13", "j_s4_p15", "j_s4_p10");
        break;
      default:
        break;
    }

    var_0 maps\_anim::anim_single_solo(var_0, var_0.animation);
  }
}

hangar_wall_debris_fx(var_0, var_1, var_2, var_3) {
  playFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_0);
  playFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_1);
  playFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_2);
  playFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_3);
  self waittillmatch("single anim", "end");
  wait 0.1;
  stopFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_0);
  stopFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_1);
  stopFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_2);
  stopFXOnTag(level._effect["vfx_smk_stream_attach"], self, var_3);
}

hangar_wall_unbroken_wait() {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4)) {
      var_4 = tolower(var_4);
    }

    if(var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" || var_4 == "mod_explosive" || var_4 == "mod_crush") {
      common_scripts\utility::exploder(3000);
      wait 0.1;
      self delete();
      common_scripts\utility::flag_set("hangar_blasted");
      break;
    }

    wait 0.05;
  }
}

hangar_wall_trigger_wait(var_0) {
  var_0 endon("destroyed");
  self waittill("trigger", var_1);

  if(isDefined(var_1)) {
    if(var_1 == level.playertank) {
      thread common_scripts\utility::play_sound_in_space("satf_concrete_barrier_crush_plr", level.player.origin);
      level.player thread maps\_gameskill::display_screen_effect("dirt", "bottom", "fullscreen_dirt_bottom", "fullscreen_dirt_bottom_b", randomfloatrange(0.55, 0.66));
      level.player screenshakeonentity(8.0, 3.0, 3.0, 1.0, 0, 1.0, 500, 6.0, 2.0, 2.0, 1.8);
      level.player playrumbleonentity("ac130_artillery_rumble");
    } else
      var_1 thread maps\_utility::play_sound_on_entity("satf_concrete_barrier_crush");

    var_0 maps\_utility::ent_flag_set("destroyed");
  }
}

hangar_wall_broken_wait() {
  self endon("destroyed");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4)) {
      var_4 = tolower(var_4);
    }

    if(var_4 == "mod_projectile" || var_4 == "mod_explosive" || var_4 == "mod_projectile_splash") {
      thread maps\satfarm_audio::hangar_wall_shot(self.origin);
      maps\_utility::ent_flag_set("destroyed");
      break;
    }

    wait 0.05;
  }
}

destroy_all_hangar_walls_wait() {
  self endon("destroyed");
  common_scripts\utility::flag_wait("destroy_all_hangar_walls");
  maps\_utility::ent_flag_set("destroyed");
}

air_strip_ai_quick_cleanup_spawn_function(var_0) {
  self endon("death");
  thread maps\satfarm_code::detectkill();

  if(self.classname != "script_model") {
    self.a.disablelongdeath = 1;
  }

  self.health = 1;
  thread air_strip_ai_quick_cleanup_death_function();

  if(issubstr(tolower(self.classname), "rpg")) {
    thread maps\satfarm_code::enemy_rpg_unlimited_ammo();
  }

  if(isDefined(self.script_parameters)) {
    if(self.script_parameters == "delete_on_goal") {
      thread maps\satfarm_code::waittill_goal(32, 1);
    } else if(self.script_parameters == "delete_on_goal_mortar") {
      thread maps\satfarm_code::waittill_goal(128, undefined, 1);
    }
  }

  while(!common_scripts\utility::flag("air_strip_end")) {
    wait 0.1;

    if(distancesquared(self.origin, level.player.origin) < var_0) {
      continue;
    }
    if(isDefined(self.magic_bullet_shield)) {
      maps\_utility::stop_magic_bullet_shield();
    }

    self kill();
  }
}

air_strip_ai_quick_cleanup_death_function() {
  self waittill("death");

  if(isDefined(self) && isDefined(self.spawner)) {
    self.spawner.count = 1;
  }
}

air_strip_ambient_dogfight_1() {
  level endon("air_strip_end");

  for(;;) {
    wait(randomfloatrange(10.0, 20.0));
    level.air_strip_ambient_a10_gun_dive_1 = undefined;
    level.air_strip_ambient_a10_gun_dive_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_1");

    if(common_scripts\utility::cointoss()) {
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_1_buddy");
    }

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_1");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss()) {
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_1_buddy");
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

air_strip_ambient_dogfight_2() {
  level endon("air_strip_end");

  for(;;) {
    wait(randomfloatrange(20.0, 40.0));
    level.air_strip_ambient_a10_gun_dive_2 = undefined;
    level.air_strip_ambient_a10_gun_dive_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_2");

    if(common_scripts\utility::cointoss()) {
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_2_buddy");
    }

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_2");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss()) {
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_2_buddy");
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

air_strip_ambient_dogfight_3() {
  level endon("air_strip_end");

  for(;;) {
    wait(randomfloatrange(15.0, 30.0));
    level.air_strip_ambient_a10_gun_dive_3 = undefined;
    level.air_strip_ambient_a10_gun_dive_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_3");

    if(common_scripts\utility::cointoss()) {
      var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_a10_gun_dive_3_buddy");
    }

    wait 0.5;
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_3");
    var_1 thread maps\satfarm_ambient_a10::mig29_afterburners_node_wait();

    if(common_scripts\utility::cointoss()) {
      var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("air_strip_ambient_mig29_missile_dive_3_buddy");
    }

    wait(randomfloatrange(5.0, 10.0));
  }
}

air_strip_cleanup() {
  var_0 = getEntArray("air_strip_ent", "script_noteworthy");
  maps\_utility::array_delete(var_0);
  var_1 = getEntArray("air_strip_sandbag_bunker_turret", "script_noteworthy");

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        var_4 = var_3 getturretowner();

        if(isDefined(var_4) && isalive(var_4)) {
          var_4 stopuseturret();
          var_4 notify("stop_using_built_in_burst_fire");
          wait 0.05;

          if(isDefined(var_4)) {
            var_4 delete();
          }
        }

        var_3 notify("stopfiring");
        var_3 notify("stop_using_built_in_burst_fire");
        wait 0.05;

        if(isDefined(var_3)) {
          var_3 delete();
        }
      }
    }
  }
}

setup_air_strip_m880() {
  level.air_strip_m880s = [];
  level.air_strip_m880_death_count = 0;
  level.air_strip_m880_corpses = [];
  thread monitor_air_strip_m880_death();
  maps\satfarm_m880::satfarm_m880_init("air_strip_m880_01", undefined, "air_strip_defenses");
  maps\satfarm_m880::satfarm_m880_init("air_strip_m880_02", undefined, "air_strip_defenses");
  maps\satfarm_m880::satfarm_m880_init("air_strip_m880_03", undefined, "air_strip_defenses");
  maps\satfarm_m880::satfarm_m880_init("air_strip_m880_04", undefined, "air_strip_defenses");
}

monitor_air_strip_m880_death() {
  level endon("air_strip_end");

  for(;;) {
    if(level.air_strip_m880_death_count == 1) {
      common_scripts\utility::flag_set("1_air_strip_bunker_destroyed");
    }

    if(level.air_strip_m880_death_count == 2) {
      common_scripts\utility::flag_set("2_air_strip_bunkers_destroyed");
    }

    if(level.air_strip_m880_death_count == 3) {
      common_scripts\utility::flag_set("3_air_strip_bunkers_destroyed");
    }

    if(level.air_strip_m880_death_count == 4) {
      common_scripts\utility::flag_set("4_air_strip_bunkers_destroyed");
      break;
    }

    wait 0.1;
  }
}

sandbag_bunker_gunner_spawn_function() {
  self endon("death");
  thread maps\satfarm_code::detectkill();
  self.health = 1;
  self.ragdoll_immediate = 1;
  maps\_utility::disable_surprise();
  maps\_utility::disable_pain();
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  self.disablefriendlyfirereaction = 1;
  self.disablereactionanims = 1;

  if(issubstr(tolower(self.classname), "rpg")) {
    thread maps\satfarm_code::enemy_rpg_unlimited_ammo();
  }

  thread sandbag_bunker_gunner_death_function();
}

turret_waittill_damage(var_0) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }

  self setCanDamage(1);
  self waittill("damage");
  var_1 = self getturretowner();

  if(isDefined(var_1) && isalive(var_1)) {
    var_1 stopuseturret();
    var_1 notify("stop_using_built_in_burst_fire");
  }

  self notify("stopfiring");
  self notify("stop_using_built_in_burst_fire");
  wait 0.05;
  playFX(level._effect["mg_turret_explode"], self.origin);
  thread common_scripts\utility::play_sound_in_space("grenade_explode_default", self.origin);

  if(isDefined(self.script_linkto)) {
    var_2 = getent(self.script_linkto, "sript_linkname");

    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  self delete();
}

sandbag_bunker_gunner_death_function() {
  self waittill("death");

  if(isDefined(self)) {
    return;
  }
}

respawn_test_trig_setup() {
  var_0 = getEntArray("respawn_test_trigger", "targetname");
  common_scripts\utility::array_thread(var_0, ::respawn_test);
  var_1 = getEntArray("vehicle_respawn_test_trigger", "targetname");
  common_scripts\utility::array_thread(var_1, ::vehicle_respawn_test);
}

respawn_test() {
  level endon("air_strip_end");

  for(;;) {
    var_0 = getEntArray(self.target, "targetname");
    self waittill("trigger");
    common_scripts\utility::trigger_off();
    var_1 = maps\_utility::array_spawn(var_0, 1);
    maps\_utility::waittill_dead(var_1);
    common_scripts\utility::trigger_on();

    while(level.player istouching(self)) {
      wait 0.05;
    }

    wait(randomfloatrange(6.0, 10.0));
  }
}

vehicle_respawn_test() {
  level endon("air_strip_end");

  for(;;) {
    self waittill("trigger");
    common_scripts\utility::trigger_off();
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname(self.target);

    foreach(var_2 in var_0) {
      if(isDefined(var_2.target)) {
        thread maps\_vehicle::gopath(var_2);
      }
    }

    maps\_utility::waittill_dead(var_0);
    common_scripts\utility::trigger_on();

    while(level.player istouching(self)) {
      wait 0.05;
    }

    wait(randomfloatrange(6.0, 10.0));
  }
}

hangar_runner_anims() {
  self endon("death");
  thread maps\satfarm_code::detectkill();
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.a.disablelongdeath = 1;
  self.health = 1;
  self.animname = "generic";
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_0 maps\_anim::anim_generic_reach(self, var_0.animation);
  var_0 anim_generic_gravity_run(self, var_0.animation);

  while(isDefined(var_0.target)) {
    var_0 = common_scripts\utility::getstruct(var_0.target, "targetname");

    if(isDefined(var_0.animation)) {
      var_0 maps\_anim::anim_generic_reach(self, var_0.animation);

      if(isDefined(self.script_parameters)) {
        if(self.script_parameters == "fed_guy_01") {
          thread maps\_utility::smart_dialogue("satfarm_fs5_getoutofthe");
        } else if(self.script_parameters == "fed_guy_02") {
          thread maps\_utility::smart_dialogue("satfarm_saf1_runmovemove");
        } else if(self.script_parameters == "fed_guy_03") {
          thread maps\_utility::smart_dialogue("satfarm_fs6_watchout");
        }
      }

      var_0 anim_generic_gravity_run(self, var_0.animation);
      continue;
    }

    self.goalradius = 32;
    self setgoalpos(var_0.origin);
    self waittill("goal");
    self delete();
  }
}

anim_generic_gravity_run(var_0, var_1, var_2, var_3) {
  thread maps\_anim::anim_generic_gravity(var_0, var_1, var_2);

  if(isDefined(var_3)) {
    var_0 thread maps\_anim::anim_set_rate_internal(var_1, var_3, "generic");
  }

  var_4 = getanimlength(maps\_utility::getanim_generic(var_1));
  wait(var_4 - 0.2);
  var_0 clearanim(maps\_utility::getanim_generic(var_1), 0.2);
  var_0 notify("killanimscript");

  if(isDefined(var_3)) {
    var_0 maps\_utility::set_moveplaybackrate(var_3);
  }
}

setup_falling_sat_dish(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = common_scripts\utility::getstruct(var_0, "targetname");
  var_5 = [];
  var_6 = maps\_utility::spawn_anim_model("saf_satellite_destroyed_anim_dish");
  var_5 = common_scripts\utility::array_add(var_5, var_6);
  var_7 = maps\_utility::spawn_anim_model("saf_satellite_destroyed_anim_base");
  var_5 = common_scripts\utility::array_add(var_5, var_7);

  if(isDefined(var_2) && var_2 == 1) {
    var_3 = maps\_utility::spawn_anim_model("dish_crash_a10");
    var_3 maps\_utility::ent_flag_init("crash");
    var_3.angles = var_4.angles;
    var_3 hide();
    var_3 thread sat_dish_a10_crash_waits(var_1, var_4);
  }

  var_4 maps\_anim::anim_first_frame(var_5, "dish_collapse");

  if(isDefined(var_2)) {
    var_3 maps\_utility::ent_flag_wait("crash");
  } else {
    common_scripts\utility::flag_wait(var_1);
  }

  var_4 thread maps\_anim::anim_single(var_5, "dish_collapse");
}

sat_dish_a10_crash_waits(var_0, var_1) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }

  thread maps\satfarm_audio::a10_crash_approach();
  wait 1.5;
  self show();
  playFXOnTag(level._effect["vfx_smk_drk_geotrail"], self, "tag_engine_left");
  var_1 thread maps\_anim::anim_single_solo(self, "dish_collapse");
  self waittillmatch("single anim", "crash");
  maps\_utility::ent_flag_set("crash");
  thread maps\satfarm_audio::a10_crash_impact();
  common_scripts\utility::exploder(5001);
  stopFXOnTag(level._effect["vfx_smk_drk_geotrail"], self, "tag_engine_left");
  wait 0.1;
  self delete();
}

setup_windsocks() {
  var_0 = common_scripts\utility::getstructarray("saf_airfield_windsock_animated", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3 thread windsock_anim();
    var_1++;

    if(var_1 > 10) {
      wait 0.05;
      var_1 = 0;
    }
  }
}

windsock_anim() {
  var_0 = maps\_utility::spawn_anim_model("windsock", self.origin);
  var_0.angles = self.angles;
  thread maps\_anim::anim_loop_solo(var_0, "windsock_large_wind_medium", "stop_windsock_anim");
  common_scripts\utility::flag_wait("air_strip_end");
  self notify("stop_windsock_anim");
  waittillframeend;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}