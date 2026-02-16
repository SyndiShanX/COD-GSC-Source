/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_code.gsc
*****************************************************/

init_system() {
  level.death_model_col = getent("death_collision_map", "targetname");
  level.scr_model["vehicle_t90ms_tank_destroyed_iw6"] = "vehicle_t90ms_tank_destroyed_iw6";
  level.friendly_thermal_reflector_effect = loadfx("fx/misc/thermal_tapereflect_inv_lrg");
  level.numberofhitstaken = 0;
  level.allyhitcount = 0;
  thread handle_friendly_fail();
  precachemodel("vehicle_gaz_tigr_base_destroyed_crushable");
  tank_tread_freq_all();
  common_scripts\utility::flag_init("playerTankNoDeath");
  common_scripts\utility::flag_init("stop_tank_chatter");
}

init_tank(var_0, var_1, var_2) {
  if(!isDefined(var_1) || !isPlayer(var_1))
    var_1 = level.player;

  if(isDefined(var_2))
    common_scripts\utility::flag_wait(var_2);

  var_0 mount_tank(var_1);
}

mount_tank(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    if(!isDefined(var_2))
      var_2 = 1.0;

    level.player thread static_on(var_2, 1.0);

    if(isDefined(var_3))
      wait(var_2);
  }

  if(!isDefined(var_4) || !var_4)
    thread mark_friendly_vehicles();

  var_6 = self;
  common_scripts\utility::flag_set("player_in_tank");
  var_0 enableinvulnerability();
  var_0 enableslowaim(0.5, 0.25);
  var_7 = var_6 gettagangles("tag_flash");
  var_7 = (var_7[0], var_7[1], 0);
  var_0 setplayerangles(var_7);
  level.player maps\_utility::player_mount_vehicle(var_6);
  var_6 makeunusable();
  setsaveddvar("cg_viewVehicleInfluence", 0.1);
  setsaveddvar("aim_aimAssistRangeScale", "1");
  setsaveddvar("aim_autoAimRangeScale", "1");
  var_0 allowprone(0);
  var_0 allowcrouch(0);
  var_0 enableweaponswitch();
  var_0 enableoffhandweapons();
  var_0 enableweapons();
  thread tank_zoom();
  level.player thread take_fire_tracking();
  var_6 thread tank_rumble();
  var_6 thread tank_quake();
  var_6 thread tank_health_monitor();
  var_6 thread tank_boost();
  level.player thread tank_hud(var_6, var_5, var_4);
  var_6 thread on_fire_main_cannon();
  var_6 thread on_fire_mg();
  var_6 thread tank_handle_sabot(var_4);
  var_6 thread on_pop_smoke();
  var_6 thread on_fire_sabot();
  level.player thread toggle_thermal();
  level.player.old_contents = level.player.contents;
  level.player.contents = 0;
  level.playertank listen_player();
  thread exiting_combat_zone();
  thread fire_tracking_missile_mig();
  level thread maps\satfarm_audio::player_tank_sounds();
  var_0 lerpviewangleclamp(1, 0.05, 0.05, 180, 180, 30, 5);
  var_6 thread player_view_clamp();

  if(isDefined(level.player.was_in_thermal) && level.player.was_in_thermal) {
    level.player.was_in_thermal = 0;
    level.player notify("thermal");
  }
}

dismount_tank(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1) {
    if(!isDefined(var_2))
      var_2 = 1.0;

    var_0 thread static_on(var_2, 1.0);
  }

  if(!isDefined(var_3) || !var_3)
    remove_all_tags();

  var_5 = self;
  var_0 maps\_utility::player_dismount_vehicle();

  if(!isDefined(var_3) || !var_3)
    setsaveddvar("aim_aimAssistRangeScale", "1");

  setsaveddvar("aim_autoAimRangeScale", "1");
  common_scripts\utility::flag_clear("player_in_tank");
  var_0 disableinvulnerability();
  var_0 disableslowaim();
  var_0 allowads(1);
  var_0 allowprone(1);
  var_0 allowcrouch(1);
  var_0 uav_thermal_off();
  level.player digitaldistortsetparams(0, 0);

  if(!isDefined(var_3) || !var_3) {
    var_0 notify("tank_dismount");
    var_0 enableoffhandweapons();
  } else {
    level.old_kill_fail_flag = common_scripts\utility::flag("kill_fail_flag");
    var_0 notify("missile_tank_dismount");

    if(isDefined(level.hintelement))
      level.hintelement maps\_hud_util::destroyelem();

    if(isDefined(level.playertank))
      level.playertank vehicle_setspeedimmediate(0, 100, 100);

    var_0 disableoffhandweapons();
    thread disable_all_triggers();
    stopallrumbles();
  }

  var_5 notify("stop_do_damage_from_tank");
  var_0.contents = var_0.old_contents;
  var_0 thread tank_clear_hud(var_4);
  common_scripts\utility::flag_clear("MG_FIRE");
  common_scripts\utility::flag_set("dismounted_tank");
}

player_view_clamp() {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");

  for(;;) {
    var_0 = vectornormalize(self gettagorigin("tag_barrel") - self.origin);
    var_1 = anglesToForward(self.angles);
    var_2 = vectordot(var_1, var_0);

    if(var_2 <= -0.5)
      level.player lerpviewangleclamp(0, 0, 0, 180, 180, 30, 5);
    else
      level.player lerpviewangleclamp(0, 0, 0, 180, 180, 30, 15);

    wait 0.25;
  }
}

mark_friendly_vehicles() {
  level endon("remove_all_tags");

  for(;;) {
    foreach(var_1 in vehicle_getarray()) {
      if(var_1.script_team == "allies" && var_1 != level.playertank && var_1 istank() && !isDefined(var_1.chevron_tag)) {
        var_1.chevron_tag = var_1 common_scripts\utility::spawn_tag_origin();
        var_1.chevron_tag linkto(var_1, "tag_origin", (0, 0, 150), (0, 0, 0));
        playFXOnTag(common_scripts\utility::getfx("friendly_tank_chevron"), var_1.chevron_tag, "tag_origin");
        var_1 thread remove_tag_on_death();
      }
    }

    wait 0.05;
  }
}

remove_tag_on_death() {
  common_scripts\utility::waittill_any("death", "remove_tags");

  if(isDefined(self.chevron_tag)) {
    stopFXOnTag(common_scripts\utility::getfx("friendly_tank_chevron"), self.chevron_tag, "tag_origin");
    self.chevron_tag delete();
    self.chevron_tag = undefined;
  }

  if(isDefined(self.reflector_tag)) {
    self.reflector_tag delete();
    self.reflector_tag = undefined;
  }
}

remove_all_tags() {
  level notify("remove_all_tags");

  foreach(var_1 in vehicle_getarray()) {
    if(var_1.script_team == "allies")
      var_1 notify("remove_tags");
  }
}

tank_rumble() {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  var_0 = self;
  var_1 = spawn("script_origin", var_0.driver.origin + (0, 0, 500));
  var_1 playrumblelooponentity("subtler_tank_rumble");
  thread cleanup_rumble_on_death(var_1);
  thread cleanup_rumble_on_dismount(var_1);
  var_2 = gettime();

  for(;;) {
    var_3 = var_0 vehicle_getspeed();
    var_4 = clamp(1 - var_3 / 50, 0.0, 1.0);
    var_5 = 400 + 100 * var_4;
    var_1 unlink();
    var_1 linkto(level.player, "", (0.0, 0.0, var_5), (0, 0, 0));
    wait 0.1;
  }
}

cleanup_rumble_on_death(var_0) {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0 stoprumble("subtler_tank_rumble");
    var_0 delete();
  }
}

cleanup_rumble_on_dismount(var_0) {
  self endon("death");
  level.player common_scripts\utility::waittill_either("tank_dismount", "missile_tank_dismount");

  if(isDefined(var_0)) {
    var_0 stoprumble("subtler_tank_rumble");
    var_0 delete();
  }
}

tank_quake() {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  var_0 = self;
  var_1 = gettime();
  level.isfiring = 0;

  for(;;) {
    var_2 = var_0 vehicle_getspeed();
    var_3 = clamp(var_2 / 50, 0.0, 1.0);

    if(level.isfiring) {
      earthquake(0.4, 1.0, var_0.driver.origin, 512);
      wait 0.9;
      level.isfiring = 0;
      continue;
    }

    var_4 = 0.05 + 0.05 * var_3;
    earthquake(var_4, 0.25, var_0.driver.origin, 512);
    wait 0.05;
  }
}

tank_health_monitor() {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level endon("final_hit");

  if(!isDefined(self.current_hit_count))
    self.current_hit_count = 0;

  if(level.gameskill == 3)
    self.max_hit_count = 4;
  else if(level.gameskill == 2)
    self.max_hit_count = 5;
  else
    self.max_hit_count = 6;

  self.max_health = self.health;

  while(!common_scripts\utility::flag("final_hit")) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    var_4 = tolower(var_4);

    if(var_4 != "mod_projectile" && var_4 != "mod_projectile_splash" && var_4 != "mod_explosive" || isDefined(var_1.script_team) && var_1.script_team == "allies") {
      self.health = self.max_health;
      continue;
    }

    if(!common_scripts\utility::flag("playerTankNoDeath"))
      self.current_hit_count++;
    else if(self.current_hit_count < self.max_hit_count - 1)
      self.current_hit_count++;
    else
      self.current_hit_count = self.max_hit_count - 1;

    level.numberofhitstaken++;
    earthquake(0.5, 1.0, self.origin, 512);
    level.player playrumbleonentity("damage_heavy");
    level.player viewkick(1, var_3);
    var_5 = 1 / self.max_hit_count * (self.current_hit_count * 0.5);
    level.player digitaldistortsetparams(var_5, var_5);

    if(self.current_hit_count >= self.max_hit_count) {
      self makeusable();
      self useby(level.player);
      level.player disableinvulnerability();
      level.player kill();
      self kill();
      return;
    } else {
      self.health = self.maxhealth;
      thread tank_health_regen();
    }
  }
}

tank_health_regen() {
  level.player endon("tank_dismount");
  level endon("final_hit");
  self endon("damage");
  self endon("death");
  var_0 = 3;

  while(self.current_hit_count > 0) {
    wait(var_0);
    self.current_hit_count--;
    self notify("regen");
    var_1 = 1 / self.max_hit_count * (self.current_hit_count * 0.5);
    level.player digitaldistortsetparams(var_1, var_1);

    if(var_0 > 1) {
      if(var_0 > 0) {
        var_0 = var_0 - 1;
        continue;
      }

      level.player digitaldistortsetparams(0, 0);
      self.current_hit_count = 0;
      break;
    }
  }

  level.player painvisionoff();
}

tank_save(var_0) {
  level endon("air_strip_end");

  while(self.current_hit_count > 0)
    common_scripts\utility::waitframe();

  maps\_utility::autosave_by_name(var_0);
}

tank_boost() {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  var_0 = [];
  var_0[var_0.size] = "satfarm_td1_punchit";
  var_0[var_0.size] = "satfarm_td1_move";
  var_0[var_0.size] = "satfarm_td1_floorit";
  var_0[var_0.size] = "satfarm_td1_fullthrottle";
  var_1 = 0;

  for(;;) {
    level.playertank waittill("veh_boost_activated");
    thread radio_dialog_add_and_go(var_0[var_1], 0.1, 0);
    var_1++;

    if(var_1 >= var_0.size)
      var_1 = 0;
  }
}

tank_zoom() {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("zoomin", "+speed_throw");
  level.player notifyonplayercommand("zoomout", "-speed_throw");
  level.player notifyonplayercommand("zoomin", "+toggleads_throw");
  level.player notifyonplayercommand("zoomout", "+toggleads_throw");
  level.player notifyonplayercommand("zoomin", "+speed");
  level.player notifyonplayercommand("zoomout", "-speed");
  level.player notifyonplayercommand("zoomin", "+ads_akimbo_accessible");
  level.player notifyonplayercommand("zoomout", "+ads_akimbo_accessible");
  level.zoomlevel = 15;

  while(!common_scripts\utility::flag("optics_out")) {
    level.player waittill("zoomin");

    if(isDefined(level.player.tank_hud_item["current_weapon"]) && level.player.tank_hud_item["current_weapon"].weap != "turret") {
      continue;
    }
    level.player thread tank_dynamic_zoom_monitor();
    common_scripts\utility::flag_set("PLAYER_ZOOMED_ONCE");
    common_scripts\utility::flag_set("ZOOM_ON");
    level.player waittill("zoomout");

    if(isDefined(level.player.tank_hud_item["current_weapon"]) && level.player.tank_hud_item["current_weapon"].weap != "turret") {
      continue;
    }
    level.player lerpfov(65, 0.15);
    level.player.tank_hud_item["turret_zoom"] settext("1.0 X");
    common_scripts\utility::flag_clear("ZOOM_ON");
  }
}

tank_dynamic_zoom_monitor() {
  self endon("zoomout");
  self endon("tank_dismount");
  self endon("missile_tank_dismount");
  var_0 = 65;
  var_1 = var_0;
  var_2 = 18000;
  var_3 = 500;
  var_4 = tan(var_0) * var_3;
  var_5 = 20;
  var_6 = 0.1;

  for(;;) {
    var_7 = 0;
    var_8 = [];

    foreach(var_10 in target_getarray()) {
      if(target_isinrect(var_10, self, var_0, 30, 30) && distancesquared(self getEye(), var_10.origin) < var_2 * var_2 && var_10 sightconetrace(self getEye()) != 0)
        var_8[var_8.size] = var_10;
    }

    if(var_8.size > 0) {
      var_12 = (0, 0, 0);

      foreach(var_10 in var_8)
      var_12 = var_12 + var_10.origin;

      var_12 = var_12 / var_8.size;
      var_15 = distance(var_12, self getEye());

      if(var_15 > var_3) {
        var_16 = atan(var_4 / var_15);

        if(var_16 <= var_5) {
          var_1 = var_16;
          self lerpfov(var_16, var_6);
          var_7 = 1;
        }
      }
    }

    if(!var_7 && getdvarfloat("cg_fov") != var_5) {
      var_1 = var_5;
      self lerpfov(var_5, var_6);
    }

    var_17 = var_0 / var_1;
    var_17 = int(var_17 * 10) / 10;
    var_18 = "" + var_17 + common_scripts\utility::ter_op(modulus(var_17, 10) == 0, ".0 X", " X");
    self.tank_hud_item["turret_zoom"] settext(var_18);
    wait 0.1;
    var_6 = 0.5;
  }
}

toggle_zoom() {
  level.player notifyonplayercommand("zoom", "+actionslot 4");

  for(;;) {
    iprintlnbold("Zoom 20 DEFAULT.");
    level.zoomlevel = 20;
    wait 0.05;
    level.player waittill("zoom");
    iprintlnbold("Zoom 30.");
    level.zoomlevel = 30;
    wait 0.05;
    level.player waittill("zoom");
    iprintlnbold("Zoom 40.");
    level.zoomlevel = 40;
    wait 0.05;
    level.player waittill("zoom");
    iprintlnbold("Zoom 50.");
    level.zoomlevel = 50;
    wait 0.05;
    level.player waittill("zoom");
    iprintlnbold("Zoom 60.");
    level.zoomlevel = 60;
    wait 0.05;
    level.player waittill("zoom");
    iprintlnbold("Zoom 65.");
    level.zoomlevel = 65;
    wait 0.05;
    level.player waittill("zoom");
  }
}

detectkill() {
  self.nodrop = 1;
  self.grenadeammo = 0;
  thread detectdamage();
  self waittill("death", var_0, var_1);

  if(isDefined(self)) {
    if(isai(self)) {
      if(isDefined(self.weapon) && self.weapon != "none")
        animscripts\shared::placeweaponon(self.weapon, "none");
    } else
      self hidepart("tag_weapon_right");
  }

  if(isDefined(var_1) && isDefined(var_0) && isDefined(level.playertank) && var_0 == level.playertank) {
    var_1 = tolower(var_1);

    if(var_1 == "mod_crush") {
      thread common_scripts\utility::play_sound_in_space("satf_body_crush_plr", self.origin);
      thread common_scripts\utility::play_sound_in_space("satfarm_crush_scream_plr", self.origin);
      level.player screenshakeonentity(4.0, 1.0, 1.0, 0.5, 0, 0.25, 0, 2.0, 0.5, 0.5);
      level.player playrumbleonentity("damage_light");
    }
  }
}

detectdamage() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_4) && isDefined(var_1) && isDefined(level.playertank) && var_1 == level.playertank) {
    var_4 = tolower(var_4);

    if(var_4 == "mod_crush") {
      if(isDefined(self) && self.health == 0)
        self.noragdoll = 1;
    }
  }
}

