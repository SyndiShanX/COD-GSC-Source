/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

bombzone_setupobjective(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  if(isDefined(level.curobj)) {
    level.curobj scripts\mp\gameobjects::deleteuseobject();
  }

  var_3 = level.objectives[var_0];
  if(isDefined(var_3.originalpos)) {
    var_3.origin = var_3.originalpos;
  } else {
    var_3.originalpos = var_3.origin;
  }

  var_4 = getEntArray(var_3.target, "targetname");
  if(level.gametype == "dd") {
    var_2 = var_3.script_label;
    var_5 = getent("dd_bombzone_clip" + var_2, "targetname");
    if(scripts\mp\utility::inovertime()) {
      if(var_2 == "_a" || var_2 == "_b") {
        var_3 delete();
        var_4[0] delete();
        var_5 delete();
        return;
      }

      var_1 = scripts\mp\gameobjects::createuseobject("neutral", var_3, var_4, (0, 0, 64));
      var_1 scripts\mp\gameobjects::allowuse("any");
      var_1.trigger.script_label = "_a";
    } else {
      if(var_2 == "_c") {
        var_3 delete();
        var_4[0] delete();
        var_5 delete();
        return;
      }

      if(level.mapname == "mp_desert" && var_2 == "_b") {
        var_3.origin = var_3.origin + (0, 0, 8);
        var_4[0].origin = var_4[0].origin + (0, 0, 8);
        var_5.origin = var_5.origin + (0, 0, 8);
      }
    }
  } else {
    var_3 = postshipmodifiedbombzones(var_4, var_3);
  }

  if(!isDefined(var_1)) {
    var_1 = scripts\mp\gameobjects::createuseobject(game["defenders"], var_3, var_4, (0, 0, 64));
    var_1 scripts\mp\gameobjects::allowuse("enemy");
  }

  var_1.id = "bomb_zone";
  var_1.trigger setuseprioritymax();
  var_1 scripts\mp\gameobjects::setusetime(level.planttime);
  var_1 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_1 scripts\mp\gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
  var_1 scripts\mp\gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
  if(!level.multibomb) {
    var_1 scripts\mp\gameobjects::setkeyobject(level.sdbomb);
  }

  var_2 = var_1 scripts\mp\gameobjects::getlabel();
  if(level.gametype == "dd" && scripts\mp\utility::inovertime()) {
    var_2 = "_a";
    var_1 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_target" + var_2);
    var_1 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_target" + var_2);
    var_1 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_target" + var_2);
    var_1 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_target" + var_2);
  } else {
    var_1 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defend" + var_2);
    var_1 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defend" + var_2);
    var_1 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_target" + var_2);
    var_1 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_target" + var_2);
  }

  var_1.label = var_2;
  var_1 scripts\mp\gameobjects::setvisibleteam("any");
  var_1.onbeginuse = ::bombzone_onbeginuse;
  var_1.onenduse = ::bombzone_onenduse;
  var_1.onuse = ::bombzone_onuseplantobject;
  var_1.oncantuse = ::bombzone_oncantuse;
  var_1.useweapon = "briefcase_bomb_mp";
  var_1.bombplanted = 0;
  var_1.bombexploded = undefined;
  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    if(isDefined(var_4[var_6].script_exploder)) {
      var_1.exploderindex = var_4[var_6].script_exploder;
      var_4[var_6] thread setupkillcament(var_1);
      break;
    }
  }

  var_1.bombdefusetrig = getent(var_4[0].target, "targetname");
  var_1.bombdefusetrig.origin = var_1.bombdefusetrig.origin + (0, 0, -10000);
  var_1.bombdefusetrig.label = var_2;
  var_1.noweapondropallowedtrigger = spawn("trigger_radius", var_1.trigger.origin, 0, 140, 100);
  return var_1;
}

setupkillcament(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateyaw(-45, 0.05);
  wait(0.05);
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\common\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["position"];
  if(scripts\mp\utility::getmapname() == "mp_skyway" && var_0.label == "_b") {
    var_2 = (326, 595, 85);
  }

  self.killcament = spawn("script_model", var_2);
  self.killcament setscriptmoverkillcam("explosive");
  var_0.killcamentnum = self.killcament getentitynumber();
  var_1 delete();
}

