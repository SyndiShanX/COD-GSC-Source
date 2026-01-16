/******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_explosive_barrels.gsc
******************************************/

main() {
  var_0 = 0;
  precacheitem("barrel_mp");
  var_1 = getentarray("explodable_barrel", "targetname");

  if(isdefined(var_1) && var_1.size > 0)
    var_0 = 1;

  if(var_0) {
    level.breakables_fx["barrel"]["explode"] = loadfx("fx\props\barrelExp");
    level.breakables_fx["barrel"]["burn_start"] = loadfx("vfx\map\mp_citystreets\barrel_ignite_01");
    level.breakables_fx["barrel"]["burn"] = loadfx("vfx\map\mp_citystreets\barrel_fire_top_01");
  }

  var_2 = getentarray("oil_spill", "targetname");

  if(isdefined(var_2) && var_2.size > 0) {
    level.breakables_fx["oilspill"]["burn"] = loadfx("fx\props\barrel_fire");
    level.breakables_fx["oilspill"]["spark"] = loadfx("fx\impacts\small_metalhit_1");
  }

  level.barrelexpsound = "h1_redbarrel_exp";
  level.barrelhealth = 150;
  var_3 = 25;
  level.precachemodeltype = [];
  level.barrelexplodingthisframe = 0;
  level.breakables_clip = [];
  var_4 = getentarray("breakable clip", "targetname");

  for (var_5 = 0; var_5 < var_4.size; var_5++)
    level.breakables_clip[level.breakables_clip.size] = var_4[var_5];

  level._breakable_utility_modelarray = [];
  level._breakable_utility_modelindex = 0;
  level._breakable_utility_maxnum = var_3;
  common_scripts\utility::array_thread(getentarray("explodable_barrel", "targetname"), ::explodable_barrel_think);
  common_scripts\utility::array_thread(getentarray("oil_spill", "targetname"), ::oil_spill_think);
}

oil_spill_think() {
  self.end = getstruct(self.target, "targetname");
  self.start = getstruct(self.end.target, "targetname");
  self.barrel = getclosestent(self.start.origin, getentarray("explodable_barrel", "targetname"));
  self.extra = getent(self.target, "targetname");
  self setcandamage(1);

  if(isdefined(self.barrel)) {
    self.barrel.oilspill = 1;
    thread oil_spill_burn_after();
  }

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    self.damageowner = var_0;
    playfx(level.breakables_fx["oilspill"]["spark"], var_3, var_2);
    thread oil_spill_burn_section(var_3);
    thread oil_spill_burn(var_3, self.start.origin);
    thread oil_spill_burn(var_3, self.end.origin);
    break;
  }

  if(isdefined(self.barrel))
    self.barrel waittill("exploding");

  self.extra delete();
  self hide();
  wait 10;
  self delete();
}

getclosestent(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = 256;
  var_3 = undefined;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

oil_spill_burn_after() {
  for (;;) {
    self.barrel waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    break;
  }

  self.damageowner = var_1;

  if(!isdefined(self.damageowner))
    self radiusdamage(self.origin, 4, 10, 10);
  else
    self radiusdamage(self.origin, 4, 10, 10, self.damageowner);
}

oil_spill_burn(var_0, var_1) {
  var_2 = vectornormalize(var_1 - var_0);
  var_3 = distance(var_0, var_1);
  var_4 = 8;
  var_5 = var_2 * var_4;
  var_6 = vectortoangles(var_2);
  var_7 = anglestoright(var_6);
  var_8 = getentarray("explodable_barrel", "targetname");
  var_9 = 484;
  var_10 = spawn("script_origin", var_0);
  var_10 hide();
  var_11 = 0;

  for (;;) {
    var_3 = var_3 - var_4;

    if(var_3 < var_4 * 0.1) {
      break;
    }

    var_0 = var_0 + (var_5 + var_7 * randomfloatrange(-6, 6));
    thread oil_spill_burn_section(var_0);
    var_11++;

    if(var_11 == 4)
      var_11 = 0;

    var_10.origin = var_0;
    var_12 = [];
    var_8 = common_scripts\utility::array_removeundefined(var_8);

    for (var_13 = 0; var_13 < var_8.size; var_13++) {
      var_14 = anglestoup(var_8[var_13].angles);
      var_15 = var_8[var_13].origin + var_14 * 22;
      var_16 = physicstrace(var_15, var_15 + (0, 0, -64));

      if(distancesquared(var_0, var_16) < var_9) {
        var_12[var_12.size] = var_8[var_13];
        var_17 = 80 + randomfloat(10);

        if(!isdefined(self.damageowner))
          self radiusdamage(var_8[var_13].origin, 4, var_17, var_17);
        else
          self radiusdamage(var_8[var_13].origin, 4, var_17, var_17, self.damageowner);
      }
    }

    for (var_13 = 0; var_13 < var_12.size; var_13++)
      var_8 = common_scripts\utility::array_remove(var_8, var_12[var_13]);

    wait 0.1;
  }

  if(!isdefined(self.barrel)) {
    return;
  }
  if(distance(var_0, self.start.origin) < 32) {
    var_17 = 80 + randomfloat(10);

    if(!isdefined(self.damageowner))
      self radiusdamage(self.barrel.origin, 4, var_17, var_17);
    else
      self radiusdamage(self.barrel.origin, 4, var_17, var_17, self.damageowner);
  }
}

oil_spill_burn_section(var_0) {
  var_1 = 0;
  var_2 = 0;
  playfx(level.breakables_fx["oilspill"]["burn"], var_0);

  while (var_2 < 5) {
    if(!isdefined(self.damageowner))
      self radiusdamage(var_0, 32, 5, 1);
    else
      self radiusdamage(var_0, 32, 5, 1, self.damageowner);

    var_2 = var_2 + 1;
    wait 1;
  }
}

explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isdefined(level.precachemodeltype["com_barrel_benzin"])) {
    level.precachemodeltype["com_barrel_benzin"] = 1;
    precachemodel("com_barrel_piece");
    precachemodel("com_barrel_piece2");
  }

  self endon("exploding");
  breakable_clip();
  self.damagetaken = 0;
  self setcandamage(1);

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    self.damagetype = var_4;
    self.damageowner = var_1;

    if(level.barrelexplodingthisframe)
      wait(randomfloat(1));

    self.damagetaken = self.damagetaken + var_0;

    if(self.damagetaken == var_0)
      thread explodable_barrel_burn();
  }
}

