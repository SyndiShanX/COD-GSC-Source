/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_interactive_objects.gsc
*****************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\death;

main() {
  flag_init("no_ai_tv_damage");
  qbarrels = 0;
  barrels = getentarray("explodable_barrel", "targetname");

  if(isDefined(barrels) && barrels.size > 0)
    qbarrels = 1;

  barrels = getentarray("explodable_barrel", "script_noteworthy");

  if(isDefined(barrels) && barrels.size > 0)
    qbarrels = 1;

  if(qbarrels) {
    precacherumble("barrel_explosion");
    level.breakables_fx["barrel"]["explode"] = loadfx("destructibles/fx_barrelExp");
    level.breakables_fx["barrel"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["barrel"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  qcrates = 0;
  crates = getentarray("flammable_crate", "targetname");

  if(isDefined(crates) && crates.size > 0)
    qcrates = 1;

  crates = getentarray("flammable_crate", "script_noteworthy");

  if(isDefined(crates) && crates.size > 0)
    qcrates = 1;

  if(qcrates)
    level.breakables_fx["ammo_crate"]["explode"] = loadfx("destructibles/fx_ammoboxExp");

  qtarpcrate = 0;
  tarpcrates = getentarray("explodable_tarpcrate", "targetname");

  if(isDefined(tarpcrates) && tarpcrates.size > 0)
    qtarpcrate = 1;

  tarpcrates = getentarray("explodable_tarpcrate", "script_noteworthy");

  if(isDefined(tarpcrates) && tarpcrates.size > 0)
    qtarpcrate = 1;

  if(qtarpcrate) {
    level.breakables_fx["tarpcrate"]["explode"] = loadfx("destructibles/fx_dest_life_raft");
    level.breakables_fx["tarpcrate"]["burn_start"] = loadfx("destructibles/fx_barrel_ignite");
    level.breakables_fx["tarpcrate"]["burn"] = loadfx("destructibles/fx_barrel_fire_top");
  }

  oilspill = getentarray("oil_spill", "targetname");

  if(isDefined(oilspill) && oilspill.size > 0) {
    level.breakables_fx["oilspill"]["burn"] = loadfx("destructibles/fx_barrel_fire");
    level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/fx_small_metalhit");
  }

  tincans = getentarray("tincan", "targetname");

  if(isDefined(tincans) && tincans.size > 0)
    level.breakables_fx["tincan"] = loadfx("destructibles/fx_tincan_bounce");

  qbreakables = 0;
  breakables = getentarray("breakable", "targetname");

  if(isDefined(breakables) && breakables.size > 0)
    qbreakables = 1;

  breakables = getentarray("breakable_vase", "targetname");

  if(isDefined(breakables) && breakables.size > 0)
    qbreakables = 1;

  breakables = getentarray("breakable box", "targetname");

  if(isDefined(barrels) && barrels.size > 0)
    qbreakables = 1;

  breakables = getentarray("breakable box", "script_noteworthy");

  if(isDefined(barrels) && barrels.size > 0)
    qbreakables = 1;

  if(qbreakables) {
    level.breakables_fx["vase"] = loadfx("destructibles/fx_vase_water");
    level.breakables_fx["bottle"] = loadfx("destructibles/fx_wine_bottle");
    level.breakables_fx["box"][0] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][1] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][2] = loadfx("destructibles/fx_exp_crate_dust");
    level.breakables_fx["box"][3] = loadfx("destructibles/fx_exp_crate_ammo");
  }

  glassarray = getentarray("glass", "targetname");
  glassarray = arraycombine(glassarray, getentarray("glass", "script_noteworthy"), 1, 0);

  if(isDefined(glassarray) && glassarray.size > 0) {
    level._glass_info = [];
    level._glass_info["glass_large"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_large");
    level._glass_info["glass_large"]["breaksnd"] = "veh_glass_break_large";
    level._glass_info["glass_med"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_med");
    level._glass_info["glass_med"]["breaksnd"] = "veh_glass_break_small";
    level._glass_info["glass_small"]["breakfx"] = loadfx("destructibles/fx_break_glass_car_headlight");
    level._glass_info["glass_small"]["breaksnd"] = "veh_glass_break_small";
  }

  level.barrelexpsound = "exp_redbarrel";
  level.crateexpsound = "exp_ammocrate";
  level.barrelingsound = "exp_redbarrel_ignition";
  level.crateignsound = "exp_ammocrate_ignition";
  level.tarpcrateexpsound = "exp_redbarrel";
  level.breakables_peicescollide["orange vase"] = 1;
  level.breakables_peicescollide["green vase"] = 1;
  level.breakables_peicescollide["bottle"] = 1;
  level.barrelhealth = 350;
  level.tankhealth = 900;
  level.precachemodeltype = [];
  level.barrelexplodingthisframe = 0;
  level.breakables_clip = [];
  level.breakables_clip = getentarray("vase_break_remove", "targetname");
  level.console_auto_aim = [];
  level.console_auto_aim = getentarray("xenon_auto_aim", "targetname");
  level.console_auto_aim_2nd = getentarray("xenon_auto_aim_secondary", "targetname");

  for(i = 0; i < level.console_auto_aim.size; i++)
    level.console_auto_aim[i] notsolid();

  for(i = 0; i < level.console_auto_aim_2nd.size; i++)
    level.console_auto_aim_2nd[i] notsolid();

  maps\_utility::set_console_status();

  if(level.console) {
    level.console_auto_aim = undefined;
    level.console_auto_aim_2nd = undefined;
  }

  temp = getentarray("breakable clip", "targetname");

  for(i = 0; i < temp.size; i++)
    level.breakables_clip[level.breakables_clip.size] = temp[i];

  level._breakable_utility_modelarray = [];
  level._breakable_utility_modelindex = 0;
  level._breakable_utility_maxnum = 25;
  array_thread(getentarray("tincan", "targetname"), ::tincan_think);
  array_thread(getentarray("helmet_pop", "targetname"), ::helmet_pop);
  array_thread(getentarray("explodable_barrel", "targetname"), ::explodable_barrel_think);
  array_thread(getentarray("explodable_barrel", "script_noteworthy"), ::explodable_barrel_think);
  array_thread(getentarray("shuddering_entity", "targetname"), ::shuddering_entity_think);
  array_thread(getentarray("breakable box", "targetname"), ::breakable_think);
  array_thread(getentarray("breakable box", "script_noteworthy"), ::breakable_think);
  array_thread(getentarray("breakable", "targetname"), ::breakable_think);
  array_thread(getentarray("breakable_vase", "targetname"), ::breakable_think);
  array_thread(getentarray("oil_spill", "targetname"), ::oil_spill_think);
  array_thread(getentarray("glass", "targetname"), ::glass_logic);
  array_thread(getentarray("flammable_crate", "targetname"), ::flammable_crate_think);
  array_thread(getentarray("flammable_crate", "script_noteworthy"), ::flammable_crate_think);
  array_thread(getentarray("explodable_tarpcrate", "targetname"), ::explodable_tarpcrate_think);
  array_thread(getentarray("explodable_tarpcrate", "script_noteworthy"), ::explodable_tarpcrate_think);
}

glass_logic() {
  direction_vec = undefined;
  crackedcontents = undefined;
  cracked = undefined;
  glasshealth = 0;

  if(isDefined(self.target)) {
    cracked = getent(self.target, "targetname");
    assert(isDefined(cracked), "Destructible glass at origin( " + self.origin + " ) has a target but the cracked version doesn't exist");
  }

  if(isDefined(self.script_linkto)) {
    links = self get_links();
    assert(isDefined(links));
    object = getent(links[0], "script_linkname");
    self linkto(object);
  }

  assert(isDefined(self.destructible_type), "Destructible glass at origin( " + self.origin + " ) doesnt have a destructible_type");

  switch (self.destructible_type) {
    case "glass_large":
      break;
    case "glass_med":
      break;
    case "glass_small":
      break;
    default:

      assertmsg("Destructible glass 'destructible_type' key/value of '" + self.destructible_type + "' is not valid");

      break;
  }

  if(isDefined(cracked)) {
    glasshealth = 99;
    cracked linkto(self);
    cracked hide();
    crackedcontents = cracked setcontents(0);
  }

  if(isDefined(self.script_health))
    glasshealth = self.script_health;
  else if(isDefined(cracked))
    glasshealth = 99;
  else
    glasshealth = 250;

  self setcandamage(1);

  while(glasshealth > 0) {
    self waittill("damage", damage, attacker, direction_vec, point, damagetype);

    if(!isDefined(direction_vec))
      direction_vec = (0, 0, 1);

    if(!isDefined(damagetype))
      damage = 100000;
    else if(damagetype == "MOD_GRENADE_SPLASH")
      damage = damage * 1.75;
    else if(damagetype == "MOD_IMPACT")
      damage = 100000;

    glasshealth = glasshealth - damage;
  }

  prevdamage = glasshealth * -1;
  self hide();
  self notsolid();

  if(isDefined(cracked)) {
    cracked show();
    cracked setcandamage(1);
    glasshealth = 200 - prevdamage;
    cracked setcontents(crackedcontents);

    while(glasshealth > 0) {
      cracked waittill("damage", damage, other, direction_vec, point, damagetype);

      if(!isDefined(direction_vec))
        direction_vec = (0, 0, 1);

      if(!isDefined(damagetype))
        damage = 100000;
      else if(damagetype == "MOD_GRENADE_SPLASH")
        damage = damage * 1.75;
      else if(damagetype == "MOD_IMPACT") {
        break;
      }

      glasshealth = glasshealth - damage;
    }

    cracked delete();
  }

  glass_play_break_fx(self getorigin(), self.destructible_type, direction_vec);
  self delete();
}

glass_play_break_fx(origin, info, direction_vec) {
  thread play_sound_in_space(level._glass_info[info]["breaksnd"], origin);
  playfx(level._glass_info[info]["breakfx"], origin, direction_vec);
  level notify("glass_shatter");
}

oil_spill_think() {
  self.end = getstruct(self.target, "targetname");
  self.start = getstruct(self.end.target, "targetname");
  self.barrel = getclosestent(self.start.origin, getentarray("explodable_barrel", "targetname"));

  if(isDefined(self.barrel)) {
    self.barrel.oilspill = 1;
    self thread oil_spill_burn_after();
  }

  self.extra = getent(self.target, "targetname");
  self setcandamage(1);

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, p, type);

    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker)
      self.damageowner = self;
    else
      self.damageowner = attacker;

    playfx(level.breakables_fx["oilspill"]["spark"], p, direction_vec);
    p = pointonsegmentnearesttopoint(self.start.origin, self.end.origin, p);
    thread oil_spill_burn_section(p);
    self thread oil_spill_burn(p, self.start.origin);
    self thread oil_spill_burn(p, self.end.origin);
    break;
  }

  if(isDefined(self.barrel))
    self.barrel waittill("exploding");

  self.extra delete();
  self hide();
  wait 10;
  self delete();
}

