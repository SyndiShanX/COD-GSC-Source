/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf.gsc
*************************************************/

main() {
  _id_09A4::overrideaitype("enemy_base_zombie_cp", "enemy_base_zombie_sumpf_cp");
  _id_06CB::_id_AA4E(::handle_agent_in_swamp);
  level.disable_hud_portal = 1;
  level.pap_model_animated = 1;
  level._id_AE0B = "mtl_s4_camo_pap_shinonuma_a_zm";
  level._id_AE0C = "mtl_s4_camo_pap_shinonuma_b_zm";
  level._id_AE0D = "mtl_s4_camo_pap_shinonuma_c_zm";
  level thread scripts\cp\zombies\zm_rbz_utility::rbz_initialize();
  level.random_perks = ["zm_perk_critical_damage", "zm_perk_reload_speed", "zm_perk_move_speed", "zm_perk_hp_regen_speed"];
  scripts\cp\maps\cp_sumpf\gen\cp_sumpf_art::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_fx::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_precache::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_anim::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_lighting::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_vo::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_audio::main();
  scripts\cp\maps\cp_sumpf\cp_sumpf_zone::init();
  scripts\cp\maps\cp_sumpf\cp_sumpf_trap::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_mq::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_wwq::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_ee_music::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_side_quest::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_dig_site_discovery::init();
  _id_06EE::_id_D88B("compass_map_cp_sumpf");
  level._id_9F28 = 1;
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

  level.custom_assist_event_name = "assist_";
  level.score_info_table = "cp/scoreinfo/cp_sumpf_scoreinfo_base.csv";
  level.score_splash_table = "cp/cp_sumpf_splashtable.csv";
  level.salvage_pickup_amount = 100;
  level.wall_buy_pap_table = "cp/cp_wall_buy_pap.csv";
  scripts\cp\zombies\zm_ww_dg2::init();
  scripts\cp\zombies\zm_flogger::init();
  scripts\cp\maps\cp_sumpf\cp_sumpf_zipline::init();
  scripts\cp\zombies\zm_round_logic::init();
  scripts\cp\zombies\zm_round_logic::init_special_round();
  level thread scripts\cp\zombies\zm_rbz_exfil::init();
  level thread scripts\cp\maps\cp_sumpf\cp_sumpf_shooting_gallery::init();
  level thread _id_0770::init_wall_buy_weapon_table("cp/cp_wall_buy_weapons_sumpf.csv");
  level thread _id_1073C();
  level thread start_vo_watcher();
  level thread setup_wonder_weapon_drop();
  _id_06CB::_id_0FA4("zone_changed", ::watch_enter_dig_site);
}

start_vo_watcher() {
  level thread check_players_get_close_to_traps();

  if(getdvarint("#x33ad41eaa5a9a3eec", 0)) {
    level thread watch_round_one_complete_vo();
    level thread watch_round_two_complete_vo();
    level thread check_players_get_close_to_zombie_fountain();
  }

  level thread watch_give_player_sacrificial_heart();
  level thread check_players_open_door();
}

watch_round_one_complete_vo() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");

    if(scripts\cp\zombies\zm_round_logic::get_round() == 2) {
      var_0 = ["zm_cpm4_rbm4_krft_mgba", "zm_cpm4_rbm4_dsrx_mgbb", "zm_cpm4_rbm4_vrcn_mgbc"];
      var_1 = ["zm_cpm4_rbm4_krft_mgbd", "zm_cpm4_rbm4_dsrx_mgbe", "zm_cpm4_rbm4_vrcn_mgbf"];
      var_2 = ["zm_cpm4_rbm4_krft_mgbg", "zm_cpm4_rbm4_dsrx_mgbh", "zm_cpm4_rbm4_vrcn_mgbi", "zm_cpm4_rbm4_vrcn_mgbj"];
      var_3 = ["zm_cpm4_rbm4_krft_mgbk", "zm_cpm4_rbm4_dsrx_mgbl", "zm_cpm4_rbm4_vrcn_mgbm"];
      var_4 = scripts\engine\utility::random([var_0, var_1, var_2, var_3]);
      level thread _id_0720::play_narrations(var_4, 1, 0, "force_quit_current_dialogue");
      level waittill("dialogue_finished");
      level thread _id_0720::play_event_vo_from_selected_players("ally_confirmation", level.players, 1);
      return;
    } else if(scripts\cp\zombies\zm_round_logic::get_round() > 2)
      return;
  }
}

