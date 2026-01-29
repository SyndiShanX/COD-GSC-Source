/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\139.gsc
**************************************/

_id_1560() {
  if(!isDefined(level._id_1456._id_1561)) {
    level._id_1456._id_1561 = spawnStruct();
    level._id_1456._id_1561._id_1562 = "";
    level._id_1456._id_1561._id_1563 = [];
    level._id_1456._id_1561._id_1564 = spawnStruct();
    level._id_1456._id_1561._id_1564._id_1565 = [];
    level._id_1456._id_1561._id_1564._id_148D = [];
    level._id_1456._id_1561._id_1564._id_14FD = [];
    level._id_1456._id_1561._id_1564._id_1566 = [];
    level._id_1456._id_1561._id_1564._id_1567 = [];
    level._id_1456._id_1561._id_1458 = 0;
    level._id_1456._id_1561._id_1459 = 0;
  }

  if(!isDefined(level._id_1456._id_1568)) {
    level._id_1456._id_1569 = undefined;
  }
}

_id_156A() {
  level._id_1456._id_1561._id_1458 = 1;
  level._id_1456._id_1561._id_1459 = 0;
}

_id_156B() {
  level._id_1456._id_1561._id_1459 = 1;
  level._id_1456._id_1561._id_1458 = 0;
}

_id_156C(var_0, var_1, var_2) {
  if(level._id_1456._id_1561._id_1562 == var_0) {
    return;
  } else if(level._id_1456._id_1561._id_1562 != "") {
    _id_1577(level._id_1456._id_1561._id_1562, var_1);

  }
  level._id_1456._id_1561._id_1562 = var_0;

  if(isDefined(level._id_1456._id_1561._id_1563[var_0]) && isDefined(level._id_1456._id_1561._id_1563[var_0]["state"]) && level._id_1456._id_1561._id_1563[var_0]["state"] != "stopping") {
    maps\_audio::_id_1466("ZONEM_start_zone(\"" + var_0 + "\") being called even though audio zone, \"" + var_0 + "\", is already started.");
    return;
  }

  var_3 = 2.0;

  if(isDefined(var_1)) {
    var_3 = var_1;

  }
  if(!isDefined(level._id_1456._id_1561._id_1563[var_0])) {
    var_4 = _id_157D(var_0);

    if(!isDefined(var_4)) {
      return;
    }
    level._id_1456._id_1561._id_1563[var_0] = var_4;
  }

  var_4 = level._id_1456._id_1561._id_1563[var_0];
  maps\_audio::_id_156D("ZONE START: " + var_0);
  level._id_1456._id_1561._id_1563[var_0]["state"] = "playing";
  var_5 = var_4["priority"];
  var_6 = var_4["interrupt_fade"];

  if(isDefined(var_4["streamed_ambience"])) {
    if(var_4["streamed_ambience"] != "none") {
      maps\_audio_stream_manager::_id_147D(var_4["streamed_ambience"], var_3, var_5, var_6);
    } else {
      maps\_audio_stream_manager::_id_1483(var_3);
    }
  }

  if(isDefined(var_4["dynamic_ambience"])) {
    if(var_4["dynamic_ambience"] != "none") {
      maps\_audio_dynamic_ambi::_id_149D(var_4["dynamic_ambience"], 1.0);
    } else {
      maps\_audio_dynamic_ambi::_id_14A7(1.0);
    }
  }

  if(isDefined(var_4["occlusion"])) {
    if(var_4["occlusion"] != "none") {
      maps\_audio::_id_156E(var_4["occlusion"]);
    } else {
      maps\_audio::_id_156F();
    }
  }

  if(isDefined(var_4["filter"])) {
    if(var_4["filter"] != "none") {
      maps\_audio::_id_1570(var_4["filter"], 0);
      level.player seteqlerp(1, 0);
    }
  }

  if(isDefined(var_4["reverb"])) {
    if(var_4["reverb"] != "none") {
      maps\_audio_reverb::_id_1465(var_4["reverb"]);
    } else {
      maps\_audio_reverb::_id_146B();
    }
  }

  if(isDefined(var_4["mix"])) {
    if(var_4["mix"] != "none") {
      maps\_audio_mix_manager::_id_1510(var_4["mix"]);
    } else {
      maps\_audio_mix_manager::_id_1513(1.0);
    }
  }
}

