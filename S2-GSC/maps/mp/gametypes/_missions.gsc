/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_missions.gsc
*********************************************/

init() {
  setdvarifuninitialized("spv_challenge_mastery_completion", 0);
  precachestring(&"MP_CHALLENGE_COMPLETED");
  if(!mayprocesschallenges()) {
    return;
  }

  level.var_4B0B = ["extended_mag", "grip", "fast_ads", "ads_move_speed", "akimbo", "reduced_sway"];
  level.var_35A8 = ["extended_range", "rapid_fire", "head_damage", "suppressor", "hipfire"];
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

  if(function_0367()) {
    if(function_0371()) {
      return 0;
    } else {
      return 1;
    }
  }

  if(function_03AF()) {
    return 0;
  }

  return level.rankedmatch;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(isbot(var_00)) {
      continue;
    }

    if(!isDefined(var_00.pers["postGameChallenges"])) {
      var_00.pers["postGameChallenges"] = 0;
    }

    var_00 thread initmissiondata();
    if(!function_0367()) {
      var_00 thread onplayerspawned();
      var_00 thread monitorbombuse();
      var_00 thread monitorstreaks();
      var_00 thread monitorscavengerpickup();
      var_00 thread monitorkillstreakprogress();
      var_00 thread monitorfinalstandsurvival();
      var_00 thread func_63B2();
      var_00 thread func_63FA();
      var_00 thread monitorplayermatchchallenges();
      var_00 notifyonplayercommand("jumped", "+goStand");
      var_00 thread monitormantle();
      var_00.streaksdestroyedthislife = [];
    } else {
      var_00 thread lib_0468::ae_sendzmskinunlockevent();
    }

    var_00 thread monitorprocesschallenge();
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

    wait 0.05;
  }
}

monitorfinalstandsurvival() {
  self endon("disconnect");
  for(;;) {
    self waittill("revive");
    processchallenge("ch_livingdead");
    wait 0.05;
  }
}

initmissiondata() {
  while(!isDefined(level.killstreakfuncs)) {
    wait 0.05;
  }

  var_00 = getarraykeys(level.killstreakfuncs);
  foreach(var_02 in var_00) {
    self.pers[var_02] = 0;
  }

  self.pers["lastBulletKillTime"] = 0;
  self.pers["bulletStreak"] = 0;
  self.explosiveinfo = [];
}

registermissioncallback(param_00, param_01) {
  if(!isDefined(level.missioncallbacks[param_00])) {
    level.missioncallbacks[param_00] = [];
  }

  level.missioncallbacks[param_00][level.missioncallbacks[param_00].size] = param_01;
}

getchallengestatus(param_00) {
  if(isDefined(self.challengedata[param_00])) {
    return self.challengedata[param_00];
  }

  return 0;
}

ch_assists(param_00) {
  var_01 = param_00.player;
  var_01 processchallenge("ch_assists");
}