oil_spill_burn_after() {
  while(true) {
    self.barrel waittill("damage", amount, attacker, direction_vec, p, type);

    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.barrel.script_selfisattacker) && self.barrel.script_selfisattacker)
      self.damageowner = self.barrel;
    else
      self.damageowner = attacker;

    break;
  }

  self radiusdamage(self.start.origin, 4, 10, 10, self.damageowner);
}

oil_spill_burn(p, dest) {
  forward = vectornormalize(dest - p);
  dist = distance(p, dest);
  interval = vectorscale(forward, 8);
  angle = vectortoangles(forward);
  right = anglestoright(angle);
  barrels = getentarray("explodable_barrel", "targetname");
  test = spawn("script_origin", p);
  num = 0;

  while(true) {
    dist = dist - 8;

    if(dist < 8 * 0.1) {
      break;
    }

    p = p + (interval + vectorscale(right, randomfloatrange(-6, 6)));
    thread oil_spill_burn_section(p);
    num++;

    if(num == 4) {
      badplace_cylinder("", 5, p, 64, 64);
      num = 0;
    }

    test.origin = p;
    remove = [];
    arrayremovevalue(barrels, undefined);

    for(i = 0; i < barrels.size; i++) {
      vec = anglestoup(barrels[i].angles);
      start = barrels[i].origin + vectorscale(vec, 22);
      pos = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));

      if(distancesquared(p, pos) < 484) {
        remove[remove.size] = barrels[i];
        barrels[i] dodamage(80 + randomfloat(10), p);
      }
    }

    for(i = 0; i < remove.size; i++)
      arrayremovevalue(barrels, remove[i]);

    wait 0.1;
  }

  if(!isDefined(self.barrel)) {
    return;
  }
  if(distancesquared(p, self.start.origin) < 1024)
    self.barrel dodamage(80 + randomfloat(10), p);
}

