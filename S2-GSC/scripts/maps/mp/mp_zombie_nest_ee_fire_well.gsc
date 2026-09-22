/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_fire_well.gsc
***********************************************************/

_id_40E8() {
  return "bunker_door_opened";
}

_id_418E() {
  return "fire trap active";
}

main() {
  var_0 = ["start_to_gallows", "gallows_to_riverside"];
  _id_0557::_id_7846("explore village", _id_0557::_id_30D8, [], &"ZOMBIE_NEST_HINT_QUEST_VILLAGE", "ZOMBIE_NEST_HINT_QUEST_VILLAGE");
  _id_0557::_id_781E("explore village", "find bunker entrance", ::_id_7830, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_LOCATE_BUNKER_ENT");
  _id_0557::_id_781E("explore village", "Restore Bunker Door Power", ::_id_785E, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_BUNKER_DOOR_POWER");
  _id_0557::_id_7848("explore village");
  _id_0557::_id_7846("1 fire well", _id_0557::_id_30D8, [], &"ZOMBIE_NEST_HINT_QUEST_SEWERS", "ZOMBIE_NEST_HINT_QUEST_SEWERS", 0, 0);
  _id_0557::_id_781E("1 fire well", "gas flowing", ::_id_7855, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_OPEN_SEWERS");
  _id_0557::_id_7848("1 fire well");
  common_scripts\utility::flag_init("bunker_door_opened");
  common_scripts\utility::flag_init("Pilot light activated");
  common_scripts\utility::flag_init("fire trap active");
  _id_AA06();
  thread _id_AC98();
}

_id_7830() {
  var_0 = _getEnt("bunker_ent_dialogue", "targetname");
  var_0 _id_A77B();

  if(!_id_0557::_id_42D6("1 fire well")) {
    _id_0557::_id_8564("1 fire well", 1);
  }

  if(!_id_0557::_id_434E("1 fire well")) {
    _id_0557::_id_8596("1 fire well", 1);
  }

  _id_0557::_id_782D("explore village", "find bunker entrance");
}

_id_A77B() {
  level endon("power_on");
  level endon(_id_0557::_id_7838("1 fire well", "gas flowing"));
  self waittill("trigger");
}

_id_785E() {
  var_0 = _id_053F::_id_44A6("gallows_to_com");
  var_1 = _id_053F::_id_44A6("com_to_rnd");
  var_2 = _id_053F::_id_44A6("com_to_med");
  var_3 = undefined;

  if(0) {
    var_4 = common_scripts\utility::_id_46B7("power_switch", "targetname");
    var_5 = [];

    foreach(var_7 in var_4) {
      var_5[var_5.size] = var_7._id_6298;
    }

    var_9 = common_scripts\utility::_id_0F73(var_5, var_0.setclientdvars);
    var_3 = _id_0557::_id_782F(undefined, var_9);
    _id_0557::_id_781D("explore village", var_3);
  }

  if(!common_scripts\utility::_id_3C77("power_sz2")) {
    common_scripts\utility::_id_3C9F("power_sz2");
  }

  foreach(var_11 in var_0.setclientdvars) {
    var_11 setscriptablepartstate("light", "green");
  }

  if(0) {
    _id_0557::_id_7847("explore village", var_3);
    var_3 = _id_0557::_id_782F(undefined, var_0.setclientdvars);
    _id_0557::_id_781D("explore village", var_3);
  }

  _id_0557::_id_7822("explore village", &"ZOMBIE_NEST_HINT_STEP_OPEN_BUNKER_DOOR");

  if(!common_scripts\utility::_id_562E(var_0._id_6BE1) && !common_scripts\utility::_id_562E(var_1._id_6BE1) && !common_scripts\utility::_id_562E(var_2._id_6BE1)) {
    var_13 = _id_A776([var_0, var_1, var_2]);
    thread _id_1DA7();
    thread _id_1DA5();
    level thread common_scripts\_exploder::_id_088E(209);
  }

  _id_0557::_id_782D("explore village", "Restore Bunker Door Power");
  _id_0557::_id_AB88("bunker_door_opened");
}

_id_1DA7() {
  var_0 = _getscriptablearray("door_light", "targetname");

  foreach(var_2 in var_0) {
    wait 0.5;
    var_2 setscriptablepartstate("puzzlelight", "flicker2");
    wait 1;
    var_2 setscriptablepartstate("puzzlelight", "on");
  }

  var_4 = _getscriptablearray("door_light_1", "targetname");

  foreach(var_6 in var_4) {
    wait 1;
    var_6 setscriptablepartstate("puzzlelight", "flicker2");
    wait 1;
    var_6 setscriptablepartstate("puzzlelight", "on");
  }
}

_id_A776(var_0) {
  foreach(var_2 in var_0) {
    var_2 thread _id_680E();
  }

  level waittill("bunker area open", var_4);
  return var_4;
}

_id_680E() {
  level endon("bunker area open");
  self waittill("open", var_0);
  level notify("bunker area open", var_0);
}

_id_1DA5() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("bunker");
    var_1 _id_0378::_id_8D74("objective_complete", "bunker");
  }
}

_id_44F7() {
  return _id_053F::_id_44A6("gallows_to_com");
}

_id_AA06() {
  var_0 = _getEnt("well_clip_bottom", "script_noteworthy");
  var_0.origin = var_0.origin + (0, 0, 128);
  var_0._id_50D0 = 0;
  waitframe();
  var_0 notsolid();
  var_1 = _getEnt("well_clip_top_plug", "script_noteworthy");
  var_1.origin = var_1.origin + (0, 0, -128);
  var_1._id_50D0 = 1;
  waitframe();
  var_1 disconnectPaths();
  var_2 = _getEnt("well_clip_door", "script_noteworthy");
  var_2.origin = var_2.origin + (0, 0, -128);
  var_2._id_50D0 = 1;
  var_3 = _getEnt("well_clip_door_ai", "script_noteworthy");
  var_3.origin = var_3.origin + (0, 0, -128);
  var_3._id_50D0 = 1;
  waitframe();
  var_3 disconnectPaths();
}

_id_AA05() {
  var_0 = getEntArray("well_clip_top", "script_noteworthy");
  var_1 = _getEnt("well_clip_top_plug", "script_noteworthy");
  var_2 = _getEnt("well_clip_door", "script_noteworthy");

  foreach(var_4 in var_0) {
    var_4 notsolid();
    var_4 connectpaths();
    waitframe();
    var_4 delete();
  }

  var_1 notsolid();
  var_2 notsolid();
}

_id_AA04() {
  var_0 = _getEnt("well_clip_bottom", "script_noteworthy");

  if(!var_0._id_50D0) {
    var_0.origin = var_0.origin + (0, 0, -128);
    var_0._id_50D0 = 1;
  }

  waitframe();
  var_0 solid();
  var_1 = _getEnt("well_clip_top_plug", "script_noteworthy");
  var_1 solid();
  var_2 = _getEnt("well_clip_door", "script_noteworthy");
  var_2 solid();
  var_3 = _getEnt("well_clip_door_ai", "script_noteworthy");
  var_3 solid();
}

_id_AA07() {
  var_0 = _getEnt("well_clip_bottom", "script_noteworthy");

  if(!var_0._id_50D0) {
    var_0.origin = var_0.origin + (0, 0, -128);
    var_0._id_50D0 = 1;
  }

  waitframe();
  var_0 solid();
  var_1 = _getEnt("well_clip_door_ai", "script_noteworthy");
  var_1 connectpaths();
  var_1 notsolid();
}

_id_AA08() {
  var_0 = _getEnt("well_clip_bottom", "script_noteworthy");
  var_0 notsolid();
  waitframe();
  var_0 delete();
  var_1 = _getEnt("well_clip_top_plug", "script_noteworthy");
  var_1 notsolid();
  var_1 disconnectPaths();
  var_2 = _getEnt("well_clip_door", "script_noteworthy");
  var_2 notsolid();
  var_2 delete();
  var_3 = _getEnt("well_clip_door_ai", "script_noteworthy");
  var_3 notsolid();
  var_3 disconnectPaths();
}

_id_0985() {
  var_0 = self;
  var_1 = undefined;

  if(0) {
    var_1 = _id_0557::_id_782F(var_0.origin + (0, 0, 46), [var_0]);
    _id_0557::_id_781D("1 fire well", var_1);
  }

  common_scripts\utility::_id_3C9F(var_0.getnegotiationnextnode);

  if(0) {
    _id_0557::_id_7847("1 fire well", var_1);
  }
}

_id_7856() {
  var_0 = _getEnt("pilot_light_trigger", "targetname");
  var_1 = spawnStruct();
  var_0 childthread common_scripts\utility::_id_A75D("trigger", var_1);

  foreach(var_3 in level._id_3EFB) {
    var_3 childthread common_scripts\utility::_id_A75D("valve_complete", var_1);
  }

  var_1 waittill("returned", var_5, var_6);
  var_1 notify("die");
  var_7 = var_6;

  if(!_id_0557::_id_42D6("1 fire well")) {
    _id_0557::_id_8564("1 fire well", 1);
  }

  if(!_id_0557::_id_434E("1 fire well")) {
    _id_0557::_id_8596("1 fire well", 1);
  }

  if(var_7 == var_0) {
    _id_0557::_id_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_VALVE");
    common_scripts\utility::_id_A70B(level._id_3EFB, "valve_complete");
  }

  _id_0557::_id_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_MORE_VALVES");
}

_id_7855() {
  var_0 = ["fuel_valve_1", "fuel_valve_2", "fuel_valve_3"];
  level._id_3EFB = [];

  foreach(var_2 in level._id_A2A0) {
    if(_id_0547::_id_5565(var_2.targetname, "fuel_valve")) {
      var_2 thread _id_A29E();
      level._id_3EFB = common_scripts\utility::_id_0F6F(level._id_3EFB, var_2);
    }
  }

  level thread _id_7856();
  thread _id_AC9B();
  thread _id_3C29(["fuel_valve_1"], "firewell_machinery_light_1", "targetname");
  thread _id_3C29(["fuel_valve_2"], "firewell_machinery_light_2", "targetname");
  thread _id_3C29(["fuel_valve_3"], "firewell_machinery_light_3", "targetname");
  thread _id_3C29(var_0, "zmb_flamethrower_light", "script_noteworthy");
  common_scripts\utility::_id_3CA1(var_0);
  var_4 = _getscriptablearray("green", "targetname");

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("light", "green");
  }

  _id_0557::_id_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_PILOT_LIGHT");
  var_8 = _getEnt("pilot_light_trigger", "targetname");

  if(0) {
    if(isDefined(var_8)) {
      var_9 = _getEnt("nest_ee_pilot_light_model", "targetname");
      var_10 = _id_0557::_id_782F(undefined, [var_9]);
      _id_0557::_id_781D("1 fire well", var_10);
    }
  }

  common_scripts\utility::_id_3C9F("Pilot light activated");
  _id_0557::_id_782D("1 fire well", "gas flowing");
  level thread _id_3C2A();
  _id_7854();
}