allowedwhileplanting(var_0) {
  scripts\engine\utility::allow_melee(var_0);
  scripts\engine\utility::allow_jump(var_0);
  scripts\mp\utility::func_1C47(var_0);
  if(var_0) {
    scripts\engine\utility::waittill_any_timeout_1(0.8, "bomb_allow_offhands");
  }

  scripts\engine\utility::allow_offhand_weapons(var_0);
}

bombzone_onbeginuse(var_0) {
  var_0 thread allowedwhileplanting(0);
  if(scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_0 setgametypevip(1);
    }

    var_0 scripts\mp\utility::notify_enemy_bots_bomb_used("defuse");
    var_0 notify("super_obj_drain");
    var_0.isdefusing = 1;
    setomnvar("ui_bomb_defuser", var_0 getentitynumber());
    scripts\mp\utility::setmlgannouncement(4, var_0.team, var_0 getentitynumber());
    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
    } else if(isDefined(level.ddbombmodel[self.label])) {
      level.ddbombmodel[self.label] hide();
    }

    var_0 thread startnpcbombusesound("briefcase_bomb_defuse_mp", "weap_suitcase_defuse_button");
    return;
  }

  var_1 = 2;
  if(self.label == "_a") {
    var_1 = 1;
  }

  scripts\mp\utility::setmlgannouncement(14, var_0.team, var_0 getentitynumber(), var_1);
  var_0 scripts\mp\utility::notify_enemy_bots_bomb_used("plant");
  var_0 notify("super_obj_drain");
  var_0.isplanting = 1;
  var_0.bombplantweapon = self.useweapon;
  var_0 thread startnpcbombusesound("briefcase_bomb_mp", "weap_suitcase_raise_button");
}

bombzone_onenduse(var_0, var_1, var_2) {
  setomnvar("ui_bomb_defuser", -1);
  if(!isDefined(var_1)) {
    return;
  }

  var_1 thread allowedwhileplanting(1);
  var_1.bombplantweapon = undefined;
  if(isalive(var_1)) {
    var_1.isdefusing = 0;
    var_1.isplanting = 0;
  }

  if(isplayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1.ui_bomb_planting_defusing = undefined;
  }

  if(scripts\mp\gameobjects::isfriendlyteam(var_1.pers["team"])) {
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      var_1 setgametypevip(0);
    }

    if(isDefined(level.sdbombmodel) && !var_2) {
      level.sdbombmodel show();
      return;
    }

    if(isDefined(level.ddbombmodel)) {
      if(isDefined(level.ddbombmodel[self.label]) && !var_2) {
        level.ddbombmodel[self.label] show();
        return;
      }

      return;
    }
  }
}

startnpcbombusesound(var_0, var_1) {
  self endon("death");
  self endon("stopNpcBombSound");
  if(scripts\mp\utility::isanymlgmatch() || scripts\mp\utility::istrue(level.silentplant) || scripts\mp\utility::_hasperk("specialty_engineer")) {
    return;
  }

  var_2 = "";
  while(var_2 != var_0) {
    self waittill("weapon_change", var_2);
  }

  self playsoundtoteam(var_1, self.team, self);
  var_3 = scripts\mp\utility::getotherteam(self.team);
  self playsoundtoteam(var_1, var_3);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

bombzone_oncantuse(var_0) {}

bombzone_onuseplantobject(var_0) {
  if((scripts\mp\utility::inovertime() && self.bombplanted == 0) || !scripts\mp\gameobjects::isfriendlyteam(var_0.pers["team"])) {
    level thread bombzone_onbombplanted(self, var_0);
    var_0 playSound("mp_bomb_plant");
    var_0 notify("bomb_planted");
    var_0 setclientomnvar("ui_objective_progress", 0.01);
    var_1 = 2;
    if(self.label == "_a") {
      var_1 = 1;
    }

    scripts\mp\utility::setmlgannouncement(3, var_0.team, var_0 getentitynumber(), var_1);
    var_0 scripts\mp\utility::incperstat("plants", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "plants", var_0.pers["plants"]);
    var_0 scripts\mp\utility::setextrascore0(var_0.pers["plants"]);
    if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
      var_0 thread removebombcarrierclass();
    }

    if(scripts\mp\utility::inovertime()) {
      scripts\mp\utility::statusdialog("enemy_bomb_planted", level.otherteam[var_0.team], 1);
    } else {
      scripts\mp\utility::statusdialog("enemy_bomb" + self.label, level.otherteam[var_0.team], 1);
    }

    scripts\mp\utility::statusdialog("bomb_planted", var_0.team, 1);
    level thread scripts\mp\utility::teamplayercardsplash("callout_bombplanted", var_0);
    level.bombowner = var_0;
    var_0 thread scripts\mp\utility::giveunifiedpoints("plant");
    var_0.bombplantedtime = gettime();
    if(isplayer(var_0)) {
      var_0 thread scripts\mp\matchdata::loggameevent("plant", var_0.origin);
    }
  }
}

