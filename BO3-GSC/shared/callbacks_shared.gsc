/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\callbacks_shared.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\simple_hostmigration;
#using scripts\shared\system_shared;
#namespace callback;

function callback(event, params) {
  if(isDefined(level._callbacks) && isDefined(level._callbacks[event])) {
    for(i = 0; i < level._callbacks[event].size; i++) {
      callback = level._callbacks[event][i][0];
      obj = level._callbacks[event][i][1];
      if(!isDefined(callback)) {
        continue;
      }
      if(isDefined(obj)) {
        if(isDefined(params)) {
          obj thread[[callback]](self, params);
        } else {
          obj thread[[callback]](self);
        }
        continue;
      }
      if(isDefined(params)) {
        self thread[[callback]](params);
        continue;
      }
      self thread[[callback]]();
    }
  }
}

function add_callback(event, func, obj) {
  assert(isDefined(event), "");
  if(!isDefined(level._callbacks) || !isDefined(level._callbacks[event])) {
    level._callbacks[event] = [];
  }
  foreach(callback in level._callbacks[event]) {
    if(callback[0] == func) {
      if(!isDefined(obj) || callback[1] == obj) {
        return;
      }
    }
  }
  array::add(level._callbacks[event], array(func, obj), 0);
  if(isDefined(obj)) {
    obj thread remove_callback_on_death(event, func);
  }
}

function remove_callback_on_death(event, func) {
  self waittill("death");
  remove_callback(event, func, self);
}

function remove_callback(event, func, obj) {
  assert(isDefined(event), "");
  assert(isDefined(level._callbacks[event]), "");
  foreach(index, func_group in level._callbacks[event]) {
    if(func_group[0] == func) {
      if(func_group[1] === obj) {
        arrayremoveindex(level._callbacks[event], index, 0);
        break;
      }
    }
  }
}

function on_finalize_initialization(func, obj) {
  add_callback("hash_36fb1b1a", func, obj);
}

function on_connect(func, obj) {
  add_callback("hash_eaffea17", func, obj);
}

function remove_on_connect(func, obj) {
  remove_callback("hash_eaffea17", func, obj);
}

function on_connecting(func, obj) {
  add_callback("hash_fefe13f5", func, obj);
}

function remove_on_connecting(func, obj) {
  remove_callback("hash_fefe13f5", func, obj);
}

function on_disconnect(func, obj) {
  add_callback("hash_aebdd257", func, obj);
}

function remove_on_disconnect(func, obj) {
  remove_callback("hash_aebdd257", func, obj);
}

function on_spawned(func, obj) {
  add_callback("hash_bc12b61f", func, obj);
}

function remove_on_spawned(func, obj) {
  remove_callback("hash_bc12b61f", func, obj);
}

function on_loadout(func, obj) {
  add_callback("hash_33bba039", func, obj);
}

function remove_on_loadout(func, obj) {
  remove_callback("hash_33bba039", func, obj);
}

function on_player_damage(func, obj) {
  add_callback("hash_ab5ecf6c", func, obj);
}

function remove_on_player_damage(func, obj) {
  remove_callback("hash_ab5ecf6c", func, obj);
}

function on_start_gametype(func, obj) {
  add_callback("hash_cc62acca", func, obj);
}

function on_joined_team(func, obj) {
  add_callback("hash_95a6c4c0", func, obj);
}

function on_joined_spectate(func, obj) {
  add_callback("hash_4c5ae192", func, obj);
}

function on_player_killed(func, obj) {
  add_callback("hash_bc435202", func, obj);
}

function remove_on_player_killed(func, obj) {
  remove_callback("hash_bc435202", func, obj);
}

function on_ai_killed(func, obj) {
  add_callback("hash_fc2ec5ff", func, obj);
}

function remove_on_ai_killed(func, obj) {
  remove_callback("hash_fc2ec5ff", func, obj);
}

function on_actor_killed(func, obj) {
  add_callback("hash_8c38c12e", func, obj);
}

function remove_on_actor_killed(func, obj) {
  remove_callback("hash_8c38c12e", func, obj);
}

function on_vehicle_spawned(func, obj) {
  add_callback("hash_bae82b92", func, obj);
}

function remove_on_vehicle_spawned(func, obj) {
  remove_callback("hash_bae82b92", func, obj);
}

function on_vehicle_killed(func, obj) {
  add_callback("hash_acb66515", func, obj);
}

function remove_on_vehicle_killed(func, obj) {
  remove_callback("hash_acb66515", func, obj);
}

function on_ai_damage(func, obj) {
  add_callback("hash_eb4a4369", func, obj);
}

