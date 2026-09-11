/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

function setupobjective(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(level.curobj)) {
    level.curobj scripts\mp\gameobjects::deleteuseobject();
  }

  if(isDefined(var_0.originalpos)) {
    var_0.origin = var_0.originalpos;
  } else {
    var_0.originalpos = var_0.origin;
  }

  var_5 = getEntArray(var_0.target, "targetname");

  if(isDefined(var_0.objectivekey)) {
    var_6 = var_0.objectivekey;
  } else {
    var_6 = var_1.script_label;
  }

  if(istrue(var_3)) {
    var_7 = getreservedobjid(var_6);
  } else {
    var_7 = undefined;
  }

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd") {
    var_6 = var_2.script_label;
    var_8 = getEnt("dd_bombzone_clip" + var_6, "targetname");

    if(scripts\mp\utility\game::inovertime()) {
      if(var_6 == "_a" || var_6 == "_b") {
        var_2 delete();
        var_6[0] delete();
        var_8 delete();
        return;
      }

      var_5 = scripts\mp\gameobjects::createuseobject("neutral", var_2, var_6, (0, 0, 64), var_7, var_3);
      var_5 scripts\mp\gameobjects::allowuse("any");
      var_5.trigger.script_label = "_a";
    } else if(var_6 == "_c") {
      var_2 delete();
      var_6[0] delete();
      var_8 delete();
      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "sd") {
    setomnvar("ui_bomb_owner_team", 0);
  }

  if(!isDefined(var_5)) {
    var_5 = scripts\mp\gameobjects::createuseobject(game["defenders"], var_2, var_6, (0, 0, 64), var_7, var_3);
    var_5 scripts\mp\gameobjects::allowuse("enemy");
  }

  if(isDefined(var_2.objectivekey)) {
    var_5.objectivekey = var_2.objectivekey;
  } else {
    var_5.objectivekey = var_5 scripts\mp\gameobjects::getlabel();
  }

  if(isDefined(var_2.iconname)) {
    var_5.iconname = var_2.iconname;
  } else {
    var_5.iconname = var_5 scripts\mp\gameobjects::getlabel();
  }

  var_5.id = "bomb_zone";
  var_5.trigger setusepriority(-3);
  var_5 scripts\mp\gameobjects::setusetime(level.planttime);
  var_5 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_5 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  var_5.trigger setuseholdduration("duration_none");

  if(!level.multibomb) {
    var_5 scripts\mp\gameobjects::setkeyobject(level.sdbomb);
  }

  if(var_5.objectivekey == "_c") {
    var_5.objectivekey = "_a";
    var_5.iconname = "_a";
  }

  if((scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd") && scripts\mp\utility\game::inovertime()) {
    var_5 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target");
    var_5 scripts\mp\gameobjects::setvisibleteam("any");
  }

  var_5.onbeginuse = &bombzone_onbeginuse;
  var_5.onenduse = &bombzone_onenduse;
  var_5.onuse = &bombzone_onuseplantobject;
  var_5.oncantuse = &bombzone_oncantuse;
  var_5.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  var_5.bombplanted = 0;
  var_5.bombexploded = undefined;
  var_5.resetprogress = level.resetprogress;

  for(var_9 = 0; var_9 < var_6.size; var_9++) {
    if(isDefined(var_6[var_9].script_exploder)) {
      var_5.exploderindex = var_6[var_9].script_exploder;
      thread setupkillcament(var_6[var_9]);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd") {
    var_5.bombdefusetrig = getEnt(var_6[0].target, "targetname");
    var_5.bombdefusetrig.origin += (0, 0, -10000);
    var_5.bombdefusetrig.label = var_6;
  } else {
    var_10 = getEnt(var_6[0].target, "targetname");
    var_10 delete();
    var_5.bombdefusetrig = var_5.trigger;
  }

  var_5.noweapondropallowedtrigger = spawn("trigger_radius", var_5.trigger.origin, 0, 140, 100);
  return var_5;
}

function getreservedobjid(var_0) {
  if(var_0 == "_a") {
    var_1 = 0;
  } else {
    var_1 = 1;
  }

  return var_1;
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

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case "mp_spear":
    case "mp_spear_pm":
      if(var_0.objectivekey == "_a") {
        var_2 = (1373, 2048, 213);
      }

      break;
    default:
      break;
  }

  self.killcament = spawn("script_model", var_2);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

function allowedwhileplanting(var_0) {
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

function setbombplantingomnvar(var_0) {
  wait 0.35;

  if(var_0 == "_a") {
    var_1 = 1;
  } else {
    var_1 = 2;
  }

  setomnvar("ui_bomb_interacting", var_1);
}

function setbombdefusingomnvar(var_0) {
  wait 0.35;

  if(var_0 == "_a") {
    var_1 = 3;
  } else {
    var_1 = 4;
  }

  setomnvar("ui_bomb_interacting", var_1);
}

function bombzone_onbeginuse(var_0) {
  thread allowedwhileplanting(var_0);

  if(!scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"]) && self.bombplanted) {
    if(level.codcasterenabled) {
      var_0 setgametypevip(1);
    }

    var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    var_0 notify("super_obj_drain");
    var_0.isdefusing = 1;
    thread setbombdefusingomnvar(var_0);
    setomnvar("ui_bomb_defuser", var_0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend_nt", "waypoint_bomb_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var_0.team);
    scripts\mp\utility\game::setmlgannouncement(2, var_0.team, var_0 getentitynumber());

    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
    } else if(isDefined(level.ddbombmodel[self.objectivekey])) {
      level.ddbombmodel[self.objectivekey] hide();
    }

    thread startnpcbombusesound(var_0, "briefcase_bomb_defuse_mp");
    return;
  }

  var_1 = 2;

  if(self.objectivekey == "_a") {
    var_1 = 1;
  }

  var_0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("plant");
  var_0 notify("super_obj_drain");
  var_0.isplanting = 1;
  var_0.bombplantweapon = self.useweapon;
  thread setbombplantingomnvar(var_0);
  scripts\mp\utility\dialog::statusdialog("bomb_planting" + self.objectivekey, var_0.team, "status");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_bomb_planting");
  thread startnpcbombusesound(var_0, "briefcase_bomb_mp");
}

function bombzone_onenduse(var_0, var_1, var_2) {
  if(var_2 && istrue(var_1.isdefusing)) {
    setomnvar("ui_bomb_interacting", 0);
  }

  setomnvar("ui_bomb_defuser", -1);
  var_3 = self.objidnum;

  if(level.resetprogress) {
    scripts\mp\objidpoolmanager::objective_set_progress(var_3, 0);
    scripts\mp\objidpoolmanager::objective_show_progress(var_3, 0);
  }

  if(!var_2) {
    if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0) {
      self.showprogressforteam = undefined;
    }

    if(var_1.isdefusing) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse_nt", "waypoint_bomb_defend_nt");
    } else if(scripts\mp\utility\game::getgametype() == "btm") {
      scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
    } else {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    }

    if(isDefined(self.radialtimeobjid)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var_1.team);
    }
  }

  if(!isDefined(var_1)) {
    return;
  }

  thread allowedwhileplanting(var_1);
  var_1.bombplantweapon = undefined;

  if(isalive(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_bomb_planting_defusing = undefined;
  }

  if(scripts\mp\gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(level.codcasterenabled) {
      var_1 setgametypevip(0);
      return;
    }

    return;
  }

  if(isDefined(level.sdbombmodel) && !var_2) {
    if(self.bombplanted) {
      level.sdbombmodel show();
      return;
    }

    return;
  }

  if(isDefined(level.ddbombmodel)) {
    if(isDefined(level.ddbombmodel[self.objectivekey]) && !var_2) {
      level.ddbombmodel[self.objectivekey] show();
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

function bombzone_oncantuse(var_0) {}

function bombzone_onuseplantobject(var_0) {
  if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0 || !scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    self.showprogressforteam = undefined;
    thread bombzone_onbombplanted(level, self);
    var_0 playSound("mp_bomb_plant");
    var_0 notify("bomb_planted");
    var_1 = 2;

    if(self.objectivekey == "_a") {
      var_1 = 1;
    }

    scripts\mp\utility\game::setmlgannouncement(0, var_0.team, var_0 getentitynumber(), var_1);
    var_0 scripts\mp\utility\stats::incpersstat("plants", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "plants", var_0.pers["plants"]);
    var_0 scripts\cp_mp\pet_watch::addplantingcharge();
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["plants"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
      thread removebombcarrierclass();
    }

    if(scripts\mp\utility\game::getgametype() != "cmd") {
      if(scripts\mp\utility\game::inovertime()) {
        scripts\mp\utility\dialog::statusdialog("enemy_bomb_planted", scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("enemy_bomb" + self.objectivekey, scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);
      }

      scripts\mp\utility\dialog::statusdialog("bomb_planted", var_0.team, 1);
    }

    level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombplanted", var_0);
    level.bombowner = var_0;
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("plant");
    var_0.bombplantedtime = gettime();

    if(isPlayer(var_0)) {
      var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_12062();
      var_0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "plant", var_0.origin);
      return;
    }

    return;
  }
}

function bombzone_onusedefuseobject(var_0) {
  var_1 = 0;
  setomnvar("ui_bomb_interacting", 0);

  foreach(var_3 in level.objectives) {
    if(isDefined(var_3.objectivekey) && var_3.objectivekey == self.objectivekey) {
      var_0 notify("bomb_defused" + var_3.objectivekey);
      thread bombdefused(level);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd") {
    scripts\mp\gameobjects::disableobject();
    iprintln(&"MP/EXPLOSIVES_DEFUSED_BY", var_0);
  }

  scripts\mp\utility\dialog::statusdialog("enemy_bomb_defused", scripts\mp\utility\game::getotherteam(var_0.team)[0], 1);
  scripts\mp\utility\dialog::statusdialog("bomb_defused", var_0.team, 1);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombdefused", var_0);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_1201f();
  scripts\mp\events::bombdefused(var_0);
}

function bombzone_onbombplanted(var_0, var_1) {
  level endon("bombs_canceled");
  level notify("bomb_planted", var_0);
  var_2 = var_1.team;
  level.bombdefused = 0;
  var_0.bombdefused = 0;

  if(scripts\mp\utility\game::getgametype() == "dd" && level.bombsplanted <= 0) {
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
  }

  level.bombplanted = 1;
  level.bombsplanted += 1;

  if(scripts\mp\utility\game::getgametype() != "btm") {
    level.timelimitoverride = 1;
  }

  level.defuseendtime = int(gettime() + level.bombtimer * 1000);

  if(var_0.objectivekey == "_a") {
    level.aplanted = 1;
  } else {
    level.bplanted = 1;
  }

  setbombtimeromnvars(var_1.team);
  level.destroyedobject = var_0;
  level.destroyedobject.bombplanted = 1;

  if(!level.multibomb) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level.defuseendtime);
  }

  var_0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];

  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("none");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
    var_3 = removespawnprotectiononnotify();
    level.sdbomb scripts\mp\gameobjects::setdropped(undefined, scripts\engine\utility::ter_op(var_3 > 0, var_3, undefined));
    level.sdbombmodel = level.sdbomb.visuals[0];
    setteaminhuddatafromteamname(level.sdbombmodel, var_2);
    level.sdbombmodel setasgametypeobjective();
  } else if(scripts\mp\utility\game::getgametype() == "cmd") {} else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "btm") {
    level.ddbombmodel[var_0.objectivekey] = spawn("script_model", var_1.origin);
    level.ddbombmodel[var_0.objectivekey].angles = var_1.angles;
    level.ddbombmodel[var_0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var_0.objectivekey] setasgametypeobjective();
    level.ddbombmodel[var_0.objectivekey] setnonstick(1);
  } else if(scripts\mp\utility\game::getgametype() == "to_dd") {
    var_4 = var_0.trigger.origin;
    var_5 = var_0.trigger.angles;
    var_6 = (0, 0, 0);

    if(isDefined(level.tacopssublevel)) {
      if(var_0.objectivekey == "_a") {
        var_6 = (0, 0, 50);
        var_5 = (-90, -45, 0);
      } else {
        var_6 = (0, 0, 50);
        var_5 = (-90, 90, 0);
      }
    }

    level.ddbombmodel[var_0.objectivekey] = spawn("script_model", var_4 + var_6);
    level.ddbombmodel[var_0.objectivekey].angles = var_5;
    level.ddbombmodel[var_0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var_0.objectivekey] setasgametypeobjective();
  } else {
    level.sdbombmodel = spawn("script_model", var_1.origin);
    level.sdbombmodel.angles = var_1.angles;
    level.sdbombmodel setModel(getbombmodel());
    level.sdbombmodel setasgametypeobjective();
    level.sdbombmodel setnonstick(1);
  }

  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" || scripts\mp\utility\game::getgametype() != "btm") {
    var_0 scripts\mp\gameobjects::allowuse("none");
    var_0 scripts\mp\gameobjects::setvisibleteam("none");
  }

  var_7 = [];
  jumpiffalse(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") LOC_000003f7;
  var_8 = var_0;
  var_8 scripts\mp\gameobjects::setownerteam(var_1.team);
  goto LOC_0000045f;
}

