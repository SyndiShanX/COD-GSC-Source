/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\endmission.gsc
*********************************************/

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

func_1355(var_0) {
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
  var_1 = func_7F6B(level.script);
  scripts\sp\gameskill::func_262C("aa_main_" + level.script);
  if(!isDefined(var_1)) {
    missionsuccess(level.script);
    return;
  }

  if(level.script != "shipcrib_epilogue") {
    scripts\sp\utility::func_ABD2();
  }

  func_F77F(var_1);
  scripts\sp\loadout::func_EB5B();
  var_2 = func_12F24();
  lib_0A2F::func_12E18();
  updategamerprofile();
  if(func_8BBF(var_1)) {
    scripts\sp\utility::settimer(func_7D92(var_1));
  }

  if(func_7F6A(var_1)) {
    if(func_3DEA(var_1, 1, 0)) {
      level.player _meth_84C7("unlockedRealism", 1);
      lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_02");
    }

    var_3 = func_7F69(var_1);
    if(var_3 >= 4) {
      if(func_3DEA(var_1, 4, 1)) {
        scripts\sp\utility::settimer("VETERAN");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_21");
      }
    }

    if(var_3 >= 5) {
      if(func_3DEA(var_1, 5, 0)) {
        level.player _meth_84C7("beatRealism", 1);
        lib_0A2F::func_EBB7("iw7_m1");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_22");
      }
    }

    if(var_3 == 6) {
      if(func_3DEA(var_1, 6, 0)) {
        level.player _meth_84C7("beatRealism", 1);
        lib_0A2F::func_EBB7("iw7_m1");
        lib_0A2F::func_EBB7("iw7_ake_gold");
        lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_22");
      }
    }
  }

  if(getitemfromcache(var_1) && func_3DEB(var_1)) {
    scripts\sp\utility::settimer("ALL_SA");
  }

  if(getitemdroporiginandangles(var_1) && func_3DE8(var_1)) {
    scripts\sp\utility::settimer("ALL_JA");
  }

  level.player scripts\sp\analytics::func_B8CE(level.script);
  if(level.script == "shipcrib_epilogue") {
    changelevel("", 0);
    var_4 = level.player _meth_84C6("missionStateData", "ja_mining");
    var_5 = level.player _meth_84C6("missionStateData", "ja_titan");
    if(isDefined(var_4) && var_4 == "locked") {
      level.player _meth_84C7("missionStateData", "ja_mining", "incomplete");
    }

    if(isDefined(var_5) && var_5 == "locked") {
      level.player _meth_84C7("missionStateData", "ja_titan", "incomplete");
    }

    return;
  }

  var_6 = var_4 + 1;
  var_7 = level.script;
  var_8 = level.player _meth_84C6("lastShipcribMission");
  var_9 = undefined;
  if(var_6 < level.var_B8D2.var_ABFA.size) {
    var_9 = level.var_B8D2.var_ABFA[var_6].var_2AD3;
  }

  if(isDefined(var_8) && level.script != "sa_moon") {
    if(getitemfromcache(var_4) || getitemdroporiginandangles(var_4)) {
      var_6 = func_12A7(var_8);
      var_9 = func_12A8(var_7);
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_0A = strtok(level.var_FDFA, "_");
    if(var_0A.size > 0) {
      if(var_0A[0] == "sa" || var_0A[0] == "ja") {
        var_6 = func_12A9(level.var_FDFA);
        var_9 = level.var_B8D2.var_ABFA[var_6].var_2AD3;
      }
    }
  }

  if(isDefined(var_9)) {
    setdvar("last_transition_movie", var_9);
    if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
      scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
    }

    if(!isDefined(var_2)) {
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
      cinematicingame(var_9, 0, 1, 1);
    }
  }

  level.player _meth_84C7("missionStateData", level.script, "complete");
  level.player _meth_84C7("opsmapMissionStateData", level.script, "complete");
  level.player _meth_84C7("lastCompletedMission", level.script);
  level.player _meth_84C7("currentLoadout", "levelCreated", var_6);
  var_0C = func_7F6D(var_6);
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

  if(isDefined(var_2)) {
    wait(var_2);
    setomnvar("ui_hide_hud", 1);
  }

  if(isDefined(func_7EB2(var_4))) {
    changelevel(func_7F6D(var_6), func_7F31(var_4), func_7EB2(var_4));
    return;
  }

  changelevel(func_7F6D(var_6), func_7F31(var_4));
}

