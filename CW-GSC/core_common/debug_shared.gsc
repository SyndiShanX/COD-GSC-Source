/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\debug_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace debug;

function private autoexec __init__system__() {
  system::register(#"debug", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread debug_draw_tuning_sphere();
  level thread devgui_debug_key_value();
  level thread function_e648ca7c();
  callback::on_loadout(&on_loadout);

  if(getdvarint(#"hash_2bf322fc226fa167", 0)) {
    adddebugcommand("<dev string:x38>");
  }
}

function private function_ddca74dd() {
  weaponname = getDvar(#"hash_136a06446fceeaa5", "<dev string:x5f>");

  if(weaponname != "<dev string:x5f>") {
    waitframe(1);
    split = strtok(weaponname, "<dev string:x63>");

    switch (split.size) {
      case 1:
      default:
        weapon = getweapon(split[0]);
        break;
      case 2:
        weapon = getweapon(split[0], split[1]);
        break;
      case 3:
        weapon = getweapon(split[0], split[1], split[2]);
        break;
      case 4:
        weapon = getweapon(split[0], split[1], split[2], split[3]);
        break;
      case 5:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
        break;
    }

    if(weapon != level.weaponnone) {
      self giveweapon(weapon);
      self switchtoweapon(weapon);
      self.spawnweapon = weapon;
    }
  }
}

function private on_loadout() {
  self function_ddca74dd();
}

function devgui_debug_key_value() {
  a_keys = array("<dev string:x68>", "<dev string:x72>", "<dev string:x7e>", "<dev string:x8b>", "<dev string:xa0>", "<dev string:xae>", "<dev string:xbf>", "<dev string:xcd>", "<dev string:xd7>");
  setDvar(#"debug_key_value", 0);
  setDvar(#"debug_key_value_dist", 2000);
  adddebugcommand("<dev string:xdf>");
  adddebugcommand("<dev string:x132>");

  foreach(str_key in a_keys) {
    adddebugcommand("<dev string:x17f>" + str_key + "<dev string:x1b2>" + str_key + "<dev string:x1cd>");
  }

  while(!flag::exists("<dev string:x1d3>")) {
    util::wait_network_frame();
  }

  level flag::wait_till("<dev string:x1d3>");

  while(true) {
    debug_key_value = getDvar(#"debug_key_value", 0);

    if(debug_key_value != 0) {
      a_ents = getEntArray();

      foreach(ent in a_ents) {
        n_draw_dist = getdvarint(#"debug_key_value_dist", 0);
        n_draw_dist_sq = n_draw_dist * n_draw_dist;
        n_dist_sq = distancesquared(ent.origin, level.players[0].origin);

        if(n_dist_sq <= n_draw_dist_sq) {
          n_scale = mapfloat(0, 6250000, 0.5, 5, n_dist_sq);
          ent thread debug_key_value(string(debug_key_value), undefined, n_scale);
          continue;
        }

        ent notify(#"debug_key_value");
      }
    } else {
      level notify(#"debug_key_value");
    }

    wait randomfloatrange(0.133333, 0.266667);
  }
}

function debug_draw_tuning_sphere() {
  n_sphere_radius = 0;
  v_text_position = (0, 0, 0);
  n_text_scale = 1;

  while(true) {
    n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);

    while(n_sphere_radius >= 1) {
      players = getplayers();

      if(isDefined(players[0])) {
        n_sphere_radius = getdvarfloat(#"debug_measure_sphere_radius", 0);
        circle(players[0].origin, n_sphere_radius, (1, 0, 0), 0, 1, 16);
        n_text_scale = sqrt(n_sphere_radius * 2.5) / 2;
        vforward = anglesToForward(players[0].angles);
        v_text_position = players[0].origin + vforward * n_sphere_radius;
        sides = int(10 * (1 + int(n_text_scale) % 100));
        sphere(v_text_position, n_text_scale, (1, 0, 0), 1, 1, sides, 16);
        print3d(v_text_position + (0, 0, 20), n_sphere_radius, (1, 0, 0), 1, n_text_scale / 14, 16);
      }

      waitframe(1);
    }

    wait 1;
  }
}

function debug_key_value(str_key, n_time, n_scale) {
  if(!isDefined(n_scale)) {
    n_scale = 1;
  }

  level endon(#"debug_key_value");
  self notify(#"debug_key_value");
  self endon(#"debug_key_value", #"death");

  if(isDefined(str_key)) {
    if(isDefined(n_time)) {
      __s = spawnStruct();
      __s endon(#"timeout");
      __s util::delay_notify(n_time, "<dev string:x1eb>");
    }

    while(true) {
      value = self.(str_key);

      if(isDefined(value)) {
        print3d(self.origin, isDefined(value) ? "<dev string:x5f>" + value : "<dev string:x5f>", (0, 0, 1), 1, n_scale, 1);
      }

      waitframe(1);
    }
  }
}

function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    waitframe(1);
  }
}

function drawdebugenttoentinternal(ent1, ent2, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    if(!isDefined(ent1) || !isDefined(ent2)) {
      return;
    }

    line(ent1.origin, ent2.origin, color);
    waitframe(1);
  }
}

function drawdebugline(frompoint, topoint, color, durationframes) {
  thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
}

function drawdebuglineenttoent(ent1, ent2, color, durationframes) {
  thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
}

function function_e648ca7c() {
  setDvar(#"hash_b8d10baa344fcbd", 0);
  function_cd140ee9(#"hash_b8d10baa344fcbd", &function_68f58e51);
}

function function_68f58e51(params) {
  level.var_77e1430c = params.value;
  function_c0767f67();
}

function function_1b531660() {
  if(!isDefined(level.var_77e1430c)) {
    level.var_77e1430c = 0;
  }

  level.var_77e1430c = !level.var_77e1430c;
  function_c0767f67();
}

function function_c0767f67() {
  if(!isDefined(level.var_77e1430c)) {
    level.var_77e1430c = 0;
  }

  if(level.var_77e1430c) {
    callback::on_player_damage(&function_e7321799);
    callback::on_actor_damage(&function_e7321799);
    callback::on_vehicle_damage(&function_e7321799);
    callback::on_scriptmover_damage(&function_e7321799);
    return;
  }

  callback::remove_on_player_damage(&function_e7321799);
  callback::remove_on_actor_damage(&function_e7321799);
  callback::remove_on_vehicle_damage(&function_e7321799);
  callback::remove_on_scriptmover_damage(&function_e7321799);
}

function function_e7321799(params) {
  damage = params.idamage;
  location = params.vpoint;
  target = self;
  smeansofdeath = params.smeansofdeath;

  if(smeansofdeath == "<dev string:x1f6>" || smeansofdeath == "<dev string:x205>") {
    location = self.origin + (0, 0, 60);
  }

  if(damage) {
    thread function_2cde0af9("<dev string:x63>" + damage, (1, 1, 1), location, (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 2), 30);
  }
}

function function_2cde0af9(text, color, start, velocity, frames) {
  location = start;
  alpha = 1;

  for(i = 0; i < frames; i++) {
    print3d(location, text, color, alpha, 0.6, 1);
    location += velocity;
    alpha -= 1 / frames * 2;
    waitframe(1);
  }
}