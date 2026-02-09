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
    level.breakables_fx["bagofbarrels"]["explode"] = loadfx("destructibles/fx_exp_bagobarrels");
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
    level.breakables_fx["bagofcrates"]["explode"] = loadfx("destructibles/fx_exp_bagocrates");
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
    level.breakables_fx["oiltank"]["explode"] = loadfx("destructibles/fx_exp_oil_tank_lg");
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
    level.breakables_fx["oiltanksmall"]["explode"] = loadfx("destructibles/fx_exp_oil_tank_sm");
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
    level.breakables_fx["liferaft"]["explode"] = loadfx("destrictibles/fx_dest_life_raft");
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
    level.breakables_fx["tarpcrate"]["explode"] = loadfx("destructibles/fx_dest_life_raft");
    level.breakables_fx["tarpcrate"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["tarpcrate"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }
  oilspill = getEntArray("oil_spill", "targetname");
  if(isDefined(oilspill) && oilspill.size > 0) {
    level.breakables_fx["oilspill"]["burn"] = loadfx("destructibles/fx_barrel_fire");
    level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/fx_small_metalhit");
  }
  tincans = getEntArray("tincan", "targetname");
  if((isDefined(tincans)) && (tincans.size > 0)) {
    level.breakables_fx["tincan"] = loadfx("destructibles/fx_tincan_bounce");
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
    level.breakables_fx["vase"] = loadfx("destructibles/fx_vase_water");
    level.breakables_fx["bottle"] = loadfx("destructibles/fx_wine_bottle");
    level.breakables_fx["box"][0] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][1] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][2] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][3] = loadfx("destructibles/fx_exp_crate_ammo");
  }
  glassarray = getEntArray("glass", "targetname");
  glassarray = array_combine(glassarray, getEntArray("glass", "script_noteworthy"));
  if(isDefined(glassarray) && glassarray.size > 0) {
    level._glass_info = [];
    level._glass_info["glass_large"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_large");
    level._glass_info["glass_large"]["breaksnd"] = "veh_glass_break_large";
    level._glass_info["glass_med"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_med");
    level._glass_info["glass_med"]["breaksnd"] = "veh_glass_break_small";
    level._glass_info["glass_small"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_headlight");
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
  level.barrelExpSound = "exp_redbarrel";
  level.crateExpSound = "exp_ammocrate";
  level.barrelIngSound = "exp_redbarrel_ignition";
  level.crateIgnSound = "exp_ammocrate_ignition";
  level.oiltankExpSound = "exp_redbarrel";
  level.oiltanksmallExpSound = "exp_redbarrel";
  level.bagofbarrelsExpSound = "exp_redbarrel";
  level.bagofcratesExpSound = "exp_redbarrel";
  level.liferaftExpSound = "exp_redbarrel";
  level.tarpcrateExpSound = "exp_redbarrel";
  maxBrokenPieces = 25;
  level.breakables_peicesCollide["orange vase"] = true;
  level.breakables_peicesCollide["green vase"] = true;
  level.breakables_peicesCollide["bottle"] = true;
  level.barrelHealth = 350;
  level.tankHealth = 900;
  level.precachemodeltype = [];
  level.barrelExplodingThisFrame = false;
  level.breakables_clip = [];
  level.breakables_clip = getEntArray("vase_break_remove", "targetname");
  level.console_auto_aim = [];
  level.console_auto_aim = getEntArray("xenon_auto_aim", "targetname");
  level.console_auto_aim_2nd = getEntArray("xenon_auto_aim_secondary", "targetname");
  for(i = 0; i < level.console_auto_aim.size; i++) {
    level.console_auto_aim[i] notsolid();
  }
  for(i = 0; i < level.console_auto_aim_2nd.size; i++) {
    level.console_auto_aim_2nd[i] notsolid();
  }
  maps\_utility::set_console_status();
  if(level.console) {
    level.console_auto_aim = undefined;
    level.console_auto_aim_2nd = undefined;
  }
  temp = getEntArray("breakable clip", "targetname");
  for(i = 0; i < temp.size; i++) {
    level.breakables_clip[level.breakables_clip.size] = temp[i];
  }
  level._breakable_utility_modelarray = [];
  level._breakable_utility_modelindex = 0;
  level._breakable_utility_maxnum = maxBrokenPieces;
  array_thread(getEntArray("tincan", "targetname"), ::tincan_think);
  array_thread(getEntArray("helmet_pop", "targetname"), ::helmet_pop);
  array_thread(getEntArray("explodable_barrel", "targetname"), ::explodable_barrel_think);
  array_thread(getEntArray("explodable_barrel", "script_noteworthy"), ::explodable_barrel_think);
  array_thread(getEntArray("shuddering_entity", "targetname"), ::shuddering_entity_think);
  array_thread(getEntArray("breakable box", "targetname"), ::breakable_think);
  array_thread(getEntArray("breakable box", "script_noteworthy"), ::breakable_think);
  array_thread(getEntArray("breakable", "targetname"), ::breakable_think);
  array_thread(getEntArray("breakable_vase", "targetname"), ::breakable_think);
  array_thread(getEntArray("oil_spill", "targetname"), ::oil_spill_think);
  array_thread(getEntArray("glass", "targetname"), ::glass_logic);
  array_thread(getEntArray("flammable_crate", "targetname"), ::flammable_crate_think);
  array_thread(getEntArray("flammable_crate", "script_noteworthy"), ::flammable_crate_think);
  array_thread(getEntArray("explodable_oiltank", "targetname"), ::explodable_oiltank_think);
  array_thread(getEntArray("explodable_oiltank", "script_noteworthy"), ::explodable_oiltank_think);
  array_thread(getEntArray("explodable_oiltank_small", "targetname"), ::explodable_oiltank_small_think);
  array_thread(getEntArray("explodable_oiltank_small", "script_noteworthy"), ::explodable_oiltank_small_think);
  array_thread(getEntArray("explodable_bagofbarrels", "targetname"), ::explodable_bagofbarrels_think);
  array_thread(getEntArray("explodable_bagofbarrels", "script_noteworthy"), ::explodable_bagofbarrels_think);
  array_thread(getEntArray("explodable_bagofcrates", "targetname"), ::explodable_bagofcrates_think);
  array_thread(getEntArray("explodable_bagofcrates", "script_noteworthy"), ::explodable_bagofcrates_think);
  array_thread(getEntArray("explodable_liferaft", "targetname"), ::explodable_liferaft_think);
  array_thread(getEntArray("explodable_liferaft", "script_noteworthy"), ::explodable_liferaft_think);
  array_thread(getEntArray("explodable_tarpcrate", "targetname"), ::explodable_tarpcrate_think);
  array_thread(getEntArray("explodable_tarpcrate", "script_noteworthy"), ::explodable_tarpcrate_think);
}
glass_logic() {
  direction_vec = undefined;
  crackedContents = undefined;
  cracked = undefined;
  glasshealth = 0;
  if(isDefined(self.target)) {
    cracked = getent(self.target, "targetname");
    assertex(isDefined(cracked), "Destructible glass at origin( " + self.origin + " ) has a target but the cracked version doesn't exist");
  }
  if(isDefined(self.script_linkTo)) {
    links = self get_links();
    assert(isDefined(links));
    object = getent(links[0], "script_linkname");
    self linkto(object);
  }
  assertex(isDefined(self.destructible_type), "Destructible glass at origin( " + self.origin + " ) doesnt have a destructible_type");
  switch (self.destructible_type) {
    case "glass_large":
      break;
    case "glass_med":
      break;
    case "glass_small":
      break;
    default:
      assertMsg("Destructible glass 'destructible_type' key/value of '" + self.destructible_type + "' is not valid");
      break;
  }
  if(isDefined(cracked)) {
    glasshealth = 99;
    cracked linkto(self);
    cracked hide();
    crackedContents = cracked setContents(0);
  }
  if(isDefined(self.script_health)) {
    glasshealth = self.script_health;
  } else if(isDefined(cracked)) {
    glasshealth = 99;
  } else {
    glasshealth = 250;
  }
  self setCanDamage(true);
  while(glasshealth > 0) {
    self waittill("damage", damage, attacker, direction_vec, point, damageType);
    if(!isDefined(direction_vec)) {
      direction_vec = (0, 0, 1);
    }
    if(!isDefined(damageType)) {
      damage = 100000;
    } else if(damageType == "MOD_GRENADE_SPLASH") {
      damage = damage * 1.75;
    } else if(damageType == "MOD_IMPACT") {
      damage = 100000;
    }
    glasshealth -= damage;
  }
  prevdamage = glasshealth * -1;
  self hide();
  self notsolid();
  if(isDefined(cracked)) {
    cracked show();
    cracked setCanDamage(true);
    glasshealth = (200) - prevdamage;
    cracked setContents(crackedContents);
    while(glasshealth > 0) {
      cracked waittill("damage", damage, other, direction_vec, point, damageType);
      if(!isDefined(direction_vec)) {
        direction_vec = (0, 0, 1);
      }
      if(!isDefined(damageType)) {
        damage = 100000;
      } else if(damageType == "MOD_GRENADE_SPLASH") {
        damage = damage * 1.75;
      } else if(damageType == "MOD_IMPACT") {
        break;
      }
      glasshealth -= damage;
    }
    cracked delete();
  }
  glass_play_break_fx(self getorigin(), self.destructible_type, direction_vec);
  self delete();
}
glass_play_break_fx(origin, info, direction_vec) {
  thread play_sound_in_space(level._glass_info[info]["breaksnd"], origin);
  playFX(level._glass_info[info]["breakfx"], origin, direction_vec);
  level notify("glass_shatter");
}
oil_spill_think() {
  self.end = getstruct(self.target, "targetname");
  self.start = getstruct(self.end.target, "targetname");
  self.barrel = getClosestEnt(self.start.origin, getEntArray("explodable_barrel", "targetname"));
  if(isDefined(self.barrel)) {
    self.barrel.oilspill = true;
    self thread oil_spill_burn_after();
  }
  self.extra = getent(self.target, "targetname");
  self setCanDamage(true);
  while(1) {
    self waittill("damage", amount, attacker, direction_vec, P, type);
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
    playFX(level.breakables_fx["oilspill"]["spark"], P, direction_vec);
    P = pointOnSegmentNearestToPoint(self.start.origin, self.end.origin, P);
    thread oil_spill_burn_section(P);
    self thread oil_spill_burn(P, self.start.origin);
    self thread oil_spill_burn(P, self.end.origin);
    break;
  }
  if(isDefined(self.barrel)) {
    self.barrel waittill("exploding");
  }
  self.extra delete();
  self hide();
  wait 10;
  self delete();
}
oil_spill_burn_after() {
  while(1) {
    self.barrel waittill("damage", amount, attacker, direction_vec, P, type);
    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isPlayer(attacker)) {
      continue;
    }
    if(isDefined(self.barrel.script_selfisattacker) && self.barrel.script_selfisattacker) {
      self.damageOwner = self.barrel;
    } else {
      self.damageOwner = attacker;
    }
    break;
  }
  self radiusdamage(self.start.origin, 4, 10, 10, self.damageOwner);
}
oil_spill_burn(P, dest) {
  forward = vectornormalize(dest - P);
  dist = distance(p, dest);
  range = 8;
  interval = vector_scale(forward, range);
  angle = vectortoangles(forward);
  right = anglestoright(angle);
  barrels = getEntArray("explodable_barrel", "targetname");
  distsqr = 22 * 22;
  test = spawn("script_origin", P);
  num = 0;
  while(1) {
    dist -= range;
    if(dist < range * .1) {
      break;
    }
    p += (interval + vector_scale(right, randomfloatrange(-6, 6)));
    thread oil_spill_burn_section(P);
    num++;
    if(num == 4) {
      badplace_cylinder("", 5, P, 64, 64);
      num = 0;
    }
    test.origin = P;
    remove = [];
    barrels = array_removeUndefined(barrels);
    for(i = 0; i < barrels.size; i++) {
      vec = anglestoup(barrels[i].angles);
      start = barrels[i].origin + (vector_scale(vec, 22));
      pos = physicstrace(start, start + (0, 0, -64));
      if(distancesquared(P, pos) < distsqr) {
        remove[remove.size] = barrels[i];
        barrels[i] dodamage((80 + randomfloat(10)), P);
      }
    }
    for(i = 0; i < remove.size; i++) {
      barrels = array_remove(barrels, remove[i]);
    }
    wait .1;
  }
  if(!isDefined(self.barrel)) {
    return;
  }
  if(distance(P, self.start.origin) < 32) {
    self.barrel dodamage((80 + randomfloat(10)), P);
  }
}
oil_spill_burn_section(P) {
  count = 0;
  time = 0;
  playFX(level.breakables_fx["oilspill"]["burn"], P);
}
explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["exploding_barrel_test"])) {
    level.precachemodeltype["exploding_barrel_test"] = true;
    precacheModel("global_explosive_barrel_d");
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
      self playSound("exp_barrel_fuse");
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
    start = (self.origin + vector_scale(up, 22));
    end = physicstrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);
  level thread play_sound_in_space(level.barrelExpSound, self.origin);
  playFX(level.breakables_fx["barrel"]["explode"], self.origin + offset, (270, 0, 0));
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
    self setModel("global_explosive_barrel_d");
  } else {
    self setModel("global_explosive_barrel_d");
  }
  if(dot < .5) {
    start = (self.origin + vector_scale(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));
    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  waittillframeend;
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, 0));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, 0));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, -116);
  if(dot < .5) {
    offset1 = vector_scale(up, -116) - (0, 0, 30);
    offset2 = vector_scale(up, -116) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, -116));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, -116);
  if(dot < .5) {
    offset1 = vector_scale(up, -116) - (0, 0, 30);
    offset2 = vector_scale(up, -116) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, -116));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, 32));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, 32));
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
    start = (self.origin + vector_scale(up, 22));
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
  offset2 = vector_scale(up, 44);
  if(dot < .5) {
    offset1 = vector_scale(up, 22) - (0, 0, 30);
    offset2 = vector_scale(up, 22) + (0, 0, 14);
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
    start = (self.origin + vector_scale(up, 22));
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
    start = (self.origin + vector_scale(up, 22));
    pos = physicstrace(start, (start + (0, 0, -64)));
    self.origin = pos;
    self.angles += (0, 0, 90);
  }
  wait 0.05;
  level.barrelExplodingThisFrame = false;
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
  direction_vec = vector_scale(direction_vec, .5 + randomfloat(1));
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
    self thread call_overloaded_func("animscripts\death", "helmetLaunch", direction_vec);
    return;
  }
  self notsolid();
  self hide();
  model = spawn("script_model", self.origin + (0, 0, 5));
  model.angles = self.angles;
  model setModel(self.model);
  model thread call_overloaded_func("animscripts\death", "helmetLaunch", direction_vec);
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
    eBreakable damage_notify_wrapper(100, other);
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
    self notify("ok_remove");
  }
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
    vec = vector_scale(vec, 125 + randomfloat(25));
    if(randomint(100) > 50) {
      org rotateroll((800 + randomfloat(4000)) * -1, 5, 0, 0);
    } else {
      org rotateroll(800 + randomfloat(4000), 5, 0, 0);
    }
  } else {
    vec = vectornormalize(end - origin);
    vec = vector_scale(vec, 60 + randomfloat(50));
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
  x = vector_scale(x, ys * scale);
  y = vector_scale(y, xs * scale);
  z = vector_scale(z, zs * scale);
  origin = wholepiece.origin + x + y + z;
  part = spawn("script_model", origin);
  part setModel(model);
  part.modelscale = scale;
  part.angles = wholepiece.angles + angles;
  list_add(part);
  return part;
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