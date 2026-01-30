/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42912.gsc
**************************************/

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
  if(maps\mp\_utility::practiceroundgame()) {
    return 0;
  }

  return level.rankedmatch;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(isbot(var_0)) {
      continue;
    }
    if(!isDefined(var_0.pers["postGameChallenges"])) {
      var_0.pers["postGameChallenges"] = 0;
    }

    var_0 thread onplayerspawned();
    var_0 thread initmissiondata();
    var_0 thread monitorbombuse();
    var_0 thread monitorstreaks();
    var_0 thread monitorstreakreward();
    var_0 thread monitorscavengerpickup();
    var_0 thread monitorblastshieldsurvival();
    var_0 thread monitorprocesschallenge();
    var_0 thread monitorkillstreakprogress();
    var_0 thread monitorfinalstandsurvival();
    var_0 thread monitoradstime();
    var_0 thread monitorpronetime();
    var_0 thread monitorpowerslidetime();
    var_0 thread monitorweaponswap();
    var_0 thread monitorflashbang();
    var_0 thread monitorconcussion();
    var_0 thread monitorminetriggering();
    var_0 thread monitorboostjumpdistance();
    var_0 thread monitorplayermatchchallenges();
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

  for(;;) {
    self waittill("spawned_player");
    thread onplayerdeath();
    thread monitorsprintdistance();
  }
}

onplayerdeath() {
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self.hasscavengedammothislife)) {
    self.hasscavengedammothislife = 0;
  }
}

monitorscavengerpickup() {
  self endon("disconnect");

  for(;;) {
    self waittill("scavenger_pickup");

    if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::_hasperk("specialty_scavenger") && !maps\mp\_utility::isjuggernaut()) {
      processchallenge("ch_scavenger_pro");
      self.hasscavengedammothislife = 1;
    }

    wait 0.05;
  }
}

monitorstreakreward() {
  self endon("disconnect");

  for(;;) {
    self waittill("received_earned_killstreak");

    if(self isitemunlocked("specialty_hardline") && maps\mp\_utility::_hasperk("specialty_hardline")) {
      processchallenge("ch_hardline_pro");
    }

    wait 0.05;
  }
}

monitorblastshieldsurvival() {
  self endon("disconnect");

  for(;;) {
    self waittill("survived_explosion", var_0);

    if(isDefined(var_0) && isplayer(var_0) && self == var_0) {
      continue;
    }
    if(self isitemunlocked("_specialty_blastshield") && maps\mp\_utility::_hasperk("_specialty_blastshield")) {
      processchallenge("ch_blastshield_pro");
    }

    waitframe();
  }
}

monitorfinalstandsurvival() {
  self endon("disconnect");

  for(;;) {
    self waittill("revive");
    processchallenge("ch_livingdead");
    waitframe();
  }
}

initmissiondata() {
  var_0 = getarraykeys(level.killstreakfuncs);

  foreach(var_2 in var_0) {
    self.pers[var_2] = 0;
  }

  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermissioncallback(var_0, var_1) {
  if(!isDefined(level.missioncallbacks[var_0])) {
    level.missioncallbacks[var_0] = [];
  }

  level.missioncallbacks[var_0][level.missioncallbacks[var_0].size] = var_1;
}

getchallengestatus(var_0) {
  if(isDefined(self.challengedata[var_0])) {
    return self.challengedata[var_0];
  } else {
    return 0;
  }
}

ch_assists(var_0) {
  var_1 = var_0.player;
  var_1 processchallenge("ch_assists");
}

ch_streak_kill(var_0) {
  switch (var_0) {
    case "vulcan_kill":
      processchallenge("ch_streak_orbitallaser");
      break;
    case "warbird_kill":
      processchallenge("ch_streak_warbird");
      break;
    case "paladin_kill":
      processchallenge("ch_streak_paladin");
      break;
    case "missile_strike_kill":
      processchallenge("ch_streak_missle");
      break;
    case "sentry_gun_kill":
      processchallenge("ch_streak_sentry");
      break;
    case "strafing_run_kill":
      processchallenge("ch_streak_strafing");
      break;
    case "assault_drone_kill":
      processchallenge("ch_streak_assault");
      break;
    case "goliath_kill":
      processchallenge("ch_streak_goliath");
      break;
    default:
      break;
  }
}

ch_hardpoints(var_0) {
  if(isbot(var_0.player)) {
    return;
  }
  var_1 = var_0.player;
  var_1.pers[var_0.hardpointtype]++;

  switch (var_0.hardpointtype) {
    case "uav":
      var_1 processchallenge("ch_uav");
      var_1 processchallenge("ch_assault_streaks");

      if(var_1.pers["uav"] >= 3) {
        var_1 processchallenge("ch_nosecrets");
      }

      break;
    case "airdrop_assault":
      var_1 processchallenge("ch_airdrop_assault");
      var_1 processchallenge("ch_assault_streaks");
      break;
    case "airdrop_sentry_minigun":
      var_1 processchallenge("ch_airdrop_sentry_minigun");
      var_1 processchallenge("ch_assault_streaks");
      break;
    case "nuke":
      var_1 processchallenge("ch_nuke");
      break;
  }
}

ch_vehicle_kills(var_0) {
  if(!isDefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  if(!maps\mp\_utility::iskillstreakweapon(var_0.sweapon)) {
    return;
  }
  var_1 = var_0.attacker;

  if(!isDefined(var_1.pers[var_0.sweapon + "_streak"]) || isDefined(var_1.pers[var_0.sweapon + "_streakTime"]) && gettime() - var_1.pers[var_0.sweapon + "_streakTime"] > 7000) {
    var_1.pers[var_0.sweapon + "_streak"] = 0;
    var_1.pers[var_0.sweapon + "_streakTime"] = gettime();
  }

  var_1.pers[var_0.sweapon + "_streak"]++;

  switch (var_0.sweapon) {
    case "artillery_mp":
      var_1 processchallenge("ch_carpetbomber");

      if(var_1.pers[var_0.sweapon + "_streak"] >= 5) {
        var_1 processchallenge("ch_carpetbomb");
      }

      if(isDefined(var_1.finalkill)) {
        var_1 processchallenge("ch_finishingtouch");
      }

      break;
    case "stealth_bomb_mp":
      var_1 processchallenge("ch_thespirit");

      if(var_1.pers[var_0.sweapon + "_streak"] >= 6) {
        var_1 processchallenge("ch_redcarpet");
      }

      if(isDefined(var_1.finalkill)) {
        var_1 processchallenge("ch_technokiller");
      }

      break;
    case "sentry_minigun_mp":
      var_1 processchallenge("ch_looknohands");

      if(isDefined(var_1.finalkill)) {
        var_1 processchallenge("ch_absentee");
      }

      break;
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "ac130_25mm_mp":
      var_1 processchallenge("ch_spectre");

      if(isDefined(var_1.finalkill)) {
        var_1 processchallenge("ch_deathfromabove");
      }

      break;
    case "remotemissile_projectile_mp":
      var_1 processchallenge("ch_predator");

      if(var_1.pers[var_0.sweapon + "_streak"] >= 4) {
        var_1 processchallenge("ch_reaper");
      }

      if(isDefined(var_1.finalkill)) {
        var_1 processchallenge("ch_dronekiller");
      }

      break;
    case "nuke_mp":
      var_0.victim processchallenge("ch_radiationsickness");
      break;
    default:
      break;
  }
}

ch_vehicle_killed(var_0) {
  if(!isDefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  var_1 = var_0.attacker;
  var_2 = maps\mp\_utility::getbaseweaponname(var_0.sweapon, 1);

  if(maps\mp\_utility::islootweapon(var_2)) {
    var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);
  }

  var_3 = get_challenge_weapon_class(var_0.sweapon, var_2);

  if(var_3 == "weapon_launcher") {
    var_1 processchallenge("ch_launcher_kill");

    if(isDefined(level.challengeinfo["ch_vehicle_" + var_2])) {
      var_1 processchallenge("ch_vehicle_" + var_2);
    }

    if(isDefined(level.challengeinfo["ch_marksman_" + var_2])) {
      var_1 processchallenge("ch_marksman_" + var_2);
    }
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_coldblooded") && var_1 maps\mp\_utility::_hasperk("specialty_spygame") && var_1 maps\mp\_utility::_hasperk("specialty_heartbreaker")) {
    if(!isDefined(var_0.vehicle) || !isDefined(var_0.vehicle.sentrytype) || var_0.vehicle.sentrytype != "prison_turret") {
      var_1 processchallenge("ch_precision_airhunt");
    }
  }

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle.vehicletype) && var_0.vehicle.vehicletype == "drone_recon" && issubstr(var_2, "exoknife")) {
    var_1 processchallenge("ch_precision_knife");
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_class_blindeye") && (!isDefined(var_0.vehicle.vehicleinfo) || var_0.vehicle.vehicleinfo != "vehicle_tracking_drone_mp")) {
    var_1 processchallenge("ch_perk_blindeye");
  }
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

  if(!isDefined(var_0.pers["MGStreak"])) {
    var_0.pers["MGStreak"] = 0;
    var_0 thread endmgstreakwhenleavemg();

    if(!isDefined(var_0.pers["MGStreak"])) {
      return;
    }
  }

  var_0.pers["MGStreak"]++;

  if(var_0.pers["MGStreak"] >= 5) {
    var_0 processchallenge("ch_mgmaster");
  }
}

endmgstreakwhenleavemg() {
  self endon("disconnect");

  for(;;) {
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
  if(!isDefined(self.pers["countermvp_streak"]) || !var_0) {
    self.pers["countermvp_streak"] = 0;
  }

  self.pers["countermvp_streak"]++;

  if(self.pers["countermvp_streak"] == 3) {
    processchallenge("ch_thebiggertheyare");
  } else if(self.pers["countermvp_streak"] == 5) {
    processchallenge("ch_thehardertheyfall");
  }

  if(self.pers["countermvp_streak"] >= 10) {
    processchallenge("ch_countermvp");
  }
}

ishighestscoringplayer(var_0) {
  if(!isDefined(var_0.score) || var_0.score < 1) {
    return 0;
  }

  var_1 = level.players;

  if(level.teambased) {
    var_2 = var_0.pers["team"];
  } else {
    var_2 = "all";
  }

  var_3 = var_0.score;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(!isDefined(var_1[var_4].score)) {
      continue;
    }
    if(var_1[var_4].score < 1) {
      continue;
    }
    if(var_2 != "all" && var_1[var_4].pers["team"] != var_2) {
      continue;
    }
    if(var_1[var_4].score > var_3) {
      return 0;
    }
  }

  return 1;
}

