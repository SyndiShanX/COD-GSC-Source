/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1987.gsc
*************************************************/

_id_2F39(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "worldspawn") {
    var_1 = undefined;
  }

  if(isDefined(var_1) && isDefined(var_1._id_72B3)) {
    var_1 = var_1._id_72B3;
  }

  if(istrue(var_2._id_B928)) {
    return;
  }
  if(var_5 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_2 scripts\cp_mp\utility\player_utility::getvehicle()) && var_2 scripts\cp_mp\utility\player_utility::getvehicle() == var_0) {
    return;
  }
  if(istrue(var_2.inlaststand) && istrue(level._id_9086) && var_5 != "MOD_MELEE") {
    return;
  }
  var_18 = var_2.health;

  if(var_4 &level._id_7CA8) {
    return;
  }
  var_19 = _id_5A4B(var_0, var_1, var_2, var_3, var_5, var_6, var_9);

  if(isDefined(var_19)) {
    return;
  }
  var_20 = _id_0A8B::_id_1DD9(var_2, var_1);
  var_21 = isDefined(var_6) && scripts\mp\utility\weapon::_id_88F6(var_6.basename);

  if(!istrue(level._id_15CA)) {
    if(istrue(game["inLiveLobby"]) || !_id_07D1::_id_60BE("prematch_done") || istrue(level._id_7E6A)) {
      _id_7430(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_21, var_15);
      return;
    }
  }

  if(var_20) {
    var_3 = _id_744C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_21);

    if(var_3 == 0) {
      return;
    }
  }

  if(var_6.basename == "s4_ar_stango44_mp_v7") {
    var_2 thread scripts\mp\weapons::_id_523C(0.1, "fs_active");
  }

  if(istrue(var_2._id_E355)) {
    var_22 = isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "trigger_hurt";
    var_23 = var_5 == "MOD_FALLING";

    if(!var_22 && !var_23) {
      _id_7430(var_0, var_1, var_2, 0, var_5, var_6, var_9, var_4, 1, 1, var_21, var_15);
      return;
    }
  }

  if(isDefined(var_1) && istrue(var_1._id_3E59)) {
    var_1 thread _id_07C1::_id_AA93(var_2);
  }

  if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return;
  }
  if(scripts\engine\utility::_id_8794(var_5)) {
    var_24 = _func_0489(var_6);
    var_25 = var_24 < 0;

    if(isDefined(var_1) && var_1 scripts\mp\utility\perk::_hasperk("specialty_vital") && !var_25) {
      var_3 = _id_6E46(var_0, var_6, var_9, var_3, var_14);
    }
  }

  if(isDefined(var_9) && var_9 == "soft" && isDefined(var_2._id_EAF7) && var_2._id_EAF7 == "s4_ks_juggernaut_mp") {
    var_2 _id_07E6::jugg_damagetank(var_3, var_1, var_6, var_7);
  } else {
    var_4 = var_4 | level._id_7C9D;

    if(_id_8A5B(var_6) || isbuckslugweapon(var_1, var_6) || var_6 _meth_8624("ammo_incendiary", 1)) {
      if(_id_078C::_id_880F(var_6) && _id_0A8B::_id_FF64(var_6, var_5, var_1)) {
        var_2 thread _id_4EE1(var_9, var_1, var_6);
      }

      var_3 = _id_E44B(var_2, var_1, var_6, var_3, var_4, var_9);

      if(var_3 == 0) {
        return;
      }
    }

    var_26 = var_6.basename;
    var_27 = scripts\mp\utility\weapon::_id_6A18(var_26);

    if(isDefined(var_27)) {
      if(var_27 == "lethal") {
        var_3 = _id_91E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      } else if(var_27 == "equipment_other") {} else if(var_27 == "tactical") {
        if(isDefined(var_26) && var_26 == "s4_stun_gbr_n69_mp") {
          if(level._id_74C4) {
            var_3 = min(var_3, 5);
          }

          if(scripts\mp\utility\game::isanymlgmatch()) {
            var_3 = min(var_3, 5);
          }
        }

        if(isDefined(var_26) && var_26 == "s4_mine_ger_s44_mp") {
          if(level._id_74C4) {
            var_3 = min(var_3, 10);
          }
        }
      }

      var_28 = _id_09BF::_id_ADCA(var_1, var_2, var_3, var_6, var_5, var_0, var_7, var_8, undefined, var_12, undefined, var_4);
      var_29 = scripts\mp\equipment::_id_558E(var_28);

      if(isDefined(var_29) && var_29 == 0) {
        return;
      }
    }

    if(var_2 scripts\mp\utility\game::_id_8923() && var_5 != "MOD_SUICIDE") {
      var_30 = istrue(var_6._id_0245);

      if(isDefined(var_27) && var_26 != "s4_throwing_knife_mp" || var_30 || var_5 == "MOD_EXPLOSIVE") {
        var_31 = int(max(var_2.health / 5, 1));

        if(var_3 >= var_31) {
          var_3 = var_31;
        }
      }
    }

    var_32 = scripts\mp\utility\weapon::_id_6E90(var_26);

    if(isDefined(var_32) && var_32 == "killstreak") {
      var_3 = _id_8DCD(var_1, var_2, var_3, var_6, var_5);

      if(var_3 == 0) {
        return;
      }
      if(isDefined(level._id_731C) && isDefined(var_1) && level._id_731C == var_1) {
        level notify("ai_pain", var_2);
      }
    }

    if(_func_010F(var_5)) {
      switch (var_6.basename) {
        case "s4_frag_gbr_n82_mp":
          var_33 = strtok(level.gametype, "_");
          var_34 = getdvarint("#x395eaf3392bf4a723", 0);

          if(var_33[0] == "hc" || var_34 || self.maxhealth == 30) {
            var_34 = 1;
          }

          if(var_34) {
            var_35 = distancesquared(var_2.origin, var_7);
            var_36 = getdvarint("#x3c5c6473271707122", 200);
            var_37 = getdvarint("#x35bcf7ed5434d94d6", 20);
            var_38 = getdvarint("#x3e96a4ae6231a1b2c", 10);
            var_39 = var_37 - var_38;

            if(var_35 > var_36 * var_36) {
              var_3 = 0;
            } else {
              var_40 = 1 - var_35 / (var_36 * var_36);
              var_3 = int(var_40 * var_39 + var_38);
            }
          }

          break;
      }

      if(var_2 scripts\mp\utility\perk::_hasperk("specialty_vanguard")) {
        var_3 = var_2 _id_0A6B::_id_B002(var_3, var_6, var_5);
      }
    }

    if(isfiredamage(var_5) && var_2 scripts\mp\utility\perk::_hasperk("specialty_vanguard")) {
      var_3 = var_2 _id_0A6B::perkvanguard_modifyfiredmg(var_3);
    }

    if(isburningdamage(var_5) && var_2 scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
      var_3 = var_2 _id_0A6B::perkdauntless_modifyburndmg(var_3);
    }

    if(scripts\engine\utility::is_equal(scripts\mp\utility\game::getgametype(), "base") && istrue(var_2.innocapturearea)) {
      if(isDefined(var_2.nocaptureareateam) && scripts\engine\utility::is_equal(var_2.nocaptureareateam, var_2.team)) {
        var_3 = 0;
      }
    }

    if(var_5 == "MOD_FALLING" && var_2 scripts\mp\utility\perk::_hasperk("specialty_featherfall")) {
      var_3 = var_3 * getdvarfloat("#x3f4baef9fde77a767", 0.5);
    }

    if(var_2 scripts\mp\utility\perk::_hasperk("specialty_serpentine") && var_5 != "MOD_FALLING" && (var_2 issprinting() || var_2 issprintsliding() || var_2 _meth_81E6() || var_2 _meth_86CF())) {
      var_3 = var_3 * getdvarfloat("#x33ed069ca4b970a4a", 0.8);
    }

    if(var_2 scripts\mp\utility\perk::_hasperk("specialty_mechanic") && scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(var_2)) {
      var_3 = var_3 * getdvarfloat("#x31c4f4ed03baa74f7", 0.5);
    }

    if(var_5 == "MOD_CRUSH" && isDefined(var_1) && isDefined(var_1.streakname) && var_1.streakname == "emp_drone") {
      var_3 = 0;
    }

    var_3 = _id_A008(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_14);
    var_3 = _id_748F(var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_21, var_14);

    if(var_3 == 0) {
      return;
    }
    if(!istrue(var_2._id_4D71)) {
      var_41 = _id_2E96(var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_0, 0, var_4, var_21, var_14);
      var_3 = var_41[0];
      var_42 = var_41[1];
      var_43 = var_41[2];
      var_44 = var_42 != 0 || var_43 != 0;
      var_9 = var_41[3];
    } else {
      var_42 = 0;
      var_43 = 0;
      var_44 = 0;
    }

    if(_id_88F7(var_1, var_2, var_3, var_5, var_6, var_13)) {
      return;
    }
    if(isDefined(var_2._id_5EAC)) {
      var_9 = var_2._id_5EAC;
      var_2._id_5EAC = undefined;
    }

    if(isPlayer(var_1) && (var_26 == "s4_smoke_usa_m18_mp" || var_26 == "s4_throwing_knife_mp")) {
      var_1 thread scripts\mp\gamelogic::_id_F13D(var_26, 1, "hits");
    }

    var_45 = var_8;

    if(isDefined(var_4) && var_4 &level._id_7CA3 && var_3 < self.health) {
      var_45 = var_2.origin - var_1.origin;
    }

    if(_id_8833(var_0)) {
      var_3 = 0;
    }

    if(isPlayer(var_1) && scripts\mp\utility\game::getgametype() == "br") {
      if(_id_1B71(var_1) || _id_7809(var_1)) {
        var_4 = var_4 | level._id_7C98;
      }

      if(_id_1B70(var_1) || _id_7808(var_1)) {
        var_4 = var_4 | level._id_7C99;
      }
    }

    if(isDefined(level._id_AB62)) {
      if(![[level._id_AB62]](var_5)) {
        return;
      }
    }

    if(getdvarint("#x3c3ed409900cf4af", 1) && isDefined(var_1) && isDefined(var_2) && var_1 != var_2 && isDefined(var_1.team) && isDefined(var_2.team) && var_1.team != var_2.team && !var_2 scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
      var_2 thread _id_06CA::_id_EBBF(var_1, var_6, var_5, var_0);
    }

    _id_BBC1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_45, var_9, var_10, var_11, var_12);
    var_2 _id_5B1C(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_45, var_9, var_10, var_11, var_12, var_44);
    _id_BA58(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_45, var_9, var_10, var_11, var_12, var_42, var_43, var_18, var_21, var_15);
  }
}

isfiredamage(var_0) {
  if(var_0 == "MOD_FIRE" || var_0 == "MOD_FIRE_BULLET" || var_0 == "MOD_BURNED" || var_0 == "MOD_BURNED_OVER_TIME") {
    return 1;
  } else {
    return 0;
  }
}

isburningdamage(var_0) {
  if(var_0 == "MOD_FIRE_BULLET" || var_0 == "MOD_FIRE" || var_0 == "MOD_BURNED_OVER_TIME") {
    return 1;
  } else {
    return 0;
  }
}

_id_6E46(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _func_0461(var_2);
  var_6 = _func_0462(var_0, var_1, var_5);

  if(var_5 == 0 || var_5 > 17 || var_6 > 1.1) {
    return var_3;
  }

  var_7 = var_5 - 1;

  if(var_5 - 6 > 0) {
    var_7--;
  }

  if(var_5 == 6 || var_5 == 7) {
    var_7 = 4;
  }

  if(var_5 == 12 || var_5 == 13) {
    var_7 = 5;
  }

  var_8 = _func_0462(var_0, var_1, var_7);

  if(var_8 > 1.1) {
    return floor(var_4 * var_8);
  } else {
    return var_3;
  }
}

_id_4EE1(var_0, var_1, var_2) {
  self notify("newDragonsBreathHitLoc");
  self endon("newDragonsBreathHitLoc");

  if(!isDefined(self._id_4EE0)) {
    self._id_4EE0 = _id_078C::_id_E29A();
  }

  self._id_4EE0._id_A456 = scripts\engine\utility::array_add(self._id_4EE0._id_A456, var_0);
  waittillframeend;
  var_3 = [];

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_4EE0)) {
    var_3 = self._id_4EE0._id_A456;
    self._id_4EE0._id_A456 = [];
  }

  if(scripts\mp\utility\player::isreallyalive(self)) {
    _id_078C::_id_D535(var_3, var_1, var_2);
  } else {
    _id_078C::_id_D536();
  }
}

_id_BBC1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = var_3;
  var_2._id_90CE = var_2 getcurrentweapon();
  var_2._id_10A09 = var_2 scripts\mp\utility\player::_id_8989();

  if(isai(self)) {
    self[[level._id_279D["on_damaged"]]](var_1, var_3, var_5, var_6, var_0, var_9);
  }

  if(isDefined(var_6.basename) && var_6.basename == "s4_ks_tw_ball_turret_gunner_mp") {
    var_0.streakinfo = var_1.streakinfo;
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo._id_79B5)) {
    var_0.streakinfo._id_79B5++;
  }

  _id_0A6B::_id_2D33(var_1, var_2, var_6.basename, var_5);

  if(var_5 == "MOD_FALLING") {
    var_2 thread _id_517E(var_3);
  }

  _id_9756(var_2, var_1, var_0, var_6, var_3, var_7, var_8, var_9, var_10, var_5);

  if(isDefined(var_0) && isDefined(var_0.owner) && var_0.owner.team != var_2.team) {
    var_2._id_8FB7 = 1;
  } else {
    var_2._id_8FB7 = isDefined(var_1) && var_1 != var_2;
  }

  if(var_2._id_8FB7) {
    var_14 = gettime();
    var_1._id_42F6[var_2.guid] = var_14;
    var_2._id_8FB5 = var_14;
  }

  var_2 thread _id_0806::_id_AB61(var_1, var_2, var_5);
  var_2 thread _id_07BC::_id_B688(var_0, var_1, var_3, var_5, var_6, var_9);

  if(isDefined(var_1) && var_3 != 0) {
    var_1 notify("victim_damaged", var_2, var_0, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(level._id_BBC1)) {
    var_2 thread[[level._id_BBC1]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }
}

_id_BA58(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17) {
  var_18 = var_3;
  var_19 = scripts\engine\utility::_id_8794(var_5);

  if(var_3 > 10 && isDefined(var_0) && !var_2 scripts\mp\utility\player::_id_8ACE() && isPlayer(var_2)) {
    var_2 thread _id_0814::_id_25AF(var_0.origin);

    if(isPlayer(var_0) && var_5 == "MOD_MELEE") {
      if(isalive(var_2) && !var_2 scripts\mp\utility\killstreak::_id_88DF() && scripts\mp\utility\game::getgametype() != "br") {
        var_2 thread _id_9DA3(var_1);
        var_2._id_79C4 = gettime();
      }

      var_0 thread _id_0814::_id_25B0(var_6, var_2);
      var_2 playrumbleonentity("defaultweapon_melee");
      var_0 playrumbleonentity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\killstreak::_id_8992(self)) {
      if(var_3 >= self.health) {
        var_3 = self.health - 1;
      } else {
        var_20 = getcompleteweaponname(var_6);
        self[[_id_09EF::_id_1215("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_20, var_7, var_8, var_9, var_10);
      }
    } else {
      var_20 = getcompleteweaponname(var_6);
      self[[_id_09EF::_id_1215("on_damaged_finished")]](var_0, var_1, var_3, var_4, var_5, var_20, var_7, var_8, var_9, var_10);
    }
  }

  _id_7430(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, var_13, var_14, var_16, var_17);

  if(var_19) {
    var_2 thread scripts\mp\battlechatter_mp::_id_10A3(var_1, var_6, var_3);
  }

  if(isagent(var_1) && isDefined(var_1) && var_1 scripts\cp_mp\utility\player_utility::_isalive() && var_1 != var_2) {
    var_2 thread scripts\mp\battlechatter_mp::_id_111F(var_1);
  }

  if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(var_2.health < 30) {
      var_2 thread scripts\mp\battlechatter_mp::_id_7BE2();
    }

    if(isDefined(var_1) && var_1 != var_2 && _func_010F(var_5)) {
      if(!isDefined(var_6) || var_6.basename != "s4_gas_usa_mk5cn_mp") {
        level thread scripts\mp\battlechatter_mp::_id_F759(var_2, "flavor_surprise", undefined, 0.5);
      }
    }
  }

  scripts\mp\gamelogic::_id_D58D(var_2, 1);

  if(isDefined(var_1) && var_1 != var_2) {
    level._id_FED4 = 0;
  }

  if(isPlayer(var_1) && isDefined(var_1.pers["participation"])) {
    var_1.pers["participation"]++;
  } else if(isPlayer(var_1)) {
    var_1.pers["participation"] = 1;
  }

  if(isDefined(level._id_3718) && isPlayer(var_0)) {
    var_23 = spawnStruct();
    var_23._id_103C2 = var_2;
    var_23._id_106B7 = var_7;
    var_23._id_FFD4 = var_8;
    var_23.objweapon = var_6;
    var_23._id_8CFF = !isalive(var_2);
    var_0._id_79B3[var_0._id_79B3.size] = var_23;
  }

  if(isDefined(level._id_9BDB) && isPlayer(var_2) && isDefined(var_0) && isPlayer(var_0) && var_19) {
    if(var_15 == var_2.maxhealth && var_2.health != self.maxhealth) {
      var_2._id_5456 = gettime();
    }
  }

  if(_id_159F(var_1, var_2, var_6, var_5, var_3)) {
    var_2 _id_DCF9();
    var_24 = "";

    switch (var_5) {
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        var_24 = "effort_bullet_pain";

        if(var_15 == var_2.maxhealth) {
          var_24 = "effort_bullet_painv";
        }

        break;
      case "MOD_BURNED_OVER_TIME":
      case "MOD_BURNED":
      case "MOD_FIRE_BULLET":
      case "MOD_FIRE":
        var_24 = "effort_bullet_pain";
        break;
      default:
        if(var_6.basename == "s4_me_fists_mp") {
          var_24 = "effort_punched";
        }

        break;
    }

    if(var_24 != "" && scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](var_2, var_24);
    }
  }

  if(isDefined(var_1) && var_3 > 0) {
    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_delayhealing")) {
      var_1 thread _id_0A6A::_id_9B89(var_2, var_5);
    }

    if(var_19 && (var_6 _meth_8624("ammomod_slow") || var_6 _meth_8624("ammo_frangible", 1)) && _id_0A8B::_id_891A(var_6, var_9, var_5, var_1) && !var_2 scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
      var_1 thread _id_0A6B::_id_1718(var_2);
    }

    if(isPlayer(var_2) && var_1 scripts\mp\utility\perk::_hasperk("specialty_shrapnel") && _id_8A31(var_6, var_5)) {
      var_2._id_9044 = gettime();
    }
  }

  if(isDefined(level._id_AB61)) {
    var_2 thread[[level._id_AB61]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_15, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  if(scripts\mp\utility\player::isreallyalive(var_2)) {
    switch (var_5) {
      case "MOD_EXPLOSIVE":
      case "MOD_GRENADE_SPLASH":
      case "MOD_IMPACT":
      case "MOD_GRENADE":
      case "MOD_PROJECTILE_SPLASH":
      case "MOD_PROJECTILE":
        var_2 scripts\mp\utility\stats::_id_7DAE("explosionsSurvived", 1);
        var_25 = scripts\mp\utility\weapon::_id_6A18(var_6.basename);

        if(var_6.basename == "s4_firebombing_run_mp") {
          break;
        }

        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_explosive_recon") && !var_2 scripts\mp\utility\perk::_hasperk("specialty_coolheaded") && (!isDefined(var_25) || var_25 != "tactical" || (var_6.basename == "s4_mine_ger_s44_mp" || var_6.basename == "at_mine_stun_mp")) && var_2 != var_1) {
          if(!var_2 scripts\mp\utility\perk::_hasperk("specialty_scout")) {
            var_1 _id_0A6B::_id_BF12(var_2);
          }

          var_1 _id_0A6B::_id_ACF7(var_2);
          level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "recon");
        }

        break;
    }
  } else if(isDefined(var_4) && var_4 &level._id_7CA1)
    var_1 scripts\mp\utility\stats::_id_7DAE("penetrationKills", 1);

  if(scripts\mp\utility\player::isreallyalive(var_2) && (var_6.basename == "s4_mine_ger_s44_mp" || var_6.basename == "at_mine_stun_mp")) {
    var_2 thread _id_0A06::_id_19CC(var_0, var_1);
  }
}

_id_9DA4(var_0, var_1) {
  var_2 = anglesToForward((0, var_0 getplayerangles()[1], 0));
  var_3 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  return scripts\engine\math::_id_178D(var_2, var_3, (0, 0, 1));
}

_id_8A31(var_0, var_1) {
  if(!isDefined(var_0) || isnullweapon(var_0)) {
    return 0;
  }

  if(!_func_010F(var_1)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8AFA(var_0)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_8876(var_0)) {
    return 0;
  }

  var_2 = scripts\mp\utility\weapon::_id_6A18(var_0.basename);

  if(isDefined(var_2)) {
    if(var_2 != "lethal") {
      return 0;
    }
  }

  return 1;
}

_id_9DA3(var_0) {
  self endon("death_or_disconnect");
  var_1 = getdvarfloat("#x33ab27fb4c0721152");
  var_2 = getdvarfloat("#x36abddfbdff7839ee");
  var_3 = self getviewkickscale();
  self setviewkickscale(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 3, 1.5));
  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_1 * 1.5, var_1);
  _id_09C8::_id_0CF9("melee_mp", "damage", var_4, 0, 0);
  var_5 = 0;

  if(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_6 = _id_9DA4(self, var_0);

    if(var_6 < 15) {
      var_5 = 10;
    } else if(var_6 > -15) {
      var_5 = -10;
    }
  }

  var_7 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), 1.15, 1.0);
  self setplayerangles(self getplayerangles() + (-14 * var_7, var_5, 0));
  thread _id_9D83(var_0);
  self earthquakeforplayer(0.35, 0.2, self.origin, 400);
  self _meth_827A("plr_rumble_4_mp", self.origin);
  self setclientomnvar("ui_hud_shake", 1);
  wait 0.05;
  self setviewkickscale(var_3);
  var_4 = scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_2 * 1.5, var_2);
  _id_09C8::_id_0CF9("melee_mp_after", "damage", var_4, 0, 0);
}

