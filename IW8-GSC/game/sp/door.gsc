/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: game\sp\door.gsc
***********************************************/

init() {
  level.interactive_doors.snakecamvision = "snake_cam";
  level.interactive_doors.fndoorinit = ::_init_door_internal;
  precacheshader("nightvision_overlay_goggles_grain");
  precachemodel("offhand_wm_c4");
  scripts\engine\sp\utility::hudoutline_add_channel("snake_cam");
  scripts\engine\utility::flag_init("snakecam_allow_exit");
  scripts\engine\utility::flag_init("exit_snakecam_immediately");
  level.player scripts\engine\utility::ent_flag_init("using_snakecam");
  level._effect["c4_detonate"] = loadfx("vfx/iw8/weap/_explo/vfx_explo_frag_gren.vfx");
  level._effect["c4_light_green"] = loadfx("vfx/iw8/core/c4/vfx_c4_light_green.vfx");
  level._effect["c4_light_red"] = loadfx("vfx/iw8/core/c4/vfx_c4_light_red.vfx");
  level._effect["enemy_marker"] = loadfx("vfx/iw8/ui/vfx_ui_snakecam_enemy_marker.vfx");
}

_init_door_internal(var_0) {
  scripts\sp\door_internal::init_door_internal(var_0);
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(self.script_parameters)) {
    var_3 = strtok(self.script_parameters, " ");

    foreach(var_5 in var_3) {
      switch (var_5) {
        case "c4":
          var_1 = 1;
          self.c4_breachable = 0;
          break;
        case "snake_cam":
          var_2 = 1;
          self.cam_structs = [];
          self.snakecam_active = 0;
          break;
      }
    }
  }

  if(isDefined(var_1) || isDefined(var_2)) {
    var_7 = scripts\engine\utility::get_linked_structs();
    var_8 = [];

    foreach(var_10 in var_7) {
      if(isDefined(var_10.script_noteworthy)) {
        var_10.door = self;

        switch (var_10.script_noteworthy) {
          case "cam_hint":
            if(!isDefined(var_2)) {
              break;
            }

            if(!isDefined(var_10.radius))
              var_10.radius = 2.5;

            var_10 thread snake_cam_logic();
            self.cam_structs[self.cam_structs.size] = var_10;
            break;
          case "c4":
            if(!isDefined(var_1)) {
              break;
            }

            if(!isDefined(var_10.radius))
              var_10.radius = 2.5;

            var_8[var_8.size] = var_10;
            break;
        }
      }

      thread door_event_wait();
    }

    if(var_8.size > 0) {
      self.c4_struct = scripts\engine\utility::spawn_script_origin();
      self.c4_struct.origin = (0, 0, 0);
      self.c4_struct.radius = 0;
      self.c4_struct.door = self;

      if(isDefined(self.angles))
        self.c4_struct.angles = self.angles;
      else
        self.c4_struct.angles = (0, 0, 0);

      foreach(var_10 in var_8) {
        self.c4_struct.origin = self.c4_struct.origin + var_10.origin * (1 / var_8.size);
        self.c4_struct.radius = self.c4_struct.radius + var_10.radius * (1 / var_8.size);
      }

      self.c4_struct.breachpoints = var_8;
    }
  }

  if(!isDefined(self.script_spawn_open_yaw))
    thread scripts\sp\door_internal::cursor_hint_thread(::cursor_hints_game);
}

door_event_wait() {
  self notify("door_event_wait");
  self endon("door_event_wait");
  self endon("entitydeleted");

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("locked", "door_unlock", "unusable");

    if(var_0 == "locked") {
      thread enable_c4_on_locked();
      continue;
    }

    if(var_0 == "unusable") {
      thread remove_door_snake_cam_ability();
      thread remove_door_c4_ability();
      continue;
    }

    if(var_0 == "door_unlock")
      thread remove_door_c4_ability();
  }
}