tank_hud(var_0, var_1, var_2) {
  level notify("clear_tank_hud");
  var_3 = 0.66;

  if(isDefined(var_2) && var_2)
    var_3 = 0.0;

  self.tank_hud_item["tank_overlay"] = maps\_hud_util::createicon("ugv_vignette_overlay", 640, 480);
  self.tank_hud_item["tank_overlay"] set_default_hud_parameters();
  self.tank_hud_item["tank_overlay"].alignx = "left";
  self.tank_hud_item["tank_overlay"].aligny = "top";
  self.tank_hud_item["tank_overlay"].horzalign = "fullscreen";
  self.tank_hud_item["tank_overlay"].vertalign = "fullscreen";
  self.tank_hud_item["tank_overlay"].alpha = 0.5;
  self.tank_hud_item["tank_overlay"].sort = self.tank_hud_item["tank_overlay"].sort - 5;
  self.tank_hud_item["reticle"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle", 400, 200);
  self.tank_hud_item["reticle"] set_default_hud_parameters();
  self.tank_hud_item["reticle"].alignx = "center";
  self.tank_hud_item["reticle"].aligny = "middle";
  self.tank_hud_item["reticle"].alpha = var_3;
  self.tank_hud_item["reticle_center"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_center", 20, 20);
  self.tank_hud_item["reticle_center"] set_default_hud_parameters();
  self.tank_hud_item["reticle_center"].alignx = "center";
  self.tank_hud_item["reticle_center"].aligny = "middle";
  self.tank_hud_item["reticle_center"].alpha = var_3;
  self.tank_hud_item["reticle_center_cyan"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_center_cyan", 20, 20);
  self.tank_hud_item["reticle_center_cyan"] set_default_hud_parameters();
  self.tank_hud_item["reticle_center_cyan"].alignx = "center";
  self.tank_hud_item["reticle_center_cyan"].aligny = "middle";
  self.tank_hud_item["reticle_center_cyan"].alpha = 0.0;
  self.tank_hud_item["reticle_center_red"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_center_red", 20, 20);
  self.tank_hud_item["reticle_center_red"] set_default_hud_parameters();
  self.tank_hud_item["reticle_center_red"].alignx = "center";
  self.tank_hud_item["reticle_center_red"].aligny = "middle";
  self.tank_hud_item["reticle_center_red"].alpha = 0.0;
  self.tank_hud_item["reticle_cross"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_cross", 88, 88);
  self.tank_hud_item["reticle_cross"] set_default_hud_parameters();
  self.tank_hud_item["reticle_cross"].alignx = "center";
  self.tank_hud_item["reticle_cross"].aligny = "middle";
  self.tank_hud_item["reticle_cross"].alpha = var_3;
  self.tank_hud_item["reticle_cross_cyan"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_cross_cyan", 88, 88);
  self.tank_hud_item["reticle_cross_cyan"] set_default_hud_parameters();
  self.tank_hud_item["reticle_cross_cyan"].alignx = "center";
  self.tank_hud_item["reticle_cross_cyan"].aligny = "middle";
  self.tank_hud_item["reticle_cross_cyan"].alpha = 0.0;
  self.tank_hud_item["reticle_cross_red"] = maps\_hud_util::createicon("m1a1_tank_primary_reticle_cross_red", 88, 88);
  self.tank_hud_item["reticle_cross_red"] set_default_hud_parameters();
  self.tank_hud_item["reticle_cross_red"].alignx = "center";
  self.tank_hud_item["reticle_cross_red"].aligny = "middle";
  self.tank_hud_item["reticle_cross_red"].alpha = 0.0;
  self.tank_hud_item["compass_heading"] = maps\_hud_util::createicon("m1a1_compass_center", 10, 20);
  self.tank_hud_item["compass_heading"] set_default_hud_parameters();
  self.tank_hud_item["compass_heading"].alignx = "center";
  self.tank_hud_item["compass_heading"].aligny = "top";
  self.tank_hud_item["compass_heading"].vertalign = "top";
  self.tank_hud_item["compass_heading"].x = 0;
  self.tank_hud_item["compass_heading"].y = 10;
  self.tank_hud_item["compass_heading"].alpha = 0.9;
  self.tank_hud_item["turret_zoom"] = maps\_hud_util::createclientfontstring("small", 1.3);
  self.tank_hud_item["turret_zoom"] set_default_hud_parameters();
  self.tank_hud_item["turret_zoom"].alignx = "right";
  self.tank_hud_item["turret_zoom"].aligny = "bottom";
  self.tank_hud_item["turret_zoom"].alpha = 0.9;
  self.tank_hud_item["turret_zoom"].x = 0 - self.tank_hud_item["reticle"].width * 0.4;
  self.tank_hud_item["turret_zoom"].y = -5;
  self.tank_hud_item["turret_zoom"] settext("1.0 X");
  self.tank_hud_item["turret_state_bg"] = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  self.tank_hud_item["turret_state_bg"] set_default_hud_parameters();
  self.tank_hud_item["turret_state_bg"].alignx = "center";
  self.tank_hud_item["turret_state_bg"].aligny = "middle";
  self.tank_hud_item["turret_state_bg"].vertalign = "bottom";
  self.tank_hud_item["turret_state_bg"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_state_bg"].y = -50;
  self.tank_hud_item["turret_state_bg"].alpha = 0.9;
  self.tank_hud_item["turret_state"] = maps\_hud_util::createicon("green_block", 57, 5);
  self.tank_hud_item["turret_state"] set_default_hud_parameters();
  self.tank_hud_item["turret_state"].alignx = "left";
  self.tank_hud_item["turret_state"].aligny = "middle";
  self.tank_hud_item["turret_state"].vertalign = "bottom";
  self.tank_hud_item["turret_state"].x = 142 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_state"].y = -51;
  self.tank_hud_item["turret_state"].alpha = 0.4;
  self.tank_hud_item["turret_name"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["turret_name"] set_default_hud_parameters();
  self.tank_hud_item["turret_name"].alignx = "center";
  self.tank_hud_item["turret_name"].aligny = "bottom";
  self.tank_hud_item["turret_name"].vertalign = "bottom";
  self.tank_hud_item["turret_name"].alpha = 0.9;
  self.tank_hud_item["turret_name"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_name"].y = -57;
  self.tank_hud_item["turret_name"] settext(&"SATFARM_TANK_TURRET");
  self.tank_hud_item["turret_status"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["turret_status"] set_default_hud_parameters();
  self.tank_hud_item["turret_status"].alignx = "center";
  self.tank_hud_item["turret_status"].aligny = "top";
  self.tank_hud_item["turret_status"].vertalign = "bottom";
  self.tank_hud_item["turret_status"].alpha = 0.9;
  self.tank_hud_item["turret_status"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_status"].y = -43;
  self.tank_hud_item["turret_status"] settext(&"SATFARM_READY");
  self.tank_hud_item["turret_offline"] = maps\_hud_util::createclientfontstring("small", 1.6);
  self.tank_hud_item["turret_offline"] set_default_hud_parameters();
  self.tank_hud_item["turret_offline"].alignx = "center";
  self.tank_hud_item["turret_offline"].aligny = "middle";
  self.tank_hud_item["turret_offline"].vertalign = "bottom";
  self.tank_hud_item["turret_offline"].alpha = 0;
  self.tank_hud_item["turret_offline"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_offline"].y = -50;
  self.tank_hud_item["turret_offline"] settext(&"SATFARM_OFFLINE");
  self.tank_hud_item["turret_warning"] = maps\_hud_util::createicon("m1a1_tank_warning", 96, 96);
  self.tank_hud_item["turret_warning"] set_default_hud_parameters();
  self.tank_hud_item["turret_warning"].alignx = "center";
  self.tank_hud_item["turret_warning"].aligny = "middle";
  self.tank_hud_item["turret_warning"].vertalign = "bottom";
  self.tank_hud_item["turret_warning"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["turret_warning"].y = -50;
  self.tank_hud_item["turret_warning"].alpha = 0.0;
  self.tank_hud_item["missile_state_bg"] = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  self.tank_hud_item["missile_state_bg"] set_default_hud_parameters();
  self.tank_hud_item["missile_state_bg"].alignx = "center";
  self.tank_hud_item["missile_state_bg"].aligny = "middle";
  self.tank_hud_item["missile_state_bg"].vertalign = "bottom";
  self.tank_hud_item["missile_state_bg"].x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_state_bg"].y = -50;
  self.tank_hud_item["missile_state_bg"].alpha = 0.9;
  self.tank_hud_item["missile_state"] = maps\_hud_util::createicon("green_block", 57, 5);
  self.tank_hud_item["missile_state"] set_default_hud_parameters();
  self.tank_hud_item["missile_state"].alignx = "left";
  self.tank_hud_item["missile_state"].aligny = "middle";
  self.tank_hud_item["missile_state"].vertalign = "bottom";
  self.tank_hud_item["missile_state"].x = 242 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_state"].y = -51;
  self.tank_hud_item["missile_state"].alpha = 0.4;
  self.tank_hud_item["missile_name"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["missile_name"] set_default_hud_parameters();
  self.tank_hud_item["missile_name"].alignx = "center";
  self.tank_hud_item["missile_name"].aligny = "bottom";
  self.tank_hud_item["missile_name"].vertalign = "bottom";
  self.tank_hud_item["missile_name"].alpha = 0.25;
  self.tank_hud_item["missile_name"].x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_name"].y = -57;
  self.tank_hud_item["missile_name"] settext(&"SATFARM_TANK_MISSILE");
  self.tank_hud_item["missile_status"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["missile_status"] set_default_hud_parameters();
  self.tank_hud_item["missile_status"].alignx = "center";
  self.tank_hud_item["missile_status"].aligny = "top";
  self.tank_hud_item["missile_status"].vertalign = "bottom";
  self.tank_hud_item["missile_status"].alpha = 0.25;
  self.tank_hud_item["missile_status"].x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_status"].y = -43;
  self.tank_hud_item["missile_status"] settext(&"SATFARM_IDLE");
  self.tank_hud_item["missile_offline"] = maps\_hud_util::createclientfontstring("small", 1.6);
  self.tank_hud_item["missile_offline"] set_default_hud_parameters();
  self.tank_hud_item["missile_offline"].alignx = "center";
  self.tank_hud_item["missile_offline"].aligny = "middle";
  self.tank_hud_item["missile_offline"].vertalign = "bottom";
  self.tank_hud_item["missile_offline"].alpha = 0;
  self.tank_hud_item["missile_offline"].x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_offline"].y = -50;
  self.tank_hud_item["missile_offline"] settext(&"SATFARM_OFFLINE");
  self.tank_hud_item["missile_warning"] = maps\_hud_util::createicon("m1a1_tank_warning", 96, 96);
  self.tank_hud_item["missile_warning"] set_default_hud_parameters();
  self.tank_hud_item["missile_warning"].alignx = "center";
  self.tank_hud_item["missile_warning"].aligny = "middle";
  self.tank_hud_item["missile_warning"].vertalign = "bottom";
  self.tank_hud_item["missile_warning"].x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["missile_warning"].y = -50;
  self.tank_hud_item["missile_warning"].alpha = 0.0;
  self.tank_hud_item["current_weapon"] = maps\_hud_util::createicon("m1a1_tank_weapon_select_arrow", 12, 12);
  self.tank_hud_item["current_weapon"] set_default_hud_parameters();
  self.tank_hud_item["current_weapon"].alignx = "center";
  self.tank_hud_item["current_weapon"].aligny = "top";
  self.tank_hud_item["current_weapon"].vertalign = "bottom";
  self.tank_hud_item["current_weapon"].x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["current_weapon"].y = -26;
  self.tank_hud_item["current_weapon"].alpha = 0.9;
  self.tank_hud_item["current_weapon"].weap = "turret";
  var_3 = 0.0;

  if(isDefined(var_2) && var_2)
    var_3 = 0.66;

  self.tank_hud_item["sabot_overlay"] = maps\_hud_util::createicon("m1a1_tank_sabot_grid_overlay", 640, 480);
  self.tank_hud_item["sabot_overlay"] set_default_hud_parameters();
  self.tank_hud_item["sabot_overlay"].alignx = "left";
  self.tank_hud_item["sabot_overlay"].aligny = "top";
  self.tank_hud_item["sabot_overlay"].horzalign = "fullscreen";
  self.tank_hud_item["sabot_overlay"].vertalign = "fullscreen";
  self.tank_hud_item["sabot_overlay"].alpha = var_3;
  self.tank_hud_item["sabot_overlay"].sort = self.tank_hud_item["sabot_overlay"].sort - 5;
  self.tank_hud_item["sabot_vignette"] = maps\_hud_util::createicon("m1a1_tank_sabot_vignette", 640, 480);
  self.tank_hud_item["sabot_vignette"] set_default_hud_parameters();
  self.tank_hud_item["sabot_vignette"].alignx = "left";
  self.tank_hud_item["sabot_vignette"].aligny = "top";
  self.tank_hud_item["sabot_vignette"].horzalign = "fullscreen";
  self.tank_hud_item["sabot_vignette"].vertalign = "fullscreen";
  self.tank_hud_item["sabot_vignette"].alpha = var_3;
  self.tank_hud_item["sabot_vignette"].sort = self.tank_hud_item["sabot_vignette"].sort - 5;
  self.tank_hud_item["sabot_reticle"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center", 75, 75);
  self.tank_hud_item["sabot_reticle"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle"].alignx = "center";
  self.tank_hud_item["sabot_reticle"].aligny = "middle";
  self.tank_hud_item["sabot_reticle"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_cyan"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center_cyan", self.tank_hud_item["sabot_reticle"].width, self.tank_hud_item["sabot_reticle"].height);
  self.tank_hud_item["sabot_reticle_cyan"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_cyan"].alignx = "center";
  self.tank_hud_item["sabot_reticle_cyan"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_cyan"].alpha = 0.0;
  self.tank_hud_item["sabot_reticle_red"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center_red", self.tank_hud_item["sabot_reticle"].width, self.tank_hud_item["sabot_reticle"].height);
  self.tank_hud_item["sabot_reticle_red"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_red"].alignx = "center";
  self.tank_hud_item["sabot_reticle_red"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_red"].alpha = 0.0;
  self.tank_hud_item["sabot_reticle_upper_left"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_top_left", 20, 20);
  self.tank_hud_item["sabot_reticle_upper_left"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_upper_left"].alignx = "center";
  self.tank_hud_item["sabot_reticle_upper_left"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_upper_left"].x = self.tank_hud_item["sabot_reticle"].width * -1.25;
  self.tank_hud_item["sabot_reticle_upper_left"].y = self.tank_hud_item["sabot_reticle"].height * -0.5;
  self.tank_hud_item["sabot_reticle_upper_left"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_upper_right"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_top_right", 20, 20);
  self.tank_hud_item["sabot_reticle_upper_right"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_upper_right"].alignx = "center";
  self.tank_hud_item["sabot_reticle_upper_right"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_upper_right"].x = self.tank_hud_item["sabot_reticle"].width * 1.25;
  self.tank_hud_item["sabot_reticle_upper_right"].y = self.tank_hud_item["sabot_reticle"].height * -0.5;
  self.tank_hud_item["sabot_reticle_upper_right"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_bottom_left"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_bottom_left", 20, 20);
  self.tank_hud_item["sabot_reticle_bottom_left"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_bottom_left"].alignx = "center";
  self.tank_hud_item["sabot_reticle_bottom_left"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_bottom_left"].x = self.tank_hud_item["sabot_reticle"].width * -1.25;
  self.tank_hud_item["sabot_reticle_bottom_left"].y = self.tank_hud_item["sabot_reticle"].height * 0.5;
  self.tank_hud_item["sabot_reticle_bottom_left"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_bottom_right"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_bottom_right", 20, 20);
  self.tank_hud_item["sabot_reticle_bottom_right"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_bottom_right"].alignx = "center";
  self.tank_hud_item["sabot_reticle_bottom_right"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_bottom_right"].x = self.tank_hud_item["sabot_reticle"].width * 1.25;
  self.tank_hud_item["sabot_reticle_bottom_right"].y = self.tank_hud_item["sabot_reticle"].height * 0.5;
  self.tank_hud_item["sabot_reticle_bottom_right"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_outer_left"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_outer_left", 40, 320);
  self.tank_hud_item["sabot_reticle_outer_left"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_outer_left"].alignx = "center";
  self.tank_hud_item["sabot_reticle_outer_left"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_outer_left"].x = self.tank_hud_item["sabot_reticle"].width * -2;
  self.tank_hud_item["sabot_reticle_outer_left"].y = 0;
  self.tank_hud_item["sabot_reticle_outer_left"].alpha = var_3;
  self.tank_hud_item["sabot_reticle_outer_right"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_outer_right", 40, 320);
  self.tank_hud_item["sabot_reticle_outer_right"] set_default_hud_parameters();
  self.tank_hud_item["sabot_reticle_outer_right"].alignx = "center";
  self.tank_hud_item["sabot_reticle_outer_right"].aligny = "middle";
  self.tank_hud_item["sabot_reticle_outer_right"].x = self.tank_hud_item["sabot_reticle"].width * 2;
  self.tank_hud_item["sabot_reticle_outer_right"].y = 0;
  self.tank_hud_item["sabot_reticle_outer_right"].alpha = var_3;
  self.tank_hud_item["sabot_target_range"] = maps\_hud_util::createicon("m1a1_tank_sabot_target_range", 20, 320);
  self.tank_hud_item["sabot_target_range"] set_default_hud_parameters();
  self.tank_hud_item["sabot_target_range"].alignx = "center";
  self.tank_hud_item["sabot_target_range"].aligny = "middle";
  self.tank_hud_item["sabot_target_range"].x = self.tank_hud_item["sabot_reticle"].width * 3;
  self.tank_hud_item["sabot_target_range"].y = 0;
  self.tank_hud_item["sabot_target_range"].alpha = var_3;
  self.tank_hud_item["sabot_fuel_gauge"] = maps\_hud_util::createicon("m1a1_tank_sabot_fuel_gauge", int(self.tank_hud_item["sabot_target_range"].height * 0.6 * 0.0625), int(self.tank_hud_item["sabot_target_range"].height * 0.6));
  self.tank_hud_item["sabot_fuel_gauge"] set_default_hud_parameters();
  self.tank_hud_item["sabot_fuel_gauge"].alignx = "center";
  self.tank_hud_item["sabot_fuel_gauge"].aligny = "middle";
  self.tank_hud_item["sabot_fuel_gauge"].x = self.tank_hud_item["sabot_target_range"].x + self.tank_hud_item["sabot_target_range"].width * 2;
  self.tank_hud_item["sabot_fuel_gauge"].y = 0;
  self.tank_hud_item["sabot_fuel_gauge"].alpha = var_3;
  self.tank_hud_item["sabot_fuel_range"] = maps\_hud_util::createicon("m1a1_tank_sabot_fuel_range", int(self.tank_hud_item["sabot_fuel_gauge"].height * 0.5 * 0.125), int(self.tank_hud_item["sabot_fuel_gauge"].height * 0.5));
  self.tank_hud_item["sabot_fuel_range"] set_default_hud_parameters();
  self.tank_hud_item["sabot_fuel_range"].alignx = "center";
  self.tank_hud_item["sabot_fuel_range"].aligny = "middle";
  self.tank_hud_item["sabot_fuel_range"].x = self.tank_hud_item["sabot_fuel_gauge"].x + self.tank_hud_item["sabot_fuel_gauge"].width * 2;
  self.tank_hud_item["sabot_fuel_range"].y = 0;
  self.tank_hud_item["sabot_fuel_range"].alpha = var_3;
  self.tank_hud_item["sabot_ROT"] = maps\_hud_util::createclientfontstring("small", 1.1);
  self.tank_hud_item["sabot_ROT"] set_default_hud_parameters();
  self.tank_hud_item["sabot_ROT"].alignx = "right";
  self.tank_hud_item["sabot_ROT"].aligny = "middle";
  self.tank_hud_item["sabot_ROT"].alpha = var_3;
  self.tank_hud_item["sabot_ROT"].x = self.tank_hud_item["sabot_target_range"].x - self.tank_hud_item["sabot_target_range"].width * 0.6;
  self.tank_hud_item["sabot_ROT"].y = 0;
  self.tank_hud_item["sabot_ROT"] settext(&"SATFARM_RANGE_ON_TARGET");
  self.tank_hud_item["sabot_fuel_range_text"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_fuel_range_text"] set_default_hud_parameters();
  self.tank_hud_item["sabot_fuel_range_text"].alignx = "left";
  self.tank_hud_item["sabot_fuel_range_text"].aligny = "middle";
  self.tank_hud_item["sabot_fuel_range_text"].alpha = var_3;
  self.tank_hud_item["sabot_fuel_range_text"].x = self.tank_hud_item["sabot_fuel_range"].x + self.tank_hud_item["sabot_fuel_range"].width;
  self.tank_hud_item["sabot_fuel_range_text"].y = -5;
  self.tank_hud_item["sabot_fuel_range_text"] settext(&"SATFARM_FUELRANGE");
  self.tank_hud_item["sabot_range_highlight"] = maps\_hud_util::createicon("white", int(self.tank_hud_item["sabot_target_range"].width * 1.25), int(self.tank_hud_item["sabot_target_range"].height * 0.0625));
  self.tank_hud_item["sabot_range_highlight"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_highlight"].alignx = "left";
  self.tank_hud_item["sabot_range_highlight"].aligny = "middle";
  self.tank_hud_item["sabot_range_highlight"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_highlight"].y = 0 + self.tank_hud_item["sabot_target_range"].height * 0.23;
  self.tank_hud_item["sabot_range_highlight"].alpha = 0;
  self.tank_hud_item["sabot_range_1"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_range_1"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_1"].alignx = "left";
  self.tank_hud_item["sabot_range_1"].aligny = "middle";
  self.tank_hud_item["sabot_range_1"].alpha = var_3;
  self.tank_hud_item["sabot_range_1"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_1"].y = 0 + self.tank_hud_item["sabot_target_range"].height * 0.23;
  self.tank_hud_item["sabot_range_1"] settext(&"SATFARM_RANGE_1");
  self.tank_hud_item["sabot_range_2"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_range_2"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_2"].alignx = "left";
  self.tank_hud_item["sabot_range_2"].aligny = "middle";
  self.tank_hud_item["sabot_range_2"].alpha = var_3;
  self.tank_hud_item["sabot_range_2"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_2"].y = 0 + self.tank_hud_item["sabot_target_range"].height * 0.125;
  self.tank_hud_item["sabot_range_2"] settext(&"SATFARM_RANGE_2");
  self.tank_hud_item["sabot_range_3"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_range_3"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_3"].alignx = "left";
  self.tank_hud_item["sabot_range_3"].aligny = "middle";
  self.tank_hud_item["sabot_range_3"].alpha = var_3;
  self.tank_hud_item["sabot_range_3"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_3"].y = 0;
  self.tank_hud_item["sabot_range_3"] settext(&"SATFARM_RANGE_3");
  self.tank_hud_item["sabot_range_4"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_range_4"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_4"].alignx = "left";
  self.tank_hud_item["sabot_range_4"].aligny = "middle";
  self.tank_hud_item["sabot_range_4"].alpha = var_3;
  self.tank_hud_item["sabot_range_4"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_4"].y = 0 - self.tank_hud_item["sabot_target_range"].height * 0.125;
  self.tank_hud_item["sabot_range_4"] settext(&"SATFARM_RANGE_4");
  self.tank_hud_item["sabot_range_5"] = maps\_hud_util::createclientfontstring("small", 0.8);
  self.tank_hud_item["sabot_range_5"] set_default_hud_parameters();
  self.tank_hud_item["sabot_range_5"].alignx = "left";
  self.tank_hud_item["sabot_range_5"].aligny = "middle";
  self.tank_hud_item["sabot_range_5"].alpha = var_3;
  self.tank_hud_item["sabot_range_5"].x = self.tank_hud_item["sabot_target_range"].x;
  self.tank_hud_item["sabot_range_5"].y = 0 - self.tank_hud_item["sabot_target_range"].height * 0.23;
  self.tank_hud_item["sabot_range_5"] settext(&"SATFARM_RANGE_5");
  thread tank_update_primary_reticle();
  thread tank_compass(var_0);
  thread tank_compass_vehicle_positions(var_0);
  thread tank_compass_objective_positions(var_0);
  thread tank_update_weapon_hud(var_0, var_2);
  thread hide_normal_hud_elements();

  if(isDefined(var_1))
    wait(var_1);

  self.tank_hud_item["smoke_state_bg"] = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  self.tank_hud_item["smoke_state_bg"] set_default_hud_parameters();
  self.tank_hud_item["smoke_state_bg"].alignx = "center";
  self.tank_hud_item["smoke_state_bg"].aligny = "middle";
  self.tank_hud_item["smoke_state_bg"].vertalign = "bottom";
  self.tank_hud_item["smoke_state_bg"].x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_state_bg"].y = -50;

  if(isDefined(var_1)) {
    self.tank_hud_item["smoke_state_bg"].alpha = 0.0;
    self.tank_hud_item["smoke_state_bg"] fadeovertime(1.0);
  }

  self.tank_hud_item["smoke_state_bg"].alpha = 0.9;
  self.tank_hud_item["smoke_state"] = maps\_hud_util::createicon("green_block", 57, 5);
  self.tank_hud_item["smoke_state"] set_default_hud_parameters();
  self.tank_hud_item["smoke_state"].alignx = "left";
  self.tank_hud_item["smoke_state"].aligny = "middle";
  self.tank_hud_item["smoke_state"].vertalign = "bottom";
  self.tank_hud_item["smoke_state"].x = -298 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_state"].y = -51;

  if(isDefined(var_1)) {
    self.tank_hud_item["smoke_state"].alpha = 0.0;
    self.tank_hud_item["smoke_state"] fadeovertime(1.0);
  }

  self.tank_hud_item["smoke_state"].alpha = 0.4;
  self.tank_hud_item["smoke_name"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["smoke_name"] set_default_hud_parameters();
  self.tank_hud_item["smoke_name"].alignx = "center";
  self.tank_hud_item["smoke_name"].aligny = "bottom";
  self.tank_hud_item["smoke_name"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["smoke_name"].alpha = 0.0;
    self.tank_hud_item["smoke_name"] fadeovertime(1.0);
  }

  self.tank_hud_item["smoke_name"].alpha = 0.9;
  self.tank_hud_item["smoke_name"].x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_name"].y = -57;
  self.tank_hud_item["smoke_name"] settext(&"SATFARM_SMOKE");
  self.tank_hud_item["smoke_status"] = maps\_hud_util::createclientfontstring("small", 1.2);
  self.tank_hud_item["smoke_status"] set_default_hud_parameters();
  self.tank_hud_item["smoke_status"].alignx = "center";
  self.tank_hud_item["smoke_status"].aligny = "top";
  self.tank_hud_item["smoke_status"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["smoke_status"].alpha = 0.0;
    self.tank_hud_item["smoke_status"] fadeovertime(1.0);
  }

  self.tank_hud_item["smoke_status"].alpha = 0.9;
  self.tank_hud_item["smoke_status"].x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_status"].y = -43;
  self.tank_hud_item["smoke_status"] settext(&"SATFARM_READY");
  self.tank_hud_item["smoke_offline"] = maps\_hud_util::createclientfontstring("small", 1.6);
  self.tank_hud_item["smoke_offline"] set_default_hud_parameters();
  self.tank_hud_item["smoke_offline"].alignx = "center";
  self.tank_hud_item["smoke_offline"].aligny = "middle";
  self.tank_hud_item["smoke_offline"].vertalign = "bottom";
  self.tank_hud_item["smoke_offline"].alpha = 0;
  self.tank_hud_item["smoke_offline"].x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_offline"].y = -50;
  self.tank_hud_item["smoke_offline"] settext(&"SATFARM_OFFLINE");
  self.tank_hud_item["smoke_warning"] = maps\_hud_util::createicon("m1a1_tank_warning", 96, 96);
  self.tank_hud_item["smoke_warning"] set_default_hud_parameters();
  self.tank_hud_item["smoke_warning"].alignx = "center";
  self.tank_hud_item["smoke_warning"].aligny = "middle";
  self.tank_hud_item["smoke_warning"].vertalign = "bottom";
  self.tank_hud_item["smoke_warning"].x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["smoke_warning"].y = -50;
  self.tank_hud_item["smoke_warning"].alpha = 0.0;
  self.tank_hud_item["speed_bar_bg"] = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  self.tank_hud_item["speed_bar_bg"] set_default_hud_parameters();
  self.tank_hud_item["speed_bar_bg"].alignx = "center";
  self.tank_hud_item["speed_bar_bg"].aligny = "middle";
  self.tank_hud_item["speed_bar_bg"].vertalign = "bottom";
  self.tank_hud_item["speed_bar_bg"].x = -170 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["speed_bar_bg"].y = -50;

  if(isDefined(var_1)) {
    self.tank_hud_item["speed_bar_bg"].alpha = 0.0;
    self.tank_hud_item["speed_bar_bg"] fadeovertime(1.0);
  }

  self.tank_hud_item["speed_bar_bg"].alpha = 0.9;
  self.tank_hud_item["speed_bar"] = maps\_hud_util::createicon("green_block", 57, 5);
  self.tank_hud_item["speed_bar"] set_default_hud_parameters();
  self.tank_hud_item["speed_bar"].alignx = "left";
  self.tank_hud_item["speed_bar"].aligny = "middle";
  self.tank_hud_item["speed_bar"].vertalign = "bottom";
  self.tank_hud_item["speed_bar"].x = -198 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["speed_bar"].y = -51;

  if(isDefined(var_1)) {
    self.tank_hud_item["speed_bar"].alpha = 0.0;
    self.tank_hud_item["speed_bar"] fadeovertime(1.0);
  }

  self.tank_hud_item["speed_bar"].alpha = 0.4;
  self.tank_hud_item["speed_bar_overdrive"] = maps\_hud_util::createicon("red_block", 57, 5);
  self.tank_hud_item["speed_bar_overdrive"] set_default_hud_parameters();
  self.tank_hud_item["speed_bar_overdrive"].alignx = "right";
  self.tank_hud_item["speed_bar_overdrive"].aligny = "middle";
  self.tank_hud_item["speed_bar_overdrive"].vertalign = "bottom";
  self.tank_hud_item["speed_bar_overdrive"].x = self.tank_hud_item["speed_bar"].x + self.tank_hud_item["speed_bar"].width;
  self.tank_hud_item["speed_bar_overdrive"].y = -51;
  self.tank_hud_item["speed_bar_overdrive"].alpha = 0.0;
  self.tank_hud_item["speed_label"] = maps\_hud_util::createclientfontstring("small", 1.0);
  self.tank_hud_item["speed_label"] set_default_hud_parameters();
  self.tank_hud_item["speed_label"].alignx = "left";
  self.tank_hud_item["speed_label"].aligny = "bottom";
  self.tank_hud_item["speed_label"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["speed_label"].alpha = 0.0;
    self.tank_hud_item["speed_label"] fadeovertime(1.0);
  }

  self.tank_hud_item["speed_label"].alpha = 0.9;
  self.tank_hud_item["speed_label"].x = -169 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["speed_label"].y = -57;
  self.tank_hud_item["speed_label"] settext(&"SATFARM_MPH");
  self.tank_hud_item["speed"] = maps\_hud_util::createclientfontstring("small", 1.7);
  self.tank_hud_item["speed"] set_default_hud_parameters();
  self.tank_hud_item["speed"].alignx = "right";
  self.tank_hud_item["speed"].aligny = "bottom";
  self.tank_hud_item["speed"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["speed"].alpha = 0.0;
    self.tank_hud_item["speed"] fadeovertime(1.0);
  }

  self.tank_hud_item["speed"].alpha = 0.9;
  self.tank_hud_item["speed"].x = -170 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["speed"].y = -57;
  self.tank_hud_item["speed"] setvalue(0);
  self.tank_hud_item["min_speed"] = maps\_hud_util::createclientfontstring("small", 1.0);
  self.tank_hud_item["min_speed"] set_default_hud_parameters();
  self.tank_hud_item["min_speed"].alignx = "right";
  self.tank_hud_item["min_speed"].aligny = "top";
  self.tank_hud_item["min_speed"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["min_speed"].alpha = 0.0;
    self.tank_hud_item["min_speed"] fadeovertime(1.0);
  }

  self.tank_hud_item["min_speed"].alpha = 0.9;
  self.tank_hud_item["min_speed"].x = -202 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["min_speed"].y = -57;
  self.tank_hud_item["min_speed"] setvalue(0);
  var_4 = 50;
  self.tank_hud_item["max_speed"] = maps\_hud_util::createclientfontstring("small", 1.0);
  self.tank_hud_item["max_speed"] set_default_hud_parameters();
  self.tank_hud_item["max_speed"].alignx = "center";
  self.tank_hud_item["max_speed"].aligny = "top";
  self.tank_hud_item["max_speed"].vertalign = "bottom";

  if(isDefined(var_1)) {
    self.tank_hud_item["max_speed"].alpha = 0.0;
    self.tank_hud_item["max_speed"] fadeovertime(1.0);
  }

  self.tank_hud_item["max_speed"].alpha = 0.9;
  self.tank_hud_item["max_speed"].x = -131 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  self.tank_hud_item["max_speed"].y = -57;
  self.tank_hud_item["max_speed"] setvalue(var_4);
  thread tank_update_speed(var_0, var_4);
}

hide_normal_hud_elements() {
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", "0");
}

show_normal_hud_elements() {
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("actionSlotsHide", "0");
  setsaveddvar("hud_showStance", "1");
}

tank_clear_hud(var_0) {
  level notify("clear_tank_hud");

  if(isDefined(var_0) && var_0) {
    var_1 = getarraykeys(self.tank_hud_item);

    foreach(var_3 in var_1) {
      self.tank_hud_item[var_3] fadeovertime(0.5);
      self.tank_hud_item[var_3].alpha = 0;
    }

    foreach(var_6 in maps\_utility::getvehiclearray()) {
      if(isDefined(var_6.hud_compass_elem)) {
        var_6.hud_compass_elem fadeovertime(0.5);
        var_6.hud_compass_elem.alpha = 0;
      }
    }

    foreach(var_9 in level.compass_objectives) {
      if(isDefined(var_9.hud_compass_elem)) {
        var_9.hud_compass_elem fadeovertime(0.5);
        var_9.hud_compass_elem.alpha = 0;
      }
    }

    wait 0.5;
  }

  var_1 = getarraykeys(self.tank_hud_item);

  foreach(var_3 in var_1) {
    self.tank_hud_item[var_3] destroy();
    self.tank_hud_item[var_3] = undefined;
  }

  foreach(var_6 in maps\_utility::getvehiclearray()) {
    if(isDefined(var_6.hud_compass_elem)) {
      var_6.hud_compass_elem destroy();
      var_6.hud_compass_elem = undefined;
    }
  }

  foreach(var_9 in level.compass_objectives) {
    if(isDefined(var_9.hud_compass_elem)) {
      var_9.hud_compass_elem destroy();
      var_9.hud_compass_elem = undefined;
    }
  }

  if(!isDefined(var_0) || !var_0)
    thread show_normal_hud_elements();
}

tank_hud_initialize() {
  thread tank_hud_vignette();
  level.player digitaldistortsetparams(0.5, 1);
  wait 0.5;
  level.player digitaldistortsetparams(0, 0);
  var_0 = level.player maps\_hud_util::createclientfontstring("small", 2);
  var_0 set_default_hud_parameters();
  var_0.alignx = "center";
  var_0.alpha = 0.9;
  var_0.y = -100;
  var_0 settext(&"SATFARM_INITIALIZING");
  thread tank_hud_body(1);
  thread tank_hud_speed(2);
  thread tank_hud_compass(3);
  thread tank_hud_turret(4);
  thread tank_hud_smoke(5);
  thread tank_hud_missile(6);
  wait 2;
  var_0 destroy();
}

tank_hud_reticle() {
  var_0 = maps\_hud_util::createicon("m1a1_tank_primary_reticle", 400, 200);
  var_0 set_default_hud_parameters();
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.alpha = 0.66;
  var_1 = maps\_hud_util::createicon("m1a1_tank_primary_reticle_center", 20, 20);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.alpha = 0.66;
  var_2 = maps\_hud_util::createicon("m1a1_tank_primary_reticle_cross", 88, 88);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.alpha = 0.66;
  wait 0.75;
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.3);
  var_3 set_default_hud_parameters();
  var_3.alignx = "right";
  var_3.aligny = "bottom";
  var_3.alpha = 0.9;
  var_3.x = 0 - var_0.width * 0.4;
  var_3.y = -5;
  var_3 settext("1.0 X");
  level waittill("clear_tank_hud");
  var_0 destroy();
  var_1 destroy();
  var_2 destroy();
  var_3 destroy();
}

tank_hud_vignette() {
  var_0 = maps\_hud_util::createicon("ugv_vignette_overlay", 640, 480);
  var_0 set_default_hud_parameters();
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0.5;
  var_0.sort = var_0.sort - 5;
  level waittill("clear_tank_hud");
  var_0 destroy();
}

tank_hud_body(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_hud_tank_body", 64, 64);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "top";
  var_1.horzalign = "center";
  var_1.vertalign = "bottom";
  var_1.x = 0;
  var_1.y = -65;
  var_1.alpha = 0.25;
  var_2 = maps\_hud_util::createicon("m1a1_hud_tank_turret", 64, 64);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "top";
  var_2.horzalign = "center";
  var_2.vertalign = "bottom";
  var_2.x = 0;
  var_2.y = -65;
  var_2.alpha = 0.25;
  wait(var_0);
  var_1.alpha = 1;
  var_2.alpha = 1;
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_2 destroy();
}

tank_hud_compass(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_compass_center", 10, 20);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "top";
  var_1.vertalign = "top";
  var_1.x = 0;
  var_1.y = 10;
  var_1.alpha = 0.9;
  thread tank_hud_compass_movement();
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_2 = getarraykeys(level.fake_tank_hud_item);

  foreach(var_4 in var_2) {
    level.fake_tank_hud_item[var_4] destroy();
    level.fake_tank_hud_item[var_4] = undefined;
  }
}

tank_hud_compass_movement() {
  level endon("clear_tank_hud");
  var_0 = 10;
  var_1 = 45;
  var_2 = 360;
  var_3 = -200;
  var_4 = 0;
  var_5 = 400;
  var_6 = 30;
  var_7 = 0.8;
  var_8 = int(var_2 / var_0);

  for(var_9 = 0; var_9 < var_8; var_9++) {
    level.fake_tank_hud_item["compass_tick_mark_" + var_9] = maps\_hud_util::createicon("white", 1, 1);
    level.fake_tank_hud_item["compass_tick_mark_" + var_9] set_default_hud_parameters();
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].alignx = "center";
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].aligny = "top";
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].vertalign = "top";
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].x = 0;
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].y = 0;
    level.fake_tank_hud_item["compass_tick_mark_" + var_9].alpha = var_7;
  }

  for(var_9 = 0; var_9 < int(var_2 / var_1); var_9++) {
    level.fake_tank_hud_item["compass_label_mark_" + var_9] = level.player maps\_hud_util::createclientfontstring("small", 1);
    level.fake_tank_hud_item["compass_label_mark_" + var_9] set_default_hud_parameters();
    level.fake_tank_hud_item["compass_label_mark_" + var_9].alignx = "center";
    level.fake_tank_hud_item["compass_label_mark_" + var_9].aligny = "top";
    level.fake_tank_hud_item["compass_label_mark_" + var_9].vertalign = "top";
    level.fake_tank_hud_item["compass_label_mark_" + var_9].alpha = var_7;
    level.fake_tank_hud_item["compass_label_mark_" + var_9].x = 0;
    level.fake_tank_hud_item["compass_label_mark_" + var_9].y = 0;
  }

  for(;;) {
    var_10 = var_5 / var_8;
    var_11 = level.player getplayerangles()[1] - getnorthyaw();
    var_12 = 0 - var_5 / 2 + (1.0 - modulus(abs(var_11), var_0) / var_0) * var_10;
    var_13 = int(var_11 / var_0 - var_8 / 2) * var_0;
    var_14 = 0;

    for(var_9 = 0; var_9 < var_8; var_9++) {
      var_13 = var_13 + var_0;
      var_15 = max(0.15, pow(common_scripts\utility::ter_op(var_9 < var_8 / 2, var_9, var_8 - var_9) / (var_8 / 2), 1.1)) * var_6 * 0.5;
      level.fake_tank_hud_item["compass_tick_mark_" + var_9].x = var_12 + var_9 * var_10;
      level.fake_tank_hud_item["compass_tick_mark_" + var_9].y = var_4 + (var_15 - var_6 * 0.15 * 0.5) * 0.75;
      level.fake_tank_hud_item["compass_tick_mark_" + var_9].height = int(var_15);

      if(modulus(var_13, var_1) == 0) {
        if(var_13 >= 360)
          var_13 = var_13 - 360;
        else if(var_13 < 0)
          var_13 = var_13 + 360;

        if(var_13 == 0)
          var_16 = "00";
        else
          var_16 = "" + var_13;

        level.fake_tank_hud_item["compass_tick_mark_" + var_9].width = 2;
        level.fake_tank_hud_item["compass_tick_mark_" + var_9].alpha = var_15 / (var_6 * 0.5);
        level.fake_tank_hud_item["compass_label_mark_" + var_14].x = var_12 + var_9 * var_10;
        level.fake_tank_hud_item["compass_label_mark_" + var_14].y = var_4 + var_6;
        level.fake_tank_hud_item["compass_label_mark_" + var_14].alpha = var_15 / (var_6 * 0.5);
        level.fake_tank_hud_item["compass_label_mark_" + var_14] settext(var_16);
        var_14++;
      } else {
        level.fake_tank_hud_item["compass_tick_mark_" + var_9].width = 1;
        level.fake_tank_hud_item["compass_tick_mark_" + var_9].alpha = max(0.15, var_7 / 4.0 * (var_15 / (var_6 * 0.5)));
      }

      level.fake_tank_hud_item["compass_tick_mark_" + var_9] setshader("white", level.fake_tank_hud_item["compass_tick_mark_" + var_9].width, level.fake_tank_hud_item["compass_tick_mark_" + var_9].height);
    }

    wait 0.05;
  }
}

tank_hud_turret(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.vertalign = "bottom";
  var_1.x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_1.y = -50;
  var_1.alpha = 0.25;
  var_2 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "bottom";
  var_2.vertalign = "bottom";
  var_2.alpha = 0.25;
  var_2.x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_2.y = -57;
  var_2 settext(&"SATFARM_TANK_TURRET");
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_3 set_default_hud_parameters();
  var_3.alignx = "center";
  var_3.aligny = "top";
  var_3.vertalign = "bottom";
  var_3.alpha = 0.25;
  var_3.x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_3.y = -43;
  var_3 settext(&"SATFARM_SYSTEM_CHECK");
  var_4 = maps\_hud_util::createicon("m1a1_tank_weapon_select_arrow", 12, 12);
  var_4 set_default_hud_parameters();
  var_4.alignx = "center";
  var_4.aligny = "top";
  var_4.vertalign = "bottom";
  var_4.x = 170 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_4.y = -26;
  var_4.alpha = 0.25;
  var_4.weap = "turret";
  wait(var_0);
  var_1.alpha = 0.9;
  var_2.alpha = 0.9;
  var_3.alpha = 0.9;
  var_4.alpha = 0.9;
  var_5 = maps\_hud_util::createicon("green_block", 57, 5);
  var_5 set_default_hud_parameters();
  var_5.alignx = "left";
  var_5.aligny = "middle";
  var_5.vertalign = "bottom";
  var_5.x = 142 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_5.y = -51;
  var_5.alpha = 0.4;
  var_3 settext(&"SATFARM_ONLINE");
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_5 destroy();
  var_2 destroy();
  var_3 destroy();
  var_4 destroy();
}

tank_hud_smoke(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.vertalign = "bottom";
  var_1.x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_1.y = -50;
  var_1.alpha = 0.25;
  var_2 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "bottom";
  var_2.vertalign = "bottom";
  var_2.alpha = 0.25;
  var_2.x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_2.y = -57;
  var_2 settext(&"SATFARM_SMOKE");
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_3 set_default_hud_parameters();
  var_3.alignx = "center";
  var_3.aligny = "top";
  var_3.vertalign = "bottom";
  var_3.alpha = 0.25;
  var_3.x = -270 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_3.y = -43;
  var_3 settext(&"SATFARM_SYSTEM_CHECK");
  wait(var_0);
  var_1.alpha = 0.9;
  var_2.alpha = 0.9;
  var_3.alpha = 0.9;
  var_4 = maps\_hud_util::createicon("green_block", 57, 5);
  var_4 set_default_hud_parameters();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.vertalign = "bottom";
  var_4.x = -298 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_4.y = -51;
  var_4.alpha = 0.4;
  var_3 settext(&"SATFARM_ONLINE");
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_4 destroy();
  var_2 destroy();
  var_3 destroy();
}

tank_hud_missile(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.vertalign = "bottom";
  var_1.x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_1.y = -50;
  var_1.alpha = 0.25;
  var_2 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "bottom";
  var_2.vertalign = "bottom";
  var_2.alpha = 0.25;
  var_2.x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_2.y = -57;
  var_2 settext(&"SATFARM_TANK_MISSILE");
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_3 set_default_hud_parameters();
  var_3.alignx = "center";
  var_3.aligny = "top";
  var_3.vertalign = "bottom";
  var_3.alpha = 0.25;
  var_3.x = 270 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_3.y = -43;
  var_3 settext(&"SATFARM_SYSTEM_CHECK");
  wait(var_0);
  var_1.alpha = 0.9;
  var_4 = maps\_hud_util::createicon("green_block", 57, 5);
  var_4 set_default_hud_parameters();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.vertalign = "bottom";
  var_4.x = 242 - common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_4.y = -51;
  var_4.alpha = 0.4;
  var_3 settext(&"SATFARM_ONLINE");
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_4 destroy();
  var_2 destroy();
  var_3 destroy();
}

tank_hud_mg(var_0) {
  var_1 = maps\_hud_util::createicon("white", 1, 48);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.vertalign = "bottom";
  var_1.x = 241;
  var_1.y = -50;
  var_1.alpha = 0.25;
  var_2 = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar_infinite", 96, 12);
  var_2 set_default_hud_parameters();
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.vertalign = "bottom";
  var_2.x = 290;
  var_2.y = -50;
  var_2.alpha = 0.25;
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_3 set_default_hud_parameters();
  var_3.alignx = "center";
  var_3.aligny = "bottom";
  var_3.vertalign = "bottom";
  var_3.alpha = 0.25;
  var_3.x = 290;
  var_3.y = -57;
  var_3 settext(&"SATFARM_TANK_MACHINE_GUN");
  var_4 = level.player maps\_hud_util::createclientfontstring("small", 1.2);
  var_4 set_default_hud_parameters();
  var_4.alignx = "center";
  var_4.aligny = "top";
  var_4.vertalign = "bottom";
  var_4.alpha = 0.25;
  var_4.x = 290;
  var_4.y = -43;
  var_4 settext(&"SATFARM_SYSTEM_CHECK");
  wait(var_0);
  var_1.alpha = 0.9;
  var_2.alpha = 0.9;
  var_3.alpha = 0.9;
  var_5 = maps\_hud_util::createicon("green_block", 57, 5);
  var_5 set_default_hud_parameters();
  var_5.alignx = "left";
  var_5.aligny = "middle";
  var_5.vertalign = "bottom";
  var_5.x = 262;
  var_5.y = -51;
  var_5.alpha = 0.4;
  var_4 settext(&"SATFARM_ONLINE");
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_2 destroy();
  var_5 destroy();
  var_3 destroy();
  var_4 destroy();
}

tank_hud_speed(var_0) {
  var_1 = maps\_hud_util::createicon("m1a1_tank_weapon_progress_bar", 96, 12);
  var_1 set_default_hud_parameters();
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.vertalign = "bottom";
  var_1.x = -170 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_1.y = -50;
  var_1.alpha = 0.25;
  var_2 = level.player maps\_hud_util::createclientfontstring("small", 1.0);
  var_2 set_default_hud_parameters();
  var_2.alignx = "left";
  var_2.aligny = "bottom";
  var_2.vertalign = "bottom";
  var_2.alpha = 0.25;
  var_2.x = -169 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_2.y = -57;
  var_2 settext(&"SATFARM_MPH");
  var_3 = level.player maps\_hud_util::createclientfontstring("small", 1.7);
  var_3 set_default_hud_parameters();
  var_3.alignx = "right";
  var_3.aligny = "bottom";
  var_3.vertalign = "bottom";
  var_3.alpha = 0.25;
  var_3.x = -170 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_3.y = -57;
  var_3 setvalue(0);
  var_4 = level.player maps\_hud_util::createclientfontstring("small", 1.0);
  var_4 set_default_hud_parameters();
  var_4.alignx = "right";
  var_4.aligny = "top";
  var_4.vertalign = "bottom";
  var_4.alpha = 0.25;
  var_4.x = -202 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_4.y = -57;
  var_4 setvalue(0);
  var_5 = level.player maps\_hud_util::createclientfontstring("small", 1.0);
  var_5 set_default_hud_parameters();
  var_5.alignx = "center";
  var_5.aligny = "top";
  var_5.vertalign = "bottom";
  var_5.alpha = 0.25;
  var_5.x = -131 + common_scripts\utility::ter_op(getdvarint("widescreen") == 0, 50, 0);
  var_5.y = -57;
  var_5 setvalue(50);
  wait(var_0);
  var_1.alpha = 0.9;
  var_3.alpha = 0.9;
  var_2.alpha = 0.9;
  var_4.alpha = 0.9;
  var_5.alpha = 0.9;
  level waittill("clear_tank_hud");
  var_1 destroy();
  var_3 destroy();
  var_2 destroy();
  var_4 destroy();
  var_5 destroy();
}

tank_hud_crack_left() {
  self.tank_hud_item["crack_left"] = maps\_hud_util::createicon("m1a1_tank_screen_crack_left", 400, 400);
  self.tank_hud_item["crack_left"] set_default_hud_parameters();
  self.tank_hud_item["crack_left"].alignx = "left";
  self.tank_hud_item["crack_left"].aligny = "top";
  self.tank_hud_item["crack_left"].horzalign = "left";
  self.tank_hud_item["crack_left"].vertalign = "top";
  self.tank_hud_item["crack_left"].x = -65;
  self.tank_hud_item["crack_left"].y = -50;
  self.tank_hud_item["crack_left"].alpha = 1;
}

tank_hud_crack_right() {
  self.tank_hud_item["crack_right"] = maps\_hud_util::createicon("m1a1_tank_screen_crack_right", 400, 400);
  self.tank_hud_item["crack_right"] set_default_hud_parameters();
  self.tank_hud_item["crack_right"].alignx = "right";
  self.tank_hud_item["crack_right"].aligny = "top";
  self.tank_hud_item["crack_right"].horzalign = "right";
  self.tank_hud_item["crack_right"].vertalign = "top";
  self.tank_hud_item["crack_right"].x = 65;
  self.tank_hud_item["crack_right"].y = -50;
  self.tank_hud_item["crack_right"].alpha = 1;
}

tank_hud_offline(var_0) {
  level endon("clear_tank_hud");

  if(!isDefined(self.tank_hud_item[var_0 + "_name"])) {
    return;
  }
  if(isDefined(self.tank_hud_item[var_0 + "_status"])) {
    self.tank_hud_item[var_0 + "_status"].alpha = 0;
    self.tank_hud_item[var_0 + "_status"].offline = 1;
  }

  self.tank_hud_item[var_0 + "_name"].alpha = 0.25;
  self.tank_hud_item[var_0 + "_state"].alpha = 0;
  self.tank_hud_item[var_0 + "_state"] setshader("white", self.tank_hud_item[var_0 + "_state"].width, self.tank_hud_item[var_0 + "_state"].height);

  for(;;) {
    self.tank_hud_item[var_0 + "_offline"] fadeovertime(0.25);
    self.tank_hud_item[var_0 + "_offline"].alpha = 1;
    self.tank_hud_item[var_0 + "_warning"] fadeovertime(0.25);
    self.tank_hud_item[var_0 + "_warning"].alpha = 1;
    wait 0.4;
    self.tank_hud_item[var_0 + "_offline"] fadeovertime(0.25);
    self.tank_hud_item[var_0 + "_offline"].alpha = 0;
    self.tank_hud_item[var_0 + "_warning"] fadeovertime(0.25);
    self.tank_hud_item[var_0 + "_warning"].alpha = 0;
    wait 0.25;

    if(self.tank_hud_item[var_0 + "_offline"].color == (1, 1, 1)) {
      self.tank_hud_item[var_0 + "_offline"].color = (1, 0, 0);
      continue;
    }

    self.tank_hud_item[var_0 + "_offline"].color = (1, 1, 1);
  }
}

tank_hud_missile_warning() {
  var_0 = maps\_hud_util::createicon("m1a1_tank_warning", 80, 80);
  var_0 set_default_hud_parameters();
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.vertalign = "bottom";
  var_0.x = 0;
  var_0.y = -100;
  var_0.alpha = 0.0;
  var_0 thread tank_hud_blink_warning();
  level common_scripts\utility::waittill_any("clear_tank_hud", "remove_missile_warning");
  var_0 destroy();
}

tank_hud_blink_warning() {
  level endon("clear_tank_hud");
  level endon("remove_missile_warning");

  for(;;) {
    self fadeovertime(0.25);
    self.alpha = 1;
    wait 0.4;
    self fadeovertime(0.25);
    self.alpha = 0;
    wait 0.25;
  }
}

tank_update_primary_reticle() {
  level endon("clear_tank_hud");

  for(;;) {
    if(self.tank_hud_item["current_weapon"].weap == "turret") {
      var_0 = bulletTrace(self getEye(), self getEye() + anglesToForward(self getplayerangles()) * 36000, 1, self);

      if(isDefined(var_0["entity"]) && (isDefined(var_0["entity"].script_team) && var_0["entity"].script_team == "axis" || isDefined(var_0["entity"].red_crosshair) && var_0["entity"].red_crosshair)) {
        self.tank_hud_item["reticle_center_red"].alpha = 0.66;
        self.tank_hud_item["reticle_cross_red"].alpha = 0.66;
        self.tank_hud_item["reticle_center_cyan"].alpha = 0.0;
        self.tank_hud_item["reticle_cross_cyan"].alpha = 0.0;
        self.tank_hud_item["reticle_center"].alpha = 0.0;
        self.tank_hud_item["reticle_cross"].alpha = 0.0;
      } else if(isDefined(var_0["entity"]) && isDefined(var_0["entity"].script_team) && var_0["entity"].script_team == "allies") {
        self.tank_hud_item["reticle_center_cyan"].alpha = 0.66;
        self.tank_hud_item["reticle_cross_cyan"].alpha = 0.66;
        self.tank_hud_item["reticle_center_red"].alpha = 0.0;
        self.tank_hud_item["reticle_cross_red"].alpha = 0.0;
        self.tank_hud_item["reticle_center"].alpha = 0.0;
        self.tank_hud_item["reticle_cross"].alpha = 0.0;
      } else {
        self.tank_hud_item["reticle_center"].alpha = 0.66;
        self.tank_hud_item["reticle_cross"].alpha = 0.66;
        self.tank_hud_item["reticle_center_red"].alpha = 0.0;
        self.tank_hud_item["reticle_cross_red"].alpha = 0.0;
        self.tank_hud_item["reticle_center_cyan"].alpha = 0.0;
        self.tank_hud_item["reticle_cross_cyan"].alpha = 0.0;
      }
    }

    wait 0.05;
  }
}

tank_update_speed(var_0, var_1) {
  level endon("clear_tank_hud");
  var_2 = self.tank_hud_item["speed_bar"].width;
  var_3 = self.tank_hud_item["speed_bar"].alpha;

  for(;;) {
    var_4 = var_0 vehicle_getspeed();
    self.tank_hud_item["speed"] setvalue(int(var_4));
    var_5 = int(min(var_4 / var_1 * var_2, var_2));

    if(var_5 == 0)
      self.tank_hud_item["speed_bar"].alpha = 0.0;
    else {
      self.tank_hud_item["speed_bar"].alpha = var_3;
      self.tank_hud_item["speed_bar"] setshader("green_block", var_5, self.tank_hud_item["speed_bar"].height);
    }

    if(floor(var_4) > var_1) {
      self.tank_hud_item["speed_bar_overdrive"].alpha = 1;
      self.tank_hud_item["speed_bar_overdrive"] setshader("red_block", int((var_4 - var_1) / var_1 * var_2), self.tank_hud_item["speed_bar"].height);
    } else
      self.tank_hud_item["speed_bar_overdrive"].alpha = 0;

    wait 0.05;
  }
}

add_ent_objective_to_compass(var_0, var_1) {
  if(isDefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.compass_objectives))
    level.compass_objectives = [];

  level.compass_objectives = common_scripts\utility::array_add(level.compass_objectives, var_0);
}

remove_ent_objective_from_compass(var_0) {
  if(isDefined(level.compass_objectives)) {
    level.compass_objectives = common_scripts\utility::array_remove(level.compass_objectives, var_0);

    if(isDefined(var_0.hud_compass_elem)) {
      var_0.hud_compass_elem destroy();
      var_0.hud_compass_elem = undefined;
    }
  }
}

tank_watch_for_vehicle_death() {
  level endon("clear_tank_hud");
  var_0 = self.hud_compass_elem;
  self waittill("death");

  if(isDefined(self)) {
    self.dead = 1;

    if(isDefined(self.hud_compass_elem)) {
      self.hud_compass_elem notify("stop_pulse");
      self.hud_compass_elem destroy();
      self.hud_compass_elem = undefined;
    }

    if(target_istarget(self))
      target_remove(self);
  } else if(isDefined(var_0)) {
    var_0 notify("stop_pulse");
    var_0 destroy();
  }
}

tank_compass(var_0) {
  level endon("clear_tank_hud");
  var_1 = 10;
  var_2 = 45;
  var_3 = 360;
  var_4 = -200;
  var_5 = 0;
  var_6 = 400;
  var_7 = 30;
  var_8 = 0.8;
  var_9 = int(var_3 / var_1);
  var_10 = var_6 / var_9;

  for(var_11 = 0; var_11 < var_9; var_11++) {
    self.tank_hud_item["compass_tick_mark_" + var_11] = maps\_hud_util::createicon("white", 1, 1);
    self.tank_hud_item["compass_tick_mark_" + var_11] set_default_hud_parameters();
    self.tank_hud_item["compass_tick_mark_" + var_11].alignx = "center";
    self.tank_hud_item["compass_tick_mark_" + var_11].aligny = "top";
    self.tank_hud_item["compass_tick_mark_" + var_11].vertalign = "top";
    self.tank_hud_item["compass_tick_mark_" + var_11].x = 0;
    self.tank_hud_item["compass_tick_mark_" + var_11].y = 0;
    self.tank_hud_item["compass_tick_mark_" + var_11].alpha = var_8;
  }

  for(var_11 = 0; var_11 < int(var_3 / var_2); var_11++) {
    self.tank_hud_item["compass_label_mark_" + var_11] = maps\_hud_util::createclientfontstring("small", 1.0);
    self.tank_hud_item["compass_label_mark_" + var_11] set_default_hud_parameters();
    self.tank_hud_item["compass_label_mark_" + var_11].alignx = "center";
    self.tank_hud_item["compass_label_mark_" + var_11].aligny = "top";
    self.tank_hud_item["compass_label_mark_" + var_11].vertalign = "top";
    self.tank_hud_item["compass_label_mark_" + var_11].alpha = var_8;
    self.tank_hud_item["compass_label_mark_" + var_11].x = 0;
    self.tank_hud_item["compass_label_mark_" + var_11].y = 0;
  }

  for(;;) {
    if(self.tank_hud_item["current_weapon"].weap != "turret") {
      for(var_11 = 0; var_11 < var_9; var_11++)
        self.tank_hud_item["compass_tick_mark_" + var_11].alpha = 0;

      for(var_11 = 0; var_11 < int(var_3 / var_2); var_11++)
        self.tank_hud_item["compass_label_mark_" + var_11].alpha = 0;

      self waittill("cycle_weapon");
    }

    var_12 = self getplayerangles()[1] - getnorthyaw();
    var_13 = var_4 + (1.0 - modulus(abs(var_12), var_1) / var_1) * var_10;
    var_14 = int(var_12 / var_1 - var_9 / 2) * var_1;
    var_15 = 0;

    for(var_11 = 0; var_11 < var_9; var_11++) {
      var_14 = var_14 + var_1;
      var_16 = max(0.15, pow(common_scripts\utility::ter_op(var_11 < var_9 / 2, var_11, var_9 - var_11) / (var_9 / 2), 1.1)) * var_7 * 0.5;
      self.tank_hud_item["compass_tick_mark_" + var_11].x = var_13 + var_11 * var_10;
      self.tank_hud_item["compass_tick_mark_" + var_11].y = var_5 + (var_16 - var_7 * 0.15 * 0.5) * 0.75;
      self.tank_hud_item["compass_tick_mark_" + var_11].height = int(var_16);

      if(modulus(var_14, var_2) == 0) {
        if(var_14 >= 360)
          var_14 = var_14 - 360;
        else if(var_14 < 0)
          var_14 = var_14 + 360;

        if(var_14 == 0)
          var_17 = "00";
        else
          var_17 = "" + var_14;

        self.tank_hud_item["compass_tick_mark_" + var_11].width = 2;
        self.tank_hud_item["compass_tick_mark_" + var_11].alpha = var_16 / (var_7 * 0.5);
        self.tank_hud_item["compass_label_mark_" + var_15].x = var_13 + var_11 * var_10;
        self.tank_hud_item["compass_label_mark_" + var_15].y = var_5 + var_7;
        self.tank_hud_item["compass_label_mark_" + var_15].alpha = var_16 / (var_7 * 0.5);
        self.tank_hud_item["compass_label_mark_" + var_15] settext(var_17);
        var_15++;
      } else {
        self.tank_hud_item["compass_tick_mark_" + var_11].width = 1;
        self.tank_hud_item["compass_tick_mark_" + var_11].alpha = max(0.15, var_8 / 4.0 * (var_16 / (var_7 * 0.5)));
      }

      self.tank_hud_item["compass_tick_mark_" + var_11] setshader("white", self.tank_hud_item["compass_tick_mark_" + var_11].width, self.tank_hud_item["compass_tick_mark_" + var_11].height);
    }

    wait 0.05;
  }
}

tank_compass_vehicle_positions(var_0) {
  level endon("clear_tank_hud");
  var_1 = 0;

  for(;;) {
    foreach(var_3 in maps\_utility::getvehiclearray()) {
      if(var_3.script_team == "axis" && var_3 istank() && (!isDefined(var_3.dead) || !var_3.dead)) {
        if(!isDefined(var_3.hud_compass_elem)) {
          var_3.hud_compass_elem = maps\_hud_util::createicon("m1a1_compass_enemy", 16, 16);
          var_3.hud_compass_elem set_default_hud_parameters();
          var_3.hud_compass_elem.alignx = "center";
          var_3.hud_compass_elem.aligny = "middle";
          var_3.hud_compass_elem.vertalign = "top";
          var_3.hud_compass_elem.x = 0;
          var_3.hud_compass_elem.y = 0;
          var_3.hud_compass_elem.alpha = 0.0;
          var_3.hud_compass_elem.visible = 0;

          if(var_1 && isDefined(var_3.compass_flash) && var_3.compass_flash)
            var_3.hud_compass_elem thread tank_compass_pulse(4, 2);

          if(!target_istarget(var_3)) {
            target_set(var_3, common_scripts\utility::ter_op(var_3 maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72)));
            target_hidefromplayer(var_3, level.player);
          }

          var_3 thread tank_watch_for_vehicle_death();
        }

        if(level.player.tank_hud_item["current_weapon"].weap != "turret") {
          var_3.hud_compass_elem notify("stop_pulse");
          var_3.hud_compass_elem.pulsing = 0;
          var_3.hud_compass_elem.alpha = 0;
          continue;
        }

        var_4 = distance2d(level.player.origin, var_3.origin);

        if(var_4 < 36000) {
          var_5 = vectortoyaw(var_3.origin - level.player.origin);
          var_6 = angleclamp180(var_5 - level.player getplayerangles()[1]);
          var_3.hud_compass_elem.x = -200 * var_6 / 180;
          var_3.hud_compass_elem.y = pow(1.0 - abs(var_6) / 180.0, 1.1) * 15;

          if(!isDefined(var_3.hud_compass_elem.pulsing) || !var_3.hud_compass_elem.pulsing) {
            var_3.hud_compass_elem.alpha = 0.9;
            var_3.hud_compass_elem.visible = 1;
            var_7 = int((1 - var_4 / 36000) * 16);
            var_3.hud_compass_elem setshader("m1a1_compass_enemy", var_7, var_7);
          }
        } else if(!isDefined(var_3.hud_compass_elem.pulsing) || !var_3.hud_compass_elem.pulsing) {
          var_3.hud_compass_elem.alpha = 0.0;
          var_3.hud_compass_elem.visible = 0;
        }
      }
    }

    var_1 = 1;

    if(level.player.tank_hud_item["current_weapon"].weap != "turret")
      level.player waittill("cycle_weapon");

    wait 0.05;
  }
}

tank_compass_objective_positions(var_0) {
  level endon("clear_tank_hud");

  if(!isDefined(level.compass_objectives))
    level.compass_objectives = [];

  var_1 = 0;

  for(;;) {
    foreach(var_3 in level.compass_objectives) {
      if(!isDefined(var_3.hud_compass_elem)) {
        var_3.hud_compass_elem = maps\_hud_util::createicon("m1a1_compass_objective", 24, 24);
        var_3.hud_compass_elem set_default_hud_parameters();
        var_3.hud_compass_elem.alignx = "center";
        var_3.hud_compass_elem.aligny = "middle";
        var_3.hud_compass_elem.vertalign = "top";
        var_3.hud_compass_elem.x = 0;
        var_3.hud_compass_elem.y = 0;
        var_3.hud_compass_elem.alpha = 0.0;
        var_3.hud_compass_elem.sort = var_3.hud_compass_elem.sort + 1;
        var_3.hud_compass_elem.visible = 0;

        if(var_1)
          var_3.hud_compass_elem thread tank_compass_pulse(4, 2);
      }

      if(level.player.tank_hud_item["current_weapon"].weap != "turret") {
        var_3.hud_compass_elem notify("stop_pulse");
        var_3.hud_compass_elem.pulsing = 0;
        var_3.hud_compass_elem.alpha = 0;
        continue;
      }

      var_4 = distance2d(level.player.origin, var_3.origin);

      if(var_4 < 36000) {
        var_5 = vectortoyaw(var_3.origin - level.player.origin);
        var_6 = angleclamp180(var_5 - level.player getplayerangles()[1]);
        var_3.hud_compass_elem.x = -200 * var_6 / 180;
        var_3.hud_compass_elem.y = pow(1.0 - abs(var_6) / 180.0, 1.1) * 15;

        if(!isDefined(var_3.hud_compass_elem.pulsing) || !var_3.hud_compass_elem.pulsing) {
          var_3.hud_compass_elem.alpha = 0.9;
          var_3.hud_compass_elem.visible = 1;
          var_7 = int(max((1 - var_4 / 36000) * 24, 12));
          var_3.hud_compass_elem setshader("m1a1_compass_objective", var_7, var_7);
        }

        continue;
      }

      if(!isDefined(var_3.hud_compass_elem.pulsing) || !var_3.hud_compass_elem.pulsing) {
        var_3.hud_compass_elem.alpha = 0.0;
        var_3.hud_compass_elem.visible = 0;
      }
    }

    var_1 = 1;

    if(level.player.tank_hud_item["current_weapon"].weap != "turret")
      level.player waittill("cycle_weapon");

    wait 0.05;
  }
}

tank_compass_pulse(var_0, var_1) {
  level endon("clear_tank_hud");
  self endon("stop_pulse");
  self.pulsing = 1;
  var_2 = var_1 / (var_0 * 2);
  var_3 = self.width;
  var_4 = int(var_3 / 2);

  for(var_5 = 0; var_5 < var_0; var_5++) {
    self scaleovertime(var_2, var_4, var_4);
    self fadeovertime(var_2);
    self.alpha = 0.0;
    wait(var_2);
    self scaleovertime(var_2, var_3, var_3);
    self fadeovertime(var_2);
    self.alpha = 0.9;
    wait(var_2);
  }

  self.pulsing = 0;
}

tank_compass_scanline(var_0) {
  level endon("clear_tank_hud");
  self.tank_hud_item["compass_scanline"] = maps\_hud_util::createicon("m1a1_compass_scanline", 18, 72);
  self.tank_hud_item["compass_scanline"] set_default_hud_parameters();
  self.tank_hud_item["compass_scanline"].alignx = "center";
  self.tank_hud_item["compass_scanline"].aligny = "top";
  self.tank_hud_item["compass_scanline"].vertalign = "top";
  self.tank_hud_item["compass_scanline"].x = 200;
  self.tank_hud_item["compass_scanline"].y = -15;
  self.tank_hud_item["compass_scanline"].alpha = 1.0;
  var_1 = 0.0;

  for(;;) {
    foreach(var_3 in maps\_utility::getvehiclearray()) {
      if(var_3.script_team == "axis") {
        if(isDefined(var_3.hud_compass_elem) && isDefined(var_3.hud_compass_elem.visible) && var_3.hud_compass_elem.visible) {
          var_3.hud_compass_elem fadeovertime(0.05);
          var_3.hud_compass_elem.alpha = var_3.hud_compass_elem.alpha * 0.95;
        }
      }
    }

    if(var_1 > 0.0) {
      var_1 = var_1 - 0.05;
      wait 0.05;
      continue;
    }

    var_5 = angleclamp180(self.tank_hud_item["compass_scanline"].x / 200.0 * 180.0 + 5);
    var_6 = self.tank_hud_item["compass_scanline"].x - 15;

    if(var_6 < -220) {
      self.tank_hud_item["compass_scanline"].x = 200;
      self.tank_hud_item["compass_scanline"].alpha = 0.0;
      var_1 = 1;
    } else {
      self.tank_hud_item["compass_scanline"] moveovertime(0.05);
      self.tank_hud_item["compass_scanline"].x = var_6;
      self.tank_hud_item["compass_scanline"].alpha = 1.0;
    }

    var_7 = angleclamp180(var_6 / 200.0 * 180.0 - 5);

    foreach(var_3 in maps\_utility::getvehiclearray()) {
      if(isDefined(var_3.hud_compass_elem) && isDefined(var_3.hud_compass_elem.visible) && var_3.hud_compass_elem.visible) {
        var_9 = vectortoyaw(var_3.origin - self getEye());
        var_10 = angleclamp180(self getplayerangles()[1] - var_9);

        if(var_5 < var_7) {
          if(var_10 < var_5)
            var_3.hud_compass_elem.alpha = 1.0;
        } else if(var_10 < var_5 && var_10 > var_7)
          var_3.hud_compass_elem.alpha = 1.0;
      }
    }

    wait 0.05;
  }
}

tank_update_weapon_hud(var_0, var_1) {
  level endon("clear_tank_hud");

  while(!common_scripts\utility::flag("tow_out")) {
    if(!isDefined(var_1) || !var_1)
      self waittill("cycle_weapon");

    var_1 = 0;
    self.tank_hud_item["tank_overlay"].alpha = 0.0;
    self.tank_hud_item["reticle"].alpha = 0.0;
    self.tank_hud_item["reticle_center"].alpha = 0.0;
    self.tank_hud_item["reticle_center_cyan"].alpha = 0.0;
    self.tank_hud_item["reticle_center_red"].alpha = 0.0;
    self.tank_hud_item["reticle_cross"].alpha = 0.0;
    self.tank_hud_item["reticle_cross_cyan"].alpha = 0.0;
    self.tank_hud_item["reticle_cross_red"].alpha = 0.0;
    self.tank_hud_item["compass_heading"].alpha = 0.0;
    self.tank_hud_item["current_weapon"].x = 200;
    self.tank_hud_item["current_weapon"].weap = "missile";
    update_weapon_status("turret", &"SATFARM_IDLE");
    update_weapon_status("missile", &"SATFARM_READY");
    self.tank_hud_item["sabot_overlay"].alpha = 0.666;
    self.tank_hud_item["sabot_vignette"].alpha = 0.9;
    self.tank_hud_item["sabot_reticle"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_upper_left"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_upper_right"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_bottom_left"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_bottom_right"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_outer_left"].alpha = 0.666;
    self.tank_hud_item["sabot_reticle_outer_right"].alpha = 0.666;
    self.tank_hud_item["sabot_target_range"].alpha = 0.666;
    self.tank_hud_item["sabot_fuel_gauge"].alpha = 0.666;
    self.tank_hud_item["sabot_fuel_range"].alpha = 0.666;
    self.tank_hud_item["sabot_ROT"].alpha = 0.666;
    self.tank_hud_item["sabot_fuel_range_text"].alpha = 0.666;
    self.tank_hud_item["sabot_range_1"].alpha = 0.666;
    self.tank_hud_item["sabot_range_2"].alpha = 0.666;
    self.tank_hud_item["sabot_range_3"].alpha = 0.666;
    self.tank_hud_item["sabot_range_4"].alpha = 0.666;
    self.tank_hud_item["sabot_range_5"].alpha = 0.666;
    common_scripts\utility::flag_clear("ZOOM_ON");
    self notify("zoomout");
    self allowads(0);
    setsaveddvar("cg_fov", 20);
    self lerpfov(20, 0.05);
    var_2 = 3.25;
    var_2 = int(var_2 * 10) / 10;
    var_3 = "" + var_2 + common_scripts\utility::ter_op(modulus(var_2, 10) == 0, ".0 X", " X");
    self.tank_hud_item["turret_zoom"] settext(var_3);
    thread tank_missile_targeting();
    self waittill("cycle_weapon");
    setsaveddvar("cg_fov", 65);
    self lerpfov(65, 0.05);
    self allowads(1);
    self.tank_hud_item["turret_zoom"] settext("1.0 X");
    self.tank_hud_item["tank_overlay"].alpha = 0.5;
    self.tank_hud_item["reticle"].alpha = 0.666;
    self.tank_hud_item["reticle_center"].alpha = 0.666;
    self.tank_hud_item["reticle_cross"].alpha = 0.666;
    self.tank_hud_item["compass_heading"].alpha = 0.9;
    self.tank_hud_item["current_weapon"].x = 110;
    self.tank_hud_item["current_weapon"].weap = "turret";
    update_weapon_status("missile", &"SATFARM_IDLE");
    update_weapon_status("turret", &"SATFARM_READY");
    self.tank_hud_item["sabot_overlay"].alpha = 0.0;
    self.tank_hud_item["sabot_vignette"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_cyan"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_red"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_upper_left"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_upper_right"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_bottom_left"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_bottom_right"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_outer_left"].alpha = 0.0;
    self.tank_hud_item["sabot_reticle_outer_right"].alpha = 0.0;
    self.tank_hud_item["sabot_target_range"].alpha = 0.0;
    self.tank_hud_item["sabot_fuel_gauge"].alpha = 0.0;
    self.tank_hud_item["sabot_fuel_range"].alpha = 0.0;
    self.tank_hud_item["sabot_ROT"].alpha = 0.0;
    self.tank_hud_item["sabot_fuel_range_text"].alpha = 0.0;
    self.tank_hud_item["sabot_range_1"].alpha = 0.0;
    self.tank_hud_item["sabot_range_2"].alpha = 0.0;
    self.tank_hud_item["sabot_range_3"].alpha = 0.0;
    self.tank_hud_item["sabot_range_4"].alpha = 0.0;
    self.tank_hud_item["sabot_range_5"].alpha = 0.0;
  }
}

update_weapon_status(var_0, var_1) {
  if(isDefined(level.player.tank_hud_item[var_0 + "_status"].offline) && level.player.tank_hud_item[var_0 + "_status"].offline) {
    return;
  }
  if(level.player.tank_hud_item["current_weapon"].weap != var_0) {
    level.player.tank_hud_item[var_0 + "_name"].alpha = 0.25;
    level.player.tank_hud_item[var_0 + "_status"].alpha = 0.25;
  } else {
    level.player.tank_hud_item[var_0 + "_name"].alpha = 0.9;
    level.player.tank_hud_item[var_0 + "_status"].alpha = 0.9;
  }

  if(!isDefined(level.player.tank_hud_item[var_0 + "_status"].loading) || !level.player.tank_hud_item[var_0 + "_status"].loading) {
    if(var_1 == &"SATFARM_READY" && level.player.tank_hud_item["current_weapon"].weap != var_0)
      level.player.tank_hud_item[var_0 + "_status"] settext(&"SATFARM_IDLE");
    else
      level.player.tank_hud_item[var_0 + "_status"] settext(var_1);
  }
}

update_weapon_state(var_0) {
  level endon("clear_tank_hud");
  var_1 = 0;

  for(var_2 = self.width; var_1 < var_0; var_1 = var_1 + 0.05) {
    self setshader("red_block", int(max(var_1 / var_0 * var_2, 1)), self.height);
    wait 0.05;
  }

  self setshader("green_block", var_2, self.height);
}

tank_missile_targeting() {
  level endon("clear_tank_hud");
  self endon("cycle_weapon");
  var_0 = 17.6;

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = 0;
    var_4 = sortbydistance(maps\_utility::getvehiclearray(), self getEye());

    foreach(var_6 in var_4) {
      if(!isDefined(var_6.dead) || !var_6.dead) {
        if(!target_istarget(var_6)) {
          if(var_3 < 5) {
            target_set(var_6, common_scripts\utility::ter_op(var_6 maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72)));
            target_hidefromplayer(var_6, level.player);
            var_3++;
          }

          continue;
        }

        if(target_isinrect(var_6, self, getdvarfloat("cg_fov"), self.tank_hud_item["sabot_reticle_bottom_right"].x * 0.5, self.tank_hud_item["sabot_reticle_bottom_right"].y * 0.5) && sighttracepassed(self getEye(), var_6.origin + common_scripts\utility::ter_op(var_6 maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72)), 0, var_6, level.playertank)) {
          if(var_6.script_team == "axis")
            var_1 = var_6;
          else if(var_6.script_team == "allies")
            var_2 = var_6;

          break;
        }
      }
    }

    if(isDefined(var_1)) {
      if(self.tank_hud_item["sabot_reticle_red"].alpha == 0.0) {
        self.tank_hud_item["sabot_reticle_red"].alpha = 0.66;
        self.tank_hud_item["sabot_range_highlight"].alpha = 0.66;
        self.tank_hud_item["sabot_reticle"].alpha = 0.0;
      }

      var_8 = distance(var_1.origin, self.origin);

      if(var_8 <= 200 * var_0)
        self.tank_hud_item["sabot_range_highlight"].y = self.tank_hud_item["sabot_range_1"].y;
      else if(var_8 <= 400 * var_0)
        self.tank_hud_item["sabot_range_highlight"].y = self.tank_hud_item["sabot_range_2"].y;
      else if(var_8 <= 600 * var_0)
        self.tank_hud_item["sabot_range_highlight"].y = self.tank_hud_item["sabot_range_3"].y;
      else if(var_8 <= 800 * var_0)
        self.tank_hud_item["sabot_range_highlight"].y = self.tank_hud_item["sabot_range_4"].y;
      else
        self.tank_hud_item["sabot_range_highlight"].y = self.tank_hud_item["sabot_range_5"].y;
    } else if(isDefined(var_2)) {
      self.tank_hud_item["sabot_reticle_cyan"].alpha = 0.66;
      self.tank_hud_item["sabot_reticle_red"].alpha = 0.0;
      self.tank_hud_item["sabot_range_highlight"].alpha = 0.0;
      self.tank_hud_item["sabot_reticle"].alpha = 0.0;
    } else if(self.tank_hud_item["sabot_reticle"].alpha == 0.0) {
      self.tank_hud_item["sabot_reticle"].alpha = 0.66;
      self.tank_hud_item["sabot_reticle_cyan"].alpha = 0.0;
      self.tank_hud_item["sabot_reticle_red"].alpha = 0.0;
      self.tank_hud_item["sabot_range_highlight"].alpha = 0.0;
    }

    wait 0.05;
  }
}

static_on(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.sort = 200;
  var_4 setshader("black", 640, 480);
  var_5 = newclienthudelem(self);
  var_5.x = 0;
  var_5.y = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.horzalign = "fullscreen";
  var_5.vertalign = "fullscreen";
  var_5.sort = var_4.sort + 1;
  var_5 setshader("overlay_static", 640, 480);

  if(isDefined(var_2)) {
    var_5.alpha = 0.0;
    var_5 fadeovertime(var_2);
    var_5.alpha = var_1;
    var_4.alpha = 0.0;
    var_4 fadeovertime(var_2);
    var_4.alpha = var_1;
    wait(var_2);
  } else {
    var_5.alpha = var_1;
    var_4.alpha = var_1;
  }

  wait(var_0);

  if(isDefined(var_3)) {
    var_5 fadeovertime(var_3);
    var_5.alpha = 0.0;
    var_4 fadeovertime(var_3);
    var_4.alpha = 0.0;
    wait(var_3);
  }

  var_5 destroy();
  var_4 destroy();
}

set_default_hud_parameters() {
  self.alignx = "left";
  self.aligny = "top";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.hidewhendead = 0;
  self.hidewheninmenu = 1;
  self.sort = 205;
  self.foreground = 1;
  self.alpha = 0.65;
}

modulus(var_0, var_1) {
  var_2 = int(var_0 / var_1);
  return var_0 - var_2 * var_1;
}

on_fire_main_cannon() {
  var_0 = self;
  var_0 endon("death");
  level.player endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("BUTTON_FIRE_CANNON", "+attack");
  level.player notifyonplayercommand("BUTTON_FIRE_CANNON", "+attack_akimbo_accessible");
  wait 0.5;

  while(!common_scripts\utility::flag("all_guns_out")) {
    level.player waittill("BUTTON_FIRE_CANNON");

    if(isDefined(level.player.tank_hud_item["current_weapon"]) && level.player.tank_hud_item["current_weapon"].weap == "turret") {
      level.isfiring = 1;
      var_0 shoot_anim();
      level.player thread play_fire_bcs();
      level.player playSound("m1a1_abrams_antitank_fire_plr");
      thread maps\satfarm_audio::reload();

      if(isDefined(level.player.tank_hud_item["turret_status"])) {
        level.player.tank_hud_item["turret_state"] thread update_weapon_state(2.0);
        update_weapon_status("turret", &"SATFARM_LOADING");
        level.player.tank_hud_item["turret_status"].loading = 1;
      }

      wait 2;
      level.player thread play_reload_bcs();

      if(isDefined(level.player.tank_hud_item["turret_status"])) {
        level.player.tank_hud_item["turret_status"].loading = 0;
        update_weapon_status("turret", &"SATFARM_READY");
      }

      continue;
    }

    if(!isDefined(level.playertank.prevent_sabot_firing) || !level.playertank.prevent_sabot_firing) {
      level.isfiring = 1;
      var_0 shoot_anim();
      level.player thread play_fire_bcs();
      level.player playSound("m1a1_abrams_antitank_fire_plr");
      thread maps\satfarm_audio::reload();
      wait 2;
      level.player thread play_reload_bcs();
    }
  }

  if(isDefined(level.player.tank_hud_item["turret_status"]))
    level.player.tank_hud_item["turret_status"] settext(&"SATFARM_OFFLINE");
}

play_fire_bcs() {
  var_0 = createevent("inform_firing", "inform_firing");
  thread play_chatter(var_0);
}

play_reload_bcs() {
  var_0 = createevent("inform_loaded", "inform_loaded");
  thread play_chatter(var_0);
}

on_fire_mg() {
  var_0 = self;
  var_0 endon("death");
  level.player endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("BUTTON_FIRE_MG", "+frag");
  level.player notifyonplayercommand("BUTTON_STOP_MG", "-frag");

  if(isDefined(var_0.mgturret)) {
    var_0.mgturret[0] turretfiredisable();
    var_0 thread handle_mg_firing();

    for(;;) {
      level.player waittill("BUTTON_FIRE_MG");
      common_scripts\utility::flag_set("PLAYER_FIRED_MG_ONCE");
      common_scripts\utility::flag_set("MG_FIRE");
      level.player waittill("BUTTON_STOP_MG");
      common_scripts\utility::flag_clear("MG_FIRE");
    }
  }
}

handle_mg_firing() {
  var_0 = self;
  var_0 endon("death");
  level.player endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  var_1 = weaponfiretime("minigun_m1a1");
  var_2 = gettime() - var_1;

  for(;;) {
    if(common_scripts\utility::flag("MG_FIRE") && var_2 < gettime()) {
      var_3 = var_0 gettagorigin("tag_coax_mg");
      var_4 = level.player getplayerangles();
      var_5 = anglesToForward(var_4);
      var_6 = anglestoright(var_4);
      var_7 = self.mgturret[0] gettagorigin("tag_flash");
      var_8 = bulletTrace(level.player getEye(), level.player getEye() + var_5 * 12 * 2000, 1, level.player);
      var_9 = var_8["position"];
      var_10 = magicbullet("minigun_m1a1", var_7 + var_5 * 32, var_9, level.player);
      level.player playSound("satfarm_turret_temp_plr");
      playFXOnTag(common_scripts\utility::getfx("grenade_muzzleflash"), self.mgturret[0], "tag_flash");
      level.player playrumbleonentity("minigun_rumble");
      var_2 = gettime() + var_1 * 1000;

      if(!level.player fragButtonPressed()) {
        level.player notify("BUTTON_STOP_MG");
        common_scripts\utility::flag_clear("MG_FIRE");
      }
    }

    wait 0.05;
  }
}

on_pop_smoke() {
  var_0 = self;
  var_0 endon("death");
  level.player endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("BUTTON_POP_SMOKE", "+smoke");

  while(!common_scripts\utility::flag("smoke_out")) {
    level.player waittill("BUTTON_POP_SMOKE");
    common_scripts\utility::flag_set("PLAYER_POPPED_SMOKE_ONCE");
    common_scripts\utility::flag_set("POPPED_SMOKE");
    var_1 = level.player getplayerangles();
    var_2 = anglesToForward(var_1);
    var_3 = anglestoright(var_1);
    var_4 = bulletTrace(level.player getEye(), level.player getEye() + var_2 * 12 * 300, 1, level.player);
    var_5 = var_4["position"];
    var_0 launch_smoke(var_5);

    if(isDefined(level.player.tank_hud_item["smoke_status"]))
      pop_smoke_hud();

    common_scripts\utility::flag_clear("POPPED_SMOKE");
  }

  if(isDefined(level.player.tank_hud_item["smoke_status"])) {
    level.player.tank_hud_item["smoke_status"] settext(&"SATFARM_OFFLINE");
    level.player.tank_hud_item["smoke_status"].alpha = 0.0;
    level.player.tank_hud_item["smoke_name"].alpha = 0.0;
    level.player.tank_hud_item["smoke_state_bg"].alpha = 0.0;
    level.player.tank_hud_item["smoke_state"].alpha = 0.0;
  }
}

pop_smoke_hud() {
  level.player.tank_hud_item["smoke_state"] thread update_weapon_state(6.0);
  level.player.tank_hud_item["smoke_status"] settext(&"SATFARM_LOADING");
  wait 6;

  if(isDefined(level.player.tank_hud_item["smoke_status"]))
    level.player.tank_hud_item["smoke_status"] settext(&"SATFARM_READY");
}

launch_smoke(var_0) {
  if(common_scripts\utility::flag("player_in_tank")) {
    thread smoke_launcher_sound_player();
    level.player playrumbleonentity("damage_heavy");
  } else
    thread smoke_launcher_sound_3d();

  if(!isDefined(var_0))
    var_0 = trace_to_forward(1000)["position"];

  var_1 = [["tag_canister_left", 1000], ["tag_canister_left", 0], ["tag_canister_right", -1000]];
  var_2 = vectortoangles(var_0 - self getcentroid());
  var_2 = vectornormalize(anglestoright(var_2));

  foreach(var_4 in var_1)
  thread launch_smoke_from_tag(var_4[0], var_0 + var_2 * var_4[1]);

  return var_0;
}

launch_smoke_from_tag(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  var_1 = common_scripts\utility::drop_to_ground(var_1);
  playFXOnTag(level._effect["smoke_start"], self, var_0);
  var_4 = spawn("script_model", var_2);
  var_4 setModel("projectile_m203grenade");
  var_4.origin = var_2;
  var_4.angles = vectortoangles(vectornormalize(var_1 - var_2));
  playFXOnTag(level._effect["rpg_trail"], var_4, "tag_origin");
  var_4 maps\_utility::move_with_rate(var_1, var_4.angles, 12000);
  stopFXOnTag(level._effect["rpg_trail"], var_4, "tag_origin");
  playFX(level._effect["smoke_screen_flash"], var_1, anglesToForward(var_4.angles));
  playFX(level._effect["smoke_screen"], var_1, anglesToForward(var_4.angles));
  var_4 delete();
}

smoke_launcher_sound_player() {
  var_0 = randomfloatrange(0.1, 0.2);
  level.player playSound("satf_smoke_launcher_plr");
  wait(var_0);
  level.player playSound("satf_smoke_launcher_plr");
}

smoke_launcher_sound_3d() {
  var_0 = randomfloatrange(0.1, 0.2);
  var_1 = self gettagorigin("antenna1_jnt");
  var_2 = self gettagorigin("antenna2_jnt");
  thread common_scripts\utility::play_sound_in_space("satf_smoke_launcher_3d", var_1);
  wait(var_0);
  thread common_scripts\utility::play_sound_in_space("satf_smoke_launcher_3d", var_2);
}

trace_to_forward(var_0) {
  if(!isDefined(var_0))
    var_0 = 1000;

  var_1 = level.player getEye();
  var_2 = level.player getplayerangles();
  var_3 = anglesToForward(var_2);
  var_1 = var_1 + var_3 * 250;
  var_4 = var_1 + var_3 * var_0;
  return bulletTrace(var_1, var_4, 1, self);
}

smoke_screen_vis_blocker(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1.angles = (var_1.angles[0], self.angles[1] + 90, var_1.angles[2]);
  var_1 clonebrushmodeltoscriptmodel(getent("smoke_screen_vis_blocker", "targetname"));
  wait 6.0;
  var_1 delete();
}

turret_reset() {
  var_0 = (0, 0, 32) + self.origin + anglesToForward(self.angles) * 3000;
  self setturrettargetvec(var_0);
  self waittill("turret_on_target");
  self clearturrettarget();
}

on_fire_sabot() {
  level.player endon("remove_sabot");
  level.playertank endon("death");
  level.player endon("death");
  level.player endon("tank_dismount");
  level.player waittill("launch_sabot");
  var_0 = level.player.origin;
  var_1 = level.player getplayerangles();
  var_1 = (var_1[0], var_1[1], 0);
  var_0 = var_0 + anglesToForward(var_1) * 50;
  level thread maps\satfarm_audio::tow_missile_launch();
  level.player init_sabot_for_player(var_0, var_1, self);
  level.player thread remove_player_missile_control();
  level.player give_player_missile_control();
}

tank_handle_sabot(var_0) {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("cycle_weapon", "weapnext");
  level.player notifyonplayercommand("fire_sabot", "+attack");
  level.player notifyonplayercommand("fire_sabot", "+attack_akimbo_accessible");

  while(!common_scripts\utility::flag("tow_out")) {
    if(!isDefined(var_0) || !var_0)
      level.player waittill("cycle_weapon");

    if(!common_scripts\utility::flag("tow_out")) {
      var_0 = 0;
      level.player playSound("satf_change_view_tow");
      common_scripts\utility::flag_set("GUIDED_ROUND_ENABLED");
      thread weapon_toggle_hint();
      level.player thread maps\_utility::display_hint_timeout("HINT_GUIDED_ROUND_FIRE", 8.0);
      var_1 = level.player common_scripts\utility::waittill_any_return("cycle_weapon", "fire_sabot");
      level.player playSound("satf_change_view_normal");

      if(var_1 == "fire_sabot") {
        if(!isDefined(level.playertank.prevent_sabot_firing) || !level.playertank.prevent_sabot_firing) {
          level.player notify("launch_sabot");
          common_scripts\utility::flag_set("PLAYER_FIRED_GUIDED_ROUND");
        }
      } else {
        common_scripts\utility::flag_clear("GUIDED_ROUND_ENABLED");
        level.player.tank_hud_item["sabot_range_highlight"].alpha = 0;
      }
    }
  }

  if(isDefined(level.player.tank_hud_item["missile_status"]))
    level.player.tank_hud_item["missile_status"] settext(&"SATFARM_OFFLINE");
}

weapon_toggle_hint() {
  level.playertank endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level endon("PLAYER_FIRED_GUIDED_ROUND");

  if(!common_scripts\utility::flag("PLAYER_FIRED_GUIDED_ROUND")) {
    return;
  }
  wait 5.0;

  if(common_scripts\utility::flag("DISPLAYED_WEAPON_TOGGLE_HINT_ONCE")) {
    return;
  }
  level.player thread maps\_utility::display_hint_timeout("HINT_WEAPON_TOGGLE", 8.0);
  common_scripts\utility::flag_set("DISPLAYED_WEAPON_TOGGLE_HINT_ONCE");
}

generic_tank_spawner_setup() {
  maps\_utility::array_spawn_function_noteworthy("generic_tank_spawner", ::npc_tank_combat_init);
  maps\_utility::array_spawn_function_noteworthy("generic_tank_spawner", ::add_to_enemytanks_until_dead);
}

add_to_enemytanks_until_dead() {
  level.enemytanks = common_scripts\utility::array_add(level.enemytanks, self);
  self waittill("death");

  if(isDefined(self))
    level.enemytanks = common_scripts\utility::array_remove(level.enemytanks, self);
}

npc_tank_combat_init(var_0, var_1) {
  if(isDefined(self) && self.classname != "script_vehicle_corpse" && !isDefined(self.iscombatready)) {
    self endon("death");
    self.iscombatready = 1;
    self.numwaits = 0;
    thread handle_death();
    thread toggle_thermal_npc();
    thread start_sand_effects();

    if(self.script_team == "axis") {
      self enableaimassist();
      thread toggle_aim_assist();

      if(istank()) {}
    }

    if(istank()) {
      thread handle_damage(var_0);
      thread tank_wait_kill_me();

      if(!isDefined(var_1))
        thread manage_target_loc(var_0);

      waittillframeend;
      self notify("nodeath_thread");

      if(!isDefined(var_0) && !isDefined(self.relative_speed))
        thread proxmity_check_stop_loop();
    }
  }
}

toggle_aim_assist() {
  for(;;) {
    level.player waittill("assist");

    if(isDefined(self))
      self disableaimassist();

    wait 0.05;
  }
}

manage_target_loc(var_0) {
  self endon("death");
  wait(randomfloatrange(0.05, 0.5));

  if(!isDefined(self.targetingoffset))
    self.targetingoffset = (0, 0, 64);

  while(!common_scripts\utility::flag("all_tanks_stop_firing")) {
    if(!isDefined(var_0))
      manage_closest_target();

    if(!isDefined(self.tank_target)) {
      common_scripts\utility::waitframe();
      continue;
    }

    self setturrettargetent(self.tank_target, self.targetingoffset);
    wait(randomfloatrange(0.25, 0.5));

    if(!isDefined(self.disable_turret_fire)) {
      if(isDefined(self.override_target) && self.override_target.classname != "script_vehicle_corpse") {
        self setturrettargetent(self.override_target, self.targetingoffset);
        var_1 = self.override_target common_scripts\utility::waittill_any_timeout(1, "death");

        if(var_1 == "death" || isDefined(self.override_target) && self.override_target.classname == "script_vehcile_corpse") {
          self.override_target = undefined;
          self clearturrettarget();
        } else
          attempt_fire_loc();
      } else if(isDefined(self.tank_target) && self.tank_target.classname != "script_vehicle_corpse") {
        self setturrettargetent(self.tank_target, self.targetingoffset);
        var_1 = self.tank_target common_scripts\utility::waittill_any_timeout(1, "death");

        if(var_1 == "death" || isDefined(self.tank_target) && self.tank_target.classname == "script_vehcile_corpse") {
          self.tank_target = undefined;
          self clearturrettarget();
        } else
          attempt_fire_loc();
      } else {
        self.tank_target = undefined;
        self clearturrettarget();
      }
    }

    wait(randomfloatrange(0.25, 0.5));
  }
}

attempt_fire_loc() {
  if(!isDefined(self.tank_target))
    return 0;
  else if(self.classname != "script_vehicle_corpse" && self.tank_target sightconetrace(self.origin + (0, 0, 32), self) && istank()) {
    if(getfxvisibility(self.origin + (0, 0, 32), self.tank_target.origin + (0, 0, 32)) < 0.5)
      set_override_offset((0, 0, 192));
    else
      set_override_offset((0, 0, 0));

    shoot_anim();
    var_0 = self.tank_target common_scripts\utility::waittill_any_timeout(1, "death");

    if(var_0 == "death")
      self.tank_target = undefined;

    return 1;
  }

  return 0;
}

check_fire_angle() {
  for(var_0 = 0; var_0 < 20; var_0++) {
    if(!isDefined(self.tank_target))
      return 0;

    var_1 = self gettagangles("tag_flash");
    var_1 = vectornormalize(var_1);
    var_2 = self.origin - self.tank_target.origin;
    var_2 = vectornormalize(var_2);
    var_3 = vectordot(var_1, var_2);

    if(var_3 > 0.7)
      return 1;

    wait 0.1;
  }

  return 0;
}

tank_death_anim() {
  self waittill("death");

  if(!isDefined(self))
    return;
}

#using_animtree("vehicles");

shoot_anim() {
  self fireweapon();

  if(isDefined(level.playertank) && self == level.playertank && common_scripts\utility::flag("player_in_tank") && !common_scripts\utility::flag("ZOOM_ON"))
    playFXOnTag(common_scripts\utility::getfx("tank_muzzleflash"), self, "tag_flash");

  self clearanim(%abrams_shoot_kick, 0);
  self setanimrestart(%abrams_shoot_kick);
  thread tank_play_traced_effect();
}

do_decal_square(var_0) {
  var_1 = [(1, 0, 0), (0, 1, 0), (-1, 0, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)];

  foreach(var_3 in var_1) {
    var_4 = bulletTrace(var_0, var_0 + var_3 * 256, 0, self);

    if(var_4["fraction"] == 1.0) {
      continue;
    }
    if(!isDefined(var_4["surfacetype"])) {
      continue;
    }
    var_5 = var_4["surfacetype"];
    var_6 = vectortoangles(var_4["normal"]);

    if(isDefined(level._effect["tank_blast_decal_" + var_5])) {
      playFX(common_scripts\utility::getfx("tank_blast_decal_" + var_5), var_4["position"], anglesToForward(var_6), anglestoup(var_6));
      continue;
    }

    playFX(common_scripts\utility::getfx("tank_blast_decal_default"), var_4["position"], anglesToForward(var_6), anglestoup(var_6));
  }
}

tank_play_traced_effect() {
  var_0 = self gettagorigin("tag_flash");
  var_1 = common_scripts\utility::tag_project("tag_flash", 999999);
  var_2 = bulletTrace(var_0, var_1, 1, self);
  var_3 = var_2["surfacetype"];
  var_4 = isDefined(var_2["entity"]);
  var_5 = -1 * anglesToForward(self gettagangles("tag_flash"));
  var_6 = vectortoangles(var_2["normal"]);
  var_7 = var_2;

  if(var_4) {
    var_8 = bulletTrace(var_2["position"], var_2["position"] + (0, 0, -10000), 0, var_2["entity"]);
    var_7 = var_2;

    if(var_2["entity"].origin[2] - var_8["position"][2] < 54) {
      var_6 = vectortoangles(var_8["normal"]);
      var_7 = var_8;
    }
  }

  var_9 = 500;
  physicsexplosionsphere(var_2["position"], var_9 + 300, var_9 * 0.25, 1);
  var_10 = "tank_blast_decal_" + var_3;

  if(isDefined(var_10) && !issubstr(var_10, "grate")) {
    var_11 = common_scripts\utility::getfx(var_10);
    playFX(var_11, var_7["position"], anglesToForward(var_6), anglestoup(var_6));
  }

  if(common_scripts\utility::flag("player_in_tank") && isDefined(level.playertank) && common_scripts\utility::flag("ZOOM_ON") && distancesquared(var_2["position"], level.playertank.origin) < 4000000)
    playFX(common_scripts\utility::getfx("tank_blast_" + var_3 + "_low"), var_2["position"], anglesToForward(var_6), anglestoup(var_6));
  else
    playFX(common_scripts\utility::getfx("tank_blast_" + var_3), var_2["position"], anglesToForward(var_6), anglestoup(var_6));

  if(isDefined(level.playertank) && self != level.playertank || !isDefined(level.playertank))
    thread common_scripts\utility::play_sound_in_space("satf_player_sabot_explosion", var_2["position"]);
}

set_override_target(var_0) {
  if(isDefined(self) && isDefined(var_0) && isDefined(self.script_team) && isDefined(var_0.script_team) && self.script_team != var_0.script_team)
    self.override_target = var_0;
}

set_override_offset(var_0) {
  self.targetingoffset = var_0;
}

set_one_hit_kill() {
  while(isDefined(self) && self.classname != "script_vehicle_corpse") {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(self.script_team) && isDefined(var_1.script_team) && self.script_team != var_1.script_team && var_0 > 50)
      thread handle_tank_death();
  }
}

fire_on_non_vehicle(var_0, var_1) {
  self endon("death");
  self.disable_turret_fire = 1;
  var_2 = getent(var_0, "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  self setturrettargetent(var_2, var_1);
  wait 1;

  if(isDefined(var_2)) {
    magicbullet("tankfire_straight_fast", self gettagorigin("tag_flash"), var_2.origin + var_1, level.player);
    playFXOnTag(common_scripts\utility::getfx("tank_muzzleflash"), self, "tag_flash");
    self joltbody(self.origin, 1000, 1, 0.5);
    self clearanim(%abrams_shoot_kick, 0);
    self setanimrestart(%abrams_shoot_kick);
  }

  wait 1;
  self.disable_turret_fire = undefined;
}

fire_now_on_vehicle(var_0, var_1) {
  self endon("death");
  self.disable_turret_fire = 1;

  if(!isDefined(var_0)) {}

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  self setturrettargetent(var_0, var_1);
  wait 1;

  if(isDefined(var_0)) {
    magicbullet("tankfire_straight_fast", self gettagorigin("tag_flash"), var_0.origin + var_1);
    playFXOnTag(common_scripts\utility::getfx("tank_muzzleflash"), self, "tag_flash");
    self joltbody(self.origin, 1000, 1, 0.5);
    self clearanim(%abrams_shoot_kick, 0);
    self setanimrestart(%abrams_shoot_kick);
  }

  wait 1;
  self.disable_turret_fire = undefined;
}

handle_damage(var_0) {
  self.health = 200000;
  var_1 = self.health - self.healthbuffer;
  var_2 = 0;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);

    if(var_7 == "MOD_PROJECTILE" || var_7 == "MOD_EXPLOSIVE" || var_7 == "MOD_PROJECTILE_SPLASH") {
      if(!isDefined(var_4) || isDefined(self.godmode) && self.godmode || isDefined(self.classname) && self.classname == "script_vehicle_apache_mg") {
        thread handle_hit(var_4, var_3);
        continue;
      }

      if(isDefined(self.script_team) && self.script_team != "allies") {
        if(var_4 == level.playertank || var_4 == level.player) {
          break;
        }
      }

      if(isDefined(self.script_team) && self.script_team == "allies") {
        if(var_4 == level.playertank || var_4 == level.player) {
          var_2++;

          if(var_2 > 4) {
            break;
          }
        }
      }

      if(isDefined(var_4.script_team) && isDefined(self.script_team) && var_4.script_team != self.script_team) {
        var_2++;

        if(var_2 > 4) {
          break;
        }
      }

      thread handle_hit(var_4, var_3);
    }
  }

  if(isDefined(self))
    var_8 = common_scripts\utility::distance_2d_squared(self.origin, var_4.origin);
  else
    return;

  if(var_8 < 4000000 && var_3 > 250) {
    handle_tank_death(var_0);
    return;
  }

  var_9 = anglesToForward(self.angles);
  var_10 = vectornormalize(var_5);
  var_11 = abs(vectordot(var_9, var_10));

  if(var_11 < 0.9 && var_3 > 250) {
    handle_tank_death(var_0);
    return;
  }

  thread play_damaged_fx(var_1);
  thread handle_hit(var_4, var_3);

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7);

    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 == level.playertank || var_4 == level.player) {
      break;
    }

    if(isDefined(var_4.script_team) && var_4.script_team == "allies") {
      break;
    }
  }

  handle_tank_death(var_0);
}

play_damaged_fx(var_0) {
  self endon("death");

  while(isDefined(self) && self.classname != "script_vehicle_corpse" && maps\_utility::hastag(self.model, "tag_turret")) {
    playFXOnTag(common_scripts\utility::getfx("tank_heavy_smoke"), self, "tag_turret");
    wait 0.2;
  }
}

handle_hit(var_0, var_1) {
  set_override_target(var_0);

  if(isDefined(level.playertank) && isDefined(var_0) && var_0 == level.playertank || var_0 == level.player) {
    if(self.script_team == "allies" && var_1 > 200) {
      level.allyhitcount++;
      level thread maps\satfarm_audio::tank_damage_player(self.origin);

      if(common_scripts\utility::cointoss()) {
        if(common_scripts\utility::cointoss())
          self playSound("satfarm_td1_friendlyfirefriendlyfire", "bc_done", 1);
        else
          self playSound("satfarm_td1_ceasefireonfriendlies", "bc_done", 1);
      } else if(common_scripts\utility::cointoss())
        self playSound("satfarm_td1_friendlyfirefriendlyfire", "bc_done", 1);
      else
        self playSound("satfarm_td1_yourefiringonallies", "bc_done", 1);

      if(level.allyhitcount >= 3)
        maps\_friendlyfire::missionfail();
    } else {
      if(isDefined(self))
        level thread maps\satfarm_audio::tank_damage_player(self.origin);

      var_2 = createevent("inform_enemy_hit", "inform_hit");
      level.player play_chatter(var_2);
    }
  } else if(isDefined(self))
    level thread maps\satfarm_audio::tank_damage_allies(self.origin);
}

handle_death() {
  var_0 = self.script_team;
  var_1 = self.classname;

  while(isDefined(self) && self.classname != "script_vehicle_corpse")
    wait 0.01;

  if(isDefined(var_0) && var_0 == "allies") {
    return;
  }
  if(isDefined(self) && var_1 != "t90_sand" && target_istarget(self))
    target_remove(self);

  var_2 = createevent("killfirm", "killfirm");
  level.player play_chatter(var_2);
  return;
}

handle_friendly_fail() {
  for(;;) {
    wait 10;

    if(level.allyhitcount == 0) {
      continue;
    }
    level.allyhitcount--;
  }
}

spawn_death_collision(var_0) {
  while(isDefined(self) && self.classname != "script_vehicle_corpse")
    wait 0.05;

  if(isDefined(self)) {
    self notify("death");
    self setcontents(0);

    if(isDefined(self.deathfx_ent)) {
      self.deathfx_ent clonebrushmodeltoscriptmodel(level.death_model_col);

      if(isDefined(var_0)) {
        var_1 = spawn("trigger_radius", self.origin, 16, 8, 256);
        var_1.angles = self.angles;
        var_1 waittill("trigger");

        if(isDefined(self)) {
          self.deathfx_ent delete();
          self delete();
          var_1 delete();
        }
      }
    }
  }
}

spawn_death_collision_phys(var_0) {
  while(isDefined(self) && self.model != "vehicle_t90ms_tank_d_noturret_iw6" && self.model != "vehicle_m1a2_abrams_iw6_dmg")
    wait 0.05;

  if(isDefined(self)) {
    self notify("death");
    self setcontents(0);
    var_1 = spawn("script_model", self.origin);
    var_1.angles = self.angles;
    var_1 setModel(self.model);
    var_2 = spawn("script_model", self.origin);
    var_2 clonebrushmodeltoscriptmodel(level.death_model_col);
    var_2.angles = self.angles;
    self delete();

    if(isDefined(var_0)) {
      var_3 = spawn("trigger_radius", var_1.origin, 16, 8, 256);
      var_3.angles = var_1.angles;
      var_3 common_scripts\utility::waittill_any_timeout(10, "trigger");

      if(isDefined(var_1)) {
        var_1 moveto(var_1.origin - (0, 0, 16), 0.25);
        var_2 delete();
        var_3 delete();
      }

      wait 5;
    } else
      wait 10;

    for(;;) {
      if(!common_scripts\utility::within_fov(level.player.origin, level.player getplayerangles(), var_1.origin, cos(65))) {
        break;
      }

      wait 0.05;
    }

    common_scripts\utility::flag_wait(level.corpseflag);
    var_1 delete();

    if(isDefined(var_2))
      var_2 delete();
  }
}

handle_tank_death(var_0) {
  if(isDefined(self)) {
    self setcontents(0);
    var_1 = bulletTrace(self.origin + (0, 0, 32), self.origin - (0, 0, 256), 0, 0);
    var_2 = spawn("script_model", var_1["position"]);
    var_2.angles = self.angles;

    if(isDefined(self.script_team) && self.script_team == "allies") {
      var_2 setModel("vehicle_t90ms_tank_d_noturret_iw6");
      level thread maps\satfarm_audio::tank_death_allies(self.origin);
    } else {
      var_2 setModel("vehicle_t90ms_tank_d_noturret_iw6");
      level thread maps\satfarm_audio::tank_death_player(self.origin);
    }

    var_3 = spawn("script_model", self.origin);
    var_3 clonebrushmodeltoscriptmodel(level.death_model_col);
    var_3.angles = self.angles;

    if(isDefined(self.rumbletrigger))
      self.rumbletrigger delete();

    if(isDefined(self.mgturret)) {
      common_scripts\utility::array_levelthread(self.mgturret, maps\_vehicle_code::turret_deleteme);
      self.mgturret = undefined;
    }

    if(isDefined(self.script_team))
      level.vehicles[self.script_team] = common_scripts\utility::array_remove(level.vehicles[self.script_team], self);

    if(isDefined(self.script_linkname))
      level.vehicle_link[self.script_linkname] = common_scripts\utility::array_remove(level.vehicle_link[self.script_linkname], self);

    playFX(common_scripts\utility::getfx("vfx_big_tank_explosion"), var_2.origin + (0, 0, 48), var_2.angles, (270, 0, 0));
    level thread maps\satfarm_audio::tank_death_player(var_2.origin);
    self delete();

    if(isDefined(var_0)) {
      var_4 = spawn("trigger_radius", var_2.origin, 16, 8, 256);
      var_4.angles = var_2.angles;
      var_4 common_scripts\utility::waittill_any_timeout(10, "trigger");

      if(isDefined(var_2)) {
        var_2 moveto(var_2.origin - (0, 0, 16), 0.25);
        var_3 delete();
        var_4 delete();
      }

      wait 5;
    } else
      wait 10;

    for(;;) {
      if(!common_scripts\utility::within_fov(level.player.origin, level.player getplayerangles(), var_2.origin, cos(65))) {
        break;
      }

      wait 0.05;
    }

    common_scripts\utility::flag_wait(level.corpseflag);
    var_2 delete();

    if(isDefined(var_3))
      var_3 delete();
  }
}

tank_wait_kill_me() {
  self endon("death");
  maps\_utility::ent_flag_init("tank_kill_me");
  maps\_utility::ent_flag_wait("tank_kill_me");
  thread handle_tank_death();
}

playerhaslineofsight() {
  self endon("death");
  thread toggle_npc_target();

  while(isDefined(self) && self.classname != "script_vehicle_corpse") {
    if(isDefined(self) && self.classname != "script_vehicle_corpse" && self sightconetrace(level.player.origin + (0, 0, 32), level.player)) {
      if(!level.istargetingoff) {
        var_0 = "ac130_hud_enemy_vehicle_target_s_w";
        var_1 = (1, 0, 0);
        thread target_enable(self, var_0, var_1, 128);
      }
    } else if(target_istarget(self))
      target_remove(self);

    wait 0.01;
  }
}

toggle_npc_target() {
  level.player notifyonplayercommand("target", "+actionslot 3");
  level.istargetingoff = 0;

  while(isDefined(self) && self.classname != "script_vehicle_corpse") {
    if(target_istarget(self))
      target_remove(self);

    level.istargetingoff = 1;
    wait 0.05;
    level.player waittill("target");
    var_0 = "ac130_hud_enemy_vehicle_target_s_w";
    var_1 = (1, 0, 0);

    if(isDefined(self) && self.classname != "script_vehicle_corpse")
      thread target_enable(self, var_0, var_1, 128);

    level.istargetingoff = 0;
    wait 0.05;
    level.player waittill("target");
  }
}

target_enable(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_4 = common_scripts\utility::ter_op(var_0 maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72));
  target_alloc(var_0, var_4);
  target_setshader(var_0, var_1);
  target_setscaledrendermode(var_0, 1);

  if(isDefined(var_2))
    target_setcolor(var_0, var_2);

  target_setmaxsize(var_0, 24);
  target_setminsize(var_0, 16, 0);
  target_flush(var_0);
}

init_chatter() {
  if(isDefined(anim.tank_bc)) {
    return;
  }
  level.tank_chatter_enabled = 1;
  anim.tank_bc = spawnStruct();
  anim.tank_bc.bc_isspeaking = 0;
  anim.tank_bc.numtankvoices = 1;
  anim.tank_bc.currentassignedvoice = 0;
  anim.tank_bc.lastalias = [];
  anim.tank_bc.bc_eventtypelastusedtime = [];
  anim.tank_bc.bc_eventtypelastusedtimeplr = [];
  anim.tank_bc.eventtypeminwait = [];
  anim.tank_bc.eventtypeminwait["same_alias"] = 15;
  anim.tank_bc.eventtypeminwait["callout_clock"] = 10;
  anim.tank_bc.eventtypeminwait["killfirm"] = 3;
  anim.tank_bc.eventtypeminwait["inform_firing"] = 10;
  anim.tank_bc.eventtypeminwait["inform_taking_fire"] = 30;
  anim.tank_bc.eventtypeminwait["inform_reloading"] = 5;
  anim.tank_bc.eventtypeminwait["inform_loaded"] = 0.5;
  anim.tank_bc.eventtypeminwait["inform_enemy_hit"] = 5;
  anim.tank_bc.eventtypeminwait["inform_enemy_retreat"] = 5;
  anim.tank_bc.bcprintfailprefix = "^3***** BCS FAILURE: ";

  if(isPlayer(self)) {
    self.voiceid = "plr";
    self.bc_isspeaking = 0;
    thread enemy_callout_tracking_plr();
  } else
    return;

  self.bc_enabled = 1;
}

createevent(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.eventtype = var_0;
  var_2.alias = var_1;
  return var_2;
}

play_chatter(var_0, var_1) {
  self endon("death");

  if(common_scripts\utility::flag("stop_tank_chatter"))
    return 0;

  if(!can_say_event_type(var_0.eventtype))
    return 0;

  var_2 = get_team_prefix() + self.voiceid + "_" + var_0.alias;

  if(!isDefined(var_2))
    return 0;

  if(!soundexists(var_2))
    return 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1 && !can_say_soundalias(var_2))
    return 0;

  if(isPlayer(self))
    self.bc_isspeaking = 1;
  else
    anim.tank_bc.bc_isspeaking = 1;

  self playSound(var_2, "bc_done", 1);
  self waittill("bc_done");

  if(isPlayer(self))
    self.bc_isspeaking = 0;
  else
    anim.tank_bc.bc_isspeaking = 0;

  update_event_type(var_0.eventtype, var_0.alias);
  return 1;
}

can_say_event_type(var_0) {
  if(!isDefined(level.tank_chatter_enabled) || !level.tank_chatter_enabled)
    return 0;

  if(isDefined(self.bc_enabled) && !self.bc_enabled)
    return 0;

  if(!isPlayer(self) && anim.tank_bc.bc_isspeaking)
    return 0;
  else if(isPlayer(self) && self.bc_isspeaking)
    return 0;

  if(isPlayer(self) && !isDefined(anim.tank_bc.bc_eventtypelastusedtimeplr[var_0]))
    return 1;
  else if(!isPlayer(self) && !isDefined(anim.tank_bc.bc_eventtypelastusedtime[var_0]))
    return 1;

  if(isPlayer(self))
    var_1 = anim.tank_bc.bc_eventtypelastusedtimeplr[var_0];
  else
    var_1 = anim.tank_bc.bc_eventtypelastusedtime[var_0];

  var_2 = anim.tank_bc.eventtypeminwait[var_0] * 1000;

  if(gettime() - var_1 >= var_2)
    return 1;

  return 0;
}

can_say_soundalias(var_0) {
  if(isDefined(anim.tank_bc.lastalias["alias"]) && anim.tank_bc.lastalias["alias"] == var_0) {
    var_1 = anim.tank_bc.lastalias["time"];
    var_2 = anim.tank_bc.eventtypeminwait["same_alias"] * 1000;

    if(gettime() - var_1 < var_2)
      return 0;
  }

  return 1;
}

update_event_type(var_0, var_1) {
  if(isPlayer(self))
    anim.tank_bc.bc_eventtypelastusedtimeplr[var_0] = gettime();
  else
    anim.tank_bc.bc_eventtypelastusedtime[var_0] = gettime();

  anim.tank_bc.lastalias["time"] = gettime();
  anim.tank_bc.lastalias["alias"] = var_1;
}

check_overrides(var_0, var_1) {
  return var_1;
}

get_team_prefix() {
  return "satfarm_tank_";
}

take_fire_tracking() {
  self endon("death");
  level.player endon("tank_dismount");

  for(;;) {
    self waittill("damage", var_0, var_1);
    self.request_move = 1;

    if(isDefined(var_1)) {
      if(!isPlayer(var_1)) {
        var_2 = createevent("inform_taking_fire", "inform_taking_fire");
        play_chatter(var_2);
      }
    }
  }
}

enemy_callout_tracking_plr() {
  self endon("death");
  level.player endon("tank_dismount");

  for(;;) {
    var_0 = undefined;
    var_1 = [];
    var_2 = maps\_utility::getvehiclearray();

    foreach(var_4 in var_2) {
      if(var_4.script_team != "allies")
        var_1 = common_scripts\utility::array_add(var_1, var_4);
    }

    var_1 = sortbydistance(var_1, self.origin);

    foreach(var_7 in var_1) {
      if(isDefined(var_7.lastplayercallouttime) && gettime() - var_7.lastplayercallouttime < 45000) {
        continue;
      }
      if(distance2d(self.origin, var_7.origin) > 8000) {
        break;
      }

      var_0 = var_7;
      break;
    }

    if(!isDefined(var_0)) {
      var_1 = getaiarray("axis");
      var_1 = common_scripts\utility::array_combine(getaiarray("team3"), var_1);
      var_1 = sortbydistance(var_1, self.origin);

      foreach(var_7 in var_1) {
        if(isDefined(var_7.lastplayercallouttime) && gettime() - var_7.lastplayercallouttime < 45000) {
          continue;
        }
        if(distance2d(self.origin, var_7.origin) > 8000) {
          break;
        }

        var_0 = var_7;
        break;
      }
    }

    if(isDefined(var_0)) {
      var_11 = createevent("callout_clock", getthreatalias(var_0));

      if(play_chatter(var_11)) {
        if(isDefined(var_0))
          var_0.lastplayercallouttime = gettime();
      }
    }

    wait 1;
  }
}

getthreatalias(var_0) {
  if(isPlayer(self))
    var_1 = animscripts\battlechatter::getdirectionfacingclock(self getplayerangles(), self.origin, var_0.origin);
  else
    var_1 = animscripts\battlechatter::getdirectionfacingclock(self.angles, self.origin, var_0.origin);

  var_2 = "callout_targetclock_" + var_1;

  if(common_scripts\utility::cointoss()) {
    if(isai(var_0))
      var_2 = var_2 + "_troops";

    if(var_0 maps\_vehicle::isvehicle()) {
      if(var_0 maps\_vehicle::ishelicopter())
        var_2 = var_2 + "_bird";

      if(var_0 istank())
        var_2 = var_2 + "_tank";
    }
  }

  return var_2;
}

nav_mesh_build() {
  level.pos_info_array = [];
  var_0 = getvehiclenodearray("tank_enemy_nodes", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2 is_path_start_node()) {
      var_2.nav_type = "path_start";
      add_path_start_and_end_refs(var_2);
      continue;
    }

    if(var_2 is_path_end_node()) {
      var_2.nav_type = "path_end";
      continue;
    }

    var_2.nav_type = "path";
  }

  foreach(var_2 in var_0) {
    if(var_2 is_path_mid_node()) {
      continue;
    }
    if(isDefined(var_2.pos_info)) {
      continue;
    }
    var_7 = spawnStruct();
    var_7.nodes_start = [];
    var_7.nodes_end = [];
    level.pos_info_array[level.pos_info_array.size] = var_7;

    for(var_8 = 0; var_8 < var_0.size; var_8++) {
      var_9 = undefined;

      if(isDefined(var_0[var_8].script_linkname) && isDefined(var_0[var_8].script_linkto))
        var_9 = 1;

      if(!isDefined(var_0[var_8].script_linkto)) {
        if(!isDefined(var_0[var_8].script_linkname))
          continue;
        else if(isDefined(var_2.script_linkto) && var_0[var_8].script_linkname != var_2.script_linkto)
          continue;
        else if(isDefined(var_2.script_linkname) && var_0[var_8].script_linkname != var_2.script_linkname)
          continue;
      } else if(isDefined(var_2.script_linkname) && var_0[var_8].script_linkto != var_2.script_linkname)
        continue;
      else if(isDefined(var_2.script_linkto) && var_0[var_8].script_linkto != var_2.script_linkto) {
        continue;
      }
      if(var_0[var_8] is_path_start_node())
        var_7.nodes_start[var_7.nodes_start.size] = var_0[var_8];
      else if(var_0[var_8] is_path_end_node())
        var_7.nodes_end[var_7.nodes_end.size] = var_0[var_8];
      else
        continue;

      var_0[var_8].pos_info = var_7;
      var_0[var_8].exit_node = var_9;
    }
  }
}

is_path_end_node() {
  if(isDefined(self.nav_type))
    return self.nav_type == "path_end";

  var_0 = isDefined(self.target) && isDefined(getvehiclenode(self.target, "targetname"));
  var_1 = isDefined(self.targetname) && isDefined(getvehiclenode(self.targetname, "target"));
  return !var_0 && var_1;
}

is_path_start_node() {
  if(isDefined(self.nav_type))
    return self.nav_type == "path_start";

  return isDefined(self.spawnflags) && self.spawnflags & 1;
}

is_path_mid_node() {
  if(isDefined(self.nav_type))
    return self.nav_type == "path";

  return !is_path_start_node() && !is_path_end_node();
}

add_path_start_and_end_refs(var_0) {
  var_0.path_end = var_0 get_path_end_node();
  var_0.path_end.path_start = var_0;
}

get_path_end_node() {
  for(var_0 = self; isDefined(var_0.target); var_0 = getvehiclenode(var_0.target, "targetname")) {}

  return var_0;
}

nav_mesh_pathing(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = "nostopping";

  if(!isDefined(self)) {
    return;
  }
  thread proxmity_check_stop_loop(var_1, "", 1);
  self.stuck = 0;
  thread manage_position_in_use_loc(var_0);
  self.pastswitch = var_0;
  switch_node_now(self, var_0);
  self waittill("reached_end_node");
  wait 0.05;
  var_2 = undefined;

  while(!common_scripts\utility::flag(var_1)) {
    if(!isDefined(var_2)) {
      var_3 = self.currentnode.pos_info;
      var_4 = self.currentnode;

      if(self.veh_pathdir == "reverse") {
        var_3 = self.attachedpath.pos_info;
        var_4 = self.attachedpath;
      }

      if(!isDefined(var_3)) {
        wait 0.5;
        continue;
      }

      var_5 = get_optimal_next_path_loc(var_3);

      if(!isDefined(var_5)) {
        wait 0.5;
        continue;
      }

      thread manage_position_in_use_loc(var_5.path_end);
      var_6 = var_5.path_end.pos_info;

      if(var_4 is_path_end_node() && var_4.path_start.origin == var_5.path_end.origin)
        var_5 = var_4;

      var_7 = var_5 is_path_end_node();

      if(var_7)
        var_5 = var_5.path_start;

      var_8 = same_path(var_5);

      if(var_8 && var_7)
        self.veh_transmission = "reverse";
      else
        self.veh_transmission = "forward";

      if(var_7)
        self.veh_pathdir = "reverse";
      else
        self.veh_pathdir = "forward";

      if(!var_8) {
        switch_node_now(self, var_5);
        self vehicle_setspeed(20, 25, 25);
        self resumespeed(25);
      } else {
        self startpath();
        self vehicle_setspeed(20, 25, 25);
        self resumespeed(25);
      }
    } else {
      switch_node_now(self, var_2);
      self vehicle_setspeed(20, 25, 25);
      self resumespeed(25);
      self waittill("reached_end_node");
      var_2 = undefined;
    }

    if(self.veh_pathdir == "forward" && !self.currentnode is_path_end_node()) {
      var_9 = undefined;

      while(!common_scripts\utility::flag(var_1)) {
        if(!self.currentnode is_path_end_node() && isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
          if(isDefined(var_9) && self.currentnode.target != var_9.targetname)
            var_9 = getvehiclenode(self.currentnode.target, "targetname");
          else if(!isDefined(var_9))
            var_9 = getvehiclenode(self.currentnode.target, "targetname");

          if(isDefined(var_9) && var_9 is_path_end_node()) {
            var_2 = get_optimal_next_path_loc(var_9.pos_info);

            if(isDefined(var_2) && isDefined(var_2.pos_info.prev_in_use) && var_2.pos_info.prev_in_use == self)
              wait 2;

            break;
          }
        } else {
          if(self.currentnode is_path_end_node()) {
            var_2 = get_optimal_next_path_loc(self.currentnode.pos_info);

            if(isDefined(var_2) && isDefined(var_2.pos_info.prev_in_use) && var_2.pos_info.prev_in_use == self)
              wait 2;

            break;
          }

          break;
        }

        var_9 common_scripts\utility::waittill_any_timeout(4, "trigger");
      }
    }

    if(isDefined(var_2)) {
      thread manage_position_in_use_loc(var_2.path_end);
      continue;
    }

    self waittill("reached_end_node");
    wait 0.5;
  }

  if(isDefined(self) && self.classname != "script_vehicle_corpse")
    nav_mesh_exit(self.currentnode);
}

same_path(var_0) {
  if(isDefined(self.attachedpath)) {
    if(self.attachedpath == var_0)
      return 1;
    else if(isDefined(self.attachedpath.script_linkname) && isDefined(var_0.script_linkname)) {
      var_1 = strtok(self.attachedpath.script_linkname, "_");
      var_2 = strtok(var_0.script_linkname, "_");

      if(var_1[1] == var_2[1])
        return 1;

      if(isDefined(var_0.script_linkto)) {
        var_3 = strtok(var_0.script_linkto, "_");

        if(var_1[1] == var_3[1])
          return 1;
      }
    }
  }

  return 0;
}

nav_mesh_exit(var_0) {
  self endon("death");
  level.inc = 0;
  self.shortestdepth = 0;
  var_1 = [];
  var_1[0] = var_0;
  var_2 = [];
  var_2 = nav_mesh_exit_recursive(var_1);

  if(!isDefined(var_2))
    return undefined;

  if(var_2.size == 0)
    return undefined;

  wait 0.05;
  var_3 = undefined;
  var_4 = 1;

  foreach(var_6 in var_2) {
    var_3 = var_6;

    if(isDefined(var_6.path_start) && isDefined(var_6.path_start.path_end)) {
      if(!isDefined(var_6.path_start.path_end.pos_info.in_use) || isDefined(var_6.path_start.path_end.pos_info.in_use) && var_6.path_start.path_end.pos_info.in_use == self) {
        if(!isDefined(var_6.path_start.path_end.pos_info.prev_in_use)) {
          thread manage_position_in_use_loc(var_6.path_start.path_end);
          switch_node_now(self, var_6.path_start);
          var_7 = strtok(var_6.path_start.script_linkname, "_");
          var_8 = var_7[1];
        } else if(var_6.path_start.path_end.pos_info.prev_in_use == self) {
          thread manage_position_in_use_loc(var_6.path_start.path_end);
          switch_node_now(self, var_6.path_start);
          var_7 = strtok(var_6.path_start.script_linkname, "_");
          var_8 = var_7[1];
        } else
          continue;
      } else
        continue;
    } else
      continue;

    wait 0.05;
    self waittill("reached_end_node");
    wait 0.05;
  }

  var_10 = getvehiclenode(self.exitnodename, "targetname");

  if(isDefined(var_10))
    switch_node_now(self, var_10);
}

nav_mesh_exit_recursive(var_0) {
  var_1 = [];

  if(isDefined(var_0[var_0.size - 1].exit_node)) {
    if(self.shortestdepth > var_0.size || self.shortestdepth == 0)
      self.shortestdepth = var_0.size;

    return var_0;
  } else if(var_0.size > 15)
    return var_1;
  else {
    var_2 = var_0[var_0.size - 1];

    foreach(var_4 in var_2.pos_info.nodes_start) {
      if(!array_contains_script_linkto(var_0, var_4.path_end)) {
        var_5 = var_0;
        var_5[var_5.size] = var_4.path_end;
        var_6 = nav_mesh_exit_recursive(var_5);

        if(var_6.size == self.shortestdepth)
          var_1 = var_6;
      }
    }
  }

  return var_1;
}

array_contains_script_linkto(var_0, var_1) {
  if(var_0.size <= 0)
    return 0;

  var_2 = "";

  if(isDefined(var_1.script_linkto)) {
    var_3 = strtok(var_1.script_linkto, "_");
    var_2 = var_3[1];
  } else if(isDefined(var_1.script_linkname)) {
    var_3 = strtok(var_1.script_linkname, "_");
    var_2 = var_3[1];
  }

  foreach(var_5 in var_0) {
    if(isDefined(var_5.script_linkto)) {
      var_6 = strtok(var_5.script_linkto, "_");
      var_7 = var_6[1];

      if(var_7 == var_2)
        return 1;

      continue;
    }

    if(isDefined(var_5.script_linkname)) {
      var_6 = strtok(var_5.script_linkname, "_");
      var_7 = var_6[1];

      if(var_7 == var_2)
        return 1;
    }
  }

  return 0;
}

get_optimal_next_path_loc(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.nodes_start) {
    if(!isDefined(var_3.path_end.pos_info.in_use)) {
      var_1[var_1.size] = var_3.path_end;
      continue;
    }
  }

  if(!var_1.size)
    return undefined;

  manage_closest_target();

  if(!isDefined(self.tank_move_target))
    return undefined;

  var_1 = sortbydistance(var_1, self.tank_move_target.origin);
  var_5 = var_0.nodes_start[0];
  var_6 = distancesquared(var_5.origin, self.tank_move_target.origin);
  var_7 = undefined;
  var_8 = undefined;

  foreach(var_10 in var_1) {
    var_11 = distancesquared(self.tank_move_target.origin, var_10.origin);

    if(var_11 < 1000000) {
      continue;
    }
    var_12 = distancesquared(var_5.origin, var_10.origin);

    if(var_11 < var_12 && var_6 < var_12) {
      continue;
    }
    if(!isDefined(var_7) || var_11 < var_8) {
      var_7 = var_10;
      var_8 = var_11;
    }
  }

  if(!isDefined(var_7)) {
    self.numwaits++;
    return undefined;
  }

  if(isDefined(self.numwaits) && self.numwaits >= 5) {
    self.numwaits = 0;
    return var_7.path_start;
  }

  if(var_6 > 1000000 && (!isDefined(var_7) || var_8 > var_6)) {
    self.numwaits++;
    return undefined;
  }

  self.numwaits = 0;
  return var_7.path_start;
}

get_optimal_next_path_los_check(var_0) {
  self endon("death");
  level.inc = 0;
  self.shortestdepth = 0;
  var_1 = [];
  var_1[0] = var_0;
  var_2 = [];
  var_2 = get_optimal_next_path_recursive(var_1);

  if(!isDefined(var_2)) {
    self.numwaits++;
    wait 0.5;
    return 0;
  }

  if(var_2.size == 0) {
    self.numwaits++;
    wait 0.5;
    return 0;
  }

  wait 0.05;
  var_3 = undefined;
  var_4 = 1;

  foreach(var_6 in var_2) {
    var_3 = var_6;

    if(isDefined(var_6.path_start) && isDefined(var_6.path_start.path_end)) {
      if(!isDefined(var_6.path_start.path_end.pos_info.in_use) || isDefined(var_6.path_start.path_end.pos_info.in_use) && var_6.path_start.path_end.pos_info.in_use != self) {
        if(!isDefined(var_6.path_start.path_end.pos_info.prev_in_use)) {
          thread manage_position_in_use_loc(var_6.path_start.path_end);
          switch_node_now(self, var_6.path_start);
          var_7 = strtok(var_6.path_start.script_linkname, "_");
          var_8 = var_7[1];
        } else if(var_6.path_start.path_end.pos_info.prev_in_use == self) {
          thread manage_position_in_use_loc(var_6.path_start.path_end);
          switch_node_now(self, var_6.path_start);
          var_7 = strtok(var_6.path_start.script_linkname, "_");
          var_8 = var_7[1];
        } else
          continue;
      } else
        continue;
    } else
      continue;

    wait 0.05;
    self waittill("reached_end_node");
    wait 0.05;
  }

  wait 0.5;
  self.numwaits = 0;
  return 1;
}

get_optimal_next_path_recursive(var_0) {
  var_1 = [];

  if(self.tank_move_target sightconetrace(var_0[var_0.size - 1].origin + (0, 0, 64)) && !isDefined(var_0[var_0.size - 1].pos_info.in_use)) {
    if(self.shortestdepth > var_0.size || self.shortestdepth == 0)
      self.shortestdepth = var_0.size;

    return var_0;
  } else if(var_0.size > 4 || isDefined(var_0[var_0.size - 1].pos_info.in_use))
    return var_1;
  else {
    var_2 = var_0[var_0.size - 1];

    foreach(var_4 in var_2.pos_info.nodes_start) {
      if(!array_contains_script_linkto(var_0, var_4.path_end)) {
        var_5 = var_0;
        var_5[var_5.size] = var_4.path_end;
        var_6 = get_optimal_next_path_recursive(var_5);

        if(var_6.size == self.shortestdepth)
          var_1 = var_6;
      }
    }
  }

  return var_1;
}

array_sort_by_handler_parameter(var_0, var_1, var_2) {
  if(isDefined(self)) {
    for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
      if(isDefined(self) && isDefined(var_0[var_3])) {
        for(var_4 = var_3 + 1; var_4 < var_0.size; var_4++) {
          if(isDefined(self) && isDefined(var_0[var_4]) && isDefined(var_0[var_3])) {
            if(var_0[var_4][[var_1]](var_2) < var_0[var_3][[var_1]](var_2)) {
              var_5 = var_0[var_4];
              var_0[var_4] = var_0[var_3];
              var_0[var_3] = var_5;
            }
          }
        }
      }
    }
  }

  return var_0;
}

distance_squared_from_player_loc(var_0) {
  return distancesquared(self.origin, var_0.origin);
}

get_hinds_enemy_active() {
  return getEntArray("lockon_targets", "script_noteworthy");
}

manage_closest_target() {
  self endon("death");

  if(isDefined(self.tank_target) && self.tank_target.classname == "script_vehicle_corpse")
    self.tank_target = undefined;

  if(isDefined(self.tank_move_target) && self.tank_move_target.classname == "script_vehicle_corpse")
    self.tank_move_target = undefined;

  var_0 = [];

  if(self.script_team == "allies") {
    if(isDefined(level.enemytanks) && level.enemytanks.size)
      var_0 = common_scripts\utility::array_combine(var_0, level.enemytanks);

    if(isDefined(level.enemygazs) && level.enemygazs.size)
      var_0 = common_scripts\utility::array_combine(level.enemygazs, var_0);

    manage_closest_target_ally(var_0);
  } else if(self.script_team == "axis") {
    var_0 = level.allytanks;

    if(isDefined(level.playertank)) {
      var_0 = common_scripts\utility::array_insert(level.allytanks, level.playertank, level.allytanks.size);
      var_1 = distancesquared(level.playertank.origin, self.origin);
      self.tank_move_target = level.playertank;
    }

    manage_closest_target_axis(var_0);
  } else {}
}

manage_closest_target_ally(var_0) {
  var_0 = clean_tank_array(var_0);
  var_1 = 1000000000;

  if(var_0.size && isDefined(self)) {
    var_2 = sortbydistance(var_0, self.origin);

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4)) {
          var_5 = distancesquared(var_4.origin, self.origin);
          var_6 = distancesquared(var_4.origin, level.player.origin);

          if(var_5 < 1000000) {
            if(var_5 < var_1 && isDefined(var_4) && var_4.classname != "script_vehicle_corpse" && self.classname != "script_vehicle_corpse") {
              var_1 = var_5;
              self.tank_move_target = var_4;

              if(var_4 sightconetrace(self.origin + (0, 0, 32), self))
                self.tank_target = var_4;
            }
          } else if(var_6 < var_1 && isDefined(var_4) && var_4.classname != "script_vehicle_corpse" && self.classname != "script_vehicle_corpse") {
            var_1 = var_6;
            self.tank_move_target = var_4;

            if(var_4 sightconetrace(self.origin + (0, 0, 32), self))
              self.tank_target = var_4;
          }
        }
      }
    }
  }
}

manage_closest_target_axis(var_0) {
  var_0 = clean_tank_array(var_0);
  var_1 = 1000000000;

  if(var_0.size && isDefined(self)) {
    var_2 = sortbydistance(var_0, self.origin);

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4)) {
          var_5 = distancesquared(var_4.origin, self.origin);

          if(var_5 < var_1 && isDefined(var_4) && var_4.classname != "script_vehicle_corpse" && self.classname != "script_vehicle_corpse") {
            var_1 = var_5;
            self.tank_move_target = var_4;

            if(var_4 sightconetrace(self.origin + (0, 0, 32), self))
              self.tank_target = var_4;
          }
        }
      }
    }
  }
}

manage_position_in_use_loc(var_0) {
  self notify("clear_last_position");
  self endon("death");

  if(isDefined(var_0.pos_info.in_use) && var_0.pos_info.in_use != self)
    return 0;

  thread manage_clear_dead(var_0);

  if(isDefined(var_0.pos_info.nodes_end)) {
    foreach(var_2 in var_0.pos_info.nodes_end) {
      if(isDefined(var_2.pos_info.in_use) && var_2.pos_info.in_use != self)
        return 0;
      else
        var_2.pos_info.in_use = self;
    }
  }

  self waittill("clear_last_position");

  if(isDefined(var_0.pos_info.nodes_end)) {
    foreach(var_2 in var_0.pos_info.nodes_end) {
      var_2.pos_info.in_use = undefined;
      var_2.pos_info.prev_in_use = self;
    }
  }

  self waittill("clear_last_position");

  if(isDefined(var_0.pos_info.nodes_end)) {
    foreach(var_2 in var_0.pos_info.nodes_end)
    var_2.pos_info.prev_in_use = undefined;
  }
}

manage_clear_dead(var_0) {
  self notify("manage_clear_dead");
  self endon("manage_clear_dead");
  self waittill("death");

  if(isDefined(var_0.pos_info.nodes_end)) {
    foreach(var_2 in var_0.pos_info.nodes_end) {
      var_2.pos_info.in_use = undefined;
      var_2.pos_info.prev_in_use = undefined;
    }
  }
}

manage_switching_vehicle_speed_loc(var_0) {
  self endon("death");
  self notify("switching_path_speed_update");
  self endon("switching_path_speed_update");
  var_1 = self vehicle_getspeed();

  if(var_1 == 0)
    self vehicle_setspeedimmediate(var_1, 1);
  else
    self vehicle_setspeedimmediate(var_1, var_1);

  var_2 = getvehiclenode(var_0.target, "targetname");
  var_2 waittillmatch("trigger", self);
  self resumespeed(20);
}

generic_tank_dynamic_path_spawner_setup() {
  maps\_utility::array_spawn_function_noteworthy("generic_tank_dynamic_path_spawner", ::generic_spawn_node_based_enemy_tank);
  maps\_utility::array_spawn_function_noteworthy("generic_tank_dynamic_path_spawner", ::add_to_enemytanks_until_dead);
}

generic_spawn_node_based_enemy_tank() {
  var_0 = self.spawner common_scripts\utility::get_linked_vehicle_node();
  self.origin = var_0.origin;
  thread init_tank_enemy_loc(var_0.pos_info.nodes_start[0]);
}

move_ally_to_mesh(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_2))
    var_2 = "nostopping";

  var_3.exitnodename = var_1;
  var_4 = getvehiclenode(var_0, "targetname");
  var_5 = var_4 common_scripts\utility::get_linked_vehicle_node();
  switch_node(var_3, var_4, var_5);
  var_3 thread nav_mesh_pathing(var_5.pos_info.nodes_start[0], var_2);
}

tank_relative_speed(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("tank_dismount");

  if(isDefined(self)) {
    var_5 = self;
    var_5.relative_speed = 1;
  } else
    return 0;

  if(!isDefined(var_0) || var_0 == "")
    level.alliedtanktarget = level.playertank;
  else {
    var_6 = common_scripts\utility::getstruct(var_0, "targetname");
    level.alliedtanktarget = var_6;
  }

  if(isDefined(var_1) && var_1 != "")
    thread tank_relative_speed_stop(var_5, var_1);
  else
    var_1 = "nostopping";

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0;

  var_7 = level.playertank;
  var_8 = squared(2500 + var_2);
  var_9 = squared(2000);
  var_10 = squared(500);
  var_11 = squared(6000);
  var_12 = var_9 - var_10;
  var_13 = 0.05;
  var_14 = undefined;
  var_15 = undefined;

  while(!common_scripts\utility::flag(var_1)) {
    var_16 = 0;
    var_17 = 0;
    var_18 = "";
    var_19 = undefined;
    var_20 = undefined;
    var_21 = undefined;

    if(!isDefined(var_5)) {
      return;
    }
    if(var_5.classname == "script_vehicle_corpse") {
      return;
    }
    if(var_5.classname != "script_vehicle_corpse" && isDefined(var_5.currentnode) && isDefined(var_5.currentnode.target)) {
      if(isDefined(var_15) && self.currentnode.target != var_15.targetname)
        var_15 = getvehiclenode(var_5.currentnode.target, "targetname");
      else if(!isDefined(var_15))
        var_15 = getvehiclenode(var_5.currentnode.target, "targetname");
    }

    if(isDefined(var_15)) {
      if(isDefined(var_15.script_flag_wait) && !common_scripts\utility::flag(var_15.script_flag_wait)) {
        var_18 = var_15.script_flag_wait;
        var_17 = 1;
      }

      if(isDefined(var_15.speed) && var_15.speed <= 30)
        var_16 = 1;
    }

    var_20 = distance2dsquared(level.alliedtanktarget.origin, var_5.origin);
    var_21 = distance2dsquared(level.alliedtanktarget.origin, var_7.origin);
    var_22 = distance2d(level.alliedtanktarget.origin, var_5.origin);
    var_23 = distance2d(level.alliedtanktarget.origin, var_7.origin);
    var_24 = 0;

    if(var_20 < var_21) {
      var_25 = distance2dsquared(var_5.origin, var_7.origin);

      if(var_25 < var_20 - var_21 && var_25 > 9000000)
        var_24 = 0;
      else
        var_24 = 1;
    } else if(var_20 > var_21 + var_10 * 2)
      var_16 = 0;

    if(!isDefined(var_19))
      var_19 = distance2dsquared(var_7.origin, var_5.origin);
    else {
      var_26 = distance2dsquared(var_7.origin, var_5.origin);

      if(var_26 < var_19)
        var_19 = var_26;
    }

    var_27 = undefined;
    var_5 proxmity_check_stop_relative(var_17, var_16);

    if(var_17) {
      if(var_5.classname != "script_vehicle_corpse") {
        if(!isDefined(var_5.isobstructed))
          var_5 resumespeed(25 + var_3);

        var_5.flagtowait = var_18;
      }
    }

    if(isDefined(var_5.flagtowait)) {
      if(common_scripts\utility::flag(var_5.flagtowait))
        var_5.flagtowait = undefined;
    } else if(!isDefined(var_5.isobstructed)) {
      if(!var_16) {
        if(var_5.classname != "script_vehicle_corpse") {
          if(var_19 >= var_8 && var_24)
            var_27 = 0;
          else if(var_24) {
            var_28 = clamp(var_19, var_10, var_9);
            var_29 = 1 - (var_28 - var_10) / var_12;
            var_27 = 5 + (60 + var_4 - 5) * var_29;
          } else
            var_27 = 60 + var_4;

          if(isDefined(var_27)) {
            var_30 = undefined;

            if(isDefined(var_14))
              var_30 = abs(var_27 - var_14) / max(var_14, 0.001);

            if((!isDefined(var_14) || isDefined(var_30) && var_30 > 0.1 || var_27 == 0) && !isDefined(var_5.isobstructed)) {
              var_5 vehicle_setspeed(var_27, 25 + var_3, 25);
              var_14 = var_27;
            } else if(var_27 == 60 + var_4 && !isDefined(var_5.isobstructed)) {
              var_5 vehicle_setspeed(var_27, 25 + var_3, 25);
              var_14 = var_27;
            }
          }
        }
      } else if(var_5.classname != "script_vehicle_corpse" && !isDefined(var_5.isobstructed)) {
        if(var_19 >= var_8 && var_24) {
          if(var_19 < var_11) {
            var_27 = 0;
            var_5 vehicle_setspeed(var_27, 25 + var_3, 25);
            var_14 = var_27;
          } else
            var_5 resumespeed(25 + var_3);
        } else
          var_5 resumespeed(25 + var_3);
      }
    }

    wait(var_13);
  }

  if(isDefined(var_5)) {
    var_5 resumespeed(25);
    var_5.relative_speed = undefined;
  }
}

tank_relative_speed_stop(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0.classname == "script_vehicle_corpse") {
    return;
  }
  var_0 resumespeed(25);
}

proxmity_check_stop_loop(var_0, var_1, var_2) {
  self endon("death");
  level.player endon("tank_dismount");

  if(!isDefined(var_0) || var_0 == "")
    var_0 = "nostopping";

  if(!isDefined(var_1) || var_1 == "")
    var_3 = level.playertank;
  else
    var_3 = var_1;

  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_2))
    var_4 = 0.7;
  else
    var_4 = 0.98;

  var_5 = undefined;
  var_6 = undefined;

  while(!common_scripts\utility::flag(var_0)) {
    var_7 = 0;

    if(!isDefined(self)) {
      return;
    }
    if(self.classname == "script_vehicle_corpse") {
      return;
    }
    if(self.classname != "script_vehicle_corpse" && isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
      if(isDefined(var_5) && self.currentnode.target != var_5.targetname)
        var_5 = getvehiclenode(self.currentnode.target, "targetname");
      else if(!isDefined(var_5))
        var_5 = getvehiclenode(self.currentnode.target, "targetname");
    }

    if(isDefined(var_5)) {
      if(isDefined(var_5.script_flag_wait) && !common_scripts\utility::flag(var_5.script_flag_wait))
        var_6 = var_5.script_flag_wait;
    }

    var_8 = self vehicle_getvelocity();

    if(var_8 == (0, 0, 0))
      var_9 = anglesToForward(self.angles);
    else
      var_9 = vectornormalize(var_8);

    if(!isDefined(var_3)) {
      common_scripts\utility::waitframe();
      continue;
    } else
      var_10 = vectornormalize(var_3.origin - self.origin);

    var_11 = vectordot(var_9, var_10);
    var_12 = self vehicle_getspeed();

    if(var_11 >= var_4) {
      var_13 = common_scripts\utility::distance_2d_squared(var_3.origin, self.origin);

      if(var_13 <= 1000000) {
        self vehicle_setspeed(0, 12.5, 250);
        self.isobstructed = 1;
      } else if(var_13 <= 4000000) {
        self vehicle_setspeed(10, 12.5, 250);
        self.isobstructed = 1;
      } else if(var_12 < 5) {
        if(!isDefined(var_6))
          self resumespeed(10);
        else if(common_scripts\utility::flag(var_6)) {
          var_6 = undefined;
          self resumespeed(10);
        }

        self.isobstructed = undefined;
      } else
        self.isobstructed = undefined;
    } else if(var_12 < 5) {
      if(!isDefined(var_6)) {
        var_6 = undefined;
        self resumespeed(10);
      } else if(common_scripts\utility::flag(var_6)) {
        var_6 = undefined;
        self resumespeed(10);
      }

      self.isobstructed = undefined;
    } else
      self.isobstructed = undefined;

    wait 0.25;
  }
}

proxmity_check_stop_relative(var_0, var_1) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(self.classname == "script_vehicle_corpse") {
    return;
  }
  var_2 = self vehicle_getspeed();
  var_3 = self vehicle_getvelocity();

  if(var_2 < 1) {
    var_3 = self.angles;
    var_4 = anglesToForward(self.angles);
  } else
    var_4 = vectornormalize(var_3);

  var_5 = vectornormalize(level.playertank.origin - self.origin);
  var_6 = vectordot(var_4, var_5);
  var_2 = self vehicle_getspeed();

  if(var_6 >= 0.95) {
    var_7 = common_scripts\utility::distance_2d_squared(level.playertank.origin, self.origin);

    if(var_7 <= 4000000) {
      self vehicle_setspeed(0, 12.5, 250);
      self.isobstructed = 1;
      return;
    }

    if(var_7 <= 9000000) {
      self vehicle_setspeed(10, 12.5, 250);
      self.isobstructed = 1;
      return;
    }

    if(isDefined(self.isobstructed) && var_2 < 5) {
      if(!var_0) {
        if(var_1)
          self resumespeed(10);
      }

      self.isobstructed = undefined;
      return;
    }

    self.isobstructed = undefined;
    return;
    return;
    return;
  } else if(isDefined(self.isobstructed) && var_2 < 5) {
    if(!var_0) {
      if(var_1)
        self resumespeed(10);
    }

    self.isobstructed = undefined;
  } else
    self.isobstructed = undefined;
}

generic_gaz_dynamic_path_spawner_setup() {
  maps\_utility::array_spawn_function_noteworthy("generic_gaz_dynamic_path_spawner", ::gaz_spawn_setup);
  maps\_utility::array_spawn_function_noteworthy("generic_gaz_dynamic_path_spawner", ::generic_spawn_node_based_enemy_gaz);
}

generic_gaz_spawner_setup() {
  maps\_utility::array_spawn_function_noteworthy("generic_gaz_spawner", ::gaz_spawn_setup);
}

generic_spawn_node_based_enemy_gaz() {
  var_0 = self.spawner common_scripts\utility::get_linked_vehicle_node();
  self.origin = var_0.origin;
  wait 0.05;
  thread nav_mesh_pathing(var_0.pos_info.nodes_start[0]);
}

gaz_spawn_setup() {
  thread target_settings();
  thread gaz_kill();
  thread gaz_damage_watcher();
  thread add_to_enemygazs_until_dead();
  thread call_trigger_kill_gazs();

  if(isDefined(self.targetname) && issubstr(self.targetname, "complex"))
    self vehicle_setspeed(60, 25, 25);

  self.numwaits = 0;
}

gaz_relative_speed(var_0, var_1) {
  self endon("death");
  var_2 = self;

  if(!isDefined(var_0) || var_0 == "")
    level.alliedtanktarget = level.player;
  else {
    var_3 = common_scripts\utility::getstruct(var_0, "targetname");
    level.alliedtanktarget = var_3;
  }

  if(isDefined(var_1))
    thread gaz_relative_speed_stop(var_2, var_1);
  else
    var_1 = "nostopping";

  var_4 = level.playertank;
  var_5 = squared(6000);
  var_6 = squared(6000);
  var_7 = squared(1000);
  var_8 = squared(6000);
  var_9 = var_6 - var_7;
  var_10 = 0.25;
  var_11 = undefined;

  while(!common_scripts\utility::flag(var_1)) {
    var_12 = 0;
    var_13 = 0;
    var_14 = "";
    var_15 = undefined;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = undefined;

    if(!isDefined(var_2)) {
      break;
    }

    if(var_2.classname == "script_vehicle_corpse") {
      break;
    }

    if(var_2.classname != "script_vehicle_corpse" && isDefined(var_2.currentnode.target))
      var_15 = getvehiclenode(var_2.currentnode.target, "targetname");

    var_17 = distance2dsquared(level.alliedtanktarget.origin, var_2.origin);
    var_18 = distance2dsquared(level.alliedtanktarget.origin, var_4.origin);
    var_19 = 0;

    if(var_17 < var_18)
      var_19 = 1;

    if(!isDefined(var_16))
      var_16 = distance2dsquared(var_4.origin, var_2.origin);
    else {
      var_20 = distance2dsquared(var_4.origin, var_2.origin);

      if(var_20 < var_16)
        var_16 = var_20;
    }

    var_21 = undefined;

    if(var_2.classname != "script_vehicle_corpse") {
      if(var_16 >= var_5 && var_19) {
        if(var_16 < var_8)
          var_21 = 20;
      } else if(var_19) {
        var_22 = clamp(var_16, var_7, var_6);
        var_23 = 1 - (var_22 - var_7) / var_9;
        var_21 = 20 + 65 * var_23;
      } else
        var_21 = 85;

      if(isDefined(var_21)) {
        var_24 = undefined;

        if(isDefined(var_11))
          var_24 = abs(var_21 - var_11) / max(var_11, 0.001);

        if(!isDefined(var_11) || isDefined(var_24) && var_24 > 0.1) {
          var_2 vehicle_setspeed(var_21, 25, 25);
          var_11 = var_21;
        } else if(var_21 == 85) {
          var_2 vehicle_setspeed(var_21, 25, 25);
          var_11 = var_21;
        }
      }
    }

    wait(var_10);
  }

  if(isDefined(var_2) && var_2.classname != "script_vehicle_corpse")
    var_2 resumespeed(25);
}

gaz_relative_speed_stop(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);

  if(isDefined(var_0) && var_0.classname != "script_vehicle_corpse")
    var_0 resumespeed(25);
}

add_to_enemygazs_until_dead() {
  level.enemygazs = common_scripts\utility::array_add(level.enemygazs, self);
  self waittill("death");

  if(isDefined(self))
    level.enemygazs = common_scripts\utility::array_remove(level.enemygazs, self);
}

gaz_damage_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_4)) {
      var_4 = tolower(var_4);

      if(var_4 == "mod_projectile" || var_4 == "mod_projectile_splash") {
        if(var_0 > 150)
          self kill();
      }
    }
  }
}

gaz_kill() {
  self waittill("death");

  if(isDefined(self))
    thread common_scripts\utility::play_sound_in_space("satf_tank_death_player", self.origin);

  if(isDefined(self) && !isDefined(self.iscrushing)) {
    self setcontents(0);
    self.isexploding = 1;
    wait(randomfloatrange(0.25, 1.0));

    if(isDefined(self)) {
      playFX(level._effect["vehicle_explosion_t90_cheap"], self.origin);

      if(isDefined(self.script_team) && self.script_team == "allies")
        level thread maps\satfarm_audio::tank_death_allies(self.origin);
      else
        level thread maps\satfarm_audio::tank_death_player(self.origin);

      wait 0.05;

      if(isDefined(self))
        self delete();
    }
  }
}

gaz_crushable_setup() {
  var_0 = getEntArray("gaz_crush_trigger", "targetname");
  common_scripts\utility::array_thread(var_0, ::gaz_crush_trigger_wait);
}

gaz_crush_trigger_wait() {
  var_0 = getent(self.target, "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "gaz_crush_vehicle_clip") {
      continue;
    }
    var_2 = var_4;
  }

  self waittill("trigger");
  var_0 crush_mobile_gaz();
}

call_trigger_kill_gazs() {
  thread trigger_kill_gazs(level.playertank);
  thread trigger_kill_gazs(level.player);

  foreach(var_1 in level.allytanks) {
    if(isDefined(var_1))
      thread trigger_kill_gazs(var_1);
  }
}

trigger_kill_gazs(var_0) {
  self endon("Death");
  var_0 endon("Death");
  maps\_utility::waittill_entity_in_range(var_0, 420);
  common_scripts\utility::waitframe();

  if(isDefined(self) && isalive(self) && isDefined(var_0) && isalive(var_0)) {
    if(isDefined(self) && !isDefined(self.isexploding)) {
      self.iscrushing = 1;
      thread crush_mobile_gaz();
    }
  }
}

crush_mobile_gaz() {
  if(isDefined(self.riders)) {
    foreach(var_1 in self.riders) {
      if(isDefined(var_1) && isalive(var_1))
        var_1 kill();
    }
  }

  var_3 = getent("gaz_crush_clip", "targetname");
  var_4 = maps\_utility::spawn_anim_model("gaz_crush", self.origin);
  var_4.angles = self.angles;
  var_5 = spawn("script_model", self.origin);
  var_5 clonebrushmodeltoscriptmodel(var_3);
  var_5.angles = self.angles;

  if(isDefined(level.animgaz) && level.animgaz == self)
    level.animgaz = var_4;

  self delete();
  playFX(level._effect["gazexplode"], var_4.origin + (0, 0, 16), anglesToForward(var_4.angles), (180, 0, 0));
  playFX(level._effect["gazsmfire"], var_4.origin + (0, 0, 16), anglesToForward(var_4.angles), (180, 0, 0));
  level thread maps\satfarm_audio::gaz_crush(var_4.origin);
  playFX(common_scripts\utility::getfx("vfx_sparks_met_dbr"), var_4.origin + (0, 0, 16), (180, 0, 0), (180, 0, 0));
  radiusdamage(var_4.origin + (0, 0, 32), 500, 400, 400);
  var_5 movez(-16, 0.25);
  var_4 maps\_anim::anim_first_frame_solo(var_4, "frontfull");

  if(isDefined(level.animgaz) && level.animgaz == var_4)
    var_5 delete();
  else {
    var_4 thread crush_front_gaz();
    var_4 thread crush_rear_gaz();
  }
}

crush_front_gaz() {
  var_0 = spawn("trigger_radius", self gettagorigin("tag_engine_left"), 16, 16, 128);
  var_0 waittill("trigger", var_1);
  self setanim(%satfarm_bridge_gaz_crush_front_additive, 1);

  if(var_1 == level.playertank) {
    if(!common_scripts\utility::flag("aud_exfil"))
      self playSound("satf_debris_crush_plr");
    else
      self playSound("satf_debris_crush_plr_small");
  }

  playFX(common_scripts\utility::getfx("vfx_sparks_met_dbr"), self.origin + (0, 0, 16), (180, 0, 0), (180, 0, 0));
  wait 1;
  var_0 delete();
}

crush_rear_gaz() {
  var_0 = spawn("trigger_radius", self gettagorigin("tag_guy_turret"), 16, 16, 128);
  var_0 waittill("trigger", var_1);
  self setanim(%satfarm_bridge_gaz_crush_rear_additive, 1);

  if(var_1 == level.playertank) {
    if(!common_scripts\utility::flag("aud_exfil"))
      self playSound("satf_debris_crush_plr");
    else
      self playSound("satf_debris_crush_plr_small");
  }

  playFX(common_scripts\utility::getfx("vfx_sparks_met_dbr"), self.origin + (0, 0, 16), (180, 0, 0), (180, 0, 0));
  wait 1;
  var_0 delete();
}

setup_satfarm_chainlink_fence_triggers() {
  var_0 = getEntArray("satfarm_chainlink_fence_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread satfarm_chainlink_fence_trigger_animate();
    iprintlnbold("AUDIOTEST fence");
  }
}

satfarm_chainlink_fence_trigger_animate() {
  var_0 = getent(self.target, "targetname");
  var_0 setcontents(0);
  self waittill("trigger", var_1);
  var_2 = 64.0;
  var_3 = var_1 vehicle_getvelocity();
  var_4 = vectordot(var_3, anglesToForward(var_0.angles));

  if(var_4 != 0.0) {
    var_5 = var_2 / abs(var_4);

    if(var_4 > 0)
      var_0 rotatepitch(90, var_5);
    else
      var_0 rotatepitch(-90, var_5);
  }
}

spawn_player_checkpoint(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = undefined;

  level.allytanks = [];
  level.herotanks = [];
  level.othertanks = [];
  level.enemytanks = [];
  level.enemygazs = [];

  if(var_0 == "air_strip_secured" || var_0 == "tower" || var_0 == "post_missile_launch" || var_0 == "warehouse") {
    var_2 = common_scripts\utility::getstruct(var_0 + "_player", "targetname");
    level.player setorigin(var_2.origin);
    level.player setplayerangles(var_2.angles);
  } else {
    if(var_0 == "bridge_deploy" || var_0 == "ride_")
      level.playertank = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0 + "playertank");
    else
      level.playertank = maps\_vehicle::spawn_vehicle_from_targetname(var_0 + "playertank");

    if(var_0 == "bridge_") {
      level.player finish_zoom();
      level.player.tank = level.playertank;
      level.playertank.driver = level.player;
      level.playertank notify("nodeath_thread");
      level.playertank maps\_vehicle::godon();
      level.lock_on = 0;
      level.player.script_team = "allies";
      level.player thread init_chatter();

      if(isDefined(var_1))
        common_scripts\utility::flag_wait(var_1);

      level.playertank mount_tank(level.player, 1, 0.5, undefined, undefined, 8);
      return;
    }

    if(var_0 != "ride_") {
      level.player.tank = level.playertank;
      level.playertank.driver = level.player;
      level.playertank notify("nodeath_thread");
      level.playertank maps\_vehicle::godon();
      level.lock_on = 0;
      level.player.script_team = "allies";
      level.player thread init_chatter();
      thread init_tank(level.playertank, level.player, var_1);
    }
  }
}

spawn_heroes_checkpoint(var_0) {
  level.herotanks[0] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0 + "hero0");
  level.bobcat = level.herotanks[0];
  level.herotanks[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0 + "hero1");
  level.badger = level.herotanks[1];
  level.allytanks = common_scripts\utility::array_combine(level.allytanks, level.herotanks);
}

spawn_node_based_enemy_tanks_targetname(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 spawn_node_based_enemy_tank();
    var_2 = common_scripts\utility::add_to_array(var_2, var_5);
  }

  return var_2;
}

