/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3502.gsc
**************************************/

init() {
  level.var_114DD = loadfx("vfx\props\barrelexp.vfx");
  level.var_114DC = loadfx("vfx\core\expl\large_vehicle_explosion.vfx");
  level.var_114DE = loadfx("vfx\core\muzflash\ac130_105mm");
  level.var_114DA = loadfx("vfx\core\smktrail\ground_smoke_launch_a");
  level.var_114DB = loadfx("vfx\core\smktrail\ground_smoke_launch_a");
  level.var_8638 = [];
  level.var_8638["mp_alpha"][0]["origin"] = (-2748.91, 2921.33, 125.394);
  level.var_8638["mp_alpha"][0]["angles"] = (0, 16, 0);
  level.var_8638["mp_alpha"][1]["origin"] = (707.795, -499.191, -7.875);
  level.var_8638["mp_alpha"][1]["angles"] = (0, 90, 0);
  level.var_8638["mp_alpha"][2]["origin"] = (81.8557, 2343.87, -7.875);
  level.var_8638["mp_alpha"][2]["angles"] = (0, -90.1, 0);
  level.var_8638["mp_bravo"][0]["origin"] = (-761.529, 1221.7, 1212.13);
  level.var_8638["mp_bravo"][0]["angles"] = (0, -92.373, 0);
  level.var_8638["mp_bravo"][1]["origin"] = (1474.99, 971.865, 1140.13);
  level.var_8638["mp_bravo"][1]["angles"] = (0, -178.401, 0);
  level.var_8638["mp_bravo"][2]["origin"] = (-1366.57, -370.995, 975.807);
  level.var_8638["mp_bravo"][2]["angles"] = (0, 0.807495, 0);
  level.var_8638["mp_dome"][0]["origin"] = (960.279, -482.564, -388.872);
  level.var_8638["mp_dome"][0]["angles"] = (0, 100.536, 0);
  level.var_8638["mp_dome"][1]["origin"] = (-921.941, 166.449, -418.131);
  level.var_8638["mp_dome"][1]["angles"] = (0, 25.4524, 0);
  level.var_8638["mp_dome"][2]["origin"] = (43.3564, 2102.85, -290.875);
  level.var_8638["mp_dome"][2]["angles"] = (0, -95.0347, 0);
  level.var_8638["mp_plaza2"][0]["origin"] = (-1579.34, -2349.41, 556.125);
  level.var_8638["mp_plaza2"][0]["angles"] = (0, 5.32288, 0);
  level.var_8638["mp_plaza2"][1]["origin"] = (-135.286, 1622.04, 607.13);
  level.var_8638["mp_plaza2"][1]["angles"] = (0, 173.639, 0);
  level.var_8638["mp_plaza2"][2]["origin"] = (-1544.55, 1966.84, 632.024);
  level.var_8638["mp_plaza2"][2]["angles"] = (0, 0.796509, 0);
  level.var_8638["mp_radar"][0]["origin"] = (896.685, 2692.74, 1208.13);
  level.var_8638["mp_radar"][0]["angles"] = (0, -178.313, 0);
  level.var_8638["mp_radar"][1]["origin"] = (-2455.87, 1564.41, 1308.9);
  level.var_8638["mp_radar"][1]["angles"] = (0, 1.93471, 0);
  level.var_8638["mp_radar"][2]["origin"] = (1609, -1098.99, 1162.13);
  level.var_8638["mp_radar"][2]["angles"] = (0, 170.421, 0);
  level.var_8638["mp_interchange"][0]["origin"] = (-2067.08, 1218.17, -82.0487);
  level.var_8638["mp_interchange"][0]["angles"] = (0, -26.2946, 0);
  level.var_8638["mp_interchange"][1]["origin"] = (-1198.2, -1782.62, 103.665);
  level.var_8638["mp_interchange"][1]["angles"] = (0, 23.3544, 0);
  level.var_8638["mp_interchange"][2]["origin"] = (2391.95, 899.034, 87.7839);
  level.var_8638["mp_interchange"][2]["angles"] = (0, -136.134, 0);
  level.var_8638["mp_lambeth"][0]["origin"] = (1641.37, -1318.01, -260.173);
  level.var_8638["mp_lambeth"][0]["angles"] = (0, 133.329, 0);
  level.var_8638["mp_lambeth"][1]["origin"] = (-1346.56, -880.226, -191.875);
  level.var_8638["mp_lambeth"][1]["angles"] = (0, 0.432892, 0);
  level.var_8638["mp_lambeth"][2]["origin"] = (1403.95, 3083.4, -287.354);
  level.var_8638["mp_lambeth"][2]["angles"] = (0, -106.321, 0);
  level.var_8638["mp_paris"][0]["origin"] = (-2427.42, 619.217, 188.826);
  level.var_8638["mp_paris"][0]["angles"] = (0, -2.90588, 0);
  level.var_8638["mp_paris"][1]["origin"] = (2066.95, 796.542, -88.322);
  level.var_8638["mp_paris"][1]["angles"] = (0, 177.292, 0);
  level.var_8638["mp_paris"][2]["origin"] = (506.406, -2165.36, -64.1201);
  level.var_8638["mp_paris"][2]["angles"] = (0, 89.5715, 0);
  level.var_8638["mp_hardhat"][0]["origin"] = (2033.65, -1428.62, 299.86);
  level.var_8638["mp_hardhat"][0]["angles"] = (0, 177.979, 0);
  level.var_8638["mp_hardhat"][1]["origin"] = (-1044.73, 82.9179, 181.022);
  level.var_8638["mp_hardhat"][1]["angles"] = (0, -2.68066, 0);
  level.var_8638["mp_hardhat"][2]["origin"] = (1248.95, 1322.56, 304.125);
  level.var_8638["mp_hardhat"][2]["angles"] = (0, -93.4772, 0);
  level.var_8638["mp_carbon"][0]["origin"] = (-47.1408, -2841.26, 3940.01);
  level.var_8638["mp_carbon"][0]["angles"] = (0, -101.667, 0);
  level.var_8638["mp_carbon"][1]["origin"] = (-1686.2, -4727.09, 3756.16);
  level.var_8638["mp_carbon"][1]["angles"] = (0, 87.6436, 0);
  level.var_8638["mp_carbon"][2]["origin"] = (-3761.18, -3716.69, 3568.91);
  level.var_8638["mp_carbon"][2]["angles"] = (0, -4.20761, 0);
  level.var_8638["mp_seatown"][0]["origin"] = (1339.87, 763.592, 175.114);
  level.var_8638["mp_seatown"][0]["angles"] = (0, 178.551, 0);
  level.var_8638["mp_seatown"][1]["origin"] = (1317.92, -725.589, 232.125);
  level.var_8638["mp_seatown"][1]["angles"] = (0, 177.738, 0);
  level.var_8638["mp_seatown"][2]["origin"] = (-961.699, -1581.56, 144.125);
  level.var_8638["mp_seatown"][2]["angles"] = (0, 90.0176, 0);
  level.var_8638["mp_bootleg"][0]["origin"] = (-988.964, 1833.74, -99.9509);
  level.var_8638["mp_bootleg"][0]["angles"] = (0, -78.8909, 0);
  level.var_8638["mp_bootleg"][1]["origin"] = (1105.84, -1116.13, -72.3048);
  level.var_8638["mp_bootleg"][1]["angles"] = (0, 176.558, 0);
  level.var_8638["mp_bootleg"][2]["origin"] = (-2027.31, 84.2235, -51.875);
  level.var_8638["mp_bootleg"][2]["angles"] = (0, -5.12868, 0);
  level.var_8638["mp_meteora"][0]["origin"] = (-590.972, 1667.65, -99.6187);
  level.var_8638["mp_meteora"][0]["angles"] = (0, -89.7745, 0);
  level.var_8638["mp_meteora"][1]["origin"] = (-1371.02, -1095.66, 4.125);
  level.var_8638["mp_meteora"][1]["angles"] = (0, 179.879, 0);
  level.var_8638["mp_meteora"][2]["origin"] = (938.851, -1376.99, -60.0877);
  level.var_8638["mp_meteora"][2]["angles"] = (0, 110.545, 0);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("mobile_mortar", ::func_128EF);
}

