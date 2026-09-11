/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_capshoot_quest.gsc
******************************************************/

function init() {
  var0 = revivent_watchfordeath_safety(game["attackers"]);

  foreach(var2 in var0) {
    alwayssnowfight(var2);
  }

  var4 = revivent_watchfordeath_safety(game["defenders"]);

  foreach(var2 in var4) {
    alwayssnowfight(var2);
  }

  scripts\mp\gametypes\br_quest_util::registerquestlocale("cap_locale");
  scripts\mp\gametypes\br_quest_util::registercreatequestlocale("cap_locale", &get_consecutive_def);
  scripts\mp\gametypes\br_quest_util::registercheckiflocaleisavailable("cap_locale", &get_comp_dist_for_info_loop);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance("cap_locale", &get_corpse_array);
  scripts\mp\gametypes\br_quest_util::registerquestcircletick("cap_locale", &get_connected_nodes_targetname_array);
  scripts\mp\gametypes\br_quest_util::ref_12b2d("cap_locale", &get_control_station_side_array);
  scripts\mp\gametypes\br_quest_util::ref_12b30("cap_locale", &get_convoy_vehicle_get_in_scene_name);
  scripts\mp\gametypes\br_quest_util::getquestdata("cap_locale").nextid = 0;
  ref_1322d();
  scripts\mp\gametypes\br_gametypes::ref_12b11("canTakePickupLoot", &get_chopperexfil_transient);
  game["dialog"]["mission_cap_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_cap_success"] = "mission_mission_dom_success";
}

function revivent_watchfordeath_safety(var0) {
  if(var0 == game["attackers"]) {
    return registermovequestlocale();
  }

  return relic_nuketimer_playvo();
}

function registermovequestlocale() {
  return ["capshoot_killstreak"];
}

function relic_nuketimer_playvo() {
  return ["capshoot_killstreak_d"];
}

function alwayssnowfight(var0) {
  var1 = scripts\mp\gametypes\br_quest_util::registerquestcategory(var0, 1);

  if(!var1) {
    return;
  }

  scripts\mp\gametypes\br_quest_util::ref_12b2a(var0, "brloot_domination_tablet");
  scripts\mp\gametypes\br_quest_util::ref_12b3d(var0, &get_current_ai_cap);
  scripts\mp\gametypes\br_quest_util::registerremovequestinstance(var0, &get_correct_bomb_wire_pair);
  scripts\mp\gametypes\br_quest_util::ref_1297c(var0, 1);
  scripts\mp\gametypes\br_quest_util::ref_12b31(var0, &get_closest_available_player_new);
  scripts\mp\gametypes\br_quest_util::ref_13180(var0);
}

function get_correct_bomb_wire_pair() {
  if(isDefined(level.ref_13ac8[self.team])) {
    level.ref_13ac8[self.team] = scripts\engine\utility::array_remove(level.ref_13ac8[self.team], self.squadindex);
  }

  scripts\mp\gametypes\br_quest_util::releaseteamonquest(self.team);
  scripts\mp\gametypes\br_quest_util::uiobjectivehidefromteam(self.team);
  thread get_combat_station_next_combat_action();
}

function get_corpse_array() {
  foreach(var1 in self.subscribedinstances) {
    var1 thread scripts\mp\gametypes\br_quest_util::removequestinstance();
  }

  last_vampire_feedback();
  self.get_closest_living_player_not_in_laststand = undefined;
}

function get_current_ai_cap() {
  self.questcategory = "capshoot";
  return true;
}

