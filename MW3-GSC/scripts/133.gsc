/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\133.gsc
**************************************/

_id_148C() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();

  }
  if(!isDefined(level._id_1456._id_148D)) {
    level._id_1456._id_148D = spawnStruct();
    level._id_1456._id_148D._id_148E = 0;
    level._id_1456._id_148D._id_148F = 0;
    level._id_1456._id_148D._id_1490 = 0;
    level._id_1456._id_148D._id_1491 = 1;
    level._id_1456._id_148D._id_1492 = [];
    level._id_1456._id_148D._id_1492["zone"] = [];
    level._id_1456._id_148D._id_1492["free"] = [];
    level._id_1456._id_148D._id_1493 = [];
    level._id_1456._id_148D._id_1494 = [];
    level._id_1456._id_148D._id_1473 = [];
    level._id_1456._id_148D._id_1495 = [];
    level._id_1456._id_148D._id_1496 = [];
    level._id_1456._id_148D._id_1458 = 0;
    level._id_1456._id_148D._id_1459 = 0;
    level._id_1456._id_148D._id_1497 = 0;
    level._id_1456._id_148D._id_1498 = 0;
    level._id_1456._id_148D._id_1499 = 15;
  }
}

_id_149A(var_0) {
  level._id_1456._id_148D._id_1499 = var_0;
}

_id_149B() {
  level._id_1456._id_148D._id_1458 = 1;
  level._id_1456._id_148D._id_1459 = 0;
}

_id_149C() {
  level._id_1456._id_148D._id_1459 = 1;
  level._id_1456._id_148D._id_1458 = 0;
}

_id_149D(var_0, var_1) {
  _id_14B3("zone", var_0, undefined, var_1);
}

_id_149E(var_0, var_1, var_2, var_3) {
  _id_14B3("free", var_0, var_1, var_2, undefined, undefined, var_3);
}

_id_149F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    thread _id_14A4(var_0, var_1, var_2, var_3, var_4, var_5);
  } else {
    _id_14B3("free", var_0, var_2, undefined, var_1, var_5);
  }
}

_id_14A0(var_0, var_1, var_2) {
  if(isstring(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = var_0;

  }
  level notify(var_3 + "dist_monitor_stop");
  _id_14A9(var_3, var_2);
}

_id_14A1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.name = var_0;
  var_5.point = var_1;
  var_5.label = var_2;
  var_5._id_14A2 = var_3;
  var_5._id_14A3 = var_4;
  return var_5;
}

_id_14A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isstring(var_2)) {
    level endon(var_2 + "dist_monitor_stop");
  } else {
    level endon(var_0 + "dist_monitor_stop");

  }
  var_6 = 1.0;

  if(isDefined(var_4)) {
    var_6 = var_4;

  }
  var_7 = 1;

  for(;;) {
    var_8 = distance(level.player.origin, var_1);

    if(var_8 < var_3) {
      if(var_7) {
        var_7 = 0;
        _id_14B3("free", var_0, var_2, undefined, var_1, var_5);
      }
    } else if(!var_7) {
      var_7 = 1;

      if(isDefined(var_2)) {
        _id_14B5("free", var_2, var_6);
      } else {
        _id_14B5("free", var_0, var_6);
      }
    }

    wait 1;
  }
}

_id_14A5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "attach";

  if(isDefined(var_3)) {
    var_5 = var_3;

  }
  _id_14B3("free", var_0, var_2, var_4, undefined, var_1, var_5);
}

_id_14A6(var_0, var_1) {
  var_2 = 2.0;

  if(isDefined(var_0)) {
    var_2 = var_0;

  }
  var_3 = "all";

  if(isDefined(var_1)) {
    var_3 = var_1;

  }
  if(var_3 == "free" || var_3 == "all") {
    foreach(var_6, var_5 in level._id_1456._id_148D._id_1492["free"]) {}
    _id_14A9(var_6, var_2);
  }

  if(var_3 == "zone" || var_3 == "all") {
    foreach(var_6, var_5 in level._id_1456._id_148D._id_1492["zone"]) {}
    _id_14A8(var_6, var_2);
  }
}

_id_14A7(var_0) {
  _id_14B5("zone", undefined, var_0);
}

_id_14A8(var_0, var_1) {
  _id_14B5("zone", var_0, var_1);
}

_id_14A9(var_0, var_1) {
  _id_14B5("free", var_0, var_1);
}

_id_14AA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 != "none") {
    if(var_1 == 0) {
      _id_14A8(var_0, 2.0);
    } else {
      _id_149D(var_0, var_1);
    }
  }

  if(isDefined(var_2) && var_2 != "none") {
    if(var_3 == 0) {
      _id_14A8(var_2, 2.0);
    } else {
      _id_149D(var_2, var_3);
    }
  }
}

_id_14AB(var_0, var_1) {
  if(!isDefined(level._id_1456._id_148D.callback)) {
    level._id_1456._id_148D.callback = [];

  }
  level._id_1456._id_148D.callback[var_0] = var_1;
}

