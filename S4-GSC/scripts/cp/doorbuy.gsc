/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\doorbuy.gsc
*************************************************/

init_doorbuy() {
  level thread _init_doorbuy();
}

_init_doorbuy() {
  level.a_s_doorbuys = [];
  _id_06EF::_id_C215("doorbuy", ::on_spawn_doorbuy);
  wait 0.1;
  var_0 = scripts\engine\utility::getstructarray("content_destination", "variantname");

  if(isDefined(var_0) && var_0.size > 0) {
    level thread spawn_doorbuy_destination(var_0[0]);
  }
}

spawn_doorbuy_destination(var_0) {
  foreach(var_2 in var_0._id_96DE) {
    var_3 = var_2._id_8300["doorbuy"];

    if(isDefined(var_3)) {
      foreach(var_5 in var_3.versions) {
        _id_06EF::_id_E16F(var_5);
      }
    }
  }
}

_id_C1EF() {
  _id_0737::_id_C266("doorbuy", ::get_doorbuy_hint_func, ::doorbuy_used);
  level._id_8393["doorbuy"].disable_model = 1;
  level._id_8393["doorbuy"]._id_E3FF = "doorbuy";
  level._id_8393["doorbuy"]._id_3D91 = 500;
  level._id_8393["doorbuy"]._id_3D92 = ::get_doorbuy_override_cost_func;
  level._id_8393["doorbuy"]._id_FE72 = 360;
  level._id_8393["doorbuy"].hint_type_func = ::get_doorbuy_hint_type_func;
}

on_spawn_doorbuy(var_0) {
  var_1 = var_0._id_3BE8["doorbuy_trigger"];

  if(_func_0107(var_1)) {
    foreach(var_3 in var_1) {
      var_3 doorbuy_init(var_0);
    }
  }
}

doorbuy_init(var_0) {
  var_1 = [];
  self._id_82FC = var_0;

  if(_id_0737::_id_838E(self)) {
    self._id_CD4B = default_to(self._id_CD4B, "power_on");
  }

  if(isDefined(self._id_CD4B)) {
    thread wait_flag_open_door(self._id_CD4B);
  }

  if(!check_doorbuy_labels(self._id_CD99, "no_minimap_icon")) {
    if(_id_0737::_id_838E(self)) {
      _id_0737::add_interaction_marker_internal(self, self._id_039B + "_power", "v_ui_icons_zombies_minimap_powerdoors", 0);
    } else {
      _id_0737::add_interaction_marker_internal(self, self._id_039B, "v_ui_icons_zombies_minimap_doorbuys", 0);
    }
  }

  if(check_doorbuy_labels(self._id_CD99, "disable_obstruction")) {
    self._id_796E = 1;
  }

  if(isDefined(self._id_CDC1)) {
    var_2 = _id_06EF::_id_E1E5(self, self._id_CDC1, 1);
    var_2.n_open_time = self._id_CE85;
    var_2.str_open_sound = self._id_CE4B;
    var_2._id_0394 = self._id_0394;
    var_1 = scripts\engine\utility::array_add(var_1, var_2);

    if(isent(var_2)) {
      if(var_2 _meth_86EE()) {
        var_2 setscriptablepartstate("base", "closed");
      } else if(isDefined(self.target2)) {
        var_3 = scripts\engine\utility::getstruct(self.target2, "targetname");
        var_2.v_open_pos = var_3.origin;
        var_2.v_open_ang = var_3.angles;
      }
    }
  } else {
    var_4 = scripts\engine\utility::getstructarray(self.target2, "targetname");
    var_1 = [];

    if(_func_0107(var_4)) {
      foreach(var_6 in var_4) {
        if(!isDefined(var_6._id_4DBA)) {
          var_6._id_4DBA = _id_06EF::_id_E1E5(var_0, var_6._id_CDC1, 1, undefined, var_6.origin);
          var_6._id_4DBA.angles = var_6.angles;
          var_6._id_4DBA.target = var_6.target;
          var_6._id_4DBA._id_0394 = var_6._id_0394;
          var_6._id_4DBA.n_open_time = default_to(var_6._id_CE85, self._id_CE85);
          var_6._id_4DBA.str_open_sound = default_to(var_6._id_CE4B, self._id_CE4B);
        }

        var_1 = scripts\engine\utility::array_add(var_1, var_6._id_4DBA);
      }
    }

    if(isDefined(self.target2)) {
      var_8 = getscriptablearray(self.target2, "targetname");
      var_1 = scripts\engine\utility::_id_1B9D(var_1, var_8);
      var_9 = getEntArray(self.target2, "targetname");
      var_1 = scripts\engine\utility::_id_1B9D(var_1, var_9);
    }

    foreach(var_2 in var_1) {
      if(isent(var_2)) {
        if(var_2 _meth_86EE()) {
          var_2 setscriptablepartstate("base", "closed");
        } else if(isDefined(var_2.target)) {
          var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
          var_2.v_open_pos = var_3.origin;
          var_2.v_open_ang = var_3.angles;
        } else if(isDefined(var_2.target2)) {
          var_3 = scripts\engine\utility::getstruct(var_2.target2, "targetname");
          var_2.v_open_pos = var_3.origin;
          var_2.v_open_ang = var_3.angles;
        }

        var_2.n_open_time = default_to(var_2._id_CE85, self._id_CE85);
        var_2.str_open_sound = default_to(var_2._id_CE4B, self._id_CE4B);
        var_2.b_doorbuy_opening = undefined;
      }
    }
  }

  self._id_425E = default_to(self._id_0359, 40);
  self.script_cost = default_to(self.script_cost, 500);
  self._id_4E4C = var_1;
  level.a_s_doorbuys = scripts\engine\utility::array_add(level.a_s_doorbuys, self);

  if(!istrue(self._id_7D67)) {
    _id_0737::_id_1037(self);
  }
}

