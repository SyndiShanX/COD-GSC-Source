/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_falldamage_modifier.gsc
*************************************************************/

main() {
  thread _id_7D14();
}

_id_7D14() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        if(!var_1 maps\mp\_utility::_hasperk("specialty_falldamage")) {
          var_1 maps\mp\_utility::giveperk("specialty_falldamage");
          var_1._id_3A0F = _float(0);
        }
      }
    }

    wait 1;
  }
}