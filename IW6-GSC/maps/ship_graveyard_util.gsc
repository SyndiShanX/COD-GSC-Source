/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ship_graveyard_util.gsc
****************************************/

player_panic_bubbles() {
  if(isalive(self)) {
    if(isDefined(self.playerfxorg))
      playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_panic"), self.playerfxorg, "tag_origin");
  }
}

keep_player_below_surface() {
  level endon("end_swimming");
  common_scripts\utility::flag_wait("start_swim");
  var_0 = 0.0;
  var_1 = getdvarfloat("player_swimVerticalSpeed", 95.0) * 2.5;
  var_2 = var_1 * 25;

  for(;;) {
    if(level.water_level_z - level.player.origin[2] < 128) {
      if(var_0 > -1 * var_2) {
        level.water_current = level.water_current - (0, 0, var_1);
        var_3 = level.water_current[0] + " " + level.water_current[1] + " " + level.water_current[2];
        setsaveddvar("player_swimWaterCurrent", var_3);
        var_0 = var_0 - var_1;
      }
    } else if(var_0 < 0) {
      level.water_current = level.water_current + (0, 0, var_1);
      var_0 = var_0 + var_1;

      if(var_0 > -0.01) {
        level.water_current = level.water_current - (0, 0, var_0);
        var_0 = 0;
      }

      var_3 = level.water_current[0] + " " + level.water_current[1] + " " + level.water_current[2];
      setsaveddvar("player_swimWaterCurrent", var_3);
    }

    wait 0.05;
  }
}

read_parameters() {
  if(isDefined(self.script_moveplaybackrate)) {
    self.moveplaybackrate = self.script_moveplaybackrate;
    self.movetransitionrate = self.moveplaybackrate;
  }
}

teleport_to_target() {
  var_0 = common_scripts\utility::get_target_ent();

  if(!isDefined(var_0.angles))
    var_0.angles = self.angles;

  self forceteleport(var_0.origin, var_0.angles);

  if(isDefined(var_0.target)) {
    var_0 = var_0 common_scripts\utility::get_target_ent();

    if(isDefined(var_0.script_animation))
      maps\ship_graveyard_stealth::stealth_idle(var_0, var_0.script_animation);
    else if(isDefined(var_0.script_idlereach))
      stealth_idle_reach(var_0);
    else
      maps\_utility::follow_path_and_animate(var_0, 0);
  }
}

stop_path_on_damage() {
  self endon("death");
  self endon("path_end_reached");
  thread break_from_path();
  self waittill("damage");
  common_scripts\utility::flag_set("stealth2_approach_guys_damaged");
}

break_from_path() {
  self endon("death");
  self endon("path_end_reached");
  common_scripts\utility::flag_wait("stealth2_approach_guys_damaged");
  self notify("stop_path");
  self setgoalentity(level.player);
}

stealth_idle_reach(var_0) {
  var_1 = var_0 maps\_utility::get_last_ent_in_chain("struct");
  self.goalradius = 128;
  self.goalheight = 128;
  maps\_utility::follow_path_and_animate(var_0, 0);
  maps\ship_graveyard_stealth::stealth_idle(var_1, var_1.script_animation);
}

boat_shoot_entity(var_0, var_1) {
  if(isDefined(var_1))
    level endon(var_1);

  self endon("death");
  self endon("stop_shooting");

  for(;;) {
    var_2 = (self.origin[0], self.origin[1], level.water_level_z);
    var_3 = 64 * anglesToForward(var_0.angles);

    if(isPlayer(var_0))
      var_4 = var_0 getEye() + var_3;
    else
      var_4 = var_0.origin + var_3;

    var_5 = anglestoright(self.angles);
    var_6 = vectordot(var_5, var_4 - self.origin);

    if(var_6 < 0)
      var_7 = common_scripts\utility::random([70, 90, 110]);
    else
      var_7 = common_scripts\utility::random([-70, -90, -110]);

    var_8 = 256;
    var_2 = var_2 + anglesToForward((0, var_7, 0)) * var_8;
    var_9 = randomintrange(5, 20);

    for(var_10 = 0; var_10 < var_9; var_10++) {
      var_11 = var_2 + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), 0);
      var_12 = var_4 + common_scripts\utility::randomvectorrange(-24, 24);
      var_13 = vectortoangles(var_12 - var_11);
      var_14 = anglestoup(var_13);
      var_15 = (90, 0, 0);
      playFX(common_scripts\utility::getfx("underwater_surface_splash_bullet"), (var_11[0], var_11[1], level.water_level_z - 1), anglesToForward(var_15), anglestoup(var_15));
      magicbullet("aps_underwater", var_11, var_12);
      wait(randomfloatrange(0.3, 0.4));
    }

    wait(randomfloatrange(2, 6));
  }
}

underwater_setup() {
  level.f_min = [];
  level.f_max = [];
  level.player.breathing_overlay = [];
  thread overlay_manage("gasmask_overlay", -98);
  thread overlay_manage("halo_overlay_scuba_steam", -100);
  level.f_min["halo_overlay_scuba_steam"] = 0.35;
  level.f_max["halo_overlay_scuba_steam"] = 0.95;
  level.player.breathing_overlay["halo_overlay_scuba_steam"].alpha = 1;
  common_scripts\utility::flag_wait("start_swim");
  level.baker thread maps\_swim_ai::enable_swim();
  playFXOnTag(common_scripts\utility::getfx("silt_ground_kickup_runner"), level.baker, "tag_origin");
  var_0 = getEntArray("marker_deleteme", "targetname");
  common_scripts\utility::array_call(var_0, ::delete);
  level.player maps\_swim_player::enable_player_swim();
  level.player thread maps\ship_graveyard_fx::water_particulates();
  setsaveddvar("glass_angular_vel", "1 5");
  setsaveddvar("glass_linear_vel", "20 40");
  setsaveddvar("glass_fall_gravity", 25);
  setsaveddvar("glass_simple_duration", 20000);
  setsaveddvar("bg_viewKickMax", 20);
  setsaveddvar("g_gravity", 30);
  setsaveddvar("sm_sunshadowscale", 0.65);
  setsaveddvar("sm_sunsamplesizeNear", 0.25);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("player_swimVerticalSpeed", 80);

  if(!is_demo_check())
    playFXOnTag(common_scripts\utility::getfx("vfx_scrnfx_water_distortion"), level.player.scubamask_distortion, "tag_origin");

  thread keep_player_below_surface();
  thread baker_killfirms();
  level.player thread shark_heartbeat();
  thread track_shark_flag();
  thread track_shark_warning();
  level.player thread player_get_closest_node();

  if(maps\_utility::is_gen4())
    maps\_art::dof_set_base(1, 200, 5, 700, 2500, 3, 0.0);
  else
    maps\_art::dof_set_base(0, 0, 5, 700, 2500, 3, 0.0);
}

track_shark_warning() {
  level endon("shark_eating_player");
  common_scripts\utility::flag_wait_either("shark_warn_player", "baker_warn_player");
  maps\_utility::smart_radio_dialogue("shipg_bkr_openwatersoutthere");
  wait 10;

  for(;;) {
    common_scripts\utility::flag_wait("shark_warn_player");
    maps\_utility::smart_radio_dialogue("shipg_bkr_wandering");
    wait 10;

    if(common_scripts\utility::flag("shark_warn_player"))
      childthread shark_eat_wandering_player();
  }
}

shark_eat_wandering_player() {
  level endon("shark_warn_player");
  wait 5;
  common_scripts\utility::flag_set("shark_force_eat_player");
}

track_shark_flag() {
  wait 0.1;
  common_scripts\utility::flag_clear("shark_force_eat_player");
  wait 0.1;
  common_scripts\utility::flag_wait("shark_force_eat_player");

  if(level.deadly_sharks.size > 0) {
    wait 0.5;
    level.deadly_sharks = common_scripts\utility::array_removeundefined(level.deadly_sharks);

    if(level.deadly_sharks.size > 0) {
      var_0 = sortbydistance(level.deadly_sharks, level.player.origin);

      if(distance(var_0[0].origin, level.player.origin) < 800) {
        var_0[0] shark_kill_player();
        return;
      }
    }
  }

  shark_kill_front();
}

shark_heartbeat() {
  common_scripts\utility::flag_init("player_near_shark");
  level.heartbeat_delay = 2.25;
  thread track_sharks();

  for(;;) {
    if((common_scripts\utility::flag("player_near_shark") || common_scripts\utility::flag("shark_warn_player")) && (!common_scripts\utility::flag("no_shark_heartbeat") || common_scripts\utility::flag("shark_eating_player"))) {
      level.player thread maps\_utility::play_sound_on_entity("shipg_shark_warning");
      level.player common_scripts\utility::delaycall(0.2, ::playrumbleonentity, "damage_light");
      wait(level.heartbeat_delay);
    }

    wait 0.05;
  }
}

heartbeat_rumble() {
  level.player playrumbleonentity("heavy_3s");
  wait 0.1;
  stopallrumbles();
  wait 0.05;
  level.player playrumbleonentity("light_1s");
  wait 0.1;
  stopallrumbles();
}

track_sharks() {
  level.shark_heartbeat_distances = [400, 250, 200, 150];

  for(;;) {
    level.deadly_sharks = common_scripts\utility::array_removeundefined(level.deadly_sharks);
    level.deadly_sharks = sortbydistance(level.deadly_sharks, level.player.origin);
    common_scripts\utility::flag_clear("player_near_shark");
    level.heartbeat_delay = 2.25;

    foreach(var_1 in level.deadly_sharks) {
      var_2 = min(distance(level.player.origin, var_1.origin), distance(level.player.origin, var_1 gettagorigin("j_jaw")));

      if(var_2 < level.shark_heartbeat_distances[0] && isDefined(var_1) && isalive(var_1)) {
        common_scripts\utility::flag_set("player_near_shark");

        if(var_2 < level.shark_heartbeat_distances[1])
          level.heartbeat_delay = 1.25;

        if(var_2 < level.shark_heartbeat_distances[2])
          level.heartbeat_delay = 0.75;

        if(var_2 < level.shark_heartbeat_distances[3])
          level.heartbeat_delay = 0.5;

        wait(level.heartbeat_delay);
        break;
      }
    }

    wait 0.05;
  }
}

