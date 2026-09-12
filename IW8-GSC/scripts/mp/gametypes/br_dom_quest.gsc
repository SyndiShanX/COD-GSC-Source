/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dom_quest.gsc
*************************************************/

function init() {
  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("domination", 1);

  if(!var_0) {
    return;
  }

  var_0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("domination_redacted", 1);

  if(var_0) {
    scripts\mp\gametypes\br_quest_util::ref_12B2A("domination_redacted", "brloot_redacted_domination_tablet");
    scripts\mp\gametypes\br_quest_util::ref_12B3D("domination_redacted", &markplayeraseliminatedonkilled);
  }

  scripts\mp\gametypes\br_quest_util::ref_12B3D("domination", &markplayeraseliminatedonkilled);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("domination", &domquest_removequestinstance);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("dom_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("dom_locale", &domlocale_createquestlocale);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("dom_locale", &domlocale_checkiflocaleisavailable);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("dom_locale", &domlocale_removelocaleinstance);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("dom_locale", &domlocale_circletick);
  scripts\mp\gametypes\br_quest_util::ref_12B2D("dom_locale", &marked_for_no_death);
  scripts\mp\gametypes\br_quest_util::ref_12B30("dom_locale", &markedentities_removeentsbyindex);
  scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid = 0;
  scripts\mp\gametypes\br_quest_util::ref_1297C("domination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12B31("domination", &maphint_offerscriptableused);
  ref_13239();
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
}

function domquest_removequestinstance() {
  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
  scripts\mp\gametypes\br_quest_util::uiobjectivehidefromteam(self.team);

  if(isDefined(self.tablet.trackriotshield_grenadepullbackforc4)) {
    [[self.tablet.trackriotshield_grenadepullbackforc4]](self);
  }

  thread mark_phone_guy_once_all_spawned();
}

function domlocale_removelocaleinstance() {
  foreach(var_1 in self.subscribedinstances) {
    var_1 thread scripts\mp\gametypes\br_quest_util::removequestinstance();
  }

  deletedomflaggameobject();
  self.domflag = undefined;
}

function markplayeraseliminatedonkilled() {
  var_0 = role_edit(self);
  var_1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("domination", var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  getlootspawnpointcount(var_1.index);
  self.ref_12C4A = var_1;
  return true;
}

function domlocale_createquestlocale(var_0) {
  scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid++;
  var_1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("dom_locale", "domination", "DomPoint:" + scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid);

  if(!isDefined(var_0)) {
    var_1.curorigin = (0, 0, 0);
    var_1.enabled = 0;
    return var_1;
  }

  var_2 = var_0.origin;

  if(var_0.spawnflags & 7) {}

  var_3 = scripts\mp\gametypes\br_quest_util::ref_12971(var_0);
  var_4 = spawn("trigger_radius", var_2, 0, int(var_3), int(level.defend_wave_3));
  level.setdomscriptablepartstatefunc = &domflag_setdomscriptablepartstate;
  var_5 = scripts\mp\gametypes\obj_dom::setupobjective(var_4, undefined, undefined, undefined, undefined, 0);
  var_5.squadindex = self.squadindex;
  var_5.onuse = &domflag_onuse;
  var_5.onbeginuse = &mark_danger_timeout;
  var_5.onuseupdate = &domflag_onuseupdate;
  var_5.onenduse = &domflag_onenduse;
  var_5.usecondition = &mark_loot;
  var_5.lockupdatingicons = 1;
  var_5.getrandompointincirclewithindistance = 1;

  if(istrue(self.tablet.ref_11FF8) && isDefined(var_0.traincar)) {
    if(istrue(level.ref_145F1.maphint_debugthink)) {
      var_5.flagmodel setModel("lm_domination_point_01_mover_nocol");
    } else {
      var_5.flagmodel setModel("lm_domination_point_01_mover");
    }

    var_6 = var_0.traincar.maphint_keypadscriptableused;
    var_7 = var_0.traincar.angles;

    if(isDefined(var_0.traincar.manageworldspawnedprojectiles)) {
      var_7 = var_0.traincar.manageworldspawnedprojectiles;
    }

    var_5.flagmodel linkTo(var_0.traincar.wz_tease, "tag_origin", var_6, var_7);
    var_4 enablelinkTo();
    var_4 linkTo(var_5.flagmodel);

    if(isDefined(var_5.visuals) && isarray(var_5.visuals)) {
      foreach(var_9 in var_5.visuals) {
        var_9 linkTo(var_5.flagmodel);
      }
    }

    var_5.scriptable linkTo(var_0.traincar.wz_tease);
    var_5.traincar = var_0.traincar;
    scripts\mp\objidpoolmanager::update_objective_onentity(var_5.objidnum, var_5.flagmodel);
  } else {
    var_5.flagmodel setModel("x2_military_old_recon_station");
    scripts\mp\objidpoolmanager::update_objective_position(var_5.objidnum, var_5.curorigin + (0, 0, 60));
  }

  level.flagcapturetime = getdvarfloat("scr_br_dom_quest_capture_time", 30);
  var_5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var_1.lastcircletick = -1;
  var_1.domflag = var_5;
  var_1.curorigin = var_5.curorigin;
  var_5.locale = var_1;
  var_5.flagmodel.unresolved_collision_func = &ref_13F27;
  scripts\mp\gametypes\br_quest_util::addquestinstance("dom_locale", var_1);
  return var_1;
}

function domlocale_checkiflocaleisavailable(var_0) {
  var_1 = getdvarfloat("scr_br_dom_quest_max_capture_percent", 0.2);
  var_2 = getdvarfloat("scr_br_dom_quest_max_teams", 4);
  var_3 = 0;

  if(isDefined(self.domflag.curprogress)) {
    var_3 = self.domflag.curprogress / self.domflag.usetime;
  }

  if(var_3 > var_1) {
    return false;
  }

  if(self.subscribedinstances.size >= var_2) {
    return false;
  }

  return true;
}

function domlocale_circletick(var_0, var_1) {
  if(!isDefined(self.domflag)) {
    return;
  }

  var_2 = gettime();

  if(self.lastcircletick == var_2) {
    return;
  }

  self.lastcircletick = var_2;

  if(isDefined(self.domflag) && isDefined(self.domflag.traincar)) {
    self.curorigin = self.domflag.traincar.origin;
  }

  var_3 = distance2d(self.curorigin, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self.subscribedinstances) {
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var_5.team, "br_domination_quest_circle_failure");
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", var_5.team, 1);
      var_5.result = "circle";

      if(isDefined(var_5.tablet.trackriotshield_grenadepullbackforc4)) {
        [[var_5.tablet.trackriotshield_grenadepullbackforc4]](var_5);
      }
    }

    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }
}

function marked_for_no_death(var_0) {
  mark_danger(var_0);
}

function markedentities_removeentsbyindex(var_0) {
  if(var_0.team == self.subscribedinstances[0].team) {
    mark_location(var_0);
    return;
  }
}

function takequestitem(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::createquestinstance("domination", self.team, var_0.index, var_0, self.squadindex);
  var_2 = "";

  if(var_0.type == "brloot_redacted_domination_tablet") {
    var_2 = "_redacted";
  }

  var_1.modifier = var_2;
  var_1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::ref_12B15(self);
  var_1.team = self.team;
  var_1.tablet = var_0;
  var_3 = getdvarint("scr_br_DOM_questTime", 240);
  var_1 scripts\mp\gametypes\br_quest_util::ref_1297D(var_3, 4);
  var_4 = role_edit(var_0);
  var_5 = var_1 scripts\mp\gametypes\br_quest_util::requestquestlocale("dom_locale", var_4, 1);

  if(!var_5.enabled) {
    var_1.result = "no_locale";

    if(isDefined(var_1.tablet.trackriotshield_grenadepullbackforc4)) {
      [[var_1.tablet.trackriotshield_grenadepullbackforc4]](var_1);
    }

    var_1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  domflagupdateicons(var_5);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("domination" + var_1.modifier, self.team);
  scripts\mp\gametypes\br_quest_util::addquestinstance("domination", var_1);
  scripts\mp\gametypes\br_quest_util::ref_13879("domination", self, self.team);
  var_6 = spawnStruct();
  var_6.excludedplayers = [];
  var_6.excludedplayers[0] = self;
  var_6.ref_127D5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("domination", scripts\mp\gametypes\br_quest_util::ringing(self.team), var_1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_domination_quest_start_team", var_6);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_domination_quest_start_tablet_finder", var_6);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var_1.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("domination"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_dom_accept", var_1.team, 1);
  return var_1;
}

function domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(var_1 in self.subscribedinstances) {
    foreach(var_3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1.team, self.squadindex)) {
      if(!var_3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(self.domflag.objidnum, var_3);
      }
    }
  }
}

function mark_danger(var_0) {
  objective_removeclientfrommask(self.domflag.objidnum, var_0);
}

function mark_location(var_0) {
  objective_addclienttomask(self.domflag.objidnum, var_0);
}

function mark_phone_guy_once_all_spawned() {
  self endon("removed");
  waittillframeend();
  domflagupdateicons();
}

function deletedomflaggameobject() {
  foreach(var_1 in self.domflag.visuals) {
    var_1 delete();
  }

  if(isDefined(self.domflag.flagmodel)) {
    self.domflag.flagmodel delete();
  }

  if(isDefined(self.domflag.scriptable)) {
    self.domflag.scriptable delete();
  }

  if(isDefined(self.domflag.trigger)) {
    self.domflag.trigger delete();
    self.domflag.trigger = undefined;
  }

  thread gameobjectreleaseid_delayed();
  self.domflag notify("deleted");
}

function gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

function ref_13239() {
  if(isDefined(level.defend_wave_3)) {
    return;
  }

  level.disableinitplayergameobjects = 0;
  level.defend_wave_3 = 120;
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  level.squadspawndebug = "icon_waypoint_ot";
  _setdomflagiconinfo("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _setdomflagiconinfo("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _setdomflagiconinfo("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

function _setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[var_0] = var_3;
}

function domflag_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 < 1 && !level.gameended) {
    ref_12427(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function mark_danger_timeout(var_0) {
  if(!isDefined(self.ref_11F63) || !self.ref_11F63) {
    self.ref_11F63 = 1;

    if(isDefined(self.traincar)) {
      if(isDefined(level.ref_145F1) && istrue(level.ref_145F1.mark_armor)) {
        var_1 = self.traincar.maphint_keypadscriptableused + (200, 0, 0);
        var_2 = self.traincar.origin + rotatevector(var_1, self.traincar.angles);
        level thread scripts\mp\gametypes\br_quest_util::ref_140B1(var_2, "dom", 3);
      }
    } else {
      level thread scripts\mp\gametypes\br_quest_util::ref_140B1(self.curorigin, "dom");
    }

    var_3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, self.squadindex);
    var_4 = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, var_3);

    foreach(var_6 in var_4) {
      if(isDefined(var_6) && isalive(var_6)) {
        var_6 thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
      }
    }

    var_8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_0.team, self.squadindex);

    foreach(var_10 in var_8) {
      var_10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function domflag_onuse(var_0) {
  foreach(var_2 in self.locale.subscribedinstances) {
    if(var_2.team == var_0.team) {
      var_3 = spawnStruct();
      var_4 = scripts\mp\gametypes\br_quest_util::ringing(var_0.team);
      var_5 = scripts\mp\gametypes\br_quest_util::getquestindex("domination" + var_2.modifier);
      var_6 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("domination", var_2.modifier));
      var_7 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var_0);
      var_3.ref_121B5 = scripts\mp\gametypes\br_quest_util::ref_121B9(var_5, var_4, var_6, undefined, var_7);
      self.squadindex = var_2.squadindex;
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var_2.team, "br_domination_quest_complete", var_3);
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var_2.team, var_0, 8, var_5);
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_dom_success", var_2.team, 1, 1);
      var_2.ref_12D2E = self.flagmodel.origin;
      var_2.ref_12D2B = self.flagmodel.angles;
      var_2.result = "success";

      if(isDefined(var_2.tablet.trackriotshield_grenadepullbackforc4)) {
        [[var_2.tablet.trackriotshield_grenadepullbackforc4]](var_2);
      }

      if(isDefined(self.assisttouchlist[var_2.team])) {
        var_8 = getarraykeys(self.assisttouchlist[var_2.team]);

        foreach(var_10 in var_8) {
          var_11 = self.assisttouchlist[var_2.team][var_10].player;

          if(isDefined(var_11.owner)) {
            var_11 = var_11.owner;
          }

          if(!isPlayer(var_11)) {
            continue;
          }

          var_11 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_complete_recon_objective_for_operator_mission", 1);
          var_11 scripts\cp\vehicles\vehicle_compass_cp::ref_12C3F("t9_ch_global_complete_recon_objective_for_operator_mission_op2", 1);
          var_2 scripts\mp\gametypes\br_quest_util::ref_12B15(var_11);
        }
      }

      continue;
    }

    scripts\mp\gametypes\br_quest_util::displayteamsplash(var_2.team, "br_domination_quest_failure");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", var_2.team, 1);
    var_2.result = "fail";

    if(isDefined(var_2.tablet.trackriotshield_grenadepullbackforc4)) {
      [[var_2.tablet.trackriotshield_grenadepullbackforc4]](var_2);
    }
  }

  self.locale thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function domflag_onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var_0, var_1, var_2);
}