_id_A29E() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_46B7("gas_vfx", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B7("indicator_light_vfx", "script_noteworthy");
  var_3 = common_scripts\utility::_id_4461(self.origin, var_2);
  var_4 = common_scripts\utility::_id_46B7("indicator_light_vfx_top", "script_noteworthy");
  var_5 = common_scripts\utility::_id_4461(self.origin, var_4);
  var_6 = _spawnfx(common_scripts\utility::_id_44F5("zmb_nest_generator_light_red"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_7 = _spawnfx(common_scripts\utility::_id_44F5("zmb_nest_generator_bulb_red"), var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  _triggerfx(var_6, 0.5);
  _triggerfx(var_7, 0.5);
  common_scripts\utility::_id_3C9F(self.getnegotiationnextnode);
  var_6 delete();
  var_7 delete();
  var_6 = _spawnfx(common_scripts\utility::_id_44F5("zmb_nest_generator_light_green"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  var_7 = _spawnfx(common_scripts\utility::_id_44F5("zmb_nest_generator_bulb_green"), var_5.origin, anglesToForward(var_5.angles), anglestoup(var_5.angles));
  _triggerfx(var_6);
  _triggerfx(var_7);
}

_id_7854() {
  if(!isDefined(level._id_6FEB)) {
    level._id_6FEB = level.player;
  }

  var_0 = common_scripts\utility::_id_46B7("well_explosion", "script_noteworthy");
  var_1 = var_0[0].origin;
  _id_0378::_id_8D74("well_explosion_ignite", var_1);
  wait 0.4;
  _id_0378::_id_8D74("well_explosion", var_1);

  if(!common_scripts\utility::_id_3C77("fire trap active")) {
    thread _id_3C26();

    if(!common_scripts\utility::_id_562E(level._id_76CE)) {
      thread _id_9063();
      _id_0378::_id_8D74("well_zombies_group_scream", var_1);
    }

    thread _id_2E86();
  }

  thread _id_3C2B();
  thread _id_3C20();
  thread _id_3BEA();

  if(!common_scripts\utility::_id_562E(level._id_6659)) {
    foreach(var_3 in var_0) {
      _earthquake(0.3, 4, var_3.origin, 850);
      playFX(common_scripts\utility::_id_44F5("zmb_firepit_blast"), var_3.origin);
      level thread common_scripts\_exploder::_id_088E(201);
      wait 0.4;
      level thread common_scripts\_exploder::_id_088E(202);
      wait 0.4;
      level thread common_scripts\_exploder::_id_088E(203);
      wait 1.0;
      level thread common_scripts\_exploder::_id_088E(204);
    }
  }

  wait 3;

  if(!common_scripts\utility::_id_3C77("fire trap active")) {
    _id_AA05();
    common_scripts\utility::flag_set("fire trap active");
    common_scripts\utility::flag_set("gallows_to_well");
    var_5 = _getscriptablearray("color", "targetname");

    foreach(var_7 in var_5) {
      wait 0.1;
      var_7 setscriptablepartstate("lightpart", "color");
    }
  }

  level notify("zmb_flamethrower_light", 0);
}

_id_9CAB(var_0) {
  if(!isDefined(level._id_6FEB)) {
    level._id_6FEB = level.player;
  }

  var_1 = common_scripts\utility::_id_46B7("well_explosion", "script_noteworthy");
  var_2 = var_1[0].origin;
  _id_0378::_id_8D74("well_explosion_ignite", var_2);
  wait 0.4;
  _id_0378::_id_8D74("well_explosion", var_2);

  if(!common_scripts\utility::_id_3C77("fire trap active")) {
    thread _id_3C26();

    if(!common_scripts\utility::_id_562E(level._id_76CE)) {
      thread _id_9063();
      _id_0378::_id_8D74("well_zombies_group_scream", var_2);
    }

    thread _id_2E86();
  }

  thread _id_3C2B();
  thread _id_3C20(var_0);
  thread _id_3BEA();

  if(!common_scripts\utility::_id_562E(level._id_6659)) {
    foreach(var_4 in var_1) {
      _earthquake(0.3, 4, var_4.origin, 850);
      playFX(common_scripts\utility::_id_44F5("zmb_firepit_blast"), var_4.origin);
      level thread common_scripts\_exploder::_id_088E(201);
      wait 0.4;
      level thread common_scripts\_exploder::_id_088E(202);
      wait 0.4;
      level thread common_scripts\_exploder::_id_088E(203);
    }
  }

  wait 3;

  if(!common_scripts\utility::_id_3C77("fire trap active")) {
    _id_AA05();
    common_scripts\utility::flag_set("fire trap active");
    common_scripts\utility::flag_set("gallows_to_well");
    var_6 = _getscriptablearray("color", "targetname");

    foreach(var_8 in var_6) {
      wait 0.1;
      var_8 setscriptablepartstate("lightpart", "color");
    }
  }

  level notify("zmb_flamethrower_light", 0);
}

_id_3C26() {
  wait 0.25;
  var_0 = getEntArray("well_cover", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.model == "zmb_well_grate_01") {
      var_2 setModel("zmb_well_grate_01_brkn");
      continue;
    }

    var_2 delete();
  }
}

_id_3C2B() {
  level._id_665A = 1;
  wait 0.5;
  level._id_665A = 0;
}

_id_3C2A() {
  for(;;) {
    var_0 = _id_0546::_id_438E();
    wait(var_0);
    level notify("zmb_flamethrower_light", 1);
    level notify("firewell_machinery_ready");
    level waittill("firewell_machinery_reset");
    level notify("zmb_flamethrower_light", 0);
  }
}

_id_3C29(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B5(var_1, var_2);
  var_4 = _id_0547::_id_8FBA(var_3, "zmb_nest_generator_bulb_red");
  _triggerfx(var_4);
  common_scripts\utility::_id_3CA1(var_0);
  var_4 delete();
  var_4 = _id_0547::_id_8FBA(var_3, "zmb_nest_generator_bulb_green");
  _triggerfx(var_4);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("1 fire well", "gas flowing"));

  for(;;) {
    level waittill(var_1, var_5);
    var_4 delete();

    if(var_5) {
      var_4 = _id_0547::_id_8FBA(var_3, "zmb_nest_generator_bulb_green");
    } else {
      var_4 = _id_0547::_id_8FBA(var_3, "zmb_nest_generator_bulb_red");
    }

    _triggerfx(var_4);
  }
}

_id_A691() {
  var_0 = common_scripts\utility::_id_A70B(level._id_3EFB, "valve_complete");
  return var_0.player;
}

_id_AC9B() {
  var_0 = _id_A691();
  level._id_6665 = 1;
  thread _id_2EB3(1, var_0);
  var_0 = _id_A691();
  thread _id_2EB3(2, var_0);
  var_0 = _id_A691();
  thread _id_2EB3(3, var_0);
}

_id_2EB3(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  switch (var_0) {
    case 1:
      var_2 = undefined;

      if(common_scripts\utility::_id_562E(var_1._id_306A) || common_scripts\utility::_id_562E(var_1._id_3068)) {
        var_2 = var_1 _id_0367::_id_8E3D("valvenext");
      } else {
        var_2 = var_1 _id_0367::_id_8E3D("valvefirst");
      }

      if(isDefined(var_2)) {
        foreach(var_4 in level.players) {
          var_4._id_3073 = 1;
          var_4._id_306A = 1;
          var_4._id_3076 = 1;
          var_4._id_3068 = 1;
        }
      }

      break;
    case 2:
      var_2 = undefined;

      if(common_scripts\utility::_id_562E(var_1._id_3073)) {
        var_2 = var_1 _id_0367::_id_8E3D("valveturning");
      } else if(common_scripts\utility::_id_562E(var_1._id_306A) || common_scripts\utility::_id_562E(var_1._id_3068)) {
        var_2 = var_1 _id_0367::_id_8E3D("valvenext");
      } else {
        var_2 = var_1 _id_0367::_id_8E3D("valvefirst");
      }

      if(isDefined(var_2)) {
        foreach(var_4 in level.players) {
          var_4._id_3074 = 1;
          var_4._id_3068 = 1;
        }
      }

      break;
    case 3:
      foreach(var_4 in level.players) {
        var_4._id_3076 = 0;
      }

      break;
  }
}

_id_AC98() {
  var_0 = _getEnt("pilot_light_trigger", "targetname");
  var_0 thread _id_AC99();

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(common_scripts\utility::_id_562E(level._id_1CBA)) {
      continue;
    }
    if(!common_scripts\utility::_id_562E(level._id_6660) && !common_scripts\utility::_id_562E(level._id_6665)) {
      level._id_6660 = 1;
      _id_0557::_id_7822("1 fire well", &"ZOMBIE_NEST_HINT_STEP_FIND_VALVE");
    }

    if(common_scripts\utility::_id_3C77("fuel_valve_1") && common_scripts\utility::_id_3C77("fuel_valve_2") && common_scripts\utility::_id_3C77("fuel_valve_3")) {
      level._id_6FEB = var_1;
      common_scripts\utility::flag_set("Pilot light activated");
      var_0 setHintString(&"ZOMBIES_EMPTY_STRING");
      break;
    } else
      thread _id_2E85(var_1);
  }
}

_id_AC99() {
  self setHintString(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  common_scripts\utility::_id_3CA0("fuel_valve_1", "fuel_valve_2", "fuel_valve_3");
  self setHintString(&"ZOMBIE_NEST_PILOTLIGHT");
}

hideviewmodel(var_0) {
  if(common_scripts\utility::_id_562E(level._id_1CBA) && !common_scripts\utility::_id_562E(var_0)) {
    return;
  }
  var_1 = _getEnt("pilot_light_trigger", "targetname");
  var_1 common_scripts\utility::_id_9DA3();
}

showviewmodel() {
  var_0 = _getEnt("pilot_light_trigger", "targetname");
  var_0 common_scripts\utility::_id_9D9F();
}

_id_2E85(var_0) {
  if(!common_scripts\utility::_id_562E(var_0._id_306A)) {
    var_1 = var_0 _id_0367::_id_8E3D("firewellpilot");

    if(isDefined(var_1)) {
      var_0._id_306A = 1;
      var_0._id_3073 = 1;
      return;
    }
  } else if(common_scripts\utility::_id_562E(var_0._id_3076)) {
    var_1 = var_0 _id_0367::_id_8E3D("pressuretank");

    if(isDefined(var_1)) {
      var_0._id_3076 = 0;
    }
  }
}

_id_3BEA() {
  var_0 = _getscriptablearray("bigfire", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("heat", "enable");
  }

  wait 0.1;

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("heat", "die");
  }

  var_6 = _getscriptablearray("smlfire", "targetname");

  foreach(var_8 in var_6) {
    var_8 setscriptablepartstate("heat2", "enable");
  }

  var_10 = _getscriptablearray("onoff", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("lightpart", "off");
  }

  var_10 = _getscriptablearray("flickr", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("lightpart", "flicker");
  }

  var_10 = _getscriptablearray("flickr2", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("lightpart", "flickerstutter");
  }

  var_10 = _getscriptablearray("broken", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("lightpart", "off");
  }

  var_10 = _getscriptablearray("broken1", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("lightpart", "off1");
  }

  var_10 = _getscriptablearray("beamoff", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("glow", "lightbeamoff");
  }

  var_10 = _getscriptablearray("lampoff", "targetname");

  foreach(var_12 in var_10) {
    wait 0.1;
    var_12 setscriptablepartstate("part", "flicker_off1");
  }
}

_id_9063() {
  var_0 = common_scripts\utility::_id_46B7("well_spawn", "script_noteworthy");
  level._id_3C24 = [];

  foreach(var_2 in var_0) {
    var_3 = _id_054D::_id_90BA("zombie_berserker", var_2, "fire well", 0, 1, 1);
    level._id_3C24[level._id_3C24.size] = var_3;
    var_3 common_scripts\utility::_id_2CBE(0.5, ::_meth_8682, 0, 10000, 10000, "none", 1);
    wait 0.3;
  }
}

_id_2E86() {
  var_0 = level._id_6FEB;

  if(!isDefined(var_0)) {
    return;
  }
  wait 0.5;
  var_0 thread _id_0367::_id_8E3C("firewellblow", undefined, undefined, undefined, "_hi");
}

_id_3C20(var_0) {
  self endon("flame_jets_done");
  thread maps\mp\mp_zombie_nest_ee_util::_id_3C28();
  var_1 = getEntArray("flame_jets", "script_noteworthy");

  if(common_scripts\utility::_id_3C77("fire trap active")) {
    var_2 = getEntArray("gallows_sewer_jumpscare", "targetname");
    var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  }

  foreach(var_4 in var_1) {
    var_4 thread _id_3C21();
  }

  var_6 = common_scripts\utility::_id_46B5("well_explosion_zombie_grab_radius", "script_noteworthy");

  if(!isDefined(level._id_3BD3)) {
    level._id_3BD3 = spawn("trigger_radius", var_6.origin, 0, var_6.radius, 128);
  }

  if(isDefined(var_0)) {
    level.fire_well_trap = level._id_3BD3;
    level.fire_well_trap._id_9C92 = var_0;
    level.fire_well_trap._id_9CBB = var_0._id_0165;
  }

  level._id_3BD3 thread _id_3C21();
  wait 4;

  foreach(var_8 in level.players) {
    var_8._id_5685 = 0;
  }

  level notify("flame_jets_done");
}

_id_3C21() {
  level endon("flame_jets_done");
  var_0 = common_scripts\utility::_id_46B5("well_explosion_zombie_grab_radius", "script_noteworthy");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1) && _isagent(var_1) && common_scripts\utility::_id_562E(var_1._id_565F) && !var_1 _id_054D::_id_56E1()) {
      if(_id_0547::_id_5565(var_1.team, level._id_746E)) {
        continue;
      }
      if(_id_0547::_id_5565(var_1._id_0A4B, "zombie_fireman")) {
        continue;
      }
      if(!isDefined(var_1._id_6B38) || var_1._id_6B38 == 0) {
        if(common_scripts\utility::_id_3C77("fire trap active")) {
          if(_id_3C27()) {
            var_1._id_6B38 = 1;
            var_2 = 5000 * vectorNormalize(var_1.origin - var_0.origin);
            var_1 _id_0547::_id_5A85("torso_lower", (var_2[0], var_2[1], 5000), level.fire_well_trap, "trap_zm_mp");

            if(!isDefined(self.hitbytrap)) {
              foreach(var_4 in level.players) {
                var_4 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
                self.hitbytrap = 1;
              }
            }
          } else if(var_1 _id_0547::_id_580A()) {
            var_1 dodamage(var_1.health * 0.25, var_0.origin, level.fire_well_trap, level.fire_well_trap, "MOD_EXPLOSIVE", "trap_zm_mp");
            var_1 _meth_8682(0, 1.5, 1, "none", 1);
          } else {
            thread _id_0547::_id_1DB3(var_1, 1.5);

            if(!isDefined(self.hitbytrap)) {
              foreach(var_4 in level.players) {
                var_4 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
                self.hitbytrap = 1;
              }
            }
          }
        } else
          var_1 _meth_8682(0, 10000, 10000, "none", 1);
      }

      continue;
    }

    if(isPlayer(var_1)) {
      if(!isDefined(var_1._id_6B39) || gettime() - var_1._id_6B39 >= 1000) {
        var_1._id_6B39 = gettime();
        var_1 dodamage(5, var_1.origin);

        if(!common_scripts\utility::_id_562E(var_1._id_5685) && self.classname != "trigger_radius") {
          var_1 notify("fire_touched");
        }
      }
    }
  }
}

_id_3C27() {
  return common_scripts\utility::_id_562E(level._id_665A);
}