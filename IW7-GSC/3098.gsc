/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3098.gsc
**************************************/

_id_25C5() {
  if(!isDefined(self.audio)) {
    self.audio = spawnStruct();
  }
}

_id_A3B3(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.spaceship_mode;
  }

  _id_A3B6(var_0, 0);
}

_id_A3B6(var_0, var_1) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self._id_615D) && self._id_615D._id_619D) {
    return;
  }
  if(isDefined(self.audio.state) && self.audio.state == var_0) {
    return;
  }
  if(isDefined(self.audio._id_552E)) {
    self thread[[self.audio._id_552E]]();
  }

  self.audio._id_552E = undefined;

  switch (var_0) {
    case "hover":
      _id_2396(var_1);
      break;
    case "fly":
      _id_11130(var_1);
      break;
    case "fly_glide":
      _id_11134(var_1);
      break;
    case "hover_glide":
      _id_11134(var_1);
      break;
    case "reentry":
      _id_11134(var_1);
      break;
    case "launch_mode":
      _id_AA5D(var_1);
      break;
    case "boost_mode":
      _id_2CAB(var_1);
      break;
    case "landed_mode":
      _id_A7CA(var_1);
      break;
    default:
  }

  self.audio.state = var_0;
}

_id_2396(var_0) {
  if(soundexists("jackal_tread_sfx_lp")) {
    if(!isDefined(self._id_A381)) {
      thread _id_A381();
    }
  }

  if(!isDefined(self._id_23A5)) {
    self.audio._id_23A5 = _id_31C0();
    self.audio._id_23A5 thread scripts\sp\utility::_id_10461(_id_0BDC::_id_7A5B("jackal_hover_world"), 1, var_0, 1);
    self.audio._id_552E = ::_id_2395;
  }
}

_id_2395() {
  var_0 = 1;
  var_1 = self.audio._id_23A5;
  var_1 _meth_8278(0, var_0);
  wait(var_0);
  _id_DFD8([var_1]);
}

_id_11130(var_0) {
  if(!isDefined(self.audio._id_1113C)) {
    self.audio._id_1113C = _id_31C0();
    var_1 = self.script_team;

    if(var_1 == "axis") {
      self.audio._id_1113C thread scripts\sp\utility::_id_10461(_id_0BDC::_id_7A5B("jackal_sdf_thrust_world"), 1, var_0, 1);
    } else {
      self.audio._id_1113C thread scripts\sp\utility::_id_10461(_id_0BDC::_id_7A5B("jackal_thrust_world"), 1, var_0, 1);
    }

    self.audio._id_1113C thread scripts\sp\utility::_id_10461(_id_0BDC::_id_7A5B("jackal_thrust_world"), 1, var_0, 1);
    thread _id_A1D5("jackal_flyby", undefined, 1);
    self.audio._id_552E = ::_id_1112F;
  }
}

_id_11134(var_0) {
  self.audio._id_552E = ::_id_11133;
}

_id_239D(var_0) {
  self.audio._id_552E = ::_id_239C;
}

_id_11133() {}

_id_239C() {}

_id_AA5D(var_0) {
  self.audio._id_552E = ::_id_AA5C;
}

_id_AA5C() {}

_id_2CAB(var_0) {
  if(!isDefined(self.audio._id_2CB5)) {
    self.audio._id_2CB5 = _id_31C0();
    self.audio._id_2CB5 thread scripts\sp\utility::_id_10461(_id_0BDC::_id_7A5B("jackal_npc_boost_lp"), 1, var_0, 1);
    playworldsound(_id_0BDC::_id_7A5B("jackal_npc_boost_init"), self.origin);
    self.audio._id_552E = ::_id_2CAA;
  }
}

_id_2CAA() {}

_id_A7CA(var_0) {
  self.audio._id_552E = ::_id_A7C9;
}

_id_A7C9() {}

_id_1112F() {
  var_0 = 1;
  self notify("notify_stop_thrust_audio");
  var_1 = self.audio._id_1113C;
  var_1 _meth_8278(0, var_0);
  wait(var_0);
  _id_DFD8([var_1]);
}

_id_31C0() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self._id_4074[self._id_4074.size] = var_0;
  return var_0;
}