player_not_obstructed(var_0) {
  var_1 = level.player getEye();
  var_2 = level.player getplayerangles();
  var_3 = anglesToForward(var_2);
  var_4 = bulletTrace(var_1, var_1 + var_3 * var_0, 1, level.player);
  return var_4["fraction"] == 1;
}

overlay_manage(var_0, var_1) {
  var_2 = "destory_" + var_0;
  level endon(var_2);
  level.f_min[var_0] = 0.3;
  level.f_max[var_0] = 0.65;
  var_3 = maps\_hud_util::create_client_overlay(var_0, level.f_min[var_0], level.player);
  var_3.foreground = 0;
  var_3.sort = var_1;
  var_3.alpha = level.f_min[var_0];
  level.player.breathing_overlay[var_0] = var_3;
  var_3 thread delete_on_notify(var_2);

  if(is_demo_check()) {
    return;
  }
  for(;;) {
    level.player waittill("scuba_breathe_sound_starting");
    var_3 maps\_hud_util::fade_over_time(level.f_max[var_0], 1.1);
    wait 0.7;
    var_3 maps\_hud_util::fade_over_time(level.f_min[var_0], 2.3);
  }
}

sun_manage() {
  level endon("stop_sun_movement");
  var_0 = getmapsundirection();
  var_1 = var_0;
  var_2 = 0;
  var_3 = 0.1;

  for(;;) {
    var_4 = randomfloatrange(0.2, 0.4);
    var_5 = var_0 + (sin(var_2) * var_3, cos(var_2) * var_3, 0);
    lerpsundirection(var_1, var_5, var_4);
    var_2 = (var_2 + 1) % 360;
    wait(var_4 - 0.05);
    var_1 = var_5;
  }
}

salvage_cargo_setup() {
  self.linked_ents = common_scripts\utility::get_linked_ents();
  self hide();

  foreach(var_1 in self.linked_ents) {
    var_1 linkto(self);
    var_1 hide();
  }
}

salvage_cargo_show() {
  self show();

  foreach(var_1 in self.linked_ents)
  var_1 show();
}

salvage_cargo_rise(var_0) {
  self endon("deleted");
  self.balloon_count = level.balloon_count;
  level.balloon_count = level.balloon_count + 1;
  var_1 = common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_1, ::linkto, self);
  self.linked = var_1;
  var_2 = getEntArray(self.target, "targetname");
  self.path_clip = [];
  self.delete_things = [];
  self.damage_detect = self;

  foreach(var_4 in var_2) {
    switch (var_4.script_noteworthy) {
      case "bottom":
        self.bottom = var_4;
        self.bottom_target = self.bottom common_scripts\utility::get_target_ent();
        var_5 = self.origin[2] - self.bottom.origin[2];
        self.land_pos = self.bottom_target.origin + (0, 0, var_5);
        break;
      case "path_clip":
        self.path_clip = common_scripts\utility::array_add(self.path_clip, var_4);
        break;
    }
  }

  foreach(var_8 in var_1) {
    if(isDefined(var_8.script_noteworthy)) {
      switch (var_8.script_noteworthy) {
        case "damage_detect":
          self.damage_detect = var_8;
        case "delete_on_explode":
          self.delete_things = common_scripts\utility::array_add(self.delete_things, var_8);
          break;
      }
    }
  }

  common_scripts\utility::waitframe();
  salvage_cargo_show();

  foreach(var_11 in self.path_clip) {
    var_11 notsolid();
    var_11 connectpaths();
  }

  var_13 = (self.origin[0], self.origin[1], level.water_level_z - 24);
  var_14 = self.origin;
  var_15 = distance(var_14, var_13);

  if(!isDefined(var_0))
    var_0 = 40;

  var_16 = var_15 / var_0;
  self moveto(var_13, var_16, var_16 * 0.15, var_16 * 0.1);
  self.damage_detect setCanDamage(1);
  self.damage_detect.health = 1;

  while(self.damage_detect.health > 0)
    self.damage_detect waittill("damage", var_17, var_18, var_19, var_13, var_20);

  playFX(common_scripts\utility::getfx("shpg_underwater_bubble_explo"), self.origin + (0, 0, 64));
  thread common_scripts\utility::play_sound_in_space("underwater_balloon_pop", self.origin);
  self hide();

  foreach(var_22 in self.delete_things)
  var_22 delete();

  badplace_cylinder("balloon" + self.balloon_count, 5, self.bottom.origin, 128, 128);

  foreach(var_11 in self.path_clip) {
    var_11 solid();
    var_11 disconnectpaths();
  }

  var_26 = getaiarray("axis");

  foreach(var_28 in var_26) {
    if(distance2d(self.origin, var_28.origin) < 128) {
      var_28 thread maps\_utility::notify_delay("ai_event", randomfloatrange(0.2, 0.4));
      var_28.health = 1;
      var_28.baseaccuracy = 0.3;
      var_28 setthreatbiasgroup("easy_kills");
    }
  }

  moveto_speed(self.land_pos, 50, 0.3, 0.0);
  playFX(common_scripts\utility::getfx("underwater_impact_vehicle_cheap"), self.land_pos, (0, 0, 1), (1, 0, 0));
  thread common_scripts\utility::play_sound_in_space("underwater_balloon_crate_hit_bottom", self.land_pos);
  earthquake(0.3, 0.6, self.land_pos, 512);
}

vehicle_setup() {
  switch (self.classname) {
    case "script_vehicle_submarine_minisub":
      thread sdv_setup();
      thread notify_spotted_on_damage();
      break;
    case "script_vehicle_zodiac_underneath":
      thread zodiac_setup(1);
      break;
    case "script_vehicle_missile_boat_under":
      thread zodiac_setup(0);
      break;
  }
}

sdv_setup() {
  self startignoringspotlight();
  maps\_utility::ent_flag_set("moving");
  maps\_utility::ent_flag_set("lights");
  self endon("death");
  level.player endon("death");

  for(;;) {
    if(level.player istouching(self) || sdv_run_over_player())
      level.player dodamage(100, self.origin, self);

    common_scripts\utility::waitframe();
  }
}

sdv_run_over_player() {
  var_0 = self gettagorigin("tag_body");
  var_1 = self gettagangles("tag_body");
  var_2 = anglesToForward(var_1);
  var_3 = vectornormalize(level.player.origin - var_0);
  var_4 = vectordot(var_3, var_2);
  return var_4 > 0.8 && distance(level.player.origin, var_0) < 128;
}

zodiac_setup(var_0) {
  if(!isDefined(self.hasstarted) || !self.hasstarted)
    common_scripts\utility::waittill_either("newpath", "start_vehiclepath");

  if(isDefined(var_0)) {
    if(var_0) {
      var_1 = common_scripts\utility::spawn_tag_origin();
      self.fx_tag_prop_wash = var_1;
      self.fx_tag_prop_wash linkto(self, "TAG_PROPELLER_FX", (0, 0, 0), (0, 0, 0));
      playFXOnTag(common_scripts\utility::getfx("prop_wash"), self.fx_tag_prop_wash, "tag_origin");
    } else {
      var_1 = common_scripts\utility::spawn_tag_origin();
      self.fx_tag_prop_wash1 = var_1;
      self.fx_tag_prop_wash1 linkto(self, "TAG_PROPELLER_FX_LEFT", (0, 0, 0), (0, 0, 0));
      playFXOnTag(common_scripts\utility::getfx("prop_wash"), self.fx_tag_prop_wash1, "tag_origin");
      var_1 = common_scripts\utility::spawn_tag_origin();
      self.fx_tag_prop_wash2 = var_1;
      self.fx_tag_prop_wash2 linkto(self, "TAG_PROPELLER_FX_RIGHT", (0, 0, 0), (0, 0, 0));
      playFXOnTag(common_scripts\utility::getfx("prop_wash"), self.fx_tag_prop_wash2, "tag_origin");
    }
  }

  maps\_vehicle::godon();
  var_1 = common_scripts\utility::spawn_tag_origin();
  self.fx_tag = var_1;
  self.fx_tag linkto(self, "tag_fx_water_splash2", (0, 0, 10), (0, 0, 180));
  playFXOnTag(common_scripts\utility::getfx("boat_trail"), self.fx_tag, "tag_origin");
  var_1 = common_scripts\utility::spawn_tag_origin();
  self.fx_tag2 = var_1;
  self.fx_tag2 linkto(self, "tag_fx_water_splash1", (90, 0, 10), (0, 0, 180));
  playFXOnTag(common_scripts\utility::getfx("boat_trail"), self.fx_tag2, "tag_origin");
  var_1 = common_scripts\utility::spawn_tag_origin();
  self.wake_org = var_1;
  self.wake_org linkto(self, "tag_fx_water_splash2", (0, 0, 10), (90, -90, 180));
  thread zodiac_wake(self.wake_org);
  common_scripts\utility::waittill_any("death", "reached_end_node");
  self.fx_tag delete();
  self.fx_tag2 delete();
  self.wake_org delete();

  if(isDefined(self.fx_tag_prop_wash))
    self.fx_tag_prop_wash delete();

  if(isDefined(self.fx_tag_prop_wash1)) {
    self.fx_tag_prop_wash1 delete();
    self.fx_tag_prop_wash2 delete();
  }
}

zodiac_wake(var_0) {
  self endon("reached_end_node");
  self endon("death");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("wake_med"), var_0, "tag_origin");
    wait 0.3;
  }
}

lcs_setup() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  self.wake_org = var_0;
  self.wake_org linkto(self, "TAG_SPLASH_BACK", (0, 0, 10), (90, -90, 180));
  thread lcs_wake(self.wake_org);
  self waittill("death");

  if(isDefined(self.wake_org))
    self.wake_org delete();
}

