/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\door.gsc
***********************************************/

door_dynamic_setup(var_0) {
  if(isDefined(level.doors)) {
    return;
  }
  setDvar("_encstr_93D40B313707EF7C697184C4BC", 150.0);
  level.doors = [];
  level.doorsetupstarted = 0;
  thread door_dynamic_setup_adapter("_encstr_964E0D322F73B0B6961BBE19BDDB27", 0);
  thread door_dynamic_setup_adapter("_encstr_95AF121B56C237AF46CBCDB0AD968D7D467B7B93", 1, var_0);
  script_model_anims();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

door_dynamic_setup_adapter(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.doorsetupstarted++;
  level.doorsetupfinished = 0;
  var_4 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"];
  var_5 = physics_createcontents(var_4);
  level.doorcontentoverride = var_5;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.script_parameters))
      var_7 door_dynamic_parse_parameters(var_7.script_parameters);

    var_7.doors = [];
    var_7.doors[0] = var_7;
    var_7.islean = var_1;
    var_7.baseangles = var_7.angles;

    if(var_7.baseangles[1] == 360)
      var_7.baseangles = (var_7.baseangles[0], 0, var_7.baseangles[2]);

    var_7.state = 0;
    var_8 = var_7.target;
    var_9 = isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "_encstr_ADB405479B88F8" || getdvarint("_encstr_A2C00F620E2531AC20A8132F1118705AC5", 0) != 0;
    var_10 = isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "_encstr_96DF07D9F0A06F1838";
    var_7.length = 52;
    var_7.height = 96;
    var_7.leftplantorg = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoright(var_7.angles) * -24.5;
    var_7.leftplantang = (0, var_7.baseangles[1] - 90.0, 0);
    var_7.rightplantorg = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoright(var_7.angles) * 24.5;
    var_7.rightplantang = (0, var_7.baseangles[1] + 90.0, 0);
    var_7.doorcenter = var_7.origin + anglesToForward(var_7.angles) * var_7.length * 0.5 + anglestoup(var_7.angles) * var_7.height * 0.5;
    var_7.max_yaw_left = 90;
    var_7.max_yaw_right = 90;
    var_11 = var_7 gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365", 1);

    if(isDefined(var_11)) {
      var_7 scripts\mp\gameobjects::sethintobject("_encstr_96F310ADF90776697D5A2041429605694365", "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_AB231877E1A878774967F14B7F215FF4CF53F3C72130D13239ED", undefined, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 200, 90, 72, 90);
      var_7.useprompt = var_7;
      var_7.useprompt setusewhenhandsoccupied(1);

      if(!var_1 && scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
        var_7.lockprompt = scripts\mp\gameobjects::createhintobject(var_11, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_BE12116A82E588A77A25BE554D8AD789E91A2D", undefined, undefined, "_encstr_BD1805CB69C063", 200, 90, 72, 90);
        var_7.lockprompt linkTo(var_7, "_encstr_96F310ADF90776697D5A2041429605694365", (3, 0, 15), (0, 0, 0));
        var_7.lockprompt setusewhenhandsoccupied(1);
        var_7.alarmprompts = [];
        var_12 = [(4, 0, 4), (4, 0, 90)];

        foreach(var_14 in var_12) {
          var_15 = scripts\mp\gameobjects::createhintobject(var_11, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_A395120F532F581FB8D5E7270F7529D06C29A57B", undefined, undefined, "_encstr_BD1805CB69C063", 100, 90, 80, 20);
          var_15 linkTo(var_7, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_14, (0, 0, 0));
          var_15 setusewhenhandsoccupied(0);
          var_16 = var_15 getentitynumber();
          var_7.alarmprompts[var_16] = var_15;
        }

        var_18 = getEnt(var_8, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(isDefined(var_18)) {
          var_7.clipent = var_18;
          var_7.clipent linkTo(var_7);
          var_7.clipent.unresolved_collision_func = scripts\mp\movers::unresolved_collision_void;
          var_7.clipent connectpaths();

          if(isDefined(var_18.target)) {
            var_19 = getEnt(var_18.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
            var_7.audioportalent = var_19;
          }
        }
      }

      if(var_9) {
        var_7 thread changestate(2);
        var_7.angles = (var_7.angles[0], var_7.angles[1] + 90.0, var_7.angles[2]);
      } else if(var_10)
        var_7 thread changestate(7);
      else
        var_7 thread changestate(0);
    }

    level.doors[level.doors.size] = var_7;
    waitframe();
  }

  if(!var_1) {
    level thread amortizeyawtraces();

    foreach(var_7 in level.doors)
    var_7 thread get_max_yaws();

    level thread linkdoubledoors();
  }

  level.doorsetupstarted--;
  level.doorsetupfinished = level.doorsetupstarted == 0;
}

door_dynamic_setup_post_init() {
  waitframe();

  if(getdvarint("_encstr_A2C00F620E2531AC20A8132F1118705AC5", 0) != 0) {
    foreach(var_1 in level.doors) {
      var_1.statecurr = 2;
      var_1.angles = var_1.doortarget.angles;
    }
  }
}

triggerlisten(var_0) {
  self notify("_encstr_BA510F9F336F9AF218B0F363F851AF8205");
  self endon("_encstr_BA510F9F336F9AF218B0F363F851AF8205");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!var_0.islean && var_0.statecurr == 0)
    var_0 thread bashmonitor();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
    self makeunusable();
    var_2 = var_0.doortarget;

    if(isDefined(var_0.doortargetccw)) {
      var_3 = anglesToForward(var_0.angles);
      var_4 = vectorcross((0, 0, 1), var_3);
      var_5 = anglesToForward((0, var_1.angles[1], 0));

      if(vectordot(var_5, var_4) < 0)
        var_2 = var_0.doortargetccw;
    }

    var_6 = 0.666;

    if(var_0.statecurr == 0) {
      self notify("_encstr_920F1262851FC39781D8174311586FEACB1DEDDA");
      var_0.statecurr = 3;
      var_0 rotateTo(var_2.angles, var_6, 0.0, 0.333);
      var_7 = &"_encstr_87AF12D9B17D3154FF9A607DB3FF1E871DE8B111";
    } else {
      var_0.statecurr = 1;
      var_0 rotateTo(var_0.baseangles, var_6, 0.0, 0.333);
      var_7 = &"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5";
    }

    var_0 scripts\mp\events::doorused(var_1, var_0.statecurr == 3);
    wait 0.1;
    var_0 childthread door_state_update_sound();
    wait(var_6);

    if(var_0.statecurr == 1) {
      var_0.statecurr = 0;

      if(!var_0.islean)
        var_0 thread bashmonitor();
    } else
      var_0.statecurr = 2;

    self makeusable();
    self setHintString(var_7);
  }
}

door_dynamic_parse_parameters(var_0) {
  var_1 = self;
  var_1.button_sound = undefined;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_2 = strtok(var_0, "_encstr_A54C02F2");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "_encstr_AB4C0246");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "_encstr_8C500ABA9B23CACC2D37AC8C" || var_5[1] == "_encstr_8B1608EC43B8D647A113") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "_encstr_A3780B0F2908BBE72840FB0519":
        var_1.stop_sound = var_5[1];
        break;
      case "_encstr_A13510C3A8EBC5DBA363EB3896263DC3A825":
        var_1.interrupt_sound = var_5[1];
        break;
      case "_encstr_A9850BA0321D29261FB765D094":
        var_1.loop_sound = var_5[1];
        break;
      case "_encstr_A3730FF6072B73F52D37E82B9C27ABC1E8":
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "_encstr_A63C0C532321D07DB99F878BD332":
        var_1.start_sound = var_5[1];
        break;
      case "_encstr_936809B6B0A3B2395A58B1":
        var_1.material = var_5[1];
        break;
    }
  }
}

door_system_init(var_0) {
  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters))
      var_3 button_parse_parameters(var_3.script_parameters);

    var_3 door_setup();
  }

  foreach(var_3 in var_1)
  var_3 thread door_think();
}

door_setup() {
  var_0 = self;
  var_0.doors = [];
  var_0.hasbeenused = 0;

  if(isDefined(var_0.script_index))
    var_0.doormovetime = max(0.1, float(var_0.script_index) / 1000);

  var_1 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "_encstr_8F5C086405E70FBA4B4A")) {
      if(!isDefined(var_0.trigblock))
        var_0.trigblock = [];

      if(isDefined(var_3.script_parameters))
        var_3 trigger_parse_parameters(var_3.script_parameters);

      if(isDefined(var_3.script_linkto)) {
        var_4 = getEnt(var_3.script_linkto, "_encstr_A29D10371B275A1C47F536969BDAB90BB5B2");
        var_3 enablelinkTo();
        var_3 linkTo(var_4);
      }

      var_0.trigblock[var_0.trigblock.size] = var_3;
      continue;
    }

    if(var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C" || var_3.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
      if(isDefined(var_3.script_noteworthy) && issubstr(var_3.script_noteworthy, "_encstr_8FA906CC80677438")) {
        if(issubstr(var_3.script_noteworthy, "_encstr_B135094273DAF12B2F9808")) {
          if(!isDefined(var_0.lights_on))
            var_0.lights_on = [];

          var_3 hide();
          var_0.lights_on[var_0.lights_on.size] = var_3;
        } else if(issubstr(var_3.script_noteworthy, "_encstr_8CF90A08FAB7A1FB07EFB4BC")) {
          if(!isDefined(var_0.lights_off))
            var_0.lights_off = [];

          var_3 hide();
          var_0.lights_off[var_0.lights_off.size] = var_3;
        } else {}
      } else if(var_3.spawnflags & 2) {
        if(!isDefined(var_0.ai_sight_brushes))
          var_0.ai_sight_brushes = [];

        var_3 notsolid();
        var_3 hide();
        var_0.ai_sight_brushes[var_0.ai_sight_brushes.size] = var_3;
      } else
        var_0.doors[var_0.doors.size] = var_3;

      continue;
    }

    if(var_3.classname == "_encstr_AD050EE61B93A50E8ED7DB39D29D96B9")
      var_0.entsound = var_3;
  }

  if(!isDefined(var_0.entsound) && var_0.doors.size)
    var_0.entsound = sortbydistance(var_0.doors, var_0.origin)[0];

  foreach(var_7 in var_0.doors) {
    var_7.posclosed = var_7.origin;
    var_7.posopen = scripts\engine\utility::getStruct(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF").origin;
    var_7.distmove = distance(var_7.posopen, var_7.posclosed);
    var_7.no_moving_unresolved_collisions = 0;

    if(!istrue(var_0.start_closed))
      var_7.origin = var_7.posopen;

    if(isDefined(var_7.script_parameters))
      var_7 door_parse_parameters(var_7.script_parameters);
  }
}