processchallengedaily(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::privatematch()) {
    return;
  }
  if(getdvarint("dailychallenge_killswitch", 0) == 0 && getdvarint("dailychallenge_killswitch2", 0) == 0) {
    return;
  }
  var_3 = self getplayerdata("dailyChallengeId", 0);
  var_4 = getdvarint("scr_current_playlist", 0);
  var_5 = getdvarint("scr_game_division", 0);
  var_6 = 0;
  var_6 = var_4 == 1 || var_4 == 2 || var_4 == 3 || var_4 == 4;
  var_7 = 0;
  var_7 = var_4 == 3;

  if(!isDefined(var_3) || !isDefined(var_0) || var_3 != var_0) {
    return;
  }
  switch (var_3) {
    case 1:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "war" && var_8 == "weapon_shotgun") {
        processchallenge("ch_daily_01");
      }

      break;
    case 2:
      if(level.gametype == "war") {
        processchallenge("ch_daily_02");
      }

      break;
    case 3:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "conf" && var_8 == "weapon_sniper") {
        processchallenge("ch_daily_03");
      }

      break;
    case 4:
      if(level.gametype == "conf") {
        processchallenge("ch_daily_04");
      }

      break;
    case 5:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "dom" && var_8 == "weapon_heavy") {
        processchallenge("ch_daily_05");
      }

      break;
    case 6:
      if(level.gametype == "dom") {
        processchallenge("ch_daily_06");
      }

      break;
    case 7:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "dom" && var_8 == "weapon_smg") {
        processchallenge("ch_daily_07");
      }

      break;
    case 8:
      var_8 = var_1;

      if(isDefined(var_8) && var_6 == 1 && var_8 == "weapon_smg") {
        processchallenge("ch_daily_08");
      }

      break;
    case 9:
      var_8 = var_1;

      if(isDefined(var_8) && var_6 == 1 && var_8 == "weapon_heavy") {
        processchallenge("ch_daily_09");
      }

      break;
    case 10:
      var_8 = var_1;

      if(isDefined(var_8) && var_6 == 1 && var_8 == "weapon_launcher") {
        processchallenge("ch_daily_10");
      }

      break;
    case 11:
      var_9 = var_1;

      if(isDefined(var_9) && var_6 == 1 && maps\mp\_utility::iskillstreakweapon(var_9)) {
        processchallenge("ch_daily_11");
      }

      break;
    case 12:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "ball" && var_8 == "weapon_shotgun") {
        processchallenge("ch_daily_12");
      }

      break;
    case 13:
      var_10 = var_1;

      if(isDefined(var_10) && level.gametype == "ball") {
        processchallenge("ch_daily_13", var_10);
      }

      break;
    case 14:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "hp" && var_8 == "weapon_smg") {
        processchallenge("ch_daily_14");
      }

      break;
    case 15:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "hp" && var_8 == "weapon_heavy") {
        processchallenge("ch_daily_15");
      }

      break;
    case 16:
      if(level.gametype == "ctf") {
        processchallenge("ch_daily_16");
      }

      break;
    case 17:
      if(level.gametype == "ctf") {
        processchallenge("ch_daily_17");
      }

      break;
    case 18:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "ctf" && var_8 == "weapon_smg") {
        processchallenge("ch_daily_18");
      }

      break;
    case 19:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "ctf" && var_8 == "weapon_heavy") {
        processchallenge("ch_daily_19");
      }

      break;
    case 20:
      var_9 = var_1;

      if(isDefined(var_9) && issubstr(var_9, "_lefthand")) {
        var_9 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");
      }

      if(isDefined(var_9) && level.gametype == "hp" && is_lethal_equipment(var_9)) {
        processchallenge("ch_daily_20");
      }

      break;
    case 21:
      if(level.gametype == "conf") {
        processchallenge("ch_daily_21");
      }

      break;
    case 22:
      var_11 = var_1;
      var_12 = 0;

      foreach(var_14 in self.ch_unique_earned_streaks) {
        if(var_14 == var_11) {
          var_12 = 1;
          break;
        }
      }

      if(var_12 == 0) {
        self.ch_unique_earned_streaks[self.ch_unique_earned_streaks.size] = var_11;
      }

      if(self.ch_unique_earned_streaks.size == 4) {
        processchallenge("ch_daily_22");
      }

      break;
    case 23:
      var_11 = var_1;

      if(isDefined(var_11) && var_11 == "orbital_carepackage") {
        processchallenge("ch_daily_23");
      }

      break;
    case 24:
      var_9 = var_1;

      if(isDefined(var_9)) {
        var_16 = getweaponattachments(var_9);

        if(level.gametype == "war" && maps\mp\_utility::iscacprimaryweapon(var_9) && var_16.size == 3) {
          processchallenge("ch_daily_24");
        }
      }

      break;
    case 25:
      if(level.gametype == "ctf") {
        processchallenge("ch_daily_25");
      }

      break;
    case 26:
      if(level.gametype == "dom") {
        processchallenge("ch_daily_26");
      }

      break;
    case 27:
      if(level.gametype == "conf") {
        processchallenge("ch_daily_27");
      }

      break;
    case 28:
      if(level.gametype == "ball") {
        processchallenge("ch_daily_28");
      }

      break;
    case 29:
      if(level.gametype == "twar") {
        processchallenge("ch_daily_29");
      }

      break;
    case 30:
      if(level.gametype == "hp") {
        processchallenge("ch_daily_30");
      }

      break;
    case 31:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "sd" && var_8 == "weapon_assault") {
        processchallenge("ch_daily_31");
      }

      break;
    case 32:
      var_11 = var_1;

      if(isDefined(var_11) && var_11 == "orbital_strike_laser") {
        processchallenge("ch_daily_32");
      }

      break;
    case 33:
      if(var_7 == 1) {
        processchallenge("ch_daily_33");
      }

      break;
    case 34:
      processchallenge("ch_daily_34");
      break;
    case 35:
      var_11 = var_1;

      if(isDefined(var_11) && var_11 == "missile_strike") {
        processchallenge("ch_daily_35");
      }

      break;
    case 36:
      if(var_6 == 1) {
        processchallenge("ch_daily_36");
      }

      break;
    case 37:
      if(var_5 == 1) {
        processchallenge("ch_daily_37");
      }

      break;
    case 38:
      processchallenge("ch_daily_38");
      break;
    case 39:
      var_8 = var_1;

      if(isDefined(var_8) && var_5 == 1 && var_8 == "weapon_smg") {
        processchallenge("ch_daily_39");
      }

      break;
    case 40:
      var_8 = var_1;

      if(isDefined(var_8) && var_5 == 1 && var_8 == "weapon_assault") {
        processchallenge("ch_daily_40");
      }

      break;
    case 41:
      var_17 = var_1;

      if(isDefined(var_17) && isDefined(self.lastslidetime) && var_17 - self.lastslidetime < 2000) {
        processchallenge("ch_daily_41");
      }

      break;
    case 42:
      if(level.gametype == "hp") {
        processchallenge("ch_daily_42");
      }

      break;
    case 43:
      var_9 = var_1;

      if(isDefined(var_9)) {
        if(issubstr(var_9, "_lefthand")) {
          var_9 = maps\mp\_utility::strip_suffix(var_9, "_lefthand");
        }

        if(level.gametype == "twar" && is_lethal_equipment(var_9)) {
          processchallenge("ch_daily_43");
        }
      }

      break;
    case 44:
      var_8 = var_1;

      if(isDefined(var_8) && level.gametype == "twar" && var_8 == "weapon_shotgun") {
        processchallenge("ch_daily_44");
      }

      break;
    case 45:
      var_9 = var_1;

      if(isDefined(var_9)) {
        var_16 = getweaponattachments(var_9);

        if(level.gametype == "ball" && maps\mp\_utility::iscacprimaryweapon(var_9) && var_16.size == 3) {
          processchallenge("ch_daily_45");
        }
      }

      break;
    default:
      break;
  }
}

