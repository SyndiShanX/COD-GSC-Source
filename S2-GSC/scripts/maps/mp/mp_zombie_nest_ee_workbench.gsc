/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_workbench.gsc
***********************************************************/

_id_536B() {
  var_0 = spawnStruct();
  var_0._id_10BD = _getEnt("assemble_ww_trig", "targetname");
  var_0._id_AA68 = _getscriptablearray(var_0._id_10BD.target, "targetname");

  foreach(var_2 in var_0._id_AA68) {
    var_3 = var_2 _meth_85CE();

    switch (var_3) {
      case "animated_zmb_workbench_doors":
        var_0._id_3291 = var_2;
        break;
      default:
        break;
    }
  }

  var_5 = getEntArray(var_0._id_10BD.target, "targetname");

  foreach(var_7 in var_5) {
    if(!isDefined(var_7._id_0165)) {
      continue;
    }
    var_8 = var_7._id_0165;

    switch (var_8) {
      case "workbench_gunrack":
        var_0._id_48F2 = var_7;
        var_0._id_48F2 hide();
        break;
      case "ww_model_frame":
      case "ww_model":
        var_0._id_10C0 = var_7;
        var_0._id_10C0 hide();
        break;
      case "ww_model_barrel":
        var_0._id_10BE = var_7;
        var_0._id_10BE hide();
        break;
      case "ww_model_core":
        var_0._id_10BF = var_7;
        var_0._id_10BF hide();
        break;
      default:
        break;
    }
  }

  var_0._id_10BE linkTo(var_0._id_10C0);
  var_0._id_10BF linkTo(var_0._id_10C0);
  var_0._id_6FDB = getEntArray(var_0._id_10C0.target, "targetname");

  foreach(var_11 in var_0._id_6FDB) {
    var_11 common_scripts\utility::_id_9D9F();
  }

  level._id_AA67 = var_0;
  thread _id_AA6C();
  var_0 thread _id_AA6B();
}

_id_536D() {
  level._id_3578 = 0;

  if(!isDefined(level._id_AACA)) {
    level._id_AACA = [];
  }

  var_0 = common_scripts\utility::_id_46B5("ww_upgrade_pickup_central", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = [];
  var_1 = _id_536C(var_0);
  return var_1;
}

_id_536C(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    switch (var_4._id_0165) {
      case "ww_upgrade_pickup_blue":
        var_2["moon weapon trig"] = var_4;
        break;
      case "ww_upgrade_pickup_purple":
        var_2["storm weapon trig"] = var_4;
        break;
      case "ww_upgrade_pickup_red":
        var_2["blood weapon trig"] = var_4;
        break;
      case "ww_upgrade_pickup_black":
        var_2["death weapon trig"] = var_4;
        break;
      default:
        break;
    }
  }

  return var_2;
}

#using_animtree("animated_props_zombies");

_id_AA6B() {
  var_0 = _id_AA70();
  maps\mp\gametypes\zombies::_id_47A8("ZM_TESLA");
  thread maps\mp\mp_zombie_nest_ee_util::_id_08A8();
  level._id_3571 thread maps\mp\mp_zombie_nest_ee_cart::_id_202D("com_2");
  _id_0378::_id_8D74("aud_activate_workbench", self._id_48F2.origin);
  common_scripts\utility::flag_set("flag_ww_forged");
  level notify("stop_workbench_assembly_info");
  _id_0559::_id_2D8E(level._id_AA67._id_4D91);
  self._id_10BD delete();
  var_1 = % zmb_workbench_01_gunrack_spin;
  var_2 = _getanimlength(var_1);
  self._id_48F2 scriptmodelplayanimdeltamotion(_debuggetanimname(var_1));
  thread _id_74C8(var_1, "zmb_tesla_gunrack_beam", self._id_48F2, self._id_48F2, "beam_start", "beam_end", "charger_l", "charger_r");
  wait(var_2);

  foreach(var_4 in self._id_6FDB) {
    var_4 common_scripts\utility::_id_9DA3();
  }

  thread _id_AA6D(self._id_10C0, var_0);
}

