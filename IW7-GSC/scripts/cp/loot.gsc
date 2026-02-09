/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\loot.gsc
*********************************************/

init_loot() {
  read_loot_table();
  init_powerup_effects();
  init_powerup_flags();
  init_powerup_data();
  level thread reset_drop_count_between_waves();
  level thread check_to_increase_powerup_drop_rates();
  level thread poweruponplayerconnect();
}

poweruponplayerconnect() {
  var_0 = getarraykeys(level.active_power_ups);
  for(;;) {
    level waittill("connected", var_1);
    foreach(var_3 in var_0) {
      if(scripts\engine\utility::istrue(level.active_power_ups[var_3])) {
        if(isDefined(level.power_up_func[var_3])) {
          thread[[level.power_up_func[var_3]]](var_1);
        }
      }
    }
  }
}

init_powerup_effects() {
  level._effect["pickup"] = loadfx("vfx\iw7\core\zombie\powerups\vfx_zom_powerup_pickup.vfx");
  level._effect["pickup_fnfmod"] = loadfx("vfx\iw7\core\zombie\powerups\vfx_zd_powerup_pickup.vfx");
  level._effect["big_explo"] = loadfx("vfx\iw7\_requests\coop\vfx_nuke_explosion_01.vfx");
}

init_powerup_data() {
  if(!isDefined(level.active_power_ups)) {
    level.active_power_ups = [];
  }

  level.active_power_ups["instakill"] = 0;
  level.active_power_ups["double_money"] = 0;
  level.active_power_ups["fire_sale"] = 0;
  level.active_power_ups["infinite_ammo"] = 0;
  level.active_power_ups["infinite_grenades"] = 0;
  level.power_up_func["instakill"] = ::apply_instakill_effects;
  level.power_up_func["double_money"] = ::apply_double_money_effects;
  level.power_up_func["infinite_ammo"] = ::apply_infinite_ammo_effects;
  level.power_up_func["infinite_grenades"] = ::apply_infinite_grenade_effects;
  level.power_up_func["fire_sale"] = ::apply_fire_sale_effects;
  if(!isDefined(level.power_up_drop_score)) {
    level.power_up_drop_score = 500;
  }

  if(!isDefined(level.powerup_drop_increment)) {
    level.powerup_drop_increment = randomintrange(2000, 3000);
  }

  if(!isDefined(level.powerup_drop_max_per_round)) {
    level.powerup_drop_max_per_round = 5;
  }

  if(!isDefined(level.powerup_drop_count)) {
    level.powerup_drop_count = 0;
  }

  if(!isDefined(level.score_to_drop)) {
    level.score_to_drop = level.powerup_drop_increment;
  }
}

check_to_increase_powerup_drop_rates() {
  level waittill("regular_wave_starting");
  for(;;) {
    foreach(var_1 in level.players) {
      if(!scripts\engine\utility::istrue(var_1.checked)) {
        var_1.checked = 1;
        level.score_to_drop = level.score_to_drop + level.power_up_drop_score;
        if(var_1 scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
          level.powerup_drop_increment = level.powerup_drop_increment - 5;
        }
      }
    }

    level waittill("player_spawned");
  }
}

init_powerup_flags() {
  scripts\engine\utility::flag_init("zombie_drop_powerups");
  scripts\engine\utility::flag_init("fire_sale");
  scripts\engine\utility::flag_init("canFiresale");
  scripts\engine\utility::flag_init("explosive_armor");
  scripts\engine\utility::flag_init("force_drop_max_ammo");
}

reset_drop_count_between_waves() {
  level endon("game_ended");
  for(;;) {
    level waittill("spawn_wave_done");
    level.powerup_drop_count = 0;
  }
}

read_loot_table() {
  level.loot_info = [];
  level.loot_fx = [];
  level.loot_icon = [];
  level.loot_id = [];
  if(isDefined(level.power_up_table)) {
    var_0 = level.power_up_table;
  } else {
    var_0 = "cp\zombies\zombie_loot.csv";
  }

  for(var_1 = 1; var_1 <= 100; var_1++) {
    var_2 = table_look_up(var_0, var_1, 2);
    if(scripts\cp\utility::is_empty_string(var_2)) {
      break;
    }

    var_3 = [];
    var_3["weights"] = convert_to_float_array(table_look_up(var_0, var_1, 3));
    var_3["weight_sum"] = get_weight_sum(var_3["weights"]);
    var_4 = strtok(table_look_up(var_0, var_1, 4), " ");
    var_3["contents"] = [];
    foreach(var_8, var_6 in var_4) {
      var_7 = [];
      var_7["value"] = var_6;
      var_7["last_time"] = 0;
      var_3["contents"][var_8] = var_7;
    }

    level.loot_info[var_2] = var_3;
  }

  for(var_1 = 101; var_1 <= 150; var_1++) {
    var_9 = table_look_up(var_0, var_1, 2);
    if(scripts\cp\utility::is_empty_string(var_9)) {
      break;
    }

    var_10 = table_look_up(var_0, var_1, 3);
    if(!isDefined(level._effect[var_10])) {
      level._effect[var_10] = loadfx(var_10);
    }

    level.loot_fx[var_9] = var_10;
    var_11 = table_look_up(var_0, var_1, 1);
    level.loot_id[var_9] = var_11;
  }

  for(var_1 = 101; var_1 <= 150; var_1++) {
    var_9 = table_look_up(var_0, var_1, 2);
    if(scripts\cp\utility::is_empty_string(var_9)) {
      break;
    }

    var_12 = table_look_up(var_0, var_1, 4);
    if(scripts\cp\utility::is_empty_string(var_12)) {
      continue;
    }

    level.loot_icon[var_9] = var_12;
  }
}