ch_kills(var_0) {
  var_0.victim playerdied();

  if(!isDefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  } else {
    var_1 = var_0.attacker;
  }

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
  var_11 = getweaponattachments(var_0.sweapon);
  var_12 = 0;

  if(isDefined(var_1.pickedupweaponfrom[var_0.sweapon]) && !maps\mp\_utility::ismeleemod(var_9)) {
    var_12++;
  }

  var_13 = maps\mp\_utility::iskillstreakweapon(var_0.sweapon);
  var_14 = maps\mp\_utility::isenvironmentweapon(var_0.sweapon);
  var_15 = 0;

  if(var_9 == "MOD_HEAD_SHOT") {
    var_15 = 1;
  }

  var_16 = 0;
  var_17 = 0;

  if(isDefined(var_0.modifiers["longshot"])) {
    var_16 = 1;
    var_17++;
  }

  var_18 = var_0.was_ads;
  var_19 = 0;

  if(var_1.recentkillcount == 2) {
    var_19 = 1;
  }

  var_20 = 0;

  if(var_1.recentkillcount == 3) {
    var_20 = 1;
  }

  var_21 = "";

  if(isDefined(var_0.attackerstance)) {
    var_21 = var_0.attackerstance;
  }

  var_22 = 0;
  var_23 = 0;
  var_24 = 0;
  var_25 = 0;
  var_26 = 0;
  var_27 = 0;

  switch (var_1.killsthislife.size + 1) {
    case 5:
      var_22 = 1;
      break;
    case 10:
      var_23 = 1;
      break;
    case 15:
      var_24 = 1;
      break;
    case 20:
      var_25 = 1;
      break;
    case 25:
      var_26 = 1;
      break;
    case 30:
      var_27 = 1;
      break;
    default:
      break;
  }

  foreach(var_29 in var_1.killsthislife) {
    if(maps\mp\_utility::iscacsecondaryweapon(var_29.sweapon) && !maps\mp\_utility::ismeleemod(var_29.smeansofdeath)) {
      var_3++;
    }

    if(isDefined(var_29.modifiers["longshot"])) {
      var_17++;
    }

    if(var_17 == 3) {
      var_1 processchallenge("ch_precision_farsight");
    }

    if(var_10 - var_29.time < 10000) {
      var_4++;
    }

    if(isDefined(var_1.pickedupweaponfrom[var_29.sweapon]) && !maps\mp\_utility::ismeleemod(var_29.smeansofdeath)) {
      var_12++;

      if(var_12 == 5) {
        var_1 processchallenge("ch_humiliation_finders");
      }
    }

    if(maps\mp\_utility::iskillstreakweapon(var_29.sweapon)) {
      if(!isDefined(var_8[var_29.sweapon])) {
        var_8[var_29.sweapon] = 0;
      }

      var_8[var_29.sweapon]++;
      continue;
    }

    if(isDefined(level.onelefttime[var_1.team]) && var_29.time > level.onelefttime[var_1.team]) {
      var_2++;
    }

    if(isDefined(var_29.victim)) {
      if(!isDefined(var_5[var_29.victim.name]) && !isDefined(var_6[var_29.sweapon]) && !maps\mp\_utility::iskillstreakweapon(var_29.sweapon)) {
        var_7++;
      }

      var_5[var_29.victim.name] = var_29.victim.name;
    }

    var_6[var_29.sweapon] = var_29.sweapon;
  }

  var_31 = maps\mp\_utility::getbaseweaponname(var_0.sweapon, 1);

  if(maps\mp\_utility::islootweapon(var_31)) {
    var_31 = maps\mp\gametypes\_class::getbasefromlootversion(var_31);
  }

  var_32 = var_31;

  if(common_scripts\utility::string_starts_with(var_31, "iw5_")) {
    var_32 = getsubstr(var_31, 4);
  }

  var_33 = get_challenge_weapon_class(var_0.sweapon, var_31);

  if(level.teambased) {
    if(level.teamcount[var_0.victim.pers["team"]] > 3 && var_1.killedplayers.size >= level.teamcount[var_0.victim.pers["team"]]) {
      var_1 processchallenge("ch_precision_cleanhouse");
    }
  }

  if(isDefined(var_1.explosive_drone_owner) && var_0.victim == var_1.explosive_drone_owner) {
    var_1 processchallenge("ch_precision_protected");
  }

  if(isDefined(var_1.powerslidetime) && var_10 - var_1.powerslidetime < 3000) {
    var_1 processchallenge("ch_boot_hero");
  }

  var_34 = undefined;

  if(maps\mp\_utility::isstrstart(var_0.sweapon, "alt_")) {
    var_34 = getsubstr(var_0.sweapon, 4);
  }

  if(isDefined(var_1.pickedupweaponfrom[var_0.sweapon]) || isDefined(var_34) && isDefined(var_1.pickedupweaponfrom[var_34])) {
    if(!maps\mp\_utility::ismeleemod(var_9)) {
      var_1 processchallenge("ch_boot_stolen");
    }
  }

  if(var_21 == "crouch") {
    var_1 processchallenge("ch_boot_crouch");
  }

  if(var_21 == "prone") {
    var_1 processchallenge("ch_boot_prone");
  }

  if(var_0.victim != var_0.attacker) {
    foreach(var_36 in var_1.loadoutwildcards) {
      var_37 = undefined;
      var_38 = 0;

      if(var_36 == "specialty_wildcard_perkslot1") {
        var_38 = 1;
        var_37 = ["specialty_extended_battery", "specialty_class_lowprofile", "specialty_class_flakjacket", "specialty_class_lightweight", "specialty_class_dangerclose"];
      }

      if(var_36 == "specialty_wildcard_perkslot2") {
        var_38 = 2;
        var_37 = ["specialty_class_blindeye", "specialty_class_coldblooded", "specialty_class_peripherals", "specialty_class_fasthands", "specialty_class_dexterity"];
      }

      if(var_36 == "specialty_wildcard_perkslot3") {
        var_38 = 3;
        var_37 = ["specialty_class_hardwired", "specialty_class_toughness", "specialty_class_scavenger", "specialty_class_hardline", "specialty_exo_blastsuppressor"];
      }

      if(isDefined(var_37) && var_38 > 0) {
        var_39 = 0;

        foreach(var_41 in var_1.loadoutperks) {
          if(common_scripts\utility::array_contains(var_37, var_41)) {
            var_39++;
          }
        }

        if(var_39 >= 2 && var_38 == 1 && var_36 == "specialty_wildcard_perkslot1") {
          var_1 processchallenge("ch_wild_perk1");
        }

        if(var_39 >= 2 && var_38 == 2 && var_36 == "specialty_wildcard_perkslot2") {
          var_1 processchallenge("ch_wild_perk2");
        }

        if(var_39 >= 2 && var_38 == 3 && var_36 == "specialty_wildcard_perkslot3") {
          var_1 processchallenge("ch_wild_perk3");
        }
      }

      if(var_36 == "specialty_wildcard_primaryattachment" || var_36 == "specialty_wildcard_secondaryattachment") {
        if(var_36 == "specialty_wildcard_primaryattachment" && maps\mp\_utility::iscacprimaryweapon(var_0.sweapon) && var_11.size >= 3) {
          var_1 processchallenge("ch_wild_primary");
        }

        if(var_36 == "specialty_wildcard_secondaryattachment" && maps\mp\_utility::iscacsecondaryweapon(var_0.sweapon) && var_11.size >= 2) {
          var_1 processchallenge("ch_wild_secondary");
        }
      }

      if(var_36 == "specialty_wildcard_dualprimaries") {
        var_43 = var_1.loadoutprimary;
        var_44 = var_1.loadoutsecondary;

        if(!maps\mp\_utility::iscacprimaryweapon(var_43) || !maps\mp\_utility::iscacprimaryweapon(var_44)) {
          continue;
        }
        var_45 = maps\mp\_utility::getbaseweaponname(var_0.sweapon);
        var_46 = undefined;

        if(var_45 == var_43) {
          var_46 = var_44;
        } else if(var_45 == var_44) {
          var_46 = var_43;
        } else {
          continue;
        }

        var_47 = var_1.killsthislife;
        var_48 = 0;
        var_49 = 0;

        foreach(var_51 in var_47) {
          if(maps\mp\_utility::getbaseweaponname(var_51.sweapon) == var_46) {
            var_48 = 1;
          }

          if(maps\mp\_utility::getbaseweaponname(var_51.sweapon) == var_45) {
            var_49 = 1;
          }
        }

        if(var_48 && !var_49) {
          var_1 processchallenge("ch_wild_overkill");
          var_1 processchallengedaily(2, var_31, var_33);
          var_1 processchallengedaily(42, var_31, var_33);
        }
      }

      if(var_36 == "specialty_wildcard_dualtacticals") {
        if(maps\mp\_utility::is_exo_ability_weapon(var_1.loadoutequipment) && maps\mp\_utility::is_exo_ability_weapon(var_1.loadoutoffhand)) {
          var_1 processchallenge("ch_wild_exotac");
        }
      }

      if(var_36 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode()) {
        if(maps\mp\gametypes\_weapons::isgrenade(var_0.sweapon) && !issubstr(var_0.sweapon, "exoknife_mp")) {
          if(var_1.loadoutequipment != "specialty_null" && maps\mp\gametypes\_class::isvalidequipment(var_1.loadoutequipment, 0) && var_1.loadoutoffhand != "specialty_null" && maps\mp\gametypes\_class::isvalidequipment(var_1.loadoutoffhand, 0)) {
            var_1 processchallenge("ch_wild_exobomb");
          }
        }
      }

      if(var_36 == "specialty_wildcard_extrastreak") {
        if(!var_13) {
          continue;
        }
        if(var_1.killstreaks.size < 4) {
          continue;
        }
        var_1 processchallenge("ch_wild_fourthscore");
      }
    }
  }

  if(var_0.victim != var_0.attacker) {
    var_54 = !level.teambased || var_0.victim.team != var_0.attacker.team;

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_lowprofile")) {
      var_55 = 0;

      if(isDefined(level.uavmodels)) {
        if(level.teambased) {
          var_55 = level.uavmodels[maps\mp\_utility::getotherteam(var_0.attacker.team)].size;
        } else if(level.uavmodels.size > 0) {
          var_56 = 0;

          foreach(var_58 in level.uavmodels) {
            if(var_58.owner == var_1) {
              var_56++;
            }
          }

          if(var_56 > 0) {
            var_55 = level.uavmodels.size - var_56;
          } else {
            var_55 = level.uavmodels.size;
          }
        }
      }

      if(var_55 > 0) {
        var_1 processchallenge("ch_perk_lowprofile");
      }
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_quickdraw") && var_1 adsbuttonpressed()) {
      var_1 processchallenge("ch_perk_quickdraw");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_lightweight")) {
      var_1 processchallenge("ch_perk_lightweight");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_coldblooded")) {
      var_1 processchallenge("ch_perk_coldblood");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_peripherals")) {
      var_1 processchallenge("ch_perk_peripheral");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_dexterity") && (var_1 issprinting() || var_1 ispowersliding())) {
      var_1 processchallenge("ch_perk_gungho");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor")) {
      var_1 processchallenge("ch_perk_blast");
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_hardwired")) {
      var_60 = 0;

      if(isDefined(level.uavmodels)) {
        if(level.teambased) {
          foreach(var_58 in level.uavmodels[maps\mp\_utility::getotherteam(var_1.team)]) {
            if(var_58.uavtype == "counter") {
              var_60 = 1;
              break;
            }
          }

          if(isDefined(level.empowner) && level.empowner.team != var_1.team) {
            var_60 = 1;
          }
        } else {
          foreach(var_58 in level.uavmodels) {
            if(var_58.uavtype == "counter" && !(var_58.owner == var_1)) {
              var_60 = 1;
              break;
            }
          }
        }
      }

      if(var_60) {
        var_1 processchallenge("ch_perk_hardwire");
      }
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_fasthands")) {
      if(isDefined(var_1.lastprimaryweaponswaptime) && gettime() - var_1.lastprimaryweaponswaptime < 5000) {
        var_1 processchallenge("ch_perk_fasthand");
      }
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_toughness")) {
      if(isDefined(var_1.lastdamagefromenemytargettime) && gettime() - var_1.lastdamagefromenemytargettime < 2000) {
        var_1 processchallenge("ch_perk_tough");
      }
    }

    if(var_54 && var_1 maps\mp\_utility::_hasperk("specialty_class_scavenger") && isDefined(var_1.hasscavengedammothislife) && var_1.hasscavengedammothislife == 1) {
      var_1 processchallenge("ch_perk_scavenge");
    }
  }

  if(var_10 < var_0.victim.concussionendtime) {
    var_1 processchallenge("ch_exolauncher_stun");
  }

  if(isDefined(var_0.victim.inplayersmokescreen)) {
    var_1 processchallenge("ch_exolauncher_smoke");
  }

  foreach(var_66 in var_0.victim._threatdetection.showlist) {
    if(var_66.eventtype == "PAINT_GRENADE" && var_10 < var_66.endtime) {
      var_1 processchallenge("ch_exolauncher_threat");
      break;
    }
  }

  if(isDefined(var_0.victim.empgrenaded) && (var_0.victim.empgrenaded == 1 || var_10 < var_0.victim.empendtime)) {
    var_1 processchallenge("ch_exolauncher_emp");
  }

  if(isDefined(var_0.victim.died_being_tracked) && var_0.victim.died_being_tracked == 1) {
    var_0.victim.died_being_tracked = undefined;
    var_1 processchallenge("ch_exolauncher_tracking");
  }

  if((var_1.loadoutequipment == "adrenaline_mp" || var_1.loadoutoffhand == "adrenaline_mp") && var_1.overclock_on == 1) {
    var_1 processchallenge("ch_exoability_overclock");
  }

  if(var_1.loadoutequipment == "exocloak_equipment_mp" || var_1.loadoutoffhand == "exocloak_equipment_mp") {
    if(var_1.exo_cloak_on == 1 || isDefined(var_1.exo_cloak_off_time) && var_0.time < var_1.exo_cloak_off_time + 3000) {
      var_1 processchallenge("ch_exoability_cloak");
    }
  }

  if((var_1.loadoutequipment == "exohover_equipment_mp" || var_1.loadoutoffhand == "exohover_equipment_mp") && var_1.exo_hover_on == 1) {
    var_1 processchallenge("ch_exoability_hover");
  }

  if((var_1.loadoutequipment == "exomute_equipment_mp" || var_1.loadoutoffhand == "exomute_equipment_mp") && var_1.mute_on == 1) {
    var_1 processchallenge("ch_exoability_mute");
  }

  if((var_1.loadoutequipment == "extra_health_mp" || var_1.loadoutoffhand == "extra_health_mp") && var_1.exo_health_on == 1) {
    if(isDefined(var_0.attacker.lastdamagedtime) && var_0.time < var_0.attacker.lastdamagedtime + 4000) {
      var_1 processchallenge("ch_exoability_health");
    }
  }

  foreach(var_69 in var_11) {
    switch (var_69) {
      case "opticsacog2ar":
      case "opticsacog2":
        if(var_18) {
          var_1 processchallenge("ch_attach_kill_opticsacog2");
        }

        break;
      case "opticstargetenhancer":
      case "variablereddot":
      case "opticseotech":
      case "opticsreddot":
      case "ironsights":
        if(var_18) {
          var_1 processchallenge("ch_attach_kill_" + var_69);
        }

        break;
      case "heatsink":
      case "trackrounds":
      case "lasersight":
      case "stock":
      case "quickdraw":
      case "longrange":
      case "firerate":
      case "foregrip":
      case "parabolicmicrophone":
      case "dualmag":
      case "xmags":
      case "akimbo":
        var_1 processchallenge("ch_attach_kill_" + var_69);
        break;
      case "opticsthermalar":
      case "opticsthermal":
        var_1 processchallenge("ch_attach_kill_opticsthermal");
        break;
      case "silencersniper":
      case "silencerpistol":
      case "silencer01":
        var_1 processchallenge("ch_attach_kill_silencer01");
        break;
      case "thorstabilizer":
      case "m990stabilizer":
      case "gm6stabilizer":
      case "morsstabilizer":
      case "stabilizer":
        var_1 processchallenge("ch_attach_kill_stabilizer");
        break;
      case "m990scopevz":
      case "thorscopevz":
      case "gm6scopevz":
      case "morsscopevz":
      case "scopevz":
        var_1 processchallenge("ch_attach_kill_scopevz");
        break;
    }
  }

  if((var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT" || var_31 == "iw5_m990") && !var_14 && !var_13) {
    switch (var_33) {
      case "weapon_smg":
        var_1 processchallenge("ch_smg_kill");

        if(var_15) {
          var_1 processchallenge("ch_smg_headshot");
        }

        break;
      case "weapon_assault":
        var_1 processchallenge("ch_ar_kill");

        if(var_15) {
          var_1 processchallenge("ch_ar_headshot");
        }

        break;
      case "weapon_shotgun":
        var_1 processchallenge("ch_shotgun_kill");

        if(var_15) {
          var_1 processchallenge("ch_shotgun_headshot");
        }

        break;
      case "weapon_sniper":
        var_1 processchallenge("ch_sniper_kill");

        if(var_15) {
          var_1 processchallenge("ch_sniper_headshot");
        }

        break;
      case "weapon_pistol":
        var_1 processchallenge("ch_pistol_kill");

        if(var_15) {
          var_1 processchallenge("ch_pistol_headshot");
        }

        break;
      case "weapon_heavy":
        var_1 processchallenge("ch_heavy_kill");

        if(var_15) {
          var_1 processchallenge("ch_heavy_headshot");
        }

        break;
      case "weapon_special":
        var_1 processchallenge("ch_special_kill");
        break;
      default:
        break;
    }

    if(var_9 == "MOD_HEAD_SHOT") {
      if(var_33 == "weapon_pistol") {
        var_1 notify("increment_pistol_headshots");
      } else if(var_33 == "weapon_assault") {
        var_1 notify("increment_ar_headshots");
      }
    }

    switch (var_31) {
      case "iw5_dlcgun6":
        var_1 processchallenge("ch_marksman_iw5_dlcgun5");
        break;
      case "iw5_dlcgun6loot5":
        var_1 processchallenge("ch_marksman_iw5_dlcgun6");
        break;
      case "iw5_dlcgun7loot0":
        var_1 processchallenge("ch_marksman_iw5_dlcgun7");
        break;
      case "iw5_dlcgun7loot6":
        var_1 processchallenge("ch_marksman_iw5_dlcgun8");
        break;
      case "iw5_dlcgun8loot1":
        var_1 processchallenge("ch_marksman_iw5_dlcgun9");
        break;
      case "iw5_dlcgun13":
        var_1 processchallenge("ch_marksman_iw5_dlcgun10");
        break;
      case "iw5_dlcgun18":
        var_1 processchallenge("ch_marksman_iw5_dlcgun11");
        break;
      case "iw5_dlcgun23":
        var_1 processchallenge("ch_marksman_iw5_dlcguna");
        break;
      case "iw5_dlcgun28":
        var_1 processchallenge("ch_marksman_iw5_dlcgunb");
        break;
      case "iw5_dlcgun33":
        var_1 processchallenge("ch_marksman_iw5_dlcgunc");
        break;
      case "iw5_dlcgun38":
        var_1 processchallenge("ch_marksman_iw5_dlcgund");
        break;
      default:
        var_1 processchallenge("ch_marksman_" + var_31);
        break;
    }
  } else if(issubstr(var_31, "microdronelauncher") && !maps\mp\_utility::ismeleemod(var_9)) {
    var_1 processchallenge("ch_marksman_" + var_31);
  } else if(issubstr(var_31, "exocrossbow") && !maps\mp\_utility::ismeleemod(var_9)) {
    var_1 processchallenge("ch_marksman_" + var_31);
  }

  if(issubstr(var_0.sweapon, "iw5_dlcgun12loot7_mp")) {
    var_1 processchallenge("ch_tier2_1_iw5_dlcgun12");
  }

  if(isDefined(var_1.last_grapple_time)) {
    var_71 = var_10 - var_1.last_grapple_time;
    var_72 = undefined;

    if(isDefined(var_1.last_grapple_time_prev)) {
      var_72 = var_10 - var_1.last_grapple_time_prev;
    }

    if(var_71 < 0 && isDefined(var_72)) {
      if(var_72 < 2000) {
        var_1 processchallenge("ch_tier2_3_iw5_dlcgun12");
      }
    } else if(var_71 < 2000 && var_71 > 0) {
      var_1 processchallenge("ch_tier2_3_iw5_dlcgun12");
    }
  }

  var_1 processchallengedaily(1, var_33, undefined);
  var_1 processchallengedaily(3, var_33, undefined);
  var_1 processchallengedaily(5, var_33, undefined);
  var_1 processchallengedaily(7, var_33, undefined);
  var_1 processchallengedaily(8, var_33, undefined);
  var_1 processchallengedaily(9, var_33, undefined);
  var_1 processchallengedaily(12, var_33, undefined);
  var_1 processchallengedaily(14, var_33, undefined);
  var_1 processchallengedaily(15, var_33, undefined);
  var_1 processchallengedaily(18, var_33, undefined);
  var_1 processchallengedaily(19, var_33, undefined);
  var_1 processchallengedaily(24, var_0.sweapon, undefined);
  var_1 processchallengedaily(31, var_33, undefined);
  var_1 processchallengedaily(33, undefined, undefined);
  var_1 processchallengedaily(39, var_33, undefined);
  var_1 processchallengedaily(40, var_33, undefined);
  var_1 processchallengedaily(41, var_10, undefined);
  var_1 processchallengedaily(44, var_33, undefined);
  var_1 processchallengedaily(45, var_0.sweapon, undefined);
  var_1 processchallengedaily(20, var_0.sweapon, undefined);
  var_1 processchallengedaily(43, var_0.sweapon, undefined);
  var_1 processchallengedaily(11, var_0.sweapon, undefined);

  if((var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT" || var_31 == "iw5_m990") && !var_14 && !var_13) {
    switch (var_33) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        switch (var_31) {
          case "iw5_dlcgun4":
          case "iw5_dlcgun3":
          case "iw5_dlcgun1":
          case "iw5_dlcgun2":
            var_1 processchallenge("ch_attach_unlock_type1_" + var_32);
            break;
          case "iw5_dlcgun6":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun5");
            break;
          case "iw5_dlcgun6loot5":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun6");
            break;
          case "iw5_dlcgun7loot0":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun7");
            break;
          case "iw5_dlcgun7loot6":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun8");
            break;
          case "iw5_dlcgun8loot1":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun9");
            break;
          case "iw5_dlcgun13":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun10");
            break;
          case "iw5_dlcgun18":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgun11");
            break;
          case "iw5_dlcgun23":
            var_1 processchallenge("ch_attach_unlock_type1_dlcguna");
            break;
          case "iw5_dlcgun28":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgunb");
            break;
          case "iw5_dlcgun33":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgunc");
            break;
          case "iw5_dlcgun38":
            var_1 processchallenge("ch_attach_unlock_type1_dlcgund");
            break;
          default:
            var_1 processchallenge("ch_attach_unlock_kills_" + var_32);
            break;
        }

        if(var_18) {
          switch (var_31) {
            case "iw5_dlcgun4":
            case "iw5_dlcgun3":
            case "iw5_dlcgun1":
            case "iw5_dlcgun2":
              var_1 processchallenge("ch_attach_unlock_type3_" + var_32);
              break;
            case "iw5_dlcgun6":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun5");
              break;
            case "iw5_dlcgun6loot5":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun6");
              break;
            case "iw5_dlcgun7loot0":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun7");
              break;
            case "iw5_dlcgun7loot6":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun8");
              break;
            case "iw5_dlcgun8loot1":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun9");
              break;
            case "iw5_dlcgun13":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun10");
              break;
            case "iw5_dlcgun18":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgun11");
              break;
            case "iw5_dlcgun23":
              var_1 processchallenge("ch_attach_unlock_type3_dlcguna");
              break;
            case "iw5_dlcgun28":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgunb");
              break;
            case "iw5_dlcgun33":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgunc");
              break;
            case "iw5_dlcgun38":
              var_1 processchallenge("ch_attach_unlock_type3_dlcgund");
              break;
            default:
              var_1 processchallenge("ch_attach_unlock_ads_" + var_32);
              break;
          }
        } else {
          switch (var_31) {
            case "iw5_dlcgun4":
            case "iw5_dlcgun3":
            case "iw5_dlcgun1":
            case "iw5_dlcgun2":
              var_1 processchallenge("ch_attach_unlock_type2_" + var_32);
              break;
            case "iw5_dlcgun6":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgun5");
              break;
            case "iw5_dlcgun7loot0":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgun7");
              break;
            case "iw5_dlcgun7loot6":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgun8");
              break;
            case "iw5_dlcgun13":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgun10");
              break;
            case "iw5_dlcgun18":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgun11");
              break;
            case "iw5_dlcgun23":
              var_1 processchallenge("ch_attach_unlock_type2_dlcguna");
              break;
            case "iw5_dlcgun28":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgunb");
              break;
            case "iw5_dlcgun33":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgunc");
              break;
            case "iw5_dlcgun38":
              var_1 processchallenge("ch_attach_unlock_type2_dlcgund");
              break;
            default:
              var_1 processchallenge("ch_attach_unlock_hipfirekills_" + var_32);
              break;
          }
        }
      default:
        break;
    }

    if(var_9 == "MOD_HEAD_SHOT") {
      switch (var_31) {
        case "iw5_dlcgun6loot5":
          var_1 processchallenge("ch_attach_unlock_type2_dlcgun6");
          break;
        default:
          var_1 processchallenge("ch_attach_unlock_headShots_" + var_32);
          break;
      }
    }
  }

  if(isDefined(var_1.riotshieldentity)) {
    if(var_10 - var_1.riotshieldentity.birthtime < 3000) {
      var_1 processchallenge("ch_attach_unlock_postplant_riotshieldt6");
    }
  }

  if(maps\mp\_utility::ismeleemod(var_9) && !var_14 && !var_13) {
    if(!issubstr(var_31, "riotshield")) {
      var_1.pers["meleeKillStreak"]++;

      foreach(var_69 in var_11) {
        if(var_69 == "tactical") {
          var_1 processchallenge("ch_attach_kill_tactical");
        }
      }
    } else if(issubstr(var_31, "riotshield")) {
      if(var_31 == "iw5_riotshieldt6") {
        var_1 processchallenge("ch_attach_unlock_meleekills_riotshieldt6");
        var_1 processchallenge("ch_marksman_iw5_riotshieldt6");
        var_1 processchallenge("ch_special_kill");
        var_1.pers["shieldKillStreak"]++;
      }
    }

    if(issubstr(var_31, "exoshield")) {
      var_1 processchallenge("ch_exoability_shield");
    }

    if(issubstr(var_31, "combatknife")) {
      var_1 notify("increment_knife_kill");
    }
  }

  if(issubstr(var_9, "MOD_IMPACT") && !var_14 && !var_13) {
    if(issubstr(var_0.sweapon, "exoknife_mp")) {
      var_1 notify("increment_knife_kill");
      var_1 processchallenge("ch_exolauncher_knife");

      if(var_16) {
        var_1 processchallenge("ch_humiliation_hailmary");
      }

      foreach(var_36 in var_1.loadoutwildcards) {
        if(var_36 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode()) {
          var_76 = maps\mp\_utility::strip_suffix(var_1.loadoutequipment, "_lefthand");
          var_77 = maps\mp\_utility::strip_suffix(var_1.loadoutoffhand, "_lefthand");

          if(is_lethal_equipment(var_76) && is_lethal_equipment(var_77)) {
            var_1 notify("increment_duallethal_kills");
          }

          break;
        }
      }
    }

    if(var_31 == "iw5_microdronelauncher" && isDefined(level.challengeinfo["ch_impact_iw5_microdronelauncher"])) {
      var_1 processchallenge("ch_impact_iw5_microdronelauncher");
    }

    if(var_31 == "iw5_exocrossbow") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_kills_" + var_32])) {
        var_1 processchallenge("ch_attach_unlock_kills_" + var_32);
      }

      if(var_18) {
        if(isDefined(level.challengeinfo["ch_attach_unlock_ads_" + var_32])) {
          var_1 processchallenge("ch_attach_unlock_ads_" + var_32);
        }
      }
    }
  }

  if(issubstr(var_9, "MOD_GRENADE") || issubstr(var_9, "MOD_PROJECTILE") || issubstr(var_9, "MOD_EXPLOSIVE") && !var_14 && !var_13) {
    switch (var_33) {
      case "weapon_special":
        var_1 processchallenge("ch_special_kill");
        break;
      default:
    }

    if(var_31 == "iw5_exocrossbow") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_kills_" + var_32])) {
        var_1 processchallenge("ch_attach_unlock_kills_" + var_32);
      }

      if(var_18) {
        if(isDefined(level.challengeinfo["ch_attach_unlock_ads_" + var_32])) {
          var_1 processchallenge("ch_attach_unlock_ads_" + var_32);
        }
      }
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "frag_")) {
      var_1 processchallenge("ch_exolauncher_frag");

      if(var_0.victim.explosiveinfo["cookedKill"]) {
        var_1 processchallenge("ch_precision_masterchef");
      }

      if(var_0.victim.explosiveinfo["throwbackKill"]) {
        var_1 processchallenge("ch_precision_return");
      }
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "semtex_")) {
      var_1 processchallenge("ch_exolauncher_semtex");
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "explosive_drone")) {
      var_1 processchallenge("ch_exolauncher_explosive_drone");
    }

    if(isDefined(var_0.einflictor.classname) && var_0.einflictor.classname == "scriptable") {
      var_1 processchallenge("ch_boot_vandalism");
      var_1 processchallenge("ch_precision_sitaware");
    }

    if(isDefined(var_0.sweapon) && var_0.sweapon == "mp_lab_gas_explosion") {
      var_1 processchallenge("ch_precision_sitaware");
    }

    if(issubstr(var_0.sweapon, "frag") || issubstr(var_0.sweapon, "semtex") || issubstr(var_0.sweapon, "explosive_drone")) {
      foreach(var_36 in var_1.loadoutwildcards) {
        if(var_36 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode()) {
          var_76 = maps\mp\_utility::strip_suffix(var_1.loadoutequipment, "_lefthand");
          var_77 = maps\mp\_utility::strip_suffix(var_1.loadoutoffhand, "_lefthand");

          if(is_lethal_equipment(var_76) && is_lethal_equipment(var_77)) {
            var_1 notify("increment_duallethal_kills");
          }

          break;
        }
      }
    }

    if(maps\mp\_utility::isplayeronenemyteam(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_class_dangerclose")) {
      var_1 processchallenge("ch_perk_dangerclose");
    }
  }

  foreach(var_69 in var_11) {
    switch (var_69) {
      case "gl":
        if(isDefined(level.challengeinfo["ch_attach_kill_" + var_69])) {
          var_1 processchallenge("ch_attach_kill_" + var_69);
        }

        break;
    }
  }

  if(issubstr(var_9, "MOD_EXPLOSIVE") && var_0.sweapon == "airdrop_trap_explosive_mp") {
    var_1 processchallenge("ch_precision_surprise");
  }

  if(!maps\mp\_utility::ismeleemod(var_9) && (var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT" || var_31 == "iw5_microdronelauncher" || var_31 == "iw5_exocrossbow" || var_31 == "iw5_m990")) {
    if(var_16) {
      if(var_33 == "weapon_assault" || var_33 == "weapon_sniper" || var_31 == "iw5_exocrossbow" || var_33 == "weapon_heavy") {
        switch (var_31) {
          case "iw5_dlcgun1":
          case "iw5_dlcgun2":
            var_1 processchallenge("ch_tier1_1_" + var_31);
            break;
          case "iw5_dlcgun6":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgun5");
            break;
          case "iw5_dlcgun6loot5":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgun6");
            break;
          case "iw5_dlcgun7loot0":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgun7");
            break;
          case "iw5_dlcgun7loot6":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgun8");
            break;
          case "iw5_dlcgun23":
            var_1 processchallenge("ch_tier1_1_iw5_dlcguna");
            break;
          case "iw5_dlcgun33":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgunc");
            break;
          default:
            var_1 processchallenge("ch_longshot_" + var_31);
            break;
        }
      }
    }

    if(!var_18) {
      if(var_33 == "weapon_shotgun" || var_33 == "weapon_smg" || var_33 == "weapon_heavy" || var_31 == "iw5_microdronelauncher") {
        switch (var_31) {
          case "iw5_dlcgun4":
          case "iw5_dlcgun2":
            var_1 processchallenge("ch_tier1_2_" + var_31);
            break;
          case "iw5_dlcgun8loot1":
            var_1 processchallenge("ch_tier1_2_iw5_dlcgun9");
            break;
          case "iw5_dlcgun18":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgun11");
            break;
          case "iw5_dlcgun28":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgunb");
            break;
          case "iw5_dlcgun38":
            var_1 processchallenge("ch_tier1_1_iw5_dlcgund");
            break;
          default:
            var_1 processchallenge("ch_hip_" + var_31);
            break;
        }
      }
    }

    if(issubstr(var_31, "iw5_exocrossbow")) {
      if(!var_18) {
        var_1 processchallenge("ch_hip_iw5_exocrossbow");
      }
    }

    if(var_15) {
      switch (var_33) {
        case "weapon_pistol":
        case "weapon_special":
        case "weapon_shotgun":
        case "weapon_sniper":
        case "weapon_assault":
        case "weapon_smg":
          switch (var_31) {
            case "iw5_dlcgun3":
            case "iw5_dlcgun1":
              var_1 processchallenge("ch_tier1_2_" + var_31);
              break;
            case "iw5_dlcgun6":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun5");
              break;
            case "iw5_dlcgun6loot5":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun6");
              break;
            case "iw5_dlcgun7loot0":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun7");
              break;
            case "iw5_dlcgun7loot6":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun8");
              break;
            case "iw5_dlcgun13":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun10");
              break;
            case "iw5_dlcgun18":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgun11");
              break;
            case "iw5_dlcgun23":
              var_1 processchallenge("ch_tier1_2_iw5_dlcguna");
              break;
            case "iw5_dlcgun28":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgunb");
              break;
            case "iw5_dlcgun33":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgunc");
              break;
            case "iw5_dlcgun38":
              var_1 processchallenge("ch_tier1_2_iw5_dlcgund");
              break;
            default:
              var_1 processchallenge("ch_headshot_" + var_31);
              break;
          }

          break;
      }
    }

    if(var_31 == "iw5_microdronelauncher") {
      if(isDefined(level.challengeinfo["ch_kills_iw5_microdronelauncher"])) {
        var_1 processchallenge("ch_kills_iw5_microdronelauncher");
      }
    }
  }

  if(!maps\mp\_utility::ismeleemod(var_9) && var_33 == "weapon_launcher") {
    if(isDefined(level.challengeinfo["ch_kills_" + var_31])) {
      var_1 processchallenge("ch_kills_" + var_31);
    }

    var_1 processchallengedaily(10, var_33, undefined);

    if(issubstr(var_0.victim.model, "npc_exo_armor_mp_base")) {
      var_1 processchallenge("ch_launcher_kill");

      if(isDefined(level.challengeinfo["ch_vehicle_" + var_31])) {
        var_1 processchallenge("ch_vehicle_" + var_31);
      }

      if(isDefined(level.challengeinfo["ch_goliath_" + var_31])) {
        var_1 processchallenge("ch_goliath_" + var_31);
      }
    }
  }

  if(var_22 || var_23 || var_24 || var_25 || var_26 || var_27) {
    if(var_33 == "weapon_sniper") {
      switch (var_31) {
        case "iw5_dlcgun6loot5":
          var_1 processchallenge("ch_tier2_2_iw5_dlcgun6");
          break;
        default:
          var_1 processchallenge("ch_blood_" + var_31);
          break;
      }
    } else if(var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_31 == "iw5_microdronelauncher") {
      switch (var_31) {
        case "iw5_dlcgun1":
        case "iw5_dlcgun2":
          var_1 processchallenge("ch_tier2_2_" + var_31);
          break;
        case "iw5_dlcgun6":
          var_1 processchallenge("ch_tier2_2_iw5_dlcgun5");
          break;
        case "iw5_dlcgun7loot0":
          var_1 processchallenge("ch_tier2_2_iw5_dlcgun7");
          break;
        case "iw5_dlcgun7loot6":
          var_1 processchallenge("ch_tier2_2_iw5_dlcgun8");
          break;
        case "iw5_dlcgun23":
          var_1 processchallenge("ch_tier2_2_iw5_dlcguna");
          break;
        case "iw5_dlcgun33":
          var_1 processchallenge("ch_tier2_2_iw5_dlcgunc");
          break;
        default:
          var_1 processchallenge("ch_triple_" + var_31);
          break;
      }
    }
  }

  if(var_11.size == 0) {
    if(!issubstr(var_9, "MOD_MELEE")) {
      switch (var_33) {
        case "weapon_pistol":
        case "weapon_special":
        case "weapon_heavy":
        case "weapon_shotgun":
        case "weapon_sniper":
        case "weapon_assault":
        case "weapon_smg":
          switch (var_31) {
            case "iw5_dlcgun4":
            case "iw5_dlcgun3":
            case "iw5_dlcgun1":
            case "iw5_dlcgun2":
              var_1 processchallenge("ch_tier2_4_" + var_31);
              break;
            case "iw5_dlcgun6":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun5");
              break;
            case "iw5_dlcgun6loot5":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun6");
              break;
            case "iw5_dlcgun7loot0":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun7");
              break;
            case "iw5_dlcgun7loot6":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun8");
              break;
            case "iw5_dlcgun8loot1":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun9");
              break;
            case "iw5_dlcgun13":
              var_1 processchallenge("ch_tier2_3_iw5_dlcgun10");
              break;
            case "iw5_dlcgun18":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgun11");
              break;
            case "iw5_dlcgun23":
              var_1 processchallenge("ch_tier2_4_iw5_dlcguna");
              break;
            case "iw5_dlcgun28":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgunb");
              break;
            case "iw5_dlcgun33":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgunc");
              break;
            case "iw5_dlcgun38":
              var_1 processchallenge("ch_tier2_4_iw5_dlcgund");
              break;
            default:
              var_1 processchallenge("ch_barebone_" + var_31);
              break;
          }

          break;
      }
    }
  }

  var_83 = 0;

  foreach(var_85 in var_1.loadoutperks) {
    if(var_85 == "specialty_null") {
      var_83++;
      continue;
    }

    break;
  }

  if(var_83 == 6 && !maps\mp\_utility::ismeleemod(var_9)) {
    switch (var_33) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        switch (var_31) {
          case "iw5_dlcgun4":
          case "iw5_dlcgun3":
          case "iw5_dlcgun1":
          case "iw5_dlcgun2":
            var_1 processchallenge("ch_tier2_5_" + var_31);
            break;
          case "iw5_dlcgun6":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun5");
            break;
          case "iw5_dlcgun6loot5":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun6");
            break;
          case "iw5_dlcgun7loot0":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun7");
            break;
          case "iw5_dlcgun7loot6":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun8");
            break;
          case "iw5_dlcgun8loot1":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun9");
            break;
          case "iw5_dlcgun13":
            var_1 processchallenge("ch_tier2_4_iw5_dlcgun10");
            break;
          case "iw5_dlcgun18":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgun11");
            break;
          case "iw5_dlcgun23":
            var_1 processchallenge("ch_tier2_5_iw5_dlcguna");
            break;
          case "iw5_dlcgun28":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgunb");
            break;
          case "iw5_dlcgun33":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgunc");
            break;
          case "iw5_dlcgun38":
            var_1 processchallenge("ch_tier2_5_iw5_dlcgund");
            break;
          default:
            var_1 processchallenge("ch_noperk_" + var_31);
            break;
        }

        break;
    }
  }

  if(isDefined(var_1.patient_zero)) {
    var_1.patient_zero++;

    if(var_1.patient_zero == 3) {
      var_1 processchallenge("ch_infect_patientzero");
    }
  }
}

