/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_weapon_upgrade.gsc
**************************************************************/

init_weapon_upgrade() {
  level.pap_room_func = ::cp_town_pap_machine_func;
  level.max_pap_func = ::can_upgrade;
  init_all_weapon_upgrades();
}

init_all_weapon_upgrades() {
  var_0 = scripts\engine\utility::getStructArray("weapon_upgrade", "script_noteworthy");
  level.get_weapon_level_func = scripts\cp\cp_weapon::get_weapon_level;
  foreach(var_2 in var_0) {
    var_2.powered_on = 1;
    var_2 thread init_upgrade_weapon();
  }
}

init_upgrade_weapon() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
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

set_fuse_icon_on_hotjoin(var_0) {
  level notify("stop_hotjoin_fuse");
  level endon("stop_hotjoin_fuse");
  for(;;) {
    level waittill("connected", var_1);
    var_1 setclientomnvar("zm_special_item", var_0);
  }
}

weapon_upgrade(var_0, var_1) {
  var_1 endon("disconnect");
  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    level.placed_alien_fuses = 1;
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_place_fuse", "town_comment_vo", "low", 10, 0, 0, 1, 100);
    level thread place_fuses_in_machine(var_0, var_1);
    foreach(var_1 in level.players) {
      var_1 setclientomnvar("zm_special_item", 0);
    }

    level thread set_fuse_icon_on_hotjoin(0);
    return;
  }

  var_4 = var_3 getcurrentweapon();
  var_5 = scripts\cp\utility::getrawbaseweaponname(var_4);
  var_6 = var_3 scripts\cp\cp_weapon::get_weapon_level(var_5);
  var_7 = undefined;
  var_8 = get_player_fists_weapon(var_3);
  var_9 = "none";
  var_10 = undefined;
  var_11 = 0;
  if(!can_use_pap_machine(var_5)) {
    return;
  }

  if(var_3 can_upgrade(var_4)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_12 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_13 = vectornormalize(anglesToForward(var_3.angles)) * 16;
    var_6 = int(var_6);
    var_6++;
    var_14 = var_4;
    var_15 = validate_current_weapon(var_6, var_5, var_4);
    var_7 = get_pap_offhand_weapon(var_3, var_4);
    var_10 = get_pap_camo(var_6, var_5, var_4);
    var_11 = should_use_old_model(var_6, var_5, var_4);
    process_pap_stat_logging(var_5, var_3);
    thread play_pap_vo(var_3);
    var_9 = return_pap_attachment(var_3, var_6, var_5, var_4);
    if(isDefined(var_9) && var_9 == "replace_me") {
      var_9 = undefined;
    }

    var_10 = filter_current_weapon_attachments(var_4);
    var_11 = remove_invalid_wm_attachments(var_10);
    var_4 = var_3 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_15, undefined, var_11);
    var_12 = var_3 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_15, var_9, var_11, undefined, var_10);
    var_13 = var_3 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_15, var_9, var_10, undefined, var_10);
    if(var_11) {
      var_14 = spawn("script_weapon", var_3 getEye() + var_13, 0, 0, var_14);
    } else {
      var_14 = spawn("script_weapon", var_4 getEye() + var_14, 0, 0, var_5);
    }

    var_14.angles = var_2.angles;
    if(var_11) {
      var_15 = disco_getoffsetfrombaseweaponname(var_14);
    } else {
      var_15 = disco_getoffsetfrombaseweaponname(var_14);
    }

    level thread releasemachineonplayerdisconnect(var_3, var_14, var_2);
    level notify("pap_used", var_3, var_6, var_13);
    var_14 makeunusable();
    var_3 thread disco_playpapgesture(var_3, var_3.pap_gesture, var_7, var_4, var_14);
    var_3.paping_weapon = var_4;
    if(var_11) {
      var_16 = getangleoffset(var_14, var_12);
    } else {
      var_16 = getangleoffset(var_14, var_13);
    }

    var_17 = scripts\cp\zombies\interaction_weapon_upgrade::getpos1offset(var_5);
    var_14 moveto(var_12.origin + var_17, 0.75);
    var_14 rotateto(var_16, 0.75);
    var_14 waittill("movedone");
    var_14 moveto(var_12.origin + var_15, 0.25);
    var_14 waittill("movedone");
    update_level_pap_machines("door", "close", undefined, undefined, "zmb_packapunch_machine_on");
    wait(0.75);
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      update_level_pap_machines("papfx", "normal", "papfx", "upgraded");
    }

    wait(3.5);
    update_level_pap_machines("door", "decomp");
    wait(0.8);
    var_14 setmoverweapon(var_12);
    wait(0.4);
    update_level_pap_machines("door", "open_idle");
    update_level_pap_machines("papfx", "idle");
    wait(0.5);
    var_14 makeusable();
    var_14 setuserange(100);
    if(var_3 scripts\cp\utility::is_valid_player()) {
      foreach(var_19 in level.players) {
        if(var_19 == var_3) {
          var_14 enableplayeruse(var_19);
          continue;
        }

        var_14 disableplayeruse(var_19);
      }

      if(var_15 == "iw7_katana_zm_pap1") {
        var_3 scripts\cp\zombies\achievement::update_achievement("SLICED_AND_DICED", 1);
        var_3 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_katana_1", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
      } else if(var_15 == "iw7_katana_zm_pap2") {
        var_3 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_katana_2", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
      } else if(var_15 == "iw7_nunchucks_zm_pap1") {
        var_3 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_nunchucks_1", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
      } else if(var_15 == "iw7_nunchucks_zm_pap2") {
        var_3 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap_nunchucks_2", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
      }

      var_3 scripts\cp\cp_merits::processmerit("mt_upgrade_weapons");
    }

    var_14 thread wait_for_player_to_take_weapon(var_13, var_8, var_6);
    var_14 scripts\engine\utility::waittill_any_timeout(30, "weapon_taken");
    if(var_3 scripts\cp\utility::is_valid_player()) {
      var_3 notify("weapon_purchased");
      var_3.paping_weapon = undefined;
      var_3 scripts\cp\cp_interaction::refresh_interaction();
      var_3 scripts\cp\cp_merits::processmerit("mt_dlc3_upgrade_weapons");
    }

    var_14 delete();
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
    level notify("pap_machine_activated");
  }
}

