/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_torpedo.gsc
*******************************************/

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["dominator_uav_vehicle"] = #animtree;
  level.scr_anim["dominator_uav_vehicle"]["dominator_uav"] = % domintaor_uav_driving_idle_forward;
}

torpedo_go(var_0, var_1) {
  vehicles();
  setdvar("dominator_speed", 5);

  if(level.gameskill == 0) {
    setdvar("dominator_speed", 4);
  }

  setdvar("dominator_angle", 0);

  if(!level.console && !level.player usinggamepad()) {
    setdvar("dominator_pitch_angle_acceleration", 1.8);
    setdvar("dominator_yaw_angle_acceleration", 1.8);
    setdvar("dominator_max_pitch_angle_velocity", 3.5);
    setdvar("dominator_max_yaw_angle_velocity", 3.5);
  } else {
    setdvar("dominator_pitch_angle_acceleration", 1);
    setdvar("dominator_yaw_angle_acceleration", 1);
    setdvar("dominator_max_pitch_angle_velocity", 2);
    setdvar("dominator_max_yaw_angle_velocity", 2);
  }

  setdvar("domgrav", 25);
  setdvar("domthermal", 1);
  setdvar("dpfov", 110);
  setdvar("dph", 440);
  setdvar("dpw", 150);
  setdvar("dpx", 570);
  setdvar("dpy", 20);
  setdvar("dp1fov", 100);
  setdvar("dp1h", 150);
  setdvar("dp1w", 225);
  setdvar("dp1x", 480);
  var_2 = common_scripts\utility::get_target_ent("remote_missile_source");
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_3 = anglesToForward(var_2.angles);
  common_scripts\utility::flag_init("force_detonate_dom");
  level.player disableweaponswitch();
  level.player giveweapon("remote_torpedo_tablet");
  level.player switchtoweapon("remote_torpedo_tablet");
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingameloop("torpedo");
  setsaveddvar("player_swimSpeed", 0);
  level.player enableslowaim(0.01, 0.01);
  var_4 = level.player common_scripts\utility::spawn_tag_origin();
  var_4.angles = level.player getplayerangles();
  wait 2.5;
  var_5 = 0;
  level.player disableslowaim();
  setsaveddvar("player_swimSpeed", 90);
  level.player unlink();
  var_4 delete();
  common_scripts\utility::flag_set("torpedo_out");
  maps\_hud_util::fade_out(0.5);
  stopcinematicingame();
  level.player.breathing_overlay["gasmask_overlay"].alpha = 0;
  level.player notify("stop_scuba_breathe");
  level.player maps\_underwater::player_scuba_mask_disable(1);
  maps\_utility::delaythread(0.1, maps\_hud_util::fade_in, 0.3);
  maps\_utility::delaythread(12, common_scripts\utility::flag_set, "force_detonate_dom");
  level.player enablemousesteer(1);
  level.player torpedo_fire(var_2, var_5);
  level.player enablemousesteer(0);
  setsaveddvar("sm_cameraOffset", 0);
  setsaveddvar("sm_sunShadowScale", 1);
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  level.player maps\_underwater::player_scuba_mask(1);
  level.f_min["gasmask_overlay"] = 0.3;
  level.f_max["gasmask_overlay"] = 0.95;
  level.player maps\_utility::delaythread(0.1, maps\_swim_player::flashlight);
  level.player takeweapon("remote_torpedo_tablet");
  level.player switchtoweapon(level.player.last_weapon);
  level.player enableweaponswitch();
  common_scripts\utility::flag_wait("turn_on_bubbles_after_torpedo");
  level.player thread maps\_underwater::player_scuba();
}

