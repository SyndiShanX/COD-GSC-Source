/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1854.gsc
*************************************************/

_id_C1EF() {
  _id_0737::_id_C266("magicbox", ::_id_64E5, ::_id_0EC0, ::_id_7FE9, undefined, undefined, undefined, undefined, 1, "v_ui_icons_zombies_minimap_mysterybox");
  _id_0737::addinteractionhinttypecallback("magicbox", ::get_magicbox_hint_type);
  level._id_8393["magicbox"]._id_3D91 = 950;
  level._id_8393["magicbox"]._id_3D92 = ::get_magicbox_cost;
}

_id_7FE9(var_0) {
  wait 2;
  level._id_9951 = scripts\engine\utility::array_randomize(var_0);
  level._id_994F = 0;
  level._id_994C = undefined;
  level._id_9950 = 0;
  level._id_994D = 0;
  level._id_994E = [];
  level.b_do_chest_move_devgui = 1;
  level.b_force_chest_to_move = 0;
  level._id_835D["magicbox"] = &"CP_ZMB_INTERACTIONS/ACTIVATE_MAGICBOX";
  level._id_835D["magicbox_need_money"] = &"CP_ZMB_INTERACTIONS/ACTIVATE_MAGICBOX_NEED_MONEY";
  level.magicbox_item_pick_window = 0;

  if(getdvarint("#x3ca096ffd2129faa0", 0) == 1) {
    level._id_835D["magicbox_fire_sale"] = &"CP_ZMB_INTERACTIONS_TUGOLF/ACTIVATE_MAGICBOX_FIRE_SALE";
    level._id_835D["magicbox_fire_sale_need_money"] = &"CP_ZMB_INTERACTIONS_TUGOLF/ACTIVATE_MAGICBOX_FIRE_SALE_NEED_MONEY";
  }

  foreach(var_3, var_2 in level._id_9951) {
    if(!isDefined(level._id_994C) && (!isDefined(var_2._id_CD99) || var_2._id_CD99 != "exclude_start")) {
      level._id_994C = var_2;
    }

    var_2 thread _id_7FE8();
  }

  level thread objective_monitor();
  scripts\engine\utility::_id_5C1B("magic_box_setup_done");
}

_id_7FE8() {
  var_0 = getscriptablearray("magicbox", "targetname");
  self._id_03A9 = scripts\engine\utility::_id_6969(self.origin, var_0);
  self._id_03A9 _meth_8359(1);
  var_1 = getEntArray("magic_box_bunny", "targetname");
  self.bunny = scripts\engine\utility::_id_6969(self._id_03A9.origin, var_1);
  var_2 = scripts\engine\utility::getstructarray("box_fx_spot", "targetname");
  self._id_6076 = scripts\engine\utility::_id_6969(self._id_03A9.origin, var_2);

  if(isDefined(level._id_994C) && level._id_994C == self) {
    _id_520A(self);
    thread _id_0720::init_approach_dialogue(self.origin, "hbx", 1, 6400, 1);
  } else
    _id_4A22(self);
}

get_magicbox_cost(var_0, var_1, var_2) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return 0;
  }

  if(istrue(level.powerup_fire_sale_active)) {
    return 10;
  }

  return 950;
}

get_magicbox_hint_type(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

_id_64E5(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return &"CP_ZMB_INTERACTIONS/DISABLED_BY_FAST_TRAVEL";
  }

  if(var_0._id_03A9 _meth_8575("base") == "hide" || var_0._id_03A9 _meth_8575("base") == "leaving") {
    return "";
  }

  var_2 = var_1 _id_074E::_id_666A();

  if(getdvarint("#x3ca096ffd2129faa0", 0) == 1) {
    if(istrue(level.powerup_fire_sale_active)) {
      if(var_2 > level._id_8393["magicbox"]._id_3D91) {
        return level._id_835D["magicbox_fire_sale"];
      }

      return level._id_835D["magicbox_fire_sale_need_money"];
    }
  }

  if(var_2 > level._id_8393["magicbox"]._id_3D91) {
    return level._id_835D["magicbox"];
  }

  return level._id_835D["magicbox_need_money"];
}

objective_monitor() {
  level endon("game_ended");
  level notify("magic_box_objective_monitor");
  level endon("magic_box_objective_monitor");

  for(;;) {
    level scripts\engine\utility::waittill_any_3("objective_started", "objective_ended", "round_complete");
    refresh_all_magicboxes();
  }
}

refresh_all_magicboxes() {
  foreach(var_2, var_1 in level._id_9951) {
    if(!isDefined(level._id_994C) || level._id_994C == var_1) {
      level thread wait_to_refresh_magicbox(var_1);
    }
  }
}

