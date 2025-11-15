/*******************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\loot.gsc
*******************************/

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
  var_00 = getarraykeys(level.active_power_ups);
  for(;;) {
    level waittill("connected", var_01);
    foreach(var_03 in var_00) {
      if(scripts\engine\utility::istrue(level.active_power_ups[var_03])) {
        if(isDefined(level.power_up_func[var_03])) {
          thread[[level.power_up_func[var_03]]](var_01);
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
    foreach(var_01 in level.players) {
      if(!scripts\engine\utility::istrue(var_01.checked)) {
        var_01.checked = 1;
        level.score_to_drop = level.score_to_drop + level.power_up_drop_score;
        if(var_01 scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
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
    var_00 = level.power_up_table;
  } else {
    var_00 = "cp\zombies\zombie_loot.csv";
  }

  for(var_01 = 1; var_01 <= 100; var_01++) {
    var_02 = table_look_up(var_00, var_01, 2);
    if(scripts\cp\utility::is_empty_string(var_02)) {
      break;
    }

    var_03 = [];
    var_03["weights"] = convert_to_float_array(table_look_up(var_00, var_01, 3));
    var_03["weight_sum"] = get_weight_sum(var_03["weights"]);
    var_04 = strtok(table_look_up(var_00, var_01, 4), " ");
    var_03["contents"] = [];
    foreach(var_08, var_06 in var_04) {
      var_07 = [];
      var_07["value"] = var_06;
      var_07["last_time"] = 0;
      var_03["contents"][var_08] = var_07;
    }

    level.loot_info[var_02] = var_03;
  }

  for(var_01 = 101; var_01 <= 150; var_01++) {
    var_09 = table_look_up(var_00, var_01, 2);
    if(scripts\cp\utility::is_empty_string(var_09)) {
      break;
    }

    var_0A = table_look_up(var_00, var_01, 3);
    if(!isDefined(level._effect[var_0A])) {
      level._effect[var_0A] = loadfx(var_0A);
    }

    level.loot_fx[var_09] = var_0A;
    var_0B = table_look_up(var_00, var_01, 1);
    level.loot_id[var_09] = var_0B;
  }

  for(var_01 = 101; var_01 <= 150; var_01++) {
    var_09 = table_look_up(var_00, var_01, 2);
    if(scripts\cp\utility::is_empty_string(var_09)) {
      break;
    }

    var_0C = table_look_up(var_00, var_01, 4);
    if(scripts\cp\utility::is_empty_string(var_0C)) {
      continue;
    }

    level.loot_icon[var_09] = var_0C;
  }
}

convert_to_float_array(param_00) {
  param_00 = strtok(param_00, " ");
  var_01 = [];
  for(var_02 = 0; var_02 < param_00.size; var_02++) {
    var_01[var_02] = float(param_00[var_02]);
  }

  return var_01;
}

get_weight_sum(param_00) {
  var_01 = 0;
  foreach(var_03 in param_00) {
    var_01 = var_01 + var_03;
  }

  return var_01;
}

drop_loot(location, from_consumable, powerup_id, should_fly_to_player, param_04, can_despawn) {
  if(powerup_id == "none") {
    return 0;
  }

  location = getclosestpointonnavmesh(location);
  fly_to_player = scripts\engine\utility::istrue(should_fly_to_player);
  var_07 = create_loot_model(location);
  if(!isDefined(var_07)) {
    return 0;
  }

  var_07.fnf_consumable_active = 0;
  foreach(var_09 in level.players) {
    if(var_09 scripts\cp\utility::is_consumable_active("temporal_increase")) {
      var_07.fnf_consumable_active = 1;
      break;
    }
  }

  var_07.content = powerup_id;
  var_0B = get_loot_fx(var_07);
  var_07.fxname = var_0B;
  var_0C = (0, 0, 0);
  if(isDefined(from_consumable) && from_consumable scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
    from_consumable scripts\cp\utility::notify_used_consumable("more_power_up_drops");
  }

  if(isDefined(param_04)) {
    level.powerup_drop_increment = level.powerup_drop_increment * 1.14;
    level.score_to_drop = param_04 + level.powerup_drop_increment;
    level.powerup_drop_count++;
    level.last_drop_time = gettime();
  }

  if(!is_in_active_volume(location) && loot_fly_to_player_enabled()) {
    location = moveeffecttoclosestplayer(var_07);
    var_07 thread loot_fx_handler();
    fly_to_player = 1;
  } else {
    location = location + (0, 0, 50);
    if(scripts\engine\utility::istrue(var_07.fnf_consumable_active)) {
      var_07.fnffx = spawnfx(level._effect["powerup_additive_fx"], location + (0, 0, -10));
    }

    var_07.fx = spawnfx(scripts\engine\utility::getfx(var_0B), location);
    if(isDefined(var_0C)) {
      var_07.fx.angles = var_0C;
    }
  }

  if(isDefined(from_consumable)) {
    var_07.triggerportableradarping = from_consumable;
  } else {
    var_07.triggerportableradarping = level.players[0];
  }

  var_07 notify("activate");
  if(!fly_to_player) {
    if(scripts\engine\utility::istrue(var_07.fnf_consumable_active)) {
      triggerfx(var_07.fnffx);
      var_07.fnffx setfxkilldefondelete();
    }

    triggerfx(var_07.fx);
    var_07.fx setfxkilldefondelete();
    var_07 thread loot_fx_handler();
  }

  var_07 thread loot_pick_up_monitor(var_07);
  var_07 thread loot_think(var_07);
  var_0D = get_index_for_powerup(powerup_id);
  if(isDefined(var_0D) && scripts\engine\utility::istrue(can_despawn)) {
    update_power_up_drop_time(var_0D);
  }

  level thread cleanuppowerup(var_07);
  return 1;
}

loot_fly_to_player_enabled() {
  if(scripts\engine\utility::istrue(level.disable_loot_fly_to_player)) {
    return 0;
  }

  return 1;
}

moveeffecttoclosestplayer(param_00) {
  level endon("game_ended");
  param_00.fx = spawn("script_model", param_00.origin + (0, 0, 50));
  param_00.fx setModel("tag_origin");
  wait(0.1);
  if(scripts\engine\utility::istrue(param_00.fnf_consumable_active)) {
    playFXOnTag(level._effect["powerup_additive_fx"], param_00.fx, "tag_origin");
  }

  playFXOnTag(scripts\engine\utility::getfx(param_00.fxname), param_00.fx, "tag_origin");
  var_01 = scripts\engine\utility::getclosest(param_00.origin, level.players);
  var_02 = distance(param_00.origin, var_01.origin);
  var_03 = 300;
  var_04 = var_02 / var_03;
  if(var_04 < 0.05) {
    var_04 = 0.05;
  }

  var_05 = getclosestpointonnavmesh(scripts\engine\utility::drop_to_ground(var_01.origin, 32, -100)) + (0, 0, 50);
  param_00.fx moveto(var_05, var_04);
  param_00.fx waittill("movedone");
  param_00 dontinterpolate();
  param_00.origin = param_00.fx.origin;
  return param_00.origin;
}

cleanuppowerup(param_00) {
  param_00 scripts\engine\utility::waittill_any_timeout_1(get_loot_time_out(), "picked_up");
  if(scripts\engine\utility::istrue(param_00.fnf_consumable_active)) {
    playFX(level._effect["pickup_fnfmod"], param_00.origin + (0, 0, 50));
  } else {
    playFX(level._effect["pickup"], param_00.origin + (0, 0, 50));
  }

  if(isDefined(param_00.fx)) {
    param_00.fx delete();
  }

  if(isDefined(param_00.fnffx)) {
    param_00.fnffx delete();
  }

  wait(0.5);
  param_00.fnf_consumable_active = 0;
  if(isDefined(param_00)) {
    param_00 delete();
  }

  param_00 notify("loot_deleted");
}

loot_fx_handler() {
  self endon("death");
  self endon("picked_up");
  self endon("loot_deleted");
  var_00 = get_loot_time_out() - 5;
  wait(var_00);
  for(var_01 = 0; var_01 < 5; var_01++) {
    wait(0.5);
    self.fx delete();
    wait(0.5);
    var_02 = get_loot_fx(self);
    var_03 = scripts\engine\utility::getfx(var_02);
    if(!isDefined(var_03)) {
      continue;
    }

    self.fx = spawnfx(var_03, self.origin + (0, 0, 50));
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

get_index_for_powerup(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = "kill_generic_zombie";
  }

  var_02 = 0;
  var_03 = level.loot_info[param_01]["contents"].size;
  for(var_02 = 0; var_02 < var_03; var_02++) {
    if(level.loot_info[param_01]["contents"][var_02]["value"] == param_00) {
      return var_02;
    }
  }

  return 0;
}

monitor_health(param_00) {
  self endon("loot_deleted");
  level endon("game_ended");
  while(isDefined(param_00) && isDefined(param_00.health) && param_00.health >= 1) {
    level waittill("attack_hit", var_01, var_02);
    if(param_00 != var_02) {
      continue;
    }

    param_00.health = param_00.health - 50;
  }

  self notify("picked_up");
}

create_loot_model(param_00) {
  var_01 = scripts\engine\utility::drop_to_ground(param_00, 32, -64);
  var_02 = spawn("trigger_radius", var_01, 0, 32, 76);
  return var_02;
}

get_loot_fx(param_00) {
  if(!isDefined(level.loot_fx[param_00.content])) {
    return "vfx_loot_ace_hearts";
  }

  return level.loot_fx[param_00.content];
}

loot_think(param_00) {
  param_00 endon("loot_deleted");
  var_01 = param_00 scripts\engine\utility::waittill_any_timeout_1(get_loot_time_out(), "picked_up");
  if(var_01 == "picked_up") {
    thread process_loot_content(param_00.triggerportableradarping, param_00.content, param_00, 1);
  }
}

loot_pick_up_monitor(param_00) {
  param_00 endon("loot_deleted");
  wait(0.2);
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isplayer(var_01)) {
      wait(0.25);
      continue;
    }

    param_00 notify("picked_up");
    var_01 playlocalsound("zmb_powerup_activate");
    break;
  }
}

process_loot_content(powerupName, param_01, param_02, param_03) {
  var_04 = param_01;
  param_01 = strtok(param_01, "_");
  var_05 = param_01[0];
  var_06 = param_01[1];
  var_07 = gettime();
  var_08 = int(level.loot_id[var_04]);
  var_09 = 1;
  display_powerup_popup(0);
  switch (var_05) {
    case "power":
      level thread[[level.power_off_func]](var_04, var_07);
      break;

    case "fire":
      if(isDefined(level.fire_sale_func)) {
        if(isDefined(level.temporal_increase)) {
          var_06 = int(var_06) * level.temporal_increase;
        }

        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_firesale", "zmb_powerup_vo");
        param_02 playSound("zmb_powerup_fire_sale");
        level thread[[level.fire_sale_func]](var_04, int(var_06), var_07);
      }
      break;

    case "grenade":
      if(isDefined(level.temporal_increase)) {
        var_06 = int(var_06) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_infinitegrenades", "zmb_powerup_vo");
      param_02 playSound("zmb_powerup_infinite_grenades");
      level thread give_infinite_grenade(var_04, int(var_06), var_07);
      break;

    case "infinite":
      if(isDefined(level.temporal_increase)) {
        var_06 = int(var_06) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_infiniteammo", "zmb_powerup_vo");
      param_02 playSound("zmb_powerup_infinite_ammo");
      level thread give_infinite_ammo(var_04, int(var_06), var_07);
      break;

    case "upgrade":
      if(isDefined(level.upgrade_weapons_func)) {
        param_02 playSound("zmb_powerup_wpn_upgrade");
        level thread[[level.upgrade_weapons_func]]();
      }
      break;

    case "kill":
      if(scripts\engine\utility::istrue(level.forced_nuke)) {
        var_09 = 0;
        level thread kill_closest_enemies(param_02, int(var_06));
      } else {
        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_nuke", "zmb_powerup_vo");
        param_02 playSound("zmb_powerup_nuke");
        level thread kill_closest_enemies(param_02, int(var_06));
      }
      break;

    case "cash":
      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_doublemoney", "zmb_powerup_vo");
      param_02 playSound("zmb_powerup_dbl_cash");
      level thread scale_earned_cash(powerupName, var_04, int(var_06), var_07);
      break;

    case "instakill":
      if(isDefined(level.temporal_increase)) {
        var_06 = int(var_06) * level.temporal_increase;
      }

      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_instakill", "zmb_powerup_vo");
      param_02 playSound("zmb_powerup_instakill");
      level thread activate_instakill(powerupName, var_04, int(var_06), var_07);
      break;

    case "ammo":
      level thread scripts\cp\cp_vo::try_to_play_vo("powerup_maxammo", "zmb_powerup_vo");
      param_02 playSound("zmb_powerup_max_ammo");
      level notify("pick_up_max_ammo");
      level thread give_ammo();
      break;

    case "board":
      if(isDefined(level.rebuild_all_windows_func)) {
        level thread scripts\cp\cp_vo::try_to_play_vo("powerup_carpenter", "zmb_powerup_vo");
        param_02 playSound("zmb_powerup_reboard_windows");
        level thread[[level.rebuild_all_windows_func]](powerupName);
      }
      break;

    default:
      break;
  }

  if(scripts\engine\utility::istrue(param_03)) {
    powerupName scripts\cp\cp_merits::processmerit("mt_powerup_grabs");
  }

  powerupName thread scripts\cp\cp_hud_message::tutorial_lookup_func("powerups");
  scripts\engine\utility::waitframe();
  if(var_09) {
    display_powerup_popup(var_08);
  }
}

get_loot_content(param_00, param_01, param_02) {
  if(!isDefined(level.loot_info[param_00])) {
    return undefined;
  }

  var_03 = gettime();
  var_04 = choose_powerup(param_00, var_03, param_01);
  return var_04;
}

choose_powerup(param_00, param_01, param_02) {
  var_03 = level.wave_num;
  var_04 = level.loot_info[param_00]["contents"].size;
  level.allowed_powerups = [];
  for(var_05 = 0; var_05 < var_04; var_05++) {
    var_06 = level.loot_info[param_00]["contents"][var_05]["value"];
    var_07 = level.loot_info[param_00]["contents"][var_05]["last_time"];
    var_06 = strtok(var_06, "_");
    var_08 = var_06[0];
    switch (var_08) {
      case "fire":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || scripts\engine\utility::flag("canFiresale") && param_01 - var_07 >= 180000) && var_03 >= 5) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "explosive":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 300000) && var_03 >= 8) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "infinite":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 180000) && var_03 >= 5) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "ammo":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 180000) && var_03 >= 2) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "grenade":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= -5536) && var_03 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "upgrade":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 600000) && var_03 >= 15) {
          if(!scripts\cp\utility::is_codxp()) {
            level.allowed_powerups[level.allowed_powerups.size] = var_05;
          }

          break;
        } else {
          break;
        }

        break;

      case "kill":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 180000) && var_03 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "cash":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 90000) && var_03 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "instakill":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= 90000) && var_03 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
          break;
        } else {
          break;
        }

        break;

      case "board":
        if((scripts\engine\utility::istrue(level.power_up_drop_override) || param_01 - var_07 >= -20536) && var_03 >= 1) {
          level.allowed_powerups[level.allowed_powerups.size] = var_05;
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

  var_09 = level.allowed_powerups[get_loot_index_based_on_weights(param_00)];
  var_0A = level.loot_info[param_00]["contents"][var_09]["value"];
  level.allowed_powerups = undefined;
  level.last_loot_drop = var_09;
  return var_0A;
}

