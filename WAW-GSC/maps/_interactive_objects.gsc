/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_interactive_objects.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;

main() {
  flag_init("no_ai_tv_damage");
  qBarrels = false;
  barrels = getEntArray("explodable_barrel", "targetname");
  if((isDefined(barrels)) && (barrels.size > 0)) {
    qBarrels = true;
  }
  barrels = getEntArray("explodable_barrel", "script_noteworthy");
  if((isDefined(barrels)) && (barrels.size > 0)) {
    qBarrels = true;
  }
  if(qBarrels) {
    PrecacheRumble("barrel_explosion");
    level.breakables_fx["barrel"]["explode"] = loadfx("destructibles/fx_barrelExp");
    level.breakables_fx["barrel"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["barrel"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qCrates = false;
  crates = getEntArray("flammable_crate", "targetname");
  if((isDefined(crates)) && (crates.size > 0)) {
    qCrates = true;
  }
  crates = getEntArray("flammable_crate", "script_noteworthy");
  if((isDefined(crates)) && (crates.size > 0)) {
    qCrates = true;
  }
  if(qCrates) {
    level.breakables_fx["ammo_crate"]["explode"] = loadfx("destructibles/fx_ammoboxExp");
  }

  qBagofbarrels = false;
  bagofbarrels = getEntArray("explodable_bagofbarrels", "targetname");
  if((isDefined(bagofbarrels)) && (bagofbarrels.size > 0)) {
    qBagofbarrels = true;
  }
  bagofbarrels = getEntArray("explodable_bagofbarrels", "script_noteworthy");
  if((isDefined(bagofbarrels)) && (bagofbarrels.size > 0)) {
    qBagofbarrels = true;
  }
  if(qBagofbarrels) {
    level.breakables_fx["bagofbarrels"]["explode"] = loadfx("maps/fly/fx_exp_bagobarrels");
    level.breakables_fx["bagofbarrels"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["bagofbarrels"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qBagofcrates = false;
  bagofcrates = getEntArray("explodable_bagofcrates", "targetname");
  if((isDefined(bagofcrates)) && (bagofcrates.size > 0)) {
    qBagofcrates = true;
  }
  bagofcrates = getEntArray("explodable_bagofcrates", "script_noteworthy");
  if((isDefined(bagofcrates)) && (bagofcrates.size > 0)) {
    qBagofcrates = true;
  }
  if(qBagofcrates) {
    level.breakables_fx["bagofcrates"]["explode"] = loadfx("maps/fly/fx_exp_bagocrates");
    level.breakables_fx["bagofcrates"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["bagofcrates"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qOiltank = false;
  oiltanks = getEntArray("explodable_oiltank", "targetname");
  if((isDefined(oiltanks)) && (oiltanks.size > 0)) {
    qOiltank = true;
  }
  oiltanks = getEntArray("explodable_oiltank", "script_noteworthy");
  if((isDefined(oiltanks)) && (oiltanks.size > 0)) {
    qOiltank = true;
  }
  if(qOiltank) {
    level.breakables_fx["oiltank"]["explode"] = loadfx("maps/fly/fx_exp_oil_tank_big");
    level.breakables_fx["oiltank"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["oiltank"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qOiltanksmall = false;
  oiltank_small = getEntArray("explodable_oiltank_small", "targetname");
  if((isDefined(oiltank_small)) && (oiltank_small.size > 0)) {
    qOiltanksmall = true;
  }
  oiltank_small = getEntArray("explodable_oiltank_small", "script_noteworthy");
  if((isDefined(oiltank_small)) && (oiltank_small.size > 0)) {
    qOiltanksmall = true;
  }
  if(qOiltank) {
    level.breakables_fx["oiltanksmall"]["explode"] = loadfx("maps/fly/fx_exp_oil_tank_sm");
    level.breakables_fx["oiltanksmall"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["oiltanksmall"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qLiferaft = false;
  liferafts = getEntArray("explodable_liferaft", "targetname");
  if((isDefined(liferafts)) && (liferafts.size > 0)) {
    qLiferaft = true;
  }
  liferafts = getEntArray("explodable_liferaft", "script_noteworthy");
  if((isDefined(liferafts)) && (liferafts.size > 0)) {
    qLiferaft = true;
  }
  if(qLiferaft) {
    level.breakables_fx["liferaft"]["explode"] = loadfx("maps/fly/fx_dest_life_raft");
    level.breakables_fx["liferaft"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["liferaft"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qTarpcrate = false;
  tarpcrates = getEntArray("explodable_tarpcrate", "targetname");
  if((isDefined(tarpcrates)) && (tarpcrates.size > 0)) {
    qTarpcrate = true;
  }
  tarpcrates = getEntArray("explodable_tarpcrate", "script_noteworthy");
  if((isDefined(tarpcrates)) && (tarpcrates.size > 0)) {
    qTarpcrate = true;
  }
  if(qTarpcrate) {
    level.breakables_fx["tarpcrate"]["explode"] = loadfx("maps/fly/fx_dest_life_raft");
    level.breakables_fx["tarpcrate"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["tarpcrate"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  oilspill = getEntArray("oil_spill", "targetname");
  if(isDefined(oilspill) && oilspill.size > 0) {
    level.breakables_fx["oilspill"]["burn"] = loadfx("destructibles/fx_barrel_fire");
    level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/small_metalhit_1");
  }

  tincans = getEntArray("tincan", "targetname");
  if((isDefined(tincans)) && (tincans.size > 0)) {
    level.breakables_fx["tincan"] = loadfx("props/tincan_bounce");
  }

  qBreakables = false;
  breakables = getEntArray("breakable", "targetname");
  if((isDefined(breakables)) && (breakables.size > 0)) {
    qBreakables = true;
  }
  breakables = getEntArray("breakable_vase", "targetname");
  if((isDefined(breakables)) && (breakables.size > 0)) {
    qBreakables = true;
  }
  breakables = getEntArray("breakable box", "targetname");
  if((isDefined(barrels)) && (barrels.size > 0)) {
    qBreakables = true;
  }
  breakables = getEntArray("breakable box", "script_noteworthy");
  if((isDefined(barrels)) && (barrels.size > 0)) {
    qBreakables = true;
  }
  if(qBreakables) {
    level.breakables_fx["vase"] = loadfx("props/vase_water");
    level.breakables_fx["bottle"] = loadfx("props/wine_bottle");
    level.breakables_fx["box"][0] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][1] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][2] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][3] = loadfx("props/crateExp_ammo");
  }

  glassarray = getEntArray("glass", "targetname");
  glassarray = array_combine(glassarray, getEntArray("glass", "script_noteworthy"));
  if(isDefined(glassarray) && glassarray.size > 0) {
    level._glass_info = [];

    level._glass_info["glass_large"]["breakfx"] = loadfx("props/car_glass_large");
    level._glass_info["glass_large"]["breaksnd"] = "veh_glass_break_large";

    level._glass_info["glass_med"]["breakfx"] = loadfx("props/car_glass_med");
    level._glass_info["glass_med"]["breaksnd"] = "veh_glass_break_small";

    level._glass_info["glass_small"]["breakfx"] = loadfx("props/car_glass_headlight");
    level._glass_info["glass_small"]["breaksnd"] = "veh_glass_break_small";
  }

  tv_array = getEntArray("interactive_tv", "targetname");
  if(isDefined(tv_array) && (tv_array.size > 0)) {
    precachemodel("com_tv2_d");
    precachemodel("com_tv1");
    precachemodel("com_tv2");
    precachemodel("com_tv1_testpattern");
    precachemodel("com_tv2_testpattern");

    level.breakables_fx["tv_explode"] = loadfx("explosions/tv_explosion");
    level.tv_lite_array = getEntArray("interactive_tv_light", "targetname");
  }

  security_camera_array = getEntArray("destroyable_security_camera", "script_noteworthy");
  if(isDefined(security_camera_array) && (security_camera_array.size > 0)) {
    precachemodel("com_security_camera");
    precachemodel("com_security_camera_destroyed");

    level.breakables_fx["security_camera_explode"] = loadfx("props/securitycamera_explosion");
  }

  level.barrelExpSound = "exp_barrel";
  level.crateExpSound = "Explo_ammocrate";
  level.barrelIngSound = "Ignition_redbarrel";
  level.crateIgnSound = "Ignition_ammocrate";
  level.oiltankExpSound = "Explo_redbarrel";
  level.oiltanksmallExpSound = "Explo_redbarrel";
  level.bagofbarrelsExpSound = "Explo_redbarrel";
  level.bagofcratesExpSound = "Explo_redbarrel";
  level.liferaftExpSound = "Explo_redbarrel";
  level.tarpcrateExpSound = "Explo_redbarrel";

  maxBrokenPieces = 25;
  level.breakables_peicesCollide["orange vase"] = true;
  level.breakables_peicesCollide["green vase"] = true;
  level.breakables_peicesCollide["bottle"] = true;
  /
}

explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["exploding_barrel_test"])) {
    level.precachemodeltype["exploding_barrel_test"] = true;
    precacheModel("exploding_barrel_test_d");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("BARRELDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && (!isPlayer(attacker) &&
        (isDefined(attacker.classname) && attacker.classname != "worldspawn"))) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_barrel_burn();
    }
  }
}

explodable_barrel_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.barrelHealth) {
    if(!startedfx) {
      playFX(level.breakables_fx["barrel"]["burn_start"], self.origin + offset1);
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
      self playSound("barrel_fuse");
      playFX(level.breakables_fx["barrel"]["burn"], self.origin + offset2);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_barrel_explode();
}

explodable_barrel_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.barrelExpSound, self.origin);
  playFX(level.breakables_fx["barrel"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);
  PlayRumbleOnPosition("barrel_explosion", self.origin + (0, 0, 32));

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 1;
  maxDamage = 250;
  if(isDefined(self.script_damage)) {
    maxDamage = self.script_damage;
  }

  blastRadius = 250;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("exploding_barrel_test_d");
  } else {
    self setModel("exploding_barrel_test_d");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_oiltank_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["static_peleliu_oiltanker"])) {
    level.precachemodeltype["static_peleliu_oiltanker"] = true;
    precacheModel("static_peleliu_oiltanker_d");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("OILTANKDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_oiltank_burn();
    }
  }
}

explodable_oiltank_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      playFX(level.breakables_fx["oiltank"]["burn_start"], self.origin + offset1);
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    playFX(level.breakables_fx["oiltank"]["burn"], self.origin + offset2);

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_oiltank_explode();
}

explodable_oiltank_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 0));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.oiltankExpSound, self.origin);
  if(isDefined(self.script_vector)) {
    playFX(level.breakables_fx["oiltank"]["explode"], self.origin + offset, (0, 0, 1));
  } else {
    playFX(level.breakables_fx["oiltank"]["explode"], self.origin + offset);
  }
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 2000;
  maxDamage = 4000;
  blastRadius = 400;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("static_peleliu_oiltanker_d");
  } else {
    self setModel("static_peleliu_oiltanker_d");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_oiltank_small_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["static_peleliu_propane"])) {
    level.precachemodeltype["static_peleliu_propane"] = true;
    precacheModel("static_peleliu_propane_d");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("OILTANKDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_oiltank_small_burn();
    }
  }
}

explodable_oiltank_small_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_oiltank_small_explode();
}

explodable_oiltank_small_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 0));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.oiltanksmallExpSound, self.origin);
  if(isDefined(self.parent)) {
    playFX(level.breakables_fx["oiltanksmall"]["explode"], self.origin + offset, anglesToForward(self.parent.angles) * -1, AnglesToUp(self.parent.angles));
  } else {
    playFX(level.breakables_fx["oiltanksmall"]["explode"], self.origin + offset);
  }
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 2000;
  maxDamage = 4000;
  blastRadius = 400;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("static_peleliu_propane_d");
  } else {
    self setModel("static_peleliu_propane_d");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_bagofbarrels_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["dest_merchantship_net_barrels_dmg0"])) {
    level.precachemodeltype["dest_merchantship_net_barrels_dmg0"] = true;
    precacheModel("dest_merchantship_net_barrels_dmg1");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("OILTANKDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_bagofbarrels_burn();
    }
  }
}

