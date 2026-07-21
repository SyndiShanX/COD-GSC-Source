/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines_vo.gsc
***********************************************/

vo_intro_marine_oorah_dialogue() {
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  wait 2;
  level.griggs scripts\engine\utility::waittill_any_timeout(5.0, "sounddone", "face_sounddone");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_igc_intro_170");
  wait 0.1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_igc_intro_180");
  thread vo_convoy_griggs_move_out_dialogue();
}

vo_intro_nag_manager_1() {
  scripts\engine\utility::flag_wait("intro_cinematic_complete");
  wait 4;

  while(!scripts\engine\utility::flag("door_kick_vignette_flag")) {
    wait(randomfloatrange(8.0, 12.0));

    if(!scripts\engine\utility::flag("door_kick_vignette_flag")) {
      vo_intro_griggs_nag_dialogue();
      scripts\sp\maps\marines\marines_utility.gsc::marines_intro_glanceback(0.3);
    }
  }

  thread vo_intro_nag_manager_2();
}

vo_intro_nag_manager_2() {
  while(!scripts\engine\utility::flag("marines_advance_group_a")) {
    wait(randomfloatrange(8.0, 12.0));

    if(!scripts\engine\utility::flag("marines_advance_group_a")) {
      vo_intro_griggs_nag_dialogue();
      scripts\sp\maps\marines\marines_utility.gsc::marines_intro_glanceback(0.3);
    }
  }

  thread vo_intro_nag_manager_3();
}

vo_intro_nag_manager_3() {
  while(!scripts\engine\utility::flag("marines_advance_group_b")) {
    wait(randomfloatrange(8.0, 12.0));

    if(!scripts\engine\utility::flag("marines_advance_group_b")) {
      vo_intro_griggs_nag_dialogue();
      scripts\sp\maps\marines\marines_utility.gsc::marines_intro_glanceback(0.3);
    }
  }
}

vo_intro_griggs_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_intro_convoy_60", "dx_vom_grg_intro_convoy_61", level.griggs, "dx_vom_grg_intro_convoy_70", "dx_vom_grg_intro_convoy_71", level.griggs, "dx_vom_grg_intro_convoy_80", "dx_vom_grg_intro_convoy_81"];
  vo_knockout_manager("intro_griggs_nag", var_0, level.player);
}

vo_convoy_griggs_move_out_dialogue() {
  level.vo_convoy_griggs_move_out_dialogue_done = 0;
  wait 1;
  level.griggs scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_igc_intro_200", undefined, undefined, undefined, undefined, level.player);

  if(!scripts\engine\utility::flag("vo_flag_convoy_rush")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_street_10", undefined, undefined, undefined, undefined, level.player);
    level.vo_convoy_griggs_move_out_dialogue_done = 1;
  }
}

vo_convoy_viper_arriving_dialogue() {
  level.vo_convoy_viper_arriving_dialogue_done = 0;
  scripts\engine\utility::flag_wait("marines_advance_group_a");

  if(isDefined(level.vo_convoy_griggs_move_out_dialogue_done)) {
    while(level.vo_convoy_griggs_move_out_dialogue_done == 0 && !scripts\engine\utility::flag("vo_flag_convoy_rush"))
      waitframe();
  } else
    scripts\engine\utility::flag_wait("vo_flag_convoy_rush");

  if(!scripts\engine\utility::flag("vo_flag_convoy_rush")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_convoy_apc("dx_vom_usd1_intro_street_20", undefined, undefined, undefined, 1);
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_street_30");
  }

  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_convoy_apc("dx_vom_usd1_intro_street_40", undefined, undefined, undefined, 1);
  level.griggs scripts\engine\sp\utility::smart_dialogue("dx_vom_grg_intro_street_50");

  if(!scripts\engine\utility::flag("vo_flag_tripwire_approach")) {
    if(!scripts\engine\utility::flag("vo_flag_tripwire_approach")) {
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_convoy_apc("dx_vom_usd1_intro_street_60", undefined, undefined, undefined, 1);
      level.vo_convoy_viper_arriving_dialogue_done = 1;
    } else
      level.vo_convoy_viper_arriving_dialogue_done = 1;
  } else
    level.vo_convoy_viper_arriving_dialogue_done = 1;
}

vo_convoy_sledgehammer_dialogue() {
  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1]))
    level.introdoorbreachmarines[1] scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_intro_clearance_10");

  if(isDefined(level.introdoorbreachmarines[2]) && isalive(level.introdoorbreachmarines[2]))
    level.introdoorbreachmarines[2] scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_intro_clearance_20");

  if(isDefined(level.introdoorbreachmarines[3]) && isalive(level.introdoorbreachmarines[3]))
    level.introdoorbreachmarines[3] scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us4_intro_clearance_270");

  scripts\engine\utility::flag_wait("play_sledge_dialogue");

  if(isDefined(level.introdoorbreachmarines[1]) && isalive(level.introdoorbreachmarines[1]))
    level.introdoorbreachmarines[1] scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us4_intro_clearance_270");

  if(isDefined(level.introdoorbreachmarines[2]) && isalive(level.introdoorbreachmarines[2]))
    level.introdoorbreachmarines[2] scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_intro_clearance_60");
}

vo_convoy_a10_flyby_react_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_intro_airstrike_10");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_intro_airstrike_20");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_intro_airstrike_30");
}

vo_convoy_alex_tripwire_callout_dialogue() {
  level endon("convoy_tripwire_discovered");
  scripts\engine\utility::flag_wait("tripwire_hint_flag");

  if(!scripts\engine\utility::flag("tripwire_cleared_flag")) {
    scripts\engine\utility::flag_set("flag_vo_alex_discovered_tripwires");
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_groundfloor_combat_60");
    thread convoy_tripwire_nag_handler();
  }
}

