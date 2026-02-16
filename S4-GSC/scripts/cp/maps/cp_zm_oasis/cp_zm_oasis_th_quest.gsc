/****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_th_quest.gsc
****************************************************************/

init() {
  setdvarifuninitialized("#x314c1518a4dd0d932", 0);

  if(!getdvarint("#x3a165e78de6483fc8", 0)) {
    return;
  }
  level._effect["fx_dig_dust"] = loadfx("vfx/s4/zombie/vfx_zm_shovel_dig.vfx");
  level._effect["door_locked_fx"] = loadfx("vfx/s4/level/cp_zod/vfx_mq_office_locked");
  level._effect["golden_ball_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_orb_energy_red_ambient");
  level._effect["page_place_slot_fx"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_page_place_slot");
  level._effect["evil_curse"] = loadfx("vfx/s4/zombie/vfx_zm_evil_energy_digging");
  level._effect["evil_doll_explode"] = loadfx("vfx/s4/zombie/vfx_samantha_explode");
  level._effect["dig_site_dust_fx"] = loadfx("vfx/s4/zombie/vfx_zm_dig_mosquito");
  level.n_find_ray_gun_piece = 0;
  level.n_dig_count = 0;
  level thread init_shovels();
  level thread init_subquest_types(0);
  level thread refresh_th_quest_listener();
  level thread ray_gun_quest_listener();
  register_subquest_funcs("find_common", ::find_common_start, ::find_common_cleanup);
  register_subquest_funcs("big_bomb", ::big_bomb_start, ::big_bomb_cleanup);
  register_subquest_funcs("find_ray_gun", ::find_ray_gun_start, ::find_ray_gun_cleanup);
}

refresh_th_quest_listener() {
  level endon("game_ended");

  for(;;) {
    if(scripts\engine\utility::_id_5C00("finish_dig_all_positions") && level._id_11049 > level.n_finish_round + 5 && istrue(level.b_refresh_th_quest)) {
      level.b_refresh_th_quest = 0;
      level thread init_subquest_types(1);
    }

    wait 1;
  }
}

ray_gun_quest_listener() {
  level endon("game_ended");
  level waittill("raygun_dig_enable");
  level thread init_ray_gun_pos();
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
  var_1 = scripts\engine\utility::getStructArray("s_subquest_pos", "targetname");
  var_1 = scripts\engine\utility::array_randomize(var_1);
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
    var_5 = 0;

    for(var_6 = var_5 + 10; var_5 < var_6; var_5++) {
      var_7 = var_1[var_5];
      var_7.script_name = "big_bomb";
      var_7.b_has_quest = 1;
    }

    while(var_5 < var_1.size) {
      var_8 = var_1[var_5];
      var_8.script_name = "find_common";
      var_8.b_has_quest = 1;
      var_5++;
    }

    foreach(var_10 in var_1) {
      if(!isDefined(var_10.mdl_dust)) {
        var_10.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_10.origin, var_10.angles);
        var_10.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_10.mdl_dust.origin, var_10.mdl_dust.angles);
        playFXOnTag(level._effect["dig_site_dust_fx"], var_10.mdl_dust.fx_proxy, "tag_origin");
        var_10.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
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
  level endon("game_ended");

  if(!istrue(var_1.b_got_shovel)) {
    return;
  }
  var_1 playrumbleonentity("damage_heavy");

  if(isDefined(var_0) && isDefined(var_0.mdl_dust) && isDefined(var_0.mdl_dust.fx_proxy)) {
    stopFXOnTag(level._effect["dig_site_dust_fx"], var_0.mdl_dust.fx_proxy, "tag_origin");
    var_0.mdl_dust.fx_proxy stoploopsound("zmb_amb_dig_flies_lp");
  }

  if(!istrue(var_0.b_pickup_antenna) && !istrue(var_0.b_bury_back_pos)) {
    level.n_dig_count++;
  }

  var_2 = scripts\engine\utility::getStructArray("s_subquest_pos", "targetname");

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

    playFX(level._effect["fx_dig_dust"], var_0.origin + (0, 0, 5), anglesToForward(var_0.angles + (0, 0, 90)), anglestoup(var_0.angles));
    level thread play_script_mover(var_0);
    _id_0737::_id_C3C5(var_0);
    scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_dig");

    if(var_0.script_name == "bury_back") {
      wait 1;
    }

    if(var_0.script_name == "find_ray_gun") {
      if(isDefined(var_0.mdl_dust)) {
        if(isDefined(var_0.mdl_dust.ent_sound_proxy)) {
          var_0.mdl_dust _meth_83F8();
          var_0.mdl_dust.ent_sound_proxy _meth_83F8();
          scripts\cp\utility::_id_10839(5);
          var_0.mdl_dust.ent_sound_proxy delete();
        }
      }
    }

    if(isDefined(var_1)) {
      level thread start_subquest(var_0, var_1);
    }

    if(var_0.script_name != "bury_back" || var_0.script_name != "find_ray_gun") {
      var_0.b_has_quest = 0;
    }
  }
}

