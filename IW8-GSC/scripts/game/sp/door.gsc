/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\game\sp\door.gsc
***********************************************/

function init() {
  level.interactive_doors.snakecamvision = "snake_cam";
  level.interactive_doors.fndoorinit = &_init_door_internal;
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

function _init_door_internal(var0) {
  scripts\sp\door_internal::init_door_internal(var0);
  var1 = undefined;
  var2 = undefined;

  if(isDefined(self.script_parameters)) {
    var3 = strtok(self.script_parameters, " ");

    foreach(var5 in var3) {
      switch (var5) {
        case "c4":
          var1 = 1;
          self.c4_breachable = 0;
          break;
        case "snake_cam":
          var2 = 1;
          self.cam_structs = [];
          self.snakecam_active = 0;
          break;
      }
    }
  }

  if(isDefined(var1) || isDefined(var2)) {
    var7 = scripts\engine\utility::get_linked_structs();
    var8 = [];

    foreach(var10 in var7) {
      if(isDefined(var10.script_noteworthy)) {
        var10.door = self;

        switch (var10.script_noteworthy) {
          case "cam_hint":
            if(!isDefined(var2)) {
              break;
            }

            if(!isDefined(var10.radius)) {
              var10.radius = 2.5;
            }

            thread snake_cam_logic();
            self.cam_structs[self.cam_structs.size] = var10;
            break;
          case "c4":
            if(!isDefined(var10.radius)) {
              var10.radius = 2.5;
            }

            var8 = var10;
            break;
        }
        LOC_0000014a:
      }

      LOC_0000014a:
        thread door_event_wait();
    }

    if(var8.size > 0) {
      self.c4_struct = scripts\engine\utility::spawn_script_origin();
      self.c4_struct.origin = (0, 0, 0);
      self.c4_struct.radius = 0;
      self.c4_struct.door = self;

      if(isDefined(self.angles)) {
        self.c4_struct.angles = self.angles;
      } else {
        self.c4_struct.angles = (0, 0, 0);
      }

      foreach(var10 in var8) {
        self.c4_struct.origin += var10.origin * 1 / var8.size;
        self.c4_struct.radius += var10.radius * 1 / var8.size;
      }

      self.c4_struct.breachpoints = var8;
    }
  }

  if(!isDefined(self.script_spawn_open_yaw)) {
    thread scripts\sp\door_internal::cursor_hint_thread(&cursor_hints_game);
    return;
  }
}

function door_event_wait() {
  self notify("door_event_wait");
  self endon("door_event_wait");
  self endon("entitydeleted");

  for(;;) {
    var0 = scripts\engine\utility::waittill_any_return("locked", "door_unlock", "unusable");

    if(var0 == "locked") {
      thread enable_c4_on_locked();
      continue;
    }

    if(var0 == "unusable") {
      thread remove_door_snake_cam_ability();
      thread remove_door_c4_ability();
      continue;
    }

    if(var0 == "door_unlock") {
      thread remove_door_c4_ability();
    }
  }
}

function enable_c4_on_locked() {
  self endon("stop_open_interact");

  if(!isDefined(self.c4_struct)) {
    return;
  }

  thread c4_breach();
  self.open_struct scripts\sp\door::remove_open_interact_hint();
  self.c4_struct endon("c4_planted");

  while(distancesquared(level.player.origin, self.origin) < squared(200)) {
    waitframe();
  }

  remove_door_c4_ability();
  self.open_struct scripts\engine\utility::delaythread(0.05, &scripts\sp\door_internal::open_struct_logic);
}

function cursor_hints_game() {
  if(self.prevplayeronright != self.playeronright) {
    if(isDefined(self.cam_structs)) {
      foreach(var1 in self.cam_structs) {
        scripts\sp\door_internal::adjust_cursor_hint_side(var1);
      }
    }

    if(isDefined(self.c4_struct)) {
      scripts\sp\door_internal::adjust_cursor_hint_side(self.c4_struct);
      return;
    }

    return;
  }
}

function set_snake_cam_ignore_ents(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  var1 = self;
  var2 = var1.cam_structs[0];
  var2.ignoremarkedents = var0;
}

function remove_from_snakecam_immediate() {
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

function set_snake_cam_vision(var0) {
  if(!isDefined(var0)) {
    var0 = "snake_cam";
  }

  level.interactive_doors.snakecamvision = var0;

  if(level.player scripts\engine\utility::ent_flag("using_snakecam")) {
    visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
    return;
  }
}

function remove_door_snake_cam_ability() {
  if(!isDefined(self.cam_structs)) {
    return;
  }

  foreach(var1 in self.cam_structs) {
    if(isDefined(var1)) {
      var1 notify("stop_snake_cam");
      var1 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
  }
}

function snake_cam_logic() {
  self endon("stop_snake_cam");
  var0 = anglestoup(self.angles * -1);
  var1 = 0;
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 10), "Cam", undefined, 120 * level.interactive_doors.hint_dist_scale, 100 * level.interactive_doors.hint_dist_scale, 0);

  for(;;) {
    self waittill("trigger");
    self notify("stop_cursor_hint_thread");
    level.player scripts\engine\utility::ent_flag_set("using_snakecam");
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 0);

    if(level.player isnightvisionon()) {
      var1 = 1;
      level.player nightvisiongogglesforceoff();
    }

    level.player scripts\engine\sp\utility::allow_nvg(0, "snakeCam", 1);

    if(isDefined(self.door)) {
      self.door.snakecam_active = 1;
    }

    level.player modifybasefov(115, 0.4);
    thread static_burst(level);
    level.player notify("enter_cam");
    level.player.og_origin = level.player.origin;
    level.player.og_angles = level.player getplayerangles();
    level.player.og_stance = level.player getstance();
    level.player freezecontrols(1);
    level.player disableweapons();

    if(scripts\engine\utility::flag_exist("hold_context_melee")) {
      scripts\engine\utility::flag_set("hold_context_melee");
    }

    level.player.ignore_stealth_sight = 1;
    level.player.ignoreme = 1;
    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.5);
    var2 = anglesToForward(self.angles);
    var3 = vectorNormalize(self.origin - level.player getorigin());
    var4 = vectordot(var2, var3);
    var5 = level.player scripts\engine\utility::spawn_tag_origin();
    var5.origin = self.origin;
    var5.angles = self.angles;

    if(isDefined(self.target)) {
      var6 = scripts\engine\utility::getStruct(self.target, "targetname");

      if(!isDefined(var6)) {
        var6 = getEnt(self.target, "targetname");
      }

      if(isDefined(var6)) {
        var5.origin = var6.origin;
        var5.angles = var6.angles;
      }
    }

    if(var4 < 0) {
      var5.angles += (0, 180, 0);
    }

    if(isDefined(self.door)) {
      self.door.clip disconnectPaths();
    }

    put_player_on_cam(var5);
    var7 = level.player scripts\engine\utility::spawn_script_origin();
    var5.tempmovesoundent = level.player scripts\engine\utility::spawn_script_origin();
    var5.rumbleent = level.player scripts\engine\utility::spawn_script_origin();
    var7 scalevolume(0, 0);
    var7 playLoopSound("snake_cam_roomtone");
    var7 scalevolume(1, 1);
    var5.tempmovesoundent playLoopSound("snake_cam_foley");
    thread snake_cam_control();
    level.cam_hud = snake_door_cam_hud();

    while(level.player useButtonPressed()) {
      wait 0.05;
    }

    LOC_000002fd:
      scripts\engine\utility::flag_wait("snakecam_allow_exit");
    waittill_player_exits_cam();
    var8 = var5.origin + anglesToForward(var5.angles) * -20;

    if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      var5 moveTo(var8, 0.05);
    } else {
      var5 moveTo(var8, 0.5, 0.125);
    }

    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
    level.player notify("leave_cam");

    foreach(var10 in level.cam_hud) {
      var10 destroy();
    }

    thread static_burst(level);
    level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "exit_snakecam_immediately");
    level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "static_faded_in");
    scripts\engine\sp\utility::do_wait_any();
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0.8, 0);
    var7 stoploopsound("snake_cam_roomtone");
    var5.tempmovesoundent stoploopsound("snake_cam_foley");
    visionsetfadetoblack("", 0.05);
    setsaveddvar("OMRQKMSSPP", 0);
    setsaveddvar("MLTTMLTKOR", 0);
    setsaveddvar("NKTRSSTMRQ", 0);
    setsaveddvar("LSOPQMRPNR", 0);
    level.player scripts\engine\sp\utility::allow_nvg(1, "snakeCam");

    if(var1) {
      level.player nightvisiongogglesforceon();
    }

    scripts\engine\utility::flag_wait_or_timeout("exit_snakecam_immediately", 0.1);

    if(!isDefined(level.fov_default)) {
      level.fov_default = 65;
    }

    level.player modifybasefov(level.fov_default, 0.05);
    remove_player_from_cam();

    if(scripts\engine\utility::flag_exist("hold_context_melee")) {
      scripts\engine\utility::flag_clear("hold_context_melee");
    }

    if(isDefined(self.door)) {
      self.door.clip connectpaths();
    }

    level.player.ignore_stealth_sight = undefined;
    level.player.ignoreme = 0;
    var5.tempmovesoundent delete();
    var5.rumbleent delete();
    var5 delete();
    var7 delete();

    if(isDefined(self.door)) {
      self.door.snakecam_active = 0;
    }

    while(level.player useButtonPressed()) {
      wait 0.05;
    }

    LOC_0000051f:
      level.player scripts\engine\utility::ent_flag_clear("using_snakecam");
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 6);
  }
}

