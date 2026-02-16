/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1904.gsc
*************************************************/

init() {
  level._id_109B0 = [];
  level._effect["wallbuy_upgrade_effect"] = loadfx("vfx/s4/zombie/vfx_wallbuy_reveal_xlg.vfx");

  if(!isDefined(level.wall_buy_pap_levels) && isDefined(level.wall_buy_pap_table)) {
    init_wall_buy_pap_levels(level.wall_buy_pap_table);
  }

  if(isDefined(level.wall_buy_pap_levels)) {
    level thread monitor_wall_buy_pap_upgration();
  }

  level.allow_wall_buy_same_weapon = 1;
  scripts\engine\utility::_id_5C11("wall_buy_setup_done");
}

_id_D80A(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 6;
  var_0._id_10CEA = [];
  var_0._id_C8C4 = [];
  var_0._id_10D0F = [];

  if(1) {
    var_0._id_10DA7 = 1;
    var_0 notify("player_weapon_build_kit_initialized");
    return;
  }
}

_id_1D12() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("interactions_initialized");

  if(scripts\cp\utility::_id_9A9E(2)) {
    var_0 = "cp/cp_disco_wall_buy_models.csv";
  } else if(scripts\cp\utility::_id_9A9E(3)) {
    var_0 = "cp/cp_town_wall_buy_models.csv";
  } else {
    var_0 = "cp/cp_wall_buy_models.csv";
  }

  if(!scripts\engine\utility::_id_5C0C("wall_buy_setup_done")) {
    scripts\engine\utility::_id_5C11("wall_buy_setup_done");
  }

  if(!scripts\engine\utility::_id_5C0C("wall_buy_chalk_model_setup_done")) {
    scripts\engine\utility::_id_5C11("wall_buy_chalk_model_setup_done");
  }

  var_1 = [];
  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, 1);

    if(var_3 == "") {
      break;
    }

    var_1[var_1.size] = var_3;
    var_2++;
  }

  var_4 = [];
  var_5 = scripts\engine\utility::getStructArray("interaction", "targetname");

  foreach(var_7 in var_5) {
    if(isDefined(var_7._id_FFC5) && var_7._id_FFC5 == "wall_buy") {
      var_4[var_4.size] = var_7;

      if(isDefined(var_7.target)) {
        if(istrue(var_7._id_1642)) {
          continue;
        }
        var_8 = scripts\engine\utility::getStructArray(var_7.target, "target");

        foreach(var_10 in var_8) {
          if(var_10 == var_7) {
            continue;
          }
          var_10._id_1642 = 1;
          var_10._id_AE57 = var_7;
        }
      }
    }
  }

  scripts\engine\utility::_id_5C24("wall_buy_chalk_model_setup_done");
  var_13 = 1;

  if(isDefined(level._id_11049)) {
    var_13 = level._id_11049;
  }

  var_14 = _id_66EF(var_13);

  foreach(var_29, var_16 in var_4) {
    if(!isDefined(var_16._id_039B)) {
      var_17 = "";
    } else {
      var_16._id_039B = strtok(var_16._id_039B, "+")[0];
      var_17 = var_16._id_039B;
    }

    if(!isDefined(var_17) || var_17 == "" || var_17 == "random") {
      var_18 = scripts\engine\utility::random(level._id_1099F);
      var_17 = var_18._id_04F6;
      var_16._id_039B = var_17;
    }

    var_19 = scripts\cp\utility::_id_6CE3(var_17);
    var_20 = undefined;

    if(!isDefined(level._id_1099F[var_19])) {
      var_16._id_4A88 = 1;
      continue;
    }

    var_21 = level._id_1099F[var_19];

    if(!istrue(var_16._id_1642)) {
      if(isDefined(var_16.target)) {
        var_22 = scripts\engine\utility::getstruct(var_16.target, "targetname");
        var_23 = var_22.origin;
        var_24 = var_22.angles;
      } else {
        var_23 = var_16.origin;
        var_24 = var_16.angles;
      }

      if(!isDefined(var_16._id_C040) || var_16._id_C040 == "") {
        var_16._id_C040 = _id_66F0(var_14);
      }

      if(!isDefined(var_16._id_3D91) && isDefined(var_16.script_cost)) {
        var_16._id_3D91 = int(var_16.script_cost);
      }

      if(!isDefined(var_16._id_3D91) && isDefined(var_21._id_3D91)) {
        var_25 = int(_id_66EE(var_16._id_C040));
        var_16._id_3D91 = int(var_21._id_3D91) + var_25;
      }

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(var_1[var_2] == var_19) {
          var_20 = var_2;
          break;
        }
      }

      var_16.pap_level = 0;
      var_26 = (0, 0, 0);
      var_27 = (0, 0, 0);

      if(issubstr(var_16._id_039B, "forgefreeze")) {
        var_26 = (3.25, -18, 9.75);
        var_27 = (0, 0, -90);
      }

      if(isDefined(var_24)) {
        var_24 = var_24 + var_27;
      } else {
        var_24 = var_27;
      }

      var_16.trigger = spawn("script_model", var_23 + var_26);
      var_16.trigger.owner = var_16;
      var_28 = _id_63BE(var_16);

      if(isDefined(var_28)) {
        var_16.trigger setModel(var_28);
      } else {
        var_16.trigger setModel("tag_origin");
      }

      if(isDefined(var_24)) {
        var_16.trigger.angles = var_24;
      }

      var_16.trigger._id_3D91 = var_16._id_3D91;
      var_16.trigger._id_EA6A = var_16;
      var_16.trigger._id_BFF6 = scripts\cp\utility::_id_2D08(var_17, 3, undefined);
      level._id_109B0[level._id_109B0.size] = var_16.trigger;
    } else if(isDefined(var_16._id_AE57.trigger))
      var_16.trigger = var_16._id_AE57.trigger;
    else {
      var_16 thread _id_19E2(var_16);
    }

    var_16._id_04F6 = var_17;
  }

  scripts\engine\utility::_id_5C1B("wall_buy_setup_done");
  level thread upgrade_fixed_wall_buy();
}

