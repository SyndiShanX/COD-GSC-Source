/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\68.gsc
**************************************/

init() {
  if(!isDefined(level._id_11B6)) {
    level._id_11B6 = [];
  }
  if(!isDefined(level._id_11B7)) {
    level._id_11B7 = [];
  }
  if(!isDefined(level._id_11B8)) {
    level._id_11B8 = [];
  }
  if(!isDefined(level._id_11B9)) {
    level._id_11B9 = [];
  }
  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }
  if(!isDefined(level._id_11BB)) {
    level._id_11BB = [];
  }
  if(!isDefined(level._id_11BC)) {
    level._id_11BC = [];
  }
  if(!isDefined(level._id_0C59)) {
    level._id_0C59[0][0] = 0;
  }
  if(!isDefined(level._id_11BB)) {
    level._id_11BB = [];
  }
}

_id_11BD(var_0, var_1) {
  self waittill(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_3["guy"];

    if(!isDefined(var_4)) {
      continue;
    }
    var_4._id_0BA3--;
    var_4._id_11BE = gettime();
  }
}

_id_11BF(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  common_scripts\utility::array_levelthread(var_0, ::_id_11D2, var_1, var_4, var_5);
}

_id_11C0(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  thread _id_11D2(var_0, var_1, var_4, var_5, "generic");
}

_id_11C1(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_11DD(var_3, var_1, var_2, 0, "generic");
}

_id_11C2(var_0, var_1, var_2) {
  var_3 = var_0.allowpain;
  var_0 maps\_utility::_id_1057();
  _id_11CC(var_0, "gravity", var_1, var_2);

  if(var_3) {
    var_0 maps\_utility::_id_1071();
  }
}

_id_11C3(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_11DD(var_3, var_1, var_2, 0.25, "generic");
}

_id_11C4(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_122A(var_3, var_1, var_2, "generic");
}

_id_11C5(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_122B(var_3, var_1, var_2, "generic", ::_id_1241, ::_id_123E);
}

_id_11C6(var_0, var_1, var_2) {
  _id_122B(var_0, var_1, var_2, undefined, ::_id_1242, ::_id_123E);
}

_id_11C7(var_0, var_1, var_2) {
  _id_122B(var_0, var_1, var_2, undefined, ::_id_1243, ::_id_123E);
}

_id_11C8(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["guy"] = var_0;
  var_4["entity"] = self;
  var_4["tag"] = var_3;
  var_5[0] = var_4;
  _id_11D8(var_5, var_1, var_2, "generic");
}

_id_11C9(var_0, var_1, var_2, var_3) {
  var_4 = _id_1202(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = undefined;

  foreach(var_9 in var_0) {
    var_7 = var_9;
    thread _id_11D4(var_9, var_1, var_2, var_5, var_6, var_9._id_1032, 0);
  }

  var_7 _id_11CB(var_2);
  self notify(var_2);
}

_id_11CA(var_0, var_1, var_2, var_3) {
  var_4 = _id_1202(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];

  foreach(var_8 in var_0) {}
  thread _id_11D4(var_8, var_1, var_2, var_5, var_6, var_8._id_1032, 1);

  var_0[0] _id_11CB(var_2);
  self notify(var_2);
}

_id_11CB(var_0) {
  self endon("finished_custom_animmode" + var_0);
  self waittill("death");
}

_id_11CC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_1202(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread _id_11D4(var_0, var_1, var_2, var_7, var_8, "generic", 0, var_4, var_5);
  var_0 _id_11CB(var_2);
  self notify(var_2);
}

_id_11CD(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_1202(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread _id_11D4(var_0, var_1, var_2, var_7, var_8, "generic", 1, var_4, var_5);
  var_0 _id_11CB(var_2);
  self notify(var_2);
}

_id_11CE(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  _id_11C9(var_4, var_1, var_2, var_3);
}

_id_11CF(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_11BF(var_3, var_1, var_2);
}

_id_11D0(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_11BF(var_3, var_1, var_2);
  _id_127F(var_3, var_1, 1.0);
}

_id_11D1(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_1032;
  }
  var_2 = 0;

  if(isDefined(level._id_0C59[var_1])) {
    var_2 = 1;

    if(isDefined(level._id_0C59[var_1][var_0])) {
      return;
    }
  }

  var_3 = 0;

  if(isDefined(level.scr_sound[var_1])) {
    var_3 = 1;

    if(isDefined(level.scr_sound[var_1][var_0])) {
      return;
    }
  }

  if(var_2 || var_3) {
    if(var_2) {
      var_4 = getarraykeys(level._id_0C59[var_1]);

      foreach(var_6 in var_4) {}
    }

    if(var_3) {
      var_4 = getarraykeys(level.scr_sound[var_1]);

      foreach(var_6 in var_4) {}
    }

    return;
  }

  var_10 = getarraykeys(level._id_0C59);
  var_10 = common_scripts\utility::array_combine(var_10, getarraykeys(level.scr_sound));

  foreach(var_12 in var_10) {}
}

_id_11D2(var_0, var_1, var_2, var_3, var_4) {
  var_0._id_11D3 = gettime();

  if(isDefined(var_4)) {
    var_5 = var_4;
  } else {
    var_5 = var_0._id_1032;
  }
  var_0 _id_1275(var_1, var_2, var_3, var_5);

  if(isai(var_0)) {
    var_0._id_0C57 = var_1;
    var_0._id_0C58 = var_5;
    var_0 animcustom(animscripts\first_frame::main);
  } else {
    var_0 stopanimscripted();
    var_0 setanimknob(level._id_0C59[var_5][var_1], 1, 0, 0);
  }
}

_id_11D4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isai(var_0) && var_0 maps\_utility::_id_0D69()) {
    return;
  }
  var_9 = undefined;

  if(isDefined(var_5)) {
    var_9 = var_5;
  } else {
    var_9 = var_0._id_1032;
  }
  if(!isDefined(var_8) || !var_8) {
    var_0 _id_1275(var_2, var_3, var_4, var_5, var_6);
  }
  var_0._id_0C60 = var_1;
  var_0._id_11D5 = var_2;
  var_0._id_0C5B = self;
  var_0._id_0C5A = var_2;
  var_0._id_0C58 = var_9;
  var_0._id_0C5D = var_6;
  var_0._id_0C5C = var_7;
  var_0 animcustom(animscripts\animmode::main);
}