door_think() {
  var_0 = self;
  var_1 = scripts\engine\utility::ter_op(istrue(var_0.start_closed), 0, 2);
  var_0 door_state_change(var_1, 1);

  for(;;) {
    var_0.statedone = undefined;
    var_0.stateinterrupted = undefined;
    var_0 scripts\engine\utility::_id_143A5("_encstr_8D201052F8A0D3C9B8C1514C8BB14FDF58D1", "_encstr_86A717E2481063792851A1BC1B21BC4BC5A13B0B9377B32FA8");

    if(isDefined(var_0.statedone) && var_0.statedone) {
      var_2 = var_0 door_state_next(var_0.statecurr);
      var_0 door_state_change(var_2, 0);
      continue;
    }

    if(isDefined(var_0.stateinterrupted) && var_0.stateinterrupted) {
      var_0 door_state_change(4, 0);
      continue;
    }
  }
}

door_state_next(var_0) {
  var_1 = self;
  var_2 = undefined;

  if(var_0 == 0)
    var_2 = 3;
  else if(var_0 == 2)
    var_2 = 1;
  else if(var_0 == 1)
    var_2 = 0;
  else if(var_0 == 3)
    var_2 = 2;
  else if(var_0 == 4)
    var_2 = var_1.stateprev;
  else {}

  return var_2;
}

door_state_update(var_0) {
  var_1 = self;
  var_1 endon("_encstr_86A717E2481063792851A1BC1B21BC4BC5A13B0B9377B32FA8");
  var_1.statedone = undefined;

  if(var_1.statecurr == 0 || var_1.statecurr == 2) {
    if(!var_0) {
      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.stop_sound)) {
          var_3 stoploopsound();
          var_3 playsoundonmovingent(var_3.stop_sound);
        }
      }
    }

    if(isDefined(var_1.lights_on)) {
      foreach(var_6 in var_1.lights_on)
      var_6 show();
    }

    foreach(var_3 in var_1.doors) {
      if(var_1.statecurr == 0) {
        if(isDefined(var_1.ai_sight_brushes)) {
          foreach(var_10 in var_1.ai_sight_brushes)
          var_10 show();
        }

        if(var_3.spawnflags & 1) {}
      } else {
        if(isDefined(var_1.ai_sight_brushes)) {
          foreach(var_10 in var_1.ai_sight_brushes)
          var_10 hide();
        }

        if(var_3.spawnflags & 1) {
          if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "_encstr_B6D812581B7716E56ED7464BDCC6BD73CD56C6D1") {} else {}
        }
      }

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "_encstr_8BF3104210AFB6C78BEB2B35E8D3937FD368" || var_3.script_noteworthy == "_encstr_82CF17E802AB2573977ABE214FA758AF146B4081FB847B696B")
          var_3 rotatevelocity((0, 0, 0), 0.1);
      }

      if(var_3.no_moving_unresolved_collisions)
        var_3.unresolved_collision_func = undefined;
    }

    var_15 = !istrue(var_1.one_time_use) || !var_1.hasbeenused;

    if(var_15) {
      var_16 = scripts\engine\utility::ter_op(var_1.statecurr == 0, &"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5", &"_encstr_87AF12D9B17D3154FF9A607DB3FF1E871DE8B111");

      if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
        var_1 setHintString(var_16);

      var_1 makeusable();
      var_1 waittill("_encstr_8F5C086405E70FBA4B4A");

      if(isDefined(var_1.button_sound))
        var_1 playSound(var_1.button_sound);

      var_1.hasbeenused = 1;
    } else
      var_1 waittill("_encstr_ABA008615A631510C7EA");
  } else if(var_1.statecurr == 1 || var_1.statecurr == 3) {
    if(isDefined(var_1.lights_off)) {
      foreach(var_6 in var_1.lights_off)
      var_6 show();
    }

    var_1 makeunusable();

    if(var_1.statecurr == 1) {
      var_1 thread door_state_on_interrupt();

      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_20 = scripts\engine\utility::ter_op(isDefined(var_1.doormovetime), var_1.doormovetime, 3.0);
          var_21 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.posclosed, var_3.posopen);
          var_22 = distance(var_3.origin, var_21);
          var_23 = max(0.1, var_22 / var_3.distmove * var_20);
          var_24 = max(var_23 * 0.25, 0.05);
          var_25 = 360 * var_22 / 94.2;

          if(var_3.script_noteworthy == "_encstr_8BF3104210AFB6C78BEB2B35E8D3937FD368")
            var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
          else if(var_3.script_noteworthy == "_encstr_82CF17E802AB2573977ABE214FA758AF146B4081FB847B696B")
            var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
        }
      }
    } else if(var_1.statecurr == 3) {
      if(isDefined(var_1.open_interrupt) && var_1.open_interrupt)
        var_1 thread door_state_on_interrupt();

      foreach(var_3 in var_1.doors) {
        if(isDefined(var_3.script_noteworthy)) {
          var_20 = scripts\engine\utility::ter_op(isDefined(var_1.doormovetime), var_1.doormovetime, 3.0);
          var_21 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.posclosed, var_3.posopen);
          var_22 = distance(var_3.origin, var_21);
          var_23 = max(0.1, var_22 / var_3.distmove * var_20);
          var_24 = max(var_23 * 0.25, 0.05);
          var_25 = 360 * var_22 / 94.2;

          if(var_3.script_noteworthy == "_encstr_8BF3104210AFB6C78BEB2B35E8D3937FD368")
            var_3 rotatevelocity((0, 0, var_25 / var_23), var_23, var_24, var_24);
          else if(var_3.script_noteworthy == "_encstr_82CF17E802AB2573977ABE214FA758AF146B4081FB847B696B")
            var_3 rotatevelocity((0, 0, -1 * var_25 / var_23), var_23, var_24, var_24);
        }
      }
    }

    wait 0.1;
    var_1 childthread door_state_update_sound();
    var_20 = scripts\engine\utility::ter_op(isDefined(var_1.doormovetime), var_1.doormovetime, 3.0);
    var_29 = undefined;

    foreach(var_3 in var_1.doors) {
      var_21 = scripts\engine\utility::ter_op(var_1.statecurr == 1, var_3.posclosed, var_3.posopen);

      if(var_3.origin != var_21) {
        var_23 = max(0.1, distance(var_3.origin, var_21) / var_3.distmove * var_20);
        var_24 = max(var_23 * 0.25, 0.05);
        var_3 moveTo(var_21, var_23, var_24, var_24);
        var_3 scripts\mp\movers::notify_moving_platform_invalid();

        if(var_3.no_moving_unresolved_collisions)
          var_3.unresolved_collision_func = scripts\mp\movers::unresolved_collision_void;

        if(!isDefined(var_29) || var_23 > var_29)
          var_29 = var_23;
      }
    }

    if(isDefined(var_29))
      wait(var_29);
  } else if(var_1.statecurr == 4) {
    foreach(var_3 in var_1.doors) {
      var_3 moveTo(var_3.origin, 0.05, 0.0, 0.0);
      var_3 scripts\mp\movers::notify_moving_platform_invalid();

      if(var_3.no_moving_unresolved_collisions)
        var_3.unresolved_collision_func = undefined;

      if(isDefined(var_3.script_noteworthy)) {
        if(var_3.script_noteworthy == "_encstr_8BF3104210AFB6C78BEB2B35E8D3937FD368" || var_3.script_noteworthy == "_encstr_82CF17E802AB2573977ABE214FA758AF146B4081FB847B696B")
          var_3 rotatevelocity((0, 0, 0), 0.05);
      }
    }

    if(isDefined(var_1.lights_off)) {
      foreach(var_6 in var_1.lights_off)
      var_6 show();
    }

    var_1.entsound stoploopsound();

    foreach(var_3 in var_1.doors) {
      if(isDefined(var_3.interrupt_sound))
        var_3 playSound(var_3.interrupt_sound);
    }

    wait 1.0;
  } else {}

  var_1.statedone = 1;

  foreach(var_3 in var_1.doors)
  var_3.statedone = 1;

  var_1 notify("_encstr_8D201052F8A0D3C9B8C1514C8BB14FDF58D1");
}

