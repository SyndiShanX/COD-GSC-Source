/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\320.gsc
**************************************/

main() {
  common_scripts\utility::flag_init("no_ai_tv_damage");
  var_0 = 0;
  var_1 = getEntArray("explodable_barrel", "targetname");

  if(var_1.size) {
    var_0 = 1;

  }
  var_1 = getEntArray("explodable_barrel", "script_noteworthy");

  if(var_1.size > 0) {
    var_0 = 1;

  }
  if(var_0) {
    level.breakables_fx["barrel"]["explode"] = loadfx("props/barrelExp");
    level.breakables_fx["barrel"]["burn_start"] = loadfx("props/barrel_ignite");
    level.breakables_fx["barrel"]["burn"] = loadfx("props/barrel_fire_top");
  }

  var_2 = getEntArray("oil_spill", "targetname");

  if(var_2.size) {
    level.breakables_fx["oilspill"]["burn"] = loadfx("props/barrel_fire");
    level.breakables_fx["oilspill"]["spark"] = loadfx("impacts/small_metalhit_1");
  }

  var_3 = getEntArray("tincan", "targetname");

  if(var_3.size) {
    level.breakables_fx["tincan"] = loadfx("props/tincan_bounce");

  }
  var_4 = 0;
  var_5 = getEntArray("breakable", "targetname");

  if(var_5.size) {
    var_4 = 1;

  }
  var_5 = getEntArray("breakable_vase", "targetname");

  if(var_5.size) {
    var_4 = 1;

  }
  var_5 = getEntArray("breakable box", "targetname");

  if(var_1.size) {
    var_4 = 1;

  }
  var_5 = getEntArray("breakable box", "script_noteworthy");

  if(var_1.size) {
    var_4 = 1;

  }
  if(var_4) {
    level.breakables_fx["vase"] = loadfx("props/vase_water");
    level.breakables_fx["bottle"] = loadfx("props/wine_bottle");
    level.breakables_fx["box"][0] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][1] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][2] = loadfx("props/crateExp_dust");
    level.breakables_fx["box"][3] = loadfx("props/crateExp_ammo");
  }

  var_6 = getEntArray("glass", "targetname");
  var_6 = common_scripts\utility::array_combine(var_6, getEntArray("glass", "script_noteworthy"));

  if(var_6.size) {
    level._id_1DDD = [];
    level._id_1DDD["glass_large"]["breakfx"] = loadfx("props/car_glass_large");
    level._id_1DDD["glass_large"]["breaksnd"] = "veh_glass_break_large";
    level._id_1DDD["glass_med"]["breakfx"] = loadfx("props/car_glass_med");
    level._id_1DDD["glass_med"]["breaksnd"] = "veh_glass_break_small";
    level._id_1DDD["glass_small"]["breakfx"] = loadfx("props/car_glass_headlight");
    level._id_1DDD["glass_small"]["breaksnd"] = "veh_glass_break_small";
  }

  var_7 = getEntArray("interactive_tv", "targetname");

  if(var_7.size) {
    precachemodel("com_tv2_d");
    precachemodel("com_tv1");
    precachemodel("com_tv2");
    precachemodel("com_tv1_testpattern");
    precachemodel("com_tv2_testpattern");
    level.breakables_fx["tv_explode"] = loadfx("explosions/tv_explosion");
  }

  level._id_1DDE = getEntArray("interactive_tv_light", "targetname");
  var_8 = getEntArray("destroyable_security_camera", "script_noteworthy");

  if(var_8.size) {
    precachemodel("com_security_camera");
    precachemodel("com_security_camera_destroyed");
    level.breakables_fx["security_camera_explode"] = loadfx("props/securitycamera_explosion");
  }

  level.barrelexpsound = "barrel_mtl_explode";
  var_9 = 25;
  level._id_1DE0["orange vase"] = 1;
  level._id_1DE0["green vase"] = 1;
  level._id_1DE0["bottle"] = 1;
  level.barrelhealth = 150;
  level.precachemodeltype = [];
  level.barrelexplodingthisframe = 0;
  level.breakables_clip = [];
  level.breakables_clip = getEntArray("vase_break_remove", "targetname");
  level._id_1DE5 = [];
  level._id_1DE5 = getEntArray("xenon_auto_aim", "targetname");
  level._id_1DE6 = getEntArray("xenon_auto_aim_secondary", "targetname");

  for(var_10 = 0; var_10 < level._id_1DE5.size; var_10++) {
    level._id_1DE5[var_10] notsolid();

  }
  for(var_10 = 0; var_10 < level._id_1DE6.size; var_10++) {
    level._id_1DE6[var_10] notsolid();

  }
  maps\_utility::_id_1DE7();

  if(level.console) {
    level._id_1DE5 = undefined;
    level._id_1DE6 = undefined;
  }

  var_11 = getEntArray("breakable clip", "targetname");

  for(var_10 = 0; var_10 < var_11.size; var_10++) {
    level.breakables_clip[level.breakables_clip.size] = var_11[var_10];

  }
  level._breakable_utility_modelarray = [];
  level._breakable_utility_modelindex = 0;
  level._breakable_utility_maxnum = var_9;
  common_scripts\utility::array_thread(getEntArray("tincan", "targetname"), ::_id_1E07);
  common_scripts\utility::array_thread(getEntArray("helmet_pop", "targetname"), ::_id_1E08);
  common_scripts\utility::array_thread(getEntArray("explodable_barrel", "targetname"), ::explodable_barrel_think);
  common_scripts\utility::array_thread(getEntArray("explodable_barrel", "script_noteworthy"), ::explodable_barrel_think);
  common_scripts\utility::array_thread(getEntArray("shuddering_entity", "targetname"), ::_id_1E06);
  common_scripts\utility::array_thread(getEntArray("breakable box", "targetname"), ::_id_1E0E);
  common_scripts\utility::array_thread(getEntArray("breakable box", "script_noteworthy"), ::_id_1E0E);
  common_scripts\utility::array_thread(getEntArray("breakable", "targetname"), ::_id_1E0E);
  common_scripts\utility::array_thread(getEntArray("breakable_vase", "targetname"), ::_id_1E0E);
  common_scripts\utility::array_thread(getEntArray("oil_spill", "targetname"), ::oil_spill_think);
  common_scripts\utility::array_thread(getEntArray("glass", "targetname"), ::_id_1DF7);
  common_scripts\utility::array_thread(getEntArray("interactive_tv", "targetname"), ::_id_1DEC);
  common_scripts\utility::array_thread(getEntArray("destroyable_security_camera", "script_noteworthy"), ::_id_1DEB);
}

