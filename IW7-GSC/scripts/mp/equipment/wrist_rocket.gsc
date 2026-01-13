/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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

wristrocketused(var_0) {
  if(var_0.tickpercent == 1) {
    return;
  }

  var_1 = wristrocket_createrocket(var_0);
  var_1.objective_position = var_0;
  var_0 = scripts\mp\utility::_launchgrenade("wristrocket_mp", self.origin, (0, 0, 0), 100, 1, var_0);
  var_0 forcehidegrenadehudwarning(1);
  var_0 linkto(var_1);
  var_0 thread wristrocket_cleanuponparentdeath(var_1);
  var_1 setscriptablepartstate("launch", "active", 0);
  var_1 thread wristrocket_watchfuse(2);
  var_1 thread wristrocket_watchstuck();
}

wristrocket_watchfuse(var_0) {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait(var_0);
  thread wristrocket_explode();
}

wristrocket_watchstuck() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self playLoopSound("wrist_rocket_fire_tail");
  self waittill("missile_stuck", var_0);
  if(isplayer(var_0)) {
    self.triggerportableradarping scripts\mp\weapons::grenadestuckto(self, var_0);
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

wristrocket_createrocket(var_0) {
  var_1 = scripts\mp\utility::_magicbullet("wristrocket_proj_mp", var_0.origin, var_0.origin + anglesToForward(self getgunangles()), self);
  var_1.triggerportableradarping = self;
  var_1.team = self.team;
  var_1.weapon_name = "wristrocket_proj_mp";
  var_1.power = "power_wristrocket";
  var_1 setotherent(self);
  var_1 setentityowner(self);
  var_1 thread wristrocket_cleanuponownerdisconnect(self);
  return var_1;
}

wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var_0 = 0;
  for(;;) {
    var_1 = spawnStruct();
    if(var_0) {
      childthread wristrocket_watcheffectsraceheldoffhandbreak(var_1);
    } else {
      childthread wristrocket_watcheffectsracegrenadepullback(var_1);
    }

    childthread wristrocket_watcheffectsracegrenadefired(var_1);
    childthread wristrocket_watcheffectsracesuperstarted(var_1);
    childthread wristrocket_watcheffectsracedeath(var_1);
    childthread wristrocket_watcheffectsraceunset(var_1);
    var_0 = 0;
    self waittill("wristRocket_watchEffectsRaceStart");
    waittillframeend;
    var_2 = scripts\mp\utility::istrue(var_1.grenadepullback);
    var_3 = scripts\mp\utility::istrue(var_1.grenadefire);
    var_4 = scripts\mp\utility::istrue(var_1.superstarted);
    var_5 = scripts\mp\utility::istrue(var_1.var_E6);
    var_6 = scripts\mp\utility::istrue(var_1.unset);
    var_7 = scripts\mp\utility::istrue(var_1.heldoffhandbreak);
    if(var_5) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(var_6) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(var_4) {
      thread wristrocket_endeffects();
    } else if(var_7) {
      thread wristrocket_endeffects();
    } else if(var_3) {
      thread wristrocket_endeffects();
    } else if(var_2) {
      thread wristrocket_begineffects();
      var_0 = 1;
    }

    self notify("wristRocket_watchEffectsRaceEnd");
  }
}

wristrocket_watcheffectsracegrenadepullback(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  for(;;) {
    self waittill("grenade_pullback", var_1);
    if(var_1 == "wristrocket_mp") {
      break;
    }
  }

  var_0.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracegrenadefired(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  for(;;) {
    self waittill("grenade_fire", var_1, var_2);
    if(var_2 == "wristrocket_mp") {
      break;
    }
  }

  var_0.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracesuperstarted(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  var_0.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracedeath(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  var_0.var_E6 = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceunset(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  var_0.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceheldoffhandbreak(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  scripts\engine\utility::waitframe();
  while(self _meth_854D() == "wristrocket_mp") {
    scripts\engine\utility::waitframe();
  }

  var_0.heldoffhandbreak = 1;
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

wristrocketcooksuicideexplodecheck(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 != var_2) {
    return;
  }

  if(var_3 != "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(var_0) || var_0 != var_1) {
    return;
  }

  if(!isDefined(var_4) || var_4 != "wristrocket_mp") {
    return;
  }

  var_5 = var_2 gettagorigin("tag_weapon_left");
  radiusdamage(var_5, 175, 200, 70, var_1, "MOD_EXPLOSIVE", "wristrocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_5, 0.6);
  playsoundatpos(var_5, "wrist_rocket_explode");
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), var_5);
}

wristrocket_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");
  if(isDefined(var_0)) {
    var_0 waittill("death");
  }

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self delete();
}

wristrocket_cleanuponownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  if(isDefined(self)) {
    self delete();
  }
}