/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\infect.gsc
*********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registertimelimitdvar(level.gametype, 10);
    scripts\mp\utility::setoverridewatchdvar("scorelimit", 0);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.numinitialinfected = 1;
    level.matchrules_damagemultiplier = 0;
    level.survivorprimaryweapon = "iw7_spasc";
  }

  updategametypedvars();
  level thread setspecialloadouts();
  level.ignorekdrstats = 1;
  level.teambased = 1;
  level.supportintel = 0;
  level.disableforfeit = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  if(level.matchrules_damagemultiplier) {
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  game["dialog"]["gametype"] = "infected";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "survive";
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_infect_numInitialInfected", getmatchrulesdata("infectData", "numInitialInfected"));
  setdynamicdvar("scr_infect_weaponSurvivorPrimary", getmatchrulesdata("infectData", "weaponSurvivorPrimary"));
  setdynamicdvar("scr_infect_weaponSurvivorSecondary", getmatchrulesdata("infectData", "weaponSurvivorSecondary"));
  setdynamicdvar("scr_infect_lethalSurvivor", getmatchrulesdata("infectData", "lethalSurvivor"));
  setdynamicdvar("scr_infect_tacticalSurvivor", getmatchrulesdata("infectData", "tacticalSurvivor"));
  setdynamicdvar("scr_infect_superSurvivor", getmatchrulesdata("infectData", "superSurvivor"));
  setdynamicdvar("scr_infect_weaponInfectPrimary", getmatchrulesdata("infectData", "weaponInfectPrimary"));
  setdynamicdvar("scr_infect_weaponInfectSecondary", getmatchrulesdata("infectData", "weaponInfectSecondary"));
  setdynamicdvar("scr_infect_lethalInfect", getmatchrulesdata("infectData", "lethalInfect"));
  setdynamicdvar("scr_infect_tacticalInfect", getmatchrulesdata("infectData", "tacticalInfect"));
  setdynamicdvar("scr_infect_weaponInitialPrimary", getmatchrulesdata("infectData", "weaponInitialPrimary"));
  setdynamicdvar("scr_infect_weaponInitialSecondary", getmatchrulesdata("infectData", "weaponInitialSecondary"));
  setdynamicdvar("scr_infect_superInfect", getmatchrulesdata("infectData", "superInfect"));
  setdynamicdvar("scr_infect_infectExtraTimePerKill", getmatchrulesdata("infectData", "infectExtraTimePerKill"));
  setdynamicdvar("scr_infect_survivorAliveScore", getmatchrulesdata("infectData", "survivorAliveScore"));
  setdynamicdvar("scr_infect_survivorScoreTime", getmatchrulesdata("infectData", "survivorScoreTime"));
  setdynamicdvar("scr_infect_survivorScorePerTick", getmatchrulesdata("infectData", "survivorScorePerTick"));
  setdynamicdvar("scr_infect_infectStreakBonus", getmatchrulesdata("infectData", "infectStreakBonus"));
  setdynamicdvar("scr_infect_enableInfectedTracker", getmatchrulesdata("infectData", "enableInfectedTracker"));
  setdynamicdvar("scr_infect_enablePing", getmatchrulesdata("infectData", "enablePing"));
  setdynamicdvar("scr_team_fftype", 0);
  setdynamicdvar("scr_infect_promode", 0);
}

onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_INFECT");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_INFECT");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_INFECT");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_INFECT");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_INFECT_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_INFECT_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_INFECT_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_INFECT_HINT");
  initspawns();
  var_0[0] = level.gametype;
  scripts\mp\gameobjects::main(var_0);
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level.infect_allowsuicide = 0;
  level.infect_skipsounds = 0;
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_awardedfinalsurvivor = 0;
  level.infect_countdowninprogress = 0;
  level.infect_teamscores["axis"] = 0;
  level.infect_teamscores["allies"] = 0;
  level.infect_players = [];
  level thread onplayerconnect();
}

