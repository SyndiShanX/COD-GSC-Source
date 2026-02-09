/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\103.gsc
**************************************/

_id_16F4() {
  if(!isDefined(level._id_16F5)) {
    if(!isDefined(level.script)) {
      level.script = tolower(getDvar("mapname"));
    }
    level._id_16F5 = spawnStruct();

    if(!isDefined(level._id_1456)) {
      level._id_1456 = spawnStruct();
    }
    level._id_1456._id_16F6 = 0;
    level._id_1456._id_16F7 = [];
    var_0 = spawnStruct();
    level._id_1456.index = spawnStruct();
    level._id_1456.index._id_16F8 = _id_17A9();
    level._id_1456.index._id_16F9 = _id_17A9();
    _id_17AD();
    level._id_1456._id_16FA = [];
    level._id_1456._id_16FB = [];
    level._id_1456._id_16FC = [];
    level._id_1456._id_16FD = 0;
    level._id_1456._id_16FE = "";
    level._id_1456._id_16FF = ["", ""];
    level._id_1456._id_159D = 0;
    level._id_1456._id_1700 = 0;
    level._id_1456._id_1701 = undefined;
    level._id_1456._id_1702 = spawnStruct();
    level._id_1456._id_1702._id_1703 = "idle";
    level._id_1456._id_1702._id_1704 = "idle";
    level._id_146A = [];
    level._id_1705 = [];
    level.fxfireloopmod = 1;
    level._id_1469 = "";
    level._id_1706 = 0;
    level._id_1707 = 1;
    level._id_1708[level._id_1706] = "";
    level._id_1708[level._id_1707] = "";
    maps\_audio_stream_manager::_id_1477();
    maps\_audio_dynamic_ambi::_id_148C();
    maps\_audio_zone_manager::_id_1560();
    thread maps\_audio_mix_manager::_id_14FC();
    maps\_audio_reverb::_id_1455();
    maps\_audio_music::_id_15A1();
    maps\_audio_whizby::_id_15B4();
    maps\_audio_vehicles::_id_15C1();
    thread _id_17C3();
    thread _id_1722();
    _id_174C(::_id_1753);
  }
}

_id_14AE(var_0, var_1) {
  _id_1532("CALLING DYNAMIC_AMBIENCE PRESET USING OLD METHOD!");
}

_id_14EA(var_0, var_1) {
  _id_1532("CALLING DYNAMIC_AMBIENCE_COMPONENTS PRESET USING OLD METHOD!");
}

_id_14E8(var_0, var_1) {
  _id_1532("CALLING DYNAMIC_AMBIENCE_LOOP_DEFINITIONS PRESET USING OLD METHOD!");
}

_id_1557(var_0, var_1) {
  _id_1532("CALLING MIX PRESET USING OLD METHOD!");
}

_id_1709(var_0, var_1) {
  _id_1532("CALLING OCCLUSION PRESET USING OLD METHOD!");
}

_id_1475(var_0, var_1) {
  _id_1532("CALLING REVERB PRESET USING OLD METHOD!");
}

_id_15B8(var_0, var_1) {
  _id_1532("CALLING WHIZBY PRESET USING OLD METHOD!");
}

_id_170A(var_0, var_1) {
  _id_1532("CALLING ZONE PRESET USING OLD METHOD!");
}

_id_170B(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  self endon("release" + var_0);

  for(;;) {
    self prefetchsound(var_0, "primed" + var_0);
    self waittill("primed" + var_0);

    if(!isDefined(self._id_170C)) {
      self._id_170C = [];
    }
    self._id_170C[var_0] = 1;

    if(!var_3) {
      return;
    } else if(isDefined(var_2)) {
      wait(var_2);
    }
  }
}

_id_170D(var_0) {
  if(isDefined(self._id_170C) && isDefined(self._id_170C[var_0]) && self._id_170C[var_0]) {
    return 1;
  } else {
    return 0;
  }
}

_id_170E(var_0) {}

_id_170F(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  self notify("release" + var_0);

  if(var_2 && isDefined(self)) {
    self stopsounds();
  }
}

_id_1710(var_0) {
  if(isDefined(self._id_170C) && isDefined(self._id_170C[var_0]) && self._id_170C[var_0]) {
    return;
  }
  self waittill("primed" + var_0);
  self notify("release" + var_0);
}

_id_1711(var_0, var_1, var_2) {
  _id_170B(var_0);

  if(isDefined(var_2) && var_2) {
    _id_17BF(var_1);
  } else {
    wait(var_1);
  }
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
  wait 0.05;
  self delete();
}

_id_1712(var_0, var_1, var_2, var_3) {
  var_4 = level.player.origin;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  var_5 = spawn("script_origin", var_4);
  var_5 thread _id_1711(var_0, var_1, var_3);
  return var_5;
}

_id_1713(var_0, var_1) {
  level._id_1456._id_16FC[var_0] = var_1;
}

_id_1714(var_0) {
  if(isDefined(level._id_1456._id_16FC[var_0])) {
    return level._id_1456._id_16FC[var_0];
  }
}

_id_1715() {
  if(!isDefined(level._id_1456._id_1716)) {
    return 1;
  } else {
    return level._id_1456._id_1716;
  }
}

_id_1717() {
  level.player._id_1718 = 0;
  level._id_1456._id_1716 = 1;
}

_id_1719() {
  level.player._id_1718 = 1;
  level._id_1456._id_1716 = 0;
}

_id_171A() {
  if(_id_1715() || isDefined(level._id_1456._id_171B)) {
    level._id_1456._id_171B = undefined;
    thread _id_156E(level._id_1456._id_1467._id_171C);
    thread _id_1570(level._id_1456._id_1467._id_171D);
    thread maps\_audio_reverb::_id_1465(level._id_1456._id_1467._id_1457);
  }
}

_id_171E() {
  level._id_1456._id_171B = 1;

  if(!isDefined(level._id_1456._id_1467)) {
    level._id_1456._id_1467 = spawnStruct();
  }
  level._id_1456._id_1467._id_171D = undefined;
  level._id_1456._id_1467._id_171C = undefined;
  level._id_1456._id_1467._id_1457 = undefined;
  level._id_1456._id_1467._id_171D = level._id_1456._id_16FE;
  level._id_1456._id_1467._id_171C = level._id_1456._id_171F;
  level._id_1456._id_1467._id_1457 = level._id_1456._id_145A;

  if(_id_1715()) {
    thread _id_1570("deathsdoor");
    thread maps\_audio_reverb::_id_1465("deathsdoor");
  }
}

_id_1720(var_0) {
  level._id_1456._id_1721 = var_0;
}

_id_1722() {
  wait 0.05;

  while(!common_scripts\utility::flag_exist("missionfailed")) {
    wait 0.05;
  }
  var_0 = "shg_mission_failed_stinger";
  common_scripts\utility::flag_wait("missionfailed");

  if(isDefined(level._id_1456._id_1721)) {
    var_0 = level._id_1456._id_1721;
  }
  if(soundexists(var_0)) {
    maps\_audio_music::_id_15A7(var_0, 2, 4);
  }
}