function removespawnprotectiononnotify() {
  switch (level.mapname) {
    case "mp_m_stadium":
      return 10;
    default:
      return 0;
  }
}

function current_carrier(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level.framedurationseconds;
  var_4 = var_3 * 1000;
  var_5 = level.bombtimer * 1000;
  var_6 = var_4 / var_5;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    var_7 = "invisible";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, var_7, self.curorigin + self.offset3d);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var_1, var_2, self.radialtimeobjid);
  self.bombplanted = 1;

  while(self.bombplanted) {
    var_8 = var_6;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.radialtimeobjid, var_0);
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, var_8);
    var_6 = min(var_6 + var_4 / var_5, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);
  self.radialtimeobjid = -1;
}

function getbombmodel(var_0) {
  if(istrue(level.setplayerselfrevivingextrainfo) && istrue(var_0)) {
    return "military_dogtags_human_skull_01";
  }

  return "offhand_wm_briefcase_bomb";
}

function initobjectivecam(var_0) {
  var_1 = undefined;
  var_2 = getEntArray("sd_bombcam_start", "targetname");

  foreach(var_4 in var_2) {
    if(var_4.script_label == var_0.objectivekey) {
      var_1 = var_4;
      break;
    }
  }

  var_6 = [];

  if(isDefined(var_1) && isDefined(var_1.target)) {
    var_7 = getEnt(var_1.target, "targetname");

    while(isDefined(var_7)) {
      var_6 = var_7;

      if(isDefined(var_7.target)) {
        var_7 = getEnt(var_7.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(isDefined(var_1) && var_6.size) {
    var_8 = spawn("script_model", var_1.origin);
    var_8.origin = var_1.origin;
    var_8.angles = var_1.angles;
    var_8.path = var_6;
    var_8 setModel("tag_origin");
    var_8 hide();
    return var_8;
  }

  return undefined;
}

function runobjectivecam() {
  level notify("objective_cam");

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait 0.5;

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::setusingremote("objective_cam");
      var_1 scripts\common\utility::allow_weapon(0);
      var_1 playerlinkweaponviewtodelta(self, "tag_player", 1, 180, 180, 180, 180, 1);
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 setplayerangles(self.angles);
      var_1 visionsetnakedforplayer("", 0.5);
    }
  }

  for(var_5 = 0; var_5 < self.path.size; var_5++) {
    var_6 = 0;

    if(var_5 == 0) {
      var_6 = 5 / self.path.size / 2;
    }

    var_7 = 0;

    if(var_5 == self.path.size - 1) {
      var_7 = 5 / self.path.size / 2;
    }

    self moveTo(self.path[var_5].origin, 5 / self.path.size, var_6, var_7);
    self rotateTo(self.path[var_5].angles, 5 / self.path.size, var_6, var_7);
    wait 5 / self.path.size;
  }
}

function bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bombs_canceled");
  level endon("bomb_defused" + var_0);
  var_1 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + var_0, var_1);
  thread updatetimerconstant("ui_bomb_timer_endtime" + var_0, var_1, level.bombtimer * 1000, var_0);
  thread handlehostmigration(level, var_1);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function updatetimerconstant(var_0, var_1, var_2, var_3) {
  level endon("bombs_canceled");
  level endon("bomb_defused" + var_3);
  self.startbombtime = gettime();

  while(gettime() < var_1) {
    var_4 = gettime() - self.startbombtime;
    setomnvar(var_0, int(gettime() + var_2 - var_4));
    waitframe();
  }
}

function handlehostmigration(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused" + var_1);
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + var_1, 0);
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    setomnvar("ui_bomb_timer_endtime" + var_1, var_0 + var_2);
    return;
  }
}

