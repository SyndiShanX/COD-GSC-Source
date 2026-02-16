/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_code_sparrow.gsc
*****************************************/

sparrow_init() {
  common_scripts\utility::flag_init("sparrow_hud_black");
  precachestring(&"ENEMY_HQ_NORTH");
  precachestring(&"ENEMY_HQ_SOUTH");
  precachestring(&"ENEMY_HQ_EAST");
  precachestring(&"ENEMY_HQ_WEST");
  precachestring(&"ENEMY_HQ_NORTHWEST");
  precachestring(&"ENEMY_HQ_SOUTHWEST");
  precachestring(&"ENEMY_HQ_SOUTHEAST");
  precachestring(&"ENEMY_HQ_NORTHEAST");
}

sam_give_control() {
  self endon("remove_sam_control");
  self endon("death");
  level.sam_launchers = [];
  level.sam_launchers = common_scripts\utility::array_add(level.sam_launchers, getent("sparrow_launcher", "targetname"));
  level.sam_launchers[0] hide();
  level.sam_launchers[0].old_contents = level.sam_launchers[0] setcontents(0);
  level.sam_launcher_index = level.sam_launchers.size;
  level.sam_launchers[level.sam_launchers.size] = spawn("script_model", level.sam_launchers[0].origin);
  level.sam_launchers[level.sam_launcher_index].angles = level.sam_launchers[0].angles;
  level.sam_launchers[level.sam_launcher_index] setModel("crr_sparrow_launcher");
  level.sam_lockon_targets = [];
  level.sam_lockon_range = 30000;

  for(;;) {
    self waittill("use_sam");

    if(isDefined(self.using_sam) && self.using_sam) {
      sam_exit();
      continue;
    }

    self.lastusedweapon = self getcurrentweapon();
    self giveweapon("sparrow_targeting_device");
    self switchtoweapon("sparrow_targeting_device");
    self freezecontrols(1);
    self.using_sam = 1;
    level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, self);
    level.black_overlay fadeovertime(0.25);
    level.black_overlay.alpha = 1;
    thread maps\carrier_audio::aud_carr_sparrow_zone_on();
    wait 0.25;
    thread maps\_utility::autosave_now_silent();
    wait 0.2;
    common_scripts\utility::flag_set("sparrow_hud_black");
    self.prev_origin = self.origin;
    self.prev_angles = self getplayerangles();
    self.prev_stance = self getstance();
    self takeweapon("sparrow_targeting_device");
    maps\_utility::store_players_weapons("sam");
    self takeallweapons();
    self setstance("stand");
    self allowcrouch(0);
    self allowjump(0);
    self allowprone(0);
    self enableinvulnerability();
    level.friendlyfiredisabled = 1;
    setsaveddvar("ammoCounterHide", "1");
    setsaveddvar("actionSlotsHide", "1");
    setsaveddvar("hud_showstance", 0);
    setsaveddvar("cg_fov", 90);
    self setorigin(level.sam_launchers[level.sam_launcher_index].origin + anglestoup(level.sam_launchers[level.sam_launcher_index] gettagangles("tag_origin")) * 95 + anglesToForward(level.sam_launchers[level.sam_launcher_index] gettagangles("tag_origin")) * -20);
    self setplayerangles(level.sam_launchers[level.sam_launcher_index] gettagangles("tag_origin") + (5, 0, 0));
    self playerlinktodelta(level.sam_launchers[level.sam_launcher_index], "tag_origin", 1, 0, 0, 0, 0);
    self playerlinkedoffsetenable();

    if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
      self enablemousesteer(1);

    level.sam_launchers[level.sam_launcher_index].old_contents = level.sam_launchers[level.sam_launcher_index] setcontents(0);
    clear_sam_missiles();
    load_sam_missiles();
    thread sam_control();
    thread maps\carrier_audio::aud_sparrow_aiming();
    level.black_overlay fadeovertime(0.25);
    level.black_overlay.alpha = 0;
    thread sam_use_auto_lock_on();
    level.sam_damage_dummy = spawn("script_model", self.origin + anglesToForward(self getplayerangles()) * 65);
    level.sam_damage_dummy.angles = self getplayerangles() + (90, 0, 0);
    level.sam_damage_dummy hide();
    level.sam_damage_dummy setModel("com_barrel_black_h");
    level.sam_damage_dummy linkto(self);
    level.sam_damage_dummy thread sam_monitor_damage();

    foreach(var_1 in getaiarray("allies")) {
      if(!isDefined(var_1.magic_bullet_shield))
        var_1 maps\_utility::magic_bullet_shield(1);
    }
  }
}

sam_exit() {
  self notify("exit_sam");
  self endon("death");
  level.black_overlay fadeovertime(0.25);
  level.black_overlay.alpha = 1;
  wait 0.25;
  sam_clear_hud();
  clear_sam_missiles();
  thread maps\carrier_audio::aud_carr_sparrow_zone_off();
  thread maps\carrier_audio::aud_play_victory_deck_music();
  var_0 = 0;

  foreach(var_2 in target_getarray()) {
    if(!isDefined(var_2)) {
      continue;
    }
    target_hidefromplayer(var_2, self);
    var_2 hudoutlinedisable();
    var_0++;

    if(var_0 > 5) {
      var_0 = 0;
      wait 0.05;
    }
  }

  level.sam_lockon_targets = [];
  level.black_overlay fadeovertime(0.25);
  level.black_overlay.alpha = 0;
  level.sam_damage_dummy unlink();
  self unlink();
  self setorigin(self.prev_origin);
  self setplayerangles(self.prev_angles);
  self setstance(self.prev_stance);
  self allowprone(1);
  self allowcrouch(1);
  self allowjump(1);
  self disableinvulnerability();
  self digitaldistortsetparams(0, 0);
  level.friendlyfiredisabled = 0;
  setsaveddvar("cg_fov", 65);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showstance", 1);
  self.using_sam = 0;

  if(!level.console && !common_scripts\utility::is_player_gamepad_enabled())
    self enablemousesteer(0);

  level.sam_launchers[0] show();
  level.sam_launchers[0] setcontents(level.sam_launchers[0].old_contents);
  level.sam_launchers[level.sam_launcher_index] delete();
  level.sam_launchers = maps\_utility::array_remove_index(level.sam_launchers, level.sam_launcher_index);
  level.sam_damage_dummy delete();
  level.sam_damage_dummy = undefined;

  foreach(var_5 in getaiarray("allies")) {
    if(isDefined(var_5.magic_bullet_shield) && isDefined(var_5.script_noteworthy) && var_5.script_noteworthy != "hesh")
      var_5 maps\_utility::stop_magic_bullet_shield();
  }
}