func_128EF(var_0, var_1) {
  if(!isDefined(level.var_8638[level.script])) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LEVEL");
    return 0;
  }

  if(isDefined(self.laststand) && !scripts\mp\utility\game::_hasperk("specialty_finalstand")) {
    self iprintlnbold(&"KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");
    return 0;
  } else if(isDefined(level.var_B8F4)) {
    self iprintlnbold(&"KILLSTREAKS_GROUND_APPROACHES_TOO_CROWDED");
    return 0;
  } else if(scripts\mp\utility\game::isusingremote())
    return 0;

  var_2 = func_F1C4();

  if(!isDefined(var_2)) {
    return 0;
  } else {
    thread scripts\mp\utility\game::func_11079(0);
  }

  var_3 = func_49F1(self, var_2);

  if(!isDefined(var_3)) {
    return 0;
  }

  var_3 thread func_BD1E("entrance");
  return 1;
}

func_F1C4() {
  var_0 = undefined;

  for(;;) {
    thread func_1012E();
    scripts\mp\utility\game::_beginlocationselection("mobile_mortar", "map_artillery_selector", 0, 500);
    self endon("stop_location_selection");
    self waittill("confirm_location", var_1);

    for(var_2 = 0; var_2 < 3; var_2++) {
      var_3 = level.var_8638[level.script][var_2]["origin"] * (1, 1, 0);
      var_4 = distancesquared(var_1, var_3);

      if(var_4 < 60000) {
        var_0 = var_2;
        break;
      }
    }

    if(isDefined(var_0)) {
      for(var_2 = 0; var_2 < 3; var_2++) {
        if(self.locationobjectives[var_2] != -1) {
          if(var_2 == var_0) {
            scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_2], "compass_objpoint_mortar_target");
            continue;
          }

          scripts\mp\objidpoolmanager::minimap_objective_state(self.locationobjectives[var_2], "invisible");
        }
      }
    } else {
      for(var_2 = 0; var_2 < 3; var_2++) {
        if(self.locationobjectives[var_2] != -1) {
          scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_2], "compass_objpoint_tank_enemy");
        }
      }
    }

    wait 0.5;
    self notify("picked_location");
    wait 0.05;

    if(isDefined(var_0)) {
      break;
    }
  }

  return var_0;
}

