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

blackholegrenadeused(param_00, param_01) {
  param_00 endon("death");
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = createkillcam(param_00);
  param_00.killcament = var_02;
  thread func_13A55(param_00);
  param_00.state = 0;
  thread func_12EB1(param_00, var_02, param_01);
  if(!param_01) {
    param_00 waittill("blackhole_grenade_stuck");
    if(!isDefined(param_00)) {
      return;
    }
  }

  param_00.state = 1;
  thread func_12F29(param_00);
  param_00 waittill("blackhole_grenade_active");
  if(!isDefined(param_00)) {
    return;
  }

  param_00.state = 2;
  thread func_12E56(param_00);
  param_00 waittill("blackhole_grenade_finished");
  if(!isDefined(param_00)) {}
}

func_2B3E(param_00) {
  param_00 endon("death");
  thread func_13A55(param_00);
  var_01 = spawn("script_model", param_00.origin);
  var_01 setotherent(param_00.triggerportableradarping);
  var_01 setModel("prop_mp_black_hole_grenade_scr");
  var_01 give_player_tickets(1);
  var_01 linkto(param_00, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_01 thread func_4116(param_00);
  param_00.physics_capsulecast = var_01;
  var_02 = getblackholecenter(param_00);
  thread func_13A58(param_00);
  param_00.physics_capsulecast setscriptablepartstate("vortexUpdate", "active_cp", 0);
  param_00 thread func_CB0C();
  var_03 = 10;
  wait(var_03);
  param_00 delete();
}

func_12EB1(param_00, param_01, param_02) {
  self endon("disconnect");
  param_00 endon("death");
  if(!param_02) {
    param_00 waittill("missile_stuck", var_03);
  }

  if(param_00 checkvalidposition(self)) {
    self notify("powers_blackholeGrenade_used", 1);
    playsoundatpos(param_00.origin, "blackhole_plant");
    var_04 = func_10834(param_00, param_00.origin, param_00.angles);
    param_00.var_DA64 = var_04;
    var_05 = getblackholecenter(param_00);
    var_06 = func_10835(param_00, var_05, param_00.angles);
    param_00.physics_capsulecast = var_06;
    param_01 unlink();
    param_01.origin = var_05;
    param_01.angles = param_00.angles;
    param_01 linkto(param_00);
    param_01 thread cleanuponparentdeath(var_06, 10);
    param_00 notify("blackhole_grenade_stuck");
    return;
  }

  thread placementfailed(var_04);
}

checkvalidposition(param_00) {
  if(!isDefined(self)) {
    return 0;
  }

  var_01 = param_00 findpath(param_00.origin, self.origin);
  if(var_01.size < 1) {
    return 0;
  } else if(distance(var_01[var_01.size - 1], self.origin) >= 12) {
    return 0;
  }

  var_02 = getclosestpointonnavmesh(self.origin);
  if(!isDefined(var_02)) {
    return 0;
  }

  if(distance(self.origin, var_02) > 18) {
    return 0;
  }

  if(isDefined(level.active_volume_check)) {
    if(!self[[level.active_volume_check]](var_02)) {
      return 0;
    }
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(self.origin, level.invalid_spawn_volume_array, param_00, undefined, 1)) {
    return 0;
  }

  if(positionwouldtelefrag(self.origin)) {
    return 0;
  }

  return 1;
}

func_12F29(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  param_00.var_DA64 setscriptablepartstate("beam", "active", 0);
  param_00.physics_capsulecast setscriptablepartstate("vortexStart", "active", 0);
  var_01 = 1.2;
  wait(var_01);
  param_00 notify("blackhole_grenade_active");
}

func_12E56(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  var_01 = getblackholecenter(param_00);
  thread grabclosestzombies(param_00);
  param_00.physics_capsulecast setscriptablepartstate("vortexUpdate", "active_cp", 0);
  param_00 thread func_CB0C();
  var_02 = 10;
  wait(var_02);
  param_00 delete();
}

grabclosestzombies(param_00, param_01) {
  param_00 endon("death");
  param_00.grabbedents = [];
  var_02 = anglestoup(param_00.angles);
  var_03 = spawn("trigger_rotatable_radius", getblackholecenter(param_00) - var_02 * 64 * 0.5, 0, 200, 64);
  var_03.angles = param_00.angles;
  var_03 enablelinkto();
  var_03 linkto(param_00);
  var_03 thread cleanuponparentdeath(param_00);
  while(isDefined(var_03)) {
    var_03 waittill("trigger", var_04);
    if(!scripts\cp\utility::isreallyalive(var_04) || !isDefined(param_00.triggerportableradarping)) {
      continue;
    }

    if(isplayer(var_04)) {
      continue;
    }

    if(isDefined(var_04.team) && var_04.team == "allies") {
      continue;
    }

    if(param_00.triggerportableradarping == var_04) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(param_00, var_04)) {
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_04) || isDefined(var_04.flung)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_04.not_affected_by_traps)) {
      continue;
    }

    if(!isalive(var_04)) {
      continue;
    }

    if(!var_04 isgrabbedent(param_00)) {
      var_04 thread grabent(param_00);
      var_04.flung = 1;
      var_04 thread suck_zombie(var_04, param_00, param_01);
      wait(0.2);
    }
  }
}

