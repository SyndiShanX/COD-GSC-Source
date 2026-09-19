/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: common_scripts\_destructible.gsc
********************************************/

init() {
  level._id_2E2A = 50;
  level._id_2E29 = [];
  level._id_2928 = 0;
  level._id_254D = gettime();

  if(!isDefined(level._id_3A53))
    level._id_3A53 = 0;

  if(!isDefined(level._id_3F02))
    level._id_3F02 = [];

  var_0 = 1;

  if(var_0)
    _id_3B74();

  var_1 = getEntArray("delete_on_load", "targetname");

  foreach(var_3 in var_1)
  var_3 delete();

  _id_51B4();
  _id_51B5();
}

_id_2AB9() {}

_id_3B74() {
  if(!isDefined(level._id_2DFA))
    level._id_2DFA = [];

  var_0 = [];

  foreach(var_2 in level.struct) {
    if(isDefined(var_2._id_0165) && var_2._id_0165 == "destructible_dot")
      var_0[var_0.size] = var_2;
  }

  var_4 = getEntArray("destructible_vehicle", "targetname");

  foreach(var_6 in var_4)
  var_6 thread _id_87D3(var_0);

  var_8 = getEntArray("destructible_toy", "targetname");

  foreach(var_10 in var_8)
  var_10 thread _id_87D3(var_0);

  _id_2AB9();
}

_id_87D3(var_0) {
  _id_87D2();
  _id_87D0(var_0);
}

_id_87D0(var_0) {
  var_1 = self._id_2E25;

  foreach(var_3 in var_0) {
    if(isDefined(level._id_0075[var_1]._id_2DF3)) {
      return;
    }
    if(isDefined(var_3.setlookatent) && issubstr(var_3.setlookatent, "destructible_type") && issubstr(var_3.setlookatent, self._id_0075)) {
      if(distancesquared(self.origin, var_3.origin) < 1) {
        var_4 = getEntArray(var_3.target, "targetname");
        level._id_0075[var_1]._id_2DF3 = [];

        foreach(var_6 in var_4) {
          var_7 = var_6.setmovespeedscale;

          if(!isDefined(level._id_0075[var_1]._id_2DF3[var_7]))
            level._id_0075[var_1]._id_2DF3[var_7] = [];

          var_8 = level._id_0075[var_1]._id_2DF3[var_7].size;
          level._id_0075[var_1]._id_2DF3[var_7][var_8]["classname"] = var_6.classname;
          level._id_0075[var_1]._id_2DF3[var_7][var_8]["origin"] = var_6.origin;
          var_9 = common_scripts\utility::_id_98E7(isDefined(var_6.spawnflags), var_6.spawnflags, 0);
          level._id_0075[var_1]._id_2DF3[var_7][var_8]["spawnflags"] = var_9;

          switch (var_6.classname) {
            case "trigger_radius":
              level._id_0075[var_1]._id_2DF3[var_7][var_8]["radius"] = var_6._id_00BD;
              level._id_0075[var_1]._id_2DF3[var_7][var_8]["height"] = var_6._id_00BD;
              break;
            default:
          }

          var_6 delete();
        }

        break;
      }
    }
  }
}

_id_2E02(var_0) {
  if(!isDefined(level._id_0075))
    return -1;

  if(level._id_0075.size == 0)
    return -1;

  for(var_1 = 0; var_1 < level._id_0075.size; var_1++) {
    if(var_0 == level._id_0075[var_1].v["type"])
      return var_1;
  }

  return -1;
}

_id_2DA4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = "test/concrete_cover_dest_test";

  if(!isDefined(var_3))
    var_3 = 150;

  _id_2DED(var_0, "tag_origin", 1, undefined, 32, "no_melee");

  if(isDefined(var_4))
    _id_2E1C(undefined, var_4, undefined, undefined, 32, "no_melee");

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = "fx_joint_" + var_6;
    _id_2E0F(var_7, undefined, var_3, undefined, undefined, "no_melee", 1);
    _id_2DFB(var_7, var_2);

    if(isDefined(var_5))
      _id_2E15(var_5);

    _id_2E1C(undefined);
  }
}

_id_2E03(var_0) {
  var_1 = _id_2E02(var_0);

  if(var_1 >= 0)
    return var_1;

  if(issubstr(var_0, "dest_cover")) {
    _id_2DA4(self._id_0075, self.atdangerousnode, self.isingoal, self.setruntopos, self.nearclaimnodeandangle, self.nearnode);
    var_1 = _id_2E02(var_0);
    return var_1;
  }

  if(!isDefined(level._id_2DFA[var_0]))
    return -1;

  [[level._id_2DFA[var_0]]]();
  var_1 = _id_2E02(var_0);
  return var_1;
}

_id_87D2() {
  var_0 = undefined;
  self._id_6297 = 0;
  _id_0914();
  self._id_2E25 = _id_2E03(self._id_0075);

  if(self._id_2E25 < 0) {
    return;
  }
  _id_7643();
  _id_091C();

  if(isDefined(level._id_2E1E) && isDefined(level._id_2E1E[self._id_0075]))
    common_scripts\utility::_id_3C9F(level._id_2E1E[self._id_0075] + "_loaded");

  if(isDefined(level._id_0075[self._id_2E25]._id_1145)) {
    foreach(var_3 in level._id_0075[self._id_2E25]._id_1145) {
      if(isDefined(var_3._id_95A6))
        self attach(var_3.model, var_3._id_95A6);
      else
        self attach(var_3.model);

      if(self._id_6297) {
        if(isDefined(var_3._id_95A6)) {
          self._id_6296 attach(var_3.model, var_3._id_95A6);
          continue;
        }

        self._id_6296 attach(var_3.model);
      }
    }
  }

  if(isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    self._id_2E10 = [];

    for(var_5 = 0; var_5 < level._id_0075[self._id_2E25]._id_6E9F.size; var_5++) {
      self._id_2E10[var_5] = spawnStruct();
      self._id_2E10[var_5].v["currentState"] = 0;

      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["health"]))
        self._id_2E10[var_5].v["health"] = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["health"];

      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["random_dynamic_attachment_1"])) {
        var_6 = randomint(level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["random_dynamic_attachment_1"].size);
        var_7 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["random_dynamic_attachment_tag"][var_6];
        var_8 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["random_dynamic_attachment_1"][var_6];
        var_9 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["random_dynamic_attachment_2"][var_6];
        var_10 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["clipToRemove"][var_6];
        thread _id_30DF(var_7, var_8, var_9, var_10);
      }

      if(var_5 == 0) {
        continue;
      }
      var_11 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["modelName"];
      var_12 = level._id_0075[self._id_2E25]._id_6E9F[var_5][0].v["tagName"];

      for(var_13 = 1; isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_5][var_13]); var_13++) {
        var_14 = level._id_0075[self._id_2E25]._id_6E9F[var_5][var_13].v["tagName"];
        var_15 = level._id_0075[self._id_2E25]._id_6E9F[var_5][var_13].v["modelName"];

        if(isDefined(var_14) && var_14 != var_12) {
          _id_4D03(var_14);

          if(self._id_6297)
            self._id_6296 _id_4D03(var_14);
        }
      }
    }
  }

  if(isDefined(self.target))
    thread _id_2E05();

  if(self._id_003B != "script_vehicle")
    self setcandamage(1);

  if(common_scripts\utility::issp())
    thread _id_258B();

  thread _id_2E1D();

  if(issubstr(self._id_0075, "dest_cover"))
    thread _id_2E23();

  thread _id_2DFF();
}

_id_2DED(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_0075))
    level._id_0075 = [];

  var_6 = level._id_0075.size;
  level._id_0075[var_6] = spawnStruct();
  level._id_0075[var_6].v["type"] = var_0;
  level._id_0075[var_6]._id_6E9F = [];
  level._id_0075[var_6]._id_6E9F[0][0] = spawnStruct();
  level._id_0075[var_6]._id_6E9F[0][0].v["modelName"] = self.model;
  level._id_0075[var_6]._id_6E9F[0][0].v["tagName"] = var_1;
  level._id_0075[var_6]._id_6E9F[0][0].v["health"] = var_2;
  level._id_0075[var_6]._id_6E9F[0][0].v["validAttackers"] = var_3;
  level._id_0075[var_6]._id_6E9F[0][0].v["validDamageZone"] = var_4;
  level._id_0075[var_6]._id_6E9F[0][0].v["validDamageCause"] = var_5;
  level._id_0075[var_6]._id_6E9F[0][0].v["godModeAllowed"] = 1;
  level._id_0075[var_6]._id_6E9F[0][0].v["rotateTo"] = self.angles;
  level._id_0075[var_6]._id_6E9F[0][0].v["vehicle_exclude_anim"] = 0;
}

_id_2E0F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level._id_0075.size - 1;
  var_11 = level._id_0075[var_10]._id_6E9F.size;
  var_12 = 0;
  _id_2E08(var_11, var_12, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, undefined, var_9);
}

_id_2E1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level._id_0075.size - 1;
  var_9 = level._id_0075[var_8]._id_6E9F.size - 1;
  var_10 = level._id_0075[var_8]._id_6E9F[var_9].size;

  if(!isDefined(var_0) && var_9 == 0)
    var_0 = level._id_0075[var_8]._id_6E9F[var_9][0].v["tagName"];

  _id_2E08(var_9, var_10, var_0, var_1, var_2, var_3, var_4, var_5, undefined, undefined, var_6, var_7);
}

_id_2DFD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_2DFB(var_0, var_1, var_2, var_3, var_4, var_5, 1, var_6);
}

