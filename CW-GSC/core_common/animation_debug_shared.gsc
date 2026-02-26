/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\animation_debug_shared.gsc
**************************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#namespace animation;

function private autoexec __init__system__() {
  system::register(#"animation_debug", &preinit, undefined, undefined, undefined);
}

function preinit() {
  thread init();
}

function init() {
  flag::init_dvar(#"anim_debug");
  flag::init_dvar(#"anim_debug_pause");

  for(;;) {
    level flag::wait_till_any([#"anim_debug", #"anim_debug_pause"]);
    waitframe(1);
    a_ents = getEntArray("<dev string:x38>", "<dev string:x42>", 1);

    foreach(ent in a_ents) {
      ent thread anim_info_render_thread();
    }

    level flag::wait_till_clear_all([#"anim_debug", #"anim_debug_pause"]);
    level notify(#"kill_anim_debug");
  }
}

function is_anim_debugging(ent) {
  return isDefined(ent) && ent flag::get(#"scriptedanim");
}

function anim_info_render_thread() {
  animation = self.var_6c4bb19.animation;
  v_origin_or_ent = self.var_6c4bb19.v_origin_or_ent;
  v_angles_or_tag = self.var_6c4bb19.v_angles_or_tag;
  var_f4b34dc1 = self.var_6c4bb19.var_f4b34dc1;
  self notify(#"_anim_info_render_thread_");
  self endon(#"_anim_info_render_thread_", #"death", #"scriptedanim");
  level endon(#"kill_anim_debug");

  if(!isDefined(v_origin_or_ent)) {
    v_origin_or_ent = self.origin;
  }

  if(!isvec(v_origin_or_ent)) {
    v_origin_or_ent endon(#"death");
  }

  if(!isDefined(level.debug_ents_by_origin)) {
    level.debug_ents_by_origin = [];
  }

  str_origin = "<dev string:x5c>" + floor(self.origin[0] / 10) * 10 + "<dev string:x60>" + floor(self.origin[1] / 10) * 10 + "<dev string:x60>" + floor(self.origin[2] / 10) * 10;

  if(!isDefined(level.debug_ents_by_origin[str_origin])) {
    level.debug_ents_by_origin[str_origin] = [];
  }

  array::filter(level.debug_ents_by_origin[str_origin], 0, &is_anim_debugging);
  array::add(level.debug_ents_by_origin[str_origin], self, 0);
  n_same_origin_index = array::find(level.debug_ents_by_origin[str_origin], self);
  recordent(self);

  while(true) {
    _init_frame();
    str_extra_info = "<dev string:x5c>";
    color = (1, 1, 0);

    if(flag::get(#"firstframe")) {
      str_extra_info += "<dev string:x65>";
    }

    var_13edeb1f = getanimframecount(animation);
    var_7b160393 = self getanimtime(animation) * var_13edeb1f;
    var_958054e5 = getanimlength(animation);
    var_f667af2f = self getanimtime(animation) * var_958054e5;
    str_extra_info += "<dev string:x76>" + var_f667af2f + "<dev string:x85>" + var_958054e5 + "<dev string:x8a>" + var_7b160393 + "<dev string:x85>" + var_13edeb1f + "<dev string:x9e>";
    s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    self anim_origin_render(s_pos.origin, s_pos.angles, undefined, undefined, !true);

    if(true) {
      line(self.origin, s_pos.origin, color, 0.5, 1);
      sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
    }

    recordline(self.origin, s_pos.origin, color, "<dev string:xa3>");
    recordsphere(s_pos.origin, 2, (0.3, 0.3, 0.3), "<dev string:xa3>");

    if(!isvec(v_origin_or_ent) && v_origin_or_ent != self && v_origin_or_ent != level) {
      str_name = "<dev string:xb3>";

      if(isDefined(v_origin_or_ent.animname)) {
        str_name = v_origin_or_ent.animname;
      } else if(isDefined(v_origin_or_ent.targetname)) {
        str_name = v_origin_or_ent.targetname;
      }

      if(true) {
        print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
      }

      record3dtext(str_name, v_origin_or_ent.origin + (0, 0, 5), (0.3, 0.3, 0.3), "<dev string:xa3>");
    }

    self anim_origin_render(self.origin, self.angles, undefined, undefined, !true);
    str_name = "<dev string:xb3>";

    if(isDefined(self.anim_debug_name)) {
      str_name = self.anim_debug_name;
    } else if(isDefined(self.animname)) {
      str_name = self.animname;
    } else if(isDefined(self.targetname)) {
      str_name = self.targetname;
    }

    maso_they_don_t_see_us_ye_ = self.origin - (0, 0, 15 * n_same_origin_index);

    if(true) {
      print3d(maso_they_don_t_see_us_ye_, self getentnum() + get_ent_type() + "<dev string:xbe>" + str_name, color, 0.8, 0.3);
      print3d(maso_they_don_t_see_us_ye_ - (0, 0, 5), "<dev string:xca>" + (isanimlooping(animation) ? "<dev string:xd2>" : "<dev string:xdd>") + function_9e72a96(animation), color, 0.8, 0.3);
      print3d(maso_they_don_t_see_us_ye_ - (0, 0, 11), str_extra_info, color, 0.8, 0.3);

      if(isarray(var_f4b34dc1) && var_f4b34dc1.size) {
        n_z_offset = 17;

        foreach(var_21c1ba1, str_anim in var_f4b34dc1) {
          var_1c56a327 = "<dev string:xe3>" + var_21c1ba1 + "<dev string:xee>" + function_9e72a96(str_anim);
          print3d(maso_they_don_t_see_us_ye_ - (0, 0, n_z_offset), var_1c56a327, (0, 1, 1), 0.8, 0.15);
          n_z_offset += 6;
        }
      }
    }

    record3dtext(self getentnum() + get_ent_type() + "<dev string:x102>" + str_name, maso_they_don_t_see_us_ye_, color, "<dev string:xa3>");
    record3dtext("<dev string:x10c>" + animation, maso_they_don_t_see_us_ye_ - (0, 0, 5), color, "<dev string:xa3>");
    record3dtext(str_extra_info, maso_they_don_t_see_us_ye_ - (0, 0, 7), color, "<dev string:xa3>");
    render_tag("<dev string:x11a>", "<dev string:x12e>", !true);
    render_tag("<dev string:x137>", "<dev string:x14a>", !true);
    render_tag("<dev string:x152>", "<dev string:x160>", !true);
    render_tag("<dev string:x16a>", "<dev string:x178>", !true);
    render_tag("<dev string:x182>", "<dev string:x18f>", !true);
    render_tag("<dev string:x198>", "<dev string:x1a3>", !true);
    render_tag("<dev string:x1aa>", "<dev string:x1aa>", !true);
    render_tag("<dev string:x1b6>", "<dev string:x1b6>", !true);
    render_tag("<dev string:x1c2>", "<dev string:x1ce>", !true);
    render_tag("<dev string:x1ce>", "<dev string:x1da>", !true);
    render_tag("<dev string:x1da>", "<dev string:x1e6>", !true);
    render_tag("<dev string:x1f2>", "<dev string:x1f2>", !true);
    render_tag("<dev string:x1fe>", "<dev string:x1fe>", !true);
    render_tag("<dev string:x20a>", "<dev string:x20a>", !true);
    render_tag("<dev string:x216>", "<dev string:x216>", !true);
    render_tag("<dev string:x223>", "<dev string:x223>", !true);
    render_tag("<dev string:x230>", "<dev string:x230>", !true);
    render_tag("<dev string:x23d>", "<dev string:x23d>", !true);
    render_tag("<dev string:x24a>", "<dev string:x24a>", !true);
    render_tag("<dev string:x257>", "<dev string:x257>", !true);
    _reset_frame();
    waitframe(1);
  }
}

function get_ent_type() {
  if(isactor(self)) {
    return "<dev string:x264>";
  }

  if(isvehicle(self)) {
    return "<dev string:x26c>";
  }

  return "<dev string:x279>" + self.classname + "<dev string:x27e>";
}

function _init_frame() {
  self.v_centroid = self getcentroid();
}

function _reset_frame() {
  self.v_centroid = undefined;
}

function render_tag(str_tag, str_label, b_recorder_only) {
  if(!isDefined(str_label)) {
    str_label = str_tag;
  }

  if(!isDefined(self.v_centroid)) {
    self.v_centroid = self getcentroid();
  }

  v_tag_org = self gettagorigin(str_tag);

  if(isDefined(v_tag_org)) {
    v_tag_ang = self gettagangles(str_tag);
    anim_origin_render(v_tag_org, v_tag_ang, 2, str_label, b_recorder_only);

    if(!b_recorder_only) {
      line(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), 0.5, 1);
    }

    recordline(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), "<dev string:xa3>");
  }
}

function anim_origin_render(org, angles, line_length, str_label, b_recorder_only) {
  if(!isDefined(line_length)) {
    line_length = 6;
  }

  if(isDefined(org) && isDefined(angles)) {
    originendpoint = org + vectorscale(anglesToForward(angles), line_length);
    originrightpoint = org + vectorscale(anglestoright(angles), -1 * line_length);
    originuppoint = org + vectorscale(anglestoup(angles), line_length);

    if(!b_recorder_only) {
      line(org, originendpoint, (1, 0, 0));
      line(org, originrightpoint, (0, 1, 0));
      line(org, originuppoint, (0, 0, 1));
    }

    recordline(org, originendpoint, (1, 0, 0), "<dev string:xa3>");
    recordline(org, originrightpoint, (0, 1, 0), "<dev string:xa3>");
    recordline(org, originuppoint, (0, 0, 1), "<dev string:xa3>");

    if(isDefined(str_label)) {
      if(!b_recorder_only) {
        print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
      }

      record3dtext(str_label, org, (1, 0.752941, 0.796078), "<dev string:xa3>");
    }
  }
}