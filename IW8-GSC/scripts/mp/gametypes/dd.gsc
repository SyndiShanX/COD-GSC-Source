/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dd.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_dd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_dd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_dd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_dd_silentPlant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_dd_extratime", getmatchrulesdata("demData", "extraTime"));
  setdynamicdvar("scr_dd_overtimeLimit", getmatchrulesdata("demData", "overtimeLimit"));
  setdynamicdvar("scr_dd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("dd", 0);
  setdynamicdvar("scr_dd_promode", 0);
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

function onstartgametype() {
  if(game["roundsPlayed"] == 2) {
    game["status"] = "overtime";
    setDvar("ui_overtime", 1);
  }

  if(scripts\mp\utility\game::inovertime()) {
    setomnvar("ui_round_hint_override_attackers", 1);
    setomnvar("ui_round_hint_override_defenders", 1);
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  level.usestartspawns = 1;
  setclientnamemode("manual_change");

  if(scripts\mp\utility\game::inovertime()) {
    game["dialog"]["defense_obj"] = "obj_destroy";
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/DD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/DD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/DD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/DD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/DD_DEFENDER_SCORE");
  }

  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/DD_OVERTIME_HINT");
    scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/DD_OVERTIME_HINT");
  } else {
    scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/DD_ATTACKER_HINT");
    scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/DD_DEFENDER_HINT");
  }

  thread waittoprocess();
  setupobjectiveicons();
  thread bombs();
}

function initspawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dd_spawn_attacker_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_dd_spawn_defender_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_start");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_a", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_b", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_a", 1);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_b", 1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.binoculars_clearuidata)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", var_2);
    scripts\mp\spawnlogic::registerspawnset("fallback", var_3);
    return;
  }

  level.spawn_defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender");
  scripts\mp\spawnlogic::registerspawnset("dd_defenders", level.spawn_defenders);
  level.spawn_defenders_a = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_a");
  level.spawn_defenders_a = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_a", level.spawn_defenders_a);
  level.spawn_defenders_b = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_b");
  level.spawn_defenders_b = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_b", level.spawn_defenders_b);
  level.spawn_defenders_fallback = scripts\engine\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a, level.spawn_defenders_b);
  scripts\mp\spawnlogic::registerspawnset("dd_defenders_fallback", level.spawn_defenders_fallback);
  level.spawn_attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker");
  scripts\mp\spawnlogic::registerspawnset("dd_attackers", level.spawn_attackers);
  level.spawn_attackers_a = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_a");
  level.spawn_attackers_a = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_a", level.spawn_attackers_a);
  level.spawn_attackers_b = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_b");
  level.spawn_attackers_b = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_b", level.spawn_attackers_b);
  level.spawn_attackers_fallback = scripts\engine\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a, level.spawn_attackers_b);
  scripts\mp\spawnlogic::registerspawnset("dd_attackers_fallback", level.spawn_attackers_fallback);
  level.spawn_defenders_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
  level.spawn_attackers_start = scripts\mp\spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
}

function getspawnpointdist(var_0, var_1) {
  var_2 = getpathdist(var_0.origin, var_1, 16000);

  if(var_2 < 0) {
    var_2 = distance(var_0.origin, var_1);
  }

  return var_2;
}

function waittoprocess() {
  level endon("game_end");

  for(;;) {
    if(level.ingraceperiod == 0) {
      break;
    }

    waitframe();
  }

  level.usestartspawns = 0;
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(istrue(level.binoculars_clearuidata)) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("normal", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "fallback");
    }
  } else {
    jumpiffalse(scripts\mp\spawnlogic::shoulduseteamstartspawn()) LOC_000000e2;

    if(var_1 == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
    }

    goto LOC_000001f8;
  }

  LOC_000001f8:
    return var_1;
}

function onspawnplayer() {
  var_0 = regroup_think();

  if(scripts\mp\utility\game::inovertime() || self.pers["team"] == var_0) {
    self setclientomnvar("ui_carrying_bomb", 1);
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 1;
  } else {
    self.isplanting = 0;
    self.isdefusing = 0;
    self.isbombcarrier = 0;
  }

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);
  } else {
    scripts\mp\utility\stats::setextrascore0(0);
  }

  if(isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::setextrascore1(self.pers["defuses"]);
  } else {
    scripts\mp\utility\stats::setextrascore1(0);
  }

  level notify("spawned_player");
}

