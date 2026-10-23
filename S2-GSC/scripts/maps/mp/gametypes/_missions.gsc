/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_missions.gsc
***************************************************/

init() {
  setdvarifuninitialized("spv_challenge_mastery_completion", 0);
  precachestring(&"MP_CHALLENGE_COMPLETED");

  if(!mayprocesschallenges()) {
    return;
  }
  level._id_4B0B = ["extended_mag", "grip", "fast_ads", "ads_move_speed", "akimbo", "reduced_sway"];
  level._id_35A8 = ["extended_range", "rapid_fire", "head_damage", "suppressor", "hipfire"];
  level.missioncallbacks = [];
  level.recentkillers = [];
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

  if(_func_367()) {
    if(_func_371()) {
      return 0;
    } else {
      return 1;
    }
  }

  if(xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
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

    var_0 thread initmissiondata();

    if(!_func_367()) {
      var_0 thread onplayerspawned();
      var_0 thread monitorbombuse();
      var_0 thread _id_63E5();
      var_0 thread monitorscavengerpickup();
      var_0 thread monitorkillstreakprogress();
      var_0 thread monitorfinalstandsurvival();
      var_0 thread monitorminetriggering();
      var_0 thread _id_63FA();
      var_0 thread monitorplayermatchchallenges();
      var_0 notifyonplayercommand("jumped", "+goStand");
      var_0 thread monitormantle();
      var_0.streaksdestroyedthislife = [];
    } else
      var_0 thread _id_0468::ae_sendzmskinunlockevent();

    var_0 thread monitorprocesschallenge();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread onplayerdeath();
  }
}

onplayerdeath() {
  self endon("disconnect");
  self waittill("death");

  if(isDefined(self.hasscavengedammothislife)) {
    self.hasscavengedammothislife = 0;
  }

  if(isDefined(self.streaksdestroyedthislife)) {
    self.streaksdestroyedthislife = [];
  }
}

