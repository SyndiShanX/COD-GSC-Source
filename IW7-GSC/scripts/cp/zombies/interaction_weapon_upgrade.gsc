/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_weapon_upgrade.gsc
*************************************************************/

init_all_weapon_upgrades() {
  var_0 = scripts\engine\utility::getstructarray("weapon_upgrade", "script_noteworthy");
  level.get_weapon_level_func = scripts\cp\cp_weapon::get_weapon_level;
  foreach(var_2 in var_0) {
    var_2.powered_on = 1;
    var_2 thread init_upgrade_weapon();
  }
}

init_upgrade_weapon() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  var_0 = getent("pap_machine", "targetname");
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(level.pap_room_func)) {
    [[level.pap_room_func]](self, var_0);
    return;
  }

  var_0 setscriptablepartstate("door", "open_idle");
  var_0 setscriptablepartstate("reels", "on");
  self.powered_on = 1;
}

func_9A40(var_0, var_1) {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  var_1 thread weapon_upgrade(var_0);
}

weapon_upgrade_hint_logic(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.wor_phase_shift)) {
    return "";
  }

  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\cp_weapon::get_weapon_level(var_2);
  if(var_3 == level.pap_max) {
    return &"COOP_INTERACTIONS_UPGRADE_MAXED";
  } else if(var_1 scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    return "";
  } else if(!scripts\cp\cp_weapon::can_upgrade(var_2)) {
    return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL";
  } else if(var_3 == 1) {
    return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON";
  } else {
    return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_GENERIC";
  }

  return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL";
}

