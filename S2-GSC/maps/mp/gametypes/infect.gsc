/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\infect.gsc
*********************************************/

func_00F9() {
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.var_3FDC, 10);
    maps\mp\_utility::func_86EA("scorelimit", 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6032 = 1;
    level.var_6031 = 0;
  }

  func_872E();
  setdvarifuninitialized("spv_tesla_mp_active", 0);
  maps\mp\_utility::func_873B(1);
  level.var_329D = 1;
  level.var_2F85 = 1;
  level.var_6702 = 1;
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6AE2 = ::func_6AE2;
  level.var_6BB6 = ::func_6BB6;
  level.var_1385 = ::func_5117;
  level.var_1DEA = ::func_511A;
  level.gametypemovespeedscalefunc = ::infectedmovespeedscale;
  level.var_2FAB = 1;
  level.disabledivisionstats = 1;
  level.var_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 1;
  if(level.var_6031) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "inf_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["inf_finalone"] = "inf_finalone";
  game["dialog"]["inf_infected"] = "inf_infected";
  game["dialog"]["inf_timeadded"] = "inf_timeadded";
  level.var_0611["mp_infected_zombie_vision_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_01");
  level.var_0611["mp_infected_zombie_vision_spltscrn_01"] = loadfx("vfx/unique/mp_infected_zombie_vision_spltscrn_01");
  level.var_0611["infected_turn_lightning_01"] = loadfx("vfx/unique/infected_turn_lightning_01");
  level.var_0611["tesla_gun_glow"] = loadfx("vfx/unique/mp_loot_ray_01");
}

func_5300() {
  maps\mp\_utility::func_8653();
  level.var_6032 = getmatchrulesdata("infectData", "numInitialInfected");
  setdynamicdvar("scr_" + level.var_3FDC + "_numLives", 0);
  maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
  maps\mp\_utility::func_86EA("scorelimit", 0);
  setdynamicdvar("scr_infect_roundswitch", 0);
  maps\mp\_utility::func_7BF8("infect", 0, 0, 9);
  setdynamicdvar("scr_infect_roundlimit", 1);
  maps\mp\_utility::func_7BF7("infect", 1);
  setdynamicdvar("scr_infect_winlimit", 1);
  maps\mp\_utility::func_7C04("infect", 1);
  setdynamicdvar("scr_infect_halftime", 0);
  maps\mp\_utility::func_7BE5("infect", 0);
  setdynamicdvar("scr_infect_playerrespawndelay", 0);
  setdynamicdvar("scr_infect_waverespawndelay", 0);
  setdynamicdvar("scr_player_forcerespawn", 1);
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("scr_game_hardpoints", 0);
  setDvar("3193", 1);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_INFECT");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_INFECT");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_INFECT");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_INFECT");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_INFECT_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_INFECT_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_INFECT_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_INFECT_HINT");
  lib_050D::func_10E4();
  var_00[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level.var_7895 = 1;
  level.var_17EF = 1;
  level.var_510F = 0;
  level.var_5111 = 0;
  level.var_5110 = 0;
  level.var_5112 = 0;
  level.var_5116["axis"] = 0;
  level.var_5116["allies"] = 0;
  level.var_5115 = [];
  level.mgnestsdisabled = 1;
  level thread maps\mp\gametypes\_raid_tripwire::runtripwirelogic();
  level thread func_6B6C();
  level thread func_3FD8();
}

func_3FD8() {
  level endon("game_ended");
  setdynamicdvar("scr_infect_timelimit", 0);
  var_00 = 0;
  var_01 = undefined;
  var_02 = 2;
  var_03 = 1;
  for(;;) {
    level waittill("update_game_time", var_04, var_05);
    var_01 = undefined;
    if(isDefined(var_05) && var_05) {
      var_01 = maps\mp\_utility::func_46E3() / -5536 + var_02;
    } else if(isDefined(var_04) && var_04 == 1) {
      var_06 = var_03 * 0.1666667 + var_02;
    } else {
      var_03++;
      var_01 = var_03 * 0.1666667 + var_02;
    }

    setdynamicdvar("scr_infect_timelimit", var_01);
    level thread func_A91E(var_01);
    if(var_00) {
      level thread maps\mp\_utility::func_5C3E("inf_timeadded", "axis", "inf_timeadded", "allies", "status");
    }

    var_00 = 1;
  }
}

