/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_671f58f0b7aa833d.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace namespace_9fe28d6e;

function private autoexec __init__system__() {
  system::register(#"hash_38469cb55dd6355a", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  function_ad272ef4();
  function_90ceecf8();
  function_7c9b0132();
}

function private function_fa076c68() {}

function private function_ad272ef4() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  if(!isDefined(level._fx.ambientwar)) {
    level._fx.ambientwar = {};
  }

  if(!isDefined(level._fx.ambientwar.data)) {
    level._fx.ambientwar.data = [];
  }

  if(!isDefined(level._fx.ambientwar.input)) {
    level._fx.ambientwar.input = {};
  }
}

function private function_7c9b0132() {
  function_5ac4dc99(#"hash_1ccb34f428b1a279", 0);
  function_cd140ee9(#"hash_1ccb34f428b1a279", &function_93945397);
  function_5ac4dc99(#"hash_6d342deda30a228a", 100);
  function_5ac4dc99(#"hash_79ddea850d94a804", 0.5);
}

function private function_90ceecf8() {
  callback::on_spawned(&_on_player_spawned);
}

function private _on_player_spawned(localclientnum) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  if(!isDefined(level._fx.player)) {
    level._fx.player = self;
  }
}

function private function_93945397(parms) {
  if(parms.value == 1) {
    setDvar(#"hash_1614a5a56768d221", 0);
    level._fx.player val::set(#"hash_36c3761ec21ee4ac", "<dev string:x38>", 0);
    level._fx.player val::set(#"hash_36c3761ec21ee4ac", "<dev string:x44>", 1);
    level._fx.player val::set(#"hash_36c3761ec21ee4ac", "<dev string:x57>", 1);
    level._fx.player val::set(#"hash_36c3761ec21ee4ac", "<dev string:x72>", 1);
    adddebugcommand("<dev string:x84>");
    adddebugcommand("<dev string:x95>");
    function_8af93a7();
    return;
  }

  function_263df0ea();
  adddebugcommand("<dev string:xa6>");
  level._fx.player val::reset_all(#"hash_36c3761ec21ee4ac");
}

function private function_8af93a7() {
  namespace_61e6d095::create(#"hash_2f8c229e8241a3a0", #"hash_355d1782cf92b25");

  if(namespace_61e6d095::exists(#"hash_2f8c229e8241a3a0")) {
    if(!isDefined(level._fx.ambientwar)) {
      level._fx.ambientwar = {};
    }

    if(!isDefined(level._fx.ambientwar.data)) {
      level._fx.ambientwar.data = [];
    }

    if(!isDefined(level._fx.ambientwar.input)) {
      level._fx.ambientwar.input = {};
    }

    level._fx.ambientwar.var_bebc9d74 = 0;
    level thread function_56e7d0e3();
    function_d885deda(0);
    level thread function_2e225b16();
    buttons = [];
    buttons[buttons.size] = "<dev string:xbc>";
    buttons[buttons.size] = "<dev string:xc7>";
    buttons[buttons.size] = "<dev string:xd4>";
    level._fx.player thread function_5402d440(level._fx.ambientwar.input, buttons);
    level._fx.player thread function_a11a465a(level._fx.ambientwar.input);
  }
}

function private function_56e7d0e3() {
  self notify("<dev string:xe0>");
  self endon("<dev string:xe0>");
  level endon(#"hash_d28501bd896672c");

  while(true) {
    if(namespace_61e6d095::exists(#"hash_2f8c229e8241a3a0")) {
      for(i = 0; i < level._fx.ambientwar.var_bebc9d74; i++) {
        namespace_61e6d095::function_7239e030(#"hash_2f8c229e8241a3a0", i);
      }

      count = 0;

      foreach(entry in level._fx.ambientwar.data) {
        namespace_61e6d095::set_count(#"hash_2f8c229e8241a3a0", count);
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:xf4>", entry.var_c6bf081d);
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x105>", entry.is_active);
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x111>", entry.group_id);
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x11c>", entry.locations.size);
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x12d>", string(float(entry.distance.min), 1));
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x138>", string(float(entry.distance.max), 1));
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x143>", string(float(entry.delay.min), 1));
        namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", count, "<dev string:x14f>", string(float(entry.delay.max), 1));
        count++;
      }

      level._fx.ambientwar.var_bebc9d74 = count;
    }

    level waittill(#"hash_51a762912b76bdc1");
  }
}

function private function_263df0ea() {
  level notify(#"hash_d28501bd896672c");

  if(namespace_61e6d095::exists(#"hash_2f8c229e8241a3a0")) {
    namespace_61e6d095::remove(#"hash_2f8c229e8241a3a0");
  }
}

function private function_5402d440(input, buttons) {
  level endon(#"hash_d28501bd896672c");

  while(true) {
    foreach(button in buttons) {
      input.(button + "<dev string:x15b>") = input.(button);
      input.(button) = self buttonPressed(button);

      if(input.(button) && !isDefined(input.(button + "<dev string:x164>"))) {
        input.(button + "<dev string:x164>") = gettime();
      }

      if(!input.(button)) {
        input.(button + "<dev string:x164>") = undefined;
      }
    }

    waitframe(1);
  }
}

function private function_a11a465a(input) {
  self notify("<dev string:x170>");
  self endon("<dev string:x170>");
  level endon(#"hash_d28501bd896672c");

  while(true) {
    selection = isDefined(level._fx.ambientwar.selection) ? level._fx.ambientwar.selection : 0;
    current_time = gettime();
    var_5b49269e = getdvarint(#"hash_6d342deda30a228a", 100);

    if(input.dpad_up && !input.var_df3d5273 || isDefined(input.var_58d265ea) && current_time - input.var_58d265ea > var_5b49269e) {
      selection--;
      function_d885deda(selection);
      input.var_58d265ea = current_time + var_5b49269e;
    }

    if(input.dpad_down && !input.var_8a047c03 || isDefined(input.var_3c626fd) && current_time - input.var_3c626fd > var_5b49269e) {
      selection++;
      function_d885deda(selection);
      input.var_3c626fd = current_time + var_5b49269e;
    }

    if(input.button_y && !input.var_d356f692 || isDefined(input.var_6a06b2b8) && current_time - input.var_6a06b2b8 > var_5b49269e) {
      toggle(function_be6420e7(selection));
      input.var_6a06b2b8 = current_time + var_5b49269e;
    }

    waitframe(1);
  }
}

function private function_d885deda(selection) {
  level endon(#"hash_d28501bd896672c");

  if(isDefined(level._fx.ambientwar.selection)) {
    level._fx.ambientwar.data[function_be6420e7(level._fx.ambientwar.selection)].var_c6bf081d = 0;
    namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", level._fx.ambientwar.selection, "<dev string:xf4>", 0);
  }

  if(selection < 0) {
    selection = level._fx.ambientwar.data.size - 1;
  }

  if(selection >= level._fx.ambientwar.data.size) {
    selection = 0;
  }

  snd::play("<dev string:x184>", level._fx.player);
  level._fx.ambientwar.data[function_be6420e7(selection)].var_c6bf081d = 1;
  namespace_61e6d095::function_f2a9266(#"hash_2f8c229e8241a3a0", selection, "<dev string:xf4>", 1);
  level._fx.ambientwar.selection = selection;
}

function private function_2e225b16() {
  self notify("<dev string:x1a2>");
  self endon("<dev string:x1a2>");
  level endon(#"hash_d28501bd896672c");

  while(true) {
    if(isDefined(level._fx.ambientwar.selection)) {
      selection = level._fx.ambientwar.selection;
      group_id = function_be6420e7(selection);
      locations = level._fx.ambientwar.data[group_id].locations;
      distance = level._fx.ambientwar.data[group_id].distance;

      for(i = 0; i < locations.size; i++) {
        box(locations[i].origin, (-5, -5, -5), (5, 5, 5), locations[i].angles, (0, 0, 0), 1, 0, 1);
        debugaxis(locations[i].origin, locations[i].angles, 16, 1, 0, 1);

        if(function_1913c46(locations[i])) {
          circle(locations[i].origin, locations[i].var_c9dbde14, (1, 0.65, 0), 0, 1, 1);
        }

        if(isDefined(level._fx.player.origin)) {
          circle(level._fx.player.origin, distance.min, (0, 1, 0), 0, 1, 1);
          circle(level._fx.player.origin, distance.max, (1, 0, 0), 0, 1, 1);
        }
      }
    }

    waitframe(1);
  }
}

function private function_be6420e7(selection) {
  count = 0;

  foreach(entry in level._fx.ambientwar.data) {
    if(count == selection) {
      return entry.group_id;
    }

    count++;
  }

  return undefined;
}

function private function_20e12458(location, dist_min, dist_max) {
  if(!isDefined(level._fx.player.origin)) {
    return 0;
  }

  dist_sqr = distance2dsquared(level._fx.player.origin, location.origin);
  return dist_sqr >= sqr(dist_min) && dist_sqr <= sqr(dist_max) ? 1 : 0;
}

function private function_4c6d8fd3(location, fov) {
  if(!isDefined(level._fx.player.origin)) {
    return false;
  }

  return util::within_fov(level._fx.player.origin, level._fx.player.angles, location.origin, fov);
}

function private function_1913c46(location) {
  if(!isDefined(level._fx.player)) {
    return 0;
  }

  enemies = [];

  if(isDefined(location.var_c9dbde14) && location.var_c9dbde14 > 0) {
    enemies = level._fx.player getenemiesinradius(location.origin, location.var_c9dbde14);
  }

  return enemies.size < 0 ? 0 : 1;
}

function private function_613e65ee(group_id) {
  level endon("stop_ambientwar_" + group_id);
  delay = level._fx.ambientwar.data[group_id].delay;
  distance = level._fx.ambientwar.data[group_id].distance;
  locations = level._fx.ambientwar.data[group_id].locations;
  effects = level._fx.ambientwar.data[group_id].effects;

  if(locations.size <= 0) {
    return;
  }

  if(!isDefined(effects) || effects.size <= 0) {
    for(i = 0; i < locations.size; i++) {
      if(!isDefined(locations[i].var_b17f3758)) {
        arrayremoveindex(effects, i, 1);
      }
    }

    arrayremovevalue(locations, undefined);
  }

  while(locations.size > 0) {
    effect = undefined;
    rand_idx = randomintrange(0, locations.size);
    rand_loc = locations[rand_idx];
    on_screen = function_4c6d8fd3(rand_loc, 0.5);
    in_range = function_20e12458(rand_loc, distance.min, distance.max);
    ai_present = function_1913c46(rand_loc);

    if(is_true(on_screen) && is_true(in_range) && is_false(ai_present)) {
      if(isDefined(rand_loc.var_b17f3758) && rand_loc.var_b17f3758 != "") {
        effect = rand_loc.var_b17f3758;
      } else {
        effect = effects[randomintrange(0, effects.size)];
      }

      if(isDefined(effect)) {
        playFX(effect, rand_loc.origin, anglesToForward(rand_loc.angles), anglestoup(rand_loc.angles));

        if(getdvarint(#"hash_1ccb34f428b1a279", 0) && function_be6420e7(level._fx.ambientwar.selection) == group_id) {
          display_time = getdvarfloat(#"hash_79ddea850d94a804", 0.5) / float(function_60d95f53()) / 1000;
          start = rand_loc.origin + (0, 0, 20);
          end = rand_loc.origin + (0, 0, 100);
          str = isDefined(rand_loc.var_b17f3758) ? "<dev string:x1b6>" + effect : effect;
          line(start, end, (1, 0.65, 0), 1, 0, int(display_time));
          print3d(end, str, (1, 1, 1), 1, 0.5, int(display_time), 0);
        }

        wait randomfloatrange(delay.min, delay.max);
      }
    }

    waitframe(1);
  }
}

function create(group_id, var_6f2c5280 = undefined, min_delay = 0.5, max_delay = 1.5, min_dist = 100, max_dist = 1000) {
  delay = {};
  delay.min = min_delay;
  delay.max = max_delay;
  distance = {};
  distance.min = min_dist;
  distance.max = max_dist;
  struct = {};
  struct.var_c6bf081d = 0;
  struct.is_active = 0;
  struct.group_id = group_id;
  struct.locations = struct::get_array(group_id, "vfx_ambientwar_group_id");
  struct.effects = var_6f2c5280;
  struct.distance = distance;
  struct.delay = delay;

  if(isDefined(level._fx.ambientwar.data[group_id])) {
    return;
  }

  level._fx.ambientwar.data[group_id] = struct;

  level notify(#"hash_51a762912b76bdc1");
}

function start(group_id) {
  if(isDefined(level._fx.ambientwar.data[group_id])) {
    level._fx.ambientwar.data[group_id].is_active = 1;
    level thread function_613e65ee(group_id);

    level notify(#"hash_51a762912b76bdc1");
  }
}

function stop(group_id) {
  if(isDefined(level._fx.ambientwar.data[group_id])) {
    level notify("stop_ambientwar_" + group_id);
    level._fx.ambientwar.data[group_id].is_active = 0;

    level notify(#"hash_51a762912b76bdc1");
  }
}

function remove(group_id) {
  if(isDefined(level._fx.ambientwar.data[group_id])) {
    stop(group_id);
    level._fx.ambientwar.data[group_id] = undefined;
    arrayremovevalue(level._fx.ambientwar.data, undefined);

    level notify(#"hash_51a762912b76bdc1");
  }
}

function toggle(group_id) {
  if(isDefined(level._fx.ambientwar.data[group_id])) {
    if(is_true(level._fx.ambientwar.data[group_id].is_active)) {
      stop(group_id);
    } else {
      start(group_id);
    }

    level notify(#"hash_51a762912b76bdc1");
  }
}