bombzone_onusedefuseobject(var_0) {
  var_1 = 0;
  var_0 setclientomnvar("ui_objective_progress", 0.01);
  foreach(var_3 in level.bombzones) {
    if(var_3.label == self.label) {
      var_0 notify("bomb_defused" + var_3.label);
      level thread bombdefused(var_3);
      break;
    }
  }

  scripts\mp\gameobjects::disableobject();
  if(!level.hardcoremode) {
    iprintln(&"MP_EXPLOSIVES_DEFUSED_BY", var_0);
  }

  scripts\mp\utility::statusdialog("enemy_bomb_defused", level.otherteam[var_0.team], 1);
  scripts\mp\utility::statusdialog("bomb_defused", var_0.team, 1);
  level thread scripts\mp\utility::teamplayercardsplash("callout_bombdefused", var_0);
  var_5 = "ninja_defuse";
  if(scripts\mp\utility::getgametypenumlives() >= 1) {
    var_6 = scripts\mp\utility::getpotentiallivingplayers();
    if(var_6.size == 1 && var_6[0] == var_0) {
      var_0 thread scripts\mp\awards::givemidmatchaward("mode_sd_last_defuse");
      var_1 = 1;
    }
  }

  if(!var_1) {
    var_0 thread scripts\mp\awards::givemidmatchaward("mode_sd_defuse");
  }

  var_0 scripts\mp\utility::incperstat("defuses", 1);
  var_0 scripts\mp\persistence::statsetchild("round", "defuses", var_0.pers["defuses"]);
  if(level.gametype != "sr") {
    var_0 scripts\mp\utility::setextrascore1(var_0.pers["defuses"]);
  }

  if(isplayer(var_0)) {
    var_0 thread scripts\mp\matchdata::loggameevent("defuse", var_0.origin);
  }
}