func_A91E(param_00) {
  level notify("watchHostMigration");
  level endon("watchHostMigration");
  level endon("game_ended");
  level waittill("host_migration_begin");
  setdynamicdvar("scr_infect_timelimit", 0);
  waittillframeend;
  setdynamicdvar("scr_infect_timelimit", 0);
  level waittill("host_migration_end");
  level notify("update_game_time", param_00);
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_511C = 0;
    var_00.var_5A51 = 0;
    if(!isai(var_00) && !function_026D(var_00)) {
      var_00 thread monitorinfectedafk();
    }

    if(maps\mp\_utility::func_3FA0("prematch_done")) {
      if(isDefined(level.var_5111) && level.var_5111) {
        var_00.var_9521 = gettime();
      }
    }

    if(isDefined(level.var_5115[var_00.var_0109])) {
      var_00.var_511C = 1;
    }

    var_00 thread func_63E8();
    var_00 thread maps\mp\gametypes\_weapons::initteslagun();
  }
}

monitorinfectedafk() {
  level endon("game_ended");
  self endon("disconnect");
  self notifyonplayercommand("buttonPressed", "+usereload");
  self notifyonplayercommand("buttonPressed", "+stance");
  self notifyonplayercommand("buttonPressed", "+weapnext");
  self notifyonplayercommand("buttonPressed", "+sprint");
  self notifyonplayercommand("buttonPressed", "+attack");
  self notifyonplayercommand("buttonPressed", "+activate");
  self notifyonplayercommand("buttonPressed", "+gostand");
  self notifyonplayercommand("buttonPressed", "+melee_zoom");
  self notifyonplayercommand("buttonPressed", "+breath_sprint");
  self notifyonplayercommand("buttonPressed", "+speed_throw");
  self notifyonplayercommand("buttonPressed", "+frag");
  self notifyonplayercommand("buttonPressed", "+smoke");
  thread disconnectifnobuttonPressed();
  self waittill("buttonPressed");
  self notifyonplayercommandremove("buttonPressed", "+usereload");
  self notifyonplayercommandremove("buttonPressed", "+stance");
  self notifyonplayercommandremove("buttonPressed", "+weapnext");
  self notifyonplayercommandremove("buttonPressed", "+sprint");
  self notifyonplayercommandremove("buttonPressed", "+attack");
  self notifyonplayercommandremove("buttonPressed", "+activate");
  self notifyonplayercommandremove("buttonPressed", "+gostand");
  self notifyonplayercommandremove("buttonPressed", "+melee_zoom");
  self notifyonplayercommandremove("buttonPressed", "+breath_sprint");
  self notifyonplayercommandremove("buttonPressed", "+speed_throw");
  self notifyonplayercommandremove("buttonPressed", "+frag");
  self notifyonplayercommandremove("buttonPressed", "+smoke");
}

disconnectifnobuttonPressed() {
  self endon("buttonPressed");
  self endon("disconnect");
  level endon("game_ended");
  wait(75);
  self notifyonplayercommandremove("buttonPressed", "+usereload");
  self notifyonplayercommandremove("buttonPressed", "+stance");
  self notifyonplayercommandremove("buttonPressed", "+weapnext");
  self notifyonplayercommandremove("buttonPressed", "+sprint");
  self notifyonplayercommandremove("buttonPressed", "+attack");
  self notifyonplayercommandremove("buttonPressed", "+activate");
  self notifyonplayercommandremove("buttonPressed", "+gostand");
  self notifyonplayercommandremove("buttonPressed", "+melee_zoom");
  self notifyonplayercommandremove("buttonPressed", "+breath_sprint");
  self notifyonplayercommandremove("buttonPressed", "+speed_throw");
  self notifyonplayercommandremove("buttonPressed", "+frag");
  self notifyonplayercommandremove("buttonPressed", "+smoke");
  if(!self ishost()) {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
    level thread maps\mp\gametypes\_gamelogic::func_A11E();
  }
}

