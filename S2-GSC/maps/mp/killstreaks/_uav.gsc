/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_uav.gsc
*********************************************/

func_00D5() {
  level.var_0611["uav_exit"] = loadfx("vfx/trail/smoketrail_uav");
  level.var_0611["uav_trail"] = loadfx("vfx/trail/smoketrail_uav");
  level.var_0611["counter_recon_hit"] = loadfx("vfx/explosion/rocket_explosion_airburst");
  level.var_5A61["uav"] = ::func_9E3B;
  level.var_5A61["counter_uav"] = ::func_9E25;
  level.var_5A61["advanced_uav"] = ::func_9E22;
  level.var_5A7D["counter_recon_gun_mp"] = "counter_uav";
  func_2834();
  func_5309();
  level thread func_6B6C();
  level thread func_9BA9();
  if(getdvarint("scr_game_radarMode") == 1) {
    level thread updatesweepinguavstatus();
  }
}

func_9FDD(param_00, param_01) {
  var_02 = randomint(360);
  var_03 = func_46FC(param_00.var_01C8);
  var_04 = func_46FD(param_00.var_01C8);
  var_05 = cos(var_02) * var_04;
  var_06 = sin(var_02) * var_04;
  var_07 = level.var_9FDF;
  if(param_00.var_01C8 == "counter_uav") {
    var_07 = level.var_28BA;
  }

  param_00 linkto(var_07, "tag_origin", (var_05, var_06, var_03), (0, var_02 - 90, 0));
  param_00 method_805C();
  param_00 method_808C();
  wait 0.05;
  var_08 = param_00.var_0116;
  param_00 unlink();
  if(0 && isDefined(param_00.var_620D)) {
    param_00.var_620D method_8352(3000, 1);
  }

  var_09 = 2625;
  if(param_00.var_01C8 == "counter_uav") {
    var_09 = 4200;
    thread func_2692(param_00);
  }

  if(param_00.var_01C8 == "uav") {
    thread func_9FD6(param_00, param_01);
  }

  param_00.var_0116 = param_00.var_0116 + -1 * anglesToForward(param_00.var_001D) * var_09;
  param_00 moveto(var_08, 3);
  param_00 rotateroll(20, 0.05);
  param_00 method_808C();
  level notify("uav_update");
  param_00 maps\mp\gametypes\_hostmigration::func_A74C("death", 3);
  if(isDefined(param_00)) {
    param_00 linkto(var_07, "tag_origin");
  }
}

func_9FDE(param_00, param_01) {
  param_00 unlink();
  var_02 = 2625;
  if(param_00.var_01C8 == "counter_uav") {
    var_02 = 4200;
  }

  if(param_00.var_01C8 == "uav") {
    thread func_9FD7(param_00, param_01);
  }

  var_03 = param_00.var_0116 + anglesToForward(param_00.var_001D) * var_02;
  playFXOnTag(common_scripts\utility::func_44F5("uav_exit"), param_00, "tag_origin");
  param_00 notify("leaving");
  param_00.var_5745 = 1;
  if(0 && isDefined(param_00.var_620D)) {
    param_00.var_620D method_8352(3000, 0);
  }

  param_00 moveto(var_03, 3);
  param_00 rotateroll(-20, 1);
  param_00 maps\mp\gametypes\_hostmigration::func_A74C("death", 2);
  var_04 = func_46FB(param_00.var_01C8, param_00.var_01A7);
  if(isDefined(var_04)) {
    param_00 setModel(var_04);
    param_00 setmaterialscriptparam(1, 0, 1);
  }

  wait(1);
  param_00 lib_0527::func_2DD3();
  if(0 && isDefined(param_00.var_620D)) {
    param_00.var_620D delete();
  }

  param_00 func_7D02();
  param_00 delete();
}

func_46FC(param_00) {
  var_01 = 0;
  switch (maps\mp\_utility::func_4571()) {
    case "mp_aachen_v2":
      var_01 = randomintrange(2250, 2500);
      break;

    case "mp_battleship_2":
      var_01 = randomintrange(1500, 2000);
      break;

    case "mp_carentan_s2":
      var_01 = randomintrange(1750, 2250);
      break;

    case "mp_canon_farm":
      var_01 = randomintrange(1750, 2000);
      break;

    case "mp_flak_tower":
      var_01 = randomintrange(2500, 3000);
      break;

    case "mp_france_cannon":
      var_01 = randomintrange(1750, 2000);
      break;

    case "mp_gibraltar_01":
    case "mp_gibraltar_02":
      var_01 = randomintrange(2250, 2500);
      break;

    case "mp_london":
      var_01 = randomintrange(1750, 2000);
      break;

    case "mp_sandbox_01":
      var_01 = randomintrange(1400, 1850);
      break;

    case "mp_hub_scorestreak_training":
    case "mp_scorstreak_training":
    case "mp_paris_s2":
    case "mp_airship":
    case "mp_d_day":
    case "mp_forest_01":
      var_01 = randomintrange(3000, 3250);
      break;

    default:
      var_01 = randomintrange(2000, 2250);
      break;
  }

  if(isDefined(param_00) && param_00 == "counter_uav") {
    var_01 = var_01 + 1500;
  }

  return var_01;
}