explodable_barrel_burn() {
  var_0 = 0;
  var_1 = 0;
  var_2 = anglestoup(self.angles);
  var_3 = anglestoup((0, 90, 0));
  var_4 = vectordot(var_2, var_3);
  var_5 = (0, 0, 0);
  var_6 = var_2 * 44;

  if(var_4 < 0.5) {
    var_5 = var_2 * 22 - (0, 0, 30);
    var_6 = var_2 * 22 + (0, 0, 14);
  }

  if(self.damagetype != "MOD_GRENADE_SPLASH" && self.damagetype != "MOD_GRENADE") {
    while (self.damagetaken < level.barrelhealth) {
      if(!var_1) {
        playfx(level.breakables_fx["barrel"]["burn_start"], self.origin + var_5);
        var_1 = 1;
      }

      if(var_0 > 20)
        var_0 = 0;

      playfx(level.breakables_fx["barrel"]["burn"], self.origin + var_6);

      if(var_0 == 0)
        self.damagetaken = self.damagetaken + (10 + randomfloat(10));

      var_0++;
      wait 0.05;
    }
  }

  thread explodable_barrel_explode();
}

explodable_barrel_explode() {
  self notify("exploding");
  self notify("death");
  var_0 = anglestoup(self.angles);
  var_1 = anglestoup((0, 90, 0));
  var_2 = vectordot(var_0, var_1);
  var_3 = (0, 0, 0);

  if(var_2 < 0.5) {
    var_4 = self.origin + var_0 * 22;
    var_5 = physicstrace(var_4, var_4 + (0, 0, -64));
    var_3 = var_5 - self.origin;
  }

  var_3 = var_3 + (0, 0, 4);
  self playsound(level.barrelexpsound);
  playfx(level.breakables_fx["barrel"]["explode"], self.origin + var_3);
  level.barrelexplodingthisframe = 1;

  if(isdefined(self.remove))
    self.remove delete();

  var_6 = 2;
  var_7 = 1;
  var_8 = 250;
  var_9 = 250;

  if(isdefined(self.radius))
    var_9 = self.radius;

  if(!isdefined(self.damageowner))
    self radiusdamage(self.origin + (0, 0, 30), var_9, var_8, var_7, undefined, "MOD_EXPLOSIVE", "barrel_mp");
  else
    self radiusdamage(self.origin + (0, 0, 30), var_9, var_8, var_7, self.damageowner, "MOD_EXPLOSIVE", "barrel_mp");

  physicsexplosionsphere(self.origin + (0, 0, 30), var_9, var_9 / 2, var_6);
  maps\mp\gametypes\_shellshock::barrel_earthquake();

  if(randomint(2) == 0)
    self setmodel("com_barrel_piece");
  else
    self setmodel("com_barrel_piece2");

  self setcandamage(0);

  if(var_2 < 0.5) {
    var_4 = self.origin + var_0 * 22;
    var_10 = physicstrace(var_4, var_4 + (0, 0, -64));
    self.origin = var_10;
    self.angles = self.angles + (0, 0, 90);
  }

  wait 0.05;
  level.barrelexplodingthisframe = 0;
}

getstruct(var_0, var_1) {
  if(!isdefined(level.struct_class_names))
    return undefined;

  var_2 = level.struct_class_names[var_1][var_0];

  if(!isdefined(var_2))
    return undefined;

  if(var_2.size > 1)
    return undefined;

  return var_2[0];
}

breakable_clip() {
  if(isdefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(var_0.classname == "script_brushmodel") {
      self.remove = var_0;
      return;
    }
  }

  if(isdefined(level.breakables_clip) && level.breakables_clip.size > 0)
    self.remove = getclosestent(self.origin, level.breakables_clip);

  if(isdefined(self.remove))
    level.breakables_clip = common_scripts\utility::array_remove(level.breakables_clip, self.remove);
}