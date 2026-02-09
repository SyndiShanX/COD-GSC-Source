/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1360.gsc
**************************************/

main() {
  level._id_40B7 = [];
}

_id_40B8(var_0, var_1) {
  if(1) {
    return spawnStruct();
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_2 = newhudelem();
  var_2.alignx = "right";
  var_2.aligny = "top";
  var_2.horzalign = "right";
  var_2.vertalign = "top";
  var_2.alpha = 0;
  var_2.index = level._id_40B7.size;
  var_2._id_40B9 = var_1;
  var_2 setshader(var_0, 40, 40);
  level._id_40B7[var_2.index] = var_2;
  _id_40BC();
  return var_2;
}

_id_40BA() {
  if(1) {
    return;
  }
  self._id_40B9 = 0;
  _id_40BC();
}

_id_40BB() {
  if(1) {
    return;
  }
  self._id_40B9 = 1;
  _id_40BC();
}

_id_40BC() {
  if(1) {
    return;
  }
  var_0 = -18;
  var_1 = 8;
  var_2 = 42;
  var_3 = 0;

  for(var_4 = 0; var_4 < level._id_40B7.size; var_4++) {
    if(level._id_40B7[var_4]._id_40B9) {
      var_5 = var_1 + var_2 * var_3;

      if(var_5 != level._id_40B7[var_4].y) {
        level._id_40B7[var_4].x = var_0;

        if(level._id_40B7[var_4].alpha != 0) {
          level._id_40B7[var_4] moveovertime(0.3);
        }
        level._id_40B7[var_4].y = var_5;
      }

      if(level._id_40B7[var_4].alpha != 1) {
        level._id_40B7[var_4] fadeovertime(0.3);
        level._id_40B7[var_4].alpha = 1;
      }

      var_3++;
      continue;
    }

    level._id_40B7[var_4] fadeovertime(0.3);
    level._id_40B7[var_4].alpha = 0;
  }
}

_id_40BD() {
  if(1) {
    return;
  }
  self destroy();
  var_0 = 0;
  var_1 = level._id_40B7;
  level._id_40B7 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2])) {
      level._id_40B7[level._id_40B7.size] = var_1[var_2];
    }
  }

  _id_40BC();
}