func_46FD(param_00) {
  var_01 = 0;
  switch (maps\mp\_utility::func_4571()) {
    case "mp_aachen_v2":
      var_01 = 3250;
      break;

    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      var_01 = 3500;
      break;

    case "mp_canon_farm":
      var_01 = 4000;
      break;

    case "mp_flak_tower":
      var_01 = 4250;
      break;

    case "mp_forest_01":
      var_01 = 3500;
      break;

    case "mp_paris_s2":
      var_01 = 2500;
      break;

    case "mp_prague":
      var_01 = 3250;
      break;

    case "mp_sandbox_01":
      var_01 = 2000;
      break;

    case "mp_hub_scorestreak_training":
    case "mp_gibraltar_01":
    case "mp_scorstreak_training":
    case "mp_london":
    case "mp_battleship_2":
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
    case "mp_france_village":
    case "mp_d_day":
    case "mp_gibraltar_02":
    default:
      var_01 = 3000;
      break;
  }

  if(isDefined(param_00) && param_00 == "counter_uav") {
    var_01 = var_01 + 2000;
  }

  return var_01;
}

func_46FA(param_00, param_01) {
  if(level.var_3FDC == "onevone") {
    return 200000;
  }

  if(isDefined(param_01) && param_01) {
    switch (param_00) {
      case "uav":
        return 35;

      case "counter_uav":
        return 40;

      case "advanced_uav":
        return 45;
    }

    return;
  }

  switch (param_00) {
    case "counter_uav":
    case "uav":
      return 30;

    case "advanced_uav":
      return 45;
  }
}

func_2692(param_00) {
  lib_0380::func_288B("ks_counter_uav_enter", undefined, param_00);
  var_01 = lib_0380::func_288D("ks_counter_uav_loop", undefined, param_00, 1.5);
  param_00 waittill("leaving");
  lib_0380::func_2893(var_01, 1.5);
  lib_0380::func_2889("ks_counter_uav_exit", undefined, param_00.var_0116);
}

func_9FD6(param_00, param_01) {
  if(isDefined(param_01)) {
    lib_0380::func_288B("ks_uav_recon_plane_enter", [param_01], param_00);
  }
}

func_9FD7(param_00, param_01) {
  if(isDefined(param_01)) {
    lib_0380::func_6844("ks_uav_recon_plane_exit", [param_01], param_00);
  }
}

func_9FDB(param_00, param_01, param_02, param_03) {
  self notify("death");
  lib_0527::func_2DD3();
  if(0 && isDefined(self.var_620D)) {
    self.var_620D delete();
  }

  func_7D02();
  self method_805C();
  thread func_2D56();
  func_74E7();
  if(self.var_01C8 == "counter_uav") {
    var_04 = "counter_uav_destroyed";
    var_05 = "callout_destroyed_counter_uav";
    var_06 = "cuav_destroyed";
  } else {
    var_04 = "uav_destroyed";
    var_05 = "callout_destroyed_uav";
    var_06 = "uav_destroyed";
  }

  maps\mp\gametypes\_damage::func_6B4B(param_00, param_01, param_02, param_03, var_04, var_06, var_05, 1);
}

func_2D56() {
  wait 0.05;
  if(isDefined(self)) {
    self delete();
  }
}

func_74E7() {
  var_00 = self.var_01A7;
  var_01 = anglesToForward(self.var_001D);
  if(self.var_01C8 == "counter_uav") {
    if(var_00 == "allies") {
      if(isDefined(self.var_57FB)) {
        if(!isDefined(level.var_0611["counter_uav_explode_allies_chase"])) {
          level.var_0611["counter_uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies_chase");
        }

        playFX(common_scripts\utility::func_44F5("counter_uav_explode_allies_chase"), self.var_0116, var_01);
        return;
      }

      if(!isDefined(level.var_0611["counter_uav_explode_allies"])) {
        level.var_0611["counter_uav_explode_allies"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_allies");
      }

      playFX(common_scripts\utility::func_44F5("counter_uav_explode_allies"), self.var_0116, var_01);
      lib_0380::func_2889("ks_plane_destruct_explode", undefined, self.var_0116);
      lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, self);
      return;
    }

    if(isDefined(self.var_57FB)) {
      if(!isDefined(level.var_0611["counter_uav_explode_axis_chase"])) {
        level.var_0611["counter_uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion_chase");
      }

      playFX(common_scripts\utility::func_44F5("counter_uav_explode_axis_chase"), self.var_0116, var_01);
      return;
    }

    if(!isDefined(level.var_0611["counter_uav_explode_axis"])) {
      level.var_0611["counter_uav_explode_axis"] = loadfx("vfx/explosion/vehicle_counter_uav_explosion");
    }

    playFX(common_scripts\utility::func_44F5("counter_uav_explode_axis"), self.var_0116, var_01);
    lib_0380::func_2889("ks_plane_destruct_explode", undefined, self.var_0116);
    lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, self);
    return;
  }

  if(var_00 == "allies") {
    if(isDefined(self.var_57FB)) {
      if(!isDefined(level.var_0611["uav_explode_allies_chase"])) {
        level.var_0611["uav_explode_allies_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies_chase");
      }

      playFX(common_scripts\utility::func_44F5("uav_explode_allies_chase"), self.var_0116, var_01);
      return;
    }

    if(!isDefined(level.var_0611["uav_explode_allies"])) {
      level.var_0611["uav_explode_allies"] = loadfx("vfx/explosion/vehicle_uav_explosion_allies");
    }

    playFX(common_scripts\utility::func_44F5("uav_explode_allies"), self.var_0116, var_01);
    lib_0380::func_2889("ks_plane_destruct_explode", undefined, self.var_0116);
    lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, self);
    return;
  }

  if(isDefined(self.var_57FB)) {
    if(!isDefined(level.var_0611["uav_explode_axis_chase"])) {
      level.var_0611["uav_explode_axis_chase"] = loadfx("vfx/explosion/vehicle_uav_explosion_chase");
    }

    playFX(common_scripts\utility::func_44F5("uav_explode_axis_chase"), self.var_0116, var_01);
    return;
  }

  if(!isDefined(level.var_0611["uav_explode_axis"])) {
    level.var_0611["uav_explode_axis"] = loadfx("vfx/explosion/vehicle_uav_explosion");
  }

  playFX(common_scripts\utility::func_44F5("uav_explode_axis"), self.var_0116, var_01);
  lib_0380::func_2889("ks_plane_destruct_explode", undefined, self.var_0116);
  lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, self);
}