vo_convoy_griggs_tripwire_callout_dialogue() {
  while(level.vo_convoy_viper_arriving_dialogue_done == 0)
    waitframe();

  if(!scripts\engine\utility::flag("tripwire_hint_flag") && !scripts\engine\utility::flag("tripwire_cleared_flag") && !scripts\engine\utility::flag("flag_vo_alex_discovered_tripwires")) {
    level notify("convoy_tripwire_discovered");
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_intro_tripwires_10");
  }

  if(!scripts\engine\utility::flag("tripwire_cleared_flag")) {
    if(scripts\engine\utility::flag("flag_vo_alex_discovered_tripwires"))
      wait 0.5;

    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_tripwires_20", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_intro_tripwires_21");
    thread convoy_tripwire_nag_handler();
  }

  scripts\engine\utility::flag_wait("tripwire_hint_flag");

  if(!scripts\engine\utility::flag("tripwire_cleared_flag"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_intro_tripwires_80");
}

convoy_tripwire_nag_handler() {
  wait 7;

  while(!scripts\engine\utility::flag("play_IED_explosion")) {
    if(level.tripwire_grenade_defused == 0 && !scripts\engine\utility::flag("tripwire_cleared_flag")) {
      thread vo_convoy_tripwire_nag_dialogue();
      wait(randomfloatrange(7, 10));
    }

    waitframe();
  }
}

vo_convoy_tripwire_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_intro_tripwires_30", "dx_vom_grg_intro_tripwires_31", level.griggs, "dx_vom_grg_intro_tripwires_40", "dx_vom_grg_intro_tripwires_41", level.griggs, "dx_vom_grg_intro_tripwires_50", "dx_vom_grg_intro_tripwires_51", scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_vom_us1_intro_tripwires_60", "dx_vom_us1_intro_tripwires_61", scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_vom_us1_intro_tripwires_70", "dx_vom_us1_intro_tripwires_71"];
  vo_knockout_manager("convoy_tripwire_nag", var_0, level.player);
}

vo_convoy_tutorial_tripwire_disabled_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_intro_tripwires_90");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_tripwires_110");
}

vo_convoy_griggs_convoy_approach_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_street_11");
  wait 0.5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();

  if(isalive(level.player))
    var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_convoy_ambush_attack_40");

  wait 0.1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();

  if(isalive(level.player))
    var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_convoy_ambush_attack_50");

  wait 0.25;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();

  if(isalive(level.player))
    var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_convoy_ambush_attack_60");

  wait 0.1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();

  if(isalive(level.player))
    var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us4_convoy_ambush_attack_70");
}

vo_convoy_marine_convoy_greeter_dialogue() {
  var_0 = scripts\engine\sp\utility::get_living_ai("convoy_greeter", "targetname");

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_convoy_ambush_attack_10");
}

vo_convoy_griggs_ahead_nag_dialogue() {
  if(scripts\engine\utility::cointoss())
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_street_80", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_intro_street_81");
  else
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_intro_street_100", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_intro_street_101");
}

vo_murderhole_griggs_ied_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_convoy_ambush_attack_90");
  scripts\engine\utility::flag_wait("wounded_kill");
  wait 1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_convoy_ambush_attack_100", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_us1_convoy_ambush_attack_101");
  var_1 = [];
  var_2 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("r");

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_6 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("c");

  foreach(var_4 in var_6) {
    if(isDefined(var_4))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_9 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("p");

  foreach(var_4 in var_9) {
    if(isDefined(var_4))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_12 = scripts\sp\maps\marines\marines_utility.gsc::get_array_of_living_allies_by_color("b");

  foreach(var_4 in var_12) {
    if(isDefined(var_4))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine(var_1);
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_murderhole_smoke_10");

  if(!scripts\engine\utility::flag("obj_update_to_gate"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_20");
}

vo_murderhole_throw_smoke_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_murderhole_smoke_30", "dx_vom_grg_murderhole_smoke_31", level.griggs, "dx_vom_grg_murderhole_smoke_40", "dx_vom_grg_murderhole_smoke_41"];
  vo_knockout_manager("murderhole_throw_smoke_nag", var_0, level.player);
}

vo_murderhole_mg_dontshoot_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_murderhole_smoke_80", "dx_vom_grg_murderhole_smoke_81", level.griggs, "dx_vom_grg_murderhole_smoke_90", "dx_vom_grg_murderhole_smoke_91", level.griggs, "dx_vom_grg_murderhole_smoke_100", "dx_vom_grg_murderhole_smoke_101"];
  vo_knockout_manager("murderhole_mg_dontshoot_nag", var_0, level.player);
}

vo_murderhole_marine_throws_smokes_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_smoke_110");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_120", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_121");
}

vo_murderhole_alex_throws_smokes_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_smoke_130");
}

vo_murderhole_griggs_smoke_advance_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_140");
}

vo_murderhole_griggs_alley_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_corridor_110");
}

vo_alley_griggs_mg_warning() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_112", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_mg_hall_assault_113");
}

vo_alley_marine_pinned_down_dialogue() {
  wait 3;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_alley_combat_10");
  wait 2;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_alley_combat_40");
  wait 3;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_alley_combat_20");
}

vo_alley_mg_initial_callout_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_alley_approach_30", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_51");
}

vo_alley_marine_technical_arrive_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_street_approach_170");
}

vo_alley_scripted_push_up_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_50", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_51");
}

vo_alley_griggs_final_smoke_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_smoke_110");
  wait 0.5;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_120", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_121");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_140");
}

vo_marines_leaving_area_nag() {
  var_0 = [level.griggs, "dx_vom_grg_murderhole_smoke_150", "dx_vom_grg_murderhole_smoke_151", level.griggs, "dx_vom_grg_murderhole_smoke_160", "dx_vom_grg_murderhole_smoke_161", level.griggs, "dx_vom_grg_murderhole_smoke_170", "dx_vom_grg_murderhole_smoke_171"];
  vo_knockout_manager("marines_leaving_area_nag", var_0);
}

vo_alley_push_up_nag_dialogue() {
  var_0 = ["dx_vom_grg_retreat_hospital_60", "dx_vom_grg_murderhole_smoke_160"];
  var_1 = ["dx_vom_grg_retreat_hospital_61", "dx_vom_grg_murderhole_smoke_161"];

  if(level.griggs_can_smoke_nag == 1) {
    level.griggs_can_smoke_nag = 0;
    var_2 = randomint(var_0.size);
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs(var_0[var_2], undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1[var_2]);
    wait 5;
    level.griggs_can_smoke_nag = 1;
  }
}

