/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_fast_travel.gsc
*************************************************************/

init_teleport_portals() {
  level._effect["death_ray_cannon_beam"] = loadfx("vfx\iw7\levels\cp_town\death_ray_cannon_beam.vfx");
  level._effect["death_ray_cannon_rock_impact"] = loadfx("vfx\iw7\levels\cp_final\rhino\vfx_metal_impact.vfx");
  level._effect["portal_glyph"] = loadfx("vfx\iw7\levels\cp_final\portal\vfx_portal_symbol_1.vfx");
  level._effect["vfx_pap_return_portal"] = loadfx("vfx\iw7\levels\cp_disco\vfx_paproom_portal.vfx");
  wait(5);
  var_0 = scripts\engine\utility::getStructArray("fast_travel_portal", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread trigger_when_player_close_by();
    wait(0.1);
  }

  level thread func_15B6();
  level thread blast_doors_with_gun();
}

register_portal_interactions() {
  level.interaction_hintstrings["portal_console"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "portal_console", undefined, undefined, ::portal_console_hint_func, ::portal_console_activate_func, 0, 1, ::portal_console_init_func);
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "portal_gun_button", undefined, undefined, ::portal_gun_hint_func, ::portal_gun_activate_func, 0, 1, ::portal_gun_init_func);
}

portal_console_init_func() {
  var_0 = scripts\engine\utility::getStructArray("portal_console", "script_noteworthy");
  foreach(var_2 in var_0) {
    level thread stand_on_glyph(var_2);
  }
}

portal_console_hint_func(var_0, var_1) {
  return "";
}

portal_console_activate_func(var_0, var_1) {}

stand_on_glyph(var_0) {
  var_1 = scripts\engine\utility::getStructArray("fast_travel_portal_symbol", "targetname");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1, 500);
  if(!isDefined(var_2)) {
    return;
  }

  var_2.fx = spawnfx(level._effect["portal_glyph"], var_2.origin);
  wait(0.1);
  triggerfx(var_2.fx);
  var_3 = 0;
  var_4 = 100;
  var_5 = var_4 * var_4;
  while(!var_3) {
    foreach(var_7 in level.players) {
      if(distancesquared(var_7.origin, var_2.origin) < var_5) {
        var_3 = 1;
        break;
      }
    }

    wait(0.5);
  }

  var_9 = scripts\engine\utility::getStructArray("fast_travel_portal", "targetname");
  var_10 = scripts\engine\utility::getclosest(var_0.origin, var_9, 500);
  var_10.opened = 1;
  var_10.end_point.opened = 1;
  var_2.fx delete();
}

trigger_when_player_close_by() {
  var_0 = getEntArray("fast_travel_portal_trigger", "targetname");
  self.trigger = scripts\engine\utility::getclosest(self.origin, var_0, 500);
  self.trigger endon("death");
  self.start_point_name = self.script_noteworthy;
  self.end_point_name = self.script_parameters;
  self.end_point = scripts\engine\utility::getstruct(self.end_point_name, "script_noteworthy");
  if(self.start_point_name == "left_alley") {
    self.trigger.origin = self.trigger.origin + (0, -15, 0);
  }

  self.recently_used = [];
  self.cooldown = 0;
  self.opened = 0;
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.teleport_spots = scripts\engine\utility::getStructArray(self.end_point.target, "targetname");
  foreach(var_2 in self.teleport_spots) {
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    if(var_2.origin == (1792, 1886, 64)) {
      var_2.origin = (1752, 1918, 64);
    }
  }

  scripts\engine\utility::flag_wait("power_on");
  var_4 = scripts\engine\utility::getStructArray("fast_travel_portal_spot", "targetname");
  self.portal_spot = scripts\engine\utility::getclosest(self.origin, var_4, 500);
  self.portal_scriptable = spawn("script_model", self.portal_spot.origin + (0, 0, 53));
  self.portal_scriptable setModel("tag_origin_final_portal");
  self.portal_scriptable.angles = self.angles;
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  thread portal_cooldown_monitor();
  wait_for_portal_doors_open();
  self.last_time_player_used = gettime();
  wait(1);
  for(;;) {
    self.trigger waittill("trigger", var_5);
    if(scripts\engine\utility::istrue(var_5.inlaststand)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isPlayer(var_5)) {
      if(self.last_time_player_used + 5000 > gettime()) {
        if(!isDefined(var_5.last_travel_time) || gettime() > var_5.last_travel_time + 10000) {
          thread move_zombie_through_portal_tube(var_5);
        }
      }

      scripts\engine\utility::waitframe();
      continue;
    }

    var_6 = anglesToForward(var_5.angles);
    if(vectordot(vectornormalize(self.portal_spot.origin - var_5.origin), var_6) < 0.66) {
      scripts\engine\utility::waitframe();
      continue;
    }

    toggleplayerlocation(var_5, self);
    if(self.end_point.opened && self.cooldown <= 0) {
      self.end_point.cooldown = self.end_point.cooldown + 10;
      thread send_followers_through_tube(var_5);
      self.last_time_player_used = gettime();
      move_player_through_portal_tube(var_5);
      if(!scripts\engine\utility::istrue(level.used_portal)) {
        scripts\cp\maps\cp_final\cp_final::setup_era_zombie_model_list();
      }

      level.used_portal = 1;
      if(isDefined(self.end_point_name)) {
        if(self.end_point_name == "theater") {
          var_5 scripts\cp\zombies\achievement::update_achievement("DOUBLE_FEATURE", 1);
        }
      }

      activate_room_after_portal_use(self.end_point_name);
    }

    wait(0.1);
  }
}

