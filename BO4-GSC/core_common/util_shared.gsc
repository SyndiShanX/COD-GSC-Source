/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\util_shared.gsc
***********************************************/

#include script_51e19a6cd0b4d30f;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\weapons_shared;

#namespace util;

autoexec __init__system__() {
  system::register(#"util_shared", &__init__, &__main__, undefined);
}

__init__() {
  level.var_9fee970c = function_60d95f53();
  function_73fab74d();
  function_f9ce1d49();
  register_clientfields();
  namespace_1e38a8f6::init();
}

__main__() {
  system::wait_till("all");
  function_3cb7a62d();
}

register_clientfields() {
  clientfield::register("world", "cf_team_mapping", 1, 1, "int");
  clientfield::register("world", "preload_frontend", 1, 1, "int");
  clientfield::register("allplayers", "ClearStreamerLoadingHints", 1, 1, "int");
  clientfield::register("allplayers", "StreamerSetSpawnHintIndex", 1, 4, "int");
}

error(msg) {
  println("<dev string:x38>", msg);

  if(!sessionmodeismultiplayergame() && !sessionmodeiswarzonegame()) {
    waitframe(1);
  }

  if(getdvar(#"debug", 0)) {
    assertmsg("<dev string:x45>");
  }
}

warning(msg) {
  println("<dev string:x74>" + msg);
}

empty(a, b, c, d, e) {}

wait_network_frame(n_count = 1) {
  if(numremoteclients()) {
    for(i = 0; i < n_count; i++) {
      snapshot_ids = getsnapshotindexarray();
      acked = undefined;

      for(n_tries = 0; !isDefined(acked) && n_tries < 5; n_tries++) {
        level waittill(#"snapacknowledged");
        acked = snapshotacknowledged(snapshot_ids);
      }
    }

    return;
  }

  wait 0.1 * n_count;
}

preload_frontend() {
  level clientfield::set("preload_frontend", 1);
  wait_network_frame();
  level clientfield::set("preload_frontend", 0);
}

clear_streamer_hint() {
  if(isDefined(self.streamer_hint)) {
    self.streamer_hint delete();
    self.streamer_hint = undefined;
  }

  self notify(#"wait_clear_streamer_hint");
}

wait_clear_streamer_hint(lifetime) {
  self endon(#"wait_clear_streamer_hint");
  wait lifetime;

  if(isDefined(self)) {
    self clear_streamer_hint();
  }
}

create_streamer_hint(origin, angles, value, lifetime) {
  if(self == level) {
    foreach(player in getplayers()) {
      player clear_streamer_hint();
    }
  }

  self clear_streamer_hint();
  self.streamer_hint = createstreamerhint(origin, value);

  if(isDefined(angles)) {
    self.streamer_hint.angles = angles;
  }

  if(self != level) {
    self.streamer_hint setinvisibletoall();
    self.streamer_hint setvisibletoplayer(self);
  }

  self.streamer_hint setincludemeshes(1);
  self notify(#"wait_clear_streamer_hint");

  if(isDefined(lifetime) && lifetime > 0) {
    self thread wait_clear_streamer_hint(lifetime);
  }
}

streamer_wait(n_stream_request_id, n_wait_frames = 0, n_timeout = 15, str_team, str_scenedef) {
  if(getdvarint(#"cg_drawfps", 1) != 0) {
    n_timeout = 1;
  }

  if(n_wait_frames > 0) {
    wait_network_frame(n_wait_frames);
  }

  timeout = gettime() + int(n_timeout * 1000);

  if(self == level) {
    n_num_streamers_ready = 0;

    do {
      wait_network_frame();
      n_num_streamers_ready = 0;

      if(isDefined(str_team)) {
        a_players = get_players(str_team);
      } else {
        a_players = getplayers();
      }

      foreach(player in a_players) {
        if(isDefined(str_scenedef) && isarray(player.var_16672042) && isDefined(player.var_16672042[str_scenedef])) {
          var_5a2f2554 = player.var_16672042[str_scenedef];
        } else {
          var_5a2f2554 = isDefined(n_stream_request_id) ? n_stream_request_id : player.var_ecd30af1;
        }

        if(isDefined(var_5a2f2554) ? player isstreamerready(var_5a2f2554) : player isstreamerready()) {
          n_num_streamers_ready++;
        }
      }

      if(n_timeout > 0 && gettime() > timeout) {
        if(n_timeout > 5) {
          iprintln("<dev string:x82>");
          debug2dtext((50, 50, 0), "<dev string:xd9>", (1, 0, 0), 1, (0, 0, 0), 0, 2, 40);
        }

        break;
      }
    }
    while(n_num_streamers_ready < max(1, a_players.size));

    return;
  }

  self endon(#"disconnect");
  var_5a2f2554 = isDefined(n_stream_request_id) ? n_stream_request_id : self.var_ecd30af1;

  do {
    wait_network_frame();

    if(n_timeout > 0 && gettime() > timeout) {
      break;
    }
  }
  while(!(isDefined(var_5a2f2554) ? self isstreamerready(var_5a2f2554) : self isstreamerready()));
}

draw_debug_line(start, end, timer) {
  for(i = 0; i < timer * 20; i++) {
    line(start, end, (1, 1, 0.5));
    waitframe(1);
  }
}

debug_line(start, end, color, alpha, depthtest, duration) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 100;
  }

  line(start, end, color, alpha, depthtest, duration);
}

debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration) {
  if(!isDefined(slices)) {
    slices = 10;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  if(!isDefined(duration)) {
    duration = 100;
  }

  sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
}

debug_sphere(origin, radius, color, alpha, time) {
  if(!isDefined(time)) {
    time = 1000;
  }

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  sides = int(10 * (1 + int(radius) % 100));
  sphere(origin, radius, color, alpha, 1, sides, time);
}

plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];

  if(!isDefined(r)) {
    r = 1;
  }

  if(!isDefined(g)) {
    g = 1;
  }

  if(!isDefined(b)) {
    b = 1;
  }

  if(!isDefined(timer)) {
    timer = 0.05;
  }

  for(i = 1; i < plotpoints.size; i++) {
    thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
    lastpoint = plotpoints[i];
  }
}

draw_arrow_time(start, end, color, timer) {
  level endon(#"newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  up = anglestoup(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = start + vectorscale(right, dist * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[2] = end;
  arrow[3] = start + vectorscale(right, dist * -1 * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[4] = start;
  arrow[5] = start + vectorscale(up, dist * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[6] = end;
  arrow[7] = start + vectorscale(up, dist * -1 * 0.1) + vectorscale(forward, dist * -0.1);
  arrow[8] = start;
  r = color[0];
  g = color[1];
  b = color[2];
  plot_points(arrow, r, g, b, timer);
}

draw_arrow(start, end, color) {
  level endon(#"newpath");
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);
  dist = distance(start, end);
  arrow = [];
  arrow[0] = start;
  arrow[1] = start + vectorscale(right, dist * 0.05) + vectorscale(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vectorscale(right, dist * -1 * 0.05) + vectorscale(forward, dist * -0.2);

  for(p = 0; p < 4; p++) {
    nextpoint = p + 1;

    if(nextpoint >= 4) {
      nextpoint = 0;
    }

    line(arrow[p], arrow[nextpoint], color, 1);
  }
}

debugorigin() {
  self notify(#"debug origin");
  self endon(#"debug origin", #"death");

  for(;;) {
    forward = anglesToForward(self.angles);
    forwardfar = vectorscale(forward, 30);
    forwardclose = vectorscale(forward, 20);
    right = anglestoright(self.angles);
    left = vectorscale(right, -10);
    right = vectorscale(right, 10);
    line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + right, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + left, (0.9, 0.7, 0.6), 0.9);
    waitframe(1);
  }
}

draw_line_for_time(org1, org2, r, g, b, timer) {
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, org2, (r, g, b), 1);
    recordline(org1, org2, (1, 1, 1), "<dev string:xec>");
    waitframe(1);
  }
}

function_6844bea4(radius1, radius2, time, color, origin, normal) {
  if(!isDefined(color)) {
    color = (0, 1, 0);
  }

  circleres = 6;
  circleinc = 360 / circleres;
  circleres++;
  plotpoints = [];
  rad = 0;
  radius = radius2;
  angletoplayer = vectortoangles(normal);

  for(i = 0; i < circleres; i++) {
    plotpoints[plotpoints.size] = origin + vectorscale(anglesToForward(angletoplayer + (rad, 90, 0)), radius);
    rad += circleinc;
  }

  plot_points(plotpoints, color[0], color[1], color[2], time);
}

track(spot_to_track) {
  if(isDefined(self.current_target)) {
    if(spot_to_track == self.current_target) {
      return;
    }
  }

  self.current_target = spot_to_track;
}

waittill_string(msg, ent) {
  if(msg != "death") {
    self endon(#"death");
  }

  ent endon(#"die");
  self waittill(msg);
  ent notify(#"returned", {
    #msg: msg
  });
}

waittill_level_string(msg, ent, otherent) {
  otherent endon(#"death");
  ent endon(#"die");
  level waittill(msg);
  ent notify(#"returned", {
    #msg: msg
  });
}

waittill_multiple(...) {
  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;

  for(i = 0; i < vararg.size; i++) {
    self thread _waitlogic(s_tracker, vararg[i]);
  }

  if(s_tracker._wait_count > 0) {
    s_tracker waittill(#"waitlogic_finished");
  }
}

waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}

break_glass(n_radius = 50) {
  n_radius = float(n_radius);

  if(n_radius == -1) {
    v_origin_offset = (0, 0, 0);
    n_radius = 100;
  } else {
    v_origin_offset = (0, 0, 40);
  }

  glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

waittill_multiple_ents(...) {
  a_ents = [];
  a_notifies = [];

  for(i = 0; i < vararg.size; i++) {
    if(i % 2) {
      if(!isDefined(a_notifies)) {
        a_notifies = [];
      } else if(!isarray(a_notifies)) {
        a_notifies = array(a_notifies);
      }

      a_notifies[a_notifies.size] = vararg[i];
      continue;
    }

    if(!isDefined(a_ents)) {
      a_ents = [];
    } else if(!isarray(a_ents)) {
      a_ents = array(a_ents);
    }

    a_ents[a_ents.size] = vararg[i];
  }

  s_tracker = spawnStruct();
  s_tracker._wait_count = 0;

  for(i = 0; i < a_ents.size; i++) {
    ent = a_ents[i];

    if(isDefined(ent)) {
      ent thread _waitlogic(s_tracker, a_notifies[i]);
    }
  }

  if(s_tracker._wait_count > 0) {
    s_tracker waittill(#"waitlogic_finished");
  }
}

_waitlogic(s_tracker, notifies) {
  s_tracker._wait_count++;

  if(!isDefined(notifies)) {
    notifies = [];
  } else if(!isarray(notifies)) {
    notifies = array(notifies);
  }

  notifies[notifies.size] = "death";
  self waittill(notifies);
  s_tracker._wait_count--;

  if(s_tracker._wait_count == 0) {
    s_tracker notify(#"waitlogic_finished");
  }
}

waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5) {
  otherent endon(#"death");
  ent = spawnStruct();

  if(isDefined(string1)) {
    level thread waittill_level_string(string1, ent, otherent);
  }

  if(isDefined(string2)) {
    level thread waittill_level_string(string2, ent, otherent);
  }

  if(isDefined(string3)) {
    level thread waittill_level_string(string3, ent, otherent);
  }

  if(isDefined(string4)) {
    level thread waittill_level_string(string4, ent, otherent);
  }

  if(isDefined(string5)) {
    level thread waittill_level_string(string5, ent, otherent);
  }

  if(isDefined(otherent)) {
    otherent thread waittill_string("death", ent);
  }

  ent thread _timeout(n_timeout);
  waitresult = ent waittill(#"returned");
  ent notify(#"die");
  return waitresult.msg;
}

_timeout(delay) {
  self endon(#"die");
  wait delay;
  self notify(#"returned", {
    #msg: "timeout"
  });
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }

  if(isDefined(ent3) && isDefined(string3)) {
    ent3 endon(string3);
  }

  if(isDefined(ent4) && isDefined(string4)) {
    ent4 endon(string4);
  }

  if(isDefined(ent5) && isDefined(string5)) {
    ent5 endon(string5);
  }

  if(isDefined(ent6) && isDefined(string6)) {
    ent6 endon(string6);
  }

  if(isDefined(ent7) && isDefined(string7)) {
    ent7 endon(string7);
  }

  ent1 waittill(string1);
}

waittill_any_ents_two(ent1, string1, ent2, string2) {
  assert(isDefined(ent1));
  assert(isDefined(string1));

  if(isDefined(ent2) && isDefined(string2)) {
    ent2 endon(string2);
  }

  ent1 waittill(string1);
}

isflashed() {
  if(!isDefined(self.flashendtime)) {
    return false;
  }

  return gettime() < self.flashendtime;
}

isstunned() {
  if(!isDefined(self.flashendtime)) {
    return false;
  }

  return gettime() < self.flashendtime;
}

single_func(entity, func, ...) {
  return _single_func(entity, func, vararg);
}

single_func_argarray(entity, func, a_vars) {
  return _single_func(entity, func, a_vars);
}

_single_func(entity, func, a_vars) {
  _clean_up_arg_array(a_vars);

  switch (a_vars.size) {
    case 8:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
      }

      break;
    case 7:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
      }

      break;
    case 6:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
      }

      break;
    case 5:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
      }

      break;
    case 4:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
      }

      break;
    case 3:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1], a_vars[2]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1], a_vars[2]);
      }

      break;
    case 2:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0], a_vars[1]);
      } else {
        return [
          [func]
        ](a_vars[0], a_vars[1]);
      }

      break;
    case 1:
      if(isDefined(entity)) {
        return entity[[func]](a_vars[0]);
      } else {
        return [
          [func]
        ](a_vars[0]);
      }

      break;
    case 0:
      if(isDefined(entity)) {
        return entity[[func]]();
      } else {
        return [
          [func]
        ]();
      }

      break;
    default:
      assertmsg("<dev string:xf5>");
      break;
  }
}

_clean_up_arg_array(&a_vars) {
  for(i = a_vars.size - 1; i >= 0; i--) {
    if(a_vars[i] === undefined) {
      arrayremoveindex(a_vars, i, 0);
      continue;
    }

    break;
  }
}

new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
  s_func = spawnStruct();
  s_func.func = func;
  s_func.arg1 = arg1;
  s_func.arg2 = arg2;
  s_func.arg3 = arg3;
  s_func.arg4 = arg4;
  s_func.arg5 = arg5;
  s_func.arg6 = arg6;
  return s_func;
}