vo_alley_throw_smoke_nag_dialogue() {
  var_0 = ["dx_vom_grg_murderhole_smoke_30", "dx_vom_grg_murderhole_smoke_40", "dx_vom_grg_murderhole_smoke_50"];
  var_1 = ["dx_vom_grg_murderhole_smoke_31", "dx_vom_grg_murderhole_smoke_41", "dx_vom_grg_murderhole_smoke_51"];

  if(level.griggs_can_smoke_nag == 1) {
    level.griggs_can_smoke_nag = 0;
    var_2 = randomint(var_0.size);
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs(var_0[var_2], undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_1[var_2]);
    wait 5;
    level.griggs_can_smoke_nag = 1;
  }
}

vo_mhbreach_griggs_breach_dialogue() {
  var_0 = getEnt("door_breach_check_volume", "targetname");

  if(!scripts\engine\utility::flag("ready_to_breach_MH")) {
    if(scripts\engine\utility::cointoss())
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_50", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_51");
    else
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_60", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_61");

    wait 2;

    if(!scripts\engine\utility::flag("kitchen_trigger"))
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_alley_approach_120");

    wait 1;

    while(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
      if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
        if(level.player istouching(var_0)) {
          var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
          var_1 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_breach_door_30");
          wait 1;
          thread vo_mhbreach_marine_ready();
          wait 15;
          continue;
        }

        if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
          scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_50", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_51");
          wait 10;

          if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
            scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_60", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_61");
            wait 10;
          }
        }
      }
    }
  }

  while(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
    if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
      if(level.player istouching(var_0)) {
        var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
        var_1 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_breach_door_30");
        wait 1;
        thread vo_mhbreach_marine_ready();
        wait 15;
        continue;
      }

      if(!scripts\engine\utility::flag("murderhole_breach_save_point")) {
        scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_50", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_51");
        wait 10;

        if(!scripts\engine\utility::flag("murderhole_breach_save_point"))
          scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_door_60", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_breach_door_61");

        wait 10;
      }
    }
  }

  wait 10;
}

vo_mhbreach_marine_ready() {
  var_0 = [scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_vom_us2_murderhole_breach_door_20", undefined, scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_vom_us2_murderhole_breach_door_40", undefined];
  vo_knockout_manager("mhbreach_marine_ready", var_0, level.player);
}

vo_mhbreach_alex_kitchen_clear_dialogue() {
  wait 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_breach_firstfloor_10");
}

vo_mhbreach_alex_stairs_climbing_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_breach_firstfloor_20");
  wait 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_firstfloor_30");
  wait 1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_murderhole_breach_firstfloor_40");
  wait 0.5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_breach_firstfloor_50");
}

vo_mhbreach_alex_tripwire_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_breach_tripwires_30");
}

vo_mhbreach_marine_defuse_nag_1_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_breach_tripwires_50");
}

vo_mhbreach_marine_defuse_nag_2_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_murderhole_breach_tripwires_60");
}

vo_mhbreach_alex_civ_down_dialogue() {
  wait 1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_murderhole_breach_civs_20");
  wait 2;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_murderhole_breach_civs_30");
}

vo_mhbreach_alex_bedroom_clear_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_retreat_rally_10");
}

vo_mhbreach_marine_bedroom_clear_dialogue() {
  var_0 = ["dx_vom_us2_intro_clearance_50", "dx_vom_us1_intro_clearance_60", "dx_vom_us2_lobby_entrance_230"];

  if(!scripts\engine\utility::flag("player_ready_for_marine")) {
    var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_1 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine(scripts\engine\utility::random(var_0));
  }
}

vo_mhbreach_alex_staircase_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_breach_thirdfloor_10");
  wait 0.5;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_breach_thirdfloor_20");

  if(!scripts\engine\utility::flag("player_entered_mg_room") && !scripts\engine\utility::flag("mg_team_alerted"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_murderhole_breach_thirdfloor_30");
}

vo_mhbreach_marine_clear_dialogue() {
  if(!scripts\engine\utility::flag("mg_team_alerted")) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_murderhole_breach_thirdfloor_90");
  }
}

vo_retreat_alex_mh_clear_dialogue() {
  level endon("missionfailed");
  level.player endon("death");
  level.griggs_retreat_line_done = 0;
  wait 0.5;
  thread vo_retreat_exit_sprint_monitor();
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_retreat_rally_10");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_rally_30");

  if(!scripts\engine\utility::flag("flag_vo_retreat_griggs_heli_fast")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_helos_10");
    level.griggs_retreat_line_done = 1;

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_heli_pilot("dx_vom_usgp_retreat_helos_20", undefined, undefined, undefined, 1);

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      thread vo_retreat_alex_nags();
  } else if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house_vehicle_move")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_helos_11");
    level.griggs_retreat_line_done = 1;

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_heli_pilot("dx_vom_usgp_retreat_helos_20", undefined, undefined, undefined, 1);

    if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      thread vo_retreat_alex_nags();
  }
}

vo_retreat_exit_sprint_monitor() {
  scripts\engine\utility::flag_wait("flag_retreat_spawn_vehicles");

  if(isDefined(level.griggs_retreat_line_done) && level.griggs_retreat_line_done == 0) {
    level.player scripts\common\utility::allow_sprint(0);

    while(level.griggs_retreat_line_done == 0 && !scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
      waitframe();

    level.player scripts\common\utility::allow_sprint(1);
  }
}

vo_retreat_alex_nags() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("flag_retreat_exiting_mg_house");
  wait 10;

  while(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house")) {
    if(!scripts\engine\utility::flag("flag_retreat_player_response")) {
      if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
        scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_rally_60");
    }

    wait(randomfloatrange(10.0, 15.0));

    if(!scripts\engine\utility::flag("flag_retreat_player_response")) {
      if(!scripts\engine\utility::flag("flag_retreat_exiting_mg_house"))
        scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_150");
    }

    wait(randomfloatrange(15.0, 20.0));
  }
}

