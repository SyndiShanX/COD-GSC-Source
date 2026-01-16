/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\missions.gsc
*********************************************/

init() {
  if(!func_B4E8()) {
    return;
  }

  level.var_B8CD = [];
  func_DEFF("playerDamaged", ::func_3BF5);
  func_DEFF("playerKilled", ::func_3BFE);
  func_DEFF("playerKilled", ::func_3C01);
  func_DEFF("playerUsedKillstreak", ::func_3C02);
  func_DEFF("playerKillstreakActive", ::func_3C00);
  func_DEFF("playerAssist", ::func_3BF3);
  func_DEFF("roundEnd", ::func_3C04);
  func_DEFF("roundEnd", ::func_3C03);
  func_DEFF("vehicleKilled", ::func_3C09);
  level thread onplayerconnect();
  level thread onroundended();
}

onroundended() {
  level waittill("game_ended");
  foreach(var_1 in level.players) {
    var_1.pers["killstreaksKilledByWeapon"] = var_1.var_A6B3;
    var_1.pers["killsPerWeapon"] = var_1.killsperweapon;
    var_1.pers["shotsLandedLMG"] = var_1.shotslandedlmg;
    var_1.pers["classicKills"] = var_1.classickills;
    var_1.pers["akimboKills"] = var_1.akimbokills;
    var_1.pers["hipfireMagKills"] = var_1.hipfiremagkills;
    var_1.pers["burstFireKills"] = var_1.burstfirekills;
  }
}

getweaponweight(var_0) {
  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = self getplayerdata("mp", "weeklyChallengeId", var_1);
    var_3 = tablelookupbyrow("mp\weeklyChallengesTable.csv", var_2, 0);
    if(var_3 == var_0) {
      return "ch_weekly_" + var_1;
    }
  }

  return "";
}

func_7E57(var_0) {
  for(var_1 = 0; var_1 < 3; var_1++) {
    var_2 = self getplayerdata("mp", "dailyChallengeId", var_1);
    var_3 = tablelookupbyrow("mp\dailyChallengesTable.csv", var_2, 0);
    if(var_3 == var_0) {
      return "ch_daily_" + var_1;
    }
  }

  return "";
}

func_3BF8(var_0) {
  if(!isenumvaluevalid("mp", "Challenge", var_0)) {
    return 0;
  }

  if(level.var_3C2C[var_0]["type"] == 0) {
    return self getplayerdata("mp", "challengeProgress", var_0);
  }

  if(level.var_3C2C[var_0]["type"] == 1) {
    return self getplayerdata("mp", "challengeProgress", func_7E57(var_0));
  }

  if(level.var_3C2C[var_0]["type"] == 2) {
    return self getplayerdata("mp", "challengeProgress", getweaponweight(var_0));
  }
}

func_3BF9(var_0) {
  if(!isenumvaluevalid("mp", "Challenge", var_0)) {
    return 0;
  }

  if(level.var_3C2C[var_0]["type"] == 0) {
    return self getplayerdata("mp", "challengeState", var_0);
  }

  if(level.var_3C2C[var_0]["type"] == 1) {
    return self getplayerdata("mp", "challengeState", func_7E57(var_0));
  }

  if(level.var_3C2C[var_0]["type"] == 2) {
    return self getplayerdata("mp", "challengeState", getweaponweight(var_0));
  }
}

func_3C05(var_0, var_1) {
  if(level.var_3C2C[var_0]["type"] == 0) {
    return self setplayerdata("mp", "challengeProgress", var_0, var_1);
  }

  if(level.var_3C2C[var_0]["type"] == 1) {
    return self setplayerdata("mp", "challengeProgress", func_7E57(var_0), var_1);
  }

  if(level.var_3C2C[var_0]["type"] == 2) {
    return self setplayerdata("mp", "challengeProgress", getweaponweight(var_0), var_1);
  }
}

func_3C06(var_0, var_1) {
  if(level.var_3C2C[var_0]["type"] == 0) {
    return self setplayerdata("mp", "challengeState", var_0, var_1);
  }

  if(level.var_3C2C[var_0]["type"] == 1) {
    return self setplayerdata("mp", "challengeState", func_7E57(var_0), var_1);
  }

  if(level.var_3C2C[var_0]["type"] == 2) {
    return self setplayerdata("mp", "challengeState", getweaponweight(var_0), var_1);
  }
}

func_3BFA(var_0, var_1) {
  if(level.var_3C2C[var_0]["type"] == 0) {
    return func_B029(var_0, var_1);
  }

  if(level.var_3C2C[var_0]["type"] == 1) {
    return int(tablelookup("mp\dailyChallengesTable.csv", 0, var_0, 9 + var_1 * 3));
  }

  if(level.var_3C2C[var_0]["type"] == 2) {
    return int(tablelookup("mp\weeklyChallengesTable.csv", 0, var_0, 9 + var_1 * 3));
  }
}

showchallengesplash(var_0, var_1) {
  var_2 = undefined;
  var_2 = func_3BF9(var_0) - 1;
  var_3 = level.var_3C2C[var_0]["displayParam"];
  if(!isDefined(var_3)) {
    var_3 = func_3BFA(var_0, var_2);
    if(var_3 == 0) {
      var_3 = 1;
    }

    var_4 = level.var_3C2C[var_0]["paramScale"];
    if(isDefined(var_4)) {
      var_3 = int(var_3 / var_4);
    }
  }

  var_5 = undefined;
  if(scripts\mp\utility::istrue(var_1)) {
    var_5 = int(min(var_2, scripts\mp\hud_message::getsplashtablemaxaltdisplays()));
  } else {
    var_6 = func_2139(var_0);
    if(scripts\mp\utility::istrue(var_6)) {
      var_5 = 1;
    }
  }

  thread scripts\mp\hud_message::showsplash(var_0, var_3, undefined, var_5);
}

func_B4E8() {
  return level.rankedmatch;
}

func_D3D6() {
  if(!func_B4E8()) {
    return 0;
  }

  if(level.players.size < 2) {
    return 0;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    return 0;
  }

  if(!isplayer(self) || isai(self)) {
    return 0;
  }

  return 1;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.var_A6B3 = var_0.pers["killstreaksKilledByWeapon"];
    var_0 thread func_989E();
    if(isai(var_0)) {
      continue;
    }

    var_0 thread onplayerspawned();
    var_0 thread func_BA2A();
    var_0 thread func_B9C0();
    var_0 thread func_B9ED();
    var_0 thread func_BA24();
    var_0 thread func_B9BF();
    var_0 thread func_BA08();
    var_0 thread func_B9E9();
    var_0 thread func_B9E6();
    var_0 thread func_BA3B();
    var_0 thread func_B9DA();
    var_0 thread func_BA29();
    var_0 thread func_BA1F();
    var_0 thread func_B9CE();
    var_0 thread func_B9BA();
    var_0 thread func_B9DF();
    var_0 thread awardpostshipadjustedtargets();
    var_0 notifyonplayercommand("hold_breath", "+breath_sprint");
    var_0 notifyonplayercommand("hold_breath", "+melee_breath");
    var_0 notifyonplayercommand("release_breath", "-breath_sprint");
    var_0 notifyonplayercommand("release_breath", "-melee_breath");
    var_0 thread func_B9E0();
    var_0 notifyonplayercommand("jumped", "+goStand");
    var_0 thread func_B9F0();
    if(isDefined(level.var_C978) && issubstr(var_0.name, level.var_C978)) {
      var_0 setplayerdata("mp", "challengeState", "ch_infected", 2);
      var_0 setplayerdata("mp", "challengeProgress", "ch_infected", 1);
      var_0 setplayerdata("mp", "challengeState", "ch_plague", 2);
      var_0 setplayerdata("mp", "challengeProgress", "ch_plague", 1);
    }

    var_0 setplayerdata("common", "round", "weaponsUsed", 0, "none");
    var_0 setplayerdata("common", "round", "weaponsUsed", 1, "none");
    var_0 setplayerdata("common", "round", "weaponsUsed", 2, "none");
    var_0 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
    var_0 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
    var_0 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    if(randomint(1001) == 1) {
      var_0 setplayerdata("mp", "plagued", 1);
    }

    if(var_0 func_3BF9("ch_solar_rig") == 1) {
      var_0 thread monitorblackskykills();
    }
  }
}

onplayerspawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    self.var_A686 = [];
    self.var_110E5 = 0;
    self.var_D99C = 0;
    self.var_6A06 = [];
    self.var_69F2 = 0;
    self.var_1119A = [];
    self.var_110E6 = [];
    self.sixthsensesource = [];
    self.relaysource = [];
    self.var_13CB9 = [];
    thread func_BA1E();
    thread func_B9B4();
    thread func_BA33();
    thread func_B9D5();
    thread func_BA07();
    thread func_BA0B();
    thread monitoradstime();
    thread func_BA12();
    thread func_B9D4();
    thread func_B9EF();
  }
}

monitorblackskykills() {
  self endon("disconnect");
  for(;;) {
    self waittill("kill_event_buffered", var_0, var_1);
    if(!scripts\mp\utility::iskillstreakweapon(var_1)) {
      if(!isDefined(self.pers[self.loadoutarchetype + "_kills"])) {
        self.pers[self.loadoutarchetype + "_kills"] = 1;
        continue;
      }

      self.pers[self.loadoutarchetype + "_kills"]++;
      if(isDefined(self.pers["archetype_assault_kills"]) && self.pers["archetype_assault_kills"] >= 5 && isDefined(self.pers["archetype_heavy_kills"]) && self.pers["archetype_heavy_kills"] >= 5 && isDefined(self.pers["archetype_scout_kills"]) && self.pers["archetype_scout_kills"] >= 5 && isDefined(self.pers["archetype_assassin_kills"]) && self.pers["archetype_assassin_kills"] >= 5 && isDefined(self.pers["archetype_engineer_kills"]) && self.pers["archetype_engineer_kills"] >= 5 && isDefined(self.pers["archetype_sniper_kills"]) && self.pers["archetype_sniper_kills"] >= 5) {
        func_D991("ch_uber_camo_rig");
      }
    }
  }
}

monitorweaponpickup(var_0) {
  if(scripts\mp\utility::ispickedupweapon(var_0)) {
    if(isDefined(self.var_13CB9) && !isDefined(self.var_13CB9[var_0])) {
      self.var_13CB9[var_0] = gettime();
    }
  }
}

awardpostshipadjustedtargets() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait(20);
  checkpostshipadjustedchallenge("ch_heavy_ground_pound_kills");
  checkpostshipadjustedchallenge("ch_sniper_ballista_collateral");
  checkpostshipadjustedchallenge("ch_dd_wins");
  checkpostshipadjustedchallenge("ch_siege_wins");
  checkpostshipadjustedchallenge("ch_clutch_revives");
  checkpostshipadjustedchallenge("ch_perk_kills_tacresist");
  var_0 = self getplayerdata("mp", "postShipFlags", 1);
  if(var_0 == 0) {
    runonce_checkpostshiprigprogress();
    self setplayerdata("mp", "postShipFlags", 1, 1);
  }
}

checkpostshipadjustedchallenge(var_0) {
  var_1 = func_7E22(var_0);
  var_2 = func_3BF8(var_0);
  var_3 = level.var_3C2C[var_0]["targetval"].size - 1;
  if(var_1 > var_3) {
    return;
  }

  var_4 = level.var_3C2C[var_0]["targetval"][var_1];
  while(var_2 >= var_4) {
    func_D991(var_0);
    var_1 = func_7E22(var_0);
    if(var_1 > var_3) {
      break;
    }

    var_4 = level.var_3C2C[var_0]["targetval"][var_1];
  }
}

awardpostshipchallenge(var_0) {
  var_1 = func_7E22(var_0);
  var_2 = level.var_3C2C[var_0]["targetval"].size - 1;
  if(var_1 > var_2) {
    return;
  }

  var_3 = level.var_3C2C[var_0]["targetval"][var_2];
  var_4 = level.var_3C2C[var_0]["targetval"][var_1];
  while(var_3 >= var_4) {
    func_D991(var_0);
    var_1 = func_7E22(var_0);
    if(var_1 > var_2) {
      break;
    }

    var_4 = level.var_3C2C[var_0]["targetval"][var_1];
  }
}

runonce_checkpostshiprigprogress() {
  var_0 = ["ch_gold_rig_assault_body", "ch_gold_rig_assault_head", "ch_gold_rig_heavy_body", "ch_gold_rig_heavy_head", "ch_gold_rig_scout_body", "ch_gold_rig_scout_head", "ch_gold_rig_assassin_body", "ch_gold_rig_assassin_head", "ch_gold_rig_engineer_body", "ch_gold_rig_engineer_head", "ch_gold_rig_sniper_body", "ch_gold_rig_sniper_head", "ch_diamond_rig_assault", "ch_diamond_rig_heavy", "ch_diamond_rig_scout", "ch_diamond_rig_assassin", "ch_diamond_rig_engineer", "ch_diamond_rig_sniper", "ch_solar_rig"];
  foreach(var_2 in var_0) {
    var_3 = func_3BF9(var_2);
    if(var_3 > 0) {
      thread giverankxpafterwait(var_2, var_3);
      scripts\mp\matchdata::func_AF99(var_2, var_3);
      func_110AE(var_2);
      setturretfov(level.var_3C2C[var_2]["score"][var_3]);
      thread showchallengesplash(var_2);
    }
  }
}

func_BA12() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 = 0;
  for(;;) {
    self waittill("scavenger_pickup");
    func_D991("ch_perk_scavenger");
    if(!var_0) {
      var_1 = 0;
      var_2 = 0;
      var_3 = self getweaponslistprimaries();
      foreach(var_5 in var_3) {
        if(!scripts\mp\utility::iscacprimaryweapon(var_5) && !scripts\mp\weapons::func_9F54(var_5)) {
          continue;
        }

        var_2++;
        if(self getfractionmaxammo(var_5) < 1) {
          break;
        }

        var_1++;
      }

      if(var_2 > 0 && var_1 == var_2) {
        func_D991("ch_scavenger_full_ammo");
        var_0 = 1;
      }
    }
  }
}

func_10DC7() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  thread func_B9E8();
  wait(5);
  self notify("stopMonitorKillsAfterAbilityActive");
}

func_B9E8() {
  self endon("stopMonitorKillsAfterAbilityActive");
  self endon("remove_super");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 = undefined;
  if(isDefined(scripts\mp\supers::getcurrentsuper())) {
    var_0 = scripts\mp\supers::getcurrentsuperref();
  } else {
    return;
  }

  for(;;) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);
    switch (var_0) {
      case "super_rewind":
        func_D991("ch_ability_rewind");
        break;

      case "super_teleport":
        func_D991("ch_ability_teleport");
        break;

      case "super_phaseshift":
        func_D991("ch_ability_phase_shift");
        break;
    }
  }
}

func_D98A(var_0) {
  if(var_0.var_250D) {
    switch (var_0.var_24E8) {
      default:
        break;

      case "super_amplify":
        func_D991("ch_ability_amplify");
        break;

      case "super_overdrive":
        func_D991("ch_ability_overdrive");
        break;

      case "super_chargemode":
        func_D991("ch_ability_bull_charge");
        break;

      case "super_armorup":
        func_D991("ch_ability_reactive_armor");
        break;

      case "super_reaper":
        func_D991("ch_ability_reaper");
        break;
    }
  }

  if(scripts\mp\utility::istrue(var_0.attackervisionpulsedvictim)) {
    func_D991("ch_ability_pulsar");
  }

  if(scripts\mp\utility::istrue(var_0.attackerhassupertrophyout)) {
    func_D991("ch_ability_centurion");
  }

  if(isDefined(var_0.sweapon) && var_0.sweapon == "micro_turret_gun_mp") {
    func_D991("ch_ability_micro_turret");
  }

  if(isDefined(var_0.modifiers) && isDefined(self.modifiers["super_kill_medal"]) && self.modifiers["super_kill_medal"] == "super_invisible") {
    func_D991("ch_ability_active_camo");
  }
}

func_B9C2() {
  self endon("bounceKillCancel");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("bounceKillVerify");
    func_D991("ch_darkops_bounce");
  }
}

func_BA36() {
  self endon("tripleStopCancel");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("tripleStopVerify");
    if(self.var_127D0 == 3) {
      func_D991("ch_darkops_slidestop");
      self.var_127D0 = undefined;
      break;
    }
  }
}

