/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1908.gsc
*************************************************/

_id_8114() {
  level._effect["pap_idle"] = loadfx("vfx/s4/zombie/vfx_pap_idle.vfx");
  level._effect["pap_activate"] = loadfx("vfx/s4/zombie/vfx_pap_active.vfx");
  level._id_AE11 = 3;
  level._id_10D22 = ::_id_C2CD;
  level._id_AE13 = 1;
  level._id_AE14 = [];
  level._id_AE14[level._id_AE14.size] = 0;

  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    level._id_AE14[level._id_AE14.size] = 7500;
    level._id_AE14[level._id_AE14.size] = 15000;
    level._id_AE14[level._id_AE14.size] = 30000;
  } else {
    level._id_AE14[level._id_AE14.size] = 5000;
    level._id_AE14[level._id_AE14.size] = 15000;
    level._id_AE14[level._id_AE14.size] = 30000;
  }

  level._id_AE16 = [];
  level._id_AE16[level._id_AE16.size] = "zm_";
  level._id_AE16[level._id_AE16.size] = "zm_pack_";
  level._id_AE16[level._id_AE16.size] = "zm_pack_";
  level._id_AE16[level._id_AE16.size] = "zm_pack_";
  level._id_AE0B = scripts\cp\utility::_id_459B(level._id_AE0B, "none");
  level._id_AE0C = scripts\cp\utility::_id_459B(level._id_AE0C, "none");
  level._id_AE0D = scripts\cp\utility::_id_459B(level._id_AE0D, "none");
  level._id_1092 = ::_id_0F9E;
  level._id_6F89 = ::_id_6F21;
  level._id_6E79 = ::_id_684B;
  level.updatecurrentpapstatus = ::update_current_pap_status;
  level.pap_num_random_attachments = [];
  level.pap_num_random_attachments[level.pap_num_random_attachments.size] = 0;
  level.pap_num_random_attachments[level.pap_num_random_attachments.size] = 3;
  level.pap_num_random_attachments[level.pap_num_random_attachments.size] = 5;
  level.pap_num_random_attachments[level.pap_num_random_attachments.size] = 10;
  _id_095C::_id_C287(::_id_10D24);
}

_id_7EC1(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::getStructArray(var_3._id_039B, "script_noteworthy");
  }

  level._id_683F = scripts\cp\cp_weapon::_id_683D;

  foreach(var_6 in var_1) {
    var_6._id_BAD8 = 1;
    var_6 thread _id_80EE();
  }
}

_id_C2CD() {
  _id_0737::_id_C266("weapon_upgrade", ::_id_10D21, ::_id_FDED, ::_id_7EC1, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_pap", 92, getdvarint("#x3dee089cb49164e4e", 0));
  _id_0737::addinteractionhinttypecallback("weapon_upgrade", ::weapon_upgrade_hint_type);
}

_id_80EE() {
  var_0 = istrue(self._id_C588);

  if(var_0) {
    self._id_BAD8 = 0;
    thread _id_1073B();
  }

  if(!isDefined(self._id_9923)) {
    var_1 = self.origin + (0, 0, 0);
    var_2 = self.angles + (0, 0, 0);
    var_3 = vectornormalize(anglesToForward(self.angles));
    self.origin = self.origin + var_3 * 16.0;
    self._id_9923 = spawn("script_model", var_1);
    self._id_9923.angles = var_2;
  }

  if(!isDefined(self._id_9923)) {
    return;
  }
  if(isDefined(level._id_AE12)) {
    [[level._id_AE12]](self, self._id_9923);
  } else if(!var_0) {
    self._id_BAD8 = 1;
  }

  if(isDefined(level.set_pap_mdl_override_func)) {
    level thread[[level.set_pap_mdl_override_func]](self);
  } else if(var_0 && !self._id_BAD8) {
    self._id_9923 setModel("s4_zm_machine_weapon_dim");
  } else {
    if(istrue(level.pap_model_animated)) {
      self._id_9923 setModel("s4_zm_fxanim_pap_mod");
      self._id_9923 _meth_82CB("s4_zm_fxanim_pap_idle_anim");
      playFXOnTag(scripts\engine\utility::getfx("pap_idle"), self._id_9923, "tag_origin");
    } else
      self._id_9923 setModel("s4_zm_machine_weapon");

    if(_func_0205("zmb_pap_idle_lp")) {
      self._id_9923 playLoopSound("zmb_pap_idle_lp");
    }
  }

  if(getDvar("#x36d16f02578d0ee10") != "cp_zm_oasis") {
    _id_0720::init_approach_dialogue(self.origin, "hpp", 1, 10000);
  }
}

_id_1073B() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("power_on", self._id_BA97 + " power_on");

  if(isDefined(self._id_9923)) {
    self._id_9923 setModel("s4_zm_machine_weapon");

    if(_func_0205("zmb_pap_activate_oneshot")) {
      self._id_9923 playSound("zmb_pap_activate_oneshot");
    }

    if(_func_0205("zmb_pap_idle_lp")) {
      self._id_9923 playLoopSound("zmb_pap_idle_lp");
    }
  }
}

