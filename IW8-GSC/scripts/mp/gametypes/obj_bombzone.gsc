/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

function setupobjective(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;

  if(isDefined(level.curobj)) {
    level.curobj scripts\mp\gameobjects::deleteuseobject();
  }

  if(isDefined(var0.originalpos)) {
    var0.origin = var0.originalpos;
  } else {
    var0.originalpos = var0.origin;
  }

  var5 = getEntArray(var0.target, "targetname");

  if(isDefined(var0.objectivekey)) {
    var6 = var0.objectivekey;
  } else {
    var6 = var1.script_label;
  }

  if(istrue(var3)) {
    var7 = getreservedobjid(var6);
  } else {
    var7 = undefined;
  }

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd") {
    var6 = var2.script_label;
    var8 = getEnt("dd_bombzone_clip" + var6, "targetname");

    if(scripts\mp\utility\game::inovertime()) {
      if(var6 == "_a" || var6 == "_b") {
        var2 delete();
        var6[0] delete();
        var8 delete();
        return;
      }

      var5 = scripts\mp\gameobjects::createuseobject("neutral", var2, var6, (0, 0, 64), var7, var3);
      var5 scripts\mp\gameobjects::allowuse("any");
      var5.trigger.script_label = "_a";
    } else if(var6 == "_c") {
      var2 delete();
      var6[0] delete();
      var8 delete();
      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "sd") {
    setomnvar("ui_bomb_owner_team", 0);
  }

  if(!isDefined(var5)) {
    var5 = scripts\mp\gameobjects::createuseobject(game["defenders"], var2, var6, (0, 0, 64), var7, var3);
    var5 scripts\mp\gameobjects::allowuse("enemy");
  }

  if(isDefined(var2.objectivekey)) {
    var5.objectivekey = var2.objectivekey;
  } else {
    var5.objectivekey = var5 scripts\mp\gameobjects::getlabel();
  }

  if(isDefined(var2.iconname)) {
    var5.iconname = var2.iconname;
  } else {
    var5.iconname = var5 scripts\mp\gameobjects::getlabel();
  }

  var5.id = "bomb_zone";
  var5.trigger setusepriority(-3);
  var5 scripts\mp\gameobjects::setusetime(level.planttime);
  var5 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var5 scripts\mp\gameobjects::setusehinttext(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  var5.trigger setuseholdduration("duration_none");

  if(!level.multibomb) {
    var5 scripts\mp\gameobjects::setkeyobject(level.sdbomb);
  }

  if(var5.objectivekey == "_c") {
    var5.objectivekey = "_a";
    var5.iconname = "_a";
  }

  if((scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd") && scripts\mp\utility\game::inovertime()) {
    var5 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_target");
    var5 scripts\mp\gameobjects::setvisibleteam("any");
  }

  var5.onbeginuse = &bombzone_onbeginuse;
  var5.onenduse = &bombzone_onenduse;
  var5.onuse = &bombzone_onuseplantobject;
  var5.oncantuse = &bombzone_oncantuse;
  var5.useweapon = getcompleteweaponname("briefcase_bomb_mp");
  var5.bombplanted = 0;
  var5.bombexploded = undefined;
  var5.resetprogress = level.resetprogress;

  for(var9 = 0; var9 < var6.size; var9++) {
    if(isDefined(var6[var9].script_exploder)) {
      var5.exploderindex = var6[var9].script_exploder;
      thread setupkillcament(var6[var9]);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd") {
    var5.bombdefusetrig = getEnt(var6[0].target, "targetname");
    var5.bombdefusetrig.origin += (0, 0, -10000);
    var5.bombdefusetrig.label = var6;
  } else {
    var10 = getEnt(var6[0].target, "targetname");
    var10 delete();
    var5.bombdefusetrig = var5.trigger;
  }

  var5.noweapondropallowedtrigger = spawn("trigger_radius", var5.trigger.origin, 0, 140, 100);
  return var5;
}

function getreservedobjid(var0) {
  if(var0 == "_a") {
    var1 = 0;
  } else {
    var1 = 1;
  }

  return var1;
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

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case "mp_spear":
    case "mp_spear_pm":
      if(var0.objectivekey == "_a") {
        var2 = (1373, 2048, 213);
      }

      break;
    default:
      break;
  }

  self.killcament = spawn("script_model", var2);
  self.killcament setscriptmoverkillcam("explosive");
  var0.killcamentnum = self.killcament getentitynumber();
  var1 delete();
}

function allowedwhileplanting(var0) {
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

function setbombplantingomnvar(var0) {
  wait 0.35;

  if(var0 == "_a") {
    var1 = 1;
  } else {
    var1 = 2;
  }

  setomnvar("ui_bomb_interacting", var1);
}

function setbombdefusingomnvar(var0) {
  wait 0.35;

  if(var0 == "_a") {
    var1 = 3;
  } else {
    var1 = 4;
  }

  setomnvar("ui_bomb_interacting", var1);
}

function bombzone_onbeginuse(var0) {
  thread allowedwhileplanting(var0);

  if(!scripts\mp\gameobjects::isfriendlyteam(var0.pers["team"]) && self.bombplanted) {
    if(level.codcasterenabled) {
      var0 setgametypevip(1);
    }

    var0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("defuse");
    var0 notify("super_obj_drain");
    var0.isdefusing = 1;
    thread setbombdefusingomnvar(var0);
    setomnvar("ui_bomb_defuser", var0 getentitynumber());
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb_defend_nt", "waypoint_bomb_defusing");
    scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.radialtimeobjid, var0.team);
    scripts\mp\utility\game::setmlgannouncement(2, var0.team, var0 getentitynumber());

    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
    } else if(isDefined(level.ddbombmodel[self.objectivekey])) {
      level.ddbombmodel[self.objectivekey] hide();
    }

    thread startnpcbombusesound(var0, "briefcase_bomb_defuse_mp");
    return;
  }

  var1 = 2;

  if(self.objectivekey == "_a") {
    var1 = 1;
  }

  var0 scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("plant");
  var0 notify("super_obj_drain");
  var0.isplanting = 1;
  var0.bombplantweapon = self.useweapon;
  thread setbombplantingomnvar(var0);
  scripts\mp\utility\dialog::statusdialog("bomb_planting" + self.objectivekey, var0.team, "status");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_bomb_planting");
  thread startnpcbombusesound(var0, "briefcase_bomb_mp");
}

function bombzone_onenduse(var0, var1, var2) {
  if(var2 && istrue(var1.isdefusing)) {
    setomnvar("ui_bomb_interacting", 0);
  }

  setomnvar("ui_bomb_defuser", -1);
  var3 = self.objidnum;

  if(level.resetprogress) {
    scripts\mp\objidpoolmanager::objective_set_progress(var3, 0);
    scripts\mp\objidpoolmanager::objective_show_progress(var3, 0);
  }

  if(!var2) {
    if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0) {
      self.showprogressforteam = undefined;
    }

    if(var1.isdefusing) {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defuse_nt", "waypoint_bomb_defend_nt");
    } else if(scripts\mp\utility\game::getgametype() == "btm") {
      scripts\mp\gameobjects::setobjectivestatusicons(level.iconplant);
    } else {
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend", "waypoint_target");
    }

    if(isDefined(self.radialtimeobjid)) {
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.radialtimeobjid, var1.team);
    }
  }

  if(!isDefined(var1)) {
    return;
  }

  thread allowedwhileplanting(var1);
  var1.bombplantweapon = undefined;

  if(isalive(var1)) {
    var1.isdefusing = 0;
    var1.isplanting = 0;
  }

  if(isPlayer(var1)) {
    var1 setclientomnvar("ui_objective_state", 0);
    var1.ui_bomb_planting_defusing = undefined;
  }

  if(scripts\mp\gameobjects::isfriendlyteam(var1.pers["team"])) {
    if(level.codcasterenabled) {
      var1 setgametypevip(0);
      return;
    }

    return;
  }

  if(isDefined(level.sdbombmodel) && !var2) {
    if(self.bombplanted) {
      level.sdbombmodel show();
      return;
    }

    return;
  }

  if(isDefined(level.ddbombmodel)) {
    if(isDefined(level.ddbombmodel[self.objectivekey]) && !var2) {
      level.ddbombmodel[self.objectivekey] show();
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

function bombzone_oncantuse(var0) {}

function bombzone_onuseplantobject(var0) {
  if(scripts\mp\utility\game::inovertime() && self.bombplanted == 0 || !scripts\mp\gameobjects::isfriendlyteam(var0.pers["team"])) {
    self.showprogressforteam = undefined;
    thread bombzone_onbombplanted(level, self);
    var0 playSound("mp_bomb_plant");
    var0 notify("bomb_planted");
    var1 = 2;

    if(self.objectivekey == "_a") {
      var1 = 1;
    }

    scripts\mp\utility\game::setmlgannouncement(0, var0.team, var0 getentitynumber(), var1);
    var0 scripts\mp\utility\stats::incpersstat("plants", 1);
    var0 scripts\mp\persistence::statsetchild("round", "plants", var0.pers["plants"]);
    var0 scripts\cp_mp\pet_watch::addplantingcharge();
    var0 scripts\mp\utility\stats::setextrascore0(var0.pers["plants"]);

    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var0.team])) {
      thread removebombcarrierclass();
    }

    if(scripts\mp\utility\game::getgametype() != "cmd") {
      if(scripts\mp\utility\game::inovertime()) {
        scripts\mp\utility\dialog::statusdialog("enemy_bomb_planted", scripts\mp\utility\game::getotherteam(var0.team)[0], 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("enemy_bomb" + self.objectivekey, scripts\mp\utility\game::getotherteam(var0.team)[0], 1);
      }

      scripts\mp\utility\dialog::statusdialog("bomb_planted", var0.team, 1);
    }

    level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombplanted", var0);
    level.bombowner = var0;
    var0 thread scripts\mp\utility\points::giveunifiedpoints("plant");
    var0.bombplantedtime = gettime();

    if(isPlayer(var0)) {
      var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12062();
      var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "plant", var0.origin);
      return;
    }

    return;
  }
}

