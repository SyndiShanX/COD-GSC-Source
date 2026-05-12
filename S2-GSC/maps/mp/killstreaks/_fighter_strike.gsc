/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_fighter_strike.gsc
***************************************************/

func_00D5() {
  level.var_0611["fighter_trail"] = loadfx("vfx/scorestreaks/fighter_strike_plane_trail");
  level.var_5A61["fighter_strike"] = ::func_9E2A;
  level.var_5A7D["fighter_strike_gun_mp"] = "fighter_strike";
  level.var_5A7D["fighter_strike_plane_mp"] = "fighter_strike";
  level.var_5A7D["fighter_strike_plane_grenadier_mp"] = "fighter_strike";
  setDvar("4711", "2500 2500");
}

func_9E2A(param_00) {
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  if(isDefined(self.var_6E6B) && self.var_6E6B) {
    self iclientprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(!self isonground() && !self islinked()) {
    self iclientprintlnbold(&"KILLSTREAKS_CANT_ACTIVATE_WHILE_FALLING");
    return 0;
  }

  if(isDefined(self.var_A019) && self.var_A019) {
    return 0;
  }

  if(isDefined(self.var_4B67)) {
    self iclientprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return 0;
  }

  var_01 = func_83AE(param_00, "fighter_strike");
  if(!isDefined(var_01) || !var_01) {
    return 0;
  }

  return 1;
}

func_83AE(param_00, param_01) {
  self endon("stop_location_selection");
  var_02 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
  if(!isDefined(level.var_5FF0)) {
    level.var_5FF0 = 1024;
  }

  var_03 = level.var_5FF0 / 6.46875;
  if(level.var_910F) {
    var_03 = var_03 * 1.5;
  }

  var_04 = 1;
  var_05 = func_44D7(var_02);
  var_06 = func_44D8(var_02);
  var_07 = 1400;
  if(var_02) {
    var_08 = 50;
    var_09 = 13000;
  } else {
    var_08 = 45;
    var_09 = 11000;
  }

  self setclientomnvar("ui_map_location_fighter_strike", 1);
  self setclientomnvar("ui_map_location_height", var_05);
  self setclientomnvar("ui_map_location_height_offset", var_06);
  self setclientomnvar("ui_map_location_pitch", var_08);
  self setclientomnvar("ui_map_location_introDist", var_07);
  self setclientomnvar("ui_map_location_diveDist", var_09);
  maps\mp\_utility::func_05D4(param_01, "map_artillery_selector", var_04, var_03, 0.5);
  thread lib_0527::func_A68F();
  var_0A = undefined;
  var_0B = undefined;
  var_0C = 0;
  while(!var_0C && !maps\mp\_utility::func_5668(0)) {
    self waittill("confirm_location", var_0D, var_0E, var_0F, var_10);
    if(fighterstrikemapplacementpassed(var_0D, var_0E, var_08, var_07, var_09, var_05, var_06, var_0F, var_10)) {
      var_0A = var_0D;
      var_0B = var_0E;
      self setclientomnvar("ui_map_location_use_carepackages", 0);
      self setclientomnvar("ui_map_location_fighter_strike", 0);
      self setclientomnvar("ui_map_location_height", 0);
      self setclientomnvar("ui_map_location_height_offset", 0);
      self setclientomnvar("ui_map_location_pitch", 0);
      self setclientomnvar("ui_map_location_introDist", 0);
      self setclientomnvar("ui_map_location_diveDist", 0);
      break;
    } else {
      thread lib_0527::func_8BEE();
    }
  }

  self setblurforplayer(0, 0.3);
  self notify("location_selection_complete");
  self setclientomnvar("ui_map_location_blocked", 0);
  thread func_3AA7();
  if(maps\mp\_utility::func_5668()) {
    return 0;
  }

  return func_318B(param_00, param_01, var_0A, var_0B);
}

func_318B(param_00, param_01, param_02, param_03) {
  thread func_73DA(param_01);
  self waittill("initRideKillstreak_complete", var_04);
  if(!var_04) {
    return;
  }

  self notify("used");
  maps\mp\_matchdata::func_5E9A("fighter_strike", param_02);
  if(level.var_3FDC == "scorestreak_training") {
    maps\mp\gametypes\scorestreak_training::func_244D();
  }

  self.var_3AAA = 0;
  thread func_1E83(param_00, self, param_02, param_03, "fighter_strike");
  self.var_4B67 = 1;
  return 1;
}

func_73DA(param_00) {
  var_01 = maps\mp\killstreaks\_killstreaks::func_5345(param_00, 1, 0, 0);
  if(var_01 != "success") {
    if(var_01 != "disconnect") {
      func_7445(0);
    }

    self notify("initRideKillstreak_complete", 0);
    return;
  }

  self notify("initRideKillstreak_complete", 1);
}

func_44D8(param_00) {
  if(param_00) {
    return lib_0527::func_4409() + -2750;
  }

  return lib_0527::func_4409() + -3000;
}

func_44D7(param_00) {
  var_01 = func_44D8(param_00);
  switch (maps\mp\_utility::func_4571()) {
    case "mp_raid_cobra":
      return var_01 + 2250;

    case "mp_aachen_v2":
      return var_01 + 2300;

    case "mp_battleship_2":
      return var_01 + 2100;

    case "mp_canon_farm":
      return var_01 + 2200;

    case "mp_carentan_s2":
    case "mp_carentan_s2_winter":
      return var_01 + 2250;

    case "mp_d_day":
      return var_01 + 2150;

    case "mp_flak_tower":
      return var_01 + 2050;

    case "mp_forest_01":
      return var_01 + 2250;

    case "mp_france_village":
      return var_01 + 2150;

    case "mp_gibraltar_01":
    case "mp_gibraltar_02":
      return var_01 + 2100;

    case "mp_london":
      return var_01 + 2350;

    case "mp_wolfslair2":
    case "mp_wolfslair_free":
    case "mp_wolfslair":
      return var_01 + 2350;

    case "mp_prague":
      return var_01 + 2350;

    case "mp_egypt_02":
      return var_01 + 1800;

    case "mp_house":
      return var_01 + 2400;

    case "mp_market_garden":
      return var_01 + 2300;

    case "mp_hub_scorestreak_training":
    case "mp_scorstreak_training":
    case "mp_paris_s2":
    default:
      return var_01 + 2250;
  }
}

func_1E83(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  var_06 = 0;
  if(isDefined(param_01)) {
    var_06 = param_01 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_07 = func_44D8(var_06);
  var_08 = (param_02[0], param_02[1], var_07);
  if(var_06) {
    var_09 = (50, param_03, 0);
  } else {
    var_09 = (45, param_04, 0);
  }

  if(var_06) {
    var_0A = func_44D7(var_06) - var_07 / sin(50) + 13000;
  } else {
    var_0A = func_44D7(var_07) - var_08 / sin(45) + 11000;
  }

  var_0B = var_08 + -1 * anglesToForward(var_09) * var_0A;
  var_0C = (0, param_03, 0);
  var_0B = var_0B + -1 * anglesToForward(var_0C) * 1400;
  if(isDefined(param_01)) {
    param_01 maps\mp\_utility::func_8A5B("fighter_strike");
    param_01 maps\mp\_utility::func_744E();
    param_01 maps\mp\_utility::func_3E8E(1);
    param_01 thread lib_0526::func_8A61(0.05, level.var_5A7C, level.var_5A6B);
    lib_0526::func_A232(1);
  }

  thread func_9080(param_00, param_01, var_08, var_0B, var_09, param_04, param_05);
}

func_9080(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = undefined;
  var_08 = 0;
  if(isDefined(param_01)) {
    var_08 = param_01 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  var_09 = (param_02[0], param_02[1], param_03[2]);
  if(var_08) {
    var_0A = magicbullet("fighter_strike_plane_grenadier_mp", param_03, var_09, param_01);
  } else {
    var_0A = magicbullet("fighter_strike_plane_mp", param_04, var_0A, param_02);
  }

  if(getdvarint("771", 0) == 1) {}

  var_0A thread func_49EB(param_01);
  if(isDefined(param_06)) {
    var_0A.var_01A7 = param_06;
  } else {
    var_0A.var_0117 = param_01;
    var_0A.var_01A7 = param_01.var_01A7;
  }

  var_0B = spawn("script_model", var_0A.var_0116);
  var_0B.var_001D = var_0A.var_001D;
  var_0B linkto(var_0A, "tag_origin", (0, 0, 0), (0, 0, 0));
  if(!isDefined(param_01)) {
    var_0A setentityowner(var_0B);
  }

  var_0C = undefined;
  if(isDefined(param_01)) {
    var_0C = spawn("script_model", var_0A.var_0116);
    var_0C.var_001D = var_0A.var_001D;
    var_0C method_805C();
  }

  var_0D = spawn("script_model", var_0A.var_0116);
  var_0D setModel("tag_origin");
  var_0D.var_001D = var_0A.var_001D;
  var_0A.var_5A2C = var_0D;
  var_0A.var_5A2C setscriptmoverkillcam("script_entity");
  var_0A.var_5A2C.var_5A32 = gettime();
  if(isDefined(param_01)) {
    param_01.var_700B = var_0A;
  }

  var_0E = spawn("script_model", var_0A.var_0116);
  var_0E setModel("tag_origin");
  var_0E.var_001D = var_0A.var_001D;
  var_0F = undefined;
  if(var_0A.var_01A7 == "allies") {
    var_0F = "vehicle_usa_fighter_thunderbolt_vista_fade";
    var_0B setModel(var_0F);
    var_0B thread lib_0527::func_39C6("vehicle_usa_fighter_thunderbolt_vista", 2);
    var_0B scriptmodelplayanim("ks_fighter_strafe_usa");
    playFXOnTag(level.var_0611["fighter_trail"], var_0B, "TAG_TRAIL_FX");
    if(isDefined(var_0C)) {
      var_0C linkto(var_0A, "tag_origin", (46, 0, 6), (0, 0, 0));
      var_0C setModel("usa_fighter_thunderbolt_cockpit");
      var_0C scriptmodelplayanim("vm_fighter_strafe_usa");
    }

    var_0D linkto(var_0A, "tag_origin", (30, 0, 134), (0, 0, 0));
    var_0E linkto(var_0A, "tag_origin", (30, 0, 134), (0, 0, 0));
  } else {
    var_0F = "ger_bomber_stuka_vista_fade";
    var_0B setModel(var_0F);
    var_0B thread lib_0527::func_39C6("ger_bomber_stuka_vista", 2);
    var_0B scriptmodelplayanim("ks_fighter_strafe_ger");
    playFXOnTag(level.var_0611["fighter_trail"], var_0B, "TAG_TRAIL_FX");
    if(isDefined(var_0C)) {
      var_0C linkto(var_0A, "tag_origin", (1, 0, 1), (0, 0, 0));
      var_0C setModel("ger_bomber_stuka_cockpit");
      var_0C scriptmodelplayanim("vm_fighter_strafe_ger");
    }

    var_0D linkto(var_0A, "tag_origin", (-8, 0, 130), (0, 0, 0));
    var_0E linkto(var_0A, "tag_origin", (-8, 0, 130), (0, 0, 0));
  }

  if(isDefined(param_01)) {
    var_0B hidefromclient(param_01);
    if(isDefined(var_0C)) {
      var_0C showtoclient(param_01);
    }
  }

  var_10 = 1;
  if(maps\mp\_utility::func_579B() && isDefined(param_06) && isDefined(level.var_79C2.var_80B0) && common_scripts\utility::func_562E(level.var_79C2.var_80B0.var_4D10)) {
    var_10 = 0;
  }

  if(var_10) {
    var_0A.var_620D = spawnplane("script_model", param_03);
    var_0A.var_620D setModel("tag_origin");
    var_11 = param_01;
    if(isDefined(param_06)) {
      var_11 = param_06;
    }

    var_0A.var_620D method_8351(var_11, lib_0527::func_4613(param_05), 20, 20);
    var_0A.var_620D method_8449(var_0A, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_0A.var_5CC6 = param_00;
  var_0A.var_01B9 = "remote";
  var_0A.var_01C8 = "fighter_strike";
  var_0A.var_703D = var_0B;
  var_0A.var_2489 = var_0C;
  var_0A.var_1EB5 = var_0D;
  var_0A.var_3F6E = var_0E;
  var_0A.var_29E1 = var_07;
  var_0B.var_0117 = var_0A.var_0117;
  var_0B.var_01A7 = var_0A.var_01A7;
  var_0B.var_5CC6 = param_00;
  var_0B.var_01C8 = "fighter_strike";
  var_0B.var_703C = var_0A;
  var_0B.var_5C2F = gettime();
  var_0B setCanDamage(1);
  var_0B setCanRadiusDamage(1);
  var_0B thread maps\mp\gametypes\_damage::func_8676(lib_0527::func_4612(param_05), undefined, ::func_6B36, ::func_6B35, 1);
  var_0B thread lib_0527::func_2818();
  var_0B thread lib_0527::func_4ACE();
  lib_0527::func_09E1(var_0B);
  level thread maps\mp\killstreaks\_killstreaks::func_A0DC();
  var_0A thread func_4AB8();
  thread func_637A(var_0A, param_01);
  thread func_63A8(var_0A, param_01);
  thread func_637D(var_0A, param_01);
  thread func_636E(var_0A, param_01);
  thread func_63D9(var_0A, param_01);
  if(isDefined(param_01)) {
    if(!isDefined(level.var_0611["fighter_flying_1P"])) {
      level.var_0611["fighter_flying_1P"] = loadfx("vfx/scorestreaks/ss_fighter_plane_cockpit_flying");
    }

    param_01 method_81E2(var_0D, "tag_origin");
    playfxontagforclients(common_scripts\utility::func_44F5("fighter_flying_1P"), var_0E, "tag_origin", param_01);
    var_0A thread func_27EA((900, 450, -50), param_01);
    var_0A thread func_27EA((1300, -600, -100), param_01);
    var_0A thread func_27EB(param_01);
  }

  var_0A thread func_6390(param_02, var_0F, param_06);
  var_0A endon("death");
  var_0A endon("crashing");
  var_0A waittill("pathComplete");
  var_0A thread func_2390();
}

func_3AA7() {
  lib_0380::func_6840("ks_fighter_strike_plr_into", [self]);
}

func_49EB(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    thread func_3AA5(var_01, param_00);
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(!isDefined(param_00) || var_04 != param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  if(isDefined(var_02) && var_02.size > 0) {
    thread func_3AA4(var_01, var_02);
  }
}

func_3AA5(param_00, param_01) {
  var_02 = lib_0380::func_6844("ks_fighter_strike_plr_interior", param_01, param_00);
  var_03 = lib_0380::func_6844("ks_fighter_strike_plr_engine", param_01, param_00);
  lib_0380::func_6844("ks_fighter_strike_plr_bailout", param_01, param_00);
  thread func_3AA6(param_00, param_01);
  param_00 waittill("aud_stop_player_plane_sfx");
  lib_0380::func_6850(var_02, 0.1);
  lib_0380::func_6850(var_03, 0.1);
}

func_3AA6(param_00, param_01) {
  wait(5.1);
  if(isDefined(param_00)) {
    lib_0380::func_6844("ks_fighter_strike_plr_exit", param_01, param_00);
  }
}

func_3AA4(param_00, param_01) {
  wait(1);
  lib_0380::func_6846("ks_fighter_strike_npc_flyby", param_01, param_00);
}

func_3AAB(param_00, param_01) {
  var_02 = anglesToForward(param_00.var_001D);
  var_03 = param_00.var_1EB5.var_0116 + var_02 * 500;
  var_04 = param_00.var_1EB5.var_0116 + var_02 * 20000;
  var_05 = bulletTrace(var_03, var_04, 0, param_00.var_703D);
  var_06 = var_05["position"] + var_02 * 3000;
  var_07 = param_00.var_703D gettagorigin("TAG_MUZZLE_FX_1");
  magicbullet("fighter_strike_gun_mp", var_07, var_06, param_01, undefined, undefined, 1);
  var_07 = param_00.var_703D gettagorigin("TAG_MUZZLE_FX_2");
  magicbullet("fighter_strike_gun_mp", var_07, var_06, param_01, undefined, undefined, 1);
  if(isDefined(param_01)) {
    param_01 playrumbleonentity("heavygun_fire");
  }

  thread func_3AA8(param_00, param_01);
}

func_316F(param_00, param_01) {
  param_01 endon("disconnect");
  param_01 endon("player_exit");
  param_00 endon("death");
  var_02 = anglesToForward(param_00.var_001D);
  var_03 = param_00.var_1EB5.var_0116 + var_02 * 500;
  var_04 = param_00.var_1EB5.var_0116 + var_02 * 20000;
  thread func_3162(var_03, var_04);
}

func_3162(param_00, param_01) {
  self.var_0117 method_84B4();
  var_02 = (param_01[0], param_01[1], param_01[2] - 10000);
  var_03 = bulletTrace(param_00, var_02, 0);
  var_04 = var_03["position"];
  var_05 = length(param_00 - var_04);
  self.var_0117 method_84B7(6, var_05, 1, 0.5, var_04);
}

func_3AA8(param_00, param_01) {
  if(isDefined(param_01)) {
    lib_0380::func_6840("ks_fighter_strike_plr", [param_01]);
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(!isDefined(param_01) || var_04 != param_01) {
      var_02[var_02.size] = var_04;
    }
  }

  if(isDefined(var_02) && var_02.size > 0) {
    lib_0380::func_6842("ks_fighter_strike_npc", var_02, param_00.var_0116);
  }
}

func_3AAC(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("player_exit");
  param_00 endon("death");
  for(;;) {
    if(param_01 attackButtonPressed()) {
      if(!isDefined(param_00.var_1EB5)) {
        return;
      }

      func_3AAB(param_00, param_01);
      wait(0.1);
    }

    wait 0.05;
  }
}

func_6390(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  var_03 = 0;
  if(isDefined(self.var_0117) && isPlayer(self.var_0117)) {
    var_03 = self.var_0117 maps\mp\_utility::func_0649("specialty_improvedstreaks");
  }

  if(1 && isDefined(self.var_620D)) {
    self.var_620D method_8352(2000, 1);
  }

  var_04 = spawn("script_model", (param_00[0], param_00[1], self.var_0116[2]));
  self method_81D9(var_04);
  wait(0.2);
  var_04 moveto(param_00, 1.8, 0.8, 0.4);
  wait(1.8);
  self method_81DB();
  var_04 delete();
  if(isDefined(self.var_0117) && isPlayer(self.var_0117)) {
    self.var_0117 thermalvisionfofoverlayon();
    self.var_0117 thread maps\mp\killstreaks\_killstreaks::func_0A2F();
    if(getdvarint("5270", 1)) {
      self.var_0117 setclientomnvar("ui_plane_gunner_phase", 3);
    }

    self.var_0117 method_8200(self);
    self.var_0117.var_260D = 1;
    thread func_3AAC(self, self.var_0117);
    thread func_316F(self, self.var_0117);
    self.var_0117 thread func_7CF1(self, self.var_0117);
    self.var_0117 maps\mp\_utility::func_3E8E(0);
  }

  if(maps\mp\_utility::func_579B() && isDefined(param_02) && isDefined(level.var_79C2.var_80B0) && isDefined(level.var_79C2.var_80B0.var_3AAF)) {
    thread[[level.var_79C2.var_80B0.var_3AAF]](self);
  }

  var_05 = func_44D7(var_03);
  for(;;) {
    if(self.var_0116[2] < var_05) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(self.var_0117) && isPlayer(self.var_0117) && isDefined(self.var_0117.var_260D)) {
    self.var_0117 method_8201();
    self.var_0117.var_260D = undefined;
    self.var_0117 maps\mp\_utility::func_3E8E(1);
    self.var_0117 notify("player_exit");
  }

  var_06 = (self.var_0116[0], self.var_0116[1], func_44D8(var_03));
  var_07 = (-15, self.var_001D[1], 0);
  var_08 = anglesToForward(var_07);
  var_09 = 30000 * var_08;
  self method_81DA(var_06 + var_09);
  self notify("startPullUp");
  if(maps\mp\_utility::func_579B() && isDefined(param_02)) {
    self method_866D(0, 1);
  }

  wait(1);
  if(isDefined(self.var_703D)) {
    self.var_703D notify("leaving");
    lib_0527::func_7CEE(self.var_703D);
  }

  if(1 && isDefined(self.var_620D)) {
    self.var_620D method_8352(1000, 0);
  }

  wait(7);
  if(isDefined(self.var_703D) && isDefined(param_01)) {
    self.var_703D setModel(param_01);
    self.var_703D setmaterialscriptparam(1, 0, 1);
  }

  wait(1);
  self notify("pathComplete");
}

func_6B36(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  self.var_0117 endon("disconnect");
  if(isDefined(self.var_703C)) {
    self.var_703C thread lib_0527::func_272D();
  }

  var_04 = "fighter_strike_destroyed";
  var_05 = "fighter_destroyed";
  var_06 = "callout_destroyed_fighter_strike";
  maps\mp\gametypes\_damage::func_6B4B(param_00, param_01, param_02, param_03, var_04, var_05, var_06, 1);
}

func_4AB8(param_00) {
  self endon("airstrike_complete");
  common_scripts\utility::func_A732("death", "crashing");
  if(isDefined(self)) {
    var_01 = anglesToForward(self.var_001D);
    if(!isDefined(level.var_0611["fighter_explode"])) {
      level.var_0611["fighter_explode"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
    }

    playFX(common_scripts\utility::func_44F5("fighter_explode"), self.var_0116, var_01);
    thread func_1358(param_00);
  }

  thread func_2390();
}

func_2390() {
  self notify("airstrike_complete");
  if(isDefined(self.var_29E1)) {
    thread func_36B4();
  }

  if(isDefined(self.var_703D)) {
    lib_0527::func_7CEE(self.var_703D);
    self.var_703D lib_0527::func_2DD3();
  }

  waittillframeend;
  maps\mp\gametypes\_hostmigration::func_A782();
  if(isDefined(self.var_703D)) {
    self.var_703D delete();
  }

  if(isDefined(self.var_2489)) {
    self.var_2489 delete();
  }

  if(isDefined(self.var_1EB5)) {
    self.var_1EB5 delete();
  }

  if(isDefined(self.var_3F6E)) {
    self.var_3F6E delete();
  }

  if(isDefined(self.var_620D)) {
    self.var_620D delete();
  }

  if(isDefined(self.var_0117)) {
    self.var_0117.var_700B = undefined;
  }

  if(isDefined(self)) {
    self delete();
  }
}

func_36B4() {
  var_00 = self.var_29E1;
  self.var_29E1 = undefined;
  if(isDefined(var_00)) {
    var_00 method_8352(lib_0527::func_4516(), 0);
  }

  wait(lib_0527::func_4516() / 1000);
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

func_1358(param_00) {
  var_01 = self;
  if(isDefined(param_00)) {
    lib_0380::func_6842("ks_plane_destruct_plr_explode", [param_00], self.var_0116);
  }

  var_02 = [];
  foreach(var_04 in level.var_744A) {
    if(!isDefined(param_00) || var_04 != param_00) {
      var_02[var_02.size] = var_04;
    }
  }

  if(isDefined(var_02) && var_02.size > 0) {
    lib_0380::func_6842("ks_plane_destruct_explode", var_02, self.var_0116);
  }
}

func_637A(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  param_00 endon("StopWaitForDeathorTimeout");
  param_00 common_scripts\utility::func_A70A("death", "crashing");
  param_00 notify("StopWaitForLeavingAirspace");
  param_00 notify("StopWaitForExitCommand");
  param_00 notify("StopWaitForChangeTeams");
  param_00 notify("StopWaitForRoundSwitch");
  param_00 notify("StopWaitForDisconnect");
  waittillframeend;
  maps\mp\gametypes\_hostmigration::func_A782();
  if(isDefined(param_01)) {
    param_01 thread func_7445(0, param_00);
  }

  param_00 notify("deathOrTimeout");
}

func_63A8(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  param_00 endon("StopWaitForLeavingAirspace");
  param_00.var_703D waittill("leaving");
  param_00 notify("StopWaitForDeathorTimeout");
  param_00 notify("StopWaitForExitCommand");
  param_00 notify("StopWaitForChangeTeams");
  param_00 notify("StopWaitForRoundSwitch");
  param_00 notify("StopWaitForDisconnect");
  if(isDefined(param_01)) {
    param_01 thread func_7445(0, param_00);
  }

  if(isDefined(param_00.var_29E1)) {
    param_00 thread func_36B4();
  }

  param_00 notify("leavingPlayspace");
}

func_637D(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("StopWaitForDisconnect");
  if(!isDefined(param_01)) {
    return;
  }

  param_01 waittill("disconnect");
  param_00 notify("StopWaitForLeavingAirspace");
  param_00 notify("StopWaitForDeathorTimeout");
  param_00 notify("StopWaitForExitCommand");
  param_00 notify("StopWaitForChangeTeams");
  param_00 notify("StopWaitForRoundSwitch");
  param_00 lib_0527::func_272D();
}

func_636E(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("StopWaitForChangeTeams");
  if(!isDefined(param_01)) {
    return;
  }

  param_01 common_scripts\utility::func_A70A("joined_team", "joined_spectators");
  param_00 notify("StopWaitForLeavingAirspace");
  param_00 notify("StopWaitForDeathorTimeout");
  param_00 notify("StopWaitForExitCommand");
  param_00 notify("StopWaitForDisconnect");
  param_00 notify("StopWaitForRoundSwitch");
  thread func_7445(0, param_00);
  param_00 thread lib_0527::func_272D();
}

func_63D9(param_00, param_01) {
  param_00 endon("StopWaitForRoundSwitch");
  level waittill("game_ended");
  param_00 notify("StopWaitForLeavingAirspace");
  param_00 notify("StopWaitForDeathorTimeout");
  param_00 notify("StopWaitForExitCommand");
  param_00 notify("StopWaitForDisconnect");
  param_00 notify("StopWaitForChangeTeams");
  if(isDefined(param_01)) {
    param_01 setclientomnvar("ui_plane_gunner_phase", 0);
  }

  if(isDefined(param_01)) {
    param_01 thread func_7445(0, param_00);
  }

  param_00 thread lib_0527::func_272D();
}

func_7CF1(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 endon("StopWaitForExitCommand");
  if(!isbot(param_01)) {
    param_01 notifyonplayercommand("ExitButtonDown", "+activate");
    param_01 notifyonplayercommand("ExitButtonUp", "-activate");
  }

  param_01 notifyonplayercommand("ExitButtonDown", "+usereload");
  param_01 notifyonplayercommand("ExitButtonUp", "-usereload");
  for(;;) {
    param_01 waittill("ExitButtonDown");
    thread func_92CB(param_00, param_01);
    thread func_1F3A();
  }
}

func_92CB(param_00, param_01) {
  param_00 endon("StopWaitForExitCommand");
  param_01 endon("ExitButtonUp");
  self.var_3AA9 = 1;
  wait(0.5);
  if(self.var_3AA9 == 1) {
    param_00 notify("StopWaitForLeavingAirspace");
    param_00 notify("StopWaitForDeathorTimeout");
    param_00 notify("StopWaitForDisconnect");
    param_00 notify("StopWaitForChangeTeams");
    param_00 notify("StopWaitForRoundSwitch");
    param_00 notify("aud_stop_player_plane_sfx");
    thread func_7445(0, param_00);
    param_00 notify("StopWaitForExitCommand");
  }
}

func_1F3A() {
  self endon("disconnect");
  self waittill("ExitButtonUp");
  self.var_3AA9 = 0;
}

func_7445(param_00, param_01) {
  self endon("disconnect");
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  maps\mp\_utility::func_3E8E(1);
  self setclientomnvar("fov_scale", 1);
  if(!isbot(self)) {
    self notifyonplayercommandremove("ExitButtonDown", "+activate");
    self notifyonplayercommandremove("ExitButtonUp", "-activate");
  }

  self notifyonplayercommandremove("ExitButtonDown", "+usereload");
  self notifyonplayercommandremove("ExitButtonUp", "-usereload");
  if(param_00) {
    wait(0.5);
    maps\mp\gametypes\_hostmigration::func_A782();
  }

  self thermalvisionfofoverlayoff();
  self notify("clearAerialKillstreakMarkers");
  if(maps\mp\_utility::func_57A0(self)) {
    self setclientomnvar("ui_plane_gunner_phase", 0);
  } else {
    thread func_4D08();
  }

  if(isDefined(param_01)) {
    if(isDefined(param_01.var_2489)) {
      param_01.var_2489 hidefromclient(self);
    }

    if(isDefined(param_01.var_703D)) {
      param_01.var_703D showtoclient(self);
    }

    if(isDefined(param_01.var_1EB5)) {
      param_01.var_1EB5 unlink();
    }

    if(isDefined(param_01.var_3F6E)) {
      function_0295(common_scripts\utility::func_44F5("fighter_flying_1P"), param_01.var_3F6E, "tag_origin", self);
    }
  }

  self method_84B6();
  self method_81E3();
  if(isDefined(self.var_260D)) {
    self method_8201();
    self.var_260D = undefined;
  }

  maps\mp\_utility::func_3E8E(0);
  if(maps\mp\_utility::func_581D()) {
    maps\mp\_utility::func_2414();
  }

  if(getdvarint("311")) {
    maps\mp\_utility::func_8742(1);
  }

  self setshadows(1);
  lib_0526::func_7D04(0.05);
  lib_0526::func_A232(0);
  maps\mp\_utility::func_7447();
  self.var_4B67 = undefined;
  self notify("player_exit");
}

func_4D08() {
  self endon("disconnect");
  self waittill("spawned");
  wait 0.05;
  self setclientomnvar("ui_plane_gunner_phase", 0);
}

func_A68D(param_00) {
  self endon("airstrike_complete");
  level endon("game_ended");
  self endon("disconnect");
  wait(param_00);
  self setshadows(0);
}

func_6B35(param_00, param_01, param_02, param_03) {
  if(isDefined(self.var_0117)) {}

  return lib_0527::func_6B9C(param_00, param_01, param_02, param_03);
}

func_27EA(param_00, param_01) {
  var_02 = self.var_0116 + rotatevector(param_00, self.var_001D);
  var_03 = var_02 + anglesToForward(self.var_001D) * 6000;
  var_04 = 5;
  var_05 = spawn("script_model", var_02);
  var_05.var_001D = self.var_001D;
  if(isDefined(self.var_01A7) && self.var_01A7 == "allies") {
    var_05 setModel("vehicle_usa_fighter_thunderbolt_vista");
    var_05 scriptmodelplayanim("ks_fighter_strafe_usa");
  } else {
    var_05 setModel("ger_bomber_stuka_vista");
    var_05 scriptmodelplayanim("ks_fighter_strafe_ger");
  }

  var_05 method_805C();
  var_05 showtoclient(param_01);
  var_05 moveto(var_03, var_04);
  common_scripts\utility::func_A71A(var_04, "StopWaitForExitCommand");
  if(isDefined(var_05)) {
    var_05 delete();
  }
}

func_27EB(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = self.var_0116 + rotatevector((3500, 750, 500), self.var_001D);
  var_02 = spawn("script_model", var_01);
  var_02.var_001D = self.var_001D;
  var_02 setModel("tag_origin");
  if(!isDefined(level.var_0611["fighter_clouds_1P"])) {
    level.var_0611["fighter_clouds_1P"] = loadfx("vfx/scorestreaks/ss_fighter_plane_clouds");
  }

  playfxontagforclients(common_scripts\utility::func_44F5("fighter_clouds_1P"), var_02, "tag_origin", param_00);
  common_scripts\utility::func_A71A(5, "StopWaitForExitCommand");
  if(isDefined(var_02)) {
    function_0294(common_scripts\utility::func_44F5("fighter_clouds_1P"), var_02, "tag_origin", param_00);
    var_02 delete();
  }
}