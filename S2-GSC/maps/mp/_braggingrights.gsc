/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_braggingrights.gsc
*********************************************/

func_7DA2() {
  var_00 = func_45C5();
  var_01 = [];
  for(var_02 = 0; var_02 < var_00; var_02++) {
    var_01[var_02] = [];
  }

  foreach(var_04 in level.var_744A) {
    if(isalive(var_04)) {
      var_05 = var_04 method_83BD();
      if(var_05 < var_00) {
        var_06 = var_01[var_05].size;
        var_01[var_05][var_06] = var_04;
      }
    }
  }

  foreach(var_02, var_05 in var_01) {
    if(var_05.size > 1) {
      var_09 = tablelookupbyrow("mp/braggingrights.csv", var_02, 2);
      var_0A = undefined;
      var_0B = undefined;
      foreach(var_0D in var_05) {
        var_0E = var_0D maps\mp\_utility::func_4628(var_09);
        if(!isDefined(var_0A) || var_0E > var_0A) {
          var_0B = var_0D;
          var_0A = var_0E;
        }
      }

      foreach(var_0D in var_05) {
        if(var_0D == var_0B) {
          if(!isDefined(var_0D.var_6024)) {
            var_0D.var_6024 = 0;
          }

          var_11 = 0;
          foreach(var_04 in var_05) {
            if(isDefined(var_04.var_6024)) {
              var_11 = var_11 + var_04.var_6024;
            }
          }

          var_0D.var_6024 = var_0D.var_6024 + var_11;
          continue;
        }

        var_0D.var_1B7E = 1;
      }
    }
  }

  foreach(var_04 in level.var_744A) {
    if(isDefined(var_04.var_1B7E) && var_04.var_1B7E) {
      var_04.var_6024 = 0;
    }
  }
}

func_45C5() {
  var_00 = -1;
  var_01 = "temp";
  while(var_01 != "") {
    var_00++;
    var_01 = tablelookupbyrow("mp/braggingrights.csv", var_00, 0);
  }

  return var_00;
}