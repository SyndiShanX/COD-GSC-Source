/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\titanjackal_code.gsc
************************************************************/

_id_1381F(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  if(var_2.size) {
    foreach(var_4 in var_2) {
      if(var_4.classname != "info_volume") {
        var_2 = scripts\engine\utility::array_remove(var_2, var_4);
      }
    }
  }

  if(var_2.size == 1) {
    var_6 = var_2[0];
  } else {
    var_6 = scripts\engine\utility::getclosest(_id_0BDC::_id_7BBA(), var_2, 10000);
  }

  for(;;) {
    var_7 = var_6 scripts\sp\utility::_id_77E3();

    if(!var_7.size) {
      wait 1;
      continue;
    } else
      break;

    wait 0.1;
  }

  wait 3;

  for(;;) {
    var_7 = var_6 scripts\sp\utility::_id_77E3();

    if(var_7.size > 0) {
      wait 0.25;
      continue;
    } else
      break;

    wait 0.1;
  }
}

_id_9C18(var_0) {
  var_1 = level.player getEye();
  var_2 = vectorNormalize(var_0.origin - var_1);
  var_3 = anglesToForward(level.player getplayerangles());
  var_4 = vectordot(var_2, var_3);
  return var_4 >= cos(50);
}

_id_10A5C(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 70;
  }

  var_2 = abs(self.origin[2] - var_0[2]);

  if(var_2 > var_1) {
    return 1;
  }

  return 0;
}

_id_519E(var_0) {
  var_1 = getEntArray("trigger_multiple", "code_classname");
  var_2 = getEntArray("trigger_radius", "classname");
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(distancesquared(level.player.origin, var_6.origin) < var_0 * var_0) {
      var_6 delete();
      var_4++;
    }
  }
}

_id_10FC2() {
  self notify("new_anim_reach");
  self notify("stop_animmode");
  scripts\sp\utility::anim_stopanimScripted();
}

_id_D08E(var_0, var_1, var_2) {
  self endon("stop_trying_gesture");
  thread scripts\sp\utility::_id_C12D("stop_trying_gesture", var_0);

  for(;;) {
    var_3 = scripts\sp\utility::_id_D08C(var_1, var_2);

    if(var_3) {
      return 1;
    } else {
      wait 0.15;
    }
  }
}

_id_13104() {
  if(getdvarint("street_c12")) {
    return 1;
  }

  return 0;
}

_id_195E(var_0) {
  var_1 = 0;

  if(scripts\asm\asm::asm_getdemeanor() == "sprint") {
    var_1 = 1;
    scripts\sp\utility::_id_5522();

    while(!scripts\asm\asm::_id_231B(self.asmname, "gesture")) {
      wait 0.05;
    }
  }

  _id_0C4C::_id_195D(var_0);

  if(var_1) {
    scripts\sp\utility::_id_61F0();
  }
}

_id_1958(var_0) {
  var_1 = 0;

  if(scripts\asm\asm::asm_getdemeanor() == "sprint") {
    var_1 = 1;
    scripts\sp\utility::_id_5522();

    while(!scripts\asm\asm::_id_231B(self.asmname, "gesture")) {
      wait 0.05;
    }
  }

  _id_0C4C::_id_1955(var_0);

  if(var_1) {
    scripts\sp\utility::_id_61F0();
  }
}

_id_1962(var_0) {
  var_1 = 0;

  if(scripts\asm\asm::asm_getdemeanor() == "sprint") {
    var_1 = 1;
    scripts\sp\utility::_id_5522();

    while(!scripts\asm\asm::_id_231B(self.asmname, "gesture")) {
      wait 0.05;
    }
  }

  _id_0C4C::_id_1960(var_0);

  if(var_1) {
    scripts\sp\utility::_id_61F0();
  }
}

_id_10733() {
  _id_10758();
  _id_10764();
  level._id_10AC8 = [level._id_C47F, level._id_2429, level._id_B33B, level._id_B33E];
}

_id_10758() {
  level._id_2429 = scripts\sp\utility::_id_107EA("atom", 1);
  level._id_2429.name = "Ethan";
  level._id_2429._id_1FBB = "atom";
  level._id_2429._id_134DB = ::_id_2434;
  level._id_2429 scripts\sp\utility::_id_72EC("iw7_erad", "primary");
  level._id_C47F = scripts\sp\utility::_id_107EA("marine_co", 1);
  level._id_C47F.name = "Omar";
  level._id_C47F._id_1FBB = "omar";
  level._id_C47F._id_134DB = ::_id_C48A;
  level._id_C47F scripts\sp\utility::_id_72EC("iw7_m4", "primary");
  level._id_8E42 = [level._id_C47F, level._id_2429];
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_8E32);
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_10AD6);

  if(!isDefined(level._id_10AC8)) {
    level._id_10AC8 = [level._id_C47F, level._id_2429];
  } else if(level._id_10AC8.size == 2) {
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_2429);
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_C47F);
  }
}

_id_10764() {
  if(isDefined(level._id_B351)) {
    return;
  }
  level._id_B33B = scripts\sp\utility::_id_107EA("marine1");
  level._id_B33B._id_1FBB = "marine1";
  level._id_B33B.name = "Brooks";
  level._id_B33B._id_134DB = ::_id_30FC;
  level._id_B33B scripts\sp\utility::_id_72EC("iw7_ar57", "primary");
  level._id_B33E = scripts\sp\utility::_id_107EA("marine2");
  level._id_B33E._id_1FBB = "marine2";
  level._id_B33E.name = "Kashima";
  level._id_B33E._id_134DB = ::_id_A556;
  level._id_B33E scripts\sp\utility::_id_72EC("iw7_ake", "primary");
  level._id_B351 = [level._id_B33B, level._id_B33E];
  scripts\engine\utility::array_thread(level._id_B351, ::_id_B34F);
  scripts\engine\utility::array_thread(level._id_B351, ::_id_10AD6);

  if(!isDefined(level._id_10AC8)) {
    level._id_10AC8 = [level._id_B33B, level._id_B33E];
  } else if(level._id_10AC8.size == 2) {
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_B33B);
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_B33E);
  }
}

