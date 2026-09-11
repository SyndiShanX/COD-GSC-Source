/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dom_quest.gsc
*************************************************/

function init() {
  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("domination", 1);

  if(!var0) {
    return;
  }

  var0 = scripts\mp\gametypes\br_quest_util::registerquestcategory("domination_redacted", 1);

  if(var0) {
    scripts\mp\gametypes\br_quest_util::ref_12b2a("domination_redacted", "brloot_redacted_domination_tablet");
    scripts\mp\gametypes\br_quest_util::ref_12b3d("domination_redacted", &markplayeraseliminatedonkilled);
  }

  scripts\mp\gametypes\br_quest_util::ref_12b3d("domination", &markplayeraseliminatedonkilled);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("domination", &domquest_removequestinstance);
  scripts\mp\gametypes\br_quest_util::registerquestlocale("dom_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("dom_locale", &domlocale_createquestlocale);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("dom_locale", &domlocale_checkiflocaleisavailable);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("dom_locale", &domlocale_removelocaleinstance);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("dom_locale", &domlocale_circletick);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("dom_locale", &marked_for_no_death);
  scripts\mp\gametypes\br_quest_util::ref_12b30("dom_locale", &markedentities_removeentsbyindex);
  scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid = 0;
  scripts\mp\gametypes\br_quest_util::ref_1297c("domination", 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31("domination", &maphint_offerscriptableused);
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
  foreach(var1 in self.subscribedinstances) {
    var1 thread scripts\mp\gametypes\br_quest_util::removequestinstance();
  }

  deletedomflaggameobject();
  self.domflag = undefined;
}

function markplayeraseliminatedonkilled() {
  var0 = role_edit(self);
  var1 = scripts\mp\gametypes\br_quest_util::play_train_speaker_vo("domination", var0);

  if(!isDefined(var1)) {
    return false;
  }

  getlootspawnpointcount(var1.index);
  self.ref_12c4a = var1;
  return true;
}

function domlocale_createquestlocale(var0) {
  scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid++;
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("dom_locale", "domination", "DomPoint:" + scripts\mp\gametypes\br_quest_util::getquestdata("dom_locale").nextid);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var2 = var0.origin;

  if(var0.spawnflags & 7) {}

  var3 = scripts\mp\gametypes\br_quest_util::ref_12971(var0);
  var4 = spawn("trigger_radius", var2, 0, int(var3), int(level.defend_wave_3));
  level.setdomscriptablepartstatefunc = &domflag_setdomscriptablepartstate;
  var5 = scripts\mp\gametypes\obj_dom::setupobjective(var4, undefined, undefined, undefined, undefined, 0);
  var5.squadindex = self.squadindex;
  var5.onuse = &domflag_onuse;
  var5.onbeginuse = &mark_danger_timeout;
  var5.onuseupdate = &domflag_onuseupdate;
  var5.onenduse = &domflag_onenduse;
  var5.usecondition = &mark_loot;
  var5.lockupdatingicons = 1;
  var5.getrandompointincirclewithindistance = 1;

  if(istrue(self.tablet.ref_11ff8) && isDefined(var0.traincar)) {
    if(istrue(level.ref_145f1.maphint_debugthink)) {
      var5.flagmodel setModel("lm_domination_point_01_mover_nocol");
    } else {
      var5.flagmodel setModel("lm_domination_point_01_mover");
    }

    var6 = var0.traincar.maphint_keypadscriptableused;
    var7 = var0.traincar.angles;

    if(isDefined(var0.traincar.manageworldspawnedprojectiles)) {
      var7 = var0.traincar.manageworldspawnedprojectiles;
    }

    var5.flagmodel linkTo(var0.traincar.wz_tease, "tag_origin", var6, var7);
    var4 enablelinkTo();
    var4 linkTo(var5.flagmodel);

    if(isDefined(var5.visuals) && isarray(var5.visuals)) {
      foreach(var9 in var5.visuals) {
        var9 linkTo(var5.flagmodel);
      }
    }

    var5.scriptable linkTo(var0.traincar.wz_tease);
    var5.traincar = var0.traincar;
    scripts\mp\objidpoolmanager::update_objective_onentity(var5.objidnum, var5.flagmodel);
  } else {
    var5.flagmodel setModel("x2_military_old_recon_station");
    scripts\mp\objidpoolmanager::update_objective_position(var5.objidnum, var5.curorigin + (0, 0, 60));
  }

  level.flagcapturetime = getdvarfloat("scr_br_dom_quest_capture_time", 30);
  var5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var1.lastcircletick = -1;
  var1.domflag = var5;
  var1.curorigin = var5.curorigin;
  var5.locale = var1;
  var5.flagmodel.unresolved_collision_func = &ref_13f27;
  scripts\mp\gametypes\br_quest_util::addquestinstance("dom_locale", var1);
  return var1;
}

function domlocale_checkiflocaleisavailable(var0) {
  var1 = getdvarfloat("scr_br_dom_quest_max_capture_percent", 0.2);
  var2 = getdvarfloat("scr_br_dom_quest_max_teams", 4);
  var3 = 0;

  if(isDefined(self.domflag.curprogress)) {
    var3 = self.domflag.curprogress / self.domflag.usetime;
  }

  if(var3 > var1) {
    return false;
  }

  if(self.subscribedinstances.size >= var2) {
    return false;
  }

  return true;
}

function domlocale_circletick(var0, var1) {
  if(!isDefined(self.domflag)) {
    return;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;

  if(isDefined(self.domflag) && isDefined(self.domflag.traincar)) {
    self.curorigin = self.domflag.traincar.origin;
  }

  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var5.team, "br_domination_quest_circle_failure");
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_obj_circle_fail", var5.team, 1);
      var5.result = "circle";

      if(isDefined(var5.tablet.trackriotshield_grenadepullbackforc4)) {
        [[var5.tablet.trackriotshield_grenadepullbackforc4]](var5);
      }
    }

    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }
}

