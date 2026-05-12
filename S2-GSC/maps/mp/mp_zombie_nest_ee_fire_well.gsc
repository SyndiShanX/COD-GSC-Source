/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_fire_well.gsc
***************************************************/

func_40E8() {
  return "bunker_door_opened";
}

func_418E() {
  return "fire trap active";
}

func_00F9() {
  var_00 = ["start_to_gallows", "gallows_to_riverside"];
  lib_0557::func_7846("explore village", ::lib_0557::func_30D8, [], &"ZOMBIE_NEST_HINT_QUEST_VILLAGE", "ZOMBIE_NEST_HINT_QUEST_VILLAGE");
  lib_0557::func_781E("explore village", "find bunker entrance", ::func_7830, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_LOCATE_BUNKER_ENT");
  lib_0557::func_781E("explore village", "Restore Bunker Door Power", ::func_785E, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_BUNKER_DOOR_POWER");
  lib_0557::func_7848("explore village");
  lib_0557::func_7846("1 fire well", ::lib_0557::func_30D8, [], &"ZOMBIE_NEST_HINT_QUEST_SEWERS", "ZOMBIE_NEST_HINT_QUEST_SEWERS", 0, 0);
  lib_0557::func_781E("1 fire well", "gas flowing", ::func_7855, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_OPEN_SEWERS");
  lib_0557::func_7848("1 fire well");
  common_scripts\utility::func_3C87("bunker_door_opened");
  common_scripts\utility::func_3C87("Pilot light activated");
  common_scripts\utility::func_3C87("fire trap active");
  func_AA06();
  thread func_AC98();
}

func_7830() {
  var_00 = getent("bunker_ent_dialogue", "targetname");
  var_00 func_A77B();
  if(!lib_0557::func_42D6("1 fire well")) {
    lib_0557::func_8564("1 fire well", 1);
  }

  if(!lib_0557::func_434E("1 fire well")) {
    lib_0557::func_8596("1 fire well", 1);
  }

  lib_0557::func_782D("explore village", "find bunker entrance");
}

func_A77B() {
  level endon("power_on");
  level endon(lib_0557::func_7838("1 fire well", "gas flowing"));
  self waittill("trigger");
}

func_785E() {
  var_00 = lib_053F::func_44A6("gallows_to_com");
  var_01 = lib_053F::func_44A6("com_to_rnd");
  var_02 = lib_053F::func_44A6("com_to_med");
  var_03 = undefined;
  if(0) {
    var_04 = common_scripts\utility::func_46B7("power_switch", "targetname");
    var_05 = [];
    foreach(var_07 in var_04) {
      var_05[var_05.size] = var_07.var_6298;
    }

    var_09 = common_scripts\utility::func_0F73(var_05, var_00.var_8301);
    var_03 = lib_0557::func_782F(undefined, var_09);
    lib_0557::func_781D("explore village", var_03);
  }

  if(!common_scripts\utility::func_3C77("power_sz2")) {
    common_scripts\utility::func_3C9F("power_sz2");
  }

  foreach(var_0B in var_00.var_8301) {
    var_0B setscriptablepartstate("light", "green");
  }

  if(0) {
    lib_0557::func_7847("explore village", var_03);
    var_03 = lib_0557::func_782F(undefined, var_00.var_8301);
    lib_0557::func_781D("explore village", var_03);
  }

  lib_0557::func_7822("explore village", &"ZOMBIE_NEST_HINT_STEP_OPEN_BUNKER_DOOR");
  if(!common_scripts\utility::func_562E(var_00.var_6BE1) && !common_scripts\utility::func_562E(var_01.var_6BE1) && !common_scripts\utility::func_562E(var_02.var_6BE1)) {
    var_0D = func_A776([var_00, var_01, var_02]);
    thread func_1DA7();
    thread func_1DA5();
    level thread common_scripts\_exploder::func_088E(209);
  }

  lib_0557::func_782D("explore village", "Restore Bunker Door Power");
  lib_0557::func_AB88("bunker_door_opened");
}

func_1DA7() {
  var_00 = function_021F("door_light", "targetname");
  foreach(var_02 in var_00) {
    wait(0.5);
    var_02 setscriptablepartstate("puzzlelight", "flicker2");
    wait(1);
    var_02 setscriptablepartstate("puzzlelight", "on");
  }

  var_04 = function_021F("door_light_1", "targetname");
  foreach(var_06 in var_04) {
    wait(1);
    var_06 setscriptablepartstate("puzzlelight", "flicker2");
    wait(1);
    var_06 setscriptablepartstate("puzzlelight", "on");
  }
}

func_A776(param_00) {
  foreach(var_02 in param_00) {
    var_02 thread func_680E();
  }

  level waittill("bunker area open", var_04);
  return var_04;
}

func_680E() {
  level endon("bunker area open");
  self waittill("open", var_00);
  level notify("bunker area open", var_00);
}

func_1DA5() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("bunker");
    var_01 lib_0378::func_8D74("objective_complete", "bunker");
  }
}

func_44F7() {
  return lib_053F::func_44A6("gallows_to_com");
}

func_AA06() {
  var_00 = getent("well_clip_bottom", "script_noteworthy");
  var_00.var_0116 = var_00.var_0116 + (0, 0, 128);
  var_00.var_50D0 = 0;
  wait 0.05;
  var_00 notsolid();
  var_01 = getent("well_clip_top_plug", "script_noteworthy");
  var_01.var_0116 = var_01.var_0116 + (0, 0, -128);
  var_01.var_50D0 = 1;
  wait 0.05;
  var_01 method_805F();
  var_02 = getent("well_clip_door", "script_noteworthy");
  var_02.var_0116 = var_02.var_0116 + (0, 0, -128);
  var_02.var_50D0 = 1;
  var_03 = getent("well_clip_door_ai", "script_noteworthy");
  var_03.var_0116 = var_03.var_0116 + (0, 0, -128);
  var_03.var_50D0 = 1;
  wait 0.05;
  var_03 method_805F();
}

func_AA05() {
  var_00 = getEntArray("well_clip_top", "script_noteworthy");
  var_01 = getent("well_clip_top_plug", "script_noteworthy");
  var_02 = getent("well_clip_door", "script_noteworthy");
  foreach(var_04 in var_00) {
    var_04 notsolid();
    var_04 method_8060();
    wait 0.05;
    var_04 delete();
  }

  var_01 notsolid();
  var_02 notsolid();
}

func_AA04() {
  var_00 = getent("well_clip_bottom", "script_noteworthy");
  if(!var_00.var_50D0) {
    var_00.var_0116 = var_00.var_0116 + (0, 0, -128);
    var_00.var_50D0 = 1;
  }

  wait 0.05;
  var_00 solid();
  var_01 = getent("well_clip_top_plug", "script_noteworthy");
  var_01 solid();
  var_02 = getent("well_clip_door", "script_noteworthy");
  var_02 solid();
  var_03 = getent("well_clip_door_ai", "script_noteworthy");
  var_03 solid();
}

func_AA07() {
  var_00 = getent("well_clip_bottom", "script_noteworthy");
  if(!var_00.var_50D0) {
    var_00.var_0116 = var_00.var_0116 + (0, 0, -128);
    var_00.var_50D0 = 1;
  }

  wait 0.05;
  var_00 solid();
  var_01 = getent("well_clip_door_ai", "script_noteworthy");
  var_01 method_8060();
  var_01 notsolid();
}

func_AA08() {
  var_00 = getent("well_clip_bottom", "script_noteworthy");
  var_00 notsolid();
  wait 0.05;
  var_00 delete();
  var_01 = getent("well_clip_top_plug", "script_noteworthy");
  var_01 notsolid();
  var_01 method_805F();
  var_02 = getent("well_clip_door", "script_noteworthy");
  var_02 notsolid();
  var_02 delete();
  var_03 = getent("well_clip_door_ai", "script_noteworthy");
  var_03 notsolid();
  var_03 method_805F();
}

func_0985() {
  var_00 = self;
  var_01 = undefined;
  if(0) {
    var_01 = lib_0557::func_782F(var_00.var_0116 + (0, 0, 46), [var_00]);
    lib_0557::func_781D("1 fire well", var_01);
  }

  common_scripts\utility::func_3C9F(var_00.var_819A);
  if(0) {
    lib_0557::func_7847("1 fire well", var_01);
  }
}

func_7856() {
  var_00 = getent("pilot_light_trigger", "targetname");
  var_01 = spawnStruct();
  var_00 childthread common_scripts\utility::func_A75D("trigger", var_01);
  foreach(var_03 in level.var_3EFB) {
    var_03 childthread common_scripts\utility::func_A75D("valve_complete", var_01);
  }

  var_01 waittill("returned", var_05, var_06);
  var_01 notify("die");
  var_07 = var_06;
  if(!lib_0557::func_42D6("1 fire well")) {
    lib_0557::func_8564("1 fire well", 1);
  }

  if(!lib_0557::func_434E("1 fire well")) {
    lib_0557::func_8596("1 fire well", 1);
  }

  if(var_07 == var_00) {
    lib_0557::func_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_VALVE");
    common_scripts\utility::func_A70B(level.var_3EFB, "valve_complete");
  }

  lib_0557::func_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_MORE_VALVES");
}

func_7855() {
  var_00 = ["fuel_valve_1", "fuel_valve_2", "fuel_valve_3"];
  level.var_3EFB = [];
  foreach(var_02 in level.var_A2A0) {
    if(lib_0547::func_5565(var_02.var_01A5, "fuel_valve")) {
      var_02 thread func_A29E();
      level.var_3EFB = common_scripts\utility::func_0F6F(level.var_3EFB, var_02);
    }
  }

  level thread func_7856();
  thread func_AC9B();
  thread func_3C29(["fuel_valve_1"], "firewell_machinery_light_1", "targetname");
  thread func_3C29(["fuel_valve_2"], "firewell_machinery_light_2", "targetname");
  thread func_3C29(["fuel_valve_3"], "firewell_machinery_light_3", "targetname");
  thread func_3C29(var_00, "zmb_flamethrower_light", "script_noteworthy");
  common_scripts\utility::func_3CA1(var_00);
  var_04 = function_021F("green", "targetname");
  foreach(var_06 in var_04) {
    var_06 setscriptablepartstate("light", "green");
  }

  lib_0557::func_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_PILOT_LIGHT");
  var_08 = getent("pilot_light_trigger", "targetname");
  if(0) {
    if(isDefined(var_08)) {
      var_09 = getent("nest_ee_pilot_light_model", "targetname");
      var_0A = lib_0557::func_782F(undefined, [var_09]);
      lib_0557::func_781D("1 fire well", var_0A);
    }
  }

  common_scripts\utility::func_3C9F("Pilot light activated");
  lib_0557::func_782D("1 fire well", "gas flowing");
  level thread func_3C2A();
  func_7854();
}

func_A29E() {
  var_00 = self;
  var_01 = common_scripts\utility::func_46B7("gas_vfx", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B7("indicator_light_vfx", "script_noteworthy");
  var_03 = common_scripts\utility::func_4461(self.var_0116, var_02);
  var_04 = common_scripts\utility::func_46B7("indicator_light_vfx_top", "script_noteworthy");
  var_05 = common_scripts\utility::func_4461(self.var_0116, var_04);
  var_06 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_light_red"), var_03.var_0116, anglesToForward(var_03.var_001D), anglestoup(var_03.var_001D));
  var_07 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_bulb_red"), var_05.var_0116, anglesToForward(var_05.var_001D), anglestoup(var_05.var_001D));
  triggerfx(var_06, 0.5);
  triggerfx(var_07, 0.5);
  common_scripts\utility::func_3C9F(self.var_819A);
  var_06 delete();
  var_07 delete();
  var_06 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_light_green"), var_03.var_0116, anglesToForward(var_03.var_001D), anglestoup(var_03.var_001D));
  var_07 = spawnfx(common_scripts\utility::func_44F5("zmb_nest_generator_bulb_green"), var_05.var_0116, anglesToForward(var_05.var_001D), anglestoup(var_05.var_001D));
  triggerfx(var_06);
  triggerfx(var_07);
}

func_7854() {
  if(!isDefined(level.var_6FEB)) {
    level.var_6FEB = level.var_721C;
  }

  var_00 = common_scripts\utility::func_46B7("well_explosion", "script_noteworthy");
  var_01 = var_00[0].var_0116;
  lib_0378::func_8D74("well_explosion_ignite", var_01);
  wait(0.4);
  lib_0378::func_8D74("well_explosion", var_01);
  if(!common_scripts\utility::func_3C77("fire trap active")) {
    thread func_3C26();
    if(!common_scripts\utility::func_562E(level.var_76CE)) {
      thread func_9063();
      lib_0378::func_8D74("well_zombies_group_scream", var_01);
    }

    thread func_2E86();
  }

  thread func_3C2B();
  thread func_3C20();
  thread func_3BEA();
  if(!common_scripts\utility::func_562E(level.var_6659)) {
    foreach(var_03 in var_00) {
      earthquake(0.3, 4, var_03.var_0116, 850);
      playFX(common_scripts\utility::func_44F5("zmb_firepit_blast"), var_03.var_0116);
      level thread common_scripts\_exploder::func_088E(201);
      wait(0.4);
      level thread common_scripts\_exploder::func_088E(202);
      wait(0.4);
      level thread common_scripts\_exploder::func_088E(203);
      wait(1);
      level thread common_scripts\_exploder::func_088E(204);
    }
  }

  wait(3);
  if(!common_scripts\utility::func_3C77("fire trap active")) {
    func_AA05();
    common_scripts\utility::func_3C8F("fire trap active");
    common_scripts\utility::func_3C8F("gallows_to_well");
    var_05 = function_021F("color", "targetname");
    foreach(var_07 in var_05) {
      wait(0.1);
      var_07 setscriptablepartstate("lightpart", "color");
    }
  }

  level notify("zmb_flamethrower_light", 0);
}

func_9CAB(param_00) {
  if(!isDefined(level.var_6FEB)) {
    level.var_6FEB = level.var_721C;
  }

  var_01 = common_scripts\utility::func_46B7("well_explosion", "script_noteworthy");
  var_02 = var_01[0].var_0116;
  lib_0378::func_8D74("well_explosion_ignite", var_02);
  wait(0.4);
  lib_0378::func_8D74("well_explosion", var_02);
  if(!common_scripts\utility::func_3C77("fire trap active")) {
    thread func_3C26();
    if(!common_scripts\utility::func_562E(level.var_76CE)) {
      thread func_9063();
      lib_0378::func_8D74("well_zombies_group_scream", var_02);
    }

    thread func_2E86();
  }

  thread func_3C2B();
  thread func_3C20(param_00);
  thread func_3BEA();
  if(!common_scripts\utility::func_562E(level.var_6659)) {
    foreach(var_04 in var_01) {
      earthquake(0.3, 4, var_04.var_0116, 850);
      playFX(common_scripts\utility::func_44F5("zmb_firepit_blast"), var_04.var_0116);
      level thread common_scripts\_exploder::func_088E(201);
      wait(0.4);
      level thread common_scripts\_exploder::func_088E(202);
      wait(0.4);
      level thread common_scripts\_exploder::func_088E(203);
    }
  }

  wait(3);
  if(!common_scripts\utility::func_3C77("fire trap active")) {
    func_AA05();
    common_scripts\utility::func_3C8F("fire trap active");
    common_scripts\utility::func_3C8F("gallows_to_well");
    var_06 = function_021F("color", "targetname");
    foreach(var_08 in var_06) {
      wait(0.1);
      var_08 setscriptablepartstate("lightpart", "color");
    }
  }

  level notify("zmb_flamethrower_light", 0);
}

func_3C26() {
  wait(0.25);
  var_00 = getEntArray("well_cover", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(var_02.var_0106 == "zmb_well_grate_01") {
      var_02 setModel("zmb_well_grate_01_brkn");
      continue;
    }

    var_02 delete();
  }
}

func_3C2B() {
  level.var_665A = 1;
  wait(0.5);
  level.var_665A = 0;
}

func_3C2A() {
  for(;;) {
    var_00 = maps\mp\zombies\_zombies_traps::func_438E();
    wait(var_00);
    level notify("zmb_flamethrower_light", 1);
    level notify("firewell_machinery_ready");
    level waittill("firewell_machinery_reset");
    level notify("zmb_flamethrower_light", 0);
  }
}

func_3C29(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B5(param_01, param_02);
  var_04 = lib_0547::func_8FBA(var_03, "zmb_nest_generator_bulb_red");
  triggerfx(var_04);
  common_scripts\utility::func_3CA1(param_00);
  var_04 delete();
  var_04 = lib_0547::func_8FBA(var_03, "zmb_nest_generator_bulb_green");
  triggerfx(var_04);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("1 fire well", "gas flowing"));
  for(;;) {
    level waittill(param_01, var_05);
    var_04 delete();
    if(var_05) {
      var_04 = lib_0547::func_8FBA(var_03, "zmb_nest_generator_bulb_green");
    } else {
      var_04 = lib_0547::func_8FBA(var_03, "zmb_nest_generator_bulb_red");
    }

    triggerfx(var_04);
  }
}

func_A691() {
  var_00 = common_scripts\utility::func_A70B(level.var_3EFB, "valve_complete");
  return var_00.var_721C;
}

func_AC9B() {
  var_00 = func_A691();
  level.var_6665 = 1;
  thread func_2EB3(1, var_00);
  var_00 = func_A691();
  thread func_2EB3(2, var_00);
  var_00 = func_A691();
  thread func_2EB3(3, var_00);
}

func_2EB3(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  switch (param_00) {
    case 1:
      var_02 = undefined;
      if(common_scripts\utility::func_562E(param_01.var_306A) || common_scripts\utility::func_562E(param_01.var_3068)) {
        var_02 = param_01 lib_0367::func_8E3D("valvenext");
      } else {
        var_02 = param_01 lib_0367::func_8E3D("valvefirst");
      }

      if(isDefined(var_02)) {
        foreach(var_04 in level.var_744A) {
          var_04.var_3073 = 1;
          var_04.var_306A = 1;
          var_04.var_3076 = 1;
          var_04.var_3068 = 1;
        }
      }
      break;

    case 2:
      var_02 = undefined;
      if(common_scripts\utility::func_562E(param_01.var_3073)) {
        var_02 = param_01 lib_0367::func_8E3D("valveturning");
      } else if(common_scripts\utility::func_562E(param_01.var_306A) || common_scripts\utility::func_562E(param_01.var_3068)) {
        var_02 = param_01 lib_0367::func_8E3D("valvenext");
      } else {
        var_02 = param_01 lib_0367::func_8E3D("valvefirst");
      }

      if(isDefined(var_02)) {
        foreach(var_04 in level.var_744A) {
          var_04.var_3074 = 1;
          var_04.var_3068 = 1;
        }
      }
      break;

    case 3:
      foreach(var_04 in level.var_744A) {
        var_04.var_3076 = 0;
      }
      break;
  }
}

func_AC98() {
  var_00 = getent("pilot_light_trigger", "targetname");
  var_00 thread func_AC99();
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(common_scripts\utility::func_562E(level.var_1CBA)) {
      continue;
    }

    if(!common_scripts\utility::func_562E(level.var_6660) && !common_scripts\utility::func_562E(level.var_6665)) {
      level.var_6660 = 1;
      lib_0557::func_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_VALVE");
    }

    if(common_scripts\utility::func_3C77("fuel_valve_1") && common_scripts\utility::func_3C77("fuel_valve_2") && common_scripts\utility::func_3C77("fuel_valve_3")) {
      level.var_6FEB = var_01;
      common_scripts\utility::func_3C8F("Pilot light activated");
      var_00 sethintstring(&"ZOMBIES_EMPTY_STRING");
      break;
    } else {
      thread func_2E85(var_01);
    }
  }
}