oil_spill_burn_section(p) {
  playfx(level.breakables_fx["oilspill"]["burn"], p);
}

explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["exploding_barrel_test"])) {
    level.precachemodeltype["exploding_barrel_test"] = 1;
    precachemodel("global_explosive_barrel_d");
  }

  self endon("exploding");
  self breakable_clip();
  self xenon_auto_aim();
  self.damagetaken = 0;
  self setcandamage(1);

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, p, type);

    println("BARRELDAMAGE: " + type);

    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && (!isplayer(attacker) && (isDefined(attacker.classname) && attacker.classname != "worldspawn"))) {
      continue;
    }
    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker)
      self.damageowner = self;
    else
      self.damageowner = attacker;

    if(level.barrelexplodingthisframe)
      wait(randomfloat(1));

    self.damagetaken = self.damagetaken + amount;

    if(self.damagetaken == amount)
      self thread explodable_barrel_burn();
  }
}

explodable_barrel_burn() {
  count = 0;
  startedfx = 0;
  up = anglestoup(self.angles);
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset1 = (0, 0, 0);
  offset2 = vectorscale(up, 44);

  if(dot < 0.5) {
    offset1 = vectorscale(up, 22) - vectorscale((0, 0, 1), 30.0);
    offset2 = vectorscale(up, 22) + vectorscale((0, 0, 1), 14.0);
  }

  while(self.damagetaken < level.barrelhealth) {
    if(!startedfx) {
      playfx(level.breakables_fx["barrel"]["burn_start"], self.origin + offset1);
      level thread play_sound_in_space(level.barrelingsound, self.origin);
      startedfx = 1;
    }

    if(count > 20)
      count = 0;

    if(count == 0) {
      self.damagetaken = self.damagetaken + (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
      self playsound("exp_barrel_fuse");
      playfx(level.breakables_fx["barrel"]["burn"], self.origin + offset2);
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
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset = (0, 0, 0);

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    end = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    offset = end - self.origin;
  }

  offset = offset + vectorscale((0, 0, 1), 4.0);
  level thread play_sound_in_space(level.barrelexpsound, self.origin);
  playfx(level.breakables_fx["barrel"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);
  playrumbleonposition("barrel_explosion", self.origin + vectorscale((0, 0, 1), 32.0));
  level.barrelexplodingthisframe = 1;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  maxdamage = 250;

  if(isDefined(self.script_damage))
    maxdamage = self.script_damage;

  blastradius = 250;

  if(isDefined(self.radius))
    blastradius = self.radius;

  attacker = undefined;

  if(isDefined(self.damageowner))
    attacker = self.damageowner;

  level.lastexplodingbarrel["time"] = gettime();
  level.lastexplodingbarrel["origin"] = self.origin + vectorscale((0, 0, 1), 30.0);
  self radiusdamage(self.origin + vectorscale((0, 0, 1), 30.0), blastradius, maxdamage, 1, attacker);

  if(randomint(2) == 0)
    self setmodel("global_explosive_barrel_d");
  else
    self setmodel("global_explosive_barrel_d");

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    pos = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    self.origin = pos;
    self.angles = self.angles + vectorscale((0, 0, 1), 90.0);
  }

  waittillframeend;
  level.barrelexplodingthisframe = 0;
}

explodable_tarpcrate_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["static_peleliu_crate_tarp"])) {
    level.precachemodeltype["static_peleliu_crate_tarp"] = 1;
    precachemodel("static_peleliu_crate_tarp_d");
  }

  self endon("exploding");
  self breakable_clip();
  self xenon_auto_aim();
  self.damagetaken = 0;
  self setcandamage(1);

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, p, type);

    println("TARPCRATEDAMAGE: " + type);

    if(type == "MOD_MELEE" || type == "MOD_IMPACT") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker)
      self.damageowner = self;
    else
      self.damageowner = attacker;

    if(level.barrelexplodingthisframe)
      wait(randomfloat(1));

    self.damagetaken = self.damagetaken + amount;

    if(self.damagetaken == amount)
      self thread explodable_tarpcrate_burn();
  }
}

