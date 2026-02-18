/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\callbacks_shared.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\simple_hostmigration;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace callback;

function callback(event, params) {
  mpl_heatwave_fx(level, event, params);

  if(self != level) {
    mpl_heatwave_fx(self, event, params);
  }
}

function function_bea20a96(event, params) {
  ais = getaiarray();

  foreach(ai in ais) {
    ai mpl_heatwave_fx(ai, event, params);
  }
}

function function_daed27e8(event, params) {
  players = getplayers();

  foreach(player in players) {
    player mpl_heatwave_fx(level, event, params);
    player mpl_heatwave_fx(player, event, params);
  }
}

function private mpl_heatwave_fx(ent, event, params) {
  callbacks = ent._callbacks[event];

  if(isDefined(callbacks)) {
    for(i = 0; i < callbacks.size; i++) {
      callback_fields = callbacks[i];

      if(!isarray(callback_fields)) {
        continue;
      }

      callback = callback_fields[0];
      assert(isfunctionptr(callback), "<dev string:x38>" + "<dev string:x53>");

      if(!isfunctionptr(callback)) {
        return;
      }

      obj = callback_fields[1];
      var_47e0b77b = callback_fields[2];

      if(!isDefined(var_47e0b77b)) {
        var_47e0b77b = [];
      }

      if(isDefined(obj)) {
        if(isDefined(params)) {
          util::function_cf55c866(obj, callback, self, params, var_47e0b77b);
        } else {
          util::function_50f54b6f(obj, callback, self, var_47e0b77b);
        }

        continue;
      }

      if(isDefined(params)) {
        util::function_50f54b6f(self, callback, params, var_47e0b77b);
        continue;
      }

      util::single_thread_argarray(self, callback, var_47e0b77b);
    }

    arrayremovevalue(callbacks, 0, 0);
  }
}

function add_callback(event, func, obj, a_params) {
  function_2b653c00(level, event, func, obj, a_params);
}

function function_d8abfc3d(event, func, obj, a_params) {
  function_2b653c00(self, event, func, obj, a_params);
}

function private function_2b653c00(ent, event, func, obj, a_params) {
  if(!isDefined(ent)) {
    return;
  }

  assert(isfunctionptr(func), "<dev string:x70>" + "<dev string:x53>");

  if(!isfunctionptr(func)) {
    return;
  }

  assert(isDefined(event), "<dev string:x94>");

  if(!(isDefined(ent._callbacks) && isDefined(ent._callbacks[event]))) {
    ent._callbacks[event] = [];
  }

  foreach(callback in ent._callbacks[event]) {
    if(isarray(callback) && callback[0] == func) {
      if(!isDefined(obj) || callback[1] == obj) {
        return;
      }
    }
  }

  array::add(ent._callbacks[event], array(func, obj, a_params), 0);

  if(isDefined(obj)) {
    obj thread remove_callback_on_death(event, func);
  }
}

function private function_862146b3(event, func) {
  return string(event) + string(func);
}

