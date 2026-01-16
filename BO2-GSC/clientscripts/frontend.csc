/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\frontend.csc
**************************************/

#include clientscripts\_callbacks;
#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\frontend_menu;
#include clientscripts\_qrcode;
#include clientscripts\frontend_fx;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\frontend_amb;

main() {
  clientscripts\frontend_fx::main();
  level.m_map_monitors = [];
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\frontend_amb::main();
  waitforclient(0);
  default_settings();
  frontend_menu_init();
  register_clientflag_callback("scriptmover", 12, ::world_clock_run);
  register_clientflag_callback("scriptmover", 13, ::map_monitor_run);
  register_clientflag_callback("scriptmover", 14, ::set_hologram_red);
  register_clientflag_callback("scriptmover", 15, ::set_hologram_shown);
  register_clientflag_callback("vehicle", 11, ::set_speeding_osprey);
  start_env_movie();
  level.world_map = spawnstruct();
  level.world_map.transform = array(0, 0, 0, 1.0);
  level.world_map.tint = array(0, 0, 0, 0, 0, 0);
  level.world_map.marker_toggle = array(0, 0, 0, 0, 0, 0);
  level.world_map.widget_toggle = array(0, 0, 0, 0, 0, 0);
  level.world_map.main_icon = 6;

  println("*** Client : frontend is running...");
}

stop_env_movie() {
  if(isDefined(level.screen_bink)) {
    stopbink(level.screen_bink);
    level.screen_bink = undefined;
  }
}

start_env_movie() {
  level.screen_bink = playbink("frontend_screen", 2);
}

world_clock_get_offset() {
  if(issubstr(self.model, "chicago"))
    return -6;
  else if(issubstr(self.model, "los_angeles"))
    return -8;
  else if(issubstr(self.model, "new_york"))
    return -5;
  else if(issubstr(self.model, "tokyo"))
    return 9;
  else if(issubstr(self.model, "hong_kong"))
    return 8;

  return 0;
}

world_clock_run(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  gmt_offset = self world_clock_get_offset();

  if(isDefined(self.script_noteworthy))
    println("Client: clock digit running: " + self.script_noteworthy);

  while(true) {
    curr_time = getsystemtime(1);
    hours = int(curr_time[0]);
    minutes = int(curr_time[1]);
    seconds = int(curr_time[2]);
    hours = hours + gmt_offset;

    if(hours < 0)
      hours = hours + 24;
    else if(hours >= 24)
      hours = hours - 24;

    time = array(floor(hours / 10), hours % 10, floor(minutes / 10), minutes % 10);

    for(i = 0; i < time.size; i++)
      time[i] = float(int(time[i] + 9) % 10);

    self setshaderconstant(localclientnum, 0, time[0], time[1], time[2], time[3]);
    wait 1.0;
  }
}

refresh_map_shaders(localclientnum) {
  self setshaderconstant(localclientnum, 0, level.world_map.transform[0], level.world_map.transform[1], level.world_map.transform[2], level.world_map.transform[3]);
  self setshaderconstant(localclientnum, 1, level.world_map.tint[0], level.world_map.tint[1], level.world_map.tint[2], level.world_map.tint[3]);
  self setshaderconstant(localclientnum, 2, level.world_map.tint[4], level.world_map.tint[5], level.world_map.marker_toggle[0], level.world_map.marker_toggle[1]);
  self setshaderconstant(localclientnum, 3, level.world_map.marker_toggle[2], level.world_map.marker_toggle[3], level.world_map.marker_toggle[4], level.world_map.marker_toggle[5]);
  self setshaderconstant(localclientnum, 4, level.world_map.widget_toggle[0], level.world_map.widget_toggle[1], level.world_map.widget_toggle[2], level.world_map.widget_toggle[3]);
  self setshaderconstant(localclientnum, 5, level.world_map.widget_toggle[4], level.world_map.widget_toggle[5], level.world_map.main_icon, 0);
}

refresh_all_map_shaders(localclientnum) {
  foreach(map in level.m_map_monitors)
  map refresh_map_shaders(localclientnum);
}