_id_1DEB() {
  self setCanDamage(1);
  var_0 = undefined;

  switch (self.model) {
    case "com_security_camera":
      var_0 = "com_security_camera_destroyed";
      break;
  }

  self waittill("damage", var_1, var_2, var_3, var_4, var_5);
  self setModel(var_0);
  playFXOnTag(level.breakables_fx["security_camera_explode"], self, "tag_deathfx");
}

_id_1DEC() {
  self setCanDamage(1);
  self._id_1DED = undefined;
  self._id_1DEE = undefined;
  self._id_1DED = "com_tv2_d";
  self._id_1DEE = "com_tv2";
  self._id_1DEF = "com_tv2_testpattern";

  if(issubstr(self.model, "1")) {
    self._id_1DEE = "com_tv1";
    self._id_1DEF = "com_tv1_testpattern";
  }

  if(isDefined(self.target)) {
    if(isDefined(level._id_1DF0)) {
      var_0 = getent(self.target, "targetname");

      if(isDefined(var_0)) {
        var_0 delete();
      }
    } else {
      self._id_1DF1 = getent(self.target, "targetname");
      self._id_1DF1 usetriggerrequirelookat();
      self._id_1DF1 setcursorhint("HINT_NOICON");
    }
  }

  var_1 = maps\_utility::_id_0AEC(self.origin, level._id_1DDE, undefined, undefined, 64);

  if(var_1.size) {
    self._id_1DF2 = var_1[0];
    level._id_1DDE = common_scripts\utility::array_remove(level._id_1DDE, self._id_1DF2);
    self._id_1DF3 = self._id_1DF2 getlightintensity();
  }

  thread _id_1DF5();

  if(isDefined(self._id_1DF1)) {
    thread _id_1DF4();
  }
}

_id_1DF4() {
  self._id_1DF1 endon("death");

  for(;;) {
    wait 0.2;
    self._id_1DF1 waittill("trigger");
    self notify("off");

    if(self.model == self._id_1DEE) {
      self setModel(self._id_1DEF);

      if(isDefined(self._id_1DF2)) {
        self._id_1DF2 setlightintensity(self._id_1DF3);

      }
      continue;
    }

    self setModel(self._id_1DEE);

    if(isDefined(self._id_1DF2)) {
      self._id_1DF2 setlightintensity(0);
    }
  }
}

_id_1DF5() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(common_scripts\utility::flag("no_ai_tv_damage")) {
      if(!isalive(var_1)) {
        continue;
      }
      if(!isplayer(var_1)) {
        continue;
      }
    }

    break;
  }

  if(isDefined(level._id_1DF6)) {
    [[level._id_1DF6]]();

  }
  self notify("off");

  if(isDefined(self._id_1DF1)) {
    self._id_1DF1 notify("death");

  }
  self setModel(self._id_1DED);

  if(isDefined(self._id_1DF2)) {
    self._id_1DF2 setlightintensity(0);

  }
  playFXOnTag(level.breakables_fx["tv_explode"], self, "tag_fx");
  self playSound("tv_shot_burst");

  if(isDefined(self._id_1DF1)) {
    self._id_1DF1 delete();
  }
}