_id_2DFB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 0;

  if(!isDefined(var_7))
    var_7 = 0;

  var_8 = level._id_0075.size - 1;
  var_9 = level._id_0075[var_8]._id_6E9F.size - 1;
  var_10 = level._id_0075[var_8]._id_6E9F[var_9].size - 1;
  var_11 = 0;

  if(isDefined(level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_filename"])) {
    if(isDefined(level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_filename"][var_4]))
      var_11 = level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_filename"][var_4].size;
  }

  if(isDefined(var_3))
    level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_valid_damagetype"][var_4][var_11] = var_3;

  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_filename"][var_4][var_11] = var_1;
  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_tag"][var_4][var_11] = var_0;
  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_useTagAngles"][var_4][var_11] = var_2;
  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["fx_cost"][var_4][var_11] = var_5;
  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["spawn_immediate"][var_4][var_11] = var_6;
  level._id_0075[var_8]._id_6E9F[var_9][var_10].v["state_change_kill"][var_4][var_11] = var_7;
}

_id_2DEE(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;

  if(!isDefined(level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"]))
    level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"] = [];

  var_4 = level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"].size;
  var_5 = _id_27E2();
  var_5.type = "predefined";
  var_5._id_00D4 = var_0;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"][var_4] = var_5;
}

_id_2DEF(var_0, var_1, var_2, var_3) {
  var_4 = level._id_0075.size - 1;
  var_5 = level._id_0075[var_4]._id_6E9F.size - 1;
  var_6 = level._id_0075[var_4]._id_6E9F[var_5].size - 1;

  if(!isDefined(level._id_0075[var_4]._id_6E9F[var_5][var_6].v["dot"]))
    level._id_0075[var_4]._id_6E9F[var_5][var_6].v["dot"] = [];

  var_7 = level._id_0075[var_4]._id_6E9F[var_5][var_6].v["dot"].size;
  var_8 = _id_27E3((0, 0, 0), var_1, var_2, var_3);
  var_8._id_95A6 = var_0;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["dot"][var_7] = var_8;
}

_id_2E13(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = level._id_0075.size - 1;
  var_9 = level._id_0075[var_8]._id_6E9F.size - 1;
  var_10 = level._id_0075[var_8]._id_6E9F[var_9].size - 1;
  var_11 = level._id_0075[var_8]._id_6E9F[var_9][var_10].v["dot"].size - 1;
  var_12 = level._id_0075[var_8]._id_6E9F[var_9][var_10].v["dot"][var_11];
  var_12 _id_866A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  _id_52AF(var_6);
}

_id_2E14(var_0, var_1, var_2) {
  var_3 = level._id_0075.size - 1;
  var_4 = level._id_0075[var_3]._id_6E9F.size - 1;
  var_5 = level._id_0075[var_3]._id_6E9F[var_4].size - 1;
  var_6 = level._id_0075[var_3]._id_6E9F[var_4][var_5].v["dot"].size - 1;
  var_7 = level._id_0075[var_3]._id_6E9F[var_4][var_5].v["dot"][var_6];
  var_8 = var_7._id_99C1.size;
  var_7._id_99C1[var_8]._id_6B05 = var_0;
  var_7._id_99C1[var_8]._id_6B33 = var_1;
  var_7._id_99C1[var_8]._id_6AE6 = var_2;
}

_id_2DE8(var_0, var_1) {
  var_2 = level._id_0075.size - 1;
  var_3 = level._id_0075[var_2]._id_6E9F.size - 1;
  var_4 = level._id_0075[var_2]._id_6E9F[var_3].size - 1;
  var_5 = level._id_0075[var_2]._id_6E9F[var_3][var_4].v["dot"].size - 1;
  var_6 = level._id_0075[var_2]._id_6E9F[var_3][var_4].v["dot"][var_5];
  var_6 _id_1D45(var_0, var_1);
}

_id_2DE9(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  var_4 = level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"].size - 1;
  var_5 = level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"][var_4];
  var_5 _id_1D46(var_0);
}

_id_2DE7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level._id_0075.size - 1;
  var_7 = level._id_0075[var_6]._id_6E9F.size - 1;
  var_8 = level._id_0075[var_6]._id_6E9F[var_7].size - 1;
  var_9 = level._id_0075[var_6]._id_6E9F[var_7][var_8].v["dot"].size - 1;
  var_10 = level._id_0075[var_6]._id_6E9F[var_7][var_8].v["dot"][var_9];
  var_10 _id_1D44(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_2DEA(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  var_4 = level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"].size - 1;
  var_5 = level._id_0075[var_1]._id_6E9F[var_2][var_3].v["dot"][var_4];
  var_5 _id_1D47(var_0);
}

_id_2E0A(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = level._id_0075.size - 1;
  var_5 = level._id_0075[var_4]._id_6E9F.size - 1;
  var_6 = level._id_0075[var_4]._id_6E9F[var_5].size - 1;
  var_7 = 0;

  if(isDefined(level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_filename"]))
    var_7 = level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_filename"].size;

  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_filename"][var_7] = var_1;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_tag"][var_7] = var_0;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_rate"][var_7] = var_2;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["loopfx_cost"][var_7] = var_3;
}

_id_2E07(var_0, var_1, var_2, var_3) {
  var_4 = level._id_0075.size - 1;
  var_5 = level._id_0075[var_4]._id_6E9F.size - 1;
  var_6 = level._id_0075[var_4]._id_6E9F[var_5].size - 1;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["healthdrain_amount"] = var_0;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["healthdrain_interval"] = var_1;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["badplace_radius"] = var_2;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["badplace_team"] = var_3;
}

_id_2E15(var_0, var_1, var_2) {
  var_3 = level._id_0075.size - 1;
  var_4 = level._id_0075[var_3]._id_6E9F.size - 1;
  var_5 = level._id_0075[var_3]._id_6E9F[var_4].size - 1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"])) {
    level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"] = [];
    level._id_0075[var_3]._id_6E9F[var_4][var_5].v["soundCause"] = [];
  }

  if(!isDefined(level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"][var_2])) {
    level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"][var_2] = [];
    level._id_0075[var_3]._id_6E9F[var_4][var_5].v["soundCause"][var_2] = [];
  }

  var_6 = level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"][var_2].size;
  level._id_0075[var_3]._id_6E9F[var_4][var_5].v["sound"][var_2][var_6] = var_0;
  level._id_0075[var_3]._id_6E9F[var_4][var_5].v["soundCause"][var_2][var_6] = var_1;
}

_id_2E0B(var_0, var_1) {
  var_2 = level._id_0075.size - 1;
  var_3 = level._id_0075[var_2]._id_6E9F.size - 1;
  var_4 = level._id_0075[var_2]._id_6E9F[var_3].size - 1;

  if(!isDefined(level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsound"])) {
    level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsound"] = [];
    level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsoundCause"] = [];
  }

  var_5 = level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsound"].size;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsound"][var_5] = var_0;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v["loopsoundCause"][var_5] = var_1;
}

_id_2DE3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_9 = [];
  var_9["anim"] = var_0;
  var_9["animTree"] = var_1;
  var_9["animType"] = var_2;
  var_9["vehicle_exclude_anim"] = var_3;
  var_9["groupNum"] = var_4;
  var_9["mpAnim"] = var_5;
  var_9["maxStartDelay"] = var_6;
  var_9["animRateMin"] = var_7;
  var_9["animRateMax"] = var_8;
  _id_0901("animation", var_9);
}

_id_2E1A(var_0) {
  var_1 = [];
  var_1["spotlight_tag"] = var_0;
  var_1["spotlight_fx"] = "spotlight_fx";
  var_1["spotlight_brightness"] = 0.85;
  var_1["randomly_flip"] = 1;
  _id_093B(var_1);
}

_id_093A(var_0, var_1) {
  var_2 = [];
  var_2[var_0] = var_1;
  _id_093B(var_2);
}

_id_093B(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;

  foreach(var_6, var_5 in var_0)
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v[var_6] = var_5;
}

_id_0901(var_0, var_1) {
  var_2 = level._id_0075.size - 1;
  var_3 = level._id_0075[var_2]._id_6E9F.size - 1;
  var_4 = level._id_0075[var_2]._id_6E9F[var_3].size - 1;
  var_5 = level._id_0075[var_2]._id_6E9F[var_3][var_4].v;

  if(!isDefined(var_5[var_0]))
    var_5[var_0] = [];

  var_5[var_0][var_5[var_0].size] = var_1;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v = var_5;
}

_id_2DEB() {
  var_0 = level._id_0075.size - 1;
  var_1 = level._id_0075[var_0]._id_6E9F.size - 1;
  var_2 = level._id_0075[var_0]._id_6E9F[var_1].size - 1;
  level._id_0075[var_0]._id_6E9F[var_1][var_2].v["triggerCarAlarm"] = 1;
}

_id_2E09(var_0) {
  if(!isDefined(var_0))
    var_0 = 256;

  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["break_nearby_lights"] = var_0;
}

_id_7A38(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = "";

  var_4 = level._id_0075.size - 1;
  var_5 = level._id_0075[var_4]._id_6E9F.size - 1;
  var_6 = 0;

  if(!isDefined(level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_1"])) {
    level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_1"] = [];
    level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_2"] = [];
    level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_tag"] = [];
  }

  var_7 = level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_1"].size;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_1"][var_7] = var_1;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_2"][var_7] = var_2;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["random_dynamic_attachment_tag"][var_7] = var_0;
  level._id_0075[var_4]._id_6E9F[var_5][var_6].v["clipToRemove"][var_7] = var_3;
}

_id_2E11(var_0, var_1) {
  var_2 = level._id_0075.size - 1;
  var_3 = level._id_0075[var_2]._id_6E9F.size - 1;
  var_4 = level._id_0075[var_2]._id_6E9F[var_3].size - 1;

  if(!isDefined(level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics"])) {
    level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics"] = [];
    level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics_tagName"] = [];
    level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics_velocity"] = [];
  }

  var_5 = level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics"].size;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics"][var_5] = 1;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics_tagName"][var_5] = var_0;
  level._id_0075[var_2]._id_6E9F[var_3][var_4].v["physics_velocity"][var_5] = var_1;
}

_id_2E18(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["splash_damage_scaler"] = var_0;
}

_id_2DF4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = level._id_0075.size - 1;
  var_15 = level._id_0075[var_14]._id_6E9F.size - 1;
  var_16 = level._id_0075[var_14]._id_6E9F[var_15].size - 1;

  if(common_scripts\utility::issp())
    level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_range"] = var_2;
  else
    level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_range"] = var_3;

  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode"] = 1;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_force_min"] = var_0;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_force_max"] = var_1;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_mindamage"] = var_4;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_maxdamage"] = var_5;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["continueDamage"] = var_6;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["originOffset"] = var_7;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["earthQuakeScale"] = var_8;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["earthQuakeRadius"] = var_9;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["originOffset3d"] = var_10;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["delaytime"] = var_11;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_angularImpulse_min"] = var_12;
  level._id_0075[var_14]._id_6E9F[var_15][var_16].v["explode_angularImpulse_max"] = var_13;
}

_id_2DF9(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["function"] = var_0;
}

_id_2E0E(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["functionNotify"] = var_0;
}

_id_2DF0(var_0) {
  var_1 = level._id_0075.size - 1;
  var_2 = level._id_0075[var_1]._id_6E9F.size - 1;
  var_3 = level._id_0075[var_1]._id_6E9F[var_2].size - 1;
  level._id_0075[var_1]._id_6E9F[var_2][var_3].v["damage_threshold"] = var_0;
}

_id_2DE5(var_0, var_1) {
  var_1 = _tolower(var_1);
  var_2 = level._id_0075.size - 1;

  if(!isDefined(level._id_0075[var_2]._id_1145))
    level._id_0075[var_2]._id_1145 = [];

  var_3 = spawnStruct();
  var_3.model = var_1;
  var_3._id_95A6 = var_0;
  level._id_0075[var_2]._id_1145[level._id_0075[var_2]._id_1145.size] = var_3;
}

_id_2E08(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_3))
    var_3 = _tolower(var_3);

  var_13 = level._id_0075.size - 1;
  level._id_0075[var_13]._id_6E9F[var_0][var_1] = spawnStruct();
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["modelName"] = var_3;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["tagName"] = var_2;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["health"] = var_4;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["validAttackers"] = var_5;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["validDamageZone"] = var_6;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["validDamageCause"] = var_7;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["alsoDamageParent"] = var_8;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["physicsOnExplosion"] = var_9;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["grenadeImpactDeath"] = var_10;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["godModeAllowed"] = 0;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["splashRotation"] = var_11;
  level._id_0075[var_13]._id_6E9F[var_0][var_1].v["receiveDamageFromParent"] = var_12;
}

_id_7643() {
  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    return;
  }
  if(isDefined(level._id_0075[self._id_2E25]._id_1145)) {
    foreach(var_1 in level._id_0075[self._id_2E25]._id_1145)
    precachemodel(var_1.model);
  }

  for(var_3 = 0; var_3 < level._id_0075[self._id_2E25]._id_6E9F.size; var_3++) {
    for(var_4 = 0; var_4 < level._id_0075[self._id_2E25]._id_6E9F[var_3].size; var_4++) {
      if(level._id_0075[self._id_2E25]._id_6E9F[var_3].size <= var_4) {
        continue;
      }
      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["modelName"]))
        precachemodel(level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["modelName"]);

      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["animation"])) {
        var_5 = level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["animation"];

        foreach(var_7 in var_5) {
          if(isDefined(var_7["mpAnim"]))
            common_scripts\utility::_id_6756("precacheMpAnim", var_7["mpAnim"]);
        }
      }

      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["random_dynamic_attachment_1"])) {
        foreach(var_10 in level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["random_dynamic_attachment_1"]) {
          if(isDefined(var_10) && var_10 != "") {
            precachemodel(var_10);
            precachemodel(var_10 + "_destroy");
          }
        }

        foreach(var_10 in level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["random_dynamic_attachment_2"]) {
          if(isDefined(var_10) && var_10 != "") {
            precachemodel(var_10);
            precachemodel(var_10 + "_destroy");
          }
        }
      }
    }
  }
}

