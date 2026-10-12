/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\powerups.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_4a6760982b403bad;
#using script_72ef6b9f0cf1f55a;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace powerups;

function init_powerups(var_751ff6b802605de7, var_931062a9b77a0c65) {
  level flag_set("drop_powerups");
  root = function_ecdae672c660149e();
  root.active_powerups = [];
  root.powerups = [];
  root.powerup_index = 0;
  root.var_eaf13acb539829eb = [];
  root.var_211f18c4ee5c760f = [];
  level thread function_4d4c49885e6b2490(var_751ff6b802605de7, var_931062a9b77a0c65);
  utility::registersharedfunc("powerups", "dropPowerup", &powerup_drop);
}

function private function_4d4c49885e6b2490(var_751ff6b802605de7, var_931062a9b77a0c65) {
  wait 1;
  root = function_ecdae672c660149e();
  var_80a668917844846 = function_e6f547b7f0a996ed();
  list_index = 0;

  foreach(var_610934571c352e02 in var_80a668917844846.powerup_list) {
    if(isDefined(var_610934571c352e02.ref) && isDefined(var_610934571c352e02.bundle)) {
      var_2fa928445372d72 = getscriptbundle("powerup:" + var_610934571c352e02.bundle);
      root.powerups[var_610934571c352e02.ref] = var_2fa928445372d72;
      root.var_eaf13acb539829eb[var_610934571c352e02.ref] = list_index;

      if(istrue(var_610934571c352e02.var_cc9e5dd3893defb)) {
        root.var_211f18c4ee5c760f[root.var_211f18c4ee5c760f.size] = var_610934571c352e02.ref;
      }
    }

    list_index++;
  }

  root.var_211f18c4ee5c760f = array_randomize(root.var_211f18c4ee5c760f);
  function_5b0b83c04b92d1fa("drop_event_incremental_number_per_player", var_80a668917844846.drop_event_incremental_number_per_player);

  if(isarray(var_80a668917844846.var_652fff0810f34100)) {
    drop_event_ranges = [];

    foreach(range in var_80a668917844846.var_652fff0810f34100) {
      range_struct = spawnStruct();
      range_struct.n_players = range.player_number;
      range_struct.n_min = range.min;
      range_struct.n_max = range.max;
      range_struct.var_9bf1ae0273911662 = range.var_7cce2df0592b4cf;
      range_struct.str_label = range.category_label;
      drop_event_ranges[drop_event_ranges.size] = range_struct;
    }

    function_5b0b83c04b92d1fa("drop_event_ranges", drop_event_ranges);
  }

  function_5b0b83c04b92d1fa("drop_height_offset", default_to(var_80a668917844846.drop_height_offset, 0));
  function_5b0b83c04b92d1fa("model_drop_delay_max", default_to(var_80a668917844846.model_drop_delay_max, 0));
  function_5b0b83c04b92d1fa("model_drop_delay_min", default_to(var_80a668917844846.model_drop_delay_min, 0));
  function_5b0b83c04b92d1fa("model_drop_delay_distance_outer", default_to(var_80a668917844846.model_drop_delay_distance_outer, 0));
  function_5b0b83c04b92d1fa("model_drop_delay_distance_inner", default_to(var_80a668917844846.model_drop_delay_distance_inner, 0));
  function_5b0b83c04b92d1fa("intro_vfx_label", var_80a668917844846.intro_vfx_label);
  function_5b0b83c04b92d1fa("intro_vfx_duration", var_80a668917844846.intro_vfx_duration);
  function_5b0b83c04b92d1fa("idle_vfx_label", var_80a668917844846.idle_vfx_label);
  function_5b0b83c04b92d1fa("grabbed_vfx_label", var_80a668917844846.grabbed_vfx_label);
  function_5b0b83c04b92d1fa("grabbed_vfx_duration", var_80a668917844846.grabbed_vfx_duration);
  root.show_splash = getdvarint(@ "hash_c33094fc634b0af", var_80a668917844846.showsplash) == 1;
  var_19aff13734d0248d = function_5b0b83c04b92d1fa("powerup_ammo_spacing_min", int(default_to(var_80a668917844846.ammo_spacing_min, 0)));
  var_198cdb3734a9ac73 = function_5b0b83c04b92d1fa("powerup_ammo_spacing_max", int(default_to(var_80a668917844846.ammo_spacing_max, 0)));

  if(var_198cdb3734a9ac73 != 0 || var_19aff13734d0248d != 0) {
    if(var_198cdb3734a9ac73 > var_19aff13734d0248d) {
      root.var_34d5d13b703a35c9 = function_1652f8a8050283bd(var_19aff13734d0248d, var_198cdb3734a9ac73);
    } else {
      assertmsg("<dev string:x1c>" + root.var_8487d1e9569b89de);
    }
  }

  if(isarray(root.var_4add5bc41afc8ae)) {
    foreach(struct in root.var_4add5bc41afc8ae) {
      _register(struct.str_powerup, struct.func_grab_powerup, struct.func_should_drop_with_regular_powerups, struct.var_58a4e1d475eb979b);
    }

    root.var_4add5bc41afc8ae = undefined;
  }

  if(isDefined(var_931062a9b77a0c65)) {
    level[[var_931062a9b77a0c65]]();
  }
}

