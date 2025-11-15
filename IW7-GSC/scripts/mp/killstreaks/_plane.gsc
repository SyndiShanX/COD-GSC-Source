/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_plane.gsc
*********************************************/

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

getflightpath(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = param_00 + param_01 * -1 * param_02;
  var_09 = param_00 + param_01 * param_02;
  if(param_03) {
    var_08 = var_08 * (1, 1, 0);
    var_09 = var_09 * (1, 1, 0);
  }

  var_08 = var_08 + (0, 0, param_04);
  var_09 = var_09 + (0, 0, param_04);
  var_0A = length(var_08 - var_09);
  var_0B = var_0A / param_05;
  var_0A = abs(0.5 * var_0A + param_06);
  var_0C = var_0A / param_05;
  var_0D["startPoint"] = var_08;
  var_0D["endPoint"] = var_09;
  var_0D["attackTime"] = var_0C;
  var_0D["flyTime"] = var_0B;
  return var_0D;
}

doflyby(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = planespawn(param_00, param_01, param_03, param_07, param_08);
  var_09 endon("death");
  var_0A = 150;
  var_0B = param_04 + (randomfloat(2) - 1 * var_0A, randomfloat(2) - 1 * var_0A, 0);
  var_09 planemove(var_0B, param_06, param_05, param_08);
  var_09 planecleanup();
}

planespawn(param_00, param_01, param_02, param_03, param_04) {
  if(!isDefined(param_01)) {
    return;
  }

  var_05 = 100;
  var_06 = param_02 + (randomfloat(2) - 1 * var_05, randomfloat(2) - 1 * var_05, 0);
  var_07 = level.planeconfigs[param_04];
  var_08 = undefined;
  var_08 = spawn("script_model", var_06);
  var_08.team = param_01.team;
  var_08.origin = var_06;
  var_08.angles = vectortoangles(param_03);
  var_08.lifeid = param_00;
  var_08.streakname = param_04;
  var_08.triggerportableradarping = param_01;
  var_08 setModel(var_07.var_B923[param_01.team]);
  if(isDefined(var_07.compassiconfriendly)) {
    var_08 setobjectiveicons(var_07.compassiconfriendly, var_07.compassiconenemy);
  }

  var_08 thread handledamage();
  var_08 thread handledeath();
  starttrackingplane(var_08);
  if(!isDefined(var_07.nolightfx)) {
    var_08 thread playplanefx();
  }

  var_08 playLoopSound(var_07.inboundsfx);
  var_08 createkillcam(param_04);
  return var_08;
}