toggleplayerlocation(var_0, var_1) {
  if(isDefined(var_1.end_point_name)) {
    if(var_1.end_point_name == "theater" || var_1.end_point_name == "left_alley" || var_1.end_point_name == "theater_front") {
      var_0.currentlocation = "theater";
      return;
    }

    var_0.currentlocation = "facility";
  }
}

activate_room_after_portal_use(var_0) {
  switch (var_0) {
    case "theater":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("theater_main");
      if(!scripts\engine\utility::istrue(level.theater_open)) {
        foreach(var_2 in level.players) {
          var_2 scripts\cp\cp_merits::processmerit("mt_dlc4_theater_open");
        }

        level.theater_open = 1;
      }
      break;

    case "cargo_room":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("cargo");
      break;

    case "left_alley":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("hallway_to_alley");
      break;

    case "starting_room":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("facility_start");
      break;

    case "pump_room":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("medical_lab");
      break;

    case "theater_front":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("theater_street");
      break;

    default:
      break;
  }
}

wait_for_portal_doors_open() {
  crack_portal_doors();
  open_portal_doors();
}

crack_portal_doors() {
  var_0 = getEntArray("center_portal_door_left", "targetname");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0, 500);
  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::getStructArray("center_portal_door_left_pos", "targetname");
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);
    if(isDefined(var_3)) {
      var_4 = var_3.origin - var_1.origin;
      var_5 = scripts\cp\utility::vec_multiply(var_4, 0.2) + var_1.origin;
      var_1 moveto(var_5, 0.5, 0.1, 0.1);
    }
  }

  var_6 = getEntArray("center_portal_door_right", "targetname");
  var_7 = scripts\engine\utility::getclosest(self.origin, var_6, 500);
  if(isDefined(var_7)) {
    var_2 = scripts\engine\utility::getStructArray("center_portal_door_right_pos", "targetname");
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);
    if(isDefined(var_3)) {
      var_4 = var_3.origin - var_7.origin;
      var_5 = scripts\cp\utility::vec_multiply(var_4, 0.2) + var_7.origin;
      var_7 moveto(var_5, 0.5, 0.1, 0.1);
    }
  }

  wait(0.5);
}

open_portal_doors() {
  var_0 = getEntArray("portal_door_left", "targetname");
  var_1 = scripts\engine\utility::getclosest(self.origin, var_0, 500);
  if(isDefined(var_1)) {
    var_2 = scripts\engine\utility::getStructArray("portal_door_left_pos", "targetname");
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);
    var_1 moveto(var_3.origin, 0.5, 0.1, 0.1);
  }

  var_4 = getEntArray("portal_door_right", "targetname");
  var_5 = scripts\engine\utility::getclosest(self.origin, var_4, 500);
  if(isDefined(var_5)) {
    var_2 = scripts\engine\utility::getStructArray("portal_door_right_pos", "targetname");
    var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 500);
    var_5 moveto(var_3.origin, 0.5, 0.1, 0.1);
  }

  wait(0.5);
}

