/**********************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_skorpion\cp_zm_skorpion_th_quest.gsc
**********************************************************************/

init() {
  setdvarifuninitialized("#x314c1518a4dd0d932", 0);

  if(!getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    return;
  }
  level._effect["fx_dig_dust"] = loadfx("vfx/s4/zombie/vfx_zm_shovel_dig.vfx");
  level._effect["door_locked_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_office_locked");
  level._effect["golden_ball_fx"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_orb_energy_red_ambient");
  level._effect["page_place_slot_fx"] = loadfx("vfx/s4/level/cp_zm_skorpion/vfx_page_place_slot");
  level._effect["evil_curse"] = loadfx("vfx/s4/zombie/vfx_zm_evil_energy_digging");
  level._effect["dig_site_dust_fx"] = loadfx("vfx/s4/zombie/vfx_zm_mosquito");
  level.n_find_lost_pages = 0;
  level.n_find_ray_gun_piece = 0;
  level.n_dig_count = 0;
  level thread init_shovels();
  level thread init_subquest_types(0);
  level thread init_radios();
  level thread init_lock_heart();
  level thread refresh_th_quest_listener();
  register_subquest_funcs("find_common", ::find_common_start, ::find_common_cleanup);
  register_subquest_funcs("find_radio", ::find_radio_start, ::find_radio_cleanup);
  register_subquest_funcs("find_lost_pages", ::find_lost_pages_start, ::find_lost_pages_cleanup);
  register_subquest_funcs("capture_ball", ::capture_golden_ball_start, ::capture_golden_ball_clanup);
  register_subquest_funcs("big_bomb", ::big_bomb_start, ::big_bomb_cleanup);
  register_subquest_funcs("bury_back", ::bury_back_start, ::bury_back_cleanup);
  register_subquest_funcs("find_ray_gun", ::find_ray_gun_start, ::find_ray_gun_cleanup);
}

refresh_th_quest_listener() {
  level endon("end_game");
  level endon("game_ended");

  for(;;) {
    if(scripts\engine\utility::_id_5C00("finish_dig_all_positions") && level._id_11049 > level.n_finish_round + 5 && istrue(level.b_refresh_th_quest)) {
      level waittill("objective_ended");
      level.b_refresh_th_quest = 0;
      level thread init_subquest_types(1);
    }

    wait 1;
  }
}

register_subquest_funcs(var_0, var_1, var_2) {
  scripts\cp\utility::_id_459B(level.th_subquests, []);
  var_3 = spawnStruct();
  var_3._id_E5E6 = var_1;
  var_3.cleanup_func = var_2;
  level.th_subquests[var_0] = var_3;
}

init_subquest_types(var_0) {
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_1 = scripts\engine\utility::getstructarray("s_subquest_pos", "targetname");
  var_1 = scripts\engine\utility::array_randomize(var_1);

  foreach(var_3 in var_1) {
    var_4 = distancesquared(var_3.origin, (-825.156, -1243.3, -364.509));

    if(var_4 < 100) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  level.n_num_of_subquests = 0;

  if(var_0) {
    foreach(var_3 in var_1) {
      if(!istrue(var_3.b_has_quest)) {
        var_3.script_name = "find_common";
        var_3.b_has_quest = 1;

        if(istrue(var_3.b_bury_back_pos)) {
          var_3.b_bury_back_pos = 0;
        }

        var_3.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_3.origin, var_3.angles);
        var_3.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_3.mdl_dust.origin, var_3.mdl_dust.angles);
        playFXOnTag(level._effect["dig_site_dust_fx"], var_3.mdl_dust.fx_proxy, "tag_origin");
        var_3.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
        var_3 registerinteractionforonestruct(::get_soid_hint_func, ::on_soid_interact, undefined, undefined, undefined, undefined, undefined, 64);

        if(!isDefined(level._id_8393["soid_inactive"].hint_type_func)) {
          _id_0737::addinteractionhinttypecallback("soid_inactive", ::soid_hint_type);
        }

        level.n_num_of_subquests++;
      }
    }
  } else {
    if(getdvarint("#x314c1518a4dd0d932", 0) == 1) {
      var_8 = 1;
    } else {
      var_8 = randomintrange(1, 100);
    }

    if(var_8 < 50) {
      level.b_open_ray_gun_quest = 1;
    }

    var_9 = 0;
    var_10 = var_1[var_9];
    var_10.script_name = "find_radio";
    var_10.b_has_quest = 1;
    var_9++;

    for(var_11 = var_9 + 4; var_9 < var_11; var_9++) {
      var_12 = var_1[var_9];
      var_12.script_name = "find_lost_pages";
      var_12.b_has_quest = 1;
    }

    var_13 = var_1[var_9];
    var_13.script_name = "bury_back";
    var_13.b_has_quest = 1;
    var_9++;

    for(var_11 = var_9 + 4; var_9 < var_11; var_9++) {
      var_12 = var_1[var_9];
      var_12.script_name = "capture_ball";
      var_12.b_has_quest = 1;
    }

    for(var_11 = var_9 + 10; var_9 < var_11; var_9++) {
      var_14 = var_1[var_9];
      var_14.script_name = "big_bomb";
      var_14.b_has_quest = 1;
    }

    if(istrue(level.b_open_ray_gun_quest)) {
      for(var_11 = var_9 + 1; var_9 < var_11; var_9++) {
        var_15 = var_1[var_9];
        var_15.script_name = "find_ray_gun";
        var_15.b_has_quest = 1;
      }
    }

    while(var_9 < var_1.size) {
      var_16 = var_1[var_9];
      var_16.script_name = "find_common";
      var_16.b_has_quest = 1;
      var_9++;
    }

    foreach(var_18 in var_1) {
      if(!isDefined(var_18.mdl_dust)) {
        var_18.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_18.origin, var_18.angles);
        var_18.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_18.mdl_dust.origin, var_18.mdl_dust.angles);
        playFXOnTag(level._effect["dig_site_dust_fx"], var_18.mdl_dust.fx_proxy, "tag_origin");
        var_18.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
      }
    }

    level.n_num_of_subquests = var_1.size;
    _id_0737::_id_C266("soid_inactive", ::get_soid_hint_func, ::on_soid_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
    _id_0737::addinteractionhinttypecallback("soid_inactive", ::soid_hint_type);
  }
}

get_soid_hint_func(var_0, var_1) {
  if(!istrue(var_1.b_got_shovel)) {
    return "";
  } else if(istrue(var_0.b_pickup_antenna)) {
    return &"CP_SKORPION/PICKUP_ANTENNA";
  } else if(istrue(var_0.b_pickup_lost_pages)) {
    return &"CP_SKORPION/PICKUP_PAGES";
  } else {
    return &"CP_SKORPION/DIG_SOID";
  }
}

