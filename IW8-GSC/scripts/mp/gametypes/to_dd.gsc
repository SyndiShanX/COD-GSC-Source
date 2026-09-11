/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_dd.gsc
***********************************************/

function main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata()) {
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  }

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = &onstartgametype;
}

function maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.startedfromtacops = 1;
  onstartgametype(1);
}

function maintacopsinit() {
  level.tacopssublevel = "to_dd";
  level.currentmode = "to_dd";
  setomnvar("ui_tac_ops_submode", level.currentmode);
}

function maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("to_dd", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("to_dd", 3);
    scripts\mp\utility\game::registerscorelimitdvar("to_dd", 0);
    scripts\mp\utility\game::registerroundlimitdvar("to_dd", 1);
    scripts\mp\utility\game::registerwinlimitdvar("to_dd", 1);
    scripts\mp\utility\game::registernumlivesdvar("to_dd", 0);
    scripts\mp\utility\game::registerhalftimedvar("to_dd", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("to_dd", 0);
    scripts\mp\utility\game::setovertimelimitdvar(2);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.onprecachegametype = &onprecachegametype;
  level.modeonspawnplayer = &onspawnplayer;
  level.ondeadevent = &ondeadevent;
  level.ontimelimit = &ontimelimit;
  level.gamemodemaydropweapon = &scripts\mp\utility\game::isplayeroutsideofanybombsite;

  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = &scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.dd = 1;
  level.bombsplanted = 0;
  level.ddbombmodel = [];
  level.aplanted = 0;
  level.bplanted = 0;
  level.allowhvtspawn = 0;
  level.hvtkilled = 0;
  level.bombexplodedcount = 0;
  scripts\mp\gametypes\obj_bombzone::setbombtimeromnvars();
  game["dialog"]["gametype"] = "manhunt";

  if(getdvarint("OSMSLRTOP")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("NOSLRNTRKL")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_diehard")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint("scr_to_dd_promode")) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "";
  game["dialog"]["defense_obj"] = "";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  scripts\mp\utility\dvars::setoverridewatchdvar("timelimit", 6);
  setdynamicdvar("scr_to_dd_waverespawndelay", 20);
  setdynamicdvar("scr_to_dd_waverespawndelay_alt", 20);
  setdynamicdvar("scr_to_dd_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_to_dd_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_to_dd_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_to_dd_silentPlant", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("scr_to_dd_extratime", getmatchrulesdata("demData", "extraTime"));
  setdynamicdvar("scr_to_dd_overtimeLimit", getmatchrulesdata("demData", "overtimeLimit"));
  setdynamicdvar("scr_to_dd_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("to_dd", 0);
  setdynamicdvar("scr_to_dd_promode", 0);
  setdynamicdvar("scr_to_dd_defusetime", 5);
  setdynamicdvar("scr_to_dd_extraTime", 1);
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

function onstartgametype(var0) {
  scripts\cp_mp\utility\game_utility::getmapname();
  seticonnames();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.usestartspawns = 1;
  level.to_dd_phase_1 = 1;
  setclientnamemode("manual_change");

  if(scripts\mp\utility\game::inovertime()) {
    game["dialog"]["defense_obj"] = "obj_destroy";
  }

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

  thread waitformatchbegin();

  if(!istrue(var0)) {
    scripts\mp\gametypes\tac_ops::commoninit();
    activatespawns();
  }

  var1 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");
  GscBinSkip1(0x45, 0, "dd");
}

function createbridgecapturesite() {
  var0 = getEnt("to_dd_bridge_flag", "targetname");

  if(!isDefined(level.objectives)) {
    level.objectives = [];
  }

  level.bridgeobjectiveindex = level.objectives.size;
  level.objectives[level.bridgeobjectiveindex] = var0;
  var1 = scripts\mp\gametypes\obj_dom::setupobjective(level.objectives[level.bridgeobjectiveindex]);
  scripts\engine\utility::delaythread(3, &delayset);
  var1.onuse = &bridgedompoint_onuse;
  level.objectives[level.bridgeobjectiveindex] = var1;
  level.flagcapturetime = 10;
  level.flagneutralization = 0;
  waitframe();
  var1 scripts\mp\gameobjects::setownerteam("neutral");
  var1 scripts\mp\gameobjects::setvisibleteam("any");
  var1 scripts\mp\gameobjects::allowuse("enemy");
  var1 scripts\mp\gameobjects::cancontestclaim(1);
  var1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

function delayset() {
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setownerteam("axis");
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::allowuse("enemy");
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gametypes\obj_dom::updateflagstate("axis", 0);
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconfriendlyextract3d);
}

function bridgedompoint_onuse(var0) {
  scripts\mp\gametypes\obj_dom::dompoint_onuse(var0);

  if(var0.team == "allies") {
    level.objectives[level.bridgeobjectiveindex].onuse = &scripts\mp\gametypes\obj_dom::dompoint_onuse;
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setkeyobject(undefined);
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setvisibleteam("any");
    level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::allowuse("enemy");
    startbombphase();
    return;
  }
}

function startbombphase() {
  level.onnormaldeath = &onnormaldeath;
  iprintlnbold("Bridge Captured");
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::setmodelvisibility(0);
  level.objectives[level.bridgeobjectiveindex] scripts\mp\gameobjects::disableobject();
  level.objectives[level.bridgeobjectiveindex].scriptable setscriptablepartstate("flag", "off");
  level.to_dd_phase_1 = 0;
  scripts\mp\tac_ops_map::setactivemapconfig("to_dd", "allies");
  thread bombs();
}

function votimer() {
  wait 10;
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_enemya", "allies");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aq1_phase1_enemyb", "axis");
  scripts\mp\gametypes\tac_ops::tacopslongwaitsec(30);
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_us1_phase1_lesstimea", "allies");
  scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team("dx_mpb_aqcm_phase2_lesstime", "axis");
}

function initspawns() {
  var0 = level.tacopsspawns;
  var0.to_dd_spawns = [];
  var0.to_dd_spawns["allies_start"] = scripts\mp\spawnlogic::getspawnpointarray("mp_todd_spawn_allies_start");
  var0.to_dd_spawns["axis_start"] = scripts\mp\spawnlogic::getspawnpointarray("mp_todd_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_todd_spawn_allies");
  var0.to_dd_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray("mp_todd_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_todd_spawn_axis");
  var0.to_dd_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray("mp_todd_spawn_axis");
  scripts\mp\spawnlogic::addspawnpoints("allies_bridge", "mp_toddbridge_spawn_allies");
  var0.to_dd_spawns["allies_bridge"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toddbridge_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints("axis_bridge", "mp_toddbridge_spawn_axis");
  var0.to_dd_spawns["axis_bridge"] = scripts\mp\spawnlogic::getspawnpointarray("mp_toddbridge_spawn_axis");
}

function getspawnpointdist(var0, var1) {
  var2 = getpathdist(var0.origin, var1, 16000);

  if(var2 < 0) {
    var2 = distance(var0.origin, var1);
  }

  return var2;
}

function getspawnpoint() {
  var0 = level.tacopsspawns;
  var1 = self.pers["team"];

  if(level.usestartspawns && !isDefined(self.tacopsmapselectedarea)) {
    var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var0.to_dd_spawns[var1 + "_start"]);
  } else {
    jumpiffalse(istrue(level.to_dd_phase_1)) LOC_00000075;
    var3 = var2 + "_bridge";
    var4 = var1.to_dd_spawns[var3];
    var4 = scripts\mp\tac_ops_map::filterspawnpoints(var4);
    var2 = undefined;
    goto LOC_0000008c;
  }

  return var2;
}

function activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("TDM");
  thread usetacopsmapongamestart();
  level.getspawnpoint = &getspawnpoint;
}

function usetacopsmapongamestart() {
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\tac_ops_map::setactivemapconfig("to_dd", "axis");
  scripts\mp\tac_ops_map::setactivemapconfig("dirttown_allies_bridge", "allies");
}

function waitforhvtrelease() {
  level endon("dd_phase_ended");
  level endon("game_end");
  scripts\mp\gametypes\tac_ops::tacopslongwaitsec(45);
  scripts\mp\gametypes\tac_ops::teamprint(&"MISC_MESSAGES_MP/TO_ALLY_DD_ESCAPE_1", &"MISC_MESSAGES_MP/TO_AXIS_DD_ESCAPE_1");

  if(level.hvtlabel == "_a") {
    level.extractionpos = scripts\engine\utility::getStructArray("hostage_extraction_a", "targetname")[0].origin;
  } else {
    level.extractionpos = scripts\engine\utility::getStructArray("hostage_extraction_b", "targetname")[0].origin;
  }

  level.ddlz = spawn("trigger_radius", level.extractionpos, 0, 90, 128);
  level.ddlz.angles = (0, 0, 0);
  level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue("bankCaptureTime", 0, 0, 10);
  level.ddlz.useobj = scripts\mp\gametypes\obj_grindzone::setupobjective(0, "allies", level.ddlz);
  level.ddlz.team = "allies";
  level.ddlz.ownerteam = "allies";
  level.ddlz.visibleteam = "any";
  level.ddlz.useobj scripts\mp\gametypes\to_hstg::updateextracticons();
  level.ddlz.useobj scripts\mp\gameobjects::setvisibleteam("none");
  level.ddlz.offset3d = (0, 0, 16);
  scripts\mp\gametypes\to_hstg::makelzextractionvisuals(level.ddlz);
  level.ddlz.location = level.extractionpos;

  if(scripts\mp\utility\teams::getteamdata("axis", "teamCount")) {
    level.topplayers = scripts\engine\utility::array_sort_with_func(scripts\mp\utility\teams::getteamdata("axis", "players"), &compare_player_score);
    var0 = level.topplayers[0] scripts\mp\gametypes\to_hstg::spawnextractchopper(level.ddlz, 30);
    level.ddlz thread scripts\mp\gametypes\to_hstg::extractvehicledeathwatcher();
    thread waitdoextraction();
    return;
  }
}

function compare_player_score(var0, var1) {
  return var0.score >= var1.score;
}

function waitdoextraction() {
  level endon("dd_phase_ended");
  scripts\mp\gametypes\tac_ops::tacopslongwaitsec(15);
  scripts\mp\gametypes\tac_ops::teamprint(&"MISC_MESSAGES_MP/TO_ALLY_DD_ESCAPE_2", &"MISC_MESSAGES_MP/TO_AXIS_DD_ESCAPE_2");

  foreach(var1 in level.objectives) {
    removedoorcollision(var1.objectivekey);
  }

  foreach(var1 in level.objectives) {
    if(isDefined(var1.ondisableobjective)) {
      var1[[var1.ondisableobjective]]();
    }
  }

  level.to_ddhvt.invulnerable = 0;
  thread hvtmovetoextractpt();
  scripts\mp\gametypes\tac_ops::tacopslongwaitsec(1);

  if(isDefined(level.to_ddhvt)) {
    scripts\mp\tac_ops\hvt_utility::hvtcleanup(level.to_ddhvt);
  }

  level.ddlz scripts\mp\gametypes\to_hstg::cleanuplzvisuals();
  self notify("extract_hostages");
}

function hvtmovetoextractpt() {
  level endon("dd_phase_ended");
  level endon("game_end");
  self endon("death");
  self botsetscriptgoal(level.extractionpos, 20, "critical");
  var0 = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
}

function waitformatchbegin() {
  level endon("game_end");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.usestartspawns = 0;
}

function onspawnplayer() {
  if(scripts\mp\utility\game::inovertime() || self.pers["team"] == game["attackers"]) {
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
  var0 = 0;

  if(self.team == "allies") {
    var0 = 1;
  } else if(self.team == "axis") {
    var0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var0);

  if(!isagent(self)) {
    scripts\mp\playerlogic::incrementalivecount(self.team);
  }

  scripts\mp\tac_ops\roles_utility::kitspawn();
}

function dd_endgame(var0, var1) {
  thread scripts\mp\gamelogic::endgame(var0, var1);
}

function ondeadevent(var0) {
  if(level.bombexploded > 0 || level.bombdefused) {
    return;
  }

  if(var0 == "all") {
    if(level.bombplanted) {
      dd_endgame(game["attackers"], game["end_reason"][game["defenders"] + "_eliminated"]);
      return;
    }

    dd_endgame(game["defenders"], game["end_reason"][game["attackers"] + "_eliminated"]);
    return;
  }

  if(var0 == game["attackers"]) {
    if(level.bombplanted) {
      return;
    }

    thread dd_endgame(level, game["defenders"]);
    return;
  }

  if(var0 == game["defenders"]) {
    thread dd_endgame(level, game["attackers"]);
    return;
  }
}

function onnormaldeath(var0, var1, var2, var3, var4) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4);
  var5 = var0.team;

  if(var0.isplanting) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var2, "planting");
    var1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
  } else if(var0.isdefusing) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var2, "defusing");
    var1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
  }

  scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals(var1, var0);

  if(!isagent(var0)) {
    if(!isDefined(var0.switching_teams)) {
      var0 scripts\mp\playerlogic::decrementalivecount(var0.team);
      return;
    }

    return;
  }
}

