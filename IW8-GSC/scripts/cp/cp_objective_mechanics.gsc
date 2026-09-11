/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objective_mechanics.gsc
*************************************************/

function starthackingdefensewithnoobjstruct(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 60);
  var_5 = gettime() + var_4 * 1000;
  var_6 = 0;
  var_7 = 0.05;
  level.hack_duration = var_4;
  var_8 = undefined;

  if(isDefined(var_3)) {
    var_8 = scripts\cp\utility::getplayersinteam(var_3);
  } else {
    var_8 = level.players;
  }

  if(!isDefined(level.independent_hack_defenses)) {
    level.independent_hack_defenses = 1;
  } else {
    level.independent_hack_defenses++;
  }

  var_9 = scripts\cp\cp_objectives::requestworldid("independent_hack_" + level.independent_hack_defenses);
  var_10 = spawnStruct();
  var_10.currentteam = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "allies");
  var_11 = 1;

  if(istrue(var_10.no_lua)) {
    var_11 = 0;
  }

  var_12 = 0;

  if(istrue(var_10.use_old_label)) {
    var_12 = 1;
  }

  hacking_labels_init(var_10, var_12);
  hacking_ui();
  objective_setplayintro(var_9, 0);
  objective_setplayoutro(var_9, 0);
  objective_state(var_9, "current");
  objective_icon(var_9, "icon_waypoint_objective_general");
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
    wait var_7;
    var_16 = 0;
    var_17 = 0;
    var_18 = [];

    foreach(var_20 in var_8) {
      if(!var_20 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_20.inhackring)) {
          var_20.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var_20.origin, var_14) > 14400) {
        if(isDefined(var_20.inhackring)) {
          var_20.inhackring = undefined;
        }

        continue;
      }

      if(isDefined(var_20.perk_data["hack_speed_boost"])) {
        var_17 += var_20.perk_data["hack_speed_boost"];
      }

      var_16++;

      if(!scripts\engine\utility::array_contains(var_18, var_20)) {
        var_18 = var_20;
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

    if(var_17 > 0) {
      var_23 += var_17;
    }

    level.hack_multiplier = var_23;
    var_6 += var_7 * var_23;

    if(var_6 >= var_4) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var_24 = var_6 / var_4;

    if(isDefined(level.hack_progress)) {
      var_24 = level.hack_progress;
    }

    objective_setprogress(var_9, var_24);
  }

  objective_setlabel(var_9, "");
  objective_sethot(var_9, 0);
  objective_setpulsate(var_9, 0);
  objective_setprogress(var_9, 0);
  objective_setshowprogress(var_9, 0);
  objective_delete(var_9);
  level.hack_duration = undefined;
  scripts\cp\cp_objectives::freeworldid("independent_hack_" + level.independent_hack_defenses);

  if(isDefined(var_2)) {
    level notify(var_2);
    return;
  }

  level notify("defense_hack_ended");
}

