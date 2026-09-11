/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_hstg.gsc
***********************************************/

function main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = &onstartgametype;
}

function maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype();
}

function maintacopsinit() {
  level.tacopssublevel = "to_hstg";
  level.currentmode = "to_hstg";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_hstg", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_hstg", 10);
    scripts\mp\utility\game::registerscorelimitdvar("to_hstg", 85);
    scripts\mp\utility\game::registerroundlimitdvar("to_hstg", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_hstg", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_hstg", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_hstg", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_hstg", 0);
  }

  updategametypedvars();
  setuphudelements();
  level.resetscoreonroundstart = 1;
  level.spawnedhostagecount = 0;
  scripts\mp\gametypes\obj_grindzone::init();
  level.teambased = 1;
  level.onplayerconnect = &onplayerconnect;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.onsuicidedeath = &onsuicidedeath;
  level.ontimelimit = &ontimelimit;
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_to_hstg_bankTime", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("scr_to_hstg_bankRate", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("scr_to_hstg_bankCaptureTime", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("scr_to_hstg_megaBankLimit", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("scr_to_hstg_bankBonus", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("scr_to_hstg_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("to_hstg", 0);
  setdynamicdvar("scr_to_hstg_promode", 0);
}

function seticonnames() {
  level.waypointcolors["waypoint_capture_recover"] = "neutral";
  level.waypointbgtype["waypoint_capture_recover"] = 1;
  level.waypointcolors["koth_enemy"] = "enemy";
  level.waypointbgtype["koth_enemy"] = 1;
  level.icontarget = "waypoint_hardpoint_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_enemy";
  level.icondefend = "koth_friendly";
  level.iconcontested = "waypoint_hardpoint_contested";
  level.icontaking = "waypoint_taking_chevron";
  level.iconlosing = "waypoint_hardpoint_losing";
  level.iconbombcapture = "waypoint_target";
  level.iconbombdefend = "waypoint_defend";
  level.iconrecover = "waypoint_capture_recover";
  level.iconescort = "waypoint_escort";
  level.icondefendhvt = "waypoint_defend_round";
  level.iconkill = "waypoint_capture_kill_round";
}

function onstartgametype() {
  createzones();
  seticonnames();
  scripts\mp\tac_ops\hostage_utility::hostagesysteminit();
  setDvar("MTLTONMMQT", 0.75);
  level.zoneduration = 120;
  level.hostagestates = [];
  level.hostagecarrystates = [];
  level.debughostagegame = 1;
  createhvt();
  level.extractionlocent = getEnt("hvtExtractionLoc", "targetname");
  level.hostagecheckpointent = [];
  level.hostagecheckpointent[0] = scripts\engine\utility::getStructArray("hostage_waypoint_1", "targetname");
  level.hostagecheckpointent[1] = scripts\engine\utility::getStructArray("hostage_waypoint_2", "targetname");
  level.hostagecheckpointent[2] = scripts\engine\utility::getStructArray("hostage_waypoint_3", "targetname");
  thread createhvtextractionsite();
  level.hostagehidespots = [];
  level.hostagehidespots[0] = level.hvtlocent;
  level.hostageexitpoints = [];
  level.hostageexitpoints[0] = level.objectives[0];
  scripts\mp\tac_ops\hostage_utility::spawnallhostages();
  level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam(level.hostages[0].body, level.hostages[0].team, "outline_nodepth_cyan", "killstreak_personal");
  setDvar("MTLTONMMQT", 0.75);
  level.zoneduration = 120;
  level.hostagestates = [];
  level.hostagecarrystates = [];
  level.debughostagegame = 1;
  level.objectives[0] scripts\mp\gameobjects::setkeyobject(level.hostages[0]);
  level.fixedlzs = [];
  level.fixedlzs[0] = level.objectives[0];
  initializefixedlzs();
  thread watchpushtriggers();

  if(!istrue(level.startedfromtacops)) {
    GscBinSkip1(0x45, 0, "dom", level);
  }

  var1 = scripts\mp\utility\game::gettimelimit();
  level.extratime = 0;
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 6);
  level.tacopssubmodetimeron = 1;
}

