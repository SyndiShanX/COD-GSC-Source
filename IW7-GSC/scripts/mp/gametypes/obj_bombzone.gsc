/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

bombzone_setupobjective(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  if(isDefined(level.curobj)) {
    level.curobj scripts\mp\gameobjects::deleteuseobject();
  }

  var_03 = level.objectives[param_00];
  if(isDefined(var_03.originalpos)) {
    var_03.origin = var_03.originalpos;
  } else {
    var_03.originalpos = var_03.origin;
  }

  var_04 = getEntArray(var_03.target, "targetname");
  if(level.gametype == "dd") {
    var_02 = var_03.script_label;
    var_05 = getent("dd_bombzone_clip" + var_02, "targetname");
    if(scripts\mp\utility::inovertime()) {
      if(var_02 == "_a" || var_02 == "_b") {
        var_03 delete();
        var_04[0] delete();
        var_05 delete();
        return;
      }

      var_01 = scripts\mp\gameobjects::createuseobject("neutral", var_03, var_04, (0, 0, 64));
      var_01 scripts\mp\gameobjects::allowuse("any");
      var_01.trigger.script_label = "_a";
    } else {
      if(var_02 == "_c") {
        var_03 delete();
        var_04[0] delete();
        var_05 delete();
        return;
      }

      if(level.mapname == "mp_desert" && var_02 == "_b") {
        var_03.origin = var_03.origin + (0, 0, 8);
        var_04[0].origin = var_04[0].origin + (0, 0, 8);
        var_05.origin = var_05.origin + (0, 0, 8);
      }
    }
  } else {
    var_03 = postshipmodifiedbombzones(var_04, var_03);
  }

  if(!isDefined(var_01)) {
    var_01 = scripts\mp\gameobjects::createuseobject(game["defenders"], var_03, var_04, (0, 0, 64));
    var_01 scripts\mp\gameobjects::allowuse("enemy");
  }

  var_01.id = "bomb_zone";
  var_01.trigger setuseprioritymax();
  var_01 scripts\mp\gameobjects::setusetime(level.planttime);
  var_01 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_01 scripts\mp\gameobjects::setusetext( & "MP_PLANTING_EXPLOSIVE");
  var_01 scripts\mp\gameobjects::setusehinttext( & "PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
  if(!level.multibomb) {
    var_01 scripts\mp\gameobjects::setkeyobject(level.sdbomb);
  }

  var_02 = var_01 scripts\mp\gameobjects::getlabel();
  if(level.gametype == "dd" && scripts\mp\utility::inovertime()) {
    var_02 = "_a";
    var_01 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_target" + var_02);
    var_01 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_target" + var_02);
    var_01 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_target" + var_02);
    var_01 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_target" + var_02);
  } else {
    var_01 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_02);
    var_01 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_02);
    var_01 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_target" + var_02);
    var_01 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_target" + var_02);
  }

  var_01.label = var_02;
  var_01 scripts\mp\gameobjects::setvisibleteam("any");
  var_01.onbeginuse = ::bombzone_onbeginuse;
  var_01.onenduse = ::bombzone_onenduse;
  var_01.onuse = ::bombzone_onuseplantobject;
  var_01.oncantuse = ::bombzone_oncantuse;
  var_01.useweapon = "briefcase_bomb_mp";
  var_01.bombplanted = 0;
  var_01.bombexploded = undefined;
  for(var_06 = 0; var_06 < var_04.size; var_06++) {
    if(isDefined(var_04[var_06].script_exploder)) {
      var_01.exploderindex = var_04[var_06].script_exploder;
      var_04[var_06] thread setupkillcament(var_01);
      break;
    }
  }

  var_01.bombdefusetrig = getent(var_04[0].target, "targetname");
  var_01.bombdefusetrig.origin = var_01.bombdefusetrig.origin + (0, 0, -10000);
  var_01.bombdefusetrig.label = var_02;
  var_01.noweapondropallowedtrigger = spawn("trigger_radius", var_01.trigger.origin, 0, 140, 100);
  return var_01;
}