sam_remove_control() {
  self notify("remove_sam_control");
  self notify("stop_lockon_sound");
  self endon("death");
  level.player enablemousesteer(0);
  self setweaponhudiconoverride("actionslot4", "");

  if(isDefined(self.using_sam) && self.using_sam)
    sam_exit();

  level.sam_targets = [];
}

sam_hud() {
  self endon("remove_sam_control");
  self endon("exit_sam");
  self endon("death");
  self.sam_hud_elements = [];
  self.sam_hud_elements["screen_overlay"] = newclienthudelem(self);
  self.sam_hud_elements["screen_overlay"].x = 0;
  self.sam_hud_elements["screen_overlay"].y = 0;
  self.sam_hud_elements["screen_overlay"].alignx = "left";
  self.sam_hud_elements["screen_overlay"].aligny = "top";
  self.sam_hud_elements["screen_overlay"].horzalign = "fullscreen";
  self.sam_hud_elements["screen_overlay"].vertalign = "fullscreen";
  self.sam_hud_elements["screen_overlay"].alpha = 1;
  self.sam_hud_elements["screen_overlay"] setshader("crr_hud_missile_system_overlay_01", 640, 480);
  self.sam_hud_elements["scanlines"] = newclienthudelem(self);
  self.sam_hud_elements["scanlines"].x = 0;
  self.sam_hud_elements["scanlines"].y = 0;
  self.sam_hud_elements["scanlines"].alignx = "left";
  self.sam_hud_elements["scanlines"].aligny = "top";
  self.sam_hud_elements["scanlines"].horzalign = "fullscreen";
  self.sam_hud_elements["scanlines"].vertalign = "fullscreen";
  self.sam_hud_elements["scanlines"].alpha = 0.25;
  self.sam_hud_elements["scanlines"] setshader("crr_hud_interlace_mask", 640, 480);
  self.sam_hud_elements["pitch_ladder_left"] = maps\_hud_util::createclienticon("crr_hud_missl_sys_ladder_l", 60, 480);
  self.sam_hud_elements["pitch_ladder_left"].alignx = "left";
  self.sam_hud_elements["pitch_ladder_left"].aligny = "middle";
  self.sam_hud_elements["pitch_ladder_left"].horzalign = "left";
  self.sam_hud_elements["pitch_ladder_left"].vertalign = "middle";
  self.sam_hud_elements["pitch_ladder_left"].x = 15;
  self.sam_hud_elements["pitch_ladder_left"].y = 0;
  self.sam_hud_elements["pitch_ladder_left"].alpha = 1;
  self.sam_hud_elements["pitch_ladder_left"].sort = 50;
  self.sam_hud_elements["pitch_ladder_right"] = maps\_hud_util::createclienticon("crr_hud_missl_sys_ladder_r", 60, 480);
  self.sam_hud_elements["pitch_ladder_right"].alignx = "right";
  self.sam_hud_elements["pitch_ladder_right"].aligny = "middle";
  self.sam_hud_elements["pitch_ladder_right"].horzalign = "right";
  self.sam_hud_elements["pitch_ladder_right"].vertalign = "middle";
  self.sam_hud_elements["pitch_ladder_right"].x = -15;
  self.sam_hud_elements["pitch_ladder_right"].y = 0;
  self.sam_hud_elements["pitch_ladder_right"].alpha = 1;
  self.sam_hud_elements["pitch_ladder_right"].sort = 50;
  self.sam_hud_elements["pitch_arrow_left"] = maps\_hud_util::createclienticon("crr_hud_arrow_l", 10, 10);
  self.sam_hud_elements["pitch_arrow_left"].alignx = "right";
  self.sam_hud_elements["pitch_arrow_left"].aligny = "middle";
  self.sam_hud_elements["pitch_arrow_left"].horzalign = "left";
  self.sam_hud_elements["pitch_arrow_left"].vertalign = "middle";
  self.sam_hud_elements["pitch_arrow_left"].x = 12;
  self.sam_hud_elements["pitch_arrow_left"].y = 0;
  self.sam_hud_elements["pitch_arrow_left"].alpha = 1;
  self.sam_hud_elements["pitch_arrow_left"].sort = 50;
  self.sam_hud_elements["pitch_arrow_right"] = maps\_hud_util::createclienticon("crr_hud_arrow_r", 10, 10);
  self.sam_hud_elements["pitch_arrow_right"].alignx = "left";
  self.sam_hud_elements["pitch_arrow_right"].aligny = "middle";
  self.sam_hud_elements["pitch_arrow_right"].horzalign = "right";
  self.sam_hud_elements["pitch_arrow_right"].vertalign = "middle";
  self.sam_hud_elements["pitch_arrow_right"].x = -12;
  self.sam_hud_elements["pitch_arrow_right"].y = 0;
  self.sam_hud_elements["pitch_arrow_right"].alpha = 1;
  self.sam_hud_elements["pitch_arrow_right"].sort = 50;
  self.sam_hud_elements["class_2"] = maps\_hud_util::createclienticon("crr_hud_icon_class_2", 15, 15);
  self.sam_hud_elements["class_2"].alignx = "center";
  self.sam_hud_elements["class_2"].aligny = "middle";
  self.sam_hud_elements["class_2"].horzalign = "center";
  self.sam_hud_elements["class_2"].vertalign = "middle";
  self.sam_hud_elements["class_2"].x = 46;
  self.sam_hud_elements["class_2"].y = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, -39, -30);
  self.sam_hud_elements["class_2"].alpha = 0;
  self.sam_hud_elements["class_2"].sort = 50;
  self.sam_hud_elements["class_4"] = maps\_hud_util::createclienticon("crr_hud_icon_class_4", 15, 15);
  self.sam_hud_elements["class_4"].alignx = "center";
  self.sam_hud_elements["class_4"].aligny = "middle";
  self.sam_hud_elements["class_4"].horzalign = "center";
  self.sam_hud_elements["class_4"].vertalign = "middle";
  self.sam_hud_elements["class_4"].x = 46;
  self.sam_hud_elements["class_4"].y = self.sam_hud_elements["class_2"].y;
  self.sam_hud_elements["class_4"].alpha = 0;
  self.sam_hud_elements["class_4"].sort = 50;
  self.sam_hud_elements["gunship"] = maps\_hud_util::createclienticon("crr_hud_icon_fed_gunship", common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48), common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48));
  self.sam_hud_elements["gunship"].alignx = "center";
  self.sam_hud_elements["gunship"].aligny = "top";
  self.sam_hud_elements["gunship"].horzalign = "center";
  self.sam_hud_elements["gunship"].vertalign = "middle";
  self.sam_hud_elements["gunship"].x = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 203, 152);
  self.sam_hud_elements["gunship"].y = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, -108, -104);
  self.sam_hud_elements["gunship"].alpha = 0;
  self.sam_hud_elements["gunship"].sort = 50;
  self.sam_hud_elements["helicopter"] = maps\_hud_util::createclienticon("crr_hud_icon_fed_helicopter", common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48), common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48));
  self.sam_hud_elements["helicopter"].alignx = "center";
  self.sam_hud_elements["helicopter"].aligny = "top";
  self.sam_hud_elements["helicopter"].horzalign = "center";
  self.sam_hud_elements["helicopter"].vertalign = "middle";
  self.sam_hud_elements["helicopter"].x = self.sam_hud_elements["gunship"].x;
  self.sam_hud_elements["helicopter"].y = self.sam_hud_elements["gunship"].y;
  self.sam_hud_elements["helicopter"].alpha = 0;
  self.sam_hud_elements["helicopter"].sort = 50;
  self.sam_hud_elements["inflatable"] = maps\_hud_util::createclienticon("crr_hud_icon_fed_inflatable", common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48), common_scripts\utility::ter_op(getdvarint("widescreen") == 1, 64, 48));
  self.sam_hud_elements["inflatable"].alignx = "center";
  self.sam_hud_elements["inflatable"].aligny = "top";
  self.sam_hud_elements["inflatable"].horzalign = "center";
  self.sam_hud_elements["inflatable"].vertalign = "middle";
  self.sam_hud_elements["inflatable"].x = self.sam_hud_elements["gunship"].x;
  self.sam_hud_elements["inflatable"].y = self.sam_hud_elements["gunship"].y;
  self.sam_hud_elements["inflatable"].alpha = 0;
  self.sam_hud_elements["inflatable"].sort = 50;
  self.sam_hud_elements["radar"] = maps\_hud_util::createclienticon("cinematic", 160, 85);
  self.sam_hud_elements["radar"].alignx = "center";
  self.sam_hud_elements["radar"].aligny = "bottom";
  self.sam_hud_elements["radar"].horzalign = "center";
  self.sam_hud_elements["radar"].vertalign = "bottom";
  self.sam_hud_elements["radar"].x = 0;
  self.sam_hud_elements["radar"].y = 8;
  self.sam_hud_elements["radar"].alpha = 1;
  self.sam_hud_elements["radar"].sort = 50;
  self.sam_hud_elements["left_pitch_val"] = maps\_hud_util::createclientfontstring("hudsmall", 0.6);
  self.sam_hud_elements["left_pitch_val"].alignx = "left";
  self.sam_hud_elements["left_pitch_val"].aligny = "bottom";
  self.sam_hud_elements["left_pitch_val"].horzalign = "left";
  self.sam_hud_elements["left_pitch_val"].vertalign = "bottom";
  self.sam_hud_elements["left_pitch_val"].x = 31;
  self.sam_hud_elements["left_pitch_val"].y = 14;
  self.sam_hud_elements["left_pitch_val"].alpha = 0.5;
  self.sam_hud_elements["left_pitch_val"].sort = 50;
  self.sam_hud_elements["right_pitch_val"] = maps\_hud_util::createclientfontstring("hudsmall", 0.6);
  self.sam_hud_elements["right_pitch_val"].alignx = "right";
  self.sam_hud_elements["right_pitch_val"].aligny = "bottom";
  self.sam_hud_elements["right_pitch_val"].horzalign = "right";
  self.sam_hud_elements["right_pitch_val"].vertalign = "bottom";
  self.sam_hud_elements["right_pitch_val"].x = -31;
  self.sam_hud_elements["right_pitch_val"].y = 14;
  self.sam_hud_elements["right_pitch_val"].alpha = 0.5;
  self.sam_hud_elements["right_pitch_val"].sort = 50;
  self.sam_hud_elements["time"] = maps\_hud_util::createclientfontstring("hudsmall", 0.7);
  self.sam_hud_elements["time"].alignx = "left";
  self.sam_hud_elements["time"].aligny = "top";
  self.sam_hud_elements["time"].horzalign = "left";
  self.sam_hud_elements["time"].vertalign = "top";
  self.sam_hud_elements["time"].x = 150;
  self.sam_hud_elements["time"].y = -14;
  self.sam_hud_elements["time"].alpha = 0.75;
  self.sam_hud_elements["time"].sort = 50;
  self.sam_hud_elements["engage"] = maps\_hud_util::createclientfontstring("hudsmall", 0.7);
  self.sam_hud_elements["engage"].alignx = "center";
  self.sam_hud_elements["engage"].aligny = "bottom";
  self.sam_hud_elements["engage"].horzalign = "center";
  self.sam_hud_elements["engage"].vertalign = "middle";
  self.sam_hud_elements["engage"].x = self.sam_hud_elements["gunship"].x;
  self.sam_hud_elements["engage"].y = common_scripts\utility::ter_op(getdvarint("widescreen") == 1, -108, -112);
  self.sam_hud_elements["engage"].alpha = 0;
  self.sam_hud_elements["engage"].sort = 50;
  self.sam_hud_elements["engage"].hidewheninmenu = 1;
  self.sam_hud_elements["engage"] settext(&"CARRIER_ENGAGE");
  self.sam_hud_elements["compass_top"] = maps\_hud_util::createclienticon("white", 195, 1);
  self.sam_hud_elements["compass_top"].alignx = "center";
  self.sam_hud_elements["compass_top"].aligny = "bottom";
  self.sam_hud_elements["compass_top"].horzalign = "center";
  self.sam_hud_elements["compass_top"].vertalign = "top";
  self.sam_hud_elements["compass_top"].x = 0;
  self.sam_hud_elements["compass_top"].y = 0;
  self.sam_hud_elements["compass_top"].alpha = 0.75;
  self.sam_hud_elements["compass_top"].sort = 50;
  self.sam_hud_elements["compass_left"] = maps\_hud_util::createclienticon("white", 1, 7);
  self.sam_hud_elements["compass_left"].alignx = "center";
  self.sam_hud_elements["compass_left"].aligny = "top";
  self.sam_hud_elements["compass_left"].horzalign = "center";
  self.sam_hud_elements["compass_left"].vertalign = "top";
  self.sam_hud_elements["compass_left"].x = -97;
  self.sam_hud_elements["compass_left"].y = 0;
  self.sam_hud_elements["compass_left"].alpha = 0.75;
  self.sam_hud_elements["compass_left"].sort = 50;
  self.sam_hud_elements["compass_right"] = maps\_hud_util::createclienticon("white", 1, 7);
  self.sam_hud_elements["compass_right"].alignx = "center";
  self.sam_hud_elements["compass_right"].aligny = "top";
  self.sam_hud_elements["compass_right"].horzalign = "center";
  self.sam_hud_elements["compass_right"].vertalign = "top";
  self.sam_hud_elements["compass_right"].x = 97;
  self.sam_hud_elements["compass_right"].y = 0;
  self.sam_hud_elements["compass_right"].alpha = 0.75;
  self.sam_hud_elements["compass_right"].sort = 50;
  thread sam_update_pitch_values();
  thread sam_update_time();
  thread sam_update_radar();
  thread sam_update_compass();
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingameloopresident("carrier_sparrow_radar");
}