play_script_mover(var_0) {
  level endon("game_ended");

  if(isDefined(var_0.mdl_dust)) {
    var_0.mdl_dust moveto(var_0.mdl_dust.origin - (0, 0, 30), 1);
  }

  var_0.mdl_dust waittill("movedone");
  var_0.mdl_dust delete();
}

start_subquest(var_0, var_1) {
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
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
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
      var_5 = scripts\engine\utility::getStructArray(var_4.target, "targetname");

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
  var_11 = scripts\engine\utility::getStructArray(var_10.target, "targetname");

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
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getStructArray("s_shovel_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_2 in var_0) {
    var_3 = var_2;
    var_3.mdl_shovel = scripts\cp\utility::_id_E190("s4_zm_jpn_farm_tools_shovel_01", var_3.origin, var_3.angles);
    var_3.mdl_shovel thread outline_distance_check_lisnter();
  }

  _id_0737::_id_C266("shovel_inactive", ::get_shovel_hint_func, ::on_shovel_interact, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("shovel_inactive", ::shovel_hint_type);

  foreach(var_6 in var_0) {
    if(!isDefined(var_6.mdl_shovel)) {
      _id_0737::_id_C3C5(var_6);
    }
  }
}

outline_distance_check_lisnter() {
  self endon("death");

  for(;;) {
    foreach(var_1 in level.players) {
      if(!istrue(var_1.b_got_shovel)) {
        var_2 = distancesquared(self.origin, var_1.origin);

        if(var_2 <= _func_0219(500)) {
          self._id_ACE5 = scripts\cp\cp_outline_utility::outlineenableforplayer(self, var_1, "outline_depth_yellow_zm_wider", "equipment");
        } else {
          self _meth_81AE(var_1);
        }
      }
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
  level endon("game_ended");

  if(istrue(var_1.b_got_shovel)) {
    return;
  }
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_shovel_pickup");
  var_1.b_got_shovel = 1;

  if(isDefined(var_0.mdl_shovel)) {
    var_0.mdl_shovel notify("death");
    var_0.mdl_shovel delete();
  }

  _id_0737::_id_C3C5(var_0);
}

find_common_start(var_0, var_1) {
  var_2 = _func_02AB(var_0.origin);

  if(isDefined(var_2)) {
    if(randomint(100) > 25) {
      _id_073D::_id_4FF0("aether_pocket_crystal_loot", var_2, var_0.angles);
    }
  }

  level.last_dig_loc = var_0;
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
  level endon("game_ended");
  var_0.mdl_antenna = scripts\cp\utility::_id_E190("s4_zm_radio_antenna", var_0.s_antenna_pos.origin, var_0.s_antenna_pos.angles);
  scripts\cp\utility::_id_B8ED(var_0.origin, "zmb_radio_antennae_place");
  level thread spawn_zombies_around(var_0, "enemy_zombie_screamer_cp", var_1);
  level notify("th_radio_start_used");
  waitframe();
  _id_0737::_id_C3C5(var_0);
}

spawn_zombies_around(var_0, var_1, var_2) {
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
  level endon("game_ended");
  self endon("death");
  level waittill("players_landed");
  self _meth_86BE();
}

find_radio_cleanup(var_0, var_1) {}

capture_golden_ball_start(var_0, var_1) {
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
  level endon("game_ended");
  level endon("captured_golden_ball");

  while(isDefined(var_0)) {
    self.origin = var_0.origin;
    waitframe();
  }
}

golden_ball_damage_listener() {
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
  level endon("game_ended");
  level endon("golden_ball_stun_down");
  self moveto(self.origin + (0, 0, 30), 3);

  if(isDefined(self.target_area)) {
    self.target_area.b_used = 0;
    self.target_area = undefined;
  }

  self waittill("movedone");
  self playSound("zmb_orb_flyaway");
  var_0 = scripts\engine\utility::getStructArray("golden_ball_start_point", "script_noteworthy");
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

  self moveto(var_4 + (0, 0, 30), 3);
  self waittill("movedone");
  _id_C266("golden_ball_inactive", ::get_golden_ball_hint_func, ::on_golden_ball_interact, undefined, undefined, undefined, undefined, undefined, 64);
  _id_0737::addinteractionhinttypecallback("golden_ball_inactive", ::golden_ball_type);
  thread stun_down_timer();
}

stun_down_timer() {
  level endon("game_ended");
  self endon("captured_golden_ball");
  wait 5;
  _id_0737::_id_C3C5(self);
  thread start_moving();
  self.damage_proxy thread golden_ball_damage_listener();
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
  level endon("game_ended");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
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
  _func_01BA(var_0.origin, 400, 80, 80, var_1, "MOD_EXPLOSIVE", "s4_monkey_bomb_zm");

  for(var_9 = 0; var_9 < 3; var_9++) {
    var_10 = randomintrange(1, 359);
    var_11 = _func_02A9(var_0.origin, 50);
    _id_092E::_id_E178("cploot_salvage", var_11, (0, var_10, 0));
  }

  level.last_dig_loc = var_0;
}

big_bomb_cleanup(var_0, var_1) {}

bury_back_start(var_0, var_1) {
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
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("s_subquest_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = [];
  var_2 = 0;

  while(var_2 < 3) {
    foreach(var_4 in var_0) {
      if(!istrue(var_4.b_has_quest) && var_4 != self) {
        var_1 = scripts\cp\utility::_id_1B8C(var_1, var_4);
        var_2++;
      }
    }

    wait 30;
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

init_ray_gun_pos() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("s_subquest_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(level.last_dig_loc)) {
      if(var_3 != level.last_dig_loc) {
        if(!istrue(var_3.b_has_quest) || scripts\engine\utility::is_equal(var_3.script_name, "find_common")) {
          var_1 = var_3;
          break;
        }
      }
    } else if(!istrue(var_3.b_has_quest) || scripts\engine\utility::is_equal(var_3.script_name, "find_common")) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.b_has_quest)) {
      if(!var_1.b_has_quest) {
        var_1.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_1.origin - (0, 0, 20), var_1.angles);
        var_1.mdl_dust moveto(var_1.origin + (0, 0, -5), 3);
        var_1.mdl_dust waittill("movedone");
        var_1.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_1.mdl_dust.origin, var_1.mdl_dust.angles);
        playFXOnTag(level._effect["dig_site_dust_fx"], var_1.mdl_dust.fx_proxy, "tag_origin");
        var_1.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
        var_1 registerinteractionforonestruct(::get_soid_hint_func, ::on_soid_interact, undefined, undefined, undefined, undefined, undefined, 64);

        if(!isDefined(level._id_8393["soid_inactive"].hint_type_func)) {
          _id_0737::addinteractionhinttypecallback("soid_inactive", ::soid_hint_type);
        }
      }

      level thread play_bunny_spawn_sound();
      var_1.b_has_quest = 1;
      var_1.script_name = "find_ray_gun";
      var_1.mdl_dust thread play_laugh_sound("zmb_bunny_laugh_buried_lp");
      var_1 thread dig_time_out_listener();
      level scripts\engine\utility::_id_5C1B("setup_current_raygun_dig");
    }
  }
}