function remove_on_ai_damage(func, obj) {
  remove_callback("hash_eb4a4369", func, obj);
}

function on_ai_spawned(func, obj) {
  add_callback("hash_f96ca9bc", func, obj);
}

function remove_on_ai_spawned(func, obj) {
  remove_callback("hash_f96ca9bc", func, obj);
}

function on_actor_damage(func, obj) {
  add_callback("hash_7b543e98", func, obj);
}

function remove_on_actor_damage(func, obj) {
  remove_callback("hash_7b543e98", func, obj);
}

function on_vehicle_damage(func, obj) {
  add_callback("hash_9bd1e27f", func, obj);
}

function remove_on_vehicle_damage(func, obj) {
  remove_callback("hash_9bd1e27f", func, obj);
}

function on_laststand(func, obj) {
  add_callback("hash_6751ab5b", func, obj);
}

function on_challenge_complete(func, obj) {
  add_callback("hash_b286c65c", func, obj);
}

function codecallback_preinitialization() {
  callback("hash_ecc6aecf");
  system::run_pre_systems();
}

function codecallback_finalizeinitialization() {
  system::run_post_systems();
  callback("hash_36fb1b1a");
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
    }
    if(isDefined(level.weapon_damage_callback_array[weapon.rootweapon])) {
      self thread[[level.weapon_damage_callback_array[weapon.rootweapon]]](eattacker, einflictor, weapon, meansofdeath, damage);
      return true;
    }
  }
  return false;
}

function add_weapon_watcher(callback) {
  if(!isDefined(level.weapon_watcher_callback_array)) {
    level.weapon_watcher_callback_array = [];
  }
  array::add(level.weapon_watcher_callback_array, callback);
}

function callback_weapon_watcher() {
  if(isDefined(level.weapon_watcher_callback_array)) {
    for(x = 0; x < level.weapon_watcher_callback_array.size; x++) {
      self[[level.weapon_watcher_callback_array[x]]]();
    }
  }
}

function codecallback_startgametype() {
  if(!isDefined(level.gametypestarted) || !level.gametypestarted) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

function codecallback_playerconnect() {
  self endon("disconnect");
  [[level.callbackplayerconnect]]();
}

function codecallback_playerdisconnect() {
  self notify("death");
  self.player_disconnected = 1;
  self notify("disconnect");
  level notify("disconnect", self);
  [[level.callbackplayerdisconnect]]();
  callback("hash_aebdd257");
}

function codecallback_migration_setupgametype() {
  println("");
  simple_hostmigration::migration_setupgametype();
}

function codecallback_hostmigration() {
  println("");
  # / [[level.callbackhostmigration]]();
}

function codecallback_hostmigrationsave() {
  println("");
  # / [[level.callbackhostmigrationsave]]();
}

function codecallback_prehostmigrationsave() {
  println("");
  # / [[level.callbackprehostmigrationsave]]();
}

function codecallback_playermigrated() {
  println("");
  # / [[level.callbackplayermigrated]]();
}

function codecallback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, vsurfacenormal) {
  self endon("disconnect");
  [[level.callbackplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, vsurfacenormal);
}

function codecallback_playerkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, deathanimduration) {
  self endon("disconnect");
  [[level.callbackplayerkilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, deathanimduration);
}

function codecallback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, delayoverride) {
  self endon("disconnect");
  [[level.callbackplayerlaststand]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset, delayoverride);
}

function codecallback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  self endon("disconnect");
  [[level.callbackplayermelee]](eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind);
}

function codecallback_actorspawned(spawner) {
  [[level.callbackactorspawned]](spawner);
}

function codecallback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
  [[level.callbackactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal);
}