function bombdefused(var_0) {
  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm") {
    level.bombdefused = 1;
  }

  var_0.bombdefused = 1;
  setbombtimeromnvars();
  level notify("bomb_defused" + var_0.objectivekey);

  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.objectivekey, undefined, game["defenders"], undefined);
    return;
  }
}

function updatebombplantedomnvar(var_0) {
  if(scripts\mp\utility\game::getgametype() == "cmd") {
    return;
  }

  if(isDefined(var_0)) {
    if(var_0 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  if(isDefined(level.aplanted)) {
    if(level.aplanted) {
      setomnvar("ui_bomb_planted_a", 1);
    } else {
      setomnvar("ui_bomb_planted_a", 0);
    }
  }

  if(isDefined(level.bplanted)) {
    if(level.bplanted) {
      setomnvar("ui_bomb_planted_b", 1);
      return;
    }

    setomnvar("ui_bomb_planted_b", 0);
    return;
  }
}

function setbombtimeromnvars(var_0) {
  updatebombplantedomnvar(var_0);
}

function bombzone_setupbombcase(var_0) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_1 = getEnt(var_0 + "_pickup_trig", "targetname");

  if(!isDefined(var_1)) {
    scripts\engine\utility::error("No " + var_0 + "_pickup_trig trigger found in map.");
    return;
  }

  GscBinSkip1(0x45, 0, getEnt(var_0, "targetname"));
}

function getadjustedfirstroundbombcaseposition(var_0, var_1) {
  switch (level.mapname) {
    case "mp_raid":
      if(scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0) {
        var_2 = (-518, -959.2, 267);

        if(istrue(var_1)) {
          var_0.origin = var_2;
        } else {
          var_0.origin = var_2;
          var_0.angles = (0, 90, 0);
        }
      }

      break;
    case "mp_petrograd":
      var_2 = (263, -2500, 146);

      if(istrue(var_1)) {
        var_0.origin = var_2;
      } else {
        var_0.origin = var_2;
        var_0.angles = (0, 90, 0);
      }

      break;
    default:
      break;
  }

  return var_0;
}

function movebombcase(var_0, var_1) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = var_0;
    level.sdbomb.visuals[0].origin = var_0;
    level.sdbomb.visuals[0].angles = var_1;
    level.sdbomb.visuals[0] show();
    level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");
    level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = &onpickup;
    level.sdbomb.ondrop = &ondrop;
    return;
  }
}