updategametypedvars() {
  scripts\mp\gametypes\common::updategametypedvars();
  level.numinitialinfected = scripts\mp\utility::dvarintvalue("numInitialInfected", 1, 1, 6);
  level.survivorprimaryweapon = getdvar("scr_infect_weaponSurvivorPrimary", "iw7_spasc");
  level.survivorsecondaryweapon = getdvar("scr_infect_weaponSurvivorSecondary", "iw7_g18");
  level.survivorlethal = getdvar("scr_infect_lethalSurvivor", "power_tripMine");
  level.survivortactical = getdvar("scr_infect_tacticalSurvivor", "power_concussionGrenade");
  level.survivorsuper = getdvar("scr_infect_superSurvivor", "super_phaseshift");
  level.infectedprimaryweapon = getdvar("scr_infect_weaponInfectPrimary", "iw7_knife");
  level.infectedsecondaryweapon = getdvar("scr_infect_weaponInfectSecondary", "iw7_fists");
  level.initialprimaryweapon = getdvar("scr_infect_weaponInitialPrimary", "iw7_spasc");
  level.initialsecondaryweapon = getdvar("scr_infect_weaponInitialSecondary", "iw7_g18");
  level.infectedlethal = getdvar("scr_infect_lethalInfect", "power_throwingKnife");
  level.infectedtactical = getdvar("scr_infect_tacticalInfect", "power_tacInsert");
  level.infectedsuper = getdvar("scr_infect_superInfect", "super_reaper");
  level.infectextratimeperkill = scripts\mp\utility::dvarfloatvalue("infectExtraTimePerKill", 30, 0, 60);
  level.survivoralivescore = scripts\mp\utility::dvarintvalue("survivorAliveScore", 25, 0, 100);
  level.survivorscoretime = scripts\mp\utility::dvarfloatvalue("survivorScoreTime", 30, 0, 60);
  level.survivorscorepertick = scripts\mp\utility::dvarintvalue("survivorScorePerTick", 50, 0, 100);
  level.infectstreakbonus = scripts\mp\utility::dvarintvalue("infectStreakBonus", 50, 0, 100);
  level.enableinfectedtracker = scripts\mp\utility::dvarintvalue("enableInfectedTracker", 0, 0, 1);
  level.enableping = scripts\mp\utility::dvarintvalue("enablePing", 0, 0, 1);
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
}

stripweapsuffix(var_0) {
  if(issubstr(var_0, "mpr")) {
    var_0 = scripts\mp\utility::strip_suffix(var_0, "_mpr");
  } else if(issubstr(var_0, "mpl")) {
    var_0 = scripts\mp\utility::strip_suffix(var_0, "_mpl");
  } else {
    var_0 = scripts\mp\utility::strip_suffix(var_0, "_mp");
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.gamemodefirstspawn = 1;
    var_0.gamemodejoinedatstart = 1;
    var_0.infectedrejoined = 0;
    var_0.waitedtospawn = 0;
    if(!scripts\mp\utility::gameflag("prematch_done") || level.infect_countdowninprogress) {
      var_0.waitedtospawn = 1;
    }

    var_0.pers["class"] = "gamemode";
    var_0.pers["lastClass"] = "";
    var_0.class = var_0.pers["class"];
    var_0.lastclass = var_0.pers["lastClass"];
    var_0 loadweaponsforplayer(level.allweapons);
    if(scripts\mp\utility::gameflag("prematch_done")) {
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
      var_0 setrandomrigifscout();
    }

    var_0 thread monitorsurvivaltime();
  }
}

givesurvivortimescore() {
  level endon("game_ended");
  for(;;) {
    wait(level.survivorscoretime);
    foreach(var_1 in level.players) {
      if(var_1.team == "allies") {
        var_1 thread scripts\mp\utility::giveunifiedpoints("survivor", undefined, level.survivorscorepertick);
      }
    }
  }
}

initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

alwaysgamemodeclass() {
  return "gamemode";
}

getspawnpoint() {
  if(isplayer(self) && self.gamemodefirstspawn) {
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
    var_1 = scripts\mp\spawnlogic::getteamspawnpoints(self.pers["team"]);
    var_3 = scripts\mp\spawnlogic::getteamfallbackspawnpoints(self.pers["team"]);
    var_2 = scripts\mp\spawnscoring::getspawnpoint(var_1, var_3);
  }

  return var_2;
}

onspawnplayer() {
  self.teamchangedthisframe = undefined;
  self.infect_spawnpos = self.origin;
  self.infectedkillsthislife = 0;
  updateteamscores();
  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    level thread choosefirstinfected();
  }

  if(!scripts\mp\utility::gameflag("prematch_done") || level.infect_countdowninprogress) {
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
        var_1 thread setinitialtonormalinfected();
      }
    }

    if(level.infect_teamscores["axis"] == 1) {
      self.isinitialinfected = 1;
    }

    initsurvivaltime(1);
  }

  thread onspawnfinished();
  level notify("spawned_player");
}