_id_19E2(var_0) {
  level endon("game_ended");

  while(!isDefined(var_0._id_AE57.trigger)) {
    waitframe();
  }

  var_0.trigger = var_0._id_AE57.trigger;
}

_id_8B2A(var_0) {
  var_0 _id_6F74(self);
}

_id_6F74(var_0) {
  var_1 = makeweaponfromstring(var_0._id_039B);
  var_2 = 0;
  var_3 = 0;
  var_4 = [];

  if(isDefined(var_0.trigger)) {
    if(isDefined(var_0.trigger._id_3D91)) {
      var_3 = var_0.trigger._id_3D91;
    }

    if(isDefined(var_0.trigger._id_BFF6)) {
      var_4 = var_0.trigger._id_BFF6;
    }
  }

  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = self getweaponslistprimaries();
  var_9 = var_8.size;
  var_10 = 3;
  var_11 = scripts\cp\utility::_id_6CE3(var_1);

  if(var_1.basename == "iw7_forgefreeze_zm") {
    level._id_994A["forgefreeze"] = "iw7_forgefreeze_zm+forgefreezealtfire";
    var_2 = 1;
  }

  if(scripts\cp\utility::_id_10D02(var_1)) {
    var_2 = 1;
  }

  [var_13, var_14, var_15] = _id_073D::_id_6531(0, var_0.origin, self.angles + (0, 180, 0));
  var_16 = spawnStruct();
  var_16.player = self;
  var_16.triggeringweapon = var_1;
  var_16.origin = var_13;
  var_16.shouldoffset = 1;

  if(isDefined(self._id_10CEA[var_11])) {
    var_5 = self._id_10CEA[var_11];
  } else {
    var_5 = var_0._id_04F6;
  }

  if(!isDefined(var_5)) {
    var_5 = var_1;
  }

  var_17 = isDefined(_id_0728::_id_6A17(var_5));

  if(!var_17 && _id_0932::drop_relevant_weapon(var_16)) {
    thread _id_0737::_id_B30D(var_0, self);
  }

  var_18 = undefined;

  if(scripts\cp\utility::_id_88F6(var_5)) {
    var_18 = makeweapon(var_5);
    var_18 = scripts\cp\utility::_giveweapon(var_18, undefined, undefined, 1);
    self._id_8B35 = var_18;
    scripts\cp\utility::_id_ED89(self);
  } else if(var_17) {
    var_19 = spawnStruct();
    var_19._id_5556 = var_5;
    var_19._id_C558 = var_13;
    _id_0728::giveequipment(var_19);
    var_17 = 1;
  } else if(scripts\cp\utility::_id_8580("wall_power") && !scripts\cp\utility::_id_8941()) {
    var_20 = scripts\cp\utility::_id_6CE3(var_5);
    var_21 = spawnStruct();
    var_21._id_991E = 2;
    self._id_AE0A[var_20] = var_21;
    var_18 = scripts\cp\cp_weapon::buildweapon(var_5, var_4);
    var_18 = scripts\cp\utility::_giveweapon(var_18, undefined, undefined, 1);
    _id_0741::_id_BD77("mt_upgrade_weapons");
    scripts\cp\utility::_id_A689("wall_power");
    scripts\cp\utility::_id_ED89(self);
  } else {
    var_22 = var_0.pap_level;
    var_23 = scripts\cp\cp_weapon::_id_663A(var_22 + 1, var_5, "");
    var_18 = scripts\cp\cp_weapon::buildweapon(var_5, var_4, var_23, undefined, undefined, undefined, undefined, undefined, undefined, var_22);
    var_18 = scripts\cp\utility::_giveweapon(var_18, undefined, undefined, 1);
    self.a_wall_buy_weapons = scripts\cp\utility::_id_459B(self.a_wall_buy_weapons, []);
    self.a_wall_buy_weapons = scripts\engine\utility::array_add(self.a_wall_buy_weapons, var_18);
    self._id_8B35 = var_18;
    level._id_F464 = randomint(100);
    scripts\cp\utility::_id_ED89(self);
    var_21 = spawnStruct();
    var_21._id_991E = var_22 + 1;
    self._id_AE0A[var_11] = var_21;
  }

  if(var_2) {
    var_0.trigger delete();
    _id_0737::_id_C3C5(var_0);
  }

  if(var_17) {
    var_0 notify("wall_buy_item_pickup", var_5);
  } else {
    self notify("wor_item_pickup", var_18);
    var_0 notify("wall_buy_item_pickup", var_18);
  }

  _id_0741::_id_BD77("mt_purchased_weapon");

  if(!var_17) {
    self givemaxammo(var_18);
    self notify("weapon_level_changed");
    self switchtoweapon(var_18);
    wait 0.25;

    while(self isswitchingweapon()) {
      wait 0.05;
    }
  }

  thread _id_076F::_id_F72D("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
  self notify("weapon_purchased");
  wait 0.05;
  self._id_BE31 = undefined;
  _id_0737::_id_C1A2();

  if(var_17) {
    _id_0720::_id_BEC0("pickup_item");
  } else {
    _id_0720::queue_weapon_pickup_dialogue(var_5);
  }
}

_id_C5E9(var_0) {
  if(isDefined(self._id_E3BB)) {
    self._id_E3BB = undefined;
  }

  if(isDefined(self._id_E3BE)) {
    self._id_E3BE = undefined;
  }

  if(isDefined(self._id_E3BD)) {
    self._id_E3BD = undefined;
  }

  if(isDefined(self._id_E3BC)) {
    self._id_E3BC = undefined;
  }

  if(isDefined(self._id_E3BA)) {
    self._id_E3BA = undefined;
  }
}

_id_6F24() {
  if(_id_0946::_id_BBF6() == 1) {
    var_0 = self getweaponslistprimaries();

    foreach(var_2 in var_0) {
      var_3 = var_2.classname;

      if(var_3 == "weapon_pistol") {
        var_4 = weaponmaxammo(var_2);
        var_5 = int(var_4 * 0.25);
        var_6 = self _meth_8109(var_2);

        if(var_5 > var_6) {
          self setweaponammostock(var_2, var_5);
        }
      }
    }
  }
}

_id_6854(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = _id_074E::_id_6383(var_3);

    if(issubstr(var_0, var_4)) {
      return var_3;
    }
  }

  return undefined;
}