setupkillcament(param_00) {
  var_01 = spawn("script_origin", self.origin);
  var_01.angles = self.angles;
  var_01 rotateyaw(-45, 0.05);
  wait(0.05);
  var_02 = undefined;
  var_03 = self.origin + (0, 0, 45);
  var_04 = self.origin + anglesToForward(var_01.angles) * 100 + (0, 0, 128);
  var_05 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var_06 = physics_createcontents(var_05);
  var_07 = scripts\common\trace::ray_trace(var_03, var_04, self, var_06);
  var_02 = var_07["position"];
  if(scripts\mp\utility::getmapname() == "mp_skyway" && param_00.label == "_b") {
    var_02 = (326, 595, 85);
  }

  self.killcament = spawn("script_model", var_02);
  self.killcament setscriptmoverkillcam("explosive");
  param_00.killcamentnum = self.killcament getentitynumber();
  var_01 delete();
}

allowedwhileplanting(param_00) {
  scripts\engine\utility::allow_melee(param_00);
  scripts\engine\utility::allow_jump(param_00);
  scripts\mp\utility::func_1C47(param_00);
  if(param_00) {
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");
  }

  scripts\engine\utility::allow_offhand_weapons(param_00);
}

bombzone_onbeginuse(param_00) {
  param_00 thread allowedwhileplanting(0);
  if(scripts\mp\gameobjects::isfriendlyteam(param_00.pers["team"])) {
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      param_00 setgametypevip(1);
    }

    param_00 scripts\mp\utility::notify_enemy_bots_bomb_used("defuse");
    param_00 notify("super_obj_drain");
    param_00.isdefusing = 1;
    setomnvar("ui_bomb_defuser", param_00 getentitynumber());
    scripts\mp\utility::setmlgannouncement(4, param_00.team, param_00 getentitynumber());
    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
    } else if(isDefined(level.ddbombmodel[self.label])) {
      level.ddbombmodel[self.label] hide();
    }

    param_00 thread startnpcbombusesound("briefcase_bomb_defuse_mp", "weap_suitcase_defuse_button");
    return;
  }

  var_01 = 2;
  if(self.label == "_a") {
    var_01 = 1;
  }

  scripts\mp\utility::setmlgannouncement(14, param_00.team, param_00 getentitynumber(), var_01);
  param_00 scripts\mp\utility::notify_enemy_bots_bomb_used("plant");
  param_00 notify("super_obj_drain");
  param_00.isplanting = 1;
  param_00.bombplantweapon = self.useweapon;
  param_00 thread startnpcbombusesound("briefcase_bomb_mp", "weap_suitcase_raise_button");
}

bombzone_onenduse(param_00, param_01, param_02) {
  setomnvar("ui_bomb_defuser", -1);
  if(!isDefined(param_01)) {
    return;
  }

  param_01 thread allowedwhileplanting(1);
  param_01.bombplantweapon = undefined;
  if(isalive(param_01)) {
    param_01.isdefusing = 0;
    param_01.isplanting = 0;
  }

  if(isplayer(param_01)) {
    param_01 setclientomnvar("ui_objective_state", 0);
    param_01.ui_bomb_planting_defusing = undefined;
  }

  if(scripts\mp\gameobjects::isfriendlyteam(param_01.pers["team"])) {
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      param_01 setgametypevip(0);
    }

    if(isDefined(level.sdbombmodel) && !param_02) {
      level.sdbombmodel show();
      return;
    }

    if(isDefined(level.ddbombmodel)) {
      if(isDefined(level.ddbombmodel[self.label]) && !param_02) {
        level.ddbombmodel[self.label] show();
        return;
      }

      return;
    }
  }
}

