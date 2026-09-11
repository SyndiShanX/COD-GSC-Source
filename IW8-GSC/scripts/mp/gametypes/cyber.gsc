/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cyber.gsc
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
  setdynamicdvar("scr_cyber_empspawn", getmatchrulesdata("cyberData", "empSpawn"));
  setdynamicdvar("scr_cyber_radarpingtime", getmatchrulesdata("cyberData", "radarPingTime"));
  setdynamicdvar("scr_cyber_persbombtimer", getmatchrulesdata("cyberData", "persBombTimer"));
  setdynamicdvar("scr_cyber_detonatescore", getmatchrulesdata("cyberData", "detonateScore"));
  setdynamicdvar("scr_cyber_enemydeathloc", getmatchrulesdata("commonOption", "enemyDeathLoc"));
  setdynamicdvar("scr_cyber_bombtimer", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("scr_cyber_planttime", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("scr_cyber_defusetime", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("scr_cyber_multibomb", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("scr_cyber_showEnemyCarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_cyber_idleResetTime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_cyber_pickupTime", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("scr_cyber_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("cyber", 0);
}

function waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("prematch_done");
  level.overrideingraceperiod = 1;
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

function onstartgametype() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  setclientnamemode("manual_change");
  level._effect["emp_detonation"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_main_blast.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::setobjectivetext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::setobjectivetext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::setobjectivescoretext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::setobjectivescoretext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::setobjectivehinttext(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::setobjectivehinttext(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  cyberattack();
  initspawns();
  thread ref_13862();
  thread waittooverridegraceperiod();
  setupwaypointicons();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.empspawnindex = scripts\mp\utility\dvars::dvarintvalue("empSpawn", 0, 0, 4);
  level.radarpingtime = 4;
  level.persbombtimer = scripts\mp\utility\dvars::dvarintvalue("persBombTimer", 0, 0, 1);
  level.detonatescore = scripts\mp\utility\dvars::dvarintvalue("detonateScore", 1, 0, 5);
  level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue("bombtimer", 30, 1, 300);
  level.planttime = scripts\mp\utility\dvars::dvarfloatvalue("planttime", 1, 0, 20);
  level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue("defusetime", 1, 0, 20);
  level.multibomb = scripts\mp\utility\dvars::dvarintvalue("multibomb", 0, 0, 1);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 0, 0, 60);
  level.pickuptime = scripts\mp\utility\dvars::dvarfloatvalue("pickupTime", 0, 0, 10);
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_cyber_spawn_allies");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_cyber_spawn_axis");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_allies");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_axis");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var_0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var_1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_ctf_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_ctf_spawn");

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    assignteamspawns();
    level.introcinematic["allies"] = "allies";
    level.introcinematic["axis"] = "axis";
    scripts\mp\spawnlogic::registerspawnset("allies", level.teamspawnpoints["allies"]);
    scripts\mp\spawnlogic::registerspawnset("axis", level.teamspawnpoints["axis"]);
    scripts\mp\spawnlogic::registerspawnset("neutral", level.teamspawnpoints["neutral"]);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

function getspawnpoint() {
  scripts\mp\spawnlogic::setactivespawnlogic("StartSpawn", "Crit_Default");
  var_0 = self.pers["team"];

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
      }
    } else {
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, level.introcinematic[var_1], "neutral");
    }
  } else if(var_1 == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_1, undefined, "start_defenders");
  }

  return var_1;
}

function assignteamspawns() {
  level.spawnnodetype = "mp_ctf_spawn";
  var_0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.objectives.size == 2) LOC_0000022a;
  var_2 = level.objectives["axis"];
  var_3 = level.objectives["allies"];
  var_4 = (var_2.curorigin[0], var_2.curorigin[1], 0);
  var_5 = (var_3.curorigin[0], var_3.curorigin[1], 0);
  var_6 = var_5 - var_4;
  var_7 = length2d(var_6);

  foreach(var_9 in var_0) {
    var_10 = (var_9.origin[0], var_9.origin[1], 0);
    var_11 = var_10 - var_4;
    var_12 = vectordot(var_11, var_6);
    var_13 = var_12 / var_7 * var_7;

    if(var_13 < 0.33) {
      var_9.teambase = var_2.ownerteam;
      level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
      continue;
    }

    if(var_13 > 0.67) {
      var_9.teambase = var_3.ownerteam;
      level.teamspawnpoints[var_9.teambase][level.teamspawnpoints[var_9.teambase].size] = var_9;
      continue;
    }

    var_14 = undefined;
    var_15 = undefined;

    if(var_1) {
      var_14 = getpathdist(var_9.origin, var_2.curorigin, 999999);
    }

    if(isDefined(var_14) && var_14 != -1) {
      var_15 = getpathdist(var_9.origin, var_3.curorigin, 999999);
    }

    if(!isDefined(var_15) || var_15 == -1) {
      var_14 = distance2d(var_2.curorigin, var_9.origin);
      var_15 = distance2d(var_3.curorigin, var_9.origin);
    }

    var_16 = max(var_14, var_15);
    var_17 = min(var_14, var_15);
    var_18 = var_17 / var_16;

    if(var_18 > 0.5) {
      level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var_9;
    }
  }

  return;
}

