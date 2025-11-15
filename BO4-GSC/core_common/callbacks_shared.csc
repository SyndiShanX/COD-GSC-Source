/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\callbacks_shared.csc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace callback;

callback(event, localclientnum, params) {
  if(isDefined(level._callbacks) && isDefined(level._callbacks[event])) {
    for(i = 0; i < level._callbacks[event].size; i++) {
      callback = level._callbacks[event][i][0];
      obj = level._callbacks[event][i][1];

      if(!isDefined(callback)) {
        continue;
      }

      if(isDefined(obj)) {
        if(isDefined(params)) {
          obj thread[[callback]](localclientnum, self, params);
        } else {
          obj thread[[callback]](localclientnum, self);
        }

        continue;
      }

      if(isDefined(params)) {
        self thread[[callback]](localclientnum, params);
        continue;
      }

      self thread[[callback]](localclientnum);
    }
  }
}

entity_callback(event, localclientnum, params) {
  if(isDefined(self._callbacks) && isDefined(self._callbacks[event])) {
    for(i = 0; i < self._callbacks[event].size; i++) {
      callback = self._callbacks[event][i][0];
      obj = self._callbacks[event][i][1];

      if(!isDefined(callback)) {
        continue;
      }

      if(isDefined(obj)) {
        if(isDefined(params)) {
          obj thread[[callback]](localclientnum, self, params);
        } else {
          obj thread[[callback]](localclientnum, self);
        }

        continue;
      }

      if(isDefined(params)) {
        self thread[[callback]](localclientnum, params);
        continue;
      }

      self thread[[callback]](localclientnum);
    }
  }
}

