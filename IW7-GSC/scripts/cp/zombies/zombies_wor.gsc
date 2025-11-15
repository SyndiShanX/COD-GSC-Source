/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_wor.gsc
**********************************************/

init() {
  scripts\engine\utility::flag_init("dischord_glasses_pickedup");
  scripts\engine\utility::flag_init("green_crystal_placed");
  scripts\engine\utility::flag_init("red_crystal_placed");
  scripts\engine\utility::flag_init("blue_crystal_placed");
  scripts\engine\utility::flag_init("yellow_crystal_placed");
  scripts\engine\utility::flag_init("dj_wor_use_nag_init");
  scripts\engine\utility::flag_wait("pre_game_over");
  level.ww_hintstrings["iw7_headcutter_zm"] = & "CP_QUEST_WOR_TAKE_HC";
  level.ww_hintstrings["iw7_shredder_zm"] = & "CP_QUEST_WOR_TAKE_SHREDDER";
  level.ww_hintstrings["iw7_facemelter_zm"] = & "CP_QUEST_WOR_TAKE_FACEMELTER";
  level.ww_hintstrings["iw7_dischord_zm"] = & "CP_QUEST_WOR_TAKE_DISCHORD";
  level thread init_wor_items();
  level.head_cutter_trap_kills = 0;
  level.angry_mike_trap_kills = 0;
  level.spinner_trap_kills = 0;
  level.rocket_trap_kills = 0;
  level.total_cryo_kills = 0;
  level.disco_trap_kills = 0;
  level.miniufos = [];
  level.quest_death_update_func = ::wor_quest_death_update_func;
  level.quest_pillage_func = ::wor_quest_pillage_func;
  level.quest_specific_pillage_show_func = ::wor_quest_specific_pillage_show_func;
  level.quest_create_pillage_interaction = ::wor_quest_create_pillage_interaction;
  level.closest_crystal_func = ::returnclosestcrystal;
  level.crystal_check_func = ::ent_near_crystal;
  level.crystal_killed_notify = "kill_near_crystal";
  level.skip_crystal_logic = 0;
  level thread wor_quest_crafting_func();
  level thread dischord_glasses_listener();
  level thread dj_quest_vo_init_timer();
  level thread init_dischord_glasses_power();
  level thread headcutter_freeze_test();
  level thread getarkqueststruct();
}

getarkqueststruct() {
  var_00 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(var_02.script_noteworthy)) {
      continue;
    }

    if(var_02.script_noteworthy == "ark_quest_station") {
      level.arkqueststation = var_02;
      break;
    }
  }
}

wor_init() {
  thread listen_for_triton_power();
  thread init_wor_items();
  thread listen_for_grenade_in_volume();
}

init_wor_items() {
  if(isDefined(level.wor_items_picked_up)) {
    return;
  }

  level.wor_items_picked_up = [];
  level.wor_items_picked_up["iw7_headcutter_zm"] = [];
  level.wor_items_picked_up["iw7_headcutter_zm"]["toy"] = 0;
  level.wor_items_picked_up["iw7_headcutter_zm"]["crystal"] = 0;
  level.wor_items_picked_up["iw7_headcutter_zm"]["battery"] = 0;
  level.wor_items_picked_up["iw7_headcutter_zm"]["weapon"] = 0;
  level.wor_items_picked_up["iw7_facemelter_zm"] = [];
  level.wor_items_picked_up["iw7_facemelter_zm"]["toy"] = 0;
  level.wor_items_picked_up["iw7_facemelter_zm"]["crystal"] = 0;
  level.wor_items_picked_up["iw7_facemelter_zm"]["battery"] = 0;
  level.wor_items_picked_up["iw7_facemelter_zm"]["weapon"] = 0;
  level.wor_items_picked_up["iw7_shredder_zm"] = [];
  level.wor_items_picked_up["iw7_shredder_zm"]["toy"] = 0;
  level.wor_items_picked_up["iw7_shredder_zm"]["crystal"] = 0;
  level.wor_items_picked_up["iw7_shredder_zm"]["battery"] = 0;
  level.wor_items_picked_up["iw7_shredder_zm"]["weapon"] = 0;
  level.wor_items_picked_up["iw7_dischord_zm"] = [];
  level.wor_items_picked_up["iw7_dischord_zm"]["toy"] = 0;
  level.wor_items_picked_up["iw7_dischord_zm"]["crystal"] = 0;
  level.wor_items_picked_up["iw7_dischord_zm"]["battery"] = 0;
  level.wor_items_picked_up["iw7_dischord_zm"]["weapon"] = 0;
  level.wor_items_placed = [];
  level.wor_items_placed["iw7_headcutter_zm"] = [];
  level.wor_items_placed["iw7_headcutter_zm"]["toy"] = 0;
  level.wor_items_placed["iw7_headcutter_zm"]["crystal"] = 0;
  level.wor_items_placed["iw7_headcutter_zm"]["battery"] = 0;
  level.wor_items_placed["iw7_headcutter_zm"]["weapon"] = 0;
  level.wor_items_placed["iw7_facemelter_zm"] = [];
  level.wor_items_placed["iw7_facemelter_zm"]["toy"] = 0;
  level.wor_items_placed["iw7_facemelter_zm"]["crystal"] = 0;
  level.wor_items_placed["iw7_facemelter_zm"]["battery"] = 0;
  level.wor_items_placed["iw7_facemelter_zm"]["weapon"] = 0;
  level.wor_items_placed["iw7_shredder_zm"] = [];
  level.wor_items_placed["iw7_shredder_zm"]["toy"] = 0;
  level.wor_items_placed["iw7_shredder_zm"]["crystal"] = 0;
  level.wor_items_placed["iw7_shredder_zm"]["battery"] = 0;
  level.wor_items_placed["iw7_shredder_zm"]["weapon"] = 0;
  level.wor_items_placed["iw7_dischord_zm"] = [];
  level.wor_items_placed["iw7_dischord_zm"]["toy"] = 0;
  level.wor_items_placed["iw7_dischord_zm"]["crystal"] = 0;
  level.wor_items_placed["iw7_dischord_zm"]["battery"] = 0;
  level.wor_items_placed["iw7_dischord_zm"]["weapon"] = 0;
}

init_standee_slots(param_00, param_01) {
  self.gun_slot = spawnStruct();
  self.gun_slot.standee = self.standee;
  self.gun_slot.finished = 0;
  self.gun_slot.gun = param_01;
  self.gun_slot setup_standee_data(param_01);
  var_02 = [1, 2, 3];
  foreach(var_04 in var_02) {
    level thread[[param_00]](self.gun_slot, var_04);
  }
}

put_gun_back_on_standee(param_00, param_01, param_02, param_03) {
  level notify("gun_replaced " + param_01);
  if(isDefined(param_02)) {
    var_04 = isDefined(param_03) && isDefined(param_03.ephemeralweapon) && issubstr(param_03.ephemeralweapon, param_01);
    if(issubstr(param_02, "pap1") && !var_04) {
      param_00.standee.upgraded = 1;
    } else {
      param_00.standee.upgraded = 0;
    }
  } else {
    param_00.standee.upgraded = 0;
  }

  param_00.standee.gun_on_standee = 1;
  param_00.standee setscriptablepartstate("zapper", "craft_zapper", 1);
}

standee_hint_logic(param_00, param_01) {
  var_02 = param_00.standee;
  if(level.wor_items_placed[var_02.script_noteworthy]["toy"] && level.wor_items_placed[var_02.script_noteworthy]["battery"] && level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
    if(var_02.gun_on_standee) {
      return level.ww_hintstrings[var_02.script_noteworthy];
    } else {
      var_03 = param_01 getcurrentweapon();
      var_04 = getweaponbasename(var_03);
      if(issubstr(var_04, param_00.gun_slot.gun)) {
        return param_00.gun_slot.place_on_standee_string;
      } else {
        return "";
      }
    }
  }

  if(level.wor_items_picked_up[var_02.script_noteworthy]["toy"] && !level.wor_items_placed[var_02.script_noteworthy]["toy"]) {
    return & "CP_QUEST_WOR_PLACE_PART";
  } else if(level.wor_items_picked_up[var_02.script_noteworthy]["battery"] && !level.wor_items_placed[var_02.script_noteworthy]["battery"]) {
    return & "CP_QUEST_WOR_PLACE_PART";
  } else if(level.wor_items_picked_up[var_02.script_noteworthy]["crystal"] && !level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
    return & "CP_QUEST_WOR_PLACE_PART";
  }

  return & "CP_QUEST_WOR_ASSEMBLY";
}

