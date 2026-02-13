/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_zm_poi_spawning.gsc
*****************************************************/

main() {
  _id_06CB::_id_0FA4("start_poi_spawning", ::start_poi_spawning);
  _id_06CB::_id_0FA4("cleanup_poi_encounters", ::cleanup_poi_encounters);
  _id_06CB::_id_AA4A(::set_poi_combat_on_ai_killed);
  _id_07A1::_id_CEC7(_id_073D::activate_loot_crystal);
}

start_poi_spawning(var_0) {
  level endon("game_ended");
  level.total_elites_spawned = 0;
  level.ai_spawned_since_last_elite = 0;

  if(isDefined(var_0._id_4649)) {
    wait(var_0._id_4649);
  }

  while(!isDefined(level.agentarray) || level.agentarray.size < 10) {
    waitframe();
  }

  if(!isDefined(level.poi_numbers_csv)) {
    level.poi_numbers_csv = "cp/zombies/cp_zod_hub_poi_numbers.csv";
  }

  if(!isDefined(level.hub_zombie_speed_settings)) {
    level.hub_zombie_speed_settings = _func_0393("zmspeedsettings:cp_zod_hub_speed_settings");
  }

  level.hub_round_speed_settings = get_round_number_speed_settings();
  start_spawning_at_active_pois();
  setup_ambushes();
}

start_spawning_at_active_pois() {
  if(!isDefined(level.active_poi_entities)) {
    level.active_poi_entities = [];
  }

  var_0 = get_valid_poi_structs();
  var_1 = get_valid_poi_encounters();
  var_2 = determine_number_of_active_pois();
  var_3 = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = scripts\engine\utility::random(var_0);
    var_3 = scripts\engine\utility::array_add(var_3, var_5);
    var_0 = scripts\engine\utility::array_remove(var_0, var_5);
  }

  foreach(var_7 in var_3) {
    if(randomfloat(100) < 67) {
      var_7.type = "crystal";
    } else {
      var_7.type = "chest";
    }

    var_7._id_5274 = scripts\engine\utility::random(var_1);
    var_7._id_5274 adjust_poi_values_for_num_players(level.players.size);
    var_7._id_5274.adjusted_for_num_players = 1;
    var_8 = var_7 scripts\engine\utility::_id_67AA();
    var_8.contains_player = 0;
    var_7 thread monitor_poi_encounter_activation();
    _id_073D::add_loot_cache_weapon_source(var_7);
    level thread manage_poi_encounter(var_7);
  }
}

adjust_poi_values_for_num_players(var_0) {
  var_1 = self;

  if(!isDefined(var_1.adjusted_for_num_players) || var_1.adjusted_for_num_players != 1) {
    var_2 = 1;
    var_3 = 1;
    var_4 = 1;

    if(var_0 == 2) {
      var_2 = 1.33;
      var_3 = 1.33;
      var_4 = 1.33;
    }

    if(var_0 == 3) {
      var_2 = 1.66;
      var_3 = 1.66;
      var_4 = 1.66;
    }

    if(var_0 == 4) {
      var_2 = 2;
      var_3 = 2;
      var_4 = 2;
    }

    if(!isDefined(var_1.startaicount)) {
      var_1.startaicount = 1;
    }

    var_1.startaicount = int(var_1.startaicount * var_2);

    if(var_1.startaicount > 5) {
      var_1.startaicount = 5;
    }

    if(!isDefined(var_1.maxactiveai)) {
      var_1.maxactiveai = 1;
    }

    var_1.maxactiveai = int(var_1.maxactiveai * var_3);

    if(!isDefined(var_1.totalencounterai)) {
      var_1.totalencounterai = 1;
    }

    var_1.totalencounterai = int(var_1.totalencounterai * var_4);

    foreach(var_6 in var_1._id_13F7) {
      if(!isDefined(var_6.aitypemax)) {
        var_6.aitypemax = 1;
      }

      var_6.aitypemax = int(var_6.aitypemax * var_4);

      if(!isDefined(var_6.aitypefrequency)) {
        var_6.aitypefrequency = 1;
      }
    }
  }

  if(var_0 == 0) {
    level.xp_per_round_active_player_count = 1;
  } else {
    level.xp_per_round_active_player_count = var_0;
  }
}