_id_1571(var_0, var_1, var_2) {
  var_3 = _id_1586(var_0, "streamed_ambience", var_1, ::_id_1581, var_2);

  if(!var_3) {
    if(!isDefined(var_1)) {
      var_1 = "none";

    }
    level._id_1456._id_1561._id_1564._id_1565[var_0] = var_1;
  }
}

_id_1572(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";

  }
  _id_1586(var_0, "dynamic_ambience", var_1, ::_id_1582, var_2);
  level._id_1456._id_1561._id_1564._id_148D[var_0] = var_1;
}

_id_1573(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";

  }
  _id_1586(var_0, "reverb", var_1, ::_id_1583, var_2);
  level._id_1456._id_1561._id_1564._id_1566[var_0] = var_1;
}

_id_1574(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";

  }
  _id_1586(var_0, "occlusion", var_1, ::_id_1584, var_2);
  level._id_1456._id_1561._id_1564._id_14FD[var_1] = var_1;
}

_id_1575(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";

  }
  _id_1586(var_0, "mix", var_1, ::_id_1585, var_2);
  level._id_1456._id_1561._id_1564._id_14FD[var_1] = var_1;
}

_id_1576(var_0) {
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = var_0;

  }
  maps\_audio::_id_156D("ZONE STOP ALL");

  foreach(var_3 in level._id_1456._id_1561._id_1563) {}
  _id_1577(var_3["name"], var_1, 0);
}

_id_1577(var_0, var_1, var_2) {
  if(isDefined(level._id_1456._id_1561._id_1563[var_0]) && isDefined(level._id_1456._id_1561._id_1563[var_0]["state"]) && level._id_1456._id_1561._id_1563[var_0]["state"] != "stopping") {
    var_3 = 1.0;

    if(isDefined(var_1)) {
      var_3 = var_1;

    }
    var_4 = level._id_1456._id_1561._id_1563[var_0];
    var_5 = 0;

    if(isDefined(var_2)) {
      var_5 = var_2;

    }
    if(var_5) {
      maps\_audio::_id_156D("ZONE STOP ZONE: " + var_0);

    }
    if(isDefined(var_4["streamed_ambience"])) {
      maps\_audio_stream_manager::_id_1481(var_4["streamed_ambience"], var_3);

    }
    if(isDefined(var_4["dynamic_ambience"])) {
      maps\_audio_dynamic_ambi::_id_14A8(var_4["dynamic_ambience"], var_3);

    }
    level._id_1456._id_1561._id_1563[var_0]["state"] = "stopping";
    thread _id_1587(var_0, var_3);
  }
}

_id_1578() {
  return level._id_1456._id_1561._id_1562;
}

_id_1579(var_0) {
  level._id_1456._id_1561._id_1562 = var_0;
}

_id_157A(var_0, var_1, var_2) {}

_id_157B(var_0) {}

_id_157C(var_0) {}

