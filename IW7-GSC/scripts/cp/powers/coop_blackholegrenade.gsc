/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_blackholegrenade.gsc
*******************************************************/

blackholegrenadeinit() {
  level.var_2ABC = [];
}

blackholeminetrigger() {
  scripts\cp\cp_weapon::makeexplosiveunusable();
  self.triggerportableradarping blackholegrenadeused(self, 1);
}

blackholemineexplode() {}

blackholegrenadeused(var_0, var_1) {
  var_0 endon("death");
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = createkillcam(var_0);
  var_0.killcament = var_2;
  thread func_13A55(var_0);
  var_0.state = 0;
  thread func_12EB1(var_0, var_2, var_1);
  if(!var_1) {
    var_0 waittill("blackhole_grenade_stuck");
    if(!isDefined(var_0)) {
      return;
    }
  }

  var_0.state = 1;
  thread func_12F29(var_0);
  var_0 waittill("blackhole_grenade_active");
  if(!isDefined(var_0)) {
    return;
  }

  var_0.state = 2;
  thread func_12E56(var_0);
  var_0 waittill("blackhole_grenade_finished");
  if(!isDefined(var_0)) {}
}

func_2B3E(var_0) {
  var_0 endon("death");
  thread func_13A55(var_0);
  var_1 = spawn("script_model", var_0.origin);
  var_1 setotherent(var_0.triggerportableradarping);
  var_1 setModel("prop_mp_black_hole_grenade_scr");
  var_1 give_player_tickets(1);
  var_1 linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 thread func_4116(var_0);
  var_0.physics_capsulecast = var_1;
  var_2 = getblackholecenter(var_0);
  thread func_13A58(var_0);
  var_0.physics_capsulecast setscriptablepartstate("vortexUpdate", "active_cp", 0);
  var_0 thread func_CB0C();
  var_3 = 10;
  wait(var_3);
  var_0 delete();
}

func_12EB1(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("death");
  if(!var_2) {
    var_0 waittill("missile_stuck", var_3);
  }

  if(var_0 checkvalidposition(self)) {
    self notify("powers_blackholeGrenade_used", 1);
    playsoundatpos(var_0.origin, "blackhole_plant");
    var_4 = func_10834(var_0, var_0.origin, var_0.angles);
    var_0.var_DA64 = var_4;
    var_5 = getblackholecenter(var_0);
    var_6 = func_10835(var_0, var_5, var_0.angles);
    var_0.physics_capsulecast = var_6;
    var_1 unlink();
    var_1.origin = var_5;
    var_1.angles = var_0.angles;
    var_1 linkto(var_0);
    var_1 thread cleanuponparentdeath(var_6, 10);
    var_0 notify("blackhole_grenade_stuck");
    return;
  }

  thread placementfailed(var_4);
}

checkvalidposition(var_0) {
  if(!isDefined(self)) {
    return 0;
  }

  var_1 = var_0 findpath(var_0.origin, self.origin);
  if(var_1.size < 1) {
    return 0;
  } else if(distance(var_1[var_1.size - 1], self.origin) >= 12) {
    return 0;
  }

  var_2 = getclosestpointonnavmesh(self.origin);
  if(!isDefined(var_2)) {
    return 0;
  }

  if(distance(self.origin, var_2) > 18) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](var_2)) {
      return 0;
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(self.origin, level.invalid_spawn_volume_array, var_0, undefined, 1)) {
    return 0;
  }

  if(positionwouldtelefrag(self.origin)) {
    return 0;
  }

  return 1;
}

func_12F29(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0.var_DA64 setscriptablepartstate("beam", "active", 0);
  var_0.physics_capsulecast setscriptablepartstate("vortexStart", "active", 0);
  var_1 = 1.2;
  wait(var_1);
  var_0 notify("blackhole_grenade_active");
}

func_12E56(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_1 = getblackholecenter(var_0);
  thread grabclosestzombies(var_0);
  var_0.physics_capsulecast setscriptablepartstate("vortexUpdate", "active_cp", 0);
  var_0 thread func_CB0C();
  var_2 = 10;
  wait(var_2);
  var_0 delete();
}