get_loot_index_based_on_weights(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.allowed_powerups.size; var_02++) {
    var_03 = int(level.allowed_powerups[var_02]);
    var_01 = var_01 + level.loot_info[param_00]["weights"][var_03];
  }

  var_04 = randomfloat(var_01);
  var_05 = 0;
  for(var_02 = 0; var_02 < level.allowed_powerups.size; var_02++) {
    var_03 = int(level.allowed_powerups[var_02]);
    var_05 = var_05 + level.loot_info[param_00]["weights"][var_03];
    if(var_05 >= var_04) {
      return var_02;
    }
  }
}

table_look_up(param_00, param_01, param_02) {
  return tablelookup(param_00, 0, param_01, param_02);
}

update_enemy_killed_event(param_00, param_01, param_02) {
  if(!scripts\cp\utility::coop_mode_has("loot")) {
    return;
  }

  if(!isDefined(level.loot_func)) {
    return;
  }

  if(!scripts\engine\utility::flag("zombie_drop_powerups")) {
    return;
  }

  if(!isplayer(param_02)) {
    return;
  }

  var_04 = scripts\engine\utility::istrue(level.power_up_drop_override);
  if(level.powerup_drop_count >= level.powerup_drop_max_per_round && !var_04) {
    return;
  }

  if(!is_in_active_volume(param_01)) {
    return;
  }

  if(scripts\engine\utility::istrue(self.is_suicide_bomber)) {
    return;
  }

  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(param_01, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(param_01, undefined, undefined, undefined, 1)) {
    return;
  }

  var_05 = level.players;
  var_03 = undefined;
  var_06 = 0;
  if(param_02 scripts\cp\utility::is_consumable_active("more_power_up_drops")) {
    var_07 = level.score_to_drop * 0.7;
  } else {
    var_07 = level.score_to_drop;
  }

  for(var_08 = 0; var_08 < var_05.size; var_08++) {
    if(isDefined(var_05[var_08].total_currency_earned)) {
      var_06 = var_06 + var_05[var_08].total_currency_earned;
    }
  }

  var_09 = 0;
  if(var_06 > var_07 && !var_09) {
    var_03 = get_loot_content("kill_" + param_00, param_01);
  }

  if(isDefined(var_03)) {
    level thread drop_loot(param_01, param_02, var_03, undefined, var_06, 1);
  }
}