startnpcbombusesound(param_00, param_01) {
  self endon("death");
  self endon("stopNpcBombSound");
  if(scripts\mp\utility::isanymlgmatch() || scripts\mp\utility::istrue(level.silentplant) || scripts\mp\utility::_hasperk("specialty_engineer")) {
    return;
  }

  var_02 = "";
  while(var_02 != param_00) {
    self waittill("weapon_change", var_02);
  }

  self playsoundtoteam(param_01, self.team, self);
  var_03 = scripts\mp\utility::getotherteam(self.team);
  self playsoundtoteam(param_01, var_03);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

bombzone_oncantuse(param_00) {}

bombzone_onuseplantobject(param_00) {
  if((scripts\mp\utility::inovertime() && self.bombplanted == 0) || !scripts\mp\gameobjects::isfriendlyteam(param_00.pers["team"])) {
    level thread bombzone_onbombplanted(self, param_00);
    param_00 playSound("mp_bomb_plant");
    param_00 notify("bomb_planted");
    param_00 setclientomnvar("ui_objective_progress", 0.01);
    var_01 = 2;
    if(self.label == "_a") {
      var_01 = 1;
    }

    scripts\mp\utility::setmlgannouncement(3, param_00.team, param_00 getentitynumber(), var_01);
    param_00 scripts\mp\utility::incperstat("plants", 1);
    param_00 scripts\mp\persistence::statsetchild("round", "plants", param_00.pers["plants"]);
    param_00 scripts\mp\utility::setextrascore0(param_00.pers["plants"]);
    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[param_00.team])) {
      param_00 thread removebombcarrierclass();
    }

    if(scripts\mp\utility::inovertime()) {
      scripts\mp\utility::statusdialog("enemy_bomb_planted", level.otherteam[param_00.team], 1);
    } else {
      scripts\mp\utility::statusdialog("enemy_bomb" + self.label, level.otherteam[param_00.team], 1);
    }

    scripts\mp\utility::statusdialog("bomb_planted", param_00.team, 1);
    level thread scripts\mp\utility::teamplayercardsplash("callout_bombplanted", param_00);
    level.bombowner = param_00;
    param_00 thread scripts\mp\utility::giveunifiedpoints("plant");
    param_00.bombplantedtime = gettime();
    if(isplayer(param_00)) {
      param_00 thread scripts\mp\matchdata::loggameevent("plant", param_00.origin);
    }
  }
}

bombzone_onusedefuseobject(param_00) {
  var_01 = 0;
  param_00 setclientomnvar("ui_objective_progress", 0.01);
  foreach(var_03 in level.bombzones) {
    if(var_03.label == self.label) {
      param_00 notify("bomb_defused" + var_03.label);
      level thread bombdefused(var_03);
      break;
    }
  }

  scripts\mp\gameobjects::disableobject();
  if(!level.hardcoremode) {
    iprintln( & "MP_EXPLOSIVES_DEFUSED_BY", param_00);
  }

  scripts\mp\utility::statusdialog("enemy_bomb_defused", level.otherteam[param_00.team], 1);
  scripts\mp\utility::statusdialog("bomb_defused", param_00.team, 1);
  level thread scripts\mp\utility::teamplayercardsplash("callout_bombdefused", param_00);
  var_05 = "ninja_defuse";
  if(scripts\mp\utility::getgametypenumlives() >= 1) {
    var_06 = scripts\mp\utility::getpotentiallivingplayers();
    if(var_06.size == 1 && var_06[0] == param_00) {
      param_00 thread scripts\mp\awards::givemidmatchaward("mode_sd_last_defuse");
      var_01 = 1;
    }
  }

  if(!var_01) {
    param_00 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse");
  }

  param_00 scripts\mp\utility::incperstat("defuses", 1);
  param_00 scripts\mp\persistence::statsetchild("round", "defuses", param_00.pers["defuses"]);
  if(level.gametype != "sr") {
    param_00 scripts\mp\utility::setextrascore1(param_00.pers["defuses"]);
  }

  if(isplayer(param_00)) {
    param_00 thread scripts\mp\matchdata::loggameevent("defuse", param_00.origin);
  }
}