_id_DFD8(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      self._id_4074 = scripts\engine\utility::array_remove(self._id_4074, var_2);
      var_2 delete();
    }
  }
}

_id_A1D5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  self endon("notify_stop_thrust_audio");
  self endon("terminate_ai_threads");
  var_8 = [];
  var_8[0] = 3000;
  var_8[1] = 6000;
  var_8[2] = 10000;
  var_9 = [];
  var_9[0] = 320;
  var_9[1] = 230;
  self _meth_83E8();
  self.audio._id_D889 = _id_A16A(var_2);
  self.audio._id_7008 = 0;
  self.audio._id_7007 = 0;
  self.audio._id_4E1F = 0;
  self.audio._id_20EF = 1;

  if(isDefined(var_3)) {
    thread _id_A13F(var_3);
  }

  if(isDefined(var_4)) {
    var_10 = spawn("script_origin", self.origin);
    var_10 linkTo(self);
    self._id_4074[self._id_4074.size] = var_10;
    thread _id_A1D3(var_10, var_4);
  }

  self.audio._id_B746 = 2;

  if(isDefined(var_5)) {
    self.audio._id_B746 = var_5;
  }

  self.audio._id_B745 = 2;

  if(isDefined(var_6)) {
    self.audio._id_B745 = var_6;
  }

  var_11 = 0.05;

  if(isDefined(var_7)) {
    var_11 = var_7;
  }

  if(isarray(var_1)) {
    foreach(var_14, var_13 in var_1) {
      thread _id_A1D7(var_14, var_13);
    }
  }

  if(isarray(var_8)) {
    while(isDefined(self)) {
      var_15 = _id_A16A(var_2);

      for(var_16 = 0; var_16 < var_8.size; var_16++) {
        if(var_15 < var_8[var_16]) {
          if(var_16 == 0) {
            if(self.audio._id_20EF && self.audio._id_7008 == 0 && self.audio._id_4E1F == 0) {
              var_17 = _id_A1D1(var_0, var_16, var_9);

              if(isDefined(var_17)) {
                thread _id_A1D4(var_17, var_16);
              }
            } else if(var_15 < self.audio._id_D889)
              self.audio._id_20EF = 1;
            else {
              self.audio._id_20EF = 0;
            }
          } else if(var_15 > self.audio._id_D889) {
            if(self.audio._id_20EF && self.audio._id_7008 == 0 && self.audio._id_7007 == 0 && self.audio._id_4E1F == 0) {
              self.audio._id_20EF = 0;
              var_17 = _id_A1D1(var_0, var_16, var_9);

              if(isDefined(var_17)) {
                thread _id_A1D4(var_17, var_16);
              }
            }
          } else if(var_15 < 3500) {
            if(self.audio._id_7008 == 0 && self.audio._id_7007 == 0 && self.audio._id_4E1F == 0) {
              var_17 = _id_A1D1(var_0, var_16, var_9);

              if(isDefined(var_17)) {
                thread _id_A1D4(var_17, var_16);
              }
            }
          } else
            self.audio._id_20EF = 1;

          break;
        }
      }

      self.audio._id_D889 = var_15;
      wait(var_11);
    }
  }
}

_id_A1D7(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  wait(var_1);
  thread _id_A1D4(var_0);
}

_id_A16A(var_0) {
  var_1 = _id_7BA7();
  var_2 = 0;

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(var_2) {
    var_3 = distance(self.origin, var_1);
  } else {
    var_3 = distance2d(self.origin, var_1);
  }

  return var_3;
}