#using_animtree("generic_human");

_id_10732() {
  var_0 = scripts\sp\vehicle::_id_1080C("friendly_jackal_spaceship");
  var_0.ignoreme = 1;
  var_0.health = 99999;
  var_0 scripts\sp\vehicle::_id_8441();
  var_0 _id_0BDC::_id_19AF(100, 100, 100);
  var_0._id_B00A = spawn("script_origin", (0, 0, 0));
  var_0._id_4074[var_0._id_4074.size] = var_0._id_B00A;
  var_0 scripts\sp\utility::_id_65E0("pause_scripted_behavior");
  var_0 scripts\sp\utility::_id_65E0("pause_scripted_shooting");
  level._id_EAD6 = var_0;
  var_1 = level._id_EAD6 _id_0BDC::_id_1063A("body_hero_xo", "head_hero_noHair_xo", "helmet_hero_xo");
  var_1.origin = level._id_EAD6 gettagorigin("tag_player");
  var_1 dontinterpolate();
  var_1 linkTo(level._id_EAD6, "tag_player", (0, 0, 0), (0, 0, 0));
  var_1 _meth_82A2(%jackal_pilot_pip_motion_idle);
  level._id_EAD6 thread scripts\engine\utility::delete_on_death(var_1);
}

_id_D283(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!scripts\sp\utility::_id_CFAC(var_2)) {
      return 0;
    }
  }

  return 1;
}

_id_B34F() {
  scripts\sp\utility::_id_F3B5("o");
}

_id_8E32() {
  scripts\sp\utility::_id_F3B5("r");
}

_id_10AD6() {
  thread scripts\sp\utility::_id_B14F();
}

_id_BC71(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  } else {
    var_2 = var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = level._id_10AC8;
  }

  foreach(var_5, var_4 in var_1) {
    if(!isDefined(var_2[var_5].angles)) {
      var_2[var_5].angles = (0, 0, 0);
    }

    var_1[var_5] _meth_80F1(var_2[var_5].origin, var_2[var_5].angles);
  }
}

_id_7988(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = call[[level.getnodefunction]](var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

_id_2170(var_0, var_1) {
  var_2 = getdvarint("skip_loadout");

  if(!var_2) {
    return;
  }
  if(!isDefined(var_1)) {
    var_3 = level.player getweaponslistall();
    var_4 = scripts\sp\utility::_id_7AD7();

    if(isDefined(var_4)) {
      var_3 = scripts\engine\utility::array_remove(var_3, var_4);
    }

    foreach(var_6 in var_3) {
      level.player takeweapon(var_6);
    }
  }

  foreach(var_9 in var_0) {
    level.player giveweapon(var_9);
    level.player givemaxammo(var_9);
  }

  if(!isDefined(var_1)) {
    var_11 = level.player scripts\sp\utility::_id_7D74();
    level.player switchtoweapon(var_11[0]);
  }
}

_id_BC52(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = var_1.origin;
  level.player setOrigin(var_2);

  if(isDefined(var_1.angles)) {
    level.player setplayerangles(var_1.angles);
  }
}

_id_7C16(var_0, var_1, var_2) {
  var_3 = anglestoright(self.angles);

  if(isDefined(var_2)) {
    var_3 = var_3 * -1;
  }

  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  return var_0 + var_3 * var_1;
}

_id_79D9(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);

  if(isDefined(var_2)) {
    var_3 = var_3 * -1;
  }

  var_4 = self.origin;
  return var_4 + var_3 * var_0;
}

_id_13798(var_0) {
  var_1 = "timeout_juke";
  level endon(var_1);
  thread _id_C0B9(var_1, var_0);
  _id_0BDC::_id_13797();
  return 1;
}

_id_C0B9(var_0, var_1) {
  wait(var_1);
  level notify(var_0);
}

_id_26E8(var_0) {
  for(;;) {
    var_1 = 0;

    if(!isDefined(var_0)) {
      var_0 = getaiarray("axis");
    }

    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

    foreach(var_3 in var_0) {
      if(isDefined(var_3)) {
        if(var_3 istouching(self)) {
          var_1 = var_1 + 1;
        }
      }
    }

    return var_1;
  }
}

_id_22CC(var_0, var_1) {
  if(isstring(var_0)) {
    var_0 = getEntArray(var_0, "targetname");
  }

  var_2 = scripts\sp\utility::_id_22C6(var_0, 1, 1);
  wait 0.05;

  while(var_2.size > var_1) {
    var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);
    wait 1;
  }

  return;
}

_id_D802(var_0) {
  foreach(var_2 in var_0) {
    precachemodel(var_2);
  }
}

_id_D7FF(var_0) {
  foreach(var_2 in var_0) {
    precacheitem(var_2);
  }
}

_id_D801(var_0) {
  foreach(var_2 in var_0) {
    precacheshader(var_2);
  }
}

_id_D809(var_0) {
  foreach(var_2 in var_0) {
    precachestring(var_2);
  }
}

_id_EB25() {
  level endon("kill_sandstorm_trigs");
  self endon("deleted");

  for(;;) {
    self waittill("trigger");

    if(!_id_EB22()) {
      continue;
    }
    var_0 = scripts\engine\utility::get_target_ent();
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    var_3 = self.script_noteworthy;

    if(isDefined(level._id_EB1B)) {
      if(level._id_EB1B._id_FB2A == var_3 && level._id_EB1B.yaw == var_2[1]) {
        continue;
      }
    }

    thread _id_494B(var_3, var_2[1]);
    wait 1;
  }
}

