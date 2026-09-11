/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tdef.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  level.keepviewingthe747 = [];
  var_0 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(var_2 in var_0) {
    level.keepviewingthe747[level.keepviewingthe747.size] = var_2.origin;
  }

  level.keepstreamposfresh = (0, 0, 0);
  var_4 = getEntArray("flag_primary", "targetname");

  foreach(var_6 in var_4) {
    if(var_6.script_label == "_b") {
      level.keepstreamposfresh = var_6.origin;
      break;
    }
  }

  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_tdef_ppkTeamNoFlag", getmatchrulesdata("tdefData", "ppkTeamNoFlag"));
  setdynamicdvar("scr_tdef_ppkTeamWithFlag", getmatchrulesdata("tdefData", "ppkTeamWithFlag"));
  setdynamicdvar("scr_tdef_ppkFlagCarrier", getmatchrulesdata("tdefData", "ppkFlagCarrier"));
  setdynamicdvar("scr_tdef_scoringTime", getmatchrulesdata("tdefData", "scoringTime"));
  setdynamicdvar("scr_tdef_scorePerTick", getmatchrulesdata("tdefData", "scorePerTick"));
  setdynamicdvar("scr_tdef_carrierBonusTime", getmatchrulesdata("tdefData", "carrierBonusTime"));
  setdynamicdvar("scr_tdef_carrierBonusScore", getmatchrulesdata("tdefData", "carrierBonusScore"));
  setdynamicdvar("scr_tdef_delayplayer", getmatchrulesdata("tdefData", "delayPlayer"));
  setdynamicdvar("scr_tdef_spawndelay", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("scr_tdef_flagActivationDelay", getmatchrulesdata("tdefData", "flagActivationDelay"));
  setdynamicdvar("scr_tdef_possessionResetCondition", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("scr_tdef_possessionResetTime", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("scr_tdef_showEnemyCarrier", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("scr_tdef_idleResetTime", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("scr_tdef_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("tdef", 0);
  setdynamicdvar("scr_tdef_promode", 0);
}

function onstartgametype() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"OBJECTIVES/TDEF");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/TDEF");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"OBJECTIVES/TDEF_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"OBJECTIVES/TDEF_ATTACKER_HINT");
  }

  initspawns();
  tdef();
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
  level.ref_1283a = scripts\mp\utility\dvars::dvarintvalue("ppkTeamNoFlag", 50, 0, 250);
  level.ref_1283b = scripts\mp\utility\dvars::dvarintvalue("ppkTeamWithFlag", 100, 0, 250);
  level.ref_12839 = scripts\mp\utility\dvars::dvarintvalue("ppkFlagCarrier", 250, 0, 250);
  level.scoringtime = scripts\mp\utility\dvars::dvarfloatvalue("scoringTime", 1, 1, 10);
  level.scorepertick = scripts\mp\utility\dvars::dvarintvalue("scorePerTick", 1, 1, 25);
  level.carrierbonustime = scripts\mp\utility\dvars::dvarfloatvalue("carrierBonusTime", 4, 0, 10);
  level.carrierbonusscore = scripts\mp\utility\dvars::dvarintvalue("carrierBonusScore", 25, 0, 250);
  level.delayplayer = scripts\mp\utility\dvars::dvarintvalue("delayPlayer", 1, 0, 1);
  level.spawndelay = scripts\mp\utility\dvars::dvarfloatvalue("spawnDelay", 2.5, 0, 30);
  level.player_has_respawn_munition = scripts\mp\utility\dvars::dvarfloatvalue("flagActivationDelay", 10, 0, 30);
  level.possessionresetcondition = scripts\mp\utility\dvars::dvarintvalue("possessionResetCondition", 0, 0, 2);
  level.possessionresettime = scripts\mp\utility\dvars::dvarfloatvalue("possessionResetTime", 0, 0, 150);
  level.idleresettime = scripts\mp\utility\dvars::dvarfloatvalue("idleResetTime", 15, 0, 60);
  level.showenemycarrier = scripts\mp\utility\dvars::dvarintvalue("showEnemyCarrier", 5, 0, 6);
}

function initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("TDef", "Crit_Frontline");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var_0);
  scripts\mp\spawnlogic::registerspawnset("fallback", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var_3 in level.spawnpoints) {
    freeze_timer_at_max_time_bomb_case(var_3);
  }
}