convert_to_float_array(var_0) {
  var_0 = strtok(var_0, " ");
  var_1 = [];
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = float(var_0[var_2]);
  }

  return var_1;
}

get_weight_sum(var_0) {
  var_1 = 0;
  foreach(var_3 in var_0) {
    var_1 = var_1 + var_3;
  }

  return var_1;
}

drop_loot(location, from_consumable, powerup_id, should_fly_to_player, var_4, can_despawn) {
  if(powerup_id == "none") {
    return 0;
  }

  location = getclosestpointonnavmesh(location);
  fly_to_player = scripts\engine\utility::istrue(should_fly_to_player);
  var_7 = create_loot_model(location);
  if(!isDefined(var_7)) {
    return 0;
  }

  var_7.fnf_consumable_active = 0;
  foreach(var_9 in level.players) {
    if(var_9 scripts\cp\utility::is_consumable_active("temporal_increase")) {
      var_7.fnf_consumable_active = 1;
      break;
    }
  }

  var_7.content = powerup_id;
  var_11 = get_loot_fx(var_7);
  var_7.fxname = var_11;
  var_12 = (0, 0, 0);
  if(isDefined(from_consumable) && from_consumable scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
    from_consumable scripts\cp\utility::notify_used_consumable("more_power_up_drops");
  }

  if(isDefined(var_4)) {
    level.powerup_drop_increment = level.powerup_drop_increment * 1.14;
    level.score_to_drop = var_4 + level.powerup_drop_increment;
    level.powerup_drop_count++;
    level.last_drop_time = gettime();
  }

  if(!is_in_active_volume(location) && loot_fly_to_player_enabled()) {
    location = moveeffecttoclosestplayer(var_7);
    var_7 thread loot_fx_handler();
    fly_to_player = 1;
  } else {
    location = location + (0, 0, 50);
    if(scripts\engine\utility::istrue(var_7.fnf_consumable_active)) {
      var_7.fnffx = spawnfx(level._effect["powerup_additive_fx"], location + (0, 0, -10));
    }

    var_7.fx = spawnfx(scripts\engine\utility::getfx(var_11), location);
    if(isDefined(var_12)) {
      var_7.fx.angles = var_12;
    }
  }

  if(isDefined(from_consumable)) {
    var_7.owner = from_consumable;
  } else {
    var_7.owner = level.players[0];
  }

  var_7 notify("activate");
  if(!fly_to_player) {
    if(scripts\engine\utility::istrue(var_7.fnf_consumable_active)) {
      triggerfx(var_7.fnffx);
      var_7.fnffx setfxkilldefondelete();
    }

    triggerfx(var_7.fx);
    var_7.fx setfxkilldefondelete();
    var_7 thread loot_fx_handler();
  }

  var_7 thread loot_pick_up_monitor(var_7);
  var_7 thread loot_think(var_7);
  var_13 = get_index_for_powerup(powerup_id);
  if(isDefined(var_13) && scripts\engine\utility::istrue(can_despawn)) {
    update_power_up_drop_time(var_13);
  }

  level thread cleanuppowerup(var_7);
  return 1;
}

loot_fly_to_player_enabled() {
  if(scripts\engine\utility::istrue(level.disable_loot_fly_to_player)) {
    return 0;
  }

  return 1;
}

moveeffecttoclosestplayer(var_0) {
  level endon("game_ended");
  var_0.fx = spawn("script_model", var_0.origin + (0, 0, 50));
  var_0.fx setModel("tag_origin");
  wait(0.1);
  if(scripts\engine\utility::istrue(var_0.fnf_consumable_active)) {
    playFXOnTag(level._effect["powerup_additive_fx"], var_0.fx, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx(var_0.fxname), var_0.fx, "tag_origin");
  var_1 = scripts\engine\utility::getclosest(var_0.origin, level.players);
  var_2 = distance(var_0.origin, var_1.origin);
  var_3 = 300;
  var_4 = var_2 / var_3;
  if(var_4 < 0.05) {
    var_4 = 0.05;
  }

  var_5 = getclosestpointonnavmesh(scripts\engine\utility::drop_to_ground(var_1.origin, 32, -100)) + (0, 0, 50);
  var_0.fx moveto(var_5, var_4);
  var_0.fx waittill("movedone");
  var_0 dontinterpolate();
  var_0.origin = var_0.fx.origin;
  return var_0.origin;
}

cleanuppowerup(var_0) {
  var_0 scripts\engine\utility::waittill_any_timeout(get_loot_time_out(), "picked_up");
  if(scripts\engine\utility::istrue(var_0.fnf_consumable_active)) {
    playFX(level._effect["pickup_fnfmod"], var_0.origin + (0, 0, 50));
  } else {
    playFX(level._effect["pickup"], var_0.origin + (0, 0, 50));
  }

  if(isDefined(var_0.fx)) {
    var_0.fx delete();
  }

  if(isDefined(var_0.fnffx)) {
    var_0.fnffx delete();
  }

  wait(0.5);
  var_0.fnf_consumable_active = 0;
  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_0 notify("loot_deleted");
}

loot_fx_handler() {
  self endon("death");
  self endon("picked_up");
  self endon("loot_deleted");
  var_0 = get_loot_time_out() - 5;
  wait(var_0);
  for(var_1 = 0; var_1 < 5; var_1++) {
    wait(0.5);
    self.fx delete();
    wait(0.5);
    var_2 = get_loot_fx(self);
    var_3 = scripts\engine\utility::getfx(var_2);
    if(!isDefined(var_3)) {
      continue;
    }

    self.fx = spawnfx(var_3, self.origin + (0, 0, 50));
    self.fx.angles = (0, 0, 0);
    wait(0.1);
    triggerfx(self.fx);
    self.fx setfxkilldefondelete();
  }

  if(isDefined(self) && isDefined(self.fx)) {
    self.fx delete();
  }

  if(isDefined(self) && isDefined(self.fnffx)) {
    self.fnffx delete();
  }
}

get_loot_time_out() {
  if(isDefined(level.loot_time_out)) {
    return level.loot_time_out;
  }

  return 30;
}

get_index_for_powerup(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "kill_generic_zombie";
  }

  var_2 = 0;
  var_3 = level.loot_info[var_1]["contents"].size;
  for(var_2 = 0; var_2 < var_3; var_2++) {
    if(level.loot_info[var_1]["contents"][var_2]["value"] == var_0) {
      return var_2;
    }
  }

  return 0;
}

