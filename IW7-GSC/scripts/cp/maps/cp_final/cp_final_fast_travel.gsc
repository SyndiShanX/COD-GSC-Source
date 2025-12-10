/*************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_fast_travel.gsc
*************************************************************/

init_teleport_portals() {
  level._effect["death_ray_cannon_beam"] = loadfx("vfx\iw7\levels\cp_town\death_ray_cannon_beam.vfx");
  level._effect["death_ray_cannon_rock_impact"] = loadfx("vfx\iw7\levels\cp_final\rhino\vfx_metal_impact.vfx");
  level._effect["portal_glyph"] = loadfx("vfx\iw7\levels\cp_final\portal\vfx_portal_symbol_1.vfx");
  level._effect["vfx_pap_return_portal"] = loadfx("vfx\iw7\levels\cp_disco\vfx_paproom_portal.vfx");
  wait(5);
  var_00 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread trigger_when_player_close_by();
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
  var_00 = scripts\engine\utility::getstructarray("portal_console", "script_noteworthy");
  foreach(var_02 in var_00) {
    level thread stand_on_glyph(var_02);
  }
}

portal_console_hint_func(param_00, param_01) {
  return "";
}

portal_console_activate_func(param_00, param_01) {}

stand_on_glyph(param_00) {
  var_01 = scripts\engine\utility::getstructarray("fast_travel_portal_symbol", "targetname");
  var_02 = scripts\engine\utility::getclosest(param_00.origin, var_01, 500);
  if(!isDefined(var_02)) {
    return;
  }

  var_02.fx = spawnfx(level._effect["portal_glyph"], var_02.origin);
  wait(0.1);
  triggerfx(var_02.fx);
  var_03 = 0;
  var_04 = 100;
  var_05 = var_04 * var_04;
  while(!var_03) {
    foreach(var_07 in level.players) {
      if(distancesquared(var_07.origin, var_02.origin) < var_05) {
        var_03 = 1;
        break;
      }
    }

    wait(0.5);
  }

  var_09 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  var_0A = scripts\engine\utility::getclosest(param_00.origin, var_09, 500);
  var_0A.opened = 1;
  var_0A.end_point.opened = 1;
  var_02.fx delete();
}