function freeze_timer_at_max_time_bomb_case(var_0) {
  var_0.scriptdata.lootchopper_droploot = undefined;
  var_1 = getpathdist(var_0.origin, level.keepviewingthe747[0], 1000);

  if(var_1 < 0) {
    var_1 = scripts\engine\utility::distance_2d_squared(var_0.origin, level.keepviewingthe747[0]);
  } else {
    var_1 *= var_1;
  }

  var_0.scriptdata.lootchopper_droploot = var_1;
}

function getspawnpoint() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  }

  jumpiffalse(scripts\mp\spawnlogic::shoulduseteamstartspawn()) LOC_0000004d;
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_0 + "_start");
  var_2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_1);
  goto LOC_000000c9;
}

function tdef() {
  level.flagmodel["allies"] = "ctf_game_flag_west";
  level.flagbase["allies"] = "ctf_game_flag_base";
  level.carryflag["allies"] = "prop_ctf_game_flag_west";
  level.flagmodel["axis"] = "ctf_game_flag_east";
  level.flagbase["axis"] = "ctf_game_flag_base";
  level.carryflag["axis"] = "prop_ctf_game_flag_east";
  setupwaypointicons();
  level.iconescort = "waypoint_escort_flag";
  level.iconkill = "waypoint_ctf_kill";
  level.iconcaptureflag = "waypoint_take_flag";
  level.icondefendflag = "waypoint_defend_flag";
  level.iconreturnflag = "waypoint_recover_flag";
  level.ref_11c5f = "waypoint_mlg_empty_flag";
  level.ref_11c60 = "waypoint_mlg_full_flag";
  level.icontarget = "waypoint_target";
  init_relic_noluck();
}

function setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0);
}

function init_relic_noluck() {
  level.keepviewingthe747 = scripts\engine\utility::array_randomize(level.keepviewingthe747);
  var_0 = level.keepviewingthe747[0] + (0, 0, 64);
  var_1 = level.keepviewingthe747[0] + (0, 0, -64);
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1, undefined, scripts\engine\trace::create_default_contents(1));
  level.keepviewingthe747[0] = var_2["position"];
  level.keeprightdooropen = init_unlock_silo("allies");
  thread player_in_bush_monitor();
}

function player_in_bush_monitor() {
  if(!scripts\mp\flags::gameflag("prematch_done")) {
    level.key_activate.ref_11f89 scripts\mp\gameobjects::setvisibleteam("none");
    level scripts\engine\utility::ref_143a5("prematch_done", "start_mode_setup");
    level.key_activate.ref_11f89 scripts\mp\gameobjects::setvisibleteam("any");
  }

  if(level.player_has_respawn_munition) {
    scripts\mp\flags::gameflagwait("prematch_done");
    level.key_activate.ref_11f89 thread scripts\mp\gametypes\obj_zonecapture::ref_1199e(level.player_has_respawn_munition, level.keeprightdooropen.curorigin + level.keeprightdooropen.offset3d);
    wait level.player_has_respawn_munition;
    level.key_activate.ref_11f89 scripts\mp\gameobjects::ref_1317f(level.iconcaptureflag, level.iconcaptureflag, level.ref_11c60);
    level.keeprightdooropen.trigger scripts\engine\utility::trigger_on();

    foreach(var_1 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", var_1);
    }

    return;
  }
}

function init_unlock_silo(var_0) {
  level.pickuptime = 0;
  level.returntime = 0;
  var_1 = 32;
  var_2 = spawn("trigger_radius", level.keepviewingthe747[0], 0, var_1, 128);
  var_3 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", level.keepviewingthe747[0]));
}

