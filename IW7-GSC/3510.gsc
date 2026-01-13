/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3510.gsc
**************************************/

init() {
  if(!isDefined(level.planes)) {
    level.planes = [];
  }

  if(!isDefined(level.planeconfigs)) {
    level.planeconfigs = [];
  }

  level.fighter_deathfx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.fx_airstrike_afterburner = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.fx_airstrike_contrail = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_green = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_red = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
}

getflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 + var_1 * (-1 * var_2);
  var_9 = var_0 + var_1 * var_2;

  if(var_3) {
    var_8 = var_8 * (1, 1, 0);
    var_9 = var_9 * (1, 1, 0);
  }

  var_8 = var_8 + (0, 0, var_4);
  var_9 = var_9 + (0, 0, var_4);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_5;
  var_10 = abs(0.5 * var_10 + var_6);
  var_12 = var_10 / var_5;
  var_13["startPoint"] = var_8;
  var_13["endPoint"] = var_9;
  var_13["attackTime"] = var_12;
  var_13["flyTime"] = var_11;
  return var_13;
}

doflyby(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = planespawn(var_0, var_1, var_3, var_7, var_8);
  var_9 endon("death");
  var_10 = 150;
  var_11 = var_4 + ((randomfloat(2) - 1) * var_10, (randomfloat(2) - 1) * var_10, 0);
  var_9 planemove(var_11, var_6, var_5, var_8);
  var_9 planecleanup();
}

planespawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  var_5 = 100;
  var_6 = var_2 + ((randomfloat(2) - 1) * var_5, (randomfloat(2) - 1) * var_5, 0);
  var_7 = level.planeconfigs[var_4];
  var_8 = undefined;
  var_8 = spawn("script_model", var_6);
  var_8.team = var_1.team;
  var_8.origin = var_6;
  var_8.angles = vectortoangles(var_3);
  var_8.lifeid = var_0;
  var_8.streakname = var_4;
  var_8.owner = var_1;
  var_8 setModel(var_7.var_B923[var_1.team]);

  if(isDefined(var_7.compassiconfriendly)) {
    var_8 setobjectiveicons(var_7.compassiconfriendly, var_7.compassiconenemy);
  }

  var_8 thread handledamage();
  var_8 thread handledeath();
  starttrackingplane(var_8);

  if(!isDefined(var_7.nolightfx)) {
    var_8 thread playplanefx();
  }

  var_8 playLoopSound(var_7.inboundsfx);
  var_8 createkillcam(var_4);
  return var_8;
}

planemove(var_0, var_1, var_2, var_3) {
  var_4 = level.planeconfigs[var_3];
  self moveto(var_0, var_1, 0, 0);

  if(isDefined(var_4.onattackdelegate)) {
    self thread[[var_4.onattackdelegate]](var_0, var_1, var_2, self.owner, var_3);
  }

  if(isDefined(var_4.sonicboomsfx)) {
    thread playsonicboom(var_4.sonicboomsfx, 0.5 * var_1);
  }

  wait(0.65 * var_1);

  if(isDefined(var_4.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(var_4.outboundsfx);
  }

  if(isDefined(var_4.outboundflightanim)) {
    self scriptmodelplayanimdeltamotion(var_4.outboundflightanim);
  }

  wait(0.35 * var_1);
}

planecleanup() {
  var_0 = level.planeconfigs[self.streakname];

  if(isDefined(var_0.onflybycompletedelegate)) {
    thread[[var_0.onflybycompletedelegate]](self.owner, self, self.streakname);
  }

  if(isDefined(self.friendlyteamid)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.friendlyteamid);
    scripts\mp\objidpoolmanager::returnminimapid(self.enemyteamid);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  stoptrackingplane(self);
  self notify("delete");
  self delete();
}

handleemp(var_0) {
  self endon("death");

  for(;;) {
    if(var_0 scripts\mp\killstreaks\emp_common::isemped()) {
      self notify("death");
      return;
    }

    level waittill("emp_update");
  }
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var_0 = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, var_0);
  thread planecleanup();
}

handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(800, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

handledeathdamage(var_0, var_1, var_2, var_3) {
  var_4 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, var_0, var_1, var_2, var_3, var_4.scorepopup, var_4.var_52DA, var_4.callout);
  scripts\mp\missions::func_3DE3(var_0, self, var_1);
}

playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

func_806A() {
  var_0 = getent("airstrikeheight", "targetname");

  if(isDefined(var_0)) {
    return var_0.origin[2];
  } else {
    var_1 = 950;

    if(isDefined(level.airstrikeheightscale)) {
      var_1 = var_1 * level.airstrikeheightscale;
    }

    return var_1;
  }
}

func_8069(var_0) {
  var_1 = spawnStruct();
  var_1.height = func_806A();
  var_2 = getent("airstrikeheight", "targetname");

  if(isDefined(var_2) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "fixedposition") {
    var_1.targetpos = var_2.origin;
    var_1.var_6F25 = anglesToForward(var_2.angles);

    if(randomint(2) == 0) {
      var_1.var_6F25 = var_1.var_6F25 * -1;
    }
  } else {
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    var_1.targetpos = self.origin + var_0 * var_3;
    var_1.var_6F25 = -1 * var_4;
  }

  return var_1;
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

starttrackingplane(var_0) {
  var_1 = var_0 getentitynumber();
  level.planes[var_1] = var_0;
}

stoptrackingplane(var_0) {
  var_1 = var_0 getentitynumber();
  level.planes[var_1] = undefined;
}

selectairstrikelocation(var_0, var_1, var_2) {
  var_3 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var_3 = var_3 * 1.5;
  }

  var_4 = level.planeconfigs[var_1];

  if(isDefined(var_4.selectlocationvo)) {
    self playlocalsound(game["voice"][self.team] + var_4.selectlocationvo);
  }

  scripts\mp\utility\game::_beginlocationselection(var_1, "map_artillery_selector", var_4.choosedirection, var_3);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_5, var_6);

  if(!var_4.choosedirection) {
    var_6 = randomint(360);
  }

  self setblurforplayer(0, 0.3);

  if(isDefined(var_4.inboundvo)) {
    self playlocalsound(game["voice"][self.team] + var_4.inboundvo);
  }

  self thread[[var_2]](var_0, var_5, var_6, var_1);
  return 1;
}

setobjectiveicons(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_2 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_2, "active", (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_2, self);
  }

  self.friendlyteamid = var_2;
  var_3 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_3 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_3, "active", (0, 0, 0), var_1);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_3, self);
  }

  self.enemyteamid = var_3;

  if(level.teambased) {
    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_2, self.team);
    }

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_3, scripts\mp\utility\game::getotherteam(self.team));
    }
  } else {
    var_4 = self.owner getentitynumber();

    if(var_2 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_2, var_4);
    }

    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_3, var_4);
    }
  }
}

playsonicboom(var_0, var_1) {
  self endon("death");
  wait(var_1);
  self playsoundonmovingent(var_0);
}

createkillcam(var_0) {
  var_1 = level.planeconfigs[var_0];

  if(isDefined(var_1.killcamoffset)) {
    var_2 = anglesToForward(self.angles);
    var_3 = spawn("script_model", self.origin + (0, 0, 100) - var_2 * 200);
    var_3.starttime = gettime();
    var_3 setscriptmoverkillcam("airstrike");
    var_3 linkto(self, "tag_origin", var_1.killcamoffset, (0, 0, 0));
    self.killcament = var_3;
  }
}