function bombsitewatcher() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup");

    foreach(var_1 in level.objectives) {
      var_1.trigger enableplayeruse(level.sdbomb.carrier);
    }

    waitframe();
  }
}

function onpickup(var_0, var_1, var_2) {
  var_0.isbombcarrier = 1;

  if(isPlayer(var_0)) {
    var_0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var_0.origin);
    scripts\mp\utility\game::setmlgannouncement(1, var_0.team, var_0 getentitynumber());
  }

  var_0 setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", var_0 getentitynumber());
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_escort_bomb");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
    thread applybombcarrierclass();
  }

  if(!level.bombdefused) {
    var_0 thread scripts\mp\hud_message::showsplash("callout_bombpickup");
    scripts\mp\hud_util::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);

    if(istrue(self.firstpickup)) {
      var_3 = "bomb_pickup_first";
      self.firstpickup = 0;

      if(istrue(level.setplayerselfrevivingextrainfo)) {
        level.sdbomb.visuals[0] setModel(getbombmodel());
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], self.trigger.origin + (0, 0, -9970));
      }
    } else {
      var_3 = "bomb_pickup";
    }

    var_4 = [];
    GscBinSkip0(0x2e, var_4.size, var_1, var_0);
  }

  scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);

  if(level.codcasterenabled) {
    var_3 setgametypevip(1);
  }

  scripts\mp\utility\game::ref_119ac(var_3, undefined, "Bomb Picked Up", var_3.origin);
  level notify("bomb_pickup");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_3.team, 25, undefined, var_3, 21);
}

