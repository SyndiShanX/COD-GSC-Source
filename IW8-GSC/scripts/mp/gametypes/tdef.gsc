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
  var0 = getEntArray("cyber_emp_pickup_trig", "targetname");

  foreach(var2 in var0) {
    level.keepviewingthe747[level.keepviewingthe747.size] = var2.origin;
  }

  level.keepstreamposfresh = (0, 0, 0);
  var4 = getEntArray("flag_primary", "targetname");

  foreach(var6 in var4) {
    if(var6.script_label == "_b") {
      level.keepstreamposfresh = var6.origin;
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
    var0 = game["attackers"];
    var1 = game["defenders"];
    game["attackers"] = var1;
    game["defenders"] = var0;
  }

  foreach(var3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var3, &"OBJECTIVES/TDEF");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/TDEF");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var3, &"OBJECTIVES/TDEF_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var3, &"OBJECTIVES/TDEF_ATTACKER_HINT");
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
  var0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
  scripts\mp\spawnlogic::registerspawnset("normal", var0);
  scripts\mp\spawnlogic::registerspawnset("fallback", var1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  foreach(var3 in level.spawnpoints) {
    freeze_timer_at_max_time_bomb_case(var3);
  }
}

function freeze_timer_at_max_time_bomb_case(var0) {
  var0.scriptdata.lootchopper_droploot = undefined;
  var1 = getpathdist(var0.origin, level.keepviewingthe747[0], 1000);

  if(var1 < 0) {
    var1 = scripts\engine\utility::distance_2d_squared(var0.origin, level.keepviewingthe747[0]);
  } else {
    var1 *= var1;
  }

  var0.scriptdata.lootchopper_droploot = var1;
}

function getspawnpoint() {
  var0 = self.pers["team"];

  if(game["switchedsides"]) {
    var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  }

  jumpiffalse(scripts\mp\spawnlogic::shoulduseteamstartspawn()) LOC_0000004d;
  var1 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var0 + "_start");
  var2 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var1);
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
  var0 = level.keepviewingthe747[0] + (0, 0, 64);
  var1 = level.keepviewingthe747[0] + (0, 0, -64);
  var2 = scripts\engine\trace::ray_trace(var0, var1, undefined, scripts\engine\trace::create_default_contents(1));
  level.keepviewingthe747[0] = var2["position"];
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

    foreach(var1 in level.teamnamelist) {
      scripts\mp\utility\dialog::leaderdialog("obj_generic_capture", var1);
    }

    return;
  }
}

function init_unlock_silo(var0) {
  level.pickuptime = 0;
  level.returntime = 0;
  var1 = 32;
  var2 = spawn("trigger_radius", level.keepviewingthe747[0], 0, var1, 128);
  var3 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", level.keepviewingthe747[0]));
}

function player_infil_already_played(var0) {
  return !var0 scripts\cp_mp\utility\player_utility::isinvehicle();
}

function init_usb_animations(var0, var1) {
  var2 = var1.visuals[0].origin;
  var3 = spawn("script_model", var2);
  var3 setModel(level.flagbase[var0]);
  var3.ownerteam = "neutral";
  var3 setasgametypeobjective();
  setteaminhuddatafromteamname(var3, var0);
  var3.ref_11f89 = scripts\mp\gameobjects::createobjidobject(var2, "neutral", (0, 0, 85), undefined, "any", 0);
  var3.ref_11f89 scripts\mp\gameobjects::setvisibleteam("any");

  if(level.player_has_respawn_munition) {
    var1.trigger scripts\engine\utility::trigger_off();
    var3.ref_11f89 scripts\mp\gameobjects::ref_1317f(level.icontarget, level.icontarget, level.ref_11c60);
  } else {
    var3.ref_11f89 scripts\mp\gameobjects::ref_1317f(level.iconcaptureflag, level.iconcaptureflag, level.ref_11c60);
  }

  return var3;
}

function setteaminhuddatafromteamname(var0) {
  if(var0 == "axis") {
    self setteaminhuddata(1);
    return;
  }

  if(var0 == "allies") {
    self setteaminhuddata(2);
    return;
  }

  self setteaminhuddata(0);
}

