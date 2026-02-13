/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2555.gsc
*************************************************/

_id_9546() {
  level endon("game_ended");
  level._id_3718 = 1;
  level._id_371F = [];
  level._id_3720 = [];
  level thread onplayerspawned();
  level thread _id_C14C();
  level thread _id_508D();
}

_id_508D() {
  level endon("game_ended");

  for(;;) {
    wait 1;
    _id_371E();
    level._id_3720 = [];
  }
}

_id_C14C() {
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    waitframe();
    _id_97AE(var_0);
    var_0++;
  }
}

_id_371D() {}

_id_371E() {}

onplayerspawned() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0._id_DA62 = [];
    var_0._id_79B3 = [];
    var_0 thread _id_10C32();
  }
}

_id_10C32(var_0) {
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_2 = spawnStruct();
    var_2._id_106B7 = self.origin;
    var_2._id_FFD4 = self _meth_8599();
    self._id_DA62[self._id_DA62.size] = var_2;
  }
}

_id_97AE(var_0) {
  var_1 = level.players;
  var_2 = [];
  var_3 = gettime();
  var_4 = "";

  if(var_1.size == 0) {
    return;
  }
  var_5 = int(4);
  var_6 = int(_func_0037(var_1.size / var_5));
  var_7 = int(var_0 % var_6);

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = var_7 * var_5 + var_8;

    if(var_9 >= var_1.size) {
      break;
    }

    var_10 = var_1[var_9];

    if(isDefined(var_10) && scripts\mp\utility\player::isreallyalive(var_10)) {
      var_4 = var_4 + ("T " + var_10 getentitynumber() + " " + var_10.team + " ");
      var_11 = int(var_10.origin[0]) + "," + int(var_10.origin[1]) + "," + int(var_10.origin[2]);
      var_12 = int(var_10.angles[0]) + "," + int(var_10.angles[1]) + "," + int(var_10.angles[2]);
      var_2[var_2.size] = "P " + var_3 + " " + var_10 getentitynumber() + " " + var_11 + " " + var_12 + " ";

      if(isDefined(var_10._id_79B3)) {
        foreach(var_14 in var_10._id_79B3) {
          var_15 = int(var_14._id_106B7[0]) + "," + int(var_14._id_106B7[1]) + "," + int(var_14._id_106B7[2]);
          var_16 = int(var_14._id_FFD4[0]) + "," + int(var_14._id_FFD4[1]) + "," + int(var_14._id_FFD4[2]);
          var_2[var_2.size - 1] = var_2[var_2.size - 1] + ("H " + var_3 + " " + var_10 getentitynumber() + " " + var_14._id_103C2 getentitynumber() + " " + var_15 + " " + var_16 + " " + var_14._id_8CFF + " ");
        }

        var_10._id_79B3 = [];
      }

      if(isDefined(var_10._id_DA62)) {
        foreach(var_19 in var_10._id_DA62) {
          var_15 = int(var_19._id_106B7[0]) + "," + int(var_19._id_106B7[1]) + "," + int(var_19._id_106B7[2]);
          var_16 = int(var_19._id_FFD4[0]) + "," + int(var_19._id_FFD4[1]) + "," + int(var_19._id_FFD4[2]);
          var_2[var_2.size - 1] = var_2[var_2.size - 1] + ("S " + var_3 + " " + var_10 getentitynumber() + " " + var_15 + " " + var_16 + " ");
        }

        var_10._id_DA62 = [];
      }

      var_2[var_2.size - 1] = var_2[var_2.size - 1] + "\n";
      level._id_371F[level._id_371F.size] = var_2[var_2.size - 1];
    }
  }

  if(level._id_371F.size > 50) {
    var_21 = var_4;

    foreach(var_23 in level._id_371F) {
      var_21 = var_21 + var_23;
    }

    level._id_371F = [];
    level._id_3720[level._id_3720.size] = var_21;
  }
}