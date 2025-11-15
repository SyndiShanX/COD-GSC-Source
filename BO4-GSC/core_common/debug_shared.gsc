/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\debug_shared.gsc
***********************************************/

#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace debug;

autoexec __init__system__() {
  system::register(#"debug", &__init__, undefined, undefined);
}

__init__() {
  level thread debug_draw_tuning_sphere();
  level thread devgui_debug_key_value();
}

devgui_debug_key_value() {
  a_keys = array("<dev string:x38>", "<dev string:x41>", "<dev string:x4c>", "<dev string:x58>", "<dev string:x6c>", "<dev string:x79>", "<dev string:x89>", "<dev string:x96>", "<dev string:x9f>");
  setdvar(#"debug_key_value", 0);
  setdvar(#"debug_key_value_dist", 2000);
  adddebugcommand("<dev string:xa6>");
  adddebugcommand("<dev string:xf8>");

  foreach(str_key in a_keys) {
    adddebugcommand("<dev string:x144>" + str_key + "<dev string:x176>" + str_key + "<dev string:x190>");
  }

  while(!flag::exists("<dev string:x195>")) {
    util::wait_network_frame();
  }

  level flag::wait_till("<dev string:x195>");

  while(true) {
    debug_key_value = getdvar(#"debug_key_value", 0);

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

debug_draw_tuning_sphere() {
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

debug_key_value(str_key, n_time, n_scale) {
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
      __s util::delay_notify(n_time, "<dev string:x1ac>");
    }

    while(true) {
      value = self.(str_key);

      if(isDefined(value)) {
        print3d(self.origin, isDefined(value) ? "<dev string:x1b6>" + value : "<dev string:x1b6>", (0, 0, 1), 1, n_scale, 1);
      }

      waitframe(1);
    }
  }
}

drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    waitframe(1);
  }
}

drawdebugenttoentinternal(ent1, ent2, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    if(!isDefined(ent1) || !isDefined(ent2)) {
      return;
    }

    line(ent1.origin, ent2.origin, color);
    waitframe(1);
  }
}

drawdebugline(frompoint, topoint, color, durationframes) {
  thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
}

drawdebuglineenttoent(ent1, ent2, color, durationframes) {
  thread drawdebugenttoentinternal(ent1, ent2, color, durationframes);
}

