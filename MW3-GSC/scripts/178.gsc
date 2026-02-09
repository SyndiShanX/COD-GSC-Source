/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\178.gsc
**************************************/

_id_15C1() {
  if(!isDefined(level._id_1456)) {
    level._id_1456 = spawnStruct();
  }
  if(!isDefined(level._id_1456._id_15C2)) {
    level._id_1456._id_15C2 = spawnStruct();
    level._id_1456._id_15C2._id_15C3 = 0.1;
    level._id_1456._id_15C2._id_15C4 = 0.5;
    level._id_1456._id_15C2._id_15C5 = 0.1;
    level._id_1456._id_15C2._id_15C6 = 0.5;
    level._id_1456._id_15C2._id_15C7 = 1.5;
    level._id_1456._id_15C2._id_15C8 = 2.0;
    level._id_1456._id_15C2._id_1494 = [];
    level._id_1456._id_15C2._id_15C9 = 0;
    level._id_1456._id_15C2._id_15CA = 0;
    level._id_1456._id_15C2._id_15CB = 0;
    level._id_1456._id_15C2._id_15CC = 0;
    level._id_1456._id_15C2._id_15CD = 0;
    level._id_1456._id_15C2._id_15CE = 0;
    level._id_1456._id_15C2._id_15CF = [];
    level._id_1456._id_15C2._id_15D0 = [];
    level._id_1456._id_15C2._id_15D1 = [];
    level._id_1456._id_15C2._id_15D2 = [];
    level._id_1456._id_15C2._id_15D3 = [];
    level._id_1456._id_15C2._id_15D4 = [];
  }
}

_id_15D5(var_0, var_1) {
  level._id_1456._id_15C2._id_1494[var_0] = var_1;
}