func_D998(var_0, var_1, var_2) {
  if(var_0.team != self.team && var_1 == "drone_hive_projectile_mp" || var_1 == "switch_blade_child_mp") {
    var_3 = 0;
    var_4 = 0;
    foreach(var_6 in level.players) {
      if(!isDefined(var_6.team)) {
        continue;
      }

      if(!scripts\mp\utility::isreallyalive(var_6)) {
        continue;
      }

      if(var_6.team == self.team) {
        var_7 = scripts\mp\domeshield::func_7E80(var_6);
        if(!isDefined(var_7)) {
          continue;
        }

        var_8 = var_7.var_58EF;
        if(!isDefined(var_8)) {
          continue;
        }

        if(var_8 == var_2) {
          if(var_6 == self) {
            var_4 = 1;
            continue;
          }

          var_3++;
        }
      }
    }

    if(var_4 && var_3 > 1) {
      func_D991("ch_darkops_chrome");
    }
  }
}

func_D997(var_0) {
  func_D9AF(var_0);
}

func_D996(var_0) {
  if(isDefined(var_0.var_94B7)) {
    if(var_0.var_94B7) {
      func_D991("ch_darkops_howthe");
    }
  }

  if(scripts\engine\utility::isbulletdamage(var_0.smeansofdeath) && var_0.var_24E3 == 0 && !scripts\mp\utility::iskillstreakweapon(var_0.sweapon)) {
    if(isDefined(self.var_127D0)) {
      self.var_127D0++;
      self notify("tripleStopVerify");
    } else {
      self.var_127D0 = 1;
      thread func_BA36();
    }
  } else {
    self.var_127D0 = undefined;
    self notify("tripleStopCancel");
  }

  if(isDefined(var_0.modifiers["headshot"]) && var_0.var_92BE &level.idflags_ricochet) {
    if(isDefined(self.var_2F04)) {
      self notify("bounceKillVerify");
    } else {
      thread func_B9C2();
      self.var_2F04 = 1;
    }
  } else {
    self notify("bounceKillCancel");
    self.var_2F04 = undefined;
  }

  if(isDefined(var_0.var_1337C) && isDefined(var_0.var_1337A) && isDefined(var_0.var_250D) && isDefined(var_0.var_24E8)) {
    if(var_0.var_1337C && var_0.var_250D && var_0.var_1337A == "super_phaseshift" && var_0.var_24E8 == "super_phaseshift") {
      func_D991("ch_darkops_phase");
    }
  }

  if(isDefined(var_0.sweapon)) {
    var_1 = scripts\mp\utility::getweaponrootname(var_0.sweapon);
    if(var_1 == "iw7_revolver" && scripts\mp\utility::weaponhasattachment(var_0.sweapon, "akimbo") && scripts\mp\utility::weaponhasattachment(var_0.sweapon, "fastaim") && scripts\mp\weapons::func_13C98(var_0.sweapon)) {
      func_D991("ch_darkops_no_idea");
    }
  }
}

processrigkillchallengesonkill_delayed(var_0) {
  var_0.var_4F func_D991("ch_" + var_0.attackerarchetype + "_kills");
  if(isDefined(var_0.attackerkillsthislife) && func_9EBC(var_0.attackerkillsthislife, 3)) {
    var_0.var_4F func_D991("ch_" + var_0.attackerarchetype + "_3streak");
  }

  if(isDefined(var_0.var_2504)) {
    if(func_9EBC(var_0.var_2504, 2)) {
      var_0.var_4F func_D991("ch_" + var_0.attackerarchetype + "_2multikill");
      if(isDefined(var_0.var_2506) && var_0.var_2506 == "specialty_boom") {
        var_0.var_4F func_D991("ch_assault_ping_2multi");
      }
    }
  }

  if(isDefined(var_0.var_2506) && var_0.var_2506 == "specialty_scavenger_eqp") {
    var_1 = scripts\mp\utility::getequipmenttype(var_0.sweapon);
    if(isDefined(var_1) && var_1 == "lethal") {
      var_0.var_4F func_D991("ch_assault_resupply_lethal_kills");
    }
  }

  if(isDefined(var_0.var_2506) && var_0.var_2506 == "specialty_rugged_eqp") {
    if(scripts\mp\utility::istrue(var_0.wasplantedmine)) {
      var_0.var_4F func_D991("ch_engineer_hardened_kill");
    }
  }

  if(isDefined(var_0.sweapon) && var_0.sweapon == "iw7_reaperblade_mp" && isDefined(var_0.var_24F3[var_0.sweapon]) && func_9EBC(var_0.var_24F3[var_0.sweapon], 4)) {
    var_0.var_4F func_D991("ch_scout_reaper_4multi");
  }

  if(isDefined(var_0.var_2506) && var_0.var_2506 == "specialty_ftlslide" && var_0.var_24EF && scripts\mp\utility::istrue(var_0.modifiers["slidekill"])) {
    var_0.var_4F func_D991("ch_assassin_ads_slide_kill");
  }

  if(isDefined(var_0.attackersixthsensesource) && scripts\mp\utility::istrue(var_0.attackersixthsensesource[var_0.victimid])) {
    var_0.var_4F func_D991("ch_assassin_perception_revenge");
  }

  if(isDefined(var_0.attackerrelaysource) && scripts\mp\utility::istrue(var_0.attackerrelaysource[var_0.victimid])) {
    var_0.var_4F func_D991("ch_engineer_relay_kill");
  }

  if(isDefined(var_0.var_2506) && var_0.var_2506 == "specialty_rearguard") {
    if(isDefined(var_0.attackerrearguardattackers) && isDefined(var_0.attackerrearguardattackers[var_0.victimid])) {
      var_0.var_4F func_D991("ch_sniper_rearguard_kill");
    }
  }
}

func_D9A8(var_0) {
  if(!isDefined(var_0.modifiers["superShutdown"])) {
    return;
  }

  switch (var_0.modifiers["superShutdown"]) {
    case "super_claw":
      func_D991("ch_killjoy_assault_weapon");
      break;

    case "super_steeldragon":
      func_D991("ch_killjoy_armor_weapon");
      break;

    case "super_armmgs":
      func_D991("ch_killjoy_synaptic_weapon");
      break;

    case "super_atomizer":
      func_D991("ch_killjoy_ftl_weapon");
      break;

    case "super_blackholegun":
      func_D991("ch_killjoy_six_weapon");
      break;

    case "super_penetrationrailgun":
      func_D991("ch_killjoy_ghost_weapon");
      break;

    case "super_overdrive":
    case "super_amplify":
      func_D991("ch_killjoy_assault_ability");
      break;

    case "super_armorup":
    case "super_chargemode":
      func_D991("ch_killjoy_armor_ability");
      break;

    case "super_reaper":
    case "super_rewind":
      func_D991("ch_killjoy_synaptic_ability");
      break;

    case "super_phaseshift":
    case "super_teleport":
      func_D991("ch_killjoy_ftl_ability");
      break;

    case "super_visionpulse":
    case "super_invisible":
      func_D991("ch_killjoy_ghost_ability");
      break;
  }
}

func_D995() {
  if(self iswallrunning()) {
    func_D991("ch_darkops_epic_run");
    return;
  }

  if(self issprintsliding()) {
    func_D991("ch_darkops_epic_slide");
  }
}

func_D9B1(var_0) {
  if(var_0 getplayerdata("mp", "plagued")) {
    self setplayerdata("mp", "plagued", 1);
    func_D991("ch_darkops_plague");
  }
}

func_D9BE(var_0) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(isDefined(var_0.guid)) {
    self endon("killedPlayer" + var_0.guid);
  }

  wait(60);
  func_D991("ch_darkops_warchief");
}

func_D9AF(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.team)) {
      continue;
    }

    if(var_2.team != var_0.team) {
      if(!isDefined(var_2.var_114ED)) {
        var_2.var_114ED = [];
      }

      var_2.var_114ED[var_0.guid] = [];
    }
  }
}

func_D9B7(var_0, var_1, var_2) {
  if(!isDefined(self.var_114ED)) {
    self.var_114ED = [];
  }

  if(self.team == var_0.team) {
    return;
  }

  if(var_0.health - var_2 > 0) {
    if(!isDefined(self.var_114ED[var_0.guid])) {
      self.var_114ED[var_0.guid] = [];
    }

    var_3 = getweaponbasename(var_1);
    if(!isDefined(self.var_114ED[var_0.guid][var_3])) {
      self.var_114ED[var_0.guid][var_3] = 1;
      if(self.var_114ED[var_0.guid].size == 4) {
        func_D991("ch_darkops_chimp");
        return;
      }
    }
  }
}

func_D9BB(var_0) {
  if(!isDefined(var_0.var_2506)) {
    return;
  }

  switch (var_0.var_2506) {
    default:
      break;

    case "specialty_man_at_arms":
      func_D991("ch_trait_man_at_arms");
      break;

    case "specialty_rush":
      func_D991("ch_trait_momentum");
      break;

    case "specialty_afterburner":
      func_D991("ch_trait_rushdown");
      break;

    case "specialty_rearguard":
      func_D991("ch_trait_perch");
      break;
  }

  if(isDefined(var_0.sweapon)) {
    if(var_0.sweapon == "groundpound_mp") {
      func_D991("ch_heavy_ground_pound_kills");
    }

    if(var_0.sweapon == "thruster_mp") {
      func_D991("ch_scout_afterburner_kill");
    }
  }
}

monitorsuperscoreearned() {
  self endon("disconnect");
  self endon("super_use_finished");
  self endon("death");
  level endon("game_ended");
  self notify("monitorSuperScoreEarned");
  self endon("monitorSuperScoreEarned");
  if(level.gametype == "dm") {
    var_0 = self.pers["gamemodeScore"] + 500;
  } else {
    var_0 = self.destroynavrepulsor + 500;
  }

  var_1 = 0;
  for(;;) {
    if(level.gametype == "dm") {
      var_2 = self.pers["gamemodeScore"];
    } else {
      var_2 = self.destroynavrepulsor;
    }

    if(var_2 >= var_0) {
      var_0 = var_0 + 500;
      func_D991("ch_assault_amplify_score");
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA2B() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSuperWeaponKills");
  self endon("monitorSuperWeaponKills");
  for(;;) {
    self waittill("super_weapon_kill", var_0);
    var_1 = int(self.var_112A8 / 3);
    self.var_112A8 = self.var_112A8 % 3;
    while(var_1 > 0) {
      var_1--;
      var_0 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
      switch (var_0) {
        case "iw7_claw_mp":
          func_D991("ch_super_streak_assault");
          break;

        case "iw7_steeldragon_mp":
          func_D991("ch_super_streak_armor");
          break;

        case "iw7_armmgs_mp":
          func_D991("ch_super_streak_synaptic");
          break;

        case "iw7_atomizer_mp":
          func_D991("ch_super_streak_ftl");
          break;

        case "iw7_blackholegun_mp":
          func_D991("ch_super_streak_six");
          break;

        case "iw7_penetrationrail_mp":
          func_D991("ch_super_streak_ghost");
          break;
      }
    }
  }
}

updatesuperkills(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }

  switch (var_0) {
    case "super_overdrive":
      if(func_9EBC(var_2, 2)) {
        func_D991("ch_assault_overdrive_2multi");
      }
      break;

    case "super_chargemode":
      if(func_9EBC(var_2, 2)) {
        func_D991("ch_heavy_bullcharge_multi");
      }
      break;

    case "super_teleport":
      if(var_1 == "MOD_MELEE") {
        func_D991("ch_assassin_jump_melee");
      }
      break;

    case "super_invisible":
      if(var_1 == "MOD_MELEE") {
        func_D991("ch_sniper_camo_melee");
      }
      break;

    case "super_visionpulse":
      if(func_9EBC(var_2, 2)) {
        func_D991("ch_sniper_pulsar_2multi");
      }
      break;
  }
}

func_12F33(var_0, var_1) {
  if(!isDefined(self.var_112A8)) {
    return;
  } else {
    self.var_112A8++;
  }

  self notify("super_weapon_kill", var_0);
  var_0 = scripts\mp\utility::getweaponbasedsmokegrenadecount(var_0);
  switch (var_0) {
    case "iw7_claw_mp":
      func_D991("ch_super_weapon_assault");
      break;

    case "iw7_steeldragon_mp":
      func_D991("ch_super_weapon_armor");
      break;

    case "iw7_armmgs_mp":
      func_D991("ch_super_weapon_synaptic");
      break;

    case "iw7_atomizer_mp":
      func_D991("ch_super_weapon_ftl");
      break;

    case "iw7_blackholegun_mp":
      func_D991("ch_super_weapon_six");
      if(isDefined(var_1)) {
        if(!isDefined(var_1.setculldist)) {
          var_1.setculldist = 1;
        } else {
          var_1.setculldist++;
        }

        if(func_9EBC(var_1.setculldist, 2)) {
          func_D991("ch_engineer_bhgun_3multi");
        }
      }
      break;

    case "iw7_penetrationrail_mp":
      func_D991("ch_super_weapon_ghost");
      break;
  }
}

func_BA2A() {
  self endon("disconnect");
  for(;;) {
    self waittill("super_use_started");
    var_0 = scripts\mp\supers::getcurrentsuperref();
    if(isDefined(var_0) && var_0 == "super_phaseshift" && self.health < self.maxhealth) {
      func_D991("ch_assassin_damaged_phase_shift");
    }

    if(isDefined(var_0) && var_0 == "super_amplify") {
      thread monitorsuperscoreearned();
    }

    self.var_112A8 = 0;
    thread func_BA2B();
    thread func_10DC7();
  }
}

func_B9DF() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("healed");
    if(isDefined(self.trait) && self.trait == "specialty_regenfaster") {
      func_D991("ch_heavy_icu_heals");
    }
  }
}

func_BA24() {
  self endon("disconnect");
  for(;;) {
    self waittill("received_earned_killstreak");
    if(func_66B8("specialty_hardline")) {
      func_D991("ch_perk_hardline");
    }

    wait(0.05);
  }
}

func_B9BF() {
  self endon("disconnect");
  for(;;) {
    self waittill("survived_explosion", var_0);
    if(isDefined(var_0) && isplayer(var_0) && self == var_0) {
      continue;
    }

    if(self isitemunlocked("specialty_blastshield", "perk") && scripts\mp\utility::_hasperk("specialty_blastshield")) {
      processchallenge("ch_blastshield");
    }

    scripts\engine\utility::waitframe();
  }
}

func_989E() {
  self.explosiveinfo = [];
  if(!isDefined(self.killsperweapon)) {
    self.killsperweapon = self.pers["killsPerWeapon"];
    if(!isDefined(self.killsperweapon)) {
      self.killsperweapon = [];
    }
  }

  if(!isDefined(self.shotslandedlmg)) {
    self.shotslandedlmg = self.pers["shotsLandedLMG"];
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 0;
    }
  }

  if(!isDefined(self.classickills)) {
    self.classickills = self.pers["classicKills"];
    if(!isDefined(self.classickills)) {
      self.classickills = 0;
    }
  }

  if(!isDefined(self.akimbokills)) {
    self.akimbokills = self.pers["akimboKills"];
    if(!isDefined(self.akimbokills)) {
      self.akimbokills = 0;
    }
  }

  if(!isDefined(self.hipfiremagkills)) {
    self.hipfiremagkills = self.pers["hipfireMagKills"];
    if(!isDefined(self.hipfiremagkills)) {
      self.hipfiremagkills = 0;
    }
  }

  if(!isDefined(self.burstfirekills)) {
    self.burstfirekills = self.pers["burstFireKills"];
    if(!isDefined(self.burstfirekills)) {
      self.burstfirekills = 0;
    }
  }
}

func_DEFF(var_0, var_1) {
  if(!isDefined(level.var_B8CD[var_0])) {
    level.var_B8CD[var_0] = [];
  }

  level.var_B8CD[var_0][level.var_B8CD[var_0].size] = var_1;
}

func_7E22(var_0) {
  if(isDefined(self.var_3C2A[var_0])) {
    return self.var_3C2A[var_0];
  }

  return 0;
}

func_3BF3(var_0) {
  var_1 = var_0.player;
  if(isDefined(var_0.sweapon) && scripts\mp\utility::iskillstreakweapon(var_0.sweapon)) {
    var_1 func_D991("ch_lifetime_streak_assists");
  }
}

func_3C02(var_0) {
  var_1 = var_0.player;
  var_1 func_D991("ch_lifetime_streaks_used");
}

func_3C00(var_0) {
  var_1 = var_0.player;
  var_2 = 0;
  var_3 = 0;
  foreach(var_5 in level.var_1655) {
    if(var_5.owner == var_1) {
      if(var_5.streakname == "sentry_shock") {
        var_2++;
        if(var_2 == 2) {
          var_1 func_D991("ch_two_sentries");
        }
      }

      continue;
    }

    if(var_5.streakname == "uav" || var_5.streakname == "directional_uav") {
      var_3 = 1;
    }
  }

  if(var_3 && var_0.var_A6A7 == "counter_uav") {
    var_1 func_D991("ch_counter_other_uav");
  }

  if(var_0.var_A6A7 == "jammer") {}
}