_id_9D83(var_0) {
  self notify("resetMeleeDOF");
  self endon("resetMeleeDOF");
  self endon("death_or_disconnect");
  var_1 = 1;
  var_2 = 2;
  var_3 = 350;
  var_4 = 1024;
  self _meth_830B(var_1, var_2, var_3, var_4, 10, 9);
  var_5 = getdvarfloat("#x33ab27fb4c0721152");
  wait(scripts\engine\utility::ter_op(var_0 scripts\mp\utility\perk::_hasperk("specialty_hardmelee"), var_5 * 3, var_5));

  while(var_4 > 350) {
    var_1 = clamp(var_1 - 100, 0, 10000);
    var_2 = clamp(var_2 - 100, 0, 10000);
    var_3 = clamp(var_3 - 100, 0, 10000);
    var_4 = clamp(var_4 - 100, 0, 10000);
    self _meth_830B(var_1, var_2, var_3, var_4, 10, 9);
    wait 0.05;
  }

  scripts\mp\utility\player::_id_D51E();
}

_id_A122(var_0) {
  scripts\engine\utility::_id_108A7(2.0, "death_or_disconnect");
  var_0 destroy();
}

_id_159F(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 == 0) {
    return 0;
  }

  if(_id_EBA7(var_0, var_1, var_2, var_3, var_4)) {
    return 0;
  }

  return 1;
}

_id_EBA7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    switch (var_2.basename) {
      default:
    }
  }

  return 0;
}

_id_10DA3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_3.basename;

  if(isDefined(var_7) && var_7 == "danger_circle_br") {
    return 1;
  }

  if(var_4 == "MOD_EXECUTION") {
    return 1;
  }

  return 0;
}

_id_2E96(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_0 notify("damage_begin", var_1);
  var_13 = 0;
  var_14 = 0;
  var_15 = 0;
  var_16 = 0.25;
  var_17 = 0.25;
  var_18 = var_0 scripts\mp\gametypes\br_public::_id_753A();
  var_19 = var_0 scripts\mp\gametypes\br_public::_id_7572();

  if(isPlayer(var_1)) {
    _id_1B6D(var_1);
    _id_77F5(var_1);
    _id_1B6C(var_1);
    _id_77F4(var_1);
  }

  if(scripts\engine\utility::_id_8794(var_3)) {
    var_20 = var_4.basename;
    var_21 = _id_0A8B::_id_8891(var_20, var_7, var_3, var_1);
    var_22 = _id_0A8B::_id_8AA6(var_20, var_7, var_3, var_1);

    if(isDefined(var_4) && scripts\mp\utility\weapon::_id_8799(var_20)) {
      if(_id_877C(var_1, var_0) && isPlayer(var_0)) {
        level thread scripts\mp\battlechatter_mp::_id_CB70(var_0, "plr_hit_back", undefined, 0.1);
      }
    }

    if(isDefined(var_10) && var_10 &level._id_7CA3) {
      if(var_20 != "none" && !scripts\mp\utility\weapon::_id_8A7D(var_20)) {
        var_2 = var_2 * 0.4;
      }
    }

    if(isPlayer(var_1) && var_1 scripts\mp\utility\perk::_hasperk("specialty_paint_pro") && !var_11) {
      var_0 thread _id_0A6B::_id_D63A(var_1);
    }

    var_23 = var_22 && var_0 scripts\mp\utility\perk::_hasperk("specialty_armorvest");
    var_24 = var_21 && var_19;
    var_25 = var_21 && istrue(var_0._id_756C);
    var_26 = istrue(var_1._id_8FB4) && "iw8_sn_crossbow" == scripts\mp\utility\weapon::getweaponrootname(var_4);
    var_27 = !var_21 && (var_1 scripts\mp\utility\perk::_hasperk("specialty_bulletdamage") || var_26);
    var_28 = _id_0A8B::_id_8866(var_4, var_3);

    if(var_24 && !istrue(var_0.inlaststand)) {
      var_29 = weaponclass(var_4);
      var_30 = 0;

      if(var_29 == "sniper" || var_29 == "dmr") {
        var_30 = 1;
      }

      var_31 = var_0 scripts\mp\gametypes\br_public::_id_4306(var_2, var_30, var_6);
      var_2 = var_2 * var_31;
    }

    if(var_27 && var_23) {
      _id_1B6F(var_1);
    } else if(var_27) {
      var_32 = _id_19EC(var_20, var_7, var_3, var_1, var_2, 100);
      var_13 = var_13 + (var_32 - var_2);
    } else if(issubstr(var_20, "s4_")) {
      var_33 = _id_0A8B::_id_FF64(var_20, var_3, var_1);
      var_34 = scripts\mp\tweakables::_id_6E14("player", "maxhealth");
      var_35 = 1;
      var_36 = 0;
      var_32 = _func_012C(var_4, var_2, var_7, var_33, var_12, var_34, var_35, var_36);
      var_13 = var_13 + (var_32 - var_2);
    } else if(var_23 && !istrue(var_0._id_F33B) && !var_28) {
      var_0._id_F33B = 1;
      var_32 = adjustbulletstokillwrapper(var_2, 100, level._id_1B72);
      var_13 = var_13 + (var_32 - var_2);
      _id_7807(var_1);
    } else if(var_25 && !var_28) {
      var_37 = _id_0A68::_id_69C0();
      var_38 = _id_0A68::_id_6B3A();
      var_39 = int(clamp(var_2 * var_37, 1, var_38));

      if(var_0.health > 1) {
        var_39 = int(min(var_0.health - 1, var_39));
      }

      var_40 = var_2 - var_39;
      var_13 = var_13 - var_40;
      var_0 notify("headgear_save");
      _id_7807(var_1);
    }

    if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
      var_2 = _id_9FFF(var_4, var_2, var_28);
    }

    if(isDefined(var_1) && isDefined(var_1._id_10324) && var_1._id_10324 == "loot_chopper") {
      var_2 = int(var_2 / 1.5);
    }

    if(istrue(var_0._id_ED30)) {
      var_2 = var_2 - int(var_2 * var_16);
    }

    if(istrue(var_0._id_ED31)) {
      var_2 = var_2 + int(var_2 * var_17);
    }
  } else if(_func_010F(var_3)) {
    if(isPlayer(var_1)) {
      if(var_1 != var_0 && var_1 scripts\mp\utility\perk::_hasperk("specialty_paint") && !var_11) {
        var_0 thread _id_0A6B::_id_D63A(var_1);
      }
    }

    var_2 = _id_A009(var_2, var_8, var_4);
    var_2 = _id_0A05::_id_381B(var_0, var_4, var_8, var_3, var_2);
    var_2 = _id_0A01::_id_1D42(var_0, var_8, var_4, var_3, var_2);
    var_2 = scripts\mp\weapons::launcherbackblast_modifieddamage(var_0, var_4, var_8, var_3, var_2);

    if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !_id_0A8B::_id_42D8(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_41 = _id_9FFD(var_2, var_1, var_0);
      var_13 = var_13 - (var_2 - var_41);
    }

    if(isPlayer(var_1) && var_1 == var_0 && scripts\mp\utility\weapon::_id_88F6(var_4)) {
      var_2 = var_2 * 0.5;
    }

    if(isDefined(level._id_91E0) && !scripts\mp\equipment::_id_91E3()) {
      var_2 = var_2 * level._id_7117;
    }
  } else if(var_3 == "MOD_FIRE") {
    if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
      if(isDefined(var_4.basename) && var_4.basename == "thermite_ap_mp" || var_4.basename == "thermite_bolt_mp") {
        var_2 = _id_9FFF(var_4, var_2, 0, 1);
      }
    }

    if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !_id_0A8B::_id_42D8(var_1, var_0, var_4, var_3, var_8, var_7)) {
      var_41 = _id_9FFD(var_2, var_1, var_0);
      var_13 = var_13 - (var_2 - var_41);
    }
  }

  var_42 = _id_10DA3(var_1, var_0, var_2, var_4, var_3, var_8, var_7);

  if(var_18 && !istrue(var_42) && !istrue(var_0.inlaststand) && var_7 != "shield") {
    var_43 = var_0 scripts\mp\gametypes\br_public::_id_42E2(var_2);
    var_44 = int(var_2 - var_43);
    var_15 = var_44;
    var_13 = var_13 - var_44;
    var_0._id_F33B = 1;

    if(isPlayer(var_1)) {
      _id_1B6F(var_1);

      if(_id_DBC2(self)) {
        var_1 scripts\mp\utility\stats::_id_7DAE("damage", var_44);
        var_1 _id_07BF::_id_7D94(1, var_44);

        if(isDefined(var_1.pers["friendlyDamageDone"]) && var_0.team == var_1.team) {
          var_1 scripts\mp\utility\stats::_id_7DAE("friendlyDamageDone", var_44);
        }
      } else if(isDefined(level._id_AA74))
        var_1[[level._id_AA74]](var_44);
    }
  }

  if(var_0 _id_07DE::_id_756F()) {
    var_45 = _id_07DE::_id_765F(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_14 = var_45[0] > 0;
    var_2 = var_45[1];
    var_13 = var_45[2];
  }

  if(_id_07EA::_id_7580(var_0) && !scripts\engine\utility::is_equal(var_7, "shield")) {
    var_45 = _id_07EA::_id_9451(var_0, var_1, var_2, var_13, var_3, var_4.basename, var_5, var_6, var_7, var_8, var_9);
    var_15 = var_45[0] > 0;
    var_2 = var_45[1];
    var_13 = var_45[2];
  }

  if(isPlayer(var_1)) {
    var_46 = var_0 scripts\mp\gametypes\br_public::_id_753A();
    var_47 = var_0 scripts\mp\gametypes\br_public::_id_7572();

    if(var_18 && !var_46) {
      _id_1B6E(var_1);
    }

    if(var_19 && !var_47) {
      _id_7806(var_1);
    }
  }

  if(_id_0A8B::_id_756D(var_0)) {
    var_2 = var_0 _id_0A8B::_id_6A95(var_2);
  }

  if(istrue(var_0.inlaststand) && getdvarfloat("#x39fcadfd30a990181", 0) > 0) {
    var_2 = int(_func_0037(var_2 / getdvarfloat("#x39fcadfd30a990181", 0)));
  }

  if(var_2 <= 1) {
    var_2 = int(_func_0037(clamp(var_2, 0, 1)));
  } else {
    var_2 = int(var_2 + var_13);
  }

  return [var_2, var_15, var_14, var_7];
}

_id_9FFD(var_0, var_1, var_2) {
  var_3 = level._id_2544;
  var_4 = level._id_2543;
  var_5 = int(var_0 * var_3);

  if(var_1 != var_2) {
    var_5 = clamp(var_5, 0, var_4);
  }

  return var_5;
}

_id_9FFF(var_0, var_1, var_2, var_3) {
  var_4 = weaponclass(var_0);

  switch (var_4) {
    case "pistol":
    case "smg":
      var_1 = min(15, var_1);
      break;
    case "mg":
    case "rifle":
      var_1 = min(20, var_1);
      break;
    case "spread":
      var_1 = min(25, var_1);
      break;
    case "sniper":
      break;
    default:
      var_1 = min(15, var_1);
      break;
  }

  if(istrue(var_2)) {
    var_1 = var_1 * level._id_1B5C;
  }

  if(istrue(var_3)) {
    if(var_0.basename == "thermite_ap_mp") {
      var_1 = var_1 * 6;
    } else if(var_0.basename == "thermite_bolt_mp") {
      var_1 = var_1 * 3;
    }
  }

  return var_1;
}

_id_A009(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return var_0;
  }

  if(!isnullweapon(var_2)) {
    return var_0;
  }

  if(!isDefined(var_1._id_00EC) || var_1._id_00EC != "scriptable") {
    return var_0;
  }

  var_3 = var_1.classname;

  if(isDefined(var_3) && _func_010D(var_3, "scriptable_")) {
    var_3 = _func_00D6(var_3, 11, var_3.size);
    var_4 = ["uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel"];

    foreach(var_6 in var_4) {
      if(_func_010D(var_3, var_6)) {
        if(scripts\mp\utility\game::isanymlgmatch()) {
          return 0;
        } else {
          return int(min(var_0, 60));
        }
      }
    }
  }

  return var_0;
}

_id_88F7(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0) && isPlayer(var_0) && (!isalive(var_0) || scripts\mp\utility\player::_id_88C8(var_0))) {
    if(var_5 && weaponclass(var_4) == "spread") {
      return 1;
    } else if(var_2 >= var_1.health) {
      if(var_3 == "MOD_MELEE") {
        return 1;
      } else if(var_5) {
        return 1;
      }
    }
  }

  return 0;
}

isbuckslugweapon(var_0, var_1) {
  return isDefined(var_1) && weaponclass(var_1) == "rifle" && isDefined(var_1._id_04B7) && issubstr(var_1._id_04B7, "buckslug");
}

_id_8A5B(var_0) {
  return isDefined(var_0) && weaponclass(var_0) == "spread";
}

_id_87DC(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(var_1 == "iw8_sn_crossbow") {
    return 1;
  }

  return 0;
}

_id_DB1A(var_0) {
  if(var_0 _meth_8624("boltexplo_crossbow")) {
    return 1;
  }

  return 0;
}

_id_E44B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5) && var_5 == "shield") {
    return var_3;
  }

  if(!_id_8A5B(var_2) && !isbuckslugweapon(var_1, var_2)) {
    return var_3;
  }

  if(isDefined(var_1) && isDefined(var_0)) {
    if(var_4 &level._id_7CA7) {
      var_6 = "lHandWeap";
    } else {
      var_6 = "rHandWeap";
    }

    if(!isDefined(var_1._id_AF82)) {
      var_1._id_AF82 = [];
    }

    var_7 = "" + var_0 getentitynumber();
    var_8 = gettime();

    foreach(var_14, var_10 in var_1._id_AF82) {
      foreach(var_13, var_12 in var_10) {
        if((var_8 - var_12._id_F1E8) / 1000 > 0.1) {
          var_1._id_AF82[var_14] = ::scripts\engine\utility::_id_1BC6(var_1._id_AF82[var_14], var_13);

          if(var_1._id_AF82[var_14].size == 0) {
            var_1._id_AF82 = scripts\engine\utility::_id_1BC6(var_1._id_AF82, var_14);
          }
        }
      }
    }

    if(!isDefined(var_1._id_AF82[var_6])) {
      var_1._id_AF82[var_6] = [];
    }

    if(!isDefined(var_1._id_AF82[var_6][var_7])) {
      var_1._id_AF82[var_6][var_7] = spawnStruct();
      var_1._id_AF82[var_6][var_7]._id_F1E8 = var_8;
      var_1._id_AF82[var_6][var_7]._id_AF81 = [];
    }

    var_15 = _id_6D74(var_1, var_2);
    var_16 = var_1._id_AF82[var_6][var_7]._id_AF81;

    if(var_1._id_AF82[var_6][var_7]._id_AF81.size >= var_15) {
      if(getdvarint("#x393cca1ba77e42493", 1)) {
        foreach(var_19, var_18 in var_1._id_AF82[var_6][var_7]._id_AF81) {
          if(var_3 > var_18) {
            var_1._id_AF82[var_6][var_7]._id_AF81[var_19] = var_3;
            var_1._id_AF82[var_6][var_7]._id_AF81 = scripts\engine\utility::_id_1BD6(var_1._id_AF82[var_6][var_7]._id_AF81, ::_id_862D);
            return var_3 - var_18;
          }
        }
      }

      return 0;
    } else {
      var_1._id_AF82[var_6][var_7]._id_AF81 = scripts\engine\utility::array_add(var_1._id_AF82[var_6][var_7]._id_AF81, var_3);
      var_1._id_AF82[var_6][var_7]._id_AF81 = scripts\engine\utility::_id_1BD6(var_1._id_AF82[var_6][var_7]._id_AF81, ::_id_862D);
    }
  }

  return var_3;
}

_id_862D(var_0, var_1) {
  return var_0 < var_1;
}

_id_6D74(var_0, var_1) {
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(var_2 == "s4_pi_mike1911" || var_2 == "s4_sh_lindia98") {
    var_3 = var_0 playerads() > 0.5;

    if(var_3) {
      return 4;
      return;
    }

    if(var_1 _meth_8624("gunperk_akimbo")) {
      return 3;
    }

    if(var_1 _meth_8624("bar_sh_fluted_lindia98")) {
      return 4;
    }

    return 3;
    return;
  } else if(var_2 == "s4_sh_becho")
    return 1;
  else if(var_2 == "s4_sh_mike97") {
    var_3 = var_0 playerads() > 0.5;

    if(var_3) {
      return 3;
      return;
    }

    if(var_1 _meth_8624("bar_sh_fluted_mike97")) {
      return 3;
    }

    return 2;
    return;
  } else if(var_2 == "s4_sh_bromeo5") {
    if(var_1 _meth_8624("bar_xs_sawed_bromeo5")) {
      return 1;
    } else {
      return 2;
    }
  } else if(var_2 == "s4_pi_wecho" && var_1 _meth_8624("bird_wecho")) {
    var_3 = var_0 playerads() > 0.5;

    if(var_3) {
      return 4;
      return;
    }

    if(var_1 _meth_8624("bar_sh_fluted_wecho")) {
      return 4;
    }

    return 3;
    return;
  } else if(_func_012A(var_1))
    return 16;
  else {
    return 4;
  }
}

_id_1B71(var_0) {
  return isDefined(var_0._id_79A0) && gettime() == var_0._id_79A0;
}

_id_1B6F(var_0) {
  var_0._id_79A0 = gettime();
}

_id_1B6D(var_0) {
  var_0._id_79A0 = undefined;
}

_id_1B70(var_0) {
  return isDefined(var_0._id_2BFB) && gettime() == var_0._id_2BFB;
}

_id_1B6E(var_0) {
  var_0._id_2BFB = gettime();
}

_id_1B6C(var_0) {
  var_0._id_2BFB = undefined;
}

_id_7809(var_0) {
  return isDefined(var_0._id_79A6) && gettime() == var_0._id_79A6;
}

_id_7807(var_0) {
  var_0._id_79A6 = gettime();
}

_id_77F5(var_0) {
  var_0._id_79A6 = undefined;
}

_id_7808(var_0) {
  return isDefined(var_0._id_2BFC) && gettime() == var_0._id_2BFC;
}

_id_7806(var_0) {
  var_0._id_2BFC = gettime();
}

_id_77F4(var_0) {
  var_0._id_2BFC = undefined;
}

_id_19EC(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = scripts\mp\tweakables::_id_6E14("player", "maxhealth");
  var_6 = _id_6933(var_5, var_4);

  if(var_6 == 2) {
    return 0.9 * var_5;
  }

  var_7 = -1;

  if(var_6 >= 5) {
    var_7 = -2;
  } else if(var_6 >= 7) {
    var_7 = -3;
  }

  return adjustbulletstokillwrapper(var_4, var_5, var_7);
}

adjustbulletstokillwrapper(var_0, var_1, var_2) {
  return _func_012B(var_0, var_1, var_2);
}

_id_6933(var_0, var_1) {
  return int(_func_0037(var_0 / var_1));
}

_id_877C(var_0, var_1) {
  var_2 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_3 = anglesToForward((0, var_1.angles[1], 0));
  return vectordot(var_2, var_3) > 0.4;
}

_id_8DCD(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 scripts\mp\utility\game::_id_8A48()) {
    var_5 = int(max(var_1.health / 4, 1));

    if(var_2 >= var_5 && scripts\mp\utility\weapon::_id_88F6(var_3.basename) && !scripts\mp\utility\weapon::_id_10D66(var_3) && var_4 != "MOD_MELEE") {
      var_2 = var_5;
    }
  }

  return var_2;
}

_id_5FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = 0;

  if(isDefined(var_6)) {
    switch (var_6.basename) {
      case "none":
        if(isDefined(var_0) && scripts\mp\utility\entity::_id_8811(var_0)) {
          var_13 = 1;
        }

        break;
      case "apache_turret_mp":
      case "trophy_mp":
        var_13 = 1;
        break;
    }
  }

  return var_13;
}

