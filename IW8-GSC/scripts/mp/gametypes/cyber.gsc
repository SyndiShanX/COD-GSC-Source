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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_allies");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_cyber_spawn_axis");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", var0);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", var1);
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
  var0 = self.pers["team"];

  if(scripts\mp\utility\game::getgametypenumlives() != 1) {
    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var0 == game["attackers"]) {
        scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
        var1 = scripts\mp\spawnlogic::getspawnpoint(self, var0, undefined, "start_attackers");
      } else {
        scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
        var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_defenders");
      }
    } else {
      var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, level.introcinematic[var1], "neutral");
    }
  } else if(var1 == game["attackers"]) {
    scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_attackers");
  } else {
    scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
    var1 = scripts\mp\spawnlogic::getspawnpoint(self, var1, undefined, "start_defenders");
  }

  return var1;
}

function assignteamspawns() {
  level.spawnnodetype = "mp_ctf_spawn";
  var0 = scripts\mp\spawnlogic::getspawnpointarray(level.spawnnodetype);
  var1 = scripts\mp\spawnlogic::ispathdataavailable();
  level.teamspawnpoints["axis"] = [];
  level.teamspawnpoints["allies"] = [];
  level.teamspawnpoints["neutral"] = [];
  jumpiffalse(level.objectives.size == 2) LOC_0000022a;
  var2 = level.objectives["axis"];
  var3 = level.objectives["allies"];
  var4 = (var2.curorigin[0], var2.curorigin[1], 0);
  var5 = (var3.curorigin[0], var3.curorigin[1], 0);
  var6 = var5 - var4;
  var7 = length2d(var6);

  foreach(var9 in var0) {
    var10 = (var9.origin[0], var9.origin[1], 0);
    var11 = var10 - var4;
    var12 = vectordot(var11, var6);
    var13 = var12 / var7 * var7;

    if(var13 < 0.33) {
      var9.teambase = var2.ownerteam;
      level.teamspawnpoints[var9.teambase][level.teamspawnpoints[var9.teambase].size] = var9;
      continue;
    }

    if(var13 > 0.67) {
      var9.teambase = var3.ownerteam;
      level.teamspawnpoints[var9.teambase][level.teamspawnpoints[var9.teambase].size] = var9;
      continue;
    }

    var14 = undefined;
    var15 = undefined;

    if(var1) {
      var14 = getpathdist(var9.origin, var2.curorigin, 999999);
    }

    if(isDefined(var14) && var14 != -1) {
      var15 = getpathdist(var9.origin, var3.curorigin, 999999);
    }

    if(!isDefined(var15) || var15 == -1) {
      var14 = distance2d(var2.curorigin, var9.origin);
      var15 = distance2d(var3.curorigin, var9.origin);
    }

    var16 = max(var14, var15);
    var17 = min(var14, var15);
    var18 = var17 / var16;

    if(var18 > 0.5) {
      level.teamspawnpoints["neutral"][level.teamspawnpoints["neutral"].size] = var9;
    }
  }

  return;
}

function reset_doors(var0) {
  var1 = scripts\mp\spawnlogic::ispathdataavailable();
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in level.objectives) {
    var6 = undefined;

    if(var1) {
      var6 = getpathdist(var0.origin, var5.curorigin, 999999);
    }

    if(!isDefined(var6) || var6 == -1) {
      var6 = distancesquared(var5.curorigin, var0.origin);
    }

    if(!isDefined(var2) || var6 < var3) {
      var2 = var5;
      var3 = var6;
    }
  }

  return scripts\mp\utility\game::getotherteam(var2.ownerteam)[0];
}