monitor_health(var_0) {
  self endon("loot_deleted");
  level endon("game_ended");
  while(isDefined(var_0) && isDefined(var_0.health) && var_0.health >= 1) {
    level waittill("attack_hit", var_1, var_2);
    if(var_0 != var_2) {
      continue;
    }

    var_0.health = var_0.health - 50;
  }

  self notify("picked_up");
}

create_loot_model(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 32, -64);
  var_2 = spawn("trigger_radius", var_1, 0, 32, 76);
  return var_2;
}

get_loot_fx(var_0) {
  if(!isDefined(level.loot_fx[var_0.content])) {
    return "vfx_loot_ace_hearts";
  }

  return level.loot_fx[var_0.content];
}

loot_think(var_0) {
  var_0 endon("loot_deleted");
  var_1 = var_0 scripts\engine\utility::waittill_any_timeout(get_loot_time_out(), "picked_up");
  if(var_1 == "picked_up") {
    thread process_loot_content(var_0.owner, var_0.content, var_0, 1);
  }
}

loot_pick_up_monitor(var_0) {
  var_0 endon("loot_deleted");
  wait(0.2);
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isPlayer(var_1)) {
      wait(0.25);
      continue;
    }

    var_0 notify("picked_up");
    var_1 playlocalsound("zmb_powerup_activate");
    break;
  }
}

process_loot_content(powerupName, var_1, var_2, var_3) {
  var_4 = var_1;
  var_1 = strtok(var_1, "_");
  var_5 = var_1[0];
  var_6 = var_1[1];
  var_7 = gettime();
  var_8 = int(level.loot_id[var_4]);
  var_9 = 1;
  display_powerup_popup(0);
  switch (var_5) {
    case "power":
      level thread[[level.power_off_func]](var_4, var_7);
      break;

    case "fire":
      if(isDefined(level.fire_sale_func)) {
        if(isDefined(level.temporal_increase)) {
          var_6 = int(var_6) * level.temporal_increase;
        }

        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_firesale", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_fire_sale");
        level thread[[level.fire_sale_func]](var_4, int(var_6), var_7);
      }
      break;

    case "grenade":
      if(isDefined(level.temporal_increase)) {
        var_6 = int(var_6) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_infinitegrenades", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_infinite_grenades");
      level thread give_infinite_grenade(var_4, int(var_6), var_7);
      break;

    case "infinite":
      if(isDefined(level.temporal_increase)) {
        var_6 = int(var_6) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_infiniteammo", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_infinite_ammo");
      level thread give_infinite_ammo(var_4, int(var_6), var_7);
      break;

    case "upgrade":
      if(isDefined(level.upgrade_weapons_func)) {
        var_2 playSound("zmb_powerup_wpn_upgrade");
        level thread[[level.upgrade_weapons_func]]();
      }
      break;

    case "kill":
      if(scripts\engine\utility::istrue(level.forced_nuke)) {
        var_9 = 0;
        level thread kill_closest_enemies(var_2, int(var_6));
      } else {
        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_nuke", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_nuke");
        level thread kill_closest_enemies(var_2, int(var_6));
      }
      break;

    case "cash":
      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_doublemoney", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_dbl_cash");
      level thread scale_earned_cash(powerupName, var_4, int(var_6), var_7);
      break;

    case "instakill":
      if(isDefined(level.temporal_increase)) {
        var_6 = int(var_6) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_instakill", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_instakill");
      level thread activate_instakill(powerupName, var_4, int(var_6), var_7);
      break;

    case "ammo":
      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_maxammo", "zmb_powerup_vo");
      var_2 playSound("zmb_powerup_max_ammo");
      level notify("pick_up_max_ammo");
      level thread give_ammo();
      break;

    case "board":
      if(isDefined(level.rebuild_all_windows_func)) {
        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_carpenter", "zmb_powerup_vo");
        var_2 playSound("zmb_powerup_reboard_windows");
        level thread[[level.rebuild_all_windows_func]](powerupName);
      }
      break;

    default:
      break;
  }

  if(scripts\engine\utility::istrue(var_3)) {
    powerupName scripts\cp\cp_merits::processmerit("mt_powerup_grabs");
  }

  powerupName thread scripts\cp\cp_hud_message::tutorial_lookup_func("powerups");
  scripts\engine\utility::waitframe();
  if(var_9) {
    display_powerup_popup(var_8);
  }
}