soid_hint_type(var_0, var_1) {
  if(!istrue(var_1.b_got_shovel)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

on_soid_interact(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");

  if(!istrue(var_1.b_got_shovel)) {
    return;
  }
  var_1 playrumbleonentity("damage_heavy");

  if(isDefined(var_0) && isDefined(var_0.mdl_dust) && isDefined(var_0.mdl_dust.fx_proxy)) {
    stopFXOnTag(level._effect["dig_site_dust_fx"], var_0.mdl_dust.fx_proxy, "tag_origin");
    var_0.mdl_dust.fx_proxy stoploopsound("zmb_amb_dig_flies_lp");
  }

  if(!istrue(var_0.b_pickup_antenna) && !istrue(var_0.b_pickup_lost_pages) && !istrue(var_0.b_bury_back_pos)) {
    level.n_dig_count++;
  }

  var_2 = scripts\engine\utility::getstructarray("s_subquest_pos", "targetname");

  if(level.n_dig_count == level.n_num_of_subquests) {
    level scripts\engine\utility::_id_5C1B("finish_dig_all_positions");
    level.n_finish_round = level._id_11049;
    level.n_dig_count = 0;
    level.b_refresh_th_quest = 1;
  }

  if(istrue(var_0.b_pickup_antenna)) {
    var_0.mdl_antenna _meth_86BE();
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_antennae_pickup");
    level thread start_subquest(var_0, var_1);
    _id_0737::_id_C3C5(var_0);
    var_0.b_has_quest = 0;
    var_0.b_pickup_antenna = 0;
    level notify("pickup_antenna");
  } else if(istrue(var_0.b_pickup_lost_pages)) {
    var_0.mdl_page _meth_86BE();
    var_0.fx_proxy delete();
    level.n_find_lost_pages++;

    if(!istrue(level.b_already_start_find_pages_quest)) {
      level thread start_subquest(var_0, var_1);
      level.b_already_start_find_pages_quest = 1;
    }

    _id_0737::_id_C3C5(var_0);
    var_0.b_has_quest = 0;
    var_0.b_pickup_lost_pages = 0;
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_paper_pickup");
  } else {
    if(var_0.script_name == "find_radio") {
      var_0.b_pickup_antenna = 1;
      playFX(level._effect["fx_dig_dust"], var_0.origin + (0, 0, 10), anglesToForward(var_0.angles + (0, 0, 90)), anglestoup(var_0.angles));
      level thread play_script_mover(var_0);
      var_0.mdl_antenna = _func_03C5("cploot_item_antenna", var_0.origin + (0, 0, 10), (0, 0, 0));
      var_0.mdl_antenna setscriptablepartstate("cploot_base", "show");
      scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");
      return;
    }

    if(var_0.script_name == "find_lost_pages") {
      var_0.b_pickup_lost_pages = 1;
      level thread play_script_mover(var_0);
      var_0.mdl_page = _func_03C5("cploot_item_lost_page", var_0.origin + (0, 0, 10), var_0.angles);
      var_0.mdl_page setscriptablepartstate("cploot_base", "show");
      var_0.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
      var_0.fx_page = playFXOnTag(level._effect["forever_blitz_page"], var_0.fx_proxy, "tag_origin");
      scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");
      return;
    }

    playFX(level._effect["fx_dig_dust"], var_0.origin + (0, 0, 5), anglesToForward(var_0.angles + (0, 0, 90)), anglestoup(var_0.angles));
    level thread play_script_mover(var_0);
    _id_0737::_id_C3C5(var_0);
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");

    if(var_0.script_name == "bury_back") {
      wait 1;
    }

    if(isDefined(var_1)) {
      level thread start_subquest(var_0, var_1);
    }

    if(var_0.script_name != "bury_back") {
      var_0.b_has_quest = 0;
    }
  }
}

play_script_mover(var_0) {
  level endon("end_game");
  level endon("game_ended");

  if(isDefined(var_0.mdl_dust)) {
    var_0.mdl_dust moveto(var_0.mdl_dust.origin - (0, 0, 30), 1);
  }

  var_0.mdl_dust waittill("movedone");
  var_0.mdl_dust delete();
}

start_subquest(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");

  if(!isDefined(var_0.script_name)) {
    return;
  }
  [[level.th_subquests[var_0.script_name]._id_E5E6]](var_0, var_1);
  [[level.th_subquests[var_0.script_name].cleanup_func]](var_0, var_1);
}

init_radios() {
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getstruct("th_radio_start", "targetname");
  var_0.mdl = scripts\cp\utility::_id_E190("s4_zm_jpn_radio_equipment_06_dmg", var_0.origin, var_0.angles);
  var_0.spawn_locations = [];
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  var_2 = 1;

  foreach(var_4 in var_1) {
    if(_func_0121(var_4._id_CE18) && var_4._id_CE18 == "prop_antenna") {
      var_0.s_antenna_pos = var_4;
      continue;
    }

    if(_func_0121(var_4._id_CE18) && var_4._id_CE18 == "sub_radio") {
      var_4.script_int = var_2;
      var_4.mdl_radio = scripts\cp\utility::_id_E190("s4_zm_jpn_radio_equipment_06_dmg", var_4.origin, var_4.angles);
      var_4.spawn_locations = [];
      var_5 = scripts\engine\utility::getstructarray(var_4.target, "targetname");

      foreach(var_7 in var_5) {
        if(_func_0121(var_7._id_CE18) && var_7._id_CE18 == "prop_antenna") {
          var_4.mdl_antenna = scripts\cp\utility::_id_E190("s4_zm_radio_antenna", var_7.origin, var_7.angles);
          continue;
        }

        if(_func_0121(var_7._id_039B) && var_7._id_039B == "spawn_location") {
          var_4.spawn_locations = scripts\engine\utility::array_add(var_4.spawn_locations, var_7);
        }
      }

      var_2++;
      continue;
    }

    if(_func_0121(var_4._id_039B) && var_4._id_039B == "spawn_location") {
      var_0.spawn_locations = scripts\engine\utility::array_add(var_0.spawn_locations, var_4);
    }
  }

  var_10 = scripts\engine\utility::getstruct("th_radio_end", "targetname");
  var_10.mdl = scripts\cp\utility::_id_E190("s4_zm_jpn_radio_equipment_06_dmg", var_10.origin, var_10.angles);
  var_10.spawn_locations = [];
  var_11 = scripts\engine\utility::getstructarray(var_10.target, "targetname");

  foreach(var_4 in var_11) {
    if(_func_0121(var_4._id_CE18) && var_4._id_CE18 == "prop_antenna") {
      var_10.mdl_antenna = scripts\cp\utility::_id_E190("s4_zm_radio_antenna", var_4.origin, var_4.angles);
      continue;
    }

    if(_func_0121(var_4._id_039B) && var_4._id_039B == "spawn_location") {
      var_10.spawn_locations = scripts\engine\utility::array_add(var_10.spawn_locations, var_4);
    }
  }
}

init_shovels() {
  if(!getdvarint("#x314c1518a4dd0d932", 0) == 1) {
    level waittill("objective_ended");
  } else {
    scripts\engine\utility::_id_5C24("introscreen_over");
  }

  var_0 = scripts\engine\utility::getstructarray("s_shovel_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = var_0[var_1];
    var_2.mdl_shovel = _func_03C5("cploot_item_shovel", var_2.origin, var_2.angles);
    var_2.mdl_shovel thread outline_distance_check_lisnter();
  }

  _id_0737::_id_C266("shovel_inactive", ::get_shovel_hint_func, ::on_shovel_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("shovel_inactive", ::shovel_hint_type);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.mdl_shovel)) {
      _id_0737::_id_C3C5(var_4);
    }
  }
}

