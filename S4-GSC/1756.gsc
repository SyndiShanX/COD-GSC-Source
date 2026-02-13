/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1756.gsc
*************************************************/

_id_E617(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("stop_sequencing_notetracks");
  thread _id_A60C(var_0, var_1, self, var_2, var_3, var_4);
}

_id_A60C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = self;
  }

  var_7 = undefined;

  if(isDefined(var_4)) {
    var_7 = var_4;
  } else {
    var_7 = var_0._id_18AF;
  }

  var_8 = spawnStruct();
  var_8._id_48F3 = [];
  var_9 = [];

  if(isDefined(var_7) && isDefined(level._id_CC43[var_7]) && isDefined(var_3)) {
    if(isDefined(level._id_CC43[var_7][var_3])) {
      var_9[var_3] = level._id_CC43[var_7][var_3];
    }

    if(isDefined(level._id_CC43[var_7]["any"])) {
      var_9["any"] = level._id_CC43[var_7]["any"];
    }
  }

  foreach(var_18, var_11 in var_9) {
    foreach(var_13 in level._id_CC43[var_7][var_18]) {
      foreach(var_15 in var_13) {
        if(isDefined(var_15["dialog"])) {
          var_8._id_48F3[var_15["dialog"]] = 1;
        }
      }
    }
  }

  var_19 = 0;
  var_20 = 0;

  for(;;) {
    var_8._id_4964 = 0;
    var_21 = undefined;

    if(!var_19 && isDefined(var_7) && isDefined(var_3)) {
      var_19 = 1;
      var_22 = undefined;
      var_20 = isDefined(level._id_CC43[var_7]) && isDefined(level._id_CC43[var_7][var_3]) && isDefined(level._id_CC43[var_7][var_3]["start"]);

      if(!var_20) {
        continue;
      }
      var_23 = ["start"];
    } else
      var_0 waittill(var_1, var_23);

    if(!_func_0107(var_23)) {
      var_23 = [var_23];
    }

    var_0 _id_BD17(var_23);
    _id_FF4D(var_1, var_23, var_5);
    var_24 = undefined;

    foreach(var_26 in var_23) {
      _id_A5F4(var_0, var_3, var_26, var_7, var_9, var_6, var_8);

      if(var_26 == "end") {
        var_24 = 1;
      }
    }

    if(isDefined(var_24)) {
      break;
    }
  }
}

_id_A5F4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_2 == "end") {
    if(isDefined(anim._id_2F52["EntityHandleNotetrackAnimEnd"])) {
      [[anim._id_2F52["EntityHandleNotetrackAnimEnd"]]](var_0, var_2);
    }

    return 1;
  }

  foreach(var_12, var_8 in var_4) {
    if(isDefined(level._id_CC43[var_3][var_12][var_2])) {
      foreach(var_10 in level._id_CC43[var_3][var_12][var_2])[[anim._id_2F52["AnimHandleNotetrack"]]](var_10, var_0, var_6, var_5);
    }
  }

  if(isDefined(anim._id_2F52["EntityHandleNotetrack"])) {
    [[anim._id_2F52["EntityHandleNotetrack"]]](var_0, var_2);
  }
}