_id_157D(var_0) {
  if(isDefined(level._id_1456._id_1561._id_1563[var_0])) {
    return;
  }
  if(!isDefined(level._id_1456._id_1561._id_1473)) {
    level._id_1456._id_1561._id_1473 = [];

  }
  var_1 = [];

  if(isDefined(level._id_1456._id_1561._id_1473[var_0])) {
    var_1 = level._id_1456._id_1561._id_1473[var_0];
  } else {
    var_1 = _id_157E(var_0, 1);

  }
  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  level._id_1456._id_1561._id_1473[var_0] = var_1;
  var_2 = 0;

  if(isDefined(level._id_1456._id_1561._id_1564._id_1565[var_0])) {
    if(level._id_1456._id_1561._id_1564._id_1565[var_0] == "none") {
      var_1["streamed_ambience"] = undefined;
    } else {
      var_1["streamed_ambience"] = level._id_1456._id_1561._id_1564._id_1565[var_0];

    }
    var_2 = 1;
    level._id_1456._id_1561._id_1564._id_1565[var_0] = undefined;
  }

  if(isDefined(level._id_1456._id_1561._id_1564._id_148D[var_0])) {
    if(level._id_1456._id_1561._id_1564._id_148D[var_0] == "none") {
      var_1["dynamic_ambience"] = undefined;
    } else {
      var_1["dynamic_ambience"] = level._id_1456._id_1561._id_1564._id_148D[var_0];

    }
    var_2 = 1;
    level._id_1456._id_1561._id_1564._id_148D[var_0] = undefined;
  }

  if(isDefined(level._id_1456._id_1561._id_1564._id_1566[var_0])) {
    if(level._id_1456._id_1561._id_1564._id_1566[var_0] == "none") {
      var_1["reverb"] = undefined;
    } else {
      var_1["reverb"] = level._id_1456._id_1561._id_1564._id_1566[var_0];

    }
    var_2 = 1;
    level._id_1456._id_1561._id_1564._id_1566[var_0] = undefined;
  }

  if(isDefined(level._id_1456._id_1561._id_1564._id_1567[var_0])) {
    if(level._id_1456._id_1561._id_1564._id_1567[var_0] == "none") {
      var_1["occlusion"] = undefined;
    } else {
      var_1["occlusion"] = level._id_1456._id_1561._id_1564._id_1567[var_0];

    }
    var_2 = 1;
    level._id_1456._id_1561._id_1564._id_1567[var_0] = undefined;
  }

  if(isDefined(level._id_1456._id_1561._id_1564._id_14FD[var_0])) {
    if(level._id_1456._id_1561._id_1564._id_14FD[var_0] == "none") {
      var_1["mix"] = undefined;
    } else {
      var_1["mix"] = level._id_1456._id_1561._id_1564._id_14FD[var_0];

    }
    var_2 = 1;
    level._id_1456._id_1561._id_1564._id_14FD[var_0] = undefined;
  }

  if(var_2) {
    level._id_1456._id_1561._id_1473[var_0] = var_1;

  }
  var_1["name"] = var_0;

  if(!isDefined(var_1["priority"])) {
    var_1["priority"] = 1;

  }
  if(!isDefined(var_1["interrupt_fade"])) {
    var_1["interrupt_fade"] = 0.1;

  }
  return var_1;
}

_id_157E(var_0, var_1) {
  var_2 = "soundtables/common_zone.csv";
  var_3 = maps\_audio::_id_157F();
  var_4 = [];

  if(var_1) {
    var_4 = _id_1580(var_3, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    var_4 = _id_1580(var_2, var_0);

  }
  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  return var_4;
}

_id_1580(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = "";
  var_5 = 8;

  for(var_6 = 1; var_6 < var_5; var_6++) {
    if(var_3 != "comments" && var_4 != "") {
      var_2[var_3] = var_4;

    }
    var_3 = tablelookup(var_0, 0, "zone_names", var_6);
    var_4 = tablelookup(var_0, 0, var_1, var_6);

    if(var_3 != "comment" && var_3 != "comments" && var_4 != "") {
      switch (var_3) {
        case "streamed_ambience":
          var_2["streamed_ambience"] = var_4;
          break;
        case "dynamic_ambience":
          var_2["dynamic_ambience"] = var_4;
          break;
        case "mix":
          var_2["mix"] = var_4;
          break;
        case "reverb":
          var_2["reverb"] = var_4;
          break;
        case "filter":
          var_2["filter"] = var_4;
          break;
        case "occlusion":
          var_2["occlusion"] = var_4;
          break;
        default:
          break;
      }
    }
  }

  return var_2;
}

_id_1581(var_0, var_1) {
  var_2 = level._id_1456._id_1561._id_1563[var_0]["streamed_ambience"];

  if(isDefined(var_2)) {
    maps\_audio_stream_manager::_id_147D(var_2, var_1);
  } else {
    maps\_audio_stream_manager::_id_1483(var_1);
  }
}

_id_1582(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;

  }
  var_3 = level._id_1456._id_1561._id_1563[var_0]["dynamic_ambience"];

  if(isDefined(var_3)) {
    maps\_audio_dynamic_ambi::_id_149D(var_3, var_2);
  } else {
    maps\_audio_dynamic_ambi::_id_14A8(undefined, var_2);
  }
}

