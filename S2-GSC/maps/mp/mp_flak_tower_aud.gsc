/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_flak_tower_aud.gsc
*********************************************/

func_00F9() {
  func_7BBE();
}

func_7BBE() {
  lib_0378::func_8DC7("mp_intro_flak_plane_flyover", ::func_6502);
  lib_0378::func_8DC7("mp_intro_flak_plane_deathspin", ::func_6500);
  lib_0378::func_8DC7("mp_intro_flak_plane_explode", ::func_6501);
}

func_6502(param_00) {
  var_01 = self;
  var_01 endon("death");
  wait 0.05;
  if(param_00 == 1) {
    lib_0380::func_6844("mp_flak_intro_fly_fighters_01_allies", "allies", var_01);
    lib_0380::func_6844("mp_flak_intro_fly_fighters_01_axis", "axis", var_01);
  }

  if(param_00 == 2) {
    lib_0380::func_6844("mp_flak_intro_fly_fighters_02_allies", "allies", var_01);
  }

  if(param_00 == 3) {
    lib_0380::func_6844("mp_flak_intro_fly_fighters_03_allies", "allies", var_01);
    lib_0380::func_6844("mp_flak_intro_fly_fighters_02_axis", "axis", var_01);
  }

  if(param_00 == 5) {
    lib_0380::func_6844("mp_flak_intro_fly_fighters_03_axis", "axis", var_01);
  }
}

func_6500() {
  var_00 = self;
  lib_0380::func_6844("intro_deathspin", undefined, var_00);
}

func_6501() {
  var_00 = self;
  lib_0380::func_6844("ks_plane_destruct_explode", undefined, var_00);
}