function player_infil_already_played(var_0) {
  return !var_0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

function init_usb_animations(var_0, var_1) {
  var_2 = var_1.visuals[0].origin;
  var_3 = spawn("script_model", var_2);
  var_3 setModel(level.flagbase[var_0]);
  var_3.ownerteam = "neutral";
  var_3 setasgametypeobjective();
  setteaminhuddatafromteamname(var_3, var_0);
  var_3.ref_11f89 = scripts\mp\gameobjects::createobjidobject(var_2, "neutral", (0, 0, 85), undefined, "any", 0);
  var_3.ref_11f89 scripts\mp\gameobjects::setvisibleteam("any");

  if(level.player_has_respawn_munition) {
    var_1.trigger scripts\engine\utility::trigger_off();
    var_3.ref_11f89 scripts\mp\gameobjects::ref_1317f(level.icontarget, level.icontarget, level.ref_11c60);
  } else {
    var_3.ref_11f89 scripts\mp\gameobjects::ref_1317f(level.iconcaptureflag, level.iconcaptureflag, level.ref_11c60);
  }

  return var_3;
}

function setteaminhuddatafromteamname(var_0) {
  if(var_0 == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(var_0 == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function onpickup(var_0, var_1, var_2) {
  self notify("picked_up");
  var_0 notify("obj_picked_up");
  level.key_activate.ref_11f89 scripts\mp\gameobjects::setvisibleteam("none");
  level.keeprightdooropen.initscriptablemanagement = var_0;
  thread choose_and_drop_tank_near_hostage();
  thread player_helis();
  var_3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var_0.team);
  var_4 = var_0.pers["team"];

  if(var_4 == "allies") {
    var_5 = "axis";
  } else {
    var_5 = "allies";
  }

  attachflag(var_1);
  var_1 scripts\mp\utility\stats::incpersstat("pickups", 1);

  if(self.ownerteam == "allies") {
    setomnvar("ui_ctf_flag_allies", var_1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", var_1 getentitynumber());
  }

  var_1 setclientomnvar("ui_ctf_flag_carrier", 1);

  if(isDefined(level.showenemycarrier)) {
    if(level.showenemycarrier == 0) {
      scripts\mp\gameobjects::setvisibleteam("none");
    } else {
      scripts\mp\gameobjects::setvisibleteam("friendly");
      objective_state(self.pingobjidnum, "current");
      scripts\mp\gameobjects::updatecompassicon("enemy", self.pingobjidnum);
      objective_icon(self.pingobjidnum, "icon_waypoint_kill");
      objective_setbackground(self.pingobjidnum, 2);
      scripts\mp\objidpoolmanager::ref_11f7d(self.pingobjidnum, 1);
      scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
      scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
      objective_setownerteam(self.pingobjidnum, var_5);
    }
  }

  scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60);
  scripts\mp\utility\print::printandsoundoneveryone(var_5, var_5, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", var_1);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", var_5);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", var_5);
  }

  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var_1);
  var_1 thread scripts\mp\hud_message::showsplash("flagpickup");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var_1) {
    var_1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var_1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var_1.origin);
  self.previouscarrier = var_1;

  if(level.codcasterenabled) {
    var_1 setgametypevip(1);
    return;
  }
}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(var_0) {
  if(isDefined(var_0.leaving_team)) {
    self.droppedteam = var_0.leaving_team;
    var_0.leaving_team = undefined;
  } else if(!isDefined(var_0)) {
    self.droppedteam = self.ownerteam;
  } else {
    self.droppedteam = var_0.team;
  }

  level.keeprightdooropen.initscriptablemanagement = undefined;

  if(isDefined(var_0)) {
    ref_13ffa(var_0);
  }

  scripts\mp\gameobjects::setownerteam("neutral");
  var_1 = self.droppedteam;
  var_2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("any");
  objective_state(self.pingobjidnum, "done");

  if(level.returntime >= 0) {
    scripts\mp\gameobjects::ref_1317f(level.iconreturnflag, level.iconreturnflag, level.ref_11c60);
  } else {
    scripts\mp\gameobjects::ref_1317f(level.iconreturnflag, level.iconreturnflag, level.ref_11c60);
    scripts\mp\objidpoolmanager::ref_11f7d(self.objidnum, 1);
  }

  if(self.ownerteam == "allies") {
    setomnvar("ui_ctf_flag_allies", -1);
  } else {
    setomnvar("ui_ctf_flag_allies", -1);
  }

  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  if(isDefined(var_0)) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      var_0.carryobject.previouscarrier = undefined;
    }

    if(isDefined(var_0.carryflag)) {
      detachflag(var_0);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var_2, "none", undefined, undefined, "mp_war_objective_lost", "", var_0);

    if(level.codcasterenabled) {
      var_0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);
  }

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_dropped", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("flag_dropped", self.droppedteam, "status");
  }

  if(level.idleresettime > 0) {
    thread returnaftertime();
    return;
  }
}