_id_15D6(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 0.25;

  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    _id_15F4(var_0);
  }
  if(isDefined(var_4)) {
    thread maps\_audio::_id_15D7(var_4, var_2, undefined, undefined, var_5);
  }
  level._id_1456._id_15C2._id_15D1[var_0] = [];
  level._id_1456._id_15C2._id_15D1[var_0]["entity"] = var_2;

  if(!isDefined(level._id_1456._id_15C2._id_15CF[var_1])) {
    var_6 = [];
    var_6 = maps\_audio_presets_vehicles::_id_15BF(var_1, var_6);
    level._id_1456._id_15C2._id_15CF[var_1] = var_6;
  }

  level._id_1456._id_15C2._id_15D1[var_0]["entity"] = var_2;

  foreach(var_19, var_8 in level._id_1456._id_15C2._id_15CF[var_1]) {
    var_9 = spawnStruct();
    var_9._id_15D8 = var_0;
    var_9.vehicle = var_2;

    switch (var_19) {
      case "tilt":
        var_9.type = "tilt";
        var_9.callback = ::_id_161D;
        var_9._id_15D9 = -45.0;
        var_9._id_15DA = 45.0;
        break;
      case "yaw":
        var_9.type = "yaw";
        var_9.callback = ::_id_161F;
        var_9._id_15D9 = 0.0;
        var_9._id_15DA = 360.0;
        break;
      case "roll":
        var_9.type = "roll";
        var_9.callback = ::_id_1620;
        var_9._id_15D9 = -45.0;
        var_9._id_15DA = 45.0;
        break;
      case "speed":
        var_9.type = "speed";
        var_9.callback = ::_id_161E;
        var_9._id_15D9 = 0.0;
        var_9._id_15DA = 100.0;
        break;
      case "altitude":
        var_9.type = "altitude";
        var_9.callback = ::_id_1621;
        var_9._id_15D9 = 0.0;
        var_9._id_15DA = 100.0;
        break;
      case "start_stop":
        var_9.type = "start_stop";
        var_9.callback = ::_id_1622;
        var_9._id_15D9 = 0.0;
        var_9._id_15DA = 1.0;
        break;
      default:
        break;
    }

    var_9._id_15DB = level._id_1456._id_15C2._id_15C5;
    var_9._id_15DC = undefined;
    var_9._id_15DD = undefined;
    var_9._id_15DE = level._id_1456._id_15C2._id_15C4;
    var_9._id_15DF = [];
    var_9._id_15E0 = 0.5;

    if(isDefined(var_3)) {
      var_9._id_15E0 = var_3;
    }
    foreach(var_18, var_11 in var_8) {
      switch (var_11[0]) {
        case "updaterate":
          var_9._id_15DE = var_11[1];
          break;
        case "smoothness":
          var_9._id_15DB = var_11[1];
          break;
        case "smooth_up":
          var_9._id_15DC = var_11[1];
          break;
        case "smooth_down":
          var_9._id_15DD = var_11[1];
          break;
        case "heightmax":
          var_9._id_15E1 = var_11[1];
          break;
        case "callback":
          var_12 = var_11[1];
          var_9._id_15E2 = level._id_1456._id_15C2._id_1494[var_12];
          break;
        case "range":
          var_9._id_15D9 = min(var_11[1], var_11[2]);
          var_9._id_15DA = max(var_11[1], var_11[2]);
          break;
        case "multiply_by_throttle":
          var_9._id_15E3 = 1;
          break;
        case "multiply_by_leftstick":
          var_9._id_15E4 = 1;
          break;
        case "start":
          var_9._id_15E5 = spawnStruct();
          var_9._id_15E5.name = var_11[1];

          for(var_13 = 2; var_13 < var_11.size; var_13++) {
            if(isarray(var_11[var_13])) {
              var_14 = var_11[var_13][0];
              var_15 = var_11[var_13][1];

              if(var_14 == "pitch") {
                var_9._id_15E5._id_15E6 = var_15;
              } else if(var_14 == "volume") {
                var_9._id_15E5._id_15E7 = var_15;

              }
              if(!isDefined(level._id_1456._id_15C2._id_15D0[var_15])) {
                var_16 = [];
                var_16 = maps\_audio_presets_vehicles::_id_15C0(var_15, var_16);
                level._id_1456._id_15C2._id_15D0[var_15] = var_16;
              }

              continue;
            }

            level._id_1456._id_15C2._id_15D3[var_0] = var_11[var_13];
          }

          break;
        case "stop":
          var_9._id_15E8 = spawnStruct();
          var_9._id_15E8.name = var_11[1];

          for(var_13 = 2; var_13 < var_11.size; var_13++) {
            if(isarray(var_11[var_13])) {
              var_14 = var_11[var_13][0];
              var_15 = var_11[var_13][1];

              if(var_14 == "pitch") {
                var_9._id_15E8._id_15E6 = var_15;
              } else if(var_14 == "volume") {
                var_9._id_15E8._id_15E7 = var_15;

              }
              if(!isDefined(level._id_1456._id_15C2._id_15D0[var_15])) {
                var_16 = [];
                var_16 = maps\_audio_presets_vehicles::_id_15C0(var_15, var_16);
                level._id_1456._id_15C2._id_15D0[var_15] = var_16;
              }

              continue;
            }

            level._id_1456._id_15C2._id_15D4[var_0] = var_11[var_13];
          }

          break;
        case "throttle_input":
          var_9._id_15E9 = var_11[1];
          break;
        case "on_threshold":
          var_9._id_15EA = var_11[1];
          break;
        case "off_threshold":
          var_9._id_15EB = var_11[1];
          break;
        case "oneshot_duck":
          var_9._id_15EC = var_11[1];
          break;
        case "oneshot_duck_time":
          var_9._id_15ED = var_11[1];
          break;
        case "offset":
          var_9.offset = var_11[1];
          break;
        default:
          var_17 = spawnStruct();
          var_17._id_15EF = var_11[0];

          for(var_13 = 1; var_13 < var_11.size; var_13++) {
            var_15 = var_11[var_13][1];

            if(var_11[var_13][0] == "pitch") {
              var_17._id_15E6 = var_15;
            } else {
              var_17._id_15F0 = var_15;
            }
            if(!isDefined(level._id_1456._id_15C2._id_15D0[var_15])) {
              var_16 = [];
              var_16 = maps\_audio_presets_vehicles::_id_15C0(var_15, var_16);
              level._id_1456._id_15C2._id_15D0[var_15] = var_16;
            }
          }

          var_9._id_15DF[var_9._id_15DF.size] = var_17;
          break;
      }
    }

    if(var_9.type == "start_stop") {
      thread _id_1611(var_9);
      continue;
    }

    thread _id_1616(var_9);
  }
}

_id_15F1(var_0) {
  level notify("aud_veh_stop");
  var_1 = 1.0;

  if(isDefined(var_0)) {
    var_1 = max(0.1, var_0);
  }
  foreach(var_3 in level._id_1456._id_15C2._id_15F2) {
    if(var_3.size > 0) {
      foreach(var_5 in var_3) {}
      thread maps\_audio::_id_15F3(var_5, var_1);
    }
  }

  level._id_1456._id_15C2._id_15F2 = [];
}