get_loot_content(var_0, var_1, var_2) {
  if(!isDefined(level.loot_info[var_0])) {
    return undefined;
  }

  var_3 = gettime();
  var_4 = choose_powerup(var_0, var_3, var_1);
  return var_4;
}

choose_powerup(var_0, var_1, var_2) {
  var_3 = level.wave_num;
  var_4 = level.loot_info[var_0]["contents"].size;
  level.allowed_powerups = [];
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = level.loot_info[var_0]["contents"][var_5]["value"];
    var_7 = level.loot_info[var_0]["contents"][var_5]["last_time"];
    var_6 = strtok(var_6, "_");
    var_8 = var_6[0];
    switch (var_8) {
      case "fire":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || scripts\engine\utility::flag("canFiresale") && var_1 - var_7 >= 180000) && var_3 >= 5) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "explosive":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 300000) && var_3 >= 8) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "infinite":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 180000) && var_3 >= 5) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "ammo":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 180000) && var_3 >= 2) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "grenade":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= -5536) && var_3 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "upgrade":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 600000) && var_3 >= 15) {
          if(!scripts\cp\utility::is_codxp()) {
            level.allowed_powerups[level.allowed_powerups.size] = var_5;
          }

          break;
        } else {
          break;
        }

        break;

      case "kill":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 180000) && var_3 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "cash":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 90000) && var_3 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "instakill":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= 90000) && var_3 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      case "board":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || var_1 - var_7 >= -20536) && var_3 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_5;
          break;
        } else {
          break;
        }

        break;

      default:
        break;
    }
  }

  if(level.allowed_powerups.size < 1) {
    return undefined;
  }

  var_9 = level.allowed_powerups[get_loot_index_based_on_weights(var_0)];
  var_10 = level.loot_info[var_0]["contents"][var_9]["value"];
  level.allowed_powerups = undefined;
  level.last_loot_drop = var_9;
  return var_10;
}

get_loot_index_based_on_weights(var_0) {
  var_1 = 0;
  for(var_2 = 0; var_2 < level.allowed_powerups.size; var_2++) {
    var_3 = int(level.allowed_powerups[var_2]);
    var_1 = var_1 + level.loot_info[var_0]["weights"][var_3];
  }

  var_4 = randomfloat(var_1);
  var_5 = 0;
  for(var_2 = 0; var_2 < level.allowed_powerups.size; var_2++) {
    var_3 = int(level.allowed_powerups[var_2]);
    var_5 = var_5 + level.loot_info[var_0]["weights"][var_3];
    if(var_5 >= var_4) {
      return var_2;
    }
  }
}

table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

update_enemy_killed_event(var_0, var_1, var_2) {
  if(!scripts\cp\utility::coop_mode_has("loot")) {
    return;
  }

  if(!isDefined(level.loot_func)) {
    return;
  }

  if(!scripts\engine\utility::flag("zombie_drop_powerups")) {
    return;
  }

  if(!isPlayer(var_2)) {
    return;
  }

  var_4 = scripts\engine\utility::istrue(level.power_up_drop_override);
  if(level.powerup_drop_count >= level.powerup_drop_max_per_round && !var_4) {
    return;
  }

  if(!is_in_active_volume(var_1)) {
    return;
  }

  if(scripts\engine\utility::istrue(self.is_suicide_bomber)) {
    return;
  }

  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(var_1, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(var_1, undefined, undefined, undefined, 1)) {
    return;
  }

  var_5 = level.players;
  var_3 = undefined;
  var_6 = 0;
  if(var_2 scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
    var_7 = level.score_to_drop * 0.7;
  } else {
    var_7 = level.score_to_drop;
  }

  for(var_8 = 0; var_8 < var_5.size; var_8++) {
    if(isDefined(var_5[var_8].total_currency_earned)) {
      var_6 = var_6 + var_5[var_8].total_currency_earned;
    }
  }

  var_9 = 0;
  if(var_6 > var_7 && !var_9) {
    var_3 = get_loot_content("kill_" + var_0, var_1);
  }

  if(isDefined(var_3)) {
    level thread drop_loot(var_1, var_2, var_3, undefined, var_6, 1);
  }
}

update_power_up_drop_time(var_0) {
  var_1 = gettime();
  level.loot_info["kill_generic_zombie"]["contents"][var_0]["last_time"] = var_1;
}

give_explosive_armor(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("deactivated" + var_0);
  scripts\engine\utility::flag_set("explosive_armor");
  level thread deactivate_explosive_armor(var_0, var_1);
  level thread player_connect_monitor(var_0, ::give_player_explosive_armor);
  level thread player_spawn_monitor(var_0, ::give_player_explosive_armor);
  level thread give_explosive_touch_on_revived(var_0, ::give_player_explosive_armor);
  level.explosive_touch = 1;
  foreach(var_4 in level.players) {
    if(!isalive(var_4) || scripts\engine\utility::istrue(var_4.inlaststand)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_4.has_explosive_armor)) {
      thread give_player_explosive_armor(var_4, var_0);
    }
  }
}