bombzone_onbombplanted(param_00, param_01) {
  level notify("bomb_planted", param_00);
  var_02 = param_01.team;
  level.bombdefused = 0;
  param_00.bombdefused = 0;
  if(level.gametype == "dd") {
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
  }

  level.bombplanted = 1;
  level.bombsplanted = level.bombsplanted + 1;
  level.timelimitoverride = 1;
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  if(param_00.label == "_a") {
    level.aplanted = 1;
  } else {
    level.bplanted = 1;
  }

  setbombtimeromnvars(param_01.team);
  level.destroyedobject = param_00;
  level.destroyedobject.bombplanted = 1;
  if(level.gametype != "dd") {
    param_01 setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level.defuseendtime);
  }

  param_00.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = param_00.visuals[0];
  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("none");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
    level.sdbomb scripts\mp\gameobjects::setdropped();
    level.sdbombmodel = level.sdbomb.visuals[0];
    level.sdbombmodel setasgametypeobjective();
  } else if(level.gametype == "dd") {
    level.ddbombmodel[param_00.label] = spawn("script_model", param_01.origin);
    level.ddbombmodel[param_00.label].angles = param_01.angles;
    level.ddbombmodel[param_00.label] setModel("suitcase_bomb_iw7_wm");
    level.ddbombmodel[param_00.label] setasgametypeobjective();
  } else {
    level.sdbombmodel = spawn("script_model", param_01.origin);
    level.sdbombmodel.angles = param_01.angles;
    level.sdbombmodel setModel("suitcase_bomb_iw7_wm");
    level.sdbombmodel setasgametypeobjective();
  }

  if(level.gametype != "dd") {
    param_00 scripts\mp\gameobjects::allowuse("none");
    param_00 scripts\mp\gameobjects::setvisibleteam("none");
  }

  var_03 = param_00 scripts\mp\gameobjects::getlabel();
  var_04 = [];
  if(level.gametype == "dd") {
    var_05 = param_00.trigger;
    var_05.origin = param_00.visuals[0].origin;
    var_06 = level.otherteam[param_01.team];
    var_07 = param_00;
  } else {
    var_05 = var_03.bombdefusetrig;
    var_07.origin = level.sdbombmodel.origin;
    var_06 = game["defenders"];
    var_07 = scripts\mp\gameobjects::createuseobject(var_07, var_06, var_05, (0, 0, 32));
  }

  var_07.id = "defuse_object";
  var_07.trigger setuseprioritymax();
  var_07 scripts\mp\gameobjects::allowuse("friendly");
  if(scripts\mp\utility::inovertime()) {
    param_00 scripts\mp\gameobjects::setownerteam(level.otherteam[param_01.team]);
  }

  var_07 scripts\mp\gameobjects::setusetime(level.defusetime);
  var_07 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_07 scripts\mp\gameobjects::setusetext( & "MP_DEFUSING_EXPLOSIVE");
  var_07 scripts\mp\gameobjects::setusehinttext( & "PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_07 scripts\mp\gameobjects::setvisibleteam("any");
  var_07 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defuse" + var_03);
  var_07 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_defend" + var_03);
  var_07 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defuse" + var_03);
  var_07 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_defend" + var_03);
  var_07.label = var_03;
  var_07.onbeginuse = ::bombzone_onbeginuse;
  var_07.onenduse = ::bombzone_onenduse;
  var_07.onuse = ::bombzone_onusedefuseobject;
  var_07.useweapon = "briefcase_bomb_mp";
  bombtimerwait(param_00);
  param_00.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  if(level.gameended) {
    return;
  } else if((level.gametype == "sd" && level.bombdefused) || level.gametype == "sr" && level.bombdefused) {
    var_07 scripts\mp\gameobjects::deleteuseobject();
    return;
  }

  if(level.gametype == "dd") {
    if(param_00.bombdefused) {
      param_00.bombplanted = 0;
      param_00 thread scripts\mp\gametypes\dd::func_2C59(param_01, "defused");
      param_00.onuse = ::bombzone_onuseplantobject;
      level.ddbombmodel[param_00.label] delete();
      return;
    } else {
      level.bombexploded = level.bombexploded + 1;
      param_00 thread scripts\mp\gametypes\dd::func_2C59(param_01, "explode", var_02);
    }
  } else {
    level.bombexploded = level.bombexploded + 1;
  }

  level notify("bomb_exploded" + param_00.label);
  param_01 thread scripts\mp\awards::givemidmatchaward("mode_sd_detonate");
  if(isDefined(level.sd_onbombtimerend)) {
    level thread[[level.sd_onbombtimerend]]();
  }

  if(level.gametype == "dd") {
    var_08 = level.ddbombmodel[param_00.label].origin;
    level.ddbombmodel[param_00.label] delete();
  } else {
    var_08 = level.sdbombmodel.origin;
    level.sdbombmodel delete();
  }

  if(isDefined(param_01)) {
    param_00.visuals[0] radiusdamage(var_08, 512, 200, 20, param_01, "MOD_EXPLOSIVE", "bomb_site_mp");
    param_01 scripts\mp\utility::incperstat("destructions", 1);
    param_01 scripts\mp\persistence::statsetchild("round", "destructions", param_01.pers["destructions"]);
  } else {
    param_00.visuals[0] radiusdamage(var_08, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  var_09 = randomfloat(360);
  if(isDefined(param_00.trigger.effect)) {
    var_0A = param_00.trigger.effect;
  } else {
    var_0A = "bomb_explosion";
  }

  var_0B = var_08 + (0, 0, 50);
  var_0C = spawnfx(level._effect[var_0A], var_0B, (0, 0, 1), (cos(var_09), sin(var_09), 0));
  triggerfx(var_0C);
  physicsexplosionsphere(var_0B, 200, 100, 3);
  scripts\mp\shellshock::func_13B9("grenade_rumble", var_08);
  scripts\mp\shellshock::_earthquake(0.75, 2, var_08, 2000);
  thread scripts\mp\utility::playsoundinspace("exp_suitcase_bomb_main", var_08);
  if(isDefined(param_00.exploderindex)) {
    scripts\engine\utility::exploder(param_00.exploderindex);
  }

  var_07 scripts\mp\gameobjects::disableobject();
  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.label, param_01, game["attackers"], undefined);
  }
}