_id_744C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_3 = scripts\mp\weapons::launcherbackblast_modifieddamage(var_2, var_6, var_0, var_5, var_3);

  if(var_3 == 0) {
    return 0;
  }

  if(isDefined(var_6) && scripts\engine\utility::_id_8794(var_5) && (scripts\mp\utility\weapon::_id_879A(var_6.basename) || scripts\mp\utility\weapon::_id_879C(var_6.basename))) {
    level thread scripts\mp\battlechatter_mp::_id_F759(var_2, "check_fire_ally", undefined, 0.25);
  }

  if(isDefined(var_0) && !isPlayer(var_0)) {
    if(!isDefined(var_1)) {
      if(isDefined(var_0.owner)) {
        var_1 = var_0.owner;
      }
    } else if(!isPlayer(var_1)) {
      if(isDefined(var_0.owner)) {
        var_1 = var_0.owner;
      } else if(isDefined(var_1.owner)) {
        var_1 = var_1.owner;
      }
    }
  }

  if(level._id_74C4) {
    if(isDefined(var_4) && var_4 &level._id_7CA3 && scripts\engine\utility::_id_8794(var_5)) {
      var_3 = int(var_3 * 0.2);
    }
  }

  if(level._id_5FA5 != 0) {
    if(level._id_9C50 == -1) {
      var_14 = 0;
    } else {
      var_14 = istrue(var_2._id_8857) || istrue(var_2._id_87F7) || istrue(var_2._id_8986);
    }

    var_15 = _id_886E(var_1);

    if(var_14 || var_15) {
      var_3 = int(var_3 * 0.5);

      if(var_3 < 1) {
        var_3 = 1;
      }

      var_1._id_8FB7 = 0;
      _id_42E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
      return 0;
    }
  }

  if(level._id_5FA5 == 0 || !isPlayer(var_1) && level._id_5FA5 != 1 || var_6.basename == "bomb_site_mp") {
    return 0;
  } else if(level._id_5FA5 == 1) {
    if(var_3 < 1) {
      var_3 = 1;
    }

    var_2._id_8FB7 = 0;
    var_2 _id_5B1C(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1 _id_7430(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0, var_13);
    return 0;
  } else if(level._id_5FA5 == 2) {
    var_3 = int(var_3 * 0.5);

    if(var_3 < 1) {
      var_3 = 1;
    }

    var_1._id_8FB7 = 0;

    if(!_id_5FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
      _id_42E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }

    return 0;
  } else if(level._id_5FA5 == 3) {
    var_3 = int(var_3 * 0.5);

    if(var_3 < 1) {
      var_3 = 1;
    }

    var_2._id_8FB7 = 0;
    var_1._id_8FB7 = 0;
    var_2 _id_5B1C(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(!_id_5FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
      _id_42E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }

    var_1 _id_7430(var_0, var_1, var_2, var_3, var_5, var_6, var_9, var_4, 0, 0, var_13);
    return 0;
  } else if(level._id_5FA5 == 4) {
    var_16 = var_1.pers["teamkills"] >= level._id_9C50;

    if(!var_16 && isDefined(level.maxallowedteamdamagebeforepunish) && level.maxallowedteamdamagebeforepunish > 0) {
      var_16 = isDefined(var_1.pers["teamdamage"]) && var_1.pers["teamdamage"] >= level.maxallowedteamdamagebeforepunish;
    }

    if(var_16) {
      if(!_id_5FAA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)) {
        var_3 = int(var_3 * 0.5);

        if(var_3 < 1) {
          var_3 = 1;
        }

        var_1._id_8FB7 = 0;
        _id_42E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
      }

      return 0;
    }
  }

  return var_3;
}

_id_886E(var_0) {
  if(level._id_9C50 == -1) {
    return 0;
  }

  if(level._id_7EB0) {
    return 1;
  }

  if(var_0.pers["teamkills"] > 1 && scripts\mp\utility\game::_id_6DE6() < level._id_7116 * 1000 + 8000 + var_0.pers["teamkills"] * 1000) {
    return 1;
  }

  return 0;
}

_id_42E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_1._id_5FA4 = 1;
    var_1 _id_5B1C(var_0, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_1._id_5FA4 = undefined;
  }
}

_id_9FAF(var_0) {
  return var_0 == "head" || var_0 == "helmet" || var_0 == "neck";
}

_id_9FB0(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::isanymlgmatch() && isDefined(var_0) && isPlayer(var_0) && !isnullweapon(var_3) && scripts\mp\utility\weapon::_id_89C7(var_3) && scripts\engine\utility::_id_8794(var_2) && _id_9FAF(var_4)) {
    switch (var_3.classname) {
      case "pistol":
      case "mg":
      case "smg":
      case "rifle":
        var_1 = int(clamp(var_1, 0, var_3._id_0299 * 1.3));
        break;
    }
  }

  return var_1;
}

_id_A008(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_3 = _id_9FB0(var_1, var_3, var_5, var_6, var_9);

  if(var_5 == "MOD_EXPLOSIVE_BULLET" && var_3 != 1) {
    var_3 = var_3 * getdvarfloat("#x359267b7c2defc390");
    var_3 = int(var_3);
  }

  if(var_5 == "MOD_IMPACT" && var_3 != 1) {
    if(istrue(var_6._id_0245) && scripts\mp\weapons::_id_876B(var_6._id_04B7)) {
      var_12 = var_0 _meth_8745();
      var_13 = length(var_12);

      if(var_13 < 400) {
        var_3 = 10;
      }
    }
  }

  if(isDefined(level._id_A00B)) {
    var_3 = int([[level._id_A00B]](var_0, var_2, var_1, var_3, var_5, var_6, var_7, var_8, var_9, var_4, var_11));
  }

  if(!isDefined(var_2._id_4D71)) {
    var_3 = int(var_3 * var_2 _id_09BF::_id_69C1(var_0, var_1, var_2, var_3, var_5, var_6, var_9));
  }

  if(_id_0A8B::_id_8891(var_6.basename, var_9, var_5, var_1)) {
    var_5 = "MOD_HEAD_SHOT";
  }

  if(scripts\mp\tweakables::_id_6E14("game", "onlyheadshots")) {
    if(var_5 == "MOD_HEAD_SHOT") {
      var_3 = 150;
    }
  }

  if(getdvarint("#x3f988f5db9b441997", 0)) {
    if(isDefined(var_6) && scripts\mp\utility\weapon::_id_8929(var_6) && isDefined(var_5)) {
      var_3 = _id_7468(var_6, var_5, var_3);
    }
  }

  return var_3;
}

_id_748F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_8 != "shield") {
    return var_3;
  }

  var_12 = _id_09BF::_id_ADCA(var_2, var_1, var_3, var_5, var_4, var_0, var_6, var_7, undefined, undefined, undefined, var_9);
  var_13 = istrue(var_1._id_7D32);

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;

    if(var_2 == var_1) {
      return 0;
    }
  }

  if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
    if(isPlayer(var_2)) {
      var_2._id_8F8F = var_1;
      var_2._id_8F90 = gettime();
    }

    var_1 notify("shield_blocked");

    if(scripts\mp\utility\weapon::_id_8834(var_5.basename)) {
      var_14 = 25;
    } else {
      var_15 = _id_2E96(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_0, 0, var_9, undefined, var_11);
      var_14 = var_15[0];
      var_16 = var_15[1];
      var_17 = var_15[2];
      var_8 = var_15[3];
    }

    var_1 scripts\mp\utility\stats::_id_7DAE("riotShieldDamageAbsorbed", var_14);

    if(isPlayer(var_2) && isDefined(var_1._id_C0C5)) {
      var_18 = var_2 getentitynumber();

      if(!isDefined(var_1._id_C0C5[var_18])) {
        var_1._id_C0C5[var_18] = var_14;
      } else {
        var_1._id_C0C5[var_18] = var_1._id_C0C5[var_18] + var_14;
      }
    }

    if(var_13) {
      return 0;
    }

    if(!scripts\mp\utility\weapon::_id_8834(var_5.basename) || scripts\engine\utility::cointoss()) {
      var_1._id_D9D7++;
    }

    var_19 = istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_1, var_2));

    if(var_1._id_D9D7 >= level._id_C88E && var_19) {
      var_20 = 1.0;

      if(self._id_C0FB > 4) {
        var_20 = 1.0 / self._id_C0FB;
      }

      var_21 = scripts\mp\rank::getscoreinfovalue("shield_damage");
      var_1 thread _id_0A9F::_id_7003("shield_damage", var_1._id_0133, var_21 * var_20);
      var_1 thread _id_6FE0();
      var_1._id_D9D7 = 0;
    }
  }

  var_22 = isDefined(var_0) && isDefined(var_0._id_EA8F) && var_0._id_EA8F == var_1;

  if(var_9 &level._id_7CA4) {
    var_1._id_5EAC = "none";

    if(!(var_9 &level._id_7CA5)) {
      var_1 scripts\mp\utility\stats::_id_7DAE("riotShieldDamageAbsorbed", var_3);
      var_3 = 0;
    }
  } else if(var_9 &level._id_7CA6) {
    var_1._id_5EAC = "none";

    if(var_1 _id_09BF::_id_8A6B(var_12)) {
      var_3 = var_1.maxhealth;
    }
  } else
    return 0;

  if(var_4 == "MOD_MELEE" && _id_080B::_id_8A09(var_5.basename)) {
    var_1 _meth_83FD(0.0);
  }

  return var_3;
}

_id_5A4B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!var_3) {
    return "!iDamage";
  }

  if(isDefined(level._id_7AAE)) {
    return "level.hostMigrationTimer";
  }

  var_1 = _id_0A8B::_id_0DB6(var_1);

  if(!isDefined(var_1) && var_4 != "MOD_FALLING") {
    return "invalid attacker";
  }

  var_2 = _id_0A8B::_id_0DBA(var_2);

  if(!isDefined(var_2)) {
    return "invalidVictim";
  }

  if(game["state"] == "postgame") {
    return "game[ state ] == postgame";
  }

  if(isDefined(var_2.sessionteam) && var_2.sessionteam == "spectator") {
    return "victim.sessionteam == spectator";
  }

  if(scripts\mp\tweakables::_id_6E14("game", "onlyheadshots")) {
    if(var_6 != "head") {
      if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
        return "getTweakableValue( game, onlyheadshots )";
      }
    }
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_1025D(var_0, var_2, var_4, var_5)) {
    return "playerJustExitedVehicle";
  }

  var_7 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1._id_72B3) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(!level.teambased && var_7 && isDefined(var_1.owner) && var_1.owner == var_2) {
    if(var_4 == "MOD_CRUSH") {
      var_2 _id_0A8B::_id_0D8A();
    }

    return "ffa suicide";
  }

  if(scripts\mp\utility\game::_id_875D()) {
    if(isDefined(var_1) && isDefined(var_2.pers) && isDefined(var_1.pers) && !scripts\engine\utility::is_equal(var_2.pers["team"], var_1.pers["team"])) {
      var_8 = scripts\mp\gametypes\arena_evo_tourney_util::_id_67C1(var_2.pers["team"]);

      if(!scripts\engine\utility::is_equal(var_8, var_1.pers["team"])) {
        return "arena_evo enemy not matched with victim";
      }
    }
  }
}

_id_9756(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_108F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1.owner) && (!isDefined(var_1._id_CC51) || !var_1._id_CC51)) {
    _id_108F(var_0, var_1.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  } else if(isDefined(var_1) && !isPlayer(var_1) && isDefined(var_1._id_CFEE) && isDefined(var_1._id_CC51) && var_1._id_CC51) {
    _id_108F(var_0, var_1._id_CFEE, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isDefined(var_2) && isDefined(var_2.owner)) {
    var_10 = var_2.owner.team != var_0.team || level._id_5FA5 == 1;

    if(var_10 && !isDefined(self._id_1DD4[var_2.owner.guid])) {
      _id_108F(var_0, var_2.owner, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  if(isDefined(var_1)) {
    level._id_9007 = var_1;
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3)) {
    var_1 thread scripts\mp\weapons::_id_3519(var_3, var_0);
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_3) && var_1 != var_0) {
    var_1 thread _id_07CE::_id_42F5(self, var_4);
    var_0._id_1DDC = var_1.origin;
  } else
    var_0._id_1DDC = undefined;

  if(!istrue(level.ignorescoring)) {
    var_0 thread scripts\common\utility::_id_F73A(level._id_9BB5, var_1, var_4, var_9, var_3);
  }

  if(isDefined(var_1) && isDefined(var_3) && !var_1 scripts\mp\utility\weapon::_id_897E(var_3)) {
    var_11 = spawnStruct();
    var_11._id_04FE = scripts\mp\utility\weapon::getweaponrootname(var_3);
    var_11.statname = "damage";
    var_11.incvalue = var_4;
    var_11._id_04CC = _func_02F7(var_3);
    var_1 _id_06E2::_id_4C2A("callback_update_weapon_stats", var_11);
  }
}

_id_9757(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2)) {
    _id_1090(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2.owner) && (!isDefined(var_2._id_CC51) || !var_2._id_CC51)) {
    var_2 = var_2.owner;
    _id_1090(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  } else if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2._id_CFEE) && isDefined(var_2._id_CC51) && var_2._id_CC51) {
    var_2 = var_2._id_CFEE;
    _id_1090(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_2)) {
    level._id_9007 = var_2;
  }

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_10) && var_2 != var_0) {
    var_0._id_1DDC = var_2.origin;
  } else {
    var_0._id_1DDC = undefined;
  }
}

_id_979A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((issubstr(var_4, "MOD_EXPLOSIVE") || issubstr(var_4, "MOD_PROJECTILE")) && isDefined(var_0) && isDefined(var_1)) {
    var_6 = getcompleteweaponname(var_5);
    var_2._id_57E9 = [];
    var_2._id_57E9["damageTime"] = gettime();
    var_2._id_57E9["damageId"] = var_0 getentitynumber();
    var_2._id_57E9["returnToSender"] = 0;
    var_2._id_57E9["counterKill"] = 0;
    var_2._id_57E9["chainKill"] = 0;
    var_2._id_57E9["cookedKill"] = 0;
    var_2._id_57E9["throwbackKill"] = 0;
    var_2._id_57E9["suicideGrenadeKill"] = 0;
    var_2._id_57E9["weapon"] = var_6;
    var_7 = issubstr(var_5.basename, "frag_");

    if(var_1 != var_2) {
      if((issubstr(var_5.basename, "c4_") || issubstr(var_5.basename, "proximity_explosive_") || issubstr(var_5.basename, "claymore_")) && isDefined(var_0.owner)) {
        var_2._id_57E9["returnToSender"] = var_0.owner == var_2;
        var_2._id_57E9["counterKill"] = isDefined(var_0._id_10A0C);
        var_2._id_57E9["chainKill"] = isDefined(var_0._id_10A0B);
        var_2._id_57E9["bulletPenetrationKill"] = isDefined(var_0._id_10A0F);
        var_2._id_57E9["cookedKill"] = 0;
      }

      if(isDefined(var_1._id_8FDE) && var_1._id_8FDE >= gettime() - 50 && var_7) {
        var_2._id_57E9["suicideGrenadeKill"] = 1;
      }
    }

    if(var_7) {
      var_2._id_57E9["cookedKill"] = isDefined(var_0._id_87C1);
      var_2._id_57E9["throwbackKill"] = isDefined(var_0._id_F170);
    }

    var_2._id_57E9["stickKill"] = isDefined(var_0._id_8A69) && var_0._id_8A69 == "enemy";
    var_2._id_57E9["stickFriendlyKill"] = isDefined(var_0._id_8A69) && var_0._id_8A69 == "friendly";

    if(isPlayer(var_1) && var_1 != self && scripts\mp\utility\game::getgametype() != "aliens") {
      _id_FC8F(var_0, var_1, var_6);
    }
  }
}

_id_7430(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = isDefined(var_1) && isDefined(var_1.classname) && !isDefined(var_1._id_72B3) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(var_12 && isDefined(var_1._id_72B3)) {
    var_13 = var_1._id_72B3;
  } else if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_13 = var_1.owner;
  } else {
    var_13 = var_1;
  }

  var_14 = "standard";

  if(isDefined(var_13) && var_13 != var_2 && var_3 + var_8 + var_9 > 0 && (!isDefined(var_6) || var_6 != "shield")) {
    var_15 = !var_2 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var_2) && var_3 >= var_2.health;

    if(var_2 scripts\mp\utility\perk::_hasperk("specialty_pistoldeath") && isDefined(var_2.inlaststand) && var_2.inlaststand == 1 && !var_2._id_75B0) {
      var_2._id_75B0 = 1;
      var_14 = "hitlaststand";
    } else if(istrue(var_2._id_88DF))
      var_14 = "hitjuggernaut";
    else if(var_2 _id_07DE::_id_756F() || var_2 _id_07DE::_id_7570()) {
      var_14 = "hitarmorheavy";
    } else if(var_7 &level._id_7CA8) {
      var_14 = "stun";
    } else if(_id_0A8B::_id_8A8B(var_5, var_4) && var_2 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance")) {
      var_14 = "hittacresist";
    } else if(var_2 scripts\mp\utility\perk::_hasperk("specialty_blastshield") && !_id_0A8B::_id_42D8(var_1, var_2, var_5, var_4, var_0, var_6)) {
      var_14 = "hitblastshield";
    } else if(_id_0A8B::_id_756D(var_2)) {
      var_14 = "hitarmorlight";
    } else if(_id_1B70(var_1)) {
      var_14 = "hitarmorlightbreak";

      if(isPlayer(var_13)) {
        level thread scripts\mp\battlechatter_mp::_id_F759(var_13, "armor_destroy");
      }

      level thread scripts\mp\battlechatter_mp::_id_F759(var_2, "armor_broken");
    } else if(_id_7808(var_1))
      var_14 = "hithelmetlightbreak";
    else if(_id_1B71(var_1)) {
      var_14 = "hitarmorlight";
    } else if(_id_7809(var_1)) {
      var_14 = "hithelmetlight";
    } else if(var_8 > 0) {
      var_14 = "hitarmorlight";
    } else if(istrue(var_2._id_11B4)) {
      var_14 = "hitadrenaline";
    } else if(var_2 scripts\mp\utility\game::_id_8A48() && var_10 && !scripts\mp\utility\weapon::_id_10D66(var_5)) {
      var_14 = "hitspawnprotect";
    } else if(var_2 scripts\mp\utility\perk::_hasperk("specialty_mechanic") && scripts\cp_mp\vehicles\vehicle_occupancy::_id_101E8(var_2)) {
      var_14 = "hitmechanic";
    }

    var_16 = scripts\engine\utility::_id_8794(var_4);
    var_17 = scripts\engine\utility::ter_op(var_16 && scripts\mp\utility\weapon::_id_89C7(var_5), "standardspread", "standard");
    var_18 = 0;

    if(var_14 == "hitarmorlightbreak") {
      var_18 = 1;

      if(var_17 == "standardspread") {
        var_17 = "standardspreadarmor";
      } else {
        var_17 = "standardarmor";
      }
    }

    var_19 = !_id_8A5B(var_5) && _id_0A8B::_id_8891(var_5.basename, var_6, var_4, var_1);
    var_20 = 1;
    var_21 = 0;

    switch (var_4) {
      case "MOD_EXECUTION":
      case "MOD_PISTOL_BULLET":
      case "MOD_RIFLE_BULLET":
        var_21 = 1;
        break;
      default:
        var_21 = 0;
        break;
    }

    var_22 = "" + var_2 getentitynumber();
    var_23 = 0;

    if(!var_18 && _id_8A5B(var_5) && isDefined(var_13._id_AF82)) {
      foreach(var_25 in var_13._id_AF82) {
        if(isDefined(var_25[var_22]) && var_25[var_22]._id_AF81.size > 1 && var_4 != "MOD_FIRE") {
          var_23 = 1;
        }
      }
    }

    if(!var_21 && var_23) {
      if(var_15) {
        var_21 = 1;
      } else {
        var_20 = 0;
      }
    }

    if(var_20) {
      var_13 thread _id_07C4::_id_FC47(var_14, var_15, var_19, var_17, var_21, undefined, var_11);
    }
  }
}

_id_91E5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_09BF::_id_ADCA(var_1, var_2, var_3, var_6, var_5, var_0, undefined, undefined, undefined, undefined, undefined, var_4);

  if(isDefined(var_0) && isDefined(var_0._id_42F2)) {
    var_1 = var_0._id_42F2;
  }

  if(var_2 _id_09BF::_id_8A6B(var_7)) {
    if(var_2 scripts\mp\utility\killstreak::_id_88DF()) {
      var_3 = min(300, var_3);
    } else {
      var_3 = var_2.maxhealth * 1000;
    }
  }

  if(getdvarint("#x3f988f5db9b441997", 0) == 1 && isDefined(var_6) && isDefined(var_6.basename) && var_6.basename == "s4_throwing_knife_mp") {
    var_3 = var_2.maxhealth * 1000;
  }

  if(isDefined(var_5) && var_5 != "MOD_IMPACT") {
    if(var_2 != var_1 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade" && var_2._id_904F + 3500 > gettime() && isDefined(var_2._id_904C) && distance(var_0.origin, var_2._id_904C.origin) < 500) {
      var_3 = 0;
    }
  }

  _id_979A(var_0, var_1, var_2, var_3, var_5, var_6);
  return var_3;
}