function get_consecutive_def(var0) {
  scripts\mp\gametypes\br_quest_util::getquestdata("cap_locale").nextid++;
  var1 = scripts\mp\gametypes\br_quest_util::createlocaleinstance("cap_locale", self.questcategory, "CapPoint:" + scripts\mp\gametypes\br_quest_util::getquestdata("cap_locale").nextid);

  if(!isDefined(var0)) {
    var1.curorigin = (0, 0, 0);
    var1.enabled = 0;
    return var1;
  }

  var2 = var0.origin;

  if(var0.spawnflags & 23) {}

  var3 = scripts\mp\gametypes\br_quest_util::ref_12971(var0);
  var4 = spawn("trigger_radius", var2, 0, int(var3), int(level.debugpayloadobjectivesstart_infil));
  var4.script_label = "";
  level.ref_13135 = &get_closest_valid_player;
  var5 = scripts\mp\gametypes\obj_dom::setupobjective(var4);
  var5.onuse = &get_closest_spawns;
  var5.onbeginuse = &get_closest_origin_index;
  var5.onuseupdate = &get_closest_unclaimed_destination;
  var5.onenduse = &get_closest_player_dist;
  var5.usecondition = &get_combat_action;
  var5.lockupdatingicons = 1;
  var5.getrandompointincirclewithindistance = 1;
  var5.flagmodel setModel("x2_military_old_recon_station");
  scripts\mp\objidpoolmanager::update_objective_position(var5.objidnum, var5.curorigin + (0, 0, 60));
  level.flagcapturetime = getdvarfloat("scr_br_cap_quest_capture_time", 30);
  var5 scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  var1.lastcircletick = -1;
  var1.get_closest_living_player_not_in_laststand = var5;
  var1.curorigin = var5.curorigin;
  var1.team = self.team;
  var5.locale = var1;
  var5.squadindex = self.squadindex;
  scripts\mp\gametypes\br_quest_util::addquestinstance("cap_locale", var1);
  return var1;
}

function get_comp_dist_for_info_loop(var0) {
  var1 = getdvarfloat("scr_br_cap_quest_max_capture_percent", 0.2);
  var2 = getdvarfloat("scr_br_cap_quest_max_teams", 4);
  var3 = 0;

  if(isDefined(self.get_closest_living_player_not_in_laststand.curprogress)) {
    var3 = self.get_closest_living_player_not_in_laststand.curprogress / self.get_closest_living_player_not_in_laststand.usetime;
  }

  if(var3 > var1) {
    return false;
  }

  if(self.subscribedinstances.size >= var2) {
    return false;
  }

  return true;
}

function get_connected_nodes_targetname_array(var0, var1) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand)) {
    return;
  }

  var2 = gettime();

  if(self.lastcircletick == var2) {
    return;
  }

  self.lastcircletick = var2;

  if(isDefined(self.get_closest_living_player_not_in_laststand) && isDefined(self.get_closest_living_player_not_in_laststand.traincar)) {
    self.curorigin = self.get_closest_living_player_not_in_laststand.traincar.origin;
  }

  var3 = distance2d(self.curorigin, var0);

  if(var3 > var1) {
    foreach(var5 in self.subscribedinstances) {
      if(isDefined(var5)) {
        scripts\mp\gametypes\br_quest_util::displayteamsplash(var5.team, "br_capshoot_quest_circle_failure");
        var6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var5.team, var5.squadindex);
        level thread scripts\mp\gametypes\br_public::brleaderdialog("br_capshoot_quest_circle_failure", 1, var6);
      }

      var5.result = "circle";
    }

    scripts\mp\gametypes\br_quest_util::removequestinstance();
    return;
  }
}

function get_control_station_side_array(var0) {
  get_closest_munitions(var0);
}

function get_convoy_vehicle_get_in_scene_name(var0) {
  foreach(var2 in self.teams) {
    if(var0.team == self.subscribedinstances[0].team) {
      get_closest_visible_drone(var0);
    }
  }
}

function get_chopperexfil_transient(var0) {
  if(!scripts\mp\gametypes\br_pickups::usb(var0.scriptablename)) {
    return undefined;
  }

  var1 = var0.tracknonoobplayerlocation;

  if(isDefined(var1.questcategory) && var1.questcategory == "capshoot") {
    if(self.team == var1.team) {
      var2 = revivent_watchfordeath_safety(self.team);

      foreach(var4 in var2) {
        if(isDefined(level.questinfo.quests[var4])) {
          foreach(var6 in level.questinfo.quests[var4].instances) {
            if(isDefined(var6) && self.squadindex == var6.squadindex) {
              return 10;
            }
          }
        }
      }

      return 1;
    } else {
      return 22;
    }
  }

  return undefined;
}

function takequestitem(var0) {
  var1 = search(var0.ref_139eb, self, 1, var0);

  if(!isDefined(var1)) {
    return;
  }

  ref_1336d(var0.ref_139eb, [self]);
  ref_13742(var1, [self]);

  if(istrue(level.disable_super_in_turret.ref_12273) && isDefined(var0.ref_12157)) {
    var2 = [[var0.ref_12157]](var0);

    if(isDefined(var2) && isDefined(var0.ref_12158)) {
      if(getdvarint("scr_br_alt_mode_mini", 0) == 1) {
        search(var0.ref_12158, var2, 0, var0, var1);
      } else {
        search(var0.ref_12158, var2, 0, var0);
      }

      ref_1336d(var0.ref_12158, [var2]);
      ref_13742(var1, [var2]);
    }
  }

  if(isDefined(level.disable_super_in_turret.ref_12979) && isDefined(var1.ref_12978)) {
    level.disable_super_in_turret.ref_12979 = scripts\engine\utility::array_remove(level.disable_super_in_turret.ref_12979, var1.ref_12978);
    return;
  }
}