function marked_for_no_death(var0) {
  mark_danger(var0);
}

function markedentities_removeentsbyindex(var0) {
  if(var0.team == self.subscribedinstances[0].team) {
    mark_location(var0);
    return;
  }
}

function takequestitem(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::createquestinstance("domination", self.team, var0.index, var0, self.squadindex);
  var2 = "";

  if(var0.type == "brloot_redacted_domination_tablet") {
    var2 = "_redacted";
  }

  var1.modifier = var2;
  var1 scripts\mp\gametypes\br_quest_util::registerteamonquest(self.team, self);
  var1 scripts\mp\gametypes\br_quest_util::ref_12b15(self);
  var1.team = self.team;
  var1.tablet = var0;
  var3 = getdvarint("scr_br_DOM_questTime", 240);
  var1 scripts\mp\gametypes\br_quest_util::ref_1297d(var3, 4);
  var4 = role_edit(var0);
  var5 = var1 scripts\mp\gametypes\br_quest_util::requestquestlocale("dom_locale", var4, 1);

  if(!var5.enabled) {
    var1.result = "no_locale";

    if(isDefined(var1.tablet.trackriotshield_grenadepullbackforc4)) {
      [[var1.tablet.trackriotshield_grenadepullbackforc4]](var1);
    }

    var1 scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
    return;
  }

  domflagupdateicons(var5);
  scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam("domination" + var1.modifier, self.team);
  scripts\mp\gametypes\br_quest_util::addquestinstance("domination", var1);
  scripts\mp\gametypes\br_quest_util::ref_13879("domination", self, self.team);
  var6 = spawnStruct();
  var6.excludedplayers = [];
  var6.excludedplayers[0] = self;
  var6.ref_127d5 = scripts\mp\gametypes\br_quest_util::rewardmodifier("domination", scripts\mp\gametypes\br_quest_util::ringing(self.team), var1.modifier);
  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_domination_quest_start_team", var6);
  scripts\mp\gametypes\br_quest_util::displayplayersplash(self, "br_domination_quest_start_tablet_finder", var6);
  scripts\mp\gametypes\br_quest_util::searchfunc(self.team, "br_mission_pickup_tablet");
  scripts\mp\gametypes\br_quest_util::lookforvehicles(var1.team, self, 6, scripts\mp\gametypes\br_quest_util::getquestindex("domination"));
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_dom_accept", var1.team, 1);
  return var1;
}

function domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(var1 in self.subscribedinstances) {
    foreach(var3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1.team, self.squadindex)) {
      if(!var3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(self.domflag.objidnum, var3);
      }
    }
  }
}

function mark_danger(var0) {
  objective_removeclientfrommask(self.domflag.objidnum, var0);
}

function mark_location(var0) {
  objective_addclienttomask(self.domflag.objidnum, var0);
}

function mark_phone_guy_once_all_spawned() {
  self endon("removed");
  waittillframeend();
  domflagupdateicons();
}