_id_091C() {
  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    return;
  }
  for(var_0 = 0; var_0 < level._id_0075[self._id_2E25]._id_6E9F.size; var_0++) {
    for(var_1 = 0; var_1 < level._id_0075[self._id_2E25]._id_6E9F[var_0].size; var_1++) {
      if(level._id_0075[self._id_2E25]._id_6E9F[var_0].size <= var_1) {
        continue;
      }
      var_2 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1];

      if(isDefined(var_2.v["fx_filename"])) {
        for(var_3 = 0; var_3 < var_2.v["fx_filename"].size; var_3++) {
          var_4 = var_2.v["fx_filename"][var_3];
          var_5 = var_2.v["fx_tag"][var_3];

          if(isDefined(var_4)) {
            if(isDefined(var_2.v["fx"]) && isDefined(var_2.v["fx"][var_3]) && var_2.v["fx"][var_3].size == var_4.size) {
              continue;
            }
            for(var_6 = 0; var_6 < var_4.size; var_6++) {
              var_7 = var_4[var_6];
              var_8 = var_5[var_6];
              level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["fx"][var_3][var_6] = loadfx(var_7, var_8);
            }
          }
        }
      }

      var_9 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["loopfx_filename"];
      var_10 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["loopfx_tag"];

      if(isDefined(var_9)) {
        if(isDefined(var_2.v["loopfx"]) && var_2.v["loopfx"].size == var_9.size) {
          continue;
        }
        for(var_6 = 0; var_6 < var_9.size; var_6++) {
          var_11 = var_9[var_6];
          var_12 = var_10[var_6];
          level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["loopfx"][var_6] = loadfx(var_11, var_12);
        }
      }
    }
  }
}

_id_1F4B(var_0) {
  foreach(var_2 in self._id_2E27) {
    if(var_2 == var_0)
      return 1;
  }

  return 0;
}

_id_2E1D() {
  var_0 = 0;
  var_1 = self.model;
  var_2 = undefined;
  var_3 = self.origin;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self.model;
  _id_2E1F(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  self endon("stop_taking_damage");

  for(;;) {
    var_0 = undefined;
    var_5 = undefined;
    var_4 = undefined;
    var_3 = undefined;
    var_8 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    self waittill("damage", var_0, var_5, var_4, var_3, var_8, var_1, var_2, var_9, var_10);

    if(!isDefined(var_0)) {
      continue;
    }
    if(isDefined(var_5) && isDefined(var_5.type) && var_5.type == "soft_landing" && !var_5 _id_1F4B(self)) {
      continue;
    }
    if(common_scripts\utility::issp())
      var_0 = var_0 * 0.5;
    else
      var_0 = var_0 * 1.0;

    if(var_0 <= 0) {
      continue;
    }
    if(common_scripts\utility::issp()) {
      if(isDefined(var_5) && isPlayer(var_5))
        self._id_29D4 = var_5;
    } else if(isDefined(var_5) && isPlayer(var_5))
      self._id_29D4 = var_5;
    else if(isDefined(var_5) && isDefined(var_5._id_48EA) && isPlayer(var_5._id_48EA))
      self._id_29D4 = var_5._id_48EA;

    var_8 = _id_4487(var_8);

    if(_id_5609(var_5, var_8)) {
      if(common_scripts\utility::issp())
        var_0 = var_0 * 8.0;
      else
        var_0 = var_0 * 4.0;
    }

    if(!isDefined(var_1) || var_1 == "")
      var_1 = self.model;

    if(isDefined(var_2) && var_2 == "") {
      if(isDefined(var_9) && var_9 != "" && var_9 != "tag_body" && var_9 != "body_animate_jnt")
        var_2 = var_9;
      else
        var_2 = undefined;

      var_11 = level._id_0075[self._id_2E25]._id_6E9F[0][0].v["tagName"];

      if(isDefined(var_11) && isDefined(var_9) && var_11 == var_9)
        var_2 = undefined;
    }

    if(var_8 == "splash" || var_8 == "energy") {
      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[0][0].v["splash_damage_scaler"]))
        var_0 = var_0 * level._id_0075[self._id_2E25]._id_6E9F[0][0].v["splash_damage_scaler"];
      else if(common_scripts\utility::issp())
        var_0 = var_0 * 9.0;
      else
        var_0 = var_0 * 13.0;

      if(var_7 == self.model && isDefined(self.nearclaimnodeandangle))
        self setModel(self.nearclaimnodeandangle);

      _id_2E17(int(var_0), var_3, var_4, var_5, var_8);
      continue;
    }

    thread _id_2E1F(int(var_0), var_1, var_2, var_3, var_4, var_5, var_8);
  }
}

_id_5609(var_0, var_1) {
  if(var_1 != "bullet")
    return 0;

  if(!isDefined(var_0))
    return 0;

  var_2 = undefined;

  if(isPlayer(var_0))
    var_2 = var_0 getcurrentweapon();
  else if(isDefined(level._id_3603) && level._id_3603) {
    if(isDefined(var_0._id_01D0))
      var_2 = var_0._id_01D0;
  }

  if(!isDefined(var_2))
    return 0;

  var_3 = weaponclass(var_2);

  if(isDefined(var_3) && var_3 == "spread")
    return 1;

  return 0;
}

_id_45FD(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.v = [];
  var_3 = -1;
  var_4 = -1;

  if(_tolower(var_0) == _tolower(self.model) && !isDefined(var_1)) {
    var_0 = self.model;
    var_1 = undefined;
    var_3 = 0;
    var_4 = 0;
  }

  for(var_5 = 0; var_5 < level._id_0075[self._id_2E25]._id_6E9F.size; var_5++) {
    var_4 = self._id_2E10[var_5].v["currentState"];

    if(level._id_0075[self._id_2E25]._id_6E9F[var_5].size <= var_4) {
      continue;
    }
    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_5][var_4].v["tagName"])) {
      var_6 = level._id_0075[self._id_2E25]._id_6E9F[var_5][var_4].v["tagName"];

      if(_tolower(var_6) == _tolower(var_1)) {
        var_3 = var_5;
        break;
      }
    }
  }

  var_2.v["stateIndex"] = var_4;
  var_2.v["partIndex"] = var_3;
  return var_2;
}

_id_2E1F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(self._id_2E10)) {
    return;
  }
  if(self._id_2E10.size == 0) {
    return;
  }
  if(level._id_3A53)
    self endon("destroyed");

  var_8 = _id_45FD(var_1, var_2);
  var_9 = var_8.v["stateIndex"];
  var_10 = var_8.v["partIndex"];

  if(var_10 < 0) {
    return;
  }
  var_11 = var_9;
  var_12 = 0;
  var_13 = 0;

  for(;;) {
    var_9 = self._id_2E10[var_10].v["currentState"];

    if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9])) {
      break;
    }

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][0].v["alsoDamageParent"])) {
      if(_id_4487(var_6) != "splash") {
        var_14 = level._id_0075[self._id_2E25]._id_6E9F[var_10][0].v["alsoDamageParent"];
        var_15 = int(var_0 * var_14);
        thread _id_6807(var_15, var_5, var_4, var_3, var_6, "", "");
      }
    }

    if(var_10 == 0 && _id_4487(var_6) != "splash") {
      for(var_16 = 0; var_16 < level._id_0075[self._id_2E25]._id_6E9F.size; var_16++) {
        var_17 = level._id_0075[self._id_2E25]._id_6E9F[var_16];

        if(!isDefined(var_17[0].v["receiveDamageFromParent"])) {
          continue;
        }
        var_18 = 0;

        if(isDefined(self._id_2E10[var_16].v["currentState"]))
          var_18 = self._id_2E10[var_16].v["currentState"];

        if(!isDefined(var_17[var_18])) {
          continue;
        }
        if(!isDefined(var_17[var_18].v["tagName"])) {
          continue;
        }
        var_19 = var_17[var_18].v["tagName"];
        var_14 = var_17[0].v["receiveDamageFromParent"];
        var_20 = int(var_0 * var_14);
        thread _id_6807(var_20, var_5, var_4, var_3, var_6, "", var_19);
      }
    }

    if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v["health"])) {
      break;
    }

    if(!isDefined(self._id_2E10[var_10].v["health"])) {
      break;
    }

    if(var_12)
      self._id_2E10[var_10].v["health"] = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v["health"];

    var_12 = 0;

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v["grenadeImpactDeath"]) && var_6 == "impact")
      var_0 = 100000000;

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v["damage_threshold"]) && level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v["damage_threshold"] > var_0)
      var_0 = 0;

    var_21 = self._id_2E10[var_10].v["health"];
    var_22 = _id_567E(var_10, var_9, var_5);

    if(var_22) {
      var_23 = _id_5825(var_10, var_9, var_6);

      if(var_23) {
        if(isDefined(var_5)) {
          if(isPlayer(var_5))
            self._id_724D = self._id_724D + var_0;
          else if(var_5 != self)
            self._id_6727 = self._id_6727 + var_0;
        }

        if(isDefined(var_6)) {
          if(var_6 == "melee" || var_6 == "impact")
            var_0 = 100000;
        }

        self._id_2E10[var_10].v["health"] = self._id_2E10[var_10].v["health"] - var_0;
      }
    }

    if(self._id_2E10[var_10].v["health"] > 0) {
      return;
    }
    if(isDefined(var_7)) {
      var_7.v["fxcost"] = _id_4283(var_10, self._id_2E10[var_10].v["currentState"]);
      _id_091D(self, var_7, var_0);

      if(!isDefined(self._id_A6E7))
        self._id_A6E7 = 1;
      else
        self._id_A6E7++;

      self waittill("queue_processed", var_24);
      self._id_A6E7--;

      if(self._id_A6E7 == 0)
        self._id_A6E7 = undefined;

      if(!var_24) {
        self._id_2E10[var_10].v["health"] = var_21;
        return;
      }
    }

    var_0 = int(_abs(self._id_2E10[var_10].v["health"]));

    if(var_0 < 0) {
      return;
    }
    self._id_2E10[var_10].v["currentState"]++;
    var_9 = self._id_2E10[var_10].v["currentState"];
    var_25 = var_9 - 1;
    var_26 = undefined;

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25]))
      var_26 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v;

    var_27 = undefined;

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9]))
      var_27 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9].v;

    if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25])) {
      return;
    }
    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode"]))
      self._id_3949 = 1;

    if(isDefined(self._id_5EFB) && isDefined(self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)])) {
      for(var_16 = 0; var_16 < self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)].size; var_16++) {
        self notify(self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)][var_16]);

        if(common_scripts\utility::issp() && self._id_6297)
          self._id_6296 notify(self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)][var_16]);
      }

      self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)] = undefined;
    }

    if(isDefined(var_26["break_nearby_lights"]))
      _id_2E01(var_26["break_nearby_lights"]);

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_9])) {
      if(var_10 == 0) {
        var_28 = var_27["modelName"];

        if(isDefined(var_28) && var_28 != self.model) {
          self setModel(var_28);

          if(common_scripts\utility::issp() && self._id_6297)
            self._id_6296 setModel(var_28);

          _id_2E19(var_27);
        }
      } else {
        _id_4D03(var_2);

        if(common_scripts\utility::issp() && self._id_6297)
          self._id_6296 _id_4D03(var_2);

        var_2 = var_27["tagName"];

        if(isDefined(var_2)) {
          _id_8BED(var_2);

          if(common_scripts\utility::issp() && self._id_6297)
            self._id_6296 _id_8BED(var_2);
        }
      }
    }

    var_29 = _id_4168();

    if(isDefined(self._id_3949))
      _id_23A2(var_29);

    var_30 = _id_2DE4(var_26, var_29, var_6, var_10);
    var_30 = _id_2E00(var_26, var_29, var_6, var_10, var_30);
    self notify("FX_State_Change_Kill" + var_10);
    var_30 = _id_2E16(var_26, var_29, var_6, var_30);

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopfx"])) {
      var_31 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopfx_filename"].size;

      if(var_31 > 0)
        self notify("FX_State_Change" + var_10);

      for(var_32 = 0; var_32 < var_31; var_32++) {
        var_33 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopfx"][var_32];
        var_34 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopfx_tag"][var_32];
        var_35 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopfx_rate"][var_32];
        thread _id_5EEF(var_33, var_34, var_35, var_10);
      }
    }

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopsound"])) {
      for(var_16 = 0; var_16 < level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopsound"].size; var_16++) {
        var_36 = _id_583B("loopsoundCause", var_26, var_16, var_6);

        if(var_36) {
          var_37 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["loopsound"][var_16];
          var_38 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["tagName"];
          thread _id_7152(var_37, var_38);

          if(!isDefined(self._id_5EFB))
            self._id_5EFB = [];

          if(!isDefined(self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)]))
            self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)] = [];

          var_39 = self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)].size;
          self._id_5EFB[common_scripts\utility::_id_9AAD(var_10)][var_39] = "stop sound" + var_37;
        }
      }
    }

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["triggerCarAlarm"]))
      thread _id_3097();

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["break_nearby_lights"]))
      thread _id_1BA6();

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["healthdrain_amount"])) {
      self notify("Health_Drain_State_Change" + var_10);
      var_40 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["healthdrain_amount"];
      var_41 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["healthdrain_interval"];
      var_42 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["modelName"];
      var_43 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["tagName"];
      var_44 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["badplace_radius"];
      var_45 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["badplace_team"];

      if(var_40 > 0)
        thread _id_4C08(var_40, var_41, var_10, var_42, var_43, var_44, var_45);
    }

    var_46 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["dot"];

    if(isDefined(var_46)) {
      foreach(var_48 in var_46) {
        var_49 = var_48._id_00D4;

        if(var_48.type == "predefined" && isDefined(var_49)) {
          var_50 = [];

          foreach(var_52 in level._id_0075[self._id_2E25]._id_2DF3[var_49]) {
            var_53 = var_52["classname"];
            var_54 = undefined;

            switch (var_53) {
              case "trigger_radius":
                var_55 = var_52["origin"];
                var_56 = var_52["spawnflags"];
                var_57 = var_52["radius"];
                var_58 = var_52["height"];
                var_54 = _id_27E3(self.origin + var_55, var_56, var_57, var_58);
                var_54._id_99C1 = var_48._id_99C1;
                var_50[var_50.size] = var_54;
                break;
              default:
            }
          }

          level thread _id_92C7(var_50);
          continue;
        }

        if(isDefined(var_48)) {
          if(isDefined(var_48._id_95A6))
            var_48 _id_866B(self gettagorigin(var_48._id_95A6));

          level thread _id_92C7([var_48]);
        }
      }

      var_46 = undefined;
    }

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode"])) {
      var_13 = 1;
      var_61 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_force_min"];
      var_62 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_force_max"];
      var_63 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_angularImpulse_min"];
      var_64 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_angularImpulse_max"];
      var_65 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_range"];
      var_66 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_mindamage"];
      var_67 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["explode_maxdamage"];
      var_68 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["continueDamage"];
      var_69 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["originOffset"];
      var_70 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["earthQuakeScale"];
      var_71 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["earthQuakeRadius"];
      var_72 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["originOffset3d"];
      var_73 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["delaytime"];

      if(isDefined(var_5) && var_5 != self) {
        self._id_1180 = var_5;

        if(self._id_003B == "script_vehicle")
          self._id_29B2 = var_6;
      }

      thread _id_3923(var_10, var_61, var_62, var_65, var_66, var_67, var_68, var_69, var_70, var_71, var_5, var_72, var_73, var_63, var_64);
    }

    var_74 = undefined;

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["physics"])) {
      for(var_16 = 0; var_16 < level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["physics"].size; var_16++) {
        var_74 = undefined;
        var_75 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["physics_tagName"][var_16];
        var_76 = level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["physics_velocity"][var_16];
        var_77 = undefined;

        if(isDefined(var_76)) {
          var_78 = undefined;

          if(isDefined(var_75))
            var_78 = self gettagangles(var_75);
          else if(isDefined(var_2))
            var_78 = self gettagangles(var_2);

          var_74 = undefined;

          if(isDefined(var_75))
            var_74 = self gettagorigin(var_75);
          else if(isDefined(var_2))
            var_74 = self gettagorigin(var_2);

          var_79 = var_76[0] - 5 + _randomfloat(10);
          var_80 = var_76[1] - 5 + _randomfloat(10);
          var_81 = var_76[2] - 5 + _randomfloat(10);
          var_82 = anglesToForward(var_78) * var_79 * _randomfloatrange(80, 110);
          var_83 = anglestoright(var_78) * var_80 * _randomfloatrange(80, 110);
          var_84 = anglestoup(var_78) * var_81 * _randomfloatrange(80, 110);
          var_77 = var_82 + var_83 + var_84;
        } else {
          var_77 = var_3;
          var_85 = (0, 0, 0);

          if(isDefined(var_5)) {
            var_85 = var_5.origin;
            var_77 = vectorNormalize(var_3 - var_85);
            var_77 = var_77 * 200;
          }
        }

        if(isDefined(var_75)) {
          var_86 = undefined;

          for(var_87 = 0; var_87 < level._id_0075[self._id_2E25]._id_6E9F.size; var_87++) {
            if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_87][0].v["tagName"])) {
              continue;
            }
            if(level._id_0075[self._id_2E25]._id_6E9F[var_87][0].v["tagName"] != var_75) {
              continue;
            }
            var_86 = var_87;
            break;
          }

          if(isDefined(var_74))
            thread _id_6FA3(var_86, 0, var_74, var_77);
          else
            thread _id_6FA3(var_86, 0, var_3, var_77);

          continue;
        }

        if(isDefined(var_74))
          thread _id_6FA3(var_10, var_25, var_74, var_77);
        else
          thread _id_6FA3(var_10, var_25, var_3, var_77);

        return;
      }
    }

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v) && isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["functionNotify"]))
      self notify(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["functionNotify"]);

    if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["function"]))
      self thread[[level._id_0075[self._id_2E25]._id_6E9F[var_10][var_25].v["function"]]]();

    var_12 = 1;
  }
}

