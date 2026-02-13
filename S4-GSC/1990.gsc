/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1990.gsc
*************************************************/

init() {
  var_0 = getEntArray("destructable", "targetname");

  if(getDvar("#x3208394a84c38a7b8") == "0") {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] delete();
    }
  } else {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] thread _id_486B();
    }
  }
}

_id_486B() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self._id_CC8B)) {
    var_0 = self._id_CC8B;
  }

  if(isDefined(self._id_CE82)) {
    var_1 = self._id_CE82;
  }

  if(isDefined(self._id_CD06)) {
    var_2 = strtok(self._id_CD06, " ");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      _id_258C(var_2[var_3]);
    }
  }

  if(isDefined(self._id_CD65)) {
    self._id_605B = loadfx(self._id_CD65);
  }

  var_4 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_5, var_6);

    if(var_5 >= var_1) {
      var_4 = var_4 + var_5;

      if(var_4 >= var_0) {
        thread _id_486A();
        return;
      }
    }
  }
}

_id_486A() {
  var_0 = self;

  if(isDefined(self._id_CD06)) {
    var_1 = strtok(self._id_CD06, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      _id_F932(var_1[var_2]);
    }
  }

  if(isDefined(var_0._id_605B)) {
    playFX(var_0._id_605B, var_0.origin + (0, 0, 6));
  }

  var_0 delete();
}

_id_258C(var_0) {}

_id_2590(var_0, var_1) {}

_id_F932(var_0) {}

_id_F933(var_0, var_1) {}