lcs_intro_setup() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  self.wake_org = var_0;
  self.wake_org linkto(self, "TAG_SPLASH_BACK", (0, 0, 10), (90, -90, 180));
  thread lcs_wake_intro(self.wake_org);
  common_scripts\utility::waittill_any("start_swim", "reached_end_node", "death");

  if(isDefined(self.wake_org))
    self.wake_org delete();
}

lcs_wake(var_0) {
  self endon("death");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("wake_lg"), var_0, "tag_origin");
    wait 1.0;
  }
}

lcs_wake_intro(var_0) {
  self endon("reached_end_node");
  self endon("death");
  self endon("start_swim");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("vfx_boat_wake_lcs_abovewater"), var_0, "tag_origin");
    wait 0.6;
  }
}

littoral_ship_lights() {
  self.target_points = [];
  lcs_lights_front();
  lcs_lights_back();
  thread add_lcs_target((-174, 101, -47));
}

lcs_lights_front() {
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-406, -160, -10), (90, 0, 0));
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-134, -160, -10), (90, 0, 0));
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-406, 160, -10), (90, 0, 0));
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-134, 160, -10), (90, 0, 0));
}

lcs_lights_back() {
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-698, -160, -10), (90, 0, 0));
  thread spawn_tag_fx("circle_glow_w_beam_lg", "tag_origin", (-698, 160, -10), (90, 0, 0));
}

add_lcs_target(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  self.target_points = common_scripts\utility::array_add(self.target_points, var_1);
  var_1 linkto(self, "tag_origin", var_0, (0, 0, 0));
  self waittill("death");
  var_1 delete();
}

add_headlamp() {
  if(self.team == "axis" && isai(self) && self.type != "dog")
    thread spawn_tag_fx("vfx_headlamp_enemy_diver", "j_head_end", (0, -5, 0), (0, -90, 0));
}

spawn_tag_fx(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4 linkto(self, var_1, var_2, var_3);
  playFXOnTag(common_scripts\utility::getfx(var_0), var_4, "tag_origin");
  self waittill("death");

  if(!maps\_vehicle::isvehicle() && !isDefined(self.script_parameters))
    var_4 thread headlamp_death_blink(common_scripts\utility::getfx(var_0));
  else
    var_4 delete();
}

headlamp_death_blink(var_0) {
  playFXOnTag(common_scripts\utility::getfx("shpg_enm_death_bubbles_a"), self, "tag_origin");

  for(var_1 = 0; var_1 < randomintrange(5, 12); var_1++) {
    var_2 = common_scripts\utility::getfx("rebreather_hose_bubbles");
    playFXOnTag(var_2, self, "tag_origin");
    playFXOnTag(var_0, self, "tag_origin");
    wait(randomfloatrange(0.05, 0.1));
    stopFXOnTag(var_0, self, "tag_origin");
    wait(randomfloatrange(0.05, 0.1));
  }

  for(var_1 = 0; var_1 < randomintrange(1, 8); var_1++) {
    var_2 = common_scripts\utility::getfx("rebreather_hose_bubbles");
    playFXOnTag(var_2, self, "tag_origin");
    wait(randomfloatrange(0.1, 0.2));
  }

  self delete();
}

sdv_patrol_setup() {
  self vehicle_turnengineoff();
  self startignoringspotlight();
  self.light_tag thread spot_light("spotlight_underwater", "spotlight_underwater_cheap", "tag_origin");
  self waittill("death");

  if(isDefined(level.last_spot_light)) {
    if(isDefined(level.last_spot_light.entity) && level.last_spot_light.entity == self.light_tag) {
      wait 0.05;
      stop_last_spot_light();
    }
  }
}

sdv_silt_kickup() {
  self vehicle_turnengineoff();
  playFXOnTag(common_scripts\utility::getfx("silt_ground_kickup_runner"), self, "TAG_PROPELLER");
}

set_start_positions(var_0) {
  var_1 = common_scripts\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(level.player_rig) && var_3.script_noteworthy == "player") {
      level.player_rig unlink();
      level.player_rig.origin = var_3.origin;
    }

    switch (var_3.script_noteworthy) {
      case "player":
        level.player setorigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "baker":
        level.baker forceteleport(var_3.origin, var_3.angles);
        level.baker setgoalpos(var_3.origin);
        break;
    }
  }
}

spawn_baker() {
  var_0 = common_scripts\utility::get_target_ent("baker");
  level.baker = var_0 maps\_utility::spawn_ai(1);
  level.baker thread maps\_utility::magic_bullet_shield();
  level.baker.animname = "baker";
  level.baker.name = "Keegan";
  level.baker.script_friendname = "Keegan";
  thread baker_glint();
}

baker_glint() {
  level.baker.glint_org = common_scripts\utility::spawn_tag_origin();
  level.baker.glint_org.origin = level.baker gettagorigin("tag_stowed_back");
  level.baker.glint_org linkto(level.baker, "tag_stowed_back", (7, 3, 3), (0, 0, 0));
  level.baker.icon = newhudelem();
  level.baker.icon setshader("blank", 1, 1);
  level.baker.icon setwaypoint(0, 1, 1);
  level.baker.icon setwaypointiconoffscreenonly();
  level.baker.icon settargetent(level.baker);
  level.baker.icon.alpha = 0.6;
  setsaveddvar("r_hudOutlineAlpha0", 0.35);
  level.baker endon("death");
  level endon("end_swimming");
  common_scripts\utility::flag_wait("start_swim");
  baker_glint_on();

  for(;;) {
    if(isDefined(level.baker)) {
      if(level.baker.back_light_on)
        playFXOnTag(common_scripts\utility::getfx("ai_marker_light"), level.baker.glint_org, "tag_origin");

      var_0 = 0.75;
      wait(var_0);
    }

    wait 0.2;
  }
}

baker_glint_off() {
  level.baker notify("glint_off");
  level.baker.back_light_on = 0;
  level.baker.icon fadeovertime(0.5);
  level.baker.icon.alpha = 0.0;
}

baker_glint_on() {
  level.baker notify("glint_on");
  level.baker.back_light_on = 1;
  level.baker.icon fadeovertime(0.5);
  level.baker.icon.alpha = 0.6;
  thread turn_off_glint_when_player_looks();
}

turn_off_glint_when_player_looks() {
  level.baker endon("glint_on");
  level.baker endon("glint_off");
  var_0 = 450;

  for(;;) {
    wait 1;

    if(distance(level.player.origin, level.baker.origin) > var_0)
      level.baker.back_light_on = 1;

    while(distance(level.player.origin, level.baker.origin) > var_0)
      wait 0.1;

    level.baker maps\_utility::waittill_player_lookat_for_time(3, 0.7);

    if(distance(level.player.origin, level.baker.origin) <= var_0)
      level.baker.back_light_on = 0;

    wait 1;

    while(distance(level.player.origin, level.baker.origin) <= var_0)
      wait 0.1;
  }
}

jump_into_water() {
  if(!isDefined(level.total_jumpers))
    level.total_jumpers = [];

  level.total_jumpers = common_scripts\utility::array_add(level.total_jumpers, self);
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_1 = common_scripts\utility::get_target_ent();
    var_0 = var_1.origin;
  }

  thread maps\_swim_ai::jumpintowater(var_0);
}

paired_death_restart() {
  level notify("paired_death_restart");
  level.paired_death_group = [];
  level.paired_death_max_distance = 700;
}

paired_death_think(var_0) {
  level endon("paired_death_restart");
  thread paired_death_add();

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(var_2 != level.player)
      return;
    else
      break;
  }

  self.gotshot = 1;
  var_3 = self.origin;

  if(!isDefined(var_3)) {
    return;
  }
  wait 0.1;

  if(level.paired_death_group.size > 0) {
    var_4 = level.paired_death_group;
    var_4 = maps\_utility::array_removedead(var_4);
    var_4 = sortbydistance(var_4, var_3);

    foreach(var_6 in var_4) {
      if(var_6 != self) {
        if(distance2d(var_6.origin, var_3) < level.paired_death_max_distance && !isDefined(var_6.gotshot)) {
          var_0 stealth_shot(var_6);
          level notify("other_guy_died");
        }

        break;
      }
    }
  }
}

paired_death_wait_flag(var_0) {
  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);

  while(level.paired_death_group.size > 0)
    wait 0.05;

  thread common_scripts\utility::flag_set(var_0);
}

paired_death_wait() {
  while(level.paired_death_group.size > 0)
    wait 0.05;
}

paired_death_add() {
  if(!isDefined(level.paired_death_group))
    level.paired_death_group = [];

  level.paired_death_group[level.paired_death_group.size] = self;
  self waittill("death");
  level.paired_death_group = common_scripts\utility::array_remove(level.paired_death_group, self);
}

stealth_shot(var_0) {
  self endon("death");
  var_0 endon("death");
  thread stealth_shot_accuracy(var_0);
  self.favoriteenemy = var_0;
  self getenemyinfo(var_0);
  var_0.dontattackme = undefined;
  wait 0.4;
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0 gettagorigin("j_head");
  magicbullet(self.weapon, var_1, var_2);
  wait 0.1;
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0 gettagorigin("j_head");
  magicbullet(self.weapon, var_1, var_2);
  var_0 kill(var_0.origin, self);
  magicbullet(self.weapon, var_1, var_2 + (randomint(5), randomint(5), randomint(5)));
  wait 0.05;
  magicbullet(self.weapon, var_1, var_2 + (randomint(5), randomint(5), randomint(5)));
  wait 0.05;
  magicbullet(self.weapon, var_1, var_2 + (randomint(5), randomint(5), randomint(5)));
  wait 0.05;
  magicbullet(self.weapon, var_1, var_2 + (randomint(5), randomint(5), randomint(5)));
  wait 0.05;
  var_3 = randomint(5);
  var_4 = randomint(5);
  var_5 = randomint(5);
  magicbullet(self.weapon, var_1, var_2 + (var_3, var_4, var_5));
  wait 0.05;
  magicbullet(self.weapon, var_1, var_2 + (var_3, var_4, var_5));
}