function reset_doors(var_0) {
  var_1 = scripts\mp\spawnlogic::ispathdataavailable();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.objectives) {
    var_6 = undefined;

    if(var_1) {
      var_6 = getpathdist(var_0.origin, var_5.curorigin, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5.curorigin, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return scripts\mp\utility\game::getotherteam(var_2.ownerteam)[0];
}

function cyberattack() {
  var_0 = getEntArray("cyber_emp_pickup_trig", "targetname");

  if(var_0.size == 0) {
    scripts\engine\utility::error("No cyber_emp_pickup_trig triggers found in map. Please bug this to the level designer.");
    return;
  }

  if(level.empspawnindex == 3) {
    if(isDefined(game["empSpawn"])) {
      var_1 = [0, 1, 2];
      var_1 = scripts\engine\utility::array_remove(var_1, game["empSpawn"]);
      level.empspawnindex = scripts\engine\utility::random(var_1);
      game["empSpawn"] = level.empspawnindex;
    } else {
      level.empspawnindex = randomintrange(0, 3);
      game["empSpawn"] = level.empspawnindex;
    }
  }

  if(level.empspawnindex == 4) {
    if(isDefined(game["empSpawn"])) {
      level.empspawnindex = game["empSpawn"] + 1;

      if(level.empspawnindex == 3) {
        level.empspawnindex = 0;
      }

      game["empSpawn"] = level.empspawnindex;
    } else {
      level.empspawnindex = 0;
      game["empSpawn"] = level.empspawnindex;
    }
  }

  var_2 = var_0[level.empspawnindex];
  var_3 = getEntArray("cyber_emp", "targetname");
  GscBinSkip1(0x45, 0, var_3[level.empspawnindex]);
}

function ref_13862() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
  }

  level.objectives["allies"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["allies"] scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("any");
  level.objectives["axis"] scripts\mp\gameobjects::requestid(1, 1);
  level.objectives["axis"] scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("any");
  thread hidebombsitesaftermatchstart();
  level.cyberemp scripts\mp\gameobjects::requestid(1, 1);
  level.cyberemp scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp");
  level.cyberemp scripts\mp\gameobjects::ref_13172("mlg_icon_waypoint_emp_planted");
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(level.cyberemp.visuals[0])) {
    level.cyberemp.visuals[0] scripts\mp\gametypes\obj_bombzone::setteaminhuddatafromteamname("neutral");
    level.cyberemp.visuals[0] setasgametypeobjective();
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.cyberemp.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.cyberemp.objidnum, 0);
  hastacvis(level.cyberemp.objidnum, 1);
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.cyberemp.pingobjidnum = var_0;
  scripts\mp\objidpoolmanager::objective_add_objective(var_0, "done", level.cyberemp.origin);
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none", var_0);
  objective_setownerteam(var_0, undefined);
  level.cyberemp scripts\mp\gameobjects::ref_1317f("icon_waypoint_escort_emp", "waypoint_capture_kill", "mlg_icon_waypoint_emp_planted", var_0);
  setcarriervisibility();
}

function hidebombsitesaftermatchstart() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["allies"].objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.objectives["axis"].objidnum, 0);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["axis"].objidnum, 1);
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
}

function emptriggerholdonuse(var_0) {}

