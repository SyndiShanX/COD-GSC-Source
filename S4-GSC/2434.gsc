/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2434.gsc
*************************************************/

_id_7EC1(var_0) {
  var_1 = scripts\engine\utility::getstructarray("weapon_upgrade", "script_noteworthy");
  level._id_683F = scripts\cp\cp_weapon::_id_683D;

  foreach(var_3 in var_1) {
    var_3._id_BAD8 = 1;
    var_3 thread _id_80EE();
  }
}

_id_80EE() {
  if(istrue(self._id_C588)) {
    level scripts\engine\utility::waittill_any_2("power_on", self._id_BA97 + " power_on");
  }

  var_0 = getent("pap_machine", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(level._id_AE12)) {
    [[level._id_AE12]](self, var_0);
  } else {
    var_0 setscriptablepartstate("door", "open_idle");
    var_0 setscriptablepartstate("reels", "on");
    self._id_BAD8 = 1;
  }
}

_id_838C(var_0, var_1) {
  if(scripts\cp\utility::_id_857B()) {
    return;
  }
  var_1 thread _id_10D20(var_0);
}

_id_10D21(var_0, var_1) {
  if(istrue(var_1._id_10F45)) {
    return "";
  }

  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\cp_weapon::_id_683D(var_2);

  if(var_3 == level._id_AE11) {
    return &"COOP_INTERACTIONS/UPGRADE_MAXED";
  } else if(var_1 scripts\cp\utility::_id_8632(var_2, 1)) {
    return "";
  } else if(!scripts\cp\cp_weapon::_id_3101(var_2)) {
    return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL";
  } else if(var_3 == 1) {
    return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON";
  } else {
    return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_GENERIC";
  }

  return &"CP_ZMB_INTERACTIONS/UPGRADE_WEAPON_FAIL";
}