_id_11D6(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = [];
    var_7["guy"] = var_6;
    var_7["entity"] = self;
    var_7["tag"] = var_3;
    var_4[var_4.size] = var_7;
  }

  _id_11D8(var_4, var_1, var_2);
}

_id_11D7(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  _id_11D8(var_3, var_1, var_2);
}

_id_11D8(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5["guy"];

    if(!isDefined(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_0BA3)) {
      var_6._id_0BA3 = 0;
    }
    var_6 endon("death");
    var_6._id_0BA3++;
  }

  var_8 = var_0[0]["guy"];

  if(!isDefined(var_2)) {
    var_2 = "stop_loop";
  }
  thread _id_11BD(var_2, var_0);
  self endon(var_2);
  var_9 = "looping anim";
  var_10 = undefined;

  if(isDefined(var_3)) {
    var_10 = var_3;
  } else {
    var_10 = var_8._id_1032;
  }
  var_11 = 0;
  var_12 = 0;

  for(;;) {
    for(var_11 = _id_11FD(var_10, var_1); var_11 == var_12 && var_11 != 0; var_11 = _id_11FD(var_10, var_1)) {}

    var_12 = var_11;
    var_13 = undefined;
    var_14 = 999999;
    var_15 = undefined;
    var_6 = undefined;

    foreach(var_29, var_5 in var_0) {
      var_17 = var_5["entity"];
      var_6 = var_5["guy"];
      var_18 = var_17 _id_1202(var_5["tag"]);
      var_19 = var_18["origin"];
      var_20 = var_18["angles"];

      if(isDefined(var_6._id_11D9)) {
        var_6._id_11D9 = undefined;
        var_0[var_29] = undefined;
        continue;
      }

      var_21 = 0;
      var_22 = 0;
      var_23 = 0;
      var_24 = 0;
      var_25 = undefined;
      var_26 = undefined;
      var_27 = undefined;

      if(isDefined(var_3)) {
        var_27 = var_3;
      } else {
        var_27 = var_6._id_1032;
      }
      if(isDefined(level._id_11B7[var_27]) && isDefined(level._id_11B7[var_27][var_1]) && isDefined(level._id_11B7[var_27][var_1][var_11])) {
        var_21 = 1;
        var_25 = level._id_11B7[var_27][var_1][var_11];
      }

      if(isDefined(level.scr_sound[var_27]) && isDefined(level.scr_sound[var_27][var_1]) && isDefined(level.scr_sound[var_27][var_1][var_11])) {
        var_22 = 1;
        var_26 = level.scr_sound[var_27][var_1][var_11];
      }

      if(isDefined(level._id_11B9[var_27]) && isDefined(level._id_11B9[var_27][var_11 + var_1])) {
        var_6 playSound(level._id_11B9[var_27][var_11 + var_1]);
      }
      if(isDefined(level._id_0C59[var_27]) && isDefined(level._id_0C59[var_27][var_1]) && (!isai(var_6) || !var_6 maps\_utility::_id_0D69())) {
        var_23 = 1;
      }
      if(var_23) {
        var_6 _id_1282();
        var_6 animscripted(var_9, var_19, var_20, level._id_0C59[var_27][var_1][var_11]);
        var_28 = getanimlength(level._id_0C59[var_27][var_1][var_11]);

        if(var_28 < var_14) {
          var_14 = var_28;
          var_13 = var_29;
        }

        thread _id_0C61(var_6, var_9, var_1, var_27);
        thread _id_0C62(var_6, var_9, var_1);
      }

      if(var_21 || var_22) {
        if(isai(var_6)) {
          if(var_23) {
            var_6 animscripts\face::_id_0C46(var_25, var_26, 1.0);
          } else {
            var_6 animscripts\face::_id_0C46(var_25, var_26, 1.0, var_9);
          }
        } else {
          var_6 maps\_utility::play_sound_on_entity(var_26);
        }
        var_15 = var_29;
      }
    }

    if(!isDefined(var_6)) {
      break;
    }

    if(isDefined(var_13)) {
      var_0[var_13]["guy"] waittillmatch(var_9, "end");
      continue;
    }

    if(isDefined(var_15)) {
      var_0[var_15]["guy"] waittill(var_9);
    }
  }
}

_id_0C61(var_0, var_1, var_2, var_3) {
  var_0 notify("stop_sequencing_notetracks");
  thread _id_11F0(var_0, var_1, self, var_2, var_3);
}

_id_11DB(var_0, var_1) {}

_id_11DC(var_0, var_1) {
  foreach(var_3 in var_0) {}
  var_3 thread _id_11DB(self, var_1);
}

_id_11DD(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  _id_11DF(var_0, var_1, var_2, var_3, var_4);
}

_id_11DE(var_0, var_1, var_2, var_3) {
  _id_11DF(var_0, var_1, var_2, 0.25, var_3);
}