_id_15F4(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = max(0.01, var_1);
  }
  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    level notify("aud_veh_stop_" + var_0);

    if(level._id_1456._id_15C2._id_15D1[var_0].size > 0) {
      foreach(var_5, var_4 in level._id_1456._id_15C2._id_15D1[var_0]) {
        if(var_5 != "entity" && var_5 != "speed" && var_5 != "throttle") {
          var_4 scalevolume(0.0, var_2);
        }
      }
    }

    wait(var_2 + 0.05);

    if(level._id_1456._id_15C2._id_15D1[var_0].size > 0) {
      foreach(var_5, var_4 in level._id_1456._id_15C2._id_15D1[var_0]) {
        if(var_5 != "entity" && var_5 != "speed" && var_5 != "throttle") {
          var_4 delete();
        }
      }
    }

    level._id_1456._id_15C2._id_15D1[var_0] = undefined;
  }
}

_id_15F5(var_0, var_1, var_2) {
  if(!isDefined(self._id_15F6)) {
    self._id_15F6 = [];
  }
  self._id_15F6[var_0] = spawnStruct();
  self._id_15F6[var_0]._id_15F7 = var_1;
  self._id_15F6[var_0]._id_15F8 = var_2;
}

_id_15F9() {
  self._id_15FA = 1;
  self waittill("sounddone");
  self._id_15FA = 0;
}

_id_15FB(var_0) {
  level common_scripts\utility::waittill_any("aud_veh_stop", "aud_veh_stop_" + var_0);

  if(self._id_15FA) {
    self scalevolume(0.0, 0.1);
    wait 0.1;
    self stopsounds();
    wait 0.05;
  }

  self delete();
}

_id_15FC(var_0) {
  self scalevolume(0.0, 0.05);
  wait 0.05;
  self stopsounds();
  wait 0.05;
  self._id_15FA = 0;
}

_id_15FD(var_0) {
  if(self._id_15FA) {
    _id_15FC(0.0);
  }
  self playSound(var_0, "sounddone");
  thread _id_15F9();
}

_id_15FE(var_0) {
  if(!isDefined(level._id_1456._id_15C2._id_15FF)) {
    level._id_1456._id_15C2._id_15FF = [];
  }
  if(!isDefined(level._id_1456._id_15C2._id_1600)) {
    level._id_1456._id_15C2._id_1600 = [];
  }
  if(!isDefined(level._id_1456._id_15C2._id_1601)) {
    level._id_1456._id_15C2._id_1601 = [];
  }
  if(!isDefined(level._id_1456._id_15C2._id_1602)) {
    level._id_1456._id_15C2._id_1602 = [];
  }
  level._id_1456._id_15C2._id_15FF[var_0] = [];
  level._id_1456._id_15C2._id_1601[var_0] = 0;
  level._id_1456._id_15C2._id_1600[var_0] = [];
  level._id_1456._id_15C2._id_1602[var_0] = 0;
}

_id_1603(var_0) {
  var_1 = 0;

  if(isDefined(level._id_1456._id_15C2._id_15D3[var_0]) && level._id_1456._id_15C2._id_15D3[var_0] && _id_1604(var_0)) {
    var_1 = 1;
  }
  if(isDefined(level._id_1456._id_15C2._id_15D4[var_0]) && level._id_1456._id_15C2._id_15D4[var_0] && _id_1605(var_0)) {
    var_1 = 1;
  }
  return var_1;
}

_id_1604(var_0) {
  if(level._id_1456._id_15C2._id_15FF[var_0].size > 0) {
    return 1;
  }
  return 0;
}

_id_1605(var_0) {
  if(level._id_1456._id_15C2._id_1600[var_0].size > 0) {
    return 1;
  }
  return 0;
}

_id_1606(var_0, var_1, var_2) {
  foreach(var_4 in level._id_1456._id_15C2._id_15FF[var_2]) {
    if(isDefined(var_4)) {
      var_4 setpitch(var_0, var_1);
    }
  }
}

_id_1607(var_0, var_1, var_2) {
  foreach(var_4 in level._id_1456._id_15C2._id_1600[var_2]) {
    if(isDefined(var_4)) {
      var_4 setpitch(var_0, var_1);
    }
  }
}

_id_1608(var_0, var_1, var_2) {
  foreach(var_4 in level._id_1456._id_15C2._id_15FF[var_2]) {
    if(isDefined(var_4)) {
      var_4 scalevolume(var_0, var_1);
    }
  }
}

_id_1609(var_0, var_1, var_2) {
  foreach(var_4 in level._id_1456._id_15C2._id_1600[var_2]) {
    if(isDefined(var_4)) {
      var_4 scalevolume(var_0, var_1);
    }
  }
}