_id_971F() {
  level._id_EB1B = spawnStruct();
  level._id_EB1B.enabled = 0;
  level._id_EB1B._id_FB2A = "";
  level._id_BFEF = getEntArray("no_fx", "targetname");
}

_id_6233() {
  level._id_EB1B.enabled = 1;
}

_id_557D() {
  level._id_EB1B.enabled = 0;
  level notify("stop_current_sandstorm");

  if(isDefined(level._id_EB1B._id_25A7)) {
    level._id_EB1B._id_25A7 delete();
  }

  if(isDefined(level._id_EB1B._id_25A9)) {
    level._id_EB1B._id_25A9 delete();
  }

  if(isDefined(level._id_EB1B._id_25A8)) {
    level._id_EB1B._id_25A8 delete();
  }

  if(isDefined(level._id_EB1B._id_25CE)) {
    level._id_EB1B._id_25CE _meth_8278(0.0, 0.5);
    level._id_EB1B._id_25CE scripts\engine\utility::delaycall(0.55, ::delete);
  }

  if(isDefined(level._id_EB1B._id_25CF)) {
    level._id_EB1B._id_25CF _meth_8278(0.0, 0.5);
    level._id_EB1B._id_25CF scripts\engine\utility::delaycall(0.55, ::delete);
  }

  if(isDefined(level.player._id_7601)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_dust_wind_visor"), level.player._id_7601, "tag_origin");
    level.player._id_7601 delete();
  }
}

_id_EB22() {
  return level._id_EB1B.enabled == 1;
}