stealth_shot_accuracy(var_0) {
  var_1 = self.baseaccuracy;
  self.baseaccuracy = 9999;
  var_0 waittill("death");
  self.baseaccuracy = var_1;
}

moveto_speed(var_0, var_1, var_2, var_3) {
  var_4 = self.origin;
  var_5 = distance(var_4, var_0);
  var_6 = var_5 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self moveto(var_0, var_6, var_6 * var_2, var_6 * var_3);
  self waittill("movedone");
}

moveto_rotateto_speed(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = self.origin;
  var_6 = distance(var_5, var_4);
  var_7 = var_6 / var_1;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  self rotateto(var_0.angles, var_7, var_7 * var_2, var_7 * var_3);
  self moveto(var_4, var_7, var_7 * var_2, var_7 * var_3);
  self waittill("movedone");
}

spot_light(var_0, var_1, var_2, var_3) {
  if(isDefined(level.last_spot_light)) {
    var_4 = level.last_spot_light;

    if(isDefined(var_4.entity)) {
      stopFXOnTag(var_4.effect_id, var_4.entity, var_4.tag_name);

      if(isDefined(var_4.cheap_effect_id))
        playFXOnTag(var_4.cheap_effect_id, var_4.entity, var_4.tag_name);
    }

    wait 0.1;
  }

  wait 0.8;
  level notify("spotlight_changed_owner");
  var_4 = spawnStruct();
  var_4.effect_id = common_scripts\utility::getfx(var_0);

  if(isDefined(var_1))
    var_4.cheap_effect_id = common_scripts\utility::getfx(var_1);

  var_4.entity = self;
  var_4.tag_name = var_2;
  playFXOnTag(var_4.effect_id, var_4.entity, var_4.tag_name);

  if(isDefined(var_3))
    thread spot_light_death(var_3);

  level.last_spot_light = var_4;
}

stop_last_spot_light() {
  if(isDefined(level.last_spot_light)) {
    var_0 = level.last_spot_light;
    stopFXOnTag(var_0.effect_id, var_0.entity, var_0.tag_name);
    level.last_spot_light = undefined;
  }
}

spot_light_death(var_0) {
  self notify("new_spot_light_death");
  self endon("new_spot_light_death");
  self endon("death");
  var_0 waittill("death");
  self delete();
}

volume_waittill_no_axis(var_0, var_1) {
  var_2 = common_scripts\utility::get_target_ent(var_0);

  for(;;) {
    if(volume_is_empty(var_2, var_1)) {
      break;
    }

    wait 0.2;
  }
}

volume_is_empty(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = getaiarray("axis");
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(var_5 istouching(var_0)) {
      var_3 = var_3 + 1;

      if(var_3 > var_1)
        return 0;
    }
  }

  return 1;
}

anim_generic_reach_and_animate(var_0, var_1, var_2, var_3) {
  maps\_anim::anim_generic_reach(var_0, var_1, var_2);
  self notify("starting_anim");
  var_0 notify("starting_anim");

  if(isDefined(var_3))
    maps\_anim::anim_generic_custom_animmode(var_0, var_3, var_1, var_2);
  else
    maps\_anim::anim_generic(var_0, var_1, var_2);
}

move_up_when_clear() {
  var_0 = common_scripts\utility::get_target_ent();
  var_1 = var_0 common_scripts\utility::get_target_ent();
  var_1 endon("trigger");
  self waittill("trigger");
  volume_waittill_no_axis(var_0.targetname, var_0.script_count);
  var_1 thread maps\_utility::activate_trigger();
}

depth_charge_org() {
  var_0 = undefined;

  if(isDefined(self.target)) {
    var_1 = common_scripts\utility::get_target_ent();
    var_0 = var_1.origin;
  }

  var_2 = (0, 0, 5);
  var_3 = level.water_level_z;
  var_4 = self.script_flag;

  if(isDefined(var_4)) {
    if(!common_scripts\utility::flag_exist(var_4))
      common_scripts\utility::flag_init(var_4);
  }

  maps\_utility::script_delay();
  drop_depth_charge(self.origin, var_0, var_4);
}

drop_depth_charge(var_0, var_1, var_2) {
  var_3 = (0, 0, 5);
  var_4 = level.water_level_z;

  if(!isDefined(var_1)) {
    var_0 = (var_0[0], var_0[1], var_4);
    var_5 = bulletTrace(var_0 - (0, 0, 10), var_0 - (0, 0, 700), 0);
    var_1 = var_5["position"];
  } else
    var_0 = (var_1[0], var_1[1], var_4);

  var_0 = var_0 + var_3;
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = var_0 + (0, 0, 22);
  var_7 = spawn("script_model", var_0);
  var_7 setModel("com_barrel_benzin2");
  var_7 linkto(var_6);
  var_8 = 200;
  var_9 = var_4 - var_1[2];
  var_6 thread barrel_roll();
  var_10 = min(100, var_9 * 0.2);
  var_11 = var_9 - var_10;
  var_12 = var_10 / var_8;
  var_13 = var_11 / (var_8 / 2);
  var_6 playSound("depth_charge_drop");
  playFX(common_scripts\utility::getfx("jump_into_water_splash"), var_0 - var_3);
  playFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_6, "tag_origin");
  var_6 movez(-1 * var_10, var_12, 0, var_12);
  wait(var_12);
  var_6 movez(-1 * var_11, var_13, 0, 0);
  wait(var_13);
  stopFXOnTag(common_scripts\utility::getfx("underwater_object_trail"), var_6, "tag_origin");
  playFX(common_scripts\utility::getfx("shpg_underwater_explosion_med_a"), var_6.origin);
  thread common_scripts\utility::play_sound_in_space("depth_charge_explo_dist", var_6.origin);

  if(isDefined(var_2))
    common_scripts\utility::flag_set(var_2);

  if(!common_scripts\utility::flag("depth_charge_muffle")) {
    earthquake(0.6, 0.75, var_6.origin, 1024);
    radiusdamage(var_6.origin, 300, 100, 20);
    var_9 = distance(level.player.origin, var_6.origin);

    if(var_9 < 1900) {
      if(var_9 < 900)
        thread common_scripts\utility::play_sound_in_space("depth_charge_explo_close_2d", var_6.origin);
      else
        thread common_scripts\utility::play_sound_in_space("depth_charge_explo_mid_2d", var_6.origin);
    }

    if(var_9 < 600) {
      thread thrash_player(600, 0.4, var_6.origin);

      if(var_9 < 300) {
        if(var_9 < 150) {
          level.player shellshock("depth_charge_hit", 2.5);
          level.player thread delay_reset_swim_shock(3);
        } else {
          level.player shellshock("depth_charge_hit", 1.5);
          level.player thread delay_reset_swim_shock(2);
        }
      }
    }
  } else
    earthquake(0.3, 0.5, var_6.origin, 1024);

  var_7 delete();
  var_6 delete();
}

thrash_player(var_0, var_1, var_2) {
  var_3 = distance(level.player.origin, var_2);
  var_4 = max(var_3 / var_0, var_1);
  level.player viewkick(int(var_4 * 120), var_2);
  var_5 = level.player getvelocity();
  var_6 = vectornormalize(level.player.origin - var_2);
  level.player setvelocity(var_5 * 0.75 + var_6 * var_4 * 100);
}

delay_reset_swim_shock(var_0) {
  self allowsprint(0);
  self notify("new_shock");
  self endon("new_shock");
  wait(var_0);
  thread maps\_swim_player::shellshock_forever();
  self allowsprint(1);
}

barrel_roll() {
  self endon("death");
  var_0 = randomfloatrange(0.5, 1.5);

  for(;;) {
    var_1 = (self.angles[0] + 20, self.angles[1] + 30, self.angles[2] + 40);
    self rotateto(var_1, var_0);
    wait(var_0);
  }
}

trigger_depth_charges() {
  self waittill("trigger");
  var_0 = common_scripts\utility::getStructArray(self.target, "targetname");
  common_scripts\utility::array_thread(var_0, ::depth_charge_org);
}

dyn_swimspeed_enable(var_0) {
  self endon("death");
  self endon("dynspeed_off");

  if(isDefined(self.dyn_speed)) {
    return;
  }
  self.dyn_speed = 1;

  if(!isDefined(var_0))
    var_0 = 200;

  self.old_moveplaybackrate = self.moveplaybackrate;

  for(;;) {
    var_1 = player_is_behind_me();
    var_2 = distance(self.origin, level.player.origin);

    if(!var_1 || var_2 < var_0) {
      self.moveplaybackrate = self.old_moveplaybackrate * 1.4;
      self.movetransitionrate = self.moveplaybackrate;
      wait 1;

      while(!player_is_behind_me() || distance(self.origin, level.player.origin) < var_0)
        wait 0.1;

      self.moveplaybackrate = self.old_moveplaybackrate;
      self.movetransitionrate = self.moveplaybackrate;
      wait 5;
    }

    wait 0.3;
  }
}

dyn_swimspeed_disable() {
  self notify("dynspeed_off");

  if(isDefined(self.old_moveplaybackrate)) {
    self.moveplaybackrate = self.old_moveplaybackrate;
    self.movetransitionrate = self.moveplaybackrate;
  }

  self.old_moveplaybackrate = undefined;
  self.dyn_speed = undefined;
}

player_is_behind_me(var_0) {
  if(!isDefined(var_0))
    var_0 = -0.1;

  var_1 = (self.angles[0], self.angles[1], 0);
  var_2 = anglesToForward(var_1);
  var_3 = self.origin - (0, 0, self.origin[2]);
  var_4 = level.player.origin - (0, 0, level.player.origin[2]);
  var_5 = vectornormalize(var_4 - var_3);
  var_6 = vectordot(var_5, var_2);
  return var_6 < var_0;
}