function ontimelimit() {
  foreach(var1 in level.objectives) {
    if(isDefined(var1.ondisableobjective)) {
      var1[[var1.ondisableobjective]]();
    }
  }

  if(isDefined(level.onphaseend)) {
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    [[level.onphaseend]]("axis");
    return;
  }
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 5, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 5, 0, 20);
  level.bombtimer = scripts\mp\utility\dvars::dvarintvalue("bombtimer", 30, 1, 300);
  level.ddtimetoadd = scripts\mp\utility\dvars::dvarfloatvalue("extraTime", 2, 0, 5);
  level.overtime = scripts\mp\utility\dvars::dvarfloatvalue("overtimeLimit", 1, 0, 5);
  scripts\mp\utility\game::setovertimelimitdvar(level.overtime);
  level.silentplant = scripts\mp\utility\dvars::dvarintvalue("silentPlant", 0, 0, 1);
}

function verifybombzones(var0) {
  var1 = "";

  if(var0.size != 3) {
    var2 = 0;
    var3 = 0;
    var4 = 0;

    foreach(var6 in var0) {
      if(issubstr(tolower(var6.script_label), "a")) {
        var2 = 1;
        continue;
      }

      if(issubstr(tolower(var6.script_label), "b")) {
        var3 = 1;
        continue;
      }

      if(issubstr(tolower(var6.script_label), "c")) {
        var4 = 1;
      }
    }

    if(!var2) {
      var1 += " A ";
    }

    if(!var3) {
      var1 += " B ";
    }

    if(!var4) {
      var1 += " C ";
    }
  }

  if(var1 != "") {
    return;
  }
}

function initbombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  level.multibomb = 1;
  level.objectives = [];
}

function bombs() {
  var0 = getEntArray("dd_bombzone", "targetname");

  if(var0.size == 0) {
    return;
  }

  wait 0.5;
  var1 = [];

  foreach(var3 in var0) {
    var4 = scripts\mp\gametypes\obj_bombzone::setupobjective(var3);
    var4.onbeginuse = &onbeginuse;
    var4.onenduse = &onenduse;
    var4.onuse = &onuseplantobject;
    var4.ondisableobjective = &bombzone_ondisableobjective;
    level.objectives[var4.objectivekey] = var4;
  }
}

function onbeginuse(var0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse(var0);
}

function onenduse(var0, var1, var2) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(var0, var1, var2);
}

function onuseplantobject(var0) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject(var0);
}

function resetbombzone() {
  if(scripts\mp\utility\game::inovertime()) {
    scripts\mp\gameobjects::setownerteam("neutral");
    scripts\mp\gameobjects::allowuse("any");
    var0 = "waypoint_target_b";
    var1 = "waypoint_target_b";
  } else {
    scripts\mp\gameobjects::allowuse("enemy");
    var0 = "waypoint_defend" + self.label;
    var1 = "waypoint_target" + self.label;
  }

  self.id = "bomb_zone";
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  scripts\mp\gameobjects::setobjectivestatusicons(var0, var1);
  scripts\mp\gameobjects::setvisibleteam("any");
  self.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  self.bombexploded = undefined;
}