_id_494B(var_0, var_1) {
  if(!_id_EB22()) {
    return;
  }
  level notify("stop_current_sandstorm");
  level endon("stop_current_sandstorm");
  setdvarifuninitialized("sandstorm_debug", 0);
  level._id_EB1B._id_FB2A = var_0;
  var_2 = 1;
  var_3 = 1;
  var_4 = 2.5;
  var_5 = scripts\engine\utility::getfx("sandstorm_single_light");
  var_6 = "titan";
  var_7 = 1;

  if(!isDefined(var_1)) {
    level._id_EB1B.yaw = randomintrange(1, 330);
  } else {
    level._id_EB1B.yaw = var_1;
  }

  var_8 = anglesToForward((0, level._id_EB1B.yaw, 0));

  switch (var_0) {
    case "light":
      var_3 = 1.5;
      var_4 = 2.5;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_light");
      var_2 = 2;
      var_6 = "titan_sandstorm_01";
      var_7 = 1;
      setaudiotriggerstate("default", "wind_light", 7);
      setaudiotriggerstate("titan_ext", "wind_light", 3);
      setaudiotriggerstate("indoorrooms", "interior", 3);
      break;
    case "medium":
      var_3 = 1;
      var_4 = 2;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_medium");
      var_2 = 3;
      var_6 = "titan_sandstorm_02";
      var_7 = 3;
      setaudiotriggerstate("default", "wind_medium", 7);
      setaudiotriggerstate("titan_ext", "wind_medium", 3);
      setaudiotriggerstate("indoorrooms", "interior", 3);
      break;
    case "heavy":
      var_3 = 0.1;
      var_4 = 0.25;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_heavy");
      var_2 = 10;
      var_6 = "titan_sandstorm_03";
      var_7 = 4;
      setaudiotriggerstate("default", "wind_heavy", 7);
      setaudiotriggerstate("titan_ext", "wind_heavy", 3);
      setaudiotriggerstate("indoorrooms", "interior", 3);
      break;
    default:
      break;
  }

  childthread _id_EB1D();
  childthread _id_EB1F();
  thread _id_13D2E(var_7);

  for(;;) {
    var_9 = _id_772D(var_2);

    if(!var_9.size) {
      wait 0.05;
      continue;
    }

    foreach(var_11 in var_9) {
      thread _id_CDFE(var_5, var_11, var_8, anglestoup(level.player.angles));
      wait(randomfloatrange(0.05, 0.15));
    }

    if(randomint(100) <= 40) {
      _id_578D();
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_EB1F() {
  if(!_id_EB22()) {
    return;
  }
  level endon("stop_sandstorm_audio_flyby");

  if(!isDefined(level._id_EB1B._id_25CF)) {
    level._id_EB1B._id_25CF = spawn("script_origin", level.player.origin);
    level._id_EB1B._id_25CF linkTo(level.player);
    level._id_EB1B._id_25CF playLoopSound("emt_titan_wind_plr_facing");
    level._id_EB1B._id_25CF _meth_8278(0.001, 0.001);
  }

  if(!isDefined(level._id_EB1B._id_25CE)) {
    level._id_EB1B._id_25CE = spawn("script_origin", level.player.origin);
    level._id_EB1B._id_25CE linkTo(level.player);
    level._id_EB1B._id_25CE playLoopSound("emt_titan_wind_plr_non_facing");
    level._id_EB1B._id_25CE _meth_8278(0.001, 0.001);
  }

  var_0 = -1;
  var_1 = -2;

  for(;;) {
    foreach(var_3 in level._id_BFEF) {
      if(level.player istouching(var_3)) {
        level._id_EB1B._id_25CE _meth_8278(0.0, 0.3);
        level._id_EB1B._id_25CF _meth_8278(0.0, 0.3);
        wait 0.3;
        continue;
      }
    }

    var_5 = level._id_EB1B.yaw;

    if(var_5 > 180) {
      var_5 = 0 - (360 - var_5);
    }

    var_6 = abs(level.player.angles[1] - var_5);

    if(var_6 > 180) {
      var_6 = 360 - var_6;
    }

    if(var_6 >= 135) {
      var_1 = 1;

      if(var_1 != var_0) {
        var_0 = var_1;
        level._id_EB1B._id_25CE _meth_8278(0.0, 0.5);
        level._id_EB1B._id_25CF _meth_8278(1.0, 0.5);
      }

      if(!level.player scripts\sp\utility::_id_65DB("facing_wind")) {
        level.player scripts\sp\utility::_id_65E1("facing_wind");
      }
    } else if(var_6 > 45 && var_6 < 135) {
      var_1 = 2;

      if(var_1 != var_0) {
        var_0 = var_1;
        level._id_EB1B._id_25CE _meth_8278(0.5, 0.5);
        level._id_EB1B._id_25CF _meth_8278(0.5, 0.5);
      }

      if(level.player scripts\sp\utility::_id_65DB("facing_wind")) {
        level.player scripts\sp\utility::_id_65DD("facing_wind");
      }
    } else {
      var_1 = 3;

      if(var_1 != var_0) {
        var_0 = var_1;
        level._id_EB1B._id_25CE _meth_8278(1.0, 0.5);
        level._id_EB1B._id_25CF _meth_8278(0.0, 0.5);
      }

      if(level.player scripts\sp\utility::_id_65DB("facing_wind")) {
        level.player scripts\sp\utility::_id_65DD("facing_wind");
      }
    }

    wait 0.2;
  }
}

_id_D11D() {
  if(!isDefined(level._id_BFEF)) {
    return 0;
  }

  foreach(var_1 in level._id_BFEF) {
    if(level.player istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_EB1D() {
  if(!_id_EB22()) {
    return;
  }
  var_0 = 0;
  var_1 = 200;
  var_2 = -200;

  if(!isDefined(level._id_EB1B._id_25A7)) {
    level._id_EB1B._id_25A7 = spawn("script_origin", (0, 0, 0));
    var_0 = 0;
    level._id_EB1B._id_25A7 childthread _id_EB1E(var_0);
  }

  if(!isDefined(level._id_EB1B._id_25A8)) {
    level._id_EB1B._id_25A8 = spawn("script_origin", (0, 0, 0));
    var_1 = 900;
    level._id_EB1B._id_25A8 childthread _id_EB1E(var_1);
  }

  if(!isDefined(level._id_EB1B._id_25A9)) {
    level._id_EB1B._id_25A9 = spawn("script_origin", (0, 0, 0));
    var_2 = -900;
    level._id_EB1B._id_25A9 childthread _id_EB1E(var_2);
  }
}

_id_EB1E(var_0) {
  level endon("stop_sandstorm_audio_flyby");

  for(;;) {
    var_1 = 0;

    if(!isDefined(level._id_EB1B.yaw) || !isDefined(level._id_EB1B._id_FB2A)) {
      wait 1;
      continue;
    }

    foreach(var_3 in level._id_BFEF) {
      if(level.player istouching(var_3)) {
        if(_id_EB21()) {
          iprintln("No sandstorm audio ent while player is in NO FX trig");
        }

        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      wait 1;
      continue;
    }

    var_5 = 8;
    var_6 = 18;
    var_7 = 50;
    var_8 = 2000;
    var_9 = "single_windgust";
    var_10 = "emt_titan_wind_bft_mvr_lt";
    var_11 = "emt_titan_wind_debris_mvr_lt";

    switch (level._id_EB1B._id_FB2A) {
      case "light":
        var_5 = 6;
        var_6 = 18;
        var_7 = 10;
        var_8 = 2000;
        level._id_6FFB = "emt_titan_wind_bft_mvr_lt";
        level._id_6FFE = "emt_titan_wind_debris_mvr_lt";
        var_9 = "emt_titan_wind_gust_mvr_lt";
        break;
      case "medium":
        var_5 = 1;
        var_6 = 9;
        var_7 = 34;
        var_8 = 5400;
        level._id_6FFB = "emt_titan_wind_bft_mvr_med";
        level._id_6FFE = "emt_titan_wind_debris_mvr_med";
        var_9 = "emt_titan_wind_gust_mvr_med";
        break;
      case "heavy":
        var_5 = 0;
        var_6 = 7;
        var_7 = 17;
        var_8 = 2700;
        level._id_6FFB = "emt_titan_wind_bft_mvr_hvy";
        level._id_6FFE = "emt_titan_wind_debris_mvr_hvy";
        var_9 = "emt_titan_wind_gust_mvr_hvy";
        break;
      default:
        break;
    }

    var_12 = (0, level._id_EB1B.yaw, 0);
    var_13 = level.player _id_79D9(var_8 * 0.25, var_12, 1);
    var_14 = level.player _id_79D9(var_8 * 0.75, var_12);
    var_15 = scripts\sp\utility::_id_BD6B(var_7, var_8);

    if(_id_EB21()) {
      thread scripts\sp\utility::_id_5B4D(level.player, self, 1, 0, 0, var_15 + 0.1);
      thread _id_D8EA("AUDIO ENT", "movedone");
    }

    var_16 = 80;
    self.origin = var_13 + (0, var_0, var_16);
    thread scripts\sp\utility::play_sound_on_entity(var_9);
    thread scripts\engine\utility::play_loop_sound_on_entity(level._id_6FFB);
    thread scripts\engine\utility::play_loop_sound_on_entity(level._id_6FFE);
    self moveTo(var_14 + (0, var_0, 0), var_15);
    self waittill("movedone");
    self notify("stop sound" + level._id_6FFB);
    self notify("stop sound" + level._id_6FFE);
    wait(randomintrange(var_5, var_6));
  }
}

_id_D8EA(var_0, var_1) {
  self endon(var_1);

  for(;;) {
    wait 0.05;
  }
}

_id_CDFE(var_0, var_1, var_2, var_3) {
  if(!_id_EB22()) {
    return;
  }
  var_4 = spawn("script_origin", var_1);

  foreach(var_6 in level._id_BFEF) {
    if(var_4 istouching(var_6)) {
      if(_id_EB21()) {}

      var_4 delete();
      return;
    }
  }

  var_4 delete();

  if(_id_EB21()) {
    var_8 = var_1;
    var_9 = var_8 + var_2 * 60;
    thread scripts\engine\utility::draw_arrow_time(var_8, var_9, (0, 0, 1), 2);
  }

  if(isDefined(var_3)) {
    playFX(var_0, var_1, var_2, var_3);
  } else {
    playFX(var_0, var_1, var_2);
  }
}

_id_578D() {
  var_0 = randomintrange(300, 500);
  var_1 = level.player _id_79D9(var_0, level.player.angles);
  var_2 = bulletTrace(var_1 + (0, 0, 500), var_1, 0, undefined, 0, 0, 0, 0, 0);

  if(_id_EB21()) {}

  thread _id_CDFE(scripts\engine\utility::getfx("ground_gust"), var_2["position"], var_2["normal"], undefined);
}

_id_772D(var_0) {
  var_1 = [];

  if(var_0 > 3) {
    var_2 = -500;
    var_3 = 500;
  } else {
    var_2 = -100;
    var_3 = 100;
  }

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = [];
    var_6 = randomintrange(100, 600);
    var_7 = randomintrange(250, 500);
    var_5[0] = level.player _id_79D9(var_6, level.player.angles);
    var_5[1] = level.player _id_7C16(var_5[0], var_7);
    var_5[2] = level.player _id_7C16(var_5[0], var_7, 1);
    var_1 = scripts\engine\utility::array_combine(var_1, var_5);
  }

  foreach(var_9 in var_1) {
    var_9 = var_9 + (0, 0, 60);
  }

  return var_1;
}

_id_EB21() {
  return getdvarint("sandstorm_debug") == 1;
}

_id_969D() {
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = getEntArray("trigger_radius", "classname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!var_4 _id_9B43() && isDefined(var_4._id_ED9A)) {
      if(isDefined(var_4.targetname) && var_4.targetname == "jackal_landingzone") {
        continue;
      }
      thread scripts\sp\trigger::_id_1273F(var_4);

      if(isDefined(var_4.targetname)) {
        continue;
      }
    }
  }
}

_id_9B43() {
  var_0 = strtok(self.classname, "_");

  if(isDefined(var_0[2])) {
    if(var_0[2] == "flag") {
      return 1;
    }
  }

  return 0;
}

_id_BE42(var_0, var_1, var_2, var_3) {
  level endon(var_0);
  var_4 = scripts\engine\utility::array_randomize(var_3);

  while(!scripts\engine\utility::flag(var_0)) {
    foreach(var_6 in var_4) {
      if(soundexists(var_6)) {
        _id_134B7(var_6);
      }

      wait(randomintrange(var_1, var_2));
    }

    wait 0.15;
  }
}

_id_192D() {
  for(;;) {
    self waittill("trigger", var_0);

    if(!isai(var_0) || isDefined(var_0._id_7269)) {
      continue;
    }
    var_0._id_7269 = 1;
    var_0 allowedstances("crouch");
    var_0 thread _id_192E(self);
  }
}

_id_192E(var_0) {
  self endon("death");

  while(self istouching(var_0)) {
    wait 0.05;
  }

  self allowedstances("stand", "crouch", "prone");
  self._id_7269 = undefined;
}

_id_8259() {
  self endon("death");
  self waittill("trigger");
  scripts\sp\utility::_id_EF15();

  if(isDefined(self._id_EDA0)) {
    scripts\engine\utility::flag_wait(self._id_EDA0);
  }

  var_0 = getspawnerarray(self.target);
  var_1 = 1;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.count)) {
      var_1 = var_3.count;
    }

    if(getdvarint("debug_geyser") == 1) {
      thread scripts\sp\utility::_id_5B4C(self.origin, var_3.origin, 0, 1, 0, 2);
    }

    thread _id_8258(var_3, var_1);
    wait 0.1;
  }
}

_id_8258(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = getEnt(var_0, "targetname");
  } else {
    var_2 = var_0;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1) && isDefined(var_2.count)) {
    var_1 = var_2.count;
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    if(getdvarint("debug_geyser") == 1) {}

    var_2 scripts\sp\utility::script_delay();

    if(getdvarint("debug_geyser") == 1) {}

    var_5 = var_2 _id_0B77::_id_12799();

    if(!scripts\sp\utility::_id_106ED(var_5)) {
      var_3[var_3.size] = var_5;
    }

    wait 0.05;
  }

  if(var_3.size < var_1) {}

  return var_3;
}