function function_8ca4b49ee68720bf(event) {
  level callback::add(event, &function_320c6c17c3136d0a);
}

function function_e6f547b7f0a996ed() {
  root = function_ecdae672c660149e();

  if(!isDefined(root.var_a61c20c83f255666)) {
    if(isDefined(level.var_a77c94576da6cab0)) {
      var_a77c94576da6cab0 = "poweruplist:" + level.var_a77c94576da6cab0;
      root.var_8487d1e9569b89de = level.var_a77c94576da6cab0;
    } else {
      var_a77c94576da6cab0 = undefined;

      if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.powerup_list)) {
        var_a77c94576da6cab0 = "poweruplist:" + level.gametypebundle.powerup_list;
        root.var_8487d1e9569b89de = level.gametypebundle.powerup_list;
      } else if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.powerup_list)) {
        var_a77c94576da6cab0 = "poweruplist:" + level.gamemodebundle.powerup_list;
        root.var_8487d1e9569b89de = level.gamemodebundle.powerup_list;
      }

      assertex(isDefined(var_a77c94576da6cab0), "<dev string:x52>");
    }

    root.var_a61c20c83f255666 = getscriptbundle(var_a77c94576da6cab0);
  }

  return root.var_a61c20c83f255666;
}

function register_powerup(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_58a4e1d475eb979b) {
  root = function_ecdae672c660149e();

  if(isarray(root.powerups) && root.powerups.size > 0) {
    _register(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_58a4e1d475eb979b);
    return;
  }

  function_854b2d27ee860e0e(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_58a4e1d475eb979b);
}

function _register(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_58a4e1d475eb979b) {
  root = function_ecdae672c660149e();

  if(isDefined(root.powerups[str_powerup])) {
    root.powerups[str_powerup].func_grab_powerup = func_grab_powerup;
    root.powerups[str_powerup].func_should_drop_with_regular_powerups = default_to(func_should_drop_with_regular_powerups, &func_should_always_drop);
    root.powerups[str_powerup].var_58a4e1d475eb979b = var_58a4e1d475eb979b;
  }
}

function function_854b2d27ee860e0e(str_powerup, func_grab_powerup, func_should_drop_with_regular_powerups, var_58a4e1d475eb979b) {
  root = function_ecdae672c660149e();

  if(!isarray(root.var_4add5bc41afc8ae)) {
    root.var_4add5bc41afc8ae = [];
  }

  struct = spawnStruct();
  struct.str_powerup = str_powerup;
  struct.func_grab_powerup = func_grab_powerup;
  struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
  struct.var_58a4e1d475eb979b = var_58a4e1d475eb979b;
  root.var_4add5bc41afc8ae[root.var_4add5bc41afc8ae.size] = struct;
}

function powerup_activate(str_powerup, ent_powerup) {
  assert(isPlayer(self));
  player = self;
  var_2fa928445372d72 = function_519d44e54a9b8ae5(str_powerup);
  player thread[[var_2fa928445372d72.func_grab_powerup]](str_powerup, ent_powerup);
}

function function_a7f6960c623182d2(str_powerup) {
  return istrue(function_519d44e54a9b8ae5(str_powerup).var_87bfb9b44387c5c8);
}

function function_c414330b83d2e427(str_powerup) {
  return !function_a7f6960c623182d2(str_powerup) && istrue(function_519d44e54a9b8ae5(str_powerup).var_7af5681aad466bb);
}

function function_896f9300bcde23c2(str_powerup) {
  affected_radius = function_519d44e54a9b8ae5(str_powerup).var_11a46abceed0ee1c;

  if(isfloat(affected_radius)) {
    return affected_radius;
  }

  return 0;
}

function function_519d44e54a9b8ae5(str_powerup) {
  return function_ecdae672c660149e().powerups[str_powerup];
}