get_valid_poi_structs() {
  var_0 = scripts\engine\utility::getstructarray("poi_location", "script_noteworthy");

  if(isDefined(level.a_active_zones)) {
    foreach(var_2 in var_0) {
      var_2.is_combat_active = undefined;

      if(istrue(var_2.b_disabled) || !scripts\engine\utility::array_contains(level.a_active_zones, var_2._id_CE18)) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }
  }

  return var_0;
}

get_valid_poi_encounters() {
  var_0 = [];

  if(!isDefined(level.a_poi_encounters) || level.a_poi_encounters.size == 0) {
    var_0[0] = _func_0393("poiencounters:default_poi_encounter");
  } else {
    if(!isDefined(level._id_11049)) {
      level._id_11049 = 1;
    }

    var_0 = level.a_poi_encounters;

    foreach(var_2 in level.a_poi_encounters) {
      if(isDefined(var_2.minround) && var_2.minround > level._id_11049) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }

      if((!isDefined(var_2.nomaxround) || var_2.nomaxround == 0) && var_2.maxround < level._id_11049) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }
  }

  return var_0;
}

setup_ambushes() {
  var_0 = determine_number_of_ambushes();
  var_1 = get_valid_ambush_structs();
  var_2 = get_valid_poi_encounters();
  var_3 = [];

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = scripts\engine\utility::random(var_1);
    var_3 = scripts\engine\utility::array_add(var_3, var_5);
    var_1 = scripts\engine\utility::array_remove(var_1, var_5);
  }

  foreach(var_7 in var_3) {
    var_7._id_5274 = scripts\engine\utility::random(var_2);
    var_7._id_5274 adjust_poi_values_for_num_players(level.players.size);
    var_7.type = "ambush";
    var_8 = var_7 scripts\engine\utility::_id_67AA();
    var_8.contains_player = 0;
    var_7 thread monitor_poi_encounter_activation();
    level thread manage_poi_encounter(var_7);
  }
}

determine_number_of_active_pois() {
  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  var_0 = level._id_11049;
  var_1 = tablelookupgetnumrows(level.poi_numbers_csv);

  if(var_0 > var_1) {
    var_0 = var_1;
  }

  var_2 = int(tablelookupbyrow(level.poi_numbers_csv, var_0 - 1, 1));
  return var_2;
}

determine_number_of_ambushes() {
  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  var_0 = level._id_11049;
  var_1 = tablelookupgetnumrows(level.poi_numbers_csv);

  if(var_0 > var_1) {
    var_0 = var_1;
  }

  var_2 = int(tablelookupbyrow(level.poi_numbers_csv, var_0 - 1, 2));
  return var_2;
}

get_valid_ambush_structs() {
  var_0 = scripts\engine\utility::getstructarray("ambush_location", "script_noteworthy");

  if(isDefined(level.a_active_zones)) {
    foreach(var_2 in var_0) {
      var_2.is_combat_active = undefined;

      if(istrue(var_2.b_disabled) || !scripts\engine\utility::array_contains(level.a_active_zones, var_2._id_CE18)) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }
  }

  return var_0;
}

monitor_poi_encounter_activation() {
  level endon("cleanup_poi_spawns ");
  level endon("game_ended");
  self endon("poi_combat_started");
  var_0 = scripts\engine\utility::_id_67AA();

  while(!istrue(self.is_combat_active)) {
    if(getdvarint("#x3d42ccd2f199bfbb6", 0) == 0 && (self.type == "crystal" || self.type == "chest")) {
      var_1 = _func_0070("axis");

      foreach(var_3 in var_1) {
        if(istrue(var_3.poi_spawned)) {
          if(isDefined(var_3._id_106A1) && var_3._id_106A1 == var_0 && istrue(var_3.isaware)) {
            thread play_ambush_vo();
            self.is_combat_active = 1;
            self notify("poi_combat_started");
          }
        }
      }
    } else if(!level scripts\engine\utility::_id_5C00("mq_speaking_stone_playing")) {
      foreach(var_6 in level.players) {
        if(var_6 istouching(var_0)) {
          thread play_ambush_vo();
          thread play_ambush_audio_stinger();
          wait 0.25;
          self.is_combat_active = 1;
          self notify("poi_combat_started");
        }
      }
    }

    wait 0.25;
  }
}