spawnwithplayersecondary() {
  var_0 = self getweaponslistprimaries();
  var_1 = self getcurrentprimaryweapon();
  if(var_0.size > 1) {
    if(scripts\mp\weapons::isknifeonly(var_1)) {
      foreach(var_3 in var_0) {
        if(var_3 != var_1) {
          self setspawnweapon(var_3);
        }
      }
    }
  }
}

setdefaultammoclip(var_0) {
  var_1 = 1;
  if(isDefined(self.isinitialinfected)) {
    if(scripts\mp\utility::isusingdefaultclass(var_0, 1)) {
      var_1 = 0;
    }
  } else if(scripts\mp\utility::isusingdefaultclass(var_0, 0)) {
    var_1 = 0;
  }

  return var_1;
}

onspawnfinished() {
  self endon("death");
  self endon("disconnect");
  self waittill("giveLoadout");
  if(scripts\mp\utility::istrue(self.waitedtospawn)) {
    self.waitedtospawn = 0;
    wait(0.1);
    self suicide();
  }

  self.last_infected_class = self.infected_class;
  self.var_2049 = 0;
  self.var_204A = 0;
  if(self.pers["team"] == "allies") {
    if(level.enableping) {
      scripts\mp\utility::giveperk("specialty_boom");
    }

    spawnwithplayersecondary();
    var_0 = "primary";
    var_1 = scripts\mp\powers::getcurrentequipment(var_0);
    if(isDefined(var_1)) {
      scripts\mp\powers::removepower(var_1);
    }

    scripts\mp\powers::givepower(level.survivorlethal, var_0, 0);
    var_0 = "secondary";
    var_1 = scripts\mp\powers::getcurrentequipment(var_0);
    if(isDefined(var_1)) {
      scripts\mp\powers::removepower(var_1);
    }

    scripts\mp\powers::givepower(level.survivortactical, var_0, 0);
    managefists(level.survivorprimaryweapon, level.survivorsecondaryweapon);
  } else if(self.pers["team"] == "axis") {
    if(level.enableping) {
      scripts\mp\utility::giveperk("specialty_boom");
    }

    refundinfectedsuper();
    thread setinfectedmsg();
    if(!level.supportdoublejump_MAYBE) {
      var_2 = 1.1;
    } else {
      var_2 = 1.05;
    }

    var_3 = int(floor(level.infect_teamscores["axis"] / 3));
    var_3 = var_3 * 0.012;
    var_2 = var_2 - var_3;
    self.overrideweaponspeed_speedscale = var_2;
    scripts\mp\weapons::updatemovespeedscale();
    var_0 = "primary";
    var_1 = scripts\mp\powers::getcurrentequipment(var_0);
    if(isDefined(var_1)) {
      scripts\mp\powers::removepower(var_1);
    }

    scripts\mp\powers::givepower(level.infectedlethal, var_0, 0);
    if(level.infectedtactical != "power_tacInsert") {
      var_0 = "secondary";
      var_1 = scripts\mp\powers::getcurrentequipment(var_0);
      if(isDefined(var_1)) {
        scripts\mp\powers::removepower(var_1);
      }

      scripts\mp\powers::givepower(level.infectedtactical, var_0, 0);
    } else {
      scripts\mp\utility::giveperk("specialty_tacticalinsertion");
    }

    if(scripts\mp\utility::istrue(self.isinitialinfected)) {
      managefists(level.initialprimaryweapon, level.initialsecondaryweapon);
    } else {
      managefists(level.infectedprimaryweapon, level.infectedsecondaryweapon);
    }

    self setscriptablepartstate("infected", "active", 0);
  }

  giveextrainfectedperks();
  var_4 = scripts\mp\utility::getweaponrootname(self.loadoutprimary);
  if(var_4 != "iw7_knife") {
    self giveweapon("iw7_knife_mp_infect");
    self assignweaponmeleeslot("iw7_knife_mp_infect");
    if(self.loadoutsecondary == "iw7_knife") {
      scripts\mp\utility::takeweaponwhensafe("iw7_knife_mp");
      self giveweapon("iw7_knife_mp_infect2");
    }
  }

  self.faux_spawn_infected = undefined;
}

managefists(var_0, var_1) {
  if(var_0 != "iw7_fists" || var_1 != "iw7_fists") {
    if(var_0 == "none" && var_1 == "none") {
      return;
    }

    scripts\mp\utility::takeweaponwhensafe("iw7_fists_mp");
  }
}