function starthackingdefense(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 60);
  var_6 = gettime() + var_5 * 1000;
  var_7 = 0;
  var_8 = 0.05;

  if(!isDefined(var_4)) {
    var_4 = 120;
  }

  level.hack_duration = var_5;
  objective_setownerteam(var_0.objectiveindex, undefined);
  objective_setprogressteam(var_0.objectiveindex, undefined);
  var_9 = spawnStruct();
  var_9.currentteam = var_0.currentteam;
  var_10 = 1;

  if(istrue(var_0.no_lua)) {
    var_10 = 0;
  }

  var_11 = 0;

  if(istrue(var_0.use_old_label)) {
    var_11 = 1;
  }

  hacking_labels_init(var_9, var_11);
  hacking_ui();
  updatehackdefenselabel(var_9, 0, var_0.objectiveindex);
  var_12 = 1;
  var_13 = var_1;
  var_14 = spawn("script_origin", var_13);
  var_15 = 0;
  var_16 = (0, 0, 90);

  for(;;) {
    wait var_8;
    var_17 = 0;
    var_18 = 0;
    var_19 = [];

    foreach(var_21 in scripts\cp\utility::getplayersinteam(var_0.currentteam)) {
      if(!var_21 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var_21.inhackring)) {
          var_21.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var_21.origin, var_13) > var_4 * var_4) {
        if(isDefined(var_21.inhackring)) {
          var_21.inhackring = undefined;

          if(scripts\cp\cp_relics::try_start_fake_infil_chopper("relic_landlocked")) {
            var_21 thread scripts\cp\cp_relics::ref_12b7e(var_21);
          }
        }

        continue;
      }

      if(istrue(var_0.ref_1405d)) {
        var_22 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0);

        if(!scripts\engine\trace::ray_trace_passed(var_21 getEye(), var_13, [var_21], var_22)) {
          if(isDefined(var_21.inhackring)) {
            var_21.inhackring = undefined;
          }

          continue;
        }
      }

      if(isDefined(var_21.perk_data["hack_speed_boost"])) {
        var_18 += var_21.perk_data["hack_speed_boost"];
      }

      var_17++;

      if(!scripts\engine\utility::array_contains(var_19, var_21)) {
        var_19 = var_21;
        var_21.inhackring = 1;

        if(var_15 == 0) {
          var_14 playSound("cp_hacking_start");
          var_14 playLoopSound("cp_hacking_lp");
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
        var_14 playSound("cp_hacking_stop");
        var_14 stoploopsound("cp_hacking_lp");
        var_15 = 0;
      }

      continue;
    }

    var_24 = 1;

    if(isDefined(var_0.hack_modifier)) {
      var_24 = var_0.hack_modifier;
    }

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

    if(var_18 > 0) {
      var_25 += var_18;
    }

    level.hack_multiplier = var_25;
    var_7 += var_8 * var_25;

    if(var_7 >= var_5) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var_26 = var_7 / var_5;

    if(isDefined(level.hack_progress)) {
      var_26 = level.hack_progress;
    }

    if(var_7 <= 0) {
      break;
    }
  }

  var_14 playSound("cp_hacking_stop");
  var_14 stoploopsound("cp_hacking_lp");
  objective_setlabel(var_0.objectiveindex, "");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setpulsate(var_0.objectiveindex, 0);
  level.hack_duration = undefined;

  if(isDefined(var_3)) {
    var_0 notify(var_3);
  } else {
    var_0 notify("defense_hack_ended");
  }

  var_14 delete();
}

function updatehackdefenselabel(var_0, var_1, var_2) {
  if(!isDefined(var_0.players_in_range)) {
    var_0.players_in_range = var_1;
  } else if(var_0.players_in_range == var_1) {
    if(!var_1) {
      if(!isDefined(level.rooftop_hack_paused)) {
        level.rooftop_hack_paused = gettime() + randomintrange(15, 25) * 1000;
      }

      if(gettime() >= level.rooftop_hack_paused) {
        level.rooftop_hack_paused = undefined;
      }
    }

    return;
  }

  if(!var_1) {
    objective_setlabel(var_2, var_0.label_settings.paused);
    objective_sethot(var_2, 1);
    objective_setpulsate(var_2, 1);
    level.hacking_paused = 1;
    setomnvar("cpu_hacking_signal", 0);
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

    setomnvar("cpu_hacking_signal", var_1);
    objective_sethot(var_2, 0);
    objective_setpulsate(var_2, 0);
  }

  var_0.players_in_range = var_1;

  if(!isDefined(level.next_hack_update_time)) {
    level.next_hack_update_time = gettime();
  }

  foreach(var_4 in scripts\cp\utility::getplayersinteam(var_0.currentteam)) {
    if(soundexists("iw8_new_objective_sfx")) {
      var_4 playlocalsound("iw8_new_objective_sfx");
    }
  }
}

function hacking_labels_init(var_0, var_1) {
  var_2 = spawnStruct();

  if(!istrue(var_1)) {
    var_2.paused = &"CP_BR_SYRK_OBJECTIVES/PANHACKING_PAUSED";
    var_2.mult_1 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_1";
    var_2.mult_2 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_2";
    var_2.mult_3 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_3";
    var_2.mult_4 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_4";
  } else {
    var_2.paused = &"CP_BR_SYRK_OBJECTIVES/HACKING_PAUSED";
    var_2.mult_1 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_1";
    var_2.mult_2 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_2";
    var_2.mult_3 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_3";
    var_2.mult_4 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_4";
  }

  var_0.label_settings = var_2;
}

function hacking_ui() {
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

function smoke_canister_spawn(var_0, var_1) {
  var_2 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_2 += (0, 0, 1);
  magicgrenademanual("deploy_airdrop_mp", var_2, (0, randomint(360), 0), 0.01);
}

function smoke_canister_end(var_0) {}