_id_8115(var_0) {
  foreach(var_2 in level._id_AE0A) {
    var_3 = scripts\cp\utility::_id_6CE3(var_2);

    if(!isDefined(var_0._id_AE0A[var_3])) {
      var_4 = spawnStruct();
      var_4._id_991E = _id_6384(var_0, var_3);
      var_0._id_AE0A[var_3] = var_4;
    }
  }
}

_id_6384(var_0, var_1) {
  if(isDefined(var_0._id_AE0A[var_1])) {
    return var_0._id_AE0A[var_1]._id_991E;
  } else {
    return 1;
  }
}

_id_838C(var_0, var_1) {
  if(scripts\cp\utility::_id_857B()) {
    return;
  }
  var_1 thread _id_10D20(var_0);
}

weapon_upgrade_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_10D21(var_0, var_1) {
  if(!istrue(level._id_AE13)) {
    return "";
  }

  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\cp_weapon::_id_683D(var_2);

  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
  }

  if(!scripts\cp\cp_weapon::_id_3101(var_2)) {
    return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL";
  } else {
    return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_GENERIC";
  }

  return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL";
}

spawn_weapon_upgrade_machine(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return undefined;
  }

  var_3 = scripts\cp\utility::_id_E190("tag_origin", var_0, var_1);
  var_3._id_039B = "weapon_upgrade";
  var_3._id_0481 = "interaction";
  var_3._id_BAD8 = 1;

  if(isDefined(var_2)) {
    var_3.owning_brush = var_2;
    var_2 _meth_80B5();
    var_2 show();
  }

  var_3 thread _id_80EE();
  _id_0737::addinteractionstruct(var_3, 1, "v_ui_icons_zombies_minimap_pap", 92);
  return var_3;
}

remove_weapon_upgrade_machine(var_0) {
  _id_0737::_id_C3C5(var_0);

  if(isDefined(var_0.owning_brush)) {
    var_0.owning_brush _meth_8093();
    var_0.owning_brush hide();
  }

  if(isDefined(var_0.markerlabel) && isDefined(var_0.instanceindex)) {
    _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);
  }

  var_0._id_9923 delete();
  var_0 delete();
}