bombzone_onbombplanted(var_0, var_1) {
  level notify("bomb_planted", var_0);
  var_2 = var_1.team;
  level.bombdefused = 0;
  var_0.bombdefused = 0;
  if(level.gametype == "dd") {
    scripts\mp\gamelogic::pausetimer();
    level.timepausestart = gettime();
  }

  level.bombplanted = 1;
  level.bombsplanted = level.bombsplanted + 1;
  level.timelimitoverride = 1;
  level.defuseendtime = int(gettime() + level.bombtimer * 1000);
  if(var_0.label == "_a") {
    level.aplanted = 1;
  } else {
    level.bplanted = 1;
  }

  setbombtimeromnvars(var_1.team);
  level.destroyedobject = var_0;
  level.destroyedobject.bombplanted = 1;
  if(level.gametype != "dd") {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level.defuseendtime);
  }

  var_0.visuals[0] thread scripts\mp\gamelogic::playtickingsound();
  level.tickingobject = var_0.visuals[0];
  if(!level.multibomb) {
    level.sdbomb scripts\mp\gameobjects::allowcarry("none");
    level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
    level.sdbomb scripts\mp\gameobjects::setdropped();
    level.sdbombmodel = level.sdbomb.visuals[0];
    level.sdbombmodel setasgametypeobjective();
  } else if(level.gametype == "dd") {
    level.ddbombmodel[var_0.label] = spawn("script_model", var_1.origin);
    level.ddbombmodel[var_0.label].angles = var_1.angles;
    level.ddbombmodel[var_0.label] setModel("suitcase_bomb_iw7_wm");
    level.ddbombmodel[var_0.label] setasgametypeobjective();
  } else {
    level.sdbombmodel = spawn("script_model", var_1.origin);
    level.sdbombmodel.angles = var_1.angles;
    level.sdbombmodel setModel("suitcase_bomb_iw7_wm");
    level.sdbombmodel setasgametypeobjective();
  }

  if(level.gametype != "dd") {
    var_0 scripts\mp\gameobjects::allowuse("none");
    var_0 scripts\mp\gameobjects::setvisibleteam("none");
  }

  var_3 = var_0 scripts\mp\gameobjects::getlabel();
  var_4 = [];
  if(level.gametype == "dd") {
    var_5 = var_0.trigger;
    var_5.origin = var_0.visuals[0].origin;
    var_6 = level.otherteam[var_1.team];
    var_7 = var_0;
  } else {
    var_5 = var_3.bombdefusetrig;
    var_7.origin = level.sdbombmodel.origin;
    var_6 = game["defenders"];
    var_7 = scripts\mp\gameobjects::createuseobject(var_7, var_6, var_5, (0, 0, 32));
  }

  var_7.id = "defuse_object";
  var_7.trigger setuseprioritymax();
  var_7 scripts\mp\gameobjects::allowuse("friendly");
  if(scripts\mp\utility::inovertime()) {
    var_0 scripts\mp\gameobjects::setownerteam(level.otherteam[var_1.team]);
  }

  var_7 scripts\mp\gameobjects::setusetime(level.defusetime);
  var_7 scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
  var_7 scripts\mp\gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
  var_7 scripts\mp\gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  var_7 scripts\mp\gameobjects::setvisibleteam("any");
  var_7 scripts\mp\gameobjects::set2dicon("friendly", "waypoint_defuse" + var_3);
  var_7 scripts\mp\gameobjects::set2dicon("enemy", "waypoint_defend" + var_3);
  var_7 scripts\mp\gameobjects::set3dicon("friendly", "waypoint_defuse" + var_3);
  var_7 scripts\mp\gameobjects::set3dicon("enemy", "waypoint_defend" + var_3);
  var_7.label = var_3;
  var_7.onbeginuse = ::bombzone_onbeginuse;
  var_7.onenduse = ::bombzone_onenduse;
  var_7.onuse = ::bombzone_onusedefuseobject;
  var_7.useweapon = "briefcase_bomb_mp";
  bombtimerwait(var_0);
  var_0.visuals[0] scripts\mp\gamelogic::stoptickingsound();
  if(level.gameended) {
    return;
  } else if((level.gametype == "sd" && level.bombdefused) || level.gametype == "sr" && level.bombdefused) {
    var_7 scripts\mp\gameobjects::deleteuseobject();
    return;
  }

  if(level.gametype == "dd") {
    if(var_0.bombdefused) {
      var_0.bombplanted = 0;
      var_0 thread scripts\mp\gametypes\dd::func_2C59(var_1, "defused");
      var_0.onuse = ::bombzone_onuseplantobject;
      level.ddbombmodel[var_0.label] delete();
      return;
    } else {
      level.bombexploded = level.bombexploded + 1;
      var_0 thread scripts\mp\gametypes\dd::func_2C59(var_1, "explode", var_2);
    }
  } else {
    level.bombexploded = level.bombexploded + 1;
  }

  level notify("bomb_exploded" + var_0.label);
  var_1 thread scripts\mp\awards::givemidmatchaward("mode_sd_detonate");
  if(isDefined(level.sd_onbombtimerend)) {
    level thread[[level.sd_onbombtimerend]]();
  }

  if(level.gametype == "dd") {
    var_8 = level.ddbombmodel[var_0.label].origin;
    level.ddbombmodel[var_0.label] delete();
  } else {
    var_8 = level.sdbombmodel.origin;
    level.sdbombmodel delete();
  }

  if(isDefined(var_1)) {
    var_0.visuals[0] radiusdamage(var_8, 512, 200, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    var_1 scripts\mp\utility::incperstat("destructions", 1);
    var_1 scripts\mp\persistence::statsetchild("round", "destructions", var_1.pers["destructions"]);
  } else {
    var_0.visuals[0] radiusdamage(var_8, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  var_9 = randomfloat(360);
  if(isDefined(var_0.trigger.effect)) {
    var_0A = var_0.trigger.effect;
  } else {
    var_0A = "bomb_explosion";
  }

  var_0B = var_8 + (0, 0, 50);
  var_0C = spawnfx(level._effect[var_0A], var_0B, (0, 0, 1), (cos(var_9), sin(var_9), 0));
  triggerfx(var_0C);
  physicsexplosionsphere(var_0B, 200, 100, 3);
  scripts\mp\shellshock::func_13B9("grenade_rumble", var_8);
  scripts\mp\shellshock::_earthquake(0.75, 2, var_8, 2000);
  thread scripts\mp\utility::playsoundinspace("exp_suitcase_bomb_main", var_8);
  if(isDefined(var_0.exploderindex)) {
    scripts\engine\utility::exploder(var_0.exploderindex);
  }

  var_7 scripts\mp\gameobjects::disableobject();
  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.label, var_1, game["attackers"], undefined);
  }
}