vo_retreat_helo_air_support_intro_dialogue() {
  level.griggs thread scripts\sp\maps\marines\marines_utility.gsc::dialogue_stop();
  waitframe();
  thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_helos_40");
  wait 3;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_heli_pilot("dx_vom_usgp_retreat_helos_50", undefined, undefined, undefined, 1);
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_helos_60");
}

vo_retreat_marine_bombardment_reaction_dialogue() {
  var_0 = [self, "dx_vom_us2_retreat_helos_70", undefined, self, "dx_vom_us3_retreat_helos_80", undefined, self, "dx_vom_us4_retreat_helos_90", undefined];
  vo_knockout_manager("retreat_marine_bombardment_reaction", var_0);
}

vo_retreat_griggs_advance_bombardment_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_heli_pilot("dx_vom_usgp_retreat_helos_100", undefined, undefined, undefined, 1);
  level.griggs scripts\engine\sp\utility::smart_dialogue("dx_vom_grg_retreat_hospital_10");
  scripts\engine\utility::flag_set("flag_retreat_advance_vo_complete");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_retreat_hospital_20");
  wait 0.1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_retreat_hospital_30");
  wait 0.15;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_retreat_hospital_40");
  wait 0.1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us4_retreat_hospital_50");
  thread vo_retreat_griggs_advance_nags();
  thread vo_retreat_marine_advance_reactions_dialogue();
}

vo_retreat_marine_advance_reactions_dialogue() {
  scripts\engine\utility::flag_wait("flag_retreat_advance_2");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_retreat_hospital_90", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_retreat_hospital_91");
  wait 3;

  if(!scripts\engine\utility::flag("flag_retreat_trigger_counterattack")) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_retreat_hospital_100");
  }
}

vo_retreat_griggs_advance_nags() {
  level endon("missionfailed");
  level.player endon("death");
  level endon("murderhole_shadow_adjustment_end");
  wait 10;

  while(!scripts\engine\utility::flag("murderhole_shadow_adjustment_end")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_150", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_151");
    wait(randomfloatrange(10.0, 15.0));
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_160", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_161");
    wait(randomfloatrange(10.0, 15.0));
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_170", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_murderhole_smoke_171");
    wait(randomfloatrange(15.0, 20.0));
  }
}

vo_retreat_marine_advance_ambush_initial_dialogue() {
  wait 2.5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_lobby_entrance_20");
  wait 2;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_lobby_entrance_30");
  wait 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_lobby_entrance_40");
  wait 4;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_ma1_street_approach_160");
  wait 4;

  if(!scripts\engine\utility::flag("flag_retreat_rpg_killed"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_alley_combat_50");
}

vo_retreat_marine_rpgs_clear_dialogue() {
  wait 1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_lobby_entrance_70");
}

vo_retreat_griggs_advance_dialogue() {
  scripts\engine\utility::flag_wait("flag_retreat_marines_advance_to_lobby_2");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_lobby_entrance_100", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_lobby_entrance_101");
}

vo_lobby_griggs_secure_lobby_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_murderhole_smoke_140");
}

vo_lobby_marine_civ_warning_dialogue() {
  if(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_lobby_entrance_180");
  }
}

vo_lobby_marines_secured_dialogue() {
  level.griggs_lobby_cleared_vo_done = 0;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_groundfloor_door_10", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_groundfloor_door_11");
  level.griggs_lobby_cleared_vo_done = 1;

  if(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start") && distance2d(level.player.origin, level.griggs.origin) < 750) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_groundfloor_door_20");
    wait 0.5;

    if(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start")) {
      level.griggs scripts\engine\sp\utility::smart_dialogue("dx_vom_grg_groundfloor_door_30");
      wait 0.5;

      if(!scripts\engine\utility::flag("flag_groundfloor_hallway_ambush_start") && distance2d(level.player.origin, level.griggs.origin) < 750)
        scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_groundfloor_door_40");
    }
  }
}

vo_lobby_griggs_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_groundfloor_door_50", "dx_vom_grg_groundfloor_door_51", level.griggs, "dx_vom_grg_groundfloor_door_60", "dx_vom_grg_groundfloor_door_61", level.griggs, "dx_vom_grg_groundfloor_door_70", "dx_vom_grg_groundfloor_door_71"];
  vo_knockout_manager("lobby_griggs_nag_dialogue", var_0, level.player);
}

vo_groundfloor_civilian_screams_dialogue() {
  var_0 = [];
  var_1 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_civ();
  wait 0.5;

  if(isDefined(var_1) && isalive(var_1))
    var_1 scripts\engine\utility::playsoundonentity("dx_vom_civ_female_scream");

  if(isDefined(var_1))
    var_0 = scripts\engine\utility::array_add(var_0, var_1);

  wait 0.5;

  if(var_0.size > 0)
    var_2 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_civ(var_0);
  else
    var_2 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_civ();

  if(isDefined(var_2) && isalive(var_2))
    var_2 scripts\engine\utility::playsoundonentity("dx_vom_civ_male_scream");
}

vo_groundfloor_griggs_hallway_ambush_dialogue() {
  if(level.griggs_lobby_cleared_vo_done == 0) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_groundfloor_combat_20");
    wait 1;

    if(level.griggs_lobby_cleared_vo_done == 1)
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_groundfloor_combat_30");
  } else {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_groundfloor_combat_10");
    wait 1;
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_groundfloor_combat_20");
    wait 1;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_groundfloor_combat_30");
  }
}

vo_groundfloor_alex_tripwire_defused_dialogue() {
  scripts\engine\utility::flag_wait_any("flag_groundfloor_tripwire_defused", "flag_stairwell_reached");

  if(!scripts\engine\utility::flag("flag_stairwell_reached")) {
    var_0 = ["dx_vom_alx_civ_ambush_gun_120", "dx_vom_alx_mg_hall_tripwires_70"];
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex(scripts\engine\utility::random(var_0));
  }
}

vo_groundfloor_alex_corner_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_groundfloor_combat_120");
}