outline_distance_check_lisnter() {
  self endon("death");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      var_3 = distancesquared(self.origin, var_2.origin);

      if(var_3 <= _func_0219(170) && !istrue(var_0)) {
        var_0 = 1;
        break;
      }
    }

    if(istrue(var_0)) {
      self setscriptablepartstate("cploot_base", "show");
    } else {
      self setscriptablepartstate("cploot_base", "hidden");
    }

    wait 1;
  }
}

get_shovel_hint_func(var_0, var_1) {
  if(istrue(var_1.b_got_shovel)) {
    return "";
  } else {
    return &"CP_SKORPION/COLLECT_SHOVEL";
  }
}

shovel_hint_type(var_0, var_1) {
  if(istrue(var_1.b_got_shovel)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

on_shovel_interact(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");

  if(istrue(var_1.b_got_shovel)) {
    return;
  }
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_shovel_pickup");
  var_1.b_got_shovel = 1;

  if(isDefined(var_0.mdl_shovel)) {
    var_0.mdl_shovel notify("death");
    var_0.mdl_shovel _meth_86BE();
  }

  _id_0737::_id_C3C5(var_0);
}

init_lock_heart() {
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getstruct("lost_pages_quest_pos", "targetname");
  var_0.mdl_heart = scripts\cp\utility::_id_E190("vm_fromeo45_00_comp", var_0.origin, var_0.angles);
  var_0.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  playFXOnTag(level._effect["forever_blitz_page"], var_0.fx_proxy, "tag_origin");
  var_1 = scripts\engine\utility::getstruct("lock_door_fx_pos", "targetname");
  var_1.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_1.origin + (0, 0, -35), var_1.angles);
  playFXOnTag(level._effect["door_locked_fx"], var_1.fx_proxy, "tag_origin");
  var_1.fx_proxy playLoopSound("zmb_paperdoor_lp");
  var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");
  var_2.blocker = spawn("script_model", var_2.origin);
  var_2.blocker.angles = var_2.angles;
  var_2.blocker setModel("vfx_zm_obj_holdout_barrier_mod_bottom_center_56x48");
  var_3 = scripts\engine\utility::getfx("objective_barrier");
  var_2.blocker.barrier_fx = playFXOnTag(var_3, var_2.blocker, "tag_origin");
  var_4 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_4.mdl_fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_4.origin + (0, 0, 5), var_4.angles);
  playFXOnTag(level._effect["domination_rune_capturing_1"], var_4.mdl_fx_proxy, "tag_origin");
  var_5 = scripts\engine\utility::getstructarray(var_4.target, "targetname");
  var_5 = scripts\engine\utility::array_randomize(var_5);

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_5[var_6].fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_5[var_6].origin, var_5[var_6].angles);
    playFXOnTag(level._effect["page_place_slot_fx"], var_5[var_6].fx_proxy, "tag_origin");
    var_5[var_6].script_int = var_6;
  }
}

find_common_start(var_0, var_1) {
  var_2 = get_random_drop_rarity();
  var_3 = _func_02AB(var_0.origin);
  _id_4FF0(var_2, var_3, var_0.angles);
}

get_random_drop_rarity() {
  var_0 = randomintrange(1, 4);

  if(isDefined("zm_loot_crystal_level_" + var_0)) {
    return "zm_loot_crystal_level_" + var_0;
  }
}

_id_4FF0(var_0, var_1, var_2, var_3) {
  var_4 = get_loot_table(var_0);

  if(!isDefined(var_4)) {
    return undefined;
  }

  _id_073D::select_and_spawn_items_from_table(var_4, var_1, var_2, var_3, var_0);
}

