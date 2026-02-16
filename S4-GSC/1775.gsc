/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1775.gsc
*************************************************/

_id_6411(var_0, var_1) {
  if(isDefined(var_0._id_3BE8[var_1])) {
    return var_0._id_3BE8[var_1][0];
  }
}

_id_6412(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0._id_3BE8[var_1])) {
    var_2 = var_0._id_3BE8[var_1];
  }

  return var_2;
}

_id_BB93() {
  level._id_3BE9 = spawnStruct();
  level._id_3BE9._id_C257 = [];
  level._id_3BE9._id_CF33 = [];
}

_id_5A9A() {
  _id_D7A1();
  _id_D7E2();
  level._id_3BE9._id_E2BA = [];
  _id_07A1::_id_CECB(::_id_833D);
}

_id_C215(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_CF92 = var_0;
  var_3._id_E274 = var_1;
  level._id_3BE9._id_C257[var_0] = var_3;

  if(isDefined(var_2) && var_2) {
    scripts\engine\utility::array_add(level._id_3BE9._id_10F47, var_0);
  }

  return var_3;
}

_id_672B(var_0) {
  return level._id_3BE9._id_C257[var_0];
}

_id_673C(var_0, var_1) {
  if(!isDefined(var_1)) {
    return [];
  }

  var_2 = scripts\engine\utility::getStructArray(var_1, var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    foreach(var_7 in level._id_3BE9._id_C257) {
      var_3[var_3.size] = var_7;
    }
  }

  return var_3;
}

_id_6410(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize(_id_63C2(var_0));

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_FFC5) && var_2[var_3]._id_FFC5 != "content_location") {
      scripts\engine\utility::array_remove_index(var_2, var_3, 1);
    }
  }

  scripts\engine\utility::_id_1BD1(var_2, 1);

  foreach(var_5 in var_2) {
    var_6 = scripts\engine\utility::array_randomize(_id_63C2(var_5));

    foreach(var_8 in var_6) {
      if(isDefined(var_8._id_3BE5) && var_8._id_3BE5 == var_1) {
        return var_8;
      }
    }
  }
}

_id_D7A1() {
  level._id_3BE9._id_4828 = [];

  if(!isDefined(level._id_EA70["variantname"])) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("content_destination", "variantname");

  foreach(var_2 in var_0) {
    level._id_3BE9._id_4828[var_2._id_0481] = var_2;
    _id_2CB3(var_2);
    var_2._id_96DE = [];
    var_3 = _id_63C2(var_2);

    foreach(var_5 in var_3) {
      if(var_5._id_FFC5 != "content_location") {
        continue;
      }
      var_2._id_96DE[var_5._id_0481] = var_5;
    }
  }

  level._id_3BE9._id_4828 = scripts\engine\utility::array_randomize(level._id_3BE9._id_4828);
}

_id_D74A(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = scripts\engine\utility::getstruct(var_4);
    level._id_3BE9._id_4828[var_0]._id_1189[var_2] = var_5;
    var_2++;
  }
}

_id_751F(var_0) {
  var_1 = _func_0107(var_0._id_E2BA) && var_0._id_E2BA.size > 0;
  return var_1;
}

_id_D7E2() {
  level._id_3BE9._id_96DE = [];

  if(!isDefined(level._id_EA70["variantname"])) {
    return;
  }
  var_0 = scripts\engine\utility::getStructArray("content_location", "variantname");

  foreach(var_2 in var_0) {
    level._id_3BE9._id_96DE[var_2._id_0481] = var_2;

    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");

      if(isDefined(var_3._id_FFC5) && var_3._id_FFC5 == "content_destination") {
        var_2._id_4823 = var_3;
      }
    }

    _id_2CB3(var_2);
    var_2._id_8300 = [];
    var_4 = _id_63C2(var_2);

    foreach(var_6 in var_4) {
      if(isDefined(var_6._id_FFC5) && var_6._id_FFC5 != "content_instance" || !isDefined(var_6._id_FFC5)) {
        continue;
      }
      if(!isDefined(var_2._id_8300[var_6._id_3BE5])) {
        var_2._id_8300[var_6._id_3BE5] = spawnStruct();
        var_2._id_8300[var_6._id_3BE5].versions = [];
      }

      var_2._id_8300[var_6._id_3BE5].versions = scripts\cp\utility::_id_459B(var_2._id_8300[var_6._id_3BE5].versions, []);
      var_2._id_8300[var_6._id_3BE5].versions = scripts\cp\utility::_id_1B8C(var_2._id_8300[var_6._id_3BE5].versions, var_6);
      var_6._id_96CF = var_2;
    }
  }
}