_id_10D20(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(!istrue(var_0) && !istrue(level._id_AE13)) {
    return;
  }
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::_id_6CE3(var_2);
  var_4 = scripts\cp\cp_weapon::_id_3101(var_2);
  var_5 = var_1 scripts\cp\cp_weapon::_id_683D(var_3);
  var_6 = undefined;
  var_7 = undefined;
  var_8 = "none";
  var_9 = undefined;
  var_10 = 0;
  var_11 = 0;

  if(var_4 && var_5 - 1 < level._id_AE11) {
    var_12 = vectornormalize(anglesToForward(var_1.angles)) * 16;
    var_13 = var_1 getweaponslistprimaries();
    var_1 _id_0741::_id_BD77("mt_upgrade_weapons");

    foreach(var_15 in var_13) {
      if(!issubstr(var_2.basename, var_15.basename) && (!var_15._id_0245 && !issubstr(var_15.basename, "knife"))) {
        var_6 = var_15;
        break;
      }
    }

    if(_func_0107(self.a_wall_buy_weapons) && scripts\cp\utility::_id_88B7(self.a_wall_buy_weapons, var_2)) {
      var_11 = 1;
    }

    var_5 = int(var_5);
    var_17 = 0;

    if(isDefined(level.get_pap_cost_override)) {
      var_17 = [[level.get_pap_cost_override]]();
    } else if(isDefined(level._id_AE14[var_5])) {
      var_17 = level._id_AE14[var_5];
    }

    var_5++;
    var_18 = var_2;
    var_9 = _func_00ED(var_2);
    var_19 = _func_00F3(var_2);

    if(issubstr(var_19, "scope")) {
      var_19 = int(_func_0440(var_19, "scope"));

      if(var_19 == 0) {
        var_19 = undefined;
      }
    } else if(!isDefined(scripts\cp\cp_weapon::_id_6CF2(var_19)))
      var_19 = undefined;

    var_20 = _func_02F7(var_2);
    var_21 = [];
    var_21 = scripts\engine\utility::array_add(var_21, var_2._id_0409);
    var_21 = scripts\engine\utility::array_add(var_21, var_2._id_040A);
    var_21 = scripts\engine\utility::array_add(var_21, var_2._id_040B);
    var_21 = scripts\engine\utility::array_add(var_21, var_2._id_040C);
    self._id_AE15 = var_2;
    var_22 = var_2._id_0070;
    var_23 = var_2._id_0071;
    [var_25, var_26] = strip_pap_attachments(var_22, var_23);
    var_27 = scripts\cp\cp_weapon::buildweapon(var_2.basename, var_25, var_9, var_19, var_20, var_26, undefined, var_21);
    var_28 = var_27;
    var_29 = var_28;

    if(scripts\cp\utility::_id_8774(var_18)) {
      self notify("thrown_weapon_cleanup", var_18);
    }

    level notify("pap_used", self, var_5, var_28);

    if(_func_0205("pack_a_punch_purchase")) {
      self playlocalsound("pack_a_punch_purchase");
    }

    thread _id_6F36(self, var_28, var_7, var_5);
    var_30 = "null";
    var_1 thread _id_0737::_id_ED96(var_17, var_30);

    if(istrue(var_11) && _func_0107(self.a_wall_buy_weapons)) {
      self.a_wall_buy_weapons = scripts\cp\utility::_id_1B8C(self.a_wall_buy_weapons, var_28);
    }

    self notify("weapon_purchased");
    var_1 setclientomnvar("ui_pap_purchase_response", 1);
    self._id_AE15 = undefined;
    level notify("pap_machine_activated");
  }
}

strip_pap_attachments(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  foreach(var_7, var_5 in var_0) {
    if(issubstr(var_5, "zm_pack_")) {
      continue;
    }
    if(issubstr(var_5, "zm_")) {
      continue;
    }
    var_6 = scripts\cp\utility::_id_1DA5(var_5);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
    var_3[var_6] = var_1[var_5];
  }

  return [var_2, var_3];
}