get_loot_table(var_0) {
  var_1 = level._id_9860[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1;
}

find_common_cleanup(var_0, var_1) {}

find_radio_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  level waittill("pickup_antenna");
  _id_0737::_id_C266("th_radio_start", ::get_radio_hint_func, ::on_radio_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("th_radio_start", ::get_radio_type);
  level waittill("th_radio_start_used");
  _id_0737::_id_C266("th_radio", ::get_sub_radio_hint_func, ::on_sub_radio_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("th_radio", ::get_radio_type);
  level scripts\engine\utility::_id_5C26(["th_radio_used_1", "th_radio_used_2"]);
  _id_0737::_id_C266("th_radio_end", ::get_sub_radio_hint_func, ::on_end_radio_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("th_radio_end", ::get_radio_type);
  level scripts\engine\utility::_id_5C27("finish_find_radio_quest", "objective_locked");
}

get_sub_radio_hint_func(var_0, var_1) {
  return &"CP_SKORPION/ADJUST_ANTENNA";
}

get_radio_hint_func(var_0, var_1) {
  return &"CP_SKORPION/PUT_ON_ANTENNA";
}

get_radio_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_radio_interact(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  var_0.mdl_antenna = scripts\cp\utility::_id_E190("s4_zm_radio_antenna", var_0.s_antenna_pos.origin, var_0.s_antenna_pos.angles);
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_antennae_place");
  level thread spawn_zombies_around(var_0, "enemy_zombie_screamer_cp", var_1);
  level notify("th_radio_start_used");
  waitframe();
  _id_0737::_id_C3C5(var_0);
}

spawn_zombies_around(var_0, var_1, var_2) {
  level endon("end_game");
  level endon("game_ended");

  if(!isDefined(var_0.spawn_locations)) {
    return;
  }
  var_3 = 0;

  switch (var_1) {
    case "enemy_zombie_screamer_cp":
      var_3 = get_number_of_spawn_screamers();
      break;
    case "enemy_zombie_juggernaut_cp":
      var_3 = get_number_of_spawn_jurggernaut();
      break;
  }

  var_0.spawned_ais = [];
  var_4 = 0;

  while(var_4 < var_3) {
    var_5 = scripts\engine\utility::random(var_0.spawn_locations);
    var_6 = _id_09A4::_id_110AD(var_1, var_5.origin, var_5.angles, var_5);

    if(isDefined(var_6)) {
      if(isalive(var_2)) {
        var_6._id_01BD = var_2;
      }

      var_0.spawned_ais = scripts\engine\utility::array_add(var_0.spawned_ais, var_6);
      var_7 = randomintrange(1, 3);
      var_4++;
      wait(var_7);
      continue;
    }

    wait 1;
  }
}

get_number_of_spawn_screamers() {
  var_0 = 0;

  switch (level.players.size) {
    case 1:
      var_0 = 6;
      break;
    case 2:
      var_0 = 12;
      break;
    case 3:
      var_0 = 18;
      break;
    case 4:
      var_0 = 24;
      break;
  }

  return var_0;
}

get_number_of_spawn_jurggernaut() {
  var_0 = 0;

  switch (level.players.size) {
    case 1:
      var_0 = 4;
      break;
    case 2:
      var_0 = 8;
      break;
    case 3:
      var_0 = 12;
      break;
    case 4:
      var_0 = 18;
      break;
  }

  return var_0;
}

on_sub_radio_interact(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);

  if(isDefined(var_0.mdl_antenna)) {
    var_2 = randomintrange(45, 135);
    var_0.mdl_antenna rotateto(var_0.mdl_antenna.angles + (0, var_2, 0), 3);
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_antennae_rotate");
    var_0.mdl_antenna waittill("rotatedone");
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_tuning_success");
  }

  if(isDefined(var_1)) {
    level thread spawn_zombies_around(var_0, "enemy_zombie_screamer_cp", var_1);
  }

  if(isDefined(var_0.script_int)) {
    scripts\engine\utility::_id_5C1B("th_radio_used_" + var_0.script_int);
  }
}

on_end_radio_interact(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);

  if(isDefined(var_0.mdl_antenna)) {
    var_2 = randomintrange(45, 135);
    var_0.mdl_antenna rotateto(var_0.mdl_antenna.angles + (0, var_2, 0), 3);
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_antennae_rotate");
    var_0.mdl_antenna waittill("rotatedone");
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_tuning_success");
  }

  if(isDefined(var_1)) {
    level thread spawn_zombies_around(var_0, "enemy_zombie_juggernaut_cp", var_1);
  }

  var_0 thread spawned_zombies_all_dead_listener();
}

spawned_zombies_all_dead_listener() {
  level endon("end_game");
  level endon("game_ended");
  level endon("objective_locked");

  for(;;) {
    if(_func_0107(self.spawned_ais)) {
      foreach(var_1 in self.spawned_ais) {
        if(var_1.health == 0) {
          if(self.spawned_ais.size == 1) {
            level thread spawn_golden_chest(var_1.origin, var_1.angles);
          }

          self.spawned_ais = scripts\engine\utility::array_remove(self.spawned_ais, var_1);
        }
      }

      if(self.spawned_ais.size == 0) {
        level scripts\engine\utility::_id_5C1B("finish_find_radio_quest");
        return;
      }
    }

    wait 1;
  }
}

spawn_golden_chest(var_0, var_1) {
  var_2 = var_0 + (0, 0, 32);
  var_3 = var_0 - (0, 0, 32);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
  var_5 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, var_4);

  if(var_5["fraction"] < 1.0) {
    var_6 = var_5["position"];
  } else {
    var_6 = var_3;
  }

  var_7 = _func_03C5("s4_zm_loot_chest", var_6 - (0, 0, 2), var_1);
  var_7 setscriptablepartstate("zm_loot_chest", "closed");
  var_7 setscriptablepartstate("fx", "closed");
  var_7.objectiveiconlocation = spawn("script_model", var_7.origin);
  var_7.objectiveiconparams = spawnStruct();
  var_7.objectiveiconparams._id_E747 = "active";
  var_7.objectiveiconparams._id_96CF = var_7.objectiveiconlocation;
  var_7.objectiveiconparams._id_7C3B = "v_ui_icons_zombies_minimap_chest";
  var_7.objectiveiconparams.minimapiconsize = "icon_regular";
  var_7.objectiveiconparams.hideonminimapwhenclipped = 1;
  var_7.objectiveiconparams.setbackground = 5;
  var_7.markerlabel = "chest_poi";
  var_7.instanceindex = _id_0987::add_instanced_objective_marker(var_7.markerlabel, var_7.objectiveiconparams);
  var_7 thread chest_life_watcher();
}

chest_life_watcher() {
  level endon("end_game");
  level endon("game_ended");
  self endon("death");
  level waittill("players_landed");
  self _meth_86BE();
}

find_radio_cleanup(var_0, var_1) {}

find_lost_pages_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  _id_0737::_id_C266("place_page_inactive", ::get_page_placed_hint_func, ::on_page_placed_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 80);
  _id_0737::addinteractionhinttypecallback("place_page_inactive", ::page_placed_hint_type);
  var_2 = scripts\engine\utility::getstructarray("place_page_inactive", "script_noteworthy");
  var_3 = scripts\engine\utility::getstruct("lock_door_fx_pos", "targetname");

  foreach(var_5 in var_2) {
    var_5 thread face_to_interact_check();
  }

  var_7 = 0;

  for(;;) {
    level waittill("place_on_page");
    level.n_find_lost_pages--;

    if(isDefined(level.n_placed_page_index) && var_7 == level.n_placed_page_index) {
      var_7++;
    } else {
      level.b_disable_place_page_trigger = 1;
      wait 2;
      scripts\cp\utility::_id_B8ED(var_3.origin, "zmb_paperdoor_fail");
      var_8 = scripts\engine\utility::getstructarray("place_page_inactive", "script_noteworthy");

      foreach(var_10 in var_8) {
        if(isDefined(var_10.mdl_page) && isent(var_10.mdl_page)) {
          var_10.mdl_page delete();
          var_10.b_placed_page = 0;
        }
      }

      level.n_find_lost_pages = level.n_find_lost_pages + var_7 + 1;
      var_7 = 0;
      level.n_placed_page_index = undefined;
      level.b_disable_place_page_trigger = 0;
    }

    if(var_7 == 4) {
      break;
    }
  }

  _id_0737::_id_C4AB("place_page_inactive");
  wait 2;
  scripts\cp\utility::_id_B8ED(var_3.origin, "zmb_paperdoor_end");
  var_12 = scripts\engine\utility::getstruct("lost_pages_quest_pos", "targetname");
  var_13 = scripts\engine\utility::getstruct(var_12.target, "targetname");

  if(isDefined(var_13.mdl_fx_proxy)) {
    stopFXOnTag(level._effect["domination_rune_capturing_1"], var_13.mdl_fx_proxy, "tag_origin");
    playFXOnTag(level._effect["domination_rune_idle"], var_13.mdl_fx_proxy, "tag_origin");
  }

  var_3 = scripts\engine\utility::getstruct("lock_door_fx_pos", "targetname");

  if(isDefined(var_3.fx_proxy)) {
    var_3.fx_proxy stoploopsound("zmb_paperdoor_lp");
    var_3.fx_proxy delete();
  }

  var_14 = scripts\engine\utility::getstruct(var_3.target, "targetname");

  if(isDefined(var_14.blocker)) {
    var_14.blocker delete();
  }

  var_15 = getent("lock_door_bullet_clip", "targetname");
  var_15 delete();
  var_12 = scripts\engine\utility::getstruct("lost_pages_quest_pos", "targetname");
  var_13 = scripts\engine\utility::getstruct(var_12.target, "targetname");
  var_16 = scripts\engine\utility::getstructarray(var_13.target, "targetname");

  for(var_17 = 0; var_17 < var_16.size; var_17++) {
    if(isDefined(var_16[var_17].fx_proxy)) {
      var_16[var_17].fx_proxy delete();
    }

    if(isDefined(var_16[var_17].mdl_page)) {
      var_16[var_17].mdl_page delete();
    }
  }

  _id_0737::_id_C266("heart_inactive", ::get_collect_heat_hint_func, ::on_collect_heat_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("heart_inactive", ::page_collect_heat_type);
  level scripts\engine\utility::_id_5C24("collect_heart");
  [[level.th_subquests["find_lost_pages"].cleanup_func]](var_0, var_1);
}