enable_c4_on_locked() {
  self endon("stop_open_interact");

  if(!isDefined(self.c4_struct)) {
    return;
  }
  self.c4_struct thread c4_breach();
  self.open_struct scripts\sp\door::remove_open_interact_hint();
  self.c4_struct endon("c4_planted");

  while(distancesquared(level.player.origin, self.origin) < squared(200))
    waitframe();

  remove_door_c4_ability();
  self.open_struct scripts\engine\utility::delaythread(0.05, scripts\sp\door_internal::open_struct_logic);
}

cursor_hints_game() {
  if(self.prevplayeronright != self.playeronright) {
    if(isDefined(self.cam_structs)) {
      foreach(var_1 in self.cam_structs)
      scripts\sp\door_internal::adjust_cursor_hint_side(var_1);
    }

    if(isDefined(self.c4_struct))
      scripts\sp\door_internal::adjust_cursor_hint_side(self.c4_struct);
  }
}

set_snake_cam_ignore_ents(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  var_1 = self;
  var_2 = var_1.cam_structs[0];
  var_2.ignoremarkedents = var_0;
}

remove_from_snakecam_immediate() {
  if(!scripts\engine\utility::ent_flag("using_snakecam")) {
    return;
  }
  if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
    return;
  }
  scripts\engine\utility::flag_set("exit_snakecam_immediately");
  scripts\engine\utility::ent_flag_waitopen("using_snakecam");
  scripts\engine\utility::flag_clear("exit_snakecam_immediately");
}

set_snake_cam_vision(var_0) {
  if(!isDefined(var_0))
    var_0 = "snake_cam";

  level.interactive_doors.snakecamvision = var_0;

  if(level.player scripts\engine\utility::ent_flag("using_snakecam"))
    visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
}

