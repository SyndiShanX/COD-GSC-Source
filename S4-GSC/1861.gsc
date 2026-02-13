/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1861.gsc
*************************************************/

_id_8009() {
  level._id_C1FF = ::_id_3F4A;
  level._id_171B = ["iw8_la_mike32_mp"];
  _id_C09F();
  setdvarifuninitialized("#x38241c5fe01eab78b", 0);
  level._id_F959 = getdvarint("#x38241c5fe01eab78b", 0);
}

_id_C09F() {
  level._id_A302 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 1);

    if(var_1 == "") {
      break;
    }

    level._id_A302[var_1] = spawnStruct();
    level._id_A302[var_1].index = int(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 0));
    level._id_A302[var_1]._id_C189 = var_1;
    level._id_A302[var_1]._id_3D91 = int(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 4));
    level._id_A302[var_1]._id_3D06 = float(tablelookupbyrow("cp/cp_munitiontable.csv", var_0, 5));
    var_0++;
  }
}

_id_6FBB() {
  self endon("disconnect");
  level endon("game_ended");
  self._id_4EC2 = 0;
  var_0 = 3;
  var_1 = 3;

  if(istrue(level._id_F959)) {
    var_1 = 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var_1);

  for(;;) {
    self waittill("luinotifyserver", var_2, var_3);

    if(var_2 == "radial_menu_munition") {
      var_4 = 0;

      if(istrue(level._id_4A26)) {
        scripts\cp\utility::_id_7970("munition_unavailable", 1, 2);
        continue;
      }

      if(!isDefined(self._id_A2FE)) {
        if(var_4) {
          iprintlnbold("self.munition_slots undefined");
        }

        continue;
      }

      if(self isonladder()) {
        if(var_4) {
          iprintlnbold("IsOnLadder() failed");
        }

        continue;
      }

      if(istrue(self._id_E3E5)) {
        if(var_4) {
          iprintlnbold("self.spectating");
        }

        continue;
      }

      if(isDefined(self._id_41E1)) {
        if(var_4) {
          iprintlnbold("self.currentPiece defined");
        }

        continue;
      }

      if(istrue(self._id_85CC)) {
        if(var_4) {
          iprintlnbold("self.is_fast_traveling");
        }

        continue;
      }

      if(istrue(self.inlaststand)) {
        if(var_4) {
          iprintlnbold("self.inLastStand");
        }

        continue;
      }

      if(istrue(self._id_8A07)) {
        if(var_4) {
          iprintlnbold("self.isReviving");
        }

        continue;
      }

      if(isDefined(self._id_B172)) {
        if(var_4) {
          iprintlnbold("self.placementModel defined");
        }

        continue;
      }

      if(istrue(self._id_87A7)) {
        if(var_4) {
          iprintlnbold("self.isCarrying");
        }

        continue;
      }

      if(isDefined(self._id_7A89)) {
        if(var_4) {
          iprintlnbold("self.hostageCarried defined");
        }

        continue;
      }

      if(level.gametype == "cp_pvpve") {
        if(var_4) {
          iprintlnbold("level.gametype == cp_pvpve");
        }

        continue;
      }

      if(istrue(self._id_24F1)) {
        if(var_4) {
          iprintlnbold("self.bGivenSentry");
        }

        continue;
      }

      if(istrue(self._id_EC7E)) {
        if(var_4) {
          iprintlnbold("self.tablet_out");
        }

        continue;
      }

      if(istrue(self._id_2039)) {
        if(var_4) {
          iprintlnbold("self.b_in_vehicle");
        }

        scripts\cp\utility::_id_7970("munition_unavailable", 1, 2);
        continue;
      }

      if(istrue(self._id_10841)) {
        if(var_4) {
          iprintlnbold("self.waiting_to_spawn");
        }

        continue;
      }

      if(self _meth_86B8()) {
        if(var_4) {
          iprintlnbold("self IsParachuting()");
        }

        continue;
      }

      if(self isskydiving()) {
        if(var_4) {
          iprintlnbold("self IsSkydiving()");
        }

        continue;
      }

      if(isDefined(self._id_4205)) {
        if(var_4) {
          iprintlnbold("self.currentTurret defined");
        }

        continue;
      }

      if(istrue(self._id_C681)) {
        if(var_4) {
          iprintlnbold("respawn in progress");
        }

        continue;
      }

      if(istrue(self._id_88DF)) {
        if(var_4) {
          iprintlnbold("self.isJuggernaut");
        }

        continue;
      }

      if(isDefined(level._id_A6DF) && level._id_A6DF == self) {
        if(var_4) {
          iprintlnbold("self is nuclear core carrier");
        }

        scripts\cp\utility::_id_7970("munition_unavailable", 1, 2);
        continue;
      }

      if(_id_073B::_id_B4EF(self)) {
        if(var_4) {
          iprintlnbold("player in last stand");
        }

        continue;
      }

      if(istrue(self._id_8913)) {
        if(var_4) {
          iprintlnbold("self.isLockedInKidnapAnim");
        }

        continue;
      }

      if(self _meth_846A()) {
        if(var_4) {
          iprintlnbold("self IsJumping()");
        }

        continue;
      }

      if(!self isonground()) {
        if(var_4) {
          iprintlnbold("self not IsOnGround()");
        }

        continue;
      }

      if(istrue(self._id_FF13)) {
        if(var_4) {
          iprintlnbold("self.usingObject");
        }

        continue;
      }

      if(istrue(self._id_86A3)) {
        if(var_4) {
          iprintlnbold("self.is_riding_heli");
        }

        continue;
      }

      if(istrue(level._id_C2D4)) {
        if(var_4) {
          iprintlnbold(" Regroup to plane started so disabled Munitions till process is complete");
        }

        continue;
      }

      if(istrue(self._id_504E)) {
        if(var_4) {
          iprintlnbold("Still dropping minigun");
        }

        continue;
      }

      if(!scripts\common\input_allow::_id_860C("cp_munitions")) {
        if(var_4) {
          iprintlnbold("munitions are not allowed");
        }

        scripts\cp\utility::_id_7970("munition_unavailable", 1, 2);
        continue;
      }

      if(var_3 >= 0 && var_3 <= 2) {
        var_5 = self._id_A2FE[var_3];

        if(isDefined(var_5) && var_5._id_C189 != "none" && var_5._id_C189 != "empty1" && var_5._id_C189 != "empty2" && var_5._id_C189 != "empty3") {
          if(istrue(_id_3107(var_3))) {
            if(scripts\cp\cp_weapon::_id_B4C8(self)) {
              var_6 = _id_DA9A(var_5._id_C189);

              if(var_6) {
                self._id_504E = 1;
                scripts\cp\cp_weapon::_id_4FF4(self);
                self waittill("weapon_change");

                while(scripts\cp\cp_weapon::_id_B4C8(self)) {
                  waitframe();
                }

                self._id_504E = undefined;
              }
            }

            thread _id_C40C(var_5._id_C189, var_3);
            var_7 = 0;

            if(var_7) {
              if(_id_860E(var_5._id_C189)) {
                self notify("munitions_used", var_5._id_C189);
              }

              _id_0705::_id_9776(self, var_5._id_C189);
            } else
              self notify("remove_munition_on_use");
          }
        }
      }
    }
  }
}