function search(var0, var1, var2, var3, var4) {
  var5 = getdvarint("scr_br_CAP_questTime", 240);
  var6 = adjust_angles_for_heli_path(var0, var1, var5, var3);
  var7 = undefined;
  var8 = spawnStruct();
  var8 = rocket_missile(var1, var0);

  if(isDefined(var3) && isDefined(var3.ref_12395)) {
    var9 = [[var3.ref_12395]](var1, var3);

    if(isDefined(var9)) {
      var8.ref_12c4a = var9;
      var7 = var9.ref_12978;
    }
  }

  if(!isDefined(var4)) {
    var4 = var6 scripts\mp\gametypes\br_quest_util::requestquestlocale("cap_locale", var8, var2);
  }

  if(!isDefined(var4) || !istrue(var4.enabled)) {
    var6.result = "no_locale";
    var6 scripts\mp\gametypes\br_quest_util::releaseteamonquest(var1.team);
    return;
  }

  if(isDefined(var4.get_closest_living_player_not_in_laststand)) {
    var3.stadium_three_death_func = var4.get_closest_living_player_not_in_laststand.flagmodel;
  }

  var4.ref_12978 = var7;
  var4.squadindex = var1.squadindex;
  get_combat_alias(var4);
  scripts\mp\gametypes\br_quest_util::addquestinstance(var0, var6);
  return var4;
}

function rocket_missile(var0) {
  var1 = self;
  var2 = spawnStruct();
  var2.ref_12fa3 = "questPointsArray";
  var2.ref_12f9f = (var1.origin[0], var1.origin[1], 0);
  var2.ref_12fa6 = getdvarfloat("scr_br_cap_search_max_radius", 7500);
  var2.ref_12fa7 = 0;
  var2.ref_12fa4 = getdvarfloat("scr_br_cap_search_ideal_max_radius", 5000);
  var2.ref_12fa5 = getdvarfloat("scr_br_cap_search_ideal_min_radius", 2500);
  var2.ref_1297f = 7;
  var2.mintime = getdvarfloat("scr_br_cap_quest_capture_time", 30);
  var2.ref_12fa1 = 1;
  var2.ref_12c4a = var1.ref_12c4a;

  if(playlinkfx(var0)) {
    if(var2.ref_12fa6 < level.ref_12965) {
      var2.ref_12fa6 = level.ref_12965;
    }

    var2.ref_12fa4 = level.ref_12965;
    var2.ref_12fa5 = level.ref_12966;
  }

  if(istrue(var1.ref_11ff8)) {
    var2.ref_12fa3 = "questPointsArrayWZTrain";
    var2.ref_1407e = 1;
  }

  var3 = getdvarint("scr_br_questCapDistMin", -1);
  var4 = getdvarint("scr_br_questCapDistMax", -1);

  if(var3 >= 0) {
    var2.ref_12fa5 = var3;
  }

  if(var4 >= 0) {
    var2.ref_12fa4 = var4;
  }

  return var2;
}

function usageloop() {
  var0 = revivent_watchfordeath_safety(game["attackers"]);

  foreach(var2 in var0) {
    if(isDefined(level.questinfo.quests[var2].instances[game["attackers"]])) {
      return true;
    }
  }

  var4 = revivent_watchfordeath_safety(game["defenders"]);

  foreach(var2 in var4) {
    if(isDefined(level.questinfo.quests[var2].instances[game["defenders"]])) {
      return true;
    }
  }

  return false;
}

function adjust_angles_for_heli_path(var0, var1, var2, var3) {
  var4 = scripts\mp\gametypes\br_quest_util::createquestinstance(var0, var1.team, "", var3, var1.squadindex);
  var4.squadindex = var1.squadindex;
  var4 scripts\mp\gametypes\br_quest_util::registerteamonquest(var1.team, var1);
  var4 scripts\mp\gametypes\br_quest_util::ref_12b15(var1);
  var4.team = var1.team;
  var4 scripts\mp\gametypes\br_quest_util::ref_1297d(var2, 4);
  return var4;
}