_id_66FB() {
  var_0 = self getweaponslistprimaries();
  var_1 = 3;

  foreach(var_3 in var_0) {
    if(var_3._id_0245) {
      var_1++;
    }
  }

  if(scripts\cp\utility::_id_7531("perk_machine_more")) {
    var_1++;
  }

  if(var_0.size >= var_1) {
    var_5 = self getcurrentweapon();
    var_6 = 0;

    if(isnullweapon(var_5)) {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level._id_10D0, var_5)) {
      var_6 = 1;
    } else if(scripts\engine\utility::array_contains(level._id_10D0, var_5 _meth_8625())) {
      var_6 = 1;
    } else if(scripts\cp\utility::_id_8632(var_5, 1)) {
      var_6 = 1;
    }

    if(var_6) {
      self._id_3D58 = self getweaponslistall();
      var_5 = _id_073B::_id_3591(level._id_10D0, 1, 1);
    }

    self._id_3D58 = undefined;

    if(_func_0276(var_5) == "altmode") {
      var_5 = var_5 getaltweapon();
    }

    return var_5;
  }

  return undefined;
}

_id_6849(var_0) {
  if(_func_0276(var_0) != "altmode") {
    return var_0;
  }

  return _func_00D6(var_0, 4);
}

_id_30CD(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = self getcurrentweapon();
  var_3 = var_2.classname;
  var_4 = scripts\cp\utility::_id_6902(var_2);

  foreach(var_6 in var_1) {
    if(var_6._id_0245) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_6);
    }
  }

  var_8 = 0;
  var_9 = 0;

  if(isDefined(self._id_75A6)) {
    var_9 = self._id_75A6;
  }

  if(!scripts\cp\utility::_id_7531("perk_machine_more")) {
    var_10 = 3;
  } else {
    var_10 = 4;
  }

  if(isDefined(self._id_A769)) {
    var_10 = var_10 + self._id_A769;
  }

  while(self isswitchingweapon()) {
    wait 0.05;

    if(!isDefined(self)) {
      return 0;
    }
  }

  if(isnullweapon(var_2)) {
    return 0;
  }

  if(!istrue(level.allow_wall_buy_same_weapon) && scripts\cp\cp_weapon::_id_752E(var_0._id_04F6)) {
    return 0;
  }

  if(isDefined(level._id_4229)) {
    if(![[level._id_4229]](var_1, var_2, var_3, var_10)) {
      return 0;
    }
  }

  if(isDefined(scripts\cp\utility::_id_7521()) && scripts\cp\utility::_id_7521()) {
    return 0;
  }

  if(var_1.size >= var_10 + 1 && istrue(self._id_75A5)) {
    return 0;
  }

  if(var_1.size >= var_10 + 2 && istrue(self._id_75A5)) {
    return 0;
  }

  if(var_1.size >= var_10 + 1 && !var_9) {
    return 0;
  }

  if(var_1.size >= var_10 + 2 && var_9) {
    return 0;
  }

  if(var_9 && var_1.size >= var_10 + 1) {
    return 0;
  }

  if(var_9 && var_1.size >= var_10 + 1) {
    return 0;
  }

  if(!scripts\cp\utility::_id_85F4()) {
    return 1;
  } else {
    return 0;
  }

  return 0;
}