_id_AA70() {
  self._id_10BD useTriggerRequireLookAt();
  self._id_10BD thread _id_AA6A();
  var_0 = undefined;
  var_1 = "flag_ww_part_01_placed";
  var_2 = "flag_ww_part_02_placed";
  var_3 = _id_0557::_id_7838("4 cart", "head to com");
  var_4 = "flag_ww_part_01_picked_up";
  var_5 = "flag_ww_part_02_picked_up";

  for(;;) {
    self._id_10BD waittill("trigger", var_0);

    if(common_scripts\utility::_id_3C77(var_4) && common_scripts\utility::_id_3C77(var_5) && common_scripts\utility::_id_3C77(var_3)) {
      if(!common_scripts\utility::_id_3C77(var_1) || !common_scripts\utility::_id_3C77(var_2)) {
        self._id_10BF show();
        self._id_10BE show();
        common_scripts\utility::flag_set(var_1);
        common_scripts\utility::flag_set(var_2);
      }

      break;
    } else if(common_scripts\utility::_id_3C77(var_4) && common_scripts\utility::_id_3C77(var_5)) {
      if(!common_scripts\utility::_id_3C77(var_1) || !common_scripts\utility::_id_3C77(var_2)) {
        self._id_10C0 linkTo(self._id_48F2, "clamp");
        self._id_10BF show();
        self._id_10BE show();
        common_scripts\utility::flag_set(var_1);
        common_scripts\utility::flag_set(var_2);
      }

      continue;
    } else if(common_scripts\utility::_id_3C77(var_4)) {
      if(!common_scripts\utility::_id_3C77(var_1)) {
        self._id_10BE show();
        common_scripts\utility::flag_set(var_1);
      }

      if(!isDefined(var_0._id_3079) && isPlayer(var_0)) {
        var_6 = var_0 _id_0367::_id_8E3D("workbenchpart2", undefined, 1);

        if(isDefined(var_6)) {
          var_0._id_3079 = 1;
        }
      }

      continue;
    } else {
      if(!isDefined(var_0._id_3078) && isPlayer(var_0)) {
        var_6 = var_0 _id_0367::_id_8E3D("workbenchpart", undefined, 1);

        if(isDefined(var_6)) {
          var_0._id_3078 = 1;
        }
      }

      continue;
    }
  }

  return var_0;
}

_id_AA6A() {
  self setHintString(&"ZOMBIES_BUILDABLE_NO_PARTS");
  var_0 = "flag_ww_part_01_picked_up";
  var_1 = "flag_ww_part_02_picked_up";
  var_2 = "flag_ww_part_01_placed";
  var_3 = "flag_ww_part_02_placed";
  var_4 = _id_0557::_id_7838("4 cart", "head to com");
  common_scripts\utility::_id_3C9F(var_0);
  _id_7C05();
  self setHintString(&"ZOMBIE_NEST_PLACE_WW_PART");
  var_5 = common_scripts\utility::_id_3CA4(var_2, var_1);

  if(var_5 == var_2) {
    self setHintString(&"ZOMBIES_BUILDABLE_NO_PARTS");
    common_scripts\utility::_id_3C9F(var_1);
    self setHintString(&"ZOMBIE_NEST_PLACE_WW_PART");
  }

  var_5 = common_scripts\utility::_id_3CA4(var_3, var_4);

  if(var_5 == var_3) {
    self setHintString(&"ZOMBIE_NEST_WAITING_FOR_CART");
    common_scripts\utility::_id_3C9F(var_4);
  }

  self setHintString(&"ZOMBIE_NEST_ASSEMBLE_WW");
}

_id_7C05() {
  level._id_AA67._id_4D91 = _id_0559::_id_7BE3(level._id_AA67._id_10BD, "teslagun_station");
}