call_func(s_func) {
  return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

single_thread(entity, func, ...) {
  _single_thread(entity, func, undefined, undefined, vararg);
}

single_thread_argarray(entity, func, &a_vars) {
  _single_thread(entity, func, undefined, undefined, a_vars);
}

function_50f54b6f(entity, func, arg1, &a_vars) {
  _single_thread(entity, func, arg1, undefined, a_vars);
}

function_cf55c866(entity, func, arg1, arg2, &a_vars) {
  _single_thread(entity, func, arg1, arg2, a_vars);
}

_single_thread(entity, func, arg1, arg2, &a_vars) {
  _clean_up_arg_array(a_vars);
  assert(isfunctionptr(func), "<dev string:x106>" + "<dev string:x11d>");

  if(!isfunctionptr(func)) {
    return;
  }

  if(isDefined(arg2)) {
    switch (a_vars.size) {
      case 8:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        break;
      case 7:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        break;
      case 6:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        break;
      case 5:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        break;
      case 4:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        break;
      case 3:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1], a_vars[2]);
        break;
      case 2:
        entity thread[[func]](arg1, arg2, a_vars[0], a_vars[1]);
        break;
      case 1:
        entity thread[[func]](arg1, arg2, a_vars[0]);
        break;
      case 0:
        entity thread[[func]](arg1, arg2);
        break;
      default:
        assertmsg("<dev string:xf5>");
        break;
    }

    return;
  }

  if(isDefined(arg1)) {
    switch (a_vars.size) {
      case 8:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
        break;
      case 7:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
        break;
      case 6:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
        break;
      case 5:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
        break;
      case 4:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
        break;
      case 3:
        entity thread[[func]](arg1, a_vars[0], a_vars[1], a_vars[2]);
        break;
      case 2:
        entity thread[[func]](arg1, a_vars[0], a_vars[1]);
        break;
      case 1:
        entity thread[[func]](arg1, a_vars[0]);
        break;
      case 0:
        entity thread[[func]](arg1);
        break;
      default:
        assertmsg("<dev string:xf5>");
        break;
    }

    return;
  }

  switch (a_vars.size) {
    case 8:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
      break;
    case 7:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
      break;
    case 6:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
      break;
    case 5:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
      break;
    case 4:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
      break;
    case 3:
      entity thread[[func]](a_vars[0], a_vars[1], a_vars[2]);
      break;
    case 2:
      entity thread[[func]](a_vars[0], a_vars[1]);
      break;
    case 1:
      entity thread[[func]](a_vars[0]);
      break;
    case 0:
      entity thread[[func]]();
      break;
    default:
      assertmsg("<dev string:xf5>");
      break;
  }
}

script_delay() {
  n_time = gettime();
  self.var_653e059d = 1;

  if(isDefined(self.script_delay)) {
    wait self.script_delay;
  }

  n_min_delay = isDefined(self.script_delay_min) ? self.script_delay_min : 0;
  n_max_delay = isDefined(self.script_delay_max) ? self.script_delay_max : 0;

  if(n_max_delay > n_min_delay) {
    wait randomfloatrange(n_min_delay, n_max_delay);
  } else if(n_min_delay > 0) {
    wait n_min_delay;
  }

  self.var_653e059d = undefined;
  return gettime() - n_time;
}

timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  if(isDefined(n_time)) {
    __s = spawnStruct();
    __s endon(#"timeout");
    __s delay_notify(n_time, "timeout");
  }

  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

create_flags_and_return_tokens(flags) {
  tokens = strtok(flags, " ");

  for(i = 0; i < tokens.size; i++) {
    level trigger::function_ac2f203a(tokens[i]);
  }

  return tokens;
}

function_aebdb74f(str_flags) {
  a_str_flags = strtok(str_flags, " ");

  foreach(str_flag in a_str_flags) {
    level flag::set(str_flag);
  }
}

fileprint_start(file) {
  filename = file;
  file = openfile(filename, "<dev string:x139>");
  level.fileprint = file;
  level.fileprintlinecount = 0;
  level.fileprint_filename = filename;
}

fileprint_map_start(file) {
  file = "<dev string:x141>" + file + "<dev string:x14f>";
  fileprint_start(file);
  level.fileprint_mapentcount = 0;
  fileprint_map_header(1);
}

fileprint_chk(file, str) {
  level.fileprintlinecount++;

  if(level.fileprintlinecount > 400) {
    waitframe(1);
    level.fileprintlinecount++;
    level.fileprintlinecount = 0;
  }

  fprintln(file, str);
}

fileprint_map_header(binclude_blank_worldspawn = 0) {
  assert(isDefined(level.fileprint));

  fileprint_chk(level.fileprint, "<dev string:x156>");
  fileprint_chk(level.fileprint, "<dev string:x160>");
  fileprint_chk(level.fileprint, "<dev string:x17d>");

  if(!binclude_blank_worldspawn) {
    return;
  }

  fileprint_map_entity_start();
  fileprint_map_keypairprint("<dev string:x18f>", "<dev string:x19b>");
  fileprint_map_entity_end();
}

fileprint_map_keypairprint(key1, key2) {
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "<dev string:x1a8>" + key1 + "<dev string:x1ac>" + key2 + "<dev string:x1a8>");
}

fileprint_map_entity_start() {
  assert(!isDefined(level.fileprint_entitystart));
  level.fileprint_entitystart = 1;
  assert(isDefined(level.fileprint));
  fileprint_chk(level.fileprint, "<dev string:x1b2>" + level.fileprint_mapentcount);
  fileprint_chk(level.fileprint, "<dev string:x1bf>");
  level.fileprint_mapentcount++;
}

fileprint_map_entity_end() {
  assert(isDefined(level.fileprint_entitystart));
  assert(isDefined(level.fileprint));
  level.fileprint_entitystart = undefined;
  fileprint_chk(level.fileprint, "<dev string:x1c3>");
}

fileprint_end() {
  assert(!isDefined(level.fileprint_entitystart));
  saved = closefile(level.fileprint);

  if(saved != 1) {
    println("<dev string:x1c7>");
    println("<dev string:x1ed>");
    println("<dev string:x1f1>");
    println("<dev string:x206>" + level.fileprint_filename);
    println("<dev string:x219>");
    println("<dev string:x252>");
    println("<dev string:x290>");
    println("<dev string:x2ce>");
    println("<dev string:x316>");
    println("<dev string:x1ed>");
    println("<dev string:x332>");
    println("<dev string:x377>");
    println("<dev string:x3bd>");
    println("<dev string:x3fb>");
    println("<dev string:x441>");
    println("<dev string:x480>");
    println("<dev string:x4c1>");
    println("<dev string:x1ed>");
    println("<dev string:x1c7>");
    println("<dev string:x506>");
  }

  level.fileprint = undefined;
  level.fileprint_filename = undefined;
}

fileprint_radiant_vec(vector) {
  string = "<dev string:x534>" + vector[0] + "<dev string:x1ed>" + vector[1] + "<dev string:x1ed>" + vector[2] + "<dev string:x534>";
  return string;
}

death_notify_wrapper(attacker, damagetype) {
  level notify(#"face", {
    #face_notify: "death", 
    #entity: self
  });
  self notify(#"death", {
    #attacker: attacker, 
    #mod: damagetype
  });
}

damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
  level notify(#"face", {
    #face_notify: "damage", 
    #entity: self
  });
  self notify(#"damage", {
    #amount: damage, 
    #attacker: attacker, 
    #direction: direction_vec, 
    #position: point, 
    #mod: type, 
    #model_name: modelname, 
    #tag_name: tagname, 
    #part_name: partname, 
    #flags: idflags
  });
}

explode_notify_wrapper() {
  level notify(#"face", {
    #face_notify: "explode", 
    #entity: self
  });
  self notify(#"explode");
}

alert_notify_wrapper() {
  level notify(#"face", {
    #face_notify: "alert", 
    #entity: self
  });
  self notify(#"alert");
}

shoot_notify_wrapper() {
  level notify(#"face", {
    #face_notify: "shoot", 
    #entity: self
  });
  self notify(#"shoot");
}

melee_notify_wrapper() {
  level notify(#"face", {
    #face_notify: "melee", 
    #entity: self
  });
  self notify(#"melee");
}

isusabilityenabled() {
  return !self.disabledusability;
}

_disableusability() {
  self.disabledusability++;
  self disableusability();
}