_id_1DF7() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  if(isDefined(self.target)) {
    var_2 = getent(self.target, "targetname");

  }
  if(isDefined(self.script_linkto)) {
    var_4 = common_scripts\utility::get_links();
    var_5 = getent(var_4[0], "script_linkname");
    self linkto(var_5);
  }

  switch (self.destructible_type) {
    case "glass_large":
      break;
    case "glass_med":
      break;
    case "glass_small":
      break;
    default:
      break;
  }

  if(isDefined(var_2)) {
    var_3 = 99;
    var_2 linkto(self);
    var_2 hide();
    var_1 = var_2 setcontents(0);
  }

  if(isDefined(self._id_1DF8)) {
    var_3 = self._id_1DF8;
  } else if(isDefined(var_2)) {
    var_3 = 99;
  } else {
    var_3 = 250;

  }
  self setCanDamage(1);

  while(var_3 > 0) {
    self waittill("damage", var_6, var_7, var_0, var_8, var_9);

    if(!isDefined(var_0)) {
      var_0 = (0, 0, 1);

    }
    if(!isDefined(var_9)) {
      var_6 = 100000;
    } else if(var_9 == "MOD_GRENADE_SPLASH") {
      var_6 = var_6 * 1.75;
    } else if(var_9 == "MOD_IMPACT") {
      var_6 = 100000;

    }
    var_3 = var_3 - var_6;
  }

  var_10 = var_3 * -1;
  self hide();
  self notsolid();

  if(isDefined(var_2)) {
    var_2 show();
    var_2 setCanDamage(1);
    var_3 = 200 - var_10;
    var_2 setcontents(var_1);

    while(var_3 > 0) {
      var_2 waittill("damage", var_6, var_11, var_0, var_8, var_9);

      if(!isDefined(var_0)) {
        var_0 = (0, 0, 1);

      }
      if(!isDefined(var_9)) {
        var_6 = 100000;
      } else if(var_9 == "MOD_GRENADE_SPLASH") {
        var_6 = var_6 * 1.75;
      } else if(var_9 == "MOD_IMPACT") {
        break;
      }

      var_3 = var_3 - var_6;
    }

    var_2 delete();
  }

  _id_1DF9(self getorigin(), self.destructible_type, var_0);
  self delete();
}

_id_1DF9(var_0, var_1, var_2) {
  thread common_scripts\utility::play_sound_in_space(level._id_1DDD[var_1]["breaksnd"], var_0);
  playFX(level._id_1DDD[var_1]["breakfx"], var_0, var_2);
  level notify("glass_shatter");
}

oil_spill_think() {
  self.end = common_scripts\utility::getstruct(self.target, "targetname");
  self.start = common_scripts\utility::getstruct(self.end.target, "targetname");
  self.barrel = getclosestent(self.start.origin, getEntArray("explodable_barrel", "targetname"));

  if(isDefined(self.barrel)) {
    self.barrel.oilspill = 1;
    thread oil_spill_burn_after();
  }

  self.extra = getent(self.target, "targetname");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    self.damageowner = var_1;
    playFX(level.breakables_fx["oilspill"]["spark"], var_3, var_2);
    var_3 = pointonsegmentnearesttopoint(self.start.origin, self.end.origin, var_3);
    thread oil_spill_burn_section(var_3);
    thread oil_spill_burn(var_3, self.start.origin);
    thread oil_spill_burn(var_3, self.end.origin);
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
  for(;;) {
    self.barrel waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    self.damageowner = var_1;
    break;
  }

  self radiusdamage(self.start.origin, 4, 10, 10, self.damageowner);
}

oil_spill_burn(var_0, var_1) {
  var_2 = vectornormalize(var_1 - var_0);
  var_3 = distance(var_0, var_1);
  var_4 = 8;
  var_5 = var_2 * var_4;
  var_6 = vectortoangles(var_2);
  var_7 = anglestoright(var_6);
  var_8 = getEntArray("explodable_barrel", "targetname");
  var_9 = 484;
  var_10 = spawn("script_origin", var_0);
  var_11 = 0;

  for(;;) {
    var_3 = var_3 - var_4;

    if(var_3 < var_4 * 0.1) {
      break;
    }

    var_0 = var_0 + (var_5 + var_7 * randomfloatrange(-6, 6));
    thread oil_spill_burn_section(var_0);
    var_11++;

    if(var_11 == 4) {
      badplace_cylinder("", 0.5, var_0, 64, 64);
      var_11 = 0;
    }

    var_10.origin = var_0;
    var_12 = [];
    var_8 = common_scripts\utility::array_removeundefined(var_8);

    for(var_13 = 0; var_13 < var_8.size; var_13++) {
      var_14 = anglestoup(var_8[var_13].angles);
      var_15 = var_8[var_13].origin + var_14 * 22;
      var_16 = physicstrace(var_15, var_15 + (0, 0, -64));

      if(distancesquared(var_0, var_16) < var_9) {
        var_12[var_12.size] = var_8[var_13];
        var_8[var_13] dodamage(80 + randomfloat(10), var_0);
      }
    }

    for(var_13 = 0; var_13 < var_12.size; var_13++) {
      var_8 = common_scripts\utility::array_remove(var_8, var_12[var_13]);

    }
    wait 0.1;
  }

  if(!isDefined(self.barrel)) {
    return;
  }
  if(distance(var_0, self.start.origin) < 32) {
    self.barrel dodamage(80 + randomfloat(10), var_0);
  }
}