func_12A9(var_0) {
  var_1 = 22;
  switch (var_0) {
    case "sa_assassination":
      var_1 = 23;
      break;

    case "sa_empambush":
      var_1 = 24;
      break;

    case "sa_vips":
      var_1 = 25;
      break;

    case "sa_wounded":
      var_1 = 26;
      break;

    case "ja_asteroid":
      var_1 = 27;
      break;

    case "ja_mining":
      var_1 = 28;
      break;

    case "ja_spacestation":
      var_1 = 29;
      break;

    case "ja_titan":
      var_1 = 30;
      break;

    case "ja_wreckage":
      var_1 = 31;
      break;
  }

  return var_1;
}

func_12A7(var_0) {
  var_1 = 9;
  switch (var_0) {
    case "shipcrib_moon":
      var_1 = 8;
      break;

    case "shipcrib_europa":
      var_1 = 9;
      break;

    case "shipcrib_titan":
      var_1 = 9;
      break;

    case "shipcrib_rogue":
      var_1 = 12;
      break;

    case "shipcrib_prisoner":
      var_1 = 14;
      break;
  }

  return var_1;
}

func_12A8(var_0) {
  var_1 = "sc_assault_maptrans_jackal_return_seamless";
  switch (var_0) {
    case "sa_assassination":
      var_1 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "sa_vips":
      var_1 = "sc_assault_maptrans_jackal_return";
      break;

    case "sa_empambush":
      var_1 = "sc_assault_empambush_blackout";
      break;

    case "sa_wounded":
      var_1 = "sc_assault_maptrans_jackal_return";
      break;

    case "ja_asteroid":
      var_1 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_mining":
      var_1 = "sc_assault_maptrans_jackal_return";
      break;

    case "ja_spacestation":
      var_1 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_titan":
      var_1 = "sc_assault_maptrans_jackal_return_seamless";
      break;

    case "ja_wreckage":
      var_1 = "sc_assault_maptrans_jackal_return_seamless";
      break;
  }

  return var_1;
}

