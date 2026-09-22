/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_utility.gsc
****************************************/

exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
  }

  self playSound(level.scr_sound[self.script_sound]);
}

_id_05D4(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("location_selection_complete");
  self endon("stop_location_selection");

  if(isDefined(level._id_6465)) {
    self _meth_866F(0, level._id_6465["cameraRotationInfluence"], level._id_6465["cameraTranslationInfluence"]);
  }

  thread _id_36E6("cancel_location");
  thread _id_36E6("death");
  thread _id_36E6("disconnect");
  thread _id_36E6("used");
  thread _id_36E6("weapon_change");
  thread _id_36E8();
  thread _id_36E7();
  thread _id_36E5();
  thread _id_A6AA();
  var_6 = 1;

  if(isDefined(var_5) && var_5) {
    var_6 = 2;
  }

  var_7 = int(tablelookup("mp/killstreakTable.csv", 1, var_0, 0));
  self setclientomnvar("ui_map_location_selector_streak_index", var_7);
  self setclientomnvar("ui_map_location_selector", var_6);

  if(var_2) {
    var_8 = 1;
  } else {
    var_8 = 0;
  }

  switch (var_0) {
    case "firebomb":
      var_8 = 2;
  }

  self setclientomnvar("ui_map_location_selector_directional_type", var_8);

  if(isDefined(var_4)) {
    wait(var_4);
  }

  self beginlocationselection(var_1, var_2, var_3);
  self._id_83AF = 1;
  self _meth_85EF(&"streak_targeting_started", 0);
  self setblurforplayer(10.3, 0.3);
}

_id_0618(var_0) {
  if(!var_0) {
    self setclientomnvar("ui_map_location_selector", 0);
    self setclientomnvar("ui_map_location_selector_directional_type", 0);
    self setclientomnvar("ui_map_location_selector_streak_index", 0);
    self setclientomnvar("ui_map_location_num_planes", 0);
    self setclientomnvar("ui_map_location_fighter_strike", 0);
    self setblurforplayer(0, 0.3);
    self endlocationselection();
    self._id_83AF = undefined;

    if(isDefined(level._id_6465)) {
      self _meth_866F(level._id_6465["velocityscaler"], level._id_6465["cameraRotationInfluence"], level._id_6465["cameraTranslationInfluence"]);
    }
  }
}

_id_A6AA() {
  self endon("stop_location_selection");
  self waittill("location_selection_complete");
  _id_0618(0);
}

_id_940B(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "generic";
  }

  _id_0618(var_0);
  self notify("stop_location_selection", var_1);
}

_id_36E7() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");

  for(;;) {
    level waittill("emp_update");

    if(!_id_56D7()) {
      continue;
    }
    _id_940B(0, "emp");
    return;
  }
}

_id_36E6(var_0, var_1) {
  self endon("location_selection_complete");
  self endon("stop_location_selection");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  while(var_1 > 0) {
    self waittill(var_0);
    var_1--;
  }

  _id_940B(var_0 == "disconnect", var_0);
}

_id_36E8() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  level waittill("game_ended");
  _id_940B(0, "end_game");
}

_id_36E5() {
  self endon("location_selection_complete");
  self endon("stop_location_selection");
  level waittill("host_migration_begin");
  _id_940B(0, "hostmigrate");
}

_id_5679(var_0) {
  var_1 = tablelookup("mp/attachmenttable.csv", 3, var_0, 0);

  if(isDefined(var_1) && var_1 != "") {
    return 1;
  } else {
    return 0;
  }
}

_id_4429(var_0) {
  var_1 = tablelookup("mp/attachmenttable.csv", 3, var_0, 1);
  return var_1;
}

isproductionlevelactive(var_0) {
  var_1 = getdvarint("6024", 23);
  return var_1 >= var_0;
}

productionlevelindextostring(var_0) {
  switch (var_0) {
    case 0:
      return "NOTSET";
    case 1:
      return "GOLD";
    case 2:
      return "TU1";
    case 3:
      return "TU2";
    case 4:
      return "TU3";
    case 5:
      return "CP";
    case 6:
      return "MTX1";
    case 7:
      return "MTX2";
    case 8:
      return "DLC1";
    case 9:
      return "MTX3";
    case 10:
      return "MTX3_5";
    case 11:
      return "MTX4";
    case 12:
      return "DLC2";
    case 13:
      return "MTX5";
    case 14:
      return "MTX6";
    case 15:
      return "DLC3";
    case 16:
      return "MTX7";
    case 17:
      return "MTX8";
    case 18:
      return "DLC4";
    case 19:
      return "MTX9";
    case 20:
      return "MTX10";
    case 21:
      return "MTX11";
    case 22:
      return "MTX12";
    case 23:
      return "ALL";
    case 24:
      return "NEVER";
  }
}

productionlevelstringtoindex(var_0) {
  switch (_tolower(var_0)) {
    case "notset":
    case "":
      return 0;
    case "gold":
      return 1;
    case "tu1":
      return 2;
    case "tu2":
      return 3;
    case "tu3":
      return 4;
    case "cp":
      return 5;
    case "mtx1":
      return 6;
    case "mtx2":
      return 7;
    case "dlc1":
      return 8;
    case "mtx3":
      return 9;
    case "mtx3_5":
      return 10;
    case "mtx4":
      return 11;
    case "dlc2":
      return 12;
    case "mtx5":
      return 13;
    case "mtx6":
      return 14;
    case "dlc3":
      return 15;
    case "mtx7":
      return 16;
    case "mtx8":
      return 17;
    case "dlc4":
      return 18;
    case "mtx9":
      return 19;
    case "mtx10":
      return 20;
    case "mtx11":
      return 21;
    case "mtx12":
      return 22;
    case "all":
      return 23;
    case "never":
      return 24;
  }
}

productionlevelstringtouidvarbool(var_0) {
  switch (_tolower(var_0)) {
    case "notset":
    case "":
      return 1;
    case "gold":
      return 1;
    case "tu1":
      return 1;
    case "tu2":
      return 1;
    case "tu3":
      return 1;
    case "cp":
      return 1;
    case "mtx1":
      return getdvarint("5955") == 1;
    case "mtx2":
      return getdvarint("5954") == 0;
    case "dlc1":
      return getdvarint("5953") == 0;
    case "mtx3":
      return getdvarint("mtx3_killswitch") == 0;
    case "mtx3_5":
      return getdvarint("mtx3_5_killswitch") == 0;
    case "mtx4":
      return getdvarint("mtx4_killswitch") == 0;
    case "dlc2":
      return getdvarint("dlc2_killswitch") == 0;
    case "mtx5":
      return getdvarint("mtx5_killswitch") == 0;
    case "mtx6":
      return getdvarint("mtx6_killswitch") == 0;
    case "dlc3":
      return getdvarint("dlc3_killswitch") == 0;
    case "mtx7":
      return getdvarint("mtx7_killswitch") == 0;
    case "mtx8":
      return getdvarint("mtx8_killswitch") == 0;
    case "dlc4":
      return getdvarint("dlc4_killswitch") == 0;
    case "mtx9":
      return getdvarint("mtx9_killswitch") == 0;
    case "mtx10":
      return getdvarint("mtx10_killswitch") == 0;
    case "mtx11":
      return getdvarint("mtx11_killswitch") == 0;
    case "mtx12":
      return getdvarint("mtx12_killswitch") == 0;
    case "all":
      return 0;
    case "never":
      return 0;
  }
}

_id_2CED(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread _id_2CEF(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

_id_2CEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait(var_1);

  if(!isDefined(var_2)) {
    thread[[var_0]]();
  } else if(!isDefined(var_3)) {
    thread[[var_0]](var_2);
  } else if(!isDefined(var_4)) {
    thread[[var_0]](var_2, var_3);
  } else if(!isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(!isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  }
}

getplant() {
  var_0 = self.origin + (0, 0, 10);
  var_1 = 11;
  var_2 = anglesToForward(self.angles);
  var_2 = var_2 * var_1;
  var_3[0] = var_0 + var_2;
  var_3[1] = var_0;
  var_4 = bulletTrace(var_3[0], var_3[0] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_5 = spawnStruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_4 = bulletTrace(var_3[1], var_3[1] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_5 = spawnStruct();
    var_5.origin = var_4["position"];
    var_5.angles = orienttonormal(var_4["normal"]);
    return var_5;
  }

  var_3[2] = var_0 + (16, 16, 0);
  var_3[3] = var_0 + (16, -16, 0);
  var_3[4] = var_0 + (-16, -16, 0);
  var_3[5] = var_0 + (-16, 16, 0);
  var_6 = undefined;
  var_7 = undefined;

  for(var_8 = 0; var_8 < var_3.size; var_8++) {
    var_4 = bulletTrace(var_3[var_8], var_3[var_8] + (0, 0, -1000), 0, undefined);

    if(!isDefined(var_6) || var_4["fraction"] < var_6) {
      var_6 = var_4["fraction"];
      var_7 = var_4["position"];
    }
  }

  if(var_6 == 1) {
    var_7 = self.origin;
  }

  var_5 = spawnStruct();
  var_5.origin = var_7;
  var_5.angles = orienttonormal(var_4["normal"]);
  return var_5;
}

orienttonormal(var_0) {
  var_1 = (var_0[0], var_0[1], 0);
  var_2 = length(var_1);

  if(!var_2) {
    return (0, 0, 0);
  }

  var_3 = vectorNormalize(var_1);
  var_4 = var_0[2] * -1;
  var_5 = (var_3[0] * var_4, var_3[1] * var_4, var_2);
  var_6 = vectortoangles(var_5);
  return var_6;
}

deleteplacedentity(var_0) {
  var_1 = getEntArray(var_0, "classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2] delete();
  }
}

playsoundonplayers(var_0, var_1, var_2) {
  if(level.splitscreen) {
    if(isDefined(level.players[0])) {
      level.players[0] playlocalsound(var_0);
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_2)) {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }
        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1 && !isexcluded(var_4, var_2)) {
          var_4 playlocalsound(var_0);
        }
      }
    } else {
      for(var_3 = 0; var_3 < level.players.size; var_3++) {
        var_4 = level.players[var_3];

        if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
          continue;
        }
        if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
          var_4 playlocalsound(var_0);
        }
      }
    }
  } else if(isDefined(var_2)) {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }
      if(!isexcluded(var_4, var_2)) {
        var_4 playlocalsound(var_0);
      }
    }
  } else {
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(var_4 issplitscreenplayer() && !var_4 issplitscreenplayerprimary()) {
        continue;
      }
      var_4 playlocalsound(var_0);
    }
  }
}

_id_74C3(var_0, var_1, var_2) {
  if(!_soundexists(var_0)) {
    return;
  }
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3 endon("death");
  thread common_scripts\utility::_id_2D18(var_3);

  if(isDefined(var_2)) {
    var_3 hide();

    foreach(var_5 in var_2) {
      var_3 showtoplayer(var_5);
    }
  }

  if(isDefined(var_1)) {
    var_3.origin = self.origin + var_1;
    var_3.angles = self.angles;
    var_3 linktosynchronizedparent(self);
  } else {
    var_3.origin = self.origin;
    var_3.angles = self.angles;
    var_3 linktosynchronizedparent(self);
  }

  var_3 playLoopSound(var_0);
  self waittill("stop sound" + var_0);
  var_3 stoploopsound(var_0);
  var_3 delete();
}

sortlowermessages() {
  for(var_0 = 1; var_0 < self.lowermessages.size; var_0++) {
    var_1 = self.lowermessages[var_0];
    var_2 = var_1.priority;

    for(var_3 = var_0 - 1; var_3 >= 0 && var_2 > self.lowermessages[var_3].priority; var_3--) {
      self.lowermessages[var_3 + 1] = self.lowermessages[var_3];
    }

    self.lowermessages[var_3 + 1] = var_1;
  }
}

addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  foreach(var_11 in self.lowermessages) {
    if(var_11.name == var_0) {
      if(var_11.text == var_1 && var_11.priority == var_3) {
        return;
      }
      var_9 = var_11;
      break;
    }
  }

  if(!isDefined(var_9)) {
    var_9 = spawnStruct();
    self.lowermessages[self.lowermessages.size] = var_9;
  }

  var_9.name = var_0;
  var_9.text = var_1;
  var_9.time = var_2;
  var_9.addtime = gettime();
  var_9.priority = var_3;
  var_9._id_8C1E = var_4;
  var_9._id_8B91 = var_5;
  var_9._id_39CE = var_6;
  var_9._id_39CF = var_7;
  var_9._id_00C1 = var_8;
  sortlowermessages();
}

removelowermessage(var_0) {
  if(isDefined(self.lowermessages)) {
    for(var_1 = self.lowermessages.size; var_1 > 0; var_1--) {
      if(self.lowermessages[var_1 - 1].name != var_0) {
        continue;
      }
      var_2 = self.lowermessages[var_1 - 1];

      for(var_3 = var_1; var_3 < self.lowermessages.size; var_3++) {
        if(isDefined(self.lowermessages[var_3])) {
          self.lowermessages[var_3 - 1] = self.lowermessages[var_3];
        }
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

getlowermessage() {
  return self.lowermessages[0];
}

_id_86C3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0.85;
  }

  if(!isDefined(var_7)) {
    var_7 = 3.0;
  }

  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  addlowermessage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  updatelowermessage();
}

updatelowermessage() {
  if(!isDefined(self.lowermessage)) {
    return;
  }
  var_0 = getlowermessage();

  if(!isDefined(var_0)) {
    if(isDefined(self.lowermessage) && isDefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage settext(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage._id_00C1 = var_0._id_00C1;

    if(var_0._id_8B91) {
      self.lowermessage fadeovertime(_min(var_0._id_39CF, 60));
      self.lowermessage.alpha = var_0._id_39CE;
    }

    if(var_0.time > 0 && var_0._id_8C1E) {
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    } else {
      if(var_0.time > 0 && !var_0._id_8C1E) {
        self.lowertimer settext("");
        self.lowermessage fadeovertime(_min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread _id_2403(var_0);
        thread _id_23D6(var_0);
        return;
      }

      self.lowertimer settext("");
    }
  }
}

_id_2403(var_0) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

_id_23D6(var_0) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

clearlowermessage(var_0) {
  removelowermessage(var_0);
  updatelowermessage();
}

clearlowermessages() {
  for(var_0 = 0; var_0 < self.lowermessages.size; var_0++) {
    self.lowermessages[var_0] = undefined;
  }

  if(!isDefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

printonteam(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3.team != var_1) {
      continue;
    }
    var_3 iprintln(var_0);
  }
}

printonteam(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4.team != var_1) {
      continue;
    }
    var_4 iprintln(var_0, var_2);
  }
}

printboldonteam(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_1) {
      var_3 iprintlnbold(var_0);
    }
  }
}

printboldonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintlnbold(var_0, var_2);
    }
  }
}

printonteamarg(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_1) {
      var_4 iprintln(var_0, var_2);
    }
  }
}

printonplayers(var_0, var_1) {
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_1)) {
      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == var_1) {
        var_2[var_3] iprintln(var_0);
      }

      continue;
    }

    var_2[var_3] iprintln(var_0);
  }
}

printandsoundoneveryone(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = isDefined(var_4);
  var_8 = 0;

  if(isDefined(var_5)) {
    var_8 = 1;
  }

  if(level.splitscreen || !var_7) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0 && isDefined(var_2)) {
          var_10 iprintln(var_2, var_6);
          continue;
        }

        if(var_11 == var_1 && isDefined(var_3)) {
          var_10 iprintln(var_3, var_6);
        }
      }
    }

    if(var_7) {
      level.players[0] playlocalsound(var_4);
    }
  } else if(var_8) {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0) {
          if(isDefined(var_2)) {
            var_10 iprintln(var_2, var_6);
          }

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3)) {
            var_10 iprintln(var_3, var_6);
          }

          var_10 playlocalsound(var_5);
        }
      }
    }
  } else {
    for(var_9 = 0; var_9 < level.players.size; var_9++) {
      var_10 = level.players[var_9];
      var_11 = var_10.team;

      if(isDefined(var_11)) {
        if(var_11 == var_0) {
          if(isDefined(var_2)) {
            var_10 iprintln(var_2, var_6);
          }

          var_10 playlocalsound(var_4);
          continue;
        }

        if(var_11 == var_1) {
          if(isDefined(var_3)) {
            var_10 iprintln(var_3, var_6);
          }
        }
      }
    }
  }
}

printandsoundonteam(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(var_4.team != var_0) {
      continue;
    }
    var_4 printandsoundonplayer(var_1, var_2);
  }
}

printandsoundonplayer(var_0, var_1) {
  self iprintln(var_0);
  self playlocalsound(var_1);
}

_playlocalsound(var_0) {
  if(level.splitscreen && self getentitynumber() != 0) {
    return;
  }
  self playlocalsound(var_0);
}

dvarintvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarint(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

dvarfloatvalue(var_0, var_1, var_2, var_3) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(getDvar(var_0) == "") {
    setDvar(var_0, var_1);
    return var_1;
  }

  var_4 = getdvarfloat(var_0);

  if(var_4 > var_3) {
    var_4 = var_3;
  } else if(var_4 < var_2) {
    var_4 = var_2;
  } else {
    return var_4;
  }

  setDvar(var_0, var_4);
  return var_4;
}