vo_civambush_griggs_stairwell_advance_dialogue() {
  scripts\engine\utility::flag_wait_or_timeout("flag_vo_stairwell_starting", 2.0);

  if(scripts\engine\sp\utility::get_living_ai_array("ai_aq_groundfloor", "script_noteworthy").size < 1) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_groundfloor_combat_160");
    wait 1;
  }

  level.griggs_vo_civambush_speaking = 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_stairs_10");
  level.griggs_vo_civambush_speaking = 0;
  wait 1;
  thread vo_civambush_group_progress_dialogue();
}

vo_civambush_group_progress_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_stairs_60");

  if(isDefined(level.alex_speaking_stairwell_secure_speaking) && level.alex_speaking_stairwell_secure_speaking == 0 && !scripts\engine\utility::flag("flag_civ_ambush_griggs_react_vo")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_civ_ambush_stairs_70");
    wait 0.5;
    level.griggs_vo_civambush_speaking = 1;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_stairs_80");
    level.griggs_vo_civambush_speaking = 0;
  } else if(!scripts\engine\utility::flag("flag_civ_ambush_griggs_react_vo")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_civ_ambush_stairs_70");
    wait 0.5;
    level.griggs_vo_civambush_speaking = 1;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_stairs_80");
    level.griggs_vo_civambush_speaking = 0;
  }
}

vo_civambush_griggs_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_civ_ambush_stairs_30", "dx_vom_grg_civ_ambush_stairs_31", level.griggs, "dx_vom_grg_civ_ambush_stairs_40", "dx_vom_grg_civ_ambush_stairs_41", level.griggs, "dx_vom_grg_civ_ambush_stairs_50", "dx_vom_grg_civ_ambush_stairs_51"];
  vo_knockout_manager("civambush_griggs_nag", var_0);
}

vo_civambush_marine_intro_dialogue() {
  scripts\engine\utility::flag_wait("flag_griggs_enter_civ_ambush_gate");

  while(level.griggs_vo_civambush_speaking == 1)
    waitframe();

  wait 0.5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();

  if(!scripts\engine\utility::flag("flag_griggs_corner_gate"))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_civ_ambush_triage_10");

  level.griggs_vo_civambush_speaking = 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_triage_20");
  level.griggs_vo_civambush_speaking = 0;
  wait 0.5;

  if(isDefined(var_0) && isalive(var_0) && !scripts\engine\utility::flag("flag_griggs_corner_gate"))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_civ_ambush_triage_30");

  wait 0.5;

  if(isDefined(var_0) && isalive(var_0) && !scripts\engine\utility::flag("flag_civ_ambush_vo_expire")) {
    level.griggs_vo_civambush_speaking = 1;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_triage_40");
    level.griggs_vo_civambush_speaking = 0;
  }

  wait 2;

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_civ_ambush_triage_50");
}

vo_civambush_alex_take_point() {
  scripts\engine\utility::flag_wait("flag_alex_vo_corridor");

  for(;;) {
    if(level.griggs_vo_civambush_speaking == 1)
      waitframe();
    else {
      if(!scripts\engine\utility::flag("flag_ambusher_killed_clear_vo"))
        scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_triage_60", undefined, undefined, undefined, undefined, level.player);

      break;
    }

    waitframe();
  }
}

vo_civ_ambush_player_handsup_responsive_dialogue(var_0) {
  var_1 = [level.player, "dx_vom_alx_civ_ambush_search_10", undefined, level.player, "dx_vom_alx_civ_ambush_search_30", undefined];
  vo_knockout_manager("civ_ambush_player_handsup_responsive", var_1, undefined, undefined, undefined, 0);
  wait 1.5;

  if(isDefined(var_0) && isalive(var_0))
    var_0 thread vo_civ_ambush_civ_react_dialogue();
}

vo_civ_ambush_friendly_hands_up_dialogue() {
  if(self != level.griggs)
    vo_civ_ambush_marine_hands_up_dialogue();
}

vo_civ_ambush_marine_hands_up_dialogue() {
  var_0 = [self, "dx_vom_us2_intro_clearance_90", undefined, self, "dx_vom_us2_intro_clearance_100", undefined, self, "dx_vom_us1_intro_clearance_180", undefined, self, "dx_vom_us1_intro_clearance_190", undefined, self, "dx_vom_us1_intro_clearance_220", undefined];
  vo_knockout_manager("civ_ambush_marine_hands_up_dialogue", var_0);
}

vo_civ_ambush_civ_react_dialogue() {
  if(!isDefined(self.sex)) {
    return;
  }
  if(self.sex == "male") {
    thread vo_civ_ambush_civ_react_male_dialogue();
    return;
  }

  if(self.sex == "female")
    thread vo_civ_ambush_civ_react_female_dialogue();
}

vo_civ_ambush_civ_react_male_dialogue() {
  var_0 = [self, "dx_vom_cvm1_civ_ambush_civ_10", undefined, self, "dx_vom_cvm1_civ_ambush_civ_20", undefined, self, "dx_vom_cvm1_civ_ambush_civ_30", undefined, self, "dx_vom_cvm1_civ_ambush_civ_40", undefined, self, "dx_vom_cvm1_civ_ambush_civ_50", undefined];
  vo_knockout_manager("civ_ambush_civ_react_male_dialogue", var_0);
}

vo_civ_ambush_civ_react_female_dialogue(var_0) {
  var_1 = [self, "dx_vom_cvf1_civ_ambush_civ_60", undefined, self, "dx_vom_cvf1_civ_ambush_civ_70", undefined, self, "dx_vom_cvf1_civ_ambush_civ_80", undefined, self, "dx_vom_cvf1_civ_ambush_civ_90", undefined];
  vo_knockout_manager("civ_ambush_civ_react_female_dialogue", var_1);
}

