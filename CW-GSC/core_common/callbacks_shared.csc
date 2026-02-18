/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\callbacks_shared.csc
***********************************************/

#using scripts\core_common\activecamo_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace callback;

function callback(event, localclientnum, params) {
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

function entity_callback(event, localclientnum, params) {
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

function add_callback(event, func, obj) {
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

function add_entity_callback(event, func, obj) {
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

function remove_callback_on_death(event, func) {
  self waittill(#"death");
  remove_callback(event, func, self);
}

function function_52ac9652(event, func, obj) {
  assert(isDefined(event), "<dev string:x6b>");

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

function remove_callback(event, func, obj) {
  assert(isDefined(event), "<dev string:x6b>");
  assert(isDefined(level._callbacks[event]), "<dev string:xa1>");

  foreach(index, func_group in level._callbacks[event]) {
    if(func_group[0] == func) {
      if(func_group[1] === obj) {
        arrayremoveindex(level._callbacks[event], index, 0);
        break;
      }
    }
  }
}

function on_localclient_connect(func, obj) {
  add_callback(#"on_localclient_connect", func, obj);
}

function on_localclient_shutdown(func, obj) {
  add_callback(#"on_localclient_shutdown", func, obj);
}

function on_finalize_initialization(func, obj) {
  add_callback(#"on_finalize_initialization", func, obj);
}

function on_gameplay_started(func, obj) {
  add_callback(#"on_gameplay_started", func, obj);
}

function on_localplayer_spawned(func, obj) {
  add_callback(#"on_localplayer_spawned", func, obj);
}

function remove_on_localplayer_spawned(func, obj) {
  remove_callback(#"on_localplayer_spawned", func, obj);
}

function on_spawned(func, obj) {
  add_callback(#"on_player_spawned", func, obj);
}

function remove_on_spawned(func, obj) {
  remove_callback(#"on_player_spawned", func, obj);
}

function function_675f0963(func, obj) {
  add_callback(#"hash_1fc6e31d0d02aa3", func, obj);
}

function function_ce9bb4ec(func, obj) {
  remove_callback(#"hash_1fc6e31d0d02aa3", func, obj);
}

function on_vehicle_spawned(func, obj) {
  add_callback(#"on_vehicle_spawned", func, obj);
}

function remove_on_vehicle_spawned(func, obj) {
  remove_callback(#"on_vehicle_spawned", func, obj);
}

function on_laststand(func, obj) {
  add_callback(#"on_player_laststand", func, obj);
}

function remove_on_laststand(func, obj) {
  remove_callback(#"on_player_laststand", func, obj);
}

function on_player_corpse(func, obj) {
  add_callback(#"on_player_corpse", func, obj);
}

function function_930e5d42(func, obj) {
  add_callback(#"hash_781399e15b138a4e", func, obj);
}

function on_weapon_change(func, obj) {
  self add_entity_callback(#"weapon_change", func, obj);
}

function on_ping(func, obj) {
  self add_entity_callback(#"on_ping", func, obj);
}

function function_78827e7f(func, obj) {
  self add_entity_callback(#"hash_5768f5220f99ebd1", func, obj);
}

function function_6231c19(func, obj) {
  add_callback(#"weapon_change", func, obj);
}

function function_a880899e(func, obj) {
  self add_entity_callback(#"hash_42d524149523a1eb", func, obj);
}

function function_23694c6c(func, obj) {
  self add_entity_callback(#"hash_56b841ac8d1dac0b", func, obj);
}

function function_4531552d(func, obj) {
  self add_entity_callback(#"hash_28ae86e34f270362", func, obj);
}

function function_74f5faf8(func, obj) {
  self add_entity_callback(#"hash_eb85a61dd6639ae", func, obj);
}

function on_deleted(func, obj) {
  add_callback(#"on_entity_deleted", func, obj);
}

function remove_on_deleted(func, obj) {
  remove_callback(#"on_entity_deleted", func, obj);
}

function on_shutdown(func, obj) {
  add_entity_callback(#"on_entity_shutdown", func, obj);
}

function on_start_gametype(func, obj) {
  add_callback(#"on_start_gametype", func, obj);
}

function on_end_game(func, obj) {
  add_callback(#"on_end_game", func, obj);
}

function remove_on_end_game(func, obj) {
  remove_callback(#"on_end_game", func, obj);
}

function on_killcam_begin(func, obj) {
  add_callback(#"killcam_begin", func, obj);
}

function on_killcam_end(func, obj) {
  add_callback(#"killcam_end", func, obj);
}

function function_9fcd5f60(func, obj) {
  add_callback(#"hash_7a8be4f48b2d1cf6", func, obj);
}

function on_team_change(func, obj) {
  add_callback(#"on_team_change", func, obj);
}

function on_melee(func, obj) {
  add_callback(#"melee", func, obj);
}

function on_trigger(func, obj) {
  add_entity_callback(#"on_trigger", func, obj);
}

function remove_on_trigger(func, obj) {
  function_52ac9652(#"on_trigger", func, obj);
}

function on_trigger_once(func, obj) {
  add_entity_callback(#"on_trigger_once", func, obj);
}

function remove_on_trigger_once(func, obj) {
  function_52ac9652(#"on_trigger_once", func, obj);
}

function function_2870abef(func, obj) {
  add_callback(#"mantle_low", func, obj);
}

function function_b27200db(func, obj) {
  add_callback(#"mantle_high", func, obj);
}

function function_56df655f(func, obj) {
  add_callback(#"demo_jump", func, obj);
}

function function_f8062bf(func, obj) {
  add_callback(#"demo_player_switch", func, obj);
}

function function_ed112c52(func, obj) {
  add_callback(#"player_switch", func, obj);
}

function event_handler[level_preinit] codecallback_preinitialization(eventstruct) {
  system::run_pre_systems();
}

function event_handler[event_cc819519] function_12c01a61(eventstruct) {
  system::run_post_systems();
}

function event_handler[level_finalizeinit] codecallback_finalizeinitialization(eventstruct) {
  system::function_b1553822();
  callback(#"on_finalize_initialization");
}

function event_handler[systemstatechange] codecallback_statechange(eventstruct) {
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

  println("<dev string:xd1>" + eventstruct.system + "<dev string:x100>");
}

function event_handler[event_6ba27c50] function_d736b8a9(eventstruct) {
  println("<dev string:x12b>");

  if(isDefined(level.var_4564d138)) {
    level thread[[level.var_4564d138]]();
  }
}

function event_handler[maprestart] codecallback_maprestart(eventstruct) {
  println("<dev string:x14e>");

  if(isDefined(level.var_6bd86801)) {
    level thread[[level.var_6bd86801]]();
  }

  level thread util::init_utility();
}

function event_handler[event_daf3d2ef] function_3036fadc(eventstruct) {
  println("<dev string:x12b>");

  if(isDefined(level.var_bad05810)) {
    level thread[[level.var_bad05810]]();
  }
}

function event_handler[localclient_connect] codecallback_localclientconnect(eventstruct) {
  if(!isDefined(level.callbacklocalclientconnect)) {
    waitframe(1);
  }

  println("<dev string:x173>" + eventstruct.localclientnum);
  [[level.callbacklocalclientconnect]](eventstruct.localclientnum);
}

function event_handler[glass_smash] codecallback_glasssmash(eventstruct) {
  println("<dev string:x1a3>");
}

function event_handler[sound_setambientstate] codecallback_soundsetambientstate(eventstruct) {
  audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

function event_handler[sound_setaiambientstate] codecallback_soundsetaiambientstate(eventstruct) {}

function event_handler[event_10eed35b] function_d3771684(eventstruct) {
  if(!isDefined(level.var_44e74ef4)) {
    return;
  }

  println("<dev string:x1ee>");
  thread[[level.var_44e74ef4]](eventstruct);
}

function event_handler[sound_playuidecodeloop] codecallback_soundplayuidecodeloop(eventstruct) {
  self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

function event_handler[player_spawned] codecallback_playerspawned(eventstruct) {
  while(!isDefined(level.callbackplayerspawned)) {
    waitframe(1);
  }

  [[level.callbackplayerspawned]](eventstruct.localclientnum);
}

function event_handler[player_laststand] codecallback_playerlaststand(eventstruct) {
  [[level.callbackplayerlaststand]](eventstruct.localclientnum);
}

function event_handler[event_d6f9e6ad] function_c1d1f779(eventstruct) {
  if(!isDefined(level.var_c3e66138)) {
    return;
  }

  println("<dev string:x21e>");
  thread[[level.var_c3e66138]](eventstruct.var_428d0be2);
}

function event_handler[event_e469e10d] function_cfcbacb1(eventstruct) {
  if(isDefined(level.var_beec2b1)) {
    [[level.var_beec2b1]](eventstruct.localclientnum);
  }
}

function event_handler[event_dd67c1a8] function_46c0443b(eventstruct) {
  if(isDefined(level.var_c442de72)) {
    [[level.var_c442de72]](self, eventstruct.localclientnum, eventstruct.weapon);
  }
}

function event_handler[entity_gibevent] codecallback_gibevent(eventstruct) {
  if(isDefined(level._gibeventcbfunc)) {
    self thread[[level._gibeventcbfunc]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
  }
}

function event_handler[gametype_precache] codecallback_precachegametype(eventstruct) {
  if(isDefined(level.callbackprecachegametype)) {
    [[level.callbackprecachegametype]]();
  }
}

function event_handler[gametype_start] codecallback_startgametype(eventstruct) {
  if(isDefined(level.callbackstartgametype) && (!isDefined(level.gametypestarted) || !level.gametypestarted)) {
    [[level.callbackstartgametype]]();
    level.gametypestarted = 1;
  }
}

function event_handler[entity_spawned] codecallback_entityspawned(eventstruct) {
  if(!isDefined(level.callbackentityspawned)) {
    waitframe(1);
  }

  [[level.callbackentityspawned]](eventstruct.localclientnum);
}

function event_handler[enter_vehicle] codecallback_entervehicle(eventstruct) {
  if(isPlayer(self)) {
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

function event_handler[exit_vehicle] codecallback_exitvehicle(eventstruct) {
  if(isPlayer(self)) {
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

function event_handler[sound_notify] codecallback_soundnotify(eventstruct) {
  switch (eventstruct.notetrack) {
    case # "scr_bomb_beep":
      if(getgametypesetting(#"silentplant") == 0) {
        self playSound(eventstruct.localclientnum, #"");
      }

      break;
  }
}

function event_handler[entity_shutdown] codecallback_entityshutdown(eventstruct) {
  if(isDefined(level.callbackentityshutdown)) {
    [[level.callbackentityshutdown]](eventstruct.localclientnum, eventstruct.entity);
  }

  eventstruct.entity entity_callback(#"on_entity_shutdown", eventstruct.localclientnum);
}

function event_handler[localclient_shutdown] codecallback_localclientshutdown(eventstruct) {
  level.localplayers = getlocalplayers();
  eventstruct.entity callback(#"on_localclient_shutdown", eventstruct.localclientnum);
}

function event_handler[localclient_changed] codecallback_localclientchanged(eventstruct) {
  level.localplayers = getlocalplayers();
}

function event_handler[player_airsupport] codecallback_airsupport(eventstruct) {
  if(isDefined(level.callbackairsupport)) {
    [[level.callbackairsupport]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
  }
}

function event_handler[demosystem_jump] codecallback_demojump(eventstruct) {
  level notify(#"demo_jump", {
    #time: eventstruct.time
  });
  level notify("demo_jump" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
  level callback(#"demo_jump", eventstruct);
}

function codecallback_demoplayerswitch(localclientnum) {
  level notify(#"demo_player_switch");
  level notify("demo_player_switch" + localclientnum);
  level callback(#"demo_player_switch");
}

function event_handler[player_switch] codecallback_playerswitch(eventstruct) {
  level notify(#"player_switch");
  level notify("player_switch" + eventstruct.localclientnum);
  level callback(#"player_switch", eventstruct);
}

function event_handler[killcam_begin] codecallback_killcambegin(eventstruct) {
  level notify(#"killcam_begin", {
    #time: eventstruct.time
  });
  level notify("killcam_begin" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
  level callback(#"killcam_begin", eventstruct);
}

function event_handler[killcam_end] codecallback_killcamend(eventstruct) {
  level notify(#"killcam_end", {
    #time: eventstruct.time
  });
  level notify("killcam_end" + eventstruct.localclientnum, {
    #time: eventstruct.time
  });
  level callback(#"killcam_end", eventstruct);
}

function event_handler[event_b1c5e32] function_d6a509f1(eventstruct) {
  level callback(#"hash_7a8be4f48b2d1cf6", eventstruct);
}

function event_handler[player_corpse] codecallback_creatingcorpse(eventstruct) {
  if(isDefined(level.callbackcreatingcorpse)) {
    [[level.callbackcreatingcorpse]](eventstruct.localclientnum, eventstruct.player);
  }
}

function event_handler[exploder_activate] codecallback_activateexploder(eventstruct) {
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

function event_handler[exploder_deactivate] codecallback_deactivateexploder(eventstruct) {
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

function event_handler[sound_chargeshotweaponnotify] codecallback_chargeshotweaponsoundnotify(eventstruct) {
  if(isDefined(level.sndchargeshot_func)) {
    self[[level.sndchargeshot_func]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
  }
}

function event_handler[hostmigration] codecallback_hostmigration(eventstruct) {
  println("<dev string:x248>");

  if(isDefined(level.callbackhostmigration)) {
    [[level.callbackhostmigration]](eventstruct.localclientnum);
  }
}

function event_handler[entity_footstep] codecallback_playaifootstep(eventstruct) {
  [[level.callbackplayaifootstep]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

function codecallback_clientflag(localclientnum, flag, set) {
  if(isDefined(level.callbackclientflag)) {
    [[level.callbackclientflag]](localclientnum, flag, set);
  }
}

function codecallback_clientflagasval(localclientnum, val) {
  if(isDefined(level._client_flagasval_callbacks) && isDefined(level._client_flagasval_callbacks[self.type])) {
    self thread[[level._client_flagasval_callbacks[self.type]]](localclientnum, val);
  }
}

function event_handler[event_3cbeb] function_327732bf(eventstruct) {
  if(isDefined(level.var_dda8e1d8)) {
    [[level.var_dda8e1d8]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.outfit_index, eventstruct.item_type, eventstruct.item_index, eventstruct.is_defaultrender);
  }
}

function event_handler[extracam_wcpaintjobicon] codecallback_extracamrenderwcpaintjobicon(eventstruct) {
  if(isDefined(level.extra_cam_render_wc_paintjobicon_func_callback)) {
    [[level.extra_cam_render_wc_paintjobicon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
  }
}

function event_handler[extracam_wcvarianticon] codecallback_extracamrenderwcvarianticon(eventstruct) {
  if(isDefined(level.extra_cam_render_wc_varianticon_func_callback)) {
    [[level.extra_cam_render_wc_varianticon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
  }
}

function event_handler[collectibles_changed] codecallback_collectibleschanged(eventstruct) {
  if(isDefined(level.on_collectibles_change)) {
    [[level.on_collectibles_change]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
  }
}

function add_weapon_type(weapontype, callback) {
  if(!isDefined(level.weapon_type_callback_array)) {
    level.weapon_type_callback_array = [];
  }

  weapontype = getweapon(weapontype);
  level.weapon_type_callback_array[weapontype] = callback;
}

function spawned_weapon_type(localclientnum) {
  weapontype = self.weapon.rootweapon;

  if(isDefined(level.weapon_type_callback_array) && isDefined(level.weapon_type_callback_array[weapontype])) {
    self thread[[level.weapon_type_callback_array[weapontype]]](localclientnum);
  }
}

function function_cbfd8fd6(localclientnum) {
  activecamo::function_cbfd8fd6(localclientnum);
}

function event_handler[notetrack_callclientscript] codecallback_callclientscript(eventstruct) {
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

function event_handler[notetrack_callclientscriptonlevel] codecallback_callclientscriptonlevel(eventstruct) {
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
  outerradius = float(eventstruct.outerradius);
  innerdamage = isDefined(self.var_f501d778) ? self.var_f501d778 : 50;
  outerdamage = isDefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25;
  var_a62fd3ab = isDefined(self.var_abe3f153) ? self.var_abe3f153 : 1;
  var_c1cde02b = isDefined(self.var_bd0f9401) ? self.var_bd0f9401 : 1;
  physicsexplosionsphere(eventstruct.localclientnum, origin, outerradius, innerradius, magnitude, innerdamage, outerdamage, var_a62fd3ab, var_c1cde02b);
}

function event_handler[scene_init] codecallback_serversceneinit(eventstruct) {
  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::init(eventstruct.scene_name);
  }
}

function event_handler[scene_play] codecallback_serversceneplay(eventstruct) {
  level thread scene_black_screen();

  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::play(eventstruct.scene_name);
  }
}

function event_handler[scene_stop] codecallback_serverscenestop(eventstruct) {
  level thread scene_black_screen();

  if(isDefined(level.server_scenes[eventstruct.scene_name])) {
    level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
  }
}

function scene_black_screen() {
  foreach(localclientnum in function_41bfa501()) {
    lui::screen_fade_out(localclientnum, 0);
  }

  waitframe(1);

  foreach(localclientnum in function_41bfa501()) {
    lui::screen_fade_in(localclientnum, 0);
  }
}

function event_handler[gadget_visionpulsereveal] codecallback_gadgetvisionpulse_reveal(eventstruct) {}

function private fade_to_black_for_x_sec(localclientnum, startwait, blackscreenwait, fadeintime, fadeouttime, var_79f400ae) {
  wait startwait;
  lui::screen_fade_out(localclientnum, fadeintime, var_79f400ae);
  wait blackscreenwait;

  if(isDefined(self)) {
    lui::screen_fade_in(localclientnum, fadeouttime, var_79f400ae);
  }
}

function event_handler[ui_fadeblackscreen] codecallback_fadeblackscreen(eventstruct) {
  if(isDefined(self) && isPlayer(self) && !isbot(self) && self function_21c0fa55()) {
    level thread fade_to_black_for_x_sec(eventstruct.localclientnum, 0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
  }
}

function event_handler[event_40f83b44] function_4b5ab05f(eventstruct) {
  if(isDefined(self) && isPlayer(self) && !isbot(self) && self function_21c0fa55()) {
    level thread fade_to_black_for_x_sec(eventstruct.localclientnum, 0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
  }
}

function event_handler[event_1f757215] function_5067ee2f(eventstruct) {
  self animation::play_siege(eventstruct.anim_name, eventstruct.shot_name, eventstruct.rate, eventstruct.loop);
}

function event_handler[forcestreambundle] codecallback_forcestreambundle(eventstruct) {
  forcestreambundle(eventstruct.name, eventstruct.var_3c542760, eventstruct.var_a0e51075);
}

function event_handler[event_bfc28859] function_582e112f(eventstruct) {
  if(isDefined(level.var_45ca79e5)) {
    [[level.var_45ca79e5]](eventstruct.localclientnum, eventstruct.eventtype, eventstruct.itemid, eventstruct.value, eventstruct.value2);
  }
}

function event_handler[event_a5e70678] function_11988454(eventstruct) {
  if(isDefined(level.var_a6c75fcb)) {
    [[level.var_a6c75fcb]](eventstruct.var_85604f16);
  }
}

function event_handler[trigger] codecallback_trigger(eventstruct) {
  if(isDefined(level.var_a6c75fcb)) {
    self callback(#"on_trigger", eventstruct);
    self callback(#"on_trigger_once", eventstruct);
    self remove_on_trigger_once("all");
  }
}

function event_handler[entity_deleted] codecallback_entitydeleted(eventstruct) {
  self callback(#"on_entity_deleted");
}

function event_handler[freefall] function_5019e563(eventstruct) {
  self callback(#"freefall", eventstruct);
  self entity_callback(#"freefall", eventstruct.localclientnum, eventstruct);
}

function event_handler[parachute] function_87b05fa3(eventstruct) {
  self callback(#"parachute", eventstruct);
  self entity_callback(#"parachute", eventstruct.localclientnum, eventstruct);
}

function event_handler[skydive_touch] function_5bc68fd9(eventstruct) {
  self callback(#"skydive_touch", eventstruct);
  self entity_callback(#"skydive_touch", eventstruct.localclientnum, eventstruct);
}

function event_handler[skydive_end] function_250a9740(eventstruct) {
  self callback(#"skydive_end", eventstruct);
  self entity_callback(#"skydive_end", eventstruct.localclientnum, eventstruct);
}

function event_handler[death] codecallback_death(eventstruct) {
  self notify(#"death", eventstruct);
  self entity_callback(#"death", eventstruct);
}

function event_handler[melee] codecallback_melee(eventstruct) {
  self callback(#"melee", eventstruct);
}

function event_handler[culled] function_667f84de(eventstruct) {
  self entity_callback(#"culled", eventstruct);
}

function event_handler[event_1b69f758] function_255585d(eventstruct) {
  callback(#"on_team_change", eventstruct);
}

function event_handler[weapon_change] function_6846a2b7(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"weapon_change", eventstruct);
  }

  self callback(#"weapon_change", eventstruct);
}

function event_handler[event_41480c76] function_c33f3471(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"hash_4152cf6a61494581", eventstruct);
  }

  self callback(#"hash_4152cf6a61494581", eventstruct);
}

function event_handler[event_6e84b1b1] function_ff9acfac(eventstruct) {
  level callback(#"hash_2fc4cfecaed47583", eventstruct);
}

function event_handler[event_2a48d8d7] function_c0a2fad1(eventstruct) {
  self callback(#"hash_42d524149523a1eb", eventstruct);
  self callback(#"hash_eb85a61dd6639ae", eventstruct);
}

function event_handler[event_4e1fa07c] function_5ea431f0(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"hash_56b841ac8d1dac0b", eventstruct);
    level callback(#"hash_eb85a61dd6639ae", eventstruct);
  }

  self callback(#"hash_56b841ac8d1dac0b", eventstruct);
  self callback(#"hash_eb85a61dd6639ae", eventstruct);
}

function event_handler[event_2a2c80ff] function_7831af89(eventstruct) {
  if(self function_21c0fa55()) {
    level callback(#"hash_28ae86e34f270362", eventstruct);
    level callback(#"hash_eb85a61dd6639ae", eventstruct);
  }

  self callback(#"hash_28ae86e34f270362", eventstruct);
  self callback(#"hash_eb85a61dd6639ae", eventstruct);
}

function event_handler[updateactivecamo] codecallback_updateactivecamo(eventstruct) {
  self callback(#"updateactivecamo", eventstruct.localclientnum, eventstruct);
}

function event_handler[event_ab7a7fd3] function_bc70e1e4(eventstruct) {
  self callback(#"hash_6900f4ea0ff32c3e", eventstruct);
}

function event_handler[ping] function_87cf247e(eventstruct) {
  self callback(#"on_ping", eventstruct);
}

function event_handler[event_7fdec554] function_45d8e443(eventstruct) {
  self callback(#"hash_5768f5220f99ebd1", eventstruct);
}

function event_handler[mantle_low] function_84c7f7d4(eventstruct) {
  self callback(#"mantle_low", eventstruct);
}

function event_handler[mantle_high] function_fcc3f82c(eventstruct) {
  self callback(#"mantle_high", eventstruct);
}

function event_handler[event_919707cb] function_75438dba(eventstruct) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  localclientnum = eventstruct.localclientnum;

  if(!isDefined(localclientnum)) {
    return;
  }

  if(isDefined(level.var_a979e61b)) {
    if(self[[level.var_a979e61b]](localclientnum) === 1) {
      return;
    }
  }

  if(isDefined(level.var_a05cd64e)) {
    if(self[[level.var_a05cd64e]](localclientnum) === 1) {
      return;
    }
  }

  if(isDefined(level.var_53854c4)) {
    if(self[[level.var_53854c4]](localclientnum) === 1) {
      return;
    }
  }
}

function event_handler[event_fa673889] function_54972fb6(eventstruct) {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }

  localclientnum = eventstruct.localclientnum;

  if(!isDefined(localclientnum)) {
    return;
  }

  if(isDefined(level.var_a05cd64e)) {
    if(self[[level.var_a05cd64e]](localclientnum) === 1) {
      return;
    }
  }
}

function event_handler[event_f4737734] objective_update(eventstruct) {
  self callback(#"server_objective", eventstruct);
}

function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.stunned = bwastimejump;
  println("<dev string:x275>");

  if(bwastimejump) {
    self notify(#"stunned");
  } else {
    self notify(#"not_stunned");
  }

  if(isDefined(self.stunnedcallback)) {
    self[[self.stunnedcallback]](fieldname, bwastimejump);
  }
}