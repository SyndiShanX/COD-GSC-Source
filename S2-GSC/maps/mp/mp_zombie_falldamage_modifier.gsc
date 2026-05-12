/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_falldamage_modifier.gsc
*****************************************************/

func_00F9() {
  thread func_7D14();
}

func_7D14() {
  for(;;) {
    if(isDefined(level.var_744A)) {
      foreach(var_01 in level.var_744A) {
        if(!var_01 maps\mp\_utility::func_0649("specialty_falldamage")) {
          var_01 maps\mp\_utility::func_47A2("specialty_falldamage");
          var_01.var_3A0F = float(0);
        }
      }
    }

    wait(1);
  }
}