suck_zombie(param_00, param_01, param_02) {
  self endon("death");
  param_01 endon("death");
  thread killzombieongrenadedeath(param_01);
  if(scripts\engine\utility::istrue(param_02)) {
    var_03 = param_01.origin;
  } else {
    var_03 = param_02.origin + (0, 0, 32);
  }

  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_04 = 22500;
  while(distancesquared(self.origin, param_01.origin) > var_04) {
    self setvelocity(vectornormalize(param_01.origin - self.origin) * 150 + (0, 0, 30));
    wait(0.05);
  }

  var_05 = 2304;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor moveto(var_03, 0.5);
  wait(0.5);
  if(soundexists("trap_blackhole_body_gore")) {
    playsoundatpos(self.origin, "trap_blackhole_body_gore");
  }

  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.anchor delete();
  self.disable_armor = 1;
  self dodamage(self.health + 1000, param_01.origin, param_01.triggerportableradarping, param_01, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
}

killzombieongrenadedeath(param_00) {
  self endon("death");
  var_01 = param_00.origin;
  var_02 = param_00.triggerportableradarping;
  param_00 waittill("death");
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self dodamage(self.health + 1000, var_01, var_02, var_02, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
}

func_13A58(param_00) {
  param_00 endon("death");
  param_00.var_11AD2 = [];
  var_01 = anglestoup(param_00.angles);
  var_02 = spawn("trigger_rotatable_radius", getblackholecenter(param_00) - var_01 * 64 * 0.5, 0, 64, 64);
  var_02.angles = param_00.angles;
  var_02 enablelinkto();
  var_02 linkto(param_00);
  var_02 thread cleanuponparentdeath(param_00);
  while(isDefined(var_02)) {
    var_02 waittill("trigger", var_03);
    if(!scripts\cp\utility::isreallyalive(var_03) || !isDefined(param_00.triggerportableradarping)) {
      continue;
    }

    if(param_00.triggerportableradarping == var_03) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(param_00, var_03)) {
      continue;
    }

    if(!var_03 func_9FAF(param_00)) {
      var_03 thread func_11AD5(param_00);
      var_03 dodamage(int(0.34 * var_03.maxhealth), param_00.origin, param_00.triggerportableradarping, param_00, "MOD_EXPLOSIVE", "blackhole_grenade_mp");
    }
  }
}

func_13A55(param_00) {
  param_00 endon("death");
  self waittill("disconnect");
  param_00 delete();
}

func_10834(param_00, param_01, param_02) {
  param_00 hide(1);
  var_03 = spawn("script_model", param_01);
  var_03.angles = param_02;
  var_03 setotherent(param_00.triggerportableradarping);
  var_03 setentityowner(param_00.triggerportableradarping);
  var_03 setModel("black_hole_projector_wm");
  var_03 linkto(param_00);
  var_03.objective_position = param_00;
  var_03.triggerportableradarping = param_00.triggerportableradarping;
  var_03 thread cleanuponparentdeath(param_00);
  var_03 thread func_13A5E();
  return var_03;
}

func_10835(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01);
  var_03.angles = param_02;
  var_03 setotherent(param_00.triggerportableradarping);
  var_03 setentityowner(param_00);
  var_03 setModel("prop_mp_black_hole_grenade_scr");
  var_03 linkto(param_00);
  var_03 thread func_4116(param_00);
  return var_03;
}

