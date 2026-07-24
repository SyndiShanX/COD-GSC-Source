/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3862.gsc
**************************************/

_id_9C7F() {
  return _id_0E4F::_id_9C7B();
}

_id_13652() {
  while(_id_9C7F())
    wait 0.05;
}

_id_79FA() {
  return self._id_4D94._id_4BF9;
}

_id_7902() {
  if(isDefined(level._id_4BC6))
    return level._id_4BC6._id_4D94._id_4BF9;
  else
    return undefined;
}

_id_8E86() {
  _id_0F14::_id_87AC();
}

_id_100E0() {
  _id_0F14::_id_87E3();
}

_id_61FE(var_0) {
  self._id_55F2 = !var_0;
}

_id_61D9(var_0) {
  if(var_0 == 1)
    level.player thread _id_0E44::_id_2168();
  else
    level.player thread _id_0E44::_id_2165();
}

_id_7D24(var_0) {
  var_1 = undefined;
  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_4.classname == "misc_turret") {
      var_1 = var_4;
      break;
    }
  }

  return var_1;
}

_id_F1A2(var_0) {
  if(getDvar("loadout_chosen") != "1")
    return "nul";

  level._id_D127 = _id_0BDC::_id_1079F("veh_player_jackal");
  _id_0BDC::_id_10CD1(level._id_D127, undefined, "hover");
  _id_0BDC::_id_A301(0.5, 0.1);
  thread[[var_0]]();
  var_1 = [];
  var_1["robotics"] = ["Robotics Control", "specialty_saboteur"];
  var_1["life_support"] = ["Life Support", "hud_ability_life_support"];
  level waittill("found_life_support");
  var_2 = scripts\engine\utility::getStruct("life_support_pip", "targetname");
  var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\pip_util::_id_CBB5(var_3, "tag_origin", 65);
  level waittill("found_life_support_entrance");
  var_4 = getEntArray("org_ship_infil", "targetname");
  var_5 = [];
  var_6 = var_4[1];
  level.player playSound("sa_hack_range");
  var_6 _id_1168D(var_1[var_6.script_noteworthy][1]);
  objective_add(scripts\sp\utility::_id_C264("OBJ_INFIL_LIFE"), "current", "", var_6.origin, var_1[var_6.script_noteworthy][1]);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_INFIL_LIFE"), "INFIL: " + var_1[var_6.script_noteworthy][0]);
  var_5[var_5.size] = scripts\sp\utility::_id_C264("OBJ_INFIL_LIFE");
  scripts\sp\pip_util::_id_CBA3();
  level waittill("found_robotics");
  var_2 = scripts\engine\utility::getStruct("robotics_pip", "targetname");
  var_7 = var_2 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\pip_util::_id_CBB5(var_7, "tag_origin", 65);
  level waittill("found_robotics_entrance");
  var_6 = var_4[0];
  level.player playSound("sa_hack_range");
  var_6 _id_1168D(var_1[var_6.script_noteworthy][1]);
  objective_add(scripts\sp\utility::_id_C264("OBJ_INFIL_ROBOT"), "current", "", var_6.origin, var_1[var_6.script_noteworthy][1]);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_INFIL_ROBOT"), "INFIL: " + var_1[var_6.script_noteworthy][0]);
  var_5[var_5.size] = scripts\sp\utility::_id_C264("OBJ_INFIL_ROBOT");
  scripts\sp\pip_util::_id_CBA3();
  var_3 delete();
  var_7 delete();
  level waittill("infil_objectives_set");
  level.player playSound("sa_int_turret_powerup");
  var_8 = getEntArray("trig_ship_infil", "targetname");
  scripts\engine\utility::array_thread(var_8, ::_id_F1A3);
  level waittill("ship_infil_triggered");

  foreach(var_10 in var_5) {
    objective_state(var_10, "invisible");
    objective_delete(var_10);
  }

  level._id_D127 _id_0BDC::_id_F358("zero_g");
  level._id_D127 _id_0BDB::_id_E073();
  level.player _meth_80A1();
  scripts\engine\utility::flag_wait("player_inside_ship");
  level._id_FD19 = 1;
  level notify("ship_assault_start");
  wait 0.05;
  return level._id_E9E3;
}

_id_1168D(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_2 = scripts\sp\hud_util::createicon(var_0, 120, 120);
  var_2 scripts\sp\hud_util::setpoint("CENTER", "CENTER", 0, -200);
  var_2.alpha = 0;
  var_2 fadeovertime(0.2);
  var_2.alpha = 1;

  if(getdvarint("kleenex")) {
    var_3 = level.player _meth_840B(var_1.origin, 65);

    if(isDefined(var_3)) {
      var_3 = var_3 + (0, -20, 0);
      var_2 moveovertime(1);
      var_2.x = var_3[0];
      var_2.y = var_3[1];
    }

    var_2 scaleovertime(1, 30, 30);
    wait 1;
    level.player thread scripts\sp\utility::play_sound_on_entity("support_drone_targeting");
  }

  var_1 delete();
  var_2 destroy();
}

_id_F1A3() {
  level endon("ship_infil_triggered");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  while(!var_2) {
    var_3 = 1;

    while(level._id_D127 istouching(self)) {
      if(var_1 >= 180)
        var_3 = 1;

      if(!var_0) {
        _id_0BDC::_id_A301(0.1, 0.5);
        var_0 = 1;
      }

      if(var_3) {
        thread scripts\sp\utility::_id_56BE("hint_exit_jackal", 3);
        var_3 = 0;
        var_1 = 0;
      }

      if(level.player buttonPressed("BUTTON_X")) {
        var_2 = 1;
        _id_0BDC::_id_A301(0.5, 0.1);
        break;
      }

      var_1++;
      wait 0.05;
    }

    if(var_0) {
      _id_0BDC::_id_A301(0.5, 0.1);
      var_0 = 0;
    }

    wait 0.05;
  }

  level._id_E9E3 = self.script_noteworthy;
  level notify("ship_infil_triggered");
}

_id_D2D5() {
  var_0 = scripts\engine\utility::getStruct("player_start_" + level._id_10CDA, "targetname");
  scripts\sp\utility::_id_11633(var_0);
}

_id_6975() {
  return !level.player scripts\sp\utility::_id_65DB("flag_player_has_jackal");
}