pick_manual_or_auto() {
  var_0 = 0;
  thread choose_fire();
  thread choose_ads();
  thread draw_trigger_hints();
  common_scripts\utility::flag_wait("picked_torpedo_mode");

  if(common_scripts\utility::flag("player_chose_auto")) {
    var_0 = 1;
    thread fade_out_hint(level.torpedo_choice_hints["left_trig_hint"]);
    thread fade_out_hint(level.torpedo_choice_hints["right_trig_hint"], 0.05);
    thread fade_out_hint(level.torpedo_choice_hints["left_trig_hint_text"]);
    thread fade_out_hint(level.torpedo_choice_hints["right_trig_hint_text"], 0.05);
  } else {
    thread fade_out_hint(level.torpedo_choice_hints["left_trig_hint"], 0.05);
    thread fade_out_hint(level.torpedo_choice_hints["right_trig_hint"]);
    thread fade_out_hint(level.torpedo_choice_hints["left_trig_hint_text"], 0.05);
    thread fade_out_hint(level.torpedo_choice_hints["right_trig_hint_text"]);
  }

  return var_0;
}

choose_fire() {
  level endon("picked_torpedo_mode");
  level.player waittill("fire weapon");
  common_scripts\utility::flag_set("picked_torpedo_mode");
}

choose_ads() {
  level endon("picked_torpedo_mode");
  level.player waittill("used ads");
  common_scripts\utility::flag_set("player_chose_auto");
  common_scripts\utility::flag_set("picked_torpedo_mode");
}

draw_trigger_hints() {
  var_0 = 125;
  var_1 = 25;
  var_2 = 150;
  var_3 = -150;
  var_4 = 2;
  var_5 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_6 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_7 = level.player maps\_hud_util::createclientfontstring("default", 2);
  var_8 = level.player maps\_hud_util::createclientfontstring("default", 2);

  if(!maps\ship_graveyard_util::game_is_pc()) {
    var_2 = var_2 * -1;
    var_3 = var_3 * -1;
  }

  var_5.x = var_2;
  var_5.y = var_0;
  var_5 set_default_hud_stuff();

  if(maps\ship_graveyard_util::game_is_pc()) {
    var_5 settext(&"SHIP_GRAVEYARD_HINT_LT");
  }
  else {
    var_5 settext(&"SHIP_GRAVEYARD_HINT_LT_360");
  }

  var_7.x = var_2;
  var_7.y = var_0 + var_1;
  var_7 set_default_hud_stuff();
  var_7 settext(&"SHIP_GRAVEYARD_HINT_LT_TEXT");
  var_6.x = var_3;
  var_6.y = var_0;
  var_6 set_default_hud_stuff();
  var_6 settext(&"SHIP_GRAVEYARD_HINT_RT");
  var_8.x = var_3;
  var_8.y = var_0 + var_1;
  var_8 set_default_hud_stuff();
  var_8 settext(&"SHIP_GRAVEYARD_HINT_RT_TEXT");

  if(!level.console && !level.player usinggamepad()) {
    var_5.fontscale = 2;
    var_6.fontscale = 2;
  } else {
    var_5.fontscale = 2 * var_4;
    var_6.fontscale = 2 * var_4;
  }

  var_9 = [];
  var_9["left_trig_hint"] = var_5;
  var_9["right_trig_hint"] = var_6;
  var_9["left_trig_hint_text"] = var_7;
  var_9["right_trig_hint_text"] = var_8;
  level.torpedo_choice_hints = var_9;
  thread fade_in_hint(var_5);
  thread fade_in_hint(var_6);
  thread fade_in_hint(var_7);
  thread fade_in_hint(var_8);
}

set_default_hud_stuff() {
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 1;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0;
}

fade_in_hint(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1.5;
  }

  var_0 fadeovertime(var_1);
  var_0.alpha = 0.95;
  wait(var_1);
}

fade_out_hint(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1.5;
  }

  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
}

torpedo_accel() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = (0, 0, 5);
  var_0 movez(15, 3);
  var_0 endon("movedone");

  for(;;) {
    setdvar("dominator_speed", var_0.origin[2]);
    wait 0.05;
  }
}