weapon_upgrade(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);
  var_4 = var_1 scripts\cp\cp_weapon::get_weapon_level(var_3);
  var_5 = undefined;
  var_6 = undefined;
  var_7 = "none";
  var_8 = undefined;
  var_9 = 0;
  if(var_3 == "dischord" || var_3 == "facemelter" || var_3 == "headcutter" || var_3 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted") && !scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
      return;
    }
  }

  if(var_4 < level.pap_max) {
    var_0A = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_0B = vectornormalize(anglesToForward(var_1.angles)) * 16;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    var_0C = var_1 getweaponslistprimaries();
    var_1 scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
    foreach(var_0E in var_0C) {
      if(!issubstr(var_2, var_0E) && !scripts\cp\utility::isstrstart(var_0E, "alt_") && !issubstr(var_0E, "knife")) {
        var_5 = var_0E;
        break;
      }
    }

    var_4 = int(var_4);
    var_4++;
    var_10 = var_2;
    if(isDefined(level.pap_1_camo) && isDefined(var_4) && var_4 == 2) {
      var_8 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var_4) && var_4 == 3) {
      var_8 = level.pap_2_camo;
    }

    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_3)) {
      var_8 = undefined;
    }

    if(var_4 == 2) {
      if(isDefined(var_3)) {
        switch (var_3) {
          case "dischord":
            var_2 = "iw7_dischord_zm_pap1";
            var_8 = "camo20";
            break;

          case "facemelter":
            var_2 = "iw7_facemelter_zm_pap1";
            var_8 = "camo22";
            break;

          case "headcutter":
            var_2 = "iw7_headcutter_zm_pap1";
            var_8 = "camo21";
            break;

          case "shredder":
            var_2 = "iw7_shredder_zm_pap1";
            var_8 = "camo23";
            break;

          default:
            break;
        }
      }
    }

    if(var_3 == "axe") {
      if(var_4 == 2) {
        var_2 = "iw7_axe_zm_pap1";
      } else if(var_4 == 3) {
        var_2 = "iw7_axe_zm_pap2";
      }

      var_9 = 1;
    }

    if(var_3 == "nunchucks") {
      if(var_4 == 2) {
        var_2 = "iw7_nunchucks_zm_pap1";
      } else if(var_4 == 3) {
        var_2 = "iw7_nunchucks_zm_pap2";
      }

      var_9 = 1;
    }

    if(var_3 == "katana") {
      if(var_4 == 2) {
        var_2 = "iw7_katana_zm_pap1";
      } else if(var_4 == 3) {
        var_2 = "iw7_katana_zm_pap2";
      }

      var_9 = 1;
    }

    if(var_3 == "venomx") {
      if(var_4 == 2) {
        var_2 = "iw7_venomx_zm_pap1";
      } else if(var_4 == 3) {
        var_2 = "iw7_venomx_zm_pap2";
      }

      var_9 = 1;
    }

    if(var_3 == "forgefreeze") {
      if(var_4 == 2) {
        var_2 = "iw7_forgefreeze_zm_pap1";
      } else if(var_4 == 3) {
        var_2 = "iw7_forgefreeze_zm_pap2";
      }

      var_9 = 1;
    }

    level.timespapused++;
    scripts\cp\zombies\zombie_analytics::log_papused(level.wave_num, var_3, level.timespapused);
    var_1 scripts\cp\zombies\achievement::update_achievement("GET_PACKED", 1);
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
    var_7 = return_pap_attachment(var_1, var_4, var_3, var_2);
    if(isDefined(var_7) && var_7 == "replace_me") {
      var_7 = undefined;
    }

    var_11 = getweaponattachments(var_2);
    if(issubstr(var_2, "g18_z")) {
      foreach(var_13 in var_11) {
        if(issubstr(var_13, "akimbo")) {
          var_11 = scripts\engine\utility::array_remove(var_11, var_13);
        }
      }
    }

    var_15 = var_11;
    foreach(var_13 in var_15) {
      if(issubstr(var_13, "silencer") || issubstr(var_13, "arcane") || issubstr(var_13, "ark")) {
        var_15 = scripts\engine\utility::array_remove(var_15, var_13);
      }
    }

    var_2 = var_1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, undefined, var_15);
    var_18 = var_1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, var_7, var_15, undefined, var_8);
    var_19 = var_1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, var_7, var_11, undefined, var_8);
    if(var_9) {
      var_1A = spawn("script_weapon", var_1 getEye() + var_0B, 0, 0, var_10);
    } else {
      var_1A = spawn("script_weapon", var_2 getEye() + var_0C, 0, 0, var_3);
    }

    var_1A.angles = var_0.angles;
    var_1B = getoffsetfrombaseweaponname(var_19);
    var_1C = getent("pap_machine", "targetname");
    level thread releasemachineonplayerdisconnect(var_1, var_1A, var_0, var_1C);
    level notify("pap_used", var_1, var_4, var_19);
    var_1A makeunusable();
    var_1 thread playpapgesture(var_1, var_1.pap_gesture, var_5, var_2, var_10);
    var_1.paping_weapon = var_2;
    var_1D = getpos1offset(var_3);
    var_1A moveto(var_0A.origin + var_1D, 0.75);
    var_1A rotateto(var_0A.angles, 0.75);
    var_1A waittill("movedone");
    var_1A moveto(var_0A.origin + var_1B, 0.25);
    var_1A waittill("movedone");
    var_1C playSound("zmb_packapunch_machine_on");
    var_1C setscriptablepartstate("door", "close");
    wait(0.75);
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      var_1C setscriptablepartstate("papfx", "normal");
    } else {
      var_1C setscriptablepartstate("papfx", "upgraded");
    }

    wait(3.5);
    var_1C setscriptablepartstate("door", "decomp");
    wait(0.8);
    var_1A setmoverweapon(var_18);
    wait(0.4);
    var_1C setscriptablepartstate("door", "open_idle");
    var_1C setscriptablepartstate("papfx", "idle");
    wait(0.5);
    var_1A makeusable();
    var_1A setuserange(100);
    foreach(var_1F in level.players) {
      if(var_1F == var_1) {
        var_1A enableplayeruse(var_1F);
        continue;
      }

      var_1A disableplayeruse(var_1F);
    }

    if(var_3 == "dischord" || var_3 == "facemelter" || var_3 == "headcutter" || var_3 == "shredder") {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_wor", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
    }

    var_1A thread wait_for_player_to_take_weapon(var_19, var_6, var_4);
    var_1A scripts\engine\utility::waittill_any_timeout_1(30, "weapon_taken");
    var_1 notify("weapon_purchased");
    var_1.paping_weapon = undefined;
    var_1A delete();
    level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_quest_ufo_pap1_nag");
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    level notify("pap_machine_activated");
  }
}

return_pap_attachment(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  if(isDefined(var_2)) {
    switch (var_2) {
      case "spiked":
      case "golf":
      case "two":
      case "machete":
      case "katana":
      case "nunchucks":
      case "venomx":
        return "replace_me";

      default:
        if(scripts\engine\utility::istrue(var_4)) {
          return undefined;
        }

        if(isDefined(var_0.pap[var_2])) {
          return "pap" + var_0.pap[var_2].lvl;
        } else {
          return "pap1";
        }

        break;
    }
  }

  return var_5;
}