_id_1583(var_0, var_1) {
  var_2 = level._id_1456._id_1561._id_1563[var_0]["reverb"];

  if(isDefined(var_2)) {
    maps\_audio_reverb::_id_1465(var_2);
  }
}

_id_1584(var_0, var_1) {
  var_2 = level._id_1456._id_1561._id_1563[var_0]["occlusion"];

  if(isDefined(var_2)) {
    maps\_audio::_id_156E(var_2);
  }
}

_id_1585(var_0, var_1) {
  var_2 = level._id_1456._id_1561._id_1563[var_0]["mix"];

  if(isDefined(var_2)) {
    maps\_audio_mix_manager::_id_150F(var_2);
  }
}

_id_1586(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_1456._id_1561._id_1563[var_0])) {
    if(isDefined(level._id_1456._id_1561._id_1563[var_0][var_1]) && level._id_1456._id_1561._id_1563[var_0][var_1] != var_2 || !isDefined(level._id_1456._id_1561._id_1563[var_0][var_1]) && var_2 != "none") {
      if(var_2 == "none") {
        level._id_1456._id_1561._id_1563[var_0][var_1] = undefined;
      } else {
        level._id_1456._id_1561._id_1563[var_0][var_1] = var_2;

      }
      if(var_0 == _id_1578()) {
        [[var_3]](var_0, var_4);
      }
    }

    return 1;
  } else {
    return 0;
  }
}

_id_1587(var_0, var_1) {
  wait(var_1);
  wait 0.05;

  if(level._id_1456._id_1561._id_1563[var_0]["state"] == "stopping") {
    return;
  }
}

_id_1588(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_1589 = var_0;
  var_2._id_158A = var_1;
  var_2._id_158B = undefined;
  var_2._id_158C = undefined;
  var_2._id_158D = undefined;
  var_2._id_158E = undefined;
  var_2._id_158F = undefined;
  var_2._id_1590 = undefined;
  var_2._id_1591 = undefined;
  var_2._id_1592 = undefined;
  var_2._id_1593 = undefined;
  var_2._id_1594 = undefined;
  var_2._id_1595 = undefined;
  var_2._id_1596 = undefined;

  if(!isDefined(level._id_1456._id_1561._id_1563[var_0])) {
    var_3 = _id_157D(var_0);

    if(!isDefined(var_3)) {
      maps\_audio::_id_1466("Couldn't find zone: " + var_0);
      return;
    }

    level._id_1456._id_1561._id_1563[var_0] = var_3;
  }

  var_4 = level._id_1456._id_1561._id_1563[var_0];

  if(!isDefined(level._id_1456._id_1561._id_1563[var_1])) {
    var_3 = _id_157D(var_1);

    if(!isDefined(var_3)) {
      maps\_audio::_id_1466("Couldn't find zone: " + var_1);
      return;
    }

    level._id_1456._id_1561._id_1563[var_1] = var_3;
  }

  var_5 = level._id_1456._id_1561._id_1563[var_1];
  var_2._id_158F = var_4["occlusion"];
  var_2._id_1590 = var_5["occlusion"];
  var_2._id_1591 = var_4["filter"];
  var_2._id_1592 = var_5["filter"];
  var_2._id_1593 = var_4["reverb"];
  var_2._id_1594 = var_5["reverb"];
  var_2._id_1597 = var_4["mix"];
  var_2._id_1598 = var_5["mix"];
  var_2._id_158B = var_4["streamed_ambience"];
  var_2._id_158C = var_5["streamed_ambience"];
  var_6 = level._id_1456._id_148D._id_1492["zone"].size;

  if(var_6 != 1) {
    maps\_audio_dynamic_ambi::_id_14A6(1.0, "zone");

  }
  if(var_6 == 1) {
    foreach(var_9, var_8 in level._id_1456._id_148D._id_1492["zone"]) {
      var_2._id_158D = var_9;
      break;
    }
  }

  var_2._id_158E = var_5["dynamic_ambience"];
  return var_2;
}

_id_1599(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && var_0 != var_1) {
    var_2 = 1;
  } else if(isDefined(var_1) && !isDefined(var_0)) {
    var_2 = 1;
  } else if(isDefined(var_0) && !isDefined(var_1)) {
    var_2 = 1;

  }
  return var_2;
}

