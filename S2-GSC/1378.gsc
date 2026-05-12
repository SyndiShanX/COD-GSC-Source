/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1378.gsc
*********************************************/

lib_0562::func_00D5() {
  common_scripts\utility::func_092C("moneyCloud", "vfx/gameplay\mp\zombie/gj_pickup_zombies_01_money");
  foreach(var_01 in ["classic_ee_trigger_01", "classic_ee_trigger_02", "classic_ee_trigger_03", "classic_ee_trigger_04"]) {
    var_02 = getent(var_01, "script_noteworthy");
    level.var_231F[var_01] = var_02;
    thread lib_0562::func_3599(var_02);
  }

  thread lib_0562::func_7E3D();
}

lib_0562::func_3599(param_00) {
  while(!isDefined(level.var_8AD2)) {
    wait 0.05;
  }

  for(;;) {
    level waittill("spawned_money_share");
    foreach(var_02 in level.var_8AD2) {
      if(!param_00 method_858B(var_02.var_0116)) {
        continue;
      }

      var_03 = var_02.var_0117;
      if(!isPlayer(var_03)) {
        continue;
      }

      var_04 = var_03 getentitynumber();
      var_02 maps\mp\zombies\_zombies_money::func_8ADD(var_04, 0);
      thread lib_0562::func_62D8(param_00.var_0116);
      var_02.var_6FD4 = 0;
      var_02.var_6FCB = 0;
      param_00.var_2320 = 1;
      level notify("theclassic_step_done");
      return;
    }
  }
}

lib_0562::func_62D8(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5("moneyCloud"), param_00);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
}

lib_0562::func_0F4E() {
  foreach(var_01 in level.var_231F) {
    if(!common_scripts\utility::func_562E(var_01.var_2320)) {
      return 0;
    }
  }

  return 1;
}

lib_0562::func_7E3D() {
  while(!lib_0562::func_0F4E()) {
    level waittill("theclassic_step_done");
  }

  maps\mp\zombies\_zombies_magicbox::func_09C8("ppsh41_classic_zm", "extended_mag", "none", "none");
}