_id_D85C() {
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
}

_id_DF3E() {
  level.player unlink();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  level.player scripts\engine\utility::allow_offhand_weapons(1);
}

_id_DF3D(var_0) {
  var_1 = 2;

  for(;;) {
    var_2 = level.player.origin + (0, 0, var_1);
    var_3 = level.player.origin;

    if(level.player scripts\common\trace::player_trace_passed(var_2, var_3, undefined, [level.player, var_0])) {
      break;
    } else
      var_0.origin = var_0.origin + (0, 0, var_1);

    wait 0.05;
  }

  _id_DF3E();
}

_id_58CC() {
  return getdvarint("bink_intro") == 1;
}

_id_C154(var_0, var_1) {
  _id_13784(var_0);
  level notify(var_1);
}

_id_13784(var_0) {
  while(var_0.size != 0) {
    foreach(var_2 in var_0) {
      if(scripts\engine\utility::array_contains(var_0, var_2) && isai(var_2) && !var_2 _meth_81A6()) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }

    wait 0.05;
  }
}

_id_2434(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_2429._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_2429 scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Atom", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_2429._id_58D2 = undefined;
  }
}

_id_C48A(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_C47F._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_C47F scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Omar", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_C47F._id_58D2 = undefined;
  }
}

_id_C24D(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_C24B._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_C24B scripts\sp\utility::_id_10346(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Nunez", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_C24B._id_58D2 = undefined;
  }
}

