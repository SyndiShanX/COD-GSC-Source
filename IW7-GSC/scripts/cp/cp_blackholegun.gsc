/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\cp_blackholegun.gsc
*********************************************/

init() {
  level.bhgunphysicsvolumes = [];
}

beginuse() {
  return 1;
}

stopuse() {}

missilespawned(var_0, var_1) {
  self endon("disconnect");
  var_2 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
  var_3 = var_1.origin;
  var_4 = anglesToForward(var_1.angles);
  var_5 = var_3 + var_4 * 1920;
  var_6 = physics_raycast(var_3, var_5, var_2, var_1, 1, "physicsquery_closest");
  var_7 = isDefined(var_6) && var_6.size > 0;
  if(var_7) {
    var_8 = var_6[0]["position"];
    var_9 = distance(var_8, var_3);
    var_10 = vectornormalize(var_3 - var_8);
    var_11 = var_8 + var_10 * 80;
  } else {
    var_9 = 1920;
    var_10 = anglesToForward(var_3.angles);
    var_11 = var_6;
    var_8 = undefined;
  }

  var_12 = distance(var_11, var_3);
  if(var_12 < 90) {
    var_13 = 1;
    wait(0.3);
    if(isDefined(var_1)) {
      var_1 delete();
      return;
    }

    return;
  }

  var_14 = max(var_12 / 980, 1.05);
  var_15 = spawn("script_model", var_3);
  var_15 setModel("prop_mp_super_blackholegun_projectile");
  var_15 setotherent(self);
  var_15 moveto(var_11, var_14, 0.1, 0.95);
  var_15.owner = var_1.owner;
  var_15 setscriptmoverkillcam("rocket");
  var_10 = var_15.owner scripts\cp\utility::_launchgrenade("blackholegun_indicator_zm", self.origin, (0, 0, 0));
  var_10.weapon_name = "blackholegun_indicator_zm";
  var_10 linkto(var_15);
  var_15 thread monitorprojectilearrive(var_14, self, var_10, var_2);
  var_1.owner thread scripts\cp\powers\coop_blackholegrenade::grabclosestzombies(var_15, 1);
  var_15 setscriptablepartstate("projectile", "on", 0);
  waittillframeend;
  var_1 delete();
}

monitorprojectilearrive(var_0, var_1, var_2, var_3) {
  self endon("blackhole_projectile_impact");
  self endon("death");
  thread projectiledisconnectwatcher(var_1, var_2);
  wait(var_0);
  self notify("blackhole_projectile_arrive");
  thread projectilearrived(var_2, var_3);
}

projectilearrived(var_0, var_1) {
  self endon("death");
  self notify("projectile_arrived");
  cleanupprojectile();
  var_2 = physics_raycast(self.origin, self.origin - (0, 0, 42), var_1, undefined, 1, "physicsquery_closest");
  var_3 = isDefined(var_2) && var_2.size > 0;
  if(var_3) {
    var_4 = var_2[0]["position"];
    self.origin = var_4 + (0, 0, 42);
  }

  var_5 = undefined;
  var_6 = undefined;
  self setscriptablepartstate("singularity", "singularity", 0);
  thread watchforincidentalplayerdamage(var_5);
  thread singularityquake();
  wait(3);
  thread singularityexplode(self.owner, var_5, var_6, var_0);
}