_id_8380(var_0, var_1) {
  if(scripts\cp\utility::_id_8722()) {
    return;
  }
  if(!istrue(var_0._id_8B2A)) {
    var_0 thread watch_wall_buy_item_pickup(var_1);
  }

  playsoundatpos(var_0.origin, "zmb_ui_purchase_accept");
  playsoundatpos(var_0.origin, "zmb_ui_weapon_buy");
  var_0 _id_8B2A(var_1);
  var_0 notify("item_pickup_ended");
  var_1._id_8F31 = undefined;
}

watch_wall_buy_item_pickup(var_0) {
  level endon("game_ended");
  self endon("item_pickup_ended");
  var_0 endon("disconnect");
  self waittill("wall_buy_item_pickup", var_1);

  if(!isDefined(self.trigger)) {
    return;
  }
  if(isDefined(var_1) && (isweapon(var_1) || _func_0121(var_1))) {
    self._id_8B2A = 1;
    var_2 = level._id_3E13.weapon_wall_buy_scriptable_name;
    var_3 = vectortoangles(var_0.origin - self.trigger.origin);
    var_4 = var_3[1];
    var_5 = self.angles[1];

    if(isDefined(self.script_int)) {
      var_5 = var_5 - self.script_int;
    }

    var_6 = _func_000B(var_4 - var_5);
    var_7 = var_5;

    if(var_6 < 0) {
      var_7 = _func_000B(var_7 + 180);
    }

    var_8 = self.trigger.origin;
    var_9 = (0, var_7, 0);
    var_10 = (0, var_7 + 270, 0);
    var_11 = anglesToForward(var_10) * 3;
    var_8 = var_8 + var_11;
    _id_092E::_id_3907();

    if(isweapon(var_1)) {
      var_12 = var_1.basename;
    } else {
      var_12 = var_1;
    }

    var_13 = undefined;
    var_14 = 0;

    if(scripts\cp\utility::_id_88F6(var_1)) {
      var_15 = spawnStruct();
      var_15._id_5BD9 = 1;
      var_16 = scripts\cp\cp_killstreaks::get_killstreak_name_from_weapon(var_1);
      var_13 = _id_092E::spawn_killstreak(var_16, var_8, var_9, 0, 0, 1, var_15, var_2);
    } else if(isDefined(_id_0728::_id_6A17(var_12))) {
      var_2 = _id_0930::_id_5B05(var_1);

      if(isDefined(var_2)) {
        var_13 = _id_0930::_id_E35C(var_2, var_8, var_9, 1, 0, 0, 0, 1);
      }
    } else {
      var_13 = _id_092E::_id_E24D(var_1, var_8, var_9, 0, 0, 0, 1, var_2);
      var_14 = 1;
    }

    if(!isDefined(var_13)) {
      return;
    }
    if(!isDefined(var_13._id_3E25)) {
      _id_092E::_id_C216(var_13);
    }

    var_13 setscriptablepartstate(var_13.type, "wall_buy_preload");
    var_13 thread wall_buy_item_visible_after_time(0.5, var_0);

    if(var_14) {
      var_17 = spawnStruct();
      var_17.wall_buy_item = var_13;
      var_17.weapon_name = var_12;
      var_17._id_0070 = var_1._id_0070;
      var_17.spawn_origin = var_8;
      var_17.spawn_angles = var_9;
      var_17._id_CF0C = var_2;
      self.wall_buy_params = var_17;
    }
  }
}