_id_1723(var_0, var_1, var_2, var_3) {
  var_4 = 7;
  var_5 = "";
  var_6 = 0;
  var_7 = [];
  var_8 = [];
  var_9 = 0;
  var_10 = 0;
  var_2 = _id_1552("filter", var_0, var_3);

  if(var_2 != -1) {
    var_6 = var_2;
  } else if(var_3 && _id_1553() || !var_3 && _id_1554()) {
    return 0;
  }
  while(var_5 != "EOF" && var_10 < 10) {
    var_5 = tablelookupbyrow(var_1, var_6, 0);

    if(var_5 != "") {
      var_10 = 0;
    }
    while(var_5 == var_0) {
      var_9 = 1;
      var_7 = undefined;

      for(var_11 = 1; var_11 < var_4; var_11++) {
        if(!isDefined(var_8[var_11])) {
          var_8[var_11] = tablelookupbyrow(var_1, 0, var_11);
        }
        var_12 = var_8[var_11];
        var_13 = tablelookupbyrow(var_1, var_6, var_11);

        if(var_13 != "") {
          switch (var_12) {
            case "channel_name":
              var_7 = spawnStruct();
              var_7._id_1724 = var_13;
              break;
            case "band":
              var_7._id_1725 = int(var_13);
              break;
            case "type":
              var_7.type = var_13;
              break;
            case "freq":
              var_7._id_1726 = float(var_13);
              break;
            case "gain":
              var_7._id_1727 = float(var_13);
              break;
            case "q":
              var_7._id_1728 = float(var_13);
              break;
            default:
              break;
          }
        }
      }

      if(!isDefined(level._id_1456._id_1729[var_0])) {
        level._id_1456._id_1729[var_0] = [];
      }
      level._id_1456._id_1729[var_0][level._id_1456._id_1729[var_0].size] = var_7;
      var_6++;
      var_5 = tablelookupbyrow(var_1, var_6, 0);
    }

    var_10++;

    if(var_9) {
      return 1;
    }
    var_6++;
  }

  return 0;
}

_id_172A(var_0, var_1, var_2) {
  if(!isDefined(level._id_1456._id_1729)) {
    level._id_1456._id_1729 = [];
  }
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  if(!isDefined(level._id_1456._id_1729[var_0])) {
    level._id_1456._id_1729[var_0] = [];
    var_4 = "soundtables/common_filter.csv";
    var_5 = _id_1748();
    var_6 = 1;
    var_6 = _id_1723(var_0, var_5, var_3, 0);

    if(!var_6) {
      var_6 = _id_1723(var_0, var_4, var_3, 1);
    }
    if(!var_6) {
      return;
    }
  }

  level._id_1456._id_16FE = var_0;

  if(level._id_1456._id_16FF[var_3] != var_0) {
    level._id_1456._id_16FF[var_3] = var_0;
    var_7 = 10;

    if(isDefined(var_2)) {
      var_7 = var_2;
    }
    var_8 = 0;

    foreach(var_10 in level._id_1456._id_1729[var_0]) {
      level.player seteq(var_10._id_1724, var_3, var_10._id_1725, var_10.type, var_10._id_1727, var_10._id_1726, var_10._id_1728);

      if(var_8 < var_7) {
        var_8++;
        continue;
      }

      var_8 = 0;
      wait 0.05;
    }
  }
}

_id_172B(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  level._id_1456._id_16FF[var_1] = "";
  _id_1570(undefined, var_1);
}

_id_172C() {
  level._id_1456._id_172D = 1;
}

_id_172E() {
  level._id_1456._id_172D = undefined;
}

_id_159C() {
  return !isDefined(level._id_1456._id_172D);
}

_id_1570(var_0, var_1, var_2, var_3) {
  if(level._id_1456._id_16FD) {
    return;
  }
  if(isDefined(level.player._id_1008) && isDefined(level.player._id_1008["player_has_red_flashing_overlay"]) && level.player maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return;
  }
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }
  if(!isDefined(var_0) || isDefined(var_0) && var_0 == "") {
    level._id_1456._id_16FE = undefined;
    level.player deactivateeq(var_4);
    return;
  }

  thread _id_172A(var_0, var_1, var_2);
}

_id_172F(var_0) {
  level._id_1456._id_16FD = 1;
}

_id_1730(var_0) {
  level._id_1456._id_16FD = 0;
}

_id_1731(var_0) {
  var_1 = "soundtables/common_timescale.csv";
  var_2 = 2;
  var_3 = "";
  var_4 = 0;
  var_5 = [];
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = _id_1552("timescale", var_0, 1);

  if(var_9 != -1) {
    var_4 = var_9;
  } else if(_id_1553()) {
    return 0;
  }
  while(var_3 != "EOF" && var_8 < 10) {
    var_3 = tablelookupbyrow(var_1, var_4, 0);

    if(var_3 != "") {
      var_8 = 0;
    }
    while(var_3 == var_0) {
      var_7 = 1;
      var_5 = undefined;

      for(var_10 = 1; var_10 < var_2 + 1; var_10++) {
        if(!isDefined(var_6[var_10])) {
          var_6[var_10] = tablelookupbyrow(var_1, 0, var_10);
        }
        var_11 = var_6[var_10];
        var_12 = tablelookupbyrow(var_1, var_4, var_10);

        if(var_12 != "") {
          switch (var_11) {
            case "channel_name":
              var_5 = spawnStruct();
              var_5._id_1724 = var_12;
              break;
            case "scalefactor":
              var_5._id_1732 = float(var_12);
              break;
            default:
              _id_1532("In timescale preset table, common_timescale.csv, there is an improperly labeled parameter column, \"" + var_11 + "\".");
              break;
          }
        }
      }

      if(isDefined(var_5)) {
        level._id_1456._id_1733[var_0][level._id_1456._id_1733[var_0].size] = var_5;
      }
      var_4++;
      var_3 = tablelookupbyrow(var_1, var_4, 0);
    }

    var_8++;

    if(var_7) {
      return 1;
    }
    var_4++;
  }

  return 0;
}

_id_1734(var_0, var_1) {
  var_2 = "default";

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  if(!isDefined(level._id_1456._id_1733)) {
    level._id_1456._id_1733 = [];
  }
  var_3 = 1;

  if(!isDefined(level._id_1456._id_1733[var_2])) {
    level._id_1456._id_1733[var_2] = [];
    var_3 = _id_1731(var_2);
  }

  if(!var_3) {
    return;
  }
  var_4 = 10;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }
  var_5 = 0;

  foreach(var_7 in level._id_1456._id_1733[var_2]) {
    soundsettimescalefactor(var_7._id_1724, var_7._id_1732);

    if(var_5 < var_4) {
      var_5++;
      continue;
    }

    var_5 = 0;
    wait 0.05;
  }
}

_id_1735(var_0, var_1) {
  thread _id_1734(var_0, var_1);
}

_id_1736(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = "soundtables/common_occlusion.csv";
  var_2 = 5;
  var_3 = "";
  var_4 = 0;
  var_5 = [];
  var_6 = [];
  var_7 = 0;
  var_8 = 0;
  var_9 = _id_1552("occlusion", var_0, 1);

  if(var_9 != -1) {
    var_4 = var_9;
  } else if(_id_1553()) {
    return 0;
  }
  while(var_3 != "EOF" && var_8 < 10) {
    var_3 = tablelookupbyrow(var_1, var_4, 0);

    if(var_3 != "") {
      var_8 = 0;
    }
    while(var_3 == var_0) {
      var_7 = 1;
      var_5 = undefined;

      for(var_10 = 1; var_10 < var_2 + 1; var_10++) {
        if(!isDefined(var_6[var_10])) {
          var_6[var_10] = tablelookupbyrow(var_1, 0, var_10);
        }
        var_11 = var_6[var_10];
        var_12 = tablelookupbyrow(var_1, var_4, var_10);

        if(var_12 != "") {
          switch (var_11) {
            case "channel_name":
              var_5 = spawnStruct();
              var_5._id_1724 = var_12;
              break;
            case "frequency":
              var_5._id_1726 = float(var_12);
              break;
            case "type":
              var_5.type = var_12;
              break;
            case "gain":
              var_5._id_1727 = float(var_12);
              break;
            case "q":
              var_5._id_1728 = float(var_12);
              break;
            default:
              _id_1532("In occlusion preset table, common_occlusion.csv, there is an improperly labeled parameter column, \"" + var_11 + "\".");
              break;
          }
        }
      }

      if(!isDefined(var_5._id_1726)) {
        var_5._id_1726 = 600;
      }
      if(!isDefined(var_5.type)) {
        var_5.type = "highshelf";
      }
      if(!isDefined(var_5._id_1727)) {
        var_5._id_1727 = -12;
      }
      if(!isDefined(var_5._id_1728)) {
        var_5._id_1728 = 1;
      }
      level._id_1456._id_1737[var_0][level._id_1456._id_1737[var_0].size] = var_5;
      var_4++;
      var_3 = tablelookupbyrow(var_1, var_4, 0);
    }

    var_8++;

    if(var_7) {
      return 1;
    }
    var_4++;
  }

  return 0;
}