_id_30FC(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_B33B._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_B33B scripts\sp\utility::_id_10346(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Brooks", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_B33B._id_58D2 = undefined;
  }
}

_id_A556(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_B33E._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_B33E scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Kashima", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_B33E._id_58D2 = undefined;
  }
}

_id_EAB8(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(level._id_EA2C)) {
    var_3 = level._id_EA2C;
  } else if(isDefined(level._id_EAD6)) {
    var_3 = level._id_EAD6;
  } else {
    var_3 = level.player;
  }

  if(isDefined(var_1)) {
    var_3._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    if(isDefined(var_3) && isai(var_3)) {
      var_3 scripts\sp\utility::_id_10346(var_0);
    } else if(isDefined(var_3) && var_3 scripts\sp\vehicle::_id_9FEF()) {
      var_3 scripts\sp\utility::_id_10347(var_0);
    } else {
      var_3 scripts\sp\utility::_id_10347(var_0);
    }

    wait 0.15;
  } else if(isDefined(var_2))
    wait(var_2);
  else {
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_3._id_58D2 = undefined;
  }
}

_id_DE1E(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level._id_DE1C._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_DE1C scripts\sp\utility::_id_10347(var_0);
  } else if(isDefined(var_2)) {
    wait(var_2);
  } else {
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_DE1C._id_58D2 = undefined;
  }
}