give_player_explosive_armor(var_0, var_1) {
  var_0.has_explosive_armor = 1;
  var_0 thread power_icon_active(undefined, var_1);
  var_0 thread create_explosive_shield();
  var_0 thread damage_enemies_in_radius();
  var_0 thread remove_explosive_touch(var_1);
  var_0 thread remove_explosive_touch_on_death(var_0);
}

player_connect_monitor(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("connected", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

player_spawn_monitor(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("player_spawned", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

give_explosive_touch_on_revived(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("revive_success", var_2);
    thread[[var_1]](var_2, var_0);
  }
}

remove_explosive_touch(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  scripts\engine\utility::flag_waitopen("explosive_armor");
  self.has_explosive_armor = undefined;
  self setscriptablepartstate("exp_touch", "neutral", 0);
  self notify("explosive_armor_removed");
  self notify("remove_power_icon" + var_0);
}

remove_explosive_touch_on_death(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("explosive_armor_removed");
  var_0 scripts\engine\utility::waittill_any("death", "last_stand");
  var_0.has_explosive_armor = undefined;
  var_0 setscriptablepartstate("exp_touch", "neutral", 0);
  var_0 notify("explosive_armor_removed");
}

deactivate_explosive_armor(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_1 = var_1 - 5.5;
  scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);
  wait(5.5);
  scripts\engine\utility::flag_clear("explosive_armor");
  level.explosive_touch = undefined;
  foreach(var_3 in level.players) {
    var_3.has_explosive_armor = undefined;
  }
}

damage_enemies_in_radius() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self endon("explosive_armor_removed");
  for(var_0 = gettime(); scripts\engine\utility::flag("explosive_armor"); var_0 = gettime()) {
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, level.spawned_enemies, undefined, undefined, 128, 1);
    foreach(var_3 in var_1) {
      if(isalive(var_3)) {
        if(!isDefined(var_3.explosive_touch_time) || gettime() > var_3.explosive_touch_time) {
          var_3.explosive_touch_time = var_0 + 1000;
          var_3 dodamage(100, self.origin, self, self, "MOD_UNKNOWN", "power_script_generic_primary_mp");
        }
      }
    }

    wait(0.25);
  }
}

create_explosive_shield() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("exp_touch", "on", 0);
}

outline_enemies(var_0, var_1, var_2) {
  level endon("deactivated" + var_0);
  level thread deactivate_outline_enemies(var_0, var_1);
  level thread outline_all_enemies(var_0);
  for(;;) {
    foreach(var_4 in level.players) {
      if(!scripts\engine\utility::istrue(var_4.has_outline_on)) {
        var_4.has_outline_on = 1;
        var_5 = var_1 - gettime() - var_2 / 1000;
        var_4 thread power_icon_active(var_5, var_0);
      }
    }

    wait(0.25);
  }
}

outline_all_enemies(var_0) {
  level endon("game_ended");
  level endon("host_migration_begin");
  level endon("deactivated" + var_0);
  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_4, var_3 in var_1) {
      if(!isalive(var_3)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_3.damaged_by_players)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_3.marked_for_challenge)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_3.marked_by_hybrid)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_3.feral_occludes)) {
        wait(0.2);
        continue;
      }

      scripts\cp\cp_outline::enable_outline_for_players(var_3, level.players, 4, 0, 0, "high");
      if(var_4 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.2);
  }
}

deactivate_outline_enemies(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);
  foreach(var_3 in level.players) {
    var_3.has_outline_on = undefined;
    var_3 scripts\cp\cp_outline::unset_outline();
  }
}

give_infinite_grenade(var_0, var_1, var_2) {
  level notify("activated" + var_0);
  level endon("activated" + var_0);
  level endon("deactivated" + var_0);
  level notify("infinite_grenade_active");
  level.infinite_grenades = 1;
  level thread deactivate_infinite_grenade(var_0, var_1);
  level.active_power_ups["infinite_grenades"] = 1;
  foreach(player in level.players) {
    thread apply_infinite_grenade_effects(player);
  }
}

apply_fire_sale_effects(var_0) {
  if(isDefined(level.temporal_increase)) {
    var_0 thread power_icon_active(30 * level.temporal_increase, "fire_30");
    return;
  }

  var_0 thread power_icon_active(30, "fire_30");
}

apply_infinite_grenade_effects(var_0) {
  var_0.power_cooldowns = 1;
  var_0.has_infinite_grenade = 1;
  var_0 scripts\cp\powers\coop_powers::power_adjustcharges(1, "primary", 1);
  if(isDefined(level.temporal_increase)) {
    var_0 thread power_icon_active(30 * level.temporal_increase, "grenade_30");
    return;
  }

  var_0 thread power_icon_active(30, "grenade_30");
}

deactivate_infinite_grenade(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0, "activated" + var_0);
  if(var_2 != "activated" + var_0) {
    level.active_power_ups["infinite_grenades"] = 0;
    level notify("deactivated" + var_0);
    foreach(var_4 in level.players) {
      var_4 scripts\cp\powers\coop_powers::power_adjustcharges(undefined, "primary", 1);
      var_4.has_infinite_grenade = undefined;
      var_4.power_cooldowns = 0;
    }

    level.infinite_grenades = undefined;
  }
}