monitorscavengerpickup() {
  self endon("disconnect");

  for(;;) {
    self waittill("scavenger_pickup");

    if(maps\mp\_utility::_hasperk("specialty_class_forage")) {
      self.hasscavengedammothislife = 1;
    } else if(maps\mp\_utility::_hasperk("specialty_class_clandestine")) {
      processchallenge("ch_dlc1_cladestine");
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
  while(!isDefined(level.killstreakfuncs)) {
    waitframe();
  }

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

_id_20A0(var_0) {
  var_1 = 3;
  var_2 = 4;
  var_3 = 2;
  processchallenge("ch_career_killstreakkills");

  switch (var_0) {
    case "fighter_strike_kill":
      processchallenge("ch_streak_fighterstrike");

      if(!isDefined(self._id_3AAA)) {
        self._id_3AAA = 0;
      }

      self._id_3AAA = self._id_3AAA + 1;

      if(self._id_3AAA == var_1) {
        processchallenge("ch_streak_ontarget");
      }

      break;
    case "fritzx_kill":
      processchallenge("ch_streak_fritzx");

      if(!isDefined(self._id_3EE8)) {
        self._id_3EE8 = 0;
      }

      self._id_3EE8 = self._id_3EE8 + 1;

      if(self._id_3EE8 == var_1) {
        processchallenge("ch_streak_ontarget");
      }

      break;
    case "firebomb_kill":
      processchallenge("ch_streak_firebomb");

      if(!isDefined(self._id_3BD6)) {
        self._id_3BD6 = 0;
      }

      self._id_3BD6 = self._id_3BD6 + 1;

      if(self._id_3BD6 == var_2) {
        processchallenge("ch_streak_rainingdeath");
      }

      break;
    case "airstrike_kill":
      processchallenge("ch_streak_airstrike");

      if(!isDefined(self._id_0B95)) {
        self._id_0B95 = 0;
      }

      self._id_0B95 = self._id_0B95 + 1;

      if(self._id_0B95 == var_2) {
        processchallenge("ch_streak_rainingdeath");
      }

      break;
    case "plane_gunner_kill":
      processchallenge("ch_streak_planegunner");

      if(!isDefined(self._id_7036)) {
        self._id_7036 = 0;
      }

      self._id_7036 = self._id_7036 + 1;

      if(self._id_7036 == var_2) {
        processchallenge("ch_streak_rainingdeath");
      }

      break;
    case "molotovs_kill":
      processchallenge("ch_streak_molotovs");

      if(!isDefined(self._id_62C3)) {
        self._id_62C3 = 0;
      }

      self._id_62C3 = self._id_62C3 + 1;

      if(self._id_62C3 == var_3) {
        processchallenge("ch_streak_flamed");
      }

      break;
    case "flamethrower_kill":
      processchallenge("ch_streak_flamethrower");

      if(!isDefined(self._id_3D1D)) {
        self._id_3D1D = 0;
      }

      self._id_3D1D = self._id_3D1D + 1;

      if(self._id_3D1D == var_3) {
        processchallenge("ch_streak_flamed");
      }

      break;
    case "mortar_strike_kill":
      processchallenge("ch_streak_mortarstrike");
      break;
    case "missile_strike_kill":
      processchallenge("ch_streak_missilestrike");
      break;
    case "paratroopers_kill":
      processchallenge("ch_streak_paratroopers");
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
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
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
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
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
    default:
      break;
  }
}

ch_vehicle_killed(var_0) {
  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return;
  }
  var_1 = var_0.attacker;
  var_2 = maps\mp\_utility::_id_4431(var_0.sweapon, 1);

  if(maps\mp\_utility::_id_5856(var_2)) {
    var_2 = maps\mp\gametypes\_class::getbasefromlootversion(var_2);
  }

  var_3 = get_challenge_weapon_class(var_0.sweapon, var_2);

  if(var_3 == "weapon_projectile") {
    if(isDefined(level.challengeinfo["ch_vehicle_" + var_2])) {
      var_1 processchallenge("ch_vehicle_" + var_2);
    }

    if(isDefined(level.challengeinfo["ch_marksman_" + var_2]) && var_2 != "dp28_mp") {
      var_1 processchallenge("ch_marksman_" + var_2);
    }
  }

  if(var_1 maps\mp\_utility::_hasperk("specialty_coldblooded") && var_1 maps\mp\_utility::_hasperk("specialty_spygame") && var_1 maps\mp\_utility::_hasperk("specialty_heartbreaker")) {
    if(!isDefined(var_0.vehicle) || !isDefined(var_0.vehicle.setsurfacetype) || var_0.vehicle.setsurfacetype != "prison_turret") {
      var_1 processchallenge("ch_precision_airhunt");
    }
  }

  if(isDefined(var_0.vehicle) && isDefined(var_0.vehicle._id_01C8) && var_0.vehicle._id_01C8 == "drone_recon" && issubstr(var_2, "exoknife")) {
    var_1 processchallenge("ch_precision_knife");
  }

  if(issubstr(var_0.sweapon, "rapid_fire") && issubstr(var_0.sweapon, "fmj")) {
    var_1 processchallenge("ch_combatefficiency_hotlead");
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
    if(!isalive(self) || self useButtonPressed()) {
      self.pers["MGStreak"] = undefined;
      break;
    }

    waitframe();
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

_id_7752(var_0) {
  if(!isDefined(self.challengedata) || !isDefined(self.challengedata[var_0])) {
    return;
  }
  if(self.challengedata[var_0] != 2) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::privatematch()) {
    return;
  }
  var_1 = maps\mp\gametypes\_hud_util::ch_getprogress(var_0);

  if(var_1 >= level.challengeinfo[var_0]["targetval"]) {
    return;
  }
  var_2 = var_1 + 1;

  if(var_2 == level.challengeinfo[var_0]["targetval"]) {
    thread maps\mp\gametypes\_hud_message::splashnotify(var_0 + "_complete");
    self.challengedata[var_0] = 3;
    maps\mp\gametypes\_hud_util::ch_setstate(var_0, 3);
  } else
    maps\mp\gametypes\_hud_util::ch_setprogress(var_0, var_2);
}

ch_kills(var_0) {
  var_0.victim playerdied();

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker)) {
    return;
  } else {
    var_1 = var_0.attacker;
  }

  if(isbot(var_1)) {
    return;
  }
  var_1 _id_7752("ch_daily_0");

  if(var_0.smeansofdeath == "MOD_HEAD_SHOT") {
    var_1 _id_7752("ch_daily_1");
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
  var_11 = _getweaponattachments(var_0.sweapon);
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

  var_31 = maps\mp\_utility::_id_45B5(var_0.sweapon);
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

  if(isDefined(var_0.modifiers["assaultObjective"])) {
    var_1 processchallenge("ch_heroics_assault");
    var_35 = 1;
    var_36 = 1;

    for(var_37 = 0; var_37 < var_1.recentkills.size; var_37++) {
      if(isDefined(var_1.recentkills[var_37].modifiers["assaultObjective"])) {
        var_35++;

        if(var_1.recentkills[var_37].modifiers["assaultObjective"] == var_0.modifiers["assaultObjective"]) {
          var_36++;
        }

        continue;
      }

      break;
    }

    if(var_35 == 2) {
      var_1 processchallenge("ch_killer_aggression");
    }

    if(var_36 == 3) {
      var_1 thread ch_monitorkillerdoingwork(var_0.modifiers["assaultObjective"]);
    }
  }

  if(isDefined(var_0.modifiers["defendObjective"])) {
    var_1 processchallenge("ch_heroics_defender");
    var_38 = 1;

    for(var_37 = 0; var_37 < var_1.recentkills.size; var_37++) {
      if(isDefined(var_1.recentkills[var_37].modifiers["defendObjective"])) {
        var_38++;
        continue;
      }

      break;
    }

    if(var_38 == 2) {
      var_1 processchallenge("ch_killer_rejection");
    }

    var_39 = 1;

    foreach(var_29 in var_1.killsthislife) {
      if(isDefined(var_29.modifiers["defendObjective"]) && var_29.modifiers["defendObjective"] == var_0.modifiers["defendObjective"]) {
        var_39++;
      }
    }

    if(var_39 == 5) {
      var_1 processchallenge("ch_killer_resistance");
    }
  }

  if(!isDefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges) {
    if(isDefined(var_0.attacker._id_0079) && !var_14 && !var_13) {
      var_42 = _id_04CA::_id_44A0(var_0.attacker._id_0079);

      if(var_42 == "infantry") {
        var_1 processchallenge("ch_infantry_kills");

        if(var_33 == "weapon_assault" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_infantry_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["divisions_infantry_kill"])) {
          var_1 processchallenge("ch_infantry_skill");
        }
      } else if(var_42 == "airborne") {
        var_1 processchallenge("ch_airborne_kills");

        if(var_33 == "weapon_smg" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_airborne_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["divisions_airborne_kill"])) {
          var_1 processchallenge("ch_airborne_skill");
        }
      } else if(var_42 == "armored") {
        var_1 processchallenge("ch_armored_kills");

        if(var_33 == "weapon_heavy" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_armored_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["divisions_armored_kill"])) {
          var_1 processchallenge("ch_armored_skill");
        }
      } else if(var_42 == "mountain") {
        var_1 processchallenge("ch_mountain_kills");

        if(var_33 == "weapon_sniper" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_mountain_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["divisions_mountain_kill"])) {
          var_1 processchallenge("ch_mountain_skill");
        }
      } else if(var_42 == "expeditionary") {
        var_1 processchallenge("ch_expeditionary_kills");

        if(var_33 == "weapon_shotgun" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_expeditionary_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["divisions_cavalry_kill"])) {
          var_1 processchallenge("ch_expeditionary_skill");
        }
      } else if(var_42 == "resistance") {
        var_1 processchallenge("ch_resistance_kills");

        if(var_33 == "weapon_pistol" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_resistance_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["division_resistance_kill"])) {
          var_1 processchallenge("ch_resistance_skill");
        }
      } else if(var_42 == "grenadier") {
        var_1 processchallenge("ch_grenadier_kills");

        if(issubstr(var_31, "riotshield_mp")) {
          var_1 processchallenge("ch_grenadier_weapon");
        }
      } else if(var_42 == "commando")
        var_1 processchallenge("ch_commando_kills");
      else if(var_42 == "scout") {
        var_1 processchallenge("ch_scout_kills");

        if(var_33 == "weapon_sniper" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_scout_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["division_scout_kill"])) {
          var_1 processchallenge("ch_scout_skill");
        }
      } else if(var_42 == "artillery") {
        var_1 processchallenge("ch_artillery_kills");

        if(var_33 == "weapon_assault" && !maps\mp\_utility::ismeleemod(var_9)) {
          var_1 processchallenge("ch_artillery_weapon");
        }

        if(common_scripts\utility::_id_562E(var_0.modifiers["division_artillery_kill"])) {
          var_1 processchallenge("ch_artillery_skill");
        }
      }
    }
  }

  if(var_0.victim != var_0.attacker) {
    var_43 = !level.teambased || var_0.victim.team != var_0.attacker.team;

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_radarimmune")) {
      var_44 = 0;

      if(isDefined(level.uavmodels)) {
        if(level.teambased) {
          var_44 = level.uavmodels[maps\mp\_utility::getotherteam(var_0.attacker.team)].size;
        } else if(level.uavmodels.size > 0) {
          var_45 = 0;

          foreach(var_47 in level.uavmodels) {
            if(var_47._id_0117 == var_1) {
              var_45++;
            }
          }

          if(var_45 > 0) {
            var_44 = level.uavmodels.size - var_45;
          } else {
            var_44 = level.uavmodels.size;
          }
        }
      }

      if(var_44 > 0) {
        var_1 processchallenge("ch_perks1_lowprofile");
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_requisitions") && var_13) {
      var_1 processchallenge("ch_field_requisitions");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_duelist") && var_33 == "weapon_pistol") {
      foreach(var_50 in var_11) {
        if(issubstr(var_50, "akimbo")) {
          var_1 processchallenge("ch_marksman_duelist");
          break;
        }
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_inconspicuous") && var_21 == "crouch") {
      var_1 processchallenge("ch_physical_inconspicuous");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_scoped") && var_1 adsButtonPressed()) {
      var_1 processchallenge("ch_marksman_scoped");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_energetic") && isDefined(var_1._id_5BE3) && gettime() - var_1._id_5BE3 < 5000) {
      var_1 processchallenge("ch_physical_energetic");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_undercover")) {
      var_1 thread _id_6359();
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_hustle") && isDefined(var_1._id_5BD6) && gettime() - var_1._id_5BD6 < 5000) {
      var_1 processchallenge("ch_physical_hustle");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_lookout") && var_16) {
      var_1 processchallenge("ch_operations_lookout");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_gunslinger") && var_1 issprinting()) {
      var_1 processchallenge("ch_physical_gunslinger");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor")) {
      var_1 processchallenge("ch_perk_blast");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_delaymine")) {
      var_52 = 0;

      if(isDefined(level.uavmodels)) {
        if(level.teambased) {
          foreach(var_47 in level.uavmodels[maps\mp\_utility::getotherteam(var_1.team)]) {
            if(isDefined(var_47._id_9FE0) && var_47._id_9FE0 == "counter") {
              var_52 = 1;
              break;
            }
          }

          if(isDefined(level.empowner) && level.empowner.team != var_1.team) {
            var_52 = 1;
          }
        } else {
          foreach(var_47 in level.uavmodels) {
            if(isDefined(var_47._id_9FE0) && var_47._id_9FE0 == "counter" && isDefined(var_47._id_0117) && !(var_47._id_0117 == var_1)) {
              var_52 = 1;
              break;
            }
          }
        }
      }

      if(var_52) {
        var_1 processchallenge("ch_perk_hardwire");
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_serrated") && issubstr(var_31, "throwingknife_mp")) {
      var_1 processchallenge("ch_field_serrated");
    }

    var_57 = maps\mp\_utility::getweaponclass(var_0.sweapon);

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_launched") && var_57 == "weapon_projectile") {
      var_1 processchallenge("ch_explosives_launched");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_rifleman")) {
      if(isDefined(var_1.lastprimaryweaponswaptime) && gettime() - var_1.lastprimaryweaponswaptime < 5000) {
        var_1 processchallenge("ch_marksman_rifleman");
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_primed")) {
      if(isDefined(var_1.lastdamagefromenemytargettime) && gettime() - var_1.lastdamagefromenemytargettime < 2000) {
        var_1 processchallenge("ch_marksman_primed");
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_forage") && isDefined(var_1.hasscavengedammothislife) && var_1.hasscavengedammothislife == 1) {
      var_1 processchallenge("ch_field_forage");
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_class_instincts") && isDefined(var_1._id_6F4D) && var_1._id_6F4D.size > 0) {
      var_58 = var_0.victim getentitynumber();

      if(isDefined(var_1._id_6F4D[var_58]) && var_1._id_6F4D[var_58]) {
        var_1 processchallenge("ch_operations_instincts");
      }
    }

    if((var_0.victim common_scripts\utility::_id_56F4() || var_0.victim common_scripts\utility::_id_56B5()) && var_1 maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
      if(var_1 maps\mp\_utility::_hasperk("specialty_sprintfire")) {
        var_1 processchallenge("ch_perks3_junkie");
      }

      if(isDefined(var_0.victim.attackerdata[var_1.guid])) {
        foreach(var_60 in var_0.victim.attackerdata[var_1.guid]._id_A9DF) {
          if(var_60 == "flash_grenade_mp" || var_60 == "stun_grenade_mp" || var_60 == "signal_flare_mp") {
            var_1 processchallenge("ch_perks2_tacmask");
          }
        }
      }
    }

    if(var_43 && var_1 maps\mp\_utility::_hasperk("specialty_sixthsense") && isDefined(var_1._id_4B65) && var_1._id_4B65) {
      var_62 = var_1.origin;
      var_63 = var_0.victim.origin;

      if(isDefined(level._id_08E2) && distancesquared(var_62, var_63) <= level._id_08E2 * level._id_08E2) {
        var_1 processchallenge("ch_perks1_sixthsense");
      }
    }
  }

  if(var_10 < var_0.victim.concussionendtime) {
    var_1 processchallenge("ch_exolauncher_stun");
  }

  if(isDefined(var_0.victim.inplayersmokescreen)) {
    var_1 processchallenge("ch_exolauncher_smoke");
  }

  if(issubstr(var_0.sweapon, "extended_mag")) {
    var_1 processchallenge("ch_combathandling_extended_mag");
    var_1 _id_18AC();
  }

  if(issubstr(var_0.sweapon, "grip")) {
    var_1 processchallenge("ch_combathandling_grip");
  }

  if(issubstr(var_0.sweapon, "fast_ads")) {
    var_1 processchallenge("ch_combathandling_fast_ads");
  }

  if(issubstr(var_0.sweapon, "reduced_sway")) {
    var_1 processchallenge("ch_combathandling_reduced_sway");
  }

  if(issubstr(var_0.sweapon, "hipfire")) {
    var_1 processchallenge("ch_combatefficiency_hipfire");
  }

  if(issubstr(var_0.sweapon, "fast_ads") && issubstr(var_0.sweapon, "grip")) {
    var_1 processchallenge("ch_combathandling_fastshooting");
  }

  if(issubstr(var_0.sweapon, "fast_ads") && issubstr(var_0.sweapon, "grip") && issubstr(var_0.sweapon, "extended_mag")) {
    var_1 processchallenge("ch_combathandling_smoothop");
  }

  if(!var_18 && issubstr(var_0.sweapon, "hipfire") && issubstr(var_0.sweapon, "extended_mag") && issubstr(var_0.sweapon, "rapid_fire")) {
    var_1 processchallenge("ch_combatefficiency_gunner");
  }

  if(issubstr(var_0.sweapon, "fmj")) {
    var_1 processchallenge("ch_combatefficiency_fmj");
  }

  if(issubstr(var_0.sweapon, "head_damage")) {
    var_1 processchallenge("ch_combatefficiency_head_damage");
  }

  if(issubstr(var_0.sweapon, "rapid_fire")) {
    var_1 processchallenge("ch_combatefficiency_rapid_fire");
  }

  if(issubstr(var_0.sweapon, "extended_range")) {
    var_1 processchallenge("ch_combatefficiency_extended_range");
  }

  if(issubstr(var_0.sweapon, "lens_sight")) {
    var_1 processchallenge("ch_combatefficiency_lens_sight");
  }

  if(issubstr(var_0.sweapon, "aperture_sight")) {
    var_1 processchallenge("ch_combatefficiency_aperture_sight");
  }

  if(issubstr(var_0.sweapon, "telescopic_sight")) {
    var_1 processchallenge("ch_combatefficiency_telescopic_sight");
  }

  if(var_15 && issubstr(var_0.sweapon, "fmj") && issubstr(var_0.sweapon, "extended_range")) {
    var_1 processchallenge("ch_combatefficiency_headhunter");
  }

  if(issubstr(var_0.sweapon, "extended_range") && issubstr(var_0.sweapon, "fmj") && (issubstr(var_0.sweapon, "telescopic_sight") || !issubstr(var_0.sweapon, "iron_sight"))) {
    var_1 processchallenge("ch_combatefficiency_assassin");
  }

  if(issubstr(var_0.sweapon, "akimbo")) {
    var_1 _id_34C3();
  }

  foreach(var_65 in var_11) {
    playrumblelooponentity(var_1, var_65, var_11, var_0.sweapon, var_18, var_15, var_16, var_19, var_22);
  }

  if(!maps\mp\_utility::ismeleemod(var_9) && !var_14 && !var_13) {
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

    if(var_33 != "weapon_projectile" || var_31 == "dp28_mp") {
      var_1 processchallenge("ch_marksman_" + var_31);
    }
  }

  if((var_9 == "MOD_PISTOL_BULLET" || var_9 == "MOD_RIFLE_BULLET" || var_9 == "MOD_HEAD_SHOT") && !var_14 && !var_13) {
    switch (var_33) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        if(issubstr(var_31, "dlcgun") && (var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_33 == "weapon_special")) {
          var_1 processchallenge("ch_attach_unlock_type1_" + var_32);
        } else {
          var_1 processchallenge("ch_attach_unlock_kills_" + var_32);
        }

        if(var_18) {
          if(issubstr(var_31, "dlcgun") && (var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_33 == "weapon_special")) {
            var_1 processchallenge("ch_attach_unlock_type3_" + var_32);
          } else {
            var_1 processchallenge("ch_attach_unlock_ads_" + var_32);
          }
        } else if(issubstr(var_31, "dlcgun") && (var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_33 == "weapon_special"))
          var_1 processchallenge("ch_attach_unlock_type2_" + var_32);
        else {
          var_1 processchallenge("ch_attach_unlock_hipfirekills_" + var_32);
        }

        break;
      default:
        break;
    }

    if(var_9 == "MOD_HEAD_SHOT") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_headShots_" + var_32])) {
        var_1 processchallenge("ch_attach_unlock_headShots_" + var_32);
      }
    }
  }

  if(isDefined(var_1.riotshieldentity)) {
    if(var_10 - var_1.riotshieldentity._id_002B < 3000) {
      var_1 processchallenge("ch_attach_unlock_postplant_riotshieldt6");
    }
  }

  if(maps\mp\_utility::ismeleemod(var_9) && !var_14 && !var_13) {
    if(!issubstr(var_31, "riotshield")) {
      var_1.pers["meleeKillStreak"]++;

      foreach(var_65 in var_11) {
        if(var_65 == "tactical") {
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

    var_1 notify("increment_melee_kills");

    if(isgunmeleeattack(var_9, var_0.sweapon) && !issubstr(var_0.sweapon, "bayonet")) {
      var_1 processchallenge("ch_humiliation_blunttrauma");
    }
  }

  if(issubstr(var_9, "MOD_IMPACT") && !var_14 && !var_13) {
    if(issubstr(var_0.sweapon, "exoknife_mp")) {
      var_1 processchallenge("ch_exolauncher_knife");
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "throwingknife_")) {
      var_1 processchallenge("ch_lethals_knifekills");

      if(var_16) {
        var_1 processchallenge("ch_humiliation_hailmary");
        var_1 _id_0468::_id_0A22("hailMary");
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
      var_1 processchallenge("ch_lethals_fragkills");

      if(var_0.victim.explosiveinfo["cookedKill"]) {
        var_1 processchallenge("ch_lethals_masterchef");
      }

      if(var_0.victim.explosiveinfo["throwbackKill"]) {
        var_1 processchallenge("ch_precision_return");
      }

      var_69 = 1;

      foreach(var_71 in var_1.recentkills) {
        if(maps\mp\_utility::isstrstart(var_71.sweapon, "frag_")) {
          var_69++;
        }
      }

      if(var_69 == 2) {
        var_1 processchallenge("ch_humiliation_snackattack");
      }
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "semtex_")) {
      var_1 processchallenge("ch_exolauncher_semtex");
      var_1 processchallenge("ch_lethals_semtexkills");
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "thermite_")) {
      var_1 processchallenge("ch_lethals_thermitekills");
    }

    if(maps\mp\_utility::isstrstart(var_0.sweapon, "c4_")) {
      var_1 processchallenge("ch_lethals_c4kills");
    }

    if(isDefined(var_0.einflictor.classname) && var_0.einflictor.classname == "scriptable") {
      var_1 processchallenge("ch_precision_sitaware");
    }

    if(isDefined(var_0.sweapon) && var_0.sweapon == "mp_lab_gas_explosion") {
      var_1 processchallenge("ch_precision_sitaware");
    }

    if(maps\mp\_utility::isplayeronenemyteam(var_1) && var_1 maps\mp\_utility::_hasperk("specialty_class_bang")) {
      var_1 processchallenge("ch_explosives_bang");
    }

    if(isDefined(var_0.victim.explosiveinfo) && isDefined(var_0.victim.explosiveinfo["midAirDetonate"]) && var_0.victim.explosiveinfo["midAirDetonate"]) {
      var_1 processchallenge("ch_dlc1_saboteur");
    }
  }

  foreach(var_65 in var_11) {
    switch (var_65) {
      case "gl":
        if(isDefined(level.challengeinfo["ch_attach_kill_" + var_65])) {
          var_1 processchallenge("ch_attach_kill_" + var_65);
        }

        break;
    }
  }

  if(issubstr(var_9, "MOD_EXPLOSIVE") && var_0.sweapon == "airdrop_trap_explosive_mp") {
    var_1 processchallenge("ch_precision_surprise");
  }

  if(!isDefined(level.disableweaponchallenges) || !level.disableweaponchallenges) {
    if(var_15) {
      switch (var_33) {
        case "weapon_pistol":
        case "weapon_heavy":
        case "weapon_assault":
        case "weapon_smg":
          var_1 processchallenge("ch_camo_" + var_31);
          break;
      }

      if(var_31 == "blunderbuss_mp") {
        var_1 tier4camochallenge(var_0.sweapon, "ch_camoT4_triplekill_");
      }
    }

    if(isDefined(var_0.modifiers["oneshotkill"])) {
      switch (var_33) {
        case "weapon_shotgun":
        case "weapon_sniper":
          var_1 processchallenge("ch_camo_" + var_31);
          break;
      }

      if(var_31 == "dp28_mp") {
        var_1 processchallenge("ch_camo_" + var_31);
      }
    }

    if(var_33 == "weapon_other" && _weapontype(var_0.sweapon) == "melee") {
      var_1 processchallenge("ch_camo_" + var_31);
    }
  }

  if(var_33 == "weapon_projectile" && var_9 == "MOD_PROJECTILE") {
    var_1 _id_99C5(var_0.sweapon, "ch_camoT2_directhitkill_");
    var_1 tier4camochallenge(var_0.sweapon, "ch_camoT4_directhitkill_");
  }

  if(isDefined(var_1.recentkills) && var_1.recentkills.size >= 1 && !isgunmeleeattack(var_9, var_0.sweapon)) {
    if(var_1.recentkills.size == 1 && var_1 maps\mp\_utility::_hasperk("specialty_class_escalation")) {
      var_1 processchallenge("ch_dlc2_escalation");
    }

    var_75 = 1;

    for(var_37 = 0; var_37 < var_1.recentkills.size; var_37++) {
      var_76 = maps\mp\_utility::_id_45B5(var_1.recentkills[var_37].sweapon);

      if(var_76 == var_31 && !isgunmeleeattack(var_1.recentkills[var_37].smeansofdeath, var_1.recentkills[var_37].sweapon)) {
        var_75++;
        continue;
      }

      break;
    }

    if(var_75 == 2) {
      var_1 _id_99C5(var_0.sweapon, "ch_camoT2_doublekill_");
      var_1 tier3camochallenge(var_0.sweapon, "ch_camoT3_doublekill_");
      var_1 tier4camochallenge(var_0.sweapon, "ch_camoT4_doublekill_");
    }

    if(var_75 == 3) {
      if(var_31 != "blunderbuss_mp") {
        var_1 tier4camochallenge(var_0.sweapon, "ch_camoT4_triplekill_");
      }
    }
  }

  if(isDefined(var_1.killsthislife) && var_1.killsthislife.size >= 4 && !isgunmeleeattack(var_9, var_0.sweapon)) {
    var_75 = 1;

    foreach(var_29 in var_1.killsthislife) {
      var_76 = maps\mp\_utility::_id_45B5(var_29.sweapon);

      if(var_76 == var_31 && !isgunmeleeattack(var_29.smeansofdeath, var_29.sweapon)) {
        var_75++;
      }
    }

    if(var_75 == 5) {
      var_1 _id_99C5(var_0.sweapon, "ch_camoT2_killstreak5_");
    }
  }

  if(isDefined(var_1.lastweaponswaptime) && gettime() - var_1.lastweaponswaptime < 5000 && !isgunmeleeattack(var_9, var_0.sweapon)) {
    var_1 _id_99C5(var_0.sweapon, "ch_camoT2_switchkill_");

    if(var_33 == "weapon_pistol" && var_1 maps\mp\_utility::_hasperk("specialty_class_shifty")) {
      var_1 processchallenge("ch_dlc1_shifty");
    }

    if(var_1 maps\mp\_utility::_hasperk("specialty_class_wanderlust")) {
      var_1 processchallenge("ch_dlc3_wanderlust");
    }
  }

  if(isDefined(var_1.tookweaponfrom[var_0.sweapon]) && var_1.tookweaponfrom[var_0.sweapon] == var_0.victim && isDefined(var_1.tookweaponkillweapon[var_0.sweapon]) && !isgunmeleeattack(var_9, var_0.sweapon)) {
    var_1 _id_99C5(var_1.tookweaponkillweapon[var_0.sweapon], "ch_camoT2_takeandkill_");
  }

  if(isDefined(var_0.attacker._id_0079) && !isgunmeleeattack(var_9, var_0.sweapon) && !var_14 && !var_13) {
    var_42 = _id_04CA::_id_44A0(var_0.attacker._id_0079);

    switch (var_33) {
      case "weapon_assault":
        if(var_42 == "infantry") {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
        }

        break;
      case "weapon_smg":
        if(var_42 == "airborne") {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
        }

        break;
      case "weapon_heavy":
        if(var_42 == "armored") {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
        }

        break;
      case "weapon_sniper":
        if(var_42 == "mountain") {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
        }

        break;
      case "weapon_shotgun":
        if(var_42 == "expeditionary") {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
        }

        break;
    }

    if(var_31 == "dp28_mp") {
      if(var_42 == "mountain") {
        var_1 _id_99C5(var_0.sweapon, "ch_camoT2_maindivision_");
      } else {
        var_1 _id_99C5(var_0.sweapon, "ch_camoT2_altdivision_");
      }
    }
  }

  if(var_33 == "weapon_launcher") {
    if(isDefined(level.challengeinfo["ch_kills_" + var_31])) {
      var_1 processchallenge("ch_kills_" + var_31);
    }

    if(issubstr(var_0.victim.model, "npc_exo_armor_mp_base")) {
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
      if(isDefined(level.challengeinfo["ch_blood_" + var_31])) {
        var_1 processchallenge("ch_blood_" + var_31);
      }
    }

    if(var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_31 == "iw5_microdronelauncher") {
      if(issubstr(var_31, "dlcgun") && (var_33 == "weapon_assault" || var_33 == "weapon_heavy")) {
        var_1 processchallenge("ch_tier2_2_" + var_31);
      } else {
        var_1 processchallenge("ch_triple_" + var_31);
      }
    }
  }

  var_79 = 0;

  if(isDefined(var_1._id_5DFA)) {
    foreach(var_81 in var_1._id_5DFA) {
      if(var_81 == 0) {
        var_79++;
        continue;
      }

      break;
    }
  }

  if(var_79 == 9) {
    switch (var_33) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        if(issubstr(var_31, "dlcgun") && (var_33 == "weapon_assault" || var_33 == "weapon_heavy" || var_33 == "weapon_special")) {
          var_1 processchallenge("ch_tier2_5_" + var_31);
        } else {
          var_1 processchallenge("ch_noperk_" + var_31);
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

isgunmeleeattack(var_0, var_1) {
  return maps\mp\_utility::ismeleemod(var_0) && _weapontype(var_1) != "melee";
}

_id_6359() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 5;

  if(maps\mp\_utility::isreallyalive(self)) {
    processchallenge("ch_operations_undercover");
  }
}

_id_99C5(var_0, var_1) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }
  var_2 = maps\mp\_utility::_id_45B5(var_0);
  var_3 = var_1 + var_2;
  var_4 = _id_4450(var_3);

  if(isDefined(var_4)) {
    if(ischallengeunlocked(var_3, var_4)) {
      processchallenge(var_3);
    }
  }
}