_id_AA6D(var_0, var_1) {
  var_2 = "teslagun_zm";
  var_3 = getEntArray(var_0.target, "targetname");

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_3[var_4]._id_AAC5 = var_0;
    level thread _id_AA6E(var_3[var_4], var_2);

    if(level._id_A980 <= 6) {
      level._id_400E[level._id_400E.size] = ["raven_set 4 1", "all"];
    }
  }
}

_id_AA6E(var_0, var_1) {
  level endon("game_ended");
  var_0._id_A9E0 = var_1;
  var_0._id_6C5C = var_1;
  var_0._id_9DA0 = 0;
  var_0._id_2925 = 5000;
  _id_0547::_id_8A4F(var_0, ::_id_10E7);

  for(;;) {
    [var_3, var_4] = var_0 _id_0547::_id_A795();
    var_5 = var_3 getcurrentprimaryweapon();

    if(_id_0547::_id_57AF(var_5) || _id_0547::_id_5862(var_5) || _id_0547::iszombieconsumableweapon(var_5)) {
      continue;
    }
    var_6 = var_3 getweaponlistprimaries();
    var_7 = var_3 getweaponlistall();
    var_8 = 0;

    if(var_6.size > 0) {
      foreach(var_10 in var_6) {
        if(issubstr(var_10, "teslagun_zm")) {
          var_8 = 1;
        }
      }
    }

    if(_id_0547::_id_73F9(var_3, var_1)) {
      if(!0) {
        continue;
      }
      if(_id_0548::_id_4B6A(var_3, var_1)) {
        _id_0548::_id_300A(var_3, 0);
        continue;
      }

      if(!var_3 maps\mp\gametypes\zombies::_id_11C2(var_0._id_2925)) {
        var_3 thread _id_054E::_id_0695("needmoney");
        continue;
      }
    } else if(var_8) {
      foreach(var_10 in var_6) {
        if(issubstr(var_10, "teslagun_zm")) {
          var_3 _id_0586::_id_0790(var_10);
        }
      }
    } else if(!var_3 _id_0586::_id_05DF(var_1)) {
      var_14 = var_3 _id_0586::_id_0637();

      if(_weapontype(var_14) != "melee") {
        var_3 _id_0586::_id_0790(var_14);
      }
    }

    level._id_400E[level._id_400E.size] = ["survivalist_set 3 -1", var_3];
    level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", var_3];
    var_3 _id_0586::_id_078C(var_1);

    if(isDefined(var_3._id_A2AF) && isDefined(var_3._id_A2AF[var_1])) {
      var_3 setweaponammostock(var_1, var_3._id_A2AF[var_1]);
    }

    if(isDefined(var_3._id_A2B0) && isDefined(var_3._id_A2B0[var_1])) {
      var_3 setweaponammoclip(var_1, var_3._id_A2B0[var_1]);
    } else {
      var_3 setweaponammoclip(var_1, _weaponclipsize(var_1));
    }

    var_3 _id_0586::_id_078E(var_1);
    var_3 thread _id_AA69(var_1);
    level thread _id_AA78(var_3, var_1, 0);
  }
}

_id_AA6C() {
  level._id_AA67._id_3291 setscriptablepartstate("doors", "open", 0);
  var_0 = % zmb_workbench_01_gunrack_up_01;
  level._id_AA67._id_48F2 show();

  if(isDefined(level._id_AA67._id_10C0)) {
    level._id_AA67._id_10C0 show();
    level._id_AA67._id_10C0 linkTo(level._id_AA67._id_48F2, "clamp");
  }

  level._id_AA67._id_48F2 scriptmodelplayanimdeltamotion(_debuggetanimname(var_0));
  var_1 = _getanimlength(var_0) * 0.5;
  wait(var_1);
}

_id_10E7(var_0) {
  _id_0559::_id_7BE2(var_0, self, "teslagun");
  thread _id_AA6F(var_0);
}