function cyberattack() {
  var0 = getEntArray("cyber_emp_pickup_trig", "targetname");

  if(var0.size == 0) {
    scripts\engine\utility::error("No cyber_emp_pickup_trig triggers found in map. Please bug this to the level designer.");
    return;
  }

  if(level.empspawnindex == 3) {
    if(isDefined(game["empSpawn"])) {
      var1 = [0, 1, 2];
      var1 = scripts\engine\utility::array_remove(var1, game["empSpawn"]);
      level.empspawnindex = scripts\engine\utility::random(var1);
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

  var2 = var0[level.empspawnindex];
  var3 = getEntArray("cyber_emp", "targetname");
  GscBinSkip1(0x45, 0, var3[level.empspawnindex]);
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
  var0 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  level.cyberemp.pingobjidnum = var0;
  scripts\mp\objidpoolmanager::objective_add_objective(var0, "done", level.cyberemp.origin);
  level.cyberemp scripts\mp\gameobjects::setvisibleteam("none", var0);
  objective_setownerteam(var0, undefined);
  level.cyberemp scripts\mp\gameobjects::ref_1317f("icon_waypoint_escort_emp", "waypoint_capture_kill", "mlg_icon_waypoint_emp_planted", var0);
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

function emptriggerholdonuse(var0) {}

function createbombzone(var0, var1, var2) {
  var3 = getEntArray(var1.target, "targetname");
  var3[0].origin = var1.origin;
  var4 = scripts\mp\gameobjects::createuseobject(var0, var1, var3, (0, 0, 64), undefined, 1);
  var4.onuse = &onuse;
  var4.onbeginuse = &onbeginuse;
  var4.onenduse = &onenduse;
  var4.oncantuse = &oncantuse;
  var4.useweapon = getcompleteweaponname("emp_bomb_mp");
  var4.id = "bomb_zone";
  var4.trigger setusepriority(-3);
  var4.trigger setuseholdduration("duration_none");
  var4.trigger setusehideprogressbar(1);
  var4.bombplanted = 0;
  var4.bombexploded = undefined;
  var4 scripts\mp\gameobjects::setusetime(level.planttime);
  var4 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var4.objectivekey = "_" + var0;
  var4.label = var4.objectivekey;
  resetbombsite(var4, 1, undefined, 1);
  var4 scripts\mp\gameobjects::setusetext(&"MP/PLANTING_EXPLOSIVE");
  var4 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

  for(var5 = 0; var5 < var3.size; var5++) {
    if(isDefined(var3[var5].script_exploder)) {
      var4.exploderindex = var3[var5].script_exploder;
      thread setupkillcament(var3[var5]);
      break;
    }
  }

  var4.noweapondropallowedtrigger = spawn("trigger_radius", var4.trigger.origin, 0, 140, 100);
  var4.defusetrig = var2;
  return var4;
}

function setupkillcament(var0) {
  var1 = spawn("script_origin", self.origin);
  var1.angles = self.angles;
  var1 rotateYaw(-45, 0.05);
  waitframe();
  var2 = undefined;
  var3 = self.origin + (0, 0, 45);
  var4 = self.origin + anglesToForward(var1.angles) * 100 + (0, 0, 128);
  var5 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var6 = physics_createcontents(var5);
  var7 = scripts\engine\trace::ray_trace(var3, var4, self, var6);
  var2 = var7["position"];
  self.killcament = spawn("script_model", var2);
  self.killcament setscriptmoverkillcam("explosive");
  var0.killcamentnum = self.killcament getentitynumber();
  var1 delete();
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
  var0 = scripts\engine\utility::spawn_script_origin(self.trigger.origin, self.trigger.angles);
  var0 thread scripts\engine\utility::play_loop_sound_on_entity("data_center_cyber_lp");
  level waittill("emp_detonated");
  var0 stopsounds("data_center_cyber_lp");
  waitframe();
  var0 delete();
}

function onbeginuse(var0) {
  if(!scripts\mp\gameobjects::isfriendlyteam(var0.pers["team"]) && !level.bombplanted) {
    var0.isplanting = 1;
    setomnvar("ui_bomb_interacting", 1);
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite", "icon_waypoint_emp_planting");
  } else {
    var0.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    scripts\mp\utility\game::setmlgannouncement(2, var0.team, var0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var0.team);
  }

  thread allowedwhileplanting(var0);

  if(level.bombplanted && !scripts\mp\gameobjects::isfriendlyteam(var0.pers["team"])) {
    var0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    var0.isdefusing = 1;
    setomnvar("ui_bomb_interacting", 3);
    setomnvar("ui_bomb_defuser", var0 getentitynumber());

    if(isDefined(level.cyberemp.visuals[0])) {
      level.cyberemp.visuals[0] hide();
    }

    thread startnpcbombusesound(var0, "briefcase_bomb_defuse_mp");
    return;
  }
}

function allowedwhileplanting(var0) {
  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_jump(var0);
  scripts\mp\utility\player::allow_gesture(var0);

  if(var0) {
    scripts\engine\utility::ref_143b9(0.8, "bomb_allow_offhands");
    scripts\common\utility::allow_melee(var0);
    scripts\common\utility::allow_mantle(var0);
  } else {
    scripts\common\utility::allow_melee(var0);
    scripts\common\utility::allow_mantle(var0);
  }

  scripts\common\utility::allow_offhand_weapons(var0);
}

function onenduse(var0, var1, var2) {
  var3 = self.objidnum;
  scripts\mp\objidpoolmanager::objective_set_progress(var3, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(var3, 0);

  if(!var2) {
    if(var1.isdefusing) {
      scripts\mp\gameobjects::ref_1317f("icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt", "mlg_icon_waypoint_emp_planted");
    } else {
      scripts\mp\gameobjects::ref_1317f("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite", "mlg_icon_waypoint_emp_planted");
    }

    if(isDefined(self.radialtimeobjid)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var1.team);
    }

    var1 scripts\mp\utility\inventory::switchtolastweapon();
  }

  var1.isplanting = 0;
  var1.isdefusing = 0;
  setomnvar("ui_bomb_defuser", -1);

  if(!isDefined(var1)) {
    return;
  }

  thread allowedwhileplanting(var1);
  var1.bombplantweapon = undefined;

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_bomb_planting_defusing = undefined;
  }

  if(!scripts\mp\gameobjects::isfriendlyteam(var1.pers["team"])) {
    if(isDefined(level.cyberemp) && !var2) {
      level.cyberemp.visuals[0] show();
      return;
    }

    return;
  }
}

function startnpcbombusesound(var0, var1) {
  self endon("death");
  self endon("stopNpcBombSound");
  jumpiffalse(scripts\mp\utility\game::isanymlgmatch() || istrue(level.silentplant) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) LOC_00000040;
  self setentitysoundcontext("silent_plant", "on");
  return;
}

function onpickup(var0, var1, var2) {
  level notify("bomb_pickup");
  var3 = var0 getcurrentprimaryweapon();

  if(isDefined(var3.basename) && var3.basename == "iw8_lm_dblmg_mp") {
    var0 notify("switched_from_minigun");
  }

  var0 scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var2) && !var0 scripts\mp\utility\killstreak::isjuggernaut() && !isbot(var0)) {
    var0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_cyberemp_mp");
  }

  thread empradarwatcher();
  setomnvar("ui_bomb_carrier", var0 getentitynumber());
  var0 setclientomnvar("ui_emp_carrier_hud", 1);
  scripts\mp\utility\game::setmlgannouncement(16, var0.team, var0 getentitynumber());

  if(self.firstpickup) {
    var0 thread scripts\mp\utility\points::giveunifiedpoints("emp_grab");
  }

  level.usestartspawns = 0;
  var4 = var0.pers["team"];

  if(var4 == "allies") {
    var5 = "axis";
  } else {
    var5 = "allies";
  }

  var1.isbombcarrier = 1;

  if(level.codcasterenabled) {
    var1 setgametypevip(1);
  }

  if(!isDefined(var3)) {
    if(self.firstpickup) {
      var6 = "emppickup_friendly_first";
      self.firstpickup = 0;
    } else {
      var6 = "emppickup_friendly";
    }

    scripts\mp\utility\dialog::leaderdialog(var6, var5, "bomb");
    scripts\mp\utility\dialog::leaderdialog("emppickup_enemy", var6, "bomb");
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], var5);
    var7 = scripts\mp\utility\teams::getteamdata(var2.team, "players");
    level thread scripts\mp\hud_message::notifyteam("emp_pickup", "emp_pickup_enemy", var2.team, var7);
    var2 thread scripts\mp\hud_message::showsplash("emp_pickup");
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_emppickup", var2, var2.team, undefined, 1);
  }

  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var2.team, 5, 6, var2, 2);
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setownerteam(var5);
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
  level.objectives[var5] scripts\mp\gameobjects::setvisibleteam("none");
  level.objectives[var6] scripts\mp\gameobjects::setvisibleteam("any");
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["allies"].objidnum, 0);
  scripts\mp\objidpoolmanager::ref_11f84(level.objectives["axis"].objidnum, 0);
  var2 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var2.origin);
}

