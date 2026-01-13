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
  level.ww_hintstrings["iw7_headcutter_zm"] = &"CP_QUEST_WOR_TAKE_HC";
  level.ww_hintstrings["iw7_shredder_zm"] = &"CP_QUEST_WOR_TAKE_SHREDDER";
  level.ww_hintstrings["iw7_facemelter_zm"] = &"CP_QUEST_WOR_TAKE_FACEMELTER";
  level.ww_hintstrings["iw7_dischord_zm"] = &"CP_QUEST_WOR_TAKE_DISCHORD";
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
  var_0 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.script_noteworthy)) {
      continue;
    }

    if(var_2.script_noteworthy == "ark_quest_station") {
      level.arkqueststation = var_2;
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

init_standee_slots(var_0, var_1) {
  self.gun_slot = spawnStruct();
  self.gun_slot.standee = self.standee;
  self.gun_slot.finished = 0;
  self.gun_slot.gun = var_1;
  self.gun_slot setup_standee_data(var_1);
  var_2 = [1, 2, 3];
  foreach(var_4 in var_2) {
    level thread[[var_0]](self.gun_slot, var_4);
  }
}

put_gun_back_on_standee(var_0, var_1, var_2, var_3) {
  level notify("gun_replaced " + var_1);
  if(isDefined(var_2)) {
    var_4 = isDefined(var_3) && isDefined(var_3.ephemeralweapon) && issubstr(var_3.ephemeralweapon, var_1);
    if(issubstr(var_2, "pap1") && !var_4) {
      var_0.standee.upgraded = 1;
    } else {
      var_0.standee.upgraded = 0;
    }
  } else {
    var_0.standee.upgraded = 0;
  }

  var_0.standee.gun_on_standee = 1;
  var_0.standee setscriptablepartstate("zapper", "craft_zapper", 1);
}

standee_hint_logic(var_0, var_1) {
  var_2 = var_0.standee;
  if(level.wor_items_placed[var_2.script_noteworthy]["toy"] && level.wor_items_placed[var_2.script_noteworthy]["battery"] && level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
    if(var_2.gun_on_standee) {
      return level.ww_hintstrings[var_2.script_noteworthy];
    } else {
      var_3 = var_1 getcurrentweapon();
      var_4 = getweaponbasename(var_3);
      if(issubstr(var_4, var_0.gun_slot.gun)) {
        return var_0.gun_slot.place_on_standee_string;
      } else {
        return "";
      }
    }
  }

  if(level.wor_items_picked_up[var_2.script_noteworthy]["toy"] && !level.wor_items_placed[var_2.script_noteworthy]["toy"]) {
    return &"CP_QUEST_WOR_PLACE_PART";
  } else if(level.wor_items_picked_up[var_2.script_noteworthy]["battery"] && !level.wor_items_placed[var_2.script_noteworthy]["battery"]) {
    return &"CP_QUEST_WOR_PLACE_PART";
  } else if(level.wor_items_picked_up[var_2.script_noteworthy]["crystal"] && !level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
    return &"CP_QUEST_WOR_PLACE_PART";
  }

  return &"CP_QUEST_WOR_ASSEMBLY";
}

standee_activate_logic(var_0, var_1) {
  var_2 = var_0.standee;
  if(level.wor_items_placed[var_2.script_noteworthy]["toy"] && level.wor_items_placed[var_2.script_noteworthy]["battery"] && level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
    if(var_2.gun_on_standee) {
      var_2.gun_on_standee = 0;
      var_2 setscriptablepartstate("zapper", "hide_zapper", 1);
      var_1 notify("weapon_purchased");
      wor_give_weapon(var_1, var_2.script_noteworthy, var_0.gun_slot);
      var_1 thread watchforweaponremoved(var_1, var_2.script_noteworthy, var_0.gun_slot);
      var_1 thread watchforplayerdeath(var_1, var_2.script_noteworthy, var_0.gun_slot);
      var_1 thread trackplayersworammo(var_1, var_2.script_noteworthy, var_0.gun_slot);
    } else {
      var_3 = var_1 getcurrentweapon();
      var_4 = getweaponbasename(var_3);
      if(issubstr(var_4, var_0.gun_slot.gun)) {
        var_5 = var_1 scripts\cp\utility::getvalidtakeweapon();
        var_1 takeweapon(var_5);
        var_6 = var_1 getweaponslistprimaries();
        var_7 = 0;
        for(var_8 = 0; var_8 < var_6.size; var_8++) {
          if(var_6[var_8] == "none") {
            continue;
          } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_6[var_8])) {
            continue;
          } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_6[var_8]))) {
            continue;
          } else if(scripts\cp\utility::is_melee_weapon(var_6[var_8], 1)) {
            continue;
          }

          var_7 = 1;
          var_1 switchtoweapon(var_6[var_8]);
          break;
        }

        if(!var_7) {
          var_9 = "iw7_fists_zm";
          var_1 scripts\cp\utility::_giveweapon(var_9, undefined, undefined, 1);
          var_1 switchtoweaponimmediate(var_9);
        }

        thread put_gun_back_on_standee(var_0.gun_slot, var_0.gun_slot.gun, var_3, var_1);
        var_1 scripts\cp\utility::updatelaststandpistol();
      }
    }
  }

  if(level.wor_items_picked_up[var_2.script_noteworthy]["toy"] && !level.wor_items_placed[var_2.script_noteworthy]["toy"]) {
    level.wor_items_placed[var_2.script_noteworthy]["toy"] = 1;
    var_2 place_part("toy");
    if(level.wor_items_placed[var_2.script_noteworthy]["toy"] && level.wor_items_placed[var_2.script_noteworthy]["battery"] && level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
      var_2 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }

  if(level.wor_items_picked_up[var_2.script_noteworthy]["battery"] && !level.wor_items_placed[var_2.script_noteworthy]["battery"]) {
    level.wor_items_placed[var_2.script_noteworthy]["battery"] = 1;
    var_2 place_part("battery");
    if(level.wor_items_placed[var_2.script_noteworthy]["toy"] && level.wor_items_placed[var_2.script_noteworthy]["battery"] && level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
      var_2 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }

  if(level.wor_items_picked_up[var_2.script_noteworthy]["crystal"] && !level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
    level.wor_items_placed[var_2.script_noteworthy]["crystal"] = 1;
    var_2 place_part("crystal");
    if(level.wor_items_placed[var_2.script_noteworthy]["toy"] && level.wor_items_placed[var_2.script_noteworthy]["battery"] && level.wor_items_placed[var_2.script_noteworthy]["crystal"]) {
      var_2 setscriptablepartstate("zapper", "craft_zapper", 1);
      return;
    }

    return;
  }
}

place_part(var_0) {
  self setscriptablepartstate(var_0, "part_placed");
  wait(1);
  self setscriptablepartstate(var_0, "part_placed_no_fx");
}

returnclosestcrystal(var_0) {
  return scripts\engine\utility::getclosest(var_0.origin, level.miniufos);
}

ent_near_crystal(var_0, var_1) {
  if(level.miniufos.size < 1) {
    return 0;
  }

  if(!scripts\cp\utility::weaponhasattachment(var_1, "arcane_base")) {
    return 0;
  }

  var_2 = 0;
  foreach(var_4 in level.miniufos) {
    var_5 = 562500;
    if(!isDefined(var_4) || scripts\engine\utility::istrue(var_4.fully_charged)) {
      continue;
    }

    if(distancesquared(var_4.origin, var_0.origin) < var_5) {
      var_2 = 1;
    }

    if(var_2) {
      break;
    }
  }

  if(var_2) {
    return 1;
  }

  return 0;
}

fake_crystal_logic(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_part_model(var_1, var_3);
  var_0 setModel(var_5);
  wait(0.25);
  var_6 = var_1.placement_fx;
  var_0 makeusable();
  var_0 setuserange(64);
  var_0 setusefov(120);
  var_7 = playFXOnTag(var_6, var_0, "tag_origin");
  var_0 sethintstring(&"CP_QUEST_WOR_PART");
  var_0 waittill("trigger", var_8);
  stopFXOnTag(var_6, var_0, "tag_origin");
  level.wor_items_picked_up[var_1.gun][var_4] = 1;
}

update_ufo_angles(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("fully_charged");
  for(;;) {
    var_0 waittill("next_position_found", var_6, var_7);
    var_8 = vectortoangles(var_7.origin - var_6.origin) + (180, 0, 0);
    var_0 rotateto(var_8, 0.5, 0.05, 0.05);
  }
}

start_crystal_path(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::getstructarray("essence_ufo_path", "script_noteworthy"));
  var_8 = 0;
  var_9 = var_7;
  var_0A = 1;
  var_0B = undefined;
  for(var_0C = get_next_valid_struct(var_6, var_9); var_0A; var_0C = var_0F) {
    if(isDefined(var_9.script_speed)) {
      var_0D = var_9.script_speed;
    } else {
      var_0D = undefined;
    }

    var_0E = get_move_rate(var_6, var_9.origin, var_0C.origin, var_0D);
    var_0F = var_0C;
    var_0F = get_next_valid_struct(var_6, var_0F);
    thread changeangledelay(var_6, var_0E, var_0F, var_9, var_0C);
    var_6 moveto(var_0C.origin, var_0E);
    var_10 = var_6 scripts\engine\utility::waittill_any_return("movedone", "fully_charged");
    if(scripts\engine\utility::istrue(var_6.fully_charged)) {
      for(;;) {
        var_0E = get_move_rate(var_6, var_6.origin, var_0C.origin, 2000);
        var_6 moveto(var_0C.origin, var_0E);
        if(can_use_struct_for_final_pos(var_0, var_0C)) {
          var_11 = scripts\engine\utility::drop_to_ground(var_0C.origin, 0, -400) + (0, 0, 40);
          var_12 = magicbullet("bolasprayprojhome_mp", var_6.origin, var_11);
          scripts\engine\utility::play_sound_in_space("miniufo_fire", var_6.origin, 0, var_6);
          var_0 dontinterpolate();
          var_0.origin = var_11;
          var_6.fully_charged = undefined;
          var_6 thread movetotraploop(var_6, var_6.origin, var_1);
          var_12 scripts\engine\utility::waittill_any_timeout_1(1.25, "death");
          if(isDefined(var_12)) {
            var_12 delete();
          }

          var_0.at_end_loc = 1;
          var_0A = 0;
          break;
        } else {
          var_6 waittill("movedone");
          var_9 = var_0C;
          var_0C = get_next_valid_struct(var_6, var_9);
          var_6 notify("next_position_found", var_9, var_0C);
        }
      }

      continue;
    }

    var_9 = var_0C;
  }
}