func_1356(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = "full";
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = level.var_B8D2 func_7F6B(level.script);
  var_4 = var_3 + 1;
  if(var_3 == level.var_B8D2.var_ABFA.size - 1) {
    var_4 = var_3;
  }

  var_5 = level.player _meth_84C6("lastShipcribMission");
  var_6 = level.player _meth_84C6("lastCompletedMission");
  var_7 = level.var_B8D2.var_ABFA[var_4].var_D845;
  if(isDefined(var_6) && isDefined(var_5) && level.script != "sa_moon") {
    var_8 = strtok(level.script, "_");
    if(var_8.size > 0) {
      if(var_8[0] == "sa" || var_8[0] == "ja") {
        var_4 = func_12A7(var_5);
        if(isDefined(level.var_B8D2.var_ABFA[var_4].var_D846)) {
          var_7 = level.var_B8D2.var_ABFA[var_4].var_D846;
        } else {
          var_7 = level.var_B8D2.var_ABFA[var_4].var_D845;
        }
      }
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_9 = strtok(level.var_FDFA, "_");
    if(var_9.size > 0) {
      if(var_9[0] == "sa" || var_9[0] == "ja") {
        var_4 = func_12A9(level.var_FDFA);
        var_7 = level.var_B8D2.var_ABFA[var_4].var_D845;
      }
    }
  }

  if(var_2) {
    level thread scripts\sp\utility::func_BF98();
  }

  if(getdvarint("fastload", 1) != 0) {
    var_0A = func_7F6D(var_4);
    if(var_0A == "phspace" && getdvarint("e3", 0) == 1) {
      preloadzones([var_0A, "phspace_shared_tr", "phspace_ground_tr", "phspace_ground_lite_tr"]);
    } else {
      switch (var_0) {
        case "full":
          if(isDefined(var_7)) {
            var_0B = scripts\engine\utility::array_add(var_7, var_0A);
            preloadzones(var_0B);
          } else {
            preloadzones(var_0A);
          }
          break;

        case "root":
          preloadzones(var_0A);
          break;

        case "transients":
          if(isDefined(var_7)) {
            preloadzones(var_7);
          }
          break;
      }
    }

    while(!ispreloadzonescomplete()) {
      scripts\engine\utility::waitframe();
    }

    if(var_1) {
      level thread func_1463(var_0A, var_1);
      scripts\engine\utility::flag_wait("weapons_preloaded");
    }
  }

  scripts\engine\utility::flag_set("nextmission_preload_complete");
}

func_1463(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("weapons_preloaded")) {
    scripts\engine\utility::flag_init("weapons_preloaded");
  } else {
    return;
  }

  if(!isDefined(level.var_D9E5)) {
    scripts\engine\utility::flag_set("weapons_preloaded");
    return;
  }

  if(isDefined(var_1) && !var_1) {
    scripts\engine\utility::flag_set("weapons_preloaded");
  }

  var_2 = ["iw7_g18", "iw7_m4", "iw7_ripper", "iw7_ake"];
  if(!isDefined(var_0)) {
    var_3 = 0;
    var_4 = undefined;
    foreach(var_7, var_6 in level.var_B8D2.var_ABFA) {
      if(var_6.name == level.template_script) {
        var_3 = var_7;
        break;
      }
    }

    if(isDefined(level.var_FDFA)) {
      var_8 = strtok(level.var_FDFA, "_");
      if(var_8.size > 0) {
        if(var_8[0] == "sa" || var_8[0] == "ja") {
          var_4 = func_12A9(level.var_FDFA);
        } else {
          var_4 = var_3 + 1;
        }
      } else {
        var_4 = var_3 + 1;
      }
    } else {
      var_4 = var_3 + 1;
    }

    var_0 = level.var_B8D2.var_ABFA[var_4].name;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "shipcrib")) {
    var_9 = 1;
  } else {
    var_9 = 0;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "ja_")) {
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
  var_14 = lib_0A2F::func_7BDE(var_0);
  var_15 = lib_0A2F::func_7F7B(var_0);
  var_16 = lib_0A2F::func_DA18(var_14, var_9, 1, var_15, var_0A);
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
                if(!scripts\engine\utility::array_contains(var_2, var_17[var_21])) {
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

  level.player _meth_84C7("lastWeaponPreload", var_0);
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
  var_0 = lib_0A2F::func_DA17();
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = level.player _meth_84C6("weaponsLoaded", var_3);
    if(isDefined(var_4) && !var_4) {
      var_5 = "weapon_" + var_3 + "_tr";
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
      level.player _meth_84C7("weaponsLoaded", var_3, 0);
    }
  }

  scripts\sp\utility::func_12651(var_1);
}

func_1357() {
  if(!isDefined(func_7F6B(level.script)) || !isDefined(func_7F6B(level.script) + 1)) {
    return;
  }

  if(!scripts\engine\utility::flag_exist("nextmission_transition_bink_primed")) {
    scripts\engine\utility::flag_init("nextmission_transition_bink_primed");
  }

  var_0 = func_7F6B(level.script) + 1;
  var_1 = level.script;
  var_2 = level.player _meth_84C6("lastShipcribMission");
  var_3 = undefined;
  if(var_0 < level.var_B8D2.var_ABFA.size) {
    var_3 = level.var_B8D2.var_ABFA[var_0].var_2AD3;
  }

  if(isDefined(var_1) && isDefined(var_2) && level.script != "sa_moon") {
    var_4 = strtok(var_1, "_");
    if(var_4.size > 0) {
      if(var_4[0] == "sa" || var_4[0] == "ja") {
        var_3 = func_12A8(var_1);
      }
    }
  }

  if(isDefined(level.var_FDFA)) {
    var_5 = strtok(level.var_FDFA, "_");
    if(var_5.size > 0) {
      if(var_5[0] == "sa" || var_5[0] == "ja") {
        var_0 = func_12A9(level.var_FDFA);
        var_3 = level.var_B8D2.var_ABFA[var_0].var_2AD3;
      }
    }
  }

  setsaveddvar("bg_cinematicAboveUI", "0");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  stopcinematicingame();
  scripts\engine\utility::waitframe();
  if(!isDefined(var_3)) {
    var_3 = "default";
  }

  cinematicingame(var_3, 1, 1, 1);
  while(!iscinematicplaying()) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("nextmission_transition_bink_primed");
}