check_doorbuy_labels(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = strtok(var_0, ",");
  return scripts\engine\utility::array_contains(var_2, var_1);
}

get_doorbuy_hint_func(var_0, var_1) {
  if(isDefined(var_0._id_CD83)) {
    return var_0._id_CD83;
  }

  if(_id_0737::_id_838E(var_0)) {
    return &"CP_ZM_OASIS/POWER_DOOR_HINT";
  } else {
    if(isDefined(var_1._id_8388)) {
      var_1._id_8388 _meth_8557(default_to(var_0.script_cost, 500));
    }

    if(check_doorbuy_labels(var_0._id_CD99, "obstacle")) {
      if(isDefined(var_0.script_cost) && !var_1 _id_074E::_id_B4C5(var_0.script_cost)) {
        return &"CP_ZMB_INTERACTIONS_TUGOLF/DEBRIBUY_HINT_NEED_MONEY";
      } else {
        return &"CP_ZMB_INTERACTIONS_TUGOLF/DEBRIBUY_HINT";
      }
    } else if(isDefined(var_0.script_cost) && !var_1 _id_074E::_id_B4C5(var_0.script_cost))
      return &"CP_ZMB_INTERACTIONS_TUGOLF/DOORBUY_HINT_NEED_MONEY";
    else {
      return &"CP_ZMB_INTERACTIONS_TUGOLF/DOORBUY_HINT";
    }
  }
}

get_doorbuy_hint_type_func(var_0, var_1) {
  if(_id_0737::_id_838E(var_0)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

get_doorbuy_override_cost_func(var_0, var_1, var_2) {
  return default_to(var_0.script_cost, 500);
}

doorbuy_used(var_0, var_1) {
  if(_func_0107(var_0._id_4E4C)) {
    foreach(var_3 in var_0._id_4E4C) {
      if(isDefined(var_3)) {
        var_3 thread open_doorbuy();
      }
    }
  }

  if(isDefined(var_0._id_CD49)) {
    var_5 = strtok(var_0._id_CD49, ",");

    foreach(var_7 in var_5) {
      scripts\engine\utility::_id_5C1B(var_7);
    }
  }

  level notify("door_opened", var_0);

  if(getDvar("#x36d16f02578d0ee10") != "cp_zm_oasis") {
    if(isPlayer(var_1)) {
      var_1 playlocalsound("zmb_ui_purchase_accept");
    }
  }

  waitframe();
  var_9 = [];

  if(isDefined(var_0._id_0481)) {
    var_9 = scripts\engine\utility::getstructarray(var_0._id_0481, "targetname");
  } else {
    var_9[0] = var_0;
  }

  foreach(var_11 in var_9) {
    if(isDefined(var_11.markerlabel) && isDefined(var_11.instanceindex)) {
      _id_0987::remove_instanced_objective_marker(var_11.markerlabel, var_11.instanceindex);
      var_11.markerlabel = undefined;
      var_11.instanceindex = undefined;
    }

    if(isDefined(var_11) && istrue(var_11._id_0394)) {
      var_11 delete();
      continue;
    }

    _id_0737::_id_C3C5(var_11);
  }
}

open_doorbuy() {
  if(istrue(self.b_doorbuy_opening)) {
    return;
  }
  self endon("death");
  self.b_doorbuy_opening = 1;
  self _meth_8093();

  if(self _meth_86EE()) {
    self setscriptablepartstate("base", "opening");

    if(istrue(self._id_0394)) {
      self _meth_86BE();
    }
  } else {
    var_0 = default_to(self.n_open_time, 2);

    if(var_0 <= 0) {
      var_0 = 0.05;
    }

    if(isDefined(self.str_open_sound)) {
      self playSound(self.str_open_sound);
    }

    if(isDefined(self.v_open_pos)) {
      self moveto(self.v_open_pos, var_0);

      if(isDefined(self.v_open_ang)) {
        self rotateto(self.v_open_ang, var_0);
      }

      self waittill("movedone");
      self _meth_80B5();
    } else
      self delete();

    if(istrue(self._id_0394)) {
      self delete();
    }
  }
}

open_power_doors(var_0) {
  foreach(var_2 in level.a_s_doorbuys) {
    if(isDefined(var_2) && _id_0737::_id_838E(var_2)) {
      if(isDefined(var_0) && (!isDefined(var_2.script_int) || var_2.script_int != var_0)) {
        continue;
      }
      doorbuy_used(var_2);
    }
  }
}

wait_flag_open_door(var_0) {
  self endon("death");
  self endon("remove_from_current_interaction_list");
  var_1 = strtok(var_0, ",");
  scripts\engine\utility::_id_5C28(var_1);
  level thread doorbuy_used(self);
}

default_to(var_0, var_1) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return var_1;
}