function function_a56a8b17eae57b09(str_powerup, powerup_origin) {
  root = function_ecdae672c660149e();
  a_players = [];

  if(function_a7f6960c623182d2(str_powerup)) {
    a_players = array_add(a_players, self);
  } else if(function_c414330b83d2e427(str_powerup)) {
    a_players = level.players;
  } else if(isDefined(root.var_d476bc08981505b4)) {
    a_players = self[[root.var_d476bc08981505b4]]();
  } else {
    foreach(player in level.players) {
      if(isalive(player) && self.team == player.team) {
        a_players = array_add(a_players, player);
      }
    }
  }

  final_players = [];
  var_e920c25b027ffdde = function_896f9300bcde23c2(str_powerup);

  if(isDefined(powerup_origin) && var_e920c25b027ffdde > 0) {
    foreach(player in a_players) {
      if(distancesquared(player.origin, powerup_origin) <= squared(var_e920c25b027ffdde)) {
        final_players = array_add(final_players, player);
      }
    }
  } else {
    final_players = a_players;
  }

  return final_players;
}

function function_d4be622286a198(str_powerup, v_spawn_pos, v_spawn_angles) {
  level endon("game_ended");
  e_powerup = powerup_drop(str_powerup, v_spawn_pos, -1, 0);

  if(isDefined(e_powerup)) {
    e_powerup.angles = v_spawn_angles;
    e_powerup.mesh_mdl.angles = v_spawn_angles;
    e_powerup setModel("jup_zm_powerup_vfx");
    contents = trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
    v_up = anglestoup(e_powerup.angles);
    caststart = e_powerup.origin + v_up * 32;
    castend = caststart + v_up * -100;
    traceresult = trace::ray_trace(caststart, castend, [], contents);

    if(isDefined(traceresult["entity"])) {
      e_powerup linkTo(traceresult["entity"]);
      e_powerup.mesh_mdl linkTo(traceresult["entity"]);
    }
  }
}

function function_c38c89a662ac4f51(str_powerup, origin) {
  if(!isDefined(origin)) {
    assertmsg("<dev string:xc2>");
    return;
  }

  offset = (0, 0, function_edeba0070ca0709e("drop_height_offset"));
  level thread powerup_drop(str_powerup, origin + offset);
}

function powerup_drop(str_powerup, v_spawn_pos, var_cfca9abfbb48775e, var_31a30ed92b3baeec) {
  if(!isDefined(var_31a30ed92b3baeec)) {
    var_31a30ed92b3baeec = 1;
  }

  self endon("powerup_grabbed");
  self endon("death");
  root = function_ecdae672c660149e();
  var_2fa928445372d72 = function_519d44e54a9b8ae5(str_powerup);
  e_powerup = spawn("script_model", v_spawn_pos);
  e_powerup setModel("tag_origin");
  e_powerup function_52bb753b67c409bd(var_2fa928445372d72.model, 1);
  e_powerup.str_powerup = str_powerup;
  function_afb7ebfa593cc2d5(str_powerup);
  offset = (0, 0, function_edeba0070ca0709e("drop_height_offset"));

  if(var_31a30ed92b3baeec) {
    groundent = e_powerup thread function_ff48fa45d1f0c4e1(offset);
    groundent = e_powerup.mesh_mdl function_ff48fa45d1f0c4e1(offset);
    e_powerup thread powerup_wobble(e_powerup.mesh_mdl, groundent);
  }

  e_powerup thread powerup_timeout(var_cfca9abfbb48775e);
  e_powerup thread powerup_wait_for_pickup();
  root.active_powerups = array_add(root.active_powerups, e_powerup);
  level notify("powerup_dropped", e_powerup);

  if(isDefined(root.dropped_callbacks)) {
    foreach(dc in root.dropped_callbacks) {
      level[[dc]](e_powerup);
    }
  }

  return e_powerup;
}

function function_ff48fa45d1f0c4e1(offset) {
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  movingplatforminfo = function_2e9e02e8bda61ef2();

  if(isDefined(movingplatforminfo) && isDefined(movingplatforminfo.groundent) && isDefined(movingplatforminfo.localorigin) && isDefined(movingplatforminfo.localangles)) {
    if(isDefined(self.linkedparent)) {
      self.linkedparent linkTo(movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles);
    } else {
      self linkTo(movingplatforminfo.groundent, "", movingplatforminfo.localorigin + offset, movingplatforminfo.localangles);
    }

    return movingplatforminfo.groundent;
  }
}