ch_streak_kill(param_00) {
  var_01 = 3;
  var_02 = 4;
  var_03 = 2;
  processchallenge("ch_career_killstreakkills");
  switch (param_00) {
    case "fighter_strike_kill":
      processchallenge("ch_streak_fighterstrike");
      if(!isDefined(self.var_3AAA)) {
        self.var_3AAA = 0;
      }

      self.var_3AAA = self.var_3AAA + 1;
      if(self.var_3AAA == var_01) {
        processchallenge("ch_streak_ontarget");
      }
      break;

    case "fritzx_kill":
      processchallenge("ch_streak_fritzx");
      if(!isDefined(self.var_3EE8)) {
        self.var_3EE8 = 0;
      }

      self.var_3EE8 = self.var_3EE8 + 1;
      if(self.var_3EE8 == var_01) {
        processchallenge("ch_streak_ontarget");
      }
      break;

    case "firebomb_kill":
      processchallenge("ch_streak_firebomb");
      if(!isDefined(self.var_3BD6)) {
        self.var_3BD6 = 0;
      }

      self.var_3BD6 = self.var_3BD6 + 1;
      if(self.var_3BD6 == var_02) {
        processchallenge("ch_streak_rainingdeath");
      }
      break;

    case "airstrike_kill":
      processchallenge("ch_streak_airstrike");
      if(!isDefined(self.var_B95)) {
        self.var_B95 = 0;
      }

      self.var_B95 = self.var_B95 + 1;
      if(self.var_B95 == var_02) {
        processchallenge("ch_streak_rainingdeath");
      }
      break;

    case "plane_gunner_kill":
      processchallenge("ch_streak_planegunner");
      if(!isDefined(self.var_7036)) {
        self.var_7036 = 0;
      }

      self.var_7036 = self.var_7036 + 1;
      if(self.var_7036 == var_02) {
        processchallenge("ch_streak_rainingdeath");
      }
      break;

    case "molotovs_kill":
      processchallenge("ch_streak_molotovs");
      if(!isDefined(self.var_62C3)) {
        self.var_62C3 = 0;
      }

      self.var_62C3 = self.var_62C3 + 1;
      if(self.var_62C3 == var_03) {
        processchallenge("ch_streak_flamed");
      }
      break;

    case "flamethrower_kill":
      processchallenge("ch_streak_flamethrower");
      if(!isDefined(self.var_3D1D)) {
        self.var_3D1D = 0;
      }

      self.var_3D1D = self.var_3D1D + 1;
      if(self.var_3D1D == var_03) {
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

ch_hardpoints(param_00) {
  if(isbot(param_00.player)) {
    return;
  }

  var_01 = param_00.player;
  var_01.pers[param_00.hardpointtype]++;
  switch (param_00.hardpointtype) {
    case "uav":
      var_01 processchallenge("ch_uav");
      var_01 processchallenge("ch_assault_streaks");
      if(var_01.pers["uav"] >= 3) {
        var_01 processchallenge("ch_nosecrets");
      }
      break;

    case "airdrop_assault":
      var_01 processchallenge("ch_airdrop_assault");
      var_01 processchallenge("ch_assault_streaks");
      break;

    case "airdrop_sentry_minigun":
      var_01 processchallenge("ch_airdrop_sentry_minigun");
      var_01 processchallenge("ch_assault_streaks");
      break;

    case "nuke":
      var_01 processchallenge("ch_nuke");
      break;
  }
}

ch_vehicle_kills(param_00) {
  if(!isDefined(param_00.attacker) || !isPlayer(param_00.attacker)) {
    return;
  }

  if(!maps\mp\_utility::iskillstreakweapon(param_00.sweapon)) {
    return;
  }

  var_01 = param_00.attacker;
  if(!isDefined(var_01.pers[param_00.sweapon + "_streak"]) || isDefined(var_01.pers[param_00.sweapon + "_streakTime"]) && gettime() - var_01.pers[param_00.sweapon + "_streakTime"] > 7000) {
    var_01.pers[param_00.sweapon + "_streak"] = 0;
    var_01.pers[param_00.sweapon + "_streakTime"] = gettime();
  }

  var_01.pers[param_00.sweapon + "_streak"]++;
  switch (param_00.sweapon) {
    case "artillery_mp":
      var_01 processchallenge("ch_carpetbomber");
      if(var_01.pers[param_00.sweapon + "_streak"] >= 5) {
        var_01 processchallenge("ch_carpetbomb");
      }

      if(isDefined(var_01.finalkill)) {
        var_01 processchallenge("ch_finishingtouch");
      }
      break;

    case "stealth_bomb_mp":
      var_01 processchallenge("ch_thespirit");
      if(var_01.pers[param_00.sweapon + "_streak"] >= 6) {
        var_01 processchallenge("ch_redcarpet");
      }

      if(isDefined(var_01.finalkill)) {
        var_01 processchallenge("ch_technokiller");
      }
      break;

    case "sentry_minigun_mp":
      var_01 processchallenge("ch_looknohands");
      if(isDefined(var_01.finalkill)) {
        var_01 processchallenge("ch_absentee");
      }
      break;

    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
      var_01 processchallenge("ch_spectre");
      if(isDefined(var_01.finalkill)) {
        var_01 processchallenge("ch_deathfromabove");
      }
      break;

    case "remotemissile_projectile_mp":
      var_01 processchallenge("ch_predator");
      if(var_01.pers[param_00.sweapon + "_streak"] >= 4) {
        var_01 processchallenge("ch_reaper");
      }

      if(isDefined(var_01.finalkill)) {
        var_01 processchallenge("ch_dronekiller");
      }
      break;

    default:
      break;
  }
}

ch_vehicle_killed(param_00) {
  if(!isDefined(param_00.attacker) || !isPlayer(param_00.attacker)) {
    return;
  }

  var_01 = param_00.attacker;
  var_02 = maps\mp\_utility::getbaseweaponname(param_00.sweapon, 1);
  if(maps\mp\_utility::islootweapon(var_02)) {
    var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
  }

  var_03 = get_challenge_weapon_class(param_00.sweapon, var_02);
  if(var_03 == "weapon_projectile") {
    if(isDefined(level.challengeinfo["ch_vehicle_" + var_02])) {
      var_01 processchallenge("ch_vehicle_" + var_02);
    }

    if(isDefined(level.challengeinfo["ch_marksman_" + var_02]) && var_02 != "dp28_mp") {
      var_01 processchallenge("ch_marksman_" + var_02);
    }
  }

  if(var_01 maps\mp\_utility::_hasperk("specialty_coldblooded") && var_01 maps\mp\_utility::_hasperk("specialty_spygame") && var_01 maps\mp\_utility::_hasperk("specialty_heartbreaker")) {
    if(!isDefined(param_00.vehicle) || !isDefined(param_00.vehicle.sentrytype) || param_00.vehicle.sentrytype != "prison_turret") {
      var_01 processchallenge("ch_precision_airhunt");
    }
  }

  if(isDefined(param_00.vehicle) && isDefined(param_00.vehicle.var_1C8) && param_00.vehicle.var_1C8 == "drone_recon" && issubstr(var_02, "exoknife")) {
    var_01 processchallenge("ch_precision_knife");
  }

  if(issubstr(param_00.sweapon, "rapid_fire") && issubstr(param_00.sweapon, "fmj")) {
    var_01 processchallenge("ch_combatefficiency_hotlead");
  }
}

clearidshortly(param_00) {
  self endon("disconnect");
  self notify("clearing_expID_" + param_00);
  self endon("clearing_expID_" + param_00);
  wait(3);
  self.explosivekills[param_00] = undefined;
}

mgkill() {
  var_00 = self;
  if(!isDefined(var_00.pers["MGStreak"])) {
    var_00.pers["MGStreak"] = 0;
    var_00 thread endmgstreakwhenleavemg();
    if(!isDefined(var_00.pers["MGStreak"])) {
      return;
    }
  }

  var_00.pers["MGStreak"]++;
  if(var_00.pers["MGStreak"] >= 5) {
    var_00 processchallenge("ch_mgmaster");
  }
}

endmgstreakwhenleavemg() {
  self endon("disconnect");
  for(;;) {
    if(!isalive(self) || self useButtonPressed()) {
      self.pers["MGStreak"] = undefined;
      break;
    }

    wait 0.05;
  }
}

endmgstreak() {
  self.pers["MGStreak"] = undefined;
}

killedbestenemyplayer(param_00) {
  if(!isDefined(self.pers["countermvp_streak"]) || !param_00) {
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

ishighestscoringplayer(param_00) {
  if(!isDefined(param_00.score) || param_00.score < 1) {
    return 0;
  }

  var_01 = level.players;
  if(level.teambased) {
    var_02 = param_00.pers["team"];
  } else {
    var_02 = "all";
  }

  var_03 = param_00.score;
  for(var_04 = 0; var_04 < var_01.size; var_04++) {
    if(!isDefined(var_01[var_04].score)) {
      continue;
    }

    if(var_01[var_04].score < 1) {
      continue;
    }

    if(var_02 != "all" && var_01[var_04].pers["team"] != var_02) {
      continue;
    }

    if(var_01[var_04].score > var_03) {
      return 0;
    }
  }

  return 1;
}

func_7752(param_00) {
  if(!isDefined(self.challengedata) || !isDefined(self.challengedata[param_00])) {
    return;
  }

  if(self.challengedata[param_00] != 2) {
    return;
  }

  if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::privatematch()) {
    return;
  }

  var_01 = maps\mp\gametypes\_hud_util::ch_getprogress(param_00);
  if(var_01 >= level.challengeinfo[param_00]["targetval"]) {
    return;
  }

  var_02 = var_01 + 1;
  if(var_02 == level.challengeinfo[param_00]["targetval"]) {
    thread maps\mp\gametypes\_hud_message::func_9102(param_00 + "_complete");
    self.challengedata[param_00] = 3;
    maps\mp\gametypes\_hud_util::ch_setstate(param_00, 3);
    return;
  }

  maps\mp\gametypes\_hud_util::ch_setprogress(param_00, var_02);
}

ch_kills(param_00) {
  param_00.victim playerdied();
  if(!isDefined(param_00.attacker) || !isPlayer(param_00.attacker)) {
    return;
  } else {
    var_01 = param_00.attacker;
  }

  if(isbot(var_01)) {
    return;
  }

  var_01 func_7752("ch_daily_0");
  if(param_00.smeansofdeath == "MOD_HEAD_SHOT") {
    var_01 func_7752("ch_daily_1");
  }

  var_02 = 0;
  var_03 = 0;
  var_04 = 1;
  var_05[param_00.victim.name] = param_00.victim.name;
  var_06[param_00.sweapon] = param_00.sweapon;
  var_07 = 1;
  var_08 = [];
  var_09 = param_00.smeansofdeath;
  var_0A = param_00.time;
  var_0B = function_0061(param_00.sweapon);
  var_0C = 0;
  if(isDefined(var_01.pickedupweaponfrom[param_00.sweapon]) && !maps\mp\_utility::ismeleemod(var_09)) {
    var_0C++;
  }

  var_0D = maps\mp\_utility::iskillstreakweapon(param_00.sweapon);
  var_0E = maps\mp\_utility::isenvironmentweapon(param_00.sweapon);
  var_0F = 0;
  if(var_09 == "MOD_HEAD_SHOT") {
    var_0F = 1;
  }

  var_10 = 0;
  var_11 = 0;
  if(isDefined(param_00.modifiers["longshot"])) {
    var_10 = 1;
    var_11++;
  }

  var_12 = param_00.was_ads;
  var_13 = 0;
  if(var_01.recentkillcount == 2) {
    var_13 = 1;
  }

  var_14 = 0;
  if(var_01.recentkillcount == 3) {
    var_14 = 1;
  }

  var_15 = "";
  if(isDefined(param_00.attackerstance)) {
    var_15 = param_00.attackerstance;
  }

  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_1A = 0;
  var_1B = 0;
  switch (var_01.killsthislife.size + 1) {
    case 5:
      var_16 = 1;
      break;

    case 10:
      var_17 = 1;
      break;

    case 15:
      var_18 = 1;
      break;

    case 20:
      var_19 = 1;
      break;

    case 25:
      var_1A = 1;
      break;

    case 30:
      var_1B = 1;
      break;

    default:
      break;
  }

  foreach(var_1D in var_01.killsthislife) {
    if(maps\mp\_utility::iscacsecondaryweapon(var_1D.sweapon) && !maps\mp\_utility::ismeleemod(var_1D.smeansofdeath)) {
      var_03++;
    }

    if(isDefined(var_1D.modifiers["longshot"])) {
      var_11++;
    }

    if(var_11 == 3) {
      var_01 processchallenge("ch_precision_farsight");
    }

    if(var_0A - var_1D.time < 10000) {
      var_04++;
    }

    if(isDefined(var_01.pickedupweaponfrom[var_1D.sweapon]) && !maps\mp\_utility::ismeleemod(var_1D.smeansofdeath)) {
      var_0C++;
      if(var_0C == 5) {
        var_01 processchallenge("ch_humiliation_finders");
      }
    }

    if(maps\mp\_utility::iskillstreakweapon(var_1D.sweapon)) {
      if(!isDefined(var_08[var_1D.sweapon])) {
        var_08[var_1D.sweapon] = 0;
      }

      var_08[var_1D.sweapon]++;
      continue;
    }

    if(isDefined(level.onelefttime[var_01.team]) && var_1D.time > level.onelefttime[var_01.team]) {
      var_02++;
    }

    if(isDefined(var_1D.victim)) {
      if(!isDefined(var_05[var_1D.victim.name]) && !isDefined(var_06[var_1D.sweapon]) && !maps\mp\_utility::iskillstreakweapon(var_1D.sweapon)) {
        var_07++;
      }

      var_05[var_1D.victim.name] = var_1D.victim.name;
    }

    var_06[var_1D.sweapon] = var_1D.sweapon;
  }

  var_1F = maps\mp\_utility::func_45B5(param_00.sweapon);
  var_20 = var_1F;
  if(common_scripts\utility::string_starts_with(var_1F, "iw5_")) {
    var_20 = getsubstr(var_1F, 4);
  }

  var_21 = get_challenge_weapon_class(param_00.sweapon, var_1F);
  if(level.teambased) {
    if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_01.killedplayers.size >= level.teamcount[param_00.victim.pers["team"]]) {
      var_01 processchallenge("ch_precision_cleanhouse");
    }
  }

  if(isDefined(var_01.explosive_drone_owner) && param_00.victim == var_01.explosive_drone_owner) {
    var_01 processchallenge("ch_precision_protected");
  }

  var_22 = undefined;
  if(maps\mp\_utility::func_57E5(param_00.sweapon, "alt_")) {
    var_22 = getsubstr(param_00.sweapon, 4);
  }

  if(isDefined(var_01.pickedupweaponfrom[param_00.sweapon]) || isDefined(var_22) && isDefined(var_01.pickedupweaponfrom[var_22])) {
    if(!maps\mp\_utility::ismeleemod(var_09)) {
      var_01 processchallenge("ch_boot_stolen");
    }
  }

  if(var_15 == "crouch") {
    var_01 processchallenge("ch_boot_crouch");
  }

  if(var_15 == "prone") {
    var_01 processchallenge("ch_boot_prone");
  }

  if(isDefined(param_00.modifiers["assaultObjective"])) {
    var_01 processchallenge("ch_heroics_assault");
    var_23 = 1;
    var_24 = 1;
    for(var_25 = 0; var_25 < var_01.recentkills.size; var_25++) {
      if(isDefined(var_01.recentkills[var_25].modifiers["assaultObjective"])) {
        var_23++;
        if(var_01.recentkills[var_25].modifiers["assaultObjective"] == param_00.modifiers["assaultObjective"]) {
          var_24++;
        }

        continue;
      }

      break;
    }

    if(var_23 == 2) {
      var_01 processchallenge("ch_killer_aggression");
    }

    if(var_24 == 3) {
      var_01 thread ch_monitorkillerdoingwork(param_00.modifiers["assaultObjective"]);
    }
  }

  if(isDefined(param_00.modifiers["defendObjective"])) {
    var_01 processchallenge("ch_heroics_defender");
    var_26 = 1;
    for(var_25 = 0; var_25 < var_01.recentkills.size; var_25++) {
      if(isDefined(var_01.recentkills[var_25].modifiers["defendObjective"])) {
        var_26++;
        continue;
      }

      break;
    }

    if(var_26 == 2) {
      var_01 processchallenge("ch_killer_rejection");
    }

    var_27 = 1;
    foreach(var_1D in var_01.killsthislife) {
      if(isDefined(var_1D.modifiers["defendObjective"]) && var_1D.modifiers["defendObjective"] == param_00.modifiers["defendObjective"]) {
        var_27++;
      }
    }

    if(var_27 == 5) {
      var_01 processchallenge("ch_killer_resistance");
    }
  }

  if(!isDefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges) {
    if(isDefined(param_00.attacker.var_79) && !var_0E && !var_0D) {
      var_2A = maps\mp\gametypes\_divisions::func_44A0(param_00.attacker.var_79);
      if(var_2A == "infantry") {
        var_01 processchallenge("ch_infantry_kills");
        if(var_21 == "weapon_assault" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_infantry_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["divisions_infantry_kill"])) {
          var_01 processchallenge("ch_infantry_skill");
        }
      } else if(var_2A == "airborne") {
        var_01 processchallenge("ch_airborne_kills");
        if(var_21 == "weapon_smg" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_airborne_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["divisions_airborne_kill"])) {
          var_01 processchallenge("ch_airborne_skill");
        }
      } else if(var_2A == "armored") {
        var_01 processchallenge("ch_armored_kills");
        if(var_21 == "weapon_heavy" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_armored_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["divisions_armored_kill"])) {
          var_01 processchallenge("ch_armored_skill");
        }
      } else if(var_2A == "mountain") {
        var_01 processchallenge("ch_mountain_kills");
        if(var_21 == "weapon_sniper" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_mountain_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["divisions_mountain_kill"])) {
          var_01 processchallenge("ch_mountain_skill");
        }
      } else if(var_2A == "expeditionary") {
        var_01 processchallenge("ch_expeditionary_kills");
        if(var_21 == "weapon_shotgun" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_expeditionary_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["divisions_cavalry_kill"])) {
          var_01 processchallenge("ch_expeditionary_skill");
        }
      } else if(var_2A == "resistance") {
        var_01 processchallenge("ch_resistance_kills");
        if(var_21 == "weapon_pistol" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_resistance_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["division_resistance_kill"])) {
          var_01 processchallenge("ch_resistance_skill");
        }
      } else if(var_2A == "grenadier") {
        var_01 processchallenge("ch_grenadier_kills");
        if(issubstr(var_1F, "riotshield_mp")) {
          var_01 processchallenge("ch_grenadier_weapon");
        }
      } else if(var_2A == "commando") {
        var_01 processchallenge("ch_commando_kills");
      } else if(var_2A == "scout") {
        var_01 processchallenge("ch_scout_kills");
        if(var_21 == "weapon_sniper" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_scout_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["division_scout_kill"])) {
          var_01 processchallenge("ch_scout_skill");
        }
      } else if(var_2A == "artillery") {
        var_01 processchallenge("ch_artillery_kills");
        if(var_21 == "weapon_assault" && !maps\mp\_utility::ismeleemod(var_09)) {
          var_01 processchallenge("ch_artillery_weapon");
        }

        if(common_scripts\utility::func_562E(param_00.modifiers["division_artillery_kill"])) {
          var_01 processchallenge("ch_artillery_skill");
        }
      }
    }
  }

  if(param_00.victim != param_00.attacker) {
    var_2B = !level.teambased || param_00.victim.team != param_00.attacker.team;
    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_radarimmune")) {
      var_2C = 0;
      if(isDefined(level.var_9FDA)) {
        if(level.teambased) {
          var_2C = level.var_9FDA[maps\mp\_utility::getotherteam(param_00.attacker.team)].size;
        } else if(level.var_9FDA.size > 0) {
          var_2D = 0;
          foreach(var_2F in level.var_9FDA) {
            if(var_2F.owner == var_01) {
              var_2D++;
            }
          }

          if(var_2D > 0) {
            var_2C = level.var_9FDA.size - var_2D;
          } else {
            var_2C = level.var_9FDA.size;
          }
        }
      }

      if(var_2C > 0) {
        var_01 processchallenge("ch_perks1_lowprofile");
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_requisitions") && var_0D) {
      var_01 processchallenge("ch_field_requisitions");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_duelist") && var_21 == "weapon_pistol") {
      foreach(var_32 in var_0B) {
        if(issubstr(var_32, "akimbo")) {
          var_01 processchallenge("ch_marksman_duelist");
          break;
        }
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_inconspicuous") && var_15 == "crouch") {
      var_01 processchallenge("ch_physical_inconspicuous");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_scoped") && var_01 adsButtonPressed()) {
      var_01 processchallenge("ch_marksman_scoped");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_energetic") && isDefined(var_01.var_5BE3) && gettime() - var_01.var_5BE3 < 5000) {
      var_01 processchallenge("ch_physical_energetic");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_undercover")) {
      var_01 thread func_6359();
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_hustle") && isDefined(var_01.var_5BD6) && gettime() - var_01.var_5BD6 < 5000) {
      var_01 processchallenge("ch_physical_hustle");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_lookout") && var_10) {
      var_01 processchallenge("ch_operations_lookout");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_gunslinger") && var_01 issprinting()) {
      var_01 processchallenge("ch_physical_gunslinger");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor")) {
      var_01 processchallenge("ch_perk_blast");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_delaymine")) {
      var_34 = 0;
      if(isDefined(level.var_9FDA)) {
        if(level.teambased) {
          foreach(var_2F in level.var_9FDA[maps\mp\_utility::getotherteam(var_01.team)]) {
            if(isDefined(var_2F.var_9FE0) && var_2F.var_9FE0 == "counter") {
              var_34 = 1;
              break;
            }
          }

          if(isDefined(level.var_35F5) && level.var_35F5.team != var_01.team) {
            var_34 = 1;
          }
        } else {
          foreach(var_2F in level.var_9FDA) {
            if(isDefined(var_2F.var_9FE0) && var_2F.var_9FE0 == "counter" && isDefined(var_2F.owner) && !var_2F.owner == var_01) {
              var_34 = 1;
              break;
            }
          }
        }
      }

      if(var_34) {
        var_01 processchallenge("ch_perk_hardwire");
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_serrated") && issubstr(var_1F, "throwingknife_mp")) {
      var_01 processchallenge("ch_field_serrated");
    }

    var_39 = maps\mp\_utility::getweaponclass(param_00.sweapon);
    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_launched") && var_39 == "weapon_projectile") {
      var_01 processchallenge("ch_explosives_launched");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_rifleman")) {
      if(isDefined(var_01.var_5BD0) && gettime() - var_01.var_5BD0 < 5000) {
        var_01 processchallenge("ch_marksman_rifleman");
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_primed")) {
      if(isDefined(var_01.var_5B8B) && gettime() - var_01.var_5B8B < 2000) {
        var_01 processchallenge("ch_marksman_primed");
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_forage") && isDefined(var_01.hasscavengedammothislife) && var_01.hasscavengedammothislife == 1) {
      var_01 processchallenge("ch_field_forage");
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_class_instincts") && isDefined(var_01.var_6F4D) && var_01.var_6F4D.size > 0) {
      var_3A = param_00.victim getentitynumber();
      if(isDefined(var_01.var_6F4D[var_3A]) && var_01.var_6F4D[var_3A]) {
        var_01 processchallenge("ch_operations_instincts");
      }
    }

    if((param_00.victim common_scripts\utility::func_56F4() || param_00.victim common_scripts\utility::func_56B5()) && var_01 maps\mp\_utility::_hasperk("specialty_stun_resistance")) {
      if(var_01 maps\mp\_utility::_hasperk("specialty_sprintfire")) {
        var_01 processchallenge("ch_perks3_junkie");
      }

      if(isDefined(param_00.victim.var_1189[var_01.guid])) {
        foreach(var_3C in param_00.victim.var_1189[var_01.guid].var_A9DF) {
          if(var_3C == "flash_grenade_mp" || var_3C == "stun_grenade_mp" || var_3C == "signal_flare_mp") {
            var_01 processchallenge("ch_perks2_tacmask");
          }
        }
      }
    }

    if(var_2B && var_01 maps\mp\_utility::_hasperk("specialty_sixthsense") && isDefined(var_01.var_4B65) && var_01.var_4B65) {
      var_3E = var_01.origin;
      var_3F = param_00.victim.origin;
      if(isDefined(level.var_8E2) && distancesquared(var_3E, var_3F) <= level.var_8E2 * level.var_8E2) {
        var_01 processchallenge("ch_perks1_sixthsense");
      }
    }
  }

  if(var_0A < param_00.victim.var_2577) {
    var_01 processchallenge("ch_exolauncher_stun");
  }

  if(isDefined(param_00.victim.var_5384)) {
    var_01 processchallenge("ch_exolauncher_smoke");
  }

  if(issubstr(param_00.sweapon, "extended_mag")) {
    var_01 processchallenge("ch_combathandling_extended_mag");
    var_01 func_18AC();
  }

  if(issubstr(param_00.sweapon, "grip")) {
    var_01 processchallenge("ch_combathandling_grip");
  }

  if(issubstr(param_00.sweapon, "fast_ads")) {
    var_01 processchallenge("ch_combathandling_fast_ads");
  }

  if(issubstr(param_00.sweapon, "reduced_sway")) {
    var_01 processchallenge("ch_combathandling_reduced_sway");
  }

  if(issubstr(param_00.sweapon, "hipfire")) {
    var_01 processchallenge("ch_combatefficiency_hipfire");
  }

  if(issubstr(param_00.sweapon, "fast_ads") && issubstr(param_00.sweapon, "grip")) {
    var_01 processchallenge("ch_combathandling_fastshooting");
  }

  if(issubstr(param_00.sweapon, "fast_ads") && issubstr(param_00.sweapon, "grip") && issubstr(param_00.sweapon, "extended_mag")) {
    var_01 processchallenge("ch_combathandling_smoothop");
  }

  if(!var_12 && issubstr(param_00.sweapon, "hipfire") && issubstr(param_00.sweapon, "extended_mag") && issubstr(param_00.sweapon, "rapid_fire")) {
    var_01 processchallenge("ch_combatefficiency_gunner");
  }

  if(issubstr(param_00.sweapon, "fmj")) {
    var_01 processchallenge("ch_combatefficiency_fmj");
  }

  if(issubstr(param_00.sweapon, "head_damage")) {
    var_01 processchallenge("ch_combatefficiency_head_damage");
  }

  if(issubstr(param_00.sweapon, "rapid_fire")) {
    var_01 processchallenge("ch_combatefficiency_rapid_fire");
  }

  if(issubstr(param_00.sweapon, "extended_range")) {
    var_01 processchallenge("ch_combatefficiency_extended_range");
  }

  if(issubstr(param_00.sweapon, "lens_sight")) {
    var_01 processchallenge("ch_combatefficiency_lens_sight");
  }

  if(issubstr(param_00.sweapon, "aperture_sight")) {
    var_01 processchallenge("ch_combatefficiency_aperture_sight");
  }

  if(issubstr(param_00.sweapon, "telescopic_sight")) {
    var_01 processchallenge("ch_combatefficiency_telescopic_sight");
  }

  if(var_0F && issubstr(param_00.sweapon, "fmj") && issubstr(param_00.sweapon, "extended_range")) {
    var_01 processchallenge("ch_combatefficiency_headhunter");
  }

  if(issubstr(param_00.sweapon, "extended_range") && issubstr(param_00.sweapon, "fmj") && issubstr(param_00.sweapon, "telescopic_sight") || !issubstr(param_00.sweapon, "iron_sight")) {
    var_01 processchallenge("ch_combatefficiency_assassin");
  }

  if(issubstr(param_00.sweapon, "akimbo")) {
    var_01 func_34C3();
  }

  foreach(var_41 in var_0B) {
    func_80A0(var_01, var_41, var_0B, param_00.sweapon, var_12, var_0F, var_10, var_13, var_16);
  }

  if(!maps\mp\_utility::ismeleemod(var_09) && !var_0E && !var_0D) {
    switch (var_21) {
      case "weapon_smg":
        var_01 processchallenge("ch_smg_kill");
        if(var_0F) {
          var_01 processchallenge("ch_smg_headshot");
        }
        break;

      case "weapon_assault":
        var_01 processchallenge("ch_ar_kill");
        if(var_0F) {
          var_01 processchallenge("ch_ar_headshot");
        }
        break;

      case "weapon_shotgun":
        var_01 processchallenge("ch_shotgun_kill");
        if(var_0F) {
          var_01 processchallenge("ch_shotgun_headshot");
        }
        break;

      case "weapon_sniper":
        var_01 processchallenge("ch_sniper_kill");
        if(var_0F) {
          var_01 processchallenge("ch_sniper_headshot");
        }
        break;

      case "weapon_pistol":
        var_01 processchallenge("ch_pistol_kill");
        if(var_0F) {
          var_01 processchallenge("ch_pistol_headshot");
        }
        break;

      case "weapon_heavy":
        var_01 processchallenge("ch_heavy_kill");
        if(var_0F) {
          var_01 processchallenge("ch_heavy_headshot");
        }
        break;

      case "weapon_special":
        var_01 processchallenge("ch_special_kill");
        break;

      default:
        break;
    }

    if(var_09 == "MOD_HEAD_SHOT") {
      if(var_21 == "weapon_pistol") {
        var_01 notify("increment_pistol_headshots");
      } else if(var_21 == "weapon_assault") {
        var_01 notify("increment_ar_headshots");
      }
    }

    if(var_21 != "weapon_projectile" || var_1F == "dp28_mp") {
      var_01 processchallenge("ch_marksman_" + var_1F);
    }
  }

  if((var_09 == "MOD_PISTOL_BULLET" || var_09 == "MOD_RIFLE_BULLET" || var_09 == "MOD_HEAD_SHOT") && !var_0E && !var_0D) {
    switch (var_21) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        if(issubstr(var_1F, "dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special") {
          var_01 processchallenge("ch_attach_unlock_type1_" + var_20);
        } else {
          var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
        }

        if(var_12) {
          if(issubstr(var_1F, "dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special") {
            var_01 processchallenge("ch_attach_unlock_type3_" + var_20);
          } else {
            var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
          }
        } else if(issubstr(var_1F, "dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special") {
          var_01 processchallenge("ch_attach_unlock_type2_" + var_20);
        } else {
          var_01 processchallenge("ch_attach_unlock_hipfirekills_" + var_20);
        }
        break;

      default:
        break;
    }

    if(var_09 == "MOD_HEAD_SHOT") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_headShots_" + var_20])) {
        var_01 processchallenge("ch_attach_unlock_headShots_" + var_20);
      }
    }
  }

  if(isDefined(var_01.var_7E9F)) {
    if(var_0A - var_01.var_7E9F.birthtime < 3000) {
      var_01 processchallenge("ch_attach_unlock_postplant_riotshieldt6");
    }
  }

  if(maps\mp\_utility::ismeleemod(var_09) && !var_0E && !var_0D) {
    if(!issubstr(var_1F, "riotshield")) {
      var_01.pers["meleeKillStreak"]++;
      foreach(var_41 in var_0B) {
        if(var_41 == "tactical") {
          var_01 processchallenge("ch_attach_kill_tactical");
        }
      }
    } else if(issubstr(var_1F, "riotshield")) {
      if(var_1F == "iw5_riotshieldt6") {
        var_01 processchallenge("ch_attach_unlock_meleekills_riotshieldt6");
        var_01 processchallenge("ch_marksman_iw5_riotshieldt6");
        var_01 processchallenge("ch_special_kill");
        var_01.pers["shieldKillStreak"]++;
      }
    }

    if(issubstr(var_1F, "exoshield")) {
      var_01 processchallenge("ch_exoability_shield");
    }

    var_01 notify("increment_melee_kills");
    if(isgunmeleeattack(var_09, param_00.sweapon) && !issubstr(param_00.sweapon, "bayonet")) {
      var_01 processchallenge("ch_humiliation_blunttrauma");
    }
  }

  if(issubstr(var_09, "MOD_IMPACT") && !var_0E && !var_0D) {
    if(issubstr(param_00.sweapon, "exoknife_mp")) {
      var_01 processchallenge("ch_exolauncher_knife");
    }

    if(maps\mp\_utility::func_57E5(param_00.sweapon, "throwingknife_")) {
      var_01 processchallenge("ch_lethals_knifekills");
      if(var_10) {
        var_01 processchallenge("ch_humiliation_hailmary");
        var_01 lib_0468::func_A22("hailMary");
      }
    }

    if(var_1F == "iw5_microdronelauncher" && isDefined(level.challengeinfo["ch_impact_iw5_microdronelauncher"])) {
      var_01 processchallenge("ch_impact_iw5_microdronelauncher");
    }

    if(var_1F == "iw5_exocrossbow") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_kills_" + var_20])) {
        var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
      }

      if(var_12) {
        if(isDefined(level.challengeinfo["ch_attach_unlock_ads_" + var_20])) {
          var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
        }
      }
    }
  }

  if(issubstr(var_09, "MOD_GRENADE") || issubstr(var_09, "MOD_PROJECTILE") || issubstr(var_09, "MOD_EXPLOSIVE") && !var_0E && !var_0D) {
    switch (var_21) {
      case "weapon_special":
        var_01 processchallenge("ch_special_kill");
        break;

      default:
        break;
    }

    if(var_1F == "iw5_exocrossbow") {
      if(isDefined(level.challengeinfo["ch_attach_unlock_kills_" + var_20])) {
        var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
      }

      if(var_12) {
        if(isDefined(level.challengeinfo["ch_attach_unlock_ads_" + var_20])) {
          var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
        }
      }
    }

    if(maps\mp\_utility::func_57E5(param_00.sweapon, "frag_")) {
      var_01 processchallenge("ch_exolauncher_frag");
      var_01 processchallenge("ch_lethals_fragkills");
      if(param_00.victim.explosiveinfo["cookedKill"]) {
        var_01 processchallenge("ch_lethals_masterchef");
      }

      if(param_00.victim.explosiveinfo["throwbackKill"]) {
        var_01 processchallenge("ch_precision_return");
      }

      var_45 = 1;
      foreach(var_47 in var_01.recentkills) {
        if(maps\mp\_utility::func_57E5(var_47.sweapon, "frag_")) {
          var_45++;
        }
      }

      if(var_45 == 2) {
        var_01 processchallenge("ch_humiliation_snackattack");
      }
    }

    if(maps\mp\_utility::func_57E5(param_00.sweapon, "semtex_")) {
      var_01 processchallenge("ch_exolauncher_semtex");
      var_01 processchallenge("ch_lethals_semtexkills");
    }

    if(maps\mp\_utility::func_57E5(param_00.sweapon, "thermite_")) {
      var_01 processchallenge("ch_lethals_thermitekills");
    }

    if(maps\mp\_utility::func_57E5(param_00.sweapon, "c4_")) {
      var_01 processchallenge("ch_lethals_c4kills");
    }

    if(isDefined(param_00.einflictor.classname) && param_00.einflictor.classname == "scriptable") {
      var_01 processchallenge("ch_precision_sitaware");
    }

    if(isDefined(param_00.sweapon) && param_00.sweapon == "mp_lab_gas_explosion") {
      var_01 processchallenge("ch_precision_sitaware");
    }

    if(maps\mp\_utility::isplayeronenemyteam(var_01) && var_01 maps\mp\_utility::_hasperk("specialty_class_bang")) {
      var_01 processchallenge("ch_explosives_bang");
    }

    if(isDefined(param_00.victim.explosiveinfo) && isDefined(param_00.victim.explosiveinfo["midAirDetonate"]) && param_00.victim.explosiveinfo["midAirDetonate"]) {
      var_01 processchallenge("ch_dlc1_saboteur");
    }
  }

  foreach(var_41 in var_0B) {
    switch (var_41) {
      case "gl":
        if(isDefined(level.challengeinfo["ch_attach_kill_" + var_41])) {
          var_01 processchallenge("ch_attach_kill_" + var_41);
        }
        break;
    }
  }

  if(issubstr(var_09, "MOD_EXPLOSIVE") && param_00.sweapon == "airdrop_trap_explosive_mp") {
    var_01 processchallenge("ch_precision_surprise");
  }

  if(!isDefined(level.disableweaponchallenges) || !level.disableweaponchallenges) {
    if(var_0F) {
      switch (var_21) {
        case "weapon_pistol":
        case "weapon_heavy":
        case "weapon_assault":
        case "weapon_smg":
          var_01 processchallenge("ch_camo_" + var_1F);
          break;
      }

      if(var_1F == "blunderbuss_mp") {
        var_01 tier4camochallenge(param_00.sweapon, "ch_camoT4_triplekill_");
      }
    }

    if(isDefined(param_00.modifiers["oneshotkill"])) {
      switch (var_21) {
        case "weapon_shotgun":
        case "weapon_sniper":
          var_01 processchallenge("ch_camo_" + var_1F);
          break;
      }

      if(var_1F == "dp28_mp") {
        var_01 processchallenge("ch_camo_" + var_1F);
      }
    }

    if(var_21 == "weapon_other" && function_01A9(param_00.sweapon) == "melee") {
      var_01 processchallenge("ch_camo_" + var_1F);
    }
  }

  if(var_21 == "weapon_projectile" && var_09 == "MOD_PROJECTILE") {
    var_01 func_99C5(param_00.sweapon, "ch_camoT2_directhitkill_");
    var_01 tier4camochallenge(param_00.sweapon, "ch_camoT4_directhitkill_");
  }

  if(isDefined(var_01.recentkills) && var_01.recentkills.size >= 1 && !isgunmeleeattack(var_09, param_00.sweapon)) {
    if(var_01.recentkills.size == 1 && var_01 maps\mp\_utility::_hasperk("specialty_class_escalation")) {
      var_01 processchallenge("ch_dlc2_escalation");
    }

    var_4B = 1;
    for(var_25 = 0; var_25 < var_01.recentkills.size; var_25++) {
      var_4C = maps\mp\_utility::func_45B5(var_01.recentkills[var_25].sweapon);
      if(var_4C == var_1F && !isgunmeleeattack(var_01.recentkills[var_25].smeansofdeath, var_01.recentkills[var_25].sweapon)) {
        var_4B++;
        continue;
      }

      break;
    }

    if(var_4B == 2) {
      var_01 func_99C5(param_00.sweapon, "ch_camoT2_doublekill_");
      var_01 tier3camochallenge(param_00.sweapon, "ch_camoT3_doublekill_");
      var_01 tier4camochallenge(param_00.sweapon, "ch_camoT4_doublekill_");
    }

    if(var_4B == 3) {
      if(var_1F != "blunderbuss_mp") {
        var_01 tier4camochallenge(param_00.sweapon, "ch_camoT4_triplekill_");
      }
    }
  }

  if(isDefined(var_01.killsthislife) && var_01.killsthislife.size >= 4 && !isgunmeleeattack(var_09, param_00.sweapon)) {
    var_4B = 1;
    foreach(var_1D in var_01.killsthislife) {
      var_4C = maps\mp\_utility::func_45B5(var_1D.sweapon);
      if(var_4C == var_1F && !isgunmeleeattack(var_1D.smeansofdeath, var_1D.sweapon)) {
        var_4B++;
      }
    }

    if(var_4B == 5) {
      var_01 func_99C5(param_00.sweapon, "ch_camoT2_killstreak5_");
    }
  }

  if(isDefined(var_01.lastweaponswaptime) && gettime() - var_01.lastweaponswaptime < 5000 && !isgunmeleeattack(var_09, param_00.sweapon)) {
    var_01 func_99C5(param_00.sweapon, "ch_camoT2_switchkill_");
    if(var_21 == "weapon_pistol" && var_01 maps\mp\_utility::_hasperk("specialty_class_shifty")) {
      var_01 processchallenge("ch_dlc1_shifty");
    }

    if(var_01 maps\mp\_utility::_hasperk("specialty_class_wanderlust")) {
      var_01 processchallenge("ch_dlc3_wanderlust");
    }
  }

  if(isDefined(var_01.var_9A8D[param_00.sweapon]) && var_01.var_9A8D[param_00.sweapon] == param_00.victim && isDefined(var_01.tookweaponkillweapon[param_00.sweapon]) && !isgunmeleeattack(var_09, param_00.sweapon)) {
    var_01 func_99C5(var_01.tookweaponkillweapon[param_00.sweapon], "ch_camoT2_takeandkill_");
  }

  if(isDefined(param_00.attacker.var_79) && !isgunmeleeattack(var_09, param_00.sweapon) && !var_0E && !var_0D) {
    var_2A = maps\mp\gametypes\_divisions::func_44A0(param_00.attacker.var_79);
    switch (var_21) {
      case "weapon_assault":
        if(var_2A == "infantry") {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
        }
        break;

      case "weapon_smg":
        if(var_2A == "airborne") {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
        }
        break;

      case "weapon_heavy":
        if(var_2A == "armored") {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
        }
        break;

      case "weapon_sniper":
        if(var_2A == "mountain") {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
        }
        break;

      case "weapon_shotgun":
        if(var_2A == "expeditionary") {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
        } else {
          var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
        }
        break;
    }

    if(var_1F == "dp28_mp") {
      if(var_2A == "mountain") {
        var_01 func_99C5(param_00.sweapon, "ch_camoT2_maindivision_");
      } else {
        var_01 func_99C5(param_00.sweapon, "ch_camoT2_altdivision_");
      }
    }
  }

  if(var_21 == "weapon_launcher") {
    if(isDefined(level.challengeinfo["ch_kills_" + var_1F])) {
      var_01 processchallenge("ch_kills_" + var_1F);
    }

    if(issubstr(param_00.victim.model, "npc_exo_armor_mp_base")) {
      if(isDefined(level.challengeinfo["ch_vehicle_" + var_1F])) {
        var_01 processchallenge("ch_vehicle_" + var_1F);
      }

      if(isDefined(level.challengeinfo["ch_goliath_" + var_1F])) {
        var_01 processchallenge("ch_goliath_" + var_1F);
      }
    }
  }

  if(var_16 || var_17 || var_18 || var_19 || var_1A || var_1B) {
    if(var_21 == "weapon_sniper") {
      if(isDefined(level.challengeinfo["ch_blood_" + var_1F])) {
        var_01 processchallenge("ch_blood_" + var_1F);
      }
    }

    if(var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_1F == "iw5_microdronelauncher") {
      if(issubstr(var_1F, "dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy") {
        var_01 processchallenge("ch_tier2_2_" + var_1F);
      } else {
        var_01 processchallenge("ch_triple_" + var_1F);
      }
    }
  }

  var_4F = 0;
  if(isDefined(var_01.var_5DFA)) {
    foreach(var_51 in var_01.var_5DFA) {
      if(var_51 == 0) {
        var_4F++;
        continue;
      }

      break;
    }
  }

  if(var_4F == 9) {
    switch (var_21) {
      case "weapon_pistol":
      case "weapon_special":
      case "weapon_heavy":
      case "weapon_shotgun":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        if(issubstr(var_1F, "dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special") {
          var_01 processchallenge("ch_tier2_5_" + var_1F);
        } else {
          var_01 processchallenge("ch_noperk_" + var_1F);
        }
        break;
    }
  }

  if(isDefined(var_01.var_6EF6)) {
    var_01.var_6EF6++;
    if(var_01.var_6EF6 == 3) {
      var_01 processchallenge("ch_infect_patientzero");
    }
  }
}

isgunmeleeattack(param_00, param_01) {
  return maps\mp\_utility::ismeleemod(param_00) && function_01A9(param_01) != "melee";
}

func_6359() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(5);
  if(maps\mp\_utility::isreallyalive(self)) {
    processchallenge("ch_operations_undercover");
  }
}

func_99C5(param_00, param_01) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }

  var_02 = maps\mp\_utility::func_45B5(param_00);
  var_03 = param_01 + var_02;
  var_04 = func_4450(var_03);
  if(isDefined(var_04)) {
    if(ischallengeunlocked(var_03, var_04)) {
      processchallenge(var_03);
    }
  }
}