play_ambush_vo() {
  var_0 = !isDefined(level.ambush_vo_last_played_time) || gettime() - level.ambush_vo_last_played_time > 30.0;
  var_1 = randomfloat(1.0) < 0.25;

  if(var_0 && var_1) {
    wait 1.0;
    level.ambush_vo_last_played_time = gettime();
    var_2 = undefined;

    if(level.mapname == "cp_zm_skorpion") {
      var_2 = ["zm_zohs_hbsk_vlst_hsia", "zm_zohs_hbsk_vlst_hsib", "zm_zohs_hbsk_vlst_hsic", "zm_zohs_hbsk_vlst_hsid", "zm_zohs_hbsk_vlst_hsie", "zm_zohs_hbsk_vlst_hsif", "zm_zohs_hbsk_vlst_hsig", "zm_zohs_hbsk_vlst_hsih", "zm_zohs_hbsk_vlst_hsii", "zm_zohs_hbsk_vlst_hsij", "zm_zohs_hbsk_krtx_hsik", "zm_zohs_hbsk_krtx_hsil", "zm_zohs_hbsk_krtx_hsim", "zm_zohs_hbsk_krtx_hsin", "zm_zohs_hbsk_krtx_hsio", "zm_zohs_hbsk_krtx_hsip", "zm_zohs_hbsk_krtx_hsiq", "zm_zohs_hbsk_krtx_hsir", "zm_zohs_hbsk_krtx_hsis", "zm_zohs_hbsk_krtx_hsit"];
    } else {
      var_2 = ["zm_cmcp_obhb_vlst_hamb", "zm_cmcp_obhb_krtx_hamb"];
    }

    thread _id_0720::play_narration(var_2, 0);
    level waittill("dialogue_finished");
  }
}

play_ambush_audio_stinger() {
  playsoundatpos(self.origin, "zmb_ui_ambush_stinger");
}

set_poi_combat_on_ai_killed(var_0) {
  if(istrue(self.poi_spawned) && isDefined(self._id_106A1)) {
    var_1 = self._id_106A1;
    var_2 = scripts\engine\utility::getstruct(var_1._id_0481, "target");

    if(isDefined(var_2) && !istrue(var_2.is_combat_active)) {
      var_2.is_combat_active = 1;
      var_2 notify("poi_combat_started");
    }
  }
}

manage_poi_encounter(var_0) {
  level endon("cleanup_poi_spawns ");
  level endon("game_ended");
  var_0 endon("encounter_done_spawning");
  var_0.total_ai_spawned = 0;
  var_1 = var_0 scripts\engine\utility::_id_67AA();

  foreach(var_3 in var_0._id_5274._id_13F7) {
    var_3.total_spawned = 0;
    var_3.zombies_spawned_before_this_one = 0;
  }

  if(var_0.type == "crystal") {
    var_0 spawn_crystal_encounter();
    var_0 thread spawn_starting_idle_ai();
  }

  if(var_0.type == "chest") {
    var_0 spawn_chest_encounter();
    var_0 thread spawn_starting_idle_ai();
  }

  var_5 = var_1 scripts\engine\utility::_id_67A9();

  while(!istrue(var_0.is_combat_active)) {
    wait 0.25;
  }

  for(;;) {
    if(var_0.total_ai_spawned < var_0._id_5274.totalencounterai) {
      var_6 = 0;
      var_7 = _func_0070("axis");

      foreach(var_9 in var_7) {
        if(isDefined(var_9._id_106A1) && var_9._id_106A1 == var_0 scripts\engine\utility::_id_67AA()) {
          var_6 = var_6 + 1;
        }
      }

      if(var_6 < var_0._id_5274.maxactiveai) {
        var_11 = randomfloatrange(0.05, 0.1);

        if(!isDefined(level._id_11049)) {
          level._id_11049 = 1;
        }

        if(level._id_11049 <= 6) {
          var_11 = var_11 * 1;
        } else if(level._id_11049 <= 9) {
          var_11 = var_11 * 1;
        }

        wait(var_11);

        foreach(var_3 in var_0._id_5274._id_13F7) {
          if(isDefined(var_3.defaultaitype) && var_3.defaultaitype == 1) {
            var_0.defaultaitype = var_3._id_13F1;
          }
        }

        var_14 = var_0.defaultaitype;

        foreach(var_3 in var_0._id_5274._id_13F7) {
          if(var_3._id_13F1 != var_0.defaultaitype && var_3.total_spawned < var_3.aitypemax && var_3.zombies_spawned_before_this_one >= var_3.aitypefrequency) {
            var_14 = var_3._id_13F1;
          }
        }

        var_17 = scripts\engine\utility::random(var_5);
        var_5 = scripts\engine\utility::array_remove(var_5, var_17);

        if(var_5.size <= 0) {
          var_5 = var_1 scripts\engine\utility::_id_67A9();
        }

        var_18 = spawn_ai_from_poi_struct(var_14, var_17, 0, var_0);
      }
    } else
      var_0 notify("encounter_done_spawning");

    var_19 = randomfloatrange(0.25, 0.5);
    wait(var_19);
  }
}

