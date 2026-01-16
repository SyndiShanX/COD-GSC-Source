/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_weap_quantum_bomb.gsc
**************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include animscripts\zombie_Utility;
#using_animtree("generic_human");
init_registration() {
  level.quantum_bomb_register_result_func = ::quantum_bomb_register_result;
  level.quantum_bomb_deregister_result_func = ::quantum_bomb_deregister_result;
  level.quantum_bomb_in_playable_area_validation_func = ::quantum_bomb_in_playable_area_validation;
  quantum_bomb_register_result("random_lethal_grenade", ::quantum_bomb_lethal_grenade_result, 50);
  quantum_bomb_register_result("random_weapon_starburst", ::quantum_bomb_random_weapon_starburst_result, 75);
  quantum_bomb_register_result("pack_or_unpack_current_weapon", ::quantum_bomb_pack_or_unpack_current_weapon_result, 10, ::quantum_bomb_pack_or_unpack_current_weapon_validation);
  quantum_bomb_register_result("auto_revive", ::quantum_bomb_auto_revive_result, 60, ::quantum_bomb_auto_revive_validation);
  quantum_bomb_register_result("player_teleport", ::quantum_bomb_player_teleport_result, 20);
  level.scr_anim["zombie"]["sprint5"] = % ai_zombie_fast_sprint_01;
  level.scr_anim["zombie"]["sprint6"] = % ai_zombie_fast_sprint_02;
  quantum_bomb_register_result("zombie_speed_buff", ::quantum_bomb_zombie_speed_buff_result, 2);
  quantum_bomb_register_result("zombie_add_to_total", ::quantum_bomb_zombie_add_to_total_result, 70, ::quantum_bomb_zombie_add_to_total_validation);
  level._effect["zombie_fling_result"] = loadfx("maps/zombie_moon/fx_moon_qbomb_explo_distort");
  quantum_bomb_register_result("zombie_fling", ::quantum_bomb_zombie_fling_result);
  level._effect["quantum_bomb_viewmodel_twist"] = LoadFX("weapon/quantum_bomb/fx_twist");
  level._effect["quantum_bomb_viewmodel_press"] = LoadFX("weapon/quantum_bomb/fx_press");
  level._effect["quantum_bomb_area_effect"] = loadfx("weapon/quantum_bomb/area_effect");
  level._effect["quantum_bomb_player_effect"] = loadfx("weapon/quantum_bomb/player_effect");
  level._effect["quantum_bomb_player_position_effect"] = loadfx("weapon/quantum_bomb/fx_player_position_effect");
  level._effect["quantum_bomb_mystery_effect"] = loadfx("weapon/quantum_bomb/fx_mystery_effect");
  level.quantum_bomb_play_area_effect_func = ::quantum_bomb_play_area_effect;
  level.quantum_bomb_play_player_effect_func = ::quantum_bomb_play_player_effect;
  level.quantum_bomb_play_player_effect_at_position_func = ::quantum_bomb_play_player_effect_at_position;
  level.quantum_bomb_play_mystery_effect_func = ::quantum_bomb_play_mystery_effect;
}

init() {
  if(!quantum_bomb_exists()) {
    return;
  }
}

quantum_bomb_debug_print_ln(msg) {}
quantum_bomb_debug_print_bold(msg) {}
quantum_bomb_debug_print_3d(msg, color) {}
quantum_bomb_register_result(name, result_func, chance, validation_func) {
  if(!isDefined(level.quantum_bomb_results)) {
    level.quantum_bomb_results = [];
  }
  if(isDefined(level.quantum_bomb_results[name])) {
    quantum_bomb_debug_print_ln("quantum_bomb_register_result(): '" + name + "' is already registered as a quantum bomb result.\n");
    return;
  }
  result = SpawnStruct();
  result.name = name;
  result.result_func = result_func;
  if(!isDefined(chance)) {
    result.chance = 100;
  } else {
    result.chance = clamp(chance, 1, 100);
  }
  if(!isDefined(validation_func)) {
    result.validation_func = ::quantum_bomb_default_validation;
  } else {
    result.validation_func = validation_func;
  }
  level.quantum_bomb_results[name] = result;
}