function createbombzone(var_0, var_1, var_2) {
  var_3 = getEntArray(var_1.target, "targetname");
  var_3[0].origin = var_1.origin;
  var_4 = scripts\mp\gameobjects::createuseobject(var_0, var_1, var_3, (0, 0, 64), undefined, 1);
  var_4.onuse = &onuse;
  var_4.onbeginuse = &onbeginuse;
  var_4.onenduse = &onenduse;
  var_4.oncantuse = &oncantuse;
  var_4.useweapon = getcompleteweaponname("emp_bomb_mp");
  var_4.id = "bomb_zone";
  var_4.trigger setusepriority(-3);
  var_4.trigger setuseholdduration("duration_none");
  var_4.trigger setusehideprogressbar(1);
  var_4.bombplanted = 0;
  var_4.bombexploded = undefined;
  var_4 scripts\mp\gameobjects::setusetime(level.planttime);
  var_4 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_4.objectivekey = "_" + var_0;
  var_4.label = var_4.objectivekey;
  resetbombsite(var_4, 1, undefined, 1);
  var_4 scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  var_4 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(isDefined(var_3[var_5].script_exploder)) {
      var_4.exploderindex = var_3[var_5].script_exploder;
      thread setupkillcament(var_3[var_5]);
      break;
    }
  }

  var_4.noweapondropallowedtrigger = spawn("trigger_radius", var_4.trigger.origin, 0, 140, 100);
  var_4.defusetrig = var_2;
  return var_4;
}

function setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateYaw(-45, 0.05);
  waitframe();
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["position"];
  self.killcament = spawn("script_model", var_2);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

function empsitewatcher() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup");

    if(level.cyberemp.carrier.team == "allies") {
      setupforplanting(level.objectives["axis"]);
    } else {
      setupforplanting(level.objectives["allies"]);
    }

    waitframe();
  }
}

function data_center_sfx_loop() {
  var_0 = scripts\engine\utility::spawn_script_origin(self.trigger.origin, self.trigger.angles);
  var_0 thread scripts\engine\utility::play_loop_sound_on_entity("data_center_cyber_lp");
  level waittill("emp_detonated");
  var_0 stopsounds("data_center_cyber_lp");
  waitframe();
  var_0 delete();
}

function onbeginuse(var_0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"]) && !level.bombplanted) {
    var_0.isplanting = 1;
    setomnvar("ui_bomb_interacting", 1);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_emp_planting");
  } else {
    var_0.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    scripts\mp\utility\game::setmlgannouncement(2, var_0.team, var_0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var_0.team);
  }

  thread allowedwhileplanting(var_0);

  if(level.bombplanted && !scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    var_0.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    setomnvar("ui_bomb_defuser", var_0 getentitynumber());

    if(isDefined(level.cyberemp.visuals[0])) {
      level.cyberemp.visuals[0] hide();
    }

    thread startnpcbombusesound(var_0, "briefcase_bomb_defuse_mp");
    return;
  }
}

function allowedwhileplanting(var_0) {
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);

  if(var_0) {
    scripts\engine\utility::ref_143b9(0.8, "bomb_allow_offhands");
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  } else {
    scripts\common\utility::allow_melee(var_0);
    scripts\common\utility::allow_mantle(var_0);
  }

  scripts\common\utility::allow_offhand_weapons(var_0);
}

function onenduse(var_0, var_1, var_2) {
  var_3 = self.objidnum;
  scripts\mp\objidpoolmanager::objective_set_progress(var_3, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);

  if(!var_2) {
    if(var_1.isdefusing) {
      scripts\mp\gameobjects::ref_1317f("icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt", "mlg_icon_waypoint_emp_planted");
    } else {
      scripts\mp\gameobjects::ref_1317f("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite", "mlg_icon_waypoint_emp_planted");
    }

    if(isDefined(self.radialtimeobjid)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var_1.team);
    }

    var_1 scripts\mp\utility\inventory::switchtolastweapon();
  }

  var_1.isplanting = 0;
  var_1.isdefusing = 0;
  setomnvar("ui_bomb_defuser", -1);

  if(!isDefined(var_1)) {
    return;
  }

  thread allowedwhileplanting(var_1);
  var_1.bombplantweapon = undefined;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_bomb_planting_defusing = undefined;
  }

  if(!scripts\mp\gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(isDefined(level.cyberemp) && !var_2) {
      level.cyberemp.visuals[0] show();
      return;
    }

    return;
  }
}

function startnpcbombusesound(var_0, var_1) {
  self endon("death");
  self endon("stopNpcBombSound");
  jumpiffalse(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) LOC_00000040;
  self setentitysoundcontext("silent_plant", "on");
  return;
}

