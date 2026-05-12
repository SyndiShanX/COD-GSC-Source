/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_v2_missle_strike.gsc
*****************************************************/

func_52F5() {}

func_9303(param_00, param_01, param_02, param_03, param_04) {
  self notify("used");
  if(!common_scripts\utility::func_562E(param_03)) {
    thread func_6B57(param_02);
    wait(func_46DF(param_02));
  }

  for(var_05 = 0; var_05 < param_01.size; var_05++) {
    var_06 = param_01[var_05];
    var_06 = (var_06[0], var_06[1], 0);
    if(isDefined(param_04)) {
      thread func_3216(param_00, var_06, undefined, param_04, param_02, param_04);
    } else {
      thread func_3216(param_00, var_06, self, self.var_012C["team"], param_02);
    }

    wait(func_46E0(param_02));
  }
}

func_3216(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(isDefined(param_02)) {
    param_02 endon("disconnect");
  }

  if(!isDefined(param_01)) {
    return;
  }

  var_07 = maps\mp\_utility::func_579B() && isDefined(param_05);
  var_08 = getEntArray("mp_artillery", "classname");
  if(var_07) {
    var_09 = "";
    if(param_05 == game["attackers"]) {
      var_09 = "allies";
    } else if(param_05 == game["defenders"]) {
      var_09 = "axis";
    }

    for(var_0A = 0; var_0A < var_08.size; var_0A++) {
      if(var_08[var_0A].var_0165 != var_09) {
        var_08[var_0A] = var_08[var_08.size - 1];
        var_08[var_08.size - 1] = undefined;
        var_0A--;
      }
    }
  }

  var_0B = 99999999;
  var_0C = level.var_5FEB + (10000, 10000, 1000);
  foreach(var_0E in var_09) {
    var_0F = distance2d(var_0E.var_0116, param_02);
    if(var_0F < var_0B) {
      var_0C = var_0E.var_0116;
      var_0B = var_0F;
    }
  }

  var_11 = 1;
  if(maps\mp\_utility::func_579B() && isDefined(param_06) && isDefined(level.var_79C2.var_80B0) && common_scripts\utility::func_562E(level.var_79C2.var_80B0.var_4D10)) {
    var_11 = 0;
  }

  var_12 = undefined;
  var_13 = undefined;
  if(var_11) {
    var_12 = spawnplane("script_model", param_02);
    var_13 = spawnplane("script_model", param_02);
    thread func_8C0B(param_05, param_03, var_12, var_13, param_06);
    if(isDefined(param_03)) {
      param_03 thread func_624C(var_12, var_13);
    }
  }

  lib_0526::func_280E(param_02, 0, param_05, param_04);
  thread lib_0526::func_5FCB(param_02, param_05);
  var_14 = 0;
  if(isDefined(param_03)) {
    var_14 = param_03 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_15 = func_45C0(param_05, var_08, var_14);
  var_16 = [];
  for(var_0A = 0; var_0A < var_15; var_0A++) {
    if(var_14) {
      var_16[var_0A] = 0.75;
      continue;
    }

    var_16[var_0A] = 0.8;
  }

  for(var_0A = 0; var_0A < var_15; var_0A++) {
    var_17 = randomfloat(0.7);
    var_16[var_0A] = var_16[var_0A] - var_17;
    var_18 = randomint(var_15);
    var_16[var_18] = var_16[var_18] + var_17;
  }

  for(var_0A = 0; var_0A < var_15; var_0A++) {
    var_19 = func_458A(param_05);
    var_1A = func_458A(param_05);
    var_1B = func_3B99(param_02[0] + var_19, param_02[1] + var_1A);
    var_1C = var_0C;
    if(isDefined(var_07)) {
      var_1D = var_07;
    } else {
      var_1D = func_458D(param_05, param_04);
    }

    var_1E = 2.5;
    if(var_14 && param_05 == "mortar_strike") {
      var_1E = 1.5;
    }

    var_1F = magicartillery(var_1D, var_1C, var_1B, var_1E, func_4578(), param_03, getdiveheightformap());
    if(isDefined(param_06)) {
      var_1F.var_01A7 = param_04;
    }

    if(isDefined(var_07) && var_07 == "mortar_strike_projectile_d_day_mp") {
      var_1F lib_0378::func_8D74("aud_beach_mortar");
    } else {
      var_1F thread func_4A1F(param_05);
    }

    if(var_0A + 1 >= var_15) {
      var_1F thread func_7EBD(param_05, var_12, var_13);
    }

    if(isDefined(param_03)) {
      var_1F thread func_624F(param_03);
    }

    wait(var_16[var_0A]);
  }

  if(isDefined(param_03)) {
    param_03 notify("missileStrikeComplete");
  }
}

func_4A1F(param_00) {
  level endon("game_ended");
  self endon("death");
  lib_0378::func_8D74("ks_projectile_fired", param_00);
  var_01 = 2.2;
  if(var_01 > 0) {
    wait(var_01);
  }

  lib_0378::func_8D74("ks_incoming_projectile", param_00);
}

func_3B99(param_00, param_01) {
  var_02 = (param_00, param_01, func_4578());
  var_03 = var_02 + (0, 0, -10000);
  var_04 = bulletTrace(var_02, var_03, 0);
  for(var_05 = var_04["entity"]; isDefined(var_05) && isDefined(var_05.var_01C8); var_05 = var_04["entity"]) {
    var_02 = var_04["position"];
    var_04 = bulletTrace(var_02, var_03, 0, var_05);
  }

  return var_04["position"];
}

func_8C0B(param_00, param_01, param_02, param_03, param_04) {
  wait(0.35);
  var_05 = func_458D(param_00);
  var_06 = func_458B(param_00);
  var_07 = 1;
  var_08 = 0;
  var_09 = 100;
  var_0A = 1;
  var_0B = 0;
  var_0C = 1;
  var_0D = param_01;
  if(isDefined(param_04)) {
    var_0D = param_04;
  }

  if(isDefined(param_02)) {
    var_0E = getweaponexplosionradius(var_05);
    var_0F = var_0E + var_06 * 2;
    param_02 method_8351(var_0D, func_458C(param_00, 0, !var_07), var_0F, var_0F, var_0C, var_0B, "", func_458C(param_00, 1, !var_07));
    param_02 method_8352(100, var_0A);
  }

  if(isDefined(param_03)) {
    var_10 = getweaponexplosiondistancefordamage(var_05, var_08, var_09);
    var_11 = var_10 + var_06 * 2;
    param_03 method_8351(var_0D, func_458C(param_00, 0, var_07), var_11, var_11, var_0C, var_0B, "", func_458C(param_00, 1, var_07));
    param_03 method_8352(100, var_0A);
  }
}

func_624C(param_00, param_01) {
  self endon("missileStrikeComplete");
  self waittill("disconnect");
  func_238B(param_00, param_01);
}

func_624F(param_00) {
  self endon("death");
  param_00 endon("missileStrikeComplete");
  param_00 waittill("disconnect");
  self notify("killstreakOwnerDisconnect");
  self delete();
}

func_238B(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 delete();
  }

  if(isDefined(param_01)) {
    param_01 delete();
  }
}

