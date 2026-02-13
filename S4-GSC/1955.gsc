/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1955.gsc
*************************************************/

ray_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_9 = _func_02C1(var_0, var_1, var_7, var_2, 0, "physicsquery_closest", var_8, var_6);

  if(var_9.size) {
    var_9 = var_9[0];
  } else {
    var_9 = _id_83DB(var_1);
  }

  if(isDefined(var_4) && var_4) {
    var_9 = _id_3C7C(var_9);
  }

  return var_9;
}

_id_C053(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  var_7 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);
  var_8 = _func_0398(var_0, var_1, var_6, var_2, 0, "physicsquery_closest", var_7);

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = _id_83DB(var_1);
  }

  if(isDefined(var_4) && var_4) {
    var_8 = _id_3C7C(var_8);
  }

  return var_8;
}

_bullet_trace(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = ["physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"];

  if(var_2) {
    var_9[var_9.size] = "physicscontents_characterproxy";
  }

  if(isDefined(var_4) && var_4) {
    var_9[var_9.size] = "physicscontents_itemclip";
  }

  if(isDefined(var_6) && var_6) {
    var_9[var_9.size] = "physicscontents_vehicleclip";
  }

  if(!isDefined(var_7) || !var_7) {
    var_9[var_9.size] = "physicscontents_clipshot";
  }

  if(!isDefined(var_8) || var_8) {
    var_9[var_9.size] = "physicscontents_glass";
  }

  if(isDefined(var_5) && var_5) {
    return _id_C051(var_0, var_1, var_3, physics_createcontents(var_9), 1);
  } else {
    return ray_trace(var_0, var_1, var_3, physics_createcontents(var_9), 1);
  }
}

_bullet_trace_passed(var_0, var_1, var_2, var_3) {
  return ray_trace_passed(var_0, var_1, var_3, _id_3EF6(!var_2));
}

_id_C051(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0);

  if(isDefined(var_6)) {
    var_9 = _func_02C1(var_0, var_1, var_7, var_2, 1, "physicsquery_closest", var_8, var_6);
  } else {
    var_9 = _func_02C1(var_0, var_1, var_7, var_2, 1, "physicsquery_closest", var_8);
  }

  if(var_9.size) {
    var_9 = var_9[0];
  } else {
    var_9 = _id_83DB(var_1);
  }

  if(isDefined(var_4) && var_4) {
    var_9 = _id_3C7C(var_9);
  }

  return var_9;
}

_id_C054(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  var_6 = _func_02C1(var_0, var_1, var_5, var_2, 0, "physicsquery_all");

  if(isDefined(var_4) && var_4) {
    foreach(var_9, var_8 in var_6) {
      var_6[var_9] = _id_3C7C(var_8);
    }
  }

  return var_6;
}

ray_trace_passed(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  return !_func_02C1(var_0, var_1, var_4, var_2, 0, "physicsquery_any");
}

_id_C052(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, _id_3EF6());
  return !_func_02C1(var_0, var_1, var_4, var_2, 1, "physicsquery_any");
}

_id_30F5(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!scripts\engine\math::_id_B9AB(var_0)) {
    return 0;
  }

  return ray_trace_passed(self getEye(), var_0, self, _id_3EE5(var_1, 1, 0, 1, 0, 1));
}

_id_E409(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  var_7 = _func_02C2(var_0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = _id_83DB(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = _id_3C7C(var_7);
  }

  return var_7;
}

_id_E40B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, 0);
  var_9 = _func_0447(var_0, var_1, var_2, var_7, var_3, "physicsquery_closest");

  if(var_9.size) {
    var_9 = var_9[0];
  } else {
    var_9 = _id_83DB(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_9 = _id_3C7C(var_9);
  }

  return var_9;
}

_id_E40A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 1.0;
  var_6 = (1, 1, 1);
  var_7 = (1, 0, 0);
  var_8 = (1, 0, 1);
  var_9 = 0;
  var_10 = distance(var_0, var_1);
  var_11 = vectornormalize(var_1 - var_0);
  var_12 = vectortoangles(var_1 - var_0);
  var_12 = _func_0047(var_12, (90, 0, 0));
  var_13 = var_0 - var_11 * var_2;

  if(isDefined(var_3)) {
    if(isint(var_3)) {
      if(var_3 == 1) {
        var_9 = 1;
      }
    } else if(isDefined(var_3["position"])) {
      var_9 = 1;
      var_5 = var_3["fraction"];
    } else {
      var_14 = undefined;
      var_15 = undefined;

      if(var_3.size == 2 && isDefined(var_3[0]) && isDefined(var_3[1]) && (isint(var_3[0]) || _func_0107(var_3[0]) && (isint(var_3[1]) || _func_0107(var_3[1])))) {
        var_14 = var_3[0];
        var_15 = var_3[1];
      } else if(isint(var_3) || _func_0107(var_3))
        var_14 = var_3;

      if(isDefined(var_14)) {
        if(isint(var_14)) {
          if(var_14 == 1) {
            var_9 = 1;
          }
        } else {
          foreach(var_18, var_17 in var_14) {
            if(isDefined(var_17["position"])) {
              var_9 = 1;

              if(var_18 == var_14.size - 1) {
                var_5 = var_17["fraction"];
                continue;
              }
            }
          }
        }
      }

      if(isDefined(var_15)) {
        if(isint(var_15)) {
          if(var_15 == 1) {}
        } else {
          foreach(var_18, var_17 in var_15) {
            if(isDefined(var_17["position"])) {}
          }
        }
      }
    }
  }

  var_20 = var_2 * 2 + var_10 * var_5;
  var_21 = var_6;

  if(var_9) {
    var_21 = var_7;
  }

  scripts\engine\utility::_id_4EF3(var_13, var_2, var_20, var_12, [var_6, var_6, var_21], 0, var_4);
}

