/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\war_room_util.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_endmission;

holo_table_system_init() {
  flag_init("allow_holo_table_input");
}

rotate_indefinitely(rotate_time, rotate_fwd) {
  if(!isDefined(rotate_time))
    rotate_time = 45;

  if(!isDefined(rotate_fwd))
    rotate_fwd = 1;

  self endon("stop_spinning");
  self endon("death");
  self endon("delete");

  while(true) {
    if(rotate_fwd)
      self rotateyaw(360, rotate_time, 0, 0);
    else
      self rotateyaw(-360, rotate_time, 0, 0);

    wait(rotate_time - 0.1);
  }
}

holo_table_rotate() {
  self endon("stop_holo_table");

  while(true) {
    self.e_origin rotateyaw(360, 60.0, 0, 0);
    wait(60.0 - 0.1);
  }
}

holo_table_get_selected_struct(str_holo_table) {
  e_table = level.holo_tables[str_holo_table];
  return e_table.poi_list[e_table.cur_poi_index];
}

holo_table_run_poi(allow_player_input) {
  self endon("stop_holo_table");

  if(self.poi_list.size <= 1) {
    return;
  }
  if(allow_player_input) {
    while(true) {
      while(distancesquared(level.player.origin, self.e_origin.origin) > 16384)
        wait_network_frame();

      while(distancesquared(level.player.origin, self.e_origin.origin) <= 16384) {
        index_change = 0;

        if(level.player buttonpressed("DPAD_LEFT"))
          index_change = -1;
        else if(level.player buttonpressed("DPAD_RIGHT"))
          index_change = 1;

        if(index_change != 0 && flag("allow_holo_table_input"))
          holo_table_change_poi(index_change, 0.5, 1);

        wait_network_frame();
      }
    }
  } else {
    while(true) {
      self holo_table_change_poi(1);
      wait 24.0;
    }
  }
}

holo_table_run(allow_player_input) {
  self notify("stop_holo_table");
  self.display linkto(self.e_origin);
  self thread holo_table_rotate();
  self thread holo_table_run_poi(allow_player_input);
}

holo_table_render_pois() {
  self endon("stop_holo_table");

  while(true) {
    fvec = anglestoforward(self.display.angles);
    rvec = anglestoright(self.display.angles);

    if(isDefined(self.cur_poi_index)) {
      foreach(s_poi in self.poi_list) {
        poi = s_poi.offset;
        world_offset = rvec * poi[0] + fvec * poi[1];
        world_pos = self.display.origin + world_offset;

        if(s_poi == self.poi_list[self.cur_poi_index]) {
          draw_arrow_time(world_pos, self.display.origin, (1, 0, 0), 0.1);
          continue;
        }

        draw_arrow_time(world_pos, self.display.origin, vectorscale((1, 1, 1), 0.5), 0.1);
      }
    }

    wait 0.05;
  }

}

holo_table_change_poi(n_index_change, move_time_s, display_level_name) {
  if(!isDefined(move_time_s))
    move_time_s = 2.0;

  if(!isDefined(display_level_name))
    display_level_name = 0;

  if(!isDefined(self.cur_poi_index))
    self.cur_poi_index = 0;
  else {
    n_index_change = n_index_change % self.poi_list.size;
    self.cur_poi_index = (self.cur_poi_index + n_index_change + self.poi_list.size) % self.poi_list.size;
  }

  s_poi = self.poi_list[self.cur_poi_index];
  v_poi_offset = s_poi.offset;
  fvec = anglestoforward(self.display.angles);
  rvec = anglestoright(self.display.angles);
  world_offset = rvec * v_poi_offset[0] + fvec * v_poi_offset[1];
  world_rotate_pos = self.e_origin.origin - world_offset;
  self.display unlink();
  self.display moveto(world_rotate_pos, move_time_s, 0, 0);
  wait(move_time_s + 0.1);
  self.display linkto(self.e_origin);
}

holo_table_get_table(str_hologram) {
  return level.holo_tables[str_hologram];
}