face_to_interact_check() {
  level endon("end_game");
  level endon("game_ended");
  level endon("collect_heart");

  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = vectortoangles(self.origin - var_1 getEye());
      var_2 = anglesToForward(var_2);

      if(isDefined(var_2)) {
        var_3 = var_1 getplayerangles();
        var_3 = anglesToForward(var_3);
        var_4 = length(var_3 - var_2);

        if(var_4 <= 0.1) {
          if(scripts\engine\utility::array_contains(var_1._id_4A8B, self)) {
            var_1._id_4A8B = scripts\engine\utility::array_remove(var_1._id_4A8B, self);
          }
        } else if(!scripts\engine\utility::array_contains(var_1._id_4A8B, self))
          var_1._id_4A8B = scripts\engine\utility::array_add(var_1._id_4A8B, self);
      }
    }

    wait 1;
  }
}

get_collect_heat_hint_func(var_0, var_1) {
  return &"CP_SKORPION/COLLECT_HEART";
}

page_collect_heat_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_collect_heat_interact(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  level scripts\engine\utility::_id_5C1B("collect_heart");
  var_0.mdl_heart delete();

  if(scripts\engine\utility::_id_5C00("found_ray_gun")) {
    var_2 = 0;

    if(_func_0107(var_1.weaponlist)) {
      foreach(var_4 in var_1.weaponlist) {
        var_5 = getweaponbasename(var_4);

        if(var_5 == "s4_pi_raygun_mp") {
          var_2 = 1;
          break;
        }
      }
    }

    if(var_2) {
      var_1 _id_074E::_id_6F28(15000, "large", undefined, 1, "bonus");
    } else {
      var_7 = spawnStruct();
      var_7.player = var_1;
      var_7.origin = var_0.origin;
      var_7.triggeringweapon = "s4_pi_raygun_mp";
      _id_0932::drop_relevant_weapon(var_7);
      var_4 = scripts\cp\cp_weapon::buildweapon("s4_pi_raygun_mp");
      var_1 giveweapon(var_4);
      var_1 switchtoweapon(var_4);
    }
  }

  var_8 = _func_02A9(var_0.origin, 50);
  var_7 = spawnStruct();
  var_7._id_5BD9 = 1;
  _id_092E::spawn_killstreak("lmg_streak", var_8, (0, 0, 0), 0, undefined, undefined, var_7) _id_0737::_id_C3C5(var_0);
}

get_page_placed_hint_func(var_0, var_1) {
  if(!istrue(var_0.b_placed_page) && level.n_find_lost_pages != 0 && !istrue(level.b_disable_place_page_trigger)) {
    return &"CP_SKORPION/PLACE_PAGE";
  } else {
    return &"";
  }
}

page_placed_hint_type(var_0, var_1) {
  if(!istrue(var_0.b_placed_page) && level.n_find_lost_pages != 0 && !istrue(level.b_disable_place_page_trigger)) {
    return "HINT_NOICON";
  } else {
    return "HINT_NOBUTTON";
  }
}

on_page_placed_interact(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");

  if(!istrue(var_0.b_placed_page) && level.n_find_lost_pages != 0 && !istrue(level.b_disable_place_page_trigger)) {
    var_0.mdl_page = scripts\cp\utility::_id_E190("s4_zm_ritual_tome_single_page", var_0.origin, var_0.angles);
    var_0.b_placed_page = 1;

    if(isDefined(var_0.script_int)) {
      level.n_placed_page_index = var_0.script_int;
      level notify("place_on_page");
    }

    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_paperdoor_place");
  }
}

find_lost_pages_cleanup(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct("lost_pages_quest_pos", "targetname");

  if(isDefined(var_2.fx_proxy)) {
    var_2.fx_proxy delete();
  }

  var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");

  if(isDefined(var_3.mdl_fx_proxy)) {
    var_3.mdl_fx_proxy delete();
  }

  if(_func_0107(var_2.a_mdl_ray_gun)) {
    foreach(var_5 in var_2.a_mdl_ray_gun) {
      if(isDefined(var_5.fx_proxy)) {
        var_5.fx_proxy delete();
      }

      if(isDefined(var_5)) {
        var_5 stoploopsound("zmb_tor_page_lp");
        var_5 delete();
      }
    }
  }
}

capture_golden_ball_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  var_0.golden_ball = scripts\cp\utility::_id_E190("s4_zm_golden_ball", var_0.origin, var_0.angles);
  var_0.golden_ball._id_039B = "golden_ball_inactive";
  var_0.golden_ball.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin + (0, 0, 5), var_0.angles);
  var_0.golden_ball.fx_proxy linkto(var_0.golden_ball);
  playFXOnTag(level._effect["golden_ball_fx"], var_0.golden_ball.fx_proxy, "tag_origin");
  var_0.golden_ball playLoopSound("zmb_orb_lp_close");
  var_2 = pickup_free_damage_proxy();
  var_2.origin = var_0.golden_ball.origin;
  var_2.parent = var_0.golden_ball;
  var_0.golden_ball.damage_proxy = var_2;
  var_2 thread sync_position(var_0.golden_ball);
  var_2 thread golden_ball_damage_listener();
  var_2.b_busy = 1;
  var_0.golden_ball thread start_moving();
  var_0.golden_ball waittill("captured_golden_ball");
  var_2.b_busy = 0;
  level thread spawn_bonus_rewards(var_0.golden_ball.origin);
  level._id_417B = scripts\engine\utility::_id_1BD1(level._id_417B, 1);
  wait 3;
  var_0.golden_ball stoploopsound("zmb_orb_lp_close");
  var_0.golden_ball.fx_proxy delete();
  var_0.golden_ball delete();
}

