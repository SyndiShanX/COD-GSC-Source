/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_misions.gsc
******************************************/

init() {
  precachestring(&"MP_CHALLENGE_COMPLETED");

  if(!mayprocesschallenges()) {
    return;
  }
  level.missioncallbacks = [];
  registermissioncallback("playerKilled", ::ch_kills);
  registermissioncallback("playerKilled", ::ch_vehicle_kills);
  registermissioncallback("playerHardpoint", ::ch_hardpoints);
  registermissioncallback("playerAssist", ::ch_assists);
  registermissioncallback("roundEnd", ::ch_roundwin);
  registermissioncallback("roundEnd", ::ch_roundplayed);
  registermissioncallback("vehicleKilled", ::ch_vehicle_killed);
  level thread onplayerconnect();
}

mayprocesschallenges() {
  return level.rankedmatch;
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);

    if(isbot(var_0)) {
      continue;
    }
    if(!isdefined(var_0.pers["postGameChallenges"]))
      var_0.pers["postGameChallenges"] = 0;

    var_0 thread onplayerspawned();
    var_0 thread initmissiondata();
    var_0 thread monitorbombuse();
    var_0 thread monitorfalldistance();
    var_0 thread monitorlivetime();
    var_0 thread monitorstreaks();
    var_0 thread monitorscavengerpickup();
    var_0 thread monitorprocesschallenge();
    var_0 thread monitorkillstreakprogress();
    var_0 thread monitoradstime();
    var_0 thread monitorpronetime();
    var_0 thread monitorweaponswap();
    var_0 thread monitorflashbang();
    var_0 thread monitorconcussion();
    var_0 notifyonplayercommand("hold_breath", "+breath_sprint");
    var_0 notifyonplayercommand("hold_breath", "+melee_breath");
    var_0 notifyonplayercommand("release_breath", "-breath_sprint");
    var_0 notifyonplayercommand("release_breath", "-melee_breath");
    var_0 thread monitorholdbreath();
    var_0 notifyonplayercommand("jumped", "+goStand");
    var_0 thread monitormantle();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    self waittill("spawned_player");
    thread onplayerdeath();
    thread monitorsprintdistance();
  }
}

onplayerdeath() {
  self endon("disconnect");
  self waittill("death");

  if(isdefined(self.hasscavengedammothislife))
    self.hasscavengedammothislife = 0;
}

monitorscavengerpickup() {
  self endon("disconnect");

  for (;;) {
    self waittill("scavenger_pickup");

    if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::_hasperk("specialty_scavenger") && !maps\mp\_utility::isjuggernaut())
      self.hasscavengedammothislife = 1;

    wait 0.05;
  }
}

initmissiondata() {
  var_0 = getarraykeys(level.killstreakfuncs);

  foreach(var_2 in var_0)
  self.pers[var_2] = 0;

  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermissioncallback(var_0, var_1) {
  if(!isdefined(level.missioncallbacks[var_0]))
    level.missioncallbacks[var_0] = [];

  level.missioncallbacks[var_0][level.missioncallbacks[var_0].size] = var_1;
}

getchallengestatus(var_0) {
  if(isdefined(self.challengedata[var_0]))
    return self.challengedata[var_0];
  else
    return 0;
}

ch_assists(var_0) {
  var_1 = var_0.player;
  var_1 processchallenge("ch_assists");
}

ch_streak_kill(var_0) {}

ch_hardpoints(var_0) {
  if(isbot(var_0.player)) {
    return;
  }
  var_1 = var_0.player;
  var_1.pers[var_0.hardpointtype]++;

  switch (var_0.hardpointtype) {
    case "radar_mp":
      var_1 processchallenge("ch_uav");
      var_1 processchallenge("ch_exposed");

      if(var_1.pers[var_0.hardpointtype] >= 3)
        var_1 processchallenge("ch_nosecrets");

      if(maps\mp\_utility::getmapname() == "mp_farm_spring")
        var_1 processchallenge("ch_stpatty_uav");

      if(maps\mp\_utility::getmapname() == "mp_bog_summer")
        var_1 processchallenge("ch_summer_uav");

      break;
    case "airstrike_mp":
      var_1 processchallenge("ch_airstrike");

      if(var_1.pers[var_0.hardpointtype] >= 2)
        var_1 processchallenge("ch_afterburner");

      break;
    case "helicopter_mp":
      var_1 processchallenge("ch_chopper");

      if(var_1.pers[var_0.hardpointtype] >= 2) {
        var_1 processchallenge("ch_airsuperiority");

        if(maps\mp\_utility::getmapname() == "mp_bog_summer")
          var_1 processchallenge("ch_summer_ranger");
      }

      break;
  }
}

ch_vehicle_kills(var_0) {
  if(!isdefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  if(!maps\mp\_utility::iskillstreakweapon(var_0.sweapon)) {
    return;
  }
  var_1 = var_0.attacker;

  if(isdefined(var_0.einflictor) && isdefined(level.chopper) && var_0.einflictor == level.chopper)
    var_1 processchallenge("ch_choppervet");

  if(!isdefined(var_1.pers[var_0.sweapon + "_streak"]) || isdefined(var_1.pers[var_0.sweapon + "_streakTime"]) && gettime() - var_1.pers[var_0.sweapon + "_streakTime"] > 7000) {
    var_1.pers[var_0.sweapon + "_streak"] = 0;
    var_1.pers[var_0.sweapon + "_streakTime"] = gettime();
  }

  var_1.pers[var_0.sweapon + "_streak"]++;

  switch (var_0.sweapon) {
    case "artillery_mp":
      var_1 processchallenge("ch_airstrikevet");

      if(var_1.pers[var_0.sweapon + "_streak"] == 5)
        var_1 processchallenge("ch_carpetbomb");

      break;
    default:
      break;
  }
}

ch_vehicle_killed(var_0) {
  if(!isdefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  var_1 = var_0.attacker;
  var_2 = maps\mp\_utility::getbaseweaponname(var_0.sweapon);

  if(maps\mp\_utility::islootweapon(var_2))
    var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);

  var_3 = get_challenge_weapon_class(var_0.sweapon, var_2);

  if(var_3 == "weapon_launcher")
    var_1 processchallenge("ch_launcher_kill");
}

clearidshortly(var_0) {
  self endon("disconnect");
  self notify("clearing_expID_" + var_0);
  self endon("clearing_expID_" + var_0);
  wait 3.0;
  self.explosivekills[var_0] = undefined;
}

mgkill() {
  var_0 = self;

  if(!isdefined(var_0.pers["MGStreak"])) {
    var_0.pers["MGStreak"] = 0;
    var_0 thread endmgstreakwhenleavemg();

    if(!isdefined(var_0.pers["MGStreak"]))
      return;
  }

  var_0.pers["MGStreak"]++;

  if(var_0.pers["MGStreak"] >= 5)
    var_0 processchallenge("ch_mgmaster");
}

endmgstreakwhenleavemg() {
  self endon("disconnect");

  for (;;) {
    if(!isalive(self) || self usebuttonpressed()) {
      self.pers["MGStreak"] = undefined;
      break;
    }

    wait 0.05;
  }
}

endmgstreak() {
  self.pers["MGStreak"] = undefined;
}

killedbestenemyplayer(var_0) {
  if(!isdefined(self.pers["countermvp_streak"]) || !var_0)
    self.pers["countermvp_streak"] = 0;

  self.pers["countermvp_streak"]++;

  if(self.pers["countermvp_streak"] >= 10) {
    self.pers["countermvp_streak"] = 0;
    processchallenge("ch_countermvp");
  }
}

ishighestscoringplayer(var_0) {
  if(!isdefined(var_0.score) || var_0.score < 1)
    return 0;

  var_1 = level.players;

  if(level.teambased)
    var_2 = var_0.pers["team"];
  else
    var_2 = "all";

  var_3 = var_0.score;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isdefined(var_1[var_4].score)) {
      continue;
    }
    if(var_1[var_4].score < 1) {
      continue;
    }
    if(var_2 != "all" && var_1[var_4].pers["team"] != var_2) {
      continue;
    }
    if(var_1[var_4].score > var_3)
      return 0;
  }

  return 1;
}