sam_clear_hud() {
  self notify("sam_clear_hud");
  var_0 = getarraykeys(self.sam_hud_elements);

  foreach(var_2 in var_0) {
    self.sam_hud_elements[var_2] destroy();
    self.sam_hud_elements[var_2] = undefined;
  }

  var_0 = getarraykeys(self.sam_hud_radar_elements);

  foreach(var_2 in var_0) {
    self.sam_hud_radar_elements[var_2] destroy();
    self.sam_hud_radar_elements[var_2] = undefined;
  }

  self.sam_hud_elements = undefined;
  self.sam_hud_radar_elements = undefined;
}

sam_update_pitch_values() {
  self endon("sam_clear_hud");

  for(;;) {
    var_0 = (angleclamp180(self getplayerangles()[0]), angleclamp180(self getplayerangles()[1]), angleclamp180(self getplayerangles()[2]));
    self.sam_hud_elements["pitch_arrow_left"].y = (var_0[0] - var_0[2]) / 45 * 205;
    self.sam_hud_elements["pitch_arrow_right"].y = (var_0[0] + var_0[2]) / 45 * 205;
    self.sam_hud_elements["left_pitch_val"] settext(0 - var_0[0] + var_0[2]);
    self.sam_hud_elements["right_pitch_val"] settext(0 - var_0[0] - var_0[2]);
    wait 0.05;
  }
}

