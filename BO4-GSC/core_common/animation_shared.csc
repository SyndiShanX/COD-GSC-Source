/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\animation_shared.csc
***********************************************/

#include scripts\core_common\animation_debug_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\shaderanim_shared;
#include scripts\core_common\system_shared;

#namespace animation;

autoexec __init__system__() {
  system::register(#"animation", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
  clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
  setup_notetracks();
}

first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
  self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time = 0) {
  self endon(#"death");
  self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link, n_start_time);
  self waittill(#"scriptedanim");
}

_play(animation, v_origin_or_ent, v_angles_or_tag, n_rate = 1, n_blend_in = 0.2, n_blend_out = 0.2, n_lerp, b_link = 0, n_start_time) {
  if(!isDefined(self)) {
    return;
  }

  self notify(#"new_scripted_anim");
  self endon(#"new_scripted_anim", #"death");

  if(!isDefined(self.model) || self.model == #"") {
    assertmsg("<dev string:x38>" + self.origin);
    return;
  }

  flagsys::set_val("firstframe", n_rate == 0);
  flagsys::set(#"scripted_anim_this_frame");
  flagsys::set(#"scriptedanim");

  if(!isDefined(v_origin_or_ent)) {
    v_origin_or_ent = self;
  }

  n_start_time = math::clamp(n_start_time, 0, 1);

  if(isvec(v_origin_or_ent) && isvec(v_angles_or_tag)) {
    self animscripted("_anim_notify_", v_origin_or_ent, v_angles_or_tag, animation, n_blend_in, n_rate, n_start_time);
  } else {
    if(isstring(v_angles_or_tag)) {
      assert(isDefined(v_origin_or_ent.model), "<dev string:x75>" + animation + "<dev string:x90>" + v_angles_or_tag + "<dev string:x9d>");
      v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
      v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
      self.origin = v_pos;
      self.angles = v_ang;
      b_link = 1;
      self animscripted("_anim_notify_", self.origin, self.angles, animation, n_blend_in, n_rate, n_start_time);
    } else {
      v_angles = isDefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
      v_origin = isDefined(v_origin_or_ent.origin) ? v_origin_or_ent.origin : (0, 0, 0);
      self animscripted("_anim_notify_", v_origin, v_angles, animation, n_blend_in, n_rate, n_start_time);
    }

    if(n_start_time > 0) {
      self setanimtimebyname(animation, n_start_time, 1);
    }
  }

  if(!b_link) {
    self unlink();
  }

  self.var_80c69db6 = "<dev string:xd2>";
  self.var_6c4bb19 = {
    #animation: animation, 
    #v_origin_or_ent: v_origin_or_ent, 
    #v_angles_or_tag: v_angles_or_tag
  };
  level flagsys::clear("<dev string:xdb>");

  self thread handle_notetracks();
  self waittill_end();

  if(b_link) {
    self unlink();
  }

  flagsys::clear(#"scriptedanim");
  flagsys::clear(#"firstframe");
  self.var_80c69db6 = undefined;
  self.var_6c4bb19 = undefined;
  waittillframeend();
  flagsys::clear(#"scripted_anim_this_frame");
}

private waittill_end() {
  level endon(#"demo_jump");
  self waittillmatch({
    #notetrack: "end"
  }, #"_anim_notify_");
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
    assert(isvec(v_angles_or_tag), "<dev string:xe8>");
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

play_siege(str_anim, str_shot = "default", n_rate = 1, b_loop = 0) {
  self notify(#"end");
  level endon(#"demo_jump");
  self endon(#"death");

  if(!isDefined(str_shot)) {
    str_shot = "default";
  }

  if(n_rate == 0) {
    self siegecmd("set_anim", str_anim, "set_shot", str_shot, "pause", "goto_start");
  } else {
    self siegecmd("set_anim", str_anim, "set_shot", str_shot, "unpause", "set_playback_speed", n_rate, "send_end_events", 1, b_loop ? "loop" : "unloop");
  }

  self waittill(#"end");
}

add_notetrack_func(funcname, func) {
  if(!isDefined(level._animnotifyfuncs)) {
    level._animnotifyfuncs = [];
  }

  assert(!isDefined(level._animnotifyfuncs[funcname]), "<dev string:x110>");
  level._animnotifyfuncs[funcname] = func;
}

add_global_notetrack_handler(str_note, func, ...) {
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

  level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, vararg);
}

call_notetrack_handler(str_note) {
  if(isDefined(level._animnotetrackhandlers) && isDefined(level._animnotetrackhandlers[str_note])) {
    foreach(handler in level._animnotetrackhandlers[str_note]) {
      func = handler[0];
      args = handler[1];

      switch (args.size) {
        case 6:
          self[[func]](args[0], args[1], args[2], args[3], args[4], args[5]);
          break;
        case 5:
          self[[func]](args[0], args[1], args[2], args[3], args[4]);
          break;
        case 4:
          self[[func]](args[0], args[1], args[2], args[3]);
          break;
        case 3:
          self[[func]](args[0], args[1], args[2]);
          break;
        case 2:
          self[[func]](args[0], args[1]);
          break;
        case 1:
          self[[func]](args[0]);
          break;
        case 0:
          self[[func]]();
          break;
        default:
          assertmsg("<dev string:x135>");
          break;
      }
    }
  }
}

setup_notetracks() {
  add_notetrack_func("flag::set", &flag::set);
  add_notetrack_func("flag::clear", &flag::clear);
  add_notetrack_func("postfx::PlayPostFxBundle", &postfx::playpostfxbundle);
  add_notetrack_func("postfx::StopPostFxBundle", &postfx::stoppostfxbundle);
  add_global_notetrack_handler("red_cracks_on", &cracks_on, "red");
  add_global_notetrack_handler("green_cracks_on", &cracks_on, "green");
  add_global_notetrack_handler("blue_cracks_on", &cracks_on, "blue");
  add_global_notetrack_handler("all_cracks_on", &cracks_on, "all");
  add_global_notetrack_handler("red_cracks_off", &cracks_off, "red");
  add_global_notetrack_handler("green_cracks_off", &cracks_off, "green");
  add_global_notetrack_handler("blue_cracks_off", &cracks_off, "blue");
  add_global_notetrack_handler("all_cracks_off", &cracks_off, "all");
}

handle_notetracks() {
  self notify(#"handle_notetracks");
  level endon(#"demo_jump");
  self endon(#"handle_notetracks", #"death");

  while(true) {
    waitresult = self waittill(#"_anim_notify_");
    str_note = waitresult.notetrack;

    if(str_note != "end" && str_note != "loop_end") {
      self thread call_notetrack_handler(str_note);
      continue;
    }

    return;
  }
}

cracks_on(str_type) {
  switch (str_type) {
    case #"red":
      cf_cracks_on(self.localclientnum, 0, 1);
      break;
    case #"green":
      cf_cracks_on(self.localclientnum, 0, 3);
      break;
    case #"blue":
      cf_cracks_on(self.localclientnum, 0, 2);
      break;
    case #"all":
      cf_cracks_on(self.localclientnum, 0, 4);
      break;
  }
}

cracks_off(str_type) {
  switch (str_type) {
    case #"red":
      cf_cracks_off(self.localclientnum, 0, 1);
      break;
    case #"green":
      cf_cracks_off(self.localclientnum, 0, 3);
      break;
    case #"blue":
      cf_cracks_off(self.localclientnum, 0, 2);
      break;
    case #"all":
      cf_cracks_off(self.localclientnum, 0, 4);
      break;
  }
}

cf_cracks_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1:
      shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
      break;
    case 3:
      shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
      break;
    case 2:
      shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
      break;
    case 4:
      shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
      shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
      shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
      break;
  }
}

cf_cracks_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1:
      shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
      break;
    case 3:
      shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
      break;
    case 2:
      shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
      break;
    case 4:
      shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
      shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
      shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
      break;
  }
}