func_3C01(var_0) {
  if(!isDefined(var_0.var_4F) || !isplayer(var_0.var_4F)) {
    return;
  }

  if(!isDefined(var_0.sweapon) || !scripts\mp\utility::iskillstreakweapon(var_0.sweapon)) {
    return;
  }

  var_1 = var_0.var_4F;
  var_2 = func_7F48(var_0.sweapon);
  switch (var_2) {
    case "sentry_shock":
      var_1 func_D991("ch_scorestreak_kills_sentry");
      break;

    case "ball_drone_backup":
      var_1 func_D991("ch_scorestreak_kills_vulture");
      break;

    case "drone_hive":
      var_1 func_D991("ch_scorestreak_kills_trinity");
      break;

    case "precision_airstrike":
      var_1 func_D991("ch_scorestreak_kills_airstrike");
      break;

    case "minijackal":
      var_1 func_D991("ch_scorestreak_kills_apex");
      break;

    case "thor":
      var_1 func_D991("ch_scorestreak_kills_thor");
      break;

    case "bombardment":
      var_1 func_D991("ch_scorestreak_kills_bombardment");
      break;

    case "remote_c8":
      if(isDefined(var_1.var_4BE1) && var_1.var_4BE1 == "MANUAL") {
        var_1 func_D991("ch_rc8_controlled_kills");
      }

      var_1 func_D991("ch_scorestreak_kills_rc8");
      break;

    case "venom":
      var_1 func_D991("ch_scorestreak_kills_scarab");
      break;

    case "jackal":
      var_1 func_D991("ch_scorestreak_kills_warden");
      break;
  }

  var_1 func_D991("ch_lifetime_streak_kills");
}

func_7F48(var_0) {
  if(isDefined(level.killstreakweildweapons[var_0])) {
    return level.killstreakweildweapons[var_0];
  }

  return undefined;
}

func_9E4B(var_0) {
  var_1 = 0;
  switch (level.gametype) {
    case "sd":
    case "dd":
    case "sr":
      foreach(var_3 in level.bombzones) {
        var_4 = distancesquared(var_3.trigger.origin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "dom":
      foreach(var_3 in level.objectives) {
        var_4 = distancesquared(var_3.origin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "siege":
      foreach(var_3 in level.magicbullet) {
        var_4 = distancesquared(var_3.origin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "grind":
      foreach(var_3 in level.var_13FC1) {
        var_4 = distancesquared(var_3.origin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "grnd":
    case "koth":
      var_1 = ispointinvolume(var_0, level.zone.gameobject.trigger);
      break;
  }

  return var_1;
}

func_9DBA(var_0) {
  var_1 = 0;
  switch (level.gametype) {
    case "sd":
    case "dd":
    case "sr":
      if(self.team != game["defenders"]) {
        break;
      }

      foreach(var_3 in level.bombzones) {
        var_4 = distancesquared(var_3.trigger.origin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "dom":
      foreach(var_3 in level.domflags) {
        if(self.team != var_3 scripts\mp\gameobjects::getownerteam()) {
          continue;
        }

        var_4 = distancesquared(var_3.curorigin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "siege":
      foreach(var_3 in level.domflags) {
        if(self.team != var_3 scripts\mp\gameobjects::getownerteam()) {
          continue;
        }

        var_4 = distancesquared(var_3.curorigin, var_0);
        if(var_4 < 90000) {
          var_1 = 1;
          break;
        }
      }
      break;

    case "grind":
      break;

    case "koth":
      var_1 = ispointinvolume(self.origin, level.zone.gameobject.trigger) || ispointinvolume(var_0, level.zone.gameobject.trigger);
      break;
  }

  return var_1;
}

func_D9BC(var_0, var_1) {
  switch (var_1) {
    case "uav":
      var_0 func_D991("ch_scorestreak_assists_uav");
      break;

    case "counter_uav":
      var_0 func_D991("ch_scorestreak_assists_cuav");
      break;

    case "directional_uav":
      var_0 func_D991("ch_scorestreak_assists_auav");
      break;
  }

  var_0 func_D991("ch_lifetime_streak_assists");
}

func_3C09(var_0) {
  if(!isDefined(var_0.var_4F) || !isplayer(var_0.var_4F)) {
    return;
  }

  var_1 = var_0.var_4F;
}

func_D98F(var_0) {
  switch (var_0) {
    case "quad_feed":
      func_D991("ch_quad_feed");
      break;

    case "one_shot_two_kills":
      func_D991("ch_collateral");
      break;

    case "first_place_kill":
      func_D991("ch_kill_1st_place");
      break;

    case "gun_butt":
      func_D991("ch_gun_butt");
      break;

    case "backfire":
      func_D991("ch_owner_kill");
      break;

    case "item_impact":
      func_D991("ch_direct_impact");
      break;
  }

  if((var_0 == "longshot" && self.awardsthislife["longshot"] == 1 && isDefined(self.awardsthislife["pointblank"])) || var_0 == "pointblank" && self.awardsthislife["pointblank"] == 1 && isDefined(self.awardsthislife["longshot"])) {
    func_D991("ch_longshot_pointblank");
  }
}

func_3BF6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  if(isplayer(var_1)) {
    if(isexplosivedamagemod(var_3)) {
      if(var_2 < var_6.health) {
        if(isDefined(var_6)) {
          var_6.var_6A06[var_1.guid] = var_1;
          if(isDefined(var_6.var_69F2)) {
            var_6.var_69F2++;
            if(var_6.var_69F2 == 3) {
              var_6 func_D991("ch_blastshield_hits");
            }
          }
        }
      }
    }

    var_1 func_D9B7(var_6, var_4, var_2);
  }
}

func_3BF5(var_0, var_1) {
  var_2 = var_0.var_4F;
  var_3 = var_0.victim;
  if(!isDefined(var_2) || !isplayer(var_2) || !isalive(var_2)) {
    return;
  }

  var_1 = var_0.time;
  if(issubstr(var_0.smeansofdeath, "MOD_MELEE")) {
    if(var_3.health > 0) {
      var_2 thread func_D9BE(var_3);
    }

    var_2 func_D9B1(var_3);
  }
}

func_3BFF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1) || !isplayer(var_1)) {
    return;
  }

  if(var_5 == "throwingknifec4_mp") {
    if(var_4 == "MOD_IMPACT") {
      var_1.var_A949 = gettime();
    } else if(var_4 == "MOD_EXPLOSIVE" && isDefined(var_1.var_A949)) {
      var_9 = gettime() - var_1.var_A949;
      if(var_9 <= 50) {
        var_1 func_D991("ch_biospike_double");
      }
    }
  }

  if(var_5 == "micro_turret_gun_mp" && isDefined(var_0)) {
    if(!isDefined(var_0.setculldist)) {
      var_0.setculldist = 1;
    } else {
      var_0.setculldist++;
    }

    if(func_9EBC(var_0.setculldist, 2)) {
      var_1 func_D991("ch_engineer_micro_turret_2multi");
    }
  }

  if(scripts\mp\utility::iskillstreakweapon(var_5)) {
    var_10 = func_7F48(var_5);
    if(!isDefined(var_1.var_A6A5)) {
      var_1.var_A6A5 = [];
    }

    if(isDefined(var_0) && isDefined(var_0.var_1653)) {
      if(!isDefined(var_1.var_A6A5[var_0.var_1653])) {
        var_11 = spawnStruct();
        var_11.var_A6A7 = var_10;
        var_11.setculldist = 1;
        var_11.var_C2A4 = scripts\engine\utility::ter_op(func_9E4B(var_0.origin), 1, 0);
        var_1.var_A6A5[var_0.var_1653] = var_11;
      } else {
        var_1.var_A6A5[var_0.var_1653].setculldist++;
        if(func_9E4B(var_0.origin)) {
          var_1.var_A6A5[var_0.var_1653].var_C2A4++;
        }
      }
    }

    switch (var_10) {
      case "sentry_shock":
        if(func_9EBC(var_1.var_A6A5[var_0.var_1653].var_C2A4, 3)) {
          var_1 func_D991("ch_sentry_defender");
        }

        if(func_9EBC(var_1.var_A6A5[var_0.var_1653].setculldist, 5)) {
          var_1 func_D991("ch_sentry_streak");
        }
        break;

      case "ball_drone_backup":
        break;

      case "drone_hive":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;

      case "precision_airstrike":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;

      case "minijackal":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;

      case "thor":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;

      case "bombardment":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;

      case "remote_c8":
        break;

      case "venom":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 2 == 0) {
          var_1 func_D991("ch_scorestreak_double_scarab");
        }

        if(self iswallrunning()) {
          var_1 func_D991("ch_scarab_wall_kill");
        }
        break;

      case "jackal":
        if(var_1.var_DDC3[var_5] > 0 && var_1.var_DDC3[var_5] % 3 == 0) {
          var_1 func_D991("ch_scorestreak_triple_kills");
        }
        break;
    }
  }

  var_1 func_D98B();
  var_1 func_D997(self);
}

func_3BFE(var_0, var_1) {
  var_2 = var_0.var_4F;
  var_3 = var_0.victim;
  if(!isDefined(var_2) || !isplayer(var_2)) {
    return;
  }

  var_1 = var_0.time;
  var_2 func_D991("ch_lifetime_kills");
  if(isDefined(var_0.victim) && isDefined(var_0.victim.guid)) {
    var_2 notify("killedPlayer" + var_0.victim.guid);
  }

  func_D9D8(var_0, var_2);
  func_D9AE(var_0, var_1, var_2, var_3);
  func_D9B9(var_0, var_1, var_2, var_3);
  func_D9B2(var_0, var_1, var_2, var_3);
  func_D9B0(var_0, var_1, var_2, var_3);
  var_2 func_D98A(var_0);
  var_2 func_D9BB(var_0);
  var_2 func_D9A8(var_0);
  var_2 func_D996(var_0);
  var_2 processrigkillchallengesonkill_delayed(var_0);
  if(isDefined(var_0.var_13374)) {
    var_4 = var_0.var_13374[var_2.guid];
    if(scripts\mp\utility::istrue(var_4.diddamagewithlethalequipment) && var_0.isbulletdamage) {
      var_2 func_D991("ch_lethal_bullet_combo");
    }

    if(scripts\mp\utility::istrue(var_4.var_54B4) && scripts\mp\utility::iscacsecondaryweapon(var_0.sweapon)) {
      var_2 func_D991("ch_swap_kill");
    }

    if(isDefined(var_0.var_24E0)) {
      if(isDefined(var_0.var_24E0[var_3.guid])) {
        if(!scripts\mp\utility::istrue(var_4.didnonmeleedamage)) {
          var_2 func_D991("ch_hurt_melee_kill");
        }
      }
    }
  }

  if(var_0.var_24F6.size > 0) {
    var_2 func_D9B8();
  }

  if(isDefined(var_0.var_24F2[var_3.guid])) {
    var_5 = var_0.var_24F2[var_3.guid];
    if(func_9EBC(var_5, 5)) {
      var_2 func_D991("ch_repeat_kill");
    }
  }

  if(var_0.var_24E1) {
    var_2 func_D991("ch_while_stunned_kill");
  }

  if(var_0.var_13375) {
    var_2 func_D991("ch_stun_kill");
  }

  if(scripts\mp\utility::istrue(var_0.var_24EA)) {
    var_2 func_D991("ch_tactical_smoke");
  }

  if(scripts\mp\utility::istrue(var_0.var_2501)) {
    var_2 func_D991("ch_tactical_radar");
  }

  if(func_9E8A(var_0.shitloc)) {
    var_2 func_D991("ch_lower_body_kill");
  }

  if(scripts\mp\utility::istrue(var_0.var_2511)) {
    var_2 func_D991("ch_pre_adrenaline");
  }

  if(isDefined(var_0.var_13377)) {
    if(var_0.var_13377 == var_2) {
      var_2 func_D991("ch_dome_defense");
    }

    if(var_0.var_13377 == var_3) {
      var_2 func_D991("ch_dome_assault");
    }
  }

  if(isDefined(var_3.debuffedbyplayers)) {
    var_6 = var_2 getentitynumber();
    if(isDefined(var_0.var_13376["cryo_mine_mp"]) && isDefined(var_0.var_13376["cryo_mine_mp"][var_6])) {
      var_2 func_D991("ch_tactical_cryomine");
    }

    if(isDefined(var_0.var_13376["blackout_grenade_mp"]) && isDefined(var_0.var_13376["blackout_grenade_mp"][var_6])) {
      var_2 func_D991("ch_tactical_blackout");
    }

    if((isDefined(var_0.var_13376["emp_grenade_mp"]) && isDefined(var_0.var_13376["emp_grenade_mp"][var_6])) || isDefined(var_0.var_13376["concussion_grenade_mp"]) && isDefined(var_0.var_13376["concussion_grenade_mp"][var_6])) {
      var_2 func_D991("ch_tactical_concussion");
    }
  }

  if(isDefined(var_0.var_24E9[var_3.guid])) {
    var_2 func_D991("ch_blastshield_revenge");
  }

  var_7 = [];
  foreach(var_9 in var_0.var_24FD) {
    var_10 = scripts\mp\perks\perks::func_805C(var_9);
    if(isDefined(var_10)) {
      if(!isDefined(var_7[var_10])) {
        var_7[var_10] = 1;
        continue;
      }

      var_7[var_10]++;
    }
  }

  if(isDefined(var_7[1]) && var_7[1] == 2) {
    var_2 func_D991("ch_perk_1_combo");
  }

  if(isDefined(var_7[2]) && var_7[2] == 2) {
    var_2 func_D991("ch_perk_2_combo");
  }

  if(isDefined(var_7[3]) && var_7[3] == 2) {
    var_2 func_D991("ch_perk_3_combo");
  }

  if(scripts\mp\utility::iskillstreakweapon(var_0.sweapon) && !allowinteractivecombat(var_2, var_0.sweapon)) {
    return;
  }

  func_D9C8(var_0, var_1, var_2, var_3);
  if(isDefined(var_0.var_24F8) && var_0.time - var_0.var_24F8 < 4500) {
    var_2 func_D991("ch_use_gesture");
  }

  if(isDefined(var_3.var_A6AE)) {
    foreach(var_13 in var_3.var_A6AE) {
      if(var_13.owner == var_2) {
        switch (var_13.var_A6A7) {
          case "remote_c8":
            var_2 func_D991("ch_rc8_defense");
            break;
        }
      }
    }
  }
}

func_D98B() {
  if(isDefined(level.var_1655)) {
    foreach(var_1 in level.var_1655) {
      if(var_1.owner == self) {
        switch (var_1.streakname) {
          case "uav":
            func_D991("ch_scorestreak_kills_uav");
            break;

          case "counter_uav":
            func_D991("ch_scorestreak_kills_cuav");
            break;

          case "directional_uav":
            func_D991("ch_scorestreak_kills_auav");
            break;
        }
      }
    }
  }
}

func_D9D8(var_0, var_1) {
  var_2 = scripts\mp\loot::getlootinfoforweapon(var_0.sweapon);
  if(isDefined(var_2) && isDefined(var_2.quality)) {
    switch (var_2.quality) {
      case 4:
        var_1 func_D991("ch_outfitter_epic");
        break;

      case 3:
        var_1 func_D991("ch_outfitter_legendary");
        break;

      case 2:
        var_1 func_D991("ch_outfitter_rare");
        break;

      case 1:
        var_1 func_D991("ch_outfitter_common");
        break;
    }
  }

  if(isDefined(var_0.var_24F3)) {
    var_3 = 0;
    foreach(var_7, var_5 in var_0.var_24F3) {
      var_6 = getweaponvariantindex(var_7);
      if(!isDefined(var_6)) {
        continue;
      }

      var_3++;
    }

    if(func_9EBC(var_3, 3)) {
      var_1 func_D991("ch_outfitter_variant_triplet");
    }
  }

  if(var_0.sweapon != var_1.primaryweapon && var_0.sweapon != var_1.secondaryweapon) {
    return;
  }

  var_8 = scripts\mp\loot::getlootinfoforweapon(var_1.primaryweapon);
  var_9 = scripts\mp\loot::getlootinfoforweapon(var_1.secondaryweapon);
  if(isDefined(var_8) && isDefined(var_8.quality) && isDefined(var_9) && isDefined(var_9.quality)) {
    if(var_8.quality == var_9.quality) {
      switch (var_8.quality) {
        case 4:
          var_1 func_D991("ch_outfitter_epic_set");
          break;

        case 3:
          var_1 func_D991("ch_outfitter_legendary_set");
          break;

        case 2:
          var_1 func_D991("ch_outfitter_rare_set");
          break;

        case 1:
          var_1 func_D991("ch_outfitter_common_set");
          break;
      }
    }
  }
}

func_D9AE(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility::istrue(var_0.modifiers["wallkill"])) {
    var_2 func_D991("ch_wallrun_kill");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["jumpkill"])) {
    var_2 func_D991("ch_air_kill");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["slidekill"])) {
    var_2 func_D991("ch_slide_kill");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["killonwall"])) {
    var_2 func_D991("ch_kill_wallrunner");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["killinair"])) {
    var_2 func_D991("ch_kill_jumper");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["clutchkill"])) {
    var_2 func_D991("ch_clutch_grenade");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["wallkill"]) && scripts\mp\utility::istrue(var_0.modifiers["killonwall"])) {
    var_2 func_D991("ch_wall_vs_wall");
  }
}