update_power_up_drop_time(param_00) {
  var_01 = gettime();
  level.loot_info["kill_generic_zombie"]["contents"][param_00]["last_time"] = var_01;
}

give_explosive_armor(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("deactivated" + param_00);
  scripts\engine\utility::flag_set("explosive_armor");
  level thread deactivate_explosive_armor(param_00, param_01);
  level thread player_connect_monitor(param_00, ::give_player_explosive_armor);
  level thread player_spawn_monitor(param_00, ::give_player_explosive_armor);
  level thread give_explosive_touch_on_revived(param_00, ::give_player_explosive_armor);
  level.explosive_touch = 1;
  foreach(var_04 in level.players) {
    if(!isalive(var_04) || scripts\engine\utility::istrue(var_04.inlaststand)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_04.has_explosive_armor)) {
      thread give_player_explosive_armor(var_04, param_00);
    }
  }
}

give_player_explosive_armor(param_00, param_01) {
  param_00.has_explosive_armor = 1;
  param_00 thread power_icon_active(undefined, param_01);
  param_00 thread create_explosive_shield();
  param_00 thread damage_enemies_in_radius();
  param_00 thread remove_explosive_touch(param_01);
  param_00 thread remove_explosive_touch_on_death(param_00);
}

player_connect_monitor(param_00, param_01) {
  level endon("deactivated" + param_00);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("connected", var_02);
    thread[[param_01]](var_02, param_00);
  }
}