spawn_bonus_rewards(var_0) {
  var_1 = 0;

  while(var_1 < 10) {
    var_2 = _func_02A9(var_0 + (0, 0, -10), 70);

    if(isDefined(var_2)) {
      var_3 = _id_0990::_id_E3DD("bonus_points_team", var_2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
      var_1++;
    }

    waitframe();
  }
}

pickup_free_damage_proxy() {
  var_0 = getEntArray("golden_ball_damage_proxy", "targetname");

  foreach(var_2 in var_0) {
    if(!istrue(var_2.b_busy)) {
      return var_2;
    }
  }
}

sync_position(var_0) {
  level endon("end_game");
  level endon("game_ended");
  level endon("captured_golden_ball");

  while(isDefined(var_0)) {
    self.origin = var_0.origin;
    waitframe();
  }
}

golden_ball_damage_listener() {
  level endon("end_game");
  level endon("game_ended");
  var_0 = get_health_scale();
  var_1 = 1000 * var_0;

  while(var_1 > 0) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(isPlayer(var_3)) {
      if(!istrue(self.parent.b_finish_moving)) {
        var_2 = 0;
      }

      if(isDefined(var_11) && istrue(self.parent.b_finish_moving)) {
        var_12 = scripts\cp\utility::_id_6902(var_11);

        if(var_12 == "s4_pi_raygun_mp") {
          var_13 = var_3 scripts\cp\cp_weapon::_id_683D(var_11);

          switch (var_13) {
            case 1:
              var_2 = 240;
              break;
            case 2:
              var_2 = 480;
              break;
            case 3:
              var_2 = 480;
              break;
            case 4:
              var_2 = 480;
              break;
            default:
              var_2 = 240;
              break;
          }
        }
      }

      level thread _id_072E::display_damage_number_internal(var_3, 0, var_2, self.origin);
      self.parent playSound("zmb_orb_impact");
      var_1 = var_1 - var_2;
    }
  }

  self.parent playSound("zmb_orb_lower");
  self.parent thread start_stun_down();
}

get_health_scale() {
  var_0 = level.players.size;

  switch (var_0) {
    case 1:
      return 1;
    case 2:
      return 1.5;
    case 3:
      return 2;
    case 4:
      return 2.5;
  }
}

start_moving() {
  level endon("end_game");
  level endon("game_ended");
  level endon("golden_ball_stun_down");
  self moveto(self.origin + (0, 0, 30), 3);

  if(isDefined(self.target_area)) {
    self.target_area.b_used = 0;
    self.target_area = undefined;
  }

  self waittill("movedone");
  self playSound("zmb_orb_flyaway");
  var_0 = scripts\engine\utility::getstructarray("golden_ball_start_point", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(!istrue(var_3.b_used)) {
      var_1 = var_3;
      var_3.b_used = 1;
      self.target_area = var_3;
      break;
    }
  }

  for(;;) {
    var_5 = pick_next_fly_point(var_1);
    var_6 = distance(var_5.origin, self.origin) / 300;

    if(var_6 < 1) {
      var_6 = 1;
    }

    self moveto(var_5.origin, var_6);
    self waittill("movedone");
    self.b_finish_moving = 1;
    start_point_stop();
    waitframe();
  }
}

start_point_stop() {
  level endon("end_game");
  level endon("game_ended");
  level endon("golden_ball_stun_down");
  wait 1;
  var_0 = 10;
  var_1 = scripts\cp\utility::_id_A2B8(gettime());
  var_2 = self.origin;
  var_3 = 0;

  while(var_3 < 10) {
    var_3 = gettime() / 1000 - var_1;
    var_4 = scripts\engine\utility::_id_C019(1);
    var_5 = var_4 * 100;
    self moveto(var_2 + var_5, 3);
    self waittill("movedone");
  }
}

start_stun_down() {
  level endon("end_game");
  level endon("game_ended");
  self endon("death");
  level notify("golden_ball_stun_down");
  var_0 = self.origin;
  var_1 = self.origin - (0, 0, 1000);
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);
  var_3 = scripts\engine\trace::ray_trace(var_0, var_1, self, var_2);

  if(var_3["fraction"] < 1.0) {
    var_4 = var_3["position"];
  } else {
    var_4 = var_1;
  }

  if(!isvector(var_4)) {
    var_4 = self.origin;
  }

  self moveto(var_4 + (0, 0, 30), 3);
  self waittill("movedone");
  _id_C266("golden_ball_inactive", ::get_golden_ball_hint_func, ::on_golden_ball_interact, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("golden_ball_inactive", ::golden_ball_type);
  thread stun_down_timer();
}

stun_down_timer() {
  level endon("end_game");
  level endon("game_ended");
  self endon("captured_golden_ball");
  wait 5;

  if(isDefined(self)) {
    _id_0737::_id_C3C5(self);
    thread start_moving();

    if(isDefined(self.damage_proxy)) {
      self.damage_proxy thread golden_ball_damage_listener();
    }
  }
}

get_golden_ball_hint_func(var_0, var_1) {
  return &"CP_SKORPION/CAPTURE_BALL";
}

golden_ball_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_golden_ball_interact(var_0, var_1) {
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_orb_capture");
  _id_0737::_id_C3C5(var_0);
  var_0 notify("captured_golden_ball");
}

_id_C266(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  scripts\cp\utility::_id_459B(var_5, "duration_short");
  var_13 = spawnStruct();
  var_13._id_039B = var_0;
  var_13._id_7965 = var_1;
  var_13._id_E3FF = var_9;
  var_13._id_F8A0 = var_10;
  var_13._id_0F07 = var_2;
  var_13._id_523F = 1;
  var_13._id_4A9D = 1;
  var_13._id_3D91 = 0;
  var_13._id_C588 = var_11;
  var_13._id_7F8B = var_3;
  var_13._id_3108 = undefined;
  var_13._id_A53D = var_4;
  var_13._id_FE5D = var_5;
  var_13._id_8656 = var_6;
  var_13._id_796E = var_7;
  var_13.hinttype = undefined;
  var_13.hint_type_func = undefined;
  level._id_8393[var_0] = var_13;
  var_14 = getEntArray(var_0, "script_noteworthy");
  _id_0FE3(var_14);
}