function regroup_think() {
  var_0 = game["attackers"];

  if(level.mapname == "mp_euphrates") {
    if(game["switchedsides"]) {
      var_0 = game["attackers"];
    } else {
      var_0 = game["defenders"];
    }
  }

  return var_0;
}

function hidecarryiconongameend() {
  self endon("disconnect");
  level waittill("game_ended");

  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
    return;
  }
}

function dd_endgame(var_0, var_1) {
  setomnvar("ui_bomb_interacting", 0);
  thread scripts\mp\gamelogic::endgame(var_0, var_1);
}

function ondeadevent(var_0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  if(var_0 == "all") {
    if(level.bombplanted) {
      dd_endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
      return;
    }

    dd_endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(var_0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }

    thread dd_endgame(level, game["defenders"]);
    return;
  }

  if(var_0 == game["defenders"]) {
    thread dd_endgame(level, game["attackers"]);
    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = var_0.team;

  if(var_0.isplanting) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "planting");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
  } else if(var_0.isdefusing) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "defusing");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var_1, var_0);
}

function ontimelimit() {
  if(scripts\mp\utility\game::inovertime()) {
    dd_endgame("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  dd_endgame(game["defenders"], game["end_reason"]["time_limit_reached"]);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarintvalue("bombtimer", 45, 1, 300);
  level.ddtimetoadd = scripts\mp\utility\dvars::dvarfloatvalue("extraTime", 120, 0, 500);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("overtimeLimit", 1, 0, 180);
  level.resetprogress = scripts\mp\utility\dvars::dvarintvalue("resetProgress", 1, 0, 1);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("silentPlant", 0, 0, 1);
}

function verifybombzones(var_0) {
  var_1 = "";

  if(var_0.size != 3) {
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(issubstr(tolower(var_6.script_label), "a")) {
        var_2 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "b")) {
        var_3 = 1;
        continue;
      }

      if(issubstr(tolower(var_6.script_label), "c")) {
        var_4 = 1;
      }
    }

    if(!var_2) {
      var_1 += " A ";
    }

    if(!var_3) {
      var_1 += " B ";
    }

    if(!var_4) {
      var_1 += " C ";
    }
  }

  if(var_1 != "") {
    return;
  }
}

function bombs() {
  waittillframeend();
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  var_0 = getEntArray("dd_bombzone", "targetname");
  verifybombzones(var_0);
  level.objectives = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_bombzone::setupobjective(var_2, 1);

    if(isDefined(var_3)) {
      var_3.onbeginuse = &onbeginuse;
      var_3.onenduse = &onenduse;
      var_3.onuse = &onuseplantobject;
      level.objectives[var_3.objectivekey] = var_3;
    }
  }

  initspawns();

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level.objectives) {
    var_3 scripts\mp\gameobjects::requestid(1, 1);

    if(scripts\mp\utility\game::inovertime()) {
      var_3 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target_neutral");
    } else {
      var_3 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    }

    var_3 scripts\mp\gameobjects::setvisibleteam("any");
  }
}

function onbeginuse(var_0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var_0);
}

function onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var_0, var_1, var_2);
}

function onuseplantobject(var_0) {
  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, var_0);
}

function setupkillcament() {
  var_0 = spawn("script_origin", self.origin);
  var_0.angles = self.angles;
  var_0 rotateYaw(-45, 0.05);
  waitframe();
  var_1 = self.origin + (0, 0, 5);
  var_2 = self.origin + anglesToForward(var_0.angles) * 100 + (0, 0, 128);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, self, scripts\engine\trace::create_default_contents(1));
  self.killcament = spawn("script_model", var_3["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var_0 delete();
}

function resetbombzone(var_0) {
  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gameobjects::setownerteam("neutral");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target");
  } else {
    scripts\mp\gameobjects::setownerteam(game["defenders"]);
    scripts\mp\gameobjects::allowuse("enemy");
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
  }

  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  self.id = "bomb_zone";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setvisibleteam("any");
  self.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  self.bombexploded = undefined;
}

function setupfordefusing() {
  scripts\mp\gameobjects::allowuse("friendly");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse", "waypoint_defend");
  scripts\mp\gameobjects::setvisibleteam("any");
}

function oncantuse(var_0) {
  var_0 iprintlnbold(&"MP/BOMBSITE_IN_USE");
}

function onreset() {}