_id_159A(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0) && isDefined(var_1) && var_0 != var_1) {
    var_2 = 1;
  } else if(isDefined(var_1) && !isDefined(var_0)) {
    var_2 = 1;

  }
  return var_2;
}

_id_159B(var_0, var_1, var_2) {
  if(_id_159A(var_2._id_158B, var_2._id_158C)) {
    var_3 = [];
    var_4 = 0;

    if(isDefined(var_2._id_158B) && var_2._id_158B != "") {
      var_5 = level._id_1456._id_1561._id_1563[var_2._id_1589];
      var_3[var_4] = spawnStruct();
      var_3[var_4]._id_1486 = var_2._id_158B;
      var_3[var_4]._id_147F = var_0;
      var_3[var_4]._id_147E = var_5["interrupt_fade"];
      var_3[var_4].priority = var_5["priority"];
      var_4++;
    }

    if(isDefined(var_2._id_158C) && var_2._id_158C != "") {
      var_6 = level._id_1456._id_1561._id_1563[var_2._id_158A];
      var_3[var_4] = spawnStruct();
      var_3[var_4]._id_1486 = var_2._id_158C;
      var_3[var_4]._id_147F = var_1;
      var_3[var_4]._id_147E = var_6["interrupt_fade"];
      var_3[var_4].priority = var_6["priority"];
    }

    if(var_3.size > 0) {
      maps\_audio_stream_manager::_id_1485(var_3);
    }
  }

  if(_id_1599(var_2._id_158D, var_2._id_158E)) {
    maps\_audio_dynamic_ambi::_id_14AA(var_2._id_158D, var_0, var_2._id_158E, var_1);

  }
  var_7 = 0;

  if(maps\_audio::_id_159C()) {
    if(isDefined(var_2._id_1591)) {
      var_7 = 1;
      maps\_audio::_id_1570(var_2._id_1591, 0, 0);
    } else {
      maps\_audio::_id_1570(undefined, 0, 0);

    }
    if(isDefined(var_2._id_1592)) {
      var_7 = 1;
      maps\_audio::_id_1570(var_2._id_1592, 1, 0);
    } else {
      maps\_audio::_id_1570(undefined, 1, 0);

    }
    if(!(isDefined(level._id_1456._id_159D) && level._id_1456._id_159D)) {
      if(isDefined(var_2._id_1591) || isDefined(var_2._id_1592)) {
        level.player seteqlerp(var_0, 0);
      }
    }
  }

  if(var_0 >= 0.75) {
    if(isDefined(var_2._id_1593)) {
      if(var_2._id_1593 == "none") {
        maps\_audio_reverb::_id_1465(undefined);
      } else {
        maps\_audio_reverb::_id_1465(var_2._id_1593);
      }
    }

    if(isDefined(var_2._id_1597)) {
      if(var_2._id_1597 == "none") {
        maps\_audio_mix_manager::_id_1513(2.0);
      } else {
        maps\_audio_mix_manager::_id_1510(var_2._id_1597);
      }
    }

    if(maps\_audio::_id_159C()) {
      if(isDefined(var_2._id_158F)) {
        if(var_2._id_158F == "none") {
          maps\_audio::_id_156F();
        } else {
          maps\_audio::_id_156E(var_2._id_158F);
        }
      }
    }
  } else if(var_1 >= 0.75) {
    if(isDefined(var_2._id_1594)) {
      if(var_2._id_1594 == "none") {
        maps\_audio_reverb::_id_1465(undefined);
      } else {
        maps\_audio_reverb::_id_1465(var_2._id_1594);
      }
    }

    if(isDefined(var_2._id_1598)) {
      if(var_2._id_1598 == "none") {
        maps\_audio_mix_manager::_id_1513(2.0);
      } else {
        maps\_audio_mix_manager::_id_1510(var_2._id_1598);
      }
    }

    if(maps\_audio::_id_159C()) {
      if(isDefined(var_2._id_1590)) {
        if(var_2._id_1590 == "none") {
          maps\_audio::_id_156F();
        } else {
          maps\_audio::_id_156E(var_2._id_1590);
        }
      }
    }
  }
}