function bombhandler(var0, var1, var2) {
  level.bombsplanted -= 1;

  if(self.label == "_a") {
    level.aplanted = 0;
  } else {
    level.bplanted = 0;
  }

  scripts\mp\gametypes\obj_bombzone::setbombtimeromnvars();

  if(level.gameended) {
    return;
  }

  if(var1 == "explode") {
    self.bombexploded = 1;
    scripts\mp\utility\dialog::statusdialog("enemy_ident", game["defenders"], 1);
    scripts\mp\utility\dialog::statusdialog("target_ident", game["attackers"], 1);

    foreach(var4 in level.objectives) {
      removedoorcollision(var4.objectivekey);

      if(isDefined(var4.ondisableobjective)) {
        var4[[var4.ondisableobjective]]();
      }
    }

    wait 2;
    restarttimer();

    if(level.ddtimetoadd > 0) {
      level thread scripts\mp\hud_util::teamplayercardsplash("callout_time_added", var0);
    }

    waitframe();
    level.bombexplodedcount++;

    if(level.bombsplanted == 1) {
      level notify("bombs_canceled");
    }

    restarttimer();
    level.bombsplanted -= 1;
    setomnvar("ui_bomb_planted_a", 0);
    setomnvar("ui_bomb_planted_b", 0);
    scripts\mp\gametypes\tac_ops::extendtacopstimelimitms(30000);

    if(isDefined(level.onphaseend) && level.bombexplodedcount == 1) {
      [[level.onphaseend]]("allies");
      return;
    }

    return;
  }

  restarttimer();
  var0 notify("bomb_defused" + self.label);
  self notify("defused");
  resetbombzone();
}