_id_2E19(var_0) {
  var_1 = var_0["splashRotation"];
  var_2 = var_0["rotateTo"];

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!var_1) {
    return;
  }
  self.angles = (self.angles[0], var_2[1], self.angles[2]);
}

_id_29A7(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = strtok("splash melee bullet splash impact unknown", " ");
  var_3 = "";

  foreach(var_6, var_5 in var_1)
  var_2 = common_scripts\utility::_id_0F93(var_2, var_5);

  foreach(var_8 in var_2)
  var_3 = var_3 + (var_8 + " ");

  return var_3;
}

_id_2E17(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 <= 0) {
    return;
  }
  if(isDefined(self._id_3928)) {
    return;
  }
  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    return;
  }
  var_5 = _id_440C(var_2);

  if(var_5.size <= 0) {
    return;
  }
  var_5 = _id_8666(var_5, var_1);
  var_6 = _id_456B(var_5);

  foreach(var_8 in var_5) {
    var_9 = var_8.v["distance"] * 1.4;
    var_10 = var_0 - (var_9 - var_6);

    if(var_10 <= 0) {
      continue;
    }
    if(isDefined(self._id_3928)) {
      continue;
    }
    thread _id_2E1F(var_10, var_8.v["modelName"], var_8.v["tagName"], var_1, var_2, var_3, var_4, var_8);
  }
}

_id_440C(var_0) {
  var_1 = [];

  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F))
    return var_1;

  for(var_2 = 0; var_2 < level._id_0075[self._id_2E25]._id_6E9F.size; var_2++) {
    var_3 = var_2;
    var_4 = self._id_2E10[var_3].v["currentState"];

    for(var_5 = 0; var_5 < level._id_0075[self._id_2E25]._id_6E9F[var_3].size; var_5++) {
      var_6 = level._id_0075[self._id_2E25]._id_6E9F[var_3][var_5].v["splashRotation"];

      if(isDefined(var_6) && var_6) {
        var_7 = vectortoangles(var_0);
        var_8 = var_7[1] - 90;
        level._id_0075[self._id_2E25]._id_6E9F[var_3][var_5].v["rotateTo"] = (0, var_8, 0);
      }
    }

    if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4])) {
      continue;
    }
    var_9 = level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["tagName"];

    if(!isDefined(var_9))
      var_9 = "";

    if(var_9 == "") {
      continue;
    }
    var_10 = level._id_0075[self._id_2E25]._id_6E9F[var_3][var_4].v["modelName"];

    if(!isDefined(var_10))
      var_10 = "";

    var_11 = var_1.size;
    var_1[var_11] = spawnStruct();
    var_1[var_11].v["modelName"] = var_10;
    var_1[var_11].v["tagName"] = var_9;
  }

  return var_1;
}

_id_8666(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = distance(var_1, self gettagorigin(var_0[var_2].v["tagName"]));
    var_0[var_2].v["distance"] = var_3;
  }

  return var_0;
}

_id_456B(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    var_4 = var_3.v["distance"];

    if(!isDefined(var_1))
      var_1 = var_4;

    if(var_4 < var_1)
      var_1 = var_4;
  }

  return var_1;
}

_id_583B(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4))
    var_5 = var_1[var_0][var_4][var_2];
  else
    var_5 = var_1[var_0][var_2];

  if(!isDefined(var_5))
    return 1;

  if(var_5 == var_3)
    return 1;

  return 0;
}

_id_567E(var_0, var_1, var_2) {
  if(isDefined(self._id_3E1B))
    return 1;

  if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["explode"])) {
    if(isDefined(self._id_323D))
      return 0;
  }

  if(!isDefined(var_2))
    return 1;

  if(var_2 == self)
    return 1;

  var_3 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["validAttackers"];

  if(!isDefined(var_3))
    return 1;

  if(var_3 == "no_player") {
    if(!isPlayer(var_2))
      return 1;

    if(!isDefined(var_2._id_29CF))
      return 1;

    if(var_2._id_29CF == 0)
      return 1;
  } else if(var_3 == "player_only") {
    if(isPlayer(var_2))
      return 1;

    if(isDefined(var_2._id_29CF) && var_2._id_29CF)
      return 1;
  } else if(var_3 == "no_ai" && isDefined(level._id_5665)) {
    if(![[level._id_5665]](var_2))
      return 1;
  } else if(var_3 == "ai_only" && isDefined(level._id_5665)) {
    if([[level._id_5665]](var_2))
      return 1;
  } else {}

  return 0;
}

_id_5825(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    return 1;

  var_3 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["godModeAllowed"];

  if(var_3 && (isDefined(self._id_480F) && self._id_480F || isDefined(self.setconvergenceheightpercent) && self.setconvergenceheightpercent && var_2 == "bullet"))
    return 0;

  var_4 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["validDamageCause"];

  if(!isDefined(var_4))
    return 1;

  if(var_4 == "splash" && var_2 != "splash")
    return 0;

  if(var_4 == "no_splash" && var_2 == "splash")
    return 0;

  if(var_4 == "no_melee" && var_2 == "melee" || var_2 == "impact")
    return 0;

  if(var_4 == "bullet" && var_2 != "bullet")
    return 0;

  return 1;
}

_id_4487(var_0) {
  if(!isDefined(var_0))
    return "unknown";

  var_0 = _tolower(var_0);

  switch (var_0) {
    case "mod_crush":
    case "mod_melee":
    case "melee":
      return "melee";
    case "mod_rifle_bullet":
    case "mod_pistol_bullet":
    case "bullet":
      return "bullet";
    case "mod_explosive":
    case "mod_projectile_splash":
    case "mod_projectile":
    case "mod_grenade_splash":
    case "mod_grenade":
    case "splash":
      return "splash";
    case "mod_impact":
      return "impact";
    case "mod_energy":
      return "energy";
    case "unknown":
      return "unknown";
    default:
      return "unknown";
  }
}

_id_29A6(var_0, var_1, var_2) {
  self notify("stop_damage_mirror");
  self endon("stop_damage_mirror");
  var_0 endon("stop_taking_damage");
  self setcandamage(1);

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);
    var_0 notify("damage", var_3, var_4, var_5, var_6, var_7, var_1, var_2);
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
  }
}

_id_0914() {
  self._id_724D = 0;
  self._id_6727 = 0;
  self._id_1FCF = 1;
}

_id_5EEF(var_0, var_1, var_2, var_3) {
  self endon("FX_State_Change" + var_3);
  self endon("delete_destructible");
  level endon("putout_fires");

  while(isDefined(self)) {
    var_4 = _id_4168();
    _playfxontag(var_0, var_4, var_1);
    wait(var_2);
  }
}