sam_update_time() {
  self endon("sam_clear_hud");
  var_0 = 8;
  var_1 = 35;
  var_2 = 16;
  var_3 = 0;

  for(;;) {
    var_4 = "";

    if(var_0 < 10)
      var_4 = "0";

    var_4 = var_4 + (var_0 + ":");

    if(var_1 < 10)
      var_4 = var_4 + "0";

    var_4 = var_4 + (var_1 + ":");

    if(var_2 < 10)
      var_4 = var_4 + "0";

    var_4 = var_4 + (var_2 + ":");

    if(var_3 < 10)
      var_4 = var_4 + "0";

    var_4 = var_4 + var_3;
    self.sam_hud_elements["time"] settext(var_4);
    wait 0.05;
    var_3 = var_3 + 5;

    if(var_3 >= 100) {
      var_3 = 0;
      var_2++;

      if(var_2 >= 60) {
        var_2 = 0;
        var_1++;

        if(var_1 >= 60) {
          var_1 = 0;
          var_0++;

          if(var_0 >= 24)
            var_0 = 0;
        }
      }
    }
  }
}

sam_update_radar() {
  self endon("sam_clear_hud");
  self.sam_hud_radar_elements = [];

  for(;;) {
    var_0 = 0;
    var_1 = self getplayerangles();
    var_2 = anglesToForward((0, var_1[1], 0));
    var_3 = anglestoright((0, var_1[1], 0));

    foreach(var_5 in vehicle_getarray()) {
      if((var_5 maps\_vehicle::ishelicopter() || var_5.classname == "script_vehicle_y_8_gunship") && var_5.health > 0) {
        var_6 = var_5.origin - self getEye();
        var_6 = vectornormalize((var_6[0], var_6[1], 0));
        var_7 = vectordot(var_6, var_2);

        if(var_7 < 0) {
          continue;
        }
        var_8 = vectordot(var_6, var_3);
        var_9 = distance2d(self getEye(), var_5.origin);

        if(!isDefined(self.sam_hud_radar_elements[var_0])) {
          self.sam_hud_radar_elements[var_0] = maps\_hud_util::createclienticon("hud_red_dot", 4, 4);
          self.sam_hud_radar_elements[var_0].alignx = "center";
          self.sam_hud_radar_elements[var_0].aligny = "middle";
          self.sam_hud_radar_elements[var_0].horzalign = "center";
          self.sam_hud_radar_elements[var_0].vertalign = "bottom";
          self.sam_hud_radar_elements[var_0].sort = 100;
          self.sam_hud_radar_elements[var_0].alpha = 0.5;
        }

        self.sam_hud_radar_elements[var_0].x = 0 + var_8 * min(pow(var_9 / 25000, 0.5), 1.0) * 48;
        self.sam_hud_radar_elements[var_0].y = -23 - var_7 * min(pow(var_9 / 25000, 0.5), 1.0) * 48;
        self.sam_hud_radar_elements[var_0].alpha = 0.5;
        var_0++;
      }
    }

    for(var_11 = var_0; var_11 < self.sam_hud_radar_elements.size; var_11++)
      self.sam_hud_radar_elements[var_11].alpha = 0;

    wait 0.05;
  }
}