initobjectivecam(param_00) {
  var_01 = undefined;
  var_02 = getEntArray("sd_bombcam_start", "targetname");
  foreach(var_04 in var_02) {
    if(var_04.script_label == param_00.label) {
      var_01 = var_04;
      break;
    }
  }

  var_06 = [];
  if(isDefined(var_01) && isDefined(var_01.target)) {
    var_07 = getent(var_01.target, "targetname");
    while(isDefined(var_07)) {
      var_06[var_06.size] = var_07;
      if(isDefined(var_07.target)) {
        var_07 = getent(var_07.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(isDefined(var_01) && var_06.size) {
    var_08 = spawn("script_model", var_01.origin);
    var_08.origin = var_01.origin;
    var_08.angles = var_01.angles;
    var_08.path = var_06;
    var_08 setModel("tag_origin");
    var_08 hide();
    return var_08;
  }

  return undefined;
}

runobjectivecam() {
  level notify("objective_cam");
  foreach(var_01 in level.players) {
    if(!isai(var_01)) {
      var_01 scripts\mp\utility::freezecontrolswrapper(1);
      var_01 visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait(0.5);
  foreach(var_01 in level.players) {
    if(!isai(var_01)) {
      if(isDefined(var_01.disabledoffhandweapons)) {
        var_01 scripts\mp\utility::setusingremote("objective_cam");
        var_01 scripts\engine\utility::allow_weapon(0);
      }

      var_01 playerlinkweaponviewtodelta(self, "tag_player", 1, 180, 180, 180, 180, 1);
      var_01 scripts\mp\utility::freezecontrolswrapper(1);
      var_01 setplayerangles(self.angles);
      var_01 visionsetnakedforplayer("", 0.5);
    }
  }

  for(var_05 = 0; var_05 < self.path.size; var_05++) {
    var_06 = 0;
    if(var_05 == 0) {
      var_06 = 5 / self.path.size / 2;
    }

    var_07 = 0;
    if(var_05 == self.path.size - 1) {
      var_07 = 5 / self.path.size / 2;
    }

    self moveto(self.path[var_05].origin, 5 / self.path.size, var_06, var_07);
    self rotateto(self.path[var_05].angles, 5 / self.path.size, var_06, var_07);
    wait(5 / self.path.size);
  }
}

bombtimerwait(param_00) {
  level endon("game_ended");
  level endon("bomb_defused" + param_00.label);
  var_01 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + param_00.label, var_01);
  level thread handlehostmigration(var_01, param_00);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(param_00, param_01) {
  level endon("game_ended");
  level endon("bomb_defused" + param_01.label);
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + param_01.label, 0);
  var_02 = scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_02 > 0) {
    setomnvar("ui_bomb_timer_endtime" + param_01.label, param_00 + var_02);
  }
}

bombdefused(param_00) {
  if(level.gametype != "dd") {
    level.bombdefused = 1;
  }

  param_00.bombdefused = 1;
  setbombtimeromnvars();
  level notify("bomb_defused" + param_00.label);
  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.label, undefined, game["defenders"], undefined);
  }
}

updatebombplantedomnvar(param_00) {
  if(isDefined(param_00)) {
    if(param_00 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  if(level.aplanted) {
    setomnvar("ui_bomb_planted_a", 1);
  } else {
    setomnvar("ui_bomb_planted_a", 0);
  }

  if(level.bplanted) {
    setomnvar("ui_bomb_planted_b", 1);
    return;
  }

  setomnvar("ui_bomb_planted_b", 0);
}

setbombtimeromnvars(param_00) {
  updatebombplantedomnvar(param_00);
}

bombzone_setupbombcase(param_00) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_01 = getent(param_00 + "_pickup_trig", "targetname");
  if(!isDefined(var_01)) {
    scripts\engine\utility::error("No " + param_00 + "_pickup_trig trigger found in map.");
    return;
  }

  var_01 = postshipadjustbombtriggerspawn(var_01);
  var_02[0] = getent(param_00, "targetname");
  if(!isDefined(var_02[0])) {
    scripts\engine\utility::error("No " + param_00 + " script_model found in map.");
    return;
  }

  var_02[0] = postshipadjustbombcasespawn(var_02[0]);
  var_02[0] setModel("suitcase_bomb_iw7_wm");
  if(!level.multibomb) {
    level.sdbomb = scripts\mp\gameobjects::createcarryobject(game["attackers"], var_01, var_02, (0, 0, 32));
    level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");
    level.sdbomb scripts\mp\gameobjects::set2dicon("friendly", "waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::set3dicon("friendly", "waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
    level thread bombsitewatcher();
    level.bombrespawnpoint = level.sdbomb.visuals[0].origin;
    level.bombrespawnangles = level.sdbomb.visuals[0].angles;
    level.sdbomb.visualgroundoffset = (0, 0, 2);
    return;
  }

  var_01 delete();
  var_02[0] delete();
}

movebombcase(param_00, param_01) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = param_00;
    level.sdbomb.visuals[0].origin = param_00;
    level.sdbomb.visuals[0].angles = param_01;
    level.sdbomb.visuals[0] show();
    level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");
    level.sdbomb scripts\mp\gameobjects::set2dicon("friendly", "waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::set3dicon("friendly", "waypoint_bomb");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = ::onpickup;
    level.sdbomb.ondrop = ::ondrop;
  }
}

bombsitewatcher() {
  level endon("game_ended");
  for(;;) {
    level waittill("bomb_pickup");
    foreach(var_01 in level.bombzones) {
      var_01.trigger enableplayeruse(level.sdbomb.carrier);
    }

    wait(0.05);
  }
}

onpickup(param_00) {
  param_00.isbombcarrier = 1;
  if(isplayer(param_00)) {
    param_00 thread scripts\mp\matchdata::loggameevent("pickup", param_00.origin);
    scripts\mp\utility::setmlgannouncement(15, param_00.team, param_00 getentitynumber());
  }

  param_00 setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", param_00 getentitynumber());
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_escort");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_escort");
  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[param_00.team])) {
    param_00 thread applybombcarrierclass();
  }

  if(!level.bombdefused) {
    scripts\mp\utility::teamplayercardsplash("callout_bombtaken", param_00, param_00.team);
    scripts\mp\utility::leaderdialog("bomb_taken", param_00.pers["team"]);
  }

  scripts\mp\utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    param_00 setgametypevip(1);
  }

  level notify("bomb_pickup");
}