function ondrop(var0) {
  setomnvar("ui_bomb_carrier", -1);

  if(level.bombplanted) {
    scripts\mp\gameobjects::setownerteam(var0.team);
    scripts\mp\gameobjects::allowuse("none");
    return;
  }

  foreach(var2 in level.objectives) {
    resetbombsite(var2, 1);
  }

  scripts\mp\gameobjects::allowuse("any");
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_emp", "icon_waypoint_emp");
  scripts\mp\gameobjects::setownerteam("neutral");
  scripts\mp\gameobjects::setvisibleteam("any");

  if(isDefined(var0)) {
    scripts\mp\utility\print::printonteamarg(&"MP/EXPLOSIVES_DROPPED_BY", scripts\mp\gameobjects::getownerteam(), var0);
  }

  scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], scripts\mp\gameobjects::getownerteam());
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var0.team, 1, 1);

  if(level.idleresettime > 0) {
    thread returnaftertime();
    return;
  }
}

function returnaftertime() {
  level endon("bomb_pickup");
  var0 = 0;

  while(var0 < level.idleresettime) {
    waitframe();

    if(self.ownerteam == "neutral") {
      var0 += level.framedurationseconds;
    }
  }

  foreach(var2 in level.teamnamelist) {
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], var2);
  }

  scripts\mp\gameobjects::returnhome();
}