explodable_bagofbarrels_burn() {
  self endon("death");

  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, -116);
  offset2 = vector_multiply(up, -116);

  if(dot < .5) {
    offset1 = vector_multiply(up, -116) - (0, 0, 30);
    offset2 = vector_multiply(up, -116) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_bagofbarrels_explode();
}

explodable_bagofbarrels_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, -116));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.bagofbarrelsExpSound, self.origin);
  playFX(level.breakables_fx["bagofbarrels"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 500;
  maxDamage = 1000;
  blastRadius = 200;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("dest_merchantship_net_barrels_dmg1");
  } else {
    self setModel("dest_merchantship_net_barrels_dmg1");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_bagofcrates_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["dest_merchantship_net_crates_dmg0"])) {
    level.precachemodeltype["dest_merchantship_net_crates_dmg0"] = true;
    precacheModel("dest_merchantship_net_crates_dmg1");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("BAGOFCRATESDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_bagofcrates_burn();
    }
  }
}

explodable_bagofcrates_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, -116);
  offset2 = vector_multiply(up, -116);

  if(dot < .5) {
    offset1 = vector_multiply(up, -116) - (0, 0, 30);
    offset2 = vector_multiply(up, -116) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_bagofcrates_explode();
}

explodable_bagofcrates_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, -116));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.bagofcratesExpSound, self.origin);
  playFX(level.breakables_fx["bagofcrates"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 500;
  maxDamage = 1000;
  blastRadius = 200;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("dest_merchantship_net_crates_dmg1");
  } else {
    self setModel("dest_merchantship_net_crates_dmg1");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_liferaft_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["dest_merchantship_lifeboat_dmg0"])) {
    level.precachemodeltype["dest_merchantship_lifeboat_dmg0"] = true;
    precacheModel("dest_merchantship_lifeboat_dmg1");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("LIFEBOATDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_liferaft_burn();
    }
  }
}

