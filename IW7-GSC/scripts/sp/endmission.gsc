/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\endmission.gsc
*************************************/

main() {
  level.var_B8D2 = func_49EF();
  func_17E9("europa", "campaign", 0, "EUROPA", 1, "", 10, 100, undefined, undefined);
  func_17E9("phparade", "campaign", 0, undefined, 0, "pearl_maptrans_cutscene_admiral_office", 28, 0, undefined, ["phparade_office_tr", "phparade_ride_tr"]);
  func_17E9("phstreets", "campaign", 1, undefined, 1, "pearl_maptrans_dropship_crash", undefined, 0, undefined, undefined);
  func_17E9("phspace", "campaign", 0, "PEARL", 1, "pearl_maptrans_cutscene_hvt_capture", undefined, 0, undefined, ["phspace_base_tr", "phspace_shared_tr"]);
  func_17E9("shipcrib_moon", "sc", 0, undefined, 0, "sc_moon_maptrans_jackal_return", 15, 0, undefined, ["shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr"]);
  func_17E9("moon_port", "campaign", 0, undefined, 1, "moon_maptrans_hud_well_deck", 40, 50, undefined, ["moon_port_welldeck_tr", "moon_port_infil_tr"]);
  func_17E9("moonjackal", "campaign", 0, undefined, 1, "moon_maptrans_jackal_arena", 10, 0, undefined, ["moonjackal_hangar_tr", "moonjackal_arena_tr", "moonjackal_ships_tr"]);
  func_17E9("sa_moon", "campaign", 0, "MOON", 1, "moon_maptrans_hud_assault_briefing", 2, 50, undefined, ["sa_moon_exterior_tr", "sa_moon_exterior_ship_tr"]);
  func_17E9("shipcrib_europa", "sc", 0, undefined, 0, "sc_europa_maptrans_hud_jackal_return_hvt", 15, 0, undefined, ["shipcrib_europa_jackal_tr", "shipcrib_europa_jackale_tr"]);
  func_17E9("shipcrib_titan", "sc", 0, undefined, 0, "sc_assault_maptrans_jackal_return", 2, 0, undefined, ["shipcrib_titan_halore_tr", "shipcrib_titan_exterior_tr", "shipcrib_titan_prime_in_tr", "shipcrib_titan_bridge_tr"]);
  func_17E9("titan", "campaign", 0, undefined, 1, "titan_maptrans_dropship_turbulence", 8, 50, undefined, ["titan_launch_art_tr", "titan_flyin_art_tr", "titan_first_steps_tr"]);
  func_17E9("titanjackal", "campaign", 0, "TITAN", 1, "titan_maptrans_hud_jackal_briefing", 0, 100, undefined, ["titan_jackal_refinery_tr"]);
  func_17E9("shipcrib_rogue", "sc", 0, undefined, 0, "sc_rogue_maptrans_cutscene_rescued", 15, 0, undefined, ["shipcrib_rogue_bridgem_tr"], ["shipcrib_rogue_halore_tr", "shipcrib_rogue_exterior_tr", "shipcrib_rogue_prime_in_tr", "shipcrib_rogue_bridge_tr"]);
  func_17E9("rogue", "campaign", 0, "ROGUE", 1, "rogue_maptrans_world_readings", 41, 50, undefined, ["rogue_hangar_tr", "rogue_surface_tr"]);
  func_17E9("shipcrib_prisoner", "sc", 0, undefined, 0, "sc_prisoner_maptrans_cutscene_omar_gone", 12, 0, undefined, ["shipcrib_prisoner_dropship_tr", "shipcrib_prisoner_ambient_tr", "shipcrib_prisoner_ambientmr_tr", "shipcrib_prisoner_jackale_tr"], ["shipcrib_prisoner_halore_tr", "shipcrib_prisoner_exterior_tr", "shipcrib_prisoner_prime_in_tr", "shipcrib_prisoner_bridge_tr"]);
  func_17E9("prisoner", "campaign", 0, undefined, 1, "prisoner_maptrans_hud_dropship_hvt", 15, 50, undefined, ["prisoner_pre_church_tr"]);
  func_17E9("heist", "campaign", 0, "HEIST", 1, "heist_maptrans_hvt_fall_impact", undefined, 0, undefined, ["heist_city_tr"]);
  func_17E9("heistspace", "campaign", 0, undefined, 1, "heist_maptrans_om_shipyard_ftl", undefined, 0, undefined, undefined);
  func_17E9("marscrash", "campaign", 0, undefined, 1, "mars_maptrans_blackout", undefined, 0, undefined, ["marscrash_vista_tr", "marscrash_playspace_tr"]);
  func_17E9("marscrib", "sc", 0, undefined, 0, "mars_maptrans_cutscene_crash_site", 4, 50, undefined, undefined);
  func_17E9("marsbase", "campaign", 0, undefined, 1, "mars_maptrans_hud_dropship_briefing", 10, 0, undefined, ["marsbase_dropship_hero_tr", "marsbase_combat_intro_tr"]);
  func_17E9("yard", "campaign", 0, "YARD", 1, "mars_maptrans_hud_yard_briefing", 15, 0, undefined, ["yard_elevator_tr", "yard_pod_chamber_tr"]);
  func_17E9("shipcrib_epilogue", "sc", 0, undefined, 0, "epilogue_memorial", 2, 0, undefined, ["shipcrib_epilogue_bridge_tr", "shipcrib_epilogue_exterior_tr"]);
  func_17E9("sa_assassination", "sa", 0, "SA_ASSASSINATION", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, ["sa_assassination_destroyer_ext_tr", "sa_assassination_destroyer_keel_tr", "sa_assassination_infil_tr"]);
  func_17E9("sa_empambush", "sa", 0, "SA_EMP", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, ["sa_empambush_pre_docking_tr"]);
  func_17E9("sa_vips", "sa", 0, "SA_VIP", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, ["sa_vips_space_tr", "sa_vips_hull_tr", "sa_vips_spacemisc_tr"]);
  func_17E9("sa_wounded", "sa", 0, "SA_WOUNDED", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, ["sa_wounded_carrier_geo_tr", "sa_wounded_ext_tr", "sa_wounded_exitbay_tr"]);
  func_17E9("ja_asteroid", "ja", 0, "JA_ASTEROID", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, undefined);
  func_17E9("ja_mining", "ja", 0, "JA_MINING", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, undefined);
  func_17E9("ja_spacestation", "ja", 0, "JA_STATION", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, undefined);
  func_17E9("ja_titan", "ja", 0, "JA_TITAN", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, undefined);
  func_17E9("ja_wreckage", "ja", 0, "JA_WRECKAGE", 1, "sc_assault_maptrans_jackal_launch", undefined, 0, undefined, undefined);
  if(isDefined(level.var_6365)) {
    [[level.var_6365]]();
    level.var_6365 = undefined;
  }
}