holo_table_initialize(str_hologram, str_map_center_origin) {
  holo_table = spawnstruct();
  display = getent(str_hologram, "targetname");
  display.v_start_org = display.origin;
  display.v_start_ang = display.angles;
  display.n_start_scale = 0.1;
  holo_table.display = display;
  holo_table.e_origin = getent(str_map_center_origin, "targetname");
  holo_table.e_origin.origin = (holo_table.e_origin.origin[0], holo_table.e_origin.origin[1], display.origin[2]);
  holo_table.poi_list = [];

  if(isDefined(holo_table.e_origin.target)) {
    s_poi_list = getstructarray(holo_table.e_origin.target);

    foreach(s_poi in s_poi_list) {
      fvec = anglestoforward(holo_table.display.angles);
      rvec = anglestoright(holo_table.display.angles);
      x_val = vectordot(s_poi.origin - holo_table.display.origin, rvec);
      y_val = vectordot(s_poi.origin - holo_table.display.origin, fvec);
      s_poi.offset = (x_val, y_val, 0);
      arrayinsert(holo_table.poi_list, s_poi, 0);
    }
  } else {
    holo_table.poi_list[0] = spawnstruct();
    holo_table.poi_list[0].origin = (0, 0, 0);
  }

  if(!isDefined(level.holo_tables))
    level.holo_tables = [];

  level.holo_tables[str_hologram] = holo_table;
  return display;
}

holo_table_boot_sequence(allow_player_input) {
  self.display holo_table_reset_display();

  for(i = 0; i < 3; i++) {
    self.display show();
    wait 0.1;
    self.display hide();
    wait 0.1;
  }

  self.display show();
  self.display holo_table_scale_overtime(2);
  self thread holo_table_run(allow_player_input);
}

holo_table_scale_overtime(n_time, str_display_name) {
  if(!isDefined(str_display_name))
    str_display_name = undefined;

  model = self;

  if(isDefined(str_display_name))
    model = getent(str_display_name, "targetname");

  model setscale(self.n_start_scale);
  model show();
  incs = n_time / 0.05;
  inc_size = (1.0 - self.n_start_scale) / incs;

  for(i = 0; i < incs; i++) {
    model.n_cur_scale = model.n_cur_scale + inc_size;
    model setscale(self.n_cur_scale);
    wait 0.05;
  }

  model setscale(1.0);
}

holo_table_scale_overtime_reverse(n_time, str_display_name, hide_after) {
  if(!isDefined(str_display_name))
    str_display_name = undefined;

  if(!isDefined(hide_after))
    hide_after = 0;

  model = self;

  if(!isDefined(self.n_cur_scale)) {
    return;
  }
  if(self.n_cur_scale <= 0.1) {
    return;
  }
  if(isDefined(str_display_name))
    model = getent(str_display_name, "targetname");

  incs = n_time / 0.05;
  inc_size = (1.0 - self.n_start_scale) / incs;

  for(i = 0; i < incs; i++) {
    model.n_cur_scale = model.n_cur_scale - inc_size;
    model setscale(self.n_cur_scale);
    wait 0.05;
  }

  model setscale(self.n_start_scale);

  if(is_true(hide_after))
    model hide();
}

holo_table_reset_display() {
  self.origin = self.v_start_org;
  self.angles = self.v_start_ang;
  self.n_cur_scale = self.n_start_scale;
  self setscale(self.n_start_scale);
  self hide();
}

set_world_map_tint(territory_index, value) {
  territory_index = clamp(territory_index, 0, 5);
  rpc("clientscripts/frontend", "set_world_map_tint", territory_index, value);
}

set_world_map_widget(territory_index, widget_on) {
  value = 0;

  if(widget_on)
    value = 1;

  territory_index = clamp(territory_index, 0, 5);
  rpc("clientscripts/frontend", "toggle_world_map_widget", territory_index, value);
}

set_world_map_marker(territory_index, marker_on) {
  value = 0;

  if(marker_on)
    value = 1;

  territory_index = clamp(territory_index, 0, 5);
  rpc("clientscripts/frontend", "toggle_world_map_marker", territory_index, value);
}

set_world_map_translation(x, y) {
  rpc("clientscripts/frontend", "set_world_map_translation", x, y);
}