explodable_liferaft_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_liferaft_explode();
}

explodable_liferaft_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 32));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.liferaftExpSound, self.origin);
  playFX(level.breakables_fx["liferaft"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 50;
  maxDamage = 100;
  blastRadius = 1;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("dest_merchantship_lifeboat_dmg1");
  } else {
    self setModel("dest_merchantship_lifeboat_dmg1");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
explodable_tarpcrate_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["static_peleliu_crate_tarp"])) {
    level.precachemodeltype["static_peleliu_crate_tarp"] = true;
    precacheModel("static_peleliu_crate_tarp_d");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    println("TARPCRATEDAMAGE: " + type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread explodable_tarpcrate_burn();
    }
  }
}

explodable_tarpcrate_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.tankHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelIngSound, self.origin);
      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread explodable_tarpcrate_explode();
}

explodable_tarpcrate_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 32));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.tarpcrateExpSound, self.origin);
  playFX(level.breakables_fx["tarpcrate"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 50;
  maxDamage = 100;
  blastRadius = 1;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
    if(isPlayer(attacker)) {
      arcademode_assignpoints("arcademode_score_explodableitem", attacker);
    }
  }

  level.lastExplodingBarrel["time"] = getTime();
  level.lastExplodingBarrel["origin"] = self.origin + (0, 0, 30);
  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(randomint(2) == 0) {
    self setModel("static_peleliu_crate_tarp_d");
  } else {
    self setModel("static_peleliu_crate_tarp_d");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}
flammable_crate_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["global_flammable_crate_jap_single"])) {
    level.precachemodeltype["global_flammable_crate_jap_single"] = true;
    precacheModel("global_flammable_crate_jap_piece01_d");
    precacheModel("global_flammable_crate_jap_piece02_d");
    precacheModel("global_flammable_crate_jap_piece03_d");
    precacheModel("global_flammable_crate_jap_piece04_d");
    precacheModel("global_flammable_crate_jap_piece05_d");
    precacheModel("global_flammable_crate_jap_piece06_d");
  }
  self endon("exploding");

  self breakable_clip();
  self xenon_auto_aim();
  self.damageTaken = 0;
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
    if(type != "MOD_BURNED" && type != "MOD_EXPLOSIVE" && type != "MOD_PROJECTILE_SPLASH" && type != "MOD_PROJECTILE" && type != "MOD_GRENADE_SPLASH" && type != "MOD_GRENADE") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }

    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker) {
      self.damageOwner = self;
    } else {
      self.damageOwner = attacker;
    }

    if(level.barrelExplodingThisFrame) {
      wait randomfloat(1);
    }
    self.damageTaken += amount;
    if(self.damageTaken == amount) {
      self thread flammable_crate_burn();
    }
  }
}