sam_update_compass() {
  self endon("sam_clear_hud");
  var_0 = 5;
  var_1 = 45;
  var_2 = 90;
  var_3 = self.sam_hud_elements["compass_left"].x;
  var_4 = self.sam_hud_elements["compass_top"].y;
  var_5 = abs(var_3 * 2);
  var_6 = 5;
  var_7 = 0.8;
  var_8 = int(var_2 / var_0);
  var_9 = var_5 / var_8;

  for(var_10 = 0; var_10 < var_8; var_10++) {
    self.sam_hud_elements["compass_tick_mark_" + var_10] = maps\_hud_util::createicon("white", 1, var_6);
    self.sam_hud_elements["compass_tick_mark_" + var_10].alignx = "center";
    self.sam_hud_elements["compass_tick_mark_" + var_10].aligny = "top";
    self.sam_hud_elements["compass_tick_mark_" + var_10].horzalign = "center";
    self.sam_hud_elements["compass_tick_mark_" + var_10].vertalign = "top";
    self.sam_hud_elements["compass_tick_mark_" + var_10].x = 0;
    self.sam_hud_elements["compass_tick_mark_" + var_10].y = var_4;
    self.sam_hud_elements["compass_tick_mark_" + var_10].alpha = var_7;
    self.sam_hud_elements["compass_tick_mark_" + var_10].sort = 50;
  }

  for(var_10 = 0; var_10 < int(var_2 / var_1); var_10++) {
    self.sam_hud_elements["compass_label_mark_" + var_10] = maps\_hud_util::createclientfontstring("default", 1.0);
    self.sam_hud_elements["compass_label_mark_" + var_10].alignx = "center";
    self.sam_hud_elements["compass_label_mark_" + var_10].aligny = "top";
    self.sam_hud_elements["compass_label_mark_" + var_10].horzalign = "center";
    self.sam_hud_elements["compass_label_mark_" + var_10].vertalign = "top";
    self.sam_hud_elements["compass_label_mark_" + var_10].alpha = var_7;
    self.sam_hud_elements["compass_label_mark_" + var_10].x = 0;
    self.sam_hud_elements["compass_label_mark_" + var_10].y = var_4 + var_6 + 1;
    self.sam_hud_elements["compass_label_mark_" + var_10].sort = 50;
  }

  for(;;) {
    var_11 = angleclamp(getnorthyaw() - self getplayerangles()[1]);
    var_12 = var_3 + (1.0 - maps\carrier_code::modulus(abs(var_11), var_0) / var_0) * var_9;
    var_13 = int(floor(var_11 / var_0) - var_8 / 2) * var_0;
    var_14 = 0;

    for(var_10 = 0; var_10 < var_8; var_10++) {
      var_13 = var_13 + var_0;
      self.sam_hud_elements["compass_tick_mark_" + var_10].x = var_12 + var_10 * var_9;

      if(maps\carrier_code::modulus(var_13, var_1) == 0) {
        if(var_13 >= 360)
          var_13 = var_13 - 360;
        else if(var_13 < 0)
          var_13 = var_13 + 360;

        var_15 = "";

        if(var_13 == 0)
          var_15 = &"ENEMY_HQ_NORTH";
        else if(var_13 == 45)
          var_15 = &"ENEMY_HQ_NORTHEAST";
        else if(var_13 == 90)
          var_15 = &"ENEMY_HQ_EAST";
        else if(var_13 == 135)
          var_15 = &"ENEMY_HQ_SOUTHEAST";
        else if(var_13 == 180)
          var_15 = &"ENEMY_HQ_SOUTH";
        else if(var_13 == 225)
          var_15 = &"ENEMY_HQ_SOUTHWEST";
        else if(var_13 == 270)
          var_15 = &"ENEMY_HQ_WEST";
        else if(var_13 == 315)
          var_15 = &"ENEMY_HQ_NORTHWEST";

        self.sam_hud_elements["compass_label_mark_" + var_14].x = var_12 + var_10 * var_9;
        self.sam_hud_elements["compass_label_mark_" + var_14] settext(var_15);
        var_14++;
      }
    }

    wait 0.05;
  }
}

sam_monitor_damage() {
  level.player endon("remove_sam_control");
  level.player endon("exit_sam");
  level.player endon("death");
  level.sam_max_health = 500;
  level.sam_health = level.sam_max_health;
  self setCanDamage(1);
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(var_2 == level.player) {
      continue;
    }
    level.sam_health = level.sam_health - 50;
    level.sam_health = max(level.sam_health, 0);
    var_6 = 1 - level.sam_health / level.sam_max_health;
    level.player digitaldistortsetparams(var_6 * 0.5, 1);
    level.player viewkick(20, var_2.origin);

    if(var_5 == "MOD_PROJECTILE_SPLASH") {
      level.player setplayerangles((level.player getplayerangles()[0] - 5, level.player getplayerangles()[1], level.player getplayerangles()[2] - 5));
      earthquake(0.7, 1.5, level.player getEye(), 800);
      level.player playrumbleonentity("heavy_2s");
      var_0++;

      if(var_0 == 1)
        common_scripts\utility::exploder(5515);
      else if(var_0 == 2)
        common_scripts\utility::exploder(5525);
    }

    if(var_6 >= 1) {
      level.player disableinvulnerability();
      level.player kill();
      continue;
    }

    thread sam_regen_health();
  }
}

sam_regen_health() {
  level.player endon("remove_sam_control");
  level.player endon("exit_sam");
  level.player endon("death");
  self endon("damage");
  wait 3;

  while(level.sam_health < level.sam_max_health) {
    level.sam_health = clamp(level.sam_health + level.sam_max_health / 10 * 0.05, 0, level.sam_max_health);
    var_0 = (1 - level.sam_health / level.sam_max_health) * 0.5;
    level.player digitaldistortsetparams(var_0, var_0);
    wait 0.05;
  }
}