func_4F25() {
  wait(10);
  while(getdvarint("test_next_mission") < 1) {
    wait(3);
  }

  if(getdvarint("test_next_mission_fastload", 0) != 0) {
    func_1356();
    wait(1);
    while(!ispreloadzonescomplete()) {
      scripts\engine\utility::waitframe();
    }
  }

  func_1355();
}

func_1355(param_00) {
  if(scripts\sp\utility::func_93A6()) {
    scripts\sp\specialist_MAYBE::hide_helmet_impacts();
    if(!level.console) {
      wait(0.05);
    }
  }

  if(scripts\sp\utility::func_9BB7()) {
    setsaveddvar("ui_nextMission", "0");
    if(isDefined(level.var_BF96)) {
      changelevel("", 0, level.var_BF96);
    } else {
      changelevel("", 0);
    }

    return;
  }

  level notify("nextmission");
  level.var_BF95 = 1;
  level.player getrankinfoxpamt();
  setdvar("ui_showPopup", "0");
  setdvar("ui_popupString", "");
  setdvar("ui_prev_map", level.script);
  game["previous_map"] = undefined;
  var_01 = func_7F6B(level.script);
  scripts\sp\gameskill::func_262C("aa_main_" + level.script);
  if(!isDefined(var_01)) {
    missionsuccess(level.script);
    return;
  }

  if(level.script != "shipcrib_epilogue") {
    scripts\sp\utility::func_ABD2();
  }

  func_F77F(var_01);
  scripts\sp\loadout::func_EB5B();
  var_02 = func_12F24();
  lib_0A2F::func_12E18();
  updategamerprofile();
  if(func_8BBF(var_01)) {
    scripts\sp\utility::settimer(func_7D92(var_01));
  }

  if(func_7F6A(var_01)) {
    if(func_3DEA(var_01, 1, 0)) {
      level.player _meth_84C7("unlockedRealism", 1);
      lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_02");
    }

    var_03 = func_7F69(var_01);
    if(var_03 >= 4) {
      if(func_3DEA(var_01, 4, 1)) {
        scripts\sp\utility::settimer("VETERAN");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_21");
      }
    }

    if(var_03 >= 5) {
      if(func_3DEA(var_01, 5, 0)) {
        level.player _meth_84C7("beatRealism", 1);
        lib_0A2F::func_EBB7("iw7_m1");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_22");
      }
    }

    if(var_03 == 6) {
      if(func_3DEA(var_01, 6, 0)) {
        level.player _meth_84C7("beatRealism", 1);
        lib_0A2F::func_EBB7("iw7_m1");
        lib_0A2F::func_EBB7("iw7_ake_gold");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_22");
      }
    }
  }

  if(getitemfromcache(var_01) && func_3DEB(var_01)) {
    scripts\sp\utility::settimer("ALL_SA");
  }

  if(getitemdroporiginandangles(var_01) && func_3DE8(var_01)) {
    scripts\sp\utility::settimer("ALL_JA");
  }

  level.player scripts\sp\analytics::func_B8CE(level.script);
  if(level.script == "shipcrib_epilogue") {
    changelevel("", 0);
    var_04 = level.player _meth_84C6("missionStateData", "ja_mining");
    var_05 = level.player _meth_84C6("missionStateData", "ja_titan");
    if(isDefined(var_04) && var_04 == "locked") {
      level.player _meth_84C7("missionStateData", "ja_mining", "incomplete");
    }

    if(isDefined(var_05) && var_05 == "locked") {
      level.player _meth_84C7("missionStateData", "ja_titan", "incomplete");
    }

    return;
  }

  var_06 = var_04 + 1;
  var_07 = level.script;
  var_08 = level.player _meth_84C6("lastShipcribMission");
  var_09 = undefined;
  if(var_06 < level.var_B8D2.var_ABFA.size) {
    var_09 = level.var_B8D2.var_ABFA[var_06].var_2AD3;
  }

  if(isDefined(var_08) && level.script != "sa_moon") {
    if(getitemfromcache(var_04) || getitemdroporiginandangles(var_04)) {
      var_06 = func_12A7(var_08);
      var_09 = func_12A8(var_07);
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_0A = strtok(level.var_FDFA, "_");
    if(var_0A.size > 0) {
      if(var_0A[0] == "sa" || var_0A[0] == "ja") {
        var_06 = func_12A9(level.var_FDFA);
        var_09 = level.var_B8D2.var_ABFA[var_06].var_2AD3;
      }
    }
  }

  if(isDefined(var_09)) {
    setdvar("last_transition_movie", var_09);
    if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
      scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
    }

    if(!isDefined(var_02)) {
      setomnvar("ui_hide_hud", 1);
    }

    if(!level.player islinked()) {
      var_0B = level.player scripts\engine\utility::spawn_tag_origin();
      level.player playerlinktoabsolute(var_0B);
    }

    level.player freezecontrols(1);
    if(scripts\engine\utility::flag("nextmission_transition_bink_primed")) {
      setsaveddvar("bg_cinematicAboveUI", "0");
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      pausecinematicingame(0);
    } else {
      setsaveddvar("bg_cinematicAboveUI", "0");
      setsaveddvar("bg_cinematicFullScreen", "1");
      setsaveddvar("bg_cinematicCanPause", "1");
      cinematicingame(var_09, 0, 1, 1);
    }
  }

  level.player _meth_84C7("missionStateData", level.script, "complete");
  level.player _meth_84C7("opsmapMissionStateData", level.script, "complete");
  level.player _meth_84C7("lastCompletedMission", level.script);
  level.player _meth_84C7("currentLoadout", "levelCreated", var_06);
  var_0C = func_7F6D(var_06);
  level.player _meth_84C7("missionStateData", var_0C, "incomplete");
  level.player _meth_84C7("opsmapMissionStateData", var_0C, "incomplete");
  if(getdvarint("fastload", 1) != 0) {
    if(waspreloadzonesstarted()) {
      for(var_0D = 0; !ispreloadzonescomplete(); var_0D--) {
        if(var_0D == 0) {
          var_0D = 60;
        }

        scripts\engine\utility::waitframe();
      }
    }

    if(scripts\engine\utility::flag_exist("nextmission_preload_complete")) {
      while(!scripts\engine\utility::flag_exist("weapons_preloaded")) {
        wait(0.05);
      }

      var_0D = 0;
      for(var_0E = 200; !scripts\engine\utility::flag("weapons_preloaded"); var_0E--) {
        if(var_0D == 0) {
          var_0D = 60;
        }

        if(var_0E == 0) {
          break;
        }

        scripts\engine\utility::waitframe();
        var_0D--;
      }
    }
  }

  if(isDefined(var_02)) {
    wait(var_02);
    setomnvar("ui_hide_hud", 1);
  }

  if(isDefined(func_7EB2(var_04))) {
    changelevel(func_7F6D(var_06), func_7F31(var_04), func_7EB2(var_04));
    return;
  }

  changelevel(func_7F6D(var_06), func_7F31(var_04));
}