map_monitor_run(localclientnum, set, newent) {
  if(set) {
    if(!isDefined(self.shader_inited)) {
      self mapshaderconstant(localclientnum, 0, "ScriptVector0");
      self mapshaderconstant(localclientnum, 1, "ScriptVector1");
      self mapshaderconstant(localclientnum, 2, "ScriptVector2");
      self mapshaderconstant(localclientnum, 3, "ScriptVector3");
      self mapshaderconstant(localclientnum, 4, "ScriptVector4");
      self mapshaderconstant(localclientnum, 5, "ScriptVector5");

      if(!isDefined(level.m_map_monitors))
        level.m_map_monitors = [];

      level.m_map_monitors[level.m_map_monitors.size] = self;
    }

    self refresh_map_shaders(localclientnum);
  }
}

set_world_map_tint(index, tint_type_index) {
  level.world_map.tint[index] = tint_type_index;
}

toggle_world_map_widget(index, toggle_on) {
  level.world_map.widget_toggle[index] = toggle_on;
}

toggle_world_map_marker(index, toggle_on) {
  level.world_map.marker_toggle[index] = toggle_on;
}

set_world_map_icon(icon_index) {
  level.world_map.main_icon = icon_index;
}

set_world_map_translation(x, y) {
  level.world_map.transform[0] = x;
  level.world_map.transform[1] = y;
}

set_world_map_rotation(theta) {
  level.world_map.transform[2] = theta;
}

set_world_map_scale(scale) {
  level.world_map.transform[3] = scale;
}

world_map_translate_to(localclientnum, pos_x, pos_y, map_scale) {
  start_x = level.world_map.transform[0];
  start_y = level.world_map.transform[1];
  start_scale = level.world_map.transform[3];

  for(f = 0.0; f <= 1.0; f = f + 0.1) {
    level.world_map.transform[0] = lerpfloat(start_x, pos_x, f);
    level.world_map.transform[1] = lerpfloat(start_y, pos_y, f);
    level.world_map.transform[3] = lerpfloat(start_scale, map_scale, f);
    refresh_all_map_shaders(localclientnum);
    wait 0.01;
  }
}

set_speeding_osprey(localclientnum, set, newent) {
  if(set)
    self.booster_speed_override = 1200.0;
  else
    self.booster_speed_override = undefined;
}

initialize_hologram(localclientnum) {
  self.shader_inited = 1;
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  self setshaderconstant(localclientnum, 0, 1, 1, 1, 1);
  self.color_id = 0;
  self mapshaderconstant(localclientnum, 1, "ScriptVector1");
  self setshaderconstant(localclientnum, 1, 0, 0, 0, 0);
}

set_hologram_red(localclientnum, set, newent) {
  if(!isDefined(self.shader_inited))
    self initialize_hologram(localclientnum);

  if(set) {
    self setshaderconstant(localclientnum, 1, 1, 0, 0, 0);
    self.color_id = 1;
  } else {
    self setshaderconstant(localclientnum, 1, 0, 0, 0, 0);
    self.color_id = 0;
  }
}

set_hologram_shown(localclientnum, set, newent) {
  self endon("death");

  if(!isDefined(self.shader_inited))
    self initialize_hologram(localclientnum);

  start_val = 0.2;
  end_val = 1.0;

  if(set) {
    start_val = 1.0;
    end_val = 0.2;
  }

  for(f = 0.0; f <= 1.0; f = f + 0.02) {
    val = lerpfloat(start_val, end_val, f);
    self setshaderconstant(localclientnum, 1, self.color_id, val, 0, 0);
    wait 0.01;
  }

  if(set)
    self setshaderconstant(localclientnum, 1, self.color_id, 0, 0, 0);
  else
    self setshaderconstant(localclientnum, 1, self.color_id, 1, 0, 0);
}

default_settings() {
  setclientdvar("hud_showstance", 0);
  setclientdvar("compass", 0);
}

settrackinfoqrcode(index) {
  setup_qr_code("frontend", 3, index);
}