/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\wrist_rocket.gsc
*************************************************/

wristrocketinit() {
  level._effect["wristrocket_explode"] = loadfx("vfx\iw7\_requests\mp\power\vfx_wrist_rocket_exp.vfx");
  level._effect["wristrocket_thruster"] = loadfx("vfx\iw7\_requests\mp\power\vfx_wrist_rocket_thruster");
}

wristrocket_set() {
  thread wristrocket_watcheffects();
}

wristrocket_unset() {
  self notify("wristRocket_unset");
}

wristrocketused(param_00) {
  if(param_00.tickpercent == 1) {
    return;
  }

  var_01 = wristrocket_createrocket(param_00);
  var_01.objective_position = param_00;
  param_00 = scripts\mp\utility::_launchgrenade("wristrocket_mp", self.origin, (0, 0, 0), 100, 1, param_00);
  param_00 forcehidegrenadehudwarning(1);
  param_00 linkto(var_01);
  param_00 thread wristrocket_cleanuponparentdeath(var_01);
  var_01 setscriptablepartstate("launch", "active", 0);
  var_01 thread wristrocket_watchfuse(2);
  var_01 thread wristrocket_watchstuck();
}

wristrocket_watchfuse(param_00) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait(param_00);
  thread wristrocket_explode();
}

wristrocket_watchstuck() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self playLoopSound("wrist_rocket_fire_tail");
  self waittill("missile_stuck", var_00);
  if(isplayer(var_00)) {
    self.triggerportableradarping scripts\mp\weapons::grenadestuckto(self, var_00);
  }

  self stoploopsound();
  self setscriptablepartstate("beacon", "active", 0);
  self.objective_position forcehidegrenadehudwarning(0);
  thread wristrocket_watchfuse(1);
}

wristrocket_explode() {
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread wristrocket_delete();
}

wristrocket_delete() {
  self notify("death");
  self.exploding = 1;
  wait(0.1);
  self delete();
}

wristrocket_createrocket(param_00) {
  var_01 = scripts\mp\utility::_magicbullet("wristrocket_proj_mp", param_00.origin, param_00.origin + anglesToForward(self getgunangles()), self);
  var_01.triggerportableradarping = self;
  var_01.team = self.team;
  var_01.weapon_name = "wristrocket_proj_mp";
  var_01.power = "power_wristrocket";
  var_01 setotherent(self);
  var_01 setentityowner(self);
  var_01 thread wristrocket_cleanuponownerdisconnect(self);
  return var_01;
}

wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var_00 = 0;
  for(;;) {
    var_01 = spawnStruct();
    if(var_00) {
      childthread wristrocket_watcheffectsraceheldoffhandbreak(var_01);
    } else {
      childthread wristrocket_watcheffectsracegrenadepullback(var_01);
    }

    childthread wristrocket_watcheffectsracegrenadefired(var_01);
    childthread wristrocket_watcheffectsracesuperstarted(var_01);
    childthread wristrocket_watcheffectsracedeath(var_01);
    childthread wristrocket_watcheffectsraceunset(var_01);
    var_00 = 0;
    self waittill("wristRocket_watchEffectsRaceStart");
    waittillframeend;
    var_02 = scripts\mp\utility::istrue(var_01.grenadepullback);
    var_03 = scripts\mp\utility::istrue(var_01.grenadefire);
    var_04 = scripts\mp\utility::istrue(var_01.superstarted);
    var_05 = scripts\mp\utility::istrue(var_01.var_E6);
    var_06 = scripts\mp\utility::istrue(var_01.unset);
    var_07 = scripts\mp\utility::istrue(var_01.heldoffhandbreak);
    if(var_05) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(var_06) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(var_04) {
      thread wristrocket_endeffects();
    } else if(var_07) {
      thread wristrocket_endeffects();
    } else if(var_03) {
      thread wristrocket_endeffects();
    } else if(var_02) {
      thread wristrocket_begineffects();
      var_00 = 1;
    }

    self notify("wristRocket_watchEffectsRaceEnd");
  }
}

wristrocket_watcheffectsracegrenadepullback(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  for(;;) {
    self waittill("grenade_pullback", var_01);
    if(var_01 == "wristrocket_mp") {
      break;
    }
  }

  param_00.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracegrenadefired(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  for(;;) {
    self waittill("grenade_fire", var_01, var_02);
    if(var_02 == "wristrocket_mp") {
      break;
    }
  }

  param_00.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracesuperstarted(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  param_00.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracedeath(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  param_00.var_E6 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceunset(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  param_00.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceheldoffhandbreak(param_00) {
  self endon("wristRocket_watchEffectsRaceEnd");
  scripts\engine\utility::waitframe();
  while(self _meth_854D() == "wristrocket_mp") {
    scripts\engine\utility::waitframe();
  }

  param_00.heldoffhandbreak = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_begineffects() {
  self notify("wristRocket_beginEffects");
  self endon("wristRocket_beginEffects");
  self endon("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
  wait(0.15);
  self setscriptablepartstate("wristRocketWorld", "active", 0);
}

wristrocket_endeffects() {
  self notify("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
}

wristrocketcooksuicideexplodecheck(param_00, param_01, param_02, param_03, param_04) {
  if(param_01 != param_02) {
    return;
  }

  if(param_03 != "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(param_00) || param_00 != param_01) {
    return;
  }

  if(!isDefined(param_04) || param_04 != "wristrocket_mp") {
    return;
  }

  var_05 = param_02 gettagorigin("tag_weapon_left");
  radiusdamage(var_05, 175, 200, 70, param_01, "MOD_EXPLOSIVE", "wristrocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_05, 0.6);
  playsoundatpos(var_05, "wrist_rocket_explode");
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), var_05);
}

wristrocket_cleanuponparentdeath(param_00, param_01) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");
  if(isDefined(param_00)) {
    param_00 waittill("death");
  }

  if(isDefined(param_01)) {
    wait(param_01);
  }

  self delete();
}

wristrocket_cleanuponownerdisconnect(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}