_id_1738(var_0, var_1) {
  var_2 = "default";

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  if(!isDefined(level._id_1456._id_1737)) {
    level._id_1456._id_1737 = [];
  }
  var_3 = 1;

  if(!isDefined(level._id_1456._id_1737[var_2])) {
    level._id_1456._id_1737[var_2] = [];
    var_3 = _id_1736(var_2);
  }

  if(!var_3) {
    return;
  }
  level._id_1456._id_171F = var_2;

  if(!(isDefined(level._id_1456._id_159D) && level._id_1456._id_159D)) {
    var_4 = 10;

    if(isDefined(var_1)) {
      var_4 = var_4;
    }
    var_5 = 0;

    foreach(var_7 in level._id_1456._id_1737[var_2]) {
      level.player setocclusion(var_7._id_1724, var_7._id_1726, var_7.type, var_7._id_1727, var_7._id_1728);

      if(var_5 < var_4) {
        var_5++;
        continue;
      }

      var_5 = 0;
      wait 0.05;
    }
  }
}

_id_156E(var_0, var_1) {
  if(isDefined(level.player._id_1008) && isDefined(level.player._id_1008["player_has_red_flashing_overlay"]) && level.player maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return;
  }
  if(!isDefined(var_0)) {
    level._id_1456._id_16FE = undefined;
    return;
  }

  thread _id_1738(var_0, var_1);
}

_id_156F(var_0) {
  var_1 = 10;

  if(isDefined(var_0)) {
    var_1 = var_1;
  }
  var_2 = 0;

  foreach(var_5, var_4 in level._id_1456._id_14FD._id_152C) {
    level.player deactivateocclusion(var_5);

    if(var_2 < var_1) {
      var_2++;
      continue;
    }

    var_2 = 0;
    wait 0.05;
  }
}

_id_1739(var_0) {
  var_1 = 10;

  if(isDefined(var_0)) {
    var_1 = var_1;
  }
  _id_1570(undefined, 0, var_1);
  _id_1570(undefined, 1, var_1);
  _id_156F(var_1);
  level._id_1456._id_159D = 1;
}

_id_173A(var_0) {
  var_1 = undefined;
  var_2 = "default";
  var_3 = 10;

  if(isDefined(var_0)) {
    var_3 = var_3;
  }
  if(isDefined(level._id_1456._id_1561._id_1562) && isDefined(level._id_1456._id_1561._id_1563[level._id_1456._id_1561._id_1562])) {
    var_4 = maps\_audio_zone_manager::_id_1578();
    var_5 = level._id_1456._id_1561._id_1563[var_4];

    if(isDefined(var_5["occlusion"]) && var_5["occlusion"] != "none") {
      var_2 = var_5["occlusion"];
    }
    if(isDefined(var_5["filter"]) && var_5["filter"] != "none") {
      var_1 = var_5["filter"];
    }
  }

  if(level._id_1456._id_171F != var_2) {
    var_2 = level._id_1456._id_171F;
  }
  level._id_1456._id_159D = 0;
  _id_1570(var_1, 0, var_3);
  _id_1570(undefined, 1, var_3);
  _id_156E(var_2, var_3);
}

_id_173B(var_0) {
  level._id_1456._id_1569 = var_0;
}

_id_173C(var_0) {
  level._id_1456._id_1474 = var_0;
}

_id_173D(var_0) {
  level._id_1456._id_173E = var_0;
}

_id_173F(var_0) {
  var_1 = 1;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  level._id_1456._id_16F6 = 1;
  maps\_audio_zone_manager::_id_156A();
  maps\_audio_reverb::_id_145B();
  maps\_audio_dynamic_ambi::_id_149B();
  maps\_audio_mix_manager::_id_150E();
  maps\_audio_whizby::_id_15B6();

  if(var_1) {
    _id_17AC();
  }
  maps\_audio_whizby::_id_15B7("default");
}

_id_1740(var_0) {
  _id_173F(0);
  level._id_1456._id_16F7["map"] = var_0;
  _id_17AC();
}

_id_1741() {
  if(isDefined(level._id_1456._id_16F7["map"])) {
    return level._id_1456._id_16F7["map"];
  } else {
    return common_scripts\utility::get_template_level();
  }
}

_id_1742(var_0) {
  level._id_1456._id_16F7["mix"] = var_0;
}

_id_154F() {
  if(!isDefined(level._id_1456._id_16F7["mix"])) {
    return "soundtables/" + _id_1741() + "_mix.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["mix"];
  }
}

_id_1743(var_0) {
  level._id_1456._id_16F7["damb"] = var_0;
}

_id_14F8() {
  if(!isDefined(level._id_1456._id_16F7["damb"])) {
    return "soundtables/" + _id_1741() + "_damb.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["damb"];
  }
}

_id_1744(var_0) {
  level._id_1456._id_16F7["damb_comp"] = var_0;
}

_id_14F5(var_0) {
  if(!isDefined(level._id_1456._id_16F7["damb_comp"])) {
    return "soundtables/" + _id_1741() + "_damb_components.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["damb_comp"];
  }
}

_id_1745(var_0) {
  level._id_1456._id_16F7["damb_loops"] = var_0;
}

_id_14F0(var_0) {
  if(!isDefined(level._id_1456._id_16F7["damb_loops"])) {
    return "soundtables/" + _id_1741() + "_damb_loops.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["damb_loops"];
  }
}

_id_1746(var_0) {
  level._id_1456._id_16F7["reverb"] = var_0;
}

_id_146E() {
  if(!isDefined(level._id_1456._id_16F7["reverb"])) {
    return "soundtables/" + _id_1741() + "_reverb.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["reverb"];
  }
}

_id_1747(var_0) {
  level._id_1456._id_16F7["filter"] = var_0;
}

_id_1748() {
  if(!isDefined(level._id_1456._id_16F7["filter"])) {
    return "soundtables/" + _id_1741() + "_filter.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["filter"];
  }
}

_id_1749(var_0) {
  level._id_1456._id_16F7["zone"] = var_0;
}

_id_157F() {
  if(!isDefined(level._id_1456._id_16F7["zone"])) {
    return "soundtables/" + _id_1741() + "_zone.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["zone"];
  }
}

_id_174A(var_0) {
  level._id_1456._id_16F7["occlusion"] = var_0;
}

_id_174B() {
  if(!isDefined(level._id_1456._id_16F7["occlusion"])) {
    return "soundtables/" + _id_1741() + "_occlusion.csv";
  } else {
    return "soundtables/" + level._id_1456._id_16F7["occlusion"];
  }
}

_id_174C(var_0) {
  level._id_1456._id_16FA[level._id_1456._id_16FA.size] = var_0;
}

aud_send_msg(var_0, var_1, var_2) {
  thread _id_174D(var_0, var_1, var_2);
}

_id_174D(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in level._id_1456._id_16FA) {
    var_4 = self[[var_6]](var_0, var_1);

    if(!var_3 && isDefined(var_4) && var_4 == 1) {
      var_3 = var_4;
      continue;
    }

    if(!var_3 && !isDefined(var_4)) {
      var_3 = 1;
    }
  }

  if(isDefined(var_2)) {
    self notify(var_2);
  }
  if(!var_3) {
    _id_1466("\tAUDIO MESSAGE NOT HANDLED: " + var_0);
  }
}

