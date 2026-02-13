/*************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion.gsc
*************************************************************/

main() {
  setDvar("#x3c51757bb6571dfe4", 1.25);
  _id_C2B0();
  level.hubdestination = "cp_zm_skorpion_oasis_tr";
  scripts\cp\cp_destinations::load_destination(level.hubdestination);
  _id_09A4::overrideaitype("enemy_base_zombie_cp", "enemy_base_zombie_skorpion_cp");
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_precache::main();
  scripts\cp\maps\cp_zm_skorpion\gen\cp_zm_skorpion_art::main();
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_fx::main();
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_lighting::main();
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_mq::init();
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_th_quest::init();
  scripts\cp\zombies\cp_zm_poi_spawning::main();
  _id_06EE::_id_D88B("compass_map_cp_zm_skorpion");
  level._id_9F28 = 1;
  level setup_poi_encounters();

  if(getdvarint("#x364d09974ef4a7017", 0) == 1 || scripts\cp\utility::is_season_live(2)) {
    level setup_elite_spawning_rules();
  }

  if(!isDefined(level._id_B7F4)) {
    level._id_B7F4 = "allies";
  }

  var_0 = level.players.size;

  if(var_0 <= 0) {
    var_0 = 1;
  }

  level.xp_per_round_active_player_count = var_0;

  if(level._id_3FD9) {
    return;
  }
  level setup_portal_zone_map();
  level setup_objective_instance_size_array();
  level setup_portal_location_model_part_state_map();
  level setup_objective_entry_triggers_array();
  level._id_10D15 = "scripts/cp/maps/cp_zm_skorpion/cp_zm_skorpion_weaponrank_event.csv";
  level._id_DACA = ::_id_DAC9;
  scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_player_character_setup::_id_8058();
  level._id_81B2 = ["front_gate"];
  level._id_459D = "s4_pi_malpha96_mp";
  _id_076F::_id_8172();
  scripts\engine\utility::_id_5C11("introscreen_over");
  scripts\engine\utility::_id_5C11("flg_dark_aether_fall_vo_cd");
  level._id_4249 = _id_073C::_id_6F90;
  level thread _id_B53E();
  level thread _id_1073C();
  level._id_10D0 = [];
  level.pap_model_animated = 1;

  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    level._id_AE0B = "mtl_s4_camo_pap_oasis_a_zm";
    level._id_AE0C = "mtl_s4_camo_pap_oasis_b_zm";
    level._id_AE0D = "mtl_s4_camo_pap_oasis_c_zm";
  }

  scripts\cp\zombies\zm_ww_riotshield::init();
  level.outofmap_volume = getent("drk_aether_fall_volume", "targetname");
  level.outofmap_teleport_points = scripts\engine\utility::getstructarray("drk_aether_fall_respawn_point", "targetname");
  _id_06CB::_id_AA4E(::onplayerconnect);
  level thread setup_animation_models();
  level scripts\engine\utility::_id_5C11("mq_speaking_stone_playing");
  level thread setup_vercanna_stone_vo();
  level thread setup_wonder_weapon_drop();
}

setup_poi_encounters() {
  level.a_poi_encounters = [];
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_easy_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_medium_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_hard_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_easy_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_hard_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_easy_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_medium_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_hard_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_easy_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_medium_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_skorpion_encounter_hard_10_up");
  level.poi_numbers_csv = "cp/zombies/cp_zm_skorpion_hub_poi_numbers.csv";
  level.a_active_zones = [];
  level.a_active_zones = scripts\engine\utility::array_add(level.a_active_zones, "zone_oasis_fob");
}

setup_objective_instance_size_array() {
  level.small_objective_instance_names = ["objective_hall_first_floor_holdout", "objective_oasis_tents_holdout", "objective_oasis_tents_east_soul_capture_clockwise", "objective_oasis_tents_east_soul_capture"];
  level.large_objective_instance_names = [];
}

setup_elite_spawning_rules() {
  level.s_elite_spawning_rules = scripts\cp\utility::_id_EA7B((0, 0, 0), (0, 0, 0));
  level.s_elite_spawning_rules.first_elite_round = 7;
  level.s_elite_spawning_rules.min_spawns_before_elite = 20;
  level.s_elite_spawning_rules.max_total_elites_to_spawn = 2;
}

