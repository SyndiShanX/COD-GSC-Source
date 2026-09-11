/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\infect.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = getdvarint("LTSNLQNRKO") && !getdvarint("LSTLQTSSRM");

  if(var_0) {
    level.unset_relic_laststandmelee = getdvarint("scr_infect_groundwarInfect", 0);
  }

  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function waitthensetstatgroupreadonly() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("kdr");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("losses");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("winLoss");
    return;
  }
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_infect_numInitialInfected", getmatchrulesdata("infectData", "numInitialInfected"));
  setdynamicdvar("scr_infect_weaponSurvivorPrimary", getmatchrulesdata("infectData", "weaponSurvivorPrimary"));
  setdynamicdvar("scr_infect_weaponSurvivorSecondary", getmatchrulesdata("infectData", "weaponSurvivorSecondary"));
  setdynamicdvar("scr_infect_lethalSurvivor", getmatchrulesdata("infectData", "lethalSurvivor"));
  setdynamicdvar("scr_infect_tacticalSurvivor", getmatchrulesdata("infectData", "tacticalSurvivor"));
  setdynamicdvar("scr_infect_superSurvivor", getmatchrulesdata("infectData", "superSurvivor"));
  setdynamicdvar("scr_infect_superSurvivorTwo", getmatchrulesdata("infectData", "superSurvivorTwo"));
  setdynamicdvar("scr_infect_weaponInfectPrimary", getmatchrulesdata("infectData", "weaponInfectPrimary"));
  setdynamicdvar("scr_infect_weaponInfectSecondary", getmatchrulesdata("infectData", "weaponInfectSecondary"));
  setdynamicdvar("scr_infect_lethalInfect", getmatchrulesdata("infectData", "lethalInfect"));
  setdynamicdvar("scr_infect_tacticalInfect", getmatchrulesdata("infectData", "tacticalInfect"));
  setdynamicdvar("scr_infect_weaponInitialPrimary", getmatchrulesdata("infectData", "weaponInitialPrimary"));
  setdynamicdvar("scr_infect_weaponInitialSecondary", getmatchrulesdata("infectData", "weaponInitialSecondary"));
  setdynamicdvar("scr_infect_superInfect", getmatchrulesdata("infectData", "superInfect"));
  setdynamicdvar("scr_infect_superInfectTwo", getmatchrulesdata("infectData", "superInfectTwo"));
  setdynamicdvar("scr_infect_infectExtraTimePerKill", getmatchrulesdata("infectData", "infectExtraTimePerKill"));
  setdynamicdvar("scr_infect_survivorAliveScore", getmatchrulesdata("infectData", "survivorAliveScore"));
  setdynamicdvar("scr_infect_survivorScoreTime", getmatchrulesdata("infectData", "survivorScoreTime"));
  setdynamicdvar("scr_infect_survivorScorePerTick", getmatchrulesdata("infectData", "survivorScorePerTick"));
  setdynamicdvar("scr_infect_infectStreakBonus", getmatchrulesdata("infectData", "infectStreakBonus"));
  setdynamicdvar("scr_infect_enableInfectedTracker", getmatchrulesdata("infectData", "enableInfectedTracker"));
  setdynamicdvar("scr_infect_enablePing", getmatchrulesdata("infectData", "enablePing"));
  setdynamicdvar("scr_infect_giveTKOnTISpawn", getmatchrulesdata("infectData", "giveTKOnTISpawn"));
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("scr_infect_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/INFECT");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/INFECT");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/INFECT_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/INFECT_HINT");
  }

  initspawns();
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level.infect_allowsuicide = 0;
  level.infect_skipsounds = 0;
  level.ref_12738 = 0;
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_awardedfinalsurvivor = 0;
  level.infect_countdowninprogress = 0;
  level.infect_teamscores["axis"] = 0;
  level.infect_teamscores["allies"] = 0;
  level.infect_players = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "shouldBeVisibleToPlayer", &ref_14124);

  if(istrue(level.unset_relic_laststandmelee)) {
    scripts\mp\gametypes\arm::monitordriverexitbutton();
    thread superselectonunset();
    thread ref_119d8();
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    level.droptime = getdvarint("scr_infect_dropTime", 30);

    if(level.droptime > 0) {
      thread ref_129fb();
      return;
    }

    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.numinitialinfected = scripts\mp\utility\dvars::dvarintvalue("numInitialInfected", 1, 1, 9);
  level.survivorprimaryweapon = getDvar("scr_infect_weaponSurvivorPrimary", "iw8_sh_romeo870_mp");
  level.survivorsecondaryweapon = getDvar("scr_infect_weaponSurvivorSecondary", "iw8_pi_golf21_mp");
  level.survivorlethal = getDvar("scr_infect_lethalSurvivor", "equip_claymore");
  level.survivortactical = getDvar("scr_infect_tacticalSurvivor", "equip_concussion");
  level.survivorsuper = getDvar("scr_infect_superSurvivor", "super_tac_cover");
  level.ref_139bd = getDvar("scr_infect_superSurvivorTwo", "none");
  level.infectedprimaryweapon = getDvar("scr_infect_weaponInfectPrimary", "iw8_knife_mp");
  level.infectedsecondaryweapon = getDvar("scr_infect_weaponInfectSecondary", "iw8_fists_mp");
  level.initialprimaryweapon = getDvar("scr_infect_weaponInitialPrimary", "iw8_sh_romeo870_mp");
  level.initialsecondaryweapon = getDvar("scr_infect_weaponInitialSecondary", "iw8_pi_golf21_mp");
  level.infectedlethal = getDvar("scr_infect_lethalInfect", "equip_throwing_knife");
  level.infectedtactical = getDvar("scr_infect_tacticalInfect", "equip_tac_insert");
  level.infectedsuper = getDvar("scr_infect_superInfect", "super_deadsilence");
  level.steam_dmg_trigger_think = getDvar("scr_infect_superInfectTwo", scripts\engine\utility::ter_op(level.unset_relic_laststandmelee, "super_tac_insert", "none"));
  level.infectextratimeperkill = scripts\mp\utility\dvars::dvarfloatvalue("infectExtraTimePerKill", 30, 0, 60);
  level.survivoralivescore = scripts\mp\utility\dvars::dvarintvalue("survivorAliveScore", 25, 0, 100);
  level.survivorscoretime = scripts\mp\utility\dvars::dvarfloatvalue("survivorScoreTime", 30, 0, 60);
  level.survivorscorepertick = scripts\mp\utility\dvars::dvarintvalue("survivorScorePerTick", 50, 0, 100);
  level.infectstreakbonus = scripts\mp\utility\dvars::dvarintvalue("infectStreakBonus", 50, 0, 100);
  level.enableinfectedtracker = scripts\mp\utility\dvars::dvarintvalue("enableInfectedTracker", 0, 0, 1);
  level.enableping = scripts\mp\utility\dvars::dvarintvalue("enablePing", 0, 0, 1);
  level.givetkontispawn = scripts\mp\utility\dvars::dvarintvalue("giveTKOnTISpawn", 0, 0, 1);
  level.stealth_broken_music = getdvarint("scr_infect_infectBonusScore", 150);
  level.stealth_broken_music_index = getdvarint("scr_infect_infectBonusSuperOnSpawn", 0);
  level.stealth_enabled = getdvarint("scr_infect_infectBonusSuperOnTacInsert", 0);
  level.play_player_approach = getdvarint("scr_infect_finalSuvivorCount", 1);
  level.steam_point_think = getdvarint("scr_infect_setRadarOnNumSurvivors", 8);
  level.ref_139bc = [];
  var_0 = getDvar("scr_infect_survivorStreakOverride", "");

  if(var_0 != "") {
    level.ref_139bc = strtok(var_0, ",");
  }

  var_1 = scripts\cp_mp\utility\game_utility::getmapname();

  if(issubstr(var_1, "mp_m_") && var_1 != "mp_m_speed") {
    level.survivorsuper = player_give_intel_3_ks(0, 0);
    level.ref_139bd = player_give_intel_3_ks(0, 1);
    level.infectedsuper = player_give_intel_3_ks(1, 0);
    level.steam_dmg_trigger_think = player_give_intel_3_ks(1, 1);
  }

  if(level.survivorsuper == level.ref_139bd) {
    level.ref_139bd = "none";
  } else if(level.survivorsuper == "none" && level.ref_139bd != "none") {
    level.survivorsuper = level.ref_139bd;
    level.ref_139bd = "none";
  }

  if(level.infectedsuper == level.steam_dmg_trigger_think) {
    level.steam_dmg_trigger_think = "none";
  } else if(level.infectedsuper == "none" && level.steam_dmg_trigger_think != "none") {
    level.infectedsuper = level.steam_dmg_trigger_think;
    level.steam_dmg_trigger_think = "none";
  }

  thread buildandloadweapons();
}