tier3camochallenge(var_0, var_1) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }
  if(!mayprocesschallenges()) {
    return;
  }
  var_2 = maps\mp\_utility::_id_45B5(var_0);
  var_3 = var_1 + var_2;
  var_4 = _id_4450(var_3);

  if(_tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(), 0, var_2) == -1) {
    return;
  }
  if(!isDefined(self.pers["weaponPrestige"][var_2])) {
    self.pers["weaponPrestige"][var_2] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "weaponStats", var_2, "prestigeLevel");
  }

  if(isDefined(var_4)) {
    if(self.pers["weaponPrestige"][var_2] >= 3) {
      processchallenge(var_3);
    }
  }
}

tier4camochallenge(var_0, var_1) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }
  if(!mayprocesschallenges()) {
    return;
  }
  var_2 = maps\mp\_utility::_id_45B5(var_0);
  var_3 = var_1 + var_2;
  var_4 = _id_4450(var_3);

  if(_tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(), 0, var_2) == -1) {
    return;
  }
  if(!isDefined(self.pers["weaponPrestige"][var_2])) {
    self.pers["weaponPrestige"][var_2] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "weaponStats", var_2, "prestigeLevel");
  }

  if(isDefined(var_4)) {
    if(self.pers["weaponPrestige"][var_2] >= 4) {
      processchallenge(var_3);
    }
  }
}

