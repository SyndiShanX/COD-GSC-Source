/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_falldamage_modifier.gsc
*****************************************************/

main() {
  thread func_7D14();
}

func_7D14() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var_01 in level.players) {
        if(!var_01 maps\mp\_utility::_hasperk("specialty_falldamage")) {
          var_01 maps\mp\_utility::giveperk("specialty_falldamage");
          var_01.var_3A0F = float(0);
        }
      }
    }

    wait(1);
  }
}