func_9BA9() {
  level endon("game_ended");
  for(;;) {
    level waittill("uav_update");
    if(level.var_984D) {
      func_A188("allies");
      func_A188("axis");
    } else {
      func_A187();
    }

    level notify("radar_status_change");
  }
}

func_463C(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = 0;
  var_06 = 0;
  if(level.var_984D) {
    var_04 = level.var_08E6[param_00];
    var_06 = level.var_08CD[param_00];
    var_05 = level.var_08D3[maps\mp\_utility::func_45DE(param_00)];
  } else {
    var_04 = level.var_08E6[param_01.var_48CA];
    var_06 = level.var_08CD[param_01.var_48CA];
    foreach(var_08 in level.var_744A) {
      if(var_08 == param_01) {
        continue;
      }

      var_05 = var_05 + level.var_08D3[var_08.var_48CA];
    }
  }

  var_0A = var_04;
  if(var_06 > 0) {
    var_0A = 3;
  }

  if(getdvarint("scr_game_radarMode") == 1) {
    var_0A++;
  }

  return int(clamp(var_0A, getuavstrengthmin(), getuavstrengthmax()));
}

func_A188(param_00) {
  var_01 = func_463C(param_00);
  setteamradarstrength(param_00, var_01);
  var_02 = level.var_08D3[maps\mp\_utility::func_45DE(param_00)];
  var_03 = 0;
  var_04 = var_01 > getuavstrengthlevelneutral();
  var_05 = var_01 >= getuavstrengthlevelshowenemyfastsweep();
  var_06 = var_01 >= getuavstrengthlevelshowenemydirectional();
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    param_00 = maps\mp\_utility::func_45DE(param_00);
  }

  if(var_03) {
    blockteamradar(param_00);
  } else {
    unblockteamradar(param_00);
  }

  setteamradar(param_00, var_04);
  if(var_05) {
    level.var_014C[param_00] = "fast_radar";
  } else {
    level.var_014C[param_00] = "normal_radar";
  }

  foreach(var_08 in level.var_744A) {
    if(var_08.var_01A7 != param_00) {
      continue;
    }

    var_08.var_014C = level.var_014C[param_00];
    var_08.var_0089 = level.var_014C[maps\mp\_utility::func_45DE(param_00)];
    var_08.var_014D = var_06;
    var_08 func_A09F(var_04);
  }
}

func_A187() {
  foreach(var_01 in level.var_744A) {
    var_02 = var_01 func_463C(var_01.var_01A7, var_01);
    var_03 = 0;
    foreach(var_05 in level.var_744A) {
      if(var_05 == var_01) {
        continue;
      }

      var_03 = var_03 + level.var_08D3[var_05.var_48CA];
    }

    var_07 = 0;
    var_08 = var_02 > getuavstrengthlevelneutral();
    var_09 = var_02 >= getuavstrengthlevelshowenemyfastsweep();
    var_0A = var_02 >= getuavstrengthlevelshowenemydirectional();
    var_01.var_014E = var_02;
    var_01.var_00DD = var_07;
    var_01.var_00B7 = var_08;
    var_01.var_014D = var_0A;
    var_01 func_A09F(var_08);
    if(var_09) {
      var_01.var_014C = "fast_radar";
      continue;
    }

    var_01.var_014C = "normal_radar";
  }
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    if(!level.var_984D) {
      level.var_08E6[var_00.var_48CA] = 0;
      level.var_08D3[var_00.var_48CA] = 0;
      level.var_08CD[var_00.var_48CA] = 0;
      level.var_014C[var_00.var_48CA] = "normal_radar";
    }

    if(getdvarint("2043", 0)) {
      var_00 setclientomnvar("ui_hide_minimap", 1);
    }

    var_00 thread func_6B82();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    var_00 = 0;
    if(level.var_984D) {
      var_00 = level.var_08D3[maps\mp\_utility::func_45DE(self.var_01A7)];
      continue;
    }

    foreach(var_02 in level.var_744A) {
      if(var_02 == self) {
        continue;
      }

      var_00 = var_00 + level.var_08D3[var_02.var_48CA];
    }
  }
}