_id_10D20(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::_id_6CE3(var_2);
  var_4 = var_1 scripts\cp\cp_weapon::_id_683D(var_3);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = "none";
  var_8 = undefined;
  var_9 = 0;

  if(var_3 == "dischord" || var_3 == "facemelter" || var_3 == "headcutter" || var_3 == "shredder") {
    if(!scripts\engine\utility::_id_5C00("fuses_inserted")) {
      return;
    }
  }

  if(var_4 < level._id_AE11) {
    var_10 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_11 = vectornormalize(anglesToForward(var_1.angles)) * 16;
    _id_0737::_id_C3C5(var_0);
    var_12 = var_1 getweaponslistprimaries();
    var_1 _id_0741::_id_BD77("mt_upgrade_weapons");

    foreach(var_14 in var_12) {
      if(!issubstr(var_2.basename, var_14.basename) && (!var_14._id_0245 && !issubstr(var_14.basename, "knife"))) {
        var_5 = var_14;
        break;
      }
    }

    var_4 = int(var_4);
    var_4++;
    var_16 = var_2;

    if(isDefined(level._id_AE0B) && isDefined(var_4) && var_4 == 2) {
      var_8 = level._id_AE0B;
    } else if(isDefined(level._id_AE0C) && isDefined(var_4) && var_4 == 3) {
      var_8 = level._id_AE0C;
    }

    if(isDefined(level._id_A524) && scripts\engine\utility::array_contains(level._id_A524, var_3)) {
      var_8 = undefined;
    }

    if(var_4 == 2) {
      if(isDefined(var_3)) {
        switch (var_3) {
          case "dischord":
            var_2 = makeweapon("iw7_dischord_zm_pap1");
            var_8 = "camo20";
            break;
          case "facemelter":
            var_2 = makeweapon("iw7_facemelter_zm_pap1");
            var_8 = "camo22";
            break;
          case "headcutter":
            var_2 = makeweapon("iw7_headcutter_zm_pap1");
            var_8 = "camo21";
            break;
          case "shredder":
            var_2 = makeweapon("iw7_shredder_zm_pap1");
            var_8 = "camo23";
            break;
          default:
            break;
        }
      }
    }

    if(var_3 == "axe") {
      if(var_4 == 2) {
        var_2 = makeweapon("iw7_axe_zm_pap1");
      } else if(var_4 == 3) {
        var_2 = makeweapon("iw7_axe_zm_pap2");
      }

      var_9 = 1;
    }

    if(var_3 == "nunchucks") {
      if(var_4 == 2) {
        var_2 = makeweapon("iw7_nunchucks_zm_pap1");
      } else if(var_4 == 3) {
        var_2 = makeweapon("iw7_nunchucks_zm_pap2");
      }

      var_9 = 1;
    }

    if(var_3 == "katana") {
      if(var_4 == 2) {
        var_2 = makeweapon("iw7_katana_zm_pap1");
      } else if(var_4 == 3) {
        var_2 = makeweapon("iw7_katana_zm_pap2");
      }

      var_9 = 1;
    }

    if(var_3 == "forgefreeze") {
      if(var_4 == 2) {
        var_2 = makeweapon("iw7_forgefreeze_zm_pap1");
      } else if(var_4 == 3) {
        var_2 = makeweapon("iw7_forgefreeze_zm_pap2");
      }

      var_9 = 1;
    }

    level._id_F277++;
    _id_0995::_id_973C(level._id_10C9F, var_3, level._id_F277);
    var_1 _id_097F::_id_FB31("GET_PACKED", 1);
    var_1 thread _id_076F::_id_F72D("weapon_pap", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
    var_7 = _id_C77A(var_1, var_4, var_3, var_2);

    if(isDefined(var_7) && var_7 == "replace_me") {
      var_7 = undefined;
    }

    var_17 = getweaponattachments(var_2);

    if(issubstr(var_2.basename, "g18_z")) {
      foreach(var_19 in var_17) {
        if(issubstr(var_19, "akimbo")) {
          var_17 = scripts\engine\utility::array_remove(var_17, var_19);
        }
      }
    }

    var_21 = var_17;

    foreach(var_19 in var_21) {
      if(issubstr(var_19, "silencer") || issubstr(var_19, "arcane") || issubstr(var_19, "ark")) {
        var_21 = scripts\engine\utility::array_remove(var_21, var_19);
      }
    }

    var_2 = var_1 scripts\cp\cp_weapon::_id_C78E(var_2, undefined, var_21);
    var_24 = var_1 scripts\cp\cp_weapon::_id_C78E(var_2, var_7, var_21, undefined, var_8);
    var_25 = var_1 scripts\cp\cp_weapon::_id_C78E(var_2, var_7, var_17, undefined, var_8);
    var_25 = makeweaponfromstring(var_25);
    var_24 = makeweaponfromstring(var_24);
    var_2 = makeweaponfromstring(var_2);

    if(var_9) {
      var_26 = spawn("script_weapon", var_1 getEye() + var_11, 0, 0, var_16);
    } else {
      var_26 = spawn("script_weapon", var_1 getEye() + var_11, 0, 0, var_2);
    }

    var_26.angles = var_0.angles;
    var_27 = _id_6BC9(var_25);
    var_28 = getent("pap_machine", "targetname");
    level thread _id_C301(var_1, var_26, var_0, var_28);
    level notify("pap_used", var_1, var_4, var_25);
    var_26 makeunusable();
    var_1 thread _id_B8B6(var_1, var_1._id_AE0F, var_5, var_2, var_16);
    var_1._id_AE15 = var_2;
    var_29 = _id_6C78(var_3);
    var_26 moveto(var_10.origin + var_29, 0.75);
    var_26 rotateto(var_10.angles, 0.75);
    var_26 waittill("movedone");
    var_26 moveto(var_10.origin + var_27, 0.25);
    var_26 waittill("movedone");
    var_28 playSound("zmb_packapunch_machine_on");
    var_28 setscriptablepartstate("door", "close");
    wait 0.75;

    if(!scripts\engine\utility::_id_5C00("fuses_inserted")) {
      var_28 setscriptablepartstate("papfx", "normal");
    } else {
      var_28 setscriptablepartstate("papfx", "upgraded");
    }

    wait 3.5;
    var_28 setscriptablepartstate("door", "decomp");
    wait 0.8;
    var_26 _meth_855D(var_24);
    wait 0.4;
    var_28 setscriptablepartstate("door", "open_idle");
    var_28 setscriptablepartstate("papfx", "idle");
    wait 0.5;
    var_26 makeuseable();
    var_26 setuserange(100);

    foreach(var_31 in level.players) {
      if(var_31 == var_1) {
        var_26 _meth_80E0(var_31);
        continue;
      }

      var_26 disableplayeruse(var_31);
    }

    if(var_3 == "dischord" || var_3 == "facemelter" || var_3 == "headcutter" || var_3 == "shredder") {
      var_1 thread _id_076F::_id_F72D("pap_wor", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
    }

    var_26 thread _id_10735(var_25, var_6, var_4);
    var_26 scripts\engine\utility::_id_108A7(30, "weapon_taken");
    var_1 notify("weapon_purchased");
    var_1._id_AE15 = undefined;
    var_26 delete();
    level thread _id_076F::_id_C3D1("dj_quest_ufo_pap1_nag");
    var_1 _id_0737::_id_C1A2();
    wait 1;
    _id_0737::_id_1037(var_0);
    level notify("pap_machine_activated");
  }
}

_id_C77A(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_2)) {
    switch (var_2) {
      case "spiked":
      case "golf":
      case "two":
      case "machete":
      case "nunchucks":
      case "katana":
        return "replace_me";
      default:
        if(istrue(var_4)) {
          return undefined;
        }

        if(isDefined(var_0._id_AE0A[var_2])) {
          return "pap" + var_0._id_AE0A[var_2]._id_991E;
        } else {
          return "pap1";
        }
    }
  }

  return var_5;
}

