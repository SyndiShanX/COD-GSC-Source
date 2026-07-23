/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\176.gsc
**************************************/

_id_15A1() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();
  }
  level._id_1456._id_1479 = spawnStruct();
  level._id_1456._id_1479._id_15A2 = [];
  level._id_1456._id_1479._id_15A3 = "";
  level._id_1456._id_1479._id_15A4 = "";
  level._id_1456._id_1479._id_15A5 = 0;
  level._id_1456._id_1479._id_15A6 = [[0.0, 0.5], [0.9, 1.0], [1.0, 1.0]];
  thread _id_15B1();
}

_id_15A7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = _id_15AA();
  var_7 = _id_15AB(var_0);
  var_8 = var_7["fade_in_time"];

  if(isDefined(var_1)) {
    var_8 = var_1;
  }
  var_9 = 2.0;

  if(isDefined(var_6)) {
    if(isDefined(var_2)) {
      var_9 = var_2;
    } else if(isDefined(var_1)) {
      var_9 = var_1;
    } else if(isDefined(var_6["fade_out_time"])) {
      var_9 = var_6["fade_out_time"];
    }
  }

  var_10 = var_7["volume"];

  if(isDefined(var_3)) {
    var_10 = var_3;
  }
  _id_15AC(var_7["name"], var_8, var_9, var_10, var_4);
}

_id_15A8(var_0) {
  var_1 = 3.0;

  if(_id_15A9()) {
    var_2 = _id_15AF(level._id_1456._id_1479._id_15A3);
    var_1 = var_2["fade_out_time"];
  }

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  _id_15AD(var_1);
}

_id_15A9() {
  return isDefined(level._id_1456._id_1479._id_15A3) && level._id_1456._id_1479._id_15A3 != "";
}

_id_15AA() {
  var_0 = undefined;

  if(_id_15A9()) {
    var_0 = _id_15AF(level._id_1456._id_1479._id_15A3);
  }
  return var_0;
}

_id_15AB(var_0) {
  var_1 = _id_15AF(var_0);

  if(!isDefined(var_1)) {
    var_1 = [];
    var_1["alias"] = var_0;
    var_1["volume"] = 1.0;
    var_1["fade_in_time"] = 1.5;
    var_1["fade_out_time"] = 1.5;
    var_1["auto_mix"] = 0;
    var_1["name"] = var_0;
    _id_15B0(var_1);
  }

  return var_1;
}

_id_15AC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }
  if(var_0 == level._id_1456._id_1479._id_15A3 && !var_5) {
    return;
  } else {
    var_6 = level._id_1456._id_1479._id_15A4;
    var_7 = level._id_1456._id_1479._id_15A3;
    level._id_1456._id_1479._id_15A4 = level._id_1456._id_1479._id_15A3;
    level._id_1456._id_1479._id_15A3 = var_0;
    var_8 = _id_15AF(level._id_1456._id_1479._id_15A3);
    var_9 = _id_15AF(level._id_1456._id_1479._id_15A4);
    var_10 = undefined;

    if(isDefined(var_9)) {
      var_10 = var_9["alias"];
    }
    maps\_audio_stream_manager::_id_1480(var_8["alias"], var_1, var_2, var_3, var_10);
  }
}

_id_15AD(var_0) {
  maps\_audio_stream_manager::_id_1484(var_0);
}

_id_15AE() {
  return level._id_1456._id_1479._id_15A5;
}

_id_15AF(var_0) {
  return level._id_1456._id_1479._id_15A2[var_0];
}

_id_15B0(var_0) {
  level._id_1456._id_1479._id_15A2[var_0["name"]] = var_0;
}

_id_15B1() {
  if(_id_15AE()) {
    var_0 = 1.0;

    for(;;) {
      wait(var_0);

      if(_id_15AE()) {
        var_1 = maps\_audio::_id_15B2();
        var_2 = maps\_audio::_id_15B3(var_1, level._id_1456._id_1479._id_15A6);
      }
    }
  }
}