_id_11DF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(!isDefined(var_7._id_0BA3)) {
      var_7._id_0BA3 = 0;
    }
    var_7._id_0BA3++;
  }

  var_9 = _id_1202(var_2);
  var_10 = var_9["origin"];
  var_11 = var_9["angles"];
  var_12 = undefined;
  var_13 = 999999;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = "single anim";

  foreach(var_29, var_7 in var_0) {
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
    var_23 = undefined;
    var_24 = undefined;
    var_25 = undefined;

    if(isDefined(var_4)) {
      var_25 = var_4;
    } else {
      var_25 = var_7._id_1032;
    }
    if(isDefined(level._id_11B7[var_25]) && isDefined(level._id_11B7[var_25][var_1])) {
      var_19 = 1;
      var_24 = level._id_11B7[var_25][var_1];
      var_16 = var_24;
    }

    if(isDefined(level.scr_sound[var_25]) && isDefined(level.scr_sound[var_25][var_1])) {
      var_20 = 1;
      var_23 = level.scr_sound[var_25][var_1];
    }

    if(isDefined(level._id_0C59[var_25]) && isDefined(level._id_0C59[var_25][var_1]) && (!isai(var_7) || !var_7 maps\_utility::_id_0D69())) {
      var_21 = 1;
    }
    if(isDefined(level._id_11B9[var_25]) && isDefined(level._id_11B9[var_25][var_1])) {
      var_7 playSound(level._id_11B9[var_25][var_1]);
    }
    if(var_21) {
      var_7 _id_1282();

      if(isPlayer(var_7)) {
        var_26 = level._id_0C59[var_25]["root"];
        var_7 setanim(var_26, 0, 0.2);
        var_27 = level._id_0C59[var_25][var_1];
        var_7 setflaggedanim(var_17, var_27, 1, 0.2);
      } else if(var_7.code_classname == "misc_turret") {
        var_27 = level._id_0C59[var_25][var_1];
        var_7 setflaggedanim(var_17, var_27, 1, 0.2);
      } else {
        var_7 animscripted(var_17, var_10, var_11, level._id_0C59[var_25][var_1]);
      }
      var_28 = getanimlength(level._id_0C59[var_25][var_1]);

      if(var_28 < var_13) {
        var_13 = var_28;
        var_12 = var_29;
      }

      thread _id_0C61(var_7, var_17, var_1, var_25);
      thread _id_0C62(var_7, var_17, var_1);
    }

    if(var_19 || var_20) {
      if(var_19) {
        if(var_20) {
          var_7 thread _id_1271(var_1, var_19, var_23, level._id_11B7[var_25][var_1]);
        }
        thread _id_1269(var_7, var_1, level._id_11B7[var_25][var_1]);
        var_15 = var_29;
      } else if(isai(var_7)) {
        if(var_21) {
          var_7 animscripts\face::_id_0C46(var_24, var_23, 1.0);
        } else {
          var_7 thread _id_0BDB("single dialogue");
          var_7 animscripts\face::_id_0C46(var_24, var_23, 1.0, "single dialogue");
        }
      } else {
        var_7 thread maps\_utility::play_sound_on_entity(var_23, "single dialogue");
      }
      var_14 = var_29;
    }
  }

  if(isDefined(var_12)) {
    var_30 = spawnStruct();
    var_30 thread _id_11E0(var_0[var_12], var_1);
    var_30 thread _id_11E3(var_0[var_12], var_1, var_13, var_3);
    var_30 waittill(var_1);
  } else if(isDefined(var_15)) {
    var_30 = spawnStruct();
    var_30 thread _id_11E0(var_0[var_15], var_1);
    var_30 thread _id_11E1(var_0[var_15], var_1, var_16);
    var_30 waittill(var_1);
  } else if(isDefined(var_14)) {
    var_30 = spawnStruct();
    var_30 thread _id_11E0(var_0[var_14], var_1);
    var_30 thread _id_11E2(var_0[var_14], var_1);
    var_30 waittill(var_1);
  }

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(isPlayer(var_7)) {
      var_25 = undefined;

      if(isDefined(var_4)) {
        var_25 = var_4;
      } else {
        var_25 = var_7._id_1032;
      }
      if(isDefined(level._id_0C59[var_25][var_1])) {
        var_26 = level._id_0C59[var_25]["root"];
        var_7 setanim(var_26, 1, 0.2);
        var_27 = level._id_0C59[var_25][var_1];
        var_7 clearanim(var_27, 0.2);
      }
    }

    var_7._id_0BA3--;
    var_7._id_11BE = gettime();
  }

  self notify(var_1);
}

_id_11E0(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("death");
  self notify(var_1);
}

_id_11E1(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1);
}

_id_11E2(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("single dialogue");
  self notify(var_1);
}

_id_11E3(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  var_0 endon("death");
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 maps\_utility::_id_11E4("single anim", "end", var_2);
    var_0 stopanimscripted();
  } else {
    var_0 waittillmatch("single anim", "end");
  }
  self notify(var_1);
}

_id_0C62(var_0, var_1, var_2) {
  if(isDefined(var_0._id_11E5) && var_0._id_11E5) {
    return;
  }
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");
  var_0 animscripts\shared::_id_0C51(var_1);
}

_id_11E6(var_0) {
  for(var_1 = 0; var_1 < level._id_11E7; var_1++) {
    if(isDefined(self._id_11E8[var_1])) {
      continue;
    }
    self._id_11E8[var_1] = var_0;
    return;
  }

  var_2 = getarraykeys(self._id_11E8);
  var_3 = var_2[0];
  var_4 = self._id_11E8[var_3]._id_11E9;

  for(var_1 = 1; var_1 < var_2.size; var_1++) {
    var_5 = var_2[var_1];

    if(self._id_11E8[var_5]._id_11E9 < var_4) {
      var_4 = self._id_11E8[var_5]._id_11E9;
      var_3 = var_5;
    }
  }

  self._id_11E8[var_3] = var_0;
}

_id_11EA(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = getarraykeys(self._id_11E8);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self._id_11E8[var_4]._id_11EB != var_0) {
      continue;
    }
    if(self._id_11E8[var_4]._id_11EC != var_1) {
      continue;
    }
    self._id_11E8[var_4]._id_11E9 = gettime() + 60000;
    return 1;
  }

  return 0;
}

_id_11ED(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_127A();

  if(var_1 == "end") {
    return;
  }
  if(_id_11EA(var_0, var_1)) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_11EB = var_0;
  var_3._id_11EC = var_1;
  var_3._id_1032 = var_2;
  var_3._id_11E9 = gettime() + 60000;
  _id_11E6(var_3);
}

_id_11EE(var_0, var_1) {
  _id_127A();
  var_2 = spawnStruct();
  var_2._id_11EB = var_0;
  var_2._id_11EC = "#" + var_0;
  var_2._id_1032 = var_1;
  var_2._id_11E9 = gettime() + 60000;

  if(_id_11EA(var_0, var_2._id_11EC)) {
    return;
  }
  _id_11E6(var_2);
}