function function_6941afdf7d54f58c(func_callback) {
  root = function_ecdae672c660149e();

  if(!isDefined(root.dropped_callbacks)) {
    root.dropped_callbacks = [];
  }

  root.dropped_callbacks[root.dropped_callbacks.size] = func_callback;
}

function function_afb7ebfa593cc2d5(str_powerup) {
  root = function_ecdae672c660149e();

  if(isDefined(root.var_34d5d13b703a35c9)) {
    if(str_powerup == "full_ammo") {
      root.var_34d5d13b703a35c9 = function_1652f8a8050283bd(function_edeba0070ca0709e("powerup_ammo_spacing_min"), function_edeba0070ca0709e("powerup_ammo_spacing_max"));
      return;
    }

    if(root.var_34d5d13b703a35c9 > 0) {
      root.var_34d5d13b703a35c9--;
    }
  }
}

function powerup_wobble(ent_model, groundent) {
  self endon("powerup_grabbed");
  self endon("powerup_timedout");
  self endon("death");
  powerup_info = function_519d44e54a9b8ae5(self.str_powerup);

  if(istrue(powerup_info.var_4b1dd9ec52ba79a3)) {
    return;
  }

  while(isDefined(ent_model)) {
    waittime = randomfloatrange(2.5, 5);
    yaw = randomint(360);

    if(yaw > 300) {
      yaw = 300;
    } else if(yaw < 60) {
      yaw = 60;
    }

    yaw = ent_model.angles[1] + yaw;
    new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));

    if(isDefined(groundent)) {
      ent_model rotateTo(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    } else {
      ent_model rotateTo(new_angles, waittime, waittime * 0.5, waittime * 0.5);
    }

    wait randomfloat(waittime - 0.1);
  }
}

function powerup_timeout(n_lifetime) {
  if(isDefined(n_lifetime) && n_lifetime < 0) {
    return;
  }

  powerup_info = function_519d44e54a9b8ae5(self.str_powerup);
  n_lifetime = default_to(n_lifetime, powerup_info.var_7f552635d01b5fd5);
  self endon("powerup_grabbed");
  self endon("death");
  self endon("powerup_reset");
  blinktime = 10;
  var_e4416a8eb368fdd7 = max(0, n_lifetime - blinktime);
  wait var_e4416a8eb368fdd7;
  thread hide_and_show(&powerup_hide, &powerup_show);
  wait blinktime;
  self notify("powerup_timedout");

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("sound")) {
    self.mesh_mdl setscriptablepartstate("sound", "timed_out");
  }

  thread function_98041907892dbd80();
}

function powerup_hide() {
  if(isDefined(self)) {
    self hide();
  }

  if(isDefined(self.mesh_mdl)) {
    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("blink")) {
      self.mesh_mdl setscriptablepartstate("blink", "blink_hide");
      return;
    }

    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("idle")) {
      self.mesh_mdl setscriptablepartstate("idle", "hide");
      return;
    }

    self.mesh_mdl hide();
  }
}

function powerup_show(var_bce144cbc1e37b8e) {
  if(isDefined(self)) {
    self show();
  }

  if(isDefined(self.mesh_mdl)) {
    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("blink")) {
      if(istrue(var_bce144cbc1e37b8e)) {
        self.mesh_mdl setscriptablepartstate("blink", "blink_show");
      } else {
        self.mesh_mdl setscriptablepartstate("blink", "blink_show_with_audio");
      }

      return;
    }

    if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("idle")) {
      self.mesh_mdl setscriptablepartstate("idle", "show");
      return;
    }

    self.mesh_mdl show();
  }
}

function hide_and_show(hide_func, show_func) {
  self endon("death");
  var_bce144cbc1e37b8e = 0;

  for(i = 0; i < 40; i++) {
    if(i % 2) {
      self[[show_func]](var_bce144cbc1e37b8e);
    } else {
      self[[hide_func]]();
    }

    if(i < 16) {
      wait 0.5;
      continue;
    }

    if(i < 24) {
      var_bce144cbc1e37b8e = 1;
      wait 0.25;
      continue;
    }

    var_bce144cbc1e37b8e = 1;
    wait 0.1;
  }
}

function powerup_delete() {
  if(isDefined(self.e_trigger)) {
    self.e_trigger delete();
  }

  if(isDefined(self.mesh_mdl)) {
    self.mesh_mdl delete();
  }

  root = function_ecdae672c660149e();

  if(isDefined(self)) {
    root.active_powerups = array_remove(root.active_powerups, self);
    self delete();
  }
}