trigger_when_player_close_by() {
  var_00 = getEntArray("fast_travel_portal_trigger", "targetname");
  self.trigger = scripts\engine\utility::getclosest(self.origin, var_00, 500);
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

  self.teleport_spots = scripts\engine\utility::getstructarray(self.end_point.target, "targetname");
  foreach(var_02 in self.teleport_spots) {
    if(!isDefined(var_02.angles)) {
      var_02.angles = (0, 0, 0);
    }

    if(var_02.origin == (1792, 1886, 64)) {
      var_02.origin = (1752, 1918, 64);
    }
  }

  scripts\engine\utility::flag_wait("power_on");
  var_04 = scripts\engine\utility::getstructarray("fast_travel_portal_spot", "targetname");
  self.portal_spot = scripts\engine\utility::getclosest(self.origin, var_04, 500);
  self.portal_scriptable = spawn("script_model", self.portal_spot.origin + (0, 0, 53));
  self.portal_scriptable setModel("tag_origin_final_portal");
  self.portal_scriptable.angles = self.angles;
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  thread portal_cooldown_monitor();
  wait_for_portal_doors_open();
  self.last_time_player_used = gettime();
  wait(1);
  for(;;) {
    self.trigger waittill("trigger", var_05);
    if(scripts\engine\utility::istrue(var_05.inlaststand)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(!isplayer(var_05)) {
      if(self.last_time_player_used + 5000 > gettime()) {
        if(!isDefined(var_05.last_travel_time) || gettime() > var_05.last_travel_time + 10000) {
          thread move_zombie_through_portal_tube(var_05);
        }
      }

      scripts\engine\utility::waitframe();
      continue;
    }

    var_06 = anglesToForward(var_05.angles);
    if(vectordot(vectornormalize(self.portal_spot.origin - var_05.origin), var_06) < 0.66) {
      scripts\engine\utility::waitframe();
      continue;
    }

    toggleplayerlocation(var_05, self);
    if(self.end_point.opened && self.cooldown <= 0) {
      self.end_point.cooldown = self.end_point.cooldown + 10;
      thread send_followers_through_tube(var_05);
      self.last_time_player_used = gettime();
      move_player_through_portal_tube(var_05);
      if(!scripts\engine\utility::istrue(level.used_portal)) {
        scripts\cp\maps\cp_final\cp_final::setup_era_zombie_model_list();
      }

      level.used_portal = 1;
      if(isDefined(self.end_point_name)) {
        if(self.end_point_name == "theater") {
          var_05 scripts\cp\zombies\achievement::update_achievement("DOUBLE_FEATURE", 1);
        }
      }

      activate_room_after_portal_use(self.end_point_name);
    }

    wait(0.1);
  }
}

toggleplayerlocation(param_00, param_01) {
  if(isDefined(param_01.end_point_name)) {
    if(param_01.end_point_name == "theater" || param_01.end_point_name == "left_alley" || param_01.end_point_name == "theater_front") {
      param_00.currentlocation = "theater";
      return;
    }

    param_00.currentlocation = "facility";
  }
}

activate_room_after_portal_use(param_00) {
  switch (param_00) {
    case "theater":
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name("theater_main");
      if(!scripts\engine\utility::istrue(level.theater_open)) {
        foreach(var_02 in level.players) {
          var_02 scripts\cp\cp_merits::processmerit("mt_dlc4_theater_open");
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
  var_00 = getEntArray("center_portal_door_left", "targetname");
  var_01 = scripts\engine\utility::getclosest(self.origin, var_00, 500);
  if(isDefined(var_01)) {
    var_02 = scripts\engine\utility::getstructarray("center_portal_door_left_pos", "targetname");
    var_03 = scripts\engine\utility::getclosest(self.origin, var_02, 500);
    if(isDefined(var_03)) {
      var_04 = var_03.origin - var_01.origin;
      var_05 = scripts\cp\utility::vec_multiply(var_04, 0.2) + var_01.origin;
      var_01 moveto(var_05, 0.5, 0.1, 0.1);
    }
  }

  var_06 = getEntArray("center_portal_door_right", "targetname");
  var_07 = scripts\engine\utility::getclosest(self.origin, var_06, 500);
  if(isDefined(var_07)) {
    var_02 = scripts\engine\utility::getstructarray("center_portal_door_right_pos", "targetname");
    var_03 = scripts\engine\utility::getclosest(self.origin, var_02, 500);
    if(isDefined(var_03)) {
      var_04 = var_03.origin - var_07.origin;
      var_05 = scripts\cp\utility::vec_multiply(var_04, 0.2) + var_07.origin;
      var_07 moveto(var_05, 0.5, 0.1, 0.1);
    }
  }

  wait(0.5);
}

open_portal_doors() {
  var_00 = getEntArray("portal_door_left", "targetname");
  var_01 = scripts\engine\utility::getclosest(self.origin, var_00, 500);
  if(isDefined(var_01)) {
    var_02 = scripts\engine\utility::getstructarray("portal_door_left_pos", "targetname");
    var_03 = scripts\engine\utility::getclosest(self.origin, var_02, 500);
    var_01 moveto(var_03.origin, 0.5, 0.1, 0.1);
  }

  var_04 = getEntArray("portal_door_right", "targetname");
  var_05 = scripts\engine\utility::getclosest(self.origin, var_04, 500);
  if(isDefined(var_05)) {
    var_02 = scripts\engine\utility::getstructarray("portal_door_right_pos", "targetname");
    var_03 = scripts\engine\utility::getclosest(self.origin, var_02, 500);
    var_05 moveto(var_03.origin, 0.5, 0.1, 0.1);
  }

  wait(0.5);
}

blast_doors_with_gun() {
  level.portal_gun_activated = 0;
  while(!scripts\engine\utility::istrue(level.portal_gun_init_done)) {
    wait(0.1);
  }

  var_00 = "death_ray_cannon_beam";
  var_01 = "tag_origin_laser_ray_fx";
  var_02 = "death_ray_cannon_rock_impact";
  var_03 = scripts\engine\utility::getstructarray("gun_barrel", "targetname");
  var_03 = level.portal_gun.barrel_ents;
  while(!level.portal_gun_activated) {
    wait(0.1);
  }

  wait(1);
  foreach(var_05 in var_03) {
    var_06 = spawn("script_model", var_05.origin);
    var_06.angles = var_05.angles;
    var_06 setModel(var_01);
    var_05.fx_spot = var_06;
  }

  wait(1);
  var_08 = (1745, 1827, 68);
  foreach(var_05 in var_03) {
    if(!isDefined(var_05.angles)) {
      var_05.angles = (0, 0, 0);
    }

    playfxbetweenpoints(level._effect[var_00], var_05.origin, var_05.angles, var_08);
  }

  playsoundatpos(level.portal_gun.origin, "zmb_railgun_fire");
  wait(0.1);
  foreach(var_05 in var_03) {
    var_05.fx_spot delete();
  }

  playFX(level._effect[var_02], var_08);
  var_0D = undefined;
  var_0E = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_10 in var_0E) {
    if(var_10.script_noteworthy == "cargo_room") {
      var_0D = var_10;
    }
  }

  if(isDefined(var_0D)) {
    var_0D.opened = 1;
    var_0D.end_point.opened = 1;
  }

  var_12 = getEntArray("center_portal_door_left", "targetname");
  var_13 = scripts\engine\utility::getclosest(var_03[0].origin, var_12, 1000);
  var_13 delete();
  var_12 = getEntArray("center_portal_door_right", "targetname");
  var_13 = scripts\engine\utility::getclosest(var_03[0].origin, var_12, 1000);
  var_13 delete();
}

debug_portal_door_open() {
  for(;;) {
    if(getdvarint("scr_open_portals") != 0) {
      break;
    }

    wait(1);
  }

  var_00 = scripts\engine\utility::getstructarray("fast_travel_portal", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.portal_spot)) {
      var_02.opened = 1;
    }
  }
}

portal_gun_init_func(param_00, param_01) {
  level.portal_gun_activated = 0;
  level.portal_gun = getent("portal_gun", "targetname");
  var_02 = scripts\engine\utility::getstruct("portal_gun_cargo_pos", "targetname");
  level.portal_gun.start_pos = level.portal_gun.origin;
  level.portal_gun.var_10B9F = level.portal_gun.angles;
  level.portal_gun.var_62EE = var_02.origin;
  level.portal_gun.end_ang = var_02.angles;
  level.portal_gun_crane = getent("laser_cannon_crane", "targetname");
  var_02 = scripts\engine\utility::getstruct("laser_cannon_crane_cargo_pos", "targetname");
  level.portal_gun_crane.start_pos = level.portal_gun_crane.origin;
  level.portal_gun_crane.var_10B9F = level.portal_gun_crane.angles;
  level.portal_gun_crane.var_62EE = var_02.origin;
  level.portal_gun_crane.end_ang = var_02.angles;
  wait(5);
  var_03 = scripts\engine\utility::getstructarray("gun_barrel", "targetname");
  level.portal_gun.barrel_ents = [];
  foreach(var_05 in var_03) {
    var_06 = spawn("script_origin", var_05.origin);
    wait(0.5);
    var_06.angles = var_05.angles;
    level.portal_gun.barrel_ents[level.portal_gun.barrel_ents.size] = var_06;
    var_06 linkto(level.portal_gun);
  }

  level.portal_gun_init_done = 1;
}

portal_gun_hint_func(param_00, param_01) {
  return "";
}

portal_gun_activate_func(param_00, param_01) {
  if(scripts\engine\utility::flag("power_on")) {
    var_02 = getent("portal_gun_button", "targetname");
    var_02 setModel("mp_frag_button_on_green");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
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

play_move_sounds(param_00) {
  var_01 = lookupsoundlength("zmb_cannon_platform_start") / 1000;
  var_02 = lookupsoundlength("zmb_cannon_platform_stop") / 1000;
  var_03 = param_00 - var_01 - var_02;
  self playsoundonmovingent("zmb_cannon_platform_start");
  wait(var_01);
  scripts\cp\utility::play_looping_sound_on_ent("zmb_cannon_platform_loop");
  wait(var_03);
  scripts\cp\utility::stop_looping_sound_on_ent("zmb_cannon_platform_loop");
  self playsoundonmovingent("zmb_cannon_platform_stop");
}

send_followers_through_tube(param_00) {
  var_01 = level.spawned_enemies;
  var_02 = param_00.origin;
  var_03 = 500;
  var_04 = var_03 * var_03;
  foreach(var_06 in var_01) {
    if(isDefined(var_06.myenemy) && var_06.myenemy == param_00) {
      if(distancesquared(var_06.origin, var_02) < var_04) {
        thread send_to_portal(var_06);
      }

      continue;
    }

    if(isDefined(var_06.isnodeoccupied) && var_06.isnodeoccupied == param_00) {
      if(distancesquared(var_06.origin, var_02) < var_04) {
        thread send_to_portal(var_06);
      }
    }
  }
}

send_to_portal(param_00) {
  param_00 endon("death");
  param_00 endon("portal_timed_out");
  param_00.scripted_mode = 1;
  param_00.sent_to_portal = 1;
  var_01 = getclosestpointonnavmesh(self.trigger.origin);
  param_00 ghostskulls_complete_status(var_01);
  level thread stop_trying_to_go_through_portal(param_00, 5);
  param_00 waittill("goal_reached");
  param_00 ghostskulls_complete_status(param_00.origin);
}

stop_trying_to_go_through_portal(param_00, param_01) {
  param_00 endon("death");
  wait(param_01);
  param_00.sent_to_portal = undefined;
  param_00.scripted_mode = 0;
  param_00 notify("portal_timed_out");
  param_00 ghostskulls_complete_status(param_00.origin);
}

turn_on_portal() {
  self.portal_scriptable setscriptablepartstate("portal", "active");
}

move_player_through_portal_tube(param_00) {
  param_00 endon("disconnect");
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.disable_consumables = 1;
  param_00.isfasttravelling = 1;
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_01 = move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  self.cooldown = self.cooldown + 10;
  teleport_to_portal_safe_spot(param_00);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_01 delete();
  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00.isfasttravelling = undefined;
  param_00 notify("fast_travel_complete");
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 thread update_personal_ents_after_delay();
}

move_zombie_through_portal_tube(param_00) {
  if(scripts\engine\utility::istrue(param_00.var_11B2F)) {
    return;
  }

  param_00.isfasttravelling = 1;
  param_00.last_travel_time = gettime();
  var_01 = ai_move_through_tube(param_00, "fast_travel_tube_start", "fast_travel_tube_end", 1);
  teleport_ai_to_portal_safe_spot(param_00);
  wait(0.1);
  if(isDefined(var_01)) {
    var_01 delete();
  }

  param_00.scripted_mode = 0;
  param_00.isfasttravelling = undefined;
}

move_through_tube(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("move_through_tube");
  param_00 earthquakeforplayer(0.3, 0.2, param_00.origin, 200);
  var_04 = getent(param_01, "targetname");
  var_05 = getent(param_02, "targetname");
  param_00 cancelmantle();
  param_00.no_outline = 1;
  param_00.no_team_outlines = 1;
  var_06 = var_04.origin + (0, 0, -45);
  var_07 = var_05.origin + (0, 0, -45);
  param_00.is_fast_traveling = 1;
  param_00 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  param_00 scripts\cp\utility::allow_player_ignore_me(1);
  param_00 dontinterpolate();
  param_00 setorigin(var_06);
  param_00 setplayerangles(var_04.angles);
  param_00 playlocalsound("zmb_portal_travel_lr");
  var_08 = spawn("script_origin", var_06);
  param_00 playerlinkto(var_08);
  param_00 getweaponrankxpmultiplier();
  wait(0.1);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  var_08 moveto(var_07, 1);
  wait(1);
  param_00.is_fast_traveling = undefined;
  param_00 scripts\cp\utility::removedamagemodifier("fast_travel", 0);
  if(param_00 scripts\cp\utility::isignoremeenabled()) {
    param_00 scripts\cp\utility::allow_player_ignore_me(0);
  }

  param_00.is_fast_traveling = undefined;
  param_00.no_outline = 0;
  param_00.no_team_outlines = 0;
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  return var_08;
}

ai_move_through_tube(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("move_through_tube");
  var_04 = getent(param_01, "targetname");
  var_05 = getent(param_02, "targetname");
  param_00.no_outline = 1;
  param_00.no_team_outlines = 1;
  var_06 = var_04.origin + (0, 0, -45);
  var_07 = var_05.origin + (0, 0, -45);
  param_00.is_fast_traveling = 1;
  param_00 scripts\cp\utility::adddamagemodifier("fast_travel", 0, 0);
  param_00 dontinterpolate();
  param_00 setorigin(var_06);
  param_00 setplayerangles(var_04.angles);
  var_08 = spawn("script_origin", var_06);
  param_00 linkto(var_08);
  wait(0.1);
  var_08 moveto(var_07, 1);
  wait(1);
  param_00.is_fast_traveling = undefined;
  param_00.is_fast_traveling = undefined;
  param_00.no_outline = 0;
  param_00.no_team_outlines = 0;
  param_00.sent_to_portal = undefined;
  param_00.scripted_mode = 0;
  return var_08;
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

teleport_to_portal_safe_spot(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = self.teleport_spots;
  }

  var_03 = undefined;
  while(!isDefined(var_03)) {
    foreach(var_05 in var_02) {
      if(!positionwouldtelefrag(var_05.origin)) {
        var_03 = var_05;
      }
    }

    if(!isDefined(var_03)) {
      if(!isDefined(var_02[0].angles)) {
        var_02[0].angles = (0, 0, 0);
      }

      var_07 = scripts\cp\utility::vec_multiply(anglesToForward(var_02[0].angles), 64);
      var_03 = spawnStruct();
      var_03.origin = var_02[0].origin + var_07;
      var_03.angles = var_02[0].angles;
    }

    wait(0.1);
  }

  param_00 playershow();
  if(scripts\engine\utility::istrue(param_00.isrewinding) || isDefined(self.rewindmover)) {
    param_00 thread unlinkplayerafterduration();
  } else {
    param_00 unlink();
  }

  param_00 dontinterpolate();
  param_00 setorigin(var_03.origin);
  param_00 setplayerangles(var_03.angles);
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00.portal_end_origin = var_03.origin;
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_03.origin, var_03.angles);
}

teleport_ai_to_portal_safe_spot(param_00) {
  var_01 = scripts\engine\utility::array_randomize(self.teleport_spots);
  var_02 = undefined;
  var_03 = undefined;
  while(!isDefined(var_02)) {
    foreach(var_03 in var_01) {
      if(!scripts\engine\utility::istrue(var_03.in_use)) {
        if(!positionwouldtelefrag(var_03.origin)) {
          var_02 = var_03;
          var_03.in_use = 1;
          break;
        }
      }
    }

    if(!isDefined(var_02)) {
      if(!isDefined(var_01[0].angles)) {
        var_01[0].angles = (0, 0, 0);
      }

      var_06 = scripts\cp\utility::vec_multiply(anglesToForward(var_01[0].angles), 64);
      if(!positionwouldtelefrag(var_06)) {
        var_02 = spawnStruct();
        var_02.origin = var_01[0].origin + var_06;
        var_02.angles = var_01[0].angles;
        break;
      }
    }

    wait(0.1);
  }

  if(isDefined(var_03) && scripts\engine\utility::istrue(var_03.in_use)) {
    var_03.in_use = undefined;
  }

  var_06 = getclosestpointonnavmesh(var_02.origin) + (0, 0, 5);
  param_00 unlink();
  param_00 dontinterpolate();
  param_00 setorigin(var_06);
  param_00 setplayerangles(var_02.angles);
  param_00.portal_end_origin = var_06;
  playFX(level._effect["vfx_zmb_portal_exit_burst"], var_06, var_02.angles);
}

portal_cooldown_monitor() {
  self.portal_scriptable setscriptablepartstate("portal", "cooldown");
  while(!scripts\engine\utility::istrue(self.end_point.opened)) {
    wait(0.1);
  }

  var_00 = 0.1;
  for(;;) {
    if(self.cooldown > 0) {
      self.cooldown = self.cooldown - var_00;
      if(self.portal_scriptable getscriptablepartstate("portal") != "cooldown") {
        self.portal_scriptable setscriptablepartstate("portal", "cooldown");
      }
    } else {
      self.portal_scriptable setscriptablepartstate("portal", self.script_parameters);
    }

    if(self.cooldown < 0) {
      self.cooldown = 0;
    }

    wait(var_00);
  }
}

func_15B6() {
  level endon("game_ended");
  level thread turn_on_room_exit_portal();
  var_00 = scripts\engine\utility::getstruct("spawn_portal_fx", "script_noteworthy");
  var_01 = scripts\engine\utility::getstruct("pap_portal", "script_noteworthy");
  level.pap_portal_scriptable = spawn("script_model", var_00.origin);
  level.pap_portal_scriptable setModel("prop_zm_scriptable_portal_fx_final");
  level.pap_portal_scriptable.angles = var_00.angles;
  for(;;) {
    level.var_8E61 = 1;
    turn_on_exit_portal_fx(1);
    level waittill("hidden_room_portal_used");
    wait(30);
    level.pap_portal_scriptable func_F556();
    var_01.cooling_down = 1;
    level.var_8E61 = 0;
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_start");
    turn_on_exit_portal_fx(0);
    thread pappenaltyspawn();
    wait(60);
    level.pap_portal_scriptable func_F28A();
    var_01.cooling_down = undefined;
    level.var_8E63 = 1;
    level notify("hidden_room_portal_cooldown_over");
  }
}

pappenaltyspawn() {
  if(scripts\engine\utility::istrue(level.spawned_phantom)) {
    if(randomint(100) < 25) {
      var_00 = [(3140, 6164, 134), (3204, 6442, 195), (3466, 6567, 227), (2887, 6395, 189), (3406, 6507, 227)];
      var_01 = scripts\engine\utility::random(var_00);
      if(!positionwouldtelefrag(var_01)) {
        var_02 = scripts\engine\utility::getclosest(var_01, level.players);
        var_03 = spawnStruct();
        var_03.origin = var_01;
        var_03.angles = anglesToForward(var_02.origin - var_01);
        var_04 = var_03 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
        if(!isDefined(var_04)) {
          thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.weaponisauto);
        }
      }
    } else {
      thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single();
    }

    return;
  }

  var_00 = [(3140, 6164, 134), (3204, 6442, 195), (3466, 6567, 227), (2887, 6395, 189), (3406, 6507, 227)];
  var_01 = scripts\engine\utility::random(var_00);
  var_02 = scripts\engine\utility::getclosest(var_01, level.players);
  if(!positionwouldtelefrag(var_01)) {
    var_03 = spawnStruct();
    var_03.origin = var_01;
    var_03.angles = anglesToForward(var_02.origin - var_01);
    var_04 = var_03 scripts\cp\zombies\cp_final_spawning::spawn_brute_wave_enemy("alien_phantom");
    if(isDefined(var_04)) {
      level.spawned_phantom = 1;
      return;
    }

    thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.weaponisauto);
    return;
  }

  thread scripts\cp\maps\cp_final\cp_final_mpq::trigger_goon_event_single(var_02.weaponisauto);
}

