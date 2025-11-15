/****************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_weapon_upgrade.gsc
****************************************************************/

init_weapon_upgrade() {
  level.pap_room_func = ::cp_town_pap_machine_func;
  level.max_pap_func = ::can_upgrade;
  init_all_weapon_upgrades();
}

init_all_weapon_upgrades() {
  var_00 = scripts\engine\utility::getstructarray("weapon_upgrade", "script_noteworthy");
  level.get_weapon_level_func = ::scripts\cp\cp_weapon::get_weapon_level;
  foreach(var_02 in var_00) {
    var_02.powered_on = 1;
    var_02 thread init_upgrade_weapon();
  }
}

init_upgrade_weapon() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  var_00 = getent("pap_machine", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  if(isDefined(level.pap_room_func)) {
    [[level.pap_room_func]](self, var_00);
    return;
  }

  var_00 setscriptablepartstate("door", "open_idle");
  var_00 setscriptablepartstate("reels", "on");
  self.powered_on = 1;
}

set_fuse_icon_on_hotjoin(param_00) {
  level notify("stop_hotjoin_fuse");
  level endon("stop_hotjoin_fuse");
  for(;;) {
    level waittill("connected", var_01);
    var_01 setclientomnvar("zm_special_item", param_00);
  }
}

weapon_upgrade(param_00, param_01) {
  param_01 endon("disconnect");
  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    level.placed_alien_fuses = 1;
    level thread place_fuses_in_machine(param_00, param_01);
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("quest_pap_fuse_deposit", "zmb_comment_vo");
    foreach(var_03 in level.players) {
      var_03 setclientomnvar("zm_special_item", 0);
    }

    level thread set_fuse_icon_on_hotjoin(0);
    return;
  }

  var_05 = var_04 getcurrentweapon();
  var_06 = scripts\cp\utility::getrawbaseweaponname(var_05);
  var_07 = var_04 scripts\cp\cp_weapon::get_weapon_level(var_06);
  var_08 = undefined;
  var_09 = get_player_fists_weapon(var_04);
  var_0A = "none";
  var_0B = undefined;
  var_0C = 0;
  if(!can_use_pap_machine(var_06)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_04.hasentanglerequipped)) {
    return;
  }

  if(var_04 can_upgrade(var_05)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
    var_0D = scripts\engine\utility::getstruct(var_03.target, "targetname");
    var_0E = vectornormalize(anglesToForward(var_04.angles)) * 16;
    var_07 = int(var_07);
    var_07++;
    var_0F = var_05;
    var_10 = validate_current_weapon(var_07, var_06, var_05);
    var_08 = get_pap_offhand_weapon(var_04, var_05);
    var_0B = get_pap_camo(var_07, var_06, var_05);
    var_0C = should_use_old_model(var_07, var_06, var_05);
    process_pap_stat_logging(var_06, var_04);
    thread play_pap_vo(var_04);
    var_0A = return_pap_attachment(var_04, var_07, var_06, var_05);
    if(isDefined(var_0A) && var_0A == "replace_me") {
      var_0A = undefined;
    }

    var_11 = filter_current_weapon_attachments(var_05);
    var_12 = remove_invalid_wm_attachments(var_11);
    var_05 = var_04 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_10, undefined, var_12);
    var_13 = var_04 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_10, var_0A, var_12, undefined, var_0B);
    var_14 = var_04 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_10, var_0A, var_11, undefined, var_0B);
    if(var_0C) {
      var_15 = spawn("script_weapon", var_04 getEye() + var_0E, 0, 0, var_0F);
    } else {
      var_15 = spawn("script_weapon", var_05 getEye() + var_0F, 0, 0, var_06);
    }

    var_15.angles = var_03.angles;
    if(var_0C) {
      var_16 = disco_getoffsetfrombaseweaponname(var_0F);
    } else {
      var_16 = disco_getoffsetfrombaseweaponname(var_15);
    }

    level thread releasemachineonplayerdisconnect(var_04, var_15, var_03);
    level notify("pap_used", var_04, var_07, var_14);
    var_15 makeunusable();
    var_04 thread disco_playpapgesture(var_04, var_04.pap_gesture, var_08, var_05, var_0F);
    var_04.paping_weapon = var_05;
    if(var_0C) {
      var_17 = getangleoffset(var_0F, var_0D);
    } else {
      var_17 = getangleoffset(var_15, var_0E);
    }

    var_18 = scripts\cp\zombies\interaction_weapon_upgrade::getpos1offset(var_06);
    var_15 moveto(var_0D.origin + var_18, 0.75);
    var_15 rotateto(var_17, 0.75);
    var_15 waittill("movedone");
    var_15 moveto(var_0D.origin + var_16, 0.25);
    var_15 waittill("movedone");
    update_level_pap_machines("door", "close", undefined, undefined, "zmb_packapunch_machine_on");
    wait(0.75);
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      update_level_pap_machines("papfx", "normal", "papfx", "upgraded");
    }

    wait(3.5);
    update_level_pap_machines("door", "decomp");
    wait(0.8);
    var_15 setmoverweapon(var_13);
    wait(0.4);
    update_level_pap_machines("door", "open_idle");
    update_level_pap_machines("papfx", "idle");
    wait(0.5);
    var_15 makeusable();
    var_15 setuserange(100);
    if(var_04 scripts\cp\utility::is_valid_player()) {
      foreach(var_19 in level.players) {
        if(var_19 == var_03) {
          var_14 enableplayeruse(var_19);
          continue;
        }

        var_14 disableplayeruse(var_19);
      }

      if(var_0F == "iw7_venomx_zm_pap2") {
        var_03 scripts\cp\zombies\achievement::update_achievement("ENCRYPT_DECRYPT", 1);
      }

      var_03 scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
    }

    var_15 thread wait_for_player_to_take_weapon(var_14, var_09, var_07);
    var_15 scripts\engine\utility::waittill_any_timeout_1(30, "weapon_taken");
    var_04 notify("weapon_purchased");
    var_04.paping_weapon = undefined;
    var_04 scripts\cp\cp_interaction::refresh_interaction();
    var_04 scripts\cp\cp_merits::processmerit("mt_dlc4_upgrade_weapons");
    var_15 delete();
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
    level notify("pap_machine_activated");
  }
}