flammable_crate_burn() {
  count = 0;
  startedfx = false;

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = vector_multiply(up, 44);

  if(dot < .5) {
    offset1 = vector_multiply(up, 22) - (0, 0, 30);
    offset2 = vector_multiply(up, 22) + (0, 0, 14);
  }
  while(self.damageTaken < level.barrelHealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.crateIgnSound, self.origin);

      startedfx = true;
    }
    if(count > 20) {
      count = 0;
    }

    if(count == 0) {
      self.damageTaken += (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }
    count++;
    wait 0.05;
  }
  self thread flammable_crate_explode();
}

flammable_crate_explode() {
  self notify("exploding");
  self notify("death");

  up = anglestoup(self.angles);
  worldup = anglestoup((0, 90, 0));
  dot = vectordot(up, worldup);

  offset = (0, 0, 0);
  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  level thread play_sound_in_space(level.crateExpSound, self.origin);
  playFX(level.breakables_fx["ammo_crate"]["explode"], self.origin);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);

  level.barrelExplodingThisFrame = true;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  minDamage = 1;
  maxDamage = 250;
  blastRadius = 250;
  if(isDefined(self.radius)) {
    blastRadius = self.radius;
  }

  attacker = undefined;

  if(isDefined(self.damageOwner)) {
    attacker = self.damageOwner;
  }

  self radiusDamage(self.origin + (0, 0, 30), blastRadius, maxDamage, minDamage, attacker);

  if(isPlayer(attacker)) {
    arcademode_assignpoints("arcademode_score_explodableitem", attacker);
  }

  if(randomint(2) == 0) {
    self setModel("global_flammable_crate_jap_piece01_d");
  } else {
    self setModel("global_flammable_crate_jap_piece01_d");
  }

  if(dot < .5) {
    start = (self.origin + vector_multiply(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));

    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
}

spawn_crate_chunks() {
  chunks = [];
  chunks[0] = spawn("script_model", self.origin + (0, 0, 32));
  chunks[1] = spawn("script_model", self.origin + (0, 0, 32));
  chunks[2] = spawn("script_model", self.origin + (0, 0, 32));
  chunks[3] = spawn("script_model", self.origin + (0, 0, 32));
  chunks[4] = spawn("script_model", self.origin + (0, 0, 32));

  chunks[0] setModel("global_flammable_crate_jap_piece02_d");
  chunks[1] setModel("global_flammable_crate_jap_piece03_d");
  chunks[2] setModel("global_flammable_crate_jap_piece04_d");
  chunks[3] setModel("global_flammable_crate_jap_piece05_d");
  chunks[4] setModel("global_flammable_crate_jap_piece06_d");

  chunks[0].physPreset = "brick";
  chunks[1].physPreset = "brick";
  chunks[2].physPreset = "brick";
  chunks[3].physPreset = "brick";
  chunks[4].physPreset = "brick";

  array_thread(chunks, ::crate_chunks_delete);
}

crate_chunks_delete() {
  wait 8;
  self delete();
}

shuddering_entity_think() {
  assert(self.classname == "script_model");
  helmet = false;
  if(self.model == "prop_helmet_german_normandy") {
    helmet = true;
  }
  self setCanDamage(true);
  for(;;) {
    self waittill("damage", other, damage, direction_vec, point);
    if(helmet) {
      self vibrate(direction_vec, 20, 0.6, 0.75);
    } else {
      self vibrate(direction_vec, 0.4, 0.4, 0.4);
    }
    self waittill("rotatedone");
  }
}