func_12A9(param_00) {
  var_01 = 22;
  switch (param_00) {
    case "sa_assassination":
      var_01 = 23;
      break;

    case "sa_empambush":
      var_01 = 24;
      break;

    case "sa_vips":
      var_01 = 25;
      break;

    case "sa_wounded":
      var_01 = 26;
      break;

    case "ja_asteroid":
      var_01 = 27;
      break;

    case "ja_mining":
      var_01 = 28;
      break;

    case "ja_spacestation":
      var_01 = 29;
      break;

    case "ja_titan":
      var_01 = 30;
      break;

    case "ja_wreckage":
      var_01 = 31;
      break;
  }

  return var_01;
}

func_12A7(param_00) {
  var_01 = 9;
  switch (param_00) {
    case "shipcrib_moon":
      var_01 = 8;
      break;

    case "shipcrib_europa":
      var_01 = 9;
      break;

    case "shipcrib_titan":
      var_01 = 9;
      break;

    case "shipcrib_rogue":
      var_01 = 12;
      break;

    case "shipcrib_prisoner":
      var_01 = 14;
      break;
  }

  return var_01;
}

func_12A8(param_00) {
  var_01 = "sc_assault_maptrans_jackal_return_seamless";
  switch (param_00) {
    case "sa_assassination":
      var_01 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "sa_vips":
      var_01 = "sc_assault_maptrans_jackal_return";
      break;

    case "sa_empambush":
      var_01 = "sc_assault_empambush_blackout";
      break;

    case "sa_wounded":
      var_01 = "sc_assault_maptrans_jackal_return";
      break;

    case "ja_asteroid":
      var_01 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_mining":
      var_01 = "sc_assault_maptrans_jackal_return";
      break;

    case "ja_spacestation":
      var_01 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_titan":
      var_01 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_wreckage":
      var_01 = "sc_assault_maptrans_jackal_return_seamless";
      break;
  }

  return var_01;
}

