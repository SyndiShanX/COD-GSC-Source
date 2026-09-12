/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_timedrun_quest.gsc
******************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("timedrun", 1);

  if(!var_0) {
    return;
  }

  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("timedrun_redacted", 1);

  if(var_0) {
    scripts\mp\gametypes\br_quest_util::ref_12B2A("timedrun_redacted", "brloot_redacted_timedrun_tablet");
    scripts\mp\gametypes\br_quest_util::ref_12B3D("timedrun_redacted", &ref_13DE0);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").ref_11C4C = getdvarint("scr_br_tr_missionTimeBase", 120);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_elevator = getdvarint("scr_br_tr_kioskSearchRadiusMax", 23000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_enemies_cleared = getdvarint("scr_br_tr_kioskSearchRadiusMin", 10000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_delay_and_then_blowup_plane = getdvarint("scr_br_tr_kioskSearchRadiusIdealMax", 23000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_door_open = getdvarint("scr_br_tr_kioskSearchRadiusIdealMin", 17000);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("timedrun", &ref_13C27);
  scripts\mp\gametypes\br_quest_util::ref_12B2E("timedrun", &ref_13C25);

  if(!var_0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12B3D("timedrun", &ref_13DE0);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("timedrun_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("timedrun_locale", &ref_13C1F);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("timedrun_locale", &ref_13C26);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("timedrun_locale", &ref_13C21);
  scripts\mp\gametypes\br_quest_util::ref_12B30("timedrun_locale", &ref_13C28);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("timedrun_locale", &ref_13C1E);
  scripts\mp\gametypes\br_quest_util::registerquestthink("timedrun_locale", &ref_13C20, 0.1);
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
}

function ref_13DE0() {
  var_0 = ref_13C23(self);
  var_1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("timedrun", var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  self.ref_12C4A = var_1;
  return true;
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("timedrun", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_1.team = self.team;
  var_1.startlocation = self.origin;
  var_1.ref_13869 = self;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var_2 = "";

  if(var_0.type == "brloot_redacted_timedrun_tablet") {
    var_2 = "_redacted";
  }

  var_1.modifier = var_2;
  var_3 = ref_13C23(var_0);
  var_1.starttime = gettime();
  var_4 = var_1 scripts\mp\gametypes\br_quest_util::requestquestlocale("timedrun_locale", var_3, 1);
  var_4.team = self.team;

  if(!var_4.enabled) {
    var_1.result = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1297C("timedrun", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("timedrun", &ref_13C24);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297D(getdvarint("scr_br_timedrun_questTimeBase", getdvarint("scr_br_tr_missionTimeBase", 120)), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("timedrun", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("timedrun", self, self.team);
  var_5 = spawnStruct();
  var_5.excludedplayers = [];
  var_5.excludedplayers[0] = self;
  var_5.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("timedrun", scripts\mp\gametypes\br_quest_util::ringing(self.team), var_1.modifier);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_timedrun_quest_start_tablet_finder", var_5);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var_1.team, "br_timedrun_quest_start_team_notify", var_5);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_timedrun_accept", var_1.team, 1, 1);
}

function gethillspawnshutofforigin(var_0) {
  if(var_0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function ref_13C29(var_0) {
  var_1 = spawnStruct();
  var_1.ref_12FA3 = "GetEntitylessScriptableArray";
  var_1.ref_12F9F = var_0;
  var_1.ref_12FA6 = 6000;
  var_1.ref_12FA7 = 0;
  var_1.ref_12FA4 = 4000;
  var_1.ref_12FA5 = 0;
  var_1.mintime = 1;
  return var_1;
}

function ref_13C23(var_0) {
  var_1 = spawnStruct();
  var_1.ref_12FA3 = "getKiosks";
  var_1.partname = "br_plunder_box";
  var_1.statename = "visible";
  var_1.ref_12F9F = var_0.origin;
  var_1.ref_12FA6 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_elevator;
  var_1.ref_12FA7 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_enemies_cleared;
  var_1.ref_12FA4 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_delay_and_then_blowup_plane;
  var_1.ref_12FA5 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_door_open;
  var_1.ref_12FA1 = 1;
  var_1.ref_12C4A = var_0.ref_12C4A;
  var_1.mintime = 1;
  return var_1;
}

function ref_13C22(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(distance2d(self.startlocation, var_2.origin) < 1500) {
      if(isDefined(var_2.vehicle)) {
        return;
      }
    }
  }

  var_4 = getentarrayinradius("script_vehicle", "classname", var_0.ref_12F9F, var_0.ref_12FA6);
  var_4 = sortbydistance(var_4, var_0.ref_12F9F);

  foreach(var_6 in var_4) {
    if(var_6.isempty) {
      self.ref_13A93 = var_6;
      break;
    }

    if(var_6.ownerteam == self.team) {
      break;
    }
  }

  if(!isDefined(self.ref_13A93)) {
    return;
  }

  self.ref_14256 = scripts\mp\utility\outline::outlineenableforteam(self.ref_13A93, self.team, "outlinefill_nodepth_yellow", "level_script");
  thread has_tac_vis();
  thread ref_144B9();
}

function ref_144B9() {
  level endon("game_ended");
  self endon("remove_TR_Outline");
  var_0 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  scripts\engine\utility::waittill_any_ents_array(var_0, "vehicle_enter");

  foreach(var_2 in var_0) {
    if(distance2d(var_2.origin, self.ref_13A93.origin) < 2000) {
      scripts\mp\utility\outline::outlinedisable(self.ref_14256, self.ref_13A93);
      self notify("remove_TR_Outline");
    }
  }
}

function has_tac_vis() {
  level endon("game_ended");
  self endon("remove_TR_Outline");

  for(;;) {
    if(self.ref_13A93.isempty != 1 || gettime() > self.starttime + 60000) {
      scripts\mp\utility\outline::outlinedisable(self.ref_14256, self.ref_13A93);
      self notify("remove_TR_Outline");
    }

    wait 0.2;
  }
}

function ref_13C1F(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("timedrun_locale", "timedrun", self.team);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var_1.curorigin = var_0.origin;
  var_1.modifier = self.modifier;
  var_1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_timedrun_objective", "current", var_1.curorigin + (0, 0, 65));
  scripts\mp\gametypes\br_quest_util::addquestinstance("timedrun_locale", var_1);
  ref_13258(var_1, var_0);
  return var_1;
}

function ref_13258(var_0) {
  if(!isDefined(var_0)) {
    var_1 = self.subscribedinstances[0];

    foreach(var_3 in scripts\mp\utility\teams::getteamdata(var_1.team, "players")) {
      var_3 scripts\mp\utility\lower_message::ref_1316E("br_assassination_notargets", undefined, 5);
    }

    var_1.result = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  self.ref_13A7A = var_4;
  thread ref_13B73(self.ref_13A7A.origin);
  ref_14028();
  return true;
}

function ref_13B73(var_0, var_1) {
  var_2 = spawnfx(level._effect["vfx_marker_base_orange_pulse"], var_0 + (0, 0, 10));
  var_2.angles = vectortoangles((0, 0, 1));
  var_2 hide();
  wait 0.5;
  triggerfx(var_2);

  foreach(var_4 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var_2 showtoplayer(var_4);
  }

  self.play_vo_internal = var_2;
}

function ref_13C27() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13C26() {
  lastplunderbankindex();

  if(isDefined(self.play_vo_internal)) {
    self.play_vo_internal delete();
  }

  self.playerlist = undefined;
  self.subscribedinstances = undefined;
}

function ref_13C20() {
  foreach(var_1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(getdvarint("scr_br_alt_mode_gxp", 0)) {
      if(var_1 scripts\mp\gametypes\br_public::ref_125EC()) {
        continue;
      }
    }

    if(distance(var_1.origin, self.curorigin) < 150) {
      foreach(var_3 in self.subscribedinstances) {
        if(var_3.team == var_1.team) {
          hinttext(var_3, self.ref_13A7A, var_1);
          return;
        }
      }
    }
  }
}

function hinttext(var_0, var_1) {
  var_2 = spawnStruct();
  var_3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var_4 = scripts\mp\gametypes\br_quest_util::getquestindex("timedrun" + self.modifier);
  var_5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("timedrun", self.modifier));
  var_6 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var_1);
  var_2.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_4, var_3, var_5, undefined, var_6);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_complete", var_2);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_misc_success", self.team, 1, 1);
  var_7 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var_9 in var_7) {
    if(isDefined(var_9) && !istrue(var_9.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br_armory_kiosk::wait_for_enemies_inarea(var_0, var_9);
    }
  }

  self.ref_12D2D = undefined;
  self.result = "success";
  self.ref_12D2E = var_0.origin + anglesToForward(var_0.angles) * 32;
  self.ref_12D2B = var_0.angles + (0, -90, 0);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function pattern() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1, 1);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_13C24() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_timedrun_fail", self.team, 1, 1);
}

function ref_13C1E(var_0, var_1) {
  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }

  self.lastcircletick = var_2;
  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      pattern(var_5);
    }

    return;
  }
}

function ref_13C25(var_0) {
  if(var_0.team == self.team) {
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("timedrun_locale", self.team).playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var_0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function ref_13C21(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
}

function ref_13C28(var_0) {
  if(!gethillspawnshutofforigin(var_0)) {
    return;
  }

  var_0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("timedrun" + self.modifier);
  scripts\mp\gametypes\br_quest_util::ref_1336C(var_0);
}

function ref_14028() {
  var_0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var_2 in var_0["valid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("timedrun" + self.modifier);
    scripts\mp\gametypes\br_quest_util::ref_1336C(var_2);
  }

  foreach(var_2 in var_0["invalid"]) {
    var_2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_2);
  }
}

function spawn_ending_individual_guys(var_0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var_0);
  var_0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastplunderbankindex() {
  foreach(var_1 in self.playerlist) {
    spawn_ending_individual_guys(var_1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}