func_D9B9(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.var_24E4)) {
    if(func_9EBC(var_0.var_24E4, 5)) {
      var_2 func_D991("ch_bloodthirsty");
    }

    if(func_9EBC(var_0.var_24E4, 10)) {
      var_2 func_D991("ch_merciless");
    }

    if(func_9EBC(var_0.var_24E4, 15)) {
      var_2 func_D991("ch_ruthless");
    }
  }
}

func_D9B2(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.var_2504)) {
    if(func_9EBC(var_0.var_2504, 2)) {
      var_2 func_D991("ch_double_kill");
    }

    if(func_9EBC(var_0.var_2504, 3)) {
      var_2 func_D991("ch_triple_kill");
    }

    if(func_9EBC(var_0.var_2504, 4)) {
      var_2 func_D991("ch_quad_kill");
    }
  }
}

func_D9B0(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0.var_24FD) {
    switch (var_5) {
      case "specialty_expanded_minimap":
        var_2 func_D991("ch_perk_kills_awareness");
        break;

      case "specialty_blastshield":
        var_2 func_D991("ch_perk_kills_blastshield");
        break;

      case "specialty_dexterity":
        var_2 func_D991("ch_perk_kills_dexterity");
        if((isDefined(var_0.var_24FA) && gettime() - var_0.var_24FA < 5000) || isDefined(var_0.var_24FC) && gettime() - var_0.var_24FC < 5000) {
          var_2 func_D991("ch_dexterity_actions");
        }
        break;

      case "specialty_ghost":
        if(scripts\mp\utility::istrue(var_0.var_13384)) {
          var_2 func_D991("ch_perk_kills_ghost");
        }

        if(scripts\mp\utility::istrue(var_0.modifiers["backstab"])) {
          var_2 func_D991("ch_ghost_backstab");
        }
        break;

      case "specialty_momentum":
        if(var_0.smeansofdeath == "MOD_MELEE" && var_0.var_24FE > 1) {
          var_2 func_D991("ch_momentum_melee");
        }
        break;

      case "specialty_tracker":
        var_2 func_D991("ch_perk_kills_tracker");
        if(var_0.smeansofdeath == "MOD_MELEE") {
          var_2 func_D991("ch_tracker_melee");
        }
        break;

      case "specialty_stun_resistance":
        if(isDefined(var_0.var_250C[var_3.guid])) {
          var_2 func_D991("ch_perk_kills_tacresist");
        }
        break;

      case "specialty_coldblooded":
        if(scripts\mp\utility::weaponhasattachment(var_0.var_13385, "thermal") || scripts\mp\utility::istrue(var_0.var_1337D) || scripts\mp\utility::istrue(var_0.var_1337B)) {
          var_2 func_D991("ch_perk_kills_coldblooded");
        }

        if(scripts\mp\utility::getweapongroup(var_0.sweapon) == "weapon_sniper") {
          var_2 func_D991("ch_coldblood_sniper");
        }
        break;

      case "specialty_sprintfire":
        if(var_0.var_24F1 && var_0.isbulletdamage) {
          var_2 func_D991("ch_perk_kills_gungho");
        }

        if(isDefined(var_0.var_24F5) && func_9EBC(var_0.var_24F5, 2)) {
          var_2 func_D991("ch_gungho_double_kill");
        }
        break;

      case "specialty_bullet_outline":
        var_2 func_D991("ch_perk_kills_pinpoint");
        var_6 = undefined;
        if(isDefined(var_0.var_13374[var_2.guid])) {
          var_6 = var_0.var_13374[var_2.guid].firsttimedamaged;
        }

        if(isDefined(var_6)) {
          var_7 = undefined;
          if(isDefined(var_0.var_24E0[var_3.guid])) {
            var_7 = var_0.var_24E0[var_3.guid].firsttimedamaged;
          }

          if(isDefined(var_7) && var_7 < var_6) {
            var_2 func_D991("ch_pinpoint_counter_kill");
          }
        }
        break;

      case "specialty_marksman":
        if(scripts\mp\utility::istrue(var_0.modifiers["longshot"])) {
          var_2 func_D991("ch_marksman_longshot");
        }

        if(var_0.var_24EF && isDefined(var_0.var_24F9) && gettime() < var_0.var_24F9 + 3000) {
          var_2 func_D991("ch_marksman_flinch");
        }
        break;

      case "specialty_empimmune":
        var_2 func_D991("ch_perk_kills_hardwired");
        break;

      case "specialty_quieter":
        var_2 func_D991("ch_perk_kills_deadsilence");
        if(var_0.smeansofdeath == "MOD_MELEE") {
          var_2 func_D991("ch_deadsilence_melee");
        }
        break;
    }
  }
}

func_D9C8(var_0, var_1, var_2, var_3) {
  if(var_0.sweapon == "none") {
    if(isDefined(var_0.victim.explosiveinfo) && isDefined(var_0.victim.explosiveinfo["weapon"])) {
      var_0.sweapon = var_0.victim.explosiveinfo["weapon"];
    } else {
      return;
    }
  }

  if(var_0.var_4F scripts\mp\utility::ispickedupweapon(var_0.sweapon)) {
    var_2 func_D991("ch_pickup_kills");
    var_4 = scripts\mp\loot::getlootinfoforweapon(var_0.sweapon);
    if(isDefined(var_4) && isDefined(var_4.quality) && var_4.quality == 4) {
      var_2 func_D991("ch_outfitter_thief");
    }

    if(isDefined(var_0.var_2512) && isDefined(var_0.var_2512[var_0.sweapon]) && gettime() - var_0.var_2512[var_0.sweapon] < 10000) {
      var_2 func_D991("ch_quick_pickup_kill");
    }
  }

  var_5 = scripts\mp\utility::getweaponrootname(var_0.sweapon);
  var_6 = scripts\mp\utility::getweapongroup(var_0.sweapon);
  if(var_0.smeansofdeath == "MOD_PISTOL_BULLET" || var_0.smeansofdeath == "MOD_RIFLE_BULLET" || var_0.smeansofdeath == "MOD_HEAD_SHOT") {
    func_D990(var_0, var_2, var_1, var_6, var_5);
  } else if(isexplosivedamagemod(var_0.smeansofdeath)) {
    func_D99E(var_0, var_2, var_1, var_6, var_5);
  } else if(issubstr(var_0.smeansofdeath, "MOD_MELEE") && !scripts\mp\weapons::isriotshield(var_0.sweapon)) {
    func_D9AC(var_0, var_2, var_1, var_6, var_5);
  } else if(scripts\mp\weapons::isriotshield(var_0.sweapon)) {
    func_D9B3(var_0, var_2, var_1, var_6, var_5);
  } else if(issubstr(var_0.smeansofdeath, "MOD_IMPACT")) {
    if(var_5 == "iw7_axe") {
      var_2 processweaponchallenge_axethrow(var_5, var_0);
    }

    func_D9A0(var_0, var_2, var_1, var_6, var_5);
  }

  if(var_6 == "weapon_projectile") {
    var_2 func_D9CE(var_5, var_0);
  }

  var_7 = scripts\mp\utility::getequipmenttype(var_0.sweapon);
  if(isDefined(var_7)) {
    if(var_7 == "lethal") {
      func_D9A9(var_0, var_2, var_1, var_6, var_5);
    }
  }

  if(scripts\mp\utility::isclassicweapon(var_0.sweapon) && var_0.smeansofdeath != "MOD_MELEE") {
    if(!isDefined(var_2.classickills)) {
      var_2.classickills = 1;
    } else {
      var_2.classickills++;
    }
  }

  if(scripts\mp\utility::isburstfireweapon(var_0.sweapon) && var_0.smeansofdeath != "MOD_MELEE") {
    if(!isDefined(var_2.burstfirekills)) {
      var_2.burstfirekills = 1;
    } else {
      var_2.burstfirekills++;
    }
  }

  if(!scripts\mp\utility::istrue(var_2.var_D99C)) {
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    foreach(var_13, var_12 in var_0.var_24F3) {
      var_8 = var_8 || scripts\mp\utility::iscacprimaryweapon(var_13);
      var_9 = var_9 || scripts\mp\utility::iscacsecondaryweapon(var_13);
      var_7 = scripts\mp\utility::getequipmenttype(var_13);
      var_10 = var_10 || isDefined(var_7) && var_7 == "lethal";
    }

    if(var_8 && var_9 && var_10) {
      var_2 func_D991("ch_3_kill_types");
      var_2.var_D99C = 1;
    }
  }
}

func_D990(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility::iskillstreakweapon(var_0.sweapon) || scripts\mp\utility::isenvironmentweapon(var_0.sweapon)) {
    return;
  }

  switch (var_3) {
    case "weapon_smg":
      var_1 func_D9D1(var_4, var_0);
      break;

    case "weapon_assault":
      var_1 func_D9C9(var_4, var_0);
      break;

    case "weapon_shotgun":
      var_1 func_D9D0(var_4, var_0);
      break;

    case "weapon_dmr":
      var_1 func_D9CA(var_4, var_0);
      break;

    case "weapon_sniper":
      if(var_4 == "iw7_m1c") {
        var_1 func_D9C9(var_4, var_0);
      } else {
        var_1 func_D9D2(var_4, var_0);
      }
      break;

    case "weapon_pistol":
      var_1 func_D9CD(var_4, var_0);
      break;

    case "weapon_lmg":
      var_1 func_D9CB(var_4, var_0);
      break;

    default:
      break;
  }

  if(scripts\mp\utility::istrue(weaponusesenergybullets(var_0.sweapon))) {
    var_1 func_D991("ch_lifetime_energy_kills");
  }

  if(scripts\mp\utility::istrue(var_0.modifiers["headshot"])) {
    var_1 func_D991("ch_lifetime_headshots");
  }

  if(var_0.var_24E3 == 0) {
    var_5 = weaponclipsize(var_0.sweapon);
    if(var_5 >= 10) {
      var_1 func_D991("ch_last_bullet_kill");
    }
  }

  var_6 = scripts\mp\utility::getweaponrootname(var_0.sweapon);
  var_7 = issubstr(var_0.sweapon, "alt_");
  var_8 = getweaponvariantindex(var_0.sweapon);
  var_9 = (var_6 == "iw7_fmg" && var_7) || var_6 == "iw7_ump45" && isDefined(var_8) && var_8 == 3 || var_8 == 35 || var_6 == "iw7_minilmg" && isDefined(var_8) && var_8 == 3 || var_8 == 35;
  if(var_9) {
    if(!isDefined(var_1.akimbokills)) {
      var_1.akimbokills = 1;
    } else {
      var_1.akimbokills++;
    }
  }

  func_D98E(var_0, var_1, var_2, var_3, var_4);
}