registerinteractionforonestruct(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  scripts\cp\utility::_id_459B(var_4, "duration_short");
  var_12 = spawnStruct();
  var_12._id_039B = self._id_039B;
  var_12._id_7965 = var_0;
  var_12._id_E3FF = var_8;
  var_12._id_F8A0 = var_9;
  var_12._id_0F07 = var_1;
  var_12._id_523F = 1;
  var_12._id_4A9D = 1;
  var_12._id_3D91 = 0;
  var_12._id_C588 = var_10;
  var_12._id_7F8B = var_2;
  var_12._id_3108 = undefined;
  var_12._id_A53D = var_3;
  var_12._id_FE5D = var_4;
  var_12._id_8656 = var_5;
  var_12._id_796E = var_6;
  var_12.hinttype = undefined;
  var_12.hint_type_func = undefined;
  level._id_8393[self._id_039B] = var_12;
  var_13 = [];
  var_13 = scripts\cp\utility::_id_1B8C(var_13, self);
  _id_0FE3(var_13);
}

_id_0FE3(var_0) {
  level._id_417B = scripts\engine\utility::array_combine(level._id_417B, var_0);
  level._id_417B = scripts\engine\utility::_id_1BC1(level._id_417B);
}

pick_next_fly_point(var_0) {
  level endon("end_game");
  level endon("game_ended");
  var_1 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  var_2 = 0;

  for(;;) {
    var_3 = scripts\engine\utility::random(var_1);
    var_4 = _func_0204(level.players, var_3.origin);

    if(distancesquared(var_3.origin, var_4[0].origin) > _func_0219(300)) {
      return var_3;
    }

    if(var_2 > 20) {
      return var_3;
    }

    var_2++;
    waitframe();
  }
}

capture_golden_ball_clanup(var_0, var_1) {}

big_bomb_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  var_2 = var_0.origin + (0, 0, 50);
  var_3 = var_0.origin - (0, 0, 100);
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0, 0, 1);

  if(isDefined(var_0.mdl_dust)) {
    var_5 = scripts\engine\trace::ray_trace(var_2, var_3, var_0.mdl_dust, var_4);
  } else {
    var_5 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, var_4);
  }

  if(var_5["fraction"] < 1.0) {
    var_6 = var_5["position"];
  } else {
    var_6 = var_3 + (0, 0, -5);
  }

  if(!isDefined(var_6)) {
    var_6 = _func_02AB(var_0.origin);
  }

  var_7 = magicgrenademanual("s4_monkey_bomb_zm", var_6, (0, 0, 0));
  var_7 hide();
  var_7.angles = var_0.angles;
  var_7._id_A15E = spawn("script_model", var_7.origin);
  var_7._id_A15E.angles = var_7.angles;
  var_7._id_A15E setModel("wpn_s4_zm_monkey_bomb_main_world");
  var_7._id_A15E._id_0203 = var_7;
  var_7._id_A15E linkto(var_7);
  var_7._id_A15E.originating_player = var_1;
  var_7._id_10D0B = spawnStruct();
  var_7._id_10D0B._id_014B = 400;
  var_7._id_A15E._id_39E4 = _func_02AB(var_7._id_A15E.origin, var_7);
  level._id_0F23 = scripts\engine\utility::array_add(level._id_0F23, var_7._id_A15E);

  while(isDefined(var_7)) {
    waitframe();
  }

  var_8 = magicgrenademanual("s4_monkey_bomb_zm", var_6, (0, 0, 0));
  var_8 hide();
  var_8 detonate();
  var_9 = _func_0071(var_6, 400, level._id_11056);

  foreach(var_11 in var_9) {
    if(isalive(var_11)) {
      var_11 dodamage(var_11.maxhealth, var_11.origin, var_1, undefined, "MOD_EXPLOSIVE", "s4_monkey_bomb_zm");
    }
  }

  for(var_13 = 0; var_13 < 5; var_13++) {
    var_14 = randomintrange(1, 359);
    var_15 = _func_02A9(var_0.origin, 50);
    _id_092E::_id_E178("cploot_salvage", var_15, (0, var_14, 0));
  }
}

big_bomb_cleanup(var_0, var_1) {}

bury_back_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  var_0.mdl_heart = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  var_0.fx_float = playFXOnTag(level._effect["evil_curse"], var_0.mdl_heart, "tag_origin");
  var_0.mdl_heart moveto(var_0.mdl_heart.origin + (0, 0, 30), 3);
  var_0.mdl_heart playSound("zmb_debuff_spawn");
  var_0.mdl_heart waittill("movedone");
  var_0.mdl_heart moveto(var_1.origin, 1);
  var_0.mdl_heart waittill("movedone");
  var_0.mdl_heart delete();

  if(isDefined(var_1)) {
    var_1 thread player_play_curse_fxs_listener();
    var_1.b_got_curse = 1;
  }

  var_0.free_positions = var_0 get_free_bury_position();

  if(_func_0107(var_0.free_positions) && var_0.free_positions.size != 0) {
    foreach(var_3 in var_0.free_positions) {
      var_3.b_has_quest = 1;
      var_3 thread init_bury_inactive();
    }
  }

  level waittill("end_bury_heart", var_5);

  if(istrue(var_5) && isDefined(var_1) && !istrue(level.b_finish_bury_back_quest)) {
    var_1 scripts\cp\cp_sacrificial_heart::giveplayersacrificialheart();
    level.b_finish_bury_back_quest = 1;
  }

  if(isDefined(var_1)) {
    var_1 stoploopsound("zmb_debuffed_lp");
  }
}

player_play_curse_fxs_listener() {
  level endon("end_game");
  level endon("game_ended");
  level endon("end_bury_heart");
  self playSound("zmb_debuffed_start");
  self playLoopSound("zmb_debuffed_lp");

  while(isalive(self)) {
    self playSound("zmb_debuffed_start");
    playFXOnTag(level._effect["domination_rune_capturing_1"], self, "tag_origin");
    var_0 = _func_0071(self.origin, 400, level._id_11056);

    foreach(var_2 in var_0) {
      var_2._id_01BD = self;
    }

    self.maxhealth = int(self._id_AFAA["max_health"] / 2);
    wait 3;

    if(isalive(self) && isDefined(self)) {
      stopFXOnTag(level._effect["domination_rune_capturing_1"], self, "tag_origin");
    } else {
      break;
    }

    wait 45;
  }

  if(isDefined(self)) {
    self.b_got_curse = 0;
  }

  var_4 = 0;
  level notify("end_bury_heart", var_4);
}