function ref_1336d(var0, var1) {
  foreach(var3 in var1) {
    var3 scripts\mp\gametypes\br_quest_util::uiobjectiveshowtoteam(var0, var3.team);
    var3 scripts\mp\gametypes\br_quest_util::ref_13879(var0, var3, var3.team);
  }

  var5 = spawnStruct();
  var5.excludedplayers = [];

  foreach(var3 in var1) {
    var5.excludedplayers[0] = var3;
    var3 scripts\mp\gametypes\br_quest_util::displayplayersplash(var3, "br_capshoot_quest_start_tablet_finder_noplunder", var5);
    var3 scripts\mp\gametypes\br_quest_util::displayteamsplash(var3.team, "br_capshoot_quest_start_team_noplunder", var5);
    var3 scripts\mp\gametypes\br_quest_util::lookforvehicles(var3.team, var3, 6, scripts\mp\gametypes\br_quest_util::getquestindex(var0));
    var7 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var3.team, var3.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("contract_acquired", 1, var7);
  }
}

function ref_13742(var0) {
  if(isDefined(self.get_closest_living_player_not_in_laststand)) {
    foreach(var2 in var0) {
      self.get_closest_living_player_not_in_laststand scripts\mp\gameobjects::squadallowuse(var2.team, var2.squadindex);
    }

    return;
  }
}

function get_combat_alias() {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }

  objective_showtoplayersinmask(self.get_closest_living_player_not_in_laststand.objidnum);
  objective_removeallfrommask(self.get_closest_living_player_not_in_laststand.objidnum);

  foreach(var1 in self.subscribedinstances) {
    foreach(var3 in scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1.team, var1.squadindex)) {
      if(!var3 scripts\mp\gametypes\br_public::isplayeringulag()) {
        objective_addclienttomask(self.get_closest_living_player_not_in_laststand.objidnum, var3);
      }
    }
  }
}

function get_closest_munitions(var0) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }

  objective_removeclientfrommask(self.get_closest_living_player_not_in_laststand.objidnum, var0);
}

function get_closest_visible_drone(var0) {
  if(!isDefined(self.get_closest_living_player_not_in_laststand) || !isDefined(self.get_closest_living_player_not_in_laststand.objidnum)) {
    return;
  }

  objective_addclienttomask(self.get_closest_living_player_not_in_laststand.objidnum, var0);
}

function get_combat_station_next_combat_action() {
  self endon("removed");
  waittillframeend();
  get_combat_alias();
}

function last_vampire_feedback() {
  foreach(var1 in self.get_closest_living_player_not_in_laststand.visuals) {
    var1 delete();
  }

  if(isDefined(self.get_closest_living_player_not_in_laststand.flagmodel)) {
    self.get_closest_living_player_not_in_laststand.flagmodel delete();
  }

  if(isDefined(self.get_closest_living_player_not_in_laststand.scriptable)) {
    self.get_closest_living_player_not_in_laststand.scriptable delete();
  }

  if(isDefined(self.get_closest_living_player_not_in_laststand.trigger)) {
    self.get_closest_living_player_not_in_laststand.trigger delete();
    self.get_closest_living_player_not_in_laststand.trigger = undefined;
  }

  thread gameobjectreleaseid_delayed();
  self.get_closest_living_player_not_in_laststand notify("deleted");
}

function gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