function setusablebyteam(var0) {
  foreach(var2 in level.players) {
    if(var2.team != var0) {
      self disableplayeruse(var2);
      continue;
    }

    self enableplayeruse(var2);
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.banktime = scripts\mp\utility\dvars::dvarfloatvalue("bankTime", 2, 0, 10);
  level.bankrate = scripts\mp\utility\dvars::dvarintvalue("bankRate", 1, 1, 10);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue("megaBankLimit", 5, 5, 15);
  level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue("megaBankBonus", 150, 0, 750);
}

function setuphudelements() {
  level.iconenemyextract3d = "waypoint_extract_enemy";
  level.iconenemyextract2d = "waypoint_extract_enemy";
  level.iconfriendlyextract3d = "waypoint_extract_friendly";
  level.iconfriendlyextract2d = "waypoint_extract_friendly";
  level.iconfriendlyzone3d = "waypoint_staging_friendly";
  level.iconfriendlyzone2d = "waypoint_staging_friendly";
}

function updateextracticons() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlyextract2d);
}

function onspawnplayer() {
  if(isDefined(self.tagscarried)) {
    self setclientomnvar("ui_grind_tags", self.tagscarried);
  }

  scripts\mp\playerlogic::incrementalivecount(self.team);
  self.hostagecarried = undefined;
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

function onplayerconnect(var0) {
  var0.isscoring = 0;
  thread monitorjointeam();
}

function monitorjointeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    var0 = 0;

    if(self.team == "allies") {
      var0 = 1;
    } else if(self.team == "axis") {
      var0 = 2;
    }

    self setclientomnvar("ui_tacops_team", var0);

    if(!isDefined(level.startedfromtacops)) {
      scripts\mp\supers::clearsuper();
      scripts\mp\tac_ops\roles_utility::latejointeamkitobjective();
    }
  }
}

function createzones() {
  var0 = scripts\engine\utility::getStructArray("hostage_extract_zone_A", "targetname");
  var1 = scripts\engine\utility::getStructArray("hostage_extract_zone_B", "targetname");
  level.fixedlzs = scripts\engine\utility::array_combine(var0, var1);
  level.objectives = [];
}

function zone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");
}

function initspawns() {
  var0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tohstg_spawn_allies", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tohstg_spawn_axis", 1);
  var0.to_hstg_spawns = [];
  var0.to_hstg_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_tohstg_spawn_allies");
  var0.to_hstg_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_tohstg_spawn_axis");

  if(var0.to_hstg_spawns["allies"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_front_spawn_allies");
    var0.to_hstg_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_allies");
  }

  if(var0.to_hstg_spawns["axis"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_front_spawn_axis");
    var0.to_hstg_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_front_spawn_axis");
    return;
  }
}

function getspawnpoint() {
  var0 = level.tacopsspawns;
  var1 = self.pers["team"];
  var2 = scripts\mp\tac_ops_map::filterspawnpoints(var0.to_hstg_spawns[var1]);
  var3 = undefined;
  return var3;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  scripts\mp\tac_ops_map::setactivemapconfig("to_hstg", "allies");
  scripts\mp\tac_ops_map::setactivemapconfig("to_hstg", "axis");
  level.getspawnpoint = &getspawnpoint;
}

function ontimelimit() {
  endhostagegame("allies");
}

function endhostagegame(var0) {
  level.extratime = undefined;
  level notify("switch_modes");

  foreach(var2 in level.hostages) {
    var2 scripts\mp\tac_ops\hostage_utility::removeminimapicons();

    if(isDefined(var2.useobj)) {
      var2.useobj delete();
    }

    var2.body delete();
    var2.head delete();
    var2 delete();
  }

  level.hostages = [];

  foreach(var5 in level.activeextractions) {
    cleanuplz(var5, 0);
    var5 scripts\mp\gametypes\obj_grindzone::deactivatezone();
  }

  if(isDefined(level.onphaseend)) {
    [[level.onphaseend]](var0);
  }

  scripts\mp\gamescore::_setteamscore(var0, 1, 0);
  thread scripts\mp\gamelogic::endgame(var0, game["end_reason"]["objective_completed"]);
}

function onsuicidedeath(var0) {
  if(isDefined(var0.hostagecarried)) {
    scripts\mp\tac_ops\hostage_utility::drophostage(var0, var0.hostagecarried, var0.origin);
    return;
  }
}

function onnormaldeath(var0, var1, var2, var3, var4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4);

  if(isDefined(var0.hostagecarried)) {
    scripts\mp\tac_ops\hostage_utility::drophostage(var0, var0.hostagecarried, var0.origin);
  }

  if(!isDefined(var0.switching_teams)) {
    var0 scripts\mp\playerlogic::decrementalivecount(var0.team);
    return;
  }
}