_id_11EF(var_0, var_1, var_2) {
  _id_127A();
  var_0 = var_1 + var_0;
  var_3 = spawnStruct();
  var_3._id_11EB = var_0;
  var_3._id_11EC = "#" + var_0;
  var_3._id_1032 = var_2;
  var_3._id_11E9 = gettime() + 60000;

  if(_id_11EA(var_0, var_3._id_11EC)) {
    return;
  }
  _id_11E6(var_3);
}

_id_11F0(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");

  if(isDefined(var_2)) {
    var_5 = var_2;
  } else {
    var_5 = self;
  }
  var_6 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = var_0._id_1032;
  }
  var_7 = spawnStruct();
  var_7._id_11F1 = [];
  var_8 = [];

  if(isDefined(var_6) && isDefined(level._id_11B6[var_6])) {
    if(isDefined(level._id_11B6[var_6][var_3])) {
      var_8[var_3] = level._id_11B6[var_6][var_3];
    }
    if(isDefined(level._id_11B6[var_6]["any"])) {
      var_8["any"] = level._id_11B6[var_6]["any"];
    }
  }

  foreach(var_17, var_10 in var_8) {
    foreach(var_12 in level._id_11B6[var_6][var_17]) {
      foreach(var_14 in var_12) {
        if(isDefined(var_14["dialog"])) {
          var_7._id_11F1[var_14["dialog"]] = 1;
        }
      }
    }
  }

  for(;;) {
    var_7._id_11F2 = 0;
    var_18 = undefined;
    var_0 waittill(var_1, var_18);

    if(var_18 == "end") {
      return;
    }
    foreach(var_17, var_10 in var_8) {
      if(isDefined(level._id_11B6[var_6][var_17][var_18])) {
        foreach(var_14 in level._id_11B6[var_6][var_17][var_18]) {}
        _id_11F5(var_14, var_0, var_7, var_5);
      }
    }

    var_22 = getsubstr(var_18, 0, 3);

    if(var_22 == "ps_") {
      var_23 = getsubstr(var_18, 3);

      if(var_23 == "dubai_elevse_yuri_remove_plr_armor") {}

      var_0 thread maps\_utility::play_sound_on_tag(var_23, undefined, 1);
      continue;
    }

    if(var_22 == "psm") {
      var_24 = getsubstr(var_18, 4);
      maps\_audio::aud_send_msg(var_24, var_0);
      continue;
    }

    var_22 = getsubstr(var_18, 0, 4);

    if(var_22 == "psr_") {
      var_23 = getsubstr(var_18, 4);
      maps\_utility::_id_11F4(var_23);
      continue;
    }

    switch (var_18) {
      case "ignoreall true":
        self.ignoreall = 1;
        break;
      case "ignoreall false":
        self.ignoreall = 0;
        break;
      case "ignoreme true":
        self.ignoreme = 1;
        break;
      case "ignoreme false":
        self.ignoreme = 0;
        break;
      case "allowdeath true":
        self.allowdeath = 1;
        break;
      case "allowdeath false":
        self.allowdeath = 0;
        break;
    }
  }
}

_id_11F5(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0["function"])) {
    self thread[[var_0["function"]]](var_1);
  }
  if(isDefined(var_0["flag"])) {
    common_scripts\utility::flag_set(var_0["flag"]);
  }
  if(isDefined(var_0["flag_clear"])) {
    common_scripts\utility::flag_clear(var_0["flag_clear"]);
  }
  if(isDefined(var_0["attach gun left"])) {
    var_1 _id_11F9();
    return;
  }

  if(isDefined(var_0["attach gun right"])) {
    var_1 _id_11FB();
    return;
  }

  if(isDefined(var_0["detach gun"])) {
    var_1 _id_11FC(var_0);
    return;
  }

  if(isDefined(var_0["attach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_1 attach(var_0["attach model"], var_0["selftag"]);
    } else {
      var_3 attach(var_0["attach model"], var_0["tag"]);
    }
    return;
  }

  if(isDefined(var_0["detach model"])) {
    waittillframeend;

    if(isDefined(var_0["selftag"])) {
      var_1 detach(var_0["detach model"], var_0["selftag"]);
    } else {
      var_3 detach(var_0["detach model"], var_0["tag"]);
    }
  }

  if(isDefined(var_0["sound"])) {
    var_1 thread maps\_utility::play_sound_on_tag(var_0["sound"], undefined, 1);
  }
  if(!var_2._id_11F2) {
    if(isDefined(var_0["dialog"]) && isDefined(var_2._id_11F1[var_0["dialog"]])) {
      var_1 animscripts\face::_id_0C46(undefined, var_0["dialog"], 1.0);
      var_2._id_11F1[var_0["dialog"]] = undefined;
      var_2._id_11F2 = 1;
    }
  }

  if(isDefined(var_0["create model"])) {
    _id_11F6(var_1, var_0);
  } else if(isDefined(var_0["delete model"])) {
    _id_11F8(var_1, var_0);
  }
  if(isDefined(var_0["selftag"])) {
    if(isDefined(var_0["effect"])) {
      playFXOnTag(level._effect[var_0["effect"]], var_1, var_0["selftag"]);
    }
    if(isDefined(var_0["stop_effect"])) {
      stopFXOnTag(level._effect[var_0["stop_effect"]], var_1, var_0["selftag"]);
    }
  }

  if(isDefined(var_0["tag"]) && isDefined(var_0["effect"])) {
    playFXOnTag(level._effect[var_0["effect"]], var_3, var_0["tag"]);
  }
  if(isDefined(var_0["selftag"]) && isDefined(var_0["effect_looped"])) {
    playFXOnTag(level._effect[var_0["effect_looped"]], var_1, var_0["selftag"]);
  }
}

_id_11F6(var_0, var_1) {
  if(!isDefined(var_0._id_11F7)) {
    var_0._id_11F7 = [];
  }
  var_2 = var_0._id_11F7.size;
  var_0._id_11F7[var_2] = spawn("script_model", (0, 0, 0));
  var_0._id_11F7[var_2] setModel(var_1["create model"]);
  var_0._id_11F7[var_2].origin = var_0 gettagorigin(var_1["selftag"]);
  var_0._id_11F7[var_2].angles = var_0 gettagangles(var_1["selftag"]);
}

