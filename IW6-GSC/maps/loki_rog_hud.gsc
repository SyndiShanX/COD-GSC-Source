/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_rog_hud.gsc
*****************************************************/

section_precache() {
  precacheshader("hud_rog_target_big_g");
  precacheshader("hud_rog_target_big_r");
  precacheshader("hud_rog_target_building_g");
  precacheshader("hud_rog_target_building_r");
  precacheshader("hud_rog_target_g");
  precacheshader("hud_rog_target_r");
  precacheshader("overlay_static");
  precacheshader("hud_rog_altimeter_pip");
  precacheshader("hud_rog_altimeter_ruler");
  precacheshader("hud_rog_compass_a");
  precacheshader("hud_rog_compass_b");
  precacheshader("hud_rog_cross_grid");
  precacheshader("hud_rog_fluff_0");
  precacheshader("hud_rog_fluff_1");
  precacheshader("hud_rog_fluff_2");
  precacheshader("hud_rog_fluff_3");
  precacheshader("hud_rog_fluff_bot");
  precacheshader("hud_rog_frame_bottom");
  precacheshader("hud_rog_frame_top");
  precacheshader("hud_rog_link_icon");
  precacheshader("hud_rog_link_no_icon");
  precacheshader("hud_rog_message_box");
  precacheshader("hud_rog_overlay");
  precacheshader("hud_rog_status_box");
}

rog_hud() {
  loadluifile("LUI.sp_hud.loki");
  level.player setclientomnvar("ui_loki_rog", 1);
  level.player setclientomnvar("ui_loki_rog_section", 0);
  level.player setclientomnvar("ui_loki_rog_message", 1);
  level.player thread rog_hud_handle_message_updates();
  level.player thread rog_hud_handle_altitude_updates();
  level.player thread rog_hud_handle_impact_updates();
  level waittill("ROG_end");
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  setsaveddvar("hud_showStance", 1);
}

rog_hud_handle_message_updates() {
  level endon("ROG_end");

  for(;;) {
    level waittill("ROG_can_fire");

    if(common_scripts\utility::flag("ROG_can_fire")) {
      level.player setclientomnvar("ui_loki_rog_message", 0);
      level.player setclientomnvar("ui_loki_rog_message_progress", 0.0);
      continue;
    }

    level.player setclientomnvar("ui_loki_rog_message", 1);
  }
}

rog_hud_handle_altitude_updates() {
  level endon("ROG_end");
  var_0 = 0;

  for(var_1 = [13.25, 9.3, 5.65, 14.05, 45.55]; 1 && var_0 < var_1.size; var_0++) {
    level waittill("rog_uav_ascending");
    level.player setclientomnvar("ui_loki_rog_altitude", var_1[var_0] - 0.75);
  }
}

rog_hud_handle_impact_updates() {
  level endon("ROG_end");

  for(;;) {
    level waittill("ROG_locked_in");
    level.player setclientomnvar("ui_loki_rog_locked_in", 1);
  }
}

static_flash(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0; var_2++) {
    level.player setclientomnvar("ui_loki_rog_static", 1);

    if(isDefined(var_1))
      level.player thread maps\_utility::play_sound_on_entity(var_1);

    wait 0.1;
    level.player setclientomnvar("ui_loki_rog_static", 0);
    wait 0.2;
  }
}

uav_static_lines(var_0) {
  level endon("slamzoom_start");

  if(!isDefined(level.uav_static_lines))
    level.uav_static_lines = [];

  var_1 = newhudelem();
  var_1.alpha = 1;
  var_1.sort = -50;
  var_1.x = -530;
  var_1.y = 0;
  var_1.hidewheninmenu = 0;
  var_1.hidewhendead = 1;
  var_1 thread random_line_flicker();

  if(var_0)
    level maps\_utility::delaythread(2.0, ::remove_static_line, var_1);

  level.uav_static_lines[level.uav_static_lines.size] = var_1;
}

remove_static_line(var_0) {
  var_0 notify("stop_static");
  level.uav_static_lines = common_scripts\utility::array_remove(level.uav_static_lines, var_0);
  var_0 destroy();
}

remove_all_static_lines() {
  foreach(var_1 in level.uav_static_lines)
  var_1 destroy();
}

random_line_flicker() {
  self endon("stop_static");
  self endon("death");

  for(;;) {
    var_0 = randomfloatrange(0.05, 0.08);
    var_1 = randomfloatrange(0.1, 0.8);
    self fadeovertime(var_0);
    self.alpha = var_1;
    childthread random_line_placement();
    childthread random_shader_cycling();
    wait(var_0);

    if(randomint(100) > 50) {
      var_0 = randomfloatrange(0.25, 0.4);
      self fadeovertime(var_0);
      self.alpha = 0;
      self notify("turn_off");
      wait(var_0);
    }
  }
}

random_shader_cycling() {
  self endon("turn_off");
  var_0 = 180;
  var_1 = randomfloatrange(0.1, 0.65);

  for(;;) {
    self setshader(common_scripts\utility::random(level.static_lines), 1280, int(var_0 * var_1));
    wait 0.05;
  }
}

random_line_placement() {
  self endon("turn_off");

  for(;;) {
    var_0 = randomintrange(10, 640);
    self.y = var_0;
    wait(randomfloatrange(0.05, 0.4));
  }
}