function ref_12427(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
    return;
  }
}

function domflag_setdomscriptablepartstate(var_0, var_1, var_2) {
  switch (var_1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var_1 = "using";

      if(isDefined(var_2)) {
        var_1 += var_2;
      }

      self.scriptable setscriptablepartstate(var_0, var_1);

      if(var_0 == "pulse") {
        self.scriptable setscriptablepartstate("flag", var_1);
      }

      return 1;
  }
}

function mark_loot(var_0) {
  if(getdvarint("scr_br_alt_mode_gxp", 0)) {
    if(var_0 scripts\mp\gametypes\br_public::ref_125EC()) {
      return false;
    }
  }

  var_1 = var_0.team;

  foreach(var_3 in self.locale.subscribedinstances) {
    if(var_3.team == var_1) {
      return true;
    }
  }

  return false;
}

function maphint_offerscriptableused() {
  while(self.ref_1393B.domflag.numtouching[self.id]) {
    waitframe();
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.id, "br_domination_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function role_edit(var_0) {
  var_1 = spawnStruct();
  var_1.ref_12FA3 = "questPointsArray";
  var_1.ref_12F9F = (var_0.origin[0], var_0.origin[1], 0);
  var_1.ref_12FA6 = 12000;
  var_1.ref_12FA7 = 0;
  var_1.ref_12FA4 = 8000;
  var_1.ref_12FA5 = 6000;
  var_1.ref_1297F = 7;
  var_1.mintime = getdvarfloat("scr_br_dom_quest_capture_time", 30);
  var_1.ref_12FA1 = 1;
  var_1.ref_12C4A = var_0.ref_12C4A;

  if(playmatchendcamera()) {
    if(var_1.ref_12FA6 < level.ref_12965) {
      var_1.ref_12FA6 = level.ref_12965;
    }

    var_1.ref_12FA4 = level.ref_12965;
    var_1.ref_12FA5 = level.ref_12966;
  }

  if(istrue(var_0.ref_11FF8)) {
    var_1.ref_12FA3 = "questPointsArrayWZTrain";
    var_1.ref_1407E = 1;
  }

  var_2 = getdvarint("scr_br_questDomDistMin", -1);
  var_3 = getdvarint("scr_br_questDomDistMax", -1);

  if(var_2 >= 0) {
    var_1.ref_12FA5 = var_2;
  }

  if(var_3 >= 0) {
    var_1.ref_12FA4 = var_3;
  }

  return var_1;
}

function playmatchendcamera() {
  var_0 = 0;
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12E05("overrideQuestSearchParams", "domination");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "mini":
    case "gold_war":
    case "risk":
    case "rat_race":
    case "dmz":
      var_0 = 1;
      break;
  }

  return var_0;
}

function ref_13F27(var_0, var_1) {
  var_0 setOrigin(var_0.origin + (0, 0, 34));
  var_0 setstance("crouch");
}