_id_11F8(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_11F7.size; var_2++) {
    if(isDefined(var_1["explosion"])) {
      var_3 = anglesToForward(var_0._id_11F7[var_2].angles);
      var_3 = var_3 * 120;
      var_3 = var_3 + var_0._id_11F7[var_2].origin;
      playFX(level._effect[var_1["explosion"]], var_0._id_11F7[var_2].origin);
      radiusdamage(var_0._id_11F7[var_2].origin, 350, 700, 50);
    }

    var_0._id_11F7[var_2] delete();
  }
}

_id_11F9() {
  if(!isDefined(self._id_11FA)) {
    return;
  }
  self._id_11FA delete();
  self.dropweapon = 1;
  animscripts\shared::_id_0C9B(self.weapon, "left");
}

_id_11FB() {
  if(!isDefined(self._id_11FA)) {
    return;
  }
  self._id_11FA delete();
  self.dropweapon = 1;
  animscripts\shared::_id_0C9B(self.weapon, "right");
}

_id_11FC(var_0) {
  if(isDefined(self._id_11FA)) {
    return;
  }
  var_1 = self gettagorigin(var_0["tag"]);
  var_2 = self gettagangles(var_0["tag"]);
  var_3 = 0;

  if(isDefined(var_0["suspend"])) {
    var_3 = var_0["suspend"];
  }
  var_4 = spawn("weapon_" + self.weapon, var_1, var_3);
  var_4.angles = var_2;
  self._id_11FA = var_4;
  animscripts\shared::_id_0C9B(self.weapon, "none");
  self.dropweapon = 0;
}

_id_11FD(var_0, var_1) {
  var_2 = level._id_0C59[var_0][var_1].size;
  var_3 = randomint(var_2);

  if(var_2 > 1) {
    var_4 = 0;
    var_5 = 0;

    for(var_6 = 0; var_6 < var_2; var_6++) {
      if(isDefined(level._id_0C59[var_0][var_1 + "weight"])) {
        if(isDefined(level._id_0C59[var_0][var_1 + "weight"][var_6])) {
          var_4++;
          var_5 = var_5 + level._id_0C59[var_0][var_1 + "weight"][var_6];
        }
      }
    }

    if(var_4 == var_2) {
      var_7 = randomfloat(var_5);
      var_5 = 0;

      for(var_6 = 0; var_6 < var_2; var_6++) {
        var_5 = var_5 + level._id_0C59[var_0][var_1 + "weight"][var_6];

        if(var_7 < var_5) {
          var_3 = var_6;
          break;
        }
      }
    }
  }

  return var_3;
}

_id_11FE(var_0, var_1, var_2, var_3, var_4) {
  thread _id_122A(var_0, var_1, var_4);
  var_5 = spawnStruct();
  var_5._id_11FF = 0;

  foreach(var_7 in var_0) {
    var_5._id_11FF++;
    thread _id_1201(var_7, var_2, var_3, var_4, var_5);
  }

  for(;;) {
    var_5 waittill("reached_position");

    if(var_5._id_11FF <= 0) {
      return;
    }
  }
}

_id_1200() {
  self endon("death");
  self waittill("anim_reach_complete");
}

_id_1201(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_1200();
  var_4._id_11FF--;
  var_4 notify("reached_position");

  if(isalive(var_0)) {
    _id_124E(var_0, var_1, var_2, var_3);
  }
}

_id_1202(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_1 = self gettagorigin(var_0);
    var_2 = self gettagangles(var_0);
  } else {
    var_1 = self.origin;
    var_2 = self.angles;
  }

  var_3 = [];
  var_3["angles"] = var_2;
  var_3["origin"] = var_1;
  return var_3;
}

_id_1203(var_0, var_1, var_2, var_3) {
  thread _id_1204(var_0);
  _id_122B(var_0, var_1, var_2, var_3, ::_id_1238, ::_id_123E);
}

_id_1204(var_0) {
  var_1 = 0.3;
  waittillframeend;

  for(;;) {
    var_0 = maps\_utility::_id_1228(var_0);
    var_2 = [];
    var_3 = 0;

    foreach(var_8, var_5 in var_0) {
      var_6 = var_5.goalpos;

      if(isDefined(var_5._id_1229)) {
        var_6 = var_5._id_1229;
      }
      var_7 = distance(var_5.origin, var_6);
      var_2[var_5.unique_id] = var_7;

      if(var_7 <= 4) {
        var_0[var_8] = undefined;
        continue;
      }

      var_3 = var_3 + var_7;
    }

    if(var_0.size <= 1) {
      break;
    }

    var_3 = var_3 / var_0.size;

    foreach(var_5 in var_0) {
      var_10 = var_2[var_5.unique_id] - var_3;
      var_11 = var_10 * 0.003;

      if(var_11 > var_1) {
        var_11 = var_1;
      } else if(var_11 < var_1 * -1) {
        var_11 = var_1 * -1;
      }
      var_5._id_0FC6 = 1 + var_11;
    }

    wait 0.05;
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5)) {
      var_5._id_0FC6 = 1;
    }
  }
}

_id_122A(var_0, var_1, var_2, var_3) {
  _id_122B(var_0, var_1, var_2, var_3, ::_id_1238, ::_id_123E);
}

_id_122B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_1202(var_2);
  var_8 = var_7["origin"];
  var_9 = var_7["angles"];

  if(isDefined(var_6)) {
    self.type = var_6;
    self._id_1170 = "stand";
  }

  var_10 = spawnStruct();
  var_11 = 0;
  var_12 = 0;

  foreach(var_14 in var_0) {
    if(isDefined(var_6)) {
      var_14.scriptedarrivalent = self;
    }
    if(isDefined(var_3)) {
      var_15 = var_3;
    } else {
      var_15 = var_14._id_1032;
    }
    if(isDefined(level._id_0C59[var_15][var_1])) {
      if(isarray(level._id_0C59[var_15][var_1])) {
        var_16 = getstartorigin(var_8, var_9, level._id_0C59[var_15][var_1][0]);
      } else {
        var_16 = getstartorigin(var_8, var_9, level._id_0C59[var_15][var_1]);
      }
    } else {
      var_16 = var_8;
    }
    var_12++;
    var_14 thread _id_1236(var_10, var_16, var_4, var_5);
  }

  while(var_12) {
    var_10 waittill("reach_notify");
    var_12--;
  }

  foreach(var_14 in var_0) {
    if(!isalive(var_14)) {
      continue;
    }
    var_14.goalradius = var_14._id_122C;
    var_14.scriptedarrivalent = undefined;
    var_14.stopanimdistsq = 0;
  }

  if(isDefined(var_6)) {
    self.type = undefined;
  }
}

