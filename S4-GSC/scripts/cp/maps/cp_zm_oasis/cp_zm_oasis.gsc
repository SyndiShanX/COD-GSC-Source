/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis.gsc
*******************************************************/

main() {
  setDvar("#x3c51757bb6571dfe4", 1);
  _id_C2B0();
  level.special_round_vision_override = "cp_zm_oasis_special";
  level.hubdestination = "cp_zm_oasis_oasis_tr";
  scripts\cp\cp_destinations::load_destination(level.hubdestination);
  _id_09A4::overrideaitype("enemy_base_zombie_cp", "enemy_base_zombie_sumpf_cp");
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_precache::main();
  scripts\cp\maps\cp_zm_oasis\gen\cp_zm_oasis_art::main();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_fx::main();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_lighting::main();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_zone::init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_teleport::init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq::init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::init();
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_th_quest::init();
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_side_quest::init();
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_boss::init();
  level.disable_hud_portal = 1;
  _id_06EE::_id_D88B("compass_map_cp_zm_oasis");
  level._id_9F28 = 1;

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
  if(getdvarint("#x3dee089cb49164e4e", 0)) {
    setomnvar("cp_round_base", 1);
  }

  level.score_info_table = "cp/scoreinfo/cp_sumpf_scoreinfo_base.csv";
  level.score_splash_table = "cp/cp_sumpf_splashtable.csv";
  level.round_threshold_juggernaut_override = 15;
  level.round_threshold_trickster_override = 20;
  scripts\cp\zombies\zm_round_logic::init();
  level thread scripts\cp\zombies\zm_rbz_exfil::init();
  level.salvage_pickup_amount = 100;
  level._id_10D15 = "scripts/cp/maps/cp_zm_oasis/cp_zm_oasis_weaponrank_event.csv";
  level._id_DACA = ::_id_DAC9;
  level.wall_buy_pap_table = "cp/cp_wall_buy_pap.csv";
  scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_player_character_setup::_id_8058();
  level thread scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_shooting_gallery::init();
  level thread _id_0770::init_wall_buy_weapon_table("cp/cp_wall_buy_weapons_oasis.csv");
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

  level.item_drop_permanent_weapon_list = ["s4_me_rindigoww_mp"];
  scripts\cp\zombies\zm_ww_riotshield::init();
  scripts\cp\zombies\zm_ww_dg2::init();
  level.outofmap_volume = getent("drk_aether_fall_volume", "targetname");
  level.outofmap_teleport_points = scripts\engine\utility::getstructarray("drk_aether_fall_respawn_point", "targetname");
  _id_06CB::_id_AA4E(::onplayerconnect);
  level thread scripts\cp\zombies\zm_rbz_utility::rbz_initialize();
  level thread setup_animation_models();
  level scripts\engine\utility::_id_5C11("mq_speaking_stone_playing");
  level thread setup_wonder_weapon_drop();
  level thread handle_dynamic_traversal();
  level thread start_vo_watcher();
}

start_vo_watcher() {
  level thread watch_round_two_complete_vo();
  level thread watch_round_three_complete_vo();
  level thread check_players_get_close_to_pap();
}