explodable_tarpcrate_burn() {
  count = 0;
  startedfx = 0;
  up = anglestoup(self.angles);
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset1 = (0, 0, 0);
  offset2 = vectorscale(up, 44);

  if(dot < 0.5) {
    offset1 = vectorscale(up, 22) - vectorscale((0, 0, 1), 30.0);
    offset2 = vectorscale(up, 22) + vectorscale((0, 0, 1), 14.0);
  }

  while(self.damagetaken < level.tankhealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.barrelingsound, self.origin);
      startedfx = 1;
    }

    if(count > 20)
      count = 0;

    if(count == 0) {
      self.damagetaken = self.damagetaken + (10 + randomfloat(10));
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
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset = (0, 0, 0);

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 32);
    end = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    offset = end - self.origin;
  }

  offset = offset + vectorscale((0, 0, 1), 4.0);
  level thread play_sound_in_space(level.tarpcrateexpsound, self.origin);
  playfx(level.breakables_fx["tarpcrate"]["explode"], self.origin + offset);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);
  level.barrelexplodingthisframe = 1;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  blastradius = 1;

  if(isDefined(self.radius))
    blastradius = self.radius;

  attacker = undefined;

  if(isDefined(self.damageowner))
    attacker = self.damageowner;

  level.lastexplodingbarrel["time"] = gettime();
  level.lastexplodingbarrel["origin"] = self.origin + vectorscale((0, 0, 1), 30.0);
  self radiusdamage(self.origin + vectorscale((0, 0, 1), 30.0), blastradius, 100, 50, attacker);

  if(randomint(2) == 0)
    self setmodel("static_peleliu_crate_tarp_d");
  else
    self setmodel("static_peleliu_crate_tarp_d");

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    pos = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    self.origin = pos;
    self.angles = self.angles + vectorscale((0, 0, 1), 90.0);
  }

  wait 0.05;
  level.barrelexplodingthisframe = 0;
}

flammable_crate_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["global_flammable_crate_jap_single"])) {
    level.precachemodeltype["global_flammable_crate_jap_single"] = 1;
    precachemodel("global_flammable_crate_jap_piece01_d");
    precachemodel("global_flammable_crate_jap_piece02_d");
    precachemodel("global_flammable_crate_jap_piece03_d");
    precachemodel("global_flammable_crate_jap_piece04_d");
    precachemodel("global_flammable_crate_jap_piece05_d");
    precachemodel("global_flammable_crate_jap_piece06_d");
  }

  self endon("exploding");
  self breakable_clip();
  self xenon_auto_aim();
  self.damagetaken = 0;
  self setcandamage(1);

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, p, type);

    if(type != "MOD_BURNED" && type != "MOD_EXPLOSIVE" && type != "MOD_PROJECTILE_SPLASH" && type != "MOD_PROJECTILE" && type != "MOD_GRENADE_SPLASH" && type != "MOD_GRENADE") {
      continue;
    }
    if(isDefined(self.script_requires_player) && self.script_requires_player && !isplayer(attacker)) {
      continue;
    }
    if(isDefined(self.script_selfisattacker) && self.script_selfisattacker)
      self.damageowner = self;
    else
      self.damageowner = attacker;

    if(level.barrelexplodingthisframe)
      wait(randomfloat(1));

    self.damagetaken = self.damagetaken + amount;

    if(self.damagetaken == amount)
      self thread flammable_crate_burn();
  }
}