_id_122D(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];

  foreach(var_7 in var_0) {
    var_8 = getstartorigin(var_4, var_5, level._id_0C59[var_7._id_1032][var_1]);
    var_9 = getstartangles(var_4, var_5, level._id_0C59[var_7._id_1032][var_1]);

    if(isai(var_7)) {
      var_7 teleport(var_8);
      continue;
    }

    var_7.origin = var_8;
    var_7.angles = var_9;
  }
}

_id_122E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_1202(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];

  foreach(var_10 in var_0) {
    var_11 = getstartorigin(var_7, var_8, level._id_0C59[var_10._id_1032][var_1]);
    var_12 = getstartangles(var_7, var_8, level._id_0C59[var_10._id_1032][var_1]);

    if(isai(var_10)) {
      continue;
    }
    var_10 moveto(var_11, var_3, var_4, var_5);
    var_10 rotateto(var_12, var_3, var_4, var_5);
  }
}

_id_122F(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = getstartorigin(var_4, var_5, level._id_0C59["generic"][var_1]);
  var_7 = getstartangles(var_4, var_5, level._id_0C59["generic"][var_1]);

  if(isai(var_0)) {
    var_0 teleport(var_6);
  } else {
    var_0.origin = var_6;
    var_0.angles = var_7;
  }
}

_id_1230(var_0, var_1, var_2) {
  return _id_1231(var_0, "generic", var_1, var_2);
}

_id_1231(var_0, var_1, var_2, var_3) {
  var_4 = _id_1202(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = getstartorigin(var_5, var_6, level._id_0C59[var_1][var_2]);
  var_8 = getstartorigin(var_5, var_6, level._id_0C59[var_1][var_2]);
  var_9 = spawn("script_model", var_7);
  var_9 setModel(var_0);
  var_9.angles = var_8;
  return var_9;
}

_id_1232(var_0, var_1) {
  self attach(var_0, var_1);
}

_id_1233(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel(var_0);
  var_3 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  return var_3;
}

_id_1234(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = spawnStruct();

  foreach(var_8 in var_0) {
    var_9 = getstartorigin(var_4, var_5, level._id_0C59[var_8._id_1032][var_1]);
    var_8.origin = var_9;
  }
}

_id_1235(var_0) {
  common_scripts\utility::waittill_either("death", "goal");
  var_0 notify("reach_notify");
}

_id_1236(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("new_anim_reach");
  thread _id_1235(var_0);
  var_1 = [[var_2]](var_1);
  maps\_utility::_id_1237(var_1);
  self._id_1229 = var_1;
  self.goalradius = 0;
  self.stopanimdistsq = squared(64);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[var_3]]();
  self notify("new_anim_reach");
}

_id_1238(var_0) {
  self._id_122C = self.goalradius;
  self._id_1239 = self.pathenemyfightdist;
  self._id_123A = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  maps\_utility::_id_123B();
  _id_123F(1);
  self.nododgemove = 1;
  self._id_123C = self.fixednode;
  self.fixednode = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self._id_123D = self._id_117F;
    self._id_117F = 1;
  }

  self._id_1229 = undefined;
  return var_0;
}

_id_123E() {
  _id_123F(0);
  self.nododgemove = 0;
  self.fixednode = self._id_123C;
  self._id_123C = undefined;
  self.pathenemyfightdist = self._id_1239;
  self.pathenemylookahead = self._id_123A;
  self._id_117F = self._id_123D;
}

_id_123F(var_0) {
  if(isDefined(self._id_1240)) {
    return;
  }
  self pushplayer(var_0);
  return;
}

_id_1241(var_0) {
  var_0 = _id_1238(var_0);
  self._id_117F = 0;
  return var_0;
}

_id_1242(var_0) {
  var_1 = self getdroptofloorposition(var_0);
  var_0 = var_1;
  var_0 = _id_1238(var_0);
  self._id_117F = 1;
  return var_0;
}

_id_1243(var_0) {
  var_1 = self getdroptofloorposition(var_0);
  var_0 = var_1;
  var_0 = _id_1238(var_0);
  self._id_117F = 0;
  return var_0;
}

_id_1244() {
  self useanimtree(level._id_1245[self._id_1032]);
}

_id_1246(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;

  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  _id_11DD(var_5, var_1, var_2, var_3, var_4);
}

_id_1247(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_11DD(var_3, var_1, var_2, 0.25);
}

_id_1248(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  _id_11DD(var_4, var_1, var_2, 0.25);
}

_id_1249(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  _id_11FE(var_5, var_1, var_2, var_3, var_4);
}

_id_124A(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_122A(var_3, var_1, var_2);
}

_id_124B(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  _id_124D(var_4, var_1, var_2, var_3);
}

_id_124C(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  var_4 = spawn("script_origin", self.origin);
  var_4.type = self.type;
  var_4.angles = self.angles;
  var_4._id_1170 = self gethighestnodestance();
  var_0.scriptedarrivalent = var_4;
  _id_124D(var_3, var_1, var_2);
  var_0.scriptedarrivalent = undefined;
  var_4 delete();

  while(var_0.a._id_0D2B != "stop") {
    wait 0.05;
  }
}

_id_124D(var_0, var_1, var_2, var_3) {
  self endon("death");
  _id_122B(var_0, var_1, var_2, undefined, ::_id_1241, ::_id_123E, var_3);
}

_id_124E(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death");
  var_4[0] = var_0;
  _id_11D6(var_4, var_1, var_2, var_3);
}

_id_124F(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  _id_122D(var_3, var_1, var_2);
}