_id_174E() {
  return level._id_1456._id_1702._id_1703;
}

_id_15B2(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = _id_174F();

  if(isDefined(var_4)) {
    var_3 = var_4;
  } else {
    var_5 = 3;
    var_6 = 10;
    var_7 = 100;

    if(isDefined(var_0)) {
      var_5 = var_0;
    }
    if(isDefined(var_2)) {
      var_7 = var_2;
    }
    if(isDefined(var_2)) {
      var_6 = var_1;
    }
    var_8 = 36 * var_7;
    var_9 = 36 * var_6;
    var_10 = getaiarray("bad_guys");
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in var_10) {
      if(isDefined(var_14.alertlevelint) && var_14.alertlevelint >= var_5) {
        var_15 = distance(level.player.origin, var_14.origin);

        if(var_15 < var_8) {
          var_11++;

          if(var_15 < var_9) {
            var_16 = 1.0;
          } else {
            var_16 = 1.0 - (var_15 - var_9) / (var_8 - var_9);
          }
          var_12 = var_12 + var_16;
        }
      }
    }

    if(var_11 > 0) {
      var_3 = var_12 / var_11;
    } else {
      var_3 = 0;
    }
  }

  return var_3;
}

_id_174F() {
  return level._id_1456._id_1701;
}

_id_1750(var_0) {
  level._id_1456._id_1701 = var_0;
}

_id_1751() {
  level._id_1456._id_1701 = undefined;
}

_id_1752(var_0) {
  var_1 = 0;
  var_2 = 3600;

  if(isDefined(var_0)) {
    var_2 = 36 * var_0;
  }
  var_3 = getaiarray("bad_guys");

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_6 = distance(level.player.origin, var_5.origin);

      if(var_6 < var_2) {
        var_1++;
      }
    }
  }

  return var_1;
}

_id_1753(var_0, var_1) {
  var_2 = 1;

  switch (var_0) {
    case "level_fade_to_black":
      var_3 = var_1[0];
      var_4 = var_1[1];
      wait(var_3);
      maps\_audio_mix_manager::_id_150F("mute_all", var_4);
      break;
    case "generic_building_bomb_shake":
      level.player playSound("sewer_bombs");
      break;
    case "start_player_slide_trigger":
      break;
    case "end_player_slide_trigger":
      break;
    case "missile_fired":
      break;
    case "msg_audio_fx_ambientExp":
      break;
    case "aud_play_sound_at":
      _id_179A(var_1._id_1486, var_1.pos);
      break;
    case "aud_play_dynamic_explosion":
      if(isDefined(var_1._id_1755)) {
        var_5 = var_1._id_1755;
      } else {
        var_5 = undefined;
      }
      if(isDefined(var_1._id_1756)) {
        var_6 = var_1._id_1756;
      } else {
        var_6 = undefined;
      }
      if(isDefined(var_1.velocity)) {
        var_7 = var_1.velocity;
      } else {
        var_7 = undefined;
      }
      _id_1775(var_1._id_1759, var_1._id_1758, var_1._id_1757, var_5, var_6, var_7);
      break;
    case "aud_play_conversation":
      _id_175B(var_0, var_1);
      break;
    case "xm25_contact_explode":
      if(soundexists("xm25_proj_explo")) {
        var_8 = var_1;
        thread common_scripts\utility::play_sound_in_space("xm25_proj_explo", var_8);
      }

      break;
    case "light_flicker_on":
      var_9 = var_1;
      _id_175A(var_9);
      break;
    default:
      var_2 = 0;
  }

  return var_2;
}

_id_175A(var_0) {
  var_1 = 0;

  switch (var_0.model) {
    case "furniture_lamp_table1":
    case "com_cafe_light_part1_off":
    case "furniture_lamp_floor1_off":
      var_1 = 1;

      if(soundexists("paris_lamplight_flicker")) {
        thread common_scripts\utility::play_sound_in_space("paris_lamplight_flicker", var_0.origin);
      }
      break;
    default:
      var_1 = 0;
  }

  return var_1;
}

_id_175B(var_0, var_1) {
  var_2 = var_1;
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_3[var_4] = var_2[var_4]._id_14B9._id_0AAF;
    var_2[var_4]._id_14B9._id_0AAF = 0;
  }

  foreach(var_6 in var_2) {
    if(isDefined(var_6.delay)) {
      wait(var_6.delay);
    }
    var_7 = spawn("script_origin", (0, 0, 0));
    var_7 linkto(var_6._id_14B9, "", (0, 0, 0), (0, 0, 0));
    var_7 playSound(var_6.sound, "sounddone");
    var_7 waittill("sounddone");
    wait 0.05;
    var_7 delete();
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_2[var_4]._id_14B9._id_0AAF = var_3[var_4];
  }
}

_id_175D(var_0) {
  if(!isDefined(level._id_1456._id_144F)) {
    level._id_1456._id_144F = [];
  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = var_2[0];
    var_4 = var_2[1];
    level._id_1456._id_144F[var_3] = var_4;
  }

  if(isDefined(level._id_1456._id_175E)) {
    foreach(var_3 in level._id_1456._id_175E) {}

    level._id_1456._id_175E = undefined;
  }
}

_id_175F() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.target;
}

_id_1760() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0.origin;
}

_id_1761() {
  var_0 = common_scripts\utility::get_target_ent();
  return var_0 common_scripts\utility::get_target_ent();
}

_id_1762() {
  var_0 = _id_1761();
  return var_0.origin;
}

_id_1763(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }
  if(var_1) {
    return var_0[1];
  } else {
    return var_0[0];
  }
}

_id_1764(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }
  if(var_1) {
    return var_0[0];
  } else {
    return var_0[1];
  }
}