_id_A1D1(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = self vehicle_getvelocity();
  var_5 = length(var_4) * 0.0568182;

  if(var_5 > 125) {
    if(isarray(var_2)) {
      if(scripts\engine\utility::player_is_in_jackal()) {
        var_6 = level._id_D127.spaceship_vel * 17.6;
      } else {
        var_6 = level.player getvelocity();
      }

      var_7 = var_4 - var_6;
      var_8 = length(var_7) * 0.0568182;

      if(var_8 < 125) {
        return undefined;
      }

      for(var_9 = 0; var_9 < var_2.size; var_9++) {
        var_3 = var_9 + 1;

        if(var_8 > var_2[var_9]) {
          var_3 = var_9;
          break;
        }
      }
    }

    if(var_3 == 0) {
      var_10 = "fast";
    } else if(var_3 == 1) {
      var_10 = "med";
    } else {
      var_10 = "slow";
    }

    if(var_1 == 0) {
      var_11 = "close";
    } else if(var_1 == 1) {
      var_11 = "mid";
    } else if(var_1 == 2) {
      var_11 = "far";
    } else {
      return undefined;
    }

    var_12 = self.script_team;

    if(var_12 == "axis") {
      var_0 = var_0 + "_sdf";
    }

    if(scripts\engine\utility::player_is_in_jackal()) {
      var_13 = var_0 + "_" + var_10 + "_" + var_11;
    } else {
      var_13 = var_0 + "_" + var_10 + "_" + var_11 + "_grnd";
    }

    if(var_1 == 0) {
      self.audio._id_7008 = 1;
    } else {
      self.audio._id_7007 = 1;
    }

    return var_13;
  } else
    return undefined;
}

_id_A1D4(var_0, var_1) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  thread _id_A331(var_1);
  self.audio._id_1113C _meth_8278(0.4, 1);
  self playSound(var_0);
  wait 1;

  if(isDefined(self.audio._id_1113C)) {
    self.audio._id_1113C _meth_8278(1, 5);
  }
}

_id_A13F(var_0) {
  self endon("crash_done");
  self waittill("deathspin");
  self playSound(var_0);
}

_id_A1D3(var_0, var_1) {
  self waittill("crash_done");
  var_0 playSound(var_1, "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

_id_A331(var_0) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  self endon("notify_stop_thrust_audio");

  if(isDefined(var_0)) {
    if(var_0 == 0) {
      wait(self.audio._id_B746);

      if(isDefined(self)) {
        self.audio._id_7008 = 0;
      }
    } else {
      wait(self.audio._id_B745);

      if(isDefined(self)) {
        self.audio._id_7007 = 0;
      }
    }
  }
}

_id_A381() {
  self endon("death");
  self endon("entitydeleted");
  thread _id_A380();
  var_0 = 0.3;
  var_1 = 0.3;
  var_2 = 500;

  for(;;) {
    var_3 = (0, 0, -100000);
    var_4 = scripts\sp\utility::_id_864C(self.origin);
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2) {
      if(isDefined(self) && !isDefined(self._id_A381)) {
        self._id_A381 = spawn("script_origin", var_4);
        wait 0.05;

        if(isDefined(self) && isDefined(self._id_A381)) {
          self._id_A381 scripts\sp\utility::_id_10461("jackal_tread_sfx_lp", var_0, 1, 1);
        }

        wait 1;
      }

      if(isDefined(self) && isDefined(self._id_A381)) {
        var_4 = scripts\sp\utility::_id_864C(self.origin);
        var_5 = distance(self.origin, var_4);
        var_1 = (var_5 - var_2) / (0 - var_2);

        if(var_1 < var_0) {
          var_1 = var_0;
        }

        self._id_A381 _meth_8278(var_1, 0.1);
        self._id_A381 moveTo(var_4, 0.1);
        wait 0.2;
      }
    } else if(var_5 > var_2) {
      if(isDefined(self) && isDefined(self._id_A381)) {
        self._id_A381 _meth_8278(0, 2);
        wait 2;

        if(isDefined(self) && isDefined(self._id_A381)) {
          self._id_A381 delete();
        }
      }
    }

    wait 0.2;
  }
}

_id_A380() {
  self waittill("death");

  if(isDefined(self._id_A381)) {
    self._id_A381 delete();
  }
}

_id_A1D0(var_0, var_1, var_2) {
  self waittill(var_1);

  if(isDefined(var_0)) {
    var_3 = 0.3;

    if(isDefined(var_2)) {
      var_3 = var_2;
    }

    var_0 _meth_8278(0.0, var_3);
    wait(var_3);

    if(isDefined(var_0)) {
      var_0 stopsounds();
      wait 0.1;

      if(isDefined(var_0)) {
        var_0 delete();
      }
    }
  }
}

_id_7BA7() {
  if(scripts\engine\utility::player_is_in_jackal()) {
    return level._id_D127.origin;
  } else {
    return level.player.origin;
  }
}