_id_1250(var_0, var_1) {
  if(!isDefined(level._id_1251)) {
    level._id_1251[var_0][0] = var_1;
  } else if(!isDefined(level._id_1251[var_0])) {
    level._id_1251[var_0][0] = var_1;
  } else {
    for(var_2 = 0; var_2 < level._id_1251[var_0].size; var_2++) {
      if(level._id_1251[var_0][var_2] == var_1) {
        return;
      }
    }

    level._id_1251[var_0][level._id_1251[var_0].size] = var_1;
  }
}

_id_1252(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  if(isDefined(var_0._id_1253)) {
    maps\_utility::_id_1254(var_0._id_1253, 0.5);
  }
  maps\_utility::_id_1255(::_id_1246, var_0, var_1, var_2, var_3);

  if(isalive(var_0)) {
    var_0._id_1253 = gettime();
  }
}

_id_1256(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  if(isDefined(var_0._id_1253)) {
    maps\_utility::_id_1254(var_0._id_1253, 0.5);
  }
  if(isDefined(var_4)) {
    maps\_utility::_id_1257(var_4, ::_id_1246, var_0, var_1, var_2, var_3, "generic");
  } else {
    maps\_utility::_id_1255(::_id_1246, var_0, var_1, var_2, var_3, "generic");
  }
  if(isalive(var_0)) {
    var_0._id_1253 = gettime();
  }
}

_id_1258(var_0) {
  foreach(var_2 in var_0) {}
  var_2 pushplayer(0);
}

_id_1259(var_0) {
  foreach(var_2 in var_0) {}
  var_2 pushplayer(1);
}

_id_125A(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_125E(var_2);
  var_4 = _id_125B(var_0, var_1, var_2);
  level._id_11B6[var_0][var_2][var_1][var_4] = [];
  level._id_11B6[var_0][var_2][var_1][var_4]["dialog"] = var_3;
}

_id_125B(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_125C(var_0, var_1, var_2);
  return level._id_11B6[var_0][var_2][var_1].size;
}

_id_125C(var_0, var_1, var_2) {
  var_1 = tolower(var_1);

  if(!isDefined(level._id_11B6)) {
    level._id_11B6 = [];
  }
  if(!isDefined(level._id_11B6[var_0])) {
    level._id_11B6[var_0] = [];
  }
  if(!isDefined(level._id_11B6[var_0][var_2])) {
    level._id_11B6[var_0][var_2] = [];
  }
  if(!isDefined(level._id_11B6[var_0][var_2][var_1])) {
    level._id_11B6[var_0][var_2][var_1] = [];
  }
}

_id_125D(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_125E(var_2);
  var_4 = _id_125B(var_0, var_1, var_2);
  level._id_11B6[var_0][var_2][var_1][var_4] = [];
  level._id_11B6[var_0][var_2][var_1][var_4]["sound"] = var_3;
}

_id_125E(var_0) {
  if(!isDefined(var_0)) {
    return "any";
  }
  return var_0;
}

_id_125F(var_0, var_1, var_2) {
  if(!isDefined(level._id_11B9[var_0])) {
    level._id_11B9[var_0] = [];
  }
  level._id_11B9[var_0][var_1] = var_2;
}

_id_1260(var_0, var_1, var_2, var_3) {
  var_2 = tolower(var_2);
  var_1 = _id_125E(var_1);
  var_4 = _id_125B(var_0, var_2, var_1);
  var_5 = [];
  var_5["sound"] = var_3;
  var_5["created_by_animSound"] = 1;
  level._id_11B6[var_0][var_1][var_2][var_4] = var_5;
}

_id_1261(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_125E(var_4);
  var_5 = _id_125B(var_0, var_1, var_4);
  var_6 = [];
  var_6["attach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_11B6[var_0][var_4][var_1][var_5] = var_6;
}

_id_1262(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = _id_125E(var_4);
  var_5 = _id_125B(var_0, var_1, var_4);
  var_6 = [];
  var_6["detach model"] = var_2;
  var_6["selftag"] = var_3;
  level._id_11B6[var_0][var_4][var_1][var_5] = var_6;
}

_id_1263(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = _id_125E(var_2);
  var_4 = _id_125B(var_0, var_1, var_2);
  var_5 = [];
  var_5["detach gun"] = 1;
  var_5["tag"] = "tag_weapon_right";

  if(isDefined(var_3)) {
    var_5["suspend"] = var_3;
  }
  level._id_11B6[var_0][var_2][var_1][var_4] = var_5;
}

_id_1264(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_125E(var_3);
  var_4 = _id_125B(var_0, var_1, var_3);
  var_5 = [];
  var_5["function"] = var_2;
  level._id_11B6[var_0][var_3][var_1][var_4] = var_5;
}

_id_1265(var_0, var_1, var_2, var_3, var_4) {
  common_scripts\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_125E(var_2);
  var_5 = _id_125B(var_0, var_1, var_2);
  var_6 = [];
  var_6["effect"] = var_3;
  var_6["selftag"] = var_4;
  level._id_11B6[var_0][var_2][var_1][var_5] = var_6;
}

_id_1266(var_0, var_1, var_2, var_3, var_4) {
  common_scripts\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = _id_125E(var_2);
  var_5 = _id_125B(var_0, var_1, var_2);
  var_6 = [];
  var_6["stop_effect"] = var_3;
  var_6["selftag"] = var_4;
  level._id_11B6[var_0][var_2][var_1][var_5] = var_6;
}

_id_1267(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_125E(var_3);
  var_4 = _id_125B(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag"] = var_2;
  level._id_11B6[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level.flag) || !isDefined(level.flag[var_2])) {
    common_scripts\utility::flag_init(var_2);
  }
}

_id_1268(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = _id_125E(var_3);
  var_4 = _id_125B(var_0, var_1, var_3);
  var_5 = [];
  var_5["flag_clear"] = var_2;
  level._id_11B6[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level.flag) || !isDefined(level.flag[var_2])) {
    common_scripts\utility::flag_init(var_2);
  }
}

#using_animtree("generic_human");