function onpickup(var_0, var_1, var_2) {
  level notify("bomb_pickup");
  var_3 = var_0 getcurrentprimaryweapon();

  if(isDefined(var_3.basename) && var_3.basename == "iw8_lm_dblmg_mp") {
    var_0 notify("switched_from_minigun");
  }

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var_2) && !var_0 scripts\mp\utility\killstreak::isjuggernaut() && !isbot(var_0)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_cyberemp_mp");
  }

  thread empradarwatcher();
  setomnvar("ui_bomb_carrier", var_0 getentitynumber());
  var_0 setclientomnvar("ui_emp_carrier_hud", 1);
  scripts\mp\utility\game::setmlgannouncement(16, var_0.team, var_0 getentitynumber());

  if(self.firstpickup) {
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("emp_grab");
  }

  level.usestartspawns = 0;
  var_4 = var_0.pers["team"];

  if(var_4 == "allies") {
    var_5 = "axis";
  } else {
    var_5 = "allies";
  }

  var_1.isbombcarrier = 1;

  if(level.codcasterenabled) {
    var_1 setgametypevip(1);
  }

  if(!isDefined(var_3)) {
    if(self.firstpickup) {
      var_6 = "emppickup_friendly_first";
      self.firstpickup = 0;
    } else {
      var_6 = "emppickup_friendly";
    }

    scripts\mp\utility\dialog::leaderdialog(var_6, var_5, "bomb");
    scripts\mp\utility\dialog::leaderdialog("emppickup_enemy", var_6, "bomb");
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], var_5);
    var_7 = scripts\mp\utility\teams::getteamdata(var_2.team, "players");
    level thread scripts\mp\hud_message::notifyteam("emp_pickup", "emp_pickup_enemy", var_2.team, var_7);
    var_2 thread scripts\mp\hud_message::showsplash("emp_pickup");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_emppickup", var_2, var_2.team, undefined, 1);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_2.team, 5, 6, var_2, 2);
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setownerteam(var_5);
  scripts\mp\gameobjects::allowuse("none");

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "done");
    } else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_escort_emp", "waypoint_capture_kill");
  level.objectives[var_5] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives[var_6] scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["axis"].objidnum, 0);
  var_2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var_2.origin);
}

function ondrop(var_0) {
  setomnvar("ui_bomb_carrier", -1);

  if(level.bombplanted) {
    scripts\mp\gameobjects::setownerteam(var_0.team);
    scripts\mp\gameobjects::allowuse("none");
    return;
  }

  foreach(var_2 in level.objectives) {
    resetbombsite(var_2, 1);
  }

  scripts\mp\gameobjects::allowuse("any");
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp", "icon_waypoint_emp");
  scripts\mp\gameobjects::setownerteam("neutral");
  scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(var_0)) {
    scripts\mp\utility\print::printonteamarg(&"MP/EXPLOSIVES_DROPPED_BY", scripts\mp\gameobjects::getownerteam(), var_0);
  }

  scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], scripts\mp\gameobjects::getownerteam());
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 1, 1);

  if(level.idleresettime > 0) {
    thread returnaftertime();
    return;
  }
}

function returnaftertime() {
  level endon("bomb_pickup");
  var_0 = 0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "neutral") {
      var_0 += level.framedurationseconds;
    }
  }

  foreach(var_2 in level.teamnamelist) {
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], var_2);
  }

  scripts\mp\gameobjects::returnhome();
}