track_death() {
  if(isai(self) && self.team == "axis") {
    self waittill("death", var_0);

    if(!isDefined(var_0)) {
      return;
    }
    if(!common_scripts\utility::flag("allow_killfirms")) {
      return;
    }
    wait 0.3;
    var_1 = 0.2;

    if(gettime() - level.last_killfirm_time < level.last_killfirm_timeout) {
      return;
    }
    if(var_0 == level.player) {
      if(gettime() - level.last_killfirm_time < level.last_killfirm_timeout) {
        return;
      }
      if(level.killfirm_suffix == "_loud") {
        var_2 = maps\_utility::radio_dialogue("shpg_killfirm_other_" + randomintrange(0, 3) + level.killfirm_suffix, var_1);

        if(var_2)
          level.last_killfirm_time = gettime();
      }
    } else if(var_0 == level.baker) {
      if(gettime() - level.last_killfirm_time < level.last_killfirm_timeout) {
        return;
      }
      var_2 = maps\_utility::radio_dialogue("shpg_killfirm_other_" + randomintrange(0, 4) + level.killfirm_suffix, var_1);

      if(var_2)
        level.last_killfirm_time = gettime();
    }
  }
}

baker_killfirms() {
  common_scripts\utility::flag_init("allow_killfirms");
  common_scripts\utility::flag_set("allow_killfirms");
  level.last_killfirm_time = 0;
  level.last_killfirm_timeout = 15000;
  level.killfirm_suffix = "";
}

force_deathquote(var_0) {
  if(isDefined(var_0)) {
    level notify("new_quote_string");
    setDvar("ui_deadquote", var_0);
  }
}

dyn_balloon_delete() {
  self notify("deleted");

  foreach(var_1 in self.path_clip) {
    if(isDefined(var_1))
      var_1 delete();
  }

  foreach(var_4 in self.linked) {
    if(isDefined(var_4))
      var_4 delete();
  }

  if(isDefined(self.trigger))
    self.trigger delete();

  self delete();
}

new_dyn_balloon_think() {
  self endon("deleted");
  self.balloon_count = level.balloon_count;
  level.balloon_count = level.balloon_count + 1;
  var_0 = common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_0, ::linkto, self);
  self.linked = var_0;
  var_1 = getEntArray(self.target, "targetname");
  self.path_clip = [];
  self.delete_things = [];
  self.damage_detect = self;

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "bottom":
        self.bottom = var_3;
        self.bottom_target = self.bottom common_scripts\utility::get_target_ent();
        break;
      case "path_clip":
        self.path_clip = common_scripts\utility::array_add(self.path_clip, var_3);
        break;
    }
  }

  foreach(var_6 in var_0) {
    if(isDefined(var_6.script_noteworthy)) {
      switch (var_6.script_noteworthy) {
        case "damage_detect":
          self.damage_detect = var_6;
        case "delete_on_explode":
          self.delete_things = common_scripts\utility::array_add(self.delete_things, var_6);
          break;
      }
    }
  }

  common_scripts\utility::waitframe();

  foreach(var_9 in self.path_clip) {
    var_9 notsolid();
    var_9 connectpaths();
  }

  self.damage_detect setCanDamage(1);
  thread dyn_balloon_bob();
  self.damage_detect.health = 1;

  while(self.damage_detect.health > 0)
    self.damage_detect waittill("damage", var_11, var_12, var_13, var_14, var_15);

  playFX(common_scripts\utility::getfx("shpg_underwater_bubble_explo"), self.origin + (0, 0, 64));
  thread common_scripts\utility::play_sound_in_space("underwater_balloon_pop", self.origin);
  self hide();
  self notify("stop_bob");

  foreach(var_17 in self.delete_things)
  var_17 delete();

  badplace_cylinder("balloon" + self.balloon_count, 5, self.bottom.origin, 128, 128);
  var_19 = getnodearray("disable_node_on_damage", "targetname");

  foreach(var_21 in var_19) {
    if(distance(var_21.origin, self.origin - (0, 0, 180)) < 128)
      var_21 disconnectnode();
  }

  foreach(var_9 in self.path_clip) {
    var_9 solid();
    var_9 disconnectpaths();
  }

  var_25 = getaiarray("axis");

  foreach(var_27 in var_25) {
    if(distance2d(self.origin, var_27.origin) < 128) {
      var_27 thread maps\_utility::notify_delay("ai_event", randomfloatrange(0.2, 0.4));
      var_27.health = 1;
      var_27.baseaccuracy = 0.3;
      var_27 setthreatbiasgroup("easy_kills");
    }

    if(distance2d(self.origin, var_27.origin) < 1000)
      var_27 thread maps\_utility::notify_delay("ai_event", randomfloatrange(0.2, 0.4));
  }

  var_29 = self.origin[2] - self.orig_org[2];
  var_30 = spawn("trigger_radius", self.bottom.origin - (0, 0, 32), 0, 32, 64);
  var_30 thread trigger_hurt();
  var_30 enablelinkto();
  var_30 linkto(self);
  self.trigger = var_30;
  moveto_speed(self.origin - (0, 0, self.bottom.origin[2] - self.bottom_target.origin[2] + var_29), 50, 0.3, 0.0);
  playFX(common_scripts\utility::getfx("underwater_impact_vehicle_cheap"), self.bottom_target.origin, (0, 0, 1), (1, 0, 0));
  thread common_scripts\utility::play_sound_in_space("underwater_balloon_crate_hit_bottom", self.bottom_target.origin);
  earthquake(0.3, 0.6, self.bottom_target.origin, 512);
  wait 0.1;
  var_30 delete();
}

trigger_hurt() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 dodamage(100, self.origin);
  }
}

dyn_balloon_think() {
  self endon("deleted");
  self.balloon_count = level.balloon_count;
  level.balloon_count = level.balloon_count + 1;
  var_0 = common_scripts\utility::get_linked_ents();
  common_scripts\utility::array_call(var_0, ::linkto, self);
  self.linked = var_0;
  var_1 = getEntArray(self.target, "targetname");
  self.path_clip = [];

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "bottom":
        self.bottom = var_3;
        self.bottom_target = self.bottom common_scripts\utility::get_target_ent();
        break;
      case "path_clip":
        self.path_clip = common_scripts\utility::array_add(self.path_clip, var_3);
        break;
    }
  }

  common_scripts\utility::waitframe();

  foreach(var_6 in self.path_clip) {
    var_6 notsolid();
    var_6 connectpaths();
  }

  self setCanDamage(1);
  thread dyn_balloon_bob();
  self waittill("damage", var_8, var_9, var_10, var_11, var_12);
  var_13 = common_scripts\utility::spawn_tag_origin();
  var_13.origin = var_11;
  var_13.angles = var_10;
  var_13 linkto(self);
  playFXOnTag(common_scripts\utility::getfx("water_bubbles_longlife_lp"), var_13, "tag_origin");
  badplace_cylinder("balloon" + self.balloon_count, 5, self.bottom.origin, 128, 128);

  foreach(var_6 in self.path_clip) {
    var_6 solid();
    var_6 disconnectpaths();
  }

  var_16 = getaiarray("axis");

  foreach(var_18 in var_16) {
    if(distance2d(self.origin, var_18.origin) < 128) {
      var_18 thread maps\_utility::notify_delay("ai_event", randomfloatrange(0.2, 0.4));
      var_18.health = 1;
      var_18.baseaccuracy = 0.3;
      var_18 setthreatbiasgroup("easy_kills");
    }
  }

  var_20 = self.origin[2] - self.orig_org[2];
  moveto_speed(self.origin - (0, 0, self.bottom.origin[2] - self.bottom_target.origin[2] + var_20), 40, 0.3, 0.0);
}

dyn_balloon_bob() {
  self endon("stop_bob");
  self endon("deleted");
  self endon("damage");
  self.orig_org = self.origin;
  var_0 = 3;

  for(;;) {
    var_1 = randomfloatrange(3, 5);
    self moveto(self.orig_org + (0, 0, var_0), var_1, var_1 * 0.5, var_1 * 0.5);
    self waittill("movedone");
    common_scripts\utility::waitframe();
    self moveto(self.orig_org - (0, 0, var_0), var_1, var_1 * 0.5, var_1 * 0.5);
    self waittill("movedone");
  }
}