oil_spill_burn_section(var_0) {
  var_1 = 0;
  var_2 = 0;
  playFX(level.breakables_fx["oilspill"]["burn"], var_0);
}

explodable_barrel_think() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(level.precachemodeltype["com_barrel_benzin"])) {
    level.precachemodeltype["com_barrel_benzin"] = 1;
    precachemodel("com_barrel_piece");
    precachemodel("com_barrel_piece2");
  }

  self endon("exploding");
  breakable_clip();
  _id_1E13();
  self.damagetaken = 0;
  self setCanDamage(1);

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") {
      continue;
    }
    self.damageowner = var_1;

    if(level.barrelexplodingthisframe) {
      wait(randomfloat(1));

    }
    self.damagetaken = self.damagetaken + var_0;

    if(self.damagetaken == var_0) {
      thread explodable_barrel_burn();
    }
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

  while(self.damagetaken < level.barrelhealth) {
    if(!var_1) {
      playFX(level.breakables_fx["barrel"]["burn_start"], self.origin + var_5);
      var_1 = 1;
    }

    if(var_0 > 19) {
      var_0 = 0;

    }
    playFX(level.breakables_fx["barrel"]["burn"], self.origin + var_6);

    if(var_0 == 0) {
      self.damagetaken = self.damagetaken + (10 + randomfloat(10));
      badplace_cylinder("", 1, self.origin, 128, 250);
    }

    var_0++;
    wait 0.05;

    if(!isDefined(self)) {
      return;
    }
  }

  self.damagetaken = undefined;
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
  level thread common_scripts\utility::play_sound_in_space(level.barrelexpsound, self.origin);
  playFX(level.breakables_fx["barrel"]["explode"], self.origin + var_3);
  physicsexplosionsphere(self.origin + var_3, 100, 80, 1);
  level.barrelexplodingthisframe = 1;

  if(isDefined(self.remove)) {
    if(common_scripts\utility::issp() && self.remove.spawnflags & 1) {
      self.remove connectpaths();

    }
    self.remove delete();
  }

  var_6 = 1;
  var_7 = 250;
  var_8 = 250;

  if(isDefined(self.radius)) {
    var_8 = self.radius;

  }
  var_9 = undefined;

  if(isDefined(self.damageowner)) {
    var_9 = self.damageowner;

    if(isplayer(var_9)) {
      maps\_utility::_id_1E05(self.origin, "rifle", 150);

    }
    self.damageowner = undefined;
  }

  level._id_193D["time"] = gettime();
  level._id_193D["origin"] = self.origin + (0, 0, 30);
  level._id_193D["radius"] = var_8;
  self radiusdamage(self.origin + (0, 0, 30), var_8, var_7, var_6, var_9);

  if(randomint(2) == 0) {
    self setModel("com_barrel_piece");
  } else {
    self setModel("com_barrel_piece2");

  }
  if(var_2 < 0.5) {
    var_4 = self.origin + var_0 * 22;
    var_10 = physicstrace(var_4, var_4 + (0, 0, -64));
    self.origin = var_10;
    self.angles = self.angles + (0, 0, 90);
  }

  wait 0.05;
  level.barrelexplodingthisframe = 0;
}

_id_1E06() {
  var_0 = 0;

  if(self.model == "prop_helmet_german_normandy") {
    var_0 = 1;

  }
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4);

    if(var_0) {
      self vibrate(var_3, 20, 0.6, 0.75);
    } else {
      self vibrate(var_3, 0.4, 0.4, 0.4);

    }
    self waittill("rotatedone");
  }
}

_id_1E07() {
  if(self.classname != "script_model") {
    return;
  }
  self setCanDamage(1);
  self waittill("damage", var_0, var_1);

  if(isai(var_1) || isplayer(var_1)) {
    var_2 = var_1 getEye() - (0, 0, randomint(50) + 50);
  } else {
    var_2 = var_1.origin;

  }
  var_3 = vectornormalize(self.origin - var_2);
  var_3 = var_3 * 0.5 + randomfloat(1);
  self notify("death");
  playFX(level.breakables_fx["tincan"], self.origin, var_3);
  self delete();
}

_id_1E08() {
  if(self.classname != "script_model") {
    return;
  }
  _id_1E13();
  self setCanDamage(1);
  thread _id_1E09();
}