func_D98E(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility::issuperweapon(var_0.sweapon)) {
    return 0;
  }

  if(getweaponcamoname(var_0.sweapon) != "camo0") {
    var_1 func_D991("ch_outfitter_camo");
  }

  if(var_3 == "weapon_sniper" && !scripts\mp\weapons::func_13C98(var_0.sweapon)) {
    var_1 func_D9C3(var_4, "noscope", var_0);
  }

  var_5 = 0;
  var_6 = 0;
  var_7 = scripts\mp\utility::getweaponattachmentsbasenames(var_0.sweapon);
  foreach(var_9 in var_7) {
    if(scripts\mp\utility::func_248E(var_9)) {
      var_1 func_D991("ch_outfitter_charm");
      if(var_9 == "cos_026" || var_9 == "cos_007" || var_9 == "cos_006") {
        var_5 = 1;
      }
    }

    if(!scripts\mp\weapons::func_9F3C(var_4, var_9)) {
      continue;
    }

    switch (var_9) {
      case "oscope":
      case "vzscope":
      case "elo":
      case "phase":
      case "reflex":
      case "hybrid":
      case "acog":
      case "thermal":
        var_1 func_D9C3(var_4, var_9, var_0);
        var_1 func_D991("ch_attach_rof");
        var_6 = 1;
        break;

      case "smart":
        var_1 func_D991("ch_attach_rof");
        var_6 = 1;
        break;

      case "xmags":
        if(func_9EBC(var_0.var_24F4, 2)) {
          var_1 func_D991("ch_xmags_two_kills");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "xmagse":
        if(func_9EBC(var_0.var_24F4, 2)) {
          var_1 func_D991("ch_xmags_two_kills");
        }

        var_1 func_D991("ch_attach_xmags");
        break;

      case "fastaim":
        if(gettime() - var_0.var_24F7 < 3000) {
          var_1 func_D991("ch_fastaim_ads_kill");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "stock":
        if(var_0.var_24EF && var_0.var_250A >= 50) {
          var_1 func_D991("ch_stock_ads_kill");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "cpu":
        if(var_0.var_24EF && !var_0.var_24EB) {
          var_1 func_D991("ch_cpu_ads_kill");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "akimbo":
        if(!var_0.var_2500) {
          var_1 func_D991("ch_akimbo_jump_kill");
        }

        var_1 func_D991("ch_attach_" + var_9);
        if(!isDefined(var_1.akimbokills)) {
          var_1.akimbokills = 1;
        } else {
          var_1.akimbokills++;
        }
        break;

      case "fmj":
        if(var_0.var_92BE &level.idflags_penetration) {
          var_1 func_D991("ch_fmj_penetrate");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "highcal":
        if(isDefined(var_0.modifiers["headshot"])) {
          var_1 func_D991("ch_highcal_headshots");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "barrelrange":
        if(isDefined(var_0.modifiers["longshot"])) {
          var_1 func_D991("ch_barrelrange_longshots");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "hipaim":
        if(isDefined(var_0.modifiers["hipfire"])) {
          var_1 func_D991("ch_hipaim_hipfire");
        }

        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "overclock":
      case "rof":
      case "silencer":
      case "grip":
      case "firetypeauto":
        var_1 func_D991("ch_attach_" + var_9);
        break;

      case "reflect":
        var_1 func_D991("ch_attach_ricochet");
        break;

      default:
        break;
    }
  }

  if(var_5) {
    var_3 = scripts\mp\utility::getweapongroup(var_0.sweapon);
    if(var_3 == "weapon_assault" && scripts\mp\utility::istrue(weaponusesenergybullets(var_0.sweapon))) {
      var_1 func_D991("ch_rvn_unlock");
    }

    if(var_3 == "weapon_pistol" && var_6 == 1) {
      var_1 func_D991("ch_udm_unlock");
    }
  }

  if(scripts\mp\utility::func_13C91(var_0.sweapon)) {
    var_1 func_D9BF(var_4, "firetypeburst");
  }

  if(scripts\mp\utility::func_13C94(var_4)) {
    var_1 func_D9BF(var_4, "silencer");
  }

  if(scripts\mp\utility::func_13C93(var_4)) {
    var_1 func_D9BF(var_4, "grip");
  }

  if(scripts\mp\utility::func_13C92(var_4)) {
    var_1 func_D9BF(var_4, "fmj");
  }

  if(var_1 scripts\mp\utility::func_9EE8() && scripts\mp\utility::func_13C95(var_0.sweapon)) {
    var_1 func_D9BF(var_4, "tracker");
  }
}

func_D99E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility::getweaponattachmentsbasenames(var_0.sweapon);
  foreach(var_7 in var_5) {
    switch (var_7) {
      case "gl":
        if(scripts\mp\utility::isstrstart(var_0.sweapon, "alt_")) {
          var_1 func_D9BF(var_4, var_7);
        }
        break;
    }
  }

  if(isDefined(var_0.var_94B6)) {
    if(var_0.var_94B6 == "power_explodingDrone") {
      if(isDefined(var_0.var_94B3) && isDefined(var_0.var_94B5)) {
        if(var_0.var_94B3 == var_1) {
          if(var_0.var_94B5 == var_1) {
            var_1 func_D991("ch_explodingdrone_combo");
            return;
          }

          return;
        }

        return;
      }

      return;
    }

    if(var_0.var_94B6 == "power_tripMine") {
      if(isDefined(var_0.var_94B3) && isDefined(var_0.var_94B5)) {
        if(var_0.var_94B3 == var_1) {
          if(var_0.var_94B5 == var_1) {
            var_1 func_D991("ch_tripmine_explode");
            return;
          }

          if(var_0.var_94B5 == var_0.victim) {
            var_1 func_D991("ch_enemy_equip_kill");
            return;
          }

          return;
        }

        return;
      }

      return;
    }
  }
}

func_D9AC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility::getweaponattachmentsbasenames(var_0.sweapon);
  foreach(var_7 in var_5) {
    switch (var_7) {
      case "tactical":
        var_1 func_D9BF(var_4, var_7);
        break;
    }
  }

  if(var_0.var_13380 == "crouch" || var_0.var_13380 == "prone") {
    var_1 func_D991("ch_melee_crouch_prone");
  }

  if(var_3 == "weapon_melee") {
    if(var_4 == "iw7_axe") {
      var_1 processweaponchallenge_axemelee(var_4, var_0);
      return;
    }

    var_1 func_D9CC(var_4, var_0);
  }
}

func_D9B3(var_0, var_1, var_2, var_3, var_4) {
  if(issubstr(var_0.smeansofdeath, "MOD_MELEE")) {
    var_1 func_D9CF(var_4, var_0);
  }

  var_5 = scripts\mp\utility::getweaponattachmentsbasenames(var_0.sweapon);
  foreach(var_7 in var_5) {
    switch (var_7) {
      case "rshieldspikes":
      case "rshieldscrambler":
      case "rshieldradar":
        var_1 func_D9BF(var_4, var_7);
        break;
    }
  }
}

func_D9A0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\mp\utility::getweaponattachmentsbasenames(var_0.sweapon);
  foreach(var_7 in var_5) {
    switch (var_7) {
      case "gl":
        if(scripts\mp\utility::isstrstart(var_0.sweapon, "alt_")) {
          var_1 func_D9BF(var_4, var_7);
        }
        break;
    }
  }
}

func_D9A9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.var_D7A4[var_0.sweapon];
  switch (var_5) {
    case "power_splashGrenade":
      var_1 func_D991("ch_lethal_splash");
      break;

    case "power_clusterGrenade":
      var_1 func_D991("ch_lethal_cluster");
      break;

    case "power_tripMine":
      var_1 func_D991("ch_lethal_tripmine");
      break;

    case "power_splitGrenade":
      var_1 func_D991("ch_lethal_split");
      break;

    case "power_explodingDrone":
      var_1 func_D991("ch_lethal_explodingdrone");
      break;

    case "power_blackholeGrenade":
      var_1 func_D991("ch_lethal_blackhole");
      break;

    case "power_wristRocket":
      var_1 func_D991("ch_lethal_armlauncher");
      break;

    case "power_spiderGrenade":
      var_1 func_D991("ch_lethal_spider");
      break;

    case "power_c4":
      var_1 func_D991("ch_lethal_c4");
      break;

    case "power_bioSpike":
      var_1 func_D991("ch_lethal_biospike");
      break;

    case "power_throwingKnife":
      break;

    default:
      break;
  }

  if(isDefined(var_0.var_94B4) && var_0.var_94B4 == "friendly") {
    var_1 func_D991("ch_stick_teammate");
  }
}

func_3C03(var_0) {
  if(!isDefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3) {
    return;
  }

  var_1 = var_0.player;
  if(var_1.wasaliveatmatchstart) {
    var_2 = var_1.pers["kills"];
    var_3 = var_1.pers["deaths"];
    var_4 = var_1.pers["score"];
    var_5 = 1000000;
    if(var_3 > 0) {
      var_5 = var_2 / var_3;
    }

    var_1.pers["kdratio"] = var_5;
    if(var_5 >= 5 && var_2 >= 5) {
      var_1 processchallenge("ch_starplayer");
    }

    if(var_3 == 0 && scripts\mp\utility::gettimepassed() > 300000) {
      var_1 processchallenge("ch_flawless");
    }

    if(var_1.destroynavrepulsor > 0) {
      var_6 = scripts\mp\utility::roundup(var_1.destroynavrepulsor / 100);
      var_1 func_D991("ch_lifetime_score", var_6);
      switch (level.gametype) {
        case "dm":
          if(var_0.var_CBFC < 3) {
            var_1 func_D991("ch_ffa_wins");
          }
          break;

        case "sotf_ffa":
          if(var_0.var_CBFC < 3) {
            var_1 processchallenge("ch_hunted_victor");
          }
          break;
      }
    }
  }

  var_1 checkvrunlockchallenge();
  var_1 checkmp28unlockchallenge();
  var_1 checkminilmgunlockchallenge();
  var_1 checkba50calunlockchallenge();
  var_1 checkmod2187unlockchallenge();
  var_1 checklongshotunlockchallenge();
  var_1 checkgaussunlockchallenge();
  var_1 checkmustangunlockchallenge();
  var_1 checktacburstunlockchallenge();
  var_1 checkatlasunlockchallenge();
}

func_3C04(var_0) {
  if(!var_0.var_13D8A) {
    return;
  }

  if(!isDefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3) {
    return;
  }

  var_1 = var_0.player;
  if(var_1.wasaliveatmatchstart) {
    var_1 func_D991("ch_global_wins");
    if(level.tactical) {
      var_1 func_D991("ch_ctf_wins");
    }

    if(var_0.var_CBFC == 0) {
      var_1 func_D991("ch_first_place");
    }

    if(var_0.var_CBFC <= 2) {
      var_1 func_D991("ch_top3");
    }

    switch (level.gametype) {
      case "war":
        var_1 func_D991("ch_war_wins");
        break;

      case "sd":
        var_1 func_D991("ch_sd_sr_wins");
        break;

      case "dom":
        var_1 func_D991("ch_dom_wins");
        break;

      case "conf":
        var_1 func_D991("ch_kc_grind_wins");
        break;

      case "sr":
        var_1 func_D991("ch_sd_sr_wins");
        break;

      case "grind":
        var_1 func_D991("ch_kc_grind_wins");
        break;

      case "ball":
        var_1 func_D991("ch_ball_wins");
        break;

      case "infect":
        break;

      case "aliens":
        break;

      case "gun":
        break;

      case "grnd":
        break;

      case "siege":
        var_1 func_D991("ch_siege_wins");
        break;

      case "koth":
        var_1 func_D991("ch_koth_wins");
        break;

      case "mp_zomb":
        break;

      case "ctf":
        break;

      case "dd":
        var_1 func_D991("ch_dd_wins");
        break;

      case "tdef":
        var_1 func_D991("ch_tdef_wins");
        break;

      case "front":
        var_1 func_D991("ch_war_wins");
        break;

      default:
        break;
    }

    var_2 = getdvarint("scr_playlist_type", 0);
    if(var_2 == 1) {
      var_1 processchallenge("ch_bromance");
      if(!level.console) {
        var_1 processchallenge("ch_tactician");
      }
    } else if(var_2 == 2) {
      var_1 processchallenge("ch_tactician");
    }

    if(level.hardcoremode) {
      var_1 processchallenge("ch_hardcore_extreme");
    }
  }

  var_1 checkcrdbunlockchallenge();
}

checkvrunlockchallenge() {
  if(func_2139("ch_vr_unlock")) {
    return;
  }

  if(isDefined(self.killsperweapon)) {
    var_0 = [];
    foreach(var_4, var_2 in self.killsperweapon) {
      if(var_2 > 0 && scripts\mp\utility::iscacprimaryweapon(var_4) || scripts\mp\utility::iscacsecondaryweapon(var_4)) {
        var_3 = scripts\mp\utility::getweaponrootname(var_4);
        var_0[var_3] = 1;
        if(var_0.size >= 6) {
          func_D991("ch_vr_unlock");
          return;
        }
      }
    }
  }
}

checkcrdbunlockchallenge() {
  if(func_2139("ch_crdb_unlock")) {
    return;
  }

  if(isDefined(self.killsperweapon)) {
    var_0 = 0;
    foreach(var_3, var_2 in self.killsperweapon) {
      if(scripts\mp\utility::getweaponrootname(var_3) == "iw7_vr") {
        var_0 = var_0 + var_2;
      }

      if(var_0 > 0) {
        func_D991("ch_crdb_unlock");
        return;
      }
    }
  }
}

checkminilmgunlockchallenge() {
  if(func_2139("ch_minilmg_unlock")) {
    return;
  }

  if(isDefined(self.shotslandedlmg) && self.shotslandedlmg >= 50) {
    func_D991("ch_minilmg_unlock");
  }
}

checkmp28unlockchallenge() {
  if(func_2139("ch_mp28_unlock")) {
    return;
  }

  if(isDefined(self.classickills) && self.classickills >= 10) {
    func_D991("ch_mp28_unlock");
  }
}

checkba50calunlockchallenge() {
  if(func_2139("ch_ba50cal_unlock")) {
    return;
  }

  if(isDefined(self.pers["oneShotKills"]) && self.pers["oneShotKills"] >= 5) {
    func_D991("ch_ba50cal_unlock");
  }
}

checkmod2187unlockchallenge() {
  if(func_2139("ch_mod2187_unlock")) {
    return;
  }

  if(isDefined(self.akimbokills) && self.akimbokills >= 10) {
    func_D991("ch_mod2187_unlock");
  }
}

checklongshotunlockchallenge() {
  if(func_2139("ch_longshot_unlock")) {
    return;
  }

  var_0 = 0;
  var_1 = 0;
  foreach(var_5, var_3 in self.killsperweapon) {
    if(var_3 > 0 && scripts\mp\utility::iscacprimaryweapon(var_5) || scripts\mp\utility::iscacsecondaryweapon(var_5)) {
      var_4 = scripts\mp\utility::getweaponrootname(var_5);
      if(var_4 == "iw7_ba50cal") {
        var_0 = 1;
      }

      if(var_4 == "iw7_mod2187") {
        var_1 = 1;
      }
    }
  }

  if(var_0 && var_1) {
    func_D991("ch_longshot_unlock");
  }
}

checkgaussunlockchallenge() {
  if(func_2139("ch_gauss_unlock")) {
    return;
  }

  if(isDefined(self.hipfiremagkills) && self.hipfiremagkills >= 5) {
    func_D991("ch_gauss_unlock");
  }
}

checkmustangunlockchallenge() {
  if(func_2139("ch_mag_unlock")) {
    return;
  }

  var_0 = 1;
  var_1 = 0;
  foreach(var_5, var_3 in self.killsperweapon) {
    if(!scripts\mp\utility::iscacprimaryweapon(var_5) && !scripts\mp\utility::iscacsecondaryweapon(var_5)) {
      continue;
    }

    var_4 = scripts\mp\utility::getweapongroup(var_5);
    if(var_4 != "weapon_pistol") {
      var_0 = 0;
      break;
    } else {
      var_1 = var_1 + var_3;
    }
  }

  if(var_0 && var_1 >= 5) {
    func_D991("ch_mag_unlock");
  }
}

checktacburstunlockchallenge() {
  if(func_2139("ch_tacburst_unlock")) {
    return;
  }

  if(isDefined(self.burstfirekills) && self.burstfirekills >= 10) {
    func_D991("ch_tacburst_unlock");
  }
}

checkatlasunlockchallenge() {
  if(func_2139("ch_unsalmg_unlock")) {
    return;
  }

  if(isDefined(self.killsperweapon)) {
    var_0 = 0;
    foreach(var_3, var_2 in self.killsperweapon) {
      if(scripts\mp\utility::getweaponrootname(var_3) == "iw7_tacburst") {
        var_0 = var_0 + var_2;
      }

      if(var_0 >= 10) {
        func_D991("ch_unsalmg_unlock");
        return;
      }
    }
  }
}

func_D378(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!func_B4E8()) {
    return;
  }

  if(!isplayer(self)) {
    return;
  }

  self endon("disconnect");
  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  func_3BF6(var_0, var_1, var_2, var_3, var_4, var_5);
  wait(0.05);
  scripts\mp\utility::func_13842();
  var_6 = spawnStruct();
  var_6.victim = self;
  var_6.einflictor = var_0;
  var_6.var_4F = var_1;
  var_6.idamage = var_2;
  var_6.smeansofdeath = var_3;
  var_6.sweapon = var_4;
  var_6.shitloc = var_5;
  func_5914("playerDamaged", var_6);
}

playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!func_B4E8()) {
    return;
  }

  if(!isDefined(var_1)) {
    return;
  }

  if(isDefined(var_1.var_A686)) {
    var_1.var_A686++;
  }

  if(isplayer(var_1) && var_1 issprinting()) {
    if(!isDefined(var_1.var_A687)) {
      var_1.var_A687 = 1;
    } else {
      var_1.var_A687++;
    }
  }

  func_3BFF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  self endon("disconnect");
  var_1 endon("disconnect");
  var_9 = spawnStruct();
  var_9.victim = self;
  var_9.victimid = self getentitynumber();
  var_9.einflictor = var_0;
  var_9.var_4F = var_1;
  var_9.idamage = var_2;
  var_9.var_92BE = var_3;
  var_9.smeansofdeath = var_4;
  var_9.sweapon = var_5;
  var_9.sprimaryweapon = var_6;
  var_9.shitloc = var_7;
  var_9.time = gettime();
  var_9.modifiers = var_8;
  var_9.isbulletdamage = scripts\engine\utility::isbulletdamage(var_4);
  if(isDefined(var_5) && issubstr(var_5, "_hybrid")) {
    if(var_1 getcurrentweapon() == var_5) {
      var_9.var_9272 = var_1 func_812E(var_5);
    } else {
      var_9.var_9272 = 0;
    }
  }

  var_9.victimonground = var_9.victim isonground();
  if(isplayer(var_1)) {
    var_1.killsthislife[var_1.killsthislife.size] = var_9;
    if(isDefined(var_1.killsthislifeperweapon[var_9.sweapon])) {
      var_1.killsthislifeperweapon[var_9.sweapon]++;
    } else {
      var_1.killsthislifeperweapon[var_9.sweapon] = 1;
    }

    if(!scripts\mp\utility::iskillstreakweapon(var_9.sweapon)) {
      if(isDefined(var_1.killsperweapon[var_9.sweapon])) {
        var_1.killsperweapon[var_9.sweapon]++;
      } else {
        var_1.killsperweapon[var_9.sweapon] = 1;
      }
    }

    var_9.var_24EC = isDefined(var_9.var_4F.setlasermaterial);
    var_9.var_2500 = var_9.var_4F isonground();
    var_9.var_250B = var_9.var_4F getstance();
    var_9.var_24E4 = var_1.pers["cur_kill_streak"];
    var_9.var_2504 = var_1.var_DDC2;
    var_9.var_2505 = var_1.var_DDC3;
    var_9.attackerarchetype = getsubstr(var_1.loadoutarchetype, 10, var_1.loadoutarchetype.size);
    var_9.attackerkillsthislife = var_1.killsthislife.size;
    var_9.var_24F3 = var_1.killsthislifeperweapon;
    var_9.var_24E3 = var_1 getweaponammoclip(var_5);
    var_9.var_24EB = var_1.var_9074;
    var_9.var_24F8 = var_1.var_A960;
    var_9.var_2503 = var_1.pers["primaryWeapon"];
    var_9.var_2509 = var_1.pers["secondaryWeapon"];
    var_9.var_24F6 = var_1.var_A6B4;
    var_9.var_24F2 = var_1.var_A653;
    var_9.var_24E1 = var_1 scripts\mp\weapons::isstunnedorblinded();
    var_9.var_24E0 = var_1.attackerdata;
    var_9.var_2512 = var_1.var_13CB9;
    var_9.var_24EA = var_1.hasactivesmokegrenade;
    var_9.var_2501 = var_1.personalradaractive;
    var_9.var_2511 = var_1.usedadrenalineatfullhp;
    var_9.var_24F4 = var_1.var_A686;
    var_9.var_24EF = var_1 scripts\mp\utility::func_9EE8();
    var_9.var_24F7 = var_1.var_A932;
    var_9.var_250A = length(var_1 getvelocity());
    var_9.var_24FD = var_1.pers["loadoutPerks"];
    var_9.var_24FA = var_1.var_A9DD;
    var_9.var_24FC = var_1.var_A9D3;
    var_9.var_24F9 = var_1.var_A98B;
    var_9.var_24FE = scripts\engine\utility::ter_op(isDefined(var_1.movespeedscaler), var_1.movespeedscaler, 1);
    var_9.var_24E9 = var_1.var_6A06;
    var_9.var_250C = var_1.var_1119A;
    var_9.var_24F5 = var_1.var_A687;
    var_9.var_24F1 = var_1 issprinting();
    var_9.var_24E8 = var_1 scripts\mp\supers::getcurrentsuperref();
    var_9.var_250D = var_1 scripts\mp\supers::issuperinuse();
    var_9.var_2506 = var_1.trait;
    var_9.attackersixthsensesource = var_1.sixthsensesource;
    var_9.attackerrelaysource = var_1.relaysource;
    var_9.attackerrearguardattackers = var_1.rearguardattackers;
    var_9.var_2510 = var_1.tookweaponfrom;
    var_9.var_24EE = var_1 getweaponslistall();
    var_9.attackerhassupertrophyout = isDefined(var_1.supertrophies) && var_1.supertrophies.size > 0;
    var_9.attackervisionpulsedvictim = var_1 scripts\mp\supers\super_visionpulse::func_9EF9(var_9.victim);
    if(isDefined(var_1.var_6A06)) {
      var_1.var_6A06[self.guid] = undefined;
    }

    if(isDefined(var_1.var_1119A)) {
      var_1.var_1119A[self.guid] = undefined;
    }
  } else {
    var_9.var_24EC = 0;
    var_9.var_2500 = 0;
    var_9.var_250B = "stand";
    var_9.var_24E4 = 0;
    var_9.var_2505 = 0;
    var_9.var_24F3 = [];
    var_9.var_24F2 = [];
    var_9.var_24E1 = 0;
    var_9.var_24E0 = [];
    var_9.var_2512 = [];
    var_9.var_24F4 = 0;
    var_9.var_24FD = [];
    var_9.var_24F5 = 0;
    var_9.var_24F1 = 0;
    var_9.var_24E8 = "";
    var_9.var_250D = 0;
  }

  if(isDefined(var_0)) {
    var_9.var_94B4 = var_0.isstuck;
    var_9.var_94B5 = var_0.owner;
    var_9.var_94B6 = var_0.power;
    var_9.var_94B3 = var_0.damagedby;
    var_9.var_94B7 = var_0.waschained;
    var_9.wasplantedmine = var_0.planted;
  }

  var_9.var_13374 = self.attackerdata;
  var_9.var_13375 = scripts\mp\weapons::isstunnedorblinded();
  var_9.var_13380 = self getstance();
  var_9.var_13376 = self.debuffedbyplayers;
  var_9.var_13384 = scripts\mp\killstreaks\_utility::func_9FB9(self.team);
  var_9.var_13385 = self.var_EB6C;
  var_9.var_1337D = func_66B8("specialty_tracker");
  var_9.var_1337B = func_66B8("specialty_sixth_sense");
  var_9.var_13379 = func_66B8("specialty_quieter");
  var_9.var_1337A = var_9.victim scripts\mp\supers::getcurrentsuperref();
  var_9.var_1337C = var_9.victim scripts\mp\supers::issuperinuse();
  var_10 = var_9.victim scripts\mp\supers::getcurrentsuper();
  if(isDefined(var_10)) {
    var_9.var_13381 = var_10.var_A986;
  }

  var_11 = scripts\mp\domeshield::func_7E80(self);
  if(isDefined(var_11)) {
    var_9.var_13377 = var_11.owner;
  }

  func_1369C(var_9);
  var_9.var_4F notify("playerKilledChallengesProcessed");
}