_id_AA6F(var_0) {
  var_0 endon("disconnect");
  var_1 = 1;
  var_2 = _id_0552::_id_7BE1(var_0, self);

  for(;;) {
    if(var_1) {
      var_1 = 0;
    } else {
      var_0 common_scripts\utility::_id_A70A("weapon_change", "new_equipment");
    }

    var_3 = 0;
    var_4 = "";
    var_5 = 0;
    var_6 = var_0 getweaponlistall();

    foreach(var_8 in var_6) {
      var_4 = _getweaponbasename(var_8);

      if(var_4 == self._id_A9E0) {
        var_3 = 1;
        break;
      }

      if(issubstr(var_8, "teslagun_zm")) {
        var_5 = 1;
      }
    }

    var_10 = var_0 getcurrentprimaryweapon();

    if(0) {
      self setCursorHint("HINT_NOICON");
    }

    if(_id_0547::_id_57AF(var_10) || _id_0547::_id_5862(var_10) || _id_0547::iszombieconsumableweapon(var_10)) {
      if(0) {
        self setHintString("");
        self setsecondaryhintstring("");
        self._id_3006 = undefined;
      }

      if(1) {
        var_2._id_2F74 = 1;
        var_2._id_6642 = 1;
      }

      continue;
    }

    if(var_3) {
      if(0) {
        self._id_3006 = self._id_2925;

        if(0) {
          self setHintString(_id_0548::_id_4412(self));
          self setsecondaryhintstring(_id_0548::_id_4411(self, 0));
        }

        if(1) {}
      } else {
        if(0) {
          self setHintString("");
          self setsecondaryhintstring("");
          self._id_3006 = undefined;
        }

        if(1) {
          var_2._id_2F74 = 1;
          var_2._id_6642 = 1;
        }
      }

      continue;
    }

    if(var_5 && !var_3) {
      if(1) {
        var_2._id_4028 = _id_0552::_id_44FF("ww_already_have");
        var_2._id_2F74 = 0;
        var_2._id_6642 = 1;
      }

      continue;
    }

    self._id_3006 = 0;

    if(0) {
      self setHintString(&"ZOMBIE_NEST_PICKUP_WW");
    }

    if(1) {
      var_2._id_4028 = _id_0552::_id_44FF("ww_pickup");
      var_2._id_2F74 = 0;
      var_2._id_6642 = 1;
    }
  }
}

_id_74C8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = _getnotetracktimes(var_0, var_4);
  var_9 = var_8[0] * _getanimlength(var_0);
  var_10 = _getnotetracktimes(var_0, var_5);
  var_11 = var_10[0] * _getanimlength(var_0);
  wait(var_9);
  var_12 = _func_382(var_1, var_2, var_6, var_3, var_7);
  wait(var_11 - var_9);
  var_12 delete();
}

_id_AA75() {
  var_0 = common_scripts\utility::_id_46B5("ww_upgrade_pickup_central", "targetname");
  self _meth_8660(1, var_0.origin);
  common_scripts\utility::_id_9D9F();
  var_1 = _getscriptablearray(self.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 _meth_85CE();

    switch (var_4) {
      case "animated_zmb_workbench_doors":
        self._id_3291 = var_3;
        break;
      default:
        break;
    }
  }

  var_6 = getEntArray(self.target, "targetname");

  foreach(var_8 in var_6) {
    if(!isDefined(var_8._id_0165)) {
      continue;
    }
    switch (var_8._id_0165) {
      case "workbench_gunrack":
        self._id_48F2 = var_8;
        self._id_48F2 hide();
        self._id_48F2._id_9189 = self._id_48F2.angles;
        self._id_48F2._id_9255 = self._id_48F2.origin;
        break;
      case "workbench_ww_model":
        self._id_AAC8 = var_8;
        self._id_AAC8 hide();
        break;
      case "workbench_ww_model_core":
        self._id_AAC7 = var_8;
        self._id_AAC7 hide();
        break;
      case "workbench_ww_model_barrel":
        self._id_AAC6 = var_8;
        self._id_AAC6 hide();
        break;
    }
  }

  if(isDefined(self._id_48F2) && isDefined(self._id_AAC8)) {
    self._id_AAC8 linkTo(self._id_48F2, "clamp");
  }

  if(isDefined(self._id_48F2) && isDefined(self._id_AAC7)) {
    self._id_AAC7 linkTo(self._id_48F2, "clamp");
  }

  if(isDefined(self._id_48F2) && isDefined(self._id_AAC6)) {
    self._id_AAC6 linkTo(self._id_48F2, "clamp");
  }
}