infectedmovespeedscale() {
  if(self.var_012C["team"] == "axis") {
    if(isDefined(self.infectedboost) && self.infectedboost) {
      return 1.35;
    }

    return 1.1;
  }

  return 1;
}

func_5117() {
  var_00 = "allies";
  if(self.var_511C) {
    var_00 = "axis";
  }

  thread maps\mp\gametypes\_menus::func_873A(var_00);
}

func_511A() {
  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "";
  self.var_012C["gamemodeLoadout"] = level.var_5114[self.var_012C["team"]];
  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
  func_7685();
}

func_7685() {
  var_00 = [];
  foreach(var_02 in level.var_5114) {
    if(isDefined(var_02["loadoutPrimaryWeaponStruct"]) && isDefined(var_02["loadoutPrimaryWeaponStruct.GUID"]) && var_02["loadoutPrimaryWeaponStruct.GUID"] != 17273856 && var_02["loadoutPrimaryWeaponStruct.GUID"] != 0) {
      var_00[var_00.size] = maps\mp\_utility::func_4737(var_02["loadoutPrimaryWeaponStruct"]);
    }

    if(isDefined(var_02["loadoutSecondaryWeaponStruct"]) && isDefined(var_02["loadoutSecondaryWeaponStruct.GUID"]) && var_02["loadoutSecondaryWeaponStruct.GUID"] != 17273856 && var_02["loadoutSecondaryWeaponStruct.GUID"] != 0) {
      var_00[var_00.size] = maps\mp\_utility::func_4737(var_02["loadoutSecondaryWeaponStruct"]);
    }
  }

  if(var_00.size > 0) {
    self method_8512(var_00);
  }
}

func_6BA7() {
  if(isDefined(self.var_984E)) {
    self.var_012C["gamemodeLoadout"] = level.var_5114[self.var_012C["team"]];
    maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
    thread func_637D();
  }

  self.var_984E = undefined;
  func_7685();
  func_A175();
  if(!level.var_5110) {
    level.var_5110 = 1;
    level thread func_220B();
  }

  if(self.var_511C) {
    if(!level.var_510F) {
      level notify("infect_stopCountdown");
      level.var_5111 = 1;
      level.var_510F = 1;
      foreach(var_01 in level.var_744A) {
        if(isDefined(var_01.var_5113)) {
          var_01.var_5113 = undefined;
        }
      }
    }

    foreach(var_01 in level.var_744A) {
      if(isDefined(var_01.var_5726)) {
        var_01 thread func_86B1();
      }
    }

    if(level.var_5116["axis"] == 1) {
      self.var_5726 = 1;
    }

    func_240F();
  }

  if(isDefined(self.var_5726)) {
    self.var_012C["gamemodeLoadout"] = level.var_5114["axis_initial"];
    maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
  }

  thread func_6BA4();
  level notify("spawned_player");
}

func_6BA4() {
  self endon("death");
  self endon("disconnect");
  self waittill("applyLoadout");
  func_A12F();
}

func_A12F() {
  if(self.var_012C["team"] == "allies") {
    self method_8626("mute_non_infected_vo");
  }

  if(self.var_012C["team"] == "axis") {
    maps\mp\killstreaks\_killstreaks::func_2400();
    thread func_86AF();
    thread func_86AE();
    maps\mp\_utility::func_47A2("specialty_lightweight");
    maps\mp\_utility::func_47A2("specialty_fastclimb");
    maps\mp\_utility::func_47A2("specialty_fastmantle");
    maps\mp\_utility::func_47A2("specialty_falldamage");
    maps\mp\gametypes\_weapons::func_A13B();
    if(!isai(self) && !function_026D(self)) {
      var_00 = undefined;
      if(self issplitscreenplayer()) {
        var_00 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_spltscrn_01");
      } else {
        var_00 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_01");
      }

      playfxontagforclients(var_00, self, "j_head", self);
    }

    if(isDefined(self.infectedboost) && self.infectedboost) {
      self.var_00FB = 200;
      self.var_00BC = 200;
    }

    self method_82CD();
    thread playzombienoises();
  }
}

