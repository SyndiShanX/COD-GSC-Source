/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2004.gsc
*************************************************/

_id_CE2A() {
  if(!isDefined(self._id_CD65) || !isDefined(self._id_CD63) || !isDefined(self._id_0393)) {
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    var_0 = getent(self.target).origin;
  } else {
    var_0 = "undefined";
  }

  if(self._id_CD63 == "OneShotfx") {}

  if(self._id_CD63 == "loopfx") {}

  if(self._id_CD63 == "loopsound") {
    return;
  }
}

_id_7162(var_0) {
  playFX(level._effect["mechanical explosion"], var_0);
  earthquake(0.15, 0.5, var_0, 250);
}

_id_E063(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);

  if(isDefined(var_2)) {
    var_3 thread _id_E064(var_2);
  }
}

_id_E064(var_0) {
  level waittill(var_0);
  self delete();
}

_id_6021() {
  var_0 = [];
  var_1 = [];
  var_2 = getEntArray("vfx_custom_glass", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_039B)) {
      var_5 = _func_009F(var_4._id_039B);

      if(isDefined(var_5)) {
        var_1[var_5] = var_4;
        var_0[var_0.size] = var_5;
      }
    }
  }

  var_7 = var_0.size;
  var_8 = var_0.size;
  var_9 = 5;
  var_10 = 0;

  while(var_7 != 0) {
    var_11 = var_10 + var_9 - 1;

    if(var_11 > var_8) {
      var_11 = var_8;
    }

    if(var_10 == var_8) {
      var_10 = 0;
    }

    while(var_10 < var_11) {
      var_12 = var_0[var_10];
      var_4 = var_1[var_12];

      if(isDefined(var_4)) {
        if(_func_0111(var_12)) {
          var_4 delete();
          var_7--;
          var_1[var_12] = undefined;
        }
      }

      var_10++;
    }

    wait 0.05;
  }
}

_id_2557(var_0) {
  self waittill("death");
  var_0 delete();
}