player_spawn_monitor(param_00, param_01) {
  level endon("deactivated" + param_00);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("player_spawned", var_02);
    thread[[param_01]](var_02, param_00);
  }
}

give_explosive_touch_on_revived(param_00, param_01) {
  level endon("deactivated" + param_00);
  level endon("game_ended");
  while(scripts\engine\utility::flag("explosive_armor")) {
    level waittill("revive_success", var_02);
    thread[[param_01]](var_02, param_00);
  }
}

remove_explosive_touch(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  scripts\engine\utility::flag_waitopen("explosive_armor");
  self.has_explosive_armor = undefined;
  self setscriptablepartstate("exp_touch", "neutral", 0);
  self notify("explosive_armor_removed");
  self notify("remove_power_icon" + param_00);
}

remove_explosive_touch_on_death(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("explosive_armor_removed");
  param_00 scripts\engine\utility::waittill_any_3("death", "last_stand");
  param_00.has_explosive_armor = undefined;
  param_00 setscriptablepartstate("exp_touch", "neutral", 0);
  param_00 notify("explosive_armor_removed");
}

deactivate_explosive_armor(param_00, param_01) {
  level endon("disconnect");
  level endon("game_ended");
  param_01 = param_01 - 5.5;
  scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00);
  level notify("deactivated" + param_00);
  wait(5.5);
  scripts\engine\utility::flag_clear("explosive_armor");
  level.explosive_touch = undefined;
  foreach(var_03 in level.players) {
    var_03.has_explosive_armor = undefined;
  }
}