blast_doors_with_gun() {
  level.portal_gun_activated = 0;
  while(!scripts\engine\utility::istrue(level.portal_gun_init_done)) {
    wait(0.1);
  }

  var_0 = "death_ray_cannon_beam";
  var_1 = "tag_origin_laser_ray_fx";
  var_2 = "death_ray_cannon_rock_impact";
  var_3 = scripts\engine\utility::getStructArray("gun_barrel", "targetname");
  var_3 = level.portal_gun.barrel_ents;
  while(!level.portal_gun_activated) {
    wait(0.1);
  }

  wait(1);
  foreach(var_5 in var_3) {
    var_6 = spawn("script_model", var_5.origin);
    var_6.angles = var_5.angles;
    var_6 setModel(var_1);
    var_5.fx_spot = var_6;
  }

  wait(1);
  var_8 = (1745, 1827, 68);
  foreach(var_5 in var_3) {
    if(!isDefined(var_5.angles)) {
      var_5.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_0], var_5.origin, var_5.angles, var_8);
  }

  playsoundatpos(level.portal_gun.origin, "zmb_railgun_fire");
  wait(0.1);
  foreach(var_5 in var_3) {
    var_5.fx_spot delete();
  }

  playFX(level._effect[var_2], var_8);
  var_13 = undefined;
  var_14 = scripts\engine\utility::getStructArray("fast_travel_portal", "targetname");
  foreach(var_10 in var_14) {
    if(var_10.script_noteworthy == "cargo_room") {
      var_13 = var_10;
    }
  }

  if(isDefined(var_13)) {
    var_13.opened = 1;
    var_13.end_point.opened = 1;
  }

  var_12 = getEntArray("center_portal_door_left", "targetname");
  var_13 = scripts\engine\utility::getclosest(var_3[0].origin, var_12, 1000);
  var_13 delete();
  var_12 = getEntArray("center_portal_door_right", "targetname");
  var_13 = scripts\engine\utility::getclosest(var_3[0].origin, var_12, 1000);
  var_13 delete();
}

debug_portal_door_open() {
  for(;;) {
    if(getdvarint("scr_open_portals") != 0) {
      break;
    }

    wait(1);
  }

  var_0 = scripts\engine\utility::getStructArray("fast_travel_portal", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.portal_spot)) {
      var_2.opened = 1;
    }
  }
}

portal_gun_init_func(var_0, var_1) {
  level.portal_gun_activated = 0;
  level.portal_gun = getent("portal_gun", "targetname");
  var_2 = scripts\engine\utility::getstruct("portal_gun_cargo_pos", "targetname");
  level.portal_gun.start_pos = level.portal_gun.origin;
  level.portal_gun.var_10B9F = level.portal_gun.angles;
  level.portal_gun.var_62EE = var_2.origin;
  level.portal_gun.end_ang = var_2.angles;
  level.portal_gun_crane = getent("laser_cannon_crane", "targetname");
  var_2 = scripts\engine\utility::getstruct("laser_cannon_crane_cargo_pos", "targetname");
  level.portal_gun_crane.start_pos = level.portal_gun_crane.origin;
  level.portal_gun_crane.var_10B9F = level.portal_gun_crane.angles;
  level.portal_gun_crane.var_62EE = var_2.origin;
  level.portal_gun_crane.end_ang = var_2.angles;
  wait(5);
  var_3 = scripts\engine\utility::getStructArray("gun_barrel", "targetname");
  level.portal_gun.barrel_ents = [];
  foreach(var_5 in var_3) {
    var_6 = spawn("script_origin", var_5.origin);
    wait(0.5);
    var_6.angles = var_5.angles;
    level.portal_gun.barrel_ents[level.portal_gun.barrel_ents.size] = var_6;
    var_6 linkto(level.portal_gun);
  }

  level.portal_gun_init_done = 1;
}

portal_gun_hint_func(var_0, var_1) {
  return "";
}

portal_gun_activate_func(var_0, var_1) {
  if(scripts\engine\utility::flag("power_on")) {
    var_2 = getent("portal_gun_button", "targetname");
    var_2 setModel("mp_frag_button_on_green");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    level.portal_gun moveto(level.portal_gun.var_62EE, 5, 0.1, 0.1);
    level.portal_gun_crane moveto(level.portal_gun_crane.var_62EE, 5, 0.1, 0.1);
    level.portal_gun_crane thread play_move_sounds(5);
    level.portal_gun waittill("movedone");
    level thread play_charge_up_sounds();
    level.portal_gun rotateto(level.portal_gun.end_ang, 3, 0.1, 0.1);
    level.portal_gun waittill("rotatedone");
    level.portal_gun_activated = 1;
    scripts\cp\maps\cp_final\cp_final_mpq::deactivateinteractionsbynoteworthy("portal_gun_button");
  }
}