func_1356(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = "full";
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = level.var_B8D2 func_7F6B(level.script);
  var_04 = var_03 + 1;
  if(var_03 == level.var_B8D2.var_ABFA.size - 1) {
    var_04 = var_03;
  }

  var_05 = level.player _meth_84C6("lastShipcribMission");
  var_06 = level.player _meth_84C6("lastCompletedMission");
  var_07 = level.var_B8D2.var_ABFA[var_04].var_D845;
  if(isDefined(var_06) && isDefined(var_05) && level.script != "sa_moon") {
    var_08 = strtok(level.script, "_");
    if(var_08.size > 0) {
      if(var_08[0] == "sa" || var_08[0] == "ja") {
        var_04 = func_12A7(var_05);
        if(isDefined(level.var_B8D2.var_ABFA[var_04].var_D846)) {
          var_07 = level.var_B8D2.var_ABFA[var_04].var_D846;
        } else {
          var_07 = level.var_B8D2.var_ABFA[var_04].var_D845;
        }
      }
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_09 = strtok(level.var_FDFA, "_");
    if(var_09.size > 0) {
      if(var_09[0] == "sa" || var_09[0] == "ja") {
        var_04 = func_12A9(level.var_FDFA);
        var_07 = level.var_B8D2.var_ABFA[var_04].var_D845;
      }
    }
  }

  if(param_02) {
    level thread scripts\sp\utility::func_BF98();
  }

  if(getdvarint("fastload", 1) != 0) {
    var_0A = func_7F6D(var_04);
    if(var_0A == "phspace" && getdvarint("e3", 0) == 1) {
      preloadzones([var_0A, "phspace_shared_tr", "phspace_ground_tr", "phspace_ground_lite_tr"]);
    } else {
      switch (param_00) {
        case "full":
          if(isDefined(var_07)) {
            var_0B = scripts\engine\utility::array_add(var_07, var_0A);
            preloadzones(var_0B);
          } else {
            preloadzones(var_0A);
          }
          break;

        case "root":
          preloadzones(var_0A);
          break;

        case "transients":
          if(isDefined(var_07)) {
            preloadzones(var_07);
          }
          break;
      }
    }

    while(!ispreloadzonescomplete()) {
      scripts\engine\utility::waitframe();
    }

    if(param_01) {
      level thread func_1463(var_0A, param_01);
      scripts\engine\utility::flag_wait("weapons_preloaded");
    }
  }

  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

func_1463(param_00, param_01) {
  if(!scripts\engine\utility::flag_exist("weapons_preloaded")) {
    scripts\engine\utility::flag_init("weapons_preloaded");
  } else {
    return;
  }

  if(!isDefined(level.var_D9E5)) {
    scripts\engine\utility::flag_set("weapons_preloaded");
    return;
  }

  if(isDefined(param_01) && !param_01) {
    scripts\engine\utility::flag_set("weapons_preloaded");
  }

  var_02 = ["iw7_g18", "iw7_m4", "iw7_ripper", "iw7_ake"];
  if(!isDefined(param_00)) {
    var_03 = 0;
    var_04 = undefined;
    foreach(var_07, var_06 in level.var_B8D2.var_ABFA) {
      if(var_06.name == level.template_script) {
        var_03 = var_07;
        break;
      }
    }

    if(isDefined(level.var_FDFA)) {
      var_08 = strtok(level.var_FDFA, "_");
      if(var_08.size > 0) {
        if(var_08[0] == "sa" || var_08[0] == "ja") {
          var_04 = func_12A9(level.var_FDFA);
        } else {
          var_04 = var_03 + 1;
        }
      } else {
        var_04 = var_03 + 1;
      }
    } else {
      var_04 = var_03 + 1;
    }

    param_00 = level.var_B8D2.var_ABFA[var_04].name;
  }

  if(scripts\engine\utility::string_starts_with(param_00, "shipcrib")) {
    var_09 = 1;
  } else {
    var_09 = 0;
  }

  if(scripts\engine\utility::string_starts_with(param_00, "ja_")) {
    var_0A = 1;
  } else {
    var_0A = 0;
  }

  var_0B = lib_0A2F::func_DA17();
  var_0C = getaiarray();
  var_0D = [];
  foreach(var_0F in var_0C) {
    var_10 = var_0F.var_394;
    var_10 = getweaponbasename(var_10);
    if(var_10 != "none" && scripts\engine\utility::array_contains(var_0B, var_10)) {
      var_0D = scripts\engine\utility::array_add(var_0D, var_10);
    }
  }

  var_0D = scripts\engine\utility::array_remove_duplicates(var_0D);
  var_12 = lib_0A2F::func_7F7B(level.template_script);
  var_13 = level.var_D9E5["loaded_weapons"];
  var_13 = scripts\engine\utility::array_combine(var_13, var_12);
  var_13 = scripts\engine\utility::array_combine(var_13, var_0D);
  var_13 = scripts\engine\utility::array_remove_duplicates(var_13);
  var_14 = lib_0A2F::func_7BDE(param_00);
  var_15 = lib_0A2F::func_7F7B(param_00);
  var_16 = lib_0A2F::func_DA18(var_14, var_09, 1, var_15, var_0A);
  var_17 = scripts\engine\utility::array_remove_array(var_13, var_16);
  foreach(var_19 in var_13) {
    if(!lib_0A2F::func_9B49(var_19)) {
      var_13 = scripts\engine\utility::array_remove(var_13, var_19);
    }
  }

  var_0B = scripts\engine\utility::array_remove_array(var_0B, var_16);
  foreach(var_19 in var_0B) {
    level.player _meth_84C7("weaponsLoaded", var_19, 0);
  }

  var_1D = [];
  var_1E = [];
  foreach(var_19 in var_16) {
    if(!lib_0A2F::func_9B49(var_19)) {
      continue;
    }

    if(level.template_script != "marscrib") {
      while(var_13.size > 17) {
        if(var_17.size > 0) {
          var_20 = undefined;
          for(var_21 = 0; var_21 < var_17.size; var_21++) {
            if(!scripts\engine\utility::array_contains(var_0D, var_17[var_21])) {
              if(issubstr(scripts\engine\utility::get_template_script_MAYBE(), "crib")) {
                if(!scripts\engine\utility::array_contains(var_02, var_17[var_21])) {
                  var_20 = var_17[var_21];
                  break;
                }

                continue;
              }

              var_20 = var_17[var_21];
              break;
            }
          }

          if(!lib_0A2F::func_9B49(var_20)) {
            var_17 = scripts\engine\utility::array_remove(var_17, var_20);
            continue;
          }

          if(!isDefined(var_20)) {}

          level.player _meth_84C7("weaponsLoaded", var_20, 0);
          var_22 = scripts\engine\utility::weaponclass(var_20);
          foreach(var_24 in level.var_D9E5["loaded_weapon_types"][var_22]) {
            if(var_24.weapon_name == var_20) {
              level.var_D9E5["loaded_weapon_types"][var_22] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapon_types"][var_22], var_24);
            }
          }

          var_13 = scripts\engine\utility::array_remove(var_13, var_20);
          thread scripts\sp\utility::func_1264E("weapon_" + var_20 + "_tr");
          var_1E = scripts\engine\utility::array_add(var_1E, "weapon_" + var_20 + "_tr");
          level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapons"], var_20);
          var_17 = scripts\engine\utility::array_remove(var_17, var_20);
          continue;
        }
      }
    }

    level.player _meth_84C7("weaponsLoaded", var_19, 1);
    if(!scripts\engine\utility::array_contains(var_13, var_19)) {
      var_26 = "weapon_" + var_19 + "_tr";
      if(istransientloaded(var_26)) {
        continue;
      }

      if(!scripts\engine\utility::flag_exist(var_26 + "_loaded")) {
        scripts\engine\utility::flag_init(var_26 + "_loaded");
      }

      loadtransient(var_26);
      var_13 = scripts\engine\utility::array_add(var_13, var_19);
      var_1D = scripts\engine\utility::array_add(var_1D, var_19);
    }
  }

  foreach(var_29 in var_17) {
    if(!lib_0A2F::func_9B49(var_29)) {
      continue;
    }

    var_22 = scripts\engine\utility::weaponclass(var_29);
    foreach(var_24 in level.var_D9E5["loaded_weapon_types"][var_22]) {
      if(var_24.weapon_name == var_29) {
        level.var_D9E5["loaded_weapon_types"][var_22] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapon_types"][var_22], var_24);
      }
    }

    level.player _meth_84C7("weaponsLoaded", var_29, 0);
    level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_remove(level.var_D9E5["loaded_weapons"], var_29);
  }

  level.player _meth_84C7("lastWeaponPreload", param_00);
  for(;;) {
    var_2D = 1;
    foreach(var_19 in var_1D) {
      var_24 = undefined;
      var_22 = undefined;
      var_26 = "weapon_" + var_19 + "_tr";
      if(!istransientloaded(var_26)) {
        var_2D = 0;
        break;
      } else {
        if(lib_0A2F::func_9B49(var_19)) {
          var_24 = spawnStruct();
          var_2F = lib_0A2F::func_7D5F(var_19);
          var_24.var_13C13 = var_2F;
          var_24.weapon_name = var_19;
          var_22 = scripts\engine\utility::weaponclass(var_19);
        }

        if(!scripts\engine\utility::array_contains(level.var_D9E5["loaded_weapons"], var_19)) {
          level.var_D9E5["loaded_weapons"] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapons"], var_19);
          if(isDefined(var_24)) {
            level.var_D9E5["loaded_weapon_types"][var_22] = scripts\engine\utility::array_add(level.var_D9E5["loaded_weapon_types"][var_22], var_24);
          }
        }
      }
    }

    if(var_2D) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("weapons_preloaded");
}

func_1464() {
  var_00 = lib_0A2F::func_DA17();
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = level.player _meth_84C6("weaponsLoaded", var_03);
    if(isDefined(var_04) && !var_04) {
      var_05 = "weapon_" + var_03 + "_tr";
      var_01 = scripts\engine\utility::array_add(var_01, var_05);
      level.player _meth_84C7("weaponsLoaded", var_03, 0);
    }
  }

  scripts\sp\utility::func_12651(var_01);
}

func_1357() {
  if(!isDefined(func_7F6B(level.script)) || !isDefined(func_7F6B(level.script) + 1)) {
    return;
  }

  if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
    scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
  }

  var_00 = func_7F6B(level.script) + 1;
  var_01 = level.script;
  var_02 = level.player _meth_84C6("lastShipcribMission");
  var_03 = undefined;
  if(var_00 < level.var_B8D2.var_ABFA.size) {
    var_03 = level.var_B8D2.var_ABFA[var_00].var_2AD3;
  }

  if(isDefined(var_01) && isDefined(var_02) && level.script != "sa_moon") {
    var_04 = strtok(var_01, "_");
    if(var_04.size > 0) {
      if(var_04[0] == "sa" || var_04[0] == "ja") {
        var_03 = func_12A8(var_01);
      }
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_05 = strtok(level.var_FDFA, "_");
    if(var_05.size > 0) {
      if(var_05[0] == "sa" || var_05[0] == "ja") {
        var_00 = func_12A9(level.var_FDFA);
        var_03 = level.var_B8D2.var_ABFA[var_00].var_2AD3;
      }
    }
  }

  setsaveddvar("bg_cinematicAboveUI", "0");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  stopcinematicingame();
  scripts\engine\utility::waitframe();
  if(!isDefined(var_03)) {
    var_03 = "default";
  }

  cinematicingame(var_03, 1, 1, 1);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("nextmission_transition_bink_primed");
}

func_136A(param_00) {
  scripts\engine\utility::waitframe();
  var_01 = func_7F6B(level.script);
  var_02 = var_01;
  var_03 = level.player _meth_84C6("lastCompletedMission");
  var_04 = level.player _meth_84C6("lastShipcribMission");
  var_05 = level.var_B8D2.var_ABFA[var_02].var_2AD3;
  if(isDefined(var_03) && isDefined(var_04)) {
    var_06 = strtok(var_03, "_");
    if(var_06.size > 0) {
      if(var_06[0] == "sa" || var_06[0] == "ja") {
        var_02 = func_12A7(var_04);
        var_05 = func_12A8(var_03);
      }
    }
  }

  if(getdvar("last_transition_movie", "") == var_05) {
    setdvar("last_transition_movie", "");
    return;
  }

  level func_CCA8(var_05, 0, param_00);
}

func_CCA8(param_00, param_01, param_02, param_03) {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(param_00);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  while(level.player gettimeremainingpercentage() || level.player usebuttonpressed()) {
    scripts\engine\utility::waitframe();
  }

  while(iscinematicplaying() && !level.player gettimeremainingpercentage() && !level.player usebuttonpressed()) {
    scripts\engine\utility::waitframe();
  }

  while(level.player gettimeremainingpercentage() || level.player usebuttonpressed()) {
    scripts\engine\utility::waitframe();
  }

  if(isDefined(param_02)) {
    for(;;) {
      if(!scripts\engine\utility::flag(param_02)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      break;
    }
  }

  level notify("nextmission_bink_finished");
  if(isDefined(param_03)) {
    while(level.script != param_03) {
      scripts\engine\utility::waitframe();
    }
  }

  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  param_01 = param_01 * 0.05;
  level thread scripts\engine\utility::noself_delaycall(param_01, ::stopcinematicingame);
}

func_12F24() {
  var_00 = int(_meth_81D4());
  if(getdvarint("mis_cheat") == 0) {
    level.player _meth_8302("percentCompleteSP", var_00);
  }

  if(var_00 == 100) {
    lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_20");
  }

  return var_00;
}

_meth_81D4() {
  var_00 = _meth_816C(1);
  var_01 = 0.4;
  var_02 = _meth_816C(3);
  var_03 = 0.2;
  var_04 = _meth_816C(4);
  var_05 = 0.1;
  var_06 = _meth_8171();
  var_07 = 0.15;
  var_08 = getweaponammostock();
  var_09 = 0.1;
  var_0A = getvieworigin();
  var_0B = 0.05;
  var_0C = 0;
  var_0C = var_0C + var_01 * var_00;
  var_0C = var_0C + var_03 * var_02;
  var_0C = var_0C + var_05 * var_04;
  var_0C = var_0C + var_07 * var_06;
  var_0C = var_0C + var_0B * var_0A;
  var_0C = var_0C + var_09 * var_08;
  return var_0C;
}

_meth_816C(param_00) {
  var_01 = level.player _meth_8139("missionHighestDifficulty");
  var_02 = 0;
  var_03 = 0;
  var_04 = [];
  var_05 = 0;
  for(var_06 = 0; var_06 < level.var_B8D2.var_ABFA.size; var_06++) {
    if(!func_7F6A(var_06)) {
      continue;
    }

    var_02++;
    if(int(var_01[var_06]) >= param_00) {
      var_03++;
    }
  }

  var_07 = var_03 / var_02 * 100;
  return var_07;
}

_meth_8171() {
  var_00 = lib_0A2F::func_DA17();
  var_00 = scripts\engine\utility::array_remove_array(var_00, lib_0A2F::func_DA0A());
  var_00 = scripts\engine\utility::array_remove_array(var_00, lib_0A2F::func_DA10());
  var_01 = var_00.size;
  var_02 = 0;
  foreach(var_04 in var_00) {
    var_05 = level.player _meth_84C6("weaponsScanned", var_04);
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05 != "locked") {
      var_02++;
    }
  }

  return var_02 / var_01 * 100;
}

getvieworigin() {
  var_00 = lib_0A2F::func_DA08();
  var_01 = 0;
  var_02 = lib_0A2F::func_D9F8();
  foreach(var_04 in var_02) {
    var_05 = level.player _meth_84C6("equipmentState", var_04);
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05 == "upgrade2") {
      var_01 = var_01 + 2;
      continue;
    }

    if(var_05 == "upgrade1") {
      var_01 = var_01 + 1;
    }
  }

  return var_01 / var_00 * 100;
}

getweaponammostock() {
  var_00 = lib_0A2F::func_DA15();
  var_01 = 0;
  var_02 = 0;
  var_03 = func_7F6B("heist");
  var_04 = func_7F69(var_03);
  foreach(var_06 in var_00) {
    var_02++;
    if(tolower(var_06) == "salenkoch" || var_06 == "riah") {
      if(var_04) {
        var_01++;
      }

      continue;
    }

    var_07 = level.player _meth_84C6("wantedBoardDataState", var_06);
    if(!isDefined(var_07)) {
      continue;
    }

    if(var_07 == "obtained" || var_07 == "viewed") {
      var_01++;
    }
  }

  return var_01 / var_02 * 100;
}

func_7F69(param_00) {
  return int(level.player _meth_8139("missionHighestDifficulty")[param_00]);
}

func_F77F(param_00) {
  var_01 = level.player _meth_8139("missionHighestDifficulty");
  var_02 = level.var_7683 + 1;
  if(scripts\sp\utility::func_93AB()) {
    var_02 = 6;
  } else if(scripts\sp\utility::func_93A6()) {
    var_02 = 5;
  }

  var_03 = "";
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    if(var_04 != param_00) {
      var_03 = var_03 + var_01[var_04];
      continue;
    }

    if(var_02 > int(var_01[param_00])) {
      var_03 = var_03 + var_02;
      continue;
    }

    var_03 = var_03 + var_01[var_04];
  }

  func_13CD(var_03);
}