_id_14AD(var_0, var_1) {
  var_2 = [];

  if(isDefined(level._id_1456._id_148D._id_1473[var_0])) {
    var_2 = level._id_1456._id_148D._id_1473[var_0];
  } else if(level._id_1456._id_148D._id_1458) {
    var_2 = _id_14F7(var_0, 1);
    level._id_1456._id_148D._id_1473[var_0] = var_2;
  } else {
    var_2 = _id_14F7(var_0, 0);

    if(var_2.size == 0) {
      var_2 = maps\_audio::_id_14AE(var_0, var_2);

    }
    level._id_1456._id_148D._id_1473[var_0] = var_2;
  }

  foreach(var_4 in var_2["components"]) {}
  _id_14AB(var_4, var_1);
}

_id_14AF(var_0, var_1) {
  var_2 = "free";

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  if(isDefined(level._id_1456._id_148D._id_1492[var_2][var_0])) {
    level._id_1456._id_148D._id_1492[var_2][var_0]["paused"] = 1;
  }
}

_id_14B0(var_0, var_1) {
  var_2 = "free";

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  if(isDefined(level._id_1456._id_148D._id_1492[var_2][var_0])) {
    level._id_1456._id_148D._id_1492[var_2][var_0]["paused"] = 0;
    level notify(var_2 + "_" + var_0 + "_event");
  }
}

_id_14B1(var_0, var_1) {
  var_2 = "free";

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  if(isDefined(level._id_1456._id_148D._id_1492[var_2][var_0])) {
    level notify(var_2 + "_" + var_0 + "_event");
  }
}

_id_14B2(var_0, var_1, var_2, var_3) {
  var_4 = "free";

  if(isDefined(level._id_1456._id_148D._id_1492[var_4][var_0]) && isDefined(level._id_1456._id_148D._id_1492[var_4][var_1])) {
    var_2 = min(var_2, var_3);
    var_3 = max(var_2, var_3);

    if(!isDefined(level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"])) {
      level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"] = [];

    }
    var_5 = level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"].size;
    level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"][var_5] = spawnStruct();
    level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"][var_5].name = var_1;
    level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"][var_5]._id_14A2 = max(var_2, 0);
    level._id_1456._id_148D._id_1492[var_4][var_0]["linked_dambs"][var_5]._id_14A3 = max(var_3, 0);
  }
}

_id_14B3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 1.0;

  if(isDefined(var_3)) {
    var_8 = var_3;

  }
  var_9 = var_1;

  if(isstring(var_2)) {
    var_9 = var_2;

  }
  if(!isDefined(level._id_1456._id_148D._id_1492[var_0][var_9])) {
    var_10 = _id_14F9(var_1);

    if(!isDefined(var_10)) {
      return;
    }
    level._id_1456._id_148D._id_1492[var_0][var_9] = var_10;
    level._id_1456._id_148D._id_1492[var_0][var_9]["prob_scale"] = var_8;
    level._id_1456._id_148D._id_1492[var_0][var_9]["paused"] = 0;

    if(isDefined(var_7)) {
      _id_14B4(var_9, var_7);

    }
    if(isDefined(var_5)) {
      level._id_1456._id_148D._id_1492[var_0][var_9]["entity"] = var_5;
      level._id_1456._id_148D._id_1492[var_0][var_9]["mode"] = var_6;
    }

    thread _id_14EB(var_0, var_9, var_4);
  } else if(level._id_1456._id_148D._id_1492[var_0][var_9]["prob_scale"] != var_8) {
    level._id_1456._id_148D._id_1492[var_0][var_9]["prob_scale"] = var_8;
  }
}

_id_14B4(var_0, var_1) {
  if(isarray(var_1)) {
    foreach(var_3 in var_1) {
      _id_14B3("free", var_3.name, var_3.label, undefined, var_3.point);
      _id_14AF(var_3.label);
      _id_14B2(var_0, var_3.label, var_3._id_14A2, var_3._id_14A3);
    }
  } else {
    _id_14B3("free", var_1.name, var_1.label, undefined, var_1.point);
    _id_14AF(var_1.label);
    _id_14B2(var_0, var_1.label, var_1._id_14A2, var_1._id_14A3);
  }
}

_id_14B5(var_0, var_1, var_2) {
  var_3 = 2.0;

  if(isDefined(var_2)) {
    var_3 = var_2;

  }
  if(var_0 == "zone" && !isDefined(var_1)) {
    if(isDefined(level._id_1456._id_148D._id_1492[var_0])) {
      foreach(var_1, var_5 in level._id_1456._id_148D._id_1492[var_0]) {
        level._id_1456._id_148D._id_1492[var_0][var_1]["fade"] = var_3;
        level notify(var_0 + "_" + var_1 + "_stop");
      }
    }
  } else if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1])) {
    level._id_1456._id_148D._id_1492[var_0][var_1]["fade"] = var_3;
    level notify(var_0 + "_" + var_1 + "_stop");
  }
}