ondrop(param_00) {
  level notify("bomb_dropped");
  setomnvar("ui_bomb_carrier", -1);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    if(isDefined(param_00)) {
      param_00 setgametypevip(0);
    }
  }

  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_bomb");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_bomb");
  scripts\mp\utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0) {
    thread waitforbombreset(level.bombresettimer);
  }
}

waitforbombreset(param_00) {
  level endon("game_ended");
  level endon("bomb_pickup");
  wait(param_00);
  playFX(loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death"), self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

enablemultibombui() {
  foreach(var_01 in level.players) {
    if(!isai(var_01)) {
      var_01 setclientomnvar("ui_carrying_bomb", var_01.pers["team"] == game["attackers"]);
    }
  }
}

respawnbombcase() {
  level endon("game_ended");
  wait(5);
  if(level.multibomb) {
    enablemultibombui();
    return;
  }

  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

advancebombcase() {
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

applybombcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  while(!self isonground()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
  }

  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00.playerspawnpos = self.origin;
  var_00.notti = 1;
  self.setspawnpoint = var_00;
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

removebombcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }

  while(self ismantling()) {
    wait(0.05);
  }

  while(!self isonground()) {
    wait(0.05);
  }

  if(scripts\mp\utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    wait(0.05);
  }

  self.pers["gamemodeLoadout"] = undefined;
  if(isDefined(self.setspawnpoint)) {
    scripts\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
  }

  var_00 = spawn("script_model", self.origin);
  var_00.angles = self.angles;
  var_00.playerspawnpos = self.origin;
  var_00.notti = 1;
  self.setspawnpoint = var_00;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

bombzone_awardgenericbombzonemedals(param_00, param_01) {
  foreach(var_03 in level.bombzones) {
    if(!isDefined(var_03.bombdefusetrig.origin)) {
      continue;
    }

    var_04 = scripts\mp\utility::istrue(var_03.bombplanted);
    var_05 = distsquaredcheck(param_00.origin, param_01.origin, scripts\engine\utility::ter_op(var_04, var_03.bombdefusetrig.origin, var_03.trigger.origin));
    if(var_05) {
      if(param_01.team == game["defenders"]) {
        param_00 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_04, "mode_x_defend", "mode_x_assault"));
        continue;
      }

      param_00 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_04, "mode_x_assault", "mode_x_defend"));
    }
  }
}