get_challenge_weapon_class(var_0, var_1) {
  var_2 = maps\mp\_utility::getweaponclass(var_0);

  if(!isDefined(var_1)) {
    var_1 = maps\mp\_utility::getbaseweaponname(var_0, 1);

    if(maps\mp\_utility::islootweapon(var_1)) {
      var_1 = maps\mp\gametypes\_class::getbasefromlootversion(var_1);
    }
  }

  if(var_1 == "iw5_exocrossbow" || var_1 == "iw5_exocrossbowblops2") {
    return "weapon_special";
  }

  if(var_1 == "iw5_maaws" || var_1 == "iw5_mahem" || var_1 == "iw5_stingerm7") {
    return "weapon_launcher";
  }

  return var_2;
}

ch_bulletdamagecommon(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::isenvironmentweapon(var_0.sweapon)) {
    var_1 endmgstreak();
  }

  if(maps\mp\_utility::iskillstreakweapon(var_0.sweapon)) {
    return;
  }
  if(isbot(var_1)) {
    return;
  }
  if(var_1.pers["lastBulletKillTime"] == var_2) {
    var_1.pers["bulletStreak"]++;
  } else {
    var_1.pers["bulletStreak"] = 1;
  }

  var_1.pers["lastBulletKillTime"] = var_2;

  if(!var_0.victimonground) {
    var_1 processchallenge("ch_hardlanding");
  }

  if(!var_0.attackeronground) {
    var_1.pers["midairStreak"]++;
  }

  if(var_1.pers["midairStreak"] == 2) {
    var_1 processchallenge("ch_airborne");
  }

  if(var_2 < var_0.victim.flashendtime) {
    var_1 processchallenge("ch_flashbangvet");
  }

  if(var_2 < var_1.flashendtime) {
    var_1 processchallenge("ch_blindfire");
  }

  if(var_2 < var_0.victim.concussionendtime) {
    var_1 processchallenge("ch_concussionvet");
  }

  if(var_2 < var_1.concussionendtime) {
    var_1 processchallenge("ch_slowbutsure");
  }

  if(var_1.pers["bulletStreak"] == 2) {
    if(isDefined(var_0.modifiers["headshot"])) {
      foreach(var_5 in var_1.killsthislife) {
        if(var_5.time != var_2) {
          continue;
        }
        if(!isDefined(var_0.modifiers["headshot"])) {
          continue;
        }
        var_1 processchallenge("ch_allpro");
      }
    }

    if(var_3 == "weapon_sniper") {
      var_1 processchallenge("ch_collateraldamage");
    }
  }

  if(var_3 == "weapon_pistol") {
    if(isDefined(var_0.victim.attackerdata) && isDefined(var_0.victim.attackerdata[var_1.guid])) {
      if(isDefined(var_0.victim.attackerdata[var_1.guid].isprimary)) {
        var_1 processchallenge("ch_fastswap");
      }
    }
  }

  if(!isDefined(var_1.infinalstand) || !var_1.infinalstand) {
    if(var_0.attackerstance == "crouch") {
      var_1 processchallenge("ch_crouchshot");
    } else if(var_0.attackerstance == "prone") {
      var_1 processchallenge("ch_proneshot");

      if(var_3 == "weapon_sniper") {
        var_1 processchallenge("ch_invisible");
      }
    }
  }

  if(var_3 == "weapon_sniper") {
    if(isDefined(var_0.modifiers["oneshotkill"])) {
      var_1 processchallenge("ch_ghillie");
    }
  }

  if(issubstr(var_0.sweapon, "silencer")) {
    var_1 processchallenge("ch_stealthvet");
  }
}