function onuse(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"]) && !level.bombplanted) {
    thread empjamandrumbleclients(level);
    setomnvar("ui_bomb_timer_endtime_a", int(scripts\mp\gamelogic::gettimeremaining()) + gettime());
    level notify("bomb_planted");
    var_0 notify("bomb_planted");
    var_0 notify("objective", "plant");
    var_0 playSound("mp_bomb_plant");
    scripts\mp\utility\game::setmlgannouncement(15, var_0.team, var_0 getentitynumber());
    var_3 = [];
    GscBinSkip0(0x2e, var_3.size, var_0, 0);
  }

  var_1 notify("bomb_defused");
  var_1 notify("objective", "defuse");
  var_4 = 0;

  if(scripts\mp\utility\teams::getenemycount(var_1.team, 1) == 0) {
    var_4 = 1;
  }

  if(var_4) {
    var_5 = "empdefused_final_friendly";
    var_6 = "empdefused_final_enemy";
  } else {
    var_5 = "empdefused_friendly";
    var_6 = "empdefused_enemy";
  }

  scripts\mp\utility\dialog::leaderdialog(var_5, var_3);
  scripts\mp\utility\dialog::leaderdialog(var_6, var_4);
  var_5 = [];
  var_5 = var_3;
  level thread scripts\mp\hud_message::notifyteam("emp_defuse", "emp_defuse_enemy", var_3.team, var_5);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_empdefused", var_3, undefined, undefined, 1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_3.team, 5, 6, var_3, 2);

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
    var_3 thread scripts\mp\rank::scoreeventpopup("ninja_defuse");
    var_3 thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
  } else {
    var_3 thread scripts\mp\rank::scoreeventpopup("defuse");
    var_3 thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
  }

  var_3 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse");
  var_3 scripts\mp\utility\stats::incpersstat("defuses", 1);
  var_3 scripts\mp\persistence::statsetchild("round", "defuses", var_3.pers["defuses"]);
  var_3 scripts\cp\vehicles\vehicle_compass_cp::ref_1201f();
  var_3 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "defuse", var_3.origin);
  level.bombplanted = 0;
  thread bombdefused(level);
  resetbombsite(1, var_3);

  if(var_6) {
    wait 3;
  }

  level.cyberemp scripts\mp\gameobjects::allowuse("any");
  level.cyberemp scripts\mp\gameobjects::setpickedup(var_3, 0, 1);
}

function empjamandrumbleclients(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 setempjammed(1);

    if(istrue(var_0)) {
      var_3 playrumbleonpositionforclient("artillery_rumble", var_3.origin);
    }
  }

  if(!istrue(var_1)) {
    wait 1;

    foreach(var_3 in level.players) {
      var_3 setempjammed(0);
    }

    return;
  }
}

function resetbombsite(var_0, var_1, var_2) {
  if(!var_0) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_planted_empsite", "icon_waypoint_target_empsite");
    scripts\mp\gameobjects::setvisibleteam("any");
    return;
  }

  if(istrue(var_2)) {
    return;
  }

  if(isDefined(var_1)) {
    self.ownerteam = var_1.team;
  }

  self.id = "bomb_zone";
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["allies"].objidnum, 1);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["axis"].objidnum, 1);
}

function setupforplanting() {
  self.trigger enableplayeruse(level.cyberemp.carrier);
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.planttime);
  scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EMP");
  scripts\mp\gameobjects::setkeyobject(level.cyberemp);
  self.useweapon = getcompleteweaponname("emp_bomb_mp");
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  self.bombplanted = 0;
}

function setupfordefusing(var_0, var_1) {
  self.trigger setusepriority(-3);
  self.ownerteam = var_1.team;
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setusetext(&"MP/DEFUSING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EMP");
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt");
  thread scripts\mp\gametypes\obj_bombzone::current_carrier(var_1.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite");
  scripts\mp\gameobjects::setvisibleteam("any", self.radialtimeobjid);
  self.id = "defuse_object";
  self.bombplanted = 1;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_1.team);
  var_3 = var_2[0];

  foreach(var_5 in scripts\mp\utility\teams::getteamdata(var_3, "players")) {
    self.trigger enableplayeruse(var_5);
  }
}

function bombdefused(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level.timelimitoverride = 0;
  level.scorelimitoverride = 0;
  var_0.bombplanted = 0;
  setomnvar("ui_bomb_owner_team", -1);
  level thread[[level.updategameevents]]();
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  level notify("bomb_defused");
}

function oncantuse(var_0) {}