play_sound_on_tag(var_0, var_1) {
  if(isDefined(var_1)) {
    playsoundatpos(self gettagorigin(var_1), var_0);
  } else {
    playsoundatpos(self.origin, var_0);
  }
}

getotherteam(var_0) {
  if(level._id_6520) {}

  if(var_0 == "allies") {
    return "axis";
  } else if(var_0 == "axis") {
    return "allies";
  } else {
    return "none";
  }
}

initpersstat(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
  }
}

getpersstat(var_0) {
  return self.pers[var_0];
}

incpersstat(var_0, var_1) {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] = self.pers[var_0] + var_1;

    if((!isDefined(level.disableallplayerstats) || !level.disableallplayerstats) && (var_0 != "suicides" && var_0 != "kills" && var_0 != "deaths" || !(_id_579B() || _func_3AF() || isDefined(level._id_2F8B) && level._id_2F8B))) {
      maps\mp\gametypes\_persistence::statadd(var_0, var_1);
    }
  }
}

setpersstat(var_0, var_1) {
  self.pers[var_0] = var_1;
}

initplayerstat(var_0, var_1) {
  if(!isDefined(self.stats["stats_" + var_0])) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    self.stats["stats_" + var_0] = spawnStruct();
    self.stats["stats_" + var_0].value = var_1;

    if(!_func_367() && rankingenabled()) {
      self setplayerdata(common_scripts\utility::_id_46A7(), "round", "awards", var_0, 0);
    }
  }
}

incplayerstat(var_0, var_1) {
  if(_isagent(self)) {
    return;
  }
  var_2 = self.stats["stats_" + var_0];
  var_2.value = var_2.value + var_1;
}

setplayerstat(var_0, var_1) {
  var_2 = self.stats["stats_" + var_0];
  var_2.value = var_1;
  var_2.time = gettime();
}

getplayerstat(var_0) {
  return self.stats["stats_" + var_0].value;
}

getplayerstattime(var_0) {
  return self.stats["stats_" + var_0].time;
}

setplayerstatifgreater(var_0, var_1) {
  var_2 = getplayerstat(var_0);

  if(var_1 > var_2) {
    setplayerstat(var_0, var_1);
  }
}

setplayerstatiflower(var_0, var_1) {
  var_2 = getplayerstat(var_0);

  if(var_1 < var_2) {
    setplayerstat(var_0, var_1);
  }
}

updatepersratio(var_0, var_1, var_2) {
  if(!rankingenabled()) {
    return;
  }
  var_3 = maps\mp\gametypes\_persistence::statget(var_1);
  var_4 = maps\mp\gametypes\_persistence::statget(var_2);

  if(var_4 == 0) {
    var_4 = 1;
  }

  maps\mp\gametypes\_persistence::statset(var_0, int(var_3 * 1000 / var_4));
}

updatepersratiobuffered(var_0, var_1, var_2) {
  if(!rankingenabled()) {
    return;
  }
  var_3 = maps\mp\gametypes\_persistence::statgetbuffered(var_1);
  var_4 = maps\mp\gametypes\_persistence::statgetbuffered(var_2);

  if(var_4 == 0) {
    var_4 = 1;
  }

  maps\mp\gametypes\_persistence::statsetbuffered(var_0, int(var_3 * 1000 / var_4));
}

waittillslowprocessallowed(var_0) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(var_0) && var_0) {
      while(level.lastslowprocessframe == gettime()) {
        waitframe();
      }
    } else {
      waitframe();

      if(level.lastslowprocessframe == gettime()) {
        waitframe();

        if(level.lastslowprocessframe == gettime()) {
          waitframe();

          if(level.lastslowprocessframe == gettime()) {
            waitframe();
          }
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
}

waitfortimeornotify(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
}

_id_A6D0(var_0, var_1) {
  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      self endon(var_3);
    }
  }

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
}

isexcluded(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

leaderdialog(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(var_0 == "null") {
    return;
  }
  if(!isDefined(var_1)) {
    leaderdialogbothteams(var_0, "allies", var_0, "axis", var_2, var_3, var_4);
  } else {
    if(isDefined(var_3)) {
      for(var_5 = 0; var_5 < level.players.size; var_5++) {
        var_6 = level.players[var_5];

        if(isDefined(var_6.pers["team"]) && var_6.pers["team"] == var_1 && !isexcluded(var_6, var_3)) {
          if(var_6 issplitscreenplayer() && !var_6 issplitscreenplayerprimary()) {
            continue;
          }
          var_6 leaderdialogonplayer(var_0, var_2, undefined, var_4);
        }
      }

      return;
    }

    for(var_5 = 0; var_5 < level.players.size; var_5++) {
      var_6 = level.players[var_5];

      if(isDefined(var_6.pers["team"]) && var_6.pers["team"] == var_1) {
        if(var_6 issplitscreenplayer() && !var_6 issplitscreenplayerprimary()) {
          continue;
        }
        var_6 leaderdialogonplayer(var_0, var_2, undefined, var_4);
      }
    }
  }
}

leaderdialogbothteams(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(level.splitscreen) {
    return;
  }
  if(level.splitscreen) {
    if(level.players.size) {
      level.players[0] leaderdialogonplayer(var_0, var_4, undefined, var_6);
    }
  } else {
    if(isDefined(var_5)) {
      for(var_7 = 0; var_7 < level.players.size; var_7++) {
        var_8 = level.players[var_7];
        var_9 = var_8.pers["team"];

        if(!isDefined(var_9)) {
          continue;
        }
        if(isexcluded(var_8, var_5)) {
          continue;
        }
        if(var_8 issplitscreenplayer() && !var_8 issplitscreenplayerprimary()) {
          continue;
        }
        if(var_9 == var_1) {
          var_8 leaderdialogonplayer(var_0, var_4, undefined, var_6);
          continue;
        }

        if(var_9 == var_3) {
          var_8 leaderdialogonplayer(var_2, var_4, undefined, var_6);
        }
      }

      return;
    }

    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      var_8 = level.players[var_7];
      var_9 = var_8.pers["team"];

      if(!isDefined(var_9)) {
        continue;
      }
      if(var_8 issplitscreenplayer() && !var_8 issplitscreenplayerprimary()) {
        continue;
      }
      if(var_9 == var_1) {
        var_8 leaderdialogonplayer(var_0, var_4, undefined, var_6);
        continue;
      }

      if(var_9 == var_3) {
        var_8 leaderdialogonplayer(var_2, var_4, undefined, var_6);
      }
    }
  }
}

leaderdialogonplayers(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  foreach(var_5 in var_1) {
    var_5 leaderdialogonplayer(var_0, var_2, undefined, var_3);
  }
}

leaderdialogonplayer(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_585D) && level._id_585D) {
    return;
  }
  if(_isagent(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = self.pers["team"];

  if(isDefined(level._id_0F05) && level._id_0F05) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 != "allies" && var_4 != "axis") {
    return;
  }
  if(self issplitscreenplayer() && !self issplitscreenplayerprimary()) {
    return;
  }
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(isDefined(var_1)) {
    if(self.leaderdialoggroup == var_1) {
      if(var_2) {
        if(isDefined(self.leaderdialogactive)) {
          _id_0380::_stoplocalsound(self.leaderdialogactive, 0.1);
          self.leaderdialogactive = undefined;
        }

        thread playleaderdialogonplayer(var_0, var_4, var_3);
      }

      return;
    }

    var_5 = isDefined(self.leaderdialoggroups[var_1]);
    self.leaderdialoggroups[var_1] = var_0;
    var_0 = var_1;

    if(var_5) {
      return;
    }
  }

  if(!isDefined(self.leaderdialogactive)) {
    thread playleaderdialogonplayer(var_0, var_4, var_3);
  } else {
    self.leaderdialogqueue[self.leaderdialogqueue.size] = var_0;
    self._id_5C42[self._id_5C42.size] = var_3;
  }
}

_id_5C3C(var_0, var_1) {
  var_2 = 2;

  if(isDefined(game["dialog"]["lockouts"][var_0])) {
    var_2 = game["dialog"]["lockouts"][var_0];

    if(var_2 == 0) {
      return;
    }
  }

  if(!isDefined(var_1._id_08C9)) {
    var_1._id_08C9 = [];
  }

  var_1._id_08C9[var_0] = 1;
  thread _id_5C3B(var_0, var_1, var_2);
}

_id_5C3B(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait(var_2);
  var_1._id_08C9[var_0] = undefined;
}

_id_5C3A(var_0, var_1) {
  if(isDefined(var_1._id_08C9)) {
    if(isDefined(var_1._id_08C9[var_0])) {
      if(isDefined(var_1._id_08C9[var_0] == 1)) {
        return 1;
      }
    }
  }

  return 0;
}

playleaderdialogonplayer(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("playLeaderDialogOnPlayer");
  self endon("playLeaderDialogOnPlayer");

  if(isDefined(self.leaderdialoggroups[var_0])) {
    var_3 = var_0;
    var_0 = self.leaderdialoggroups[var_3];
    self.leaderdialoggroups[var_3] = undefined;
    self.leaderdialoggroup = var_3;
  }

  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  if(_isai(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](var_0, var_2);
  }

  if(issubstr(game["dialog"][var_0], "null")) {
    return;
  }
  var_4 = game["voice"][var_1] + game["dialog"][var_0];

  if(_soundexists(var_4)) {
    if(_id_5C3A(game["dialog"][var_0], self)) {
      return;
    }
    if(_id_5727()) {
      return;
    }
    if(isDefined(self.leaderdialogactive)) {
      _id_0380::_stoplocalsound(self.leaderdialogactive, 0.1);
      self.leaderdialogactive = undefined;
    }

    self.leaderdialogactive = _id_0380::_id_2888(var_4, self);
    _id_5C3C(game["dialog"][var_0], self);
  } else {}

  if(isDefined(level._id_2EBB)) {
    [[level._id_2EBB]](var_0, var_4);
  } else {
    wait 2.0;
  }

  self.leaderdialoglocalsound = "";
  self.leaderdialogactive = undefined;
  self.leaderdialoggroup = "";

  if(self.leaderdialogqueue.size > 0) {
    var_5 = self.leaderdialogqueue[0];
    var_6 = self._id_5C42[0];

    for(var_7 = 1; var_7 < self.leaderdialogqueue.size; var_7++) {
      self.leaderdialogqueue[var_7 - 1] = self.leaderdialogqueue[var_7];
    }

    for(var_7 = 1; var_7 < self._id_5C42.size; var_7++) {
      self._id_5C42[var_7 - 1] = self._id_5C42[var_7];
    }

    self.leaderdialogqueue[var_7 - 1] = undefined;
    self._id_5C42[var_7 - 1] = undefined;
    thread playleaderdialogonplayer(var_5, var_1, var_6);
  }
}

_id_45AA() {
  for(var_0 = 0; var_0 < self.leaderdialogqueue.size; var_0++) {
    if(issubstr(self.leaderdialogqueue[var_0], "losing")) {
      if(self.team == "allies") {
        if(issubstr(level._id_147A, self.leaderdialogqueue[var_0])) {
          return self.leaderdialogqueue[var_0];
        } else {
          common_scripts\utility::_id_0F93(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);
        }
      } else if(issubstr(level._id_0BF4, self.leaderdialogqueue[var_0]))
        return self.leaderdialogqueue[var_0];
      else {
        common_scripts\utility::_id_0F93(self.leaderdialogqueue, self.leaderdialogqueue[var_0]);
      }

      continue;
    }

    return level._id_0BF4[self.leaderdialogqueue];
  }
}

_id_6C2A() {
  self endon("disconnect");
  var_0 = [];
  var_0 = self.leaderdialogqueue;

  for(var_1 = 0; var_1 < self.leaderdialogqueue.size; var_1++) {
    if(issubstr(self.leaderdialogqueue[var_1], "losing")) {
      for(var_2 = var_1; var_2 >= 0; var_2--) {
        if(!issubstr(self.leaderdialogqueue[var_2], "losing") && var_2 != 0) {
          continue;
        }
        if(var_2 != var_1) {
          _id_0FBD(var_0, self.leaderdialogqueue[var_1], var_2);
          common_scripts\utility::_id_0F93(var_0, self.leaderdialogqueue[var_1]);
          break;
        }
      }
    }
  }

  self.leaderdialogqueue = var_0;
}

_id_3D8B() {
  self.leaderdialoggroups = [];
  self.leaderdialogqueue = [];
  self.leaderdialogactive = undefined;
  self._id_293C = "";
  self notify("flush_dialog");
}

_id_3D8C(var_0) {
  foreach(var_2 in level.players) {
    var_2 _id_3D8D(var_0);
  }
}

_id_0FC0(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  while(var_2 < var_0.size) {
    if(var_0[var_2] == var_1) {
      var_2++;
      continue;
    }

    if(var_2 != var_3) {
      var_0[var_3] = var_0[var_2];
    }

    var_2++;
    var_3++;
  }

  while(var_3 < var_0.size) {
    var_0[var_3] = undefined;
    var_3++;
  }
}

_id_3D8D(var_0) {
  self.leaderdialoggroups[var_0] = undefined;
  _id_0FC0(self.leaderdialogqueue, var_0);

  if(self.leaderdialogqueue.size == 0) {
    _id_3D8B();
  }
}

updatemainmenu() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
  } else {
    self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
  }
}

updateobjectivetext() {
  if(self.pers["team"] == "spectator") {
    self setclientdvar("cg_objectiveText", "");
  } else {
    if(getwatcheddvar("scorelimit") > 0 && !isobjectivebased()) {
      if(level.splitscreen) {
        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
        return;
      }

      self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), getwatcheddvar("scorelimit"));
      return;
      return;
    }

    self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
  }
}

setobjectivetext(var_0, var_1) {
  game["strings"]["objective_" + var_0] = var_1;
}

setobjectivescoretext(var_0, var_1) {
  game["strings"]["objective_score_" + var_0] = var_1;
}

setobjectivehinttext(var_0, var_1) {
  game["strings"]["objective_hint_" + var_0] = var_1;
}

getobjectivetext(var_0) {
  return game["strings"]["objective_" + var_0];
}

getobjectivescoretext(var_0) {
  return game["strings"]["objective_score_" + var_0];
}

getobjectivehinttext(var_0) {
  return game["strings"]["objective_hint_" + var_0];
}

gettimepassed() {
  if(!isDefined(level.starttime) || !isDefined(level.discardtime)) {
    return 0;
  }

  if(level.timerstopped) {
    return level.timerpausetime - level.starttime - level.discardtime;
  } else {
    return gettime() - level.starttime - level.discardtime;
  }
}

_id_4705() {
  if(!isDefined(level._id_6027)) {
    return 0;
  }

  return gettime() - level._id_6027;
}

_id_44FA() {
  var_0 = getmatchdata("match_common", "game_length_seconds") * 1000;
  var_0 = var_0 + _id_4705();
  return var_0;
}

_id_44FB() {
  var_0 = _id_44FA();
  var_1 = int(var_0 / 1000);
  return var_1;
}

_id_46E4() {
  return gettimepassed() / (gettimelimit() * 60 * 1000) * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

_id_2315(var_0) {
  var_0 = int(var_0);

  if(var_0 > 32767) {
    var_0 = 32767;
  }

  if(var_0 < -32768) {
    var_0 = -32768;
  }

  return var_0;
}

_id_2314(var_0) {
  var_0 = int(var_0);

  if(var_0 > 255) {
    var_0 = 255;
  }

  if(var_0 < 0) {
    var_0 = 0;
  }

  return var_0;
}

clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self._id_0020 = 0;
  self._id_014A = 0;
  self._id_0188 = 0;
  self._id_0189 = 0;
}

_id_5727() {
  var_0 = "Player";

  if(istestclient(self)) {
    var_0 = "TestClient";
  }

  if(_isagent(self)) {
    var_0 = "Agent";
  }

  var_1 = "ERROR: self.spectateKillcam is " + self._id_0188 + ", but self.forcespectatorclient = " + self.forcespectatorclient + " and self.killcamentity = " + self.killcamentity + " (self is " + var_0 + ")";
  return self._id_0188;
}

isvalidclass(var_0) {
  return isDefined(var_0) && var_0 != "";
}

getvalueinrange(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_2;
  } else if(var_0 < var_1) {
    return var_1;
  } else {
    return var_0;
  }
}

_id_5EB0() {
  if(!isDefined(self.pers["summary"])) {
    return;
  }
  if(_isai(self)) {
    return;
  }
  var_0 = 0;

  if(isDefined(self._id_9A06["total"])) {
    var_0 = self._id_9A06["total"];
  }

  _reconevent("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s", self.pers["summary"]["xp"], var_0, self.pers["summary"]["score"], self.pers["summary"]["challenge"], self.pers["summary"]["match"], self.pers["summary"]["misc"], level.gametype);
}