wait_to_refresh_magicbox(var_0) {
  level endon("game_ended");

  while(istrue(var_0._id_7D7E)) {
    waitframe();
  }

  if(isDefined(var_0)) {
    level thread refresh_preview_items(var_0);
  }
}

disable_current_magicbox() {
  level endon("game_ended");

  if(isDefined(level._id_994C)) {
    _id_4A22(level._id_994C);
    level._id_994C = undefined;
  }
}

_id_4A22(var_0) {
  level endon("game_ended");

  while(istrue(var_0._id_7D7E)) {
    wait 0.05;
  }

  var_0 notify("magicbox_disabled");
  _id_0737::_id_C3C5(var_0);
  clear_preview_items(var_0);
  var_0._id_03A9 setscriptablepartstate("base", "hide");

  if(isDefined(var_0._id_10CF3)) {
    var_0._id_10CF3 delete();
  }

  var_0.bunny show();

  if(var_0._id_03A9 _meth_8575("fx") == "to_hide") {
    wait 0.5;
  }

  var_0._id_03A9 setscriptablepartstate("fx", "off");

  if(isDefined(var_0.markerlabel) && isDefined(var_0.instanceindex)) {
    _id_0987::remove_instanced_objective_marker(var_0.markerlabel, var_0.instanceindex);
    var_0.markerlabel = undefined;
    var_0.instanceindex = undefined;
  }
}

_id_520A(var_0) {
  level endon("game_ended");
  var_0._id_03A9 setscriptablepartstate("base", "arriving");
  var_0._id_03A9 setscriptablepartstate("fx", "hideshow");
  generate_preview_items(var_0);
  wait 2.5;
  var_0.bunny hide();
  wait 2;

  if(isDefined(var_0._id_CD99) && var_0._id_CD99 == "shi_no_numa_special_center_building") {
    var_0._id_03A9 setscriptablepartstate("fx", "normal_bot");
  } else {
    var_0._id_03A9 setscriptablepartstate("fx", "normal");
  }

  _id_0737::_id_1037(var_0);

  if(var_0._id_03A9.classname == "scriptable_s4_zm_magicbox_rbz") {
    var_0._id_03A9 setscriptablepartstate("activation_light", "off");
  }

  if(!isDefined(var_0.instanceindex)) {
    _id_0737::add_interaction_marker_internal(var_0, var_0._id_039B, "v_ui_icons_zombies_minimap_mysterybox");
  }
}

_id_DAB6() {
  if(isDefined(level.b_do_chest_move_devgui) && !level.b_do_chest_move_devgui) {
    return 0;
  }

  if(istrue(level.b_force_chest_to_move)) {
    return 1;
  }

  return level._id_9950 > 4 && level._id_9951.size > 1;
}

_id_A1E5() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::array_randomize(level._id_9951);

  foreach(var_2 in var_0) {
    if(!isDefined(level._id_994C) || var_2 != level._id_994C) {
      disable_current_magicbox();
      playsoundatpos(var_2.origin, "zmb_magic_box_land");
      _id_520A(var_2);
      level._id_994C = var_2;

      if(!scripts\engine\utility::_id_5C00("can_firesale")) {
        scripts\engine\utility::_id_5C1B("can_firesale");
      }

      break;
    }
  }
}

_id_0EC0(var_0, var_1) {
  if(istrue(level._id_0C35) || istrue(var_1._id_2031)) {
    return;
  }
  if(var_0._id_03A9 _meth_8575("base") == "hide" || var_0._id_03A9 _meth_8575("base") == "leaving") {
    return;
  }
  level endon("game_ended");
  var_1 endon("disconnect");
  thread generate_selected_item(var_0, var_1);
  open_magicbox(var_0, var_1);
  wait 0.25;
  preview_items(var_0, var_1);
  level thread wait_to_refresh_preview_item(var_0, 6);

  if(level._id_9951.size > 1) {
    if(_id_DAB6()) {
      level.magicbox_item_pick_window = 4;
      var_0.b_is_leaving = 1;
      var_0.selected_item = spawn_magicbox_item(var_0, "cploot_magicbox_bunny", "magicbox_wait");
    } else
      level.magicbox_item_pick_window = 12;
  } else
    level.magicbox_item_pick_window = 12;

  present_selected_item(var_0, var_1);
  close_magicbox(var_0, var_1);
}

wait_to_refresh_preview_item(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("magicbox_disabled");
  var_0 scripts\engine\utility::_id_108A7(var_1, "close_magicbox");
  refresh_preview_items(var_0);
}