giveextrainfectedperks() {
  if(self.pers["team"] == "allies") {
    var_0 = ["specialty_fastreload", "passive_gore", "passive_nuke", "passive_refresh"];
  } else if(scripts\mp\utility::istrue(self.isinitialinfected)) {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage", "specialty_bulletaccuracy", "specialty_quickswap"];
  } else {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage"];
  }

  foreach(var_2 in var_0) {
    scripts\mp\utility::giveperk(var_2);
  }
}

setinfectedmodels() {}

setinfectedmsg() {
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
      thread scripts\mp\utility::giveunifiedpoints("first_infected");
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

choosefirstinfected() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level endon("force_end");
  level.infect_allowsuicide = 0;
  scripts\mp\utility::gameflagwait("prematch_done");
  level.infect_countdowninprogress = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  setomnvar("ui_match_start_text", "first_infected_in");
  var_0 = 15;
  while(var_0 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", var_0);
    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  setomnvar("ui_match_start_countdown", 0);
  level.infect_countdowninprogress = 0;
  var_1 = [];
  foreach(var_3 in level.players) {
    if(scripts\mp\utility::matchmakinggame() && level.players.size > 1 && var_3 ishost()) {
      continue;
    }

    if(var_3.team == "spectator") {
      continue;
    }

    if(!var_3.hasspawned) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = undefined;
  if(var_1.size <= level.numinitialinfected && var_1.size > 1) {
    level.numinitialinfected = var_1.size - 1;
  }

  for(var_6 = 0; var_6 < level.numinitialinfected; var_6++) {
    var_5 = var_1[randomint(var_1.size)];
    var_5 setfirstinfected(1);
    var_1 = scripts\engine\utility::array_remove(var_1, var_5);
  }

  level.infect_allowsuicide = 1;
  foreach(var_3 in level.players) {
    if(var_3 == var_5) {
      continue;
    }

    var_3.survivalstarttime = gettime();
  }
}

setfirstinfected(var_0) {
  self endon("disconnect");
  self endon("death");
  if(var_0) {
    self.infect_isbeingchosen = 1;
  }

  while(!scripts\mp\utility::isreallyalive(self) || scripts\mp\utility::isusingremote()) {
    wait(0.05);
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  while(!isalive(self)) {
    scripts\engine\utility::waitframe();
  }

  if(var_0) {
    scripts\mp\menus::addtoteam("axis", undefined, 1);
    thread monitordisconnect();
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
    updateteamscores();
    self playlocalsound("breathing_better_c6");
  }

  self.isinitialinfected = 1;
  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\perkfunctions::deleteti(self.setspawnpoint);
  }

  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1.playerspawnpos = self.origin;
  var_1.notti = 1;
  self.setspawnpoint = var_1;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;
  waittillframeend;
  thread scripts\mp\playerlogic::spawnplayer(1);
  if(var_0) {
    level.infect_players[self.name] = 1;
  }

  foreach(var_3 in level.players) {
    var_3 thread scripts\mp\hud_message::showsplash("first_infected");
  }

  level thread scripts\mp\utility::teamplayercardsplash("callout_first_infected", self);
  if(!level.infect_skipsounds) {
    scripts\mp\utility::playsoundonplayers("mp_enemy_obj_captured");
    level.infect_skipsounds = 1;
  }

  self iprintlnbold(&"SPLASHES_INFECT_ALL");
  initsurvivaltime(1);
}

setinitialtonormalinfected(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self.isinitialinfected = undefined;
  self.changingtoregularinfected = 1;
  if(isDefined(var_0)) {
    self.changingtoregularinfectedbykill = 1;
  }

  while(!scripts\mp\utility::isreallyalive(self)) {
    wait(0.05);
  }

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  while(self ismeleeing()) {
    wait(0.05);
  }

  while(!scripts\mp\utility::isreallyalive(self)) {
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\perkfunctions::deleteti(self.setspawnpoint);
  }

  var_2 = spawn("script_model", self.origin);
  var_2.angles = self.angles;
  var_2.playerspawnpos = self.origin;
  var_2.notti = 1;
  self.setspawnpoint = var_2;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;
  scripts\engine\utility::waitframe();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }

  var_10 = 0;
  var_11 = 0;
  if(self.team == "axis") {
    self setscriptablepartstate("infected", "neutral", 0);
  }

  if(self.team == "allies" && isDefined(var_1)) {
    if(isplayer(var_1) && var_1 != self) {
      var_10 = 1;
    } else if(level.infect_allowsuicide && var_1 == self || !isplayer(var_1)) {
      var_10 = 1;
      var_11 = 1;
    }
  }

  if(isplayer(var_1) && var_1.team == "allies" && var_1 != self) {
    var_1 thread scripts\mp\perks\weaponpassives::func_8974(var_1, self);
    var_1 scripts\mp\utility::incperstat("killsAsSurvivor", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", var_1.pers["killsAsSurvivor"]);
  } else if(isplayer(var_1) && var_1.team == "axis" && var_1 != self) {
    var_1 scripts\mp\utility::incperstat("killsAsInfected", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "killsAsInfected", var_1.pers["killsAsInfected"]);
    if(isplayer(var_1)) {
      var_1 scripts\mp\utility::setextrascore1(var_1.pers["killsAsInfected"]);
    }
  }

  if(var_10) {
    thread delayedprocesskill(var_1, var_11);
    if(var_11) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected)) {
          var_13 thread setinitialtonormalinfected();
        }
      }
    } else if(isDefined(var_1.isinitialinfected)) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected)) {
          var_13 thread setinitialtonormalinfected(1);
        }
      }
    } else if(level.infectstreakbonus > 0) {
      if(!isDefined(var_1.infectedkillsthislife)) {
        var_1.infectedkillsthislife = 1;
      } else {
        var_1.infectedkillsthislife++;
      }

      var_1 thread scripts\mp\utility::giveunifiedpoints("infected_survivor", undefined, level.infectstreakbonus * var_1.infectedkillsthislife);
    } else {
      var_1 thread scripts\mp\utility::giveunifiedpoints("infected_survivor");
    }

    if(scripts\mp\utility::getwatcheddvar("timelimit") != 0) {
      if(!isDefined(level.extratime)) {
        level.extratime = level.infectextratimeperkill / 60;
      } else {
        level.extratime = level.extratime + level.infectextratimeperkill / 60;
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
  } else {
    self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
    self.infected_class = self.pers["team"];
  }

  if(self.pers["team"] == "allies") {
    setrandomrigifscout();
  }
}