sam_control() {
  self endon("remove_sam_control");
  self endon("exit_sam");
  self endon("death");
  sam_hud();

  if(!isDefined(self.lockon_sequence_active))
    self.lockon_sequence_active = 0;

  wait 0.25;
  level.sam_launchers[level.sam_launcher_index].angles = vectortoangles(level.ac_130.origin - self getEye()) + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), 0);

  for(;;) {
    var_0 = self getnormalizedcameramovement();

    if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
      var_0 = (var_0[0], var_0[1] * -1, 0);

    if(abs(var_0[0]) < 0.1)
      var_0 = (0.0, var_0[1], var_0[1]);

    if(abs(var_0[1]) < 0.1)
      var_0 = (var_0[0], 0.0, var_0[1]);

    level.sam_launchers[level.sam_launcher_index].angles = level.sam_launchers[level.sam_launcher_index].angles - (var_0[0] * common_scripts\utility::ter_op(getdvarfloat("cg_fov") >= 65, 3.75, 1.0625) * common_scripts\utility::ter_op(self.lockon_sequence_active, 0.5, 1.0), var_0[1] * common_scripts\utility::ter_op(getdvarfloat("cg_fov") >= 65, 3.75, 1.0625) * common_scripts\utility::ter_op(self.lockon_sequence_active, 0.5, 1.0), 0);
    level.sam_launchers[level.sam_launcher_index].angles = (clamp(angleclamp180(level.sam_launchers[level.sam_launcher_index].angles[0]), -30, 30), clamp(level.sam_launchers[level.sam_launcher_index].angles[1], -65, 100), level.sam_launchers[level.sam_launcher_index].angles[2]);
    wait 0.05;
  }
}

sam_use_auto_lock_on() {
  self endon("exit_sam");
  self endon("remove_sam_control");
  self endon("death");
  self notifyonplayercommand("fire_missiles", "+attack");
  self notifyonplayercommand("fire_missiles", "+speed_throw");
  self notifyonplayercommand("fire_missiles", "+attack_akimbo_accessible");

  for(;;) {
    self.lockon_sequence_active = 0;
    thread sam_start_missile_lockon();

    while(level.sam_lockon_targets.size == 0)
      self waittill("fire_missiles");

    self notify("sam_missile_lockon_end");

    if(self.lockon_sequence_active) {
      self notify("end_lockon_sequence");
      self.lockon_sequence_active = 0;
    }

    sam_fire_missiles();
    wait 1.25;
  }
}

sam_ads() {
  self endon("exit_sam");
  self endon("remove_sam_control");
  self endon("death");
  self notifyonplayercommand("ads_on", "+speed_throw");
  self notifyonplayercommand("ads_off", "-speed_throw");
  self.sam_ads = 0;

  for(;;) {
    if(!self adsButtonPressed())
      self waittill("ads_on");

    self lerpfov(15, 0.25);
    self.sam_ads = 1;
    wait 0.25;

    if(self adsButtonPressed())
      self waittill("ads_off");

    self lerpfov(65, 0.25);
    self.sam_ads = 0;
    wait 0.25;
  }
}

sam_start_missile_lockon() {
  self endon("exit_sam");
  self endon("remove_sam_control");
  self endon("sam_missile_lockon_end");
  self endon("death");
  var_0 = self;
  var_1 = 0.0;
  var_2 = 0.0;
  var_3 = 0;
  var_4 = 64;
  var_5 = 32;
  var_6 = 784000000;
  self.lockon_sequence_active = 0;

  if(!isDefined(level.sam_targets))
    level.sam_targets = [];

  for(;;) {
    if(isDefined(level.sam_lockon_targets) && level.sam_lockon_targets.size < 1) {
      if(var_0 == self) {
        var_7 = undefined;
        var_8 = 999999999;

        foreach(var_10 in level.sam_targets) {
          if(isDefined(var_10) && isalive(var_10) && !common_scripts\utility::array_contains(level.sam_lockon_targets, var_10) && target_istarget(var_10) && target_isinrect(var_10, self, getdvarfloat("cg_fov"), var_4, var_5) && (var_10.classname != "script_vehicle_y_8_gunship" || !isDefined(var_10.attacked_this_run) || !var_10.attacked_this_run)) {
            var_11 = distancesquared(var_10.origin, self.origin);

            if(!isDefined(var_7) || var_11 < var_8) {
              if(var_11 < var_6) {
                var_7 = var_10;
                var_8 = var_11;
              }
            }
          }
        }

        var_0 = var_7;

        if(isDefined(var_0)) {
          if(var_0.classname == "script_vehicle_y_8_gunship")
            var_1 = 0.75;
          else
            var_1 = 0.25;

          var_2 = 0.0;
          var_3 = 0;
          thread looplocalseeksound("scn_carr_sparrow_target", 0.4);
          target_hidefromplayer(var_0, self);
          var_0 hudoutlinedisable();

          if(!self.lockon_sequence_active) {
            self notify("start_lockon_sequence");
            self.lockon_sequence_active = 1;
          }
        } else {
          var_0 = self;

          if(self.lockon_sequence_active) {
            self notify("stop_lockon_sound");
            self notify("end_lockon_sequence");
            self.lockon_sequence_active = 0;
            self.sam_hud_elements["gunship"].alpha = 0;
            self.sam_hud_elements["helicopter"].alpha = 0;
            self.sam_hud_elements["inflatable"].alpha = 0;
            self.sam_hud_elements["class_2"].alpha = 0;
            self.sam_hud_elements["class_4"].alpha = 0;
            self.sam_hud_elements["engage"].alpha = 0;
          }
        }
      } else {
        if(!isDefined(var_0) || !target_istarget(var_0)) {
          self notify("stop_lockon_sound");
          var_0 = self;
          continue;
        }

        var_1 = var_1 - 0.05;
        var_2 = var_2 + 0.05;

        if(var_1 < 0.0) {
          self notify("stop_lockon_sound");
          self.sam_hud_elements["gunship"].alpha = 0;
          self.sam_hud_elements["helicopter"].alpha = 0;
          self.sam_hud_elements["inflatable"].alpha = 0;
          self.sam_hud_elements["class_2"].alpha = 0;
          self.sam_hud_elements["class_4"].alpha = 0;
          self.sam_hud_elements["engage"].alpha = 1;

          if(var_0 maps\_vehicle::ishelicopter()) {
            self.sam_hud_elements["helicopter"].alpha = 1;
            self.sam_hud_elements["class_2"].alpha = 1;
          } else if(var_0.classname == "script_vehicle_y_8_gunship") {
            self.sam_hud_elements["gunship"].alpha = 1;
            self.sam_hud_elements["class_4"].alpha = 1;
          } else {
            self.sam_hud_elements["inflatable"].alpha = 1;
            self.sam_hud_elements["class_2"].alpha = 1;
          }

          target_showtoplayer(var_0, self);
          target_drawcornersonly(var_0, 0);
          var_0 hudoutlineenable(0, 1);
          var_0.lased = 1;
          thread sam_break_lockon(var_0, var_4, var_5);
          level.sam_lockon_targets = common_scripts\utility::array_add(level.sam_lockon_targets, var_0);
          var_0 = self;
          self playlocalsound("scn_carr_sparrow_lock");
        } else if(!target_isinrect(var_0, self, getdvarfloat("cg_fov"), var_4, var_5)) {
          self notify("stop_lockon_sound");
          target_hidefromplayer(var_0, self);
          var_0 hudoutlinedisable();
          var_0 = self;
          self.sam_hud_elements["gunship"].alpha = 0;
          self.sam_hud_elements["helicopter"].alpha = 0;
          self.sam_hud_elements["inflatable"].alpha = 0;
          self.sam_hud_elements["class_4"].alpha = 0;
          self.sam_hud_elements["class_2"].alpha = 0;
          self.sam_hud_elements["engage"].alpha = 0;
        } else if(var_2 == 0.05) {
          var_2 = 0.0;
          var_3 = !var_3;

          if(var_3)
            target_showtoplayer(var_0, self);
          else
            target_hidefromplayer(var_0, self);
        }
      }
    }

    wait 0.05;
  }
}