damage_enemies_in_radius() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("last_stand");
  self endon("explosive_armor_removed");
  for(var_00 = gettime(); scripts\engine\utility::flag("explosive_armor"); var_00 = gettime()) {
    var_01 = scripts\engine\utility::get_array_of_closest(self.origin, level.spawned_enemies, undefined, undefined, 128, 1);
    foreach(var_03 in var_01) {
      if(isalive(var_03)) {
        if(!isDefined(var_03.explosive_touch_time) || gettime() > var_03.explosive_touch_time) {
          var_03.explosive_touch_time = var_00 + 1000;
          var_03 dodamage(100, self.origin, self, self, "MOD_UNKNOWN", "power_script_generic_primary_mp");
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

outline_enemies(param_00, param_01, param_02) {
  level endon("deactivated" + param_00);
  level thread deactivate_outline_enemies(param_00, param_01);
  level thread outline_all_enemies(param_00);
  for(;;) {
    foreach(var_04 in level.players) {
      if(!scripts\engine\utility::istrue(var_04.has_outline_on)) {
        var_04.has_outline_on = 1;
        var_05 = param_01 - gettime() - param_02 / 1000;
        var_04 thread power_icon_active(var_05, param_00);
      }
    }

    wait(0.25);
  }
}

outline_all_enemies(param_00) {
  level endon("game_ended");
  level endon("host_migration_begin");
  level endon("deactivated" + param_00);
  for(;;) {
    var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    foreach(var_04, var_03 in var_01) {
      if(!isalive(var_03)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_03.damaged_by_players)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_03.marked_for_challenge)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_03.marked_by_hybrid)) {
        wait(0.2);
        continue;
      }

      if(isDefined(var_03.feral_occludes)) {
        wait(0.2);
        continue;
      }

      scripts\cp\cp_outline::enable_outline_for_players(var_03, level.players, 4, 0, 0, "high");
      if(var_04 % 2 == 0) {
        wait(0.05);
      }
    }

    wait(0.2);
  }
}

deactivate_outline_enemies(param_00, param_01) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00);
  level notify("deactivated" + param_00);
  foreach(var_03 in level.players) {
    var_03.has_outline_on = undefined;
    var_03 scripts\cp\cp_outline::unset_outline();
  }
}

give_infinite_grenade(param_00, param_01, param_02) {
  level notify("activated" + param_00);
  level endon("activated" + param_00);
  level endon("deactivated" + param_00);
  level notify("infinite_grenade_active");
  level.infinite_grenades = 1;
  level thread deactivate_infinite_grenade(param_00, param_01);
  level.active_power_ups["infinite_grenades"] = 1;
  foreach(player in level.players) {
    thread apply_infinite_grenade_effects(player);
  }
}

apply_fire_sale_effects(param_00) {
  if(isDefined(level.temporal_increase)) {
    param_00 thread power_icon_active(30 * level.temporal_increase, "fire_30");
    return;
  }

  param_00 thread power_icon_active(30, "fire_30");
}

apply_infinite_grenade_effects(param_00) {
  param_00.power_cooldowns = 1;
  param_00.has_infinite_grenade = 1;
  param_00 scripts\cp\powers\coop_powers::power_adjustcharges(1, "primary", 1);
  if(isDefined(level.temporal_increase)) {
    param_00 thread power_icon_active(30 * level.temporal_increase, "grenade_30");
    return;
  }

  param_00 thread power_icon_active(30, "grenade_30");
}

deactivate_infinite_grenade(param_00, param_01) {
  level endon("disconnect");
  level endon("game_ended");
  var_02 = scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00, "activated" + param_00);
  if(var_02 != "activated" + param_00) {
    level.active_power_ups["infinite_grenades"] = 0;
    level notify("deactivated" + param_00);
    foreach(var_04 in level.players) {
      var_04 scripts\cp\powers\coop_powers::power_adjustcharges(undefined, "primary", 1);
      var_04.has_infinite_grenade = undefined;
      var_04.power_cooldowns = 0;
    }

    level.infinite_grenades = undefined;
  }
}

give_infinite_ammo(param_00, param_01, param_02) {
  level notify("activated" + param_00);
  level endon("activated" + param_00);
  level endon("deactivated" + param_00);
  level notify("infinite_ammo_active");
  level.infinite_ammo = 1;
  level.active_power_ups["infinite_ammo"] = 1;
  level thread deactivate_infinite_ammo(param_00, param_01);
  foreach(var_04 in level.players) {
    thread apply_infinite_ammo_effects(var_04);
  }
}

apply_infinite_ammo_effects(param_00) {
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("powerup_ammo", "zmb_comment_vo");
  param_00.has_infinite_ammo = 1;
  var_01 = param_00 ammo_round_up();
  param_00 thread unlimited_ammo(var_01, "infinite_20");
  if(isDefined(level.temporal_increase)) {
    param_00 thread power_icon_active(20 * level.temporal_increase, "infinite_20");
    return;
  }

  param_00 thread power_icon_active(20, "infinite_20");
}