watch_player_play_close_to_portal_vo() {
  level endon("game_ended");
  level endon("mq_trial_a_done");
  level endon("mq_trial_b_done");
  level endon("mq_trial_c_done");
  self endon("disconnect");
  level waittill("mq_step_three_done");
  var_0 = scripts\engine\utility::getstruct("mq_1st_portal_loc", "script_noteworthy");
  var_1 = var_0.origin;

  for(;;) {
    if(isDefined(self) && distancesquared(self.origin, var_1) < 10000 && !scripts\engine\utility::_id_546E("portal_vo_playing")) {
      scripts\engine\utility::_id_5473("portal_vo_playing");
      scripts\engine\utility::_id_5474("portal_vo_playing");

      if(istrue(level._id_493C)) {
        level waittill("dialogue_finished");
      }

      if(isDefined(self) && isalive(self)) {
        var_2 = _id_0766::getcurrentsuper();
        var_3 = var_2._id_E76B._id_C189;

        if(isDefined(var_3)) {
          var_4 = "";

          switch (var_3) {
            case "field_upgrade_energy_mine":
              var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_dsrx_mikj", "zm_cpm5_rbm5_dsrx_mikk", "zm_cpm5_rbm5_dsrx_mikl"]);
              break;
            case "field_upgrade_ring_of_fire":
              var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_dnvk_mikd", "zm_cpm5_rbm5_dnvk_mike", "zm_cpm5_rbm5_dnvk_mikf"]);
              break;
            case "field_upgrade_aether_shroud":
              var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_blkr_mikg", "zm_cpm5_rbm5_blkr_mikh", "zm_cpm5_rbm5_blkr_miki"]);
              break;
            case "field_upgrade_frost_blast":
              var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_dnrt_mika", "zm_cpm5_rbm5_dnrt_mikb", "zm_cpm5_rbm5_dnrt_mikc"]);
              break;
            case "field_upgrade_healing_aura":
              var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_vrcn_mikm", "zm_cpm5_rbm5_vrcn_mikn", "zm_cpm5_rbm5_vrcn_miko"]);
              break;
          }

          if(var_4 != "") {
            level thread _id_0720::_id_B309(self, var_4);
          }
        }
      }

      return;
    }

    wait 1;
  }
}

watch_player_play_enter_aether_pocket_vo() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 0;

  for(;;) {
    self waittill("player_enter_aether_pocket");
    var_0++;

    if(var_0 >= 3) {
      if(istrue(level._id_493C)) {
        level waittill("dialogue_finished");
      }

      if(isDefined(self) && isalive(self)) {
        var_1 = _id_0766::getcurrentsuper();
        var_2 = var_1._id_E76B._id_C189;

        if(isDefined(var_2)) {
          var_3 = "";

          switch (var_2) {
            case "field_upgrade_energy_mine":
              var_3 = scripts\engine\utility::random(["zm_cpm5_rbm5_dsrx_mijj", "zm_cpm5_rbm5_dsrx_mijk", "zm_cpm5_rbm5_dsrx_mijl"]);
              break;
            case "field_upgrade_ring_of_fire":
              var_3 = scripts\engine\utility::random(["zm_cpm5_rbm5_dnvk_mijd", "zm_cpm5_rbm5_dnvk_mije", "zm_cpm5_rbm5_dnvk_mijf"]);
              break;
            case "field_upgrade_aether_shroud":
              var_3 = scripts\engine\utility::random(["zm_cpm5_rbm5_blkr_mijg", "zm_cpm5_rbm5_blkr_mijh", "zm_cpm5_rbm5_blkr_miji"]);
              break;
            case "field_upgrade_frost_blast":
              var_3 = scripts\engine\utility::random(["zm_cpm5_rbm5_dnrt_mija", "zm_cpm5_rbm5_dnrt_mijb", "zm_cpm5_rbm5_dnrt_mijc"]);
              break;
            case "field_upgrade_healing_aura":
              var_3 = scripts\engine\utility::random(["zm_cpm5_rbm5_vrcn_mijm", "zm_cpm5_rbm5_vrcn_mijn", "zm_cpm5_rbm5_vrcn_mijo"]);
              break;
          }

          if(var_3 != "") {
            level thread _id_0720::_id_B309(self, var_3);
          }
        }

        return;
      }
    }
  }
}

check_players_get_close_to_pap() {
  level endon("game_ended");
  level endon("papq_top_part_returned");
  level endon("papq_med_part_returned");
  var_0 = scripts\engine\utility::getstruct("papq_pap_center", "script_noteworthy");
  var_1 = var_0.origin;

  for(;;) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && distancesquared(var_3.origin, var_1) < 10000 && !level scripts\engine\utility::_id_5C00("pap_vo_playing")) {
        level scripts\engine\utility::_id_5C11("pap_vo_playing");
        level scripts\engine\utility::_id_5C1B("pap_vo_playing");
        var_4 = scripts\engine\utility::random(["zm_cpm5_rbm5_krft_mida", "zm_cpm5_rbm5_krft_midb", "zm_cpm5_rbm5_krft_midc", "zm_cpm5_rbm5_krft_midd"]);
        level thread _id_0720::play_narrations(var_4, 1, 0);
        level waittill("dialogue_finished");
        level scripts\engine\utility::_id_5C04("zombie_fountain_vo_playing");
        return;
      }
    }

    wait 1;
  }
}