_id_6F36(var_0, var_1, var_2, var_3) {
  var_2 = makeweapon("iw8_knife_mp");

  if(var_0 hasweapon(var_2)) {
    var_0 takeweapon(var_2);
  }

  var_4 = undefined;

  if(isweapon(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = makeweaponfromstring(var_1);
  }

  if(var_0 scripts\cp\cp_weapon::_id_752E(var_4)) {
    var_5 = scripts\cp\utility::_id_6CE3(var_4);

    foreach(var_7 in var_0 getweaponslistprimaries()) {
      var_8 = scripts\cp\utility::_id_6CE3(var_7);

      if(var_5 == var_8) {
        var_0 takeweapon(var_7);
      }
    }
  }

  if(_id_0777::_id_DAE4(var_0)) {
    var_10 = var_0 getcurrentweapon();
    var_11 = scripts\cp\utility::_id_6CE3(var_10);
    var_0 takeweapon(var_10);
  }

  self notify("weapon_taken");
  var_12 = _func_02F7(var_4);
  var_4 = var_0 scripts\cp\utility::_giveweapon(var_4, var_12, undefined, 0);
  var_0 givemaxammo(var_4);
  var_13 = var_0 getweaponslistprimaries();

  foreach(var_7 in var_13) {
    if(issubstr(var_7.basename, var_4.basename)) {
      if(var_7._id_0245) {
        var_5 = getweaponbasename(var_7);

        if(isDefined(level._id_1648) && scripts\engine\utility::array_contains(level._id_1648, var_5)) {
          var_4 = var_4 getaltweapon();
          break;
        }
      }
    }
  }

  var_0 switchtoweapon(var_4);
  var_5 = scripts\cp\utility::_id_6CE3(var_4);
  var_0._id_AE0A[var_5]._id_991E++;
  var_0 _id_074E::_id_6F38(500, 1);
  var_0 notify("weapon_level_changed");
  var_0 setclientomnvar("ui_pap_current_level", var_0._id_AE0A[var_5]._id_991E);
}

update_current_pap_status(var_0) {
  var_1 = var_0 getcurrentweapon();
  var_2 = scripts\cp\utility::_id_6CE3(var_1);
  var_3 = var_0 scripts\cp\cp_weapon::_id_683D(var_2);
  var_0 setclientomnvar("ui_pap_current_level", var_3);
}

_id_AC11(var_0) {
  update_current_pap_status(var_0);
  var_0 setclientomnvar("ui_zm_open_pap_menu", 1);
  var_0._id_AE17 = var_0.origin;
  var_0 thread _id_34FA();
}

_id_10D24(var_0, var_1) {
  if(var_0 == "pap_purchase") {
    var_2 = self getcurrentweapon();
    var_3 = scripts\cp\utility::_id_6CE3(var_2);
    var_4 = scripts\cp\cp_weapon::_id_683D(var_3);

    if(var_4 != var_1) {
      self setclientomnvar("ui_pap_purchase_response", 4);
      return;
    }

    if(!istrue(_id_B3D1(var_1))) {
      self playlocalsound("zmb_ui_purchase_deny");
      _id_0720::_id_BEC0("insufficient_funds", 1);
      self setclientomnvar("ui_pap_purchase_response", 3);
      return;
    }

    if(isDefined(self.current_pap_machine)) {
      self.current_pap_machine thread anim_play_initiate();
    }

    self playlocalsound("zmb_ui_purchase_accept");
    _id_0720::_id_BEC0("weapon_packed", 1);
    _id_10D20();
  }
}

_id_B3D1(var_0) {
  var_1 = 0;

  if(isDefined(level._id_AE14[var_0])) {
    var_1 = level._id_AE14[var_0];
  }

  return _id_074E::_id_B4C5(var_1);
}

_id_65A1(var_0, var_1) {
  if(var_0 < var_1) {
    return "(Need Prerequisite Level)";
  } else if(var_0 > var_1) {
    return "(Acquired)";
  }

  return "";
}

_id_575C() {
  var_0 = _id_39C7();

  if(var_0) {
    self._id_AE17 = undefined;
    self.current_pap_machine = undefined;
  }
}

_id_39C7() {
  self setclientomnvar("ui_zm_open_pap_menu", 0);
  return 1;
}

_id_FDED(var_0, var_1) {
  if(!istrue(level._id_AE13)) {
    return;
  }
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return;
  }
  while(var_1 scripts\cp\utility::_id_1A57()) {
    waitframe();
  }

  if(istrue(level.pap_model_animated)) {
    var_1.current_pap_machine = var_0._id_9923;
  }

  _id_AC11(var_1);
}