ownerdisconnectcleanup(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

makeblackholeimpulsefield(var_0) {
  var_1 = spawnimpulsefield(self.owner, "bhgunfield_mp", self.origin);
  var_1 linkto(self);
  return var_1;
}

singularityquake() {
  self endon("death");
  var_0 = 0.6;
  var_1 = 0.0466;
  for(var_2 = 0; var_2 < 5; var_2++) {
    earthquake(var_2 + 1 * var_1, var_0 * 2, self.origin, 800);
    wait(var_0);
  }
}

trydodamage(var_0, var_1, var_2, var_3) {
  var_4 = physics_raycast(self.origin, var_1, var_3, self, 0, "physicsquery_closest");
  var_5 = !isDefined(var_4) && var_4.size > 0;
  if(var_5) {
    var_0 dodamage(var_2, self.origin, self.owner, self, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
  }
}

watchforincidentalplayerdamage(var_0) {
  self endon("death");
  self endon("blackhole_die");
  self.owner endon("disconnect");
  var_1 = scripts\common\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_2 = 5898.24;
  for(;;) {
    foreach(var_4 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(!scripts\cp\utility::isreallyalive(var_4)) {
        continue;
      }

      if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(self, var_4)) {
        continue;
      }

      if(!level.friendlyfire && var_4 != self.owner && var_4.team != self.owner.team) {
        continue;
      }

      if(distancesquared(var_4 getEye(), self.origin) > var_2) {
        continue;
      }

      trydodamage(var_4, var_4 getEye(), 1200, var_1);
    }

    wait(0.2);
  }
}

watchfordirectplayerdamage(var_0, var_1) {
  self endon("death");
  self endon("blackhole_projectile_arrive");
  self.owner endon("disconnect");
  wait(0.1);
  var_2 = spawn("trigger_radius", self.origin - (0, 0, 32), 0, 24, 64);
  var_2 enablelinkto();
  var_2 linkto(self);
  var_2 thread cleanuptrigger(self);
  for(;;) {
    var_2 waittill("trigger", var_3);
    if(var_3 == self.owner) {
      continue;
    }

    if(!isplayer(var_3) && !isagent(var_3)) {
      continue;
    }

    if(!scripts\cp\utility::isreallyalive(var_3)) {
      continue;
    }

    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(self, var_3)) {
      continue;
    }

    var_4 = var_3;
    if(!level.friendlyfire && var_4 != self.owner && var_4.team != self.owner.team) {
      continue;
    }

    self notify("blackhole_projectile_impact");
    var_3 dodamage(var_3.maxhealth, self.origin, self.owner, self, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
    self moveto(self.origin, 0.05, 0, 0);
    thread projectilearrived(var_0, var_1);
    break;
  }
}

singularityexplode(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("singularity", "explosion", 0);
  self radiusdamage(self.origin, 150, 2000, 500, self.owner, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
  self notify("singularity_explode");
  self notify("blackhole_die");
  thread cleanupsingularity(var_1, var_2, var_3);
}

spawnblackholephysicsvolume(var_0) {
  var_1 = physics_volumecreate(self.origin, 384);
  var_1 physics_volumesetasfocalforce(1, self.origin, var_0);
  var_1 physics_volumeenable(1);
  var_1.time = gettime();
  level.bhgunphysicsvolumes scripts\engine\utility::array_removeundefined(level.bhgunphysicsvolumes);
  var_2 = undefined;
  var_3 = 0;
  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = level.bhgunphysicsvolumes[var_4];
    if(!isDefined(var_5)) {
      var_3 = var_4;
      break;
    } else if(!isDefined(var_2) || isDefined(var_2) && var_2.time > var_5.time) {
      var_2 = var_5;
      var_3 = var_4;
    }
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  level.bhgunphysicsvolumes[var_3] = var_1;
  var_1 thread blackholephysicsvolumeactivate();
  return var_1;
}

blackholephysicsvolumeactivate() {
  self endon("death");
  self physics_volumesetactivator(1);
  scripts\engine\utility::waitframe();
  self physics_volumesetactivator(0);
}

cleanuptrigger(var_0) {
  var_0 scripts\engine\utility::waittill_any("death", "blackhole_projectile_arrive", "blackhole_projectile_impact");
  self delete();
}

cleanupsingularity(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  self setscriptablepartstate("singularity", "off", 0);
  self delete();
}

projectiledisconnectwatcher(var_0, var_1) {
  self endon("death");
  self endon("projectile_arrived");
  var_0 waittill("disconnect");
  cleanupprojectile();
  if(isDefined(var_1)) {
    var_1 delete();
  }

  self delete();
}

cleanupprojectile() {
  self setscriptablepartstate("projectile", "off", 0);
}

singularitydisconnectwatcher(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 waittill("disconnect");
  thread cleanupsingularity(var_0, var_2, var_3);
}