torpedo_fire(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent("sonar_wreck_crash_player");
  self.dom = spawnStruct();
  self.start_origin = var_2.origin;
  self.start_angles = var_2.angles;
  var_3 = var_1;
  var_4 = 0;
  var_5 = [(2816, -62112, 48), (2960, -62352, 81), (3146, -62643, 154), (3368, -62965, 232)];
  var_6 = var_5[0];
  var_7 = anglesToForward(var_0.angles);
  var_8 = var_0.origin;

  if(var_3) {
    var_8 = var_6;
  }

  var_9 = spawn("script_model", var_8);
  var_9.angles = var_0.angles;

  if(var_3) {
    var_9.angles = (0, 300, 0);
  }

  var_9 setModel("viewmodel_torpedo");
  var_9 useanimtree(level.scr_animtree["torpedo"]);
  var_9 setanim(level.scr_anim["torpedo"]["torpedo_idle"]);
  var_9.dominator_angular_velocity = (0, 0, 0);
  self.dom.ref_ent = var_9;
  playFXOnTag(common_scripts\utility::getfx("torpedo_propellor_loop"), var_9, "spinner0_JNT");
  var_10 = spawn("script_model", var_9.origin + var_7 * -200.0);
  var_10.angles = var_9.angles;
  var_10 setModel("tag_origin");
  var_11 = 0;
  var_10 linkto(var_9, "tag_body", (-1.5, 0, -6.5), (var_11, 0, 0));
  self playerlinktodelta(var_10, "tag_origin", 1.0, 0, 0, 0, 0, 1);
  self.dom.player_ent = var_10;
  lock_player_controls(1);
  var_12 = 0;
  self.dom.sprint = 0;
  self.dom.sprint_time = 0;
  thread enable_torpedo_ui(var_1);
  self thermalvisionon();
  self visionsetthermalforplayer("shpg_thermal", 0);
  level.sonar_boat setModel("vehicle_lcs_flir");
  setsaveddvar("r_cc_mode", "clut");

  if(!maps\_utility::game_is_current_gen()) {
    setsaveddvar("r_thermalColorOffset", -0.01);
  }

  level notify("torpedo_ready");
  level.player thread spawn_model_fx((3, 0, 0));
  level waittill("fire_torpedo");
  wait 0.25;
  var_9 unlink();
  earthquake(0.75, 0.7, level.player.origin, 1024);
  thread torpedo_accel();
  var_9 playSound("scn_shipg_torpedo_start", "start_sound_done");
  var_9 common_scripts\utility::delaycall(0.75, ::playloopsound, "scn_shipg_torpedo_loop");
  var_13 = var_9 common_scripts\utility::spawn_tag_origin();
  self.dom.auto_pilot_rot_control_ref_ent = var_13;
  var_13.angles = var_9.angles;

  for(;;) {
    var_13.origin = var_9.origin;
    var_14 = self getnormalizedcameramovement();
    var_15 = self getnormalizedmovement();

    if(!level.console && !level.player usinggamepad()) {
      var_14 = var_14 * (1, -1, 1);
      var_14 = (max(min(1, var_14[0]), -1), max(min(1, var_14[1]), -1), 0);
    } else {
      if(var_14[0] == 0) {
        if(isDefined(self getlocalplayerprofiledata("invertedPitch")) && self getlocalplayerprofiledata("invertedPitch")) {
          var_14 = (var_15[0] * -1.0, var_14[1], var_14[2]);
        }
        else {
          var_14 = (var_15[0], var_14[1], var_14[2]);
        }
      }

      if(var_14[1] == 0) {
        var_14 = (var_14[0], var_15[1], var_14[2]);
      }
    }

    var_9.dominator_angular_velocity = (var_9 dominator_accelerate("pitch", var_9.dominator_angular_velocity, var_14), var_9 dominator_accelerate("yaw", var_9.dominator_angular_velocity, var_14), var_9 dominator_accelerate("roll", var_9.dominator_angular_velocity, var_14));
    var_9.angles = var_9.angles + var_9.dominator_angular_velocity * (1, 1, 0);
    var_16 = 80;
    var_17 = 55;

    if(var_9.angles[0] > var_16) {
      var_9.angles = (var_16, var_9.angles[1], 0);
    }
    else if(var_9.angles[0] < var_17 * -1) {
      var_9.angles = (var_17 * -1, var_9.angles[1], 0);
    }

    var_9.angles = var_9.angles * (1, 1, 0);
    var_9.angles = var_9.angles + (0, 0, var_9.dominator_angular_velocity[2] * -5.0);

    if(var_3 == 1) {
      var_18 = 1;

      if(distance(var_6, var_9.origin) < 128) {
        var_4++;

        if(var_4 < var_5.size) {
          var_6 = var_5[var_4];
        }
        else if(var_4 == var_5.size) {
          var_6 = level.sonar_boat.target_points[0].origin + (-166, 154, -156);
          var_18 = 0.25;
        } else
          var_6 = level.sonar_boat.target_points[0].origin;
      }

      var_19 = vectortoangles(var_6 - var_9.origin);
      var_13 rotateto(var_19, var_18);
      var_9.angles = var_13.angles;
    }

    var_20 = var_9.angles[0] / 90.0;

    if(var_9.angles[0] < 0) {
      var_20 = var_20 / 3.0;
    }

    var_21 = getdvarfloat("dominator_speed");
    var_9.velocity = anglesToForward(var_9.angles) * var_21;
    var_22 = var_9.origin + var_9.velocity;
    var_23 = anglesToForward(var_9.angles) * 5;
    var_24 = bulletTrace(var_9.origin, var_22 + var_9.velocity, 0, var_9);
    var_25 = bulletTrace(self getEye(), self getEye() + (0, 0, 5), 0, var_9);

    if(var_24["fraction"] < 1 || var_25["fraction"] < 1 || common_scripts\utility::flag("force_detonate_dom")) {
      thread detonate_dominator(var_9.origin, var_22 + var_9.velocity);
      break;
    }

    var_26 = var_9.origin;
    var_9.origin = var_22;
    wait 0.01;
  }

  var_27 = 0;

  foreach(var_29 in level.sonar_boat.target_points) {
    if(distance(self.origin, var_29.origin) < 196) {
      var_27 = 1;
      break;
    }
  }

  level notify("exit_torpedo", var_27);
  wait 0.25;
  disable_torpedo_ui();
  self thermalvisionoff();
  setsaveddvar("r_cc_mode", "off");
}