grabclosestzombies(var_0, var_1) {
  var_0 endon("death");
  var_0.grabbedents = [];
  var_2 = anglestoup(var_0.angles);
  var_3 = spawn("trigger_rotatable_radius", getblackholecenter(var_0) - var_2 * 64 * 0.5, 0, 200, 64);
  var_3.angles = var_0.angles;
  var_3 enablelinkto();
  var_3 linkto(var_0);
  var_3 thread cleanuponparentdeath(var_0);
  while(isDefined(var_3)) {
    var_3 waittill("trigger", var_4);
    if(!scripts\cp\utility::isreallyalive(var_4) || !isDefined(var_0.triggerportableradarping)) {
      continue;
    }

    if(isplayer(var_4)) {
      continue;
    }

    if(isDefined(var_4.team) && var_4.team == "allies") {
      continue;
    }

    if(var_0.triggerportableradarping == var_4) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(var_0, var_4)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_4) || isDefined(var_4.flung)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.not_affected_by_traps)) {
      continue;
    }

    if(!isalive(var_4)) {
      continue;
    }

    if(!var_4 isgrabbedent(var_0)) {
      var_4 thread grabent(var_0);
      var_4.flung = 1;
      var_4 thread suck_zombie(var_4, var_0, var_1);
      wait(0.2);
    }
  }
}