open_magicbox(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);
  var_0.is_previewing = 1;
  var_0._id_7D7E = 1;
  var_0._id_03A9 setscriptablepartstate("base", "opening");
  var_0._id_03A9 setscriptablepartstate("activation_light", "on");

  if(var_0._id_03A9.classname == "scriptable_s4_zm_magicbox_rbz") {
    if(isDefined(var_0._id_CD99) && var_0._id_CD99 == "shi_no_numa_special_center_building") {
      var_0._id_03A9 setscriptablepartstate("fx", "open_bot");
    } else {
      var_0._id_03A9 setscriptablepartstate("fx", "open");
    }
  }

  if(!istrue(level.powerup_fire_sale_active)) {
    level._id_9950++;
  }

  level._id_994D = _id_DAB6();
  waitframe();
  playsoundatpos(var_0.origin, "zmb_magic_box_open");

  if(istrue(getdvarint("#x32499d9dc5db0430e", 0))) {
    playsoundatpos(var_0.origin, "zmb_magic_box_music_h");
  } else {
    playsoundatpos(var_0.origin, "zmb_magic_box_music");
  }

  if(isDefined(var_1)) {
    var_1 playlocalsound("zmb_ui_purchase_accept");
    var_1 _id_0720::_id_BEC0("magic_box", 1);
  }
}

preview_items(var_0, var_1) {
  if(!_func_0107(var_0.preview_items)) {
    generate_preview_items(var_0);
  }

  var_2 = gettime() + scripts\cp\utility::_id_CFF0(4);
  var_3 = undefined;
  var_4 = 0;

  for(;;) {
    if(gettime() >= var_2) {
      break;
    }

    var_3 = var_0.preview_items[var_4];
    var_3 setscriptablepartstate(var_3.type, "preview");
    var_4 = (var_4 + 1) % var_0.preview_items.size;
    wait 0.2;

    if(isDefined(var_3)) {
      var_3 setscriptablepartstate(var_3.type, "hidden");
    }
  }

  var_0.is_previewing = undefined;
}

generate_preview_items(var_0, var_1, var_2) {
  while(istrue(var_0.is_clearing)) {
    wait 0.2;
  }

  var_0.preview_items = scripts\cp\utility::_id_459B(var_0.preview_items, []);
  var_1 = scripts\cp\utility::_id_459B(var_1, 8);
  var_3 = _id_073D::get_loot_table("magicbox");
  var_4 = _id_073D::_id_D040(var_3, undefined, var_1);
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_8, var_6 in var_4) {
    if(var_8 >= var_1) {
      break;
    }

    var_7 = spawn_magicbox_item(var_0, var_6, "hidden");
    var_0.preview_items = scripts\engine\utility::array_add(var_0.preview_items, var_7);

    if(isDefined(var_2)) {
      wait(var_2);
    }
  }

  var_0.preview_items = scripts\engine\utility::array_randomize(var_0.preview_items);
}

clear_preview_items(var_0, var_1, var_2) {
  while(istrue(var_0.is_previewing)) {
    wait 0.2;
  }

  if(_func_0107(var_0.preview_items)) {
    var_0.is_clearing = 1;
    var_1 = scripts\cp\utility::_id_459B(var_1, var_0.preview_items.size);
    var_3 = var_0.preview_items;
    var_4 = [];

    foreach(var_7, var_6 in var_3) {
      if(var_7 >= var_1) {
        break;
      }

      var_0.preview_items = scripts\engine\utility::array_remove(var_0.preview_items, var_6);
      var_4[var_4.size] = var_6;
    }

    var_0.is_clearing = undefined;
    level thread wait_to_delete_removed_items(var_4, var_2);
  }
}

wait_to_delete_removed_items(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_1)) {
    wait(var_1);
  }

  foreach(var_3 in var_0) {
    _id_092E::_id_4744(var_3);
    wait 0.2;
  }
}

refresh_preview_items(var_0) {
  level endon("game_ended");
  var_0 endon("magicbox_disabled");

  if(istrue(var_0.refresh_preview_items_in_progress)) {
    return;
  }
  var_0 notify("refresh_preview_items");
  var_0.refresh_preview_items_in_progress = 1;
  clear_preview_items(var_0, 3, 4);
  waitframe();
  generate_preview_items(var_0, 3, 1);
  var_0.refresh_preview_items_in_progress = undefined;
}