_id_E16F(var_0) {
  _id_2CB3(var_0);
  var_1 = level._id_3BE9._id_C257[var_0._id_3BE5];

  if(isDefined(var_1._id_E274)) {
    level thread[[var_1._id_E274]](var_0);
  }

  _id_F3EC(var_0);
}

_id_30FB(var_0) {
  return !_id_751F(var_0._id_96CF);
}

_id_F3EC(var_0) {
  var_0._id_96CF._id_E2BA = scripts\cp\utility::_id_459B(var_0._id_96CF._id_E2BA, []);
  var_0._id_96CF._id_E2BA[var_0._id_96CF._id_E2BA.size] = var_0;
  var_1 = level._id_3BE9._id_E2BA;
  var_1[var_0._id_3BE5] = ::scripts\cp\utility::_id_459B(var_1[var_0._id_3BE5], []);
  var_1[var_0._id_3BE5][var_1[var_0._id_3BE5].size] = var_0;
  level._id_3BE9._id_E2BA = var_1;
}

_id_E170(var_0, var_1, var_2, var_3) {
  var_3 = scripts\cp\utility::_id_459B(var_3, (0, 0, 0));
  var_4 = _func_03C5(var_1, var_0.origin + var_3, var_0.angles);
  var_4._id_3BE6 = var_2;
  var_4 _id_833C(1);
  return var_4;
}

_id_833C(var_0) {
  var_1 = "visible";

  if(!var_0) {
    var_1 = "hidden";
  }

  self setscriptablepartstate("content_interact", var_1);
}

_id_833B() {
  self setscriptablepartstate("content_interact", "inactive");
}

_id_833D(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0._id_3BE6)) {
    return;
  }
  var_0 thread[[var_0._id_3BE6]](var_3);
}

_id_E1E7(var_0, var_1, var_2, var_3) {
  scripts\cp\utility::_id_459B(var_2, 0);
  scripts\cp\utility::_id_459B(var_3, 1);
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = _id_E1E5(var_6, var_1, var_2, var_3);
    var_4[var_4.size] = var_7;
  }

  return var_4;
}

_id_E1E5(var_0, var_1, var_2, var_3, var_4) {
  var_2 = scripts\cp\utility::_id_459B(var_2, 0);
  var_3 = scripts\cp\utility::_id_459B(var_3, 1);
  var_4 = scripts\cp\utility::_id_459B(var_4, var_0.origin);
  var_5 = spawn("script_model", var_4);
  var_5.angles = var_0.angles;
  var_5 setModel(var_1);

  if(isDefined(var_0._id_0481)) {
    var_5._id_0481 = var_0._id_0481;
  }

  if(isDefined(var_0._id_039B)) {
    var_5._id_039B = var_0._id_039B;
  }

  if(var_2) {
    var_5 _meth_80B5();
  }

  if(var_3) {}

  var_6 = var_0;

  for(;;) {
    if(var_6._id_FFC5 == "content_instance" && isDefined(var_6._id_0DDF)) {
      if(!scripts\engine\utility::array_contains(var_6._id_0DDF._id_9FDF, var_5)) {
        var_6._id_0DDF._id_9FDF = scripts\engine\utility::array_add(var_6._id_0DDF._id_9FDF, var_5);
      }

      break;
    }

    if(!isDefined(var_6.target)) {
      break;
    }

    var_6 = scripts\engine\utility::getstruct(var_6.target, "targetname");

    if(!isDefined(var_6)) {
      break;
    }
  }

  return var_5;
}