door_state_update_sound() {
  var_0 = self;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0;

  if(var_0.statecurr == 3 || var_0.statecurr == 1) {
    foreach(var_5 in var_0.doors) {
      if(isDefined(var_5.start_sound)) {
        var_5 playsoundonmovingent(var_5.start_sound);
        var_3 = lookupsoundlength(var_5.start_sound) / 1000;
        var_1 = 0;
      }
    }

    if(var_1) {
      if(!isDefined(var_0.entsound))
        var_0.entsound = var_0;

      if(var_0.statecurr == 3) {
        if(soundexists("_encstr_BA651CEB26DB539337A08A82F8DF8BF7D01D7F74484353DD7B61726B78E5")) {
          var_3 = lookupsoundlength("_encstr_BA651CEB26DB539337A08A82F8DF8BF7D01D7F74484353DD7B61726B78E5") / 1000;
          playsoundatpos(var_0.entsound.origin, "_encstr_BA651CEB26DB539337A08A82F8DF8BF7D01D7F74484353DD7B61726B78E5");
        }
      } else if(var_0.statecurr == 1) {
        if(soundexists("_encstr_820E1D2BEE78316B7FC7D8D73BB973E23F52B18C485FC14CC5880244DAFA71")) {
          var_3 = lookupsoundlength("_encstr_820E1D2BEE78316B7FC7D8D73BB973E23F52B18C485FC14CC5880244DAFA71") / 1000;
          playsoundatpos(var_0.entsound.origin, "_encstr_820E1D2BEE78316B7FC7D8D73BB973E23F52B18C485FC14CC5880244DAFA71");
        }
      }
    }
  }

  wait(var_3 * 0.3);

  if(var_0.statecurr == 3 || var_0.statecurr == 1) {
    foreach(var_5 in var_0.doors) {
      if(isDefined(var_5.loop_sound)) {
        if(var_5.loop_sound != "_encstr_8BBA05185F8B99")
          var_5 playLoopSound(var_5.loop_sound);

        var_2 = 0;
      }
    }

    if(var_2) {
      if(soundexists("_encstr_B40101"))
        var_0.entsound playLoopSound("_encstr_B40101");
    }
  }
}

door_state_change(var_0, var_1) {
  var_2 = self;

  if(isDefined(var_2.statecurr)) {
    door_state_exit(var_2.statecurr);
    var_2.stateprev = var_2.statecurr;
  }

  var_2.statecurr = var_0;
  var_2 thread door_state_update(var_1);
}

door_state_exit(var_0) {
  var_1 = self;

  if(var_0 == 0 || var_0 == 2) {
    if(isDefined(var_1.lights_on)) {
      foreach(var_3 in var_1.lights_on)
      var_3 hide();
    }
  } else if(var_0 == 1 || var_0 == 3) {
    if(isDefined(var_1.lights_off)) {
      foreach(var_3 in var_1.lights_off)
      var_3 hide();
    }

    var_1.entsound stoploopsound();

    foreach(var_8 in var_1.doors) {
      if(isDefined(var_8.loop_sound))
        var_8 stoploopsound();
    }
  } else {
    if(var_0 == 4) {
      return;
    }
    return;
  }
}

door_state_on_interrupt() {
  var_0 = self;
  var_0 endon("_encstr_8D201052F8A0D3C9B8C1514C8BB14FDF58D1");

  if(!isDefined(var_0.trigblock)) {
    return;
  }
  var_1 = [];

  foreach(var_3 in var_0.trigblock) {
    if(var_0.statecurr == 1) {
      if(isDefined(var_3.not_closing) && var_3.not_closing == 1)
        continue;
    } else if(var_0.statecurr == 3) {
      if(isDefined(var_3.not_opening) && var_3.not_opening == 1)
        continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0) {
    var_5 = var_0 waittill_any_triggered_return_triggerer(var_1);

    if(!isDefined(var_5.fauxdead) || var_5.fauxdead == 0) {
      var_0.stateinterrupted = 1;
      var_0 notify("_encstr_86A717E2481063792851A1BC1B21BC4BC5A13B0B9377B32FA8");
    }
  }
}

waittill_any_triggered_return_triggerer(var_0) {
  var_1 = self;

  foreach(var_3 in var_0)
  var_1 thread return_triggerer(var_3);

  var_1 waittill("_encstr_8DFD0C4F986395D31D451A13A5E9");
  return var_1.interrupter;
}

return_triggerer(var_0) {
  var_1 = self;
  var_1 endon("_encstr_8D201052F8A0D3C9B8C1514C8BB14FDF58D1");
  var_1 endon("_encstr_8DFD0C4F986395D31D451A13A5E9");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_0.prone_only) && var_0.prone_only == 1) {
      if(isPlayer(var_2)) {
        var_3 = var_2 getstance();

        if(var_3 != "_encstr_922406F1A6FD5E05")
          continue;
        else {
          var_4 = vectorNormalize(anglesToForward(var_2.angles));
          var_5 = vectorNormalize(var_0.origin - var_2.origin);
          var_6 = vectordot(var_4, var_5);

          if(var_6 > 0)
            continue;
        }
      }
    }

    break;
  }

  var_1.interrupter = var_2;
  var_1 notify("_encstr_8DFD0C4F986395D31D451A13A5E9");
}

button_parse_parameters(var_0) {
  var_1 = self;
  var_1.button_sound = undefined;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_2 = strtok(var_0, "_encstr_A54C02F2");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "_encstr_AB4C0246");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "_encstr_8C500ABA9B23CACC2D37AC8C" || var_5[1] == "_encstr_8B1608EC43B8D647A113") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "_encstr_A3730FF6072B73F52D37E82B9C27ABC1E8":
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "_encstr_8BF20D52D89973D7A8F02B3FFDF0A3":
        var_1.button_sound = var_5[1];
        break;
      case "_encstr_B8910DCD8E58E41DF5C6C6B73756C8":
        var_1.start_closed = string_to_bool(var_5[1]);
        break;
      case "_encstr_8B6D0D40C035879149DA08F9C3E3CB":
        var_1.one_time_use = string_to_bool(var_5[1]);
        break;
      default:
        break;
    }
  }
}

door_parse_parameters(var_0) {
  var_1 = self;
  var_1.start_sound = undefined;
  var_1.stop_sound = undefined;
  var_1.loop_sound = undefined;
  var_1.interrupt_sound = undefined;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_2 = strtok(var_0, "_encstr_A54C02F2");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "_encstr_AB4C0246");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "_encstr_8C500ABA9B23CACC2D37AC8C" || var_5[1] == "_encstr_8B1608EC43B8D647A113") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "_encstr_A3780B0F2908BBE72840FB0519":
        var_1.stop_sound = var_5[1];
        break;
      case "_encstr_A13510C3A8EBC5DBA363EB3896263DC3A825":
        var_1.interrupt_sound = var_5[1];
        break;
      case "_encstr_A9850BA0321D29261FB765D094":
        var_1.loop_sound = var_5[1];
        break;
      case "_encstr_A3730FF6072B73F52D37E82B9C27ABC1E8":
        var_1.open_interrupt = string_to_bool(var_5[1]);
        break;
      case "_encstr_A63C0C532321D07DB99F878BD332":
        var_1.start_sound = var_5[1];
        break;
      case "_encstr_95A81B5D9BC9CA6E7BC6EC958CFA6CB76363A5B95AF6E6FAB9BD912BB9":
        var_1.unresolved_collision_nodes = getnodearray(var_5[1], "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        break;
      case "_encstr_86E5201BD84EC55A5D03251F603302825190A79B88E104814F28ADD553E78A5798E8":
        var_1.no_moving_unresolved_collisions = string_to_bool(var_5[1]);
        break;
      case "_encstr_936809B6B0A3B2395A58B1":
        var_1.material = var_5[1];
        break;
      default:
        break;
    }
  }
}

trigger_parse_parameters(var_0) {
  var_1 = self;

  if(!isDefined(var_0))
    var_0 = "_encstr_B40101";

  var_2 = strtok(var_0, "_encstr_A54C02F2");

  foreach(var_4 in var_2) {
    var_5 = strtok(var_4, "_encstr_AB4C0246");

    if(var_5.size != 2) {
      continue;
    }
    if(var_5[1] == "_encstr_8C500ABA9B23CACC2D37AC8C" || var_5[1] == "_encstr_8B1608EC43B8D647A113") {
      var_1.params[var_5[0]] = undefined;
      continue;
    }

    switch (var_5[0]) {
      case "_encstr_8E790CCDDB1DBEDE389537A5CD3B":
        var_1.not_opening = string_to_bool(var_5[1]);
        break;
      case "_encstr_BDF10C9A9045FF5EE84FEBC97588":
        var_1.not_closing = string_to_bool(var_5[1]);
        break;
      case "_encstr_85E50B634BD7504889378D9139":
        var_1.prone_only = string_to_bool(var_5[1]);
        break;
      default:
        break;
    }
  }
}

string_to_bool(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_AAEF05B83B43EB":
    case "_encstr_A34C02BB":
      var_1 = 1;
      break;
    case "_encstr_B6C106D7FF89633D":
    case "_encstr_934C0218":
      var_1 = 0;
      break;
    default:
      break;
  }

  return var_1;
}

bashmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_BADC0C404BCB50051FC0C2C3588B");
  self endon("_encstr_BADC0C404BCB50051FC0C2C3588B");
  thread monitordamage();

  for(;;) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(bashproxcheck(var_2) && shouldbashopen(var_2))
          thread bashopen(var_2, var_2.origin);
      }

      waitframe();
      continue;
    }

    wait 0.1;
  }
}

bashproxcheck(var_0) {
  var_1 = distancesquared(var_0.origin, self.doorcenter);
  var_2 = 4900;
  return var_1 < var_2;
}