spawn_node_based_enemy_tank() {
  var_0 = self;
  var_1 = var_0 common_scripts\utility::get_linked_vehicle_node();
  var_2 = maps\_vehicle::vehicle_spawn(var_0);
  var_2.origin = var_1.origin;
  var_2 thread init_tank_enemy_loc(var_1.pos_info.nodes_start[0]);
  return var_2;
}

init_tank_enemy_loc(var_0) {
  self.exitnodename = "defend_exit_node";
  thread npc_tank_combat_init(1);
  thread nav_mesh_pathing(var_0);
}

waittilltanksdead(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(!isDefined(var_0))
    return 1;

  if(!isDefined(var_1) || var_1 == 0)
    var_1 = var_0.size;

  var_5 = spawnStruct();

  if(isDefined(var_2) && var_2 != 0) {
    var_5 endon("thread_timed_out");
    var_5 thread maps\_utility::waittill_dead_timeout(var_2);
  }

  if(!isDefined(var_3)) {
    while(var_0.size && var_1 > var_4) {
      foreach(var_7 in var_0) {
        if(isDefined(var_7) && var_7.classname == "script_vehicle_corpse") {
          var_0 = common_scripts\utility::array_remove(var_0, var_7);
          var_4++;
          continue;
        }

        if(!isDefined(var_7)) {
          var_0 = common_scripts\utility::array_remove(var_0, var_7);
          var_4++;
        }
      }

      wait 0.05;
    }
  } else {
    while(var_0.size && var_1 > var_4 && !common_scripts\utility::flag(var_3)) {
      foreach(var_7 in var_0) {
        if(isDefined(var_7) && var_7.classname == "script_vehicle_corpse") {
          var_0 = common_scripts\utility::array_remove(var_0, var_7);
          var_4++;
          continue;
        }

        if(!isDefined(var_7)) {
          var_0 = common_scripts\utility::array_remove(var_0, var_7);
          var_4++;
        }
      }

      wait 0.05;
    }
  }

  return 1;
}

