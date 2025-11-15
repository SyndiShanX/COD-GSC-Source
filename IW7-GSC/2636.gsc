/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2636.gsc
***************************************/

init() {
  level.bhgunphysicsvolumes = [];
}

beginuse() {
  return 1;
}

stopuse() {}

missilespawned(var_00, var_01) {
  self endon("disconnect");
  var_02 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
  var_03 = var_1.origin;
  var_04 = anglesToForward(var_1.angles);
  var_05 = var_03 + var_04 * 1920.0;
  var_06 = physics_raycast(var_03, var_05, var_02, var_01, 1, "physicsquery_closest");
  var_07 = isDefined(var_06) && var_6.size > 0;

  if(var_07) {
    var_08 = var_6[0]["position"];
    var_09 = distance(var_08, var_03);
    var_10 = vectornormalize(var_03 - var_08);
    var_11 = var_08 + var_10 * 80.0;
  } else {
    var_09 = 1920.0;
    var_10 = anglesToForward(var_1.angles);
    var_11 = var_05;
    var_08 = undefined;
  }

  var_12 = distance(var_11, var_03);

  if(var_12 < 90) {
    var_13 = 1;
    wait 0.3;

    if(isDefined(var_01)) {
      var_01 delete();
      return;
    }
  } else {
    var_14 = max(var_12 / 980.0, 1.05);
    var_15 = spawn("script_model", var_03);
    var_15 setModel("prop_mp_super_blackholegun_projectile");
    var_15 setotherent(self);
    var_15 moveto(var_11, var_14, 0.1, 0.95);
    var_15.owner = var_1.owner;
    var_15 setscriptmoverkillcam("rocket");
    var_16 = var_15.owner scripts\cp\utility::_launchgrenade("blackholegun_indicator_zm", self.origin, (0, 0, 0));
    var_16.weapon_name = "blackholegun_indicator_zm";
    var_16 linkto(var_15);
    var_15 thread monitorprojectilearrive(var_14, self, var_16, var_02);
    var_1.owner thread scripts\cp\powers\coop_blackholegrenade::grabclosestzombies(var_15, 1);
    var_15 setscriptablepartstate("projectile", "on", 0);
    waittillframeend;
    var_01 delete();
  }
}

monitorprojectilearrive(var_00, var_01, var_02, var_03) {
  self endon("blackhole_projectile_impact");
  self endon("death");
  thread projectiledisconnectwatcher(var_01, var_02);
  wait(var_00);
  self notify("blackhole_projectile_arrive");
  thread projectilearrived(var_02, var_03);
}

projectilearrived(var_00, var_01) {
  self endon("death");
  self notify("projectile_arrived");
  cleanupprojectile();
  var_02 = physics_raycast(self.origin, self.origin - (0, 0, 42), var_01, undefined, 1, "physicsquery_closest");
  var_03 = isDefined(var_02) && var_2.size > 0;

  if(var_03) {
    var_04 = var_2[0]["position"];
    self.origin = var_04 + (0, 0, 42);
  }

  var_05 = undefined;
  var_06 = undefined;
  self setscriptablepartstate("singularity", "singularity", 0);
  thread watchforincidentalplayerdamage(var_05);
  thread singularityquake();
  wait 3.0;
  thread singularityexplode(self.owner, var_05, var_06, var_00);
}

ownerdisconnectcleanup(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self delete();
}

makeblackholeimpulsefield(var_00) {
  var_01 = _spawnimpulsefield(self.owner, "bhgunfield_mp", self.origin);
  var_01 linkto(self);
  return var_01;
}

singularityquake() {
  self endon("death");
  var_00 = 0.6;
  var_01 = 0.0466;

  for(var_02 = 0; var_02 < 5; var_2++) {
    earthquake((var_02 + 1) * var_01, var_00 * 2, self.origin, 800);
    wait(var_00);
  }
}

trydodamage(var_00, var_01, var_02, var_03) {
  var_04 = physics_raycast(self.origin, var_01, var_03, self, 0, "physicsquery_closest");
  var_05 = !(isDefined(var_04) && var_4.size > 0);

  if(var_05)
    var_00 getrandomarmkillstreak(var_02, self.origin, self.owner, self, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
}

watchforincidentalplayerdamage(var_00) {
  self endon("death");
  self endon("blackhole_die");
  self.owner endon("disconnect");
  var_01 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_02 = 5898.24;

  for(;;) {
    foreach(var_04 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
      if(!isDefined(var_04)) {
        continue;
      }
      if(!scripts\cp\utility::isreallyalive(var_04)) {
        continue;
      }
      if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(self, var_04)) {
        continue;
      }
      if(!level.friendlyfire && var_04 != self.owner && var_4.team != self.owner.team) {
        continue;
      }
      if(distancesquared(var_04 getEye(), self.origin) > var_02) {
        continue;
      }
      trydodamage(var_04, var_04 getEye(), 1200, var_01);
    }

    wait 0.2;
  }
}