standee_activate_logic(param_00, param_01) {
  var_02 = param_00.standee;
  if(level.wor_items_placed[var_02.script_noteworthy]["toy"] && level.wor_items_placed[var_02.script_noteworthy]["battery"] && level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
    if(var_02.gun_on_standee) {
      var_02.gun_on_standee = 0;
      var_02 setscriptablepartstate("zapper", "hide_zapper", 1);
      param_01 notify("weapon_purchased");
      wor_give_weapon(param_01, var_02.script_noteworthy, param_00.gun_slot);
      param_01 thread watchforweaponremoved(param_01, var_02.script_noteworthy, param_00.gun_slot);
      param_01 thread watchforplayerdeath(param_01, var_02.script_noteworthy, param_00.gun_slot);
      param_01 thread trackplayersworammo(param_01, var_02.script_noteworthy, param_00.gun_slot);
    } else {
      var_03 = param_01 getcurrentweapon();
      var_04 = getweaponbasename(var_03);
      if(issubstr(var_04, param_00.gun_slot.gun)) {
        var_05 = param_01 scripts\cp\utility::getvalidtakeweapon();
        param_01 takeweapon(var_05);
        var_06 = param_01 getweaponslistprimaries();
        var_07 = 0;
        for(var_08 = 0; var_08 < var_06.size; var_08++) {
          if(var_06[var_08] == "none") {
            continue;
          } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_06[var_08])) {
            continue;
          } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_06[var_08]))) {
            continue;
          } else if(scripts\cp\utility::is_melee_weapon(var_06[var_08], 1)) {
            continue;
          }

          var_07 = 1;
          param_01 switchtoweapon(var_06[var_08]);
          break;
        }

        if(!var_07) {
          var_09 = "iw7_fists_zm";
          param_01 scripts\cp\utility::_giveweapon(var_09, undefined, undefined, 1);
          param_01 switchtoweaponimmediate(var_09);
        }

        thread put_gun_back_on_standee(param_00.gun_slot, param_00.gun_slot.gun, var_03, param_01);
        param_01 scripts\cp\utility::updatelaststandpistol();
      }
    }
  }

  if(level.wor_items_picked_up[var_02.script_noteworthy]["toy"] && !level.wor_items_placed[var_02.script_noteworthy]["toy"]) {
    level.wor_items_placed[var_02.script_noteworthy]["toy"] = 1;
    var_02 place_part("toy");
    if(level.wor_items_placed[var_02.script_noteworthy]["toy"] && level.wor_items_placed[var_02.script_noteworthy]["battery"] && level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
      var_02 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }

  if(level.wor_items_picked_up[var_02.script_noteworthy]["battery"] && !level.wor_items_placed[var_02.script_noteworthy]["battery"]) {
    level.wor_items_placed[var_02.script_noteworthy]["battery"] = 1;
    var_02 place_part("battery");
    if(level.wor_items_placed[var_02.script_noteworthy]["toy"] && level.wor_items_placed[var_02.script_noteworthy]["battery"] && level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
      var_02 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }

  if(level.wor_items_picked_up[var_02.script_noteworthy]["crystal"] && !level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
    level.wor_items_placed[var_02.script_noteworthy]["crystal"] = 1;
    var_02 place_part("crystal");
    if(level.wor_items_placed[var_02.script_noteworthy]["toy"] && level.wor_items_placed[var_02.script_noteworthy]["battery"] && level.wor_items_placed[var_02.script_noteworthy]["crystal"]) {
      var_02 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }
}

place_part(param_00) {
  self setscriptablepartstate(param_00, "part_placed");
  wait(1);
  self setscriptablepartstate(param_00, "part_placed_no_fx");
}

returnclosestcrystal(param_00) {
  return scripts\engine\utility::getclosest(param_00.origin, level.miniufos);
}

ent_near_crystal(param_00, param_01) {
  if(level.miniufos.size < 1) {
    return 0;
  }

  if(!scripts\cp\utility::weaponhasattachment(param_01, "arcane_base")) {
    return 0;
  }

  var_02 = 0;
  foreach(var_04 in level.miniufos) {
    var_05 = 562500;
    if(!isDefined(var_04) || scripts\engine\utility::istrue(var_04.fully_charged)) {
      continue;
    }

    if(distancesquared(var_04.origin, param_00.origin) < var_05) {
      var_02 = 1;
    }

    if(var_02) {
      break;
    }
  }

  if(var_02) {
    return 1;
  }

  return 0;
}

fake_crystal_logic(param_00, param_01, param_02, param_03, param_04) {
  var_05 = get_part_model(param_01, param_03);
  param_00 setModel(var_05);
  wait(0.25);
  var_06 = param_01.placement_fx;
  param_00 makeusable();
  param_00 setuserange(64);
  param_00 setusefov(120);
  var_07 = playFXOnTag(var_06, param_00, "tag_origin");
  param_00 sethintstring( & "CP_QUEST_WOR_PART");
  param_00 waittill("trigger", var_08);
  stopFXOnTag(var_06, param_00, "tag_origin");
  level.wor_items_picked_up[param_01.gun][param_04] = 1;
}

update_ufo_angles(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("fully_charged");
  for(;;) {
    param_00 waittill("next_position_found", var_06, var_07);
    var_08 = vectortoangles(var_07.origin - var_06.origin) + (180, 0, 0);
    param_00 rotateto(var_08, 0.5, 0.05, 0.05);
  }
}

start_crystal_path(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = scripts\engine\utility::getclosest(param_06.origin, scripts\engine\utility::getstructarray("essence_ufo_path", "script_noteworthy"));
  var_08 = 0;
  var_09 = var_07;
  var_0A = 1;
  var_0B = undefined;
  for(var_0C = get_next_valid_struct(param_06, var_09); var_0A; var_0C = var_0F) {
    if(isDefined(var_09.script_speed)) {
      var_0D = var_09.script_speed;
    } else {
      var_0D = undefined;
    }

    var_0E = get_move_rate(param_06, var_09.origin, var_0C.origin, var_0D);
    var_0F = var_0C;
    var_0F = get_next_valid_struct(param_06, var_0F);
    thread changeangledelay(param_06, var_0E, var_0F, var_09, var_0C);
    param_06 moveto(var_0C.origin, var_0E);
    var_10 = param_06 scripts\engine\utility::waittill_any_return("movedone", "fully_charged");
    if(scripts\engine\utility::istrue(param_06.fully_charged)) {
      for(;;) {
        var_0E = get_move_rate(param_06, param_06.origin, var_0C.origin, 2000);
        param_06 moveto(var_0C.origin, var_0E);
        if(can_use_struct_for_final_pos(param_00, var_0C)) {
          var_11 = scripts\engine\utility::drop_to_ground(var_0C.origin, 0, -400) + (0, 0, 40);
          var_12 = magicbullet("bolasprayprojhome_mp", param_06.origin, var_11);
          scripts\engine\utility::play_sound_in_space("miniufo_fire", param_06.origin, 0, param_06);
          param_00 dontinterpolate();
          param_00.origin = var_11;
          param_06.fully_charged = undefined;
          param_06 thread movetotraploop(param_06, param_06.origin, param_01);
          var_12 scripts\engine\utility::waittill_any_timeout_1(1.25, "death");
          if(isDefined(var_12)) {
            var_12 delete();
          }

          param_00.at_end_loc = 1;
          var_0A = 0;
          break;
        } else {
          param_06 waittill("movedone");
          var_09 = var_0C;
          var_0C = get_next_valid_struct(param_06, var_09);
          param_06 notify("next_position_found", var_09, var_0C);
        }
      }

      continue;
    }

    var_09 = var_0C;
  }
}

changeangledelay(param_00, param_01, param_02, param_03, param_04) {
  wait(max(0.05, param_01 - 0.35));
  param_00 notify("next_position_found", param_04, param_02);
}

movetotraploop(param_00, param_01, param_02) {
  param_00 waittill("movedone");
  param_00 setscriptablepartstate("miniufo", "mini_ufo");
  var_03 = scripts\engine\utility::random(param_02.starting_move_structs);
  param_00 setModel("tag_origin");
  param_00.origin = var_03.origin;
  param_00.angles = var_03.angles;
}

can_use_struct_for_final_pos(param_00, param_01) {
  if(isDefined(param_01.name)) {
    if(isDefined(param_01.name == "cant_stop_wont_stop")) {
      return 0;
    }
  }

  return 1;
}

get_next_valid_struct(param_00, param_01) {
  var_02 = scripts\engine\utility::getstructarray(param_01.target, "targetname");
  var_03 = [];
  var_04 = undefined;
  var_04 = scripts\engine\utility::random(var_02);
  return var_04;
}

get_move_rate(param_00, param_01, param_02, param_03) {
  var_04 = distance(param_01, param_02);
  if(!isDefined(param_03)) {
    param_03 = int(clamp(level.wave_num * 15, 75, 150));
  }

  var_05 = var_04 / param_03;
  if(var_05 < 0.05) {
    var_05 = 0.05;
  }

  return var_05;
}

move_crystal_to_end_pos(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(param_00.origin, 0, -400) + (0, 0, 40);
  var_02 = distance(param_00.origin, var_01);
  var_03 = 2000;
  var_04 = var_02 / var_03;
  if(var_04 < 0.05) {
    var_04 = 0.05;
  }

  wait(2);
  param_00 moveto(var_01, var_04);
  param_00.at_end_loc = 1;
}

getminiufostartingstruct(param_00) {
  if(param_00.crystal_model == "zmb_weapon_crystal_green" && isDefined(level.dichordtraptrigger)) {
    return level.dichordtraptrigger;
  }

  if(param_00.crystal_model == "zmb_weapon_crystal_blue" && isDefined(level.fmtraptrigger)) {
    return level.fmtraptrigger;
  }

  if(param_00.crystal_model == "zmb_weapon_crystal_yellow" && isDefined(level.hctraptrigger)) {
    return level.hctraptrigger;
  }

  return scripts\engine\utility::random(param_00.starting_move_structs);
}

getminoufofromorbeffect(param_00, param_01) {
  switch (param_00) {
    case "blue":
      if(!isDefined(level.rocket_mini_ufo)) {
        var_02 = spawn("script_model", param_01.origin);
        var_02 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_02 = level.rocket_mini_ufo;
        if(var_02.model != "tag_origin_mini_ufo") {
          var_02 setModel("tag_origin_mini_ufo");
          var_02 dontinterpolate();
          var_02.origin = param_01.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "green":
      if(!isDefined(level.disco_mini_ufo)) {
        var_02 = spawn("script_model", var_02.origin);
        var_02 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_02 = level.disco_mini_ufo;
        if(var_02.model != "tag_origin_mini_ufo") {
          var_02 setModel("tag_origin_mini_ufo");
          var_02 dontinterpolate();
          var_02.origin = param_01.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "yellow":
      if(!isDefined(level.steel_dragon_mini_ufo)) {
        var_02 = spawn("script_model", var_02.origin);
        var_02 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_02 = level.steel_dragon_mini_ufo;
        if(var_02.model != "tag_origin_mini_ufo") {
          var_02 setModel("tag_origin_mini_ufo");
          var_02 dontinterpolate();
          var_02.origin = param_01.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "red":
      if(!isDefined(level.chromosphere_mini_ufo)) {
        var_02 = spawn("script_model", var_02.origin);
        var_02 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_02 = level.chromosphere_mini_ufo;
        if(var_02.model != "tag_origin_mini_ufo") {
          var_02 setModel("tag_origin_mini_ufo");
          var_02 dontinterpolate();
          var_02.origin = param_01.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    default:
      var_02 = spawn("script_model", var_02.origin);
      var_02 setModel("tag_origin_mini_ufo");
      var_02 dontinterpolate();
      var_02.origin = param_01.origin;
      scripts\engine\utility::waitframe();
      break;
  }

  return var_02;
}

collect_arcane_essense(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = getminiufostartingstruct(param_01);
  var_07 = param_01.largeessencefx;
  var_08 = getminoufofromorbeffect(var_07, var_06);
  var_08 setscriptablepartstate("miniufo", var_07);
  scripts\engine\utility::flag_set("mini_ufo_" + param_01.color + "_collecting");
  var_08 thread start_crystal_path(param_00, param_01, param_02, param_03, param_04, param_05, var_08);
  var_08 thread update_ufo_angles(var_08, param_01, param_02, param_03, param_04, param_05);
  level.miniufos[level.miniufos.size] = var_08;
  wait_for_crystal_to_charge(param_00, param_01, var_08, var_07);
  param_00 makeusable();
  param_00 setuserange(64);
  param_00 setusefov(120);
  param_00.gun_slot = param_01;
  if(scripts\engine\utility::istrue(param_05)) {
    param_00 thread timeout_crystal(param_00, param_01, param_03, var_08);
  }

  param_00 endon("death");
  create_essence_interaction(param_00);
  for(;;) {
    param_00 waittill("mini_ufo_completed", var_09);
    param_00 setscriptablepartstate("miniufo", "neutral");
    param_00 notify("picked_up");
    switch (param_01.color) {
      case "blue":
        var_09 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_blue_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "red":
        var_09 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_red_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "green":
        var_09 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_green_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "yellow":
        var_09 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_yellow_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      default:
        var_09 thread scripts\cp\cp_vo::try_to_play_vo("arcane_core_success", "zmb_comment_vo", "highest", 10, 0, 0, 0, 50);
        break;
    }

    level thread waittillnextwave(var_08, param_01);
    reset_trap_kill_count(param_00, param_01, param_03);
    param_00 makeunusable();
    if(scripts\engine\utility::istrue(param_05)) {
      param_00 delete();
    } else {
      param_00 setModel("tag_origin");
    }

    break;
  }
}

waittillnextwave(param_00, param_01) {
  level waittill("regular_wave_starting");
  if(param_00.model != "tag_origin_mini_ufo") {
    param_00 setModel("tag_origin_mini_ufo");
  }

  scripts\engine\utility::flag_clear("mini_ufo_" + param_01.color + "_collecting");
}

essence_pickup_func(param_00, param_01) {
  if(!isDefined(param_00.at_end_loc)) {
    return;
  }

  if(!scripts\cp\utility::weaponhasattachment(param_01 getcurrentweapon(), "arcane_base")) {
    return;
  }

  param_00 notify("mini_ufo_completed", param_01);
  param_01 playlocalsound("part_pickup");
  remove_essence_interaction(param_00);
  param_01 thread charge_players_arcane_base_attachment(param_01, param_00.gun_slot);
}

create_essence_interaction(param_00) {
  param_00.script_noteworthy = "spawned_essence";
  param_00.requires_power = 0;
  param_00.powered_on = 1;
  param_00.script_parameters = "default";
  param_00.custom_search_dist = 96;
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

remove_essence_interaction(param_00) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.script_noteworthy = undefined;
  param_00.requires_power = undefined;
  param_00.powered_on = undefined;
  param_00.script_parameters = undefined;
  param_00.custom_search_dist = undefined;
}

playufoeffectonplayerconnect(param_00, param_01) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_02);
    thread playeffectwhenspawned(param_00, param_01, var_02);
  }
}

playeffectwhenspawned(param_00, param_01, param_02) {
  level endon("game_ended");
  param_02 endon("disconnect");
  param_02 waittill("spawned_player");
  playFXOnTag(param_00, param_01, "tag_origin");
}

disablepickuppromptfortime(param_00, param_01) {
  param_00 disableplayeruse(param_01);
  wait(1);
  param_00 enableplayeruse(param_01);
}

run_mini_ufo_logic(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("timed_out");
  var_05 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.players, undefined, 4, 512);
  foreach(var_07 in var_05) {
    var_07 thread scripts\cp\cp_vo::try_to_play_vo("arcane_core_event", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  param_00 collect_arcane_essense(param_00, param_01, param_02, param_03, param_04);
  var_09 = param_01.crystal_slot;
  struct_wait_for_damage(var_09, param_01.crystal_model, param_00, param_01, param_02, param_03, param_04);
}

timeout_crystal(param_00, param_01, param_02, param_03) {
  param_00 endon("picked_up");
  wait(30);
  level thread waittillnextwave(param_03, param_01);
  playsoundatpos(param_00.origin, "zmb_coin_disappear");
  playFX(level._effect["souvenir_pickup"], param_00.origin);
  remove_essence_interaction(param_00);
  reset_trap_kill_count(param_00, param_01, param_02);
  param_00 setscriptablepartstate("miniufo", "neutral");
  param_00 makeunusable();
  param_00 setModel("tag_origin");
  param_00 delete();
}

reset_trap_kill_count(param_00, param_01, param_02) {
  var_03 = param_01.crystal_model;
  switch (var_03) {
    case "zmb_weapon_crystal_red":
      level.angry_mike_trap_kills = 0;
      scripts\engine\utility::flag_clear("mini_ufo_red_ready");
      break;

    case "zmb_weapon_crystal_blue":
      level.rocket_trap_kills = 0;
      scripts\engine\utility::flag_clear("mini_ufo_blue_ready");
      break;

    case "zmb_weapon_crystal_green":
      level.disco_trap_kills = 0;
      scripts\engine\utility::flag_clear("mini_ufo_green_ready");
      break;

    case "zmb_weapon_crystal_yellow":
      level.head_cutter_trap_kills = 0;
      scripts\engine\utility::flag_clear("mini_ufo_yellow_ready");
      break;

    default:
      break;
  }

  thread crystal_listener(param_01, param_02);
}

crystal_listener(param_00, param_01) {
  var_02 = get_part_name(param_01);
  var_03 = undefined;
  level waittill("ww_" + param_00.gun + "_" + var_02 + "_dropped", var_04);
  var_05 = spawn("script_model", var_04 + (0, 0, 30));
  var_06 = get_part_model(param_00, param_01);
  if(scripts\engine\utility::istrue(level.skip_crystal_logic)) {
    level.skip_crystal_logic = 0;
    fake_crystal_logic(var_05, param_00, var_04, param_01, var_02);
    return;
  }

  var_05 collect_arcane_essense(var_05, param_00, var_04, param_01, var_02, 1);
}

struct_wait_for_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  scripts\engine\utility::flag_wait("gator_tooth_broken");
  var_07 = strtok(param_01, "_");
  var_08 = var_07[3];
  var_09 = level.arkqueststation;
  var_0A = scripts\engine\utility::getstruct("slot_" + param_00, "script_noteworthy");
  param_02.origin = var_0A.origin;
  param_02.angles = anglestoup(var_0A.angles);
  param_02 setModel(param_01);
  var_0B = getent("crystal_damage_trigger_" + param_00, "targetname");
  var_0B.origin = var_0B.origin + (0, 0.25, 0);
  var_0B setCanDamage(1);
  var_0B.team = "axis";
  var_0B.max_health = 100;
  var_0B.health = 100;
  for(;;) {
    wait(0.05);
    scripts\engine\utility::flag_wait("gator_gold_tooth_placed");
    var_0B waittill("damage", var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18);
    if(!isDefined(var_0D)) {
      continue;
    }

    if(!isDefined(var_15)) {
      var_15 = var_0D getcurrentweapon();
    }

    if(!scripts\cp\utility::weaponhasattachment(var_15, "ark" + var_08)) {
      continue;
    }

    playsoundatpos(param_02.origin, "arc_machine_door_shoot_off");
    var_0B setCanDamage(0);
    var_0B hide();
    if(!isDefined(var_09.crystals)) {
      var_09.crystals = [];
    }

    var_09.crystals[var_09.crystals.size] = param_02;
    scripts\engine\utility::flag_wait(var_08 + "_crystal_placed");
    break;
  }

  level.wor_items_picked_up[param_03.gun][param_06] = 1;
  if(isplayer(var_0D)) {
    switch (param_03.gun) {
      case "iw7_headcutter_zm":
        var_0D thread scripts\cp\cp_vo::try_to_play_vo("quest_cutter_crystal_yellow", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "iw7_facemelter_zm":
        var_0D thread scripts\cp\cp_vo::try_to_play_vo("quest_melter_crystal_blue", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "iw7_shredder_zm":
        var_0D thread scripts\cp\cp_vo::try_to_play_vo("quest_shredder_crystal_red", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "iw7_dischord_zm":
        var_0D thread scripts\cp\cp_vo::try_to_play_vo("quest_dischord_crystal_green", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      default:
        var_0D thread scripts\cp\cp_vo::try_to_play_vo("part_collect_wor", "zmb_comment_vo");
        break;
    }
  }
}

run_battery_logic(param_00, param_01, param_02, param_03, param_04) {
  var_05 = get_part_model(param_01, param_03);
  param_00 setModel(var_05);
  if(param_01.gun == "iw7_dischord_zm") {
    var_06 = "dischord";
    if(scripts\engine\utility::istrue(level.skip_battery_logic)) {
      level.skip_battery_logic = 0;
      wait(0.25);
    } else {
      param_00 dischord_battery_move();
    }
  } else if(param_02.gun == "iw7_facemelter_zm") {
    var_06 = "melter";
    level.facemelter_battery = param_00;
    wait(0.25);
  } else if(param_02.gun == "iw7_shredder_zm") {
    var_06 = "shredder";
    level.shredder_battery = param_00;
    wait(0.25);
  } else {
    var_06 = "cutter";
    wait(0.25);
  }

  param_00 setscriptablepartstate("model", param_01.toy_model_state);
  param_00 thread rotate_wor_piece();
  param_00 makeusable();
  param_00 setuserange(64);
  param_00 setusefov(120);
  param_00 sethintstring( & "CP_QUEST_WOR_PART");
  param_00 waittill("trigger", var_07);
  var_07 thread scripts\cp\cp_vo::try_to_play_vo("quest_" + var_06 + "_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  param_00 setscriptablepartstate("pickup_piece", "pickup_piece");
  level.wor_items_picked_up[param_01.gun][param_04] = 1;
  wait(0.25);
  param_00 setscriptablepartstate("model", "neutral");
}

rotate_wor_piece() {
  self endon("death");
  for(;;) {
    self rotateyaw(360, 2);
    self movez(-5, 2);
    self waittill("movedone");
    self rotateyaw(360, 2);
    self movez(5, 2);
    self waittill("movedone");
  }
}

run_toy_logic(param_00, param_01, param_02, param_03, param_04) {
  var_05 = (0, 0, 0);
  var_06 = (0, 0, 0);
  switch (param_01.gun) {
    case "iw7_shredder_zm":
      var_07 = getent("toy_angry_mike", "targetname");
      var_05 = var_07.origin;
      var_06 = var_07.angles;
      var_07 hide();
      break;

    case "iw7_facemelter_zm":
      var_07 = getent("toy_shuttle", "targetname");
      var_05 = var_07.origin;
      var_06 = var_07.angles;
      var_07 hide();
      break;

    case "iw7_dischord_zm":
      var_07 = getent("toy_disco_ball", "targetname");
      var_05 = var_07.origin;
      var_06 = var_07.angles;
      var_07 hide();
      break;

    case "iw7_headcutter_zm":
      var_07 = getent("toy_yeti", "targetname");
      var_05 = var_07.origin;
      var_06 = var_07.angles;
      var_07 hide();
      break;
  }

  param_00 setModel(param_01.toy_model);
  param_00.origin = var_05;
  param_00.angles = var_06;
  wait(0.1);
  param_00 setscriptablepartstate("model", param_01.toy_model_state);
  var_08 = scripts\engine\utility::getstructarray("interaction", "targetname");
  var_09 = scripts\engine\utility::getclosest(param_00.origin, var_08);
  if(!isDefined(var_09.angles)) {
    var_09.angles = (0, 0, 0);
  }

  param_00 follow_struct_trail(var_09, var_05, var_06);
  param_00 makeusable();
  param_00 setuserange(64);
  param_00 setusefov(120);
  param_00 sethintstring( & "CP_QUEST_WOR_PART");
  param_00 thread spin_toy();
  param_00 waittill("trigger", var_0A);
  switch (param_00.model) {
    case "zmb_ice_monster_toy":
      var_0A thread scripts\cp\cp_vo::try_to_play_vo("quest_cutter_icemonster", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
      break;

    case "decor_spaceshuttle_boosters_toy":
      var_0A thread scripts\cp\cp_vo::try_to_play_vo("quest_melter_rocket", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
      break;

    case "zmb_spaceland_discoball_toy":
      var_0A thread scripts\cp\cp_vo::try_to_play_vo("quest_dischord_discoball", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
      break;

    case "statue_angry_mike_toy":
      var_0A thread scripts\cp\cp_vo::try_to_play_vo("quest_shredder_monster", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
      break;

    default:
      var_0A thread scripts\cp\cp_vo::try_to_play_vo("part_collect_wor", "zmb_comment_vo");
      break;
  }

  param_00 setscriptablepartstate("pickup_piece", "pickup_piece");
  level.wor_items_picked_up[param_01.gun][param_04] = 1;
  wait(0.25);
  param_00 setscriptablepartstate("model", "neutral");
  param_00 setModel("tag_origin");
}

part_listener(param_00, param_01) {
  var_02 = get_part_name(param_01);
  var_03 = undefined;
  level waittill("ww_" + param_00.gun + "_" + var_02 + "_dropped", var_04);
  var_05 = param_00.gun;
  var_06 = (0, 0, 30);
  if(param_00.gun == "iw7_headcutter_zm" && var_02 == "battery") {
    var_06 = (0, 0, 0);
  }

  var_07 = spawn("script_model", var_04 + var_06);
  var_08 = get_part_model(param_00, param_01);
  switch (var_02) {
    case "crystal":
      if(level.skip_crystal_logic) {
        level.skip_crystal_logic = 0;
        fake_crystal_logic(var_07, param_00, var_04, param_01, var_02);
      } else {
        run_mini_ufo_logic(var_07, param_00, var_04, param_01, var_02);
      }
      break;

    case "toy":
      run_toy_logic(var_07, param_00, var_04, param_01, var_02);
      break;

    case "battery":
      run_battery_logic(var_07, param_00, var_04, param_01, var_02);
      break;
  }

  var_07 delete();
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_wor_use_nag", "zmb_dj_vo", 60, 30, 2, 1);
  var_09 = get_omnvar_bit(param_00.gun, param_01);
  level notify("ww_" + param_00.gun + "_" + var_02 + "_picked_up");
  level scripts\cp\utility::set_quest_icon(var_09);
}

wait_for_crystal_to_charge(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  param_02.runner_count = 0;
  param_02.expected_souls = 0;
  var_05 = 25;
  while(var_04 < var_05) {
    level waittill("kill_near_crystal", var_06, var_07, var_08);
    param_02.expected_souls--;
    if(param_02 != var_08) {
      continue;
    }

    if(!scripts\cp\utility::weaponhasattachment(var_07, "arcane_base")) {
      continue;
    }

    thread crytsal_capture_killed_essense(var_06, param_02);
    param_02.runner_count++;
    var_04++;
  }

  while(param_02.runner_count >= 1) {
    wait(0.05);
  }

  param_02.fully_charged = 1;
  param_02 notify("fully_charged");
  while(!isDefined(param_00.at_end_loc)) {
    wait(0.1);
  }

  param_00 setModel("tag_origin_ground_essence", param_03);
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("quest_arcane_ufo_start");
  scripts\engine\utility::waitframe();
  param_00 setscriptablepartstate("miniufo", param_03);
  if(isDefined(param_02) && scripts\engine\utility::array_contains(level.miniufos, param_02)) {
    level.miniufos = scripts\engine\utility::array_remove(level.miniufos, param_02);
  }
}

crytsal_capture_killed_essense(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("tag_origin_soultrail");
  var_03 = param_01.origin;
  var_04 = param_00 + (0, 0, 40);
  for(;;) {
    var_05 = distance(var_04, var_03);
    var_06 = 1500;
    var_07 = var_05 / var_06;
    if(var_07 < 0.05) {
      var_07 = 0.05;
    }

    var_02 moveto(var_03, var_07);
    var_02 waittill("movedone");
    if(distance(var_02.origin, param_01.origin) > 16) {
      var_03 = param_01.origin;
      var_04 = var_02.origin;
      continue;
    }

    break;
  }

  param_01 setscriptablepartstate("sparks", "sparks");
  wait(0.25);
  param_01 setscriptablepartstate("sparks", "neutral");
  param_01.runner_count--;
  var_02 delete();
}

charge_players_arcane_base_attachment(param_00, param_01) {
  var_02 = strtok(param_01.crystal_model, "_");
  var_03 = var_02[3];
  var_04 = "ark" + var_03;
  param_00 setscriptablepartstate("arcane", "arcane_absorb", 0);
  wait(0.25);
  param_00 scripts\engine\utility::allow_weapon_switch(0);
  var_05 = param_00 getcurrentweapon();
  param_00 scripts\cp\cp_weapon::add_attachment_to_weapon(var_04, var_05, 1);
  while(param_00 isswitchingweapon()) {
    wait(0.05);
  }

  param_00 scripts\engine\utility::allow_weapon_switch(1);
  level thread play_arcane_vo(param_00);
  param_00 scripts\cp\cp_persistence::give_player_xp(500, 1);
}

play_arcane_vo(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("last_stand");
  wait(10);
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_ufo_success", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  wait(7);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_arcane_corecharged_complete", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

set_gun_slot_from_part_num(param_00, param_01) {
  switch (param_01) {
    case 1:
      param_00.part_1 = 1;
      break;

    case 2:
      param_00.part_2 = 1;
      break;

    case 3:
      param_00.part_3 = 1;
      break;
  }
}

setup_standee_data(param_00) {
  var_01 = getweaponbasename(param_00);
  switch (var_01) {
    case "iw7_headcutter_zm":
      init_headcutter_data();
      break;

    case "iw7_facemelter_zm":
      init_facemelter_data();
      break;

    case "iw7_dischord_zm":
      init_dischord_data();
      break;

    case "iw7_shredder_zm":
      init_shredder_data();
      break;
  }
}

init_headcutter_data() {
  self.toy_model = "zmb_ice_monster_toy";
  self.toy_model_state = "ice_monster";
  self.battery_model = "alien_crafting_battery_single_01";
  self.crystal_model = "zmb_weapon_crystal_yellow";
  self.color = "yellow";
  self.transformed_gun_model = "weapon_zappers_headcutter_wm";
  self.gun_model = "weapon_zappers_headcutter_wm";
  self.largeessencefx = "yellow";
  self.placement_fx = level._effect["part_glow_yellow"];
  self.placement_fx_complete = level._effect["part_glow_yellow_complete"];
  self.starting_move_structs = scripts\engine\utility::getstructarray("hc_start_struct", "targetname");
  self.charge_distance = 750;
  self.crystal_slot = 0;
  self.place_on_standee_string = & "CP_QUEST_WOR_PLACE_HC";
}

init_facemelter_data() {
  self.toy_model = "decor_spaceshuttle_boosters_toy";
  self.toy_model_state = "spaceshuttle";
  self.battery_model = "alien_crafting_battery_single_01";
  self.crystal_model = "zmb_weapon_crystal_blue";
  self.color = "blue";
  self.transformed_gun_model = "weapon_zappers_facemelter_wm";
  self.gun_model = "weapon_zappers_facemelter_wm";
  self.largeessencefx = "blue";
  self.placement_fx = level._effect["part_glow_blue"];
  self.placement_fx_complete = level._effect["part_glow_blue_complete"];
  self.starting_move_structs = scripts\engine\utility::getstructarray("fm_start_struct", "targetname");
  self.charge_distance = 750;
  self.crystal_slot = 1;
  self.place_on_standee_string = & "CP_QUEST_WOR_PLACE_FACEMELTER";
}

init_dischord_data() {
  self.toy_model = "zmb_spaceland_discoball_toy";
  self.toy_model_state = "discoball";
  self.battery_model = "alien_crafting_battery_single_01";
  self.crystal_model = "zmb_weapon_crystal_green";
  self.color = "green";
  self.transformed_gun_model = "weapon_zappers_dischord_wm";
  self.gun_model = "weapon_zappers_dischord_wm";
  self.largeessencefx = "green";
  self.placement_fx = level._effect["part_glow_green"];
  self.placement_fx_complete = level._effect["part_glow_green_complete"];
  self.starting_move_structs = scripts\engine\utility::getstructarray("dischord_start_struct", "targetname");
  self.charge_distance = 750;
  self.crystal_slot = 2;
  self.place_on_standee_string = & "CP_QUEST_WOR_PLACE_DISCHORD";
}

init_shredder_data() {
  self.toy_model = "statue_angry_mike_toy";
  self.toy_model_state = "angry_mike";
  self.battery_model = "alien_crafting_battery_single_01";
  self.crystal_model = "zmb_weapon_crystal_red";
  self.color = "red";
  self.transformed_gun_model = "weapon_zappers_shredder_wm";
  self.gun_model = "weapon_zappers_shredder_wm";
  self.largeessencefx = "red";
  self.placement_fx = level._effect["part_glow_red"];
  self.placement_fx_complete = level._effect["part_glow_red_complete"];
  self.starting_move_structs = scripts\engine\utility::getstructarray("shredder_start_struct", "targetname");
  self.charge_distance = 750;
  self.crystal_slot = 3;
  self.place_on_standee_string = & "CP_QUEST_WOR_PLACE_SHREDDER";
}

get_part_name(param_00) {
  switch (param_00) {
    case 1:
      return "toy";

    case 2:
      return "battery";

    case 3:
      return "crystal";
  }

  return undefined;
}

get_omnvar_bit(param_00, param_01) {
  var_02 = getweaponbasename(param_00);
  switch (var_02) {
    case "iw7_headcutter_zm":
      switch (param_01) {
        case 1:
          return 10;

        case 2:
          return 11;

        case 3:
          return 12;
      }
      break;

    case "iw7_facemelter_zm":
      switch (param_01) {
        case 1:
          return 13;

        case 2:
          return 14;

        case 3:
          return 15;
      }
      break;

    case "iw7_dischord_zm":
      switch (param_01) {
        case 1:
          return 16;

        case 2:
          return 17;

        case 3:
          return 18;
      }
      break;

    case "iw7_shredder_zm":
      switch (param_01) {
        case 1:
          return 19;

        case 2:
          return 20;

        case 3:
          return 21;
      }
      break;
  }

  return undefined;
}

get_part_model(param_00, param_01) {
  switch (param_01) {
    case 1:
      return param_00.toy_model;

    case 2:
      return param_00.battery_model;

    case 3:
      return param_00.crystal_model;
  }

  return undefined;
}

get_toy_angle_offset(param_00) {
  var_01 = getweaponbasename(param_00.gun);
  switch (var_01) {
    case "iw7_headcutter_zm":
      return (0, -90, 0);

    case "iw7_facemelter_zm":
      return (0, 0, 0);

    case "iw7_dischord_zm":
      return (0, 0, 0);

    case "iw7_shredder_zm":
      return (0, 0, 0);
  }

  return undefined;
}

get_toy_pos_offset(param_00) {
  var_01 = getweaponbasename(param_00.gun);
  switch (var_01) {
    case "iw7_headcutter_zm":
      return (-4, 1, 3);

    case "iw7_facemelter_zm":
      return (0, 0, 0);

    case "iw7_dischord_zm":
      return (0, 0, 10);

    case "iw7_shredder_zm":
      return (0, 0, 0);
  }

  return undefined;
}

wor_quest_death_update_func(param_00, param_01) {
  if(scripts\engine\utility::flag("mini_ufo_yellow_ready") && level.head_cutter_trap_kills >= 15) {
    level notify("ww_iw7_headcutter_zm_crystal_dropped", param_00.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_red_ready") && level.angry_mike_trap_kills >= 15) {
    level notify("ww_iw7_shredder_zm_crystal_dropped", param_00.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_green_ready") && level.disco_trap_kills >= 15) {
    level notify("ww_iw7_dischord_zm_crystal_dropped", param_00.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_blue_ready") && level.rocket_trap_kills >= 15) {
    level notify("ww_iw7_facemelter_zm_crystal_dropped", param_00.origin);
  }
}

wor_quest_crafting_func() {
  level.headcutter_crafting_list = ["zmb_coin_ice", "zmb_coin_ice", "zmb_coin_ice"];
  level.shredder_crafting_list = ["zmb_coin_alien", "zmb_coin_alien", "zmb_coin_alien"];
  level.dischord_crafting_list = ["zmb_coin_alien", "zmb_coin_space", "zmb_coin_ice"];
  level.facemelter_crafting_list = ["zmb_coin_space", "zmb_coin_space", "zmb_coin_space"];
  var_00 = "europa_tunnel";
  var_01 = "moon_outside_begin";
  var_02 = "mars_3";
  var_03 = "moon_bumpercars";
  var_04 = [];
  while(var_04.size < 4) {
    level waittill("quest_crafting_check", var_05);
    if(scripts\cp\utility::is_codxp()) {
      continue;
    }

    if(!isDefined(var_04["iw7_headcutter_zm"]) && ingredient_list_check(var_05.ingredient_list, level.headcutter_crafting_list)) {
      if(isDefined(var_05.power_area) && var_05.power_area == var_00) {
        level notify("ww_iw7_headcutter_zm_toy_dropped", var_05.origin);
        var_04["iw7_headcutter_zm"] = 1;
      }
    }

    if(!isDefined(var_04["iw7_shredder_zm"]) && ingredient_list_check(var_05.ingredient_list, level.shredder_crafting_list)) {
      if(isDefined(var_05.power_area) && var_05.power_area == var_02) {
        level notify("ww_iw7_shredder_zm_toy_dropped", var_05.origin);
        var_04["iw7_shredder_zm"] = 1;
      }
    }

    if(!isDefined(var_04["iw7_dischord_zm"]) && ingredient_list_check(var_05.ingredient_list, level.dischord_crafting_list)) {
      if(isDefined(var_05.power_area) && var_05.power_area == var_03) {
        level notify("ww_iw7_dischord_zm_toy_dropped", var_05.origin);
        var_04["iw7_dischord_zm"] = 1;
      }
    }

    if(!isDefined(var_04["iw7_facemelter_zm"]) && ingredient_list_check(var_05.ingredient_list, level.facemelter_crafting_list)) {
      if(isDefined(var_05.power_area) && var_05.power_area == var_01) {
        level notify("ww_iw7_facemelter_zm_toy_dropped", var_05.origin);
        var_04["iw7_facemelter_zm"] = 1;
      }
    }
  }
}

ingredient_list_check(param_00, param_01) {
  if(param_01.size == 0) {
    return 0;
  }

  foreach(var_03 in param_00) {
    var_04 = undefined;
    foreach(var_06 in param_01) {
      if(var_03 == var_06) {
        var_04 = var_06;
        break;
      }
    }

    if(!isDefined(var_04)) {
      return 0;
    } else {
      param_01 = array_remove_single(param_01, var_04);
    }
  }

  return 1;
}

array_remove_single(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  foreach(var_05 in param_00) {
    if(var_02) {
      var_03[var_03.size] = var_05;
      continue;
    }

    if(var_05 != param_01) {
      var_03[var_03.size] = var_05;
      continue;
    }

    var_02 = 1;
  }

  return var_03;
}

follow_struct_trail(param_00, param_01, param_02) {
  var_03 = scripts\engine\utility::getstructarray("toy_trail_start", "targetname");
  var_04 = scripts\engine\utility::getclosest(self.origin, var_03);
  wait(0.5);
  self moveto(var_04.origin, 0.5);
  self waittill("movedone");
  var_05 = scripts\engine\utility::getstruct(var_04.target, "targetname");
  self moveto(var_05.origin, 0.5);
  self waittill("movedone");
  while(isDefined(var_05.target)) {
    var_05 = scripts\engine\utility::getstruct(var_05.target, "targetname");
    if(!isDefined(var_05.target)) {
      var_06 = var_05.origin - var_04.origin;
      var_06 = vectornormalize(var_06);
      var_06 = var_06 * 40;
      var_06 = (var_06[0], var_06[1], 0);
      var_05.origin = var_05.origin + var_06;
    }

    self moveto(var_05.origin, 0.75);
    self waittill("movedone");
  }

  self movez(-10, 0.5);
  wait(0.5);
}

spin_toy() {
  self endon("death");
  self endon("trigger");
  for(;;) {
    self rotateyaw(360, 2);
    self movez(5, 2);
    self waittill("movedone");
    self movez(-5, 2);
    self rotateyaw(360, 2);
    self waittill("movedone");
  }
}

listen_for_shredder_battery_hit() {
  level.shredder_battery_dropped = 1;
  level notify("ww_iw7_shredder_zm_battery_dropped", self.origin);
}

listen_for_grenade_in_volume() {
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  self endon("disconnect");
  while(!scripts\engine\utility::flag_exist("fast_travel_init_done")) {
    wait(0.1);
  }

  scripts\engine\utility::flag_wait("fast_travel_init_done");
  var_00 = getEntArray("portal_grenade_volume", "targetname");
  for(;;) {
    self waittill("grenade_fire", var_01, var_02);
    if(isDefined(var_01) && isDefined(var_02)) {
      var_01 thread wait_for_impact(var_00[0], var_02, self);
    }
  }
}

check_for_grenade_in_volume(param_00, param_01, param_02) {
  self endon("death");
  scripts\engine\utility::waitframe();
  if(!isDefined(level.hot_potato_stage)) {
    level.hot_potato_stage = 0;
  }

  for(;;) {
    if(level.hot_potato_stage == 0) {
      if(!level.facemelter_portal.portal_is_open && !level.facemelter_portal.portal_charging) {
        wait(0.1);
        continue;
      }

      if(self istouching(param_00)) {
        level.hot_potato_stage = 1;
        level thread start_hot_potato(self, param_00, param_01, param_02);
      }
    } else if(isDefined(level.hot_potato_carrier) && param_02 == level.hot_potato_carrier && is_thrown_back_grenade(param_02)) {
      self.potato = 1;
      level.hot_potato_carrier = undefined;
      level.last_potato_carrier = param_02;
      if(self istouching(param_00)) {
        level thread throw_battery_out_of_portal(self, param_02);
      }
    }

    if(scripts\engine\utility::istrue(self.potato)) {
      if(self istouching(param_00)) {
        level thread throw_battery_out_of_portal(self, param_02);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

start_hot_potato(param_00, param_01, param_02, param_03) {
  level endon("end_hot_potato_stage_1");
  level.potatoes_needed = 1;
  var_04 = param_00 throw_grenade_back(param_01, param_02, param_03, 5);
  param_00 delete();
  var_04 thread notify_on_explode();
  var_04 thread listen_for_pickup();
  var_05 = level scripts\engine\utility::waittill_any_return("hot_potato_timed_out");
  if(var_05 == "hot_potato_timed_out") {
    if(isDefined(level.last_potato_carrier)) {
      level thread play_fail_sound(level.last_potato_carrier, 2);
    }

    level.hot_potato_carrier = undefined;
    level.last_potato_carrier = undefined;
    level.hot_potato_stage = 0;
  }
}

play_fail_sound(param_00, param_01) {
  param_00 endon("death");
  wait(param_01);
  param_00 playlocalsound("zapper_grenade_toss_fail");
}

listen_for_pickup() {
  level endon("hot_potato_timed_out");
  self waittill("trigger", var_00);
  level.hot_potato_carrier = var_00;
}

throw_battery_out_of_portal(param_00, param_01) {
  level.hot_potato_stage = 2;
  level notify("ww_iw7_facemelter_zm_battery_dropped", param_01.origin);
  param_00 delete();
}

notify_on_explode() {
  self waittill("explode");
  level.hot_potato_stage = 0;
  level notify("hot_potato_timed_out");
}

throw_grenade_back(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 5;
  }

  var_04 = (3756, 1379, 115);
  var_05 = (-200, 0, 0);
  var_05 = var_05 + (randomintrange(-100, 100), randomintrange(-10, 10), 0);
  var_06 = param_00 launchgrenade("frag_grenade_zm", var_04, var_05, param_03);
  var_06 hudoutlineenable(1, 1, 1);
  var_06.potato = 1;
  return var_06;
}

is_thrown_back_grenade(param_00) {
  if(!isDefined(param_00.throwinggrenade)) {
    return 1;
  }

  return 0;
}

notify_test(param_00) {
  self waittill(param_00, var_01, var_02, var_03, var_04, var_05);
  var_06 = 0;
}

wait_for_impact(param_00, param_01, param_02) {
  self endon("death");
  var_03 = 20;
  var_04 = var_03 * var_03;
  var_05 = scripts\engine\utility::getstructarray("freeze_breath_struct", "targetname");
  var_05 = scripts\engine\utility::get_array_of_closest(self.origin, var_05);
  var_06 = var_05[0];
  if(!isDefined(level.facemelter_portal)) {
    level.facemelter_portal = scripts\engine\utility::getclosest(param_00.origin, level.fast_travel_spots);
  }

  if(facemelter_grenade_check(param_01)) {
    if(!isDefined(level.hot_potato_stage) || level.hot_potato_stage < 1) {
      thread check_for_grenade_in_volume(param_00, param_01, param_02);
    } else if(level.hot_potato_stage < 2) {
      if(isDefined(level.hot_potato_carrier) && level.hot_potato_carrier == param_02) {
        self.potato = 1;
        level.hot_potato_carrier = undefined;
        thread notify_on_explode();
        thread listen_for_pickup();
        param_00 = getent("center_portal_grenade_volume", "targetname");
        thread check_for_grenade_in_volume(param_00, param_01, param_02);
      }
    }
  }

  thread listen_for_mouth_explosion(var_04, var_06, param_02);
}

facemelter_grenade_check(param_00) {
  switch (param_00) {
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "frag_grenade_zm":
      return 1;
  }

  return 0;
}

listen_for_mouth_explosion(param_00, param_01, param_02) {
  if(!isDefined(self.weapon_name) || self.weapon_name != "zfreeze_semtex_mp") {
    return;
  }

  self waittill("explode", var_03);
  var_04 = getent("headcutter_grenade_vol", "targetname");
  if(ispointinvolume(var_03, var_04)) {
    param_01 notify("cryo_hit");
    if(isDefined(param_02)) {
      param_02 thread scripts\cp\cp_vo::try_to_play_vo("quest_icemonster_grenade", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    }
  }
}

listen_for_triton_power() {
  level scripts\engine\utility::waittill_any_return("power_on", "europa_tunnel power_on");
  scripts\engine\utility::flag_init("listen_for_cryo_hit");
  scripts\engine\utility::flag_set("listen_for_cryo_hit");
}

wor_change_portal(param_00) {
  if(!isDefined(level.wor_portal_change_time) || level.wor_portal_change_time < 5) {
    level.wor_portal_change_time = 5;
  }

  while(level.wor_portal_change_time > 0) {
    level.wor_portal_change_time--;
    wait(1);
  }
}

wait_to_spawn_facemelter_battery() {
  level waittill("player_entering_wor_changed_portal", var_00);
  var_01 = scripts\engine\utility::getstruct("facemelter_battery_org", "targetname");
  level notify("ww_iw7_facemelter_zm_battery_dropped", var_01.origin);
  while(!isDefined(level.facemelter_battery)) {
    wait(0.1);
  }

  level thread facemelter_battery_phase_listener();
}

facemelter_battery_phase_listener() {
  level endon("ww_iw7_facemelter_zm_battery_picked_up");
  for(;;) {
    foreach(var_01 in level.players) {
      if(!var_01 is_in_fake_phase_shift()) {
        level.facemelter_battery hidefromplayer(var_01);
        level.facemelter_battery disableplayeruse(var_01);
        continue;
      }

      level.facemelter_battery showtoplayer(var_01);
      level.facemelter_battery enableplayeruse(var_01);
    }

    wait(0.1);
  }
}

is_in_fake_phase_shift() {
  return scripts\engine\utility::istrue(self.wor_phase_shift);
}

dischord_glasses_listener() {
  level.wor_glasses = 0;
  level.dischord_targets_hit = 0;
  var_00 = getEntArray("dischord_target", "targetname");
  var_00 = scripts\engine\utility::array_randomize(var_00);
  var_01 = 0;
  var_02 = scripts\engine\utility::getclosest((3504, -1297, 172), var_00, 500);
  var_03 = scripts\engine\utility::getclosest((1865, -2068, 1046), var_00, 500);
  level.dischord_targets = [5];
  foreach(var_05 in var_00) {
    if(var_01 < 5) {
      level.dischord_targets[var_01] = var_05;
      level thread dischord_target_listener(var_05);
    }

    if(var_05 == var_02) {
      var_05.origin = var_05.origin + (0, -25, 5);
    }

    if(var_05 == var_03) {
      var_05.origin = (1866, -2107, 835);
      var_05.angles = (74, 117, 0);
    }

    var_05 hide();
    var_01++;
  }

  level thread dischord_visibility_listener();
  level waittill("ww_iw7_dischord_zm_battery_dropped");
}

dischord_target_listener(param_00) {
  param_00 hudoutlineenable(1, 1, 0);
  param_00 setCanDamage(1);
  var_01 = 0;
  while(!var_01) {
    param_00 waittill("damage", var_02, var_03);
    if(isplayer(var_03) && scripts\engine\utility::istrue(var_03.wearing_dischord_glasses) || level.debug_dischord_targets) {
      level.dischord_targets_hit++;
      var_01 = 1;
      if(level.dischord_targets_hit >= 5) {
        level notify("ww_iw7_dischord_zm_battery_dropped", param_00.origin - (0, 0, 50));
      }
    }
  }

  playFX(level._effect["pickup"], param_00.origin);
  param_00 notify("stop_visibility_listener");
  if(scripts\engine\utility::array_contains(level.dischord_targets, param_00)) {
    level.dischord_targets = scripts\engine\utility::array_remove(level.dischord_targets, param_00);
  }

  param_00 delete();
}

dischord_visibility_listener() {
  self endon("stop_visibility_listener");
  if(!isDefined(level.debug_dischord_targets)) {
    level.debug_dischord_targets = 0;
  }

  for(;;) {
    foreach(var_01 in level.dischord_targets) {
      foreach(var_03 in level.players) {
        if(scripts\engine\utility::istrue(var_03.wearing_dischord_glasses) || level.debug_dischord_targets) {
          var_01 showtoplayer(var_03);
          var_01 hudoutlineenable(1, 1, 0);
          continue;
        }

        var_01 hidefromplayer(var_03);
      }
    }

    wait(1);
  }
}

debug_show_dischord_targets() {
  if(!isDefined(level.debug_dischord_targets)) {
    level.debug_dischord_targets = 0;
  }

  for(;;) {
    var_00 = getdvarint("scr_show_dischord_targets", 0);
    if(var_00 != 0) {
      if(level.debug_dischord_targets) {
        level.debug_dischord_targets = 0;
        debug_make_dischord_targets_invisible();
      } else {
        debug_make_dischord_targets_visible();
        level.debug_dischord_targets = 1;
      }

      setdvar("scr_show_dischord_targets", 0);
    }

    wait(0.1);
  }
}

debug_make_dischord_targets_visible() {
  var_00 = getEntArray("dischord_target", "targetname");
  foreach(var_02 in var_00) {
    var_02 show();
    var_02 hudoutlineenable(1, 0, 0);
  }
}

debug_make_dischord_targets_invisible() {
  var_00 = getEntArray("dischord_target", "targetname");
  foreach(var_02 in var_00) {
    var_02 hudoutlineenable(1, 1, 0);
    var_02 hide();
  }
}

dischord_battery_move() {
  var_00 = scripts\engine\utility::getstruct("dischord_battery_end_loc", "targetname");
  self moveto(var_00.origin, 5, 0.1, 0.1);
  self waittill("movedone");
}

wor_quest_pillage_func() {
  if(!isDefined(level.glasses_drop_change_increase)) {
    level.glasses_drop_change_increase = 0;
  }

  var_00 = randomint(100);
  var_01 = 10 + level.glasses_drop_change_increase;
  if(var_00 < var_01 && !level.wor_glasses) {
    level.glasses_drop_change_increase = 0;
    return "quest";
  } else {
    level.glasses_drop_change_increase = level.glasses_drop_change_increase + 10;
  }

  return undefined;
}

wor_quest_specific_pillage_show_func(param_00, param_01, param_02) {
  playFX(level._effect["souvenir_pickup"], param_02.origin + (0, 0, 30));
  param_00 give_glasses_power();
  param_00 scripts\cp\utility::setlowermessage("msg_power_hint", & "CP_QUEST_WOR_GLASSES_TOGGLE", 4);
  param_02 notify("all_players_searched");
}

give_glasses_power() {
  var_00 = spawnStruct();
  var_00.power_name = "power_glasses";
  scripts\cp\powers\coop_powers::give_player_wall_bought_power(var_00, self);
  var_00 = undefined;
}

wor_quest_create_pillage_interaction(param_00, param_01) {
  param_00.type = "quest";
  param_00.randomintrange = "quest";
  param_01.effect = spawnfx(level._effect["quest_glasses_drop"], param_01.origin);
  level.wor_glasses = 1;
  param_00 thread unset_flag_if_not_picked_up(param_01.effect);
  scripts\engine\utility::waitframe();
  triggerfx(param_01.effect);
}

unset_flag_if_not_picked_up(param_00) {
  self endon("picked_up");
  self waittill("stop_pillage_spot_think");
  level.wor_glasses = 0;
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

give_glasses_to_player() {
  self.has_dischord_glasses = 1;
  self.dont_use_charges = "power_glasses";
  thread listen_to_toggle_glasses();
  thread reset_flags_on_death();
  scripts\engine\utility::flag_set("dischord_glasses_pickedup");
}

put_glasses_on_player(param_00) {
  var_01 = "ges_visor_up";
  if(!self isgestureplaying()) {
    var_02 = 0;
    self setweaponammostock("iw7_sunglasses_zm_on", 1);
    self giveandfireoffhand("iw7_sunglasses_zm_on");
  }

  thread put_glasses_on();
  scripts\engine\utility::flag_set("dischord_glasses_pickedup");
}

remove_glasses_from_player() {
  self notify("removing_glasses_from_player");
  self.wearing_dischord_glasses = 0;
  self.has_dischord_glasses = 0;
  self visionsetnakedforplayer("", 0.1);
  self.dont_use_charges = undefined;
}

put_glasses_on() {
  wait(1);
  self.wearing_dischord_glasses = 1;
  self visionsetnakedforplayer("cp_zmb_bw", 0.1);
  thread wait_to_knock_off_glasses();
  thread reapply_visionset_after_host_migration();
  thread scripts\cp\cp_vo::try_to_play_vo("sunglasses", "zmb_comment_vo", "low", 30, 0, 0, 0, 30);
}

reapply_visionset_after_host_migration() {
  self endon("death");
  self endon("disconnect");
  self endon("removing_glasses_from_player");
  level waittill("host_migration_begin");
  level waittill("host_migration_end");
  if(scripts\engine\utility::istrue(self.wearing_dischord_glasses)) {
    self visionsetnakedforplayer("cp_zmb_bw");
    thread wait_to_knock_off_glasses();
  }
}

take_glasses_off(param_00) {
  if(param_00) {
    thread launch_glasses();
    return;
  }

  self.wearing_dischord_glasses = 0;
  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0.1);
  } else {
    self visionsetnakedforplayer("", 0.1);
  }

  var_01 = "ges_visor_down";
  if(!self isgestureplaying()) {
    var_02 = 0;
    self setweaponammostock("iw7_sunglasses_zm_off", 1);
    self giveandfireoffhand("iw7_sunglasses_zm_off");
  }
}

launch_glasses() {
  self endon("deleting_glasses");
  scripts\cp\powers\coop_powers::removepower("power_glasses");
  var_00 = 400;
  var_01 = self gettagorigin("tag_eye");
  var_02 = self gettagangles("tag_eye");
  var_02 = anglesToForward(var_02);
  var_03 = vectornormalize(var_02) + (0, 0, 0.25);
  var_03 = var_03 * var_00;
  var_04 = self getvelocity();
  var_03 = var_03 + var_04;
  var_05 = spawn("script_model", var_01);
  var_05 setModel("zmb_sunglass_01_wm");
  var_05 physicslaunchserver(var_01, var_03);
  wait(0.1);
  var_05 thread pick_up_knocked_off_glasses();
  var_05 thread delete_glasses_after_time(10);
  var_05 waittill("trigger", var_06);
  var_06 give_glasses_power();
  var_05 notify("glasses_picked_up");
  var_05 delete();
}

wait_to_knock_off_glasses() {
  level endon("ww_iw7_dischord_zm_battery_dropped");
  self notify("waiting_for_knock_off");
  self endon("waiting_for_knock_off");
  while(self.has_dischord_glasses) {
    self waittill("damage", var_00, var_01);
    if(isDefined(var_01.team) && var_01.team != self.team) {
      if(scripts\engine\utility::istrue(self.wearing_dischord_glasses)) {
        take_glasses_off(1);
        wait(0.1);
        break;
      }
    }
  }
}

listen_to_toggle_glasses() {
  self endon("removing_glasses_from_player");
  while(self.has_dischord_glasses) {
    self waittill("glasses_change");
    if(scripts\engine\utility::istrue(self.wearing_dischord_glasses)) {
      take_glasses_off(0);
      continue;
    }

    put_glasses_on_player(self);
  }
}

reset_flags_on_death() {
  self notify("glasses_flag_check_reset");
  self endon("glasses_flag_check_reset");
  self waittill("death");
  self.wearing_dischord_glasses = 0;
  self.has_dischord_glasses = 0;
  self.dont_use_charges = undefined;
}

delete_glasses_after_time(param_00) {
  self endon("glasses_picked_up");
  wait(param_00);
  self notify("deleting_glasses");
  level.wor_glasses = 0;
  self delete();
}

pick_up_knocked_off_glasses() {
  self hudoutlineenable(2, 1, 0);
  self makeusable();
  var_00 = & "CP_QUEST_WOR_PART";
  self sethintstring(var_00);
}

init_dischord_glasses_power() {
  while(!scripts\engine\utility::flag_exist("powers_init_done")) {
    wait(0.1);
  }

  while(!scripts\engine\utility::flag("powers_init_done")) {
    wait(0.1);
  }

  scripts\cp\powers\coop_powers::powersetupfunctions("power_glasses", ::setdischordglasses, ::unsetdischordglasses, ::usedischordglasses, "powers_glasses_update", undefined, undefined);
}

setdischordglasses(param_00) {
  give_glasses_to_player();
}

unsetdischordglasses() {
  remove_glasses_from_player();
}

usedischordglasses() {
  self notify("glasses_change");
  self.powers["power_glasses"].charges = 1;
}

headcutter_freeze_test() {
  level.headcutter_org = scripts\engine\utility::getstruct("headcutter_battery_loc", "targetname");
  if(scripts\cp\utility::is_codxp()) {
    return;
  }

  level thread wait_to_drop_headcutter_battery();
  var_00 = scripts\engine\utility::getstructarray("freeze_breath_struct", "targetname");
  foreach(var_02 in var_00) {
    if(var_02.target == "freeze_volume_1") {
      var_02 thread headcutter_freeze_loop();
      var_02 thread freeze_check_loop();
      var_02 thread listen_for_cryo_kills();
    }
  }
}

headcutter_freeze_loop() {
  level endon("hc_freeze_done");
  self.freeze_active = 1;
}

freeze_check_loop() {
  self endon("stop_feeze_loop");
  self.freeze_volume = getent(self.target, "targetname");
  var_00 = getent("main_street_monster", "targetname");
  var_01 = 10;
  for(;;) {
    self waittill("cryo_hit");
    if(self.freeze_active) {
      var_00 setscriptablepartstate("main", "breath_attack_in");
      thread freeze_breath(var_01);
      activate_freeze_volume(var_01);
      var_00 setscriptablepartstate("main", "idle2");
    }

    wait(0.1);
  }
}

activate_freeze_volume(param_00) {
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    foreach(var_03 in level.spawned_enemies) {
      if(isDefined(var_03.agent_type) && var_03.agent_type == "generic_zombie" || var_03.agent_type == "zombie_cop") {
        if(var_03 istouching(self.freeze_volume)) {
          var_03.freeze_struct = self;
          var_03 dodamage(1, var_03.origin, level.players[0], level.players[0], "MOD_GRENADE_SPLASH", "zfreeze_semtex_mp");
        }
      }
    }

    wait(0.1);
  }
}

freeze_breath(param_00) {
  var_01 = getent("main_street_monster", "targetname");
  var_02 = spawnfx(level._effect["coaster_ice_frost"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  wait(2);
  var_01 playSound("yeti_frost_breath");
  triggerfx(var_02);
  wait(param_00 - 1);
  var_02 delete();
}

listen_for_cryo_kills() {
  var_00 = 0;
  var_01 = 10;
  while(var_00 < var_01) {
    self waittill("headcutter_cryo_kill", var_02, var_03);
    var_00++;
    level.total_cryo_kills++;
  }

  var_04 = getent("main_street_monster", "targetname");
  var_04 playSound("yeti_growl");
}

wait_to_drop_headcutter_battery() {
  for(;;) {
    if(level.total_cryo_kills >= 10) {
      level notify("ww_iw7_headcutter_zm_battery_dropped", level.headcutter_org.origin);
    }

    wait(0.25);
  }
}

dj_quest_vo_init_timer() {
  wait(1000);
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_partsrecovery_hint", "zmb_dj_vo", 60, 15, 2, 1);
}

wor_give_weapon(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disconnect");
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(param_00)) {
    var_03 = param_00 scripts\cp\utility::getvalidtakeweapon();
    var_04 = scripts\cp\utility::getrawbaseweaponname(var_03);
    param_00 takeweapon(var_03);
    if(isDefined(param_00.pap[var_04])) {
      param_00.pap[var_04] = undefined;
      param_00 notify("weapon_level_changed");
    }
  }

  var_05 = scripts\cp\utility::getrawbaseweaponname(param_01);
  if(param_00 hasweapon("iw7_fists_zm")) {
    param_00 takeweapon("iw7_fists_zm");
  }

  if(scripts\engine\utility::istrue(param_02.standee.upgraded)) {
    switch (param_01) {
      case "iw7_facemelter_zm":
        param_01 = "iw7_facemelter_zm_pap1+fmpap1+camo22";
        break;

      case "iw7_shredder_zm":
        param_01 = "iw7_shredder_zm_pap1+shredderpap1+camo23";
        break;

      case "iw7_headcutter_zm":
        param_01 = "iw7_headcutter_zm_pap1+hcpap1+camo21";
        break;

      case "iw7_dischord_zm":
        param_01 = "iw7_dischord_zm_pap1+dischordpap1+camo20";
        break;
    }
  }

  param_01 = param_00 scripts\cp\utility::_giveweapon(param_01, undefined, undefined, 0);
  if(issubstr(param_01, "emc")) {
    param_00.has_replaced_starting_pistol = 1;
  }

  param_00 notify("wor_item_pickup", param_01);
  var_06 = 1;
  if(isDefined(param_02.clip)) {
    var_06 = 0;
    param_00 setweaponammoclip(param_01, param_02.clip);
  }

  if(isDefined(param_02.stock)) {
    var_06 = 0;
    param_00 setweaponammostock(param_01, param_02.stock);
  }

  param_00 switchtoweapon(param_01);
  if(var_06) {
    param_00 givemaxammo(param_01);
  }

  var_07 = scripts\cp\utility::getrawbaseweaponname(param_01);
  if(issubstr(param_01, "dischord")) {
    if(param_00.vo_prefix == "p3_") {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_dischord(level.wave_num);
  } else if(issubstr(param_01, "facemelter")) {
    if(param_00.vo_prefix == "p2_") {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_facemelter(level.wave_num);
  } else if(issubstr(param_01, "shredder")) {
    if(param_00.vo_prefix == "p4_") {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_shredder(level.wave_num);
  } else if(issubstr(param_01, "headcutter")) {
    if(param_00.vo_prefix == "p1_") {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      param_00 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_headcutter(level.wave_num);
  }

  param_00 scripts\cp\zombies\achievement::update_achievement("ROCK_ON", 1);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_wor_use_nag");
  var_08 = spawnStruct();
  var_08.lvl = 1;
  param_00.pap[var_05] = var_08;
  param_00 notify("weapon_level_changed");
}

trackplayersworammo(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  level endon("game_ended");
  level endon("gun_replaced " + param_01);
  param_02.stock = param_00 getweaponammostock(param_01);
  param_02.clip = param_00 getweaponammoclip(param_01);
  for(;;) {
    param_00 scripts\engine\utility::waittill_any_3("weapon_fired", "reload");
    if(scripts\engine\utility::istrue(param_00.inlaststand)) {
      continue;
    }

    if(scripts\engine\utility::istrue(level.infinite_ammo)) {
      continue;
    }

    var_03 = param_00 getcurrentweapon();
    var_04 = getweaponbasename(var_03);
    if(var_04 == param_01 || var_04 == param_01 + "_pap1") {
      param_02.stock = param_00 getweaponammostock(var_03);
      param_02.clip = param_00 getweaponammoclip(var_03);
    }
  }
}

watchforplayerdeath(param_00, param_01, param_02) {
  level thread watchforplayerdisconnect(param_00, param_01, param_02);
  level endon("gun_replaced " + param_01);
  level endon("game_ended");
  param_00 endon("disconnect");
  var_03 = getweaponbasename(param_01);
  var_04 = 1;
  for(;;) {
    if(!var_04) {
      break;
    }

    var_05 = undefined;
    param_00 waittill("last_stand");
    var_04 = 0;
    var_06 = param_00 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_06 != "revive") {
      var_05 = param_00 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_05) && var_05 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_07 = param_00 getweaponslistall();
    foreach(var_09 in var_07) {
      var_0A = getweaponbasename(var_09);
      if(var_0A == var_03) {
        param_00 thread watchforweaponremoved(param_00, param_01, param_02);
        var_04 = 1;
        break;
      }
    }
  }

  thread put_gun_back_on_standee(param_02, var_03, undefined, param_00);
  param_00 scripts\cp\utility::updatelaststandpistol();
}

init_standee_interaction() {
  var_00 = scripts\engine\utility::getstructarray("wor_standee", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.target)) {
      var_03 = getscriptablearray(var_02.target, "targetname");
      if(var_03.size > 0) {
        var_02.standee = var_03[0];
        var_02.standee.gun_on_standee = 1;
        var_02 thread init_standee_slots(::part_listener, var_02.standee.script_noteworthy);
      }
    }
  }
}

watchforweaponremoved(param_00, param_01, param_02) {
  level thread watchforplayerdisconnect(param_00, param_01, param_02);
  level endon("gun_replaced " + param_01);
  level endon("game_ended");
  param_00 endon("last_stand");
  param_00 endon("disconnect");
  var_03 = getweaponbasename(param_01);
  var_04 = 1;
  for(;;) {
    if(!var_04) {
      break;
    }

    param_00 scripts\engine\utility::waittill_any_3("weapon_purchased", "mule_munchies_sold");
    var_04 = 0;
    var_05 = param_00 getweaponslistall();
    foreach(var_07 in var_05) {
      var_08 = getweaponbasename(var_07);
      if(issubstr(var_08, var_03)) {
        var_04 = 1;
        break;
      }
    }
  }

  thread put_gun_back_on_standee(param_02, var_03, undefined, param_00);
  param_00 scripts\cp\utility::updatelaststandpistol();
}

watchforplayerdisconnect(param_00, param_01, param_02) {
  level endon("gun_replaced " + param_01);
  param_00 waittill("disconnect");
  thread put_gun_back_on_standee(param_02, param_01, undefined, param_00);
  param_00 scripts\cp\utility::updatelaststandpistol();
}