function deletedomflaggameobject() {
  foreach(var1 in self.domflag.visuals) {
    var1 delete();
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

function _setdomflagiconinfo(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 1;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[var0] = var3;
}

function domflag_onuseupdate(var0, var1, var2, var3) {
  if(var1 < 1 && !level.gameended) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function mark_danger_timeout(var0) {
  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;

    if(isDefined(self.traincar)) {
      if(isDefined(level.ref_145f1) && istrue(level.ref_145f1.mark_armor)) {
        var1 = self.traincar.maphint_keypadscriptableused + (200, 0, 0);
        var2 = self.traincar.origin + rotatevector(var1, self.traincar.angles);
        level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var2, "dom", 3);
      }
    } else {
      level thread scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    }

    var3 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, self.squadindex);
    var4 = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, var3);

    foreach(var6 in var4) {
      if(isDefined(var6) && isalive(var6)) {
        var6 thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
      }
    }

    var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, self.squadindex);

    foreach(var10 in var8) {
      var10 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function domflag_onuse(var0) {
  foreach(var2 in self.locale.subscribedinstances) {
    if(var2.team == var0.team) {
      var3 = spawnStruct();
      var4 = scripts\mp\gametypes\br_quest_util::ringing(var0.team);
      var5 = scripts\mp\gametypes\br_quest_util::getquestindex("domination" + var2.modifier);
      var6 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype("domination", var2.modifier));
      var7 = scripts\mp\gametypes\br_alt_mode_bblitz::clear_all_remaining(var0);
      var3.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var5, var4, var6, undefined, var7);
      self.squadindex = var2.squadindex;
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var2.team, "br_domination_quest_complete", var3);
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var2.team, var0, 8, var5);
      level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_dom_success", var2.team, 1, 1);
      var2.ref_12d2e = self.flagmodel.origin;
      var2.ref_12d2b = self.flagmodel.angles;
      var2.result = "success";

      if(isDefined(var2.tablet.trackriotshield_grenadepullbackforc4)) {
        [[var2.tablet.trackriotshield_grenadepullbackforc4]](var2);
      }

      if(isDefined(self.assisttouchlist[var2.team])) {
        var8 = getarraykeys(self.assisttouchlist[var2.team]);

        foreach(var10 in var8) {
          var11 = self.assisttouchlist[var2.team][var10].player;

          if(isDefined(var11.owner)) {
            var11 = var11.owner;
          }

          if(!isPlayer(var11)) {
            continue;
          }

          var11 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_recon_objective_for_operator_mission", 1);
          var11 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_recon_objective_for_operator_mission_op2", 1);
          var2 scripts\mp\gametypes\br_quest_util::ref_12b15(var11);
        }
      }

      continue;
    }

    scripts\mp\gametypes\br_quest_util::displayteamsplash(var2.team, "br_domination_quest_failure");
    level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", var2.team, 1);
    var2.result = "fail";

    if(isDefined(var2.tablet.trackriotshield_grenadepullbackforc4)) {
      [[var2.tablet.trackriotshield_grenadepullbackforc4]](var2);
    }
  }

  self.locale thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function domflag_onenduse(var0, var1, var2) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(var0, var1, var2);
}

function ref_12427(var0, var1) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var2 = "";
    var0 = int(floor(var0 * 10));
    var2 = "mp_dom_capturing_tick_0" + var0;
    self.visuals[0] playsoundtoteam(var2, var1);
    return;
  }
}

function domflag_setdomscriptablepartstate(var0, var1, var2) {
  switch (var1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var1 = "using";

      if(isDefined(var2)) {
        var1 += var2;
      }

      self.scriptable setscriptablepartstate(var0, var1);

      if(var0 == "pulse") {
        self.scriptable setscriptablepartstate("flag", var1);
      }

      return 1;
  }
}

function mark_loot(var0) {
  if(getdvarint("scr_br_alt_mode_gxp", 0)) {
    if(var0 scripts\mp\gametypes\br_public::ref_125ec()) {
      return false;
    }
  }

  var1 = var0.team;

  foreach(var3 in self.locale.subscribedinstances) {
    if(var3.team == var1) {
      return true;
    }
  }

  return false;
}

function maphint_offerscriptableused() {
  while(self.ref_1393b.domflag.numtouching[self.id]) {
    waitframe();
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.id, "br_domination_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::dmztut_luicallback("mission_gen_fail", self.team, 1);
}

function role_edit(var0) {
  var1 = spawnStruct();
  var1.ref_12fa3 = "questPointsArray";
  var1.ref_12f9f = (var0.origin[0], var0.origin[1], 0);
  var1.ref_12fa6 = 12000;
  var1.ref_12fa7 = 0;
  var1.ref_12fa4 = 8000;
  var1.ref_12fa5 = 6000;
  var1.ref_1297f = 7;
  var1.mintime = getdvarfloat("scr_br_dom_quest_capture_time", 30);
  var1.ref_12fa1 = 1;
  var1.ref_12c4a = var0.ref_12c4a;

  if(playmatchendcamera()) {
    if(var1.ref_12fa6 < level.ref_12965) {
      var1.ref_12fa6 = level.ref_12965;
    }

    var1.ref_12fa4 = level.ref_12965;
    var1.ref_12fa5 = level.ref_12966;
  }

  if(istrue(var0.ref_11ff8)) {
    var1.ref_12fa3 = "questPointsArrayWZTrain";
    var1.ref_1407e = 1;
  }

  var2 = getdvarint("scr_br_questDomDistMin", -1);
  var3 = getdvarint("scr_br_questDomDistMax", -1);

  if(var2 >= 0) {
    var1.ref_12fa5 = var2;
  }

  if(var3 >= 0) {
    var1.ref_12fa4 = var3;
  }

  return var1;
}

function playmatchendcamera() {
  var0 = 0;
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", "domination");

  if(isDefined(var1)) {
    return var1;
  }

  var2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var2) {
    case "mini":
    case "gold_war":
    case "risk":
    case "rat_race":
    case "dmz":
      var0 = 1;
      break;
  }

  return var0;
}

function ref_13f27(var0, var1) {
  var0 setOrigin(var0.origin + (0, 0, 34));
  var0 setstance("crouch");
}