_id_B53E() {
  level endon("game_ended");
  wait 2;
  scripts\engine\utility::_id_5C1B("introscreen_over");
  wait 0.5;

  while(!isDefined(level.players[0])) {
    waitframe();
  }

  level.players[0] notify("player_weapon_build_kit_initialized");
  wait 0.5;

  while(!isDefined(level.players[0])) {
    waitframe();
  }

  level.players[0] scripts\cp\utility::_id_5F63(0);
}

_id_C2B0() {
  _id_07F7::_id_7EB6("mp/iw8_default_agent_definition.csv");
}

_id_1073C() {
  if(!isDefined(level._id_11EF)) {
    level._id_11EF = [];
  }

  wait 0.2;
  _id_0999::_id_5237("front_gate");
  _id_7FE7();
  _id_800D();
}

setup_portal_zone_map() {
  level.a_portal_zone_map = [];
  level.a_portal_zone_map["portal_a"] = "zone_oasis_ruins_west";
  level.a_portal_zone_map["portal_a_1"] = "zone_oasis_train";
  level.a_portal_zone_map["portal_b"] = "zone_oasis_road";
  level.a_portal_zone_map["portal_b_1"] = "zone_oasis_crashed_plane_body";
  level.a_portal_zone_map["portal_b_2"] = "zone_oasis_crashed_plane_tail";
  level.a_portal_zone_map["portal_c"] = "zone_oasis_ruins_east";
}

setup_portal_location_model_part_state_map() {
  level.a_default_portal_model_state = "hub";
  level.a_portal_model_state_map = [];
  level.a_portal_model_state_map["objectives_location_oasis_tents"] = "tents";
  level.a_portal_model_state_map["objectives_location_oasis_train"] = "train";
  level.a_portal_model_state_map["objectives_location_oasis_ruins_east"] = "ruins_east";
  level.a_portal_model_state_map["objectives_location_oasis_ruins_west"] = "ruins_west";
  level.a_portal_model_state_map["objectives_location_oasis_crashed_plane"] = "crashed_plane";
  level.a_portal_model_state_map["objectives_location_dark_aether"] = "dark_aether";
  level.a_portal_model_state_map["objectives_location_hall"] = "hall";
}