watch_round_two_complete_vo() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");

    if(scripts\cp\zombies\zm_round_logic::get_round() == 3) {
      var_0 = ["zm_cpm4_rbm4_krft_mgca", "zm_cpm4_rbm4_vlst_mgcb", "zm_cpm4_rbm4_krft_mgcc"];
      var_1 = ["zm_cpm4_rbm4_krft_mgcd", "zm_cpm4_rbm4_vlst_mgce", "zm_cpm4_rbm4_krft_mgcf"];
      var_2 = ["zm_cpm4_rbm4_krft_mgcg", "zm_cpm4_rbm4_vlst_mgch", "zm_cpm4_rbm4_krft_mgci"];
      var_3 = ["zm_cpm4_rbm4_krft_mgcj", "zm_cpm4_rbm4_vlst_mgck", "zm_cpm4_rbm4_krft_mgcl"];
      var_4 = scripts\engine\utility::random([var_0, var_1, var_2, var_3]);
      level thread _id_0720::play_narrations(var_4, 1, 0, "force_quit_current_dialogue");
      level waittill("dialogue_finished");
      return;
    } else if(scripts\cp\zombies\zm_round_logic::get_round() > 3)
      return;
  }
}

check_players_get_close_to_zombie_fountain() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstruct("mq_step_five_empty_fountain_loc", "script_noteworthy");
  var_1 = var_0.origin;

  for(;;) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && distancesquared(var_3.origin, var_1) < 10000 && !level scripts\engine\utility::_id_5C00("traps_vo_playing")) {
        level scripts\engine\utility::_id_5C11("zombie_fountain_vo_playing");
        level scripts\engine\utility::_id_5C1B("zombie_fountain_vo_playing");
        var_4 = ["zm_cpm4_rbm4_krft_mgea", "zm_cpm4_rbm4_blkr_mgeb"];
        var_5 = ["zm_cpm4_rbm4_krft_mgec", "zm_cpm4_rbm4_blkr_mged"];
        var_6 = ["zm_cpm4_rbm4_krft_mgee", "zm_cpm4_rbm4_blkr_mgef"];
        var_7 = ["zm_cpm4_rbm4_krft_mgeg", "zm_cpm4_rbm4_blkr_mgeh"];
        var_8 = scripts\engine\utility::random([var_4, var_5, var_6, var_7]);
        level thread _id_0720::play_narrations(var_8, 1, 0);
        level waittill("dialogue_finished");
        level scripts\engine\utility::_id_5C04("zombie_fountain_vo_playing");
        return;
      }
    }

    wait 1;
  }
}

check_players_get_close_to_traps() {
  level endon("game_ended");

  while(!isDefined(level.flogger)) {
    wait 1;
  }

  var_0 = (0, 0, -150);
  var_1 = scripts\engine\utility::getstruct("electric_trap_comm", "targetname");
  var_2 = scripts\engine\utility::getstruct("electric_trap_fishing", "targetname");
  var_3 = scripts\engine\utility::getstruct("electric_trap_doctors", "targetname");
  var_4 = scripts\engine\utility::getstruct("electric_trap_storage", "targetname");
  var_5 = [level.flogger.logs.origin + var_0, var_1.origin, var_2.origin, var_3.origin, var_4.origin];

  for(;;) {
    foreach(var_7 in level.players) {
      foreach(var_9 in var_5) {
        if(isDefined(var_7) && distancesquared(var_7.origin, var_9) < 10000 && !level scripts\engine\utility::_id_5C00("zombie_fountain_vo_playing")) {
          level scripts\engine\utility::_id_5C11("traps_vo_playing");
          level scripts\engine\utility::_id_5C1B("traps_vo_playing");
          level thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgd1", "zm_cpm4_rbm4_krft_mgd2", "zm_cpm4_rbm4_krft_mgd3", "zm_cpm4_rbm4_krft_mgd4"], 1, 0);
          level waittill("dialogue_finished");
          level scripts\engine\utility::_id_5C04("traps_vo_playing");
          return;
        }
      }
    }

    wait 1;
  }
}