ch_kills(var_0) {
  var_0.victim playerdied();

  if(!isdefined(var_0.attacker) || !isplayer(var_0.attacker))
    return;
  else
    var_1 = var_0.attacker;

  if(isbot(var_1)) {
    return;
  }
  var_2 = 0;
  var_3 = 0;
  var_4 = 1;
  var_5[var_0.victim.name] = var_0.victim.name;
  var_6[var_0.sweapon] = var_0.sweapon;
  var_7 = 1;
  var_8 = [];
  var_9 = var_0.smeansofdeath;
  var_10 = var_0.time;
  var_11 = 0;

  if(isdefined(var_1.pickedupweaponfrom[var_0.sweapon]) && !maps\mp\_utility::ismeleemod(var_9))
    var_11++;

  var_12 = maps\mp\_utility::iskillstreakweapon(var_0.sweapon);
  var_13 = maps\mp\_utility::isenvironmentweapon(var_0.sweapon);
  var_14 = 0;

  if(var_9 == "MOD_HEAD_SHOT")
    var_14 = 1;

  var_15 = 0;
  var_16 = 0;

  if(isdefined(var_0.modifiers["longshot"])) {
    var_15 = 1;
    var_16++;
  }

  var_17 = var_0.was_ads;
  var_18 = 0;

  if(var_1.recentkillcount == 2)
    var_18 = 1;

  var_19 = 0;

  if(var_1.recentkillcount == 3)
    var_19 = 1;

  var_20 = "";

  if(isdefined(var_0.attackerstance))
    var_20 = var_0.attackerstance;

  var_21 = 0;
  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;

  switch (var_1.killsthislife.size + 1) {
    case 5:
      var_21 = 1;
      break;
    case 10:
      var_22 = 1;
      break;
    case 15:
      var_23 = 1;
      break;
    case 20:
      var_24 = 1;
      break;
    case 25:
      var_25 = 1;
      break;
    case 30:
      var_26 = 1;
      break;
    default:
      break;
  }

  foreach(var_28 in var_1.killsthislife) {
    if(maps\mp\_utility::iscacsecondaryweapon(var_28.sweapon) && !maps\mp\_utility::ismeleemod(var_28.smeansofdeath))
      var_3++;

    if(isdefined(var_28.modifiers["longshot"]))
      var_16++;

    if(!isdefined(var_1.farsightchallengecounter))
      var_1.farsightchallengecounter = 0;

    if(!isdefined(var_1.humiliationfinderscounter))
      var_1.humiliationfinderscounter = [];

    if(var_16 == var_1.farsightchallengecounter * 3 + 3 && var_15) {
      var_1.farsightchallengecounter++;
      var_1 processchallenge("ch_precision_farsight");

      if(maps\mp\_utility::getmapname() == "mp_bog_summer")
        var_1 processchallenge("ch_summer_precision_farsight");
    }

    if(var_10 - var_28.time < 10000)
      var_4++;

    if(isdefined(var_1.pickedupweaponfrom[var_28.sweapon]) && !maps\mp\_utility::ismeleemod(var_28.smeansofdeath)) {
      if(!isdefined(var_1.humiliationfinderscounter[var_28.sweapon]))
        var_1.humiliationfinderscounter[var_28.sweapon] = 0;

      var_11++;

      if(var_11 == var_1.humiliationfinderscounter[var_28.sweapon] * 5 + 5) {
        var_1.humiliationfinderscounter[var_28.sweapon]++;
        var_1 processchallenge("ch_humiliation_finders");
      }
    }

    if(maps\mp\_utility::iskillstreakweapon(var_28.sweapon)) {
      if(!isdefined(var_8[var_28.sweapon]))
        var_8[var_28.sweapon] = 0;

      var_8[var_28.sweapon]++;
      continue;
    }

    if(isdefined(level.onelefttime[var_1.team]) && var_28.time > level.onelefttime[var_1.team])
      var_2++;

    if(isdefined(var_28.victim)) {
      if(!isdefined(var_5[var_28.victim.name]) && !isdefined(var_6[var_28.sweapon]) && !maps\mp\_utility::iskillstreakweapon(var_28.sweapon))
        var_7++;

      var_5[var_28.victim.name] = var_28.victim.name;
    }

    var_6[var_28.sweapon] = var_28.sweapon;
  }

  var_30 = maps\mp\_utility::getbaseweaponname(var_0.sweapon);

  if(maps\mp\_utility::islootweapon(var_30))
    var_30 = maps\mp\gametypes\_class::getbasefromlootversion(var_30);

  var_31 = var_30;

  if(common_scripts\utility::string_starts_with(var_30, "iw5_"))
    var_31 = getsubstr(var_30, 4);
  else if(common_scripts\utility::string_starts_with(var_30, "h1_"))
    var_31 = getsubstr(var_30, 3);

  var_32 = get_challenge_weapon_class(var_0.sweapon, var_30);

  if(level.teambased) {
    if(level.teamcount[var_0.victim.pers["team"]] > 3 && var_1.pers["killed_players"].size >= level.teamcount[var_0.victim.pers["team"]] && !maps\mp\_utility::is_true(var_1.tangodowncomplete)) {
      var_1.tangodowncomplete = 1;
      var_1 processchallenge("ch_tangodown");
    }

    if(level.teamcount[var_0.victim.pers["team"]] > 3 && var_1.killedplayerscurrent.size >= level.teamcount[var_0.victim.pers["team"]]) {
      var_1.killedplayerscurrent = [];
      var_1 processchallenge("ch_extremecruelty");
    }
  }

  if(isdefined(var_1.finalkill))
    var_1 processchallenge("ch_theedge");

  if(var_1.pers["cur_kill_streak"] == 10) {
    var_1 processchallenge("ch_fearless");

    if(maps\mp\_utility::getmapname() == "mp_bog_summer")
      var_1 processchallenge("ch_summer_fearless");
  }

  if(var_0.victim.score > 0) {
    if(level.teambased) {
      var_33 = var_0.victim.pers["team"];

      if(isdefined(var_33) && var_33 != var_1.pers["team"]) {
        if(ishighestscoringplayer(var_0.victim) && level.players.size >= 6)
          var_1 killedbestenemyplayer(1);
        else
          var_1 killedbestenemyplayer(0);
      }
    } else if(ishighestscoringplayer(var_0.victim) && level.players.size >= 4)
      var_1 killedbestenemyplayer(1);
    else
      var_1 killedbestenemyplayer(0);
  }

  var_34 = maps\mp\_utility::getmapname();

  if(var_34 == "mp_crash_snow")
    var_1 processchallenge("ch_wc_kills");
  else if(var_34 == "mp_farm_spring")
    var_1 processchallenge("ch_stpatty_kills");
  else if(var_34 == "mp_bog_summer")
    var_1 processchallenge("ch_summer_kills");

  if(isdefined(var_1.pickedupweaponfrom[var_0.sweapon])) {
    if(!maps\mp\_utility::ismeleemod(var_9))
      var_1 processchallenge("ch_kills_stolen");
  }

  if(var_20 == "crouch")
    var_1 processchallenge("ch_kills_crouch");

  if(var_20 == "prone")
    var_1 processchallenge("ch_kills_prone");

  if((var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT") && var_13)
    var_1 mgkill();

  if((var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT" || var_30 == "iw5_m990") && !var_13 && !var_12) {
    ch_bulletdamagecommon(var_0, var_1, var_10, var_32);

    switch (var_32) {
      case "weapon_smg":
        if(var_14)
          var_1 processchallenge("ch_expert_smg");

        break;
      case "weapon_assault":
        if(var_14)
          var_1 processchallenge("ch_expert_assault");

        break;
      case "weapon_shotgun":
        break;
      case "weapon_sniper":
        break;
      case "weapon_pistol":
        if(var_14)
          var_1 processchallenge("ch_expert_pistol");

        break;
      case "weapon_heavy":
      case "weapon_lmg":
        if(var_14)
          var_1 processchallenge("ch_expert_lmg");

        break;
      default:
    }

    if(var_9 == "MOD_HEAD_SHOT") {
      if(var_32 == "weapon_pistol")
        var_1 notify("increment_pistol_headshots");
      else if(var_32 == "weapon_assault")
        var_1 notify("increment_ar_headshots");
    }

    if(isdefined(level.challengeinfo["ch_marksman_" + var_30]) && var_1 getchallengestatus("ch_marksman_" + var_30) > 0)
      var_1 processchallenge("ch_marksman_" + var_30);

    if(var_14) {
      if(isdefined(level.challengeinfo["ch_expert_" + var_30]) && var_1 getchallengestatus("ch_expert_" + var_30) > 0)
        var_1 processchallenge("ch_expert_" + var_30);
    }
  }

  if(maps\mp\_utility::ismeleemod(var_9) && !var_13 && !var_12) {
    if(!issubstr(var_30, "riotshield")) {
      var_1 processchallenge("ch_knifevet");
      var_1.pers["meleeKillStreak"]++;

      if(var_34 == "mp_crash_snow")
        var_1 processchallenge("ch_wc_melee");
      else if(var_34 == "mp_farm_spring")
        var_1 processchallenge("ch_stpatty_melee");
      else if(var_34 == "mp_bog_summer")
        var_1 processchallenge("ch_summer_melee");

      if(var_1.pers["meleeKillStreak"] == 3) {
        var_1 processchallenge("ch_slasher");

        if(var_34 == "mp_bog_summer")
          var_1 processchallenge("ch_summer_slasher");
      }

      var_35 = var_0.victim.anglesondeath[1];
      var_36 = var_1.anglesonkill[1];
      var_37 = angleclamp180(var_35 - var_36);

      if(abs(var_37) < 30)
        var_1 processchallenge("ch_backstabber");

      if(!var_0.attackeronground)
        var_1 processchallenge("ch_jump_slasher");

      if(var_0.attackerstance == "prone")
        var_1 processchallenge("ch_pronemelee");

      if(!var_0.attackeronground)
        var_1 processchallenge("ch_jumpmelee");
    }

    if(issubstr(var_30, "combatknife"))
      var_1 notify("increment_knife_kill");
  }

  if(issubstr(var_9, "MOD_IMPACT") && !var_13 && !var_12) {
    if(maps\mp\_utility::isstrstart(var_0.sweapon, "h1_frag"))
      var_1 processchallenge("ch_thinkfast");
    else if(maps\mp\_utility::isstrstart(var_0.sweapon, "h1_concussion"))
      var_1 processchallenge("ch_thinkfastconcussion");
    else if(maps\mp\_utility::isstrstart(var_0.sweapon, "h1_flash"))
      var_1 processchallenge("ch_thinkfastflash");

    var_38 = getweaponattachments(var_0.sweapon);
    var_30 = maps\mp\_utility::getbaseweaponname(var_0.sweapon);

    foreach(var_40 in var_38) {
      if(maps\mp\_utility::isstrstart(var_40, "glmwr"))
        var_1 processchallenge("ch_ouch");
    }
  }

  if(issubstr(var_9, "MOD_GRENADE") || issubstr(var_9, "MOD_PROJECTILE") || issubstr(var_9, "MOD_EXPLOSIVE") && !var_13 && !var_12) {
    if(isdefined(var_0.victim.explosiveinfo["damageTime"]) && var_0.victim.explosiveinfo["damageTime"] == var_10) {
      if(var_0.sweapon == "none")
        var_0.sweapon = var_0.victim.explosiveinfo["weapon"];

      var_42 = var_10 + "_" + var_0.victim.explosiveinfo["damageId"];

      if(!isdefined(var_1.explosivekills[var_42]))
        var_1.explosivekills[var_42] = 0;

      var_1 thread clearidshortly(var_42);
      var_1.explosivekills[var_42]++;

      if(var_31 == "fraggrenadeshort") {
        if(var_1.explosivekills[var_42] == 3)
          var_1 processchallenge("ch_martyrdom");

        var_1 processchallenge("ch_martyrdomvet");
      } else if(var_31 == "fraggrenade") {
        if(var_1.explosivekills[var_42] == 2)
          var_1 processchallenge("ch_multifrag");

        var_1 processchallenge("ch_grenadekill");

        if(var_34 == "mp_crash_snow")
          var_1 processchallenge("ch_wc_grenade");
        else if(var_34 == "mp_farm_spring")
          var_1 processchallenge("ch_stpatty_grenade");
        else if(var_34 == "mp_bog_summer")
          var_1 processchallenge("ch_summer_grenade");

        if(var_0.victim.explosiveinfo["cookedKill"])
          var_1 processchallenge("ch_masterchef");

        if(var_0.victim.explosiveinfo["suicideGrenadeKill"])
          var_1 processchallenge("ch_miserylovescompany");

        if(var_0.victim.explosiveinfo["throwbackKill"])
          var_1 processchallenge("ch_hotpotato");
      } else if(var_31 == "c4") {
        if(var_1.explosivekills[var_42] == 2)
          var_1 processchallenge("ch_multic4");

        if(var_0.victim.explosiveinfo["returnToSender"])
          var_1 processchallenge("ch_returntosender");

        if(var_0.victim.explosiveinfo["counterKill"])
          var_1 processchallenge("ch_counterc4");

        if(var_0.victim.explosiveinfo["bulletPenetrationKill"])
          var_1 processchallenge("ch_howthe");

        if(var_0.victim.explosiveinfo["chainKill"])
          var_1 processchallenge("ch_dominos");
      } else if(var_31 == "claymore") {
        var_1 processchallenge("ch_claymoreshot");

        if(var_1.explosivekills[var_42] == 2)
          var_1 processchallenge("ch_multiclaymore");

        if(var_0.victim.explosiveinfo["returnToSender"])
          var_1 processchallenge("ch_returntosender");

        if(var_0.victim.explosiveinfo["counterKill"])
          var_1 processchallenge("ch_counterclaymore");

        if(var_0.victim.explosiveinfo["bulletPenetrationKill"])
          var_1 processchallenge("ch_howthe");

        if(var_0.victim.explosiveinfo["chainKill"])
          var_1 processchallenge("ch_dominos");
      } else if(var_0.sweapon == "destructible_car")
        var_1 processchallenge("ch_carbomb");
      else if(var_31 == "rpg") {
        if(var_1.explosivekills[var_42] == 2)
          var_1 processchallenge("ch_multirpg");
      }
    }

    if(isdefined(var_0.einflictor.classname) && var_0.einflictor.classname == "scriptable")
      var_1 processchallenge("ch_kills_vandalism");
  }

  var_43 = "";
  var_38 = getweaponattachments(var_0.sweapon);

  foreach(var_40 in var_38) {
    var_45 = getsubstr(var_40, 0, 5);

    switch (var_45) {
      case "glmwr":
        if(var_9 == "MOD_GRENADE_SPLASH" || var_9 == "MOD_IMPACT" || var_9 == "MOD_GRENADE") {
          var_1 processchallenge("ch_attach_glkills");
          break;
        }
    }
  }

  var_38 = getweaponattachments(var_0.sweapon);

  if(var_38.size == 0) {
    if(!issubstr(var_9, "MOD_MELEE")) {
      switch (var_32) {
        case "weapon_pistol":
        case "weapon_heavy":
        case "weapon_shotgun":
        case "weapon_sniper":
        case "weapon_assault":
        case "weapon_smg":
          var_1 processchallenge("ch_barebone_" + var_30);
          break;
      }
    }
  } else if(var_38.size > 0) {
    if(!issubstr(var_9, "MOD_MELEE")) {
      foreach(var_48 in var_38) {
        if(issubstr(var_48, "reflexmwr")) {
          var_1 processchallenge("ch_reddot_" + var_30);
          continue;
        }

        if(issubstr(var_48, "silencermwr")) {
          var_1 processchallenge("ch_silencer_" + var_30);
          continue;
        }

        if(issubstr(var_48, "acogmwr"))
          var_1 processchallenge("ch_acog_" + var_30);
      }
    }
  }

  if(level.gametype == "gun")
    var_1 processchallenge("ch_ggkills");

  if(isdefined(var_0.victim.isplanting) && var_0.victim.isplanting)
    var_1 processchallenge("ch_bombplanter");

  if(isdefined(var_0.victim.isdefusing) && var_0.victim.isdefusing)
    var_1 processchallenge("ch_bombdefender");

  if(isdefined(var_0.victim.isbombcarrier) && var_0.victim.isbombcarrier)
    var_1 processchallenge("ch_bombdown");

  if(isdefined(var_1.inlaststand) && var_1.inlaststand)
    var_1 processchallenge("ch_laststandvet");

  if(isdefined(var_1.pers["killed_players"][var_0.victim.guid]) && var_1.pers["killed_players"][var_0.victim.guid] == 5)
    var_1 processchallenge("ch_rival");

  if(isdefined(var_1.tookweaponfrom[var_0.sweapon])) {
    if(var_1.tookweaponfrom[var_0.sweapon] == var_0.victim && !maps\mp\_utility::ismeleemod(var_0.smeansofdeath))
      var_1 processchallenge("ch_cruelty");
  }

  if(var_1 isatbrinkofdeath()) {
    var_1.brinkofdeathkillstreak++;

    if(var_1.brinkofdeathkillstreak >= 3)
      var_1 processchallenge("ch_thebrink");
  }

  if(isdefined(var_1.patient_zero)) {
    var_1.patient_zero++;

    if(var_1.patient_zero == 3)
      var_1 processchallenge("ch_infect_patientzero");
  }
}

get_challenge_weapon_class(var_0, var_1) {
  var_2 = maps\mp\_utility::getweaponclass(var_0);

  if(!isdefined(var_1)) {
    var_1 = maps\mp\_utility::getbaseweaponname(var_0);

    if(maps\mp\_utility::islootweapon(var_1))
      var_1 = maps\mp\gametypes\_class::getbasefromlootversion(var_1);
  }

  if(var_1 == "h1_rpg")
    return "weapon_launcher";

  return var_2;
}

ch_bulletdamagecommon(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::isenvironmentweapon(var_0.sweapon))
    var_1 endmgstreak();

  if(maps\mp\_utility::iskillstreakweapon(var_0.sweapon)) {
    return;
  }
  if(isbot(var_1)) {
    return;
  }
  if(var_1.pers["lastBulletKillTime"] == var_2)
    var_1.pers["bulletStreak"]++;
  else
    var_1.pers["bulletStreak"] = 1;

  var_1.pers["lastBulletKillTime"] = var_2;

  if(!var_0.victimonground)
    var_1 processchallenge("ch_hardlanding");

  if(!var_0.attackeronground)
    var_1.pers["midairStreak"]++;

  if(var_1.pers["midairStreak"] == 2)
    var_1 processchallenge("ch_airborne");

  if(var_2 < var_0.victim.flashendtime)
    var_1 processchallenge("ch_flashbangvet");

  if(var_2 < var_1.flashendtime)
    var_1 processchallenge("ch_blindfire");

  if(var_2 < var_0.victim.concussionendtime)
    var_1 processchallenge("ch_concussionvet");

  if(var_2 < var_1.concussionendtime)
    var_1 processchallenge("ch_slowbutsure");

  if(var_1.pers["bulletStreak"] == 2) {
    if(isdefined(var_0.modifiers["headshot"])) {
      foreach(var_5 in var_1.killsthislife) {
        if(var_5.time != var_2) {
          continue;
        }
        if(!isdefined(var_0.modifiers["headshot"])) {
          continue;
        }
        var_1 processchallenge("ch_allpro");
      }
    }

    if(var_3 == "weapon_sniper") {
      var_1 processchallenge("ch_collateraldamage");

      if(maps\mp\_utility::getmapname() == "mp_bog_summer")
        var_1 processchallenge("ch_summer_collateraldamage");
    }
  }

  if(var_3 == "weapon_pistol") {
    if(isdefined(var_0.victim.attackerdata) && isdefined(var_0.victim.attackerdata[var_1.guid])) {
      if(isdefined(var_0.victim.attackerdata[var_1.guid].isprimary))
        var_1 processchallenge("ch_fastswap");
    }
  }

  if(!isdefined(var_1.infinalstand) || !var_1.infinalstand) {
    var_7 = maps\mp\_utility::getbaseweaponname(var_0.sweapon);

    if(var_0.attackerstance == "crouch") {
      var_1 processchallenge("ch_crouchshot");
      var_1 processchallenge("ch_crouch_" + var_7);
    } else if(var_0.attackerstance == "prone") {
      var_1 processchallenge("ch_proneshot");
      var_1 processchallenge("ch_prone_" + var_7);

      if(var_3 == "weapon_sniper")
        var_1 processchallenge("ch_invisible");
    }
  }

  if(issubstr(var_0.sweapon, "silencer"))
    var_1 processchallenge("ch_stealth");
}

ch_roundplayed(var_0) {
  var_1 = var_0.player;

  if(var_1.wasaliveatmatchstart) {
    var_2 = var_1.pers["deaths"];
    var_3 = var_1.pers["kills"];
    var_4 = 1000000;

    if(var_2 > 0)
      var_4 = var_3 / var_2;

    if(var_4 >= 5.0 && var_3 >= 5.0)
      var_1 processchallenge("ch_starplayer");

    if(var_2 == 0 && maps\mp\_utility::gettimepassed() > 300000)
      var_1 processchallenge("ch_flawless");

    if(level.placement["all"].size < 3) {
      return;
    }
    if(var_1.score > 0) {
      switch (level.gametype) {
        case "dm":
          if(var_0.place < 3) {
            var_1 processchallenge("ch_victor_dm");
            var_1 processchallenge("ch_ffa_win");
          }

          var_1 processchallenge("ch_ffa_participate");
          break;
        default:
          break;
      }
    }
  }
}

ch_roundwin(var_0) {
  if(!var_0.winner) {
    return;
  }
  var_1 = var_0.player;

  if(var_1.wasaliveatmatchstart) {
    switch (level.gametype) {
      case "war":
        if(level.players.size >= 6 && var_1.kills > 0) {
          if(level.hardcoremode) {
            var_1 processchallenge("ch_teamplayer_hc");

            if(var_0.place == 0)
              var_1 processchallenge("ch_mvp_thc");
          } else {
            var_1 processchallenge("ch_teamplayer");

            if(var_0.place == 0)
              var_1 processchallenge("ch_mvp_tdm");
          }
        }

        break;
      case "sab":
        var_1 processchallenge("ch_victor_sab");
        break;
      case "sd":
        var_1 processchallenge("ch_victor_sd");
        break;
      case "hc":
      case "koth":
      case "dom":
      case "ctf":
      case "dm":
      case "hp":
        break;
      default:
        break;
    }
  }
}

playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");

  if(isdefined(var_1))
    var_1 endon("disconnect");

  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_6 = spawnstruct();
  var_6.victim = self;
  var_6.einflictor = var_0;
  var_6.attacker = var_1;
  var_6.idamage = var_2;
  var_6.smeansofdeath = var_3;
  var_6.sweapon = var_4;
  var_6.shitloc = var_5;
  var_6.victimonground = var_6.victim isonground();

  if(isplayer(var_1)) {
    var_6.attackerinlaststand = isdefined(var_6.attacker.laststand);
    var_6.attackeronground = var_6.attacker isonground();
    var_6.attackerstance = var_6.attacker getstance();
  } else {
    var_6.attackerinlaststand = 0;
    var_6.attackeronground = 0;
    var_6.attackerstance = "stand";
  }

  domissioncallback("playerDamaged", var_6);
}

playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.anglesondeath = self getplayerangles();

  if(isdefined(var_1))
    var_1.anglesonkill = var_1 getplayerangles();

  self endon("disconnect");
  var_9 = spawnstruct();
  var_9.victim = self;
  var_9.einflictor = var_0;
  var_9.attacker = var_1;
  var_9.idamage = var_2;
  var_9.smeansofdeath = var_3;
  var_9.sweapon = var_4;
  var_9.sprimaryweapon = var_5;
  var_9.shitloc = var_6;
  var_9.time = gettime();
  var_9.modifiers = var_7;
  var_9.duetodisconnect = var_8;
  var_9.victimonground = var_9.victim isonground();

  if(isplayer(var_1)) {
    var_9.attackerinlaststand = isdefined(var_9.attacker.laststand);
    var_9.attackeronground = var_9.attacker isonground();
    var_9.attackerstance = var_9.attacker getstance();
  } else {
    var_9.attackerinlaststand = 0;
    var_9.attackeronground = 0;
    var_9.attackerstance = "stand";
  }

  var_10 = 0;

  if(isdefined(var_9.einflictor) && isdefined(var_9.einflictor.firedads))
    var_10 = var_9.einflictor.firedads;
  else if(isdefined(var_1) && isplayer(var_1))
    var_10 = var_1 playerads();

  var_9.was_ads = 0;

  if(var_10 >= 0.2)
    var_9.was_ads = 1;

  waitandprocessplayerkilledcallback(var_9);

  if(isdefined(var_1) && maps\mp\_utility::isreallyalive(var_1))
    var_1.killsthislife[var_1.killsthislife.size] = var_9;

  var_9.attacker notify("playerKilledChallengesProcessed");
}

vehiclekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnstruct();
  var_7.vehicle = var_1;
  var_7.victim = var_0;
  var_7.einflictor = var_2;
  var_7.attacker = var_3;
  var_7.idamage = var_4;
  var_7.smeansofdeath = var_5;
  var_7.sweapon = var_6;
  var_7.time = gettime();
  domissioncallback("vehicleKilled", var_7);
}

waitandprocessplayerkilledcallback(var_0) {
  if(isdefined(var_0.attacker))
    var_0.attacker endon("disconnect");

  self.processingkilledchallenges = 1;

  if(!isdefined(var_0.duetodisconnect) || !var_0.duetodisconnect) {
    wait 0.05;
    maps\mp\_utility::waittillslowprocessallowed();
  }

  domissioncallback("playerKilled", var_0);
  self.processingkilledchallenges = undefined;
}

playerassist() {
  var_0 = spawnstruct();
  var_0.player = self;
  domissioncallback("playerAssist", var_0);
}

usehardpoint(var_0) {
  self endon("disconnect");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_1 = spawnstruct();
  var_1.player = self;
  var_1.hardpointtype = var_0;
  domissioncallback("playerHardpoint", var_1);
}

roundbegin() {
  domissioncallback("roundBegin");
}

roundend(var_0) {
  var_1 = spawnstruct();

  if(level.teambased) {
    var_2 = "allies";

    for (var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.winner = var_2 == var_0;
      var_1.place = var_3;
      domissioncallback("roundEnd", var_1);
    }

    var_2 = "axis";

    for (var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.winner = var_2 == var_0;
      var_1.place = var_3;
      domissioncallback("roundEnd", var_1);
    }
  } else {
    for (var_3 = 0; var_3 < level.placement["all"].size; var_3++) {
      var_1.player = level.placement["all"][var_3];
      var_1.winner = isdefined(var_0) && isplayer(var_0) && var_1.player == var_0;
      var_1.place = var_3;
      domissioncallback("roundEnd", var_1);
    }
  }
}