tier3camochallenge(param_00, param_01) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }

  if(!mayprocesschallenges()) {
    return;
  }

  var_02 = maps\mp\_utility::func_45B5(param_00);
  var_03 = param_01 + var_02;
  var_04 = func_4450(var_03);
  if(tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(), 0, var_02) == -1) {
    return;
  }

  if(!isDefined(self.pers["weaponPrestige"][var_02])) {
    self.pers["weaponPrestige"][var_02] = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "prestigeLevel");
  }

  if(isDefined(var_04)) {
    if(self.pers["weaponPrestige"][var_02] >= 3) {
      processchallenge(var_03);
    }
  }
}

tier4camochallenge(param_00, param_01) {
  if(isDefined(level.disableweaponchallenges) && level.disableweaponchallenges) {
    return;
  }

  if(!mayprocesschallenges()) {
    return;
  }

  var_02 = maps\mp\_utility::func_45B5(param_00);
  var_03 = param_01 + var_02;
  var_04 = func_4450(var_03);
  if(tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(), 0, var_02) == -1) {
    return;
  }

  if(!isDefined(self.pers["weaponPrestige"][var_02])) {
    self.pers["weaponPrestige"][var_02] = self getrankedplayerdata(common_scripts\utility::func_46AE(), "weaponStats", var_02, "prestigeLevel");
  }

  if(isDefined(var_04)) {
    if(self.pers["weaponPrestige"][var_02] >= 4) {
      processchallenge(var_03);
    }
  }
}

