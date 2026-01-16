/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_snowmobile.gsc
*******************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("snowmobile", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_snowmobile", "vehicle_snowmobile_static");
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_unload_groups(::unload_groups);

  if(!isDefined(anim._effect))
    anim._effect = [];

  maps\_vehicle::build_light(var_2, "headlight_truck_left", "tag_headlight_left", "fx/misc/car_headlight_jeep_l_clk", "headlights");
  maps\_vehicle::build_light(var_2, "headlight_truck_right", "tag_headlight_right", "fx/misc/car_headlight_jeep_r_clk", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_right", "TAG_TAIL_LIGHT_LEFT", "fx/misc/car_taillight_jeep_r_clk", "headlights");
  maps\_vehicle::build_light(var_2, "taillight_truck_left", "TAG_TAIL_LIGHT_LEFT", "fx/misc/car_taillight_jeep_l_clk", "headlights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_right", "TAG_TAIL_LIGHT_LEFT", "fx/misc/car_brakelight_truck_R_pb", "brakelights");
  maps\_vehicle::build_light(var_2, "brakelight_truck_left", "TAG_TAIL_LIGHT_LEFT", "fx/misc/car_brakelight_truck_L_pb", "brakelights");
  anim._effect["snowmobile_leftground"] = loadfx("fx/treadfx/bigair_snow_snowmobile_emitter");
  anim._effect["snowmobile_bumpbig"] = loadfx("fx/treadfx/bigjump_land_snow_snowmobile");
  anim._effect["snowmobile_bump"] = loadfx("fx/treadfx/smalljump_land_snow_snowmobile");
  maps\_vehicle::build_single_tread();
}

init_local() {
  self.driver_shooting = 0;
  self.passenger_shooting = 1;
  self.steering_enable = 1;
  self.steering_maxroll = 15;
  self.steering_maxdelta = 0.15;
  self.steering = 0;
  self.update_time = -1;
  self.kill_my_fx = 0;

  if(!maps\_utility::is_specialop())
    thread do_steering();

  self.bigjump_timedelta = 500;
  self.event_time = -1;
  self.event = [];
  self.event["jump"] = [];
  self.event["jump"]["driver"] = 0;
  self.event["jump"]["passenger"] = 0;
  self.event["bump"] = [];
  self.event["bump"]["driver"] = 0;
  self.event["bump"]["passenger"] = 0;
  self.event["bump_big"] = [];
  self.event["bump_big"]["driver"] = 0;
  self.event["bump_big"]["passenger"] = 0;
  self.event["sway_left"] = [];
  self.event["sway_left"]["driver"] = 0;
  self.event["sway_left"]["passenger"] = 0;
  self.event["sway_right"] = [];
  self.event["sway_right"]["driver"] = 0;
  self.event["sway_right"]["passenger"] = 0;
  thread watchvelocity();
  thread listen_leftground();
  thread listen_landed();
  thread listen_jolt();
  thread listen_collision();
  thread setridershooting();

  if(issubstr(self.vehicletype, "player")) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("viewmodel_glock");
    var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_0 hideallparts();
  }
}

init_rider() {
  self.ridingvehicle.steering = 0;
  self.onsnowmobile = 1;
  self.custom_animscript["combat"] = animscripts\snowmobile::main;
  self.custom_animscript["stop"] = animscripts\snowmobile::main;
}

watchvelocity() {
  self endon("death");
  var_0 = self vehicle_getvelocity();

  for(;;) {
    self.prevframevelocity = var_0;
    var_0 = self vehicle_getvelocity();
    wait 0.05;
  }
}

setridershooting() {
  self endon("death");
  waittillframeend;

  if(self.riders.size == 1) {
    self.driver_shooting = 1;
    self.passenger_shooting = 0;
  }
}

snowmobile_fx(var_0) {
  if(isDefined(anim._effect[var_0]))
    playFXOnTag(anim._effect[var_0], self, "tag_deathfx");
}

listen_leftground() {
  self endon("death");

  for(;;) {
    self waittill("veh_leftground");

    if(self.kill_my_fx == 0) {
      self.event_time = gettime();
      self.event["jump"]["driver"] = 1;
      self.event["jump"]["passenger"] = 1;
      snowmobile_fx("snowmobile_leftground");
      wait 1;
    }
  }
}