ch_roundplayed(var_0) {
  var_1 = var_0.player;

  if(var_1.wasaliveatmatchstart) {
    var_2 = var_1.pers["deaths"];
    var_3 = var_1.pers["kills"];
    var_4 = 1000000;

    if(var_2 > 0) {
      var_4 = var_3 / var_2;
    }

    if(var_4 >= 5.0 && var_3 >= 5.0) {
      var_1 processchallenge("ch_starplayer");
    }

    if(var_2 == 0 && maps\mp\_utility::gettimepassed() > 300000) {
      var_1 processchallenge("ch_flawless");
    }

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
        case "war":
          if(var_0.winner) {
            var_1 processchallenge("ch_war_win");
          }

          var_1 processchallenge("ch_war_participate");
          break;
        case "kc":
          if(var_0.winner) {
            var_1 processchallenge("ch_kc_win");
          }

          var_1 processchallenge("ch_kc_participate");
          break;
        case "dd":
          if(var_0.winner) {
            var_1 processchallenge("ch_dd_win");
          }

          var_1 processchallenge("ch_dd_participate");
          break;
        case "koth":
          if(var_0.winner) {
            var_1 processchallenge("ch_koth_win");
          }

          var_1 processchallenge("ch_koth_participate");
          break;
        case "sab":
          if(var_0.winner) {
            var_1 processchallenge("ch_sab_win");
          }

          var_1 processchallenge("ch_sab_participate");
          break;
        case "sd":
          if(var_0.winner) {
            var_1 processchallenge("ch_sd_win");
          }

          var_1 processchallenge("ch_sd_participate");
          break;
        case "dom":
          if(var_0.winner) {
            var_1 processchallenge("ch_dom_win");
          }

          var_1 processchallenge("ch_dom_participate");
          break;
        case "ctf":
          if(var_0.winner) {
            var_1 processchallenge("ch_ctf_win");
          }

          var_1 processchallenge("ch_ctf_participate");
          break;
        case "tdef":
          if(var_0.winner) {
            var_1 processchallenge("ch_tdef_win");
          }

          var_1 processchallenge("ch_tdef_participate");
          break;
        case "hp":
          if(var_0.winner) {
            var_1 processchallenge("ch_hp_win");
          }

          var_1 processchallenge("ch_hp_participate");
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
        if(level.hardcoremode) {
          var_1 processchallenge("ch_teamplayer_hc");

          if(var_0.place == 0) {
            var_1 processchallenge("ch_mvp_thc");
          }
        } else {
          var_1 processchallenge("ch_teamplayer");

          if(var_0.place == 0) {
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

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_6 = spawnStruct();
  var_6.victim = self;
  var_6.einflictor = var_0;
  var_6.attacker = var_1;
  var_6.idamage = var_2;
  var_6.smeansofdeath = var_3;
  var_6.sweapon = var_4;
  var_6.shitloc = var_5;
  var_6.victimonground = var_6.victim isonground();

  if(isplayer(var_1)) {
    var_6.attackerinlaststand = isDefined(var_6.attacker.laststand);
    var_6.attackeronground = var_6.attacker isonground();
    var_6.attackerstance = var_6.attacker getstance();
  } else {
    var_6.attackerinlaststand = 0;
    var_6.attackeronground = 0;
    var_6.attackerstance = "stand";
  }

  if(isDefined(self) && isDefined(var_1) && isDefined(self.team) && isDefined(var_1.team)) {
    if(self.team != var_1.team && maps\mp\_utility::_hasperk("specialty_class_flakjacket") && isexplosivedamagemod(var_6.smeansofdeath) && maps\mp\_utility::isreallyalive(self) && var_4 != "killstreak_solar_mp") {
      processchallenge("ch_perk_flakjack");
    }

    if(self.team != var_1.team && maps\mp\_utility::_hasperk("specialty_class_toughness")) {
      self.lastdamagefromenemytargettime = gettime();
    }
  }

  domissioncallback("playerDamaged", var_6);
}

playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self.anglesondeath = self getangles();

  if(isDefined(var_1)) {
    var_1.anglesonkill = var_1 getangles();
  }

  self endon("disconnect");
  var_8 = spawnStruct();
  var_8.victim = self;
  var_8.einflictor = var_0;
  var_8.attacker = var_1;
  var_8.idamage = var_2;
  var_8.smeansofdeath = var_3;
  var_8.sweapon = var_4;
  var_8.sprimaryweapon = var_5;
  var_8.shitloc = var_6;
  var_8.time = gettime();
  var_8.modifiers = var_7;
  var_8.victimonground = var_8.victim isonground();

  if(isplayer(var_1)) {
    var_8.attackerinlaststand = isDefined(var_8.attacker.laststand);
    var_8.attackeronground = var_8.attacker isonground();
    var_8.attackerstance = var_8.attacker getstance();
  } else {
    var_8.attackerinlaststand = 0;
    var_8.attackeronground = 0;
    var_8.attackerstance = "stand";
  }

  var_9 = 0;

  if(isDefined(var_8.einflictor) && isDefined(var_8.einflictor.firedads)) {
    var_9 = var_8.einflictor.firedads;
  } else if(isDefined(var_1) && isplayer(var_1)) {
    var_9 = var_1 playerads();
  }

  var_8.was_ads = 0;

  if(var_9 >= 0.2) {
    var_8.was_ads = 1;
  }

  waitandprocessplayerkilledcallback(var_8);

  if(isDefined(var_1) && maps\mp\_utility::isreallyalive(var_1)) {
    var_1.killsthislife[var_1.killsthislife.size] = var_8;
  }

  var_8.attacker notify("playerKilledChallengesProcessed");
}

vehiclekilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
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
  if(isDefined(var_0.attacker)) {
    var_0.attacker endon("disconnect");
  }

  self.processingkilledchallenges = 1;
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  domissioncallback("playerKilled", var_0);
  self.processingkilledchallenges = undefined;
}

playerassist() {
  var_0 = spawnStruct();
  var_0.player = self;
  domissioncallback("playerAssist", var_0);
}

usehardpoint(var_0) {
  self endon("disconnect");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_1 = spawnStruct();
  var_1.player = self;
  var_1.hardpointtype = var_0;
  domissioncallback("playerHardpoint", var_1);
}

roundbegin() {
  domissioncallback("roundBegin");
}

roundend(var_0) {
  var_1 = spawnStruct();

  if(level.teambased) {
    var_2 = "allies";

    for(var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.winner = var_2 == var_0;
      var_1.place = var_3;
      domissioncallback("roundEnd", var_1);
    }

    var_2 = "axis";

    for(var_3 = 0; var_3 < level.placement[var_2].size; var_3++) {
      var_1.player = level.placement[var_2][var_3];
      var_1.winner = var_2 == var_0;
      var_1.place = var_3;
      domissioncallback("roundEnd", var_1);
    }
  } else {
    for(var_3 = 0; var_3 < level.placement["all"].size; var_3++) {
      var_1.player = level.placement["all"][var_3];
      var_1.winner = isDefined(var_0) && isplayer(var_0) && var_1.player == var_0;
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
  if(!isDefined(level.missioncallbacks[var_0])) {
    return;
  }
  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < level.missioncallbacks[var_0].size; var_2++) {
      thread[[level.missioncallbacks[var_0][var_2]]](var_1);
    }
  } else {
    for(var_2 = 0; var_2 < level.missioncallbacks[var_0].size; var_2++) {
      thread[[level.missioncallbacks[var_0][var_2]]]();
    }
  }
}

monitorsprintdistance() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("sprint_begin");
    self.sprintdistthissprint = 0;
    thread monitorsprinttime();
    monitorsinglesprintdistance();

    if(self isitemunlocked("specialty_longersprint") && maps\mp\_utility::_hasperk("specialty_longersprint")) {
      processchallenge("ch_longersprint_pro", int(self.sprintdistthissprint / 12));
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

  for(;;) {
    wait 0.1;
    self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin, var_0);
    var_0 = self.origin;
  }
}