func_13A5E() {
  scripts\cp\cp_weapon::monitordamage(38, "blackhole", ::func_DA65, ::func_DA66, 0);
}

func_DA65(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 notify("destroyed_equipment");
  }

  playsoundatpos(self.objective_position.origin, "mp_killstreak_disappear");
  self.objective_position delete();
  self notify("detonateExplosive");
}

func_DA66(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  if(scripts\cp\powers\coop_phaseshift::isentityphaseshifted(param_00)) {
    return 0;
  }

  return var_05;
}

func_4116(param_00) {
  param_00 waittill("death");
  self setscriptablepartstate("vortexStart", "neutral", 0);
  self setscriptablepartstate("vortexUpdate", "neutral", 0);
  self setscriptablepartstate("vortexEnd", "active", 0);
  wait(2);
  self delete();
}

spawnblackholephysicsvolume(param_00, param_01, param_02, param_03) {
  var_04 = physics_volumecreate(param_01, 200);
  var_04.angles = param_02;
  var_04 linkto(param_00);
  var_04 physics_volumesetasfocalforce(1, param_01, param_03);
  var_04 physics_volumeenable(1);
  var_04 physics_volumesetactivator(1);
  var_04.time = gettime();
  var_04.var_720E = param_03;
  level.var_2ABC scripts\engine\utility::array_removeundefined(level.var_2ABC);
  var_05 = undefined;
  var_06 = 0;
  for(var_07 = 0; var_07 < 7; var_07++) {
    var_08 = level.var_2ABC[var_07];
    if(!isDefined(var_08)) {
      var_06 = var_07;
      break;
    } else if(!isDefined(var_05) || isDefined(var_05) && var_05.time > var_08.time) {
      var_05 = var_08;
      var_06 = var_07;
    }
  }

  if(isDefined(var_05)) {
    var_05 delete();
  }

  level.var_2ABC[var_06] = var_04;
  var_04 thread func_139AD();
  var_04 thread cleanuponparentdeath(param_00);
}

func_139AD() {
  self endon("death");
  var_00 = self.origin;
  for(;;) {
    if(var_00 != self.origin) {
      self physics_volumesetasfocalforce(1, self.origin, self.var_720E);
      var_00 = self.origin;
    }

    wait(0.1);
  }
}

func_10831(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnimpulsefield(param_03, param_04, param_01);
  var_05.angles = param_02;
  var_05 linkto(param_00);
  var_05 thread cleanuponparentdeath(param_00);
}

createkillcam(param_00) {
  var_01 = spawn("script_model", param_00.origin);
  var_01 setModel("tag_origin");
  var_01 setscriptmoverkillcam("explosive");
  var_01 linkto(param_00);
  var_01 thread cleanuponparentdeath(param_00);
  return var_01;
}

func_CB0C() {
  var_00 = spawnStruct();
  func_CB0D(var_00);
  physicsexplosionsphere(var_00.pos, 100, 0, 200);
}

func_CB0D(param_00) {
  self endon("death");
  for(;;) {
    param_00.pos = self.origin;
    scripts\engine\utility::waitframe();
  }
}

cleanuponparentdeath(param_00, param_01) {
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

placementfailed(param_00) {
  self notify("powers_blackholeGrenade_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(param_00.weapon_name, 1, param_00.origin);
  param_00 delete();
}

isgrabbedent(param_00) {
  return isDefined(param_00.grabbedents[self getentitynumber()]);
}

func_9FAF(param_00) {
  return isDefined(param_00.var_11AD2[self getentitynumber()]);
}

grabent(param_00) {
  param_00 endon("death");
  var_01 = self getentitynumber();
  param_00.grabbedents[var_01] = self;
  grabentstall();
  param_00.grabbedents[var_01] = undefined;
}

func_11AD5(param_00) {
  param_00 endon("death");
  var_01 = self getentitynumber();
  param_00.var_11AD2[var_01] = self;
  func_11AD6();
  param_00.var_11AD2[var_01] = undefined;
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

func_B777(param_00) {
  self notify("powers_blackholeGrenade_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(param_00.weapon_name, 1, param_00.origin);
}

getblackholecenter(param_00) {
  return param_00.origin + anglestoup(param_00.angles) * 55;
}