func_7EBD(param_00, param_01, param_02) {
  self endon("killstreakOwnerDisconnect");
  self waittill("death");
  switch (param_00) {
    case "v2_rocket":
    default:
      break;
  }

  if(isDefined(param_01)) {
    param_01 method_8352(80, 0);
  }

  if(isDefined(param_02)) {
    param_02 method_8352(80, 0);
  }

  wait(0.08);
  func_238B(param_01, param_02);
}

func_6B57(param_00) {
  switch (param_00) {
    case "missile_strike":
    case "mortar_strike":
      break;
  }
}

func_458D(param_00, param_01) {
  switch (param_00) {
    case "missile_strike":
      if(isDefined(param_01) && param_01 == "allies") {
        return "missile_strike_projectile_mp";
      } else {
        return "missile_strike_projectile_axis_mp";
      }

      break;

    case "mortar_strike":
      if(isDefined(param_01) && param_01 == "allies") {
        return "mortar_strike_projectile_mp";
      } else {
        return "mortar_strike_projectile_axis_mp";
      }

      break;

    case "v2_rocket":
      return "v2_rocket_mp";
  }
}

func_458A(param_00) {
  switch (param_00) {
    case "missile_strike":
      return randomfloatrange(-250, 250);

    case "mortar_strike":
      return 0;

    case "v2_rocket":
      return randomfloatrange(-100, 100);
  }
}