monitorsprinttime() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");
  self waittill("sprint_end");
  self.lastsprintendtime = gettime();
}

monitorfalldistance() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(!isalive(self)) {
      self waittill("spawned_player");
      continue;
    }

    if(!self isonground()) {
      var_0 = self.origin[2];

      while(!self isonground() && isalive(self)) {
        if(self.origin[2] > var_0) {
          var_0 = self.origin[2];
        }

        wait 0.05;
      }

      var_1 = var_0 - self.origin[2];

      if(var_1 < 0) {
        var_1 = 0;
      }

      if(var_1 / 12.0 > 15 && isalive(self) && maps\mp\_utility::isemped()) {
        processchallenge("ch_boot_shortcut");
      }

      if(var_1 / 12.0 > 30 && !isalive(self) && maps\mp\_utility::isemped()) {
        processchallenge("ch_boot_gravity");
      }
    }

    wait 0.05;
  }
}

monitorboostjumpdistance() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(!isalive(self)) {
      self waittill("spawned_player");
      continue;
    }

    self waittill("exo_boost");

    if(!self isonground()) {
      var_0 = self.origin[2];
      var_1 = self.origin[2];

      while(!self isonground() && isalive(self)) {
        if(self.origin[2] > var_0) {
          var_0 = self.origin[2];
        }

        wait 0.05;
      }

      var_2 = var_0 - var_1;

      if(var_2 < 0) {
        var_2 = 0;
      }

      processchallenge("ch_exomech_frontier", int(ceil(var_2 / 12 / 10)));
    }

    wait 0.05;
  }
}