_id_6750(var_0) {
  if(soundexists(var_0)) {
    level.player scripts\sp\utility::play_sound_on_entity(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Eth3n", var_0);
    wait 2;
  }
}

_id_7707(var_0) {
  if(soundexists(var_0)) {
    level.player scripts\sp\utility::play_sound_on_entity(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Gator", var_0);
    wait 2;
  }
}

_id_A25A(var_0) {
  if(soundexists(var_0)) {
    level.player scripts\sp\utility::play_sound_on_entity(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Computer", var_0);
    wait 2;
  }
}

_id_2081(var_0) {
  if(soundexists(var_0)) {
    while(isDefined(level._id_2066)) {
      wait 0.15;
    }

    level._id_2066 = 1;
    level.player scripts\sp\utility::play_sound_on_entity(var_0);
    wait 0.15;
    level._id_2066 = undefined;
  } else {
    thread scripts\sp\utility::_id_16C5("APC Driver", var_0);
    wait 2;
  }
}

_id_D1D5(var_0, var_1) {
  if(isDefined(var_1)) {
    level.player._id_58D2 = 1;
  }

  if(soundexists(var_0)) {
    if(isDefined(level._id_D127)) {
      level._id_D127 scripts\sp\utility::_id_10347(var_0);
    } else {
      level.player scripts\sp\utility::_id_10347(var_0);
    }

    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Reese", var_0);
    wait 2;
  }

  if(isDefined(var_1)) {
    level.player._id_58D2 = undefined;
  }
}

_id_EB7F(var_0, var_1) {
  thread scripts\sp\anim::_id_1EBF("single dialogue");
  scripts\anim\face::sayspecificdialogue(var_0, "single dialogue");
  var_2 = spawnStruct();
  var_2 thread scripts\sp\anim::_id_1EB0(self, var_0);
  var_2 thread scripts\sp\anim::_id_1EB1(self, var_0);
  var_2 waittill(var_0);
  wait 0.15;
}

_id_9BC2() {
  return isDefined(self._id_58D2);
}

_id_48BD(var_0) {
  foreach(var_3, var_2 in var_0) {
    _id_134B7(var_2);
  }
}

_id_4601() {
  for(;;) {
    self waittill("trigger", var_0);

    if(distance(self.origin, level.player.origin) > 4000) {
      wait 1;
      continue;
    }

    if(isDefined(self.spawnflags)) {
      if(self.spawnflags == 2 && var_0 == level.player) {
        wait 1;
        continue;
      }
    }

    switch (self.script_noteworthy) {
      case "1_7":
        if(_id_9BF6()) {
          return;
        }
        wait 2;
        _id_134B7("titan_brk_lookslikehome");
        _id_134B7("titan_ksh_notmyhome");
        level._id_B33B thread _id_1958(level._id_C47F);
        _id_134B7("titan_brk_puthehurtonus");
        level._id_C47F thread _id_1958(level._id_B33B);
        wait 0.1;
        level._id_C47F thread _id_0C4C::_id_1964(0.5);
        level._id_B33B _id_0C4C::_id_1964(0.5);
        _id_134B7("titan_usf_downtowntitan");
        _id_134B7("titan_atm_wasnthalfbad");
        _id_134B7("titan_usf_tookaboatride");
        _id_134B7("titan_brk_seenbetterdays");
        _id_134B7("titan_atm_whydidyourdad");
        _id_134B7("titan_usf_makeabetterlife");
        _id_134B7("titan_atm_didhefight");
        _id_134B7("titan_plr_leavethesergeant");
        _id_134B7("titan_usf_idontmind");
        _id_134B7("titan_usf_32ndarmored");
        _id_134B7("titan_atm_victoryordeath");
        _id_134B7("titan_usf_survivedtwo");
        _id_134B7("titan_plr_appledidntfall");
        _id_134B7("titan_usf_fellfarenough");
        return;
      case "1_11":
        if(_id_9BF6()) {
          return;
        }
        return;
      case "18_28":
        _id_134B7("titan_slt_headright");
        return;
      default:
        return;
    }
  }
}

_id_134B7(var_0, var_1) {
  if(!soundexists(var_0)) {
    wait 1.5;
    return;
  }

  var_2 = strtok(var_0, "_");

  switch (var_2[1]) {
    case "usf":
      if(!isDefined(level._id_C47F)) {
        break;
      }

      _id_C48A(var_0, var_1);
      return;
    case "ksh":
      if(!isDefined(level._id_B33E)) {
        break;
      }

      _id_A556(var_0, var_1);
      return;
    case "atm":
    case "eth":
      if(!isDefined(level._id_2429)) {
        break;
      }

      _id_2434(var_0, var_1);
      return;
    case "plr":
      _id_D1D5(var_0, var_1);
      return;
    case "brks":
    case "brk":
      if(!isDefined(level._id_B33B)) {
        break;
      }

      _id_30FC(var_0, var_1);
      return;
    case "slt":
      if(!isDefined(level._id_EAD6)) {
        if(!isDefined(level._id_EA2C)) {
          break;
        }
      }

      _id_EAB8(var_0, var_1);
      return;
    default:
      level.player _id_D1D5(var_0, var_1);
      return;
  }

  level.player _id_D1D5(var_0, var_1);
}

_id_D250(var_0) {
  level.player notify("stop_player_rain");
  level.player endon("stop_player_rain");

  if(!level.player scripts\sp\utility::_id_65DF("player_rain")) {
    level.player scripts\sp\utility::_id_65E0("player_rain");
  }

  level.player scripts\sp\utility::_id_65E1("player_rain");
  level.player._id_DC2E = undefined;
  var_1 = undefined;

  if(var_0 == 1) {
    level.player._id_DC2E = "vfx_rain_player_attached_light";
    setglobalsoundcontext("rain", "light", 7.0);
    setaudiotriggerstate("default", "light", 3);
    setaudiotriggerstate("indoorrooms", "light", 3);
    var_1 = 0.75;
  }

  if(var_0 == 2) {
    level.player._id_DC2E = "vfx_rain_player_attached_medium";
    setglobalsoundcontext("rain", "medium", 3.0);
    setaudiotriggerstate("indoorrooms", "medium", 3);
    setaudiotriggerstate("default", "medium", 3);
    var_1 = 0.5;
  }

  if(var_0 == 3) {
    level.player._id_DC2E = "vfx_rain_player_attached_heavy";
    setglobalsoundcontext("rain", "heavy", 3.0);
    setaudiotriggerstate("indoorrooms", "heavy", 3);
    setaudiotriggerstate("default", "heavy", 3);
    var_1 = 0.45;
  }

  if(var_0 == 4) {
    level.player._id_DC2E = "vfx_rain_player_attached_torrential";
    setglobalsoundcontext("rain", "heavy", 3.0);
    setaudiotriggerstate("indoorrooms", "heavy", 3);
    setaudiotriggerstate("default", "heavy", 3);
    var_1 = 0.45;
  }

  for(;;) {
    playFX(scripts\engine\utility::getfx(level.player._id_DC2E), level.player.origin);
    wait 0.35;
  }
}

_id_D24F() {
  level.player notify("stop_player_rain");
  level.player scripts\sp\utility::_id_65DD("player_rain");
  setaudiotriggerstate("default", "nowind", 3);
  setglobalsoundcontext("rain", "", 3.0);
}

_id_134C4(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  if(isDefined(var_3)) {
    var_4 = var_3;
  } else {
    var_4 = squared(150);
  }

  while(distancesquared(self.origin, level.player.origin) > var_4) {
    wait 0.5;
  }

  if(isDefined(var_2)) {
    scripts\engine\utility::flag_set(var_2);
  }

  childthread _id_48BD(var_0);
}

_id_13782(var_0) {
  while(var_0.size) {
    foreach(var_2 in var_0) {
      var_2 endon("death");

      if(!isDefined(var_2.node) || distancesquared(var_2.origin, var_2.node.origin) < squared(50)) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }

    wait 0.05;
  }
}

_id_10169(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  return scripts\engine\utility::random(var_1);
}

_id_11619(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = 200;
  }

  var_4 = anglesToForward(var_1.angles);
  var_4 = var_4 * -1;
  var_5 = var_1.origin + var_4 * var_3;
  var_0 _meth_80F1(var_5, var_1.angles, 10000);
}

_id_137EA(var_0, var_1) {
  level endon("stop_monitoring_player_lookat");
  level thread scripts\sp\utility::_id_C12D("stop_monitoring_player_lookat", var_1);

  for(;;) {
    if(scripts\engine\utility::within_fov(_id_0BDC::_id_7BBA(), level.player.angles, var_0.origin, cos(40))) {
      if(sighttracepassed(level.player getEye(), var_0.origin, 1, level.player)) {
        return 1;
      }
    }

    wait 0.05;
  }
}

_id_137E7(var_0) {
  while(getaiarray("axis").size == 0) {
    wait 0.5;
  }

  for(;;) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(isDefined(var_0)) {
        if(var_3 _id_9BBD(var_0)) {
          if(scripts\sp\utility::_id_CFAC(var_3)) {
            level notify("player_sees_enemy");
            return;
          }
        }
      } else if(scripts\sp\utility::_id_CFAC(var_3)) {
        level notify("player_sees_enemy");
        return;
      }
    }

    wait 0.1;
  }
}

_id_137EB(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    level endon("player_sees_ai_timeout");
    level thread scripts\sp\utility::_id_C12D("player_sees_ai_timeout", var_3);
  }

  var_4 = var_1;
  var_5 = [];

  for(;;) {
    var_4 = scripts\engine\utility::array_removeundefined(var_4);

    foreach(var_7 in var_4) {
      if(isDefined(var_2)) {
        if(var_7 _id_9BBD(var_2)) {
          if(scripts\sp\utility::_id_CFAC(var_7)) {
            if(!scripts\engine\utility::array_contains(var_5, var_7)) {
              var_5[var_5.size] = var_7;
            }

            if(var_5.size >= var_0) {
              level notify("player_sees_enemy");
              return;
            }
          }
        }
      } else if(scripts\sp\utility::_id_CFAC(var_7)) {
        if(!scripts\engine\utility::array_contains(var_5, var_7)) {
          var_5[var_5.size] = var_7;
        }

        if(var_5.size >= var_0) {
          level notify("player_sees_enemy");
          return;
        }
      }
    }

    wait 0.05;
  }
}

