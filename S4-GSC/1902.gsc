/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1902.gsc
*************************************************/

_id_1041D() {
  var_0 = undefined;
  var_1 = undefined;

  for(;;) {
    level waittill("vision_set_change_request", var_0, var_1, var_2, var_3);

    if(!isDefined(var_0) && isDefined(var_3)) {
      if(!_func_0121(var_3)) {
        continue;
      }
      if(var_3 == "") {
        continue;
      }
      if(isDefined(var_1)) {
        if(!isPlayer(var_1)) {
          continue;
        }
        _id_C45C(var_1, var_3, var_2);
      } else {
        foreach(var_5 in level.players) {
          _id_C45C(var_5, var_3, var_2);
        }
      }

      continue;
    }

    if(!isDefined(var_0) || !_func_0121(var_0)) {
      continue;
    }
    if(isDefined(var_1)) {
      if(!isPlayer(var_1)) {
        continue;
      }
      if(var_0 == "") {
        _id_C45B(var_1, var_2);
      } else {
        _id_106E(var_1, var_0, var_2);
      }

      continue;
    }

    foreach(var_5 in level.players) {
      if(var_0 == "") {
        _id_C45B(var_5, var_2);
        continue;
      }

      _id_106E(var_5, var_0, var_2);
    }
  }
}

_id_3F8D(var_0) {
  var_0._id_10423 = [""];
  var_0._id_10422 = var_0._id_10423.size - 1;
  var_0._id_41A8 = var_0._id_10423[var_0._id_10422];
  var_0 visionsetnakedforplayer(var_0._id_41A8);
}

_id_106E(var_0, var_1, var_2) {
  var_0._id_AA24 = var_0._id_10423[var_0._id_10422];
  var_0._id_10423 = scripts\engine\utility::array_add(var_0._id_10423, var_1);
  var_0._id_10422 = var_0._id_10423.size - 1;
  var_0._id_41A8 = var_0._id_10423[var_0._id_10422];

  if(isDefined(var_2)) {
    var_0 visionsetnakedforplayer(var_0._id_41A8, var_2);
  } else {
    var_0 visionsetnakedforplayer(var_0._id_41A8);
  }
}

_id_C45B(var_0, var_1) {
  if(var_0._id_10422 <= 0) {} else {
    var_0._id_AA24 = var_0._id_10423[var_0._id_10422];
    var_0._id_10423 = scripts\engine\utility::array_remove_index(var_0._id_10423, var_0._id_10422);
    var_0._id_10422--;
    var_0._id_41A8 = var_0._id_10423[var_0._id_10422];
  }

  if(isDefined(var_1)) {
    var_0 visionsetnakedforplayer(var_0._id_41A8, var_1);
  } else {
    var_0 visionsetnakedforplayer(var_0._id_41A8);
  }
}

_id_C45C(var_0, var_1, var_2) {
  if(var_0._id_10422 > 0) {
    var_0._id_10423 = scripts\engine\utility::array_remove(var_0._id_10423, var_1);
    var_0._id_10422--;
    var_0._id_41A8 = var_0._id_10423[var_0._id_10422];
  }

  if(isDefined(var_2)) {
    var_0 visionsetnakedforplayer(var_0._id_41A8, var_2);
  } else {
    var_0 visionsetnakedforplayer(var_0._id_41A8);
  }
}