killstreakdamaged(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2.var_A6AE)) {
    var_2.var_A6AE = [];
  }

  if(isDefined(self.var_1653)) {
    if(!isDefined(var_2.var_A6AE[self.var_1653])) {
      var_5 = spawnStruct();
      var_5.owner = self.owner;
      var_5.var_A6A7 = var_0;
      var_5.var_4D71 = var_4;
      var_2.var_A6AE[self.var_1653] = var_5;
      return;
    }

    var_2.var_A6AE[self.var_1653].var_4D71 = var_2.var_A6AE[self.var_1653].var_4D71 + var_4;
    return;
  }
}

killstreakkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!func_B4E8()) {
    return;
  }

  if(isDefined(var_4) && isplayer(var_4) && !isDefined(var_1) || var_4 != var_1 && isDefined(var_7)) {
    var_9 = scripts\mp\utility::getweaponrootname(var_7);
    if(!isDefined(var_4.var_A6B3)) {
      var_4.var_A6B3 = [];
    }

    if(!isDefined(var_4.var_A6B3[var_9])) {
      var_4.var_A6B3[var_9] = 1;
    } else {
      var_4.var_A6B3[var_9]++;
    }

    if(var_4 func_66B8("specialty_engineer")) {
      var_4 func_D991("ch_perk_kills_engineer");
    }

    if(var_4.killsthislife.size > 0) {
      var_4 func_D9B8();
    }

    if(scripts\mp\killstreaks\_utility::func_9D28(var_0)) {
      if(var_4 func_66B8("specialty_blindeye")) {
        var_4 func_D991("ch_perk_kills_blindeye");
      }
    }

    var_10 = var_7;
    var_11 = scripts\mp\utility::iskillstreakweapon(var_10);
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = scripts\mp\utility::issuperweapon(var_10);
    var_10 = scripts\engine\utility::isbulletdamage(var_6);
    if(var_11) {
      switch (func_7F48(var_10)) {
        case "jackal":
        case "bombardment":
        case "precision_airstrike":
        case "thor":
        case "minijackal":
        case "drone_hive":
          var_12 = 1;
          break;
      }
    }

    switch (var_0) {
      case "precision_airstrike":
      case "drone_hive":
        var_13 = 1;
        break;

      case "directional_uav":
      case "counter_uav":
      case "uav":
        var_4 func_D991("ch_destroy_uav");
        var_13 = 1;
        break;

      case "minijackal":
        var_4 func_D991("ch_destroy_apex");
        var_13 = 1;
        break;

      case "thor":
        if(var_10) {
          var_4 func_D991("ch_thor_bullet_kill");
        }

        var_13 = 1;
        break;

      case "bombardment":
        var_13 = 1;
        break;

      case "jackal":
        if(var_10) {
          var_4 func_D991("ch_armada_warden_bullet_kill");
        }

        var_13 = 1;
        break;

      case "dronedrop":
        var_4 func_D991("ch_destroy_dronepackage");
        var_13 = 1;
        break;

      case "sentry_shock":
        var_4 func_D991("ch_destroy_sentry");
        var_14 = 1;
        break;

      case "ball_drone_backup":
        var_4 func_D991("ch_destroy_vulture");
        var_14 = 1;
        break;

      case "remote_c8":
        var_4 func_D991("ch_kill_rc8");
        var_14 = 1;
        break;

      case "venom":
        var_4 func_D991("ch_destroy_scarab");
        var_14 = 1;
        break;
    }

    if(var_13) {
      var_4 func_D991("ch_destroy_aerial");
    }

    if(var_12 && var_13) {
      var_4 func_D991("ch_scorestreak_air_to_air");
    }

    if(var_12 && var_14) {
      var_4 func_D991("ch_scorestreak_air_to_ground");
    }

    if(var_15) {
      var_4 func_D991("ch_super_scorestreak_kill");
    }

    var_4 func_D9D4(var_9, var_0, var_2);
    var_4.var_A9A8 = gettime();
  }
}

func_D9D4(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility::getweapongroup(var_0);
  switch (var_3) {
    case "weapon_projectile":
      func_D9D3(var_0, var_1, var_2);
      break;
  }
}

func_D9D3(var_0, var_1, var_2) {
  switch (var_0) {
    case "iw7_glprox":
      func_D9D6(var_0, var_1, var_2);
      break;

    case "iw7_chargeshot":
      func_D9D5(var_0, var_1, var_2);
      break;

    case "iw7_lockon":
      func_D9D7(var_0, var_1, var_2);
      break;

    case "iw7_venomx":
      processweaponkilledkillstreak_venomx(var_0, var_1, var_2);
      break;
  }
}

setweaponammostock(var_0, var_1) {
  if(isDefined(self.attackers)) {
    foreach(var_3 in self.attackers) {
      if(self.attackerdata[var_3.guid].var_DA >= 100) {
        if(!isDefined(scripts\mp\utility::_validateattacker(var_3))) {
          continue;
        }

        if(isDefined(self.owner) && self.owner == var_3) {
          continue;
        }

        if(isDefined(self.owner.team) && scripts\mp\utility::func_9E05(self.owner.team, var_3)) {
          continue;
        }

        if(var_3 == var_1) {
          continue;
        }

        var_3 thread scripts\mp\utility::giveunifiedpoints("vehicle_destroyed_assist");
      }
    }
  }
}

func_1369C(var_0) {
  if(isDefined(var_0.var_4F)) {
    var_0.var_4F endon("disconnect");
  }

  self.var_D9A6 = 1;
  wait(0.05);
  scripts\mp\utility::func_13842();
  func_5914("playerKilled", var_0);
  self.var_D9A6 = undefined;
}

func_D366(var_0) {
  var_1 = spawnStruct();
  var_1.player = self;
  var_1.victim = var_0;
  var_2 = var_0.attackerdata[self.guid];
  if(isDefined(var_2)) {
    var_1.sweapon = var_2.weapon;
  }

  func_5914("playerAssist", var_1);
}

func_13079(var_0) {
  self endon("disconnect");
  wait(0.05);
  scripts\mp\utility::func_13842();
  var_1 = spawnStruct();
  var_1.player = self;
  var_1.var_A6A7 = var_0;
  func_5914("playerUsedKillstreak", var_1);
}

func_A691(var_0) {
  self endon("disconnect");
  wait(0.05);
  scripts\mp\utility::func_13842();
  var_1 = spawnStruct();
  var_1.player = self.owner;
  var_1.var_A6A7 = var_0;
  func_5914("playerKillstreakActive", var_1);
}

func_E75B() {
  func_5914("roundBegin");
}

func_E75D(var_0) {
  var_1 = spawnStruct();
  if(level.teambased) {
    var_2 = "allies";
    for(var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.var_13D8A = var_2 == var_0;
      var_1.var_CBFC = var_3;
      func_5914("roundEnd", var_1);
      var_1.player scripts\mp\contractchallenges::contractmatchend(var_1);
    }

    var_2 = "axis";
    for(var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.var_13D8A = var_2 == var_0;
      var_1.var_CBFC = var_3;
      func_5914("roundEnd", var_1);
      var_1.player scripts\mp\contractchallenges::contractmatchend(var_1);
    }

    return;
  }

  for(var_3 = 0; var_3 < level.placement["all"].size; var_3++) {
    var_1.player = level.placement["all"][var_3];
    var_1.var_13D8A = isDefined(var_0) && isplayer(var_0) && var_1.player == var_0;
    var_1.var_CBFC = var_3;
    func_5914("roundEnd", var_1);
    var_1.player scripts\mp\contractchallenges::contractmatchend(var_1);
  }
}

func_5914(var_0, var_1) {
  if(!func_B4E8()) {
    return;
  }

  if(isDefined(var_1)) {
    var_2 = var_1.player;
    if(!isDefined(var_2)) {
      var_2 = var_1.var_4F;
    }

    if(isDefined(var_2) && isai(var_2)) {
      return;
    }
  }

  if(getdvarint("disable_challenges") > 0) {
    return;
  }

  if(!isDefined(level.var_B8CD[var_0])) {
    return;
  }

  if(isDefined(var_1)) {
    for(var_3 = 0; var_3 < level.var_B8CD[var_0].size; var_3++) {
      thread[[level.var_B8CD[var_0][var_3]]](var_1);
    }

    return;
  }

  for(var_3 = 0; var_3 < level.var_B8CD[var_0].size; var_3++) {
    thread[[level.var_B8CD[var_0][var_3]]]();
  }
}

func_BA1E() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");
  self.var_10ABF = 0;
  for(;;) {
    self waittill("sprint_begin");
    self.var_A9F8 = gettime();
    thread func_BA17();
    thread func_BA18();
  }
}

func_BA1F() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self.var_A687 = 0;
    scripts\engine\utility::waittill_any("sprint_end", "death");
  }
}

func_BA18() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitorSingleSprintMomentumTime()");
  self endon("monitorSingleSprintMomentumTime()");
  self waittill("momentum_max_speed");
  var_0 = gettime();
  self waittill("momentum_reset");
  if(gettime() > var_0 + 5000) {
    func_D991("ch_momentum_time");
  }
}

func_B9BA() {
  if(level.gametype != "tdef") {
    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  self.var_6DE0 = 0;
  for(;;) {
    self waittill("ball_grab");
    self.var_6DE0 = 1;
    self waittill("ball_dropped");
    self.var_6DE0 = 0;
  }
}

func_27FA() {
  if(scripts\mp\utility::istrue(self.var_6DE0)) {
    func_D991("ch_keep_away");
  }
}

func_BA17() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitorSingleSprintDistance()");
  self endon("monitorSingleSprintDistance()");
  var_0 = 0;
  var_1 = gettime();
  for(;;) {
    var_2 = self.origin;
    var_3 = scripts\engine\utility::waittill_any_timeout(0.1, "sprint_end", "death");
    var_4 = distance(self.origin, var_2);
    var_0 = var_0 + var_4;
    if(var_3 != "timeout" || !self issprinting()) {
      break;
    }
  }

  var_5 = gettime() - var_1;
  var_6 = int(var_5 * 0.35);
  var_0 = int(min(var_0, var_6) / 12);
  func_D991("ch_sprint", var_0);
}

func_B9B4() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 = self isonground() && !self iswallrunning();
  var_1 = 0;
  for(;;) {
    if(scripts\mp\utility::istrue(level.hostmigration)) {
      level waittill("host_migration_end");
    }

    if(self isonground() && !self iswallrunning()) {
      var_0 = 1;
    } else {
      if(var_0) {
        var_1 = 0;
      } else {
        var_1 = var_1 + 0.05;
      }

      if(var_1 >= 20) {
        func_D991("ch_stay_in_air");
        return;
      }

      var_0 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA33() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("used_cosmetic_gesture");
    self.var_A960 = gettime();
  }
}

func_B9D5() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("killed_exploding_drone", var_0);
    if(isDefined(var_0) && var_0 != self) {
      func_D991("ch_destroy_explodingdrone");
    }
  }
}

func_BA07() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 = [];
  for(;;) {
    self waittill("power_activated", var_1, var_2);
    if(!isDefined(var_0[var_2])) {
      var_0[var_2] = 1;
    } else {
      var_0[var_2]++;
    }

    if(var_2 == "secondary") {
      func_D991("ch_tactical_uses");
      if(func_9EBC(var_0[var_2], 2)) {
        func_D991("ch_tactical_two_uses");
      }
    }
  }
}

lastmansd() {
  if(!func_B4E8()) {
    return;
  }

  if(!self.wasaliveatmatchstart) {
    return;
  }

  if(self.teamkillsthisround > 0) {
    return;
  }

  processchallenge("ch_lastmanstanding");
}

func_B9C0() {
  self endon("disconnect");
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("bomb_planted", "bomb_defused");
    if(!isDefined(var_0)) {
      continue;
    }

    if(var_0 == "bomb_planted") {
      processchallenge("ch_saboteur");
      continue;
    }

    if(var_0 == "bomb_defused") {
      processchallenge("ch_hero");
    }
  }
}

func_B9ED() {
  for(;;) {
    self waittill("spawned_player");
    thread func_112E0();
  }
}

func_112E0() {
  self endon("death");
  self endon("disconnect");
  wait(300);
  if(isDefined(self)) {
    processchallenge("ch_survivalist");
  }
}

func_B9EF() {
  self endon("death");
  self endon("disconnect");
  self.var_AF2C = [];
  for(;;) {
    self waittill("missile_fire", var_0, var_1);
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = scripts\mp\utility::getweaponrootname(var_1);
    if(var_2 == "iw7_lockon") {
      self.var_AF2C[self.var_AF2C.size] = var_0;
      if(isDefined(self.var_10FAA) && isDefined(self.var_10FA9) && self.var_10FA9 == 2) {
        var_0.var_C83D = self.var_10FAA;
      }
    }
  }
}

processchallenge(var_0, var_1, var_2) {}

func_D991(var_0, var_1, var_2) {
  if(!func_D3D6()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!func_8C49(var_0)) {
    if(getdvarint("debug_challenges")) {}

    return;
  }

  if(!func_9D84(var_0)) {
    return;
  }

  var_3 = func_7E22(var_0);
  if(func_2139(var_0)) {
    return;
  }

  var_4 = func_3BF8(var_0);
  var_5 = level.var_3C2C[var_0]["targetval"][var_3];
  if(isDefined(var_2) && var_2) {
    var_6 = var_1;
  } else {
    var_6 = var_5 + var_2;
  }

  var_7 = 0;
  if(var_6 >= var_5) {
    var_8 = 1;
    var_7 = var_6 - var_5;
    var_6 = var_5;
  } else {
    var_8 = 0;
  }

  if(var_4 < var_6) {
    func_3C05(var_0, var_6);
  }

  if(var_8) {
    thread giverankxpafterwait(var_0, var_3);
    scripts\mp\matchdata::func_AF99(var_0, var_3);
    func_110AE(var_0);
    setturretfov(level.var_3C2C[var_0]["score"][var_3]);
    var_3++;
    func_3C06(var_0, var_3);
    self.var_3C2A[var_0] = var_3;
    if(func_2139(var_0)) {
      thread showchallengesplash(var_0, challengesplasheseachtier(var_0));
      processmasterchallenge(var_0);
      switch (var_0) {
        case "ch_iw7_knife_gold":
        case "ch_iw7_lockon_gold":
        case "ch_iw7_chargeshot_gold":
        case "ch_iw7_glprox_gold":
        case "ch_iw7_emc_gold":
        case "ch_iw7_g18_gold":
        case "ch_iw7_revolver_gold":
        case "ch_iw7_nrg_gold":
          thread func_D991("ch_diamond_melee");
          break;
      }

      return;
    }

    if(givesmasterprogresseachtier(var_0)) {
      processmasterchallenge(var_0);
    }

    if(challengesplasheseachtier(var_0)) {
      thread showchallengesplash(var_0, 1);
      return;
    }
  }
}