play_charge_up_sounds() {
  wait(1.25);
  playsoundatpos(level.portal_gun.origin, "zmb_cannon_charge_up");
}

play_move_sounds(var_0) {
  var_1 = lookupsoundlength("zmb_cannon_platform_start") / 1000;
  var_2 = lookupsoundlength("zmb_cannon_platform_stop") / 1000;
  var_3 = var_0 - var_1 - var_2;
  self playsoundonmovingent("zmb_cannon_platform_start");
  wait(var_1);
  scripts\cp\utility::play_looping_sound_on_ent("zmb_cannon_platform_loop");
  wait(var_3);
  scripts\cp\utility::stop_looping_sound_on_ent("zmb_cannon_platform_loop");
  self playsoundonmovingent("zmb_cannon_platform_stop");
}

send_followers_through_tube(var_0) {
  var_1 = level.spawned_enemies;
  var_2 = var_0.origin;
  var_3 = 500;
  var_4 = var_3 * var_3;
  foreach(var_6 in var_1) {
    if(isDefined(var_6.myenemy) && var_6.myenemy == var_0) {
      if(distancesquared(var_6.origin, var_2) < var_4) {
        thread send_to_portal(var_6);
      }

      continue;
    }

    if(isDefined(var_6.enemy) && var_6.enemy == var_0) {
      if(distancesquared(var_6.origin, var_2) < var_4) {
        thread send_to_portal(var_6);
      }
    }
  }
}

send_to_portal(var_0) {
  var_0 endon("death");
  var_0 endon("portal_timed_out");
  var_0.scripted_mode = 1;
  var_0.sent_to_portal = 1;
  var_1 = getclosestpointonnavmesh(self.trigger.origin);
  var_0 ghostskulls_complete_status(var_1);
  level thread stop_trying_to_go_through_portal(var_0, 5);
  var_0 waittill("goal_reached");
  var_0 ghostskulls_complete_status(var_0.origin);
}

stop_trying_to_go_through_portal(var_0, var_1) {
  var_0 endon("death");
  wait(var_1);
  var_0.sent_to_portal = undefined;
  var_0.scripted_mode = 0;
  var_0 notify("portal_timed_out");
  var_0 ghostskulls_complete_status(var_0.origin);
}

turn_on_portal() {
  self.portal_scriptable setscriptablepartstate("portal", "active");
}

move_player_through_portal_tube(var_0) {
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0.isfasttravelling = 1;
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  self.cooldown = self.cooldown + 10;
  teleport_to_portal_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.isfasttravelling = undefined;
  var_0 notify("fast_travel_complete");
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread update_personal_ents_after_delay();
}