remove_door_snake_cam_ability() {
  if(!isDefined(self.cam_structs)) {
    return;
  }
  foreach(var_1 in self.cam_structs) {
    if(isDefined(var_1)) {
      var_1 notify("stop_snake_cam");
      var_1 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
  }
}

snake_cam_logic() {
  self endon("stop_snake_cam");
  var_0 = anglestoup(self.angles * -1);
  var_1 = 0;
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 10), "Cam", undefined, 120 * level.interactive_doors.hint_dist_scale, 100 * level.interactive_doors.hint_dist_scale, 0);

  for(;;) {
    self waittill("trigger");
    self notify("stop_cursor_hint_thread");
    level.player scripts\engine\utility::ent_flag_set("using_snakecam");
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 0);

    if(level.player isnightvisionon()) {
      var_1 = 1;
      level.player nightvisiongogglesforceoff();
    }

    level.player scripts\engine\sp\utility::allow_nvg(0, "snakeCam", 1);

    if(isDefined(self.door))
      self.door.snakecam_active = 1;

    level.player modifybasefov(115, 0.4);
    level thread static_burst(0.1);
    level.player notify("enter_cam");
    level.player.og_origin = level.player.origin;
    level.player.og_angles = level.player getplayerangles();
    level.player.og_stance = level.player getstance();
    level.player freezecontrols(1);
    level.player disableweapons();

    if(scripts\engine\utility::flag_exist("hold_context_melee"))
      scripts\engine\utility::flag_set("hold_context_melee");

    level.player.ignore_stealth_sight = 1;
    level.player.ignoreme = 1;
    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.5);
    var_2 = anglesToForward(self.angles);
    var_3 = vectorNormalize(self.origin - level.player getorigin());
    var_4 = vectordot(var_2, var_3);
    var_5 = level.player scripts\engine\utility::spawn_tag_origin();
    var_5.origin = self.origin;
    var_5.angles = self.angles;

    if(isDefined(self.target)) {
      var_6 = scripts\engine\utility::getStruct(self.target, "targetname");

      if(!isDefined(var_6))
        var_6 = getEnt(self.target, "targetname");

      if(isDefined(var_6)) {
        var_5.origin = var_6.origin;
        var_5.angles = var_6.angles;
      }
    }

    if(var_4 < 0)
      var_5.angles = var_5.angles + (0, 180, 0);

    if(isDefined(self.door))
      self.door.clip disconnectPaths();

    put_player_on_cam(var_5);
    var_7 = level.player scripts\engine\utility::spawn_script_origin();
    var_5.tempmovesoundent = level.player scripts\engine\utility::spawn_script_origin();
    var_5.rumbleent = level.player scripts\engine\utility::spawn_script_origin();
    var_7 scalevolume(0, 0);
    var_7 playLoopSound("snake_cam_roomtone");
    var_7 scalevolume(1, 1);
    var_5.tempmovesoundent playLoopSound("snake_cam_foley");
    var_5 thread snake_cam_control();
    level.cam_hud = snake_door_cam_hud();

    while(level.player useButtonPressed()) {
      if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
        break;
      }

      wait 0.05;
    }

    scripts\engine\utility::flag_wait("snakecam_allow_exit");
    waittill_player_exits_cam();
    var_8 = var_5.origin + anglesToForward(var_5.angles) * -20;

    if(scripts\engine\utility::flag("exit_snakecam_immediately"))
      var_5 moveTo(var_8, 0.05);
    else
      var_5 moveTo(var_8, 0.5, 0.125);

    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
    level.player notify("leave_cam");

    foreach(var_10 in level.cam_hud)
    var_10 destroy();

    level thread static_burst(0.125);
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "exit_snakecam_immediately");
    level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "static_faded_in");
    scripts\engine\sp\utility::do_wait_any();
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0.8, 0);
    var_7 stoploopsound("snake_cam_roomtone");
    var_5.tempmovesoundent stoploopsound("snake_cam_foley");
    visionsetfadetoblack("", 0.05);
    setsaveddvar("OMRQKMSSPP", 0);
    setsaveddvar("MLTTMLTKOR", 0);
    setsaveddvar("NKTRSSTMRQ", 0);
    setsaveddvar("LSOPQMRPNR", 0);
    level.player scripts\engine\sp\utility::allow_nvg(1, "snakeCam");

    if(var_1)
      level.player nightvisiongogglesforceon();

    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.1);

    if(!isDefined(level.fov_default))
      level.fov_default = 65;

    level.player modifybasefov(level.fov_default, 0.05);
    remove_player_from_cam();

    if(scripts\engine\utility::flag_exist("hold_context_melee"))
      scripts\engine\utility::flag_clear("hold_context_melee");

    if(isDefined(self.door))
      self.door.clip connectpaths();

    level.player.ignore_stealth_sight = undefined;
    level.player.ignoreme = 0;
    var_5.tempmovesoundent delete();
    var_5.rumbleent delete();
    var_5 delete();
    var_7 delete();

    if(isDefined(self.door))
      self.door.snakecam_active = 0;

    while(level.player useButtonPressed()) {
      if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
        break;
      }

      wait 0.05;
    }

    level.player scripts\engine\utility::ent_flag_clear("using_snakecam");
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 6.0);
  }
}