_id_4C08(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("Health_Drain_State_Change" + var_2);
  level endon("putout_fires");
  self endon("destroyed");

  if(isDefined(var_5) && isDefined(level._id_2DE6))
    var_5 = var_5 * level._id_2DE6;

  if(isDefined(var_0) && isDefined(level._id_2E06))
    var_0 = var_0 * level._id_2E06;

  wait(var_1);
  self._id_4C18 = 1;
  var_7 = undefined;

  if(isDefined(level._id_2F30) && level._id_2F30)
    var_5 = undefined;

  if(isDefined(var_5) && isDefined(level._id_14F6)) {
    var_7 = "" + gettime();

    if(!isDefined(self._id_2F71)) {
      if(isDefined(self.scriptmodelplayanim))
        var_5 = self.scriptmodelplayanim;

      if(common_scripts\utility::issp() && isDefined(var_6)) {
        if(var_6 == "both")
          call[[level._id_14F6]](var_7, 0, self.origin, var_5, 128, "allies", "bad_guys");
        else
          call[[level._id_14F6]](var_7, 0, self.origin, var_5, 128, var_6);

        thread _id_14F8(var_7);
      } else {
        call[[level._id_14F6]](var_7, 0, self.origin, var_5, 128);
        thread _id_14F8(var_7);
      }
    }
  }

  while(isDefined(self) && self._id_2E10[var_2].v["health"] > 0) {
    self notify("damage", var_0, self, (0, 0, 0), (0, 0, 0), "MOD_UNKNOWN", var_3, var_4);
    wait(var_1);
  }

  self notify("remove_badplace");
}

_id_14F8(var_0) {
  common_scripts\utility::_id_A70A("destroyed", "remove_badplace");
  call[[level._id_14F7]](var_0);
}

_id_6FA3(var_0, var_1, var_2, var_3) {
  var_4 = _id_6FA6(var_0, var_1);
  var_4 physicslaunchclient(var_2, var_3);
}

_id_6FA4(var_0, var_1, var_2, var_3) {
  var_4 = _id_6FA6(var_0, var_1);
  var_4 physicslaunchclientwithimpulse(var_2, var_3);
}

_id_6FA6(var_0, var_1) {
  var_2 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["modelName"];
  var_3 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v["tagName"];
  _id_4D03(var_3);

  if(level._id_2E29.size >= level._id_2E2A)
    _id_6FA7(level._id_2E29[0]);

  var_4 = spawn("script_model", self gettagorigin(var_3));
  var_4.angles = self gettagangles(var_3);
  var_4 setModel(var_2);
  level._id_2E29[level._id_2E29.size] = var_4;
  return var_4;
}

_id_6FA7(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level._id_2E29.size; var_2++) {
    if(level._id_2E29[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level._id_2E29[var_2];
  }

  level._id_2E29 = var_1;

  if(isDefined(var_0))
    var_0 delete();
}

_id_3923(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(isDefined(var_3) && isDefined(level._id_2DF5))
    var_3 = var_3 * level._id_2DF5;

  if(!isDefined(var_7))
    var_7 = 80;

  if(!isDefined(var_11))
    var_11 = (0, 0, 0);

  if(!isDefined(var_6) || isDefined(var_6) && !var_6) {
    if(isDefined(self._id_3928)) {
      return;
    }
    self._id_3928 = 1;
  }

  if(!isDefined(var_12))
    var_12 = 0;

  self notify("exploded", var_10);
  level notify("destructible_exploded", self, var_10);

  if(self._id_003B == "script_vehicle")
    self notify("death", var_10, self._id_29B2);

  if(common_scripts\utility::issp())
    thread _id_2FC6();

  if(!level._id_3A53)
    waitframe();

  if(!isDefined(self)) {
    return;
  }
  var_15 = self._id_2E10[var_0].v["currentState"];
  var_16 = undefined;

  if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_0][var_15]))
    var_16 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_15].v["tagName"];

  if(isDefined(var_16))
    var_17 = self gettagorigin(var_16);
  else
    var_17 = self.origin;

  self notify("damage", var_5, self, (0, 0, 0), var_17, "MOD_EXPLOSIVE", "", "");
  self notify("stop_car_alarm");
  waittillframeend;

  if(isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    for(var_18 = level._id_0075[self._id_2E25]._id_6E9F.size - 1; var_18 >= 0; var_18--) {
      if(var_18 == var_0) {
        continue;
      }
      var_19 = self._id_2E10[var_18].v["currentState"];

      if(var_19 >= level._id_0075[self._id_2E25]._id_6E9F[var_18].size)
        var_19 = level._id_0075[self._id_2E25]._id_6E9F[var_18].size - 1;

      var_20 = level._id_0075[self._id_2E25]._id_6E9F[var_18][var_19].v["modelName"];
      var_16 = level._id_0075[self._id_2E25]._id_6E9F[var_18][var_19].v["tagName"];

      if(!isDefined(var_20)) {
        continue;
      }
      if(!isDefined(var_16)) {
        continue;
      }
      var_21 = 0;

      if(isDefined(self._id_2E10[var_18].v["health"]))
        var_21 = self._id_2E10[var_18].v["health"];

      var_22 = 0;

      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_18][var_19].v["health"]))
        var_22 = level._id_0075[self._id_2E25]._id_6E9F[var_18][var_19].v["health"];

      if(var_22 > 0 && var_21 <= 0) {
        continue;
      }
      if(isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_18][0].v["physicsOnExplosion"])) {
        if(level._id_0075[self._id_2E25]._id_6E9F[var_18][0].v["physicsOnExplosion"] > 0) {
          var_23 = level._id_0075[self._id_2E25]._id_6E9F[var_18][0].v["physicsOnExplosion"];
          var_24 = self gettagorigin(var_16);
          var_25 = vectorNormalize(var_24 - var_17);
          var_25 = var_25 * (_randomfloatrange(var_1, var_2) * var_23);

          if(isDefined(var_13) && isDefined(var_14)) {
            var_26 = common_scripts\utility::_id_7A61(var_13, var_14);
            thread _id_6FA4(var_18, var_19, var_25, var_26);
          } else
            thread _id_6FA3(var_18, var_19, var_24, var_25);

          continue;
        }
      }
    }
  }

  var_27 = !isDefined(var_6) || isDefined(var_6) && !var_6;

  if(var_27)
    self notify("stop_taking_damage");

  if(!level._id_3A53)
    waitframe();

  if(!isDefined(self)) {
    return;
  }
  var_28 = var_17 + (0, 0, var_7) + var_11;
  var_29 = getsubstr(level._id_0075[self._id_2E25].v["type"], 0, 7) == "vehicle";

  if(var_29) {
    anim._id_5B7D = gettime();
    anim._id_5B7A = var_28;
    anim._id_5B7B = var_17;
    anim._id_5B7C = var_3;
  }

  level thread _id_846F(1);

  if(var_12 > 0)
    wait(var_12);

  if(isDefined(level._id_2E12))
    thread[[level._id_2E12]]();

  if(common_scripts\utility::issp()) {
    if(level._id_3FD4 == 0 && !_id_7381())
      self radiusdamage(var_28, var_3, var_5, var_4, self, "MOD_RIFLE_BULLET");
    else
      self radiusdamage(var_28, var_3, var_5, var_4, self);

    if(isDefined(self._id_29D4) && var_29) {
      self._id_29D4 notify("destroyed_car");
      level notify("player_destroyed_car", self._id_29D4, var_28);
    }
  } else {
    var_30 = "destructible_toy";

    if(var_29)
      var_30 = "destructible_car";

    if(!isDefined(self._id_29D4))
      self radiusdamage(var_28, var_3, var_5, var_4, self, "MOD_EXPLOSIVE", var_30);
    else {
      self radiusdamage(var_28, var_3, var_5, var_4, self._id_29D4, "MOD_EXPLOSIVE", var_30);

      if(var_29) {
        self._id_29D4 notify("destroyed_car");
        level notify("player_destroyed_car", self._id_29D4, var_28);
      }
    }
  }

  if(isDefined(var_8) && isDefined(var_9))
    _earthquake(var_8, 2.0, var_28, var_9);

  level thread _id_846F(0, 0.05);
  var_31 = 0.01;
  var_32 = var_3 * var_31;
  var_3 = var_3 * 0.99;
  _physicsexplosionsphere(var_17, var_3, 0, var_32);

  if(var_27) {
    self setcandamage(0);
    thread _id_2398();
  }

  self notify("destroyed");
}

_id_2398() {
  waitframe();

  while(isDefined(self) && isDefined(self._id_A6E7)) {
    self waittill("queue_processed");
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }
  self._id_0ED4 = undefined;
  self._id_1180 = undefined;
  self._id_1FCF = undefined;
  self._id_1FD9 = undefined;
  self._id_29D4 = undefined;
  self._id_2E10 = undefined;
  self._id_0075 = undefined;
  self._id_2E25 = undefined;
  self._id_4C18 = undefined;
  self._id_6727 = undefined;
  self._id_724D = undefined;

  if(!isDefined(level._id_2DEC)) {
    return;
  }
  self.setjitterparams = undefined;
  self._id_3949 = undefined;
  self._id_5EFB = undefined;
  self._id_1FC7 = undefined;
}

_id_846F(var_0, var_1) {
  level notify("set_disable_friendlyfire_value_delayed");
  level endon("set_disable_friendlyfire_value_delayed");

  if(isDefined(var_1))
    wait(var_1);

  level._id_3ECF = var_0;
}

_id_258B() {
  var_0 = _id_4391();

  if(!isDefined(var_0)) {
    return;
  }
  var_0 call[[level._id_2587]]();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

_id_2FC6() {
  var_0 = _id_4391();

  if(!isDefined(var_0)) {
    return;
  }
  var_0.origin = var_0.origin + (0, 0, 10000);
  var_0 call[[level._id_2FC3]]();
  var_0.origin = var_0.origin - (0, 0, 10000);
}

_id_4391() {
  if(!isDefined(self.target))
    return undefined;

  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(_isspawner(var_2)) {
      continue;
    }
    if(isDefined(var_2.getenemyinfo)) {
      continue;
    }
    if(var_2._id_003B == "light") {
      continue;
    }
    if(!var_2.spawnflags & 1) {
      continue;
    }
    return var_2;
  }
}

_id_4D03(var_0) {
  self hidepart(var_0);
}

_id_8BED(var_0) {
  self showpart(var_0);
}

_id_2F37() {
  self._id_323D = 1;
}

_id_3DED() {
  self._id_323D = undefined;
  self._id_3E1B = 1;
  self notify("damage", 100000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "");
}

_id_4168() {
  if(!common_scripts\utility::issp())
    return self;

  if(self._id_6297)
    var_0 = self._id_6296;
  else
    var_0 = self;

  return var_0;
}

_id_7152(var_0, var_1) {
  var_2 = _id_4168();
  var_3 = spawn("script_origin", (0, 0, 0));

  if(isDefined(var_1))
    var_3.origin = var_2 gettagorigin(var_1);
  else
    var_3.origin = var_2.origin;

  var_3 playloopsound(var_0);
  var_2 thread _id_3E01(var_0);
  var_2 waittill("stop sound" + var_0);

  if(!isDefined(var_3)) {
    return;
  }
  var_3 stoploopsound(var_0);
  var_3 delete();
}

_id_3E01(var_0) {
  self endon("stop sound" + var_0);
  level waittill("putout_fires");
  self notify("stop sound" + var_0);
}

_id_6807(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(isDefined(self._id_3928)) {
    return;
  }
  if(common_scripts\utility::issp())
    var_0 = var_0 / 0.5;
  else
    var_0 = var_0 / 1.0;

  self notify("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_71A7(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = spawn("script_origin", self gettagorigin(var_1));
    var_2 hide();
    var_2 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  } else {
    var_2 = spawn("script_origin", (0, 0, 0));
    var_2 hide();
    var_2.origin = self.origin;
    var_2.angles = self.angles;
    var_2 linkto(self);
  }

  var_2 playSound(var_0);
  wait 5.0;

  if(isDefined(var_2))
    var_2 delete();
}

_id_3097() {
  if(isDefined(self._id_1FD9)) {
    return;
  }
  self._id_1FD9 = 1;

  if(!_id_8B54()) {
    return;
  }
  self._id_1FC7 = spawn("script_model", self.origin);
  self._id_1FC7 hide();
  self._id_1FC7 playloopsound("car_alarm");
  level._id_2928++;
  thread _id_1FC8();
  self waittill("stop_car_alarm");
  level._id_5B79 = gettime();
  level._id_2928--;
  self._id_1FC7 stoploopsound("car_alarm");
  self._id_1FC7 delete();
}

_id_1FC8() {
  self endon("stop_car_alarm");
  wait 25;

  if(!isDefined(self)) {
    return;
  }
  thread _id_71A7("car_alarm_off");
  self notify("stop_car_alarm");
}