_id_1765(var_0) {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();
  }
  if(!isDefined(level._id_1456._id_144F)) {
    level._id_1456._id_144F = [];
  }
  var_1 = undefined;

  if(isDefined(var_0) && var_0) {
    if(isDefined(self.ambient)) {
      var_1 = strtok(self.ambient, " ");
    }
  } else if(isDefined(self._id_1766)) {
    var_1 = strtok(self._id_1766, " ");
  } else if(isDefined(self._id_1767)) {
    var_1 = strtok(self._id_1767, " ");
  }
  if(isDefined(var_1) && var_1.size == 2) {} else if(isDefined(var_1) && var_1.size == 1) {
    for(;;) {
      self waittill("trigger", var_2);
      maps\_audio_zone_manager::_id_156C(var_1[0], self._id_1662);
    }
  }

  if(isDefined(self._id_1768)) {
    if(!isDefined(level._id_1456._id_16FC[self._id_1768])) {
      _id_1532("Trying to set a progress_map_function without defining the envelope in the level.aud.envs array.");
      self._id_1768 = undefined;
    }
  }

  if(!isDefined(level._id_1456._id_175E)) {
    level._id_1456._id_175E = [];
  }
  if(isDefined(self._id_1769)) {
    level._id_1456._id_175E[level._id_1456._id_175E.size] = self._id_1769;
  }
  if(isDefined(self._id_176A)) {
    level._id_1456._id_175E[level._id_1456._id_175E.size] = self._id_176A;
  }
  if(isDefined(self._id_176B)) {
    level._id_1456._id_175E[level._id_1456._id_175E.size] = self._id_176B;
  }
  if(isDefined(self._id_176C)) {
    level._id_1456._id_175E[level._id_1456._id_175E.size] = self._id_176C;
  }
  if(!isDefined(self._id_176D)) {
    self._id_176D = "blend";
  }
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.target)) {
    if(!isDefined(common_scripts\utility::get_target_ent())) {
      _id_1532("Audo Zone Trigger at " + self.origin + " has defined a target, " + self.target + ", but that target doesn't exist.");
      return;
    }

    if(isDefined(_id_175F())) {
      var_3 = _id_1760();

      if(!isDefined(_id_1761())) {
        _id_1532("Audo Zone Trigger at " + self.origin + " has defined a target, " + _id_175F() + ", but that target doesn't exist.");
        return;
      }

      var_4 = _id_1762();
    } else {
      var_6 = common_scripts\utility::get_target_ent();
      var_7 = 2 * (self.origin - var_6.origin);
      var_8 = vectortoangles(var_7);
      var_3 = _id_1760();
      var_4 = var_3 + var_7;

      if(angleclamp180(var_8[0]) < 45) {
        var_3 = (var_3[0], var_3[1], 0);
        var_4 = (var_4[0], var_4[1], 0);
      }
    }

    var_5 = distance(var_3, var_4);
  }

  var_9 = 0;

  for(;;) {
    self waittill("trigger", var_2);

    if(_id_17C4() && var_2 != level.player) {
      continue;
    }
    if(isDefined(var_3) && isDefined(var_4)) {
      var_10 = _id_1772(var_3, var_4, var_5, var_2.origin);

      if(var_10 < 0.5) {
        var_9 = 0;

        if(isDefined(self._id_176E)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            aud_send_msg(self._id_176E, var_1[0]);
          } else {
            aud_send_msg(self._id_176E, "front");
          }
        }

        if(isDefined(self._id_1769)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            if(isDefined(level._id_1456._id_144F[self._id_1769])) {
              [[level._id_1456._id_144F[self._id_1769]]](var_1[0]);
            }
          } else if(isDefined(level._id_1456._id_144F[self._id_1769])) {
            [[level._id_1456._id_144F[self._id_1769]]]("front");
          }
        }
      } else {
        var_9 = 1;

        if(isDefined(self._id_176E)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            aud_send_msg(self._id_176E, var_1[1]);
          } else {
            aud_send_msg(self._id_176E, "back");
          }
        }

        if(isDefined(self._id_1769)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            if(isDefined(level._id_1456._id_144F[self._id_1769])) {
              [[level._id_1456._id_144F[self._id_1769]]](var_1[1]);
            }
          } else if(isDefined(level._id_1456._id_144F[self._id_1769])) {
            [[level._id_1456._id_144F[self._id_1769]]]("back");
          }
        }
      }
    } else {
      if(isDefined(self._id_176E)) {
        aud_send_msg(self._id_176E);
      }
      if(isDefined(self._id_1769)) {
        if(isDefined(level._id_1456._id_144F[self._id_1769])) {
          [[level._id_1456._id_144F[self._id_1769]]]();
        }
      }
    }

    var_11 = undefined;

    if(isDefined(_id_1763(var_1, var_9)) && isDefined(_id_1764(var_1, var_9))) {
      var_11 = maps\_audio_zone_manager::_id_1588(_id_1763(var_1, var_9), _id_1764(var_1, var_9));

      if(!isDefined(var_11)) {
        return;
      }
      var_11.mode = self._id_176D;
    }

    if(isDefined(var_11) && _id_159C()) {
      if(isDefined(var_11._id_1591) || isDefined(var_11._id_1592)) {
        level.player deactivateeq(1);
      }
    }

    var_12 = -1;
    var_10 = -1;

    while(var_2 istouching(self)) {
      if(isDefined(self._id_176C)) {
        var_13 = _id_1773(var_3, var_4, var_2.origin);

        if(isDefined(level._id_1456._id_144F[self._id_176C])) {
          [[level._id_1456._id_144F[self._id_176C]]](var_13);
        }
      }

      if(isDefined(var_3) && isDefined(var_4)) {
        var_10 = _id_1772(var_3, var_4, var_5, var_2.origin);

        if(isDefined(self._id_1768)) {
          var_10 = _id_15B3(var_10, level._id_1456._id_16FC[self._id_1768]);
        }
        if(var_10 != var_12) {
          if(isDefined(_id_1763(var_1, var_9)) && isDefined(_id_1764(var_1, var_9))) {
            maps\_audio_zone_manager::_id_157A(_id_1763(var_1, var_9), _id_1764(var_1, var_9), var_10);
          }
          if(isDefined(self._id_176F)) {
            aud_send_msg(self._id_176F, var_10);
          }
          if(isDefined(self._id_176B)) {
            if(isDefined(level._id_1456._id_144F[self._id_176B])) {
              [[level._id_1456._id_144F[self._id_176B]]](var_10);
            }
          }

          if(isDefined(var_11)) {
            _id_1774(var_10, var_11, var_9);
          }
          var_12 = var_10;
          maps\_audio_zone_manager::_id_157C(var_10);
        }
      }

      if(isDefined(self._id_1770)) {
        wait(self._id_1770);
        continue;
      }

      wait 0.1;
    }

    if(isDefined(var_3) && isDefined(var_4)) {
      if(var_10 > 0.5) {
        if(isDefined(var_1) && isDefined(var_1[1])) {
          maps\_audio_zone_manager::_id_1579(var_1[1]);
        }
        if(isDefined(self._id_1771)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            aud_send_msg(self._id_1771, var_1[1]);
          } else {
            aud_send_msg(self._id_1771, "back");
          }
        }

        if(isDefined(self._id_176A)) {
          if(isDefined(var_1) && isDefined(var_1[1])) {
            if(isDefined(level._id_1456._id_144F[self._id_176A])) {
              [[level._id_1456._id_144F[self._id_176A]]](var_1[1]);
            }
          } else if(isDefined(level._id_1456._id_144F[self._id_176A])) {
            [[level._id_1456._id_144F[self._id_176A]]]("back");
          }
        }

        var_10 = 1;
      } else {
        if(isDefined(var_1) && isDefined(var_1[0])) {
          maps\_audio_zone_manager::_id_1579(var_1[0]);
        }
        if(isDefined(self._id_1771)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            aud_send_msg(self._id_1771, var_1[0]);
          } else {
            aud_send_msg(self._id_1771, "front");
          }
        }

        if(isDefined(self._id_176A)) {
          if(isDefined(var_1) && isDefined(var_1[0])) {
            if(isDefined(level._id_1456._id_144F[self._id_176A])) {
              [[level._id_1456._id_144F[self._id_176A]]](var_1[0]);
            }
          } else if(isDefined(level._id_1456._id_144F[self._id_176A])) {
            [[level._id_1456._id_144F[self._id_176A]]]("front");
          }
        }

        var_10 = 0;
      }

      if(isDefined(var_11)) {
        _id_1774(var_10, var_11, var_9);
      }
      continue;
    }

    if(isDefined(self._id_1771)) {
      aud_send_msg(self._id_1771);
    }
    if(isDefined(self._id_176A)) {
      if(isDefined(level._id_1456._id_144F[self._id_176A])) {
        [[level._id_1456._id_144F[self._id_176A]]]();
      }
    }
  }
}

_id_1772(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_3 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_2;
  return clamp(var_6, 0, 1.0);
}

_id_1773(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_1 - var_0);
  var_4 = var_2 - var_0;
  var_5 = vectordot(var_4, var_3);
  return var_3 * var_5 + var_0;
}

_id_1774(var_0, var_1, var_2) {
  var_0 = clamp(var_0, 0, 1.0);

  if(var_2) {
    var_0 = 1.0 - var_0;
  }
  var_3 = var_1.mode;

  if(var_3 == "blend") {
    var_4 = 1.0 - var_0;
    var_5 = var_0;
    maps\_audio_zone_manager::_id_159B(var_4, var_5, var_1);
  } else if(var_0 < 0.33) {
    maps\_audio_zone_manager::_id_156C(var_1._id_1589);
  } else if(var_0 > 0.66) {
    maps\_audio_zone_manager::_id_156C(var_1._id_158A);
  }
}