wait_for_player_to_take_weapon(param_00, param_01, param_02) {
  self endon("death");
  level endon("pap_machine_activated");
  var_03 = undefined;
  for(;;) {
    self waittill("trigger", var_03);
    if(scripts\engine\utility::istrue(var_03.hasentanglerequipped)) {
      continue;
    } else {
      break;
    }
  }

  if(!isDefined(param_01)) {
    param_01 = "iw7_fists_zm";
  }

  if(var_03 hasweapon(param_01)) {
    var_03 takeweapon(param_01);
  }

  if(var_03 scripts\cp\cp_weapon::has_weapon_variation(param_00)) {
    var_04 = scripts\cp\utility::getrawbaseweaponname(param_00);
    foreach(var_06 in var_03 getweaponslistall()) {
      var_07 = scripts\cp\utility::getrawbaseweaponname(var_06);
      if(var_04 == var_07) {
        var_03 takeweapon(var_06);
      }
    }
  }

  if(scripts\cp\zombies\interaction_weapon_upgrade::should_take_players_current_weapon(var_03)) {
    var_09 = var_03 getcurrentweapon();
    var_0A = scripts\cp\utility::getrawbaseweaponname(var_09);
    var_03 takeweapon(var_09);
  }

  self notify("weapon_taken");
  param_00 = var_03 scripts\cp\utility::_giveweapon(param_00, undefined, undefined, 0);
  if(issubstr(param_00, "venomx_zm_pap1")) {
    var_03 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_venx_1", "final_comment_vo");
  } else if(issubstr(param_00, "venomx_zm_pap2")) {
    var_03 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_venx_2", "final_comment_vo");
  }

  var_03 givemaxammo(param_00);
  var_0B = var_03 getweaponslistprimaries();
  foreach(var_06 in var_0B) {
    if(issubstr(var_06, param_00)) {
      if(scripts\cp\utility::isaltmodeweapon(var_06)) {
        var_04 = getweaponbasename(var_06);
        if(isDefined(level.mode_weapons_allowed) && scripts\engine\utility::array_contains(level.mode_weapons_allowed, var_04)) {
          param_00 = "alt_" + param_00;
          break;
        }
      }
    }
  }

  var_03 switchtoweapon(param_00);
  var_04 = scripts\cp\utility::getrawbaseweaponname(param_00);
  var_03.pap[var_04].lvl++;
  var_03 scripts\cp\cp_persistence::give_player_xp(500, 1);
  var_03 notify("weapon_level_changed");
}