registerroundswitchdvar(var_0, var_1, var_2, var_3) {
  registerwatchdvarint("roundswitch", var_1);
  var_0 = "scr_" + var_0 + "_roundswitch";
  level.roundswitchdvar = var_0;
  level.roundswitchmin = var_2;
  level.roundswitchmax = var_3;
  level.roundswitch = getdvarint(var_0, var_1);

  if(level.roundswitch < var_2) {
    level.roundswitch = var_2;
  } else if(level.roundswitch > var_3) {
    level.roundswitch = var_3;
  }
}

registerroundlimitdvar(var_0, var_1) {
  registerwatchdvarint("roundlimit", var_1);
}

registernumteamsdvar(var_0, var_1) {
  registerwatchdvarint("numTeams", var_1);
}

registerwinlimitdvar(var_0, var_1) {
  registerwatchdvarint("winlimit", var_1);
}

registerscorelimitdvar(var_0, var_1) {
  registerwatchdvarint("scorelimit", var_1);
}

registertimelimitdvar(var_0, var_1) {
  registerwatchdvarfloat("timelimit", var_1);
  setDvar("ui_timelimit", gettimelimit());
}

registerhalftimedvar(var_0, var_1) {
  registerwatchdvarint("halftime", var_1);
  setDvar("ui_halftime", gethalftime());
}

registernumlivesdvar(var_0, var_1) {
  registerwatchdvarint("numlives", var_1);
}

setovertimelimitdvar(var_0) {
  setDvar("overtimeTimeLimit", var_0);
}

get_damagable_player(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 1;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damagable_sentry(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.issentry = 1;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damagable_grenade(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

_id_4139(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isplayer = 0;
  var_2.isadestructable = 0;
  var_2.entity = var_0;
  var_2.damagecenter = var_1;
  return var_2;
}

get_damagable_player_pos(var_0) {
  return var_0.origin + (0, 0, 32);
}

_id_469E() {
  if(self getstance() == "crouch") {
    var_0 = self.origin + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var_0 = self.origin + (0, 0, 10);
  } else {
    var_0 = self.origin + (0, 0, 32);
  }

  return var_0;
}

get_damagable_grenade_pos(var_0) {
  return var_0.origin;
}

getdvarvec(var_0) {
  var_1 = getDvar(var_0);

  if(var_1 == "") {
    return (0, 0, 0);
  }

  var_2 = strtok(var_1, " ");

  if(var_2.size < 3) {
    return (0, 0, 0);
  }

  setDvar("tempR", var_2[0]);
  setDvar("tempG", var_2[1]);
  setDvar("tempB", var_2[2]);
  return (getdvarfloat("tempR"), getdvarfloat("tempG"), getdvarfloat("tempB"));
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

_takeweaponsexcept(var_0) {
  var_1 = self getweaponlistall();

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      continue;
    } else {
      self takeweapon(var_3);
    }
  }
}

savedata() {
  var_0 = spawnStruct();
  var_0.offhandclass = self getoffhandsecondaryclass();
  var_0.actionslots = self.saved_actionslotdata;
  var_0.currentweapon = self getcurrentweapon();
  var_1 = self getweaponlistall();
  var_0.weapons = [];

  foreach(var_3 in var_1) {
    if(weaponinventorytype(var_3) == "exclusive") {
      continue;
    }
    if(weaponinventorytype(var_3) == "altmode") {
      continue;
    }
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.clipammor = self getweaponammoclip(var_3, "right");
    var_4.clipammol = self getweaponammoclip(var_3, "left");
    var_4.stockammo = self getweaponammostock(var_3);

    if(isDefined(self.throwinggrenade) && self.throwinggrenade == var_3) {
      var_4.stockammo--;
    }

    var_0.weapons[var_0.weapons.size] = var_4;
  }

  self.script_savedata = var_0;
}

restoredata() {
  var_0 = self.script_savedata;
  self setoffhandsecondaryclass(var_0.offhandclass);

  foreach(var_2 in var_0.weapons) {
    self setweaponammoclip(var_2.name, var_2.clipammor, "right");

    if(issubstr(var_2.name, "akimbo")) {
      self setweaponammoclip(var_2.name, var_2.clipammol, "left");
    }

    self setweaponammostock(var_2.name, var_2.stockammo);
  }

  foreach(var_6, var_5 in var_0.actionslots) {
    _setactionslot(var_6, var_5.type, var_5._id_586B);
  }

  if(self getcurrentweapon() == "none") {
    var_2 = var_0.currentweapon;

    if(var_2 == "none") {
      var_2 = common_scripts\utility::_id_4550();
    }

    self setspawnweapon(var_2);
    self switchtoweapon(var_2);
  }
}

_id_867B(var_0) {
  self._id_008F = var_0;
  setpersstat("extrascore0", var_0);
}

_id_867C(var_0) {
  self._id_0090 = var_0;
  setpersstat("extrascore1", var_0);
}

_setactionslot(var_0, var_1, var_2) {
  self.saved_actionslotdata[var_0].type = var_1;
  self.saved_actionslotdata[var_0]._id_586B = var_2;
  self setactionslot(var_0, var_1, var_2);
}

scalevolume() {
  _setactionslot(1, "");
  _setactionslot(2, "");
  _setactionslot(3, "altMode");
  _setactionslot(4, "");

  if(!level._id_258F) {
    _setactionslot(5, "");
    _setactionslot(6, "");
    _setactionslot(7, "");
    _setactionslot(8, "");
  }
}

isfloat(var_0) {
  if(int(var_0) != var_0) {
    return 1;
  }

  return 0;
}

registerwatchdvarint(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarint(var_2, var_1);
  level.watchdvars[var_2].type = "int";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

registerwatchdvarfloat(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getdvarfloat(var_2, var_1);
  level.watchdvars[var_2].type = "float";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

registerwatchdvar(var_0, var_1) {
  var_2 = "scr_" + level.gametype + "_" + var_0;
  level.watchdvars[var_2] = spawnStruct();
  level.watchdvars[var_2].value = getDvar(var_2, var_1);
  level.watchdvars[var_2].type = "string";
  level.watchdvars[var_2].notifystring = "update_" + var_0;
}

_id_86EA(var_0, var_1) {
  var_0 = "scr_" + level.gametype + "_" + var_0;
  level._id_6CC8[var_0] = var_1;
}

getwatcheddvar(var_0) {
  var_0 = "scr_" + level.gametype + "_" + var_0;

  if(isDefined(level._id_6CC8) && isDefined(level._id_6CC8[var_0])) {
    return level._id_6CC8[var_0];
  }

  return level.watchdvars[var_0].value;
}

updatewatcheddvars() {
  while(game["state"] == "playing") {
    foreach(var_2, var_1 in level.watchdvars) {
      updatewatcheddvar(var_2);
    }

    wait 1.0;
  }
}

updatewatcheddvar(var_0) {
  var_1 = level.watchdvars[var_0];

  if(var_1.type == "string") {
    var_2 = getproperty(var_0, var_1.value);
  } else if(var_1.type == "float") {
    var_2 = getfloatproperty(var_0, var_1.value);
  } else {
    var_2 = getintproperty(var_0, var_1.value);
  }

  if(var_2 != var_1.value) {
    var_1.value = var_2;
    level notify(var_1.notifystring, var_2);
  }
}

isroundbased() {
  if(!level.teambased && !common_scripts\utility::_id_562E(level.roundbasedffa)) {
    return 0;
  }

  if(getwatcheddvar("winlimit") != 1 && getwatcheddvar("roundlimit") != 1) {
    return 1;
  }

  return 0;
}

_id_56F0() {
  if(!level.teambased) {
    return 1;
  }

  if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] == 0) {
    return 1;
  }

  if(getwatcheddvar("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0) {
    return 1;
  }

  return 0;
}

islastround() {
  if(!level.teambased) {
    return 1;
  }

  if(getwatcheddvar("roundlimit") > 1 && game["roundsPlayed"] >= getwatcheddvar("roundlimit") - 1) {
    return 1;
  }

  if(getwatcheddvar("winlimit") > 1 && isDefined(game["roundsWon"]) && game["roundsWon"]["allies"] >= getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] >= getwatcheddvar("winlimit") - 1) {
    return 1;
  }

  return 0;
}

wasonlyround() {
  if(!level.teambased && !common_scripts\utility::_id_562E(level.roundbasedffa)) {
    return 1;
  }

  if(isDefined(level._id_6B54)) {
    return 0;
  }

  if(getwatcheddvar("winlimit") == 1 && hitwinlimit()) {
    return 1;
  }

  if(getwatcheddvar("roundlimit") == 1) {
    return 1;
  }

  return 0;
}

waslastround() {
  if(level._id_3E16) {
    return 1;
  }

  if(!level.teambased && !common_scripts\utility::_id_562E(level.roundbasedffa)) {
    return 1;
  }

  if(hitroundlimit() || hitwinlimit()) {
    return 1;
  }

  return 0;
}

hitroundlimit() {
  if(getwatcheddvar("roundlimit") <= 0) {
    return 0;
  }

  return game["roundsPlayed"] >= getwatcheddvar("roundlimit");
}

hitscorelimit() {
  if(isobjectivebased()) {
    return 0;
  }

  if(getwatcheddvar("scorelimit") <= 0) {
    return 0;
  }

  if(level.teambased) {
    if(game["teamScores"]["allies"] >= getwatcheddvar("scorelimit") || game["teamScores"]["axis"] >= getwatcheddvar("scorelimit")) {
      return 1;
    }
  } else {
    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      var_1 = level.players[var_0];

      if(isDefined(var_1.score) && var_1.score >= getwatcheddvar("scorelimit")) {
        return 1;
      }
    }
  }

  return 0;
}

hitwinlimit() {
  if(getwatcheddvar("winlimit") <= 0) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(level.roundbasedffa)) {
    return 0;
  }

  if(!level.teambased) {
    return 1;
  }

  if(getroundswon("allies") >= getwatcheddvar("winlimit") || getroundswon("axis") >= getwatcheddvar("winlimit")) {
    return 1;
  }

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(getwatcheddvar("roundlimit")) {
      return getwatcheddvar("roundlimit");
    } else {
      return getwatcheddvar("winlimit");
    }
  } else
    return getwatcheddvar("scorelimit");
}

getroundswon(var_0) {
  return game["roundsWon"][var_0];
}

isobjectivebased() {
  return level.objectivebased;
}

_id_579B() {
  return isDefined(level._id_579A) && level._id_579A && isDefined(level._id_79C2);
}

_id_585F() {
  return isDefined(level._id_585D) && level._id_585D;
}

iszombiegameshattermode() {
  if(_id_585F() == 0) {
    return 0;
  }

  var_0 = _id_4571();
  return isDefined(level.iszombiesshotgun) && level.iszombiesshotgun;
}

getcurzombiegameshatterindex() {
  if(iszombiegameshattermode() == 0) {
    return -1;
  }

  var_0 = _id_4571();

  if(var_0 == "mp_zombie_windmill") {
    return 1;
  } else if(var_0 == "mp_zombie_dnk") {
    return 2;
  } else if(var_0 == "mp_zombie_dig_02") {
    return 3;
  }

  return -1;
}

isprophuntgametype() {
  return common_scripts\utility::_id_562E(level.isprophunt);
}

isdogfightgametype() {
  return common_scripts\utility::_id_562E(level.isdogfight);
}

gettimelimit() {
  if(inovertime()) {
    var_0 = _float(getDvar("overtimeTimeLimit"));

    if(!isDefined(var_0)) {
      var_0 = 1;
    }

    return var_0;
  } else if(isDefined(level._id_2D64) && level._id_2D64 == 1 && isDefined(level._id_18EE) && level._id_18EE == 1 && isDefined(level._id_3992))
    return getwatcheddvar("timelimit") + 2 * level._id_3992;
  else if(level.gametype == "onevone" && isDefined(level._id_09B7)) {
    return getwatcheddvar("timelimit") + level._id_09B7;
  } else if(level.gametype == "ctf" && isDefined(level._id_289F) && level._id_289F && isDefined(level._id_3992)) {
    return getwatcheddvar("timelimit") + 2 * level._id_3992;
  }

  return getwatcheddvar("timelimit");
}

gethalftime() {
  if(inovertime()) {
    return 0;
  }

  return getwatcheddvar("halftime");
}

inovertime() {
  return isDefined(game["status"]) && _id_576C(game["status"]);
}

_id_576C(var_0) {
  return var_0 == "overtime" || var_0 == "overtime_halftime";
}

gamehasstarted() {
  if(isDefined(level.gamehasstarted)) {
    return level.gamehasstarted;
  }

  if(level.teambased) {
    return level.hasspawned["axis"] && level.hasspawned["allies"];
  }

  return level.maxplayercount > 1;
}

getaverageorigin(var_0) {
  var_1 = (0, 0, 0);

  if(!var_0.size) {
    return undefined;
  }

  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3.origin;
  }

  var_5 = int(var_1[0] / var_0.size);
  var_6 = int(var_1[1] / var_0.size);
  var_7 = int(var_1[2] / var_0.size);
  var_1 = (var_5, var_6, var_7);
  return var_1;
}

getlivingplayers(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isalive(var_3)) {
      continue;
    }
    if(level.teambased && isDefined(var_0)) {
      if(var_0 == var_3.pers["team"]) {
        var_1[var_1.size] = var_3;
      }

      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

setusingremote(var_0) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  self.usingremote = var_0;
  common_scripts\utility::_disableoffhandweapons();
  self notify("using_remote");
}

getremotename() {
  return self.usingremote;
}

freezecontrolswrapper(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    self freezecontrols(1);
    return;
  }

  self freezecontrols(var_0);
  self.controlsfrozen = var_0;
}

_id_3E8F(var_0) {
  if(!var_0) {
    self disableoffhandsecondaryweapons();
    self disableoffhandweapons();
  } else {
    self enableoffhandsecondaryweapons();
    self enableoffhandweapons();
  }

  self _meth_8546(var_0);
  self allowjump(var_0);
  self allowfire(var_0);
  self _meth_86CD(1, var_0, var_0);
  self allowprone(1);
  self allowcrouch(1);
  self allowmelee(var_0);
  self allowmantle(var_0);

  if(!_hasexperimentalbtperk("specialty_class_snowblind")) {
    self allowads(1);
  }

  self.controlsfrozen = !var_0;
}

_id_3E90(var_0, var_1) {
  wait(var_1);

  if(isDefined(self)) {
    freezecontrolswrapper(var_0);
  }
}

clearusingremote() {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  common_scripts\utility::_id_0614();
  var_0 = self getcurrentweapon();

  if(var_0 == "none" || iskillstreakweapon(var_0)) {
    self switchtoweapon(common_scripts\utility::_id_4550());
  }

  freezecontrolswrapper(0);
  _id_7441();
  self notify("stopped_using_remote");
}

_id_7440() {
  self setclientomnvar("ui_killstreak_remote", 1);
}

_id_7441() {
  self setclientomnvar("ui_killstreak_remote", 0);
}

_id_43D1() {
  if(isDefined(self._id_A01A)) {
    if(self._id_A01A == "shallow" && isDefined(level._id_8ACF)) {
      return level._id_8ACF;
    }

    if(self._id_A01A == "deep" && isDefined(level._id_2B7C)) {
      return level._id_2B7C;
    }

    if(self._id_A01A != "none" && isDefined(level._id_8ACF)) {
      return level._id_8ACF;
    }
  }

  return "none";
}

_id_4739(var_0, var_1) {
  if(!rankingenabled() || _id_761E()) {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_1) && isPlayer(var_0) && (iscacprimaryweapon(var_1) || iscacsecondaryweapon(var_1))) {
    var_2 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", _id_45B5(var_1), "prestigeLevel");
    var_3 = var_0 getplayerdata(common_scripts\utility::_id_46AE(), "weaponStats", _id_45B5(var_1), "kills");
    return _func_362(var_3, var_2);
  } else
    return 0;
}

isusingremote() {
  return isDefined(self.usingremote);
}

_id_572D() {
  return isDefined(self._id_7C67);
}

_id_57B0() {
  return isDefined(self._id_57B0) && self._id_57B0;
}

_id_6F74(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isDefined(level.players)) {
    common_scripts\utility::_id_0FB2(level.players, var_0, var_1);
  }

  if(isDefined(level._id_596C)) {
    common_scripts\utility::_id_0FB2(level._id_596C, var_0, var_1);
  }

  for(;;) {
    level waittill("connected", var_3);
    common_scripts\utility::_id_0FB2([var_3], var_0, var_1);
  }
}

safe_str(var_0) {
  if(isDefined(var_0)) {
    return "" + var_0;
  }

  return "<undefined>";
}

print3d_lines(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_6 = "";

  foreach(var_8 in var_1) {
    var_6 = var_6 + "\n";
  }
}

_id_9466(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = " ";
  }

  var_2 = "";
  var_3 = "";

  foreach(var_5 in var_0) {
    var_2 = var_2 + (var_3 + var_5);
    var_3 = var_1;
  }

  return var_2;
}

_id_5DC8() {
  var_0 = spawnStruct();
  var_0._id_005C = 0;
  return var_0;
}