function removedoorcollision(var0) {
  var1 = getEnt("dd_bombzone_clip" + var0, "targetname");
  var1 delete();
}

function restarttimer() {
  scripts\mp\gametypes\tac_ops::resumetacopstimer();

  if(level.bombsplanted <= 0) {
    level.timelimitoverride = 0;
    return;
  }
}

function bombzone_ondisableobjective() {
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");
}

function seticonnames() {
  level.icontarget = "waypoint_hardpoint_target";
  level.iconneutral = "koth_neutral";
  level.iconcapture = "koth_enemy";
  level.icondefend = "koth_friendly";
  level.iconcontested = "waypoint_hardpoint_contested";
  level.icontaking = "waypoint_taking_chevron";
  level.iconlosing = "waypoint_hardpoint_losing";
  level.iconbombcapture = "waypoint_target";
  level.iconbombdefend = "waypoint_defend";
  level.iconescort = "waypoint_escort";
}

function setupkillcament() {
  var0 = spawn("script_origin", self.origin);
  var0.angles = self.angles;
  var0 rotateYaw(-45, 0.05);
  waitframe();
  var1 = self.origin + (0, 0, 5);
  var2 = self.origin + anglesToForward(var0.angles) * 100 + (0, 0, 128);
  var3 = scripts\engine\trace::ray_trace(var1, var2, self, scripts\engine\trace::create_default_contents(1));
  self.killcament = spawn("script_model", var3["position"]);
  self.killcament setscriptmoverkillcam("explosive");
  var0 delete();
}