quantum_bomb_deregister_result(name) {
  if(!isDefined(level.quantum_bomb_results)) {
    level.quantum_bomb_results = [];
  }
  if(!isDefined(level.quantum_bomb_results[name])) {
    quantum_bomb_debug_print_ln("quantum_bomb_deregister_result(): '" + name + "' is not registered as a quantum bomb result.\n");
    return;
  }
  level.quantum_bomb_results[name] = undefined;
}

quantum_bomb_play_area_effect(position) {
  PlayFX(level._effect["quantum_bomb_area_effect"], position);
}

quantum_bomb_play_player_effect() {
  PlayFXOnTag(level._effect["quantum_bomb_player_effect"], self, "tag_origin");
}

quantum_bomb_play_player_effect_at_position(position) {
  PlayFX(level._effect["quantum_bomb_player_position_effect"], position);
}

quantum_bomb_play_mystery_effect(position) {
  PlayFX(level._effect["quantum_bomb_mystery_effect"], position);
}

quantum_bomb_clear_cached_data() {
  level.quantum_bomb_cached_in_playable_area = undefined;
  level.quantum_bomb_cached_closest_zombies = undefined;
}

quantum_bomb_select_result(position) {
  quantum_bomb_clear_cached_data();
  eligible_results = [];
  chance = randomInt(100);
  keys = GetArrayKeys(level.quantum_bomb_results);
  for(i = 0; i < keys.size; i++) {
    result = level.quantum_bomb_results[keys[i]];
    if(result.chance > chance && self[[result.validation_func]](position)) {
      eligible_results[eligible_results.size] = result.name;
    }
  }
  return level.quantum_bomb_results[eligible_results[randomInt(eligible_results.size)]];
}

player_give_quantum_bomb() {
  self giveweapon("zombie_quantum_bomb");
  self set_player_tactical_grenade("zombie_quantum_bomb");
  self thread player_handle_quantum_bomb();
}

player_handle_quantum_bomb() {
  self notify("starting_quantum_bomb");
  self endon("disconnect");
  self endon("starting_quantum_bomb");
  level endon("end_game");
  while(true) {
    grenade = self get_thrown_quantum_bomb();
    if(isDefined(grenade)) {
      if(self maps\_laststand::player_is_in_laststand()) {
        grenade delete();
        continue;
      }
      grenade waittill("explode", position);
      playsoundatposition("wpn_quantum_exp", position);
      result = self quantum_bomb_select_result(position);
      self thread[[result.result_func]](position);
      quantum_bomb_debug_print_bold("quantum_bomb exploded at " + position + ", result: '" + result.name + "'.\n");
    }
    wait(0.05);
  }
}

quantum_bomb_exists() {
  return isDefined(level.zombie_weapons["zombie_quantum_bomb"]);
}

get_thrown_quantum_bomb() {
  self endon("disconnect");
  self endon("starting_quantum_bomb");
  while(true) {
    self waittill("grenade_fire", grenade, weapName);
    if(weapName == "zombie_quantum_bomb") {
      return grenade;
    }
    wait(0.05);
  }
}

quantum_bomb_default_validation(position) {
  return true;
}

quantum_bomb_get_cached_closest_zombies(position) {
  if(!isDefined(level.quantum_bomb_cached_closest_zombies)) {
    level.quantum_bomb_cached_closest_zombies = get_array_of_closest(position, GetAiSpeciesArray("axis", "all"));
  }
  return level.quantum_bomb_cached_closest_zombies;
}

quantum_bomb_get_cached_in_playable_area(position) {
  if(!isDefined(level.quantum_bomb_cached_in_playable_area)) {
    level.quantum_bomb_cached_in_playable_area = check_point_in_playable_area(position);
  }
  return level.quantum_bomb_cached_in_playable_area;
}