_id_AA73(var_0) {
  level notify(self._id_A9E0 + "_assembled");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_2916 = "building";
  self._id_78A1 = "working";

  if(!level._id_3578) {
    thread _id_AA74();
  }

  if(var_0) {
    self._id_AAC8 show();
    self._id_AAC6 show();
    self._id_AAC7 show();
  }

  var_1 = self._id_3291 _meth_866B("doors");

  if(var_1 != "opened_idle") {
    self._id_3291 _id_AA7E("opened_idle");
  }

  var_2 = % zmb_workbench_01_gunrack_up_01;
  var_3 = % zmb_workbench_01_gunrack_up_idle_01;
  var_4 = % zmb_workbench_01_gunrack_down_01;
  var_5 = % zmb_workbench_01_gunrack_spin;
  var_6 = _getanimlength(var_4);
  var_7 = _getanimlength(var_2);
  var_8 = _func_382("zmb_tesla_gunrack_beam", self._id_48F2, "charger_l", self._id_48F2, "charger_r");
  self._id_48F2 scriptmodelclearanim();
  self._id_48F2 scriptmodelplayanimdeltamotion(_debuggetanimname(var_4));
  wait(var_6);
  self._id_3291 _id_AA7E("close");
  self._id_AAC6 show();
  self._id_AAC7 show();
  self._id_AAC8 show();
  _id_AA77();
  wait 3;
  self._id_48F2 scriptmodelclearanim();
  self._id_48F2 scriptmodelplayanimdeltamotionfrompos(_debuggetanimname(var_2), self._id_48F2._id_9255, self._id_48F2._id_9189);
  wait 0.1;
  self._id_48F2 setshadowrendering(1);
  self._id_3291 _id_AA7E("open");
  self._id_48F2 setshadowrendering(0);
  wait(var_7 - 0.1);
  var_8 delete();
  self._id_48F2 scriptmodelclearanim();
  self._id_48F2 scriptmodelplayanim(_debuggetanimname(var_5), "", 9.2);
  wait 0.866667;
  self._id_78A1 = "finished";
  self._id_2916 = "available";
}

_id_AA74() {
  level._id_3578 = 1;
  thread maps\mp\mp_zombie_nest_ee_util::_id_08A8();
  _id_0378::_id_8D74("aud_activate_workbench", self._id_48F2.origin);
  level._id_3571 maps\mp\mp_zombie_nest_ee_cart::_id_202D("com_2");
  level._id_3578 = 0;
}

_id_AA7E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "closed_idle";
  }

  var_1 = 0;
  var_2 = 0.1;

  switch (var_0) {
    case "closed_idle":
      var_2 = 0.166667;
      var_1 = 1;
      break;
    case "close":
      var_2 = 1.4;
      var_1 = 1;
      break;
    case "open":
      var_2 = 2.03333;
      var_1 = 1;
      break;
    case "opened_idle":
      var_2 = 0.2;
      var_1 = 1;
      break;
    default:
      break;
  }

  if(var_1) {
    self setscriptablepartstate("doors", var_0);
    wait(var_2);
  }
}