sam_break_lockon(var_0, var_1, var_2) {
  self endon("death");
  self endon("lockon_broken");
  var_0 endon("death");

  while(target_isinrect(var_0, self, getdvarfloat("cg_fov"), var_1 * 1.25, var_2 * 1.25))
    wait 0.05;

  target_hidefromplayer(var_0, self);
  target_drawcornersonly(var_0, 1);
  var_0 hudoutlinedisable();
  var_0.lased = 0;
  level.sam_lockon_targets = common_scripts\utility::array_remove(level.sam_lockon_targets, var_0);

  if(var_0.classname != "script_vehicle_y_8_gunship") {
    var_0 thread sam_add_target();
    var_0 = self;
  }

  self notify("lockon_broken");
}

looplocalseeksound(var_0, var_1) {
  self endon("stop_lockon_sound");
  self endon("death");

  for(;;) {
    self playlocalsound(var_0);
    wait(var_1);
  }
}

sam_fire_missiles() {
  self endon("remove_sam_control");
  self endon("exit_sam");
  self endon("death");
  var_0 = 0;

  foreach(var_2 in level.sam_lockon_targets) {
    if(isDefined(var_2) && target_istarget(var_2) && isalive(var_2) && level.sam_missiles.size > 0) {
      var_0 = 1;
      target_setattackmode(var_2, "direct");
      target_hidefromplayer(var_2, self);
      var_2 hudoutlinedisable();

      if(var_2.classname == "script_vehicle_y_8_gunship") {
        var_2.attacked_this_run = 1;
        var_3 = anglesToForward(var_2.angles) * 256 + (0, 0, 64);

        if(!isDefined(var_2.left_missile_target))
          var_2.left_missile_target = spawn("script_origin", var_2.origin);

        if(!isDefined(var_2.right_missile_target))
          var_2.right_missile_target = spawn("script_origin", var_2.origin);

        if(!isDefined(var_2.bottom_missile_target))
          var_2.bottom_missile_target = spawn("script_origin", var_2.origin);

        var_2.left_missile_target.origin = var_2.origin + var_3 - anglestoright(self getplayerangles()) * 5000;
        var_2.right_missile_target.origin = var_2.origin + var_3 + anglestoright(self getplayerangles()) * 5000;
        var_2.bottom_missile_target.origin = var_2.origin + var_3 - anglestoup(self getplayerangles()) * 1000;
        var_2 thread sam_update_missile_targets();

        for(var_4 = 0; var_4 < 4; var_4++) {
          var_5 = sam_fire_missile();

          if(var_4 == 0) {
            var_5 thread sam_missile_lockon(var_2.left_missile_target);
            var_2.left_missile_target.missile = var_5;
          } else if(var_4 == 2) {
            var_5 thread sam_missile_lockon(var_2.right_missile_target);
            var_2.right_missile_target.missile = var_5;
          } else if(var_4 == 3) {
            var_5 thread sam_missile_lockon(var_2.bottom_missile_target);
            var_2.bottom_missile_target.missile = var_5;
          } else {
            var_5 thread sam_missile_lockon(var_2);
            var_2 notify("sam_targeted", var_5);
          }

          earthquake(0.4, 0.15, self.origin, 999999999);
          self playrumbleonentity("ac130_40mm_fire");
          wait(randomfloatrange(0.05, 0.15));
        }
      } else {
        for(var_4 = 0; var_4 < 2; var_4++) {
          var_5 = sam_fire_missile();
          var_2 notify("sam_targeted", var_5);
          var_5 thread sam_missile_lockon(var_2);
          earthquake(0.4, 0.15, self.origin, 999999999);
          self playrumbleonentity("ac130_40mm_fire");
          wait(randomfloatrange(0.05, 0.15));
        }
      }

      self.sam_hud_elements["gunship"].alpha = 0;
      self.sam_hud_elements["helicopter"].alpha = 0;
      self.sam_hud_elements["inflatable"].alpha = 0;
      self.sam_hud_elements["class_2"].alpha = 0;
      self.sam_hud_elements["class_4"].alpha = 0;
      self.sam_hud_elements["engage"].alpha = 0;
    }
  }

  level.sam_targets = common_scripts\utility::array_remove_array(level.sam_targets, level.sam_lockon_targets);
  level.sam_lockon_targets = [];
}