get_free_bury_position() {
  level endon("end_game");
  level endon("game_ended");
  var_0 = scripts\engine\utility::getstructarray("s_subquest_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = [];
  var_2 = 0;

  while(var_2 < 3) {
    foreach(var_4 in var_0) {
      if(!istrue(var_4.b_has_quest) && var_4 != self) {
        var_1 = scripts\cp\utility::_id_1B8C(var_1, var_4);
        var_2++;

        if(var_2 > 2) {
          break;
        }
      }
    }

    wait 10;
  }

  return var_1;
}

init_bury_inactive() {
  self.trigger_proxy = scripts\cp\utility::_id_E190("tag_origin", self.origin + (0, 0, 5), self.angles);
  self.trigger_proxy._id_039B = "bury_heart_inactive";
  self.trigger_proxy.parent = self;
  playFXOnTag(level._effect["domination_rune_idle"], self.trigger_proxy, "tag_origin");
  self.trigger_proxy playLoopSound("zmb_debuffed_barrier_lp");
  _id_C266("bury_heart_inactive", ::get_bury_heart_hint_func, ::on_bury_heart_interact, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("bury_heart_inactive", ::bury_heart_type);
}

get_bury_heart_hint_func(var_0, var_1) {
  if(!istrue(var_1.b_got_curse)) {
    return "";
  } else {
    return &"CP_SKORPION/BURY_HEART";
  }
}

bury_heart_type(var_0, var_1) {
  if(!istrue(var_1.b_got_curse)) {
    return "HINT_NOBUTTON";
  } else {
    return "HINT_NOICON";
  }
}

on_bury_heart_interact(var_0, var_1) {
  if(!istrue(var_1.b_got_curse)) {
    return;
  }
  var_2 = 1;
  var_0.parent.b_bury_back_pos = 1;
  var_1.b_got_curse = 0;
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");
  _id_0737::_id_C3C5(var_0);
  wait 1;
  level thread play_bury_heart_back_anim(var_0);

  if(isDefined(var_1)) {
    var_1 playSound("zmb_debuff_bury");
  }

  level notify("end_bury_heart", var_2);

  if(isDefined(var_1)) {
    var_1.maxhealth = var_1._id_AFAA["max_health"];
    var_1.health = var_1.maxhealth;
  }
}

play_bury_heart_back_anim(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0.mdl_heart)) {
    var_0.mdl_heart = scripts\cp\utility::_id_E190("tag_origin", var_0.origin + (0, 0, 20), var_0.angles);
    playFXOnTag(level._effect["evil_curse"], var_0.mdl_heart, "tag_origin");
    var_0.mdl_heart moveto(var_0.origin + (0, 0, -15), 3);
    var_0.mdl_heart waittill("movedone");
    var_0.mdl_heart delete();
  }

  if(!isDefined(var_0.mdl_dust)) {
    var_0.parent.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_0.parent.origin - (0, 0, 20), var_0.parent.angles);
    var_0.parent.mdl_dust moveto(var_0.origin + (0, 0, -5), 3);
    var_0.parent.mdl_dust waittill("movedone");
    var_0.parent.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.parent.mdl_dust.origin, var_0.parent.mdl_dust.angles);
    playFXOnTag(level._effect["dig_site_dust_fx"], var_0.parent.mdl_dust.fx_proxy, "tag_origin");
    var_0.parent.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
  }

  level notify("finish_play_bury_back_anim");
}

bury_back_cleanup(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");
  level waittill("finish_play_bury_back_anim");

  if(_func_0107(var_0.free_positions) && var_0.free_positions.size != 0) {
    foreach(var_3 in var_0.free_positions) {
      if(istrue(var_3.b_bury_back_pos)) {
        var_3 registerinteractionforonestruct(::get_soid_hint_func, ::on_soid_interact, undefined, undefined, undefined, undefined, undefined, 64);

        if(!isDefined(level._id_8393["soid_inactive"].hint_type_func)) {
          _id_0737::addinteractionhinttypecallback("soid_inactive", ::soid_hint_type);
        }

        var_3.script_name = "bury_back";
      } else {
        if(isDefined(var_3.trigger_proxy)) {
          _id_0737::_id_C3C5(var_3.trigger_proxy);
        }

        var_3.b_has_quest = 0;
      }

      if(isDefined(var_3.trigger_proxy)) {
        var_3.trigger_proxy stoploopsound("zmb_debuffed_barrier_lp");
        var_3.trigger_proxy delete();
      }
    }
  }

  if(isDefined(var_1)) {
    stopFXOnTag(level._effect["domination_rune_capturing_1"], var_1, "tag_origin");
  }

  var_0.b_has_quest = 0;
}

find_ray_gun_start(var_0, var_1) {
  level endon("end_game");
  level endon("game_ended");

  if(scripts\engine\utility::_id_5C00("collect_heart")) {
    var_2 = get_random_drop_rarity();
    var_3 = _func_02AB(var_0.origin);
    _id_4FF0(var_2, var_3, var_0.angles);
  } else {
    var_4 = scripts\cp\utility::_id_E190("wm_ralpha_zm_200", var_0.origin, var_0.angles);
    var_4.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
    var_4.fx_proxy linkto(var_4);
    playFXOnTag(level._effect["forever_blitz_page"], var_4.fx_proxy, "tag_origin");
    var_4 playLoopSound("zmb_tor_page_lp");
    var_4 moveto(var_0.origin + (0, 0, 20), 3);
    var_4 waittill("movedone");
    level thread spawn_zombies_on_generate_points(var_0, "enemy_zombie_screamer_cp", var_1, 20);
    var_5 = scripts\engine\utility::getstruct("lost_pages_quest_pos", "targetname");
    var_4 moveto(var_5.origin + (11, 0, 10), 3);
    var_4 rotateto(var_5.angles, 3);
    scripts\cp\utility::_id_459B(var_5.a_mdl_ray_gun, []);
    var_5.a_mdl_ray_gun = scripts\engine\utility::_id_1B8D(var_5.a_mdl_ray_gun, var_4);
    level.n_find_ray_gun_piece++;
    var_4 waittill("movedone");

    if(level.n_find_ray_gun_piece == 1) {
      scripts\engine\utility::_id_5C1B("found_ray_gun");
    }
  }
}

generate_spawn_spots(var_0, var_1, var_2) {
  level endon("end_game");
  level endon("game_ended");
  var_3 = [];
  var_4 = (-10, -10, 0);
  var_5 = (10, 10, 48);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = _func_0439(0, var_2, 0, 360, var_6);
    var_8 = var_1 * cos(var_7);
    var_9 = var_1 * sin(var_7);
    var_10 = (var_8, var_9, 0) + var_0;
    var_11 = _func_02AB(var_10);

    if(isDefined(var_11)) {
      var_3[var_3.size] = var_11;
    }
  }

  return var_3;
}

spawn_zombies_on_generate_points(var_0, var_1, var_2, var_3) {
  level endon("end_game");
  var_4 = generate_spawn_spots(var_0.origin, 250, 20);
  var_5 = 0;

  while(var_5 < var_3) {
    var_6 = var_4[var_5];
    var_7 = var_0.origin - var_6;
    var_8 = vectortoangles(var_7);
    var_9 = _id_09A4::_id_110AD(var_1, var_6, var_8, var_0);

    if(isDefined(var_9)) {
      if(isalive(var_2)) {
        var_9._id_01BD = var_2;
      }

      var_10 = randomfloatrange(0.2, 0.5);
      var_5++;
      wait(var_10);
      continue;
    }

    wait 1;
  }
}

find_ray_gun_cleanup(var_0, var_1) {}