func_13CD(param_00) {
  if(getdvar("mis_cheat") == "1") {
    return;
  }

  level.player _meth_8302("missionHighestDifficulty", param_00);
}

func_41ED() {
  var_00 = level.player _meth_8139("missionHighestDifficulty");
  var_01 = "";
  for(var_02 = 0; var_02 < var_00.size; var_02++) {
    if(int(var_00[var_02]) == 6) {
      var_01 = var_01 + 5;
      continue;
    }

    var_01 = var_01 + var_00[var_02];
  }

  level.player _meth_8302("missionHighestDifficulty", var_01);
}

func_7F6F(param_00) {
  var_01 = level.player _meth_8139("missionHighestDifficulty");
  return int(var_01[param_00]);
}

func_7FBB(param_00) {
  if(param_00 < 9) {
    return "mis_0" + param_00 + 1;
  }

  return "mis_" + param_00 + 1;
}

func_7F89(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = level.player _meth_8139("missionHighestDifficulty");
  var_02 = 4;
  for(var_03 = 0; var_03 < level.var_B8D2.var_ABFA.size; var_03++) {
    if(param_00 && !getinvultime(var_03)) {
      continue;
    }

    if(int(var_01[var_03]) < var_02) {
      var_02 = int(var_01[var_03]);
    }
  }

  return var_02;
}