_id_14B6(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 = level._id_1456._id_148D._id_1492[var_0][var_1]["event_time"];
  var_4 = min(var_3[0], var_3[1]);
  var_5 = max(var_3[0], var_3[1]);
  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["first_event"])) {
    var_3 = level._id_1456._id_148D._id_1492[var_0][var_1]["first_event"];
    var_6 = min(var_3[0], var_3[1]);
    var_7 = max(var_3[0], var_3[1]);
  }

  var_8 = undefined;

  if(isDefined(var_6)) {
    var_8 = randomfloatrange(var_6, var_7);
  } else {
    var_8 = randomfloatrange(var_4, var_5);

  }
  for(;;) {
    if(level._id_1456._id_148D._id_1492[var_0][var_1]["paused"]) {
      level waittill(var_0 + "_" + var_1 + "_event");

    }
    if(!level._id_1456._id_148D._id_1492[var_0][var_1]["paused"]) {
      wait(var_8);

    }
    var_9 = _id_14E5(var_0, var_1);

    if(!isDefined(var_9)) {
      continue;
    }
    var_10 = _id_14BC(var_0, var_1, var_9, var_1);

    if(var_10._id_14B7) {
      if(var_10._id_14B8 && !isDefined(var_10._id_14B9)) {
        level notify(var_0 + "_" + var_1 + "_stop");
        break;
      }

      var_11 = _id_14D4(var_10, var_1, var_9);

      if(var_11._id_14BA) {
        if(level._id_1456._id_148D._id_1491) {
          _id_14DF(var_0, var_1, var_11);
        } else {
          thread _id_14DF(var_0, var_1, var_11);
        }
      }
    } else {
      maps\_audio::_id_1466("Dynamic ambience is playing back serially and using components which do not define oneshots or loops");

    }
    var_8 = randomfloatrange(var_4, var_5);
  }
}

_id_14BB(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2["single_loops"])) {
    foreach(var_6 in var_2["single_loops"]) {
      var_7 = undefined;

      if(isDefined(var_4)) {
        var_7 = spawn("script_origin", var_4.origin);
      } else if(isDefined(var_3)) {
        var_7 = spawn("script_origin", var_3);
      } else {
        var_7 = spawn("script_origin", level.player.origin);

      }
      level._id_1456._id_148D._id_1498++;
      var_7 playLoopSound(var_6);

      if(isDefined(var_4)) {
        var_7 linkto(var_4);

      }
      var_8 = level._id_1456._id_148D._id_148F;
      level._id_1456._id_148D._id_1492[var_0][var_1]["single_loops"][var_8] = var_7;
      level._id_1456._id_148D._id_148F++;
    }
  }
}

_id_14BC(var_0, var_1, var_2, var_1) {
  var_3 = spawnStruct();
  var_3._id_14B7 = 0;

  if(!isDefined(var_2["single_loops"])) {
    var_3._id_14BD = 0;
  } else {
    var_3._id_14BD = 1;

  }
  if(isDefined(var_2["oneshots"]) || isDefined(var_2["loops"])) {
    var_3._id_14B7 = 1;

    if(!isDefined(var_2["radius"])) {
      var_2["radius"] = [0.0, 0.01];

    }
    var_3._id_14BE = min(var_2["radius"][0], var_2["radius"][1]);
    var_3._id_14BF = max(var_2["radius"][0], var_2["radius"][1]);

    if(isarray(var_2["event_time"])) {
      var_3._id_14C0 = min(var_2["event_time"][0], var_2["event_time"][1]);
      var_3._id_14C1 = max(var_2["event_time"][0], var_2["event_time"][1]);
    }

    if(isarray(var_2["first_event"])) {
      var_3._id_14C2 = 1;
      var_3._id_14C3 = min(var_2["first_event"][0], var_2["first_event"][1]);
      var_3._id_14C4 = max(var_2["first_event"][0], var_2["first_event"][1]);
    }

    if(isarray(var_2["pitch"])) {
      var_3._id_14C5 = min(var_2["pitch"][0], var_2["pitch"][1]);
      var_3._id_14C6 = max(var_2["pitch"][0], var_2["pitch"][1]);
    }

    if(isarray(var_2["travel_time"])) {
      var_3._id_14C7 = min(var_2["travel_time"][0], var_2["travel_time"][1]);
      var_3._id_14C8 = max(var_2["travel_time"][0], var_2["travel_time"][1]);

      if(isarray(var_2["delta"])) {
        var_3._id_14C9 = min(var_2["delta"][0], var_2["delta"][1]);
        var_3._id_14CA = max(var_2["delta"][0], var_2["delta"][1]);
      } else {
        var_3._id_14CB = min(var_2["delta_angle"][0], var_2["delta_angle"][1]);
        var_3._id_14CC = max(var_2["delta_angle"][0], var_2["delta_angle"][1]);
      }
    }

    if(isarray(var_2["pitch_time"])) {
      var_3._id_14CD = min(var_2["pitch_time"][0], var_2["pitch_time"][1]);
      var_3._id_14CE = max(var_2["pitch_time"][0], var_2["pitch_time"][1]);
    }

    if(isDefined(var_2["cone"])) {
      var_3._id_14CF = min(var_2["cone"][0], var_2["cone"][1]);
      var_3._id_14D0 = max(var_2["cone"][0], var_2["cone"][1]);
    }
  } else {
    var_3._id_14B7 = 0;

  }
  var_3._id_14B8 = 0;

  if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["entity"])) {
    var_3._id_14B8 = 1;
    var_3._id_14B9 = level._id_1456._id_148D._id_1492[var_0][var_1]["entity"];
    var_3.mode = level._id_1456._id_148D._id_1492[var_0][var_1]["mode"];
  }

  var_3._id_14D2 = level._id_1456._id_148D._id_1492[var_0][var_1]["prob_scale"];
  return var_3;
}

_id_14D3(var_0, var_1, var_2) {
  for(;;) {
    if(!isDefined(var_2)) {
      level notify(var_0 + "_" + var_1 + "_stop");

    }
    wait 1.0;
  }
}