func_136A(var_0) {
  scripts\engine\utility::waitframe();
  var_1 = func_7F6B(level.script);
  var_2 = var_1;
  var_3 = level.player _meth_84C6("lastCompletedMission");
  var_4 = level.player _meth_84C6("lastShipcribMission");
  var_5 = level.var_B8D2.var_ABFA[var_2].var_2AD3;
  if(isDefined(var_3) && isDefined(var_4)) {
    var_6 = strtok(var_3, "_");
    if(var_6.size > 0) {
      if(var_6[0] == "sa" || var_6[0] == "ja") {
        var_2 = func_12A7(var_4);
        var_5 = func_12A8(var_3);
      }
    }
  }

  if(getdvar("last_transition_movie", "") == var_5) {
    setdvar("last_transition_movie", "");
    return;
  }

  level func_CCA8(var_5, 0, var_0);
}

func_CCA8(var_0, var_1, var_2, var_3) {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_0);
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

  if(isDefined(var_2)) {
    for(;;) {
      if(!scripts\engine\utility::flag(var_2)) {
        scripts\engine\utility::waitframe();
        continue;
      }

      break;
    }
  }

  level notify("nextmission_bink_finished");
  if(isDefined(var_3)) {
    while(level.script != var_3) {
      scripts\engine\utility::waitframe();
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_1 = var_1 * 0.05;
  level thread scripts\engine\utility::noself_delaycall(var_1, ::stopcinematicingame);
}

func_12F24() {
  var_0 = int(_meth_81D4());
  if(getdvarint("mis_cheat") == 0) {
    level.player _meth_8302("percentCompleteSP", var_0);
  }

  if(var_0 == 100) {
    lib_0A2F::func_EBB3("veh_mil_air_un_jackal_livery_shell_20");
  }

  return var_0;
}

_meth_81D4() {
  var_0 = _meth_816C(1);
  var_1 = 0.4;
  var_2 = _meth_816C(3);
  var_3 = 0.2;
  var_4 = _meth_816C(4);
  var_5 = 0.1;
  var_6 = _meth_8171();
  var_7 = 0.15;
  var_8 = getweaponammostock();
  var_9 = 0.1;
  var_0A = getvieworigin();
  var_0B = 0.05;
  var_0C = 0;
  var_0C = var_0C + var_1 * var_0;
  var_0C = var_0C + var_3 * var_2;
  var_0C = var_0C + var_5 * var_4;
  var_0C = var_0C + var_7 * var_6;
  var_0C = var_0C + var_0B * var_0A;
  var_0C = var_0C + var_9 * var_8;
  return var_0C;
}

_meth_816C(var_0) {
  var_1 = level.player _meth_8139("missionHighestDifficulty");
  var_2 = 0;
  var_3 = 0;
  var_4 = [];
  var_5 = 0;
  for(var_6 = 0; var_6 < level.var_B8D2.var_ABFA.size; var_6++) {
    if(!func_7F6A(var_6)) {
      continue;
    }

    var_2++;
    if(int(var_1[var_6]) >= var_0) {
      var_3++;
    }
  }

  var_7 = var_3 / var_2 * 100;
  return var_7;
}

_meth_8171() {
  var_0 = lib_0A2F::func_DA17();
  var_0 = scripts\engine\utility::array_remove_array(var_0, lib_0A2F::func_DA0A());
  var_0 = scripts\engine\utility::array_remove_array(var_0, lib_0A2F::func_DA10());
  var_1 = var_0.size;
  var_2 = 0;
  foreach(var_4 in var_0) {
    var_5 = level.player _meth_84C6("weaponsScanned", var_4);
    if(!isDefined(var_5)) {
      continue;
    }

    if(var_5 != "locked") {
      var_2++;
    }
  }

  return var_2 / var_1 * 100;
}

getvieworigin() {
  var_0 = lib_0A2F::func_DA08();
  var_1 = 0;
  var_2 = lib_0A2F::func_D9F8();
  foreach(var_4 in var_2) {
    var_5 = level.player _meth_84C6("equipmentState", var_4);
    if(!isDefined(var_5)) {
      continue;
    }

    if(var_5 == "upgrade2") {
      var_1 = var_1 + 2;
      continue;
    }

    if(var_5 == "upgrade1") {
      var_1 = var_1 + 1;
    }
  }

  return var_1 / var_0 * 100;
}

getweaponammostock() {
  var_0 = lib_0A2F::func_DA15();
  var_1 = 0;
  var_2 = 0;
  var_3 = func_7F6B("heist");
  var_4 = func_7F69(var_3);
  foreach(var_6 in var_0) {
    var_2++;
    if(tolower(var_6) == "salenkoch" || var_6 == "riah") {
      if(var_4) {
        var_1++;
      }

      continue;
    }

    var_7 = level.player _meth_84C6("wantedBoardDataState", var_6);
    if(!isDefined(var_7)) {
      continue;
    }

    if(var_7 == "obtained" || var_7 == "viewed") {
      var_1++;
    }
  }

  return var_1 / var_2 * 100;
}

func_7F69(var_0) {
  return int(level.player _meth_8139("missionHighestDifficulty")[var_0]);
}

func_F77F(var_0) {
  var_1 = level.player _meth_8139("missionHighestDifficulty");
  var_2 = level.var_7683 + 1;
  if(scripts\sp\utility::func_93AB()) {
    var_2 = 6;
  } else if(scripts\sp\utility::func_93A6()) {
    var_2 = 5;
  }

  var_3 = "";
  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_4 != var_0) {
      var_3 = var_3 + var_1[var_4];
      continue;
    }

    if(var_2 > int(var_1[var_0])) {
      var_3 = var_3 + var_2;
      continue;
    }

    var_3 = var_3 + var_1[var_4];
  }

  func_13CD(var_3);
}