distsquaredcheck(param_00, param_01, param_02) {
  var_03 = distancesquared(param_02, param_00);
  var_04 = distancesquared(param_02, param_01);
  if(var_03 < 90000 || var_04 < 90000) {
    return 1;
  }

  return 0;
}

postshipmodifiedbombzones(param_00, param_01) {
  var_02 = param_01.origin;
  var_03 = modifiedbombzones(param_01, var_02, param_00);
  return var_03;
}

modifiedbombzones(param_00, param_01, param_02) {
  if(level.mapname == "mp_desert" && param_00.script_label == "_b") {
    param_02[0].origin = (-928, 552, 352);
    param_02[0].angles = (0, 0, 0);
    param_00.originalpos = (-928, 552, 361);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 35), (0, 90, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_metropolis" && param_00.script_label == "_b") {
    param_02[0].origin = (-1570, -785, -64);
    param_02[0].angles = (0, 90, 0);
    param_00.originalpos = (-1570, -785, -64);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 0, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 180, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_fallen" && param_00.script_label == "_a") {
    param_02[0].origin = (408, -70, 760);
    param_02[0].angles = (0, 0, 0);
    param_00.originalpos = (408, -70, 760);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 90, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_fallen" && param_00.script_label == "_b") {
    param_02[0].origin = (-270, 2387, 927);
    param_02[0].angles = (0, 0, 0);
    param_00.originalpos = (-270, 2387, 927);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_riot" && param_00.script_label == "_a") {
    param_02[0].origin = (514, 669, 250);
    param_02[0].angles = (13, 90, 1);
    param_00.originalpos = (514, 669, 250);
    param_00.origin = param_00.originalpos;
    param_00.angles = (13, 90, 1);
    setmodifiedbombzonescollision((0, 5, 30), (13, 90, 1), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_proto" && param_00.script_label == "_a") {
    param_02[0].origin = (-90, 1825, 480);
    param_02[0].angles = (0, 0, 0);
    param_00.originalpos = (-90, 1825, 480);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_divide" && param_00.script_label == "_b") {
    param_02[0].origin = (-510, -560, 585);
    param_02[0].angles = (0, 180, 0);
    param_00.originalpos = (-527, -560, 585);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 135, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, -45, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_parkour" && param_00.script_label == "_a") {
    param_02[0].origin = (-1602, 3, 184);
    param_02[0].angles = (0, 90, 0);
    param_00.originalpos = (-1602, 3, 186);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 0, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 180, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  if(level.mapname == "mp_parkour" && param_00.script_label == "_b") {
    param_02[0].origin = (489, -1408, 249);
    param_02[0].angles = (0, 90, 0);
    param_00.originalpos = (489, -1408, 249);
    param_00.origin = param_00.originalpos;
    param_00.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), param_01, param_02);
    setexplodermodel(param_01, param_02);
    return param_00;
  }

  return param_00;
}