_id_1269(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon(var_1);
  var_3 = 0.05;
  var_0 notify("newLookTarget");
  waittillframeend;
  var_0 setanim(%scripted_talking, 5, 0.2);
  var_0 setflaggedanimknobrestart("face_done_" + var_1, var_2, 1, 0, 1);
  thread _id_126A(var_0, var_1, var_2);
  thread _id_1272(var_0, "face_done_" + var_1, var_1);
}

_id_126A(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("stop_loop");
  self endon(var_1);

  for(;;) {
    var_0 setanim(%scripted_talking, 5, 0.4);
    var_0 setflaggedanimknoblimited("face_done_" + var_1, var_2, 1, 0, 1);
    wait 0.05;
  }
}

_id_0BDB(var_0, var_1) {
  self endon("death");
  var_2 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;

  if(!isDefined(var_1) && isDefined(self._id_0BAE)) {
    var_1 = self._id_0BAE;
  }
  var_3 = % generic_talker_allies;

  if(self isbadguy()) {
    var_3 = % generic_talker_axis;
  }
  self setanimknoblimitedrestart(var_3, 1, 0, 1);
  self setanim(%scripted_talking, 5, 0.4);
  _id_126B(var_0, var_3);
  var_2 = 0.3;
  self clearanim(%scripted_talking, 0.2);
}

_id_126B(var_0, var_1) {
  self endon(var_0);

  for(;;) {
    wait 0.2;
    self setanimknoblimited(var_1, 1, 0, 1);
    self setanim(%scripted_talking, 5, 0.4);
  }
}

_id_126C(var_0) {
  self endon("death");
  var_1 = % generic_talker_allies;

  if(self isbadguy()) {
    var_1 = % generic_talker_axis;
  }
  self setanimknoblimitedrestart(var_1, 1, 0, 1);
  self setanim(%scripted_talking, 5, 0.4);
  wait(var_0);
  var_2 = 0.3;
  self clearanim(%scripted_talking, 0.2);
}

_id_126D(var_0, var_1) {
  var_2 = var_0[1] - var_1[1];
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_126E(var_0, var_1) {
  self notify("lookline");
  self endon("lookline");
  self endon(var_1);
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_126F(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.count = var_0.size;

  foreach(var_5 in var_0) {}
  thread _id_1270(var_5, var_1, var_2, var_3);

  while(var_3.count) {
    var_3 waittill("reached_goal");
  }
  self notify("stopReachIdle");
}

_id_1270(var_0, var_1, var_2, var_3) {
  _id_124A(var_0, var_1);
  var_3.count--;
  var_3 notify("reached_goal");

  if(var_3.count > 0) {
    _id_124E(var_0, var_2, "stopReachIdle");
  }
}

_id_1271(var_0, var_1, var_2, var_3) {
  if(animhasnotetrack(var_3, "dialog")) {
    self waittillmatch("face_done_" + var_0, "dialog");
  }
  if(var_1) {
    animscripts\face::_id_0C46(undefined, var_2, 1.0);
  } else {
    animscripts\face::_id_0C46(undefined, var_2, 1.0, "single dialogue");
  }
}

_id_1272(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 waittillmatch(var_1, "end");
  var_3 = 0.3;
  var_0 clearanim(%scripted_talking, 0.2);
}

_id_1273(var_0, var_1, var_2) {
  var_3 = _id_1202(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  common_scripts\utility::array_thread(var_0, ::_id_1275, var_1, var_4, var_5);
}

_id_1274(var_0, var_1, var_2) {
  var_3[0] = var_0;
  _id_1273(var_3, var_1, var_2);
}

_id_1275(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = var_3;
  } else {
    var_5 = self._id_1032;
  }
  if(isDefined(var_4) && var_4) {
    var_6 = level._id_0C59[var_5][var_0][0];
  } else {
    var_6 = level._id_0C59[var_5][var_0];
  }
  if(isai(self)) {
    var_7 = getstartorigin(var_1, var_2, var_6);
    var_8 = getstartangles(var_1, var_2, var_6);

    if(isDefined(self._id_1276)) {
      var_7 = maps\_utility::_id_1277(var_7);
    }
    self forceteleport(var_7, var_8);
  } else if(self.code_classname == "script_vehicle") {
    self vehicle_teleport(getstartorigin(var_1, var_2, var_6), getstartangles(var_1, var_2, var_6));
  } else {
    self.origin = getstartorigin(var_1, var_2, var_6);
    self.angles = getstartangles(var_1, var_2, var_6);
  }
}

_id_1278(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = self;
  return var_2;
}

_id_1279(var_0, var_1) {
  var_2 = [];
  var_2["guy"] = self;
  var_2["entity"] = var_0;
  var_2["tag"] = var_1;
  return var_2;
}

_id_127A() {
  if(!isDefined(self._id_11E8)) {
    self._id_11E8 = [];
  }
  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_11E8.size; var_1++) {
    if(self == level._id_11E8[var_1]) {
      var_0 = 1;
      break;
    }
  }

  if(!var_0) {
    level._id_11E8[level._id_11E8.size] = self;
  }
}

_id_127B(var_0, var_1, var_2) {
  var_0 thread _id_127D(var_1, var_2);
}

_id_127C(var_0, var_1, var_2) {
  common_scripts\utility::array_thread(var_0, ::_id_127D, var_1, var_2);
}

_id_127D(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = self._id_1032;
  }
  self setflaggedanim("single anim", maps\_utility::_id_127E(var_0, var_3), 1, 0, var_1);
}

_id_127F(var_0, var_1, var_2) {
  common_scripts\utility::array_thread(var_0, ::_id_1280, var_1, var_2);
}

_id_1280(var_0, var_1) {
  var_2 = maps\_utility::_id_1281(var_0);
  self setanimtime(var_2, var_1);
}

_id_1282() {
  if(!isDefined(self._id_1283)) {
    self._id_1283 = gettime();
    return;
  }

  var_0 = gettime();

  if(self._id_1283 == var_0) {
    self endon("death");
    wait 0.05;
  }

  self._id_1283 = var_0;
}

_id_1284(var_0, var_1) {
  var_0._id_11A0 = animscripts\cover_arrival::_id_119C;
  var_0._id_119D = level._id_0C59[var_0._id_1032][var_1];
}