_id_E40C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  var_8 = _func_02C2(var_0, var_1, var_2, var_7, var_3, "physicsquery_all", undefined, var_6);

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8) {
      var_10 = _id_3C7C(var_10);
    }
  }

  return var_8;
}

_id_E40D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  return !_func_02C2(var_0, var_1, var_2, var_5, var_3, "physicsquery_any");
}

_id_E407(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  var_7 = _func_02C6(var_0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = _id_83DB(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = _id_3C7C(var_7);
  }

  return var_7;
}

_id_3219(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, _id_3EF6());
  var_9 = _id_3C77(var_0, var_1, var_2, var_3, var_4);
  var_10 = _func_02C3(var_9["trace_start"], var_9["trace_end"], var_2, var_9["half_height"], var_4, var_8, var_5, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = _id_83DB(var_1);
  }

  if(isDefined(var_7) && var_7) {
    var_10 = _id_3C7C(var_10);
  }

  return var_10;
}

_id_321A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, _id_3EF6());
  var_9 = _id_3C77(var_0, var_1, var_2, var_3, var_4);
  var_10 = _func_02C3(var_9["trace_start"], var_9["trace_end"], var_2, var_9["half_height"], var_4, var_8, var_5, "physicsquery_all");

  if(isDefined(var_7) && var_7) {
    foreach(var_12 in var_10) {
      var_12 = _id_3C7C(var_12);
    }
  }

  return var_10;
}

_id_321B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, _id_3EF6());
  var_8 = _id_3C77(var_0, var_1, var_2, var_3, var_4);
  return !_func_02C3(var_8["trace_start"], var_8["trace_end"], var_2, var_8["half_height"], var_4, var_7, var_5, "physicsquery_any");
}

_id_3218(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, _id_3EF6());
  var_9 = _id_3C77(var_0, undefined, var_1, var_2, var_3);
  var_10 = _func_02C7(var_9["trace_start"], var_1, var_9["half_height"], var_3, var_4, var_8, var_5, "physicsquery_closest");

  if(var_10.size) {
    var_10 = var_10[0];
  } else {
    var_10 = _id_83DB(var_0);
  }

  if(isDefined(var_7) && var_7) {
    var_10 = _id_3C7C(var_10);
  }

  return var_10;
}

_id_B607(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = _func_02D2(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_closest");

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = _id_83DB(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_8 = _id_3C7C(var_8);
  }

  return var_8;
}

_id_B608(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = _func_02D2(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_all");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8) {
      var_10 = _id_3C7C(var_10);
    }
  }

  return var_8;
}

_id_B609(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self getplayerangles();
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return !_func_02D2(var_0, var_1, self, var_5, var_2, var_6, var_3, "physicsquery_any");
}

_id_B490(var_0, var_1, var_2, var_3) {
  return _id_B48F(self.origin, self.angles, var_0, var_1, var_2, var_3);
}

_id_B48F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = self getplayerangles();
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(_func_0107(var_3)) {
    var_3 = scripts\engine\utility::array_add(var_3, self);
  } else {
    var_3 = self;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3EF6());
  var_7 = _func_02D3(var_0, self, 0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = _id_83DB(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = _id_3C7C(var_7);
  }

  return var_7;
}

_id_12F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3F70());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = _func_02D2(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_closest");

  if(var_8.size) {
    var_8 = var_8[0];
  } else {
    var_8 = _id_83DB(var_1);
  }

  if(isDefined(var_5) && var_5) {
    var_8 = _id_3C7C(var_8);
  }

  return var_8;
}

_id_12F3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3F70());

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_8 = _func_02D2(var_0, var_1, self, var_6, var_2, var_7, var_3, "physicsquery_all");

  if(isDefined(var_5) && var_5) {
    foreach(var_10 in var_8) {
      var_10 = _id_3C7C(var_10);
    }
  }

  return var_8;
}

_id_12F4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = self.angles;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3F70());

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  return !_func_02D2(var_0, var_1, self, var_5, var_2, var_6, var_3, "physicsquery_any");
}