_id_B8B6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = makeweapon("iw7_fists_zm");
  var_0 scripts\cp\utility::_giveweapon(var_5, undefined, undefined, 1);
  var_0 switchtoweaponimmediate(var_5);
  var_0 takeweapon(var_4);
  wait 1;
  thread scripts\cp\utility::_id_5B75(var_0, var_1);
  wait 2.5;

  if(isDefined(var_2)) {
    var_0 switchtoweaponimmediate(var_2);

    if(var_0 hasweapon(var_5)) {
      var_0 takeweapon(var_5);
    }
  }
}

_id_6957() {
  if(isDefined(self._id_AE10)) {
    return self _meth_8495(self._id_AE10);
  } else {
    return 3;
  }
}

_id_6C78(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "forgefreeze":
        return (-32, 0, 24);
      default:
        return (-32, 0, 16);
    }
  } else
    return (-32, 0, 16);
}

_id_C301(var_0, var_1, var_2, var_3) {
  level endon("pap_machine_activated");
  var_0 waittill("disconnect");
  var_3 setscriptablepartstate("door", "decomp");
  wait 1.2;
  var_3 setscriptablepartstate("door", "open_idle");
  var_3 setscriptablepartstate("papfx", "idle");
  var_1 delete();
  wait 1;
  _id_0737::_id_1037(var_2);
  level notify("pap_machine_activated");
}

_id_6BC9(var_0) {
  var_1 = scripts\cp\utility::_id_6902(var_0);

  switch (var_1) {
    case "iw7_erad":
    case "iw7_devastator":
    case "iw7_ar57":
      return (0, -4, 3);
    case "iw7_sdflmg":
      return (0, 2, 3);
    case "iw7_fmg":
    case "iw7_glprox":
      return (0, -4, 2);
    case "iw7_m4":
    case "iw7_sonic":
    case "iw7_lmg03":
      return (0, -2, 2);
    case "iw7_m8":
    case "iw7_lockon":
      return (0, 2, 2);
    case "iw7_fhr":
      return (0, -6, 3);
    case "iw7_sdfar":
      return (0, -1, 3);
    case "iw7_ripper":
      return (0, -7, 3);
    case "iw7_chargeshot":
      return (0, -4, 4);
    case "iw7_axe":
      return (0, 4, 0);
    case "iw7_m1":
      return (0, 4, 0);
    case "iw7_kbs":
      return (0, 4, 2);
    case "iw7_cheytac":
      return (0, 8, 2);
    case "iw7_ake":
    case "iw7_g18":
    case "iw7_mauler":
      return (0, 0, 2);
    case "iw7_crb":
      return (0, -7, 3);
    case "iw7_nrg":
    case "iw7_emc":
    case "iw7_shredder":
    case "iw7_headcutter":
    case "iw7_facemelter":
    case "iw7_dischord":
      return (0, 0, 0);
    case "iw7_forgefreeze":
      return (0, 0, 16);
    case "iw7_revolver":
    case "iw7_spas":
      return (0, 3, 1);
    case "iw7_sdfshotty":
      return (0, 1, 4);
    case "iw7_ump45":
      return (0, -6, 2);
    default:
      return (0, 0, 0);
  }
}