changeangledelay(var_0, var_1, var_2, var_3, var_4) {
  wait(max(0.05, var_1 - 0.35));
  var_0 notify("next_position_found", var_4, var_2);
}

movetotraploop(var_0, var_1, var_2) {
  var_0 waittill("movedone");
  var_0 setscriptablepartstate("miniufo", "mini_ufo");
  var_3 = scripts\engine\utility::random(var_2.starting_move_structs);
  var_0 setModel("tag_origin");
  var_0.origin = var_3.origin;
  var_0.angles = var_3.angles;
}

can_use_struct_for_final_pos(var_0, var_1) {
  if(isDefined(var_1.name)) {
    if(isDefined(var_1.name == "cant_stop_wont_stop")) {
      return 0;
    }
  }

  return 1;
}

get_next_valid_struct(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_1.target, "targetname");
  var_3 = [];
  var_4 = undefined;
  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

get_move_rate(var_0, var_1, var_2, var_3) {
  var_4 = distance(var_1, var_2);
  if(!isDefined(var_3)) {
    var_3 = int(clamp(level.wave_num * 15, 75, 150));
  }

  var_5 = var_4 / var_3;
  if(var_5 < 0.05) {
    var_5 = 0.05;
  }

  return var_5;
}

move_crystal_to_end_pos(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin, 0, -400) + (0, 0, 40);
  var_2 = distance(var_0.origin, var_1);
  var_3 = 2000;
  var_4 = var_2 / var_3;
  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  wait(2);
  var_0 moveto(var_1, var_4);
  var_0.at_end_loc = 1;
}

getminiufostartingstruct(var_0) {
  if(var_0.crystal_model == "zmb_weapon_crystal_green" && isDefined(level.dichordtraptrigger)) {
    return level.dichordtraptrigger;
  }

  if(var_0.crystal_model == "zmb_weapon_crystal_blue" && isDefined(level.fmtraptrigger)) {
    return level.fmtraptrigger;
  }

  if(var_0.crystal_model == "zmb_weapon_crystal_yellow" && isDefined(level.hctraptrigger)) {
    return level.hctraptrigger;
  }

  return scripts\engine\utility::random(var_0.starting_move_structs);
}