function powerup_wait_for_pickup() {
  self endon("death");
  root = function_ecdae672c660149e();
  var_2fa928445372d72 = function_519d44e54a9b8ae5(self.str_powerup);
  offset = (0, 0, function_edeba0070ca0709e("drop_height_offset"));
  origin = self.origin - offset;
  self.e_trigger = spawn("trigger_radius", origin, 0, 32, 72);
  self.e_trigger enablelinkTo();
  self.e_trigger linkTo(self);

  while(true) {
    self.e_trigger waittill("trigger", ent);
    player = ent;

    if(isDefined(root.var_5cdeaceda00983a3)) {
      player = ent[[root.var_5cdeaceda00983a3]]();
    }

    if(!istrue(var_2fa928445372d72.var_f9f899d9e6df9373) && !isPlayer(player)) {
      continue;
    }

    if(!istrue(var_2fa928445372d72.powerupcanpickupinlaststand) && istrue(player.inlaststand)) {
      continue;
    }

    if(isDefined(self.mesh_mdl)) {
      if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("sound")) {
        self.mesh_mdl setscriptablepartstate("sound", "pickup");
      }
    }

    var_269d8af30921f43d = player function_a56a8b17eae57b09(self.str_powerup, self.origin);

    foreach(player_sound in var_269d8af30921f43d) {
      sound_event = "sndevent_powerup_" + self.str_powerup;
      player_sound playsoundevent(sound_event, player_sound);
      namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_operator_vo", {
        #target: undefined, #speaker: player_sound, #sound_event: sound_event, #sound_type: undefined, #script_func_name: "powerup_wait_for_pickup"});
    }

    if(isDefined(var_2fa928445372d72.var_c5a9d2297ea16382)) {
      a_players = player function_a56a8b17eae57b09(self.str_powerup, self.origin);

      foreach(player_sound in a_players) {
        if(isalive(player_sound)) {
          player_sound namespace_53fc9ddbb516e6e1::playsoundtoplayersharedfunc(var_2fa928445372d72.var_c5a9d2297ea16382, player_sound);
        }
      }
    }

    if(isDefined(player.name)) {
      iprintlnbold(self.str_powerup + "<dev string:xe9>" + player.name);
    }

    level callback::callback(#"player_powerup", {
      #player: player, #powerup: self
    });
    player powerup_activate(self.str_powerup, self);
    player namespace_53fc9ddbb516e6e1::dopowerupscoreeventsharedfunc();
    self notify("powerup_grabbed", player);
    thread function_98041907892dbd80(1);
    return;
  }
}

function get_next_powerup() {
  root = function_ecdae672c660149e();

  if(isDefined(level.var_7f2e8af1175e5aa5)) {
    str_powerup = level.var_7f2e8af1175e5aa5;
    level.var_7f2e8af1175e5aa5 = undefined;
    return str_powerup;
  }

  if(isDefined(level.var_37858f4d4dbe2433)) {
    str_powerup = level.var_37858f4d4dbe2433;
    level.var_37858f4d4dbe2433 = undefined;
  } else {
    str_powerup = root.var_211f18c4ee5c760f[root.powerup_index];
    root.powerup_index++;

    if(root.powerup_index >= root.var_211f18c4ee5c760f.size) {
      root.powerup_index = 0;
      function_39a01e773f00003();
    }
  }

  return str_powerup;
}

function function_39a01e773f00003() {
  root = function_ecdae672c660149e();
  root.var_211f18c4ee5c760f = array_randomize(root.var_211f18c4ee5c760f);
}

function func_should_always_drop() {
  return true;
}

function func_should_never_drop() {
  return false;
}

function function_320c6c17c3136d0a(params) {
  if(!function_76ccbdb9c3d32f22()) {
    return;
  }

  if(istrue(self.no_powerups)) {
    return;
  }

  root = function_ecdae672c660149e();

  if(isDefined(root.var_4e1cce72cf8d8f63)) {
    if(!self[[root.var_4e1cce72cf8d8f63]](params)) {
      return;
    }
  }

  drop_pos = isai(self) ? self.var_f182de6049d1ab48 : self.origin;

  if(!isDefined(level.var_2a474bda8984ac2a)) {
    level.var_2a474bda8984ac2a = throttle_initialize("powerup_drop", 1, level.framedurationseconds);
  }

  var_8ed8f695a88af352 = spawnStruct();
  function_f632348cbb773537(level.var_2a474bda8984ac2a, var_8ed8f695a88af352);
  var_cdcc412515151986 = 1;

  if(isDefined(root.var_29e4cb253683279f)) {
    params.etarget = self;
    var_cdcc412515151986 = level[[root.var_29e4cb253683279f]](params);
  }

  if(var_cdcc412515151986) {
    var_d01a68d4c8274caf = undefined;
    var_d01a68d4c8274caf = function_3f65dbe307c93086();

    if(isDefined(var_d01a68d4c8274caf)) {
      offset = (0, 0, function_edeba0070ca0709e("drop_height_offset"));
      level thread powerup_drop(var_d01a68d4c8274caf, drop_pos + offset);
    }
  }
}