function buildandloadweapons() {
  waitframe();

  if(level.ref_12052) {
    switch (level.survivorprimaryweapon) {
      case "iw8_sh_dpapa12_mp":
        level.arenaloadouts = 10;
        break;
      case "iw8_ar_akilo47_mp":
        level.arenaloadouts = 7;
        break;
      case "iw8_pi_decho_mp":
        level.arenaloadouts = 9;
        break;
      case "iw8_sm_papa90_mp":
        level.arenaloadouts = 8;
        break;
      case "iw8_sn_alpha50_mp":
        level.arenaloadouts = 11;
        break;
      default:
        level.arenaloadouts = 7;
        break;
    }

    scripts\mp\gametypes\arena::cacherandomloadouts();
    level.survivorprimaryweapon = game["arenaRandomLoadout"][0]["loadoutPrimary"];
    level.survivorprimaryweapon += "_mp";

    if(game["arenaRandomLoadout"][0]["loadoutSecondary"] != "none") {
      level.survivorsecondaryweapon = game["arenaRandomLoadout"][0]["loadoutSecondary"];
      level.survivorsecondaryweapon += "_mp";
    }

    level.initialprimaryweapon = game["arenaRandomLoadout"][0]["loadoutPrimary"];
    level.initialprimaryweapon += "_mp";

    if(game["arenaRandomLoadout"][0]["loadoutSecondary"] != "none") {
      level.initialsecondaryweapon = game["arenaRandomLoadout"][0]["loadoutSecondary"];
      level.initialsecondaryweapon += "_mp";
    }
  }

  level.allweapons = [];
  level.allweapons[level.allweapons.size] = level.survivorprimaryweapon;
  level.allweapons[level.allweapons.size] = level.survivorsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedprimaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.initialprimaryweapon;
  level.allweapons[level.allweapons.size] = level.initialsecondaryweapon;
  level.survivorprimaryweapon = stripweapsuffix(level.survivorprimaryweapon);
  level.survivorsecondaryweapon = stripweapsuffix(level.survivorsecondaryweapon);
  level.infectedprimaryweapon = stripweapsuffix(level.infectedprimaryweapon);
  level.infectedsecondaryweapon = stripweapsuffix(level.infectedsecondaryweapon);
  level.initialprimaryweapon = stripweapsuffix(level.initialprimaryweapon);
  level.initialsecondaryweapon = stripweapsuffix(level.initialsecondaryweapon);

  foreach(var_1 in level.allweapons) {
    if(var_1 != "none") {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
      var_3 = [];

      if(level.ref_12052) {
        if(var_1 == level.allweapons[0] || var_1 == level.allweapons[4]) {
          for(var_4 = 1; var_4 < 6; var_4++) {
            var_5 = var_4;

            if(var_4 == 1) {
              var_5 = "";
            }

            var_6 = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment" + var_5];

            if(var_6 != "none") {
              var_3 = var_6;
            }
          }
        }

        if(var_1 == level.allweapons[1] || var_1 == level.allweapons[5]) {
          for(var_4 = 1; var_4 < 6; var_4++) {
            var_5 = var_4;

            if(var_4 == 1) {
              var_5 = "";
            }

            var_6 = game["arenaRandomLoadout"][0]["loadoutSecondaryAttachment" + var_5];

            if(var_6 != "none") {
              var_3 = var_6;
            }
          }
        }
      }

      if(level.steam_damaged) {
        game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"] = run_func_on_each_player();
      }

      var_7 = "none";
      var_8 = "none";
      var_9 = scripts\mp\class::buildweapon(var_2, var_3, var_7, var_8);
      var_10 = createheadicon(var_9);
    }
  }

  thread setspecialloadouts();
}

function run_func_on_each_player() {
  var_0 = game["arenaRandomLoadout"][0]["loadoutPrimary"] + "_mp";
  var_1 = weaponclass(var_0);
  level.ref_14543 = var_1;
  var_2 = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];

  switch (var_1) {
    case "smg":
    case "mg":
    case "rifle":
      var_3 = randomintrange(0, 3);

      if(var_3 == 0) {
        var_2 = "thermal";
      } else if(var_3 == 0) {
        var_2 = "thermal2";
      } else {
        var_2 = "hybrid3";
      }

      break;
    case "sniper":
      var_3 = randomintrange(0, 3);

      if(var_3 == 0) {
        var_2 = "thermal";
      } else if(var_3 == 0) {
        var_2 = "thermal2";
      } else {
        var_2 = "thermalvz";
      }

      break;
    case "spread":
      var_2 = "thermal";
    case "rocketlauncher":
      break;
    case "pistol":
      break;
    default:
      break;
  }

  return var_2;
}

function stripweapsuffix(var_0) {
  if(issubstr(var_0, "mpr")) {
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_mpr");
  } else if(issubstr(var_0, "mpl")) {
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_mpl");
  } else {
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_mp");
  }

  return var_0;
}

function player_give_intel_3_ks(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = scripts\engine\utility::ter_op(var_0, level.steam_dmg_trigger_think, level.ref_139bd);
  } else {
    var_2 = scripts\engine\utility::ter_op(var_1, level.infectedsuper, level.survivorsuper);
  }

  switch (var_2) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      var_2 = "super_ammo_drop";
      break;
    case "super_tac_insert":
      if(var_1 && level.infectedtactical == "equip_tac_insert") {
        level.infectedtactical = "none";
      } else if(level.survivortactical == "equip_tac_insert") {
        level.survivortactical = "none";
      }

      break;
    case "super_trophy":
      if(var_1 && level.infectedtactical == "equip_trophy") {
        level.infectedtactical = "none";
      } else if(level.survivortactical == "equip_trophy") {
        level.survivortactical = "none";
      }

      break;
  }

  return var_2;
}

function onplayerconnect(var_0) {
  var_0.gamemodefirstspawn = 1;
  var_0.gamemodejoinedatstart = 1;
  var_0.infectedrejoined = 0;
  var_0.waitedtospawn = 0;

  if(!scripts\mp\flags::gameflag("prematch_done") || level.infect_countdowninprogress) {
    var_0.waitedtospawn = 1;
  }

  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0.lastclass = var_0.pers["lastClass"];
  var_0 loadweaponsforplayer(level.allweapons, 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    var_0.gamemodejoinedatstart = 0;

    if(isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected) {
      var_0.survivalstarttime = gettime();
    }
  }

  if(isDefined(level.infect_players[var_0.name])) {
    var_0.infectedrejoined = 1;
  }

  if(isDefined(var_0.isinitialinfected)) {
    var_0.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  } else if(var_0.infectedrejoined) {
    var_0.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  } else {
    var_0.pers["gamemodeLoadout"] = level.infect_loadouts["allies"];
  }

  thread monitorsurvivaltime();

  if(level.unset_relic_laststandmelee) {
    thread ref_133f7();
    return;
  }
}

function givesurvivortimescore() {
  level endon("game_ended");

  for(;;) {
    wait level.survivorscoretime;

    foreach(var_1 in level.players) {
      if(var_1.team == "allies") {
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("survivor", undefined, level.survivorscorepertick);
      }
    }
  }
}

function initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    var_0 = "mp_gw_spawn_allies_start";
    var_1 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = var_0;
    level.gamemodestartspawnpointnames["axis"] = var_1;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["allies"] = "mp_tdm_spawn";
    level.gamemodespawnpointnames["axis"] = "mp_tdm_spawn";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah") {
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWarTTLOS", "Crit_Default");
    } else if(scripts\cp_mp\utility\game_utility::islargemap()) {
      scripts\mp\spawnlogic::setactivespawnlogic("GroundWar", "Crit_Default");
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
    }

    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addstartspawnpoints("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_gw_spawn_allies_start");
    scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_gw_spawn_axis_start");
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::registerspawnset("start_attackers", var_2);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", var_3);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var_5 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", var_4);
    scripts\mp\spawnlogic::registerspawnset("fallback", var_5);
    return;
  }

  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_4 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var_5 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_4);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_5);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function alwaysgamemodeclass() {
  return "gamemode";
}

function getspawnpoint() {
  if(isPlayer(self) && self.gamemodefirstspawn) {
    self.gamemodefirstspawn = 0;
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";
    self.class = self.pers["class"];
    self.lastclass = self.pers["lastClass"];
    var_0 = "allies";

    if(self.infectedrejoined) {
      var_0 = "axis";
    }

    scripts\mp\menus::addtoteam(var_0, 1);
    thread monitordisconnect();
  }

  if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_random(var_1);
  } else {
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return var_2;
}

function onspawnplayer() {
  self.teamchangedthisframe = undefined;
  self.infect_spawnpos = self.origin;
  self.infectedkillsthislife = 0;

  if(self.pers["team"] == "axis") {
    scripts\mp\battlechatter_mp::disablebattlechatter(self);

    if(istrue(level.unset_relic_laststandmelee)) {
      self.little_bird_mg_playerexitturret = 1;
    }
  }

  updateteamscores();

  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    thread choosefirstinfected();
  }

  if(!scripts\mp\flags::gameflag("prematch_done") || level.infect_countdowninprogress) {
    self.waitedtospawn = 0;
  }

  if(self.infectedrejoined) {
    if(!level.infect_allowsuicide) {
      level notify("infect_stopCountdown");
      level.infect_chosefirstinfected = 1;
      level.infect_allowsuicide = 1;

      foreach(var_1 in level.players) {
        if(isDefined(var_1.infect_isbeingchosen)) {
          var_1.infect_isbeingchosen = undefined;
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1.isinitialinfected)) {
        thread setinitialtonormalinfected();
      }
    }

    if(level.infect_teamscores["axis"] == 1) {
      self.isinitialinfected = 1;
    }

    initsurvivaltime(1);
  }

  thread onspawnfinished();
  thread updatematchstatushintonspawn();
  level notify("spawned_player");
}

function spawnwithplayersecondary() {
  var_0 = self getweaponslistprimaries();
  var_1 = self getcurrentprimaryweapon();

  if(var_0.size > 1) {
    if(scripts\mp\utility\weapon::isknifeonly(var_1)) {
      foreach(var_3 in var_0) {
        if(var_3 != var_1) {
          self setspawnweapon(var_3);
        }
      }

      return;
    }

    return;
  }
}

function setdefaultammoclip(var_0) {
  var_1 = 1;

  if(isDefined(self.isinitialinfected)) {
    if(scripts\mp\utility\game::isusingdefaultclass(var_0, 1)) {
      var_1 = 0;
    }
  } else if(scripts\mp\utility\game::isusingdefaultclass(var_0, 0)) {
    var_1 = 0;
  }

  return var_1;
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(istrue(self.waitedtospawn)) {
    self.waitedtospawn = 0;
    self.ref_13968 = 1;
    wait 0.1;
    self suicide();
  }

  self.last_infected_class = self.infected_class;

  if(self.pers["team"] == "allies") {
    if(level.enableping) {
      scripts\mp\utility\perk::giveperk("specialty_boom");
    }

    if(level.unset_relic_laststandmelee) {
      thread searchfortarget();
    }

    spawnwithplayersecondary();

    if(level.steam_damaged && !level.steam_damage_players && !isbot(self)) {
      thread ref_11f4b();
    }
  } else if(self.pers["team"] == "axis") {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self detachall();
      self setModel("fullbody_zombie_a");
      self setviewmodel("vm_arms_zombie_a");

      if(getdvarint("scr_infect_hw_zmb_vision", 1) == 1) {
        thread ref_126ff();
      }

      self playlocalsound("zmb_breath_land_dropin");
      self.unset_relic_steelballs = 1;
    }

    if(istrue(level.brking_initfeatures)) {
      self skydive_cutautodeployon();
    }

    if(level.enableping) {
      scripts\mp\utility\perk::giveperk("specialty_boom");
    }

    var_0 = 1.05;

    if(!level.unset_relic_laststandmelee) {
      var_1 = int(floor(level.infect_teamscores["axis"] / 3));
      var_1 *= 0.01;
      var_0 = max(1, var_0 - var_1);
    }

    self.overrideweaponspeed_speedscale = var_0;
    thread setinfectedmsg();

    if(level.infectedtactical == "equip_tac_insert" && !istrue(self.isinitialinfected)) {
      if(level.givetkontispawn || !level.givetkontispawn && !self.ti_spawn) {
        scripts\mp\equipment::giveequipment(level.infectedlethal, "primary");
      } else {
        scripts\mp\equipment::decrementequipmentammo(level.infectedlethal, 1);
      }
    }

    if(level.infectedtactical != "equip_tac_insert" || level.infectedtactical == "none") {
      scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    } else {
      scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");
    }
  }

  giveextrainfectedperks();

  if(istrue(self.ref_11d9e)) {
    if(!level.unset_relic_laststandmelee || level.unset_relic_laststandmelee && level.mapname == "mp_aniyah") {
      self.ref_11d9e = undefined;
    }

    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {} else {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(self.loadoutprimary);

    if(var_2 != "iw8_knife") {
      var_3 = getcompleteweaponname("iw8_knifestab_mp");
      self giveweapon(var_3);
      self assignweaponmeleeslot(var_3);

      if(self.loadoutsecondary == "iw8_knife") {
        scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw8_knife_mp");
        self giveweapon("iw8_knife_mp");
      }
    }
  }

  self.faux_spawn_infected = undefined;

  if(istrue(self.updatearenaomnvardata)) {
    self.updatearenaomnvardata = undefined;
    thread scripts\cp_mp\parachute::stop_restock_recharge(1);
  }

  thread scripts\mp\supers::givesuperpoints(level.stealth_broken_music_index, undefined, 1);
  thread ref_14399();
}

function ref_126ff() {
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self setscriptablepartstate("headVFX", "zombieVision");
  waitframe();

  if(getdvarint("scr_br_zxp_loop_zombie_fx", 1)) {
    self setscriptablepartstate("zombie", "on_loop");
    return;
  }

  self setscriptablepartstate("zombie", "on");
}

function ref_14399() {
  self endon("death_or_disconnect");
  wait 0.2;

  if(istrue(level.setplayerselfrevivingextrainfo) && self.team == "axis") {
    self method_87aa("zombie");
    return;
  }

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
    return;
  }

  self method_87aa("");
}

function searchfortarget() {
  scripts\mp\flags::gameflagwait("prematch_done");
  thread scripts\mp\supers::givesuperpoints(200, undefined, 1);
}

function managefists(var_0, var_1) {
  if(var_0 != "iw8_fists" || var_1 != "iw8_fists") {
    if(var_0 == "none" && var_1 == "none") {
      return;
    }

    scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw8_fists_mp");
    return;
  }
}

function giveextrainfectedperks() {
  if(self.pers["team"] == "allies") {
    var_0 = ["specialty_fastreload"];
  } else if(istrue(self.isinitialinfected)) {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage", "specialty_bulletaccuracy", "specialty_quickswap"];
  } else {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage"];
  }

  foreach(var_2 in var_0) {
    scripts\mp\utility\perk::giveperk(var_2);
  }
}