spawn_crystal_encounter() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = self.origin - (0, 0, 32);
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
  var_3 = scripts\engine\trace::ray_trace(var_0, var_1, undefined, var_2);

  if(var_3["fraction"] < 1.0) {
    var_4 = var_3["position"];
  } else {
    var_4 = var_1;
  }

  var_5 = _func_03C5("s4_zm_loot_crystal", var_4 - (0, 0, 2), self.angles);
  var_5 setscriptablepartstate("fx", "idle");
  var_5.poi_spawned = 1;
  level.active_poi_entities[level.active_poi_entities.size] = var_5;
  var_5.objectiveiconlocation = spawn("script_model", var_5.origin);
  var_5.objectiveiconparams = spawnStruct();
  var_5.objectiveiconparams._id_E747 = "active";
  var_5.objectiveiconparams._id_96CF = var_5.objectiveiconlocation;
  var_5.objectiveiconparams._id_7C3B = "v_ui_icons_zombies_minimap_crystals";
  var_5.objectiveiconparams.minimapiconsize = "icon_regular";
  var_5.objectiveiconparams.hideonminimapwhenclipped = 1;
  var_5.objectiveiconparams.setbackground = 1;
  var_5.markerlabel = "crystal_poi";
  var_5.instanceindex = _id_0987::add_instanced_objective_marker(var_5.markerlabel, var_5.objectiveiconparams);
}

spawn_chest_encounter() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = self.origin - (0, 0, 32);
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
  var_3 = scripts\engine\trace::ray_trace(var_0, var_1, undefined, var_2);

  if(var_3["fraction"] < 1.0) {
    var_4 = var_3["position"];
  } else {
    var_4 = var_1;
  }

  var_5 = _func_03C5("s4_zm_loot_chest", var_4 - (0, 0, 2), self.angles);
  var_5 setscriptablepartstate("zm_loot_chest", "closed");
  var_5 setscriptablepartstate("fx", "closed");
  var_5.poi_spawned = 1;
  level.active_poi_entities[level.active_poi_entities.size] = var_5;
  var_5.objectiveiconlocation = spawn("script_model", var_5.origin);
  var_5.objectiveiconparams = spawnStruct();
  var_5.objectiveiconparams._id_E747 = "active";
  var_5.objectiveiconparams._id_96CF = var_5.objectiveiconlocation;
  var_5.objectiveiconparams._id_7C3B = "v_ui_icons_zombies_minimap_chest";
  var_5.objectiveiconparams.minimapiconsize = "icon_regular";
  var_5.objectiveiconparams.hideonminimapwhenclipped = 1;
  var_5.objectiveiconparams.setbackground = 1;
  var_5.markerlabel = "chest_poi";
  var_5.instanceindex = _id_0987::add_instanced_objective_marker(var_5.markerlabel, var_5.objectiveiconparams);
}