_id_D05C(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0)) {
    var_6 = getEnt(var_0, "targetname");
    var_6 thread _id_F1A3();

    if(isDefined(var_6.target))
      var_7 = scripts\engine\utility::getStruct(var_6.target, "targetname");
    else
      var_7 = var_6;

    if(isDefined(var_3))
      objective_add(scripts\sp\utility::_id_C264("obj_player_exits_jackal"), "current", var_3, var_7.origin);
    else
      objective_add(scripts\sp\utility::_id_C264("obj_player_exits_jackal"), "current", "", var_7.origin);

    level waittill("ship_infil_triggered");

    if(isDefined(var_5)) {
      level waittill(var_5);
      scripts\engine\utility::waitframe();
    }

    objective_delete(scripts\sp\utility::_id_C264("obj_player_exits_jackal"));
  }

  level thread _id_0F00::_id_D05A();

  if(!isDefined(level._id_D127))
    level._id_D127 = getEnt("player_jackal", "targetname");

  if(!isDefined(var_4))
    var_4 = "zero_g";

  level._id_D127 notsolid();
  level._id_D127 _id_0BDC::_id_F358(var_4);
  level._id_D127 _id_0BDB::_id_E073();

  if(isDefined(var_1))
    level._id_D223 _id_0BDC::_id_104A6(0);

  thread _id_0F0E::_id_890C();
  level.player notify("missile_barrage_end");

  if(isDefined(var_2)) {
    var_8 = getcsplineid(var_2);
    level._id_D223 _id_0C24::_id_10A49();
    level._id_D223 _id_0BDC::_id_A301(0.5, 0.1);
    level._id_D223 _meth_8479(var_8);
    level._id_D223 _meth_847B(3);
    var_9 = scripts\engine\utility::waittill_either("goal", "near_goal");
    level._id_D223 _meth_8455(self.origin, 1);

    if(isDefined(level._id_D223))
      level._id_D223 delete();
  }
}

_id_D154(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level._id_D127 = _id_0BDC::_id_1079F(var_0, var_2);
  else if(isDefined(var_2))
    level._id_D127 _id_0BDC::_id_1162F(var_2);

  if(!isDefined(level._id_D127)) {
    return;
  }
  level._id_D127.ignoreall = 1;
  level._id_D127.ignoreme = 1;
  level._id_D127 scripts\sp\vehicle::_id_8441();
  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, level._id_D127);

  if(issentient(level._id_D127))
    level._id_D127 _id_0BDC::_id_19A0(1);

  level._id_D127 _meth_849F(0);
  level._id_D127 _id_0E46::_id_48C4("tag_player", (50, 0, 50), undefined, 35, 2000, 130);
  level._id_D127 _id_0BDC::_id_F48D("zero_g");
  level._id_D127 _id_0BDC::_id_F5BD("instant");
  level._id_D127 _id_0BDC::_id_6B4C("fly", 1);

  if(isDefined(var_1)) {
    var_3 = getcsplineid(var_1);
    level._id_D127 _id_0C24::_id_10A49();
    level._id_D127 _meth_8479(var_3);
    level._id_D127 _meth_847B(0.5);
    var_4 = level._id_D127 scripts\engine\utility::waittill_either("goal", "near_goal");
    level._id_D127 _meth_8455(level._id_D127.origin, 1);
  }

  level._id_D127 _id_0BDC::_id_6B4C("hover", 0);
  level._id_D127 waittill("trigger");
  level notify("player_used_jackal");
  level._id_D127 _meth_849F(1);
  scripts\engine\utility::waitframe();
  level._id_D127 _id_0E46::_id_DFE3();
  _id_0BDC::_id_137D6();
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("player_in_jackal");
  thread _id_0F0E::_id_8968();
}

_id_FCDA() {
  while(!isDefined(level._id_A9E7))
    wait 0.1;

  var_0 = getEntArray("trig_save_ship_assault", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_12716);

  for(;;) {
    scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_off);

    while(level._id_A9E7 + 30000 > gettime())
      wait((level._id_A9E7 + 30000 - gettime()) / 1000);

    scripts\engine\utility::array_thread(var_0, scripts\engine\utility::trigger_on);

    while(level._id_A9E7 + 30000 <= gettime())
      wait 0.05;
  }
}

_id_12716() {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    scripts\sp\utility::_id_2669("");
  }
}

_id_3A25(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_3 = getEnt(var_0, "targetname");

    if(isDefined(var_1))
      level._id_E977.spawners[var_1] = getspawnerarray(var_0, "targetname");
    else
      level._id_E977.spawners["sa00_captain"] = getspawnerarray(var_0, "targetname");
  } else {
    var_3 = getEnt("sa00_captain_spawner", "targetname");

    if(isDefined(var_1))
      level._id_E977.spawners[var_1] = getspawnerarray("sa00_captain_spawner", "targetname");
    else
      level._id_E977.spawners["sa00_captain"] = getspawnerarray("sa00_captain_spawner", "targetname");
  }

  if(isDefined(var_2))
    var_3 thread scripts\sp\utility::_id_1747(var_2);
  else
    var_3 thread scripts\sp\utility::_id_1747(::_id_3A26);

  scripts\engine\utility::flag_init("captain_dead");
}

_id_3A26() {
  self endon("death");
  level._id_3A12 = self;
  thread _id_A5C4();
}

_id_A5C4(var_0) {
  wait 0.05;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(self, "tag_eye", (0, 0, 20), (0, 0, 0));

  if(!isDefined(var_0)) {
    objective_add(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), "current", "Kill the ship's captain", var_1.origin);
    objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), "KILL");
    objective_onentity(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"), var_1);
  }

  self waittill("death");

  if(!isDefined(var_0))
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJ_CAPTAIN_KILL"));

  var_2 = spawnStruct();
  var_2.keyname = "captain_key";
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_2.model = "beacon_intel_tablet";
  var_2._id_FFFE = 1;
  var_2._id_CB2B = "captain_key_pickedUp";
  var_2.owner = self;
  var_2._id_4F4C = "Captain's Key Acquired!";
  var_2._id_4F58 = "Captain's Key Used!";
  scripts\engine\utility::flag_set("captain_dead");
  level thread _id_0F10::_id_FCFC(var_2);
}

_id_FA7E() {}

_id_3E3E(var_0) {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();

  if(!level.player scripts\sp\utility::_id_65DF("player_inside_ship"))
    level.player scripts\sp\utility::_id_65E0("player_inside_ship");

  level.player scripts\sp\utility::_id_65E1("player_inside_ship");

  if(isDefined(level._id_3965) && !level._id_3965 scripts\sp\utility::_id_65DF("player_inside_ship"))
    level._id_3965 scripts\sp\utility::_id_65E0("player_inside_ship");

  level._id_3965 scripts\sp\utility::_id_65E1("player_inside_ship");
  _id_3E3F(var_0);
}

_id_3E3F(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  level.player setOrigin(var_1[0].origin);
  level.player setplayerangles(var_1[0].angles);
}

_id_3E3D(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();

  if(isDefined(var_1) && var_1 == 1)
    _id_3E3B(var_0);
  else
    _id_3E3A(var_0, var_2);
}

_id_3E3A(var_0, var_1) {
  scripts\engine\utility::flag_wait("allies_spawned");
  var_2 = 1;

  foreach(var_4 in level.allies) {
    if(scripts\engine\utility::is_true(var_1))
      var_4 _id_3E3C(var_0 + "_" + var_4._id_EDB8, var_2);
    else
      var_4 _id_3E3C(var_0, var_2);

    var_2++;
  }
}

_id_3E3B(var_0) {
  scripts\engine\utility::flag_wait("allies_spawned_zerog");
  var_1 = 1;

  foreach(var_3 in level._id_1C24) {
    var_3 _id_3E3C(var_0 + "_" + var_3._id_EDB8, var_1);
    var_1++;
  }
}