flammable_crate_burn() {
  count = 0;
  startedfx = 0;
  up = anglestoup(self.angles);
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset1 = (0, 0, 0);
  offset2 = vectorscale(up, 44);

  if(dot < 0.5) {
    offset1 = vectorscale(up, 22) - vectorscale((0, 0, 1), 30.0);
    offset2 = vectorscale(up, 22) + vectorscale((0, 0, 1), 14.0);
  }

  while(self.damagetaken < level.barrelhealth) {
    if(!startedfx) {
      level thread play_sound_in_space(level.crateignsound, self.origin);
      startedfx = 1;
    }

    if(count > 20)
      count = 0;

    if(count == 0) {
      self.damagetaken = self.damagetaken + (10 + randomfloat(10));
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
  worldup = anglestoup(vectorscale((0, 1, 0), 90.0));
  dot = vectordot(up, worldup);
  offset = (0, 0, 0);

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    end = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    offset = end - self.origin;
  }

  offset = offset + vectorscale((0, 0, 1), 4.0);
  level thread play_sound_in_space(level.crateexpsound, self.origin);
  playfx(level.breakables_fx["ammo_crate"]["explode"], self.origin);
  physicsexplosionsphere(self.origin + offset, 100, 80, 1);
  level.barrelexplodingthisframe = 1;

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  blastradius = 250;

  if(isDefined(self.radius))
    blastradius = self.radius;

  attacker = undefined;

  if(isDefined(self.damageowner))
    attacker = self.damageowner;

  self radiusdamage(self.origin + vectorscale((0, 0, 1), 30.0), blastradius, 250, 1, attacker);

  if(randomint(2) == 0)
    self setmodel("global_flammable_crate_jap_piece01_d");
  else
    self setmodel("global_flammable_crate_jap_piece01_d");

  if(dot < 0.5) {
    start = self.origin + vectorscale(up, 22);
    pos = physicstrace(start, start + vectorscale((0, 0, -1), 64.0));
    self.origin = pos;
    self.angles = self.angles + vectorscale((0, 0, 1), 90.0);
  }

  wait 0.05;
  level.barrelexplodingthisframe = 0;
}

shuddering_entity_think() {
  assert(self.classname == "script_model");
  helmet = 0;

  if(self.model == "prop_helmet_german_normandy")
    helmet = 1;

  self setcandamage(1);

  for(;;) {
    self waittill("damage", other, damage, direction_vec, point);

    if(helmet)
      self vibrate(direction_vec, 20, 0.6, 0.75);
    else
      self vibrate(direction_vec, 0.4, 0.4, 0.4);

    self waittill("rotatedone");
  }
}

tincan_think() {
  if(self.classname != "script_model") {
    return;
  }
  self setcandamage(1);
  self waittill("damage", damage, ent);

  if(issentient(ent))
    direction_org = ent geteye() - (0, 0, randomint(50) + 50);
  else
    direction_org = ent.origin;

  direction_vec = vectornormalize(self.origin - direction_org);
  direction_vec = vectorscale(direction_vec, 0.5 + randomfloat(1));
  self notify("death");
  playfx(level.breakables_fx["tincan"], self.origin, direction_vec);
  self delete();
}

helmet_pop() {
  if(self.classname != "script_model") {
    return;
  }
  self xenon_auto_aim();
  self setcandamage(1);
  self thread helmet_logic();
}

helmet_logic() {
  self waittill("damage", damage, ent);

  if(issentient(ent))
    direction_org = ent geteye();
  else
    direction_org = ent.origin;

  direction_vec = vectornormalize(self.origin - direction_org);

  if(!isDefined(self.dontremove) && ent == level.player) {
    self thread animscripts\death::helmetlaunch(direction_vec);
    return;
  }

  self notsolid();
  self hide();
  model = spawn("script_model", self.origin + vectorscale((0, 0, 1), 5.0));
  model.angles = self.angles;
  model setmodel(self.model);
  model thread animscripts\death::helmetlaunch(direction_vec);
  self.dontremove = 0;
  self notify("ok_remove");
}

allowbreak(ent) {
  if(!isDefined(level.breakingents))
    return true;

  if(level.breakingents.size == 0)
    return false;
  else {
    for(i = 0; i < level.breakingents.size; i++) {
      if(ent == level.breakingents[i])
        return true;
    }

    return false;
  }

  return true;
}

breakable_think_triggered(ebreakable) {
  for(;;) {
    self waittill("trigger", other);
    ebreakable damage_notify_wrapper(100, other);
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
      level.precachemodeltype["egypt_prop_vase_o"] = 1;
      precachemodel("egypt_prop_vase_br2");
      precachemodel("egypt_prop_vase_br5");
      precachemodel("egypt_prop_vase_br7");
    }

    type = "orange vase";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "egypt_prop_vase2" || self.model == "egypt_prop_vase5" || self.model == "egypt_prop_vase6") {
    if(!isDefined(level.precachemodeltype["egypt_prop_vase_g"])) {
      level.precachemodeltype["egypt_prop_vase_g"] = 1;
      precachemodel("egypt_prop_vase_br1");
      precachemodel("egypt_prop_vase_br3");
      precachemodel("egypt_prop_vase_br4");
      precachemodel("egypt_prop_vase_br6");
    }

    type = "green vase";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "prop_crate_dak1" || self.model == "prop_crate_dak2" || self.model == "prop_crate_dak3" || self.model == "prop_crate_dak4" || self.model == "prop_crate_dak5" || self.model == "prop_crate_dak6" || self.model == "prop_crate_dak7" || self.model == "prop_crate_dak8" || self.model == "prop_crate_dak9") {
    if(!isDefined(level.precachemodeltype["prop_crate_dak_shard"])) {
      level.precachemodeltype["prop_crate_dak_shard"] = 1;
      precachemodel("prop_crate_dak_shard");
    }

    type = "wood box";
    self breakable_clip();
    self xenon_auto_aim();
  } else if(self.model == "prop_winebottle_breakable") {
    if(!isDefined(level.precachemodeltype["prop_winebottle"])) {
      level.precachemodeltype["prop_winebottle"] = 1;
      precachemodel("prop_winebottle_broken_top");
      precachemodel("prop_winebottle_broken_bot");
    }

    type = "bottle";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
    }

    type = "plate";
    self.plate = "round_floral";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    type = "plate";
    self.plate = "round_plain";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_roundstack") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
    }

    type = "plate";
    self.plate = "round_stack";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
    }

    type = "plate";
    self.plate = "oval_floral";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    type = "plate";
    self.plate = "oval_plain";
    self xenon_auto_aim();
  } else if(self.model == "prop_diningplate_ovalstack") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
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

    if(isDefined(trig) && trig.classname == "trigger_multiple")
      trig thread breakable_think_triggered(self);
  }

  self setcandamage(1);
  self thread breakable_logic(type);
}