_id_160A(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = spawn("script_origin", var_1.origin);
  var_5 linkto(var_1, "tag_origin", (var_4, 0, 0), (0, 0, 0));
  var_5._id_160B = level._id_1456._id_15C2._id_1601[var_2];
  var_5 playSound(var_0, "sounddone");
  var_5 thread _id_160D(var_2);
  level._id_1456._id_15C2._id_15FF[var_2][var_5._id_160B] = var_5;
  level._id_1456._id_15C2._id_1601[var_2]++;
}

_id_160C(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }
  var_5 = spawn("script_origin", var_1.origin);
  var_5 linkto(var_1, "tag_origin", (var_4, 0, 0), (0, 0, 0));
  var_5._id_160B = level._id_1456._id_15C2._id_1602[var_2];
  var_5 playSound(var_0, "sounddone");
  level._id_1456._id_15C2._id_1600[var_2][var_5._id_160B] = var_5;
  level._id_1456._id_15C2._id_1602[var_2]++;
  wait 0.05;
  var_5 thread _id_160E(var_2);
}

_id_160D(var_0) {
  self endon("kill");
  self waittill("sounddone");
  level._id_1456._id_15C2._id_15FF[var_0][self._id_160B] = undefined;

  if(isDefined(level._id_1456._id_15C2._id_15D2[var_0])) {
    level._id_1456._id_15C2._id_15D2[var_0] = undefined;
  }
  self delete();
}

_id_160E(var_0) {
  self endon("kill");
  self waittill("sounddone");
  level._id_1456._id_15C2._id_1600[var_0][self._id_160B] = undefined;

  if(isDefined(level._id_1456._id_15C2._id_15D2[var_0])) {
    level._id_1456._id_15C2._id_15D2[var_0] = undefined;
  }
  self delete();
}

_id_160F(var_0, var_1, var_2) {
  if(isDefined(level._id_1456._id_15C2._id_15D2[var_2])) {
    level._id_1456._id_15C2._id_15D2[var_2] = undefined;
  }
  var_3 = 0.1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  level._id_1456._id_15C2._id_1600[var_2][var_0._id_160B] = undefined;
  var_0 scalevolume(0.0, var_3 + 0.05);
  var_0 notify("kill");
  wait(var_3 + 0.05);
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

_id_1610(var_0, var_1, var_2) {
  if(isDefined(level._id_1456._id_15C2._id_15D2[var_2])) {
    level._id_1456._id_15C2._id_15D2[var_2] = undefined;
  }
  var_3 = 0.1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }
  level._id_1456._id_15C2._id_15FF[var_2][var_0._id_160B] = undefined;
  var_0 scalevolume(0.0, var_3 + 0.05);
  var_0 notify("kill");
  wait(var_3 + 0.05);
  var_0 stopsounds();
  wait 0.05;
  var_0 delete();
}