setup_objective_entry_triggers_array() {
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_east_main_holdout"] = "trigger_ruins_east_main_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_east_exterior_holdout"] = "trigger_ruins_east_exterior_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_west_interior_holdout"] = "trigger_ruins_west_interior_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_west_exterior_holdout"] = "trigger_ruins_west_exterior_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_crashed_plane_east_holdout"] = "trigger_crashed_plane_east_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_crashed_plane_west_holdout"] = "trigger_crashed_plane_west_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_tents_holdout"] = "trigger_tents_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_train_holdout_one"] = "trigger_train_holdout_one";
  level.a_objective_zombie_entry_triggers["objective_oasis_train_holdout_two"] = "trigger_train_holdout_two";
  level.a_objective_zombie_entry_triggers["objective_hall_first_floor_holdout"] = "trigger_hall_first_floor_holdout";
  level.a_objective_zombie_entry_triggers["objective_hall_second_floor_holdout"] = "trigger_hall_second_floor_holdout";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_north_holdout"] = "trigger_dark_aether_north_holdout";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_east_holdout"] = "trigger_dark_aether_east_holdout";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_west_holdout"] = "trigger_dark_aether_west_holdout";
  level.a_objective_zombie_entry_triggers["objective_oasis_train_west_soul_capture"] = "trigger_train_west_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_train_east_soul_capture"] = "trigger_train_east_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_tents_east_soul_capture"] = "trigger_tents_east_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_tents_east_soul_capture_clockwise"] = "trigger_tents_east_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_crashed_plane_west_soul_capture"] = "trigger_crashed_plane_west_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_crashed_plane_west_soul_capture_countclockwise"] = "trigger_crashed_plane_west_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_east_exterior_soul_capture"] = "trigger_ruins_east_exterior_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_east_exterior_soul_capture_clockwise"] = "trigger_ruins_east_exterior_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_west_tent_soul_capture"] = "trigger_ruins_west_tent_soul";
  level.a_objective_zombie_entry_triggers["objective_oasis_ruins_west_tent_soul_capture_clockwise"] = "trigger_ruins_west_tent_soul";
  level.a_objective_zombie_entry_triggers["objective_hall_bottom_up_soul_capture"] = "trigger_hall_bottom_up_soul";
  level.a_objective_zombie_entry_triggers["objective_hall_bottom_up_soul_capture_countclockwise"] = "trigger_hall_bottom_up_soul";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_clockwise_soul_capture"] = "trigger_dark_aether_clockwise_soul";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_counterclockwise_soul_capture"] = "trigger_dark_aether_counterclockwise_soul";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_orb_follow_north"] = "trigger_dark_aether_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_orb_follow_east"] = "trigger_dark_aether_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_orb_follow_oasis_train_east"] = "trigger_train_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_orb_follow_oasis_train_west"] = "trigger_train_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_hall_top_orb_follow"] = "trigger_hall_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_hall_bottom_orb_follow"] = "trigger_hall_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_crashed_plane_west_orb_follow"] = "trigger_crashed_plane_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_crashed_plane_center_orb_follow"] = "trigger_crashed_plane_orb_follow";
  level.a_objective_zombie_entry_triggers["objective_domination_dark_aether_south"] = "trigger_dark_aether_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_dark_aether_north"] = "trigger_dark_aether_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_hall"] = "trigger_hall_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_hall_bottom"] = "trigger_hall_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_crashed_plane"] = "trigger_crashed_plane_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_crashed_plane_west"] = "trigger_crashed_plane_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_train"] = "trigger_train_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_train_east"] = "trigger_train_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_ruin_west_tent"] = "trigger_ruins_west_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_ruin_west_outdoor"] = "trigger_ruins_west_outdoor_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_ruin_east_outdoor"] = "trigger_ruins_east_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_ruin_east_south"] = "trigger_ruins_east_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_tents_east"] = "trigger_tents_domination";
  level.a_objective_zombie_entry_triggers["objective_domination_tents_edge"] = "trigger_tents_domination";
  level.a_objective_zombie_entry_triggers["objective_oasis_train_first_assault"] = "trigger_oasis_train_first_assault";
  level.a_objective_zombie_entry_triggers["objective_dark_aether_forever_blitz"] = "trigger_dark_aether_forever_blitz";
}

_id_7FE7() {
  var_0 = ["messhall", "front_gate"];
}

onplayerconnect() {
  thread handle_player_outofmap();
}

setup_vercanna_stone_vo() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  _id_0737::_id_C266("vercanna_stone_trigger", ::vercanna_stone_hint_logic, ::on_vercanna_stone_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("vercanna_stone_trigger", ::vercanna_stone_hint_tpye);
}

setup_wonder_weapon_drop() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  level.weapon_drop_exclude_list = scripts\engine\utility::array_remove(level.weapon_drop_exclude_list, "s4_me_rindigoww_mp");
}

vercanna_stone_hint_logic(var_0, var_1) {
  if(istrue(level._id_0C35) || isDefined(self._id_EB09) && isDefined(self._id_EB09._id_E76B) && isDefined(self._id_EB09._id_E76B._id_C189) && self._id_EB09._id_E76B._id_C189 != "field_upgrade_healing_aura" || istrue(level._id_493C)) {
    return "";
  } else {
    return &"CP_SKORPION/INTERACT_VERCANNA_STONE";
  }
}