add_callback(event, func, obj) {
  assert(isDefined(event), "<dev string:x38>");

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

add_entity_callback(event, func, obj) {
  assert(isDefined(event), "<dev string:x38>");

  if(!isDefined(self._callbacks) || !isDefined(self._callbacks[event])) {
    self._callbacks[event] = [];
  }

  foreach(callback in self._callbacks[event]) {
    if(callback[0] == func) {
      if(!isDefined(obj) || callback[1] == obj) {
        return;
      }
    }
  }

  array::add(self._callbacks[event], array(func, obj), 0);
}

remove_callback_on_death(event, func) {
  self waittill(#"death");
  remove_callback(event, func, self);
}

function_52ac9652(event, func, obj) {
  assert(isDefined(event), "<dev string:x6a>");

  if(!isDefined(self._callbacks) || !isDefined(self._callbacks[event])) {
    return;
  }

  foreach(index, func_group in self._callbacks[event]) {
    if(func_group[0] == func) {
      if(func_group[1] === obj) {
        arrayremoveindex(self._callbacks[event], index, 0);
        break;
      }
    }
  }
}

remove_callback(event, func, obj) {
  assert(isDefined(event), "<dev string:x6a>");
  assert(isDefined(level._callbacks[event]), "<dev string:x9f>");

  foreach(index, func_group in level._callbacks[event]) {
    if(func_group[0] == func) {
      if(func_group[1] === obj) {
        arrayremoveindex(level._callbacks[event], index, 0);
        break;
      }
    }
  }
}

on_localclient_connect(func, obj) {
  add_callback(#"on_localclient_connect", func, obj);
}

on_localclient_shutdown(func, obj) {
  add_callback(#"on_localclient_shutdown", func, obj);
}

on_finalize_initialization(func, obj) {
  add_callback(#"on_finalize_initialization", func, obj);
}

on_gameplay_started(func, obj) {
  add_callback(#"on_gameplay_started", func, obj);
}

on_localplayer_spawned(func, obj) {
  add_callback(#"on_localplayer_spawned", func, obj);
}

remove_on_localplayer_spawned(func, obj) {
  remove_callback(#"on_localplayer_spawned", func, obj);
}

on_spawned(func, obj) {
  add_callback(#"on_player_spawned", func, obj);
}

remove_on_spawned(func, obj) {
  remove_callback(#"on_player_spawned", func, obj);
}

on_laststand(func, obj) {
  add_callback(#"on_player_laststand", func, obj);
}

remove_on_laststand(func, obj) {
  remove_callback(#"on_player_laststand", func, obj);
}

on_player_corpse(func, obj) {
  add_callback(#"on_player_corpse", func, obj);
}

function_930e5d42(func, obj) {
  add_callback(#"hash_781399e15b138a4e", func, obj);
}

on_weapon_change(func, obj) {
  self add_entity_callback(#"weapon_change", func, obj);
}

function_6231c19(func, obj) {
  add_callback(#"weapon_change", func, obj);
}

function_17381fe(func, obj) {
  self add_entity_callback(#"hash_12ca6e8bf50f11f5", func, obj);
}

on_deleted(func, obj) {
  add_callback(#"on_entity_deleted", func, obj);
}

remove_on_deleted(func, obj) {
  remove_callback(#"on_entity_deleted", func, obj);
}

on_shutdown(func, obj) {
  add_entity_callback(#"on_entity_shutdown", func, obj);
}

on_start_gametype(func, obj) {
  add_callback(#"on_start_gametype", func, obj);
}

on_end_game(func, obj) {
  add_callback(#"on_end_game", func, obj);
}

remove_on_end_game(func, obj) {
  remove_callback(#"on_end_game", func, obj);
}

on_killcam_begin(func, obj) {
  add_callback(#"killcam_begin", func, obj);
}

on_killcam_end(func, obj) {
  add_callback(#"killcam_end", func, obj);
}

on_melee(func, obj) {
  add_callback(#"melee", func, obj);
}

on_trigger(func, obj) {
  add_entity_callback(#"on_trigger", func, obj);
}

remove_on_trigger(func, obj) {
  function_52ac9652(#"on_trigger", func, obj);
}

on_trigger_once(func, obj) {
  add_entity_callback(#"on_trigger_once", func, obj);
}

remove_on_trigger_once(func, obj) {
  function_52ac9652(#"on_trigger_once", func, obj);
}

on_death(func, obj) {
  add_callback(#"death", func, obj);
}

remove_on_death(func, obj) {
  remove_callback(#"death", func, obj);
}

event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
  callback(#"on_pre_initialization");
  system::run_pre_systems();
}

event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
  system::run_post_systems();
  callback(#"on_finalize_initialization");
}

event_handler[systemstatechange] codecallback_statechange(eventstruct) {
  if(!isDefined(level._systemstates)) {
    level._systemstates = [];
  }

  if(!isDefined(level._systemstates[eventstruct.system])) {
    level._systemstates[eventstruct.system] = spawnStruct();
  }

  level._systemstates[eventstruct.system].state = eventstruct.state;

  if(isDefined(level._systemstates[eventstruct.system].callback)) {
    [[level._systemstates[eventstruct.system].callback]](eventstruct.localclientnum, eventstruct.state);
    return;
  }

  println("<dev string:xce>" + eventstruct.system + "<dev string:xfc>");
}

event_handler[maprestart] codecallback_maprestart(eventstruct) {
  println("<dev string:x126>");
  util::waitforclient(0);
  level thread util::init_utility();
}

event_handler[localclient_connect] codecallback_localclientconnect(eventstruct) {
  println("<dev string:x14a>" + eventstruct.localclientnum);
  [[level.callbacklocalclientconnect]](eventstruct.localclientnum);
}

event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
  println("<dev string:x179>");
}

event_handler[sound_setambientstate] codecallback_soundsetambientstate(eventstruct) {
  audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

event_handler[sound_setaiambientstate] codecallback_soundsetaiambientstate(eventstruct) {}

event_handler[event_10eed35b] function_d3771684(eventstruct) {
  if(!isDefined(level.var_44e74ef4)) {
    return;
  }

  println("<dev string:x1c3>");
  thread[[level.var_44e74ef4]](eventstruct);
}

event_handler[sound_playuidecodeloop] codecallback_soundplayuidecodeloop(eventstruct) {
  self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

event_handler[player_spawned] codecallback_playerspawned(eventstruct) {
  [[level.callbackplayerspawned]](eventstruct.localclientnum);
}

event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
  [[level.callbackplayerlaststand]](eventstruct.localclientnum);
}

event_handler[event_d6f9e6ad] function_c1d1f779(eventstruct) {
  if(!isDefined(level.var_c3e66138)) {
    return;
  }

  println("<dev string:x1f2>");
  thread[[level.var_c3e66138]](eventstruct.var_428d0be2);
}

event_handler[event_e469e10d] function_cfcbacb1(eventstruct) {
  if(isDefined(level.var_beec2b1)) {
    [[level.var_beec2b1]](eventstruct.localclientnum);
  }
}

event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
  if(isDefined(level.var_c442de72)) {
    [[level.var_c442de72]](self, eventstruct.localclientnum, eventstruct.weapon);
  }
}

event_handler[entity_gibevent] codecallback_gibevent(eventstruct) {
  if(isDefined(level._gibeventcbfunc)) {
    self thread[[level._gibeventcbfunc]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
  }
}

event_handler[gametype_precache] codecallback_precachegametype(eventstruct) {
  if(isDefined(level.callbackprecachegametype)) {
    [[level.callbackprecachegametype]]();
  }
}

event_handler[gametype_start] codecallback_startgametype(eventstruct) {
  if(isDefined(level.callbackstartgametype) && (!isDefined(level.gametypestarted) || !level.gametypestarted)) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

event_handler[entity_spawned] codecallback_entityspawned(eventstruct) {
  [[level.callbackentityspawned]](eventstruct.localclientnum);
}

event_handler[enter_vehicle] codecallback_entervehicle(eventstruct) {
  if(isplayer(self)) {
    if(isDefined(level.var_69b47c50)) {
      self[[level.var_69b47c50]](eventstruct.localclientnum, eventstruct.vehicle);
    }

    return;
  }

  if(self isvehicle()) {
    if(isDefined(level.var_93b40f07)) {
      self[[level.var_93b40f07]](eventstruct.localclientnum, eventstruct.player);
    }
  }
}

event_handler[exit_vehicle] codecallback_exitvehicle(eventstruct) {
  if(isplayer(self)) {
    if(isDefined(level.var_db2ec524)) {
      self[[level.var_db2ec524]](eventstruct.localclientnum, eventstruct.vehicle);
    }

    return;
  }

  if(self isvehicle()) {
    if(isDefined(level.var_d4d60480)) {
      self[[level.var_d4d60480]](eventstruct.localclientnum, eventstruct.player);
    }
  }
}

event_handler[sound_notify] codecallback_soundnotify(eventstruct) {
  switch (eventstruct.notetrack) {
    case #"scr_bomb_beep":
      if(getgametypesetting(#"silentplant") == 0) {
        self playSound(eventstruct.localclientnum, #"fly_bomb_buttons_npc");
      }

      break;
  }
}

event_handler[entity_shutdown] codecallback_entityshutdown(eventstruct) {
  if(isDefined(level.callbackentityshutdown)) {
    [[level.callbackentityshutdown]](eventstruct.localclientnum, eventstruct.entity);
  }

  eventstruct.entity entity_callback(#"on_entity_shutdown", eventstruct.localclientnum);
}

event_handler[localclient_shutdown] codecallback_localclientshutdown(eventstruct) {
  level.localplayers = getlocalplayers();
  eventstruct.entity callback(#"on_localclient_shutdown", eventstruct.localclientnum);
}

event_handler[localclient_changed] codecallback_localclientchanged(eventstruct) {
  level.localplayers = getlocalplayers();
}

event_handler[player_airsupport] codecallback_airsupport(eventstruct) {
  if(isDefined(level.callbackairsupport)) {
    [[level.callbackairsupport]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
  }
}

event_handler[demosystem_jump] codecallback_demojump(eventstruct) {
  level notify(#"demo_jump", {
    #time: eventstruct.time
  });
  level notify("demo_jump" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
}

codecallback_demoplayerswitch(localclientnum) {
  level notify(#"demo_player_switch");
  level notify("demo_player_switch" + localclientnum);
}

event_handler[player_switch] codecallback_playerswitch(eventstruct) {
  level notify(#"player_switch");
  level notify("player_switch" + eventstruct.localclientnum);
}

event_handler[killcam_begin] codecallback_killcambegin(eventstruct) {
  level notify(#"killcam_begin", {
    #time: eventstruct.time
  });
  level notify("killcam_begin" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
  level callback(#"killcam_begin", eventstruct);
}

event_handler[killcam_end] codecallback_killcamend(eventstruct) {
  level notify(#"killcam_end", {
    #time: eventstruct.time
  });
  level notify("killcam_end" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
  level callback(#"killcam_end", eventstruct);
}

event_handler[player_corpse] codecallback_creatingcorpse(eventstruct) {
  if(isDefined(level.callbackcreatingcorpse)) {
    [[level.callbackcreatingcorpse]](eventstruct.localclientnum, eventstruct.player);
  }
}

event_handler[exploder_activate] codecallback_activateexploder(eventstruct) {
  if(!isDefined(level._exploder_ids)) {
    return;
  }

  exploder = undefined;

  foreach(k, v in level._exploder_ids) {
    if(v == eventstruct.exploder_id) {
      exploder = k;
      break;
    }
  }

  if(!isDefined(exploder)) {
    return;
  }

  exploder::activate_exploder(exploder);
}

event_handler[exploder_deactivate] codecallback_deactivateexploder(eventstruct) {
  if(!isDefined(level._exploder_ids)) {
    return;
  }

  exploder = undefined;

  foreach(k, v in level._exploder_ids) {
    if(v == eventstruct.exploder_id) {
      exploder = k;
      break;
    }
  }

  if(!isDefined(exploder)) {
    return;
  }

  exploder::stop_exploder(exploder);
}

event_handler[sound_chargeshotweaponnotify] codecallback_chargeshotweaponsoundnotify(eventstruct) {
  if(isDefined(level.sndchargeshot_func)) {
    self[[level.sndchargeshot_func]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
  }
}

event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
  println("<dev string:x21b>");

  if(isDefined(level.callbackhostmigration)) {
    [[level.callbackhostmigration]](eventstruct.localclientnum);
  }
}

event_handler[entity_footstep] codecallback_playaifootstep(eventstruct) {
  [[level.callbackplayaifootstep]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

codecallback_clientflag(localclientnum, flag, set) {
  if(isDefined(level.callbackclientflag)) {
    [[level.callbackclientflag]](localclientnum, flag, set);
  }
}

codecallback_clientflagasval(localclientnum, val) {
  if(isDefined(level._client_flagasval_callbacks) && isDefined(level._client_flagasval_callbacks[self.type])) {
    self thread[[level._client_flagasval_callbacks[self.type]]](localclientnum, val);
  }
}

event_handler[extracam_currentheroheadshot] codecallback_extracamrendercurrentheroheadshot(eventstruct) {
  if(isDefined(level.extra_cam_render_current_hero_headshot_func_callback)) {
    [[level.extra_cam_render_current_hero_headshot_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.is_defaulthero);
  }
}

event_handler[event_3cbeb] function_327732bf(eventstruct) {
  if(isDefined(level.var_dda8e1d8)) {
    [[level.var_dda8e1d8]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.outfit_index, eventstruct.item_type, eventstruct.item_index, eventstruct.is_defaultrender);
  }
}

event_handler[extracam_characterheaditem] codecallback_extracamrendercharacterheaditem(eventstruct) {
  if(isDefined(level.extra_cam_render_character_head_item_func_callback)) {
    [[level.extra_cam_render_character_head_item_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.head_index, eventstruct.is_default_render);
  }
}

event_handler[extracam_genderrender] codecallback_extracamrendergender(eventstruct) {
  if(isDefined(level.extra_cam_render_gender_func_callback)) {
    [[level.extra_cam_render_gender_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.gender);
  }
}

event_handler[extracam_wcpaintjobicon] codecallback_extracamrenderwcpaintjobicon(eventstruct) {
  if(isDefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
    [[level.extra_cam_render_wc_paintjobicon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
  }
}

event_handler[extracam_wcvarianticon] codecallback_extracamrenderwcvarianticon(eventstruct) {
  if(isDefined(level.extra_cam_render_wc_varianticon_func_callback)) {
    [[level.extra_cam_render_wc_varianticon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
  }
}

event_handler[collectibles_changed] codecallback_collectibleschanged(eventstruct) {
  if(isDefined(level.on_collectibles_change)) {
    [[level.on_collectibles_change]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
  }
}

add_weapon_type(weapontype, callback) {
  if(!isDefined(level.weapon_type_callback_array)) {
    level.weapon_type_callback_array = [];
  }

  weapontype = getweapon(weapontype);
  level.weapon_type_callback_array[weapontype] = callback;
}

spawned_weapon_type(localclientnum) {
  weapontype = self.weapon.rootweapon;

  if(isDefined(level.weapon_type_callback_array) && isDefined(level.weapon_type_callback_array[weapontype])) {
    self thread[[level.weapon_type_callback_array[weapontype]]](localclientnum);
  }
}

function_cbfd8fd6(localclientnum) {
  activecamo::function_cbfd8fd6(localclientnum);
}

event_handler[notetrack_callclientscript] codecallback_callclientscript(eventstruct) {
  if(!isDefined(level._animnotifyfuncs)) {
    return;
  }

  if(isDefined(level._animnotifyfuncs[eventstruct.label])) {
    if(isDefined(eventstruct.param3) && eventstruct.param3 != "") {
      self[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
      return;
    }

    self[[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
  }
}

event_handler[notetrack_callclientscriptonlevel] codecallback_callclientscriptonlevel(eventstruct) {
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
  outerradius = float(eventstruct.outerradius);
  innerdamage = isDefined(self.var_f501d778) ? self.var_f501d778 : 50;
  outerdamage = isDefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
  var_a62fd3ab = isDefined(self.var_abe3f153) ? self.var_abe3f153 : 1;
  var_c1cde02b = isDefined(self.var_bd0f9401) ? self.var_bd0f9401 : 1;
  physicsexplosionsphere(eventstruct.localclientnum, origin, outerradius, innerradius, magnitude, innerdamage, outerdamage, var_a62fd3ab, var_c1cde02b);
}

event_handler[scene_init] codecallback_serversceneinit(eventstruct) {
  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::init(eventstruct.scene_name);
  }
}

event_handler[scene_play] codecallback_serversceneplay(eventstruct) {
  level thread scene_black_screen();

  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::play(eventstruct.scene_name);
  }
}

event_handler[scene_stop] codecallback_serverscenestop(eventstruct) {
  level thread scene_black_screen();

  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
  }
}

scene_black_screen() {
  foreach(i, player in level.localplayers) {
    if(!isDefined(player.lui_black)) {
      player.lui_black = createluimenu(i, "FullScreenBlack");
      openluimenu(i, player.lui_black);
    }
  }

  waitframe(1);

  foreach(i, player in level.localplayers) {
    if(isDefined(player.lui_black)) {
      closeluimenu(i, player.lui_black);
      player.lui_black = undefined;
    }
  }
}

event_handler[gadget_visionpulsereveal] codecallback_gadgetvisionpulse_reveal(eventstruct) {
  if(isDefined(level.gadgetvisionpulse_reveal_func)) {
    eventstruct.entity[[level.gadgetvisionpulse_reveal_func]](eventstruct.localclientnum, eventstruct.enable);
  }
}

private fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername) {
  self endon(#"disconnect");
  wait startwait;
  self lui::screen_fade_out(fadeintime, shadername);
  wait blackscreenwait;

  if(isDefined(self)) {
    self lui::screen_fade_in(fadeouttime, shadername);
  }
}

event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
  if(isDefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55()) {
    self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
  }
}

event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
  if(isDefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55()) {
    self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
  }
}

event_handler[event_1f757215] function_5067ee2f(eventstruct) {
  self animation::play_siege(eventstruct.anim_name, eventstruct.shot_name, eventstruct.rate, eventstruct.loop);
}

event_handler[forcestreambundle] codecallback_forcestreambundle(eventstruct) {
  forcestreambundle(eventstruct.name, eventstruct.var_3c542760, eventstruct.var_a0e51075);
}

event_handler[event_bfc28859] function_582e112f(eventstruct) {
  if(isDefined(level.var_45ca79e5)) {
    [[level.var_45ca79e5]](eventstruct.localclientnum, eventstruct.eventtype, eventstruct.itemid, eventstruct.value, eventstruct.value2);
  }
}

event_handler[event_a5e70678] function_11988454(eventstruct) {
  if(isDefined(level.var_a6c75fcb)) {
    [[level.var_a6c75fcb]](eventstruct.var_85604f16);
  }
}

event_handler[trigger] codecallback_trigger(eventstruct) {
  if(isDefined(level.var_a6c75fcb)) {
    self callback(#"on_trigger", eventstruct);
    self callback(#"on_trigger_once", eventstruct);
    self remove_on_trigger_once("all");
  }
}

event_handler[freefall] function_5019e563(eventstruct) {
  self callback(#"freefall", eventstruct);
  self entity_callback(#"freefall", eventstruct.localclientnum, eventstruct);
}

event_handler[parachute] function_87b05fa3(eventstruct) {
  self callback(#"parachute", eventstruct);
  self entity_callback(#"parachute", eventstruct.localclientnum, eventstruct);
}

event_handler[death] codecallback_death(eventstruct) {
  self callback(#"death", eventstruct);
  self entity_callback(#"death", eventstruct);
}

event_handler[melee] codecallback_melee(eventstruct) {
  self callback(#"melee", eventstruct);
}

event_handler[culled] function_667f84de(eventstruct) {
  self entity_callback(#"culled", eventstruct);
}

event_handler[weapon_change] function_6846a2b7(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"weapon_change", eventstruct);
  }

  self callback(#"weapon_change", eventstruct);
}

event_handler[event_41480c76] function_c33f3471(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"hash_4152cf6a61494581", eventstruct);
  }

  self callback(#"hash_4152cf6a61494581", eventstruct);
}

event_handler[event_6e84b1b1] function_ff9acfac(eventstruct) {
  level callback(#"hash_2fc4cfecaed47583", eventstruct);
}

event_handler[event_eae361ae] function_a1ad9b51(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"hash_12ca6e8bf50f11f5", eventstruct.localclientnum);
  }

  self callback(#"hash_12ca6e8bf50f11f5", eventstruct.localclientnum);
}

event_handler[updateactivecamo] codecallback_updateactivecamo(eventstruct) {
  self callback(#"updateactivecamo", eventstruct.localclientnum, eventstruct);
}

event_handler[event_ab7a7fd3] function_bc70e1e4(eventstruct) {
  self callback(#"hash_6900f4ea0ff32c3e", eventstruct);
}