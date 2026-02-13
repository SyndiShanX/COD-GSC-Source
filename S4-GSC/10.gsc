/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 10.gsc
*************************************************/

_id_01E4() {
  if(!isDefined(self._id_03E9) || !isDefined(self._id_CE77)) {
    return;
  }
  var_0 = self._id_03E9;
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1._id_EBE6 = gettime();

  if(isDefined(self._id_EBE7)) {
    var_1._id_EBE7 = self._id_EBE7;
  } else {
    var_1._id_EBE7 = spawnStruct();
  }

  if(isDefined(self._id_0408)) {
    var_1._id_0408 = spawnStruct();
    var_1._id_0408._id_2C56 = self._id_0408._id_2C56;
    var_1._id_0408._id_8522 = self._id_0408._id_8522;
  }

  if(isDefined(self._id_02ED)) {
    if(isDefined(self._id_FEFC)) {
      if(isDefined(self._id_02ED._id_0481)) {
        var_1.target = self._id_02ED._id_0481;
      }

      var_1._id_02ED = self._id_02ED;
    }

    var_1.target = self._id_02ED._id_0481;
  }

  var_0._id_EBE3 = var_1;

  if(isDefined(self._id_CE78) && !isDefined(self._id_CD5D)) {
    _id_5F46(self._id_CE78);
  }
}

_id_5F46(var_0) {
  if(!isDefined(level._id_BD6F)) {
    level._id_BD6F = [];
  }

  if(isDefined(level._id_BD6F[var_0])) {
    return;
  }
  level._id_BD6F[var_0] = 1;
  var_1 = _func_0070();

  foreach(var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }
    if(!isDefined(var_3._id_CE78)) {
      continue;
    }
    if(var_3._id_CE78 != var_0) {
      continue;
    }
    var_3._id_CD5D = 1;
    var_3 _id_01E4();
    var_3 delete();
  }

  level._id_BD6F[var_0] = undefined;
}

_id_3F92(var_0, var_1) {
  if(!isDefined(level._id_5DB9)) {
    self._id_FEC7 = undefined;

    if(!isDefined(var_0)) {
      var_2 = _func_0375();
    } else if(!_func_0107(var_0) && var_0 == "") {
      var_2 = _func_0375();
    } else if(_func_0107(var_0)) {
      var_2 = makeweapon(var_0[randomint(var_0.size)]);
    } else {
      var_2 = makeweapon(var_0);
    }

    if(!isnullweapon(var_2)) {
      self._id_CF80 = 1;

      if(isDefined(var_1) && var_1 == "sidearm") {
        self._id_CF83 = var_0;
      } else {
        self._id_CF81 = var_0;
      }
    }

    return var_2;
  } else
    return [[level._id_5DB9]](var_0, var_1);
}