getminoufofromorbeffect(var_0, var_1) {
  switch (var_0) {
    case "blue":
      if(!isDefined(level.rocket_mini_ufo)) {
        var_2 = spawn("script_model", var_1.origin);
        var_2 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_2 = level.rocket_mini_ufo;
        if(var_2.model != "tag_origin_mini_ufo") {
          var_2 setModel("tag_origin_mini_ufo");
          var_2 dontinterpolate();
          var_2.origin = var_1.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "green":
      if(!isDefined(level.disco_mini_ufo)) {
        var_2 = spawn("script_model", var_2.origin);
        var_2 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_2 = level.disco_mini_ufo;
        if(var_2.model != "tag_origin_mini_ufo") {
          var_2 setModel("tag_origin_mini_ufo");
          var_2 dontinterpolate();
          var_2.origin = var_1.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "yellow":
      if(!isDefined(level.steel_dragon_mini_ufo)) {
        var_2 = spawn("script_model", var_2.origin);
        var_2 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_2 = level.steel_dragon_mini_ufo;
        if(var_2.model != "tag_origin_mini_ufo") {
          var_2 setModel("tag_origin_mini_ufo");
          var_2 dontinterpolate();
          var_2.origin = var_1.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    case "red":
      if(!isDefined(level.chromosphere_mini_ufo)) {
        var_2 = spawn("script_model", var_2.origin);
        var_2 setModel("tag_origin_mini_ufo");
        scripts\engine\utility::waitframe();
      } else {
        var_2 = level.chromosphere_mini_ufo;
        if(var_2.model != "tag_origin_mini_ufo") {
          var_2 setModel("tag_origin_mini_ufo");
          var_2 dontinterpolate();
          var_2.origin = var_1.origin;
          scripts\engine\utility::waitframe();
        }
      }
      break;

    default:
      var_2 = spawn("script_model", var_2.origin);
      var_2 setModel("tag_origin_mini_ufo");
      var_2 dontinterpolate();
      var_2.origin = var_1.origin;
      scripts\engine\utility::waitframe();
      break;
  }

  return var_2;
}

collect_arcane_essense(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getminiufostartingstruct(var_1);
  var_7 = var_1.largeessencefx;
  var_8 = getminoufofromorbeffect(var_7, var_6);
  var_8 setscriptablepartstate("miniufo", var_7);
  scripts\engine\utility::flag_set("mini_ufo_" + var_1.color + "_collecting");
  var_8 thread start_crystal_path(var_0, var_1, var_2, var_3, var_4, var_5, var_8);
  var_8 thread update_ufo_angles(var_8, var_1, var_2, var_3, var_4, var_5);
  level.miniufos[level.miniufos.size] = var_8;
  wait_for_crystal_to_charge(var_0, var_1, var_8, var_7);
  var_0 makeusable();
  var_0 setuserange(64);
  var_0 setusefov(120);
  var_0.gun_slot = var_1;
  if(scripts\engine\utility::istrue(var_5)) {
    var_0 thread timeout_crystal(var_0, var_1, var_3, var_8);
  }

  var_0 endon("death");
  create_essence_interaction(var_0);
  for(;;) {
    var_0 waittill("mini_ufo_completed", var_9);
    var_0 setscriptablepartstate("miniufo", "neutral");
    var_0 notify("picked_up");
    switch (var_1.color) {
      case "blue":
        var_9 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_blue_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "red":
        var_9 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_red_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "green":
        var_9 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_green_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      case "yellow":
        var_9 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_yellow_essence", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
        break;

      default:
        var_9 thread scripts\cp\cp_vo::try_to_play_vo("arcane_core_success", "zmb_comment_vo", "highest", 10, 0, 0, 0, 50);
        break;
    }

    level thread waittillnextwave(var_8, var_1);
    reset_trap_kill_count(var_0, var_1, var_3);
    var_0 makeunusable();
    if(scripts\engine\utility::istrue(var_5)) {
      var_0 delete();
    } else {
      var_0 setModel("tag_origin");
    }

    break;
  }
}

waittillnextwave(var_0, var_1) {
  level waittill("regular_wave_starting");
  if(var_0.model != "tag_origin_mini_ufo") {
    var_0 setModel("tag_origin_mini_ufo");
  }

  scripts\engine\utility::flag_clear("mini_ufo_" + var_1.color + "_collecting");
}

essence_pickup_func(var_0, var_1) {
  if(!isDefined(var_0.at_end_loc)) {
    return;
  }

  if(!scripts\cp\utility::weaponhasattachment(var_1 getcurrentweapon(), "arcane_base")) {
    return;
  }

  var_0 notify("mini_ufo_completed", var_1);
  var_1 playlocalsound("part_pickup");
  remove_essence_interaction(var_0);
  var_1 thread charge_players_arcane_base_attachment(var_1, var_0.gun_slot);
}

create_essence_interaction(var_0) {
  var_0.script_noteworthy = "spawned_essence";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.script_parameters = "default";
  var_0.custom_search_dist = 96;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

remove_essence_interaction(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.script_noteworthy = undefined;
  var_0.requires_power = undefined;
  var_0.powered_on = undefined;
  var_0.script_parameters = undefined;
  var_0.custom_search_dist = undefined;
}

playufoeffectonplayerconnect(var_0, var_1) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_2);
    thread playeffectwhenspawned(var_0, var_1, var_2);
  }
}

playeffectwhenspawned(var_0, var_1, var_2) {
  level endon("game_ended");
  var_2 endon("disconnect");
  var_2 waittill("spawned_player");
  playFXOnTag(var_0, var_1, "tag_origin");
}

disablepickuppromptfortime(var_0, var_1) {
  var_0 disableplayeruse(var_1);
  wait(1);
  var_0 enableplayeruse(var_1);
}

run_mini_ufo_logic(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("timed_out");
  var_5 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, undefined, 4, 512);
  foreach(var_7 in var_5) {
    var_7 thread scripts\cp\cp_vo::try_to_play_vo("arcane_core_event", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  }

  var_0 collect_arcane_essense(var_0, var_1, var_2, var_3, var_4);
  var_9 = var_1.crystal_slot;
  struct_wait_for_damage(var_9, var_1.crystal_model, var_0, var_1, var_2, var_3, var_4);
}

timeout_crystal(var_0, var_1, var_2, var_3) {
  var_0 endon("picked_up");
  wait(30);
  level thread waittillnextwave(var_3, var_1);
  playsoundatpos(var_0.origin, "zmb_coin_disappear");
  playFX(level._effect["souvenir_pickup"], var_0.origin);
  remove_essence_interaction(var_0);
  reset_trap_kill_count(var_0, var_1, var_2);
  var_0 setscriptablepartstate("miniufo", "neutral");
  var_0 makeunusable();
  var_0 setModel("tag_origin");
  var_0 delete();
}

reset_trap_kill_count(var_0, var_1, var_2) {
  var_3 = var_1.crystal_model;
  switch (var_3) {
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

  thread crystal_listener(var_1, var_2);
}

crystal_listener(var_0, var_1) {
  var_2 = get_part_name(var_1);
  var_3 = undefined;
  level waittill("ww_" + var_0.gun + "_" + var_2 + "_dropped", var_4);
  var_5 = spawn("script_model", var_4 + (0, 0, 30));
  var_6 = get_part_model(var_0, var_1);
  if(scripts\engine\utility::istrue(level.skip_crystal_logic)) {
    level.skip_crystal_logic = 0;
    fake_crystal_logic(var_5, var_0, var_4, var_1, var_2);
    return;
  }

  var_5 collect_arcane_essense(var_5, var_0, var_4, var_1, var_2, 1);
}

struct_wait_for_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  scripts\engine\utility::flag_wait("gator_tooth_broken");
  var_7 = strtok(var_1, "_");
  var_8 = var_7[3];
  var_9 = level.arkqueststation;
  var_0A = scripts\engine\utility::getstruct("slot_" + var_0, "script_noteworthy");
  var_2.origin = var_0A.origin;
  var_2.angles = anglestoup(var_0A.angles);
  var_2 setModel(var_1);
  var_0B = getent("crystal_damage_trigger_" + var_0, "targetname");
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

    if(!scripts\cp\utility::weaponhasattachment(var_15, "ark" + var_8)) {
      continue;
    }

    playsoundatpos(var_2.origin, "arc_machine_door_shoot_off");
    var_0B setCanDamage(0);
    var_0B hide();
    if(!isDefined(var_9.crystals)) {
      var_9.crystals = [];
    }

    var_9.crystals[var_9.crystals.size] = var_2;
    scripts\engine\utility::flag_wait(var_8 + "_crystal_placed");
    break;
  }

  level.wor_items_picked_up[var_3.gun][var_6] = 1;
  if(isplayer(var_0D)) {
    switch (var_3.gun) {
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

run_battery_logic(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_part_model(var_1, var_3);
  var_0 setModel(var_5);
  if(var_1.gun == "iw7_dischord_zm") {
    var_6 = "dischord";
    if(scripts\engine\utility::istrue(level.skip_battery_logic)) {
      level.skip_battery_logic = 0;
      wait(0.25);
    } else {
      var_0 dischord_battery_move();
    }
  } else if(var_2.gun == "iw7_facemelter_zm") {
    var_6 = "melter";
    level.facemelter_battery = var_0;
    wait(0.25);
  } else if(var_2.gun == "iw7_shredder_zm") {
    var_6 = "shredder";
    level.shredder_battery = var_0;
    wait(0.25);
  } else {
    var_6 = "cutter";
    wait(0.25);
  }

  var_0 setscriptablepartstate("model", var_1.toy_model_state);
  var_0 thread rotate_wor_piece();
  var_0 makeusable();
  var_0 setuserange(64);
  var_0 setusefov(120);
  var_0 sethintstring(&"CP_QUEST_WOR_PART");
  var_0 waittill("trigger", var_7);
  var_7 thread scripts\cp\cp_vo::try_to_play_vo("quest_" + var_6 + "_battery", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
  var_0 setscriptablepartstate("pickup_piece", "pickup_piece");
  level.wor_items_picked_up[var_1.gun][var_4] = 1;
  wait(0.25);
  var_0 setscriptablepartstate("model", "neutral");
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

run_toy_logic(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 0);
  var_6 = (0, 0, 0);
  switch (var_1.gun) {
    case "iw7_shredder_zm":
      var_7 = getent("toy_angry_mike", "targetname");
      var_5 = var_7.origin;
      var_6 = var_7.angles;
      var_7 hide();
      break;

    case "iw7_facemelter_zm":
      var_7 = getent("toy_shuttle", "targetname");
      var_5 = var_7.origin;
      var_6 = var_7.angles;
      var_7 hide();
      break;

    case "iw7_dischord_zm":
      var_7 = getent("toy_disco_ball", "targetname");
      var_5 = var_7.origin;
      var_6 = var_7.angles;
      var_7 hide();
      break;

    case "iw7_headcutter_zm":
      var_7 = getent("toy_yeti", "targetname");
      var_5 = var_7.origin;
      var_6 = var_7.angles;
      var_7 hide();
      break;
  }

  var_0 setModel(var_1.toy_model);
  var_0.origin = var_5;
  var_0.angles = var_6;
  wait(0.1);
  var_0 setscriptablepartstate("model", var_1.toy_model_state);
  var_8 = scripts\engine\utility::getstructarray("interaction", "targetname");
  var_9 = scripts\engine\utility::getclosest(var_0.origin, var_8);
  if(!isDefined(var_9.angles)) {
    var_9.angles = (0, 0, 0);
  }

  var_0 follow_struct_trail(var_9, var_5, var_6);
  var_0 makeusable();
  var_0 setuserange(64);
  var_0 setusefov(120);
  var_0 sethintstring(&"CP_QUEST_WOR_PART");
  var_0 thread spin_toy();
  var_0 waittill("trigger", var_0A);
  switch (var_0.model) {
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

  var_0 setscriptablepartstate("pickup_piece", "pickup_piece");
  level.wor_items_picked_up[var_1.gun][var_4] = 1;
  wait(0.25);
  var_0 setscriptablepartstate("model", "neutral");
  var_0 setModel("tag_origin");
}

part_listener(var_0, var_1) {
  var_2 = get_part_name(var_1);
  var_3 = undefined;
  level waittill("ww_" + var_0.gun + "_" + var_2 + "_dropped", var_4);
  var_5 = var_0.gun;
  var_6 = (0, 0, 30);
  if(var_0.gun == "iw7_headcutter_zm" && var_2 == "battery") {
    var_6 = (0, 0, 0);
  }

  var_7 = spawn("script_model", var_4 + var_6);
  var_8 = get_part_model(var_0, var_1);
  switch (var_2) {
    case "crystal":
      if(level.skip_crystal_logic) {
        level.skip_crystal_logic = 0;
        fake_crystal_logic(var_7, var_0, var_4, var_1, var_2);
      } else {
        run_mini_ufo_logic(var_7, var_0, var_4, var_1, var_2);
      }
      break;

    case "toy":
      run_toy_logic(var_7, var_0, var_4, var_1, var_2);
      break;

    case "battery":
      run_battery_logic(var_7, var_0, var_4, var_1, var_2);
      break;
  }

  var_7 delete();
  level thread scripts\cp\cp_vo::add_to_nag_vo("dj_wor_use_nag", "zmb_dj_vo", 60, 30, 2, 1);
  var_9 = get_omnvar_bit(var_0.gun, var_1);
  level notify("ww_" + var_0.gun + "_" + var_2 + "_picked_up");
  level scripts\cp\utility::set_quest_icon(var_9);
}

wait_for_crystal_to_charge(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_2.runner_count = 0;
  var_2.expected_souls = 0;
  var_5 = 25;
  while(var_4 < var_5) {
    level waittill("kill_near_crystal", var_6, var_7, var_8);
    var_2.expected_souls--;
    if(var_2 != var_8) {
      continue;
    }

    if(!scripts\cp\utility::weaponhasattachment(var_7, "arcane_base")) {
      continue;
    }

    thread crytsal_capture_killed_essense(var_6, var_2);
    var_2.runner_count++;
    var_4++;
  }

  while(var_2.runner_count >= 1) {
    wait(0.05);
  }

  var_2.fully_charged = 1;
  var_2 notify("fully_charged");
  while(!isDefined(var_0.at_end_loc)) {
    wait(0.1);
  }

  var_0 setModel("tag_origin_ground_essence", var_3);
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("quest_arcane_ufo_start");
  scripts\engine\utility::waitframe();
  var_0 setscriptablepartstate("miniufo", var_3);
  if(isDefined(var_2) && scripts\engine\utility::array_contains(level.miniufos, var_2)) {
    level.miniufos = scripts\engine\utility::array_remove(level.miniufos, var_2);
  }
}

crytsal_capture_killed_essense(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin_soultrail");
  var_3 = var_1.origin;
  var_4 = var_0 + (0, 0, 40);
  for(;;) {
    var_5 = distance(var_4, var_3);
    var_6 = 1500;
    var_7 = var_5 / var_6;
    if(var_7 < 0.05) {
      var_7 = 0.05;
    }

    var_2 moveto(var_3, var_7);
    var_2 waittill("movedone");
    if(distance(var_2.origin, var_1.origin) > 16) {
      var_3 = var_1.origin;
      var_4 = var_2.origin;
      continue;
    }

    break;
  }

  var_1 setscriptablepartstate("sparks", "sparks");
  wait(0.25);
  var_1 setscriptablepartstate("sparks", "neutral");
  var_1.runner_count--;
  var_2 delete();
}

charge_players_arcane_base_attachment(var_0, var_1) {
  var_2 = strtok(var_1.crystal_model, "_");
  var_3 = var_2[3];
  var_4 = "ark" + var_3;
  var_0 setscriptablepartstate("arcane", "arcane_absorb", 0);
  wait(0.25);
  var_0 scripts\engine\utility::allow_weapon_switch(0);
  var_5 = var_0 getcurrentweapon();
  var_0 scripts\cp\cp_weapon::add_attachment_to_weapon(var_4, var_5, 1);
  while(var_0 isswitchingweapon()) {
    wait(0.05);
  }

  var_0 scripts\engine\utility::allow_weapon_switch(1);
  level thread play_arcane_vo(var_0);
  var_0 scripts\cp\cp_persistence::give_player_xp(500, 1);
}

play_arcane_vo(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  wait(10);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_ufo_success", "zmb_comment_vo", "highest", 10, 0, 0, 1);
  wait(7);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_arcane_corecharged_complete", "zmb_ww_vo", "highest", 60, 0, 0, 1);
}

set_gun_slot_from_part_num(var_0, var_1) {
  switch (var_1) {
    case 1:
      var_0.part_1 = 1;
      break;

    case 2:
      var_0.part_2 = 1;
      break;

    case 3:
      var_0.part_3 = 1;
      break;
  }
}

setup_standee_data(var_0) {
  var_1 = getweaponbasename(var_0);
  switch (var_1) {
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
  self.place_on_standee_string = &"CP_QUEST_WOR_PLACE_HC";
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
  self.place_on_standee_string = &"CP_QUEST_WOR_PLACE_FACEMELTER";
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
  self.place_on_standee_string = &"CP_QUEST_WOR_PLACE_DISCHORD";
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
  self.place_on_standee_string = &"CP_QUEST_WOR_PLACE_SHREDDER";
}

get_part_name(var_0) {
  switch (var_0) {
    case 1:
      return "toy";

    case 2:
      return "battery";

    case 3:
      return "crystal";
  }

  return undefined;
}

get_omnvar_bit(var_0, var_1) {
  var_2 = getweaponbasename(var_0);
  switch (var_2) {
    case "iw7_headcutter_zm":
      switch (var_1) {
        case 1:
          return 10;

        case 2:
          return 11;

        case 3:
          return 12;
      }
      break;

    case "iw7_facemelter_zm":
      switch (var_1) {
        case 1:
          return 13;

        case 2:
          return 14;

        case 3:
          return 15;
      }
      break;

    case "iw7_dischord_zm":
      switch (var_1) {
        case 1:
          return 16;

        case 2:
          return 17;

        case 3:
          return 18;
      }
      break;

    case "iw7_shredder_zm":
      switch (var_1) {
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

get_part_model(var_0, var_1) {
  switch (var_1) {
    case 1:
      return var_0.toy_model;

    case 2:
      return var_0.battery_model;

    case 3:
      return var_0.crystal_model;
  }

  return undefined;
}

get_toy_angle_offset(var_0) {
  var_1 = getweaponbasename(var_0.gun);
  switch (var_1) {
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

get_toy_pos_offset(var_0) {
  var_1 = getweaponbasename(var_0.gun);
  switch (var_1) {
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

wor_quest_death_update_func(var_0, var_1) {
  if(scripts\engine\utility::flag("mini_ufo_yellow_ready") && level.head_cutter_trap_kills >= 15) {
    level notify("ww_iw7_headcutter_zm_crystal_dropped", var_0.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_red_ready") && level.angry_mike_trap_kills >= 15) {
    level notify("ww_iw7_shredder_zm_crystal_dropped", var_0.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_green_ready") && level.disco_trap_kills >= 15) {
    level notify("ww_iw7_dischord_zm_crystal_dropped", var_0.origin);
  }

  if(scripts\engine\utility::flag("mini_ufo_blue_ready") && level.rocket_trap_kills >= 15) {
    level notify("ww_iw7_facemelter_zm_crystal_dropped", var_0.origin);
  }
}

wor_quest_crafting_func() {
  level.headcutter_crafting_list = ["zmb_coin_ice", "zmb_coin_ice", "zmb_coin_ice"];
  level.shredder_crafting_list = ["zmb_coin_alien", "zmb_coin_alien", "zmb_coin_alien"];
  level.dischord_crafting_list = ["zmb_coin_alien", "zmb_coin_space", "zmb_coin_ice"];
  level.facemelter_crafting_list = ["zmb_coin_space", "zmb_coin_space", "zmb_coin_space"];
  var_0 = "europa_tunnel";
  var_1 = "moon_outside_begin";
  var_2 = "mars_3";
  var_3 = "moon_bumpercars";
  var_4 = [];
  while(var_4.size < 4) {
    level waittill("quest_crafting_check", var_5);
    if(scripts\cp\utility::is_codxp()) {
      continue;
    }

    if(!isDefined(var_4["iw7_headcutter_zm"]) && ingredient_list_check(var_5.ingredient_list, level.headcutter_crafting_list)) {
      if(isDefined(var_5.power_area) && var_5.power_area == var_0) {
        level notify("ww_iw7_headcutter_zm_toy_dropped", var_5.origin);
        var_4["iw7_headcutter_zm"] = 1;
      }
    }

    if(!isDefined(var_4["iw7_shredder_zm"]) && ingredient_list_check(var_5.ingredient_list, level.shredder_crafting_list)) {
      if(isDefined(var_5.power_area) && var_5.power_area == var_2) {
        level notify("ww_iw7_shredder_zm_toy_dropped", var_5.origin);
        var_4["iw7_shredder_zm"] = 1;
      }
    }

    if(!isDefined(var_4["iw7_dischord_zm"]) && ingredient_list_check(var_5.ingredient_list, level.dischord_crafting_list)) {
      if(isDefined(var_5.power_area) && var_5.power_area == var_3) {
        level notify("ww_iw7_dischord_zm_toy_dropped", var_5.origin);
        var_4["iw7_dischord_zm"] = 1;
      }
    }

    if(!isDefined(var_4["iw7_facemelter_zm"]) && ingredient_list_check(var_5.ingredient_list, level.facemelter_crafting_list)) {
      if(isDefined(var_5.power_area) && var_5.power_area == var_1) {
        level notify("ww_iw7_facemelter_zm_toy_dropped", var_5.origin);
        var_4["iw7_facemelter_zm"] = 1;
      }
    }
  }
}

ingredient_list_check(var_0, var_1) {
  if(var_1.size == 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    var_4 = undefined;
    foreach(var_6 in var_1) {
      if(var_3 == var_6) {
        var_4 = var_6;
        break;
      }
    }

    if(!isDefined(var_4)) {
      return 0;
    } else {
      var_1 = array_remove_single(var_1, var_4);
    }
  }

  return 1;
}

array_remove_single(var_0, var_1) {
  var_2 = 0;
  var_3 = [];
  foreach(var_5 in var_0) {
    if(var_2) {
      var_3[var_3.size] = var_5;
      continue;
    }

    if(var_5 != var_1) {
      var_3[var_3.size] = var_5;
      continue;
    }

    var_2 = 1;
  }

  return var_3;
}

follow_struct_trail(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getstructarray("toy_trail_start", "targetname");
  var_4 = scripts\engine\utility::getclosest(self.origin, var_3);
  wait(0.5);
  self moveto(var_4.origin, 0.5);
  self waittill("movedone");
  var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
  self moveto(var_5.origin, 0.5);
  self waittill("movedone");
  while(isDefined(var_5.target)) {
    var_5 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    if(!isDefined(var_5.target)) {
      var_6 = var_5.origin - var_4.origin;
      var_6 = vectornormalize(var_6);
      var_6 = var_6 * 40;
      var_6 = (var_6[0], var_6[1], 0);
      var_5.origin = var_5.origin + var_6;
    }

    self moveto(var_5.origin, 0.75);
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
  var_0 = getEntArray("portal_grenade_volume", "targetname");
  for(;;) {
    self waittill("grenade_fire", var_1, var_2);
    if(isDefined(var_1) && isDefined(var_2)) {
      var_1 thread wait_for_impact(var_0[0], var_2, self);
    }
  }
}

check_for_grenade_in_volume(var_0, var_1, var_2) {
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

      if(self istouching(var_0)) {
        level.hot_potato_stage = 1;
        level thread start_hot_potato(self, var_0, var_1, var_2);
      }
    } else if(isDefined(level.hot_potato_carrier) && var_2 == level.hot_potato_carrier && is_thrown_back_grenade(var_2)) {
      self.potato = 1;
      level.hot_potato_carrier = undefined;
      level.last_potato_carrier = var_2;
      if(self istouching(var_0)) {
        level thread throw_battery_out_of_portal(self, var_2);
      }
    }

    if(scripts\engine\utility::istrue(self.potato)) {
      if(self istouching(var_0)) {
        level thread throw_battery_out_of_portal(self, var_2);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

start_hot_potato(var_0, var_1, var_2, var_3) {
  level endon("end_hot_potato_stage_1");
  level.potatoes_needed = 1;
  var_4 = var_0 throw_grenade_back(var_1, var_2, var_3, 5);
  var_0 delete();
  var_4 thread notify_on_explode();
  var_4 thread listen_for_pickup();
  var_5 = level scripts\engine\utility::waittill_any_return("hot_potato_timed_out");
  if(var_5 == "hot_potato_timed_out") {
    if(isDefined(level.last_potato_carrier)) {
      level thread play_fail_sound(level.last_potato_carrier, 2);
    }

    level.hot_potato_carrier = undefined;
    level.last_potato_carrier = undefined;
    level.hot_potato_stage = 0;
  }
}

play_fail_sound(var_0, var_1) {
  var_0 endon("death");
  wait(var_1);
  var_0 playlocalsound("zapper_grenade_toss_fail");
}

listen_for_pickup() {
  level endon("hot_potato_timed_out");
  self waittill("trigger", var_0);
  level.hot_potato_carrier = var_0;
}

throw_battery_out_of_portal(var_0, var_1) {
  level.hot_potato_stage = 2;
  level notify("ww_iw7_facemelter_zm_battery_dropped", var_1.origin);
  var_0 delete();
}

notify_on_explode() {
  self waittill("explode");
  level.hot_potato_stage = 0;
  level notify("hot_potato_timed_out");
}

throw_grenade_back(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 5;
  }

  var_4 = (3756, 1379, 115);
  var_5 = (-200, 0, 0);
  var_5 = var_5 + (randomintrange(-100, 100), randomintrange(-10, 10), 0);
  var_6 = var_0 launchgrenade("frag_grenade_zm", var_4, var_5, var_3);
  var_6 hudoutlineenable(1, 1, 1);
  var_6.potato = 1;
  return var_6;
}

is_thrown_back_grenade(var_0) {
  if(!isDefined(var_0.throwinggrenade)) {
    return 1;
  }

  return 0;
}

notify_test(var_0) {
  self waittill(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = 0;
}

wait_for_impact(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 20;
  var_4 = var_3 * var_3;
  var_5 = scripts\engine\utility::getstructarray("freeze_breath_struct", "targetname");
  var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_5);
  var_6 = var_5[0];
  if(!isDefined(level.facemelter_portal)) {
    level.facemelter_portal = scripts\engine\utility::getclosest(var_0.origin, level.fast_travel_spots);
  }

  if(facemelter_grenade_check(var_1)) {
    if(!isDefined(level.hot_potato_stage) || level.hot_potato_stage < 1) {
      thread check_for_grenade_in_volume(var_0, var_1, var_2);
    } else if(level.hot_potato_stage < 2) {
      if(isDefined(level.hot_potato_carrier) && level.hot_potato_carrier == var_2) {
        self.potato = 1;
        level.hot_potato_carrier = undefined;
        thread notify_on_explode();
        thread listen_for_pickup();
        var_0 = getent("center_portal_grenade_volume", "targetname");
        thread check_for_grenade_in_volume(var_0, var_1, var_2);
      }
    }
  }

  thread listen_for_mouth_explosion(var_4, var_6, var_2);
}

facemelter_grenade_check(var_0) {
  switch (var_0) {
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "frag_grenade_zm":
      return 1;
  }

  return 0;
}

listen_for_mouth_explosion(var_0, var_1, var_2) {
  if(!isDefined(self.weapon_name) || self.weapon_name != "zfreeze_semtex_mp") {
    return;
  }

  self waittill("explode", var_3);
  var_4 = getent("headcutter_grenade_vol", "targetname");
  if(ispointinvolume(var_3, var_4)) {
    var_1 notify("cryo_hit");
    if(isDefined(var_2)) {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("quest_icemonster_grenade", "zmb_comment_vo", "highest", 10, 1, 0, 0, 100);
    }
  }
}

listen_for_triton_power() {
  level scripts\engine\utility::waittill_any_return("power_on", "europa_tunnel power_on");
  scripts\engine\utility::flag_init("listen_for_cryo_hit");
  scripts\engine\utility::flag_set("listen_for_cryo_hit");
}

wor_change_portal(var_0) {
  if(!isDefined(level.wor_portal_change_time) || level.wor_portal_change_time < 5) {
    level.wor_portal_change_time = 5;
  }

  while(level.wor_portal_change_time > 0) {
    level.wor_portal_change_time--;
    wait(1);
  }
}

wait_to_spawn_facemelter_battery() {
  level waittill("player_entering_wor_changed_portal", var_0);
  var_1 = scripts\engine\utility::getstruct("facemelter_battery_org", "targetname");
  level notify("ww_iw7_facemelter_zm_battery_dropped", var_1.origin);
  while(!isDefined(level.facemelter_battery)) {
    wait(0.1);
  }

  level thread facemelter_battery_phase_listener();
}

facemelter_battery_phase_listener() {
  level endon("ww_iw7_facemelter_zm_battery_picked_up");
  for(;;) {
    foreach(var_1 in level.players) {
      if(!var_1 is_in_fake_phase_shift()) {
        level.facemelter_battery hidefromplayer(var_1);
        level.facemelter_battery disableplayeruse(var_1);
        continue;
      }

      level.facemelter_battery showtoplayer(var_1);
      level.facemelter_battery enableplayeruse(var_1);
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
  var_0 = getEntArray("dischord_target", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = 0;
  var_2 = scripts\engine\utility::getclosest((3504, -1297, 172), var_0, 500);
  var_3 = scripts\engine\utility::getclosest((1865, -2068, 1046), var_0, 500);
  level.dischord_targets = [5];
  foreach(var_5 in var_0) {
    if(var_1 < 5) {
      level.dischord_targets[var_1] = var_5;
      level thread dischord_target_listener(var_5);
    }

    if(var_5 == var_2) {
      var_5.origin = var_5.origin + (0, -25, 5);
    }

    if(var_5 == var_3) {
      var_5.origin = (1866, -2107, 835);
      var_5.angles = (74, 117, 0);
    }

    var_5 hide();
    var_1++;
  }

  level thread dischord_visibility_listener();
  level waittill("ww_iw7_dischord_zm_battery_dropped");
}

dischord_target_listener(var_0) {
  var_0 hudoutlineenable(1, 1, 0);
  var_0 setCanDamage(1);
  var_1 = 0;
  while(!var_1) {
    var_0 waittill("damage", var_2, var_3);
    if(isplayer(var_3) && scripts\engine\utility::istrue(var_3.wearing_dischord_glasses) || level.debug_dischord_targets) {
      level.dischord_targets_hit++;
      var_1 = 1;
      if(level.dischord_targets_hit >= 5) {
        level notify("ww_iw7_dischord_zm_battery_dropped", var_0.origin - (0, 0, 50));
      }
    }
  }

  playFX(level._effect["pickup"], var_0.origin);
  var_0 notify("stop_visibility_listener");
  if(scripts\engine\utility::array_contains(level.dischord_targets, var_0)) {
    level.dischord_targets = scripts\engine\utility::array_remove(level.dischord_targets, var_0);
  }

  var_0 delete();
}

dischord_visibility_listener() {
  self endon("stop_visibility_listener");
  if(!isDefined(level.debug_dischord_targets)) {
    level.debug_dischord_targets = 0;
  }

  for(;;) {
    foreach(var_1 in level.dischord_targets) {
      foreach(var_3 in level.players) {
        if(scripts\engine\utility::istrue(var_3.wearing_dischord_glasses) || level.debug_dischord_targets) {
          var_1 showtoplayer(var_3);
          var_1 hudoutlineenable(1, 1, 0);
          continue;
        }

        var_1 hidefromplayer(var_3);
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
    var_0 = getdvarint("scr_show_dischord_targets", 0);
    if(var_0 != 0) {
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
  var_0 = getEntArray("dischord_target", "targetname");
  foreach(var_2 in var_0) {
    var_2 show();
    var_2 hudoutlineenable(1, 0, 0);
  }
}

debug_make_dischord_targets_invisible() {
  var_0 = getEntArray("dischord_target", "targetname");
  foreach(var_2 in var_0) {
    var_2 hudoutlineenable(1, 1, 0);
    var_2 hide();
  }
}

dischord_battery_move() {
  var_0 = scripts\engine\utility::getstruct("dischord_battery_end_loc", "targetname");
  self moveto(var_0.origin, 5, 0.1, 0.1);
  self waittill("movedone");
}

wor_quest_pillage_func() {
  if(!isDefined(level.glasses_drop_change_increase)) {
    level.glasses_drop_change_increase = 0;
  }

  var_0 = randomint(100);
  var_1 = 10 + level.glasses_drop_change_increase;
  if(var_0 < var_1 && !level.wor_glasses) {
    level.glasses_drop_change_increase = 0;
    return "quest";
  } else {
    level.glasses_drop_change_increase = level.glasses_drop_change_increase + 10;
  }

  return undefined;
}

wor_quest_specific_pillage_show_func(var_0, var_1, var_2) {
  playFX(level._effect["souvenir_pickup"], var_2.origin + (0, 0, 30));
  var_0 give_glasses_power();
  var_0 scripts\cp\utility::setlowermessage("msg_power_hint", &"CP_QUEST_WOR_GLASSES_TOGGLE", 4);
  var_2 notify("all_players_searched");
}

give_glasses_power() {
  var_0 = spawnStruct();
  var_0.power_name = "power_glasses";
  scripts\cp\powers\coop_powers::give_player_wall_bought_power(var_0, self);
  var_0 = undefined;
}

wor_quest_create_pillage_interaction(var_0, var_1) {
  var_0.type = "quest";
  var_0.randomintrange = "quest";
  var_1.effect = spawnfx(level._effect["quest_glasses_drop"], var_1.origin);
  level.wor_glasses = 1;
  var_0 thread unset_flag_if_not_picked_up(var_1.effect);
  scripts\engine\utility::waitframe();
  triggerfx(var_1.effect);
}

unset_flag_if_not_picked_up(var_0) {
  self endon("picked_up");
  self waittill("stop_pillage_spot_think");
  level.wor_glasses = 0;
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

give_glasses_to_player() {
  self.has_dischord_glasses = 1;
  self.dont_use_charges = "power_glasses";
  thread listen_to_toggle_glasses();
  thread reset_flags_on_death();
  scripts\engine\utility::flag_set("dischord_glasses_pickedup");
}

put_glasses_on_player(var_0) {
  var_1 = "ges_visor_up";
  if(!self isgestureplaying()) {
    var_2 = 0;
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

take_glasses_off(var_0) {
  if(var_0) {
    thread launch_glasses();
    return;
  }

  self.wearing_dischord_glasses = 0;
  if(isDefined(level.vision_set_override)) {
    self visionsetnakedforplayer(level.vision_set_override, 0.1);
  } else {
    self visionsetnakedforplayer("", 0.1);
  }

  var_1 = "ges_visor_down";
  if(!self isgestureplaying()) {
    var_2 = 0;
    self setweaponammostock("iw7_sunglasses_zm_off", 1);
    self giveandfireoffhand("iw7_sunglasses_zm_off");
  }
}

launch_glasses() {
  self endon("deleting_glasses");
  scripts\cp\powers\coop_powers::removepower("power_glasses");
  var_0 = 400;
  var_1 = self gettagorigin("tag_eye");
  var_2 = self gettagangles("tag_eye");
  var_2 = anglesToForward(var_2);
  var_3 = vectornormalize(var_2) + (0, 0, 0.25);
  var_3 = var_3 * var_0;
  var_4 = self getvelocity();
  var_3 = var_3 + var_4;
  var_5 = spawn("script_model", var_1);
  var_5 setModel("zmb_sunglass_01_wm");
  var_5 physicslaunchserver(var_1, var_3);
  wait(0.1);
  var_5 thread pick_up_knocked_off_glasses();
  var_5 thread delete_glasses_after_time(10);
  var_5 waittill("trigger", var_6);
  var_6 give_glasses_power();
  var_5 notify("glasses_picked_up");
  var_5 delete();
}

wait_to_knock_off_glasses() {
  level endon("ww_iw7_dischord_zm_battery_dropped");
  self notify("waiting_for_knock_off");
  self endon("waiting_for_knock_off");
  while(self.has_dischord_glasses) {
    self waittill("damage", var_0, var_1);
    if(isDefined(var_1.team) && var_1.team != self.team) {
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

delete_glasses_after_time(var_0) {
  self endon("glasses_picked_up");
  wait(var_0);
  self notify("deleting_glasses");
  level.wor_glasses = 0;
  self delete();
}

pick_up_knocked_off_glasses() {
  self hudoutlineenable(2, 1, 0);
  self makeusable();
  var_0 = &"CP_QUEST_WOR_PART";
  self sethintstring(var_0);
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

setdischordglasses(var_0) {
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
  var_0 = scripts\engine\utility::getstructarray("freeze_breath_struct", "targetname");
  foreach(var_2 in var_0) {
    if(var_2.target == "freeze_volume_1") {
      var_2 thread headcutter_freeze_loop();
      var_2 thread freeze_check_loop();
      var_2 thread listen_for_cryo_kills();
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
  var_0 = getent("main_street_monster", "targetname");
  var_1 = 10;
  for(;;) {
    self waittill("cryo_hit");
    if(self.freeze_active) {
      var_0 setscriptablepartstate("main", "breath_attack_in");
      thread freeze_breath(var_1);
      activate_freeze_volume(var_1);
      var_0 setscriptablepartstate("main", "idle2");
    }

    wait(0.1);
  }
}

activate_freeze_volume(var_0) {
  var_1 = gettime() + var_0 * 1000;
  while(gettime() < var_1) {
    foreach(var_3 in level.spawned_enemies) {
      if(isDefined(var_3.agent_type) && var_3.agent_type == "generic_zombie" || var_3.agent_type == "zombie_cop") {
        if(var_3 istouching(self.freeze_volume)) {
          var_3.freeze_struct = self;
          var_3 dodamage(1, var_3.origin, level.players[0], level.players[0], "MOD_GRENADE_SPLASH", "zfreeze_semtex_mp");
        }
      }
    }

    wait(0.1);
  }
}

freeze_breath(var_0) {
  var_1 = getent("main_street_monster", "targetname");
  var_2 = spawnfx(level._effect["coaster_ice_frost"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  wait(2);
  var_1 playSound("yeti_frost_breath");
  triggerfx(var_2);
  wait(var_0 - 1);
  var_2 delete();
}

listen_for_cryo_kills() {
  var_0 = 0;
  var_1 = 10;
  while(var_0 < var_1) {
    self waittill("headcutter_cryo_kill", var_2, var_3);
    var_0++;
    level.total_cryo_kills++;
  }

  var_4 = getent("main_street_monster", "targetname");
  var_4 playSound("yeti_growl");
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

wor_give_weapon(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disconnect");
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_3 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_0 takeweapon(var_3);
    if(isDefined(var_0.pap[var_4])) {
      var_0.pap[var_4] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_5 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(var_0 hasweapon("iw7_fists_zm")) {
    var_0 takeweapon("iw7_fists_zm");
  }

  if(scripts\engine\utility::istrue(var_2.standee.upgraded)) {
    switch (var_1) {
      case "iw7_facemelter_zm":
        var_1 = "iw7_facemelter_zm_pap1+fmpap1+camo22";
        break;

      case "iw7_shredder_zm":
        var_1 = "iw7_shredder_zm_pap1+shredderpap1+camo23";
        break;

      case "iw7_headcutter_zm":
        var_1 = "iw7_headcutter_zm_pap1+hcpap1+camo21";
        break;

      case "iw7_dischord_zm":
        var_1 = "iw7_dischord_zm_pap1+dischordpap1+camo20";
        break;
    }
  }

  var_1 = var_0 scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 0);
  if(issubstr(var_1, "emc")) {
    var_0.has_replaced_starting_pistol = 1;
  }

  var_0 notify("wor_item_pickup", var_1);
  var_6 = 1;
  if(isDefined(var_2.clip)) {
    var_6 = 0;
    var_0 setweaponammoclip(var_1, var_2.clip);
  }

  if(isDefined(var_2.stock)) {
    var_6 = 0;
    var_0 setweaponammostock(var_1, var_2.stock);
  }

  var_0 switchtoweapon(var_1);
  if(var_6) {
    var_0 givemaxammo(var_1);
  }

  var_7 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(issubstr(var_1, "dischord")) {
    if(var_0.vo_prefix == "p3_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_dischord(level.wave_num);
  } else if(issubstr(var_1, "facemelter")) {
    if(var_0.vo_prefix == "p2_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_facemelter(level.wave_num);
  } else if(issubstr(var_1, "shredder")) {
    if(var_0.vo_prefix == "p4_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_shredder(level.wave_num);
  } else if(issubstr(var_1, "headcutter")) {
    if(var_0.vo_prefix == "p1_") {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor_fav", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    } else {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("receive_wor", "zmb_comment_vo", "highest", 10, 0, 0, 1);
    }

    scripts\cp\zombies\zombie_analytics::log_crafted_wor_headcutter(level.wave_num);
  }

  var_0 scripts\cp\zombies\achievement::update_achievement("ROCK_ON", 1);
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dj_wor_use_nag");
  var_8 = spawnStruct();
  var_8.lvl = 1;
  var_0.pap[var_5] = var_8;
  var_0 notify("weapon_level_changed");
}

trackplayersworammo(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");
  level endon("gun_replaced " + var_1);
  var_2.stock = var_0 getweaponammostock(var_1);
  var_2.clip = var_0 getweaponammoclip(var_1);
  for(;;) {
    var_0 scripts\engine\utility::waittill_any_3("weapon_fired", "reload");
    if(scripts\engine\utility::istrue(var_0.inlaststand)) {
      continue;
    }

    if(scripts\engine\utility::istrue(level.infinite_ammo)) {
      continue;
    }

    var_3 = var_0 getcurrentweapon();
    var_4 = getweaponbasename(var_3);
    if(var_4 == var_1 || var_4 == var_1 + "_pap1") {
      var_2.stock = var_0 getweaponammostock(var_3);
      var_2.clip = var_0 getweaponammoclip(var_3);
    }
  }
}

watchforplayerdeath(var_0, var_1, var_2) {
  level thread watchforplayerdisconnect(var_0, var_1, var_2);
  level endon("gun_replaced " + var_1);
  level endon("game_ended");
  var_0 endon("disconnect");
  var_3 = getweaponbasename(var_1);
  var_4 = 1;
  for(;;) {
    if(!var_4) {
      break;
    }

    var_5 = undefined;
    var_0 waittill("last_stand");
    var_4 = 0;
    var_6 = var_0 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_6 != "revive") {
      var_5 = var_0 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_5) && var_5 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_7 = var_0 getweaponslistall();
    foreach(var_9 in var_7) {
      var_0A = getweaponbasename(var_9);
      if(var_0A == var_3) {
        var_0 thread watchforweaponremoved(var_0, var_1, var_2);
        var_4 = 1;
        break;
      }
    }
  }

  thread put_gun_back_on_standee(var_2, var_3, undefined, var_0);
  var_0 scripts\cp\utility::updatelaststandpistol();
}

init_standee_interaction() {
  var_0 = scripts\engine\utility::getstructarray("wor_standee", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.target)) {
      var_3 = getscriptablearray(var_2.target, "targetname");
      if(var_3.size > 0) {
        var_2.standee = var_3[0];
        var_2.standee.gun_on_standee = 1;
        var_2 thread init_standee_slots(::part_listener, var_2.standee.script_noteworthy);
      }
    }
  }
}

watchforweaponremoved(var_0, var_1, var_2) {
  level thread watchforplayerdisconnect(var_0, var_1, var_2);
  level endon("gun_replaced " + var_1);
  level endon("game_ended");
  var_0 endon("last_stand");
  var_0 endon("disconnect");
  var_3 = getweaponbasename(var_1);
  var_4 = 1;
  for(;;) {
    if(!var_4) {
      break;
    }

    var_0 scripts\engine\utility::waittill_any_3("weapon_purchased", "mule_munchies_sold");
    var_4 = 0;
    var_5 = var_0 getweaponslistall();
    foreach(var_7 in var_5) {
      var_8 = getweaponbasename(var_7);
      if(issubstr(var_8, var_3)) {
        var_4 = 1;
        break;
      }
    }
  }

  thread put_gun_back_on_standee(var_2, var_3, undefined, var_0);
  var_0 scripts\cp\utility::updatelaststandpistol();
}

watchforplayerdisconnect(var_0, var_1, var_2) {
  level endon("gun_replaced " + var_1);
  var_0 waittill("disconnect");
  thread put_gun_back_on_standee(var_2, var_1, undefined, var_0);
  var_0 scripts\cp\utility::updatelaststandpistol();
}