sam_fire_missile() {
  self endon("remove_sam_control");
  self endon("exit_sam");
  var_0 = level.sam_missiles[0];
  var_1 = magicbullet("sparrow_missile", var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 100000, level.player);
  level notify("sparrow_missile_fired");
  level.sam_missiles = maps\_utility::array_remove_index(level.sam_missiles, 0);
  wait 0.05;
  var_0 hide();
  var_0 thread sam_reload_missile();
  return var_1;
}

sam_reload_missile() {
  self endon("remove_sam_control");
  self endon("exit_sam");
  self endon("death");
  wait 1;
  level.sam_missiles[level.sam_missiles.size] = self;
}

get_current_sam() {
  return level.sam_launchers[level.sam_launcher_index];
}

load_sam_missiles() {
  level.sam_missiles = [];
  var_0 = 1;

  for(var_1 = 0; var_1 < 12; var_1++) {
    var_2 = get_current_sam() gettagorigin("tag_missile" + var_0);
    var_3 = get_current_sam() gettagangles("tag_missile" + var_0);
    level.sam_missiles[var_1] = spawn("script_model", var_2);
    level.sam_missiles[var_1] setModel("tag_origin");
    level.sam_missiles[var_1].angles = var_3;
    level.sam_missiles[var_1] linkto(get_current_sam());
    level.sam_missiles[var_1].missile_index = var_0;
    level.sam_missiles[var_1] setcontents(0);

    if(maps\carrier_code::modulus(var_1, 2) == 0) {
      var_0 = var_0 + 6;
      continue;
    }

    var_0 = var_0 - 5;
  }
}

clear_sam_missiles() {
  if(isDefined(level.sam_missiles) && level.sam_missiles.size > 0) {
    foreach(var_1 in level.sam_missiles) {
      var_1 unlink();
      var_1 delete();
    }
  }
}

sam_add_target() {
  if(!isDefined(level.sam_targets))
    level.sam_targets = [];

  if(!common_scripts\utility::array_contains(level.sam_targets, self)) {
    level.sam_targets[level.sam_targets.size] = self;
    add_target(self);
  }

  foreach(var_1 in level.sam_targets) {
    if(isDefined(var_1))
      var_1 thread remove_sam_target_on_death();
  }
}

add_target(var_0) {
  var_0 enableaimassist();
  target_set(var_0);
  target_setshader(var_0, "crr_hud_lock_on_box");
  target_setscaledrendermode(var_0, 1);
  target_hidefromplayer(var_0, level.player);
  target_drawcornersonly(var_0, 1);
  target_setmaxsize(var_0, 160);
}

remove_sam_target_on_death() {
  self notify("remove_on_death_call");
  self endon("remove_on_death_call");
  level.player endon("stop_using_sam");
  level.player endon("death");
  common_scripts\utility::waittill_any("death", "delete");

  if(isDefined(self) && target_istarget(self)) {
    target_remove(self);
    level.sam_targets = common_scripts\utility::array_remove(level.sam_targets, self);

    if(isDefined(level.sam_lockon_targets))
      level.sam_lockon_targets = common_scripts\utility::array_remove(level.sam_lockon_targets, self);
  }

  if(isDefined(level.sam_targets))
    level.sam_targets = common_scripts\utility::array_removeundefined(level.sam_targets);

  if(isDefined(level.sam_lockon_targets))
    level.sam_lockon_targets = common_scripts\utility::array_removeundefined(level.sam_lockon_targets);
}

sam_missile_lockon(var_0) {
  var_0 endon("death");
  wait 0.1;

  if(isDefined(var_0)) {
    var_1 = (0, 0, 0);

    if(isDefined(var_0.vehicletype) && var_0 maps\_vehicle::ishelicopter())
      var_1 = (0, 0, -80);
    else if(isDefined(var_0.vehicletype) && var_0 maps\_vehicle::isairplane())
      var_1 = (0, 0, 64);
    else if(isDefined(var_0.vehicletype) && var_0.classname == "script_vehicle_y_8_gunship")
      var_1 = anglesToForward(var_0.angles) * 256 + (0, 0, 64);
    else if(isDefined(var_0.vehicletype) && var_0.classname == "script_vehicle_zodiac_iw6")
      var_1 = (0, 0, 20);

    if(isDefined(self) && isvalidmissile(self))
      self missile_settargetent(var_0, var_1);
  }

  var_2 = 10;
  thread missile_life(var_0, var_2);
  thread kill_target(var_0);
}

sam_update_missile_targets() {
  var_0 = distance(self.left_missile_target.origin, self.origin + anglesToForward(self.angles) * 256 + (0, 0, 64));
  var_1 = distance(self.bottom_missile_target.origin, self.origin + anglesToForward(self.angles) * 256 + (0, 0, 64));
  var_2 = 1.5;
  var_3 = 1.5;
  wait 0.35;

  while(var_3 > 0 && isDefined(self)) {
    var_4 = self.origin + anglesToForward(self.angles) * 256 + (0, 0, 64);
    self.left_missile_target.origin = var_4 + vectornormalize(self.left_missile_target.origin - var_4) * var_0 * var_3 / var_2;
    self.right_missile_target.origin = var_4 + vectornormalize(self.right_missile_target.origin - var_4) * var_0 * var_3 / var_2;
    self.bottom_missile_target.origin = var_4 + vectornormalize(self.bottom_missile_target.origin - var_4) * var_1 * var_3 / var_2;
    wait 0.05;
    var_3 = var_3 - 0.05;
  }

  if(isDefined(self)) {
    self.left_missile_target delete();
    self.right_missile_target delete();
    self.bottom_missile_target delete();
  }
}

missile_life(var_0, var_1) {
  self endon("death");
  var_0 common_scripts\utility::waittill_any_timeout(var_1, "missile_hit");
  self notify("missile_timer_ran_out");

  if(isDefined(self))
    self delete();
}

kill_target(var_0) {
  self endon("missile_timer_ran_out");
  self waittill("death");
  var_0 notify("missile_hit");

  if(isDefined(var_0.vehicletype) && var_0 maps\_vehicle::ishelicopter())
    var_0 kill();
  else if(isDefined(var_0.vehicletype) && var_0.classname == "script_vehicle_zodiac_iw6")
    var_0 notify("sparrow_hit_zodiac");
}