deactivate_infinite_ammo(param_00, param_01) {
  level endon("disconnect");
  level endon("game_ended");
  var_02 = scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00, "activated" + param_00);
  if(var_02 != "activated" + param_00) {
    level.active_power_ups["infinite_ammo"] = 0;
    level.infinite_ammo = undefined;
    level notify("deactivated" + param_00);
    foreach(var_04 in level.players) {
      var_04.has_infinite_ammo = undefined;
    }
  }

  foreach(var_04 in level.players) {
    if(var_04 scripts\cp\utility::isinfiniteammoenabled()) {
      var_04 scripts\cp\utility::enable_infinite_ammo(0);
    }
  }
}

give_left_powers(param_00, param_01, param_02) {
  level endon("deactivated" + param_00);
  level endon("disconnect");
  level endon("game_ended");
  var_03 = undefined;
  level.secondary_power = 1;
  var_04 = scripts\engine\utility::random(["power_speedBoost", "power_siegeMode", "power_barrier", "power_mortarMount", "power_transponder"]);
  for(;;) {
    foreach(var_06 in level.players) {
      if(!scripts\engine\utility::istrue(var_06.has_left_power)) {
        var_06.has_left_power = 1;
        var_07 = param_01 - gettime() - param_02 / 1000;
        var_03 = var_06 scripts\cp\powers\coop_powers::what_power_is_in_slot("secondary");
        var_06 thread scripts\cp\powers\coop_powers::givepower(var_04, "secondary", undefined, undefined, undefined, undefined, 1);
        var_06 scripts\cp\powers\coop_powers::power_modifycooldownrate(10, "secondary");
        var_06 thread additional_ability_hint(param_00, var_07);
        var_06 thread power_icon_active(var_07, param_00);
        var_06 thread deactivate_left_power(var_07, var_03, var_04, param_00);
      }
    }

    wait(0.25);
  }
}

additional_ability_hint(param_00, param_01) {
  level endon("deactivated" + param_00);
  level endon("disconnect");
  level endon("game_ended");
  self endon("disconnect");
  self endon("lb_power_used");
  self.additional_ability_hint_display = 0;
  var_02 = param_01 / 3;
  self notifyonplayercommand("lb_power_used", "+speed_throw");
  while(self.additional_ability_hint_display > 3) {
    if(!isalive(self)) {
      wait(0.5);
      continue;
    }

    scripts\cp\utility::setlowermessage("msg_axe_hint", & "CP_ZOMBIE_ADD_ABILITY__HINT", 5);
    self.additional_ability_hint_display++;
    wait(var_02);
  }
}

deactivate_left_power(param_00, param_01, param_02, param_03) {
  level endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_1(param_00, "deactivated" + param_03);
  self.has_left_power = undefined;
  self.additional_ability_hint_display = undefined;
  level.secondary_power = undefined;
  level notify("deactivated" + param_03);
  scripts\cp\powers\coop_powers::removepower(param_02);
  if(isDefined(param_01)) {
    thread scripts\cp\powers\coop_powers::givepower(param_01, "secondary", undefined, undefined, undefined, undefined, 0);
  }
}

give_ammo() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_01)) {
      continue;
    }

    give_max_ammo_to_player(var_01);
  }
}

give_max_ammo_to_player(param_00) {
  var_01 = param_00 getweaponslistprimaries();
  foreach(var_03 in var_01) {
    var_04 = strtok(var_03, "_");
    if(var_04[0] != "alt") {
      param_00 givemaxammo(var_03);
    }

    if(weaponmaxammo(var_03) == weaponclipsize(var_03)) {
      param_00 setweaponammoclip(var_03, weaponclipsize(var_03));
    }
  }

  var_06 = getarraykeys(param_00.powers);
  foreach(var_08 in var_06) {
    if(param_00.powers[var_08].slot == "secondary") {
      continue;
    }

    param_00 thread recharge_power(var_08);
  }
}

recharge_power(param_00) {
  var_01 = 0;
  var_02 = self.powers[param_00].slot;
  var_03 = level.powers[param_00].maxcharges - self.powers[param_00].charges;
  scripts\cp\powers\coop_powers::power_adjustcharges(var_03, var_02);
  self setweaponammostock(level.powers[param_00].weaponuse, level.powers[param_00].maxcharges);
}

activate_instakill(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  level notify("activated" + param_01);
  level endon("deactivated" + param_01);
  level.insta_kill = 1;
  level thread deactivate_instakill(param_01, param_02);
  level.active_power_ups["instakill"] = 1;
  foreach(var_05 in level.players) {
    thread apply_instakill_effects(var_05);
  }
}

apply_instakill_effects(param_00) {
  param_00.instakill = 1;
  if(isDefined(level.temporal_increase)) {
    param_00 thread power_icon_active(30 * level.temporal_increase, "instakill_30");
    return;
  }

  param_00 thread power_icon_active(30, "instakill_30");
}

deactivate_instakill(param_00, param_01) {
  level endon("game_ended");
  level endon("activated" + param_00);
  scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00);
  level notify("deactivated" + param_00);
  foreach(var_03 in level.players) {
    var_03.instakill = undefined;
  }

  level.insta_kill = undefined;
  level.active_power_ups["instakill"] = 0;
}