_id_8B54() {
  if(level._id_2928 >= 2)
    return 0;

  var_0 = undefined;

  if(!isDefined(level._id_5B79)) {
    if(common_scripts\utility::_id_24A6())
      return 1;

    var_0 = gettime() - level._id_254D;
  } else
    var_0 = gettime() - level._id_5B79;

  if(level._id_2928 == 0 && var_0 >= 120)
    return 1;

  if(randomint(100) <= 33)
    return 1;

  return 0;
}

_id_30DF(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(common_scripts\utility::issp()) {
    self attach(var_1, var_0, 0);

    if(isDefined(var_2) && var_2 != "")
      self attach(var_2, var_0, 0);
  } else {
    var_4[0] = spawn("script_model", self gettagorigin(var_0));
    var_4[0].angles = self gettagangles(var_0);
    var_4[0] setModel(var_1);
    var_4[0] linkto(self, var_0);

    if(isDefined(var_2) && var_2 != "") {
      var_4[1] = spawn("script_model", self gettagorigin(var_0));
      var_4[1].angles = self gettagangles(var_0);
      var_4[1] setModel(var_2);
      var_4[1] linkto(self, var_0);
    }
  }

  if(isDefined(var_3)) {
    var_5 = self gettagorigin(var_0);
    var_6 = _id_410A(var_5, var_3);

    if(isDefined(var_6))
      var_6 delete();
  }

  self waittill("exploded");

  if(common_scripts\utility::issp()) {
    self detach(var_1, var_0);
    self attach(var_1 + "_destroy", var_0, 0);

    if(isDefined(var_2) && var_2 != "") {
      self detach(var_2, var_0);
      self attach(var_2 + "_destroy", var_0, 0);
    }
  } else {
    var_4[0] setModel(var_1 + "_destroy");

    if(isDefined(var_2) && var_2 != "")
      var_4[1] setModel(var_2 + "_destroy");
  }
}

_id_410A(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = getEntArray(var_1, "targetname");

  foreach(var_6 in var_4) {
    var_7 = distancesquared(var_0, var_6.origin);

    if(!isDefined(var_2) || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_6;
    }
  }

  return var_3;
}

_id_7381() {
  var_0 = undefined;

  if(!isDefined(self.target))
    return 0;

  var_1 = getEntArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.getenemyinfo) && var_3.getenemyinfo == "post") {
      var_0 = var_3;
      break;
    }
  }

  if(!isDefined(var_0))
    return 0;

  var_5 = _id_42AD(var_0);

  if(isDefined(var_5))
    return 1;

  return 0;
}

_id_42AD(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(var_0 istouching(var_2))
      return var_2;
  }

  return undefined;
}

_id_560F() {
  return getDvar("1996") == "1";
}

_id_2E05() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];
  var_1["pre"] = ::_id_24E0;
  var_1["post"] = ::_id_24DF;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.getenemyinfo)) {
      continue;
    }
    self thread[[var_1[var_3.getenemyinfo]]](var_3);
  }
}

_id_24E0(var_0) {
  waittillframeend;

  if(common_scripts\utility::issp() && var_0.spawnflags & 1)
    var_0 call[[level._id_2FC3]]();

  self waittill("exploded");

  if(common_scripts\utility::issp() && var_0.spawnflags & 1)
    var_0 call[[level._id_2587]]();

  var_0 delete();
}

_id_24DF(var_0) {
  var_0 notsolid();

  if(common_scripts\utility::issp() && var_0.spawnflags & 1)
    var_0 call[[level._id_2587]]();

  self waittill("exploded");
  waittillframeend;

  if(common_scripts\utility::issp()) {
    if(var_0.spawnflags & 1)
      var_0 call[[level._id_2FC3]]();

    if(_id_560F()) {
      var_1 = _id_42AD(var_0);

      if(isDefined(var_1))
        self thread[[level._id_3F05]](var_1);
    } else {}
  }

  var_0 solid();
}

_id_2AFD(var_0) {}

_id_2E01(var_0) {
  var_1 = getEntArray("light_destructible", "targetname");

  if(common_scripts\utility::issp()) {
    var_2 = getEntArray("light_destructible", "script_noteworthy");
    var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  }

  if(!var_1.size) {
    return;
  }
  var_3 = var_0 * var_0;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    var_7 = distancesquared(self.origin, var_6.origin);

    if(var_7 < var_3) {
      var_4 = var_6;
      var_3 = var_7;
    }
  }

  if(!isDefined(var_4)) {
    return;
  }
  self._id_1BAF = var_4;
}

_id_1BA6(var_0) {
  if(!isDefined(self._id_1BAF)) {
    return;
  }
  self._id_1BAF setlightintensity(0);
}

_id_2B01(var_0, var_1, var_2, var_3) {
  var_4 = 16;
  var_5 = 360 / var_4;
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = _cos(var_8) * var_1;
    var_10 = _sin(var_8) * var_1;
    var_11 = var_0[0] + var_9;
    var_12 = var_0[1] + var_10;
    var_13 = var_0[2];
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread _id_2AC5(var_6, 5.0, (1, 0, 0), var_0);
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = _cos(var_8) * var_1;
    var_10 = _sin(var_8) * var_1;
    var_11 = var_0[0];
    var_12 = var_0[1] + var_9;
    var_13 = var_0[2] + var_10;
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread _id_2AC5(var_6, 5.0, (1, 0, 0), var_0);
  var_6 = [];

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_5 * var_7;
    var_9 = _cos(var_8) * var_1;
    var_10 = _sin(var_8) * var_1;
    var_11 = var_0[0] + var_10;
    var_12 = var_0[1];
    var_13 = var_0[2] + var_9;
    var_6[var_6.size] = (var_11, var_12, var_13);
  }

  thread _id_2AC5(var_6, 5.0, (1, 0, 0), var_0);
}

_id_2AC5(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_4 + 1 >= var_0.size)
      var_6 = var_0[0];
    else
      var_6 = var_0[var_4 + 1];

    thread _id_2AF0(var_5, var_6, var_1, var_2);
    thread _id_2AF0(var_3, var_5, var_1, var_2);
  }
}

_id_2AF0(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = (1, 1, 1);

  for(var_4 = 0; var_4 < var_2 * 20; var_4++)
    waitframe();
}

_id_911E(var_0) {
  var_0 endon("death");
  level waittill("new_destructible_spotlight");
  var_0 delete();
}

_id_9117(var_0, var_1, var_2, var_3, var_4) {
  level endon("new_destructible_spotlight");
  thread _id_911E(var_4);
  var_5 = var_0["spotlight_brightness"];
  wait(_randomfloatrange(2, 5));
  _id_2E00(var_0, var_1, var_2, var_3);
  level._id_2E1A delete();
  var_4 delete();
}

_id_2E1B(var_0, var_1, var_2, var_3) {
  if(!common_scripts\utility::issp()) {
    return;
  }
  if(!isDefined(self._id_1BAF)) {
    return;
  }
  var_1 common_scripts\utility::getweaponheatlevel("startignoringspotLight");

  if(!isDefined(level._id_2E1A)) {
    level._id_2E1A = common_scripts\utility::_id_8FFC();
    var_4 = common_scripts\utility::_id_44F5(var_0["spotlight_fx"]);
    _playfxontag(var_4, level._id_2E1A, "tag_origin");
  }

  level notify("new_destructible_spotlight");
  level._id_2E1A unlink();
  var_5 = common_scripts\utility::_id_8FFC();
  var_5 linkto(self, var_0["spotlight_tag"], (0, 0, 0), (0, 0, 0));
  level._id_2E1A.origin = self._id_1BAF.origin;
  level._id_2E1A.angles = self._id_1BAF.angles;
  level._id_2E1A thread _id_9117(var_0, var_1, var_2, var_3, var_5);
  waitframe();

  if(isDefined(var_5))
    level._id_2E1A linkto(var_5);
}

_id_5641(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1["fx_valid_damagetype"]))
    var_4 = var_1["fx_valid_damagetype"][var_3][var_2];

  if(!isDefined(var_4))
    return 1;

  return issubstr(var_4, var_0);
}

_id_2E16(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_3928))
    return undefined;

  if(!isDefined(var_0["sound"]))
    return undefined;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_0["sound"][var_3]))
    return undefined;

  for(var_4 = 0; var_4 < var_0["sound"][var_3].size; var_4++) {
    var_5 = _id_583B("soundCause", var_0, var_4, var_2, var_3);

    if(!var_5) {
      continue;
    }
    var_6 = var_0["sound"][var_3][var_4];
    var_7 = var_0["tagName"];
    var_1 thread _id_71A7(var_6, var_7);
  }

  return var_3;
}

_id_2DFC(var_0) {
  var_1 = level._id_0075[self._id_2E25]._id_6E9F[0].size - 1;
  self endon("FX_State_Change_Kill" + var_0);

  for(;;) {
    var_2 = -1;

    if(isDefined(self._id_2E10[0].v["currentState"]))
      var_2 = self._id_2E10[0].v["currentState"];

    if(var_2 == var_1)
      return 0;

    waitframe();
  }
}

_id_2DFE(var_0, var_1, var_2, var_3, var_4, var_5) {
  waittillframeend;

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_2)) {
    if(var_4) {
      _playfxontag(var_1, var_0, var_2);
      waitframe();

      if(var_5 == 1 || var_5 == 2) {
        _id_2DFC(var_3);

        if(var_5 == 1)
          _stopfxontag(var_1, var_0, var_2);
        else
          _killfxontag(var_1, var_0, var_2);
      }
    } else {
      var_8 = var_0 gettagorigin(var_2);
      var_9 = (0, 0, 100);

      if(var_5 == 1 || var_5 == 2) {
        var_7 = _spawnfx(var_1, var_8, var_9);
        var_6 = _triggerfx(var_7, 0.01);
      } else
        var_6 = playFX(var_1, var_8, var_9);

      waitframe();

      if(var_5 == 1 || var_5 == 2) {
        _id_2DFC(var_3);

        if(var_5 == 1)
          var_7 delete();
        else if(var_5 == 2) {
          setfxkillondelete(var_7, 1);
          waitframe();
          var_7 delete();
        }
      }
    }
  } else {
    var_8 = var_0.origin;
    var_9 = (0, 0, 100);

    if(var_5 == 1 || var_5 == 2) {
      var_7 = _spawnfx(var_1, var_8, var_9);
      var_6 = _triggerfx(var_7, 0.01);
    } else
      var_6 = playFX(var_1, var_8, var_9);

    waitframe();

    if(var_5 == 1 || var_5 == 2) {
      _id_2DFC(var_3);

      if(var_5 == 1)
        var_7 delete();
      else if(var_5 == 2) {
        setfxkillondelete(var_7, 1);
        waitframe();
        var_7 delete();
      }
    }
  }
}

_id_2DFF() {
  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F)) {
    return;
  }
  var_0 = _id_4168();

  for(var_1 = 0; var_1 < level._id_0075[self._id_2E25]._id_6E9F.size; var_1++) {
    for(var_2 = 0; var_2 < level._id_0075[self._id_2E25]._id_6E9F[var_1].size; var_2++) {
      var_3 = level._id_0075[self._id_2E25]._id_6E9F[var_1][var_2];

      if(isDefined(var_3.v["fx_filename"])) {
        for(var_4 = 0; var_4 < var_3.v["fx_filename"].size; var_4++) {
          var_5 = var_3.v["fx_filename"][var_4];
          var_6 = var_3.v["fx_tag"][var_4];
          var_7 = var_3.v["spawn_immediate"][var_4];

          if(isDefined(var_5) && isDefined(var_7)) {
            for(var_8 = 0; var_8 < var_5.size; var_8++) {
              if(var_7[var_8] == 1) {
                var_9 = var_3.v["state_change_kill"][var_4][var_8];
                var_10 = level._id_0075[self._id_2E25]._id_6E9F[var_1][var_2].v["fx"][var_4][var_8];
                var_11 = var_6[var_8];
                var_12 = var_5[var_8];
                var_13 = level._id_0075[self._id_2E25]._id_6E9F[var_1][var_2].v["fx_useTagAngles"][var_4][var_8];
                thread _id_2DFE(var_0, var_10, var_11, var_1, var_13, var_9);
              }
            }
          }
        }
      }
    }
  }
}