_id_4450(var_0) {
  if(isDefined(var_0) && isDefined(level.challengeinfo[var_0])) {
    var_1 = level.challengeinfo[var_0]["index"];
    return var_1;
  }
}

get_challenge_weapon_class(var_0, var_1) {
  var_2 = maps\mp\_utility::getweaponclass(var_0);

  if(!isDefined(var_1)) {
    var_1 = maps\mp\_utility::_id_4431(var_0, 1);

    if(maps\mp\_utility::_id_5856(var_1)) {
      var_1 = maps\mp\gametypes\_class::getbasefromlootversion(var_1);
    }
  }

  if(var_1 == "iw5_exocrossbow" || var_1 == "iw5_exocrossbowblops2") {
    return "weapon_special";
  }

  if(var_1 == "iw5_maaws" || var_1 == "iw5_mahem") {
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
      case "hp":
      case "hc":
      case "dom":
      case "koth":
      case "dm":
      case "ctf":
        break;
      default:
        break;
    }
  }
}

playerdamaged(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  self endon("disconnect");

  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  waitframe();
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

  if(isPlayer(var_1)) {
    var_6.attackerinlaststand = isDefined(var_6.attacker._id_00E8);
    var_6.attackeronground = var_6.attacker isonground();
    var_6.attackerstance = var_6.attacker getstance();
  } else {
    var_6.attackerinlaststand = 0;
    var_6.attackeronground = 0;
    var_6.attackerstance = "stand";
  }

  if(isDefined(self) && isDefined(var_1) && isDefined(self.team) && isDefined(var_1.team)) {
    if(self.team != var_1.team && maps\mp\_utility::_hasperk("specialty_class_hunker") && _isexplosivedamagemod(var_6.smeansofdeath) && maps\mp\_utility::isreallyalive(self) && !_id_052D::_id_3154(var_4)) {
      processchallenge("ch_explosives_hunker");
    }

    if(self.team != var_1.team && maps\mp\_utility::_hasperk("specialty_class_primed")) {
      self.lastdamagefromenemytargettime = gettime();
    }
  }

  domissioncallback("playerDamaged", var_6);
}

playerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self._id_0DDF = self getplayerangles();

  if(isDefined(var_1)) {
    var_1._id_0DE0 = var_1 getplayerangles();
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

  if(isPlayer(var_1)) {
    var_8.attackerinlaststand = isDefined(var_8.attacker._id_00E8);
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
  } else if(isDefined(var_1) && isPlayer(var_1)) {
    var_9 = var_1 playerads();
  }

  var_8.was_ads = 0;

  if(var_9 >= 0.2) {
    var_8.was_ads = 1;
  }

  waitandprocessplayerkilledcallback(var_8);

  if(isDefined(var_1) && maps\mp\_utility::isreallyalive(var_1)) {
    var_1.killsthislife[var_1.killsthislife.size] = var_8;
    var_1.recentkills = common_scripts\utility::_id_0F86(var_1.recentkills, var_8, 0);

    if(!isDefined(level.recentkillers)) {
      level.recentkillers = [];
    }

    level.recentkillers = common_scripts\utility::_id_0F86(level.recentkillers, var_1, 0);

    if(level.recentkillers.size >= 4) {
      level.recentkillers = common_scripts\utility::_id_0FA3(level.recentkillers, 0, 4);
      var_10 = 0;

      foreach(var_12 in level.recentkillers) {
        if(var_12 == var_1) {
          var_10++;
          continue;
        }

        break;
      }

      if(var_10 >= 4) {
        var_1 processchallenge("ch_killer_feed");
        level.recentkillers = [];
      }
    }
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
  waitframe();
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
  waitframe();
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
      var_1.winner = isDefined(var_0) && isPlayer(var_0) && var_1.player == var_0;
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

        waitframe();
      }

      var_1 = var_0 - self.origin[2];

      if(var_1 < 0) {
        var_1 = 0;
      }

      if(var_1 / 12.0 > 15 && isalive(self) && maps\mp\_utility::_id_56D7()) {
        processchallenge("ch_boot_shortcut");
      }

      if(var_1 / 12.0 > 30 && !isalive(self) && maps\mp\_utility::_id_56D7()) {
        processchallenge("ch_boot_gravity");
      }
    }

    waitframe();
  }
}

