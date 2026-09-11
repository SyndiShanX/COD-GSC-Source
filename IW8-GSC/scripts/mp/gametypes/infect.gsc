/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\infect.gsc
***********************************************/

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var0 = getdvarint("LTSNLQNRKO") && !getdvarint("LSTLQTSSRM");

  if(var0) {
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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/INFECT");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/INFECT");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/INFECT_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/INFECT_HINT");
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
  var0 = getDvar("scr_infect_survivorStreakOverride", "");

  if(var0 != "") {
    level.ref_139bc = strtok(var0, ",");
  }

  var1 = scripts\cp_mp\utility\game_utility::getmapname();

  if(issubstr(var1, "mp_m_") && var1 != "mp_m_speed") {
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

  foreach(var1 in level.allweapons) {
    if(var1 != "none") {
      var2 = scripts\mp\utility\weapon::getweaponrootname(var1);
      var3 = [];

      if(level.ref_12052) {
        if(var1 == level.allweapons[0] || var1 == level.allweapons[4]) {
          for(var4 = 1; var4 < 6; var4++) {
            var5 = var4;

            if(var4 == 1) {
              var5 = "";
            }

            var6 = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment" + var5];

            if(var6 != "none") {
              var3 = var6;
            }
          }
        }

        if(var1 == level.allweapons[1] || var1 == level.allweapons[5]) {
          for(var4 = 1; var4 < 6; var4++) {
            var5 = var4;

            if(var4 == 1) {
              var5 = "";
            }

            var6 = game["arenaRandomLoadout"][0]["loadoutSecondaryAttachment" + var5];

            if(var6 != "none") {
              var3 = var6;
            }
          }
        }
      }

      if(level.steam_damaged) {
        game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"] = run_func_on_each_player();
      }

      var7 = "none";
      var8 = "none";
      var9 = scripts\mp\class::buildweapon(var2, var3, var7, var8);
      var10 = createheadicon(var9);
    }
  }

  thread setspecialloadouts();
}

function run_func_on_each_player() {
  var0 = game["arenaRandomLoadout"][0]["loadoutPrimary"] + "_mp";
  var1 = weaponclass(var0);
  level.ref_14543 = var1;
  var2 = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];

  switch (var1) {
    case "smg":
    case "mg":
    case "rifle":
      var3 = randomintrange(0, 3);

      if(var3 == 0) {
        var2 = "thermal";
      } else if(var3 == 0) {
        var2 = "thermal2";
      } else {
        var2 = "hybrid3";
      }

      break;
    case "sniper":
      var3 = randomintrange(0, 3);

      if(var3 == 0) {
        var2 = "thermal";
      } else if(var3 == 0) {
        var2 = "thermal2";
      } else {
        var2 = "thermalvz";
      }

      break;
    case "spread":
      var2 = "thermal";
    case "rocketlauncher":
      break;
    case "pistol":
      break;
    default:
      break;
  }

  return var2;
}

function stripweapsuffix(var0) {
  if(issubstr(var0, "mpr")) {
    var0 = scripts\mp\utility\script::strip_suffix(var0, "_mpr");
  } else if(issubstr(var0, "mpl")) {
    var0 = scripts\mp\utility\script::strip_suffix(var0, "_mpl");
  } else {
    var0 = scripts\mp\utility\script::strip_suffix(var0, "_mp");
  }

  return var0;
}

function player_give_intel_3_ks(var0, var1) {
  if(istrue(var1)) {
    var2 = scripts\engine\utility::ter_op(var0, level.steam_dmg_trigger_think, level.ref_139bd);
  } else {
    var2 = scripts\engine\utility::ter_op(var1, level.infectedsuper, level.survivorsuper);
  }

  switch (var2) {
    case "super_weapon_drop":
    case "super_emp_drone":
    case "super_recon_drone":
      var2 = "super_ammo_drop";
      break;
    case "super_tac_insert":
      if(var1 && level.infectedtactical == "equip_tac_insert") {
        level.infectedtactical = "none";
      } else if(level.survivortactical == "equip_tac_insert") {
        level.survivortactical = "none";
      }

      break;
    case "super_trophy":
      if(var1 && level.infectedtactical == "equip_trophy") {
        level.infectedtactical = "none";
      } else if(level.survivortactical == "equip_trophy") {
        level.survivortactical = "none";
      }

      break;
  }

  return var2;
}