func_4450(param_00) {
  if(isDefined(param_00) && isDefined(level.challengeinfo[param_00])) {
    var_01 = level.challengeinfo[param_00]["index"];
    return var_01;
  }
}

get_challenge_weapon_class(param_00, param_01) {
  var_02 = maps\mp\_utility::getweaponclass(param_00);
  if(!isDefined(param_01)) {
    param_01 = maps\mp\_utility::getbaseweaponname(param_00, 1);
    if(maps\mp\_utility::islootweapon(param_01)) {
      param_01 = maps\mp\gametypes\_class::getbasefromlootversion(param_01);
    }
  }

  if(param_01 == "iw5_exocrossbow" || param_01 == "iw5_exocrossbowblops2") {
    return "weapon_special";
  }

  if(param_01 == "iw5_maaws" || param_01 == "iw5_mahem") {
    return "weapon_launcher";
  }

  return var_02;
}

ch_bulletdamagecommon(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::isenvironmentweapon(param_00.sweapon)) {
    param_01 endmgstreak();
  }

  if(maps\mp\_utility::iskillstreakweapon(param_00.sweapon)) {
    return;
  }

  if(isbot(param_01)) {
    return;
  }

  if(param_01.pers["lastBulletKillTime"] == param_02) {
    param_01.pers["bulletStreak"]++;
  } else {
    param_01.pers["bulletStreak"] = 1;
  }

  param_01.pers["lastBulletKillTime"] = param_02;
  if(!param_00.victimonground) {
    param_01 processchallenge("ch_hardlanding");
  }

  if(!param_00.attackeronground) {
    param_01.pers["midairStreak"]++;
  }

  if(param_01.pers["midairStreak"] == 2) {
    param_01 processchallenge("ch_airborne");
  }

  if(param_02 < param_00.victim.flashendtime) {
    param_01 processchallenge("ch_flashbangvet");
  }

  if(param_02 < param_01.flashendtime) {
    param_01 processchallenge("ch_blindfire");
  }

  if(param_02 < param_00.victim.var_2577) {
    param_01 processchallenge("ch_concussionvet");
  }

  if(param_02 < param_01.var_2577) {
    param_01 processchallenge("ch_slowbutsure");
  }

  if(param_01.pers["bulletStreak"] == 2) {
    if(isDefined(param_00.modifiers["headshot"])) {
      foreach(var_05 in param_01.killsthislife) {
        if(var_05.time != param_02) {
          continue;
        }

        if(!isDefined(param_00.modifiers["headshot"])) {
          continue;
        }

        param_01 processchallenge("ch_allpro");
      }
    }

    if(param_03 == "weapon_sniper") {
      param_01 processchallenge("ch_collateraldamage");
    }
  }

  if(param_03 == "weapon_pistol") {
    if(isDefined(param_00.victim.var_1189) && isDefined(param_00.victim.var_1189[param_01.guid])) {
      if(isDefined(param_00.victim.var_1189[param_01.guid].isprimary)) {
        param_01 processchallenge("ch_fastswap");
      }
    }
  }

  if(!isDefined(param_01.infinalstand) || !param_01.infinalstand) {
    if(param_00.attackerstance == "crouch") {
      param_01 processchallenge("ch_crouchshot");
    } else if(param_00.attackerstance == "prone") {
      param_01 processchallenge("ch_proneshot");
      if(param_03 == "weapon_sniper") {
        param_01 processchallenge("ch_invisible");
      }
    }
  }

  if(param_03 == "weapon_sniper") {
    if(isDefined(param_00.modifiers["oneshotkill"])) {
      param_01 processchallenge("ch_ghillie");
    }
  }

  if(issubstr(param_00.sweapon, "silencer")) {
    param_01 processchallenge("ch_stealthvet");
  }
}