give_infinite_ammo(var_0, var_1, var_2) {
  level notify("activated" + var_0);
  level endon("activated" + var_0);
  level endon("deactivated" + var_0);
  level notify("infinite_ammo_active");
  level.infinite_ammo = 1;
  level.active_power_ups["infinite_ammo"] = 1;
  level thread deactivate_infinite_ammo(var_0, var_1);
  foreach(var_4 in level.players) {
    thread apply_infinite_ammo_effects(var_4);
  }
}

apply_infinite_ammo_effects(var_0) {
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("powerup_ammo", "zmb_comment_vo");
  var_0.has_infinite_ammo = 1;
  var_1 = var_0 ammo_round_up();
  var_0 thread unlimited_ammo(var_1, "infinite_20");
  if(isDefined(level.temporal_increase)) {
    var_0 thread power_icon_active(20 * level.temporal_increase, "infinite_20");
    return;
  }

  var_0 thread power_icon_active(20, "infinite_20");
}

deactivate_infinite_ammo(var_0, var_1) {
  level endon("disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0, "activated" + var_0);
  if(var_2 != "activated" + var_0) {
    level.active_power_ups["infinite_ammo"] = 0;
    level.infinite_ammo = undefined;
    level notify("deactivated" + var_0);
    foreach(var_4 in level.players) {
      var_4.has_infinite_ammo = undefined;
    }
  }

  foreach(var_4 in level.players) {
    if(var_4 scripts\cp\utility::isinfiniteammoenabled()) {
      var_4 scripts\cp\utility::enable_infinite_ammo(0);
    }
  }
}

give_left_powers(var_0, var_1, var_2) {
  level endon("deactivated" + var_0);
  level endon("disconnect");
  level endon("game_ended");
  var_3 = undefined;
  level.secondary_power = 1;
  var_4 = scripts\engine\utility::random(["power_speedBoost", "power_siegeMode", "power_barrier", "power_mortarMount", "power_transponder"]);
  for(;;) {
    foreach(var_6 in level.players) {
      if(!scripts\engine\utility::istrue(var_6.has_left_power)) {
        var_6.has_left_power = 1;
        var_7 = var_1 - gettime() - var_2 / 1000;
        var_3 = var_6 scripts\cp\powers\coop_powers::what_power_is_in_slot("secondary");
        var_6 thread scripts\cp\powers\coop_powers::givepower(var_4, "secondary", undefined, undefined, undefined, undefined, 1);
        var_6 scripts\cp\powers\coop_powers::power_modifycooldownrate(10, "secondary");
        var_6 thread additional_ability_hint(var_0, var_7);
        var_6 thread power_icon_active(var_7, var_0);
        var_6 thread deactivate_left_power(var_7, var_3, var_4, var_0);
      }
    }

    wait(0.25);
  }
}

additional_ability_hint(var_0, var_1) {
  level endon("deactivated" + var_0);
  level endon("disconnect");
  level endon("game_ended");
  self endon("disconnect");
  self endon("lb_power_used");
  self.additional_ability_hint_display = 0;
  var_2 = var_1 / 3;
  self notifyonplayercommand("lb_power_used", "+speed_throw");
  while(self.additional_ability_hint_display > 3) {
    if(!isalive(self)) {
      wait(0.5);
      continue;
    }

    scripts\cp\utility::setlowermessage("msg_axe_hint", &"CP_ZOMBIE_ADD_ABILITY__HINT", 5);
    self.additional_ability_hint_display++;
    wait(var_2);
  }
}

deactivate_left_power(var_0, var_1, var_2, var_3) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout(var_0, "deactivated" + var_3);
  self.has_left_power = undefined;
  self.additional_ability_hint_display = undefined;
  level.secondary_power = undefined;
  level notify("deactivated" + var_3);
  scripts\cp\powers\coop_powers::removepower(var_2);
  if(isDefined(var_1)) {
    thread scripts\cp\powers\coop_powers::givepower(var_1, "secondary", undefined, undefined, undefined, undefined, 0);
  }
}

give_ammo() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
      continue;
    }

    give_max_ammo_to_player(var_1);
  }
}

give_max_ammo_to_player(var_0) {
  var_1 = var_0 getweaponslistprimaries();
  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "_");
    if(var_4[0] != "alt") {
      var_0 givemaxammo(var_3);
    }

    if(weaponmaxammo(var_3) == weaponclipsize(var_3)) {
      var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
    }
  }

  var_6 = getarraykeys(var_0.powers);
  foreach(var_8 in var_6) {
    if(var_0.powers[var_8].slot == "secondary") {
      continue;
    }

    var_0 thread recharge_power(var_8);
  }
}

recharge_power(var_0) {
  var_1 = 0;
  var_2 = self.powers[var_0].slot;
  var_3 = level.powers[var_0].maxcharges - self.powers[var_0].charges;
  scripts\cp\powers\coop_powers::power_adjustcharges(var_3, var_2);
  self setweaponammostock(level.powers[var_0].weaponuse, level.powers[var_0].maxcharges);
}

activate_instakill(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level notify("activated" + var_1);
  level endon("deactivated" + var_1);
  level.insta_kill = 1;
  level thread deactivate_instakill(var_1, var_2);
  level.active_power_ups["instakill"] = 1;
  foreach(var_5 in level.players) {
    thread apply_instakill_effects(var_5);
  }
}

