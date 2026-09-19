/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_trigger.gsc
****************************************/

_id_41FC() {
  var_0 = _id_028C::_id_4323();
  var_1 = [];
  var_1["trigger_multiple_spawn_once"] = _id_048F::_id_9DB1;
  var_1["trigger_multiple_spawn_flood"] = _id_048F::_id_9D7C;
  var_1 = common_scripts\utility::_id_0F76(var_1, var_0);
  return var_1;
}

_id_5258() {
  var_0 = _id_41FC();
  var_1 = [];

  foreach(var_5, var_3 in var_0) {
    var_4 = getEntArray(var_5, "classname");
    common_scripts\utility::_id_0F8A(var_4, var_3);
    var_1 = common_scripts\utility::_id_0F73(var_1, var_4);
  }

  var_4 = [];
  var_6 = ["trigger_multiple", "trigger_once", "trigger_radius", "trigger_disk", "trigger_hurt", "trigger_damage", "trigger_use"];

  foreach(var_8 in var_6) {
    var_9 = getEntArray(var_8, "code_classname");
    var_4 = common_scripts\utility::_id_0F8C(var_4, var_9);
  }

  var_11 = common_scripts\utility::_id_0F7D(var_4, var_1);
  var_12 = [];

  foreach(var_14 in var_11) {
    var_15 = 0;

    foreach(var_8 in var_6) {
      if(var_14.classname == var_8) {
        var_15 = 1;
        break;
      }
    }

    if(!var_15) {
      foreach(var_8 in var_12) {
        if(var_14.classname == var_8 || issubstr(var_14.classname, var_8)) {
          var_15 = 1;
          break;
        }
      }
    }

    if(var_15)
      var_11 = common_scripts\utility::_id_0F93(var_11, var_14);
  }

  if(isDefined(var_11) && var_11.size > 0) {
    foreach(var_14 in var_11) {}
  }

  for(var_23 = 0; var_23 < var_4.size; var_23++) {
    if(isDefined(var_4[var_23].setgoalnode))
      level thread _id_028C::_id_9DAC(var_4[var_23]);

    if(isDefined(var_4[var_23].pushplayer))
      level thread _id_028C::_id_9DAB(var_4[var_23]);

    if(isDefined(var_4[var_23].addroll))
      var_4[var_23] thread _id_028C::_id_9D85();

    if(isDefined(var_4[var_23].physicslaunchserver))
      var_4[var_23].setdepthoffield = var_4[var_23].physicslaunchserver;
  }
}