/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3510.gsc
***************************************/

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

getflightpath(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = var_00 + var_01 * (-1 * var_02);
  var_09 = var_00 + var_01 * var_02;

  if(var_03) {
    var_08 = var_08 * (1, 1, 0);
    var_09 = var_09 * (1, 1, 0);
  }

  var_08 = var_08 + (0, 0, var_04);
  var_09 = var_09 + (0, 0, var_04);
  var_10 = length(var_08 - var_09);
  var_11 = var_10 / var_05;
  var_10 = abs(0.5 * var_10 + var_06);
  var_12 = var_10 / var_05;
  var_13["startPoint"] = var_08;
  var_13["endPoint"] = var_09;
  var_13["attackTime"] = var_12;
  var_13["flyTime"] = var_11;
  return var_13;
}

doflyby(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = planespawn(var_00, var_01, var_03, var_07, var_08);
  var_09 endon("death");
  var_10 = 150;
  var_11 = var_04 + ((randomfloat(2) - 1) * var_10, (randomfloat(2) - 1) * var_10, 0);
  var_09 planemove(var_11, var_06, var_05, var_08);
  var_09 planecleanup();
}

planespawn(var_00, var_01, var_02, var_03, var_04) {
  if(!isDefined(var_01)) {
    return;
  }
  var_05 = 100;
  var_06 = var_02 + ((randomfloat(2) - 1) * var_05, (randomfloat(2) - 1) * var_05, 0);
  var_07 = level.planeconfigs[var_04];
  var_08 = undefined;
  var_08 = spawn("script_model", var_06);
  var_8.team = var_1.team;
  var_8.origin = var_06;
  var_8.angles = vectortoangles(var_03);
  var_8.lifeid = var_00;
  var_8.streakname = var_04;
  var_8.owner = var_01;
  var_08 setModel(var_7.func_B923[var_1.team]);

  if(isDefined(var_7.compassiconfriendly)) {
    var_08 setobjectiveicons(var_7.compassiconfriendly, var_7.compassiconenemy);
  }

  var_08 thread handledamage();
  var_08 thread handledeath();
  starttrackingplane(var_08);

  if(!isDefined(var_7.nolightfx)) {
    var_08 thread playplanefx();
  }

  var_08 playLoopSound(var_7.inboundsfx);
  var_08 createkillcam(var_04);
  return var_08;
}

planemove(var_00, var_01, var_02, var_03) {
  var_04 = level.planeconfigs[var_03];
  self moveto(var_00, var_01, 0, 0);

  if(isDefined(var_4.onattackdelegate)) {
    self thread[[var_4.onattackdelegate]](var_00, var_01, var_02, self.owner, var_03);
  }

  if(isDefined(var_4.sonicboomsfx)) {
    thread playsonicboom(var_4.sonicboomsfx, 0.5 * var_01);
  }

  wait(0.65 * var_01);

  if(isDefined(var_4.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(var_4.outboundsfx);
  }

  if(isDefined(var_4.outboundflightanim)) {
    self scriptmodelplayanimdeltamotion(var_4.outboundflightanim);
  }

  wait(0.35 * var_01);
}

planecleanup() {
  var_00 = level.planeconfigs[self.streakname];

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

handleemp(var_00) {
  self endon("death");

  for(;;) {
    if(var_00 scripts\mp\killstreaks\emp_common::isemped()) {
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
  var_00 = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, var_00);
  thread planecleanup();
}

handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(800, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  var_04 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, var_00, var_01, var_02, var_03, var_4.scorepopup, var_4.func_52DA, var_4.callout);
  scripts\mp\missions::func_3DE3(var_00, self, var_01);
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

_meth_806A() {
  var_00 = getent("airstrikeheight", "targetname");

  if(isDefined(var_00)) {
    return var_0.origin[2];
  }
  else {
    var_01 = 950;

    if(isDefined(level.airstrikeheightscale)) {
      var_01 = var_01 * level.airstrikeheightscale;
    }

    return var_01;
  }
}

_meth_8069(var_00) {
  var_01 = spawnStruct();
  var_1.height = _meth_806A();
  var_02 = getent("airstrikeheight", "targetname");

  if(isDefined(var_02) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "fixedposition") {
    var_1.targetpos = var_2.origin;
    var_1.func_6F25 = anglesToForward(var_2.angles);

    if(randomint(2) == 0) {
      var_1.func_6F25 = var_1.func_6F25 * -1;
    }
  } else {
    var_03 = anglesToForward(self.angles);
    var_04 = anglestoright(self.angles);
    var_1.targetpos = self.origin + var_00 * var_03;
    var_1.func_6F25 = -1 * var_04;
  }

  return var_01;
}

getexplodedistance(var_00) {
  var_01 = 850;
  var_02 = 1500;
  var_03 = var_01 / var_00;
  var_04 = var_03 * var_02;
  return var_04;
}

starttrackingplane(var_00) {
  var_01 = var_00 getentitynumber();
  level.planes[var_01] = var_00;
}

stoptrackingplane(var_00) {
  var_01 = var_00 getentitynumber();
  level.planes[var_01] = undefined;
}

selectairstrikelocation(var_00, var_01, var_02) {
  var_03 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var_03 = var_03 * 1.5;
  }

  var_04 = level.planeconfigs[var_01];

  if(isDefined(var_4.selectlocationvo)) {
    self playlocalsound(game["voice"][self.team] + var_4.selectlocationvo);
  }

  scripts\mp\utility\game::_beginlocationselection(var_01, "map_artillery_selector", var_4.choosedirection, var_03);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_05, var_06);

  if(!var_4.choosedirection) {
    var_06 = randomint(360);
  }

  self setblurforplayer(0, 0.3);

  if(isDefined(var_4.inboundvo)) {
    self playlocalsound(game["voice"][self.team] + var_4.inboundvo);
  }

  self thread[[var_02]](var_00, var_05, var_06, var_01);
  return 1;
}

setobjectiveicons(var_00, var_01) {
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_02 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", (0, 0, 0), var_00);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_02, self);
  }

  self.friendlyteamid = var_02;
  var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);

  if(var_03 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "active", (0, 0, 0), var_01);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03, self);
  }

  self.enemyteamid = var_03;

  if(level.teambased) {
    if(var_02 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
    }

    if(var_03 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_03, scripts\mp\utility\game::getotherteam(self.team));
    }
  } else {
    var_04 = self.owner getentitynumber();

    if(var_02 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_02, var_04);
    }

    if(var_03 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_03, var_04);
    }
  }
}

playsonicboom(var_00, var_01) {
  self endon("death");
  wait(var_01);
  self playsoundonmovingent(var_00);
}

createkillcam(var_00) {
  var_01 = level.planeconfigs[var_00];

  if(isDefined(var_1.killcamoffset)) {
    var_02 = anglesToForward(self.angles);
    var_03 = spawn("script_model", self.origin + (0, 0, 100) - var_02 * 200);
    var_3.starttime = gettime();
    var_03 setscriptmoverkillcam("airstrike");
    var_03 linkto(self, "tag_origin", var_1.killcamoffset, (0, 0, 0));
    self.killcament = var_03;
  }
}