breakable_logic(type) {
  ent = undefined;

  for(;;) {
    self waittill("damage", amount, ent);

    if(isDefined(ent) && ent.classname == "script_vehicle")
      ent joltbody(self.origin + vectorscale((0, 0, -1), 90.0), 0.2);

    if(type == "wood box") {
      if(!allowbreak(ent)) {
        continue;
      }
      if(!isDefined(level.flags) || !isDefined(level.flags["Breakable Boxes"])) {
        break;
      }

      if(isDefined(level.flags["Breakable Boxes"]) && level.flags["Breakable Boxes"] == 1) {
        break;
      }
    } else
      break;
  }

  self notify("death");
  soundalias = undefined;
  fx = undefined;
  hasdependant = 0;

  switch (type) {
    case "green vase":
    case "orange vase":
      soundalias = "bullet_large_vase";
      fx = level.breakables_fx["vase"];
      break;
    case "wood box":
      if(isDefined(level.crateimpactsound))
        soundalias = level.crateimpactsound;
      else
        soundalias = "bullet_large_vase";

      fx = level.breakables_fx["box"][randomint(level.breakables_fx["box"].size)];
      hasdependant = 1;
      break;
    case "bottle":
      soundalias = "bullet_small_bottle";
      fx = level.breakables_fx["bottle"];
      break;
    case "plate":
      soundalias = "bullet_small_plate";
      break;
  }

  thread play_sound_in_space(soundalias, self.origin);
  self thread make_broken_peices(self, type);

  if(isDefined(fx))
    playfx(fx, self.origin);

  if(hasdependant) {
    others = getentarray("breakable", "targetname");

    for(i = 0; i < others.size; i++) {
      other = others[i];
      diffx = abs(self.origin[0] - other.origin[0]);
      diffy = abs(self.origin[1] - other.origin[1]);

      if(diffx <= 20 && diffy <= 20) {
        diffz = self.origin[2] - other.origin[2];

        if(diffz <= 0)
          other notify("damage", amount, ent);
      }
    }
  }

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  if(!isDefined(self.dontremove))
    self delete();
  else {
    self.dontremove = 0;
    self notify("ok_remove");
  }
}