monitorplayermatchchallenges() {
  thread monitormatchchallenges("increment_melee_kills", 15, "ch_precision_slice");
  thread monitormatchchallenges("increment_stuck_kills", 5, "ch_precision_ticktick");
  thread monitormatchchallenges("increment_pistol_headshots", 10, "ch_precision_pistoleer");
  thread monitormatchchallenges("increment_ar_headshots", 5, "ch_precision_headhunt");
  thread monitormatchchallenges("increment_sharpshooter_kills", 10, "ch_precision_sharpshoot");
  thread monitormatchchallenges("increment_oneshotgun_kills", 10, "ch_precision_cqexpert");
  thread monitormatchchallenges("increment_duallethal_kills", 5, "ch_precision_dangerclose");
  thread monitormatchchallenges("increment_lethaldouble_kills", 3, "ch_lethals_firediscipline");
  thread monitormatchchallenges("increment_nemesis_kills", 5, "ch_humiliation_archnemesis");
  thread monitormatchchallenges("increment_resupplylethal_kills", 3, "ch_lethals_resourceful");
  thread monitortier2camomatchchallenges("increment_camo_multidestroy", 5, "ch_camoT2_multidestroy_");
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
    self waittill(var_0, var_3);
    var_4 = game[var_2][self.guid];
    var_4++;
    game[var_2][self.guid] = var_4;

    if(var_4 == var_1) {
      if(isDefined(var_3) && issubstr(var_2, "ch_camoT2_")) {
        _id_99C5(var_3, var_2);
        continue;
      }

      processchallenge(var_2);
    }
  }
}