_id_1775(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_origin", level.player.origin);
  var_7 = spawn("script_origin", var_0);

  if(!isDefined(var_3)) {
    var_3 = distance(var_7.origin, var_6.origin);
  }
  if(!isDefined(var_4)) {
    var_8 = 30;
    var_4 = 36 * var_8;
  }

  var_9 = _id_1776(var_7.origin, var_6.origin, var_3, var_4);
  var_9[0] = (var_9[0][0], var_9[0][1], var_6.origin[2]);
  var_9[1] = (var_9[1][0], var_9[1][1], var_6.origin[2]);
  var_10 = distance(var_7.origin, var_9[0]);

  if(!isDefined(var_5)) {
    var_5 = 1800;
  }
  var_11 = var_10 / var_5;

  if(isDefined(var_9) && var_9.size == 2) {
    var_12 = spawn("script_origin", var_7.origin);
    var_13 = spawn("script_origin", var_7.origin);
    var_12 playSound(var_1);
    var_13 playSound(var_2);
    var_12 moveto(var_9[0], var_11, 0, 0);
    var_13 moveto(var_9[1], var_11, 0, 0);
  }
}

_id_1776(var_0, var_1, var_2, var_3) {
  var_4 = var_1 - var_0;
  var_5 = _id_177B(var_4);
  var_6 = _id_177B(var_4);
  var_7 = _id_177C(var_5);
  var_8 = 0.5 * var_2 / var_7;
  var_5 = _id_1778(var_5, var_8);
  var_6 = _id_1778(var_6, var_8);
  var_5 = _id_177A(var_5, 90);
  var_6 = _id_177A(var_6, -90);
  var_9 = _id_177C(var_4);
  var_10 = var_3 / var_9;
  var_11 = _id_1778(var_4, var_10);
  var_11 = var_11 + var_4;
  var_11 = var_11 + var_4;
  var_5 = var_5 + var_11;
  var_6 = var_6 + var_11;
  var_12 = [];
  var_12[0] = var_5;
  var_12[1] = var_6;
  return var_12;
}

_id_1777(var_0, var_1) {
  var_2 = var_1;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }
  return var_2;
}

_id_1778(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2]);
}

_id_1779(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

_id_177A(var_0, var_1) {
  var_2 = var_0[0] * cos(var_1) - var_0[1] * sin(var_1);
  var_3 = var_0[0] * sin(var_1) + var_0[1] * cos(var_1);
  return (var_2, var_3, var_0[2]);
}

_id_177B(var_0) {
  var_1 = (0, 0, 0);
  var_1 = var_1 + var_0;
  return var_1;
}

_id_177C(var_0) {
  return sqrt(var_0[0] * var_0[0] + var_0[1] * var_0[1]);
}

_id_177D(var_0) {
  _id_177E(var_0, "synch_frame");
}

_id_177E(var_0, var_1) {}

_id_1466(var_0) {
  _id_177E(var_0, "warning");
}

_id_1532(var_0) {
  _id_177E(var_0, "error");
}

_id_177F(var_0) {
  _id_177E(var_0);
}

_id_156D(var_0) {
  _id_177E(var_0, "zone");
}

_id_1780(var_0) {
  _id_177E(var_0, "zone_small");
}

_id_1781(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    return var_0 == var_1;
  } else {
    return !isDefined(var_0) && !isDefined(var_1);
  }
}

_id_1782(var_0) {
  return !isDefined(var_0);
}

_id_1783(var_0) {
  var_0 waittill("sounddone");
  var_0 _id_1784();
}

_id_1784() {
  common_scripts\utility::delaycall(0.05, ::delete);
}

_id_15F3(var_0, var_1) {
  var_0 scalevolume(0.0, var_1);
  var_0 common_scripts\utility::delaycall(var_1 + 0.05, ::stopsounds);
  var_0 common_scripts\utility::delaycall(var_1 + 0.1, ::delete);
}

_id_14E4(var_0, var_1) {
  var_0 scalevolume(0.0, var_1);
  wait(var_1 + 0.05);
  var_0 stoploopsound();
  wait 0.05;
  var_0 delete();
}

_id_1785(var_0, var_1) {
  if(var_0 <= var_1) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_1786(var_0, var_1) {
  if(var_0 >= var_1) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_1787(var_0, var_1, var_2) {
  if(var_0 < var_1) {
    var_0 = var_1;
  } else if(var_0 > var_2) {
    var_0 = var_2;
  }
  return var_0;
}

_id_1788(var_0, var_1, var_2, var_3, var_4) {
  var_2 = _id_1787(var_2, 0.0, 1.0);
  var_3 = _id_1786(0.05, var_3);
  var_5 = 0;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }
  if(var_5) {
    var_0 playLoopSound(var_1);
  } else {
    var_0 playSound(var_1);
  }
  var_0 scalevolume(0.0);
  var_0 common_scripts\utility::delaycall(0.05, ::scalevolume, var_2, var_3);
}

_id_1789(var_0, var_1) {
  var_4 = var_1[0][0];
  var_5 = var_1[var_1.size - 1][0];
  var_6 = var_1[0][1];
  var_7 = var_1[var_1.size - 1][1];
  var_8 = undefined;

  if(var_0 <= var_4) {
    var_8 = var_6;
  } else if(var_0 >= var_5) {
    var_8 = var_7;
  } else {
    var_9 = undefined;
    var_2 = var_4;
    var_10 = var_6;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_9 = var_1[var_3][0];
      var_11 = var_1[var_3][1];

      if(var_0 >= var_2 && var_0 < var_9) {
        var_12 = (var_0 - var_2) / (var_9 - var_2);
        var_8 = var_10 + var_12 * (var_11 - var_10);
        break;
      }

      var_2 = var_9;
      var_10 = var_11;
    }
  }

  return var_8;
}

_id_15B3(var_0, var_1) {
  var_2 = 0.0;
  var_3 = var_1.size;
  var_4 = var_1[0];

  for(var_5 = 1; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];

    if(var_0 >= var_4[0] && var_0 <= var_6[0]) {
      var_7 = var_4[0];
      var_8 = var_6[0];
      var_9 = var_4[1];
      var_10 = var_6[1];
      var_11 = (var_0 - var_7) / (var_8 - var_7);
      var_2 = var_9 + var_11 * (var_10 - var_9);
      break;
    } else {
      var_4 = var_6;
    }
  }

  return var_2;
}

_id_178A(var_0, var_1, var_2, var_3) {
  var_4 = (var_0 - var_1) / (var_2 - var_1);
  var_4 = clamp(var_4, 0.0, 1.0);
  return _id_15B3(var_4, var_3);
}

_id_178B(var_0, var_1, var_2) {
  return var_0 + var_2 * (var_1 - var_0);
}

_id_1523(var_0) {
  return var_0 == int(var_0 / 2) * 2;
}

_id_178C(var_0) {
  var_1 = maps\_audio_mix_manager::_id_152B();
  var_2 = [];

  foreach(var_4 in var_0) {}
  var_1[var_4] = undefined;

  foreach(var_4, var_7 in var_1) {}
  var_2[var_2.size] = var_4;

  return var_2;
}

_id_178D() {
  var_0 = maps\_audio_mix_manager::_id_152B();
  var_1 = [];

  foreach(var_4, var_3 in var_0) {}
  var_1[var_1.size] = var_4;

  return var_1;
}

_id_178E(var_0) {
  var_0 = clamp(var_0, 0, 1.0);
  var_1 = _id_178D();
  _id_178F(var_1, var_0);
}

_id_178F(var_0, var_1) {
  thread _id_1790(var_0, var_1);
}

_id_1790(var_0, var_1) {
  var_2 = 8;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_4 < var_0.size; var_4 = var_4 + var_2) {
    var_5 = var_4;

    for(var_3 = 0; var_3 < var_2 && var_5 < var_0.size; var_3++) {
      soundsettimescalefactor(var_0[var_5], var_1);
      var_5++;
    }

    wait 0.05;
  }
}

