/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_glasses.csc
**************************************/

#include clientscripts\_utility;

autoexec init() {
  register_clientflag_callback("scriptmover", 1, ::glasses_cam);
  register_clientflag_callback("scriptmover", 2, ::extra_cam);
  register_clientflag_callback("scriptmover", 4, ::karma_vitals_cam);
  waitforclient(0);
  init_sw_cam();
  level.extracamactive = 0;
}

glasses_cam(localclientnum, set, newent) {
  if(set) {
    if(!level.extracamactive) {
      level.extracamactive = 1;
      self isextracam(0);
    }
  } else if(level.extracamactive) {
    stopextracam(0);
    level.extracamactive = 0;
  }
}

extra_cam(localclientnum, set, newent) {
  if(set) {
    if(!level.extracamactive) {
      level.extracamactive = 1;
      self isextracam(0);
      start_sw_cam(0.1, 0.1, 0.1);
    }
  } else if(level.extracamactive) {
    stopextracam(0);
    level.extracamactive = 0;
    stop_sw_cam();
  }
}

init_sw_cam() {
  level.pip_filterid = 2;
  level.pip_passid = 0;
  level.pip_materialid = 12;
  level.pip_opacity = 0.5;
  level.pip_squash = 1.0;
  level.pip_material = "extracam_glasses";
  level.pip_left = 30;
  level.pip_top = 30;
  level.pip_right = 230;
  level.pip_bottom = 290;
  player = level.localplayers[0];
  player map_material(level.pip_materialid, level.pip_material);
  player set_filter_pass_material(level.pip_filterid, level.pip_passid, level.pip_materialid);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 4, level.pip_left);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 5, level.pip_top);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 6, level.pip_right);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 7, level.pip_bottom);
  player set_filter_bit_flag(level.pip_filterid, 2, 1);
}

init_crosshair_material() {
  level.pip_filterid = 2;
  level.pip_passid = 0;
  level.pip_materialid = 12;
  level.pip_opacity = 0.5;
  level.pip_squash = 1.0;
  level.pip_material = "hud_karma_sw";
  level.pip_left = 30;
  level.pip_top = 30;
  level.pip_right = 230;
  level.pip_bottom = 290;
  player = level.localplayers[0];
  player map_material(level.pip_materialid, level.pip_material);
  player set_filter_pass_material(level.pip_filterid, level.pip_passid, level.pip_materialid, 3, 0, 0);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 4, level.pip_left);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 5, level.pip_top);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 6, level.pip_right);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 7, level.pip_bottom);
}

set_extracam_material_location(material, left, top, right, bottom) {
  level.pip_material = material;
  level.pip_left = left;
  level.pip_top = top;
  level.pip_right = right;
  level.pip_bottom = bottom;
  player = level.localplayers[0];
  player map_material(level.pip_materialid, level.pip_material);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 4, level.pip_left);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 5, level.pip_top);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 6, level.pip_right);
  player set_filter_pass_constant(level.pip_filterid, level.pip_passid, 7, level.pip_bottom);
}

setup_player_control(localclientnum) {
  player = getlocalplayer(localclientnum);

  while(true) {
    movement = player getnormalizedcameramovement();
    new_angles = self.angles;
    x = new_angles[0] - movement[0];
    y = new_angles[1] - movement[1];

    if(x < -4.5)
      x = -4.5;

    if(x > 6)
      x = 6;

    if(y > 19)
      y = 19;

    if(y < -1.5)
      y = -1.5;

    new_angles = (x, y, 0);
    self.angles = new_angles;
    wait 0.01;
    iprintlnbold(new_angles[0] + " " + new_angles[1]);
  }
}

karma_vitals_cam(localclientnum, set, newent) {
  if(set)
    start_karma_vitals_cam(localclientnum);
  else
    stop_karma_vitals_cam(localclientnum);
}

start_karma_vitals_cam(localclientnum) {
  if(!level.extracamactive) {
    level.extracamactive = 1;
    init_crosshair_material();
    self linktocamera();
    self isextracam(localclientnum);
    start_sw_cam(0.3, 0.2, 0.2);
    level.extracam_required_fov = 7;
    current_fov = level.extracam_required_fov;
    setextracamfov(localclientnum, current_fov);
    min_zoomed_in_time = 1.0;
    fov_inc = 3.2;
    level.zoomed_in_start_time = -10000;

    while(level.extracamactive) {
      required_fov = level.extracam_required_fov;

      if(current_fov != required_fov) {
        if(current_fov < required_fov) {
          time = getrealtime();
          dt = (time - level.zoomed_in_start_time) / 1000;

          if(dt > min_zoomed_in_time) {
            current_fov = current_fov + fov_inc;

            if(current_fov >= required_fov)
              current_fov = required_fov;
          }
        }

        if(current_fov > required_fov) {
          current_fov = current_fov - fov_inc;

          if(current_fov <= required_fov)
            current_fov = required_fov;
        }

        setextracamfov(localclientnum, current_fov);
      }

      wait 0.01;
    }
  }
}

stop_karma_vitals_cam(localclientnum) {
  if(level.extracamactive) {
    fade_out_sw_extra_cam(1.0, 1.0, 3.0);
    wait 5;
    stopextracam(localclientnum);
    level.extracamactive = 0;
    stop_sw_cam();
  }
}

start_sw_cam(fade_in_time, hold_static_time, static_time) {
  level.localplayers[0] set_filter_pass_enabled(level.pip_filterid, level.pip_passid, 1);
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, level.pip_opacity);
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 1, level.pip_squash);

  if(!isDefined(fade_in_time))
    fade_in_time = 2.0;

  if(!isDefined(hold_static_time))
    hold_static_time = 0.6;

  if(!isDefined(static_time))
    static_time = 2.2;

  level thread fade_in_sw_extra_cam(fade_in_time, hold_static_time, static_time);
}

stop_sw_cam() {
  level.localplayers[0] set_filter_pass_enabled(level.pip_filterid, level.pip_passid, 0);
}

fade_in_sw_extra_cam(fade_in_time, hold_static_time, static_time) {
  level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, 0.01);
  alpha = 0;
  fuzz = 0.01;
  time = 0;
  start_time = getrealtime();

  while(time < fade_in_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > fade_in_time)
      time = fade_in_time;

    alpha = 1.0 - (fade_in_time - time) / fade_in_time;
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }

  wait(hold_static_time);
  time = 0;
  start_time = getrealtime();

  while(time < static_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > static_time)
      time = static_time;

    frac = 1.0 - (static_time - time) / static_time;
    fuzz = 0.85 * frac;
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }
}

fade_out_sw_extra_cam(fade_out_time, hold_static_time, static_time) {
  alpha = 1.0;
  fuzz = 1.0;
  time = 0;
  start_time = getrealtime();

  while(time < static_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > static_time)
      time = static_time;

    frac = (static_time - time) / static_time;
    fuzz = frac;

    if(fuzz < 0.01)
      fuzz = 0.01;

    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }

  wait(hold_static_time);
  time = 0;
  start_time = getrealtime();

  while(time < fade_out_time) {
    time = (getrealtime() - start_time) / 1000;

    if(time > fade_out_time)
      time = fade_out_time;

    alpha = (fade_out_time - time) / fade_out_time;
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 0, alpha);
    level.localplayers[0] set_filter_pass_constant(level.pip_filterid, level.pip_passid, 2, fuzz);
    wait 0.01;
  }
}

fov_listener(str_msg, n_fov) {
  while(true) {
    level waittill(str_msg);
    setextracamfov(0, n_fov);
  }
}