_id_1611(var_0) {
  var_1 = var_0._id_15D8;
  level endon("aud_veh_stop");
  level endon("aud_veh_stop_" + var_1);
  level._id_1456._id_15C2._id_15D1[var_1]["entity"] endon("death");
  var_2 = 0;
  var_3 = 0;
  var_4 = -1;
  var_5 = "off";
  var_6 = var_0._id_15DB;
  var_7 = var_0._id_15DC;
  var_8 = var_0._id_15DD;
  var_9 = var_0._id_15D9;
  var_10 = var_0._id_15DA;
  var_11 = 0;
  _id_15FE(var_1);
  var_12 = gettime();

  for(;;) {
    var_13 = [[var_0.callback]](var_0);
    var_13 = (var_13 - var_0._id_15D9) / (var_0._id_15DA - var_0._id_15D9);
    var_13 = clamp(var_13, 0.0, 1.0);
    var_11 = var_13;

    if(isDefined(var_7) && var_13 > var_2) {
      var_2 = var_2 + var_7 * (var_13 - var_2);
    } else if(isDefined(var_8) && var_13 <= var_2) {
      var_2 = var_2 + var_8 * (var_13 - var_2);
    } else {
      var_2 = var_2 + var_6 * (var_13 - var_2);
    }
    var_14 = var_2 - var_3;
    var_3 = var_2;
    var_15 = gettime();
    var_16 = var_15 - var_12;
    var_17 = 0;
    var_18 = 0;

    if((var_14 >= var_0._id_15EA || var_11 >= 0.99) && var_5 == "off" && var_16 > 200) {
      var_12 = var_15;
      var_5 = "on";
      var_17 = 1;
      wait 0.05;
      var_19 = level._id_1456._id_15C2._id_15D1[var_1]["entity"];
      thread _id_160A(var_0._id_15E5.name, var_19, var_0._id_15D8, var_0.offset);

      if(isDefined(level._id_1456._id_15C2._id_1600[var_0._id_15D8])) {
        var_20 = level._id_1456._id_15C2._id_1600[var_0._id_15D8];

        foreach(var_19 in var_20) {}
        thread _id_160F(var_19, undefined, var_0._id_15D8);
      }
    } else if((var_14 <= var_0._id_15EB || var_11 <= 0.01) && var_5 == "on" && var_16 > 200) {
      var_12 = var_15;
      var_5 = "off";
      var_18 = 1;
      wait 0.05;
      var_19 = level._id_1456._id_15C2._id_15D1[var_1]["entity"];
      thread _id_160C(var_0._id_15E8.name, var_19, var_0._id_15D8, var_0.offset);

      if(isDefined(level._id_1456._id_15C2._id_15FF[var_0._id_15D8])) {
        var_23 = level._id_1456._id_15C2._id_15FF[var_0._id_15D8];

        foreach(var_19 in var_23) {}
        thread _id_1610(var_19, undefined, var_0._id_15D8);
      }
    }

    var_26 = undefined;
    var_27 = undefined;

    if(_id_1604(var_0._id_15D8)) {
      if(var_17) {
        var_17 = 0;

        if(isDefined(var_0._id_15E5._id_15E6)) {
          var_26 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15E5._id_15E6]);
          var_26 = level._id_1456._id_15C2._id_15C6 + var_26 * (level._id_1456._id_15C2._id_15C7 - level._id_1456._id_15C2._id_15C6);
          _id_1606(var_26, var_0._id_15DE, var_0._id_15D8);
        }
      }

      if(isDefined(var_0._id_15E5._id_15F0)) {
        var_27 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15E5._id_15F0]);
        _id_1608(var_27, var_0._id_15DE, var_0._id_15D8);
      }
    }

    if(_id_1605(var_0._id_15D8)) {
      if(var_18) {
        var_18 = 0;

        if(isDefined(var_0._id_15E8._id_15E6)) {
          var_26 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15E8._id_15E6]);
          var_26 = level._id_1456._id_15C2._id_15C6 + var_26 * (level._id_1456._id_15C2._id_15C7 - level._id_1456._id_15C2._id_15C6);
          _id_1607(var_26, var_0._id_15DE, var_0._id_15D8);
        }
      }

      if(isDefined(var_0._id_15E8._id_15F0)) {
        var_27 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15E8._id_15F0]);
        _id_1609(var_27, var_0._id_15DE, var_0._id_15D8);
      }
    }

    var_4 = var_2;
    wait(var_0._id_15DE);
  }
}

_id_1612(var_0) {
  self._id_1613 = 1;

  if(isDefined(var_0)) {
    self._id_1614 = var_0;
  }
}

_id_1615() {
  self._id_1613 = undefined;
}