move_zombie_through_portal_tube(var_0) {
  if(scripts\engine\utility::istrue(var_0.var_11B2F)) {
    return;
  }

  var_0.isfasttravelling = 1;
  var_0.last_travel_time = gettime();
  var_1 = ai_move_through_tube(var_0, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_ai_to_portal_safe_spot(var_0);
  wait(0.1);
  if(isDefined(var_1)) {
    var_1 delete();
  }

  var_0.scripted_mode = 0;
  var_0.isfasttravelling = undefined;
}

move_through_tube(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("move_through_tube");
  var_0 earthquakeforplayer(0.3, 0.2, var_0.origin, 200);
  var_4 = getent(var_1, "targetname");
  var_5 = getent(var_2, "targetname");
  var_0 cancelmantle();
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_6 = var_4.origin + (0, 0, -45);
  var_7 = var_5.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_4.angles);
  var_0 playlocalsound("zmb_portal_travel_lr");
  var_8 = spawn("script_origin", var_6);
  var_0 playerlinkto(var_8);
  var_0 getweaponrankxpmultiplier();
  wait(0.1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_8 moveto(var_7, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(var_0 scripts\cp\utility::isignoremeenabled()) {
    var_0 scripts\cp\utility::allow_player_ignore_me(0);
  }

  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_8;
}

ai_move_through_tube(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("move_through_tube");
  var_4 = getent(var_1, "targetname");
  var_5 = getent(var_2, "targetname");
  var_0.no_outline = 1;
  var_0.no_team_outlines = 1;
  var_6 = var_4.origin + (0, 0, -45);
  var_7 = var_5.origin + (0, 0, -45);
  var_0.is_fast_traveling = 1;
  var_0 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_4.angles);
  var_8 = spawn("script_origin", var_6);
  var_0 linkto(var_8);
  wait(0.1);
  var_8 moveto(var_7, 1);
  wait(1);
  var_0.is_fast_traveling = undefined;
  var_0.is_fast_traveling = undefined;
  var_0.no_outline = 0;
  var_0.no_team_outlines = 0;
  var_0.sent_to_portal = undefined;
  var_0.scripted_mode = 0;
  return var_8;
}

update_personal_ents_after_delay() {
  self endon("disconnect");
  scripts\engine\utility::waitframe();
  scripts\cp\cp_interaction::refresh_interaction();
}

unlinkplayerafterduration() {
  while(scripts\engine\utility::istrue(self.isrewinding) || isDefined(self.rewindmover)) {
    wait(0.1);
  }

  self unlink();
}

teleport_to_portal_safe_spot(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = self.teleport_spots;
  }

  var_3 = undefined;
  while(!isDefined(var_3)) {
    foreach(var_5 in var_2) {
      if(!positionwouldtelefrag(var_5.origin)) {
        var_3 = var_5;
      }
    }

    if(!isDefined(var_3)) {
      if(!isDefined(var_2[0].angles)) {
        var_2[0].angles = (0, 0, 0);
      }

      var_7 = scripts\cp\utility::vec_multiply(anglesToForward(var_2[0].angles), 64);
      var_3 = spawnStruct();
      var_3.origin = var_2[0].origin + var_7;
      var_3.angles = var_2[0].angles;
    }

    wait(0.1);
  }

  var_0 playershow();
  if(scripts\engine\utility::istrue(var_0.isrewinding) || isDefined(self.rewindmover)) {
    var_0 thread unlinkplayerafterduration();
  } else {
    var_0 unlink();
  }

  var_0 dontinterpolate();
  var_0 setorigin(var_3.origin);
  var_0 setplayerangles(var_3.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0.portal_end_origin = var_3.origin;
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_3.origin, var_3.angles);
}

teleport_ai_to_portal_safe_spot(var_0) {
  var_1 = scripts\engine\utility::array_randomize(self.teleport_spots);
  var_2 = undefined;
  var_3 = undefined;
  while(!isDefined(var_2)) {
    foreach(var_3 in var_1) {
      if(!scripts\engine\utility::istrue(var_3.in_use)) {
        if(!positionwouldtelefrag(var_3.origin)) {
          var_2 = var_3;
          var_3.in_use = 1;
          break;
        }
      }
    }

    if(!isDefined(var_2)) {
      if(!isDefined(var_1[0].angles)) {
        var_1[0].angles = (0, 0, 0);
      }

      var_6 = scripts\cp\utility::vec_multiply(anglesToForward(var_1[0].angles), 64);
      if(!positionwouldtelefrag(var_6)) {
        var_2 = spawnStruct();
        var_2.origin = var_1[0].origin + var_6;
        var_2.angles = var_1[0].angles;
        break;
      }
    }

    wait(0.1);
  }

  if(isDefined(var_3) && scripts\engine\utility::istrue(var_3.in_use)) {
    var_3.in_use = undefined;
  }

  var_6 = getclosestpointonnavmesh(var_2.origin) + (0, 0, 5);
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_6);
  var_0 setplayerangles(var_2.angles);
  var_0.portal_end_origin = var_6;
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_6, var_2.angles);
}

portal_cooldown_monitor() {
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  while(!scripts\engine\utility::istrue(self.end_point.opened)) {
    wait(0.1);
  }

  var_0 = 0.1;
  for(;;) {
    if(self.cooldown > 0) {
      self.cooldown = self.cooldown - var_0;
      if(self.portal_scriptable getscriptablepartstate("portal") != "cooldown") {
        self.portal_scriptable setscriptablepartstate("portal", "cooldown");
      }
    } else {
      self.portal_scriptable setscriptablepartstate("portal", self.script_parameters);
    }

    if(self.cooldown < 0) {
      self.cooldown = 0;
    }

    wait(var_0);
  }
}