vercanna_stone_hint_tpye(var_0, var_1) {
  if(istrue(level._id_0C35)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

on_vercanna_stone_interact(var_0, var_1) {
  if(istrue(level._id_0C35) || isDefined(self._id_EB09) && isDefined(self._id_EB09._id_E76B) && isDefined(self._id_EB09._id_E76B._id_C189) && self._id_EB09._id_E76B._id_C189 != "field_upgrade_healing_aura" || istrue(level._id_493C)) {
    return;
  }
  level thread _id_0720::play_narration("zm_zohs_hbsk_vrcn_hsma");
  _id_0737::_id_C4AB("vercanna_stone_trigger");
}

dark_aether_outofmap_safeguard(var_0) {
  var_1 = var_0.origin;
  return var_1[0] > -5000 && var_1[1] > 10000 && var_1[2] < -500;
}

handle_player_outofmap() {
  self endon("disconnect");

  if(!isDefined(level.outofmap_volume) || !isDefined(level.outofmap_teleport_points) || level.outofmap_teleport_points.size == 0) {
    return;
  }
  for(;;) {
    if(self istouching(level.outofmap_volume) || dark_aether_outofmap_safeguard(self)) {
      var_0 = _func_0204(level.outofmap_teleport_points, self.origin);
      var_1 = scripts\cp\utility::_id_3EE1("white", 0, self);
      var_1 fadeovertime(0.2);
      var_1.alpha = 1;
      wait 0.3;
      playFX(scripts\engine\utility::getfx("outofmap_teleport"), var_0[0].origin);
      var_2 = self.health - 0.1 * self.maxhealth;

      if(var_2 > 0) {
        self dodamage(var_2, self.origin, undefined, undefined, "MOD_SUICIDE");
      }

      if(isDefined(self._id_1B3D) && self._id_1B3D > 0) {
        _id_0707::_id_D161(self, 0 * self._id_9C09);
      }

      var_3 = var_0[0];

      if(isDefined(level._id_3BE9._id_0F51)) {
        var_4 = level._id_3BE9._id_0F51._id_0481;

        foreach(var_6 in var_0) {
          if(isDefined(var_6._id_039B)) {
            var_7 = strtok(var_6._id_039B, ",");

            if(scripts\cp\utility::_id_88B7(var_7, var_4)) {
              var_3 = var_6;
              break;
            }
          }
        }
      }

      _id_098B::_id_F02A(var_3);
      self playsoundtoplayer("zmb_d_ae_respawn", self);
      self playsoundtoteam("zmb_d_ae_respawn_m", self.team, self, self);
      var_1 fadeovertime(0.8);
      var_1.alpha = 0;
      wait 0.4;
      playFXOnTag(scripts\engine\utility::getfx("outofmap_teleport_begin"), self, "j_head");
      playFXOnTag(scripts\engine\utility::getfx("outofmap_teleport_end"), self, "j_head");
      wait 0.5;
      var_1 destroy();
      thread handle_dark_aether_cliff_fall_vo();
    }

    waitframe();
  }
}

handle_dark_aether_cliff_fall_vo() {
  level endon("game_ended");

  if(!level._id_493C && !level scripts\engine\utility::_id_5C00("flg_dark_aether_fall_vo_cd")) {
    scripts\engine\utility::_id_5C1B("flg_dark_aether_fall_vo_cd");
    _id_0720::_id_BEC0("vercanna_cliff_fall", 1);
    wait 30;
    scripts\engine\utility::_id_5C04("flg_dark_aether_fall_vo_cd");
  }
}

_id_DAC9(var_0) {
  return 0;
}

_id_800D() {
  scripts\cp\zombies\objective_barriers::init();
  var_0 = spawnStruct();
  var_0._id_4828 = [];
  var_0._id_332E = [];
  _id_0987::_id_3328(var_0);
  _id_0987::_id_D797(var_0._id_332E);
  _id_0987::_id_D2B2(1, 1);
  _id_0987::spawn_one_time_objectives();
  scripts\cp\zombies\objective_barriers::hide_all_objective_clip();
  waittillframeend;
  _id_06EF::_id_E16F(level._id_3BE9._id_96DE["objectives_location_fob"]._id_8300["exfil"].versions[0]);
  _id_0987::add_location_ammo_cache_markers(level._id_3BE9._id_96DE["objectives_location_fob"]);
}

setup_animation_models() {
  var_0 = getEntArray("animation_model", "targetname");

  if(_func_0107(var_0)) {
    foreach(var_2 in var_0) {
      if(_func_0121(var_2._id_CE18)) {
        var_2 thread play_script_model_animation();
      }
    }
  }
}

play_script_model_animation() {
  var_0 = randomfloatrange(0.1, 2.0);
  wait(var_0);
  self _meth_82CB(self._id_CE18);
}