_id_5DC6(var_0) {
  var_1 = spawnStruct();
  var_1.value = var_0;

  if(!isDefined(self._id_95BE)) {
    self._id_00B9 = var_1;
    self._id_95BE = var_1;
  } else {
    self._id_95BE._id_66A1 = var_1;
    self._id_95BE = var_1;
  }

  self._id_005C++;
}

_id_5DCA() {
  if(!isDefined(self._id_00B9)) {
    return undefined;
  } else if(self._id_00B9 == self._id_95BE) {
    var_0 = self._id_00B9.value;
    self._id_00B9 = undefined;
    self._id_95BE = undefined;
    self._id_005C = 0;
    return var_0;
  } else {
    var_0 = self._id_00B9.value;
    self._id_00B9 = self._id_00B9._id_66A1;
    self._id_005C--;
    return var_0;
  }
}

_id_5DC9() {
  if(!isDefined(self._id_00B9)) {
    return undefined;
  } else {
    return self._id_00B9.value;
  }
}

_id_5DCB() {
  return self._id_005C;
}

_id_5DC7() {
  var_0 = self._id_005C;

  for(var_1 = self._id_00B9; var_0; var_1 = var_2) {
    var_2 = var_1._id_66A1;
    var_1._id_66A1 = undefined;
    var_1.value = undefined;
    var_1 = undefined;
    var_0 = var_0 - 1;
  }

  self._id_005C = 0;
  self._id_00B9 = undefined;
  self._id_95BE = undefined;
}

_id_5DCC() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = self._id_00B9; isDefined(var_2); var_2 = var_2._id_66A1) {
    var_0[var_1] = var_2.value;
    var_1++;
  }

  return var_0;
}

_id_06D4(var_0, var_1) {
  if(isPlayer(self)) {
    _id_04CA::updatedivisionusagestats();
    self.divisionusageindex = var_1;
    self _meth_867C(var_1);
    self._id_305A = gettime();
  }

  self._id_0079 = var_1;
}

_giveweapon(var_0, var_1, var_2, var_3) {
  if(issubstr(var_0, "alt") == 0) {
    var_0 = _id_922B(var_0);
  }

  if(issubstr(var_0, "+akimbo") || isDefined(var_1) && var_1 == 1) {
    if(_isagent(self)) {
      self giveweapon(var_0, 1, 0);
    } else {
      self giveweapon(var_0, 1, 0, self, var_2, var_3);
    }
  } else if(_isagent(self))
    self giveweapon(var_0, 0, 0);
  else {
    self giveweapon(var_0, 0, 0, self, var_2, var_3);
  }
}

_id_4604() {
  if(_id_585F()) {
    return "mp/zombiePerkTable.csv";
  } else {
    return "mp/perktable.csv";
  }
}

isdivisionsglobaloverhaulenabled() {
  return getdvarint("divisionsGlobalOverhaul", 1) == 1;
}

areexperimentalbasictrainingsenabled() {
  return getdvarint("6015", 0) == 1;
}

_hasperk(var_0) {
  if(!_id_585F() && _id_052C::isspecialistperk(var_0) && !_id_052C::hasspecialistperkunlocked(var_0)) {
    return 0;
  }

  if(!_id_585F() && _id_052C::isclassifiedsecondbt(var_0) && !_id_052C::hasclassifiedsecondbt()) {
    return 0;
  }

  if(isDefined(self._id_6F65) && isDefined(self._id_6F65[var_0])) {
    return 1;
  }

  return 0;
}

_hasexperimentalbtperk(var_0) {
  if(areexperimentalbasictrainingsenabled()) {
    return _hasperk(var_0);
  }

  return 0;
}

_id_47A3(var_0, var_1) {
  if(issubstr(var_0, "_mp")) {
    _giveweapon(var_0);
    self givestartammo(var_0);
    _setperk1(var_0, 1);
    return;
  }

  if(issubstr(var_0, "specialty_weapon_")) {
    _setperk1(var_0, 1);
    return;
  }

  if(_func_30D(var_0)) {
    var_0 = _id_452B(var_0);
  }

  _setperk1(var_0, 1, var_1);
}

giveperk(var_0) {
  if(issubstr(var_0, "_mp")) {
    _giveweapon(var_0);
    self givestartammo(var_0);
    _setperk1(var_0, 0);
    return;
  }

  if(issubstr(var_0, "specialty_weapon_")) {
    _setperk1(var_0, 0);
    return;
  }

  if(_func_30D(var_0)) {
    var_0 = _id_452B(var_0);
  }

  _setperk1(var_0, 0);
}

_setperk1(var_0, var_1, var_2) {
  self._id_6F65[var_0] = 1;
  self._id_6F6A[var_0] = var_1;

  if(isDefined(level._id_6F68[var_0])) {
    self thread[[level._id_6F68[var_0]]]();
  }

  if(isDefined(var_2)) {
    self setperk(var_0, !isDefined(level.disableoffhandweapons[var_0]), var_1, var_2);
  } else {
    self setperk(var_0, !isDefined(level.disableoffhandweapons[var_0]), var_1);
  }
}

_id_0735(var_0) {
  self._id_6F65[var_0] = undefined;
  self._id_6F6A[var_0] = undefined;

  if(isDefined(level._id_6F6C[var_0])) {
    self thread[[level._id_6F6C[var_0]]]();
  }

  self unsetperk(var_0, !isDefined(level.disableoffhandweapons[var_0]));
}

_id_05E4() {
  foreach(var_2, var_1 in self._id_6F65) {
    if(isDefined(level._id_6F6C[var_2])) {
      self[[level._id_6F6C[var_2]]]();
    }
  }

  self._id_6F65 = [];
  self._id_6F6A = [];
  self clearperks();
}

_id_1F50(var_0) {
  return _id_05DE(var_0);
}

_id_05DE(var_0) {
  if(!isDefined(level._id_083D) || !isDefined(level._id_083D[var_0])) {
    return 1;
  }

  return self[[level._id_083D[var_0]]]();
}

_id_476E(var_0, var_1) {
  _setperk(var_0, var_1);
}

_setperk(var_0, var_1) {
  self.perks[var_0] = 1;

  if(isPlayer(self)) {
    if(isDefined(level._id_0841[var_0])) {
      self thread[[level._id_0841[var_0]]]();
    }
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]), var_1);
}

_unsetperk(var_0) {
  self.perks[var_0] = undefined;

  if(isPlayer(self)) {
    if(isDefined(level.perkunsetfuncs[var_0])) {
      self thread[[level.perkunsetfuncs[var_0]]]();
    }
  }

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

_id_05E1() {
  if(isPlayer(self)) {
    if(isDefined(level.perkunsetfuncs[self.pers["ability"]])) {
      self[[level.perkunsetfuncs[self.pers["ability"]]]]();
    }
  }

  self.perks = [];
  self clearperks();
}

_id_0648(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    if(isDefined(self.perks[var_0]) && self.perks[var_0]) {
      return 1;
    }
  } else if(isDefined(self.pers["ability"]) && self.pers["ability"] == var_0 && isDefined(self.pers["abilityOn"]) && self.pers["abilityOn"])
    return 1;

  return 0;
}

_suicide() {
  if(isusingremote() && !isDefined(self)) {
    thread maps\mp\gametypes\_damage::playerkilled_internal(self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", (0, 0, 0), "none", 0, 1116, 1);
  } else if(!isusingremote() && !isDefined(self)) {
    self suicide();
  }
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0)) {
    return 1;
  }

  return 0;
}

_id_A71C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_1)) {
    thread common_scripts\utility::_id_A75E(var_1, var_6);
  }

  if(isDefined(var_2)) {
    thread common_scripts\utility::_id_A75E(var_2, var_6);
  }

  if(isDefined(var_3)) {
    thread common_scripts\utility::_id_A75E(var_3, var_6);
  }

  if(isDefined(var_4)) {
    thread common_scripts\utility::_id_A75E(var_4, var_6);
  }

  if(isDefined(var_5)) {
    thread common_scripts\utility::_id_A75E(var_5, var_6);
  }

  var_6 thread _id_0731(var_0, self);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

_id_0731(var_0, var_1) {
  self endon("die");

  for(var_2 = 0.05; var_0 > 0; var_0 = var_0 - var_2) {
    if(isPlayer(var_1) && !isreallyalive(var_1)) {
      var_1 waittill("spawned_player");
    }

    if(getdvarint("ui_inprematch")) {
      level waittill("prematch_over");
    }

    wait(var_2);
  }

  self notify("returned", "timeout");
}

_id_7210(var_0, var_1) {
  if(isDefined(level._id_2980)) {
    self thread[[level._id_2980]]();
    return;
  }

  if(isDefined(self._id_18A8)) {
    if(self.team == "axis") {
      if(self hasfemalecustomizationmodel()) {
        var_2 = _randomintrange(1, 4);

        if(isDefined(var_0) && (var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME")) {
          var_3 = _id_0380::_id_6842("flame_death_enemy_fm_" + var_2, undefined, self._id_18A8.origin);
        } else if(isDefined(var_0) && var_0 == "MOD_MELEE" && issubstr(var_1, "bayonet")) {
          var_3 = _id_0380::_id_2889("bayo_death_enemy_fm_" + var_2, undefined, self._id_18A8.origin);
        } else if(isDefined(self._id_5D9F) && self._id_5D9F == 1) {
          var_3 = _id_0380::_id_6842("lingering_death_enemy_fm_" + var_2, undefined, self._id_18A8.origin);
        } else {
          var_3 = _id_0380::_id_6842("generic_death_enemy_fm_" + var_2, undefined, self._id_18A8.origin);
        }
      } else {
        var_2 = _randomintrange(1, 7);

        if(isDefined(var_0) && (var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME")) {
          var_3 = _id_0380::_id_6842("flame_death_enemy_" + var_2, undefined, self._id_18A8.origin);
        } else if(isDefined(var_0) && var_0 == "MOD_MELEE" && issubstr(var_1, "bayonet")) {
          var_3 = _id_0380::_id_2889("bayo_death_enemy_" + var_2, undefined, self._id_18A8.origin);
        } else if(isDefined(self._id_5D9F) && self._id_5D9F == 1) {
          var_3 = _id_0380::_id_6842("lingering_death_enemy_" + var_2, undefined, self._id_18A8.origin);
        } else {
          var_3 = _id_0380::_id_6842("generic_death_enemy_" + var_2, undefined, self._id_18A8.origin);
        }
      }
    } else if(self hasfemalecustomizationmodel()) {
      var_2 = _randomintrange(1, 4);

      if(isDefined(var_0) && (var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME")) {
        var_3 = _id_0380::_id_6842("flame_death_friendly_fm_" + var_2, undefined, self._id_18A8.origin);
      } else if(isDefined(var_0) && var_0 == "MOD_MELEE" && issubstr(var_1, "bayonet")) {
        var_3 = _id_0380::_id_2889("bayo_death_friendly_fm_" + var_2, undefined, self._id_18A8.origin);
      } else if(isDefined(self._id_5D9F) && self._id_5D9F == 1) {
        var_3 = _id_0380::_id_6842("lingering_death_friendly_fm_" + var_2, undefined, self._id_18A8.origin);
      } else {
        var_3 = _id_0380::_id_6842("generic_death_friendly_fm_" + var_2, undefined, self._id_18A8.origin);
      }
    } else {
      var_2 = _randomintrange(1, 7);

      if(isDefined(var_0) && (var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME")) {
        var_3 = _id_0380::_id_6842("flame_death_friendly_" + var_2, undefined, self._id_18A8.origin);
      } else if(isDefined(var_0) && var_0 == "MOD_MELEE" && issubstr(var_1, "bayonet")) {
        var_3 = _id_0380::_id_2889("bayo_death_friendly_" + var_2, undefined, self._id_18A8.origin);
      } else if(isDefined(self._id_5D9F) && self._id_5D9F == 1) {
        var_3 = _id_0380::_id_6842("lingering_death_friendly_" + var_2, undefined, self._id_18A8.origin);
      } else {
        var_3 = _id_0380::_id_6842("generic_death_friendly_" + var_2, undefined, self._id_18A8.origin);
      }
    }
  }
}

rankingenabled() {
  if(!isPlayer(self)) {
    return 0;
  }

  return level.rankedmatch && !self._id_A25B || _func_367() && !_func_371() && !_issplitscreen() && !_issystemlink();
}

privatematch() {
  return !level.onlinegame || _func_371();
}

matchmakinggame() {
  return level.onlinegame && !_func_371();
}

_id_761E() {
  return level._id_7616;
}

setaltsceneobj(var_0, var_1, var_2, var_3) {}

endsceneondeath(var_0) {
  self endon("altscene");
  var_0 waittill("death");
  self notify("end_altScene");
}

_id_4571() {
  return getDvar("1673");
}

getgametypenumlives() {
  return getwatcheddvar("numlives");
}

_id_0FBD(var_0, var_1, var_2) {
  if(var_0.size != 0) {
    for(var_3 = var_0.size; var_3 >= var_2; var_3--) {
      var_0[var_3 + 1] = var_0[var_3];
    }
  }

  var_0[var_2] = var_1;
}

getproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getDvar(var_0, var_1);
  return var_2;
}

getintproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarint(var_0, var_1);
  return var_2;
}

getfloatproperty(var_0, var_1) {
  var_2 = var_1;
  var_2 = getdvarfloat(var_0, var_1);
  return var_2;
}

_id_56A8() {
  return isDefined(self._id_20CC);
}

_id_5A54(var_0) {
  return 1;
}

iskillstreakweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(_id_56C4(var_0)) {
    return 0;
  }

  if(_id_568F(var_0) || isuseweapon(var_0)) {
    return 0;
  }

  if(issubstr(var_0, "killstreak")) {
    return 1;
  }

  if(var_0 == "p51_cannon") {
    return 0;
  }

  var_0 = _id_4431(var_0);

  if(var_0 == "airdrop_sentry_marker_mp") {
    return 1;
  }

  if(var_0 == "teslagun_war_moon_mp" || var_0 == "war_super_soldier_syrum_purple_mp" || var_0 == "war_super_soldier_syrum_green_mp" || var_0 == "war_super_soldier_syrum_mp" || var_0 == "war_super_soldier_syrum_orange_mp" || var_0 == "war_sword_mp") {
    return 1;
  }

  if(isDefined(level._id_5A7D) && isDefined(level._id_5A7D[var_0])) {
    return 1;
  }

  var_1 = weaponinventorytype(var_0);

  if(isDefined(var_1) && var_1 == "exclusive") {
    return 1;
  }

  return 0;
}

_id_56C4(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "barrel_mp":
    case "destructible":
    case "destructible_car":
    case "destructible_toy":
      return 1;
  }

  return 0;
}

_id_5705() {
  if(_id_551F()) {
    return 0;
  }

  return getdvarint("scr_game_grappling_hook", 0);
}

_id_571D() {
  return getdvarint("scr_game_increased_clients", 0);
}

_id_568F(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "bomb_site_mp":
    case "search_dstry_bomb_defuse_mp":
    case "search_dstry_bomb_mp":
      return 1;
  }

  return 0;
}

isuseweapon(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "wrench_disassemble_dig_zm":
    case "explosives_dig_zm":
    case "war_generic_open_mp":
    case "war_rope_untie_mp":
    case "war_dynamite_disarm_mp":
    case "war_wrench_assemble_mp":
    case "war_generic_assemble_mp":
    case "war_bangalore_mp":
    case "war_hammer_assemble_mp":
    case "war_dynamite_mp":
    case "search_dstry_bomb_defuse_mp":
    case "search_dstry_bomb_mp":
      return 1;
  }

  return 0;
}

_id_56DF(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(var_0 == "turret_minigun_mp") {
    return 1;
  }

  if(issubstr(var_0, "_bipod_")) {
    return 1;
  }

  return 0;
}

_id_5856(var_0) {
  if(issubstr(var_0, "loot")) {
    return 1;
  }

  return 0;
}

_id_5857(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  var_1 = _func_311(var_0);
  return _id_5856(var_1);
}

_id_4738(var_0) {
  return strtok(var_0, "+");
}

_id_4730(var_0, var_1) {
  var_2 = _id_4738(var_0);

  for(var_3 = 1; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!_id_5679(var_4) && issubstr(var_4, var_1)) {
      return var_4;
    }
  }

  return "";
}

_id_4728(var_0) {
  return _id_4730(var_0, "camo");
}

_id_472B(var_0) {
  return _id_4730(var_0, "cond");
}

_id_473A(var_0) {
  return _id_4730(var_0, "scope");
}

_id_472F(var_0) {
  return _id_4730(var_0, "cust");
}

getweaponclass(var_0, var_1) {
  if(var_0 == "p51_cannon") {
    return "none";
  }

  var_2 = _id_4431(var_0);
  var_3 = tablelookup("mp/statstable.csv", 2, var_2, 0);

  if(var_3 == "") {
    var_3 = tablelookup("mp/statstable.csv", 2, var_0, 0);
  }

  if(_id_56DF(var_0)) {
    var_3 = "weapon_mg";
  } else if(!common_scripts\utility::_id_562E(var_1) && iskillstreakweapon(var_0)) {
    var_3 = "killstreak";
  } else if(var_0 == "none") {
    var_3 = "other";
  } else if(var_3 == "") {
    var_3 = "other";
  }

  return var_3;
}