waittillhelisdead(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    return 1;

  var_0 = maps\_utility::array_removedead(var_0);

  if(var_0.size > 0) {
    var_4 = spawnStruct();

    if(isDefined(var_2) && var_2 != 0) {
      var_4 endon("thread_timed_out");
      var_4 thread maps\_utility::waittill_dead_timeout(var_2);
    }

    var_4.count = var_0.size;

    if(isDefined(var_1) && var_1 < var_4.count)
      var_4.count = var_1;

    common_scripts\utility::array_thread(var_0, maps\_utility::waittill_dead_thread, var_4);

    if(isDefined(var_3)) {
      while(var_4.count > 0 && !common_scripts\utility::flag(var_3))
        wait 0.05;
    } else {
      while(var_4.count > 0)
        var_4 waittill("waittill_dead guy died");
    }
  }

  return 1;
}

radio_dialog_add_and_go(var_0, var_1, var_2) {
  maps\_utility::radio_add(var_0);

  if(isDefined(var_2) && var_2 == 1)
    maps\_utility::radio_dialogue_overlap(var_0);
  else
    maps\_utility::radio_dialogue(var_0, var_1);
}

char_dialog_add_and_go(var_0) {
  level.scr_sound[self.animname][var_0] = var_0;
  maps\_utility::dialogue_queue(var_0);
}

