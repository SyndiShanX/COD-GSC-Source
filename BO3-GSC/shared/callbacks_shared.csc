/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\callbacks_shared.csc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\footsteps_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace callback;

function callback(event, localclientnum, params) {
  if(isdefined(level._callbacks) && isdefined(level._callbacks[event])) {
    for (i = 0; i < level._callbacks[event].size; i++) {
      callback = level._callbacks[event][i][0];
      obj = level._callbacks[event][i][1];
      if(!isdefined(callback)) {
        continue;
      }
      if(isdefined(obj)) {
        if(isdefined(params)) {
          obj thread[[callback]](localclientnum, self, params);
        } else {
          obj thread[[callback]](localclientnum, self);
        }
        continue;
      }
      if(isdefined(params)) {
        self thread[[callback]](localclientnum, params);
        continue;
      }
      self thread[[callback]](localclientnum);
    }
  }
}

function entity_callback(event, localclientnum, params) {
  if(isdefined(self._callbacks) && isdefined(self._callbacks[event])) {
    for (i = 0; i < self._callbacks[event].size; i++) {
      callback = self._callbacks[event][i][0];
      obj = self._callbacks[event][i][1];
      if(!isdefined(callback)) {
        continue;
      }
      if(isdefined(obj)) {
        if(isdefined(params)) {
          obj thread[[callback]](localclientnum, self, params);
        } else {
          obj thread[[callback]](localclientnum, self);
        }
        continue;
      }
      if(isdefined(params)) {
        self thread[[callback]](localclientnum, params);
        continue;
      }
      self thread[[callback]](localclientnum);
    }
  }
}

function add_callback(event, func, obj) {
  assert(isdefined(event), "");
  if(!isdefined(level._callbacks) || !isdefined(level._callbacks[event])) {
    level._callbacks[event] = [];
  }
  foreach(callback in level._callbacks[event]) {
    if(callback[0] == func) {
      if(!isdefined(obj) || callback[1] == obj) {
        return;
      }
    }
  }
  array::add(level._callbacks[event], array(func, obj), 0);
  if(isdefined(obj)) {
    obj thread remove_callback_on_death(event, func);
  }
}

function add_entity_callback(event, func, obj) {
  assert(isdefined(event), "");
  if(!isdefined(self._callbacks) || !isdefined(self._callbacks[event])) {
    self._callbacks[event] = [];
  }
  foreach(callback in self._callbacks[event]) {
    if(callback[0] == func) {
      if(!isdefined(obj) || callback[1] == obj) {
        return;
      }
    }
  }
  array::add(self._callbacks[event], array(func, obj), 0);
}

function remove_callback_on_death(event, func) {
  self waittill("death");
  remove_callback(event, func, self);
}

function remove_callback(event, func, obj) {
  assert(isdefined(event), "");
  assert(isdefined(level._callbacks[event]), "");
  foreach(index, func_group in level._callbacks[event]) {
    if(func_group[0] == func) {
      if(func_group[1] === obj) {
        arrayremoveindex(level._callbacks[event], index, 0);
      }
    }
  }
}

function on_localclient_connect(func, obj) {
  add_callback("hash_da8d7d74", func, obj);
}

function on_localclient_shutdown(func, obj) {
  add_callback("hash_e64327a6", func, obj);
}

function on_finalize_initialization(func, obj) {
  add_callback("hash_36fb1b1a", func, obj);
}

function on_localplayer_spawned(func, obj) {
  add_callback("hash_842e788a", func, obj);
}

function remove_on_localplayer_spawned(func, obj) {
  remove_callback("hash_842e788a", func, obj);
}

function on_spawned(func, obj) {
  add_callback("hash_bc12b61f", func, obj);
}

function remove_on_spawned(func, obj) {
  remove_callback("hash_bc12b61f", func, obj);
}

function on_shutdown(func, obj) {
  add_entity_callback("hash_390259d9", func, obj);
}

function on_start_gametype(func, obj) {
  add_callback("hash_cc62acca", func, obj);
}

function codecallback_preinitialization() {
  callback("hash_ecc6aecf");
  system::run_pre_systems();
}