delayedprocesskill(var_0, var_1) {
  wait(0.15);
  self.teamchangedthisframe = 1;
  scripts\mp\menus::addtoteam("axis");
  updateteamscores();
  level.infect_players[self.name] = 1;
  thread monitordisconnect();
  if(level.infect_teamscores["allies"] > 1) {
    scripts\mp\utility::playsoundonplayers("mp_enemy_obj_captured", "allies");
    scripts\mp\utility::playsoundonplayers("mp_war_objective_taken", "axis");
    thread scripts\mp\utility::teamplayercardsplash("callout_got_infected", self, "allies");
    if(!var_1) {
      thread scripts\mp\utility::teamplayercardsplash("callout_infected", var_0, "axis");
      if(!isDefined(level.survivorscoreevent)) {
        level.survivorscoreevent = scripts\mp\rank::getscoreinfovalue("survivor");
      } else {
        level.survivorscoreevent = level.survivorscoreevent + level.survivoralivescore;
      }

      foreach(var_3 in level.players) {
        if(!scripts\mp\utility::isreallyalive(var_3) || self.sessionstate == "spectator") {
          continue;
        }

        if(var_3.team == "allies" && var_3 != self && distance(var_3.infect_spawnpos, var_3.origin) > 32) {
          var_3 thread scripts\mp\utility::giveunifiedpoints("survivor", undefined, level.survivorscoreevent);
        }

        if(var_3.team == "axis" && var_3 != var_0 && var_3 != self) {
          var_3 thread scripts\mp\utility::giveunifiedpoints("assist", undefined, 50);
        }
      }
    }
  } else if(level.infect_teamscores["allies"] == 1) {
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

onfinalsurvivor() {
  scripts\mp\utility::playsoundonplayers("mp_obj_captured");
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1.team == "allies") {
      var_1 thread scripts\mp\rank::scoreeventpopup("final_survivor");
      if(!level.infect_awardedfinalsurvivor) {
        if(var_1.gamemodejoinedatstart && isDefined(var_1.infect_spawnpos) && distance(var_1.infect_spawnpos, var_1.origin) > 32) {
          var_1 thread scripts\mp\utility::giveunifiedpoints("final_survivor");
        }

        level.infect_awardedfinalsurvivor = 1;
      }

      thread scripts\mp\utility::teamplayercardsplash("callout_final_survivor", var_1);
      if(!var_1 scripts\mp\utility::isjuggernaut()) {
        level thread finalsurvivoruav(var_1);
      }

      break;
    }
  }
}