vo_civ_ambush_alex_dialogue() {
  scripts\engine\utility::flag_wait("flag_alex_vo_corridor");
  level.griggs_vo_civambush_speaking = 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_corridor_60", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_civ_ambush_corridor_61");
  wait 0.25;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_radio("dx_vom_us3_civ_ambush_corridor_10", undefined, undefined, undefined, 1);
  level.griggs_vo_civambush_speaking = 0;
  scripts\engine\utility::flag_wait("flag_ambusher_killed_clear_vo");
  wait 2;
  level.griggs_vo_civambush_speaking = 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_corridor_70", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_civ_ambush_corridor_71");
  level.griggs_vo_civambush_speaking = 0;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_civ_ambush_corridor_80");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_corridor_90");
}

vo_civambush_alex_shoot_dialogue() {
  var_0 = ["dx_vom_alx_civ_ambush_gun_10", "dx_vom_alx_civ_ambush_gun_20"];

  if(isDefined(level.civ_ambusher) && isalive(level.civ_ambusher)) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.civ_ambusher getEye(), cos(45)))
      thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex(scripts\engine\utility::random(var_0));
  }
}

vo_civambush_griggs_shoot_dialogue() {
  var_0 = ["dx_vom_grg_civ_ambush_gun_40", "dx_vom_grg_civ_ambush_gun_50", "dx_vom_grg_civ_ambush_gun_60"];
  thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs(scripts\engine\utility::random(var_0));
}

vo_civ_ambush_ambusher_shoot_dialogue() {
  var_0 = ["dx_vom_aq1_civ_ambush_attack_10", "dx_vom_aq2_civ_ambush_attack_20", "dx_vom_aq3_civ_ambush_attack_30"];

  if(isDefined(level.civ_ambusher) && isalive(level.civ_ambusher))
    thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_civ_ambusher(scripts\engine\utility::random(var_0));
}

vo_civ_ambush_ambusher_killed_dialogue() {
  if(isalive(level.player)) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_gun_100");
    scripts\engine\utility::flag_set("flag_ambusher_killed_clear_vo");
  }
}

vo_mghall_enemy_trap_shout(var_0) {
  var_1 = ["dx_cbc_aq1_reaction_hostile_burst", "dx_cbc_aq2_reaction_hostile_burst", "dx_cbc_aq3_reaction_hostile_burst"];
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_aq(scripts\engine\utility::random(var_1));
}

vo_mghall_marines_intro_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us2_mg_hall_assault_20");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_convoy_ambush_attack_100", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_us1_convoy_ambush_attack_101");
  wait 1;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_10");
  wait 3;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_40");
  wait 2;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_50", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_mg_hall_assault_51");
  wait 4;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_120");
}

vo_mghall_griggs_shoot_nag_1_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_130", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_mg_hall_assault_131");
}

vo_mghall_griggs_shoot_nag_2_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_140", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_grg_mg_hall_assault_141");
}

vo_mghall_marine_reloading_dialogue() {
  level waittill("mg_reloading");
  wait 0.5;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_mg_hall_assault_110", undefined, undefined, undefined, undefined, undefined, undefined, undefined, "dx_vom_us1_mg_hall_assault_111");
}

vo_mghall_smoked_dialogue_handler() {
  while(level.mg_hall_griggs_smoke_vo_done == 0)
    waitframe();

  thread vo_mghall_griggs_smoked_dialogue();
}

vo_mghall_griggs_smoked_dialogue() {
  level.mg_hall_griggs_smoke_vo_done = 0;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_civ_ambush_corridor_110");
  level.mg_hall_griggs_smoke_vo_done = 1;
}

vo_mghall_alex_tripwire_l_defused_dialogue() {
  scripts\engine\utility::flag_wait_any("flag_mghall_tripwire_l_defused", "mg_hall_gunner_dead");

  if(!scripts\engine\utility::flag("mg_hall_gunner_dead")) {
    var_0 = ["dx_vom_alx_civ_ambush_gun_120", "dx_vom_alx_mg_hall_tripwires_70"];
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex(scripts\engine\utility::random(var_0));
  }
}

vo_mghall_alex_tripwire_r_defused_dialogue() {
  scripts\engine\utility::flag_wait_any("flag_mghall_tripwire_r_defused", "mg_hall_gunner_dead");

  if(!scripts\engine\utility::flag("mg_hall_gunner_dead")) {
    var_0 = ["dx_vom_alx_civ_ambush_gun_120", "dx_vom_alx_mg_hall_tripwires_50"];
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex(scripts\engine\utility::random(var_0));
  }
}

vo_mghall_griggs_gunner_dead_alex_dialogue() {
  level.mg_hall_cleared_vo_done = 0;
  wait 1.0;
  scripts\engine\utility::flag_wait("flag_mg_hall_cleared");

  if(!scripts\engine\utility::flag("flag_snakecam_tripwire_cleared")) {
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_150");

    if(distance2d(level.player.origin, level.griggs.origin) < 1000)
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_mg_hall_assault_160");

    level.mg_hall_cleared_vo_done = 1;
  } else
    level.mg_hall_cleared_vo_done = 1;
}

vo_mghall_marine_clear_dialogue() {
  level.mg_hall_cleared_vo_done = 0;
  wait 1.0;
  scripts\engine\utility::flag_wait("flag_mg_hall_cleared");

  if(!scripts\engine\utility::flag("flag_snakecam_tripwire_cleared")) {
    var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_mg_hall_assault_170");
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_mg_hall_assault_180");
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_assault_190");
    level.mg_hall_cleared_vo_done = 1;
  } else
    level.mg_hall_cleared_vo_done = 1;
}

vo_snakecam_griggs_tripwire_start_dialogue() {
  scripts\engine\utility::flag_wait("flag_mg_hall_cleared");

  if(isDefined(level.mg_hall_cleared_vo_done) && level.mg_hall_cleared_vo_done == 0) {
    while(level.mg_hall_cleared_vo_done == 0)
      waitframe();
  }

  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_tripwires_190");
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
  var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_mg_hall_tripwires_200");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_wolfdoor_10");

  if(!scripts\engine\utility::flag("flag_wolf_tripwire_cleared")) {
    if(!isDefined(level.snakecam_setting_up_vo)) {
      if(isDefined(var_0) && isalive(var_0))
        var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_snakecam_wolfdoor_20");
      else {
        var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();
        var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_snakecam_wolfdoor_20");
      }
    }
  }
}