apply_instakill_effects(var_0) {
  var_0.instakill = 1;
  if(isDefined(level.temporal_increase)) {
    var_0 thread power_icon_active(30 * level.temporal_increase, "instakill_30");
    return;
  }

  var_0 thread power_icon_active(30, "instakill_30");
}

deactivate_instakill(var_0, var_1) {
  level endon("game_ended");
  level endon("activated" + var_0);
  scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0);
  level notify("deactivated" + var_0);
  foreach(var_3 in level.players) {
    var_3.instakill = undefined;
  }

  level.insta_kill = undefined;
  level.active_power_ups["instakill"] = 0;
}

scale_earned_cash(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("deactivated" + var_1);
  level notify("scale_earned_cash");
  level endon("scale_earned_cash");
  level.active_power_ups["double_money"] = 1;
  level.cash_scalar = 2;
  if(isDefined(level.temporal_increase)) {
    level thread deactivate_scaled_cash(var_1, 30 * level.temporal_increase, var_2);
  } else {
    level thread deactivate_scaled_cash(var_1, 30, var_2);
  }

  foreach(var_5 in level.players) {
    thread apply_double_money_effects(var_5);
  }
}

apply_double_money_effects(var_0) {
  var_0.double_money = 1;
  if(isDefined(level.temporal_increase)) {
    var_0 thread power_icon_active(30 * level.temporal_increase, "cash_2");
    return;
  }

  var_0 thread power_icon_active(30, "cash_2");
}

deactivate_scaled_cash(var_0, var_1, var_2) {
  level endon("disconnect");
  level endon("game_ended");
  var_3 = scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0, "activated" + var_0);
  if(var_3 != "activated" + var_0) {
    level notify("deactivated" + var_0);
    level.cash_scalar = 1;
    level.active_power_ups["double_money"] = 0;
    foreach(var_5 in level.players) {
      var_5.double_money = undefined;
    }
  }
}

power_icon_active(var_0, var_1) {
  level notify("power_icon_active_" + var_1);
  level endon("power_icon_active_" + var_1);
  var_2 = level.loot_icon[var_1];
  self.powerupicons[var_1] = var_2;
  var_3 = set_ui_omnvar_for_powerups(var_1);
  thread hide_power_icon(var_0, var_1, var_3);
}

set_ui_omnvar_for_powerups(var_0) {
  var_1 = int(tablelookup(level.power_up_table, 2, var_0, 1));
  var_2 = int(var_1);
  self setclientomnvarbit("zm_active_powerups", var_2 - 1, 1);
  return var_2;
}

display_powerup_popup(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclientomnvar("zm_powerup_activated", var_0);
    wait(0.05);
  }
}

get_fx_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = scripts\engine\utility::getstructarray(var_1, var_2);
  var_6[var_6.size] = var_0;
  foreach(var_8 in var_6) {
    var_9 = scripts\engine\utility::get_array_of_closest(var_8.origin, level.players, undefined, 1, var_4, 1);
    if(var_9.size >= 1) {
      if(!isDefined(var_8.angles)) {
        var_8.angles = (0, 0, 0);
      }

      var_10 = scripts\engine\utility::spawn_tag_origin(var_8.origin, var_8.angles);
      var_10 show();
      var_10.origin = var_8.origin;
      var_10.angles = var_8.angles;
      var_5[var_5.size] = var_10;
      if(isDefined(var_3)) {
        if(var_5.size >= var_3) {
          break;
        }
      }
    }
  }

  var_5 = sortbydistance(var_5, var_0.origin);
  return var_5;
}

kill_closest_enemies(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_0.origin;
  var_3 = get_fx_points(var_0, "effect_loc", "targetname", undefined, 1500);
  wait(1);
  playsoundatpos(var_2, "zmb_powerup_nuke_explo");
  level thread nuke_fx(var_0, var_3);
  scripts\engine\utility::waitframe();
  playrumbleonposition("heavy_3s", var_2);
  earthquake(0.25, 4, var_2, 2500);
  scripts\engine\utility::waitframe();
  var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_6 in level.players) {
    var_6 scripts\cp\utility::adddamagemodifier("nuke", 0, 0);
  }

  var_8 = sortbydistance(var_4, var_2);
  var_9 = 400;
  if(isDefined(level.cash_scalar)) {
    var_9 = 400 * level.cash_scalar;
  }

  foreach(var_11 in var_8) {
    if(is_immune_against_nuke(var_11)) {
      continue;
    }

    if(scripts\engine\utility::istrue(level.forced_nuke)) {
      var_11.died_poorly = 1;
      var_11.died_poorly_health = var_11.health;
    }

    if(scripts\engine\utility::istrue(var_11.isfrozen)) {
      var_11 dodamage(var_11.health + 100, var_11.origin);
    } else {
      var_11.precacheleaderboards = 1;
      var_11.is_burning = 1;
      var_11.nocorpse = undefined;
      var_11 thread kill_selected_enemy(1);
    }

    wait(0.1);
  }

  level.nuke_zombies_paused = 1;
  wait(5);
  level.nuke_zombies_paused = 0;
  level.dont_resume_wave_after_solo_afterlife = undefined;
  foreach(var_6 in level.players) {
    var_6 scripts\cp\utility::removedamagemodifier("nuke", 0);
    if(!scripts\engine\utility::istrue(level.forced_nuke)) {
      if(!scripts\cp\cp_laststand::player_in_laststand(var_6)) {
        var_6 scripts\cp\cp_persistence::give_player_currency(var_9, undefined, undefined, 1, "nuke");
      }
    }
  }

  level.forced_nuke = undefined;
}