_id_3E3C(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  if(isDefined(var_1) && isDefined(var_2[var_1]))
    self _meth_80F1(var_2[var_1].origin, var_2[var_1].angles);
  else
    self _meth_80F1(var_2[0].origin, var_2[0].angles);
}

_id_8EA3() {
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_3965))
    level._id_3965 notify("hide_hull");
}

_id_991E(var_0, var_1) {
  if(!level.player scripts\sp\utility::_id_65DF("player_inside_ship"))
    level.player scripts\sp\utility::_id_65E0("player_inside_ship");

  level.player scripts\sp\utility::_id_65E1("player_inside_ship");

  if(!scripts\engine\utility::is_true(var_1))
    _id_0EFE::_id_FD1B();

  if(isDefined(level._id_98C4))
    thread[[level._id_98C4]]();

  if(!isDefined(var_0))
    thread _id_0BB6::_id_39DF();

  wait 0.1;

  if(isDefined(level._id_3965) && !level._id_3965 scripts\sp\utility::_id_65DF("player_inside_ship"))
    level._id_3965 scripts\sp\utility::_id_65E0("player_inside_ship");
  else if(isDefined(level._id_3965))
    level._id_3965 scripts\sp\utility::_id_65E1("player_inside_ship");
}

_id_88DA(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");

  if(isDefined(var_3))
    var_5 = scripts\sp\utility::_id_C264(var_3);
  else
    var_5 = scripts\sp\utility::_id_C264("sa00");

  var_6 = scripts\engine\utility::spawn_tag_origin(var_4 getorigin());
  objective_add(var_5, "current", var_1);
  objective_onentity(var_5, var_6);
  _func_2E9(var_5, 1);

  if(isDefined(var_4) && isDefined(var_4.script_parameters) && var_4.script_parameters == "override_obj_text")
    objective_setpointertextoverride(var_5, var_2);

  while(isDefined(var_4) && isDefined(var_4.target)) {
    var_7 = getEnt(var_4.target, "targetname");
    var_4 waittill("trigger");
    var_4 = var_7;

    if(isDefined(var_4)) {
      var_8 = var_4 getorigin();

      if(isDefined(var_4.target)) {
        var_9 = scripts\engine\utility::getStruct(var_4.target, "targetname");

        if(isDefined(var_9))
          var_8 = var_9.origin;
      }

      var_10 = distance(var_8, var_6.origin) / 300;
      var_10 = clamp(var_10, 0.9, 5.1);
      var_6 moveTo(var_8, var_10, 0.05, 0.05);

      if(isDefined(var_4) && isDefined(var_4.script_parameters) && var_4.script_parameters == "override_obj_text")
        objective_setpointertextoverride(var_5, var_2);
    }
  }

  if(isDefined(var_4))
    var_4 waittill("trigger");

  scripts\sp\utility::_id_C27C(var_5);
}

_id_7C1E(var_0) {
  foreach(var_2 in level._id_E6E0) {
    if(ispointinvolume(var_0, var_2))
      return var_2;
  }

  return undefined;
}

_id_7B0D(var_0) {
  var_1 = getarraykeys(level._id_E99D);

  foreach(var_3 in var_1) {
    foreach(var_5 in level._id_E99D[var_3].doors) {
      var_6 = distance(var_0, var_5.origin);

      if((isDefined(var_5._id_AD38) || isDefined(var_5._id_BE61)) && isDefined(var_5._id_4284) && var_5._id_4284) {
        if(distancesquared(var_0, var_5.origin) < 6400)
          return var_5;
      }
    }
  }

  return undefined;
}

_id_13931(var_0, var_1, var_2) {
  var_1 endon("death");

  if(!isDefined(level._id_263D))
    level._id_263D = 0;

  level._id_263E = "show";

  for(;;) {
    level waittill("update_door_obj", var_3);

    switch (var_3) {
      case "hide":
        if(!level._id_263D) {
          objective_state_nomessage(var_0, "invisible");
          level._id_263E = "hide";
        }

        break;
      case "show":
        objective_state_nomessage(var_0, "current");
        level._id_263E = "show";
        break;
      default:
        break;
    }

    wait 0.05;
  }
}

_id_BC46(var_0, var_1, var_2) {
  var_1 notify("mov_obj");
  var_1 endon("mov_obj");
  var_1 dontinterpolate();
  var_1.origin = var_0;
  thread _id_C278(var_2);
}

_id_2638(var_0) {
  if(!isDefined(level._id_263E))
    level._id_263E = "show";

  if(!isDefined(var_0))
    var_0 = 1;

  level._id_263D = var_0;

  if(level._id_263E == "hide" && var_0 == 1)
    level notify("update_door_obj", "show");
}

_id_2636(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_7E96(var_0, "targetname");
  _id_2635(var_3, var_1, var_2);
}