function delayedhostagespawn(var0, var1, var2) {
  level endon("game_ended");
  level endon("hostage_spawn_early");
  wait var0;
  scripts\mp\tac_ops\hostage_utility::spawnrandomhostages(var1, var2);
}

function hostagecheckscoring() {
  for(var0 = 0; var0 < level.activeextractions.size; var0++) {
    var1 = level.activeextractions[var0];

    if(distancesquared(self.origin, var1.origin) < 14400) {
      iprintlnbold("OPFOR EXTRACTED A HOSTAGE");
      scripts\mp\tac_ops\hostage_utility::scorehostage(var1.team, 3);
      return true;
    }
  }

  return false;
}

function initializefixedlzs() {
  level endon("game_ended");
  level endon("switch_modes");
  level.extractionteam = "allies";

  for(var0 = 0; var0 < level.fixedlzs.size; var0++) {
    level.inactiveextractions[var0] = level.fixedlzs[var0];
  }

  thread waitprematchdone();
}

function initializedynamiclzs() {
  level endon("game_ended");
  level endon("switch_modes");
  level.extractionteam = "axis";

  for(var0 = 0; var0 < 2; var0++) {
    level.inactiveextractions[var0] = level.objective[var0];
    updateextracticons(level.inactiveextractions[var0]);
    level.inactiveextractions[var0] scripts\mp\gameobjects::setvisibleteam("none");
  }

  thread waitprematchdone();
}

function waitprematchdone() {
  scripts\mp\flags::gameflagwait("prematch_done");
}

function createhostagelz(var0, var1) {
  var2 = level.inactiveextractions.size;
  var3 = level.inactiveextractions[var2 - 1];
  var3.marker = var0;
  level.inactiveextractions[var2 - 1] = undefined;
  var4 = level.activeextractions.size;
  level.activeextractions[var4] = var3;
  level.activeextractors[var4] = self;
  var5 = int(gettime() + 119000);

  if(istrue(var1)) {
    makelzextractionvisuals(var3);
    return;
  }
}

function makelzextractionvisuals(var0, var1) {
  if(!isDefined(var1)) {
    var1 = level.extractionpos;
  }

  var0.origin = var1;

  if(isDefined(var0.trigger)) {
    var0.trigger.origin = var1;
  }

  var0.curorigin = var1;
  var0 scripts\mp\gameobjects::requestid(1, 1);
  updateextracticons(var0);
  var0 scripts\mp\gametypes\obj_grindzone::activatezone();
  var0.active = 1;
  var0 scripts\mp\gameobjects::setvisibleteam("friendly");
  var0.scriptable = scripts\mp\gametypes\obj_grindzone::setupscriptablevisuals(var1, var0);
  var0 scripts\mp\gametypes\obj_grindzone::updateflagstate(var0.team, 0);

  if(isDefined(var0.team)) {
    updateservericons(var0.team, 0);
  }

  level notify("zone_moved");
  scripts\mp\utility\sound::playsoundonplayers("mp_killstreak_radar");
  var2 = spawnfx(level._effect["vfx_smk_signal"], var1);

  if(isDefined(var2)) {
    triggerfx(var2);
  }

  var0.fxtoplay = var2;
}