quantum_bomb_in_playable_area_validation(position) {
  return quantum_bomb_get_cached_in_playable_area(position);
}

quantum_bomb_lethal_grenade_result(position) {
  self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
  self MagicGrenadeType(level.zombie_lethal_grenade_list[randomInt(level.zombie_lethal_grenade_list.size)], position, (0, 0, 0), 0.35);
}

quantum_bomb_random_weapon_starburst_result(position) {
  self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
  weapon = "ray_gun_zm";
  rand = randomInt(20);
  switch (rand) {
    case 0:
    case 1:
    case 2:
      weapon = "ray_gun_upgraded_zm";
      if(isDefined(level.zombie_include_weapons["ray_gun_upgraded_zm"])) {
        break;
      }
    case 3:
    case 4:
      weapon = "spas_upgraded_zm";
      if(isDefined(level.zombie_include_weapons["spas_upgraded_zm"])) {
        break;
      }
    case 5:
    case 6:
      weapon = "china_lake_upgraded_zm";
      if(isDefined(level.zombie_include_weapons["china_lake_upgraded_zm"])) {
        break;
      }
    case 7:
    case 8:
      weapon = "m72_law_upgraded_zm";
      if(isDefined(level.zombie_include_weapons["m72_law_upgraded_zm"])) {
        break;
      }
    case 9:
      weapon = "python_upgraded_zm";
      if(isDefined(level.zombie_include_weapons["python_upgraded_zm"])) {
        break;
      }
    default:
      weapon = "ray_gun_zm";
      break;
  }
  quantum_bomb_play_player_effect_at_position(position);
  base_pos = position + (0, 0, 40);
  start_yaw = VectorToAngles(base_pos - self.origin);
  start_yaw = (0, start_yaw[1], 0);
  weapon_model = spawn("script_model", position);
  weapon_model.angles = start_yaw;
  modelname = GetWeaponModel(weapon);
  weapon_model setModel(modelname);
  weapon_model useweaponhidetags(weapon);
  weapon_model moveTo(base_pos, 1, 0.25, 0.25);
  weapon_model waittill("movedone");
  attacker = self;
  for(i = 0; i < 36; i++) {
    yaw = start_yaw + (RandomIntRange(-3, 3), i * 10, 0);
    weapon_model.angles = yaw;
    flash_pos = weapon_model GetTagOrigin("tag_flash");
    target_pos = flash_pos + vector_scale(AnglesToForward(yaw), 40);
    if(!isDefined(attacker)) {
      attacker = undefined;
    }
    MagicBullet(weapon, flash_pos, target_pos, attacker);
    wait_network_frame();
  }
  weapon_model Delete();
}

quantum_bomb_pack_or_unpack_current_weapon_validation(position) {
  if(!quantum_bomb_get_cached_in_playable_area(position)) {
    return false;
  }
  pack_triggers = getEntArray("zombie_vending_upgrade", "targetname");
  range_squared = 180 * 180;
  for(i = 0; i < pack_triggers.size; i++) {
    if(distanceSquared(pack_triggers[i].origin, position) < range_squared) {
      return true;
    }
  }
  return !randomInt(5);
}