_id_1E09() {
  self waittill("damage", var_0, var_1);

  if(isai(var_1)) {
    var_2 = var_1 getEye();
  } else {
    var_2 = var_1.origin;

  }
  var_3 = vectornormalize(self.origin - var_2);

  if(!isDefined(self._id_1E0A) && isplayer(var_1)) {
    thread animscripts\death::_id_0ED0(var_3);
    return;
  }

  self notsolid();
  self hide();
  var_4 = spawn("script_model", self.origin + (0, 0, 5));
  var_4.angles = self.angles;
  var_4 setModel(self.model);
  var_4 thread animscripts\death::_id_0ED0(var_3);
  self._id_1E0A = 0;
  self notify("ok_remove");
}

_id_1E0B(var_0) {
  if(!isDefined(level._id_1E0C)) {
    return 1;

  }
  if(level._id_1E0C.size == 0) {
    return 0;
  } else {
    for(var_1 = 0; var_1 < level._id_1E0C.size; var_1++) {
      if(var_0 == level._id_1E0C[var_1]) {
        return 1;
      }
    }

    return 0;
  }

  return 1;
}

_id_1E0D(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    var_0 notify("damage", 100, var_1);
  }
}

_id_1E0E() {
  if(self.classname != "script_model") {
    return;
  }
  if(!isDefined(self.model)) {
    return;
  }
  var_0 = undefined;

  if(self.model == "egypt_prop_vase1" || self.model == "egypt_prop_vase3" || self.model == "egypt_prop_vase4") {
    if(!isDefined(level.precachemodeltype["egypt_prop_vase_o"])) {
      level.precachemodeltype["egypt_prop_vase_o"] = 1;
      precachemodel("egypt_prop_vase_br2");
      precachemodel("egypt_prop_vase_br5");
      precachemodel("egypt_prop_vase_br7");
    }

    var_0 = "orange vase";
    breakable_clip();
    _id_1E13();
  } else if(self.model == "egypt_prop_vase2" || self.model == "egypt_prop_vase5" || self.model == "egypt_prop_vase6") {
    if(!isDefined(level.precachemodeltype["egypt_prop_vase_g"])) {
      level.precachemodeltype["egypt_prop_vase_g"] = 1;
      precachemodel("egypt_prop_vase_br1");
      precachemodel("egypt_prop_vase_br3");
      precachemodel("egypt_prop_vase_br4");
      precachemodel("egypt_prop_vase_br6");
    }

    var_0 = "green vase";
    breakable_clip();
    _id_1E13();
  } else if(self.model == "prop_crate_dak1" || self.model == "prop_crate_dak2" || self.model == "prop_crate_dak3" || self.model == "prop_crate_dak4" || self.model == "prop_crate_dak5" || self.model == "prop_crate_dak6" || self.model == "prop_crate_dak7" || self.model == "prop_crate_dak8" || self.model == "prop_crate_dak9") {
    if(!isDefined(level.precachemodeltype["prop_crate_dak_shard"])) {
      level.precachemodeltype["prop_crate_dak_shard"] = 1;
      precachemodel("prop_crate_dak_shard");
    }

    var_0 = "wood box";
    breakable_clip();
    _id_1E13();
  } else if(self.model == "prop_winebottle_breakable") {
    if(!isDefined(level.precachemodeltype["prop_winebottle"])) {
      level.precachemodeltype["prop_winebottle"] = 1;
      precachemodel("prop_winebottle_broken_top");
      precachemodel("prop_winebottle_broken_bot");
    }

    var_0 = "bottle";
    _id_1E13();
  } else if(self.model == "prop_diningplate_roundfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
    }

    var_0 = "plate";
    self._id_1E0F = "round_floral";
    _id_1E13();
  } else if(self.model == "prop_diningplate_roundplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    var_0 = "plate";
    self._id_1E0F = "round_plain";
    _id_1E13();
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

    var_0 = "plate";
    self._id_1E0F = "round_stack";
    _id_1E13();
  } else if(self.model == "prop_diningplate_ovalfloral") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenfloral"])) {
      level.precachemodeltype["prop_diningplate_brokenfloral"] = 1;
      precachemodel("prop_diningplate_brokenfloral1");
      precachemodel("prop_diningplate_brokenfloral2");
      precachemodel("prop_diningplate_brokenfloral3");
      precachemodel("prop_diningplate_brokenfloral4");
    }

    var_0 = "plate";
    self._id_1E0F = "oval_floral";
    _id_1E13();
  } else if(self.model == "prop_diningplate_ovalplain") {
    if(!isDefined(level.precachemodeltype["prop_diningplate_brokenplain"])) {
      level.precachemodeltype["prop_diningplate_brokenplain"] = 1;
      precachemodel("prop_diningplate_brokenplain1");
      precachemodel("prop_diningplate_brokenplain2");
      precachemodel("prop_diningplate_brokenplain3");
      precachemodel("prop_diningplate_brokenplain4");
    }

    var_0 = "plate";
    self._id_1E0F = "oval_plain";
    _id_1E13();
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

    var_0 = "plate";
    self._id_1E0F = "oval_stack";
    _id_1E13();
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(self.target)) {
    var_1 = getent(self.target, "targetname");

    if(isDefined(var_1) && var_1.classname == "trigger_multiple") {
      var_1 thread _id_1E0D(self);
    }
  }

  self setCanDamage(1);
  thread _id_1E10(var_0);
}