lock_player_controls(var_0) {
  if(var_0 == 1) {
    self disableweapons();
    self disableoffhandweapons();
    self hideviewmodel();
  } else {
    self showviewmodel();
    self enableweapons();
    self enableoffhandweapons();
  }

  self allowcrouch(!var_0);
  self allowprone(!var_0);
  self allowsprint(!var_0);
  self allowads(!var_0);
}

dominator_accelerate(var_0, var_1, var_2) {
  if(var_0 == "yaw") {
    var_3 = getdvarfloat("dominator_max_yaw_angle_velocity");
    var_4 = getdvarfloat("dominator_yaw_angle_acceleration");
    var_5 = 1;
    var_6 = 1;
    var_7 = 0.01;
  } else if(var_0 == "roll") {
    var_3 = getdvarfloat("dominator_max_yaw_angle_velocity");
    var_4 = getdvarfloat("dominator_yaw_angle_acceleration");
    var_5 = 2;
    var_6 = 1;
    var_7 = 0.01;
  } else {
    var_3 = getdvarfloat("dominator_max_pitch_angle_velocity");
    var_4 = getdvarfloat("dominator_pitch_angle_acceleration");
    var_5 = 0;
    var_6 = 0;
    var_7 = 0.3;
  }

  var_8 = dominator_get_dead_zone_range(var_2[var_6] * -1.0, var_7);

  if(var_8 == 0) {
    if(var_0 == "yaw") {
      var_4 = var_4 * 3.5;
    }
    else if(var_0 == "roll") {
      var_4 = var_4 * 1.5;
    }
    else {
      var_4 = var_4 * 2.1;
    }
  }

  var_9 = var_1[var_5] / var_3;
  var_10 = var_8 - var_9;
  var_4 = var_10 * var_4;

  if(var_0 == "yaw") {
    var_1 = var_1 + (0, var_4, 0);
  }
  else if(var_0 == "roll") {
    var_1 = var_1 + (0, 0, var_4);
  }
  else {
    var_1 = var_1 + (var_4, 0, 0);
  }

  return var_1[var_5];
}