_id_4723(var_0) {
  return _getweaponattachmentsbasenames(var_0);
}

_id_4431(var_0, var_1) {
  var_2 = strtok(var_0, "+");
  var_3 = "";

  if(var_2[0] == "alt") {
    var_3 = var_2[1];
  } else {
    var_3 = var_2[0];
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_4 = tablelookup("mp/statstable.csv", 2, var_3, 28);

    if(var_4 != "") {
      return var_4;
    }
  }

  return var_3;
}

_id_45B5(var_0) {
  var_1 = _id_4431(var_0);

  if(_id_5856(var_1)) {
    var_1 = maps\mp\gametypes\_class::_id_4432(var_1);
  }

  return var_1;
}

playsoundinspace(var_0, var_1) {
  playsoundatpos(var_1, var_0);
}

limitdecimalplaces(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  var_2 = 1;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 = var_2 * 10;
  }

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 = var_4 / var_2;
  return var_4;
}

playerforclientid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.clientid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

_id_A18D(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("connected", var_1);
    self disableplayeruse(var_1);
  }
}

_id_871D() {
  self makeunusable();

  foreach(var_1 in level.players) {
    self disableplayeruse(var_1);
  }
}

maketeamusable(var_0) {
  self makeusable();
  thread _updateteamusable(var_0);
}

_updateteamusable(var_0) {
  self endon("death");
  self notify("stop_usable_update");
  self endon("stop_usable_update");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
    }

    level waittill("joined_team");
  }
}

makeenemyusable(var_0) {
  self makeusable();
  thread _updateenemyusable(var_0);
}

_updateenemyusable(var_0) {
  self endon("death");
  var_1 = var_0.team;

  for(;;) {
    if(level.teambased) {
      foreach(var_3 in level.players) {
        if(var_3.team != var_1) {
          self enableplayeruse(var_3);
          continue;
        }

        self disableplayeruse(var_3);
      }
    } else {
      foreach(var_3 in level.players) {
        if(var_3 != var_0) {
          self enableplayeruse(var_3);
          continue;
        }

        self disableplayeruse(var_3);
      }
    }

    level waittill("joined_team");
  }
}

getnextlifeid(var_0) {
  var_1 = getmatchdata("match_common", "life_count");

  if(var_1 < level.maxlives) {
    setmatchdata("match_common", "life_count", var_1 + 1);
    level._id_5CC7[var_1] = gettime();
    return var_1;
  } else
    return level.maxlives - 1;
}

initgameflags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
}

gameflaginit(var_0, var_1) {
  game["flags"][var_0] = var_1;
}

gameflagexists(var_0) {
  return isDefined(game["flags"]) && isDefined(game["flags"][var_0]);
}

gameflag(var_0) {
  return game["flags"][var_0];
}

gameflagset(var_0) {
  game["flags"][var_0] = 1;
  level notify(var_0);
}

gameflagclear(var_0) {
  game["flags"][var_0] = 0;
}

gameflagwait(var_0) {
  while(!gameflag(var_0)) {
    level waittill(var_0);
  }
}

isbulletdamage(var_0) {
  var_1 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";

  if(issubstr(var_1, var_0)) {
    return 1;
  }

  return 0;
}

_id_56F8(var_0, var_1, var_2) {
  return isDefined(var_2) && isPlayer(var_2) && (var_2 _hasperk("specialty_bulletpenetration") || var_2 _hasperk("specialty_superbulletpenetration")) && isDefined(var_1) && isbulletdamage(var_1);
}

initlevelflags() {
  if(!isDefined(level.levelflags)) {
    level.levelflags = [];
  }
}

levelflaginit(var_0, var_1) {
  level.levelflags[var_0] = var_1;
}

levelflag(var_0) {
  return level.levelflags[var_0];
}

levelflagset(var_0) {
  level.levelflags[var_0] = 1;
  level notify(var_0);
}

levelflagclear(var_0) {
  level.levelflags[var_0] = 0;
  level notify(var_0);
}

levelflagwait(var_0) {
  while(!levelflag(var_0)) {
    level waittill(var_0);
  }
}

levelflagwaitopen(var_0) {
  while(levelflag(var_0)) {
    level waittill(var_0);
  }
}

_id_551F() {
  if(!isDefined(level._id_A559) || level._id_A559 == 0) {
    return 0;
  }

  return 1;
}

_id_5716(var_0) {
  if(var_0 == "emote_weapon_mp" || var_0 == "boxing_gloves_hub_mp") {
    return 1;
  }

  return 0;
}

_id_573D() {
  if(_id_551F()) {
    return 0;
  }

  return _id_56D7() || _id_5668();
}

_id_56D7() {
  if(self.team == "spectator") {
    return 0;
  }

  if(_id_551F()) {
    return 0;
  }

  if(level.teambased) {
    return isDefined(level.teamemped) && level.teamemped[self.team] || isDefined(self._id_35F1) && self._id_35F1;
  } else {
    return isDefined(level.empplayer) && level.empplayer != self || isDefined(self._id_35F1) && self._id_35F1;
  }
}

isemped() {
  if(self.team == "spectator") {
    return 0;
  }

  if(_id_551F()) {
    return 0;
  }

  if(level.teambased) {
    return level.teamemped[self.team];
  } else {
    return isDefined(level.empplayer) && level.empplayer != self;
  }
}

_id_5668(var_0, var_1) {
  var_2 = self.team;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(level.teambased && isDefined(level._id_9854) && isDefined(var_2) && isDefined(level._id_9854[var_2]) && level._id_9854[var_2] || !level.teambased && isDefined(level._id_3CE0) && level._id_3CE0 != self) {
    if(!isDefined(var_0) || var_0) {
      self iprintlnbold(&"KILLSTREAKS_FLAK_GUN_ACTIVE");
    }

    return 1;
  }

  return 0;
}

_id_5814(var_0, var_1) {
  var_2 = self.team;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(level.teambased && isDefined(level._id_9850) && level._id_9850[var_2] || !level.teambased && isDefined(level._id_2694) && level._id_2694 != self) {
    if(!isDefined(var_0) || var_0) {
      self iprintlnbold(&"KILLSTREAKS_COUNTER_RECON_ACTIVE");
    }

    return 1;
  }

  return 0;
}

isnuked() {
  if(self.team == "spectator") {
    return 0;
  }

  return isDefined(self.nuked);
}

getplayerforguid(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

teamplayercardsplash(var_0, var_1, var_2, var_3) {
  if(level.hardcoremode) {
    return;
  }
  foreach(var_5 in level.players) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(var_2) && (!isDefined(var_5.team) || var_5.team != var_2)) {
      continue;
    }
    if(!isPlayer(var_5)) {
      continue;
    }
    var_5 thread maps\mp\gametypes\_hud_message::playercardsplashnotify(var_0, var_1, var_3);
  }
}

iscacprimaryweapon(var_0) {
  switch (getweaponclass(var_0)) {
    case "weapon_special":
    case "weapon_heavy":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_riot":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    default:
      return 0;
  }
}

iscacsecondaryweapon(var_0) {
  switch (getweaponclass(var_0)) {
    case "weapon_other":
    case "weapon_sec_special":
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_knife":
    case "weapon_projectile":
      return 1;
    default:
      return 0;
  }
}

getlastlivingplayer(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(isDefined(var_0) && var_3.team != var_0) {
      continue;
    }
    if(!isreallyalive(var_3) && !var_3 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    var_1 = var_3;
  }

  return var_1;
}

getpotentiallivingplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!isreallyalive(var_2) && !var_2 maps\mp\gametypes\_playerlogic::mayspawn()) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

waittillrecoveredhealth(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  for(;;) {
    if(self.health != self.maxhealth) {
      var_2 = 0;
    } else {
      var_2 = var_2 + var_1;
    }

    wait(var_1);

    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }

  return;
}

_id_1151(var_0, var_1) {
  var_2 = var_0;

  if(isDefined(var_0)) {
    var_1 = _id_4431(var_1, 1);

    if(_id_5856(var_1)) {
      var_1 = maps\mp\gametypes\_class::_id_4432(var_1);
    }

    if(isDefined(level._id_114F[var_1]) && isDefined(level._id_114F[var_1][var_0])) {
      var_2 = level._id_114F[var_1][var_0];
    } else {
      var_3 = tablelookup("mp/statstable.csv", 2, var_1, 0);

      if(isDefined(level._id_114F[var_3]) && isDefined(level._id_114F[var_3][var_0])) {
        var_2 = level._id_114F[var_3][var_0];
      }
    }
  }

  return var_2;
}

_id_1153(var_0) {
  var_1 = undefined;

  if(isDefined(level._id_114E[var_0])) {
    var_1 = level._id_114E[var_0];
  }

  return var_1;
}

_id_567A(var_0, var_1) {
  var_2 = strtok(var_0, "_");
  return _id_567B(var_2, var_1);
}

_id_567B(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "alt") {
      var_3 = 1;
    }

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "iw5" || var_0[var_3] == "iw6")) {
      if(weaponclass(var_0[var_3] + "_" + var_0[var_3 + 1] + "_" + var_0[var_3 + 2]) == "sniper") {
        var_2 = var_0[var_3 + 1] + "scope" == var_1;
      }
    }
  }

  return var_2;
}

_id_4725(var_0) {
  var_1 = _getweaponattachments(var_0);

  foreach(var_4, var_3 in var_1) {
    var_1[var_4] = _id_1150(var_3);
  }

  return var_1;
}

_id_4427() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 4); var_2 != ""; var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 4)) {
    if(!common_scripts\utility::_id_0F79(var_0, var_2)) {
      var_0[var_0.size] = var_2;
    }

    var_1++;
  }

  return var_0;
}

_id_4428() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 3); var_2 != ""; var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 3)) {
    var_0[var_0.size] = var_2;
    var_1++;
  }

  return var_0;
}

_id_1D3E() {
  var_0 = _id_4428();
  level._id_1152 = [];

  foreach(var_2 in var_0) {
    var_3 = tablelookup("mp/attachmenttable.csv", 3, var_2, 4);

    if(var_2 == var_3) {
      continue;
    }
    level._id_1152[var_2] = var_3;
  }

  var_5 = [];
  var_6 = 1;

  for(var_7 = _tablelookupbyrow("mp/attachmentmap.csv", var_6, 0); var_7 != ""; var_7 = _tablelookupbyrow("mp/attachmentmap.csv", var_6, 0)) {
    var_5[var_5.size] = var_7;
    var_6++;
  }

  var_8 = [];
  var_9 = 1;

  for(var_10 = _tablelookupbyrow("mp/attachmentmap.csv", 0, var_9); var_10 != ""; var_10 = _tablelookupbyrow("mp/attachmentmap.csv", 0, var_9)) {
    var_8[var_10] = var_9;
    var_9++;
  }

  level._id_114F = [];

  foreach(var_7 in var_5) {
    foreach(var_15, var_13 in var_8) {
      var_14 = tablelookup("mp/attachmentmap.csv", 0, var_7, var_13);

      if(var_14 == "") {
        continue;
      }
      if(!isDefined(level._id_114F[var_7])) {
        level._id_114F[var_7] = [];
      }

      level._id_114F[var_7][var_15] = var_14;
    }
  }

  level._id_114E = [];

  foreach(var_18 in var_0) {
    var_19 = tablelookup("mp/attachmenttable.csv", 3, var_18, 8);

    if(var_19 == "") {
      continue;
    }
    level._id_114E[var_18] = var_19;
  }
}

_id_1150(var_0) {
  if(isDefined(level._id_1152[var_0])) {
    var_0 = level._id_1152[var_0];
  }

  return var_0;
}

_objective_delete(var_0) {
  objective_delete(var_0);

  if(!isDefined(level.reclaimedreservedobjectives)) {
    level.reclaimedreservedobjectives = [];
    level.reclaimedreservedobjectives[0] = var_0;
  } else
    level.reclaimedreservedobjectives[level.reclaimedreservedobjectives.size] = var_0;
}

touchingbadtrigger() {
  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in var_0) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  var_4 = getEntArray("radiation", "targetname");

  foreach(var_2 in var_4) {
    if(self istouching(var_2)) {
      return 1;
    }
  }

  if(getDvar("1924") == "hp" && isDefined(level._id_AC7C) && isDefined(level._id_AC7C._id_9D5E) && self istouching(level._id_AC7C._id_9D5E)) {
    return 1;
  }

  if(getDvar("1924") == "undead" && isDefined(level._id_AC7C) && isDefined(level._id_AC7C._id_9D5E) && self istouching(level._id_AC7C._id_9D5E)) {
    return 1;
  }

  return 0;
}

setthirdpersondof(var_0) {
  if(var_0) {
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  } else {
    self setdepthoffield(0, 0, 512, 512, 4, 0);
  }
}

killtrigger(var_0, var_1, var_2) {
  var_3 = spawn("trigger_radius", var_0, 0, var_1, var_2);

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }
    var_4 suicide();
  }
}

_id_3B8E(var_0, var_1, var_2) {
  return findisfacingvectors(var_0.origin, anglesToForward(var_0.angles), var_1.origin, var_2);
}

findplayerisfacing(var_0, var_1, var_2) {
  var_3 = distance(var_0 getEye(), var_1.origin);
  var_4 = var_0 getEye() + var_3 * vectorNormalize(anglesToForward(var_0 _meth_8566()));
  return distance(var_1.origin, var_4) < var_2;
}

findisfacingvectors(var_0, var_1, var_2, var_3) {
  var_4 = _cos(var_3);
  var_5 = var_2 - var_0;
  var_5 = var_5 * (1, 1, 0);
  var_5 = vectorNormalize(var_5);
  var_1 = var_1 * (1, 1, 0);
  var_1 = vectorNormalize(var_1);
  var_6 = vectordot(var_5, var_1);
  return var_6 >= var_4;
}

_id_33D8(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

_id_33DF(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 * 20);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

_id_870F(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self._id_7AD7)) {
    self._id_7AD7 = var_0;
  } else {
    self._id_7AD7 = self._id_7AD7 + var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self._id_7AD7) && var_1 < self._id_7AD7) {
      var_1 = self._id_7AD7;
    }

    var_2 = 100 - var_1;
  } else
    var_2 = 100 - self._id_7AD7;

  if(_hasperk("specialty_sessionProgressionC") && isDefined(self.pers["sessionProgressionC_Modifier"])) {
    var_2 = var_2 * _id_052C::getgrenadiermodvalue_c();
  }

  if(isDefined(self.classifiedboostafterreloadactive) && self.classifiedboostafterreloadactive) {
    var_2 = var_2 * 50;
  }

  if(isDefined(self.raidbasictrainingbuff) && self.raidbasictrainingbuff) {
    var_2 = var_2 * 70;
  }

  if(var_2 < 0) {
    var_2 = 0;
  }

  if(var_2 > 100) {
    var_2 = 100;
  }

  if(var_2 == 100) {
    self playerrecoilscaleoff();
    return;
  }

  self playerrecoilscaleon(int(var_2));
}

_id_2341(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_4];
  }

  return var_1;
}

_id_6819(var_0) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self endon("notusablejoiningplayers");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1) && var_1 != var_0) {
      self disableplayeruse(var_1);
    }
  }
}

_id_57E5(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

_id_2F6D() {
  level._id_5A74 = 1;
}

_id_3653() {
  level._id_5A74 = undefined;
}

_id_0F5C() {
  return !isDefined(level._id_5A74) || !level._id_5A74;
}

_id_A27A(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = var_0;
  } else {
    var_3 = self.pers["killstreaks"];
    var_2 = var_3[self._id_5A69]._id_944C;
  }

  if(isDefined(level._id_5A74) && level._id_5A74) {
    return 0;
  }

  if(isDefined(self._id_5A74) && self._id_5A74) {
    return 0;
  }

  if(getdvarint("scorestreak_enabled_" + var_2) == 0) {
    return 0;
  }

  if(!self isonground() && _id_57AD(var_2)) {
    return 0;
  }

  if(isusingremote() || _id_572D()) {
    return 0;
  }

  if(isDefined(self._id_83AF)) {
    return 0;
  }

  if(!gameflag("prematch_done")) {
    return 0;
  }

  if(_id_8BA1(var_2) && level._id_5A70) {
    var_4 = 0;

    if(isDefined(level._id_7690)) {
      var_4 = (gettime() - level._id_7690) / 1000;
    }

    if(var_4 < level._id_5A70) {
      var_5 = int(level._id_5A70 - var_4 + 0.5);

      if(!var_5) {
        var_5 = 1;
      }

      if(!(isDefined(var_1) && var_1)) {
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", var_5);
      }

      return 0;
    }
  }

  if(_id_56D7() && (!isDefined(level._id_585D) || !level._id_585D)) {
    if(!(isDefined(var_1) && var_1)) {
      if(isDefined(level._id_35F7) && level._id_35F7 > 0) {
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP", level._id_35F7);
      } else if(isDefined(self._id_35EF) && int((self._id_35EF - gettime()) / 1000) > 0) {
        self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", int((self._id_35EF - gettime()) / 1000));
      }
    }

    return 0;
  }

  if(self isusingturret() && (_id_57AD(var_2) || _id_56A6(var_2))) {
    if(!(isDefined(var_1) && var_1)) {
      self iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
    }

    return 0;
  }

  if(isDefined(self._id_00E8) && !_hasperk("specialty_finalstand")) {
    if(!(isDefined(var_1) && var_1)) {
      self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
    }

    return 0;
  }

  if(!common_scripts\utility::_id_5851()) {
    return 0;
  }

  return 1;
}