play_bunny_spawn_sound() {
  level endon("game_ended");
  wait 3;

  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      scripts\cp\utility::_id_B8F4("zmb_bunny_spawn_2d", var_1);
    }
  }
}

find_ray_gun_start(var_0, var_1) {
  level endon("game_ended");
  var_2 = "";

  switch (level.n_find_ray_gun_piece) {
    case 0:
      var_2 = "s4_zm_bunny_head";
      break;
    case 1:
      var_2 = "s4_zm_bunny_body";
      break;
    case 2:
      var_2 = "s4_zm_bunny_legs";
      break;
    default:
      break;
  }

  if(var_2 == "") {
    return;
  }
  var_3 = scripts\cp\utility::_id_E190(var_2, var_0.origin, var_0.angles);
  var_3.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_0.origin, var_0.angles);
  var_3 play_laugh_sound("zmb_bunny_float_lp");
  var_3.fx_proxy linkto(var_3);
  var_3 moveto(var_0.origin + (0, 0, 20), 3);
  var_3 waittill("movedone");
  var_3._id_039B = "bunny_interact";
  _id_C266("bunny_interact", ::bunny_interact_hint_func, ::on_bunny_interact, undefined, undefined, undefined, undefined, undefined, 100);
  _id_0737::addinteractionhinttypecallback("bunny_interact", ::bunny_interact_type);
  var_3 thread time_out_listener(30);
  _id_0737::_id_C3C5(var_0);
  level waittill("bunny_part_appeared");

  if(level.n_find_ray_gun_piece >= 3) {
    level thread spawn_ray_gun_quest_reward(var_0, var_1);
  } else {
    level waittill("raygun_dig_enable");
    set_up_next_bunny_part(var_0);
  }
}