disco_playpapgesture(param_00, param_01, param_02, param_03, param_04) {
  var_05 = get_player_fists_weapon(param_00);
  param_00 scripts\cp\utility::_giveweapon(var_05, undefined, undefined, 1);
  param_00 switchtoweaponimmediate(var_05);
  param_00 takeweapon(param_04);
  wait(1);
  thread scripts\cp\utility::firegesturegrenade(param_00, param_01);
  wait(2.5);
  if(isDefined(param_02)) {
    param_00 switchtoweaponimmediate(param_02);
    if(param_00 hasweapon(var_05)) {
      param_00 takeweapon(var_05);
    }
  }
}

get_player_fists_weapon(param_00) {
  if(isDefined(param_00.vo_prefix)) {
    switch (param_00.vo_prefix) {
      case "p1_":
        return "iw7_fists_zm";

      case "p2_":
        return "iw7_fists_zm";

      case "p3_":
        return "iw7_fists_zm";

      case "p4_":
        return "iw7_fists_zm";

      case "p5_":
        return "iw7_fists_zm";

      default:
        return "iw7_fists_zm";
    }

    return;
  }

  return "iw7_fists_zm";
}

getangleoffset(param_00, param_01) {
  var_02 = scripts\cp\utility::getbaseweaponname(param_00);
  var_03 = param_01.angles;
  switch (var_02) {
    case "iw7_nunchucks":
    case "iw7_katana":
    case "iw7_spiked":
    case "iw7_golf":
    case "iw7_two":
    case "iw7_machete":
      return (90, 90, 0);

    default:
      return var_03;
  }
}

disco_getoffsetfrombaseweaponname(param_00) {
  var_01 = scripts\cp\utility::getbaseweaponname(param_00);
  var_02 = scripts\cp\zombies\interaction_weapon_upgrade::getoffsetfrombaseweaponname(param_00);
  switch (var_01) {
    case "iw7_machete":
      return (0, -6, 2);

    case "iw7_two":
      return (0, -8, 2);

    case "iw7_spiked":
    case "iw7_golf":
      return (0, -12, 2);

    case "iw7_nunchucks":
    case "iw7_katana":
      return (0, -12, 2);

    default:
      return var_02;
  }
}

return_pap_attachment(param_00, param_01, param_02, param_03, param_04) {
  var_05 = undefined;
  if(isDefined(param_02)) {
    switch (param_02) {
      case "spiked":
      case "golf":
      case "two":
      case "machete":
      case "katana":
      case "nunchucks":
      case "venomx":
        return "replace_me";

      default:
        if(scripts\engine\utility::istrue(param_04)) {
          return undefined;
        }

        if(isDefined(param_00.pap[param_02])) {
          return "pap" + param_00.pap[param_02].lvl;
        } else {
          return "pap1";
        }

        break;
    }
  }

  return var_05;
}

cp_town_pap_machine_func(param_00, param_01) {
  level.pap_machine = param_01;
  level.pap_machine hide();
  param_00.powered_on = 1;
}

place_fuses_in_machine(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\cp\maps\cp_final\cp_final_interactions::generic_place_gesture_and_fx(param_01, param_00);
  upgrade_machine_for_all_players();
  update_level_pap_machines("door", "close");
  wait(0.5);
  update_level_pap_machines("machine", "upgraded");
  wait(0.25);
  update_level_pap_machines("reels", "neutral");
  wait(0.25);
  update_level_pap_machines("reels", "on");
  wait(0.25);
  update_level_pap_machines("door", "open_idle");
  wait(0.25);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  if(param_01 scripts\cp\utility::is_valid_player()) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("pap_upgrade", "zmb_pap_vo", "high");
  }
}

upgrade_machine_for_all_players() {
  foreach(var_01 in level.player_pap_machines) {
    var_01 setModel("zmb_pap_machine_animated_soul_key");
  }

  scripts\engine\utility::waitframe();
}