turn_on_exit_portal_fx(param_00) {
  if(param_00) {
    level.pap_portal_scriptable setscriptablepartstate("portal", "active");
    return;
  }

  level.pap_portal_scriptable setscriptablepartstate("portal", "powered_on");
}

turn_on_room_exit_portal() {
  var_00 = scripts\engine\utility::getstruct("hidden_room_portal", "targetname");
  var_01 = spawn("script_model", var_00.origin);
  var_01 setModel("tag_origin");
  var_01.angles = var_00.angles;
  var_02 = anglesToForward(var_00.angles);
  level.pap_room_portal = spawnfx(level._effect["vfx_pap_return_portal"], var_00.origin, var_02);
  wait(1);
  triggerfx(level.pap_room_portal);
  teleport_from_hidden_room_before_time_up(var_01);
}

teleport_from_hidden_room_before_time_up(param_00) {
  param_00 makeusable();
  param_00 sethintstring(&"CP_FINAL_INTERACTIONS_EXIT_PAP_ROOM");
  param_00.portal_is_open = 1;
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(!isDefined(var_01.kicked_out)) {
      var_01 notify("left_hidden_room_early");
      var_01.disable_consumables = 1;
      hidden_room_exit_tube(var_01);
    }

    wait(0.1);
  }
}