domissioncallback(var_0, var_1) {
  if(!mayprocesschallenges()) {
    return;
  }
  if(getdvarint("disable_challenges") > 0) {
    return;
  }
  if(!isdefined(level.missioncallbacks[var_0])) {
    return;
  }
  if(isdefined(var_1)) {
    for (var_2 = 0; var_2 < level.missioncallbacks[var_0].size; var_2++)
      thread[[level.missioncallbacks[var_0][var_2]]](var_1);
  } else {
    for (var_2 = 0; var_2 < level.missioncallbacks[var_0].size; var_2++)
      thread[[level.missioncallbacks[var_0][var_2]]]();
  }
}

monitorsprintdistance() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");

  if(!isdefined(self.pers["totalGameSprintDist"]))
    self.pers["totalGameSprintDist"] = 0;

  for (;;) {
    self waittill("sprint_begin");
    self.sprintdistthissprint = 0;
    monitorsinglesprintdistance();
    processchallenge("ch_marathon", int(self.sprintdistthissprint));

    if(maps\mp\_utility::getmapname() == "mp_crash_snow")
      processchallenge("ch_wc_sprint", int(self.sprintdistthissprint));

    self.pers["totalGameSprintDist"] = self.pers["totalGameSprintDist"] + self.sprintdistthissprint;

    if(maps\mp\_utility::_hasperk("specialty_longersprint")) {
      if(int(self.pers["totalGameSprintDist"]) >= 15840) {
        processchallenge("ch_extremeconditioning");
        self.pers["totalGameSprintDist"] = 0;
      }
    }
  }
}