_id_57AD(var_0) {
  return 0;
}

_id_56A6(var_0) {
  switch (var_0) {
    case "remote_mg_sentry_turret":
    case "deployable_exp_ammo":
    case "deployable_grenades":
    case "deployable_ammo":
    case "sentry":
      return 1;
    default:
      return 0;
  }
}

_id_8BA1(var_0) {
  switch (var_0) {
    case "plane_gunner":
    case "v2_rocket":
    case "fighter_strike":
    case "firebomb":
    case "airstrike":
    case "missile_strike":
    case "mortar_strike":
    case "fritzx":
      return 1;
  }

  return 0;
}

_id_3153(var_0) {
  switch (var_0) {
    case "plane_gunner":
    case "v2_rocket":
    case "fighter_strike":
    case "firebomb":
    case "missile_strike":
    case "mortar_strike":
      return 1;
  }

  return 0;
}

_id_573A(var_0) {
  switch (var_0) {
    case "refill_grenades":
    case "speed_boost":
    case "eyes_on":
    case "high_value_target":
    case "recon_agent":
    case "agent":
    case "placeable_barrier":
    case "deployable_juicebox":
    case "deployable_grenades":
    case "deployable_ammo":
      return 0;
    default:
      return 1;
  }
}

_id_573B(var_0) {
  return _id_573A(var_0) && !_id_56F7(var_0);
}

_id_56F7(var_0) {
  switch (var_0) {
    case "orbital_strike_drone":
    case "orbital_strike_cluster":
    case "orbital_strike_laser_chem":
    case "orbital_strike_chem":
    case "orbital_strike_laser":
    case "orbital_strike":
    case "orbital_carepackag":
    case "orbitalsupport":
    case "airdrop_support":
    case "airdrop_assault":
    case "airdrop_sentry_minigun":
    case "missile_strike":
      return 0;
    default:
      return 1;
  }
}

_id_4545(var_0) {
  return _tablelookuprownum("mp/killstreakTable.csv", 1, var_0);
}

_id_453F(var_0) {
  var_1 = tablelookup("mp/killstreakTable.csv", 1, var_0, 0);

  if(var_1 == "") {
    var_2 = -1;
  } else {
    var_2 = int(var_1);
  }

  return var_2;
}

_id_4543(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 1);
}

_id_4541(var_0) {
  return _tablelookupistring("mp/killstreakTable.csv", 1, var_0, 2);
}

_id_4544(var_0) {
  return tablelookup("mp/killstreakTable.csv", 0, var_0, 1);
}

_id_4534(var_0) {
  return _tablelookupistring("mp/killstreakTable.csv", 1, var_0, 3);
}

_id_4531(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 4);
}

_id_453C(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 5);
}

_id_4548(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 6);
}

getkillstreakesportscost(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 33);
}

getkillstreakkills(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 7);
}

getkillstreakhardlinekills(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 8);
}

getkillstreaksupportkills(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 9);
}

_id_4538(var_0) {
  return _tablelookupistring("mp/killstreakTable.csv", 1, var_0, 10);
}

_id_4547(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 11);
}

_id_4537(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 12);
}

_id_4530(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 13);
}

_id_4539(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 14);
}

_id_453A(var_0) {
  return int("mp/killstreakTable.csv", 1, var_0, 15);
}

_id_454A(var_0, var_1, var_2) {
  var_3 = tablelookup("mp/killstreakTable.csv", 1, var_0, 16);

  if(_id_579B() && common_scripts\utility::_id_562E(level._id_79C1)) {
    var_1 = getotherteam(var_1);
  }

  if(isDefined(var_1) && var_1 == "axis") {
    var_4 = tablelookup("mp/killstreakTable.csv", 1, var_0, 29);

    if(isDefined(var_4) && var_4 != "") {
      var_3 = var_4;
    }
  }

  if(isDefined(var_2) && var_2) {
    var_5 = tablelookup("mp/killstreakTable.csv", 1, var_0, 31);

    if(isDefined(var_5) && var_5 != "") {
      var_3 = var_5;
    }

    if(isDefined(var_1) && var_1 == "axis") {
      var_6 = tablelookup("mp/killstreakTable.csv", 1, var_0, 32);

      if(isDefined(var_6) && var_6 != "") {
        var_3 = var_6;
      }
    }
  }

  return var_3;
}

_id_4546(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 17);
}

_id_453E(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 18);
}

_id_4542(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 19);
}

_id_4536(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 23);
}

_id_4549(var_0) {
  return tablelookup("mp/killstreakTable.csv", 1, var_0, 24);
}

_id_2924(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = var_0;

  if(isDefined(level._id_4C9C)) {
    var_1 = var_1 + level._id_4C9C.size;
  }

  if(isDefined(level._id_7043)) {
    var_1 = var_1 + level._id_7043.size;
  }

  if(isDefined(level._id_9FEA)) {
    var_1 = var_1 + level._id_9FEA.size;
  }

  return var_1;
}

_id_60A6() {
  return 8;
}

_id_50FD() {
  level._id_3A62++;
}

_id_2B78() {
  level._id_3A62--;

  if(level._id_3A62 < 0) {
    level._id_3A62 = 0;
  }
}

_id_0C2D() {
  if(!_isshipbuild() && getdvarint("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  var_0 = int(tablelookup("mp/gametypesTable.csv", 0, level.gametype, 4));
  return var_0;
}

_id_0C1E() {
  if(!_isshipbuild() && getdvarint("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  if(isprophuntgametype() && (!level.phsettings.allowloadouts || !isDefined(self.team) || self.team == game["defenders"])) {
    return 0;
  }

  var_0 = int(tablelookup("mp/gametypesTable.csv", 0, level.gametype, 5));
  return var_0;
}

_id_8BFD() {
  if(_id_0C2D() || _id_0C1E()) {
    return 0;
  }

  var_0 = int(tablelookup("mp/gametypesTable.csv", 0, level.gametype, 7));
  return var_0;
}

_id_5693(var_0, var_1) {
  return 0;
}

_id_8653(var_0) {
  var_1 = _getmatchrulesdata("commonOption", "timeLimit");
  _setdynamicdvar("scr_" + level.gametype + "_timeLimit", var_1);
  registertimelimitdvar(level.gametype, var_1);
  var_2 = _getmatchrulesdata("commonOption", "scoreLimit");
  _setdynamicdvar("scr_" + level.gametype + "_scoreLimit", var_2);
  registerscorelimitdvar(level.gametype, var_2);
  _setdynamicdvar("scr_game_matchstarttime", _getmatchrulesdata("commonOption", "preMatchTimer"));
  _setdynamicdvar("scr_game_roundstarttime", _getmatchrulesdata("commonOption", "preRoundTimer"));
  _setdynamicdvar("scr_game_suicidespawndelay", _getmatchrulesdata("commonOption", "suicidePenalty"));
  _setdynamicdvar("scr_team_teamkillspawndelay", _getmatchrulesdata("commonOption", "teamKillPenalty"));
  _setdynamicdvar("scr_team_teamkillkicklimit", _getmatchrulesdata("commonOption", "teamKillKickLimit"));
  var_3 = _getmatchrulesdata("commonOption", "numLives");
  _setdynamicdvar("scr_" + level.gametype + "_numLives", var_3);
  registernumlivesdvar(level.gametype, var_3);
  _setdynamicdvar("scr_player_maxhealth", _getmatchrulesdata("commonOption", "maxHealth"));
  _setdynamicdvar("scr_player_healthregentime", _getmatchrulesdata("commonOption", "healthRegen"));
  level._id_6031 = 0;
  level._id_6035 = 0;
  _setdynamicdvar("scr_game_spectatetype", _getmatchrulesdata("commonOption", "spectateModeAllowed"));
  _setdynamicdvar("scr_game_lockspectatorpov", _getmatchrulesdata("commonOption", "spectateModePOV"));
  _setdynamicdvar("scr_game_allowkillcam", _getmatchrulesdata("commonOption", "showKillcam"));
  _setdynamicdvar("scr_game_forceuav", _getmatchrulesdata("commonOption", "radarMode") == 2);
  _setdynamicdvar("scr_game_radarMode", _getmatchrulesdata("commonOption", "radarMode"));
  _setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay", _getmatchrulesdata("commonOption", "respawnDelay"));
  _setdynamicdvar("scr_" + level.gametype + "_waverespawndelay", _getmatchrulesdata("commonOption", "waveRespawnDelay"));
  _setdynamicdvar("scr_player_forcerespawn", _getmatchrulesdata("commonOption", "forceRespawn"));
  level._id_6030 = _getmatchrulesdata("commonOption", "allowCustomClasses");
  level._id_297A = _getmatchrulesdata("commonOption", "classPickCount");
  _setdynamicdvar("scr_game_hardpoints", 1);
  _setdynamicdvar("scr_game_perks", 1);
  _setdynamicdvar("2043", _getmatchrulesdata("commonOption", "hardcoreModeOn"));
  _setdynamicdvar("scr_thirdPerson", _getmatchrulesdata("commonOption", "forceThirdPersonView"));
  _setdynamicdvar("311", _getmatchrulesdata("commonOption", "forceThirdPersonView"));
  _setdynamicdvar("scr_game_onlyheadshots", _getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isDefined(var_0)) {
    _setdynamicdvar("scr_team_fftype", _getmatchrulesdata("commonOption", "ffType"));
  }

  _setdynamicdvar("scr_game_killstreakdelay", _getmatchrulesdata("commonOption", "streakGracePeriod"));
  level._id_352F = 1;
  level._id_5FF1 = 1;
  level.mgnestsdisabled = _getmatchrulesdata("commonOption", "disableMGNests");
  level._id_212F = _getmatchrulesdata("commonOption", "chatterDisabled");
  level._id_0F05 = _getmatchrulesdata("commonOption", "announcerDisabled");
  level._id_6034 = _getmatchrulesdata("commonOption", "switchTeamDisabled");
  level._id_4867 = _getmatchrulesdata("commonOption", "grenadeGracePeriod");
  _setdynamicdvar("scr_oneShot", _getmatchrulesdata("commonOption", "oneShotMode"));

  if(getdvarint("scr_oneShot", 0) == 1 || getdvarint("scr_wanderlustOnly", 0) == 1) {
    level._id_2FAB = 1;
    level.disabledivisionstats = 1;
    level._id_2F8B = 1;
    level.disableallplayerstats = 1;
    level.disableweaponchallenges = 1;
    level.disabledivisionchallenges = 1;
    level.disablewinlossstats = 1;
    level.mgnestsdisabled = 1;
  }

  if(_getmatchrulesdata("commonOption", "hardcoreModeOn")) {
    _setdynamicdvar("scr_team_fftype", 1);
    _setdynamicdvar("scr_player_maxhealth", 30);
    _setdynamicdvar("scr_player_healthregentime", 0);
    _setdynamicdvar("scr_player_respawndelay", 10);
    _setdynamicdvar("scr_game_allowkillcam", 0);
    _setdynamicdvar("scr_game_forceuav", 0);
    _setdynamicdvar("scr_game_radarMode", 0);
  }

  if(_func_371() || _issystemlink()) {
    setDvar("1689", _getmatchrulesdata("commonOption", "broadcasterEnabled"));
  }

  setDvar("isMLGMatch", _getmatchrulesdata("commonOption", "isMLGMatch"));
  setDvar("isEsportsMatch", _getmatchrulesdata("commonOption", "isEsportsMatch"));
  setDvar("spawning_use_classic", _getmatchrulesdata("commonOption", "useClassicSpawning"));
  setDvar("4899", getDvar("scr_game_forceuav"));
  setDvar("4648", getDvar("scr_game_compassRadarUpdateTime"));
}

_id_7C13() {
  for(;;) {
    level waittill("host_migration_begin");
    [[level._id_5300]]();
  }
}

_id_7C15(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    var_0 endon("death");
  }

  for(;;) {
    level waittill("host_migration_begin");

    if(isDefined(self._id_5C0E)) {
      self visionsetthermalforplayer(self._id_5C0E, 0);
    }
  }
}

_id_4573(var_0, var_1) {
  var_2 = [];
  var_2["loadoutDivision"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "division");
  var_2["loadoutPrimaryWeaponStruct"] = _id_473C(_getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "weapon"), 0);

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_2["loadoutPrimaryAttachmentsGUID"][var_3] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "attachment", var_3);
  }

  var_2["loadoutPrimaryCamoGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryCamo2GUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "camo2");
  var_2["loadoutPrimaryReticleGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutPrimaryPaintjobId"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "paintjob");
  var_2["loadoutPrimaryCharmGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "charm");
  var_2["loadoutSecondaryWeaponStruct"] = _id_473C(_getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "weapon"), 0);

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_2["loadoutSecondaryAttachmentsGUID"][var_3] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "attachment", var_3);
  }

  var_2["loadoutSecondaryCamoGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryCamo2GUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "camo2");
  var_2["loadoutSecondaryReticleGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutSecondaryPaintjobId"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "paintjob");
  var_2["loadoutSecondaryCharmGUID"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "charm");
  var_2["loadoutEquipmentStruct"] = _id_44CE(_getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipmentSetups", 0, "equipment"), 0);
  var_2["loadoutEquipmentNumExtra"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipmentSetups", 0, "numExtra");
  var_2["loadoutOffhandStruct"] = _id_44CE(_getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipmentSetups", 1, "equipment"), 0);
  var_2["loadoutOffhandNumExtra"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipmentSetups", 1, "numExtra");

  for(var_3 = 0; var_3 < 9; var_3++) {
    var_2["loadoutPerksGUID"][var_3] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "perkSlots", var_3);
  }

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2["loadoutKillstreaksGUID"][var_3] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "assaultStreaks", var_3, "streak");
  }

  var_2["loadoutJuggernaut"] = _getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "juggernaut");
  return var_2;
}

removemgnestsfromlevel() {
  var_0 = getEntArray("misc_turret", "classname");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      var_2 delete();
    }
  }
}

_id_A165(var_0) {
  self.sessionstate = var_0;
  self setclientomnvar("ui_session_state", var_0);
}

_id_1E01() {
  if(isDefined(level._id_3E0E)) {
    return level._id_3E0E;
  }

  if(_issystemlink() || !_func_3AC() || _id_5385()) {
    return "privateMatchCustomClasses";
  } else if(_func_3AF() || common_scripts\utility::_id_562E(self.inrankedlobby)) {
    return "competitiveCustomClasses";
  } else {
    return "customClasses";
  }
}

_id_5385() {
  if(isDefined(self._id_537B)) {
    return self._id_537B == 2;
  } else {
    return 0;
  }
}

_id_5387() {
  if(isDefined(self._id_537B)) {
    return self._id_537B == 1;
  } else {
    return 0;
  }
}

_id_537D() {
  var_0 = _id_5385();
  var_1 = _id_5387();
  return var_0 || var_1;
}

getclassindex(var_0) {
  if(isDefined(level.classmap[var_0])) {
    return level.classmap[var_0];
  } else {
    return 0;
  }
}

_id_57FF() {
  var_0 = getlivingplayers(self.team);

  foreach(var_2 in var_0) {
    if(var_2 != self && (!isDefined(var_2._id_00E8) || !var_2._id_00E8)) {
      return 0;
    }
  }

  return 1;
}

_id_5A7F(var_0) {
  var_1 = getlivingplayers(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_00E8) && var_3._id_00E8) {
      var_3 thread maps\mp\gametypes\_damage::_id_2EEF(_randomintrange(1, 3));
    }
  }
}

_id_955C(var_0) {
  if(!_isai(self)) {
    self switchtoweapon(var_0);
  } else {
    self switchtoweapon("none");
  }
}

_id_955D(var_0) {
  if(!_isai(self)) {
    self _meth_86A5(var_0);
  } else {
    self _meth_86A5("none");
  }
}