_id_12D90(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "titanjackal":
      var_2 = 0;
      break;
    case "hotlanding":
      var_2 = 1;
      break;
  }

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  visionsetalternate(var_2, var_1);
  level._id_4BCF = "" + var_2 + " : " + var_0;
  wait(var_1);
}

#using_animtree("destructibles");

_id_13D2D() {
  if(!isDefined(level._id_13D2C)) {
    level._id_13D2C = getEntArray("wind_turbine", "targetname");
  }

  var_0 = 1;

  foreach(var_2 in level._id_13D2C) {
    var_2._id_1FBB = "wind_turbine";
    var_2 scripts\sp\utility::_id_23B7();
    var_2 _meth_82A2(%tag_rotate_z, 1, 0.02, var_0);
    var_2._id_1F09 = var_0;
    var_2 playLoopSound("emt_titan_turbine");
  }
}

_id_13D2E(var_0) {
  scripts\engine\utility::array_thread(level._id_13D2C, ::_id_13D2F, var_0);
}

_id_13D2F(var_0) {
  while(isDefined(self._id_9C35)) {
    wait 0.05;
  }

  self._id_65F6 = self getentitynumber();
  self._id_9C35 = 1;
  self notify("new_rate");
  var_1 = _id_77EF(var_0);
  self _meth_8460("turbine", var_1, 3);
  var_2 = randomfloatrange(0.75, 1.15);
  var_0 = var_0 * var_2;
  _id_13D2B(var_0);
  self._id_1F09 = var_0;
  self._id_9C35 = undefined;
}

_id_77EF(var_0) {
  var_1 = undefined;

  if(var_0 == 1) {
    var_1 = "slow";
  } else if(var_0 == 3) {
    var_1 = "medium";
  } else if(var_0 == 4) {
    var_1 = "fast";
  }

  return var_1;
}

_id_13D2B(var_0) {
  if(self._id_1F09 == var_0) {
    return;
  }
  wait(randomfloatrange(0.1, 0.6));
  var_1 = 60;
  var_2 = var_0 / var_1;
  var_3 = self._id_1F09;
  var_4 = var_3;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(var_3 > var_0) {
      var_4 = var_4 - var_2;
    } else if(var_3 < var_0) {
      var_4 = var_4 + var_2;
    } else if(var_3 == var_0) {
      break;
    }

    self _meth_82B1(%tag_rotate_z, var_4);
    var_3 = var_4;
    wait 0.05;
  }
}

_id_1381E(var_0, var_1) {
  level endon("vol_check_timeout");
  level thread scripts\sp\utility::_id_C12D("vol_check_timeout", var_1);

  for(;;) {
    level._id_EA60 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(isDefined(level._id_EA60)) {
      if(level._id_EA60.size > 0) {
        wait 0.25;
        continue;
      } else
        return 1;
    } else
      return 1;

    wait 0.5;
  }
}

_id_65EC(var_0, var_1, var_2) {
  if(distance2dsquared(var_0.origin, var_1.origin) <= var_2 * var_2) {
    return 1;
  }

  return 0;
}

_id_9BBD(var_0) {
  if(distance(self.origin, _id_0BDC::_id_7BBA()) <= var_0) {
    return 1;
  }

  return 0;
}

_id_9BBC(var_0) {
  if(distance2dsquared(self.origin, _id_0BDC::_id_7BBA()) <= var_0 * var_0) {
    return 1;
  }

  return 0;
}

_id_A5E5(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2) || !isDefined(var_2)) {
      continue;
    }
    if(scripts\engine\utility::cointoss()) {
      var_2 dodamage(var_2.health + 100, var_2.origin, level._id_EAD6, level._id_EAD6, "MOD_RIFLE_BULLET");
    } else {
      var_2 dodamage(var_2.health + 100, var_2.origin, level._id_EAD6, level._id_EAD6, "MOD_EXPLOSIVE");
    }

    wait(randomfloatrange(0.15, 0.5));
  }
}

_id_F40C(var_0, var_1, var_2) {
  scripts\sp\utility::_id_F40A(var_0, var_1, var_2);
}

_id_DEE4(var_0, var_1, var_2) {
  if(!isDefined(level._id_157F[var_0])) {
    level._id_157F[var_0] = [];
  }

  var_3 = spawnStruct();
  var_3._id_2AD1 = var_1;
  var_3._id_8FE1 = var_2;
  var_3._id_A5A1 = undefined;
  var_3._id_9028 = undefined;
  precachestring(var_2);
  level._id_157F[var_0][level._id_157F[var_0].size] = var_3;
}

_id_7D93(var_0) {
  for(var_1 = 0; var_1 < level._id_157F[var_0].size; var_1++) {
    var_2 = level._id_157F[var_0][var_1];
    var_3 = getkeybinding(var_2._id_2AD1);

    if(!var_3["count"]) {
      continue;
    }
    return level._id_157F[var_0][var_1];
  }

  return level._id_157F[var_0][0];
}

_id_9BF6() {
  if(getdvarint("greenlight") == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_535E() {
  var_0 = getEntArray("destructible_panel", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_535F);
}

_id_535F() {
  self setCanDamage(1);
  self._id_C897 = 300;
  var_0 = 0.8;

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(isDefined(var_2) && (isDefined(var_2.team) && var_2.team == "axis")) {
      var_1 = var_1 * var_0;
    }

    var_3 = self._id_C897 - var_1;

    if(var_3 <= 0) {
      break;
    }

    self._id_C897 = var_3;
  }

  playFX(scripts\engine\utility::getfx("panel_break"), self.origin, anglesToForward(self.angles) * -1, anglestoup(self.angles));
  self delete();
}

_id_4EF9() {}