listen_landed() {
  self endon("death");

  for(;;) {
    self waittill("veh_landed");

    if(self.kill_my_fx == 0) {
      if(self.event_time + self.bigjump_timedelta < gettime()) {
        self.event["bump_big"]["driver"] = 1;
        self.event["bump_big"]["passenger"] = 1;
        snowmobile_fx("snowmobile_bumpbig");
        continue;
      }

      self.event["bump"]["driver"] = 1;
      self.event["bump"]["passenger"] = 1;
      snowmobile_fx("snowmobile_bump");
    }
  }
}

listen_jolt() {
  self endon("death");

  for(;;) {
    self waittill("veh_jolt", var_0);

    if(self.kill_my_fx == 0) {
      if(var_0[1] >= 0) {
        self.event["sway_left"]["driver"] = 1;
        self.event["sway_left"]["passenger"] = 1;
        snowmobile_fx("snowmobile_sway_left");
        continue;
      }

      self.event["sway_right"]["driver"] = 1;
      self.event["sway_right"]["passenger"] = 1;
      snowmobile_fx("snowmobile_sway_right");
    }
  }
}

listen_collision() {
  self endon("death");

  for(;;) {
    self waittill("veh_collision", var_0, var_1);

    foreach(var_3 in self.riders) {
      if(isalive(var_3) && !isDefined(var_3.magic_bullet_shield)) {
        var_3.specialdeathfunc = animscripts\snowmobile::snowmobile_collide_death;
        var_3 kill();
      }
    }

    if(self.kill_my_fx == 0)
      snowmobile_fx("snowmobile_collision");
  }
}

#using_animtree("vehicles");

do_steering() {
  self endon("death");
  wait 0.05;
  self setanimknoball( % snowmobile, % root, 1, 0);
  self setanimlimited( % sm_turn, 1, 0);

  for(;;) {
    maps\_vehicle_code::update_steering(self);

    if(self.steering_enable) {
      if(self.steering >= 0) {
        self setanimknoblimited( % snowmobile_vehicle_lean_r_delta, 1, 0, 0);
        self setanimtime( % snowmobile_vehicle_lean_r_delta, self.steering);
      } else {
        self setanimknoblimited( % snowmobile_vehicle_lean_l_delta, 1, 0, 0);
        self setanimtime( % snowmobile_vehicle_lean_l_delta, abs(self.steering));
      }
    } else {
      self clearanim( % snowmobile_vehicle_lean_r_delta, 0);
      self clearanim( % snowmobile_vehicle_lean_l_delta, 0);
    }

    wait 0.05;
  }
}

