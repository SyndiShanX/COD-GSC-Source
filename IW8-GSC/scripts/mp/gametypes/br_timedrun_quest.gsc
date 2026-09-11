/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_timedrun_quest.gsc
******************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("timedrun", 1);

  if(!var0) {
    return;
  }

  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("timedrun_redacted", 1);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("timedrun_redacted", "brloot_redacted_timedrun_tablet");
    scripts\mp\gametypes\br_quest_util::ref_12b3d("timedrun_redacted", &ref_13de0);
  }

  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").ref_11c4c = getdvarint("scr_br_tr_missionTimeBase", 120);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_elevator = getdvarint("scr_br_tr_kioskSearchRadiusMax", 23000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_enemies_cleared = getdvarint("scr_br_tr_kioskSearchRadiusMin", 10000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_delay_and_then_blowup_plane = getdvarint("scr_br_tr_kioskSearchRadiusIdealMax", 23000);
  scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_door_open = getdvarint("scr_br_tr_kioskSearchRadiusIdealMin", 17000);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("timedrun", &ref_13c27);
  scripts\mp\gametypes\br_quest_util::ref_12b2e("timedrun", &ref_13c25);

  if(!var0) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b3d("timedrun", &ref_13de0);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("timedrun_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("timedrun_locale", &ref_13c1f);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("timedrun_locale", &ref_13c26);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("timedrun_locale", &ref_13c21);
  scripts\mp\gametypes\br_quest_util::ref_12b30("timedrun_locale", &ref_13c28);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("timedrun_locale", &ref_13c1e);
  scripts\mp\gametypes\br_quest_util::registerquestthink("timedrun_locale", &ref_13c20, 0.1);
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
}

function ref_13de0() {
  var0 = ref_13c23(self);
  var1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("timedrun", var0);

  if(!isDefined(var1)) {
    return false;
  }

  self.ref_12c4a = var1;
  return true;
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("timedrun", self.team, var0.index, var0);
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1.team = self.team;
  var1.startlocation = self.origin;
  var1.ref_13869 = self;
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  var2 = "";

  if(var0.type == "brloot_redacted_timedrun_tablet") {
    var2 = "_redacted";
  }

  var1.modifier = var2;
  var3 = ref_13c23(var0);
  var1.starttime = gettime();
  var4 = var1 scripts\mp\gametypes\br_quest_util::requestquestlocale("timedrun_locale", var3, 1);
  var4.team = self.team;

  if(!var4.enabled) {
    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_1297c("timedrun", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("timedrun", &ref_13c24);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(getdvarint("scr_br_timedrun_questTimeBase", getdvarint("scr_br_tr_missionTimeBase", 120)), 4);
  scripts\mp\gametypes\br_quest_util::addquestinstance("timedrun", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("timedrun", self, self.team);
  var5 = spawnStruct();
  var5.excludedplayers = [];
  var5.excludedplayers[0] = self;
  var5.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("timedrun", scripts\mp\gametypes\br_quest_util::ringing(self.team), var1.modifier);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_timedrun_quest_start_tablet_finder", var5);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(var1.team, "br_timedrun_quest_start_team_notify", var5);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_timedrun_accept", var1.team, 1, 1);
}

function gethillspawnshutofforigin(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    return 1;
  }

  return 0;
}

function ref_13c29(var0) {
  var1 = spawnStruct();
  var1.ref_12fa3 = "GetEntitylessScriptableArray";
  var1.ref_12f9f = var0;
  var1.ref_12fa6 = 6000;
  var1.ref_12fa7 = 0;
  var1.ref_12fa4 = 4000;
  var1.ref_12fa5 = 0;
  var1.mintime = 1;
  return var1;
}

function ref_13c23(var0) {
  var1 = spawnStruct();
  var1.ref_12fa3 = "getKiosks";
  var1.partname = "br_plunder_box";
  var1.statename = "visible";
  var1.ref_12f9f = var0.origin;
  var1.ref_12fa6 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_elevator;
  var1.ref_12fa7 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_enemies_cleared;
  var1.ref_12fa4 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_delay_and_then_blowup_plane;
  var1.ref_12fa5 = scripts\mp\gametypes\br_quest_util::getquestdata("timedrun").wait_for_door_open;
  var1.ref_12fa1 = 1;
  var1.ref_12c4a = var0.ref_12c4a;
  var1.mintime = 1;
  return var1;
}

function ref_13c22(var0) {
  foreach(var2 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(distance2d(self.startlocation, var2.origin) < 1500) {
      if(isDefined(var2.vehicle)) {
        return;
      }
    }
  }

  var4 = getentarrayinradius("script_vehicle", "classname", var0.ref_12f9f, var0.ref_12fa6);
  var4 = sortbydistance(var4, var0.ref_12f9f);

  foreach(var6 in var4) {
    if(var6.isempty) {
      self.ref_13a93 = var6;
      break;
    }

    if(var6.ownerteam == self.team) {
      break;
    }
  }

  if(!isDefined(self.ref_13a93)) {
    return;
  }

  self.ref_14256 = scripts\mp\utility\outline::outlineenableforteam(self.ref_13a93, self.team, "outlinefill_nodepth_yellow", "level_script");
  thread has_tac_vis();
  thread ref_144b9();
}

function ref_144b9() {
  level endon("game_ended");
  self endon("remove_TR_Outline");
  var0 = scripts\mp\utility\teams::getteamdata(self.team, "players");
  scripts\engine\utility::waittill_any_ents_array(var0, "vehicle_enter");

  foreach(var2 in var0) {
    if(distance2d(var2.origin, self.ref_13a93.origin) < 2000) {
      scripts\mp\utility\outline::outlinedisable(self.ref_14256, self.ref_13a93);
      self notify("remove_TR_Outline");
    }
  }
}

function has_tac_vis() {
  level endon("game_ended");
  self endon("remove_TR_Outline");

  for(;;) {
    if(self.ref_13a93.isempty != 1 || gettime() > self.starttime + 60000) {
      scripts\mp\utility\outline::outlinedisable(self.ref_14256, self.ref_13a93);
      self notify("remove_TR_Outline");
    }

    wait 0.2;
  }
}

function ref_13c1f(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("timedrun_locale", "timedrun", self.team);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var1.playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");
  var1.curorigin = var0.origin;
  var1.modifier = self.modifier;
  var1 scripts\mp\gametypes\br_quest_util::init_tape_machine_animations("ui_mp_br_mapmenu_icon_timedrun_objective", "current", var1.curorigin + (0, 0, 65));
  scripts\mp\gametypes\br_quest_util::addquestinstance("timedrun_locale", var1);
  ref_13258(var1, var0);
  return var1;
}

function ref_13258(var0) {
  if(!isDefined(var0)) {
    var1 = self.subscribedinstances[0];

    foreach(var3 in scripts\mp\utility\teams::getteamdata(var1.team, "players")) {
      var3 scripts\mp\utility\lower_message::ref_1316e("br_assassination_notargets", undefined, 5);
    }

    var1.result = "no_locale";
    var1 scripts\mp\gametypes\br_quest_util::removequestinstance();
    return false;
  }

  self.ref_13a7a = var4;
  thread ref_13b73(self.ref_13a7a.origin);
  ref_14028();
  return true;
}

function ref_13b73(var0, var1) {
  var2 = spawnfx(level._effect["vfx_marker_base_orange_pulse"], var0 + (0, 0, 10));
  var2.angles = vectortoangles((0, 0, 1));
  var2 hide();
  wait 0.5;
  triggerfx(var2);

  foreach(var4 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    var2 showtoplayer(var4);
  }

  self.play_vo_internal = var2;
}

function ref_13c27() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
}

