/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3399.gsc
************************/

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
  var_00 = scripts\engine\utility::getstruct("arkpink,pink", "script_noteworthy");
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("tag_origin_ground_essence");
  var_02 = spawnfx(level._effect["pink_ark_spawn"], var_00.origin);
  triggerfx(var_02);
  wait(1);
  var_01 setscriptablepartstate("miniufo", "pink");
  var_01 thread flytogatormouth(var_01, var_00, var_02);
  scripts\engine\utility::flag_set("all_attachments_deposited");
  level notify("all_attachments_deposited");
  var_03 = getent("master_arcane_deposit", "targetname");
  var_03 makeunusable();
  var_04 = getomnvarvalue("pink");
  if(isDefined(var_04)) {
    level scripts\cp\utility::set_quest_icon(var_04);
  }

  var_05 = scripts\engine\utility::getstruct("ark_quest_station", "script_noteworthy");
  var_05.buy_loc = var_01;
  add_white_ark_attachment_pickup(var_05);
}

whereami(param_00) {
  for(;;) {
    scripts\engine\utility::draw_line_for_time(param_00.origin, param_00.origin + (0, 0, 200), 1, 0, 0, 0.25);
    wait(0.25);
  }
}

flytogatormouth(param_00, param_01, param_02) {
  param_02 delete();
  playFXOnTag(level._effect["pink_essense"], param_00, "tag_origin");
  var_03 = param_01;
  var_04 = scripts\engine\utility::getstruct(var_03.target, "targetname");
  var_05 = undefined;
  for(;;) {
    var_06 = get_move_rate(param_00, var_03.origin, var_04.origin, 400);
    param_00 moveto(var_04.origin, var_06);
    param_00 waittill("movedone");
    var_03 = var_04;
    if(isDefined(var_05)) {
      param_00 dontinterpolate();
      param_00.origin = var_05.origin;
      var_03 = var_05;
      var_05 = undefined;
    }

    if(isDefined(var_03.target)) {
      var_04 = scripts\engine\utility::getstruct(var_03.target, "targetname");
    } else {
      break;
    }

    if(isDefined(var_04.script_noteworthy) && var_04.script_noteworthy == "arcane_struct_portal") {
      var_05 = scripts\engine\utility::getstruct(var_04.target, "targetname");
    }
  }

  scripts\engine\utility::flag_set("pink_essence_arrived");
}

get_move_rate(param_00, param_01, param_02, param_03) {
  var_04 = distance(param_01, param_02);
  if(!isDefined(param_03)) {
    param_03 = min(10 + level.wave_num * 5, 150);
  }

  var_05 = var_04 / param_03;
  if(var_05 < 0.05) {
    var_05 = 0.05;
  }

  return var_05;
}

wait_for_ufo_quest_completion() {
  var_00 = getent("master_arcane_deposit", "targetname");
  var_00 makeunusable();
  var_00 makeusable();
  var_00 setcursorhint("HINT_NODISPLAY");
  var_01 = scripts\engine\utility::getstructarray(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.script_noteworthy) && var_03.script_noteworthy == "arkpink,pink") {
      continue;
    }

    var_03 thread wait_for_ark_placed(var_00, var_03);
  }
}

wait_for_ark_placed(param_00, param_01) {
  param_01.model = spawn("script_model", param_01.origin);
  param_01.model setModel("tag_origin");
  var_02 = strtok(param_01.script_noteworthy, ",");
  var_03 = var_02[1];
  var_04 = undefined;
  scripts\engine\utility::flag_wait(var_03 + "_crystal_placed");
  var_05 = 0;
  for(;;) {
    param_00 waittill("trigger", var_06);
    if(!var_05) {
      param_00 playLoopSound("arc_machine_on_idle_lp");
      var_05 = 1;
    }

    var_07 = var_06 getcurrentweapon();
    level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_return_arcanecore");
    if(scripts\cp\utility::weaponhasattachment(var_07, var_02[0])) {
      wait(0.1);
      scripts\cp\zombies\zombies_weapons::clear_arcane_effects(var_06);
      var_06 setscriptablepartstate("arcane", "arcane_disperse", 0);
      var_06 takeweapon(var_07);
      var_08 = getweaponattachments(var_07);
      var_09 = scripts\cp\utility::getcurrentcamoname(var_07);
      var_0A = var_06 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_07, "arcane_base", var_08, undefined, var_09);
      var_0A = var_06 scripts\cp\utility::_giveweapon(var_0A, undefined, undefined, 1);
      var_06 switchtoweapon(var_0A);
      switch (var_03) {
        case "blue":
          param_01.model playSound("arc_machine_place_blue_ark");
          break;

        case "green":
          param_01.model playSound("arc_machine_place_green_ark");
          break;

        case "red":
          param_01.model playSound("arc_machine_place_red_ark");
          break;

        case "yellow":
          param_01.model playSound("arc_machine_place_yellow_ark");
          break;
      }

      var_0B = param_01.origin + (0, 0, 8);
      var_0C = spawnfx(level._effect["neil_repair_sparks"], var_0B);
      wait(0.1);
      triggerfx(var_0C);
      wait(0.1);
      var_0C delete();
      var_0D = spawn("script_model", var_0B);
      var_0D setModel("tag_origin_ground_essence");
      scripts\engine\utility::waitframe();
      var_0D setscriptablepartstate("miniufo", var_03);
      break;
    } else {
      continue;
    }
  }

  var_0E = getomnvarvalue(var_03);
  if(isDefined(var_0E)) {
    level scripts\cp\utility::set_quest_icon(var_0E);
  }

  param_01.model makeunusable();
  var_0F = var_03 + "_ark_quest";
  scripts\engine\utility::flag_set(var_0F);
}