xenon_auto_aim() {
  if(isDefined(level.console_auto_aim) && level.console_auto_aim.size > 0)
    self.autoaim = getclosestaccurantent(self.origin, level.console_auto_aim);

  if(isDefined(self.autoaim)) {
    arrayremovevalue(level.console_auto_aim, self.autoaim);
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
  self.dontremove = 1;
  self waittill("damage", amount, ent);
  self.autoaim disableaimassist();
  self.autoaim delete();

  if(self.dontremove)
    self waittill("ok_remove");

  self delete();
}

xenon_enable_auto_aim(wait_message) {
  self endon("xenon_auto_aim_stop_logic");
  self endon("death");

  if(!isDefined(wait_message))
    wait_message = 1;

  if(isDefined(self.script_noteworthy) && wait_message) {
    string = "enable_xenon_autoaim_" + self.script_noteworthy;
    level waittill(string);
  }

  self.wait_message = 0;

  if(isDefined(self.recreate) && self.recreate == 1)
    self waittill("recreate");

  self enableaimassist();
}

breakable_clip() {
  if(isDefined(self.target)) {
    targ = getent(self.target, "targetname");

    if(targ.classname == "script_brushmodel") {
      self.remove = targ;
      return;
    }
  }

  if(isDefined(level.breakables_clip) && level.breakables_clip.size > 0)
    self.remove = getclosestent(self.origin, level.breakables_clip);

  if(isDefined(self.remove))
    arrayremovevalue(level.breakables_clip, self.remove);
}

getfurthestent(org, array) {
  if(array.size < 1) {
    return;
  }
  distsq = distancesquared(array[0] getorigin(), org);
  ent = array[0];

  for(i = 0; i < array.size; i++) {
    newdistsq = distancesquared(array[i] getorigin(), org);

    if(newdistsq < distsq) {
      continue;
    }
    distsq = newdistsq;
    ent = array[i];
  }

  return ent;
}

getclosestent(org, array) {
  if(array.size < 1) {
    return;
  }
  distsq = 65536;
  ent = undefined;

  for(i = 0; i < array.size; i++) {
    newdistsq = distancesquared(array[i] getorigin(), org);

    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    ent = array[i];
  }

  return ent;
}

make_broken_peices(wholepiece, type) {
  rt = anglestoright(wholepiece.angles);
  fw = anglestoforward(wholepiece.angles);
  up = anglestoup(wholepiece.angles);
  piece = [];

  switch (type) {
    case "orange vase":
      piece[piece.size] = addpiece(rt, fw, up, -7, 0, 22, wholepiece, (0, 0, 0), "egypt_prop_vase_br2");
      piece[piece.size] = addpiece(rt, fw, up, 13, -6, 28, wholepiece, vectorscale((0, 1, 0), 245.1), "egypt_prop_vase_br7");
      piece[piece.size] = addpiece(rt, fw, up, 12, 10, 27, wholepiece, vectorscale((0, 1, 0), 180.0), "egypt_prop_vase_br7");
      piece[piece.size] = addpiece(rt, fw, up, 3, 2, 0, wholepiece, (0, 0, 0), "egypt_prop_vase_br5");
      break;
    case "green vase":
      piece[piece.size] = addpiece(rt, fw, up, -6, -1, 26, wholepiece, (0, 0, 0), "egypt_prop_vase_br1");
      piece[piece.size] = addpiece(rt, fw, up, 12, 1, 31, wholepiece, vectorscale((0, 1, 0), 348.5), "egypt_prop_vase_br3");
      piece[piece.size] = addpiece(rt, fw, up, 6, 13, 29, wholepiece, vectorscale((0, 1, 0), 153.5), "egypt_prop_vase_br6");
      piece[piece.size] = addpiece(rt, fw, up, 3, 1, 0, wholepiece, (0, 0, 0), "egypt_prop_vase_br4");
      break;
    case "wood box":
      piece[piece.size] = addpiece(rt, fw, up, -10, 10, 25, wholepiece, (0, 0, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, 10, 25, wholepiece, vectorscale((0, 1, 0), 90.0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, -10, 25, wholepiece, vectorscale((0, 1, 0), 180.0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, -10, 25, wholepiece, vectorscale((0, 1, 0), 270.0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, 10, 5, wholepiece, vectorscale((1, 0, 0), 180.0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, 10, -10, 5, wholepiece, (180, 90, 0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, -10, 5, wholepiece, vectorscale((1, 1, 0), 180.0), "prop_crate_dak_shard");
      piece[piece.size] = addpiece(rt, fw, up, -10, 10, 5, wholepiece, (180, 270, 0), "prop_crate_dak_shard");
      break;
    case "bottle":
      piece[piece.size] = addpiece(rt, fw, up, 0, 0, 10, wholepiece, (0, 0, 0), "prop_winebottle_broken_top");
      piece[piece.size - 1].type = "bottle_top";
      piece[piece.size] = addpiece(rt, fw, up, 0, 0, 0, wholepiece, (0, 0, 0), "prop_winebottle_broken_bot");
      piece[piece.size - 1].type = "bottle_bot";
      break;
    case "plate":
      switch (wholepiece.plate) {
        case "round_floral":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 150.0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, 0.5, wholepiece, vectorscale((0, 1, 0), 149.8), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 146.8), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "round_plain":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 150.0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, 0.5, wholepiece, vectorscale((0, 1, 0), 149.8), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 146.8), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
        case "round_stack":
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 150.0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, 0.5, wholepiece, vectorscale((0, 1, 0), 149.8), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 146.8), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 3, 2.5, wholepiece, vectorscale((0, 1, 0), 60.0), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -1, -3, 2.5, wholepiece, vectorscale((0, 1, 0), 59.8), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, -1, 2.5, wholepiece, vectorscale((0, 1, 0), 60.2), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, 4, 2.5, wholepiece, vectorscale((0, 1, 0), 56.8), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -4, 4.5, wholepiece, vectorscale((0, 1, 0), 150.0), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, -2, 4.5, wholepiece, vectorscale((0, 1, 0), 149.8), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 1, 2, 4.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 2, 4.5, wholepiece, vectorscale((0, 1, 0), 146.8), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_floral":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 205.9), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, 0.5, wholepiece, vectorscale((0, 1, 0), 352.2), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, 0.5, wholepiece, vectorscale((0, 1, 0), 102.3), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, 0.5, wholepiece, vectorscale((0, 1, 0), 246.7), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_plain":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 205.9), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, 0.5, wholepiece, vectorscale((0, 1, 0), 352.2), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, 0.5, wholepiece, vectorscale((0, 1, 0), 102.3), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, 0.5, wholepiece, vectorscale((0, 1, 0), 246.7), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
        case "oval_stack":
          piece[piece.size] = addpiece(rt, fw, up, 4, -4, 0.5, wholepiece, vectorscale((0, 1, 0), 205.9), "prop_diningplate_brokenfloral1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -6, 1, 0.5, wholepiece, vectorscale((0, 1, 0), 352.2), "prop_diningplate_brokenfloral2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 4, 2, 0.5, wholepiece, vectorscale((0, 1, 0), 150.2), "prop_diningplate_brokenfloral3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -2, 5, 0.5, wholepiece, vectorscale((0, 1, 0), 102.3), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -3, -3, 0.5, wholepiece, vectorscale((0, 1, 0), 246.7), "prop_diningplate_brokenfloral4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, 5, 2.5, wholepiece, vectorscale((0, 1, 0), 25.9), "prop_diningplate_brokenplain1");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 6, 0, 2.5, wholepiece, vectorscale((0, 1, 0), 172.2), "prop_diningplate_brokenplain2");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, -4, -1, 2.5, wholepiece, vectorscale((0, 1, 0), 330.2), "prop_diningplate_brokenplain3");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 2, -4, 2.5, wholepiece, vectorscale((0, 1, 0), 282.3), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          piece[piece.size] = addpiece(rt, fw, up, 3, 4, 2.5, wholepiece, vectorscale((0, 1, 0), 66.7), "prop_diningplate_brokenplain4");
          piece[piece.size - 1].type = "plate";
          break;
      }

      break;
    default:
      return;
  }

  array_thread(piece, ::pieces_move, wholepiece.origin);

  if(isDefined(level.breakables_peicescollide[type]) && level.breakables_peicescollide[type] == 1) {
    height = piece[0].origin[2];

    for(i = 0; i < piece.size; i++) {
      if(height > piece[i].origin[2])
        height = piece[i].origin[2];
    }

    array_thread(piece, ::pieces_collision, height);
  } else {
    wait 2;

    for(i = 0; i < piece.size; i++) {
      if(isDefined(piece[i]))
        piece[i] delete();
    }
  }
}

list_add(model) {
  if(isDefined(level._breakable_utility_modelarray[level._breakable_utility_modelindex]))
    level._breakable_utility_modelarray[level._breakable_utility_modelindex] delete();

  level._breakable_utility_modelarray[level._breakable_utility_modelindex] = model;
  level._breakable_utility_modelindex++;

  if(!(level._breakable_utility_modelindex < level._breakable_utility_maxnum))
    level._breakable_utility_modelindex = 0;
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

    if(randomint(100) > 50)
      x = -1;

    if(randomint(100) > 50)
      y = -1;

    if(randomint(100) > 50)
      z = -1;

    org rotatevelocity((250 * x, 250 * y, randomfloat(100) * z), 2, 0, 0.5);
  } else if(isDefined(self.type) && self.type == "plate") {
    vec = vectornormalize(end - origin);
    vec = vectorscale(vec, 125 + randomfloat(25));

    if(randomint(100) > 50)
      org rotateroll((800 + randomfloat(4000)) * -1, 5, 0, 0);
    else
      org rotateroll(800 + randomfloat(4000), 5, 0, 0);
  } else {
    vec = vectornormalize(end - origin);
    vec = vectorscale(vec, 60 + randomfloat(50));

    if(randomint(100) > 50)
      org rotateroll((800 + randomfloat(1000)) * -1, 5, 0, 0);
    else
      org rotateroll(800 + randomfloat(1000), 5, 0, 0);
  }

  org movegravity(vec, 5);
  wait 5;

  if(isDefined(self))
    self unlink();

  org delete();
}