function bombzone_onusedefuseobject(var0) {
  var1 = 0;
  setomnvar("ui_bomb_interacting", 0);

  foreach(var3 in level.objectives) {
    if(isDefined(var3.objectivekey) && var3.objectivekey == self.objectivekey) {
      var0 notify("bomb_defused" + var3.objectivekey);
      thread bombdefused(level);
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd") {
    scripts\mp\gameobjects::disableobject();
    iprintln(&"MP/EXPLOSIVES_DEFUSED_BY", var0);
  }

  scripts\mp\utility\dialog::statusdialog("enemy_bomb_defused", scripts\mp\utility\game::getotherteam(var0.team)[0], 1);
  scripts\mp\utility\dialog::statusdialog("bomb_defused", var0.team, 1);
  level thread scripts\mp\hud_util::teamplayercardsplash("callout_bombdefused", var0);
  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_1201f();
  scripts\mp\events::bombdefused(var0);
}

function bombzone_onbombplanted(var0, var1) {
  level endon("bombs_canceled");
  level notify("bomb_planted", var0);
  var2 = var1.team;
  level.bombdefused = 0;
  var0.bombdefused = 0;

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

  if(var0.objectivekey == "_a") {
    level.aplanted = 1;
  } else {
    level.bplanted = 1;
  }

  setbombtimeromnvars(var1.team);
  level.destroyedobject = var0;
  level.destroyedobject.bombplanted = 1;

  if(!level.multibomb) {
    var1 setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level.defuseendtime);
  }

  var0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = var0.visuals[0];

  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("none");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
    var3 = removespawnprotectiononnotify();
    level.sdbomb scripts\mp\gameobjects::setdropped(undefined, scripts\engine\utility::ter_op(var3 > 0, var3, undefined));
    level.sdbombmodel = level.sdbomb.visuals[0];
    setteaminhuddatafromteamname(level.sdbombmodel, var2);
    level.sdbombmodel setasgametypeobjective();
  } else if(scripts\mp\utility\game::getgametype() == "cmd") {} else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "btm") {
    level.ddbombmodel[var0.objectivekey] = spawn("script_model", var1.origin);
    level.ddbombmodel[var0.objectivekey].angles = var1.angles;
    level.ddbombmodel[var0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var0.objectivekey] setasgametypeobjective();
    level.ddbombmodel[var0.objectivekey] setnonstick(1);
  } else if(scripts\mp\utility\game::getgametype() == "to_dd") {
    var4 = var0.trigger.origin;
    var5 = var0.trigger.angles;
    var6 = (0, 0, 0);

    if(isDefined(level.tacopssublevel)) {
      if(var0.objectivekey == "_a") {
        var6 = (0, 0, 50);
        var5 = (-90, -45, 0);
      } else {
        var6 = (0, 0, 50);
        var5 = (-90, 90, 0);
      }
    }

    level.ddbombmodel[var0.objectivekey] = spawn("script_model", var4 + var6);
    level.ddbombmodel[var0.objectivekey].angles = var5;
    level.ddbombmodel[var0.objectivekey] setModel(getbombmodel());
    level.ddbombmodel[var0.objectivekey] setasgametypeobjective();
  } else {
    level.sdbombmodel = spawn("script_model", var1.origin);
    level.sdbombmodel.angles = var1.angles;
    level.sdbombmodel setModel(getbombmodel());
    level.sdbombmodel setasgametypeobjective();
    level.sdbombmodel setnonstick(1);
  }

  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" || scripts\mp\utility\game::getgametype() != "btm") {
    var0 scripts\mp\gameobjects::allowuse("none");
    var0 scripts\mp\gameobjects::setvisibleteam("none");
  }

  var7 = [];
  jumpiffalse(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") LOC_000003f7;
  var8 = var0;
  var8 scripts\mp\gameobjects::setownerteam(var1.team);
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

function current_carrier(var0, var1, var2) {
  level endon("game_ended");
  var3 = level.framedurationseconds;
  var4 = var3 * 1000;
  var5 = level.bombtimer * 1000;
  var6 = var4 / var5;
  self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.radialtimeobjid != -1) {
    var7 = "invisible";
    scripts\mp\objidpoolmanager::objective_add_objective(self.radialtimeobjid, var7, self.curorigin + self.offset3d);
    scripts\mp\objidpoolmanager::objective_set_play_intro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(self.radialtimeobjid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.radialtimeobjid);
    self.showworldicon = 1;
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var1, var2, self.radialtimeobjid);
  self.bombplanted = 1;

  while(self.bombplanted) {
    var8 = var6;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.radialtimeobjid, var0);
    scripts\mp\objidpoolmanager::objective_show_progress(self.radialtimeobjid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.radialtimeobjid, var8);
    var6 = min(var6 + var4 / var5, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.radialtimeobjid);
  self.radialtimeobjid = -1;
}