updatesweepinguavstatus() {
  level endon("game_ended");
  while(!isDefined(level.var_5139) || level.var_5139 > 5) {
    wait 0.05;
  }

  level thread sweepinguavhandlehostmigration();
  level notify("uav_update");
  for(;;) {
    level waittill("player_spawned");
    level notify("uav_update");
  }
}

sweepinguavhandlehostmigration() {
  level endon("game_ended");
  level endon("disconnect");
  for(;;) {
    level waittill("host_migration_begin");
    var_00 = maps\mp\gametypes\_hostmigration::func_A782();
    if(level.var_3FDC == "gun" || level.var_3FDC == "blades" || level.var_3FDC == "aon" || level.var_3FDC == "oitc") {
      setdynamicdvar("scr_game_compassRadarUpdateTime", 9);
      setDvar("4648", 9);
    }

    level notify("uav_update");
  }
}

func_9E3B(param_00) {
  return func_9E3C("uav");
}

func_9E25(param_00) {
  return func_9E3C("counter_uav");
}

func_9E22(param_00) {
  return func_9E3C("advanced_uav");
}

func_9E3C(param_00) {
  if(maps\mp\_utility::func_5668() || param_00 != "counter_uav" && maps\mp\_utility::func_5814()) {
    return 0;
  }

  var_01 = self.var_01A7;
  if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(level.var_79C1)) {
    var_01 = maps\mp\_utility::func_45DE(var_01);
  }

  var_02 = 0;
  if((level.var_984D && level.var_9FDA[var_01].size > 5) || !level.var_984D && level.var_9FDA.size > 10) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  maps\mp\_matchdata::func_5E9A(param_00, self.var_0116);
  if(param_00 == "uav" && getdvarint("4263", 0)) {
    var_03 = func_83BC(param_00);
    if(!isDefined(var_03) || !var_03) {
      return 0;
    }

    return 1;
  } else if(var_01 == "counter_uav") {
    var_04 = func_4475();
    if(isDefined(var_04)) {
      var_04.var_57FB = 1;
      var_04 setCanDamage(0);
      level thread func_5C24(self, var_02, var_04);
      return 1;
    }
  }

  level thread func_5C30(self, var_02, var_01);
  return 1;
}

func_09A8(param_00, param_01) {
  if(0) {
    self.var_620D = spawnplane("script_model", (0, 0, 0));
    self.var_620D setModel("tag_origin");
    self.var_620D method_8351(param_00, param_01, 15, 15);
    self.var_620D method_8449(self, "", (0, 0, 0), (0, 0, 0));
    self.var_620D method_805C();
  }
}