watch_round_two_complete_vo() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");

    if(scripts\cp\zombies\zm_round_logic::get_round() == 2) {
      var_0 = ["zm_cpm5_rbm5_krft_miba", "zm_cpm5_rbm5_dnvk_mibb"];
      var_1 = ["zm_cpm5_rbm5_krft_mibc", "zm_cpm5_rbm5_dnvk_mibd"];
      var_2 = ["zm_cpm5_rbm5_krft_mibe", "zm_cpm5_rbm5_dnvk_mibf"];
      var_3 = ["zm_cpm5_rbm5_krft_mibg", "zm_cpm5_rbm5_dnvk_mibh"];
      var_4 = scripts\engine\utility::random([var_0, var_1, var_2, var_3]);
      level thread _id_0720::play_narrations(var_4, 1, 0, "force_quit_current_dialogue");
      level waittill("dialogue_finished");
      return;
    } else if(scripts\cp\zombies\zm_round_logic::get_round() > 2)
      return;
  }
}

watch_round_three_complete_vo() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");

    if(scripts\cp\zombies\zm_round_logic::get_round() == 3) {
      var_0 = ["zm_cpm5_rbm5_dnrt_mica", "zm_cpm5_rbm5_dnrt_micb", "zm_cpm5_rbm5_dnrt_micc"];
      var_1 = ["zm_cpm5_rbm5_dnrt_micd", "zm_cpm5_rbm5_dnrt_mice", "zm_cpm5_rbm5_krft_micf"];
      var_2 = ["zm_cpm5_rbm5_dnrt_micg", "zm_cpm5_rbm5_dnrt_mich", "zm_cpm5_rbm5_krft_mici"];
      var_3 = ["zm_cpm5_rbm5_dnrt_micj", "zm_cpm5_rbm5_dnrt_mick", "zm_cpm5_rbm5_krft_micl"];
      var_4 = scripts\engine\utility::random([var_0, var_1, var_2, var_3]);
      level thread _id_0720::play_narrations(var_4, 1, 0, "force_quit_current_dialogue");
      level waittill("dialogue_finished");
      return;
    } else if(scripts\cp\zombies\zm_round_logic::get_round() > 3)
      return;
  }
}

setup_poi_encounters() {
  level.a_poi_encounters = [];
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_easy_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_medium_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_hard_01_to_03");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_easy_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zod_encounter_medium_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_hard_04_to_05");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_easy_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_medium_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_hard_06_to_09");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_easy_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_medium_10_up");
  level.a_poi_encounters[level.a_poi_encounters.size] = _func_0393("poiencounters:cp_zm_oasis_encounter_hard_10_up");
  level.poi_numbers_csv = "cp/zombies/cp_zm_oasis_hub_poi_numbers.csv";
  level.a_active_zones = [];
  level.a_active_zones = scripts\engine\utility::array_add(level.a_active_zones, "zone_oasis_fob");
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

_id_7FE7() {
  var_0 = ["messhall", "front_gate"];
}

onplayerconnect() {
  thread handle_player_outofmap();
  thread watch_player_play_close_to_portal_vo();
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
  level.weapon_drop_exclude_list = scripts\engine\utility::array_remove(level.weapon_drop_exclude_list, "s4_ar_tgun_mp");
  level.oasis_wonder_weapons = [];
  level.oasis_wonder_weapons[0] = "s4_me_rindigoww_mp";
  level.oasis_wonder_weapons[1] = "s4_ar_tgun_mp";
  level.oasis_check_wonder_weapon_drop = ::oasis_check_wonder_weapon_drop;
  level.on_magicbox_selected_item = ::oasis_check_wwshield_spawned_in_magicbox;
}