function setinfectedmodels() {}

function setinfectedmsg() {
  if(isDefined(self.isinitialinfected)) {
    if(!isDefined(self.showninfected) || !self.showninfected) {
      thread scripts\mp\rank::scoreeventpopup("first_infected");
      self.showninfected = 1;
      return;
    }

    return;
  }

  if(isDefined(self.changingtoregularinfected)) {
    self.changingtoregularinfected = undefined;

    if(isDefined(self.changingtoregularinfectedbykill)) {
      self.changingtoregularinfectedbykill = undefined;
      thread scripts\mp\utility\points::giveunifiedpoints("first_infected");
      return;
    }

    return;
  }

  if(!isDefined(self.showninfected) || !self.showninfected) {
    thread scripts\mp\rank::scoreeventpopup("got_infected");
    self.showninfected = 1;
    return;
  }
}

function choosefirstinfected() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level endon("force_end");
  level.infect_allowsuicide = 0;
  scripts\mp\flags::gameflagwait("prematch_done");
  level.infect_countdowninprogress = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  setomnvar("ui_match_start_text", "first_infected_in");
  var_0 = 15;

  while(var_0 > 0 && !level.gameended) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("ui_match_start_countdown", var_0);
    }

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  setomnvar("ui_match_start_text", "match_starting_in");

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_start_countdown", 0);
  }

  level.infect_countdowninprogress = 0;
  var_6 = [];

  foreach(var_8 in level.players) {
    if(scripts\mp\utility\game::matchmakinggame() && level.players.size > 1 && var_8 ishost()) {
      continue;
    }

    if(var_8.team == "spectator") {
      continue;
    }

    if(!var_8.hasspawned) {
      continue;
    }

    var_6 = var_8;
  }

  level.player_damage_blood = 0;

  if(var_6.size <= level.numinitialinfected && var_6.size > 1) {
    level.numinitialinfected = var_6.size - 1;
  }

  var_10 = [];

  for(var_11 = 0; var_11 < level.numinitialinfected; var_11++) {
    var_12 = var_6[randomint(var_6.size)];
    var_10 = var_12;
    var_6 = scripts\engine\utility::array_remove(var_6, var_12);
  }

  foreach(var_12 in var_10) {
    setfirstinfected(var_12, 1);
  }

  level.infect_allowsuicide = 1;

  foreach(var_8 in level.players) {
    if(istrue(var_8.isinitialinfected)) {
      var_8 thread scripts\mp\hud_message::showsplash("first_infected");
      var_8 scripts\mp\utility\dialog::leaderdialogonplayer("infected_first");
      continue;
    }

    var_8 thread scripts\mp\hud_message::showsplash("first_survivor");
    var_8.survivalstarttime = gettime();
  }
}

function setfirstinfected(var_0) {
  self endon("death_or_disconnect");

  if(var_0) {
    self.infect_isbeingchosen = 1;
  }

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote() || isDefined(self.ref_1425d)) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  var_1 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.allowairexit = 1;
    var_2.onprematchfadedone2 = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_1, undefined, self, var_2, 1);

    while(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      waitframe();
    }
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!isalive(self)) {
    waitframe();
  }

  while(istrue(self.usingascender)) {
    waitframe();
  }

  if(var_0) {
    scripts\mp\menus::addtoteam("axis", undefined, 1);
    thread monitordisconnect();
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
    updateteamscores();

    if(scripts\mp\utility\player::isfemale()) {
      self playlocalsound("Fem_breathing_better");
    } else {
      self playlocalsound("breathing_better");
    }

    thread scripts\mp\music_and_dialog::stealthtimeelapsed();
  }

  self.isinitialinfected = 1;
  scripts\mp\utility\stats::incpersstat("firstInfected", 1);
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;
  self.operatorcustomization = undefined;
  waittillframeend();
  thread scripts\mp\playerlogic::spawnplayer(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuperref() == "super_deadsilence") {
    thread ref_1383e();
  } else if(level.unset_relic_laststandmelee) {
    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);
  }

  if(var_0) {
    level.infect_players[self.name] = 1;
  }

  level.player_damage_blood = 1;

  if(!level.player_damage_blood) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_first_infected", self);
  }

  if(!level.infect_skipsounds) {
    scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured");
    level.infect_skipsounds = 1;
  }

  thread ref_1439e();
  initsurvivaltime(1);
}

function ref_1439e() {
  self endon("death_or_disconnect");
  wait 4;
  self iprintlnbold(&"SPLASHES/INFECT_ALL");
}

function ref_1383e() {
  thread scripts\mp\supers::givesuperpoints(4000, undefined, 1);
  thread scripts\mp\perks\perkpackage::perkpackage_forceusesuper();
}

function setinitialtonormalinfected(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self.isinitialinfected = undefined;
  self.changingtoregularinfected = 1;

  if(isDefined(var_0)) {
    self.changingtoregularinfectedbykill = 1;
  }

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(self ismeleeing()) {
    waitframe();
  }

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuper().isinuse) {
    thread scripts\mp\supers::superusefinished(0);
  }

  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuperref() == "super_deadsilence") {
    thread ref_1383e();
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }

  var_10 = 0;
  var_11 = 0;
  thread shouldplayhalfwayvo();

  if(self.team == "axis") {}

  if(self.team == "allies" && isDefined(var_1)) {
    self.operatorcustomization = undefined;

    if(isPlayer(var_1) && var_1 != self) {
      var_10 = 1;
    } else if(level.infect_allowsuicide && (var_1 == self || !isPlayer(var_1))) {
      var_10 = 1;
      var_11 = 1;
    }
  }

  if(self.team == "allies" && istrue(level.nukeincoming)) {
    if(isDefined(level.ref_11f14) && self == level.ref_11f14) {
      var_10 = 0;
      var_11 = 0;
    }
  }

  if(isPlayer(var_1) && var_1.team == "allies" && var_1 != self) {
    var_1 scripts\mp\utility\stats::incpersstat("killsAsSurvivor", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", var_1.pers["killsAsSurvivor"]);
  } else if(isPlayer(var_1) && var_1.team == "axis" && var_1 != self) {
    var_1 scripts\mp\utility\stats::incpersstat("killsAsInfected", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "killsAsInfected", var_1.pers["killsAsInfected"]);

    if(isPlayer(var_1)) {
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["killsAsInfected"]);
    }
  }

  if(var_10) {
    thread delayedprocesskill(var_1, var_11);

    if(var_11) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected)) {
          thread setinitialtonormalinfected();
        }
      }
    } else if(isDefined(var_1.isinitialinfected)) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected)) {
          thread setinitialtonormalinfected(var_13);
        }
      }
    } else if(level.infectstreakbonus > 0) {
      if(!isDefined(var_1.infectedkillsthislife)) {
        var_1.infectedkillsthislife = 1;
      } else {
        var_1.infectedkillsthislife++;
      }

      var_1 thread scripts\mp\utility\points::giveunifiedpoints("infected_survivor", undefined, level.infectstreakbonus * var_1.infectedkillsthislife);
    } else {
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("infected_survivor");
    }

    if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") != 0) {
      var_17 = 1;

      if(scripts\mp\utility\game::matchmakinggame()) {
        level.packclientmatchdata++;
        var_17 = level.packclientmatchdata <= level.packedbits;
      }

      if(var_17) {
        if(!isDefined(level.extratime)) {
          level.extratime = level.infectextratimeperkill;
        } else {
          level.extratime += level.infectextratimeperkill;
        }
      }
    }

    setsurvivaltime(1);
    return;
  }

  if(isbot(self)) {
    self.classcallback = "gamemode";
  }

  if(isDefined(self.isinitialinfected)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    self.infected_class = "axis_initial";
    return;
  }

  self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
  self.infected_class = self.pers["team"];
}