function ref_13c26() {
  lastplunderbankindex();

  if(isDefined(self.play_vo_internal)) {
    self.play_vo_internal delete();
  }

  self.playerlist = undefined;
  self.subscribedinstances = undefined;
}

function ref_13c20() {
  foreach(var1 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(getdvarint("scr_br_alt_mode_gxp", 0)) {
      if(var1 scripts\mp\gametypes\br_public::ref_125ec()) {
        continue;
      }
    }

    if(distance(var1.origin, self.curorigin) < 150) {
      foreach(var3 in self.subscribedinstances) {
        if(var3.team == var1.team) {
          hinttext(var3, self.ref_13a7a, var1);
          return;
        }
      }
    }
  }
}

function hinttext(var0, var1) {
  var2 = spawnStruct();
  var3 = scripts\mp\gametypes\br_quest_util::ringing(self.team);
  var4 = scripts\mp\gametypes\br_quest_util::getquestindex("timedrun" + self.modifier);
  var5 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("timedrun", self.modifier));
  var6 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var1);
  var2.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var4, var3, var5, undefined, var6);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_complete", var2);
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_misc_success", self.team, 1, 1);
  var7 = scripts\mp\utility\teams::getteamdata(self.team, "players");

  foreach(var9 in var7) {
    if(isDefined(var9) && !istrue(var9.delay_enter_combat_after_investigating_grenade)) {
      scripts\mp\gametypes\br_armory_kiosk::wait_for_enemies_inarea(var0, var9);
    }
  }

  self.ref_12d2d = undefined;
  self.result = "success";
  self.ref_12d2e = var0.origin + anglesToForward(var0.angles) * 32;
  self.ref_12d2b = var0.angles + (0, -90, 0);
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function pattern() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_circle_failure");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", self.team, 1, 1);
  self.result = "fail";
  scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function ref_13c24() {
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_timedrun_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_timedrun_fail", self.team, 1, 1);
}

function ref_13c1e(var0, var1) {
  if(!isDefined(self.lastcircletick)) {
    self.lastcircletick = -1;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;
  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      pattern(var5);
    }

    return;
  }
}

function ref_13c25(var0) {
  if(var0.team == self.team) {
    scripts\mp\gametypes\br_quest_util::getquestinstancedata("timedrun_locale", self.team).playerlist = scripts\mp\utility\teams::getteamdata(self.team, "players");

    if(!scripts\mp\gametypes\br_quest_util::isteamvalid(var0.team)) {
      self.result = "fail";
      scripts\mp\gametypes\br_quest_util::removequestinstance();
      return;
    }

    return;
  }
}

function ref_13c21(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
}

function ref_13c28(var0) {
  if(!gethillspawnshutofforigin(var0)) {
    return;
  }

  var0 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("timedrun" + self.modifier);
  scripts\mp\gametypes\br_quest_util::ref_1336c(var0);
}

function ref_14028() {
  var0 = scripts\mp\gametypes\br_quest_util::sortvalidplayersinarray(self.playerlist);

  foreach(var2 in var0["valid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectiveshow("timedrun" + self.modifier);
    scripts\mp\gametypes\br_quest_util::ref_1336c(var2);
  }

  foreach(var2 in var0["invalid"]) {
    var2 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var2);
  }
}

function spawn_ending_individual_guys(var0) {
  scripts\mp\gametypes\br_quest_util::spawn_downed_friendly(var0);
  var0 scripts\mp\gametypes\br_quest_util::uiobjectivehide();
}

function lastplunderbankindex() {
  foreach(var1 in self.playerlist) {
    spawn_ending_individual_guys(var1);
  }

  scripts\mp\gametypes\br_quest_util::lastdropedtime();
}