planemove(param_00, param_01, param_02, param_03) {
  var_04 = level.planeconfigs[param_03];
  self moveto(param_00, param_01, 0, 0);
  if(isDefined(var_04.onattackdelegate)) {
    self thread[[var_04.onattackdelegate]](param_00, param_01, param_02, self.triggerportableradarping, param_03);
  }

  if(isDefined(var_04.sonicboomsfx)) {
    thread playsonicboom(var_04.sonicboomsfx, 0.5 * param_01);
  }

  wait(0.65 * param_01);
  if(isDefined(var_04.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(var_04.outboundsfx);
  }

  if(isDefined(var_04.outboundflightanim)) {
    self scriptmodelplayanimdeltamotion(var_04.outboundflightanim);
  }

  wait(0.35 * param_01);
}

planecleanup() {
  var_00 = level.planeconfigs[self.streakname];
  if(isDefined(var_00.onflybycompletedelegate)) {
    thread[[var_00.onflybycompletedelegate]](self.triggerportableradarping, self, self.streakname);
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

handleemp(param_00) {
  self endon("death");
  for(;;) {
    if(param_00 scripts\mp\killstreaks\_emp_common::isemped()) {
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

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  var_04 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, param_00, param_01, param_02, param_03, var_04.scorepopup, var_04.var_52DA, var_04.callout);
  scripts\mp\missions::func_3DE3(param_00, self, param_01);
}

playplanefx() {
  self endon("death");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

_meth_806A() {
  var_00 = getent("airstrikeheight", "targetname");
  if(isDefined(var_00)) {
    return var_00.origin[2];
  }

  var_01 = 950;
  if(isDefined(level.airstrikeheightscale)) {
    var_01 = var_01 * level.airstrikeheightscale;
  }

  return var_01;
}

_meth_8069(param_00) {
  var_01 = spawnStruct();
  var_01.height = _meth_806A();
  var_02 = getent("airstrikeheight", "targetname");
  if(isDefined(var_02) && isDefined(var_02.script_noteworthy) && var_02.script_noteworthy == "fixedposition") {
    var_01.targetpos = var_02.origin;
    var_01.var_6F25 = anglesToForward(var_02.angles);
    if(randomint(2) == 0) {
      var_01.var_6F25 = var_01.var_6F25 * -1;
    }
  } else {
    var_03 = anglesToForward(self.angles);
    var_04 = anglestoright(self.angles);
    var_01.targetpos = self.origin + param_00 * var_03;
    var_01.var_6F25 = -1 * var_04;
  }

  return var_01;
}

getexplodedistance(param_00) {
  var_01 = 850;
  var_02 = 1500;
  var_03 = var_01 / param_00;
  var_04 = var_03 * var_02;
  return var_04;
}

starttrackingplane(param_00) {
  var_01 = param_00 getentitynumber();
  level.planes[var_01] = param_00;
}

stoptrackingplane(param_00) {
  var_01 = param_00 getentitynumber();
  level.planes[var_01] = undefined;
}

selectairstrikelocation(param_00, param_01, param_02) {
  var_03 = level.mapsize / 6.46875;
  if(level.splitscreen) {
    var_03 = var_03 * 1.5;
  }

  var_04 = level.planeconfigs[param_01];
  if(isDefined(var_04.selectlocationvo)) {
    self playlocalsound(game["voice"][self.team] + var_04.selectlocationvo);
  }

  scripts\mp\utility::_beginlocationselection(param_01, "map_artillery_selector", var_04.choosedirection, var_03);
  self endon("stop_location_selection");
  self waittill("confirm_location", var_05, var_06);
  if(!var_04.choosedirection) {
    var_06 = randomint(360);
  }

  self setblurforplayer(0, 0.3);
  if(isDefined(var_04.inboundvo)) {
    self playlocalsound(game["voice"][self.team] + var_04.inboundvo);
  }

  self thread[[param_02]](param_00, var_05, var_06, param_01);
  return 1;
}

setobjectiveicons(param_00, param_01) {
  var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_02 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "active", (0, 0, 0), param_00);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_02, self);
  }

  self.friendlyteamid = var_02;
  var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);
  if(var_03 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "active", (0, 0, 0), param_01);
    scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_03, self);
  }

  self.enemyteamid = var_03;
  if(level.teambased) {
    if(var_02 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
    }

    if(var_03 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_team(var_03, scripts\mp\utility::getotherteam(self.team));
      return;
    }

    return;
  }

  var_04 = self.triggerportableradarping getentitynumber();
  if(var_02 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_playerteam(var_02, var_04);
  }

  if(var_03 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_playerenemyteam(var_03, var_04);
  }
}

playsonicboom(param_00, param_01) {
  self endon("death");
  wait(param_01);
  self playsoundonmovingent(param_00);
}

createkillcam(param_00) {
  var_01 = level.planeconfigs[param_00];
  if(isDefined(var_01.killcamoffset)) {
    var_02 = anglesToForward(self.angles);
    var_03 = spawn("script_model", self.origin + (0, 0, 100) - var_02 * 200);
    var_03.starttime = gettime();
    var_03 setscriptmoverkillcam("airstrike");
    var_03 linkto(self, "tag_origin", var_01.killcamoffset, (0, 0, 0));
    self.killcament = var_03;
  }
}