/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objective_mechanics.gsc
*************************************************/

function starthackingdefensewithnoobjstruct(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::ter_op(isDefined(var1), var1, 60);
  var5 = gettime() + var4 * 1000;
  var6 = 0;
  var7 = 0.05;
  level.hack_duration = var4;
  var8 = undefined;

  if(isDefined(var3)) {
    var8 = scripts\cp\utility::getplayersinteam(var3);
  } else {
    var8 = level.players;
  }

  if(!isDefined(level.independent_hack_defenses)) {
    level.independent_hack_defenses = 1;
  } else {
    level.independent_hack_defenses++;
  }

  var9 = scripts\cp\cp_objectives::requestworldid("independent_hack_" + level.independent_hack_defenses);
  var10 = spawnStruct();
  var10.currentteam = scripts\engine\utility::ter_op(isDefined(var3), var3, "allies");
  var11 = 1;

  if(istrue(var10.no_lua)) {
    var11 = 0;
  }

  var12 = 0;

  if(istrue(var10.use_old_label)) {
    var12 = 1;
  }

  hacking_labels_init(var10, var12);
  hacking_ui();
  objective_setplayintro(var9, 0);
  objective_setplayoutro(var9, 0);
  objective_state(var9, "current");
  objective_icon(var9, "icon_waypoint_objective_general");
  objective_setbackground(var9, 1);
  objective_position(var9, var0);
  objective_setshowprogress(var9, 1);
  objective_setprogress(var9, 0);
  objective_setownerteam(var9, undefined);
  objective_setprogressteam(var9, undefined);
  updatehackdefenselabel(var10, 0, var9);
  var13 = 1;
  var14 = var0;
  var15 = (0, 0, 90);

  for(;;) {
    wait var7;
    var16 = 0;
    var17 = 0;
    var18 = [];

    foreach(var20 in var8) {
      if(!var20 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var20.inhackring)) {
          var20.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var20.origin, var14) > 14400) {
        if(isDefined(var20.inhackring)) {
          var20.inhackring = undefined;
        }

        continue;
      }

      if(isDefined(var20.perk_data["hack_speed_boost"])) {
        var17 += var20.perk_data["hack_speed_boost"];
      }

      var16++;

      if(!scripts\engine\utility::array_contains(var18, var20)) {
        var18 = var20;
        var20.inhackring = 1;
      }
    }

    if(var13 || scripts\cp\utility::roundup(var6) % 1 == 0) {
      updatehackdefenselabel(var10, var16, var9);
      var13 = 0;
    }

    if(var16 < 1) {
      continue;
    }

    var22 = 1;
    var23 = 1;

    switch (var16) {
      case 2:
        var23 = 1 + 1 * var22;
        break;
      case 3:
        var23 = 1 + 3 * var22;
        break;
      case 4:
        var23 = 1 + 5 * var22;
        break;
    }

    if(var17 > 0) {
      var23 += var17;
    }

    level.hack_multiplier = var23;
    var6 += var7 * var23;

    if(var6 >= var4) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var24 = var6 / var4;

    if(isDefined(level.hack_progress)) {
      var24 = level.hack_progress;
    }

    objective_setprogress(var9, var24);
  }

  objective_setlabel(var9, "");
  objective_sethot(var9, 0);
  objective_setpulsate(var9, 0);
  objective_setprogress(var9, 0);
  objective_setshowprogress(var9, 0);
  objective_delete(var9);
  level.hack_duration = undefined;
  scripts\cp\cp_objectives::freeworldid("independent_hack_" + level.independent_hack_defenses);

  if(isDefined(var2)) {
    level notify(var2);
    return;
  }

  level notify("defense_hack_ended");
}