_id_2E00(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0["fx"]))
    return undefined;

  if(!isDefined(var_4))
    var_4 = randomint(var_0["fx_filename"].size);

  if(!isDefined(var_0["fx"][var_4]))
    var_4 = randomint(var_0["fx_filename"].size);

  var_5 = var_0["fx_filename"][var_4].size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    if(!_id_5641(var_2, var_0, var_6, var_4)) {
      continue;
    }
    if(var_0["spawn_immediate"][var_4][var_6] == 1) {
      continue;
    }
    var_7 = var_0["fx"][var_4][var_6];
    var_8 = var_0["state_change_kill"][var_4][var_6];

    if(isDefined(var_0["fx_tag"][var_4][var_6])) {
      var_9 = var_0["fx_tag"][var_4][var_6];
      self notify("FX_State_Change" + var_3);

      if(var_0["fx_useTagAngles"][var_4][var_6])
        thread _id_2DFE(var_1, var_7, var_9, var_3, 1, var_8);
      else
        thread _id_2DFE(var_1, var_7, var_9, var_3, 0, var_8);

      continue;
    }

    thread _id_2DFE(var_1, var_7, undefined, var_3, 0, var_8);
  }

  return var_4;
}

_id_2DE4(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_3928))
    return undefined;

  if(!isDefined(var_0["animation"]))
    return undefined;

  if(isDefined(self._id_66E6))
    return undefined;

  if(isDefined(var_0["randomly_flip"]) && !isDefined(self.setjitterparams)) {
    if(common_scripts\utility::_id_24A6())
      self.angles = self.angles + (0, 180, 0);
  }

  if(isDefined(var_0["spotlight_tag"])) {
    thread _id_2E1B(var_0, var_1, var_2, var_3);
    waitframe();
  }

  var_4 = common_scripts\utility::random(var_0["animation"]);
  var_5 = var_4["anim"];
  var_6 = var_4["animTree"];
  var_7 = var_4["groupNum"];
  var_8 = var_4["mpAnim"];
  var_9 = var_4["maxStartDelay"];
  var_10 = var_4["animRateMin"];
  var_11 = var_4["animRateMax"];

  if(!isDefined(var_10))
    var_10 = 1.0;

  if(!isDefined(var_11))
    var_11 = 1.0;

  if(var_10 == var_11)
    var_12 = var_10;
  else
    var_12 = _randomfloatrange(var_10, var_11);

  var_13 = var_4["vehicle_exclude_anim"];

  if(self._id_003B == "script_vehicle" && var_13)
    return undefined;

  var_1 common_scripts\utility::getweaponheatlevel("useanimtree", var_6);
  var_14 = var_4["animType"];

  if(!isDefined(self._id_0ED4))
    self._id_0ED4 = [];

  self._id_0ED4[self._id_0ED4.size] = var_5;

  if(isDefined(self._id_3949))
    _id_23A2(var_1);

  if(isDefined(var_9) && var_9 > 0)
    wait(_randomfloat(var_9));

  if(!common_scripts\utility::issp()) {
    if(isDefined(var_8))
      common_scripts\utility::getweaponheatlevel("scriptModelPlayAnim", var_8);

    return var_7;
  }

  if(var_14 == "setanim") {
    var_1 common_scripts\utility::getweaponheatlevel("setanim", var_5, 1.0, 1.0, var_12);
    return var_7;
  }

  if(var_14 == "setanimknob") {
    var_1 common_scripts\utility::getweaponheatlevel("setanimknob", var_5, 1.0, 0, var_12);
    return var_7;
  }

  return undefined;
}

_id_23A2(var_0) {
  if(isDefined(self._id_0ED4)) {
    foreach(var_2 in self._id_0ED4) {
      if(common_scripts\utility::issp()) {
        var_0 common_scripts\utility::getweaponheatlevel("clearanim", var_2, 0);
        continue;
      }

      var_0 common_scripts\utility::getweaponheatlevel("scriptModelClearAnim");
    }
  }
}

_id_51B4() {
  level._id_2DC8 = 0;
  level._id_2DC9 = 0.5;

  if(common_scripts\utility::issp())
    level._id_607E = 20;
  else
    level._id_607E = 2;
}

_id_0976() {
  level._id_2DC8++;
  wait(level._id_2DC9);
  level._id_2DC8--;
}

_id_414B() {
  return level._id_2DC8;
}

_id_420B() {
  return level._id_607E;
}

_id_51B5() {
  level._id_2E24 = [];
}

_id_091D(var_0, var_1, var_2) {
  var_3 = self getentitynumber();

  if(!isDefined(level._id_2E24[var_3])) {
    level._id_2E24[var_3] = spawnStruct();
    level._id_2E24[var_3]._id_37D8 = var_3;
    level._id_2E24[var_3]._id_2DE2 = var_0;
    level._id_2E24[var_3]._id_9AB1 = 0;
    level._id_2E24[var_3]._id_6635 = 9999999;
    level._id_2E24[var_3]._id_3F6B = 0;
  }

  level._id_2E24[var_3]._id_3F6B = level._id_2E24[var_3]._id_3F6B + var_1.v["fxcost"];
  level._id_2E24[var_3]._id_9AB1 = level._id_2E24[var_3]._id_9AB1 + var_2;

  if(var_1.v["distance"] < level._id_2E24[var_3]._id_6635)
    level._id_2E24[var_3]._id_6635 = var_1.v["distance"];

  thread _id_49CE();
}

_id_49CE() {
  level notify("handle_destructible_frame_queue");
  level endon("handle_destructible_frame_queue");
  waitframe();
  var_0 = level._id_2E24;
  level._id_2E24 = [];
  var_1 = _id_8F1F(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(_id_414B() < _id_420B()) {
      if(var_1[var_2]._id_3F6B)
        thread _id_0976();

      var_1[var_2]._id_2DE2 notify("queue_processed", 1);
      continue;
    }

    var_1[var_2]._id_2DE2 notify("queue_processed", 0);
  }
}

_id_8F1F(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = var_3;

  for(var_5 = 1; var_5 < var_1.size; var_5++) {
    var_6 = var_1[var_5];

    for(var_7 = var_5 - 1; var_7 >= 0 && _id_40D5(var_6, var_1[var_7]) == var_6; var_7--)
      var_1[var_7 + 1] = var_1[var_7];

    var_1[var_7 + 1] = var_6;
  }

  return var_1;
}

_id_40D5(var_0, var_1) {
  if(var_0._id_9AB1 > var_1._id_9AB1)
    return var_0;
  else
    return var_1;
}

_id_4283(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1]))
    return var_2;

  var_3 = level._id_0075[self._id_2E25]._id_6E9F[var_0][var_1].v;

  if(isDefined(var_3["fx"])) {
    foreach(var_5 in var_3["fx_cost"]) {
      foreach(var_7 in var_5)
      var_2 = var_2 + var_7;
    }
  }

  return var_2;
}

_id_52AF(var_0) {
  if(!common_scripts\utility::_id_3C83("FLAG_DOT_init")) {
    common_scripts\utility::flag_init("FLAG_DOT_init");
    common_scripts\utility::flag_set("FLAG_DOT_init");
  }

  var_0 = _tolower(var_0);

  switch (var_0) {
    case "poison":
      if(!common_scripts\utility::_id_3C83("FLAG_DOT_poison_init")) {
        common_scripts\utility::flag_init("FLAG_DOT_poison_init");
        common_scripts\utility::flag_set("FLAG_DOT_poison_init");
      }

      break;
    default:
  }
}

_id_27E2() {
  var_0 = spawnStruct();
  var_0._id_99C1 = [];
  return var_0;
}

_id_27E3(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "trigger_radius";
  var_4.origin = var_0;
  var_4.spawnflags = var_1;
  var_4.radius = var_2;
  var_4._id_6220 = var_2;
  var_4._id_6098 = var_2;
  var_4._id_00BD = var_3;
  var_4._id_99C1 = [];
  return var_4;
}

_id_866B(var_0) {
  self.origin = var_0;
}

_id_866C(var_0, var_1) {
  if(isDefined(self.classname) && self.classname != "trigger_radius") {}

  if(!isDefined(var_1))
    var_1 = var_0;

  self._id_6220 = var_0;
  self._id_6098 = var_1;
}

_id_8669(var_0, var_1) {
  if(isDefined(self.classname) && issubstr(self.classname, "trigger"))
    return;
}

_id_866A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_0)) {} else
    var_0 = 0;

  var_6 = _tolower(var_6);
  var_7 = _tolower(var_7);
  var_8 = self._id_99C1.size;
  self._id_99C1[var_8] = spawnStruct();
  self._id_99C1[var_8]._id_35FE = 0;
  self._id_99C1[var_8]._id_2CAC = var_0;
  self._id_99C1[var_8]._id_00D9 = var_1;
  self._id_99C1[var_8].duration = var_2;
  self._id_99C1[var_8]._id_61BD = var_3;
  self._id_99C1[var_8]._id_607B = var_4;

  switch (var_5) {
    case 1:
    case 0:
      break;
    default:
  }

  self._id_99C1[var_8]._id_0093 = var_5;
  self._id_99C1[var_8].starttime = 0;

  switch (var_6) {
    case "normal":
      break;
    case "poison":
      switch (var_7) {
        case "player":
          self._id_99C1[var_8].type = var_6;
          self._id_99C1[var_8]._id_0A32 = var_7;
          self._id_99C1[var_8]._id_6B05 = ::_id_6B04;
          self._id_99C1[var_8]._id_6B33 = ::_id_6B32;
          self._id_99C1[var_8]._id_6AE6 = ::_id_6AE5;
          break;
        default:
      }

      break;
    default:
  }
}

_id_1D45(var_0, var_1) {
  var_1 = _tolower(var_1);
  var_2 = self._id_99C1.size;
  self._id_99C1[var_2] = spawnStruct();
  self._id_99C1[var_2].duration = var_0;
  self._id_99C1[var_2]._id_2CAC = 0;
  self._id_99C1[var_2]._id_6B05 = ::_id_6B00;
  self._id_99C1[var_2]._id_6B33 = ::_id_6B30;
  self._id_99C1[var_2]._id_6AE6 = ::_id_6AE4;

  switch (var_1) {
    case "player":
      self._id_99C1[var_2]._id_0A32 = var_1;
      break;
    default:
  }
}

_id_1D46(var_0) {
  var_1 = self._id_99C1.size - 1;

  if(!isDefined(self._id_99C1[var_1]._id_932C))
    self._id_99C1[var_1]._id_932C = [];

  var_2 = self._id_99C1[var_1]._id_932C.size;
  self._id_99C1[var_1]._id_932C = [];
  self._id_99C1[var_1]._id_932C["vars"] = [];
  self._id_99C1[var_1]._id_932C["vars"]["count"] = var_0;
}

_id_1D44(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self._id_99C1.size - 1;

  if(!isDefined(self._id_99C1[var_6]._id_932C["actions"]))
    self._id_99C1[var_6]._id_932C["actions"] = [];

  var_7 = self._id_99C1[var_6]._id_932C["actions"].size;
  self._id_99C1[var_6]._id_932C["actions"][var_7] = [];
  self._id_99C1[var_6]._id_932C["actions"][var_7]["vars"] = [var_0, var_1, var_2, var_3, var_4, var_5];
  self._id_99C1[var_6]._id_932C["actions"][var_7]["func"] = ::_id_310C;
}

_id_1D47(var_0) {
  var_1 = self._id_99C1.size - 1;

  if(!isDefined(self._id_99C1[var_1]._id_932C["actions"]))
    self._id_99C1[var_1]._id_932C["actions"] = [];

  var_2 = self._id_99C1[var_1]._id_932C["actions"].size;
  self._id_99C1[var_1]._id_932C["actions"][var_2] = [];
  self._id_99C1[var_1]._id_932C["actions"][var_2]["vars"] = [var_0];
  self._id_99C1[var_1]._id_932C["actions"][var_2]["func"] = ::_id_310D;
}