_id_17DB(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0["function"])) {
    self thread[[var_0["function"]]](var_1);
  }

  if(isDefined(var_0["notify"])) {
    level notify(var_0["notify"]);
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
    if(isDefined(var_0["selftag"])) {
      var_1 detach(var_0["detach model"], var_0["selftag"]);
    } else {
      var_3 detach(var_0["detach model"], var_0["tag"]);
    }
  }

  if(!var_2._id_4964) {
    if(isDefined(var_0["dialog"]) && isDefined(var_2._id_48F3[var_0["dialog"]])) {
      var_1 scripts\anim\face::_id_CB6F(var_0["dialog"]);
      var_2._id_48F3[var_0["dialog"]] = undefined;
      var_2._id_4964 = 1;
    }
  }

  if(isDefined(var_0["create model"])) {
    _id_179A(var_1, var_0);
  } else if(isDefined(var_0["delete model"])) {
    _id_182A(var_1, var_0);
  }

  if(isDefined(var_0["selftag"])) {
    if(isDefined(var_0["effect"])) {
      level thread _id_A5F2(var_1, var_0);
    }

    if(isDefined(var_0["stop_effect"])) {
      stopFXOnTag(level._effect[var_0["stop_effect"]], var_1, var_0["selftag"]);
    }

    if(isDefined(var_0["swap_part_to_efx"])) {
      playFXOnTag(level._effect[var_0["swap_part_to_efx"]], var_1, var_0["selftag"]);
      var_1 hidepart(var_0["selftag"]);
    }

    if(isDefined(var_0["trace_part_for_efx"])) {
      var_4 = undefined;
      var_5 = scripts\engine\utility::getfx(var_0["trace_part_for_efx"]);

      if(isDefined(var_0["trace_part_for_efx_water"])) {
        var_4 = scripts\engine\utility::getfx(var_0["trace_part_for_efx_water"]);
      }

      var_6 = 0;

      if(isDefined(var_0["trace_part_for_efx_delete_depth"])) {
        var_6 = var_0["trace_part_for_efx_delete_depth"];
      }

      var_1 thread _id_F3C1(var_0["selftag"], var_5, var_4, var_6);
    }

    if(isDefined(var_0["trace_part_for_efx_canceling"])) {
      var_1 thread _id_F3C2(var_0["selftag"]);
    }
  }

  if(isDefined(var_0["tag"]) && isDefined(var_0["effect"])) {
    playFXOnTag(level._effect[var_0["effect"]], var_3, var_0["tag"]);
  }

  if(isDefined(var_0["selftag"]) && isDefined(var_0["effect_looped"])) {
    playFXOnTag(level._effect[var_0["effect_looped"]], var_1, var_0["selftag"]);
  }
}

_id_179A(var_0, var_1) {
  if(!isDefined(var_0._id_CF8F)) {
    var_0._id_CF8F = [];
  }

  var_2 = var_0._id_CF8F.size;
  var_0._id_CF8F[var_2] = spawn("script_model", (0, 0, 0));
  var_0._id_CF8F[var_2] setModel(var_1["create model"]);
  var_0._id_CF8F[var_2].origin = var_0 gettagorigin(var_1["selftag"]);
  var_0._id_CF8F[var_2].angles = var_0 gettagangles(var_1["selftag"]);
}

_id_182A(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_CF8F.size; var_2++) {
    if(isDefined(var_1["explosion"])) {
      var_3 = anglesToForward(var_0._id_CF8F[var_2].angles);
      var_3 = var_3 * 120;
      var_3 = var_3 + var_0._id_CF8F[var_2].origin;
      playFX(level._effect[var_1["explosion"]], var_0._id_CF8F[var_2].origin);
      _func_01BA(var_0._id_CF8F[var_2].origin, 350, 700, 50);
    }

    var_0._id_CF8F[var_2] delete();
  }
}

_id_A5F2(var_0, var_1) {
  var_2 = isDefined(var_1["moreThanThreeHack"]);

  if(var_2) {
    scripts\engine\utility::_id_96E1("moreThanThreeHack");
  }

  playFXOnTag(level._effect[var_1["effect"]], var_0, var_1["selftag"]);

  if(var_2) {
    scripts\engine\utility::_id_F981("moreThanThreeHack");
  }
}

_id_F3C2(var_0) {
  self notify("cancel_trace_for_part_" + var_0);
}

_id_F3C1(var_0, var_1, var_2, var_3) {
  var_4 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + var_0);
  var_5 = self gettagorigin(var_0);
  var_6 = 0;
  var_7 = spawnStruct();
  var_7._id_8F4D = self gettagorigin(var_0);
  var_7._id_799D = 0;
  var_7._id_AE77 = var_0;
  var_7._id_799F = 0;
  var_7._id_5106 = var_1;
  var_7._id_E76E = 0;
  var_7._id_8F40 = gettime();

  while(isDefined(self) && !var_7._id_799D) {
    scripts\engine\utility::_id_96E1(var_4);
    _id_F0CE(var_7);
    scripts\engine\utility::_id_F98A(var_4);

    if(var_7._id_E76E == 1 && gettime() - var_7._id_8F40 > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_2) && var_7._id_799F) {
    var_1 = var_2;
  }

  playFX(var_1, var_7._id_8F4D);

  if(var_3 == 0) {
    self hidepart(var_0);
  } else {
    thread _id_790E(var_7._id_8F4D[2] - var_3, var_0);
  }
}

