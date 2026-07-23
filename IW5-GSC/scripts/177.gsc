/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\177.gsc
**************************************/

_id_15B4() {
  setsaveddvar("snd_newWhizby", 1);
  level._id_1456._id_15B5 = spawnStruct();
  level._id_1456._id_15B5._id_1458 = 0;
}

_id_15B6() {
  level._id_1456._id_15B5._id_1458 = 1;
}

_id_15B7(var_0) {
  var_1 = [];

  if(level._id_1456._id_15B5._id_1458) {
    var_1 = _id_15BD(var_0);
  } else {
    var_1 = maps\_audio::_id_15B8(var_0, var_1);
  }
  var_1["name"] = var_0;
  var_2 = var_1["probability"];
  var_3 = var_1["spread"];
  var_4 = var_1["radius"];
  var_5 = var_1["offset"];
  level.player setwhizbyprobabilities(var_2[0], var_2[1], var_2[2]);
  level.player setwhizbyspreads(var_3[0], var_3[1], var_3[2]);
  level.player setwhizbyradii(var_4[0], var_4[1], var_4[2]);
  level.player setwhizbyoffset(var_5);
}

_id_15B9(var_0, var_1, var_2) {
  level.player setwhizbyprobabilities(var_0, var_1, var_2);
}

_id_15BA(var_0, var_1, var_2) {
  level.player setwhizbyspreads(var_0, var_1, var_2);
}

_id_15BB(var_0, var_1, var_2) {
  level.player setwhizbyradii(var_0, var_1, var_2);
}

_id_15BC(var_0) {
  level.player setwhizbyoffset(var_0);
}

_id_15BD(var_0) {
  var_1 = "soundtables/common_whizby.csv";
  var_2 = [];
  var_2 = _id_15BE(var_1, var_0);
  return var_2;
}

_id_15BE(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = 12;
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = 0;
  var_10 = 0;

  for(var_11 = 1; var_11 < var_5; var_11++) {
    var_3 = tablelookup(var_0, 0, "whizby_preset", var_11);
    var_4 = tablelookup(var_0, 0, var_1, var_11);

    if(!isDefined(var_4)) {
      break;
    }

    if(var_4 != "" && var_4 != "comments") {
      var_10++;

      switch (var_3) {
        case "radius_offset":
          var_9 = float(var_4);
          break;
        case "near_radius":
          var_6[0] = float(var_4);
          break;
        case "medium_radius":
          var_6[1] = float(var_4);
          break;
        case "far_radius":
          var_6[2] = float(var_4);
          break;
        case "near_spread":
          var_7[0] = float(var_4);
          break;
        case "medium_spread":
          var_7[1] = float(var_4);
          break;
        case "far_spread":
          var_7[2] = float(var_4);
          break;
        case "near_prob":
          var_8[0] = float(var_4);
          break;
        case "medium_prob":
          var_8[1] = float(var_4);
          break;
        case "far_prob":
          var_8[2] = float(var_4);
          break;
      }
    }
  }

  if(var_10 > 0) {
    var_2["radius"] = var_6;
    var_2["spread"] = var_7;
    var_2["probability"] = var_8;

    if(isDefined(var_9)) {
      var_2["offset"] = var_9;
    }
  }

  return var_2;
}