function delayedprocesskill(var_0, var_1) {
  self.ref_11d9e = 1;

  if(level.unset_relic_laststandmelee && level.mapname != "mp_aniyah") {
    ref_1314d();
  }

  wait 0.15;
  self.teamchangedthisframe = 1;
  scripts\mp\menus::addtoteam("axis");

  if(!istrue(self.ref_13968)) {
    var_2 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
    var_2 -= 240;
    self.pers["afkResetTime"] = var_2;
  } else {
    self.ref_13968 = 0;
  }

  updateteamscores();
  level.infect_players[self.name] = 1;
  thread monitordisconnect();

  if(level.infect_teamscores["allies"] > 1) {
    if(level.unset_relic_laststandmelee) {
      level.ref_12738++;

      if(level.ref_12738 > 3) {
        level.ref_12738 = 1;
      }

      if(level.infect_teamscores["allies"] == level.steam_point_think) {
        thread ref_13861();
      }
    }

    if(level.ref_12738 == 1) {
      scripts\mp\utility\sound::playsoundonplayers("mp_enemy_obj_captured", "allies");
      scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_taken", "axis");
      thread scripts\mp\hud_util::teamplayercardsplash("callout_got_infected", self, "allies");
    }

    if(!var_1) {
      thread scripts\mp\hud_util::teamplayercardsplash("callout_infected", var_0, "axis");

      if(!isDefined(level.survivorscoreevent)) {
        var_3 = getdvarint("scr_infect_survivorinitialscore", 50);

        if(var_3 > 0) {
          level.survivorscoreevent = var_3;
        } else {
          level.survivorscoreevent = scripts\mp\rank::getscoreinfovalue("survivor");
        }
      } else {
        level.survivorscoreevent += level.survivoralivescore;
      }

      foreach(var_5 in level.players) {
        if(var_5.team == "allies" && var_5 != self && distance(var_5.infect_spawnpos, var_5.origin) > 32) {
          var_5 thread scripts\mp\utility\points::giveunifiedpoints("survivor", undefined, level.survivorscoreevent);
        }

        if(var_5.team == "axis" && var_5 != var_0 && var_5 != self) {
          var_5 thread scripts\mp\utility\points::giveunifiedpoints("assist", undefined, level.stealth_broken_music);
          LOC_0000021e:
        }
        LOC_0000021e:
      }
    }
  } else if(level.infect_teamscores["allies"] == level.play_player_approach) {
    onfinalsurvivor();
  } else if(level.infect_teamscores["allies"] == 0) {
    onsurvivorseliminated();
  }

  if(isbot(self)) {
    self.classcallback = "gamemode";
  }

  if(isDefined(self.isinitialinfected)) {
    self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
    self.infected_class = "axis_initial";
    return;
  }

  self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
  self.infected_class = self.pers["team"];
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.matchmakingmatch) && isDefined(var_1) && isDefined(var_0)) {
    var_6 = var_1 getfireteammembers();

    if(isDefined(var_6) && var_6.size > 0) {
      foreach(var_8 in var_6) {
        if(isDefined(var_8) && var_0 == var_8) {
          var_1 scripts\mp\killstreaks\killstreaks::givestreakpoints("kill", -1, 0);
          var_1.nukepoints = scripts\engine\utility::ter_op(var_1.nukepoints > 0, var_1.nukepoints - 1, 0);
          break;
        }
      }

      return;
    }

    return;
  }
}

function onfinalsurvivor() {
  scripts\mp\utility\sound::playsoundonplayers("mp_obj_captured");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1.team == "allies") {
      var_1 scripts\mp\utility\dialog::leaderdialogonplayer("infected_lastalive");
      var_1 thread scripts\mp\rank::scoreeventpopup("final_survivor");
      var_1 scripts\mp\utility\stats::incpersstat("lastSurvivor", 1);

      if(scripts\mp\utility\game::matchmakinggame()) {
        if(!var_1 scripts\mp\utility\killstreak::isjuggernaut()) {
          var_1.maxhealth = 200;
          var_1 notify("force_regeneration");
        }
      }

      if(!level.infect_awardedfinalsurvivor) {
        if(var_1.gamemodejoinedatstart && isDefined(var_1.infect_spawnpos) && distance(var_1.infect_spawnpos, var_1.origin) > 32) {
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("final_survivor");
        }

        level.infect_awardedfinalsurvivor = 1;
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_final_survivor", var_1);

      if(level.steam_damaged) {} else {
        thread finalsurvivoruav(level);
      }

      break;
    }
  }
}

function finalsurvivoruav(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  level endon("infect_lateJoiner");
  thread enduavonlatejoiner(level);
  var_1 = getuavstrengthlevelneutral();

  if(level.unset_relic_laststandmelee && level.mapname != "mp_aniyah") {
    var_1 = 5;
  }

  var_2 = 1;
  var_3 = 0;
  level.radarmode["axis"] = "normal_radar";

  foreach(var_5 in level.players) {
    if(var_5.team == "axis") {
      var_5.radarmode = "normal_radar";
    }
  }

  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var_1 + 1);

  for(;;) {
    var_7 = var_0.origin;
    wait 4;

    if(var_3) {
      setteamradar("axis", 0);
      var_3 = 0;
    }

    wait 6;

    if(distance(var_7, var_0.origin) < 200) {
      setteamradar("axis", 1);
      var_3 = 1;

      foreach(var_5 in level.players) {
        var_5 playlocalsound("recondrone_tag");
      }
    }

    if(var_2) {
      var_2 = 0;
      var_1 = getuavstrengthlevelneutral();
      scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var_1 + 1);
    }
  }
}

function ref_119d8() {
  scripts\mp\flags::gameflagwait("prematch_done");

  while(level.infect_teamscores["allies"] > level.steam_point_think) {
    foreach(var_1 in level.players) {
      if(var_1.team == "axis") {
        triggeroneoffradarsweep(var_1);
      }
    }

    wait getdvarint("scr_infect_longWaitUAV", 60);
  }
}

function enduavonlatejoiner(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");

  for(;;) {
    if(level.infect_teamscores["allies"] > level.play_player_approach) {
      level notify("infect_lateJoiner");
      waitframe();
      setteamradar("axis", 0);
      break;
    }

    waitframe();
  }
}

function ref_13861() {
  level.radarmode["axis"] = "normal_radar";

  foreach(var_1 in level.players) {
    if(var_1.team == "axis") {
      var_1.radarmode = "normal_radar";
    }
  }

  var_3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var_3 + 1);
  setteamradar("axis", 1);
}

function monitordisconnect() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var_0 = self.team;

  if(!isDefined(var_0) && isDefined(self.bot_team)) {
    var_0 = self.bot_team;
  }

  self waittill("disconnect");
  updateteamscores();

  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"]) {
      if(level.unset_relic_laststandmelee) {
        if(var_0 == "allies" && level.infect_teamscores["allies"] == level.steam_point_think) {
          thread ref_13861();
        }
      }

      if(var_0 == "allies" && level.infect_teamscores["allies"] == level.play_player_approach) {
        onfinalsurvivor();
      } else if(var_0 == "axis" && level.infect_teamscores["axis"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "axis") {
            setfirstinfected(var_2, 0);
          }
        }
      }
    } else if(level.infect_teamscores["allies"] == 0) {
      if(istrue(level.hostmigration)) {
        scripts\mp\hostmigration::waittillhostmigrationdone();
      }

      onsurvivorseliminated();
    } else if(level.infect_teamscores["axis"] == 0) {
      if(level.infect_teamscores["allies"] == 1) {
        level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"][tolower(game["axis"]) + "_eliminated"]);
      } else if(level.infect_teamscores["allies"] > 1) {
        level.infect_chosefirstinfected = 0;
        thread choosefirstinfected();
      }
    }
  } else if(level.infect_countdowninprogress && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.infect_choosingfirstinfected = 0;

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_match_start_countdown", 0);
    }
  }

  self.isinitialinfected = undefined;
}

function ondeadevent(var_0) {}

function ontimelimit() {
  level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

function onsurvivorseliminated() {
  level thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["survivors_eliminated"]);
}