playpapgesture(var_0, var_1, var_2, var_3, var_4) {
  var_5 = "iw7_fists_zm";
  var_0 scripts\cp\utility::_giveweapon(var_5, undefined, undefined, 1);
  var_0 switchtoweaponimmediate(var_5);
  var_0 takeweapon(var_4);
  wait(1);
  thread scripts\cp\utility::firegesturegrenade(var_0, var_1);
  wait(2.5);
  if(isDefined(var_2)) {
    var_0 switchtoweaponimmediate(var_2);
    if(var_0 hasweapon(var_5)) {
      var_0 takeweapon(var_5);
    }
  }
}

getcharactercardgesturelength() {
  if(isDefined(self.pap_gesture_anim)) {
    return self getgestureanimlength(self.pap_gesture_anim);
  }

  return 3;
}

getpos1offset(var_0) {
  if(isDefined(var_0)) {
    switch (var_0) {
      case "forgefreeze":
        return (-32, 0, 24);

      default:
        return (-32, 0, 16);
    }

    return;
  }

  return (-32, 0, 16);
}

releasemachineonplayerdisconnect(var_0, var_1, var_2, var_3) {
  level endon("pap_machine_activated");
  var_0 waittill("disconnect");
  var_3 setscriptablepartstate("door", "decomp");
  wait(1.2);
  var_3 setscriptablepartstate("door", "open_idle");
  var_3 setscriptablepartstate("papfx", "idle");
  var_1 delete();
  wait(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  level notify("pap_machine_activated");
}

getoffsetfrombaseweaponname(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  switch (var_1) {
    case "iw7_devastator":
    case "iw7_erad":
    case "iw7_ar57":
      return (0, -4, 3);

    case "iw7_sdflmg":
      return (0, 2, 3);

    case "iw7_fmg":
    case "iw7_glprox":
      return (0, -4, 2);

    case "iw7_m4":
    case "iw7_lmg03":
    case "iw7_sonic":
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

    case "iw7_mauler":
    case "iw7_g18":
    case "iw7_ake":
      return (0, 0, 2);

    case "iw7_crb":
      return (0, -7, 3);

    case "iw7_shredder":
    case "iw7_headcutter":
    case "iw7_facemelter":
    case "iw7_dischord":
    case "iw7_nrg":
    case "iw7_emc":
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

wait_for_player_to_take_weapon(var_0, var_1, var_2) {
  self endon("death");
  self waittill("trigger", var_3);
  var_1 = "iw7_fists_zm";
  if(var_3 hasweapon(var_1)) {
    var_3 takeweapon(var_1);
  }

  if(var_3 scripts\cp\cp_weapon::has_weapon_variation(var_0)) {
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_0);
    foreach(var_6 in var_3 getweaponslistall()) {
      var_7 = scripts\cp\utility::getrawbaseweaponname(var_6);
      if(var_4 == var_7) {
        var_3 takeweapon(var_6);
      }
    }
  }

  if(should_take_players_current_weapon(var_3)) {
    var_9 = var_3 getcurrentweapon();
    var_0A = scripts\cp\utility::getrawbaseweaponname(var_9);
    var_3 takeweapon(var_9);
  }

  self notify("weapon_taken");
  var_0 = var_3 scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 0);
  var_3 givemaxammo(var_0);
  var_0B = var_3 getweaponslistprimaries();
  foreach(var_6 in var_0B) {
    if(issubstr(var_6, var_0)) {
      if(scripts\cp\utility::isaltmodeweapon(var_6)) {
        var_4 = getweaponbasename(var_6);
        if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, var_4)) {
          var_0 = "alt_" + var_0;
          break;
        }
      }
    }
  }

  var_3 switchtoweapon(var_0);
  var_4 = scripts\cp\utility::getrawbaseweaponname(var_0);
  var_3.pap[var_4].lvl++;
  var_3 scripts\cp\cp_persistence::give_player_xp(500, 1);
  var_3 notify("weapon_level_changed");
}