initobjectivecam(var_0) {
  var_1 = undefined;
  var_2 = getEntArray("sd_bombcam_start", "targetname");
  foreach(var_4 in var_2) {
    if(var_4.script_label == var_0.label) {
      var_1 = var_4;
      break;
    }
  }

  var_6 = [];
  if(isDefined(var_1) && isDefined(var_1.target)) {
    var_7 = getent(var_1.target, "targetname");
    while(isDefined(var_7)) {
      var_6[var_6.size] = var_7;
      if(isDefined(var_7.target)) {
        var_7 = getent(var_7.target, "targetname");
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

runobjectivecam() {
  level notify("objective_cam");
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility::freezecontrolswrapper(1);
      var_1 visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait(0.5);
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      if(isDefined(var_1.disabledoffhandweapons)) {
        var_1 scripts\mp\utility::setusingremote("objective_cam");
        var_1 scripts\engine\utility::allow_weapon(0);
      }

      var_1 playerlinkweaponviewtodelta(self, "tag_player", 1, 180, 180, 180, 180, 1);
      var_1 scripts\mp\utility::freezecontrolswrapper(1);
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

    self moveto(self.path[var_5].origin, 5 / self.path.size, var_6, var_7);
    self rotateto(self.path[var_5].angles, 5 / self.path.size, var_6, var_7);
    wait(5 / self.path.size);
  }
}

bombtimerwait(var_0) {
  level endon("game_ended");
  level endon("bomb_defused" + var_0.label);
  var_1 = int(level.bombtimer * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + var_0.label, var_1);
  level thread handlehostmigration(var_1, var_0);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

handlehostmigration(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused" + var_1.label);
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + var_1.label, 0);
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();
  if(var_2 > 0) {
    setomnvar("ui_bomb_timer_endtime" + var_1.label, var_0 + var_2);
  }
}

bombdefused(var_0) {
  if(level.gametype != "dd") {
    level.bombdefused = 1;
  }

  var_0.bombdefused = 1;
  setbombtimeromnvars();
  level notify("bomb_defused" + var_0.label);
  if(isDefined(level.onobjectivecomplete)) {
    [[level.onobjectivecomplete]]("bombzone", self.label, undefined, game["defenders"], undefined);
  }
}

updatebombplantedomnvar(var_0) {
  if(isDefined(var_0)) {
    if(var_0 == "allies") {
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

setbombtimeromnvars(var_0) {
  updatebombplantedomnvar(var_0);
}

bombzone_setupbombcase(var_0) {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  var_1 = getent(var_0 + "_pickup_trig", "targetname");
  if(!isDefined(var_1)) {
    scripts\engine\utility::error("No " + var_0 + "_pickup_trig trigger found in map.");
    return;
  }

  var_1 = postshipadjustbombtriggerspawn(var_1);
  var_2[0] = getent(var_0, "targetname");
  if(!isDefined(var_2[0])) {
    scripts\engine\utility::error("No " + var_0 + " script_model found in map.");
    return;
  }

  var_2[0] = postshipadjustbombcasespawn(var_2[0]);
  var_2[0] setModel("suitcase_bomb_iw7_wm");
  if(!level.multibomb) {
    level.sdbomb = scripts\mp\gameobjects::createcarryobject(game["attackers"], var_1, var_2, (0, 0, 32));
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

  var_1 delete();
  var_2[0] delete();
}

movebombcase(var_0, var_1) {
  if(isDefined(level.sdbomb)) {
    level.sdbomb.trigger.origin = var_0;
    level.sdbomb.visuals[0].origin = var_0;
    level.sdbomb.visuals[0].angles = var_1;
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
    foreach(var_1 in level.bombzones) {
      var_1.trigger enableplayeruse(level.sdbomb.carrier);
    }

    wait(0.05);
  }
}

onpickup(var_0) {
  var_0.isbombcarrier = 1;
  if(isplayer(var_0)) {
    var_0 thread scripts\mp\matchdata::loggameevent("pickup", var_0.origin);
    scripts\mp\utility::setmlgannouncement(15, var_0.team, var_0 getentitynumber());
  }

  var_0 setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", var_0 getentitynumber());
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_escort");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_escort");
  if(isDefined(level.sd_loadout) && isDefined(level.sd_loadout[var_0.team])) {
    var_0 thread applybombcarrierclass();
  }

  if(!level.bombdefused) {
    scripts\mp\utility::teamplayercardsplash("callout_bombtaken", var_0, var_0.team);
    scripts\mp\utility::leaderdialog("bomb_taken", var_0.pers["team"]);
  }

  scripts\mp\utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_0 setgametypevip(1);
  }

  level notify("bomb_pickup");
}

ondrop(var_0) {
  level notify("bomb_dropped");
  setomnvar("ui_bomb_carrier", -1);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    if(isDefined(var_0)) {
      var_0 setgametypevip(0);
    }
  }

  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_bomb");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_bomb");
  scripts\mp\utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
  if(!level.bombplanted && isDefined(level.bombresettimer) && level.bombresettimer > 0) {
    thread waitforbombreset(level.bombresettimer);
  }
}

waitforbombreset(var_0) {
  level endon("game_ended");
  level endon("bomb_pickup");
  wait(var_0);
  playFX(loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death"), self.visuals[0].origin, self.visuals[0].angles);
  movebombcase(level.bombrespawnpoint, level.bombrespawnangles);
}

enablemultibombui() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("ui_carrying_bomb", var_1.pers["team"] == game["attackers"]);
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

  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0.playerspawnpos = self.origin;
  var_0.notti = 1;
  self.setspawnpoint = var_0;
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

  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0.playerspawnpos = self.origin;
  var_0.notti = 1;
  self.setspawnpoint = var_0;
  self notify("faux_spawn");
  self.faux_spawn_stance = self getstance();
  thread scripts\mp\playerlogic::spawnplayer(1);
}

bombzone_awardgenericbombzonemedals(var_0, var_1) {
  foreach(var_3 in level.bombzones) {
    if(!isDefined(var_3.bombdefusetrig.origin)) {
      continue;
    }

    var_4 = scripts\mp\utility::istrue(var_3.bombplanted);
    var_5 = distsquaredcheck(var_0.origin, var_1.origin, scripts\engine\utility::ter_op(var_4, var_3.bombdefusetrig.origin, var_3.trigger.origin));
    if(var_5) {
      if(var_1.team == game["defenders"]) {
        var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "mode_x_defend", "mode_x_assault"));
        continue;
      }

      var_0 thread scripts\mp\awards::givemidmatchaward(scripts\engine\utility::ter_op(var_4, "mode_x_assault", "mode_x_defend"));
    }
  }
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);
  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  }

  return 0;
}

