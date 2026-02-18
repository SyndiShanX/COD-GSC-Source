/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ui\object_descriptions.gsc
************************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace object_descriptions;

function private autoexec __init__system__() {
  system::register(#"object_descriptions", &preload, undefined, undefined, undefined);
}

function preload() {
  level.object_descriptions = {};
  level.object_descriptions.ents = [];
  level.object_descriptions.triggers = [];
  level.object_descriptions.points = [];
  level.object_descriptions.objects = [];
  level.object_descriptions.trace_dist = 0;
  callback::on_spawned(&on_player_spawned);

  util::init_dvar("<dev string:x38>", 0, &function_5120dfdb);
}

function on_player_spawned() {
  var_7edfa20f = struct::get_array("obj_desc_rect", "variantname");
  circles = struct::get_array("obj_desc_circle", "variantname");

  foreach(index, rect in var_7edfa20f) {
    link_ent = undefined;

    if(isDefined(rect.target)) {
      link_ent = getent(rect.target, "targetname");
    }

    function_23e7a30a("rect" + index, rect.origin, rect.angles, rect.script_width, rect.script_height, hash(rect.script_string), rect.script_maxdist, link_ent);
  }

  foreach(index, circle in circles) {
    link_ent = undefined;

    if(isDefined(circle.target)) {
      link_ent = getent(circle.target, "targetname");
    }

    register_circle("circle" + index, circle.origin, circle.angles, circle.script_radius, hash(circle.script_string), circle.script_maxdist, link_ent);
  }
}

function register_ent(uid, ent, loc_string, max_dist = 500) {
  data = {};
  data.ent = ent;
  data.loc_string = loc_string;
  data.max_dist = max_dist;
  data.test_func = &function_73b1e949;
  data.var_f03d5bb1 = &function_136c1375;
  _register(uid, data);
  ent thread function_50676d1(uid);
}

function register_trigger(uid, trigger, loc_string, max_dist = 500, var_36247bfb, var_774d5d03 = 1) {
  data = {};
  data.trigger = trigger;
  data.loc_string = loc_string;
  data.var_36247bfb = var_36247bfb;
  data.max_dist = max_dist;
  data.test_func = &function_fc5ed81d;
  data.var_f03d5bb1 = &function_f56da461;
  data.var_774d5d03 = var_774d5d03;
  _register(uid, data);
}

function function_23e7a30a(uid, center, angles, width, height, loc_string, max_dist = 500, link_ent, var_36247bfb, var_774d5d03 = 1) {
  data = {};
  data.center = center;
  data.axis = anglestoaxis(angles);
  data.width = width / 2;
  data.height = height / 2;
  data.loc_string = loc_string;
  data.max_dist = max_dist;
  data.test_func = &function_f08e8278;
  data.var_f03d5bb1 = &function_3c2d7742;
  data.var_36247bfb = var_36247bfb;
  data.var_774d5d03 = var_774d5d03;

  data.var_ffc04e84 = &function_1ee1bf29;
  data.angles = angles;

  if(isDefined(link_ent)) {
    data.angles = angles;
    data.link_ent = link_ent;
    data.var_9a145184 = center - link_ent.origin;
    data.var_1321588e = angleclamp180(angles - link_ent.angles);
    data.link_ent thread function_50676d1(uid);
  }

  _register(uid, data);
}

function register_circle(uid, center, angles, radius, loc_string, max_dist = 500, link_ent, var_36247bfb, var_774d5d03 = 1) {
  data = {};
  data.center = center;
  data.axis = anglestoaxis(angles);
  data.radius = radius;
  data.loc_string = loc_string;
  data.max_dist = max_dist;
  data.test_func = &function_d0acce99;
  data.var_f03d5bb1 = &function_3c2d7742;
  data.var_36247bfb = var_36247bfb;
  data.var_774d5d03 = var_774d5d03;

  data.var_ffc04e84 = &_draw_circle;

  if(isDefined(link_ent)) {
    data.angles = angles;
    data.link_ent = link_ent;
    data.var_9a145184 = center - link_ent.origin;
    data.var_1321588e = angleclamp180(angles - link_ent.angles);
    data.link_ent thread function_50676d1(uid);
  }

  _register(uid, data);
}

function remove(uid) {
  level notify("remove_object_description_" + uid);
  arrayremoveindex(level.object_descriptions.ents, uid, 1);
  arrayremoveindex(level.object_descriptions.triggers, uid, 1);
  arrayremoveindex(level.object_descriptions.points, uid, 1);
  level.object_descriptions.objects = arraycombine(level.object_descriptions.ents, level.object_descriptions.triggers, 1, 0);
  level.object_descriptions.objects = arraycombine(level.object_descriptions.objects, level.object_descriptions.points, 1, 0);
  function_e8419844();
}

function remove_all() {
  level notify(#"hash_54c689354421dd79");
  level.object_descriptions.objects = [];
  level.object_descriptions.ents = [];
  level.object_descriptions.triggers = [];
  level.object_descriptions.points = [];
  level.object_descriptions.trace_dist = 0;
}

function private _register(uid, data) {
  if(!isDefined(data.var_774d5d03)) {
    data.var_774d5d03 = 0;
  }

  if(isDefined(data.ent)) {
    level.object_descriptions.ents[uid] = data;
  } else if(isDefined(data.trigger)) {
    level.object_descriptions.triggers[uid] = data;
  } else {
    level.object_descriptions.points[uid] = data;
  }

  level.object_descriptions.objects = arraycombine(level.object_descriptions.ents, level.object_descriptions.triggers, 1, 0);
  level.object_descriptions.objects = arraycombine(level.object_descriptions.objects, level.object_descriptions.points, 1, 0);
  function_e8419844();

  if(!level flag::get("object_descriptions_active")) {
    getplayers()[0] thread _think();
  }
}

function private function_e8419844() {
  level.object_descriptions.trace_dist = 0;

  foreach(data in level.object_descriptions.objects) {
    level.object_descriptions.trace_dist = max(level.object_descriptions.trace_dist, data.max_dist);
  }
}

function private function_50676d1(uid) {
  level endon(#"hash_54c689354421dd79", "remove_object_description_" + uid);
  self waittill(#"death");
  thread remove(uid);
}

function private function_73b1e949(data, trace, eye_dir) {
  return eye_dir[# "entity"] === trace.ent;
}

function private function_fc5ed81d(data, trace, eye_dir) {
  return istouching(eye_dir[# "position"], trace.trigger);
}

function private function_f08e8278(data, trace, eye_dir) {
  function_975e779f(data);
  to_focus = trace[# "position"] - data.center;

  if(abs(vectordot(to_focus, data.axis.forward)) > 6 || vectordot(eye_dir, data.axis.forward) > -0.17) {
    return false;
  }

  if(abs(vectordot(to_focus, data.axis.right)) > data.width) {
    return false;
  }

  if(abs(vectordot(to_focus, data.axis.up)) > data.height) {
    return false;
  }

  return true;
}

function private function_d0acce99(data, trace, eye_dir) {
  function_975e779f(data);
  to_focus = trace[# "position"] - data.center;

  if(abs(vectordot(to_focus, data.axis.forward)) > 6 || vectordot(eye_dir, data.axis.forward) > -0.17) {
    return false;
  }

  return lengthsquared(to_focus) < data.radius * data.radius;
}

function private function_136c1375(data) {
  return data.ent.origin;
}

function private function_f56da461(data) {
  return data.trigger.origin;
}

function private function_3c2d7742(data) {
  return data.center;
}

function private function_975e779f(data) {
  if(isDefined(data.link_ent)) {
    angle_delta = angleclamp180(data.var_1321588e - data.angles - data.link_ent.angles);

    if(lengthsquared(angle_delta) > 1) {
      data.var_9a145184 = rotatepoint(data.var_9a145184, angle_delta);
      data.angles = data.link_ent.angles + data.var_1321588e;
      data.axis = anglestoaxis(data.angles);
    }

    data.center = data.link_ent.origin + data.var_9a145184;
  }
}

function private _think() {
  self endon(#"death");
  level endon(#"level_restarting");
  level flag::set("object_descriptions_active");
  namespace_61e6d095::create(#"object_descriptions", #"hash_1dbb8163d29524c9");
  var_ebb41806 = undefined;

  while(level.object_descriptions.trace_dist > 0) {
    eye = self getplayercamerapos();
    eye_dir = anglesToForward(self getplayerangles());
    text = # "";
    var_36247bfb = # "";

    if(!namespace_61e6d095::exists(#"hint_tutorial") && !self flag::get(#"lockpicking") && function_185fc34e(eye, eye_dir)) {
      end = eye + eye_dir * level.object_descriptions.trace_dist;
      trace = bulletTrace(eye, end, 1, self, 1, 0);

      if(trace[# "fraction"] < 1) {
        distance = level.object_descriptions.trace_dist * trace[# "fraction"];
        start_index = 0;

        if(!isDefined(trace[# "entity"])) {
          start_index = level.object_descriptions.ents.size;
        }

        for(i = start_index; i < level.object_descriptions.objects.size; i++) {
          data = level.object_descriptions.objects[i];

          if(level.object_descriptions.debug_draw && isDefined(data.var_ffc04e84)) {
            [[data.var_ffc04e84]](data);
          }

          if(data.max_dist > distance && [[data.test_func]](data, trace, eye_dir)) {
            text = data.loc_string;
            var_36247bfb = data.var_36247bfb;
            break;
          }
        }
      }
    }

    if(var_ebb41806 !== text) {
      var_ebb41806 = text;

      if(isDefined(data) && isDefined(var_ebb41806) && var_ebb41806 != # "") {
        if(isDefined(var_36247bfb) && var_36247bfb != # "") {
          namespace_61e6d095::set_text(#"object_descriptions", var_36247bfb);
          namespace_61e6d095::function_bfdab223(#"object_descriptions", text);
        } else if(data.var_774d5d03 == 3) {
          namespace_61e6d095::set_text(#"object_descriptions", text);
        } else {
          namespace_61e6d095::function_bfdab223(#"object_descriptions", text);
        }

        namespace_61e6d095::set_state(#"object_descriptions", data.var_774d5d03);
      } else {
        namespace_61e6d095::set_text(#"object_descriptions", #"");
        namespace_61e6d095::function_bfdab223(#"object_descriptions", #"");
        namespace_61e6d095::set_state(#"object_descriptions", 0);
      }
    }

    waitframe(1);
  }

  namespace_61e6d095::remove(#"object_descriptions");
  level flag::clear("object_descriptions_active");
}

function private function_185fc34e(eye, eye_dir) {
  foreach(data in level.object_descriptions.objects) {
    origin = [[data.var_f03d5bb1]](data);

    if(distancesquared(eye, origin) < data.max_dist * data.max_dist && vectordot(eye_dir, origin - eye) > 0) {
      return true;
    }
  }

  return false;
}

function private function_5120dfdb(dvar) {
  level.object_descriptions.debug_draw = dvar.value;
}

function private function_1ee1bf29(data) {
  half_width = data.width / 2;
  half_height = data.height / 2;
  box(data.center, (-3, data.width * -1, data.height * -1), (3, data.width, data.height), data.angles, (1, 0.5, 0), 1, 1, 1);
}

function private _draw_circle(data) {
  circle(data.center, data.radius, (1, 0.5, 0), 1, 0, 1);
}