func_5C30(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", level.var_9FDF gettagorigin("tag_origin"));
  var_04 setclientowner(param_00);
  var_04 method_8012(1);
  var_04 method_805C();
  var_04 method_808C();
  var_05 = func_46FF(param_02, param_01);
  var_06 = func_46FB(param_02, param_01);
  if(isDefined(var_06)) {
    var_04 thread func_39C7(var_06, var_05);
  } else {
    var_04 setModel(var_05);
  }

  var_07 = func_46F8(param_02, param_01);
  if(isDefined(var_07) && var_07 != "") {
    var_04 scriptmodelplayanim(var_07);
  }

  var_04 thread func_74E6();
  var_04 thread maps\mp\gametypes\_damage::func_8676(lib_0527::func_4612(param_02), undefined, ::func_9FDB, ::lib_0527::func_6B9C, 1);
  if(level.var_3FDC == "onevone") {
    var_04 setCanDamage(0);
  }

  if(isDefined(param_03)) {
    var_04.var_6DA6 = 1;
  } else {
    var_04.var_0117 = param_00;
  }

  var_04.var_5C2F = gettime();
  var_04.var_01C8 = param_02;
  var_04.var_01A7 = param_01;
  var_04 common_scripts\utility::func_5FA9(param_01, undefined, undefined, 1);
  var_04 thread lib_0527::func_2818();
  var_04 thread lib_0527::func_4ACE();
  var_04 func_09FE();
  var_04 func_0992(param_02);
  if(isDefined(param_03)) {
    foreach(var_09 in level.var_744A) {
      if(isDefined(var_09.var_01A7) && var_09.var_01A7 == param_01) {
        var_04 func_09A8(var_09, func_46FE(param_02));
      }
    }
  } else {
    var_04 func_09A8(var_04.var_0117, func_46FE(param_02));
  }

  level notify("uav_update");
  level thread maps\mp\killstreaks\_killstreaks::func_A0DC();
  thread func_9FDD(var_04, param_00);
  var_04 thread func_A186();
  var_04 thread func_2397(param_02, param_00);
  var_0B = 0;
  if((!isDefined(param_03) || param_03 == 0) && isDefined(var_04.var_0117)) {
    var_04 thread func_6BBA();
    var_0B = var_04.var_0117 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_04 maps\mp\gametypes\_hostmigration::func_A74C("death", func_46FA(param_02, var_0B));
  if(isDefined(var_04)) {
    var_04 notify("cleanup_uav");
  }
}

func_6BBA() {
  level endon("game_ended");
  self endon("cleanup_uav");
  self.var_0117 common_scripts\utility::func_A70A("disconnect", "joined_team", "joined_spectators");
  self notify("cleanup_uav");
}

func_2397(param_00, param_01) {
  level endon("game_ended");
  self waittill("cleanup_uav");
  if(param_00 == "counter_uav") {
    var_02 = "cuav_ended";
  } else {
    var_02 = "uav_ended";
  }

  if(isDefined(param_01)) {
    param_01 thread maps\mp\_utility::func_5C43(var_02);
  }

  func_7CCC(param_00);
  level notify("uav_update");
  if(self.var_006A < self.var_00FB && !isDefined(self.var_57FB)) {
    thread func_9FDE(self, param_01);
  }
}

func_A186() {
  self endon("death");
  for(;;) {
    level common_scripts\utility::func_A732("joined_team", "uav_update");
    self method_805C();
    foreach(var_01 in level.var_744A) {
      if(level.var_984D) {
        if(var_01.var_01A7 != self.var_01A7 || 1) {
          self showtoclient(var_01);
          if(0 && isDefined(self.var_620D)) {
            self.var_620D showtoclient(var_01);
          }
        }

        continue;
      }

      if(isDefined(self.var_0117) && var_01 == self.var_0117) {
        continue;
      }

      self showtoclient(var_01);
      if(0 && isDefined(self.var_620D)) {
        self.var_620D showtoclient(var_01);
      }
    }
  }
}

func_2834() {
  var_00 = getEntArray("minimap_corner", "targetname");
  if(var_00.size) {
    var_01 = lib_050D::func_3B89(var_00[0].var_0116, var_00[1].var_0116);
  } else {
    var_01 = (0, 0, 0);
  }

  level.var_9FDF = spawn("script_model", var_01);
  level.var_9FDF setModel("c130_zoomrig");
  level.var_9FDF.var_001D = (0, 115, 0);
  level.var_9FDF method_805C();
  level.var_9FDF.var_01A5 = "uavrig_script_model";
  var_02 = 20053.52 / func_46FD();
  level.var_9FDF thread func_7EF0(var_02);
  level.var_28BA = spawn("script_model", var_01);
  level.var_28BA setModel("c130_zoomrig");
  level.var_28BA.var_001D = (0, 115, 0);
  level.var_28BA method_805C();
  var_02 = 40107.04 / func_46FD("counter_uav");
  level.var_28BA thread func_7EF0(var_02);
}

func_7EF0(param_00) {
  var_01 = 60;
  var_02 = -1 * param_00 * var_01;
  for(;;) {
    self rotateyaw(var_02, var_01);
    wait(var_01);
  }
}

func_74E6() {
  self endon("death");
  level endon("game_ended");
  playFXOnTag(level.var_0611["uav_trail"], self, "tag_origin");
}

func_39C7(param_00, param_01) {
  self endon("death");
  self setModel(param_00);
  self setmaterialscriptparam(0, 1, 1);
  wait(1);
  self setModel(param_01);
}

func_46FF(param_00, param_01) {
  switch (param_00) {
    case "advanced_uav":
    case "uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "usa_recon_pipercub_ai";
      } else {
        return "ger_recon_storch";
      }

      break;

    case "counter_uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "usa_bomber_p61_blackwidow_vista";
      }
      return "ger_recon_messerschmitt100_vista";
  }
}

func_46FB(param_00, param_01) {
  switch (param_00) {
    case "advanced_uav":
    case "uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "usa_recon_pipercub_ai_fade";
      } else {
        return "ger_recon_storch_fade";
      }

      break;

    case "counter_uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "usa_bomber_p61_blackwidow_vista_fade";
      }
      return "ger_recon_messerschmitt100_vista_fade";
  }
}

func_46F8(param_00, param_01) {
  switch (param_00) {
    case "advanced_uav":
    case "uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "ks_recon_usa";
      } else {
        return "ks_recon_ger";
      }

      break;

    case "counter_uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "ks_counter_intelligence_usa";
      }
      return "ks_counter_intelligence_ger";
  }
}

func_46F9(param_00, param_01) {
  switch (param_00) {
    case "advanced_uav":
    case "uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "ks_recon_usa_animated";
      } else {
        return "ks_recon_ger_animated";
      }

      break;

    case "counter_uav":
      if(isDefined(param_01) && param_01 == "allies") {
        return "ks_counter_intelligence_usa_animated";
      }
      return "ks_counter_intelligence_ger_animated";
  }
}