_id_790E(var_0, var_1) {
  self endon("entitydeleted");

  while(self gettagorigin(var_1)[2] > var_0) {
    wait 0.05;
  }

  self hidepart(var_1);
}

_id_F0CE(var_0) {
  var_1 = undefined;

  if(!isDefined(self)) {
    return;
  }
  var_0._id_4190 = self gettagorigin(var_0._id_AE77);

  if(var_0._id_4190 != var_0._id_8F4D) {
    var_0._id_8F40 = gettime();
    var_0._id_E76E = 0;

    if(!scripts\engine\trace::_bullet_trace_passed(var_0._id_8F4D, var_0._id_4190, 0, self)) {
      var_2 = scripts\engine\trace::_bullet_trace(var_0._id_8F4D, var_0._id_4190, 0, self);

      if(var_2["fraction"] < 1.0) {
        var_0._id_8F4D = var_2["position"];
        var_0._id_799F = var_2["surfacetype"] == "water";
        var_0._id_799D = 1;
        return;
      } else {}
    }
  } else
    var_0._id_E76E = 1;

  var_0._id_8F4D = var_0._id_4190;
}

_id_0B1D(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

_id_FF4D(var_0, var_1, var_2) {}

_id_BD17(var_0) {}

_id_18DF(var_0, var_1) {
  _id_102E();
  var_2 = spawnStruct();
  var_2._id_18A3 = var_0;
  var_2._id_A5F0 = "#" + var_0;
  var_2._id_18AF = var_1;
  var_2._id_52CE = gettime() + 60000;

  if(_id_18DD(var_0, var_2._id_A5F0)) {
    return;
  }
  _id_0F9B(var_2);
}

_id_18E0(var_0, var_1, var_2) {
  _id_102E();
  var_0 = var_1 + var_0;
  var_3 = spawnStruct();
  var_3._id_18A3 = var_0;
  var_3._id_A5F0 = "#" + var_0;
  var_3._id_18AF = var_2;
  var_3._id_52CE = gettime() + 60000;

  if(_id_18DD(var_0, var_3._id_A5F0)) {
    return;
  }
  _id_0F9B(var_3);
}

_id_18E2(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  _id_102E();

  if(var_1 == "end") {
    return;
  }
  if(_id_18DD(var_0, var_1)) {
    return;
  }
  var_3 = spawnStruct();
  var_3._id_18A3 = var_0;
  var_3._id_A5F0 = var_1;
  var_3._id_18AF = var_2;
  var_3._id_52CE = gettime() + 60000;
  _id_0F9B(var_3);
}

_id_18DD(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = getarraykeys(self._id_18E3);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self._id_18E3[var_4]._id_18A3 != var_0) {
      continue;
    }
    if(self._id_18E3[var_4]._id_A5F0 != var_1) {
      continue;
    }
    self._id_18E3[var_4]._id_52CE = gettime() + 60000;
    return 1;
  }

  return 0;
}

_id_0F9B(var_0) {
  for(var_1 = 0; var_1 < level._id_18DE; var_1++) {
    if(isDefined(self._id_18E3[var_1])) {
      continue;
    }
    self._id_18E3[var_1] = var_0;
    return;
  }

  var_2 = getarraykeys(self._id_18E3);
  var_3 = var_2[0];
  var_4 = self._id_18E3[var_3]._id_52CE;

  for(var_1 = 1; var_1 < var_2.size; var_1++) {
    var_5 = var_2[var_1];

    if(self._id_18E3[var_5]._id_52CE < var_4) {
      var_4 = self._id_18E3[var_5]._id_52CE;
      var_3 = var_5;
    }
  }

  self._id_18E3[var_3] = var_0;
}

_id_102E() {
  if(!isDefined(self._id_18E3)) {
    self._id_18E3 = [];
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < level._id_18E3.size; var_1++) {
    if(self == level._id_18E3[var_1]) {
      var_0 = 1;
      break;
    }
  }

  if(!var_0) {
    level._id_18E3[level._id_18E3.size] = self;
  }
}