func_458B(param_00) {
  switch (param_00) {
    case "missile_strike":
      return 250;

    case "mortar_strike":
      return 0;

    case "v2_rocket":
      return 100;
  }
}

func_458C(param_00, param_01, param_02) {
  switch (param_00) {
    case "missile_strike":
      if(param_01) {
        if(param_02) {
          return "scorestreak_minimap_artillery_barrage_kill_fullscreen";
        } else {
          return "scorestreak_minimap_artillery_barrage_damage_fullscreen";
        }
      } else if(param_02) {
        return "scorestreak_minimap_artillery_barrage_kill";
      } else {
        return "scorestreak_minimap_artillery_barrage_damage";
      }

      break;

    case "mortar_strike":
      if(param_01) {
        if(param_02) {
          return "scorestreak_minimap_mortar_strike_kill_fullscreen";
        } else {
          return "scorestreak_minimap_mortar_strike_damage_fullscreen";
        }
      } else if(param_02) {
        return "scorestreak_minimap_mortar_strike_kill";
      } else {
        return "scorestreak_minimap_mortar_strike_damage";
      }

      break;

    case "v2_rocket":
      return "";
  }
}

func_46DF(param_00) {
  switch (param_00) {
    case "missile_strike":
      return 0;

    case "mortar_strike":
      return 0;

    case "v2_rocket":
      return 5;
  }
}

func_46E0(param_00) {
  switch (param_00) {
    case "missile_strike":
      return 1;

    case "mortar_strike":
      return randomfloatrange(0.2, 1);

    case "v2_rocket":
      return 0;
  }
}

func_45C0(param_00, param_01, param_02) {
  if(!param_01 && isDefined(param_02) && param_02) {
    switch (param_00) {
      case "missile_strike":
        return 23;

      case "mortar_strike":
        return 1;

      case "v2_rocket":
        return 1;
    }

    return;
  }

  switch (param_00) {
    case "missile_strike":
      if(param_01 && isDefined(level.var_79C2.var_80B0) && isDefined(level.var_79C2.var_80B0.var_624A)) {
        return int(exp(18 * level.var_79C2.var_80B0.var_624A));
      } else {
        return 18;
      }

      break;

    case "mortar_strike":
      return 1;

    case "v2_rocket":
      return 1;
  }
}

func_4578() {
  switch (maps\mp\_utility::func_4571()) {
    case "mp_aachen_v2":
      return 3400;

    case "mp_airship":
      return 3500;

    case "mp_battleship_2":
      return 6400;

    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      return 3650;

    case "mp_canon_farm":
      return 3200;

    case "mp_d_day":
      return 3750;

    case "mp_flak_tower":
      return 5000;

    case "mp_forest_01":
      return 4650;

    case "mp_france_village":
      return 3200;

    case "mp_gibraltar_02":
      return 2000;

    case "mp_scorestreak_training":
      return 1600;

    case "mp_london":
      return 3400;

    case "mp_paris_s2":
      return 3300;

    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
      return 3850;

    case "mp_prague":
      return 3500;

    case "mp_market_garden":
      return 3600;

    case "mp_monte_cassino_v2":
      return 3500;

    case "mp_stalingrad":
      return 3650;

    case "mp_sandbox":
      return 2000;

    default:
      return 3200;
  }
}