func_15B6() {
  level endon("game_ended");
  level thread turn_on_room_exit_portal();
  var_0 = scripts\engine\utility::getstruct("spawn_portal_fx", "script_noteworthy");
  var_1 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  level.pap_portal_scriptable = spawn("script_model", var_0.origin);
  level.pap_portal_scriptable setModel("prop_zm_scriptable_portal_fx_final");
  level.pap_portal_scriptable.angles = var_0.angles;
  for(;;) {
    level.var_8E61 = 1;
    turn_on_exit_portal_fx(1);
    level waittill("hidden_room_portal_used");
    wait(30);
    level.pap_portal_scriptable func_F556();
    var_1.cooling_down = 1;
    level.var_8E61 = 0;
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_start");
    turn_on_exit_portal_fx(0);
    thread pappenaltyspawn();
    wait(60);
    level.pap_portal_scriptable func_F28A();
    var_1.cooling_down = undefined;
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_over");
  }
}

pappenaltyspawn() {
  if(scripts\engine\utility::istrue(level.spawned_phantom)) {
    if(randomint(100) < 25) {
      var_0 = [(3140, 6164, 134), (3204, 6442, 195), (3466, 6567, 227), (2887, 6395, 189), (3406, 6507, 227)];
      var_1 = scripts\engine\utility::random(var_0);
      if(!positionwouldtelefrag(var_1)) {
        var_2 = scripts\engine\utility::getclosest(var_1, level.players);
        var_3 = spawnStruct();
        var_3.origin = var_1;
        var_3.angles = anglesToForward(var_2.origin - var_1);
        var_4 = var_3 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
        if(!isDefined(var_4)) {
          thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_2.weaponisauto);
        }
      }
    } else {
      thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single();
    }

    return;
  }

  var_0 = [(3140, 6164, 134), (3204, 6442, 195), (3466, 6567, 227), (2887, 6395, 189), (3406, 6507, 227)];
  var_1 = scripts\engine\utility::random(var_0);
  var_2 = scripts\engine\utility::getclosest(var_1, level.players);
  if(!positionwouldtelefrag(var_1)) {
    var_3 = spawnStruct();
    var_3.origin = var_1;
    var_3.angles = anglesToForward(var_2.origin - var_1);
    var_4 = var_3 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
    if(isDefined(var_4)) {
      level.spawned_phantom = 1;
      return;
    }

    thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_2.weaponisauto);
    return;
  }

  thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_2.weaponisauto);
}

turn_on_exit_portal_fx(var_0) {
  if(var_0) {
    level.pap_portal_scriptable setscriptablepartstate("portal", "active");
    return;
  }

  level.pap_portal_scriptable setscriptablepartstate("portal", "powered_on");
}

turn_on_room_exit_portal() {
  var_0 = scripts\engine\utility::getstruct("hidden_room_portal", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1.angles = var_0.angles;
  var_2 = anglesToForward(var_0.angles);
  level.pap_room_portal = spawnfx(level._effect["vfx_pap_return_portal"], var_0.origin, var_2);
  wait(1);
  triggerfx(level.pap_room_portal);
  teleport_from_hidden_room_before_time_up(var_1);
}

teleport_from_hidden_room_before_time_up(var_0) {
  var_0 makeusable();
  var_0 sethintstring(&"CP_FINAL_INTERACTIONS_EXIT_PAP_ROOM");
  var_0.portal_is_open = 1;
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!isDefined(var_1.kicked_out)) {
      var_1 notify("left_hidden_room_early");
      var_1.disable_consumables = 1;
      hidden_room_exit_tube(var_1);
    }

    wait(0.1);
  }
}

teleport_to_hidden_room() {
  self endon("left_hidden_room_early");
  var_0 = scripts\engine\utility::getStructArray("pap_spawners", "targetname");
  move_player_through_pap_tube(self, var_0);
  self playershow();
  scripts\cp\utility::adddamagemodifier("papRoom", 0, 0);
  self.is_off_grid = 1;
  self.disable_consumables = undefined;
  scripts\cp\powers\coop_powers::power_enablepower();
  set_in_pap_room(self, 1);
  thread hidden_room_timer();
  level notify("hidden_room_portal_used");
}

pap_timer_start() {
  self endon("disconnect");
  if(!isDefined(self.pap_timer_running)) {
    self.pap_timer_running = 1;
    var_0 = 30;
    self setclientomnvar("zombie_papTimer", var_0);
    wait(1);
    for(;;) {
      var_0--;
      if(var_0 < 0) {
        var_0 = 30;
        wait(1);
        break;
      }

      self setclientomnvar("zombie_papTimer", var_0);
      wait(1);
    }

    self setclientomnvar("zombie_papTimer", -1);
    self notify("kicked_out");
    wait(30);
    self.pap_timer_running = undefined;
  }
}