shark_go_trig() {
  var_0 = getEntArray(self.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1 = common_scripts\utility::array_add(var_1, var_3);

  common_scripts\utility::array_call(var_1, ::hide);
  self waittill("trigger");
  common_scripts\utility::array_thread(var_1, ::shark_think);
  common_scripts\utility::array_thread(var_1, maps\_utility::delaythread, randomfloatrange(0, 1), ::shark_kill_think);
}

#using_animtree("animals");

shark_think() {
  self endon("death");
  self notify("new_directive");
  self endon("new_directive");
  self show();
  self useanimtree(#animtree);
  var_0 = randomfloatrange(0.7, 1.1);

  if(isDefined(self.script_moveplaybackrate))
    var_0 = self.script_moveplaybackrate;

  self.animname = "shark";
  self setanim(%shark_swim_f, 1, randomfloatrange(0, 0.5), var_0);
  var_1 = common_scripts\utility::get_target_ent();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "real_shark") {
    find_available_collision_model();
    thread shark_think_real();
  }

  for(;;) {
    var_2 = var_1.origin - self.origin;
    self rotateto(vectortoangles(var_2), 1);
    moveto_speed(var_1.origin, 60 * var_0);

    if(isDefined(var_1.target)) {
      var_1 = var_1 common_scripts\utility::get_target_ent();
      continue;
    }

    break;
  }

  self delete();
}

shark_think_real() {
  self.shark_collision_model setCanDamage(1);
  self.shark_collision_model waittill("damage");
  common_scripts\utility::flag_waitopen("shark_eating_player");
  return_collision_model();
  var_0 = getent("generic_shark_spawner", "targetname");
  var_1 = var_0 stalingradspawn();

  if(maps\_utility::spawn_failed(var_1)) {
    return;
  }
  var_1.animname = "shark";
  var_1 maps\_anim::setanimtree();
  var_1 forceteleport(self.origin, self.angles);
  self delete();
  var_1 shark_kill_player();
}

dead_body_spawner() {
  var_0 = common_scripts\utility::getStructArray(self.script_noteworthy, "script_noteworthy");

  foreach(var_2 in var_0) {
    self.origin = var_2.origin;
    self.angles = var_2.angles;
    var_3 = maps\_utility::spawn_ai(1);
    var_3 maps\_utility::gun_remove();
    var_4 = level.scr_anim["generic"][var_2.animation];

    if(isarray(var_4))
      var_4 = var_4[0];

    var_3 setCanDamage(0);
    var_3 notsolid();
    var_3 animscripted("endanim", var_2.origin, var_2.angles, var_4);
    common_scripts\utility::waitframe();
  }
}

shark_kill_front(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = "shark_attack_4";

  if(!isDefined(var_2))
    var_2 = [0.6, 1.25, 1.5];

  var_3 = level.player.origin;
  var_4 = anglesToForward(level.player.angles);
  var_5 = anglestoright(level.player.angles);

  if(!isDefined(var_0)) {
    var_0 = spawn("script_model", var_3 - var_4 * 50);
    var_0 setModel("fullbody_tigershark");
    var_0.animname = "shark";
    var_0 maps\_anim::setanimtree();
  }

  var_0 endon("death");
  var_0 unlink();
  var_0 notify("stop_loop");

  if(isDefined(var_0.anim_node))
    var_0.anim_node notify("stop_loop");

  var_6 = spawnStruct();
  var_6.origin = var_0.origin;
  var_6.angles = vectortoangles(level.player.origin - var_0.origin);

  if(issubstr(var_1, "_L")) {
    var_7 = anglestoright(var_6.angles);
    var_6.angles = vectortoangles(var_7);
  } else if(issubstr(var_1, "_R")) {
    var_7 = anglestoright(var_6.angles);
    var_6.angles = vectortoangles(-1 * var_7);
  }

  var_3 = level.player.origin;
  var_4 = anglesToForward(level.player.angles);
  var_5 = anglestoright(level.player.angles);
  var_8 = (0, 0, 52);
  var_9 = maps\_player_rig::get_player_rig();
  var_9.origin = level.player.origin - var_8;
  var_9.angles = level.player.angles;
  var_9 hide();
  var_0 setviewmodeldepth(1);
  var_9 setviewmodeldepth(1);
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = var_9.origin;
  var_10.angles = var_9.angles;
  var_10 linkto(var_9, "tag_player", var_8, (0, 0, 0));
  var_6 thread maps\_anim::anim_single([var_9, var_0], var_1);
  level.player takeallweapons();
  var_11 = 0.2;
  level.player playerlinktoblend(var_10, "tag_origin", var_11, 0, var_11 * 0.25);
  thread shark_attack_slomo();
  var_9 common_scripts\utility::delaycall(var_11, ::show);
  level.player common_scripts\utility::delaycall(0.0, ::playsound, "scn_shipg_shark_bite_plr");
  wait(var_2[0]);
  var_12 = common_scripts\utility::spawn_tag_origin();
  var_12.origin = level.player getEye();
  var_12 linkto(level.player);
  playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_12.origin);
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), var_12, "tag_origin");
  level.player thread maps\_gameskill::blood_splat_on_screen("bottom");
  level.player playrumbleonentity("damage_heavy");
  wait(var_2[1]);
  level.player thread maps\_gameskill::blood_splat_on_screen("left");
  level.player playrumbleonentity("damage_heavy");
  wait(var_2[2]);
  var_13 = getdvarint("shpg_killed_by_shark", 0);
  setDvar("shpg_killed_by_shark", var_13 + 1);
  level.player kill();
}

shark_attack_slomo() {
  var_0 = 0;
  wait 0.2;
  var_1 = 0.15;
  var_2 = 0.35;
  level.player lerpfov(50, 0.2);
  maps\_utility::slowmo_setspeed_slow(0.1);
  maps\_utility::slowmo_setlerptime_in(var_1);

  if(var_0)
    maps\_utility::slowmo_lerp_in();

  wait(var_1);
  wait 0.1;
  level.player lerpfov(65, 0.3);
  maps\_utility::slowmo_setlerptime_out(var_2);

  if(var_0)
    maps\_utility::slowmo_lerp_out();
}

shark_vehicle(var_0) {
  var_1 = self;
  var_1.animname = "shark";
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(self.target);
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_1 linkto(var_2, "tag_origin");
  wait(randomfloatrange(0, 1));
  var_1.anim_node = var_2;
  var_2 thread maps\_anim::anim_loop_solo(var_1, var_1.animation, "stop_loop", "tag_origin");
  var_1 thread shark_kill_think();
}

shark_track_bulletwhizby() {
  if((greenlight_check() || is_demo_check()) && (isDefined(level.start_point) && level.start_point != "fallon")) {
    return;
  }
  self addaieventlistener("bulletwhizby");

  for(;;) {
    self waittill("ai_event", var_0);

    if(var_0 == "bulletwhizby") {
      if(level.player maps\_utility::player_looking_at(self.origin, 0.7, 1)) {
        var_1 = shark_kill_player();

        if(var_1) {
          break;
        }
      }
    }

    wait 0.5;
  }
}

shark_kill_think() {
  self endon("death");
  self.animname = "shark";
  level.deadly_sharks = common_scripts\utility::array_add(level.deadly_sharks, self);

  if(isai(self))
    childthread shark_track_bulletwhizby();

  maps\_utility::ent_flag_init("shark_busy");

  for(;;) {
    var_0 = getdvarint("shpg_killed_by_shark", 0);

    if(var_0 == 0) {
      var_1 = 110;
      var_2 = 90;
      var_3 = 0.75;
    } else {
      var_1 = 90;
      var_2 = 70;
      var_3 = 0.95;
    }

    if(level.start_point == "start_big_wreck_2" && self.origin[0] < 13720 && self.origin[1] > -54848 && self.origin[2] > 200) {
      var_1 = 150;
      var_2 = 130;
      var_3 = 0.75;
    }

    if(!level.console && !level.player usinggamepad())
      var_3 = 1;

    maps\_utility::ent_flag_waitopen("shark_busy");
    common_scripts\utility::flag_waitopen("shark_eating_player");
    common_scripts\utility::flag_waitopen("no_shark_heartbeat");
    var_4 = getdvarint("player_swimSpeed", 70);
    var_4 = var_4 * var_3;
    var_5 = self gettagorigin("j_jaw");
    var_6 = self gettagorigin("j_head");
    var_7 = self gettagangles("j_head");
    var_7 = anglestoright(var_7);
    var_7 = vectortoangles(var_7);
    var_8 = 1;
    var_9 = distance(level.player getvelocity(), (0, 0, 0));

    if(var_9 > var_4)
      var_8 = var_9 / var_4;

    if(distance(level.player.origin, self.origin) < var_1 * var_8)
      shark_kill_player();
    else if(distance(level.player.origin, var_5) < var_2 * var_8)
      shark_kill_player();
    else if(common_scripts\utility::within_fov(var_6, var_7, level.player.origin, 0.8) && distance(level.player.origin, var_6) < var_2 * var_8 * 2)
      shark_kill_player();

    wait 0.05;
  }
}

player_get_closest_node() {
  level.player endon("death");

  for(;;) {
    var_0 = getclosestnodeinsight(self.origin);

    if(isDefined(var_0)) {
      if(var_0.type != "Begin" && var_0.type != "End" && var_0.type != "Turret")
        self.node_closest = var_0;
    }

    wait 0.25;
  }
}

shark_kill_player(var_0) {
  if((greenlight_check() || is_demo_check()) && (isDefined(level.start_point) && level.start_point != "fallon")) {
    return;
  }
  self endon("death");
  thread restore_attack_flag_on_death();

  if(common_scripts\utility::flag("shark_eating_player"))
    return 0;

  if(!isDefined(var_0)) {
    var_1 = bulletTrace(self.origin, level.player.origin, 0, self);

    if(var_1["fraction"] < 0.95)
      return 0;

    maps\_utility::radio_dialogue_stop();
    thread maps\_utility::radio_dialogue_interupt("shpg_shark_attack_0");
  }

  self notify("killing_player");
  common_scripts\utility::flag_set("shark_eating_player");
  wait 0.25;

  if(isai(self)) {
    if(isDefined(self.animnode)) {
      self.animnode notify("stop_loop");
      self.animnode notify("stop_first_frame");
      self notify("stop_loop");
      self notify("stop_first_frame");
    }

    self stopanimscripted();
    self unlink();
    var_2 = 250;
    self.moveplaybackrate = level.shark_attack_playbackrate;
    self.movetransitionrate = self.moveplaybackrate;
    self.goalheight = 150;
    self.goalradius = 64;
    thread shark_chase_player();

    for(;;) {
      var_1 = bulletTrace(self.origin, level.player.origin, 0, self);

      if(var_1["fraction"] >= 0.95 && distance(level.player.origin, self.origin) <= var_2) {
        break;
      }

      wait 0.1;
    }
  }

  self notify("chomp");
  maps\_utility::delaythread(0.9, common_scripts\utility::flag_set, "no_shark_heartbeat");
  maps\_utility::delaythread(0.6, maps\_utility::smart_radio_dialogue_interrupt, "shipg_hsh_adam");
  var_3 = getdirectionfacing(self.angles, self.origin, level.player.origin);
  shark_kill_front(self, "shark_attack_" + var_3);
  return 1;
}

getdirectionfacing(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 >= 315 || var_7 <= 45)
    var_8 = "F";
  else if(var_7 < 135)
    var_8 = "R";
  else if(var_7 < 255)
    var_8 = "B";
  else
    var_8 = "L";

  return var_8;
}

