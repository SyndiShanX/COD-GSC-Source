/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_quicktest.gsc
***************************************************/

func_00F9() {
  level.var_6662 = common_scripts\utility::func_46B7("objective_testing_spawners", "targetname");
  level.var_6664 = common_scripts\utility::func_46B7("objective_testing_spawners_salt", "targetname");
  level.var_6663 = common_scripts\utility::func_46B7("objective_testing_spawners_com", "targetname");
  level.var_6661 = common_scripts\utility::func_46B7("objective_testing_spawners_blimp", "targetname");
}

func_772E() {
  for(;;) {
    var_00 = 0;
    foreach(var_02 in maps\mp\agents\_agent_utility::func_43FD("all")) {
      if(common_scripts\utility::func_562E(var_02.var_6816)) {
        continue;
      }

      if(var_02.var_901F <= level.var_A980 && var_02.var_6816) {
        var_00++;
      }
    }

    iprintln("zombies left to kill: " + var_00);
    wait(1);
  }
}

func_0CAE(param_00, param_01, param_02, param_03) {
  wait(0.5);
  foreach(var_05 in level.var_AC1D) {
    var_05 notify("open", level.var_744A[0]);
  }

  var_07 = func_4420(param_03);
  for(;;) {
    if(isDefined(level.var_744A)) {
      for(var_08 = 0; var_08 < level.var_744A.size; var_08++) {
        if(!isDefined(level.var_744A[var_08].var_57D9)) {
          level.var_744A[var_08].var_57D9 = 1;
          if(isDefined(var_07)) {
            level.var_744A[var_08] setorigin(var_07[var_08].var_0116);
            level.var_744A[var_08] setangles(var_07[var_08].var_001D);
          }

          level.var_744A[var_08] func_8706(param_00, param_01);
          if(0) {
            level.var_744A[var_08].var_AC5B = 1;
          }

          level.var_744A[var_08] maps\mp\gametypes\zombies::func_4798(param_02 - 500);
          level.var_744A[var_08] lib_056A::func_47B5();
          level.var_744A[var_08] lib_056A::func_47B8();
          level.var_744A[var_08] lib_056A::func_47B1();
        }
      }
    }

    wait(1);
  }
}

func_8706(param_00, param_01) {
  var_02 = self getcurrentweapon();
  lib_0586::func_078C(param_00);
  lib_0586::func_078C(param_01);
  lib_0586::func_078E(param_00);
  lib_0586::func_0790(var_02);
}

func_4420(param_00) {
  var_01 = [(0, 0, 0)];
  switch (param_00) {
    case 1:
      var_01 = level.var_6664;
      thread maps\mp\mp_zombie_nest_ee_shard::func_784E();
      break;

    case 2:
      var_01 = level.var_6663;
      thread maps\mp\mp_zombie_nest_ee_shard::func_7866();
      break;

    case 3:
      var_01 = level.var_6663;
      thread maps\mp\mp_zombie_nest_ee_cart::func_7865();
      break;

    case 4:
      var_01 = level.var_6663;
      thread maps\mp\mp_zombie_nest_ee_fuses::func_785D();
      break;

    case 5:
      var_01 = level.var_6662;
      thread maps\mp\mp_zombie_nest_ee_tower_battle::func_170D();
      break;

    case 6:
      var_01 = level.var_6662;
      thread maps\mp\mp_zombie_nest_ee_tower_battle::func_1715();
      break;

    case 7:
      var_01 = level.var_6661;
      break;

    case 8:
      var_01 = level.var_6661;
      thread maps\mp\mp_zombie_nest_ee_final_boss::func_7853();
      thread maps\mp\mp_zombie_nest_ee_overcharge::func_784B();
      break;

    default:
      break;
  }

  return var_01;
}

func_7C11(param_00) {
  while(!isDefined(level.var_744A)) {
    wait(0.1);
  }

  wait(1);
  level.var_A980 = param_00;
}