func_49EF() {
  var_00 = spawnStruct();
  var_00.var_ABFA = [];
  var_00.var_D861 = [];
  return var_00;
}

func_17E9(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = level.var_B8D2.var_ABFA.size;
  level.var_B8D2.var_ABFA[var_0B] = spawnStruct();
  level.var_B8D2.var_ABFA[var_0B].name = param_00;
  level.var_B8D2.var_ABFA[var_0B].var_ABFC = param_01;
  level.var_B8D2.var_ABFA[var_0B].var_A580 = param_02;
  level.var_B8D2.var_ABFA[var_0B].var_1563 = param_03;
  level.var_B8D2.var_ABFA[var_0B].var_4486 = param_04;
  level.var_B8D2.var_ABFA[var_0B].var_2AD3 = param_05;
  level.var_B8D2.var_ABFA[var_0B].var_F88F = param_06;
  level.var_B8D2.var_ABFA[var_0B].var_41F7 = param_07;
  level.var_B8D2.var_ABFA[var_0B].var_E2B2 = param_08;
  level.var_B8D2.var_ABFA[var_0B].var_D845 = param_09;
  level.var_B8D2.var_ABFA[var_0B].var_D846 = param_0A;
}

func_1814(param_00) {
  var_01 = level.var_B8D2.var_D861.size;
  level.var_B8D2.var_D861[var_01] = param_00;
}