set_up_next_bunny_part(var_0) {
  if(scripts\engine\utility::_id_5C00("setup_current_raygun_dig")) {
    return;
  }
  var_1 = var_0 get_ray_gun_free_position();

  if(isDefined(var_1)) {
    if(isDefined(var_1.b_has_quest)) {
      if(!var_1.b_has_quest) {
        var_1.mdl_dust = scripts\cp\utility::_id_E190("s4_zm_dust_pile", var_1.origin - (0, 0, 20), var_1.angles);
        var_1.mdl_dust moveto(var_1.origin + (0, 0, -5), 3);
        var_1.mdl_dust waittill("movedone");
        var_1.mdl_dust.fx_proxy = scripts\cp\utility::_id_E190("tag_origin", var_1.mdl_dust.origin, var_1.mdl_dust.angles);
        playFXOnTag(level._effect["dig_site_dust_fx"], var_1.mdl_dust.fx_proxy, "tag_origin");
        var_1.mdl_dust.fx_proxy playLoopSound("zmb_amb_dig_flies_lp");
        var_1 registerinteractionforonestruct(::get_soid_hint_func, ::on_soid_interact, undefined, undefined, undefined, undefined, undefined, 64);

        if(!isDefined(level._id_8393["soid_inactive"].hint_type_func)) {
          _id_0737::addinteractionhinttypecallback("soid_inactive", ::soid_hint_type);
        }
      }

      level thread play_bunny_spawn_sound();
      var_1.b_has_quest = 1;
      var_1.script_name = "find_ray_gun";
      var_1.mdl_dust thread play_laugh_sound("zmb_bunny_laugh_buried_lp");
      var_1 thread dig_time_out_listener();
    }
  }

  level scripts\engine\utility::_id_5C1B("setup_current_raygun_dig");
}