istank() {
  if(issubstr(self.classname, "t90"))
    return 1;

  if(issubstr(self.classname, "t72"))
    return 1;

  if(issubstr(self.classname, "m1a1"))
    return 1;

  if(issubstr(self.classname, "m1a2"))
    return 1;

  return 0;
}

clean_tank_array(var_0) {
  var_0 = common_scripts\utility::array_removeundefined(var_0);

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_vehicle_corpse")
      var_0 = common_scripts\utility::array_remove(var_0, var_2);
  }

  return var_0;
}

disable_arrivals_and_exits(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.disablearrivals = var_0;
  self.disableexits = var_0;
}

switch_node_on_flag(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isDefined(var_1) && var_1 != "")
    common_scripts\utility::flag_wait(var_1);

  var_4 = getvehiclenode(var_2, "targetname");
  var_5 = getvehiclenode(var_3, "targetname");

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_5)) {
    return;
  }
  common_scripts\utility::flag_wait(var_4.script_flag_set);
  var_0.attachedpath = undefined;
  var_0 notify("newpath");
  var_0 thread maps\_vehicle::vehicle_paths(var_5);
  var_0 startpath(var_5);
  var_0 vehicle_setspeed(45, 30, 30);
  var_0 resumespeed(30);
}

switch_node(var_0, var_1, var_2) {
  var_0 endon("death");

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  common_scripts\utility::flag_wait(var_1.script_flag_set);
  var_0.attachedpath = undefined;
  var_0 notify("newpath");
  var_0 thread maps\_vehicle::vehicle_paths(var_2);
  var_0 startpath(var_2);
  var_0 vehicle_setspeed(45, 30, 30);
  var_0 resumespeed(30);
}