monitortier2camomatchchallenges(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill(var_0, var_3);
    var_4 = var_2 + var_3;

    if(!isDefined(game[var_4])) {
      game[var_4] = [];
    }

    if(!isDefined(game[var_4][self.guid])) {
      game[var_4][self.guid] = 0;
      thread remove_tracking_on_disconnect(var_4);
    }

    var_5 = game[var_4][self.guid];
    var_5++;
    game[var_4][self.guid] = var_5;

    if(var_5 == var_1) {
      _id_99C5(var_3, var_2);
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

_id_63E5() {
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

_id_4C1F() {
  if(!isalive(self)) {
    return;
  }
  if(!mayprocesschallenges()) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(isDefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy) {
    self.healthregenerationstreak++;

    if(self.healthregenerationstreak >= 5 && maps\mp\_utility::_hasperk("specialty_class_remedy")) {
      processchallenge("ch_dlc4_remedy");
    }
  }
}

healthregeneratedbrinkofdeath() {
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

      if(maps\mp\_utility::_hasperk("specialty_class_remedy")) {
        processchallenge("ch_dlc4_remedy");
      }
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
  if(level.players.size < 2 && !getdvarint("850") && !getdvarint("5357") && !_func_367()) {
    var_3 = undefined;

    if(isDefined(var_3)) {
      if(var_3 == 0) {
        return;
      }
    } else
      return;
  }

  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(isDefined(level.challengeinfo[var_0]) && isDefined(level.challengeinfo[var_0]["requiresPrestige"])) {
    var_4 = level.challengeinfo[var_0]["requiresPrestige"];

    if(var_4 != "") {
      if(maps\mp\gametypes\_rank::getprestigelevel() < int(var_4)) {
        return;
      }
    }
  }

  if(getdvarint("1258", 0) == 1) {
    if(common_scripts\utility::string_starts_with(var_0, "ch_camo") || common_scripts\utility::string_starts_with(var_0, "ch_reticle")) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_5 = getchallengestatus(var_0);

  if(var_5 == 0) {
    return;
  }
  if(var_5 > level.challengeinfo[var_0]["targetval"].size) {
    return;
  }
  var_6 = maps\mp\gametypes\_hud_util::ch_getprogress(var_0);

  if(isDefined(var_2) && var_2) {
    var_7 = var_1;
  } else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(var_0)) {
    var_7 = var_6;
  } else {
    var_7 = var_6 + var_1;
  }

  var_8 = 0;

  for(var_9 = level.challengeinfo[var_0]["targetval"][var_5]; isDefined(var_9) && var_7 >= var_9; var_9 = level.challengeinfo[var_0]["targetval"][var_5 + var_8]) {
    var_8++;
  }

  if(var_6 < var_7) {
    maps\mp\gametypes\_hud_util::ch_setprogress(var_0, var_7);
  }

  if(var_8 > 0) {
    for(var_10 = var_5; var_8; var_8--) {
      thread giverankxpafterwait(var_0, var_5);
      var_11 = _getchallengeid(var_0, var_5);
      var_12 = common_scripts\utility::tostring(var_11);
      var_13 = int(getsubstr(var_12, 0, var_12.size - 2));

      if(!isDefined(game["challengeStruct"]["challengesCompleted"][self.guid])) {
        game["challengeStruct"]["challengesCompleted"][self.guid] = [];
      }

      var_14 = 0;

      foreach(var_16 in game["challengeStruct"]["challengesCompleted"][self.guid]) {
        if(var_16 == var_13) {
          var_14 = 1;
        }
      }

      if(!var_14) {
        game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_13;
      }

      if(var_5 >= level.challengeinfo[var_0]["targetval"].size && level.challengeinfo[var_0]["parent_challenge"] != "") {
        processchallenge(level.challengeinfo[var_0]["parent_challenge"]);
      }

      var_5++;
    }

    if(!issubstr(var_0, "ch_limited_bloodshed") && !issubstr(var_0, "ch_division_iconic_weapon") && !issubstr(var_0, "ch_hq_data")) {
      thread maps\mp\gametypes\_hud_message::challengesplashnotify(var_0, var_10, var_5);
    }

    maps\mp\gametypes\_hud_util::ch_setstate(var_0, var_5);
    self.challengedata[var_0] = var_5;
  }
}

giverankxpafterwait(var_0, var_1) {
  self endon("disconnect");
  wait 0.25;
  maps\mp\gametypes\_rank::giverankxp("challenge", level.challengeinfo[var_0]["reward"][var_1], undefined, undefined, var_0);
}

masterychallengeprocess(var_0) {
  if(tablelookup("mp/allChallengesTable.csv", 0, "ch_" + var_0 + "_mastery", 1) == "") {
    return;
  }
  var_1 = 0;
  var_2 = maps\mp\_utility::_id_4723(var_0);

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
  var_2 = _tablelookupbyrow("mp/allChallengesTable.csv", var_1, 8);

  if(var_2 != "") {
    var_3 = getchallengestatus(var_2);

    if(var_3 > 1) {
      return 1;
    }
  }

  var_4 = _tablelookupbyrow("mp/allChallengesTable.csv", var_1, 6);

  if(var_4 != "") {
    var_5 = maps\mp\gametypes\_rank::getrank();

    if(var_5 < int(var_4)) {
      return 0;
    }
  }

  var_6 = _tablelookupbyrow("mp/allChallengesTable.csv", var_1, 7);

  if(var_6 != "") {
    var_7 = getchallengestatus(var_6);

    if(var_7 <= level.challengeinfo[var_6]["targetval"].size) {
      return 0;
    }
  }

  return 1;
}

updatechalleges() {
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

  if(!isDefined(self.pers["weaponPrestige"])) {
    self.pers["weaponPrestige"] = [];
  }

  self endon("disconnect");

  if(!mayprocesschallenges()) {
    return;
  }
  if(!self isitemunlocked2("challenges")) {
    return;
  }
  var_0 = 0;
  var_1 = getdvarint("spv_challenge_mastery_completion", 0) == 1;

  foreach(var_6, var_3 in level.challengeinfo) {
    var_0++;

    if(var_0 % 40 == 0) {
      waitframe();
    }

    if(_func_367() && !_id_5680(var_6)) {
      continue;
    }
    self.challengedata[var_6] = 0;
    var_4 = var_3["index"];
    var_5 = maps\mp\gametypes\_hud_util::ch_getstate(var_6);

    if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_6) && !isDefined(game["challengeStruct"]["limitedChallengesReset"][self.guid])) {
      maps\mp\gametypes\_hud_util::ch_setprogress(var_6, 0);
      var_5 = 0;
    }

    if(var_5 == 0) {
      maps\mp\gametypes\_hud_util::ch_setstate(var_6, 1);
      var_5 = 1;
    }

    self.challengedata[var_6] = var_5;

    if(common_scripts\utility::_id_562E(var_1) && issubstr(var_6, "_master")) {
      processchallenge(var_6, 0);
    }
  }

  game["challengeStruct"]["limitedChallengesReset"][self.guid] = 1;
}

_id_5680(var_0) {
  return tablelookup("mp/allChallengesTable.csv", 0, var_0, 44) != "";
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
  if(isDefined(getweaponfromchallenge(var_0))) {
    return 1;
  }

  return 0;
}

getweaponfromchallenge(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = getchallengefilter(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = strtok(var_1, "_");

  if(var_2[0] == "challenge") {
    var_3 = undefined;

    for(var_4 = 1; var_4 < var_2.size; var_4++) {
      if(isDefined(var_3)) {
        var_3 = var_3 + "_" + var_2[var_4];
        continue;
      }

      var_3 = var_2[var_4];
    }

    if(isDefined(var_3) && (maps\mp\gametypes\_class::isvalidprimary(var_3) || maps\mp\gametypes\_class::isvalidsecondary(var_3, 0))) {
      return var_3;
    }
  }

  return undefined;
}

getweaponattachmentfromchallenge(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = getchallengefilter(var_0);

  if(!isDefined(var_1) || var_1 != "attachment") {
    return undefined;
  }

  var_2 = strtok(var_0, "_");

  if(var_2.size > 0) {
    var_3 = var_2[var_2.size - 1];

    if(isDefined(var_3) && maps\mp\_utility::isattachment(var_3)) {
      return var_3;
    }
  }

  return undefined;
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
    var_4 = _tablelookupbyrow(var_0, var_3, 0);

    if(var_4 == "") {
      break;
    }

    if(issubstr(var_4, "ch_daily")) {
      continue;
    }
    var_5 = _tablelookupbyrow(var_0, var_3, 43);

    if(var_5 == "1") {
      continue;
    }
    level.challengeinfo[var_4] = [];
    level.challengeinfo[var_4]["index"] = var_3;
    level.challengeinfo[var_4]["type"] = var_1;
    level.challengeinfo[var_4]["targetval"] = [];
    level.challengeinfo[var_4]["reward"] = [];
    level.challengeinfo[var_4]["parent_challenge"] = "";
    level.challengeinfo[var_4]["requiresPrestige"] = _tablelookupbyrow("mp/allChallengesTable.csv", var_3, 45);

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

    for(var_9 = 1; var_9 < 10; var_9++) {
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

  if(getDvar("4017") == "1" && !_func_367()) {
    return;
  }
  var_0 = 0;
  var_0 = var_0 + buildchallengetableinfo("mp/allChallengesTable.csv", 0);
  _id_1D43();
}

_id_1D43() {
  var_0 = 0;

  for(;;) {
    var_1 = _tablelookupbyrow("mp/dailychallengesTable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    level.challengeinfo[var_1] = [];
    level.challengeinfo[var_1]["index"] = var_0;
    level.challengeinfo[var_1]["type"] = 1;
    level.challengeinfo[var_1]["targetval"] = [];
    level.challengeinfo[var_1]["reward"] = [];
    level.challengeinfo[var_1]["targetval"] = challenge_targetval("mp/dailychallengesTable.csv", var_1, 1);
    level.challengeinfo[var_1]["reward"] = challenge_rewardval("mp/dailychallengesTable.csv", var_1, 1);
    var_0++;
  }
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
    if(!isDefined(self.killstreaks)) {
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
      processchallenge("ch_shield_damage", var_1);
      break;
    case "shield_bullet_hits":
      processchallenge("ch_shield_bullet", var_1);
      break;
    case "shield_explosive_hits":
      processchallenge("ch_shield_explosive", var_1);
      break;
  }
}

playerhasammo() {
  var_0 = self getweaponlistprimaries();

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
  self._id_0A12 = 0.0;

  for(;;) {
    if(self playerads() == 1) {
      self._id_0A12 = self._id_0A12 + 0.05;
    } else {
      self._id_0A12 = 0.0;
    }

    waitframe();
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

    waitframe();
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
  level endon("game_ended");
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
      if(self isitemunlocked2("specialty_fastmantle") && maps\mp\_utility::_hasperk("specialty_fastmantle")) {
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

_id_63FA() {
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
    if(maps\mp\_utility::isbombsiteweapon(var_1) || maps\mp\_utility::isuseweapon(var_1)) {
      continue;
    }
    self.lastweaponswaptime = gettime();
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
    self._id_5B9C = gettime();
  }
}

monitorconcussion() {
  self endon("disconnect");

  for(;;) {
    self waittill("concussed", var_0);

    if(self == var_0) {
      continue;
    }
    self._id_5B86 = gettime();
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

  if(maps\mp\_utility::_hasperk("specialty_class_flanker")) {
    thread processchallenge("ch_operations_flanker");
  }
}

is_lethal_equipment(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "frag_grenade_german_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 1;
    default:
      return 0;
  }
}

ch_monitorkillerdoingwork(var_0) {
  self endon("disconnect");
  self endon("death");
  self notify("monitorKillerDoingWork");
  self endon("monitorKillerDoingWork");
  self waittill("ch_capture", var_1);

  if(var_1 == var_0) {
    thread processchallenge("ch_killer_doingwork");
  }
}

_id_18AC() {
  if(!isDefined(self._id_18AE) || !isDefined(self.killsthislife) || self.killsthislife.size == 0) {
    self._id_18AE = 0;
  }

  self._id_18AE++;

  if(isDefined(self._id_18AE) && self._id_18AE == 5) {
    processchallenge("ch_combathandling_bodycount");
    self._id_18AE = 0;
  }
}

_id_34C3() {
  if(!isDefined(self._id_0BA8) || !isDefined(self.killsthislife) || self.killsthislife.size == 0) {
    self._id_0BA8 = 0;
  }

  self._id_0BA8++;

  if(isDefined(self._id_0BA8) && self._id_0BA8 == 3) {
    processchallenge("ch_combathandling_rungun");
    self._id_0BA8 = 0;
  }
}

playrumblelooponentity(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!var_4) {
    return;
  }
  if(issubstr(var_1, "aperture_sight") || issubstr(var_1, "telescopic") || issubstr(var_1, "lens_sight")) {
    var_9 = maps\mp\_utility::_id_45B5(var_3);
    var_10 = undefined;

    if(issubstr(var_1, "aperture_sight")) {
      var_10 = "nydar";
    } else if(issubstr(var_1, "telescopic")) {
      var_10 = "optic";
    } else if(issubstr(var_1, "lens_sight")) {
      var_10 = "lens";
    }

    var_0 processchallenge("ch_reticle_" + var_10 + "_kill_" + var_9);

    if(var_5) {
      var_0 _id_99C5(var_9, "ch_reticle_" + var_10 + "_headshot_");
    }

    if(var_6) {
      var_0 _id_99C5(var_9, "ch_reticle_" + var_10 + "_longshot_");
    }

    if(isDefined(var_0.recentkills) && var_0.recentkills.size >= 1) {
      var_11 = 1;

      for(var_12 = 0; var_12 < var_0.recentkills.size; var_12++) {
        var_13 = maps\mp\_utility::_id_45B5(var_0.recentkills[var_12].sweapon);
        var_14 = issubstr(var_0.recentkills[var_12].sweapon, var_1);

        if(var_0.recentkills[var_12].was_ads && var_13 == var_9 && var_14) {
          var_11++;
          continue;
        }

        break;
      }

      if(var_11 == 2) {
        var_0 _id_99C5(var_9, "ch_reticle_" + var_10 + "_doublekill_");
      }
    }

    if(isDefined(var_0.killsthislife) && var_0.killsthislife.size >= 4) {
      var_11 = 1;

      foreach(var_16 in var_0.killsthislife) {
        var_13 = maps\mp\_utility::_id_45B5(var_16.sweapon);
        var_14 = issubstr(var_16.sweapon, var_1);

        if(var_16.was_ads && var_13 == var_9 && var_14) {
          var_11++;
        }
      }

      if(var_11 == 5) {
        var_0 _id_99C5(var_9, "ch_reticle_" + var_10 + "_streaking_");
      }
    }
  }
}

_id_80BB(var_0, var_1) {
  var_2 = _id_047A::_id_43D6(var_0, var_1);

  if(var_2 == "fighter_strike_kill" || var_2 == "fritzx_kill" || var_2 == "firebomb_kill" || var_2 == "airstrike_kill" || var_2 == "plane_gunner_kill") {
    processchallenge("ch_streak_closeairsupport");
  }

  if(var_2 == "mortar_strike_kill" || var_2 == "missile_strike_kill") {
    processchallenge("ch_streak_firesupport");
  }

  if(var_2 == "molotovs_kill" || var_2 == "flamethrower_kill") {
    processchallenge("ch_streak_hotpoint");
  }
}

_id_0B9D() {
  var_0 = isDefined(level._id_3CE0) && level._id_3CE0 == self;
  var_1 = 0;

  if(level.teambased && isDefined(level.uavmodels)) {
    if(isDefined(level.uavmodels)) {
      foreach(var_3 in level.uavmodels[self.team]) {
        if(var_3._id_01C8 == "counter_uav" && isDefined(var_3._id_0117) && var_3._id_0117 == self) {
          var_1 = 1;
          break;
        }
      }
    }
  } else
    var_5 = isDefined(level._id_2694) && level._id_2694 == self;

  if(var_0 || var_1) {
    processchallenge("ch_streak_airsuperiority");
  }
}