tincan_think() {
  if(self.classname != "script_model") {
    return;
  }
  self setCanDamage(true);
  self waittill("damage", damage, ent);

  if(isSentient(ent)) {
    direction_org = ((ent getEye()) - (0, 0, (randomint(50) + 50)));
  } else {
    direction_org = ent.origin;
  }

  direction_vec = vectornormalize(self.origin - direction_org);
  direction_vec = vectorScale(direction_vec, .5 + randomfloat(1));

  self notify("death");
  playFX(level.breakables_fx["tincan"], self.origin, direction_vec);
  self delete();
}

helmet_pop() {
  if(self.classname != "script_model") {
    return;
  }
  self xenon_auto_aim();

  self setCanDamage(true);
  self thread helmet_logic();
}

helmet_logic() {
  self waittill("damage", damage, ent);

  if(isSentient(ent)) {
    direction_org = ent getEye();
  } else {
    direction_org = ent.origin;
  }

  direction_vec = vectornormalize(self.origin - direction_org);

  if(!isDefined(self.dontremove) && ent == level.player) {
    self thread animscripts\death::helmetLaunch(direction_vec);
    return;
  }

  self notsolid();
  self hide();
  model = spawn("script_model", self.origin + (0, 0, 5));
  model.angles = self.angles;
  model setModel(self.model);
  model thread animscripts\death::helmetLaunch(direction_vec);

  self.dontremove = false;
  self notify("ok_remove");
}

allowBreak(ent) {
  if(!isDefined(level.breakingEnts)) {
    return true;
  }

  if(level.breakingEnts.size == 0) {
    return false;
  } else {
    for(i = 0; i < level.breakingEnts.size; i++) {
      if(ent == level.breakingEnts[i]) {
        return true;
      }
    }
    return false;
  }
  return true;
}

breakable_think_triggered(eBreakable) {
  for(;;) {
    self waittill("trigger", other);
    eBreakable notify("damage", 100, other);
  }
}

breakable_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(self.model)) {
    return;
  }
  type = undefined;

  if(self.model == "egypt_prop_vase1" || self.model == "egypt_prop_vase3" || self.model == "egypt_prop_vase4") {
    if(!isDefined(level.precachemodeltype["egypt_prop_vase_o"])) {
      level.precachemodeltype["egypt_prop_vase_o"] = true;
      precacheModel("egypt_prop_vase_br2");
      precacheModel("egypt_prop_vase_br5");
      precacheModel("egypt_prop_vase_br7");
    }
    type = "orange vase";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "egypt_prop_vase2" || self.model == "egypt_prop_vase5" || self.model == "egypt_prop_vase6") {
    if(!isDefined(level.precachemodeltype["egypt_prop_vase_g"])) {
      level.precachemodeltype["egypt_prop_vase_g"] = true;
      precacheModel("egypt_prop_vase_br1");
      precacheModel("egypt_prop_vase_br3");
      precacheModel("egypt_prop_vase_br4");
      precacheModel("egypt_prop_vase_br6");
    }
    type = "green vase";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "prop_crate_dak1" || self.model == "prop_crate_dak2" || self.model == "prop_crate_dak3" || self.model == "prop_crate_dak4" || self.model == "prop_crate_dak5" || self.model == "prop_crate_dak6" || self.model == "prop_crate_dak7" || self.model == "prop_crate_dak8" || self.model == "prop_crate_dak9") {
    if(!isDefined(level.precachemodeltype["prop_crate_dak_shard"])) {
      level.precachemodeltype["prop_crate_dak_shard"] = true;
      precacheModel("prop_crate_dak_shard");
    }
    type = "wood box";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "prop_winebottle_breakable") {
    if(!isDefined(level.precachemodeltype["prop_winebottle"])) {
      level.precachemodeltype["prop_winebottle"] = true;
      precacheModel("prop_winebottle_broken_top");
      precacheModel("prop_winebottle_broken_bot");
    }
    type = "bottle";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = true;
      precacheModel("prop_diningplate_brokenfloral1");
      precacheModel("prop_diningplate_brokenfloral2");
      precacheModel("prop_diningplate_brokenfloral3");
      precacheModel("prop_diningplate_brokenfloral4");
    }
    type = "plate";
    self.plate = "round_floral";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = true;
      precacheModel("prop_diningplate_brokenplain1");
      precacheModel("prop_diningplate_brokenplain2");
      precacheModel("prop_diningplate_brokenplain3");
      precacheModel("prop_diningplate_brokenplain4");
    }
    type = "plate";
    self.plate = "round_plain";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundstack") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = true;
      precacheModel("prop_diningplate_brokenplain1");
      precacheModel("prop_diningplate_brokenplain2");
      precacheModel("prop_diningplate_brokenplain3");
      precacheModel("prop_diningplate_brokenplain4");
    }
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = true;
      precacheModel("prop_diningplate_brokenfloral1");
      precacheModel("prop_diningplate_brokenfloral2");
      precacheModel("prop_diningplate_brokenfloral3");
      precacheModel("prop_diningplate_brokenfloral4");
    }
    type = "plate";
    self.plate = "round_stack";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = true;
      precacheModel("prop_diningplate_brokenfloral1");
      precacheModel("prop_diningplate_brokenfloral2");
      precacheModel("prop_diningplate_brokenfloral3");
      precacheModel("prop_diningplate_brokenfloral4");
    }
    type = "plate";
    self.plate = "oval_floral";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = true;
      precacheModel("prop_diningplate_brokenplain1");
      precacheModel("prop_diningplate_brokenplain2");
      precacheModel("prop_diningplate_brokenplain3");
      precacheModel("prop_diningplate_brokenplain4");
    }
    type = "plate";
    self.plate = "oval_plain";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalstack") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = true;
      precacheModel("prop_diningplate_brokenplain1");
      precacheModel("prop_diningplate_brokenplain2");
      precacheModel("prop_diningplate_brokenplain3");
      precacheModel("prop_diningplate_brokenplain4");
    }
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = true;
      precacheModel("prop_diningplate_brokenfloral1");
      precacheModel("prop_diningplate_brokenfloral2");
      precacheModel("prop_diningplate_brokenfloral3");
      precacheModel("prop_diningplate_brokenfloral4");
    }
    type = "plate";
    self.plate = "oval_stack";
    self xenon_auto_aim();
  }
  if(!isDefined(type)) {
    println("Entity ", self.targetname, " at ", self.origin, " is not a valid breakable object.");
    return;
  }

  if(isDefined(self.target)) {
    trig = getent(self.target, "targetname");
    if((isDefined(trig)) && (trig.classname == "trigger_multiple")) {
      trig thread breakable_think_triggered(self);
    }
  }

  self setCanDamage(true);
  self thread breakable_logic(type);
}