_id_10735(var_0, var_1, var_2) {
  self endon("death");
  self waittill("trigger", var_3);
  var_1 = makeweapon("iw7_fists_zm");

  if(var_3 hasweapon(var_1)) {
    var_3 takeweapon(var_1);
  }

  var_4 = undefined;

  if(isweapon(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = makeweaponfromstring(var_0);
  }

  if(var_3 scripts\cp\cp_weapon::_id_752E(var_4)) {
    var_5 = scripts\cp\utility::_id_6CE3(var_4);

    foreach(var_7 in var_3 getweaponslistall()) {
      var_8 = scripts\cp\utility::_id_6CE3(var_7);

      if(var_5 == var_8) {
        var_3 takeweapon(var_7);
      }
    }
  }

  if(_id_DAE4(var_3)) {
    var_10 = var_3 getcurrentweapon();
    var_11 = scripts\cp\utility::_id_6CE3(var_10);
    var_3 takeweapon(var_10);
  }

  self notify("weapon_taken");
  var_4 = var_3 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 0);
  var_3 givemaxammo(var_4);
  var_12 = var_3 getweaponslistprimaries();

  foreach(var_7 in var_12) {
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

  var_3 switchtoweapon(var_4);
  var_5 = scripts\cp\utility::_id_6CE3(var_4);
  var_3._id_AE0A[var_5]._id_991E++;
  var_3 _id_074E::_id_6F38(500, 1);
  var_3 notify("weapon_level_changed");
}

_id_DAE4(var_0) {
  var_1 = 3;

  if(var_0 scripts\cp\utility::_id_7531("perk_machine_more")) {
    var_1 = 4;
  }

  var_2 = var_0 getweaponslistprimaries("primary");

  foreach(var_4 in var_2) {
    if(var_4._id_0245) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }
  }

  return var_2.size >= var_1;
}

_id_FD99() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponslistall();
    var_3 = 1;
    var_4 = scripts\cp\utility::_id_6CE3(var_1 scripts\cp\utility::_id_6E34());

    foreach(var_6 in var_2) {
      var_7 = scripts\cp\utility::_id_6CE3(var_6);

      if(isDefined(var_1._id_AE0A[var_7]) && var_1 scripts\cp\cp_weapon::_id_3101(var_6)) {
        var_8 = _id_FD98(var_1, var_6);

        if(var_7 == var_4 && !istrue(var_1._id_8E55)) {
          var_1 switchtoweaponimmediate(var_8);
        }
      }
    }
  }
}