ch_roundplayed(param_00) {
  var_01 = param_00.player;
  if(var_01.wasaliveatmatchstart) {
    var_02 = var_01.pers["deaths"];
    var_03 = var_01.pers["kills"];
    var_04 = 1000000;
    if(var_02 > 0) {
      var_04 = var_03 / var_02;
    }

    if(var_04 >= 5 && var_03 >= 5) {
      var_01 processchallenge("ch_starplayer");
    }

    if(var_02 == 0 && maps\mp\_utility::gettimepassed() > 300000) {
      var_01 processchallenge("ch_flawless");
    }

    if(level.placement["all"].size < 3) {
      return;
    }

    if(var_01.score > 0) {
      switch (level.gametype) {
        case "dm":
          if(param_00.place < 3) {
            var_01 processchallenge("ch_victor_dm");
            var_01 processchallenge("ch_ffa_win");
          }

          var_01 processchallenge("ch_ffa_participate");
          break;

        case "war":
          if(param_00.winner) {
            var_01 processchallenge("ch_war_win");
          }

          var_01 processchallenge("ch_war_participate");
          break;

        case "kc":
          if(param_00.winner) {
            var_01 processchallenge("ch_kc_win");
          }

          var_01 processchallenge("ch_kc_participate");
          break;

        case "dd":
          if(param_00.winner) {
            var_01 processchallenge("ch_dd_win");
          }

          var_01 processchallenge("ch_dd_participate");
          break;

        case "koth":
          if(param_00.winner) {
            var_01 processchallenge("ch_koth_win");
          }

          var_01 processchallenge("ch_koth_participate");
          break;

        case "sab":
          if(param_00.winner) {
            var_01 processchallenge("ch_sab_win");
          }

          var_01 processchallenge("ch_sab_participate");
          break;

        case "sd":
          if(param_00.winner) {
            var_01 processchallenge("ch_sd_win");
          }

          var_01 processchallenge("ch_sd_participate");
          break;

        case "dom":
          if(param_00.winner) {
            var_01 processchallenge("ch_dom_win");
          }

          var_01 processchallenge("ch_dom_participate");
          break;

        case "ctf":
          if(param_00.winner) {
            var_01 processchallenge("ch_ctf_win");
          }

          var_01 processchallenge("ch_ctf_participate");
          break;

        case "tdef":
          if(param_00.winner) {
            var_01 processchallenge("ch_tdef_win");
          }

          var_01 processchallenge("ch_tdef_participate");
          break;

        case "hp":
          if(param_00.winner) {
            var_01 processchallenge("ch_hp_win");
          }
          var_01 processchallenge("ch_hp_participate");
          break;
      }
    }
  }
}

