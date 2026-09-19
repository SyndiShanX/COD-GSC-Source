/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_braggingrights.gsc
***********************************************/

_id_7DA2() {
  var_0 = _id_45C5();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0; var_2++)
    var_1[var_2] = [];

  foreach(var_4 in level.players) {
    if(isalive(var_4)) {
      var_5 = var_4 _meth_83BD();

      if(var_5 < var_0) {
        var_6 = var_1[var_5].size;
        var_1[var_5][var_6] = var_4;
      }
    }
  }

  foreach(var_2, var_5 in var_1) {
    if(var_5.size > 1) {
      var_9 = _func_1AE("mp/braggingrights.csv", var_2, 2);
      var_10 = undefined;
      var_11 = undefined;

      foreach(var_13 in var_5) {
        var_14 = var_13 maps\mp\_utility::getplayerstat(var_9);

        if(!isDefined(var_10) || var_14 > var_10) {
          var_11 = var_13;
          var_10 = var_14;
        }
      }

      foreach(var_13 in var_5) {
        if(var_13 == var_11) {
          if(!isDefined(var_13._id_6024))
            var_13._id_6024 = 0;

          var_17 = 0;

          foreach(var_4 in var_5) {
            if(isDefined(var_4._id_6024))
              var_17 = var_17 + var_4._id_6024;
          }

          var_13._id_6024 = var_13._id_6024 + var_17;
          continue;
        }

        var_13._id_1B7E = 1;
      }
    }
  }

  foreach(var_4 in level.players) {
    if(isDefined(var_4._id_1B7E) && var_4._id_1B7E)
      var_4._id_6024 = 0;
  }
}

_id_45C5() {
  var_0 = -1;

  for(var_1 = "temp"; var_1 != ""; var_1 = _func_1AE("mp/braggingrights.csv", var_0, 0))
    var_0++;

  return var_0;
}