function ondrop(var_0) {
  level notify("bomb_dropped");
  setomnvar("ui_bomb_carrier", -1);

  if(level.codcasterenabled) {
    if(isDefined(var_0)) {
      var_0 setgametypevip(0);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
  scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);

  if(isDefined(var_0)) {
    var_0.isbombcarrier = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var_0.team, 24);
  }

  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0) {
    thread waitforbombreset(level.bombresettimer);
    return;
  }
}

function waitforbombreset(var_0) {
  level endon("game_ended");
  level endon("bomb_pickup");
  wait var_0;
  scripts\mp\weapons::equipmentdeletevfx(self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

function enablemultibombui() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("ui_carrying_bomb", var_1.pers["team"] == game["attackers"]);
    }
  }
}

function respawnbombcase() {
  level endon("game_ended");
  wait 5;

  if(level.multibomb) {
    enablemultibombui();
    return;
  }

  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

function advancebombcase() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombrespawnpoint = level.curobj.visuals[0].origin + (0, 0, 48);
  level.bombrespawnangles = level.curobj.visuals[0].angles;

  if(level.multibomb) {
    enablemultibombui();
    return;
  }

  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
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

  self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
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

  self.pers["gamemodeLoadout"] = undefined;
  scripts\mp\equipment\tac_insert::ref_13684(self.origin, self.angles);
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

function bombzone_awardgenericbombzonemedals(var_0, var_1) {
  foreach(var_3 in level.objectives) {
    if(!isDefined(var_3.bombdefusetrig.origin)) {
      continue;
    }

    var_4 = istrue(var_3.bombplanted);
    var_5 = distsquaredcheck(var_0.origin, var_1.origin, scripts\engine\utility::ter_op(var_4, var_3.bombdefusetrig.origin, var_3.trigger.origin));

    if(var_5) {
      if(scripts\mp\utility\game::getgametype() == "dd" && scripts\mp\utility\game::inovertime()) {
        if(var_0.team == var_3.ownerteam) {
          var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "defend", "assault"));
          var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "mode_x_defend", "mode_x_assault"));
        } else {
          var_0 thread scripts\mp\rank::scoreeventpopup("assault");
          var_0 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        }

        continue;
      }

      if(var_1.team == game["defenders"]) {
        var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "defend", "assault"));
        var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "mode_x_defend", "mode_x_assault"));
        continue;
      }

      var_0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var_4, "assault", "defend"));
      var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "mode_x_assault", "mode_x_defend"));
    }
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

function playerdelayedvo(var_0, var_1) {
  var_2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming)) {
    var_3 = 8;
  } else {
    var_3 = 5;
  }

  var_4 = var_3 - var_3;

  if(var_4 > 0) {
    wait var_4;
  }

  if(isDefined(var_1)) {
    var_1 scripts\mp\utility\dialog::leaderdialogonplayer(var_2);
    return;
  }
}

function teamdelayedvo(var_0, var_1) {
  var_2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming)) {
    var_3 = 8;
  } else {
    var_3 = 5;
  }

  var_4 = var_3 - var_3;

  if(var_4 > 0) {
    wait var_4;
  }

  scripts\mp\utility\dialog::leaderdialog("bomb_achieve", var_1, "bomb", var_2);
}

function resetuiomnvargamemode() {
  self setclientomnvar("ui_carrying_bomb", 0);
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