_id_566A(var_0) {
  if(_isagent(var_0) && var_0._id_0A4A == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

_id_5800(var_0) {
  if(_id_566A(var_0)) {
    return 1;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_5666(var_0) {
  if(_isagent(var_0) && var_0._id_0A42 == 1) {
    return 1;
  }

  if(isbot(var_0)) {
    return 1;
  }

  return 0;
}

_id_56FF(var_0) {
  if(_id_5666(var_0)) {
    return 1;
  }

  if(isPlayer(var_0)) {
    return 1;
  }

  return 0;
}

_id_46D4(var_0) {
  var_1 = 0;

  if(level.teambased) {
    switch (var_0) {
      case "axis":
        var_1 = 1;
        break;
      case "allies":
        var_1 = 2;
        break;
    }
  }

  return var_1;
}

_id_5755(var_0) {
  return var_0 == "MOD_MELEE";
}

_id_5695(var_0) {
  return var_0 == "MOD_RIFLE_BULLET" || var_0 == "MOD_PISTOL_BULLET" || var_0 == "MOD_HEAD_SHOT";
}

isexplosivedamage(var_0) {
  return var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH" || var_0 == "MOD_EXPLOSIVE";
}

_id_5697(var_0, var_1) {
  return var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME";
}

_id_570A(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3._id_0117)) {
      if(_isshipbuild() && !isDefined(var_3._id_003B)) {
        return 0;
      }

      if(var_3._id_003B == "script_vehicle") {
        return 0;
      }

      if(var_3._id_003B == "misc_turret") {
        return 0;
      }

      if(var_3._id_003B == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3._id_0A4B)) {
      if(var_3._id_0A4B == "dog") {
        return 0;
      }
    }
  }

  return (var_1 == "head" || var_1 == "helmet") && !_id_5755(var_2) && (_id_45B5(var_0) == "dp28_mp" || var_2 != "MOD_IMPACT") && !_id_56DF(var_0);
}

_id_5670(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  return weaponinventorytype(var_0) == "altmode";
}

_id_118D(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1) && _isagent(var_0) && isDefined(var_0._id_0A4B) && var_0._id_0A4B == "leprechauns") {
    return 0;
  } else if(isDefined(var_0) && isDefined(var_1) && _isagent(var_0) && isDefined(var_0._id_0A4B) && var_0._id_0A4B == "mp_zombie_generic") {
    return 0;
  } else if(isDefined(var_0) && isDefined(var_1) && _isagent(var_1) && isDefined(var_1._id_0A4B) && var_1._id_0A4B == "paratroopers" && isDefined(var_1._id_0117) && var_1._id_0117 == var_0) {
    return 1;
  } else if(!level.teambased) {
    return 0;
  } else if(_func_367() && isDefined(var_1) && isDefined(var_0) && isDefined(var_1._id_572A) && isDefined(var_0._id_572A) && var_1._id_572A && var_0._id_572A) {
    return 0;
  } else if(!isDefined(var_1) || !isDefined(var_0)) {
    return 0;
  } else if(!isDefined(var_0.team) || !isDefined(var_1.team)) {
    return 0;
  } else if(var_0 == var_1) {
    return 0;
  } else if(isDefined(var_1._id_984E) && var_0.pers["team"] == var_1.team) {
    return 0;
  } else if(isDefined(var_1.isfiringturret) && var_1.isfiringturret) {
    return 0;
  } else if(var_0.team == var_1.team) {
    return 1;
  } else {
    return 0;
  }
}

playerhaskillstreak(var_0, var_1) {
  foreach(var_3 in var_0.pers["killstreaks"]) {
    if(isDefined(var_3._id_944C) && var_3._id_944C == var_1) {
      return 1;
    }
  }

  return 0;
}

vehicle_diveboatissubmerged(var_0) {
  if(!(isDefined(self._id_4D3C) && common_scripts\utility::_id_0F79(self._id_4D3C, var_0))) {
    self._id_4D3C = common_scripts\utility::_id_0F6F(self._id_4D3C, var_0);
    var_0 notify("calculate_new_level_targets");
  }
}

_id_0974(var_0, var_1) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0._id_A1F5 = var_1;
    var_0._id_1A23 = "use";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
  }
}

_id_7C8D(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
  }
}

_id_0973(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0._id_1A23 = "damage";
    [[level.bot_funcs["bots_add_to_level_targets"]]](var_0);
  }
}

_id_7C8C(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_remove_from_level_targets"])) {
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_0);
  }
}

_id_67F4(var_0) {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["notify_enemy_bots_bomb_used"])) {
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var_0);
  }
}

_id_42EC() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bot_get_rank_xp_and_prestige"])) {
    return self[[level.bot_funcs["bot_get_rank_xp_and_prestige"]]]();
  }
}

_id_8568() {
  var_0 = _id_42EC();

  if(isDefined(var_0)) {
    self.pers["rankxp"] = var_0._id_7A6D;
    self.pers["prestige"] = var_0._id_76B0;
    self.pers["prestige_fake"] = var_0._id_76B0;
  }
}

_id_8567() {
  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bot_set_rank_options"])) {
    self[[level.bot_funcs["bot_set_rank_options"]]]();
  }
}

_id_843E() {
  if(!isDefined(level._id_258F)) {
    level._id_258F = getDvar("5554") == "true";
  } else {}

  if(!isDefined(level._id_01D4)) {
    level._id_01D4 = getDvar("3475") == "true";
  } else {}

  if(!isDefined(level._id_01D5)) {
    level._id_01D5 = getDvar("2695") == "true";
  } else {}

  if(!isDefined(level._id_0148)) {
    level._id_0148 = getDvar("3864") == "true";
  } else {}

  if(!isDefined(level._id_0149)) {
    level._id_0149 = getDvar("3957") == "true";
  } else {}
}

_id_5583() {
  if(level._id_01D4 || level._id_0148 || !level._id_258F) {
    return 1;
  } else {
    return 0;
  }
}

_id_8670(var_0, var_1, var_2) {
  if(!isDefined(level._id_258F) || !isDefined(level._id_01D4) || !isDefined(level._id_0148)) {
    _id_843E();
  }

  if(_id_5583()) {
    setDvar(var_0, var_2);
  } else {
    setDvar(var_0, var_1);
  }
}

_id_583E(var_0, var_1) {
  return isDefined(var_1.team) && var_1.team != var_0.team;
}

_id_5828(var_0, var_1) {
  return isDefined(var_1._id_0117) && var_1._id_0117 != var_0;
}

_id_4507() {
  return (0, 0, 5000);
}

_id_4508() {
  return (0, 0, 2500);
}

_id_7E50(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(level._id_6859) && isDefined(level._id_6869)) {
    self setclienttriggervisionset(level._id_6869, var_0);
    self visionsetnakedforplayer(level._id_6869, var_0);
    _id_85F0(level._id_6869, var_0);
  } else if(isDefined(self.usingremote) && isDefined(self._id_7E7B)) {
    self setclienttriggervisionset(self._id_7E7B, var_0);
    self visionsetnakedforplayer(self._id_7E7B, var_0);
    _id_85F0(self._id_7E7B, var_0);
  } else {
    self setclienttriggervisionset("", var_0);
    self visionsetnakedforplayer("", var_0);
    _id_85F0("", var_0);
  }
}

_id_8513(var_0) {
  if(!isPlayer(self)) {
    return;
  }
  if(isDefined(level._id_5D79)) {
    level._id_5D7A = level._id_5D79;
  }

  level._id_5D79 = var_0;
  self lightsetforplayer(var_0);
}

_id_23C0() {
  if(!isPlayer(self)) {
    return;
  }
  var_0 = _getmapcustom("map");

  if(isDefined(level._id_5D7A)) {
    var_0 = level._id_5D7A;
    level._id_5D7A = undefined;
  }

  level._id_5D79 = var_0;
  self lightsetforplayer(var_0);
}

_id_5D22(var_0, var_1, var_2, var_3) {
  if(!isPlayer(self)) {
    return;
  }
  self lightsetoverrideenableforplayer(var_0, var_1);
  _id_A6D0(var_2, ["death", "disconnect"]);

  if(isDefined(self)) {
    self lightsetoverridedisableforplayer(var_3);
  }
}

_id_4704() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isDefined(level._id_48CB)) {
      level._id_48CB++;
    } else {
      level._id_48CB = 1;
    }

    var_0 = "script" + level._id_48CB;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

_id_42B8(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(!isDefined(var_5) || var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(isDefined(var_5.team) && var_5.team == "spectator" || var_5.sessionstate == "spectator") {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5.forcespectatorclient == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_85F0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_42B8(var_4, var_5);

  foreach(var_9 in var_7) {
    var_9 notify("changing_watching_visionset");

    if(isDefined(var_3) && var_3) {
      var_9 visionsetmissilecamforplayer(var_0, var_1);
    } else if(isDefined(var_6) && var_6) {
      var_9 visionsetpostapplyforplayer(var_0, var_1);
    } else {
      var_9 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      var_9 thread _id_7D4B(self, var_1 + var_2, var_6);
      var_9 thread _id_7D49(self, var_6);

      if(var_9 _id_5727()) {
        var_9 thread _id_7D4A();
      }
    }
  }
}

_id_7D4A() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0.0);
  self visionsetpostapplyforplayer("", 0.0);
}

_id_7D4B(var_0, var_1, var_2) {
  self endon("changing_watching_visionset");
  var_0 endon("disconnect");
  var_3 = gettime();
  var_4 = self.team;

  while(gettime() - var_3 < var_1 * 1000) {
    if(self.team != var_4 || !common_scripts\utility::_id_0F79(var_0 _id_42B8(), self)) {
      if(isDefined(var_2) && var_2) {
        self visionsetpostapplyforplayer("", 0.0);
      } else {
        self visionsetnakedforplayer("", 0.0);
      }

      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

_id_7D49(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");

  if(isDefined(var_1) && var_1) {
    self visionsetpostapplyforplayer("", 0.0);
  } else {
    self visionsetnakedforplayer("", 0.0);
  }
}

_id_073C(var_0) {
  if(_isagent(var_0) && (!isDefined(var_0._id_565F) || !var_0._id_565F)) {
    return undefined;
  }

  return var_0;
}

_id_06D6(var_0, var_1) {
  if(!isDefined(self._id_6609)) {
    self._id_6609 = [];
    self._id_76E2 = [];
  } else {
    self._id_76E2[0] = self._id_6609[0];
    self._id_76E2[1] = self._id_6609[1];
  }

  self._id_6609[0] = var_0;
  self._id_6609[1] = var_1;
  self setnameplatematerial(var_0, var_1);
}

_id_06AF() {
  if(isDefined(self._id_76E2)) {
    self setnameplatematerial(self._id_76E2[0], self._id_76E2[1]);
  } else {
    self setnameplatematerial("", "");
  }

  self._id_6609 = undefined;
  self._id_76E2 = undefined;
}

_id_3B88(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  if(var_2.size > 0) {
    foreach(var_4 in var_2) {
      var_5 = 0;

      if(isDefined(var_4.setflaggedanimknoball)) {
        if(isDefined(var_4.setlookatent) && var_4.setlookatent == "delta_anim") {
          var_5 = 1;
        }

        var_4 thread _id_71F5(var_1, var_5);
      }
    }
  }
}

_id_71F5(var_0, var_1) {
  if(var_0 == 1) {
    wait(_randomfloatrange(0.0, 1));
  }

  if(var_1 == 0) {
    self scriptmodelplayanim(self.setflaggedanimknoball);
  } else {
    self scriptmodelplayanimdeltamotion(self.setflaggedanimknoball);
  }
}

_id_73AF(var_0, var_1) {
  _id_0693("dodge", var_0, var_1, ::allowdodge);
}

_id_0693(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self._id_73D4)) {
    self._id_73D4 = [];
  }

  if(!isDefined(self._id_73D4[var_0])) {
    self._id_73D4[var_0] = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "default";
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(var_1) {
    self._id_73D4[var_0] = common_scripts\utility::_id_0F93(self._id_73D4[var_0], var_2);

    if(!self._id_73D4[var_0].size) {
      if(var_4) {
        self call[[var_3]](1);
      } else {
        self[[var_3]](1);
      }
    }
  } else {
    if(!isDefined(common_scripts\utility::_id_0F7E(self._id_73D4[var_0], var_2))) {
      self._id_73D4[var_0] = common_scripts\utility::_id_0F6F(self._id_73D4[var_0], var_2);
    }

    if(var_4) {
      self call[[var_3]](0);
    } else {
      self[[var_3]](0);
    }
  }
}

_id_5FBA(var_0, var_1, var_2, var_3) {
  var_4 = 500;

  switch (var_0) {
    case "killstreakRemote":
      var_4 = 300;
      break;
    case "coopStreakPrompt":
      var_4 = 301;
      break;
    default:
      break;
  }

  _id_065E(var_4, var_0, var_2, var_3);
  self makeglobalusable(var_4, var_2, var_3);
  self setHintString(var_1);
  self setCursorHint("HINT_NOICON");
}

_id_065E(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_47E6)) {
    level._id_47E6 = [];
  }

  var_4 = -1;

  for(var_5 = 0; var_5 < level._id_47E6.size; var_5++) {
    var_6 = level._id_47E6[var_5];

    if(var_6.priority > var_0) {
      if(var_4 == -1) {
        var_4 = var_5;
      }

      break;
    }

    if(var_6.priority == var_0) {
      var_6.priority = var_6.priority + 0.01;

      if(var_6._id_3655) {
        var_6._id_378F makeglobalusable(var_6.priority, var_6.player, var_6.team);
      }

      if(var_4 == -1) {
        var_4 = var_5;
      }
    }
  }

  if(var_4 == -1) {
    var_4 = 0;
  }

  var_7 = spawnStruct();
  var_7._id_378F = self;
  var_7.priority = var_0;
  var_7.type = var_1;
  var_7.player = var_2;
  var_7.team = var_3;
  var_7._id_3655 = 1;
  level._id_47E6 = common_scripts\utility::_id_0F86(level._id_47E6, var_7, var_4);
}

_id_5FB9() {
  var_0 = undefined;

  foreach(var_2 in level._id_47E6) {
    if(var_2._id_378F == self) {
      var_0 = var_2;
      break;
    }
  }

  if(isDefined(var_0)) {
    var_4 = var_0.priority;
    level._id_47E6 = common_scripts\utility::_id_0F93(level._id_47E6, var_0);
    self makeglobalunusable();

    foreach(var_2 in level._id_47E6) {
      if(var_4 > var_2.priority && int(var_4) == int(var_2.priority)) {
        var_2.priority = var_2.priority - 0.01;

        if(var_2._id_3655) {
          var_2._id_378F makeglobalusable(var_2.priority, var_2.player, var_2.team);
        }
      }
    }
  }
}

_id_2F89() {
  foreach(var_1 in level._id_47E6) {
    if(var_1._id_378F == self) {
      if(var_1._id_3655) {
        var_1._id_378F makeglobalunusable();
        var_1._id_3655 = 0;
      }

      break;
    }
  }
}

_id_3659() {
  foreach(var_1 in level._id_47E6) {
    if(var_1._id_378F == self) {
      if(!var_1._id_3655) {
        var_1._id_378F makeglobalusable(var_1.priority, var_1.player, var_1.team);
        var_1._id_3655 = 1;
      }

      break;
    }
  }
}

_id_8668(var_0) {
  self setdepthoffield(var_0["nearStart"], var_0["nearEnd"], var_0["farStart"], var_0["farEnd"], var_0["nearBlur"], var_0["farBlur"]);
}

_id_86F8() {
  if(!isDefined(level._id_6F9D)) {
    return;
  }
  if(isDefined(level._id_6F9D["dofScripting"])) {
    self enablephysicaldepthoffieldscripting(level._id_6F9D["dofScripting"]);
  }

  self setphysicaldepthoffield(level._id_6F9D["fstop"], level._id_6F9D["focus"], level._id_6F9D["focusSpeed"], level._id_6F9D["apertureSpeed"]);
  self setphysicalviewmodeldepthoffield(level._id_6F9D["viewModelFstop"], level._id_6F9D["viewModelFocus"]);
}

_id_86F7(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self ismlgspectator()) {
    return;
  }
  if(!isDefined(level._id_6F9D)) {
    level._id_6F9D = [];
  }

  level._id_6F9D["fstop"] = var_0;
  level._id_6F9D["focus"] = var_1;
  level._id_6F9D["viewModelFstop"] = var_2;
  level._id_6F9D["viewModelFocus"] = var_3;
  level._id_6F9D["focusSpeed"] = var_4;
  level._id_6F9D["apertureSpeed"] = var_5;
  level._id_6F9D["dofScripting"] = var_6;
  _id_86F8();
}

_id_56D9(var_0) {
  if(level.teambased) {
    return _id_5781(var_0);
  } else {
    return _id_577B(var_0);
  }
}

_id_5781(var_0) {
  return var_0.team != self.team;
}

_id_577B(var_0) {
  if(isDefined(var_0._id_0117)) {
    return var_0._id_0117 != self;
  } else {
    return var_0 != self;
  }
}