_id_1791() {
  var_0 = _id_178D();
  _id_178F(var_0, 1.0);
  wait 0.5;
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.4);
  soundsettimescalefactor("effects1", 0.2);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.2);
  soundsettimescalefactor("local2", 0.2);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
}

_id_1792(var_0) {
  self playSound(var_0, "sounddone");
  self waittill("sounddone");
  wait 0.05;
  self delete();
}

_id_1793(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    _id_17BF(var_1);
  } else {
    wait(var_1);
  }
  var_3 = spawn("script_origin", level.player.origin);
  var_3 thread _id_1792(var_0);
  return var_3;
}

_id_1794(var_0) {
  var_1 = spawn("script_origin", level.player.origin);
  var_1 thread _id_1792(var_0);
  return var_1;
}

_id_1795(var_0, var_1, var_2) {
  var_3 = thread _id_1793(var_0, var_1, var_2);
  return var_3;
}

_id_1796(var_0, var_1, var_2) {
  if(var_0 == "loop") {
    level endon(var_2 + "internal");
    self playLoopSound(var_1);
    level waittill(var_2);

    if(isDefined(self)) {
      self stoploopsound(var_1);
      wait 0.05;
      self delete();
    }
  } else if(var_0 == "oneshot") {
    self playSound(var_1, "sounddone");
    self waittill("sounddone");

    if(isDefined(self)) {
      self delete();
    }
  }
}

_id_1797(var_0, var_1) {
  level endon(var_1);

  while(isDefined(self)) {
    wait 0.1;
  }
  level notify(var_1 + "internal");

  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait 0.05;
    var_0 delete();
  }
}

_id_15D7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "oneshot";

  if(isDefined(var_2)) {
    var_5 = var_2;
  }
  var_6 = spawn("script_origin", var_1.origin);

  if(isDefined(var_4)) {
    var_6 linkto(var_1, "tag_origin", var_4, (0, 0, 0));
  } else {
    var_6 linkto(var_1);
  }
  if(var_5 == "loop") {
    var_1 thread _id_1797(var_6, var_3);
  }
  var_6 thread _id_1796(var_5, var_0, var_3);
  return var_6;
}

_id_1798(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1.origin);
  var_3 linkto(var_1);
  var_4 = "oneshot";

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  if(var_4 == "loop") {
    var_3 playLoopSound(var_0);
  } else {
    var_3 playSound(var_0);
  }
  return var_3;
}

_id_1799(var_0, var_1, var_2) {
  self playSound(var_0, "sounddone");

  if(isDefined(var_2)) {
    wait(var_2);
    self stopsounds();
  } else {
    self waittill("sounddone");
  }
  wait 0.05;
  self delete();
}

_id_179A(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3 thread _id_1799(var_0, var_1, var_2);
  return var_3;
}

_id_179B(var_0, var_1) {
  var_2 = spawn("script_origin", var_1);
  var_2 thread _id_170B(var_0, 1, 0.1);
  return var_2;
}

_id_179C(var_0, var_1, var_2) {
  var_3 = _id_1777(var_1, 1.0);
  var_4 = _id_1777(var_2, 1.0);
  _id_1788(self, var_0, var_3, var_4, 1);
  _id_170F(var_0);
}

_id_179D(var_0, var_1, var_2, var_3) {
  var_4 = _id_1777(var_2, 1.0);
  var_5 = _id_1777(var_3, 1.0);
  var_6 = spawn("script_origin", var_1);
  _id_1788(var_6, var_0, var_4, var_5, 1);
  return var_6;
}

_id_179E(var_0, var_1) {
  var_2 = _id_1777(var_1, 1.0);
  _id_15F3(var_0, var_2);
}

_id_179F(var_0, var_1, var_2) {
  var_1 = clamp(var_1, 0, 1.0);
  var_3 = _id_1777(var_2, 1.0);
  var_0 scalevolume(var_1, var_3);
}

_id_17A0(var_0, var_1, var_2, var_3) {
  var_4 = 0.1;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = getEntArray(var_0, "script_noteworthy");
  var_6 = var_5.size;

  foreach(var_8 in var_5) {
    var_8 playLoopSound(var_1);
    var_8._id_17A1 = 0;
  }

  while(var_6 > 0) {
    wait(var_4);

    foreach(var_8 in var_5) {
      if(var_8.health < 0 && !var_8._id_17A1) {
        var_6--;
        var_8 stoploopsound();
        var_8._id_17A1 = 1;

        if(isDefined(var_2)) {
          common_scripts\utility::play_sound_in_space(var_2, var_8.origin);
        }
      }
    }
  }
}

_id_17A2(var_0, var_1) {
  var_2 = "music_submix";

  if(!maps\_audio_mix_manager::_id_1525(var_2)) {
    maps\_audio_mix_manager::_id_1522(var_2, ["music", 1.0], var_1);
    maps\_audio_mix_manager::_id_1515(var_2);
  }

  maps\_audio_mix_manager::_id_151E(var_2, var_0, var_1);
}

_id_17A3(var_0, var_1) {
  var_2 = "ambi_submix";

  if(!maps\_audio_mix_manager::_id_1525(var_2)) {
    maps\_audio_mix_manager::_id_1522(var_2, ["ambience", 1.0], var_1);
    maps\_audio_mix_manager::_id_1515(var_2);
  }

  maps\_audio_mix_manager::_id_151E(var_2, var_0, var_1);
}

_id_17A4(var_0) {
  var_1 = 10.0;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }
  maps\_audio_mix_manager::_id_1517("mute_music", 0.1);
  wait 0.05;
  maps\_audio_mix_manager::_id_1520("mute_music", var_1);
}

_id_14E1() {
  self endon("cleanup");

  if(!isDefined(self._id_14E2)) {
    self._id_14E2 = 0;
  }
  self waittill("sounddone");

  if(isDefined(self)) {
    self._id_14E2 = 1;
    self notify("cleanup");
  }
}

_id_17A5(var_0) {
  return _id_1781(maps\_audio_zone_manager::_id_1578(), var_0);
}

_id_17A6(var_0) {
  if(isDefined(level.createfxexploders)) {
    var_1 = level.createfxexploders["" + var_0];

    if(isDefined(var_1)) {
      return var_1[0];
    }
  } else {
    for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
      var_3 = level.createfxent[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isDefined(var_3.v["exploder"])) {
        continue;
      }
      if(int(var_3.v["exploder"]) != var_0) {
        continue;
      }
      return var_3;
    }
  }

  return undefined;
}

_id_17A7(var_0, var_1, var_2, var_3) {
  thread _id_17A8(var_0, var_1, var_2, var_3);
}

_id_17A8(var_0, var_1, var_2, var_3) {
  var_1 = clamp(var_1, 0, 10);
  var_4 = 1.0;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }
  var_5 = var_4;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  maps\_audio_mix_manager::_id_1517(var_0, var_4);
  wait(var_1);
  maps\_audio_mix_manager::_id_1520(var_0, var_5);
}

_id_17A9() {
  var_0 = spawnStruct();
  var_0._id_171D = [];
  var_0._id_14FD = [];
  var_0._id_171C = [];
  var_0._id_17AA = [];
  var_0._id_17AB = 0;
  return var_0;
}

_id_17AC() {
  level._id_1456.index._id_16F8._id_14FD = _id_17AF(_id_154F());
  level._id_1456.index._id_16F8._id_171D = _id_17AF(_id_1748());
  level._id_1456.index._id_16F8._id_17AB = 1;
}

_id_1554() {
  return level._id_1456.index._id_16F8._id_17AB;
}