_id_2635(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = scripts\sp\utility::_id_C264("sa00");
  var_4 = scripts\engine\utility::spawn_tag_origin(var_0.origin);
  level._id_8EE0 = undefined;
  level._id_59B7 = var_1;
  level._id_59B6 = undefined;
  objective_add(var_3, "current");
  objective_onentity(var_3, var_4);
  thread _id_C278(var_3);
  thread _id_13931(var_3, var_4, var_1);
  var_5 = _id_7C1E(var_0.origin);
  var_6 = 0.5;
  var_7 = 0;
  var_8 = undefined;
  var_9 = (0, 0, 0);

  while(isDefined(var_5) && !var_7 && isDefined(var_0)) {
    if(scripts\engine\utility::is_true(level._id_E9E8)) {
      var_10 = undefined;
      var_10 = level.player _meth_855C(level.player.origin, var_0.origin, "door", 128);

      if(!isDefined(var_10)) {
        var_10 = var_0.origin;
        var_11 = var_5;
      } else
        var_11 = _id_7C1E(var_10);

      var_12 = _id_7B0D(var_10);

      if(isDefined(var_12) && !scripts\engine\utility::is_true(var_12._id_19CB)) {
        var_8 = var_12;
        var_10 = var_12.origin + (0, 0, 60);
        var_13 = var_12 scripts\sp\utility::_id_7A97();

        if(isDefined(var_13)) {
          foreach(var_15 in var_13) {
            if(isDefined(var_15.targetname) && var_15.targetname == "auto_obj_loc")
              var_10 = var_15.origin + (0, 0, 60);
          }
        }

        if(var_9 != var_10) {
          thread _id_BC46(var_10, var_4, var_3);
          var_9 = var_10;
        }
      } else if(!isDefined(var_11) || var_5 != var_11) {
        var_10 = var_10 + (0, 0, 32);
        var_17 = distance(var_10, var_9);

        if(var_17 > 64) {
          thread _id_BC46(var_10, var_4, var_3);
          var_9 = var_10;
        }
      } else if(isDefined(var_11) && var_5 == var_11) {
        if(var_9 != var_0.origin) {
          thread _id_BC46(var_0.origin, var_4, var_3);
          var_9 = var_0.origin;
        }

        if(isDefined(level._id_59B7))
          objective_setpointertextoverride(var_3, level._id_59B7);

        level._id_59B6 = 1;

        if(_id_263C(var_0, var_5, var_4, var_3, var_8, var_2)) {
          var_5 = undefined;
          level._id_59B6 = undefined;
          objective_setpointertextoverride(var_3, "");
          break;
        }

        level._id_59B6 = undefined;
        objective_setpointertextoverride(var_3, "");
      }

      level scripts\engine\utility::waittill_notify_or_timeout("update_objective_path_now", var_6);

      if(isDefined(var_2))
        var_7 = scripts\engine\utility::flag(var_2);

      continue;
    }

    var_18 = level.player findpath(level.player.origin, var_0.origin);
    var_19 = undefined;
    var_20 = 1.0;
    var_19 = undefined;
    var_21 = undefined;
    var_11 = undefined;
    var_12 = undefined;

    foreach(var_23 in var_18) {
      var_11 = _id_7C1E(var_23);

      if(isDefined(var_19) && isDefined(var_11) && isDefined(var_21)) {
        if(var_11 != var_21) {
          var_12 = _id_7B0D((var_23 + var_19) / 2);

          if(isDefined(var_12)) {
            var_8 = var_12;
            var_10 = var_12.origin + (0, 0, 60);
            var_13 = var_12 scripts\sp\utility::_id_7A97();

            if(isDefined(var_13)) {
              foreach(var_15 in var_13) {
                if(isDefined(var_15.targetname) && var_15.targetname == "auto_obj_loc")
                  var_10 = var_15.origin + (0, 0, 60);
              }
            }

            if(var_9 != var_10) {
              thread _id_BC46(var_10, var_4, var_3);
              var_9 = var_10;
            }

            break;
          } else if(var_5 == var_11) {
            if(var_9 != var_0.origin) {
              thread _id_BC46(var_0.origin, var_4, var_3);
              var_9 = var_0.origin;
            }

            if(isDefined(level._id_59B7))
              objective_setpointertextoverride(var_3, level._id_59B7);

            level._id_59B6 = 1;

            if(_id_263C(var_0, var_5, var_4, var_3, var_8, var_2)) {
              var_5 = undefined;
              level._id_59B6 = undefined;
              objective_setpointertextoverride(var_3, "");
              break;
            }

            level._id_59B6 = undefined;
            objective_setpointertextoverride(var_3, "");
          }
        }
      }

      var_19 = var_23;
      var_21 = var_11;
    }

    level scripts\engine\utility::waittill_notify_or_timeout("update_objective_path_now", var_6);

    if(isDefined(var_2))
      var_7 = scripts\engine\utility::flag(var_2);
  }

  scripts\sp\utility::_id_C27C(var_3);
  var_4 delete();
}

_id_2637(var_0) {
  level._id_59B7 = var_0;

  if(isDefined(level._id_59B6))
    objective_setpointertextoverride(scripts\sp\utility::_id_C264("sa00"), level._id_59B7);
}

_id_13593() {
  self endon("death");
  self endon("autoobj_stop_wait");

  if(isDefined(self._id_4C1F))
    self._id_4C1F waittill("trigger");
  else
    self waittill("trigger");

  self._id_2665 = 1;
}

_id_263C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 512;
  var_7 = var_6 * var_6;
  var_8 = 10000;
  var_9 = 0;

  if(isDefined(var_5) && scripts\engine\utility::flag(var_5))
    var_9 = 1;

  var_10 = 1;
  var_11 = 0;

  if(isDefined(var_0._id_4C1F) || isDefined(var_0._id_6AF1))
    var_0 thread _id_13593();

  while(isDefined(var_0) && !var_9 && var_10 && !isDefined(var_0._id_2665)) {
    if((!isDefined(var_4) || isDefined(var_4._id_4284) && var_4._id_4284) && !level.player istouching(var_1)) {
      var_10 = 0;
      continue;
    }

    if(isDefined(var_5) && scripts\engine\utility::flag(var_5)) {
      var_9 = 1;
      continue;
    }

    var_12 = scripts\engine\utility::is_true(level._id_C816);

    if(var_12 && !isDefined(level._id_8EE0))
      level._id_8EE0 = 0;

    var_13 = distancesquared(level.player.origin, var_0.origin);

    if(isDefined(level._id_8EE0)) {
      if(var_12 != level._id_8EE0) {
        if(var_12) {
          level._id_8EE0 = 1;
          objective_state(var_3, "invisible");
        } else {
          level._id_8EE0 = 0;
          objective_state(var_3, "current");
        }
      }

      if(var_13 < var_8) {
        level._id_8EE0 = 0;
        self notify("autoobj_stop_wait");
        return 1;
      }
    } else if(isDefined(var_0._id_4C1F) || isDefined(var_0._id_6AF1)) {
      if(var_11 && var_13 >= var_7) {
        var_11 = 0;
        objective_state(var_3, "current");
      } else if(!var_11 && var_13 < var_7) {
        var_11 = 1;
        objective_state(var_3, "invisible");
      }
    } else if(var_13 < var_8) {
      self notify("autoobj_stop_wait");
      return 1;
    }

    wait 0.1;
  }

  self notify("autoobj_stop_wait");

  if(scripts\engine\utility::is_true(level._id_8EE0)) {
    level._id_8EE0 = 0;
    objective_state(var_3, "current");
  }

  if(!isDefined(var_0) || var_9 || isDefined(var_0._id_2665))
    return 1;

  return 0;
}

_id_893C(var_0) {
  foreach(var_2 in var_0)
  thread _id_893A(var_2);
}

_id_893A(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  objective_add(scripts\sp\utility::_id_C264(var_1.script_noteworthy), "current", "", var_1.origin, level._id_C6B6[var_1.script_noteworthy][1]);
  objective_setpointertextoverride(scripts\sp\utility::_id_C264(var_1.script_noteworthy), level._id_C6B6[var_1.script_noteworthy][0]);
}

_id_893B(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1))
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264(var_2.script_noteworthy));

  objective_state(scripts\sp\utility::_id_C264(var_2.script_noteworthy), "invisible");
  objective_delete(scripts\sp\utility::_id_C264(var_2.script_noteworthy));
}

_id_88CA(var_0) {
  wait 5;

  if(isDefined(var_0))
    var_1 = scripts\sp\vehicle::_id_1080E(var_0);
  else
    var_1 = scripts\sp\vehicle::_id_1080E("destroyer_exterior_hull");

  foreach(var_3 in var_1) {
    var_3.script_disconnectpaths = 0;
    var_3 notsolid();
  }

  for(;;) {
    while(getDvar("toggle_ship_visibility") == "1")
      wait 0.05;

    foreach(var_3 in var_1) {
      var_3 hide();
      var_3 _id_0BB8::_id_39CD("off");
      var_3 _id_0BB8::_id_39D0("off");
      var_3 _id_0BB8::_id_39CE("off");
    }

    while(getDvar("toggle_ship_visibility") == "0")
      wait 0.05;

    foreach(var_3 in var_1) {
      var_3 show();
      var_3 _id_0BB8::_id_39CD("idle");
      var_3 _id_0BB8::_id_39D0("idle");
      var_3 _id_0BB8::_id_39CE("high");
    }
  }
}