quantum_bomb_pack_or_unpack_current_weapon_result(position) {
  quantum_bomb_play_mystery_effect(position);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player.sessionstate == "spectator" || player maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    weapon = player GetCurrentWeapon();
    if("primary" != WeaponInventoryType(weapon) || !isDefined(level.zombie_weapons[weapon])) {
      continue;
    }
    if(maps\_zombiemode_weapons::is_weapon_upgraded(weapon)) {
      if(randomInt(5)) {
        continue;
      }
      ziw_keys = GetArrayKeys(level.zombie_weapons);
      for(weaponindex = 0; weaponindex < level.zombie_weapons.size; weaponindex++) {
        if(isDefined(level.zombie_weapons[ziw_keys[weaponindex]].upgrade_name) &&
          level.zombie_weapons[ziw_keys[weaponindex]].upgrade_name == weapon) {
          if(player == self) {
            self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_bad");
          }
          player thread maps\_zombiemode_weapons::weapon_give(ziw_keys[weaponindex]);
          player quantum_bomb_play_player_effect();
          break;
        }
      }
    } else if(isDefined(level.zombie_weapons[weapon].upgrade_name)) {
      if(!randomInt(4)) {
        continue;
      }
      weapon_limit = 2;
      if(player HasPerk("specialty_additionalprimaryweapon")) {
        weapon_limit = 3;
      }
      primaries = player GetWeaponsListPrimaries();
      if(isDefined(primaries) && primaries.size < weapon_limit) {
        player TakeWeapon(weapon);
      }
      if(player == self) {
        player thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
      }
      player thread maps\_zombiemode_weapons::weapon_give(level.zombie_weapons[weapon].upgrade_name);
      player quantum_bomb_play_player_effect();
    }
  }
}

quantum_bomb_auto_revive_validation(position) {
  if(flag("solo_game")) {
    return false;
  }
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player maps\_laststand::player_is_in_laststand()) {
      return true;
    }
  }
  return false;
}

quantum_bomb_auto_revive_result(position) {
  quantum_bomb_play_mystery_effect(position);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player maps\_laststand::player_is_in_laststand() && randomInt(3)) {
      player maps\_laststand::auto_revive(self);
      player quantum_bomb_play_player_effect();
    }
  }
}

quantum_bomb_player_teleport_result(position) {
  quantum_bomb_play_mystery_effect(position);
  players = getplayers();
  players_to_teleport = [];
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(player.sessionstate == "spectator" || player maps\_laststand::player_is_in_laststand()) {
      continue;
    }
    if(isDefined(level.quantum_bomb_prevent_player_getting_teleported) && player[[level.quantum_bomb_prevent_player_getting_teleported]](position)) {
      continue;
    }
    players_to_teleport[players_to_teleport.size] = player;
  }
  players_to_teleport = array_randomize(players_to_teleport);
  for(i = 0; i < players_to_teleport.size; i++) {
    player = players_to_teleport[i];
    if(i && randomInt(5)) {
      continue;
    }
    level thread quantum_bomb_teleport_player(player);
  }
}

quantum_bomb_teleport_player(player) {
  black_hole_teleport_structs = getstructarray("struct_black_hole_teleport", "targetname");
  chosen_spot = undefined;
  if(isDefined(level._special_blackhole_bomb_structs)) {
    black_hole_teleport_structs = [
      [level._special_blackhole_bomb_structs]
    ]();
  }
  player_current_zone = player get_current_zone();
  if(!isDefined(black_hole_teleport_structs) || black_hole_teleport_structs.size == 0 || !isDefined(player_current_zone)) {
    return;
  }
  black_hole_teleport_structs = array_randomize(black_hole_teleport_structs);
  if(isDefined(level._override_blackhole_destination_logic)) {
    chosen_spot = [
      [level._override_blackhole_destination_logic]
    ](black_hole_teleport_structs, player);
  } else {
    for(i = 0; i < black_hole_teleport_structs.size; i++) {
      if(check_point_in_active_zone(black_hole_teleport_structs[i].origin) &&
        (player_current_zone != black_hole_teleport_structs[i].script_string)) {
        chosen_spot = black_hole_teleport_structs[i];
        break;
      }
    }
  }
  if(isDefined(chosen_spot)) {
    player thread quantum_bomb_teleport(chosen_spot);
  }
}