postshipmodifiedbombzones(var_0, var_1) {
  var_2 = var_1.origin;
  var_3 = modifiedbombzones(var_1, var_2, var_0);
  return var_3;
}

modifiedbombzones(var_0, var_1, var_2) {
  if(level.mapname == "mp_desert" && var_0.script_label == "_b") {
    var_2[0].origin = (-928, 552, 352);
    var_2[0].angles = (0, 0, 0);
    var_0.originalpos = (-928, 552, 361);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 35), (0, 90, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_metropolis" && var_0.script_label == "_b") {
    var_2[0].origin = (-1570, -785, -64);
    var_2[0].angles = (0, 90, 0);
    var_0.originalpos = (-1570, -785, -64);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 0, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 180, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_fallen" && var_0.script_label == "_a") {
    var_2[0].origin = (408, -70, 760);
    var_2[0].angles = (0, 0, 0);
    var_0.originalpos = (408, -70, 760);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 90, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_fallen" && var_0.script_label == "_b") {
    var_2[0].origin = (-270, 2387, 927);
    var_2[0].angles = (0, 0, 0);
    var_0.originalpos = (-270, 2387, 927);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_riot" && var_0.script_label == "_a") {
    var_2[0].origin = (514, 669, 250);
    var_2[0].angles = (13, 90, 1);
    var_0.originalpos = (514, 669, 250);
    var_0.origin = var_0.originalpos;
    var_0.angles = (13, 90, 1);
    setmodifiedbombzonescollision((0, 5, 30), (13, 90, 1), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_proto" && var_0.script_label == "_a") {
    var_2[0].origin = (-90, 1825, 480);
    var_2[0].angles = (0, 0, 0);
    var_0.originalpos = (-90, 1825, 480);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_divide" && var_0.script_label == "_b") {
    var_2[0].origin = (-510, -560, 585);
    var_2[0].angles = (0, 180, 0);
    var_0.originalpos = (-527, -560, 585);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 135, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, -45, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_parkour" && var_0.script_label == "_a") {
    var_2[0].origin = (-1602, 3, 184);
    var_2[0].angles = (0, 90, 0);
    var_0.originalpos = (-1602, 3, 186);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 0, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 180, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  if(level.mapname == "mp_parkour" && var_0.script_label == "_b") {
    var_2[0].origin = (489, -1408, 249);
    var_2[0].angles = (0, 90, 0);
    var_0.originalpos = (489, -1408, 249);
    var_0.origin = var_0.originalpos;
    var_0.angles = (0, 90, 0);
    setmodifiedbombzonescollision((0, 0, 27), (0, 270, 0), var_1, var_2);
    setexplodermodel(var_1, var_2);
    return var_0;
  }

  return var_0;
}

setmodifiedbombzonescollision(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray("script_brushmodel", "classname");
  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_gameobjectname) && var_6.script_gameobjectname == "bombzone") {
      if(distance(var_6.origin, var_2) < 100) {
        var_7 = spawn("script_model", var_3[0].origin + var_0);
        var_7.angles = var_1;
        var_7 clonebrushmodeltoscriptmodel(var_6);
        var_7 disconnectpaths();
        var_6 delete();
        break;
      }
    }
  }
}