breakable_logic(type) {
  ent = undefined;
  for(;;) {
    self waittill("damage", amount, ent);
    if(isDefined(ent) && ent.classname == "script_vehicle") {
      ent joltbody(self.origin + (0, 0, -90), .2);
    }
    if(type == "wood box") {
      if(!allowBreak(ent)) {
        continue;
      }
      if((!isDefined(level.flags)) || (!isDefined(level.flags["Breakable Boxes"]))) {
        break;
      }
      if((isDefined(level.flags["Breakable Boxes"])) && (level.flags["Breakable Boxes"] == true)) {
        break;
      }
      continue;
    }
    break;
  }

  self notify("death");

  soundAlias = undefined;
  fx = undefined;
  hasDependant = false;
  switch (type) {
    case "orange vase":
    case "green vase":
      soundAlias = "bullet_large_vase";
      fx = level.breakables_fx["vase"];
      break;
    case "wood box":
      if(isDefined(level.crateImpactSound)) {
        soundAlias = level.crateImpactSound;
      } else {
        soundAlias = "bullet_large_vase";
      }
      fx = level.breakables_fx["box"][randomint(level.breakables_fx["box"].size)];
      hasDependant = true;
      break;
    case "bottle":
      soundAlias = "bullet_small_bottle";
      fx = level.breakables_fx["bottle"];
      break;
    case "plate":
      soundAlias = "bullet_small_plate";
      break;
  }
  thread play_sound_in_space(soundAlias, self.origin);
  self thread make_broken_peices(self, type);
  if(isDefined(fx)) {
    playFX(fx, self.origin);
  }

  if(hasDependant) {
    others = getEntArray("breakable", "targetname");
    for(i = 0; i < others.size; i++) {
      other = others[i];

      diffX = abs(self.origin[0] - other.origin[0]);
      diffY = abs(self.origin[1] - other.origin[1]);

      if((diffX <= 20) && (diffY <= 20)) {
        diffZ = (self.origin[2] - other.origin[2]);
        if(diffZ <= 0) {
          other notify("damage", amount, ent);
        }
      }
    }
  }

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  if(!isDefined(self.dontremove)) {
    self delete();
  } else {
    self.dontremove = false;
  }
  self notify("ok_remove");
}

xenon_auto_aim() {
  if((isDefined(level.console_auto_aim)) && (level.console_auto_aim.size > 0)) {
    self.autoaim = getClosestAccurantEnt(self.origin, level.console_auto_aim);
  }

  if(isDefined(self.autoaim)) {
    level.console_auto_aim = array_remove(level.console_auto_aim, self.autoaim);
    self thread xenon_remove_auto_aim();
  }
}

xenon_auto_aim_stop_logic() {
  self notify("entered_xenon_auto_aim_stop_logic");
  self endon("entered_xenon_auto_aim_stop_logic");

  self.autoaim waittill("xenon_auto_aim_stop_logic");
  self.dontremove = undefined;
}