_id_1E10(var_0) {
  var_1 = undefined;

  for(;;) {
    self waittill("damage", var_2, var_1);

    if(isDefined(var_1) && var_1.code_classname == "script_vehicle") {
      var_1 joltbody(self.origin + (0, 0, -90), 0.2);

    }
    if(var_0 == "wood box") {
      if(!_id_1E0B(var_1)) {
        continue;
      }
      if(!isDefined(level.flags) || !isDefined(level.flags["Breakable Boxes"])) {
        break;
      }

      if(isDefined(level.flags["Breakable Boxes"]) && level.flags["Breakable Boxes"] == 1) {
        break;
      }
    } else {
      break;
    }
  }

  self notify("death");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;

  switch (var_0) {
    case "green vase":
    case "orange vase":
      var_3 = "bullet_large_vase";
      var_4 = level.breakables_fx["vase"];
      break;
    case "wood box":
      if(isDefined(level._id_1E12)) {
        var_3 = level._id_1E12;
      } else {
        var_3 = "bullet_large_vase";

      }
      var_4 = level.breakables_fx["box"][randomint(level.breakables_fx["box"].size)];
      var_5 = 1;
      break;
    case "bottle":
      var_3 = "bullet_small_bottle";
      var_4 = level.breakables_fx["bottle"];
      break;
    case "plate":
      var_3 = "bullet_small_plate";
      break;
  }

  thread common_scripts\utility::play_sound_in_space(var_3, self.origin);
  thread _id_1E1B(self, var_0);

  if(isDefined(var_4)) {
    playFX(var_4, self.origin);

  }
  if(var_5) {
    var_6 = getEntArray("breakable", "targetname");

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      var_8 = var_6[var_7];
      var_9 = abs(self.origin[0] - var_8.origin[0]);
      var_10 = abs(self.origin[1] - var_8.origin[1]);

      if(var_9 <= 20 && var_10 <= 20) {
        var_11 = self.origin[2] - var_8.origin[2];

        if(var_11 <= 0) {
          var_8 notify("damage", var_2, var_1);
        }
      }
    }
  }

  if(isDefined(self.remove)) {
    self.remove connectpaths();
    self.remove delete();
  }

  if(!isDefined(self._id_1E0A)) {
    self delete();
  } else {
    self._id_1E0A = 0;

  }
  self notify("ok_remove");
}

_id_1E13() {
  if(isDefined(level._id_1DE5) && level._id_1DE5.size > 0) {
    self._id_1E14 = _id_1E23(self.origin, level._id_1DE5);

  }
  if(isDefined(self._id_1E14)) {
    level._id_1DE5 = common_scripts\utility::array_remove(level._id_1DE5, self._id_1E14);
    thread _id_1E16();
  }
}

_id_1E15() {
  self notify("entered_xenon_auto_aim_stop_logic");
  self endon("entered_xenon_auto_aim_stop_logic");
  self._id_1E14 waittill("xenon_auto_aim_stop_logic");
  self._id_1E0A = undefined;
}

_id_1E16(var_0) {
  thread _id_1E15();
  self endon("xenon_auto_aim_stop_logic");
  self._id_1E14 endon("xenon_auto_aim_stop_logic");
  self notify("xenon_remove_auto_aim");
  self._id_1E14 thread _id_1E17(var_0);
  self._id_1E0A = 1;
  self waittill("damage", var_1, var_2);
  self._id_1E14 disableaimassist();
  self._id_1E14 delete();

  if(self._id_1E0A) {
    self waittill("ok_remove");

  }
  self delete();
}

_id_1E17(var_0) {
  self endon("xenon_auto_aim_stop_logic");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 1;

  }
  if(isDefined(self.script_noteworthy) && var_0) {
    var_1 = "enable_xenon_autoaim_" + self.script_noteworthy;
    level waittill(var_1);
  }

  self._id_1E18 = 0;

  if(isDefined(self._id_1E19) && self._id_1E19 == 1) {
    self waittill("recreate");

  }
  self enableaimassist();
}

breakable_clip() {
  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(var_0.classname == "script_brushmodel") {
      self.remove = var_0;
      return;
    }
  }

  if(isDefined(level.breakables_clip) && level.breakables_clip.size > 0) {
    self.remove = getclosestent(self.origin, level.breakables_clip);

  }
  if(isDefined(self.remove)) {
    level.breakables_clip = common_scripts\utility::array_remove(level.breakables_clip, self.remove);
  }
}