present_selected_item(var_0, var_1) {
  if(!isDefined(var_0.selected_item)) {
    generate_selected_item(var_0, var_1, "magicbox_wait");
  } else {
    if(var_0.selected_item.type == "cploot_weapon_riotshield" || var_0.selected_item.type == "cploot_weapon_wonder_shield") {
      var_0.selected_item setscriptablepartstate(var_0.selected_item.type, "magicbox_visible");
    } else {
      var_0.selected_item setscriptablepartstate(var_0.selected_item.type, "visible");
    }

    if(var_0._id_03A9.classname == "scriptable_s4_zm_magicbox_rbz") {
      if(isDefined(var_0.selected_item) && isDefined(var_0.selected_item.pap_level)) {
        switch (var_0.selected_item.pap_level) {
          case 0:
            break;
          case 1:
            var_0._id_03A9 setscriptablepartstate("activation_light", "pap1_rolled");
            break;
          case 2:
            var_0._id_03A9 setscriptablepartstate("activation_light", "pap2_rolled");
            break;
          case 3:
            var_0._id_03A9 setscriptablepartstate("activation_light", "pap3_rolled");
            break;
        }
      }
    }

    if(isDefined(var_1) && isDefined(var_0.selected_item)) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3) && var_3 != var_1) {
          var_0.selected_item _meth_86A8(var_3);
        }
      }
    }

    wait 0.2;

    if(isDefined(var_0.selected_item)) {
      var_0.selected_item setscriptablepartstate(var_0.selected_item.type, "magicbox_wait");
    }
  }

  if(isDefined(var_0.selected_item)) {
    if(isDefined(var_1)) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3) && var_3 != var_1) {
          var_0.selected_item _meth_86A8(var_3);
        }
      }
    }

    var_7 = var_0.selected_item scripts\engine\utility::_id_108F7("death", level.magicbox_item_pick_window);

    if(isDefined(var_7) && var_7 == "timeout") {
      _id_092E::_id_4744(var_0.selected_item);
    }
  }

  var_0.selected_item = undefined;
}

generate_selected_item(var_0, var_1, var_2) {
  if(!isDefined(var_0.selected_item)) {
    var_3 = _id_073D::get_loot_table("magicbox");
    var_4 = _id_073D::_id_D040(var_3);
    var_5 = scripts\cp\utility::_id_459B(var_2, "hidden");
    var_0.selected_item = spawn_magicbox_item(var_0, var_4[0], var_5, var_1);

    if(isDefined(var_0.selected_item) && isDefined(level.on_magicbox_selected_item)) {
      [[level.on_magicbox_selected_item]](var_0.selected_item);
    }
  } else
    var_0.selected_item.usable_player = var_1;

  if(isDefined(var_1)) {
    var_6 = randomintrange(0, 26);
    [var_8, var_9, var_10] = _id_073D::_id_6531(var_6, var_1.origin, var_1.angles);
    var_0.selected_item._id_C558 = var_8;
  }
}

close_magicbox(var_0, var_1) {
  level endon("game_ended");
  var_0 notify("close_magicbox");
  var_0._id_7D7E = 0;

  if(level._id_994D) {
    level._id_994D = 0;
    level._id_9950 = 0;

    if(isDefined(var_1)) {
      var_2 = level._id_8393["magicbox"]._id_3D91;
      var_1 _id_074E::_id_6F28(var_2, undefined, undefined, 1, "magicboxRefund");
    }

    wait 0.5;
    var_0._id_03A9 setscriptablepartstate("base", "leaving");
    level notify("magic_box_leaving", var_0);

    if(var_0._id_03A9.classname == "scriptable_s4_zm_magicbox_rbz") {
      var_0._id_03A9 setscriptablepartstate("activation_light", "leaving");
      var_0._id_03A9 thread play_magic_box_leaving_fx();
    }

    wait 9;
    var_0.b_is_leaving = 0;
    _id_A1E5();
  } else {
    var_0._id_03A9 setscriptablepartstate("base", "closing");
    var_0._id_03A9 setscriptablepartstate("activation_light", "off");

    if(var_0._id_03A9.classname == "scriptable_s4_zm_magicbox_rbz") {
      if(isDefined(var_0._id_CD99) && var_0._id_CD99 == "shi_no_numa_special_center_building") {
        var_0._id_03A9 setscriptablepartstate("fx", "normal_bot");
      } else {
        var_0._id_03A9 setscriptablepartstate("fx", "normal");
      }
    }
  }

  if(scripts\engine\utility::is_equal(level._id_994C, var_0) || istrue(level.powerup_fire_sale_active)) {
    _id_0737::_id_1037(var_0);
  }
}

play_magic_box_leaving_fx() {
  level endon("game_ended");
  wait 5.5;
  self setscriptablepartstate("fx", "to_hide");
}