playzombienoises() {
  self endon("death");
  level endon("game_ended");
  self method_8626("mute_non_infected_vo");
  self method_8617("zvox_gen_spawn");
  for(;;) {
    switch (randomint(7)) {
      case 0:
        self method_8617("zvox_gen_snarl");
        break;

      case 1:
        self method_8617("zvox_gen_growl_lev1");
        break;

      case 3:
        self method_8617("zvox_gen_pain_lrg");
        break;

      case 5:
        self method_8617("zvox_gen_sneakattack_success");
        break;

      case 6:
        self method_8617("zvox_gen_taunt");
        break;

      default:
        self method_8617("zvox_gen_snarl");
        break;
    }

    wait(randomfloatrange(1.5, 6));
  }
}

func_86AE() {
  self setcostumemodels([492, 492, 0, 0, 0], "axis", 1, 0);
}

func_86AF() {
  if(!isDefined(self.var_8C0E) || !self.var_8C0E) {
    thread maps\mp\_events::func_4817();
    self method_860F("mp_inf_got_infected", self);
    thread maps\mp\_utility::func_5C43("inf_infected", "status");
    self.var_8C0E = 1;
  }
}

func_220B() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level.var_510F = 0;
  maps\mp\_utility::func_3FA5("prematch_done");
  level.var_5112 = 1;
  maps\mp\gametypes\_hostmigration::func_A6F5(1);
  var_00 = 15;
  setomnvar("ui_match_countdown_title", 7);
  setomnvar("ui_match_countdown_toggle", 1);
  while(var_00 > 0 && !level.var_3F9D) {
    var_00--;
    setomnvar("ui_match_countdown", var_00 + 1);
    maps\mp\gametypes\_hostmigration::func_A6F5(1);
  }

  setomnvar("ui_match_countdown", 0);
  setomnvar("ui_match_countdown_title", 0);
  setomnvar("ui_match_countdown_toggle", 0);
  level.var_5112 = 0;
  var_01 = [];
  var_02 = undefined;
  foreach(var_04 in level.var_744A) {
    if(maps\mp\_utility::func_602B() && level.var_744A.size > 1 && var_04 ishost()) {
      var_02 = var_04;
      continue;
    }

    if(var_04.var_01A7 == "spectator") {
      continue;
    }

    if(!var_04.var_4B96) {
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  if(!var_01.size && isDefined(var_02)) {
    var_01[var_01.size] = var_02;
  }

  var_06 = var_01[randomint(var_01.size)];
  var_06 func_8682(1);
  lib_0380::func_6844("mp_zmb_infect_turn_init", undefined, var_06);
  foreach(var_04 in level.var_744A) {
    if(var_04 == var_06) {
      continue;
    }

    var_04.var_9521 = gettime();
  }

  level thread randomcarepackagespawner();
}

randomcarepackagespawner() {
  level endon("game_ended");
  for(;;) {
    wait(30);
    if(getteamplayersalive("allies") > 0) {
      var_00 = getrandomnodenearsurvivor();
      if(isDefined(var_00)) {
        level thread callinrandomcarepackage(var_00);
      }
    }
  }
}

getrandomnodenearsurvivor() {
  var_00 = undefined;
  foreach(var_02 in common_scripts\utility::func_0F92(level.var_9859["allies"])) {
    var_00 = getnodesinradius(var_02.var_0116, 800, 0, 1000, "Path");
    if(isDefined(var_00) && var_00.size > 0) {
      foreach(var_04 in common_scripts\utility::func_0F92(var_00)) {
        if(isDefined(var_04) && nodeexposedtosky(var_04)) {
          return var_04;
        }
      }
    }
  }

  var_00 = getnodesinradius((0, 0, 0), 10000, 0, 10000, "Path");
  var_07 = undefined;
  foreach(var_04 in common_scripts\utility::func_0F92(var_00)) {
    if(isDefined(var_04) && nodeexposedtosky(var_04)) {
      return var_04;
    }
  }

  return common_scripts\utility::func_7A33(var_00);
}

callinrandomcarepackage(param_00) {
  var_01 = undefined;
  var_02 = common_scripts\utility::func_0F92(level.var_744A);
  foreach(var_04 in var_02) {
    if(var_04.var_01A7 != "allies") {
      continue;
    }

    var_01 = var_04;
    break;
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_06 = common_scripts\utility::func_7A33(["tripwire", "tripwire", "flamethrower", "flamethrower", "v2_rocket"]);
  var_07 = lib_0527::func_4570();
  var_01 thread lib_0527::func_9302(var_01.var_5CC6, [param_00.var_0116], [var_07], "carepackage", undefined, "allies", var_06);
}

func_76A2() {
  while(!maps\mp\_utility::func_57A0(self) || maps\mp\_utility::func_581D()) {
    wait 0.05;
  }

  if(isDefined(self.var_56A3) && self.var_56A3 == 1) {
    self notify("force_cancel_placement");
    wait 0.05;
  }

  while(self method_8128()) {
    wait 0.05;
  }

  while(self method_82E4()) {
    wait 0.05;
  }

  while(!self isonground() && !self method_801D()) {
    wait 0.05;
  }

  wait 0.05;
  while(!maps\mp\_utility::func_57A0(self)) {
    wait 0.05;
  }
}

func_8682(param_00) {
  self endon("disconnect");
  func_76A2();
  if(param_00) {
    self.var_5113 = 1;
    maps\mp\gametypes\_menus::func_09FC("axis", undefined, 1);
    thread func_637D();
    level.var_5111 = 1;
    self.var_5113 = undefined;
    self.infectedboost = 0;
    thread watchforfirstinfectedkill();
    level notify("update_game_time", 0, 1);
    func_A175();
    level.var_510F = 1;
    level.var_5115[self.var_0109] = 1;
    if(!isai(self) && !function_026D(self)) {
      var_01 = undefined;
      if(self issplitscreenplayer()) {
        var_01 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_spltscrn_01");
      } else {
        var_01 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_01");
      }

      playfxontagforclients(var_01, self, "j_head", self);
    }

    var_02 = common_scripts\utility::func_44F5("infected_turn_lightning_01");
    playFXOnTag(var_02, self, "tag_origin");
  }

  self.var_5726 = 1;
  self.var_8C0E = 1;
  self notify("faux_spawn");
  self.var_012C["gamemodeLoadout"] = level.var_5114["axis_initial"];
  maps\mp\gametypes\_class::func_4773(self.var_01A7, "gamemode");
  func_A12F();
  thread maps\mp\_events::func_3C69();
  self method_860F("mp_inf_got_infected", self);
  thread maps\mp\_utility::func_5C43("inf_infected", "status");
  func_240F();
}

func_86B1() {
  level endon("game_ended");
  self.var_5726 = undefined;
  func_76A2();
  self notify("gotFirstInfectedKill");
  if(isDefined(self.infectedboost) && self.infectedboost) {
    self.var_00FB = 100;
    self.infectedboost = 0;
  }

  self notify("faux_spawn");
  self.var_012C["gamemodeLoadout"] = level.var_5114["axis"];
  thread func_6BA4();
  maps\mp\gametypes\_class::func_4773(self.var_01A7, "gamemode");
}

watchforfirstinfectedkill() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gotFirstInfectedKill");
  wait(60);
  self.infectedboost = 1;
  if(getdvarint("spv_infect_throwing_knives_enabled", 0) == 1) {
    level.var_5114["axis_initial"]["loadoutEquipmentStruct"] = maps\mp\_utility::func_473C(16818176, 0);
    if(maps\mp\_utility::func_57A0(self)) {
      self.var_012C["gamemodeLoadout"] = level.var_5114["axis_initial"];
      maps\mp\gametypes\_class::func_4773(self.var_01A7, "gamemode");
      func_A12F();
      if(isDefined(self.var_872A)) {
        maps\mp\perks\_perkfunctions::func_2D54(self.var_872A);
      }
    }
  }

  if(maps\mp\_utility::func_57A0(self)) {
    self.var_00FB = 200;
    self.var_00BC = 200;
    maps\mp\gametypes\_weapons::func_A13B();
  }
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_01)) {
    return;
  }

  if(self.var_01A7 == "axis" && isPlayer(param_01) && param_01.var_01A7 == "allies" && maps\mp\_utility::func_5755(param_03)) {
    param_01 maps\mp\gametypes\_missions::func_7750("ch_infect_tooclose");
  }

  if(self.var_01A7 == "axis") {
    if(getdvarint("spv_tesla_mp_active", 0) == 1) {
      level thread maps\mp\gametypes\_weapons::potentiallyspawnteslagun(self.var_0116, 10);
    }

    param_01 lib_0468::ae_sendzombiekillevent(param_04, param_03);
    return;
  }

  var_0A = param_01 == self || !isPlayer(param_01);
  if(var_0A && !level.var_510F) {
    return;
  }

  level notify("update_game_time");
  foreach(var_0C in level.var_744A) {
    var_0C thread maps\mp\gametypes\_hud_message::func_9102("infect_time_added");
  }

  self notify("delete_explosive_drones");
  self.var_984E = 1;
  maps\mp\gametypes\_menus::func_09FC("axis");
  func_8738(1);
  func_511A();
  func_A175();
  maps\mp\_utility::func_74D9("mp_enemy_obj_captured", "allies");
  maps\mp\_utility::func_74D9("mp_war_objective_taken", "axis");
  level.var_5115[self.var_0109] = 1;
  level thread maps\mp\_utility::func_9863("callout_got_infected", self, "allies");
  lib_0380::func_6845("mp_zmb_infect_turn_3d", level.var_744A, self, self);
  lib_0380::func_6840("mp_zmb_infect_turn_plr", self);
  if(!var_0A) {
    param_01 maps\mp\_utility::func_2CED(0.05, ::maps\mp\_events::func_511D);
    param_01 method_860F("mp_inf_infection_kill", param_01);
    param_01.var_5A51++;
    param_01 maps\mp\_utility::func_867C(param_01.var_5A51);
    if(param_01.var_5A51 % 3 == 0) {
      param_01 maps\mp\_utility::func_2CED(0.05, ::maps\mp\_events::func_700A);
    }
  }

  if(level.var_5116["axis"] == 2) {
    foreach(var_0C in level.var_744A) {
      if(isDefined(var_0C.var_5726)) {
        var_0C thread func_86B1();
      }
    }
  }

  if(level.var_5116["allies"] == 0) {
    func_6BB3();
    return;
  }

  if(level.var_5116["allies"] == 1) {
    func_6B37();
  }
}