finalsurvivoruav(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  level endon("infect_lateJoiner");
  level thread enduavonlatejoiner(var_0);
  var_1 = 0;
  level.radarmode["axis"] = "normal_radar";
  foreach(var_3 in level.players) {
    if(var_3.team == "axis") {
      var_3.radarmode = "normal_radar";
    }
  }

  var_5 = getuavstrengthlevelneutral();
  scripts\mp\killstreaks\_uav::_setteamradarstrength("axis", var_5 + 1);
  for(;;) {
    var_6 = var_0.origin;
    wait(4);
    if(var_1) {
      setteamradar("axis", 0);
      var_1 = 0;
    }

    wait(6);
    if(distance(var_6, var_0.origin) < 200) {
      setteamradar("axis", 1);
      var_1 = 1;
      foreach(var_3 in level.players) {
        var_3 playlocalsound("recondrone_tag");
      }
    }
  }
}

enduavonlatejoiner(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  for(;;) {
    if(level.infect_teamscores["allies"] > 1) {
      level notify("infect_lateJoiner");
      wait(0.05);
      setteamradar("axis", 0);
      break;
    }

    wait(0.05);
  }
}

monitordisconnect() {
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
      if(var_0 == "allies" && level.infect_teamscores["allies"] == 1) {
        onfinalsurvivor();
      } else if(var_0 == "axis" && level.infect_teamscores["axis"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "axis") {
            var_2 setfirstinfected(0);
          }
        }
      }
    } else if(level.infect_teamscores["allies"] == 0) {
      if(scripts\mp\utility::istrue(level.hostmigration)) {
        scripts\mp\hostmigration::waittillhostmigrationdone();
      }

      onsurvivorseliminated();
    } else if(level.infect_teamscores["axis"] == 0) {
      if(level.infect_teamscores["allies"] == 1) {
        level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["axis_eliminated"]);
      } else if(level.infect_teamscores["allies"] > 1) {
        level.infect_chosefirstinfected = 0;
        level thread choosefirstinfected();
      }
    }
  } else if(level.infect_countdowninprogress && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0) {
    level notify("infect_stopCountdown");
    level.infect_choosingfirstinfected = 0;
    setomnvar("ui_match_start_countdown", 0);
  }

  self.isinitialinfected = undefined;
}

ondeadevent(var_0) {}

ontimelimit() {
  level thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["time_limit_reached"]);
}

onsurvivorseliminated() {
  level thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["allies_eliminated"]);
}