shouldbashopen(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(var_0))
    return 0;

  var_1 = anglesToForward(var_0.angles);

  if(scripts\engine\utility::within_fov(var_0.origin + var_1 * -45.0, var_0.angles, self.doorcenter, cos(43))) {
    var_2 = anglestoright(self.angles);
    var_3 = vectorNormalize(self.doorcenter - var_0 getEye());
    var_4 = vectordot(var_1, var_3);
    var_5 = vectordot(var_1, var_2);
    var_6 = var_0 getvelocity();
    var_7 = vectordot(vectorNormalize(var_6), (0, 0, 1));

    if((length(var_6) >= 200 || var_0 scripts\mp\utility\killstreak::isjuggernaut() && length(var_6) >= 140) && abs(var_7) < 0.75 && abs(var_5) > 0.75 && var_4 > 0.75) {
      var_8 = self gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365", 1);

      if(isDefined(var_8)) {
        var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_8, var_0, level.doorcontentoverride, 0);

        if(isDefined(var_9["_encstr_850E077B0BF30318B9"]) && var_9["_encstr_850E077B0BF30318B9"] == self)
          return 1;
      } else
        return 1;
    }
  }

  return 0;
}

bashopen(var_0, var_1) {
  thread checktriggeralarm(var_0);
  thread changestate(5);

  if(istrue(self.bashed)) {
    return;
  }
  if(!isDefined(self.useprompt))
    self.bashed = 1;

  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglestoright(var_3);
  var_5 = vectorNormalize(var_1 - self.origin);
  var_6 = vectordot(var_4, var_5);
  var_7 = var_6 > 0;
  var_8 = undefined;

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isai(var_0))
      thread bashpresentation(var_0);
    else
      self notify("_encstr_BEE70AB778DE573B8B70174F");
  }

  if(isDefined(self.material)) {
    if(self.material == "_encstr_9BC806E72F38AFE8")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_8CC823BBA60DBB4340FF77AFAB17900D0734384FAFD1B3202CDE1BC35D0FF0D77972AE03E0");
    else if(self.material == "_encstr_ABF605EEBD7B32")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_82561ACD1BC9C1A3D7917BB793EB777B7B23FA26B0E4B9EB260B6E1A");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "_encstr_A74D1C63D7800ACBB0A9DAC273E88F8510B1D7FC7710565345E6022A3B5B");

  if(var_7)
    var_8 = self.baseangles[1] + self.max_yaw_left;
  else
    var_8 = self.baseangles[1] - self.max_yaw_right;

  if(var_8 > 360)
    var_8 = var_8 - 360;
  else if(var_8 < 0)
    var_8 = var_8 + 360;

  var_9 = 0.35;
  var_10 = 0.15;
  var_11 = scripts\engine\math::normalize_value(0, 170, var_8);
  var_12 = scripts\engine\math::factor_value(var_9, var_10, var_11);
  var_13 = self.angles;
  var_14 = var_13[1];

  if(var_14 > 360)
    var_14 = var_14 - 360;
  else if(var_14 < 0)
    var_14 = var_14 + 360;

  var_15 = angle_diff(var_14, self.baseangles[1]);
  var_16 = angle_diff(var_8, self.baseangles[1]);
  var_17 = anglesToForward(var_13);
  var_18 = anglestoright(self.baseangles);
  var_19 = vectordot(var_17, var_18) < 0.0;

  if(var_7) {
    if(!var_19)
      var_16 = var_16 + var_15;
    else
      var_16 = var_16 - var_15;
  } else {
    if(var_19)
      var_16 = var_16 + var_15;
    else
      var_16 = var_16 - var_15;

    var_16 = var_16 * -1.0;
  }

  var_20 = (0, var_16, 0);
  self rotateby(var_20, var_12);
  wait(var_12);
  self.lastpushtime = gettime();
  thread changestate(6);

  if(!isDefined(self.useprompt)) {
    self.statecurr = 2;

    if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
      self.trigger setHintString(&"_encstr_87AF12D9B17D3154FF9A607DB3FF1E871DE8B111");
  }

  self.bashed = 0;
  var_21 = randomfloatrange(3, 5);
  var_22 = randomfloatrange(0.25, 2.5);

  if(var_7)
    var_22 = var_22 * -1.0;

  self rotateYaw(var_22, var_21, 0.5, var_21 - 0.5);
}

bashpresentation(var_0) {
  var_0 playRumbleOnEntity("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9");
  var_0 earthquakeforplayer(0.35, 0.5, var_0.origin, 200);
}

monitordamage() {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56");
  self endon("_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56");
  self setCanDamage(1);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_13, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_3)) {
      if(var_3 == "_encstr_8DED0A21C79B660BC7588981") {
        if(istrue(self.issaloonstyle))
          self.otherdoor thread bashopen(var_1, var_1.origin);

        thread bashopen(var_1, var_1.origin);
        continue;
      }

      if(var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "_encstr_BA730BF8AFF178988293F158B9" || var_8.basename == "_encstr_99410C4B48C39AB7D0CD95B769DB" || var_8.basename == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1" || var_8.basename == "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898");

        if(var_0 > 10 && !var_14)
          thread bashopen(var_12, var_13);

        continue;
      }

      if(isDefined(var_8) && var_8.basename == "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B" && (var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_3 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B"))
        thread bashopen(var_12, var_13);
    }
  }
}

openmonitor() {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(self.state == 7 || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(self.islean || 0 || 1) {
    if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
      self.useprompt setHintString(&"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5");
  } else if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    self.useprompt setHintString(&"_encstr_AB231877E1A878774967F14B7F215FF4CF53F3C72130D13239ED");

  self.useprompt sethintdisplayrange(200);

  for(;;) {
    self.useprompt waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 useButtonPressed()) {
        break;
      }

      var_1 = var_1 + level.framedurationseconds;
      waitframe();
    }

    if(self.state == 7) {
      var_2 = self gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365", 1);

      if(isDefined(var_2))
        playsoundatpos(var_2, "_encstr_A15F0C05578773FF5DBA485B3277");
      else
        playsoundatpos(self.origin + (0, 0, 42), "_encstr_A15F0C05578773FF5DBA485B3277");

      continue;
    }

    if(self.islean) {
      thread cheapopen(var_0);
      return;
    }

    if(1 && var_0 playerads() > 0.9) {
      thread ajar(var_0);
      return;
    }

    thread cheapopen(var_0);
  }
}

cheapopen(var_0) {
  thread checktriggeralarm(var_0);
  var_1 = self.useprompt.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(isDefined(self.material)) {
    if(self.material == "_encstr_9BC806E72F38AFE8")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_B46A237B31B389739EB5B75ADBFF6B50B7FBF82119F9A19FA9D937A375A7EB05E74F784FC8");
    else if(self.material == "_encstr_ABF605EEBD7B32")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_B12D1A208A22214BB7B460689A8F13D7CD62C95042FAA5661FC87DD0");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "_encstr_BA651CEB26DB539337A08A82F8DF8BF7D01D7F74484353DD7B61726B78E5");

  thread changestate(3);
  var_7 = scripts\engine\utility::ter_op(var_6, self.max_yaw_left, self.max_yaw_right * -1.0);
  var_8 = (self.baseangles[0], self.baseangles[1] + var_7, self.baseangles[2]);
  self rotateTo(var_8, 0.666, 0.0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    var_7 = scripts\engine\utility::ter_op(!var_6, self.otherdoor.max_yaw_left, self.otherdoor.max_yaw_right * -1.0);
    var_8 = (self.otherdoor.baseangles[0], self.otherdoor.baseangles[1] + var_7, self.otherdoor.baseangles[2]);
    self.otherdoor rotateTo(var_8, 0.666, 0.0, 0.333);
  }

  wait 0.666;
  self.lastpushtime = gettime();
  thread changestate(2);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle))
    self.otherdoor thread changestate(2);
}

ajar(var_0) {
  thread checktriggeralarm(var_0);
  thread changestate(6);
  var_1 = self.useprompt.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - var_1);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;
  var_7 = 0.5;
  var_8 = scripts\engine\utility::ter_op(var_6, 15, -15);
  var_0 playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");

  if(isDefined(self.material)) {
    if(self.material == "_encstr_9BC806E72F38AFE8")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_818729F74B224B3B1722C7AF2A790BB1E15BF0675073232E71B00B34F0671137EF938B295AB3CF47AB3B5F");
    else if(self.material == "_encstr_ABF605EEBD7B32")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_B671206EC64EE0D1EB8CBDB7C9F5DDEDB719AF985827B9F56EA3164EA3FA1C5656D6");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "_encstr_84E722889F6203E1F1E740587A293F28D73B61A8C71D19997AC146DD9693719610D70858");

  self rotateYaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    self.otherdoor thread changestate(6);
    var_8 = scripts\engine\utility::ter_op(!var_6, 15, -15);
    self.otherdoor rotateYaw(var_8, var_7, var_7 * 0.25, var_7 * 0.75);
  }

  self.lastpushtime = gettime();
}

pushmonitor() {
  if(self.islean) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_928C0C0137D3D3819F6DD08BD56A");
  self endon("_encstr_928C0C0137D3D3819F6DD08BD56A");
  wait 0.5;

  for(;;) {
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(pushproxcheck(var_2)) {
          push(var_2);
          self.lastpushtime = gettime();
          door_destroynavobstacle();
        }
      }
    }

    if(isDefined(self.lastpushtime) && gettime() > self.lastpushtime + 2000)
      door_createnavobstacle();

    waitframe();
  }
}

pushproxcheck(var_0) {
  self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  if(var_0.origin[2] > self.origin[2] + self.height || var_0.origin[2] + 70 < self.origin[2])
    return 0;

  var_1 = distance2dsquared(var_0.origin, self.doorcenter);
  var_2 = 900;
  return var_1 < var_2;
}