_id_17AD() {
  level._id_1456.index._id_16F9._id_14FD = _id_17AF("soundtables/common_mix.csv");
  level._id_1456.index._id_16F9._id_171C = _id_17AF("soundtables/common_occlusion.csv");
  level._id_1456.index._id_16F9._id_17AA = _id_17AF("soundtables/common_timescale.csv");
  level._id_1456.index._id_16F9._id_171D = _id_17AF("soundtables/common_filter.csv");
  level._id_1456.index._id_16F9._id_17AB = 1;
}

_id_1553() {
  return level._id_1456.index._id_16F9._id_17AB;
}

_id_1552(var_0, var_1, var_2) {
  var_3 = 1;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }
  var_4 = undefined;

  if(var_3) {
    var_4 = level._id_1456.index._id_16F9;
  } else {
    var_4 = level._id_1456.index._id_16F8;
  }
  var_5 = undefined;

  switch (var_0) {
    case "mix":
      var_5 = var_4._id_14FD[var_1];
      break;
    case "filter":
      var_5 = var_4._id_171D[var_1];
      break;
    case "occlusion":
      var_5 = level._id_1456.index._id_16F9._id_171C[var_1];
      break;
    case "timescale":
      var_5 = level._id_1456.index._id_16F9._id_17AA[var_1];
      break;
    default:
      break;
  }

  if(!isDefined(var_5)) {
    var_5 = -1;
  }
  return var_5;
}

_id_17AE(var_0, var_1) {
  if(var_1) {
    return level._id_1456.index._id_16F9._id_14FD[var_0];
  } else {
    return level._id_1456.index._id_16F8._id_14FD[var_0];
  }
}

_id_17AF(var_0) {
  var_1 = "";
  var_2 = 0;
  var_3 = 1;
  var_4 = [];

  for(var_5 = ""; var_2 < 10 && var_5 != "EOF"; var_3++) {
    var_5 = tablelookupbyrow(var_0, var_3, 0);

    if(isDefined(var_5) && var_5 != var_1 && var_5 != "" && var_5 != "EOF") {
      var_2 = 0;
      var_1 = var_5;
      var_4[var_1] = var_3;
      continue;
    }

    if(var_5 == "") {
      var_2++;
    }
  }

  return var_4;
}

_id_17B0(var_0) {
  return randomintrange(1, 100) <= var_0;
}

_id_17B1(var_0, var_1) {
  level endon("aud_stop_slow_mo_gunshot");
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {}
  var_4 thread _id_17B2(var_1);

  var_6 = 0;
  var_7 = level.player getcurrentweapon();

  for(;;) {
    if(level.player attackbuttonpressed()) {
      if(!var_6) {
        var_6 = 1;
        [[var_0]](var_7);
      }
    } else {
      var_6 = 0;
    }
    wait 0.05;
  }
}

_id_17B2(var_0) {
  level endon("aud_stop_slow_mo_gunshot");
  var_1 = level.player getcurrentweapon();

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_5)) {
      [[var_0]](var_1, var_2, var_3, var_5, var_6);
    }
  }
}

_id_17B3() {
  level notify("aud_stop_slow_mo_gunshot");
}

_id_17B4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return;
  self._id_17B5 = 1;
  self._id_1486 = var_0;
  self.points = var_1;
  self._id_17B7 = var_2;
  self._id_17B8 = var_5;
  self._id_17B9 = var_3;
  self._id_17BA = var_4;
  self._id_17BB = var_6;
  self playLoopSound(var_0);
  wait 0.1;
  thread _id_17BE(var_1, var_2, var_5, var_3, var_4, var_6);
}

_id_17BC() {
  self notify("stop");
}

_id_17BD() {
  return;

  if(isDefined(self._id_17B5)) {
    self playLoopSound(self._id_1486);
    wait 0.1;
    thread _id_17BE(self.points, self._id_17B7, self._id_17B8, self._id_17B9, self._id_17BA, self._id_17BB);
  }
}

_id_17BE(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("stop");
  var_6 = 0.1;

  if(isDefined(var_2)) {
    var_6 = var_2;
  }
  var_7 = 1.0;

  if(isDefined(var_5)) {
    var_7 = var_5;
  }
  if(isDefined(var_3)) {
    if(!isDefined(var_4)) {
      return;
    }
    while(isDefined(self)) {
      self setdistributed2dsound(var_0, var_1, var_6, var_7, var_3, var_4);
      wait(var_6);
    }
  } else {
    while(isDefined(self)) {
      self setdistributed2dsound(var_0, var_1, var_6, var_7);
      wait(var_6);
    }
  }
}

_id_17BF(var_0) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 thread _id_17C0(var_0);
  var_1 waittill("slo_mo_wait_done");
  var_1 delete();
}

_id_17C0(var_0) {
  var_1 = 0;

  while(var_1 < var_0) {
    var_2 = getdvarfloat("com_timescale");
    var_1 = var_1 + 0.05 / var_2;
    wait 0.05;
  }

  self notify("slo_mo_wait_done");
}

_id_17C1(var_0) {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();
  }
  level._id_1456._id_17C2 = var_0;
}

_id_17C3() {
  if(!isDefined(level._id_1456._id_17C2)) {
    level._id_1456._id_17C2 = 1.0;
  }
  wait 0.05;
  levelsoundfade(1, level._id_1456._id_17C2);
}

_id_17C4() {
  return isDefined(level._id_1456._id_17C5);
}

_id_17C6() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();
  }
  level._id_1456._id_17C5 = 1;
}

_id_17C7() {
  thread _id_17C6();
}

_id_17C8() {
  level endon(self.label + "_line_emitter_stop");
  var_0 = self._id_17C9 - self._id_17CA;
  var_1 = vectornormalize(var_0);
  var_2 = distance(self._id_17CA, self._id_17C9);
  var_3 = 0.1;

  for(;;) {
    var_4 = level.player.origin - self._id_17CA;
    var_5 = vectordot(var_4, var_1);
    var_5 = clamp(var_5, 0, var_2);
    var_6 = self._id_17CA + var_1 * var_5;

    if(!self._id_17CB) {
      self.origin = var_6;
      self playLoopSound(self._id_1486);
      self scalevolume(0);
      wait 0.05;
      self scalevolume(1.0, self._id_17CC);
      self._id_17CB = 1;
    } else {
      self moveto(var_6, var_3);
    }
    wait(var_3);
  }
}

_id_17CD(var_0) {
  level notify(var_0 + "_line_emitter_stop");
}

_id_17CE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 0.1;

  if(isDefined(var_4)) {
    var_6 = max(var_4, 0);
    var_7 = max(var_4, 0);
  }

  if(isDefined(var_5)) {
    var_7 = max(var_5, 0);
  }
  var_8 = spawn("script_origin", (0, 0, 0));
  var_8._id_1486 = var_1;
  var_8._id_17CB = 0;
  var_8._id_17CA = var_2;
  var_8._id_17C9 = var_3;
  var_8._id_17CC = var_6;
  var_8.label = var_0;
  var_8 thread _id_17C8();
  level waittill(var_0 + "_line_emitter_stop");
  var_8 scalevolume(0, var_7);
  wait(var_7);
  var_8 stoploopsound();
  wait 0.05;
  var_8 delete();
}

_id_17CF(var_0, var_1, var_2) {
  if(isDefined(self)) {
    var_3 = (1, 1, 1);
    var_4 = (1, 0, 0);
    var_5 = (0, 1, 0);
    var_6 = (0, 1, 1);
    var_7 = 5;
    var_8 = var_3;

    if(isDefined(var_1)) {
      var_7 = var_1;
    }
    if(isDefined(var_2)) {
      var_8 = var_2;

      switch (var_8) {
        case "red":
          var_8 = var_4;
          break;
        case "white":
          var_8 = var_3;
          break;
        case "blue":
          var_8 = var_6;
          break;
        case "green":
          var_8 = var_5;
          break;
        default:
          var_8 = var_3;
      }
    }

    self endon("death");

    while(isDefined(self)) {
      wait 0.05;
    }
  }
}