_id_AA7A(var_0) {
  self endon("disconnect");
  var_1 = % zmb_workbench_01_gunrack_up_01;
  var_2 = % zmb_workbench_01_gunrack_up_idle_01;
  var_3 = % zmb_workbench_01_gunrack_up_idle_02;
  var_4 = % zmb_workbench_01_gunrack_down_01;
  var_5 = % zmb_workbench_01_gunrack_idle_01;
  var_6 = % zmb_workbench_01_gunrack_spin;
  var_7 = _getanimlength(var_4);
  var_8 = _getanimlength(var_1);
  var_0._id_78A1 = "opening";
  var_0._id_48F2 show();

  if(var_0._id_2916 == "available") {
    var_0._id_AAC5 show();
  }

  var_0._id_48F2 scriptmodelclearanim();
  var_0._id_48F2 scriptmodelplayanimdeltamotionfrompos(_debuggetanimname(var_1), var_0._id_48F2._id_9255, var_0._id_48F2._id_9189);
  wait 0.1;
  var_0._id_48F2 setshadowrendering(1);
  var_0._id_3291 _id_AA7E("open");
  var_0._id_48F2 setshadowrendering(0);
  wait(var_8 - 0.1);
  var_0._id_48F2 scriptmodelclearanim();
  var_0._id_48F2 scriptmodelplayanim(_debuggetanimname(var_6), "", 9.2);
  wait 0.866667;
  var_0._id_78A1 = "opened";
}

_id_AA77() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  switch (self._id_A9E0) {
    case "teslagun_zm_blood":
      var_0 = "zmb_teslagun_crystal_01_blood";
      var_1 = "zmb_teslagun_barrel_01_blood";
      var_2 = "zmb_teslagun_base_01_blood";
      break;
    case "teslagun_zm_storm":
      var_0 = "zmb_teslagun_crystal_01_storm";
      var_1 = "zmb_teslagun_barrel_01_storm";
      var_2 = "zmb_teslagun_base_01_storm";
      break;
    case "teslagun_zm_moon":
      var_0 = "zmb_teslagun_crystal_01_moon";
      var_1 = "zmb_teslagun_barrel_01_moon";
      var_2 = "zmb_teslagun_base_01_moon";
      break;
    case "teslagun_zm_death":
      var_0 = "zmb_teslagun_crystal_01_death";
      var_1 = "zmb_teslagun_barrel_01_death";
      var_2 = "zmb_teslagun_base_01_death";
      break;
  }

  if(isDefined(var_0)) {
    self._id_AAC7 setModel(var_0);
  }

  if(isDefined(var_1)) {
    self._id_AAC6 setModel(var_1);
  }

  if(isDefined(var_2)) {
    self._id_AAC8 setModel(var_2);
  }
}

_id_AA79(var_0) {
  self endon("disconnect");
  level endon(var_0._id_A9E0 + "_assembled");
  var_1 = 250;
  var_2 = var_1 * var_1;
  var_3 = % zmb_workbench_01_gunrack_up_01;
  var_4 = % zmb_workbench_01_gunrack_up_idle_01;
  var_5 = % zmb_workbench_01_gunrack_up_idle_02;
  var_6 = % zmb_workbench_01_gunrack_down_01;
  var_7 = % zmb_workbench_01_gunrack_idle_01;
  var_8 = % zmb_workbench_01_gunrack_spin;
  var_9 = _getanimlength(var_6);
  var_10 = _getanimlength(var_3);

  for(;;) {
    if(distancesquared(self.origin, var_0._id_48F2._id_9255) > var_2 && var_0._id_78A1 == "opened") {
      var_0._id_78A1 = "closing";
      var_0._id_9D65 makeunusable();
      var_0._id_48F2 scriptmodelclearanim();
      var_0._id_48F2 scriptmodelplayanimdeltamotion(_debuggetanimname(var_6), "");
      wait(var_9);
      var_0._id_3291 _id_AA7E("close");
      var_0._id_48F2 hide();

      if(var_0._id_2916 == "available") {
        var_0._id_AAC5 hide();
      }

      var_0._id_78A1 = "closed";
    } else if(distancesquared(self.origin, var_0._id_48F2._id_9255) < var_2 && var_0._id_78A1 == "closed") {
      var_0._id_78A1 = "opening";
      var_0._id_48F2 show();

      if(var_0._id_2916 == "available") {
        var_0._id_AAC5 show();
      }

      var_0._id_48F2 scriptmodelclearanim();
      var_0._id_48F2 scriptmodelplayanimdeltamotionfrompos(_debuggetanimname(var_3), var_0._id_48F2._id_9255, var_0._id_48F2._id_9189);
      wait 0.1;
      var_0._id_48F2 setshadowrendering(1);
      var_0._id_3291 _id_AA7E("open");
      var_0._id_48F2 setshadowrendering(0);
      wait(var_10 - 0.1);
      var_0._id_48F2 scriptmodelclearanim();
      var_0._id_48F2 scriptmodelplayanim(_debuggetanimname(var_8), "", 9.2);
      wait 0.866667;
      var_0._id_9D65 makeusable();
      var_0._id_78A1 = "opened";
    }

    wait 0.25;
  }
}