function bombplanted(var_0, var_1) {
  var_0 endon("defused");
  var_2 = var_1.team;
  level.bombsplanted += 1;
  scripts\mp\gamelogic::pausetimer();
  level.timepausestart = gettime();
  level.timelimitoverride = 1;
  level.bombplanted = 1;
  level.destroyedobject = var_0;

  if(level.destroyedobject.objectivekey == "_a") {
    level.aplanted = 1;
  } else {
    level.bplanted = 1;
  }

  level.destroyedobject.bombplanted = 1;
  level.tickingobject = var_0.visuals[0];
  dropbombmodel(var_1, var_0.objectivekey);
  var_0.bombdefused = 0;
  var_0 scripts\mp\gameobjects::allowuse("none");
  var_0 scripts\mp\gameobjects::setvisibleteam("none");

  if(scripts\mp\utility\game::inovertime()) {
    var_0 scripts\mp\gameobjects::setownerteam(scripts\mp\utility\game::getotherteam(var_1.team)[0]);
  }

  setupfordefusing(var_0);
  bombtimerwait(var_0, var_0);
  thread bombhandler(var_0, var_1, "explode");
}

function bombhandler(var_0, var_1, var_2) {
  level.bombsplanted -= 1;

  if(self.objectivekey == "_a") {
    level.aplanted = 0;
  } else {
    level.bplanted = 0;
  }

  restarttimer();
  scripts\mp\gametypes\obj_bombzone::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }

  if(var_1 == "explode") {
    self.bombexploded = 1;
    var_3 = scripts\mp\utility\dvars::getwatcheddvar("timelimit");

    if(var_3 != 0 && !scripts\mp\utility\game::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0) {
      level.extratime = level.bombexploded * level.ddtimetoadd;
      var_4 = scripts\mp\gamelogic::gettimeremaining();

      if(istrue(level.timerstoppedforgamemode)) {
        var_4 -= level.bombtimer * 1000;
      }

      setgameendtime(gettime() + int(var_4));
    }

    wait 2;

    if(scripts\mp\utility\game::inovertime() || level.bombexploded > 1) {
      if(istrue(level.nukeincoming)) {
        return;
      }

      dd_endgame(var_2, game["end_reason"]["target_destroyed"]);
      return;
    }

    if(level.ddtimetoadd > 0) {
      scripts\mp\utility\dialog::statusdialog("bomb_destroyed_en", game["defenders"]);
      level thread scripts\mp\hud_message::notifyteam("callout_time_added", "callout_time_added", var_0.team);
      return;
    }

    return;
  }

  var_0 notify("bomb_defused" + self.objectivekey);
  self notify("defused");
  resetbombzone(var_0);
}

function dropbombmodel(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0.origin + (0, 0, 20), var_0.origin - (0, 0, 2000), var_0, scripts\engine\trace::create_default_contents(1));
  var_3 = randomfloat(360);
  var_4 = (cos(var_3), sin(var_3), 0);
  var_4 = vectorNormalize(var_4 - var_2["normal"] * vectordot(var_4, var_2["normal"]));
  var_5 = vectortoangles(var_4);
  level.ddbombmodel[var_1] = spawn("script_model", var_2["position"]);
  level.ddbombmodel[var_1].angles = var_5;
  level.ddbombmodel[var_1] setModel("prop_suitcase_bomb");
}

function restarttimer() {
  if(scripts\mp\utility\game::inovertime()) {
    if(level.bombexploded == 1) {
      return;
    }
  } else if(level.bombexploded > 1) {
    return;
  }

  if(level.bombsplanted <= 0) {
    scripts\mp\gamelogic::resumetimer();
    level.timepaused = gettime() - level.timepausestart;
    level.timelimitoverride = 0;
    return;
  }
}

function bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bomb_defused" + var_0.objectivekey);

  if(scripts\mp\utility\game::inovertime()) {
    var_0.waittime = level.bombtimer;
  } else {
    var_0.waittime = level.bombtimer;
  }

  thread update_ui_timers(level);

  while(var_0.waittime >= 0) {
    var_0.waittime--;

    if(var_0.waittime >= 0) {
      wait 1;
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function update_ui_timers(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("bomb_defused" + var_0.objectivekey);
  level endon("bomb_exploded" + var_0.objectivekey);
  var_1 = var_0.waittime * 1000 + gettime();
  setDvar("ui_bombtimer" + var_0.objectivekey, var_1);
  level waittill("host_migration_begin");
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    setDvar("ui_bombtimer" + var_0.objectivekey, var_1 + var_2);
    return;
  }
}

function bombdefused(var_0) {
  level.tickingobject scripts\mp\gamelogic::stoptickingsound();
  var_0.bombdefused = 1;
  level notify("bomb_defused" + var_0.objectivekey);
}

function setupobjectiveicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0);
}