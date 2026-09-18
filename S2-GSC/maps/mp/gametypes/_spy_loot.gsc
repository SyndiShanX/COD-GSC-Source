/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spy_loot.gsc
*********************************************/

init() {
  func_52BD();
  thread initloot();
}

func_52BD() {
  level.spy_fx["weapon_pickup_red"] = loadfx("vfx/test/br/weapon_pickup_red");
  level.spy_fx["weapon_pickup_orange"] = loadfx("vfx/test/br/weapon_pickup_orange");
  level.spy_fx["weapon_pickup_yellow"] = loadfx("vfx/test/br/weapon_pickup_yellow");
  level.spy_fx["weapon_pickup_green"] = loadfx("vfx/test/br/weapon_pickup_green");
  level.spy_fx["weapon_pickup_blue"] = loadfx("vfx/test/br/weapon_pickup_blue");
}

initloot() {
  level.spyloot = [];
  level.spyloot[0] = [];
  level.spyloot[1] = [];
  level.spylootchancetotal = [];
  level.spylootchancetotal[0] = 0;
  level.spylootchancetotal[1] = 0;
  addlootweapon("m1941_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1.5, 0.5, 0.5, 0);
  addlootweapon("stg44_mp", 2, 1, (5, 0, 0), (0, 0, 0), "orange", 1.5, 0.5, 0.5, 0);
  addlootweapon("fg42_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1.5, 0.5, 0.5, 0);
  addlootweapon("bar_mp", 2, 1, (0, 0, 0), (0, 0, 0), "orange", 1.5, 0.5, 0.5, 0);
  addlootweapon("svt40_mp", 4, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 1);
  addlootweapon("m1a1_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 1);
  addlootweapon("m1garand_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 1);
  addlootweapon("greasegun_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("ppsh41_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("type100_mp", 1.5, 1, (3, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("mp28_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("thompson_mp", 0, 1, (10, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("mp40_mp", 1.5, 1, (3, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 2);
  addlootweapon("lewis_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0.5, 0.5, 3);
  addlootweapon("mg15_mp", 2, 1, (0, 0, 0), (0, 0, 0), "orange", 1.5, 0.5, 0.5, 3);
  addlootweapon("bren_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0.5, 0.5, 3);
  addlootweapon("mg42_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0.5, 0.5, 3);
  addlootweapon("karabin_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 4);
  addlootweapon("leeenfield_mp", 2.5, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 4);
  addlootweapon("springfield_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 4);
  addlootweapon("kar98_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 4);
  addlootweapon("winchester1897_mp", 1.5, 1, (3, 0, 0), (0, 0, 0), "orange", 0.5, 0.5, 0.5, 5);
  addlootweapon("m30_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 5);
  addlootweapon("walther_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0.5, 0.5, 5);
  addlootweapon("model21_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0.5, 5);
  addlootweapon("luger_mp", 3, 1, (10, 0, 0), (0, 0, 0), "orange", 2.5, 0.5, 0, 6);
  addlootweapon("m1911_mp", 0, 1, (10, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0, 6);
  addlootweapon("m712_mp", 3, 1, (10, 0, 0), (0, 0, 0), "orange", 2, 0.5, 0, 6);
  addlootweapon("panzerschreck_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0, 0, 7);
  addlootweapon("bazooka_mp", 1, 1, (12, 0, 0), (0, 0, 0), "orange", 2, 0, 0, 7);
  waittillframeend;
  initlootlocations();
  level.spylootlocations[0] = common_scripts\utility::array_randomize(level.spylootlocations[0]);
  var_00 = int(level.spylootlocations[0].size * lootdensity());
  if(var_00 > lootmaxspawneditems()) {
    var_00 = lootmaxspawneditems();
  }

  for(var_01 = 0; var_01 < var_00; var_01++) {
    if(var_01 < level.spylootlocations[1].size) {
      var_02 = 1;
      var_03 = level.spylootlocations[1][var_01];
    } else {
      var_02 = 0;
      var_03 = level.spylootlocations[2][var_01];
    }

    var_04 = randomfloatrange(0, level.spylootchancetotal[var_02]);
    var_05 = undefined;
    foreach(var_07 in level.spyloot[var_02]) {
      if(var_04 >= var_07.chancerangestart[var_02] && var_04 < var_07.chancerangeend[var_02]) {
        var_05 = var_07;
        break;
      }
    }

    if(!isDefined(var_05)) {}

    spawnloot(var_05, var_03);
  }
}

addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(level.spyloot[0][param_00])) {
    return;
  }

  var_06 = spawnStruct();
  var_06.name = param_00;
  var_06.originoffset = param_03;
  var_06.anglesoffset = param_04;
  var_06.var_3F74 = param_05;
  var_06.loottype = 0;
  var_06.chancerangestart = [];
  var_06.chancerangeend = [];
  var_07 = [];
  var_07[0] = param_01;
  var_07[1] = common_scripts\utility::func_98E7(param_02, param_01, 0);
  for(var_08 = 0; var_08 < 2; var_08++) {
    var_06.chancerangestart[var_08] = level.spylootchancetotal[var_08];
    level.spylootchancetotal[var_08] = level.spylootchancetotal[var_08] + var_07[var_08];
    var_06.chancerangeend[var_08] = level.spylootchancetotal[var_08];
    level.spyloot[var_08][param_00] = var_06;
  }

  return var_06;
}

addlootweapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05);
  var_0A.loottype = 1;
  var_0A.startclips = param_06;
  var_0A.attachment1chance = param_07;
  var_0A.attachment2chance = param_08;
  var_0A.weapontypeenum = param_09;
}

addlootpickup(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05);
  var_09.loottype = 2;
  var_09.model = param_06;
  var_09.var_C5 = param_07;
  var_09.onpickupfunc = param_08;
}

initlootlocations() {
  level.spylootlocations = [];
  for(var_00 = 0; var_00 < 3; var_00++) {
    level.spylootlocations[var_00] = [];
  }

  addpathnodelootlocations();
  addhardcodedlootlocations();
  var_01 = common_scripts\utility::func_46B7("spy_loot_location", "targetname");
  common_scripts\utility::array_thread(var_01, ::lootlocationinit, 0);
  var_01 = common_scripts\utility::func_46B7("spy_loot_location_force_use", "targetname");
  common_scripts\utility::array_thread(var_01, ::lootlocationinit, 1);
}

lootlocationinit(param_00) {
  self.origin = self.origin + (0, 0, lootgroundoffset());
  self.forceuse = param_00;
  level.spylootlocations[0][level.spylootlocations[0].size] = self;
  if(param_00) {
    level.spylootlocations[1][level.spylootlocations[1].size] = self;
    return;
  }

  level.spylootlocations[2][level.spylootlocations[2].size] = self;
}

addpathnodelootlocations() {
  var_00 = 2;
  var_01 = 25;
  var_02 = lootpathnodesoutside();
  var_03 = lootpathnodesinsideparial();
  var_04 = lootpathnodesinsidecomplete();
  level.spyinteriors = [];
  var_05 = getallnodes();
  var_05 = common_scripts\utility::array_randomize(var_05);
  foreach(var_07 in var_05) {
    if(var_07.type != "Path") {
      continue;
    }

    updateinteriorlocations(var_07);
  }

  var_09 = [];
  foreach(var_0C, var_0B in level.spyinteriors) {
    var_09[var_0C] = level.spyinteriors[var_0C].size;
  }

  foreach(var_07 in var_05) {
    var_0E = 0;
    if(common_scripts\utility::func_562E(var_07.noloot)) {
      continue;
    }

    if(var_07.type != "Path") {
      continue;
    }

    if(nodeexposedtosky(var_07, 1)) {
      if(randomfloat(1) > var_02) {
        continue;
      }
    } else if(nodeexposedtosky(var_07, 0)) {
      if(randomfloat(1) > var_03) {
        continue;
      }
    } else {
      if(isDefined(var_07.interiorindex)) {
        if(level.spyinteriors[var_07.interiorindex].size <= var_00) {
          continue;
        }

        if(var_09[var_07.interiorindex] > 0) {
          var_09[var_07.interiorindex] = var_09[var_07.interiorindex] - var_01;
          var_0E = 1;
        }
      }

      if(!var_0E && randomfloat(1) > var_04) {
        continue;
      }
    }

    var_0F = (0, randomfloatrange(0, 360), 0);
    var_10 = addlootlocation(var_07.origin, var_0F, var_0E);
    var_10.node = var_07;
    setnolootonconenctednodes(var_07, var_07, 0, lootpathnodesmindist());
  }
}

addhardcodedlootlocations() {
  switch (level.script) {
    case "mp_gibraltar_02":
      break;

    default:
      break;
  }
}

lootlocationcreate(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.origin = param_00;
  var_03.angles = param_01;
  if(common_scripts\utility::func_562E(param_02)) {
    var_03.targetname = "spy_loot_location_force_use";
  } else {
    var_03.targetname = "spy_loot_location";
  }

  return var_03;
}

addlootlocation(param_00, param_01, param_02) {
  var_03 = lootlocationcreate(param_00, param_01, param_02);
  common_scripts\utility::func_96C(var_03);
  return var_03;
}

nodeneedsinteriorindex(param_00) {
  return !isDefined(param_00.interiorindex) && !nodeexposedtosky(param_00, 0);
}

updateinteriorlocations(param_00) {
  if(!nodeneedsinteriorindex(param_00)) {
    return;
  }

  var_01 = level.spyinteriors.size;
  level.spyinteriors[var_01] = [];
  param_00.interiorindex = var_01;
  level.spyinteriors[var_01][0] = param_00;
  for(var_02 = 0; var_02 < level.spyinteriors[var_01].size; var_02++) {
    var_03 = level.spyinteriors[var_01][var_02];
    var_04 = function_0204(var_03);
    foreach(var_06 in var_04) {
      if(nodeneedsinteriorindex(var_06)) {
        var_06.interiorindex = var_01;
        var_07 = level.spyinteriors[var_01].size;
        level.spyinteriors[var_01][var_07] = var_06;
      }
    }
  }
}

setnolootonconenctednodes(param_00, param_01, param_02, param_03) {
  param_01.loopcheck = param_00;
  var_04 = function_0204(param_01);
  foreach(var_06 in var_04) {
    if(isDefined(var_06.loopcheck) && var_06.loopcheck == param_00) {
      continue;
    }

    var_07 = distance(param_01.origin, var_06.origin);
    if(param_02 + var_07 < param_03) {
      var_06.noloot = 1;
      if(!isDefined(param_00.nolootnodes)) {
        param_00.nolootnodes = [];
      }

      param_00.nolootnodes[param_00.nolootnodes.size] = var_06;
      setnolootonconenctednodes(param_00, var_06, param_02 + var_07, param_03);
    }
  }
}

spawnloot(param_00, param_01) {
  switch (param_00.loottype) {
    case 1:
      spawnlootweapon(param_00, param_01);
      break;

    case 2:
      spawnlootpickup(param_00, param_01);
      break;

    case 0:
    default:
      break;
  }
}

spawnlootweapon(param_00, param_01) {
  var_02 = param_00.name;
  var_03 = function_0372(param_00.name);
  var_04 = [];
  foreach(var_06 in var_03) {
    if(var_06.size > 2) {
      var_07 = getsubstr(var_06, var_06.size - 2, var_06.size);
      if(var_07 == "_1" || var_07 == "_2") {
        var_04[var_04.size] = var_06;
      }
    }
  }

  foreach(var_0A in var_04) {
    var_03 = common_scripts\utility::func_F93(var_03, var_0A);
  }

  var_0C = function_03A1(param_00.name);
  foreach(var_0E in var_0C) {
    var_03 = common_scripts\utility::func_F93(var_03, var_0E);
  }

  var_10 = ["extended_mag", "telescopic_sight"];
  foreach(var_12 in var_10) {
    var_13 = [];
    foreach(var_06 in var_03) {
      if(issubstr(var_06, var_12)) {
        var_13[var_13.size] = var_06;
      }
    }

    foreach(var_17 in var_13) {
      var_03 = common_scripts\utility::func_F93(var_03, var_17);
    }
  }

  var_1A = undefined;
  var_1B = undefined;
  if(randomfloat(1) < param_00.attachment1chance && var_03.size > 0) {
    var_1A = common_scripts\utility::random(var_03);
    if(randomfloat(1) < param_00.attachment2chance) {
      var_1C = tablelookuprownum("mp/attachmentcombos_mtx12.csv", 0, var_1A);
      var_1D = function_027B("mp/attachmentcombos_mtx12.csv");
      for(var_1E = 0; var_1E < var_1D; var_1E++) {
        var_1F = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_1C, var_1E);
        if(var_1F == "no") {
          var_20 = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_1E);
          var_03 = common_scripts\utility::func_F93(var_03, var_20);
        }
      }

      if(var_03.size > 0) {
        var_1B = common_scripts\utility::random(var_03);
      }
    }
  }

  if(param_00.weapontypeenum == 4) {
    if(!isDefined(var_1A) || var_1A == "hold_breath_1") {
      var_1A = "hold_breath_3";
    } else if(var_1A != "hold_breath_3") {
      var_1B = "hold_breath_3";
    }
  }

  if(isDefined(var_1A) && isDefined(var_1B)) {
    if(stricmp(var_1A, var_1B) > 0) {
      var_21 = var_1A;
      var_1A = var_1B;
      var_1B = var_21;
    }
  }

  if(isDefined(var_1A)) {
    var_02 = var_02 + "+" + var_1A;
    if(isDefined(var_1B)) {
      var_02 = var_02 + "+" + var_1B;
    }
  }

  spawnweaponitem(var_02, param_00, param_01);
}

spawnweaponitem(param_00, param_01, param_02) {
  var_03 = "weapon_" + param_00;
  var_04 = spawn(var_03, (0, 0, 0), lootweaponitemflags(param_00));
  spawnlootinitent(var_04, param_01, param_02);
  lootweaponsetstartammo(var_04, param_01, param_00);
  var_04 thread maps\mp\gametypes\_weapons::func_A934();
  var_04 thread lootweaponwatchpickup();
  return var_04;
}

lootweaponitemflags(param_00) {
  var_01 = 0;
  if(lootdroptoground()) {
    var_01 = var_01 | itemspawnflagsuspended();
  }

  if(weaponisakimbo(param_00)) {
    var_01 = var_01 | itemspawnflagakimbo();
  }

  var_01 = var_01 | itemspawnflagsprintuse();
  return var_01;
}

weaponisakimbo(param_00) {
  var_01 = function_0061(param_00, 1);
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "akimbo")) {
      return 1;
    }
  }

  return 0;
}

lootweaponsetstartammo(param_00, param_01, param_02) {
  var_03 = weaponclipsize(param_02);
  var_04 = int(param_01.startclips * var_03);
  if(var_04 > var_03) {
    var_05 = var_03;
    var_06 = var_04 - var_03;
  } else {
    var_05 = var_06;
    var_06 = 0;
  }

  if(weaponisakimbo(param_02)) {
    param_00 method_817E(var_05, var_06 * 2, var_05);
  } else {
    param_00 method_817E(var_05, var_06);
  }

  param_00 method_86B3(0);
}

spawnlootpickup(param_00, param_01) {
  var_02 = spawn("script_model", (0, 0, 0), lootpickupscriptmoverflags());
  var_02 setModel(param_00.model);
  var_02.onpickupfunc = param_00.onpickupfunc;
  spawnlootinitent(var_02, param_00, param_01);
  var_02 makeusable();
  var_02 setHintString(param_00.var_C5);
  var_02 thread pickuponused();
}

spawnlootinitent(param_00, param_01, param_02) {
  var_03 = rotatevector(param_01.originoffset, param_02.angles);
  param_00.origin = param_02.origin + var_03;
  param_00.angles = param_02.angles + param_01.anglesoffset;
  param_00.targetname = "spy_loot";
  param_00.loottype = param_01.loottype;
  param_00.lootname = param_01.name;
  param_00.var_3F77 = param_02.origin;
  thread spawnlootfx(param_00, param_01.var_3F74);
}

lootpickupscriptmoverflags() {
  return scriptmoverspawnflagsprintuse();
}

pickuponused() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_00);
    if(!maps\mp\_utility::isreallyalive(var_00)) {
      continue;
    }

    self[[self.onpickupfunc]](self.lootname, var_00);
    break;
  }

  waittillframeend;
  self delete();
}

lootweaponwatchpickup() {
  self endon("death");
  var_00 = maps\mp\gametypes\_weapons::func_452C();
  for(;;) {
    self waittill("trigger", var_01, var_02, var_03, var_04, var_05);
    if(!isDefined(var_03) || !isDefined(var_04)) {
      continue;
    }

    if(var_03 == var_04) {
      if(var_03) {
        return;
      }

      continue;
    }

    break;
  }

  if(isDefined(var_00) && var_00 == var_01.primaryweapon) {
    return;
  }

  if(isDefined(var_00) && var_00 == var_01.var_835A) {
    return;
  }

  var_06 = 0;
  var_07 = var_01 getweaponslistprimaries();
  foreach(var_09 in var_07) {
    if(isDefined(var_09) && var_09 == "shovel_mp") {
      var_06 = 1;
      break;
    }
  }

  if(var_06) {
    if(isDefined(var_02)) {
      var_01 takeweapon("shovel_mp");
      maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_01, "shovel_mp", var_00);
      var_0B = var_02 maps\mp\gametypes\_weapons::func_452C();
      var_01 giveweapon(var_0B);
      var_0C = var_02 method_85F2();
      var_01 setweaponammoclip(var_0B, var_0C["clip_ammo"]);
      var_01 setweaponammostock(var_0B, var_0C["stock_ammo"]);
      var_02 delete();
      return;
    }

    var_0D = var_01.currentweapon;
    if(shouldrestoreweapontoplayer(var_0D, var_01)) {
      var_01 takeweapon("shovel_mp");
      maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_01, "shovel_mp", var_00);
      var_01 giveweapon(var_0D);
      var_01 setweaponammoclip(var_0D, 0);
      var_01 setweaponammostock(var_0D, 0);
      return;
    }

    return;
  }

  if(isDefined(var_03)) {
    var_0B = var_03 maps\mp\gametypes\_weapons::func_452C();
    var_0E = var_02 dropweaponbattleroyale(var_0B);
    var_0F = var_03 method_85F2();
    var_10 = var_0F["clip_ammo"];
    var_11 = var_0F["stock_ammo"];
    var_12 = var_0F["clip_ammo_left"];
    if(!isDefined(var_12)) {
      var_12 = 0;
    }

    var_0E method_817E(var_10, var_11, var_12);
    maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_02, var_0B, var_01);
    var_03 delete();
  }
}

shouldrestoreweapontoplayer(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "shovel_mp") {
    return 0;
  }

  if(param_01 hasweapon(param_00)) {
    return 0;
  }

  var_02 = maps\mp\_utility::getbaseweaponname(param_00);
  if(!isDefined(level.spyloot[0][var_02])) {
    return 0;
  }

  if(level.spyloot[0][var_02].loottype != 1) {
    return 0;
  }

  return 1;
}

dropweaponbattleroyale(param_00) {
  var_01 = maps\mp\_utility::func_4738(param_00);
  if(var_01[0] == "alt") {
    param_00 = var_01[1];
    for(var_02 = 2; var_02 < var_01.size; var_02++) {
      param_00 = param_00 + "_" + var_01[var_02];
    }
  }

  var_03 = maps\mp\_utility::getbaseweaponname(param_00);
  var_04 = level.spyloot[0][var_03];
  var_05 = lootgetgroundpos(self.origin);
  var_05 = var_05 + (0, 0, lootgroundoffset());
  var_06 = self.angles;
  var_07 = lootlocationcreate(var_05, var_06);
  return spawnweaponitem(param_00, var_04, var_07);
}

spawnlootfx(param_00, param_01) {
  param_00 endon("death");
  if(param_00.loottype == 1) {
    if(!param_00.spawnflags &itemspawnflagsuspended()) {
      var_02 = param_00.origin + (0, 0, 1);
      while(var_02 != param_00.origin) {
        var_02 = param_00.origin;
        wait 0.05;
      }
    }
  }

  var_03 = spawnfx(level.spy_fx["weapon_pickup_" + param_01], param_00.var_3F77);
  triggerfx(var_03);
  param_00 waittill("trigger");
  var_03 delete();
}

lootdropweapon(param_00) {
  var_01 = maps\mp\_utility::func_4738(param_00);
  if(var_01[0] == "alt") {
    param_00 = var_01[1];
    for(var_02 = 2; var_02 < var_01.size; var_02++) {
      param_00 = param_00 + "_" + var_01[var_02];
    }
  }

  var_03 = maps\mp\_utility::getbaseweaponname(param_00);
  var_04 = level.brloot[0][var_03];
  var_05 = lootgetgroundpos(self.origin);
  var_05 = var_05 + (0, 0, lootgroundoffset());
  var_06 = self.angles;
  var_07 = lootlocationcreate(var_05, var_06);
  return spawnweaponitem(param_00, var_04, var_07);
}

weaponenumtostring(param_00) {
  switch (param_00) {
    case 0:
      return "AR";

    case 1:
      return "AR Semi";

    case 2:
      return "SMG";

    case 3:
      return "LMG";

    case 4:
      return "Sniper";

    case 5:
      return "Shotgun";

    case 6:
      return "Pistol";

    case 7:
      return "Launcher";

    case 8:
      return "Melee";

    default:
      return "Unknown";
  }
}

lootdensity() {
  return getdvarfloat("scr_spy_loot_density", 0.6);
}

lootdroptoground() {
  return getdvarint("scr_spy_loot_drop_to_ground", 1);
}

lootgroundoffset() {
  return getdvarfloat("scr_spy_loot_ground_offset", 30);
}

lootmaxspawneditems() {
  return 100;
}

lootpathnodesoutside() {
  return getdvarfloat("scr_spy_loot_path_nodes_outside", 0.02);
}

lootpathnodesinsideparial() {
  return getdvarfloat("scr_spy_loot_path_nodes_inside_partial", 0);
}

lootpathnodesinsidecomplete() {
  return getdvarfloat("scr_spy_loot_path_nodes_inside_complete", 1);
}

lootpathnodesmindist() {
  return getdvarint("scr_spy_loot_path_nodes_min_dist", 220);
}

lootgetgroundpos(param_00) {
  return bulletTrace(param_00 + (0, 0, 10), param_00 + (0, 0, -1000), 0, self, 0, 0, 0, 0, 1, 1, 0)["position"];
}

itemspawnflagsuspended() {
  return 1;
}

itemspawnflagakimbo() {
  return 4;
}

itemspawnflagsprintuse() {
  return 16;
}

scriptmoverspawnflagsprintuse() {
  return 16;
}