function bombplanted(var_0, var_1) {
  level endon("overtime");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("ui_match_timer_stopped", 0);
  level.bombplantedteam = var_1;
  level.timelimitoverride = 1;
  level.scorelimitoverride = 1;

  if(isDefined(var_1)) {
    if(var_1 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  setgameendtime(int(gettime() + level.bombtimer * 1000));
  var_0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  var_2 = gettime();
  thread bomb_pre_exp_music();
  thread bomb_pre_exp_sfx_wait(var_0.visuals[0].origin);
  bombtimerwait();
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();

  if(!level.bombplanted) {
    if(level.persbombtimer) {
      var_3 = (gettime() - var_2) / 1000;
      level.bombtimer -= var_3;
    }

    return;
  }

  var_4 = var_0.visuals[0].origin;
  level.bombexploded = 1;
  setDvar("ui_danger_team", "BombExploded");

  if(isDefined(level.bombowner)) {
    var_0.visuals[0] radiusdamage(var_4, 512, 1, 1, level.bombowner, "MOD_EXPLOSIVE", "bomb_site_mp");
    level.bombowner scripts\mp\utility\stats::incpersstat("destructions", 1);
    level.bombowner scripts\mp\persistence::statsetchild("round", "destructions", level.bombowner.pers["destructions"]);
  } else {
    var_0.visuals[0] radiusdamage(var_4, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  var_5 = randomfloat(360);
  playsoundatpos(var_4, "exp_cyber_emp_close");
  var_6 = var_0.visuals[0] gettagorigin("tag_origin");
  var_7 = spawnfx(level._effect["emp_detonation"], var_6, (0, 0, 1), (cos(var_5), sin(var_5), 0));
  triggerfx(var_7);
  earthquake(0.6, 1.5, var_4, 10000);
  thread empjamandrumbleclients(level, 1);
  level notify("emp_detonated");

  foreach(var_9 in level.objectives) {
    var_9 notify("disabled");
    var_9.trigger scripts\mp\utility\usability::setallunusable();
  }

  if(game["switchedsides"]) {
    var_0.exploderindex = 200;
  } else {
    var_0.exploderindex = 201;
  }

  if(isDefined(var_0.exploderindex)) {
    scripts\engine\utility::exploder(var_0.exploderindex);
  }

  var_0.bombplanted = 0;
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["allies"] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives["axis"] scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["axis"].objidnum, 0);
  setgameendtime(0);
  level.scorelimitoverride = 1;

  if(isDefined(level.bombowner)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_destroyed_cyberbombsite", level.bombowner);
  }

  var_0 scripts\mp\gameobjects::releaseid();

  if(istrue(level.nukeincoming)) {
    return;
  }

  wait 3;
  thread scripts\mp\gamelogic::endgame(var_1, game["end_reason"]["target_destroyed"], undefined, undefined, level.detonatescore);
}

function bombtimerwait() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  var_0 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var_0);
  thread handlehostmigration(level);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function bomb_pre_exp_music() {
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

function bomb_pre_exp_sfx_wait(var_0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  wait max(level.bombtimer - 2, 0.1);
  playsoundatpos(var_0, "exp_cyber_emp_preexplode");
}

function handlehostmigration(var_0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    setomnvar("ui_bomb_timer_endtime", var_0 + var_1);
    return;
  }
}

function overtimethread(var_0) {
  level endon("game_ended");
  level.inovertime = 1;
  wait 5;
  level.disablespawning = 1;
}

function givelastonteamwarning() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

function ontimelimit() {
  if(level.bombexploded) {
    return;
  }

  trial_race_lap_total();
  thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["cyber_tie"]);
}

function onspawnplayer() {
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_match_status_hint_text", -1);

  if(level.multibomb) {
    self setclientomnvar("ui_emp_carrier_hud", 1);
  } else {
    self setclientomnvar("ui_emp_carrier_hud", 0);
    thread updatebombsiteusability();
  }

  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;

  if(scripts\mp\utility\game::inovertime() && !isDefined(self.otspawned)) {
    thread printothint();
  }

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::setextrascore0(self.pers["plants"]);
  }

  if(isDefined(self.pers["rescues"])) {
    scripts\mp\utility\stats::setextrascore1(self.pers["rescues"]);
  }

  thread updatematchstatushintonspawn();
}

function updatebombsiteusability() {
  if(!isDefined(level.objectives)) {
    level waittill("enable_player_usability");
  }

  foreach(var_1 in level.objectives) {
    if(var_1.bombplanted == 0) {
      var_1.trigger disableplayeruse(self);
    }
  }
}

function updatematchstatushintonspawn() {
  if(level.bombplanted) {
    if(isDefined(level.bombplantedteam) && level.bombplantedteam == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 4);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 3);
    return;
  }

  if(isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier)) {
    if(level.cyberemp.carrier.team == self.team) {
      if(level.cyberemp.carrier == self) {
        self setclientomnvar("ui_match_status_hint_text", 2);
        return;
      }

      self setclientomnvar("ui_match_status_hint_text", 5);
      return;
    }

    self setclientomnvar("ui_match_status_hint_text", 6);
    return;
  }

  self setclientomnvar("ui_match_status_hint_text", 1);
}

function trial_race_lap_total() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.isplanting) && isDefined(var_1.lastnonuseweapon)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1.lastnonuseweapon);
      break;
    }
  }
}