func_AC99() {
  self sethintstring(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  common_scripts\utility::func_3CA0("fuel_valve_1", "fuel_valve_2", "fuel_valve_3");
  self sethintstring(&"ZOMBIE_NEST_PILOTLIGHT");
}

func_848D(param_00) {
  if(common_scripts\utility::func_562E(level.var_1CBA) && !common_scripts\utility::func_562E(param_00)) {
    return;
  }

  var_01 = getent("pilot_light_trigger", "targetname");
  var_01 common_scripts\utility::func_9DA3();
}

func_848C() {
  var_00 = getent("pilot_light_trigger", "targetname");
  var_00 common_scripts\utility::func_9D9F();
}

func_2E85(param_00) {
  if(!common_scripts\utility::func_562E(param_00.var_306A)) {
    var_01 = param_00 lib_0367::func_8E3D("firewellpilot");
    if(isDefined(var_01)) {
      param_00.var_306A = 1;
      param_00.var_3073 = 1;
      return;
    }

    return;
  }

  if(common_scripts\utility::func_562E(param_00.var_3076)) {
    var_01 = param_00 lib_0367::func_8E3D("pressuretank");
    if(isDefined(var_01)) {
      param_00.var_3076 = 0;
      return;
    }
  }
}

func_3BEA() {
  var_00 = function_021F("bigfire", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("heat", "enable");
  }

  wait(0.1);
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("heat", "die");
  }

  var_06 = function_021F("smlfire", "targetname");
  foreach(var_08 in var_06) {
    var_08 setscriptablepartstate("heat2", "enable");
  }

  var_0A = function_021F("onoff", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("lightpart", "off");
  }

  var_0A = function_021F("flickr", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("lightpart", "flicker");
  }

  var_0A = function_021F("flickr2", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("lightpart", "flickerstutter");
  }

  var_0A = function_021F("broken", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("lightpart", "off");
  }

  var_0A = function_021F("broken1", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("lightpart", "off1");
  }

  var_0A = function_021F("beamoff", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("glow", "lightbeamoff");
  }

  var_0A = function_021F("lampoff", "targetname");
  foreach(var_0C in var_0A) {
    wait(0.1);
    var_0C setscriptablepartstate("part", "flicker_off1");
  }
}