vo_snakecam_griggs_snakecam_start_dialogue() {
  if(!scripts\engine\utility::flag("snakecam_enable_flag")) {
    if(isDefined(level.snakecam_marine) && isalive(level.snakecam_marine)) {
      level.snakecam_setting_up_vo = 1;
      level.snakecam_marine scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_snakecam_wolfdoor_30");
    }
  }

  scripts\engine\utility::flag_wait("snakecam_enable_flag");

  if(isDefined(level.snakecam_marine) && isalive(level.snakecam_marine))
    level.snakecam_marine scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us3_snakecam_wolfdoor_40");
}

vo_snakecam_griggs_snakecam_ready_dialogue() {
  wait 3;

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_starting")) {
    level.snakecam_griggs_setup_vo_done = 0;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_wolfdoor_50", undefined, undefined, undefined, undefined, level.player, undefined, undefined, "dx_vom_grg_snakecam_wolfdoor_51");
    level.snakecam_griggs_setup_vo_done = 1;
  }

  wait(randomfloatrange(10.0, 15.0));

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_starting")) {
    level.snakecam_griggs_setup_vo_done = 0;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_wolfdoor_60", undefined, undefined, undefined, undefined, level.player, undefined, undefined, "dx_vom_grg_snakecam_wolfdoor_61");
    level.snakecam_griggs_setup_vo_done = 1;
  }

  wait(randomfloatrange(10.0, 15.0));

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_starting")) {
    level.snakecam_griggs_setup_vo_done = 0;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_wolfdoor_70", undefined, undefined, undefined, undefined, level.player, undefined, undefined, "dx_vom_grg_snakecam_wolfdoor_71");
    level.snakecam_griggs_setup_vo_done = 1;
  }

  wait(randomfloatrange(10.0, 15.0));

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_starting")) {
    level.snakecam_griggs_setup_vo_done = 0;
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_mg_hall_tripwires_240", undefined, undefined, undefined, undefined, level.player, undefined, undefined, "dx_vom_grg_mg_hall_tripwires_241");
    level.snakecam_griggs_setup_vo_done = 1;
  }
}

vo_snakecam_wolf_speech_dialogue() {
  while(level.wolf_nag_count < 1 && !scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    waitframe();

  if(isDefined(level.proxy_wolf) && isalive(level.proxy_wolf))
    level.proxy_wolf scripts\engine\utility::waittill_any("sounddone", "face_sounddone");

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_hostage_20");

  while(level.wolf_nag_count < 3 && !scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    waitframe();
}

vo_snakecam_wolf_dialogue() {
  if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_hostage_30");

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete")) {
    level.wolf_nag_count++;

    if(isDefined(level.proxy_wolf) && isalive(level.proxy_wolf))
      level.proxy_wolf scripts\engine\sp\utility::smart_dialogue("dx_vom_wolf_wolf_capture_401");
  }

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_snakecam_hostage_40");

  wait 0.95;

  if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete"))
    scripts\engine\utility::flag_set("flag_vo_final_line_done");

  wait 1.5;

  if(isDefined(level.proxy_wolf) && isalive(level.proxy_wolf))
    level.proxy_wolf scripts\engine\sp\utility::smart_dialogue("dx_vom_wolf_wolf_capture_91");
}

vo_snakecam_hostage_dialogue() {
  scripts\engine\utility::flag_wait("flag_snakecam_hostage_kicked");
}

vo_wolf_alex_start_dialogue() {
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_wolf_capture_10");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_wolf_capture_20", undefined, undefined, undefined, undefined, level.player);
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_wolf_capture_41", undefined, undefined, undefined, undefined, level.player);
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_civ_ambush_corridor_30");
}

vo_wolf_marine_balcony_advance_dialogue(var_0) {
  var_1 = getEnt("wolf_alternate_path_marine_faketarget", "targetname");

  for(;;) {
    var_2 = sighttracepassed(var_1.origin, level.player getEye(), 0, level.player);
    var_3 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_1.origin, 0.95);

    if(var_2 && var_3) {
      break;
    }

    wait 1;
  }

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_vom_us1_wolf_capture_42");
}

vo_wolf_alex_tripwire_approach_dialogue() {
  level.wolf_tripwire_set_vo_done = 0;
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_hospital_wolf_room_10");
  level.wolf_tripwire_set_vo_done = 1;
}

vo_wolf_alex_tripwire_encountered_dialogue() {
  while(level.wolf_tripwire_set_vo_done == 0)
    waitframe();

  if(isalive(level.player))
    thread scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_alex("dx_vom_alx_hospital_wolf_room_30");
}

vo_wolf_wolf_tripwire_cleared_speech_dialogue() {
  var_0 = ["dx_vom_wolf_wolf_capture_40", "dx_vom_wolf_wolf_capture_401", "dx_vom_wolf_wolf_capture_402"];
  var_1 = 0;

  if(level.wolf_nag_count > 0)
    var_1 = level.wolf_nag_count + 1;

  scripts\engine\utility::flag_wait_or_timeout("flag_wolf_tripwire_cleared", 3.0);

  while(var_1 < var_0.size && !scripts\engine\utility::flag("flag_wolf_vo_expire") && level.wolf_killed == 0) {
    if(level.wolf_killed == 0) {
      scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_wolf(var_0[var_1]);
      wait(randomfloatrange(3.0, 5.0));
      var_1++;
    }
  }
}

vo_wolf_alex_tripwire_cleared_dialogue() {
  scripts\engine\utility::flag_wait("flag_wolf_breach_gundown");
  scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_griggs("dx_vom_grg_wolf_capture_50");
}

vo_wolf_marine_tripwire_triggered_dialogue() {
  wait 1;
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_marine();

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_marine("dx_cbc_usm1_reaction_casualty");
}

vo_wolf_aq_takedown_alerted_dialogue() {
  var_0 = scripts\sp\maps\marines\marines_utility.gsc::get_closest_aq();

  if(isDefined(var_0) && isalive(var_0))
    var_0 scripts\sp\maps\marines\marines_utility.gsc::add_dialogue_line_aq("dx_vom_aq1_wolf_capture_100");
}