func_7F6B(param_00) {
  if(!isDefined(level.var_B8D2) || !isDefined(level.var_B8D2.var_ABFA)) {
    return undefined;
  }

  foreach(var_03, var_02 in level.var_B8D2.var_ABFA) {
    if(var_02.name == param_00) {
      return var_03;
    }
  }

  return undefined;
}

func_7F6D(param_00) {
  return level.var_B8D2.var_ABFA[param_00].name;
}

func_7F31(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_A580;
}

func_7D92(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_1563;
}

func_7F6A(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_4486;
}

getinvultime(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_ABFC == "campaign";
}

getitemslot(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_ABFC == "sc";
}

getitemfromcache(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_ABFC == "sa";
}

getitemdroporiginandangles(param_00) {
  return level.var_B8D2.var_ABFA[param_00].var_ABFC == "ja";
}

func_7EB2(param_00) {
  if(!isDefined(level.var_B8D2.var_ABFA[param_00].var_6AB0)) {
    return undefined;
  }

  return level.var_B8D2.var_ABFA[param_00].var_6AB0;
}

func_8BBF(param_00) {
  if(isDefined(level.var_B8D2.var_ABFA[param_00].var_1563)) {
    return 1;
  }

  return 0;
}

fireweapon(param_00) {
  if(!isDefined(level.var_B8D2)) {
    return undefined;
  }

  var_01 = func_7F6B(param_00);
  if(isDefined(level.var_B8D2.var_ABFA[var_01].var_E2B2)) {
    return level.var_B8D2.var_ABFA[var_01].var_E2B2;
  }
}