update_level_pap_machines(param_00, param_01, param_02, param_03, param_04) {
  var_05 = isDefined(param_02) && isDefined(param_03);
  foreach(var_07 in level.player_pap_machines) {
    if(isDefined(param_04)) {
      var_07 playSound(param_04);
    }

    if(scripts\engine\utility::istrue(level.placed_alien_fuses) && var_05) {
      var_07 setscriptablepartstate(param_02, param_03);
      continue;
    }

    var_07 setscriptablepartstate(param_00, param_01);
  }
}

releasemachineonplayerdisconnect(param_00, param_01, param_02) {
  level endon("pap_machine_activated");
  param_00 waittill("disconnect");
  update_level_pap_machines("door", "decomp");
  wait(1.2);
  update_level_pap_machines("door", "open_idle");
  update_level_pap_machines("papfx", "idle");
  param_01 delete();
  wait(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_02);
  level notify("pap_machine_activated");
}

can_use_pap_machine(param_00) {
  if(param_00 == "dischord" || param_00 == "facemelter" || param_00 == "headcutter" || param_00 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      return 0;
    }

    return 1;
  }

  return 1;
}

get_pap_offhand_weapon(param_00, param_01) {
  var_02 = param_00 getweaponslistprimaries();
  foreach(var_04 in var_02) {
    if(!issubstr(param_01, var_04) && !scripts\cp\utility::isstrstart(var_04, "alt_") && !issubstr(var_04, "knife") && var_04 != "iw7_knife_zm_disco") {
      return var_04;
    }
  }

  return undefined;
}

validate_current_weapon(param_00, param_01, param_02) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(param_02)])) {
    param_02 = level.weapon_upgrade_path[getweaponbasename(param_02)];
  } else if(isDefined(param_01)) {
    switch (param_01) {
      case "two":
        if(param_00 == 2) {
          param_02 = "iw7_two_headed_axe_mp";
        } else if(param_00 == 3) {
          param_02 = "iw7_two_headed_axe_mp";
        }
        break;

      case "golf":
        if(param_00 == 2) {
          param_02 = "iw7_golf_club_mp";
        } else if(param_00 == 3) {
          param_02 = "iw7_golf_club_mp";
        }
        break;

      case "machete":
        if(param_00 == 2) {
          param_02 = "iw7_machete_mp";
        } else if(param_00 == 3) {
          param_02 = "iw7_machete_mp";
        }
        break;

      case "spiked":
        if(param_00 == 2) {
          param_02 = "iw7_spiked_bat_mp";
        } else if(param_00 == 3) {
          param_02 = "iw7_spiked_bat_mp";
        }
        break;

      case "axe":
        if(param_00 == 2) {
          param_02 = "iw7_axe_zm_pap1";
        } else if(param_00 == 3) {
          param_02 = "iw7_axe_zm_pap2";
        }
        break;

      case "venomx":
        if(param_00 == 2) {
          param_02 = "iw7_venomx_zm_pap1";
        } else if(param_00 == 3) {
          param_02 = "iw7_venomx_zm_pap2";
        }
        break;

      default:
        return param_02;
    }
  }

  return param_02;
}

should_use_old_model(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    switch (param_01) {
      case "spiked":
      case "golf":
      case "two":
      case "axe":
      case "machete":
        return 1;

      default:
        return 0;
    }

    return;
  }

  return 0;
}

get_pap_camo(param_00, param_01, param_02) {
  var_03 = undefined;
  if(isDefined(param_01)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, param_01)) {
      var_03 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(param_00) && param_00 == 2) {
      var_03 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(param_00) && param_00 == 3) {
      var_03 = level.pap_2_camo;
    }

    switch (param_01) {
      case "dischord":
        param_02 = "iw7_dischord_zm_pap1";
        var_03 = "camo20";
        break;

      case "facemelter":
        param_02 = "iw7_facemelter_zm_pap1";
        var_03 = "camo22";
        break;

      case "headcutter":
        param_02 = "iw7_headcutter_zm_pap1";
        var_03 = "camo21";
        break;

      case "katana":
      case "nunchucks":
        var_03 = "camo222";
        break;

      case "forgefreeze":
        if(param_00 == 2) {
          param_02 = "iw7_forgefreeze_zm_pap1";
        } else if(param_00 == 3) {
          param_02 = "iw7_forgefreeze_zm_pap2";
        }

        var_04 = 1;
        break;

      case "axe":
        if(param_00 == 2) {
          param_02 = "iw7_axe_zm_pap1";
        } else if(param_00 == 3) {
          param_02 = "iw7_axe_zm_pap2";
        }

        var_04 = 1;
        break;

      case "shredder":
        param_02 = "iw7_shredder_zm_pap1";
        var_03 = "camo23";
        break;
    }
  }

  return var_03;
}