_id_88B8() {
  scripts\engine\utility::waitframe();
  var_0 = getEnt("bridge_door1", "targetname");
  var_1 = getEnt("bridge_door2", "targetname");
  var_0 _id_0F05::_id_F2F6(0);
  var_1 _id_0F05::_id_F2F6(0);
}

_id_8965() {
  var_0 = getEnt("door_left", "targetname");
  var_1 = getEnt("door_right", "targetname");
  scripts\sp\utility::_id_127B3("open_hatch");
  wait 1.5;
  var_0 movey(-68, 1);
  var_1 movey(68, 1);
  scripts\sp\utility::_id_127B3("close_hatch");
  var_0 movey(68, 1);
  var_1 movey(-68, 1);
  wait 1;
  scripts\engine\utility::flag_set("inside_trash_compactor");
  scripts\engine\utility::flag_set("player_in_gravity");
}

_id_8914(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon(var_3);

  if(isDefined(var_4)) {
    var_9 = scripts\engine\utility::random(var_4);
    level.player scripts\sp\utility::_id_1034D(var_9);
  }

  if(isDefined(var_5)) {
    var_10 = scripts\engine\utility::random(var_5);
    scripts\sp\utility::_id_10350(var_10);
  }

  if(isDefined(var_6))
    level.player playSound(var_6);

  level.player _id_0F14::_id_10DE1(var_0, "HOLD");
  level.player._id_D9E4 settext(var_1);
  level.player._id_D9E4.y = level.player._id_D9E4.y + 15;
  var_11 = undefined;

  if(isDefined(var_8)) {
    var_11 = scripts\engine\utility::play_loopsound_in_space(var_8, level.player.origin);
    var_11 linkTo(level.player);
  }

  thread _id_4089(var_2, var_3, var_7, var_11);
  var_12 = 0;
  var_13 = 0.05;

  for(;;) {
    if(level._id_2820)
      var_12 = var_12 + var_13;
    else if(var_12 >= 0.05)
      var_12 = var_12 - var_13;
    else
      var_12 = 0;

    level.player._id_D9E3.bar.color = (1, 1, 1);
    var_14 = var_12 / var_0;
    level.player _id_0F14::_id_F80E(var_14, level.player._id_D9E3);

    if(var_14 >= 1.0) {
      level notify(var_3);
      break;
    } else
      wait(var_13);
  }
}

_id_4089(var_0, var_1, var_2, var_3) {
  level waittill(var_1);

  if(isDefined(var_3)) {
    var_3 stoploopsound();
    var_3 delete();
  }

  if(isDefined(var_2))
    level.player playSound("sa_hack_finish");

  level.player._id_D9E4 settext(var_0);
  wait 0.5;
  level.player._id_D9E4 scripts\sp\hud_util::destroyelem();
  level.player._id_D9E3 scripts\sp\hud_util::destroyelem();
}

_id_8925(var_0) {
  if(isDefined(var_0))
    level._id_10FB1 = getEnt(var_0, "targetname");
  else
    level._id_10FB1 = getEnt("stolen_tech", "targetname");

  level._id_10FB1 _id_0E46::_id_48C4();
  level._id_10FB1 waittill("trigger");
  level._id_10FB1 delete();
}

_id_FA19(var_0) {
  if(isDefined(var_0)) {
    level.player setstance(var_0);

    switch (var_0) {
      case "crouch":
        level.player allowcrouch(1);
        level.player allowprone(0);
        level.player allowstand(0);
        break;
      case "prone":
        level.player allowprone(1);
        level.player allowcrouch(0);
        level.player allowstand(0);
        break;
      case "stand":
      default:
        level.player allowstand(1);
        level.player allowprone(0);
        level.player allowcrouch(0);
        break;
    }
  } else {
    level.player setstance("stand");
    level.player allowstand(1);
    level.player allowprone(0);
    level.player allowcrouch(0);
  }
}

_id_8964(var_0, var_1, var_2) {
  level endon(var_1);
  scripts\engine\utility::flag_init("out_of_time");
  var_3 = level.player scripts\sp\hud_util::_id_499D("objective", 2.5);
  var_3.alpha = 1;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "left";
  var_3.vertalign = "top";
  var_3.x = 10;
  var_3.y = 10;
  var_3.hidewheninmenu = 0;
  var_3.hidewhendead = 1;
  var_3 settenthstimer(var_0 * 60);
  wait(var_0 * 60);

  if(isDefined(var_2))
    scripts\engine\utility::flag_set(var_2);
  else
    scripts\engine\utility::flag_set("out_of_time");

  var_3 thread _id_A620(var_1);
}

_id_A620(var_0) {
  self notify(var_0);

  if(isDefined(self))
    self destroy();
}

_id_2B49(var_0, var_1, var_2) {
  var_3 = level.player;
  var_4 = "black";

  if(!isDefined(var_3._id_C7FD)) {
    var_3._id_C7FD = [];
    var_3._id_C7FD[var_4] = scripts\sp\hud_util::_id_48B7(var_4, 0, var_3);
    var_3._id_C7FD[var_4].sort = 0;
    var_3._id_C7FD[var_4].foreground = 1;
    var_3._id_C7FD[var_4].alpha = 0;
  }

  if(isDefined(var_2))
    var_3._id_C7FD[var_4] fadeovertime(var_2);

  var_3._id_C7FD[var_4].alpha = 1;
  wait(var_0);

  if(isDefined(var_1))
    var_3._id_C7FD[var_4] fadeovertime(var_1);

  var_3._id_C7FD[var_4].alpha = 0;
}

_id_9C21(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon(var_3);

  var_4 = getEnt(var_1, "targetname");

  for(;;) {
    if(ispointinvolume(var_0.origin, var_4)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set(var_2);
}

_id_FA47(var_0) {
  if(!isDefined(var_0))
    var_0 = "rotating_roid";

  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_4 = getEntArray(var_3.target, "targetname");
      scripts\engine\utility::array_call(var_4, ::linkto, var_3);
    }

    var_3 thread _id_6F40();
  }
}

_id_FA48(var_0) {
  if(!isDefined(var_0))
    var_0 = "linear_mover";

  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.target)) {
      var_4 = getEntArray(var_3.target, "targetname");
      scripts\engine\utility::array_call(var_4, ::linkto, var_3);
    }

    var_5 = 90;
    var_6 = randomfloatrange(-0.25, 0.25);
    var_5 = var_5 + var_5 * var_6;

    if(isDefined(var_3.script_parameters))
      var_5 = float(var_3.script_parameters);

    var_5 = var_5 + var_5 * var_6;

    if(isDefined(var_3.script_noteworthy)) {
      var_7 = scripts\engine\utility::getStruct(var_3.script_noteworthy, "targetname");

      if(isDefined(var_7)) {
        if(isDefined(var_7.target)) {
          var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
          var_9 = var_7.origin - var_8.origin;
          var_3 thread _id_BC37(var_9, var_5, 1);
        } else
          var_3 thread _id_BC37(var_7.origin, var_5);
      }
    }
  }
}