_id_AA7D(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_9D65 = var_1;
  var_2._id_AAC7 = var_1._id_AAC7;
  var_2._id_AAC8 = var_1._id_AAC8;
  var_2._id_AAC6 = var_1._id_AAC6;
  var_2._id_48F2 = var_1._id_48F2;
  var_2._id_3291 = var_1._id_3291;
  var_2._id_A9E0 = var_0;
  var_2._id_2916 = "not built";
  var_2._id_78A1 = "closed";
  var_2._id_2909 = undefined;
  return var_2;
}

_id_AA76() {
  var_0 = "teslagun";

  if(self._id_A9E0 == "teslagun_zm_blood") {
    var_0 = "teslagun_blood";
  } else if(self._id_A9E0 == "teslagun_zm_storm") {
    var_0 = "teslagun_storm";
  } else if(self._id_A9E0 == "teslagun_zm_moon") {
    var_0 = "teslagun_moon";
  } else if(self._id_A9E0 == "teslagun_zm_death") {
    var_0 = "teslagun_death";
  }

  _id_0559::_id_7BE3(self._id_9D65, var_0);

  for(;;) {
    [var_2, var_3] = self._id_9D65 _id_0547::_id_A795();
    var_4 = var_2 getcurrentprimaryweapon();

    if(_id_0547::_id_57AF(var_4) || _id_0547::_id_5862(var_4) || _id_0547::iszombieconsumableweapon(var_4)) {
      continue;
    }
    var_5 = var_2 _id_0548::_id_473B();
    var_6 = 0;
    var_7 = 0;

    if(var_5.size > 0) {
      foreach(var_9 in var_5) {
        if(self._id_A9E0 == var_9) {
          var_6 = 1;
        }

        if(issubstr(var_9, "teslagun_zm")) {
          var_7 = 1;
        }
      }
    }

    if(var_6) {
      continue;
    } else if(var_7) {
      foreach(var_9 in var_5) {
        if(issubstr(var_9, "teslagun_zm")) {
          var_2 _id_0586::_id_0790(var_9);
        }
      }
    } else if(!var_2 _id_0586::_id_05DF(self._id_A9E0)) {
      var_13 = var_2 _id_0586::_id_0637();

      if(_weapontype(var_13) != "melee") {
        var_2 _id_0586::_id_0790(var_13);
      }
    }

    level._id_400E[level._id_400E.size] = ["survivalist_set 3 -1", var_2];
    level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", var_2];
    var_2 _id_0586::_id_078C(self._id_A9E0);

    if(isDefined(var_2._id_A2AF) && isDefined(var_2._id_A2AF[self._id_A9E0])) {
      var_2 setweaponammostock(self._id_A9E0, var_2._id_A2AF[self._id_A9E0]);
    }

    if(isDefined(var_2._id_A2B0) && isDefined(var_2._id_A2B0[self._id_A9E0])) {
      var_2 setweaponammoclip(self._id_A9E0, var_2._id_A2B0[self._id_A9E0]);
    } else {
      var_2 setweaponammoclip(self._id_A9E0, _weaponclipsize(self._id_A9E0));
    }

    var_2 _id_0586::_id_078E(self._id_A9E0);
    _id_AA7C(self._id_A9E0, var_2);
    var_2 thread _id_AA69(self._id_A9E0);
    level thread _id_AA78(var_2, self._id_A9E0);
    return;
  }
}