function getteamsize(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator" && !var_3.spectatekillcam && !istrue(var_3.inspawncamera)) {
      continue;
    }

    if(var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

function updateteamscores() {
  level.infect_teamscores["allies"] = getteamsize("allies");
  game["teamScores"]["allies"] = level.infect_teamscores["allies"];
  setteamscore("allies", level.infect_teamscores["allies"]);
  level.infect_teamscores["axis"] = getteamsize("axis");
  game["teamScores"]["axis"] = level.infect_teamscores["axis"];
  setteamscore("axis", level.infect_teamscores["axis"]);
}

function setspecialloadouts() {
  waitframe();

  if(!isDefined(level.survivorprimaryweapon) || level.survivorprimaryweapon == "") {
    level.survivorprimaryweapon = "iw8_sh_romeo870_mp";
  }

  if(!isDefined(level.survivorsecondaryweapon) || level.survivorsecondaryweapon == "") {
    level.survivorsecondaryweapon = "iw8_pi_golf21_mp";
  }

  if(!isDefined(level.infectedprimaryweapon) || level.infectedprimaryweapon == "") {
    level.infectedprimaryweapon = "iw8_knife_mp";
  }

  if(!isDefined(level.infectedsecondaryweapon) || level.infectedsecondaryweapon == "") {
    level.infectedsecondaryweapon = "iw8_fists_mp";
  }

  if(!isDefined(level.initialprimaryweapon) || level.initialprimaryweapon == "") {
    level.initialprimaryweapon = "iw8_sh_romeo870_mp";
  }

  if(isDefined(level.infectedprimaryweapon) && level.infectedprimaryweapon == "iw8_knife_mp") {
    level.infectedprimaryweapon = "iw8_knife_mp";

    if(isDefined(level.infectedsecondaryweapon) && level.infectedsecondaryweapon == "iw8_knife_mp") {
      level.infectedsecondaryweapon = "none";
    }
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    level.infectedprimaryweapon = "iw8_fists_mp_zmb";
    level.infectedsecondaryweapon = "iw8_fists_mp_zmb";
  }

  if(!isDefined(level.initialsecondaryweapon) || level.initialsecondaryweapon == "") {
    level.initialsecondaryweapon = "iw8_pi_golf21_mp";
  }

  if(!isDefined(level.survivorlethal) || level.survivorlethal == "") {
    level.survivorlethal = "equip_claymore";
  }

  if(!isDefined(level.survivortactical) || level.survivortactical == "") {
    level.survivortactical = "equip_concussion";
  }

  if(!isDefined(level.infectedlethal) || level.infectedlethal == "") {
    level.infectedlethal = "equip_throwing_knife";
  }

  if(!isDefined(level.infectedtactical) || level.infectedtactical == "") {
    level.infectedtactical = "equip_tac_insert";
  }

  level.infect_allyrigs = [];
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assault";
  var_0 = 0;
  var_1 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.survivorprimaryweapon);
  var_0 = scripts\mp\class::ref_139e7(level.survivorprimaryweapon, var_1);
  var_2 = 0;
  var_3 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.survivorsecondaryweapon);
  var_2 = scripts\mp\class::ref_139e7(level.survivorsecondaryweapon, var_3);

  if(scripts\mp\utility\game::isusingdefaultclass("allies", 0)) {
    level.infect_loadouts["allies"] = scripts\mp\utility\game::getmatchrulesspecialclass("allies", 0);
  } else if(level.ref_12052) {
    level.infect_loadouts["allies"]["loadoutPrimary"] = level.survivorprimaryweapon;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = var_0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = var_2;
    level.infect_loadouts["allies"]["loadoutEquipmentPrimary"] = level.survivorlethal;
    level.infect_loadouts["allies"]["loadoutEquipmentSecondary"] = level.survivortactical;
    level.infect_loadouts["allies"]["loadoutSuper"] = "none";
    level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";

    if(level.ref_139bc.size > 0) {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = level.ref_139bc[0];
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = level.ref_139bc[1];
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = level.ref_139bc[2];
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_warhead", "specialty_scavenger_plus", "specialty_restock"];
    } else {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
      level.infect_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_hardline"];
      level.infect_loadouts["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    }

    level.infect_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["allies"]["loadoutFieldUpgrade1"] = level.survivorsuper;
    level.infect_loadouts["allies"]["loadoutFieldUpgrade2"] = level.ref_139bd;
  } else {
    level.infect_loadouts["allies"]["loadoutPrimary"] = level.survivorprimaryweapon;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = level.attachmentsurvivorprimary;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = var_0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = var_2;
    level.infect_loadouts["allies"]["loadoutEquipmentPrimary"] = level.survivorlethal;
    level.infect_loadouts["allies"]["loadoutEquipmentSecondary"] = level.survivortactical;
    level.infect_loadouts["allies"]["loadoutSuper"] = "none";
    level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";

    if(level.ref_139bc.size > 0) {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = level.ref_139bc[0];
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = level.ref_139bc[1];
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = level.ref_139bc[2];
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_warhead", "specialty_scavenger_plus", "specialty_restock"];
    } else {
      level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
      level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
      level.infect_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
      level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_hardline"];
      level.infect_loadouts["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    }

    level.infect_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["allies"]["loadoutFieldUpgrade1"] = level.survivorsuper;
    level.infect_loadouts["allies"]["loadoutFieldUpgrade2"] = level.ref_139bd;

    if(level.enableping) {}
  }

  var_4 = 0;
  var_5 = 0;

  if(level.survivorprimaryweapon == level.initialprimaryweapon) {
    var_4 = var_0;
  } else {
    var_6 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.initialprimaryweapon);
    var_4 = scripts\mp\class::ref_139e7(level.initialprimaryweapon, var_6);
  }

  if(level.survivorsecondaryweapon == level.initialsecondaryweapon) {
    var_5 = var_2;
  } else {
    var_7 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.initialsecondaryweapon);
    var_5 = scripts\mp\class::ref_139e7(level.initialsecondaryweapon, var_7);
  }

  var_8 = [];

  if(level.unset_relic_laststandmelee) {
    GscBinSkip0(0x2e, var_8.size, "specialty_restock");
  }

  if(scripts\mp\utility\game::isusingdefaultclass("axis", 1)) {
    level.infect_loadouts["axis_initial"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 1);
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
  } else if(level.ref_12052) {
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = var_4;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = var_5;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = var_8;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;
  } else {
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = level.attachmentinitialprimary;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = var_4;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = var_5;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = var_8;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;

    if(level.enableinfectedtracker) {}

    if(level.enableping) {}
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    var_9 = 0;
  } else {
    var_9 = 0;
    var_10 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.infectedprimaryweapon);
    var_9 = scripts\mp\class::ref_139e7(level.infectedprimaryweapon, var_10);
  }

  var_11 = [];

  if(level.unset_relic_laststandmelee) {
    GscBinSkip0(0x2e, var_11.size, "specialty_restock");
  }

  if(scripts\mp\utility\game::isusingdefaultclass("axis", 0)) {
    level.infect_loadouts["axis"] = scripts\mp\utility\game::getmatchrulesspecialclass("axis", 0);
    level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
    return;
  }

  level.infect_loadouts["axis"]["loadoutPrimary"] = level.infectedprimaryweapon;
  level.infect_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryVariantID"] = var_9;
  level.infect_loadouts["axis"]["loadoutSecondary"] = level.infectedsecondaryweapon;
  level.infect_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryVariantID"] = -1;
  level.infect_loadouts["axis"]["loadoutEquipmentPrimary"] = level.infectedlethal;
  level.infect_loadouts["axis"]["loadoutEquipmentSecondary"] = level.infectedtactical;
  level.infect_loadouts["axis"]["loadoutSuper"] = level.infectedsuper;
  level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.infect_loadouts["axis"]["loadoutPerks"] = var_11;
  level.infect_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.infect_loadouts["axis"]["loadoutFieldUpgrade1"] = level.infectedsuper;
  level.infect_loadouts["axis"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;

  if(level.enableinfectedtracker) {}

  if(level.enableping) {
    return;
  }
}

function addsurvivorattachmentsprimary(var_0) {
  level.attachmentsurvivorprimary = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_shotgun") {
    level.attachmentsurvivorprimary = "barrelrange";
    return;
  }

  if(var_1 == "weapon_assault" || var_1 == "weapon_tactical" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level.attachmentsurvivorprimary = "highcal";
    return;
  }
}