_id_14D4(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(randomfloat(1.0) < var_0._id_14D2) {
    var_4._id_14BA = 1;

    if(isDefined(level._id_1456._id_148D._id_1494[var_1])) {
      thread[[level._id_1456._id_148D.callback[var_1]]]();
    } else {
      var_4._id_1486 = _id_14E6(var_2);
      var_4.point = var_3;
      var_4._id_14B9 = var_0._id_14B9;
      var_4.mode = var_0.mode;
      var_5 = randomfloatrange(var_0._id_14BE, var_0._id_14BF);
      var_6 = undefined;

      if(isDefined(var_0._id_14CF)) {
        var_6 = randomfloatrange(var_0._id_14CF, var_0._id_14D0);
      } else {
        var_6 = randomfloatrange(0, 360);

      }
      var_7 = var_5 * cos(var_6);
      var_8 = var_5 * sin(var_6);
      var_4._id_14D5 = (var_7, var_8, 0);

      if(isDefined(var_0._id_14C7)) {
        var_4._id_14D6 = randomfloatrange(var_0._id_14C7, var_0._id_14C8);

        if(isDefined(var_0._id_14C9)) {
          var_5 = randomfloatrange(var_0._id_14C9, var_0._id_14CA);
          var_6 = randomfloatrange(0, 360);
          var_7 = var_5 * cos(var_6);
          var_8 = var_5 * sin(var_6);
          var_4._id_14D7 = var_4._id_14D5 + (var_7, var_8, 0);
        } else {
          var_9 = randomfloatrange(var_0._id_14CB, var_0._id_14CC);
          var_9 = var_9 * 0.5;
          var_10 = level.player.origin;

          if(isDefined(var_3)) {
            var_10 = var_3;

          }
          var_11 = var_4._id_14D5 - var_10;
          var_7 = var_11[0] * cos(var_9) - var_11[1] * sin(var_9);
          var_8 = var_11[0] * sin(var_9) + var_11[1] * cos(var_9);
          var_4._id_14D7 = var_4._id_14D5 + (var_7, var_8, 0);
        }
      }

      if(isDefined(var_0._id_14C5)) {
        var_4._id_14D8 = randomfloatrange(var_0._id_14C5, var_0._id_14C6);

      }
      if(isDefined(var_0._id_14CD)) {
        var_4._id_14D9 = randomfloatrange(var_0._id_14C5, var_0._id_14C6);
        var_4._id_14DA = randomfloatrange(var_0._id_14CD, var_0._id_14CE);
      }
    }
  } else {
    var_4._id_14BA = 0;

  }
  return var_4;
}

_id_14DB(var_0, var_1) {
  wait(var_1);
  _id_14B1(var_0);
}

_id_14DC(var_0) {
  var_1 = undefined;

  if(isDefined(var_0._id_14C2)) {
    var_1 = randomfloatrange(var_0._id_14C3, var_0._id_14C4);
  } else {
    var_1 = randomfloatrange(var_0._id_14C0, var_0._id_14C1);

  }
  return var_1;
}

_id_14DD(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_4 = _id_14BC(var_0, var_1, var_2, var_1);

  if(var_4._id_14BD) {
    _id_14BB(var_0, var_1, var_2, var_3, var_4._id_14B9);

    if(var_4._id_14B8 && !var_4._id_14B7) {
      thread _id_14D3(var_0, var_1, var_4._id_14B9);
    }
  }

  if(var_4._id_14B7) {
    var_5 = _id_14DC(var_4);

    for(;;) {
      if(level._id_1456._id_148D._id_1492[var_0][var_1]["paused"]) {
        level waittill(var_0 + "_" + var_1 + "_event");

      }
      if(!level._id_1456._id_148D._id_1492[var_0][var_1]["paused"]) {
        wait(var_5);

      }
      if(var_4._id_14B8 && !isDefined(var_4._id_14B9)) {
        level notify(var_0 + "_" + var_1 + "_stop");
        break;
      }

      if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["linked_dambs"])) {
        foreach(var_7 in level._id_1456._id_148D._id_1492[var_0][var_1]["linked_dambs"]) {
          var_8 = randomfloatrange(var_7._id_14A2, var_7._id_14A3);
          thread _id_14DB(var_7.name, var_8);
        }
      }

      var_4._id_14D2 = level._id_1456._id_148D._id_1492[var_0][var_1]["prob_scale"];
      var_10 = _id_14D4(var_4, var_1, var_2, var_3);

      if(var_10._id_14BA) {
        thread _id_14DF(var_0, var_1, var_10);

      }
      var_5 = randomfloatrange(var_4._id_14C0, var_4._id_14C1);
    }
  }
}

_id_14DE(var_0, var_1, var_2, var_3) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 waittill("sounddone");

  if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"][var_2])) {
    var_3 delete();
    _id_14FB();
    level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"][var_2] = undefined;
  }
}

_id_14DF(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");

  if(var_2._id_1486["type"] == "loop") {
    _id_14E3(var_0, var_1, var_2);
  } else {
    _id_14E0(var_0, var_1, var_2);
  }
}