function onuse(var0) {
  var1 = var0.pers["team"];
  var2 = scripts\mp\utility\game::getotherteam(var1)[0];

  if(!scripts\mp\gameobjects::isfriendlyteam(var0.pers["team"]) && !level.bombplanted) {
    thread empjamandrumbleclients(level);
    setomnvar("ui_bomb_timer_endtime_a", int(scripts\mp\gamelogic::gettimeremaining()) + gettime());
    level notify("bomb_planted");
    var0 notify("bomb_planted");
    var0 notify("objective", "plant");
    var0 playSound("mp_bomb_plant");
    scripts\mp\utility\game::setmlgannouncement(15, var0.team, var0 getentitynumber());
    var3 = [];
    GscBinSkip0(0x2e, var3.size, var0, 0);
  }

  var1 notify("bomb_defused");
  var1 notify("objective", "defuse");
  var4 = 0;

  if(scripts\mp\utility\teams::getenemycount(var1.team, 1) == 0) {
    var4 = 1;
  }

  if(var4) {
    var5 = "empdefused_final_friendly";
    var6 = "empdefused_final_enemy";
  } else {
    var5 = "empdefused_friendly";
    var6 = "empdefused_enemy";
  }

  scripts\mp\utility\dialog::leaderdialog(var5, var3);
  scripts\mp\utility\dialog::leaderdialog(var6, var4);
  var5 = [];
  var5 = var3;
  level thread scripts\mp\hud_message::notifyteam("emp_defuse", "emp_defuse_enemy", var3.team, var5);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_empdefused", var3, undefined, undefined, 1);
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var3.team, 5, 6, var3, 2);

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
    var3 thread scripts\mp\rank::scoreeventpopup("ninja_defuse");
    var3 thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
  } else {
    var3 thread scripts\mp\rank::scoreeventpopup("defuse");
    var3 thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
  }

  var3 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse");
  var3 scripts\mp\utility\stats::incpersstat("defuses", 1);
  var3 scripts\mp\persistence::statsetchild("round", "defuses", var3.pers["defuses"]);
  var3 scripts\cp\vehicles\vehicle_compass_cp::ref_1201f();
  var3 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "defuse", var3.origin);
  level.bombplanted = 0;
  thread bombdefused(level);
  resetbombsite(1, var3);

  if(var6) {
    wait 3;
  }

  level.cyberemp scripts\mp\gameobjects::allowuse("any");
  level.cyberemp scripts\mp\gameobjects::setpickedup(var3, 0, 1);
}

function empjamandrumbleclients(var0, var1) {
  foreach(var3 in level.players) {
    var3 setempjammed(1);

    if(istrue(var0)) {
      var3 playrumbleonpositionforclient("artillery_rumble", var3.origin);
    }
  }

  if(!istrue(var1)) {
    wait 1;

    foreach(var3 in level.players) {
      var3 setempjammed(0);
    }

    return;
  }
}