function spawnextractchopper(var0, var1) {
  self endon("game_ended");
  self endon("switch_modes");
  wait var1;
  var2 = level.extractionpos;
  var3 = (0, 0, 0);
  var4 = 24000;
  var5 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var6 = var5.origin[2];
  var7 = getexplodedistance(var6);
  var8 = 4000;
  var9 = "jackal";
  var10 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var2, var3, var4, var5, var6, var8, var7, var9);
  var11 = fakestreakinfo();
  var12 = scripts\mp\killstreaks\jackal::beginjackal(0, var10["startPoint"], var2, var11, var0);
  return var12;
}

function fakestreakinfo() {
  var0 = spawnStruct();
  var0.available = 1;
  var0.firednotify = "offhand_fired";
  var0.isgimme = 1;
  var0.kid = 5;
  var0.lifeid = 0;
  var0.madeavailabletime = gettime();
  var0.scriptuseagetype = "gesture_script_weapon";
  var0.streakname = "jackal";
  var0.streaksetupinfo = undefined;
  var0.variantid = -1;
  var0.weaponname = "ks_gesture_generic_mp";
  var0.objweapon = getcompleteweaponname(var0.weaponname);
  return var0;
}

function getexplodedistance(var0) {
  var1 = 850;
  var2 = 1500;
  var3 = var1 / var0;
  var4 = var3 * var2;
  return var4;
}

function waitlzextractarrival(var0) {
  level endon("game_ended");
  level endon("switch_modes");
  self endon("extraction_destroyed");
  thread extractvehicledeathwatcher();
  wait 119;

  foreach(var2 in level.jackals) {
    if(!isDefined(var2.lz) || !isDefined(var2.lz.marker)) {
      continue;
    }

    if(self.marker == var2.lz.marker) {
      var2 notify("extract_hostages");
    }
  }

  if(level.objectives[0].ownerteam == "allies") {
    scripts\mp\gamescore::_setteamscore("allies", 1, 0);
    thread scripts\mp\gamelogic::endgame("allies", game["end_reason"]["objective_completed"]);
    return;
  }

  scripts\mp\gamescore::_setteamscore("axis", 1, 0);
  thread scripts\mp\gamelogic::endgame("axis", game["end_reason"]["objective_completed"]);
}

function extractvehicledeathwatcher() {
  level endon("switch_modes");
  self endon("game_ended");
  self endon("extract_hostages");
  self waittill("extraction_destroyed");
  cleanuplz(0);
}

function cleanuplz(var0) {
  if(var0) {
    checkhostagescoring();
  }

  cleanuplzvisuals();
  level.inactiveextractions[level.inactiveextractions.size] = self;
  level.activeextractors = scripts\engine\utility::array_remove_index(level.activeextractors, 0);
  level.activeextractions = scripts\engine\utility::array_remove_index(level.activeextractions, 0);
}

function cleanuplzvisuals() {
  if(isDefined(self.scriptable)) {
    scripts\mp\gametypes\obj_grindzone::updateflagstate("off", 0);
    self.scriptable delete();
  }

  if(isDefined(self.fxtoplay)) {
    self.fxtoplay delete();
  }

  if(isDefined(self.marker) && isDefined(self.marker.visual)) {
    self.marker.visual delete();
    scripts\mp\gameobjects::allowuse("none");
    scripts\mp\gameobjects::releaseid();
  }

  self.active = 0;
  updateservericons("zone_shift", 0);
  scripts\mp\gametypes\obj_grindzone::deactivatezone();
  self.active = 1;
  self.lastactivatetime = gettime();
}