snake_cam_control(var_0) {
  level.player endon("leave_cam");
  var_1 = self.angles;
  var_2 = -24;
  var_3 = 0;
  var_4 = 55;
  var_5 = var_1[1] - var_4;
  var_6 = var_1[1] + var_4;
  var_7 = var_1[2] - 10;
  var_8 = var_1[2] + 10;
  var_9 = 20;
  var_10 = 10;
  var_11 = 0.6;
  var_12 = 0.8;
  var_13 = 10;
  var_14 = 4;
  var_15 = 1.2;
  var_16 = [0, 0];
  var_17 = 0.2;
  var_18 = 0.2;
  var_19 = 0;

  for(;;) {
    var_20 = self.angles;
    var_21 = level.player.cam_ent.angles;
    var_22 = level.player getnormalizedcameramovement();
    var_23 = 0;
    var_24 = (var_22[0], var_22[1], 0);
    var_24 = length(var_24);
    var_25 = scripts\engine\math::factor_value(var_18, var_17, var_24);
    var_16[0] = scripts\engine\math::lerp(var_16[0], var_22[0], var_25);
    var_16[1] = scripts\engine\math::lerp(var_16[1], var_22[1], var_25);

    if(var_20[0] > 0 && var_16[0] < 0)
      var_26 = 1 - scripts\engine\math::normalize_value(var_3 * var_11, var_3, var_20[0]);
    else if(var_20[0] < 0 && var_16[0] > 0)
      var_26 = scripts\engine\math::normalize_value(var_2, var_2 * var_11, var_20[0]);
    else
      var_26 = 1;

    if(var_20[1] > var_1[1] && var_16[1] < 0)
      var_27 = 1 - scripts\engine\math::normalize_value(var_6 - var_4 * var_12, var_6, var_20[1]);
    else if(var_20[1] < var_1[1] && var_16[1] > 0)
      var_27 = scripts\engine\math::normalize_value(var_5, var_5 + var_4 * var_12, var_20[1]);
    else
      var_27 = 1;

    var_28 = var_16[1] * -1;
    var_29 = var_20[1] + var_14 * var_28 * var_27;

    if(var_29 > var_1[1])
      var_23 = scripts\engine\math::normalized_float_smooth_out(scripts\engine\math::normalize_value(var_1[1], var_6, var_29)) * -1;

    if(var_29 < var_1[1])
      var_23 = 1 - scripts\engine\math::normalized_float_smooth_in(scripts\engine\math::normalize_value(var_5, var_1[1], var_29));

    var_30 = var_22[1];
    var_31 = var_1[2] + var_10 * var_23;
    var_8 = var_8 * var_23;
    var_29 = clamp(var_29, var_5, var_6);
    var_32 = var_16[0] * -1;
    var_33 = var_20[0] + var_15 * var_32 * var_26;
    var_34 = var_2;
    var_35 = var_3;
    var_33 = clamp(var_33, var_34, var_35);
    var_36 = (var_33, var_29, var_31);
    var_37 = length(var_36 - self.angles);
    var_37 = scripts\engine\math::normalize_value(0, 1.5, var_37);
    var_38 = scripts\engine\math::factor_value(0.0, 0.105, var_37);
    var_39 = scripts\engine\math::factor_value(0.0, 0.08, var_37);
    var_40 = scripts\engine\math::factor_value(0.0, 0.2, var_37);

    if(var_38 > 0.005)
      earthquake(var_38, 0.07, level.player.origin, 2000);

    if(var_39 > 0.0001) {
      if(!var_19) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        var_19 = 1;
      }
    } else if(var_19) {
      self.rumbleent stoprumble("steady_rumble");
      var_19 = 0;
    }

    var_41 = 1 - var_39;
    var_41 = var_41 * 1000;
    self.rumbleent.origin = level.player getEye() + (0, 0, var_41);
    self.tempmovesoundent scalevolume(var_40, 0.05);
    self.angles = var_36;
    var_42 = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    level.player.cam_ent.origin = var_42;
    level.player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

put_player_on_cam(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 12 - (0, 0, 55);
  level.player.cam_ent = scripts\engine\utility::spawn_tag_origin(var_1, var_0.angles);
  level.player playerdisabletriggers();
  level.player setstance("stand");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableusability();
  level.player setOrigin(level.player.cam_ent.origin);
  level.player playerlinktodelta(level.player.cam_ent, "tag_origin", 1, 20, 20, 20, 20, 1);
  level.player springcamenabled(0, 2, 1);
  level.player setplayerangles(var_0.angles);
  level.player freezecontrols(0);
}

snakecam_allow_exit() {
  scripts\engine\utility::flag_set("snakecam_allow_exit");
}

snakecam_allow_exit_prompt() {
  level.cam_hud[2] settext("Press [{+activate}] To Exit");
}

snakecam_force_exit() {
  scripts\engine\utility::flag_set("exit_snakecam_immediately");
}

remove_player_from_cam() {
  level.player unlink();
  level.player.cam_ent delete();
  level.player setOrigin(level.player.og_origin);
  level.player setplayerangles(level.player.og_angles);
  level.player setstance(level.player.og_stance);
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableusability();
  level.player playerenabletriggers();
  scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
  level.player.ignoreme = 0;
  level.player enableweapons();
}

waittill_player_exits_cam() {
  for(;;) {
    if(player_is_trying_to_exit_camera()) {
      break;
    } else if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      break;
    } else
      waitframe();
  }
}