func_12B0(param_00) {
  var_01 = func_7F6B(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  return level.var_B8D2.var_ABFA[var_01].var_F88F;
}

func_12AF(param_00) {
  var_01 = func_7F6B(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  return level.var_B8D2.var_ABFA[var_01].var_41F7;
}

func_12B1(param_00) {
  var_01 = func_7F6B(param_00);
  if(!isDefined(var_01)) {
    return "";
  }

  return level.var_B8D2.var_ABFA[var_01].var_2AD3;
}

func_1455(param_00) {
  var_01 = func_12B0(param_00);
  var_02 = func_12AF(param_00);
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  if(!isDefined(var_02)) {
    var_02 = 0;
  } else {
    var_02 = var_02 * 0.02;
  }

  var_03 = var_01 + var_02;
  if(isDefined(var_03)) {
    wait(var_03 * 0.05);
  }

  if(isDefined(var_02) && var_02 <= 0) {
    scripts\engine\utility::waitframe();
    return;
  }

  if(!isDefined(var_01) || var_01 <= 0) {
    scripts\engine\utility::waitframe();
  }
}

func_3DEA(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < level.var_B8D2.var_ABFA.size; var_03++) {
    if(!param_02 && getitemfromcache(var_03) || getitemdroporiginandangles(var_03)) {
      continue;
    }

    if(var_03 == param_00 || !func_7F6A(var_03)) {
      continue;
    }

    if(func_7F69(var_03) < param_01) {
      return 0;
    }
  }

  return 1;
}

func_3DEB(param_00) {
  for(var_01 = 0; var_01 < level.var_B8D2.var_ABFA.size; var_01++) {
    if(var_01 == param_00 || !getitemfromcache(var_01)) {
      continue;
    }

    if(func_7F69(var_01) == 0) {
      return 0;
    }
  }

  return 1;
}

func_3DE8(param_00) {
  for(var_01 = 0; var_01 < level.var_B8D2.var_ABFA.size; var_01++) {
    if(var_01 == param_00 || !getitemdroporiginandangles(var_01)) {
      continue;
    }

    if(func_7F69(var_01) == 0) {
      return 0;
    }
  }

  return 1;
}

func_7FE6() {
  for(var_00 = 0; var_00 < level.var_B8D2.var_ABFA.size; var_00++) {
    if(!func_7F6F(var_00)) {
      return var_00;
    }
  }

  return 0;
}

func_6CD9() {
  if(getdvar("mis_cheat") == "1") {
    return 1;
  }

  var_00 = func_7F6F(func_7F6B("yard"));
  if(!isDefined(var_00)) {
    return 0;
  }

  return var_00;
}

func_725B(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 2;
  }

  var_01 = level.player _meth_8139("missionHighestDifficulty");
  var_02 = "";
  for(var_03 = 0; var_03 < var_01.size; var_03++) {
    var_02 = var_02 + param_00;
  }

  level.player _meth_8302("missionHighestDifficulty", var_02);
  for(var_04 = 0; var_04 < level.var_B8D2.var_ABFA.size; var_04++) {
    var_05 = func_7F6D(var_04);
    level.player _meth_84C7("missionStateData", var_05, "complete");
    level.player _meth_84C7("opsmapMissionStateData", var_05, "complete");
    if(var_04 % 3 == 0) {
      wait(0.05);
    }
  }

  level.player _meth_84C7("lastCompletedMission", "yard");
}

func_4195() {
  level.player _meth_8302("missionHighestDifficulty", "00000000000000000000000000000000000000000000000000");
}