getteamsize(var_0) {
  var_1 = 0;
  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator" && !var_3.clearstartpointtransients) {
      continue;
    }

    if(var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

updateteamscores() {
  level.infect_teamscores["allies"] = getteamsize("allies");
  game["teamScores"]["allies"] = level.infect_teamscores["allies"];
  setteamscore("allies", level.infect_teamscores["allies"]);
  level.infect_teamscores["axis"] = getteamsize("axis");
  game["teamScores"]["axis"] = level.infect_teamscores["axis"];
  setteamscore("axis", level.infect_teamscores["axis"]);
}

setspecialloadouts() {
  wait(0.05);
  if(!isDefined(level.survivorprimaryweapon) || level.survivorprimaryweapon == "") {
    level.survivorprimaryweapon = "iw7_spasc";
  }

  if(!isDefined(level.survivorsecondaryweapon) || level.survivorsecondaryweapon == "") {
    level.survivorsecondaryweapon = "iw7_g18";
  }

  if(!isDefined(level.infectedprimaryweapon) || level.infectedprimaryweapon == "") {
    level.infectedprimaryweapon = "iw7_knife";
  }

  if(!isDefined(level.infectedsecondaryweapon) || level.infectedsecondaryweapon == "") {
    level.infectedsecondaryweapon = "iw7_fists";
  }

  if(!isDefined(level.initialprimaryweapon) || level.initialprimaryweapon == "") {
    level.initialprimaryweapon = "iw7_spasc";
  }

  if(isDefined(level.infectedprimaryweapon) && level.infectedprimaryweapon == "iw7_knife") {
    level.infectedprimaryweapon = "iw7_knife_mp_infect2";
    if(isDefined(level.infectedsecondaryweapon) && level.infectedsecondaryweapon == "iw7_knife") {
      level.infectedsecondaryweapon = "none";
    }
  }

  if(!isDefined(level.initialsecondaryweapon) || level.initialsecondaryweapon == "") {
    level.initialsecondaryweapon = "iw7_g18";
  }

  addsurvivorattachmentsprimary(level.survivorprimaryweapon);
  addsurvivorattachmentssecondary(level.survivorsecondaryweapon);
  addinitialattachmentsprimary(level.initialprimaryweapon);
  addinitialattachmentssecondary(level.initialsecondaryweapon);
  if(!isDefined(level.survivorlethal) || level.survivorlethal == "") {
    level.survivorlethal = "power_tripMine";
  }

  if(!isDefined(level.survivortactical) || level.survivortactical == "") {
    level.survivortactical = "power_concussionGrenade";
  }

  if(!isDefined(level.infectedlethal) || level.infectedlethal == "") {
    level.infectedlethal = "power_throwingKnife";
  }

  if(!isDefined(level.infectedtactical) || level.infectedtactical == "") {
    level.infectedtactical = "none";
  }

  level.infect_allyrigs = [];
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assault";
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_heavy";
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_engineer";
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_sniper";
  level.infect_allyrigs[level.infect_allyrigs.size] = "archetype_assassin";
  if(scripts\mp\utility::isusingdefaultclass("allies", 0)) {
    level.infect_loadouts["allies"] = ::scripts\mp\utility::getmatchrulesspecialclass("allies", 0);
  } else {
    level.infect_loadouts["allies"]["loadoutPrimary"] = level.survivorprimaryweapon;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = level.attachmentsurvivorprimary;
    level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondary"] = level.survivorsecondaryweapon;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["allies"]["loadoutPowerPrimary"] = level.survivorlethal;
    level.infect_loadouts["allies"]["loadoutPowerSecondary"] = level.survivortactical;
    level.infect_loadouts["allies"]["loadoutSuper"] = level.survivorsuper;
    level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["allies"]["loadoutJuggernaut"] = 0;
    level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_scavenger", "specialty_quieter"];
    level.infect_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["allies"]["loadoutRigTrait"] = "specialty_null";
    if(level.enableping) {
      level.infect_loadouts["allies"]["loadoutRigTrait"] = "specialty_boom";
    }
  }

  if(scripts\mp\utility::isusingdefaultclass("axis", 1)) {
    level.infect_loadouts["axis_initial"] = ::scripts\mp\utility::getmatchrulesspecialclass("axis", 1);
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
  } else {
    level.infect_loadouts["axis_initial"]["loadoutArchetype"] = "archetype_scout";
    level.infect_loadouts["axis_initial"]["loadoutPrimary"] = level.initialprimaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = level.attachmentinitialprimary;
    level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondary"] = level.initialsecondaryweapon;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = level.attachmentinitialsecondary;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutPowerPrimary"] = level.infectedlethal;
    level.infect_loadouts["axis_initial"]["loadoutPowerSecondary"] = level.infectedtactical;
    level.infect_loadouts["axis_initial"]["loadoutSuper"] = level.infectedsuper;
    level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
    level.infect_loadouts["axis_initial"]["loadoutJuggernaut"] = 0;
    level.infect_loadouts["axis_initial"]["loadoutPerks"] = ["specialty_quieter"];
    level.infect_loadouts["axis_initial"]["loadoutGesture"] = "playerData";
    level.infect_loadouts["axis_initial"]["loadoutRigTrait"] = "specialty_null";
    if(level.enableinfectedtracker) {
      level.infect_loadouts["axis_initial"]["loadoutPerks"][level.infect_loadouts["axis_initial"]["loadoutPerks"].size] = "specialty_tracker";
    }
  }

  if(scripts\mp\utility::isusingdefaultclass("axis", 0)) {
    level.infect_loadouts["axis"] = ::scripts\mp\utility::getmatchrulesspecialclass("axis", 0);
    level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
    level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
    level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
    return;
  }

  level.infect_loadouts["axis"]["loadoutArchetype"] = "archetype_scout";
  level.infect_loadouts["axis"]["loadoutPrimary"] = level.infectedprimaryweapon;
  level.infect_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
  level.infect_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondary"] = level.infectedsecondaryweapon;
  level.infect_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
  level.infect_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
  level.infect_loadouts["axis"]["loadoutPowerPrimary"] = level.infectedlethal;
  level.infect_loadouts["axis"]["loadoutPowerSecondary"] = level.infectedtactical;
  level.infect_loadouts["axis"]["loadoutSuper"] = level.infectedsuper;
  level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
  level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
  level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
  level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
  level.infect_loadouts["axis"]["loadoutJuggernaut"] = 0;
  level.infect_loadouts["axis"]["loadoutPerks"] = ["specialty_quieter"];
  level.infect_loadouts["axis"]["loadoutGesture"] = "playerData";
  level.infect_loadouts["axis"]["loadoutRigTrait"] = "specialty_null";
  if(level.enableinfectedtracker) {
    level.infect_loadouts["axis"]["loadoutPerks"][level.infect_loadouts["axis"]["loadoutPerks"].size] = "specialty_tracker";
  }
}