_id_B6F6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _id_09BF::_id_ADCA(var_1, var_2, var_3, var_6, var_5, var_0, undefined, var_7, undefined, undefined, undefined, var_4);
  var_12._id_79A8 = var_8;
  var_12._id_0354 = var_9;
  var_12._id_43D5 = var_10;
  var_12._id_8852 = var_11;

  if(var_5 == "MOD_EXECUTION") {
    var_12._id_5705 = _id_0790::_id_56FC(var_1);
  }

  var_12._id_4D02 = 0;
  var_12._id_4CAC = 1;
  var_12.killcamentity = undefined;
  var_12._id_8D63 = -1;
  var_12._id_8D64 = 0;
  var_12._id_7E94 = undefined;
  var_12._id_8D67 = undefined;
  var_12._id_886D = undefined;
  var_12._id_034C = undefined;
  var_12._id_936C = undefined;
  var_12._id_1DD7 = undefined;
  var_12._id_88F6 = undefined;
  var_12._id_10D86 = undefined;
  var_12._id_8954 = 0;
  var_12._id_43FF = getdvarfloat("#x38c327cfe5906f2a", 1.75);
  var_12._id_43FE = int(var_12._id_43FF * 1000);
  var_12._id_441F = gettime();
  var_12._id_2C4B = undefined;
  return var_12;
}

_id_B6FB(var_0) {
  if(isDefined(var_0.objweapon)) {}

  if(scripts\mp\utility\game::_id_60C4(scripts\mp\utility\game::getgametype())) {
    if(var_0._id_103C2 != var_0.attacker && var_0._id_9CD6 == "MOD_CRUSH") {
      var_0.inflictor = var_0._id_103C2;
      var_0.attacker = var_0._id_103C2;
      var_0._id_9CD6 = "MOD_SUICIDE";
      var_0.objweapon.basename = "none";
      var_0._id_79A8 = "none";
      var_0._id_103C2._id_1DDE = [];
    }
  }

  if(var_0.objweapon.basename == "none") {
    if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor._id_232D)) {
      var_0.objweapon.basename = var_0.inflictor._id_232D;
    }
  }

  var_0._id_103C2 _id_B6F3(var_0);

  if(_id_0A8B::_id_8891(var_0.objweapon.basename, var_0._id_79A8, var_0._id_9CD6, var_0.attacker)) {
    var_0._id_9CD6 = "MOD_HEAD_SHOT";
  }

  if(var_0._id_8852) {
    var_0._id_4D02 = 0;
    var_0._id_43D5 = var_0._id_103C2 _meth_8260(var_0.inflictor, var_0._id_9CD6, var_0.objweapon, var_0._id_79A8, var_0._id_49CA);
  }
}

_id_B6F3(var_0) {
  var_0.attacker = _id_0A8B::_id_0DB6(var_0.attacker);
  var_1 = 0;

  if(!isDefined(var_0.attacker)) {
    var_1 = 1;
  } else if(isDefined(var_0.attacker.classname) && (var_0.attacker.classname == "trigger_hurt" || var_0.attacker.classname == "worldspawn")) {
    var_1 = 1;
  } else if(var_0.attacker == var_0._id_103C2) {
    var_1 = 1;
  }

  if(var_1) {
    var_2 = undefined;

    if(isDefined(var_0._id_103C2._id_1DDE) && self._id_1DDE.size > 0) {
      foreach(var_4 in var_0._id_103C2._id_1DDE) {
        if(!isDefined(_id_0A8B::_id_0DB6(var_4))) {
          continue;
        }
        if(!isDefined(var_0._id_103C2._id_1DD4[var_4.guid].damage)) {
          continue;
        }
        if(var_4 == var_0._id_103C2 || level.teambased && var_4.team == var_0._id_103C2.team) {
          continue;
        }
        if(var_0._id_103C2._id_1DD4[var_4.guid].damage > 1 && !isDefined(var_2)) {
          var_2 = var_4;
          continue;
        }

        if(isDefined(var_2) && var_0._id_103C2._id_1DD4[var_4.guid].damage > var_0._id_103C2._id_1DD4[var_2.guid].damage) {
          var_2 = var_4;
        }
      }
    }

    if(!isDefined(var_2)) {
      if(isDefined(var_0._id_103C2._id_4427) && var_0._id_103C2._id_4427.size > 0) {
        var_6 = ["chargemode_mp", "cryo_mine_mp", "s4_stun_gbr_n69_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

        foreach(var_12, var_8 in var_6) {
          var_9 = scripts\mp\gamescore::_id_69CD(var_0._id_103C2, var_8);

          if(var_9.size > 0) {
            for(var_10 = var_9.size - 1; var_10 >= 0; var_10--) {
              var_11 = var_9[var_10];

              if(!isDefined(_id_0A8B::_id_0DB6(var_11))) {
                continue;
              }
              if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_11, var_0._id_103C2))) {
                continue;
              }
              var_2 = var_11;

              if(!isDefined(var_0._id_103C2._id_1DD4) || !isDefined(var_0._id_103C2._id_1DD4[var_2.guid])) {
                _id_108F(var_0._id_103C2, var_2, undefined, makeweapon(var_8), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");
              }

              break;
            }
          }

          if(isDefined(var_2)) {
            break;
          }
        }
      }
    }

    if(isDefined(var_2)) {
      var_0.attacker = var_2;
      var_0.attacker._id_1D2B = 1;
      var_0.objweapon = var_0._id_103C2._id_1DD4[var_2.guid].objweapon;
      var_0._id_49CA = var_0._id_103C2._id_1DD4[var_2.guid]._id_FFD4;
      var_0._id_79A8 = var_0._id_103C2._id_1DD4[var_2.guid]._id_D9E0;
      var_0._id_0354 = var_0._id_103C2._id_1DD4[var_2.guid]._id_0354;
      var_0._id_9CD6 = var_0._id_103C2._id_1DD4[var_2.guid]._id_DE2B;
      var_0.damage = var_0._id_103C2._id_1DD4[var_2.guid].damage;
      var_0._id_034C = var_0._id_103C2._id_1DD4[var_2.guid]._id_E44C;
      var_0._id_1D2B = 1;
    }
  }

  if(isDefined(var_0.attacker)) {
    if(var_0.attacker._id_00EC == "script_vehicle" && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;
    }

    if(var_0.attacker._id_00EC == "misc_turret" && isDefined(var_0.attacker.owner)) {
      if(isDefined(var_0.attacker.vehicle)) {
        var_0.attacker.vehicle notify("killedPlayer", var_0._id_103C2);
      }

      var_0.attacker = var_0.attacker.owner;
    }

    if(isagent(var_0.attacker)) {
      if(isDefined(var_0.attacker.owner)) {
        var_0.attacker = var_0.attacker.owner;
      }
    }

    if(var_0.attacker._id_00EC == "script_model" && isDefined(var_0.attacker.owner)) {
      var_0.attacker = var_0.attacker.owner;

      if(!_id_886D(var_0._id_103C2, var_0.attacker) && var_0.attacker != var_0._id_103C2) {
        var_0.attacker notify("crushed_enemy");
      }
    }
  }

  if(isDefined(var_0.inflictor) && !isPlayer(var_0.inflictor)) {
    if(!isDefined(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      }
    } else if(!isPlayer(var_0.attacker)) {
      if(isDefined(var_0.inflictor.owner)) {
        var_0.attacker = var_0.inflictor.owner;
      }
    }
  }

  if(isDefined(var_0.attacker) && var_0.attacker != var_0._id_103C2) {
    if(isDefined(var_0.inflictor) && var_0.inflictor == var_0._id_103C2) {
      var_0.inflictor = var_0.attacker;
    }
  }

  var_0.attacker._id_1D2B = 0;
}

_id_B6FC(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_2._id_AFD4 = 0;
  var_2._id_4411 = undefined;
  var_2._id_441F = var_0._id_441F;
  var_2.attacker = var_1;
  var_2._id_8FBB = var_2.origin;
  var_2._id_8FB8 = var_2 getplayerangles();

  if(!isPlayer(var_3) && isDefined(var_3._id_034C)) {
    var_0._id_034C = var_3._id_034C;
  } else if(isDefined(var_1) && isPlayer(var_1) && !isnullweapon(var_1 getcurrentprimaryweapon())) {
    var_0._id_034C = getcompleteweaponname(var_1 getcurrentprimaryweapon());
  } else if(var_4._id_0245) {
    var_0._id_034C = var_4.basename;
  } else {
    var_0._id_034C = undefined;
  }

  var_0._id_936C = var_2._id_9BC0;

  if(!isDefined(var_0._id_936C)) {
    var_0._id_936C = level._id_9C84 - 1;
  }

  if(scripts\mp\utility\entity::_id_8877(var_1)) {
    var_0._id_1DD7 = var_1 getentitynumber();
  } else {
    var_0._id_1DD7 = -1;
  }

  var_0._id_88F6 = scripts\mp\utility\weapon::_id_88F6(var_4.basename);
  var_0._id_10D86 = getcompleteweaponname(var_4);
  var_0._id_886D = _id_886D(var_2, var_1);
  var_0._id_8954 = var_4.basename == "s4_v2_mp";
  var_0._id_2C4B = scripts\mp\utility\player::_id_88C8(var_2);
}

_id_B6FD(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0.damage;
  var_6 = var_0._id_9CD6;
  var_7 = var_0._id_8852;
  var_8 = var_0._id_79A8;
  var_9 = var_0._id_49CA;
  var_2 notify("killed_player");
  _id_07FB::_id_ACCC(var_2);
  var_2 _id_DCF9();
  var_2 _meth_82EE(0, 0);
  scripts\mp\outofbounds::_id_3964(var_2, 1);
  var_2 _id_0A11::_id_A047();
  var_2 _id_0A1B::_id_F1B5();
  var_2 _id_0A1C::_id_F1C6();
  var_2 _id_078C::_id_E909();
  var_2 _id_0A15::steel_bib_clear_ui();

  if(!scripts\mp\utility\game::_id_CA4B()) {
    scripts\mp\utility\print::_id_BD15("death", var_2);
  }

  var_2 _id_90FE(var_5, var_6);
  var_2 _id_080B::_id_C877();

  if(isDefined(var_1._id_B030) && var_1 != var_2) {
    var_1 _id_0798::_id_10DA();

    if(var_6 == "MOD_EXECUTION") {
      var_1 _id_0798::_id_10AD();
    }
  }

  if(var_6 == "MOD_EXECUTION" && !isagent(var_1)) {
    var_1 scripts\mp\utility\stats::_id_7DAE("executionKills", 1);
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "flavor_execution", undefined, 1.0);
  }

  if(var_6 == "MOD_EXECUTION" && isagent(var_1) && var_1._id_1210 == "actor_s4_mp_krampus") {
    var_1 thread scripts\mp\agents\krampus\think::onkrampuskill(var_2);
  }

  var_10 = var_2 getcurrentweapon();

  if(!var_2 scripts\mp\utility\weapon::_id_88F6(var_10)) {
    scripts\mp\weapons::_id_CB54();
    scripts\mp\weapons::_id_CB3F();
  }

  var_2 _id_0A12::_id_CB51();
  _id_0A95::_id_74B2();

  if(!var_7) {
    if(isDefined(var_2._id_52F7)) {
      scripts\mp\utility\player::_id_C708(2);
    } else {
      scripts\mp\utility\player::_id_C708(0);
      var_2 _meth_840A();
    }
  } else {
    var_2._id_59E0 = 1;
    var_2 _meth_8736(1);
    self notify("death");
    self notify("death_or_disconnect");
  }

  scripts\mp\perks\perks::_id_FBF1(var_3, var_1, var_2, var_5, var_6, var_4, var_8, var_9);
  scripts\mp\supers::_id_FBF3(var_3, var_1, var_2, var_5, var_6, var_4, var_8, var_9);
  _id_0A20::_id_10FB7(var_3, var_1, var_2, var_6, var_4);

  if(var_6 != "MOD_HEAD_SHOT" && !var_0._id_8954) {
    if(isDefined(level._id_4237)) {
      [[level._id_4237]](var_2, var_6, var_3);
    } else {
      var_2 _id_0AA2::_id_B386(var_6, var_4);
    }
  }

  if(isDefined(level._id_4232)) {
    [[level._id_4232]](var_2, var_6, var_3);
  }

  if(var_6 != "MOD_SUICIDE" && (scripts\mp\utility\entity::_id_8737(var_2) || scripts\mp\utility\entity::_id_8737(var_1)) && isDefined(level._id_279D) && isDefined(level._id_279D["get_attacker_ent"])) {
    var_11 = [[level._id_279D["get_attacker_ent"]]](var_1, var_3);

    if(isDefined(var_11)) {
      if(scripts\mp\utility\entity::_id_8737(var_2)) {
        var_2 _meth_8046("death", var_0._id_10D86, var_11.origin, var_2.origin, var_11);
      }

      if(scripts\mp\utility\entity::_id_8737(var_1)) {
        var_12 = 1;

        if(isDefined(var_11.classname) && (var_11.classname == "script_vehicle" && isDefined(var_11._id_77E7) || var_11.classname == "rocket" || var_11.classname == "misc_turret")) {
          var_12 = 0;
        }

        if(var_12) {
          var_1 _meth_8046("kill", var_0._id_10D86, var_11.origin, var_2.origin, var_2);
        }
      }
    }
  }

  if((scripts\mp\utility\game::_id_8A95() || scripts\mp\utility\game::getgametype() == "br") && _id_07D1::_id_60BE("prematch_done") && !istrue(var_2._id_7C27) && istrue(var_2.inlaststand)) {
    _id_07E8::_id_AAA4(var_0);
  }

  if(scripts\mp\utility\game::_id_8A95() && _id_07D1::_id_60BE("prematch_done")) {
    if(var_6 == "MOD_FALLING" && var_2 _id_081F::_id_8AEC()) {
      var_2 _id_081F::_id_D8D5();
    }

    var_13 = istrue(self._id_88DF) && isDefined(self._id_8C2B);

    if(!var_13) {
      var_14 = var_2 scripts\mp\class::_id_C6BB();
    } else {
      var_14 = self._id_8C2B;
    }

    var_2 scripts\mp\class::_id_C6A8(var_14);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      var_2 _id_07BC::_id_E901("alive_in_gas");
      var_2 _id_07BC::_id_E901("alive_not_downed");

      if(istrue(level._id_2AA8) && !scripts\mp\gametypes\br_public::_id_8990()) {
        scripts\mp\gametypes\br_analytics::_id_2AF7(self, "player_death");
      }
    }
  }

  var_15 = scripts\engine\utility::ter_op(scripts\mp\utility\killstreak::_id_8992(var_2), var_2._id_B75E, var_2);

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
    var_15 thread scripts\mp\weapons::_id_5057(var_1, var_0._id_9CD6);
  }

  var_15[[level._id_10D7D]](var_1, var_6, undefined, var_5);

  if(!var_7) {
    var_2 scripts\mp\utility\player::_id_FD26("dead");

    if(isPlayer(var_1)) {
      var_2 setclientomnvar("ui_killcam_killedby_id", var_1 getentitynumber());
    } else if(var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn") {
      var_2 setclientomnvar("ui_killcam_killedby_id", var_2 getentitynumber());
    } else {
      var_2 setclientomnvar("ui_killcam_killedby_id", -1);
    }
  }

  var_16 = istrue(var_2._id_59E0) && istrue(var_2._id_EC33);

  if(!var_16) {
    if(!isDefined(level._id_9FE5) || [[level._id_9FE5]](var_2)) {
      var_2 scripts\mp\playerlogic::_id_C4A4();
    }
  }

  if(!isDefined(var_2._id_EC33)) {
    if(!istrue(level.ignorescoring) && !var_0._id_886D) {
      var_2 _id_0804::_id_116A(1, "combatStats", "deaths");

      if(var_2.pers["deaths"] < 999) {
        var_2 scripts\mp\utility\stats::_id_7DAE("deaths", 1);
        var_2._id_0157 = var_2 scripts\mp\utility\stats::_id_6C29("deaths");
        var_2 scripts\mp\persistence::_id_E770("round", "deaths", var_2._id_0157, level._id_7D29);
      }
    }
  }

  var_17 = var_6;

  if(isDefined(var_0._id_7C97) && var_0._id_7C97 &level._id_7CA1) {
    if(isDefined(var_1._id_2D30) && var_1._id_2D30 == 0) {
      var_17 = "MOD_PENETRATION";

      if(isPlayer(var_1)) {
        if(var_4 _meth_8624("gunperk_driller")) {
          var_18 = scripts\mp\rank::getscoreinfovalue("penetration_kill") * 2;
          var_1 thread _id_0A9F::_id_700C("penetration_kill", var_18);
        } else
          var_1 thread _id_0A9F::_id_700C("penetration_kill");
      }
    }
  }

  if(level.gametype == "br") {
    var_19 = [];

    if(isDefined(var_2)) {
      var_20 = scripts\mp\utility\teams::_id_6A59(var_2.team, 0);

      if(isDefined(var_20)) {
        var_19 = var_20;
      }
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_21 = scripts\mp\utility\teams::_id_6A59(var_1.team, 0);

      if(isDefined(var_21) && var_2.team != var_1.team) {
        var_19 = scripts\engine\utility::array_combine(var_21, var_19);
      }
    }

    if(var_19.size > 0) {
      var_22 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_10007(var_0), "MOD_EXPLOSIVE", var_17);
      obituary(var_2, var_1, var_4, var_22, var_19);
    }
  } else {
    var_23 = var_4;

    if(isDefined(var_17) && var_17 == "MOD_EXPLOSIVE" && (!isDefined(var_23) || isnullweapon(var_23))) {
      var_23 = makeweapon("obit_explosive");
    }

    var_22 = var_17;

    if(!isnullweapon(var_4)) {
      var_22 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\vehicle::_id_10007(var_0), "MOD_EXPLOSIVE", var_17);
    }

    obituary(var_2, var_1, var_23, var_22);
  }

  var_2 _id_FC4B(var_2._id_1DDE, var_2._id_1DD4, var_1);
  var_2._id_8F9C = _id_07B4::_id_B6B6();
  var_2 _id_07B4::_id_B766();
  var_2 _id_07B4::_id_B767();
  var_2 thread scripts\mp\supers::_id_7431();
  var_2 scripts\mp\battlechatter_mp::_id_AB70(var_3, var_1, var_5, var_6, var_4, var_0._id_49CA, var_0._id_79A8, var_0._id_0354, var_0._id_43D5, var_0._id_936C);
  var_2 thread[[level._id_AB71]](var_3, var_1, var_5, var_6, var_4, var_0._id_49CA, var_0._id_79A8, var_0._id_0354, var_0._id_43D5, var_0._id_936C, scripts\mp\utility\weapon::_id_88F6(var_10));

  if(isai(var_2) && isDefined(level._id_279D) && isDefined(level._id_279D["on_killed"])) {
    var_2 thread[[level._id_279D["on_killed"]]](var_3, var_1, var_5, var_6, var_0._id_10D86, var_0._id_49CA, var_0._id_79A8, var_0._id_0354, var_0._id_43D5, var_0._id_936C);
  }

  var_24 = (var_0._id_441F - var_2._id_E393) / 1000;

  if(isDefined(var_2.pers["shortestLife"])) {
    if(var_2.pers["shortestLife"] == 0 || var_24 < var_2.pers["shortestLife"]) {
      var_2.pers["shortestLife"] = var_24;
    }
  }

  if(isDefined(var_2.pers["shortestLife"])) {
    if(var_2.pers["longestLife"] == 0 || var_24 > var_2.pers["longestLife"]) {
      var_2.pers["longestLife"] = var_24;
    }
  }
}

_id_B6FA(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0.objweapon;
  var_5 = var_0._id_10D86;
  var_6 = var_0._id_9CD6;
  var_7 = var_0._id_936C;
  var_2 scripts\common\utility::_id_F73A(level._id_39A0, var_1);
  _id_06E2::_id_4C2A("callback_player_death", var_0);
  var_2 _id_07A9::_id_9778();
  var_2 _id_07A9::_id_977A(var_1, var_6, var_5);

  if(isPlayer(var_1)) {
    var_1 _id_07A9::_id_977C(var_2, var_6, var_5);
  }

  if(isPlayer(var_1) && var_1 != self && istrue(var_1.dead_drop_active)) {
    var_1 scripts\mp\killstreaks\killstreaks::_id_CB52();
  }

  if(isPlayer(var_1) && var_1 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    var_8 = var_2._id_8FC2;
    var_8 = scripts\mp\utility\weapon::_id_9ACB(var_8, var_3);
    var_9 = getcompleteweaponname(var_8);
    thread scripts\mp\gamelogic::_id_F41A(var_1, var_2, var_9, var_6);
    thread scripts\mp\gamelogic::_id_F3F2(var_1, var_2, var_5, var_6);
  }

  if(isDefined(level._id_9BDB) && isDefined(var_3) && isPlayer(var_3) && scripts\engine\utility::_id_8794(var_6)) {
    var_10 = var_3.origin - var_2.origin;
    var_11 = vectornormalize((var_10[0], var_10[1], 0));
    var_12 = anglesToForward(var_2.angles);
    var_13 = vectornormalize((var_12[0], var_12[1], 0));
    var_14 = clamp(var_13[0] * var_11[0] + var_13[1] * var_11[1], -1.0, 1.0);
    var_15 = _func_0002(var_14);

    if(!isDefined(var_2._id_DD1A)) {
      var_2._id_DD1A = 0;
    }

    if(var_15 > 75.0) {
      var_2._id_DD1A++;
    }

    var_16 = 0.0;

    if(isDefined(var_2._id_5456)) {
      var_16 = gettime() - var_2._id_5456;
    }

    if(!isDefined(var_2._id_5457)) {
      var_2._id_5457 = 0;
      var_2._id_5455 = 0;
    }

    var_2._id_5457 = var_2._id_5457 + var_16;
    var_2._id_5455++;
    var_2._id_5456 = undefined;
  }

  _id_FC37(var_1, var_2, var_6, var_4);
}