function ondeadevent(var_0) {
  trial_race_lap_total();

  if(level.bombexploded > 0 && !level.postgameexfil) {
    return;
  }

  if(var_0 == "all") {
    if(level.bombplanted) {
      var_1 = scripts\mp\utility\game::getotherteam(level.bombplantedteam)[0];
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[var_1]) + "_eliminated"], undefined, undefined, level.detonatescore);
      return;
    }

    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["tie"]);
    return;
  }

  if(level.bombplanted) {
    if(var_0 != level.bombplantedteam) {
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[var_0]) + "_eliminated"], undefined, undefined, level.detonatescore);
      return;
    }

    return;
  }

  if(var_0 == game["attackers"]) {
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(var_0 == game["defenders"]) {
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    return;
  }
}

function ononeleftevent(var_0) {
  if(level.bombexploded > 0) {
    return;
  }

  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);

  if(isDefined(var_1)) {
    var_1.laststanding = 1;
    thread givelastonteamwarning();
    return;
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_emp_carrier_hud", 0);
  thread checkallowspectating();

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }

  if(self.isbombcarrier && level.codcasterenabled) {
    self setgametypevip(0);
  }

  awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function checkallowspectating() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var_0 = 1;
  }

  if(var_0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);

  if(var_0.isplanting) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "planting");
    var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
    return;
  }

  if(var_0.isbombcarrier) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "carrying");
    return;
  }

  if(var_0.isdefusing) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_2, "defusing");
    return;
  }
}

function printothint() {
  self endon("disconnect");
  wait 0.25;
  self.otspawned = 1;
}

function awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.origin;
  var_15 = var_1.origin;
  var_16 = 0;

  if(isDefined(var_0)) {
    var_15 = var_0.origin;
    var_16 = var_0 == var_1;
  }

  if(isDefined(level.cyberemp.carrier)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_13.pers["team"]) {
      if(isDefined(var_1.isbombcarrier) && var_16 && isDefined(var_4) && var_4.basename == "iw8_cyberemp_mp") {
        var_1 thread scripts\mp\rank::scoreeventpopup("emp_carrier_kill");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_cyber_kill_with_emp");
      } else if(istrue(var_13.isbombcarrier)) {
        var_13.isbombcarrier = 0;

        if(istrue(var_13.ref_1334e)) {
          var_13 scripts\mp\utility\player::hideminimap();
        }

        var_1 thread scripts\mp\rank::scoreeventpopup("killed_emp_carrier");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_cyber_kill_carrier");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "carrying");
      }

      if(var_1.pers["team"] == level.cyberemp.ownerteam && var_1 != level.cyberemp.carrier) {
        var_17 = distancesquared(level.cyberemp.carrier.origin, var_15);

        if(var_17 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("defend");
          var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
          var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
          thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "defending");
        }
      }
    }
  }

  foreach(var_19 in level.objectives) {
    if(istrue(var_19.trigger.trigger_off)) {
      continue;
    }

    var_20 = var_19 scripts\mp\gameobjects::getownerteam();

    if(var_20 != var_1.team) {
      var_21 = distsquaredcheck(var_19.trigger, var_15, var_14);

      if(var_21) {
        var_11 = 1;
        var_1 thread scripts\mp\rank::scoreeventpopup("assault");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        var_19 notify("assault", var_1);
        thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "assaulting");
        continue;
      }

      continue;
    }

    var_22 = distsquaredcheck(var_19.trigger, var_15, var_14);

    if(var_22) {
      var_12 = 1;
      var_1 thread scripts\mp\rank::scoreeventpopup("defend");
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var_19 notify("defend", var_1);
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b26, var_9, "defending");
    }
  }
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck)) {
      return 1;
    }

    if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function empradarwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  self.radarpingtime = gettime();
  self.nextradarpingtime = self.radarpingtime;
  thread weaponswapwatcher();

  for(;;) {
    if(self.currentprimaryweapon.basename == "iw8_cyberemp_mp") {
      while(self.currentprimaryweapon.basename == "iw8_cyberemp_mp" && gettime() > self.nextradarpingtime) {
        triggeroneoffradarsweep(self);
        self.radarpingtime = gettime();
        self.nextradarpingtime = gettime() + level.radarpingtime * 1000;
        thread waitandwatchradarsweep();
        self waittill("radar_check");
      }
    }

    waitframe();
  }
}

