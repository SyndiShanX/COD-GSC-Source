/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2319.gsc
*************************************************/

main() {
  if(isDefined(level._id_3FD9) && level._id_3FD9) {
    return;
  }
  level thread _id_A0D8();

  if(!istrue(level._id_62A5) && level.script != "cp_ai_combat_zm") {
    level._id_11EF["generic_zombie"]["on_damaged"] = ::_id_ABDE;
    level._id_11EF["generic_zombie"]["gametype_on_damage_finished"] = ::_id_ABDF;
    level._id_11EF["generic_zombie"]["gametype_on_killed"] = ::_id_ABE0;
    level._id_62A5 = 1;
  }

  level._id_11EF["zombie_brute"]["on_damaged"] = ::_id_ABDE;
  level._id_11EF["zombie_brute"]["gametype_on_damage_finished"] = ::_id_ABDF;
  level._id_11EF["zombie_brute"]["gametype_on_killed"] = ::_id_ABE0;
  level._id_2F4E = ::_id_2F43;
  level._id_11EF["c6"]["on_damaged"] = ::_id_ABDE;
  level._id_11EF["c6"]["gametype_on_damage_finished"] = ::_id_ABDF;
  level._id_11EF["c6"]["gametype_on_killed"] = ::_id_ABE0;
  level._id_11EF["the_hoff"]["on_damaged"] = ::_id_AB01;
  level._id_11EF["the_hoff"]["gametype_on_damage_finished"] = ::_id_ABDF;
  level._id_11EF["the_hoff"]["gametype_on_killed"] = ::_id_ABE0;
  level._id_11EF["soldier_agent"]["on_damaged"] = ::_id_ABDE;
  level._id_11EF["soldier_agent"]["gametype_on_damage_finished"] = ::_id_ABDF;
  level._id_11EF["soldier_agent"]["gametype_on_killed"] = ::_id_ABE0;
  level._id_60F1 = ::_id_62A6;
  level._id_7D75 = _id_09A4::_id_8600;
  level._id_5DD3 = ::_id_110AA;
  level._id_5D8B = ::_id_1106D;
  level._id_A23E["generic_zombie"] = ::_id_C9DA;

  if(!isDefined(level._id_5142)) {
    level._id_5142 = ::_id_229F;
  }

  if(!isDefined(level._id_DA88)) {
    level._id_DA88 = ::_id_22A8;
  }

  level._id_8F1C = gettime();
  level._id_5FE8 = _id_075B::_id_5F60;
  level._id_F0EC = _id_075B::_id_F943;
  level thread _id_8128();
  level._id_5D4C = ::_id_63EF;
  level._id_5D4B = scripts\cp\utility::_id_63D8;
  level._id_A523 = getent("no_pain_volume", "targetname");
  level._id_5D9E = scripts\cp\utility::_id_8632;
  level._id_A393 = 0;
  level._id_11049 = getdvarint("#x3b044c32650d4f148", 1);
}

_id_229F(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 1;
}

_id_22A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  return 1;
}