_id_14E0(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");
  var_3 = level.player.origin;

  if(isDefined(var_2._id_14B9)) {
    var_3 = var_2._id_14B9.origin;
  } else if(isDefined(var_2.point)) {
    var_3 = var_2.point;

  }
  if(level._id_1456._id_148D._id_1497 < level._id_1456._id_148D._id_1499) {
    var_4 = spawn("script_origin", var_3 + var_2._id_14D5);

    if(isDefined(var_2._id_14B9) && var_2.mode == "attach") {
      var_4 linkto(var_2._id_14B9);

    }
    var_4 playSound(var_2._id_1486["name"], "sounddone");
    var_4 thread maps\_audio::_id_14E1();

    if(!var_4._id_14E2) {
      var_5 = level._id_1456._id_148D._id_1490;
      level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"][var_5] = var_4;
      level._id_1456._id_148D._id_1490++;
      _id_14FA();

      if(isDefined(var_2._id_14D7) && !isDefined(var_2.entity)) {
        var_6 = 0.1 * var_2._id_14D6;
        var_4 moveto(var_3 + var_2._id_14D7, var_2._id_14D6, var_6, var_6);
      }

      if(isDefined(var_2._id_14D8)) {
        var_4 scalepitch(var_2._id_14D8);

      }
      if(isDefined(var_2._id_14DA)) {
        wait 0.05;

        if(isDefined(var_4) && !var_4._id_14E2) {
          var_4 scalepitch(var_2._id_14D9, var_2._id_14DA);
        }
      }

      thread _id_14DE(var_0, var_1, var_5, var_4);
      var_4 waittill("sounddone");
      return;
    }

    var_4 delete();
    return;
  } else {
    maps\_audio::_id_1466("TRYING TO PLAY ONESHOT WITH DAMB REF COUNT AT MAXIMUM!");
  }
}

_id_14E3(var_0, var_1, var_2) {
  level endon(var_0 + "_" + var_1 + "_stop");

  if(level._id_1456._id_148D._id_1497 < level._id_1456._id_148D._id_1499) {
    var_3 = level.player.origin;

    if(isDefined(var_2._id_14B9)) {
      var_3 = var_2._id_14B9.origin;
    } else if(isDefined(var_2.point)) {
      var_3 = var_2.point;

    }
    var_4 = var_2._id_1486["name"];
    var_5 = _id_14E7(var_4);

    if(!isDefined(var_5)) {
      return;
    }
    var_6 = min(var_5["duration"][0], var_5["duration"][1]);
    var_7 = max(var_5["duration"][0], var_5["duration"][1]);
    var_8 = randomfloatrange(var_6, var_7);
    var_9 = var_5["loop_alias"];
    var_10 = var_5["fade_in"];
    var_11 = var_5["fade_out"];
    var_12 = undefined;

    if(isDefined(var_5["end_alias"])) {
      var_12 = var_5["end_alias"];

    }
    var_13 = spawn("script_origin", var_3 + var_2._id_14D5);

    if(isDefined(var_2._id_14B9) && var_2.mode == "attach") {
      var_13 linkto(var_2._id_14B9);

    }
    var_13 playLoopSound(var_9);

    if(isDefined(var_10)) {
      var_13 scalevolume(0.0);
      wait 0.05;
      var_13 scalevolume(1.0, var_10);
    }

    var_13 thread maps\_audio::_id_14E1();

    if(!var_13._id_14E2) {
      var_14 = level._id_1456._id_148D._id_148E;
      level._id_1456._id_148D._id_1492[var_0][var_1]["loops"][var_14] = var_13;
      _id_14FA();
      level._id_1456._id_148D._id_148E++;
      var_15 = 0;

      if(isDefined(var_2.mode) && var_2.mode == "free" && isDefined(var_2._id_14D7)) {
        var_15 = 1;
      } else if(!isDefined(var_2.mode) && isDefined(var_2._id_14D7)) {
        var_15 = 1;

      }
      if(var_15) {
        var_16 = 0.1 * var_2._id_14D6;
        var_13 moveto(var_3 + var_2._id_14D7, var_2._id_14D6, var_16, var_16);
      }

      if(isDefined(var_2._id_14D8)) {
        var_13 setpitch(var_2._id_14D8);

      }
      if(isDefined(var_2._id_14DA)) {
        wait 0.05;

        if(isDefined(var_13) && !var_13._id_14E2) {
          var_13 setpitch(var_2._id_14D9, var_2._id_14DA);
        }
      }

      wait(var_8);

      if(!var_13._id_14E2) {
        if(isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["loops"][var_14])) {
          if(isDefined(var_12)) {
            var_17 = spawn("script_origin", var_13.origin);
            var_17 playSound(var_12, "sounddone");
            var_18 = level._id_1456._id_148D._id_1490;
            level._id_1456._id_148D._id_1490++;
            level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"][var_18] = var_17;
            _id_14FA();
            thread _id_14DE(var_0, var_1, var_18, var_17);
          }

          if(isDefined(var_11)) {
            thread maps\_audio::_id_14E4(var_13, var_11);
          } else {
            var_13 stoploopsound();
            wait 0.05;
            var_13 delete();
          }

          _id_14FB();
          level._id_1456._id_148D._id_1492[var_0][var_1]["loops"][var_14] = undefined;
          return;
        }

        return;
      }

      var_13 stoploopsound();
      var_13 delete();
      _id_14FB();
      level._id_1456._id_148D._id_1492[var_0][var_1]["loops"][var_14] = undefined;
      return;
      return;
    }

    var_13 delete();
    return;
  } else {
    maps\_audio::_id_1466("TRYING TO PLAY LOOP WITH DAMB REF COUNT AT MAXIMUM!");
  }
}