get_ray_gun_free_position() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStructArray("s_subquest_pos", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3 != self) {
      if(!istrue(var_3.b_has_quest) || scripts\engine\utility::is_equal(var_3.script_name, "find_common")) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

time_out_listener(var_0) {
  level endon("game_ended");
  self endon("death");
  wait(var_0);

  foreach(var_2 in level.players) {
    if(isPlayer(var_2)) {
      _func_019D(level._effect["evil_doll_explode"], self.fx_proxy, "tag_origin", var_2);
      wait 0.5;
    }
  }

  level scripts\engine\utility::_id_5C04("setup_current_raygun_dig");
  level.n_round_count = 0;
  level notify("bunny_part_appeared");
  _id_0737::_id_C3C5(self);
  self delete();
}

dig_time_out_listener() {
  level endon("game_ended");
  level endon("bunny_part_appeared");
  self endon("dig_timeout");
  level scripts\engine\utility::_id_10897("round_complete", "round_accelerant_closed");

  if(isDefined(self.mdl_dust)) {
    if(isDefined(self.mdl_dust.ent_sound_proxy)) {
      self.mdl_dust _meth_83F8();
      self.mdl_dust.ent_sound_proxy _meth_83F8();
      scripts\cp\utility::_id_10839(5);
      self.mdl_dust.ent_sound_proxy delete();
    }
  }

  self.b_has_quest = 0;
  self.script_name = "find_common";
  level scripts\engine\utility::_id_5C04("setup_current_raygun_dig");
  level.n_round_count = 0;
  level waittill("raygun_dig_enable");
  set_up_next_bunny_part(self);
  self notify("dig_timeout");
}

play_laugh_sound(var_0) {
  level endon("game_ended");
  self endon("death");
  self.ent_sound_proxy = scripts\cp\utility::_id_E190("tag_origin", self.origin, self.angles);
  self.ent_sound_proxy playLoopSound(var_0);
}

bunny_interact_hint_func(var_0, var_1) {
  return &"CP_ZM_OASIS/PICK_UP_BUNNY";
}

bunny_interact_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_bunny_interact(var_0, var_1) {
  level endon("game_ended");
  level endon("bunny_part_appeared");
  level.n_find_ray_gun_piece++;

  if(isDefined(var_1)) {
    scripts\cp\utility::_id_B8F4("zmb_bunny_part_pickup", var_1);
  }

  foreach(var_1 in level.players) {
    if(isPlayer(var_1)) {
      _func_019D(level._effect["evil_doll_explode"], var_0.fx_proxy, "tag_origin", var_1);
      waitframe();
    }
  }

  var_0 hide();
  _id_0737::_id_C3C5(var_0);

  if(isDefined(var_0.ent_sound_proxy)) {
    var_0.ent_sound_proxy _meth_83F8();
    scripts\cp\utility::_id_10839(5);
    var_0.ent_sound_proxy delete();
  }

  var_0.fx_proxy delete();
  var_0 delete();
  level scripts\engine\utility::_id_5C04("setup_current_raygun_dig");
  level notify("bunny_part_appeared");
}

spawn_ray_gun_quest_reward(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in level.players) {
    if(isPlayer(var_3)) {
      scripts\cp\utility::_id_B8F4("zmb_bunny_success", var_3);
    }
  }

  for(var_5 = 0; var_5 <= 3; var_5++) {
    var_6 = _func_02A9(var_0.origin, 70);
    _id_0990::_id_E3DD("bonus_points_team", var_6);
  }

  var_6 = _func_02A9(var_0.origin, 50);
  var_1 _id_075A::_id_6FCE(500);
  var_7 = 0;

  if(_func_0107(var_1.weaponlist)) {
    foreach(var_9 in var_1.weaponlist) {
      var_10 = getweaponbasename(var_9);

      if(var_10 == "s4_pi_raygun_mp") {
        var_7 = 1;
        break;
      }
    }
  }

  if(var_7) {
    var_1 _id_074E::_id_6F28(15000, "large", undefined, 1, "bonus");
  } else {
    var_6 = _func_02A9(var_0.origin, 70);
    var_12 = scripts\cp\cp_weapon::buildweapon("s4_pi_raygun_mp");
    var_13 = _id_092E::_id_E24D(var_12, var_6 + (0, 0, 8), undefined, undefined, undefined, 1);
  }

  level notify("ray_gun_dig_complete");
}

raygun_interact_hint_func(var_0, var_1) {
  return &"CP_ZM_OASIS/PICK_UP_RAYGUN";
}

raygun_interact_type(var_0, var_1) {
  return "HINT_NOICON";
}

on_raygun_interact(var_0, var_1) {
  var_1 giveweapon("s4_pi_raygun_mp");
  var_1 switchtoweapon("s4_pi_raygun_mp");
  _id_0737::_id_C3C5(var_0);
  var_0.fx_proxy delete();
  var_0 delete();
}

find_ray_gun_cleanup(var_0, var_1) {
  level endon("game_ended");
  level waittill("bunny_part_appeared");
  var_0.b_has_quest = 0;
}