function onplayerconnect(var0) {
  var0.gamemodefirstspawn = 1;
  var0.gamemodejoinedatstart = 1;
  var0.infectedrejoined = 0;
  var0.waitedtospawn = 0;

  if(!scripts\mp\flags::gameflag("prematch_done") || level.infect_countdowninprogress) {
    var0.waitedtospawn = 1;
  }

  var0.pers["class"] = "gamemode";
  var0.pers["lastClass"] = "";
  var0.class = var0.pers["class"];
  var0.lastclass = var0.pers["lastClass"];
  var0 loadweaponsforplayer(level.allweapons, 1);

  if(scripts\mp\flags::gameflag("prematch_done")) {
    var0.gamemodejoinedatstart = 0;

    if(isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected) {
      var0.survivalstarttime = gettime();
    }
  }

  if(isDefined(level.infect_players[var0.name])) {
    var0.infectedrejoined = 1;
  }

  if(isDefined(var0.isinitialinfected)) {
    var0.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  } else if(var0.infectedrejoined) {
    var0.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  } else {
    var0.pers["gamemodeLoadout"] = level.infect_loadouts["allies"];
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

    foreach(var1 in level.players) {
      if(var1.team == "allies") {
        var1 thread scripts\mp\utility\points::giveunifiedpoints("survivor", undefined, level.survivorscorepertick);
      }
    }
  }
}

function initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    var0 = "mp_gw_spawn_allies_start";
    var1 = "mp_gw_spawn_axis_start";
    level.gamemodestartspawnpointnames["allies"] = var0;
    level.gamemodestartspawnpointnames["axis"] = var1;
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
    var2 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_allies_start");
    var3 = scripts\mp\spawnlogic::getspawnpointarray("mp_gw_spawn_axis_start");
    scripts\mp\spawnlogic::registerspawnset("start_attackers", var2);
    scripts\mp\spawnlogic::registerspawnset("start_defenders", var3);
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var5 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", var4);
    scripts\mp\spawnlogic::registerspawnset("fallback", var5);
    return;
  }

  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var4 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var5 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var4);
  scripts\mp\spawnlogic::registerspawnset("fallback", var5);
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
    var0 = "allies";

    if(self.infectedrejoined) {
      var0 = "axis";
    }

    scripts\mp\menus::addtoteam(var0, 1);
    thread monitordisconnect();
  }

  if(level.ingraceperiod) {
    var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var2 = scripts\mp\spawnlogic::getspawnpoint_random(var1);
  } else {
    var2 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["team"], "normal", "fallback");
  }

  return var2;
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

      foreach(var1 in level.players) {
        if(isDefined(var1.infect_isbeingchosen)) {
          var1.infect_isbeingchosen = undefined;
        }
      }
    }

    foreach(var1 in level.players) {
      if(isDefined(var1.isinitialinfected)) {
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
  var0 = self getweaponslistprimaries();
  var1 = self getcurrentprimaryweapon();

  if(var0.size > 1) {
    if(scripts\mp\utility\weapon::isknifeonly(var1)) {
      foreach(var3 in var0) {
        if(var3 != var1) {
          self setspawnweapon(var3);
        }
      }

      return;
    }

    return;
  }
}

function setdefaultammoclip(var0) {
  var1 = 1;

  if(isDefined(self.isinitialinfected)) {
    if(scripts\mp\utility\game::isusingdefaultclass(var0, 1)) {
      var1 = 0;
    }
  } else if(scripts\mp\utility\game::isusingdefaultclass(var0, 0)) {
    var1 = 0;
  }

  return var1;
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

    var0 = 1.05;

    if(!level.unset_relic_laststandmelee) {
      var1 = int(floor(level.infect_teamscores["axis"] / 3));
      var1 *= 0.01;
      var0 = max(1, var0 - var1);
    }

    self.overrideweaponspeed_speedscale = var0;
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
    var2 = scripts\mp\utility\weapon::getweaponrootname(self.loadoutprimary);

    if(var2 != "iw8_knife") {
      var3 = getcompleteweaponname("iw8_knifestab_mp");
      self giveweapon(var3);
      self assignweaponmeleeslot(var3);

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

function managefists(var0, var1) {
  if(var0 != "iw8_fists" || var1 != "iw8_fists") {
    if(var0 == "none" && var1 == "none") {
      return;
    }

    scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("iw8_fists_mp");
    return;
  }
}

function giveextrainfectedperks() {
  if(self.pers["team"] == "allies") {
    var0 = ["specialty_fastreload"];
  } else if(istrue(self.isinitialinfected)) {
    var0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage", "specialty_bulletaccuracy", "specialty_quickswap"];
  } else {
    var0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage"];
  }

  foreach(var2 in var0) {
    scripts\mp\utility\perk::giveperk(var2);
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
  var0 = 15;

  while(var0 > 0 && !level.gameended) {
    foreach(var2 in level.players) {
      var2 setclientomnvar("ui_match_start_countdown", var0);
    }

    var0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  setomnvar("ui_match_start_text", "match_starting_in");

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_match_start_countdown", 0);
  }

  level.infect_countdowninprogress = 0;
  var6 = [];

  foreach(var8 in level.players) {
    if(scripts\mp\utility\game::matchmakinggame() && level.players.size > 1 && var8 ishost()) {
      continue;
    }

    if(var8.team == "spectator") {
      continue;
    }

    if(!var8.hasspawned) {
      continue;
    }

    var6 = var8;
  }

  level.player_damage_blood = 0;

  if(var6.size <= level.numinitialinfected && var6.size > 1) {
    level.numinitialinfected = var6.size - 1;
  }

  var10 = [];

  for(var11 = 0; var11 < level.numinitialinfected; var11++) {
    var12 = var6[randomint(var6.size)];
    var10 = var12;
    var6 = scripts\engine\utility::array_remove(var6, var12);
  }

  foreach(var12 in var10) {
    setfirstinfected(var12, 1);
  }

  level.infect_allowsuicide = 1;

  foreach(var8 in level.players) {
    if(istrue(var8.isinitialinfected)) {
      var8 thread scripts\mp\hud_message::showsplash("first_infected");
      var8 scripts\mp\utility\dialog::leaderdialogonplayer("infected_first");
      continue;
    }

    var8 thread scripts\mp\hud_message::showsplash("first_survivor");
    var8.survivalstarttime = gettime();
  }
}

function setfirstinfected(var0) {
  self endon("death_or_disconnect");

  if(var0) {
    self.infect_isbeingchosen = 1;
  }

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote() || isDefined(self.ref_1425d)) {
    waitframe();
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  var1 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var1)) {
    var2 = spawnStruct();
    var2.allowairexit = 1;
    var2.onprematchfadedone2 = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var1, undefined, self, var2, 1);

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

  if(var0) {
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

  if(var0) {
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

function setinitialtonormalinfected(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self.isinitialinfected = undefined;
  self.changingtoregularinfected = 1;

  if(isDefined(var0)) {
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

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(level.gameended) {
    return;
  }

  var10 = 0;
  var11 = 0;
  thread shouldplayhalfwayvo();

  if(self.team == "axis") {}

  if(self.team == "allies" && isDefined(var1)) {
    self.operatorcustomization = undefined;

    if(isPlayer(var1) && var1 != self) {
      var10 = 1;
    } else if(level.infect_allowsuicide && (var1 == self || !isPlayer(var1))) {
      var10 = 1;
      var11 = 1;
    }
  }

  if(self.team == "allies" && istrue(level.nukeincoming)) {
    if(isDefined(level.ref_11f14) && self == level.ref_11f14) {
      var10 = 0;
      var11 = 0;
    }
  }

  if(isPlayer(var1) && var1.team == "allies" && var1 != self) {
    var1 scripts\mp\utility\stats::incpersstat("killsAsSurvivor", 1);
    var1 scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", var1.pers["killsAsSurvivor"]);
  } else if(isPlayer(var1) && var1.team == "axis" && var1 != self) {
    var1 scripts\mp\utility\stats::incpersstat("killsAsInfected", 1);
    var1 scripts\mp\persistence::statsetchild("round", "killsAsInfected", var1.pers["killsAsInfected"]);

    if(isPlayer(var1)) {
      var1 scripts\mp\utility\stats::setextrascore1(var1.pers["killsAsInfected"]);
    }
  }

  if(var10) {
    thread delayedprocesskill(var1, var11);

    if(var11) {
      foreach(var13 in level.players) {
        if(isDefined(var13.isinitialinfected)) {
          thread setinitialtonormalinfected();
        }
      }
    } else if(isDefined(var1.isinitialinfected)) {
      foreach(var13 in level.players) {
        if(isDefined(var13.isinitialinfected)) {
          thread setinitialtonormalinfected(var13);
        }
      }
    } else if(level.infectstreakbonus > 0) {
      if(!isDefined(var1.infectedkillsthislife)) {
        var1.infectedkillsthislife = 1;
      } else {
        var1.infectedkillsthislife++;
      }

      var1 thread scripts\mp\utility\points::giveunifiedpoints("infected_survivor", undefined, level.infectstreakbonus * var1.infectedkillsthislife);
    } else {
      var1 thread scripts\mp\utility\points::giveunifiedpoints("infected_survivor");
    }

    if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") != 0) {
      var17 = 1;

      if(scripts\mp\utility\game::matchmakinggame()) {
        level.packclientmatchdata++;
        var17 = level.packclientmatchdata <= level.packedbits;
      }

      if(var17) {
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

function delayedprocesskill(var0, var1) {
  self.ref_11d9e = 1;

  if(level.unset_relic_laststandmelee && level.mapname != "mp_aniyah") {
    ref_1314d();
  }

  wait 0.15;
  self.teamchangedthisframe = 1;
  scripts\mp\menus::addtoteam("axis");

  if(!istrue(self.ref_13968)) {
    var2 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
    var2 -= 240;
    self.pers["afkResetTime"] = var2;
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

    if(!var1) {
      thread scripts\mp\hud_util::teamplayercardsplash("callout_infected", var0, "axis");

      if(!isDefined(level.survivorscoreevent)) {
        var3 = getdvarint("scr_infect_survivorinitialscore", 50);

        if(var3 > 0) {
          level.survivorscoreevent = var3;
        } else {
          level.survivorscoreevent = scripts\mp\rank::getscoreinfovalue("survivor");
        }
      } else {
        level.survivorscoreevent += level.survivoralivescore;
      }

      foreach(var5 in level.players) {
        if(var5.team == "allies" && var5 != self && distance(var5.infect_spawnpos, var5.origin) > 32) {
          var5 thread scripts\mp\utility\points::giveunifiedpoints("survivor", undefined, level.survivorscoreevent);
        }

        if(var5.team == "axis" && var5 != var0 && var5 != self) {
          var5 thread scripts\mp\utility\points::giveunifiedpoints("assist", undefined, level.stealth_broken_music);
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

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  if(istrue(level.matchmakingmatch) && isDefined(var1) && isDefined(var0)) {
    var6 = var1 getfireteammembers();

    if(isDefined(var6) && var6.size > 0) {
      foreach(var8 in var6) {
        if(isDefined(var8) && var0 == var8) {
          var1 scripts\mp\killstreaks\killstreaks::givestreakpoints("kill", -1, 0);
          var1.nukepoints = scripts\engine\utility::ter_op(var1.nukepoints > 0, var1.nukepoints - 1, 0);
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

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    if(var1.team == "allies") {
      var1 scripts\mp\utility\dialog::leaderdialogonplayer("infected_lastalive");
      var1 thread scripts\mp\rank::scoreeventpopup("final_survivor");
      var1 scripts\mp\utility\stats::incpersstat("lastSurvivor", 1);

      if(scripts\mp\utility\game::matchmakinggame()) {
        if(!var1 scripts\mp\utility\killstreak::isjuggernaut()) {
          var1.maxhealth = 200;
          var1 notify("force_regeneration");
        }
      }

      if(!level.infect_awardedfinalsurvivor) {
        if(var1.gamemodejoinedatstart && isDefined(var1.infect_spawnpos) && distance(var1.infect_spawnpos, var1.origin) > 32) {
          var1 thread scripts\mp\utility\points::giveunifiedpoints("final_survivor");
        }

        level.infect_awardedfinalsurvivor = 1;
      }

      thread scripts\mp\hud_util::teamplayercardsplash("callout_final_survivor", var1);

      if(level.steam_damaged) {} else {
        thread finalsurvivoruav(level);
      }

      break;
    }
  }
}

function finalsurvivoruav(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("eliminated");
  level endon("infect_lateJoiner");
  thread enduavonlatejoiner(level);
  var1 = getuavstrengthlevelneutral();

  if(level.unset_relic_laststandmelee && level.mapname != "mp_aniyah") {
    var1 = 5;
  }

  var2 = 1;
  var3 = 0;
  level.radarmode["axis"] = "normal_radar";

  foreach(var5 in level.players) {
    if(var5.team == "axis") {
      var5.radarmode = "normal_radar";
    }
  }

  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var1 + 1);

  for(;;) {
    var7 = var0.origin;
    wait 4;

    if(var3) {
      setteamradar("axis", 0);
      var3 = 0;
    }

    wait 6;

    if(distance(var7, var0.origin) < 200) {
      setteamradar("axis", 1);
      var3 = 1;

      foreach(var5 in level.players) {
        var5 playlocalsound("recondrone_tag");
      }
    }

    if(var2) {
      var2 = 0;
      var1 = getuavstrengthlevelneutral();
      scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var1 + 1);
    }
  }
}

function ref_119d8() {
  scripts\mp\flags::gameflagwait("prematch_done");

  while(level.infect_teamscores["allies"] > level.steam_point_think) {
    foreach(var1 in level.players) {
      if(var1.team == "axis") {
        triggeroneoffradarsweep(var1);
      }
    }

    wait getdvarint("scr_infect_longWaitUAV", 60);
  }
}

function enduavonlatejoiner(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("eliminated");

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

  foreach(var1 in level.players) {
    if(var1.team == "axis") {
      var1.radarmode = "normal_radar";
    }
  }

  var3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("axis", var3 + 1);
  setteamradar("axis", 1);
}

function monitordisconnect() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var0 = self.team;

  if(!isDefined(var0) && isDefined(self.bot_team)) {
    var0 = self.bot_team;
  }

  self waittill("disconnect");
  updateteamscores();

  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"]) {
      if(level.unset_relic_laststandmelee) {
        if(var0 == "allies" && level.infect_teamscores["allies"] == level.steam_point_think) {
          thread ref_13861();
        }
      }

      if(var0 == "allies" && level.infect_teamscores["allies"] == level.play_player_approach) {
        onfinalsurvivor();
      } else if(var0 == "axis" && level.infect_teamscores["axis"] == 1) {
        foreach(var2 in level.players) {
          if(var2 != self && var2.team == "axis") {
            setfirstinfected(var2, 0);
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

    foreach(var5 in level.players) {
      var5 setclientomnvar("ui_match_start_countdown", 0);
    }
  }

  self.isinitialinfected = undefined;
}

function ondeadevent(var0) {}

function ontimelimit() {
  level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

function onsurvivorseliminated() {
  level thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["survivors_eliminated"]);
}

function getteamsize(var0) {
  var1 = 0;

  foreach(var3 in level.players) {
    if(var3.sessionstate == "spectator" && !var3.spectatekillcam && !istrue(var3.inspawncamera)) {
      continue;
    }

    if(var3.team == var0) {
      var1++;
    }
  }

  return var1;
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
  var0 = 0;
  var1 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.survivorprimaryweapon);
  var0 = scripts\mp\class::ref_139e7(level.survivorprimaryweapon, var1);
  var2 = 0;
  var3 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.survivorsecondaryweapon);
  var2 = scripts\mp\class::ref_139e7(level.survivorsecondaryweapon, var3);

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
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = var0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = var2;
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
    level.infect_loadouts["allies"]["loadoutPrimaryVariantID"] = var0;
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryVariantID"] = var2;
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

  var4 = 0;
  var5 = 0;

  if(level.survivorprimaryweapon == level.initialprimaryweapon) {
    var4 = var0;
  } else {
    var6 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.initialprimaryweapon);
    var4 = scripts\mp\class::ref_139e7(level.initialprimaryweapon, var6);
  }

  if(level.survivorsecondaryweapon == level.initialsecondaryweapon) {
    var5 = var2;
  } else {
    var7 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.initialsecondaryweapon);
    var5 = scripts\mp\class::ref_139e7(level.initialsecondaryweapon, var7);
  }

  var8 = [];

  if(level.unset_relic_laststandmelee) {
    GscBinSkip0(0x2e, var8.size, "specialty_restock");
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
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = var4;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = var5;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = var8;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;
  } else {
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = level.attachmentinitialprimary;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryVariantID"] = var4;
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryVariantID"] = var5;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutEquipmentSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = var8;
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade1"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;

    if(level.enableinfectedtracker) {}

    if(level.enableping) {}
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    var9 = 0;
  } else {
    var9 = 0;
    var10 = scripts\mp\gametypes\gun::remappedhpzoneorder(level.infectedprimaryweapon);
    var9 = scripts\mp\class::ref_139e7(level.infectedprimaryweapon, var10);
  }

  var11 = [];

  if(level.unset_relic_laststandmelee) {
    GscBinSkip0(0x2e, var11.size, "specialty_restock");
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
  level.infect_loadouts["axis"]["loadoutPrimaryVariantID"] = var9;
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
  level.infect_loadouts["axis"]["loadoutPerks"] = var11;
  level.infect_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.infect_loadouts["axis"]["loadoutFieldUpgrade1"] = level.infectedsuper;
  level.infect_loadouts["axis"]["loadoutFieldUpgrade2"] = level.steam_dmg_trigger_think;

  if(level.enableinfectedtracker) {}

  if(level.enableping) {
    return;
  }
}

function addsurvivorattachmentsprimary(var0) {
  level.attachmentsurvivorprimary = "none";
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  if(var1 == "weapon_shotgun") {
    level.attachmentsurvivorprimary = "barrelrange";
    return;
  }

  if(var1 == "weapon_assault" || var1 == "weapon_tactical" || var1 == "weapon_smg" || var1 == "weapon_lmg" || var1 == "weapon_pistol" || var0 == "iw7_m1c") {
    level.attachmentsurvivorprimary = "highcal";
    return;
  }
}

function addinitialattachmentsprimary(var0) {
  level.attachmentinitialprimary = "none";
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  if(var1 == "weapon_shotgun") {
    level.attachmentinitialprimary = "barrelrange";
    return;
  }

  if(var1 == "weapon_assault" || var1 == "weapon_tactical" || var1 == "weapon_smg" || var1 == "weapon_lmg" || var1 == "weapon_pistol" || var0 == "iw7_m1c") {
    level.attachmentinitialprimary = "highcal";
    return;
  }
}

function addsurvivorattachmentssecondary(var0) {
  level.attachmentsurvivorsecondary = "none";
  level.attachmentsurvivorsecondarytwo = "none";
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  if(var1 == "weapon_pistol") {
    level.attachmentsurvivorsecondary = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var0 == "iw7_g18c") {
      level.attachmentsurvivorsecondary = "akimbo";
      level.attachmentsurvivorsecondarytwo = "highcal";
      return;
    }

    return;
  }
}

function addinitialattachmentssecondary(var0) {
  level.attachmentinitialsecondary = "none";
  level.attachmentinitialsecondarytwo = "none";
  var1 = scripts\mp\utility\weapon::getweapongroup(var0);

  if(var1 == "weapon_pistol") {
    level.attachmentinitialsecondary = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var0 == "iw7_g18c") {
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

function initsurvivaltime(var0) {
  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var0) && var0) {
    self notify("infected");
    return;
  }
}

function setsurvivaltime(var0) {
  if(!isDefined(self.survivalstarttime)) {
    self.survivalstarttime = self.spawntime;
  }

  var1 = int((gettime() - self.survivalstarttime) / 1000);

  if(var1 > 999) {
    var1 = 999;
  }

  scripts\mp\utility\stats::setextrascore0(var1);

  if(isDefined(var0) && var0) {
    self notify("infected");
    return;
  }
}

function shouldplayhalfwayvo() {
  if(!level.didhalfscorevoboost && getteamscore("axis") >= int(level.players.size - level.players.size / 2)) {
    var0 = "axis";
    scripts\mp\utility\dialog::leaderdialog("halfway_friendly_score", var0, "status");
    var1 = scripts\mp\utility\teams::getenemyteams(var0);

    foreach(var3 in var1) {
      scripts\mp\utility\dialog::leaderdialog("halfway_enemy_score", var3, "status");
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
  var0 = 0;
  var1 = 0;

  for(;;) {
    if(self isnightvisionon()) {
      var0 += level.framedurationseconds;

      if(var0 >= 9 && !var1) {
        scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/LOW_BATTERY");
        var1 = 1;
      }

      if(var0 >= 10) {
        self nightvisionviewoff();
        self setclientomnvar("ui_ctf_flag_carrier", 1);
        scripts\common\utility::brjugg_oncrateuse(0);
        ref_12a93();
        scripts\common\utility::brjugg_oncrateuse(1);
        var1 = 0;
        self setclientomnvar("ui_ctf_flag_carrier", 0);
        var0 = 0;
      }
    }

    wait level.framedurationseconds;
  }
}

function ref_12a93() {
  var0 = 0;

  while(var0 < 5) {
    var0 += level.framedurationseconds;

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
    var0 = "gamemode";
    var1 = scripts\mp\class::zombiesignorevehicleexplosions();
    var1 = scripts\mp\class::ref_1194e(var1, var0);
    scripts\mp\class::loadout_updatefieldupgrades(var1, var0);

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

function registervehicletype(var0, var1, var2) {
  var3 = spawnStruct();
  var3.refname = var0;
  var3.spawncallback = var2;
  var3.vehiclespawns = [[var1]]();

  if(!isDefined(level.vehicleinfo)) {
    level.vehicleinfo = [];
  }

  level.vehicleinfo[var0] = var3;
}

function superselectonunset() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("atv", &scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, &vehiclespawn_atv);
  level.vehiclespawnlocs = [];

  foreach(var1 in level.vehicleinfo) {
    if(var1.refname == "atv") {
      if(level.mapname == "mp_farms2_gw" && level.localeid == "locale_9") {
        var2 = [];
        var3 = [];
        var2 = (46022, 1039, 56);
        GscBinSkip0(0x2e, 0, (7, 289, 0));
      }

      if(level.mapname == "mp_downtown_gw" && level.localeid == "locale_6") {
        var2 = [];
        var3 = [];
        var2 = (17806, -20823, -110);
        GscBinSkip0(0x2e, 0, (11, 358, 0));
      }
    }

    foreach(var2, var3 in var14.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var3.script_noteworthy) && var3.script_noteworthy == level.localeid) {
        var12 = level.vehiclespawnlocs.size;
        level.vehiclespawnlocs[var12] = var3;
        level.vehiclespawnlocs[var12].refname = var14.refname;
      }
    }
  }

  var13 = undefined;
  var3 = undefined;

  if(false) {
    foreach(var16 in level.vehiclespawnlocs) {
      thread scripts\mp\utility\debug::drawline(var16.origin, var16.origin + (0, 0, 1500), 1000, (1, 0, 0));
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var18 = level.ref_11f41;

  if(!isDefined(level.ref_11f41)) {
    var18 = 25;
  }

  if(false) {
    for(var4 = 0; var4 < var18; var4++) {
      var16 = level.vehiclespawnlocs[var4];
      thread scripts\mp\utility\debug::drawline(var16.origin + (0, 0, 1500), var16.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var4 = 0; var4 < var18; var4++) {
    var16 = level.vehiclespawnlocs[var4];

    if(isDefined(var16)) {
      var14 = level.vehicleinfo[var16.refname];
      [[var14.spawncallback]](var16);
    }
  }
}

function vehiclespawn_atv(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, randomfloat(360), 0);
  }

  var2 = vehiclespawn_getspawndata(var0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("atv", var2, var1);
}

function vehiclespawn_getspawndata(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.showheadicon = 1;
  return var1;
}

function ref_129fb() {
  level endon("game_ended");
  level.steam_damage_player = [];
  thread ref_13254();
  scripts\mp\flags::gameflagwait("prematch_done");
  wait level.droptime;
  level.grnd_previouscratetypes = [];

  for(;;) {
    var0 = scripts\engine\utility::random(scripts\mp\utility\teams::getteamdata("allies", "players"));
    var1 = 1;

    if(isDefined(var0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var2 = scripts\mp\gametypes\grnd::getdropzonecratetype();
      var3 = remove_medic_class();

      if(!isDefined(var3)) {
        return;
      }

      if(var2 == "mega") {
        var4 = spawnStruct();
        var4.cratetype = undefined;
        var4.numcrates = undefined;
        var4.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var0, var0.team, var3, randomfloat(360), var3, var4);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var0, var0.team, var2, var3, randomfloat(360), var3, 1);
      }

      var5 = level.droptime;
    } else {
      var5 = 0.5;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var5);
  }
}

function remove_medic_class() {
  var0 = level.steam_damage_player[0];
  level.steam_damage_player[level.steam_damage_player.size] = level.steam_damage_player[0];
  level.steam_damage_player[0] = undefined;
  level.steam_damage_player = scripts\engine\utility::array_removeundefined(level.steam_damage_player);
  return var0;
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
  var0 = [];
  var1 = getEntArray("grnd", "targetname");

  if(level.mapname == "mp_shipment") {
    var2 = [];

    foreach(var4 in var1) {
      if(var4.script_label == "1" && distance(var4.origin, (-333, 1999, 119)) < 5) {
        var2 = var4;
        continue;
      }

      if(var4.script_label == "2" && distance(var4.origin, (189, 1564, 75)) < 5) {
        var2 = var4;
        continue;
      }

      if(var4.script_label == "3" && distance(var4.origin, (-751, 2416, 81)) < 5) {
        var2 = var4;
        continue;
      }

      if(var4.script_label == "4" && distance(var4.origin, (165, 2420, 79)) < 5) {
        var2 = var4;
        continue;
      }

      if(var4.script_label == "5" && distance(var4.origin, (-823, 1536, 68)) < 5) {
        var2 = var4;
      }
    }

    var1 = scripts\engine\utility::array_remove_array(var1, var2);
  }

  if(var1.size > 0) {
    foreach(var4 in var1) {
      var0 = var4.origin;
    }
  }

  return var0;
}

function steam_fx_off() {
  var0 = getdvarint("scr_infect_juggHealth", 2000);
  self.maxhealth = var0;
  self.startinghealth = var0;
}

function playgotinfectedsoundcount(var0, var1, var2, var3, var4) {
  var5 = 0;

  if(var0.team == "axis" && scripts\mp\utility\weapon::iskillstreakweapon(var3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var3) && var4 != "MOD_MELEE") {
    var5 = 1;
  }

  return var5;
}

function ref_1314d() {
  var0 = getspawnpoint();
  var1 = spawn("script_model", var0.origin);
  var1.playerspawnpos = var0.origin;
  var1.playerspawnangles = var0.angles;
  var1.notti = 0;
  var1.issuper = 1;
  var1.ref_133e3 = 1;
  self.setspawnpoint = var1;
}

function ref_14124(var0, var1) {
  return true;
}

function ref_133f7() {
  self endon("disconnect");
  self notify("skydive_spawn_tutorial");
  self endon("skydive_spawn_tutorial");
  var0 = 0;
  var1 = 1;

  for(;;) {
    if(var1) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    if(self.pers["team"] == "allies") {
      continue;
    }

    if(var0 < 2) {
      if(!var0) {
        wait 5;
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(77);
      wait 5;
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      var0++;
      continue;
    }

    break;
  }
}