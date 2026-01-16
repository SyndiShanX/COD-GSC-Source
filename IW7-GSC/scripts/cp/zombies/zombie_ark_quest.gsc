/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_ark_quest.gsc
**************************************************/

init_ark_quest() {
  level.ark_quest_pieces = [];
  level.ark_quest_kills = [];
  level.ark_quest_kills["blue"] = 0;
  level.ark_quest_kills["pink"] = 0;
  level.ark_quest_kills["red"] = 0;
  level.ark_quest_kills["yellow"] = 0;
  level.ark_quest_kills["green"] = 0;
  scripts\engine\utility::flag_init("pink_essence_arrived");
  scripts\engine\utility::flag_init("blue_ark_quest");
  scripts\engine\utility::flag_init("yellow_ark_quest");
  scripts\engine\utility::flag_init("pink_ark_quest");
  scripts\engine\utility::flag_init("red_ark_quest");
  scripts\engine\utility::flag_init("green_ark_quest");
  scripts\engine\utility::flag_init("ufo_quest_finished");
  scripts\engine\utility::flag_init("all_attachments_deposited");
  level thread wait_for_ufo_quest_completion();
  level thread wait_for_all_arks_deposited();
}

wait_for_all_arks_deposited() {
  scripts\engine\utility::flag_wait("blue_ark_quest");
  scripts\engine\utility::flag_wait("yellow_ark_quest");
  scripts\engine\utility::flag_wait("red_ark_quest");
  scripts\engine\utility::flag_wait("green_ark_quest");
  var_0 = scripts\engine\utility::getstruct("arkpink,pink", "script_noteworthy");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin_ground_essence");
  var_2 = spawnfx(level._effect["pink_ark_spawn"], var_0.origin);
  triggerfx(var_2);
  wait(1);
  var_1 setscriptablepartstate("miniufo", "pink");
  var_1 thread flytogatormouth(var_1, var_0, var_2);
  scripts\engine\utility::flag_set("all_attachments_deposited");
  level notify("all_attachments_deposited");
  var_3 = getent("master_arcane_deposit", "targetname");
  var_3 makeunusable();
  var_4 = getomnvarvalue("pink");
  if(isDefined(var_4)) {
    level scripts\cp\utility::set_quest_icon(var_4);
  }

  var_5 = scripts\engine\utility::getstruct("ark_quest_station", "script_noteworthy");
  var_5.buy_loc = var_1;
  add_white_ark_attachment_pickup(var_5);
}

whereami(var_0) {
  for(;;) {
    scripts\engine\utility::draw_line_for_time(var_0.origin, var_0.origin + (0, 0, 200), 1, 0, 0, 0.25);
    wait(0.25);
  }
}

flytogatormouth(var_0, var_1, var_2) {
  var_2 delete();
  playFXOnTag(level._effect["pink_essense"], var_0, "tag_origin");
  var_3 = var_1;
  var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_5 = undefined;
  for(;;) {
    var_6 = get_move_rate(var_0, var_3.origin, var_4.origin, 400);
    var_0 moveto(var_4.origin, var_6);
    var_0 waittill("movedone");
    var_3 = var_4;
    if(isDefined(var_5)) {
      var_0 dontinterpolate();
      var_0.origin = var_5.origin;
      var_3 = var_5;
      var_5 = undefined;
    }

    if(isDefined(var_3.target)) {
      var_4 = scripts\engine\utility::getstruct(var_3.target, "targetname");
    } else {
      break;
    }

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "arcane_struct_portal") {
      var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
    }
  }

  scripts\engine\utility::flag_set("pink_essence_arrived");
}

get_move_rate(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_1, var_2);
  if(!isDefined(var_3)) {
    var_3 = min(10 + level.wave_num * 5, 150);
  }

  var_5 = var_4 / var_3;
  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  return var_5;
}

wait_for_ufo_quest_completion() {
  var_0 = getent("master_arcane_deposit", "targetname");
  var_0 makeunusable();
  var_0 makeusable();
  var_0 setcursorhint("HINT_NODISPLAY");
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "arkpink,pink") {
      continue;
    }

    var_3 thread wait_for_ark_placed(var_0, var_3);
  }
}

wait_for_ark_placed(var_0, var_1) {
  var_1.model = spawn("script_model", var_1.origin);
  var_1.model setModel("tag_origin");
  var_2 = strtok(var_1.script_noteworthy, ",");
  var_3 = var_2[1];
  var_4 = undefined;
  scripts\engine\utility::flag_wait(var_3 + "_crystal_placed");
  var_5 = 0;
  for(;;) {
    var_0 waittill("trigger", var_6);
    if(!var_5) {
      var_0 playLoopSound("arc_machine_on_idle_lp");
      var_5 = 1;
    }

    var_7 = var_6 getcurrentweapon();
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_arcanecore");
    if(scripts\cp\utility::weaponhasattachment(var_7, var_2[0])) {
      wait(0.1);
      scripts\cp\zombies\zombies_weapons::clear_arcane_effects(var_6);
      var_6 setscriptablepartstate("arcane", "arcane_disperse", 0);
      var_6 takeweapon(var_7);
      var_8 = getweaponattachments(var_7);
      var_9 = scripts\cp\utility::getcurrentcamoname(var_7);
      var_10 = var_6 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_7, "arcane_base", var_8, undefined, var_9);
      var_10 = var_6 scripts\cp\utility::_giveweapon(var_10, undefined, undefined, 1);
      var_6 switchtoweapon(var_10);
      switch (var_3) {
        case "blue":
          var_1.model playSound("arc_machine_place_blue_ark");
          break;

        case "green":
          var_1.model playSound("arc_machine_place_green_ark");
          break;

        case "red":
          var_1.model playSound("arc_machine_place_red_ark");
          break;

        case "yellow":
          var_1.model playSound("arc_machine_place_yellow_ark");
          break;
      }

      var_11 = var_1.origin + (0, 0, 8);
      var_12 = spawnfx(level._effect["neil_repair_sparks"], var_11);
      wait(0.1);
      triggerfx(var_12);
      wait(0.1);
      var_12 delete();
      var_13 = spawn("script_model", var_11);
      var_13 setModel("tag_origin_ground_essence");
      scripts\engine\utility::waitframe();
      var_13 setscriptablepartstate("miniufo", var_3);
      break;
    } else {
      continue;
    }
  }

  var_14 = getomnvarvalue(var_3);
  if(isDefined(var_14)) {
    level scripts\cp\utility::set_quest_icon(var_14);
  }

  var_1.model makeunusable();
  var_15 = var_3 + "_ark_quest";
  scripts\engine\utility::flag_set(var_15);
}