func_6B37() {
  foreach(var_01 in level.var_744A) {
    if(!isDefined(var_01)) {
      continue;
    }

    if(var_01.var_01A7 != "allies") {
      continue;
    }

    if(isDefined(var_01.var_1456)) {
      continue;
    }

    var_01.var_1456 = 1;
    var_01 thread maps\mp\_events::func_3B5F();
    var_01 thread maps\mp\_utility::func_5C43("inf_finalone");
    level thread maps\mp\_utility::func_5C39("inf_finalone", "axis");
    level thread func_3B60(var_01);
    break;
  }
}

func_3B60(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("eliminated");
  level endon("infect_lateJoiner");
  level thread func_36EE(param_00);
  var_01 = 0;
  level.var_014C["axis"] = "normal_radar";
  foreach(var_03 in level.var_744A) {
    if(var_03.var_01A7 == "axis") {
      var_03.var_014C = "normal_radar";
    }
  }

  setteamradarstrength("axis", 1);
  for(;;) {
    var_05 = param_00.var_0116;
    wait(4);
    if(var_01) {
      setteamradar("axis", 0);
      var_01 = 0;
    }

    wait(6);
    if(distance(var_05, param_00.var_0116) < 200) {
      setteamradar("axis", 1);
      var_01 = 1;
      foreach(var_03 in level.var_744A) {
        var_03 method_8615("recondrone_tag");
      }
    }
  }
}