processmasterchallenge(var_0) {
  var_1 = level.var_3C2C[var_0]["master"];
  if(isDefined(var_1)) {
    thread func_D991(var_1);
  }
}

func_110AE(var_0) {
  if(!isDefined(self.var_3C30)) {
    self.var_3C30 = [];
  }

  var_1 = 0;
  foreach(var_3 in self.var_3C30) {
    if(var_3 == var_0) {
      var_1 = 1;
    }
  }

  if(!var_1) {
    self.var_3C30[self.var_3C30.size] = var_0;
  }
}

giverankxpafterwait(var_0, var_1) {
  self endon("disconnect");
  if(!level.gameended) {
    wait(0.25);
  }

  var_2 = "challenge";
  var_3 = undefined;
  if(func_9FFC(var_0)) {
    var_3 = scripts\mp\utility::func_13C75(func_8222(var_0));
  }

  var_4 = level.var_3C2C[var_0]["reward"][var_1];
  var_5 = "bonus_challenge_xp";
  if(isDefined(level.prestigeextras[var_5])) {
    if(self isitemunlocked(var_5, "prestigeExtras", 1)) {
      var_4 = int(var_4 * 1.25);
    }
  }

  scripts\mp\rank::giverankxp(var_2, var_4, var_3);
}

setturretfov(var_0) {
  var_1 = self getplayerdata("mp", "challengeScore");
  self setplayerdata("mp", "challengeScore", var_1 + var_0);
}

func_12E71() {
  self.var_3C2A = [];
  self endon("disconnect");
  if(!func_B4E8()) {
    return;
  }

  var_0 = 0;
  foreach(var_5, var_2 in level.var_3C2C) {
    var_0++;
    if(var_0 % 20 == 0) {
      wait(0.05);
    }

    self.var_3C2A[var_5] = 0;
    var_3 = var_2["index"];
    var_4 = func_3BF9(var_5);
    self.var_3C2A[var_5] = var_4;
  }
}

func_7E20(var_0) {
  return tablelookup("mp\allChallengesTable.csv", 0, var_0, 6);
}

func_7E21(var_0) {
  var_1 = tablelookup("mp\allChallengesTable.csv", 0, var_0, 7);
  if(isDefined(var_1) && var_1 == "") {
    return undefined;
  }

  return var_1;
}

func_B029(var_0, var_1) {
  return int(tablelookup("mp\allChallengesTable.csv", 0, var_0, 10 + var_1 * 3));
}

func_9F27(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = func_7E20(var_0);
  switch (var_1) {
    case "all_optics":
    case "oscope":
    case "vzscope":
    case "elo":
    case "phase":
    case "reflex":
    case "hybrid":
    case "acog":
    case "noscope":
    case "thermal":
      return 1;
  }

  return 0;
}

isrigcustomizationchallenge(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = func_7E20(var_0);
  if(var_1 == "rig_customization") {
    return 1;
  }

  return 0;
}

func_9FFC(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = func_7E20(var_0);
  if(isDefined(var_1)) {
    if(scripts\mp\utility::func_13C86(var_1)) {
      return 1;
    }
  }

  return 0;
}

challengesplasheseachtier(var_0) {
  return func_9FFC(var_0) || isweaponclasschallenge(var_0) || func_9F27(var_0) || isrigcustomizationchallenge(var_0);
}

givesmasterprogresseachtier(var_0) {
  return func_9FFC(var_0) || isweaponclasschallenge(var_0) || func_9F27(var_0) || isrigcustomizationchallenge(var_0);
}

isweaponclasschallenge(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = func_7E20(var_0);
  if(isDefined(var_1)) {
    switch (var_1) {
      case "weapon_all":
      case "weapon_projectile":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_lmg":
      case "weapon_assault":
      case "weapon_smg":
      case "weapon_pistol":
      case "weapon_melee":
        return 1;
    }
  }

  return 0;
}

func_8222(var_0) {
  return func_7E20(var_0);
}

getentitynumber(var_0) {
  return func_7E20(var_0);
}

func_3C27(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + var_2 * 3);
  return int(var_3);
}

func_3C20(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 11 + var_2 * 3);
  return int(var_3);
}

func_3C25(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 12 + var_2 * 3);
  return int(var_3);
}

func_3C18(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, var_1, 8);
  return scripts\engine\utility::ter_op(var_2 == "", undefined, int(var_2));
}

func_3C1C(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, var_1, 9);
  return scripts\engine\utility::ter_op(var_2 == "", undefined, int(var_2));
}

func_31D8(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  level.var_3C2D = [];
  var_2 = 0;
  for(;;) {
    var_4 = tablelookupbyrow(var_0, var_2, 0);
    if(var_4 == "") {
      break;
    }

    var_5 = func_7E21(var_4);
    level.var_3C2C[var_4] = [];
    level.var_3C2C[var_4]["index"] = var_2;
    level.var_3C2C[var_4]["type"] = var_1;
    level.var_3C2C[var_4]["targetval"] = [];
    level.var_3C2C[var_4]["reward"] = [];
    level.var_3C2C[var_4]["score"] = [];
    level.var_3C2C[var_4]["filter"] = func_7E20(var_4);
    level.var_3C2C[var_4]["master"] = var_5;
    for(var_6 = 0; var_6 < 8; var_6++) {
      var_7 = func_3C27(var_0, var_4, var_6);
      if(var_7 == 0) {
        break;
      }

      var_8 = func_3C20(var_0, var_4, var_6);
      var_9 = func_3C25(var_0, var_4, var_6);
      level.var_3C2C[var_4]["targetval"][var_6] = var_7;
      level.var_3C2C[var_4]["reward"][var_6] = var_8;
      level.var_3C2C[var_4]["score"][var_6] = var_9;
      var_3 = var_3 + var_8;
    }

    var_10 = func_3C18(var_0, var_4);
    level.var_3C2C[var_4]["displayParam"] = var_10;
    var_11 = func_3C1C(var_0, var_4);
    level.var_3C2C[var_4]["paramScale"] = var_11;
    if(isDefined(var_5)) {
      if(!isDefined(level.var_3C2D[var_5])) {
        level.var_3C2D[var_5] = [];
      }

      level.var_3C2D[var_5][level.var_3C2D[var_5].size] = var_4;
    }

    var_2++;
  }

  return int(var_3);
}

validatemasterchallenges() {
  level endon("game_ended");
  wait(1);
  foreach(var_6, var_1 in level.var_3C2D) {
    var_2 = 0;
    foreach(var_1 in var_1) {
      if(givesmasterprogresseachtier(var_1)) {
        var_2 = var_2 + level.var_3C2C[var_1]["targetval"].size;
        continue;
      }

      var_2 = var_2 + 1;
    }

    var_5 = level.var_3C2C[var_6]["targetval"][0];
  }
}

func_31D7() {
  level.var_3C2C = [];
  var_0 = 0;
  var_0 = var_0 + func_31D8("mp\allChallengesTable.csv", 0);
}

func_BA08() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    if(!func_B4E8()) {
      return;
    }

    self waittill("process", var_0);
    processchallenge(var_0);
  }
}

func_B9E9() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    self waittill("got_killstreak", var_0);
    if(!isDefined(var_0)) {
      continue;
    }

    if(var_0 == 10 && self.var_A6AB.size == 0) {
      processchallenge("ch_theloner");
      continue;
    }

    if(var_0 == 9) {
      if(isDefined(self.var_A6AB[7]) && isDefined(self.var_A6AB[8]) && isDefined(self.var_A6AB[9])) {
        processchallenge("ch_6fears7");
      }
    }
  }
}

func_B9E6() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    self waittill("destroyed_killstreak", var_0);
    if(self isitemunlocked("specialty_blindeye", "perk") && scripts\mp\utility::_hasperk("specialty_blindeye")) {
      processchallenge("ch_blindeye");
    }
  }
}

func_D39B() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2)) {
      if(!scripts\mp\weapons::isriotshield(var_2) && !scripts\mp\weapons::isknifeonly(var_2)) {
        return 1;
      }
    }

    var_3 = weaponaltweaponname(var_2);
    if(!isDefined(var_3) || var_3 == "none") {
      continue;
    }

    if(self getweaponammoclip(var_3)) {
      return 1;
    }
  }

  return 0;
}

monitoradstime() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_0 = scripts\mp\utility::func_9EE8();
  self.var_A932 = 0;
  for(;;) {
    if(scripts\mp\utility::func_9EE8()) {
      if(!var_0) {
        self.var_A932 = gettime();
        var_0 = 1;
      }
    } else {
      var_0 = 0;
    }

    wait(0.05);
  }
}

func_B9E0() {
  self endon("disconnect");
  self.var_9074 = 0;
  for(;;) {
    self waittill("hold_breath");
    self.var_9074 = 1;
    self waittill("release_breath");
    self.var_9074 = 0;
  }
}

func_B9F0() {
  self endon("disconnect");
  self.var_B315 = 0;
  for(;;) {
    self waittill("jumped");
    var_0 = self getcurrentweapon();
    scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 1);
    var_1 = self getcurrentweapon();
    if(var_1 == "none") {
      self.var_B315 = 1;
    } else {
      self.var_B315 = 0;
    }

    if(self.var_B315) {
      if(self isitemunlocked("specialty_fastmantle", "perk") && scripts\mp\utility::_hasperk("specialty_fastmantle")) {
        processchallenge("ch_fastmantle");
      }

      scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 1);
      var_1 = self getcurrentweapon();
      if(var_1 == var_0) {
        self.var_B315 = 0;
      }
    }
  }
}

func_BA3B() {
  self endon("disconnect");
  var_0 = self getcurrentweapon();
  for(;;) {
    self waittill("weapon_change", var_1);
    if(var_1 == "none") {
      continue;
    }

    if(var_1 == var_0) {
      continue;
    }

    if(scripts\mp\utility::iskillstreakweapon(var_1)) {
      continue;
    }

    if(var_1 == "briefcase_bomb_mp" || var_1 == "briefcase_bomb_defuse_mp") {
      continue;
    }

    var_2 = weaponinventorytype(var_1);
    if(var_2 != "primary") {
      continue;
    }

    self.var_A9D3 = gettime();
  }
}

func_B9DA() {
  self endon("disconnect");
  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);
    if(self == var_3) {
      continue;
    }

    self.var_A98A = gettime();
  }
}

func_B9F4() {
  self endon("disconnect");
  for(;;) {
    self waittill("triggeredExpl", var_0);
    thread func_136A2();
  }
}

func_136A2() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(level.delayminetime + 2);
  processchallenge("ch_delaymine");
}

func_10061(var_0) {
  return self isitemunlocked(var_0, "perk") && scripts\mp\utility::_hasperk(var_0);
}

func_D9BF(var_0, var_1) {
  processchallenge("ch_" + var_1);
}

processfinalkillchallenges(var_0, var_1) {
  if(!func_B4E8() || isai(var_0)) {
    return;
  }

  var_0 processchallenge("ch_theedge");
  if(!isai(var_1)) {
    var_1 processchallenge("ch_starryeyed");
  }

  if(isDefined(var_0) && isDefined(var_0.modifiers) && isDefined(var_0.modifiers["revenge"])) {
    var_0 processchallenge("ch_moneyshot");
  }

  if(isDefined(var_1) && isDefined(var_1.explosiveinfo) && isDefined(var_1.explosiveinfo["stickKill"]) && var_1.explosiveinfo["stickKill"]) {
    var_0 processchallenge("ch_stickman");
  }

  if(isDefined(var_1.attackerdata[var_0.guid]) && isDefined(var_1.attackerdata[var_0.guid].smeansofdeath) && isDefined(var_1.attackerdata[var_0.guid].weapon) && issubstr(var_1.attackerdata[var_0.guid].smeansofdeath, "MOD_MELEE") && scripts\mp\weapons::isriotshield(var_1.attackerdata[var_0.guid].weapon)) {
    var_0 processchallenge("ch_owned");
  }

  var_2 = var_0.team;
  if(!level.teambased) {
    var_2 = "none";
  }

  var_0 func_D991("ch_final_killcam");
}

func_D9C3(var_0, var_1, var_2) {
  if(scripts\mp\utility::func_9EE8()) {
    func_D991("ch_" + var_1 + "_kills");
    if(isDefined(var_2.modifiers["headshot"])) {
      func_D991("ch_" + var_1 + "_headshots");
    }

    if(isDefined(var_2.modifiers["longshot"])) {
      func_D991("ch_" + var_1 + "_longshots");
    }

    if(var_2.var_2504 % 2 == 0) {
      func_D991("ch_" + var_1 + "_double_kills");
    }
  }

  if(var_2.var_24E4 > 0 && var_2.var_24E4 % 3 == 0) {
    func_D991("ch_" + var_1 + "_streak");
  }
}