monitorplayermatchchallenges() {
  thread monitormatchchallenges("increment_knife_kill", 15, "ch_precision_slice");
  thread monitormatchchallenges("increment_stuck_kills", 5, "ch_precision_ticktick");
  thread monitormatchchallenges("increment_pistol_headshots", 10, "ch_precision_pistoleer");
  thread monitormatchchallenges("increment_ar_headshots", 5, "ch_precision_headhunt");
  thread monitormatchchallenges("increment_sharpshooter_kills", 10, "ch_precision_sharpshoot");
  thread monitormatchchallenges("increment_oneshotgun_kills", 10, "ch_precision_cqexpert");
  thread monitormatchchallenges("increment_duallethal_kills", 5, "ch_precision_dangerclose");
}

monitormatchchallenges(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(game[var_2])) {
    game[var_2] = [];
  }

  if(!isDefined(game[var_2][self.guid])) {
    game[var_2][self.guid] = 0;
  }

  thread remove_tracking_on_disconnect(var_2);

  for(;;) {
    self waittill(var_0);
    var_3 = game[var_2][self.guid];
    var_3++;
    game[var_2][self.guid] = var_3;

    if(var_3 == var_1) {
      processchallenge(var_2);
    }
  }
}

remove_tracking_on_disconnect(var_0) {
  level endon("game_ended");
  self waittill("disconnect");

  if(isDefined(game[var_0][self.guid])) {
    game[var_0][self.guid] = undefined;
  }
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

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("bomb_planted", "bomb_defused");

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

monitorlivetime() {
  for(;;) {
    self waittill("spawned_player");
    thread survivalistchallenge();
  }
}

survivalistchallenge() {
  self endon("death");
  self endon("disconnect");
  wait 300;

  if(isDefined(self)) {
    processchallenge("ch_survivalist");
  }
}

monitorstreaks() {
  self endon("disconnect");
  self.pers["airstrikeStreak"] = 0;
  self.pers["meleeKillStreak"] = 0;
  self.pers["shieldKillStreak"] = 0;
  thread monitormisc();

  for(;;) {
    self waittill("death");
    self.pers["airstrikeStreak"] = 0;
    self.pers["meleeKillStreak"] = 0;
    self.pers["shieldKillStreak"] = 0;
  }
}

monitormisc() {
  self endon("disconnect");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_no_endon_death("destroyed_explosive", "begin_airstrike", "destroyed_car", "destroyed_car");
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

      if(self isitemunlocked("specialty_detectexplosive") && maps\mp\_utility::_hasperk("specialty_detectexplosive")) {
        processchallenge("ch_detectexplosives_pro");
      }

      break;
    case "destroyed_car":
      processchallenge("ch_vandalism");
      break;
    case "crushed_enemy":
      processchallenge("ch_heads_up");

      if(isDefined(self.finalkill)) {
        processchallenge("ch_droppincrates");
      }

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

  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy) {
    self.healthregenerationstreak++;

    if(self.healthregenerationstreak >= 5) {
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

    if(isDefined(var_3)) {
      if(var_3 == 0) {
        return;
      }
    } else {
      return;
    }
  }

  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_4 = getchallengestatus(var_0);

  if(var_4 == 0) {
    return;
  }
  if(var_4 > level.challengeinfo[var_0]["targetval"].size) {
    return;
  }
  var_5 = maps\mp\gametypes\_hud_util::ch_getprogress(var_0);

  if(isDefined(var_2) && var_2) {
    var_6 = var_1;
  } else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(var_0)) {
    var_6 = var_5;
  } else {
    var_6 = var_5 + var_1;
  }

  var_7 = 0;

  for(var_8 = level.challengeinfo[var_0]["targetval"][var_4]; isDefined(var_8) && var_6 >= var_8; var_8 = level.challengeinfo[var_0]["targetval"][var_4 + var_7]) {
    var_7++;
  }

  if(var_5 < var_6) {
    maps\mp\gametypes\_hud_util::ch_setprogress(var_0, var_6);
  }

  if(var_7 > 0) {
    var_9 = var_4;

    while(var_7) {
      thread giverankxpafterwait(var_0, var_4);
      var_10 = getchallengeid(var_0, var_4);
      self challengenotification(var_10);
      var_11 = common_scripts\utility::tostring(var_10);
      var_12 = int(getsubstr(var_11, 0, var_11.size - 2));

      if(!isDefined(game["challengeStruct"]["challengesCompleted"][self.guid])) {
        game["challengeStruct"]["challengesCompleted"][self.guid] = [];
      }

      var_13 = 0;

      foreach(var_15 in game["challengeStruct"]["challengesCompleted"][self.guid]) {
        if(var_15 == var_12) {
          var_13 = 1;
        }
      }

      if(!var_13) {
        game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_12;
      }

      if(var_4 >= level.challengeinfo[var_0]["targetval"].size && level.challengeinfo[var_0]["parent_challenge"] != "") {
        processchallenge(level.challengeinfo[var_0]["parent_challenge"]);
      }

      var_4++;
      var_7--;
      var_17 = getchallengerewarditem(var_10);

      if(var_17 != 0) {
        maps\mp\_matchdata::logcompletedchallenge(var_10);
      }
    }

    if(!issubstr(var_0, "ch_limited_bloodshed")) {
      thread maps\mp\gametypes\_hud_message::challengesplashnotify(var_0, var_9, var_4);
    }

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
  return tablelookup("mp/unlockTable.csv", 0, var_0, 4 + var_1);
}

masterychallengeprocess(var_0) {
  if(tablelookup("mp/allChallengesTable.csv", 0, "ch_" + var_0 + "_mastery", 1) == "") {
    return;
  }
  var_1 = 0;
  var_2 = maps\mp\_utility::getweaponattachmentfromstats(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == "") {
      continue;
    }
    if(maps\mp\gametypes\_class::isattachmentunlocked(var_0, var_4)) {
      var_1++;
    }
  }

  processchallenge("ch_" + var_0 + "_mastery", var_1, 1);
}