_id_FD98(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::_id_6CE3(var_1);
  var_4 = undefined;

  if(isDefined(var_0._id_AE0A[var_3]) && var_0 scripts\cp\cp_weapon::_id_3101(var_1, var_2)) {
    var_5 = var_0 scripts\cp\cp_weapon::_id_683D(var_3);
    var_5 = int(var_5);
    var_5++;

    if(isDefined(level._id_A524) && scripts\engine\utility::array_contains(level._id_A524, var_3)) {
      var_4 = undefined;
    } else if(isDefined(level._id_AE0B) && isDefined(var_5) && var_5 == 2) {
      var_4 = level._id_AE0B;
    } else if(isDefined(level._id_AE0C) && isDefined(var_5) && var_5 == 3) {
      var_4 = level._id_AE0C;
    }

    switch (var_3) {
      case "dischord":
        var_6 = "iw7_dischord_zm_pap1";
        var_4 = "camo20";
        break;
      case "facemelter":
        var_6 = "iw7_facemelter_zm_pap1";
        var_4 = "camo22";
        break;
      case "headcutter":
        var_6 = "iw7_headcutter_zm_pap1";
        var_4 = "camo21";
        break;
      case "nunchucks":
      case "katana":
        var_4 = "camo222";
        break;
      case "shredder":
        var_6 = "iw7_shredder_zm_pap1";
        var_4 = "camo23";
        break;
    }

    if(var_3 == "axe") {
      if(var_5 == 2) {
        var_6 = "iw7_axe_zm_pap1";
      } else if(var_5 == 3) {
        var_6 = "iw7_axe_zm_pap2";
      }
    }

    if(var_3 == "nunchucks") {
      if(var_5 == 2) {
        var_6 = "iw7_nunchucks_zm_pap1";
      } else if(var_5 == 3) {
        var_6 = "iw7_nunchucks_zm_pap2";
      }
    }

    if(var_3 == "katana") {
      if(var_5 == 2) {
        var_6 = "iw7_katana_zm_pap1";
      } else if(var_5 == 3) {
        var_6 = "iw7_katana_zm_pap2";
      }
    }

    if(var_3 == "forgefreeze") {
      if(var_5 == 2) {
        var_6 = "iw7_forgefreeze_zm_pap1";
      } else if(var_5 == 3) {
        var_6 = "iw7_forgefreeze_zm_pap2";
      }
    }

    var_0 takeweapon(var_1);
    var_7 = _id_FF38(var_5, var_3, var_1);
    var_1 = makeweaponfromstring(var_7);
    var_8 = _id_C77A(var_0, var_5, var_3, var_1);

    if(isDefined(var_8) && var_8 == "replace_me") {
      var_8 = undefined;
    }

    var_9 = getweaponattachments(var_1);

    if(issubstr(getcompleteweaponname(var_1), "g18_z")) {
      foreach(var_11 in var_9) {
        if(issubstr(var_11, "akimbo")) {
          var_9 = scripts\engine\utility::array_remove(var_9, var_11);
        }
      }
    }

    var_13 = var_0 scripts\cp\cp_weapon::_id_C78E(var_1, var_8, var_9, undefined, var_4);
    var_14 = makeweaponfromstring(var_13);
    var_14 = var_0 scripts\cp\utility::_giveweapon(var_14, undefined, undefined, 1);
    var_0._id_AE0A[var_3]._id_991E++;
    var_0 notify("weapon_level_changed");
    return var_14;
  }

  return undefined;
}

_id_FF38(var_0, var_1, var_2) {
  if(isDefined(level._id_10D23) && isDefined(level._id_10D23[getweaponbasename(var_2)])) {
    var_2 = level._id_10D23[getweaponbasename(var_2)];
  } else if(isDefined(var_1)) {
    switch (var_1) {
      case "two":
        if(var_0 == 2) {
          var_2 = "iw7_two_headed_axe_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_two_headed_axe_mp";
        }

        break;
      case "golf":
        if(var_0 == 2) {
          var_2 = "iw7_golf_club_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_golf_club_mp";
        }

        break;
      case "machete":
        if(var_0 == 2) {
          var_2 = "iw7_machete_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_machete_mp";
        }

        break;
      case "spiked":
        if(var_0 == 2) {
          var_2 = "iw7_spiked_bat_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_spiked_bat_mp";
        }

        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        break;
      case "katana":
        if(var_0 == 2) {
          var_2 = "iw7_katana_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_katana_zm_pap2";
        }

        break;
      case "nunchucks":
        if(var_0 == 2) {
          var_2 = "iw7_nunchucks_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_nunchucks_zm_pap2";
        }

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

_id_86C7(var_0) {
  if(var_0 == "iw7_zm1coaster_zm" || var_0 == "iw7_cpbasketball_mp" || var_0 == "iw7_shootgallery_zm_blue" || var_0 == "iw7_shootgallery_zm_red" || var_0 == "iw7_shootgallery_zm_yellow" || var_0 == "iw7_shootgallery_zm_green") {
    return 1;
  }

  return 0;
}