monitorsinglesprintdistance() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");
  self endon("sprint_end");
  var_0 = self.origin;

  for (;;) {
    wait 0.1;
    self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin, var_0);
    var_0 = self.origin;
  }
}

monitorfalldistance() {
  self endon("disconnect");
  self.pers["midairStreak"] = 0;

  for (;;) {
    if(!isalive(self)) {
      self waittill("spawned_player");
      continue;
    }

    if(!self isonground()) {
      self.pers["midairStreak"] = 0;
      var_0 = self.origin[2];

      while (!self isonground()) {
        if(self.origin[2] > var_0)
          var_0 = self.origin[2];

        wait 0.05;
      }

      self.pers["midairStreak"] = 0;
      var_1 = var_0 - self.origin[2];

      if(var_1 < 0)
        var_1 = 0;

      if(var_1 / 12.0 > 15 && isalive(self))
        processchallenge("ch_basejump");

      if(var_1 / 12.0 > 30 && !isalive(self))
        processchallenge("ch_goodbye");
    }

    wait 0.05;
  }
}

remove_tracking_on_disconnect(var_0) {
  level endon("game_ended");
  self waittill("disconnect");

  if(isdefined(game[var_0][self.guid]))
    game[var_0][self.guid] = undefined;
}

lastmansd() {
  if(!mayprocesschallenges()) {
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

monitorbombuse() {
  self endon("disconnect");

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return("bomb_planted", "bomb_defused");

    if(!isdefined(var_0)) {
      continue;
    }
    if(var_0 == "bomb_defused")
      processchallenge("ch_hero");
  }
}

monitorlivetime() {
  for (;;) {
    self waittill("spawned_player");
    thread survivalistchallenge();
  }
}

survivalistchallenge() {
  self endon("death");
  self endon("disconnect");
  wait 300;

  if(isdefined(self))
    processchallenge("ch_survivalist");
}

monitorstreaks() {
  self endon("disconnect");
  self.pers["airstrikeStreak"] = 0;
  self.pers["meleeKillStreak"] = 0;
  self.pers["shieldKillStreak"] = 0;
  thread monitormisc();

  for (;;) {
    self waittill("death");
    self.pers["airstrikeStreak"] = 0;
    self.pers["meleeKillStreak"] = 0;
    self.pers["shieldKillStreak"] = 0;
  }
}

monitormisc() {
  self endon("disconnect");

  for (;;) {
    var_0 = common_scripts\utility::waittill_any_return_no_endon_death("destroyed_explosive", "begin_airstrike", "destroyed_helicopter", "destroyed_car", "crushed_enemy");
    monitormisccallback(var_0);
  }
}

monitormisccallback(var_0) {
  switch (var_0) {
    case "begin_airstrike":
      self.pers["airstrikeStreak"] = 0;
      break;
    case "destroyed_explosive":
      processchallenge("ch_backdraft");
      break;
    case "destroyed_helicopter":
      processchallenge("ch_flyswatter");
      break;
    case "destroyed_car":
      processchallenge("ch_vandalism");
      break;
    default:
      break;
  }
}

healthregenerated() {
  if(!isalive(self)) {
    return;
  }
  if(!mayprocesschallenges()) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  thread resetbrinkofdeathkillstreakshortly();

  if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy) {
    self.healthregenerationstreak++;

    if(self.healthregenerationstreak >= 5) {
      self.healthregenerationstreak = 0;
      processchallenge("ch_invincible");
    }
  }
}