addsurvivorattachmentsprimary(var_0) {
  level.attachmentsurvivorprimary = "none";
  var_1 = scripts\mp\utility::getweapongroup(var_0);
  if(var_1 == "weapon_shotgun") {
    level.attachmentsurvivorprimary = "barrelrange";
    return;
  }

  if(var_1 == "weapon_assault" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level.attachmentsurvivorprimary = "highcal";
  }
}

addinitialattachmentsprimary(var_0) {
  level.attachmentinitialprimary = "none";
  var_1 = scripts\mp\utility::getweapongroup(var_0);
  if(var_1 == "weapon_shotgun") {
    level.attachmentinitialprimary = "barrelrange";
    return;
  }

  if(var_1 == "weapon_assault" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level.attachmentinitialprimary = "highcal";
  }
}

addsurvivorattachmentssecondary(var_0) {
  level.attachmentsurvivorsecondary = "none";
  level.attachmentsurvivorsecondarytwo = "none";
  var_1 = scripts\mp\utility::getweapongroup(var_0);
  if(var_1 == "weapon_pistol") {
    level.attachmentsurvivorsecondary = "highcal";
  }

  if(scripts\mp\utility::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level.attachmentsurvivorsecondary = "akimbo";
      level.attachmentsurvivorsecondarytwo = "highcal";
    }
  }
}

addinitialattachmentssecondary(var_0) {
  level.attachmentinitialsecondary = "none";
  level.attachmentinitialsecondarytwo = "none";
  var_1 = scripts\mp\utility::getweapongroup(var_0);
  if(var_1 == "weapon_pistol") {
    level.attachmentinitialsecondary = "highcal";
  }

  if(scripts\mp\utility::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level.attachmentinitialsecondary = "akimbo";
      level.attachmentinitialsecondarytwo = "highcal";
    }
  }
}

monitorsurvivaltime() {
  self endon("death");
  self endon("disconnect");
  self endon("infected");
  level endon("game_ended");
  for(;;) {
    if(!level.infect_chosefirstinfected || !isDefined(self.survivalstarttime) || !isalive(self)) {
      wait(0.05);
      continue;
    }

    setsurvivaltime(0);
    wait(1);
  }
}

initsurvivaltime(var_0) {
  scripts\mp\utility::setextrascore0(0);
  if(isDefined(var_0) && var_0) {
    self notify("infected");
  }
}

setsurvivaltime(var_0) {
  if(!isDefined(self.survivalstarttime)) {
    self.survivalstarttime = self.spawntime;
  }

  var_1 = int(gettime() - self.survivalstarttime / 1000);
  if(var_1 > 999) {
    var_1 = 999;
  }

  scripts\mp\utility::setextrascore0(var_1);
  if(isDefined(var_0) && var_0) {
    self notify("infected");
  }
}

refundinfectedsuper() {
  var_0 = self.super;
  if(isDefined(var_0)) {
    var_1 = scripts\mp\supers::getsupermaxcooldownmsec() / 10;
    scripts\mp\supers::func_DE3A(var_1);
  }
}

setrandomrigifscout() {
  self.infected_archtype = "archetype_scout";
  if(!isbot(self)) {
    self.infected_archtype = scripts\mp\class::cac_getcharacterarchetype();
  }

  if(self.infected_archtype == "archetype_scout") {
    self.pers["gamemodeLoadout"]["loadoutArchetype"] = level.infect_allyrigs[randomint(level.infect_allyrigs.size)];
  }
}