_id_1616(var_0) {
  var_1 = var_0._id_15D8;
  level endon("aud_veh_stop");
  level endon("aud_veh_stop_" + var_1);
  var_2 = undefined;
  var_3 = var_0._id_15DB;
  var_4 = var_0._id_15DC;
  var_5 = var_0._id_15DD;
  var_6 = var_0._id_15D9;
  var_7 = var_0._id_15DA;

  if(isDefined(var_0._id_15E1)) {
    var_8 = level._id_1456._id_15C2._id_15D1[var_1]["entity"];
    var_0._id_1617 = var_8.origin[2];
  }

  var_9 = 1;

  for(;;) {
    var_0._id_15DB = var_3;
    var_0._id_15DC = var_4;
    var_0._id_15DD = var_5;
    var_8 = level._id_1456._id_15C2._id_15D1[var_1]["entity"];

    if(isDefined(var_8._id_15F6) && isDefined(var_8._id_15F6[var_0.type]) && isDefined(var_8._id_15F6[var_0.type]._id_15F7)) {
      var_0._id_15D9 = var_8._id_15F6[var_0.type]._id_15F7;
      var_0._id_15DA = var_8._id_15F6[var_0.type]._id_15F8;
    } else {
      var_0._id_15D9 = var_6;
      var_0._id_15DA = var_7;
    }

    if(!isDefined(var_8)) {
      _id_15F1(var_0._id_15D8);
      return;
    }

    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_8._id_1613)) {
      var_10 = var_8._id_1613;

      if(isDefined(var_8._id_1614)) {
        var_11 = var_8._id_1614;
      }
    }

    var_12 = [[var_0.callback]](var_0);

    if(isDefined(var_0._id_15E3)) {
      if(var_10) {
        var_13 = var_11;
      } else {
        var_13 = _id_1622(var_0);
      }
      if(level._id_1456._id_15C2._id_15CE) {
        iprintln("throttle: " + var_13);
      }
      var_12 = var_12 * var_13;
    }

    var_12 = (var_12 - var_0._id_15D9) / (var_0._id_15DA - var_0._id_15D9);
    var_12 = clamp(var_12, 0.0, 1.0);

    if(isDefined(var_2)) {
      if(isDefined(var_0._id_15DC) && var_12 > var_2) {
        var_2 = var_2 + var_0._id_15DC * (var_12 - var_2);
      } else if(isDefined(var_0._id_15DD) && var_12 <= var_2) {
        var_2 = var_2 + var_0._id_15DD * (var_12 - var_2);
      } else {
        var_2 = var_2 + var_0._id_15DB * (var_12 - var_2);
      }
    } else {
      var_2 = var_12;
    }
    if(isDefined(var_0._id_15E2)) {
      [[var_0._id_15E2]](var_8, var_2);
    }
    foreach(var_15 in var_0._id_15DF) {}
    thread _id_1618(var_15, var_0, var_2, var_1, var_9);

    if(var_9) {
      var_9 = 0;
      wait(var_0._id_15E0);
      continue;
    }

    wait(var_0._id_15DE);
  }
}

_id_1618(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0._id_15E6)) {
    var_5 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15E6]);
    var_5 = level._id_1456._id_15C2._id_15C6 + var_5 * (level._id_1456._id_15C2._id_15C7 - level._id_1456._id_15C2._id_15C6);
  }

  if(isDefined(var_0._id_15F0)) {
    var_6 = maps\_audio::_id_15B3(var_2, level._id_1456._id_15C2._id_15D0[var_0._id_15F0]);
  }
  var_7 = 0;
  var_8 = 0;

  if(isDefined(level._id_1456._id_15C2._id_15D2[var_3])) {
    var_9 = level._id_1456._id_15C2._id_15D2[var_3];
    var_10 = gettime();
    var_11 = 2.5;

    if(isDefined(var_1._id_15ED)) {
      var_11 = var_1._id_15ED;
    }
    if(var_10 - var_9 < var_11 * 1000) {
      var_7 = 1;
    }
  }

  if(!var_7) {
    if(!isDefined(level._id_1456._id_15C2._id_15D2[var_3]) && _id_1603(var_3)) {
      var_7 = 1;
      level._id_1456._id_15C2._id_15D2[var_3] = gettime();
    }
  }

  if(var_7) {
    var_12 = 0.7;

    if(isDefined(var_1._id_15EC)) {
      var_12 = var_1._id_15EC;
    }
    var_6 = var_6 * var_12;
  }

  if(isDefined(var_1._id_15E1)) {
    var_13 = var_1.vehicle.origin[2];
    var_14 = var_13 - var_1._id_1617;

    if(var_14 > var_1._id_15E1) {
      var_6 = 0;
    }
  }

  if(!isDefined(level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF])) {
    level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] = spawn("script_origin", var_1.vehicle.origin);
    var_15 = 0;

    if(isDefined(var_1.offset)) {
      var_15 = var_1.offset;
    }
    level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] linkto(var_1.vehicle, "tag_origin", (var_15, 0, 0), (0, 0, 0));
    level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] playLoopSound(var_0._id_15EF);
    level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] scalevolume(0.0);
    wait 0.05;
    level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] scalevolume(var_6, var_1._id_15E0);
  } else {
    if(isDefined(var_5)) {
      level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] setpitch(var_5, var_1._id_15DE);
    }
    if(isDefined(var_6)) {
      level._id_1456._id_15C2._id_15D1[var_3][var_0._id_15EF] scalevolume(var_6, var_1._id_15DE);
    }
  }
}

_id_1619(var_0, var_1, var_2, var_3) {
  var_4 = "tag_origin";

  if(isDefined(var_2)) {
    var_4 = "tag_origin";
  }
  var_5 = 0;

  if(isDefined(var_3)) {
    var_5 = var_3;
  }
  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    foreach(var_8, var_7 in level._id_1456._id_15C2._id_15D1[var_0]) {
      if(var_8 != "entity" && var_8 != "speed" && var_8 != "throttle") {
        var_7 unlink();
        var_7 linkto(var_1, var_4, (var_5, 0, 0), (0, 0, 0));
      }
    }

    level._id_1456._id_15C2._id_15D1[var_0]["entity"] = var_1;
  }
}