resetbrinkofdeathkillstreakshortly() {
  self endon("disconnect");
  self endon("death");
  self endon("damage");
  wait 1;
  self.brinkofdeathkillstreak = 0;
}

playerspawned() {
  self.brinkofdeathkillstreak = 0;
  self.healthregenerationstreak = 0;
}

playerdied() {
  self.brinkofdeathkillstreak = 0;
  self.healthregenerationstreak = 0;
}

isatbrinkofdeath() {
  var_0 = self.health / self.maxhealth;
  return var_0 <= level.healthoverlaycutoff;
}

processchallenge(var_0, var_1, var_2) {
  if(!mayprocesschallenges()) {
    return;
  }
  if(level.players.size < 2 && !getdvarint("force_ranking")) {
    var_3 = undefined;

    if(isdefined(var_3)) {
      if(var_3 == 0)
        return;
    } else
      return;
  }

  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!isdefined(var_1))
    var_1 = 1;

  var_4 = getchallengestatus(var_0);

  if(var_4 == 0) {
    return;
  }
  if(var_4 > level.challengeinfo[var_0]["targetval"].size) {
    return;
  }
  var_5 = maps\mp\gametypes\_hud_util::ch_getprogress(var_0);

  if(isdefined(var_2) && var_2)
    var_6 = var_1;
  else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(var_0))
    var_6 = var_5;
  else
    var_6 = var_5 + var_1;

  var_7 = 0;

  for (var_8 = level.challengeinfo[var_0]["targetval"][var_4]; isdefined(var_8) && var_6 >= var_8; var_8 = level.challengeinfo[var_0]["targetval"][var_4 + var_7])
    var_7++;

  if(var_5 < var_6)
    maps\mp\gametypes\_hud_util::ch_setprogress(var_0, var_6);

  if(var_7 > 0) {
    var_9 = var_4;

    while (var_7) {
      thread giverankxpafterwait(var_0, var_4);
      var_10 = getchallengeid(var_0, var_4);
      self challengenotification(var_10);
      var_11 = common_scripts\utility::tostring(var_10);
      var_12 = int(getsubstr(var_11, 0, var_11.size - 2));

      if(!isdefined(game["challengeStruct"]["challengesCompleted"][self.guid]))
        game["challengeStruct"]["challengesCompleted"][self.guid] = [];

      var_13 = 0;

      foreach(var_15 in game["challengeStruct"]["challengesCompleted"][self.guid]) {
        if(var_15 == var_12)
          var_13 = 1;
      }

      if(!var_13)
        game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_12;

      if(var_4 >= level.challengeinfo[var_0]["targetval"].size && level.challengeinfo[var_0]["parent_challenge"] != "")
        processchallenge(level.challengeinfo[var_0]["parent_challenge"]);

      var_4++;
      var_7--;
      maps\mp\_matchdata::logcompletedchallenge(var_10);
    }

    if(!issubstr(var_0, "ch_limited_bloodshed"))
      thread maps\mp\gametypes\_hud_message::challengesplashnotify(var_0, var_9, var_4);

    maps\mp\gametypes\_hud_util::ch_setstate(var_0, var_4);
    self.challengedata[var_0] = var_4;
  }
}