func_9063() {
  var_00 = common_scripts\utility::func_46B7("well_spawn", "script_noteworthy");
  level.var_3C24 = [];
  foreach(var_02 in var_00) {
    var_03 = lib_054D::func_90BA("zombie_berserker", var_02, "fire well", 0, 1, 1);
    level.var_3C24[level.var_3C24.size] = var_03;
    var_03 common_scripts\utility::func_2CBE(0.5, ::setonfire, 0, 10000, 10000, "none", 1);
    wait(0.3);
  }
}

func_2E86() {
  var_00 = level.var_6FEB;
  if(!isDefined(var_00)) {
    return;
  }

  wait(0.5);
  var_00 thread lib_0367::func_8E3C("firewellblow", undefined, undefined, undefined, "_hi");
}

func_3C20(param_00) {
  self endon("flame_jets_done");
  thread maps\mp\mp_zombie_nest_ee_util::func_3C28();
  var_01 = getEntArray("flame_jets", "script_noteworthy");
  if(common_scripts\utility::func_3C77("fire trap active")) {
    var_02 = getEntArray("gallows_sewer_jumpscare", "targetname");
    var_01 = common_scripts\utility::func_0F73(var_01, var_02);
  }

  foreach(var_04 in var_01) {
    var_04 thread func_3C21();
  }

  var_06 = common_scripts\utility::func_46B5("well_explosion_zombie_grab_radius", "script_noteworthy");
  if(!isDefined(level.var_3BD3)) {
    level.var_3BD3 = spawn("trigger_radius", var_06.var_0116, 0, var_06.var_014F, 128);
  }

  if(isDefined(param_00)) {
    level.fire_well_trap = level.var_3BD3;
    level.fire_well_trap.var_9C92 = param_00;
    level.fire_well_trap.var_9CBB = param_00.var_0165;
  }

  level.var_3BD3 thread func_3C21();
  wait(4);
  foreach(var_08 in level.var_744A) {
    var_08.var_5685 = 0;
  }

  level notify("flame_jets_done");
}