getomnvarvalue(param_00) {
  var_01 = undefined;
  switch (param_00) {
    case "blue":
      var_01 = 1;
      break;

    case "red":
      var_01 = 4;
      break;

    case "pink":
      var_01 = 5;
      break;

    case "yellow":
      var_01 = 3;
      break;

    case "green":
      var_01 = 2;
      break;

    default:
      break;
  }

  return var_01;
}

ark_quest_hint_func(param_00, param_01) {
  if(isDefined(param_00.crystals) && param_00.crystals.size >= 1) {
    return &"CP_QUEST_WOR_PART";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

has_white_ark_hint_func(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.has_white_ark)) {
    return;
  }

  if(!scripts\cp\cp_weapon::can_use_attachment("arkpink", param_01 getcurrentweapon())) {
    return;
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}

ark_quest_activation(param_00, param_01) {
  if(!isDefined(param_00.crystals)) {
    return;
  }

  if(param_00.crystals.size < 1) {
    return;
  }

  var_02 = 0;
  var_03 = undefined;
  foreach(var_05 in param_00.crystals) {
    var_06 = strtok(var_05.model, "_");
    var_07 = var_06[3];
    var_05 makeunusable();
    var_05 setModel("tag_origin");
    scripts\engine\utility::flag_set(var_07 + "_crystal_placed");
    param_00.crystals = undefined;
  }
}

add_white_ark_to_weapon(param_00, param_01) {
  var_02 = param_01 getcurrentweapon();
  var_03 = param_01 scripts\cp\cp_weapon::add_attachment_to_weapon("arkpink", var_02);
  if(!var_03) {
    return;
  }

  param_01 getraidspawnpoint();
  while(param_01 isswitchingweapon()) {
    wait(0.05);
  }

  param_01 enableweaponswitch();
  param_01.has_white_ark = 1;
  scripts\cp\zombies\zombie_analytics::log_pink_ark_obtained(level.wave_num);
  level thread play_exquisite_essence_vo(param_01);
  param_01 scripts\cp\zombies\achievement::update_achievement("BATTERIES_NOT_INCLUDED", 1);
  param_01 thread watchforplayerdeath(param_01);
  param_01 thread watchforattachmentremoved(param_01);
}

play_exquisite_essence_vo(param_00) {
  param_00 endon("disconnect");
  param_00 endon("death");
  if(randomint(100) > 70) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_pink_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    wait(scripts\cp\cp_vo::get_sound_length(param_00.vo_prefix + "quest_arcane_pink_essence"));
  } else {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("part_collect_exquisite", "zmb_comment_vo", "low", 10, 0, 0, 0, 45);
    wait(scripts\cp\cp_vo::get_sound_length(param_00.vo_prefix + "part_collect_exquisite"));
  }

  level thread scripts\cp\cp_vo::try_to_play_vo("ww_arcane_exquisiteattach_complete", "zmb_ww_vo", "high", 60, 0, 0, 1);
}

watchforplayerdeath(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_01 = 1;
  while(scripts\engine\utility::istrue(param_00.has_white_ark)) {
    if(!var_01) {
      param_00.has_white_ark = undefined;
      break;
    }

    var_02 = undefined;
    param_00 waittill("last_stand");
    var_01 = 0;
    var_03 = param_00 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive");
    if(var_03 == "player_entered_ala") {
      var_02 = param_00 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
    }

    if(isDefined(var_02) && var_02 == "lost_and_found_time_out") {
      continue;
    }

    var_04 = param_00 getweaponslistall();
    foreach(var_06 in var_04) {
      if(issubstr(var_06, "arkpink")) {
        var_07 = 1;
        param_00 thread watchforattachmentremoved(param_00);
        break;
      }
    }
  }
}

watchforattachmentremoved(param_00) {
  level endon("game_ended");
  param_00 endon("last_stand");
  param_00 endon("disconnect");
  var_01 = 1;
  while(scripts\engine\utility::istrue(param_00.has_white_ark)) {
    if(!var_01) {
      param_00.has_white_ark = undefined;
      break;
    }

    param_00 scripts\engine\utility::waittill_any_3("weapon_purchased", "mule_munchies_sold");
    var_01 = 0;
    var_02 = param_00 getweaponslistall();
    foreach(var_04 in var_02) {
      if(issubstr(var_04, "arkpink")) {
        var_01 = 1;
        break;
      }
    }
  }
}

add_white_ark_attachment_pickup(param_00) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\engine\utility::flag_wait("pink_essence_arrived");
  param_00.script_noteworthy = "white_ark";
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

isarkdamage(param_00, param_01, param_02) {
  return param_00 == "poison_ammo_mp" || param_00 == "incendiary_ammo_mp" || param_00 == "stun_ammo_mp" || param_00 == "slayer_ammo_mp" || issubstr(param_00, "emcpap") || param_01 == "yellow" && param_02 == "MOD_EXPLOSIVE_BULLET" || scripts\engine\utility::isbulletdamage(param_02) && param_01 == "pink";
}