_id_E257(var_0, var_1, var_2) {
  scripts\cp\utility::_id_459B(var_2, 0);
  var_3 = spawn(var_1, var_0.origin);
  var_3.angles = var_0.angles;

  if(var_2) {
    var_3 _meth_80B5();
  }

  var_4 = var_0;

  for(;;) {
    if(var_4._id_FFC5 == "content_instance") {
      if(!scripts\engine\utility::array_contains(var_4._id_0DDF._id_9FDF, var_3)) {
        var_4._id_0DDF._id_9FDF = scripts\engine\utility::array_add(var_4._id_0DDF._id_9FDF, var_3);
      }

      break;
    }

    var_4 = scripts\engine\utility::getstruct(var_4.target);

    if(!isDefined(var_4)) {
      break;
    }
  }

  return var_3;
}

_id_3863() {
  level notify("cleanup_spawned_instances");
  var_0 = 10;
  var_1 = 0;

  foreach(var_3 in level._id_3BE9._id_E2BA) {
    foreach(var_5 in var_3) {
      if(isDefined(var_5._id_0DF3)) {
        foreach(var_7 in var_5._id_0DF3) {
          if(isDefined(var_7)) {
            if(isDefined(var_7.trigger)) {
              var_7.trigger delete();
            }

            if(isDefined(var_7._id_A8FE)) {
              if(isDefined(level._id_601A)) {
                [[level._id_601A]](var_7._id_A8FE);
              } else {
                _func_015C(var_7._id_A8FE);
              }
            }

            if(isDefined(var_7._id_A8DB)) {
              if(isDefined(level._id_601A)) {
                [[level._id_601A]](var_7._id_A8DB);
              } else {
                _func_015C(var_7._id_A8DB);
              }
            }

            var_7 _id_0788::_id_1830();
            var_7 delete();
            var_1 = var_1 + 1;

            if(var_1 % var_0 == 0) {
              wait 0.05;
            }
          }
        }

        var_5._id_0DF3 = scripts\engine\utility::_id_1BD1(var_5._id_0DF3);
      }

      var_3 = scripts\engine\utility::array_remove(var_3, var_5);
      var_5._id_96CF._id_E2BA = scripts\engine\utility::array_remove(var_5._id_96CF._id_E2BA, var_5);
    }

    var_3 = scripts\engine\utility::_id_1BD1(var_3);
    level._id_3BE9._id_E2BA = scripts\engine\utility::array_remove(level._id_3BE9._id_E2BA, var_3);
  }

  scripts\engine\utility::_id_1BD1(level._id_3BE9._id_E2BA);
}

_id_2CB3(var_0) {
  var_1 = _id_63C2(var_0);
  var_2 = _id_2CB1(var_1);
  var_0._id_3BE8 = var_2;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4._id_3BE4) || isDefined(var_4._id_3BE4) && var_4._id_FFC5 != "content_struct") {
      continue;
    }
    var_4.parent = var_0;
    _id_2CB3(var_4);
  }
}

_id_2CB1(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_3BE4) || var_3._id_FFC5 != "content_struct") {
      continue;
    }
    if(!isDefined(var_1[var_3._id_3BE4])) {
      var_1[var_3._id_3BE4] = [];
    }

    scripts\cp\utility::_id_459B(var_1[var_3._id_3BE4], []);
    var_1[var_3._id_3BE4][var_1[var_3._id_3BE4].size] = var_3;
  }

  return var_1;
}

_id_63C2(var_0) {
  if(!isDefined(var_0._id_0481)) {
    return [];
  }

  return scripts\engine\utility::getStructArray(var_0._id_0481, "target");
}