xenon_remove_auto_aim(wait_message) {
  self thread xenon_auto_aim_stop_logic();
  self endon("xenon_auto_aim_stop_logic");
  self.autoaim endon("xenon_auto_aim_stop_logic");

  self notify("xenon_remove_auto_aim");
  self.autoaim thread xenon_enable_auto_aim(wait_message);
  self.dontremove = true;
  self waittill("damage", amount, ent);

  self.autoaim disableAimAssist();

  self.autoaim delete();
  if(self.dontremove) {
    self waittill("ok_remove");
  }
  self delete();
}

xenon_enable_auto_aim(wait_message) {
  self endon("xenon_auto_aim_stop_logic");
  self endon("death");
  if(!isDefined(wait_message)) {
    wait_message = true;
  }

  if(isDefined(self.script_noteworthy) && wait_message) {
    string = "enable_xenon_autoaim_" + self.script_noteworthy;
    level waittill(string);
  }

  self.wait_message = false;
  if(isDefined(self.recreate) && self.recreate == true) {
    self waittill("recreate");
  }
  self enableAimAssist();
}

breakable_clip() {
  if(isDefined(self.target)) {
    targ = getent(self.target, "targetname");
    if(targ.classname == "script_brushmodel") {
      self.remove = targ;
      return;
    }
  }
  if((isDefined(level.breakables_clip)) && (level.breakables_clip.size > 0)) {
    self.remove = getClosestEnt(self.origin, level.breakables_clip);
  }
  if(isDefined(self.remove)) {
    level.breakables_clip = array_remove(level.breakables_clip, self.remove);
  }
}