func_3C21() {
  level endon("flame_jets_done");
  var_00 = common_scripts\utility::func_46B5("well_explosion_zombie_grab_radius", "script_noteworthy");
  for(;;) {
    self waittill("trigger", var_01);
    if(!isPlayer(var_01) && function_01EF(var_01) && common_scripts\utility::func_562E(var_01.var_565F) && !var_01 lib_054D::func_56E1()) {
      if(lib_0547::func_5565(var_01.var_01A7, level.var_746E)) {
        continue;
      }

      if(lib_0547::func_5565(var_01.var_0A4B, "zombie_fireman")) {
        continue;
      }

      if(!isDefined(var_01.var_6B38) || var_01.var_6B38 == 0) {
        if(common_scripts\utility::func_3C77("fire trap active")) {
          if(func_3C27()) {
            var_01.var_6B38 = 1;
            var_02 = 5000 * vectornormalize(var_01.var_0116 - var_00.var_0116);
            var_01 lib_0547::func_5A85("torso_lower", (var_02[0], var_02[1], 5000), level.fire_well_trap, "trap_zm_mp");
            if(!isDefined(self.hitbytrap)) {
              foreach(var_04 in level.var_744A) {
                var_04 maps\mp\gametypes\zombies::func_47C7("kill_trap");
                self.hitbytrap = 1;
              }
            }
          } else if(var_01 lib_0547::func_580A()) {
            var_01 dodamage(var_01.var_00BC * 0.25, var_00.var_0116, level.fire_well_trap, level.fire_well_trap, "MOD_EXPLOSIVE", "trap_zm_mp");
            var_01 setonfire(0, 1.5, 1, "none", 1);
          } else {
            thread lib_0547::func_1DB3(var_01, 1.5);
            if(!isDefined(self.hitbytrap)) {
              foreach(var_04 in level.var_744A) {
                var_04 maps\mp\gametypes\zombies::func_47C7("kill_trap");
                self.hitbytrap = 1;
              }
            }
          }
        } else {
          var_01 setonfire(0, 10000, 10000, "none", 1);
        }
      }

      continue;
    }

    if(isPlayer(var_01)) {
      if(!isDefined(var_01.var_6B39) || gettime() - var_01.var_6B39 >= 1000) {
        var_01.var_6B39 = gettime();
        var_01 dodamage(5, var_01.var_0116);
        if(!common_scripts\utility::func_562E(var_01.var_5685) && self.var_003A != "trigger_radius") {
          var_01 notify("fire_touched");
        }
      }
    }
  }
}

func_3C27() {
  return common_scripts\utility::func_562E(level.var_665A);
}