play_pap_vo(param_00) {
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap", "zmb_pap_vo", "high");
}

process_pap_stat_logging(param_00, param_01) {
  level.timespapused++;
  scripts\cp\zombies\zombie_analytics::log_papused(level.wave_num, param_00, level.timespapused);
}

filter_current_weapon_attachments(param_00) {
  var_01 = getweaponattachments(param_00);
  if(issubstr(param_00, "g18_z")) {
    foreach(var_03 in var_01) {
      if(issubstr(var_03, "akimbo")) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_03);
      }
    }
  }

  return var_01;
}

remove_invalid_wm_attachments(param_00) {
  var_01 = param_00;
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "silencer") || issubstr(var_03, "arcane") || issubstr(var_03, "ark")) {
      var_01 = scripts\engine\utility::array_remove(var_01, var_03);
    }
  }

  return param_00;
}

weapon_upgrade_hint_func(param_00, param_01) {
  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return & "CP_FINAL_INTERACTIONS_ADD_CHARGED_FUSE";
  }

  var_02 = param_01 getcurrentweapon();
  var_03 = scripts\cp\cp_weapon::get_weapon_level(var_02);
  if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    if(issubstr(var_02, "venomx_zm_pap1") && scripts\engine\utility::istrue(level.completed_venomx_pap2_challenges)) {
      return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON";
    } else if(var_03 == 3) {
      return & "COOP_INTERACTIONS_UPGRADE_MAXED";
    } else if(!can_upgrade(var_02)) {
      return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON_FAIL";
    } else {
      return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON";
    }

    return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON_FAIL";
  }

  if(var_03 == level.pap_max) {
    return & "COOP_INTERACTIONS_UPGRADE_MAXED";
  } else if(param_01 scripts\cp\utility::is_melee_weapon(var_02, 1)) {
    return "";
  } else if(!can_upgrade(var_02)) {
    return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON_FAIL";
  } else {
    return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON";
  }

  return & "CP_FINAL_INTERACTIONS_UPGRADE_WEAPON_FAIL";
}

can_upgrade(param_00, param_01) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.hasentanglerequipped) && isDefined(param_00) && issubstr(param_00, "iw7_entangler2")) {
    return 0;
  }

  if(isDefined(param_00)) {
    var_02 = scripts\cp\utility::getrawbaseweaponname(param_00);
  } else {
    return 0;
  }

  if(!isDefined(var_02)) {
    return 0;
  }

  if(!isDefined(level.pap[var_02])) {
    var_03 = getsubstr(var_02, 0, var_02.size - 1);
    if(!isDefined(level.pap[var_03])) {
      return 0;
    }
  }

  if(isDefined(self.ephemeralweapon) && getweaponbasename(self.ephemeralweapon) == getweaponbasename(param_00)) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(param_00)])) {
    if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
      if(param_00 == "iw7_venomx_zm" || param_00 == "iw7_venomx_zm_pap1") {
        return 1;
      }
    } else if(param_00 == "iw7_venomx_zm") {
      if(scripts\engine\utility::istrue(level.completed_venomx_pap1_challenges)) {
        return 1;
      } else {
        return 0;
      }
    } else if(issubstr(param_00, "iw7_venomx_zm_pap1")) {
      if(scripts\engine\utility::istrue(level.completed_venomx_pap2_challenges)) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  if(var_02 == "dischord" || var_02 == "facemelter" || var_02 == "headcutter" || var_02 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      if(scripts\engine\utility::istrue(param_01)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl == 2) {
      return 0;
    }
  }

  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl >= 3) {
      return 0;
    } else {
      return 1;
    }
  }

  if(scripts\engine\utility::istrue(param_01) && isDefined(self.pap[var_02]) && self.pap[var_02].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_02]) && self.pap[var_02].lvl >= level.pap_max) {
    return 0;
  }

  return 1;
}