quantum_bomb_teleport(struct_dest) {
  self endon("death");
  if(!isDefined(struct_dest)) {
    return;
  }
  prone_offset = (0, 0, 49);
  crouch_offset = (0, 0, 20);
  stand_offset = (0, 0, 0);
  destination = undefined;
  if(self GetStance() == "prone") {
    destination = struct_dest.origin + prone_offset;
  } else if(self GetStance() == "crouch") {
    destination = struct_dest.origin + crouch_offset;
  } else {
    destination = struct_dest.origin + stand_offset;
  }
  if(isDefined(level._black_hole_teleport_override)) {
    level[[level._black_hole_teleport_override]](self);
  }
  quantum_bomb_play_player_effect_at_position(self.origin);
  self FreezeControls(true);
  self DisableOffhandWeapons();
  self DisableWeapons();
  self playsoundtoplayer("zmb_gersh_teleporter_go_2d", self);
  self DontInterpolate();
  self SetOrigin(destination);
  self SetPlayerAngles(struct_dest.angles);
  self EnableOffhandWeapons();
  self EnableWeapons();
  self FreezeControls(false);
  self quantum_bomb_play_player_effect();
  self thread quantum_bomb_slightly_delayed_player_response();
}

quantum_bomb_slightly_delayed_player_response() {
  wait(1);
  self maps\_zombiemode_audio::create_and_play_dialog("general", "teleport_gersh");
}

quantum_bomb_zombie_speed_buff_result(position) {
  quantum_bomb_play_mystery_effect(position);
  self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_bad");
  zombies = quantum_bomb_get_cached_closest_zombies(position);
  for(i = 0; i < zombies.size; i++) {
    fast_sprint = "sprint5";
    if(randomInt(100) < 50) {
      fast_sprint = "sprint6";
    }
    zombie = zombies[i];
    if(isDefined(zombie.fastSprintFunc)) {
      fast_sprint = zombie[[zombie.fastSprintFunc]]();
    } else if(is_true(zombie.in_low_gravity)) {
      if(!zombie.has_legs) {
        fast_sprint = "crawl_low_g_super_sprint";
      } else {
        fast_sprint = "low_g_super_sprint";
      }
    } else {
      if(!zombie.has_legs) {
        fast_sprint = "crawl_super_sprint";
      }
    }
    if(zombie.isdog || !isDefined(level.scr_anim[zombie.animname][fast_sprint])) {
      continue;
    }
    zombie.zombie_move_speed = "sprint";
    zombie set_run_anim(fast_sprint);
    zombie.run_combatanim = level.scr_anim[zombie.animname][fast_sprint];
    zombie.needs_run_update = true;
  }
}

quantum_bomb_zombie_fling_result(position) {
  PlayFX(level._effect["zombie_fling_result"], position);
  self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_good");
  range = 300;
  range_squared = range * range;
  zombies = quantum_bomb_get_cached_closest_zombies(position);
  for(i = 0; i < zombies.size; i++) {
    zombie = zombies[i];
    if(!isDefined(zombie) || !IsAlive(zombie)) {
      continue;
    }
    test_origin = zombie.origin + (0, 0, 40);
    test_origin_squared = distanceSquared(position, test_origin);
    if(test_origin_squared > range_squared) {
      break;
    }
    dist_mult = (range_squared - test_origin_squared) / range_squared;
    fling_vec = VectorNormalize(test_origin - position);
    fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
    fling_vec = vector_scale(fling_vec, 100 + 100 * dist_mult);
    zombie quantum_bomb_fling_zombie(self, fling_vec);
    if(i && !(i % 10)) {
      wait_network_frame();
      wait_network_frame();
      wait_network_frame();
    }
  }
}

quantum_bomb_fling_zombie(player, fling_vec) {
  if(!isDefined(self) || !IsAlive(self)) {
    return;
  }
  self DoDamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    self StartRagdoll();
    self LaunchRagdoll(fling_vec);
  }
}

quantum_bomb_zombie_add_to_total_validation(position) {
  if(level.zombie_total) {
    return false;
  }
  zombies = quantum_bomb_get_cached_closest_zombies(position);
  return (zombies.size < level.zombie_ai_limit);
}

quantum_bomb_zombie_add_to_total_result(position) {
  quantum_bomb_play_mystery_effect(position);
  self thread maps\_zombiemode_audio::create_and_play_dialog("kill", "quant_bad");
  level.zombie_total += level.zombie_ai_limit;
}