_id_1E1B(var_0, var_1) {
  var_2 = anglestoright(var_0.angles);
  var_3 = anglesToForward(var_0.angles);
  var_4 = anglestoup(var_0.angles);
  var_5 = [];

  switch (var_1) {
    case "orange vase":
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -7, 0, 22, var_0, (0, 0, 0), "egypt_prop_vase_br2");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 13, -6, 28, var_0, (0, 245.1, 0), "egypt_prop_vase_br7");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 12, 10, 27, var_0, (0, 180, 0), "egypt_prop_vase_br7");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, 2, 0, var_0, (0, 0, 0), "egypt_prop_vase_br5");
      break;
    case "green vase":
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -6, -1, 26, var_0, (0, 0, 0), "egypt_prop_vase_br1");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 12, 1, 31, var_0, (0, 348.5, 0), "egypt_prop_vase_br3");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 6, 13, 29, var_0, (0, 153.5, 0), "egypt_prop_vase_br6");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, 1, 0, var_0, (0, 0, 0), "egypt_prop_vase_br4");
      break;
    case "wood box":
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -10, 10, 25, var_0, (0, 0, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 10, 10, 25, var_0, (0, 90, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 10, -10, 25, var_0, (0, 180, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -10, -10, 25, var_0, (0, 270, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 10, 10, 5, var_0, (180, 0, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 10, -10, 5, var_0, (180, 90, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -10, -10, 5, var_0, (180, 180, 0), "prop_crate_dak_shard");
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -10, 10, 5, var_0, (180, 270, 0), "prop_crate_dak_shard");
      break;
    case "bottle":
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 0, 0, 10, var_0, (0, 0, 0), "prop_winebottle_broken_top");
      var_5[var_5.size - 1].type = "bottle_top";
      var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 0, 0, 0, var_0, (0, 0, 0), "prop_winebottle_broken_bot");
      var_5[var_5.size - 1].type = "bottle_bot";
      break;
    case "plate":
      switch (var_0._id_1E0F) {
        case "round_floral":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -4, 0.5, var_0, (0, 150, 0), "prop_diningplate_brokenfloral1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, -2, 0.5, var_0, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 1, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 2, 0.5, var_0, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          break;
        case "round_plain":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -4, 0.5, var_0, (0, 150, 0), "prop_diningplate_brokenplain1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, -2, 0.5, var_0, (0, 149.8, 0), "prop_diningplate_brokenplain2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 1, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenplain3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 2, 0.5, var_0, (0, 146.8, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          break;
        case "round_stack":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -4, 0.5, var_0, (0, 150, 0), "prop_diningplate_brokenfloral1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, -2, 0.5, var_0, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 1, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 2, 0.5, var_0, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 3, 2.5, var_0, (0, 60, 0), "prop_diningplate_brokenplain1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -1, -3, 2.5, var_0, (0, 59.8, 0), "prop_diningplate_brokenplain2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 2, -1, 2.5, var_0, (0, 60.2, 0), "prop_diningplate_brokenplain3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 2, 4, 2.5, var_0, (0, 56.8, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -4, 4.5, var_0, (0, 150, 0), "prop_diningplate_brokenfloral1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, -2, 4.5, var_0, (0, 149.8, 0), "prop_diningplate_brokenfloral2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 1, 2, 4.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 2, 4.5, var_0, (0, 146.8, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          break;
        case "oval_floral":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, -4, 0.5, var_0, (0, 205.9, 0), "prop_diningplate_brokenfloral1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -6, 1, 0.5, var_0, (0, 352.2, 0), "prop_diningplate_brokenfloral2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -2, 5, 0.5, var_0, (0, 102.3, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -3, 0.5, var_0, (0, 246.7, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          break;
        case "oval_plain":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, -4, 0.5, var_0, (0, 205.9, 0), "prop_diningplate_brokenplain1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -6, 1, 0.5, var_0, (0, 352.2, 0), "prop_diningplate_brokenplain2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenplain3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -2, 5, 0.5, var_0, (0, 102.3, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -3, 0.5, var_0, (0, 246.7, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          break;
        case "oval_stack":
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, -4, 0.5, var_0, (0, 205.9, 0), "prop_diningplate_brokenfloral1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -6, 1, 0.5, var_0, (0, 352.2, 0), "prop_diningplate_brokenfloral2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 4, 2, 0.5, var_0, (0, 150.2, 0), "prop_diningplate_brokenfloral3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -2, 5, 0.5, var_0, (0, 102.3, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -3, -3, 0.5, var_0, (0, 246.7, 0), "prop_diningplate_brokenfloral4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, 5, 2.5, var_0, (0, 25.9, 0), "prop_diningplate_brokenplain1");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 6, 0, 2.5, var_0, (0, 172.2, 0), "prop_diningplate_brokenplain2");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, -4, -1, 2.5, var_0, (0, 330.2, 0), "prop_diningplate_brokenplain3");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 2, -4, 2.5, var_0, (0, 282.3, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          var_5[var_5.size] = _id_1E1F(var_2, var_3, var_4, 3, 4, 2.5, var_0, (0, 66.7, 0), "prop_diningplate_brokenplain4");
          var_5[var_5.size - 1].type = "plate";
          break;
      }

      break;
    default:
      return;
  }

  common_scripts\utility::array_thread(var_5, ::_id_1E1D, var_0.origin);

  if(isDefined(level._id_1DE0[var_1]) && level._id_1DE0[var_1] == 1) {
    var_6 = var_5[0].origin[2];

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(var_6 > var_5[var_7].origin[2]) {
        var_6 = var_5[var_7].origin[2];
      }
    }

    common_scripts\utility::array_thread(var_5, ::_id_1E1E, var_6);
  } else {
    wait 2;

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      if(isDefined(var_5[var_7])) {
        var_5[var_7] delete();
      }
    }
  }
}

_id_1E1C(var_0) {
  if(isDefined(level._breakable_utility_modelarray[level._breakable_utility_modelindex])) {
    level._breakable_utility_modelarray[level._breakable_utility_modelindex] delete();

  }
  level._breakable_utility_modelarray[level._breakable_utility_modelindex] = var_0;
  level._breakable_utility_modelindex++;

  if(!(level._breakable_utility_modelindex < level._breakable_utility_maxnum)) {
    level._breakable_utility_modelindex = 0;
  }
}

_id_1E1D(var_0) {
  self endon("do not kill");

  if(isDefined(self.type) && self.type == "bottle_bot") {
    return;
  }
  var_1 = spawn("script_origin", self.origin);
  self linkto(var_1);
  var_2 = self.origin + (randomfloat(10) - 5, randomfloat(10) - 5, randomfloat(10) + 5);
  var_3 = undefined;

  if(isDefined(self.type) && self.type == "bottle_top") {
    var_3 = (randomfloat(40) - 20, randomfloat(40) - 20, 70 + randomfloat(15));
    var_4 = 1;
    var_5 = 1;
    var_6 = 1;

    if(randomint(100) > 50) {
      var_4 = -1;

    }
    if(randomint(100) > 50) {
      var_5 = -1;

    }
    if(randomint(100) > 50) {
      var_6 = -1;

    }
    var_1 rotatevelocity((250 * var_4, 250 * var_5, randomfloat(100) * var_6), 2, 0, 0.5);
  } else if(isDefined(self.type) && self.type == "plate") {
    var_3 = vectornormalize(var_2 - var_0);
    var_3 = var_3 * (125 + randomfloat(25));

    if(randomint(100) > 50) {
      var_1 rotateroll((800 + randomfloat(4000)) * -1, 5, 0, 0);
    } else {
      var_1 rotateroll(800 + randomfloat(4000), 5, 0, 0);
    }
  } else {
    var_3 = vectornormalize(var_2 - var_0);
    var_3 = var_3 * (60 + randomfloat(50));

    if(randomint(100) > 50) {
      var_1 rotateroll((800 + randomfloat(1000)) * -1, 5, 0, 0);
    } else {
      var_1 rotateroll(800 + randomfloat(1000), 5, 0, 0);
    }
  }

  var_1 movegravity(var_3, 5);
  wait 5;

  if(isDefined(self)) {
    self unlink();

  }
  var_1 delete();
}

_id_1E1E(var_0) {
  self endon("death");
  wait 0.1;
  var_1 = bulletTrace(self.origin, self.origin - (0, 0, 50000), 0, undefined);
  var_2 = var_1["position"];

  while(self.origin[2] > var_2[2]) {
    wait 0.05;

  }
  self unlink();
  self.origin = (self.origin[0], self.origin[1], var_2[2]);
  self notify("do not kill");
  self unlink();
}

_id_1E1F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 1;
  var_10 = var_0;
  var_11 = var_1;
  var_12 = var_2;
  var_10 = var_10 * (var_4 * var_9);
  var_11 = var_11 * (var_3 * var_9);
  var_12 = var_12 * (var_5 * var_9);
  var_13 = var_6.origin + var_10 + var_11 + var_12;
  var_14 = spawn("script_model", var_13);
  var_14 setModel(var_8);
  var_14.modelscale = var_9;
  var_14.angles = var_6.angles + var_7;
  _id_1E1C(var_14);
  return var_14;
}

_id_1E21(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = distance(var_1[0] getorigin(), var_0);
  var_3 = var_1[0];

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 < var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

getclosestent(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = 256;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

_id_1E23(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = 8;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}

_id_1E24(var_0, var_1) {
  if(var_1.size < 1) {
    return;
  }
  var_2 = 1000000;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 >= var_2) {
      continue;
    }
    var_2 = var_5;
    var_3 = var_1[var_4];
  }

  return var_3;
}