_id_B6F2(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0._id_9CD6;

  if(var_2 _id_8A85()) {
    return "deathType_switchingTeams";
  } else if(!isPlayer(var_1) || isPlayer(var_1) && var_4 == "MOD_FALLING") {
    return "deathType_worldDeath";
  } else if(var_1 == var_2 || !scripts\cp_mp\utility\player_utility::_id_B78C(var_1, var_2) && scripts\mp\utility\entity::_id_8811(var_3)) {
    return "deathType_suicide";
  } else if(var_0._id_886D && var_0.objweapon.basename != "bomb_site_mp" && !var_0._id_8954) {
    return "deathType_friendlyFire";
  } else if(istrue(var_2.inlaststand)) {
    return "deathType_inLastStand";
  } else {
    return "deathType_normal";
  }
}

_id_B6F5(var_0) {
  var_1 = var_0._id_103C2;
  var_0._id_4420 = _id_B6F2(var_0);

  switch (var_0._id_4420) {
    case "deathType_switchingTeams":
      _id_749E();
      break;
    case "deathType_worldDeath":
      _id_74B7(var_0, var_0.attacker, var_0._id_936C, var_0._id_9CD6, var_0._id_79A8);
      break;
    case "deathType_suicide":
      _id_749B(var_0._id_9CD6, var_0._id_79A8);
      break;
    case "deathType_friendlyFire":
      _id_744D(var_0.attacker, var_0._id_103C2);
      break;
    case "deathType_inLastStand":
      _id_7461(var_0);
      break;
    case "deathType_normal":
      _id_7474(var_0._id_936C, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0._id_9CD6, var_1, var_0._id_88F6, var_0);
      break;
    default:
      break;
  }
}

_id_B6FE(var_0) {
  _id_B6F4(var_0);
  _id_D4FF(var_0);
  var_1 = var_0.attacker;

  if(isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(!isPlayer(var_1)) {
    var_0._id_4D02 = 0;
    var_0._id_4CAC = 0;
  }

  _id_B6F9(var_0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2AEB(var_0.attacker, var_0._id_103C2, var_0.objweapon, var_0._id_4420);
  }

  thread _id_07BC::_id_AAA4(var_0.inflictor, var_0.attacker, var_0.damage, var_0._id_4304, var_0._id_9CD6, var_0.objweapon, var_0._id_79A8, var_0.attacker._id_9FFB);

  if(!scripts\mp\utility\game::_id_CA4B() || getdvarint("#x35104344562d1d829", 1)) {
    _id_B6FA(var_0);
  }

  if(isDefined(level.updatecodcasterclientstatsinplayerkilledsharedlogiclate) && level.updatecodcasterclientstatsinplayerkilledsharedlogiclate) {
    _id_07BF::_id_FC32();
    level.updatecodcasterclientstatsinplayerkilledsharedlogiclate = 0;
  }

  _id_0818::badspawntimeout(var_0._id_103C2);
}

_id_B6F4(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0._id_9CD6;
  var_5 = var_0.objweapon;
  scripts\cp_mp\vehicles\vehicle::_id_10235(var_0);

  if(!isDefined(self._id_A546)) {
    var_2._id_25CA = var_2 cloneplayer(var_0._id_43D5, var_1);
  }

  if(!isDefined(self._id_A546) && isDefined(var_2._id_25CA)) {
    var_2._id_25CA._id_0481 = "player_corpse";

    if(var_0._id_8954) {}

    if(_func_010F(var_4)) {
      _func_0472(scripts\engine\utility::getfx("vfx_dismember"), var_2._id_25CA, var_3.origin);
    }

    _id_5467(var_1, var_2, var_3, var_5, var_4);
    var_2 thread _id_2F5C();

    if(var_0._id_8852) {
      var_2 playerhide();
      var_2 _meth_852B(0);
    }

    if(!isDefined(var_2._id_EC33)) {
      if(isDefined(var_1) && isPlayer(var_1)) {
        thread _id_07C5::_id_10A4(var_1, var_2._id_25CA, var_2, var_2.team, 5.0);
      }

      var_6 = [];
      var_7 = [];

      foreach(var_10, var_9 in level.players) {
        if(isDefined(var_2)) {
          if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_9, var_2)) && var_9 scripts\mp\utility\perk::_hasperk("specialty_kill_report")) {
            var_6[var_10] = var_9;
            continue;
          }

          if(var_9 _meth_81D3()) {
            var_7[var_10] = var_9;
          }
        }
      }

      if(var_6.size > 0 || var_7.size > 0) {
        thread _id_07C5::_id_10A8(var_2._id_25CA, var_2, var_6, var_7, getdvarfloat("#x3ece9446ba0f29d4c"), 1);
      }
    }

    var_2 thread _id_0D84(var_0._id_103C2._id_25CA, var_0._id_9CD6, var_0.inflictor);
  } else if(isDefined(var_2._id_A546)) {
    var_2._id_25CA = var_2 cloneplayer(var_0._id_43D5);
    var_2._id_25CA hide(1);
  }

  if(!istrue(game["isLaunchChunk"])) {
    var_2._id_EA19 = scripts\mp\class::_id_962F(var_2._id_EA19);

    if(scripts\mp\killstreaks\killstreaks::_id_EA1A(var_2._id_EA19)) {
      if(!level._id_3324 && !var_2 scripts\mp\utility\perk::_hasperk("specialty_support_killstreaks")) {
        var_2 scripts\mp\killstreaks\killstreaks::_id_C647();
        var_2 scripts\mp\killstreaks\killstreaks::_id_C645();
      } else if(level._id_3324) {
        var_11 = scripts\mp\killstreaks\killstreaks::_id_34E8();

        if(var_11) {
          var_2 scripts\mp\killstreaks\killstreaks::_id_C647();
          var_2 scripts\mp\killstreaks\killstreaks::_id_C645();
        }
      }
    }
  }
}

_id_0D84(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_3 = var_0 _meth_8121();
  var_4 = 0.0;

  if(_func_0335(var_3)) {
    var_4 = _func_0079(var_3);
  }

  var_5 = undefined;
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = _id_B700(var_1, var_2);
  var_8 = undefined;
  var_9 = _func_0011(var_3, "delete_corpse");
  var_10 = _func_0011(var_3, "delete_corpse_delayed");
  var_11 = _func_0011(var_3, "no_ragdoll");
  var_12 = _func_0011(var_3, "start_ragdoll");
  var_13 = _func_0011(var_3, "hide_corpse");

  if(isDefined(var_6)) {
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_6, self);

    if(var_11 || var_12) {
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C7(var_0, var_6, var_8);
      var_0 _meth_8303(0);
      var_0._id_9516 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C8(var_6, var_8);
    }

    if(var_9 || var_10 || var_11 || var_12) {
      var_14 = scripts\engine\utility::ter_op(var_11 || var_12, 0, 1);
      var_15 = scripts\engine\utility::ter_op(var_10, var_4, var_4 + 3);
      thread _id_B6F1(var_0, var_6, var_8, var_15, var_14);
    }
  }

  if(var_1 == "MOD_EXECUTION" && var_13) {
    var_5 = 0;

    if(var_13 && var_4 > 0.0) {
      var_16 = _func_00BB(var_3, "hide_corpse")[0];
      var_5 = var_16 * var_4;
    }

    wait(var_5);
    var_0 thread _donewithcorpseexecutions(var_5, var_4);
    return;
  }

  if(var_1 != "MOD_EXECUTION" && !var_11) {
    var_5 = 0;

    if(var_12 && var_4 > 0.0) {
      var_16 = _func_00BB(var_3, "start_ragdoll")[0];
      var_5 = var_16 * var_4;
    }

    if(var_7) {
      var_5 = 0;
    }
  }

  if(isDefined(var_5)) {
    wait(var_5);

    if(!isDefined(var_0)) {
      return;
    }
    if(isDefined(var_6)) {
      var_0 thread _id_0D9E(var_6, var_8, var_9, var_10, var_5, var_4);
      var_0 notify("cancel_delete_corpse");
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_1016F(var_0, var_6, var_8);
    } else {
      if(!var_0 _meth_81DF()) {
        if(var_7) {
          var_0 _meth_8737(var_2);
        } else {
          var_0 startragdoll();
        }
      }

      var_0 thread _id_0BC8(var_9, var_10, var_5, var_4);
    }
  }
}

_id_0BC8(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(var_0 || var_1) {
    var_5 = var_3;

    if(var_1) {
      var_3 = var_3 + 3;
    }

    if(isDefined(var_2)) {
      var_5 = var_5 - var_2;
    }

    wait(var_5);

    if(!isDefined(var_4)) {
      return;
    }
    var_4 delete();
  } else if(!scripts\mp\utility\game::_id_8A95())
    var_4 _meth_8364();
}

_donewithcorpseexecutions(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2)) {
    return;
  }
  var_2 hide();
  var_3 = var_1 - var_0;
  wait(var_3);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 delete();
}

_id_0D9E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self;
  var_7 = getdvarint("#x3563ba0a5dd95b6cc", 1);
  var_8 = !var_7;
  var_9 = getdvarint("#x34b2aab732bf30285", 1);

  if(var_7) {
    if(!var_6 _meth_81DF()) {
      var_6 startragdoll(var_9);
    }
  }

  var_10 = getdvarfloat("#x374f7deb5129121de", 0.1);

  if(var_10 > 0) {
    wait(var_10);
  }

  if(isDefined(var_6)) {
    if(isDefined(var_6._id_9516) && isDefined(var_0)) {
      var_11 = (0, 0, 0);
      var_12 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C8(var_0, var_1);
      var_11 = var_12.origin - var_6._id_9516.origin;
      var_13 = var_6.origin + var_11;
      var_14 = var_12.angles;
      var_6 _meth_875B(var_13, var_14);
    }

    var_6 unlink();

    if(var_8) {
      var_6 startragdoll(var_9);
    }

    var_6 thread _id_0BC8(var_2, var_3, var_4, var_5);
  }
}

_id_0D85(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  var_3 = var_0 _meth_8121();
  var_4 = undefined;
  var_5 = _func_0079(var_3);
  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();
  var_7 = var_1 == "MOD_CRUSH" && isDefined(var_2) && isDefined(var_2._id_1031E);

  if(!var_7) {
    var_8 = _func_0011(var_3, "delete_corpse");
    var_9 = _func_0011(var_3, "delete_corpse_delayed");
    var_10 = _func_0011(var_3, "no_ragdoll");
  } else {
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
  }

  if(isDefined(var_6)) {
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_6, self);

    if(var_10) {
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C7(var_0, var_6, var_11);
    }

    if(var_8 || var_9) {
      var_12 = scripts\engine\utility::ter_op(var_9, var_5, var_5 + 3);
      thread _id_B6F1(var_0, var_6, var_11, var_12);
    }
  }

  if(var_1 != "MOD_EXECUTION" && !var_10) {
    var_4 = 0;

    if(_func_0011(var_3, "start_ragdoll")) {
      var_13 = _func_00BB(var_3, "start_ragdoll")[0];
      var_4 = var_13 * var_5;
    }
  }

  if(var_7) {
    var_4 = 0;
  }

  if(isDefined(var_4)) {
    if(var_4 > 0) {
      wait(var_4);
    }

    if(!var_0 _meth_81DF()) {
      if(!var_7) {
        var_0 startragdoll();
      } else {
        var_0 _meth_8737(var_2);
      }
    }
  }

  if(var_8 || var_9) {
    if(!var_7) {
      var_14 = var_5;

      if(var_9) {
        var_5 = var_5 + 3;
      }

      if(isDefined(var_4)) {
        var_14 = var_14 - var_4;
      }

      wait(var_14);
    }

    var_0 delete();
  } else if(!scripts\mp\utility\game::_id_8A95())
    var_0 _meth_8364();
}

_id_B6F1(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("cancel_delete_corpse");
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_10163(var_0, var_1, var_2, var_4);
  var_1 scripts\engine\utility::_id_108A7(var_3, "death");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_B700(var_0, var_1) {
  if(var_0 != "MOD_CRUSH") {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    return 0;
  }

  return 1;
}

_id_B6F9(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0._id_103C2;
  var_3 = var_0.inflictor;
  var_4 = var_0._id_9CD6;
  var_5 = var_0.objweapon;
  var_6 = var_0._id_5705;

  if(var_0.attacker._id_1D2B || level.teambased && isDefined(var_1.team) && var_1.team == var_2.team) {
    var_0._id_4D02 = 0;
    var_0._id_4CAC = 0;
  }

  if(!isDefined(var_0.killcamentity)) {
    var_0.killcamentity = var_2 _id_07E7::_id_6AD9(var_1, var_3, var_5, var_4);
  }

  if(isDefined(var_0.killcamentity)) {
    var_0._id_8D63 = var_0.killcamentity getentitynumber();
    var_0._id_8D64 = var_0.killcamentity._id_0094;

    if(!isDefined(var_0._id_8D64)) {
      var_0._id_8D64 = 0;
    }
  }

  if(var_0._id_4D02) {
    var_2 _id_07E7::_id_BB94(var_1);

    if(isDefined(var_3) && isagent(var_3)) {
      var_0._id_7E94 = spawnStruct();
      var_0._id_7E94._id_1210 = var_3._id_1210;
      var_0._id_7E94._id_904F = var_3._id_904F;
    }
  }

  var_0._id_8D67 = var_4 == "MOD_IMPACT" || var_4 == "MOD_HEAD_SHOT" && isDefined(var_3) || var_4 == "MOD_GRENADE" || isDefined(var_2) && isDefined(var_2._id_EA8D) && isDefined(var_3) && var_2._id_EA8D == var_3 || var_5.basename == "throwingknifec4_mp";

  if(isDefined(var_1.killcamvanityindex)) {
    self setclientomnvar("ui_killcam_killedby_vanity_index", var_1.killcamvanityindex);
  }

  if(!var_0._id_88F6) {
    _id_07E7::_id_D5CD(var_5, var_4, var_3, var_6);
  }

  if(level._id_C145 && var_0._id_4CAC && !_id_081E::skipplayerbotfinalkillcam(var_1)) {
    if((!isDefined(level._id_4A15) || !level._id_4A15) && var_4 != "MOD_SUICIDE" && !(!isDefined(var_1) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_1 == var_2)) {
      _id_07D0::_id_C145(5.0, var_2, var_1, var_0._id_1DD7, var_3, var_0._id_8D63, var_0._id_8D64, var_0._id_8D67, var_5, var_0._id_0354, var_4);
    }
  }
}

_id_B6F0(var_0) {
  var_1 = var_0._id_103C2;
  var_1 endon("spawned");

  if(!istrue(var_1._id_DDA8)) {}

  var_1 _meth_83EF("sys_deaths_door_lp_mp");

  if(var_1 scripts\mp\utility\player::_id_8855()) {
    var_1 _meth_83EF("sys_deaths_door_breath_lp_mp_fm");
  } else {
    var_1 _meth_83EF("sys_deaths_door_breath_lp_mp");
  }

  var_1 _meth_8680("deaths_door_mp");
  _func_02E3("deaths_door", "", 0.05);

  if(!var_0._id_8852) {
    if(isDefined(var_0.attacker.killcamvanityindex)) {
      var_1 setclientomnvar("ui_killcam_prestream_vanity_index", var_0.attacker.killcamvanityindex);
    }

    if(!isDefined(var_1._id_C6C5)) {
      var_1._id_C6C5 = gettime() + var_0._id_43FE;
    }

    wait(var_0._id_43FF);

    if(var_0._id_4D02) {
      var_0._id_4D02 = !_id_07D0::_id_DDB1(0.5);
    }

    var_1 notify("death_delay_finished");
  } else if(!isDefined(var_1._id_C6C5))
    var_1._id_C6C5 = gettime();
}

_id_B6F8(var_0) {
  var_0._id_103C2 endon("spawned");
  var_1 = var_0._id_103C2;
  var_2 = var_0.attacker;
  var_3 = (gettime() - var_1._id_441F) / 1000;

  if(isDefined(level._id_9FF5)) {
    [[level._id_9FF5]](var_0);
  }

  if(!(isDefined(var_1._id_315D) && var_1._id_315D) && var_0._id_4D02 && level.killcam && game["state"] == "playing" && !var_1 scripts\mp\utility\player::_id_8ACE() && !level._id_DCBA) {
    var_4 = scripts\mp\playerlogic::_id_F287(1);

    if(!isDefined(var_2) || !isDefined(var_2.pers)) {
      var_5 = [];
    } else {
      var_5 = var_2.pers["loadoutPerks"];
    }

    if(!istrue(level._id_4A87)) {
      var_1 thread _id_E693(var_2);
    }

    var_6 = scripts\mp\utility\game::modesupportsloadoutsharing() && !scripts\mp\utility\game::privatematch() && getdvarint("#x3a9c4045693a5c72b", 0) && getdvarint("#x37a6c1a0743673f40", 0) && !isbot(self);

    if(var_6) {
      var_1 thread startlistenforloadoutsave(var_2);
    }

    var_7 = 1;
    var_1.killedbyassistedsuicide = var_0._id_1D2B;
    var_1 _id_07E7::killcam(var_0.inflictor, var_0._id_7E94, var_0._id_1DD7, var_0._id_8D63, var_0._id_8D64, undefined, var_0._id_8D67, var_0.objweapon, var_3, var_0._id_0354, var_4, scripts\mp\gamelogic::_id_F286(), var_2, var_1, var_0._id_9CD6, var_5, var_7);
    var_1.killedbyassistedsuicide = undefined;

    if(!istrue(level._id_4A87)) {
      var_1 thread _id_E905();
    }

    var_1 thread stoplistenforloadoutsave();

    if(isDefined(level._id_AB7D)) {
      [[level._id_AB7D]]();
    }
  }
}

_id_B6FF(var_0) {
  if(isDefined(level._id_9FEB) && [[level._id_9FEB]](var_0, 1)) {
    return;
  }
  var_1 = var_0._id_103C2;
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_2 = var_0.attacker;
  var_1 _id_C639();
  var_1 _id_C635();

  if(isDefined(var_2)) {
    var_1._id_026E = var_2;
  } else {
    var_1._id_026E = undefined;
  }

  var_1._id_109C6 = 0;

  if(isDefined(var_1.vehicle)) {
    var_3 = var_1.vehicle;
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(var_3, var_1);
    var_5 = spawnStruct();
    var_5._id_B68D = 1;
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10182(var_3, var_4, var_1, var_5);
  }

  if(game["state"] != "playing") {
    if(!level._id_DCBA) {
      var_1 scripts\mp\utility\player::_id_FD26("dead");
      var_1 scripts\mp\utility\player::_id_394E();
    }

    return;
  }

  if(scripts\mp\class::_id_8AE0(var_1.class)) {
    var_1 thread scripts\mp\playerlogic::_id_E285();
  }
}

_id_B6F7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_2 endon("spawned");

  if(game["state"] == "postgame") {
    return;
  }
  var_12 = var_2 _id_B6F6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  _id_B6FB(var_12);
  _id_B6FC(var_12);
  _id_B6FD(var_12);
  _id_B6F5(var_12);
  _id_B6FE(var_12);
  _id_B6F0(var_12);
  _id_B6F8(var_12);
  _id_B6FF(var_12);
}

_id_8A85() {
  if(isDefined(self._id_EC33)) {
    return 1;
  }

  return 0;
}

_id_8A98() {
  var_0 = scripts\mp\teams::_id_3DA8();
  var_0[self._id_916E]--;
  var_0[self._id_8BDA]++;
  return var_0[self._id_8BDA] - var_0[self._id_916E] < 2;
}

_id_886D(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0.team != var_1.team) {
    return 0;
  }

  if(var_0 == var_1) {
    return 0;
  }

  return 1;
}

_id_8D80(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  if(var_0 != self) {
    return 0;
  }

  return 1;
}

_id_749E() {
  if(!level.teambased) {
    return;
  }
  if(self._id_8BDA == "spectator" || !_id_8A98()) {
    _id_0804::_id_116A(1, "combatStats", "suicides");
    scripts\mp\utility\stats::_id_7DAE("suicides", 1);
  }

  if(isDefined(level._id_ABB9)) {
    [[level._id_ABB9]](self);
  }
}

_id_74B7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0._id_103C2;
  var_5._id_4411 = var_5.origin;

  if(!isDefined(var_1)) {
    return;
  }
  _id_07CE::_id_B823(var_1, var_3);

  if(!isDefined(var_1.team) || var_1.team == "neutral") {
    _id_749B(var_3, var_4);
    return;
  }

  if(level.teambased && var_1.team != self.team || !level.teambased) {
    if(isDefined(level._id_AB3F) && (isPlayer(var_1) || isagent(var_1)) && var_1.team != "spectator") {
      if(!level.gameended) {
        [[level._id_AB3F]](self, var_1, var_2, var_3);
      }
    }
  }

  if(isagent(var_1)) {
    var_0._id_4D02 = 1;
  }
}