switch_node_now(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_1)) {
    return;
  }
  var_0.attachedpath = undefined;
  var_0 notify("newpath");
  var_0 thread maps\_vehicle::vehicle_paths(var_1);
  var_0 startpath(var_1);
}

switch_node_now_heli(var_0, var_1) {
  var_0 endon("death");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 maps\_utility::vehicle_detachfrompath();
  var_0.currentnode = var_1;
  var_0 maps\_utility::vehicle_resumepath();
}

toggle_thermal() {
  level.player endon("tank_dismount");
  level.player endon("thermal_off");
  level.player endon("missile_tank_dismount");
  level.player notifyonplayercommand("thermal", "+usereload");
  level.player notifyonplayercommand("thermal", "+activate");

  while(!common_scripts\utility::flag("thermal_out")) {
    level.player waittill("thermal");
    uav_thermal_on();
    level thread maps\satfarm_audio::thermal();
    thread thermal_hint();
    wait 1;
    level.player waittill("thermal");
    uav_thermal_off();
    wait 1;
  }
}

thermal_hint() {
  level.player endon("thermal_off");
  level.playertank endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  wait 5;
  level.player maps\_utility::display_hint_timeout("HINT_TOGGLE_THERMAL", 8.0);
}

toggle_thermal_npc() {
  level.player endon("tank_dismount");
  self endon("Death");
  level.player notifyonplayercommand("thermal", "+usereload");

  if(isDefined(level.player.is_in_thermal_vision) && level.player.is_in_thermal_vision) {
    self thermaldrawenable();

    if(isDefined(self.script_team) && self.script_team == "allies")
      thread ally_strobe();
  }

  while(isDefined(self) && self.classname != "script_vehicle_corpse") {
    level.player waittill("thermal");
    wait 0.05;

    if(isDefined(level.player.is_in_thermal_vision) && level.player.is_in_thermal_vision) {
      if(isDefined(self) && self.classname != "script_vehicle_corpse") {
        self thermaldrawenable();

        if(isDefined(self.script_team) && self.script_team == "allies")
          thread ally_strobe();
      }

      continue;
    }

    if(isDefined(self) && self.classname != "script_vehicle_corpse")
      self thermaldrawdisable();

    level notify("thermal_fx_off");
  }

  if(isDefined(self))
    self thermaldrawdisable();
}

ally_strobe() {
  level endon("thermal_fx_off");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");
  level.player endon("remove_player_missile_control");
  self endon("death");

  if(!isDefined(self.reflector_tag)) {
    self.reflector_tag = common_scripts\utility::spawn_tag_origin();
    self.reflector_tag linkto(self, "tag_origin", (0, 0, 150), (0, 0, 0));
  }

  while(isDefined(self) && isDefined(self.reflector_tag) && self.model != "vehicle_t90ms_tank_d_noturret_iw6") {
    playFXOnTag(level.friendly_thermal_reflector_effect, self.reflector_tag, "tag_origin");
    wait 0.2;
  }
}