function getbombmodel(var0) {
  if(istrue(level.setplayerselfrevivingextrainfo) && istrue(var0)) {
    return "military_dogtags_human_skull_01";
  }

  return "offhand_wm_briefcase_bomb";
}

function initobjectivecam(var0) {
  var1 = undefined;
  var2 = getEntArray("sd_bombcam_start", "targetname");

  foreach(var4 in var2) {
    if(var4.script_label == var0.objectivekey) {
      var1 = var4;
      break;
    }
  }

  var6 = [];

  if(isDefined(var1) && isDefined(var1.target)) {
    var7 = getEnt(var1.target, "targetname");

    while(isDefined(var7)) {
      var6 = var7;

      if(isDefined(var7.target)) {
        var7 = getEnt(var7.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(isDefined(var1) && var6.size) {
    var8 = spawn("script_model", var1.origin);
    var8.origin = var1.origin;
    var8.angles = var1.angles;
    var8.path = var6;
    var8 setModel("tag_origin");
    var8 hide();
    return var8;
  }

  return undefined;
}

function runobjectivecam() {
  level notify("objective_cam");

  foreach(var1 in level.players) {
    if(!isai(var1)) {
      var1 scripts\mp\utility\player::_freezecontrols(1);
      var1 visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait 0.5;

  foreach(var1 in level.players) {
    if(!isai(var1)) {
      var1 scripts\mp\utility\player::setusingremote("objective_cam");
      var1 scripts\common\utility::allow_weapon(0);
      var1 playerlinkweaponviewtodelta(self, "tag_player", 1, 180, 180, 180, 180, 1);
      var1 scripts\mp\utility\player::_freezecontrols(1);
      var1 setplayerangles(self.angles);
      var1 visionsetnakedforplayer("", 0.5);
    }
  }

  for(var5 = 0; var5 < self.path.size; var5++) {
    var6 = 0;

    if(var5 == 0) {
      var6 = 5 / self.path.size / 2;
    }

    var7 = 0;

    if(var5 == self.path.size - 1) {
      var7 = 5 / self.path.size / 2;
    }

    self moveTo(self.path[var5].origin, 5 / self.path.size, var6, var7);
    self rotateTo(self.path[var5].angles, 5 / self.path.size, var6, var7);
    wait 5 / self.path.size;
  }
}

function bombtimerwait(var0) {
  level endon("game_ended");
  level endon("bombs_canceled");
  level endon("bomb_defused" + var0);
  var1 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + var0, var1);
  thread updatetimerconstant("ui_bomb_timer_endtime" + var0, var1, level.bombtimer * 1000, var0);
  thread handlehostmigration(level, var1);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function updatetimerconstant(var0, var1, var2, var3) {
  level endon("bombs_canceled");
  level endon("bomb_defused" + var3);
  self.startbombtime = gettime();

  while(gettime() < var1) {
    var4 = gettime() - self.startbombtime;
    setomnvar(var0, int(gettime() + var2 - var4));
    waitframe();
  }
}

function handlehostmigration(var0, var1) {
  level endon("game_ended");
  level endon("bomb_defused" + var1);
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + var1, 0);
  var2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var2 > 0) {
    setomnvar("ui_bomb_timer_endtime" + var1, var0 + var2);
    return;
  }
}

function bombdefused(var0) {
  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm") {
    level.bombdefused = 1;
  }

  var0.bombdefused = 1;
  setbombtimeromnvars();
  level notify("bomb_defused" + var0.objectivekey);

  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.objectivekey, undefined, game["defenders"], undefined);
    return;
  }
}

function updatebombplantedomnvar(var0) {
  if(scripts\mp\utility\game::getgametype() == "cmd") {
    return;
  }

  if(isDefined(var0)) {
    if(var0 == "allies") {
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

function setbombtimeromnvars(var0) {
  updatebombplantedomnvar(var0);
}

function bombzone_setupbombcase(var0) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var1 = getEnt(var0 + "_pickup_trig", "targetname");

  if(!isDefined(var1)) {
    scripts\engine\utility::error("No " + var0 + "_pickup_trig trigger found in map.");
    return;
  }

  GscBinSkip1(0x45, 0, getEnt(var0, "targetname"));
}

function getadjustedfirstroundbombcaseposition(var0, var1) {
  switch (level.mapname) {
    case "mp_raid":
      if(scripts\mp\flags::gameflag("infil_will_run") && game["roundsPlayed"] == 0) {
        var2 = (-518, -959.2, 267);

        if(istrue(var1)) {
          var0.origin = var2;
        } else {
          var0.origin = var2;
          var0.angles = (0, 90, 0);
        }
      }

      break;
    case "mp_petrograd":
      var2 = (263, -2500, 146);

      if(istrue(var1)) {
        var0.origin = var2;
      } else {
        var0.origin = var2;
        var0.angles = (0, 90, 0);
      }

      break;
    default:
      break;
  }

  return var0;
}

function movebombcase(var0, var1) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = var0;
    level.sdbomb.visuals[0].origin = var0;
    level.sdbomb.visuals[0].angles = var1;
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

    foreach(var1 in level.objectives) {
      var1.trigger enableplayeruse(level.sdbomb.carrier);
    }

    waitframe();
  }
}

function onpickup(var0, var1, var2) {
  var0.isbombcarrier = 1;

  if(isPlayer(var0)) {
    var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var0.origin);
    scripts\mp\utility\game::setmlgannouncement(1, var0.team, var0 getentitynumber());
  }

  var0 setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", var0 getentitynumber());
  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_escort_bomb");

  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var0.team])) {
    thread applybombcarrierclass();
  }

  if(!level.bombdefused) {
    var0 thread scripts\mp\hud_message::showsplash("callout_bombpickup");
    scripts\mp\hud_util::teamplayercardsplash("callout_bombtaken", var0, var0.team);

    if(istrue(self.firstpickup)) {
      var3 = "bomb_pickup_first";
      self.firstpickup = 0;

      if(istrue(level.setplayerselfrevivingextrainfo)) {
        level.sdbomb.visuals[0] setModel(getbombmodel());
        playFX(level.spawnoffsettacinsertmax["vanish_hw_fr"], self.trigger.origin + (0, 0, -9970));
      }
    } else {
      var3 = "bomb_pickup";
    }

    var4 = [];
    GscBinSkip0(0x2e, var4.size, var1, var0);
  }

  scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);

  if(level.codcasterenabled) {
    var3 setgametypevip(1);
  }

  scripts\mp\utility\game::ref_119ac(var3, undefined, "Bomb Picked Up", var3.origin);
  level notify("bomb_pickup");
  level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var3.team, 25, undefined, var3, 21);
}