restore_attack_flag_on_death() {
  self waittill("death");

  if(isDefined(self))
    playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), self, "j_spineupper");

  common_scripts\utility::flag_clear("shark_eating_player");
  level.shark_attack_playbackrate = level.shark_attack_playbackrate + 1.5;
}

shark_chase_player() {
  self endon("chomp");
  self endon("death");

  for(;;) {
    self setgoalpos(level.player.node_closest.origin);
    wait 0.25;
  }
}

waittill_goal_or_dist() {
  self endon("death");
  childthread maps\_utility::notify_delay("timeout", 0.8);
  self endon("goal");
  self endon("timeout");

  while(distance(level.player.origin, self.origin) > self.goalradius)
    wait 0.05;
}

notify_spotted_on_damage() {
  self endon("death");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player)
    common_scripts\utility::flag_set("_stealth_spotted");
}

make_swimmer() {
  if(self.team == "allies") {
    return;
  }
  if(self.type == "dog") {
    return;
  }
  if(!isDefined(self.swimmer) || self.swimmer == 0)
    thread maps\_swim_ai::enable_swim();
}

delete_on_notify(var_0) {
  if(!isDefined(var_0))
    var_0 = "level_cleanup";

  self endon("death");
  level waittill(var_0);

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  self delete();
}

baker_noncombat() {
  level.baker clearenemy();
  level.baker.alertlevel = "noncombat";
  level.baker.a.combatendtime = gettime() - 10000;
}

moveto_rotateto(var_0, var_1, var_2, var_3) {
  self moveto(var_0.origin, var_1, var_2, var_3);
  self rotateto(var_0.angles, var_1, var_2, var_3);
  self waittill("movedone");
}

set_flag_unless_triggered(var_0, var_1) {
  self endon("trigger");
  self endon("death");
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

sdv_play_sound_on_entity() {
  self vehicle_turnengineoff();
  thread maps\_utility::play_sound_on_entity("scn_shipg_minisub_passby");
}

track_hint_up() {
  common_scripts\utility::flag_clear("player_can_rise");
  level.player notifyonplayercommand("pressed_up", "+frag");
  level.player notifyonplayercommand("pressed_up", "+gostand");
  level.player waittill("pressed_up");
  common_scripts\utility::flag_set("player_can_rise");
}

track_hint_down() {
  common_scripts\utility::flag_clear("player_can_fall");
  level.player notifyonplayercommand("pressed_down", "+smoke");
  level.player notifyonplayercommand("pressed_down", "+toggleprone");
  level.player notifyonplayercommand("pressed_down", "+stance");
  level.player waittill("pressed_down");
  common_scripts\utility::flag_set("player_can_fall");
}

track_hint_sprint() {
  common_scripts\utility::flag_clear("player_can_sprint");
  level.player notifyonplayercommand("pressed_sprint", "+sprint");
  level.player notifyonplayercommand("pressed_sprint", "+sprint_zoom");
  level.player notifyonplayercommand("pressed_sprint", "+breath_sprint");
  level.player waittill("pressed_sprint");
  common_scripts\utility::flag_set("player_can_sprint");
}

hintup_test() {
  return common_scripts\utility::flag("player_can_rise");
}

hintdown_test() {
  return common_scripts\utility::flag("player_can_fall");
}

hintsprint_test() {
  return common_scripts\utility::flag("player_can_sprint");
}

hintflashlight_test() {
  return !level.player maps\_utility::ent_flag("flashlight_on");
}

sardines_path_sound(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "scn_fish_swim_away";

  var_2 = common_scripts\utility::get_target_ent(var_0);
  var_2 waittill("trigger");
  var_3 = getent(var_0, "target");
  common_scripts\utility::waitframe();
  var_3.pieces[0] thread maps\_utility::play_sound_on_entity(var_1);
}

sardines_path_sound_no_trigger(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "scn_fish_swim_away";

  var_2 = getent(var_0, "script_noteworthy");
  common_scripts\utility::waitframe();
  var_2.pieces[0] thread maps\_utility::play_sound_on_entity(var_1);
}

delete_fish_in_volume(var_0) {
  var_0 = common_scripts\utility::get_target_ent(var_0);
  var_1 = getEntArray("interactive_fish_bannerfish", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(var_3 istouching(var_0))
        var_3 delete();
    }

    common_scripts\utility::waitframe();
  }
}

trigger_multiple_fx_volume_off_target() {
  wait 1;
  self waittill("trigger");
  var_0 = common_scripts\utility::get_target_ent();
  maps\_utility::fx_volume_pause(var_0);
}

try_to_melee_player(var_0) {
  level endon(var_0);
  level.player endon("death");

  if(!common_scripts\utility::flag(var_0)) {
    level endon(var_0);

    for(var_1 = getaiarray("axis"); var_1.size > 0; var_1 = getaiarray("axis")) {
      var_1 = sortbydistance(var_1, level.player.origin);
      var_2 = undefined;

      foreach(var_4 in var_1) {
        if(distance(var_4.origin, level.player.origin) > 200) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        var_2 childthread enemy_attempt_melee();
        var_6 = var_2 common_scripts\utility::waittill_any_return("death", "start_melee");

        if(var_6 == "start_melee")
          wait 90;
        else
          wait 0.5;

        continue;
      }

      wait 2;
    }
  }
}

enemy_attempt_melee() {
  level.player endon("death");
  self endon("death");
  maps\_utility::ent_flag_init("adjusting_position");
  self.ignoreme = 1;
  self.favoriteenemy = level.player;
  self setthreatbiasgroup("ignoring_baker");
  self.turnrate = 1;
  self.moveplaybackrate = 2;
  self.movetransitionrate = self.moveplaybackrate;
  self.goalradius = 128;
  self.goalheight = 96;
  self setgoalentity(level.player, 50);

  for(;;) {
    self.goalradius = 128;

    while(distance2d(self.origin, level.player.origin) > self.goalradius + 64)
      wait 0.05;

    self.goalradius = 128;
    var_0 = self aiphysicstrace(self.origin, level.player getEye(), undefined, undefined, 1, 1);

    if(var_0["fraction"] < 0.99) {
      thread enemy_melee_readjust();
      wait 0.2;
      continue;
    } else if(distance2d(self.origin, level.player.origin) <= self.goalradius + 64) {
      break;
    }
  }

  self notify("start_melee");
  self.health = 900;
  thread enemy_melee_front(self);
}

enemy_melee_readjust() {
  if(maps\_utility::ent_flag("adjusting_position")) {
    return;
  }
  self notify("adjusting_pos");
  self endon("start_melee");
  self endon("adjusting_pos");
  self endon("death");
  maps\_utility::ent_flag_set("adjusting_position");
  maps\_utility::delaythread(2, maps\_utility::ent_flag_clear, "adjusting_position");
  var_0 = getnodesinradiussorted(level.player.origin, self.goalradius + 64, 64, self.goalheight);

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      var_3 = self aiphysicstrace(self.origin, level.player getEye(), undefined, undefined, 1, 1);

      if(var_3["fraction"] > 0.99) {
        self setgoalpos(var_2.origin);
        self waittill("goal");
        self setgoalentity(level.player, 50);
        return;
      } else
        common_scripts\utility::waitframe();
    }
  }
}

enemy_melee_front(var_0, var_1) {
  playFXOnTag(common_scripts\utility::getfx("rebreather_hose_bubbles"), var_0.scuba_org, "tag_origin");
  var_0 unlink();
  var_0 notify("stop_loop");

  if(isDefined(var_0.anim_node))
    var_0.anim_node notify("stop_loop");

  if(!isDefined(var_1))
    var_1 = "melee_A";

  level.player.pre_melee_origin = level.player.origin;
  var_2 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = vectortoangles(level.player.origin - var_0.origin);
  var_3 = level.player.origin;
  var_4 = anglesToForward(level.player.angles);
  var_5 = anglestoright(level.player.angles);
  var_6 = (0, 0, 48);
  var_7 = maps\_player_rig::get_player_rig();
  var_7.origin = level.player.origin - var_6;
  var_7.angles = level.player.angles;
  var_7 hide();
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_8.origin = var_7.origin;
  var_8.angles = var_7.angles;
  var_8 linkto(var_7, "tag_player", var_6, (0, 0, 0));
  var_9 = var_0 gettagorigin("tag_inhand");
  var_10 = var_0 gettagangles("tag_inhand");
  var_0 attach("weapon_parabolic_knife", "tag_inhand", 1);
  level.player thread melee_dof();
  var_0 thread maps\_utility::magic_bullet_shield();
  var_2 thread maps\_anim::anim_single_solo(var_7, var_1);
  var_2 thread maps\_anim::anim_generic(var_0, var_1);
  level.player disableweapons();
  level.player enabledeathshield(1);
  var_11 = 0.5;
  level.player playerlinktoblend(var_8, "tag_origin", var_11, var_11, 0);
  var_7 common_scripts\utility::delaycall(var_11, ::show);
  level.player maps\_utility::delaythread(2, ::player_panic_bubbles);
  wait 2.4;

  if(level.player.health < 60)
    melee_kill_stab(var_0, var_1, var_7, var_2);
  else
    melee_damage_stab(var_0, var_1, var_7, var_2);
}

melee_damage_stab(var_0, var_1, var_2, var_3) {
  level.player endon("melee_button_pressed");
  level.player thread melee_wait_for_player_input();
  level.player thread melee_hint();
  level.player thread melee_acknowledge_player_input(var_0, var_1, var_2, var_3, 0);
  var_3 waittill(var_1);
  level.player notify("melee_done");
  level.player thread melee_damage(var_0, var_1, var_2, var_3);
}