init_snowmobile_mount_anims() {
  level.snowmobile_mount_anims = [];
  level.snowmobile_mount_anims["snowmobile_passenger"] = [];
  level.snowmobile_mount_anims["snowmobile_driver"] = [];

  foreach(var_2, var_1 in level.scr_anim["generic"]) {
    if(issubstr(var_2, "snowmobile_passenger_mount")) {
      level.snowmobile_mount_anims["snowmobile_passenger"][var_2] = 1;
      continue;
    }

    if(issubstr(var_2, "snowmobile_driver_mount"))
      level.snowmobile_mount_anims["snowmobile_driver"][var_2] = 1;
  }
}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  level.scr_anim["generic"]["snowmobile_passenger_mount_dir1"] = % snowmobile_passenger_mount_dir3;
  level.scr_anim["generic"]["snowmobile_passenger_mount_dir3"] = % snowmobile_passenger_mount_dir1;
  level.scr_anim["generic"]["snowmobile_driver_mount_dir3"] = % snowmobile_driver_mount_dir3;
  level.scr_anim["generic"]["snowmobile_driver_mount_dir1"] = % snowmobile_driver_mount_dir1;
  level.scr_anim["generic"]["snowmobile_passenger_mount_dir1_short"] = % snowmobile_passenger_mount_dir3_short;
  level.scr_anim["generic"]["snowmobile_passenger_mount_dir3_short"] = % snowmobile_passenger_mount_dir1_short;
  level.scr_anim["generic"]["snowmobile_driver_mount_dir3_short"] = % snowmobile_driver_mount_dir3_short;
  level.scr_anim["generic"]["snowmobile_driver_mount_dir1_short"] = % snowmobile_driver_mount_dir1_short;
  level.scr_anim["snowmobile"]["driver"]["idle"] = % snowmobile_driver_aiming_idle;
  level.scr_anim["snowmobile"]["driver"]["drive"] = % snowmobile_driver_driving_idle;
  level.scr_anim["snowmobile"]["driver"]["left2right"] = % snowmobile_driver_lean_l2r;
  level.scr_anim["snowmobile"]["driver"]["right2left"] = % snowmobile_driver_lean_r2l;
  level.scr_anim["snowmobile"]["driver"]["fire"] = % snowmobile_driver_autofire;
  level.scr_anim["snowmobile"]["driver"]["single"] = % snowmobile_driver_fire;
  level.scr_anim["snowmobile"]["driver"]["drive_jump"] = % snowmobile_driver_driving_jump_01;
  level.scr_anim["snowmobile"]["driver"]["drive_bump"] = % snowmobile_driver_driving_bump_01;
  level.scr_anim["snowmobile"]["driver"]["drive_bump_big"] = % snowmobile_driver_driving_bump_02;
  level.scr_anim["snowmobile"]["driver"]["drive_sway_left"] = % snowmobile_driver_driving_swayl_01;
  level.scr_anim["snowmobile"]["driver"]["drive_sway_right"] = % snowmobile_driver_driving_swayr_01;
  level.scr_anim["snowmobile"]["driver"]["shoot_jump"] = % snowmobile_driver_aiming_jump_01;
  level.scr_anim["snowmobile"]["driver"]["shoot_bump"] = % snowmobile_driver_aiming_bump_01;
  level.scr_anim["snowmobile"]["driver"]["shoot_bump_big"] = % snowmobile_driver_aiming_bump_02;
  level.scr_anim["snowmobile"]["driver"]["shoot_sway_left"] = % snowmobile_driver_aiming_swayl_01;
  level.scr_anim["snowmobile"]["driver"]["shoot_sway_right"] = % snowmobile_driver_aiming_swayr_01;
  level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["left"] = % snowmobile_driver_aim4l_add;
  level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["center"] = % snowmobile_driver_aim4c_add;
  level.scr_anim["snowmobile"]["driver"]["add_aim_left"]["right"] = % snowmobile_driver_aim4r_add;
  level.scr_anim["snowmobile"]["driver"]["straight_level"]["left"] = % snowmobile_driver_aim5l;
  level.scr_anim["snowmobile"]["driver"]["straight_level"]["center"] = % snowmobile_driver_aim5c;
  level.scr_anim["snowmobile"]["driver"]["straight_level"]["right"] = % snowmobile_driver_aim5r;
  level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["left"] = % snowmobile_driver_aim6l_add;
  level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["center"] = % snowmobile_driver_aim6c_add;
  level.scr_anim["snowmobile"]["driver"]["add_aim_right"]["right"] = % snowmobile_driver_aim6r_add;
  level.scr_anim["snowmobile"]["passenger"]["hide"] = % snowmobile_passenger_hide;
  level.scr_anim["snowmobile"]["passenger"]["drive"] = % snowmobile_passenger_driving_idle;
  level.scr_anim["snowmobile"]["passenger"]["add_lean"]["left"] = % snowmobile_passenger_lean_l;
  level.scr_anim["snowmobile"]["passenger"]["add_lean"]["right"] = % snowmobile_passenger_lean_r;
  level.scr_anim["snowmobile"]["passenger"]["idle"] = % snowmobile_passenger_aiming_idle;
  level.scr_anim["snowmobile"]["passenger"]["fire"] = % snowmobile_passenger_autofire;
  level.scr_anim["snowmobile"]["passenger"]["single"] = % snowmobile_passenger_fire;
  level.scr_anim["snowmobile"]["passenger"]["reload"] = % snowmobile_passenger_reload;
  level.scr_anim["snowmobile"]["passenger"]["gun_down"] = % snowmobile_passenger_aim2hide;
  level.scr_anim["snowmobile"]["passenger"]["gun_up"] = % snowmobile_passenger_hide2aim;
  level.scr_anim["snowmobile"]["passenger"]["hide_jump"] = % snowmobile_passenger_driving_jump_01;
  level.scr_anim["snowmobile"]["passenger"]["hide_bump"] = % snowmobile_passenger_driving_bump_01;
  level.scr_anim["snowmobile"]["passenger"]["hide_bump_big"] = % snowmobile_passenger_driving_bump_02;
  level.scr_anim["snowmobile"]["passenger"]["hide_sway_left"] = % snowmobile_passenger_driving_swayl_01;
  level.scr_anim["snowmobile"]["passenger"]["hide_sway_right"] = % snowmobile_passenger_driving_swayr_01;
  level.scr_anim["snowmobile"]["passenger"]["drive_jump"] = % snowmobile_passenger_aiming_jump_01;
  level.scr_anim["snowmobile"]["passenger"]["drive_bump"] = % snowmobile_passenger_aiming_bump_01;
  level.scr_anim["snowmobile"]["passenger"]["drive_bump_big"] = % snowmobile_passenger_aiming_bump_02;
  level.scr_anim["snowmobile"]["passenger"]["drive_sway_left"] = % snowmobile_passenger_aiming_swayl_01;
  level.scr_anim["snowmobile"]["passenger"]["drive_sway_right"] = % snowmobile_passenger_aiming_swayr_01;
  level.scr_anim["snowmobile"]["passenger"]["aim_left"]["left"] = % snowmobile_passenger_aim4l;
  level.scr_anim["snowmobile"]["passenger"]["aim_left"]["center"] = % snowmobile_passenger_aim4c;
  level.scr_anim["snowmobile"]["passenger"]["aim_left"]["right"] = % snowmobile_passenger_aim4r;
  level.scr_anim["snowmobile"]["passenger"]["aim_right"]["left"] = % snowmobile_passenger_aim6l;
  level.scr_anim["snowmobile"]["passenger"]["aim_right"]["center"] = % snowmobile_passenger_aim6c;
  level.scr_anim["snowmobile"]["passenger"]["aim_right"]["right"] = % snowmobile_passenger_aim6r;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["left"] = % snowmobile_passenger_aim1l_add;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["center"] = % snowmobile_passenger_aim1c_add;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backleft"]["right"] = % snowmobile_passenger_aim1r_add;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["left"] = % snowmobile_passenger_aim3l_add;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["center"] = % snowmobile_passenger_aim3c_add;
  level.scr_anim["snowmobile"]["passenger"]["add_aim_backright"]["right"] = % snowmobile_passenger_aim3r_add;
  level.scr_anim["snowmobile"]["passenger"]["straight_level"]["left"] = % snowmobile_passenger_aim5l;
  level.scr_anim["snowmobile"]["passenger"]["straight_level"]["center"] = % snowmobile_passenger_aim5c;
  level.scr_anim["snowmobile"]["passenger"]["straight_level"]["right"] = % snowmobile_passenger_aim5r;
  level.scr_anim["snowmobile"]["big"]["death"]["back"] = % snowmobile_driver_death_b_01;
  level.scr_anim["snowmobile"]["big"]["death"]["left"] = % snowmobile_driver_death_l_01;
  level.scr_anim["snowmobile"]["big"]["death"]["front"] = % snowmobile_driver_death_f_01;
  level.scr_anim["snowmobile"]["big"]["death"]["right"] = % snowmobile_driver_death_r_01;
  level.scr_anim["snowmobile"]["small"]["death"]["back"] = % snowmobile_driver_death_b_03;
  level.scr_anim["snowmobile"]["small"]["death"]["left"] = % snowmobile_driver_death_l_03;
  level.scr_anim["snowmobile"]["small"]["death"]["right"] = % snowmobile_driver_death_r_03;
  init_snowmobile_mount_anims();
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].sittag = "tag_driver";
  var_0[0].linktoblend = 1;
  var_0[0].rider_func = ::init_rider;
  var_0[1].sittag = "tag_passenger";
  var_0[1].linktoblend = 1;
  var_0[1].rider_func = ::init_rider;
  var_0[0].getout = % snowmobile_driver_dismount;
  var_0[1].getout = % snowmobile_passenger_dismount;
  return var_0;
}

unload_groups() {
  var_0 = [];
  var_0["all"] = [];
  var_1 = "all";
  var_0[var_1][var_0[var_1].size] = 0;
  var_0[var_1][var_0[var_1].size] = 1;
  var_0["default"] = var_0["all"];
  return var_0;
}