spawn_starting_idle_ai() {
  level endon("cleanup_poi_spawns ");
  level endon("game_ended");

  if(getdvarint("#x3d42ccd2f199bfbb6", 0) == 0) {
    wait 0.5;
    var_0 = self;
    var_1 = var_0.target;
    var_2 = scripts\engine\utility::_id_67A9(var_1);
    var_3 = var_0._id_5274.startaicount;

    if(!isDefined(var_3) || var_3 < 1) {
      var_3 = 1;
    }

    var_4 = [];

    foreach(var_6 in var_0._id_5274._id_13F7) {
      var_6.total_spawned = 0;
      var_6.zombies_spawned_before_this_one = 0;

      if(isDefined(var_6.aitypeinitialspawning) && var_6.aitypeinitialspawning == 1) {
        var_4[var_4.size] = var_6;
      }

      if(isDefined(var_6.defaultaitype) && var_6.defaultaitype == 1) {
        var_0.defaultaitype = var_6._id_13F1;
      }
    }

    if(var_4.size <= 0) {
      return;
    }
    for(var_8 = 0; var_8 < var_3; var_8++) {
      var_9 = var_0.defaultaitype;

      foreach(var_6 in var_0._id_5274._id_13F7) {
        if(var_6._id_13F1 != var_0.defaultaitype && var_6.total_spawned < var_6.aitypemax && var_6.zombies_spawned_before_this_one >= var_6.aitypefrequency) {
          var_9 = var_6._id_13F1;
        }
      }

      var_12 = scripts\engine\utility::random(var_2);
      var_2 = scripts\engine\utility::array_remove(var_2, var_12);

      if(var_2.size <= 0) {
        var_2 = scripts\engine\utility::_id_67A9(var_1);
      }

      var_13 = spawn_ai_from_poi_struct(var_9, var_12, 1, var_0);
    }

    return;
  }
}

spawn_ai_from_poi_struct(var_0, var_1, var_2, var_3) {
  level endon("cleanup_poi_spawns ");
  level endon("game_ended");

  for(var_4 = _func_0070("axis"); var_4.size >= 32 || !level scripts\engine\utility::_id_5C00("spawn_zombies"); var_4 = _func_0070("axis")) {
    waitframe();
  }

  var_5 = check_to_spawn_elite();
  level.ai_spawned_since_last_elite = level.ai_spawned_since_last_elite + 1;

  if(isDefined(var_5) && var_5 == 1) {
    var_0 = choose_elite_to_spawn();
    level.total_elites_spawned = level.total_elites_spawned + 1;
    level.ai_spawned_since_last_elite = 0;
  }

  var_6 = var_3 scripts\engine\utility::_id_67AA();
  var_7 = _id_09A4::_id_110AD(var_0, var_1.origin, var_1.angles, var_1, var_6, undefined, _id_09A4::get_ltm_spawner_model_from_type(var_0));

  if(!isDefined(var_7)) {
    return;
  }
  if(var_2 == 1) {
    var_7 scripts\aitypes\zombie_common\awareness::set_unaware();
  } else {
    var_7 scripts\aitypes\zombie_common\awareness::set_aware();

    if(isDefined(var_7.origin) && isDefined(level.players)) {
      var_8 = scripts\engine\utility::_id_6969(var_7.origin, level.players);

      if(isDefined(var_8)) {
        var_7._id_012F = var_8;
      }
    }
  }

  var_7 thread set_zombie_movement_speed();
  var_3.total_ai_spawned = var_3.total_ai_spawned + 1;

  foreach(var_10 in var_3._id_5274._id_13F7) {
    if(var_10._id_13F1 == var_0) {
      var_10.total_spawned = var_10.total_spawned + 1;
      var_10.zombies_spawned_before_this_one = 0;
      continue;
    }

    var_10.zombies_spawned_before_this_one = var_10.zombies_spawned_before_this_one + 1;
  }

  var_7.poi_spawned = 1;
  return var_7;
}