function snake_cam_control(var0) {
  level.player endon("leave_cam");
  var1 = self.angles;
  var2 = -24;
  var3 = 0;
  var4 = 55;
  var5 = var1[1] - var4;
  var6 = var1[1] + var4;
  var7 = var1[2] - 10;
  var8 = var1[2] + 10;
  var9 = 20;
  var10 = 10;
  var11 = 0.6;
  var12 = 0.8;
  var13 = 10;
  var14 = 4;
  var15 = 1.2;
  var16 = [0, 0];
  var17 = 0.2;
  var18 = 0.2;
  var19 = 0;

  for(;;) {
    var20 = self.angles;
    var21 = level.player.cam_ent.angles;
    var22 = level.player getnormalizedcameramovement();
    var23 = 0;
    var24 = (var22[0], var22[1], 0);
    var24 = length(var24);
    var25 = scripts\engine\math::factor_value(var18, var17, var24);
    var16 = scripts\engine\math::lerp(var16[0], var22[0], var25);
    var16 = scripts\engine\math::lerp(var16[1], var22[1], var25);

    if(var20[0] > 0 && var16[0] < 0) {
      var26 = 1 - scripts\engine\math::normalize_value(var3 * var11, var3, var20[0]);
    } else if(var20[0] < 0 && var16[0] > 0) {
      var26 = scripts\engine\math::normalize_value(var2, var2 * var11, var20[0]);
    } else {
      var26 = 1;
    }

    if(var20[1] > var1[1] && var16[1] < 0) {
      var27 = 1 - scripts\engine\math::normalize_value(var6 - var4 * var12, var6, var20[1]);
    } else if(var20[1] < var1[1] && var16[1] > 0) {
      var27 = scripts\engine\math::normalize_value(var5, var5 + var4 * var12, var20[1]);
    } else {
      var27 = 1;
    }

    var28 = var16[1] * -1;
    var29 = var20[1] + var14 * var28 * var27;

    if(var29 > var1[1]) {
      var23 = scripts\engine\math::normalized_float_smooth_out(scripts\engine\math::normalize_value(var1[1], var6, var29)) * -1;
    }

    if(var29 < var1[1]) {
      var23 = 1 - scripts\engine\math::normalized_float_smooth_in(scripts\engine\math::normalize_value(var5, var1[1], var29));
    }

    var30 = var22[1];
    var31 = var1[2] + var10 * var23;
    var8 *= var23;
    var29 = clamp(var29, var5, var6);
    var32 = var16[0] * -1;
    var33 = var20[0] + var15 * var32 * var26;
    var34 = var2;
    var35 = var3;
    var33 = clamp(var33, var34, var35);
    var36 = (var33, var29, var31);
    var37 = length(var36 - self.angles);
    var37 = scripts\engine\math::normalize_value(0, 1.5, var37);
    var38 = scripts\engine\math::factor_value(0, 0.105, var37);
    var39 = scripts\engine\math::factor_value(0, 0.08, var37);
    var40 = scripts\engine\math::factor_value(0, 0.2, var37);

    if(var38 > 0.005) {
      earthquake(var38, 0.07, level.player.origin, 2000);
    }

    if(var39 > 0.0001) {
      if(!var19) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        var19 = 1;
      }
    } else if(var19) {
      self.rumbleent stoprumble("steady_rumble");
      var19 = 0;
    }

    var41 = 1 - var39;
    var41 *= 1000;
    self.rumbleent.origin = level.player getEye() + (0, 0, var41);
    self.tempmovesoundent scalevolume(var40, 0.05);
    self.angles = var36;
    var42 = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    level.player.cam_ent.origin = var42;
    level.player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

function put_player_on_cam(var0) {
  var1 = var0.origin + anglesToForward(var0.angles) * 12 - (0, 0, 55);
  level.player.cam_ent = scripts\engine\utility::spawn_tag_origin(var1, var0.angles);
  level.player playerdisabletriggers();
  level.player setstance("stand");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableusability();
  level.player setOrigin(level.player.cam_ent.origin);
  level.player playerlinktodelta(level.player.cam_ent, "tag_origin", 1, 20, 20, 20, 20, 1);
  level.player springcamenabled(0, 2, 1);
  level.player setplayerangles(var0.angles);
  level.player freezecontrols(0);
}

function snakecam_allow_exit() {
  scripts\engine\utility::flag_set("snakecam_allow_exit");
}

function snakecam_allow_exit_prompt() {
  level.cam_hud[2] settext("Press [{+activate}] To Exit");
}

function snakecam_force_exit() {
  scripts\engine\utility::flag_set("exit_snakecam_immediately");
}

function remove_player_from_cam() {
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

function waittill_player_exits_cam() {
  for(;;) {
    if(player_is_trying_to_exit_camera()) {
      break;
    }

    if(scripts\engine\utility::flag("exit_snakecam_immediately")) {
      break;
    }

    waitframe();
  }
}

function player_is_trying_to_exit_camera() {
  return level.player useButtonPressed() || level.player fragButtonPressed() || level.player meleeButtonPressed() || level.player buttonPressed("BUTTON_B") || level.player jumpbuttonPressed() || level.player buttonPressed("BUTTON_LSTICK") || level.player buttonPressed("BUTTON_RSTICK");
}

function static_burst(var0) {
  var1 = 0.25;
  var0 = scripts\engine\utility::ter_op(isDefined(var0), var0, 0.5);
  level.player playSound("snake_cam_static");
  var2 = scripts\sp\hud_util::create_client_overlay("overlay_static", 1);
  var2.alpha = 0;
  var2 fadeovertime(var1);
  var2.alpha = 1;
  wait var1;
  level notify("static_faded_in");
  wait var0;
  var2 fadeovertime(var1);
  var2.alpha = 0;
  wait var1;
  level notify("static_faded_out");
  var2 destroy();
}

function cam_enemy_marking() {
  level.player endon("leave_cam");
  level.player notifyonplayercommand("trigger_pressed", "+attack");

  for(;;) {
    level.player waittill("trigger_pressed");
    var0 = [self.door, level.player];

    if(isDefined(self.ignoremarkedents)) {
      var0 = scripts\engine\utility::array_combine(var0, self.ignoremarkedents);
    }

    var1 = anglesToForward(level.player getplayerangles());
    var2 = level.player getEye() + var1 * 1000;
    var3 = scripts\engine\trace::sphere_trace(level.player getEye(), var2, 2, var0);
    var4 = var3["entity"];

    if(isDefined(var4)) {
      if(isai(var4) && isalive(var4) && var4.team == "axis") {
        thread handle_cam_enemy_marking();
      }
    }
  }
}

function snake_door_cam_hud() {
  var0 = newhudelem();
  var0.archived = 0;
  var0.location = 0;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.foreground = 1;
  var0.fontscale = 1;
  var0.sort = 20;
  var0.alpha = 0.7;
  var0.y = 233;
  var0 settext("+");
  var1 = newhudelem();
  var1.x = 292;
  var1.y = 60;
  var1.alignx = "center";
  var1.aligny = "middle";
  var1.font = "smallfixed";
  var1.fontscale = 0.75;
  var2 = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar("OMRQKMSSPP", 0.5);
  setsaveddvar("MLTTMLTKOR", 0.2);
  setsaveddvar("NKTRSSTMRQ", -0.75);
  setsaveddvar("LSOPQMRPNR", 0.011);
  return [var0, var2, var1];
}

function snake_door_cam_hud_blur_v2() {
  var0 = newhudelem();
  var0.archived = 0;
  var0.location = 0;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.foreground = 1;
  var0.fontscale = 1;
  var0.sort = 20;
  var0.alpha = 0.7;
  var0.y = 233;
  var0 settext("+");
  var1 = newhudelem();
  var1.x = 400;
  var1.y = 180;
  var1.alignx = "center";
  var1.aligny = "middle";
  var1.font = "smallfixed";
  var1.fontscale = 0.75;
  var2 = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar("OMRQKMSSPP", 0.5);
  setsaveddvar("MLTTMLTKOR", 0.2);
  setsaveddvar("NKTRSSTMRQ", -0.75);
  setsaveddvar("LSOPQMRPNR", 0.011);
  return [var0, var2, var1];
}

function handle_cam_enemy_marking() {
  if(!scripts\engine\utility::ent_flag_exist("snake_cam_marked")) {
    scripts\engine\utility::ent_flag_init("snake_cam_marked");
  }

  if(scripts\engine\utility::ent_flag("snake_cam_marked")) {
    return;
  }

  scripts\engine\utility::ent_flag_set("snake_cam_marked");
  handle_cam_enemy_caret();

  if(isalive(self) && scripts\engine\utility::ent_flag("snake_cam_marked")) {
    scripts\engine\sp\utility::hudoutline_enable_new("outline_nodepth_red", "snake_cam");
    scripts\engine\utility::ent_flag_clear("snake_cam_marked");
    return;
  }
}

function handle_cam_enemy_caret() {
  var0 = scripts\engine\utility::spawn_tag_origin();
  level.player playSound("support_drone_targeting");
  playFXOnTag(scripts\engine\utility::getfx("enemy_marker"), var0, "tag_origin");
  cam_enemy_caret_follow_target_til_cleanup(var0);
  var0 delete();
}

function cam_enemy_caret_follow_target_til_cleanup(var0) {
  self endon("death");

  while(level.player scripts\engine\utility::ent_flag("using_snakecam") && scripts\engine\utility::ent_flag("snake_cam_marked")) {
    var1 = self gettagorigin("j_head");
    var0.origin = var1 + (0, 0, 18);
    wait 0.05;
  }
}

function c4_breach() {
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
  remove_door_snake_cam_ability(self.door);
  c4_on_door();
  c4_countdown();
  c4_detonate();
  self.door scripts\sp\door::clear_navobstacle();
  self.door scripts\sp\door::delete_door();
}

function isbreachableinit() {
  if(self.door.locked) {
    return 1;
  }

  return 0;
}

function c4_on_door() {
  self.breachpoints = sortbydistance(self.breachpoints, level.player.origin);
  var0 = self.breachpoints[0];
  level.player playgestureviewmodel("ges_equip_frag_throw");
  wait 0.5;
  self.door.c4 = spawn("script_model", var0.origin);
  self.door.c4.angles = var0.angles;
  self.door.c4 setModel("offhand_wm_c4");
  playworldsound("sp_c4_plant", self.origin);
  self.door notify("c4_planted");
}

function c4_monitor_dmg() {
  self endon("detonate");
  self.door.c4 setCanDamage(1);

  for(;;) {
    self.door.c4 waittill("damage", var0, var1, var0, var0, var2);

    if(isDefined(var1) && var1 == level.player && isDefined(var2)) {
      if(var2 == "MOD_MELEE") {
        continue;
      }

      self notify("kill_timer");
    }
  }
}

function c4_detonate() {
  self.door notify("detonate");
  playworldsound("frag_grenade_expl_trans", self.origin);
  playFX(level._effect["c4_detonate"], self.origin);
  self.door.c4 delete();
  self.door hide();
  earthquake(0.7, 0.8, self.origin, 600);
  radiusdamage(self.origin, 120, 150, 30, level.player, "MOD_EXPLOSIVE");
  self.door.clip notsolid();

  if(isDefined(self.door.navmodifier)) {
    destroynavobstacle(self.door.navmodifier);
  }

  scripts\engine\utility::delaythread(0.5, &scripts\sp\door_internal::stealth_broadcast, 500, "gunshot");
}

function c4_countdown() {
  self endon("kill_timer");
  thread c4_monitor_dmg();
  wait 0.7;

  for(var0 = 0; var0 < 3; var0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_green"], self.door.c4, "tag_fx");
    wait 0.5;
  }

  for(var0 = 0; var0 < 6; var0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_green"], self.door.c4, "tag_fx");
    wait 0.25;
  }

  for(var0 = 0; var0 < 20; var0++) {
    playworldsound("hack_robot_explode_beep", self.origin);
    playFXOnTag(level._effect["c4_light_red"], self.door.c4, "tag_fx");
    wait 0.1;
  }

  self notify("detonate");
}

function remove_door_c4_ability() {
  if(!istrue(self.c4_breachable)) {
    return;
  }

  self.c4_breachable = 0;
  self notify("stop_c4_ability");

  if(isDefined(self.c4_struct)) {
    self.c4_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
    return;
  }
}