giverankxpafterwait(var_0, var_1) {
  self endon("disconnect");
  wait 0.25;
  maps\mp\gametypes\_rank::giverankxp("challenge", level.challengeinfo[var_0]["reward"][var_1], undefined, undefined, var_0);
}

getmarksmanunlockattachment(var_0, var_1) {
  return tablelookup("mp\unlockTable.csv", 0, var_0, 4 + var_1);
}

getlastchallengetier(var_0) {
  var_1 = 0;

  if(isdefined(level.challengeinfo[var_0]) && isdefined(level.challengeinfo[var_0]["targetval"].size))
    var_1 = level.challengeinfo[var_0]["targetval"].size;

  return var_1;
}

getchallengetiernumber(var_0) {
  var_1 = getsubstr(var_0, var_0.size - 2, var_0.size);

  if(getsubstr(var_1, 0, 1) == "_")
    var_2 = int(getsubstr(var_1, 1, 2));
  else
    var_2 = 0;

  return var_2;
}

ischallengeresetafterprestige(var_0, var_1) {
  var_2 = tablelookupbyrow("mp\allChallengesTable.csv", var_0, 45);

  if(!isdefined(var_1))
    var_1 = tablelookupbyrow("mp\allChallengesTable.csv", var_0, 6);

  if(var_2 != "" && int(var_2) && int(var_1) != 4)
    return 1;

  return 0;
}

ischallengeunlocked(var_0, var_1) {
  var_2 = tablelookupbyrow("mp\allChallengesTable.csv", var_1, 9);

  if(var_2 != "") {
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "challengeState", var_2);

    if(var_3 > 1)
      return 1;
  }

  var_4 = tablelookupbyrow("mp\allChallengesTable.csv", var_1, 6);

  if(var_4 != "") {
    var_5 = maps\mp\gametypes\_rank::getrank();
    var_6 = maps\mp\gametypes\_rank::getprestigelevel();

    if(var_5 < int(var_4)) {
      if(var_6 < 1)
        return 0;

      if(int(var_4) > 54)
        return 0;

      if(ischallengeresetafterprestige(var_1, var_4))
        return 0;
    }
  }

  var_7 = tablelookupbyrow("mp\allChallengesTable.csv", var_1, 47);

  if(var_7 != "") {
    var_6 = maps\mp\gametypes\_rank::getprestigelevel();

    if(var_6 < int(var_7))
      return 0;
  }

  var_8 = tablelookupbyrow("mp\allChallengesTable.csv", var_1, 8);

  if(var_8 != "") {
    var_9 = self isitemunlocked(var_8);

    if(!var_9)
      return 0;
  }

  var_10 = tablelookupbyrow("mp\allChallengesTable.csv", var_1, 7);

  if(var_10 != "") {
    var_11 = getchallengetiernumber(var_10);

    if(var_11 == 0)
      var_11 = getlastchallengetier(var_10);

    if(var_11 > 0) {
      var_12 = getchallengestatus(var_10);

      if(var_12 <= var_11)
        return 0;
    }
  }

  return 1;
}

updatechallenges() {
  self.challengedata = [];

  if(!isdefined(self.ch_unique_earned_streaks))
    self.ch_unique_earned_streaks = [];

  if(!isdefined(game["challengeStruct"]))
    game["challengeStruct"] = [];

  if(!isdefined(game["challengeStruct"]["limitedChallengesReset"]))
    game["challengeStruct"]["limitedChallengesReset"] = [];

  if(!isdefined(game["challengeStruct"]["challengesCompleted"]))
    game["challengeStruct"]["challengesCompleted"] = [];

  self endon("disconnect");

  if(!mayprocesschallenges()) {
    return;
  }
  if(!self isitemunlocked("feature_challenges")) {
    return;
  }
  var_0 = 0;

  foreach(var_5, var_2 in level.challengeinfo) {
    var_0++;

    if(var_0 % 40 == 0)
      wait 0.05;

    self.challengedata[var_5] = 0;
    var_3 = var_2["index"];

    if(!ischallengeunlocked(var_5, var_3)) {
      continue;
    }
    var_4 = maps\mp\gametypes\_hud_util::ch_getstate(var_5);

    if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_5) && !isdefined(game["challengeStruct"]["limitedChallengesReset"][self.guid])) {
      maps\mp\gametypes\_hud_util::ch_setprogress(var_5, 0);
      var_4 = 0;
    }

    if(var_4 == 0) {
      maps\mp\gametypes\_hud_util::ch_setstate(var_5, 1);
      var_4 = 1;
    }

    self.challengedata[var_5] = var_4;
  }

  game["challengeStruct"]["limitedChallengesReset"][self.guid] = 1;
}

isinunlocktable(var_0) {
  return tablelookup("mp\unlockTable.csv", 0, var_0, 0) != "";
}

getchallengefilter(var_0) {
  return tablelookup("mp\allChallengesTable.csv", 0, var_0, 5);
}

getchallengetable(var_0) {
  return tablelookup("mp\challengeTable.csv", 8, var_0, 4);
}

gettierfromtable(var_0, var_1) {
  return tablelookup(var_0, 0, var_1, 1);
}

isweaponchallenge(var_0) {
  if(!isdefined(var_0))
    return 0;

  var_1 = getchallengefilter(var_0);

  if(isdefined(var_1) && var_1 == "riotshield")
    return 1;

  var_2 = maps\mp\_utility::getweaponnametokens(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(var_4 == "iw5" || var_4 == "iw6" || var_4 == "h1")
      var_4 = var_2[var_3] + "_" + var_2[var_3 + 1];

    if(maps\mp\gametypes\_class::isvalidprimary(var_4) || maps\mp\gametypes\_class::isvalidsecondary(var_4))
      return 1;
  }

  return 0;
}

getweaponfromchallenge(var_0) {
  var_1 = "ch_";

  if(issubstr(var_0, "ch_marksman_"))
    var_1 = "ch_marksman_";
  else if(issubstr(var_0, "ch_expert_"))
    var_1 = "ch_expert_";
  else if(issubstr(var_0, "pr_marksman_"))
    var_1 = "pr_marksman_";
  else if(issubstr(var_0, "pr_expert_"))
    var_1 = "pr_expert_";

  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);
  var_2 = undefined;

  if(var_3[0] == "iw5" || var_3[0] == "iw6" || var_3[0] == "h1")
    var_2 = var_3[0] + "_" + var_3[1];
  else
    var_2 = var_3[0];

  return var_2;
}