function onpickup(var0, var1, var2) {
  self notify("picked_up");
  var0 notify("obj_picked_up");
  level.key_activate.ref_11f89 scripts\mp\gameobjects::setvisibleteam("none");
  level.keeprightdooropen.initscriptablemanagement = var0;
  thread choose_and_drop_tank_near_hostage();
  thread player_helis();
  var3 = scripts\mp\gameobjects::getownerteam();
  scripts\mp\gameobjects::setownerteam(var0.team);
  var4 = var0.pers["team"];

  if(var4 == "allies") {
    var5 = "axis";
  } else {
    var5 = "allies";
  }

  attachflag(var1);
  var1 scripts\mp\utility\stats::incpersstat("pickups", 1);

  if(self.ownerteam == "allies") {
    setomnvar("ui_ctf_flag_allies", var1 getentitynumber());
  } else {
    setomnvar("ui_ctf_flag_allies", var1 getentitynumber());
  }

  var1 setclientomnvar("ui_ctf_flag_carrier", 1);

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
      objective_setownerteam(self.pingobjidnum, var5);
    }
  }

  scripts\mp\gameobjects::ref_1317f(level.iconescort, level.iconkill, level.ref_11c60);
  scripts\mp\utility\print::printandsoundoneveryone(var5, var5, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", var1);

  if(!level.gameended) {
    scripts\mp\utility\dialog::leaderdialog("enemy_flag_taken", var5);
    scripts\mp\utility\dialog::leaderdialog("flag_getback", var5);
  }

  thread scripts\mp\hud_util::teamplayercardsplash("callout_flagpickup", var1);
  var1 thread scripts\mp\hud_message::showsplash("flagpickup");

  if(!isDefined(self.previouscarrier) || self.previouscarrier != var1) {
    var1 thread scripts\mp\utility\points::giveunifiedpoints("flag_grab");
  }

  var1 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var1.origin);
  self.previouscarrier = var1;

  if(level.codcasterenabled) {
    var1 setgametypevip(1);
    return;
  }
}

function returnflag() {
  scripts\mp\gameobjects::returnhome();
}