ischallengeunlocked(var_0, var_1) {
  var_2 = tablelookupbyrow("mp/allChallengesTable.csv", var_1, 8);

  if(var_2 != "") {
    var_3 = getchallengestatus(var_2);

    if(var_3 > 1) {
      return 1;
    }
  }

  var_4 = tablelookupbyrow("mp/allChallengesTable.csv", var_1, 6);

  if(var_4 != "") {
    var_5 = maps\mp\gametypes\_rank::getrank();

    if(var_5 < int(var_4)) {
      return 0;
    }
  }

  var_6 = tablelookupbyrow("mp/allChallengesTable.csv", var_1, 7);

  if(var_6 != "") {
    var_7 = getchallengestatus(var_6);

    if(var_7 <= 1) {
      return 0;
    }
  }

  return 1;
}

updatechallenges() {
  self.challengedata = [];

  if(!isDefined(self.ch_unique_earned_streaks)) {
    self.ch_unique_earned_streaks = [];
  }

  if(!isDefined(game["challengeStruct"])) {
    game["challengeStruct"] = [];
  }

  if(!isDefined(game["challengeStruct"]["limitedChallengesReset"])) {
    game["challengeStruct"]["limitedChallengesReset"] = [];
  }

  if(!isDefined(game["challengeStruct"]["challengesCompleted"])) {
    game["challengeStruct"]["challengesCompleted"] = [];
  }

  self endon("disconnect");

  if(!mayprocesschallenges()) {
    return;
  }
  if(!self isitemunlocked("challenges")) {
    return;
  }
  var_0 = 0;

  foreach(var_5, var_2 in level.challengeinfo) {
    var_0++;

    if(var_0 % 40 == 0) {
      wait 0.05;
    }

    self.challengedata[var_5] = 0;
    var_3 = var_2["index"];
    var_4 = maps\mp\gametypes\_hud_util::ch_getstate(var_5);

    if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_5) && !isDefined(game["challengeStruct"]["limitedChallengesReset"][self.guid])) {
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
  return tablelookup("mp/unlockTable.csv", 0, var_0, 0) != "";
}

getchallengefilter(var_0) {
  return tablelookup("mp/allChallengesTable.csv", 0, var_0, 5);
}

getchallengetable(var_0) {
  return tablelookup("mp/challengeTable.csv", 8, var_0, 4);
}

gettierfromtable(var_0, var_1) {
  return tablelookup(var_0, 0, var_1, 1);
}

isweaponchallenge(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getchallengefilter(var_0);

  if(isDefined(var_1) && var_1 == "riotshield") {
    return 1;
  }

  var_2 = maps\mp\_utility::getweaponnametokens(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(var_4 == "iw5" || var_4 == "iw6") {
      var_4 = var_2[var_3] + "_" + var_2[var_3 + 1];
    }

    if(maps\mp\gametypes\_class::isvalidprimary(var_4) || maps\mp\gametypes\_class::isvalidsecondary(var_4, 0)) {
      return 1;
    }
  }

  return 0;
}

getweaponfromchallenge(var_0) {
  var_1 = "ch_";

  if(issubstr(var_0, "ch_marksman_")) {
    var_1 = "ch_marksman_";
  } else if(issubstr(var_0, "ch_expert_")) {
    var_1 = "ch_expert_";
  } else if(issubstr(var_0, "pr_marksman_")) {
    var_1 = "pr_marksman_";
  } else if(issubstr(var_0, "pr_expert_")) {
    var_1 = "pr_expert_";
  }

  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);
  var_2 = undefined;

  if(var_3[0] == "iw5" || var_3[0] == "iw6") {
    var_2 = var_3[0] + "_" + var_3[1];
  } else {
    var_2 = var_3[0];
  }

  return var_2;
}

getweaponattachmentfromchallenge(var_0) {
  var_1 = "ch_";

  if(issubstr(var_0, "ch_marksman_")) {
    var_1 = "ch_marksman_";
  } else if(issubstr(var_0, "ch_expert_")) {
    var_1 = "ch_expert_";
  } else if(issubstr(var_0, "pr_marksman_")) {
    var_1 = "pr_marksman_";
  } else if(issubstr(var_0, "pr_expert_")) {
    var_1 = "pr_expert_";
  }

  var_2 = getsubstr(var_0, var_1.size, var_0.size);
  var_3 = maps\mp\_utility::getweaponnametokens(var_2);
  var_4 = undefined;

  if(isDefined(var_3[2]) && maps\mp\_utility::isattachment(var_3[2])) {
    var_4 = var_3[2];
  }

  return var_4;
}

iskillstreakchallenge(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = getchallengefilter(var_0);

  if(isDefined(var_1) && (var_1 == "killstreaks_assault" || var_1 == "killstreaks_support")) {
    return 1;
  }

  return 0;
}

getkillstreakfromchallenge(var_0) {
  var_1 = "ch_";
  var_2 = getsubstr(var_0, var_1.size, var_0.size);

  if(var_2 == "assault_streaks" || var_2 == "support_streaks") {
    var_2 = undefined;
  }

  return var_2;
}

challenge_targetval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 9 + (var_2 - 1) * 2);
  return int(var_3);
}

challenge_rewardval(var_0, var_1, var_2) {
  var_3 = tablelookup(var_0, 0, var_1, 10 + (var_2 - 1) * 2);
  return int(var_3);
}

challenge_parentchallenge(var_0, var_1) {
  var_2 = tablelookup(var_0, 0, var_1, 42);

  if(!isDefined(var_2)) {
    var_2 = "";
  }

  return var_2;
}

buildchallengetableinfo(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_3++;
    var_4 = tablelookupbyrow(var_0, var_3, 0);

    if(var_4 == "") {
      break;
    }

    var_5 = tablelookupbyrow(var_0, var_3, 43);

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

      if(isDefined(var_6)) {
        level.challengeinfo[var_4]["weapon"] = var_6;
      }

      if(isDefined(var_7)) {
        level.challengeinfo[var_4]["attachment"] = var_7;
      }
    } else if(iskillstreakchallenge(var_4)) {
      var_8 = getkillstreakfromchallenge(var_4);

      if(isDefined(var_8)) {
        level.challengeinfo[var_4]["killstreak"] = var_8;
      }
    }

    for(var_9 = 1; var_9 < 11; var_9++) {
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
  var_0 = var_0 + buildchallengetableinfo("mp/allChallengesTable.csv", 0);
}

monitorprocesschallenge() {
  self endon("disconnect");
  level endon("game_end");

  for(;;) {
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

  for(;;) {
    self waittill("got_killstreak", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(var_0 == 9 && isDefined(self.killstreaks[7]) && isDefined(self.killstreaks[8]) && isDefined(self.killstreaks[9])) {
      processchallenge("ch_6fears7");
    }

    if(var_0 == 10 && self.killstreaks.size == 0) {
      processchallenge("ch_theloner");
    }
  }
}

monitorkilledkillstreak() {
  self endon("disconnect");
  level endon("game_end");

  for(;;) {
    self waittill("destroyed_killstreak", var_0);

    if(self isitemunlocked("specialty_blindeye") && maps\mp\_utility::_hasperk("specialty_blindeye")) {
      processchallenge("ch_blindeye_pro");
    }

    if(isDefined(var_0) && var_0 == "stinger_mp") {
      processchallenge("ch_marksman_stinger");
      processchallenge("pr_marksman_stinger");
    }
  }
}

genericchallenge(var_0, var_1) {
  switch (var_0) {
    case "hijacker_airdrop":
      processchallenge("ch_smoothcriminal");
      break;
    case "wargasm":
      processchallenge("ch_wargasm");
      break;
    case "weapon_assault":
      processchallenge("ch_surgical_assault");
      break;
    case "weapon_smg":
      processchallenge("ch_surgical_smg");
      break;
    case "weapon_lmg":
      processchallenge("ch_surgical_lmg");
      break;
    case "weapon_dmr":
      break;
    case "weapon_sniper":
      processchallenge("ch_surgical_sniper");
      break;
    case "shield_damage":
      if(!maps\mp\_utility::isjuggernaut()) {
        processchallenge("ch_shield_damage", var_1);
      }

      break;
    case "shield_bullet_hits":
      if(!maps\mp\_utility::isjuggernaut()) {
        processchallenge("ch_shield_bullet", var_1);
      }

      break;
    case "shield_explosive_hits":
      if(!maps\mp\_utility::isjuggernaut()) {
        processchallenge("ch_shield_explosive", var_1);
      }

      break;
  }
}

playerhasammo() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(self getweaponammoclip(var_2)) {
      return 1;
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
  self endon("disconnect");
  self.adstime = 0.0;

  for(;;) {
    if(self playerads() == 1) {
      self.adstime = self.adstime + 0.05;
    } else {
      self.adstime = 0.0;
    }

    wait 0.05;
  }
}

monitorpronetime() {
  self endon("disconnect");
  level endon("game_ended");
  self.pronetime = undefined;
  var_0 = 0;

  for(;;) {
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

monitorpowerslidetime() {
  self endon("disconnect");
  level endon("game_ended");
  self.powerslidetime = undefined;

  for(;;) {
    while(!self ispowersliding()) {
      wait 0.05;
    }

    self.powerslidetime = gettime();
    wait 0.05;
  }
}

monitorholdbreath() {
  self endon("disconnect");
  self.holdingbreath = 0;

  for(;;) {
    self waittill("hold_breath");
    self.holdingbreath = 1;
    self waittill("release_breath");
    self.holdingbreath = 0;
  }
}

monitormantle() {
  self endon("disconnect");
  self.mantling = 0;

  for(;;) {
    self waittill("jumped");
    var_0 = self getcurrentweapon();
    common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
    var_1 = self getcurrentweapon();

    if(var_1 == "none") {
      self.mantling = 1;
    } else {
      self.mantling = 0;
    }

    if(self.mantling) {
      if(self isitemunlocked("specialty_fastmantle") && maps\mp\_utility::_hasperk("specialty_fastmantle")) {
        processchallenge("ch_fastmantle");
      }

      common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
      var_1 = self getcurrentweapon();

      if(var_1 == var_0) {
        self.mantling = 0;
      }
    }
  }
}

monitorweaponswap() {
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

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);

    if(isDefined(var_3) && self == var_3) {
      continue;
    }
    self.lastflashedtime = gettime();
  }
}

monitorconcussion() {
  self endon("disconnect");

  for(;;) {
    self waittill("concussed", var_0);

    if(self == var_0) {
      continue;
    }
    self.lastconcussedtime = gettime();
  }
}

monitorminetriggering() {
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::waittill_any("triggered_mine", "triggered_claymore");
    thread waitdelayminetime();
  }
}

waitdelayminetime() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(level.delayminetime + 2);
  processchallenge("ch_delaymine");
}

is_lethal_equipment(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "explosive_drone_mp":
    case "exoknife_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 1;
    default:
      return 0;
  }
}