_id_DA9A(var_0) {
  return 1;
}

_id_C40C(var_0, var_1) {
  self notify("remove_munition_on_use");
  self endon("remove_munition_on_use");

  if(istrue(level._id_F959)) {
    return;
  }
  thread _id_D0AD(var_0, var_1);
  self waittill("munitions_used", var_0);
  _id_C40A(var_1, var_0);
}

_id_D0AD(var_0, var_1) {
  switch (var_0) {
    case "apache":
    case "chopper_gunner":
      self waittill("chopper_gunner_used");
      break;
    default:
      return;
  }

  self notify("munitions_used", var_0);
}

_id_860E(var_0) {
  switch (var_0) {
    case "ac130":
    case "trophysystem":
    case "cruise_missile":
    case "uav":
      return 1;
  }

  return 0;
}

_id_A2FD() {
  self endon("disconnect");
  var_0 = level._id_4A29;

  for(;;) {
    var_1 = getDvar("#x311998e6c039af360", "");

    if(var_1 != "") {
      level._id_4A29 = 1;
      _id_0922::_id_C4F1();
    } else {
      level._id_4A29 = var_0;

      if(!istrue(level._id_4A29)) {
        _id_0922::_id_CA64();
      }
    }

    wait 0.1;
  }
}

_id_FB84(var_0) {
  self setclientomnvar("cp_munition_sel_slot_idx", var_0);
}

_id_6750(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_1;
  }

  if(var_0 < var_1) {
    return var_2;
  }

  return var_0;
}