spawn_magicbox_item(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = var_0._id_6076.origin;
  var_5 = var_0._id_6076.angles;
  var_6 = undefined;

  if(scripts\cp\cp_killstreaks::is_killstreak_name(var_1)) {
    var_7 = spawnStruct();
    var_7._id_5BD9 = 1;
    var_6 = _id_092E::spawn_killstreak(var_1, var_4, var_5, 0, 0, 1, var_7);
  } else if(_id_0777::_id_8720(var_1)) {
    var_8 = _id_073D::get_pap_from_item_name(var_1);
    var_9 = _id_073D::strip_pap_level_from_item_name(var_1);
    var_10 = scripts\cp\cp_weapon::get_num_random_attachments_by_weapon_level(var_8);
    var_11 = scripts\cp\utility::_id_2D08(var_9, var_10, undefined);
    var_12 = scripts\cp\cp_weapon::_id_663A(var_8 + 1, var_9, "");
    var_13 = scripts\cp\cp_weapon::buildweapon(var_9, var_11, var_12, undefined, undefined, undefined, undefined, undefined, undefined, var_8);

    if(isDefined(var_13)) {
      var_6 = _id_092E::_id_E24D(var_13, var_4, var_5, 0, var_8, 0, 1);
      var_6.current_attachments = var_11;
    } else {}
  } else if(is_bunny_name(var_1)) {
    var_6 = _func_03C5(var_1, var_4, var_5 + (0, 90, 0));
    _id_092E::_id_C216(var_6);

    foreach(var_16 in level.players) {
      var_16 playSound("zmb_magic_box_leave_2d");
    }

    wait 2.5;
  } else
    var_6 = _id_092E::_id_E178(var_1, var_4, var_5, 0, 0);

  if(isDefined(var_6)) {
    var_6.usable_player = var_3;
    var_6.is_magic_box_weapon = 1;
    var_6 setscriptablepartstate(var_6.type, var_2);
  }

  return var_6;
}

is_bunny_name(var_0) {
  if(scripts\engine\utility::is_equal(var_0, "cploot_magicbox_bunny")) {
    return 1;
  } else {
    return 0;
  }
}

firesale_start() {
  if(getdvarint("#x3ca096ffd2129faa0", 0) != 1) {
    return;
  }
  level notify("end_firesale_start");
  level endon("end_firesale_start");

  foreach(var_1 in level._id_9951) {
    if(isDefined(level._id_994C)) {
      if(level._id_994C != var_1) {
        level thread _id_520A(var_1);
      }

      if(level._id_994C == var_1) {
        if(istrue(var_1.b_is_leaving)) {
          var_1.b_set_refresh_thread = 1;
          var_1 thread repopulate_listener();
        }
      }

      continue;
    }

    level thread _id_520A(var_1);
  }

  level.powerup_fire_sale_active = 1;

  if(!isDefined(level._id_8393["magicbox"].n_original_cost)) {
    level._id_8393["magicbox"].n_original_cost = level._id_8393["magicbox"]._id_3D91;
    level._id_8393["magicbox"]._id_3D91 = 10;
  }

  level thread updatemagicboxhint();
  scripts\engine\utility::_id_5C30("powerup_fire_sale_active");

  foreach(var_1 in level._id_9951) {
    if(isDefined(level._id_994C)) {
      if(level._id_994C != var_1) {
        level thread _id_4A22(var_1);
      }

      continue;
    }

    level thread _id_4A22(var_1);
  }

  level.powerup_fire_sale_active = 0;

  if(isDefined(level._id_8393["magicbox"].n_original_cost)) {
    level._id_8393["magicbox"]._id_3D91 = level._id_8393["magicbox"].n_original_cost;
    level._id_8393["magicbox"].n_original_cost = undefined;
  }

  level thread updatemagicboxhint();
}

repopulate_listener() {
  level endon("game_ended");

  while(istrue(self.b_is_leaving)) {
    wait 1;
  }

  if(!scripts\engine\utility::_id_5C00("powerup_fire_sale_active")) {
    self.b_set_refresh_thread = 0;
    return;
  }

  self.b_set_refresh_thread = 0;
  level thread _id_520A(self);
}

updatemagicboxhint() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_8388) || !istrue(var_1._id_8388._id_7D7E)) {
      continue;
    }
    if(!isDefined(var_1._id_8F31) || !isDefined(var_1._id_8F31._id_039B) || var_1._id_8F31._id_039B != "magicbox") {
      continue;
    }
    var_2 = _id_0737::_id_6521(var_1._id_8F31, var_1);

    if(isDefined(var_2)) {
      var_1._id_8388 sethintstring(var_2);
    }
  }
}