function weaponswapwatcher() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self.ref_1334e = 0;

  for(;;) {
    if(self.currentprimaryweapon.basename == "iw8_cyberemp_mp") {
      if(!istrue(self.ref_1334e)) {
        scripts\mp\utility\player::showminimap();
        self.ref_1334e = 1;
      }
    } else if(istrue(self.ref_1334e)) {
      scripts\mp\utility\player::hideminimap();
      self.ref_1334e = 0;
    }

    waitframe();
  }
}

function waitandwatchradarsweep() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  var_0 = gettime() + level.radarpingtime * 1000;

  while(gettime() < var_0) {
    if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier && self.currentprimaryweapon.basename == "iw8_cyberemp_mp") {
      waitframe();
      continue;
    }

    break;
  }

  self notify("radar_check");
}

function applybombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level.cyber_loadouts[self.team];
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self.gamemode_chosenclass = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self.lastclass = "gamemode";
  self notify("faux_spawn");
  self.gameobject_fauxspawn = 1;
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function removebombcarrierclass() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self ismantling()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self notify("lost_juggernaut");
  waitframe();
  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function setcarriervisibility() {
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0;
        break;
      case 1:
        level.cyberemp.objidpingfriendly = 0;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 0.05;
        break;
      case 2:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1;
        break;
      case 3:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 1.5;
        break;
      case 4:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 2;
        break;
      case 5:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 3;
        break;
      case 6:
        level.cyberemp.objidpingfriendly = 1;
        level.cyberemp.objidpingenemy = 0;
        level.cyberemp.objpingdelay = 4;
        break;
    }

    return;
  }

  level.cyberemp.objidpingfriendly = 1;
  level.cyberemp.objidpingenemy = 0;
  level.cyberemp.objpingdelay = 3;
}

function onexfilstarted() {
  level.cyberemp scripts\mp\gameobjects::releaseid();

  if(isDefined(level.cyberemp.carrier)) {
    foreach(var_1 in level.objectives) {
      if(var_1.bombplanted == 0) {
        var_1.trigger disableplayeruse(level.cyberemp.carrier);
      }
    }
  }

  level.cyberemp.trigger delete();
  level.cyberemp.visuals[0] delete();
}

function emplightsoff() {
  level endon("game_ended");
  level waittill("emp_detonated");

  for(;;) {
    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "off";
      handleemponoff(var_1);
    }

    wait 0.1;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "on";
      handleemponoff(var_1);
    }

    wait 0.15;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "off";
      handleemponoff(var_1);
    }

    wait 0.1;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "on";
      handleemponoff(var_1, 0.05);
    }

    wait 0.5;

    foreach(var_1 in level.emplights) {
      var_1.switchstatus = "off";
      handleemponoff(var_1);
    }

    wait 10;
  }
}

function destroytvs() {
  level endon("game_ended");
  level waittill("emp_detonated");
  var_0 = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = getscriptablearray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_5 setscriptablepartstate("tv", "dead");
      waitframe();
    }
  }
}

function handleemponoff(var_0, var_1) {
  var_2 = 0.2;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(var_0.switchstatus == "on") {
    self notify("masterSwitch_on");

    if(!var_0.lightson) {
      foreach(var_4 in var_0.lights) {
        var_4 thread scripts\mp\motiondetectors::lightonroutine(randomfloat(var_2));
      }

      thread scripts\mp\motiondetectors::onoffmodelswap(var_0.models, "on");
      var_0.lightson = 1;
      return;
    }

    return;
  }

  if(var_3.switchstatus == "off") {
    if(var_3.lightson) {
      level scripts\mp\motiondetectors::lightoffroutine(var_3.lights);
      thread scripts\mp\motiondetectors::onoffmodelswap(var_3.models, "off");
      var_3.lightson = 0;
    }

    if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
      var_3.switchstatus = "motion";
    }

    self notify("lights_off");
    return;
  }
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp", 2, "neutral", "MP_INGAME_ONLY/OBJ_EMP_CAPS", "hud_icon_cyber_bomb", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_escort_emp", 1, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "hud_icon_cyber_bomb", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defend_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_target_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_ATTACK_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_planted_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defuse_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp_planting", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_emp_defusing", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defend_empsite_nt", 0, "friendly", "", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_defuse_empsite_nt", 0, "enemy", "", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("mlg_icon_waypoint_emp_planted", 0, "neutral", "", "icon_minimap_objective_codcaster_bomb", 0);
}