_id_C5C8(var_0, var_1) {
  var_0 notify("reset_munitions");
  var_2 = [];
  var_1 = 3;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(isDefined(var_0._id_A2FE) && isDefined(var_0._id_A2FE[var_3]) && isDefined(var_0._id_A2FE[var_3]._id_3D09)) {
      var_2[var_3] = var_0._id_A2FE[var_3]._id_3D09;
    } else {
      var_2[var_3] = undefined;
    }

    var_4 = var_0 _id_073C::_id_2E8A();

    if(!isDefined(var_0._id_A2FE) || !isDefined(var_0._id_A2FE[var_3])) {
      var_0._id_A2FE[var_3] = spawnStruct();
    }

    var_0._id_A301[var_3] = spawnStruct();

    if(_id_072E::_id_155A(var_0)) {
      var_0._id_A2FE[var_3]._id_C189 = var_0 _id_65BE(var_3);
      var_0._id_A301[var_3]._id_C189 = var_0._id_A2FE[var_3]._id_C189;
      var_0._id_A2FE[var_3]._id_3D06 = level._id_A302[var_0._id_A2FE[var_3]._id_C189]._id_3D06;
      var_0._id_A2FE[var_3]._id_3102 = 0;
      var_0._id_A2FE[var_3]._id_3D09 = undefined;
      var_0._id_A2FE[var_3]._id_E06D = undefined;

      if(isDefined(var_2[var_3])) {
        var_0._id_A2FE[var_3]._id_3D09 = var_2[var_3];
      }

      if(!istrue(level._id_F959)) {
        var_0._id_A2FE[var_3]._id_3102 = 0;

        if(!_id_0780::_id_85B4(var_3)) {
          var_0 setclientomnvar("cp_munition_1_timer", 1);
          var_0 setclientomnvar("cp_munition_2_timer", 1);
          var_0 setclientomnvar("cp_munition_3_timer", 1);
          var_0._id_A2FE[var_3]._id_3102 = 1;
        }
      }
    } else if(!isDefined(var_0._id_8009)) {
      var_0._id_A2FE[var_3]._id_C189 = "none";
      var_0._id_A2FE[var_3]._id_3D06 = level._id_A302[var_0._id_A2FE[var_3]._id_C189]._id_3D06;
      var_0._id_A2FE[var_3]._id_3102 = 0;
      var_0._id_A2FE[var_3]._id_3D09 = undefined;
      var_0._id_A2FE[var_3]._id_E06D = undefined;
    }

    var_5 = undefined;
    var_6 = "cp_munition_slot_reset";
    var_7 = undefined;

    switch (var_3) {
      case 0:
        var_5 = "cp_munition_slot_1";
        var_7 = 1;
        break;
      case 1:
        var_5 = "cp_munition_slot_2";
        var_7 = 2;
        break;
      case 2:
        var_5 = "cp_munition_slot_3";
        var_7 = 3;
        break;
      case 3:
        var_5 = "cp_munition_slot_4";
        break;
    }

    var_8 = level._id_A302[var_0._id_A2FE[var_3]._id_C189].index;

    if(isDefined(var_5) && isDefined(var_8) && isDefined(var_7)) {
      var_0 setclientomnvar(var_5, var_8);
    }
  }

  if(!isDefined(var_0._id_8009)) {
    var_0._id_8009 = 1;
  }

  if(!isDefined(var_0._id_961D)) {
    var_0._id_961D = 0;
  }

  if(var_0._id_961D == 0) {
    var_9 = 1;
  } else {
    var_9 = 0;
  }

  var_0 setclientomnvar("cp_loadout_changed", var_9);
  var_0._id_961D = var_9;

  if(istrue(level._id_F959)) {
    var_0 thread _id_3D07("munition_1_used", "cp_munition_1_timer", var_0, var_0._id_A2FE[0]._id_C189, var_0._id_A2FE[0]._id_3D06, 0);
    var_0 thread _id_3D07("munition_2_used", "cp_munition_2_timer", var_0, var_0._id_A2FE[1]._id_C189, var_0._id_A2FE[1]._id_3D06, 1);
    var_0 thread _id_3D07("munition_3_used", "cp_munition_3_timer", var_0, var_0._id_A2FE[2]._id_C189, var_0._id_A2FE[2]._id_3D06, 2);
    var_0 thread _id_3D07("munition_4_used", "cp_munition_4_timer", var_0, var_0._id_A2FE[3]._id_C189, var_0._id_A2FE[3]._id_3D06, 3);
  }
}