watch_give_player_sacrificial_heart() {
  level endon("game_ended");
  level scripts\engine\utility::_id_5C24("introscreen_over");

  foreach(var_1 in level.players) {
    if(isDefined(var_1)) {
      var_1 thread give_player_sacrificial_heart();
    }
  }
}

give_player_sacrificial_heart() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self waittill("give_player_sacrificial_heart");

  for(;;) {
    wait 0.5;

    if(isDefined(self) && isalive(self) && !istrue(level._id_493C)) {
      var_0 = _id_0766::getcurrentsuper();
      var_1 = var_0._id_E76B._id_C189;

      if(isDefined(var_1)) {
        var_2 = "";

        switch (var_1) {
          case "field_upgrade_energy_mine":
            var_2 = scripts\engine\utility::random(["zm_cpm4_rbm4_dsrx_mgk1", "zm_cpm4_rbm4_dsrx_mgk2", "zm_cpm4_rbm4_dsrx_mgk3", "zm_cpm4_rbm4_dsrx_mgk4"]);
            break;
          case "field_upgrade_ring_of_fire":
            var_2 = scripts\engine\utility::random(["zm_cpm4_rbm4_dnvk_mgj1", "zm_cpm4_rbm4_dnvk_mgj2", "zm_cpm4_rbm4_dnvk_mgj3", "zm_cpm4_rbm4_dnvk_mgj4"]);
            break;
          case "field_upgrade_aether_shroud":
            var_2 = scripts\engine\utility::random(["zm_cpm4_rbm4_blkr_mgg1", "zm_cpm4_rbm4_blkr_mgg2", "zm_cpm4_rbm4_blkr_mgg3", "zm_cpm4_rbm4_blkr_mgg4"]);
            break;
          case "field_upgrade_frost_blast":
            var_2 = scripts\engine\utility::random(["zm_cpm4_rbm4_dnrt_mgi1", "zm_cpm4_rbm4_dnrt_mgi2", "zm_cpm4_rbm4_dnrt_mgi3", "zm_cpm4_rbm4_dnrt_mgi4"]);
            break;
          case "field_upgrade_healing_aura":
            var_2 = scripts\engine\utility::random(["zm_cpm4_rbm4_vrcn_mgh1", "zm_cpm4_rbm4_vrcn_mgh2", "zm_cpm4_rbm4_vrcn_mgh3", "zm_cpm4_rbm4_vrcn_mgh4"]);
            break;
        }

        if(var_2 != "") {
          level thread _id_0720::_id_B309(self, var_2);
        }

        return;
      }
    }
  }
}

watch_enter_dig_site(var_0) {
  if(!level scripts\engine\utility::_id_5C00("dig_site_vo_played")) {
    if(var_0.zone_struct.script_zone_name == "dig_site_to_storage_outside_zone" || var_0.zone_struct.script_zone_name == "dig_site_to_comm_room_outside_zone") {
      level scripts\engine\utility::_id_5C11("dig_site_vo_played");
      level scripts\engine\utility::_id_5C1B("dig_site_vo_played");
      var_1 = ["zm_cpm4_rbm4_krft_mgfa", "zm_cpm4_rbm4_vlst_mgfb"];
      var_2 = ["zm_cpm4_rbm4_krft_mgfc", "zm_cpm4_rbm4_vlst_mgfd"];
      var_3 = ["zm_cpm4_rbm4_krft_mgfe", "zm_cpm4_rbm4_vlst_mgff"];
      var_4 = ["zm_cpm4_rbm4_krft_mgfg", "zm_cpm4_rbm4_vlst_mgfh"];
      var_5 = scripts\engine\utility::random([var_1, var_2, var_3, var_4]);
      level thread _id_0720::play_narrations(var_5, 1, 0);
      level waittill("dialogue_finished");
    }
  }
}