push(var_0) {
  var_1 = 26;
  var_2 = 0;
  var_3 = 25;
  var_4 = self.origin + anglesToForward(self.angles) * 28;
  var_5 = distance2d(var_0.origin, var_4);
  var_6 = scripts\engine\math::normalize_value(var_2, var_1, var_5);
  var_7 = var_3 * (1 - var_6);

  if(var_7 == 0) {
    return;
  }
  var_8 = self.useprompt.origin;
  var_9 = self.angles;
  var_10 = anglestoright(var_9);
  var_11 = vectorNormalize(var_0.origin - var_8);
  var_12 = vectordot(var_10, var_11);
  var_13 = var_12 > 0;
  var_14 = self.angles[1];
  var_15 = scripts\engine\utility::ter_op(var_13 == 1, 1, -1);
  var_16 = var_14 + var_7 * var_15;
  var_17 = angle_diff(var_16, self.baseangles[1]);

  if(var_13) {
    if(var_17 > self.max_yaw_left) {
      self.debug_activity = "_encstr_B6031B97E38B6919D42AA3E012E55181664DF5043B16F3C1AF42D0A0FA" + self.max_yaw_left;
      self.angles = (self.angles[0], self.baseangles[1] + self.max_yaw_left, self.angles[2]);
      return;
    }
  } else if(var_17 > self.max_yaw_right) {
    self.debug_activity = "_encstr_8FD41C6240EBB0C0010AC4800AE031FB3073F8E7747908C8AB0B2EC7CA32" + self.max_yaw_right;
    self.angles = (self.angles[0], self.baseangles[1] - self.max_yaw_right, self.angles[2]);
    return;
  }

  self.angles = (self.angles[0], var_16, self.angles[2]);
}

autoclosemonitor() {
  if(self.islean) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_BDD011B0D5E8DE681BF69BB2537B374BA3B7C9");
  self endon("_encstr_BDD011B0D5E8DE681BF69BB2537B374BA3B7C9");
  wait 0.5;

  for(;;) {
    if(angle_diff(self.angles[1], self.baseangles[1]) < 40) {
      if(isDefined(self.lastpushtime) && gettime() > self.lastpushtime + 3000) {
        var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, 250);

        if(var_0.size == 0)
          thread closedoor(1);
      }
    }

    waitframe();
  }
}

changestate(var_0) {
  if(!isDefined(self.useprompt)) {
    return;
  }
  switch (self.state) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      if(isDefined(self.useprompt))
        self.useprompt sethinticon("_encstr_BE9C13432E022D068C5FA040B7B578716A56CADD47");

      break;
    case 8:
      break;
  }

  self.state = var_0;
  self notify("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  switch (var_0) {
    case 0:
      door_destroynavobstacle();
      door_disableaudioportal();
      thread openmonitor();
      thread bashmonitor();
      thread lockmonitor();
      thread alarmmonitor();
      thread ajarmonitor();
      break;
    case 1:
      door_destroynavobstacle();
      break;
    case 2:
      door_createnavobstacle();
      door_enableaudioportal();
      thread closemonitor();
      thread bashmonitor();
      break;
    case 3:
      door_destroynavobstacle();
      door_enableaudioportal();
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      door_enableaudioportal();
      thread closemonitor();
      thread pushmonitor();
      thread bashmonitor();
      thread autoclosemonitor();
      break;
    case 7:
      if(isDefined(self.useprompt)) {
        self.useprompt sethintdisplayrange(300);
        self.useprompt sethinticon("_encstr_97EA11A5B1DE73D732B7DEC9FAC6DBB1DA9523");
        self.useprompt setHintString(&"_encstr_B8651385DFAA94386065C7E70F3D61C401058C1FB5");
      }

      thread openmonitor();
      thread breachmonitor();
      break;
    case 8:
      thread openmonitor();
      thread bashmonitor();
      thread removealarmmonitor();
      thread disownalarmmonitor();
      break;
  }

  thread updatelockpromptvisibility();
  thread updatealarmpromptvisibility();

  if(isDefined(self.otherdoor))
    self.otherdoor thread updatealarmpromptvisibility();
}

updatestate() {
  switch (self.state) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
    case 8:
      break;
  }
}

closemonitor() {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(!scripts\cp_mp\utility\game_utility::isrealismenabled())
    self.useprompt setHintString(&"_encstr_87AF12D9B17D3154FF9A607DB3FF1E871DE8B111");

  self.useprompt sethintdisplayrange(200);
  self.useprompt sethintdisplayfov(120);
  self.useprompt setuserange(125);
  self.useprompt setusefov(120);
  self.useprompt makeusable();

  for(;;) {
    self.useprompt waittill("_encstr_93461143DEC7CA1FF04AD13A3A32EF6A5F700B", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    var_1 = 0;

    while(var_1 < 0.1) {
      if(!var_0 useButtonPressed()) {
        break;
      }

      var_1 = var_1 + level.framedurationseconds;
      waitframe();
    }

    thread closedoor();
  }
}

closedoor(var_0) {
  if(isDefined(self.material)) {
    if(self.material == "_encstr_9BC806E72F38AFE8")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_82362427A322388DCFEA4870B3F74B583E2EBB87454FA05F6B31C3B89AFF712BD993096FE337");
    else if(self.material == "_encstr_ABF605EEBD7B32")
      playsoundatpos(self.origin + (0, 0, 42), "_encstr_A60C1B831F25D1E329012F450BC0A72F1F3A816B603B20D6E0F27FC342");
  } else
    playsoundatpos(self.origin + (0, 0, 42), "_encstr_820E1D2BEE78316B7FC7D8D73BB973E23F52B18C485FC14CC5880244DAFA71");

  thread changestate(1);
  var_1 = 0.666;

  if(istrue(var_0))
    var_1 = var_1 * 3;

  self rotateTo(self.baseangles, var_1, 0.0, 0.333);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle))
    self.otherdoor rotateTo(self.otherdoor.baseangles, var_1, 0.0, 0.333);

  wait(var_1);
  waitframe();

  if(angle_diff(self.angles[1], self.baseangles[1]) < 1)
    thread changestate(0);
  else
    thread changestate(6);

  if(isDefined(self.otherdoor) && istrue(self.issaloonstyle)) {
    if(angle_diff(self.otherdoor.angles[1], self.otherdoor.baseangles[1]) < 1)
      self.otherdoor thread changestate(0);
    else
      self.otherdoor thread changestate(6);
  }
}

angle_diff(var_0, var_1) {
  return 180 - abs(abs(var_0 - var_1) - 180);
}

amortizeyawtraces() {
  level.doorphase = 0;
  level.doortracequeue = 0;
  var_0 = [];
  var_1 = [];
  level.doortracemetrics = spawnStruct();
  level.doortracemetrics.doorcount = level.doors.size;
  level.doortracemetrics.totaltracecount = 0;
  level.doortracemetrics.tracecountbyphase = [];
  level.doortracemetrics.tracetimebyphase = [];
  level.doortracemetrics.totaltime = 0;
  level.doortracemetrics.totalwaitframes = 0;
  level.waitcycles = 0;
  level.doortraces = 0;
  waitframe();
  level.doortracemetrics.totaltime = gettime();
  var_1[0] = level.doortracemetrics.totaltime;

  for(;;) {
    if(level.doortracequeue == 0) {
      var_2 = gettime();
      var_1[level.doorphase] = var_2 - var_1[level.doorphase];
      var_0[level.doorphase] = level.doortraces;
      level.doortracemetrics.totaltracecount = level.doortracemetrics.totaltracecount + level.doortraces;
      level.doortraces = 0;
      level.doortracemetrics.totalwaitframes = level.doortracemetrics.totalwaitframes + level.waitcycles;
      level.waitcycles = 0;
      level.doorphase++;
      level notify("_encstr_8E27135819EC0BDCB156F523BDBD39D71D4E85C62B");

      if(level.doorphase < 3)
        var_1[level.doorphase] = var_2;
      else
        break;
    }

    waitframe();
  }

  level.doortracemetrics.totaltime = gettime() - level.doortracemetrics.totaltime;
  level.doortracemetrics.tracecountbyphase = var_0;
  level.doortracemetrics.tracetimebyphase = var_1;
}

get_max_yaws() {
  thread get_max_yaw(1);
  thread get_max_yaw(0);
}

get_max_yaw(var_0) {
  if(var_0) {
    if(isDefined(self.script_max_left_angle)) {
      self.max_yaw_left = self.script_max_left_angle;
      return;
    }
  } else if(isDefined(self.script_max_right_angle)) {
    self.max_yaw_right = self.script_max_right_angle;
    return;
  }

  var_1 = 90;
  var_2 = 10;
  var_3 = 0.0;

  while(level.doorphase < 3) {
    var_3 = get_max_yaw_internal(var_1, var_2, var_0);

    if(var_0)
      self.max_yaw_left = var_3;
    else
      self.max_yaw_right = var_3;

    if(var_3 == 100) {
      break;
    }

    var_2 = var_2 * 0.5;
    var_1 = var_3 + var_2;
    level waittill("_encstr_8E27135819EC0BDCB156F523BDBD39D71D4E85C62B");
  }

  var_3 = max(var_3, 90);

  if(var_0)
    self.max_yaw_left = var_3;
  else
    self.max_yaw_right = var_3;
}