player_is_trying_to_exit_camera() {
  return level.player useButtonPressed() || level.player fragButtonPressed() || level.player meleeButtonPressed() || level.player buttonPressed("BUTTON_B") || level.player jumpbuttonPressed() || level.player buttonPressed("BUTTON_LSTICK") || level.player buttonPressed("BUTTON_RSTICK");
}

static_burst(var_0) {
  var_1 = 0.25;
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 0.5);
  level.player playSound("snake_cam_static");
  var_2 = scripts\sp\hud_util::create_client_overlay("overlay_static", 1);
  var_2.alpha = 0;
  var_2 fadeovertime(var_1);
  var_2.alpha = 1;
  wait(var_1);
  level notify("static_faded_in");
  wait(var_0);
  var_2 fadeovertime(var_1);
  var_2.alpha = 0;
  wait(var_1);
  level notify("static_faded_out");
  var_2 destroy();
}

cam_enemy_marking() {
  level.player endon("leave_cam");
  level.player notifyonplayercommand("trigger_pressed", "+attack");

  for(;;) {
    level.player waittill("trigger_pressed");
    var_0 = [self.door, level.player];

    if(isDefined(self.ignoremarkedents))
      var_0 = scripts\engine\utility::array_combine(var_0, self.ignoremarkedents);

    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = level.player getEye() + var_1 * 1000;
    var_3 = scripts\engine\trace::sphere_trace(level.player getEye(), var_2, 2, var_0);
    var_4 = var_3["entity"];

    if(isDefined(var_4)) {
      if(isai(var_4) && isalive(var_4) && var_4.team == "axis")
        var_4 thread handle_cam_enemy_marking();
    }
  }
}

snake_door_cam_hud() {
  var_0 = newhudelem();
  var_0.archived = 0;
  var_0.location = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.foreground = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 0.7;
  var_0.y = 233;
  var_0 settext("+");
  var_1 = newhudelem();
  var_1.x = 292;
  var_1.y = 60;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.font = "smallfixed";
  var_1.fontscale = 0.75;
  var_2 = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar("OMRQKMSSPP", 0.5);
  setsaveddvar("MLTTMLTKOR", 0.2);
  setsaveddvar("NKTRSSTMRQ", -0.75);
  setsaveddvar("LSOPQMRPNR", 0.011);
  return [var_0, var_2, var_1];
}

snake_door_cam_hud_blur_v2() {
  var_0 = newhudelem();
  var_0.archived = 0;
  var_0.location = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.foreground = 1;
  var_0.fontscale = 1;
  var_0.sort = 20;
  var_0.alpha = 0.7;
  var_0.y = 233;
  var_0 settext("+");
  var_1 = newhudelem();
  var_1.x = 400;
  var_1.y = 180;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.font = "smallfixed";
  var_1.fontscale = 0.75;
  var_2 = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar("OMRQKMSSPP", 0.5);
  setsaveddvar("MLTTMLTKOR", 0.2);
  setsaveddvar("NKTRSSTMRQ", -0.75);
  setsaveddvar("LSOPQMRPNR", 0.011);
  return [var_0, var_2, var_1];
}

handle_cam_enemy_marking() {
  if(!scripts\engine\utility::ent_flag_exist("snake_cam_marked"))
    scripts\engine\utility::ent_flag_init("snake_cam_marked");

  if(scripts\engine\utility::ent_flag("snake_cam_marked")) {
    return;
  }
  scripts\engine\utility::ent_flag_set("snake_cam_marked");
  handle_cam_enemy_caret();

  if(isalive(self) && scripts\engine\utility::ent_flag("snake_cam_marked")) {
    scripts\engine\sp\utility::hudoutline_enable_new("outline_nodepth_red", "snake_cam");
    scripts\engine\utility::ent_flag_clear("snake_cam_marked");
  }
}

