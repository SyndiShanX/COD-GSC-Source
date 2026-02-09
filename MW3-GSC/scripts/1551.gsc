/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1551.gsc
**************************************/

_id_3B69(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_3 = 0;

    for(var_4 = var_2 + 1; var_4 < var_0.size; var_4++) {
      if(var_0[var_4][[var_1]]() < var_0[var_2][[var_1]]()) {
        var_5 = var_0[var_4];
        var_0[var_4] = var_0[var_2];
        var_0[var_2] = var_5;
      }
    }
  }

  return var_0;
}

_id_3B6A(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isDefined(var_3) && var_3 == self) {
      self._id_3B6B = gettime();

      if(isDefined(level._id_16C3)) {
        self._id_3B6C = max(level._id_16C3 - (self._id_3B6B - level._id_16CF), 0);
      }
      if(!maps\_utility::_id_12C1() || isDefined(maps\_utility::_id_133A(self)._id_3B6B)) {
        common_scripts\utility::flag_set(var_1);
      }
      break;
    }
  }
}