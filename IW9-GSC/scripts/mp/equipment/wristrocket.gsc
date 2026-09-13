/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\wristrocket.gsc
************************************************/

wristrocketinit() {
  level._effect["wristrocket_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
  level._effect["wristrocket_thruster"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_thruster");
}

wristrocket_set() {
  thread wristrocket_watcheffects();
}

wristrocket_unset() {
  self notify("wristRocket_unset");
}

wristrocketused(grenade) {
  if(grenade.tickpercent == 1) {
    return;
  }
  rocket = wristrocket_createrocket(grenade);
  rocket.grenade = grenade;
  grenade = scripts\mp\utility\weapon::_launchgrenade("pop_rocket_mp", self.origin, (0, 0, 0), 100, 1, grenade);
  grenade forcehidegrenadehudwarning(1);
  grenade linkTo(rocket);
  grenade thread wristrocket_cleanuponparentdeath(rocket);
  grenade thread wristrocket_cleanuponownerdisconnect(self);
  rocket setscriptablepartstate("launch", "active", 0);
  rocket thread wristrocket_watchfuse(2);
  rocket thread wristrocket_watchstuck();
}

wristrocket_watchfuse(fusetime) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait(fusetime);
  thread wristrocket_explode();
}

wristrocket_watchstuck() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", stuckto);

  if(isPlayer(stuckto))
    self.owner scripts\mp\weapons::grenadestuckto(self, stuckto);

  self stoploopsound();
  self setscriptablepartstate("stuck", "active", 0);
  self setscriptablepartstate("beacon", "active", 0);
  self.grenade forcehidegrenadehudwarning(0);
  thread wristrocket_watchfuse(1.35);
}

wristrocket_explode() {
  self setscriptablepartstate("stuck", "neutral", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread wristrocket_delete();
}

wristrocket_delete() {
  self notify("death");
  self.exploding = 1;
  wait 0.1;
  self delete();
}

wristrocket_createrocket(grenade) {
  rocket = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("pop_rocket_proj_mp"), grenade.origin, grenade.origin + anglesToForward(self getgunangles()), self);
  rocket.owner = self;
  rocket.team = self.team;
  rocket.weapon_name = "pop_rocket_proj_mp";
  rocket.power = "power_wristrocket";
  rocket setotherent(self);
  rocket setentityowner(self);
  rocket thread wristrocket_cleanuponownerdisconnect(self);
  return rocket;
}

wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  _id_FB0B2F8F6AA55804 = 0;

  for(;;) {
    _id_C05958D616DDF1C5 = spawnStruct();

    if(_id_FB0B2F8F6AA55804)
      childthread wristrocket_watcheffectsraceheldoffhandbreak(_id_C05958D616DDF1C5);
    else
      childthread wristrocket_watcheffectsracegrenadepullback(_id_C05958D616DDF1C5);

    childthread wristrocket_watcheffectsracegrenadefired(_id_C05958D616DDF1C5);
    childthread wristrocket_watcheffectsracesuperstarted(_id_C05958D616DDF1C5);
    childthread wristrocket_watcheffectsracedeath(_id_C05958D616DDF1C5);
    childthread wristrocket_watcheffectsraceunset(_id_C05958D616DDF1C5);
    _id_FB0B2F8F6AA55804 = 0;
    self waittill("wristRocket_watchEffectsRaceStart");
    waittillframeend;
    grenadepullback = istrue(_id_C05958D616DDF1C5.grenadepullback);
    grenadefire = istrue(_id_C05958D616DDF1C5.grenadefire);
    superstarted = istrue(_id_C05958D616DDF1C5.superstarted);
    death = istrue(_id_C05958D616DDF1C5.death);
    unset = istrue(_id_C05958D616DDF1C5.unset);
    heldoffhandbreak = istrue(_id_C05958D616DDF1C5.heldoffhandbreak);

    if(death) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(unset) {
      self notify("wristRocket_watchEffectsRaceEnd");
      thread wristrocket_endeffects();
      return;
    } else if(superstarted)
      thread wristrocket_endeffects();
    else if(heldoffhandbreak)
      thread wristrocket_endeffects();
    else if(grenadefire)
      thread wristrocket_endeffects();
    else if(grenadepullback) {
      thread wristrocket_begineffects();
      _id_FB0B2F8F6AA55804 = 1;
    }

    self notify("wristRocket_watchEffectsRaceEnd");
  }
}

wristrocket_watcheffectsracegrenadepullback(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_pullback", objweapon);

    if(objweapon.basename == "pop_rocket_mp") {
      break;
    }
  }

  _id_C05958D616DDF1C5.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracegrenadefired(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_fire", grenade, objweapon);

    if(objweapon.basename == "pop_rocket_mp") {
      break;
    }
  }

  _id_C05958D616DDF1C5.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracesuperstarted(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  _id_C05958D616DDF1C5.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsracedeath(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  _id_C05958D616DDF1C5.death = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceunset(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  _id_C05958D616DDF1C5.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_watcheffectsraceheldoffhandbreak(_id_C05958D616DDF1C5) {
  self endon("wristRocket_watchEffectsRaceEnd");
  waitframe();
  weapon = makeweapon("pop_rocket_mp");

  while(self getheldoffhand() == weapon)
    waitframe();

  _id_C05958D616DDF1C5.heldoffhandbreak = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

wristrocket_begineffects() {
  self notify("wristRocket_beginEffects");
  self endon("wristRocket_beginEffects");
  self endon("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
  wait 0.15;
  self setscriptablepartstate("wristRocketWorld", "active", 0);
}

wristrocket_endeffects() {
  self notify("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
}

wristrocketcooksuicideexplodecheck(inflictor, attacker, victim, meansofdeath, objweapon) {
  if(attacker != victim) {
    return;
  }
  if(meansofdeath != "MOD_SUICIDE") {
    return;
  }
  if(!isDefined(inflictor) || inflictor != attacker) {
    return;
  }
  if(!isDefined(objweapon) || objweapon.basename != "pop_rocket_mp") {
    return;
  }
  _id_45292519459D6838 = victim gettagorigin("tag_weapon_left");
  radiusdamage(_id_45292519459D6838, 175, 200, 70, attacker, "MOD_EXPLOSIVE", "pop_rocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(_id_45292519459D6838, 0.6);
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), _id_45292519459D6838);
}

wristrocket_cleanuponparentdeath(parent, delay) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(parent))
    parent waittill("death");

  if(isDefined(delay))
    wait(delay);

  self delete();
}

wristrocket_cleanuponownerdisconnect(owner) {
  self endon("death");
  owner waittill("disconnect");

  if(isDefined(self))
    self delete();
}