function function_3f65dbe307c93086() {
  level endon("game_ended");
  root = function_ecdae672c660149e();

  if(isDefined(level.var_7f2e8af1175e5aa5)) {
    str_powerup = level.var_7f2e8af1175e5aa5;
    level.var_7f2e8af1175e5aa5 = undefined;
    return str_powerup;
  }

  for(n_loop = root.var_211f18c4ee5c760f.size * 2; n_loop > 0; n_loop--) {
    str_powerup = get_next_powerup();
    powerup_info = function_519d44e54a9b8ae5(str_powerup);

    if(!isDefined(powerup_info.func_should_drop_with_regular_powerups)) {
      return str_powerup;
    }

    is_available = [[powerup_info.func_should_drop_with_regular_powerups]]();

    if(istrue(is_available)) {
      return str_powerup;
    }
  }

  return undefined;
}

function function_8edb8c0ed499f61e(var_b963bd568903c6d) {
  function_ecdae672c660149e().var_7d478c526f5d7a85 = var_b963bd568903c6d;
}

function private function_76ccbdb9c3d32f22() {
  root = function_ecdae672c660149e();

  if(isDefined(root.var_7d478c526f5d7a85)) {
    return root.var_7d478c526f5d7a85;
  }

  return 1;
}

function function_5b0b83c04b92d1fa(zvar, value) {
  if(!isDefined(value)) {
    return undefined;
  }

  root = function_ecdae672c660149e();
  root.powerup_vars[zvar] = value;
  return value;
}

function function_edeba0070ca0709e(zvar) {
  root = function_ecdae672c660149e();
  return root.powerup_vars[zvar];
}

function powerup_hud_show(str_powerup, n_lifetime) {
  self endon("powerup_hud_show_" + str_powerup);
  self endon("disconnect");
  root = function_ecdae672c660149e();
  self[[root.var_b0d3396c2b9e78d4]](self.var_e2d9965430ae7f24[str_powerup], n_lifetime);
  self.var_a0e1c0f50ca3ef0f[self.var_e2d9965430ae7f24[str_powerup].index] = undefined;
  self.var_e2d9965430ae7f24[str_powerup] = undefined;
  self[[root.var_5a4c4a84060b59da]](str_powerup);
}

function function_587ecc90909a8c38(str_powerup) {
  self notify("powerup_hud_show_" + str_powerup);
  self endon("powerup_hud_show_" + str_powerup);
  self endon("disconnect");
  root = function_ecdae672c660149e();

  if(!isDefined(self.var_e2d9965430ae7f24)) {
    self.var_e2d9965430ae7f24 = [];
  }

  if(!isDefined(self.var_e2d9965430ae7f24[str_powerup])) {
    self.var_e2d9965430ae7f24[str_powerup] = spawnStruct();
  }

  if(!isDefined(self.var_a0e1c0f50ca3ef0f)) {
    self.var_a0e1c0f50ca3ef0f = [];
  }

  powerupbundle = function_e6f547b7f0a996ed();
  poweruplist = powerupbundle.powerup_list;
  powerupindex = 0;
  spotfound = 0;

  for(i = 0; i < poweruplist.size; i++) {
    var_f8358178900f0d5f = isDefined(self.var_a0e1c0f50ca3ef0f[i]);
    var_8952024062b19822 = var_f8358178900f0d5f && self.var_a0e1c0f50ca3ef0f[i] == str_powerup;

    if(!var_f8358178900f0d5f || var_8952024062b19822) {
      if(!spotfound) {
        powerupindex = i;
        spotfound = 1;
        continue;
      }

      self.var_a0e1c0f50ca3ef0f[i] = undefined;
    }
  }

  self.var_e2d9965430ae7f24[str_powerup].str_powerup = str_powerup;
  self.var_e2d9965430ae7f24[str_powerup].start = gettime();
  self.var_e2d9965430ae7f24[str_powerup].index = powerupindex;
  self.var_a0e1c0f50ca3ef0f[powerupindex] = str_powerup;
  return self.var_e2d9965430ae7f24[str_powerup];
}