getweaponattachmentfromchallenge(var_0) {
  var_1 = "ch_";

  if(issubstr(var_0, "ch_marksman_"))
    var_1 = "ch_marksman_";
  else if(issubstr(var_0, "ch_expert_"))
    var_1 = "ch_expert_";
  else if(issubstr(var_0, "pr_marksman_"))
    var_1 = "pr_marksman_";
  else if(issubstr(var_0, "pr_expert_"))
    var_1 = "pr_expert_";

  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);
  var_4 = undefined;

  if(isdefined(var_3[2]) && maps\mp\_utility::isattachment(var_3[2]))
    var_4 = var_3[2];

  return var_4;
}

iskillstreakchallenge(var_0) {
  if(!isdefined(var_0))
    return 0;

  var_1 = getchallengefilter(var_0);

  if(isdefined(var_1) && (var_1 == "killstreaks_assault" || var_1 == "killstreaks_support"))
    return 1;

  return 0;
}

getkillstreakfromchallenge(var_0) {
  var_1 = "ch_";
  var_2 = getsubstr(var_0, var_1.size, var_0.size);

  if(var_2 == "assault_streaks" || var_2 == "support_streaks")
    var_2 = undefined;

  return var_2;
}

challenge_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + (var_2 - 1) * 2);
  return int(var_3);
}

challenge_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 11 + (var_2 - 1) * 2);
  return int(var_3);
}

challenge_parentchallenge(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, var_1, 43);

  if(!isdefined(var_2))
    var_2 = "";

  return var_2;
}

buildchallengetableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  for (;;) {
    var_3++;
    var_4 = tablelookupbyrow(var_0, var_3, 0);

    if(var_4 == "") {
      break;
    }

    var_5 = tablelookupbyrow(var_0, var_3, 44);

    if(var_5 == "1") {
      continue;
    }
    level.challengeinfo[var_4] = [];
    level.challengeinfo[var_4]["index"] = var_3;
    level.challengeinfo[var_4]["type"] = var_1;
    level.challengeinfo[var_4]["targetval"] = [];
    level.challengeinfo[var_4]["reward"] = [];
    level.challengeinfo[var_4]["parent_challenge"] = "";

    if(isweaponchallenge(var_4)) {
      var_6 = getweaponfromchallenge(var_4);
      var_7 = getweaponattachmentfromchallenge(var_4);

      if(isdefined(var_6))
        level.challengeinfo[var_4]["weapon"] = var_6;

      if(isdefined(var_7))
        level.challengeinfo[var_4]["attachment"] = var_7;
    } else if(iskillstreakchallenge(var_4)) {
      var_8 = getkillstreakfromchallenge(var_4);

      if(isdefined(var_8))
        level.challengeinfo[var_4]["killstreak"] = var_8;
    }

    for (var_9 = 1; var_9 < 11; var_9++) {
      var_10 = challenge_targetval(var_0, var_4, var_9);
      var_11 = challenge_rewardval(var_0, var_4, var_9);

      if(var_10 == 0) {
        break;
      }

      level.challengeinfo[var_4]["targetval"][var_9] = var_10;
      level.challengeinfo[var_4]["reward"][var_9] = var_11;
      var_2 = var_2 + var_11;
    }

    level.challengeinfo[var_4]["parent_challenge"] = challenge_parentchallenge(var_0, var_4);
  }

  return int(var_2);
}

buildchallegeinfo() {
  level.challengeinfo = [];

  if(getdvar("virtualLobbyActive") == "1") {
    return;
  }
  var_0 = 0;
  var_0 = var_0 + buildchallengetableinfo("mp\allChallengesTable.csv", 0);
}

monitorprocesschallenge() {
  self endon("disconnect");
  level endon("game_end");

  for (;;) {
    if(!mayprocesschallenges()) {
      return;
    }
    self waittill("process", var_0);
    processchallenge(var_0);
  }
}

monitorkillstreakprogress() {
  self endon("disconnect");
  level endon("game_end");

  for (;;) {
    self waittill("got_killstreak", var_0);

    if(!isdefined(var_0))
      continue;
  }
}

genericchallenge(var_0, var_1) {
  switch (var_0) {
    default:
      break;
  }
}

playerhasammo() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2))
      return 1;

    var_3 = weaponaltweaponname(var_2);

    if(!isdefined(var_3) || var_3 == "none") {
      continue;
    }
    if(self getweaponammoclip(var_3))
      return 1;
  }

  return 0;
}

monitoradstime() {
  self endon("disconnect");
  self.adstime = 0.0;

  for (;;) {
    if(self playerads() == 1)
      self.adstime = self.adstime + 0.05;
    else
      self.adstime = 0.0;

    wait 0.05;
  }
}

monitorpronetime() {
  self endon("disconnect");
  level endon("game_ended");
  self.pronetime = undefined;
  var_0 = 0;

  for (;;) {
    var_1 = self getstance();

    if(var_1 == "prone" && var_0 == 0) {
      self.pronetime = gettime();
      var_0 = 1;
    } else if(var_1 != "prone") {
      self.pronetime = undefined;
      var_0 = 0;
    }

    wait 0.05;
  }
}

monitorholdbreath() {
  self endon("disconnect");
  self.holdingbreath = 0;

  for (;;) {
    self waittill("hold_breath");
    self.holdingbreath = 1;
    self waittill("release_breath");
    self.holdingbreath = 0;
  }
}

monitormantle() {
  self endon("disconnect");
  self.mantling = 0;

  for (;;) {
    self waittill("jumped");
    var_0 = self getcurrentweapon();
    common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
    var_1 = self getcurrentweapon();

    if(var_1 == "none")
      self.mantling = 1;
    else
      self.mantling = 0;

    if(self.mantling) {
      common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
      var_1 = self getcurrentweapon();

      if(var_1 == var_0)
        self.mantling = 0;
    }
  }
}

monitorweaponswap() {
  self endon("disconnect");
  var_0 = self getcurrentweapon();

  for (;;) {
    self waittill("weapon_change", var_1);

    if(var_1 == "none") {
      continue;
    }
    if(var_1 == var_0) {
      continue;
    }
    if(maps\mp\_utility::iskillstreakweapon(var_1)) {
      continue;
    }
    if(maps\mp\_utility::isbombsiteweapon(var_1)) {
      continue;
    }
    var_2 = weaponinventorytype(var_1);

    if(var_2 != "primary") {
      continue;
    }
    self.lastprimaryweaponswaptime = gettime();
  }
}

monitorflashbang() {
  self endon("disconnect");

  for (;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);

    if(isdefined(var_3) && self == var_3) {
      continue;
    }
    self.lastflashedtime = gettime();
  }
}

monitorconcussion() {
  self endon("disconnect");

  for (;;) {
    self waittill("concussed", var_0);

    if(self == var_0) {
      continue;
    }
    self.lastconcussedtime = gettime();
  }
}

is_lethal_equipment(var_0) {
  if(!isdefined(var_0))
    return 0;

  switch (var_0) {
    case "h1_fraggrenade_mp":
      return 1;
    default:
      return 0;
  }
}