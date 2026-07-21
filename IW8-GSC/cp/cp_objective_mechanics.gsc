/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_objective_mechanics.gsc
***********************************************/

starthackingdefensewithnoobjstruct(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 60);
  var_5 = gettime() + var_4 * 1000;
  var_6 = 0;
  var_7 = 0.05;
  level.hack_duration = var_4;
  var_8 = undefined;

  if(isDefined(var_3))
    var_8 = scripts\cp\utility::getplayersinteam(var_3);
  else
    var_8 = level.players;

  if(!isDefined(level.independent_hack_defenses))
    level.independent_hack_defenses = 1;
  else
    level.independent_hack_defenses++;

  var_9 = scripts\cp\cp_objectives::requestworldid("_encstr_93921293A04BE7D098F089D10EA5E8C3B1AEFF08" + level.independent_hack_defenses);
  var_10 = spawnStruct();
  var_10.currentteam = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "_encstr_9A8507BA4040188D08");
  var_11 = 1;

  if(istrue(var_10.no_lua))
    var_11 = 0;

  var_12 = 0;

  if(istrue(var_10.use_old_label))
    var_12 = 1;

  hacking_labels_init(var_10, var_12);
  hacking_ui();
  objective_setplayintro(var_9, 0);
  objective_setplayoutro(var_9, 0);
  objective_state(var_9, "_encstr_AF5A081BBAC993AC73A3");
  objective_icon(var_9, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  objective_setbackground(var_9, 1);
  objective_position(var_9, var_0);
  objective_setshowprogress(var_9, 1);
  objective_setprogress(var_9, 0);
  objective_setownerteam(var_9, undefined);
  objective_setprogressteam(var_9, undefined);
  updatehackdefenselabel(var_10, 0, var_9);
  var_13 = 1;
  var_14 = var_0;
  var_15 = (0, 0, 90);

  for(;;) {
    wait(var_7);
    var_16 = 0;
    var_17 = 0;
    var_18 = [];

    foreach(var_20 in var_8) {
      if(!var_20 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_20.inhackring))
          var_20.inhackring = undefined;

        continue;
      }

      if(distancesquared(var_20.origin, var_14) > 14400) {
        if(isDefined(var_20.inhackring))
          var_20.inhackring = undefined;

        continue;
      }

      if(isDefined(var_20.perk_data["_encstr_8F7F11A31AFA808F433BB81D41E85B78803B51"]))
        var_17 = var_17 + var_20.perk_data["_encstr_8F7F11A31AFA808F433BB81D41E85B78803B51"];

      var_16++;

      if(!scripts\engine\utility::array_contains(var_18, var_20)) {
        var_18[var_18.size] = var_20;
        var_20.inhackring = 1;
      }
    }

    if(var_13 || scripts\cp\utility::roundup(var_6) % 1 == 0) {
      updatehackdefenselabel(var_10, var_16, var_9);
      var_13 = 0;
    }

    if(var_16 < 1) {
      continue;
    }
    var_22 = 1;
    var_23 = 1;

    switch (var_16) {
      case 2:
        var_23 = 1 + 1 * var_22;
        break;
      case 3:
        var_23 = 1 + 3 * var_22;
        break;
      case 4:
        var_23 = 1 + 5 * var_22;
        break;
    }

    if(var_17 > 0)
      var_23 = var_23 + var_17;

    level.hack_multiplier = var_23;
    var_6 = var_6 + var_7 * var_23;

    if(var_6 >= var_4) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var_24 = var_6 / var_4;

    if(isDefined(level.hack_progress))
      var_24 = level.hack_progress;

    objective_setprogress(var_9, var_24);
  }

  objective_setlabel(var_9, "_encstr_B40101");
  objective_sethot(var_9, 0);
  objective_setpulsate(var_9, 0);
  objective_setprogress(var_9, 0);
  objective_setshowprogress(var_9, 0);
  objective_delete(var_9);
  level.hack_duration = undefined;
  scripts\cp\cp_objectives::freeworldid("_encstr_93921293A04BE7D098F089D10EA5E8C3B1AEFF08" + level.independent_hack_defenses);

  if(isDefined(var_2))
    level notify(var_2);
  else
    level notify("_encstr_ABDC137A910CD7DDD09B0708AB68A4F72568F29259");
}