ch_roundwin(param_00) {
  if(!param_00.winner) {
    return;
  }

  var_01 = param_00.player;
  if(var_01.wasaliveatmatchstart) {
    switch (level.gametype) {
      case "war":
        if(level.hardcoremode) {
          var_01 processchallenge("ch_teamplayer_hc");
          if(param_00.place == 0) {
            var_01 processchallenge("ch_mvp_thc");
          }
        } else {
          var_01 processchallenge("ch_teamplayer");
          if(param_00.place == 0) {
            var_01 processchallenge("ch_mvp_tdm");
          }
        }
        break;

      case "sab":
        var_01 processchallenge("ch_victor_sab");
        break;

      case "sd":
        var_01 processchallenge("ch_victor_sd");
        break;

      case "hc":
      case "dom":
      case "koth":
      case "hp":
      case "dm":
      case "ctf":
        break;

      default:
        break;
    }
  }
}

playerdamaged(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isPlayer(self)) {
    return;
  }

  self endon("disconnect");
  if(isDefined(param_01)) {
    param_01 endon("disconnect");
  }

  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_06 = spawnStruct();
  var_06.victim = self;
  var_06.einflictor = param_00;
  var_06.attacker = param_01;
  var_06.idamage = param_02;
  var_06.smeansofdeath = param_03;
  var_06.sweapon = param_04;
  var_06.shitloc = param_05;
  var_06.victimonground = var_06.victim isonground();
  if(isPlayer(param_01)) {
    var_06.attackerinlaststand = isDefined(var_06.attacker.laststand);
    var_06.attackeronground = var_06.attacker isonground();
    var_06.attackerstance = var_06.attacker getstance();
  } else {
    var_06.attackerinlaststand = 0;
    var_06.attackeronground = 0;
    var_06.attackerstance = "stand";
  }

  if(isDefined(self) && isDefined(param_01) && isDefined(self.team) && isDefined(param_01.team)) {
    if(self.team != param_01.team && maps\mp\_utility::_hasperk("specialty_class_hunker") && isexplosivedamagemod(var_06.smeansofdeath) && maps\mp\_utility::isreallyalive(self) && !maps\mp\perks\_perks::isreallyalive(param_04)) {
      processchallenge("ch_explosives_hunker");
    }

    if(self.team != param_01.team && maps\mp\_utility::_hasperk("specialty_class_primed")) {
      self.var_5B8B = gettime();
    }
  }

  domissioncallback("playerDamaged", var_06);
}

playerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self.anglesondeath = self getplayerangles();
  if(isDefined(param_01)) {
    param_01.anglesonkill = param_01 getplayerangles();
  }

  self endon("disconnect");
  var_08 = spawnStruct();
  var_08.victim = self;
  var_08.einflictor = param_00;
  var_08.attacker = param_01;
  var_08.idamage = param_02;
  var_08.smeansofdeath = param_03;
  var_08.sweapon = param_04;
  var_08.sprimaryweapon = param_05;
  var_08.shitloc = param_06;
  var_08.time = gettime();
  var_08.modifiers = param_07;
  var_08.victimonground = var_08.victim isonground();
  if(isPlayer(param_01)) {
    var_08.attackerinlaststand = isDefined(var_08.attacker.laststand);
    var_08.attackeronground = var_08.attacker isonground();
    var_08.attackerstance = var_08.attacker getstance();
  } else {
    var_08.attackerinlaststand = 0;
    var_08.attackeronground = 0;
    var_08.attackerstance = "stand";
  }

  var_09 = 0;
  if(isDefined(var_08.einflictor) && isDefined(var_08.einflictor.firedads)) {
    var_09 = var_08.einflictor.firedads;
  } else if(isDefined(param_01) && isPlayer(param_01)) {
    var_09 = param_01 playerads();
  }

  var_08.was_ads = 0;
  if(var_09 >= 0.2) {
    var_08.was_ads = 1;
  }

  waitandprocessplayerkilledcallback(var_08);
  if(isDefined(param_01) && maps\mp\_utility::isreallyalive(param_01)) {
    param_01.killsthislife[param_01.killsthislife.size] = var_08;
    param_01.recentkills = common_scripts\utility::func_F86(param_01.recentkills, var_08, 0);
    if(!isDefined(level.recentkillers)) {
      level.recentkillers = [];
    }

    level.recentkillers = common_scripts\utility::func_F86(level.recentkillers, param_01, 0);
    if(level.recentkillers.size >= 4) {
      level.recentkillers = common_scripts\utility::func_FA3(level.recentkillers, 0, 4);
      var_0A = 0;
      foreach(var_0C in level.recentkillers) {
        if(var_0C == param_01) {
          var_0A++;
          continue;
        }

        break;
      }

      if(var_0A >= 4) {
        param_01 processchallenge("ch_killer_feed");
        level.recentkillers = [];
      }
    }
  }

  var_08.attacker notify("playerKilledChallengesProcessed");
}

vehiclekilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.vehicle = param_01;
  var_07.victim = param_00;
  var_07.einflictor = param_02;
  var_07.attacker = param_03;
  var_07.idamage = param_04;
  var_07.smeansofdeath = param_05;
  var_07.sweapon = param_06;
  var_07.time = gettime();
  domissioncallback("vehicleKilled", var_07);
}

waitandprocessplayerkilledcallback(param_00) {
  if(isDefined(param_00.attacker)) {
    param_00.attacker endon("disconnect");
  }

  self.processingkilledchallenges = 1;
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  domissioncallback("playerKilled", param_00);
  self.processingkilledchallenges = undefined;
}

playerassist() {
  var_00 = spawnStruct();
  var_00.player = self;
  domissioncallback("playerAssist", var_00);
}

usehardpoint(param_00) {
  self endon("disconnect");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();
  var_01 = spawnStruct();
  var_01.player = self;
  var_01.hardpointtype = param_00;
  domissioncallback("playerHardpoint", var_01);
}

roundbegin() {
  domissioncallback("roundBegin");
}

roundend(param_00) {
  var_01 = spawnStruct();
  if(level.teambased) {
    var_02 = "allies";
    for(var_03 = 0; var_03 < level.placement[var_02].size; var_03++) {
      var_01.player = level.placement[var_02][var_03];
      var_01.winner = var_02 == param_00;
      var_01.place = var_03;
      domissioncallback("roundEnd", var_01);
    }

    var_02 = "axis";
    for(var_03 = 0; var_03 < level.placement[var_02].size; var_03++) {
      var_01.player = level.placement[var_02][var_03];
      var_01.winner = var_02 == param_00;
      var_01.place = var_03;
      domissioncallback("roundEnd", var_01);
    }

    return;
  }

  for(var_03 = 0; var_03 < level.placement["all"].size; var_03++) {
    var_01.player = level.placement["all"][var_03];
    var_01.winner = isDefined(param_00) && isPlayer(param_00) && var_01.player == param_00;
    var_01.place = var_03;
    domissioncallback("roundEnd", var_01);
  }
}

domissioncallback(param_00, param_01) {
  if(!mayprocesschallenges()) {
    return;
  }

  if(getdvarint("disable_challenges") > 0) {
    return;
  }

  if(!isDefined(level.missioncallbacks[param_00])) {
    return;
  }

  if(isDefined(param_01)) {
    for(var_02 = 0; var_02 < level.missioncallbacks[param_00].size; var_02++) {
      thread[[level.missioncallbacks[param_00][var_02]]](param_01);
    }

    return;
  }

  for(var_02 = 0; var_02 < level.missioncallbacks[param_00].size; var_02++) {
    thread[[level.missioncallbacks[param_00][var_02]]]();
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
      var_00 = self.origin[2];
      while(!self isonground() && isalive(self)) {
        if(self.origin[2] > var_00) {
          var_00 = self.origin[2];
        }

        wait 0.05;
      }

      var_01 = var_00 - self.origin[2];
      if(var_01 < 0) {
        var_01 = 0;
      }

      if(var_01 / 12 > 15 && isalive(self) && maps\mp\_utility::isemped()) {
        processchallenge("ch_boot_shortcut");
      }

      if(var_01 / 12 > 30 && !isalive(self) && maps\mp\_utility::isemped()) {
        processchallenge("ch_boot_gravity");
      }
    }

    wait 0.05;
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

monitormatchchallenges(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("disconnect");
  if(!isDefined(game[param_02])) {
    game[param_02] = [];
  }

  if(!isDefined(game[param_02][self.guid])) {
    game[param_02][self.guid] = 0;
  }

  thread remove_tracking_on_disconnect(param_02);
  for(;;) {
    self waittill(param_00, var_03);
    var_04 = game[param_02][self.guid];
    var_04++;
    game[param_02][self.guid] = var_04;
    if(var_04 == param_01) {
      if(isDefined(var_03) && issubstr(param_02, "ch_camoT2_")) {
        func_99C5(var_03, param_02);
        continue;
      }

      processchallenge(param_02);
    }
  }
}

monitortier2camomatchchallenges(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill(param_00, var_03);
    var_04 = param_02 + var_03;
    if(!isDefined(game[var_04])) {
      game[var_04] = [];
    }

    if(!isDefined(game[var_04][self.guid])) {
      game[var_04][self.guid] = 0;
      thread remove_tracking_on_disconnect(var_04);
    }

    var_05 = game[var_04][self.guid];
    var_05++;
    game[var_04][self.guid] = var_05;
    if(var_05 == param_01) {
      func_99C5(var_03, param_02);
    }
  }
}

remove_tracking_on_disconnect(param_00) {
  level endon("game_ended");
  self waittill("disconnect");
  if(isDefined(game[param_00][self.guid])) {
    game[param_00][self.guid] = undefined;
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
    var_00 = common_scripts\utility::waittill_any_return("bomb_planted", "bomb_defused");
    if(!isDefined(var_00)) {
      continue;
    }

    if(var_00 == "bomb_planted") {
      processchallenge("ch_saboteur");
      continue;
    }

    if(var_00 == "bomb_defused") {
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
  wait(300);
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
    var_00 = common_scripts\utility::waittill_any_return_no_endon_death("destroyed_explosive", "begin_airstrike", "destroyed_car", "destroyed_car");
    monitormisccallback(var_00);
  }
}

monitormisccallback(param_00) {
  switch (param_00) {
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
        return;
      }
    }
  }
}