setmodifiedbombzonescollision(param_00, param_01, param_02, param_03) {
  var_04 = getEntArray("script_brushmodel", "classname");
  foreach(var_06 in var_04) {
    if(isDefined(var_06.script_gameobjectname) && var_06.script_gameobjectname == "bombzone") {
      if(distance(var_06.origin, param_02) < 100) {
        var_07 = spawn("script_model", param_03[0].origin + param_00);
        var_07.angles = param_01;
        var_07 clonebrushmodeltoscriptmodel(var_06);
        var_07 disconnectpaths();
        var_06 delete();
        break;
      }
    }
  }
}

setexplodermodel(param_00, param_01) {
  var_02 = getEntArray("script_model", "classname");
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(isDefined(var_02[var_03].script_exploder)) {
      if(isDefined(var_02[var_03].var_336) && var_02[var_03].var_336 == "exploder" && distance(var_02[var_03].origin, param_00) < 100) {
        var_02[var_03].origin = param_01[0].origin;
        var_02[var_03].angles = param_01[0].angles;
      }
    }
  }
}

postshipadjustbombcasespawn(param_00) {
  if(level.mapname == "mp_fallen") {
    param_00.origin = (2655, 1260, 930);
    return param_00;
  }

  if(level.mapname == "mp_divide") {
    param_00.origin = param_00.origin - (0, 0, 2);
    return param_00;
  }

  if(level.mapname == "mp_parkour") {
    param_00.origin = (-56, 3139, 170);
    return param_00;
  }

  if(level.mapname == "mp_quarry") {
    param_00.origin = (-2067, 1214, 242);
    return param_00;
  }

  if(level.mapname == "mp_frontier") {
    param_00.origin = param_00.origin + (0, 0, 1);
    return param_00;
  }

  if(level.mapname == "mp_desert") {
    param_00.origin = param_00.origin + (0, 0, 1);
    return param_00;
  }

  if(level.mapname == "mp_metropolis") {
    param_00.origin = param_00.origin + (0, 0, 2);
    return param_00;
  }

  if(level.mapname == "mp_proto") {
    param_00.origin = (2349, 228, 530);
    return param_00;
  }

  if(level.mapname == "mp_rivet") {
    param_00.origin = param_00.origin + (0, 0, 1);
    return param_00;
  }

  if(level.mapname == "mp_breakneck") {
    param_00.origin = param_00.origin + (0, 0, 2);
    return param_00;
  }

  if(level.mapname == "mp_dome_iw") {
    param_00.origin = param_00.origin + (0, 0, 2);
    return param_00;
  }

  if(level.mapname == "mp_skyway") {
    param_00.origin = param_00.origin + (0, 0, 2);
    return param_00;
  }

  return param_00;
}

postshipadjustbombtriggerspawn(param_00) {
  if(level.mapname == "mp_proto") {
    param_00.origin = (2349, 228, 530);
    return param_00;
  }

  if(level.mapname == "mp_fallen") {
    param_00.origin = (2655, 1260, 930);
    return param_00;
  }

  if(level.mapname == "mp_quarry") {
    param_00.origin = (-2067, 1214, 242);
    return param_00;
  }

  if(level.mapname == "mp_parkour") {
    param_00.origin = (-56, 3139, 170);
    return param_00;
  }

  return param_00;
}