check_players_open_door() {
  level endon("game_ended");
  level waittill("door_opened");
  var_0 = scripts\engine\utility::random(["zm_cpm4_rbm4_vrcn_mgl0", "zm_cpm4_rbm4_vrcn_mgl1", "zm_cpm4_rbm4_vrcn_mgl2", "zm_cpm4_rbm4_vrcn_mgl3", "zm_cpm4_rbm4_vrcn_mgl4", "zm_cpm4_rbm4_vrcn_mgl5", "zm_cpm4_rbm4_vrcn_mgl6", "zm_cpm4_rbm4_vrcn_mgl7", "zm_cpm4_rbm4_vrcn_mgl8", "zm_cpm4_rbm4_vrcn_mgl9"]);
  level thread _id_0720::play_narration(var_0, 1, 0);
  level waittill("dialogue_finished");
}

play_slowed_in_water_vo() {
  if(!scripts\engine\utility::_id_546E("slowed_in_water_vo_played")) {
    if(isDefined(self) && isalive(self) && !istrue(level._id_493C)) {
      scripts\engine\utility::_id_5473("slowed_in_water_vo_played");
      scripts\engine\utility::_id_5474("slowed_in_water_vo_played");
      level thread _id_0720::_id_B309(self, ["zm_cpm4_rbm4_vrcn_mgo1", "zm_cpm4_rbm4_vrcn_mgo2", "zm_cpm4_rbm4_vrcn_mgo3", "zm_cpm4_rbm4_vrcn_mgo4"]);
    }
  }
}

handle_agent_in_swamp() {
  level endon("game_ended");
  self endon("disconnect");

  if(!isPlayer(self)) {
    if(!_id_06FE::is_zm_normal()) {
      return;
    }
    self endon("death");
  }

  self.b_move_in_swamp = 0;
  self.cache_swamp_check_position = (0, 0, 0);
  var_0 = 0;

  for(;;) {
    if(distancesquared(self.cache_swamp_check_position, self.origin) < 400 && var_0 == istrue(self.inlaststand)) {
      wait 0.5;
      continue;
    }

    self.cache_swamp_check_position = self.origin;
    var_1 = 0;
    var_2 = 1;

    if(!istrue(self.inlaststand)) {
      var_3 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 50), self.origin, 0, self);
      var_1 = var_3["surfacetype"] == "surftype_water" && var_3["fraction"] < 0.9;
      var_2 = var_3["fraction"];
    }

    var_0 = istrue(self.inlaststand);

    if(var_1 && isPlayer(self)) {
      var_4 = clamp((var_2 - 0.6) / 0.3, 0, 1);
      _id_06E5::_id_D12B("swamp_slow", "move_speed_scale", 0.7 + 0.2 * var_4);
      thread play_slowed_in_water_vo();
    }

    if(self.b_move_in_swamp != var_1) {
      if(var_1) {
        if(isPlayer(self)) {
          _id_06E5::_id_D12B("swamp_slow", "allow_super_sprint", 0);
          _id_06E5::_id_D12B("swamp_slow", "allow_prone", 0);
        } else
          scripts\cp\zombies\zombie_slow::slow("swamp_slow", 0.7, 9999);
      } else if(isPlayer(self))
        _id_06E5::_id_C5A1("swamp_slow");
      else {
        scripts\cp\zombies\zombie_slow::end_slow("swamp_slow");
      }

      self.b_move_in_swamp = var_1;
    }

    wait 0.5;
  }
}

_id_1073C() {
  wait 0.2;
  _id_800D();
}

_id_800D() {
  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    return;
  }
  _id_0987::_id_D2B2(1, 1);
  waittillframeend;
  _id_06EF::_id_E16F(level._id_3BE9._id_96DE["objectives_location_fob"]._id_8300["exfil"].versions[0]);
  _id_0987::add_location_ammo_cache_markers(level._id_3BE9._id_96DE["objectives_location_fob"]);
  level thread scripts\cp\zombies\zm_rbz_exfil::hide_exfil_interact();
}

setup_wonder_weapon_drop() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  level.weapon_drop_exclude_list = scripts\engine\utility::array_remove(level.weapon_drop_exclude_list, "s4_ar_tgun_mp");
}