resetbrinkofdeathkillstreakshortly() {
  self endon("disconnect");
  self endon("death");
  self endon("damage");
  wait(1);
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
  var_00 = self.health / self.maxhealth;
  return var_00 <= level.healthoverlaycutoff;
}

processchallenge(param_00, param_01, param_02) {
  if(!mayprocesschallenges()) {
    return;
  }

  if(level.players.size < 2 && !getdvarint("850") && !getdvarint("5357") && !function_0367()) {
    var_03 = undefined;
    if(isDefined(var_03)) {
      if(var_03 == 0) {
        return;
      }
    } else {
      return;
    }
  }

  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }

  if(isDefined(level.challengeinfo[param_00]) && isDefined(level.challengeinfo[param_00]["requiresPrestige"])) {
    var_04 = level.challengeinfo[param_00]["requiresPrestige"];
    if(var_04 != "") {
      if(maps\mp\gametypes\_rank::getprestigelevel() < int(var_04)) {
        return;
      }
    }
  }

  if(getdvarint("1258", 0) == 1) {
    if(common_scripts\utility::string_starts_with(param_00, "ch_camo") || common_scripts\utility::string_starts_with(param_00, "ch_reticle")) {
      return;
    }
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_05 = getchallengestatus(param_00);
  if(var_05 == 0) {
    return;
  }

  if(var_05 > level.challengeinfo[param_00]["targetval"].size) {
    return;
  }

  var_06 = maps\mp\gametypes\_hud_util::ch_getprogress(param_00);
  if(isDefined(param_02) && param_02) {
    var_07 = param_01;
  } else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(param_01)) {
    var_07 = var_07;
  } else {
    var_07 = var_07 + param_02;
  }

  var_08 = 0;
  var_09 = level.challengeinfo[param_00]["targetval"][var_05];
  while(isDefined(var_09) && var_07 >= var_09) {
    var_08++;
    var_09 = level.challengeinfo[param_00]["targetval"][var_05 + var_08];
  }

  if(var_06 < var_07) {
    maps\mp\gametypes\_hud_util::ch_setprogress(param_00, var_07);
  }

  if(var_08 > 0) {
    var_0A = var_05;
    while(var_08) {
      thread giverankxpafterwait(param_00, var_05);
      var_0B = function_02AD(param_00, var_05);
      var_0C = common_scripts\utility::func_9AAD(var_0B);
      var_0D = int(getsubstr(var_0C, 0, var_0C.size - 2));
      if(!isDefined(game["challengeStruct"]["challengesCompleted"][self.guid])) {
        game["challengeStruct"]["challengesCompleted"][self.guid] = [];
      }

      var_0E = 0;
      foreach(var_10 in game["challengeStruct"]["challengesCompleted"][self.guid]) {
        if(var_10 == var_0D) {
          var_0E = 1;
        }
      }

      if(!var_0E) {
        game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_0D;
      }

      if(var_05 >= level.challengeinfo[param_00]["targetval"].size && level.challengeinfo[param_00]["parent_challenge"] != "") {
        processchallenge(level.challengeinfo[param_00]["parent_challenge"]);
      }

      var_05++;
      var_08--;
    }

    if(!issubstr(param_00, "ch_limited_bloodshed") && !issubstr(param_00, "ch_division_iconic_weapon") && !issubstr(param_00, "ch_hq_data")) {
      thread maps\mp\gametypes\_hud_message::challengesplashnotify(param_00, var_0A, var_05);
    }

    maps\mp\gametypes\_hud_util::ch_setstate(param_00, var_05);
    self.challengedata[param_00] = var_05;
  }
}

giverankxpafterwait(param_00, param_01) {
  self endon("disconnect");
  wait(0.25);
  maps\mp\gametypes\_rank::giverankxp("challenge", level.challengeinfo[param_00]["reward"][param_01], undefined, undefined, param_00);
}

masterychallengeprocess(param_00) {
  if(tablelookup("mp/allChallengesTable.csv", 0, "ch_" + param_00 + "_mastery", 1) == "") {
    return;
  }

  var_01 = 0;
  var_02 = maps\mp\_utility::getweaponattachmentfromstats(param_00);
  foreach(var_04 in var_02) {
    if(var_04 == "") {
      continue;
    }

    if(maps\mp\gametypes\_class::isattachmentunlocked(param_00, var_04)) {
      var_01++;
    }
  }

  processchallenge("ch_" + param_00 + "_mastery", var_01, 1);
}

ischallengeunlocked(param_00, param_01) {
  var_02 = tablelookupbyrow("mp/allChallengesTable.csv", param_01, 8);
  if(var_02 != "") {
    var_03 = getchallengestatus(var_02);
    if(var_03 > 1) {
      return 1;
    }
  }

  var_04 = tablelookupbyrow("mp/allChallengesTable.csv", param_01, 6);
  if(var_04 != "") {
    var_05 = maps\mp\gametypes\_rank::getrank();
    if(var_05 < int(var_04)) {
      return 0;
    }
  }

  var_06 = tablelookupbyrow("mp/allChallengesTable.csv", param_01, 7);
  if(var_06 != "") {
    var_07 = getchallengestatus(var_06);
    if(var_07 <= level.challengeinfo[var_06]["targetval"].size) {
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

  if(!isDefined(self.pers["weaponPrestige"])) {
    self.pers["weaponPrestige"] = [];
  }

  self endon("disconnect");
  if(!mayprocesschallenges()) {
    return;
  }

  if(!self isitemunlocked("challenges")) {
    return;
  }

  var_00 = 0;
  var_01 = getdvarint("spv_challenge_mastery_completion", 0) == 1;
  foreach(var_06, var_03 in level.challengeinfo) {
    var_00++;
    if(var_00 % 40 == 0) {
      wait 0.05;
    }

    if(function_0367() && !func_5680(var_06)) {
      continue;
    }

    self.challengedata[var_06] = 0;
    var_04 = var_03["index"];
    var_05 = maps\mp\gametypes\_hud_util::ch_getstate(var_06);
    if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_06) && !isDefined(game["challengeStruct"]["limitedChallengesReset"][self.guid])) {
      maps\mp\gametypes\_hud_util::ch_setprogress(var_06, 0);
      var_05 = 0;
    }

    if(var_05 == 0) {
      maps\mp\gametypes\_hud_util::ch_setstate(var_06, 1);
      var_05 = 1;
    }

    self.challengedata[var_06] = var_05;
    if(common_scripts\utility::func_562E(var_01) && issubstr(var_06, "_master")) {
      processchallenge(var_06, 0);
    }
  }

  game["challengeStruct"]["limitedChallengesReset"][self.guid] = 1;
}

func_5680(param_00) {
  return tablelookup("mp/allChallengesTable.csv", 0, param_00, 44) != "";
}

isinunlocktable(param_00) {
  return tablelookup("mp/unlockTable.csv", 0, param_00, 0) != "";
}

getchallengefilter(param_00) {
  return tablelookup("mp/allChallengesTable.csv", 0, param_00, 5);
}

getchallengetable(param_00) {
  return tablelookup("mp/challengeTable.csv", 8, param_00, 4);
}

gettierfromtable(param_00, param_01) {
  return tablelookup(param_00, 0, param_01, 1);
}

func_584F(param_00) {
  if(isDefined(func_4732(param_00))) {
    return 1;
  }

  return 0;
}

func_4732(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = getchallengefilter(param_00);
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_02 = strtok(var_01, "_");
  if(var_02[0] == "challenge") {
    var_03 = undefined;
    for(var_04 = 1; var_04 < var_02.size; var_04++) {
      if(isDefined(var_03)) {
        var_03 = var_03 + "_" + var_02[var_04];
        continue;
      }

      var_03 = var_02[var_04];
    }

    if(isDefined(var_03) && maps\mp\gametypes\_class::isvalidprimary(var_03) || maps\mp\gametypes\_class::isvalidsecondary(var_03, 0)) {
      return var_03;
    }
  }

  return undefined;
}

func_4724(param_00) {
  if(!isDefined(param_00)) {
    return undefined;
  }

  var_01 = getchallengefilter(param_00);
  if(!isDefined(var_01) || var_01 != "attachment") {
    return undefined;
  }

  var_02 = strtok(param_00, "_");
  if(var_02.size > 0) {
    var_03 = var_02[var_02.size - 1];
    if(isDefined(var_03) && maps\mp\_utility::isattachment(var_03)) {
      return var_03;
    }
  }

  return undefined;
}

iskillstreakchallenge(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = getchallengefilter(param_00);
  if(isDefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support") {
    return 1;
  }

  return 0;
}

getkillstreakfromchallenge(param_00) {
  var_01 = "ch_";
  var_02 = getsubstr(param_00, var_01.size, param_00.size);
  if(var_02 == "assault_streaks" || var_02 == "support_streaks") {
    var_02 = undefined;
  }

  return var_02;
}

challenge_targetval(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_01, 9 + param_02 - 1 * 2);
  return int(var_03);
}

challenge_rewardval(param_00, param_01, param_02) {
  var_03 = tablelookup(param_00, 0, param_01, 10 + param_02 - 1 * 2);
  return int(var_03);
}

challenge_parentchallenge(param_00, param_01) {
  var_02 = tablelookup(param_00, 0, param_01, 42);
  if(!isDefined(var_02)) {
    var_02 = "";
  }

  return var_02;
}

buildchallengetableinfo(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  for(;;) {
    var_03++;
    var_04 = tablelookupbyrow(param_00, var_03, 0);
    if(var_04 == "") {
      break;
    }

    if(issubstr(var_04, "ch_daily")) {
      continue;
    }

    var_05 = tablelookupbyrow(param_00, var_03, 43);
    if(var_05 == "1") {
      continue;
    }

    level.challengeinfo[var_04] = [];
    level.challengeinfo[var_04]["index"] = var_03;
    level.challengeinfo[var_04]["type"] = param_01;
    level.challengeinfo[var_04]["targetval"] = [];
    level.challengeinfo[var_04]["reward"] = [];
    level.challengeinfo[var_04]["parent_challenge"] = "";
    level.challengeinfo[var_04]["requiresPrestige"] = tablelookupbyrow("mp/allChallengesTable.csv", var_03, 45);
    if(func_584F(var_04)) {
      var_06 = func_4732(var_04);
      var_07 = func_4724(var_04);
      if(isDefined(var_06)) {
        level.challengeinfo[var_04]["weapon"] = var_06;
      }

      if(isDefined(var_07)) {
        level.challengeinfo[var_04]["attachment"] = var_07;
      }
    } else if(iskillstreakchallenge(var_04)) {
      var_08 = getkillstreakfromchallenge(var_04);
      if(isDefined(var_08)) {
        level.challengeinfo[var_04]["killstreak"] = var_08;
      }
    }

    for(var_09 = 1; var_09 < 10; var_09++) {
      var_0A = challenge_targetval(param_00, var_04, var_09);
      var_0B = challenge_rewardval(param_00, var_04, var_09);
      if(var_0A == 0) {
        break;
      }

      level.challengeinfo[var_04]["targetval"][var_09] = var_0A;
      level.challengeinfo[var_04]["reward"][var_09] = var_0B;
      var_02 = var_02 + var_0B;
    }

    level.challengeinfo[var_04]["parent_challenge"] = challenge_parentchallenge(param_00, var_04);
  }

  return int(var_02);
}

