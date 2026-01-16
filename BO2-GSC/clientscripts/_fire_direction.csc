/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_fire_direction.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;

init() {
  level.grid_shader_enabled = 0;
  waitforclient(0);
  clientscripts\_filter::init_filter_hud_projected_grid(level.localplayers[0]);
  clientscripts\_filter::init_filter_hud_projected_grid_haiti(level.localplayers[0]);
  register_clientflag_callback("scriptmover", 10, ::set_shader_position);
  thread toggle_grid_shader_drone();
  thread toggle_grid_shader_god_rod();
}

toggle_grid_shader_drone() {
  level endon("_fire_direction_kill");

  while(true) {
    level waittill("grid_shader_on");
    grid_shader_enable_drone();
    level waittill("grid_shader_off");
    grid_shader_disable_drone();
  }
}

grid_shader_enable_drone() {
  clientscripts\_filter::enable_filter_hud_projected_grid(level.localplayers[0], 0);
  clientscripts\_filter::set_filter_hud_projected_grid_radius(level.localplayers[0], 0, 240);
  level.grid_shader_enabled = 1;

  if(level.wiiu)
    setsaveddvar("wiiu_disableYellowDot", 1);
}

grid_shader_disable_drone() {
  clientscripts\_filter::disable_filter_hud_projected_grid(level.localplayers[0], 0);
  level.grid_shader_enabled = 0;

  if(level.wiiu)
    setsaveddvar("wiiu_disableYellowDot", 0);
}

toggle_grid_shader_god_rod() {
  level endon("_fire_direction_kill");

  while(true) {
    level waittill("grid_shader_on_god_rod");
    grid_shader_enable_god_rod();
    level waittill("grid_shader_off_god_rod");
    grid_shader_disable_god_rod();
  }
}

grid_shader_enable_god_rod() {
  clientscripts\_filter::enable_filter_hud_projected_grid_haiti(level.localplayers[0], 0);
  clientscripts\_filter::set_filter_hud_projected_grid_radius(level.localplayers[0], 0, 240);
  level.grid_shader_enabled = 1;
}

grid_shader_disable_god_rod() {
  clientscripts\_filter::disable_filter_hud_projected_grid(level.localplayers[0], 0);
  level.grid_shader_enabled = 0;
}

set_shader_position(localclientnum, set, newent) {
  level endon("_fire_direction_kill");
  self endon("entity_shutdown");
  level.fire_direction_shader_on = 1;

  while(level.fire_direction_shader_on) {
    if(isDefined(self)) {
      n_dist = distance(level.localplayers[0].origin, self.origin);
      set_filter_hud_projected_grid_position(level.localplayers[0], 0, n_dist);
    }

    wait 0.01;
  }
}