_id_BC37(var_0, var_1, var_2) {
  level endon("stop_move_in_space");
  var_2 = scripts\engine\utility::is_true(var_2);
  var_3 = var_0;
  var_4 = self.origin;
  var_5 = var_1 / 4;
  thread _id_E228(self.origin, self.angles);

  for(;;) {
    if(var_2) {
      var_3 = self.origin + var_0;
      self rotateby((randomfloatrange(-10, 10), randomfloatrange(-10, 10), 0) * var_1, var_1, var_5, var_5);
    }

    self moveTo(var_3, var_1, var_5, var_5);
    self waittill("movedone");

    if(var_2)
      self rotateby((randomfloatrange(-10, 10), randomfloatrange(-10, 10), 0) * var_1, var_1, var_5, var_5);

    self moveTo(var_4, var_1, var_5, var_5);
    self waittill("movedone");
  }
}

_id_E228(var_0, var_1) {
  level waittill("stop_move_in_space");
  scripts\engine\utility::waitframe();
  self.origin = var_0;
  self.angles = var_1;
}

_id_6F40() {
  self endon("stop_float_in_space");
  level endon("death");
  level endon("stop_space_debris");
  var_0 = 0.1;
  var_1 = (1, 1, 0);

  if(isDefined(self.script_parameters)) {
    var_2 = strtok(self.script_parameters, " ");

    if(var_2.size < 3 && float(var_2[0]) > 0) {
      var_0 = float(var_2[0]);
      var_1 = var_1 * var_0;
    } else if(float(var_2[0]) >= 0 && float(var_2[1]) >= 0 && float(var_2[2]) >= 0) {
      var_1 = (float(var_2[0]), float(var_2[1]), float(var_2[2]));
      var_0 = max(var_1[0], max(var_1[1], var_1[2]));
    }
  } else
    var_1 = var_1 * var_0;

  var_3 = var_0 * 10;
  var_4 = 180 / var_3;

  if(var_4 > 20)
    var_4 = var_4 - randomfloatrange(1.0, 20.0);

  var_5 = [];

  for(var_6 = 0; var_6 < 3; var_6++) {
    if(var_1[var_6] > 0) {
      var_5[var_6] = randomfloatrange(-1 * var_1[var_6], var_1[var_6]);
      continue;
    }

    var_5[var_6] = 0.0;
  }

  var_5 = (var_5[0], var_5[1], var_5[2]);
  var_5 = var_5 * 50;

  for(;;) {
    self rotateby(var_5 * var_4, var_4);
    self waittill("rotatedone");
  }
}

_id_1DEA(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  if(isDefined(var_2) && var_2.size >= 1) {
    foreach(var_4 in var_2)
    var_4 thread _id_1DE9(var_1);
  }
}

_id_1DE9(var_0) {
  if(isDefined(var_0))
    level endon(var_0);

  var_1 = self;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = scripts\sp\utility::_id_7A97();

  if(isDefined(var_5))
    var_3 = var_5[0];

  var_6 = scripts\sp\utility::_id_7A8F();

  if(isDefined(var_6))
    var_2 = var_6[0];

  if(isDefined(var_3)) {
    var_3 waittill("trigger", var_4);
    var_4 scripts\sp\utility::_id_F2A8(0);
    var_4 scripts\sp\utility::_id_F416(1);
    var_7 = randomintrange(2, 4);

    for(var_8 = 0; var_8 < var_7; var_8++)
      magicbullet("iw7_ar57", var_4.origin + (randomintrange(10, 20), randomintrange(10, 20), 0), var_4.origin + (0, 0, randomintrange(30, 60)));
  } else if(isDefined(var_2))
    var_2 waittill("trigger");

  scripts\engine\utility::exploder("vfx_rumble");

  if(isDefined(var_1._id_EF20)) {
    if(issubstr(var_1._id_EF20, "exploder")) {
      var_9 = strtok(var_1._id_EF20, ",");
      scripts\engine\utility::exploder(int(var_9[1]));
    } else {
      var_10 = getEnt(var_1.target, "targetname");

      if(isDefined(var_10)) {
        var_11 = strtok(var_1._id_EF20, ",");

        if(isDefined(var_11))
          var_10 _meth_8224(var_10.origin, (float(var_11[0]), float(var_11[1]), float(var_11[2])));
      }
    }
  }

  if(isDefined(var_1.script_count))
    level thread _id_FD60(var_1.origin, var_1.script_count);

  if(isDefined(var_1.script_fxid)) {
    var_12 = strtok(var_1.script_fxid, ",");

    if(isDefined(var_12[0]) && level._effect[var_12[0]])
      playFX(scripts\engine\utility::getfx(var_12[0]), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));

    if(isDefined(var_12[1]) && level._effect[var_12[1]])
      playFX(scripts\engine\utility::getfx(var_12[1]), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
  }

  if(isDefined(var_1.script_soundalias)) {
    if(soundexists(var_1.script_soundalias))
      playworldsound(var_1.script_soundalias, var_1.origin);
  }

  if(isDefined(var_1.script_rumble))
    playrumbleonposition(var_1.script_rumble, var_1.origin);

  if(isDefined(var_1.script_earthquake)) {
    var_13 = strtok(var_1.script_earthquake, ",");
    level thread _id_FD63(var_1.origin, var_13);
  }

  if(isDefined(var_3)) {
    var_4 endon("death");

    if(isDefined(var_4) && isalive(var_4) && isDefined(var_3._id_ECED) && var_3._id_ECED == 1) {
      var_4 scripts\sp\utility::_id_F415(1);
      var_4 scripts\sp\utility::_id_F416(1);
      var_4.a.nodeath = 1;
      var_4.noragdoll = 1;
      var_4 scripts\sp\utility::_id_5564();
      wait(getanimlength(scripts\sp\utility::_id_7ECF(var_3.script_noteworthy)) - 0.05);
      var_4 scripts\sp\utility::_id_F2A8(1);
      var_4 scripts\sp\utility::_id_54C6();
    }
  }
}

_id_FD60(var_0, var_1) {
  level thread _id_FD62(var_1);
  level thread _id_FD61(var_0);
}

_id_FD63(var_0, var_1) {
  if(isDefined(var_1[0]))
    var_2 = float(var_1[0]);
  else
    var_2 = 1.0;

  if(isDefined(var_1[1]))
    var_3 = float(var_1[1]);
  else
    var_3 = 5;

  if(isDefined(var_1[2]))
    var_4 = float(var_1[2]);
  else
    var_4 = var_3 * 0.25;

  if(isDefined(var_1[3]))
    var_5 = float(var_1[3]);
  else
    var_5 = var_3 * 0.5;

  if(isDefined(var_1[4]))
    var_6 = float(var_1[4]);
  else
    var_6 = 1000;

  if(isDefined(var_1[5]))
    var_7 = float(var_1[5]);
  else
    var_7 = 8;

  screenshake(var_0, var_2, var_2, var_2, var_3, var_4, var_5, var_6, var_7, var_7, var_7);
}