buildchallegeinfo() {
  level.challengeinfo = [];
  if(getDvar("4017") == "1" && !function_0367()) {
    return;
  }

  var_00 = 0;
  var_00 = var_00 + buildchallengetableinfo("mp/allChallengesTable.csv", 0);
  func_1D43();
}

func_1D43() {
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp/dailychallengesTable.csv", var_00, 0);
    if(var_01 == "") {
      break;
    }

    level.challengeinfo[var_01] = [];
    level.challengeinfo[var_01]["index"] = var_00;
    level.challengeinfo[var_01]["type"] = 1;
    level.challengeinfo[var_01]["targetval"] = [];
    level.challengeinfo[var_01]["reward"] = [];
    level.challengeinfo[var_01]["targetval"] = challenge_targetval("mp/dailychallengesTable.csv", var_01, 1);
    level.challengeinfo[var_01]["reward"] = challenge_rewardval("mp/dailychallengesTable.csv", var_01, 1);
    var_00++;
  }
}

monitorprocesschallenge() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    if(!mayprocesschallenges()) {
      return;
    }

    self waittill("process", var_00);
    processchallenge(var_00);
  }
}

monitorkillstreakprogress() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    self waittill("got_killstreak", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    if(!isDefined(self.killstreaks)) {
      continue;
    }

    if(var_00 == 9 && isDefined(self.killstreaks[7]) && isDefined(self.killstreaks[8]) && isDefined(self.killstreaks[9])) {
      processchallenge("ch_6fears7");
    }

    if(var_00 == 10 && self.killstreaks.size == 0) {
      processchallenge("ch_theloner");
    }
  }
}

monitorkilledkillstreak() {
  self endon("disconnect");
  level endon("game_end");
  for(;;) {
    self waittill("destroyed_killstreak", var_00);
    if(isDefined(var_00) && var_00 == "stinger_mp") {
      processchallenge("ch_marksman_stinger");
      processchallenge("pr_marksman_stinger");
    }
  }
}

genericchallenge(param_00, param_01) {
  switch (param_00) {
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
      processchallenge("ch_shield_damage", param_01);
      break;

    case "shield_bullet_hits":
      processchallenge("ch_shield_bullet", param_01);
      break;

    case "shield_explosive_hits":
      processchallenge("ch_shield_explosive", param_01);
      break;
  }
}

playerhasammo() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(self getweaponammoclip(var_02)) {
      return 1;
    }

    var_03 = weaponaltweaponname(var_02);
    if(!isDefined(var_03) || var_03 == "none") {
      continue;
    }

    if(self getweaponammoclip(var_03)) {
      return 1;
    }
  }

  return 0;
}

monitoradstime() {
  self endon("disconnect");
  self.adstime = 0;
  for(;;) {
    if(self playerads() == 1) {
      self.adstime = self.adstime + 0.05;
    } else {
      self.adstime = 0;
    }

    wait 0.05;
  }
}

monitorpronetime() {
  self endon("disconnect");
  level endon("game_ended");
  self.pronetime = undefined;
  var_00 = 0;
  for(;;) {
    var_01 = self getstance();
    if(var_01 == "prone" && var_00 == 0) {
      self.pronetime = gettime();
      var_00 = 1;
    } else if(var_01 != "prone") {
      self.pronetime = undefined;
      var_00 = 0;
    }

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
  level endon("game_ended");
  self.mantling = 0;
  for(;;) {
    self waittill("jumped");
    var_00 = self getcurrentweapon();
    common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
    var_01 = self getcurrentweapon();
    if(var_01 == "none") {
      self.mantling = 1;
    } else {
      self.mantling = 0;
    }

    if(self.mantling) {
      if(self isitemunlocked("specialty_fastmantle") && maps\mp\_utility::_hasperk("specialty_fastmantle")) {
        processchallenge("ch_fastmantle");
      }

      common_scripts\utility::waittill_notify_or_timeout("weapon_change", 1);
      var_01 = self getcurrentweapon();
      if(var_01 == var_00) {
        self.mantling = 0;
      }
    }
  }
}

func_63FA() {
  self endon("disconnect");
  var_00 = self getcurrentweapon();
  for(;;) {
    self waittill("weapon_change", var_01);
    if(var_01 == "none") {
      continue;
    }

    if(var_01 == var_00) {
      continue;
    }

    if(maps\mp\_utility::iskillstreakweapon(var_01)) {
      continue;
    }

    if(maps\mp\_utility::func_568F(var_01) || maps\mp\_utility::isuseweapon(var_01)) {
      continue;
    }

    self.lastweaponswaptime = gettime();
    var_02 = function_01D4(var_01);
    if(var_02 != "primary") {
      continue;
    }

    self.var_5BD0 = gettime();
  }
}

func_6395() {
  self endon("disconnect");
  for(;;) {
    self waittill("flashbang", var_00, var_01, var_02, var_03);
    if(isDefined(var_03) && self == var_03) {
      continue;
    }

    self.var_5B9C = gettime();
  }
}

func_6375() {
  self endon("disconnect");
  for(;;) {
    self waittill("concussed", var_00);
    if(self == var_00) {
      continue;
    }

    self.var_5B86 = gettime();
  }
}

func_63B2() {
  self endon("disconnect");
  for(;;) {
    common_scripts\utility::waittill_any("triggered_mine", "triggered_claymore");
    thread func_A68C();
  }
}

func_A68C() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(level.var_2CE8 + 2);
  processchallenge("ch_delaymine");
  if(maps\mp\_utility::_hasperk("specialty_class_flanker")) {
    thread processchallenge("ch_operations_flanker");
  }
}

func_55B0(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  switch (param_00) {
    case "frag_grenade_german_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      return 1;

    default:
      return 0;
  }
}

ch_monitorkillerdoingwork(param_00) {
  self endon("disconnect");
  self endon("death");
  self notify("monitorKillerDoingWork");
  self endon("monitorKillerDoingWork");
  self waittill("ch_capture", var_01);
  if(var_01 == param_00) {
    thread processchallenge("ch_killer_doingwork");
  }
}

func_18AC() {
  if(!isDefined(self.var_18AE) || !isDefined(self.killsthislife) || self.killsthislife.size == 0) {
    self.var_18AE = 0;
  }

  self.var_18AE++;
  if(isDefined(self.var_18AE) && self.var_18AE == 5) {
    processchallenge("ch_combathandling_bodycount");
    self.var_18AE = 0;
  }
}

func_34C3() {
  if(!isDefined(self.var_BA8) || !isDefined(self.killsthislife) || self.killsthislife.size == 0) {
    self.var_BA8 = 0;
  }

  self.var_BA8++;
  if(isDefined(self.var_BA8) && self.var_BA8 == 3) {
    processchallenge("ch_combathandling_rungun");
    self.var_BA8 = 0;
  }
}

func_80A0(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!param_04) {
    return;
  }

  if(issubstr(param_01, "aperture_sight") || issubstr(param_01, "telescopic") || issubstr(param_01, "lens_sight")) {
    var_09 = maps\mp\_utility::func_45B5(param_03);
    var_0A = undefined;
    if(issubstr(param_01, "aperture_sight")) {
      var_0A = "nydar";
    } else if(issubstr(param_01, "telescopic")) {
      var_0A = "optic";
    } else if(issubstr(param_01, "lens_sight")) {
      var_0A = "lens";
    }

    param_00 processchallenge("ch_reticle_" + var_0A + "_kill_" + var_09);
    if(param_05) {
      param_00 func_99C5(var_09, "ch_reticle_" + var_0A + "_headshot_");
    }

    if(param_06) {
      param_00 func_99C5(var_09, "ch_reticle_" + var_0A + "_longshot_");
    }

    if(isDefined(param_00.recentkills) && param_00.recentkills.size >= 1) {
      var_0B = 1;
      for(var_0C = 0; var_0C < param_00.recentkills.size; var_0C++) {
        var_0D = maps\mp\_utility::func_45B5(param_00.recentkills[var_0C].sweapon);
        var_0E = issubstr(param_00.recentkills[var_0C].sweapon, param_01);
        if(param_00.recentkills[var_0C].was_ads && var_0D == var_09 && var_0E) {
          var_0B++;
          continue;
        }

        break;
      }

      if(var_0B == 2) {
        param_00 func_99C5(var_09, "ch_reticle_" + var_0A + "_doublekill_");
      }
    }

    if(isDefined(param_00.killsthislife) && param_00.killsthislife.size >= 4) {
      var_0B = 1;
      foreach(var_10 in param_00.killsthislife) {
        var_0D = maps\mp\_utility::func_45B5(var_10.sweapon);
        var_0E = issubstr(var_10.sweapon, param_01);
        if(var_10.was_ads && var_0D == var_09 && var_0E) {
          var_0B++;
        }
      }

      if(var_0B == 5) {
        param_00 func_99C5(var_09, "ch_reticle_" + var_0A + "_streaking_");
        return;
      }
    }
  }
}

func_80BB(param_00, param_01) {
  var_02 = maps\mp\_events::func_43D6(param_00, param_01);
  if(var_02 == "fighter_strike_kill" || var_02 == "fritzx_kill" || var_02 == "firebomb_kill" || var_02 == "airstrike_kill" || var_02 == "plane_gunner_kill") {
    processchallenge("ch_streak_closeairsupport");
  }

  if(var_02 == "mortar_strike_kill" || var_02 == "missile_strike_kill") {
    processchallenge("ch_streak_firesupport");
  }

  if(var_02 == "molotovs_kill" || var_02 == "flamethrower_kill") {
    processchallenge("ch_streak_hotpoint");
  }
}

func_0B9D() {
  var_00 = isDefined(level.var_3CE0) && level.var_3CE0 == self;
  var_01 = 0;
  if(level.teambased && isDefined(level.var_9FDA)) {
    if(isDefined(level.var_9FDA)) {
      foreach(var_03 in level.var_9FDA[self.team]) {
        if(var_03.var_1C8 == "counter_uav" && isDefined(var_03.owner) && var_03.owner == self) {
          var_01 = 1;
          break;
        }
      }
    }
  } else {
    var_05 = isDefined(level.var_2694) && level.var_2694 == self;
  }

  if(var_00 || var_01) {
    processchallenge("ch_streak_airsuperiority");
  }
}