/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2709.gsc
*************************************************/

_id_6AF9() {
  return self._id_9021;
}

_id_EC3C() {
  if(!isai(self)) {
    var_0 = _id_6AF9();

    if(scripts\mp\utility\killstreak::_id_88DF()) {
      if(var_0.basename != "s4_gw_flima35_mp") {
        if(self.primaryweaponobj.basename == "s4_gw_flima35_mp") {
          var_0 = self.primaryweaponobj;
        } else {
          var_0 = makeweapon("s4_gw_flima35_mp");
          scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 0);
        }
      }
    } else if(!self hasweapon(var_0))
      var_0 = _id_6A3F();

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_0);
  } else
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon("none");
}

_id_6A3F() {
  var_0 = self.primaryweapons;
  return var_0[0];
}

_id_C2CC(var_0, var_1, var_2) {
  var_3 = self._id_10D6A;

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
    self._id_10D6A = var_3;
    var_3._id_A4A7 = 1;
    var_3._id_A4BD = -1;
    var_3._id_2F52 = [];
    var_3._id_AAD1 = [];
    var_3._id_B014 = [];
  }

  var_4 = undefined;

  if(istrue(var_1)) {
    var_4 = var_3._id_A4BD;
    var_3._id_A4BD--;
    var_3._id_AAD1[var_4] = var_0;
  } else {
    var_4 = var_3._id_A4A7;
    var_3._id_A4A7++;
    var_3._id_2F52[var_4] = var_0;
  }

  if(istrue(var_2)) {
    var_3._id_B014[var_4] = var_4;
  }

  return var_4;
}

_id_F9A4(var_0) {
  var_1 = self._id_10D6A;

  if(var_0 < 0) {
    var_1._id_AAD1[var_0] = undefined;
  } else {
    var_1._id_2F52[var_0] = undefined;
  }
}

_id_74B2() {
  var_0 = self._id_10D6A;

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3, var_2 in var_0._id_2F52) {
    if(!isDefined(var_0._id_B014[var_3])) {
      var_0._id_2F52[var_3] = undefined;
    }
  }

  foreach(var_3, var_2 in var_0._id_AAD1) {
    if(!isDefined(var_0._id_B014[var_3])) {
      var_0._id_AAD1[var_3] = undefined;
    }
  }
}