func_D9C9(var_0, var_1) {
  func_D991("ch_lifetime_ar_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "headshot", var_0);
  func_3DF9(var_1, "longshot", var_0);
  func_3E59(var_0, var_1.sweapon);
  func_3DEF(var_0, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

func_D9D1(var_0, var_1) {
  func_D991("ch_lifetime_smg_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "hipfire", var_0);
  func_3DF9(var_1, "pointblank", var_0);
  func_3DF9(var_1, "sliding", var_0);
  func_3DEF(var_0, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

func_D9CB(var_0, var_1) {
  func_D991("ch_lifetime_lmg_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "headshot", var_0);
  if(isDefined(var_1.modifiers["hipfire"])) {
    func_D991("ch_" + var_0 + "_penetrate");
  }

  func_3E25(var_1, var_0, var_1.sweapon);
  func_3DEF(var_0, var_1.sweapon, 6);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

func_D9CA(var_0, var_1) {
  func_D991("ch_" + var_0);
  if(var_1.var_250B == "crouch") {
    processchallenge("ch_" + var_0 + "_crouch");
  }

  func_3DFA(var_1, "defender", var_0);
  func_3DFA(var_1, "longshot", var_0);
  func_3DFA(var_1, "headshot", var_0);
  func_3DFA(var_1, "pointblank", var_0);
  func_3DF8(var_0);
}

func_D9D2(var_0, var_1) {
  func_D991("ch_lifetime_sniper_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "headshot", var_0);
  func_3DF9(var_1, "longshot", var_0);
  if(var_1.var_24EB) {
    func_D991("ch_" + var_0 + "_holdbreath");
  }

  func_3DEF(var_0, var_1.sweapon, 6);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
  if(scripts\mp\utility::istrue(var_1.modifiers["pointblank"])) {
    func_D991("ch_point_blank_sniper");
  }
}

func_D9D0(var_0, var_1) {
  func_D991("ch_lifetime_shotgun_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "hipfire", var_0);
  func_3DF9(var_1, "pointblank", var_0);
  func_3DF9(var_1, "sliding", var_0);
  func_3DEF(var_0, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

func_D9CF(var_0, var_1) {
  func_D991("ch_" + var_0);
}

func_D9CD(var_0, var_1) {
  func_D991("ch_lifetime_pistol_kills");
  func_D991("ch_" + var_0);
  func_3DF9(var_1, "headshot", var_0);
  func_3DF9(var_1, "pointblank", var_0);
  if(!func_3E17(var_1)) {
    func_D991("ch_" + var_0 + "_pistol_only");
  }

  func_3DEF(var_0, var_1.sweapon, 5);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
  var_2 = scripts\mp\utility::getweaponrootname(var_1.sweapon);
  if(var_2 == "iw7_mag" && isDefined(var_1.modifiers["hipfire"])) {
    if(!isDefined(self.hipfiremagkills)) {
      self.hipfiremagkills = 1;
      return;
    }

    self.hipfiremagkills++;
  }
}

func_D9CE(var_0, var_1) {
  switch (var_0) {
    case "iw7_glprox":
      func_D9C6(var_0, var_1);
      break;

    case "iw7_chargeshot":
      func_D9C5(var_0, var_1);
      break;

    case "iw7_lockon":
      func_D9C7(var_0, var_1);
      break;

    case "iw7_venomx":
      processweaponchallenge_venomx(var_0, var_1);
      break;
  }
}

func_D9C6(var_0, var_1) {
  func_D991("ch_iw7_glprox");
  if(var_1.smeansofdeath == "MOD_IMPACT" || var_1.smeansofdeath == "MOD_GRENADE") {
    func_D991("ch_iw7_glprox_direct");
  }

  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  if(!func_3E17(var_1)) {
    func_D991("ch_iw7_glprox_no_primary");
  }

  if(isDefined(var_1.victim)) {
    if(distancesquared(var_1.victim.origin, self.origin) > 1440000) {
      func_D991("ch_iw7_glprox_long_range");
    }
  }

  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

func_D9D6(var_0, var_1, var_2) {
  func_D991("ch_iw7_glprox_kill_streak");
}

processweaponchallenge_venomx(var_0, var_1) {
  func_D991("ch_iw7_venomx");
  if(var_1.smeansofdeath == "MOD_IMPACT" || var_1.smeansofdeath == "MOD_GRENADE") {
    func_D991("ch_iw7_venomx_direct");
  }

  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  if(!func_3E17(var_1)) {
    func_D991("ch_iw7_venomx_no_primary");
  }

  if(isDefined(var_1.victim)) {
    if(distancesquared(var_1.victim.origin, self.origin) > 1440000) {
      func_D991("ch_iw7_venomx_long_range");
    }
  }

  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

processweaponkilledkillstreak_venomx(var_0, var_1, var_2) {
  func_D991("ch_iw7_venomx_kill_streak");
}

func_D9C5(var_0, var_1) {
  func_D991("ch_iw7_chargeshot_kill");
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3E4D(var_0);
}

func_D9D5(var_0, var_1, var_2) {
  func_D991("ch_iw7_chargeshot");
  func_D991("ch_iw7_chargeshot_kill_streak_points", scripts\mp\killstreaks\killstreaks::getstreakcost(var_1));
  if(isDefined(self.var_A9A8) && gettime() - self.var_A9A8 < 10000) {
    func_D991("ch_iw7_chargeshot_streak_double");
  }

  if(isDefined(self.var_A6B3) && isDefined(self.var_A6B3[var_0]) && func_9EBC(self.var_A6B3[var_0], 3)) {
    func_D991("ch_iw7_chargeshot_kill_3_streaks");
  }

  func_3E4D(var_0);
}

func_D9C7(var_0, var_1) {
  func_D991("ch_iw7_lockon_kill");
  func_3E4D(var_0);
}

func_D9D7(var_0, var_1, var_2) {
  func_D991("ch_iw7_lockon");
  func_D991("ch_iw7_lockon_kill_streak_points", scripts\mp\killstreaks\killstreaks::getstreakcost(var_1));
  var_3 = undefined;
  var_4 = 0;
  foreach(var_6 in self.var_AF2C) {
    if(isDefined(var_6)) {
      var_7 = distancesquared(var_6.origin, var_2.origin);
      if(!isDefined(var_3) || var_4 > var_7) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(isDefined(var_3) && !isDefined(var_3.var_C83D)) {
    func_D991("ch_iw7_lockon_no_lock_on");
  }

  if(isDefined(self.var_A9A8) && gettime() - self.var_A9A8 < 10000) {
    func_D991("ch_iw7_lockon_streak_double");
  }

  if(isDefined(self.var_A6B3) && isDefined(self.var_A6B3[var_0]) && func_9EBC(self.var_A6B3[var_0], 3)) {
    func_D991("ch_iw7_lockon_kill_3_streaks");
  }

  func_3E4D(var_0);
}

func_D9CC(var_0, var_1) {
  func_D991("ch_" + var_0);
  if(isDefined(var_1.modifiers["backstab"])) {
    func_D991("ch_" + var_0 + "_backstab");
  } else {
    func_D991("ch_" + var_0 + "_frontstab");
  }

  if(!func_3E17(var_1)) {
    func_D991("ch_" + var_0 + "_melee_only");
  }

  func_3DF9(var_1, "sliding", var_0);
  func_3E2B(var_1.sweapon, var_1, var_0, 2);
  func_3DFE(var_1.sweapon, var_1, var_0, 3);
}

processweaponchallenge_axemelee(var_0, var_1) {
  var_2 = "alt_" + var_1.sweapon;
  func_D991("ch_iw7_axe");
  if(isDefined(var_1.modifiers["backstab"])) {
    func_D991("ch_" + var_0 + "_backstab");
  }

  checkaxecombochallenge(var_1, var_1.sweapon, var_2);
  checkaxemultikillchallenge(var_1, var_1.sweapon, var_2);
  checkaxeconsecutivechallenge(var_1, var_1.sweapon, var_2);
}

processweaponchallenge_axethrow(var_0, var_1) {
  var_2 = scripts\mp\utility::func_E0CF(var_1.sweapon);
  func_D991("ch_iw7_axe_frontstab");
  if(isDefined(var_1.modifiers["backstab"])) {
    func_D991("ch_" + var_0 + "_backstab");
  }

  var_3 = var_1.var_24F3[var_1.sweapon];
  if(isDefined(var_3) && func_9EBC(var_3, 2)) {
    func_D991("ch_iw7_axe_melee_only");
  }

  checkaxecombochallenge(var_1, var_2, var_1.sweapon);
  checkaxemultikillchallenge(var_1, var_2, var_1.sweapon);
  checkaxeconsecutivechallenge(var_1, var_2, var_1.sweapon);
}

checkaxecombochallenge(var_0, var_1, var_2) {
  var_3 = var_0.var_24F3[var_1];
  var_4 = var_0.var_24F3[var_2];
  if(var_0.sweapon == var_1) {
    var_5 = isDefined(var_3) && var_3 == 1;
    var_6 = isDefined(var_4) && var_4 > 0;
    if(var_5 && var_6) {
      func_D991("ch_iw7_axe_sliding");
      return;
    }

    return;
  }

  if(var_0.sweapon == var_2) {
    var_7 = isDefined(var_4) && var_4 == 1;
    var_8 = isDefined(var_3) && var_3 > 0;
    if(var_7 && var_8) {
      func_D991("ch_iw7_axe_sliding");
      return;
    }

    return;
  }
}

checkaxemultikillchallenge(var_0, var_1, var_2) {
  var_3 = 0;
  if(isDefined(var_0.var_2505[var_1])) {
    var_3 = var_3 + var_0.var_2505[var_1];
  }

  if(isDefined(var_0.var_2505[var_2])) {
    var_3 = var_3 + var_0.var_2505[var_2];
  }

  if(isDefined(var_3) && func_9EBC(var_3, 2)) {
    func_D991("ch_iw7_axe_2multikill");
  }
}

checkaxeconsecutivechallenge(var_0, var_1, var_2) {
  var_3 = 0;
  if(isDefined(var_0.var_24F3[var_1])) {
    var_3 = var_3 + var_0.var_24F3[var_1];
  }

  if(isDefined(var_0.var_24F3[var_2])) {
    var_3 = var_3 + var_0.var_24F3[var_2];
  }

  if(isDefined(var_3) && func_9EBC(var_3, 3)) {
    func_D991("ch_iw7_axe_3streak");
  }
}

func_3DF9(var_0, var_1, var_2) {
  if(isDefined(var_0.modifiers[var_1])) {
    func_D991("ch_" + var_2 + "_" + var_1);
  }
}

func_3DFA(var_0, var_1, var_2) {
  if(isDefined(var_0.modifiers[var_1])) {
    processchallenge("ch_" + var_2 + "_" + var_1);
  }
}

func_3DF8(var_0) {
  if(self func_81AA()) {
    processchallenge("ch_" + var_0 + "_leaning");
  }
}

func_3E32(var_0, var_1) {
  if(var_0.var_92BE &level.idflags_penetration) {
    processchallenge("ch_" + var_1 + "_penetrate");
  }
}

func_3E31(var_0, var_1) {
  if(var_0.var_92BE &level.idflags_penetration) {
    func_D991("ch_" + var_1 + "_penetrate");
  }
}

func_3DFE(var_0, var_1, var_2, var_3) {
  var_4 = var_1.var_24F3[var_0];
  if(isDefined(var_4) && func_9EBC(var_4, var_3)) {
    func_D991("ch_" + var_2 + "_" + var_3 + "streak");
  }
}

func_3E5F() {
  var_0 = self getcurrentweapon();
  if(scripts\mp\weapons::isriotshield(var_0)) {
    return 1;
  }

  var_1 = scripts\engine\utility::getlastweapon();
  return scripts\mp\weapons::isriotshield(var_1);
}

func_3DE3(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    if(isDefined(level.var_C321) && isDefined(level.var_C321["odin_assault"]) && var_2 == level.var_C321["odin_assault"].weapon["large_rod"].projectile || var_2 == level.var_C321["odin_assault"].weapon["small_rod"].projectile) {
      var_0 processchallenge("ch_shooting_star");
      return 1;
    } else if(var_2 == "aamissile_projectile_mp") {
      var_0 processchallenge("ch_air_superiority");
    }
  }

  var_0 processchallenge("ch_clearskies");
  return 0;
}

func_3DFF(var_0, var_1) {
  if(!isai(var_0)) {
    var_2 = var_0 scripts\mp\teams::getplayermodelindex();
    var_3 = var_0 scripts\mp\teams::getplayermodelname(var_2);
    return var_3 == var_1;
  }

  return 0;
}

func_3E59(var_0, var_1) {
  if(scripts\mp\utility::istrue(self.modifiers["ads"])) {
    var_2 = getweaponattachments(var_1);
    foreach(var_4 in var_2) {
      var_5 = scripts\mp\weapons::func_248C(var_4);
      if(var_5 == "rail") {
        var_6 = scripts\mp\utility::attachmentmap_tobase(var_4);
        if(scripts\mp\weapons::func_9F3C(var_0, var_6)) {
          func_D991("ch_" + var_0 + "_optic");
          break;
        }
      }
    }
  }
}

func_3E2B(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1.var_2505[var_0])) {
    var_4 = var_1.var_2505[var_0];
    if(isDefined(var_4) && func_9EBC(var_4, var_3)) {
      func_D991("ch_" + var_2 + "_" + var_3 + "multikill");
    }
  }
}

func_3DEF(var_0, var_1, var_2) {
  var_3 = 0;
  foreach(var_5 in getweaponattachments(var_1)) {
    var_6 = scripts\mp\utility::attachmentmap_tobase(var_5);
    if(scripts\mp\weapons::func_9F3C(var_0, var_6)) {
      var_3++;
    }
  }

  if(var_3 == var_2) {
    func_D991("ch_" + var_0 + "_" + var_2 + "attachments");
  }
}

func_3E25(var_0, var_1, var_2) {
  if(!isDefined(var_0.var_24E3)) {
    return;
  }

  var_3 = var_0.var_24E3;
  var_4 = weaponclipsize(var_2);
  if(var_3 <= var_4 * 0.15) {
    func_D991("ch_" + var_1 + "_lastshots");
  }
}

func_3E17(var_0) {
  if(isDefined(var_0.var_24EE)) {
    foreach(var_2 in var_0.var_24EE) {
      if(scripts\mp\utility::iscacprimaryweapon(var_2)) {
        return 1;
      }
    }
  }

  return 0;
}

func_3E4D(var_0) {
  if(isDefined(self.killsthislife) && isDefined(self.var_A6B4)) {
    if(self.killsthislife.size > 0 && self.var_A6B4.size > 0 && !scripts\mp\utility::istrue(self.var_110E6[var_0])) {
      func_D991("ch_" + var_0 + "_combo");
      self.var_110E6[var_0] = 1;
    }
  }
}

func_D994(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      var_3 processchallenge(var_0);
    }
  }
}

func_9D84(var_0) {
  var_1 = level.var_3C2C[var_0]["filter"];
  if(!isDefined(var_1)) {
    return 1;
  }

  return self isitemunlocked(var_1, "challenge") && self isitemunlocked(var_0, "challenge");
}

func_8C49(var_0) {
  return isDefined(level.var_3C2C) && isDefined(level.var_3C2C[var_0]);
}

allowinteractivecombat(var_0, var_1) {
  return 0;
}

func_3E2D(var_0, var_1) {
  var_2 = self.pers[var_0];
  return func_9EBC(var_2, var_1);
}

func_9EBC(var_0, var_1) {
  return var_0 > 0 && var_0 % var_1 == 0;
}

func_8C0E() {
  if(isDefined(self.pers["loadoutPerks"])) {
    return self.pers["loadoutPerks"].size == 0;
  }

  return 1;
}

func_9D83(var_0) {
  if(!func_D3D6()) {
    return 0;
  }

  if(func_2139(var_0)) {
    return 0;
  }

  return 1;
}

func_2139(var_0) {
  if(self.var_3C2A[var_0] >= level.var_3C2C[var_0]["targetval"].size) {
    return 1;
  }

  return 0;
}

func_D9B8() {
  if(scripts\mp\utility::istrue(self.var_110E5)) {
    return;
  }

  func_D991("ch_streak_player_kill");
  self.var_110E5 = 1;
}

func_9E8A(var_0) {
  switch (var_0) {
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 1;
  }

  return 0;
}

func_D3A8(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  var_2 = scripts\engine\utility::ter_op(isplayer(var_1), var_1, var_1.owner);
  if(!isDefined(var_2) || !isplayer(var_2)) {
    return;
  }

  if(isDefined(var_0.debuffedbyplayers) && isDefined(var_0.debuffedbyplayers["cryo_mine_mp"]) && var_0.debuffedbyplayers["cryo_mine_mp"].size > 0) {
    var_2 func_D991("ch_plasma_cryo_combo");
  }
}

minedestroyed(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !isplayer(var_1)) {
    return;
  }

  if(isDefined(var_0.weapon_name) && var_0.weapon_name == "c4_mp") {
    if(var_0.owner != var_1 && !scripts\mp\utility::istrue(var_0.planted) && scripts\engine\utility::isbulletdamage(var_2)) {
      var_1 func_D991("ch_c4_air_kill");
    }
  }
}

func_2AEA(var_0, var_1, var_2) {
  if(var_0.disttravelled >= 1300) {
    var_1 func_D991("ch_biospike_longrange");
  }
}

func_BA0B() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.var_A686 = 0;
  for(;;) {
    self waittill("reload");
    self.var_A9DD = gettime();
    self.var_A686 = 0;
  }
}

func_C5A8(var_0) {
  if(!func_B4E8()) {
    return;
  }

  if(isDefined(self.consecutivehitsperweapon) && isDefined(self.consecutivehitsperweapon[var_0])) {
    if(func_9EBC(self.consecutivehitsperweapon[var_0], 5) && scripts\mp\utility::weaponhasattachment(var_0, "grip")) {
      func_D991("ch_grip_accuracy");
    }
  }
}

func_BA29() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("super_earned");
    if(!scripts\mp\utility::gameflag("prematch_done")) {
      continue;
    }

    if(func_66B8("specialty_overclock")) {
      func_D991("ch_perk_overclock");
      if(self.pers["supersEarned"] % 5 == 0) {
        func_D991("ch_overclock_unlocked");
      }
    }
  }
}

func_66B8(var_0) {
  if(!scripts\mp\utility::_hasperk(var_0) || !scripts\mp\perks\perks::func_9EDF(var_0)) {
    return 0;
  }

  return 1;
}

resistedstun(var_0) {
  if(!isDefined(var_0) || !isplayer(var_0)) {
    return;
  }

  self.var_1119A[var_0.guid] = 1;
}

func_B9D4() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("destroyed_equipment");
    func_D991("ch_destroy_items");
    if(func_66B8("specialty_engineer")) {
      func_D991("ch_perk_kills_engineer");
    }
  }
}

func_127BC() {
  func_D991("ch_engineer_explosion_delay");
}

func_B9CE() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("earned_award_buffered", var_0);
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    switch (var_0) {
      case "mode_ctf_kill_with_flag":
      case "mode_uplink_kill_with_ball":
      case "mode_sd_defuse_save":
      case "mode_x_assault":
        var_1 = 1;
        break;

      case "mode_sd_plant_save":
      case "mode_x_defend":
        var_2 = 1;
        break;

      case "mode_ctf_kill_carrier":
      case "mode_uplink_kill_carrier":
        var_2 = 1;
        var_4 = 1;
        break;

      case "mode_siege_secure":
      case "mode_ctf_cap":
      case "mode_uplink_fieldgoal":
      case "mode_uplink_dunk":
      case "mode_hp_secure":
      case "mode_dom_secure":
      case "mode_dom_secure_neutral":
      case "mode_dom_secure_b":
      case "mode_sd_detonate":
        var_3 = 1;
        break;

      case "mode_sd_defuse":
      case "mode_sd_last_defuse":
        var_3 = 1;
        var_5 = 1;
        break;
    }

    if(var_1) {
      func_D991("ch_kill_defenders");
    }

    if(var_2) {
      func_D991("ch_kill_attackers");
    }

    if(var_3) {
      func_D991("ch_objectives");
    }

    if(var_5) {
      func_D991("ch_defuse");
    }

    if(var_4) {
      func_D991("ch_kill_carrier");
    }
  }
}