function codecallback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset) {
  [[level.callbackactorkilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, timeoffset);
}

function codecallback_actorcloned(original) {
  [[level.callbackactorcloned]](original);
}

function codecallback_vehiclespawned(spawner) {
  if(isDefined(level.callbackvehiclespawned)) {
    [[level.callbackvehiclespawned]](spawner);
  }
}

function codecallback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  [[level.callbackvehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

function codecallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  [[level.callbackvehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal);
}

function codecallback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, timeoffset) {
  [[level.callbackvehicleradiusdamage]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, timeoffset);
}

function finishcustomtraversallistener() {
  self endon("death");
  self waittillmatch("custom_traversal_anim_finished");
  self finishtraversal();
  self unlink();
  self.usegoalanimweight = 0;
  self.blockingpain = 0;
  self.customtraverseendnode = undefined;
  self.customtraversestartnode = undefined;
  self notify("custom_traversal_cleanup", "end");
}

function killedcustomtraversallistener() {
  self endon("custom_traversal_cleanup");
  self waittill("death");
  if(isDefined(self)) {
    self finishtraversal();
    self stopanimscripted();
    self unlink();
  }
}

function codecallback_playcustomtraversal(entity, beginparent, endparent, origin, angles, animhandle, animmode, playbackspeed, goaltime, lerptime) {
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity.customtraverseendnode = entity.traverseendnode;
  entity.customtraversestartnode = entity.traversestartnode;
  entity animmode("noclip", 0);
  entity orientmode("face angle", angles[1]);
  if(isDefined(endparent)) {
    offset = entity.origin - endparent.origin;
    entity linkto(endparent, "", offset);
  }
  entity animscripted("custom_traversal_anim_finished", origin, angles, animhandle, animmode, undefined, playbackspeed, goaltime, lerptime);
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

function codecallback_menuresponse(action, arg) {
  if(!isDefined(level.menuresponsequeue)) {
    level.menuresponsequeue = [];
    level thread menu_response_queue_pump();
  }
  index = level.menuresponsequeue.size;
  level.menuresponsequeue[index] = spawnStruct();
  level.menuresponsequeue[index].action = action;
  level.menuresponsequeue[index].arg = arg;
  level.menuresponsequeue[index].ent = self;
  level notify("menuresponse_queue");
}

function menu_response_queue_pump() {
  while(true) {
    level waittill("menuresponse_queue");
    do {
      level.menuresponsequeue[0].ent notify("menuresponse", level.menuresponsequeue[0].action, level.menuresponsequeue[0].arg);
      arrayremoveindex(level.menuresponsequeue, 0, 0);
      wait(0.05);
    }
    while(level.menuresponsequeue.size > 0);
  }
}

function codecallback_callserverscript(pself, label, param) {
  if(!isDefined(level._animnotifyfuncs)) {
    return;
  }
  if(isDefined(level._animnotifyfuncs[label])) {
    pself[[level._animnotifyfuncs[label]]](param);
  }
}

function codecallback_callserverscriptonlevel(label, param) {
  if(!isDefined(level._animnotifyfuncs)) {
    return;
  }
  if(isDefined(level._animnotifyfuncs[label])) {
    level[[level._animnotifyfuncs[label]]](param);
  }
}

function codecallback_launchsidemission(str_mapname, str_gametype, int_list_index, int_lighting) {
  switchmap_preload(str_mapname, str_gametype, int_lighting);
  luinotifyevent(&"open_side_mission_countdown", 1, int_list_index);
  wait(10);
  luinotifyevent(&"close_side_mission_countdown");
  switchmap_switch();
}

function codecallback_fadeblackscreen(duration, blendtime) {
  for(i = 0; i < level.players.size; i++) {
    if(isDefined(level.players[i])) {
      level.players[i] thread hud::fade_to_black_for_x_sec(0, duration, blendtime, blendtime);
    }
  }
}

function codecallback_setactivecybercomability(new_ability) {
  self notify("setcybercomability", new_ability);
}

function abort_level() {
  println("");
  level.callbackstartgametype = &callback_void;
  level.callbackplayerconnect = &callback_void;
  level.callbackplayerdisconnect = &callback_void;
  level.callbackplayerdamage = &callback_void;
  level.callbackplayerkilled = &callback_void;
  level.callbackplayerlaststand = &callback_void;
  level.callbackplayermelee = &callback_void;
  level.callbackactordamage = &callback_void;
  level.callbackactorkilled = &callback_void;
  level.callbackvehicledamage = &callback_void;
  level.callbackvehiclekilled = &callback_void;
  level.callbackactorspawned = &callback_void;
  level.callbackbotentereduseredge = &callback_void;
  if(isDefined(level._gametype_default)) {
    setDvar("g_gametype", level._gametype_default);
  }
  exitlevel(0);
}

function codecallback_glasssmash(pos, dir) {
  level notify("glass_smash", pos, dir);
}

function codecallback_botentereduseredge(startnode, endnode) {
  [[level.callbackbotentereduseredge]](startnode, endnode);
}

function codecallback_decoration(name) {
  a_decorations = self getdecorations(1);
  if(!isDefined(a_decorations)) {
    return;
  }
  if(a_decorations.size == 12) {
    self notify("give_achievement", "CP_ALL_DECORATIONS");
  }
  a_all_decorations = self getdecorations();
  if(a_decorations.size == (a_all_decorations.size - 1)) {
    self givedecoration("cp_medal_all_decorations");
  }
  level notify("decoration_awarded");
  [[level.callbackdecorationawarded]]();
}

function callback_void() {}