function starthackingdefense(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::ter_op(isDefined(var2), var2, 60);
  var6 = gettime() + var5 * 1000;
  var7 = 0;
  var8 = 0.05;

  if(!isDefined(var4)) {
    var4 = 120;
  }

  level.hack_duration = var5;
  objective_setownerteam(var0.objectiveindex, undefined);
  objective_setprogressteam(var0.objectiveindex, undefined);
  var9 = spawnStruct();
  var9.currentteam = var0.currentteam;
  var10 = 1;

  if(istrue(var0.no_lua)) {
    var10 = 0;
  }

  var11 = 0;

  if(istrue(var0.use_old_label)) {
    var11 = 1;
  }

  hacking_labels_init(var9, var11);
  hacking_ui();
  updatehackdefenselabel(var9, 0, var0.objectiveindex);
  var12 = 1;
  var13 = var1;
  var14 = spawn("script_origin", var13);
  var15 = 0;
  var16 = (0, 0, 90);

  for(;;) {
    wait var8;
    var17 = 0;
    var18 = 0;
    var19 = [];

    foreach(var21 in scripts\cp\utility::getplayersinteam(var0.currentteam)) {
      if(!var21 scripts\cp\utility::is_valid_player()) {
        if(isDefined(var21.inhackring)) {
          var21.inhackring = undefined;
        }

        continue;
      }

      if(distancesquared(var21.origin, var13) > var4 * var4) {
        if(isDefined(var21.inhackring)) {
          var21.inhackring = undefined;

          if(scripts\cp\cp_relics::try_start_fake_infil_chopper("relic_landlocked")) {
            var21 thread scripts\cp\cp_relics::ref_12b7e(var21);
          }
        }

        continue;
      }

      if(istrue(var0.ref_1405d)) {
        var22 = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0);

        if(!scripts\engine\trace::ray_trace_passed(var21 getEye(), var13, [var21], var22)) {
          if(isDefined(var21.inhackring)) {
            var21.inhackring = undefined;
          }

          continue;
        }
      }

      if(isDefined(var21.perk_data["hack_speed_boost"])) {
        var18 += var21.perk_data["hack_speed_boost"];
      }

      var17++;

      if(!scripts\engine\utility::array_contains(var19, var21)) {
        var19 = var21;
        var21.inhackring = 1;

        if(var15 == 0) {
          var14 playSound("cp_hacking_start");
          var14 playLoopSound("cp_hacking_lp");
          var15 = 1;
        }
      }
    }

    if(var12 || scripts\cp\utility::roundup(var7) % 1 == 0) {
      updatehackdefenselabel(var9, var17, var0.objectiveindex);
      var12 = 0;
    }

    if(var17 < 1) {
      if(var15 > 0) {
        var14 playSound("cp_hacking_stop");
        var14 stoploopsound("cp_hacking_lp");
        var15 = 0;
      }

      continue;
    }

    var24 = 1;

    if(isDefined(var0.hack_modifier)) {
      var24 = var0.hack_modifier;
    }

    var25 = 1;

    switch (var17) {
      case 2:
        var25 = 1 + 1 * var24;
        break;
      case 3:
        var25 = 1 + 3 * var24;
        break;
      case 4:
        var25 = 1 + 5 * var24;
        break;
    }

    if(var18 > 0) {
      var25 += var18;
    }

    level.hack_multiplier = var25;
    var7 += var8 * var25;

    if(var7 >= var5) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    var26 = var7 / var5;

    if(isDefined(level.hack_progress)) {
      var26 = level.hack_progress;
    }

    if(var7 <= 0) {
      break;
    }
  }

  var14 playSound("cp_hacking_stop");
  var14 stoploopsound("cp_hacking_lp");
  objective_setlabel(var0.objectiveindex, "");
  objective_sethot(var0.objectiveindex, 0);
  objective_setpulsate(var0.objectiveindex, 0);
  level.hack_duration = undefined;

  if(isDefined(var3)) {
    var0 notify(var3);
  } else {
    var0 notify("defense_hack_ended");
  }

  var14 delete();
}

function updatehackdefenselabel(var0, var1, var2) {
  if(!isDefined(var0.players_in_range)) {
    var0.players_in_range = var1;
  } else if(var0.players_in_range == var1) {
    if(!var1) {
      if(!isDefined(level.rooftop_hack_paused)) {
        level.rooftop_hack_paused = gettime() + randomintrange(15, 25) * 1000;
      }

      if(gettime() >= level.rooftop_hack_paused) {
        level.rooftop_hack_paused = undefined;
      }
    }

    return;
  }

  if(!var1) {
    objective_setlabel(var2, var0.label_settings.paused);
    objective_sethot(var2, 1);
    objective_setpulsate(var2, 1);
    level.hacking_paused = 1;
    setomnvar("cpu_hacking_signal", 0);
  } else {
    level.hacking_paused = undefined;
    level.rooftop_hack_paused = undefined;

    switch (var1) {
      case 1:
        objective_setlabel(var2, var0.label_settings.mult_1);
        break;
      case 2:
        objective_setlabel(var2, var0.label_settings.mult_2);
        break;
      case 3:
        objective_setlabel(var2, var0.label_settings.mult_3);
        break;
      case 4:
        objective_setlabel(var2, var0.label_settings.mult_4);
        break;
    }

    setomnvar("cpu_hacking_signal", var1);
    objective_sethot(var2, 0);
    objective_setpulsate(var2, 0);
  }

  var0.players_in_range = var1;

  if(!isDefined(level.next_hack_update_time)) {
    level.next_hack_update_time = gettime();
  }

  foreach(var4 in scripts\cp\utility::getplayersinteam(var0.currentteam)) {
    if(soundexists("iw8_new_objective_sfx")) {
      var4 playlocalsound("iw8_new_objective_sfx");
    }
  }
}

function hacking_labels_init(var0, var1) {
  var2 = spawnStruct();

  if(!istrue(var1)) {
    var2.paused = &"CP_BR_SYRK_OBJECTIVES/PANHACKING_PAUSED";
    var2.mult_1 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_1";
    var2.mult_2 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_2";
    var2.mult_3 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_3";
    var2.mult_4 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_4";
  } else {
    var2.paused = &"CP_BR_SYRK_OBJECTIVES/HACKING_PAUSED";
    var2.mult_1 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_1";
    var2.mult_2 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_2";
    var2.mult_3 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_3";
    var2.mult_4 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_4";
  }

  var0.label_settings = var2;
}

function hacking_ui() {
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

function smoke_canister_spawn(var0, var1) {
  var2 = scripts\engine\utility::drop_to_ground(var0, 50, -200, (0, 0, 1));
  var2 += (0, 0, 1);
  magicgrenademanual("deploy_airdrop_mp", var2, (0, randomint(360), 0), 0.01);
}

function smoke_canister_end(var0) {}