func_1012E() {
  var_0 = scripts\mp\hud_util::createfontstring("bigfixed", 0.5);
  var_0 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  var_0 give_zap_perk(&"KILLSTREAKS_SELECT_MOBILE_MORTAR_LOCATION");
  self.locationobjectives = [];

  for(var_1 = 0; var_1 < 3; var_1++) {
    self.locationobjectives[var_1] = scripts\mp\objidpoolmanager::requestminimapid(1);

    if(self.locationobjectives[var_1] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(self.locationobjectives[var_1], "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(self.locationobjectives[var_1], level.var_8638[level.script][var_1]["origin"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(self.locationobjectives[var_1], "active");
      scripts\mp\objidpoolmanager::minimap_objective_team(self.locationobjectives[var_1], self.team);
      scripts\mp\objidpoolmanager::minimap_objective_icon(self.locationobjectives[var_1], "compass_objpoint_tank_friendly");
    }
  }

  scripts\engine\utility::waittill_any("cancel_location", "picked_location", "stop_location_selection");
  var_0 scripts\mp\hud_util::destroyelem();

  for(var_1 = 0; var_1 < 3; var_1++) {
    scripts\mp\objidpoolmanager::returnminimapid(self.locationobjectives[var_1]);
  }
}

func_49F1(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\airdrop::getflyheightoffset(level.var_8638[level.script][var_1]["origin"]);
  var_3 = bulletTrace(level.var_8638[level.script][var_1]["origin"] + (0, 0, var_2), level.var_8638[level.script][var_1]["origin"] - (0, 0, var_2), 0);
  var_4 = var_3["position"] + anglesToForward(level.var_8638[level.script][var_1]["angles"]) * -1000;
  var_5 = spawn("script_model", var_4);

  if(!isDefined(var_5)) {
    return undefined;
  }

  var_5.angles = level.var_8638[level.script][var_1]["angles"];
  var_5 setModel("vehicle_bradley");
  var_5 setCanDamage(1);
  var_5.maxhealth = level.var_8D73 * 2;
  var_5.health = var_5.maxhealth;
  var_5.owner = var_0;
  var_5.var_D40F = [];
  var_5.var_AA24 = var_5.origin;

  if(level.teambased) {
    var_5.team = var_0.team;
  }

  var_5.var_B0ED = level.spawnpoints[0].origin[0];
  var_5.var_8EF9 = level.spawnpoints[0].origin[0];
  var_5.var_B0EE = level.spawnpoints[0].origin[1];
  var_5.var_8EFA = level.spawnpoints[0].origin[1];
  var_6 = 200;

  if(level.spawnpoints.size > 1) {
    for(var_7 = 1; var_7 < level.spawnpoints.size; var_7++) {
      if(level.spawnpoints[var_7].origin[0] < var_5.var_B0ED) {
        var_5.var_B0ED = level.spawnpoints[var_7].origin[0];
      } else if(level.spawnpoints[var_7].origin[0] > var_5.var_8EF9) {
        var_5.var_8EF9 = level.spawnpoints[var_7].origin[0];
      }

      if(level.spawnpoints[var_7].origin[1] < var_5.var_B0EE) {
        var_5.var_B0EE = level.spawnpoints[var_7].origin[1];
        continue;
      }

      if(level.spawnpoints[var_7].origin[1] > var_5.var_8EFA) {
        var_5.var_8EFA = level.spawnpoints[var_7].origin[1];
      }
    }
  } else
    var_6 = -2000;

  var_5.var_B0ED = var_5.var_B0ED + var_6;
  var_5.var_8EF9 = var_5.var_8EF9 - var_6;
  var_5.var_B0EE = var_5.var_B0EE + var_6;
  var_5.var_8EFA = var_5.var_8EFA - var_6;

  if(level.teambased) {
    var_8 = scripts\mp\objidpoolmanager::requestminimapid(1);

    if(var_8 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_8, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(var_8, var_3["position"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(var_8, "active");
      scripts\mp\objidpoolmanager::minimap_objective_team(var_8, var_5.team);
      scripts\mp\objidpoolmanager::minimap_objective_icon(var_8, "compass_objpoint_tank_friendly");
    }

    var_5.objidfriendly = var_8;
    var_8 = scripts\mp\objidpoolmanager::requestminimapid(1);

    if(var_8 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_8, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_position(var_8, var_3["position"]);
      scripts\mp\objidpoolmanager::minimap_objective_state(var_8, "active");
      scripts\mp\objidpoolmanager::minimap_objective_team(var_8, level.otherteam[var_5.team]);
      scripts\mp\objidpoolmanager::minimap_objective_icon(var_8, "compass_objpoint_tank_enemy");
    }

    var_5.var_C2BA = var_8;
  }

  var_5 thread watchtimeout();
  var_5 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor();
  var_5 thread func_139E8();
  var_5 thread func_13B18();
  level.var_B8F4 = var_5;
  return var_5;
}

func_BD1E(var_0) {
  level endon("game_ended");
  self endon("death");

  if(var_0 == "entrance") {
    var_1 = self.origin + anglesToForward(self.angles) * 1000;
  } else {
    self notify("leaving");
    var_1 = self.origin + anglesToForward(self.angles) * -1000;
  }

  var_2 = 3.0;
  self moveto(var_1, var_2, var_2 * 0.6, var_2 * 0.4);
  wait(var_2);

  if(var_0 == "entrance") {
    thread func_BB64();
  } else {
    stopFXOnTag(level.var_114DA, self.fxent, "tag_origin");
    stopFXOnTag(level.var_114DB, self.fxent, "tag_origin");
    self.fxent delete();
    scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
    scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
    level.var_B8F4 = undefined;
    self delete();
  }
}

func_6CC6() {
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(var_2 == self.owner) {
      continue;
    }
    if(var_2 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
      continue;
    }
    if(level.teambased && var_2.team == self.owner.team) {
      continue;
    }
    if(distancesquared(self.origin, var_2.origin) < 1000000) {
      continue;
    }
    for(var_3 = 0; var_3 < self.var_D40F.size; var_3++) {
      if(var_2 == self.var_D40F[var_3]) {
        continue;
      }
    }

    if(distancesquared(var_2.origin, self.var_AA24) < 500000) {
      continue;
    }
    if(level.teambased) {
      var_4 = 0;

      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        if(level.players[var_3].team != var_2.team && distancesquared(var_2.origin, level.players[var_3].origin) < 250000) {
          var_4 = 1;
          break;
        }
      }

      if(var_4 == 1) {
        continue;
      }
    }

    wait 0.05;
    var_5 = bulletTrace(var_2.origin + (0, 0, var_2 scripts\mp\killstreaks\airdrop::getflyheightoffset(var_2.origin)), var_2.origin + (0, 0, 100), 0);

    if(var_5["surfacetype"] != "none") {
      continue;
    }
    var_0 = var_2.origin;
    self.var_AA24 = var_2.origin;
    self.var_D40F[self.var_D40F.size] = var_2;
    break;
  }

  return var_0;
}

func_6CC2() {
  var_0 = undefined;

  for(var_1 = 0; var_1 < 20; var_1++) {
    var_2 = (randomfloatrange(self.var_B0ED, self.var_8EF9), randomfloatrange(self.var_B0EE, self.var_8EFA), 0);

    if(distancesquared(self.origin * (1, 1, 0), var_2) < 1000000) {
      continue;
    }
    if(distancesquared(self.owner.origin * (1, 1, 0), var_2) < 250000) {
      continue;
    }
    if(distancesquared(self.origin * (1, 1, 0), self.var_AA24) < 500000) {
      continue;
    }
    var_3 = 0;

    if(level.teambased) {
      foreach(var_5 in level.players) {
        if(var_5.team == self.owner.team && distancesquared(var_5.origin * (1, 1, 0), var_2) < 250000) {
          var_3 = 1;
          break;
        }
      }
    }

    if(var_3 == 0) {
      var_0 = var_2;
      self.var_AA24 = var_2;
      break;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = (randomfloatrange(self.var_B0ED, self.var_8EF9), randomfloatrange(self.var_B0EE, self.var_8EFA), 0);
  }

  return var_0;
}

func_BB64() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  var_0 = 0;
  self.fxent = spawn("script_model", self.origin);
  self.fxent setModel("tag_origin");
  self.fxent.angles = self.angles;
  self.fxent addpitch(-90);

  for(;;) {
    var_1 = func_6CC6();

    if(!isDefined(var_1)) {
      var_1 = func_6CC2();
    }

    var_2 = self.origin[2] + 3500;
    var_3 = bulletTrace(var_1 + (0, 0, var_2), var_1 - (0, 0, var_2), 0);
    var_4 = var_1 + (0, 0, var_2);
    var_5 = var_1 + (0, 0, var_3["position"][2]);
    self playSound("bmp_fire");
    playFX(level.var_114DE, self.origin + anglesToForward(self.angles) * 50);

    if(var_0 < 3) {
      playFXOnTag(level.var_114DA, self.fxent, "tag_origin");
      playFXOnTag(level.var_114DB, self.fxent, "tag_origin");
      var_0++;
    }

    thread func_BB98();
    level thread firemortar(self, var_4, var_5);
    self waittill("mortar_fire_done");
    wait 2.5;
  }
}

firemortar(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = var_0.owner;
  var_4 = scripts\mp\utility\game::_magicbullet("javelin_mp", var_0.origin + (0, 0, 150), var_1, var_3);
  var_5 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_5 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_5, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::minimap_objective_position(var_5, var_2);
    scripts\mp\objidpoolmanager::minimap_objective_state(var_5, "active");
    scripts\mp\objidpoolmanager::minimap_objective_team(var_5, var_0.team);
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_5, "compass_objpoint_mortar_target");
  }

  var_4.objidfriendly = var_5;
  var_6 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_6 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_6, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::minimap_objective_position(var_6, var_2);
    scripts\mp\objidpoolmanager::minimap_objective_state(var_6, "active");
    scripts\mp\objidpoolmanager::minimap_objective_team(var_6, level.otherteam[var_0.team]);
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_6, "compass_objpoint_mortar_target");
  }

  var_4.var_C2BA = var_6;
  var_7 = 0;

  for(;;) {
    if(!isDefined(var_4) || var_7 > 115 || distancesquared(var_4.origin, var_1) < 500) {
      break;
    } else
      wait 0.05;

    var_7++;
  }

  if(isDefined(var_4)) {
    var_4 delete();
  }

  if(isDefined(var_3)) {
    var_8 = scripts\mp\utility\game::_magicbullet("javelin_mp", var_1 + (0, 0, 200), var_2, var_3);
  } else {
    var_8 = scripts\mp\utility\game::_magicbullet("javelin_mp", var_1 + (0, 0, 200), var_2);
  }

  var_8.objidfriendly = var_5;
  var_8.var_C2BA = var_6;
  var_8 thread func_13B16(var_0);
}