func_46FE(param_00) {
  switch (param_00) {
    case "advanced_uav":
    case "uav":
      return "scorestreak_minimap_recon";

    case "counter_uav":
      return "scorestreak_minimap_fighter";
  }
}

func_5309() {
  if(level.var_984D) {
    level.var_014C["allies"] = "normal_radar";
    level.var_014C["axis"] = "normal_radar";
    level.var_08E6["allies"] = 0;
    level.var_08E6["axis"] = 0;
    level.var_08D3["allies"] = 0;
    level.var_08D3["axis"] = 0;
    level.var_08CD["allies"] = 0;
    level.var_08CD["axis"] = 0;
    level.var_9FDA["allies"] = [];
    level.var_9FDA["axis"] = [];
  } else {
    level.var_014C = [];
    level.var_08E6 = [];
    level.var_08D3 = [];
    level.var_08CD = [];
    level.var_9FDA = [];
  }

  level.var_9FD9 = 15;
  level.var_9FD8 = 0;
}

func_09FE() {
  var_00 = self.var_01A7;
  if(level.var_984D) {
    level.var_9FDA[var_00][level.var_9FDA[var_00].size] = self;
    return;
  }

  level.var_9FDA[self.var_0117.var_48CA + "_" + gettime()] = self;
}

func_7D02() {
  self method_8012(0);
  var_00 = self.var_01A7;
  if(level.var_984D) {
    level.var_9FDA[var_00] = common_scripts\utility::func_0F98(self, level.var_9FDA[var_00]);
    return;
  }

  level.var_9FDA = common_scripts\utility::func_0F98(self, level.var_9FDA);
}

func_0992(param_00) {
  func_0A05(param_00, 1);
  if(param_00 == "counter_uav") {
    if(level.var_984D) {
      level.var_9850[maps\mp\_utility::func_45DE(self.var_01A7)] = 1;
    } else {
      level.var_2694 = self.var_0117;
    }

    level thread lib_0528::func_A0E0();
  }
}

func_7CCC(param_00) {
  func_0A05(param_00, -1);
  if(param_00 == "counter_uav") {
    if(level.var_984D) {
      if(level.var_08D3[self.var_01A7] == 0) {
        level.var_9850[maps\mp\_utility::func_45DE(self.var_01A7)] = 0;
      }
    } else if(isDefined(self.var_0117) && level.var_08D3[self.var_0117.var_48CA] == 0) {
      level.var_2694 = undefined;
    }

    level thread lib_0528::func_A0E0();
  }
}

func_0A05(param_00, param_01) {
  switch (param_00) {
    case "uav":
      if(level.var_984D) {
        level.var_08E6[self.var_01A7] = level.var_08E6[self.var_01A7] + param_01;
      } else if(isDefined(self.var_0117)) {
        level.var_08E6[self.var_0117.var_48CA] = level.var_08E6[self.var_0117.var_48CA] + param_01;
      }
      break;

    case "counter_uav":
      if(level.var_984D) {
        level.var_08D3[self.var_01A7] = level.var_08D3[self.var_01A7] + param_01;
      } else if(isDefined(self.var_0117)) {
        level.var_08D3[self.var_0117.var_48CA] = level.var_08D3[self.var_0117.var_48CA] + param_01;
      }
      break;

    case "advanced_uav":
      if(level.var_984D) {
        level.var_08CD[self.var_01A7] = level.var_08CD[self.var_01A7] + param_01;
      } else if(isDefined(self.var_0117)) {
        level.var_08CD[self.var_0117.var_48CA] = level.var_08CD[self.var_0117.var_48CA] + param_01;
      }
      break;
  }
}

func_27DD() {
  if(!isDefined(self.var_9846)) {
    self.var_9846 = newclienthudelem(self);
    self.var_9846.var_01D3 = -350;
    self.var_9846.var_01D7 = -70;
    self.var_9846.var_0010 = "center";
    self.var_9846.var_0011 = "middle";
    self.var_9846.var_00C6 = "center";
    self.var_9846.var_01CA = "middle";
    self.var_9846.var_009B = 1;
    self.var_9846.var_0018 = 1;
    self.var_6C0C = newclienthudelem(self);
    self.var_6C0C.var_01D3 = -320;
    self.var_6C0C.var_01D7 = -70;
    self.var_6C0C.var_0010 = "center";
    self.var_6C0C.var_0011 = "middle";
    self.var_6C0C.var_00C6 = "center";
    self.var_6C0C.var_01CA = "middle";
    self.var_6C0C.var_009B = 1;
    self.var_6C0C.var_0018 = 1;
    thread func_A0F6();
  }
}