_id_6B00(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);
  var_2 = undefined;
  var_3 = var_1._id_99C1[var_0]._id_932C;

  if(!isDefined(var_3) || !isDefined(var_3["vars"]) || !isDefined(var_3["vars"]["count"]) || !isDefined(var_3["actions"])) {
    return;
  }
  var_4 = var_3["vars"]["count"];
  var_5 = var_3["actions"];
  var_3 = undefined;

  for(var_6 = 1; var_6 <= var_4 || var_4 == 0; var_6--) {
    foreach(var_8 in var_5) {
      var_9 = var_8["vars"];
      var_10 = var_8["func"];
      self[[var_10]](var_0, var_1, var_9);
    }
  }
}

_id_6B30(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
}

_id_6AE4(var_0, var_1) {}

_id_310C(var_0, var_1, var_2) {
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_5 = var_2[2];
  var_6 = var_2[3];
  var_7 = var_2[4];
  var_8 = var_2[5];
  self thread[[level.callbackplayerdamage]](var_1, var_1, var_4, var_6, var_7, var_8, var_1.origin, (0, 0, 0) - var_1.origin, "none", 0);
}

_id_310D(var_0, var_1, var_2) {
  var_3 = var_1 getentitynumber();
  var_4 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_3);
  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_3 + "_" + var_4);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_3);
  var_3 = undefined;
  var_4 = undefined;
  wait(var_2[0]);
}

_id_92C7(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = undefined;

    switch (var_3.type) {
      case "trigger_radius":
        var_4 = spawn("trigger_radius", var_3.origin, var_3.spawnflags, var_3.radius, var_3._id_00BD);
        var_4._id_6220 = var_3._id_6220;
        var_4._id_6098 = var_3._id_6098;
        var_4._id_99C1 = var_3._id_99C1;
        var_1[var_1.size] = var_4;
        break;
      default:
    }

    if(isDefined(var_3._id_6E74)) {
      var_4 linkto(var_3._id_6E74);
      var_3._id_6E74._id_32B1 = var_4;
    }

    var_5 = var_4._id_99C1;

    foreach(var_7 in var_5)
    var_7.starttime = gettime();

    foreach(var_7 in var_5) {
      if(!var_7._id_2CAC)
        var_7._id_35FE = 1;
    }

    foreach(var_7 in var_5) {
      if(issubstr(var_7._id_0A32, "player")) {
        var_4._id_6B6B = 1;
        break;
      }
    }
  }

  foreach(var_4 in var_1) {
    var_4._id_32B2 = [];

    foreach(var_16 in var_1) {
      if(var_4 == var_16) {
        continue;
      }
      var_4._id_32B2[var_4._id_32B2.size] = var_16;
    }
  }

  foreach(var_4 in var_1) {
    if(var_4._id_6B6B)
      var_4 thread _id_92C8();
  }

  foreach(var_4 in var_1)
  var_4 thread _id_6381();
}

_id_92C8() {
  thread _id_9DC3(::_id_6B01, ::_id_6B31);
}

_id_6381() {
  var_0 = gettime();

  while(isDefined(self)) {
    foreach(var_4, var_2 in self._id_99C1) {
      if(isDefined(var_2) && gettime() - var_0 >= var_2.duration * 1000) {
        var_3 = self getentitynumber();
        self notify("LISTEN_kill_tick_" + var_4 + "_" + var_3);
        self._id_99C1[var_4] = undefined;
      }
    }

    if(!self._id_99C1.size) {
      break;
    }

    waitframe();
  }

  if(isDefined(self)) {
    foreach(var_2 in self._id_99C1)
    self[[var_2._id_6AE6]]();

    self notify("death");
    self delete();
  }
}

_id_6B01(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("LISTEN_enter_dot_" + var_1);

  foreach(var_4, var_3 in var_0._id_99C1) {
    if(!var_3._id_35FE)
      thread _id_3144(var_4, var_0, var_3._id_2CAC, var_3._id_6B05);
  }

  foreach(var_4, var_3 in var_0._id_99C1) {
    if(var_3._id_35FE && var_3._id_0A32 == "player")
      self thread[[var_3._id_6B05]](var_4, var_0);
  }
}

_id_6B31(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("LISTEN_exit_dot_" + var_1);

  foreach(var_4, var_3 in var_0._id_99C1) {
    if(var_3._id_35FE && var_3._id_0A32 == "player")
      self thread[[var_3._id_6B33]](var_4, var_0);
  }
}

_id_3144(var_0, var_1, var_2, var_3) {
  var_4 = var_1 getentitynumber();
  var_5 = self getentitynumber();
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_4 + "_" + var_5);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self notify("LISTEN_exit_dot_" + var_4);
  var_4 = undefined;
  var_5 = undefined;
  wait(var_2);
  self thread[[var_3]](var_0, var_1);
}

_id_6B04(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);

  if(!isDefined(self._id_6B02))
    self._id_6B02 = [];

  if(!isDefined(self._id_6B02[var_0]))
    self._id_6B02[var_0] = [];

  self._id_6B02[var_0][var_2] = 0;
  var_4 = common_scripts\utility::_id_98E7(common_scripts\utility::issp(), 1.5, 1);

  while(isDefined(var_1) && isDefined(var_1._id_99C1[var_0])) {
    self._id_6B02[var_0][var_2]++;

    switch (self._id_6B02[var_0][var_2]) {
      case 1:
        self viewkick(1, self.origin);
        break;
      case 3:
        self shellshock("mp_radiation_low", 4);
        _id_3149(var_1, var_4 * 2);
        break;
      case 4:
        self shellshock("mp_radiation_med", 5);
        thread _id_3148(var_0, var_1);
        _id_3149(var_1, var_4 * 2);
        break;
      case 6:
        self shellshock("mp_radiation_high", 5);
        _id_3149(var_1, var_4 * 2);
        break;
      case 8:
        self shellshock("mp_radiation_high", 5);
        _id_3149(var_1, var_4 * 500);
        break;
    }

    wait(var_1._id_99C1[var_0]._id_00D9);
  }
}

_id_6B32(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_4 = self._id_6B03;

  if(isDefined(var_4)) {
    foreach(var_7, var_6 in var_4) {
      if(isDefined(var_4[var_7]) && isDefined(var_4[var_7][var_2]))
        var_4[var_7][var_2] thread _id_3146(0.1, 0);
    }
  }

  var_1 notify("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
}

_id_6AE5() {
  var_0 = self getentitynumber();

  foreach(var_2 in level.players) {
    var_3 = var_2._id_6B03;

    if(isDefined(var_3)) {
      foreach(var_6, var_5 in var_3) {
        if(isDefined(var_3[var_6]) && isDefined(var_3[var_6][var_0]))
          var_3[var_6][var_0] thread _id_3147();
      }
    }
  }
}

_id_3149(var_0, var_1) {
  if(common_scripts\utility::issp()) {
    return;
  }
  self thread[[level.callbackplayerdamage]](var_0, var_0, var_1, 0, "MOD_SUICIDE", "claymore_mp", var_0.origin, (0, 0, 0) - var_0.origin, "none", 0);
  return;
}

_id_3148(var_0, var_1) {
  var_2 = var_1 getentitynumber();
  var_3 = self getentitynumber();
  var_1 endon("death");
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2);
  var_1 endon("LISTEN_kill_tick_" + var_0 + "_" + var_2 + "_" + var_3);
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self endon("LISTEN_exit_dot_" + var_2);

  if(!isDefined(self._id_6B03))
    self._id_6B03 = [];

  if(!isDefined(self._id_6B03[var_0]))
    self._id_6B03[var_0] = [];

  if(!isDefined(self._id_6B03[var_0][var_2])) {
    var_4 = _newclienthudelem(self);
    var_4.x = 0;
    var_4.y = 0;
    var_4.alignx = "left";
    var_4.aligny = "top";
    var_4._id_00C6 = "fullscreen";
    var_4._id_01CA = "fullscreen";
    var_4.alpha = 0;
    var_4 setshader("black", 640, 480);
    self._id_6B03[var_0][var_2] = var_4;
  }

  var_4 = self._id_6B03[var_0][var_2];
  var_5 = 1;
  var_6 = 2;
  var_7 = 0.25;
  var_8 = 1;
  var_9 = 5;
  var_10 = 100;
  var_11 = 0;

  for(;;) {
    while(self._id_6B02[var_0][var_2] > 1) {
      var_12 = var_10 - var_9;
      var_11 = (self._id_6B02[var_0][var_2] - var_9) / var_12;

      if(var_11 < 0)
        var_11 = 0;
      else if(var_11 > 1)
        var_11 = 1;

      var_13 = var_6 - var_5;
      var_14 = var_5 + var_13 * (1 - var_11);
      var_15 = var_8 - var_7;
      var_16 = var_7 + var_15 * var_11;
      var_17 = var_11 * 0.5;

      if(var_11 == 1) {
        break;
      }

      var_18 = var_14 / 2;
      var_4 _id_3145(var_18, var_16);
      var_4 _id_3146(var_18, var_17);
      wait(var_11 * 0.5);
    }

    if(var_11 == 1) {
      break;
    }

    if(var_4.alpha != 0)
      var_4 _id_3146(1, 0);

    waitframe();
  }

  var_4 _id_3145(2, 0);
}

_id_3145(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
}

_id_3146(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
}

_id_3147(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
  var_1 = undefined;
  wait(var_0);
  self destroy();
}

_id_9DC3(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self._id_37D8 = self getentitynumber();

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2) && !isDefined(var_2._id_3BAA)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2._id_9AC5[self._id_37D8]))
      var_2 thread _id_7477(self, var_0, var_1);
  }
}

_id_7477(var_0, var_1, var_2) {
  var_0 endon("death");

  if(!isPlayer(self))
    self endon("death");

  if(!common_scripts\utility::issp())
    var_3 = self.guid;
  else
    var_3 = "player" + gettime();

  var_0._id_9AC3[var_3] = self;

  if(isDefined(var_0._id_64DD))
    self._id_64DE++;

  var_0 notify("trigger_enter", self);
  self notify("trigger_enter", var_0);
  var_4 = 1;

  foreach(var_6 in var_0._id_32B2) {
    foreach(var_8 in self._id_9AC5) {
      if(var_6 == var_8)
        var_4 = 0;
    }
  }

  if(var_4 && isDefined(var_1))
    self thread[[var_1]](var_0);

  self._id_9AC5[var_0._id_37D8] = var_0;

  while(isalive(self) && (common_scripts\utility::issp() || !level.gameended)) {
    var_11 = 1;

    if(self istouching(var_0))
      waitframe();
    else {
      if(!var_0._id_32B2.size)
        var_11 = 0;

      foreach(var_6 in var_0._id_32B2) {
        if(self istouching(var_6)) {
          waitframe();
          break;
        } else
          var_11 = 0;
      }
    }

    if(!var_11) {
      break;
    }
  }

  if(isDefined(self)) {
    self._id_9AC5[var_0._id_37D8] = undefined;

    if(isDefined(var_0._id_64DD))
      self._id_64DE--;

    self notify("trigger_leave", var_0);

    if(var_4 && isDefined(var_2))
      self thread[[var_2]](var_0);
  }

  if(!common_scripts\utility::issp() && level.gameended) {
    return;
  }
  var_0._id_9AC3[var_3] = undefined;
  var_0 notify("trigger_leave", self);

  if(!_id_0F13(var_0))
    var_0 notify("trigger_empty");
}

_id_0F13(var_0) {
  return var_0._id_9AC3.size;
}

_id_42C9(var_0) {
  return level._id_05FD[var_0];
}

_id_42CA(var_0) {
  return level._id_05FE[var_0];
}

_id_2E23() {
  if(!isDefined(level.player)) {
    return;
  }
  if(!isDefined(self.nearclaimnode))
    self.nearclaimnode = 20000;

  while(isDefined(self)) {
    if(isDefined(self._id_2E10)) {
      var_0 = 0;

      for(var_1 = 1; var_1 < self._id_2E10.size; var_1++) {
        if(self._id_2E10[var_1].v["currentState"] == 1)
          var_0++;
      }

      if(var_0 == self._id_2E10.size - 1) {
        break;
      }
    }

    var_2 = distancesquared(level.player.origin, self.origin);

    if(var_2 > self.nearclaimnode * self.nearclaimnode)
      self setcandamage(0);
    else
      self setcandamage(1);

    waitframe();
  }
}