_id_FD62(var_0) {
  if(scripts\engine\utility::is_true(level._id_FD64)) {
    return;
  }
  level._id_FD64 = 1;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.angles = (0, 0, 0);
  level.player _meth_823F(var_1);

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_1 rotateTo((randomfloatrange(2.0, 4.0), randomfloatrange(1.0, 3.0), randomfloatrange(1.5, 3.5)), 1.0, 0.25, 0.5);
    wait 1.0;
  }

  var_1 rotateTo((0, 0, 0), 3.0, 0.5, 0.5);
  wait 3.0;
  level.player _meth_823F(undefined);
  var_1 delete();
  level._id_FD64 = undefined;
}

_id_FD61(var_0) {
  _id_0BDC::_id_D527("sa_vip_shiptilt", var_0);
}

_id_E9FC(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, var_1);

  if(isDefined(var_3))
    scripts\sp\utility::_id_15F1(var_0, var_1, var_2);
}

_id_6E41(var_0, var_1, var_2) {
  level endon("death");
  scripts\sp\utility::_id_13754(var_0, var_1);
  scripts\engine\utility::flag_set(var_2);
}

_id_68BF(var_0, var_1, var_2, var_3, var_4) {
  level endon("death");

  if(isDefined(var_3))
    level endon(var_3);

  var_5 = getEnt(var_1, "targetname");
  scripts\engine\utility::flag_wait(var_0);

  if(!isDefined(var_4))
    scripts\sp\utility::_id_2669(var_0);

  if(!isDefined(var_2))
    var_2 = getaiarray("axis");

  foreach(var_7 in var_2)
  var_7 _meth_82F1(var_5);
}

_id_1C17(var_0, var_1) {
  level endon("death");
  scripts\engine\utility::flag_wait(var_0);
  var_2 = getEnt(var_1, "targetname");

  if(!isDefined(var_2) || isDefined(var_2) && isDefined(var_2.trigger_off)) {
    return;
  }
  scripts\sp\utility::_id_15F1(var_1, "targetname", level.player);
}

_id_B2CC(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait(var_0);
  scripts\sp\utility::_id_2669(var_0);
  wait 0.1;
  var_6 = scripts\sp\utility::_id_22CB(var_1, 1);
  var_7 = undefined;

  if(isDefined(var_2)) {
    var_7 = getEnt(var_2, "targetname");

    foreach(var_9 in var_6)
    var_9 _meth_82F1(var_7);
  }

  if(isDefined(var_3) && isDefined(var_4))
    thread _id_6E41(var_6, var_3, var_4);

  if(isDefined(var_5) && isDefined(var_7) && isDefined(var_7.target))
    thread _id_68BF(var_5, var_7.target);

  return var_6;
}