func_A0F6() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    if(level.var_3FDC == "onevone" || self getclientomnvar("ui_hide_minimap")) {
      self.var_9846.var_0018 = 0;
      self.var_6C0C.var_0018 = 0;
    } else {
      self.var_9846.var_0018 = 1;
      self.var_6C0C.var_0018 = 1;
    }

    var_00 = func_463C(self.var_01A7, self);
    var_01 = func_463C(maps\mp\_utility::func_45DE(self.var_01A7), self);
    self.var_9846 setvalue(var_00);
    self.var_6C0C setvalue(var_01);
    level waittill("uav_update");
  }
}

func_A09F(param_00) {
  if(getdvarint("2043", 0)) {
    if(param_00) {
      self setclientomnvar("ui_hide_minimap", 0);
      return;
    }

    self setclientomnvar("ui_hide_minimap", 1);
  }
}

func_83BC(param_00) {
  self endon("stop_location_selection");
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  var_01 = level.var_5FF0 / 4;
  if(level.var_910F) {
    var_01 = var_01 * 1.5;
  }

  var_02 = 0;
  maps\mp\_utility::func_05D4(param_00, "map_artillery_selector", var_02, var_01);
  thread func_A6D8();
  self waittill("confirm_location", var_03, var_04);
  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  thread func_A22E(var_03);
  return 1;
}

func_A22E(param_00) {
  var_01 = level.var_9FD8;
  level.var_9FD8++;
  foreach(var_03 in level.var_744A) {
    if(!isPlayer(var_03) || isbot(var_03) || function_026D(var_03)) {
      continue;
    }

    if(var_03.var_01A7 != self.var_01A7) {
      continue;
    }

    var_03 thread func_47A6(var_01, self, param_00);
  }

  thread func_479B(var_01, self, param_00);
  wait(30);
  level notify("uav_locational_destroyed_" + var_01);
  foreach(var_03 in level.var_744A) {
    if(!isPlayer(var_03) || isbot(var_03) || function_026D(var_03)) {
      continue;
    }

    if(var_03.var_01A7 != self.var_01A7) {
      continue;
    }

    var_03 thread func_7CF4(var_01);
  }
}

func_47A6(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_02);
  var_03.var_01A7 = param_01.var_01A7;
  var_03.var_283E = param_01;
  var_03.var_502A = param_00;
  var_03 makeportableradar(self);
  if(isDefined(self.var_7B4E)) {
    self.var_7B4E = common_scripts\utility::func_0FA0(self.var_7B4E);
    if(self.var_7B4E.size >= level.var_9FD9) {
      level maps\mp\gametypes\_portable_radar::func_2D49(self.var_7B4E[0]);
      self.var_7B4E[0] = undefined;
    }

    self.var_7B4E = common_scripts\utility::func_0FA0(self.var_7B4E);
  } else {
    self.var_7B4E = [];
  }

  self.var_7B4E[self.var_7B4E.size] = var_03;
  thread func_A6B7(param_00);
}

func_7CF4(param_00) {
  if(isDefined(self.var_7B4E)) {
    self.var_7B4E = common_scripts\utility::func_0FA0(self.var_7B4E);
    foreach(var_02 in self.var_7B4E) {
      if(var_02.var_502A == param_00) {
        level maps\mp\gametypes\_portable_radar::func_2D49(var_02);
        var_02 = undefined;
      }
    }

    self.var_7B4E = common_scripts\utility::func_0FA0(self.var_7B4E);
  }
}

func_A6B7(param_00) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + param_00);
  common_scripts\utility::func_A70A("disconnect", "joined_team", "joined_spectators");
  func_7CF4(param_00);
}

func_A6D8() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  if(maps\mp\gametypes\_hostmigration::func_A782() > 0) {
    self switchtoweapon(common_scripts\utility::func_4550());
  }
}

func_479B(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("uav_locational_destroyed_" + param_00);
  for(;;) {
    level waittill("connected", var_03);
    if(!isPlayer(var_03) || isbot(var_03) || function_026D(var_03)) {
      continue;
    }

    if(var_03.var_01A7 != param_01.var_01A7) {
      continue;
    }

    var_03 thread func_47A6(param_00, param_01, param_02);
  }
}

func_4475() {
  var_00 = undefined;
  var_01 = level.var_9FDA;
  if(level.var_984D) {
    var_01 = level.var_9FDA[maps\mp\_utility::func_45DE(self.var_01A7)];
  }

  foreach(var_03 in var_01) {
    if(!isDefined(var_03) || isDefined(var_03.var_5745) || isDefined(var_03.var_57FB)) {
      continue;
    }

    if(isDefined(var_00) && var_00.var_01C8 == "counter_uav" && var_03.var_01C8 != "counter_uav") {
      continue;
    }

    if(!level.var_984D && isDefined(var_03.var_0117) && var_03.var_0117 == self) {
      continue;
    }

    var_00 = var_03;
  }

  return var_00;
}