function resetbombsite(var0, var1, var2) {
  if(!var0) {
    scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_planted_empsite", "icon_waypoint_target_empsite");
    scripts\mp\gameobjects::setvisibleteam("any");
    return;
  }

  if(istrue(var2)) {
    return;
  }

  if(isDefined(var1)) {
    self.ownerteam = var1.team;
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

function setupfordefusing(var0, var1) {
  self.trigger setusepriority(-3);
  self.ownerteam = var1.team;
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(level.defusetime);
  scripts\mp\gameobjects::setusetext(&"MP/DEFUSING_EXPLOSIVE");
  scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_DEFUSE_EMP");
  scripts\mp\gameobjects::setkeyobject(undefined);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt");
  thread scripts\mp\gametypes\obj_bombzone::current_carrier(var1.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite");
  scripts\mp\gameobjects::setvisibleteam("any", self.radialtimeobjid);
  self.id = "defuse_object";
  self.bombplanted = 1;
  var2 = scripts\mp\utility\teams::getenemyteams(var1.team);
  var3 = var2[0];

  foreach(var5 in scripts\mp\utility\teams::getteamdata(var3, "players")) {
    self.trigger enableplayeruse(var5);
  }
}

function bombdefused(var0) {
  scripts\mp\gamelogic::resumetimer();
  level.timelimitoverride = 0;
  level.scorelimitoverride = 0;
  var0.bombplanted = 0;
  setomnvar("ui_bomb_owner_team", -1);
  level thread[[level.updategameevents]]();
  var0.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  level notify("bomb_defused");
}

function oncantuse(var0) {}

function bombplanted(var0, var1) {
  level endon("overtime");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("ui_match_timer_stopped", 0);
  level.bombplantedteam = var1;
  level.timelimitoverride = 1;
  level.scorelimitoverride = 1;

  if(isDefined(var1)) {
    if(var1 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  setgameendtime(int(gettime() + level.bombtimer * 1000));
  var0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  var2 = gettime();
  thread bomb_pre_exp_music();
  thread bomb_pre_exp_sfx_wait(var0.visuals[0].origin);
  bombtimerwait();
  var0.visuals[0] scripts\mp\gamelogic::stoptickingsound();

  if(!level.bombplanted) {
    if(level.persbombtimer) {
      var3 = (gettime() - var2) / 1000;
      level.bombtimer -= var3;
    }

    return;
  }

  var4 = var0.visuals[0].origin;
  level.bombexploded = 1;
  setDvar("ui_danger_team", "BombExploded");

  if(isDefined(level.bombowner)) {
    var0.visuals[0] radiusdamage(var4, 512, 1, 1, level.bombowner, "MOD_EXPLOSIVE", "bomb_site_mp");
    level.bombowner scripts\mp\utility\stats::incpersstat("destructions", 1);
    level.bombowner scripts\mp\persistence::statsetchild("round", "destructions", level.bombowner.pers["destructions"]);
  } else {
    var0.visuals[0] radiusdamage(var4, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  var5 = randomfloat(360);
  playsoundatpos(var4, "exp_cyber_emp_close");
  var6 = var0.visuals[0] gettagorigin("tag_origin");
  var7 = spawnfx(level._effect["emp_detonation"], var6, (0, 0, 1), (cos(var5), sin(var5), 0));
  triggerfx(var7);
  earthquake(0.6, 1.5, var4, 10000);
  thread empjamandrumbleclients(level, 1);
  level notify("emp_detonated");

  foreach(var9 in level.objectives) {
    var9 notify("disabled");
    var9.trigger scripts\mp\utility\usability::setallunusable();
  }

  if(game["switchedsides"]) {
    var0.exploderindex = 200;
  } else {
    var0.exploderindex = 201;
  }

  if(isDefined(var0.exploderindex)) {
    scripts\engine\utility::exploder(var0.exploderindex);
  }

  var0.bombplanted = 0;
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

  var0 scripts\mp\gameobjects::releaseid();

  if(istrue(level.nukeincoming)) {
    return;
  }

  wait 3;
  thread scripts\mp\gamelogic::endgame(var1, game["end_reason"]["target_destroyed"], undefined, undefined, level.detonatescore);
}

function bombtimerwait() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  var0 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var0);
  thread handlehostmigration(level);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function bomb_pre_exp_music() {
  thread scripts\mp\music_and_dialog::stopsuspensemusic();
  thread scripts\mp\music_and_dialog::bombplanted_music();
}

function bomb_pre_exp_sfx_wait(var0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  wait max(level.bombtimer - 2, 0.1);
  playsoundatpos(var0, "exp_cyber_emp_preexplode");
}

function handlehostmigration(var0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var1 > 0) {
    setomnvar("ui_bomb_timer_endtime", var0 + var1);
    return;
  }
}

function overtimethread(var0) {
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
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_lastenemyalive", self, var0);
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

  foreach(var1 in level.objectives) {
    if(var1.bombplanted == 0) {
      var1.trigger disableplayeruse(self);
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
  foreach(var1 in level.players) {
    if(istrue(var1.isplanting) && isDefined(var1.lastnonuseweapon)) {
      var1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var1.lastnonuseweapon);
      break;
    }
  }
}

function ondeadevent(var0) {
  trial_race_lap_total();

  if(level.bombexploded > 0 && !level.postgameexfil) {
    return;
  }

  if(var0 == "all") {
    if(level.bombplanted) {
      var1 = scripts\mp\utility\game::getotherteam(level.bombplantedteam)[0];
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[var1]) + "_eliminated"], undefined, undefined, level.detonatescore);
      return;
    }

    thread scripts\mp\gamelogic::endgame("tie", game["end_reason"]["tie"]);
    return;
  }

  if(level.bombplanted) {
    if(var0 != level.bombplantedteam) {
      thread scripts\mp\gamelogic::endgame(level.bombplantedteam, game["end_reason"][tolower(game[var0]) + "_eliminated"], undefined, undefined, level.detonatescore);
      return;
    }

    return;
  }

  if(var0 == game["attackers"]) {
    level thread scripts\mp\gamelogic::endgame(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    return;
  }

  if(var0 == game["defenders"]) {
    level thread scripts\mp\gamelogic::endgame(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    return;
  }
}

function ononeleftevent(var0) {
  if(level.bombexploded > 0) {
    return;
  }

  var1 = scripts\mp\utility\game::getlastlivingplayer(var0);

  if(isDefined(var1)) {
    var1.laststanding = 1;
    thread givelastonteamwarning();
    return;
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self setclientomnvar("ui_emp_carrier_hud", 0);
  thread checkallowspectating();

  if(!isPlayer(var1) || var1.team == self.team) {
    return;
  }

  if(self.isbombcarrier && level.codcasterenabled) {
    self setgametypevip(0);
  }

  awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function checkallowspectating() {
  waitframe();
  var0 = 0;

  if(!scripts\mp\utility\teams::getteamdata(game["attackers"], "aliveCount")) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(!scripts\mp\utility\teams::getteamdata(game["defenders"], "aliveCount")) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    var0 = 1;
  }

  if(var0) {
    scripts\mp\spectating::updatespectatesettings();
    return;
  }
}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::oncommonnormaldeath(var0, var1, var2, var3, var4, var5);

  if(var0.isplanting) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var2, "planting");
    var1 scripts\mp\utility\stats::incpersstat("defends", 1);
    var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
    return;
  }

  if(var0.isbombcarrier) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var2, "carrying");
    return;
  }

  if(var0.isdefusing) {
    thread scripts\common\utility::ref_13e0a(level.ref_11b30, var2, "defusing");
    return;
  }
}

function printothint() {
  self endon("disconnect");
  wait 0.25;
  self.otspawned = 1;
}

function awardgenericmedals(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = 0;
  var11 = 0;
  var12 = 0;
  var13 = self;
  var14 = var13.origin;
  var15 = var1.origin;
  var16 = 0;

  if(isDefined(var0)) {
    var15 = var0.origin;
    var16 = var0 == var1;
  }

  if(isDefined(level.cyberemp.carrier)) {
    if(isDefined(var1) && isPlayer(var1) && var1.pers["team"] != var13.pers["team"]) {
      if(isDefined(var1.isbombcarrier) && var16 && isDefined(var4) && var4.basename == "iw8_cyberemp_mp") {
        var1 thread scripts\mp\rank::scoreeventpopup("emp_carrier_kill");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_cyber_kill_with_emp");
      } else if(istrue(var13.isbombcarrier)) {
        var13.isbombcarrier = 0;

        if(istrue(var13.ref_1334e)) {
          var13 scripts\mp\utility\player::hideminimap();
        }

        var1 thread scripts\mp\rank::scoreeventpopup("killed_emp_carrier");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_cyber_kill_carrier");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "carrying");
      }

      if(var1.pers["team"] == level.cyberemp.ownerteam && var1 != level.cyberemp.carrier) {
        var17 = distancesquared(level.cyberemp.carrier.origin, var15);

        if(var17 < 105625) {
          var1 thread scripts\mp\rank::scoreeventpopup("defend");
          var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
          var1 scripts\mp\utility\stats::incpersstat("defends", 1);
          var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
          thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
        }
      }
    }
  }

  foreach(var19 in level.objectives) {
    if(istrue(var19.trigger.trigger_off)) {
      continue;
    }

    var20 = var19 scripts\mp\gameobjects::getownerteam();

    if(var20 != var1.team) {
      var21 = distsquaredcheck(var19.trigger, var15, var14);

      if(var21) {
        var11 = 1;
        var1 thread scripts\mp\rank::scoreeventpopup("assault");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        var19 notify("assault", var1);
        thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "assaulting");
        continue;
      }

      continue;
    }

    var22 = distsquaredcheck(var19.trigger, var15, var14);

    if(var22) {
      var12 = 1;
      var1 thread scripts\mp\rank::scoreeventpopup("defend");
      var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
      var19 notify("defend", var1);
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b26, var9, "defending");
    }
  }
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var0.origin, var1);
  var4 = distancesquared(var0.origin, var2);

  if(var3 < 105625 || var4 < 105625) {
    if(!isDefined(var0.modifieddefendcheck)) {
      return 1;
    }

    if(var1[2] - var0.origin[2] < 100 || var2[2] - var0.origin[2] < 100) {
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
  var0 = gettime() + level.radarpingtime * 1000;

  while(gettime() < var0) {
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
    foreach(var1 in level.objectives) {
      if(var1.bombplanted == 0) {
        var1.trigger disableplayeruse(level.cyberemp.carrier);
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
    foreach(var1 in level.emplights) {
      var1.switchstatus = "off";
      handleemponoff(var1);
    }

    wait 0.1;

    foreach(var1 in level.emplights) {
      var1.switchstatus = "on";
      handleemponoff(var1);
    }

    wait 0.15;

    foreach(var1 in level.emplights) {
      var1.switchstatus = "off";
      handleemponoff(var1);
    }

    wait 0.1;

    foreach(var1 in level.emplights) {
      var1.switchstatus = "on";
      handleemponoff(var1, 0.05);
    }

    wait 0.5;

    foreach(var1 in level.emplights) {
      var1.switchstatus = "off";
      handleemponoff(var1);
    }

    wait 10;
  }
}

function destroytvs() {
  level endon("game_ended");
  level waittill("emp_detonated");
  var0 = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(var2 in var0) {
    var3 = getscriptablearray(var2.target, "targetname");

    foreach(var5 in var3) {
      var5 setscriptablepartstate("tv", "dead");
      waitframe();
    }
  }
}

function handleemponoff(var0, var1) {
  var2 = 0.2;

  if(isDefined(var1)) {
    var2 = var1;
  }

  if(var0.switchstatus == "on") {
    self notify("masterSwitch_on");

    if(!var0.lightson) {
      foreach(var4 in var0.lights) {
        var4 thread scripts\mp\motiondetectors::lightonroutine(randomfloat(var2));
      }

      thread scripts\mp\motiondetectors::onoffmodelswap(var0.models, "on");
      var0.lightson = 1;
      return;
    }

    return;
  }

  if(var3.switchstatus == "off") {
    if(var3.lightson) {
      level scripts\mp\motiondetectors::lightoffroutine(var3.lights);
      thread scripts\mp\motiondetectors::onoffmodelswap(var3.models, "off");
      var3.lightson = 0;
    }

    if(isDefined(self.script_parameters) && self.script_parameters == "motion") {
      var3.switchstatus = "motion";
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