#using_animtree("script_model");

anim_play_initiate() {
  level endon("game_end");
  self endon("death");

  if(istrue(self.pap_activated)) {
    return;
  }
  self.pap_activated = 1;
  var_0 = _func_0079(%s4_zm_fxanim_pap_initiate_anim);
  self _meth_82CA();
  stopFXOnTag(scripts\engine\utility::getfx("pap_idle"), self, "tag_origin");
  self _meth_82CB("s4_zm_fxanim_pap_initiate_anim");
  playFXOnTag(scripts\engine\utility::getfx("pap_activate"), self, "tag_origin");
  wait(var_0);
  self _meth_82CA();
  stopFXOnTag(scripts\engine\utility::getfx("pap_activate"), self, "tag_origin");
  self _meth_82CB("s4_zm_fxanim_pap_idle_anim");
  playFXOnTag(scripts\engine\utility::getfx("pap_idle"), self, "tag_origin");
  wait 0.1;
  self.pap_activated = undefined;
}

_id_34FA() {
  thread _id_3532();
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "pap_invalidated");
  force_close_pap_menu();
}

force_close_pap_menu() {
  if(!isDefined(self)) {
    return;
  }
  self setclientomnvar("ui_pap_purchase_response", 2);
  _id_575C();
}

_id_3532() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(!scripts\cp\cp_weapon::_id_3101(var_0)) {
      break;
    }

    if(!isDefined(self._id_AE17)) {
      break;
    }

    if(_id_073B::_id_B4EF(self)) {
      break;
    }

    if(distance(self._id_AE17, self.origin) > 100) {
      break;
    }

    if(istrue(level._id_0C35) || istrue(self._id_2031)) {
      break;
    }

    wait 0.25;
  }

  self notify("pap_invalidated");
}

_id_0F9E(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp\utility::_id_6CE3(var_0);

  if(isDefined(level._id_AE16) && isDefined(level._id_AE16[var_3])) {
    var_5 = level._id_AE16[var_3] + var_4;
    var_6 = scripts\cp\utility::getweaponrootname(var_0);
    var_7 = makeweapon(scripts\cp\utility::_id_2D16(var_6));

    if(!scripts\engine\utility::array_contains(var_1, var_5) && var_7 _meth_8629(var_5)) {
      var_1 = scripts\engine\utility::array_add(var_1, var_5);

      if(var_2.size > 0) {
        var_2[var_5] = 0;
      }
    }
  }

  return [var_1, var_2];
}

_id_6F21(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 > 0) {
    var_4 = scripts\cp\utility::_id_6CE3(var_0);
    var_5 = var_0;
    var_6 = scripts\cp\cp_weapon::_id_663A(var_2 + 1, var_4, var_5);

    if(isDefined(var_6) && var_6 != "none") {
      var_1 = var_6;
    }
  }

  return var_1;
}

_id_684B(var_0) {
  var_1 = scripts\cp\utility::_id_6CE3(var_0);
  var_2 = scripts\cp\cp_weapon::_id_683D(var_1);

  if(isDefined(self._id_AE15)) {
    var_3 = scripts\cp\utility::_id_6CE3(self._id_AE15);

    if(var_3 == var_1) {
      var_2++;
    }
  }

  var_2 = var_2 - 1;
  return var_2;
}

_id_6C04(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isPlayer(var_1) || !isDefined(var_5) || !isDefined(var_4)) {
    return var_2;
  }

  if(!scripts\cp\cp_weapon::ismeleeweapon(var_5) && var_4 == "MOD_MELEE") {
    return var_2;
  }

  var_12 = _id_69C2(var_1, var_5);
  var_2 = int(var_2 * var_12);
  return var_2;
}

_id_69C2(var_0, var_1) {
  if(!isPlayer(var_0) || !isDefined(var_1)) {
    return 1;
  }

  var_2 = var_0 _id_684B(var_1);
  var_3 = int(max(var_2 - 1, 0));
  return _func_01A6(2, var_3);
}