teleport_to_hidden_room() {
  self endon("left_hidden_room_early");
  var_00 = scripts\engine\utility::getstructarray("pap_spawners", "targetname");
  move_player_through_pap_tube(self, var_00);
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
    var_00 = 30;
    self setclientomnvar("zombie_papTimer", var_00);
    wait(1);
    for(;;) {
      var_00--;
      if(var_00 < 0) {
        var_00 = 30;
        wait(1);
        break;
      }

      self setclientomnvar("zombie_papTimer", var_00);
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

hidden_room_exit_tube(param_00) {
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_01 = move_through_tube(param_00, "hidden_travel_tube_end", "hidden_travel_tube_start", 1);
  scripts\engine\utility::getstruct("pap_portal", "script_noteworthy") teleport_to_safe_spot(param_00);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_01 delete();
  if(scripts\engine\utility::istrue(param_00.wor_phase_shift)) {
    param_00 scripts\cp\powers\coop_phaseshift::exitphaseshift(1);
    param_00.wor_phase_shift = 0;
  }

  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00 set_in_pap_room(param_00, 0);
  param_00 notify("fast_travel_complete");
  scripts\cp\cp_vo::remove_from_nag_vo("ww_pap_nag");
  scripts\cp\cp_vo::remove_from_nag_vo("nag_find_pap");
}

reduce_reserved_post_death() {
  self waittill("death");
  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(1);
}

teleport_to_safe_spot(param_00) {
  var_01 = undefined;
  while(!isDefined(var_01)) {
    foreach(var_03 in self.end_positions) {
      if(!positionwouldtelefrag(var_03.origin)) {
        var_01 = var_03;
      }
    }

    if(!isDefined(var_01)) {
      var_05 = scripts\cp\utility::vec_multiply(anglesToForward(self.end_positions[0].angles, 64));
      var_01 = self.end_positions[0].origin + var_05;
    }

    wait(0.1);
  }

  param_00 playershow();
  param_00 unlink();
  param_00 dontinterpolate();
  param_00 setorigin(var_01.origin);
  param_00 setplayerangles(var_01.angles);
  param_00.disable_consumables = undefined;
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("portal_exit", "zmb_comment_vo");
}

set_in_pap_room(param_00, param_01) {
  param_00.is_in_pap = param_01;
}

pap_vo(param_00) {
  if(level.pap_firsttime != 1) {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("pap_room_first", "zmb_pap_vo");
  }

  level.pap_firsttime = 1;
  param_00 endon("disconnect");
  wait(4);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_pap_nag", "zmb_pap_vo", "high", undefined, undefined, undefined, 1);
}

refresh_piccadilly_civs_array() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01.last_interaction_point) && var_01.last_interaction_point == self) {
      var_01 scripts\cp\cp_interaction::refresh_interaction();
    }
  }
}