function ondrop(var0) {
  if(isDefined(var0.leaving_team)) {
    self.droppedteam = var0.leaving_team;
    var0.leaving_team = undefined;
  } else if(!isDefined(var0)) {
    self.droppedteam = self.ownerteam;
  } else {
    self.droppedteam = var0.team;
  }

  level.keeprightdooropen.initscriptablemanagement = undefined;

  if(isDefined(var0)) {
    ref_13ffa(var0);
  }

  scripts\mp\gameobjects::setownerteam("neutral");
  var1 = self.droppedteam;
  var2 = scripts\mp\utility\game::getotherteam(self.droppedteam)[0];
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

  if(isDefined(var0)) {
    var0 setclientomnvar("ui_ctf_flag_carrier", 0);
  }

  if(isDefined(var0)) {
    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      var0.carryobject.previouscarrier = undefined;
    }

    if(isDefined(var0.carryflag)) {
      detachflag(var0);
    }

    scripts\mp\utility\print::printandsoundoneveryone(var2, "none", undefined, undefined, "mp_war_objective_lost", "", var0);

    if(level.codcasterenabled) {
      var0 setgametypevip(0);
    }
  } else {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);
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
  var0 = 0;

  while(var0 < level.idleresettime) {
    waitframe();

    if(self.claimteam == "none") {
      var0 += level.framedurationseconds;
    }
  }

  foreach(var2 in level.teamnamelist) {
    scripts\mp\utility\sound::playsoundonplayers("mp_war_objective_lost", var2);
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

  var0 = scripts\mp\gameobjects::getownerteam();
  var1 = scripts\mp\utility\game::getotherteam(var0)[0];
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
  var0 = scripts\mp\utility\game::getotherteam(self.pers["team"])[0];
  self attach(level.carryflag[var0], "tag_stowed_back3", 1);
  self.carryflag = level.carryflag[var0];
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

function choose_and_drop_tank_near_hostage(var0) {
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

function player_helis(var0) {
  level endon("game_ended");
  level.keeprightdooropen endon("dropped");
  level.keeprightdooropen endon("reset");
  level notify("portableRadarRunning");
  level endon("portableRadarRunning");

  if(isDefined(level.keeprightdooropen.ref_127eb)) {
    level.keeprightdooropen.ref_127eb clearportableradar();
    level.keeprightdooropen.ref_127eb delete();
  }

  if(!isDefined(var0)) {
    var0 = self.team;
  }

  var1 = relic_vampire(var0);
  var2 = spawn("script_model", level.keeprightdooropen.visuals[0].origin);
  var2.team = scripts\mp\utility\game::getotherteam(var0)[0];
  var2.owner = var1;
  var2 makeportableradar(var1);
  level.keeprightdooropen.ref_127eb = var2;
  thread player_infil_landlord();
  thread player_infil_lbravo();
}

function relic_vampire(var0) {
  level endon("game_ended");
  self endon("dropped");
  level endon("portableRadarRunning");
  var1 = 0;

  for(;;) {
    if(level.teamswithplayers.size == 1 && game["state"] == "playing") {
      var1 = 1;
    } else {
      if(var1) {
        wait 15;
      }

      var2 = scripts\mp\utility\game::getotherteam(var0)[0];
      var1 = 0;

      foreach(var4 in level.players) {
        if(isalive(var4) && var4.pers["team"] == var2) {
          return var4;
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
  var0 = self.ref_127eb.team;
  var0 = scripts\mp\utility\game::getotherteam(var0)[0];
  self.ref_127eb.owner scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  self.ref_127eb clearportableradar();
  self.ref_127eb = undefined;
  player_helis(var0);
}

function getrespawndelay() {
  var0 = level.keeprightdooropen scripts\mp\gameobjects::getownerteam();

  if(isDefined(var0)) {
    if(self.pers["team"] == var0) {
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

function onplayerconnect(var0) {
  thread onplayerspawned(var0);
}

function onplayerspawned(var0) {
  for(;;) {
    var0 waittill("spawned");
    var0 setclientomnvar("ui_ctf_flag_carrier", 0);
    var0 scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(var0.pers["objTime"])) {
      var0 scripts\mp\utility\stats::setextrascore0(var0.pers["objTime"]);
    }

    var0 scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(var0.pers["defends"])) {
      var0 scripts\mp\utility\stats::setextrascore1(var0.pers["defends"]);
    }
  }
}

function onplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isPlayer(var1) || var1 == self) {
    if(isDefined(self.carryflag)) {
      detachflag();
    }

    return;
  }

  var10 = level.ref_1283a;

  if(isDefined(level.keeprightdooropen) && level.keeprightdooropen scripts\mp\gameobjects::getownerteam() == var1.pers["team"]) {
    if(isDefined(level.keeprightdooropen.carrier) && var1 != level.keeprightdooropen.carrier) {
      level.keeprightdooropen.carrier thread scripts\mp\rank::scoreeventpopup("carrier_bonus");
      var11 = scripts\mp\rank::getscoreinfovalue("carrier_bonus");
      scripts\mp\gamescore::giveplayerscore("carrier_bonus", var11, self);
      level.keeprightdooropen.carrier thread scripts\mp\rank::giverankxp("carrier_bonus", var11);
      var1 thread scripts\mp\rank::scoreeventpopup("kill_bonus");
      var11 = scripts\mp\rank::getscoreinfovalue("kill_bonus");
      scripts\mp\gamescore::giveplayerscore("kill_bonus", var11, self);
      var1 thread scripts\mp\rank::giverankxp("kill_bonus", var11);
    }

    var10 = level.ref_1283b;
  } else if(isDefined(self.carryflag)) {
    var10 = level.ref_12839;
  }

  var1 scripts\mp\gamescore::giveteamscoreforobjective(var1.pers["team"], var10);
  var12 = 0;
  var13 = var1.origin;
  var14 = 0;

  if(isDefined(var0)) {
    var13 = var0.origin;
    var14 = var0 == var1;
  }

  if(isDefined(var1) && isPlayer(var1) && var1.pers["team"] != self.pers["team"]) {
    if(isDefined(var1.carryflag) && var14) {
      var1 thread scripts\mp\rank::scoreeventpopup("carrier_kill");
      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_with_flag");
      var12 = 1;
    }

    if(isDefined(self.carryflag)) {
      var1 thread scripts\mp\awards::givemidmatchaward("mode_ctf_kill_carrier");
      var1 scripts\mp\utility\stats::incpersstat("carrierKills", 1);
      var1 thread scripts\mp\hud_message::showsplash("killed_carrier");
      var1 scripts\mp\utility\stats::incpersstat("defends", 1);
      var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
      thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "carrying");
      scripts\mp\utility\game::setmlgannouncement(20, var1.team, var1 getentitynumber());
      var12 = 1;
    }

    if(!var12) {
      var15 = 0;
      var16 = 0;
      var17 = distsquaredcheck(var13, self.origin, level.keeprightdooropen.curorigin);

      if(var17) {
        if(level.keeprightdooropen.ownerteam == self.team) {
          var15 = 1;
        } else {
          var16 = 1;
        }
      }

      if(var15) {
        var1 thread scripts\mp\rank::scoreeventpopup("assault");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "defending");
        var1 scripts\mp\utility\stats::incpersstat("assaults", 1);
      } else if(var16) {
        var1 thread scripts\mp\rank::scoreeventpopup("defend");
        var1 thread scripts\mp\awards::givemidmatchaward("mode_x_defend");
        var1 scripts\mp\utility\stats::incpersstat("defends", 1);
        var1 scripts\mp\persistence::statsetchild("round", "defends", var1.pers["defends"]);
        thread scripts\common\utility::ref_13e0a(level.ref_11b30, var9, "assaulting");
      }
    }
  }

  if(isDefined(self.carryflag)) {
    detachflag();
    return;
  }
}

function distsquaredcheck(var0, var1, var2) {
  var3 = distancesquared(var2, var0);
  var4 = distancesquared(var2, var1);

  if(var3 < 90000 || var4 < 90000) {
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