/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2972.gsc
************************/

func_13BFD() {
  var_0 = getEntArray();
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].classname) && getsubstr(var_0[var_1].classname, 0, 7) == "weapon_") {
      var_2 = var_0[var_1];
      var_3 = getsubstr(var_2.classname, 7);
      if(isDefined(var_2.var_ECF2)) {
        var_4 = weaponclipsize(var_3);
        var_5 = weaponmaxammo(var_3);
        var_2 gettimepassedpercentage(var_4, var_5, var_4, 0);
        var_6 = weaponaltweaponname(var_3);
        if(var_6 != "none") {
          var_7 = weaponclipsize(var_6);
          var_8 = weaponmaxammo(var_6);
          var_2 gettimepassedpercentage(var_7, var_8, var_7, 1);
        }

        continue;
      }

      var_9 = 0;
      var_4 = undefined;
      var_0A = undefined;
      var_0B = 0;
      var_0C = undefined;
      var_0D = undefined;
      if(isDefined(var_2.var_ECF0)) {
        var_4 = var_2.var_ECF0;
        var_9 = 1;
      }

      if(isDefined(var_2.var_ECF1)) {
        var_0A = var_2.var_ECF1;
        var_9 = 1;
      }

      if(isDefined(var_2.var_ECEE)) {
        var_0C = var_2.var_ECEE;
        var_0B = 1;
      }

      if(isDefined(var_2.var_ECEF)) {
        var_0D = var_2.var_ECEF;
        var_0B = 1;
      }

      if(var_9) {
        if(!isDefined(var_4)) {}

        if(!isDefined(var_0A)) {}

        var_2 gettimepassedpercentage(var_4, var_0A);
      }

      if(var_0B) {
        if(!isDefined(var_0C)) {}

        if(!isDefined(var_0D)) {}

        var_2 gettimepassedpercentage(var_0C, var_0D, 0, 1);
      }
    }
  }
}