wall_buy_item_visible_after_time(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!_func_0458(self)) {
    if(scripts\engine\utility::is_equal(level.mapname, "cp_zm_oasis") && self _meth_867A(self.type, "wall_buy_visible_oasis")) {
      self setscriptablepartstate(self.type, "wall_buy_visible_oasis");
    } else {
      self setscriptablepartstate(self.type, "wall_buy_visible");
    }

    if(isDefined(var_1)) {
      var_1 _meth_8282(var_1.origin);
    }
  }
}

can_afford_wall_buy(var_0, var_1) {
  if(isDefined(var_0._id_3D91)) {
    var_2 = var_0._id_3D91;
  } else {
    var_3 = var_0._id_039B;
    var_2 = level._id_8387[var_3]._id_3D91;
  }

  return var_1 _id_074E::_id_B4C5(var_2);
}

_id_310E(var_0, var_1) {
  if(scripts\cp\utility::_id_8722()) {
    return 0;
  }

  if(!_id_B514(var_1, var_0.origin)) {
    return 0;
  }

  if(!istrue(level.allow_wall_buy_same_weapon) && var_1 scripts\cp\cp_weapon::_id_752E(var_0._id_04F6)) {
    return 0;
  }

  if(isDefined(_id_0728::_id_6A17(var_0._id_039B))) {
    if(_id_0728::hasmaxammo(var_0._id_039B)) {
      return 0;
    }
  }

  if(!var_1 _id_30CD(var_0)) {
    return 0;
  }

  if(isDefined(_id_0728::_id_6A17(var_0._id_039B))) {
    var_2 = var_0._id_039B;
  } else {
    var_2 = getweaponbasename(var_0._id_039B);
  }

  return isDefined(level._id_8393[var_2]);
}

_id_682C(var_0, var_1) {
  if(scripts\cp\utility::_id_8722()) {
    return &"CP_ZMB_INTERACTIONS/WALL_BUY_DISABLED";
  }

  if(!_id_B514(var_1, var_0.origin)) {
    return "";
  }

  if(!istrue(level.allow_wall_buy_same_weapon) && var_1 scripts\cp\cp_weapon::_id_752E(var_0._id_04F6)) {
    return &"CP_ZMB_INTERACTIONS/ALREADY_EQUIPPED";
  }

  var_2 = _id_0728::_id_6A17(var_0._id_039B);

  if(isDefined(var_2)) {
    if(_id_0728::hasmaxammo(var_0._id_039B)) {
      if(var_2._id_45C7 == "primary") {
        return &"CP_ZMB_INTERACTIONS_TUGOLF/LETHAL_EQUIPMENT_FULL";
      } else {
        return &"CP_ZMB_INTERACTIONS_TUGOLF/TACTICAL_EQUIPMENT_FULL";
      }
    }
  }

  if(!var_1 _id_30CD(var_0)) {
    return &"COOP_INTERACTIONS/CANNOT_BUY";
  }

  if(isDefined(_id_0728::_id_6A17(var_0._id_039B))) {
    var_3 = var_0._id_039B;
  } else {
    var_3 = getweaponbasename(var_0._id_039B);
  }

  var_4 = scripts\engine\utility::ter_op(var_1 can_afford_wall_buy(var_0, var_1), level._id_835D[var_3], level._id_835D[var_3 + "_need_money"]);
  _id_D24A(var_0, var_1, var_4);
  return var_4;
}