function codecallback_finalizeinitialization() {
  system::run_post_systems();
  callback("hash_36fb1b1a");
}

function codecallback_statechange(clientnum, system, newstate) {
  if(!isdefined(level._systemstates)) {
    level._systemstates = [];
  }
  if(!isdefined(level._systemstates[system])) {
    level._systemstates[system] = spawnstruct();
  }
  level._systemstates[system].state = newstate;
  if(isdefined(level._systemstates[system].callback)) {
    [
      [level._systemstates[system].callback]
    ](clientnum, newstate);
  } else {
    println(("" + system) + "");
  }
}

function codecallback_maprestart() {
  println("");
  util::waitforclient(0);
  level thread util::init_utility();
}

function codecallback_localclientconnect(localclientnum) {
  println("" + localclientnum);
  # / [[level.callbacklocalclientconnect]](localclientnum);
}

function codecallback_localclientdisconnect(clientnum) {
  println("" + clientnum);
}

function codecallback_glasssmash(org, dir) {
  level notify("glass_smash", org, dir);
}

function codecallback_soundsetambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
  audio::setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom);
}

function codecallback_soundsetaiambientstate(triggers, actors, numtriggers) {}

function codecallback_soundplayuidecodeloop(decodestring, playtimems) {
  self thread audio::soundplayuidecodeloop(decodestring, playtimems);
}

function codecallback_playerspawned(localclientnum) {
  println("");
  # / [[level.callbackplayerspawned]](localclientnum);
}

function codecallback_gibevent(localclientnum, type, locations) {
  if(isdefined(level._gibeventcbfunc)) {
    self thread[[level._gibeventcbfunc]](localclientnum, type, locations);
  }
}

function codecallback_precachegametype() {
  if(isdefined(level.callbackprecachegametype)) {
    [
      [level.callbackprecachegametype]
    ]();
  }
}

function codecallback_startgametype() {
  if(isdefined(level.callbackstartgametype) && (!isdefined(level.gametypestarted) || !level.gametypestarted)) {
    [
      [level.callbackstartgametype]
    ]();
    level.gametypestarted = 1;
  }
}

function codecallback_entityspawned(localclientnum) {
  [[level.callbackentityspawned]](localclientnum);
}

function codecallback_soundnotify(localclientnum, entity, note) {
  switch (note) {
    case "scr_bomb_beep": {
      if(getgametypesetting("silentPlant") == 0) {
        entity playsound(localclientnum, "fly_bomb_buttons_npc");
      }
      break;
    }
  }
}

function codecallback_entityshutdown(localclientnum, entity) {
  if(isdefined(level.callbackentityshutdown)) {
    [
      [level.callbackentityshutdown]
    ](localclientnum, entity);
  }
  entity entity_callback("hash_390259d9", localclientnum);
}

function codecallback_localclientshutdown(localclientnum, entity) {
  level.localplayers = getlocalplayers();
  entity callback("hash_e64327a6", localclientnum);
}

function codecallback_localclientchanged(localclientnum, entity) {
  level.localplayers = getlocalplayers();
}

function codecallback_airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
  if(isdefined(level.callbackairsupport)) {
    [
      [level.callbackairsupport]
    ](localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height);
  }
}

function codecallback_demojump(localclientnum, time) {
  level notify("demo_jump", time);
  level notify("demo_jump" + localclientnum, time);
}

function codecallback_demoplayerswitch(localclientnum) {
  level notify("demo_player_switch");
  level notify("demo_player_switch" + localclientnum);
}

function codecallback_playerswitch(localclientnum) {
  level notify("player_switch");
  level notify("player_switch" + localclientnum);
}

function codecallback_killcambegin(localclientnum, time) {
  level notify("killcam_begin", time);
  level notify("killcam_begin" + localclientnum, time);
}

function codecallback_killcamend(localclientnum, time) {
  level notify("killcam_end", time);
  level notify("killcam_end" + localclientnum, time);
}

function codecallback_creatingcorpse(localclientnum, player) {
  if(isdefined(level.callbackcreatingcorpse)) {
    [
      [level.callbackcreatingcorpse]
    ](localclientnum, player);
  }
}

function codecallback_playerfoliage(client_num, player, firstperson, quiet) {
  footsteps::playerfoliage(client_num, player, firstperson, quiet);
}