hidden_room_timer() {
  self endon("left_hidden_room_early");
  self endon("disconnect");
  self endon("last_stand");
  self.kicked_out = undefined;
  thread pap_timer_start();
  level thread pap_vo(self);
  self waittill("kicked_out");
  self.kicked_out = 1;
  level thread hidden_room_exit_tube(self);
}

hidden_room_exit_tube(var_0) {
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_1 = move_through_tube(var_0, "hidden_travel_tube_end", "hidden_travel_tube_start", 1);
  scripts\engine\utility::getstruct("pap_portal", "script_noteworthy") teleport_to_safe_spot(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_1 delete();
  if(scripts\engine\utility::istrue(var_0.wor_phase_shift)) {
    var_0 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    var_0.wor_phase_shift = 0;
  }

  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0 set_in_pap_room(var_0, 0);
  var_0 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

reduce_reserved_post_death() {
  self waittill("death");
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

teleport_to_safe_spot(var_0) {
  var_1 = undefined;
  while(!isDefined(var_1)) {
    foreach(var_3 in self.end_positions) {
      if(!positionwouldtelefrag(var_3.origin)) {
        var_1 = var_3;
      }
    }

    if(!isDefined(var_1)) {
      var_5 = scripts\cp\utility::vec_multiply(anglesToForward(self.end_positions[0].angles, 64));
      var_1 = self.end_positions[0].origin + var_5;
    }

    wait(0.1);
  }

  var_0 playershow();
  var_0 unlink();
  var_0 dontinterpolate();
  var_0 setorigin(var_1.origin);
  var_0 setplayerangles(var_1.angles);
  var_0.disable_consumables = undefined;
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("portal_exit", "zmb_comment_vo");
}

set_in_pap_room(var_0, var_1) {
  var_0.is_in_pap = var_1;
}

pap_vo(var_0) {
  if(level.pap_firsttime != 1) {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "zmb_pap_vo");
  }

  level.pap_firsttime = 1;
  var_0 endon("disconnect");
  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
}

refresh_piccadilly_civs_array() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.last_interaction_point) && var_1.last_interaction_point == self) {
      var_1 scripts\cp\cp_interaction::refresh_interaction();
    }
  }
}

func_F556() {
  self setscriptablepartstate("portal", "powered_on");
}

func_F28A() {
  self setscriptablepartstate("portal", "active");
}

run_fast_travel_logic(var_0, var_1) {
  if(!var_1 scripts\cp\utility::isteleportenabled()) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::flag("disable_portals")) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_2 = 0;
  if(var_1 scripts\cp\cp_persistence::player_has_enough_currency(var_2)) {
    var_1 scripts\cp\cp_interaction::take_player_money(var_2, "fast_travel");
    var_1 thread disable_teleportation(var_1, 0.5, "fast_travel_complete");
    var_0 thread travel_through_hidden_tube(var_1);
  }
}

disable_teleportation(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 scripts\cp\utility::allow_player_teleport(0);
  var_0 waittill(var_2);
  wait(var_1);
  if(!var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(1);
  }

  var_0 notify("can_teleport");
}

travel_through_hidden_tube(var_0) {
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0 notify("delete_equipment");
  var_0.disable_consumables = 1;
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_0 teleport_to_hidden_room();
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
}

move_player_through_pap_tube(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 scripts\cp\powers\coop_powers::power_disablepower();
  var_0.disable_consumables = 1;
  var_0.isfasttravelling = 1;
  var_0 getrigindexfromarchetyperef();
  var_0 notify("delete_equipment");
  var_0 notify("cancel_trap");
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_2 = move_through_tube(var_0, "hidden_travel_tube_start", "hidden_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + 10;
  }

  teleport_to_portal_safe_spot(var_0, var_1);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_2 delete();
  var_0 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  var_0.is_off_grid = undefined;
  var_0.kicked_out = undefined;
  var_0.isfasttravelling = undefined;
  var_0.disable_consumables = undefined;
  var_0 notify("fast_travel_complete");
  var_0 scripts\cp\powers\coop_powers::power_enablepower();
  var_0 thread update_personal_ents_after_delay();
  if(var_0.vo_prefix == "p5_") {
    var_0 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}