/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\weaponlist.gsc
**************************************/

_id_0CCA() {
  return weaponisauto(self.weapon) || weaponburstcount(self.weapon) > 0;
}

_id_0CCB() {
  return weaponissemiauto(self.weapon);
}

_id_0CCC() {
  if(_id_0CCA()) {
    return 0.1 / weaponfiretime(self.weapon);
  } else {
    return 0.5;
  }
}

_id_0CCD() {
  if(_id_0CCA()) {
    return 0.1 / weaponfiretime(self.weapon);
  } else {
    return 0.2;
  }
}

_id_0CCE() {
  return 0.25;
}

_id_0CCF(var_0) {
  if(!_id_0CCA() || isDefined(var_0) && var_0 == 1) {
    var_1 = 0.5 + randomfloat(1);
    return weaponfiretime(self.weapon) * var_1;
  } else {
    return weaponfiretime(self.weapon);
  }
}

_id_0CD0() {
  if(self.weapon == "none") {
    self._id_0CD1 = 0;
    return 0;
  }

  if(weaponclass(self.weapon) == "rocketlauncher") {
    if(!self.a._id_0CD2) {
      thread animscripts\combat_utility::_id_0CD3();
    }
  }

  if(!isDefined(self._id_0CD1)) {
    self._id_0CD1 = weaponclipsize(self.weapon);
  } else {
    self._id_0CD1 = weaponclipsize(self.weapon);

  }
  if(self._id_0CD1 <= 0) {
    return 0;
  } else {
    return 1;
  }
}

_id_0CD4(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 3.0;

  }
  if(!isDefined(var_3)) {
    var_2 = 1;

  }
  if(!isDefined(var_4)) {
    var_4 = "rifle";

  }
  var_0 = tolower(var_0);
  anim._id_0CD5[var_0]["type"] = var_1;
  anim._id_0CD5[var_0]["time"] = var_2;
  anim._id_0CD5[var_0]["clipsize"] = var_3;
  anim._id_0CD5[var_0]["anims"] = var_4;
}

_id_0CD6(var_0) {
  anim._id_0CD5[tolower(var_0)]["type"] = "turret";
}