set_world_map_rotation(theta) {
  rpc("clientscripts/frontend", "set_world_map_rotation", theta);
}

set_world_map_scale(scale) {
  rpc("clientscripts/frontend", "set_world_map_scale", scale);
}

set_world_map_icon(icon_index) {
  icon_index = clamp(icon_index, 0, 6);
  rpc("clientscripts/frontend", "set_world_map_icon", icon_index);
}

world_map_zoom_to(x, y, scale) {
  rpc("clientscripts/frontend", "world_map_translate_to", 0, x, y, scale);
}

war_map_blink_country(territory_index, blink_color, end_blink_notify) {
  assert(isDefined(territory_index));

  if(isDefined(end_blink_notify))
    level endon(end_blink_notify);

  blink_on = 1;

  while(true) {
    cur_color = 4;

    if(blink_on)
      cur_color = blink_color;

    set_world_map_tint(territory_index, cur_color);
    refresh_war_map_shader();
    blink_on = !blink_on;
    wait 0.2;
  }
}

refresh_war_map_shader() {
  rpc("clientscripts/frontend", "refresh_all_map_shaders", 0);
}

script_model_blink_on() {
  for(i = 0; i < 3; i++) {
    self show();
    wait 0.2;
    self hide();
    wait 0.2;
  }

  self show();
}

holo_table_prop_blink_on(off_after_seconds) {
  if(!isDefined(off_after_seconds))
    off_after_seconds = undefined;

  for(i = 0; i < 4; i++) {
    self setclientflag(14);
    wait 0.2;
    self clearclientflag(14);
    wait 0.2;
  }

  self setclientflag(14);

  if(isDefined(off_after_seconds)) {
    wait(off_after_seconds);
    self clearclientflag(14);
  }
}

holo_table_exploder_switch(exploder_num) {
  if(!isDefined(exploder_num))
    exploder_num = undefined;

  if(isDefined(level.m_table_exploder))
    level thread stop_exploder(level.m_table_exploder);

  if(isDefined(exploder_num))
    level thread exploder(exploder_num);

  level.m_table_exploder = exploder_num;
}

holo_table_feature_prop(model_name, done_notify, scale, map_objective_list, v_offset, str_targetname, b_spin) {
  if(!isDefined(scale))
    scale = 1.0;

  if(!isDefined(map_objective_list))
    map_objective_list = undefined;

  if(!isDefined(v_offset))
    v_offset = (0, 0, 0);

  if(!isDefined(str_targetname))
    str_targetname = "holo_prop";

  if(!isDefined(b_spin))
    b_spin = 1;

  self endon("death");
  rotate_time = 60.0;
  rotate_fwd = 0;
  extra_spin = (0, 0, 0);

  if(issubstr(model_name, "zhao")) {
    extra_spin = vectorscale((0, 1, 0), 90.0);
    holo_table_exploder_switch(114);
    rotate_time = 120.0;
    rotate_fwd = 1;
  }

  if(isDefined(map_objective_list)) {
    foreach(e_obj in map_objective_list) {
      e_obj play_fx("fx_briefing_objective", e_obj.origin, e_obj.angles, "obj_done", 1, "tag_origin");
      e_obj thread holo_table_prop_blink_on();
    }
  }

  e_spin = getent("holo_table_spin", "targetname");
  e_model = spawn_model(model_name, e_spin.origin + v_offset, e_spin.angles + extra_spin);

  if(!isDefined(b_spin) || isDefined(b_spin) && b_spin)
    e_model thread rotate_indefinitely(rotate_time, rotate_fwd);

  e_model setscale(scale);
  e_model.targetname = str_targetname;
  e_model ignorecheapentityflag(1);
  e_model setclientflag(15);

  if(!issubstr(model_name, "zhao"))
    e_model setclientflag(14);

  level waittill(done_notify);

  if(isDefined(map_objective_list)) {
    foreach(e_obj in map_objective_list) {
      e_obj clearclientflag(14);
      e_obj notify("obj_done");
    }
  }

  e_model clearclientflag(15);
}