function ref_1322d() {
  if(isDefined(level.debugpayloadobjectivesstart_infil)) {
    return;
  }

  level.disableinitplayergameobjects = 0;
  level.debugpayloadobjectivesstart_infil = 120;
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  level.squadspawndebug = "icon_waypoint_ot";
  ammobox_checkclearbufferedattachmentweapon("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  ammobox_checkclearbufferedattachmentweapon("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  ammobox_checkclearbufferedattachmentweapon("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  ammobox_checkclearbufferedattachmentweapon("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  ammobox_checkclearbufferedattachmentweapon("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  ammobox_checkclearbufferedattachmentweapon("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

function ammobox_checkclearbufferedattachmentweapon(var0, var1, var2, var3) {
  level.waypointcolors[var0] = var1;
  level.waypointbgtype[var0] = 1;
  level.waypointstring[var0] = var2;
  level.waypointshader[var0] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[var0] = var3;
}

function get_closest_unclaimed_destination(var0, var1, var2, var3) {
  if(var1 < 1 && !level.gameended) {
    ref_12427(var1, var0);
  }

  if(var1 > 0.05 && var2 && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
    return;
  }
}

function get_closest_origin_index(var0) {
  if(!isDefined(self.ref_11f63) || !self.ref_11f63) {
    self.ref_11f63 = 1;

    if(isDefined(self.traincar)) {
      if(isDefined(level.ref_145f1) && istrue(level.ref_145f1.get_closest_destination)) {
        var1 = self.traincar.get_closest_attackable_player + (200, 0, 0);
        var2 = self.traincar.origin + rotatevector(var1, self.traincar.angles);
        level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var2, "dom", 3);
      }
    } else {
      level thread scripts\mp\gametypes\br_quest_util::ref_140b1(self.curorigin, "dom");
    }

    foreach(var4 in level.players) {
      if(isDefined(var4) && isalive(var4) && (var4.team != var0.team || var4.squadindex != var0.squadindex)) {
        var4 thread scripts\mp\hud_message::showsplash("br_capshoot_quest_alert");
      }
    }

    var6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);

    foreach(var8 in var6) {
      var8 notify("calloutmarkerping_warzoneKillQuestIcon");
    }

    return;
  }
}

function get_closest_spawns(var0) {
  foreach(var2 in self.locale.subscribedinstances) {
    var3 = var2.team;

    if(var3 == var0.team) {
      var4 = scripts\mp\gametypes\br_quest_util::ringing(var0.team);
      var5 = scripts\mp\gametypes\br_quest_util::getquestindex(var2.questcategory);
      var6 = scripts\mp\gametypes\br_quest_util::rewardtovalue(scripts\mp\gametypes\br_quest_util::rewardtotype(var2.questcategory));
      var7 = spawnStruct();
      var7.ref_121b5 = scripts\mp\gametypes\br_quest_util::ref_121b9(var5, var4, var6);
      self.squadindex = var2.squadindex;
      scripts\mp\gametypes\br_quest_util::displayteamsplash(var3, "br_capshoot_quest_complete_noplunder", var7);
      scripts\mp\gametypes\br_quest_util::lookforvehicles(var3, var0, 8, var5);
      var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var0.team, var0.squadindex);
      level thread scripts\mp\gametypes\br_public::brleaderdialog("contract_complete", 1, var8, 0, 1);
      var2.ref_12d2e = self.flagmodel.origin;
      var2.ref_12d2b = self.flagmodel.angles;
      var2.result = "success";

      if(isDefined(self.assisttouchlist)) {
        if(isDefined(self.assisttouchlist[var3])) {
          var9 = getarraykeys(self.assisttouchlist[var3]);

          foreach(var11 in var9) {
            var12 = self.assisttouchlist[var3][var11].player;

            if(isDefined(var12.owner)) {
              var12 = var12.owner;
            }

            if(!isPlayer(var12)) {
              continue;
            }

            var12 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_recon_objective_for_operator_mission", 1);
            var12 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_complete_recon_objective_for_operator_mission_op2", 1);
            var2 scripts\mp\gametypes\br_quest_util::ref_12b15(var12);
          }
        }
      }

      continue;
    }

    scripts\mp\gametypes\br_quest_util::displayteamsplash(var3, "br_capshoot_quest_failure", undefined, var2.squadindex);
    var8 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var3, var2.squadindex);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("contract_fail", 1, var8);
    var2.result = "fail";
  }

  self.locale thread scripts\mp\gametypes\br_quest_util::removequestinstance();
}

function get_closest_player_dist(var0, var1, var2) {
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

function get_closest_valid_player(var0, var1, var2) {
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

function get_combat_action(var0) {
  var1 = var0.team;

  foreach(var3 in self.locale.subscribedinstances) {
    if(isDefined(var3)) {
      if(var3.team == var1) {
        return true;
      }
    }
  }

  return false;
}

function get_closest_available_player_new() {
  if(isDefined(self.ref_1393b.get_closest_living_player_not_in_laststand.numtouching)) {
    while(self.ref_1393b.get_closest_living_player_not_in_laststand.numtouching[self.id]) {
      waitframe();
    }
  }

  scripts\mp\gametypes\br_quest_util::displayteamsplash(self.team, "br_capshoot_quest_timer_expired");
  var0 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(self.team, self.squadindex);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("contract_fail", 1, var0);
}

function playlinkfx(var0) {
  var1 = 0;
  var2 = scripts\mp\gametypes\br_gametypes::ref_12e05("overrideQuestSearchParams", var0);

  if(isDefined(var2)) {
    return var2;
  }

  var3 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var3) {
    case "mini":
    case "risk":
    case "rat_race":
    case "dmz":
      var1 = 1;
      break;
  }

  return var1;
}