func_5C24(param_00, param_01, param_02, param_03) {
  while(isDefined(param_02) && !param_02 islinked()) {
    wait 0.05;
  }

  if(!isDefined(param_02)) {
    level thread func_5C30(param_00, param_01, "counter_uav");
    return;
  }

  level thread func_9FDC(param_02);
  var_04 = anglestoright((0, param_02.var_001D[1], 0));
  var_05 = param_02.var_0116 + var_04 * -3200;
  var_06 = spawn("script_model", var_05);
  var_06.var_001D = param_02.var_001D + (0, -55, 0);
  lib_0380::func_288B("ks_counter_uav_chase", undefined, var_06);
  if(param_02.var_01C8 == "counter_uav") {
    lib_0380::func_288B("ks_counter_uav_chase_target_lg", undefined, param_02);
  } else {
    lib_0380::func_288B("ks_counter_uav_chase_target_sm", undefined, param_02);
  }

  wait(0.5);
  var_07 = func_46FF("counter_uav", param_01);
  var_08 = func_46FB("counter_uav", param_01);
  if(isDefined(var_08)) {
    var_06 setModel(var_08);
  } else {
    var_06 setModel(var_07);
  }

  var_09 = "ks_counter_intelligence_ger_attack";
  if(param_01 == "allies") {
    var_09 = "ks_counter_intelligence_usa_attack";
  }

  var_06 method_8278(var_09, "finished_chase_anim");
  if(isDefined(param_03)) {
    var_06.var_6DA6 = 1;
  } else {
    var_06.var_0117 = param_00;
  }

  var_06.var_5C2F = gettime();
  var_06.var_01C8 = "counter_uav";
  if(isDefined(param_03)) {
    foreach(var_0B in level.var_744A) {
      if(isDefined(var_0B.var_01A7) && var_0B.var_01A7 == param_01) {
        var_06 func_09A8(var_0B, func_46FE("counter_uav"));
      }
    }
  } else {
    var_06 func_09A8(var_06.var_0117, func_46FE("counter_uav"));
  }

  if(isDefined(var_08)) {
    var_06 setmaterialscriptparam(0, 1, 1);
  }

  wait(1);
  var_06 setModel(var_07);
  wait(1.66);
  var_06 thread func_2695(param_02, param_01);
  var_06 common_scripts\utility::func_A70A("death", "finished_chase_anim");
  if(isDefined(var_08)) {
    var_06 setModel(var_08);
    var_06 setmaterialscriptparam(1, 0, 0.5);
    wait(0.5);
  }

  if(0 && isDefined(var_06.var_620D)) {
    var_06.var_620D delete();
  }

  var_06 delete();
}

func_2695(param_00, param_01) {
  self endon("death");
  var_02 = (134, 9, 39);
  var_03 = (134, -9, 39);
  if(param_01 == "allies") {
    var_02 = (111, 17, 13);
    var_03 = (111, -17, 13);
  }

  var_04 = 2.8;
  if(param_00.var_01C8 == "counter_uav") {
    var_04 = 5;
  }

  var_05 = gettime();
  for(var_06 = 0; var_06 < var_04 * 1000; var_06 = gettime() - var_05) {
    var_07 = anglesToForward(self.var_001D);
    var_08 = vectornormalize(param_00.var_0116 - self.var_0116);
    var_09 = vectordot(var_07, var_08);
    var_0A = self.var_0116 + rotatevector(var_02, self.var_001D);
    var_0B = var_0A + var_07 * 8000;
    magicbullet("counter_recon_gun_mp", var_0A, var_0B);
    var_0A = self.var_0116 + rotatevector(var_03, self.var_001D);
    var_0B = var_0A + var_07 * 8000;
    magicbullet("counter_recon_gun_mp", var_0A, var_0B);
    lib_0380::func_2889("ks_fighter_strike_npc", undefined, self.var_0116);
    if(var_09 > 0.995) {
      var_0C = param_00 gettagorigin("TAG_DEATH_FX");
      playFX(common_scripts\utility::func_44F5("counter_recon_hit"), var_0C);
    }

    wait(0.1);
  }

  param_00 setCanDamage(1);
  param_00 dodamage(param_00.var_00FB * 10, param_00.var_0116, self.var_0117, self, "MOD_RIFLE_BULLET", "counter_recon_gun_mp");
  if(param_00.var_01C8 == "counter_uav") {
    var_0D = param_00.var_0116;
    lib_0380::func_2889("ks_plane_destruct_explode", undefined, var_0D);
    lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, param_00);
  } else {
    lib_0380::func_2889("ks_plane_destruct_explode", undefined, param_00.var_0116);
  }

  lib_0380::func_288D("ks_plane_destruct_deathspin_long", undefined, param_00);
}

func_9FDC(param_00) {
  param_00 notify("leaving");
  param_00 notify("death");
  param_00 func_7D02();
  param_00 unlink();
  var_01 = func_46F9(param_00.var_01C8, param_00.var_01A7);
  param_00 method_8278(var_01, "finished_chase_anim");
  if(0 && isDefined(param_00.var_620D)) {
    param_00.var_620D method_8352(3000, 0);
  }

  param_00 common_scripts\utility::func_A70A("death", "finished_chase_anim");
  wait 0.05;
  wait 0.05;
  if(isDefined(param_00)) {
    param_00 lib_0527::func_2DD3();
    if(0 && isDefined(param_00.var_620D)) {
      param_00.var_620D delete();
    }

    param_00 delete();
  }
}