getdiveheightformap() {
  switch (maps\mp\_utility::func_4571()) {
    case "mp_egypt_02":
    case "mp_canon_farm":
      return 1000;

    case "mp_stalingrad":
    case "mp_dunkirk":
    case "mp_carentan_s2":
    case "mp_sandbox_01":
    case "mp_d_day":
    case "mp_carentan_s2_winter":
    case "mp_gibraltar_02":
      return 1500;

    case "mp_aachen_v2":
    case "mp_monte_cassino_v2":
    case "mp_market_garden":
    case "mp_v2_rocket_02":
    case "mp_london":
    case "mp_flak_tower":
    case "mp_airship":
    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
    case "mp_france_village":
    case "mp_forest_01":
      return 2000;

    case "mp_prague":
    case "mp_paris_s2":
      return 2500;

    case "mp_battleship_2":
      return 3000;

    case "mp_scorestreak_training":
    default:
      return undefined;
  }
}

func_9E39(param_00, param_01) {
  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    self iclientprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  var_02 = func_83BB(param_00, param_01);
  if(!isDefined(var_02) || !var_02) {
    return 0;
  }

  maps\mp\_matchdata::func_5E9A(param_01, self.var_0116);
  return 1;
}

func_83BB(param_00, param_01) {
  self endon("stop_location_selection");
  var_02 = 0;
  var_03 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  var_04 = func_45C1(param_01, var_03);
  self setclientomnvar("ui_map_location_num_targets", var_04);
  maps\mp\_utility::func_05D4(param_01, "map_artillery_selector", var_02, func_46C2(param_01), 0.5);
  thread func_A6AB();
  var_05 = [];
  for(var_06 = 0; var_06 < var_04; var_06++) {
    self waittill("confirm_location", var_07, var_08);
    lib_0380::func_6844("mp_ks_target_select_circle_target", self, self);
    switch (param_01) {
      case "mortar_strike":
        self luinotifyevent(&"confirmed_target_location_mortar_strike", 3, var_06, int(var_07[0]), int(var_07[1]));
        self notify("single_location_selection_complete");
        break;

      case "v2_rocket":
      case "missile_strike":
        break;
    }

    var_05[var_06] = var_07;
  }

  lib_0380::func_6844("mstrike_entry_npc", maps\mp\_utility::func_45DE(self.var_01A7), self);
  lib_0380::func_6845("mstrike_entry_npc", self.var_01A7, self, self);
  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self setclientomnvar("ui_map_location_num_targets", 0);
  thread func_9303(param_00, var_05, param_01);
  return 1;
}

func_A6AB() {
  self endon("location_selection_complete");
  self endon("disconnect");
  self waittill("stop_location_selection");
  self setblurforplayer(0, 0.3);
  self setclientomnvar("ui_map_location_num_targets", 0);
  if(maps\mp\gametypes\_hostmigration::func_A782() > 0) {
    self switchtoweapon(common_scripts\utility::func_4550());
  }
}

func_46C2(param_00) {
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  var_01 = 0;
  switch (param_00) {
    case "missile_strike":
      var_01 = 1054;
      break;

    case "mortar_strike":
      var_01 = 550;
      break;

    case "v2_rocket":
      var_01 = 2000;
      break;
  }

  if(level.var_910F) {
    var_01 = var_01 * 1.5;
  }

  return var_01;
}

func_45C1(param_00, param_01) {
  if(isDefined(param_01) && param_01) {
    switch (param_00) {
      case "missile_strike":
        return 1;

      case "mortar_strike":
        return 4;

      case "v2_rocket":
        return 1;
    }

    return;
  }

  switch (param_00) {
    case "missile_strike":
      return 1;

    case "mortar_strike":
      return 3;

    case "v2_rocket":
      return 1;
  }
}