uav_thermal_on(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "ac130_inverted";

  setthermalbodymaterial("thermalbody_snowlevel");

  if(isDefined(var_0))
    self visionsetthermalforplayer(var_1, var_0);
  else
    self visionsetthermalforplayer(var_1, 0.25);

  maps\_load::thermal_effectson();
  self thermalvisionon();
  common_scripts\utility::flag_set("PLAYER_TURNED_ON_THERMAL_ONCE");
  common_scripts\utility::flag_set("THERMAL_ON");
}

uav_thermal_off() {
  maps\_load::thermal_effectsoff();
  self thermalvisionoff();
  common_scripts\utility::flag_clear("THERMAL_ON");
}

tank_thermal_effects(var_0, var_1) {
  level endon("thermal_fx_off" + var_0);
  self endon("death");

  for(;;) {
    if(isDefined(var_1))
      playfxontagforclients(level.friendly_thermal_reflector_effect, self, "tag_turret", var_1);
    else
      playFXOnTag(level.friendly_thermal_reflector_effect, self, "tag_turret");

    wait 0.2;
  }
}

enemytank_cleanup() {
  self endon("death");

  while(!isDefined(level.cinematic_started))
    wait 0.05;

  if(isDefined(self) && isalive(self))
    self delete();
}

flag_wait_god_mode_off(var_0) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(self) && isalive(self))
    maps\_vehicle::godoff();
}

crawling_guys_spawnfunc() {
  thread detectkill();
  maps\_utility::gun_remove();
  self.health = 1;
  self.ignoreexplosionevents = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.ignorerandombulletdamage = 1;
  self.grenadeawareness = 0;
  self.no_pain_sound = 1;
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self.health = 2;
  var_0 = randomintrange(4, 10);
  var_1 = common_scripts\utility::ter_op(randomint(2), level.scr_anim["crawl_death_1"], level.scr_anim["crawl_death_2"]);
  maps\_utility::force_crawling_death(self.spawner.angles[1], var_0, var_1, 1);
  self dodamage(1, self.origin, level.player);
}

limping_guys_spawnfunc() {
  self endon("death");
  thread detectkill();
  self.ignoreexplosionevents = 1;
  self.ignoreall = 1;
  self.ignorerandombulletdamage = 1;
  self.grenadeawareness = 0;
  self.health = 1;
  self.animname = "wounded_ai";
  disable_arrivals_and_exits(1);

  if(common_scripts\utility::cointoss()) {
    maps\_utility::set_run_anim("wounded_limp_jog", 1);
    self.moveplaybackrate = randomfloatrange(0.8, 1.0);
  } else {
    maps\_utility::set_run_anim("wounded_limp_run", 1);
    self.moveplaybackrate = randomfloatrange(0.8, 1.0);
  }

  self waittill("goal");

  if(isDefined(self) && isalive(self))
    self kill();
}

delayed_show(var_0) {
  wait(var_0);
  self show();
}

delayed_kill(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    common_scripts\utility::flag_wait(var_1);

  wait(var_0);

  if(isDefined(self)) {
    if(istank())
      thread handle_tank_death();
    else
      self kill();
  }
}

random_wait_and_kill(var_0, var_1) {
  self endon("death");
  wait(randomfloatrange(var_0, var_1));

  if(isDefined(self))
    thread handle_tank_death();
}

flag_wait_delete(var_0) {
  common_scripts\utility::flag_wait(var_0);

  if(isDefined(self))
    self delete();
}

delete_all_vehicles() {
  var_0 = vehicle_getarray();

  foreach(var_2 in var_0)
  var_2 delete();
}

mortar_fire_on_struct(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.angles = (-90, 0, 0);
  thread common_scripts\utility::play_sound_in_space("satf_mortar_incoming", var_2.origin);
  wait(randomfloatrange(0.25, 0.45));
  playFXOnTag(common_scripts\utility::getfx("mortar"), var_2, "tag_origin");

  if(isDefined(var_1))
    radiusdamage(var_2.origin, 170, 500, 250);

  earthquake(0.2, 0.5, level.player.origin, 512);
  thread common_scripts\utility::play_sound_in_space("satf_mortar_explosion_dirt", var_2.origin);
  wait(randomfloatrange(0.25, 0.45));
  var_2 delete();
}

get_a10_player_start() {
  var_0 = common_scripts\utility::getstruct("a10_player_start", "targetname");
  return var_0;
}

init_sabot_for_player(var_0, var_1, var_2) {
  if(isDefined(level.missile))
    level.missile delete();

  level.missile = common_scripts\utility::spawn_tag_origin();
  level.missile.origin = var_0;
  level.missile.angles = var_1;
  level.missile.speed = 175;
  level.missile.acceleration = 200;
  level.missile.deceleration = 10;
  level.missile.launch_speed = 200;
  level.missile.launch_delay = 0.0;
  level.missile.pitch_max = 180;
  level.missile.pitch_speed_max = 25;
  level.missile.yaw_speed_max = 55;
  level.missile.mph_to_ips = 17.6;
  level.missile.fov = 100;
  level.missile.acceleration_fov = 75;
  level.missile.weap = "sabot_guided";
  level.missile.weap_detonate = "sabot_guided_detonate";
  level.missile.lifetime = 5;
  level.missile.tank = var_2;
}

init_bunker_buster_missile_for_player(var_0, var_1) {
  if(isDefined(level.missile))
    level.missile delete();

  level.missile = common_scripts\utility::spawn_tag_origin();
  level.missile.origin = var_0;
  level.missile.angles = var_1;
  level.missile.speed = 250;
  level.missile.acceleration = 250;
  level.missile.launch_speed = 250;
  level.missile.launch_delay = 0.0;
  level.missile.pitch_max = 180;
  level.missile.pitch_speed_max = 15;
  level.missile.yaw_speed_max = 15;
  level.missile.mph_to_ips = 17.6;
  level.missile.fov = 100;
  level.missile.weap = undefined;
  level.missile.weap_detonate = undefined;
  level.missile.lifetime = undefined;
  level.missile.tank = undefined;
}

give_player_missile_control() {
  self notify("give_player_missile_control");
  self endon("give_player_missile_control");
  self endon("remove_player_missile_control");
  common_scripts\utility::flag_set("PLAYER_GUIDING_ROUND");

  if(level.player usinggamepad())
    level.player thread maps\_utility::display_hint_timeout("HINT_GUIDED_ROUND_GUIDING", 8.0);
  else {
    var_0 = 1;
    var_1 = 0;
    var_2 = getkeybinding("+speed_throw");

    if(!isDefined(var_2) || var_2["count"] == 0) {
      var_0 = 0;
      var_2 = getkeybinding("+toggleads_throw");

      if(isDefined(var_2) && var_2["count"] > 0)
        var_1 = 1;
    }

    if(var_0)
      level.player thread maps\_utility::display_hint_timeout("HINT_GUIDED_ROUND_GUIDING", 8.0);
    else
      level.player thread maps\_utility::display_hint_timeout("HINT_GUIDED_ROUND_GUIDING_TOGGLEADS_THROW", 8.0);
  }

  self.prev_angles = self getplayerangles();
  self.was_in_thermal = self.is_in_thermal_vision;

  if(isDefined(level.missile.tank))
    level.missile.tank dismount_tank(self, 0, 0, 1);

  self setstance("stand");
  self allowprone(0);
  self allowcrouch(0);
  self allowstand(1);
  self allowads(0);
  self hideviewmodel();
  self disableweaponswitch();
  self disableoffhandweapons();
  self enableinvulnerability();
  setsaveddvar("cg_fov", level.missile.fov);
  setsaveddvar("ammoCounterHide", "1");
  setsaveddvar("actionSlotsHide", "1");
  setsaveddvar("hud_showStance", "0");
  self disableweapons();
  self setorigin(level.missile.origin);
  self setplayerangles(level.missile.angles);
  self playerlinktodelta(level.missile, "tag_origin", 1, 0, 0, 0, 0, 1);
  self playerlinkedoffsetenable();
  level.missile.missile_hud_item["static"] = newhudelem();
  level.missile.missile_hud_item["static"].hidewheninmenu = 1;
  level.missile.missile_hud_item["static"].hidewhendead = 1;
  level.missile.missile_hud_item["static"] setshader("overlay_static", 640, 480);
  level.missile.missile_hud_item["static"].alignx = "left";
  level.missile.missile_hud_item["static"].aligny = "top";
  level.missile.missile_hud_item["static"].horzalign = "fullscreen";
  level.missile.missile_hud_item["static"].vertalign = "fullscreen";
  level.missile.missile_hud_item["static"].alpha = 0.25;
  level.missile.missile_hud_item["overlay"] = newhudelem();
  level.missile.missile_hud_item["overlay"].hidewheninmenu = 1;
  level.missile.missile_hud_item["overlay"].hidewhendead = 1;
  level.missile.missile_hud_item["overlay"] setshader("ugv_screen_overlay", 640, 480);
  level.missile.missile_hud_item["overlay"].alignx = "left";
  level.missile.missile_hud_item["overlay"].aligny = "top";
  level.missile.missile_hud_item["overlay"].horzalign = "fullscreen";
  level.missile.missile_hud_item["overlay"].vertalign = "fullscreen";
  level.missile.missile_hud_item["overlay"].alpha = 0.75;
  level.missile.missile_hud_item["vignette"] = newhudelem();
  level.missile.missile_hud_item["vignette"].hidewheninmenu = 1;
  level.missile.missile_hud_item["vignette"].hidewhendead = 1;
  level.missile.missile_hud_item["vignette"] setshader("ugv_vignette_overlay", 640, 480);
  level.missile.missile_hud_item["vignette"].alignx = "left";
  level.missile.missile_hud_item["vignette"].aligny = "top";
  level.missile.missile_hud_item["vignette"].horzalign = "fullscreen";
  level.missile.missile_hud_item["vignette"].vertalign = "fullscreen";
  level.missile.missile_hud_item["vignette"].alpha = 0.5;
  level.missile.missile_hud_item["scanline"] = newhudelem();
  level.missile.missile_hud_item["scanline"].hidewheninmenu = 1;
  level.missile.missile_hud_item["scanline"].hidewhendead = 1;
  level.missile.missile_hud_item["scanline"] setshader("m1a1_tank_sabot_scanline", 1000, 75);
  level.missile.missile_hud_item["scanline"].alignx = "center";
  level.missile.missile_hud_item["scanline"].aligny = "middle";
  level.missile.missile_hud_item["scanline"].horzalign = "center";
  level.missile.missile_hud_item["scanline"].vertalign = "middle";
  level.missile.missile_hud_item["scanline"].alpha = 0.75;
  level.missile.missile_hud_item["scanline"] thread missile_update_scanline();
  level.missile.missile_hud_item["sabot_reticle"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center", 25, 25);
  level.missile.missile_hud_item["sabot_reticle"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_reticle_cyan"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center_cyan", 25, 25);
  level.missile.missile_hud_item["sabot_reticle_cyan"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_cyan"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_cyan"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_cyan"].alpha = 0.0;
  level.missile.missile_hud_item["sabot_reticle_red"] = maps\_hud_util::createicon("m1a1_tank_sabot_reticle_center_red", 25, 25);
  level.missile.missile_hud_item["sabot_reticle_red"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_red"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_red"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_red"].alpha = 0.0;
  level.missile.missile_hud_item["sabot_reticle_upper_left"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_top_left", 20, 20);
  level.missile.missile_hud_item["sabot_reticle_upper_left"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_upper_left"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_upper_left"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_upper_left"].x = level.missile.missile_hud_item["sabot_reticle"].width * -2.5;
  level.missile.missile_hud_item["sabot_reticle_upper_left"].y = level.missile.missile_hud_item["sabot_reticle"].height * -1;
  level.missile.missile_hud_item["sabot_reticle_upper_left"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_reticle_upper_right"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_top_right", 20, 20);
  level.missile.missile_hud_item["sabot_reticle_upper_right"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_upper_right"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_upper_right"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_upper_right"].x = level.missile.missile_hud_item["sabot_reticle"].width * 2.5;
  level.missile.missile_hud_item["sabot_reticle_upper_right"].y = level.missile.missile_hud_item["sabot_reticle"].height * -1;
  level.missile.missile_hud_item["sabot_reticle_upper_right"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_reticle_bottom_left"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_bottom_left", 20, 20);
  level.missile.missile_hud_item["sabot_reticle_bottom_left"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_bottom_left"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_bottom_left"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_bottom_left"].x = level.missile.missile_hud_item["sabot_reticle"].width * -2.5;
  level.missile.missile_hud_item["sabot_reticle_bottom_left"].y = level.missile.missile_hud_item["sabot_reticle"].height * 1;
  level.missile.missile_hud_item["sabot_reticle_bottom_left"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_reticle_bottom_right"] = maps\_hud_util::createicon("m1a1_tank_missile_reticle_inner_bottom_right", 20, 20);
  level.missile.missile_hud_item["sabot_reticle_bottom_right"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_reticle_bottom_right"].alignx = "center";
  level.missile.missile_hud_item["sabot_reticle_bottom_right"].aligny = "middle";
  level.missile.missile_hud_item["sabot_reticle_bottom_right"].x = level.missile.missile_hud_item["sabot_reticle"].width * 2.5;
  level.missile.missile_hud_item["sabot_reticle_bottom_right"].y = level.missile.missile_hud_item["sabot_reticle"].height * 1;
  level.missile.missile_hud_item["sabot_reticle_bottom_right"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_fuel_range_bracket"] = maps\_hud_util::createicon("m1a1_tank_sabot_fuel_range_horizontal", int(level.missile.missile_hud_item["sabot_reticle"].width * 4), int(level.missile.missile_hud_item["sabot_reticle"].width * 4 * 0.25));
  level.missile.missile_hud_item["sabot_fuel_range_bracket"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_fuel_range_bracket"].alignx = "center";
  level.missile.missile_hud_item["sabot_fuel_range_bracket"].aligny = "bottom";
  level.missile.missile_hud_item["sabot_fuel_range_bracket"].y = level.missile.missile_hud_item["sabot_reticle"].height * -3;
  level.missile.missile_hud_item["sabot_fuel_range_bracket"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_fuel_range_bar"] = maps\_hud_util::createicon("red_block", int(level.missile.missile_hud_item["sabot_fuel_range_bracket"].width * 0.625), int(level.missile.missile_hud_item["sabot_fuel_range_bracket"].height * 0.32));
  level.missile.missile_hud_item["sabot_fuel_range_bar"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_fuel_range_bar"].alignx = "left";
  level.missile.missile_hud_item["sabot_fuel_range_bar"].aligny = "middle";
  level.missile.missile_hud_item["sabot_fuel_range_bar"].x = level.missile.missile_hud_item["sabot_fuel_range_bar"].width * -0.5 - 1;
  level.missile.missile_hud_item["sabot_fuel_range_bar"].y = level.missile.missile_hud_item["sabot_fuel_range_bracket"].y - level.missile.missile_hud_item["sabot_fuel_range_bracket"].height * 0.38;
  level.missile.missile_hud_item["sabot_fuel_range_bar"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_fuel_range_bar"].start_width = level.missile.missile_hud_item["sabot_fuel_range_bar"].width;
  level.missile.missile_hud_item["sabot_fuel_range_text"] = maps\_hud_util::createclientfontstring("small", 1.0);
  level.missile.missile_hud_item["sabot_fuel_range_text"] set_default_hud_parameters();
  level.missile.missile_hud_item["sabot_fuel_range_text"].alignx = "center";
  level.missile.missile_hud_item["sabot_fuel_range_text"].aligny = "bottom";
  level.missile.missile_hud_item["sabot_fuel_range_text"].alpha = 0.666;
  level.missile.missile_hud_item["sabot_fuel_range_text"].x = 0;
  level.missile.missile_hud_item["sabot_fuel_range_text"].y = level.missile.missile_hud_item["sabot_fuel_range_bracket"].y - level.missile.missile_hud_item["sabot_fuel_range_bracket"].height * 0.666;
  level.missile.missile_hud_item["sabot_fuel_range_text"] settext(&"SATFARM_FUEL_RANGE");
  level.missile.missile_hud_item["speed"] = maps\_hud_util::createclientfontstring("small", 1.0);
  level.missile.missile_hud_item["speed"] set_default_hud_parameters();
  level.missile.missile_hud_item["speed"].alignx = "center";
  level.missile.missile_hud_item["speed"].aligny = "top";
  level.missile.missile_hud_item["speed"].alpha = 0.666;
  level.missile.missile_hud_item["speed"].x = 0;
  level.missile.missile_hud_item["speed"].y = level.missile.missile_hud_item["sabot_fuel_range_bracket"].y + level.missile.missile_hud_item["sabot_fuel_range_bracket"].height * 0.666;
  visionsetnaked("satfarm_sabot_view", 0);
  visionsetthermal("satfarm_sabot_view", 0);
  level.missile thread player_missile_control(self);

  if(isDefined(self.was_in_thermal) && self.was_in_thermal)
    self notify("thermal");
}

missile_update_scanline() {
  level.player endon("remove_player_missile_control");

  while(isDefined(self)) {
    self.y = -400;
    self moveovertime(2);
    self.y = 400;
    wait 2;
  }
}

remove_target_on_death() {
  self waittill("death");

  if(isDefined(self) && target_istarget(self))
    target_remove(self);
}

remove_player_missile_control() {
  self waittill("remove_player_missile_control");
  common_scripts\utility::flag_set("tow_cam_sound_off");
  remove_player_missile_control_internal();
}

remove_player_missile_control_internal() {
  common_scripts\utility::flag_clear("PLAYER_GUIDING_ROUND");
  self unlink();
  self showviewmodel();
  self setstance("stand");
  self allowprone(1);
  self allowcrouch(1);
  self allowstand(1);
  self allowads(1);
  self thermalvisionoff();
  maps\_load::thermal_effectsoff();
  stopallrumbles();

  if(isDefined(level.missile)) {
    var_0 = getarraykeys(level.missile.missile_hud_item);

    foreach(var_2 in var_0) {
      level.missile.missile_hud_item[var_2] destroy();
      level.missile.missile_hud_item[var_2] = undefined;
    }

    if(isDefined(level.missile.tank)) {
      self setplayerangles(self.prev_angles);
      self enableslowaim(0, 0);
      level.missile.tank mount_tank(self, 1, 0.25, 1, 1);
      self enableslowaim(0, 0);
    }

    visionsetnaked(level.default_level_vision_set, 0);
    level.missile delete();
    level.missile = undefined;
    wait 0.25;
    self enableslowaim(0.5, 0.25);
  } else {
    self disableinvulnerability();
    setsaveddvar("ammoCounterHide", "0");
    setsaveddvar("actionSlotsHide", "0");
    setsaveddvar("hud_showStance", "1");
    setsaveddvar("cg_fov", 65);
    visionsetnaked(level.default_level_vision_set, 0);
  }

  level.player notify("reenable_triggers");
}

missile_timeout(var_0) {
  var_0 endon("give_player_missile_control");
  var_0 endon("remove_player_missile_control");

  if(isDefined(level.missile.tank)) {
    var_0 notifyonplayercommand("early_det", "+attack");
    var_0 notifyonplayercommand("early_det", "+attack_akimbo_accessible");
  }

  common_scripts\utility::waittill_any_timeout(self.lifetime, "early_det");

  if(isDefined(self)) {
    var_0 notify("missile_timeout");
    var_0 missile_explode(1);
  }
}

missile_remove_blur(var_0, var_1) {
  wait(var_0);
  setblur(0, var_1);
}

player_missile_control(var_0) {
  var_0 endon("give_player_missile_control");
  var_0 endon("remove_player_missile_control");
  var_1 = 0;

  if(isDefined(self.max_distance))
    var_1 = self.max_distance;

  thread missile_trigger_explode(var_0);
  var_0 thread missile_handle_thermal();
  var_0 thread missile_handle_boost_fov_lerps(self.acceleration_fov, self.acceleration_fov * 1.5);
  var_2 = self.launch_speed;
  var_3 = self.lifetime;
  var_4 = self.launch_delay;
  var_5 = !isDefined(self.acceleration_fov);
  var_0 enablemousesteer(1);

  while(isDefined(self)) {
    player_missile_yaw_control(var_0);
    player_missile_pitch_control(var_0);
    self.angles = (self.angles[0], self.angles[1], self.angles[2] * 0.9);

    if(var_4 <= 0) {
      if(!var_5) {
        setblur(10, 0);
        var_0 lerpfov(self.acceleration_fov, 0.25);
        var_5 = 1;
        thread missile_remove_blur(0.05, 0.25);
        earthquake(1, 0.25, self.origin, 500);
        self screenshakeonentity(randomfloatrange(0.25, 0.35), randomfloatrange(0.25, 0.35), randomfloatrange(0.25, 0.35), self.lifetime, 0, 0, 100, randomfloatrange(15, 20), randomfloatrange(15, 20), randomfloatrange(15, 20));
        var_0 playrumblelooponentity("tank_missile");
      }

      if(!var_0 adsButtonPressed(1) && var_2 > self.speed) {
        var_2 = var_2 - self.acceleration * 0.05;
        var_2 = max(var_2, self.speed);
      } else {
        var_2 = var_2 + self.acceleration * 0.05 * common_scripts\utility::ter_op(var_0 adsButtonPressed(1), 2, 1);
        var_2 = min(var_2, self.speed * common_scripts\utility::ter_op(var_0 adsButtonPressed(1), 1.5, 1));
      }
    } else {
      var_2 = var_2 - self.deceleration * 0.05;
      var_4 = var_4 - 0.05;
    }

    level.missile.missile_hud_item["speed"] settext(var_2 * 1.5 + " MPH");
    var_6 = self.origin + anglesToForward(self.angles) * var_2 * self.mph_to_ips * 0.05;

    if(var_4 <= 0 && isDefined(self.lifetime)) {
      var_3 = var_3 - 0.05 * var_2 / self.speed;

      if(int(level.missile.missile_hud_item["sabot_fuel_range_bar"].start_width * var_3 / self.lifetime) < 1)
        level.missile.missile_hud_item["sabot_fuel_range_bar"].alpha = 0;
      else
        level.missile.missile_hud_item["sabot_fuel_range_bar"] setshader("red_block", int(level.missile.missile_hud_item["sabot_fuel_range_bar"].start_width * var_3 / self.lifetime), level.missile.missile_hud_item["sabot_fuel_range_bar"].height);
    }

    if(common_scripts\utility::flag("missile_out_of_bounds") || var_3 < 0) {
      common_scripts\utility::flag_clear("missile_out_of_bounds");
      var_0 missile_explode(1);
      return;
    }

    self.origin_diff = var_6 - self.origin;
    var_7 = bulletTrace(var_0 getEye() + (0, 0, 10), var_0 getEye() + (0, 0, 10) + self.origin_diff, 0, self);
    var_8 = bulletTrace(var_0 getEye() - (0, 0, 10), var_0 getEye() - (0, 0, 10) + self.origin_diff, 0, self);
    var_9 = bulletTrace(var_0 getEye() + anglestoright(var_0 getplayerangles()) * 10, var_0 getEye() + anglestoright(var_0 getplayerangles()) * 10 + self.origin_diff, 0, self);
    var_10 = bulletTrace(var_0 getEye() - anglestoright(var_0 getplayerangles()) * 10, var_0 getEye() - anglestoright(var_0 getplayerangles()) * 10 + self.origin_diff, 0, self);

    if(var_7["fraction"] < 1 || var_8["fraction"] < 1 || var_9["fraction"] < 1 || var_10["fraction"] < 1) {
      var_0 missile_explode();
      return;
    }

    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = sortbydistance(maps\_utility::getvehiclearray(), var_0 getEye());

    foreach(var_16 in var_14) {
      if(!isDefined(var_16.dead) || !var_16.dead) {
        if(!target_istarget(var_16)) {
          if(var_13 < 5) {
            target_set(var_16, common_scripts\utility::ter_op(var_16 maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72)));
            target_hidefromplayer(var_16, var_0);
            var_13++;
          }

          continue;
        }

        if(target_isinrect(var_16, var_0, getdvarfloat("cg_fov"), 20, 20) && (var_16.script_team == "allies" || sighttracepassed(var_0 getEye(), var_16.origin + (0, 0, 60), 0, self))) {
          if(var_16.script_team == "axis")
            var_11 = 1;
          else if(var_16.script_team == "allies")
            var_12 = 1;

          break;
        }
      }
    }

    if(var_11 && level.missile.missile_hud_item["sabot_reticle_red"].alpha == 0) {
      level.missile.missile_hud_item["sabot_reticle_red"].alpha = 0.666;
      level.missile.missile_hud_item["sabot_reticle_cyan"].alpha = 0;
      level.missile.missile_hud_item["sabot_reticle"].alpha = 0;
    } else if(var_12 && level.missile.missile_hud_item["sabot_reticle_cyan"].alpha == 0) {
      level.missile.missile_hud_item["sabot_reticle_cyan"].alpha = 0.666;
      level.missile.missile_hud_item["sabot_reticle_red"].alpha = 0;
      level.missile.missile_hud_item["sabot_reticle"].alpha = 0;
    } else if(!var_11 && !var_12 && level.missile.missile_hud_item["sabot_reticle"].alpha == 0) {
      level.missile.missile_hud_item["sabot_reticle"].alpha = 0.666;
      level.missile.missile_hud_item["sabot_reticle_cyan"].alpha = 0;
      level.missile.missile_hud_item["sabot_reticle_red"].alpha = 0;
    }

    self moveto(var_6, 0.05, 0, 0);

    foreach(var_16 in target_getarray()) {
      if(var_16.script_team == "axis" && distancesquared(var_6, var_16.origin) < common_scripts\utility::ter_op(var_16 maps\_vehicle::ishelicopter(), 250000, 40000) && vectordot(var_16.origin - var_6, anglesToForward(self.angles)) <= 0.0) {
        var_0 missile_explode();
        return;
      }
    }

    wait 0.05;
  }
}

missile_handle_thermal() {
  self endon("give_player_missile_control");
  self endon("remove_player_missile_control");

  for(;;) {
    self waittill("thermal");

    if(!isDefined(self.is_in_thermal_vision) || !self.is_in_thermal_vision) {
      self thermalvisionon();
      maps\_load::thermal_effectson();
      continue;
    }

    self thermalvisionoff();
    maps\_load::thermal_effectsoff();
  }
}

missile_handle_boost_fov_lerps(var_0, var_1) {
  self endon("give_player_missile_control");
  self endon("remove_player_missile_control");
  wait 0.25;
  var_2 = 0;

  for(;;) {
    if(self adsButtonPressed(1) && !var_2) {
      self lerpfov(var_1, 0.1);
      var_2 = 1;
    } else if(!self adsButtonPressed(1) && var_2) {
      self lerpfov(var_0, 0.1);
      var_2 = 0;
    }

    wait 0.1;
  }
}

missile_trigger_explode(var_0) {
  var_0 endon("give_player_missile_control");
  var_0 endon("remove_player_missile_control");

  if(isDefined(level.missile.tank)) {
    var_0 notifyonplayercommand("early_det", "+attack");
    var_0 notifyonplayercommand("early_det", "+attack_akimbo_accessible");
    var_0 notifyonplayercommand("early_det", "weapnext");
    var_0 notifyonplayercommand("early_det", "+stance");
  }

  wait 0.5;
  var_0 waittill("early_det");

  if(isDefined(self)) {
    var_0 notify("missile_timeout");
    var_0 missile_explode(1);
  }
}

player_missile_roll_control(var_0) {
  var_1 = 0;
  var_2 = 0;
  self.old_angles = self.angles;
  var_3 = var_0 getnormalizedcameramovement()[1];

  if(var_3 > 0 && var_3 < 0.25)
    var_3 = 0;
  else if(var_3 < 0 && var_3 > -0.25)
    var_3 = 0;

  var_4 = self.angles[2];

  if(var_4 > 180)
    var_4 = var_4 - 360;

  if(var_3 == 0) {
    if(var_4 > 0)
      var_1 = var_1 - 0.25 * self.roll_speed_max * 0.05;
    else
      var_1 = var_1 + 0.25 * self.roll_speed_max * 0.05;

    var_1 = clamp(var_1, (0 - self.roll_speed_max / 4) * 0.05, self.roll_speed_max / 4 * 0.05);
    var_1 = var_1 * min(1.0, squared(abs(var_4) / (self.roll_max / 2)));

    if(abs(var_1) > abs(var_4))
      var_1 = 0 - var_4;

    self.roll_current = self.roll_current - self.roll_current * 0.05;
    var_2 = var_2 * 0.75;
  } else {
    var_1 = var_1 + var_3 * (self.roll_speed_max * 4) * 0.05;
    var_1 = clamp(var_1, (0 - self.roll_speed_max) * abs(var_3) * 0.05, self.roll_speed_max * abs(var_3) * 0.05);
    var_2 = var_2 + var_3 * (self.yaw_speed_max / 10) * 0.05;
    var_2 = clamp(var_2, (0 - self.yaw_speed_max) * abs(var_3) * 0.05, self.yaw_speed_max * abs(var_3) * 0.05);

    if(abs(var_4) / self.roll_max > 0.5) {
      if(var_4 < 0 && var_1 < 0 || var_4 > 0 && var_1 > 0) {
        var_5 = squared((self.roll_max - abs(var_4)) / (self.roll_max - self.roll_max * 0.5));
        var_1 = var_1 * var_5;
      }
    }

    self.roll_current = var_1 / (self.roll_speed_max * 0.05);
  }

  var_4 = var_4 + var_1;
  var_4 = clamp(var_4, 0 - self.roll_max, self.roll_max);
  self addroll(var_4 - self.angles[2]);

  if(!self.flight_controls)
    self.angles = (self.angles[0], self.angles[1] - var_2, self.angles[2]);
}

player_missile_yaw_control(var_0) {
  var_1 = var_0 getnormalizedcameramovement()[1];

  if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
    var_1 = var_1 * -1;
  else if(var_1 > 0 && var_1 < 0.25)
    var_1 = 0;
  else if(var_1 < 0 && var_1 > -0.25)
    var_1 = 0;

  var_2 = self.angles[1];

  if(var_1 != 0.0)
    var_2 = var_2 + self.yaw_speed_max * var_1 * 0.05;

  self addyaw(self.angles[1] - var_2);
}

player_missile_pitch_control(var_0) {
  var_1 = 0;
  var_2 = var_0 getnormalizedcameramovement()[0];

  if(level.console || level.player common_scripts\utility::is_player_gamepad_enabled()) {
    if(var_2 > 0 && var_2 < 0.25)
      var_2 = 0;
    else if(var_2 < 0 && var_2 > -0.25)
      var_2 = 0;
  }

  var_3 = self.angles[0];

  if(var_3 > 180)
    var_3 = var_3 - 360;

  var_1 = var_1 - var_2 * self.pitch_speed_max * 0.05;
  var_1 = clamp(var_1, (0 - self.pitch_speed_max) * abs(var_2) * 0.05, self.pitch_speed_max * abs(var_2) * 0.05);

  if(abs(var_3) / self.pitch_max > 0.5) {
    if(var_3 < 0 && var_1 < 0 || var_3 > 0 && var_1 > 0) {
      var_4 = squared((self.pitch_max - abs(var_3)) / (self.pitch_max - self.pitch_max * 0.5));
      var_1 = var_1 * var_4;
    }
  }

  var_3 = var_3 + var_1;
  var_3 = clamp(var_3, 0 - self.pitch_max, self.pitch_max);
  self addpitch(var_3 - self.angles[0]);
}

missile_explode(var_0) {
  thread do_decal_square(self getEye());
  radiusdamage(self getEye(), 500, 1000, 500, self, "MOD_PROJECTILE", level.missile.weap);
  playFX(level._effect["sabot_explode"], self.origin);
  level thread maps\satfarm_audio::tow_missile_explode(self.origin);
  physicsexplosionsphere(self getEye(), 300, 150, 1);
  self notify("remove_player_missile_control");
  level.player enablemousesteer(0);
}

update_altitude() {
  level endon("remove_player_missile_control");

  for(;;) {
    self.altitude = (self.origin[2] - maps\_utility::groundpos(self.origin)[2]) / 12;
    wait 0.05;
  }
}

spawn_allies() {
  level.allies = [];
  level.allies[0] = spawn_ally("ghost1");
  level.allies[0].animname = "hesh";
}

spawn_ally(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1))
    var_2 = level.start_point + "_" + var_0;
  else
    var_2 = var_1 + "_" + var_0;

  var_3 = spawn_targetname_at_struct_targetname(var_0, var_2);

  if(!isDefined(var_3))
    return undefined;

  var_3 maps\_utility::make_hero();

  if(!isDefined(var_3.magic_bullet_shield))
    var_3 maps\_utility::magic_bullet_shield();

  var_3.grenadeammo = 0;
  return var_3;
}

spawn_targetname_at_struct_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");

  if(isDefined(var_2) && isDefined(var_3)) {
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles))
      var_2.angles = var_3.angles;

    var_4 = var_2 maps\_utility::spawn_ai(1);
    return var_4;
  }

  if(isDefined(var_2)) {
    var_4 = var_2 maps\_utility::spawn_ai(1);
    iprintlnbold("Add a script struct called: " + var_1 + " to spawn him in the correct location.");
    var_4 teleport(level.player.origin, level.player.angles);
    return var_4;
  }

  iprintlnbold("failed to spawn " + var_0 + " at " + var_1);
  return undefined;
}

send_to_volume_and_delete(var_0) {
  self endon("death");
  maps\_utility::set_fixednode_false();
  self setgoalvolumeauto(var_0);
  self waittill("goal");
  self delete();
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

cleanup_enemies(var_0, var_1) {
  common_scripts\utility::flag_wait(var_0);
  var_1 = maps\_utility::array_removedead_or_dying(var_1);

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 kill();
    }
  }
}

dumb_tank_shoot(var_0) {
  self endon("death");

  if(isDefined(var_0))
    self endon(var_0);

  wait(randomfloatrange(2, 7));

  for(;;) {
    shoot_anim();
    wait(randomfloatrange(6, 12));
  }
}

waittill_goal(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_0))
    self.goalradius = var_0;

  self waittill("goal");

  if(isDefined(var_1)) {
    if(isDefined(self))
      self delete();
  }

  if(isDefined(self) && isDefined(var_2)) {
    if(isDefined(self.goalpos))
      thread mortar_on_spot(self.goalpos);
  }
}

mortar_on_spot(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self.goalpos;
  var_1.angles = (-90, 0, 0);
  thread common_scripts\utility::play_sound_in_space("satf_mortar_incoming", var_1.origin);
  wait(randomfloatrange(0.25, 0.45));
  mortar_impact(var_1);
  wait(randomfloatrange(0.25, 0.45));
  var_1 delete();
}

mortar_impact(var_0) {
  playFXOnTag(common_scripts\utility::getfx("mortar"), var_0, "tag_origin");
  screenshake(var_0.origin, 10, 2, 2, 2.0, 0, 2.0, 1600, 15, 8, 8, 1.8);
  thread common_scripts\utility::play_sound_in_space("satf_mortar_explosion_dirt", var_0.origin);
  playrumbleonposition("artillery_rumble", var_0.origin);
  radiusdamage(var_0.origin, 512, 25, 1);
}

enemy_rpg_unlimited_ammo(var_0) {
  if(isDefined(var_0))
    self endon(var_0);

  self endon("death");
  var_1 = 1;

  for(;;) {
    if(isDefined(self.a.rockets))
      self.a.rockets = var_1;

    wait 0.05;
  }
}

rotate_big_sat() {
  var_0 = getent("big_dish", "targetname");
  var_0 rotateroll(50, 0.05);
  common_scripts\utility::flag_wait("spawn_front");
  var_0 rotateroll(-50, 20);
}

kill_vehicle_spawners_now(var_0) {
  maps\_utility::array_delete(level.vehicle_killspawn_groups[var_0]);
  level.vehicle_killspawn_groups[var_0] = [];
}

kill_spawners_per_checkpoint(var_0) {}

saf_streetlight_dynamic_setup(var_0, var_1) {
  var_2 = common_scripts\utility::getStructArray("saf_streetlight_dynamic_" + var_0, "targetname");
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5 thread saf_streetlight_dynamic_func(var_1);
    var_3++;

    if(var_3 > 10) {
      wait 0.05;
      var_3 = 0;
    }
  }
}

saf_streetlight_dynamic_func(var_0) {
  level endon(var_0);
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("saf_streetlight_01");
  var_1 thread flag_wait_delete(var_0);
  var_1 setCanDamage(1);

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_6) && isDefined(var_3) && isDefined(level.playertank) && var_3 == level.playertank) {
      var_6 = tolower(var_6);

      if(var_6 == "mod_crush" || var_6 == "mod_explosive" || var_6 == "mod_projectile" || var_6 == "mod_projectile_splash") {
        break;
      }
    }

    wait 0.05;
  }

  if(isDefined(var_1))
    var_1 delete();

  var_7 = spawn("script_model", self.origin);
  var_7.angles = self.angles;
  var_7 setModel("saf_streetlight_broken_01");
  var_7 thread flag_wait_delete(var_0);
  var_8 = spawn("script_model", self.origin);
  var_8.angles = self.angles;
  var_8 setModel("saf_streetlight_broken_02");
  var_8 thread flag_wait_delete(var_0);

  if(isDefined(var_6) && var_6 == "mod_crush") {
    if(isDefined(var_3)) {
      var_9 = var_3 vehicle_getvelocity();

      if(var_3 == level.playertank) {
        thread common_scripts\utility::play_sound_in_space("satf_tank_collision_post_plr", level.player.origin);
        level.player screenshakeonentity(4.0, 1.0, 1.0, 0.5, 0, 0.25, 0, 2.0, 0.5, 0.5);
        level.player playrumbleonentity("damage_heavy");
      } else
        thread common_scripts\utility::play_sound_in_space("satf_tank_collision_npc", var_7.origin);

      var_8 physicslaunchclient(var_8.origin + (0, 0, 128), var_9 * 50);
    }
  } else if(isDefined(var_6) && (var_6 == "mod_explosive" || var_6 == "mod_projectile" || var_6 == "mod_projectile_splash") && isDefined(var_5) && isDefined(var_4)) {
    thread common_scripts\utility::play_sound_in_space("satf_tank_collision_npc", var_7.origin);
    var_8 physicslaunchclient(var_5, var_4 * 50);
  }
}

saf_concrete_barrier_dynamic_setup(var_0, var_1) {
  var_2 = common_scripts\utility::getStructArray("saf_concrete_barrier_dynamic_" + var_0, "targetname");
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5 thread saf_concrete_barrier_dynamic_func(var_1);
    var_3++;

    if(var_3 > 10) {
      wait 0.05;
      var_3 = 0;
    }
  }
}