function addinitialattachmentsprimary(var_0) {
  level.attachmentinitialprimary = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_shotgun") {
    level.attachmentinitialprimary = "barrelrange";
    return;
  }

  if(var_1 == "weapon_assault" || var_1 == "weapon_tactical" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level.attachmentinitialprimary = "highcal";
    return;
  }
}

function addsurvivorattachmentssecondary(var_0) {
  level.attachmentsurvivorsecondary = "none";
  level.attachmentsurvivorsecondarytwo = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_pistol") {
    level.attachmentsurvivorsecondary = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level.attachmentsurvivorsecondary = "akimbo";
      level.attachmentsurvivorsecondarytwo = "highcal";
      return;
    }

    return;
  }
}

function addinitialattachmentssecondary(var_0) {
  level.attachmentinitialsecondary = "none";
  level.attachmentinitialsecondarytwo = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_pistol") {
    level.attachmentinitialsecondary = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level.attachmentinitialsecondary = "akimbo";
      level.attachmentinitialsecondarytwo = "highcal";
      return;
    }

    return;
  }
}

function monitorsurvivaltime() {
  self endon("death_or_disconnect");
  self endon("infected");
  level endon("game_ended");

  for(;;) {
    if(!level.infect_chosefirstinfected || !isDefined(self.survivalstarttime) || !isalive(self)) {
      waitframe();
      continue;
    }

    setsurvivaltime(0);
    wait 1;
  }
}

function initsurvivaltime(var_0) {
  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0) && var_0) {
    self notify("infected");
    return;
  }
}

function setsurvivaltime(var_0) {
  if(!isDefined(self.survivalstarttime)) {
    self.survivalstarttime = self.spawntime;
  }

  var_1 = int((gettime() - self.survivalstarttime) / 1000);

  if(var_1 > 999) {
    var_1 = 999;
  }

  scripts\mp\utility\stats::setextrascore0(var_1);

  if(isDefined(var_0) && var_0) {
    self notify("infected");
    return;
  }
}

function shouldplayhalfwayvo() {
  if(!level.didhalfscorevoboost && getteamscore("axis") >= int(level.players.size - level.players.size / 2)) {
    var_0 = "axis";
    scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", var_0, "status");
    var_1 = scripts\mp\utility\teams::getenemyteams(var_0);

    foreach(var_3 in var_1) {
      scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", var_3, "status");
    }

    level.didhalfscorevoboost = 1;
    return;
  }
}

function updatematchstatushintonspawn() {
  level endon("game_ended");

  if(self.team == "allies") {
    self setclientomnvar("ui_match_status_hint_text", 39);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 40);
}

function ref_11f4b() {
  self endon("death");
  self endon("spawned");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(self isnightvisionon()) {
      var_0 += level.framedurationseconds;

      if(var_0 >= 9 && !var_1) {
        scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/LOW_BATTERY");
        var_1 = 1;
      }

      if(var_0 >= 10) {
        self nightvisionviewoff();
        self setclientomnvar("ui_ctf_flag_carrier", 1);
        scripts\common\utility::brjugg_oncrateuse(0);
        ref_12a93();
        scripts\common\utility::brjugg_oncrateuse(1);
        var_1 = 0;
        self setclientomnvar("ui_ctf_flag_carrier", 0);
        var_0 = 0;
      }
    }

    wait level.framedurationseconds;
  }
}

function ref_12a93() {
  var_0 = 0;

  while(var_0 < 5) {
    var_0 += level.framedurationseconds;

    if(self isnightvisionon()) {
      self nightvisionviewoff();
    }

    wait level.framedurationseconds;
  }
}

function ref_122ff() {
  if(self.team == "axis") {
    if(scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
      scripts\mp\utility\perk::removeperk("specialty_tacticalinsertion");
    }

    if(!scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
      scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");
    }

    scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    return;
  }
}

function ref_13a06() {
  thread headicon_time_left();
}

function headicon_time_left() {
  self.loadoutfieldupgrade1 = "none";
  self.loadoutfieldupgrade2 = "none";
  self.loadoutfieldupgrade1 = level.infectedsuper;
  self.loadoutfieldupgrade2 = level.steam_dmg_trigger_think;
  wait 0.1;

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
    self notify("giveLoadout_start");
    scripts\mp\supers::clearsuper();
    scripts\mp\perks\perkpackage::perkpackage_reset();
    self.perkpackagedata.istwomode = 1;
    scripts\mp\perks\perkpackage::perkpackage_setstate(0);
    self.perkpackagedata.super = "super_select";
    var_0 = "gamemode";
    var_1 = scripts\mp\class::zombiesignorevehicleexplosions();
    var_1 = scripts\mp\class::ref_1194e(var_1, var_0);
    scripts\mp\class::loadout_updatefieldupgrades(var_1, var_0);

    if(scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
      scripts\mp\utility\perk::removeperk("specialty_tacticalinsertion");
    }

    if(!scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
      scripts\mp\utility\perk::giveperk("specialty_tacticalinsertion");
    }

    scripts\mp\equipment::giveequipment(level.infectedtactical, "secondary");
    thread scripts\mp\supers::givesuperpoints(level.stealth_enabled, undefined, 1);
  }

  if(istrue(level.ref_133f8)) {
    thread ref_13967();
    return;
  }

  thread scripts\mp\hud_message::showsplash("tac_insert_infect_placed");
}

function ref_13967() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    self.ref_133cb = 1;
    self suicide();
    waitframe();

    if(isDefined(self)) {
      self.deaths -= 1;
      self.pers["deaths"] = self.pers["deaths"] - 1;
    }
  }

  wait 1;

  if(isDefined(self)) {
    self.ref_133cb = undefined;
    thread scripts\mp\hud_message::showsplash("tac_insert_infect_placed");
    return;
  }
}

function registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[var_0] = var_3;
}

function superselectonunset() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  level.vehiclespawnlocs = [];

  foreach(var_1 in level.vehicleinfo) {
    if(var_1.refname == "atv") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var_2 = [];
        var_3 = [];
        var_2 = (46022, 1039, 56);
        GscBinSkip0(0x2e, 0, (7, 289, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var_2 = [];
        var_3 = [];
        var_2 = (17806, -20823, -110);
        GscBinSkip0(0x2e, 0, (11, 358, 0));
      }
    }

    foreach(var_2, var_3 in var_14.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == level.localeid) {
        var_12 = level.vehiclespawnlocs.size;
        level.vehiclespawnlocs[var_12] = var_3;
        level.vehiclespawnlocs[var_12].refname = var_14.refname;
      }
    }
  }

  var_13 = undefined;
  var_3 = undefined;

  if(false) {
    foreach(var_16 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var_16.origin, var_16.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_18 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var_18 = 25;
  }

  if(false) {
    for(var_4 = 0; var_4 < var_18; var_4++) {
      var_16 = level.vehiclespawnlocs[var_4];
      thread scripts\mp\utility\debug::drawline(var_16.origin + (0, 0, 1500), var_16.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_4 = 0; var_4 < var_18; var_4++) {
    var_16 = level.vehiclespawnlocs[var_4];

    if(isDefined(var_16)) {
      var_14 = level.vehicleinfo[var_16.refname];
      [[var_14.spawncallback]](var_16);
    }
  }
}

function vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, randomfloat(360), 0);
  }

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var_2, var_1);
}

function vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.showheadicon = 1;
  return var_1;
}