func_13CD(var_0) {
  if(getdvar("mis_cheat") == "1") {
    return;
  }

  level.player _meth_8302("missionHighestDifficulty", var_0);
}

func_41ED() {
  var_0 = level.player _meth_8139("missionHighestDifficulty");
  var_1 = "";
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(int(var_0[var_2]) == 6) {
      var_1 = var_1 + 5;
      continue;
    }

    var_1 = var_1 + var_0[var_2];
  }

  level.player _meth_8302("missionHighestDifficulty", var_1);
}

func_7F6F(var_0) {
  var_1 = level.player _meth_8139("missionHighestDifficulty");
  return int(var_1[var_0]);
}

func_7FBB(var_0) {
  if(var_0 < 9) {
    return "mis_0" + var_0 + 1;
  }

  return "mis_" + var_0 + 1;
}

func_7F89(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = level.player _meth_8139("missionHighestDifficulty");
  var_2 = 4;
  for(var_3 = 0; var_3 < level.var_B8D2.var_ABFA.size; var_3++) {
    if(var_0 && !getinvultime(var_3)) {
      continue;
    }

    if(int(var_1[var_3]) < var_2) {
      var_2 = int(var_1[var_3]);
    }
  }

  return var_2;
}

func_49EF() {
  var_0 = spawnStruct();
  var_0.var_ABFA = [];
  var_0.var_D861 = [];
  return var_0;
}

func_17E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A) {
  var_0B = level.var_B8D2.var_ABFA.size;
  level.var_B8D2.var_ABFA[var_0B] = spawnStruct();
  level.var_B8D2.var_ABFA[var_0B].name = var_0;
  level.var_B8D2.var_ABFA[var_0B].var_ABFC = var_1;
  level.var_B8D2.var_ABFA[var_0B].var_A580 = var_2;
  level.var_B8D2.var_ABFA[var_0B].var_1563 = var_3;
  level.var_B8D2.var_ABFA[var_0B].var_4486 = var_4;
  level.var_B8D2.var_ABFA[var_0B].var_2AD3 = var_5;
  level.var_B8D2.var_ABFA[var_0B].var_F88F = var_6;
  level.var_B8D2.var_ABFA[var_0B].var_41F7 = var_7;
  level.var_B8D2.var_ABFA[var_0B].var_E2B2 = var_8;
  level.var_B8D2.var_ABFA[var_0B].var_D845 = var_9;
  level.var_B8D2.var_ABFA[var_0B].var_D846 = var_0A;
}

func_1814(var_0) {
  var_1 = level.var_B8D2.var_D861.size;
  level.var_B8D2.var_D861[var_1] = var_0;
}

func_7F6B(var_0) {
  if(!isDefined(level.var_B8D2) || !isDefined(level.var_B8D2.var_ABFA)) {
    return undefined;
  }

  foreach(var_3, var_2 in level.var_B8D2.var_ABFA) {
    if(var_2.name == var_0) {
      return var_3;
    }
  }

  return undefined;
}

func_7F6D(var_0) {
  return level.var_B8D2.var_ABFA[var_0].name;
}

func_7F31(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_A580;
}

func_7D92(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_1563;
}