_id_749B(var_0, var_1) {
  _id_0804::_id_116A(1, "combatStats", "suicides");
  scripts\mp\utility\stats::_id_7DAE("suicides", 1);
  _id_07BF::_id_D5E4(21, 0);
  var_2 = scripts\mp\tweakables::_id_6E14("game", "suicidepointloss");
  scripts\mp\gamescore::_id_0CEE(self, scripts\mp\gamescore::_id_0C06(self) - var_2);

  if(scripts\mp\weapons::_id_7166() && var_0 == "MOD_SUICIDE" && var_1 == "none") {
    self._id_8FDE = gettime();
  }

  if(isDefined(level._id_ABB3)) {
    [[level._id_ABB3]](self);
  }

  self._id_EAF5 = 1;

  if(isDefined(self._id_5FA4)) {
    self._id_5FB3 = 1;
  }
}

_id_744D(var_0, var_1) {
  if(scripts\mp\utility\game::_id_8A95() && _id_07D1::_id_60BE("prematch_done")) {
    level thread _id_081F::_id_E35E(var_1, var_1, "new_trigger_spawned", "MOD_SUICIDE");
  }

  var_0 thread scripts\mp\rank::_id_CC00("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1.0;

  if(scripts\mp\tweakables::_id_6E14("team", "teamkillpointloss")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\gamescore::_id_0CEE(var_0, scripts\mp\gamescore::_id_0C06(var_0) - var_2);
  }

  if(level._id_9C50 < 0) {
    return;
  }
  var_3 = var_0 scripts\mp\playerlogic::_id_EF7F();

  if(var_3 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_0 notify("team_kill_punish");

    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      var_0 thread _id_0A8B::_id_EAE0();
    } else {
      var_0 thread _id_0A8B::_id_EADF();
    }
  }

  if(level._id_5FA5 == 4 && !istrue(var_0._id_79A5) && var_0.pers["teamkills"] >= level._id_9C50) {
    var_0._id_79A5 = 1;
    var_0 scripts\mp\hud_message::_id_DCA2("MP/FRIENDLY_FIRE_PUNISH_SWITCH");
  }

  if(isDefined(level.maxallowedteamkillsbeforekick) && level.maxallowedteamkillsbeforekick > 0 && var_0.pers["teamkills"] >= level.maxallowedteamkillsbeforekick) {
    if(!istrue(var_0.hitffkicklimit)) {
      var_0.hitffkicklimit = 1;
      var_0 scripts\mp\hud_message::_id_DCA2("MP/FRIENDLY_FIRE_KICK_WARNING");
    } else if(istrue(var_0._id_3B81))
      kick(var_0 getentitynumber(), "EXE/PLAYERKICKED_TEAMKILLS");
  }
}

_id_7461(var_0) {
  var_1 = scripts\mp\utility\game::getgametype() == "br";

  if(!istrue(var_0._id_103C2._id_4A15)) {
    var_0._id_4D02 = 1;
  }

  if(!var_0._id_88F6) {
    var_0.attacker thread _id_0A9F::_id_7003("last_stand_kill", var_0.objweapon, undefined, undefined, var_0._id_103C2);

    if(isDefined(self._id_9060)) {
      self._id_9060 _id_B6DC();
    }

    if(isDefined(self._id_9060) && var_0.attacker != self._id_9060) {
      self._id_9060 thread scripts\mp\rank::_id_CC00("kill_confirmed");
      self._id_9060 = undefined;
      self._id_907C = undefined;
      self._id_9096 = undefined;
    }

    if(var_1) {
      _id_7474(var_0._id_936C, var_0.attacker, var_0.inflictor, var_0.objweapon, var_0._id_9CD6, self, var_0._id_88F6, var_0, 1);
    }
  }
}

_id_7475(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = var_1;

  if(!isDefined(var_0._id_8FFA)) {
    var_0._id_8FFA = gettime();
    var_4 = 1;
  } else if(gettime() > var_0._id_8FFA + 700) {
    var_0._id_8FFA = gettime();
    var_4 = 1;
  }

  var_4 = 0;

  if(!scripts\engine\utility::_id_8794(var_2) || var_0 != var_3) {
    if(var_4 && !scripts\cp_mp\utility\game_utility::_id_89EC()) {
      var_5 playsoundtoplayer("mp_kill_alert_quiet", var_0);
    }
  } else if(var_2 == "MOD_HEAD_SHOT") {
    var_5 playsoundtoplayer("bullet_impact_headshot_plr", var_1);
    var_5 playsoundtoplayer("bullet_impact_headshot", var_0);

    if(var_4) {
      var_5 playsoundtoplayer("mp_headshot_alert", var_0);
    }

    var_5 playsoundtoteam("bullet_impact_headshot_npc", var_1.team, var_1);
    var_5 playsoundtoteam("bullet_impact_headshot_npc", var_0.team, var_0);
  } else {
    var_5 playsoundtoteam("mp_hit_alert_final_npc", var_1.team);
    var_5 playsoundtoteam("mp_hit_alert_final_npc", var_0.team, var_0);

    if(var_4) {
      var_5 playsoundtoplayer("mp_kill_alert", var_0);
    }
  }

  if(isPlayer(var_1)) {
    var_1 _meth_8680("deaths_door_mp", 2);
  }
}

_id_7474(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(var_4 == "MOD_GRENADE" && var_2 == var_1) {
    _id_108F(var_5, var_1, var_2, var_3, var_7.damage, (0, 0, 0), var_7._id_49CA, var_7._id_79A8, var_7._id_0354, var_4);
  }

  var_7._id_4D02 = 1;

  if(isai(var_5) && isDefined(level._id_279D) && isDefined(level._id_279D["should_do_killcam"])) {
    var_7._id_4D02 = var_5[[level._id_279D["should_do_killcam"]]]();
  }

  if(istrue(level._id_4A15) || istrue(var_5._id_4A15)) {
    var_7._id_4D02 = 0;
  }

  var_1 thread _id_07CE::_id_8D7C(var_0, self, var_3, var_4, var_2, var_7);

  if(!istrue(level._id_4AEC)) {
    _id_07BF::_id_AB6F(var_1, var_5);
    var_5.pers["cur_death_streak"]++;

    if(var_4 == "MOD_HEAD_SHOT") {
      var_1 _id_0804::_id_116A(1, "combatStats", "headshots");
      var_1 scripts\mp\utility\stats::_id_7DAE("headshots", 1);
      var_1._id_761D = var_1 scripts\mp\utility\stats::_id_6C29("headshots");

      switch (weaponclass(var_3.basename)) {
        case "rifle":
          var_1 scripts\mp\utility\stats::_id_7DAE("arHeadshots", 1);
          break;
        case "smg":
          var_1 scripts\mp\utility\stats::_id_7DAE("smgHeadshots", 1);
          break;
        case "spread":
          var_1 scripts\mp\utility\stats::_id_7DAE("shotgunHeadshots", 1);
          break;
        case "mg":
          var_1 scripts\mp\utility\stats::_id_7DAE("lmgHeadshots", 1);
          break;
        case "sniper":
          var_1 scripts\mp\utility\stats::_id_7DAE("sniperHeadshots", 1);
          break;
        case "rocketlauncher":
          var_1 scripts\mp\utility\stats::_id_7DAE("launcherHeadshots", 1);
          break;
        case "pistol":
          var_1 scripts\mp\utility\stats::_id_7DAE("pistolHeadshots", 1);
          break;
      }
    }

    if(isDefined(var_2) && istrue(var_2._id_8835)) {
      switch (var_2._id_5562) {
        case "equip_frag":
          var_1 scripts\mp\utility\stats::_id_7DAE("fragKills", 1);
          break;
        case "equip_semtex":
          var_1 scripts\mp\utility\stats::_id_7DAE("semtexKills", 1);
          break;
        case "equip_molotov":
          var_1 scripts\mp\utility\stats::_id_7DAE("molotovKills", 1);
          break;
        case "equip_claymore":
          var_1 scripts\mp\utility\stats::_id_7DAE("claymoreKills", 1);
          break;
        case "equip_throwing_knife":
          var_1 scripts\mp\utility\stats::_id_7DAE("throwingKnifeKills", 1);
          break;
        case "equip_c4":
          var_1 scripts\mp\utility\stats::_id_7DAE("c4Kills", 1);
          break;
        case "equip_thermite":
          var_1 scripts\mp\utility\stats::_id_7DAE("thermiteKills", 1);
          break;
        case "equip_at_mine":
          var_1 scripts\mp\utility\stats::_id_7DAE("proximityMineKills", 1);
          break;
        case "equip_at_mine_stun":
          var_1 scripts\mp\utility\stats::_id_7DAE("proximityMineKills", 1);
          break;
      }
    }

    if(scripts\common\utility::_id_69C4(var_4) == "splash") {
      var_1 scripts\mp\utility\stats::_id_7DAE("explosiveKills", 1);
    }
  }

  thread _id_7475(var_1, var_5, var_4, var_2);
  var_9 = var_1;

  if(isDefined(var_1._id_3ADD)) {
    var_9 = var_1._id_3ADD;
  }

  if(!istrue(var_8) && !_id_886D(var_5, var_1)) {
    if(!istrue(level.ignorescoring)) {
      var_9 _id_B6DC();

      if(_id_877C(var_9, var_5)) {
        var_9 scripts\mp\utility\stats::_id_7DAE("killsFromBehind", 1);
        var_5 scripts\mp\utility\stats::_id_7DAE("deathsFromBehind", 1);
      }
    } else if(isDefined(level._id_BB9E))
      var_9[[level._id_BB9E]]();
  }

  if(!istrue(level._id_4AEC)) {
    _id_07BF::_id_D5E4(21, 0);

    if(isPlayer(var_1)) {
      var_1 _id_07BF::_id_7D9A(21, 1);
    }
  }

  if(!istrue(var_9.pers["ignoreWeaponMatchBonus"]) && (scripts\mp\utility\weapon::_id_879A(var_3) || scripts\mp\utility\weapon::_id_879C(var_3))) {
    if(!isDefined(var_9.pers["weaponMatchBonusKills"])) {
      var_9.pers["weaponMatchBonusKills"] = 1;
    } else {
      var_9.pers["weaponMatchBonusKills"]++;
    }

    if(var_9.pers["weaponMatchBonusKills"] > _id_0826::_id_6A64()) {
      var_9.pers["ignoreWeaponMatchBonus"] = 1;
      var_9.pers["weaponMatchBonusKills"] = undefined;
      var_9.pers["killsPerWeapon"] = undefined;
    } else {
      if(!isDefined(var_9.pers["killsPerWeapon"])) {
        var_9.pers["killsPerWeapon"] = [];
      }

      var_10 = scripts\mp\utility\weapon::getweaponrootname(var_3);
      var_11 = 0;

      foreach(var_14, var_13 in var_9.pers["killsPerWeapon"]) {
        if(var_14 == var_10) {
          var_13._id_8D6E++;
          var_11 = 1;
          break;
        }
      }

      if(!var_11) {
        var_13 = spawnStruct();
        var_13._id_8D6E = 1;
        var_13.basename = var_3.basename;
        var_13._id_AC63 = var_9.pers["killsPerWeapon"].size;
        var_13.objweapon = var_3;
        var_9.pers["killsPerWeapon"][var_10] = var_13;
      }
    }
  }

  var_15 = var_1.pers["cur_kill_streak"];

  if(!istrue(level.ignorescoring) && (isalive(var_1) || isDefined(var_1._id_EA19) && var_1._id_EA19 == "support")) {
    if(var_4 == "MOD_MELEE" && !var_1 scripts\mp\utility\killstreak::_id_88DF() && isDefined(var_2) && !isagent(var_2) || var_1 scripts\mp\utility\killstreak::_id_8D9E(var_3)) {
      var_1 _id_C269(var_3, var_4, 1, var_6);
    }

    if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility\stats::_id_6C29("longestStreak")) {
      var_1.pers["longestStreak"] = var_1.pers["cur_kill_streak"];
      _id_07DF::_id_D5D4(var_1, var_1.pers["longestStreak"]);
    }
  }

  var_1.pers["cur_death_streak"] = 0;

  if(!scripts\mp\utility\game::_id_CA4B()) {
    if(!istrue(level.ignorescoring) && var_1.pers["cur_kill_streak"] > var_1 scripts\mp\persistence::_id_E760("round", "killStreak")) {
      var_1 scripts\mp\persistence::_id_E770("round", "killStreak", var_1.pers["cur_kill_streak"]);
    }

    if(!istrue(level.ignorescoring) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      if(var_1.pers["cur_kill_streak"] > var_1._id_24D1) {
        var_1 _id_0804::_id_D672(var_1.pers["cur_kill_streak"], "bestStats", "killStreak");
        var_1._id_24D1 = var_1.pers["cur_kill_streak"];
      }
    }
  }

  if(!scripts\mp\utility\weapon::_id_88F6(var_3) && !scripts\mp\utility\weapon::_id_88F4(var_2) || _id_0A9F::_id_8868(var_3)) {
    var_1 thread _id_07CE::_id_8D83("kill", 0);
    var_16 = undefined;

    if(scripts\mp\utility\game::getgametype() == "br" && !_id_07D1::_id_60BE("prematch_done")) {
      var_16 = 100;
    }

    var_1 thread _id_0A9F::_id_7003("kill", var_3, var_16, undefined, var_5);
    var_1 _id_07B4::_id_2964();
    var_1 _id_07B4::_id_2962(var_5._id_8F9C, var_5.origin);

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(var_1._id_74C6) && var_1._id_74C6["assists"] == 2) {
      var_1 thread _id_0A9F::_id_6FF6("assist_hardline", var_3, 1);
    }
  }

  var_17 = scripts\mp\tweakables::_id_6E14("game", "deathpointloss");

  if(var_1 scripts\mp\utility\perk::_hasperk("specialty_brawler") && var_4 == "MOD_MELEE") {
    var_1 notify("begin_regeneration");
  }

  if(var_1._id_0133 _meth_8624("gunperk_frenzy")) {
    var_1 notify("begin_regeneration");
  }

  if(var_1._id_0133 _meth_8624("gunperk_unmarked")) {
    var_18 = 0;

    foreach(var_20 in var_1._id_1DDE) {
      if(var_20 == var_5) {
        var_18 = 1;
        break;
      }
    }

    if(!var_18) {
      var_1 _id_0A6B::_id_19CD();
    }
  }

  if(isDefined(level._id_731C) && level._id_731C == var_1) {
    level notify("ai_killed", self);
  }

  scripts\mp\gamescore::_id_0CEE(self, scripts\mp\gamescore::_id_0C06(self) - var_17);
  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_1);
  level notify("player_killed", var_5, var_1);
  var_1 notify("killed_enemy");

  if(istrue(var_1.inlaststand)) {
    var_1 thread _id_07E8::_id_AB1E(var_7);
  }

  if(isDefined(level._id_AB3F) && (isDefined(var_1.pers) && var_1.pers["team"] != "spectator") && !istrue(level.ignorescoring)) {
    [[level._id_AB3F]](self, var_1, var_0, var_4, var_3, var_6);
  }

  if(!var_1 scripts\mp\utility\player::_id_8ACE()) {
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "killfirm_infantry", undefined, 0.75);
  }

  var_22 = undefined;

  switch (var_5._id_965F) {
    case "archetype_assault":
      var_22 = "plr_killfirm_warfighter";
      break;
  }

  if(isDefined(var_22)) {
    level thread scripts\mp\battlechatter_mp::_id_CB70(var_1, var_22, "plr_killfirm_generic", 0.75);
  }

  if(isDefined(self._id_8F8F) && isDefined(self._id_8F90) && self._id_8F8F != var_1) {
    if(gettime() - self._id_8F90 < 2500) {
      self._id_8F8F thread scripts\mp\gamescore::_id_BD7E(self);
    } else if(isalive(self._id_8F8F) && gettime() - self._id_8F90 < 5000) {
      var_23 = vectornormalize(anglesToForward(self.angles));
      var_24 = vectornormalize(self._id_8F8F.origin - self.origin);

      if(vectordot(var_24, var_23) > 0.925) {
        self._id_8F8F thread scripts\mp\gamescore::_id_BD7E(self);
      }
    }
  }

  if(!scripts\mp\utility\game::_id_CA4B()) {
    scripts\mp\gamescore::_id_1FC3(var_1, self);
  }

  var_25 = 1;

  if(isDefined(self._id_1DDE)) {
    foreach(var_20 in self._id_1DDE) {
      if(!isDefined(_id_0A8B::_id_0DB6(var_20))) {
        continue;
      }
      if(var_20 == var_1) {
        continue;
      }
      if(self == var_20) {
        continue;
      }
      if(isDefined(level._id_1D2C)) {
        continue;
      }
      var_27 = undefined;

      if(isDefined(self._id_1DD4)) {
        var_28 = self._id_1DD4[var_20.guid];

        if(isDefined(var_28)) {
          var_27 = var_28.objweapon;
        }
      }

      var_29 = 0;

      if(self._id_1DD4[var_20.guid].damage >= 35) {
        var_29 = 1;
      }

      if(self._id_1DD4[var_20.guid].damage >= 70) {
        var_29 = 2;
      }

      var_20 thread scripts\mp\gamescore::_id_BD5D(self, var_27, var_29);
      var_25 = 0;

      if(var_20 scripts\mp\utility\perk::_hasperk("specialty_boom")) {
        var_5 thread _id_0A6B::_id_D4A2(var_20);
      }
    }
  }

  if(isDefined(var_1.pers["soloKills"]) && var_25 && var_1.team != var_5.team) {
    var_1 scripts\mp\utility\stats::_id_7DAE("soloKills", 1);
  }

  if(isDefined(self._id_9B35)) {
    foreach(var_20 in level.players) {
      if(var_20.team == self.team) {
        continue;
      }
      if(scripts\engine\utility::array_contains(self._id_1DDE, var_20)) {
        continue;
      }
      if(scripts\engine\utility::_id_1BA1(self._id_9B35, var_20 scripts\mp\utility\player::getuniqueid())) {
        var_20 thread scripts\mp\gamescore::_id_BD5D(self, var_3);
      }
    }
  }

  if(level.teambased) {
    if(isDefined(var_1.team) && isDefined(level._id_F8F8) && isDefined(level._id_F8F8[var_1.team]) && level._id_F8F8[var_1.team].size > 0) {
      var_33 = [];

      foreach(var_35 in level._id_F8F8[var_1.team]) {
        if(isDefined(var_35) && isDefined(var_35.owner) && var_35.owner != var_1 && !scripts\engine\utility::array_contains(var_33, var_35._id_F904)) {
          var_36 = var_35._id_F904 + "_assist";
          var_37 = undefined;

          if(!isDefined(var_35._id_1D2D)) {
            var_35._id_1D2D = 0;
          }

          var_38 = scripts\engine\utility::ter_op(var_35._id_F904 == "directional_uav", 15, 10);

          if(var_35._id_1D2D < var_38) {
            var_35.owner thread _id_0A9F::_id_7003(var_36, undefined, var_37, undefined, undefined, undefined, var_35.streakinfo);
          } else {
            var_35.owner thread _id_0A9F::_id_700C(var_36, var_37);
          }

          var_35._id_1D2D++;

          switch (var_35._id_F904) {
            case "uav":
              var_35.owner scripts\mp\utility\stats::_id_7DAE("killstreakUAVAssists", 1);
              break;
            case "directional_uav":
              var_35.owner scripts\mp\utility\stats::_id_7DAE("killstreakAUAVAssists", 1);
              break;
          }

          var_33[var_33.size] = var_35._id_F904;
          _id_07BC::_id_BD85(var_35.owner, var_35._id_F904);
          var_35.owner scripts\mp\utility\script::_id_2C9F("update_uav_assist_buffered");
          var_35.owner _id_3ABD(var_35._id_F904);
        }
      }
    }

    if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
      foreach(var_41 in level._id_EB9A) {
        if(level.teambased && var_41.team == var_1.team && var_41.owner != var_1) {
          if(isDefined(var_41._id_5377) && isDefined(var_41._id_5377[self getentitynumber()])) {
            var_41.owner thread _id_0A9F::_id_7003(var_41.streakinfo.streakname + "_assist");
          }
        }

        if(var_41._id_786F == "scrambler_drone_guard") {
          if(var_1 != var_41.owner) {
            var_36 = var_41.streakinfo.streakname + "_assist";

            if(!isDefined(var_41._id_1D2D)) {
              var_41._id_1D2D = 0;
            }

            if(var_41._id_1D2D < 10) {
              var_41.owner thread _id_0A9F::_id_7003(var_36, undefined, undefined, undefined, undefined, undefined, var_41.streakinfo);
            } else {
              var_41.owner thread _id_0A9F::_id_700C(var_36);
            }

            var_41._id_1D2D++;
            var_41.owner scripts\mp\utility\stats::_id_7DAE("killstreakCUAVAssists", 1);
          }
        }
      }
    }

    if(isDefined(var_1.team) && isDefined(level._id_0F6C) && level._id_0F6C.size > 0) {
      var_43 = level._id_0F6C[0];
      var_44 = var_43.owner;
      var_45 = var_43.team;

      if(var_1.team == var_45 && var_1 != var_44) {
        if(istrue(var_5._id_10F9F) || istrue(var_5._id_10F9D)) {
          var_36 = "white_phosphorus_assist";

          if(!isDefined(var_43._id_1D2D)) {
            var_43._id_1D2D = 0;
          }

          if(var_43._id_1D2D < 15) {
            var_44 thread _id_0A9F::_id_7003(var_36, undefined, undefined, undefined, undefined, undefined, var_43.streakinfo);
          } else {
            var_44 thread _id_0A9F::_id_700C(var_36);
          }

          var_43._id_1D2D++;
          var_44 scripts\mp\utility\stats::_id_7DAE("killstreakWhitePhosphorousKillsAssists", 1);
        }
      }
    }
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_killed_player", self getentitynumber());
    var_1 setclientomnvar("ui_killed_player_notify", gettime());
  }
}