should_take_players_current_weapon(var_0) {
  var_1 = 3;
  if(var_0 scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
    var_1 = 4;
  }

  var_2 = var_0 getweaponslistprimaries("primary");
  foreach(var_4 in var_2) {
    if(scripts\cp\utility::isstrstart(var_4, "alt_")) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }
  }

  return var_2.size >= var_1;
}

canupgradefunctionreroute(var_0, var_1) {
  if(isDefined(level.max_pap_func)) {
    return self[[level.max_pap_func]](var_0, var_1);
  }

  return scripts\cp\cp_weapon::can_upgrade(var_0, var_1);
}

func_12F73() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponslistall();
    var_3 = 1;
    var_4 = [];
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_1 scripts\cp\utility::getvalidtakeweapon());
    foreach(var_7 in var_2) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_7);
      if(!scripts\engine\utility::istrue(var_4[var_8])) {
        var_4[var_8] = 1;
        if(isDefined(var_1.pap[var_8])) {
          if(var_1 canupgradefunctionreroute(var_7)) {
            var_9 = func_12F72(var_1, var_7);
            if(var_8 == var_5 && !scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
              var_1 switchtoweaponimmediate(var_9);
            }
          }
        }
      }
    }
  }
}

func_12F72(var_0, var_1, var_2) {
  var_3 = scripts\cp\utility::getrawbaseweaponname(var_1);
  var_4 = undefined;
  if(isDefined(var_0.pap[var_3])) {
    if(var_0 canupgradefunctionreroute(var_1, var_2)) {
      var_5 = var_0 scripts\cp\cp_weapon::get_weapon_level(var_3);
      var_5 = int(var_5);
      var_5++;
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_3)) {
        var_4 = undefined;
      } else if(isDefined(level.pap_1_camo) && isDefined(var_5) && var_5 == 2) {
        var_4 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && isDefined(var_5) && var_5 == 3) {
        var_4 = level.pap_2_camo;
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

        case "katana":
        case "nunchucks":
          var_4 = "camo222";
          break;

        case "shredder":
          var_6 = "iw7_shredder_zm_pap1";
          var_4 = "camo23";
          break;

        case "venomx":
          if(var_5 == 2) {
            var_6 = "iw7_venomx_zm_pap1";
            var_4 = "camo32";
            break;
          } else if(var_5 == 3) {
            var_6 = "iw7_venomx_zm_pap2";
            var_4 = "camo34";
            break;
          }

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

      if(var_3 == "venomx") {
        if(var_5 == 2) {
          var_6 = "iw7_venomx_zm_pap1";
        } else if(var_5 == 3) {
          var_6 = "iw7_venomx_zm_pap2";
        }
      }

      var_0 takeweapon(var_1);
      var_1 = validate_current_weapon(var_5, var_3, var_1);
      var_7 = return_pap_attachment(var_0, var_5, var_3, var_1);
      if(isDefined(var_7) && var_7 == "replace_me") {
        var_7 = undefined;
      }

      var_8 = getweaponattachments(var_1);
      if(issubstr(var_1, "g18_z")) {
        foreach(var_0A in var_8) {
          if(issubstr(var_0A, "akimbo")) {
            var_8 = scripts\engine\utility::array_remove(var_8, var_0A);
          }
        }
      }

      var_0C = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, var_7, var_8, undefined, var_4);
      var_0C = var_0 scripts\cp\utility::_giveweapon(var_0C, undefined, undefined, 1);
      var_0.pap[var_3].lvl++;
      var_0 notify("weapon_level_changed");
      var_0 givemaxammo(var_0C);
      return var_0C;
    }
  }

  return undefined;
}

validate_current_weapon(var_0, var_1, var_2) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_2)])) {
    var_2 = level.weapon_upgrade_path[getweaponbasename(var_2)];
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

      case "venomx":
        if(var_0 == 2) {
          var_2 = "iw7_venomx_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_venomx_zm_pap2";
        }

        break;

      default:
        return var_2;
    }
  }

  return var_2;
}

func_9CCD(var_0) {
  if(var_0 == "iw7_zm1coaster_zm" || var_0 == "iw7_cpbasketball_mp" || var_0 == "iw7_shootgallery_zm_blue" || var_0 == "iw7_shootgallery_zm_red" || var_0 == "iw7_shootgallery_zm_yellow" || var_0 == "iw7_shootgallery_zm_green") {
    return 1;
  }

  return 0;
}