get_wall_buy_hint_type(var_0, var_1) {
  if(scripts\cp\utility::_id_8722()) {
    return "HINT_NOBUTTON";
  }

  if(!istrue(level.allow_wall_buy_same_weapon) && var_1 scripts\cp\cp_weapon::_id_752E(var_0._id_04F6)) {
    return "HINT_NOBUTTON";
  }

  if(isDefined(_id_0728::_id_6A17(var_0._id_039B))) {
    if(_id_0728::hasmaxammo(var_0._id_039B)) {
      return "HINT_NOBUTTON";
    }
  }

  if(!var_1 _id_30CD(var_0)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_B514(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = var_0 getplayerangles();
    var_3 = anglesToForward(var_2);
    var_4 = var_0 getEye();
    var_5 = vectornormalize(var_1 - var_4);
    var_6 = vectordot(var_3, var_5);

    if(var_6 > 0) {
      return 1;
    }
  }

  return 0;
}

_id_D24A(var_0, var_1, var_2) {
  if(isDefined(var_2) && !_func_0121(var_2)) {
    var_3 = var_0._id_039B;
    var_4 = scripts\engine\utility::ter_op(var_0.pap_level > 0, 1, 0);

    if(isDefined(level.wall_buy_weapons) && isDefined(level.wall_buy_weapons[var_3]) && isDefined(level.wall_buy_weapons[var_3].loc_names) && isDefined(level.wall_buy_weapons[var_3].loc_names[var_4])) {
      var_5 = level.wall_buy_weapons[var_3].loc_names[var_4];
    } else {
      var_5 = _id_0737::_id_6E7B(var_0._id_039B);
    }

    if(isDefined(var_0._id_3D91)) {
      self._id_8388 _meth_8557(var_5, int(var_0._id_3D91));
    } else {
      self._id_8388 _meth_8557(var_5, int(level._id_8393[var_0._id_039B]._id_3D91));
    }
  }
}

_id_682D(var_0, var_1, var_2) {
  if(isDefined(var_0._id_3D91)) {
    return var_0._id_3D91;
  }

  return var_2;
}

_id_D44B(var_0) {
  level._id_10D13 = var_0;
}

_id_C1EF() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("wall_buy_setup_done");
  var_0 = 0;

  if(isDefined(level._id_3E20)) {
    var_1 = level._id_3E20;
  } else {
    var_1 = "cp/cp_weapontable.csv";
  }

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 2);

    if(issubstr(var_3, "wall")) {
      var_4 = tablelookupbyrow(var_1, var_0, 1);
      var_5 = int(tablelookupbyrow(var_1, var_0, 3));
      level._id_835D[var_4] = &"CP_ZMB_INTERACTIONS_TUGOLF/WALL_BUY_WEAPON";
      level._id_835D[var_4 + "_need_money"] = &"CP_ZMB_INTERACTIONS_TUGOLF/WALL_BUY_WEAPON_NEED_MONEY";
      _id_0737::_id_C266(var_4, ::_id_682C, ::_id_8380);
      level._id_8393[var_4]._id_3D91 = var_5;
      level._id_8393[var_4]._id_3108 = ::_id_310E;
      level._id_8393[var_4]._id_3D92 = ::_id_682D;
      level._id_8393[var_4].hint_type_func = ::get_wall_buy_hint_type;
      var_6 = scripts\engine\utility::getStructArray(var_4, "script_noteworthy");

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        _id_0737::add_interaction_marker_internal(var_6[var_7], "wallbuy", "v_ui_icons_zombies_minimap_wallbuys", 0);
      }
    }

    var_0++;
  }
}

_id_6454(var_0, var_1) {
  var_2 = var_0 * var_1;
  var_2 = clamp(var_2, 0, 100);
  var_3 = 100 - var_2;
  return var_3;
}

_id_6453(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_33BC = _id_6454(var_0, var_1);
  var_3._id_C040 = var_2;
  return var_3;
}