_id_D0D6(var_0) {
  if(scripts\sp\utility::_id_93A6()) {
    return;
  }
  level.player.helmet = spawn("script_model", (0, 0, 0));
  level.player.helmet setModel("vm_hero_protagonist_helmet");
  level.player.helmet _meth_81E2(level.player, "tag_playerhelmet", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  level.player setviewmodeldepthoffield(2, 10);
}

_id_D0D5(var_0) {
  if(isDefined(level.player.helmet)) {
    level.player.helmet _meth_83CB(level.player);
    level.player setviewmodeldepthoffield(0, 0);
    level.player.helmet delete();
  }
}

_id_F603(var_0, var_1) {
  if(!isDefined(level._id_13447))
    level._id_13447 = [];

  level._id_13447[level._id_13447.size] = var_0;
  visionsetnaked(var_0, var_1);
}

_id_E0A8(var_0, var_1) {
  if(!isDefined(level._id_13447) || level._id_13447.size == 0) {
    return;
  }
  var_2 = level._id_13447[level._id_13447.size - 1];
  level._id_13447 = scripts\engine\utility::array_remove(level._id_13447, var_0);

  if(var_2 == var_0) {
    if(level._id_13447.size > 0)
      visionsetnaked(level._id_13447[level._id_13447.size - 1], var_1);
    else
      visionsetnaked("", var_1);
  }
}

_id_94F7() {
  var_0 = getEntArray("amb_fx_trig", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_88A5();
}

_id_88A5() {
  self waittill("trigger");
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_2 in var_0)
  playFX(scripts\engine\utility::getfx(var_2.script_parameters), var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
}

_id_13351(var_0, var_1) {
  if(!isarray(level._id_1290))
    level._id_1290 = [];

  if(!isDefined(level._id_1290[var_0]))
    level._id_1290[var_0] = 0;

  if(scripts\engine\utility::is_true(var_1) && !level._id_1290[var_0]) {
    scripts\engine\utility::exploder(var_0);
    level._id_1290[var_0] = 1;
  } else if(!scripts\engine\utility::is_true(var_1) && level._id_1290[var_0]) {
    scripts\sp\utility::_id_10FEC(var_0);
    level._id_1290[var_0] = 0;
  }
}

_id_C278(var_0) {
  level notify("objective_center_fade_" + var_0);
  level endon("objective_center_fade_" + var_0);
  _func_2E9(var_0, 1);
  _func_2F7(var_0, 0);
  wait 3;
  _func_2F7(var_0, 1);
}

_id_FD14() {
  var_0 = [];
  var_0["r_hudoutlineFillColor0"] = "0 0 0 0";
  var_0["r_hudoutlineFillColor1"] = "0 0 0 0";
  var_0["r_hudoutlineOccludedInlineColor"] = ".7 .7 .7 0.25";
  var_0["r_hudoutlineOccludedInteriorColor"] = ".7 .7 .7 0.25";
  var_0["cg_hud_outline_colors_1"] = "0.5 0.5 0.5 1.000";
  return var_0;
}

_id_FD13() {
  var_0 = 1;
  var_1 = [];
  var_1[var_1.size] = "cg_hud_outline_colors_1";
  var_1[var_1.size] = "cg_hud_outline_colors_2";
  var_1[var_1.size] = "cg_hud_outline_colors_3";
  var_1[var_1.size] = "cg_hud_outline_colors_4";
  var_1[var_1.size] = "cg_hud_outline_colors_5";
  var_1[var_1.size] = "cg_hud_outline_colors_6";
  var_1[var_1.size] = "cg_hud_outline_colors_7";
  var_2 = var_0;

  while(var_2 > 0 && level.player scripts\sp\utility::_id_9B4D()) {
    foreach(var_4 in var_1) {
      var_5 = getDvar(var_4);
      var_6 = strtok(var_5, " ");
      var_7 = "" + var_6[0] + " " + var_6[1] + " " + var_6[2] + " " + var_2 / var_0;
      setsaveddvar(var_4, var_7);
    }

    var_2 = var_2 - 0.05;
    wait 0.05;
  }
}

_id_FCF5() {
  scripts\sp\utility::_id_9187("security_highlighting", 1, ::_id_FD14);
  self setweaponhudiconoverride("actionslot1", "hud_ability_security_highlight");
  self notifyonplayercommand("security_highlighting", "+actionslot 1");
  thread _id_FD12();

  if(!scripts\engine\utility::flag("used_security_cameras"))
    thread scripts\sp\utility::_id_56BA("security_highlighting_hint");
}

_id_FD0C() {
  self setweaponhudiconoverride("actionslot1", "");
  self notify("remove_ability_security_highlighting");
  level notify("security_highlighting_off");
  scripts\engine\utility::flag_clear("used_security_cameras");
  setsaveddvar("r_depthscaneffectenable", 0);
}

_id_FD12() {
  self endon("death");
  self endon("remove_ability_security_highlighting");
  var_0 = 2000;
  var_1 = 1000;
  var_2 = 2000;
  var_3 = 0.25;

  for(;;) {
    self waittill("security_highlighting");

    if(!scripts\sp\utility::_id_9B4D()) {
      continue;
    }
    scripts\engine\utility::flag_set("used_security_cameras");
    setsaveddvar("r_depthscaneffectenable", 1);
    setsaveddvar("r_depthscancolor", "0 0 0 0.25");
    setsaveddvar("r_depthscanoutlinecolor", "0.25 0.25 0.25 1");
    setsaveddvar("r_depthscanoutlinethickness", 50);
    setsaveddvar("r_depthscanthickness", 50);
    var_4 = gettime();
    var_5 = gettime() - var_3;
    var_6 = var_0;
    var_7 = 0;
    var_8 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
    var_9 = [];

    foreach(var_11 in var_8) {
      if(!var_11 scripts\sp\utility::_id_65DF("rss_deactivated") || !var_11 scripts\sp\utility::_id_65DB("rss_deactivated")) {
        var_9 = scripts\engine\utility::array_combine(var_9, getEntArray(var_11.target, "targetname"));
        var_11 thread _id_FD15();
      }
    }

    var_9 = scripts\engine\utility::array_combine(var_9, getaiarray("axis", "allies", "neutral"));
    var_9 = sortbydistance(var_9, self.origin);
    var_13 = 0;

    while(var_13 < var_9.size && scripts\sp\utility::_id_9B4D()) {
      var_14 = (gettime() - var_4) / 1000.0;

      if(var_6 > var_1) {
        var_6 = var_6 - var_2 * var_14;
        var_6 = max(var_6, var_1);
      }

      var_7 = var_7 + var_6 * 0.05;
      var_15 = var_7 * var_7;
      setsaveddvar("r_depthscandistance", var_7);

      for(var_16 = var_13; var_16 < var_9.size; var_16++) {
        if(isDefined(var_9[var_16]) && (!isai(var_9[var_16]) || isalive(var_9[var_16]))) {
          var_17 = distancesquared(var_9[var_16].origin, self.origin);

          if(var_17 <= var_15) {
            if((gettime() - var_5) / 1000 >= var_3) {
              thread scripts\sp\utility::play_sound_on_entity("drone_tag_success");
              var_5 = gettime();
            }

            var_13 = var_16 + 1;

            if(isai(var_9[var_16])) {
              if(isDefined(var_9[var_16].team) && var_9[var_16].team == "axis") {
                var_9[var_16] thread scripts\sp\utility::_id_9196(1, 0, 1, "security_highlighting");
                var_9[var_16] thread _id_F0E9();
              } else {
                var_9[var_16] thread scripts\sp\utility::_id_9196(3, 0, 1, "security_highlighting");
                var_9[var_16] thread _id_F0E9();
              }
            } else {
              var_9[var_16] thread scripts\sp\utility::_id_9196(0, 0, 1, "security_highlighting");
              var_9[var_16] thread _id_F0E9();
            }

            var_9[var_16]._id_C78B = 1;
          } else
            break;

          continue;
        }

        if(var_16 == var_13)
          var_13++;
      }

      wait 0.05;
    }

    setsaveddvar("r_depthscaneffectenable", 0);
    var_18 = self.origin;

    while(var_18 == self.origin && scripts\sp\utility::_id_9B4D()) {
      var_19 = getaiarray("axis", "allies", "neutral");

      foreach(var_21 in var_19) {
        if(!scripts\engine\utility::is_true(var_21._id_C78B)) {
          if(isDefined(var_21.team) && var_21.team == "axis")
            var_21 thread scripts\sp\utility::_id_9196(1, 0, 1, "security_highlighting");
          else
            var_21 thread scripts\sp\utility::_id_9196(2, 0, 1, "security_highlighting");

          var_21._id_C78B = 1;
          var_9[var_9.size] = var_21;
        }
      }

      wait 0.05;
    }

    if(scripts\sp\utility::_id_9B4D())
      wait 4;

    level notify("security_highlighting_off");
    scripts\sp\utility::_id_918D("security_highlighting", ::_id_FD13);

    foreach(var_24 in var_9) {
      if(isDefined(var_24))
        var_24._id_C78B = undefined;
    }

    level.player notify("security_highlighting_disable_hudoutline");
    wait 0.05;
  }
}

_id_F0E9() {
  self endon("death");
  self endon("entitydeleted");
  thread _id_F0E8();
  level.player scripts\engine\utility::waittill_any("security_highlighting_disable_hudoutline", "remove_ability_security_highlighting");
  self notify("remove_ability_security_highlighting");
}

_id_F0E8() {
  self endon("entitydeleted");
  scripts\engine\utility::waittill_any("death", "start_context_melee", "remove_ability_security_highlighting");
  scripts\sp\utility::_id_9193("security_highlighting");
}

_id_FD15() {
  level endon("security_highlighting_off");

  if(scripts\sp\utility::_id_65DF("rss_deactivated")) {
    scripts\sp\utility::_id_65E3("rss_deactivated");
    scripts\engine\utility::array_thread(getEntArray(self.target, "targetname"), scripts\sp\utility::_id_9193, "security_highlighting");
  }
}

isfirstarmageddonmeteorhit(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    scripts\sp\utility::_id_72EC(var_2, "secondary");
    thread scripts\anim\shared::placeweaponon(var_2, "back");
  }

  scripts\sp\utility::_id_72EC(var_0, var_1);
}

_id_88EC() {
  var_0 = getEntArray("fans", "script_noteworthy");

  if(isDefined(var_0)) {
    scripts\engine\utility::array_thread(var_0, ::_id_310D, 1);

    foreach(var_2 in var_0)
    var_2 thread _id_0F31::_id_3109(100);
  }
}

_id_310D(var_0) {
  if(isDefined(self.target)) {
    var_1 = getEntArray(self.target, "targetname");

    if(isDefined(var_1)) {
      foreach(var_3 in var_1)
      var_3 linkTo(self);
    }
  }
}