function returnaftertime() {
  self endon("picked_up");
  var_0 = 0;

  while(var_0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      var_0 += level.framedurationseconds;
    }
  }

  foreach(var_2 in level.teamnamelist) {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var_2);
  }

  scripts\mp\gameobjects::returnhome();
}

function onreset() {
  level.keeprightdooropen.initscriptablemanagement = undefined;

  if(isDefined(level.keeprightdooropen.ref_127eb)) {
    level.keeprightdooropen.ref_127eb clearportableradar();
    level.keeprightdooropen.ref_127eb delete();
  }

  if(isDefined(self.droppedteam)) {
    scripts\mp\gameobjects::setownerteam(self.droppedteam);
  }

  var_0 = scripts\mp\gameobjects::getownerteam();
  var_1 = scripts\mp\utility\game::getotherteam(var_0)[0];
  scripts\mp\gameobjects::allowcarry("any");
  scripts\mp\gameobjects::setvisibleteam("none");
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconescort, level.iconkill);
  level.key_activate.ref_11f89 scripts\mp\gameobjects::setvisibleteam("any");

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", scripts\mp\utility\game::getotherteam(self.droppedteam)[0], "status");
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_returned", self.droppedteam, "status");
  }

  self.droppedteam = undefined;

  if(self.ownerteam == "allies") {
    setomnvar("ui_ctf_flag_allies", -2);
  } else {
    setomnvar("ui_ctf_flag_allies", -2);
  }

  self.previouscarrier = undefined;
}

function attachflag() {
  ref_13ff9();
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[var_0], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[var_0];
}

function detachflag() {
  self detach(self.carryflag, "tag_stowed_back3");
  self.carryflag = undefined;
}

function ref_13ffa() {
  self setclientomnvar("ui_match_status_hint_text", 43);
}

function ref_13ff9() {
  self setclientomnvar("ui_match_status_hint_text", 43);
}

function choose_and_drop_tank_near_hostage(var_0) {
  level endon("game_ended");
  level.keeprightdooropen endon("dropped");
  level.keeprightdooropen endon("reset");
  level notify("objTimePointsRunning");
  level endon("objTimePointsRunning");

  while(!level.gameended) {
    wait 1;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      level.keeprightdooropen.carrier scripts\mp\utility\stats::incpersstat("objTime", 1);
      level.keeprightdooropen.carrier scripts\mp\persistence::statsetchild("round", "objTime", level.keeprightdooropen.carrier.pers["objTime"]);
      level.keeprightdooropen.carrier scripts\mp\utility\stats::setextrascore0(level.keeprightdooropen.carrier.pers["objTime"]);
      level.keeprightdooropen.carrier scripts\mp\gamescore::giveplayerscore("tdef_hold_obj", 10);
    }
  }
}

function player_helis(var_0) {
  level endon("game_ended");
  level.keeprightdooropen endon("dropped");
  level.keeprightdooropen endon("reset");
  level notify("portableRadarRunning");
  level endon("portableRadarRunning");

  if(isDefined(level.keeprightdooropen.ref_127eb)) {
    level.keeprightdooropen.ref_127eb clearportableradar();
    level.keeprightdooropen.ref_127eb delete();
  }

  if(!isDefined(var_0)) {
    var_0 = self.team;
  }

  var_1 = relic_vampire(var_0);
  var_2 = spawn("script_model", level.keeprightdooropen.visuals[0].origin);
  var_2.team = scripts\mp\utility\game::getotherteam(var_0)[0];
  var_2.owner = var_1;
  var_2 makeportableradar(var_1);
  level.keeprightdooropen.ref_127eb = var_2;
  thread player_infil_landlord();
  thread player_infil_lbravo();
}

function relic_vampire(var_0) {
  level endon("game_ended");
  self endon("dropped");
  level endon("portableRadarRunning");
  var_1 = 0;

  for(;;) {
    if(level.teamswithplayers.size == 1 && game["state"] == "playing") {
      var_1 = 1;
    } else {
      if(var_1) {
        wait 15;
      }

      var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];
      var_1 = 0;

      foreach(var_4 in level.players) {
        if(isalive(var_4) && var_4.pers["team"] == var_2) {
          return var_4;
        }
      }
    }

    wait 0.05;
  }
}

function player_infil_landlord() {
  level endon("game_ended");
  self endon("dropped");
  self.ref_127eb endon("death");
  level endon("portableRadarRunning");

  for(;;) {
    self.ref_127eb moveTo(self.initscriptablemanagement.origin, 0.05);
    wait 0.05;
  }
}