get_max_yaw_internal(var_0, var_1, var_2) {
  if(!isDefined(self.traces))
    self.traces = 0;

  if(!isDefined(level.doortraces))
    level.doortraces = 0;

  var_3 = 0;
  var_4 = 0;
  level.doortracequeue++;
  waitframe();

  while(!var_4) {
    if(var_0 > 100) {
      level.currentdoor = undefined;
      level.doortracequeue--;
      return 100;
    }

    while(isDefined(level.currentdoor) && self != level.currentdoor)
      waitframe();

    if(!isDefined(level.currentdoor))
      level.currentdoor = self;

    var_5 = yaw_collision_check(var_0, var_1, var_2);

    if(var_5) {
      if(var_3)
        var_6 = 1;

      var_0 = var_0 + var_1;
    } else {
      if(!var_3)
        var_3 = 1;

      var_0 = var_0 - var_1;
      var_4 = 1;
    }

    self.traces++;
    level.doortraces++;
    var_7 = gettime();

    if(!isDefined(level.doortraceframetime) || level.doortraceframetime != var_7) {
      level.doortraceframetime = var_7;
      level.doortracesthisframe = 0;
    }

    level.doortracesthisframe++;

    if(level.doortracesthisframe == 3) {
      level.doortracesthisframe = 0;
      level.waitcycles++;
      waitframe();
    }
  }

  level.currentdoor = undefined;
  level.doortracequeue--;
  return var_0;
}

yaw_collision_check(var_0, var_1, var_2) {
  if(!var_2)
    var_0 = var_0 * -1;

  var_3 = self.baseangles + (0, var_0, 0);
  var_4 = self.origin + (0, 0, 8);
  var_5 = self.height - 16.0;
  var_6 = anglesToForward(var_3);
  var_7 = anglestoright(var_3);

  if(var_2)
    var_7 = var_7 * -1.0;

  var_8 = var_4 + var_6 * self.length * 0.2;
  var_9 = var_4 + var_6 * (self.length - 2.0);
  var_10 = scripts\engine\trace::capsule_trace(var_8, var_9, 2.0, var_5, var_3, scripts\engine\utility::ter_op(isDefined(self.clip), [self, self.clip], [self]), level.doorcontentoverride, 0);

  if(getdvarint("_encstr_82410FC39A63088045F77537E42F78E5CF")) {
    var_11 = (1, 1, 1);

    if(var_10["_encstr_A53009A25003666B9818C6"] == 1.0)
      var_11 = (0, 1, 0);
    else
      var_11 = (1, 0, 0);

    thread scripts\mp\utility\debug::drawline(var_8, var_9, 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_8 + (0, 0, var_5), var_9 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_8, var_8 + (0, 0, var_5), 600, var_11);
    thread scripts\mp\utility\debug::drawline(var_9, var_9 + (0, 0, var_5), 600, var_11);
  }

  return var_10["_encstr_A53009A25003666B9818C6"] == 1.0;
}

perk_doorsensethink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    foreach(var_1 in level.doors) {
      if(var_1.state != 0) {
        continue;
      }
      if(isDefined(level.playerswithdoorsense) && level.playerswithdoorsense <= 0) {
        continue;
      }
      var_2 = scripts\mp\utility\player::getplayersinradius(var_1.origin, 128);

      if(var_2.size == 0) {
        continue;
      }
      foreach(var_4 in var_2) {
        if(var_4 scripts\mp\utility\perk::_hasperk("_encstr_B2D9157B3B83979FA3E9BB803F12D0D850B11840DE4275"))
          perk_doorsense_outlinedoor(var_4, var_2, var_1);
      }
    }

    wait 0.1;
  }
}

perk_doorsense_outlinedoor(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team)
      var_3[var_3.size] = var_5;
  }

  if(var_3.size == 0) {
    return;
  }
  foreach(var_8 in var_3) {
    if(perk_doorsense_othersideofdoorcheck(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_2, var_0, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_BE8F0A272F9B2BE97268AE8B");
      thread perk_doorsense_trackoutlinedisable(var_9, var_2);
    }
  }
}

perk_doorsense_outlineenemies(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_1) {
    if(var_5.team != var_0.team)
      var_3[var_3.size] = var_5;
  }

  if(var_3.size == 0) {
    return;
  }
  foreach(var_8 in var_3) {
    if(perk_doorsense_othersideofdoorcheck(var_0, var_8, var_2)) {
      var_9 = scripts\mp\utility\outline::outlineenableforplayer(var_8, var_0, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA", "_encstr_BE8F0A272F9B2BE97268AE8B");
      thread perk_doorsense_trackoutlinedisable(var_9, var_8);
    }
  }
}

perk_doorsense_othersideofdoorcheck(var_0, var_1, var_2) {
  var_3 = vectorNormalize(anglestoright(var_2.angles));
  var_4 = vectorNormalize(var_0.origin - var_2.origin);
  var_5 = vectorNormalize(var_1.origin - var_2.origin);
  var_6 = vectordot(var_3, var_4);
  var_7 = vectordot(var_3, var_5);

  if(var_6 > 0 && var_7 < 0 || var_6 < 0 && var_7 > 0)
    return 1;

  return 0;
}

perk_doorsense_trackoutlinedisable(var_0, var_1) {
  wait 0.2;
  scripts\mp\utility\outline::outlinedisable(var_0, var_1);
}

onplayerspawned() {
  var_0 = scripts\mp\utility\perk::_hasperk("_encstr_81791663D09B96EF69094C498891AFDD1D11FAEB906B4E23") || getdvarint("_encstr_97DE1D6E1B9CBE23DBEDE4F5C4279585B1A17DABCD4E95B93A272DB11D958C", 0) == 1;
  updatealldoorslockvisibilityforplayer(self, var_0);
  var_1 = scripts\mp\utility\perk::_hasperk("_encstr_A9D515BF13499B4B5E3D7BD3C6EA6067925F432151F5D3");
  updatealldoorsalarmvisibilityforplayer(self, var_1);
}

updatelockpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  while(!isDefined(level.players))
    waitframe();

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("_encstr_81791663D09B96EF69094C498891AFDD1D11FAEB906B4E23") || getdvarint("_encstr_97DE1D6E1B9CBE23DBEDE4F5C4279585B1A17DABCD4E95B93A272DB11D958C", 0) == 1;
    updatelockpromptvisibilityforplayer(var_1, var_2);
  }
}

updatealldoorslockvisibilityforplayer(var_0, var_1) {
  foreach(var_3 in level.doors)
  var_3 updatelockpromptvisibilityforplayer(var_0, var_1);
}

updatelockpromptvisibilityforplayer(var_0, var_1) {
  if(!isDefined(self.lockprompt)) {
    return;
  }
  var_2 = self.state == 0 || self.state == 7;

  if(var_2 && isDefined(self.otherdoor))
    var_2 = self.otherdoor.state == 0 || self.otherdoor.state == 7;

  if(!istrue(self.breaching) && var_2) {
    if(var_1) {
      self.lockprompt showtoplayer(var_0);
      self.lockprompt enableplayeruse(var_0);
    } else {
      self.lockprompt hidefromplayer(var_0);
      self.lockprompt disableplayeruse(var_0);
    }
  } else {
    self.lockprompt hidefromplayer(var_0);
    self.lockprompt disableplayeruse(var_0);
  }
}

lockmonitor() {
  if(!isDefined(self.lockprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0)
      waitframe();
  }

  self.lockprompt setHintString(&"_encstr_BE12116A82E588A77A25BE554D8AD789E91A2D");
  self.lockprompt setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  updatelockpromptvisibility();

  for(;;) {
    self.lockprompt waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(var_0 meleeButtonPressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread lockdoor();
  }
}

lockdoor() {
  thread changestate(7);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(7);
}

updatealarmpromptvisibility() {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  while(!isDefined(level.players))
    waitframe();

  foreach(var_1 in level.players) {
    var_2 = var_1 scripts\mp\utility\perk::_hasperk("_encstr_A9D515BF13499B4B5E3D7BD3C6EA6067925F432151F5D3");
    updatealarmpromptsvisibilityforplayer(var_1, var_2);
  }
}

updatealldoorsalarmvisibilityforplayer(var_0, var_1) {
  foreach(var_3 in level.doors)
  var_3 updatealarmpromptsvisibilityforplayer(var_0, var_1);
}

updatealarmpromptsvisibilityforplayer(var_0, var_1) {
  if(!isDefined(self.alarmprompts)) {
    return;
  }
  foreach(var_3 in self.alarmprompts) {
    var_4 = var_1 && self.state == 0 || self.state == 8 && isDefined(self.dooralarmprompt) && var_3 == self.dooralarmprompt;

    if(var_4 && isDefined(self.otherdoor))
      var_4 = var_1 && self.otherdoor.state == 0 || self.state == 8 && var_3 == self.dooralarmprompt;

    if(var_4) {
      var_3 showtoplayer(var_0);
      var_3 enableplayeruse(var_0);
      continue;
    }

    var_3 hidefromplayer(var_0);
    var_3 disableplayeruse(var_0);
  }
}

alarmmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 0)
      waitframe();
  }

  foreach(var_1 in self.alarmprompts) {
    var_1 setHintString(&"_encstr_A395120F532F581FB8D5E7270F7529D06C29A57B");
    var_1 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  }

  updatealarmpromptvisibility();

  foreach(var_1 in self.alarmprompts)
  thread _alarmmonitorinternal(var_1);
}

_alarmmonitorinternal(var_0) {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(self.state != 0) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(var_1 meleeButtonPressed()) {
      continue;
    }
    if(var_1 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread alarmdoor(var_1, var_0);
  }
}