saf_concrete_barrier_dynamic_func(var_0) {
  level endon(var_0);
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("saf_parking_post_01");
  var_1 thread flag_wait_delete(var_0);
  var_1 setCanDamage(1);

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_6) && isDefined(var_3) && isDefined(level.playertank) && var_3 == level.playertank) {
      var_6 = tolower(var_6);

      if(var_6 == "mod_crush") {
        break;
      }
    }

    wait 0.05;
  }

  if(isDefined(var_3)) {
    var_7 = var_3 vehicle_getvelocity();

    if(var_3 == level.playertank) {
      thread maps\satfarm_audio::player_post_collision();
      level.player screenshakeonentity(4.0, 1.0, 1.0, 0.5, 0, 0.25, 0, 2.0, 0.5, 0.5);
      level.player playrumbleonentity("damage_heavy");
    } else
      thread maps\satfarm_audio::npc_post_collision(var_1.origin);

    var_1 physicslaunchclient(var_1.origin + (0, 0, 128), var_7 * 100);
  }
}

saf_large_sign_01_dynamic_setup(var_0, var_1) {
  var_2 = common_scripts\utility::getStructArray("saf_large_sign_01_dynamic_" + var_0, "targetname");
  var_3 = 0;

  foreach(var_5 in var_2) {
    var_5 thread saf_large_sign_01_dynamic_func(var_1);
    var_3++;

    if(var_3 > 10) {
      wait 0.05;
      var_3 = 0;
    }
  }
}

saf_large_sign_01_dynamic_func(var_0) {
  level endon(var_0);
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 setModel("saf_large_sign_01");
  var_1 thread flag_wait_delete(var_0);
  var_1 setCanDamage(1);

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(var_6) && isDefined(var_3) && isDefined(level.playertank) && var_3 == level.playertank) {
      var_6 = tolower(var_6);

      if(var_6 == "mod_crush" || var_6 == "mod_explosive" || var_6 == "mod_projectile" || var_6 == "mod_projectile_splash") {
        break;
      }
    }

    wait 0.05;
  }

  if(isDefined(var_6) && var_6 == "mod_crush") {
    if(isDefined(var_3)) {
      var_7 = var_3 vehicle_getvelocity();

      if(var_3 == level.playertank) {
        thread maps\satfarm_audio::player_post_collision();
        level.player screenshakeonentity(4.0, 1.0, 1.0, 0.5, 0, 0.25, 0, 2.0, 0.5, 0.5);
        level.player playrumbleonentity("damage_heavy");
      } else
        thread maps\satfarm_audio::npc_post_collision(var_1.origin);

      var_1 physicslaunchclient(var_1.origin + (0, 0, 128), var_7 * 50);
    }
  } else if(isDefined(var_6) && (var_6 == "mod_explosive" || var_6 == "mod_projectile" || var_6 == "mod_projectile_splash") && isDefined(var_5) && isDefined(var_4)) {
    thread common_scripts\utility::play_sound_in_space("satf_tank_collision_npc", var_1.origin);
    var_1 physicslaunchclient(var_5, var_4 * 100);
  }
}

disable_all_triggers() {
  level.player endon("tank_dismount");
  var_0 = getEntArray("trigger_multiple", "classname");
  var_1 = getEntArray("trigger_radius", "classname");
  var_2 = getEntArray("trigger_multiple_flag_set", "classname");
  var_3 = getEntArray("trigger_damage", "classname");
  var_4 = getEntArray("info_volume", "classname");

  foreach(var_6 in var_0) {
    if(isDefined(var_6.trigger_off) || isDefined(var_6.targetname) && var_6.targetname == "hangar_wall_smash_trigger") {
      var_0 = common_scripts\utility::array_remove(var_0, var_6);
      continue;
    }

    var_6 common_scripts\utility::trigger_off();
  }

  foreach(var_6 in var_1) {
    if(isDefined(var_6.trigger_off)) {
      var_1 = common_scripts\utility::array_remove(var_1, var_6);
      continue;
    }

    var_6 common_scripts\utility::trigger_off();
  }

  foreach(var_6 in var_2) {
    if(isDefined(var_6.trigger_off)) {
      var_2 = common_scripts\utility::array_remove(var_2, var_6);
      continue;
    }

    var_6 common_scripts\utility::trigger_off();
  }

  foreach(var_6 in var_4) {
    if(isDefined(var_6.trigger_off)) {
      var_4 = common_scripts\utility::array_remove(var_4, var_6);
      continue;
    }

    var_6 common_scripts\utility::trigger_off();
  }

  level.player waittill("reenable_triggers");

  foreach(var_6 in var_0) {
    if(isDefined(var_6))
      var_6 common_scripts\utility::trigger_on();
  }

  foreach(var_6 in var_1) {
    if(isDefined(var_6))
      var_6 common_scripts\utility::trigger_on();
  }

  foreach(var_6 in var_2) {
    if(isDefined(var_6))
      var_6 common_scripts\utility::trigger_on();
  }

  foreach(var_6 in var_4) {
    if(isDefined(var_6))
      var_6 common_scripts\utility::trigger_on();
  }
}

setup_ambient_tank_drop(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::getstruct(var_0, "targetname");
  var_6 = [];
  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_1) && var_1 == 1) {
    var_7 = maps\_utility::spawn_anim_model("tank_ambient");
    var_6 = common_scripts\utility::add_to_array(var_6, var_7);
    var_8 = maps\_utility::spawn_anim_model("c17_ambient");
    var_6 = common_scripts\utility::add_to_array(var_6, var_8);
  } else {
    var_9 = maps\_utility::getvehiclespawnerarray(var_0);

    foreach(var_11 in var_9) {
      if(isDefined(var_11.script_parameters)) {
        if(var_11.script_parameters == "tank") {
          var_7 = var_11 maps\_utility::spawn_vehicle();
          var_7.animname = "tank_ambient";
          var_7 useanimtree(level.scr_animtree[var_7.animname]);
          var_6 = common_scripts\utility::add_to_array(var_6, var_7);
          level.allytanks = common_scripts\utility::array_add(level.allytanks, var_7);

          if(isDefined(var_3))
            var_7 thread flag_wait_delete(var_3);
        }

        if(var_11.script_parameters == "c17") {
          var_8 = var_11 maps\_utility::spawn_vehicle();
          var_8.animname = "c17_ambient";
          var_8 useanimtree(level.scr_animtree[var_8.animname]);
          var_6 = common_scripts\utility::add_to_array(var_6, var_8);
        }
      }
    }
  }

  var_5 thread maps\_anim::anim_single(var_6, "ambient_drop");
  var_7 thread tank_ambient_deploy_chutes(var_5, 1, var_4);
  var_7 thread tank_ambient_waits(var_2, var_0);

  if(isDefined(var_1) && var_1 == 1) {
    var_8 waittillmatch("single anim", "end");
    var_8 delete();
  } else {
    var_13 = getvehiclenode(var_0 + "_c17_start", "targetname");
    var_8 waittillmatch("single anim", "end");
    wait 0.05;
    var_8 useanimtree(#animtree);
    var_8 attach_path_and_drive(var_13, 180);
  }
}

tank_ambient_waits(var_0, var_1) {
  self endon("death");
  self waittillmatch("single anim", "end");
  wait 0.05;
  self useanimtree(#animtree);
  var_2 = getvehiclenode(var_1 + "_tank_start", "targetname");
  thread attach_path_and_drive(var_2);

  if(isDefined(var_0))
    thread npc_tank_combat_init();
}

tank_ambient_deploy_chutes(var_0, var_1, var_2) {
  var_3 = "pilot_chute_tank_ambient";
  var_4 = maps\_utility::spawn_anim_model(var_3);

  if(isDefined(var_1) && var_1 == 1)
    var_0 = self;

  var_4 hide();

  if(isDefined(var_1) && var_1 == 1)
    var_4 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  var_5 = [];

  for(var_6 = 0; var_6 <= 2; var_6++) {
    var_3 = "main_chute" + var_6 + "_tank_ambient";
    var_5[var_6] = maps\_utility::spawn_anim_model(var_3);
    var_5[var_6] hide();

    if(isDefined(var_1) && var_1 == 1)
      var_5[var_6] linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  var_0 thread maps\_anim::anim_first_frame_solo(var_4, "pilot_chute_deploy", "tag_origin");
  var_0 thread maps\_anim::anim_first_frame(var_5, "main_chute_deploy", "tag_origin");
  self waittillmatch("single anim", "spawn_pilot_chute");
  var_4 show();
  var_0 thread maps\_anim::anim_single_solo(var_4, "pilot_chute_deploy", "tag_origin");
  self waittillmatch("single anim", "spawn_main_chutes");

  if(isDefined(var_2)) {}

  foreach(var_8 in var_5)
  var_8 show();

  var_0 maps\_anim::anim_single(var_5, "main_chute_deploy", "tag_origin");
  var_4 unlink();

  foreach(var_8 in var_5)
  var_8 unlink();

  wait 5.0;
  var_4 delete();

  foreach(var_8 in var_5)
  var_8 delete();
}

attach_path_and_drive(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 45;

  if(!isDefined(var_2))
    var_2 = 15;

  self attachpath(var_0);
  self startpath(var_0);
  thread maps\_vehicle::vehicle_paths(var_0);

  if(isDefined(var_1))
    self vehicle_setspeedimmediate(var_1, var_2);
}

create_missile_attractor() {
  level.playertank endon("death");
  level.missilefire = common_scripts\utility::spawn_tag_origin();
  level.missilehit = common_scripts\utility::spawn_tag_origin();
  level.missilehit linkto(level.playertank, "tag_flash", (0, 0, 0), (0, 0, 0));
}

play_sparks() {
  while(!isDefined(level.oldtank)) {
    playFXOnTag(common_scripts\utility::getfx("vfx_malfunction_sparks"), level.playertank, "tag_barrel");
    playFXOnTag(common_scripts\utility::getfx("tank_heavy_smoke"), level.playertank, "tag_turret");
    playFXOnTag(common_scripts\utility::getfx("tank_heavy_smoke"), level.playertank, "tag_interior_light_godray");
    wait(randomfloatrange(1, 5));
  }
}

target_settings() {
  if(!isDefined(level.target_settings_frame_count))
    level.target_settings_frame_count = 0;

  while(level.target_settings_frame_count >= 5)
    wait 0.05;

  level.target_settings_frame_count++;
  target_alloc(self, common_scripts\utility::ter_op(maps\_vehicle::ishelicopter(), (0, 0, 0), (0, 0, 72)));
  target_setshader(self, "ac130_hud_enemy_vehicle_target_s_w");
  target_setcolor(self, (1, 0, 0));
  target_hidefromplayer(self, level.player);
  target_flush(self);
  wait 0.05;
  level.target_settings_frame_count = 0;
  self waittill("death");

  if(isDefined(self))
    target_remove(self);
}

remove_drone_on_path_end() {
  self waittill("goal");

  if(isalive(self))
    self kill();
}

sand_effects_init() {
  if(!isDefined(anim._effect))
    anim._effect = [];
}

start_sand_effects() {
  self.bigjump_timedelta = 500;
  self.event_time = -1;
  thread listen_leftground();
  thread listen_landed();
  thread listen_jolt();
  thread listen_collision();
  thread listen_vehicle_death();
}

tank_fx(var_0) {
  if(self.model == "vehicle_chinese_brave_warrior_anim") {
    if(isDefined(anim._effect[var_0]))
      playFXOnTag(anim._effect[var_0], self, "tag_deathfx");
  }

  if(self.model == "vehicle_gaz_tigr_base") {
    if(isDefined(anim._effect[var_0]))
      playFXOnTag(anim._effect[var_0], self, "tag_guy0");
  }
}

listen_leftground() {
  self endon("death");

  for(;;) {
    self waittill("veh_leftground");
    thread common_scripts\utility::play_sound_in_space("satf_tank_leftground_npc", self.origin);

    if(!isDefined(self.kill_my_fx))
      self.event_time = gettime();
  }
}

listen_vehicle_death() {
  var_0 = 2000;
  self waittill("death");

  if(isDefined(self)) {
    var_1 = distance(level.player.origin, self.origin);

    if(var_1 < var_0)
      return;
  } else {}
}

listen_landed() {
  self endon("death");

  for(;;) {
    self waittill("veh_landed");

    if(!isDefined(self.kill_my_fx)) {
      if(self.event_time + self.bigjump_timedelta < gettime()) {
        thread common_scripts\utility::play_sound_in_space("satf_tank_land_loud_npc", self.origin);
        continue;
      }

      thread common_scripts\utility::play_sound_in_space("satf_tank_land_npc", self.origin);
    }
  }
}

listen_jolt() {
  self endon("death");

  for(;;) {
    self waittill("veh_jolt", var_0);

    if(!isDefined(self.kill_my_fx)) {
      if(var_0[1] >= 0) {
        thread common_scripts\utility::play_sound_in_space("satf_tank_jolt_npc", self.origin);
        continue;
      }

      thread common_scripts\utility::play_sound_in_space("satf_tank_jolt_npc", self.origin);
    }
  }
}

listen_collision() {
  self endon("death");

  for(;;) {
    self waittill("veh_collision", var_0, var_1);
    thread common_scripts\utility::play_sound_in_space("satf_tank_collision_npc", self.origin);

    if(!isDefined(self.kill_my_fx)) {}
  }
}

listen_player() {
  self.bigjump_timedelta = 500;
  self.event_time = -1;
  thread listen_player_leftground();
  thread listen_player_landed();
  thread listen_player_jolt();
}

listen_player_jolt() {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");

  for(;;) {
    self waittill("veh_jolt", var_0);

    if(!isDefined(self.kill_my_fx)) {
      var_1 = length(var_0);

      if(var_1 < 6000) {
        continue;
      }
      var_2 = var_1 / 30000;
      level.player screenshakeonentity(15 * var_2, 5 * var_2, 0, 1, 0, 1, 500, 12, 10, 0, 1.8);

      if(var_1 > 10000) {
        thread play_rumble_seconds("damage_heavy", 1);

        if(var_0[1] >= 0)
          thread common_scripts\utility::play_sound_in_space("satf_tank_collision_plr", level.player.origin);
        else
          thread common_scripts\utility::play_sound_in_space("satf_tank_jolt_plr", level.player.origin);
      } else {
        thread play_rumble_seconds("damage_light", 1);
        thread common_scripts\utility::play_sound_in_space("satf_tank_jolt_plr", level.player.origin);
      }
    }
  }
}

listen_player_leftground() {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");

  for(;;) {
    self waittill("veh_leftground");
    thread common_scripts\utility::play_sound_in_space("satf_tank_leftground_plr", level.player.origin);
    self.event_time = gettime();
  }
}

listen_player_landed() {
  self endon("death");
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");

  for(;;) {
    self waittill("veh_landed");

    if(self.event_time + self.bigjump_timedelta > gettime()) {
      thread common_scripts\utility::play_sound_in_space("satf_tank_land_loud_plr", level.player.origin);
      continue;
    }

    thread common_scripts\utility::play_sound_in_space("satf_tank_land_treads_plr", self.origin);
  }
}

play_rumble_seconds(var_0, var_1) {
  level.player endon("tank_dismount");
  level.player endon("missile_tank_dismount");

  for(var_2 = 0; var_2 < var_1 / 0.3; var_2++) {
    level.player playrumbleonentity(var_0);
    wait 0.3;
  }
}

screenshakefade(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = var_1 * 10;
  var_5 = var_2 * 10;

  if(var_5 > 0)
    var_6 = var_0 / var_5;
  else
    var_6 = var_0;

  var_7 = var_3 * 10;
  var_8 = var_4 - var_7;

  if(var_7 > 0)
    var_9 = var_0 / var_7;
  else
    var_9 = var_0;

  var_10 = 0.1;
  var_0 = 0;

  for(var_11 = 0; var_11 < var_4; var_11++) {
    if(var_11 <= var_5)
      var_0 = var_0 + var_6;

    if(var_11 > var_8)
      var_0 = var_0 - var_9;

    earthquake(var_0, var_10, level.player.origin, 500);
    wait(var_10);
  }
}

heli_crash_kill() {
  while(isalive(self) && !isDefined(self.crashing))
    wait 1;

  self waittill("damage");
  self notify("crash_done");
  self notify("in_air_explosion");
}

is_player_locked_on() {
  if(isDefined(level.playertank.locked_on) && level.playertank.locked_on == 1)
    return 1;
  else
    return 0;
}

chopper_insta_kill() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 == level.player && isDefined(level.missile) && isDefined(level.missile.weap) && isDefined(var_9) && var_9 == level.missile.weap) {
      if(!isDefined(level.chopper_missile_kills))
        level.chopper_missile_kills = 0;

      level.chopper_missile_kills++;

      if(level.chopper_missile_kills == 3)
        level.player maps\_utility::player_giveachievement_wrapper("LEVEL_16A");
    }

    if(isDefined(var_4))
      var_4 = tolower(var_4);

    if(var_4 == "mod_projectile" || var_4 == "mod_projectile_splash" || var_4 == "mod_explosive") {
      if(isDefined(self)) {
        level thread maps\satfarm_audio::chopper_death_player(self.origin);
        self kill();
        wait 0.1;

        if(isDefined(self))
          self delete();
      }
    }

    wait 0.05;
  }
}

satfarm_timer(var_0, var_1, var_2, var_3) {
  level endon("kill_timer");

  if(getDvar("notimer") == "1") {
    return;
  }
  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_1))
    var_1 = &"SATFARM_TIME_IMACT";

  level.hudtimerindex = 20;
  level.timer = maps\_hud_util::get_countdown_hud(-250);
  level.timer setpulsefx(30, 900000, 700);
  level.timer.label = var_1;
  level.timer settimer(var_0);
  level.start_time = gettime();
  var_4 = level.timer;

  if(!isDefined(var_2))
    wait(var_0);
  else
    wait(var_2);

  if(isDefined(var_4))
    killtimer();
}

timer_ten_change(var_0) {
  level endon("kill_timer");

  while(isDefined(level.timer)) {
    if(isDefined(level.timer) && var_0 < 11 && var_0 > 0) {
      common_scripts\utility::flag_set("aud_ten_seconds");
      level.timer.color = (1, 0, 0);
      wait 0.25;

      if(isDefined(level.timer))
        level.timer.color = (0.8, 1, 0.8);

      wait 0.25;

      if(isDefined(level.timer))
        level.timer.color = (1, 0, 0);

      wait 0.25;

      if(isDefined(level.timer))
        level.timer.color = (0.8, 1, 0.8);

      wait 0.25;
    } else
      wait 1;

    var_0--;
  }
}

killtimer() {
  if(isDefined(level.timer))
    level.timer destroy();
}

exiting_combat_zone() {
  level notify("exiting_combat_zone");
  level endon("exiting_combat_zone");
  level endon("air_strip_end");
  level endon("air_strip_secured_begin");
  level.player endon("missile_tank_dismount");

  if(isDefined(level.old_kill_fail_flag) && !level.old_kill_fail_flag)
    common_scripts\utility::flag_clear("kill_fail_flag");

  var_0 = getEntArray("fail_warning", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      if((!isDefined(var_2.trigger_off) || !var_2.trigger_off) && level.player istouching(var_2)) {
        maps\_utility::hint(&"SATFARM_LEAVING_COMBAT", 1, 64);
        break;
      }
    }

    if(common_scripts\utility::flag("kill_fail_flag"))
      level notify("player_tank_exited_combat_area");

    common_scripts\utility::waitframe();
  }
}

exiting_combat_player_fail() {
  while(common_scripts\utility::flag("PLAYER_GUIDING_ROUND"))
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_wait("player_in_tank");
  level.playertank makeusable();
  level.playertank useby(level.player);
  level.player disableinvulnerability();
  setDvar("ui_deadquote", &"SATFARM_TANK_DEATH");
  maps\_utility::missionfailedwrapper();
  level.player kill();
  level.playertank kill();
}

fire_tracking_missile_mig() {
  if(isDefined(level.fire_tracking_missile_mig)) {
    return;
  }
  level.fire_tracking_missile_mig = 1;
  level waittill("player_tank_exited_combat_area");
  thread play_mig_anim(level.playertank);
  wait 1.5;
  var_0 = fire_magic_missile_mig(75);
  thread track_player_direction_mig(var_0);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("missile_incoming");

  while(isDefined(var_0))
    common_scripts\utility::waitframe();

  level.player thread common_scripts\utility::stop_loop_sound_on_entity("missile_incoming");
  exiting_combat_player_fail();
}

fire_tracking_missile_mig_nonfatal() {
  thread play_mig_anim(level.playertank);
  wait 1.5;
  var_0 = fire_magic_missile_mig(75);
  thread track_player_direction_mig(var_0);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("missile_incoming");

  while(isDefined(var_0))
    common_scripts\utility::waitframe();

  level.player thread common_scripts\utility::stop_loop_sound_on_entity("missile_incoming");
}

fire_tracking_missile_at_vehicle(var_0) {
  thread play_mig_anim(var_0);
  wait 1.5;
  var_1 = fire_magic_missile_mig(75, var_0);
  track_player_direction_mig(var_1, var_0);

  while(isDefined(var_1))
    common_scripts\utility::waitframe();
}

play_mig_anim(var_0) {
  var_1 = maps\_utility::spawn_anim_model("mig_flyby", var_0.origin);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = level.player.origin + (0, 0, 1200);
  var_2.angles = level.player.angles;
  var_2 linkto(var_0);
  var_2 maps\_anim::anim_single_solo(var_1, "flyby");
  var_1 delete();
  var_2 delete();
}

fire_magic_missile_mig(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level.playertank;

  var_2 = var_1 gettagorigin("tag_barrel");
  var_3 = anglesToForward(level.player.angles);
  var_4 = var_1 vehicle_getspeed();
  var_5 = var_2 + 50 * var_3 * var_0 + (0, 0, 1500);
  var_6 = magicbullet("javelin_satfarm", var_5, var_1.origin);
  return var_6;
}

track_player_direction_mig(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = level.playertank;

  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = 0;
  var_0 missile_settargetent(var_2);

  while(isDefined(var_0) && isDefined(var_1) && isalive(var_1)) {
    var_4 = var_1 gettagorigin("tag_barrel");
    var_5 = anglesToForward(level.player.angles);
    var_6 = var_1 vehicle_getspeed();
    var_7 = var_4 + var_6 * var_5 * 5;
    var_2.origin = var_7;
    var_3 = var_0.origin;
    common_scripts\utility::waitframe();
  }

  var_2 delete();
}

follow_icon_manager() {
  level.player endon("death");
  wait 0.5;

  while(!common_scripts\utility::flag("air_strip_take_off_mig_01_go")) {
    if(distancesquared(level.player.origin, level.badger.origin) <= 6250000 || distancesquared(level.player.origin, level.badger.origin) > 6250000 && common_scripts\utility::within_fov(level.player.origin, level.player getplayerangles(), level.badger.origin, cos(15)))
      setsaveddvar("objectiveHide", 1);
    else
      setsaveddvar("objectiveHide", 0);

    wait 1.5;
  }

  setsaveddvar("objectiveHide", 0);
}

tank_tread_freq_all() {
  var_0 = vehicle_getspawnerarray();

  foreach(var_2 in var_0) {
    if(var_2 istank())
      var_2 tank_tread_freq();
  }
}

tank_tread_freq() {
  self.treadfx_freq_scale = 0.5;
}

finish_zoom() {}

satfarm_corpse_cleanup() {
  level endon("player_landed");

  for(;;) {
    var_0 = getcorpsearray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && !sighttracepassed(level.player getEye(), var_2.origin, 0, level.player)) {
        if(isDefined(var_2))
          var_2 delete();
      }

      if(isDefined(var_2) && distancesquared(var_2.origin, level.player.origin) > 6250000) {
        if(isDefined(var_2))
          var_2 delete();

        continue;
      }

      if(isDefined(var_2) && !common_scripts\utility::within_fov(level.player.origin, level.player getplayerangles(), var_2.origin, cos(65))) {
        if(isDefined(var_2))
          var_2 delete();
      }
    }

    wait 1.0;
  }
}