_id_66EF(var_0) {
  var_1 = [];
  var_1[var_1.size] = _id_6453(2, var_0, "orange");
  var_1[var_1.size] = _id_6453(4, var_0, "purple");
  var_1[var_1.size] = _id_6453(16, var_0, "blue");
  var_1[var_1.size] = _id_6453(32, var_0, "green");
  return var_1;
}

_id_66F0(var_0) {
  if(getdvarint("#x3e79d7edf74d3cee0") < 1) {
    return "white";
  }

  var_1 = randomint(100);

  foreach(var_3 in var_0) {
    if(var_1 > var_3._id_33BC) {
      return var_3._id_C040;
    }
  }

  return "green";
}

_id_63BE(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return "s4_zm_chalk_buy_ar_accurate_t9";
  }

  if(!isDefined(var_1)) {
    var_1 = var_0._id_C040;
  }

  var_3 = _id_66ED(var_1);

  if(!isDefined(var_2)) {
    var_2 = var_0._id_039B;
  }

  var_4 = scripts\cp\utility::_id_459B(var_0.pap_level, 0);
  var_5 = scripts\cp\utility::_id_6CE3(var_2);

  if(isDefined(level._id_1099F[var_5])) {
    if(isDefined(level.wall_buy_weapons) && isDefined(level.wall_buy_weapons[var_2]) && isDefined(level.wall_buy_weapons[var_2].chalk_models) && isDefined(level.wall_buy_weapons[var_2].chalk_models[var_4])) {
      var_6 = level.wall_buy_weapons[var_2].chalk_models[var_4];
    } else {
      var_6 = "s4_zm_chalk_buy_" + var_2 + var_3;
    }

    if(isDefined(var_6)) {
      return var_6;
    }
  }

  return "s4_zm_chalk_buy_ar_accurate_t9";
}

_id_66ED(var_0) {
  switch (var_0) {
    case "orange":
      return "_legendary";
    case "purple":
      return "_epic";
    case "blue":
      return "_rare";
    case "green":
      return "_uncommon";
    default:
      break;
  }

  return "";
}

_id_66EE(var_0) {
  switch (var_0) {
    case "orange":
      return 3500;
    case "purple":
      return 2500;
    case "blue":
      return 1500;
    case "green":
      return 500;
    default:
      break;
  }

  return 0;
}

init_wall_buy_pap_levels(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 4;
  level.wall_buy_pap_levels = [];
  var_6 = 0;

  for(;;) {
    var_7 = tablelookupbyrow(var_0, var_6, var_1);

    if(var_7 == "") {
      break;
    }

    var_8 = tablelookupbyrow(var_0, var_6, var_2);
    var_9 = tablelookupbyrow(var_0, var_6, var_3);
    var_10 = tablelookupbyrow(var_0, var_6, var_4);
    var_11 = tablelookupbyrow(var_0, var_6, var_5);
    var_12 = spawnStruct();
    var_12.min_round = int(var_7);
    var_12.max_round = int(var_8);
    var_12.pap_chance_array = [float(var_9), float(var_10), float(var_11)];
    level.wall_buy_pap_levels[level.wall_buy_pap_levels.size] = var_12;
    var_6++;
  }
}

get_pap_level_chance(var_0) {
  for(var_1 = var_0.size - 1; var_1 >= 0; var_1--) {
    if(var_0[var_1] > 0) {
      if(randomfloat(1) <= var_0[var_1]) {
        return var_1 + 1;
      }
    }
  }

  return 0;
}

monitor_wall_buy_pap_upgration() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");
    var_0 = scripts\cp\zombies\zm_round_logic::get_round();

    foreach(var_2 in level.wall_buy_pap_levels) {
      if(var_0 >= var_2.min_round && (var_2.max_round == -1 || var_0 <= var_2.max_round)) {
        upgrade_wall_buys(var_2.pap_chance_array);
        break;
      }
    }
  }
}

upgrade_wall_buys(var_0) {
  if(!isDefined(level._id_109B0)) {
    return;
  }
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3 > 0) {
      var_1 = 1;
      break;
    }
  }

  if(!var_1) {
    return;
  }
  var_5 = [4000, 13000, 25000];

  foreach(var_7 in level._id_109B0) {
    var_8 = var_7._id_EA6A;
    var_9 = isDefined(_id_0728::_id_6A17(var_8._id_04F6));

    if(var_9) {
      continue;
    }
    if(isDefined(var_8._id_CE18) && int(var_8._id_CE18) > 0) {
      continue;
    }
    var_10 = get_pap_level_chance(var_0);

    if(var_8.pap_level < var_10) {
      var_8.pap_level = var_10;
      var_8._id_3D91 = var_5[var_10 - 1];
      var_7._id_3D91 = var_8._id_3D91;
      var_8 thread play_wallbuy_upgrade_vfx();
      var_11 = _id_63BE(var_8);

      if(isDefined(var_11)) {
        var_7 setModel(var_11);
      }

      if(isDefined(var_8.wall_buy_params) && isDefined(var_8.wall_buy_params.wall_buy_item)) {
        var_8 upgrade_wall_buy_item(var_8.wall_buy_params, var_10);
      }
    }
  }
}