_id_B6DC() {
  var_0 = self;
  var_0 _id_0804::_id_116A(1, "combatStats", "kills");

  if(var_0.pers["kills"] < 14999) {
    var_0 scripts\mp\utility\stats::_id_7DAE("kills", 1);
    var_0._id_0267 = var_0 scripts\mp\utility\stats::_id_6C29("kills");
    var_0 scripts\mp\persistence::_id_E770("round", "kills", var_0._id_0267, level._id_7D29);
  }
}

_id_2F3C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_B6F7(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0);
}

_id_90FE(var_0, var_1) {
  if(_id_080B::_id_C87D()) {
    if(isDefined(self._id_C887)) {
      _id_080B::_id_C878(1);
    }

    if(isDefined(self._id_C888)) {
      _id_080B::_id_C878(0);
    }
  }
}

_id_C639() {
  self._id_EC33 = undefined;
  self._id_8BDA = undefined;
  self._id_916E = undefined;
  self.pers["cur_kill_streak"] = 0;
  self._id_8D6F = 0;
  _id_07D6::_id_4890();
}

_id_C635() {
  scripts\mp\playerlogic::_id_C651();
  self setclientomnvar("ui_life_kill_count", 0);
  self setclientomnvar("ui_shrapnel_overlay", 0);
}

_id_79AA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;

  if(!getdvarint("#x376b80553bab6c03c")) {
    return;
  }
  if(!isDefined(var_0._id_79AB)) {
    for(var_6 = 0; var_6 < 6; var_6++) {
      var_0 setclientdvar(_func_0483("#x3ed4086fbf94d8a6f", scripts\engine\utility::_id_EA52(var_6)), "");
    }

    var_0._id_79AB = 1;
  }

  if(level.splitscreen || !isPlayer(var_0)) {
    return;
  }
  var_7 = 6;

  if(!isDefined(var_0._id_4308)) {
    var_0._id_4308 = [];

    for(var_6 = 0; var_6 < var_7; var_6++) {
      var_0._id_4308[var_6] = spawnStruct();
      var_0._id_4308[var_6].damage = 0;
      var_0._id_4308[var_6]._id_79A8 = "";
      var_0._id_4308[var_6]._id_2992 = 0;
      var_0._id_4308[var_6]._id_3A80 = 0;
    }

    var_0._id_4309 = 0;
    var_0._id_430A = undefined;
  }

  for(var_6 = var_7 - 1; var_6 > 0; var_6--) {
    var_0._id_4308[var_6].damage = var_0._id_4308[var_6 - 1].damage;
    var_0._id_4308[var_6]._id_79A8 = var_0._id_4308[var_6 - 1]._id_79A8;
    var_0._id_4308[var_6]._id_2992 = var_0._id_4308[var_6 - 1]._id_2992;
    var_0._id_4308[var_6]._id_3A80 = var_0._id_4308[var_6 - 1]._id_3A80;
  }

  var_0._id_4308[0].damage = var_2;
  var_0._id_4308[0]._id_79A8 = var_3;
  var_0._id_4308[0]._id_2992 = var_4 &level._id_7CA1;

  if(isDefined(var_0._id_430A) && var_0._id_430A != var_1) {
    var_0._id_4309++;

    if(var_0._id_4309 == var_5.size) {
      var_0._id_4309 = 0;
    }
  }

  var_0._id_430A = var_1;
  var_0._id_4308[0]._id_3A80 = var_0._id_4309;

  for(var_6 = 0; var_6 < var_7; var_6++) {
    var_8 = "^" + var_5[var_0._id_4308[var_6]._id_3A80];

    if(var_0._id_4308[var_6]._id_79A8 != "") {
      var_9 = var_8 + var_0._id_4308[var_6]._id_79A8;

      if(var_0._id_4308[var_6]._id_2992) {
        var_9 = var_9 + " (BP)";
      }

      var_0 setclientdvar(_func_0483("#x3ed4086fbf94d8a6f", scripts\engine\utility::_id_EA52(var_6)), var_9);
    }

    var_0 setclientdvar(_func_0483("#x317c78c131e1781b3", scripts\engine\utility::_id_EA52(var_6)), var_8 + var_0._id_4308[var_6].damage);
  }
}

_id_6FE0() {
  self endon("death_or_disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self._id_C0FB++;
  wait 20.0;
  self._id_C0FB = 0;
}

_id_FC8F(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0._id_1645) || !var_0._id_1645 || !scripts\mp\utility\weapon::_id_8A38(var_2)) {
    scripts\mp\gamelogic::_id_D5B9(var_0, var_1, var_2);
  }

  if(isDefined(var_0)) {
    var_0._id_1645 = 1;
  }
}

_id_108F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_0._id_1DD4)) {
    var_0._id_1DD4 = [];
  }

  if(!isDefined(var_0._id_1DD4[var_1.guid])) {
    var_0._id_1DDE[var_1.guid] = var_1;
    var_0._id_1DD4[var_1.guid] = spawnStruct();
    var_0._id_1DD4[var_1.guid].damage = 0;
    var_0._id_1DD4[var_1.guid]._id_1DD6 = var_1;
    var_0._id_1DD4[var_1.guid]._id_5BE2 = gettime();
    var_0._id_1DD4[var_1.guid]._id_79A3 = 1;
  } else
    var_0._id_1DD4[var_1.guid]._id_79A3++;

  if(scripts\mp\utility\weapon::_id_879A(var_3) && !scripts\mp\utility\weapon::_id_879C(var_3)) {
    var_0._id_1DD4[var_1.guid]._id_4968 = 1;
  }

  if(isDefined(var_9) && var_9 != "MOD_MELEE") {
    var_0._id_1DD4[var_1.guid]._id_4973 = 1;
  }

  var_10 = scripts\mp\utility\weapon::_id_6A18(var_3.basename);

  if(isDefined(var_10)) {
    if(var_10 == "lethal") {
      var_0._id_1DD4[var_1.guid]._id_4967 = 1;
    }

    if(var_10 == "tactical") {
      var_0._id_1DD4[var_1.guid]._id_4969 = 1;
    }

    if(level.teambased) {
      if(var_1.team != var_0.team) {
        var_1 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_010");
      }
    } else if(var_1 != var_0)
      var_1 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_010");
  }

  var_0._id_1DD4[var_1.guid].damage = var_0._id_1DD4[var_1.guid].damage + var_4;
  var_0._id_1DD4[var_1.guid]._id_04F6 = getcompleteweaponname(var_3);
  var_0._id_1DD4[var_1.guid].objweapon = var_3;
  var_0._id_1DD4[var_1.guid]._id_106B7 = var_5;
  var_0._id_1DD4[var_1.guid]._id_FFD4 = var_6;
  var_0._id_1DD4[var_1.guid]._id_D9E0 = var_7;
  var_0._id_1DD4[var_1.guid]._id_0354 = var_8;
  var_0._id_1DD4[var_1.guid]._id_DE2B = var_9;
  var_0._id_1DD4[var_1.guid]._id_1DD6 = var_1;
  var_0._id_1DD4[var_1.guid]._id_90A7 = gettime();

  if(isDefined(var_2) && !isPlayer(var_2) && isDefined(var_2._id_034C)) {
    var_0._id_1DD4[var_1.guid]._id_E44C = var_2._id_034C;
  } else if(isDefined(var_1) && isPlayer(var_1) && !isnullweapon(var_1 getcurrentprimaryweapon())) {
    var_0._id_1DD4[var_1.guid]._id_E44C = getcompleteweaponname(var_1 getcurrentprimaryweapon());
  } else {
    var_0._id_1DD4[var_1.guid]._id_E44C = undefined;
  }
}

_id_1090(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_0._id_1DD4)) {
    var_0._id_1DD4 = [];
  }

  if(!isDefined(var_0._id_1DD4[var_2.guid])) {
    var_0._id_1DDE[var_2.guid] = var_2;
    var_0._id_1DD4[var_2.guid] = spawnStruct();
    var_0._id_1DD4[var_2.guid].damage = 0;
    var_0._id_1DD4[var_2.guid]._id_1DD6 = var_2;
    var_0._id_1DD4[var_2.guid]._id_5BE2 = gettime();
    var_0._id_1DD4[var_2.guid]._id_79A3 = 1;
  }

  var_0._id_1DD4[var_2.guid].damage = var_0._id_1DD4[var_2.guid].damage + var_1;
  var_0._id_1DD4[var_2.guid]._id_04F6 = var_10;
  var_0._id_1DD4[var_2.guid]._id_106B7 = var_4;
  var_0._id_1DD4[var_2.guid]._id_FFD4 = var_3;
  var_0._id_1DD4[var_2.guid]._id_031A = var_8;
  var_0._id_1DD4[var_2.guid]._id_DE2B = var_5;
  var_0._id_1DD4[var_2.guid]._id_1DD6 = var_2;
  var_0._id_1DD4[var_2.guid]._id_90A7 = gettime();

  if(isDefined(var_2) && isPlayer(var_2) && !isnullweapon(var_2 getcurrentprimaryweapon())) {
    var_0._id_1DD4[var_2.guid]._id_E44C = getcompleteweaponname(var_2 getcurrentprimaryweapon());
  } else {
    var_0._id_1DD4[var_2.guid]._id_E44C = undefined;
  }
}

_id_C602() {
  self._id_1DDE = [];
  self._id_1DD4 = [];
}

_id_C4F5() {
  self endon("damage");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!isDefined(self._id_1DDE)) {
    return;
  }
  for(;;) {
    var_0 = gettime();

    foreach(var_3, var_2 in self._id_1DDE) {
      if(isDefined(var_2) && var_0 - self._id_1DD4[var_3]._id_90A7 < 2000) {
        continue;
      }
      self._id_1DDE[var_3] = undefined;
      self._id_1DD4[var_3] = undefined;
    }

    waitframe();
  }
}

_id_2F38(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  var_15 = gettime();
  _id_2F39(var_0, var_1, self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
}

_id_5B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = int(min(var_2, self.health));

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(_id_DBC2(self)) {
      var_1 scripts\mp\utility\stats::_id_7DAE("damage", var_13);

      if(isDefined(var_1.pers["friendlyDamageDone"]) && self.team == var_1.team) {
        var_1 scripts\mp\utility\stats::_id_7DAE("friendlyDamageDone", var_13);
      }

      if(var_1 != self && self.team != var_1.team) {
        var_1 _id_07BF::_id_7D94(1, var_13);
      }

      if(var_8 == "head" && isDefined(var_1.pers["shotsHitHead"])) {
        var_1 scripts\mp\utility\stats::_id_7DAE("shotsHitHead", 1);
      }

      var_14 = scripts\mp\utility\weapon::_id_9ACB(var_5);
      var_15 = getcompleteweaponname(var_14);
      var_1 thread scripts\mp\gamelogic::_id_F13D(var_15, var_13, "damage_dealt");

      if(isDefined(var_1.pers["teamdamage"]) && self.team == var_1.team) {
        var_1 scripts\mp\utility\stats::_id_7DAE("teamdamage", var_13);

        if(isDefined(level.maxallowedteamdamagebeforekick) && level.maxallowedteamdamagebeforekick > 0 && var_1.pers["teamdamage"] >= level.maxallowedteamdamagebeforekick) {
          if(!istrue(var_1.hitffkicklimit)) {
            var_1.hitffkicklimit = 1;
            var_1 scripts\mp\hud_message::_id_DCA2("MP/FRIENDLY_FIRE_KICK_WARNING");
          } else if(istrue(var_1._id_3B81))
            kick(var_1 getentitynumber(), "EXE/PLAYERKICKED_TEAMDAMAGE");
        }
      }
    } else if(isDefined(level._id_AA74))
      var_1[[level._id_AA74]](var_13);
  }

  if(_id_DBC2(self)) {
    var_14 = self._id_8FC2;
    var_14 = scripts\mp\utility\weapon::_id_9ACB(var_14);
    var_15 = getcompleteweaponname(var_14);
    scripts\mp\utility\stats::_id_7DAE("damageTaken", var_13);
    thread scripts\mp\gamelogic::_id_F13D(var_15, 1, "hit_markers_taken");
    thread scripts\mp\gamelogic::_id_F13D(var_15, var_13, "damage_taken");
  }

  if(isDefined(var_0) && isDefined(var_0.streakinfo) && isDefined(var_0.streakinfo.damage)) {
    var_0.streakinfo.damage = var_0.streakinfo.damage + var_2;
  }

  if(_id_0A8B::_id_B7AF() && var_2 >= self.health && !(var_3 &level._id_7CA8) && _id_15B6()) {
    if(!isDefined(var_7)) {
      var_7 = (0, 0, 0);
    }

    if(!isDefined(var_1)) {
      var_1 = self;
    }

    if(!isDefined(var_0)) {
      var_0 = var_1;
    }

    _id_B6F7(var_0, var_1, self, var_2, var_3, var_4, var_5, var_7, var_8, var_9, 0, 1);
  } else {
    if(!_id_2F33(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    if(isPlayer(self)) {
      if(!isDefined(var_11)) {
        var_11 = "";
      }

      if(!isDefined(var_12)) {
        var_12 = 0;
      }

      if(var_5 _meth_8624("gunperk_silentfocus")) {
        var_16 = 1;
      } else {
        var_16 = 0;
      }

      if(_id_DC02(var_4)) {
        var_3 = var_3 | level._id_7CA3;
      }

      if(scripts\mp\utility\game::getgametype() == "br") {
        var_12 = 0;
      }

      var_17 = !(var_4 != "MOD_TRIGGER_HURT" && isDefined(self._id_8901));

      if(isDefined(var_1) && isPlayer(var_1) && var_1 != self) {
        if(!isDefined(var_1.firstdamagedeliveredtime)) {
          var_14 = scripts\mp\utility\weapon::_id_9ACB(var_5);
          var_15 = getcompleteweaponname(var_14);
          var_18 = getweaponbasename(var_15);
          var_1.firstdamagedeliveredtime = gettime();
          var_1.firstdamagedeliveredtype = var_4;
          var_1.firstdamagedeliveredweapon = var_18;
        }
      }

      if(!isDefined(self.firstdamagereceivedtime)) {
        var_14 = scripts\mp\utility\weapon::_id_9ACB(var_5);
        var_15 = getcompleteweaponname(var_14);
        var_18 = getweaponbasename(var_15);
        self.firstdamagereceivedtime = gettime();
        self.firstdamagereceivedtype = var_4;
        self.firstdamagereceivedweapon = var_18;

        if(getdvarint("#x3786b1d0072bbf7c0", 0)) {
          _id_0818::badspawntimeout(self);
        }
      }

      self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11, var_12, var_17, var_16);
    }
  }

  if(var_4 == "MOD_EXPLOSIVE_BULLET") {
    _id_09C8::_id_0CF9("damage_mp", "damage", getdvarfloat("#x3dcfe2cb7ce9860c4"), 0, 0);
  }

  _id_4327(var_0, var_5, var_4, var_2, var_3, var_1);
}

_id_DC02(var_0) {
  return var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_FIRE";
}

_id_2F3B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\mp\weapons::_id_7D5B(var_0, self, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_15B6() {
  if(!isDefined(level._id_15B6)) {
    level._id_15B6 = 1;
  }

  return level._id_15B6;
}

_id_2F3D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = _id_8867(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6);

  if(!istrue(var_9)) {
    if(scripts\mp\utility\game::getgametype() != "br" && !istrue(self._id_8DD9) && (var_3 == "MOD_MELEE" && var_4.basename != "s4_fists_mp" && var_4.basename != "s4_fists_mp_ls")) {
      return 0;
    }

    if(var_3 == "MOD_EXECUTION") {
      return 0;
    }

    if(scripts\mp\utility\game::getgametype() != "br" && _id_0A8B::_id_8891(var_4.basename, var_6, var_3, var_1)) {
      return 0;
    }

    if(scripts\mp\utility\game::getgametype() != "br" && _func_010F(var_3)) {
      return 0;
    }

    if(istrue(self._id_7263)) {
      return 0;
    }

    if(isDefined(var_1) && (isDefined(var_1.classname) && var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn")) {
      return 0;
    }

    if(var_1 == self && scripts\mp\utility\game::getgametype() != "br") {
      return 0;
    }
  }

  if(isDefined(level._id_AE36)) {
    self[[level._id_AE36]]();
  }

  if(self isskydiving()) {
    self _meth_86B4();
  }

  var_10 = self._id_9BC0;

  if(!isDefined(var_10)) {
    var_10 = level._id_9C84 - 1;
  }

  if(isDefined(var_1) && var_1.classname != "worldspawn") {
    if(!isPlayer(var_1)) {
      if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
        var_1 = var_1.owner;
      } else if(isDefined(var_0) && isDefined(var_0.owner) && isPlayer(var_0.owner)) {
        var_1 = var_0.owner;
      }
    }

    var_11 = _id_09BF::_id_ADCA(var_1, self, var_2, var_4, var_3, var_0, undefined, var_5, undefined, var_6, undefined, undefined);
    var_11._id_9078 = 1;
    self._id_B6BF = 1;

    if(isPlayer(var_1) && var_1 != self) {
      self._id_9060 = var_1;
      self._id_907C = var_11._id_9CD6;
      self._id_9096 = var_4;
    }

    _id_B6F3(var_11);
    self._id_8F9C = _id_07B4::_id_B6B6();
    _id_07B4::_id_B766();
    _id_07B4::_id_B767();
    var_11._id_886D = _id_886D(self, var_1);

    if(!var_11._id_886D && var_1 != self) {
      if(scripts\mp\utility\game::getgametype() == "br") {
        if(isPlayer(var_1) && var_1 != self) {
          var_1 scripts\mp\gametypes\br_public::_id_7DF3();
          var_1 thread scripts\mp\rank::_id_CC00("downed");
        }

        if(isDefined(level._id_2A1B) && isDefined(level._id_2A1B._id_372F)) {
          var_12 = min(max(1, level._id_2A1B._id_372F), 6);
          var_13 = "br_downEnemy_circle_" + scripts\engine\utility::_id_EA52(var_12);

          if(scripts\mp\rank::_id_89F5(var_13)) {
            var_1 thread _id_0A9F::_id_7003(var_13, var_4);
          }
        }
      }
    }
  }

  scripts\common\utility::_id_158B(0);
  scripts\common\utility::_id_152F(0);

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    scripts\mp\gametypes\br_plunder::_id_B92B(self, 0, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_analytics::_id_2AEB(var_1, self, var_4, "downed");

    if(var_3 == "MOD_CRUSH" && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {}
  }

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    if(isDefined(var_1) && isPlayer(var_1) && !isbot(var_1)) {
      var_1 notify("enemy_in_laststand");
    }
  }

  var_14 = 0;

  if(istrue(level._id_8304) && level.gametype == "br" && !istrue(self._id_75AF)) {
    if(getDvar("#x3f59526763711edc4", "") == "dmz") {
      if(level._id_EF6A[self.team]["alivePlayers"].size == 1) {
        var_14 = 1;
      }

      if(!var_14) {
        var_15 = 0;

        foreach(var_17 in level._id_EF6A[self.team]["players"]) {
          if(self != var_17 && (istrue(var_17.inlaststand) || !isalive(var_17)) && !istrue(var_17._id_75AF)) {
            var_15++;
          }
        }

        if(var_15 == level._id_EF6A[self.team]["players"].size - 1) {
          var_14 = 1;

          foreach(var_17 in level._id_EF6A[self.team]["players"]) {
            if(var_17 != self) {
              var_17 notify("squad_wipe_death");
              var_17._id_E4B5 = 1;
              var_17 _id_0A8B::_id_0D8A();
            }
          }
        }
      }

      if(var_14) {
        if(scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::_id_6D9E() == "dmz") {
          var_21 = scripts\mp\gametypes\br_quest_util::_id_68A3(self.team);

          if(isDefined(var_21) && var_21.size > 0) {
            foreach(var_23 in var_21) {
              var_23._id_82FC scripts\mp\gametypes\br_quest_util::_id_C50F();
            }
          }

          if(isPlayer(var_1) && var_1 != self) {
            var_1 thread _id_07CE::_id_8D83("team_wiped", 0);
            var_1 thread _id_0A9F::_id_7003("team_wiped", var_4);
          }
        }

        self._id_E4B5 = 1;
        return 0;
      }
    }
  }

  if(isDefined(level._id_350B)) {
    if([[level._id_350B]](self)) {
      return 0;
    }
  }

  thread _id_07E8::_id_908D();
  return 1;
}