scale_earned_cash(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  level endon("deactivated" + param_01);
  level notify("scale_earned_cash");
  level endon("scale_earned_cash");
  level.active_power_ups["double_money"] = 1;
  level.cash_scalar = 2;
  if(isDefined(level.temporal_increase)) {
    level thread deactivate_scaled_cash(param_01, 30 * level.temporal_increase, param_02);
  } else {
    level thread deactivate_scaled_cash(param_01, 30, param_02);
  }

  foreach(var_05 in level.players) {
    thread apply_double_money_effects(var_05);
  }
}

apply_double_money_effects(param_00) {
  param_00.double_money = 1;
  if(isDefined(level.temporal_increase)) {
    param_00 thread power_icon_active(30 * level.temporal_increase, "cash_2");
    return;
  }

  param_00 thread power_icon_active(30, "cash_2");
}

deactivate_scaled_cash(param_00, param_01, param_02) {
  level endon("disconnect");
  level endon("game_ended");
  var_03 = scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00, "activated" + param_00);
  if(var_03 != "activated" + param_00) {
    level notify("deactivated" + param_00);
    level.cash_scalar = 1;
    level.active_power_ups["double_money"] = 0;
    foreach(var_05 in level.players) {
      var_05.double_money = undefined;
    }
  }
}

power_icon_active(param_00, param_01) {
  level notify("power_icon_active_" + param_01);
  level endon("power_icon_active_" + param_01);
  var_02 = level.loot_icon[param_01];
  self.powerupicons[param_01] = var_02;
  var_03 = set_ui_omnvar_for_powerups(param_01);
  thread hide_power_icon(param_00, param_01, var_03);
}

set_ui_omnvar_for_powerups(param_00) {
  var_01 = int(tablelookup(level.power_up_table, 2, param_00, 1));
  var_02 = int(var_01);
  self setclientomnvarbit("zm_active_powerups", var_02 - 1, 1);
  return var_02;
}

display_powerup_popup(param_00) {
  foreach(var_02 in level.players) {
    var_02 setclientomnvar("zm_powerup_activated", param_00);
    wait(0.05);
  }
}

get_fx_points(param_00, param_01, param_02, param_03, param_04) {
  var_05 = [];
  var_06 = scripts\engine\utility::getstructarray(param_01, param_02);
  var_06[var_06.size] = param_00;
  foreach(var_08 in var_06) {
    var_09 = scripts\engine\utility::get_array_of_closest(var_08.origin, level.players, undefined, 1, param_04, 1);
    if(var_09.size >= 1) {
      if(!isDefined(var_08.angles)) {
        var_08.angles = (0, 0, 0);
      }

      var_0A = scripts\engine\utility::spawn_tag_origin(var_08.origin, var_08.angles);
      var_0A show();
      var_0A.origin = var_08.origin;
      var_0A.angles = var_08.angles;
      var_05[var_05.size] = var_0A;
      if(isDefined(param_03)) {
        if(var_05.size >= param_03) {
          break;
        }
      }
    }
  }

  var_05 = sortbydistance(var_05, param_00.origin);
  return var_05;
}

kill_closest_enemies(param_00, param_01) {
  level endon("game_ended");
  var_02 = param_00.origin;
  var_03 = get_fx_points(param_00, "effect_loc", "targetname", undefined, 1500);
  wait(1);
  playsoundatpos(var_02, "zmb_powerup_nuke_explo");
  level thread nuke_fx(param_00, var_03);
  scripts\engine\utility::waitframe();
  playrumbleonposition("heavy_3s", var_02);
  earthquake(0.25, 4, var_02, 2500);
  scripts\engine\utility::waitframe();
  var_04 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_06 in level.players) {
    var_06 scripts\cp\utility::adddamagemodifier("nuke", 0, 0);
  }

  var_08 = sortbydistance(var_04, var_02);
  var_09 = 400;
  if(isDefined(level.cash_scalar)) {
    var_09 = 400 * level.cash_scalar;
  }

  foreach(var_0B in var_08) {
    if(is_immune_against_nuke(var_0B)) {
      continue;
    }

    if(scripts\engine\utility::istrue(level.forced_nuke)) {
      var_0B.died_poorly = 1;
      var_0B.died_poorly_health = var_0B.health;
    }

    if(scripts\engine\utility::istrue(var_0B.isfrozen)) {
      var_0B dodamage(var_0B.health + 100, var_0B.origin);
    } else {
      var_0B.precacheleaderboards = 1;
      var_0B.is_burning = 1;
      var_0B.nocorpse = undefined;
      var_0B thread kill_selected_enemy(1);
    }

    wait(0.1);
  }

  level.nuke_zombies_paused = 1;
  wait(5);
  level.nuke_zombies_paused = 0;
  level.dont_resume_wave_after_solo_afterlife = undefined;
  foreach(var_06 in level.players) {
    var_06 scripts\cp\utility::removedamagemodifier("nuke", 0);
    if(!scripts\engine\utility::istrue(level.forced_nuke)) {
      if(!scripts\cp\cp_laststand::player_in_laststand(var_06)) {
        var_06 scripts\cp\cp_persistence::give_player_currency(var_09, undefined, undefined, 1, "nuke");
      }
    }
  }

  level.forced_nuke = undefined;
}

is_immune_against_nuke(param_00) {
  return scripts\engine\utility::istrue(param_00.immune_against_nuke);
}