function ref_129fb() {
  level endon("game_ended");
  level.steam_damage_player = [];
  thread ref_13254();
  scripts\mp\flags::gameflagwait("prematch_done");
  wait level.droptime;
  level.grnd_previouscratetypes = [];

  for(;;) {
    var_0 = scripts\engine\utility::random(scripts\mp\utility\teams::getteamdata("allies", "players"));
    var_1 = 1;

    if(isDefined(var_0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var_2 = scripts\mp\gametypes\grnd::getdropzonecratetype();
      var_3 = remove_medic_class();

      if(!isDefined(var_3)) {
        return;
      }

      if(var_2 == "mega") {
        var_4 = spawnStruct();
        var_4.cratetype = undefined;
        var_4.numcrates = undefined;
        var_4.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_0.team, var_3, randomfloat(360), var_3, var_4);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var_0, var_0.team, var_2, var_3, randomfloat(360), var_3, 1);
      }

      var_5 = level.droptime;
    } else {
      var_5 = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_5);
  }
}

function remove_medic_class() {
  var_0 = level.steam_damage_player[0];
  level.steam_damage_player[level.steam_damage_player.size] = level.steam_damage_player[0];
  level.steam_damage_player[0] = undefined;
  level.steam_damage_player = scripts\engine\utility::array_removeundefined(level.steam_damage_player);
  return var_0;
}

function ref_13254() {
  switch (level.mapname) {
    case "mp_downtown_gw":
      level.steam_damage_player = [(21298, -15989, 1970), (22131, -18582, 690), (17264, -17920, 1066), (16682, -23069, 230), (21664, -23061, -108), (16208, -13686, -158), (19920, -18069, 157), (25150, -17449, -150), (27173, -14625, -200), (22696, -12784, -158), (22115, -12162, -106), (22278, -10595, 1610), (19963, -14131, 149), (20019, -11243, -194), (16711, -8999, -326), (15772, -5966, -390), (15501, -1873, -446), (19760, -1172, -449), (20464, -2047, -450), (23814, -5888, -382), (26210, -9404, -318), (30288, -8981, -358), (20781, -7208, -366), (18773, -13037, 9), (20091, -21421, -78), (23574, -14769, -134)];
      break;
    case "mp_quarry2":
      level.steam_damage_player = [(25008, 32313, 826), (29171, 32156, 659), (25021, 37011, 841), (30305, 35572, 526), (30779, 33427, 1009), (28913, 38886, 888), (25888, 40248, 1680), (27533, 43285, 1792), (31199, 37768, 722), (33534, 35968, 1103), (34872, 33255, 664), (33704, 39718, 1395), (35903, 39512, 879), (32265, 46424, 1450), (35084, 43008, 960), (38700, 43064, 1087), (36348, 44694, 481), (34805, 48469, 1317), (32313, 39712, 767)];
      break;
    case "mp_farms2":
    case "mp_farms2_gw":
      level.steam_damage_player = [(51478, -24749, -55), (50222, -21762, -335), (46165, -20091, -409), (49089, -18057, -359), (54074, -16693, -307), (52289, -14523, -335), (48361, -13952, -1), (43445, -16524, -405), (43634, -13100, -51), (47714, -14136, 141), (50498, -12784, -199), (53744, -11930, -510), (52284, -7268, -672), (49723, -7122, 438), (47540, -10295, 266), (48403, -7548, 291), (53225, -3832, -456), (49419, -4336, 141), (49419, -4336, 141), (47101, -1784, 116), (43600, -3193, 340), (42522, -6972, 30), (45959, -5516, 328), (46058, -8625, 136)];
      break;
    case "mp_port2_gw":
      level.steam_damage_player = [(40724, -13376, -58), (37115, -14577, -152), (35766, -19268, -508), (38572, -18749, -508), (42023, -19947, -500), (40116, -25824, -247), (38056, -23083, 240), (35024, -24401, -508), (36958, -26270, -112), (36264, -28611, -36), (38229, -28438, -452), (38304, -30376, -172), (33276, -26940, -116), (30526, -27712, -508), (29810, -29730, -508), (33689, -28898, -507), (36498, -33452, -508), (37219, -37142, -506), (34863, -34724, -318), (34304, -36576, -506), (31116, -35074, -508), (32797, -32582, -372)];
      break;
    case "mp_boneyard_gw":
      level.steam_damage_player = [(-28661, -17966, -177), (-30406, -15324, -159), (-26858, -14816, 3), (-26567, -8261, 17), (-23466, -14624, -12), (-24687, -11527, 238), (-24492, -10369, 148), (-25965, -11096, 27), (-29884, -12919, -43), (-30458, -10020, -136), (-28564, -9301, 248), (-29994, -6709, -208), (-28156, -5883, -119), (-30522, -3889, -247), (-28220, -3171, -255), (-25333, -4300, -242), (-28106, -1937, -255), (-30823, -2351, -248), (-29121, -11011, -61)];
      break;
    case "mp_aniyah":
      level.steam_damage_player = [(2716, -158, 708), (8215, 874, 342), (6524, 1561, 316), (5827, -860, 357), (4268, -47, 452), (2305, -1994, 386), (5172, 2587, 231), (2691, 3096, 302), (-910, 3497, 318), (-3579, -544, 320), (2591, 1659, 545), (1033, -514, 447), (-93, -2789, 169), (-1301, 924, 315), (-2843, 2779, 316)];
      break;
    default:
      level.steam_damage_player = relic_healthpacks();
      break;
  }

  level.steam_damage_player = scripts\engine\utility::array_randomize(level.steam_damage_player);
}

function relic_healthpacks() {
  var_0 = [];
  var_1 = getEntArray("grnd", "targetname");

  if(level.mapname == "mp_shipment") {
    var_2 = [];

    foreach(var_4 in var_1) {
      if(var_4.script_label == "1" && distance(var_4.origin, (-333, 1999, 119)) < 5) {
        var_2 = var_4;
        continue;
      }

      if(var_4.script_label == "2" && distance(var_4.origin, (189, 1564, 75)) < 5) {
        var_2 = var_4;
        continue;
      }

      if(var_4.script_label == "3" && distance(var_4.origin, (-751, 2416, 81)) < 5) {
        var_2 = var_4;
        continue;
      }

      if(var_4.script_label == "4" && distance(var_4.origin, (165, 2420, 79)) < 5) {
        var_2 = var_4;
        continue;
      }

      if(var_4.script_label == "5" && distance(var_4.origin, (-823, 1536, 68)) < 5) {
        var_2 = var_4;
      }
    }

    var_1 = scripts\engine\utility::array_remove_array(var_1, var_2);
  }

  if(var_1.size > 0) {
    foreach(var_4 in var_1) {
      var_0 = var_4.origin;
    }
  }

  return var_0;
}

function steam_fx_off() {
  var_0 = getdvarint("scr_infect_juggHealth", 2000);
  self.maxhealth = var_0;
  self.startinghealth = var_0;
}

function playgotinfectedsoundcount(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(var_0.team == "axis" && scripts\mp\utility\weapon::iskillstreakweapon(var_3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_3) && var_4 != "MOD_MELEE") {
    var_5 = 1;
  }

  return var_5;
}

function ref_1314d() {
  var_0 = getspawnpoint();
  var_1 = spawn("script_model", var_0.origin);
  var_1.playerspawnpos = var_0.origin;
  var_1.playerspawnangles = var_0.angles;
  var_1.notti = 0;
  var_1.issuper = 1;
  var_1.ref_133e3 = 1;
  self.setspawnpoint = var_1;
}

function ref_14124(var_0, var_1) {
  return true;
}

function ref_133f7() {
  self endon("disconnect");
  self notify("skydive_spawn_tutorial");
  self endon("skydive_spawn_tutorial");
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    if(var_1) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    if(self.pers["team"] == "allies") {
      continue;
    }

    if(var_0 < 2) {
      if(!var_0) {
        wait 5;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(77);
      wait 5;
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      var_0++;
      continue;
    }

    break;
  }
}