vo_smoke_nag_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_mg_hall_assault_60", "dx_vom_grg_mg_hall_assault_61", level.griggs, "dx_vom_grg_mg_hall_assault_70", "dx_vom_grg_mg_hall_assault_71"];
  vo_knockout_manager("smoke_nag", var_0, level.player);
}

vo_wolf_fail_timer_nag() {
  var_0 = [level.griggs, "dx_vom_grg_intro_convoy_80", undefined, level.griggs, "dx_vom_grg_murderhole_smoke_140", undefined];
  vo_knockout_manager("wolf_fail_timer_nag", var_0, level.player);
}

vo_wolf_fail_timer_radio_nag() {
  var_0 = [level.griggs, "dx_vom_grg_murderhole_smoke_150", undefined, level.griggs, "dx_vom_grg_murderhole_breach_thirdfloor_70", undefined, level.griggs, "dx_vom_grg_murderhole_smoke_160", undefined];
  vo_knockout_manager("wolf_fail_timer_radio_nag", var_0, level.player);
}

vo_friendly_fire_dialogue() {
  var_0 = [level.griggs, "dx_vom_grg_civ_ambush_civkill_10", "dx_vom_grg_civ_ambush_civkill_11", level.griggs, "dx_vom_grg_civ_ambush_civkill_20", "dx_vom_grg_civ_ambush_civkill_21", level.griggs, "dx_vom_grg_civ_ambush_civkill_30", "dx_vom_grg_civ_ambush_civkill_31", scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_cbc_usm1_response_check_fire", undefined, scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_cbc_usm2_response_check_fire", undefined, scripts\sp\maps\marines\marines_utility.gsc::vo_get_closest_available_marine, "dx_cbc_usm3_response_check_fire", undefined];
  vo_knockout_manager("friendly_fire_dialogue", var_0, level.player);
}

vo_knockout_manager(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.knockout_manager))
    level.knockout_manager = [];

  if(!isDefined(level.knockout_manager[var_0])) {
    level.knockout_manager[var_0] = [];

    for(var_6 = 0; var_6 < var_1.size; var_6++) {
      switch (var_6 % 3) {
        case 0:
          level.knockout_manager[var_0][int(var_6 / 3)] = [];
          level.knockout_manager[var_0][int(var_6 / 3)]["used"] = 0;
          level.knockout_manager[var_0][int(var_6 / 3)]["speaker"] = var_1[var_6];
          level.knockout_manager[var_0][int(var_6 / 3)]["glance_entity"] = var_2;
          level.knockout_manager[var_0][int(var_6 / 3)]["glance_duration"] = var_3;
          level.knockout_manager[var_0][int(var_6 / 3)]["glance_intensity"] = var_4;
          break;
        case 1:
          level.knockout_manager[var_0][int((var_6 - 1) / 3)]["dialogue"] = var_1[var_6];
          level.knockout_manager[var_0][int((var_6 - 1) / 3)]["glance_entity"] = var_2;
          level.knockout_manager[var_0][int((var_6 - 1) / 3)]["glance_duration"] = var_3;
          level.knockout_manager[var_0][int((var_6 - 1) / 3)]["glance_intensity"] = var_4;
          break;
        case 2:
          level.knockout_manager[var_0][int((var_6 - 2) / 3)]["radio"] = var_1[var_6];
          break;
        default:
      }
    }
  }

  if(!isDefined(var_5))
    var_5 = 1;

  vo_knockout_manager_dialogue(var_0, var_5);
}

vo_knockout_manager_dialogue(var_0, var_1) {
  if(var_1 == 0) {
    var_2 = 1;

    foreach(var_4 in level.knockout_manager[var_0]) {
      if(var_4["used"] == 0)
        var_2 = 0;
    }

    if(var_2 == 1)
      return;
  }

  level.knockout_manager[var_0] = vo_knockout_manager_reset_check(level.knockout_manager[var_0]);
  var_6 = vo_knockout_manager_get_random(level.knockout_manager[var_0]);
  level.knockout_manager[var_0][var_6]["used"] = 1;

  if(isDefined(level.knockout_manager[var_0][var_6]["speaker"])) {
    var_7 = undefined;

    if(isent(level.knockout_manager[var_0][var_6]["speaker"]))
      var_7 = level.knockout_manager[var_0][var_6]["speaker"];
    else
      var_7 = [[level.knockout_manager[var_0][var_6]["speaker"]]]();

    if(!isDefined(var_7.animname))
      var_7.animname = "generic";

    var_7 thread scripts\sp\maps\marines\marines_utility.gsc::dialogue(level.knockout_manager[var_0][var_6]["dialogue"], undefined, undefined, undefined, undefined, level.knockout_manager[var_0][var_6]["glance_entity"], level.knockout_manager[var_0][var_6]["glance_duration"], level.knockout_manager[var_0][var_6]["glance_intensity"], level.knockout_manager[var_0][var_6]["radio"]);
  }
}

vo_knockout_manager_reset_check(var_0) {
  foreach(var_2 in var_0) {
    if(var_2["used"] == 0)
      return var_0;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++)
    var_0[var_4]["used"] = 0;

  return var_0;
}

vo_knockout_manager_get_random(var_0) {
  for(var_1 = randomintrange(0, var_0.size); var_0[var_1]["used"] == 1; var_1 = randomintrange(0, var_0.size)) {}

  return var_1;
}

mus_infil() {
  wait 0.1;
  setmusicstate("mx_marines_infil");
}

mus_mghall_clear() {
  scripts\engine\utility::flag_wait("mg_hall_gunner_dead");
  wait 0.1;
  setmusicstate("mx_marines_hospital");
}

mus_snakecam_enter() {
  scripts\engine\utility::flag_wait("flag_wolf_snakecam_starting");
  wait 0.1;
  setmusicstate("mx_marines_cam");
}

mus_wolf_captured() {
  wait 1.5;
  setmusicstate("");
}

sphere_test() {
  for(;;) {
    var_0 = distance2d(level.player.origin, level.griggs.origin);
    iprintln(" " + var_0);
    waitframe();
  }
}