_enableusability() {
  self.disabledusability--;
  assert(self.disabledusability >= 0);

  if(!self.disabledusability) {
    self enableusability();
  }
}

resetusability() {
  self.disabledusability = 0;
  self enableusability();
}

orient_to_normal(normal) {
  hor_normal = (normal[0], normal[1], 0);
  hor_length = length(hor_normal);

  if(!hor_length) {
    return (0, 0, 0);
  }

  hor_dir = vectornormalize(hor_normal);
  neg_height = normal[2] * -1;
  tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
  plant_angle = vectortoangles(tangent);
  return plant_angle;
}

delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

_delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon(#"death");

  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  if(ishash(time_or_notify) || isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait time_or_notify;
  }

  single_thread(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

_delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
  self endon(#"death");

  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  wait_network_frame(n_frames);
  single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

delay_notify(time_or_notify, str_notify, str_endon, arg1) {
  self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1);
}

_delay_notify(time_or_notify, str_notify, str_endon, arg1) {
  self endon(#"death");

  if(isDefined(str_endon)) {
    self endon(str_endon);
  }

  if(ishash(time_or_notify) || isstring(time_or_notify)) {
    self waittill(time_or_notify);
  } else {
    wait time_or_notify;
  }

  self notify(str_notify, arg1);
}

get_closest_player(org, team) {
  team = get_team_mapping(team);
  players = getplayers(team);
  return arraysort(players, org, 1, 1)[0];
}

registerclientsys(ssysname) {
  if(!isDefined(level._clientsys)) {
    level._clientsys = [];
  }

  if(level._clientsys.size >= 32) {
    assertmsg("<dev string:x537>");
    return;
  }

  if(isDefined(level._clientsys[ssysname])) {
    assertmsg("<dev string:x55a>" + ssysname);
    return;
  }

  level._clientsys[ssysname] = spawnStruct();
  level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

setclientsysstate(ssysname, ssysstate, player) {
  if(!isDefined(level._clientsys)) {
    assertmsg("<dev string:x584>");
    return;
  }

  if(!isDefined(level._clientsys[ssysname])) {
    assertmsg("<dev string:x5c3>" + ssysname);
    return;
  }

  if(isDefined(player)) {
    player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    return;
  }

  clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
  level._clientsys[ssysname].sysstate = ssysstate;
}

getclientsysstate(ssysname) {
  if(!isDefined(level._clientsys)) {
    assertmsg("<dev string:x5f6>");
    return "";
  }

  if(!isDefined(level._clientsys[ssysname])) {
    assertmsg("<dev string:x638>" + ssysname + "<dev string:x649>");
    return "";
  }

  if(isDefined(level._clientsys[ssysname].sysstate)) {
    return level._clientsys[ssysname].sysstate;
  }

  return "";
}

clientnotify(event) {
  if(level.clientscripts) {
    if(isplayer(self)) {
      setclientsysstate("levelNotify", event, self);
      return;
    }

    setclientsysstate("levelNotify", event);
  }
}

coopgame() {
  return sessionmodeissystemlink() || sessionmodeisonlinegame() || issplitscreen();
}

is_looking_at(ent_or_org, n_dot_range = 0.9, do_trace = 0, v_offset) {
  assert(isDefined(ent_or_org), "<dev string:x678>");
  v_point = isvec(ent_or_org) ? ent_or_org : ent_or_org.origin;

  if(isvec(v_offset)) {
    v_point += v_offset;
  }

  b_can_see = 0;
  b_use_tag_eye = 0;

  if(isplayer(self) || isai(self)) {
    b_use_tag_eye = 1;
  }

  n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);

  if(n_dot > n_dot_range) {
    if(do_trace) {
      v_eye = self get_eye();
      b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
    } else {
      b_can_see = 1;
    }
  }

  return b_can_see;
}

get_eye() {
  if(isplayer(self)) {
    return self getplayercamerapos();
  }

  return self getEye();
}

is_ads() {
  return self playerads() > 0.5;
}

spawn_model(model_name, origin = (0, 0, 0), angles = (0, 0, 0), n_spawnflags = 0, b_throttle = 0) {
  while(true) {
    if(b_throttle) {
      spawner::global_spawn_throttle(4);
    }

    model = spawn("script_model", origin, n_spawnflags);

    if(isDefined(model)) {
      break;
    } else {
      println("<dev string:x6b2>" + "<dev string:x6c6>" + model_name + "<dev string:x6e1>" + origin + "<dev string:x6ef>" + angles);
    }

    waitframe(1);
  }

  model setModel(model_name);
  model.angles = angles;
  return model;
}

spawn_anim_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
  model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
  model useanimtree("generic");
  model.animtree = "generic";
  return model;
}

spawn_anim_player_model(model_name, origin, angles, n_spawnflags = 0, b_throttle) {
  model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
  model useanimtree("all_player");
  model.animtree = "all_player";
  return model;
}

waittill_player_looking_at(origin, arc_angle_degrees = 90, do_trace, e_ignore) {
  self endon(#"death");
  arc_angle_degrees = absangleclamp360(arc_angle_degrees);
  dot = cos(arc_angle_degrees * 0.5);

  while(!is_player_looking_at(origin, dot, do_trace, e_ignore)) {
    waitframe(1);
  }
}

waittill_player_not_looking_at(origin, dot, do_trace) {
  self endon(#"death");

  while(is_player_looking_at(origin, dot, do_trace)) {
    waitframe(1);
  }
}

is_player_looking_at(v_origin, n_dot = 0.7, b_do_trace = 1, e_ignore) {
  assert(isplayer(self), "<dev string:x6fc>");

  if(isDefined(self.hijacked_vehicle_entity)) {
    v_eye = self.hijacked_vehicle_entity gettagorigin("tag_driver");
    v_view = anglesToForward(self.hijacked_vehicle_entity gettagangles("tag_driver"));
  } else {
    v_eye = self get_eye();
    v_view = anglesToForward(self getplayerangles());
  }

  v_delta = vectornormalize(v_origin - v_eye);
  n_new_dot = vectordot(v_delta, v_view);

  if(n_new_dot >= n_dot) {
    if(b_do_trace) {
      return bullettracepassed(v_origin, v_eye, 0, e_ignore);
    } else {
      return 1;
    }
  }

  return 0;
}

wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
  self endon(endonstring);

  if(isDefined(endonstring2)) {
    self endon(endonstring2);
  }

  if(isDefined(endonstring3)) {
    self endon(endonstring3);
  }

  if(isDefined(endonstring4)) {
    self endon(endonstring4);
  }

  wait waittime;
  return true;
}

waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3) {
  if(isDefined(endcondition1)) {
    self endon(endcondition1);
  }

  if(isDefined(endcondition2)) {
    self endon(endcondition2);
  }

  if(isDefined(endcondition3)) {
    self endon(endcondition3);
  }

  self waittill(waitcondition);

  if(isDefined(callback)) {
    [[callback]](waitcondition);
  }
}

new_timer(n_timer_length) {
  s_timer = spawnStruct();
  s_timer.n_time_created = gettime();
  s_timer.n_length = n_timer_length;
  return s_timer;
}

get_time() {
  t_now = gettime();
  return t_now - self.n_time_created;
}

get_time_in_seconds() {
  return float(get_time()) / 1000;
}

get_time_frac(n_end_time = self.n_length) {
  return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

get_time_left() {
  if(isDefined(self.n_length)) {
    n_current_time = get_time_in_seconds();
    return max(self.n_length - n_current_time, 0);
  }

  return -1;
}

is_time_left() {
  return get_time_left() != 0;
}

timer_wait(n_wait) {
  if(isDefined(self.n_length)) {
    n_wait = min(n_wait, get_time_left());
  }

  wait n_wait;
  n_current_time = get_time_in_seconds();
  return n_current_time;
}

is_primary_damage(meansofdeath) {
  if(meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
    return true;
  }

  return false;
}

delete_on_death(ent) {
  ent endon(#"death");
  self waittill(#"death");

  if(isDefined(ent)) {
    ent delete();
  }
}

delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield = undefined) {
  e_to_delete endon(#"death");
  self waittill_either("death", str_notify);

  if(isDefined(e_to_delete)) {
    if(isDefined(str_clientfield)) {
      e_to_delete clientfield::set(str_clientfield, 0);
      wait 0.1;
    }

    e_to_delete delete();
  }
}

wait_till_not_touching(e_to_check, e_to_touch) {
  assert(isDefined(e_to_check), "<dev string:x72c>");
  assert(isDefined(e_to_touch), "<dev string:x76c>");
  e_to_check endon(#"death");
  e_to_touch endon(#"death");

  while(e_to_check istouching(e_to_touch)) {
    waitframe(1);
  }
}

any_player_is_touching(ent, team) {
  team = get_team_mapping(team);

  foreach(player in getplayers(team)) {
    if(isalive(player) && player istouching(ent)) {
      return true;
    }
  }

  return false;
}

set_console_status() {
  if(!isDefined(level.console)) {
    level.console = getdvarstring(#"consolegame") == "true";
  } else {
    assert(level.console == getdvarstring(#"consolegame") == "<dev string:x7ac>", "<dev string:x7b3>");
  }

  if(!isDefined(level.consolexenon)) {
    level.xenon = getdvarstring(#"xenongame") == "true";
    return;
  }

  assert(level.xenon == getdvarstring(#"xenongame") == "<dev string:x7ac>", "<dev string:x7d8>");
}

waittill_asset_loaded(str_type, str_name) {}

script_wait() {
  n_time = gettime();

  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }
  }

  n_min = isDefined(self.script_wait_min) ? self.script_wait_min : 0;
  n_max = isDefined(self.script_wait_max) ? self.script_wait_max : 0;

  if(n_max > n_min) {
    wait randomfloatrange(n_min, n_max);
    self.script_wait_min += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
    self.script_wait_max += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
  } else if(n_min > 0) {
    wait n_min;
    self.script_wait_min += isDefined(self.script_wait_add) ? self.script_wait_add : 0;
  }

  return gettime() - n_time;
}

is_killstreaks_enabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}

is_flashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

magic_bullet_shield(ent = self) {
  ent val::set(#"magic_bullet_shield", "allowdeath", 0);
  ent.magic_bullet_shield = 1;

  ent notify(#"_stop_magic_bullet_shield_debug");
  level thread debug_magic_bullet_shield_death(ent);

  assert(isalive(ent), "<dev string:x7fb>");

  if(isai(ent)) {
    if(isactor(ent)) {
      ent bloodimpact("hero");
    }

    ent.attackeraccuracy = 0.1;
  }
}

debug_magic_bullet_shield_death(guy) {
  targetname = "none";

  if(isDefined(guy.targetname)) {
    targetname = guy.targetname;
  }

  guy endon(#"stop_magic_bullet_shield", #"_stop_magic_bullet_shield_debug");
  guy waittill(#"death");
  assert(!isDefined(guy), "<dev string:x839>" + targetname);
}

spawn_player_clone(player, animname, s_align, var_df23b31f = 0) {
  playerclone = spawn("script_model", player.origin);
  playerclone.angles = player.angles;

  if(player function_390cb543()) {
    var_1749f1e8 = player function_92ea4100();

    if(isDefined(var_1749f1e8)) {
      playerclone setModel(var_1749f1e8);
    }

    headmodel = player startquantity();

    if(isDefined(headmodel)) {
      playerclone attach(headmodel);
    }
  } else {
    var_41206ae3 = player function_5d23af5b();

    if(isDefined(var_41206ae3)) {
      playerclone setModel(var_41206ae3);
    }

    headmodel = player startquantity();

    if(isDefined(headmodel)) {
      playerclone attach(headmodel);
    }

    var_b4d88433 = player function_cde23658();

    if(isDefined(var_b4d88433)) {
      playerclone attach(var_b4d88433);
    }

    var_1749f1e8 = player function_92ea4100();

    if(isDefined(var_1749f1e8)) {
      playerclone attach(var_1749f1e8);
    }
  }

  playerclone setbodyrenderoptionspacked(player getcharacterbodyrenderoptions());

  if(var_df23b31f) {
    playerclone animation::attach_weapon(player getcurrentweapon());
  }

  playerclone useanimtree("all_player");

  if(isDefined(animname)) {
    if(isDefined(s_align)) {
      playerclone thread animation::play(animname, s_align);
    } else {
      playerclone thread animation::play(animname, playerclone.origin, playerclone.angles);
    }
  }

  playerclone.health = 100;
  playerclone setowner(player);
  playerclone.team = player.team;
  playerclone solid();
  return playerclone;
}

stop_magic_bullet_shield(ent = self) {
  ent val::reset(#"magic_bullet_shield", "allowdeath");
  ent.magic_bullet_shield = undefined;

  if(isai(ent)) {
    if(isactor(ent)) {
      ent bloodimpact("normal");
    }

    ent.attackeraccuracy = 1;
  }

  ent notify(#"stop_magic_bullet_shield");
}

get_rounds_won(team) {
  team = get_team_mapping(team);
  return game.stat[#"roundswon"][team];
}

within_fov(start_origin, start_angles, end_origin, fov) {
  normal = vectornormalize(end_origin - start_origin);
  forward = anglesToForward(start_angles);
  dot = vectordot(forward, normal);
  return dot >= fov;
}

button_held_think(which_button) {
  self endon(#"disconnect");

  if(!isDefined(self._holding_button)) {
    self._holding_button = [];
  }

  self._holding_button[which_button] = 0;
  time_started = 0;

  while(true) {
    usinggamepad = self gamepadusedlast();
    use_time = ispc() && !usinggamepad ? 0 : 250;

    if(self._holding_button[which_button]) {
      if(!self[[level._button_funcs[which_button]]]()) {
        self._holding_button[which_button] = 0;
      }
    } else if(self[[level._button_funcs[which_button]]]()) {
      if(time_started == 0) {
        time_started = gettime();
      }

      if(gettime() - time_started > use_time) {
        self._holding_button[which_button] = 1;
      }
    } else if(time_started != 0) {
      time_started = 0;
    }

    waitframe(1);
  }
}

use_button_held() {
  init_button_wrappers();

  if(!isDefined(self._use_button_think_threaded)) {
    self thread button_held_think(0);
    self._use_button_think_threaded = 1;
  }

  return self._holding_button[0];
}

stance_button_held() {
  init_button_wrappers();

  if(!isDefined(self._stance_button_think_threaded)) {
    self thread button_held_think(1);
    self._stance_button_think_threaded = 1;
  }

  return self._holding_button[1];
}

ads_button_held() {
  init_button_wrappers();

  if(!isDefined(self._ads_button_think_threaded)) {
    self thread button_held_think(2);
    self._ads_button_think_threaded = 1;
  }

  return self._holding_button[2];
}

attack_button_held() {
  init_button_wrappers();

  if(!isDefined(self._attack_button_think_threaded)) {
    self thread button_held_think(3);
    self._attack_button_think_threaded = 1;
  }

  return self._holding_button[3];
}

button_right_held() {
  init_button_wrappers();

  if(!isDefined(self._dpad_right_button_think_threaded)) {
    self thread button_held_think(6);
    self._dpad_right_button_think_threaded = 1;
  }

  return self._holding_button[6];
}

waittill_use_button_pressed() {
  while(!self usebuttonpressed()) {
    waitframe(1);
  }
}

waittill_use_button_held() {
  while(!self use_button_held()) {
    waitframe(1);
  }
}

waittill_stance_button_pressed() {
  while(!self stancebuttonpressed()) {
    waitframe(1);
  }
}

waittill_stance_button_held() {
  while(!self stance_button_held()) {
    waitframe(1);
  }
}

waittill_attack_button_pressed() {
  while(!self attackbuttonpressed()) {
    waitframe(1);
  }
}

waittill_ads_button_pressed() {
  while(!self adsbuttonpressed()) {
    waitframe(1);
  }
}

waittill_vehicle_move_up_button_pressed() {
  while(!self vehiclemoveupbuttonpressed()) {
    waitframe(1);
  }
}

init_button_wrappers() {
  if(!isDefined(level._button_funcs)) {
    level._button_funcs[0] = &usebuttonpressed;
    level._button_funcs[2] = &adsbuttonpressed;
    level._button_funcs[3] = &attackbuttonpressed;
    level._button_funcs[1] = &stancebuttonpressed;
    level._button_funcs[6] = &actionslotfourbuttonpressed;

    level._button_funcs[4] = &up_button_pressed;
    level._button_funcs[5] = &down_button_pressed;

  }
}

up_button_held() {
  init_button_wrappers();

  if(!isDefined(self._up_button_think_threaded)) {
    self thread button_held_think(4);
    self._up_button_think_threaded = 1;
  }

  return self._holding_button[4];
}

down_button_held() {
  init_button_wrappers();

  if(!isDefined(self._down_button_think_threaded)) {
    self thread button_held_think(5);
    self._down_button_think_threaded = 1;
  }

  return self._holding_button[5];
}

up_button_pressed() {
  return self buttonpressed("<dev string:x872>") || self buttonpressed("<dev string:x87c>");
}

waittill_up_button_pressed() {
  while(!self up_button_pressed()) {
    waitframe(1);
  }
}

down_button_pressed() {
  return self buttonpressed("<dev string:x886>") || self buttonpressed("<dev string:x892>");
}

waittill_down_button_pressed() {
  while(!self down_button_pressed()) {
    waitframe(1);
  }
}

ishacked() {
  return isDefined(self.hacked) && self.hacked || isDefined(self.ishacked) && self.ishacked;
}

function_fbce7263(team_a, team_b) {
  if(team_a === team_b || function_9b7092ef(team_a, team_b)) {
    return false;
  }

  if(!isDefined(team_a) || !isDefined(team_b)) {
    return true;
  }

  if(function_b37afded(team_a, team_b)) {
    return false;
  }

  return true;
}

isenemyteam(team) {
  assert(isDefined(team));

  if(!isDefined(self)) {
    return false;
  }

  return function_fbce7263(team, self.team);
}

isfriendlyplayer(player) {
  if(!isplayer(player) || !isDefined(self)) {
    return false;
  }

  if(level.teambased) {
    return !isenemyteam(player.team);
  } else if(player == self) {
    return true;
  }

  return true;
}

isenemyplayer(player) {
  if(!isplayer(player) || !isDefined(self)) {
    return false;
  }

  if(level.teambased) {
    return isenemyteam(player.team);
  } else if(player == self) {
    return false;
  }

  return true;
}

waittillslowprocessallowed() {
  while(level.lastslowprocessframe == gettime()) {
    waitframe(1);
  }

  level.lastslowprocessframe = gettime();
}

function_1ea0b2ce() {
  level.lastslowprocessframe = gettime();
}

get_start_time() {
  return getmicrosecondsraw();
}

note_elapsed_time(start_time, label = "unspecified") {
  elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());

  if(!isDefined(start_time)) {
    return;
  }

  elapsed_time *= 0.001;

  if(!level.orbis) {
    elapsed_time = int(elapsed_time);
  }

  msg = label + "<dev string:x89e>" + elapsed_time + "<dev string:x8b0>";
  profileprintln(msg);
  iprintln(msg);
}

record_elapsed_time(start_time, &elapsed_time_array) {
  elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());

  if(!isDefined(elapsed_time_array)) {
    elapsed_time_array = [];
  } else if(!isarray(elapsed_time_array)) {
    elapsed_time_array = array(elapsed_time_array);
  }

  elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

note_elapsed_times(&elapsed_time_array, label = "unspecified") {
  if(!isarray(elapsed_time_array)) {
    return;
  }

  msg = label + "<dev string:x8b6>" + elapsed_time_array.size;
  profileprintln(msg);

  if(elapsed_time_array.size == 0) {
    return;
  }

  total_elapsed_time = 0;
  smallest_elapsed_time = 2147483647;
  largest_elapsed_time = 0;

  foreach(elapsed_time in elapsed_time_array) {
    elapsed_time *= 0.001;
    total_elapsed_time += elapsed_time;

    if(elapsed_time < smallest_elapsed_time) {
      smallest_elapsed_time = elapsed_time;
    }

    if(elapsed_time > largest_elapsed_time) {
      largest_elapsed_time = elapsed_time;
    }

    if(!level.orbis) {
      elapsed_time = int(elapsed_time);
    }

    msg = label + "<dev string:x89e>" + elapsed_time + "<dev string:x8b0>";
    profileprintln(msg);
  }

  average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
  msg = label + "<dev string:x8c3>" + average_elapsed_time + "<dev string:x8b0>";
  profileprintln(msg);
  iprintln(msg);
  msg = label + "<dev string:x8dd>" + largest_elapsed_time + "<dev string:x8b0>";
  profileprintln(msg);
  msg = label + "<dev string:x8f7>" + smallest_elapsed_time + "<dev string:x8b0>";
  profileprintln(msg);
}

get_elapsed_time(start_time, end_time = getmicrosecondsraw()) {
  if(!isDefined(start_time)) {
    return undefined;
  }

  elapsed_time = end_time - start_time;

  if(elapsed_time < 0) {
    elapsed_time += -2147483648;
  }

  return elapsed_time;
}

note_raw_time(label = "unspecified") {
  now = getmicrosecondsraw();
  msg = "us = " + now + " -- " + label;
  profileprintln(msg);
}

mayapplyscreeneffect() {
  assert(isDefined(self));
  assert(isplayer(self));
  return !isDefined(self.viewlockedentity);
}

waittillnotmoving() {
  if(self ishacked()) {
    waitframe(1);
    return;
  }

  if(self.classname == "grenade") {
    self waittill(#"stationary");
    return;
  }

  for(prevorigin = self.origin; true; prevorigin = self.origin) {
    wait 0.15;

    if(self.origin == prevorigin) {
      break;
    }
  }
}

waittillrollingornotmoving() {
  if(self ishacked()) {
    waitframe(1);
    return "stationary";
  }

  movestate = self waittill(#"stationary", #"rolling");
  return movestate._notify;
}

getweaponclass(weapon) {
  if(weapon == level.weaponnone) {
    return undefined;
  }

  if(!weapon.isvalid) {
    return undefined;
  }

  if(!isDefined(level.weaponclassarray)) {
    level.weaponclassarray = [];
  }

  if(isDefined(level.weaponclassarray[weapon.name])) {
    return level.weaponclassarray[weapon.name];
  }

  baseweaponparam = weapons::getbaseweapon(weapon);
  baseweaponindex = getbaseweaponitemindex(baseweaponparam);
  weaponclass = #"";
  weaponinfo = getunlockableiteminfofromindex(baseweaponindex, 1);

  if(isDefined(weaponinfo)) {
    weaponclass = weaponinfo.itemgroupname;
  }

  level.weaponclassarray[weapon.name] = weaponclass;
  return weaponclass;
}

function_56353fe9(weaponname) {
  weapon = getweapon(weaponname);

  if(!isDefined(weapon) || weapon == level.weaponnone) {
    return undefined;
  }

  return weapon;
}

isusingremote() {
  return isDefined(self.usingremote);
}

function_63d27d4e(remotename) {
  return self.usingremote === remotename;
}

setusingremote(remotename, set_killstreak_delay_killcam = !sessionmodeiszombiesgame()) {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 0;
  }

  assert(!self isusingremote());
  self.usingremote = remotename;

  if(set_killstreak_delay_killcam) {
    self.killstreak_delay_killcam = remotename;
  }

  self disableoffhandweapons();
  self notify(#"using_remote");
}

function_9a39538a() {
  if(isDefined(self.carryicon)) {
    self.carryicon.alpha = 1;
  }

  self.usingremote = undefined;
  self enableoffhandweapons();
  self.killstreak_delay_killcam = undefined;
  self notify(#"stopped_using_remote");
}

deleteaftertime(time) {
  assert(isDefined(self));
  assert(isDefined(time));
  assert(time >= 0.05);
  self thread deleteaftertimethread(time);
}

deleteaftertimethread(time) {
  self endon(#"death");
  wait time;
  self delete();
}

waitfortime(time = 0) {
  if(time > 0) {
    wait time;
  }
}

waitfortimeandnetworkframe(time = 0) {
  start_time_ms = gettime();
  wait_network_frame();
  elapsed_time = (gettime() - start_time_ms) * 0.001;
  remaining_time = time - elapsed_time;

  if(remaining_time > 0) {
    wait remaining_time;
  }
}

deleteaftertimeandnetworkframe(time) {
  assert(isDefined(self));
  waitfortimeandnetworkframe(time);
  self delete();
}

drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
  if(!isDefined(duration)) {
    duration = 0;
  }

  level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
}

drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha) {
  if(isDefined(stop_notify)) {
    level endon(stop_notify);
  }

  stop_time = gettime() + int(seconds * 1000);
  currad = rad;
  curheight = height;

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  for(;;) {
    if(seconds > 0 && stop_time <= gettime()) {
      return;
    }

    for(r = 0; r < 20; r++) {
      theta = r / 20 * 360;
      theta2 = (r + 1) / 20 * 360;
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
      line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
      line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
    }

    waitframe(1);
  }
}

spawn_array_struct() {
  s = spawnStruct();
  s.a = [];
  return s;
}

gethostplayer() {
  players = getplayers();

  foreach(player in players) {
    if(player ishost()) {
      return player;
    }
  }
}

gethostplayerforbots() {
  players = getplayers();

  for(index = 0; index < players.size; index++) {
    if(players[index] ishostforbots()) {
      return players[index];
    }
  }
}

get_array_of_closest(org, array, excluders = [], max = array.size, maxdist) {
  maxdists2rd = undefined;

  if(isDefined(maxdist)) {
    maxdists2rd = maxdist * maxdist;
  }

  dist = [];
  index = [];

  for(i = 0; i < array.size; i++) {
    if(!isDefined(array[i])) {
      continue;
    }

    if(isinarray(excluders, array[i])) {
      continue;
    }

    if(isvec(array[i])) {
      length = distancesquared(org, array[i]);
    } else {
      length = distancesquared(org, array[i].origin);
    }

    if(isDefined(maxdists2rd) && maxdists2rd < length) {
      continue;
    }

    dist[dist.size] = length;
    index[index.size] = i;
  }

  for(;;) {
    change = 0;

    for(i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1]) {
        continue;
      }

      change = 1;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }

    if(!change) {
      break;
    }
  }

  newarray = [];

  if(max > dist.size) {
    max = dist.size;
  }

  for(i = 0; i < max; i++) {
    newarray[i] = array[index[i]];
  }

  return newarray;
}

set_lighting_state(n_state) {
  if(isDefined(n_state)) {
    self.lighting_state = n_state;
  } else {
    self.lighting_state = level.lighting_state;
  }

  if(isDefined(self.lighting_state)) {
    if(self == level) {
      if(isDefined(level.activeplayers)) {
        foreach(player in level.activeplayers) {
          player set_lighting_state(level.lighting_state);
        }
      }

      return;
    }

    if(isplayer(self)) {
      self setlightingstate(self.lighting_state);
      return;
    }

    assertmsg("<dev string:x912>");
  }
}

set_sun_shadow_split_distance(f_distance) {
  if(isDefined(f_distance)) {
    self.sun_shadow_split_distance = f_distance;
  } else {
    self.sun_shadow_split_distance = level.sun_shadow_split_distance;
  }

  if(isDefined(self.sun_shadow_split_distance)) {
    if(self == level) {
      if(isDefined(level.activeplayers)) {
        foreach(player in level.activeplayers) {
          player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
        }
      }

      return;
    }

    if(isplayer(self)) {
      self setsunshadowsplitdistance(self.sun_shadow_split_distance);
      return;
    }

    assertmsg("<dev string:x946>");
  }
}

function_7f49ffb7(var_bf01552a) {
  if(!isDefined(level.var_bf01552a)) {
    level.var_bf01552a = -1;
  }

  if(isDefined(var_bf01552a)) {
    self.var_bf01552a = var_bf01552a;
  } else {
    self.var_bf01552a = level.var_bf01552a;
  }

  if(isDefined(self.var_bf01552a)) {
    if(self == level) {
      if(isDefined(level.activeplayers)) {
        foreach(player in level.activeplayers) {
          player function_7f49ffb7(level.var_bf01552a);
        }
      }

      return;
    }

    if(isplayer(self)) {
      self function_61471b4a(self.var_bf01552a);
      return;
    }

    assertmsg("<dev string:x985>");
  }
}

auto_delete(n_mode = 1, n_min_time_alive = 0, n_dist_horizontal = 0, n_dist_vertical = 0) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death", #"hash_375a9d48dd6a9427");
  self notify(#"__auto_delete__");
  self endon(#"__auto_delete__");
  level flag::wait_till("all_players_spawned");

  if(isDefined(level.heroes) && isinarray(level.heroes, self)) {
    return;
  }

  if(isplayer(self)) {
    return;
  }

  if(n_mode&16 || n_mode == 1 || n_mode == 8) {
    n_mode |= 2;
    n_mode |= 4;
  }

  n_think_time = 1;
  n_tests_to_do = 2;
  n_dot_check = 0;

  if(n_mode&16) {
    n_think_time = 0.2;
    n_tests_to_do = 1;
    n_dot_check = 0.4;
  }

  n_test_count = 0;
  n_dist_horizontal_sq = n_dist_horizontal * n_dist_horizontal;

  while(true) {
    do {
      wait randomfloatrange(n_think_time - n_think_time / 3, n_think_time + n_think_time / 3);
    }
    while(isDefined(self.birthtime) && float(gettime() - self.birthtime) / 1000 < n_min_time_alive);

    n_tests_passed = 0;

    foreach(player in level.players) {
      if(isbot(player)) {
        n_tests_passed++;
        continue;
      }

      if(n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal_sq) {
        continue;
      }

      if(n_dist_vertical && abs(self.origin[2] - player.origin[2]) < n_dist_vertical) {
        continue;
      }

      v_eye = player getplayercamerapos();
      b_behind = 0;

      if(n_mode&2) {
        v_facing = anglesToForward(player getplayerangles());
        v_to_ent = vectornormalize(self.origin - v_eye);
        n_dot = vectordot(v_facing, v_to_ent);

        if(n_dot < n_dot_check) {
          b_behind = 1;

          if(!(n_mode&1)) {
            n_tests_passed++;
            continue;
          }
        }
      }

      if(n_mode&4) {
        if(!self sightconetrace(v_eye, isDefined(player getvehicleoccupied()) ? player getvehicleoccupied() : player)) {
          if(b_behind || !(n_mode&1)) {
            n_tests_passed++;
          }
        }
      }
    }

    if(n_tests_passed == level.players.size) {
      n_test_count++;

      if(n_test_count < n_tests_to_do) {
        continue;
      }

      self notify(#"_disable_reinforcement");
      self delete();
      continue;
    }

    n_test_count = 0;
  }
}

query_ents(&a_kvps_match, b_match_all = 1, &a_kvps_ingnore, b_ignore_spawners = 0, b_match_substrings = 0) {
  a_ret = [];

  if(b_match_substrings) {
    a_all_ents = arraycombine(getEntArray(), level.struct, 0, 0);
    b_first = 1;

    foreach(v in a_kvps_match) {
      a_ents = _query_ents_by_substring_helper(a_all_ents, v.value, v.key, b_ignore_spawners);

      if(b_first) {
        a_ret = a_ents;
        b_first = 0;
        continue;
      }

      if(b_match_all) {
        a_ret = arrayintersect(a_ret, a_ents);
        continue;
      }

      a_ret = arraycombine(a_ret, a_ents, 0, 0);
    }

    if(isDefined(a_kvps_ingnore)) {
      foreach(k, v in a_kvps_ingnore) {
        a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
        a_ret = array::exclude(a_ret, a_ents);
      }
    }
  } else {
    b_first = 1;

    foreach(v in a_kvps_match) {
      a_ents = arraycombine(getEntArray(v.value, v.key, b_ignore_spawners), struct::get_array(v.value, v.key), 0, 0);

      if(b_first) {
        a_ret = a_ents;
        b_first = 0;
        continue;
      }

      if(b_match_all) {
        a_ret = arrayintersect(a_ret, a_ents);
        continue;
      }

      a_ret = arraycombine(a_ret, a_ents, 0, 0);
    }

    if(isDefined(a_kvps_ingnore)) {
      foreach(k, v in a_kvps_ingnore) {
        a_ents = arraycombine(getEntArray(v, k, b_ignore_spawners), struct::get_array(v, k), 0, 0);
        a_ret = array::exclude(a_ret, a_ents);
      }
    }
  }

  return a_ret;
}

_query_ents_by_substring_helper(&a_ents, str_value, str_key = "targetname", b_ignore_spawners = 0) {
  a_ret = [];

  foreach(ent in a_ents) {
    if(b_ignore_spawners && isspawner(ent)) {
      continue;
    }

    if(isstring(ent.(str_key)) && issubstr(ent.(str_key), str_value)) {
      if(!isDefined(a_ret)) {
        a_ret = [];
      } else if(!isarray(a_ret)) {
        a_ret = array(a_ret);
      }

      a_ret[a_ret.size] = ent;
    }
  }

  return a_ret;
}

get_weapon_by_name(weapon_name, var_2f3a032e) {
  split = [];

  if("" != var_2f3a032e) {
    split = strtok(var_2f3a032e, "+");
  }

  if(split.size) {
    weapon = getweapon(weapon_name, split);
  } else {
    weapon = getweapon(weapon_name);
  }

  return weapon;
}

function_2146bd83(weapon) {
  var_2f3a032e = "";

  for(i = 0; i < weapon.attachments.size; i++) {
    if(!i) {
      var_2f3a032e += "+";
    }

    var_2f3a032e += weapon.attachments[i];
  }

  return var_2f3a032e;
}

function_4c1656d5() {
  if(sessionmodeiswarzonegame()) {
    return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
  }

  return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

function_16fb0a3b() {
  if(sessionmodeiswarzonegame()) {
    if(getdvarint(#"hash_23a1d3a9139af42b", 0) > 0) {
      return getdvarfloat(#"hash_608e7bb0e9517884", 250);
    } else {
      return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
    }

    return;
  }

  if(getdvarint(#"hash_23fac9a913e70c03", 0) > 0) {
    return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
  }

  return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

is_female() {
  gender = self getplayergendertype(currentsessionmode());
  b_female = 0;

  if(isDefined(gender) && gender == "female") {
    b_female = 1;
  }

  return b_female;
}

positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent) {
  if(isDefined(reachableby_ent)) {
    queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
  } else {
    queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
  }

  pointarray = [];

  foreach(pointstruct in queryresult.data) {
    if(!isDefined(pointarray)) {
      pointarray = [];
    } else if(!isarray(pointarray)) {
      pointarray = array(pointarray);
    }

    pointarray[pointarray.size] = pointstruct.origin;
  }

  return pointarray;
}

totalplayercount() {
  count = 0;

  foreach(team, _ in level.teams) {
    count += level.playercount[team];
  }

  return count;
}

isrankenabled() {
  return isDefined(level.rankenabled) && level.rankenabled;
}

isoneround() {
  if(level.roundlimit == 1) {
    return true;
  }

  return false;
}

isfirstround() {
  if(game.roundsplayed == 0) {
    return true;
  }

  return false;
}

islastround() {
  if(level.roundlimit > 1 && game.roundsplayed >= level.roundlimit - 1) {
    return true;
  }

  return false;
}

waslastround() {
  if(level.forcedend) {
    return true;
  }

  if(isDefined(level.nextroundisovertime)) {
    if(level.nextroundisovertime) {
      level.nextroundisovertime = 1;
      return false;
    } else if(isDefined(game.overtime_round) && game.overtime_round > 0) {
      return true;
    }
  }

  if(hitroundlimit() || hitscorelimit() || hitroundwinlimit()) {
    return true;
  }

  return false;
}

hitroundlimit() {
  if(level.roundlimit <= 0) {
    return false;
  }

  return getroundsplayed() >= level.roundlimit;
}

anyteamhitroundwinlimit() {
  foreach(team, _ in level.teams) {
    if(getroundswon(team) >= level.roundwinlimit) {
      return true;
    }
  }

  return false;
}

anyteamhitroundlimitwithdraws() {
  tie_wins = game.stat[#"roundswon"][#"tie"];

  foreach(team, _ in level.teams) {
    if(getroundswon(team) + tie_wins >= level.roundwinlimit) {
      return true;
    }
  }

  return false;
}

function_385658da() {
  count = 0;

  foreach(team, _ in level.teams) {
    wins = getroundswon(team);

    if(!isDefined(count)) {
      count = wins;
      continue;
    }

    if(wins != count) {
      return false;
    }
  }

  return true;
}

hitroundwinlimit() {
  if(!isDefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
    return false;
  }

  if(anyteamhitroundwinlimit()) {
    return true;
  }

  if(anyteamhitroundlimitwithdraws()) {
    if(!function_385658da()) {
      return true;
    }
  }

  return false;
}

any_team_hit_score_limit() {
  foreach(team, _ in level.teams) {
    if(game.stat[#"teamscores"][team] >= level.scorelimit) {
      return true;
    }
  }

  return false;
}

hitscorelimit() {
  if(level.scoreroundwinbased) {
    return false;
  }

  if(level.scorelimit <= 0) {
    return false;
  }

  if(level.teambased) {
    if(any_team_hit_score_limit()) {
      return true;
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(isDefined(player.pointstowin) && player.pointstowin >= level.scorelimit) {
        return true;
      }
    }
  }

  return false;
}

get_current_round_score_limit() {
  return level.roundscorelimit * (game.roundsplayed + 1);
}

any_team_hit_round_score_limit() {
  round_score_limit = get_current_round_score_limit();

  foreach(team, _ in level.teams) {
    if(game.stat[#"teamscores"][team] >= round_score_limit) {
      return true;
    }
  }

  return false;
}

hitroundscorelimit() {
  if(level.roundscorelimit <= 0) {
    return false;
  }

  if(level.teambased) {
    if(any_team_hit_round_score_limit()) {
      return true;
    }
  } else {
    roundscorelimit = get_current_round_score_limit();

    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];

      if(isDefined(player.pointstowin) && player.pointstowin >= roundscorelimit) {
        return true;
      }
    }
  }

  return false;
}

getroundswon(team) {
  team = get_team_mapping(team);
  return game.stat[#"roundswon"][team];
}

getotherteamsroundswon(str_skip_team) {
  str_skip_team = get_team_mapping(str_skip_team);
  roundswon = 0;

  if(!isDefined(str_skip_team)) {
    return roundswon;
  }

  foreach(team, _ in level.teams) {
    if(team === str_skip_team) {
      continue;
    }

    roundswon += game.stat[#"roundswon"][team];
  }

  return roundswon;
}

getroundsplayed() {
  return game.roundsplayed;
}

isroundbased() {
  if(level.roundlimit != 1 && level.roundwinlimit != 1) {
    return true;
  }

  return false;
}

getcurrentgamemode() {
  if(gamemodeismode(6)) {
    return "leaguematch";
  }

  return "publicmatch";
}

function_97cf7eb0(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
  v_trace_start = v_start + (0, 0, 5);
  v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
  a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);

  if(a_trace[#"surfacetype"] != "none") {
    return {
      #position: a_trace[#"position"] + (0, 0, n_ground_offset), 
      #entity: a_trace[#"entity"]
    };
  }

  return {
    #position: v_start, 
    #entity: a_trace[#"entity"]
  };
}

ground_position(v_start, n_max_dist = 5000, n_ground_offset = 0, e_ignore, b_ignore_water = 0, b_ignore_glass = 0) {
  return function_97cf7eb0(v_start, n_max_dist, n_ground_offset, e_ignore, b_ignore_water, b_ignore_glass).position;
}

delayed_notify(str_notify, f_delay_seconds) {
  wait f_delay_seconds;

  if(isDefined(self)) {
    self notify(str_notify);
  }
}

delayed_delete(f_delay_seconds) {
  assert(isentity(self));
  wait f_delay_seconds;

  if(isDefined(self) && isentity(self)) {
    self delete();
  }
}

is_safehouse() {
  mapname = get_map_name();
  return false;
}

is_new_cp_map() {
  mapname = get_map_name();

  switch (mapname) {
    default:
      return false;
  }
}

add_queued_debug_command(cmd) {
  if(!isDefined(level.dbg_cmd_queue)) {
    level thread queued_debug_commands();
  }

  if(isDefined(level.dbg_cmd_queue)) {
    array::push(level.dbg_cmd_queue, cmd);
  }
}

queued_debug_commands() {
  self notify(#"queued_debug_commands");
  self endon(#"queued_debug_commands");

  if(!isDefined(level.dbg_cmd_queue)) {
    level.dbg_cmd_queue = [];
  }

  while(true) {
    waitframe(1);

    if(!isDefined(game.state)) {
      continue;
    }

    if(game.state == "<dev string:x9be>") {
      continue;
    }

    if(level.dbg_cmd_queue.size == 0) {
      level.dbg_cmd_queue = undefined;
      return;
    }

    trickle = 0;

    if(level.players.size > 1) {
      trickle = 1;
    }

    for(var_1085858 = 12;
      (!trickle || var_1085858 > 0) && canadddebugcommand() && level.dbg_cmd_queue.size > 0; var_1085858--) {
      cmd = array::pop_front(level.dbg_cmd_queue, 0);
      adddebugcommand(cmd);

      if(trickle) {}
    }
  }
}

array_copy_if_array(any_var) {
  return isarray(any_var) ? arraycopy(any_var) : any_var;
}

is_item_purchased(ref) {
  itemindex = getitemindexfromref(ref);
  return itemindex < 0 || itemindex >= 256 ? 0 : self isitempurchased(itemindex);
}

has_purchased_perk_equipped(ref) {
  return self hasperk(ref) && self is_item_purchased(ref);
}

has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
  if(isplayer(self)) {
    return (self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref));
  }

  return 0;
}

has_flak_jacket_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_flakjacket");
}

has_blind_eye_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyairsupport", #"specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

has_ghost_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_gpsjammer");
}

has_tactical_mask_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_stunprotection", #"specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

has_hacker_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_showenemyequipment", #"specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

has_cold_blooded_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_nottargetedbyaitank", #"specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

has_hard_wired_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_immunecounteruav", #"specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

has_gung_ho_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_sprintfire", #"specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

has_fast_hands_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_fastweaponswitch", #"specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

has_scavenger_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_scavenger");
}

has_jetquiet_perk_purchased_and_equipped() {
  return self has_purchased_perk_equipped_with_specific_stat(#"specialty_jetquiet", #"specialty_jetnoradar|specialty_jetquiet");
}

has_awareness_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_loudenemies");
}

has_ninja_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_quieter");
}

has_toughness_perk_purchased_and_equipped() {
  return has_purchased_perk_equipped(#"specialty_bulletflinch");
}

str_strip_lh(str) {
  if(strendswith(str, "_lh")) {
    return getsubstr(str, 0, str.size - 3);
  }

  return str;
}

trackwallrunningdistance() {
  self endon(#"disconnect");
  self.movementtracking.wallrunning = spawnStruct();
  self.movementtracking.wallrunning.distance = 0;
  self.movementtracking.wallrunning.count = 0;
  self.movementtracking.wallrunning.time = 0;

  while(true) {
    self waittill(#"wallrun_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.wallrunning.count++;
    self waittill(#"wallrun_end");
    self.movementtracking.wallrunning.distance += distance(startpos, self.origin);
    self.movementtracking.wallrunning.time += gettime() - starttime;
  }
}

tracksprintdistance() {
  self endon(#"disconnect");
  self.movementtracking.sprinting = spawnStruct();
  self.movementtracking.sprinting.distance = 0;
  self.movementtracking.sprinting.count = 0;
  self.movementtracking.sprinting.time = 0;

  while(true) {
    self waittill(#"sprint_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.sprinting.count++;
    self waittill(#"sprint_end");
    self.movementtracking.sprinting.distance += distance(startpos, self.origin);
    self.movementtracking.sprinting.time += gettime() - starttime;
  }
}

trackdoublejumpdistance() {
  self endon(#"disconnect");
  self.movementtracking.doublejump = spawnStruct();
  self.movementtracking.doublejump.distance = 0;
  self.movementtracking.doublejump.count = 0;
  self.movementtracking.doublejump.time = 0;

  while(true) {
    self waittill(#"doublejump_begin");
    startpos = self.origin;
    starttime = gettime();
    self.movementtracking.doublejump.count++;
    self waittill(#"doublejump_end");
    self.movementtracking.doublejump.distance += distance(startpos, self.origin);
    self.movementtracking.doublejump.time += gettime() - starttime;
  }
}

getplayspacecenter() {
  minimaporigins = getEntArray("minimap_corner", "targetname");

  if(minimaporigins.size) {
    return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
  }

  return (0, 0, 0);
}

getplayspacemaxwidth() {
  minimaporigins = getEntArray("minimap_corner", "targetname");

  if(minimaporigins.size) {
    x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
    y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
    return max(x, y);
  }

  return 0;
}

getteammask(team) {
  team = get_team_mapping(team);

  if(!level.teambased || !isDefined(team) || !isDefined(level.spawnsystem.ispawn_teammask[team])) {
    return level.spawnsystem.ispawn_teammask_free;
  }

  return level.spawnsystem.ispawn_teammask[team];
}

getotherteam(team) {
  team = get_team_mapping(team);

  if(team == #"allies") {
    return #"axis";
  } else if(team == #"axis") {
    return #"allies";
  } else {
    return #"allies";
  }

  assertmsg("<dev string:x9c8>" + team);
}

getotherteamsmask(str_skip_team) {
  str_skip_team = get_team_mapping(str_skip_team);
  mask = 0;

  if(!isDefined(str_skip_team)) {
    return mask;
  }

  foreach(team, _ in level.teams) {
    if(team === str_skip_team) {
      continue;
    }

    mask |= getteammask(team);
  }

  return mask;
}

waittill_can_add_debug_command() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }
}

add_debug_command(cmd) {
  waittill_can_add_debug_command();
  adddebugcommand(cmd);
}

get_players(team = #"any") {
  arrayremovevalue(level.players, undefined, 0);

  if(team == #"any") {
    return arraycopy(level.players);
  }

  assert(isDefined(level.teams[team]), "<dev string:x9e6>" + function_9e72a96(team) + "<dev string:x9ea>");
  players = [];

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.team === team) {
      players[players.size] = player;
    }
  }

  return players;
}

get_active_players(team = #"any") {
  if(team != #"any") {
    assert(isDefined(level.teams[team]), "<dev string:x9e6>" + function_9e72a96(team) + "<dev string:x9ea>");
  }

  arrayremovevalue(level.activeplayers, undefined, 0);
  players = [];

  foreach(player in level.activeplayers) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(team) || team == #"any" || player.team === team) {
      players[players.size] = player;
    }
  }

  return players;
}

function_81ccf6d3(team = #"any") {
  players = get_active_players();

  if(team == #"any") {
    return players;
  }

  assert(isDefined(level.teams[team]), "<dev string:x9e6>" + function_9e72a96(team) + "<dev string:x9ea>");
  enemies = [];

  foreach(player in players) {
    if(isDefined(player) && isDefined(player.team) && function_fbce7263(player.team, team)) {
      enemies[enemies.size] = player;
    }
  }

  return enemies;
}

get_human_players(team = #"any") {
  players = getplayers(team);
  humanplayers = [];

  foreach(player in players) {
    if(!isbot(player)) {
      humanplayers[humanplayers.size] = player;
    }
  }

  return humanplayers;
}

function_8e89351(player) {
  return isDefined(player) && !isbot(player) && isinarray(level.players, player);
}

get_bot_players(team = #"any") {
  players = get_players(team);
  botplayers = [];

  foreach(player in players) {
    if(isbot(player)) {
      botplayers[botplayers.size] = player;
    }
  }

  return botplayers;
}

is_game_solo(team = #"any") {
  humanplayers = get_human_players(team);
  return humanplayers.size == 1;
}

is_game_coop(team = #"any") {
  humanplayers = get_human_players(team);
  return humanplayers.size > 1;
}

function_cfa8b8df(team) {
  players = get_players(team);
  return players.size > 0;
}

function_cda17472(team) {
  players = get_human_players(team);
  return players.size > 0;
}

timesince(starttimeinmilliseconds) {
  return (gettime() - starttimeinmilliseconds) * 0.001;
}

cooldowninit() {
  if(!isDefined(self._cooldown)) {
    self._cooldown = [];
  }
}

cooldown(name, time_seconds) {
  cooldowninit();
  self._cooldown[name] = gettime() + int(time_seconds * 1000);
}

getcooldowntimeraw(name) {
  cooldowninit();

  if(!isDefined(self._cooldown[name])) {
    self._cooldown[name] = gettime() - 1;
  }

  return self._cooldown[name];
}

getcooldownleft(name) {
  cooldowninit();
  return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

iscooldownready(name, timeforward_seconds) {
  cooldowninit();

  if(!isDefined(timeforward_seconds)) {
    timeforward_seconds = 0;
  }

  cooldownreadytime = self._cooldown[name];
  return !isDefined(cooldownreadytime) || gettime() + int(timeforward_seconds * 1000) > cooldownreadytime;
}

clearcooldown(name) {
  cooldowninit();
  self._cooldown[name] = gettime() - 1;
}

addcooldowntime(name, time_seconds) {
  cooldowninit();
  self._cooldown[name] = getcooldowntimeraw(name) + int(time_seconds * 1000);
}

clearallcooldowns() {
  if(isDefined(self._cooldown)) {
    foreach(str_name, cooldown in self._cooldown) {
      self._cooldown[str_name] = gettime() - 1;
    }
  }
}

private function_4627b63d(alias) {
  assert(isDefined(level.team_mapping_alias));
  assert(isDefined(level.team_mapping_alias[alias]));
  return level.team_mapping_alias[alias];
}

private function_3cb7a62d() {
  assert(isDefined(level.team_mapping));

  if(get_team_mapping("sidea") == #"allies" && get_team_mapping("sideb") == #"axis") {
    level clientfield::set("cf_team_mapping", 1);
    return;
  }

  level clientfield::set("cf_team_mapping", 0);
}

function_73fab74d() {
  if(isDefined(level.var_1bbf77be)) {
    return;
  }

  level.var_1bbf77be = 1;
  function_9db3109f(#"allies", #"allies");
  function_9db3109f(#"axis", #"axis");
  function_9db3109f(#"allies", "wun");
  function_9db3109f(#"axis", "fpa");
  function_9db3109f(#"team3", "side3");
  function_d3e0802c("sidea", "sideb");
  function_d3e0802c("teama", "teamb");
  function_d3e0802c("attacker", "defender");
  function_d3e0802c("attackers", "defenders");
  function_d3e0802c("wun", "fpa");
  function_c16f65a3(#"allies", #"axis");
  function_c16f65a3(#"team3", #"any");
  set_team_mapping(#"allies", #"axis");
}

function_f9ce1d49() {
  if(isDefined(level.var_fdf974de)) {
    return;
  }

  level.var_fdf974de = array();
}

function_d7e70327(var_23866d2) {
  array::add(level.var_fdf974de, var_23866d2);
}

function_3d66774c(var_23866d2) {
  foreach(i, v in level.var_fdf974de) {
    if(array::function_460f3c24(v, var_23866d2)) {
      array::remove_index(i);
    }
  }
}

function_9b7092ef(team1, team2, team3, team4) {
  if(!isDefined(team1) || !isDefined(team2)) {
    return false;
  }

  foreach(var_ef54b214 in level.var_fdf974de) {
    if(array::contains(var_ef54b214, team1)) {
      if(array::contains(var_ef54b214, team2)) {
        if(!isDefined(team3) || array::contains(var_ef54b214, team3)) {
          if(!isDefined(team4) || array::contains(var_ef54b214, team4)) {
            return true;
          }
        }
      }
    }
  }

  return false;
}

set_team_mapping(var_b0dd114d, var_54495823) {
  var_b0dd114d = function_4627b63d(var_b0dd114d);
  var_54495823 = function_4627b63d(var_54495823);
  assert(var_b0dd114d != var_54495823, "<dev string:xa07>");
  level.team_mapping[0] = var_b0dd114d;
  level.team_mapping[1] = var_54495823;
  flagsys::set(#"team_mapping_set");
  game.attackers = var_b0dd114d;
  game.defenders = var_54495823;

  if(clientfield::can_set()) {
    function_3cb7a62d();
  }
}

function_d3e0802c(var_1dc5879e, var_128bf12b) {
  assert(var_1dc5879e != var_128bf12b, "<dev string:xa54>");
  level.var_af68e94e[var_1dc5879e] = 0;
  level.var_af68e94e[var_128bf12b] = 1;
}

function_c16f65a3(enemy_a, enemy_b) {
  assert(enemy_a != enemy_b, "<dev string:xa9e>");
  level.team_enemy_mapping[enemy_a] = enemy_b;
  level.team_enemy_mapping[enemy_b] = enemy_a;
}

function_9db3109f(team, alias) {
  assert(team == #"allies" || team == #"axis" || team == #"team3");
  level.team_mapping_alias[alias] = team;
}

get_team_mapping(team) {
  assert(isDefined(level.team_mapping));
  assert(isDefined(level.var_af68e94e));

  if(isDefined(team)) {
    if(isDefined(level.var_af68e94e[team])) {
      return level.team_mapping[level.var_af68e94e[team]];
    } else if(isDefined(level.team_mapping_alias[team])) {
      return level.team_mapping_alias[team];
    }
  }

  return team;
}

function_310d70e2(team) {
  assert(isDefined(level.team_mapping));
  assert(isDefined(level.var_af68e94e));

  if(isDefined(team)) {
    if(team === level.team_mapping[level.var_af68e94e[#"sidea"]]) {
      return "sidea";
    } else if(team === level.team_mapping[level.var_af68e94e[#"sideb"]]) {
      return "sideb";
    }
  }

  return team;
}

is_on_side(team) {
  return self getteam() === get_team_mapping(team);
}

get_enemy_team(team) {
  team = get_team_mapping(team);

  if(!isDefined(team)) {
    return undefined;
  }

  if(isDefined(level.team_enemy_mapping[team])) {
    return level.team_enemy_mapping[team];
  }

  return #"none";
}

get_game_type() {
  return tolower(getdvarstring(#"g_gametype"));
}

get_map_name() {
  return tolower(getdvarstring(#"sv_mapname"));
}

is_frontend_map() {
  return get_map_name() === "core_frontend";
}

add_devgui(menu_path, commands) {
  add_queued_debug_command("<dev string:xae1>" + menu_path + "<dev string:x1ac>" + commands + "<dev string:xaf0>");
}

remove_devgui(menu_path) {
  add_queued_debug_command("<dev string:xaf5>" + menu_path + "<dev string:xaf0>");
}

function_3f749abc(menu_path, commands) {
  add_debug_command("<dev string:xae1>" + menu_path + "<dev string:x1ac>" + commands + "<dev string:xaf0>");
}

function_85c62761(menu_path) {
  add_debug_command("<dev string:xaf5>" + menu_path + "<dev string:xaf0>");
}

gadget_is_in_use(slot) {
  if(isDefined(self._gadgets_player) && isDefined(self._gadgets_player[slot])) {
    if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type])) {
      if(isDefined(level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse)) {
        return self[[level._gadgets_level[self._gadgets_player[slot].gadget_type].isinuse]](slot);
      }
    }
  }

  return self gadgetisactive(slot);
}

function_72cbea07(player, weapon) {
  if(!isDefined(player.var_9c4683a0)) {
    return false;
  }

  foreach(var_e64f4a4a in player.var_9c4683a0) {
    if(var_e64f4a4a == weapon) {
      return true;
    }
  }

  return false;
}

ghost_wait_show(wait_time = 0.1) {
  self endon(#"death");
  self ghost();
  wait wait_time;
  self show();
}

ghost_wait_show_to_player(player, wait_time = 0.1, self_endon_string1) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self.abort_ghost_wait_show_to_player = undefined;

  if(isDefined(player)) {
    player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  }

  if(isDefined(self_endon_string1)) {
    self endon(self_endon_string1);
  }

  self ghost();
  self setinvisibletoall();
  self setvisibletoplayer(player);
  wait wait_time;

  if(!isDefined(self.abort_ghost_wait_show_to_player)) {
    self showtoplayer(player);
  }
}

ghost_wait_show_to_others(player, wait_time = 0.1, self_endon_string1) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self.abort_ghost_wait_show_to_others = undefined;

  if(isDefined(player)) {
    player endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  }

  if(isDefined(self_endon_string1)) {
    self endon(self_endon_string1);
  }

  self ghost();
  self setinvisibletoplayer(player);
  wait wait_time;

  if(!isDefined(self.abort_ghost_wait_show_to_others)) {
    self show();
    self setinvisibletoplayer(player);
  }
}

show_hit_marker(var_554cb812 = 0, var_1ed250ec = 0) {
  if(isplayer(self)) {
    if(isDefined(self) && isDefined(self.hud_damagefeedback)) {
      currenttime = gettime();

      if((isDefined(self.hud_damagefeedback.time) ? self.hud_damagefeedback.time : 0) != currenttime || !(isDefined(self.hud_damagefeedback.feedback_dead) && self.hud_damagefeedback.feedback_dead)) {
        if(var_554cb812) {
          self.hud_damagefeedback setshader(#"damage_feedback_glow_orange", 24, 48);
          self.hud_damagefeedback.feedback_dead = 1;
        } else {
          self.hud_damagefeedback setshader(#"damage_feedback", 24, 48);
          self.hud_damagefeedback.feedback_dead = 0;
        }

        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
        self.hud_damagefeedback.time = currenttime;
      }

      return;
    }

    if(isDefined(self) && !isDefined(self.hud_damagefeedback)) {
      self thread _show_hit_marker(var_554cb812, var_1ed250ec);
    }
  }
}

private _show_hit_marker(var_554cb812, var_1ed250ec) {
  self endon(#"death");

  if(!isDefined(self.var_9a94bf1)) {
    self.var_9a94bf1 = 0;
  }

  if(self.var_9a94bf1 < 5) {
    self.var_9a94bf1++;
    self playhitmarker(undefined, 5, undefined, var_554cb812, var_1ed250ec);
    wait_network_frame();
    self.var_9a94bf1--;
  }
}

function_5d36c37a(str_tag = "tag_aim_target") {
  if(!issentient(self) && !function_ffa5b184(self)) {
    if(isDefined(self gettagorigin(str_tag))) {
      self function_2baad8fc(str_tag);
      return;
    }

    self function_2baad8fc();
  }
}

make_sentient() {
  if(!issentient(self)) {
    self makesentient();
  }
}

function_f9af3d43(time) {
  self endon(#"death");
  wait time;
  self delete();
}

is_party_gamemode() {
  switch (level.gametype) {
    case #"sas":
    case #"oic":
    case #"shrp":
    case #"gun":
      return true;
  }

  return false;
}

get_gametype_name() {
  return level.gametype;
}

cleanup_fancycam() {
  self endon(#"disconnect");

  if(isplayer(self) && !isbot(self)) {
    wait_network_frame();
    self function_eb0dd56(0);
    wait_network_frame();
    self function_eb0dd56(0);
  }
}

set_dvar_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return value;
  }

  return getdvarstring(dvar);
}

set_dvar_float_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
  }

  return getdvarfloat(dvar, 0);
}

set_dvar_int_if_unset(dvar, value, reset = 0) {
  if(reset || getdvarstring(dvar) == "") {
    setdvar(dvar, value);
    return int(value);
  }

  return getdvarint(dvar, 0);
}

debug_slow_heli_speed() {
  if(getdvarint(#"scr_slow_heli", 0) > 0) {
    self setspeed(getdvarint(#"scr_slow_heli", 0));
  }
}

function_fb80e9ca() {
  n_timeout = 0;
  self flagsys::set(#"radiant_kvp_delay");

  if(isDefined(self.script_flag_timeout)) {
    n_timeout = self.script_flag_timeout;
  }

  flag::function_5f02becb(n_timeout);
  self script_delay();
  self flagsys::clear(#"radiant_kvp_delay");
}

function_74f2b2e9() {
  return isDefined(self.script_flag_true) || isDefined(self.script_flag_false) || isDefined(self.script_delay) && self.script_delay > 0 || isDefined(self.script_delay_min) && self.script_delay_min > 0 || isDefined(self.script_delay_max) && self.script_delay_max > 0;
}

function_d2dd4134(str_value, str_key) {
  a_targets = [];

  if(!isDefined(str_key)) {
    str_key = "targetname";
  }

  if(isDefined(str_value)) {
    var_c747e345 = strtok(str_value, " ");

    foreach(var_2fd77a2f in var_c747e345) {
      a_targets = arraycombine(a_targets, getEntArray(var_2fd77a2f, str_key), 0, 0);
      a_targets = arraycombine(a_targets, struct::get_array(var_2fd77a2f, str_key), 0, 0);
    }
  }

  return a_targets;
}

get_array(str_value, str_key = "targetname") {
  a_targets = function_d2dd4134(str_value, str_key);

  if(isDefined(str_value)) {
    var_c747e345 = strtok(str_value, " ");

    foreach(var_2fd77a2f in var_c747e345) {
      a_targets = arraycombine(a_targets, getvehiclenodearray(var_2fd77a2f, str_key), 0, 0);
      a_targets = arraycombine(a_targets, getnodearray(var_2fd77a2f, str_key), 0, 0);
    }
  }

  return a_targets;
}

function_a1281365(radius) {
  if(!isDefined(radius) || radius <= 0) {
    return 0;
  }

  return randomfloatrange(radius * -1, radius);
}

function_8eb53136(radius) {
  if(!isDefined(radius) || radius <= 0) {
    return 0;
  }

  return randomintrangeinclusive(radius * -1, radius);
}

is_spectating() {
  if(self.sessionstate == #"spectator") {
    return true;
  }

  return false;
}

function_8570168d() {
  if(getdvar(#"hash_49e94b7aefac4f49", 0)) {
    return true;
  }

  if(sessionmodeismultiplayergame()) {
    mode = function_bea73b01();

    if(mode == 4) {
      return true;
    }
  }

  return false;
}

function_88c74107(var_2cd16289 = "ufo", var_e7245730 = "noclip") {
  var_bf8813f9 = 0;

  if(self == level) {
    a_players = getplayers();
    var_bf8813f9 = 0;

    foreach(player in a_players) {
      if(player isinmovemode("ufo", "noclip")) {
        var_bf8813f9 = 1;
        break;
      }
    }
  } else if(self isinmovemode("ufo", "noclip")) {
    var_bf8813f9 = 1;
  }

  return var_bf8813f9;
}

function_22bf0a4a() {
  profilestart();
  player = self;

  if(level.var_e6f2a0c9 === 1) {
    profilestop();
    return;
  }

  if(getdvarstring(#"loot_special_contract_bundle", "") != "community_galil_achievement") {
    profilestop();
    return;
  }

  if(!gamemodeismode(0) && !gamemodeismode(6)) {
    profilestop();
    return;
  }

  if(level.var_903e2252 === 1) {
    profilestop();
    return;
  }

  if(!isDefined(player)) {
    profilestop();
    return;
  }

  if(!isplayer(player)) {
    profilestop();
    return;
  }

  player function_cce105c8(#"hash_243e425916855df3", 1, getdvarint(#"hash_4f52cc2f30dbbb9", 1));
  level.var_e6f2a0c9 = 1;
  profilestop();
}

#namespace namespace_2e6206f9;

register_callback(str_kvp, func, ...) {
  var_a12e87bd = hash(str_kvp);
  var_bcb861f = self.(str_kvp + "_target");

  if(isDefined(var_bcb861f)) {
    if(!isDefined(mission.var_232d57d8)) {
      mission.var_232d57d8 = [];
    }

    if(!isDefined(mission.var_232d57d8[var_a12e87bd])) {
      mission.var_232d57d8[var_a12e87bd] = [];
    }

    if(!isDefined(self.var_c18fbf49)) {
      self.var_c18fbf49 = [];
    }

    s_callback = {
      #func: func, 
      #params: vararg
    };
    self.var_c18fbf49[var_a12e87bd] = s_callback;
    var_c747e345 = strtok(var_bcb861f, " ");

    foreach(var_5afcf8a3 in var_c747e345) {
      if(!isDefined(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)])) {
        mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = [];
      } else if(!isarray(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)])) {
        mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)]);
      }

      mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)][mission.var_232d57d8[var_a12e87bd][hash(var_5afcf8a3)].size] = self;
    }

    self thread function_d608a743();
  }
}

register_custom_callback(str_name, str_kvp, func) {
  var_ce100229 = hash(str_name);
  var_bcb861f = self.(str_kvp + "_target");

  if(isDefined(var_bcb861f)) {
    if(!isDefined(mission.var_232d57d8)) {
      mission.var_232d57d8 = [];
    }

    if(!isDefined(mission.var_232d57d8[var_ce100229])) {
      mission.var_232d57d8[var_ce100229] = [];
    }

    if(!isDefined(self.var_c18fbf49)) {
      self.var_c18fbf49 = [];
    }

    s_callback = {
      #func: func
    };
    self.var_c18fbf49[var_ce100229] = s_callback;
    var_c747e345 = strtok(var_bcb861f, " ");

    foreach(var_5afcf8a3 in var_c747e345) {
      if(!isDefined(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)])) {
        mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = [];
      } else if(!isarray(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)])) {
        mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)] = array(mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)]);
      }

      mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)][mission.var_232d57d8[var_ce100229][hash(var_5afcf8a3)].size] = self;
    }

    self thread function_d608a743();
  }
}

function_d608a743() {
  self notify(#"hash_29bf696e43d4a08b");
  self endon(#"hash_29bf696e43d4a08b", #"death");
  a_str_notifies = getarraykeys(self.var_c18fbf49);

  while(true) {
    s_result = self waittill(a_str_notifies);
    s_callback = self.var_c18fbf49[hash(s_result._notify)];

    if(isDefined(s_callback.params)) {
      util::single_thread_argarray(self, s_callback.func, s_callback.params);
      continue;
    }

    if(isDefined(s_result.params)) {
      util::single_thread_argarray(self, s_callback.func, s_result.params);
      continue;
    }

    util::single_thread_argarray(self, s_callback.func);
  }
}

function_7ed1d198(str_kvp, str_name) {
  a_s_result = [];

  if(isDefined(mission.var_232d57d8)) {
    var_ce100229 = hash(isDefined(str_name) ? str_name : str_kvp);
    var_7ac3e82f = mission.var_232d57d8[var_ce100229];

    if(isDefined(var_7ac3e82f)) {
      var_bcb861f = self.(str_kvp + "_src");

      if(isDefined(var_bcb861f)) {
        var_c747e345 = strtok(var_bcb861f, " ");

        foreach(var_5afcf8a3 in var_c747e345) {
          var_85c1bb33 = var_7ac3e82f[hash(var_5afcf8a3)];

          if(isDefined(var_85c1bb33)) {
            foreach(var_8507e893 in var_85c1bb33) {
              if(!isDefined(a_s_result)) {
                a_s_result = [];
              } else if(!isarray(a_s_result)) {
                a_s_result = array(a_s_result);
              }

              a_s_result[a_s_result.size] = var_8507e893;
            }
          }
        }
      }
    }
  }

  return a_s_result;
}

callback(str_kvp) {
  var_e028d750 = function_7ed1d198(str_kvp);

  if(var_e028d750.size) {
    foreach(var_8507e893 in var_e028d750) {
      var_8507e893 notify(str_kvp);
    }
  }
}

custom_callback(str_name, str_kvp, ...) {
  var_e028d750 = function_7ed1d198(str_kvp, str_name);

  if(var_e028d750.size) {
    foreach(var_8507e893 in var_e028d750) {
      var_8507e893 notify(str_name, {
        #params: vararg
      });
    }
  }
}

function_4da758bf() {
  self.var_c18fbf49 = undefined;
  self notify(#"hash_29bf696e43d4a08b");
}

function_61e8e3c8(str_kvp) {
  return util::get_array(self.(str_kvp + "_target"), str_kvp + "_src");
}

get_target_structs(str_kvp) {
  return util::get_array(self.(str_kvp + "_src"), str_kvp + "_target");
}