_id_AB01(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {}

_id_ABDE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(!isDefined(var_13._id_1210)) {
    return;
  }
  if(isDefined(level._id_60D3)) {
    self[[level._id_60D3]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(isDefined(level._id_9AA7)) {
    self[[level._id_9AA7]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(var_4 != "MOD_SUICIDE") {
    if(_id_07F7::_id_85D9(var_13, var_1)) {
      return;
    }
    if(_id_07F7::_id_85D9(var_13, var_0)) {
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = var_13;
  }

  var_14 = _id_DA89(var_1, var_2, var_4, var_5, var_8, var_13);

  if(!var_14) {
    return;
  }
  if(isDefined(level._id_BB79)) {
    var_2 = var_13[[level._id_BB79]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  var_3 = var_3 | 4;
  var_15 = isDefined(var_13._id_1210);
  var_16 = var_12.basename;
  var_17 = var_12.classname;
  var_18 = var_15 && var_13._id_1210 == "zombie_brute";
  var_19 = var_15 && var_13._id_1210 == "zombie_grey";
  var_20 = var_15 && var_13._id_1210 == "slasher";
  var_21 = var_15 && var_13._id_1210 == "superslasher";
  var_22 = istrue(var_13._id_86D9);
  var_23 = istrue(var_1.inlaststand);
  var_24 = var_4 == "MOD_MELEE";
  var_25 = var_13 scripts\cp\utility::_id_1217();
  var_26 = isDefined(var_13._id_8873) && isDefined(var_5) && (!scripts\cp\cp_weapon::_id_886B(var_16) || var_4 == "MOD_MELEE");
  var_27 = scripts\engine\utility::_id_8794(var_4) || var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 != "none";
  var_28 = isDefined(var_1) && isPlayer(var_1);
  var_29 = var_27 && scripts\cp\utility::_id_8891(var_12, var_8, var_4, var_1);
  var_30 = (var_12 _meth_8624("overclock", 1) || var_12 _meth_8624("overclockcp", 1)) && var_27;
  var_31 = istrue(self._id_2382);
  var_32 = istrue(level._id_82F4) && !var_18 && !var_19;
  var_33 = !var_23 && var_29 && var_27 && var_1 scripts\cp\utility::_id_8580("headshot_explosion");
  var_34 = var_4 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_8) && var_8 == "none") || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_35 = istrue(var_13._id_7D45);
  var_36 = istrue(var_12._id_0245);
  var_37 = var_24 && var_1 scripts\cp\utility::_id_8580("increased_melee_damage");
  var_38 = var_24 && var_1 scripts\cp\utility::_id_8580("shock_melee_upgrade");

  if(var_28) {
    if(var_16 == "iw7_harpoon2_zm") {
      var_1 notify("zombie_hit_by_ben", var_6, var_13, var_13.maxhealth);
    }

    var_13._id_42ED = 1;

    if(istrue(var_1._id_439C)) {
      var_2 = var_2 * 1.25;
    }
  }

  if(istrue(var_1._id_86F2) && var_4 != "MOD_SUICIDE") {
    if(var_18) {
      var_2 = int(var_2 * 1.5);
    } else {
      var_2 = var_1._id_9D40;
    }
  }

  var_39 = 0;

  if(!var_24 && var_36 && var_28 && !isDefined(var_1._id_9500) && var_1 scripts\cp\utility::_id_8580("sniper_soft_upgrade")) {
    var_39 = var_12.classname == "sniper";
  }

  var_40 = !var_25 && (var_31 || var_32 || var_38 || var_26 || var_30 || var_33 || var_37 || var_39);
  var_41 = isDefined(var_13._id_8873);

  if(_id_094B::_id_885B(var_5) && !var_18 && !var_19) {
    var_13 thread _id_094B::_id_5CFB(var_0.origin, var_6, var_7);
    return;
  } else if(!var_41 && var_36)
    return;
  else if(var_40 && !var_18 && !var_19) {
    if(var_39) {
      var_1 scripts\cp\utility::_id_A689("sniper_soft_upgrade");
    }

    var_2 = int(var_13.maxhealth);

    if(var_38) {
      if(isDefined(var_6)) {
        playFX(level._effect["shock_melee_impact"], var_6);
      }

      var_1 thread _id_0997::_id_EAA6(var_13 getEye(), var_13, var_13.maxhealth, "MOD_UNKNOWN", undefined, var_38);
    }

    if(var_27) {
      var_1 notify("weapon_hit_enemy", var_13, var_1, var_5, var_2, var_8, var_4);
    }
  } else if(!var_19) {
    var_8 = _id_D9E1(var_1, var_4, var_5, var_8);
    var_42 = level._id_10C9F;
    var_43 = _id_85E4(var_5, var_4);
    var_44 = istrue(var_13._id_8569) && !var_27;
    var_45 = var_29 && var_1 scripts\cp\utility::_id_8580("sharp_shooter_upgrade");
    var_46 = var_27 && var_1 scripts\cp\utility::_id_8580("bonus_damage_on_last_bullets");
    var_47 = var_27 && var_1 scripts\cp\utility::_id_8580("damage_booster_upgrade");
    var_48 = var_27 && isDefined(var_1._id_E3B9) && var_1._id_E3B9 == var_12;
    var_49 = var_28 && var_1 scripts\cp\utility::_id_7531("perk_machine_boom");
    var_50 = var_28 && var_1 scripts\cp\utility::_id_7531("perk_machine_smack");
    var_51 = 0;
    var_52 = weaponclass(var_12) == "spread" && var_12 _meth_8624("smart", 1);
    var_53 = weaponclass(var_12) == "spread" && !var_52 && (var_12 _meth_8624("arkpink", 1) || var_12 _meth_8624("arkyellow", 1));
    var_54 = var_29 && var_27 && var_12 _meth_8624("highcal", 1);

    if(var_36 && var_12 _meth_8624("gl", 1)) {
      var_2 = var_13 _id_CB85(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }

    if(var_52) {
      var_2 = var_2 * 0.5;
    }

    if(isDefined(var_2) && isDefined(var_8) && !var_32 && var_27) {
      var_55 = _id_0996::_id_BD4A(var_13, var_1, var_2, var_8, var_7);

      if(var_55 <= 0) {
        return;
      }
      var_2 = var_55;
    }

    var_2 = _id_81C1(undefined, var_1, var_2, undefined, var_4, var_5, undefined, undefined, var_8, undefined, undefined, undefined);

    if(var_53) {
      var_2 = var_2 * 4;
    }

    if(var_28) {
      if(var_24) {
        if(var_12 _meth_8624("meleervn", 1)) {
          var_2 = var_2 + int(1500 * var_1 scripts\cp\cp_weapon::_id_683D(var_12));
        }

        var_2 = int(var_2 * var_1 _id_0947::_id_AFBA());

        if(isDefined(var_1._id_AEA2)) {
          var_2 = var_2 + var_1._id_AEA2;
        }

        if(var_50) {
          var_2 = var_2 + 1500;
        }

        var_56 = 0;

        if(var_2 >= var_13.health) {
          var_56 = 1;
        }

        if(isDefined(var_1._id_7DD1)) {
          var_2 = var_2 + var_1._id_7DD1;
        }

        if(var_51 || var_50) {
          if(var_51) {
            var_1 notify("axe_melee_hit", var_5, var_13, var_2);

            if(var_56 && !isDefined(var_13._id_90F1)) {
              var_13 thread _id_90DA(var_1, var_5, var_50);
              return;
            }
          } else if(var_56)
            var_13._id_DDDF = 1;
        } else if(var_56 && var_1._id_105F0 == "p1_")
          var_13 thread _id_E202(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
      }

      if(var_48) {
        var_1 thread _id_0997::_id_EAA6(var_13 getEye(), var_13, var_2, var_4, 128);
      }

      if(var_49 && var_34) {
        var_2 = int(var_2 * 2);
      }
    }

    if(var_45) {
      var_2 = var_2 * 3.0;
    }

    if(var_46) {
      var_57 = var_1 getcurrentweapon();
      var_58 = int(var_1 getweaponammoclip(var_57) + 1);
      var_59 = weaponclipsize(var_57);

      if(var_58 <= 4) {
        var_2 = var_2 * 2;
      }
    }

    if(var_27 && istrue(var_1._id_C310)) {
      var_2 = var_2 * 2;
    }

    if(var_43) {
      var_2 = var_2 * min(2 + var_42 * 0.5, 10);
    }

    if(var_47) {
      var_2 = int(var_2 * 2);
    }

    if(var_54) {
      var_2 = var_2 * 1.2;
    }
  }

  if(isDefined(var_1._id_AFAA) && var_1._id_AFAA["damagemod"]._id_2D25 == 2.0 && var_27) {
    var_2 = var_2 * 1.33;
  }

  if(isDefined(var_1._id_DD78) && (isDefined(var_1._id_DD78["impact"]._id_2D25) && var_27)) {
    var_2 = var_2 * var_1._id_DD78["impact"]._id_2D25;
  }

  if(isDefined(level._id_42D6)) {
    if(!scripts\engine\utility::_id_5C00("start_tracking_dps")) {
      scripts\engine\utility::_id_5C1B("start_tracking_dps");
    }

    if(isDefined(level._id_4EC9)) {
      level._id_4EC9 = gettime();
    }

    if(isDefined(var_1._id_F361)) {
      var_1._id_F361 = var_1._id_F361 + var_2;
    }
  }

  var_2 = var_13 _id_DAFD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  var_2 = _id_59D8(var_13, var_5, var_2, var_19, var_18, var_21, var_20);

  if(var_18) {
    if(isDefined(level._id_2C42)) {
      var_2 = var_13[[level._id_2C42]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    }
  }

  if(isDefined(var_5) && (issubstr(var_5.basename, "arcane") || issubstr(var_5.basename, "ark"))) {
    var_2 = var_2 * 1.2;
  }

  if(isDefined(level._id_ABDD)) {
    var_2 = [[level._id_ABDD]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }

  if(isDefined(var_1._id_E3C7) && (var_18 || var_19 || var_22)) {
    var_2 = var_2 * var_1._id_E3C7;
  }

  if(var_28 && scripts\cp\utility::_id_8632(var_5, 1)) {
    if(isDefined(level._effect["melee_impact"])) {
      playFX(level._effect["melee_impact"], var_13 gettagorigin("j_neck"), vectortoangles(var_13.origin - var_1.origin), anglestoup(var_13.angles), var_1);
    }
  }

  var_2 = int(min(var_2, var_13.maxhealth));

  if(var_13.health > 0 && var_13.health - var_2 <= 0) {
    if(var_13._id_4982) {
      var_13._id_4984 = var_13.health;
    }

    if(isDefined(var_13._id_74D9)) {
      var_13 _id_09A0::_id_B0C7(var_13, var_13._id_74D9, var_1);
    }

    var_13 _meth_80C6(0, 0);
  }

  if(var_28) {
    if(isDefined(level._id_FCD5)) {
      level thread[[level._id_FCD5]](var_1, var_5, var_13);
    }

    var_1 thread scripts\cp\utility::_id_1049("weapon_hit_enemy", var_13, var_1, var_5, var_2, var_8, var_4);
    var_1 thread _id_FCB8(var_16);

    if(var_27) {
      if(!isDefined(var_1._id_0E5E)) {
        var_1._id_0E5E = 1;
      } else {
        var_1._id_0E5E++;
      }

      _id_074E::_id_7DE2(var_1);
      _id_0995::_id_9743(1, var_1, var_1._id_0E5E);
    }

    if(!isDefined(var_1._id_DA6C[var_16])) {
      var_1._id_DA6C[var_16] = 1;
    } else {
      var_1._id_DA6C[var_16]++;
    }
  }

  if(var_29 && var_28 && var_41) {
    if(isDefined(var_13._id_5F5E)) {
      var_13._id_5F5E notify("headcutter_cryo_kill", var_1, var_13);
    }
  }

  _id_099E::_id_FB35(var_1, var_2, var_4);

  if(!var_18) {
    _id_06FE::_id_BD48(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_13);
  }

  _id_06FE::_id_E9B2(var_1, var_2);
  _id_0993::_id_E3C6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(var_28) {
    var_13 thread _id_A449(var_1);
  }

  var_13[[level._id_11EF[var_13._id_1210]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

_id_CB85(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_1 scripts\cp\cp_weapon::_id_683D(var_5);
  var_13 = var_2 / 110;

  if(!isDefined(var_12)) {
    return var_2;
  }

  if(var_4 != "MOD_GRENADE_SPLASH") {
    return var_2;
  }

  switch (var_12) {
    case 1:
      return 1000 * var_13;
    case 2:
      return 1500 * var_13;
    case 3:
      return 2000 * var_13;
  }

  return var_2;
}

_id_FCB8(var_0) {
  waittillframeend;
  self notify("updateMagShots_" + var_0);
}

_id_DAFD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1._id_40A0)) {
    var_12 = "j_crotch";

    if(isDefined(var_12)) {
      var_13 = self gettagorigin(var_12);
      var_14 = distance(var_13, var_6);
      var_15 = 10;

      if(var_14 <= var_15) {
        var_2 = var_2 * var_1._id_40A0;
      }
    }
  }

  return var_2;
}

_id_DA89(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    return 0;
  }

  if(isPlayer(var_0) && var_0 _meth_8507()) {
    return 0;
  }

  if(![[level._id_DA88]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return 0;
  }

  return 1;
}

_id_85E4(var_0, var_1) {
  var_2 = var_1 == "MOD_GRENADE_SPLASH" || var_1 == "MOD````_GRENADE";
  return var_2 && var_0.basename == "throwingknifec4_mp";
}

_id_ABE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self._id_E146)) {
    self._id_E146 delete();
  }

  if(isDefined(self._id_CF98)) {
    self._id_CF98 delete();
    self._id_CF98 = undefined;
  }

  if(isDefined(level._id_60D4)) {
    self[[level._id_60D4]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isDefined(level._id_9AA8)) {
    self[[level._id_9AA8]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  if(isPlayer(var_1) && var_1 scripts\cp\utility::_id_8580("explosive_touch")) {
    self._id_A546 = 1;
    self._id_5FF5 = 1;

    if(isDefined(self._id_25CA)) {
      self._id_43AD = 1;
    }
  }

  if(issubstr(var_4.basename, "iw7_knife") && isPlayer(var_1) && scripts\cp\utility::_id_8632(var_4)) {
    var_1 thread _id_D472(var_1);
  } else if((var_4.basename == "iw7_axe_zm" || var_4.basename == "iw7_axe_zm_pap1" || var_4.basename == "iw7_axe_zm_pap2") && isPlayer(var_1) && scripts\cp\utility::_id_8632(var_4)) {
    var_1 thread _id_D472(var_1);
  }

  if(isDefined(self._id_94FF)) {
    self._id_94FF._id_11016 = undefined;
    self._id_94FF = undefined;
  }

  if(!isPlayer(var_1)) {
    if(isDefined(var_1.name)) {
      if(var_1.name == var_1.owner._id_8B3D) {
        if(isDefined(var_1.owner._id_8DF0[var_1.owner._id_8B3D])) {
          var_1.owner._id_8DF0[var_1.owner._id_8B3D]++;
        }
      }
    }
  }

  if(var_4.basename == "zmb_imsprojectile_mp") {
    for(var_9 = 0; var_9 < level._id_61CA; var_9++) {
      if(isDefined(level._id_61C9[var_9])) {
        if(level._id_61C9[var_9]._id_8B3D == "crafted_gascan") {
          if(!isDefined(level._id_61C8[level._id_61C9[var_9].name])) {
            level._id_61C8[level._id_61C9[var_9].name] = 1;
            continue;
          }

          level._id_61C8[level._id_61C9[var_9].name]++;
        }
      }
    }
  }

  if(isPlayer(var_1)) {
    if(istrue(self._id_9B34)) {
      self._id_9B34 = 0;
      var_1._id_9B31 = scripts\engine\utility::array_remove(var_1._id_9B31, self);
      self setscriptablepartstate("shared_fate_fx", "inactive", 1);
      var_1 notify("weapon_hit_marked_target", var_1, var_2, var_3, var_4, self);
    }

    if(isDefined(var_1._id_10D0E) && var_1._id_10D0E > 1) {
      var_1._id_8D5A = 1;
    }

    var_10 = var_3 == "MOD_EXPLOSIVE_BULLET" && (isDefined(var_6) && var_6 == "none") || var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE" || var_3 == "MOD_PROJECTILE_SPLASH";

    if(var_10) {
      if(!isDefined(var_1._id_57E3)) {
        var_1._id_57E3 = 1;
      } else {
        var_1._id_57E3++;
      }

      _id_074E::_id_7DDC(var_1);
    }

    var_1._id_0267++;
    var_1._id_10D09 = scripts\cp\utility::_id_6902(var_4);

    if(!isDefined(var_1._id_121F[var_1._id_10D09])) {
      var_1._id_121F[var_1._id_10D09] = 1;
    } else {
      var_1._id_121F[var_1._id_10D09]++;
    }

    _id_0995::_id_9752(1, level._id_10C9F, var_1, var_4, self._id_1210, self.origin);

    if(scripts\engine\utility::_id_8794(var_3) && var_4.basename != "incendiary_ammo_mp" && var_4.basename != "slayer_ammo_mp") {
      if(isDefined(var_6) && scripts\cp\utility::_id_8891(var_4, var_6, var_3, var_1)) {
        self playsoundtoplayer("zmb_player_achieve_headshot", var_1);
      }
    }

    if(isDefined(var_1._id_8B35)) {
      foreach(var_12 in level._id_BADE) {
        if(var_12._id_10DE9 == var_4.basename) {
          if(var_12._id_10DE9 == var_1._id_8B35) {
            if(isDefined(var_1._id_8B32[var_1._id_8B35])) {
              var_1._id_8B32[var_1._id_8B35]++;
              continue;
            }

            var_1._id_8B32[var_1._id_8B35] = 1;
          }
        }
      }
    }

    level notify("zombie_killed_by", var_1);
  }

  if(isDefined(var_1.team)) {
    if(var_1.team == "allies") {
      if(!isPlayer(var_1)) {
        for(var_9 = 0; var_9 < level._id_C7FF; var_9++) {
          if(!isDefined(level._id_C7FD[level._id_C7FE[var_9].name])) {
            level._id_C7FD[level._id_C7FE[var_9].name] = 1;
            continue;
          }

          level._id_C7FD[level._id_C7FE[var_9].name]++;
        }
      }
    }
  }

  _id_075B::_id_F7FA(self);

  if(scripts\engine\utility::_id_5C0C("force_drop_max_ammo") && scripts\engine\utility::_id_5C00("force_drop_max_ammo") && var_3 != "MOD_SUICIDE") {
    if(isDefined(level._id_4FF2)) {
      level thread[[level._id_4FF2]](self.origin, var_1, "ammo_max");
    }

    scripts\engine\utility::_id_5C04("force_drop_max_ammo");
  }

  var_14 = isDefined(self._id_1210) && self._id_1210 == "zombie_brute";
  var_15 = isDefined(self._id_1210) && self._id_1210 == "zombie_grey";
  var_16 = istrue(self._id_86D9);

  if(isDefined(level._id_FD0F) && isPlayer(var_1)) {
    var_1 thread[[level._id_FD0F]](self, var_4);
  }

  if(scripts\engine\utility::_id_8794(var_3) && (getweaponbasename(var_4.basename) == "iw7_atomizer_mp" || istrue(self._id_1D61))) {
    if(!var_16 && !var_15 && !var_14) {
      self playSound("bullet_atomizer_impact_npc");

      if(isDefined(self._id_25CA)) {
        self._id_25CA thread _id_B36D();
        self._id_25CA hide(1);
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 notify("zombie_killed", self, self.origin, var_4, var_3);
  }

  if(!_id_8961(self)) {
    _id_541E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(level._id_ABE1)) {
      [[level._id_ABE1]](var_1, var_4);
    }
  }

  var_1 _id_0981::_id_761A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(level._id_E31C)) {
    [[level._id_E31C]](var_1, var_4);
  }

  if(isDefined(self._id_A3EE) && !isDefined(self._id_E04B)) {
    self._id_E04B = 1;

    if(isDefined(var_1._id_8B3D)) {
      if(var_1._id_8B3D == "crafted_medusa") {
        if(!isDefined(var_1._id_8DF0[var_1._id_8B3D])) {
          var_1._id_8DF0[var_1._id_8B3D] = 1;
        } else {
          var_1._id_8DF0[var_1._id_8B3D]++;
        }
      }
    }

    level thread[[level._id_9D2F]](self.origin, self._id_A3EE, istrue(self._id_4B40));
  }

  if(isDefined(level._id_BEA2)) {
    level thread[[level._id_BEA2]](self);
  }

  if(isPlayer(var_1) && isDefined(level._id_FCD9)) {
    level thread[[level._id_FCD9]](var_4, var_1, self, var_3, var_6);
  }

  self _meth_81AD();

  if(isDefined(self._id_1772)) {
    self._id_1772 delete();
  }

  if(isDefined(self._id_1DC9)) {
    _id_0999::_id_C2F3(self._id_1DC9);
  }

  self._id_39E3 = undefined;
  self._id_1DC9 = undefined;
  self._id_C069 = undefined;
  self._id_75DE = undefined;
  self._id_C8AA = undefined;
  self._id_4B0F = undefined;
  self._id_FD9B = undefined;
  self._id_DD05 = undefined;
  self._id_A3EE = undefined;
  _id_BD50(var_0, var_1, self, var_6, var_3, var_4);
  _id_BD3E(var_1);

  if(isDefined(level._id_43AE)) {
    [[level._id_43AE]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  } else {
    _id_06F0::_id_FB53(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  _id_0741::_id_BD3D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  _id_06FE::_id_4386();
  _id_0996::_id_383D(self);
  level notify("zombie_killed", self.origin, var_4, var_3);
}

_id_F23B(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  wait 10;
  _id_0737::_id_C3C5(var_0);
  var_1 delete();
}

_id_5B25(var_0, var_1, var_2) {
  wait 0.1;
  var_3 = var_2 + (0, 0, 50);
  var_4 = scripts\engine\utility::_id_6969(var_2, level._id_E2A4, 500);

  if(isDefined(var_4)) {
    var_5 = var_4 gettagorigin("j_neck");
    _func_0313(level._effect["deadeye_beam"], var_3, vectortoangles(var_3 - var_5), var_5);
    _func_0143(var_1, var_3, var_5, var_0);
  }
}

_id_D472(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0._id_9D91 = 1;
  waittillframeend;
  var_0._id_9D91 = 0;
}

_id_E202(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_8 != "neck" && var_8 != "head" && var_8 != "torso_upper") {
    wait 0.35;
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
  } else {
    if(randomint(100) > 30) {
      wait 0.35;
      playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
      return;
    }

    if(_id_0908::_id_881E(var_1, self._id_9D84)) {
      if(isDefined(self._id_1210) && (self._id_1210 != "zombie_brute" && self._id_1210 != "zombie_grey" && self._id_1210 != "zombie_clown")) {
        self._id_E42D = 1;
        self setscriptablepartstate("spoon", "active", 1);
        return;
      }

      return;
    }

    wait 0.35;
    playsoundatpos(self.origin, "melee_valleygirl_spoon_drop");
  }
}

_id_B36D() {
  var_0[0][0]["org"] = self gettagorigin("j_spineupper");
  var_0[0][0]["angles"] = self gettagangles("j_spineupper");
  var_0[0][1]["org"] = self gettagorigin("j_spinelower");
  var_0[0][1]["angles"] = self gettagangles("j_spinelower");
  var_1 = level._effect["atomize_body"];

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3) {
      playFX(var_1, var_5["org"], anglesToForward(var_5["angles"]));
    }

    wait 0.01;
  }
}

_id_BD50(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_6ECC(var_0, var_1, var_3, var_4, var_5);
  var_6 = _id_06FE::_id_6305(var_2);
  var_7 = scripts\cp\utility::_id_6376(var_1);
  var_8 = 0;
  var_9 = isDefined(self._id_74D9);

  if(!isDefined(var_6)) {
    return;
  }
  if(isDefined(var_7)) {
    var_10 = 0;
    var_11 = scripts\cp\utility::_id_8891(var_5, var_3, var_4, var_1);

    if(var_11) {
      var_10 = 1;

      if(!isDefined(var_7._id_761D[scripts\cp\utility::_id_6902(var_5)])) {
        var_7._id_761D[scripts\cp\utility::_id_6902(var_5)] = 1;
        var_7 _id_074E::_id_5530("headShots", 1);
      } else {
        var_7._id_761D[scripts\cp\utility::_id_6902(var_5)]++;
        var_7 _id_074E::_id_5530("headShots", 1);
      }

      var_7._id_F365++;

      if(issubstr(var_5.basename, "dischord")) {
        var_7 thread _id_076F::_id_F72D("killfirm_dischord", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5.basename, "facemelter")) {
        var_7 thread _id_076F::_id_F72D("killfirm_melter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5.basename, "shredder")) {
        var_7 thread _id_076F::_id_F72D("killfirm_shredder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5.basename, "headcutter")) {
        var_7 thread _id_076F::_id_F72D("killfirm_cutter", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else if(issubstr(var_5.basename, "harpoon")) {
        var_7 thread _id_076F::_id_F72D("killfirm_wonder", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
      } else {
        var_7 thread _id_076F::_id_F72D("killfirm_headshot", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      }
    } else if(var_5.basename == "iw7_forgefreeze_zm+forgefreezealtfire" || var_5.basename == "iw7_forgefreeze_zm" || var_5.basename == "alt_iw7_forgefreeze_zm+forgefreezealtfire") {
      var_10 = 1;
      var_7 thread _id_076F::_id_F72D("killfirm_freeze", "zmb_comment_vo", "high", 10, 0, 0, 0, 10);
    }

    if(var_10 == 0) {
      if(isDefined(var_2._id_106A9)) {
        if(var_2._id_106A9 == "zmb_vo_clown_") {
          level thread _id_09A5::_id_B313(var_2, "death", 1);
          var_7 thread _id_076F::_id_F72D("killfirm_clown", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      }

      if(var_2._id_1210 == "zombie_cop") {
        if(randomint(100) > 60) {
          var_7 thread _id_076F::_id_F72D("killfirm_cop", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_7 thread _id_076F::_id_F72D("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      } else if(var_2._id_1210 == "zombie_sasquatch") {
        if(randomint(100) > 60) {
          var_7 thread _id_076F::_id_F72D("killfirm_sasquatch", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_7 thread _id_076F::_id_F72D("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      } else if(var_2._id_1210 == "lumberjack") {
        if(randomint(100) > 60) {
          var_7 thread _id_076F::_id_F72D("killfirm_lumberjack", "rave_comment_vo", "low", 10, 0, 0, 0, 20);
        } else {
          var_7 thread _id_076F::_id_F72D("killfirm", "zmb_comment_vo", "low", 10, 0, 0, 0, 20);
        }
      } else if(var_2._id_1210 == "zombie_brute")
        level thread _id_09A5::_id_B313(var_2, "death", 1);
    }
  }

  if(isDefined(self._id_857A)) {
    return;
  }
  if(isDefined(var_7)) {
    _id_074E::_id_C13B(var_5, var_3, var_4, var_7);
  }

  if(isDefined(level._id_1102E)) {
    if([[level._id_1102E]](var_6, self.origin, var_1)) {
      return;
    }
  }

  if(isDefined(var_7)) {
    if(self isonground()) {
      var_14 = isDefined(var_2._id_1210) && (var_2._id_1210 == "zombie_brute" || var_2._id_1210 == "zombie_grey");

      if(gettime() < level._id_8F1C + 5000) {
        return;
      }
      if(scripts\cp\utility::_id_5481(self)) {
        return;
      }
      if(scripts\cp\utility::_id_F336(self.origin)) {
        return;
      }
      if(!var_9 && !var_14) {
        if(scripts\engine\utility::_id_5C0C("can_drop_coins") && scripts\engine\utility::_id_5C00("can_drop_coins") && isDefined(level._id_3E4E) && istrue([[level._id_3E4E]](var_6, self.origin, var_1))) {
          level._id_8F1C = gettime();
          return;
        } else if(isDefined(level._id_9855) && scripts\engine\utility::_id_5C0C("zombie_drop_powerups") && scripts\engine\utility::_id_5C00("zombie_drop_powerups"))
          [[level._id_9855]](var_6, self.origin, var_1);
      }
    }
  }
}

_id_BD3E(var_0) {
  if(!isDefined(self._id_1DD0)) {
    return;
  }
  foreach(var_2 in self._id_1DD0) {
    if(isDefined(var_2.player)) {
      if(var_2.player == var_0) {
        continue;
      } else {
        var_2.player _id_074E::_id_5530("assists", 1);
      }
    }
  }
}

_id_6ECC(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_1.team) && self.team == var_1.team) {
    return;
  }
  var_5 = _id_07F7::_id_6305(self);
  var_6 = level._id_11ED[var_5]["reward"];
  var_7 = level._id_11ED[var_5]["xp"];
  var_8 = 0;
  var_9 = istrue(self._id_86D9);
  var_10 = isDefined(var_4) && (var_4.basename == "incendiary_ammo_mp" || var_4.basename == "slayer_ammo_mp");

  if(var_1.classname == "trigger_radius") {
    if(isDefined(level._id_3BAD)) {
      var_11 = var_6 * (level._id_32FF + level._id_3BAD);
    } else {
      var_11 = var_6 * level._id_32FF;
    }

    foreach(var_13 in level.players) {
      if(!var_13 scripts\cp\utility::_id_8708()) {
        continue;
      }
      if(isDefined(level._id_1105F)) {
        var_13 _id_074E::_id_6F38(int(var_7));
      }

      if(istrue(level._id_E3C2)) {
        continue;
      }
      var_14 = "large";
      var_2 = "none";
      var_13 _id_074E::_id_6F28(var_11, var_14, var_2, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
    return;
  }
  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
    var_8 = 1;
  }

  if(!var_10 && (var_5 == "generic_zombie" || var_5 == "fast_zombie" || var_5 == "zombie_cop")) {
    if(scripts\cp\utility::_id_8891(var_4, var_2, var_3, var_1) && !var_8 && scripts\engine\utility::_id_8794(var_3) && !var_9) {
      var_6 = int(100);
      var_7 = int(75);
    }

    if(isDefined(var_3) && var_3 == "MOD_MELEE" && !issubstr(var_4.basename, "axe")) {
      var_6 = int(130);
      var_7 = int(100);
    }
  }

  if(isPlayer(var_1)) {
    var_16 = scripts\cp\utility::_id_6859(var_1, var_4);

    if(scripts\cp\utility::_id_891F(var_16)) {
      var_7 = var_7 * 1.15;
    }
  }

  if(isDefined(level._id_8D4A)) {
    var_6 = [[level._id_8D4A]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  }

  if(isDefined(var_6)) {
    _id_6FAA(var_0, var_1, var_6, var_7, "large", var_2, var_4, var_3);
  }
}

_id_34DF(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  var_1 = scripts\cp\utility::_id_6902(var_0);

  switch (var_1) {
    case "iw7_m8":
      if(scripts\cp\utility::_id_874D(var_0)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

_id_6FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(level._id_3BAD)) {
    var_2 = var_2 * (level._id_32FF + level._id_3BAD);
  } else {
    var_2 = var_2 * level._id_32FF;
  }

  var_1 thread _id_6FC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(self._id_D9B2)) {
    foreach(var_9 in level.players) {
      if(!var_9 scripts\cp\utility::_id_8708()) {
        continue;
      }
      if(istrue(level._id_E3C2)) {
        continue;
      }
      var_9 _id_074E::_id_6F28(var_2, var_4, var_5, 1, "crafted");
    }
  } else if(_id_DAA5(var_0, var_1, var_6))
    var_1 _id_074E::_id_6F28(var_2, var_4, var_5, 1);

  if(isDefined(level._id_1105F)) {
    var_1 _id_074E::_id_6F38(int(var_3));
  }
}

_id_6FC9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(_id_DAA5(var_0, var_1, var_6)) {
    if(var_1 scripts\cp\utility::_id_8580("extra_sniping_points") && scripts\engine\utility::_id_8794(var_7) && var_6.classname == "weapon_sniper" && _id_34DF(var_6)) {
      var_8 = 300;

      if(var_6 == "iw7_shared_fate_weapon") {
        var_1 scripts\cp\utility::_id_A689("extra_sniping_points");
      } else {
        var_1 scripts\cp\utility::_id_A689("extra_sniping_points");
        var_1 thread _id_46CC(var_8, var_4, var_5, "bonus", 0.15);
      }
    }

    if(isPlayer(var_1) && isDefined(var_1._id_32FF)) {
      if(isDefined(var_1._id_3301) && var_1._id_3301 == scripts\cp\utility::_id_6CE3(var_6)) {
        var_9 = int(var_2 * var_1._id_32FF - var_2);
        var_1 thread _id_46CC(var_9, var_4, var_5, "bonus", 0.25);
      }

      if(isDefined(var_1._id_3300) && var_1._id_3300 == scripts\cp\utility::_id_6CE3(var_6) && istrue(var_6._id_0245) && istrue(var_1._id_1647)) {
        var_9 = int(var_2 * var_1._id_32FF - var_2);
        var_1 thread _id_46CC(var_9, var_4, var_5, "bonus", 0.25);
      }
    }
  }
}

_id_46CC(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  wait(var_4);
  _id_074E::_id_6F28(var_0, var_1, var_2, 1, var_3);
}

_id_DAA5(var_0, var_1, var_2) {
  if(isPlayer(var_1) && _id_073B::_id_B4EF(var_1)) {
    return 0;
  }

  if(scripts\cp\utility::_id_86EC(var_0, var_2)) {
    return 0;
  }

  if(istrue(level._id_E3C2)) {
    return 0;
  }

  return 1;
}

_id_541E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level._id_8FC7 = self.origin;

  if(isDefined(level._id_BD6A)) {
    self thread[[level._id_BD6A]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, self.origin);
  }
}

_id_8961(var_0) {
  if(isDefined(var_0.team)) {
    return var_0.team == level._id_B7F4;
  }

  return 0;
}

_id_D9E1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isPlayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::_id_8580("sniper_soft_upgrade") && var_2.classname == "weapon_sniper") {
    return "head";
  }

  if(isDefined(var_0) && isPlayer(var_0) && var_1 != "MOD_MELEE" && var_0 scripts\cp\utility::_id_8580("increased_limb_damage") && _id_8626(var_2, var_3, var_1, var_0)) {
    return "torso_upper";
  }

  return var_3;
}

_id_DA54(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && weaponclass(var_2) == "spread") {
    var_3 = "" + gettime();

    if(!isDefined(var_0._id_AF80) || !isDefined(var_0._id_AF80[var_3])) {
      var_0._id_AF80 = undefined;
      var_0._id_AF80[var_3] = [];
    }

    if(!isDefined(var_0._id_AF80[var_3][var_1.guid])) {
      var_0._id_AF80[var_3][var_1.guid] = 1;
      waitframe();

      if(var_1.health > 1) {
        return 1;
      } else {
        return 0;
      }
    } else
      return 0;
  }

  return 0;
}

_id_81C1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!_id_30EF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    return var_2;
  }

  var_12 = isDefined(self._id_1210) && (self._id_1210 == "zombie_brute" || self._id_1210 == "zombie_grey");

  if(isDefined(var_5)) {
    if(isDefined(var_4) && var_4 == "MOD_MELEE") {
      if(isDefined(level._id_9D63) && scripts\engine\utility::array_contains(level._id_9D63, var_5.basename)) {
        return var_2;
      } else if(issubstr(var_5.basename, "rvn")) {
        var_2 = min(self.maxhealth, var_2);
        return var_2;
      }

      return var_2;
    } else if(var_5.basename == "alien_sentry_minigun_4_mp") {
      if(var_12) {
        var_2 = min(int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25)), 2500);
      } else {
        var_2 = int(self.maxhealth / 5 * randomfloatrange(0.75, 1.25));
      }
    }

    return var_2;
  }

  return var_2;
}

_id_59D8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1)) {
    return var_2;
  }

  var_7 = var_1.basename;

  if(isDefined(var_7)) {
    switch (var_7) {
      case "iw7_claw_mp":
      case "iw7_steeldragon_mp":
        if(var_3 || var_5 || var_6) {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        } else {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        }

        break;
      case "iw7_blackholegun_mp":
        if(var_5 || var_6) {
          var_2 = min(max(var_0.maxhealth * 0.34, 300), 1000);
        } else {
          var_2 = min(var_2 * 10, 2000);
        }

        break;
      case "iw7_atomizer_mp":
      case "iw7_penetrationrail_mp":
        if(var_3 || var_5 || var_6) {
          var_2 = 2500;
        } else if(var_4) {
          var_2 = var_0.maxhealth / 10;
        } else {
          var_2 = var_0.maxhealth;
        }

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

_id_C139(var_0) {
  if(!isDefined(self._id_C146)) {
    self._id_C146 = 1;
    var_1 = self.health;
    wait(var_0);
    var_2 = self.health;
    var_3 = var_1 - var_2;
    iprintln("damage: " + var_3);
    self._id_C146 = undefined;
  }
}

_id_30EF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(istrue(var_1.inlaststand)) {
    return 0;
  }

  if(isPlayer(var_1) && !isDefined(var_1._id_AE0A)) {
    return 0;
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  if(var_4 == "MOD_SUICIDE") {
    return 0;
  }

  if(var_4 == "MOD_UNKNOWN") {
    return 0;
  }

  return 1;
}

_id_5143(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(istrue(_id_073B::_id_B4EF(var_0))) {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(var_5 < 1) {
    return 0;
  }

  if(istrue(var_4._id_86D9)) {
    return 0;
  }

  if(istrue(level._id_7E84) && scripts\engine\utility::_id_8794(var_2)) {
    return 0;
  }

  if(istrue(level._id_E3C2)) {
    return 0;
  }

  if(isDefined(var_4._id_1210) && var_4._id_1210 == "zombie_brute") {
    return 0;
  }

  if(scripts\cp\utility::_id_86EC(var_1, var_3)) {
    return 0;
  }

  if(weaponclass(var_3) == "spread") {
    if(!_id_DA54(var_0, var_4, var_3)) {
      return 0;
    }
  }

  if(var_3.basename == "incendiary_ammo_mp" || var_3.basename == "slayer_ammo_mp" || var_3.basename == "iw7_facemelterdummy_zm" || var_3.basename == "iw7_scrambler_zm") {
    return 0;
  }

  switch (var_2) {
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_RIFLE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      if(var_3.basename == "gas_grenade_mp" || var_3.basename == "splash_grenade_zm") {
        if(isDefined(var_4._id_5C4B)) {
          if(gettime() > var_4._id_5C4B) {
            return 1;
          } else {
            return 0;
          }
        }
      }

      return 1;
    case "MOD_UNKNOWN":
      if(istrue(var_4._id_8569) && isDefined(var_4._id_5C4B)) {
        if(gettime() > var_4._id_5C4B) {
          return 1;
        }
      }

      return 0;
    default:
      break;
  }

  if(!istrue(var_4._id_8569)) {
    return 1;
  }

  if(!istrue(var_4._id_9B33)) {
    return 1;
  }

  if([[level._id_5142]](var_0, var_1, var_2, var_3, var_4, var_5)) {
    return 1;
  }

  return 0;
}

_id_ABDF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(level._id_3BAD)) {
    var_13 = 10 * (level._id_32FF + level._id_3BAD);
  } else {
    var_13 = 10 * level._id_32FF;
  }

  if(isDefined(var_1)) {
    if(_id_5143(var_1, var_0, var_4, var_5, self, var_2)) {
      var_14 = gettime();

      if(var_14 > var_1._id_A491 && (level._id_32FF > 1 || var_1 scripts\cp\utility::_id_8580("hit_reward_upgrade") || isDefined(level._id_3BAD))) {
        _func_019D(level._effect["extra_cash_kill"], self, "j_spineupper", var_1);
        var_1._id_A491 = var_14 + 1000;
      }

      if(var_1 scripts\cp\utility::_id_8580("hit_reward_upgrade")) {
        var_1 scripts\cp\utility::_id_A689("hit_reward_upgrade");
        var_15 = int(var_13 * 2 - var_13);
        var_1 thread _id_46CC(var_15, "large", var_8, "bonus", 0.2);
      }

      var_1 _id_074E::_id_6F28(var_13, "large", var_8);
    }
  }
}

_id_607A() {
  self endon("death");
  wait 1;
  self._id_EAAB = undefined;
}

_id_8977(var_0) {
  return isDefined(self._id_AF84) && self._id_AF84;
}

_id_DA91(var_0, var_1, var_2) {
  if(_id_8977()) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(_id_06FE::_id_6305(self) == "elite" || _id_06FE::_id_6305(self) == "elite_boss") {
    return 0;
  }

  if(istrue(self._id_8569)) {
    return 0;
  }

  if(isDefined(var_2) && isDefined(var_2._id_332F) && var_2._id_332F == "lightning_tower") {
    return 1;
  }

  if(isDefined(var_2) && isPlayer(var_2) && var_1 != "MOD_MELEE") {
    var_3 = isDefined(var_0) && var_0 == getcompleteweaponname(var_2 getcurrentprimaryweapon());
    return var_3 && var_2 scripts\cp\utility::_id_7524();
  }

  return 0;
}

_id_1106D() {
  return self._id_03E9._id_11081;
}

_id_110AA() {
  return 0;
}

_id_696E() {
  while(!isDefined(self._id_39E3)) {
    wait 0.1;
  }

  return self._id_39E3;
}

_id_62A6() {
  self._id_30B9 = 0;
  self._id_1DC9 = undefined;
  self._id_54D1 = 0;
  self._id_9B33 = undefined;
  self._id_F4B9 = undefined;
  self._id_75BE = 0;
  self._id_4982 = 0;
  self._id_8873 = undefined;
  self._id_5D22 = undefined;
  self._id_2382 = undefined;
  self._id_DABE = undefined;
  self._id_86D9 = undefined;
  self._id_869D = undefined;
  self._id_857A = undefined;
  self._id_CF4A = 0;
  self._id_8595 = 0;
  self._id_0E0F = 0;
  self._id_86F2 = 0;
  self._id_9D40 = undefined;
  self._id_A1EE = undefined;
  self._id_25C1 = undefined;
  self._id_DB0E = undefined;
  self._id_9B32 = undefined;
  self._id_42EF = [];
  self._id_C8AA = undefined;
  self._id_C8B3 = undefined;
  self._id_25C5 = undefined;
  self._id_4D8F = undefined;
  self._id_E04B = undefined;
  self._id_A463 = undefined;
  self._id_74D9 = undefined;
  self._id_90F1 = undefined;
  self._id_DDDF = undefined;
  self._id_855F = undefined;
  self._id_5F65 = undefined;
  self._id_8D78 = undefined;
  self._id_1D61 = undefined;
  self._id_D9B2 = undefined;

  if(isDefined(self._id_433A)) {
    self._id_433A._id_A926 = 0;
  }

  self._id_433A = undefined;
  thread _id_F140();
}

_id_DA78() {
  var_0 = 50;
  self._id_39E5 = _id_63EF(self);

  if(!isDefined(self._id_39E5)) {
    return 0;
  }

  if(randomint(100) > var_0) {
    return 0;
  }

  return 1;
}

_id_DD34() {
  var_0 = 55;
  var_1 = self.origin + (0, 0, var_0);
  var_2 = self._id_39E5.origin + (0, 0, var_0);
  return _func_0202(var_1, var_2, 0, self);
}

_id_63EF(var_0) {
  var_1 = scripts\engine\utility::_id_6369(var_0.origin, level.players)[0];
  var_2 = scripts\engine\utility::_id_6969(var_0.origin, level._id_417B);

  if(!_id_866F(var_1, var_2)) {
    var_1 = undefined;
  }

  return var_1;
}

_id_866F(var_0, var_1) {
  var_2 = 2304;
  return distancesquared(var_0.origin, var_1.origin) < var_2;
}

_id_1DC6() {
  if(!isDefined(self._id_1DC9)) {
    return;
  }
  self._id_DB0E = 1;

  if(isDefined(self._id_1DC9.angles)) {
    self._id_25C1 = self._id_1DC9.angles;
  } else {
    self._id_25C1 = (0, 0, 0);
  }

  for(;;) {
    self waittill("boardbreak", var_0);

    if(var_0[0] == "hit") {
      break;
    }
  }

  self._id_DB0E = 0;
  self._id_25C1 = undefined;
  var_1 = scripts\engine\utility::_id_6969(self.origin, level._id_417B);

  if(_id_866F(self._id_39E5, var_1)) {
    _id_0908::_id_4D17(self._id_39E5, _id_0908::_id_659A(), "MOD_IMPACT");
  }
}

_id_2B76(var_0) {
  if(isDefined(self._id_1DC9)) {
    if(isDefined(self._id_1DC9.angles)) {
      self._id_25C1 = self._id_1DC9.angles;
    } else {
      self._id_25C1 = (0, 0, 0);
    }
  }

  self._id_DB0E = 1;

  for(;;) {
    self waittill("boardbreak", var_1);

    if(var_1[0] == "hit") {
      break;
    }
  }

  _id_0999::_id_C382(var_0);

  if(!_id_0999::_id_5519(var_0)) {
    self._id_DB0E = 0;
    self._id_012F = undefined;
    self._id_0229 = 0;
    self.ignoreme = 0;
    _id_0999::_id_C2F3(self._id_1DC9);
    self._id_1DC9 = undefined;
  }
}

_id_1C44() {
  self endon("death");
  self notify("asmDebug");
  self endon("asmDebug");
  var_0 = (0, 0, 72);
  var_1 = (0, 0, -8);

  for(;;) {
    if(isDefined(self._id_1CB8)) {
      var_2 = self _meth_85CC(self._id_1CB8);
      var_3 = var_0 + var_1;
    }

    waitframe();
  }
}

_id_8D32() {
  self endon("death");

  if(!isDefined(level._id_3D8F)) {
    level._id_3D8F = [];
  }

  if(!isDefined(level._id_3D8F["60"])) {
    level._id_3D8F["60"] = cos(60);
  }

  var_0 = 0;
  var_1 = self.origin;
  wait(randomintrange(5, 8));

  while(!istrue(self._id_54D1)) {
    var_2 = var_1;
    var_1 = self.origin;
    var_3 = 0;

    if(distance2dsquared(var_2, var_1) < 100) {
      foreach(var_5 in level.players) {
        if(distancesquared(var_5.origin, self.origin) < 4000000) {
          if(scripts\engine\utility::_id_10E76(var_5.origin, var_5.angles, self.origin, level._id_3D8F["60"])) {
            var_6 = var_5 getEye();

            if(scripts\engine\trace::ray_trace_passed(var_6, self.origin + (0, 0, 40), self)) {
              var_3 = 1;
            }
          }
        }
      }

      if(var_3) {
        wait 2;
        continue;
      }

      var_0 = 1;
      break;
    } else
      wait 2;
  }

  if(!var_0) {
    return;
  }
  self._id_4982 = 1;

  if(istrue(self._id_9B32) && isDefined(level._id_A768)) {
    level._id_A768--;
  }

  self dodamage(self.health + 1000, self.origin, self, self, "MOD_SUICIDE");
}

_id_8626(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3.owner)) {
      if(var_3._id_00EC == "script_vehicle") {
        return 0;
      }

      if(var_3._id_00EC == "misc_turret") {
        return 0;
      }

      if(var_3._id_00EC == "script_model") {
        return 0;
      }
    }

    if(isDefined(var_3._id_1210)) {
      if(var_3._id_1210 == "dog" || var_3._id_1210 == "alien") {
        return 0;
      }
    }
  }

  return var_1 == "left_leg_upper" || var_1 == "right_foot" || var_1 == "left_leg_lower" || var_1 == "right_leg_lower" || var_1 == "left_foot" || var_1 == "right_leg_upper" || var_1 == "right_arm_lower" || var_1 == "left_arm_lower" || var_1 == "right_hand" || var_1 == "left_hand";
}

_id_C9DA(var_0) {
  if(level._id_4815 - level._id_416B == 1) {
    if(!isDefined(self._id_CA0B)) {
      if(level._id_10C9F < 4) {
        self._id_CA0B = gettime() + 80000;
      } else {
        self._id_CA0B = gettime() - 1;
      }
    }

    if(self._id_CA0B < gettime() && isDefined(self._id_1C30._id_4130) && self._id_1C30._id_4130 != "sprint") {
      return "run";
    }
  }

  return undefined;
}

_id_8128() {
  _func_004D("player1");
  _func_004D("player2");
  _func_004D("player3");
  _func_004D("player4");
  _func_004D("player1_enemy");
  _func_004D("player2_enemy");
  _func_004D("player3_enemy");
  _func_004D("player4_enemy");
  _func_01FA("player1", "player1_enemy", 10000);
  _func_01FA("player2", "player2_enemy", 10000);
  _func_01FA("player3", "player3_enemy", 10000);
  _func_01FA("player4", "player4_enemy", 10000);
}

_id_7DC0(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  if(_func_011D(var_1)) {
    var_2 = var_1 _meth_8181();

    if(_func_0247(var_2 + "_enemy")) {
      var_0 _meth_8390(var_2 + "_enemy");
    }

    wait 5;
    var_0 _meth_8390();
  }
}

_id_F140() {
  self endon("death");
  var_0 = 100;
  var_1 = 200;
  var_2 = 200;
  var_3 = var_2 * var_2;
  self._id_EC1C = 0;
  self._id_8F12 = 0;
  self._id_A448 = undefined;

  for(;;) {
    if(isDefined(self._id_0192)) {
      var_4 = distancesquared(self.origin, self._id_0192.origin);

      if(isDefined(self._id_A448)) {
        if(self._id_EC1C >= var_1) {
          self._id_EC1C = 0;
          _id_7DC0(self, self._id_A448);
          wait 0.25;
          continue;
        } else {
          var_5 = distancesquared(self.origin, self._id_A448.origin);

          if(var_5 < var_3 && var_5 < var_4) {
            self._id_EC1C = self._id_EC1C + var_0;
            wait 0.25;
            continue;
          } else {
            self._id_EC1C = 0;
            var_6 = scripts\engine\utility::array_remove(level.players, self._id_0192);

            if(var_6.size > 0) {
              var_6 = scripts\engine\utility::array_remove(var_6, self._id_A448);
            }

            self._id_A448 = undefined;
            _id_345F(var_4, var_6);
            wait 0.25;
            continue;
          }
        }
      } else {
        self._id_EC1C = 0;
        var_6 = scripts\engine\utility::array_remove(level.players, self._id_0192);
        _id_345F(var_4, var_6);
        wait 0.25;
        continue;
      }
    }

    wait 0.25;
  }
}

_id_345F(var_0, var_1) {
  var_2 = 200;
  var_3 = var_2 * var_2;

  if(var_1.size > 0) {
    foreach(var_5 in var_1) {
      var_6 = distancesquared(self.origin, var_5.origin);

      if(var_6 < var_3 && var_6 < var_0) {
        self._id_A448 = var_5;
      }
    }
  }
}

_id_A449(var_0) {
  if(!isDefined(self._id_8F12)) {
    self._id_8F12 = 0;
  }

  var_1 = 100;

  if(isDefined(self._id_0192)) {
    if(var_0 == self._id_0192) {
      self._id_8F12 = gettime();
    } else {
      var_2 = gettime();

      if(var_2 - self._id_8F12 > 5000) {
        if(isDefined(self._id_A448)) {
          if(var_0 == self._id_A448) {
            self._id_EC1C = self._id_EC1C + var_1;
          }
        } else {
          self._id_A448 = var_0;
          self._id_EC1C = 0;
        }
      }
    }
  }
}

_id_2F43(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_7D5B(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_7D5B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level._id_74CB)) {
    [[level._id_74CB]](var_2, var_0, var_1, var_4, var_5, var_6, var_7, var_8);
  } else {
    var_1 startragdoll();
    var_9 = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
    var_10 = var_4 + var_5 * 4096;
    var_11 = scripts\engine\trace::_id_C051(var_4, var_10, undefined, var_9, undefined, 1);
    var_10 = var_11["position"] - var_5 * 12;
    var_12 = length(var_10 - var_4);
    var_13 = var_12 / 1250;
    var_13 = clamp(var_13, 0.05, 1);
    wait 0.05;
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = _func_025B(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, _func_0017(var_14, var_16, var_15));
    var_17 moveto(var_10, var_13);
    var_18 = _func_0212(var_1, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkto(var_17);
    thread _id_7D5C(var_1, var_17, var_13 + 0.05, var_18);
  }
}

_id_7D5E(var_0, var_1) {
  wait(clamp(var_1 + 0.5, 0.05, 20));
  _id_06D6::_id_B842(scripts\engine\utility::getfx("penetration_railgun_explosion"), var_0);
}

_id_7D5C(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::_id_108A8(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

_id_90DA(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("disconnect");
  self._id_4C08 = 1;
  self._id_426B = 1;
  self._id_49D8 = 1;
  self._id_90F1 = 1;

  if(randomint(100) > 50 && !isDefined(self._id_86D9)) {
    self._id_A546 = undefined;
    var_3 = 50;
    var_4 = 50;

    if(var_2) {
      var_3 = 300;
      var_4 = 150;
    }

    self setvelocity(vectornormalize(self.origin - var_0.origin) * var_3 + (0, 0, var_4));
    wait 0.1;
  } else {
    self._id_5FF5 = 1;
    self._id_A546 = 1;
  }

  self dodamage(self.health + 1000, var_0.origin, var_0, var_0, "MOD_MELEE");
}

_id_A0D8() {
  scripts\engine\utility::_id_5C11("player_count_determined");
  var_0 = getDvar("#x345ba6dff8ecba1eb");

  if(var_0 != "1") {
    level._id_AB30 = 0;
    scripts\engine\utility::_id_5C1B("player_count_determined");
    return;
  }

  level._id_AB30 = 1;
  scripts\engine\utility::_id_5C1B("player_count_determined");

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    if(level.players.size > 1) {
      break;
    }

    wait 1;
  }

  level._id_AB30 = 0;
  level notify("multiple_players");
}