func_F556() {
  self setscriptablepartstate("portal", "powered_on");
}

func_F28A() {
  self setscriptablepartstate("portal", "active");
}

run_fast_travel_logic(param_00, param_01) {
  if(!param_01 scripts\cp\utility::isteleportenabled()) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  if(scripts\engine\utility::flag("disable_portals")) {
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_02 = 0;
  if(param_01 scripts\cp\cp_persistence::player_has_enough_currency(var_02)) {
    param_01 scripts\cp\cp_interaction::take_player_money(var_02, "fast_travel");
    param_01 thread disable_teleportation(param_01, 0.5, "fast_travel_complete");
    param_00 thread travel_through_hidden_tube(param_01);
  }
}

disable_teleportation(param_00, param_01, param_02) {
  param_00 endon("death");
  param_00 scripts\cp\utility::allow_player_teleport(0);
  param_00 waittill(param_02);
  wait(param_01);
  if(!param_00 scripts\cp\utility::isteleportenabled()) {
    param_00 scripts\cp\utility::allow_player_teleport(1);
  }

  param_00 notify("can_teleport");
}

travel_through_hidden_tube(param_00) {
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00 notify("delete_equipment");
  param_00.disable_consumables = 1;
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  param_00 teleport_to_hidden_room();
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
}

move_player_through_pap_tube(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 scripts\cp\powers\coop_powers::power_disablepower();
  param_00.disable_consumables = 1;
  param_00.isfasttravelling = 1;
  param_00 getrigindexfromarchetyperef();
  param_00 notify("delete_equipment");
  param_00 notify("cancel_trap");
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_02 = move_through_tube(param_00, "hidden_travel_tube_start", "hidden_travel_tube_end");
  if(isDefined(self.cooldown)) {
    self.cooldown = self.cooldown + 10;
  }

  teleport_to_portal_safe_spot(param_00, param_01);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
  wait(0.1);
  var_02 delete();
  param_00 scripts\cp\utility::removedamagemodifier("papRoom", 0);
  param_00.is_off_grid = undefined;
  param_00.kicked_out = undefined;
  param_00.isfasttravelling = undefined;
  param_00.disable_consumables = undefined;
  param_00 notify("fast_travel_complete");
  param_00 scripts\cp\powers\coop_powers::power_enablepower();
  param_00 thread update_personal_ents_after_delay();
  if(param_00.vo_prefix == "p5_") {
    param_00 thread scripts\cp\cp_vo::try_to_play_vo("fasttravel_exit", "town_comment_vo");
  }
}