pieces_collision(height) {
  self endon("death");
  wait 0.1;
  trace = bullettrace(self.origin, self.origin - vectorscale((0, 0, 1), 50000.0), 0, undefined);
  vec = trace["position"];

  while(self.origin[2] > vec[2])
    wait 0.05;

  self unlink();
  self.origin = (self.origin[0], self.origin[1], vec[2]);
  self notify("do not kill");
  self unlink();
}

addpiece(rt, fw, up, xs, ys, zs, wholepiece, angles, model) {
  x = rt;
  y = fw;
  z = up;
  x = vectorscale(x, ys * 1);
  y = vectorscale(y, xs * 1);
  z = vectorscale(z, zs * 1);
  origin = wholepiece.origin + x + y + z;
  part = spawn("script_model", origin);
  part setmodel(model);
  part.modelscale = 1;
  part.angles = wholepiece.angles + angles;
  list_add(part);
  return part;
}

getclosestaccurantent(org, array) {
  if(array.size < 1) {
    return;
  }
  distsq = 64;
  ent = undefined;

  for(i = 0; i < array.size; i++) {
    newdistsq = distancesquared(array[i] getorigin(), org);

    if(newdistsq >= distsq) {
      continue;
    }
    distsq = newdistsq;
    ent = array[i];
  }

  return ent;
}