_id_161A(var_0, var_1) {
  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    level._id_1456._id_15C2._id_15D1[var_0]["speed"] = var_1;
  }
}

_id_161B(var_0, var_1) {
  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    level._id_1456._id_15C2._id_15D1[var_0]["throttle"] = var_1;
  }
}

_id_161C(var_0, var_1) {
  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0])) {
    return;
  }
}

_id_161D(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  var_2 = var_1.angles[0];

  if(level._id_1456._id_15C2._id_15CA) {
    iprintln("tilt: " + var_2);
  }
  return var_2;
}

_id_161E(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  var_2 = 0;

  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["speed"])) {
    var_3 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["speed"];
    var_2 = var_1[[var_3]]();
  } else {
    var_2 = var_0.vehicle vehicle_getspeed();
  }
  if(level._id_1456._id_15C2._id_15C9) {
    iprintln("speed: " + var_2);
  }
  return var_2;
}

_id_161F(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  var_2 = var_1.angles[1];

  if(level._id_1456._id_15C2._id_15C9) {
    iprintln("yaw: " + var_2);
  }
  return var_2;
}

_id_1620(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  var_2 = var_1.angles[2];

  if(level._id_1456._id_15C2._id_15CC) {
    iprintln("roll: " + var_2);
  }
  return var_2;
}

_id_1621(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  return 1.0;
}

_id_1622(var_0) {
  var_1 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["entity"];
  var_2 = 0;

  if(isDefined(level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["throttle"])) {
    var_3 = level._id_1456._id_15C2._id_15D1[var_0._id_15D8]["speed"];
    var_2 = var_1[[var_3]]();
  } else if(isDefined(var_0._id_15E9) && var_0._id_15E9 == "leftstick") {
    var_4 = level.player getnormalizedmovement();
    var_5 = var_4[0];
    var_2 = 0;

    if(var_5 >= 0) {
      var_2 = var_5;
    }
  } else if(isDefined(var_0._id_15E9) && var_0._id_15E9 == "leftstick_abs") {
    var_4 = level.player getnormalizedmovement();
    var_5 = abs(var_4[0]);
    var_6 = abs(var_4[1]);
    var_2 = 2 * sqrt(var_5 * var_5 + var_6 * var_6);
    var_2 = clamp(var_2, 0, 1);
  } else if(isDefined(var_0._id_15E9) && var_0._id_15E9 == "attack") {
    if(level.player attackbuttonpressed()) {
      var_2 = 1.0;
    } else {
      var_2 = 0.0;
    }
  } else {
    var_2 = var_1 vehicle_getthrottle();
  }
  return var_2;
}

_id_1623(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self._id_1624 = spawnStruct();
  self._id_1624._id_1625 = var_0;
  self._id_1624._id_1626 = var_1;
  self._id_1624._id_1627 = var_2;
  self._id_1624._id_1628 = var_3;
  self._id_1624._id_1629 = var_4;
  thread _id_163A(var_5);
  thread _id_1639();
  thread _id_1638();
  _id_162A();
}

_id_162A() {
  self endon("death");
  self._id_162B = 1;
  self._id_162C = 0;
  self._id_162D = 0;
  self._id_162E = 0;
  self._id_162F = 0;
  self._id_1630 = spawnStruct();
  self._id_1630._id_1631 = spawn("script_origin", self.origin);
  self._id_1630._id_1631 linkto(self);
  self._id_1630._id_1632 = spawn("script_origin", self.origin);
  self._id_1630._id_1632 linkto(self);
  self._id_1630._id_1633 = spawn("script_origin", self.origin);
  self._id_1630._id_1633 linkto(self);
  self._id_1630._id_1634 = spawn("script_origin", self.origin);
  self._id_1630._id_1634 linkto(self);

  for(;;) {
    var_0 = self vehicle_getspeed();

    if(var_0 > 0.05) {
      self._id_162B = 1;
      _id_1635(var_0);
    }

    wait 0.25;
  }
}