function checkhostagescoring() {
  var0 = [];
  var1 = "none";

  foreach(var3 in level.hostages) {
    if(hostagecheckscoring(var3)) {
      var0 = var3;
    }

    var1 = var3.team;
  }

  level.hostages = scripts\engine\utility::array_remove_array(level.hostages, var0);
  tryhostagerespawn(var1);
}

function tryhostagerespawn(var0) {
  if(level.hostages.size == 0) {
    level notify("hostage_spawn_early");
    scripts\mp\tac_ops\hostage_utility::spawnrandomhostages(2, var0);
    waitframe();
    var1 = scripts\mp\gametypes\tac_ops::gettacopstimelimitms() / 1000;
    thread delayedhostagespawn(var1 * 0.2, 2);
    thread delayedhostagespawn(var1 * 0.4, 2);
    thread delayedhostagespawn(var1 * 0.6, 2);
    return;
  }
}

function handlehostmigration(var0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var1 > 0) {
    return;
  }
}

function updateservericons(var0, var1) {
  var2 = -1;

  if(var1) {
    var2 = -2;
    return;
  }

  switch (var0) {
    case "axis":
    case "allies":
      var3 = thread getownerteamplayer(var0);

      if(isDefined(var3)) {
        var2 = var3 getentitynumber();
      }

      break;
    case "zone_activation_delay":
      var2 = -3;
      break;
    case "zone_shift":
    default:
      break;
  }
}

function getownerteamplayer(var0) {
  var1 = undefined;

  foreach(var3 in level.players) {
    if(var3.team == var0) {
      var1 = var3;
      break;
    }
  }

  return var1;
}

function setupextractioncallouts(var0) {
  var1 = 1;
  level.extractionteam = var0;

  if(!isDefined(level.extractionteam)) {
    var1 = 2;
  } else if(level.extractionteam == "allies") {
    var1 = 0;
  }

  foreach(var3 in level.players) {
    if(isDefined(var1)) {
      var3 setclientomnvar("ui_hp_callout_id", var1);
    }
  }
}

function trycreateextractpoint(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(level.activeextractions.size < 2) {
    level.extractionpos = var0;
    createhostagelz(var1, var2);
    self iprintlnbold("Extraction copter deployed, hold out!");
    return 1;
  }

  self iprintlnbold("Request Denied - All copters already en route!");
  return 0;
}

function getextractiontimeconst() {
  return 120;
}

function createhvt() {
  var0 = getEnt("hvtSpawnLoc", "targetname");
  level.hvtlocent = var0;
}