_id_AA78(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  for(;;) {
    var_3 = var_0 common_scripts\utility::waittill_any_return("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");

    if(var_3 == "weapon_change") {
      if(_id_0547::_id_577E(var_0)) {
        continue;
      } else if(!_id_0547::_id_73F9(var_0, var_1)) {
        if(var_2) {
          _id_AA7B(var_1);
          level._id_AACA[var_1] thread _id_AA76();
        }

        level notify(var_1 + "_stop_tracking");
        return;
      }
    } else if(var_3 == "bleedout" || var_3 == "becameSpectator" || var_3 == "disconnect") {
      if(var_2) {
        _id_AA7B(var_1);
        level._id_AACA[var_1] thread _id_AA76();
      }

      return;
    }
  }
}

_id_AA7B(var_0) {
  level._id_AACA[var_0] _id_AA73(0);
  level._id_AACA[var_0]._id_9D65 common_scripts\utility::_id_9DA3();
  level._id_AACA[var_0]._id_9D65._id_AAC8 show();
  level._id_AACA[var_0]._id_9D65._id_AAC7 show();
  level._id_AACA[var_0]._id_9D65._id_AAC6 show();
  level._id_AACA[var_0]._id_2916 = "available";
  level._id_AACA[var_0]._id_2909 = undefined;
}

_id_AA7C(var_0, var_1) {
  level._id_AACA[var_0]._id_9D65 common_scripts\utility::_id_9D9F();
  level._id_AACA[var_0]._id_9D65._id_AAC8 hide();
  level._id_AACA[var_0]._id_9D65._id_AAC7 hide();
  level._id_AACA[var_0]._id_9D65._id_AAC6 hide();
  level._id_AACA[var_0]._id_2916 = "taken";
  level._id_AACA[var_0]._id_2909 = var_1;
}

_id_AA72(var_0) {
  var_1 = &"ZOMBIE_NEST_GRAB_DEATH";

  switch (var_0) {
    case "teslagun_zm_moon":
      var_1 = &"ZOMBIE_NEST_GRAB_MOON";
      break;
    case "teslagun_zm_death":
      var_1 = &"ZOMBIE_NEST_GRAB_DEATH";
      break;
    case "teslagun_zm_blood":
      var_1 = &"ZOMBIE_NEST_GRAB_BLOOD";
      break;
    case "teslagun_zm_storm":
      var_1 = &"ZOMBIE_NEST_GRAB_STORM";
      break;
  }

  return var_1;
}

_id_AA71(var_0) {
  var_1 = &"ZOMBIE_NEST_ASSEMBLE_DEATH";

  switch (var_0) {
    case "teslagun_zm_moon":
      var_1 = &"ZOMBIE_NEST_ASSEMBLE_MOON";
      break;
    case "teslagun_zm_death":
      var_1 = &"ZOMBIE_NEST_ASSEMBLE_DEATH";
      break;
    case "teslagun_zm_blood":
      var_1 = &"ZOMBIE_NEST_ASSEMBLE_BLOOD";
      break;
    case "teslagun_zm_storm":
      var_1 = &"ZOMBIE_NEST_ASSEMBLE_STORM";
      break;
  }

  return var_1;
}

_id_AA69(var_0) {
  self endon("death");
  level endon(var_0 + "_stop_tracking");

  for(;;) {
    common_scripts\utility::_id_A70C(self, "missile_fire", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");

    if(self hasweapon(var_0)) {
      self._id_A2AF[var_0] = self getweaponammostock(var_0);
      self._id_A2B0[var_0] = self getweaponammoclip(var_0);
    }
  }
}