func_36EE(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("eliminated");
  for(;;) {
    if(level.var_5116["allies"] > 1) {
      level notify("infect_lateJoiner");
      wait 0.05;
      setteamradar("axis", 0);
      break;
    }

    wait 0.05;
  }
}

func_637D() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var_00 = self.var_01A7;
  if(!isDefined(var_00) && isDefined(self.var_1AFA)) {
    var_00 = self.var_1AFA;
  }

  self waittill("disconnect");
  func_A175();
  if(isDefined(self.var_5113) || level.var_5111) {
    if(level.var_5116["axis"] && level.var_5116["allies"]) {
      if(var_00 == "allies" && level.var_5116["allies"] == 1) {
        func_6B37();
      } else if(var_00 == "axis" && level.var_5116["axis"] == 1) {
        foreach(var_02 in level.var_744A) {
          if(var_02 != self && var_02.var_01A7 == "axis") {
            var_02 func_8682(0);
          }
        }
      }
    } else if(level.var_5116["allies"] == 0) {
      func_6BB3();
    } else if(level.var_5116["axis"] == 0) {
      if(level.var_5116["allies"] == 1) {
        level.var_3B5C = "allies";
        level thread maps\mp\gametypes\_gamelogic::func_36B9("allies", game["end_reason"]["infected_eliminated"]);
      } else if(level.var_5116["allies"] > 1) {
        level.var_5111 = 0;
        level thread func_220B();
      }
    }
  } else if(level.var_5112 && level.var_5116["allies"] == 0 && level.var_5116["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.var_5110 = 0;
    setomnvar("ui_match_start_countdown", 0);
  }

  self.var_5726 = undefined;
}