func_7F6A(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_4486;
}

getinvultime(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_ABFC == "campaign";
}

getitemslot(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_ABFC == "sc";
}

getitemfromcache(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_ABFC == "sa";
}

getitemdroporiginandangles(var_0) {
  return level.var_B8D2.var_ABFA[var_0].var_ABFC == "ja";
}

func_7EB2(var_0) {
  if(!isDefined(level.var_B8D2.var_ABFA[var_0].var_6AB0)) {
    return undefined;
  }

  return level.var_B8D2.var_ABFA[var_0].var_6AB0;
}

func_8BBF(var_0) {
  if(isDefined(level.var_B8D2.var_ABFA[var_0].var_1563)) {
    return 1;
  }

  return 0;
}

fireweapon(var_0) {
  if(!isDefined(level.var_B8D2)) {
    return undefined;
  }

  var_1 = func_7F6B(var_0);
  if(isDefined(level.var_B8D2.var_ABFA[var_1].var_E2B2)) {
    return level.var_B8D2.var_ABFA[var_1].var_E2B2;
  }
}

func_12B0(var_0) {
  var_1 = func_7F6B(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return level.var_B8D2.var_ABFA[var_1].var_F88F;
}

func_12AF(var_0) {
  var_1 = func_7F6B(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return level.var_B8D2.var_ABFA[var_1].var_41F7;
}

func_12B1(var_0) {
  var_1 = func_7F6B(var_0);
  if(!isDefined(var_1)) {
    return "";
  }

  return level.var_B8D2.var_ABFA[var_1].var_2AD3;
}

func_1455(var_0) {
  var_1 = func_12B0(var_0);
  var_2 = func_12AF(var_0);
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  } else {
    var_2 = var_2 * 0.02;
  }

  var_3 = var_1 + var_2;
  if(isDefined(var_3)) {
    wait(var_3 * 0.05);
  }

  if(isDefined(var_2) && var_2 <= 0) {
    scripts\engine\utility::waitframe();
    return;
  }

  if(!isDefined(var_1) || var_1 <= 0) {
    scripts\engine\utility::waitframe();
  }
}

func_3DEA(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.var_B8D2.var_ABFA.size; var_3++) {
    if(!var_2 && getitemfromcache(var_3) || getitemdroporiginandangles(var_3)) {
      continue;
    }

    if(var_3 == var_0 || !func_7F6A(var_3)) {
      continue;
    }

    if(func_7F69(var_3) < var_1) {
      return 0;
    }
  }

  return 1;
}

func_3DEB(var_0) {
  for(var_1 = 0; var_1 < level.var_B8D2.var_ABFA.size; var_1++) {
    if(var_1 == var_0 || !getitemfromcache(var_1)) {
      continue;
    }

    if(func_7F69(var_1) == 0) {
      return 0;
    }
  }

  return 1;
}

func_3DE8(var_0) {
  for(var_1 = 0; var_1 < level.var_B8D2.var_ABFA.size; var_1++) {
    if(var_1 == var_0 || !getitemdroporiginandangles(var_1)) {
      continue;
    }

    if(func_7F69(var_1) == 0) {
      return 0;
    }
  }

  return 1;
}

func_7FE6() {
  for(var_0 = 0; var_0 < level.var_B8D2.var_ABFA.size; var_0++) {
    if(!func_7F6F(var_0)) {
      return var_0;
    }
  }

  return 0;
}

func_6CD9() {
  if(getdvar("mis_cheat") == "1") {
    return 1;
  }

  var_0 = func_7F6F(func_7F6B("yard"));
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0;
}

func_725B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  var_1 = level.player _meth_8139("missionHighestDifficulty");
  var_2 = "";
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2 = var_2 + var_0;
  }

  level.player _meth_8302("missionHighestDifficulty", var_2);
  for(var_4 = 0; var_4 < level.var_B8D2.var_ABFA.size; var_4++) {
    var_5 = func_7F6D(var_4);
    level.player _meth_84C7("missionStateData", var_5, "complete");
    level.player _meth_84C7("opsmapMissionStateData", var_5, "complete");
    if(var_4 % 3 == 0) {
      wait(0.05);
    }
  }

  level.player _meth_84C7("lastCompletedMission", "yard");
}

func_4195() {
  level.player _meth_8302("missionHighestDifficulty", "00000000000000000000000000000000000000000000000000");
}