suck_zombie(var_0, var_1, var_2) {
  self endon("death");
  var_1 endon("death");
  thread killzombieongrenadedeath(var_1);
  if(scripts\engine\utility::istrue(var_2)) {
    var_3 = var_1.origin;
  } else {
    var_3 = var_2.origin + (0, 0, 32);
  }

  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_4 = 22500;
  while(distancesquared(self.origin, var_1.origin) > var_4) {
    self setvelocity(vectornormalize(var_1.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  var_5 = 2304;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor moveto(var_3, 0.5);
  wait(0.5);
  if(soundexists("trap_blackhole_body_gore")) {
    playsoundatpos(self.origin, "trap_blackhole_body_gore");
  }

  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  self dodamage(self.health + 1000, var_1.origin, var_1.triggerportableradarping, var_1, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
}

killzombieongrenadedeath(var_0) {
  self endon("death");
  var_1 = var_0.origin;
  var_2 = var_0.triggerportableradarping;
  var_0 waittill("death");
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self dodamage(self.health + 1000, var_1, var_2, var_2, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
}

func_13A58(var_0) {
  var_0 endon("death");
  var_0.var_11AD2 = [];
  var_1 = anglestoup(var_0.angles);
  var_2 = spawn("trigger_rotatable_radius", getblackholecenter(var_0) - var_1 * 64 * 0.5, 0, 64, 64);
  var_2.angles = var_0.angles;
  var_2 enablelinkto();
  var_2 linkto(var_0);
  var_2 thread cleanuponparentdeath(var_0);
  while(isDefined(var_2)) {
    var_2 waittill("trigger", var_3);
    if(!scripts\cp\utility::isreallyalive(var_3) || !isDefined(var_0.triggerportableradarping)) {
      continue;
    }

    if(var_0.triggerportableradarping == var_3) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(var_0, var_3)) {
      continue;
    }

    if(!var_3 func_9FAF(var_0)) {
      var_3 thread func_11AD5(var_0);
      var_3 dodamage(int(0.34 * var_3.maxhealth), var_0.origin, var_0.triggerportableradarping, var_0, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
    }
  }
}

func_13A55(var_0) {
  var_0 endon("death");
  self waittill("disconnect");
  var_0 delete();
}

func_10834(var_0, var_1, var_2) {
  var_0 hide(1);
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setotherent(var_0.triggerportableradarping);
  var_3 setentityowner(var_0.triggerportableradarping);
  var_3 setModel("black_hole_projector_wm");
  var_3 linkto(var_0);
  var_3.objective_position = var_0;
  var_3.triggerportableradarping = var_0.triggerportableradarping;
  var_3 thread cleanuponparentdeath(var_0);
  var_3 thread func_13A5E();
  return var_3;
}

func_10835(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setotherent(var_0.triggerportableradarping);
  var_3 setentityowner(var_0);
  var_3 setModel("prop_mp_black_hole_grenade_scr");
  var_3 linkto(var_0);
  var_3 thread func_4116(var_0);
  return var_3;
}

func_13A5E() {
  scripts\cp\cp_weapon::monitordamage(38, "blackhole", ::func_DA65, ::func_DA66, 0);
}

func_DA65(var_0, var_1, var_2, var_3) {
  if(isDefined(self.triggerportableradarping) && var_0 != self.triggerportableradarping) {
    var_0 notify("destroyed_equipment");
  }

  playsoundatpos(self.objective_position.origin, "mp_killstreak_disappear");
  self.objective_position delete();
  self notify("detonateExplosive");
}

func_DA66(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  if(scripts\cp\powers\coop_phaseshift::isentityphaseshifted(var_0)) {
    return 0;
  }

  return var_5;
}

func_4116(var_0) {
  var_0 waittill("death");
  self setscriptablepartstate("vortexStart", "neutral", 0);
  self setscriptablepartstate("vortexUpdate", "neutral", 0);
  self setscriptablepartstate("vortexEnd", "active", 0);
  wait(2);
  self delete();
}

spawnblackholephysicsvolume(var_0, var_1, var_2, var_3) {
  var_4 = physics_volumecreate(var_1, 200);
  var_4.angles = var_2;
  var_4 linkto(var_0);
  var_4 physics_volumesetasfocalforce(1, var_1, var_3);
  var_4 physics_volumeenable(1);
  var_4 physics_volumesetactivator(1);
  var_4.time = gettime();
  var_4.var_720E = var_3;
  level.var_2ABC scripts\engine\utility::array_removeundefined(level.var_2ABC);
  var_5 = undefined;
  var_6 = 0;
  for(var_7 = 0; var_7 < 7; var_7++) {
    var_8 = level.var_2ABC[var_7];
    if(!isDefined(var_8)) {
      var_6 = var_7;
      break;
    } else if(!isDefined(var_5) || isDefined(var_5) && var_5.time > var_8.time) {
      var_5 = var_8;
      var_6 = var_7;
    }
  }

  if(isDefined(var_5)) {
    var_5 delete();
  }

  level.var_2ABC[var_6] = var_4;
  var_4 thread func_139AD();
  var_4 thread cleanuponparentdeath(var_0);
}

func_139AD() {
  self endon("death");
  var_0 = self.origin;
  for(;;) {
    if(var_0 != self.origin) {
      self physics_volumesetasfocalforce(1, self.origin, self.var_720E);
      var_0 = self.origin;
    }

    wait(0.1);
  }
}

func_10831(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnimpulsefield(var_3, var_4, var_1);
  var_5.angles = var_2;
  var_5 linkto(var_0);
  var_5 thread cleanuponparentdeath(var_0);
}

createkillcam(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 setscriptmoverkillcam("explosive");
  var_1 linkto(var_0);
  var_1 thread cleanuponparentdeath(var_0);
  return var_1;
}

func_CB0C() {
  var_0 = spawnStruct();
  func_CB0D(var_0);
  physicsexplosionsphere(var_0.pos, 100, 0, 200);
}

func_CB0D(var_0) {
  self endon("death");
  for(;;) {
    var_0.pos = self.origin;
    scripts\engine\utility::waitframe();
  }
}

cleanuponparentdeath(var_0, var_1) {
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

placementfailed(var_0) {
  self notify("powers_blackholeGrenade_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
  var_0 delete();
}

isgrabbedent(var_0) {
  return isDefined(var_0.grabbedents[self getentitynumber()]);
}

func_9FAF(var_0) {
  return isDefined(var_0.var_11AD2[self getentitynumber()]);
}

grabent(var_0) {
  var_0 endon("death");
  var_1 = self getentitynumber();
  var_0.grabbedents[var_1] = self;
  grabentstall();
  var_0.grabbedents[var_1] = undefined;
}

func_11AD5(var_0) {
  var_0 endon("death");
  var_1 = self getentitynumber();
  var_0.var_11AD2[var_1] = self;
  func_11AD6();
  var_0.var_11AD2[var_1] = undefined;
}

grabentstall() {
  self endon("death");
  self endon("disconnect");
  wait(0.75);
}

func_11AD6() {
  self endon("death");
  self endon("disconnect");
  wait(0.75);
}

func_B777(var_0) {
  self notify("powers_blackholeGrenade_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
}

getblackholecenter(var_0) {
  return var_0.origin + anglestoup(var_0.angles) * 55;
}