dominator_get_dead_zone_range(var_0, var_1) {
  var_2 = clamp(abs(var_0) - var_1, 0, 1);
  var_3 = 1.0 - var_1;
  var_2 = var_2 / var_3;

  if(var_0 < 0.0) {
    var_2 = var_2 * -1.0;
  }

  return var_2;
}

detonate_dominator(var_0, var_1) {
  if(isDefined(level.sound_torpedo_ent)) {
    level.sound_torpedo_ent stoploopsound();
    level.sound_torpedo_ent delete();
  }

  var_2 = anglesToForward(self getplayerangles());
  thread dominator_earthquake(1.0, 1);
  thread common_scripts\utility::play_sound_in_space("underwater_explosion", self.origin);
  maps\_hud_util::fade_out(0.1, "white");
  self setorigin(self.start_origin);
  self setplayerangles(self.start_angles);
  self.dom.ref_ent delete();
  self.dom.player_ent delete();
  self.dom.auto_pilot_rot_control_ref_ent delete();
  level notify("kill_torpedo_model");
  self.dom.ref_ent = undefined;
  lock_player_controls(0);
  wait 0.2;
  thread maps\_hud_util::fade_in(0.35, "white");
}

dominator_earthquake(var_0, var_1) {
  if(var_1 == 0) {
    earthquake(var_0 * 0.8, 2.0, self.origin, 100000.0);
  }

  if(var_0 < 0.2) {
    self playrumbleonentity("damage_heavy");
  }
  else {
    self playrumbleonentity("damage_heavy");
    wait 0.2;
    self playrumbleonentity("damage_light");
    wait 0.2;
    self playrumbleonentity("damage_light");
  }
}

track_lcs_targets() {
  var_0 = level.sonar_boat;
  var_1 = level.sonar_boat.target_points;

  foreach(var_3 in var_1) {
    var_4 = "apache_targeting_circle";
    var_5 = (1, 0, 0);
    target_enable(var_3, var_4, var_5, 128);
    var_3 thread disable_target_on_death();
  }
}

disable_target_on_death() {
  level waittill("exit_torpedo");

  if(target_istarget(self)) {
    target_remove(self);
  }
}

target_enable(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_4 = (0, 0, 0);
  target_alloc(var_0, var_4);
  target_setshader(var_0, var_1);
  target_drawsquare(var_0, 24);

  if(isDefined(var_2)) {
    target_setcolor(var_0, var_2);
  }

  target_setmaxsize(var_0, 128);
  target_setminsize(var_0, 64, 0);
  target_setdelay(var_0, 0.6);
  target_flush(var_0);
}

