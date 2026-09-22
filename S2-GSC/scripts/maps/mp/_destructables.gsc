/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_destructables.gsc
**********************************************/

init() {
  var_0 = getEntArray("destructable", "targetname");

  if(getDvar("scr_destructables") == "0") {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] delete();
    }
  } else {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] thread _id_2DE1();
    }
  }
}

_id_2DE1() {
  var_0 = 40;
  var_1 = 0;

  if(isDefined(self.setwhizbyoffset)) {
    var_0 = self.setwhizbyoffset;
  }

  if(isDefined(self.stopmoveslide)) {
    var_1 = self.stopmoveslide;
  }

  if(isDefined(self.clearenemy)) {
    var_2 = strtok(self.clearenemy, " ");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      _id_17D7(var_2[var_3]);
    }
  }

  if(isDefined(self._id_81BB)) {
    self.fx = loadfx(self._id_81BB);
  }

  var_4 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_5, var_6);

    if(var_5 >= var_1) {
      var_4 = var_4 + var_5;

      if(var_4 >= var_0) {
        thread _id_2DE0();
        return;
      }
    }
  }
}

_id_2DE0() {
  var_0 = self;

  if(isDefined(self.clearenemy)) {
    var_1 = strtok(self.clearenemy, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      _id_A017(var_1[var_2]);
    }
  }

  if(isDefined(var_0.fx)) {
    playFX(var_0.fx, var_0.origin + (0, 0, 6));
  }

  var_0 delete();
}

_id_17D7(var_0) {}

_id_17E0(var_0, var_1) {}

_id_A017(var_0) {}

_id_A018(var_0, var_1) {}