_id_65BE(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionWaveModeSetups", var_0, "munition");
  } else {
    var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "munitionSetups", var_0, "munition");
  }

  return var_1;
}

_id_670E(var_0) {
  var_1 = undefined;

  if(getdvarint("#x34f6731ffc5ce0a8f", 0)) {
    switch (self.class) {
      case "assault":
        var_1 = "grenade_launcher";
        break;
      case "medic":
        var_1 = "adrenaline";
        break;
      case "tank":
        var_1 = "sentry";
        break;
      case "hunter":
        var_1 = "drone_strike";
        break;
      case "engineer":
        var_1 = "recon_drone";
        break;
      case "crusader":
        var_1 = "riot_shield";
        break;
      default:
        break;
    }
  } else {
    switch (self.class) {
      case "assault":
        var_1 = "ammo_crate";
        break;
      case "medic":
        var_1 = "armor";
        break;
      case "tank":
        var_1 = "armor";
        break;
      case "hunter":
        var_1 = "ammo_crate";
        break;
      case "engineer":
        var_1 = "grenade_crate";
        break;
      case "crusader":
        var_1 = "grenade_crate";
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_1)) {} else {}

  return var_1;
}

_id_3D07(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 endon("reset_munitions");
  var_2 notify(var_0 + "_reset");
  var_2 endon(var_0 + "_reset");
  var_7 = var_4;
  var_8 = getdvarfloat("#x34bd290762af02f55", 1);
  var_4 = var_7 * var_8;
  var_9 = undefined;

  for(;;) {
    var_10 = 0;

    if(scripts\engine\utility::_id_5C0C("infil_complete") && !scripts\engine\utility::_id_5C00("infil_complete")) {
      var_10 = 1;
    }

    if(var_10) {
      waitframe();
      continue;
    }

    if(!isDefined(var_2._id_A2FE[var_5]._id_3D09)) {
      var_2._id_A2FE[var_5]._id_3D09 = 0;
      var_2 setclientomnvar(var_1, 0);
    }

    if(istrue(var_6)) {
      var_2._id_A2FE[var_5]._id_3D09 = var_4;
      var_2 setclientomnvar(var_1, 1);
      var_6 = undefined;
    }

    if(var_2._id_A2FE[var_5]._id_3D09 < var_4) {
      var_2._id_A2FE[var_5]._id_3102 = 0;
    }

    while(var_2._id_A2FE[var_5]._id_3D09 <= var_4) {
      var_11 = getdvarfloat("#x34bd290762af02f55", 1);

      if(var_11 != var_8) {
        var_8 = var_11;
        var_4 = var_7 * var_8;
      }

      if(istrue(var_2._id_74FD)) {
        var_2._id_A2FE[var_5]._id_3D09 = var_4 + 1;
      }

      if(var_4 == 0) {
        var_12 = 1;
      } else {
        var_12 = min(var_2._id_A2FE[var_5]._id_3D09 / var_4, 1);
      }

      var_2 setclientomnvar(var_1, var_12);

      if(var_12 < 1) {
        var_13 = 0.05;
        var_2._id_A2FE[var_5]._id_3D09 = var_2._id_A2FE[var_5]._id_3D09 + var_13;
      } else
        break;

      wait 0.05;
    }

    var_2._id_A2FE[var_5]._id_3102 = 1;
    var_14 = "cp_" + var_3;

    if(istrue(var_9)) {
      var_2 thread scripts\cp\cp_hud_message::showsplash(var_14, undefined, self);
    }

    var_9 = 1;
    var_2 waittill(var_0);
    var_2._id_A2FE[var_5]._id_3D09 = undefined;
    var_2._id_A2FE[var_5]._id_3102 = 0;
    var_2._id_A2FE[var_5]._id_E06D = undefined;
  }
}

_id_C40B(var_0, var_1) {
  for(var_2 = 0; var_2 < self._id_A2FE.size; var_2++) {
    if(isDefined(self._id_A301[var_2]) && self._id_A301[var_2]._id_C189 == var_1) {
      if(var_2 == var_0) {
        self setclientomnvar("cp_munition_slot_reset", var_2);
      }

      self._id_A301[var_2] = undefined;
      break;
    }
  }
}

_id_3107(var_0) {
  if(self._id_A2FE[var_0]._id_C189 == "juggernaut" && istrue(self._id_88DF)) {
    return 0;
  }

  if(self._id_A2FE[var_0]._id_C189 == "ac130" && istrue(level._id_731B)) {
    return 0;
  }

  if(istrue(self._id_A2FE[var_0]._id_3102)) {
    return 1;
  }

  return 0;
}