nuke_fx(param_00, param_01) {
  var_02 = 0;
  foreach(var_04 in param_01) {
    foreach(var_06 in level.players) {
      if(!var_06 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_06.in_afterlife_arcade)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_06.is_off_grid)) {
        continue;
      }

      playfxontagforclients(level._effect["big_explo"], var_04, "tag_origin", var_06);
    }

    scripts\engine\utility::waitframe();
  }

  wait(5);
  foreach(var_04 in param_01) {
    foreach(var_06 in level.players) {
      stopfxontagforclients(level._effect["big_explo"], var_04, "tag_origin", var_06);
    }

    var_04 delete();
    scripts\engine\utility::waitframe();
  }
}

kill_selected_enemy(param_00) {
  self endon("death");
  thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
  self.marked_for_death = 1;
  var_01 = scripts\engine\utility::istrue(self.is_suicide_bomber);
  if(isDefined(param_00)) {
    if(isalive(self) && !var_01) {
      playFX(level._effect["head_loss"], self gettagorigin("j_neck"));
      self setscriptablepartstate("head", "detached", 1);
      self setscriptablepartstate("eyes", "eye_glow_off", 1);
    }
  } else {
    wait(1);
  }

  self dodamage(self.health, self.origin);
}

give_money(param_00, param_01) {
  param_00 iprintlnbold("Got Loot: $" + param_01);
  param_00 scripts\cp\cp_persistence::give_player_currency(param_01);
}

flash_power_icon(param_00, param_01, param_02) {
  param_02 endon("remove " + param_01 + " icon");
  param_02 endon("death");
  param_02 endon("disconnect");
  level endon("game_ended");
  var_03 = 10;
  var_04 = 0.2;
  wait(param_00 - 5);
  param_00 = 5;
  for(;;) {
    wait(param_00 / var_03);
    self.alpha = 0.1;
    wait(var_04);
    self.alpha = 0.75;
    if(float(var_03 * 1.5) > var_04) {
      var_03 = float(var_03 * 1.5);
      continue;
    }

    var_03 = var_04;
  }
}

hide_power_icon(param_00, param_01, param_02, param_03) {
  level endon("activated" + param_01);
  self endon("remove_carryIcon" + param_01);
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(param_00)) {
    param_00 = 60;
  }

  var_04 = 5.5;
  param_00 = param_00 - var_04;
  self setclientomnvarbit("zm_active_powerup_animation", param_02 - 1, 0);
  if(param_00 > 0) {
    level scripts\engine\utility::waittill_any_timeout_1(param_00, "deactivated" + param_01);
    self setclientomnvarbit("zm_active_powerup_animation", param_02 - 1, 1);
  }

  level scripts\engine\utility::waittill_any_timeout_1(var_04, "deactivated" + param_01);
  level notify("power_up_deactivated");
  if(isDefined(self.powerupicons[param_01])) {
    self.powerupicons[param_01] = undefined;
  }

  self notify("remove " + param_01 + " icon");
  self setclientomnvarbit("zm_active_powerups", param_02 - 1, 0);
  self setclientomnvarbit("zm_active_powerup_animation", param_02 - 1, 0);
}

hidecarryiconongameend() {
  self endon("remove_carryIcon");
  level waittill("game_ended");
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }
}

is_in_active_volume(param_00) {
  if(!isDefined(level.active_spawn_volumes)) {
    return 1;
  }

  var_01 = sortbydistance(level.active_spawn_volumes, param_00);
  foreach(var_03 in var_01) {
    if(ispointinvolume(param_00, var_03)) {
      return 1;
    }
  }

  return 0;
}

ammo_round_up() {
  self endon("death");
  self endon("disconnect");
  var_00 = [];
  foreach(var_02 in self.weaponlist) {
    var_00[var_02] = self getrunningforwardpainanim(var_02);
  }

  return var_00;
}

unlimited_ammo(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("deactivated" + param_01);
  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  scripts\cp\utility::enable_infinite_ammo(1);
  for(;;) {
    var_02 = 0;
    foreach(var_04 in self.weaponlist) {
      if(var_04 == self getcurrentweapon() && weapon_no_unlimited_check(var_04)) {
        var_02 = 1;
        self setweaponammoclip(var_04, weaponclipsize(var_04), "left");
        self setclientomnvar("zm_ui_unlimited_ammo", 1);
      }

      if(var_04 == self getcurrentweapon() && weapon_no_unlimited_check(var_04)) {
        var_02 = 1;
        self setweaponammoclip(var_04, weaponclipsize(var_04), "right");
        self setclientomnvar("zm_ui_unlimited_ammo", 1);
      }

      if(var_02 == 0) {
        self setclientomnvar("zm_ui_unlimited_ammo", 0);
        ammo_round_up();
      }
    }

    wait(0.05);
  }
}

weapon_no_unlimited_check(param_00) {
  var_01 = 1;
  foreach(var_03 in level.opweaponsarray) {
    if(param_00 == var_03) {
      var_01 = 0;
    }
  }

  return var_01;
}

do_screen_flash() {
  scripts\engine\utility::waitframe();
  if(isDefined(self) && scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    playfxontagforclients(level._effect["vfx_screen_flash"], self, "tag_eye", self);
  }
}