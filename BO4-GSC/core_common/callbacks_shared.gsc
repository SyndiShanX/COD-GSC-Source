/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\callbacks_shared.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\simple_hostmigration;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\voice\voice_events;

#namespace callback;

callback(event, params) {
  mpl_heatwave_fx(level, event, params);

  if(self != level) {
    mpl_heatwave_fx(self, event, params);
  }
}

function_bea20a96(event, params) {
  ais = getaiarray();

  foreach(ai in ais) {
    ai mpl_heatwave_fx(ai, event, params);
  }
}

function_daed27e8(event, params) {
  mpl_heatwave_fx(level, event, params);
  players = getplayers();

  foreach(player in players) {
    player mpl_heatwave_fx(player, event, params);
  }
}

private mpl_heatwave_fx(ent, event, params) {
  if(isDefined(ent) && isDefined(ent._callbacks) && isDefined(ent._callbacks[event])) {
    for(i = 0; i < ent._callbacks[event].size; i++) {
      if(!isarray(ent._callbacks[event][i])) {
        continue;
      }

      callback = ent._callbacks[event][i][0];
      assert(isfunctionptr(callback), "<dev string:x38>" + "<dev string:x52>");

      if(!isfunctionptr(callback)) {
        return;
      }

      obj = ent._callbacks[event][i][1];
      var_47e0b77b = isDefined(ent._callbacks[event][i][2]) ? ent._callbacks[event][i][2] : [];

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

    arrayremovevalue(ent._callbacks[event], 0, 0);
  }
}

add_callback(event, func, obj, a_params) {
  function_2b653c00(level, event, func, obj, a_params);
}

function_d8abfc3d(event, func, obj, a_params) {
  function_2b653c00(self, event, func, obj, a_params);
}

private function_2b653c00(ent, event, func, obj, a_params) {
  if(!isDefined(ent)) {
    return;
  }

  assert(isfunctionptr(func), "<dev string:x6e>" + "<dev string:x52>");

  if(!isfunctionptr(func)) {
    return;
  }

  assert(isDefined(event), "<dev string:x91>");

  if(!isDefined(ent._callbacks) || !isDefined(ent._callbacks[event])) {
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

private function_862146b3(event, func) {
  return string(event) + string(func);
}

remove_callback_on_death(event, func) {
  self notify(function_862146b3(event, func));
  self endon(function_862146b3(event, func));
  self util::waittill_either("death", "remove_callbacks");
  remove_callback(event, func, self);
}

remove_callback(event, func, obj) {
  function_3f5f097e(level, event, func, obj);
}

function_52ac9652(event, func, obj, instant) {
  function_3f5f097e(self, event, func, obj, instant);
}

private function_3f5f097e(ent, event, func, obj, instant) {
  if(!isDefined(ent._callbacks)) {
    return;
  }

  assert(isDefined(event), "<dev string:xc3>");

  if(func === "all") {
    ent._callbacks[event] = [];
    return;
  }

  assert(isDefined(ent._callbacks[event]), "<dev string:xf8>");

  if(!isDefined(ent._callbacks[event])) {
    return;
  }

  if(isDefined(instant) && instant) {
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

on_finalize_initialization(func, obj) {
  add_callback(#"on_finalize_initialization", func, obj);
}

on_connect(func, obj, ...) {
  add_callback(#"on_player_connect", func, obj, vararg);
}

remove_on_connect(func, obj) {
  remove_callback(#"on_player_connect", func, obj);
}

on_connecting(func, obj) {
  add_callback(#"on_player_connecting", func, obj);
}

remove_on_connecting(func, obj) {
  remove_callback(#"on_player_connecting", func, obj);
}

on_disconnect(func, obj) {
  add_callback(#"on_player_disconnect", func, obj);
}

remove_on_disconnect(func, obj) {
  remove_callback(#"on_player_disconnect", func, obj);
}

on_spawned(func, obj) {
  add_callback(#"on_player_spawned", func, obj);
}

remove_on_spawned(func, obj) {
  remove_callback(#"on_player_spawned", func, obj);
}

remove_on_revived(func, obj) {
  remove_callback(#"on_player_revived", func, obj);
}

on_deleted(func, obj) {
  add_callback(#"on_entity_deleted", func, obj);
}

remove_on_deleted(func, obj) {
  remove_callback(#"on_entity_deleted", func, obj);
}

on_loadout(func, obj) {
  add_callback(#"on_loadout", func, obj);
}

remove_on_loadout(func, obj) {
  remove_callback(#"on_loadout", func, obj);
}

on_player_damage(func, obj) {
  add_callback(#"on_player_damage", func, obj);
}

remove_on_player_damage(func, obj) {
  remove_callback(#"on_player_damage", func, obj);
}

on_start_gametype(func, obj) {
  add_callback(#"on_start_gametype", func, obj);
}

on_end_game(func, obj) {
  add_callback(#"on_end_game", func, obj);
}

on_game_shutdown(func, obj) {
  add_callback(#"on_game_shutdown", func, obj);
}

on_game_playing(func, obj) {
  add_callback(#"on_game_playing", func, obj);
}

on_joined_team(func, obj) {
  add_callback(#"joined_team", func, obj);
}

on_joined_spectate(func, obj) {
  add_callback(#"on_joined_spectate", func, obj);
}

on_player_killed(func, obj) {
  add_callback(#"on_player_killed", func, obj);
}

on_player_killed_with_params(func, obj) {
  add_callback(#"on_player_killed_with_params", func, obj);
}

on_player_corpse(func, obj) {
  add_callback(#"on_player_corpse", func, obj);
}

remove_on_player_killed(func, obj) {
  remove_callback(#"on_player_killed", func, obj);
}

remove_on_player_killed_with_params(func, obj) {
  remove_callback(#"on_player_killed_with_params", func, obj);
}

function_80270643(func, obj) {
  add_callback(#"on_team_eliminated", func, obj);
}

function_c53a8ab8(func, obj) {
  remove_callback(#"on_team_eliminated", func, obj);
}

on_ai_killed(func, obj) {
  add_callback(#"on_ai_killed", func, obj);
}

remove_on_ai_killed(func, obj) {
  remove_callback(#"on_ai_killed", func, obj);
}

on_actor_killed(func, obj) {
  add_callback(#"on_actor_killed", func, obj);
}

remove_on_actor_killed(func, obj) {
  remove_callback(#"on_actor_killed", func, obj);
}

on_vehicle_spawned(func, obj) {
  add_callback(#"on_vehicle_spawned", func, obj);
}

remove_on_vehicle_spawned(func, obj) {
  remove_callback(#"on_vehicle_spawned", func, obj);
}

on_vehicle_killed(func, obj) {
  add_callback(#"on_vehicle_killed", func, obj);
}

on_vehicle_collision(func, obj) {
  function_d8abfc3d(#"veh_collision", func, obj);
}

remove_on_vehicle_killed(func, obj) {
  remove_callback(#"on_vehicle_killed", func, obj);
}

on_ai_damage(func, obj) {
  add_callback(#"on_ai_damage", func, obj);
}

remove_on_ai_damage(func, obj) {
  remove_callback(#"on_ai_damage", func, obj);
}

on_ai_spawned(func, obj) {
  add_callback(#"on_ai_spawned", func, obj);
}

remove_on_ai_spawned(func, obj) {
  remove_callback(#"on_ai_spawned", func, obj);
}

on_actor_damage(func, obj) {
  add_callback(#"on_actor_damage", func, obj);
}

remove_on_actor_damage(func, obj) {
  remove_callback(#"on_actor_damage", func, obj);
}

on_scriptmover_damage(func, obj) {
  add_callback(#"on_scriptmover_damage", func, obj);
}

remove_on_scriptmover_damage(func, obj) {
  remove_callback(#"on_scriptmover_damage", func, obj);
}

on_vehicle_damage(func, obj) {
  add_callback(#"on_vehicle_damage", func, obj);
}

remove_on_vehicle_damage(func, obj) {
  remove_callback(#"on_vehicle_damage", func, obj);
}

on_downed(func, obj) {
  add_callback(#"on_player_downed", func, obj);
}

remove_on_downed(func, obj) {
  remove_callback(#"on_player_downed", func, obj);
}

on_laststand(func, obj) {
  add_callback(#"on_player_laststand", func, obj);
}

remove_on_laststand(func, obj) {
  remove_callback(#"on_player_laststand", func, obj);
}

on_bleedout(func, obj) {
  add_callback(#"on_player_bleedout", func, obj);
}

on_revived(func, obj) {
  add_callback(#"on_player_revived", func, obj);
}

on_mission_failed(func, obj) {
  add_callback(#"on_mission_failed", func, obj);
}

on_challenge_complete(func, obj) {
  add_callback(#"on_challenge_complete", func, obj);
}

on_weapon_change(func, obj) {
  add_callback(#"weapon_change", func, obj);
}

remove_on_weapon_change(func, obj) {
  remove_callback(#"weapon_change", func, obj);
}

on_weapon_fired(func, obj) {
  add_callback(#"weapon_fired", func, obj);
}

remove_on_weapon_fired(func, obj) {
  remove_callback(#"weapon_fired", func, obj);
}

on_grenade_fired(func, obj) {
  add_callback(#"grenade_fired", func, obj);
}

remove_on_grenade_fired(func, obj) {
  remove_callback(#"grenade_fired", func, obj);
}

on_offhand_fire(func, obj) {
  add_callback(#"offhand_fire", func, obj);
}

remove_on_offhand_fire(func, obj) {
  remove_callback(#"offhand_fire", func, obj);
}

function_4b7977fe(func, obj) {
  add_callback(#"hash_198a389d6b65f68d", func, obj);
}

function_61583a71(func, obj) {
  remove_callback(#"hash_198a389d6b65f68d", func, obj);
}

on_detonate(func, obj) {
  function_d8abfc3d(#"detonate", func, obj);
}

remove_on_detonate(func, obj) {
  function_52ac9652(#"detonate", func, obj);
}

on_double_tap_detonate(func, obj) {
  function_d8abfc3d(#"doubletap_detonate", func, obj);
}

remove_on_double_tap_detonate(func, obj) {
  function_52ac9652(#"doubletap_detonate", func, obj);
}

on_death(func, obj) {
  function_d8abfc3d(#"death", func, obj);
}

remove_on_death(func, obj) {
  function_52ac9652(#"death", func, obj);
}

on_trigger_spawned(func, obj) {
  add_callback(#"on_trigger_spawned", func, obj);
}

on_trigger(func, obj, ...) {
  function_d8abfc3d(#"on_trigger", func, obj, vararg);
}

remove_on_trigger(func, obj) {
  function_52ac9652(#"on_trigger", func, obj);
}

on_trigger_once(func, obj, ...) {
  function_d8abfc3d(#"on_trigger_once", func, obj, vararg);
}

remove_on_trigger_once(func, obj) {
  function_52ac9652(#"on_trigger_once", func, obj);
}

function_33f0ddd3(func, obj) {
  add_callback(#"hash_39bf72fd97e248a0", func, obj);
}

function_824d206(func, obj) {
  remove_callback(#"hash_39bf72fd97e248a0", func, obj);
}

on_boast(func, obj) {
  add_callback(#"on_boast", func, obj);
}

remove_on_boast(func, obj) {
  remove_callback(#"on_boast", func, obj);
}

function_5753ac6e(func, obj) {
  add_callback(#"hash_4a9c56bba76da754", func, obj);
}

function_16046baa(func, obj) {
  remove_callback(#"hash_4a9c56bba76da754", func, obj);
}

on_menu_response(func, obj) {
  add_callback(#"on_menu_response", func, obj);
}

on_item_pickup(func, obj) {
  add_callback(#"on_item_pickup", func, obj);
}

on_item_drop(func, obj) {
  add_callback(#"on_drop_item", func, obj);
}

on_drop_inventory(func, obj) {
  add_callback(#"on_drop_inventory", func, obj);
}

on_item_use(func, obj) {
  add_callback(#"on_item_use", func, obj);
}

on_stash_open(func, obj) {
  add_callback(#"on_stash_open", func, obj);
}

on_character_unlock(func, obj) {
  add_callback(#"on_character_unlock", func, obj);
}

on_contract_complete(func, obj) {
  add_callback(#"contract_complete", func, obj);
}

event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
  callback(#"on_pre_initialization");
  system::run_pre_systems();
}

event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
  system::run_post_systems();
  callback(#"on_finalize_initialization");
}

add_weapon_damage(weapontype, callback) {
  if(!isDefined(level.weapon_damage_callback_array)) {
    level.weapon_damage_callback_array = [];
  }

  level.weapon_damage_callback_array[weapontype] = callback;
}

callback_weapon_damage(eattacker, einflictor, weapon, meansofdeath, damage) {
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

add_weapon_fired(weapon, callback) {
  if(!isDefined(level.var_129c2069)) {
    level.var_129c2069 = [];
  }

  level.var_129c2069[weapon] = callback;
}

callback_weapon_fired(weapon) {
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

event_handler[gametype_start] codecallback_startgametype(eventstruct) {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

event_handler[player_connect] codecallback_playerconnect(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerconnect]]();
}

event_handler[player_disconnect] codecallback_playerdisconnect(eventstruct) {
  self notify(#"death");
  self.player_disconnected = 1;
  self notify(#"disconnect");
  level notify(#"disconnect", self);
  [[level.callbackplayerdisconnect]]();
  callback(#"on_player_disconnect");
}

event_handler[hostmigration_setupgametype] codecallback_migration_setupgametype() {
  println("<dev string:x127>");
  simple_hostmigration::migration_setupgametype();
}

event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
  println("<dev string:x156>");
  [[level.callbackhostmigration]]();
}

event_handler[hostmigration_save] codecallback_hostmigrationsave(eventstruct) {
  println("<dev string:x17b>");
  [[level.callbackhostmigrationsave]]();
}

event_handler[hostmigration_premigrationsave] codecallback_prehostmigrationsave(eventstruct) {
  println("<dev string:x1a4>");
  [[level.callbackprehostmigrationsave]]();
}

event_handler[hostmigration_playermigrated] codecallback_playermigrated(eventstruct) {
  println("<dev string:x1d0>");
  [[level.callbackplayermigrated]]();
}

event_handler[player_damage] codecallback_playerdamage(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.normal);
}

event_handler[player_killed] codecallback_playerkilled(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayerkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.death_anim_duration);
}

event_handler[event_2958ea55] function_73e8e3f9(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_3a9881cb)) {
    [[level.var_3a9881cb]](eventstruct.attacker, eventstruct.effect_name, eventstruct.var_894859a2, eventstruct.durationoverride, eventstruct.weapon);
  }
}

event_handler[event_a98a54a7] function_323548ba(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayershielddamageblocked]](eventstruct.damage);
}

event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
  self endon(#"disconnect");
  self stopanimscripted();
  [[level.callbackplayerlaststand]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset, eventstruct.delay);
}

event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
  self endon(#"disconnect");
  [[level.var_69959686]](eventstruct.weapon);
}

event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_bb1ea3f1)) {
    [[level.var_bb1ea3f1]](eventstruct.weapon);
  }
}

event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_2f64d35)) {
    [[level.var_2f64d35]](eventstruct.weapon);
  }
}

event_handler[event_bf57d5bb] function_d7eb3672(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_a28be0a5)) {
    [[level.var_a28be0a5]](eventstruct.weapon);
  }
}

event_handler[event_e9b4bb47] function_7dba9a1(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_bd0b5fc1)) {
    [[level.var_bd0b5fc1]](eventstruct.weapon);
  }
}

event_handler[player_boast] function_3b159f77(eventstruct) {
  self endon(#"disconnect");

  if(isDefined(level.var_4268159)) {
    [[level.var_4268159]](eventstruct.gestureindex, eventstruct.animlength);
  }

  callback(#"on_boast", eventstruct);
}

event_handler[event_8451509a] function_e35aeddd(eventstruct) {
  self endon(#"disconnect");
  callback(#"hash_4a9c56bba76da754");
}

event_handler[player_melee] codecallback_playermelee(eventstruct) {
  self endon(#"disconnect");
  [[level.callbackplayermelee]](eventstruct.attacker, eventstruct.amount, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.bone_index, eventstruct.is_shieldhit, eventstruct.is_frombehind);
}

event_handler[actor_spawned] codecallback_actorspawned(eventstruct) {
  self[[level.callbackactorspawned]](eventstruct.entity);
}

event_handler[actor_damage] codecallback_actordamage(eventstruct) {
  [[level.callbackactordamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.surface_type, eventstruct.normal);
}

event_handler[actor_killed] codecallback_actorkilled(eventstruct) {
  [[level.callbackactorkilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

event_handler[actor_cloned] codecallback_actorcloned(eventstruct) {
  [[level.callbackactorcloned]](eventstruct.clone);
}

event_handler[event_1524de24] function_5b0a9275(eventstruct) {
  [[level.var_6788bf11]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.bone_index, eventstruct.model_index, eventstruct.part_name, eventstruct.surface_type, eventstruct.normal);
}

event_handler[vehicle_spawned] codecallback_vehiclespawned(eventstruct) {
  if(isDefined(level.callbackvehiclespawned)) {
    [[level.callbackvehiclespawned]](eventstruct.spawner);
  }
}

event_handler[vehicle_killed] codecallback_vehiclekilled(eventstruct) {
  [[level.callbackvehiclekilled]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.mod, eventstruct.weapon, eventstruct.direction, eventstruct.hit_location, eventstruct.time_offset);
}

event_handler[vehicle_damage] codecallback_vehicledamage(eventstruct) {
  [[level.callbackvehicledamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.direction, eventstruct.hit_location, eventstruct.damage_origin, eventstruct.time_offset, eventstruct.damage_from_underneath, eventstruct.model_index, eventstruct.part_name, eventstruct.normal);
}

event_handler[vehicle_radiusdamage] codecallback_vehicleradiusdamage(eventstruct) {
  [[level.callbackvehicleradiusdamage]](eventstruct.inflictor, eventstruct.attacker, eventstruct.amount, eventstruct.inner_damage, eventstruct.outer_damage, eventstruct.flags, eventstruct.mod, eventstruct.weapon, eventstruct.position, eventstruct.outer_radius, eventstruct.cone_angle, eventstruct.cone_direction, eventstruct.time_offset);
}

finishcustomtraversallistener() {
  self endon(#"death");
  self waittillmatch({
    #notetrack: "end"
  }, #"custom_traversal_anim_finished");
  self finishtraversal();
  self unlink();
  self.usegoalanimweight = 0;
  self.blockingpain = 0;
  self.customtraverseendnode = undefined;
  self.customtraversestartnode = undefined;
  self notify(#"custom_traversal_cleanup");
}

killedcustomtraversallistener() {
  self endon(#"custom_traversal_cleanup");
  self waittill(#"death");

  if(isDefined(self)) {
    self finishtraversal();
    self stopanimscripted();
    self unlink();
  }
}

event_handler[entity_playcustomtraversal] codecallback_playcustomtraversal(eventstruct) {
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

codecallback_faceeventnotify(notify_msg, ent) {
  if(isDefined(ent) && isDefined(ent.do_face_anims) && ent.do_face_anims) {
    if(isDefined(level.face_event_handler) && isDefined(level.face_event_handler.events[notify_msg])) {
      ent sendfaceevent(level.face_event_handler.events[notify_msg]);
    }
  }
}

event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
  if(!isDefined(level.menuresponsequeue)) {
    level.menuresponsequeue = [];
    level thread menu_response_queue_pump();
  }

  index = level.menuresponsequeue.size;
  level.menuresponsequeue[index] = {
    #ent: self, 
    #eventstruct: eventstruct
  };
  level notify(#"menuresponse_queue");
}

menu_response_queue_pump() {
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

event_handler[notetrack_callserverscript] codecallback_callserverscript(eventstruct) {
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

event_handler[notetrack_callserverscriptonlevel] codecallback_callserverscriptonlevel(eventstruct) {
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

event_handler[event_69572c01] function_2073f6dc(eventstruct) {
  origin = self.origin;
  magnitude = float(eventstruct.magnitude);
  innerradius = float(eventstruct.innerradius);
  outerradius = int(eventstruct.outerradius);
  innerdamage = isDefined(self.var_f501d778) ? self.var_f501d778 : 50;
  outerdamage = isDefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
  physicsexplosionsphere(origin, outerradius, innerradius, magnitude, outerdamage, innerdamage);
}

event_handler[sidemission_launch] codecallback_launchsidemission(eventstruct) {
  switchmap_preload(eventstruct.name, eventstruct.game_type);
  luinotifyevent(#"open_side_mission_countdown", 1, eventstruct.list_index);
  wait 10;
  luinotifyevent(#"close_side_mission_countdown");
  switchmap_switch();
}

event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
  if(isplayer(self) && !isbot(self)) {
    self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
  }
}

event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
  if(isplayer(self) && !isbot(self)) {
    self thread hud::fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
  }
}

abort_level() {
  println("<dev string:x1f6>");
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
  level.callbackbotentereduseredge = &callback_void;
  level.callbackbotcreateplayerbot = &callback_void;
  level.callbackbotshutdown = &callback_void;

  if(isDefined(level._gametype_default)) {
    setdvar(#"g_gametype", level._gametype_default);
  }

  exitlevel(0);
}

event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
  level notify(#"glass_smash", {
    #position: eventstruct.position, 
    #direction: eventstruct.direction
  });
}

event_handler[freefall] function_5019e563(eventstruct) {
  self callback(#"freefall", eventstruct);
}

event_handler[parachute] function_87b05fa3(eventstruct) {
  self callback(#"parachute", eventstruct);
}

event_handler[swimming] codecallback_swimming(eventstruct) {
  self callback(#"swimming", eventstruct);
}

event_handler[underwater] codecallback_underwater(eventstruct) {
  self callback(#"underwater", eventstruct);
}

event_handler[event_d6f9e6ad] function_8877d89(eventstruct) {
  self callback(#"hash_42aa89b2a0951308", eventstruct);
}

event_handler[debug_movement] function_930ce3c3(eventstruct) {
  self callback(#"debug_movement", eventstruct);
}

event_handler[event_31e1c5e9] function_7d45bff(eventstruct) {
  self endon(#"death");
  level flagsys::wait_till("system_init_complete");
  self callback(#"on_trigger_spawned");
}

event_handler[trigger] codecallback_trigger(eventstruct, look_trigger = 0) {
  if(look_trigger || !trigger::is_look_trigger()) {
    self util::script_delay();
    self callback(#"on_trigger", eventstruct);
    self callback(#"on_trigger_once", eventstruct);
    self remove_on_trigger_once("all");
  }
}

event_handler[entity_deleted] codecallback_entitydeleted(eventstruct) {
  self callback(#"on_entity_deleted");
}

event_handler[bot_enteruseredge] codecallback_botentereduseredge(eventstruct) {
  self[[level.callbackbotentereduseredge]](eventstruct.start_node, eventstruct.end_node, eventstruct.mantle_node, eventstruct.start_position, eventstruct.end_position, eventstruct.var_a8cc518d);
}

event_handler[bot_create_player_bot] codecallback_botcreateplayerbot(eventstruct) {
  self[[level.callbackbotcreateplayerbot]]();
}

event_handler[bot_stop_update] codecallback_botstopupdate(eventstruct) {
  self[[level.callbackbotshutdown]]();
}

event_handler[voice_event] function_451258ba(eventstruct) {
  self voice_events::function_c710099c(eventstruct.event, eventstruct.params);
}

event_handler[event_596b7bdc] function_f5026566(eventstruct) {
  if(!isDefined(level.var_abb3fd2)) {
    return;
  }

  eventdata = {};
  eventdata.tableindex = eventstruct.tableindex;
  eventdata.event_info = eventstruct.event_info;
  self[[level.var_abb3fd2]](eventstruct.event_name, eventstruct.time, eventstruct.client, eventstruct.priority, eventdata);
}

event_handler[player_decoration] codecallback_decoration(eventstruct) {
  a_decorations = self getdecorations(1);

  if(!isDefined(a_decorations)) {
    return;
  }

  if(a_decorations.size == 12) {}

  level notify(#"decoration_awarded");
  [[level.callbackdecorationawarded]]();
}

event_handler[event_ba6fea54] function_f4449e63(eventstruct) {
  if(isDefined(level.var_17c7288a)) {
    [[level.var_17c7288a]](eventstruct.player, eventstruct.eventtype, eventstruct.eventdata, eventstruct.var_c5a66313);
  }
}

event_handler[detonate] codecallback_detonate(eventstruct) {
  self callback(#"detonate", eventstruct);
}

event_handler[doubletap_detonate] function_92aba4c4(eventstruct) {
  self callback(#"doubletap_detonate", eventstruct);
}

event_handler[death] codecallback_death(eventstruct) {
  self callback(#"death", eventstruct);
}

callback_void() {}