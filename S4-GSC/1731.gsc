/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1731.gsc
*************************************************/

_id_3609() {
  var_0 = distancesquared(self.origin, self._id_0B67._id_03C8);

  if(var_0 > 160000) {
    self._id_0B67._id_03C1 = randomintrange(1, 5);
  } else {
    self._id_0B67._id_03C1 = 10;
  }

  switch (self._id_0B67._id_03CC) {
    case "single":
      self._id_0B67._id_03CA = 1;
      break;
    case "burst":
      self._id_0B67._id_03CA = _id_451A(var_0);
      break;
    case "semi":
      self._id_0B67._id_03CA = _id_451A(var_0);
      break;
    case "full":
      self._id_0B67._id_03CA = _id_451B();
      break;
    case "mg":
      self._id_0B67._id_03CA = _id_451C();
      break;
  }
}

_id_451C() {
  var_0 = _id_06AC::_id_6E2B();
  var_1 = isDefined(var_0);

  if(var_1 && isDefined(var_0._id_CCD2)) {
    var_2 = var_0._id_CCD2;
  } else {
    var_2 = 0.5;
  }

  if(var_1 && isDefined(var_0._id_CCD0)) {
    var_3 = var_0._id_CCD0 - var_2;
  } else {
    var_3 = 1.5;
  }

  var_4 = var_2 + randomfloat(var_3);
  return int(var_4 * 10.0);
}

_id_451B() {
  var_0 = self._id_00CC;
  var_1 = weaponclass(self._id_04F6);

  if(weaponclass(self._id_04F6) == "mg") {
    var_2 = randomfloat(10);

    if(var_2 < 3) {
      var_0 = randomintrange(2, 6);
    } else if(var_2 < 8) {
      var_0 = randomintrange(6, 12);
    } else {
      var_0 = randomintrange(12, 20);
    }
  }

  return var_0;
}

_id_451A(var_0) {
  var_1 = 5;
  var_2 = weaponburstcount(self._id_04F6);

  if(var_2) {
    var_3 = var_2;
  } else {
    var_3 = _id_C17D(var_1, var_0);
    var_3 = var_3 + randomintrange(-2, 3);
    var_3 = int(max(var_3, 1));
  }

  if(var_3 <= self._id_00CC) {
    return var_3;
  }

  if(self._id_00CC <= 0) {
    return 1;
  }

  return self._id_00CC;
}

_id_C17D(var_0, var_1) {
  var_2 = 62500;
  var_3 = 810000;
  var_4 = 1562500;
  var_5 = 2560000;
  var_6 = [var_2, var_3, var_4, var_5];

  foreach(var_8 in var_6) {
    if(var_1 > var_8) {
      var_0 = var_0 - 1;
    }
  }

  return var_0;
}