function function_e91cc9367bcb7f1a(hud_powerup, n_lifetime) {
  assert(isPlayer(self));
  root = function_ecdae672c660149e();
  poweruplist = function_e6f547b7f0a996ed();
  assertex(isDefined(root.var_eaf13acb539829eb[hud_powerup.str_powerup]), "<dev string:x103>" + hud_powerup.str_powerup + "<dev string:x118>");
  player = self;
  index = hud_powerup.index;
  scriptedwidgettype = poweruplist.var_5a95e049dbbdc1ec;
  refname = "hud_powerup_" + hud_powerup.str_powerup;
  isactive = player function_ada0825249682644(refname);

  if(n_lifetime > 0 && isDefined(scriptedwidgettype) && scriptedwidgettype != "") {
    state = default_to(poweruplist.scriptedwidgethudstate, "");
    anchorhorz = function_f845164fd6027e79(poweruplist.var_99a990e9f5ea961c);
    anchorvert = function_863b22a1564f8eb(poweruplist.var_40a95d7bb8872fa2);
    anchorx = default_to(poweruplist.var_fde517927a257ba7, 0);
    anchory = default_to(poweruplist.var_fde516927a257974, 0);
    stepx = default_to(poweruplist.var_3a83b92e9fcd024a, 0);
    stepy = default_to(poweruplist.var_3a83ba2e9fcd047d, 0);

    if(!isactive) {
      player function_90de31b2cbef19f9(refname, scriptedwidgettype);
      player function_d28fa5295a04d555(refname, state);
    }

    var_8d076e93bc8ccd99 = [];
    var_8d076e93bc8ccd99["bundle_index"] = root.var_eaf13acb539829eb[hud_powerup.str_powerup];
    var_8d076e93bc8ccd99["time"] = n_lifetime;
    player function_14a0ee2aaf9128c3(refname, var_8d076e93bc8ccd99, 0);
    player function_f4c37324750dc183(refname, anchorx + index * stepx, anchory + index * stepy, anchorhorz, anchorvert);
    return;
  }

  if(isactive) {
    player function_d28fa5295a04d555(refname, "hide");
    wait 1.5;
    player scripted_widget_destroy(refname);
  }
}

function function_aa5cdd71af797058(hud_powerup, n_lifetime) {
  assert(isPlayer(self));
  root = function_ecdae672c660149e();
  poweruplist = function_e6f547b7f0a996ed();
  assertex(isDefined(root.var_eaf13acb539829eb[hud_powerup.str_powerup]), "<dev string:x103>" + hud_powerup.str_powerup + "<dev string:x118>");
  player = self;
  index = root.var_eaf13acb539829eb[hud_powerup.str_powerup];
  scriptedwidgettype = poweruplist.var_509cf6c285b05999;
  refname = "hud_powerup_vignette";
  isactive = player function_ada0825249682644(refname);

  if(n_lifetime > 0 && isDefined(scriptedwidgettype) && scriptedwidgettype != "") {
    state = default_to(poweruplist.var_31bc54db39a319a2, "");
    param = default_to(poweruplist.var_193b808b8bdb874e, "");

    if(!isactive) {
      player function_90de31b2cbef19f9(refname, scriptedwidgettype);
      player function_d28fa5295a04d555(refname, state);
      player function_af4f62f0f944a8f1(refname, param);
    }

    return;
  }

  if(isactive) {
    player scripted_widget_destroy(refname);
  }
}

function function_5bfe254c7e9aa4db() {
  if(!isDefined(self.var_a0e1c0f50ca3ef0f)) {
    return;
  }

  poweruplist = function_e6f547b7f0a996ed();

  for(i = 0; i < self.var_a0e1c0f50ca3ef0f.size; i++) {
    self.var_a0e1c0f50ca3ef0f[i] = undefined;
  }

  foreach(powerup in poweruplist.powerup_list) {
    refname = "hud_powerup_" + powerup.ref;
    isactive = hud_management::function_ada0825249682644(refname);

    if(isactive) {
      hud_management::scripted_widget_destroy(refname);
    }
  }
}