_id_C40A(var_0, var_1) {
  _id_C40B(var_0, var_1);
  var_2 = "none";

  if(var_0 == 0) {
    var_2 = "empty1";
  } else if(var_0 == 1) {
    var_2 = "empty2";
  } else if(var_0 == 2) {
    var_2 = "empty3";
  }

  _id_6F15(var_2, var_0);
  var_3 = "cp_munition_1_timer";

  switch (var_0) {
    case 0:
      var_3 = "cp_munition_1_timer";
      break;
    case 1:
      var_3 = "cp_munition_2_timer";
      break;
    case 2:
      var_3 = "cp_munition_3_timer";
      break;
    case 3:
      var_3 = "cp_munition_4_timer";
      break;
  }

  self setclientomnvar(var_3, 0);
  _id_3453();
  _id_1D01();
}

_id_3453() {
  var_0 = 0;
  var_1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(isDefined(self._id_A2FE) && isDefined(self._id_A2FE[var_2])) {
      if(!_id_0780::_id_85B4(var_2)) {
        var_0 = var_0 + 1;
      }
    }
  }

  self._id_A2FF = var_0;
  self setclientomnvar("cp_munition_slots_full", var_0);
}

_id_1D01() {
  var_0 = 0;

  for(var_1 = self._id_A2FE.size - 1; var_1 > -1; var_1--) {
    if(!_id_0780::_id_85B4(var_1)) {
      self._id_4EC2 = var_1;
      break;
    } else
      var_0 = var_0 + 1;
  }

  if(var_0 == self._id_A2FE.size) {
    self._id_4EC2 = 0;
  }

  _id_FB84(self._id_4EC2);
}

_id_1D04() {
  var_0 = 0;

  for(var_1 = 0; var_1 < self._id_A2FE.size; var_1++) {
    if(!_id_0780::_id_85B4(var_1)) {
      self._id_4EC2 = var_1;
      break;
    } else
      var_0 = var_0 + 1;
  }

  if(var_0 == self._id_A2FE.size) {
    self._id_4EC2 = 0;
  }

  _id_FB84(self._id_4EC2);
}