func_6AE2(param_00) {}

func_6BB6() {
  level.var_3B5C = "allies";
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_01A7) && var_01.var_01A7 == "axis") {
      if(!isai(var_01) && !function_026D(var_01)) {
        var_02 = undefined;
        if(var_01 issplitscreenplayer()) {
          var_02 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_spltscrn_01");
        } else {
          var_02 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_01");
        }

        function_0295(var_02, var_01, "j_head", var_01);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::func_36B9("allies", game["end_reason"]["time_limit_reached"]);
}

func_6BB3() {
  level.var_3B5C = "axis";
  foreach(var_01 in level.var_744A) {
    if(isDefined(var_01.var_01A7) && var_01.var_01A7 == "axis") {
      if(!isai(var_01) && !function_026D(var_01)) {
        var_02 = undefined;
        if(var_01 issplitscreenplayer()) {
          var_02 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_spltscrn_01");
        } else {
          var_02 = common_scripts\utility::func_44F5("mp_infected_zombie_vision_01");
        }

        function_0295(var_02, var_01, "j_head", var_01);
      }
    }
  }

  level thread maps\mp\gametypes\_gamelogic::func_36B9("axis", game["end_reason"]["survivors_eliminated"]);
}

func_46D7(param_00) {
  var_01 = 0;
  foreach(var_03 in level.var_744A) {
    if(var_03.var_0178 == "spectator" && !var_03.var_0188) {
      continue;
    }

    if(var_03.var_01A7 == param_00) {
      var_01++;
    }
  }

  return var_01;
}

func_A175() {
  level.var_5116["allies"] = func_46D7("allies");
  game["teamScores"]["allies"] = level.var_5116["allies"];
  setteamscore("allies", level.var_5116["allies"]);
  level.var_5116["axis"] = func_46D7("axis");
  game["teamScores"]["axis"] = level.var_5116["axis"];
  setteamscore("axis", level.var_5116["axis"]);
}

func_872E() {
  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "allies", "defaultClass", 0, "class", "inUse")) {
    level.var_5114["allies"] = maps\mp\_utility::func_4573("allies", 0);
  } else if(level.var_7A67) {
    level.var_5114["allies"] = maps\mp\gametypes\_class::func_44B4();
    level.var_5114["allies"]["loadoutDivision"] = 0;
    level.var_5114["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16953344, 0);
    level.var_5114["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16871424, 0);
    level.var_5114["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::func_473C(16990208, 0);
    level.var_5114["allies"]["loadoutEquipmentNumExtra"] = 1;
    level.var_5114["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::func_473C(17027072, 0);
    level.var_5114["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::func_452A("specialty_bulletresupply");
    level.var_5114["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::func_452A("specialty_scavenger");
    level.var_5114["allies"]["ignoreMeleeSlotWeapon"] = 1;
  } else {
    level.var_5114["allies"] = maps\mp\gametypes\_class::func_44B4();
    level.var_5114["allies"]["loadoutDivision"] = 0;
    level.var_5114["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16953344, 0);
    level.var_5114["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16871424, 0);
    level.var_5114["allies"]["loadoutEquipmentStruct"] = maps\mp\_utility::func_473C(16990208, 0);
    level.var_5114["allies"]["loadoutEquipmentNumExtra"] = 1;
    level.var_5114["allies"]["loadoutOffhandStruct"] = maps\mp\_utility::func_473C(17027072, 0);
    level.var_5114["allies"]["loadoutPerksGUID"][0] = maps\mp\_utility::func_452A("specialty_bulletresupply");
    level.var_5114["allies"]["loadoutPerksGUID"][1] = maps\mp\_utility::func_452A("specialty_scavenger");
    level.var_5114["allies"]["ignoreMeleeSlotWeapon"] = 1;
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", "defaultClass", 1, "class", "inUse")) {
    level.var_5114["axis_initial"] = maps\mp\_utility::func_4573("axis", 1);
  } else {
    level.var_5114["axis_initial"] = maps\mp\gametypes\_class::func_44B4();
    level.var_5114["axis_initial"]["loadoutDivision"] = 1;
    level.var_5114["axis_initial"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(17273856, 0);
    var_00 = maps\mp\_utility::func_452A("s2_tactical_insertion_device_mp");
    level.var_5114["axis_initial"]["loadoutOffhandStruct"] = maps\mp\_utility::func_473C(var_00, 0);
  }

  if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses", "axis", "defaultClass", 0, "class", "inUse")) {
    level.var_5114["axis"] = maps\mp\_utility::func_4573("axis", 0);
    return;
  }

  level.var_5114["axis"] = maps\mp\gametypes\_class::func_44B4();
  level.var_5114["axis"]["loadoutDivision"] = 1;
  level.var_5114["axis"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(17273856, 0);
  level.var_5114["axis"]["loadoutOffhandStruct"] = maps\mp\_utility::func_473C(maps\mp\_utility::func_452A("s2_tactical_insertion_device_mp"), 0);
}

func_63E8() {
  self endon("death");
  self endon("disconnect");
  self endon("infected");
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    if(!level.var_5111 || !isDefined(self.var_9521) || !isalive(self)) {
      wait 0.05;
      continue;
    }

    func_8738(0);
    var_00++;
    maps\mp\gametypes\_hostmigration::func_A6F5(1);
    if(var_00 == 30) {
      thread maps\mp\_events::func_9522();
      var_00 = 0;
    }
  }
}

func_240F() {
  maps\mp\_utility::func_867B(0);
  self notify("infected");
}

func_8738(param_00) {
  if(!isDefined(self.var_9521)) {
    self.var_9521 = level.var_5CC7[self.var_5CC6];
  }

  var_01 = int(gettime() - self.var_9521 / 1000);
  if(var_01 > 999) {
    var_01 = 999;
  }

  maps\mp\_utility::func_867B(var_01);
  if(isDefined(param_00) && param_00) {
    self notify("infected");
  }
}