watchfordirectplayerdamage(var_00, var_01) {
  self endon("death");
  self endon("blackhole_projectile_arrive");
  self.owner endon("disconnect");
  wait 0.1;
  var_02 = spawn("trigger_radius", self.origin - (0, 0, 32), 0, 24, 64);
  var_02 getrankxp();
  var_02 linkto(self);
  var_02 thread cleanuptrigger(self);

  for(;;) {
    var_02 waittill("trigger", var_03);

    if(var_03 == self.owner) {
      continue;
    }
    if(!isplayer(var_03) && !isagent(var_03)) {
      continue;
    }
    if(!scripts\cp\utility::isreallyalive(var_03)) {
      continue;
    }
    if(!scripts\cp\powers\coop_phaseshift::areentitiesinphase(self, var_03)) {
      continue;
    }
    var_04 = var_03;

    if(!level.friendlyfire && var_04 != self.owner && var_4.team != self.owner.team) {
      continue;
    }
    self notify("blackhole_projectile_impact");
    var_03 getrandomarmkillstreak(var_3.maxhealth, self.origin, self.owner, self, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
    self moveto(self.origin, 0.05, 0, 0);
    thread projectilearrived(var_00, var_01);
    break;
  }
}

singularityexplode(var_00, var_01, var_02, var_03) {
  self setscriptablepartstate("singularity", "explosion", 0);
  self radiusdamage(self.origin, 150, 2000, 500, self.owner, "MOD_EXPLOSIVE", "iw7_blackholegun_mp");
  self notify("singularity_explode");
  self notify("blackhole_die");
  thread cleanupsingularity(var_01, var_02, var_03);
}

spawnblackholephysicsvolume(var_00) {
  var_01 = _physics_volumecreate(self.origin, 384.0);
  var_01 physics_volumesetasfocalforce(1, self.origin, var_00);
  var_01 physics_volumeenable(1);
  var_1.time = gettime();
  level.bhgunphysicsvolumes scripts\engine\utility::array_removeundefined(level.bhgunphysicsvolumes);
  var_02 = undefined;
  var_03 = 0;

  for(var_04 = 0; var_04 < 3; var_4++) {
    var_05 = level.bhgunphysicsvolumes[var_04];

    if(!isDefined(var_05)) {
      var_03 = var_04;
      break;
    } else if(!isDefined(var_02) || isDefined(var_02) && var_2.time > var_5.time) {
      var_02 = var_05;
      var_03 = var_04;
    }
  }

  if(isDefined(var_02))
    var_02 delete();

  level.bhgunphysicsvolumes[var_03] = var_01;
  var_01 thread blackholephysicsvolumeactivate();
  return var_01;
}

blackholephysicsvolumeactivate() {
  self endon("death");
  self physics_volumesetactivator(1);
  scripts\engine\utility::waitframe();
  self physics_volumesetactivator(0);
}

cleanuptrigger(var_00) {
  var_00 scripts\engine\utility::waittill_any("death", "blackhole_projectile_arrive", "blackhole_projectile_impact");
  self delete();
}

cleanupsingularity(var_00, var_01, var_02) {
  if(isDefined(var_01))
    var_01 delete();

  if(isDefined(var_00))
    var_00 delete();

  if(isDefined(var_02))
    var_02 delete();

  self setscriptablepartstate("singularity", "off", 0);
  self delete();
}

projectiledisconnectwatcher(var_00, var_01) {
  self endon("death");
  self endon("projectile_arrived");
  var_00 waittill("disconnect");
  cleanupprojectile();

  if(isDefined(var_01))
    var_01 delete();

  self delete();
}

cleanupprojectile() {
  self setscriptablepartstate("projectile", "off", 0);
}

singularitydisconnectwatcher(var_00, var_01, var_02, var_03) {
  self endon("death");
  var_01 waittill("disconnect");
  thread cleanupsingularity(var_00, var_02, var_03);
}