enable_torpedo_ui(var_0) {
  common_scripts\utility::flag_set("pause_dynamic_dof");
  maps\_art::dof_enable_script(1, 20, 5, 9000, 90000, 3, 0.1);
  level.torpedo_hud_items = [];
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_connection_frame", 256, 12);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_2 = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_connection_text", 256, 12);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 0, -12, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_3 = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_connection_bar", 4, 4);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", -115, -2, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_4 = var_1;
  var_1 = maps\_hud_util::create_client_overlay("torpedo_frame_edge", 1, level.player);
  var_1.foreground = 0;
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  level thread torpedo_boot_sequence(var_2, var_3);
  level thread torpedo_load_bar(var_4);
  level waittill("torpedo_one_quarter_loaded");
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_sidebracket_l", 30, 340);
  var_1 maps\_hud_util::setpoint("LEFT", "LEFT", 60, 0, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_sidebracket_r", 30, 340);
  var_1 maps\_hud_util::setpoint("RIGHT", "RIGHT", -60, 0, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  level waittill("torpedo_half_loaded");
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_databit_1", 200, 26);
  var_1 maps\_hud_util::setpoint("LEFT TOP", "LEFT", 60, 120, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  wait 0.1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_databit_2", 200, 26);
  var_1 maps\_hud_util::setpoint("RIGHT TOP", "RIGHT", -105, 120, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  level thread track_lcs_targets();
  wait 0.1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_databit_3", 200, 26);
  var_1 maps\_hud_util::setpoint("TOP", "TOP", 0, 14, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  level waittill("torpedo_three_quarter_loaded");
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_centerbox", 800, 320);
  var_1 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_frame_center", 200, 12);
  var_1 maps\_hud_util::setpoint("TOP", "TOP", 0, 10, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_frame_center_bottom", 200, 12);
  var_1 maps\_hud_util::setpoint("BOTTOM", "BOTTOM", 0, -10, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  level waittill("torpedo_bar_loading_complete");
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_center", 200, 200);
  var_1 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
  var_1.alpha = 0.4;
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_horizonline", 700, 60);
  var_1 maps\_hud_util::setpoint("CENTER", undefined, 0, 0, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 thread move_horizon_line_on_torpedo_hud();
  var_1 = level.player maps\_hud_util::createclienticon("torpedo_centerline", 110, 60);
  var_1 maps\_hud_util::setpoint("BOTTOM", "CENTER", 0, -20, 0);
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 = level.player maps\_hud_util::createclientfontstring("bigfixed", 0.48);
  var_1.color = (0.733, 0.878, 0.905);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", -140, 128, 0);
  var_1.foreground = 1;
  var_1.sort = 0;
  var_1.alpha = 1;
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 thread torpedo_get_distance_to_target();
  var_1 = level.player maps\_hud_util::createclientfontstring("bigfixed", 0.48);
  var_1.color = (1, 0.419, 0.831);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", -138, 128, 0);
  var_1.sort = -1;
  var_1.alpha = 0.5;
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 thread torpedo_get_distance_to_target();
  var_1 = level.player maps\_hud_util::createclientfontstring("bigfixed", 0.48);
  var_1.color = (0.45, 1, 0.419);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", -142, 128, 0);
  var_1.sort = -2;
  var_1.alpha = 0.5;
  level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
  var_1 thread torpedo_get_distance_to_target();

  if(var_0) {
    var_1 = level.player maps\_hud_util::createclientfontstring("bigfixed", 1.5);
    var_1.color = (1, 1, 1);
    var_1 maps\_hud_util::setpoint("CENTER", "CENTER", -160, 70, 0);
    var_1.foreground = 1;
    var_1.alpha = 0.5;
    level.torpedo_hud_items[level.torpedo_hud_items.size] = var_1;
    var_1 thread auto_flash_text();
  }

  level.sonar_boat thread hud_outlineenable();
}

auto_flash_text() {
  level endon("kill_hud_logic");
  level endon("kill_torpedo_model");
  var_0 = 0.75;
  self settext(&"SHIP_GRAVEYARD_AUTO");

  for(;;) {
    wait(var_0);
    self.alpha = 0.5;
    wait(var_0 / 2);
    self.alpha = 0;
  }
}

torpedo_boot_sequence(var_0, var_1) {
  level endon("kill_hud_logic");
  level endon("kill_torpedo_model");
  var_2 = 0.25;
  var_0.alpha = 1;
  var_1.alpha = 1;
  wait(var_2);
  var_1.alpha = 0;
  wait(var_2);
  var_1.alpha = 1;
  wait(var_2);
  var_1.alpha = 0;
  wait(var_2);
  var_1.alpha = 1;
  wait(var_2);
  var_1.alpha = 0;
  level waittill("torpedo_bar_loading_complete");
  var_1.alpha = 0;
  var_0.alpha = 0;
}

torpedo_load_bar(var_0) {
  level endon("kill_hud_logic");
  level endon("kill_torpedo_model");
  var_1 = 29;
  var_2 = 8;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_0.width = var_0.width + var_2;
    var_0 setshader("torpedo_connection_bar", var_0.width, 4);
    var_0.x = var_0.x + var_2 / 2;
    var_0 maps\_hud_util::setpoint("CENTER", "CENTER", var_0.x, -2, 0);
    common_scripts\utility::waitframe();

    if(var_3 > var_1 * 0.25) {
      level notify("torpedo_one_quarter_loaded");
    }

    if(var_3 > var_1 * 0.5) {
      level notify("torpedo_half_loaded");
    }

    if(var_3 > var_1 * 0.75) {
      level notify("torpedo_three_quarter_loaded");
    }
  }

  level notify("torpedo_bar_loading_complete");
  var_0.alpha = 0;
}

torpedo_get_distance_to_target() {
  level endon("kill_hud_logic");
  wait 0.2;

  while(isDefined(level.sonar_boat.target_points)) {
    var_0 = distance(level.player.origin, level.sonar_boat.target_points[0].origin) - 35;

    if(var_0 < 16) {
      var_0 = 0;
    }

    self settext(abs(int(var_0)) + "m");
    common_scripts\utility::waitframe();
  }
}

move_horizon_line_on_torpedo_hud() {
  level endon("kill_hud_logic");
  level endon("kill_torpedo_model");
  var_0 = 30;
  var_1 = -30;
  var_2 = -285;
  var_3 = -139;

  for(;;) {
    var_4 = level.player.dom.ref_ent.angles[0];
    var_5 = 1 - (var_4 - var_0) / (var_1 - var_0);
    var_6 = abs(var_2) - abs(var_3);
    var_7 = var_3 + -1 * max(0, var_5 * var_6);
    var_7 = int(clamp(var_7, var_2, var_3));
    wait 0.05;
    maps\_hud_util::setpoint("CENTER", "BOTTOM", 0, var_7, 0);
  }
}

move_center_line_on_torpedo_hud() {
  level endon("kill_hud_logic");
  level endon("kill_torpedo_model");
  var_0 = 180;
  var_1 = -180;
  var_2 = -200;
  var_3 = 0;

  for(;;) {
    var_4 = level.player getplayerangles()[1];
    var_4 = clamp(var_4, var_0, var_1);
    var_5 = 1 - (var_4 - var_0) / (var_1 - var_0);
    var_6 = abs(var_2) - abs(var_3);
    var_7 = var_3 + -1 * max(0, var_5 * var_6);
    var_7 = int(clamp(var_7, var_2, var_3));
    wait 0.05;
    maps\_hud_util::setpoint("bottom", "center", var_7, 0, 0);
  }
}

disable_torpedo_ui() {
  maps\_art::dof_disable_script(0.1);
  level notify("kill_hud_logic");

  foreach(var_1 in level.torpedo_hud_items) {
  var_1 destroy();
  }

  if(common_scripts\utility::flag("pause_dynamic_dof")) {
    common_scripts\utility::flag_clear("pause_dynamic_dof");
  }
}

spawn_model_fx(var_0) {
  self.crt_plane = spawn("script_model", (0, 0, 0));
  self.crt_plane setModel("torpedo_crtplane");
  self.crt_plane linktoplayerview(self, "tag_origin", (2, 0, 0) + var_0, (0, -90, 0), 1);
  self.crt_plane notsolid();
  level waittill("exit_torpedo");
  self.crt_plane unlinkfromplayerview(self);
  self.crt_plane delete();
}

hud_outlineenable() {
  setsaveddvar("r_hudOutlineWidth", 2);
  self hudoutlineenable(0, 1);
  self waittill("death");

  if(isDefined(self)) {
    self hudoutlinedisable();
  }
}