handle_cam_enemy_caret() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  level.player playSound("support_drone_targeting");
  playFXOnTag(scripts\engine\utility::getfx("enemy_marker"), var_0, "tag_origin");
  cam_enemy_caret_follow_target_til_cleanup(var_0);
  var_0 delete();
}

cam_enemy_caret_follow_target_til_cleanup(var_0) {
  self endon("death");

  while(level.player scripts\engine\utility::ent_flag("using_snakecam") && scripts\engine\utility::ent_flag("snake_cam_marked")) {
    var_1 = self gettagorigin("j_head");
    var_0.origin = var_1 + (0, 0, 18);
    wait 0.05;
  }
}

c4_breach() {
  self.door endon("entitydeleted");
  self.door endon("stop_c4_ability");
  self.door.c4_breachable = 1;

  if(!isbreachableinit()) {
    return;
  }
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, "Breach", undefined, 110 * level.interactive_doors.hint_dist_scale, 60 * level.interactive_doors.hint_dist_scale, 0);
  self.door scripts\sp\door_internal::adjust_cursor_hint_side(self);
  self waittill("trigger");
  self notify("stop_cursor_hint_thread");
  self notify("c4_planted");
  self.door scripts\sp\door::create_navobstacle();
  self.breached = 1;
  self.door scripts\sp\door::remove_open_ability();
  self.door remove_door_snake_cam_ability();
  c4_on_door();
  c4_countdown();
  c4_detonate();
  self.door scripts\sp\door::clear_navobstacle();
  self.door scripts\sp\door::delete_door();
}

isbreachableinit() {
  if(self.door.locked)
    return 1;
  else
    return 0;
}

c4_on_door() {
  self.breachpoints = sortbydistance(self.breachpoints, level.player.origin);
  var_0 = self.breachpoints[0];
  level.player playgestureviewmodel("ges_equip_frag_throw");
  wait 0.5;
  self.door.c4 = spawn("script_model", var_0.origin);
  self.door.c4.angles = var_0.angles;
  self.door.c4 setModel("offhand_wm_c4");
  playworldsound("sp_c4_plant", self.origin);
  self.door notify("c4_planted");
}

c4_monitor_dmg() {
  self endon("detonate");
  self.door.c4 setCanDamage(1);

  for(;;) {
    self.door.c4 waittill("damage", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == level.player && isDefined(var_2)) {
      if(var_2 == "MOD_MELEE")
        continue;
      else
        self notify("kill_timer");
    }
  }
}

c4_detonate() {
  self.door notify("detonate");
  playworldsound("frag_grenade_expl_trans", self.origin);
  playFX(level._effect["c4_detonate"], self.origin);
  self.door.c4 delete();
  self.door hide();
  earthquake(0.7, 0.8, self.origin, 600);
  radiusdamage(self.origin, 120, 150, 30, level.player, "MOD_EXPLOSIVE");
  self.door.clip notsolid();

  if(isDefined(self.door.navmodifier))
    destroynavobstacle(self.door.navmodifier);

  scripts\engine\utility::delaythread(0.5, scripts\sp\door_internal::stealth_broadcast, 500, "gunshot");
}

c4_countdown() {
  self endon("kill_timer");
  thread c4_monitor_dmg();
  wait 0.7;

  for(var_0 = 0; var_0 < 3; var_0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_green"], self.door.c4, "tag_fx");
    wait 0.5;
  }

  for(var_0 = 0; var_0 < 6; var_0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_green"], self.door.c4, "tag_fx");
    wait 0.25;
  }

  for(var_0 = 0; var_0 < 20; var_0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_red"], self.door.c4, "tag_fx");
    wait 0.1;
  }

  self notify("detonate");
}

remove_door_c4_ability() {
  if(!istrue(self.c4_breachable)) {
    return;
  }
  self.c4_breachable = 0;
  self notify("stop_c4_ability");

  if(isDefined(self.c4_struct))
    self.c4_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
}