function createhvtextractionsite() {
  var0 = getEnt("hvtExtractionLoc", "targetname");
  level.objectives = [];
  level.objectives[0] = var0;
  var1 = scripts\mp\gametypes\obj_dom::setupobjective(level.objectives[0]);
  scripts\engine\utility::delaythread(3, &delayset);
  var1.onuse = &hostagedompoint_onuse;
  level.objectives[0] = var1;
  level.flagcapturetime = 0.1;
  level.flagneutralization = 0;
  waitframe();
  var1 scripts\mp\gameobjects::setownerteam("neutral");
  var1 scripts\mp\gameobjects::setvisibleteam("any");
  var1 scripts\mp\gameobjects::allowuse("enemy");
  var1 scripts\mp\gameobjects::cancontestclaim(1);
  var1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

function delayset() {
  level.objectives[0] scripts\mp\gameobjects::setownerteam("axis");
  level.objectives[0] scripts\mp\gameobjects::allowuse("enemy");
  level.objectives[0] scripts\mp\gametypes\obj_dom::updateflagstate("axis", 0);
  level.objectives[0] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

function watchpushtriggers() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  var0 = getEntArray("to_hstg_push_trigger", "targetname");

  if(!isDefined(var0) || var0.size <= 0) {
    return;
  }

  var1 = [];

  foreach(var3 in var0) {
    var4 = int(var3.script_noteworthy);
    var1 = var3;
  }

  var6 = 0;

  for(;;) {
    wait 1;
    var7 = var1[var6 + 1];

    if(isDefined(var7)) {
      foreach(var9 in level.hostages) {
        if(var9 istouching(var7)) {
          var6++;
          var10 = "to_hstg_" + var6;
          scripts\mp\tac_ops_map::setactivemapconfig(var10, "allies");
          scripts\mp\tac_ops_map::setactivemapconfig(var10, "axis");
          level notify("hostage_spawns_pushed");
        }
      }
    }
  }
}

function hostagedompoint_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);

  if(var0.team == "allies") {
    if(isDefined(var0.hostagecarried)) {
      var1 = scripts\mp\tac_ops\hostage_utility::drophostage(var0, var0.hostagecarried, var0.origin);
      var1.trackedobject scripts\mp\gameobjects::deletetrackedobject();
      var1 makeunusable();
      var1.useobj unlink();
      var1.useobj makeunusable();
    }

    thread trycreateextractpoint(var0, var0.origin, undefined);
    var2 = scripts\mp\gametypes\tac_ops::gettacopstimeremainingms();

    if(var2 < getextractiontimeconst() * 1000) {
      scripts\mp\gametypes\tac_ops::extendtacopstimelimitms(getextractiontimeconst() * 1000 - var2);
    } else {
      scripts\mp\gametypes\tac_ops::reducetacopstimelimitms(var2 - getextractiontimeconst() * 1000);
    }

    level.objectives[0].onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
    level.objectives[0] scripts\mp\gameobjects::setkeyobject(undefined);
    level.objectives[0] scripts\mp\gameobjects::setvisibleteam("any");
    level.objectives[0] scripts\mp\gameobjects::allowuse("enemy");

    if(scripts\mp\utility\teams::getteamdata("allies", "teamCount")) {
      level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata("allies", "players"), &compare_player_score);
      var3 = spawnextractchopper(level.topplayers[0], self, 0);
      var4 = scripts\mp\utility\teams::getteamdata("axis", "players");
      var5 = var4.size;
      var5 = max(var5, 1);
      var6 = 1666.67;
      var3.health = int(var5 * var6);
      var3.maxhealth = var3.health;
      thread copterdeathwatcher();
      thread copterhealthwatcher();
      setomnvar("ui_tacops_helo_health_percent", 1);
      thread holdoutphase();
      return;
    }

    return;
  }
}

function holdouttext() {
  wait 7;
  scripts\mp\gametypes\tac_ops::teamprint(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_DEFEND_1", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_DEFEND_1");
}

function copterhealthwatcher() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var0);
    setomnvar("ui_tacops_helo_health_percent", self.health / self.maxhealth);
  }
}

function copterdeathwatcher() {
  level endon("game_ended");
  self waittill("extraction_destroyed");
  scripts\mp\gametypes\tac_ops::pausetacopstimer();
  wait 5;
  endhostagegame("axis");
}

function holdoutphase() {
  level endon("game_ended");
  self endon("extraction_destroyed");
  level notify("hostage_holdout_phase_begun");
  thread holdouttext();
  startcopteroutofbounds();
  wait getextractiontimeconst() - 110;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_wina", "allies");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_lz_capture", "axis");
  wait 10;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_ovl_lz_hold", "allies");
  wait 20;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us2_phase3_introa4", "allies");
  wait 55;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us2_phase1_infila6", "allies");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase1_lesstimeb", "axis");
}

function startcopteroutofbounds() {
  var0 = getEntArray("holdout_outofbounds", "targetname");
  var1 = scripts\mp\utility\teams::getteamdata("allies", "players");

  foreach(var3 in var1) {
    foreach(var5 in var0) {
      startphaseoob(var3, var5, "copterHoldOut");
    }
  }
}

function startphaseoob(var0, var1) {
  level endon("game_ended");
  level endon("switch_modes");
}

function compare_player_score(var0, var1) {
  return var0.score >= var1.score;
}