getomnvarvalue(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "blue":
      var_1 = 1;
      break;

    case "red":
      var_1 = 4;
      break;

    case "pink":
      var_1 = 5;
      break;

    case "yellow":
      var_1 = 3;
      break;

    case "green":
      var_1 = 2;
      break;

    default:
      break;
  }

  return var_1;
}

ark_quest_hint_func(var_0, var_1) {
  if(isDefined(var_0.crystals) && var_0.crystals.size >= 1) {
    return &"CP_QUEST_WOR_PART";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

has_white_ark_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.has_white_ark)) {
    return;
  }

  if(!scripts\cp\cp_weapon::can_use_attachment("arkpink", var_1 getcurrentweapon())) {
    return;
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

ark_quest_activation(var_0, var_1) {
  if(!isDefined(var_0.crystals)) {
    return;
  }

  if(var_0.crystals.size < 1) {
    return;
  }

  var_2 = 0;
  var_3 = undefined;
  foreach(var_5 in var_0.crystals) {
    var_6 = strtok(var_5.model, "_");
    var_7 = var_6[3];
    var_5 makeunusable();
    var_5 setModel("tag_origin");
    scripts\engine\utility::flag_set(var_7 + "_crystal_placed");
    var_0.crystals = undefined;
  }
}

add_white_ark_to_weapon(var_0, var_1) {
  var_2 = var_1 getcurrentweapon();
  var_3 = var_1 scripts\cp\cp_weapon::add_attachment_to_weapon("arkpink", var_2);
  if(!var_3) {
    return;
  }

  var_1 getraidspawnpoint();
  while(var_1 isswitchingweapon()) {
    wait(0.05);
  }

  var_1 enableweaponswitch();
  var_1.has_white_ark = 1;
  scripts\cp\zombies\zombie_analytics::log_pink_ark_obtained(level.wave_num);
  level thread play_exquisite_essence_vo(var_1);
  var_1 scripts\cp\zombies\achievement::update_achievement("BATTERIES_NOT_INCLUDED", 1);
  var_1 thread watchforplayerdeath(var_1);
  var_1 thread watchforattachmentremoved(var_1);
}

play_exquisite_essence_vo(var_0) {
  var_0 endon("disconnect");
  var_0 endon("death");
  if(randomint(100) > 70) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_pink_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "quest_arcane_pink_essence"));
  } else {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("part_collect_exquisite", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
    wait(scripts\cp\cp_vo::get_sound_length(var_0.vo_prefix + "part_collect_exquisite"));
  }

  level thread scripts\cp\cp_vo::try_to_play_vo("ww_arcane_exquisiteattach_complete", "zmb_ww_vo", "high", 60, 0, 0, 1);
}

watchforplayerdeath(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = 1;
  while(scripts\engine\utility::istrue(var_0.has_white_ark)) {
    if(!var_1) {
      var_0.has_white_ark = undefined;
      break;
    }

    var_2 = undefined;
    var_0 waittill("last_stand");
    var_1 = 0;
    var_3 = var_0 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive");
    if(var_3 == "player_entered_ala") {
      var_2 = var_0 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
    }

    if(isDefined(var_2) && var_2 == "lost_and_found_time_out") {
      continue;
    }

    var_4 = var_0 getweaponslistall();
    foreach(var_6 in var_4) {
      if(issubstr(var_6, "arkpink")) {
        var_7 = 1;
        var_0 thread watchforattachmentremoved(var_0);
        break;
      }
    }
  }
}

watchforattachmentremoved(var_0) {
  level endon("game_ended");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_1 = 1;
  while(scripts\engine\utility::istrue(var_0.has_white_ark)) {
    if(!var_1) {
      var_0.has_white_ark = undefined;
      break;
    }

    var_0 scripts\engine\utility::waittill_any("weapon_purchased", "mule_munchies_sold");
    var_1 = 0;
    var_2 = var_0 getweaponslistall();
    foreach(var_4 in var_2) {
      if(issubstr(var_4, "arkpink")) {
        var_1 = 1;
        break;
      }
    }
  }
}

add_white_ark_attachment_pickup(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_wait("pink_essence_arrived");
  var_0.script_noteworthy = "white_ark";
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

isarkdamage(var_0, var_1, var_2) {
  return var_0 == "poison_ammo_mp" || var_0 == "incendiary_ammo_mp" || var_0 == "stun_ammo_mp" || var_0 == "slayer_ammo_mp" || issubstr(var_0, "emcpap") || var_1 == "yellow" && var_2 == "MOD_EXPLOSIVE_BULLET" || scripts\engine\utility::isbulletdamage(var_2) && var_1 == "pink";
}