set_zombie_movement_speed() {
  var_0 = self;

  if(var_0._id_1210 == "actor_enemy_base_zombie_cp") {
    var_1 = level.players.size;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = level.hub_round_speed_settings;

    if(isDefined(var_5)) {
      if(var_1 == 1) {
        if(isDefined(var_5.oneprunchance)) {
          var_4 = var_5.oneprunchance;
        }

        if(isDefined(var_5.onepsprintchance)) {
          var_3 = var_5.onepsprintchance;
        }

        if(isDefined(var_5.onepsupersprintchance)) {
          var_2 = var_5.onepsupersprintchance;
        }
      } else if(var_1 == 2) {
        if(isDefined(var_5.twoprunchance)) {
          var_4 = var_5.twoprunchance;
        }

        if(isDefined(var_5.twopsprintchance)) {
          var_3 = var_5.twopsprintchance;
        }

        if(isDefined(var_5.twopsupersprintchance)) {
          var_2 = var_5.twopsupersprintchance;
        }
      } else if(var_1 == 3) {
        if(isDefined(var_5.threeprunchance)) {
          var_4 = var_5.threeprunchance;
        }

        if(isDefined(var_5.threepsprintchance)) {
          var_3 = var_5.threepsprintchance;
        }

        if(isDefined(var_5.threepsupersprintchance)) {
          var_2 = var_5.threepsupersprintchance;
        }
      } else {
        if(isDefined(var_5.fourprunchance)) {
          var_4 = var_5.fourprunchance;
        }

        if(isDefined(var_5.fourpsprintchance)) {
          var_3 = var_5.fourpsprintchance;
        }

        if(isDefined(var_5.fourpsupersprintchance)) {
          var_2 = var_5.fourpsupersprintchance;
        }
      }
    }

    var_6 = randomfloat(1);

    if(var_2 > 0 && var_6 <= var_2) {
      var_0[[var_0._id_D603]]("super_sprint");
    } else if(var_3 > 0 && var_6 <= var_3) {
      var_0[[var_0._id_D603]]("sprint");
    } else if(var_4 > 0 && var_6 <= var_4) {
      var_0[[var_0._id_D603]]("run");
    } else {
      var_0[[var_0._id_D603]]("walk");
    }
  }
}

get_round_number_speed_settings() {
  if(!isDefined(level._id_11049)) {
    level._id_11049 = 1;
  }

  var_0 = level._id_11049;

  if(var_0 > 50) {
    var_0 = 50;
  }

  var_1 = level.hub_zombie_speed_settings.roundspeedsetting;

  foreach(var_3 in var_1) {
    if(var_0 >= var_3.minround && var_0 <= var_3.maxround) {
      return var_3;
    }
  }

  return undefined;
}

cleanup_poi_encounters() {
  level notify("cleanup_poi_spawns ");
  wait 0.1;
  var_0 = _func_0070("axis");

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  waitframe();

  if(isDefined(level.active_poi_entities) && level.active_poi_entities.size > 0) {
    foreach(var_5 in level.active_poi_entities) {
      level.active_poi_entities = scripts\engine\utility::array_remove(level.active_poi_entities, var_5);
      _id_073D::remove_loot_cache_weapon_source(var_5);

      if(isent(var_5)) {
        var_5 delete();
        continue;
      }

      if(isDefined(var_5.markerlabel) && isDefined(var_5.instanceindex)) {
        _id_0987::remove_instanced_objective_marker(var_5.markerlabel, var_5.instanceindex);
        waitframe();
      }

      if(isDefined(var_5.objectiveiconlocation)) {
        var_5.objectiveiconlocation delete();
      }

      var_5 notify("death");
      var_5 _meth_86BE();
    }
  }

  level.active_poi_entities = [];
}

check_to_spawn_elite() {
  var_0 = 0;
  var_1 = scripts\cp\utility::_id_6C5C();
  var_2 = var_1.size;
  var_3 = 1;

  if(var_2 >= 3) {
    var_3 = 1;
  }

  if(!isDefined(level.ai_spawned_since_last_elite)) {
    level.ai_spawned_since_last_elite = 0;
  }

  if(!isDefined(level.total_elites_spawned)) {
    level.total_elites_spawned = 0;
  }

  if(!isDefined(level.s_elite_spawning_rules)) {
    return 0;
  }

  if(!isDefined(level._id_11049) || level._id_11049 < level.s_elite_spawning_rules.first_elite_round) {
    return 0;
  }

  if(level.ai_spawned_since_last_elite < level.s_elite_spawning_rules.min_spawns_before_elite) {
    return 0;
  }

  if(level.total_elites_spawned >= level.s_elite_spawning_rules.max_total_elites_to_spawn * var_3) {
    return 0;
  }

  var_4 = _func_0070();

  foreach(var_6 in var_4) {
    if(var_6 _id_06FE::is_zm_elite()) {
      var_0 = var_0 + 1;
    }
  }

  var_8 = 1;

  if(var_2 >= 3) {
    var_8 = 2;
  }

  if(var_0 >= var_8) {
    return 0;
  }

  return 1;
}

choose_elite_to_spawn() {
  return "enemy_zombie_trickster_cp";
}