_id_128B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isai(self)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = self.angles;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, _id_3F70());
  var_7 = _func_02D3(var_0, self, 0, var_1, var_2, var_6, var_3, "physicsquery_closest");

  if(var_7.size) {
    var_7 = var_7[0];
  } else {
    var_7 = _id_83DB(var_0);
  }

  if(isDefined(var_5) && var_5) {
    var_7 = _id_3C7C(var_7);
  }

  return var_7;
}

_id_3F70(var_0) {
  var_1 = ["physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle"];

  if(!isDefined(var_0) || !var_0) {
    var_1 = scripts\engine\utility::array_add(var_1, "physicscontents_characterproxy");
  }

  return physics_createcontents(var_1);
}

_id_3F55(var_0, var_1) {
  var_2 = ["physicscontents_ainosight", "physicscontents_vehicle"];

  if(!istrue(var_0)) {
    var_2[var_2.size] = "physicscontents_characterproxy";
  }

  if(!istrue(var_1)) {
    var_2[var_2.size] = "physicscontents_foliage";
  }

  return physics_createcontents(var_2);
}

_id_3EC9() {
  var_0 = ["physicscontents_ainosight"];
  return physics_createcontents(var_0);
}

_id_3F94() {
  var_0 = ["physicscontents_itemclip", "physicscontents_water"];
  return physics_createcontents(var_0);
}

_id_3F1E() {
  var_0 = ["physicscontents_glass"];
  return physics_createcontents(var_0);
}

_id_3EC8() {
  var_0 = ["physicscontents_ainoshoot"];
  return physics_createcontents(var_0);
}

_id_3F2C() {
  var_0 = ["physicscontents_item"];
  return physics_createcontents(var_0);
}

_id_3F2D() {
  var_0 = ["physicscontents_itemclip"];
  return physics_createcontents(var_0);
}

_id_3F87() {
  var_0 = ["physicscontents_vehicle"];
  return physics_createcontents(var_0);
}

_id_3F6B() {
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip"];
  return physics_createcontents(var_0);
}

_id_3F5F() {
  var_0 = ["physicscontents_playerclip"];
  return physics_createcontents(var_0);
}

_id_3EE0() {
  var_0 = ["physicscontents_characterproxy"];
  return physics_createcontents(var_0);
}

_id_3EF6(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  return _id_3EE5(!var_0, 1, 1, 1, 0, 1);
}

_id_3EE5(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;

  if(isDefined(var_0) && var_0) {
    var_9 = var_9 + _id_3EE0();
  }

  if(isDefined(var_1) && var_1) {
    var_9 = var_9 + _id_3F94();
  }

  if(isDefined(var_2) && var_2) {
    var_9 = var_9 + _id_3F1E();
  }

  if(isDefined(var_3) && var_3) {
    var_9 = var_9 + _id_3F6B();
  }

  if(isDefined(var_4) && var_4) {
    var_9 = var_9 + _id_3F2C();
  }

  if(isDefined(var_5) && var_5) {
    var_9 = var_9 + _id_3F87();
  }

  if(isDefined(var_6) && var_6) {
    var_9 = var_9 + _id_3F5F();
  }

  if(isDefined(var_7) && var_7) {
    var_9 = var_9 + _id_3EC9();
  }

  if(isDefined(var_8) && var_8) {
    var_9 = var_9 + _id_3F2D();
  }

  return var_9;
}

_id_3ECB() {
  var_0 = ["physicscontents_foliage", "physicscontents_vehicletrigger", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_sentienttrigger", "physicscontents_nonsentienttrigger", "physicscontents_vehicle", "physicscontents_useclip", "physicscontents_playertrigger"];
  return physics_createcontents(var_0);
}

_id_3C7C(var_0) {
  var_1 = _func_02CA(var_0["surfaceflags"]);
  var_0["surfaceindex"] = var_1["index"];
  var_0["surfacetype"] = var_1["name"];
  return var_0;
}

_id_3C77(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_5 = var_3 * 0.5;
  var_6 = anglesToForward(var_4);
  var_7 = anglestoup(var_4);
  var_8 = [];
  var_8["trace_start"] = var_0 + var_7 * var_5;

  if(isDefined(var_1)) {
    var_8["trace_end"] = var_1 + var_7 * var_5;
  }

  var_8["radius"] = var_2;
  var_8["angles"] = var_4;
  var_8["half_height"] = var_5;
  return var_8;
}

_id_4F2F(var_0, var_1, var_2, var_3) {}

_id_4F30(var_0, var_1, var_2, var_3, var_4) {}

_id_4F31(var_0, var_1, var_2) {}

_id_83DB(var_0) {
  var_1 = [];
  var_1["fraction"] = 1;
  var_1["surfaceflags"] = 0;
  var_1["distance"] = 0;
  var_1["position"] = var_0;
  var_1["shape_position"] = var_0;
  var_1["normal"] = (0, 0, 0);
  var_1["contact_normal"] = (0, 0, 0);
  var_1["hittype"] = "hittype_none";
  return var_1;
}

_id_83D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}