melee_damage(var_0, var_1, var_2, var_3) {
  level.player notify("melee_win", 0);
  var_3 thread maps\_anim::anim_generic(var_0, var_1 + "_stab1");
  var_3 thread maps\_anim::anim_single_solo(var_2, var_1 + "_stab1");
  level waittill("stab");
  var_4 = var_0 gettagorigin("tag_knife_fx");
  level.player dodamage(200, var_4);
  level.player playrumbleonentity("damage_heavy");
  level.player thread maps\_utility::play_sound_on_entity("generic_death_enemy_1");
  wait 0.1;
  var_4 = var_0 gettagorigin("tag_knife_fx");
  var_3 waittill(var_1 + "_stab1");
  var_3 thread maps\_anim::anim_generic(var_0, var_1 + "_reset");
  var_3 thread maps\_anim::anim_single_solo(var_2, var_1 + "_reset");
  common_scripts\utility::noself_delaycall(0.2, ::playfxontag, common_scripts\utility::getfx("knife_stab_blood"), var_0, "tag_knife_fx");
  wait 0.65;
  level.player endon("melee_button_pressed");
  setslowmotion(1, 0.4, 0.1);
  level.player thread melee_wait_for_player_input();
  level.player thread melee_hint();
  level.player thread melee_acknowledge_player_input(var_0, var_1, var_2, var_3, 1);
  var_3 waittill(var_1 + "_reset");
  level.player notify("melee_done");
  level.player thread melee_lose(var_0, var_1, var_2, var_3);
}

melee_kill_stab(var_0, var_1, var_2, var_3) {
  level.player endon("melee_button_pressed");
  setslowmotion(1, 0.4, 0.1);
  level.player thread melee_wait_for_player_input();
  level.player thread melee_hint();
  level.player thread melee_acknowledge_player_input(var_0, var_1, var_2, var_3, 1);
  var_3 waittill(var_1);
  level.player notify("melee_done");
  level.player thread melee_lose(var_0, var_1, var_2, var_3);
}

melee_lose(var_0, var_1, var_2, var_3) {
  level.player notify("melee_win", 0);
  setslowmotion(0.4, 1, 0.1);
  var_3 thread maps\_anim::anim_generic(var_0, var_1 + "_stab2");
  var_3 thread maps\_anim::anim_single_solo(var_2, var_1 + "_stab2");
  var_3 waittill(var_1 + "_stab2");
  var_3 thread maps\_anim::anim_generic(var_0, var_1 + "_lose");
  var_3 thread maps\_anim::anim_single_solo(var_2, var_1 + "_lose");
  wait 0.1;
  var_4 = var_0 gettagorigin("tag_knife_fx");
  playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_4);
  level.player dodamage(90, var_4);
  level.player thread maps\_utility::play_sound_on_entity("generic_death_enemy_1");
  wait 0.1;
  playFX(common_scripts\utility::getfx("swim_ai_death_blood"), level.player getEye());
  level.player enabledeathshield(0);
  level.player kill();
}

melee_acknowledge_player_input(var_0, var_1, var_2, var_3, var_4) {
  level.player endon("melee_done");
  level.player waittill("melee_button_pressed");
  level.player notify("melee_win", 1);
  level.player enabledeathshield(0);
  level.player enableinvulnerability();
  var_0 maps\_utility::stop_magic_bullet_shield();
  var_0.allowdeath = 1;
  var_5 = var_2 gettagorigin("tag_knife_attach");
  var_6 = var_2 gettagangles("tag_knife_attach");
  var_2 attach("viewmodel_knife", "tag_knife_attach", 0);

  if(var_4)
    setslowmotion(0.4, 1, 0.25);

  level.player maps\_utility::delaythread(2.8, ::melee_player_lerp_back, var_2);
  var_3 thread maps\_anim::anim_generic(var_0, var_1 + "_win");
  var_3 thread maps\_anim::anim_single_solo(var_2, var_1 + "_win");
  level waittill("stab");
  var_7 = var_2 gettagorigin("tag_knife_fx");
  var_0 thread animscripts\death::playdeathsound();
  playFX(common_scripts\utility::getfx("swim_ai_blood_impact"), var_7);
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), var_0, "j_spineupper");
  level.player notify("melee_dof_adjust");
  level waittill("pull_out");
  playFXOnTag(common_scripts\utility::getfx("knife_stab_blood"), var_2, "tag_knife_fx");
  var_3 waittill(var_1 + "_win");
  stopFXOnTag(common_scripts\utility::getfx("rebreather_hose_bubbles"), var_0.scuba_org, "tag_origin");
  var_0.a.nodeath = 1;
  var_0.nodeathsound = 1;
  var_0 detach("weapon_parabolic_knife", "tag_inhand");
  var_0 kill();
  playFXOnTag(common_scripts\utility::getfx("swim_ai_death_blood"), var_0, "j_spineupper");
  var_2 delete();
  level.player enableweapons();
  level.player disableinvulnerability();
}

melee_player_lerp_back(var_0) {
  var_0 hide();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = level.player.pre_melee_origin;
  var_1.angles = level.player.angles;
  var_2 = 0.75;
  level.player playerlinktoblend(var_1, "tag_origin", var_2, 0.2, 0.2);
  wait(var_2);
  common_scripts\utility::waitframe();
  level.player unlink();
  level.player enableweapons();
  level.player disableinvulnerability();
  level.player.pre_melee_origin = undefined;
  var_1 delete();
}

melee_wait_for_player_input() {
  level.player endon("melee_button_pressed");
  level.player endon("melee_done");

  while(level.player player_attacked())
    wait 0.05;

  while(!level.player player_attacked())
    wait 0.05;

  level.player notify("melee_button_pressed");
}

player_attacked() {
  return isalive(self) && self meleeButtonPressed();
}

melee_hint() {
  if(isDefined(self.meleehintelem))
    self.meleehintelem maps\_hud_util::destroyelem();

  self.meleehintelem = maps\_hud_util::createclientfontstring("default", 3);
  self.meleehintelem.color = (1, 1, 1);
  self.meleehintelem settext(&"SCRIPT_PLATFORM_DOG_HINT");
  self.meleehintelem.x = 25;
  self.meleehintelem.y = -30;
  self.meleehintelem.alignx = "center";
  self.meleehintelem.aligny = "middle";
  self.meleehintelem.horzalign = "center";
  self.meleehintelem.vertalign = "middle";
  self.meleehintelem.foreground = 1;
  self.meleehintelem.alpha = 1;
  self.meleehintelem.hidewhendead = 1;
  self.meleehintelem.sort = -1;
  self.meleehintelem endon("death");
  self waittill("melee_win", var_0);
  thread melee_hint_fade(var_0);
}

melee_hint_fade(var_0) {
  if(isDefined(self) && isDefined(self.meleehintelem)) {
    var_1 = self.meleehintelem;

    if(var_0) {
      var_2 = 0.5;
      var_1 changefontscaleovertime(var_2);
      var_1.fontscale = var_1.fontscale * 1.5;
      var_1.glowcolor = (0.3, 0.6, 0.3);
      var_1.glowalpha = 1;
      var_1 fadeovertime(var_2);
      var_1.color = (0, 0, 0);
      var_1.alpha = 0;
      wait(var_2);
      var_1 maps\_hud_util::destroyelem();
    } else
      var_1 maps\_hud_util::destroyelem();
  }
}

melee_dof() {
  common_scripts\utility::flag_set("pause_dynamic_dof");
  maps\_art::dof_enable_script(0, 10, 10, 70, 100, 10, 0.5);
  level.player waittill("melee_dof_adjust");
  maps\_art::dof_disable_script(1);
  wait 1;
  common_scripts\utility::flag_clear("pause_dynamic_dof");
}

e3_text_hud(var_0, var_1) {
  var_2 = 27;
  var_3 = newhudelem();
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  var_3.x = 0;
  var_3.y = 0;
  var_3 settext(var_0);
  var_3.alpha = 0;
  var_3.font = "objective";
  var_3.foreground = 1;
  var_3.sort = 150;
  var_3.color = (0.85, 0.93, 0.92);
  var_3.fontscale = 1.75;
  var_3 fadeovertime(0.5);
  var_3.alpha = 1;
  var_3 fadeovertime(1);
  var_3.alpha = 1;
  wait 1;
  wait(var_1);
  var_3 fadeovertime(1);
  var_3.alpha = 0;
  wait 1;
  var_3 destroy();
}

greenlight_check() {
  return getdvarint("e3", 0);
}

is_demo_check() {
  return getdvarint("demo_mode", 0);
}

game_is_pc() {
  if(level.xenon)
    return 0;

  if(level.ps3)
    return 0;

  if(level.ps4)
    return 0;

  if(level.xb3)
    return 0;

  return 1;
}

cull_trigger_logic() {
  if(!isDefined(self.script_index)) {
    return;
  }
  for(;;) {
    if(level.player istouching(self))
      setculldist(self.script_index);

    wait 1;
  }
}

shark_collision_setup() {
  level.shark_collsions = getEntArray("shark_col", "targetname");

  foreach(var_1 in level.shark_collsions) {
    var_1.is_available = 1;
    var_1.original_origin = var_1.origin;
  }
}

find_available_collision_model() {
  if(!isDefined(level.shark_collsions)) {
    return;
  }
  for(var_0 = 0; var_0 < level.shark_collsions.size; var_0++) {
    if(level.shark_collsions[var_0].is_available) {
      level.shark_collsions[var_0].is_available = 0;
      level.shark_collsions[var_0].origin = self.origin;
      level.shark_collsions[var_0].angles = self.angles;
      level.shark_collsions[var_0] linkto(self);
      self.shark_collision_model = level.shark_collsions[var_0];
      break;
    }
  }
}

return_collision_model() {
  if(!isDefined(level.shark_collsions) || !isDefined(self.shark_collision_model)) {
    return;
  }
  self.shark_collision_model unlink();
  self.shark_collision_model.origin = self.shark_collision_model.original_origin;
  self.shark_collision_model.is_available = 1;
}

go_to_nodes_off_sub() {
  self waittill("jumpedout");

  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    self setgoalnode(var_0);
  }
}