wait_for_player_to_take_weapon(var_0, var_1, var_2) {
  self endon("death");
  self waittill("trigger", var_3);
  if(!isDefined(var_1)) {
    var_1 = "iw7_fists_zm";
  }

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

  if(scripts\cp\zombies\interaction_weapon_upgrade::should_take_players_current_weapon(var_3)) {
    var_9 = var_3 getcurrentweapon();
    var_10 = scripts\cp\utility::getrawbaseweaponname(var_9);
    var_3 takeweapon(var_9);
  }

  self notify("weapon_taken");
  var_0 = var_3 scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 0);
  var_3 givemaxammo(var_0);
  var_11 = var_3 getweaponslistprimaries();
  foreach(var_6 in var_11) {
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

disco_playpapgesture(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_player_fists_weapon(var_0);
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

get_player_fists_weapon(var_0) {
  if(isDefined(var_0.vo_prefix)) {
    switch (var_0.vo_prefix) {
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

getangleoffset(var_0, var_1) {
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_3 = var_1.angles;
  switch (var_2) {
    case "iw7_nunchucks":
    case "iw7_katana":
    case "iw7_spiked":
    case "iw7_golf":
    case "iw7_two":
    case "iw7_machete":
      return (90, 90, 0);

    default:
      return var_3;
  }
}

disco_getoffsetfrombaseweaponname(var_0) {
  var_1 = scripts\cp\utility::getbaseweaponname(var_0);
  var_2 = scripts\cp\zombies\interaction_weapon_upgrade::getoffsetfrombaseweaponname(var_0);
  switch (var_1) {
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
      return var_2;
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
      case "nunchucks":
      case "katana":
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

cp_town_pap_machine_func(var_0, var_1) {
  level.pap_machine = var_1;
  level.pap_machine hide();
  var_0.powered_on = 1;
}

place_fuses_in_machine(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
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
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("pap_upgrade", "zmb_pap_vo", "high");
  }
}

upgrade_machine_for_all_players() {
  foreach(var_1 in level.player_pap_machines) {
    var_1 setModel("zmb_pap_machine_animated_soul_key");
  }

  scripts\engine\utility::waitframe();
}

update_level_pap_machines(var_0, var_1, var_2, var_3, var_4) {
  var_5 = isDefined(var_2) && isDefined(var_3);
  foreach(var_7 in level.player_pap_machines) {
    if(isDefined(var_4)) {
      var_7 playSound(var_4);
    }

    if(scripts\engine\utility::istrue(level.placed_alien_fuses) && var_5) {
      var_7 setscriptablepartstate(var_2, var_3);
      continue;
    }

    var_7 setscriptablepartstate(var_0, var_1);
  }
}

releasemachineonplayerdisconnect(var_0, var_1, var_2) {
  level endon("pap_machine_activated");
  var_0 waittill("disconnect");
  update_level_pap_machines("door", "decomp");
  wait(1.2);
  update_level_pap_machines("door", "open_idle");
  update_level_pap_machines("papfx", "idle");
  var_1 delete();
  wait(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  level notify("pap_machine_activated");
}

can_use_pap_machine(var_0) {
  if(var_0 == "dischord" || var_0 == "facemelter" || var_0 == "headcutter" || var_0 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      return 0;
    }

    return 1;
  }

  return 1;
}

get_pap_offhand_weapon(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  foreach(var_4 in var_2) {
    if(!issubstr(var_1, var_4) && !scripts\cp\utility::isstrstart(var_4, "alt_") && !issubstr(var_4, "knife") && var_4 != "iw7_knife_zm_disco") {
      return var_4;
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

      default:
        return var_2;
    }
  }

  return var_2;
}

should_use_old_model(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    switch (var_1) {
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

get_pap_camo(var_0, var_1, var_2) {
  var_3 = undefined;
  if(isDefined(var_1)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_1)) {
      var_3 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(var_0) && var_0 == 2) {
      var_3 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var_0) && var_0 == 3) {
      var_3 = level.pap_2_camo;
    }

    switch (var_1) {
      case "dischord":
        var_2 = "iw7_dischord_zm_pap1";
        var_3 = "camo20";
        break;

      case "facemelter":
        var_2 = "iw7_facemelter_zm_pap1";
        var_3 = "camo22";
        break;

      case "headcutter":
        var_2 = "iw7_headcutter_zm_pap1";
        var_3 = "camo21";
        break;

      case "nunchucks":
      case "katana":
        var_3 = "camo222";
        break;

      case "forgefreeze":
        if(var_0 == 2) {
          var_2 = "iw7_forgefreeze_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_forgefreeze_zm_pap2";
        }

        var_4 = 1;
        break;

      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        var_4 = 1;
        break;

      case "shredder":
        var_2 = "iw7_shredder_zm_pap1";
        var_3 = "camo23";
        break;
    }
  }

  return var_3;
}

play_pap_vo(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("weapon_pap", "rave_pap_vo", "high");
}

process_pap_stat_logging(var_0, var_1) {
  level.timespapused++;
  scripts\cp\zombies\zombie_analytics::log_papused(level.wave_num, var_0, level.timespapused);
}

filter_current_weapon_attachments(var_0) {
  var_1 = getweaponattachments(var_0);
  if(issubstr(var_0, "g18_z")) {
    foreach(var_3 in var_1) {
      if(issubstr(var_3, "akimbo")) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }
    }
  }

  return var_1;
}

remove_invalid_wm_attachments(var_0) {
  var_1 = var_0;
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "silencer") || issubstr(var_3, "arcane") || issubstr(var_3, "ark")) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  return var_0;
}

weapon_upgrade_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return &"CP_TOWN_PAP_UPGRADE";
  }

  level.interactions[var_0.script_noteworthy].cost = 5000;
  var_2 = var_1 getcurrentweapon();
  var_3 = scripts\cp\cp_weapon::get_weapon_level(var_2);
  if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    if(var_3 == 3) {
      return &"COOP_INTERACTIONS_UPGRADE_MAXED";
    } else if(!can_upgrade(var_2)) {
      return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
    } else if(var_3 == 1) {
      return &"CP_TOWN_UPGRADE_WEAPON";
    } else {
      return &"CP_TOWN_UPGRADE_WEAPON";
    }

    return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
  }

  if(var_3 == level.pap_max) {
    return &"COOP_INTERACTIONS_UPGRADE_MAXED";
  } else if(var_1 scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    return "";
  } else if(!can_upgrade(var_2)) {
    return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
  } else if(var_3 == 1) {
    return &"CP_TOWN_UPGRADE_WEAPON";
  } else {
    return &"CP_TOWN_UPGRADE_WEAPON";
  }

  return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
}

can_upgrade(var_0, var_1) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(level.pap[var_2])) {
    var_3 = getsubstr(var_2, 0, var_2.size - 1);
    if(!isDefined(level.pap[var_3])) {
      return 0;
    }
  }

  if(isDefined(self.ephemeralweapon) && getweaponbasename(self.ephemeralweapon) == getweaponbasename(var_0)) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return 1;
  }

  if(var_2 == "dischord" || var_2 == "facemelter" || var_2 == "headcutter" || var_2 == "shredder") {
    if(!scripts\engine\utility::flag("fuses_inserted")) {
      if(scripts\engine\utility::istrue(var_1)) {
        return 1;
      } else {
        return 0;
      }
    } else if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl == 2) {
      return 0;
    }
  }

  if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
    if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= 3) {
      return 0;
    } else {
      return 1;
    }
  }

  if(scripts\engine\utility::istrue(var_1) && isDefined(self.pap[var_2]) && self.pap[var_2].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= level.pap_max) {
    return 0;
  }

  return 1;
}