_id_56B4() {
  if(_issystemlink() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

_id_56B3() {
  if(_issplitscreen() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

_id_56B2() {
  if(privatematch() && getdvarint("4974")) {
    return 1;
  }

  return 0;
}

_id_56B1() {
  if(getdvarint("isMLGMatch")) {
    return 1;
  }

  return 0;
}

_id_9067(var_0, var_1, var_2, var_3) {
  var_4 = _spawnfx(var_0, var_2, var_3);
  var_4 _id_3F7B(var_1);
  return var_4;
}

_id_3F7B(var_0) {
  thread _id_8BFC(var_0);
  setfxkillondelete(self, 1);
  _triggerfx(self);
}

_id_8BFC(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self hide();

    foreach(var_2 in level.players) {
      var_3 = var_2.team;

      if(var_2 ismlgspectator()) {
        var_3 = "broadcaster";
      } else if(var_3 != "axis") {
        var_3 = "allies";
      }

      if(var_0 == var_3 || var_0 == "neutral") {
        self showtoplayer(var_2);
      }
    }

    level waittill("joined_team");
  }
}

_id_74A3(var_0, var_1, var_2, var_3) {
  var_4 = _spawnlinkedfx(var_0, var_1, var_2);
  _triggerfx(var_4, var_3);
  return var_4;
}

_id_9028(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _spawnlinkedfx(var_0, var_4, var_5);
  var_6 _id_3F7A(var_1, var_2, var_3);
  return var_6;
}

_id_3F7A(var_0, var_1, var_2) {
  thread _id_8C1B(var_0, var_1, var_2);
  setfxkillondelete(self, 1);
  _triggerfx(self);
}

_id_8C1B(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self hide();

    foreach(var_4 in level.players) {
      var_5 = var_4.team;

      if(var_4 ismlgspectator()) {
        var_5 = "broadcaster";
      } else if(var_5 != "axis") {
        var_5 = "allies";
      }

      var_6 = var_4 _hasperk("specialty_stun_resistance");

      if(!var_2 && var_6 || var_1 == var_5 && var_4 == var_0 && !var_6) {
        continue;
      }
      if(var_1 == var_5 || var_1 == "neutral" || var_6 || var_1 != var_5 && var_4 == var_0) {
        self showtoplayer(var_4);
      }
    }

    level waittill("joined_team");
  }
}

_id_922B(var_0) {
  var_1 = issubstr(var_0, "zk383");

  if(isDefined(self.pers["altModeActive"]) && isDefined(self._id_0079) && self.pers["altModeActive"] && self._id_0079 != 5 && getweaponclass(var_0) == "weapon_smg" && issubstr(var_0, "suppressor") && !var_1) {
    var_2 = _id_04CA::_id_461C(1);

    if(var_2 == "suppressor_level1" || var_2 == "suppressor_level2" || var_2 == "suppressor_level3") {
      var_0 = "alt+" + var_0;
    }
  } else if(var_1 && common_scripts\utility::_id_562E(self.pers["altModeActive"]))
    var_0 = "alt+" + var_0;
  else if(isDefined(self._id_0079) && self._id_0079 != 5 && getweaponclass(var_0) == "weapon_shotgun" && issubstr(var_0, "dragon_breath")) {}

  return var_0;
}

_id_4340(var_0) {
  var_1 = "m1garand_mp";

  if(isDefined(var_0._id_76F8) && var_0._id_76F8 != "none") {
    var_1 = var_0._id_76F8;
    var_1 = _id_922B(var_1);
  } else if(isDefined(var_0.botclearscriptgoal) && var_0.botclearscriptgoal != "none")
    var_1 = var_0.botclearscriptgoal;
  else if(isDefined(var_0._id_60EE) && var_0._id_60EE != "none") {
    var_1 = var_0._id_60EE;
  }

  return var_1;
}

_id_744E() {
  self._id_7DEE = self getplayerangles();
}

_id_7447() {
  if(isDefined(self._id_7DEE)) {
    if(self.team != "spectator") {
      self setplayerangles(self._id_7DEE);
    }

    self._id_7DEE = undefined;
  }
}

_id_863F(var_0, var_1, var_2, var_3) {
  var_0 _id_04D1::set2dicon("broadcaster", var_1, undefined, var_2);
  var_0 _id_04D1::playsoundtoteam("broadcaster", var_1, var_2, var_3);
}

_id_907D(var_0, var_1, var_2) {
  var_3 = _getEnt(var_0, "targetname");

  if(!isDefined(var_3)) {
    return undefined;
  }

  var_4 = spawn("script_model", var_1);
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_4.angles = var_2;
  return var_4;
}

_id_56B9() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return 1;
  }

  return 0;
}

_id_86BF(var_0) {
  var_1 = getEntArray();
  _setomnvar("lighting_state", var_0);

  if(!getdvarint("233")) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_5D56) && isDefined(var_3.classname) && (var_3.classname == "script_brushmodel" || var_3.classname == "script_model")) {
        if(var_3._id_5D56 == 0) {
          continue;
        }
        if(var_3._id_5D56 == var_0) {
          var_3 common_scripts\utility::_id_8BE0();
          var_3 allowriotshieldplant();
          continue;
        }

        var_3 notify("hidingLightingState");
        var_3 common_scripts\utility::_id_4CEB();
      }
    }
  }
}

_id_46E7() {
  return _gettimeutc();
}

_id_08F7() {
  if(isDefined(self._id_005C) && self._id_005C <= 0) {
    return undefined;
  }

  if(self.classname == "agent_enemy_dog_raid") {
    var_0 = [[level._id_0A4C]](undefined, undefined, self.origin, self.angles, undefined, 0, undefined, self.classname);
  } else {
    var_0 = [[level._id_0A4D]]("player", "axis", undefined, self.origin, self.angles, undefined, 0, 0, undefined, self.classname);
  }

  if(isDefined(var_0) && _isagent(var_0)) {
    if(isDefined(level._id_0A41[var_0._id_0A4B]["set_initial_behavior"])) {
      self[[level._id_0A41[var_0._id_0A4B]["set_initial_behavior"]]](var_0);
    }

    if(isDefined(self._id_005C)) {
      self._id_005C--;
    }
  }

  return var_0;
}

_id_0FA7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_005C) && var_4._id_005C <= 0) {
      continue;
    }
    var_5 = var_4 _id_08F7();

    if(!var_1) {}

    var_2[var_2.size] = var_5;
  }

  if(!var_1) {}

  return var_2;
}

_id_8FE4(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && var_3) {
    var_4 = _getvehiclenode(var_0, "script_noteworthy");
  } else {
    var_4 = _getvehiclenode(var_0, "targetname");
  }

  var_5 = _func_2CD(var_4.origin, var_4.angles, var_2, var_1);
  var_5 notify("forward");
  var_5._id_01C7 = "forward";
  var_5._id_01C1 = "forward";
  var_5._id_17DC = 0;
  var_5._id_931A = "forward";
  var_5 startpath(var_4);
  return var_5;
}

_id_0FA8(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");
  return _id_0FA7(var_2, var_1);
}

finishplayerdamage_impactfx(var_0) {
  if(!isDefined(level._id_738E)) {
    thread _id_5243();
  }

  if(var_0) {
    self._id_738F = 1;
  } else {
    self._id_738F = undefined;
  }
}

_id_5243() {
  level._id_738E = 1;

  foreach(var_1 in level.players) {
    var_1 thread _id_A1CE();
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 thread _id_A1CE();
  }
}

_id_A1CE() {
  self endon("disconnect");
  var_0 = undefined;

  for(;;) {
    var_1 = self getusableentity();

    if(isDefined(var_1) && _distance2dsquared(var_1.origin, self.origin) > _pow(getdvarfloat("2098"), 2)) {
      var_1 = undefined;
    }

    if(isDefined(var_1) && (!isDefined(var_0) || var_1 != var_0)) {
      if(isDefined(var_1._id_738F)) {
        var_1 notify("player_usable_focus", self);
      }
    }

    if(isDefined(var_0) && (!isDefined(var_1) || var_1 != var_0)) {
      if(isDefined(var_0._id_738F)) {
        var_0 notify("player_usable_focus_end", self);
      }
    }

    waitframe();
    var_0 = var_1;
  }
}

_id_461F() {
  if(isDefined(level._id_585D) && level._id_585D) {
    return common_scripts\utility::_id_46A8();
  }

  if(_func_3AC()) {
    return common_scripts\utility::_id_46AE();
  }

  return common_scripts\utility::_id_46A7();
}

_id_461E() {
  if(_func_3AC()) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

_id_86FB() {
  level._id_933C = _id_461F();
  level._id_5E09 = _id_461E();
}

_id_452A(var_0) {
  if(!isDefined(var_0) || var_0 == "" || var_0 == "none" || var_0 == "specialty_null") {
    return 0;
  } else {
    return _func_310(var_0);
  }
}

_id_452B(var_0) {
  if(isDefined(var_0) && var_0 != 0) {
    var_1 = _func_311(var_0);
    return var_1;
  } else
    return "none";
}

_id_473D(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0;

  if(issubstr(var_0, "_raid")) {
    var_1._id_3FC3 = 2;
    var_2 = _func_337(var_0, "_raid");
  } else if(issubstr(var_0, "_zm")) {
    var_1._id_3FC3 = 1;
    var_2 = _func_337(var_0, "_zm");
  } else
    var_1._id_3FC3 = 0;

  var_1.guid = _id_452A(var_2);
  return var_1;
}

_id_473C(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.guid = var_0;
  var_2._id_3FC3 = var_1;
  return var_2;
}

_id_4737(var_0) {
  var_1 = "none";

  if(!isDefined(var_0) || !isDefined(var_0.guid) || var_0.guid == 0 || !isDefined(var_0._id_3FC3)) {
    return var_1;
  }

  var_2 = _id_452B(var_0.guid);

  if(var_0._id_3FC3 == 2) {
    var_1 = _func_2FF(var_2, "_mp") + "_raid" + "_mp";
  } else if(var_0._id_3FC3 == 1) {
    var_1 = _func_2FF(var_2, "_mp") + "_zm";
  } else {
    var_1 = var_2;
  }

  return var_1;
}

_id_472C(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && var_0 != 0) {
    var_1 = _func_314(var_0);
  }

  return var_1;
}

_id_472D(var_0) {
  var_1 = 0;

  if(!isDefined(var_0) || !isDefined(var_0.guid) || var_0.guid == 0 || !isDefined(var_0._id_3FC3)) {
    return var_1;
  }

  var_1 = _func_314(var_0.guid);
  return var_1;
}

_id_44CF(var_0) {
  var_1 = spawnStruct();
  var_2 = var_0;

  if(issubstr(var_0, "_raid")) {
    var_1._id_3FC3 = 2;
    var_2 = _func_337(var_0, "_raid");
  } else if(issubstr(var_0, "_zm")) {
    var_1._id_3FC3 = 1;
    var_2 = _func_337(var_0, "_zm");
  } else
    var_1._id_3FC3 = 0;

  var_1.guid = _id_452A(var_2);
  return var_1;
}

_id_44CE(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.guid = var_0;
  var_2._id_3FC3 = var_1;
  return var_2;
}

_id_44CD(var_0) {
  var_1 = "none";

  if(!isDefined(var_0) || !isDefined(var_0.guid) || var_0.guid == 0 || !isDefined(var_0._id_3FC3)) {
    return var_1;
  }

  var_2 = _id_452B(var_0.guid);

  if(var_0._id_3FC3 == 2) {
    var_1 = _func_2FF(var_2, "_mp") + "_raid" + "_mp";
  } else if(var_0._id_3FC3 == 1) {
    var_1 = _func_2FF(var_2, "_mp") + "_zm";
  } else if(_id_579B() && common_scripts\utility::_id_562E(level._id_79C1)) {
    if(var_2 == "smoke_grenade_mp") {
      var_1 = "smoke_grenade_axis_mp";
    } else if(var_2 == "smoke_grenade_axis_mp") {
      var_1 = "smoke_grenade_mp";
    } else {
      var_1 = var_2;
    }
  } else
    var_1 = var_2;

  return var_1;
}

_id_5746(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

_id_873B(var_0) {
  level.teambased = var_0;
  setDvar("4491", var_0);
}

_id_44DD() {
  var_0 = self getweaponlistprimaries();
  return var_0[0];
}

_id_5C98(var_0, var_1, var_2) {
  var_3 = _getEnt(var_0, "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3 getlightintensity();
  var_3._id_36D5 = var_2;
  var_5 = 0;

  while(var_5 < var_1) {
    var_6 = var_4 + (var_2 - var_4) * (var_5 / var_1);
    var_5 = var_5 + 0.05;
    var_3 setlightintensity(var_6);
    waitframe();
  }

  var_3 setlightintensity(var_2);
}

_id_5C99(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_6 = var_5 getlightintensity();
    var_5._id_36D5 = var_2;
    var_7 = 0;

    while(var_7 < var_1) {
      var_8 = var_6 + (var_2 - var_6) * (var_7 / var_1);
      var_7 = var_7 + 0.05;
      var_5 setlightintensity(var_8);
      waitframe();
    }

    var_5 setlightintensity(var_2);
  }
}

_id_33C0(var_0, var_1, var_2, var_3) {
  level endon(var_3);

  for(;;) {
    waitframe();
  }
}

_id_33A8(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = var_4;
  } else {
    var_5 = 16;
  }

  var_6 = 360 / var_5;
  var_7 = [];

  for(var_8 = 0; var_8 < var_5; var_8++) {
    var_9 = var_6 * var_8;
    var_10 = _cos(var_9) * var_1;
    var_11 = _sin(var_9) * var_1;
    var_12 = var_0[0] + var_10;
    var_13 = var_0[1] + var_11;
    var_14 = var_0[2];
    var_7[var_7.size] = (var_12, var_13, var_14);
  }

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_15 = var_7[var_8];

    if(var_8 + 1 >= var_7.size) {
      var_16 = var_7[0];
    } else {
      var_16 = var_7[var_8 + 1];
    }

    thread _id_33C0(var_15, var_16, var_2, var_3);
  }
}

_id_2D4F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0._id_0164;

  if(isDefined(var_1) && isDefined(level._id_947C["script_linkname"]) && isDefined(level._id_947C["script_linkname"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["script_linkname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_947C["script_linkname"][var_1][var_4] = undefined;
      }
    }

    if(level._id_947C["script_linkname"][var_1].size == 0) {
      level._id_947C["script_linkname"][var_1] = undefined;
    }
  }

  var_1 = var_0._id_0165;

  if(isDefined(var_1) && isDefined(level._id_947C["script_noteworthy"]) && isDefined(level._id_947C["script_noteworthy"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["script_noteworthy"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_947C["script_noteworthy"][var_1][var_4] = undefined;
      }
    }

    if(level._id_947C["script_noteworthy"][var_1].size == 0) {
      level._id_947C["script_noteworthy"][var_1] = undefined;
    }
  }

  var_1 = var_0.target;

  if(isDefined(var_1) && isDefined(level._id_947C["target"]) && isDefined(level._id_947C["target"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["target"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_947C["target"][var_1][var_4] = undefined;
      }
    }

    if(level._id_947C["target"][var_1].size == 0) {
      level._id_947C["target"][var_1] = undefined;
    }
  }

  var_1 = var_0.targetname;

  if(isDefined(var_1) && isDefined(level._id_947C["targetname"]) && isDefined(level._id_947C["targetname"][var_1])) {
    foreach(var_4, var_3 in level._id_947C["targetname"][var_1]) {
      if(isDefined(var_3) && var_0 == var_3) {
        level._id_947C["targetname"][var_1][var_4] = undefined;
      }
    }

    if(level._id_947C["targetname"][var_1].size == 0) {
      level._id_947C["targetname"][var_1] = undefined;
    }
  }

  if(isDefined(level.struct)) {
    foreach(var_4, var_3 in level.struct) {
      if(var_0 == var_3) {
        level.struct[var_4] = undefined;
      }
    }
  }
}

_id_863E(var_0, var_1, var_2, var_3) {
  if(var_1 == "axis") {
    var_0 = var_0 + 2000;
  } else if(var_1 == "allies") {
    var_0 = var_0 + 1000;
  }

  if(isDefined(var_2)) {
    var_0 = var_0 + (var_2 + 1) * 10000;
  }

  if(isDefined(var_3)) {
    if(_isnumber(var_3)) {
      var_0 = var_0 + (var_3 + 1) * 1000000;
    } else {
      common_scripts\utility::_id_3809("broadcaster announcement extra data supports numbers only. Invalid extra data: " + var_3);
    }
  }

  _setomnvar("ui_broadcaster_announcement", var_0);
}

_id_5246() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_0F24();
  }
}

_id_0F24() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("applyLoadout");
    var_0 = getEntArray("scorestreakclosed", "targetname");

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        var_2 enableportalgroup(1, self);
      }
    }

    var_0 = getEntArray("scorestreakopen", "targetname");

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        var_2 enableportalgroup(0, self);
      }
    }
  }
}

array_combine_no_dupes(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && !isDefined(common_scripts\utility::_id_0F7E(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && !isDefined(common_scripts\utility::_id_0F7E(var_2, var_4))) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

unsignedint_to_hexstring_fixed(var_0) {
  var_1 = "0123456789ABCDEF";

  if(var_0 == 0) {
    return var_1[0];
  }

  var_2 = var_0;

  for(var_3 = ""; var_0 > 0; var_0 = var_0 >> 4) {
    var_3 = var_1[int(var_0 % 16)] + var_3;
  }

  var_3 = "0x" + var_3;
  return var_3;
}

no_obfuscate(var_0) {
  return var_0;
}