upgrade_fixed_wall_buy() {
  var_0 = [4000, 13000, 25000];

  foreach(var_2 in level._id_109B0) {
    var_3 = var_2._id_EA6A;
    var_4 = isDefined(_id_0728::_id_6A17(var_3._id_04F6));

    if(var_4) {
      continue;
    }
    if(isDefined(var_3._id_CE18) && int(var_3._id_CE18) > 0) {
      var_3.pap_level = int(var_3._id_CE18);
      var_3._id_3D91 = var_0[int(var_3._id_CE18) - 1];
      var_2._id_3D91 = var_3._id_3D91;
      var_3 thread play_wallbuy_upgrade_vfx();
      var_5 = _id_63BE(var_3);

      if(isDefined(var_5)) {
        var_2 setModel(var_5);
      }
    }
  }
}

play_wallbuy_upgrade_vfx() {
  if(isDefined(self.trigger) && isDefined(self.trigger.origin)) {
    if(!isDefined(self.upgrade_vfx_loc)) {
      var_0 = spawn("script_model", self.trigger.origin);
      var_0 setModel("tag_origin");
      var_0.angles = self.angles;
      self.upgrade_vfx_loc = var_0;
      waitframe();
    }

    playFXOnTag(scripts\engine\utility::getfx("wallbuy_upgrade_effect"), self.upgrade_vfx_loc, "tag_origin");
  }
}

init_wall_buy_weapon_table(var_0) {
  if(!scripts\engine\utility::_id_5C0C("wall_buy_chalk_model_setup_done")) {
    scripts\engine\utility::_id_5C11("wall_buy_chalk_model_setup_done");
  }

  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 4;
  var_6 = 5;
  var_7 = 6;
  level.wall_buy_weapons = [];
  var_8 = 0;

  for(;;) {
    var_9 = tablelookupbyrow(var_0, var_8, var_1);

    if(var_9 == "") {
      break;
    }

    var_10 = spawnStruct();
    var_10.chalk_models = [];
    var_10.loc_names = [];
    var_10.chalk_models[0] = tablelookupbyrow(var_0, var_8, var_2);
    var_10.loc_names[0] = _func_0227(var_0, var_8, var_3);
    var_11 = isDefined(_id_0728::_id_6A17(var_9));

    if(!var_11) {
      var_10.chalk_models[1] = tablelookupbyrow(var_0, var_8, var_4);
      var_10.chalk_models[2] = tablelookupbyrow(var_0, var_8, var_5);
      var_10.chalk_models[3] = tablelookupbyrow(var_0, var_8, var_6);
      var_10.loc_names[1] = _func_0227(var_0, var_8, var_7);
    }

    level.wall_buy_weapons[var_9] = var_10;
    var_8++;
  }

  scripts\engine\utility::_id_5C1B("wall_buy_chalk_model_setup_done");
}

upgrade_wall_buy_item(var_0, var_1) {
  if(isDefined(var_0.wall_buy_item)) {
    _id_092E::_id_4744(var_0.wall_buy_item);
    var_0.wall_buy_item = undefined;
  }

  _id_092E::_id_3907();
  var_2 = scripts\cp\cp_weapon::_id_663A(var_1 + 1, var_0.weapon_name, "");
  var_3 = scripts\cp\cp_weapon::buildweapon(var_0.weapon_name, var_0._id_0070, var_2, undefined, undefined, undefined, undefined, undefined, undefined, var_1);
  var_4 = _id_092E::_id_E24D(var_3, var_0.spawn_origin, var_0.spawn_angles, 0, 0, 0, 1, var_0._id_CF0C);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_4._id_3E25)) {
    _id_092E::_id_C216(var_4);
  }

  var_4 setscriptablepartstate(var_4.type, "wall_buy_preload");
  var_4 thread wall_buy_item_visible_after_time(0.5);
  var_0.wall_buy_item = var_4;
}