_id_7503(var_0) {
  foreach(var_2 in self._id_A2FE) {
    if(var_2._id_C189 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_6F15(var_0, var_1, var_2) {
  var_3 = _id_FBDE(var_1);
  var_4 = self;

  if(!isDefined(var_1)) {
    var_1 = var_3 - 1;
  }

  if(!isDefined(self._id_A2FE) || !isDefined(self._id_A2FE[var_1])) {
    self._id_A2FE[var_1] = spawnStruct();
  }

  self._id_A2FE[var_1]._id_C189 = var_0;
  self._id_A2FE[var_1]._id_3D06 = level._id_A302[self._id_A2FE[var_1]._id_C189]._id_3D06;
  self._id_A2FE[var_1]._id_3102 = 1;
  self._id_A2FE[var_1]._id_3D09 = 1;

  if(isDefined(var_2)) {
    self._id_A2FE[var_1]._id_E06D = var_2;
  }

  if(var_0 == "none") {
    if(isDefined(self._id_A2FE[var_1]._id_E06D)) {
      self._id_A2FE[var_1]._id_E06D = undefined;
    }
  }

  var_3 = self getplayerdata("cp", "inventorySlots", "totalSlots");
  var_5 = undefined;
  var_6 = var_4 _id_3457(var_0);

  if(!istrue(self._id_A300)) {
    var_6 = "cp_" + var_6;
  }

  var_4 thread scripts\cp\cp_hud_message::showsplash(var_6, undefined, self);

  switch (var_1) {
    case 0:
      var_5 = "cp_munition_slot_1";
      var_4 thread _id_3D07("munition_1_used", "cp_munition_1_timer", var_4, var_4._id_A2FE[0]._id_C189, var_4._id_A2FE[0]._id_3D06, 0, 1);
      break;
    case 1:
      var_5 = "cp_munition_slot_2";
      var_4 thread _id_3D07("munition_2_used", "cp_munition_2_timer", var_4, var_4._id_A2FE[1]._id_C189, var_4._id_A2FE[1]._id_3D06, 1, 1);
      break;
    case 2:
      var_5 = "cp_munition_slot_3";
      var_4 thread _id_3D07("munition_3_used", "cp_munition_3_timer", var_4, var_4._id_A2FE[2]._id_C189, var_4._id_A2FE[2]._id_3D06, 2, 1);
      break;
    case 3:
      var_5 = "cp_munition_slot_4";
      var_4 thread _id_3D07("munition_4_used", "cp_munition_4_timer", var_4, var_4._id_A2FE[3]._id_C189, var_4._id_A2FE[3]._id_3D06, 3, 1);
      break;
  }

  var_7 = level._id_A302[var_4._id_A2FE[var_1]._id_C189].index;

  if(isDefined(var_5) && isDefined(var_7)) {
    var_4 setclientomnvar(var_5, var_7);
  }

  if(isDefined(var_4._id_A2FF) && var_4._id_A2FF == 0) {
    var_4 _id_3453();
  }
}

_id_FBDE(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  var_1 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(var_0 >= var_1 && var_1 < 3) {
    var_1 = var_1 + 1;
  }

  self setplayerdata("cp", "inventorySlots", "totalSlots", var_1);
  return var_1;
}

_id_3457(var_0) {
  var_1 = self;

  if(var_0 == "grenade_launcher" && isDefined(var_1._id_700E)) {
    return var_1._id_700E + "_proj";
  }

  return var_0;
}

_id_3F49(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1._id_0481 = "interaction";
  var_1._id_039B = "loadout_change_interaction";
  var_1._id_C588 = 0;
  var_1._id_E3FF = "null";
  var_1._id_3D91 = 0;
  var_1._id_2028 = 1;
  _id_0737::_id_1037(var_1);
}

_id_3ECA() {
  wait 50;
  var_0 = scripts\engine\utility::getstructarray("loadout_change_struct", "script_noteworthy");
  level._id_EA6E = [];

  foreach(var_2 in var_0) {
    var_2._id_2028 = 1;
    var_2._id_A461 = gettime() + 50000;
    var_2.team = "allies";
    var_2.model = spawn("script_model", var_2.origin);
    var_2.model setModel(var_2._id_CDC1);

    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_2.model.angles = var_2.angles;
    level._id_EA6E = scripts\engine\utility::array_add(level._id_EA6E, var_2);
    var_2 thread _id_C9AA();
  }
}

_id_C9AA() {
  for(;;) {
    if(gettime() > self._id_A461) {
      _id_E0B5(self);
    }

    waitframe();
  }
}

_id_E0B5(var_0) {
  if(!istrue(var_0._id_2028)) {
    var_0._id_A461 = gettime() + 50000;
    return;
  }

  var_0._id_2028 = 0;
  var_1 = _func_02A9(var_0.origin, 128);
  var_0 waittill("change_loadout_timer");
  var_0._id_A461 = gettime() + 50000;
  var_0._id_2028 = 1;
}

_id_3F4A() {
  _id_0737::_id_C1EE("loadout_change_interaction", "null", undefined, ::_id_961C, ::_id_961B, 0, 0, undefined);
  var_0 = scripts\engine\utility::getstructarray("loadout_change_struct", "script_noteworthy");

  foreach(var_2 in var_0) {
    _id_3F49(var_2);
  }
}

_id_961C(var_0, var_1) {
  return &"COOP_CRAFTING/PICKUP_LOADOUT_CHANGE";
}

_id_961B(var_0, var_1) {
  var_1 endon("disconnect");
}

_id_C40D(var_0, var_1, var_2) {
  var_3 = var_1 * var_1;
  var_4 = 20;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  var_5 = ["brloot_munition", "brloot_munition_airdrop", "brloot_munition_ammo", "brloot_munition_armor", "brloot_munition_c4_launcher", "brloot_munition_cluster_strike", "brloot_munition_cruise_missile", "brloot_munition_cruise_predator", "brloot_munition_deployable_cover", "brloot_munition_grenade_crate", "brloot_munition_grenade_launcher", "brloot_munition_juggernaut", "brloot_munition_precision_airstrike", "brloot_munition_thermite_launcher", "brloot_munition_trophysystem", "brloot_munition_turret", "brloot_munition_uav", "brloot_munition_white_phos"];

  foreach(var_7 in var_5) {
    var_8 = _func_03C0(undefined, undefined, var_0, var_1, var_7);
    var_9 = 0;

    foreach(var_11 in var_8) {
      var_11 setscriptablepartstate(var_7, "hidden");
      var_9++;

      if(var_9 % var_4) {
        wait 0.1;
      }
    }

    wait 0.1;
  }
}