function player_infil_lbravo() {
  level endon("game_ended");
  self endon("dropped");
  var_0 = self.ref_127eb.team;
  var_0 = scripts\mp\utility\game::getotherteam(var_0)[0];
  self.ref_127eb.owner scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  self.ref_127eb clearportableradar();
  self.ref_127eb = undefined;
  player_helis(var_0);
}

function getrespawndelay() {
  var_0 = level.keeprightdooropen scripts\mp\gameobjects::getownerteam();

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level.spawndelay) {
        return undefined;
      }

      if(level.delayplayer) {
        return level.spawndelay;
      }

      return;
    }

    return;
  }
}

function onplayerconnect(var_0) {
  thread onplayerspawned(var_0);
}

function onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
    var_0 setclientomnvar("ui_ctf_flag_carrier", 0);
    var_0 scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(var_0.pers["objTime"])) {
      var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["objTime"]);
    }

    var_0 scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(var_0.pers["defends"])) {
      var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["defends"]);
    }
  }
}

function onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1 == self) {
    if(isDefined(self.carryflag)) {
      detachflag();
    }

    return;
  }

  var_10 = level.ref_1283a;

  if(isDefined(level.keeprightdooropen) && level.keeprightdooropen scripts\mp\gameobjects::getownerteam() == var_1.pers["team"]) {
    if(isDefined(level.keeprightdooropen.carrier) && var_1 != level.keeprightdooropen.carrier) {
      level.keeprightdooropen.carrier thread scripts\mp\rank::scoreeventpopup("carrier_bonus");
      var_11 = scripts\mp\rank::getscoreinfovalue("carrier_bonus");
      scripts\mp\gamescore::giveplayerscore("carrier_bonus", var_11, self);
      level.keeprightdooropen.carrier thread scripts\mp\rank::giverankxp("carrier_bonus", var_11);
      var_1 thread scripts\mp\rank::scoreeventpopup("kill_bonus");
      var_11 = scripts\mp\rank::getscoreinfovalue("kill_bonus");
      scripts\mp\gamescore::giveplayerscore("kill_bonus", var_11, self);
      var_1 thread scripts\mp\rank::giverankxp("kill_bonus", var_11);
    }

    var_10 = level.ref_1283b;
  } else if(isDefined(self.carryflag)) {
    var_10 = level.ref_12839;
  }

  var_1 scripts\mp\gamescore::giveteamscoreforobjective(var_1.pers["team"], var_10);
  var_12 = 0;
  var_13 = var_1.origin;
  var_14 = 0;

  if(isDefined(var_0)) {
    var_13 = var_0.origin;
    var_14 = var_0 == var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != self.pers["team"]) {
    if(isDefined(var_1.carryflag) && var_14) {
      var_1 thread scripts\mp\rank::scoreeventpopup("carrier_kill");
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_with_flag");
      var_12 = 1;
    }

    if(isDefined(self.carryflag)) {
      var_1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_carrier");
      var_1 scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      var_1 thread scripts\mp\hud_message::showsplash("killed_carrier");
      var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "carrying");
      scripts\mp\utility\game::setmlgannouncement(20, var_1.team, var_1 getentitynumber());
      var_12 = 1;
    }

    if(!var_12) {
      var_15 = 0;
      var_16 = 0;
      var_17 = distsquaredcheck(var_13, self.origin, level.keeprightdooropen.curorigin);

      if(var_17) {
        if(level.keeprightdooropen.ownerteam == self.team) {
          var_15 = 1;
        } else {
          var_16 = 1;
        }
      }

      if(var_15) {
        var_1 thread scripts\mp\rank::scoreeventpopup("assault");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "defending");
        var_1 scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(var_16) {
        var_1 thread scripts\mp\rank::scoreeventpopup("defend");
        var_1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var_1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var_1 scripts\mp\persistence::statsetchild("round", "defends", var_1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var_9, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
    return;
  }
}

function distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

function carriergivescore() {
  level endon("game_ended");
  self endon("death");
  level.keeprightdooropen endon("dropped");
  level.keeprightdooropen endon("reset");

  for(;;) {
    wait level.carrierbonustime;
    thread scripts\mp\utility\points::giveunifiedpoints("ball_carry", undefined, level.carrierbonusscore);
  }
}