function function_52bb753b67c409bd(model_name, var_f77ed8ae404fb650) {
  self endon("powerup_grabbed");
  self endon("death");
  intro_fx = function_edeba0070ca0709e("intro_vfx_label");
  var_3d0000bc842db347 = istrue(var_f77ed8ae404fb650) && isDefined(intro_fx) && fxexists(intro_fx);

  if(var_3d0000bc842db347) {
    function_5b0773c04b8eb8f3(intro_fx);
    wait function_edeba0070ca0709e("intro_vfx_duration");
  }

  function_5b0773c04b8eb8f3(function_edeba0070ca0709e("idle_vfx_label"));
  mdl_delay = function_fb089abb8dac6216();
  wait mdl_delay;
  self.mesh_mdl = spawn("script_model", self.origin);
  self.mesh_mdl setModel(model_name);

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("idle")) {
    self.mesh_mdl setscriptablepartstate("idle", "show");
  }

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("sound")) {
    self.mesh_mdl setscriptablepartstate("sound", "spawn");
  }
}

function function_98041907892dbd80(b_play_fx) {
  self endon("death");

  if(isDefined(self.e_trigger)) {
    self.e_trigger delete();
  }

  if(self.mesh_mdl isscriptable() && self.mesh_mdl getscriptablehaspart("idle")) {
    self.mesh_mdl setscriptablepartstate("idle", "hide");
  } else {
    self.mesh_mdl hide();
  }

  grabbed_vfx = function_edeba0070ca0709e("grabbed_vfx_label");
  var_26bf64b63e12ec04 = istrue(b_play_fx) && isDefined(grabbed_vfx) && fxexists(grabbed_vfx);

  if(var_26bf64b63e12ec04) {
    function_5b0773c04b8eb8f3(grabbed_vfx);
    wait function_edeba0070ca0709e("grabbed_vfx_duration");
  }

  wait 0.05;
  powerup_delete();
}

function function_5b0773c04b8eb8f3(str_fx_name) {
  if(!isDefined(self)) {
    return;
  }

  if(!fxexists(str_fx_name)) {
    return;
  }

  str_fx = getfx(str_fx_name);
  stop_vfx();
  play_vfx(str_fx);
}

function stop_vfx() {
  if(isDefined(self.n_powerup_fx)) {
    stopFXOnTag(self.n_powerup_fx, self, "tag_origin");
    self.n_powerup_fx = undefined;
  }
}

function play_vfx(str_fx) {
  self.n_powerup_fx = playFXOnTag(str_fx, self, "tag_origin");
}

function function_e419d148895ea689(powerup_name) {
  lifetime = function_ecdae672c660149e().powerups[powerup_name].var_f862e718db266e0a;

  if(isDefined(level.powerup_timeout_override)) {
    lifetime = self[[level.powerup_timeout_override]](lifetime);
  }

  return lifetime;
}

function private function_fb089abb8dac6216() {
  root = function_ecdae672c660149e();
  delay_min = function_edeba0070ca0709e("model_drop_delay_min");
  delay_max = function_edeba0070ca0709e("model_drop_delay_max");
  distance_outer = function_edeba0070ca0709e("model_drop_delay_distance_outer");
  distance_inner = function_edeba0070ca0709e("model_drop_delay_distance_inner");

  if(istrue(root.var_a43bd6a1b5aa5858)) {
    return delay_min;
  }

  e_player = getclosest(self.origin, level.players);

  if(!isDefined(e_player)) {
    return delay_max;
  }

  n_distance = distance(e_player.origin, self.origin);

  if(n_distance > distance_outer) {
    return delay_min;
  } else if(n_distance < distance_inner) {
    return delay_max;
  }

  n_delay = mapfloat(distance_inner, distance_outer, delay_max, delay_min, n_distance);
  return n_delay;
}

function function_1652f8a8050283bd(var_a24595ceea8d9a67, var_9c82af4273cc1f01) {
  return randomintrange(var_a24595ceea8d9a67, var_9c82af4273cc1f01 + 1);
}

function function_ecdae672c660149e() {
  if(!isDefined(level.powerups_root)) {
    level.powerups_root = spawnStruct();
  }

  return level.powerups_root;
}

function function_e2b8eeccc951133f(a_params) {
  var_580aba0d7d779ed2 = isDefined(a_params[1]) ? int(a_params[1]) : 1;
  str_powerup = a_params[0];
  root = function_ecdae672c660149e();

  if(var_580aba0d7d779ed2) {
    offset = (0, 0, function_edeba0070ca0709e("<dev string:x181>"));
    v_spawn_pos = scripts\common\devgui::function_9b4c82dba041b23d() + offset - (0, 0, 8);

    if(isDefined(v_spawn_pos) && isDefined(function_519d44e54a9b8ae5(str_powerup))) {
      e_powerup = namespace_2b1145f62aa835b8::droppowerupsharedfunc(str_powerup, v_spawn_pos);
    }

    return;
  }

  level.var_7f2e8af1175e5aa5 = str_powerup;
}

# /