_id_1635(var_0) {
  self endon("death");
  var_1 = 0.5;
  var_2 = 1.5;
  var_3 = 0;

  for(;;) {
    var_4 = var_0;
    wait 0.1;
    var_5 = 0.5 + self vehicle_getspeed();

    if(var_5 >= var_4) {
      if(isDefined(self._id_1624._id_1627) && self._id_162D) {
        self._id_1630._id_1631 thread _id_1636(0.5);
      }
      if(self._id_162B) {
        self._id_162B = 0;

        if(isDefined(self._id_1624._id_1628)) {
          self._id_1630._id_1634 playSound(self._id_1624._id_1628);
        }
      } else {
        if(isDefined(self._id_1624._id_1626) && !self._id_162F) {
          self._id_162F = 1;
          self._id_1630._id_1633 playLoopSound(self._id_1624._id_1626);
        }

        if(isDefined(self._id_1624._id_1625) && !self._id_162E) {
          self._id_162E = 1;
          self._id_1630._id_1632 playLoopSound(self._id_1624._id_1625);
        }

        if(!var_3) {
          if(isDefined(self._id_1624._id_1625)) {
            self._id_1630._id_1632 thread _id_1637(var_1);
          }
          if(isDefined(self._id_1624._id_1626)) {
            self._id_1630._id_1633 thread _id_1637(var_1);
          }
          var_3 = 1;
        }
      }
    } else if(var_5 < var_4) {
      if(isDefined(self._id_1624._id_1627)) {
        if(!self._id_162D) {
          self._id_162D = 1;
          self._id_1630._id_1631 playLoopSound(self._id_1624._id_1627);
        }

        self._id_1630._id_1631 thread _id_1637(0.5);
      }

      if(isDefined(self._id_1624._id_1629)) {
        self._id_1630._id_1634 playSound(self._id_1624._id_1629);
      }
      if(isDefined(self._id_1624._id_1625)) {
        self._id_1630._id_1632 thread _id_1636(0.5);
      }
      if(isDefined(self._id_1624._id_1625)) {
        self._id_1630._id_1633 thread _id_1636(0.1);
      }
      return;
    }

    wait 0.2;
  }
}

_id_1636(var_0) {
  self scalevolume(0.0, var_0);
}

_id_1637(var_0, var_1) {
  var_2 = 1.0;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }
  self scalevolume(0.0);
  wait 0.05;
  self scalevolume(var_2, var_0);
}

_id_1638() {
  self waittill("cleanup_sound_ents");
  self._id_1630._id_1631 stoploopsound();
  self._id_1630._id_1632 stoploopsound();
  self._id_1630._id_1633 stoploopsound();
  self._id_1630._id_1634 stopsounds();
  wait 0.05;
  self._id_1630._id_1631 delete();
  self._id_1630._id_1632 delete();
  self._id_1630._id_1633 delete();
  self._id_1630._id_1634 delete();
}

_id_1639() {
  self endon("cleanup_sound_ents");
  self waittill("death");
  self notify("cleanup_sound_ents");
}

_id_163A(var_0) {
  self endon("cleanup_sound_ents");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(self.health < self._id_163B) {
      break;
    }

    wait 0.05;
  }

  self notify("died");

  if(isDefined(var_0)) {
    common_scripts\utility::play_sound_in_space(var_0, self.origin);
  }
  self notify("ceanup_sound_ents");
}

_id_163C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0;

  if(isDefined(var_3)) {
    var_6 = var_3;
  }
  var_7 = 0;

  if(isDefined(var_4)) {
    var_7 = var_4;
  }
  while(isDefined(var_0)) {
    if(var_7) {
      var_8 = distance(var_0.origin, level.player.origin);
    } else {
      var_8 = distance2d(var_0.origin, level.player.origin);
    }
    if(var_6) {
      iprintln("Distance: " + var_8);
    }
    if(var_8 < var_2) {
      var_9 = spawn("script_origin", var_0.origin);
      var_9 linkto(var_0);
      var_9 playSound(var_1, "sounddone");
      var_0 notify("flyby_sound_played");
      var_9 thread _id_163D(var_0);
      var_9 thread _id_163E();
      var_9 waittill("flyby_ent", var_10);

      if(var_10 == "deathspin") {
        if(isDefined(var_5)) {
          thread common_scripts\utility::play_sound_in_space(var_5, var_9.origin);
        }
        var_9 scalevolume(0.0, 0.3);
        wait 0.4;
        var_9 stopsounds();
        wait 0.05;
        var_9 delete();
        return;
      } else if(var_10 == "sounddone") {
        wait 0.1;
        var_9 delete();
        return;
      }

      continue;
    }

    wait 0.05;
  }
}

_id_163D(var_0) {
  self endon("flyby_ent");
  var_0 waittill("deathspin");
  self notify("flyby_ent", "deathspin");
}

_id_163E() {
  self endon("flyby_ent");
  self waittill("sounddone");
  self notify("flyby_ent", "sounddone");
}