_id_14E5(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level._id_1456._id_148D._id_1492[var_0][var_1]["components"]) {
    var_5 = var_4[1];
    var_2 = var_2 + var_5;
  }

  var_7 = randomfloat(var_2);
  var_8 = 0.0;
  var_9 = undefined;

  foreach(var_4 in level._id_1456._id_148D._id_1492[var_0][var_1]["components"]) {
    var_11 = var_8 + var_4[1];

    if(var_7 >= var_8 && var_7 < var_11) {
      var_9 = var_4[0];
      break;
    }

    var_8 = var_11;
  }

  var_13 = _id_14E9(var_9);

  if(!isDefined(var_13)) {
    return;
  }
  var_13["name"] = var_9;
  return var_13;
}

_id_14E6(var_0) {
  var_1 = var_0["loops"];
  var_2 = var_0["oneshots"];
  var_3 = undefined;

  if(!isDefined(level._id_1456._id_148D._id_1493[var_0["name"]])) {
    var_3 = 0;

    if(isDefined(var_1)) {
      if(isstring(var_1[0])) {
        var_3 = var_3 + var_1[1];
      } else {
        foreach(var_5 in var_1) {}
        var_3 = var_3 + var_5[1];
      }
    }

    if(isDefined(var_2)) {
      if(isstring(var_2[0])) {
        var_3 = var_3 + var_2[1];
      } else {
        foreach(var_5 in var_2) {}
        var_3 = var_3 + var_5[1];
      }
    }

    level._id_1456._id_148D._id_1493[var_0["name"]] = var_3;
  } else {
    var_3 = level._id_1456._id_148D._id_1493[var_0["name"]];

  }
  var_9 = randomfloatrange(0.0, var_3);
  var_10 = undefined;
  var_11 = undefined;
  var_12 = 0.0;

  if(isDefined(var_1)) {
    if(isstring(var_1[0])) {
      var_13 = var_12 + var_1[1];

      if(var_9 >= var_12 && var_9 < var_13) {
        var_10 = var_1[0];
        var_11 = "loop";
      } else {
        var_12 = var_13;
      }
    } else {
      foreach(var_5 in var_1) {
        var_13 = var_12 + var_5[1];

        if(var_9 >= var_12 && var_9 < var_13) {
          var_10 = var_5[0];
          var_11 = "loop";
          break;
        } else {
          var_12 = var_13;
        }
      }
    }
  }

  if(!isDefined(var_10) && isDefined(var_2)) {
    if(isarray(var_2)) {
      foreach(var_5 in var_2) {
        var_13 = var_12 + var_5[1];

        if(var_9 >= var_12 && var_9 < var_13) {
          var_10 = var_5[0];
          var_11 = "oneshot";
          break;
        } else {
          var_12 = var_13;
        }
      }
    } else {
      var_13 = var_12 + var_2[1];

      if(var_9 >= var_12 && var_9 < var_13) {
        var_10 = var_2[0];
        var_11 = "oneshot";
      } else {
        var_12 = var_13;
      }
    }
  }

  var_18 = [];
  var_18["name"] = var_10;
  var_18["type"] = var_11;
  return var_18;
}

_id_14E7(var_0) {
  var_1 = [];

  if(isDefined(level._id_1456._id_148D._id_1496[var_0])) {
    var_1 = level._id_1456._id_148D._id_1496[var_0];
  } else if(level._id_1456._id_148D._id_1458) {
    var_1 = _id_14EF(var_0, 1);
  } else {
    var_1 = _id_14EF(var_0, 0);

    if(!isDefined(var_1) || var_1.size == 0) {
      var_1 = maps\_audio::_id_14E8(var_0, var_1);
    }
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._id_1456._id_148D._id_1496[var_0] = var_1;
  return var_1;
}

_id_14E9(var_0) {
  if(!isDefined(level._id_1456._id_148D._id_1495)) {
    level._id_1456._id_148D._id_1495 = [];

  }
  var_1 = [];

  if(isDefined(level._id_1456._id_148D._id_1495[var_0])) {
    var_1 = level._id_1456._id_148D._id_1495[var_0];
  } else if(level._id_1456._id_148D._id_1458) {
    var_1 = _id_14F4(var_0, 1);
  } else {
    var_1 = _id_14F4(var_0, 0);

    if(!isDefined(var_1) || var_1.size == 0) {
      var_1 = maps\_audio::_id_14EA(var_0, var_1);
    }
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._id_1456._id_148D._id_1495[var_0] = var_1;
  return var_1;
}

_id_14EB(var_0, var_1, var_2) {
  level._id_1456._id_148D._id_1492[var_0][var_1]["loops"] = [];
  level._id_1456._id_148D._id_1492[var_0][var_1]["single_loops"] = [];
  level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"] = [];

  if(!isDefined(level._id_1456._id_148D._id_1492[var_0][var_1]["event_time"])) {
    foreach(var_4 in level._id_1456._id_148D._id_1492[var_0][var_1]["components"]) {
      var_5 = _id_14E9(var_4);

      if(!isDefined(var_5)) {
        return;
      }
      var_5["name"] = var_4;
      thread _id_14DD(var_0, var_1, var_5, var_2);
    }
  } else {
    thread _id_14B6(var_0, var_1, var_2);

  }
  level waittill(var_0 + "_" + var_1 + "_stop");
  wait 0.1;

  foreach(var_8 in level._id_1456._id_148D._id_1492[var_0][var_1]["loops"]) {}
  thread _id_14ED(var_8, level._id_1456._id_148D._id_1492[var_0][var_1]["fade"], 0);

  foreach(var_8 in level._id_1456._id_148D._id_1492[var_0][var_1]["single_loops"]) {}
  thread _id_14ED(var_8, level._id_1456._id_148D._id_1492[var_0][var_1]["fade"], 1);

  foreach(var_8 in level._id_1456._id_148D._id_1492[var_0][var_1]["oneshots"]) {}
  thread _id_14EC(var_8, level._id_1456._id_148D._id_1492[var_0][var_1]["fade"]);

  level._id_1456._id_148D._id_1492[var_0][var_1] = undefined;
}

_id_14EC(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 scalevolume(0.0, var_1);
    wait(var_1);
    var_0 stopsounds();
    wait 0.05;
    var_0 delete();
    _id_14FB();
  }
}

_id_14ED(var_0, var_1, var_2) {
  var_0 scalevolume(0.0, var_1);
  wait(var_1);
  var_0 stoploopsound();
  wait 0.05;
  var_0 delete();

  if(var_2) {
    level._id_1456._id_148D._id_1498--;
  } else {
    _id_14FB();
  }
}

_id_14EE(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = var_3;

  }
  var_5 = [];
  var_6 = 0;
  var_7 = strtok(var_0, "+");
  var_8 = 0;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_10 = strtok(var_7[var_9], " ");

    if(var_10.size == 1 && var_10[0] != "") {
      var_5[var_5.size] = var_10[0];
      continue;
    }

    var_11 = var_5.size;
    var_5[var_11] = [];
    var_5[var_11][0] = var_10[0];
    var_5[var_11][1] = float(var_10[1]);
  }

  if(!var_6 && var_4) {
    var_12 = [];

    for(var_9 = 0; var_9 < var_5.size; var_9++) {
      var_13 = var_12.size;
      var_12[var_13] = [];
      var_12[var_13][0] = var_5[var_9];
      var_12[var_13][1] = 1.0;
    }

    var_5 = var_12;
  }

  return var_5;
}