function ondrop(var0) {
  level notify("bomb_dropped");
  setomnvar("ui_bomb_carrier", -1);

  if(level.codcasterenabled) {
    if(isDefined(var0)) {
      var0 setgametypevip(0);
    }
  }

  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_bomb");
  scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);

  if(isDefined(var0)) {
    var0.isbombcarrier = 0;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers(var0.team, 24);
  }

  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0) {
    thread waitforbombreset(level.bombresettimer);
    return;
  }
}

function waitforbombreset(var0) {
  level endon("game_ended");
  level endon("bomb_pickup");
  wait var0;
  scripts\mp\weapons::equipmentdeletevfx(self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

function enablemultibombui() {
  foreach(var1 in level.players) {
    if(!isai(var1)) {
      var1 setclientomnvar("ui_carrying_bomb", var1.pers["team"] == game["attackers"]);
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

function bombzone_awardgenericbombzonemedals(var0, var1) {
  foreach(var3 in level.objectives) {
    if(!isDefined(var3.bombdefusetrig.origin)) {
      continue;
    }

    var4 = istrue(var3.bombplanted);
    var5 = distsquaredcheck(var0.origin, var1.origin, scripts\engine\utility::ter_op(var4, var3.bombdefusetrig.origin, var3.trigger.origin));

    if(var5) {
      if(scripts\mp\utility\game::getgametype() == "dd" && scripts\mp\utility\game::inovertime()) {
        if(var0.team == var3.ownerteam) {
          var0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var4, "defend", "assault"));
          var0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var4, "mode_x_defend", "mode_x_assault"));
        } else {
          var0 thread scripts\mp\rank::scoreeventpopup("assault");
          var0 thread scripts\mp\awards::givemidmatchaward("mode_x_assault");
        }

        continue;
      }

      if(var1.team == game["defenders"]) {
        var0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var4, "defend", "assault"));
        var0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var4, "mode_x_defend", "mode_x_assault"));
        continue;
      }

      var0 thread scripts\mp\rank::scoreeventpopup(scripts\engine\utility::ter_op(var4, "assault", "defend"));
      var0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var4, "mode_x_assault", "mode_x_defend"));
    }
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

function playerdelayedvo(var0, var1) {
  var2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming)) {
    var3 = 8;
  } else {
    var3 = 5;
  }

  var4 = var3 - var3;

  if(var4 > 0) {
    wait var4;
  }

  if(isDefined(var1)) {
    var1 scripts\mp\utility\dialog::leaderdialogonplayer(var2);
    return;
  }
}

function teamdelayedvo(var0, var1) {
  var2 = scripts\mp\utility\game::gettimepassed() / 1000;

  if(istrue(level.infilvotiming)) {
    var3 = 8;
  } else {
    var3 = 5;
  }

  var4 = var3 - var3;

  if(var4 > 0) {
    wait var4;
  }

  scripts\mp\utility\dialog::leaderdialog("bomb_achieve", var1, "bomb", var2);
}

function resetuiomnvargamemode() {
  self setclientomnvar("ui_carrying_bomb", 0);
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