function codecallback_activateexploder(exploder_id) {
  if(!isdefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;
  for (i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }
  if(!isdefined(exploder)) {
    return;
  }
  exploder::activate_exploder(exploder);
}

function codecallback_deactivateexploder(exploder_id) {
  if(!isdefined(level._exploder_ids)) {
    return;
  }
  keys = getarraykeys(level._exploder_ids);
  exploder = undefined;
  for (i = 0; i < keys.size; i++) {
    if(level._exploder_ids[keys[i]] == exploder_id) {
      exploder = keys[i];
      break;
    }
  }
  if(!isdefined(exploder)) {
    return;
  }
  exploder::stop_exploder(exploder);
}

function codecallback_chargeshotweaponsoundnotify(localclientnum, weapon, chargeshotlevel) {
  if(isdefined(level.sndchargeshot_func)) {
    self[[level.sndchargeshot_func]](localclientnum, weapon, chargeshotlevel);
  }
}

function codecallback_hostmigration(localclientnum) {
  println("");
  if(isdefined(level.callbackhostmigration)) {
    [
      [level.callbackhostmigration]
    ](localclientnum);
  }
}

function codecallback_dogsoundnotify(client_num, entity, note) {
  if(isdefined(level.callbackdogsoundnotify)) {
    [
      [level.callbackdogsoundnotify]
    ](client_num, entity, note);
  }
}

function codecallback_playaifootstep(client_num, pos, surface, notetrack, bone) {
  [[level.callbackplayaifootstep]](client_num, pos, surface, notetrack, bone);
}

function codecallback_playlightloopexploder(exploderindex) {
  [[level.callbackplaylightloopexploder]](exploderindex);
}

function codecallback_stoplightloopexploder(exploderindex) {
  num = int(exploderindex);
  if(isdefined(level.createfxexploders[num])) {
    for (i = 0; i < level.createfxexploders[num].size; i++) {
      ent = level.createfxexploders[num][i];
      if(!isdefined(ent.looperfx)) {
        ent.looperfx = [];
      }
      for (clientnum = 0; clientnum < level.max_local_clients; clientnum++) {
        if(localclientactive(clientnum)) {
          if(isdefined(ent.looperfx[clientnum])) {
            for (looperfxcount = 0; looperfxcount < ent.looperfx[clientnum].size; looperfxcount++) {
              deletefx(clientnum, ent.looperfx[clientnum][looperfxcount]);
            }
          }
        }
        ent.looperfx[clientnum] = [];
      }
      ent.looperfx = [];
    }
  }
}

function codecallback_clientflag(localclientnum, flag, set) {
  if(isdefined(level.callbackclientflag)) {
    [
      [level.callbackclientflag]
    ](localclientnum, flag, set);
  }
}

function codecallback_clientflagasval(localclientnum, val) {
  if(isdefined(level._client_flagasval_callbacks) && isdefined(level._client_flagasval_callbacks[self.type])) {
    self thread[[level._client_flagasval_callbacks[self.type]]](localclientnum, val);
  }
}

function codecallback_extracamrenderhero(localclientnum, jobindex, extracamindex, sessionmode, characterindex) {
  if(isdefined(level.extra_cam_render_hero_func_callback)) {
    [
      [level.extra_cam_render_hero_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, characterindex);
  }
}

function codecallback_extracamrenderlobbyclienthero(localclientnum, jobindex, extracamindex, sessionmode) {
  if(isdefined(level.extra_cam_render_lobby_client_hero_func_callback)) {
    [
      [level.extra_cam_render_lobby_client_hero_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode);
  }
}

function codecallback_extracamrendercurrentheroheadshot(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero) {
  if(isdefined(level.extra_cam_render_current_hero_headshot_func_callback)) {
    [
      [level.extra_cam_render_current_hero_headshot_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero);
  }
}

function codecallback_extracamrendercharacterbodyitem(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender) {
  if(isdefined(level.extra_cam_render_character_body_item_func_callback)) {
    [
      [level.extra_cam_render_character_body_item_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender);
  }
}

function codecallback_extracamrendercharacterhelmetitem(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender) {
  if(isdefined(level.extra_cam_render_character_helmet_item_func_callback)) {
    [
      [level.extra_cam_render_character_helmet_item_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultitemrender);
  }
}

function codecallback_extracamrendercharacterheaditem(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultitemrender) {
  if(isdefined(level.extra_cam_render_character_head_item_func_callback)) {
    [
      [level.extra_cam_render_character_head_item_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultitemrender);
  }
}

function codecallback_extracamrenderoutfitpreview(localclientnum, jobindex, extracamindex, sessionmode, outfitindex) {
  if(isdefined(level.extra_cam_render_outfit_preview_func_callback)) {
    [
      [level.extra_cam_render_outfit_preview_func_callback]
    ](localclientnum, jobindex, extracamindex, sessionmode, outfitindex);
  }
}

function codecallback_extracamrenderwcpaintjobicon(localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
  if(isdefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
    [
      [level.extra_cam_render_wc_paintjobicon_func_callback]
    ](localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview);
  }
}

function codecallback_extracamrenderwcvarianticon(localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview) {
  if(isdefined(level.extra_cam_render_wc_varianticon_func_callback)) {
    [
      [level.extra_cam_render_wc_varianticon_func_callback]
    ](localclientnum, extracamindex, jobindex, attachmentvariantstring, weaponoptions, weaponplusattachments, loadoutslot, paintjobindex, paintjobslot, isfilesharepreview);
  }
}

function codecallback_collectibleschanged(changedclient, collectiblesarray, localclientnum) {
  if(isdefined(level.on_collectibles_change)) {
    [
      [level.on_collectibles_change]
    ](changedclient, collectiblesarray, localclientnum);
  }
}

function add_weapon_type(weapontype, callback) {
  if(!isdefined(level.weapon_type_callback_array)) {
    level.weapon_type_callback_array = [];
  }
  if(isstring(weapontype)) {
    weapontype = getweapon(weapontype);
  }
  level.weapon_type_callback_array[weapontype] = callback;
}

function spawned_weapon_type(localclientnum) {
  weapontype = self.weapon.rootweapon;
  if(isdefined(level.weapon_type_callback_array) && isdefined(level.weapon_type_callback_array[weapontype])) {
    self thread[[level.weapon_type_callback_array[weapontype]]](localclientnum);
  }
}

function codecallback_callclientscript(pself, label, param) {
  if(!isdefined(level._animnotifyfuncs)) {
    return;
  }
  if(isdefined(level._animnotifyfuncs[label])) {
    pself[[level._animnotifyfuncs[label]]](param);
  }
}

function codecallback_callclientscriptonlevel(label, param) {
  if(!isdefined(level._animnotifyfuncs)) {
    return;
  }
  if(isdefined(level._animnotifyfuncs[label])) {
    level[[level._animnotifyfuncs[label]]](param);
  }
}

function codecallback_serversceneinit(scene_name) {
  if(isdefined(level.server_scenes[scene_name])) {
    level thread scene::init(scene_name);
  }
}

function codecallback_serversceneplay(scene_name) {
  level thread scene_black_screen();
  if(isdefined(level.server_scenes[scene_name])) {
    level thread scene::play(scene_name);
  }
}

function codecallback_serverscenestop(scene_name) {
  level thread scene_black_screen();
  if(isdefined(level.server_scenes[scene_name])) {
    level thread scene::stop(scene_name, undefined, undefined, undefined, 1);
  }
}

function scene_black_screen() {
  foreach(i, player in level.localplayers) {
    if(!isdefined(player.lui_black)) {
      player.lui_black = createluimenu(i, "FullScreenBlack");
      openluimenu(i, player.lui_black);
    }
  }
  wait(0.016);
  foreach(i, player in level.localplayers) {
    if(isdefined(player.lui_black)) {
      closeluimenu(i, player.lui_black);
      player.lui_black = undefined;
    }
  }
}

function codecallback_gadgetvisionpulse_reveal(local_client_num, entity, breveal) {
  if(isdefined(level.gadgetvisionpulse_reveal_func)) {
    entity[[level.gadgetvisionpulse_reveal_func]](local_client_num, breveal);
  }
}