make_broken_peices(wholepiece, type) {
  rt = anglesToRight(wholepiece.angles);
  fw = anglesToForward(wholepiece.angles);
  up = anglesToUp(wholepiece.angles);

  piece = [];
  switch (type) {
    case "orange vase":
      piece[piece.size] = addpiece(rt, fw, up, -7, 0, 22, wholepiece, (0, 0, 0), "egypt_prop_vase_br2");
      piece[piece.size] = addpiece(rt, fw, up, 13, -6, 28, wholepiece, (0, 245.1, 0), "egypt_prop_vase_br7");
      piece[piece.size] = addpiece(rt, fw, up, 12, 10, 27, wholepiece, (0, 180, 0), "egypt_prop_vase_br7");
      piece[piece.size] = addpiece(rt, fw, up, 3, 2, 0, wholepiece, (0, 0, 0), "egypt_prop_vase_br5");
      break;
    case "green vase":
      piece[piece.size] = addpiece(rt, fw, up, -6, -1, 26, wholepiece, (0, 0, 0), "egypt_prop_vase_br1");
      piece[piece.size] = addpiece(rt, fw, up, 12, 1, 31, wholepiece, (0, 348.5, 0), "egypt_prop_vase_br3");
      piece[piece.size] = addpiece(rt, fw, up, 6, 13, 29, wholepiece, (0, 153.5, 0), "egypt_prop_vase_br6");
      piece[piece.size] = addpiece(rt, fw, up, 3, 1, 0, wholepiece, (0, 0, 0), "egypt_prop_vase_br4");
      break;
    case "wood box":
      piece[piece.size] = addpiece(rt, fw, up, -10, 10, 25, wholepiece, (0, 0, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, 10, 25, wholepiece, (0, 90, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, -10, 25, wholepiece, (0, 180, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, -10, 25, wholepiece, (0, 270, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, 10, 5, wholepiece, (180, 0, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, -10, 5, wholepiece, (180, 90, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, -10, 5, wholepiece, (180, 180, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, 10, 5, wholepiece, (180, 270, 0), "prop_crate_dak_shard");
      break;
    case "bottle":
      piece[piece.size] = addpiece(rt, fw, up, 0, 0, 10, wholepiece, (0, 0, 0), "prop_winebottle_broken_top");
      piece[piece.size - 1].type = "bottle_top";
      piece[piece.size] = addpiece(rt, fw, up, 0, 0, 0, wholepiece, (0, 0, 0), "prop_winebottle_broken_bot");
      piece[piece.size - 1].type = "bottle_bot";
      break;
    case "plate": {
      switch (wholepiece.plate) {
        case "round_floral":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, .5, wholepiece, (0, 150, 0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, .5, wholepiece, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, .5, wholepiece, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "round_plain":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, .5, wholepiece, (0, 150, 0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, .5, wholepiece, (0, 149.8, 0), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, .5, wholepiece, (0, 146.8, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
        case "round_stack":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, .5, wholepiece, (0, 150, 0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, .5, wholepiece, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, .5, wholepiece, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";

          piece[piece.size] = addpiece(rt, fw, up, -4, 3, 2.5, wholepiece, (0, 60, 0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -1, -3, 2.5, wholepiece, (0, 59.8, 0), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, -1, 2.5, wholepiece, (0, 60.2, 0), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, 4, 2.5, wholepiece, (0, 56.8, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";

          piece[piece.size] = addpiece(rt, fw, up, -3, -4, 4.5, wholepiece, (0, 150, 0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, 4.5, wholepiece, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, 4.5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, 4.5, wholepiece, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_floral":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, .5, wholepiece, (0, 205.9, 0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, .5, wholepiece, (0, 352.2, 0), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, .5, wholepiece, (0, 102.3, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, .5, wholepiece, (0, 246.7, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_plain":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, .5, wholepiece, (0, 205.9, 0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, .5, wholepiece, (0, 352.2, 0), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, .5, wholepiece, (0, 102.3, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, .5, wholepiece, (0, 246.7, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_stack":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, .5, wholepiece, (0, 205.9, 0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, .5, wholepiece, (0, 352.2, 0), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, .5, wholepiece, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, .5, wholepiece, (0, 102.3, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, .5, wholepiece, (0, 246.7, 0), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";

          piece[piece.size] = addpiece(rt, fw, up, -4, 5, 2.5, wholepiece, (0, 25.9, 0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 6, 0, 2.5, wholepiece, (0, 172.2, 0), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, -1, 2.5, wholepiece, (0, 330.2, 0), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, -4, 2.5, wholepiece, (0, 282.3, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, 4, 2.5, wholepiece, (0, 66.7, 0), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
      }
    }
    break;
    default:
      return;
  }
  array_thread(piece, ::pieces_move, wholepiece.origin);

  if((isDefined(level.breakables_peicesCollide[type])) && (level.breakables_peicesCollide[type] == true)) {
    height = piece[0].origin[2];
    for(i = 0; i < piece.size; i++) {
      if(height > piece[i].origin[2]) {
        height = piece[i].origin[2];
      }
    }
    array_thread(piece, ::pieces_collision, height);
  } else {
    wait 2;
    for(i = 0; i < piece.size; i++) {
      if(isDefined(piece[i])) {
        piece[i] delete();
      }
    }
  }
}

list_add(model) {
  if(isDefined(level._breakable_utility_modelarray[level._breakable_utility_modelindex])) {
    level._breakable_utility_modelarray[level._breakable_utility_modelindex] delete();
  }
  level._breakable_utility_modelarray[level._breakable_utility_modelindex] = model;
  level._breakable_utility_modelindex++;

  if(!(level._breakable_utility_modelindex < level._breakable_utility_maxnum)) {
    level._breakable_utility_modelindex = 0;
  }
}

pieces_move(origin) {
  self endon("do not kill");
  if(isDefined(self.type) && self.type == "bottle_bot") {
    return;
  }
  org = spawn("script_origin", self.origin);
  self linkto(org);
  end = self.origin + (randomfloat(10) - 5, randomfloat(10) - 5, randomfloat(10) + 5);

  vec = undefined;
  if(isDefined(self.type) && self.type == "bottle_top") {
    vec = (randomfloat(40) - 20, randomfloat(40) - 20, 70 + randomfloat(15));
    x = 1;
    y = 1;
    z = 1;
    if(randomint(100) > 50) {
      x = -1;
    }
    if(randomint(100) > 50) {
      y = -1;
    }
    if(randomint(100) > 50) {
      z = -1;
    }

    org rotatevelocity((250 * x, 250 * y, randomfloat(100) * z), 2, 0, .5);
  } else if(isDefined(self.type) && self.type == "plate") {
    vec = vectornormalize(end - origin);
    vec = vectorScale(vec, 125 + randomfloat(25));
    if(randomint(100) > 50) {
      org rotateroll((800 + randomfloat(4000)) * -1, 5, 0, 0);
    } else {
      org rotateroll(800 + randomfloat(4000), 5, 0, 0);
    }
  } else {
    vec = vectornormalize(end - origin);
    vec = vectorScale(vec, 60 + randomfloat(50));
    if(randomint(100) > 50) {
      org rotateroll((800 + randomfloat(1000)) * -1, 5, 0, 0);
    } else {
      org rotateroll(800 + randomfloat(1000), 5, 0, 0);
    }
  }

  org moveGravity(vec, 5);

  wait 5;
  if(isDefined(self)) {
    self unlink();
  }
  org delete();
}

pieces_collision(height) {
  self endon("death");
  wait .1;
  trace = bulletTrace(self.origin, self.origin - (0, 0, 50000), false, undefined);
  vec = trace["position"];

  while(self.origin[2] > vec[2]) {
    wait .05;
  }

  self unlink();

  self.origin = (self.origin[0], self.origin[1], vec[2]);

  self notify("do not kill");
  self unlink();
}

addpiece(rt, fw, up, xs, ys, zs, wholepiece, angles, model) {
  scale = 1;

  x = rt;
  y = fw;
  z = up;
  x = vectorScale(x, ys * scale);
  y = vectorScale(y, xs * scale);
  z = vectorScale(z, zs * scale);
  origin = wholepiece.origin + x + y + z;
  part = spawn("script_model", origin);
  part setModel(model);
  part.modelscale = scale;
  part.angles = wholepiece.angles + angles;

  list_add(part);

  return part;
}

getFurthestEnt(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = distance(array[0] getorigin(), org);
  ent = array[0];
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);
    if(newdist < dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

getClosestEnt(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = 256;
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

getClosestAccurantEnt(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = 8;
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

getClosestAimEnt(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = 1000000;
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}