starthackingdefense(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 60);
  var_6 = gettime() + var_5 * 1000;
  var_7 = 0;
  var_8 = 0.05;

  if(!isDefined(var_4))
    var_4 = 120;

  level.hack_duration = var_5;
  objective_setownerteam(var_0.objectiveindex, undefined);
  objective_setprogressteam(var_0.objectiveindex, undefined);
  var_9 = spawnStruct();
  var_9.currentteam = var_0.currentteam;
  var_10 = 1;

  if(istrue(var_0.no_lua))
    var_10 = 0;

  var_11 = 0;

  if(istrue(var_0.use_old_label))
    var_11 = 1;

  hacking_labels_init(var_9, var_11);
  hacking_ui();
  updatehackdefenselabel(var_9, 0, var_0.objectiveindex);
  var_12 = 1;
  var_13 = var_1;
  var_14 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_13);
  var_15 = 0;
  var_16 = (0, 0, 90);

  for(;;) {
    wait(var_8);
    var_17 = 0;
    var_18 = 0;
    var_19 = [];

    foreach(var_21 in scripts\cp\utility::getplayersinteam(var_0.currentteam)) {
      if(!var_21 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_21.inhackring))
          var_21.inhackring = undefined;

        continue;
      }

      if(distancesquared(var_21.origin, var_13) > var_4 * var_4) {
        if(isDefined(var_21.inhackring)) {
          var_21.inhackring = undefined;

          if(scripts\cp\cp_relics::try_start_fake_infil_chopper("_encstr_AB57110667FAEB596F9B286883641037528FF5"))
            var_21 thread scripts\cp\cp_relics::_id_12B7E(var_21);
        }

        continue;
      }

      if(istrue(var_0._id_1405D)) {
        var_22 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0);

        if(!scripts\engine\trace::ray_trace_passed(var_21 getEye(), var_13, [var_21], var_22)) {
          if(isDefined(var_21.inhackring))
            var_21.inhackring = undefined;

          continue;
        }
      }

      if(isDefined(var_21.perk_data["_encstr_8F7F11A31AFA808F433BB81D41E85B78803B51"]))
        var_18 = var_18 + var_21.perk_data["_encstr_8F7F11A31AFA808F433BB81D41E85B78803B51"];

      var_17++;

      if(!scripts\engine\utility::array_contains(var_19, var_21)) {
        var_19[var_19.size] = var_21;
        var_21.inhackring = 1;

        if(var_15 == 0) {
          var_14 playSound("_encstr_A7E51198E0091BE23EFC5F35D486F04C47CBFD");
          var_14 playLoopSound("_encstr_8B4A0E6C38F50D16D8B6A5B976FAC607");
          var_15 = 1;
        }
      }
    }

    if(var_12 || scripts\cp\utility::roundup(var_7) % 1 == 0) {
      updatehackdefenselabel(var_9, var_17, var_0.objectiveindex);
      var_12 = 0;
    }

    if(var_17 < 1) {
      if(var_15 > 0) {
        var_14 playSound("_encstr_8A961046B3D1F8D117D8D188AC4F2FA32DEF");
        var_14 stoploopsound("_encstr_8B4A0E6C38F50D16D8B6A5B976FAC607");
        var_15 = 0;
      }

      continue;
    }

    var_24 = 1;

    if(isDefined(var_0.hack_modifier))
      var_24 = var_0.hack_modifier;

    var_25 = 1;

    switch (var_17) {
      case 2:
        var_25 = 1 + 1 * var_24;
        break;
      case 3:
        var_25 = 1 + 3 * var_24;
        break;
      case 4:
        var_25 = 1 + 5 * var_24;
        break;
    }

    if(var_18 > 0)
      var_25 = var_25 + var_18;

    level.hack_multiplier = var_25;
    var_7 = var_7 + var_8 * var_25;

    if(var_7 >= var_5) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var_26 = var_7 / var_5;

    if(isDefined(level.hack_progress))
      var_26 = level.hack_progress;

    if(var_7 <= 0) {
      break;
    }
  }

  var_14 playSound("_encstr_8A961046B3D1F8D117D8D188AC4F2FA32DEF");
  var_14 stoploopsound("_encstr_8B4A0E6C38F50D16D8B6A5B976FAC607");
  objective_setlabel(var_0.objectiveindex, "_encstr_B40101");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setpulsate(var_0.objectiveindex, 0);
  level.hack_duration = undefined;

  if(isDefined(var_3))
    var_0 notify(var_3);
  else
    var_0 notify("_encstr_ABDC137A910CD7DDD09B0708AB68A4F72568F29259");

  var_14 delete();
}