is_immune_against_nuke(var_0) {
  return scripts\engine\utility::istrue(var_0.immune_against_nuke);
}

nuke_fx(var_0, var_1) {
  var_2 = 0;
  foreach(var_4 in var_1) {
    foreach(var_6 in level.players) {
      if(!var_6 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_6.in_afterlife_arcade)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_6.is_off_grid)) {
        continue;
      }

      playfxontagforclients(level._effect["big_explo"], var_4, "tag_origin", var_6);
    }

    scripts\engine\utility::waitframe();
  }

  wait(5);
  foreach(var_4 in var_1) {
    foreach(var_6 in level.players) {
      stopfxontagforclients(level._effect["big_explo"], var_4, "tag_origin", var_6);
    }

    var_4 delete();
    scripts\engine\utility::waitframe();
  }
}

kill_selected_enemy(var_0) {
  self endon("death");
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  self.marked_for_death = 1;
  var_1 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(var_0)) {
    if(isalive(self) && !var_1) {
      playFX(level._effect["head_loss"], self gettagorigin("j_neck"));
      self setscriptablepartstate("head", "detached", 1);
      self setscriptablepartstate("eyes", "eye_glow_off", 1);
    }
  } else {
    wait(1);
  }

  self dodamage(self.health, self.origin);
}

give_money(var_0, var_1) {
  var_0 iprintlnbold("Got Loot: $" + var_1);
  var_0 scripts\cp\cp_persistence::give_player_currency(var_1);
}

flash_power_icon(var_0, var_1, var_2) {
  var_2 endon("remove " + var_1 + " icon");
  var_2 endon("death");
  var_2 endon("disconnect");
  level endon("game_ended");
  var_3 = 10;
  var_4 = 0.2;
  wait(var_0 - 5);
  var_0 = 5;
  for(;;) {
    wait(var_0 / var_3);
    self.alpha = 0.1;
    wait(var_4);
    self.alpha = 0.75;
    if(float(var_3 * 1.5) > var_4) {
      var_3 = float(var_3 * 1.5);
      continue;
    }

    var_3 = var_4;
  }
}

hide_power_icon(var_0, var_1, var_2, var_3) {
  level endon("activated" + var_1);
  self endon("remove_carryIcon" + var_1);
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  var_4 = 5.5;
  var_0 = var_0 - var_4;
  self setclientomnvarbit("zm_active_powerup_animation", var_2 - 1, 0);
  if(var_0 > 0) {
    level scripts\engine\utility::waittill_any_timeout(var_0, "deactivated" + var_1);
    self setclientomnvarbit("zm_active_powerup_animation", var_2 - 1, 1);
  }

  level scripts\engine\utility::waittill_any_timeout(var_4, "deactivated" + var_1);
  level notify("power_up_deactivated");
  if(isDefined(self.powerupicons[var_1])) {
    self.powerupicons[var_1] = undefined;
  }

  self notify("remove " + var_1 + " icon");
  self setclientomnvarbit("zm_active_powerups", var_2 - 1, 0);
  self setclientomnvarbit("zm_active_powerup_animation", var_2 - 1, 0);
}

hidecarryiconongameend() {
  self endon("remove_carryIcon");
  level waittill("game_ended");
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
}

is_in_active_volume(var_0) {
  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  var_1 = sortbydistance(level.active_spawn_volumes, var_0);
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0, var_3)) {
      return 1;
    }
  }

  return 0;
}

ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  var_0 = [];
  foreach(var_2 in self.weaponlist) {
    var_0[var_2] = self getrunningforwardpainanim(var_2);
  }

  return var_0;
}

unlimited_ammo(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("deactivated" + var_1);
  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);
  for(;;) {
    var_2 = 0;
    foreach(var_4 in self.weaponlist) {
      if(var_4 == self getcurrentweapon() && weapon_no_unlimited_check(var_4)) {
        var_2 = 1;
        self setweaponammoclip(var_4, weaponclipsize(var_4), "left");
        self setclientomnvar("zm_ui_unlimited_ammo", 1);
      }

      if(var_4 == self getcurrentweapon() && weapon_no_unlimited_check(var_4)) {
        var_2 = 1;
        self setweaponammoclip(var_4, weaponclipsize(var_4), "right");
        self setclientomnvar("zm_ui_unlimited_ammo", 1);
      }

      if(var_2 == 0) {
        self setclientomnvar("zm_ui_unlimited_ammo", 0);
        ammo_round_up();
      }
    }

    wait(0.05);
  }
}

weapon_no_unlimited_check(var_0) {
  var_1 = 1;
  foreach(var_3 in level.opweaponsarray) {
    if(var_0 == var_3) {
      var_1 = 0;
    }
  }

  return var_1;
}

do_screen_flash() {
  scripts\engine\utility::waitframe();
  if(isDefined(self) && scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    playfxontagforclients(level._effect["vfx_screen_flash"], self, "tag_eye", self);
  }
}