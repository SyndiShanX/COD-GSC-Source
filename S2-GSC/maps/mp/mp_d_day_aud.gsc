/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_d_day_aud.gsc
*********************************************/

func_00F9() {
  func_7BBE();
}

func_7BBE() {
  lib_0378::func_8DC7("mp_intro_dday_plane_flyover", ::func_64FF);
}

func_64FF(param_00, param_01) {
  var_02 = self;
  var_02 endon("death");
  wait 0.05;
  if(param_01 == 11) {
    lib_0380::func_6844("mp_dday_intro_fly_bombers_01_allies", "allies", var_02);
    wait(1.2);
    lib_0380::func_6844("mp_dday_intro_fly_bombers_01_axis", "axis", var_02);
  }

  if(param_01 == 101) {
    lib_0380::func_6844("mp_dday_intro_fly_bombers_02_allies", "allies", var_02);
    lib_0380::func_6844("mp_dday_intro_fly_bombers_02_axis", "axis");
  }

  if(param_01 == 105) {
    lib_0380::func_6844("mp_dday_intro_fly_bombers_03_allies", "allies", var_02);
  }

  if(param_01 == 104) {
    lib_0380::func_6844("mp_dday_intro_fly_bombers_03_axis", "axis", var_02);
  }

  if(param_01 == 13) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_01_allies", "allies", var_02);
    lib_0380::func_6844("mp_dday_intro_fly_fighters_01_axis", "axis", var_02);
  }

  if(param_01 == 4) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_02_allies", "allies", var_02);
    lib_0380::func_6844("mp_dday_intro_fly_fighters_02_axis", "axis", var_02);
  }

  if(param_01 == 3) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_03_allies", "allies", var_02);
  }

  if(param_01 == 5) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_04_axis", "axis", var_02);
  }

  if(param_01 == 8) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_04_allies", "allies", var_02);
    lib_0380::func_6844("mp_dday_intro_fly_fighters_05_axis", "axis", var_02);
  }

  if(param_01 == 7) {
    lib_0380::func_6844("mp_dday_intro_fly_fighters_05_allies", "allies", var_02);
    lib_0380::func_6844("mp_dday_intro_fly_fighters_03_axis", "axis", var_02);
  }
}