_id_14EF(var_0, var_1) {
  var_2 = "soundtables/common_damb_loops.csv";
  var_3 = maps\_audio::_id_14F0();
  var_4 = [];

  if(var_1) {
    var_4 = _id_14F1(var_3, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = _id_14F1(var_2, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

_id_14F1(var_0, var_1) {
  var_2 = [];
  var_3 = 8;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = [];

  for(var_9 = 0; var_9 < var_3; var_9++) {
    var_10 = tablelookup(var_0, 0, "loop_defs", var_9);

    if(!isDefined(var_10) || var_10 == "") {
      return;
    }
    var_11 = tablelookup(var_0, 0, var_1, var_9);

    if(var_11 != "" && var_10 != "comments") {
      switch (var_10) {
        case "loop_alias":
          var_4 = var_11;
          break;
        case "fade_in":
          if(isDefined(var_11) && var_11 != "") {
            var_6 = max(float(var_11), 0.0);

          }
          break;
        case "fade_out":
          if(isDefined(var_11) && var_11 != "") {
            var_7 = max(float(var_11), 0.0);

          }
          break;
        case "end_alias":
          if(isDefined(var_11) && var_11 != "") {
            var_5 = var_11;

          }
          break;
        case "duration_min":
          if(isDefined(var_11) && var_11 != "") {
            var_8[0] = float(var_11);

          }
          break;
        case "duration_max":
          if(isDefined(var_11) && var_11 != "") {
            var_8[1] = float(var_11);

          }
          break;
        default:
          break;
      }
    }
  }

  var_2["loop_alias"] = var_4;

  if(isDefined(var_6)) {
    var_2["fade_in"] = var_6;

  }
  if(isDefined(var_7)) {
    var_2["fade_out"] = var_7;

  }
  if(isDefined(var_5)) {
    var_2["end_alias"] = var_5;

  }
  if(isDefined(var_8[0])) {
    var_2["duration"] = _id_14F2(var_8);

  }
  return var_2;
}

_id_14F2(var_0) {
  var_1 = [];
  var_1[0] = float(var_0[0]);
  var_1[1] = float(var_0[1]);
  return var_1;
}

_id_14F3(var_0, var_1) {
  var_2 = [];
  var_3 = 21;
  var_4 = 8;
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = [];
  var_15 = [];
  var_16 = 0;

  for(var_17 = 1; var_17 < var_3; var_17++) {
    var_18 = tablelookup(var_0, 0, "components", var_17);

    if(!isDefined(var_18)) {
      return;
    }
    var_19 = tablelookup(var_0, 0, var_1, var_17);

    if(var_19 != "" && var_18 != "comments") {
      var_16++;

      switch (var_18) {
        case "oneshots":
          var_5 = _id_14EE(var_19, "component definition", "oneshots", 1);
          break;
        case "loops":
          var_6 = _id_14EE(var_19, "component definition", "loops", 1);
          break;
        case "single_loops":
          var_7 = _id_14EE(var_19, "component definition", "single_loops", 0);
          break;
        case "first_event_min":
          var_8[0] = float(var_19);
          break;
        case "first_event_max":
          var_8[1] = float(var_19);
          break;
        case "event_time_min":
          var_9[0] = float(var_19);
          break;
        case "event_time_max":
          var_9[1] = float(var_19);
          break;
        case "dist_min":
          var_10[0] = float(var_19);
          break;
        case "dist_max":
          var_10[1] = float(var_19);
          break;
        case "cone_min":
          var_11[0] = float(var_19);
          break;
        case "cone_max":
          var_11[1] = float(var_19);
          break;
        case "travel_min":
          var_12[0] = float(var_19);
          break;
        case "travel_max":
          var_12[1] = float(var_19);
          break;
        case "travel_time_min":
          var_13[0] = float(var_19);
          break;
        case "travel_time_max":
          var_13[1] = float(var_19);
          break;
        case "pitch_min":
          var_14[0] = float(var_19);
          break;
        case "pitch_max":
          var_14[1] = float(var_19);
          break;
        case "pitch_time_min":
          var_15[0] = float(var_19);
          break;
        case "pitch_time_max":
          var_15[1] = float(var_19);
          break;
        default:
          break;
      }
    }
  }

  if(var_16 > 0) {
    if(isDefined(var_5[0])) {
      if(isstring(var_5[0])) {
        var_5[1] = 1.0;

      }
      var_2["oneshots"] = var_5;
    }

    if(isDefined(var_6[0])) {
      var_2["loops"] = var_6;

    }
    if(isDefined(var_7[0])) {
      var_2["single_loops"] = var_7;

    }
    if(isDefined(var_8[0])) {
      var_2["first_event"] = _id_14F2(var_8);

    }
    if(isDefined(var_9[0])) {
      var_2["event_time"] = _id_14F2(var_9);

    }
    if(isDefined(var_10[0])) {
      var_2["radius"] = _id_14F2(var_10);

    }
    if(isDefined(var_11[0])) {
      var_2["cone"] = _id_14F2(var_11);

    }
    if(isDefined(var_12[0])) {
      var_2["delta"] = _id_14F2(var_12);

    }
    if(isDefined(var_13[0])) {
      var_2["travel_time"] = _id_14F2(var_13);

    }
    if(isDefined(var_14[0])) {
      var_2["pitch"] = _id_14F2(var_14);

    }
    if(isDefined(var_15[0])) {
      var_2["pitch_time"] = _id_14F2(var_15);

    }
    if(!isDefined(var_2["radius"])) {
      var_2["radius"] = [0.0, 0.01];
    }
  }

  return var_2;
}

_id_14F4(var_0, var_1) {
  var_2 = maps\_audio::_id_14F5();
  var_3 = "soundtables/common_damb_components.csv";
  var_4 = [];

  if(var_1) {
    var_4 = _id_14F3(var_2, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = _id_14F3(var_3, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

_id_14F6(var_0, var_1) {
  var_2 = 7;
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];

  for(var_7 = 1; var_7 < var_2; var_7++) {
    var_8 = tablelookup(var_0, 0, "dynamic_ambience", var_7);
    var_9 = tablelookup(var_0, 0, var_1, var_7);
    var_10 = 0;

    if(var_9 != "" && var_8 != "comments") {
      switch (var_8) {
        case "components":
          var_4 = _id_14EE(var_9, "preset definition", "components");
          break;
        case "first_event_min":
          if(isDefined(var_9) && var_9 != "") {
            var_5[0] = float(var_9);

          }
          break;
        case "first_event_max":
          if(isDefined(var_9) && var_9 != "") {
            var_5[1] = float(var_9);

          }
          break;
        case "event_time_min":
          if(isDefined(var_9) && var_9 != "") {
            var_6[0] = float(var_9);

          }
          break;
        case "event_time_max":
          if(isDefined(var_9) && var_9 != "") {
            var_6[1] = float(var_9);
          }
        case "comment":
          break;
        default:
          break;
      }
    }
  }

  var_10 = 0;

  if(isDefined(var_5[0])) {
    var_10 = 1;
    var_3["first_event"] = var_5;
  }

  if(isDefined(var_6[0])) {
    var_10 = 1;
    var_3["event_time"] = var_6;
  }

  if(var_10) {
    if(isDefined(var_4[0][1])) {
      var_3["components"] = var_4;
    } else {
      var_3["components"] = [];

      for(var_7 = 0; var_7 < var_4.size; var_7++) {
        var_3["components"][var_3["components"].size] = [var_4[0], 1.0];

      }
      if(var_3["components"].size == 0) {
        var_3["components"] = undefined;
      }
    }
  } else if(var_4.size != 0) {
    var_3["components"] = var_4;

  }
  return var_3;
}

_id_14F7(var_0, var_1) {
  var_2 = maps\_audio::_id_14F8();
  var_3 = "soundtables/common_damb.csv";
  var_4 = [];

  if(var_1) {
    var_4 = _id_14F6(var_2, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = _id_14F6(var_3, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

_id_14F9(var_0) {
  var_1 = [];

  if(isDefined(level._id_1456._id_148D._id_1473[var_0])) {
    var_1 = level._id_1456._id_148D._id_1473[var_0];
  } else {
    var_1 = _id_14F7(var_0, 1);

  }
  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._id_1456._id_148D._id_1473[var_0] = var_1;
  var_1["name"] = var_0;
  return var_1;
}

_id_14FA() {
  level._id_1456._id_148D._id_1497++;
}

_id_14FB() {
  level._id_1456._id_148D._id_1497--;
}