updatehackdefenselabel(var_0, var_1, var_2) {
  if(!isDefined(var_0.players_in_range))
    var_0.players_in_range = var_1;
  else if(var_0.players_in_range == var_1) {
    if(!var_1) {
      if(!isDefined(level.rooftop_hack_paused))
        level.rooftop_hack_paused = gettime() + randomintrange(15, 25) * 1000;

      if(gettime() >= level.rooftop_hack_paused)
        level.rooftop_hack_paused = undefined;
    }

    return;
  }

  if(!var_1) {
    objective_setlabel(var_2, var_0.label_settings.paused);
    objective_sethot(var_2, 1);
    objective_setpulsate(var_2, 1);
    level.hacking_paused = 1;
    setomnvar("_encstr_96CD138D83BAD743858DB6B4E6CED79B969DE6851B", 0);
  } else {
    level.hacking_paused = undefined;
    level.rooftop_hack_paused = undefined;

    switch (var_1) {
      case 1:
        objective_setlabel(var_2, var_0.label_settings.mult_1);
        break;
      case 2:
        objective_setlabel(var_2, var_0.label_settings.mult_2);
        break;
      case 3:
        objective_setlabel(var_2, var_0.label_settings.mult_3);
        break;
      case 4:
        objective_setlabel(var_2, var_0.label_settings.mult_4);
        break;
    }

    setomnvar("_encstr_96CD138D83BAD743858DB6B4E6CED79B969DE6851B", var_1);
    objective_sethot(var_2, 0);
    objective_setpulsate(var_2, 0);
  }

  var_0.players_in_range = var_1;

  if(!isDefined(level.next_hack_update_time))
    level.next_hack_update_time = gettime();

  foreach(var_4 in scripts\cp\utility::getplayersinteam(var_0.currentteam)) {
    if(soundexists("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320"))
      var_4 playlocalsound("_encstr_AFC716FA83730FED506FD7FF5DF0F737FDF883A2EEAEB320");
  }
}

hacking_labels_init(var_0, var_1) {
  var_2 = spawnStruct();

  if(!istrue(var_1)) {
    var_2.paused = &"_encstr_8BF32840F1CFFE238EF60102E2D60FB68D21C8A99165E7EF685F21060B3DF70C53D1F091C1A3AB971DAD";
    var_2.mult_1 = &"_encstr_B1A92CBFE9D0A04371999F0DC14FE9F5848788FDD9C1C1EFCFC763A540BF03D949607481B1968D24BF55F93F56FE";
    var_2.mult_2 = &"_encstr_8CA92C67E9863251C7D6D01A321F58FA8CF9EFA349DF6D090F4F2E058B4BD04BF671630719F7AF708DEDA24A6895";
    var_2.mult_3 = &"_encstr_A9A92CCDB2F7B98641F7736DFF2940E14A5F75A76C0649DE7EE33B4DCB10BE6107245C5EC2AA619C419F177F7F1F";
    var_2.mult_4 = &"_encstr_B4A92C568F79C259D8D70F2BCFE0B07A79B5DEEBC4698D8108297763D18738BB299C05A15FA15F98EE2B371F97E5";
  } else {
    var_2.paused = &"_encstr_81BE25C6381725D5A1494919204937FDEB957EC5494B8D9F85E0718918947D156768F7DDCBAF55";
    var_2.mult_1 = &"_encstr_99E92916EF2108719F13BBC6831958B8B0B3D5FC598B40879740A17D71B6238E012F09CF17E96D072F5F16";
    var_2.mult_2 = &"_encstr_8BE929579321F649BF32C6BF2C57693E882FCFF14F192D3997DCCD95C46F014071E3657F1F01E5F1C3619B";
    var_2.mult_3 = &"_encstr_83E92907C371A619CF42B6EF7CE7B9EE78FF7FA13F499DC9476CBDC514BFB130C113D50FAFF1558113B1EB";
    var_2.mult_4 = &"_encstr_A1E929EF1F366172E1319B4BF30EEDDAB9F518FB47034D5FF733F7339FAF3865412129643FD245963F269C";
  }

  var_0.label_settings = var_2;
}

hacking_ui() {
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

smoke_canister_spawn(var_0, var_1) {
  var_2 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_2 = var_2 + (0, 0, 1);
  magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", var_2, (0, randomint(360), 0), 0.01);
}

smoke_canister_end(var_0) {}