/***************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: common_scripts\_ca_beautiful_corner.gsc
***************************************************/

initialize() {
  if(getdvar("beautiful_corner") != "1") {
    cleanup();
    return 0;
  }

  level.beautiful_views = [];
  level.beautiful_visions = [];
  level.beautiful_lightsets = [];
  level.beautiful_cluts = [];
  level.beautiful_dof = [];
  level.beautiful_view_static = 1;
  level.beautiful_view_index = 0;
  level.beautiful_weapon = undefined;
  return 1;
}

activate() {
  thread beautiful_player();
  thread beautiful_guys();
  thread beautiful_views();
}

cleanup() {
  var_0 = getentarray("beautiful_guy", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();
}

beautiful_player() {
  level.player takeallweapons();
  level.player disableoffhandweapons();

  if(isdefined(level.beautiful_weapon)) {
    level.player giveweapon(level.beautiful_weapon);
    level.player switchtoweapon(level.beautiful_weapon);
  }

  level.player thread beautiful_player_ammo();
  level.friendlyfiredisabled = 1;
  level.player enableinvulnerability();
}

beautiful_player_ammo() {
  var_0 = self getweaponslistall();
  self.maintain_stock = [];

  foreach(var_2 in var_0) {
    if(!isdefined(self.maintain_stock[var_2]))
      self.maintain_stock[var_2] = self getweaponammostock(var_2);
  }

  for (;;) {
    foreach(var_2 in var_0)
    self setweaponammostock(var_2, self.maintain_stock[var_2]);

    wait 1;
  }
}

beautiful_guys() {
  var_0 = getentarray("beautiful_guy", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 maps\_shg_design_tools::actual_spawn();

    if(!isdefined(var_3)) {
      return;
    }
    var_3 maps\_utility::make_hero();
    var_3 maps\_utility::ai_ignore_everything();
    var_3 maps\_utility::magic_bullet_shield();
    var_3.script_friendname = "none";

    if(isdefined(level.beautiful_weapon))
      var_3 maps\_utility::forceuseweapon(level.beautiful_weapon, "primary");

    if(isdefined(var_2.script_noteworthy)) {
      var_3.animname = "beautiful_guy";
      var_3 thread maps\_anim::anim_loop_solo(var_3, var_2.script_noteworthy, undefined, "stop_idle");
    }
  }
}

beautiful_views() {
  beautiful_view_origin_offsets();
  beautiful_view_init();
  thread beautiful_view_move_request();
  thread beautiful_view_state_request();
}

beautiful_view_origin_offsets() {
  var_0 = [0.0, 0.0, -60.0];

  foreach(var_2 in level.beautiful_views) {
    var_3 = getent(var_2, "targetname");
    beautiful_offset_view_origin(var_3, var_0);
    var_4 = getent(var_2 + "_static", "targetname");
    beautiful_offset_view_origin(var_4, var_0);
  }
}

beautiful_offset_view_origin(var_0, var_1) {
  if(!isdefined(var_0)) {
    return;
  }
  if(!isdefined(var_0.script_noteworthy)) {
    return;
  }
  if(var_0.script_noteworthy != "view_pos") {
    return;
  }
  var_2 = spawnstruct();
  var_2.entity = var_0;
  var_2.forward = var_1[0];
  var_2.right = var_1[1];
  var_2.up = var_1[2];
  var_2 maps\_utility::translate_local();
}

beautiful_view_init() {
  if(level.beautiful_views.size <= 0) {
    return;
  }
  common_scripts\utility::flag_init("beautiful_view_transitioning");
  common_scripts\utility::flag_clear("beautiful_view_transitioning");
  level.black_overlay = maps\_hud_util::create_client_overlay("black", 1);
  level.black_overlay.sort = 1000;
  level.player takeweapon("beretta");
  level.player takeweapon("fraggrenade");
  level.player takeweapon("flash_grenade");
  beautiful_view_position(level.beautiful_views[level.beautiful_view_index]);
  wait 0.05;
  setsaveddvar("compass", "0");
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("hud_showStance", "0");
  setsaveddvar("actionSlotsHide", "1");
  wait 0.5;
  level.player disableweapons();
  level.player freezecontrols(1);
  wait 1.0;
  beautiful_view_fade_in();
}

beautiful_view_move_request() {
  for (;;) {
    while (!(level.player buttonpressed("DPAD_UP") || level.player buttonpressed("HOME")))
      wait 0.05;

    if(!common_scripts\utility::flag("beautiful_view_transitioning")) {
      beautiful_view_get_next_position();
      beautiful_view_update(level.beautiful_views[level.beautiful_view_index]);
    }

    wait 0.05;
  }
}

beautiful_view_get_next_position() {
  for (var_0 = undefined; !isdefined(var_0); var_0 = getent(var_1, "targetname")) {
    level.beautiful_view_index++;

    if(level.beautiful_view_index >= level.beautiful_views.size)
      level.beautiful_view_index = 0;

    var_1 = level.beautiful_views[level.beautiful_view_index];

    if(level.beautiful_view_static)
      var_1 = var_1 + "_static";
  }
}

beautiful_view_state_request() {
  for (;;) {
    while (!(level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("END")))
      wait 0.05;

    if(!common_scripts\utility::flag("beautiful_view_transitioning")) {
      level.beautiful_view_static = !level.beautiful_view_static;
      beautiful_view_update(level.beautiful_views[level.beautiful_view_index]);
    }

    wait 0.05;
  }
}

beautiful_view_update(var_0) {
  common_scripts\utility::flag_set("beautiful_view_transitioning");
  beautiful_view_fade_out();
  beautiful_view_position(var_0);
  wait 0.25;
  beautiful_view_fade_in();
  wait 0.25;
  common_scripts\utility::flag_clear("beautiful_view_transitioning");
}

beautiful_view_fade_in() {
  wait 0.1;
  level.black_overlay fadeovertime(0.3);
  level.black_overlay.alpha = 0;

  if(!level.beautiful_view_static)
    level.player enableweapons();

  wait 0.3;

  if(!level.beautiful_view_static)
    level.player freezecontrols(0);

  level.player hidehud();
}

beautiful_view_fade_out() {
  level.player showhud();
  level.player setstance("stand");
  level.black_overlay fadeovertime(0.3);
  level.black_overlay.alpha = 1;
  level.player disableweapons();
  wait 0.3;
  level.player freezecontrols(1);
  wait 0.1;
}

beautiful_view_position(var_0) {
  if(level.beautiful_visions[var_0] != "")
    maps\_utility::vision_set_fog_changes(level.beautiful_visions[var_0], 0);

  if(level.beautiful_lightsets[var_0] != "")
    level.player lightsetforplayer(level.beautiful_lightsets[var_0]);

  if(level.beautiful_cluts[var_0] != "")
    level.player setclutforplayer(level.beautiful_cluts[var_0], 0);

  if(level.beautiful_view_static && isdefined(level.beautiful_dof[var_0])) {
    var_1 = level.beautiful_dof[var_0];
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield(var_1["fstop"], var_1["focus_distance"], var_1["focus_speed"], var_1["aperture_speed"]);
  } else
    level.player disablephysicaldepthoffieldscripting();

  level.player setstance("stand");

  if(level.beautiful_view_static)
    beautiful_view_position_static(var_0 + "_static");
  else
    beautiful_view_position_dynamic(var_0);
}

beautiful_view_position_dynamic(var_0) {
  level.player unlink();
  var_1 = getent(var_0, "targetname");

  if(!isdefined(var_1)) {
    return;
  }
  level.player setorigin(var_1.origin);
  level.player setplayerangles(var_1.angles);
}

beautiful_view_position_static(var_0) {
  level.player unlink();
  var_1 = getent(var_0, "targetname");

  if(!isdefined(var_1)) {
    return;
  }
  if(!isdefined(level.beautiful_view_ent))
    level.beautiful_view_ent = common_scripts\utility::spawn_tag_origin();

  level.beautiful_view_ent.origin = var_1.origin;
  level.beautiful_view_ent.angles = var_1.angles;
  level.player setorigin(level.beautiful_view_ent.origin);
  level.player setplayerangles(level.beautiful_view_ent.angles);
  level.player playerlinktoabsolute(level.beautiful_view_ent, "tag_origin");
}