oasis_check_wonder_weapon_drop(var_0) {
  if(var_0 == "s4_me_rindigoww_mp") {
    if(istrue(level.can_drop_ww_shield) && !istrue(level.ww_shield_already_dropped_from_box)) {
      return 1;
    } else {
      return 0;
    }
  } else if(istrue(level.can_drop_ww_dg2))
    return 1;
  else {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2) || !isalive(var_2)) {
        continue;
      }
      var_3 = var_2 getweaponslistprimaries();

      foreach(var_5 in var_3) {
        if(var_5.basename == var_0) {
          return 0;
        }
      }
    }

    return 1;
  }
}

oasis_check_wwshield_spawned_in_magicbox(var_0) {
  if(isDefined(var_0.type) && var_0.type == "cploot_weapon_wonder_shield") {
    level.ww_shield_already_dropped_from_box = 1;
  }
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
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(level.outofmap_volume) || !isDefined(level.outofmap_teleport_points) || level.outofmap_teleport_points.size == 0) {
    return;
  }
  for(;;) {
    if(self istouching(level.outofmap_volume) || dark_aether_outofmap_safeguard(self)) {
      var_0 = _func_0204(level.outofmap_teleport_points, self.origin);
      thread fadetowhite_for_specific_player(0.1);
      wait 0.1;
      playFX(scripts\engine\utility::getfx("outofmap_teleport"), var_0[0].origin);
      var_1 = var_0[0];

      if(isDefined(level._id_3BE9._id_0F51)) {
        var_2 = level._id_3BE9._id_0F51._id_0481;

        foreach(var_4 in var_0) {
          if(isDefined(var_4._id_039B)) {
            var_5 = strtok(var_4._id_039B, ",");

            if(scripts\cp\utility::_id_88B7(var_5, var_2)) {
              var_1 = var_4;
              break;
            }
          }
        }
      }

      thread _id_098B::_id_F02A(var_1);
      var_7 = self.health - 0.1 * self.maxhealth;

      if(var_7 > 0) {
        self dodamage(var_7, self.origin, undefined, undefined, "MOD_SUICIDE");
      }

      if(isDefined(self._id_1B3D) && self._id_1B3D > 0) {
        _id_0707::_id_D161(self, 0 * self._id_9C09);
      }

      self playsoundtoplayer("zmb_d_ae_respawn", self);
      self playsoundtoteam("zmb_d_ae_respawn_m", self.team, self, self);
      wait 0.4;
      playFXOnTag(scripts\engine\utility::getfx("outofmap_teleport_begin"), self, "j_head");
      playFXOnTag(scripts\engine\utility::getfx("outofmap_teleport_end"), self, "j_head");
      wait 0.5;
      thread handle_dark_aether_cliff_fall_vo();
    }

    waitframe();
  }
}

fadetowhite_for_specific_player(var_0) {
  level endon("game_ended");
  self notify("FadeToWhite_singleton");
  self endon("FadeToWhite_singleton");
  self setclientomnvar("ui_total_fade_color", 1);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, var_0);
  wait(var_0 + 0.3);
  level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, var_0);
  wait(var_0 + 0.3);
  self setclientomnvar("ui_total_fade_color", 0);
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
  var_0 = spawnStruct();
  var_0._id_4828 = [];
  var_0._id_332E = [];
  _id_0987::_id_D2B2(1, 1);
  waittillframeend;
  _id_06EF::_id_E16F(level._id_3BE9._id_96DE["objectives_location_fob"]._id_8300["exfil"].versions[0]);
  level thread scripts\cp\zombies\zm_rbz_exfil::hide_exfil_interact();
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

handle_dynamic_traversal() {
  var_0 = _func_00B3("dynamic_traversal", "script_noteworthy");

  if(var_0.size < 0) {
    return;
  }
  foreach(var_2 in var_0) {
    _func_0050(var_2);
    var_2 thread wait_and_create_traversal();
  }
}

wait_and_create_traversal() {
  level endon("game_ended");

  if(!isDefined(self._id_CD4B)) {
    return;
  }
  scripts\engine\utility::_id_5C24(self._id_CD4B);
  var_0 = _func_00B2(self.target, "targetname");

  if(isDefined(var_0)) {
    _func_004C("jump_link", self.origin, var_0.origin, self);
  }
}