alarmdoor(var_0, var_1) {
  var_2 = self gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365");
  playsoundatpos(var_1.origin, "_encstr_A7E711E8E0092B0238BA872B5141F85558BFF0");
  self.dooralarment = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  self.dooralarment setModel("_encstr_B2100D47E82182270D0BA219087CA9");
  self.dooralarment.angles = self.angles;
  self.dooralarment linkTo(self);
  self.dooralarment setentityowner(var_0);
  self.dooralarment setotherent(var_0);
  self.dooralarment setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_B41B0883B10BDCA39519", 0);
  self.dooralarmowner = var_0;
  self.dooralarmprompt = var_1;
  self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_add(self.dooralarmowner.alarmeddoors, self);

  while(self.dooralarmowner.alarmeddoors.size > 3) {
    var_3 = self.dooralarmowner.alarmeddoors[0];
    var_3 removealarmdoor(0);
  }

  thread changestate(8);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(8);
}

removealarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8)
      waitframe();
  }

  self.dooralarmprompt setHintString(&"_encstr_8B271974CACFC14018BB47AB4740B0B97D15BCAF27D79189D0936B");
  self.dooralarmprompt setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  self.dooralarmprompt.owner = self.dooralarmowner;
  self.dooralarmprompt.team = self.dooralarmowner.team;
  updatealarmpromptvisibility();

  for(;;) {
    self.dooralarmprompt waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(self.state != 8) {
      continue;
    }
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    if(var_0 meleeButtonPressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    thread removealarmdoor(1);
  }
}

disownalarmmonitor() {
  if(!isDefined(self.dooralarmprompt) || self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");

  if(isDefined(self.otherdoor)) {
    while(self.otherdoor.state != 8)
      waitframe();
  }

  for(;;) {
    self.dooralarmowner scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");

    if(self.state != 8) {
      return;
    }
    thread removealarmdoor(0);
  }
}

removealarmdoor(var_0) {
  if(var_0)
    playsoundatpos(self.dooralarment.origin, "_encstr_82F212227B870A67C0A28E612871BAD159385204");

  if(isDefined(self.dooralarmowner))
    self.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(self.dooralarmowner.alarmeddoors, self);

  self.dooralarment delete();
  self.dooralarmowner = undefined;
  self.dooralarmprompt = undefined;
  thread changestate(0);

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(0);
}

checktriggeralarm(var_0) {
  if(self.state != 8) {
    return;
  }
  var_1 = self;

  if(!isDefined(self.dooralarment) && isDefined(self.otherdoor))
    var_1 = self.otherdoor;

  if(!isDefined(var_1.dooralarmowner)) {
    return;
  }
  var_2 = var_1.dooralarment;
  var_3 = var_1.dooralarmowner;
  var_1.dooralarmowner.alarmeddoors = scripts\engine\utility::array_remove(var_1.dooralarmowner.alarmeddoors, var_1);
  var_1.dooralarment = undefined;
  var_1.dooralarmowner = undefined;
  var_1.dooralarmprompt = undefined;
  var_3 scripts\mp\killstreaks\killstreaks::givescorefortriggeredalarmeddoor();

  if(isDefined(self.otherdoor))
    self.otherdoor thread changestate(0);

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_0, var_3))) {
    var_2 playLoopSound("_encstr_8CE711B5C1BE8CDB7B27AFB0360B27ADD7B10E");
    pinglocationenemyteams(self.origin, var_0.team);
    var_2 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_8EB70A8BAE4BEAC70938272B", 0);
    wait 4.0;
    var_2 stoploopsound();
    var_2 delete();
  } else {
    playsoundatpos(var_2.origin, "_encstr_82F212227B870A67C0A28E612871BAD159385204");
    var_2 setscriptablepartstate("_encstr_A2CC08B2333395D81D37", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    var_2 delete();
  }
}

ajarmonitor() {
  if(self.islean || scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }
  if(!istrue(self.issaloonstyle)) {
    return;
  }
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_BDB70C208A76D59C872EF37537AB");
  self endon("_encstr_BDB70C208A76D59C872EF37537AB");

  for(;;) {
    waitframe();
    waittillframeend;

    if(self.otherdoor.state != 0)
      thread changestate(6);
  }
}

breachmonitor() {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  thread monitorbreachmelee();
  self.lockprompt setHintString(&"_encstr_990D13A605BC443DA749FA554DA8EB0994150A0D90");
  self.lockprompt setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  updatelockpromptvisibility();

  if(!isDefined(self.otherdoor))
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;

  thread updatelocklight("_encstr_855B0BB1BD8DD6AC1911F6ED39");

  for(;;) {
    self.lockprompt waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(var_0 meleeButtonPressed()) {
      continue;
    }
    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }
    if(var_0 issprinting() || var_0 issprintsliding()) {
      continue;
    }
    if(var_0 ismantling()) {
      continue;
    }
    if(istrue(self.breaching)) {
      continue;
    }
    thread breachdoor(var_0);
  }
}

breachdoor(var_0) {
  thread plantbreach(var_0);
}

monitorbreachmelee() {
  self endon("_encstr_9B5C0D16B3BA4109E33B98F81F1DE1");
  self notify("_encstr_8A6B135BDB739647DE399027ACB0C6A135598D9595");
  self endon("_encstr_8A6B135BDB739647DE399027ACB0C6A135598D9595");
  self.lockedmeleehealth = 150;
  self setCanDamage(1);
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_13, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isDefined(var_3) && !istrue(self.breaching)) {
      if(var_3 == "_encstr_8DED0A21C79B660BC7588981" || var_3 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_3 == "_encstr_911B0C7DA090E9A7F799FD50DD48" || var_3 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_3 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F") {
        var_14 = isDefined(var_8) && isDefined(var_8.basename) && (var_8.basename == "_encstr_BA730BF8AFF178988293F158B9" || var_8.basename == "_encstr_99410C4B48C39AB7D0CD95B769DB" || var_8.basename == "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1" || var_8.basename == "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898");

        if(var_14) {
          continue;
        }
        self.lockedmeleehealth = self.lockedmeleehealth - var_0;

        if(isDefined(self.otherdoor))
          self.otherdoor.lockedmeleehealth = self.otherdoor.lockedmeleehealth - var_0;

        if(self.lockedmeleehealth < 1) {
          if(isDefined(self.otherdoor) || istrue(self.issaloonstyle)) {
            self.otherdoor thread updatelocklight("_encstr_BA19049F4B2D");
            self.otherdoor thread bashopen(var_1, var_1.origin);
          }

          thread updatelocklight("_encstr_BA19049F4B2D");
          thread bashopen(var_1, var_1.origin);
          continue;
        }

        playsoundatpos(self.origin + (0, 0, 42), "_encstr_A74D1C63D7800ACBB0A9DAC273E88F8510B1D7FC7710565345E6022A3B5B");
      }
    }
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");

plantbreach(var_0) {
  if(isDefined(self.otherdoor) && istrue(self.otherdoor.breaching)) {
    return;
  }
  self.breaching = 1;
  thread updatelockpromptvisibility();
  thread watchplayerdeath(var_0);
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = anglestoright(var_2);
  var_4 = vectorNormalize(var_0.origin - self.origin);
  var_5 = vectordot(var_3, var_4);
  var_6 = var_5 > 0;

  if(var_6) {
    var_7 = self.rightplantorg;
    var_8 = self.rightplantang;
  } else {
    var_7 = self.leftplantorg;
    var_8 = self.leftplantang;
  }

  var_0.linktoent = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0 playerlinktodelta(var_0.linktoent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1, 0, 0, 0, 0, 0);
  var_9 = scripts\engine\utility::spawn_tag_origin(var_7, var_8);
  var_0.linktoent moveTo(var_7, 0.25, 0.1, 0.1);
  var_0.linktoent rotateTo(var_8, 0.25, 0.1, 0.1);
  var_0 setstance("_encstr_A5AD069B231F0BAF");

  if(!istrue(var_0 givegunless())) {
    var_0 unlink();
    var_0.linktoent delete();
    var_0.linktoent = undefined;
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  var_0 unlink();
  var_0.linktoent delete();
  var_0.linktoent = undefined;
  var_0 setOrigin(var_7);
  var_0 setplayerangles(var_8);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "_encstr_AA45092A9BB0E33D20ED4C");
  var_10 = scripts\engine\utility::ter_op(var_0.team == "_encstr_9A8507BA4040188D08", "_encstr_8BE4053B1FD34F", "_encstr_918305A77EDB3B");

  if(level.mapname == "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0")
    var_10 = scripts\engine\utility::ter_op(var_0.team == "_encstr_9A8507BA4040188D08", "_encstr_B2E40580875803", "_encstr_AA8305594B131B");

  var_0 queuedialogforplayer("_encstr_84690847F92EFD1A5F1F" + var_10 + "_encstr_AD500E0196C2F5D67758099340873818", "_encstr_8A2C11976F8A67C6A36FC7DAFB58EA8833AE28", 2);
  thread create_player_rig(var_0, "_encstr_A51B086302E74E1BADDA");
  var_9 thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, "_encstr_A24E069389FFAA3C");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_11 setModel("_encstr_A3B30E856CADE209A050075FE07EC3EF");
  var_11.animname = "_encstr_8B07036CD0";
  var_11 useanimtree(#animtree);
  self.plantedbomb = var_11;
  var_9 thread scripts\common\anim::anim_single_solo(var_11, "_encstr_A24E069389FFAA3C");
  var_12 = getanimlength(level.scr_anim["_encstr_A51B086302E74E1BADDA"]["_encstr_A24E069389FFAA3C"]);
  var_13 = 0.5;
  wait(var_12 - var_13);

  if(istrue(self.cancelplant)) {
    self.breaching = 0;
    thread updatelockpromptvisibility();
    return 0;
  }

  thread bomb_planted_think(var_0, var_6);
  givebreachscore(var_0);
  wait(var_13);

  if(var_0 isviewmodelanimplaying())
    var_0 stopviewmodelanim();

  var_0 thread takegunless();
  remove_player_rig(var_0);
  return 1;
}