func_13B16(var_0) {
  level endon("game_ended");
  self waittill("death");
  scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
  scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);

  if(isDefined(var_0)) {
    var_0 notify("mortar_fire_done");
  }
}

func_BB98() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  var_0 = self.origin + anglesToForward(self.angles) * -20;
  var_1 = self.origin;
  var_2 = self.angles;
  self moveto(var_0, 0.1);
  self ghost_nav_mode(-3, 0.1);
  wait 0.1;
  self moveto(var_1, 0.15);
  self rotateto(var_2, 0.15);
  wait 0.15;
}

watchtimeout() {
  level endon("game_ended");
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(90.0);
  self setCanDamage(0);
  thread func_BD1E("exit");
}

func_13B18() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  for(;;) {
    radiusdamage(self.origin, 200, 20, 20);
    wait 1;
  }
}

func_139E8() {
  level endon("game_ended");
  self endon("leaving");
  self waittill("death");
  playFX(level.var_114DD, self.origin);
  playFX(level.var_114DC, self.origin);
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("vehicle_bradley_destroyed");
  var_0.angles = self.angles;
  stopFXOnTag(level.var_114DA, self.fxent, "tag_origin");
  stopFXOnTag(level.var_114DB, self.fxent, "tag_origin");
  scripts\mp\objidpoolmanager::returnminimapid(self.objidfriendly);
  scripts\mp\objidpoolmanager::returnminimapid(self.var_C2BA);
  self.fxent delete();
  self delete();
  wait 3.5;
  var_0 delete();
  level.var_B8F4 = undefined;
}

func_139E5() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(self.health < 0) {
      break;
    }
  }
}