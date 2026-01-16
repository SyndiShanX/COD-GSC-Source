/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\animation_shared.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_debug_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\string_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\voice\voice;

#namespace animation;

autoexec __init__system__() {
  system::register(#"animation", &__init__, undefined, undefined);
}

__init__() {
  if(getdvarstring(#"debug_anim_shared", "") == "") {
    setdvar(#"debug_anim_shared", "");
  }

  setup_notetracks();
  callback::on_laststand(&reset_player);
  callback::on_bleedout(&reset_player);
  callback::on_player_killed(&reset_player);
  callback::on_spawned(&reset_player);
}

reset_player() {
  flagsys::clear(#"firstframe");
  flagsys::clear(#"scripted_anim_this_frame");
  flagsys::clear(#"scriptedanim");
}

first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
  self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

last_frame(animation, v_origin_or_ent, v_angles_or_tag) {
  self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0, 0, 0, 0, 1);
}

play_siege(str_anim, n_rate = 1) {
  self notify(#"stop_siege_anim");
  self endon(#"death", #"scene_stop", #"stop_siege_anim");
  b_loop = function_35c3fa74(str_anim);
  self function_cf6be307(str_anim, "default", n_rate, b_loop);

  if(b_loop) {
    self waittill(#"stop_siege_anim");
    return;
  }

  n_length = function_658484f7(str_anim);
  wait n_length;
}

play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp = 0, n_start_time = 0, b_show_player_firstperson_weapon = 0, b_unlink_after_completed = 1, var_f4b34dc1, paused) {
  if(self isragdoll()) {
    return;
  }

  self endon(#"death", #"entering_last_stand");
  self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_f4b34dc1, paused);

  if(n_rate > 0) {
    self waittill(#"scriptedanim");
  }
}

stop(n_blend = 0.2) {
  flagsys::clear(#"scriptedanim");

  if(isDefined(self)) {
    self stopanimscripted(n_blend);
  }
}

debug_print(str_animation, str_msg) {
  str_dvar = getdvarstring(#"debug_anim_shared", "<dev string:x38>");

  if(str_dvar != "<dev string:x38>") {
    if(!isstring(str_animation)) {
      str_animation = isDefined(function_9e72a96(str_animation)) ? "<dev string:x38>" + function_9e72a96(str_animation) : "<dev string:x38>";
    }

    b_print = 0;

    if(strisnumber(str_dvar)) {
      if(int(str_dvar) > 0) {
        b_print = 1;
      }
    } else if(issubstr(str_animation, str_dvar) || isDefined(self.animname) && issubstr(self.animname, str_dvar)) {
      b_print = 1;
    }

    if(b_print) {
      printtoprightln(str_animation + "<dev string:x3b>" + string::rjust(str_msg, 10) + "<dev string:x3b>" + string::rjust("<dev string:x38>" + self getentitynumber(), 4) + "<dev string:x41>" + string::rjust("<dev string:x38>" + gettime(), 6) + "<dev string:x46>", (1, 1, 0), -1);
    }
  }
}

_play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed, var_f4b34dc1, paused) {
  self notify(#"new_scripted_anim");
  self endoncallback(&function_2adc2518, #"death", #"entering_last_stand", #"new_scripted_anim");

  debug_print(animation, "<dev string:x4a>");

  flagsys::set_val("firstframe", n_rate == 0 && !(isDefined(paused) && paused));
  flagsys::set(#"scripted_anim_this_frame");
  flagsys::set(#"scriptedanim");

  if(!isDefined(v_origin_or_ent)) {
    v_origin_or_ent = self;
  }

  if(isvec(v_origin_or_ent)) {
    v_origin = v_origin_or_ent;
  } else {
    v_origin = isDefined(v_origin_or_ent.origin) ? v_origin_or_ent.origin : (0, 0, 0);
  }

  if(isvec(v_angles_or_tag)) {
    v_angles = v_angles_or_tag;
  } else if(isstring(v_angles_or_tag)) {
    str_tag = v_angles_or_tag;
    v_origin = v_origin_or_ent gettagorigin(str_tag);
    v_angles = v_origin_or_ent gettagangles(str_tag);
    assert(isDefined(v_origin) && isDefined(v_angles), "<dev string:x54>" + function_9e72a96(animation) + "<dev string:x87>" + v_origin_or_ent getentitynumber() + "<dev string:x96>" + v_angles_or_tag + "<dev string:xa3>");
  } else {
    v_angles = isDefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
  }

  self.str_current_anim = animation;
  b_link = isentity(v_origin_or_ent);

  if(isDefined(self.n_script_anim_rate)) {
    n_rate = self.n_script_anim_rate;
  }

  if(n_lerp > 0) {
    prevorigin = self.origin;
    prevangles = self.angles;
  }

  if(b_link) {
    if(isactor(self)) {
      self forceteleport(v_origin, v_angles);
    } else if(isplayer(self)) {
      self setorigin(v_origin);
      self setplayerangles(v_angles);
    } else {
      self.origin = v_origin;
      self.angles = v_angles;
    }

    if(v_origin_or_ent != self) {
      if(isstring(str_tag)) {
        self linkto(v_origin_or_ent, str_tag, (0, 0, 0), (0, 0, 0));
      } else {
        self linkto(v_origin_or_ent);
      }
    }

    if(n_lerp > 0) {
      if(isactor(self)) {
        self forceteleport(prevorigin, prevangles);
      } else if(isplayer(self)) {
        self setorigin(prevorigin);
        self setplayerangles(prevangles);
      } else {
        self.origin = prevorigin;
        self.angles = prevangles;
      }
    }
  }

  self animscripted(animation, v_origin, v_angles, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon, var_f4b34dc1, paused);

  if(isplayer(self)) {
    set_player_clamps();
  }

  self.var_80c69db6 = "<dev string:xa7>";
  self.var_6c4bb19 = {
    #animation: animation, 
    #v_origin_or_ent: v_origin_or_ent, 
    #v_angles_or_tag: v_angles_or_tag, 
    #var_f4b34dc1: var_f4b34dc1
  };
  level flagsys::clear("<dev string:xb0>");

  if(!isanimlooping(animation) && n_blend_out > 0 && n_rate > 0 && n_start_time < 1) {
    if(!animhasnotetrack(animation, "start_ragdoll")) {
      self thread _blend_out(animation, n_blend_out, n_rate, n_start_time);
    }
  }

  if(!flagsys::get(#"firstframe")) {
    self thread handle_notetracks(animation);

    if(getanimframecount(animation) > 1 || isanimlooping(animation)) {
      self waittillmatch({
        #notetrack: "end"
      }, animation);
    } else {
      waitframe(1);
    }

    if(b_link && isDefined(b_unlink_after_completed) && b_unlink_after_completed) {
      self unlink();
    }

    self.str_current_anim = undefined;
    self.var_80c69db6 = undefined;
    self.var_6c4bb19 = undefined;
    flagsys::clear(#"scriptedanim");
    flagsys::clear(#"firstframe");

    debug_print(animation, "<dev string:xbd>");

    waittillframeend();
    flagsys::clear(#"scripted_anim_this_frame");
  }
}

function_2adc2518(str_notify) {
  if(isDefined(self) && str_notify == "entering_last_stand") {
    self.var_80c69db6 = undefined;
    self.str_current_anim = undefined;
    self.var_6c4bb19 = undefined;
  }
}

_blend_out(animation, n_blend, n_rate, n_start_time) {
  self endon(#"death", #"end", #"scriptedanim", #"new_scripted_anim");
  n_server_length = floor(getanimlength(animation) / float(function_60d95f53()) / 1000) * float(function_60d95f53()) / 1000;

  while(true) {
    n_current_time = self getanimtime(animation) * n_server_length;
    n_time_left = n_server_length - n_current_time;

    if(n_time_left <= n_blend) {
      self stopanimscripted(n_blend);
      break;
    }

    waitframe(1);
  }
}

_get_align_ent(e_align) {
  e = self;

  if(isDefined(e_align)) {
    e = e_align;
  }

  if(!isDefined(e.angles)) {
    e.angles = (0, 0, 0);
  }

  return e;
}

_get_align_pos(v_origin_or_ent = self.origin, v_angles_or_tag = isDefined(self.angles) ? self.angles : (0, 0, 0)) {
  s = spawnStruct();

  if(isvec(v_origin_or_ent)) {
    assert(isvec(v_angles_or_tag), "<dev string:xc5>");
    s.origin = v_origin_or_ent;
    s.angles = v_angles_or_tag;
  } else {
    e_align = _get_align_ent(v_origin_or_ent);

    if(isstring(v_angles_or_tag)) {
      s.origin = e_align gettagorigin(v_angles_or_tag);
      s.angles = e_align gettagangles(v_angles_or_tag);
    } else {
      s.origin = e_align.origin;
      s.angles = e_align.angles;
    }
  }

  if(!isDefined(s.angles)) {
    s.angles = (0, 0, 0);
  }

  return s;
}

teleport(animation, v_origin_or_ent, v_angles_or_tag, time = 0) {
  s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
  v_pos = getstartorigin(s.origin, s.angles, animation, time);
  v_ang = getstartangles(s.origin, s.angles, animation, time);

  if(isactor(self)) {
    self forceteleport(v_pos, v_ang);
    return;
  }

  if(isplayer(self)) {
    self setorigin(v_pos);
    self setplayerangles(v_ang);
    return;
  }

  self.origin = v_pos;
  self.angles = v_ang;
}

reach(animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0) {
  self endon(#"death");
  s_tracker = spawnStruct();
  self thread _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals);
  s_tracker waittill(#"done");
}

_reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals = 0) {
  self endon(#"death");
  self notify(#"stop_going_to_node");
  self notify(#"new_anim_reach");
  flagsys::wait_till_clear("anim_reach");
  flagsys::set(#"anim_reach");
  s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
  goal = getstartorigin(s.origin, s.angles, animation);
  n_delta = distancesquared(goal, self.origin);

  if(n_delta > 16) {
    self stopanimscripted(0.2);

    if(b_disable_arrivals) {
      if(ai::has_behavior_attribute("disablearrivals")) {
        ai::set_behavior_attribute("disablearrivals", 1);
      }

      self.stopanimdistsq = 0.0001;
    }

    if(isDefined(self.archetype) && self.archetype == #"robot") {
      ai::set_behavior_attribute("rogue_control_force_goal", goal);
    } else if(ai::has_behavior_attribute("vignette_mode") && !(isDefined(self.ignorevignettemodeforanimreach) && self.ignorevignettemodeforanimreach)) {
      ai::set_behavior_attribute("vignette_mode", "fast");
    }

    self thread ai::force_goal(goal, 1, undefined, 0, 1);

    self thread debug_anim_reach();

    self waittill(#"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");

    if(ai::has_behavior_attribute("disablearrivals")) {
      ai::set_behavior_attribute("disablearrivals", 0);
      self.stopanimdistsq = 0;
    }
  } else {
    waittillframeend();
  }

  if(!(isDefined(self.archetype) && self.archetype == #"robot") && ai::has_behavior_attribute("vignette_mode")) {
    ai::set_behavior_attribute("vignette_mode", "off");
  }

  flagsys::clear(#"anim_reach");
  s_tracker notify(#"done");
  self notify(#"reach_done");
}

debug_anim_reach() {
  self endon(#"death", #"goal", #"new_anim_reach", #"new_scripted_anim", #"stop_scripted_anim");

  while(true) {
    level flagsys::wait_till("<dev string:xb0>");
    print3d(self.origin, "<dev string:xed>", (1, 0, 0), 1, 1, 1);
    waitframe(1);
  }
}

set_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
  self notify(#"new_death_anim");

  if(isDefined(animation)) {
    self.skipdeath = 1;
    self thread _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    return;
  }

  self.skipdeath = 0;
}

_do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
  self endon(#"new_death_anim");
  self waittill(#"death");

  if(isDefined(self) && !self isragdoll()) {
    self play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
  }
}

set_player_clamps() {
  if(isDefined(self.player_anim_look_enabled) && self.player_anim_look_enabled) {
    self setviewclamp(self.player_anim_clamp_right, self.player_anim_clamp_left, self.player_anim_clamp_top, self.player_anim_clamp_bottom);
  }
}

add_notetrack_func(funcname, func) {
  if(!isDefined(level._animnotifyfuncs)) {
    level._animnotifyfuncs = [];
  }

  assert(!isDefined(level._animnotifyfuncs[funcname]), "<dev string:xfa>");
  level._animnotifyfuncs[funcname] = func;
}

add_global_notetrack_handler(str_note, func, pass_notify_params, ...) {
  if(!isDefined(level._animnotetrackhandlers)) {
    level._animnotetrackhandlers = [];
  }

  if(!isDefined(level._animnotetrackhandlers[str_note])) {
    level._animnotetrackhandlers[str_note] = [];
  }

  if(!isDefined(level._animnotetrackhandlers[str_note])) {
    level._animnotetrackhandlers[str_note] = [];
  } else if(!isarray(level._animnotetrackhandlers[str_note])) {
    level._animnotetrackhandlers[str_note] = array(level._animnotetrackhandlers[str_note]);
  }

  level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, pass_notify_params, vararg);
}

call_notetrack_handler(str_note, param1, param2) {
  if(isDefined(level._animnotetrackhandlers[str_note])) {
    foreach(handler in level._animnotetrackhandlers[str_note]) {
      func = handler[0];
      passnotifyparams = handler[1];
      args = handler[2];

      if(passnotifyparams) {
        self[[func]](param1, param2);
        continue;
      }

      util::single_func_argarray(self, func, args);
    }
  }
}

setup_notetracks() {
  add_notetrack_func("flag::set", &flagsys::set);
  add_notetrack_func("flag::clear", &flagsys::clear);
  add_notetrack_func("util::break_glass", &util::break_glass);
  add_notetrack_func("PhysicsLaunch", &function_eb0aa7cf);
  clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int");
  clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int");
  add_global_notetrack_handler("red_cracks_on", &cracks_on, 0, "red");
  add_global_notetrack_handler("green_cracks_on", &cracks_on, 0, "green");
  add_global_notetrack_handler("blue_cracks_on", &cracks_on, 0, "blue");
  add_global_notetrack_handler("all_cracks_on", &cracks_on, 0, "all");
  add_global_notetrack_handler("red_cracks_off", &cracks_off, 0, "red");
  add_global_notetrack_handler("green_cracks_off", &cracks_off, 0, "green");
  add_global_notetrack_handler("blue_cracks_off", &cracks_off, 0, "blue");
  add_global_notetrack_handler("all_cracks_off", &cracks_off, 0, "all");
  add_global_notetrack_handler("headlook_on", &enable_headlook, 0, 1);
  add_global_notetrack_handler("headlook_off", &enable_headlook, 0, 0);
  add_global_notetrack_handler("headlook_notorso_on", &enable_headlook_notorso, 0, 1);
  add_global_notetrack_handler("headlook_notorso_off", &enable_headlook_notorso, 0, 0);
  add_global_notetrack_handler("attach weapon", &attach_weapon, 1);
  add_global_notetrack_handler("detach weapon", &detach_weapon, 1);
  add_global_notetrack_handler("fire", &fire_weapon, 0);
}

handle_notetracks(animation) {
  self endon(#"death", #"new_scripted_anim");

  while(true) {
    waitresult = self waittill(animation);
    str_note = waitresult.notetrack;

    if(isDefined(str_note)) {
      if(str_note != "end" && str_note != "loop_end") {
        self thread call_notetrack_handler(str_note, waitresult.param1, waitresult.param2);
        continue;
      }

      return;
    }
  }
}

cracks_on(str_type) {
  switch (str_type) {
    case #"red":
      clientfield::set("cracks_on", 1);
      break;
    case #"green":
      clientfield::set("cracks_on", 3);
      break;
    case #"blue":
      clientfield::set("cracks_on", 2);
      break;
    case #"all":
      clientfield::set("cracks_on", 4);
      break;
  }
}

cracks_off(str_type) {
  switch (str_type) {
    case #"red":
      clientfield::set("cracks_off", 1);
      break;
    case #"green":
      clientfield::set("cracks_off", 3);
      break;
    case #"blue":
      clientfield::set("cracks_off", 2);
      break;
    case #"all":
      clientfield::set("cracks_off", 4);
      break;
  }
}

enable_headlook(b_on = 1) {
  if(isactor(self)) {
    if(b_on) {
      self lookatentity(level.players[0]);
      return;
    }

    self lookatentity();
  }
}

enable_headlook_notorso(b_on = 1) {
  if(isactor(self)) {
    if(b_on) {
      self lookatentity(level.players[0], 1);
      return;
    }

    self lookatentity();
  }
}

is_valid_weapon(weaponobject) {
  return isDefined(weaponobject) && weaponobject != level.weaponnone;
}

attach_weapon(weaponobject, tag = "tag_weapon_right") {
  if(isactor(self)) {
    if(is_valid_weapon(weaponobject)) {
      ai::gun_switchto(weaponobject.name, "right");
    } else {
      ai::gun_recall();
    }

    return;
  }

  if(!is_valid_weapon(weaponobject)) {
    weaponobject = self.last_item;
  }

  if(is_valid_weapon(weaponobject)) {
    if(self.item != level.weaponnone) {
      detach_weapon();
    }

    assert(isDefined(weaponobject.worldmodel));
    self attach(weaponobject.worldmodel, tag);
    self setentityweapon(weaponobject);
    self.gun_removed = undefined;
    self.last_item = weaponobject;
  }
}

detach_weapon(weaponobject, tag = "tag_weapon_right") {
  if(isactor(self)) {
    ai::gun_remove();
    return;
  }

  if(!is_valid_weapon(weaponobject)) {
    weaponobject = self.item;
  }

  if(is_valid_weapon(weaponobject)) {
    self detach(weaponobject.worldmodel, tag);
    self setentityweapon(level.weaponnone);
  }

  self.gun_removed = 1;
}

fire_weapon() {
  if(!isai(self)) {
    if(self.item != level.weaponnone) {
      v_start_pos = isDefined(self gettagorigin("tag_flash")) ? self gettagorigin("tag_flash") : self gettagorigin("tag_aim");
      v_start_ang = isDefined(self gettagangles("tag_flash")) ? self gettagangles("tag_flash") : self gettagangles("tag_aim");
      v_end_pos = v_start_pos + vectorscale(anglesToForward(v_start_ang), 100);
      magicbullet(self.item, v_start_pos, v_end_pos, self);
    }
  }
}

function_eb0aa7cf(n_pulse = 100, bone) {
  assert(!issentient(self), "<dev string:x11f>");

  if(!isDefined(bone)) {
    bone = "tag_physics_pulse";
  }

  var_8ef160cb = isDefined(self gettagorigin(bone)) ? self gettagorigin(bone) : self getcentroid();
  n_pulse = float(n_pulse);

  if(n_pulse == 0) {
    self physicslaunch(var_8ef160cb);
    return;
  }

  var_cc487a10 = self gettagangles(bone);
  var_236556ec = (0, 0, 100);
  color = (1, 0, 0);

  if(isDefined(var_cc487a10)) {
    var_236556ec = vectorscale(anglesToForward(var_cc487a10), n_pulse);
    color = (0, 1, 0);
  } else {
    x_dir = math::cointoss() ? 1 : -1;
    y_dir = math::cointoss() ? 1 : -1;
    z_dir = math::cointoss() ? 1 : -1;
    var_236556ec = vectorscale((x_dir, y_dir, z_dir), n_pulse);
    color = (1, 1, 0);
  }

  self physicslaunch(var_8ef160cb, var_236556ec);

  util::draw_arrow_time(var_8ef160cb, var_8ef160cb + var_236556ec, color, 2);
}