_id_8867(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = 0;

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(scripts\mp\gametypes\br_public::_id_8AB8()) {
      return 1;
    }

    if(isDefined(var_2) && isPlayer(var_2) && var_2 != var_0 && !istrue(var_2._id_7262)) {
      var_2 thread scripts\mp\hud_message::showsplash("br_enemy_downed", undefined, var_0);
    }

    if(var_4 == "MOD_FALLING" && !istrue(self._id_7263)) {
      var_8 = 1;
    }
  }

  if(istrue(self._id_8DD9) && isDefined(level._id_8DB6)) {
    var_8 = 1;
  }

  return var_8;
}

_id_6AA4(var_0) {
  switch (var_0) {
    case "neck":
    case "head":
    case "helmet":
      return 60;
    case "left_hand":
    case "right_hand":
    case "right_arm_lower":
    case "torso_upper":
    case "right_arm_upper":
    case "left_arm_lower":
    case "left_arm_upper":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "left_leg_upper":
    case "right_leg_upper":
      return 32;
    case "right_leg_lower":
    case "left_leg_lower":
      return 10;
    case "right_foot":
    case "left_foot":
      return 5;
  }

  return 48;
}

_id_4327(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread scripts\mp\weapons::_id_ABD9(var_0, var_1, var_2, var_3, var_5);

  if(!isai(self) && scripts\common\utility::_id_69C4(var_2) != "bullet") {
    self playrumbleonentity("damage_heavy");
  }
}

_id_2F33(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return 1;
}

_id_517E(var_0) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
}

_id_60D1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_2) && isPlayer(var_2) && isalive(var_2)) {
    if(level._id_9BEB) {
      var_3 = var_3 * level._id_9BEB;
    }

    if(level._id_9BF0) {
      var_2.health = int(min(float(var_2.maxhealth), min(var_2.health + var_3, float(var_2.health + 20))));
      var_2 notify("vampirism");
    }

    if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
      var_11 = weaponclass(var_5);

      switch (var_8) {
        case "neck":
        case "head":
        case "helmet":
          if(var_11 != "spread" && var_5.basename != "s4_firebombing_run_mp") {
            var_3 = var_3 * 2.7;
          }

          break;
        case "torso_upper":
          break;
        case "left_hand":
        case "right_hand":
        case "right_arm_lower":
        case "right_arm_upper":
        case "left_arm_lower":
        case "left_arm_upper":
        case "gun":
          break;
        case "torso_lower":
          break;
        case "left_leg_upper":
        case "right_leg_upper":
          break;
        case "right_leg_lower":
        case "right_foot":
        case "left_foot":
        case "left_leg_lower":
          break;
      }
    }

    if(istrue(game["isLaunchChunk"])) {
      if(game["launchChunkRuleSet"] == 0 || game["launchChunkRuleSet"] == 3) {
        if(!isbot(var_1)) {
          if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_HEAD_SHOT") {
            var_12 = 80;

            if(!isPlayer(var_2) || !isPlayer(var_1)) {
              return 0;
            }

            var_13 = var_1 getplayerangles();
            var_14 = var_2 getplayerangles();
            var_15 = _func_000B(var_13[1] - var_14[1]);

            if(abs(var_15) < var_12) {
              var_3 = var_3 * 0.3;
            }
          }
        }
      }
    }
  }

  return var_3;
}

_id_C269(var_0, var_1, var_2, var_3) {
  self._id_8D6F++;
  self.pers["cur_kill_streak"]++;
  self setclientomnvar("ui_life_kill_count", self._id_8D6F);
}

_id_A0FF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 2147483647;
  self.maxhealth = var_0;

  if(!isDefined(self._id_014E) || istrue(var_6)) {
    self._id_014E = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_8 = 1;

  while(var_8) {
    self waittill("damage", var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23);
    var_9 = scripts\mp\weapons::launcherbackblast_modifieddamage(self, var_18, var_22, var_13, var_9);

    if(var_9 == 0) {
      continue;
    }
    var_18 = scripts\mp\utility\weapon::_id_9ACB(var_18, var_22);

    if(var_5) {
      self playrumbleonentity("damage_light");
    }

    if(var_4) {
      var_24 = "none";

      if(isDefined(var_18)) {
        var_24 = getcompleteweaponname(var_18);
      }

      _id_9757(self, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_24);
    }

    var_8 = _id_A101(var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_22, var_1, var_2, var_3, var_4, var_23, var_7);
  }
}

_id_A100() {
  self notify("monitorDamageEnd");
  self._id_014E = undefined;
  self._id_1DDE = undefined;
  self._id_10A0C = undefined;
  self._id_10A0F = undefined;
  self._id_10A10 = undefined;
  self setCanDamage(0);
}

_id_A101(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  if(!isDefined(self)) {
    return 0;
  }

  if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(isDefined(var_1) && !scripts\mp\utility\entity::_id_8877(var_1) && !istrue(var_1._id_AD49)) {
    return 1;
  }

  if(isDefined(var_1) && !scripts\mp\weapons::_id_5FB2(self.owner, var_1)) {
    if(isDefined(self._id_5562) && self._id_5562 == "equip_tac_cover") {} else
      return 1;
  }

  var_17 = var_0;

  if(_id_0A8B::_id_A5A7(var_1, var_9, var_10, var_4)) {
    return 1;
  }

  if(isDefined(var_9)) {
    var_18 = _id_09BF::_id_ADCA(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

    if(!isDefined(var_13)) {
      var_13 = ::_id_A007;
    }

    var_17 = self[[var_13]](var_18);

    if(var_9.basename != "none") {
      var_17 = var_17 * _func_0490(var_9);
    }
  }

  if(var_17 <= 0) {
    return 1;
  }

  self._id_10A0C = 1;
  self._id_014E = self._id_014E + var_17;
  self.health = 2147483647;

  if(isDefined(var_8) && var_8 &level._id_7CA1) {
    self._id_10A0F = 1;
  }

  if(isDefined(var_8) && var_8 &level._id_7CA3) {
    self._id_10A10 = 1;
  }

  if(istrue(var_14)) {
    scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_9, self, var_4, var_17);
  }

  if(isDefined(var_1)) {
    if(isPlayer(var_1)) {
      var_1 _id_07C4::_id_FC47(var_11, undefined, undefined, var_16, undefined, undefined, var_15);
    }
  }

  if(self._id_014E >= self.maxhealth) {
    var_18 = _id_09BF::_id_ADCA(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_18);
    return 0;
  }

  return 1;
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C96;

  if(isDefined(var_5) && (var_5 && level._id_7CA3)) {
    var_6 = 0.6 * var_4;
  } else {
    var_6 = var_4;
  }

  var_6 = _id_743D(var_2, var_3, var_6);
  var_6 = _id_746C(var_2, var_3, var_6);
  var_6 = _id_7453(var_2, var_3, var_6);
  var_6 = _id_741D(var_2, var_3, var_6);
  return var_6;
}

_id_746C(var_0, var_1, var_2) {
  var_3 = var_2;

  switch (var_0.basename) {
    case "heli_pilot_turret_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "bomb_site_mp":
      self._id_8EE2 = 0;
      var_3 = var_3 * 2;
      break;
    default:
      break;
  }

  return var_3;
}

_id_7453(var_0, var_1, var_2) {
  if(_func_010F(var_1)) {
    switch (var_0.basename) {
      case "s4_sticky_eng_n74_mp":
      case "s4_c4_mp":
        var_2 = var_2 * 3;
        break;
      case "bouncing_betty_mp":
      case "s4_frag_gbr_n82_mp":
      case "s4_frag_gbr_n23_mp":
      case "s4_bundle_charge_mp":
      case "s4_frag_ger_m24_mp":
      case "s4_semtex_mp":
      case "s4_frag_usa_mk2_mp":
        var_2 = var_2 * 4;
        break;
      default:
        if(var_0._id_0245) {
          var_2 = var_2 * 3;
        }

        break;
    }
  }

  return var_2;
}

_id_7468(var_0, var_1, var_2) {
  if(var_1 == "MOD_MELEE") {
    return self.maxhealth + 1;
  }

  return var_2;
}

_id_743D(var_0, var_1, var_2) {
  return var_2;
}

_id_741D(var_0, var_1, var_2, var_3) {
  var_4 = 1.0;
  var_5 = level._id_1B5C - 1;

  if(_id_0A8B::_id_8866(var_0, var_1)) {
    var_4 = var_4 + var_5;
  }

  var_6 = level._id_1B5D - 1;

  if(isDefined(var_3) && var_3 scripts\mp\utility\perk::_hasperk("specialty_armorpiercingks") && isDefined(self.streakname) && scripts\mp\utility\weapon::_id_89C7(var_0) && scripts\engine\utility::_id_8794(var_1)) {
    var_4 = var_4 + var_6;
  }

  return var_2 * var_4;
}

_id_7492(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return var_2;
  }

  if(var_0.basename == "none") {
    return var_2;
  }

  if(weaponclass(var_0) != "spread") {
    return var_2;
  }

  return int(min(150, var_2));
}

_id_AB13(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(isPlayer(var_1) && self.owner scripts\mp\utility\player::isenemy(var_1)) {
      var_4 = var_1;
    }
  }

  if(isDefined(var_4)) {
    thread _id_07BC::_id_8DCC(var_0, self.owner, var_4, var_2, var_3);
  }
}

_id_AB18(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = 0;
  var_10 = undefined;

  if(isDefined(var_1) && isDefined(self.owner)) {
    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1 = var_1.owner;
    }

    if(_func_011D(self.owner) && _func_011D(var_1)) {
      if(!_func_03D9(self.owner, var_1)) {
        var_10 = var_1;
      }
    } else if(self.owner scripts\mp\utility\player::isenemy(var_1))
      var_10 = var_1;
  }

  if(isDefined(var_10)) {
    if(isDefined(var_7)) {
      var_10 scripts\mp\battlechatter_mp::_id_8DCF(var_0);
    }

    thread _id_07CE::_id_8D7B(var_0, var_10, var_2);
    thread _id_07BC::createkillstreakchallengeevent(var_1, var_1, self, var_2, "killstreak_destroyed", var_0);
    thread _id_07BC::_id_8DD8(var_0, self.owner, self, var_10, var_4, var_3, var_2, var_5);
    _id_0793::_id_BD60(self, var_10);
    var_9 = 1;
  }

  thread _id_07CE::_id_BD7D(var_10);

  if(isDefined(self.owner) && isDefined(var_6)) {
    self.owner _id_0A8D::_id_B86E(var_6, undefined, undefined, self.origin);
  }

  if(!istrue(var_8)) {
    self notify("death");
  }

  return var_9;
}

_id_FC4B(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2) && isPlayer(var_2) && isDefined(var_2.health)) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      self setclientomnvar("ui_death_details_enemy_health", 0);
    } else {
      self setclientomnvar("ui_death_details_enemy_health", int(clamp(var_2.health, 0, var_2.maxhealth)) / var_2.maxhealth);
    }
  } else
    self setclientomnvar("ui_death_details_enemy_health", -1);

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_7, var_5 in var_0) {
      if(!isPlayer(var_5)) {
        continue;
      }
      var_6 = var_5 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_3, var_6);
      self setclientomnvar("ui_death_details_hits_" + var_3, int(min(var_1[var_7]._id_79A3, 10)));
      var_3++;

      if(var_3 >= 4) {
        break;
      }
    }
  }

  for(var_8 = var_3; var_8 < 4; var_8++) {
    self setclientomnvar("ui_death_details_attacker_" + var_8, -1);
  }
}

_id_D4FF(var_0) {
  var_1 = var_0._id_103C2;
  var_2 = 0;

  if(var_1 scripts\mp\playerlogic::_id_9CCD() && !level._id_4AE7) {
    var_3 = scripts\mp\playerlogic::_id_F287(1);
    var_4 = 1;

    if(scripts\mp\utility\game::privatematch()) {
      var_3 = var_3 + var_4;
    } else {
      var_5 = 2.25;
      var_3 = max(var_3 + var_4, var_5);
    }

    var_2 = var_3 + var_0._id_43FF;
  }

  var_1._id_0154 = int(var_2 * 10);
}

_id_6AB7(var_0) {
  switch (var_0) {
    case "torso_upper":
      return 0;
    case "torso_lower":
      return 1;
    case "helmet":
      return 2;
    case "head":
      return 3;
    case "neck":
      return 4;
    case "left_arm_upper":
      return 5;
    case "left_arm_lower":
      return 6;
    case "left_hand":
      return 7;
    case "right_arm_upper":
      return 8;
    case "right_arm_lower":
      return 9;
    case "right_hand":
      return 10;
    case "left_leg_upper":
      return 11;
    case "left_leg_lower":
      return 12;
    case "left_foot":
      return 13;
    case "right_leg_upper":
      return 14;
    case "right_leg_lower":
      return 15;
    case "right_foot":
      return 16;
    case "gun":
      return 17;
    case "none":
      return 18;
  }

  return 0;
}

_id_DCF9() {
  self setclientomnvar("ui_damage_event", self._id_42FB);
}

_id_FC37(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  if(isDefined(var_0) && isPlayer(var_0) && var_0 != var_1) {
    var_0 _id_3AB9(var_0._id_965F);

    if(isDefined(var_3)) {
      var_4 = scripts\mp\utility\weapon::_id_6A18(var_3.basename);

      if(isDefined(var_4) && var_4 == "lethal") {
        var_5 = scripts\mp\equipment::_id_6A14(var_3);
        var_0 _id_3ABF(var_5);
      } else {
        var_6 = scripts\mp\utility\killstreak::_id_6AE7(var_3);

        if(isDefined(var_6)) {
          if(_func_030C("mp", "LethalScorestreakStatItems", var_6)) {
            var_0 _id_3ABD(var_6);
          }
        }

        if(istrue(var_0._id_B028)) {
          var_0 _id_3AC3("power_periphVis");
        }

        if(istrue(var_0._id_11B4)) {
          var_0 _id_3AC3("power_adrenaline");
        }
      }
    }
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 _id_3AB8(var_1._id_965F);
  }
}

_id_3AB9(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata(level.progressiongroup, "playerStats", "archetypeStats", var_0, "kills");
  self setplayerdata(level.progressiongroup, "playerStats", "archetypeStats", var_0, "kills", var_1 + 1);
}

_id_3AB8(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata(level.progressiongroup, "playerStats", "archetypeStats", var_0, "deaths");
  self setplayerdata(level.progressiongroup, "playerStats", "archetypeStats", var_0, "deaths", var_1 + 1);
}

_id_3ABA(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = scripts\mp\equipment::_id_8836(var_0);

  if(var_1) {
    var_2 = self getplayerdata(level.progressiongroup, "playerStats", "lethalStats", var_0, "uses");
    self setplayerdata(level.progressiongroup, "playerStats", "lethalStats", var_0, "uses", var_2 + 1);
  } else {
    var_2 = self getplayerdata(level.progressiongroup, "playerStats", "tacticalStats", var_0, "uses");
    self setplayerdata(level.progressiongroup, "playerStats", "tacticalStats", var_0, "uses", var_2 + 1);
  }
}

_id_3ABF(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = self getplayerdata(level.progressiongroup, "playerStats", "lethalStats", var_0, "kills");
  self setplayerdata(level.progressiongroup, "playerStats", "lethalStats", var_0, "kills", var_1 + 1);
}

_id_3AC3(var_0, var_1) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = self getplayerdata(level.progressiongroup, "playerStats", "tacticalStats", var_0, "extraStat1");
  self setplayerdata(level.progressiongroup, "playerStats", "tacticalStats", var_0, "extraStat1", var_2 + var_1);
}

_id_3ABD(var_0) {
  if(!scripts\mp\utility\stats::_id_31BA()) {
    return;
  }
  var_1 = scripts\mp\utility\stats::_id_6D95(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = self getplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "extraStat1");
  self setplayerdata(level.progressiongroup, "playerStats", var_1, var_0, "extraStat1", var_2 + 1);
}

_id_5466(var_0, var_1) {
  if(!isDefined(self._id_3D89)) {
    self._id_3D89 = [];
    self._id_3D88 = [];
  }

  if(!isDefined(self._id_3D89[var_0])) {
    self._id_3D89[var_0] = var_1;
    self._id_3D88[var_0] = 0;
  }

  self._id_3D88[var_0]++;
}

_id_47FD(var_0) {
  if(!isDefined(self._id_3D89)) {
    return;
  }
  if(!isDefined(self._id_3D89[var_0])) {
    return;
  }
  self._id_3D88[var_0]--;

  if(self._id_3D88[var_0] <= 0) {
    self._id_3D89[var_0] = undefined;
    self._id_3D88[var_0] = undefined;
  }
}

_id_2F5C() {
  if(!isDefined(self._id_3D89)) {
    return;
  }
  var_0 = self._id_25CA;

  foreach(var_2 in self._id_3D89) {
    self thread[[var_2]](var_0);
  }

  thread _id_392F();
}

_id_392F() {
  self notify("clearCorpsetableFuncs");
  self._id_3D89 = undefined;
  self._id_3D88 = undefined;
}

_id_5467(var_0, var_1, var_2, var_3, var_4) {}

startlistenforloadoutsave(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_listen_for_loadout_save");

  if(copyloadoutforvault(var_0)) {
    var_1 = self getplayerdata("common", "numCapturedLoadouts");
    var_1 = var_1 + 1;
    self setplayerdata("common", "numCapturedLoadouts", int(var_1));
    self setplayerdata("common", "capturedLoadout", "source", "game");
    self setclientomnvar("ui_loadout_saved", 1);
  } else {
    self setclientomnvar("ui_loadout_saved", 3);
    return;
  }

  while(self _meth_8765()) {
    waitframe();
  }

  while(!self _meth_8765()) {
    waitframe();
  }

  self setclientomnvar("ui_loadout_saved", 2);
}

stoplistenforloadoutsave() {
  self notify("stop_listen_for_loadout_save");
  self setclientomnvar("ui_loadout_saved", 0);
  self setplayerdata("common", "numCapturedLoadouts", 0);
}

copyloadoutforvault(var_0) {
  if(!isDefined(var_0._id_3808)) {
    return 0;
  }

  var_1 = var_0._id_3808;
  var_2 = 0;
  var_3 = 1;
  var_4 = 10;
  var_5 = 10;
  var_6 = 0;
  var_7 = 1;
  var_8 = 4;
  var_9 = var_0 getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", var_0._id_37FF, "name");
  self setplayerdata("common", "capturedLoadout", "name", var_9);
  self setplayerdata("common", "capturedLoadout", "authorName", var_0.name);
  self setplayerdata("common", "capturedLoadout", "authorXuidHigh", var_0 _meth_8585());
  self setplayerdata("common", "capturedLoadout", "authorXuidLow", var_0 _meth_8586());
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "weapon", var_1._id_9683);

  for(var_10 = 0; var_10 < var_4; var_10++) {
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "attachmentSetup", var_10, "attachment", var_1._id_9685[var_10]);
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "attachmentSetup", var_10, "variantID", var_1._id_9684[var_10]);
  }

  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "lootItemID", var_1._id_9689);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "variantID", var_1._id_968E);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "camo", var_1._id_9686);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "reticle", var_1._id_968C);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "cosmeticAttachment", var_1._id_9687);

  for(var_10 = 0; var_10 < var_8; var_10++) {
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_2, "sticker", var_10, var_1._id_968D[var_10]);
  }

  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "weapon", var_1._id_9692);

  for(var_10 = 0; var_10 < var_5; var_10++) {
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "attachmentSetup", var_10, "attachment", var_1._id_9694[var_10]);
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "attachmentSetup", var_10, "variantID", var_1._id_9693[var_10]);
    waitframe();
  }

  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "lootItemID", var_1._id_9698);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "variantID", var_1._id_969C);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "camo", var_1._id_9695);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "reticle", var_1._id_969A);
  self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "cosmeticAttachment", var_1._id_9696);

  for(var_10 = 0; var_10 < var_8; var_10++) {
    self setplayerdata("common", "capturedLoadout", "weaponSetups", var_3, "sticker", var_10, var_1._id_969B[var_10]);
  }

  self setplayerdata("common", "capturedLoadout", "equipmentSetups", var_6, "equipment", var_1._id_966A);
  self setplayerdata("common", "capturedLoadout", "equipmentSetups", var_6, "extraCharge", var_1._id_966E);
  self setplayerdata("common", "capturedLoadout", "equipmentSetups", var_7, "equipment", var_1._id_966B);
  self setplayerdata("common", "capturedLoadout", "equipmentSetups", var_7, "extraCharge", var_1._id_966F);

  for(var_10 = 0; var_10 < var_1._id_967F.size; var_10++) {
    self setplayerdata("common", "capturedLoadout", "loadoutPerks", var_10, var_1._id_967F[var_10]);
  }

  return 1;
}

_id_E693(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_copy_cat_option");

  if(!isDefined(var_0) || !isPlayer(var_0) || isbot(self)) {
    return;
  }
  while(self _meth_8765()) {
    waitframe();
  }

  while(!self _meth_8765()) {
    waitframe();
  }

  scripts\mp\class::_id_3D64(var_0);
}

_id_E905() {
  self notify("stop_copy_cat_option");
}

_id_8833(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0._id_00EC) && var_0._id_00EC == "scriptable") {
    switch (var_0.classname) {
      case "scriptable_rp_propane_tank_long_01":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_DBC2(var_0) {
  if(istrue(level._id_4A90)) {
    return 0;
  }

  if(isDefined(level._id_4A91) && ![[level._id_4A91]](var_0)) {
    return 0;
  }

  return 1;
}