bomb_planted_think(var_0, var_1) {
  var_2 = var_0.team;
  self.defused = 0;

  if(!isDefined(self.breachindex)) {
    if(!isDefined(level.breachindex))
      level.breachindex = 0;
    else
      level.breachindex++;

    self.breachindex = level.breachindex;
  }

  bomb_fuse_think(var_2);

  if(!self.defused) {
    self.doorcenter = self.origin + anglesToForward(self.angles) * self.length * 0.5 + anglestoup(self.angles) * self.height * 0.5;
    var_3 = self.doorcenter;

    if(var_1)
      var_4 = self.rightplantang;
    else
      var_4 = self.leftplantang;

    var_5 = spawnfx(level._effect["_encstr_950D0F9D6D2A63501B5755786BA387E46B"], var_3, anglesToForward(var_4) * -1.0, (0, 0, 1));
    triggerfx(var_5);
    physicsexplosionsphere(var_3, 200, 100, 3);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_3);
    earthquake(0.5, 1.0, var_3, 1500);
    var_0 scripts\mp\utility\weapon::_launchgrenade("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683", self.plantedbomb.origin + anglesToForward(var_4) * 100.0, (0, 0, 0), 0.05, 1);
    var_0 scripts\mp\utility\weapon::_launchgrenade("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", self.plantedbomb.origin + anglesToForward(var_4) * 100.0, (0, 0, 0), 0.05, 1);
    wait 0.1;

    if(isDefined(var_0))
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 50, 10, 5, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");
    else
      self.plantedbomb radiusdamage(self.plantedbomb.origin, 100, 50, 5, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E");

    thread bashopen(var_0, self.plantedbomb.origin);

    if(isDefined(self.otherdoor))
      self.otherdoor thread bashopen(var_0, self.plantedbomb.origin);
  }

  self.plantedbomb delete();
  self.plantedbomb = undefined;
  setomnvar("_encstr_8FB61105DB86CFFDAF50821AB9D17497B93EA7" + self.breachindex, 0);
  setomnvar("_encstr_AAB815BA96D72D37CEC25BACAF472DB559C9FACAE68E7D" + self.breachindex, undefined);
  self.breaching = 0;
  thread updatelockpromptvisibility();
  thread updatelocklight("_encstr_BA19049F4B2D");

  if(isDefined(self.otherdoor))
    self.otherdoor thread updatelocklight("_encstr_BA19049F4B2D");
}

bomb_fuse_think(var_0) {
  self notify("_encstr_93720F904BE551BFF2B95F690EAAA9994C");
  self.timerobject = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.plantedbomb.origin);
  var_1 = gettime();
  var_2 = int(var_1 + 1000.0);
  setomnvar("_encstr_8FB61105DB86CFFDAF50821AB9D17497B93EA7" + self.breachindex, var_2);
  setomnvar("_encstr_AAB815BA96D72D37CEC25BACAF472DB559C9FACAE68E7D" + self.breachindex, self.timerobject);
  var_3 = var_2 - var_1;

  while(!self.defused && var_3 > 0) {
    var_1 = gettime();
    var_3 = var_2 - var_1;

    if(var_3 < 1500) {
      if(var_3 <= 250)
        self.plantedbomb playSound("_encstr_8203175B3318A3F7E0E1A44753E58B5D7F8F63BDBB5B07925E");
      else if(var_3 < 500)
        self.plantedbomb playSound("_encstr_9203179D930AEF7868B99B511AFED090C2BF152B6703B8AA74");
      else if(var_3 < 1500)
        self.plantedbomb playSound("_encstr_AA0317C813BDF9174A11040732424B40E70F7078D740F669C7");
      else
        self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");

      wait 0.25;
    } else if(var_3 < 3500) {
      self.plantedbomb playSound("_encstr_8103174C9CCAB0D8437DDD2C4E37A537D9F5985659C1F5608C");
      wait 0.5;
    } else {
      self.plantedbomb playSound("_encstr_8803179643206932CB472F6F05E05AAE884E0EDFD9E00F3FBF");
      wait 1.0;
    }

    if(var_3 < 0) {
      break;
    }
  }
}

watchplayerdeath(var_0) {
  self endon("_encstr_93720F904BE551BFF2B95F690EAAA9994C");
  self.cancelplant = 0;

  for(;;) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      if(isDefined(self.plantedbomb)) {
        self.plantedbomb delete();
        self.plantedbomb = undefined;
        self.plantedkey = undefined;
      }

      self.cancelplant = 1;
      break;
    }

    waitframe();
  }
}

script_model_anims() {}

#using_animtree("_encstr_B40101");

create_player_rig(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0.player_rig)) {
    return;
  }
  var_0.animname = var_1;

  if(!isDefined(var_2))
    var_2 = "_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A";

  var_0.player_rig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_0.player_rig setModel(var_2);
  var_0.player_rig hide();
  var_0.player_rig.animname = var_1;
  var_0.player_rig useanimtree(#animtree);
  var_0 playerlinktodelta(var_0.player_rig, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0, 0);
  var_0 watch_remove_rig();
  remove_player_rig(var_0);
}

remove_player_rig(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.player_rig)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 getdroptofloorposition(var_0.origin);

  if(isDefined(var_1))
    var_0 setOrigin(var_1);
  else
    var_0 setOrigin(var_0.origin + (0, 0, 100));

  var_0.player_rig delete();
  var_0.player_rig = undefined;
}

watch_remove_rig(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_BE840BF2FFD8B0A4DB6EE31FA1", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
}

givebreachscore(var_0) {
  var_1 = "_encstr_BAD70791FB4F67C8D4";
  var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
  var_0 thread scripts\mp\rank::giverankxp(var_1, var_2);
  var_0 thread scripts\mp\rank::scoreeventpopup(var_1);
}

givegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = getcompleteweaponname("_encstr_9A0D0C4B54606F8F63C84B8B53EE");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_offhand_weapons(0);
    scripts\common\utility::allow_melee(0);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return var_1;
}

takegunless() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }
  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);

  while(self hasweapon(self.gunnlessweapon)) {
    if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(self.gunnlessweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(self.gunnlessweapon);
    else {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self.gunnlessweapon);
      scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }

    waitframe();
  }

  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_offhand_weapons(1);
  scripts\common\utility::allow_melee(1);
}

updatelocklight(var_0) {
  if(!isDefined(self.locklight)) {
    return;
  }
  self notify("_encstr_B2B410C88B25565B35ECBAEE3FB90C1F784B");
  self endon("_encstr_B2B410C88B25565B35ECBAEE3FB90C1F784B");

  if(!scripts\mp\flags::levelflag("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\mp\flags::levelflagwait("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  self.locklight setscriptablepartstate("_encstr_912B0778976260C323", var_0);
}

linkdoubledoors() {
  foreach(var_1 in level.doors) {
    if(isDefined(var_1.otherdoor)) {
      continue;
    }
    foreach(var_3 in level.doors) {
      if(var_3 == var_1) {
        continue;
      }
      var_4 = var_1 gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365", 1);
      var_5 = var_3 gettagorigin("_encstr_96F310ADF90776697D5A2041429605694365", 1);

      if(!isDefined(var_4) || !isDefined(var_5)) {
        continue;
      }
      var_6 = distancesquared(var_4, var_5);

      if(var_6 < 225) {
        if(var_6 < 100) {
          var_1.issaloonstyle = 1;
          var_3.issaloonstyle = 1;
        }

        var_3.otherdoor = var_1;
        var_1.otherdoor = var_3;

        if(isDefined(var_1.lockprompt) && isDefined(var_3.lockprompt)) {
          var_3.lockprompt delete();
          var_3.lockprompt = var_1.lockprompt;
          var_7 = (var_4 + var_5) * 0.5 + (0, 0, 15);
          var_1.lockprompt unlink();
          var_1.lockprompt.origin = var_7;
          var_1 thread changestate(var_1.state);
          var_3 thread changestate(var_3.state);
          var_1.leftplantorg = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1.baseangles) * -24.5;
          var_1.leftplantang = (0, var_1.baseangles[1] - 90.0, 0);
          var_1.rightplantorg = (var_7[0], var_7[1], var_1.origin[2]) + anglestoright(var_1.baseangles) * 24.5;
          var_1.rightplantang = (0, var_1.baseangles[1] + 90.0, 0);
          var_3.leftplantorg = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3.baseangles) * -24.5;
          var_3.leftplantang = (0, var_3.baseangles[1] - 90.0, 0);
          var_3.rightplantorg = (var_7[0], var_7[1], var_3.origin[2]) + anglestoright(var_3.baseangles) * 24.5;
          var_3.rightplantang = (0, var_3.baseangles[1] + 90.0, 0);
        }
      }
    }
  }
}

door_createnavobstacle() {
  if(!isDefined(self.clipent)) {
    return;
  }
  if(isDefined(self.doornavobstacle)) {
    return;
  }
  self.doornavobstacle = createnavobstaclebyent(self.clipent);
}

door_destroynavobstacle() {
  if(!isDefined(self.doornavobstacle)) {
    return;
  }
  destroynavobstacle(self.doornavobstacle);
  self.doornavobstacle = undefined;
}

door_enableaudioportal() {
  if(isDefined(self.audioportalent))
    self.audioportalent enableaudioportal(1);
}

door_disableaudioportal() {
  if(isDefined(self.otherdoor) && (self.otherdoor.state != 0 && self.otherdoor.state != 7 && self.otherdoor.state != 8)) {
    return;
  }
  if(isDefined(self.audioportalent))
    self.audioportalent enableaudioportal(0);
}

door_can_open_check() {
  return self.state == 6 || self.state == 0;
}