function remove_callback_on_death(event, func) {
  self notify(function_862146b3(event, func));
  self endon(function_862146b3(event, func));
  self waittill(#"death", #"remove_callbacks");
  remove_callback(event, func, self);
}

function remove_callback(event, func, obj) {
  function_3f5f097e(level, event, func, obj);
}

function function_52ac9652(event, func, obj, instant) {
  function_3f5f097e(self, event, func, obj, instant);
}

function private function_3f5f097e(ent, event, func, obj, instant) {
  if(!isDefined(ent._callbacks)) {
    return;
  }

  assert(isDefined(event), "<dev string:xc7>");

  if(func === "all") {
    ent._callbacks[event] = [];
    return;
  }

  if(!isDefined(ent._callbacks[event])) {
    return;
  }

  if(is_true(instant)) {
    arrayremovevalue(ent._callbacks[event], 0, 0);
    return;
  }

  foreach(index, func_group in ent._callbacks[event]) {
    if(isarray(func_group) && func_group[0] == func) {
      if(func_group[1] === obj) {
        if(isDefined(obj)) {
          obj notify(function_862146b3(event, func));
        }

        ent._callbacks[event][index] = 0;
        break;
      }
    }
  }
}

function on_finalize_initialization(func, obj) {
  add_callback(#"on_finalize_initialization", func, obj);
}

function on_connect(func, obj, ...) {
  add_callback(#"on_player_connect", func, obj, vararg);
}

function remove_on_connect(func, obj) {
  remove_callback(#"on_player_connect", func, obj);
}

function on_connecting(func, obj) {
  add_callback(#"on_player_connecting", func, obj);
}

function remove_on_connecting(func, obj) {
  remove_callback(#"on_player_connecting", func, obj);
}

function on_disconnect(func, obj) {
  add_callback(#"on_player_disconnect", func, obj);
}

function remove_on_disconnect(func, obj) {
  remove_callback(#"on_player_disconnect", func, obj);
}

function on_spawned(func, obj) {
  add_callback(#"on_player_spawned", func, obj);
}

function remove_on_spawned(func, obj) {
  remove_callback(#"on_player_spawned", func, obj);
}

function function_acaac19b(func, obj) {
  add_callback(#"hash_3e52a013a2eb0f16", func, obj);
}

function function_2d538029(func, obj) {
  remove_callback(#"hash_3e52a013a2eb0f16", func, obj);
}

function remove_on_revived(func, obj) {
  remove_callback(#"on_player_revived", func, obj);
}

function on_deleted(func, obj) {
  add_callback(#"on_entity_deleted", func, obj);
}

function remove_on_deleted(func, obj) {
  remove_callback(#"on_entity_deleted", func, obj);
}

function on_loadout(func, obj) {
  add_callback(#"on_loadout", func, obj);
}

function remove_on_loadout(func, obj) {
  remove_callback(#"on_loadout", func, obj);
}

function function_adff8850(func, obj) {
  add_callback(#"hash_51775e2174499c80", func, obj);
}

function function_4bd0e6a4(func, obj) {
  remove_callback(#"hash_51775e2174499c80", func, obj);
}

function on_player_damage(func, obj) {
  add_callback(#"on_player_damage", func, obj);
}

function remove_on_player_damage(func, obj) {
  remove_callback(#"on_player_damage", func, obj);
}

function on_start_gametype(func, obj) {
  add_callback(#"on_start_gametype", func, obj);
}

function on_end_game(func, obj) {
  add_callback(#"on_end_game", func, obj);
}

function function_5fb139ea(func, obj) {
  add_callback(#"hash_db04388888e3e16", func, obj);
}

function on_game_shutdown(func, obj) {
  add_callback(#"on_game_shutdown", func, obj);
}

function on_game_playing(func, obj) {
  add_callback(#"on_game_playing", func, obj);
}

function function_359493ba(func, obj) {
  add_callback(#"hash_7177603f5415549b", func, obj);
}

function on_joined_team(func, obj) {
  add_callback(#"joined_team", func, obj);
}

function on_joined_spectate(func, obj) {
  add_callback(#"on_joined_spectator", func, obj);
}

function on_player_killed(func, obj) {
  add_callback(#"on_player_killed", func, obj);
}

function function_c046382d(func, obj) {
  add_callback(#"hash_2fea1d218f4c6a1f", func, obj);
}

function on_player_corpse(func, obj) {
  add_callback(#"on_player_corpse", func, obj);
}

function remove_on_player_killed(func, obj) {
  remove_callback(#"on_player_killed", func, obj);
}

function function_489cbdb4(func, obj) {
  remove_callback(#"hash_2fea1d218f4c6a1f", func, obj);
}

function function_80270643(func, obj) {
  add_callback(#"on_team_eliminated", func, obj);
}

function function_c53a8ab8(func, obj) {
  remove_callback(#"on_team_eliminated", func, obj);
}

function on_ai_killed(func, obj) {
  add_callback(#"on_ai_killed", func, obj);
}

function remove_on_ai_killed(func, obj) {
  remove_callback(#"on_ai_killed", func, obj);
}

function on_actor_killed(func, obj) {
  add_callback(#"on_actor_killed", func, obj);
}

function remove_on_actor_killed(func, obj) {
  remove_callback(#"on_actor_killed", func, obj);
}

function function_30c3f95d(func, obj) {
  function_d8abfc3d(#"hash_3d6ccbbe0e628b2d", func, obj);
}

function function_95ba5345(func, obj) {
  function_52ac9652(#"hash_3d6ccbbe0e628b2d", func, obj);
}

function on_vehicle_spawned(func, obj) {
  add_callback(#"on_vehicle_spawned", func, obj);
}

function remove_on_vehicle_spawned(func, obj) {
  remove_callback(#"on_vehicle_spawned", func, obj);
}

function on_vehicle_killed(func, obj) {
  add_callback(#"on_vehicle_killed", func, obj);
}

function on_vehicle_collision(func, obj) {
  function_d8abfc3d(#"veh_collision", func, obj);
}

function remove_on_vehicle_killed(func, obj) {
  remove_callback(#"on_vehicle_killed", func, obj);
}

function on_ai_damage(func, obj) {
  add_callback(#"on_ai_damage", func, obj);
}

function remove_on_ai_damage(func, obj) {
  remove_callback(#"on_ai_damage", func, obj);
}

function on_ai_spawned(func, obj) {
  add_callback(#"on_ai_spawned", func, obj);
}

function remove_on_ai_spawned(func, obj) {
  remove_callback(#"on_ai_spawned", func, obj);
}

function function_f642faf2(func, obj) {
  add_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

function function_c1017156(func, obj) {
  remove_callback(#"hash_7d2e38b28c894e5a", func, obj);
}

function on_actor_damage(func, obj) {
  add_callback(#"on_actor_damage", func, obj);
}

function remove_on_actor_damage(func, obj) {
  remove_callback(#"on_actor_damage", func, obj);
}

function on_scriptmover_damage(func, obj) {
  add_callback(#"on_scriptmover_damage", func, obj);
}

function remove_on_scriptmover_damage(func, obj) {
  remove_callback(#"on_scriptmover_damage", func, obj);
}

function on_vehicle_damage(func, obj) {
  add_callback(#"on_vehicle_damage", func, obj);
}

function remove_on_vehicle_damage(func, obj) {
  remove_callback(#"on_vehicle_damage", func, obj);
}

function on_downed(func, obj) {
  add_callback(#"on_player_downed", func, obj);
}

function remove_on_downed(func, obj) {
  remove_callback(#"on_player_downed", func, obj);
}

function on_laststand(func, obj) {
  add_callback(#"on_player_laststand", func, obj);
}

function remove_on_laststand(func, obj) {
  remove_callback(#"on_player_laststand", func, obj);
}

function function_716834ed(func, obj) {
  add_callback(#"entering_last_stand", func, obj);
}

function function_d5b3e529(func, obj) {
  remove_callback(#"entering_last_stand", func, obj);
}

function on_bleedout(func, obj) {
  add_callback(#"on_player_bleedout", func, obj);
}

function on_revived(func, obj) {
  add_callback(#"on_player_revived", func, obj);
}

function on_mission_failed(func, obj) {
  add_callback(#"on_mission_failed", func, obj);
}

function on_challenge_complete(func, obj) {
  add_callback(#"on_challenge_complete", func, obj);
}

function on_weapon_change(func, obj) {
  add_callback(#"weapon_change", func, obj);
}

function remove_on_weapon_change(func, obj) {
  remove_callback(#"weapon_change", func, obj);
}

function on_weapon_fired(func, obj) {
  add_callback(#"weapon_fired", func, obj);
}

function remove_on_weapon_fired(func, obj) {
  remove_callback(#"weapon_fired", func, obj);
}

function on_grenade_fired(func, obj) {
  add_callback(#"grenade_fired", func, obj);
}

function remove_on_grenade_fired(func, obj) {
  remove_callback(#"grenade_fired", func, obj);
}

function on_offhand_fire(func, obj) {
  add_callback(#"offhand_fire", func, obj);
}

function remove_on_offhand_fire(func, obj) {
  remove_callback(#"offhand_fire", func, obj);
}

function function_4b7977fe(func, obj) {
  add_callback(#"hash_198a389d6b65f68d", func, obj);
}

function function_61583a71(func, obj) {
  remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

function on_detonate(func, obj) {
  function_d8abfc3d(#"detonate", func, obj);
}

function remove_on_detonate(func, obj) {
  function_52ac9652(#"detonate", func, obj);
}

function on_double_tap_detonate(func, obj) {
  function_d8abfc3d(#"doubletap_detonate", func, obj);
}

function remove_on_double_tap_detonate(func, obj) {
  function_52ac9652(#"doubletap_detonate", func, obj);
}

function function_9cac835e(func, obj) {
  add_callback(#"flourish_start", func, obj);
}

function function_e1c2dbd9(func, obj) {
  remove_callback(#"flourish_start", func, obj);
}

function on_death(func, obj) {
  function_d8abfc3d(#"death", func, obj);
}

function remove_on_death(func, obj) {
  function_52ac9652(#"death", func, obj);
}

function on_trigger_spawned(func, obj) {
  add_callback(#"on_trigger_spawned", func, obj);
}

function on_trigger(func, obj, ...) {
  function_d8abfc3d(#"on_trigger", func, obj, vararg);
}

function remove_on_trigger(func, obj) {
  function_52ac9652(#"on_trigger", func, obj);
}

function on_trigger_once(func, obj, ...) {
  function_d8abfc3d(#"on_trigger_once", func, obj, vararg);
}

function remove_on_trigger_once(func, obj) {
  function_52ac9652(#"on_trigger_once", func, obj);
}

function function_33f0ddd3(func, obj) {
  add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

function function_824d206(func, obj) {
  remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

function on_boast(func, obj) {
  add_callback(#"on_boast", func, obj);
}

function remove_on_boast(func, obj) {
  remove_callback(#"on_boast", func, obj);
}

function function_5753ac6e(func, obj) {
  add_callback(#"hash_4a9c56bba76da754", func, obj);
}

function function_16046baa(func, obj) {
  remove_callback(#"hash_4a9c56bba76da754", func, obj);
}

function on_ping(func, obj) {
  add_callback(#"on_ping", func, obj);
}

function on_menu_response(func, obj) {
  add_callback(#"menu_response", func, obj);
}

function function_96bbd5dc(func, obj) {
  remove_callback(#"menu_response", func, obj);
}

function on_item_pickup(func, obj) {
  add_callback(#"on_item_pickup", func, obj);
}

function on_item_drop(func, obj) {
  add_callback(#"on_drop_item", func, obj);
}

function on_drop_inventory(func, obj) {
  add_callback(#"on_drop_inventory", func, obj);
}

function on_item_use(func, obj) {
  add_callback(#"on_item_use", func, obj);
}

function on_stash_open(func, obj) {
  add_callback(#"on_stash_open", func, obj);
}

function on_character_unlock(func, obj) {
  add_callback(#"on_character_unlock", func, obj);
}

function on_contract_complete(func, obj) {
  add_callback(#"contract_complete", func, obj);
}

function function_6700e8b5(func, obj) {
  if(self == level) {
    add_callback(#"hash_4428d68b23082312", func, obj);
    return;
  }

  function_d8abfc3d(#"hash_4428d68b23082312", func, obj);
}

function function_900862de(func, obj) {
  if(self == level) {
    add_callback(#"hash_4b4c187e584b34ac", func, obj);
    return;
  }

  function_d8abfc3d(#"hash_4b4c187e584b34ac", func, obj);
}

function function_be4cb7fe(func, obj) {
  if(self == level) {
    add_callback(#"hash_255b4626805810f5", func, obj);
    return;
  }

  function_d8abfc3d(#"hash_255b4626805810f5", func, obj);
}

function on_rappel(func, obj) {
  add_callback(#"on_rappel", func, obj);
}

function function_c16ce2bc(func, obj) {
  add_callback(#"hash_52c6deac4a362083", func, obj);
}

function on_zipline(func, obj) {
  add_callback(#"on_zipline", func, obj);
}

function function_46609b1(func, obj) {
  add_callback(#"hash_1b4bad2414c405c0", func, obj);
}

function function_e5340d32(func, obj) {
  add_callback(#"hash_3b6ebf3a7ab5c795", func, obj);
}

function function_d4f0a93d(func, obj) {
  remove_callback(#"hash_3b6ebf3a7ab5c795", func, obj);
}

function function_dd017b2e(func, obj) {
  add_callback(#"player_callout", func, obj);
}

function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
  system::run_pre_systems();
  flag::set(#"preinit");
}

function event_handler[level_init] function_4123368a(eventstruct) {
  flag::set(#"levelinit");
}

function event_handler[event_cc819519] function_12c01a61(eventstruct) {
  system::run_post_systems();
  flag::set(#"postinit");
}

function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
  system::function_b1553822();
  flag::set(#"finalizeinit");
  callback(#"on_finalize_initialization");
}

function add_weapon_damage(weapontype, callback) {
  if(!isDefined(level.weapon_damage_callback_array)) {
    level.weapon_damage_callback_array = [];
  }

  level.weapon_damage_callback_array[weapontype] = callback;
}

function callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
  if(isDefined(level.weapon_damage_callback_array)) {
    if(isDefined(level.weapon_damage_callback_array[weapon])) {
      self thread[[level.weapon_damage_callback_array[weapon]]](eattacker, einflictor, weapon, meansofdeath, damage);
      return true;
    } else if(isDefined(level.weapon_damage_callback_array[weapon.rootweapon])) {
      self thread[[level.weapon_damage_callback_array[weapon.rootweapon]]](eattacker, einflictor, weapon, meansofdeath, damage);
      return true;
    }
  }

  return false;
}

function add_weapon_fired(weapon, callback) {
  if(!isDefined(level.var_129c2069)) {
    level.var_129c2069 = [];
  }

  level.var_129c2069[weapon] = callback;
}

function callback_weapon_fired(weapon) {
  if(isDefined(weapon) && isDefined(level.var_129c2069)) {
    if(isDefined(level.var_129c2069[weapon])) {
      self thread[[level.var_129c2069[weapon]]](weapon);
      return true;
    } else if(isDefined(level.var_129c2069[weapon.rootweapon])) {
      self thread[[level.var_129c2069[weapon.rootweapon]]](weapon);
      return true;
    }
  }

  return false;
}

function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    if(isDefined(level.callbackstartgametype)) {
      [[level.callbackstartgametype]]();
    }

    level.gametypestarted = 1;
  }
}

function event_handler[player_connect] codecallback_playerconnect(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerconnect]]();
}

function event_handler[player_disconnect] codecallback_playerdisconnect(eventstruct) {
  self.player_disconnected = 1;
  self notify(#"disconnect");
  level notify(#"disconnect", self);
  self notify(#"death");
  [[level.callbackplayerdisconnect]]();
  callback(#"on_player_disconnect");
}

function event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
  println("<dev string:xfd>");
  simple_hostmigration::migration_setupgametype();
}

function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
  println("<dev string:x12d>");
  [[level.callbackhostmigration]]();
}

function event_handler[hostmigration_save] codecallback_hostmigrationsave(eventstruct) {
  println("<dev string:x153>");
  [[level.callbackhostmigrationsave]]();
}

function event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(eventstruct) {
  println("<dev string:x17d>");
  [[level.callbackprehostmigrationsave]]();
}

function event_handler[hostmigration_playermigrated] codecallback_playermigrated(eventstruct) {
  println("<dev string:x1aa>");
  [[level.callbackplayermigrated]]();
}

function event_handler[player_damage] codecallback_playerdamage(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

function event_handler[player_killed] codecallback_playerkilled(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

function event_handler[event_2958ea55] function_73e8e3f9(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_3a9881cb)) {
    [[level.var_3a9881cb]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_894859a2, eventstruct.durationoverride, eventstruct.weapon);
  }
}

function event_handler[event_a98a54a7] function_323548ba(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayershielddamageblocked]](eventstruct.damage);
}

function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
  self endon(#"disconnect");
  self stopanimscripted();
  [[level.callbackplayerlaststand]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

function event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
  self endon(#"disconnect");
  [[level.var_69959686]](eventstruct.weapon);
}

function event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_bb1ea3f1)) {
    [[level.var_bb1ea3f1]](eventstruct.weapon);
  }
}

function event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_2f64d35)) {
    [[level.var_2f64d35]](eventstruct.weapon);
  }
}

function event_handler[event_3dd1ca18] function_cf68d893(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_523faa05)) {
    [[level.var_523faa05]](eventstruct.weapon);
  }
}

function event_handler[event_bf57d5bb] function_d7eb3672(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_a28be0a5)) {
    [[level.var_a28be0a5]](eventstruct.weapon);
  }
}

function event_handler[event_e9b4bb47] function_7dba9a1(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_bd0b5fc1)) {
    [[level.var_bd0b5fc1]](eventstruct.weapon);
  }
}

function event_handler[player_boast] function_3b159f77(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_4268159)) {
    [[level.var_4268159]](eventstruct.gestureindex, eventstruct.animlength);
  }

  callback(#"on_boast", eventstruct);
}

function event_handler[event_8451509a] function_e35aeddd(eventstruct) {
  self endon(#"disconnect");
  callback(#"hash_4a9c56bba76da754");
}

function event_handler[event_7602f48e] function_1a49689c(eventstruct, var_22c15896) {
  self endon(#"disconnect");
  waittillframeend();

  if(!isPlayer(self)) {
    return;
  }

  callback(#"hash_51775e2174499c80");
}

function event_handler[sprint_begin] function_336afb8e(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_7bd720f6)) {
    [[level.var_7bd720f6]](eventstruct);
  }
}

function event_handler[sprint_end] function_6806b4f(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_42b43ce2)) {
    [[level.var_42b43ce2]](eventstruct);
  }
}

function event_handler[event_9e865a6e] function_1855d09f(eventstruct) {
  self endon(#"disconnect");
  callback(#"on_rappel");
}

function event_handler[rappel_end] function_e51b8b9d(eventstruct) {
  self endon(#"disconnect");
  callback(#"hash_52c6deac4a362083");
}

function event_handler[event_6d81870d] function_78ddc6fb(eventstruct) {
  self endon(#"disconnect");
  callback(#"on_zipline");
}

function event_handler[event_4be77411] function_e62ade94(eventstruct) {
  self endon(#"disconnect");
  callback(#"hash_1b4bad2414c405c0");
}

function event_handler[slide_begin] function_2e3100e0(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_e74639aa)) {
    [[level.var_e74639aa]](eventstruct);
  }
}

function event_handler[slide_end] function_e1b7e658(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_7f80c5a6)) {
    [[level.var_7f80c5a6]](eventstruct);
  }
}

function event_handler[jump_begin] function_b0353bef(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_6c3038dc)) {
    [[level.var_6c3038dc]](eventstruct);
  }
}

function event_handler[jump_end] function_40b29944(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_4c9e52d1)) {
    [[level.var_4c9e52d1]](eventstruct);
  }
}

function event_handler[player_melee] codecallback_playermelee(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayermelee]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

function event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
  self[[level.callbackactorspawned]](eventstruct.entity);
}

function event_handler[event_7d801d3e] function_2f02dc73(eventstruct) {
  if(isDefined(level.var_a79419ed)) {
    self[[level.var_a79419ed]](eventstruct.entity);
  }
}

function event_handler[event_52071346] function_40ef094(eventstruct) {
  self callback(#"hash_7d2e38b28c894e5a");
}

function event_handler[actor_damage] codecallback_actordamage(eventstruct) {
  [[level.callbackactordamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

function event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
  [[level.callbackactorkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

function event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
  [[level.callbackactorcloned]](eventstruct.clone);
}

function event_handler[event_bc72e1ee] function_df3c93ef(eventstruct) {
  self callback(#"hash_3d6ccbbe0e628b2d", eventstruct);
}

function event_handler[event_1524de24] function_5b0a9275(eventstruct) {
  [[level.var_6788bf11]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

function event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
  if(isDefined(level.callbackvehiclespawned)) {
    [[level.callbackvehiclespawned]](eventstruct.spawner);
  }
}

function event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
  [[level.callbackvehiclekilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

function event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
  [[level.callbackvehicledamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.var_fd90b0bb, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

function event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
  if(isDefined(level.callbackvehicleradiusdamage)) {
    [[level.callbackvehicleradiusdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
  }
}

function event_handler[ping] function_87cf247e(eventstruct) {
  self callback(#"on_ping", eventstruct);
}

function finishcustomtraversallistener() {
  self endon(#"death");
  self waittillmatch({
    #notetrack: "end"}, #"custom_traversal_anim_finished");
  self finishtraversal();
  self unlink();
  self.usegoalanimweight = 0;
  self.blockingpain = 0;
  self.customtraverseendnode = undefined;
  self.customtraversestartnode = undefined;
  self notify(#"custom_traversal_cleanup");
}

function killedcustomtraversallistener() {
  self endon(#"custom_traversal_cleanup");
  self waittill(#"death");

  if(isDefined(self)) {
    self finishtraversal();
    self stopanimscripted();
    self unlink();
  }
}

function event_handler[entity_playcustomtraversal] codecallback_playcustomtraversal(eventstruct) {
  entity = eventstruct.entity;
  endparent = eventstruct.end_entity;
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity.customtraverseendnode = entity.traverseendnode;
  entity.customtraversestartnode = entity.traversestartnode;
  entity animmode("noclip", 0);
  entity orientmode("face angle", eventstruct.direction[1]);

  if(isDefined(endparent)) {
    offset = entity.origin - endparent.origin;
    entity linkto(endparent, "", offset);
  }

  entity animscripted("custom_traversal_anim_finished", eventstruct.location, eventstruct.direction, eventstruct.animation, eventstruct.anim_mode, undefined, eventstruct.playback_speed, eventstruct.goal_time, eventstruct.lerp_time);
  entity thread finishcustomtraversallistener();
  entity thread killedcustomtraversallistener();
}

function codecallback_faceeventnotify(notify_msg, ent) {
  if(isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims) {
    if(isDefined(level.face_event_handler) && isDefined(level.face_event_handler.events[notify_msg])) {
      ent sendfaceevent(level.face_event_handler.events[notify_msg]);
    }
  }
}

function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
  if(!isDefined(level.menuresponsequeue)) {
    level.menuresponsequeue = [];
    level thread menu_response_queue_pump();
  }

  index = level.menuresponsequeue.size;
  level.menuresponsequeue[index] = {
    #ent: self, #eventstruct: eventstruct
  };
  level notify(#"menuresponse_queue");
}

function menu_response_queue_pump() {
  while(true) {
    level waittill(#"menuresponse_queue");

    do {
      if(isDefined(level.menuresponsequeue[0].ent)) {
        level.menuresponsequeue[0].ent notify(#"menuresponse", level.menuresponsequeue[0].eventstruct);
        level.menuresponsequeue[0].ent callback(#"menu_response", level.menuresponsequeue[0].eventstruct);
      }

      arrayremoveindex(level.menuresponsequeue, 0, 0);
      waitframe(1);
    }
    while(level.menuresponsequeue.size > 0);
  }
}

function event_handler[notetrack_callserverscript] codecallback_callserverscript(eventstruct) {
  if(!isDefined(level._animnotifyfuncs)) {
    return;
  }

  if(isDefined(level._animnotifyfuncs[eventstruct.label])) {
    if(isDefined(eventstruct.param3) && eventstruct.param3 != "") {
      eventstruct.entity[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
      return;
    }

    eventstruct.entity[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
  }
}

function event_handler[notetrack_callserverscriptonlevel] codecallback_callserverscriptonlevel(eventstruct) {
  if(!isDefined(level._animnotifyfuncs)) {
    return;
  }

  if(isDefined(level._animnotifyfuncs[eventstruct.label])) {
    if(isDefined(eventstruct.param3) && eventstruct.param3 != "") {
      level[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
      return;
    }

    level[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
  }
}

function event_handler[event_69572c01] function_2073f6dc(eventstruct) {
  origin = self.origin;
  magnitude = float(eventstruct.magnitude);
  innerradius = float(eventstruct.innerradius);
  outerradius = int(eventstruct.outerradius);
  innerdamage = isDefined(self.var_f501d778) ? self.var_f501d778 : 50;
  outerdamage = isDefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
  physicsexplosionsphere(origin, outerradius, innerradius, magnitude, outerdamage, innerdamage);
}

function event_handler[event_195cc461] function_52d32e5b(eventstruct) {
  actor = self;
  player = arraygetclosest(actor.origin, function_a1ef346b());

  if(!isactor(actor)) {
    return;
  }

  if(is_true(eventstruct.enable) && isDefined(player)) {
    switch (eventstruct.type) {
      case # "hash_d85822f3fe3ff26":
        actor lookatentity(player, 0, 0, 0, eventstruct.blend, eventstruct.weight);
        break;
      case # "head_torso":
        actor lookatentity(player, 0, 0, 1, eventstruct.blend, eventstruct.weight);
        break;
      case # "head":
        actor lookatentity(player, 1, 0, 1, eventstruct.blend, eventstruct.weight);
        break;
      case # "eyes":
        actor lookatentity(player, 1, 1, 0, eventstruct.blend, eventstruct.weight);
        break;
      case # "aim":
        actor aimatentityik(player, eventstruct.blend, eventstruct.weight);
        break;
      case # "head_eyes":
      default:
        actor lookatentity(player, 1, 0, 0, eventstruct.blend, eventstruct.weight);
        break;
    }

    return;
  }

  actor lookatentity();
}

function event_handler[event_5d98e413] function_81d4b0fe(eventstruct) {
  player = self;

  if(!isPlayer(player)) {
    player = getplayers()[0];
  }

  if(isDefined(player)) {
    player setviewclamp(eventstruct.minyaw, eventstruct.maxyaw, eventstruct.minpitch, eventstruct.maxpitch, 0, 0, eventstruct.blend);
  }
}

function event_handler[sidemission_launch] codecallback_launchsidemission(eventstruct) {
  switchmap_preload(eventstruct.name, eventstruct.game_type);
  luinotifyevent(#"open_side_mission_countdown", 1, eventstruct.list_index);
  wait 10;
  luinotifyevent(#"close_side_mission_countdown");
  switchmap_switch();
}

function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
  if(isPlayer(self) && !isbot(self)) {
    self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
  }
}

function event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
  if(isPlayer(self) && !isbot(self)) {
    self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
  }
}

function abort_level() {
  println("<dev string:x1d1>");
  println("<dev string:x231>");
  println("<dev string:x1d1>");

  level.callbackstartgametype = &callback_void;
  level.callbackplayerconnect = &callback_void;
  level.callbackplayerdisconnect = &callback_void;
  level.callbackplayerdamage = &callback_void;
  level.callbackplayerkilled = &callback_void;
  level.var_3a9881cb = &callback_void;
  level.callbackplayerlaststand = &callback_void;
  level.var_4268159 = &callback_void;
  level.var_69959686 = &callback_void;
  level.callbackplayermelee = &callback_void;
  level.callbackactordamage = &callback_void;
  level.callbackactorkilled = &callback_void;
  level.var_6788bf11 = &callback_void;
  level.callbackvehicledamage = &callback_void;
  level.callbackvehiclekilled = &callback_void;
  level.callbackactorspawned = &callback_void;

  if(isDefined(level._gametype_default)) {
    setDvar(#"g_gametype", level._gametype_default);
  }

  exitlevel(0);
}

function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
  level notify(#"glass_smash", {
    #position: eventstruct.position, #direction: eventstruct.direction
  });
}

function event_handler[freefall] function_5019e563(eventstruct) {
  self callback(#"freefall", eventstruct);
}

function event_handler[parachute] function_87b05fa3(eventstruct) {
  self callback(#"parachute", eventstruct);
}

function event_handler[skydive_touch] function_5bc68fd9(eventstruct) {
  self callback(#"skydive_touch", eventstruct);
}

function event_handler[skydive_end] function_250a9740(eventstruct) {
  self callback(#"skydive_end", eventstruct);
}

function event_handler[swimming_begin] function_e337eb32(eventstruct) {
  self callback(#"swimming", {
    #swimming: 1
  });
}

function event_handler[swimming_end] function_e142d2b2(eventstruct) {
  self callback(#"swimming", {
    #swimming: 0
  });
}

function event_handler[underwater] codecallback_underwater(eventstruct) {
  self callback(#"underwater", eventstruct);
}

function event_handler[event_d6f9e6ad] function_8877d89(eventstruct) {
  self callback(#"hash_42aa89b2a0951308", eventstruct);
}

function event_handler[player_callout] function_c91ebb30(eventstruct) {
  self callback(#"player_callout", eventstruct);
}

function event_handler[debug_movement] function_930ce3c3(eventstruct) {
  self callback(#"debug_movement", eventstruct);
}

function event_handler[flourish_start] function_86a28d6a(eventstruct) {
  self callback(#"flourish_start", eventstruct);
}

function event_handler[event_6ba27c50] function_d736b8a9(eventstruct) {
  self callback(#"hash_3b6ebf3a7ab5c795", eventstruct);
}

function event_handler[event_31e1c5e9] function_7d45bff(eventstruct) {
  self endon(#"death");
  level flag::wait_till("system_postinit_complete");
  self callback(#"on_trigger_spawned");
}

function event_handler[trigger] codecallback_trigger(eventstruct, look_trigger = 0) {
  self endon(#"death");

  if(look_trigger || !self trigger::is_look_trigger()) {
    self util::script_delay();
    self callback(#"on_trigger", eventstruct);
    self callback(#"on_trigger_once", eventstruct);
    self remove_on_trigger_once("all");
  }
}

function event_handler[entity_deleted] codecallback_entitydeleted(eventstruct) {
  self callback(#"on_entity_deleted");
}

function event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
  self callback(#"hash_767bb029d2dcda7c", eventstruct);
}

function event_handler[event_e054b61b] function_d658381b(eventstruct) {
  self callback(#"hash_6efb8cec1ca372dc");
}

function event_handler[event_46837d44] function_2ff20679(eventstruct) {
  self callback(#"hash_6280ac8ed281ce3c");
}

function event_handler[event_596b7bdc] function_f5026566(eventstruct) {
  if(!isDefined(level.var_abb3fd2)) {
    return;
  }

  eventdata = {};
  eventdata.tableindex = eventstruct.tableindex;
  eventdata.event_info = eventstruct.event_info;
  self[[level.var_abb3fd2]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

function event_handler[player_decoration] codecallback_decoration(eventstruct) {
  a_decorations = self getdecorations(1);

  if(!isDefined(a_decorations)) {
    return;
  }

  if(a_decorations.size == 12) {}

  level notify(#"decoration_awarded");
  [[level.callbackdecorationawarded]]();
}

function event_handler[event_4620dccd] function_a4a77d57(eventstruct) {
  if(isDefined(level.var_b24258)) {
    self[[level.var_b24258]](eventstruct);
  }
}

function event_handler[event_4e560379] function_d5edcd9a(eventstruct) {
  if(isDefined(level.var_ee39a80e)) {
    self[[level.var_ee39a80e]](eventstruct);
  }
}

function event_handler[event_ba6fea54] function_f4449e63(eventstruct) {
  if(isDefined(level.var_17c7288a)) {
    [[level.var_17c7288a]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_c5a66313);
  }
}

function event_handler[detonate] codecallback_detonate(eventstruct) {
  self callback(#"detonate", eventstruct);
}

function event_handler[doubletap_detonate] function_92aba4c4(eventstruct) {
  self callback(#"doubletap_detonate", eventstruct);
}

function event_handler[death] codecallback_death(eventstruct) {
  self notify(#"death", eventstruct);
  self callback(#"death", eventstruct);
}

function callback_void() {}