/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\134.gsc
**************************************/

_id_1455(var_0) {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();

  }
  level._id_1456._id_1457 = spawnStruct();
  level._id_1456._id_1457._id_1458 = 0;
  level._id_1456._id_1457._id_1459 = 0;
  level._id_1456._id_1457._id_145A = "";
}

_id_145B() {
  level._id_1456._id_1457._id_1458 = 1;
  level._id_1456._id_1457._id_1459 = 0;
}

_id_145C() {
  level._id_1456._id_1457._id_1459 = 1;
  level._id_1456._id_1457._id_1458 = 0;
}

_id_145D(var_0, var_1) {
  var_1 = clamp(var_1, 0, 1.0);
  var_0._id_145E = var_1;
}

_id_145F(var_0, var_1) {
  var_1 = clamp(var_1, 0, 1.0);
  var_0._id_1460 = var_1;
}

_id_1461(var_0, var_1) {
  if(!isDefined(level._id_1456._id_1457._id_1462) || level._id_1456._id_1457._id_1462 != var_0) {
    level._id_1456._id_1457._id_1462 = var_0;
    var_2 = undefined;

    if(isDefined(var_1)) {
      var_2 = var_1;
    } else {
      var_2 = var_0._id_1463;

    }
    level.player setreverb(var_0.priority, var_0._id_1464, var_0._id_145E, var_0._id_1460, var_2);
  }
}

_id_1465(var_0, var_1) {
  if(level.player maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    if(isDefined(var_0) && var_0 != "none") {
      var_2 = _id_1472(var_0);

      if(!isDefined(var_2)) {
        maps\_audio::_id_1466("Failed to load reverb preset: " + var_0);
        return;
      }

      if(var_0 != "deathsdoor") {
        _id_1468(var_0, var_2);
        level._id_1456._id_1467._id_1457 = var_0;
      }
    } else {
      _id_1468("none", undefined);
      level._id_1456._id_1467._id_1457 = "none";
    }

    return;
  }

  if((isDefined(var_0) && var_0 == "none" || !isDefined(var_0)) && isDefined(level._id_1456._id_145A)) {
    level.player deactivatereverb("snd_enveffectsprio_level", 1);
    level._id_1456._id_145A = undefined;
    level._id_1456._id_1457._id_145A = "";
    return;
  } else if(!isDefined(var_0) || isDefined(var_0) && var_0 == "none") {
    return;
  }
  var_2 = _id_1472(var_0);

  if(!isDefined(var_2)) {
    maps\_audio::_id_1466("Failed to load reverb preset: " + var_0);
    return;
  }

  level._id_1456._id_145A = var_0;

  if(var_0 != "deathsdoor") {
    _id_1468(var_0, var_2);

  }
  if(level._id_1456._id_1457._id_145A != var_0) {
    level._id_1456._id_1457._id_145A = var_0;
    _id_1461(var_2, var_1);
  }
}

_id_1468(var_0, var_1) {
  if(var_0 != "deathsdoor") {
    level._id_1469 = var_0;

    if(var_0 == "none" && !isDefined(level._id_146A["none"])) {
      level._id_146A["none"] = 1;
    } else if(!isDefined(level._id_146A[var_0])) {
      level._id_146A[var_0] = [];
      level._id_146A[var_0]["priority"] = "snd_enveffectsprio_level";
      level._id_146A[var_0]["roomtype"] = var_1._id_1464;
      level._id_146A[var_0]["drylevel"] = var_1._id_145E;
      level._id_146A[var_0]["wetlevel"] = var_1._id_1460;
      level._id_146A[var_0]["fadetime"] = var_1._id_1463;
    }
  }
}

_id_146B() {
  level._id_1469 = "";
  level.player deactivatereverb("snd_enveffectsprio_level", 2);
  level._id_1456._id_145A = undefined;
  level._id_1456._id_1457._id_145A = "";
}

_id_146C() {
  var_0 = undefined;

  if(isDefined(level._id_1456._id_1457._id_1462)) {
    var_0 = level._id_1456._id_1457._id_1462;

  }
  return var_0;
}

_id_146D(var_0, var_1) {
  var_2 = maps\_audio::_id_146E();
  var_3 = "soundtables/common_reverb.csv";
  var_4 = [];

  if(var_1) {
    var_4 = _id_146F(var_2, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = _id_146F(var_3, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

_id_146F(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = 6;

  for(var_6 = 1; var_6 < var_5; var_6++) {
    var_3 = tablelookup(var_0, 0, "reverb_names", var_6);
    var_4 = tablelookup(var_0, 0, var_1, var_6);

    if(var_3 != "comments" && var_4 != "") {
      if(var_3 != "roomtype") {
        var_2[var_3] = float(var_4);
        continue;
      }

      var_2[var_3] = var_4;
    }
  }

  return var_2;
}

_id_1470() {
  while(!isDefined(level.player)) {
    wait 0.5;

  }
  _id_1461(level._id_1456._id_1457._id_1471);
}

_id_1472(var_0) {
  if(!isDefined(level._id_1456._id_1457._id_1473)) {
    level._id_1456._id_1457._id_1473 = [];

  }
  var_1 = _id_1476();
  var_2 = [];

  if(isDefined(level._id_1456._id_1474)) {
    var_2 = [[level._id_1456._id_1474]](var_0, var_2);
  } else if(isDefined(level._id_1456._id_1457._id_1473[var_0])) {
    var_2 = level._id_1456._id_1457._id_1473[var_0];
  } else if(level._id_1456._id_1457._id_1458) {
    var_2 = _id_146D(var_0, 1);

    if(!isDefined(var_2)) {
      return;
    }
    level._id_1456._id_1457._id_1473[var_0] = var_2;
  } else {
    var_2 = _id_146D(var_0, 0);

    if(!isDefined(var_2) || var_2.size == 0) {
      var_2 = maps\_audio::_id_1475(var_0, var_2);

    }
    if(!isDefined(var_2)) {
      return;
    }
    level._id_1456._id_1457._id_1473[var_0] = var_2;
  }

  var_1.name = var_0;
  var_1._id_1464 = var_2["roomtype"];
  var_1._id_145E = var_2["drylevel"];
  var_1._id_1460 = var_2["wetlevel"];
  var_1._id_1463 = var_2["fadetime"];
  return var_1;
}

_id_1476() {
  var_0 = spawnStruct();
  var_0._id_1464 = "generic";
  var_0._id_145E = 1.0;
  var_0._id_1460 = 0.5;
  var_0._id_1463 = 0;
  var_0.priority = "snd_enveffectsprio_level";
  return var_0;
}