setexplodermodel(var_0, var_1) {
  var_2 = getEntArray("script_model", "classname");
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3].script_exploder)) {
      if(isDefined(var_2[var_3].var_336) && var_2[var_3].var_336 == "exploder" && distance(var_2[var_3].origin, var_0) < 100) {
        var_2[var_3].origin = var_1[0].origin;
        var_2[var_3].angles = var_1[0].angles;
      }
    }
  }
}

postshipadjustbombcasespawn(var_0) {
  if(level.mapname == "mp_fallen") {
    var_0.origin = (2655, 1260, 930);
    return var_0;
  }

  if(level.mapname == "mp_divide") {
    var_0.origin = var_0.origin - (0, 0, 2);
    return var_0;
  }

  if(level.mapname == "mp_parkour") {
    var_0.origin = (-56, 3139, 170);
    return var_0;
  }

  if(level.mapname == "mp_quarry") {
    var_0.origin = (-2067, 1214, 242);
    return var_0;
  }

  if(level.mapname == "mp_frontier") {
    var_0.origin = var_0.origin + (0, 0, 1);
    return var_0;
  }

  if(level.mapname == "mp_desert") {
    var_0.origin = var_0.origin + (0, 0, 1);
    return var_0;
  }

  if(level.mapname == "mp_metropolis") {
    var_0.origin = var_0.origin + (0, 0, 2);
    return var_0;
  }

  if(level.mapname == "mp_proto") {
    var_0.origin = (2349, 228, 530);
    return var_0;
  }

  if(level.mapname == "mp_rivet") {
    var_0.origin = var_0.origin + (0, 0, 1);
    return var_0;
  }

  if(level.mapname == "mp_breakneck") {
    var_0.origin = var_0.origin + (0, 0, 2);
    return var_0;
  }

  if(level.mapname == "mp_dome_iw") {
    var_0.origin = var_0.origin + (0, 0, 2);
    return var_0;
  }

  if(level.mapname == "mp_skyway") {
    var_0.origin = var_0.origin + (0, 0, 2);
    return var_0;
  }

  return var_0;
}

postshipadjustbombtriggerspawn(var_0) {
  if(level.mapname == "mp_proto") {
    var_0.origin = (2349, 228, 530);
    return var_0;
  }

  if(level.mapname == "mp_fallen") {
    var_0.origin = (2655, 1260, 930);
    return var_0;
  }

  if(level.mapname == "mp_quarry") {
    var_0.origin = (-2067, 1214, 242);
    return var_0;
  }

  if(level.mapname == "mp_parkour") {
    var_0.origin = (-56, 3139, 170);
    return var_0;
  }

  return var_0;
}