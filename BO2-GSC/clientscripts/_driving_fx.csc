/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_driving_fx.csc
*****************************************/

#include clientscripts\_utility;
#include clientscripts\_audio;

init() {
  level._customvehiclecbfunc = ::vehicle_spawned_callback;
  level.vehicletypecallbackarray = [];
}

add_vehicletype_callback(vehicletype, callback) {
  if(!isDefined(level.vehicletypecallbackarray))
    init();

  level.vehicletypecallbackarray[vehicletype] = callback;
}

vehicle_spawned_callback(localclientnum) {
  vehicletype = self.vehicletype;

  if(isDefined(level.vehicletypecallbackarray[vehicletype]))
    self thread[[level.vehicletypecallbackarray[vehicletype]]](localclientnum);
}

dirt_overlay_control(localclientnum) {
  showui(localclientnum, "fullscreen_dirt", 1);
  showui(localclientnum, "fullscreen_dust", 1);
  self waittill("entityshutdown");
  showui(localclientnum, "fullscreen_dirt", 0);
  showui(localclientnum, "fullscreen_dust", 0);
}

dirt_surface_type(surface_type) {
  switch (surface_type) {
    case "dirt":
    case "foliage":
    case "grass":
    case "gravel":
    case "mud":
    case "sand":
    case "snow":
    case "water":
      return true;
  }

  return false;
}

correct_surface_type_for_screen_fx() {
  right_rear = self getwheelsurface("back_right");
  left_rear = self getwheelsurface("back_left");

  if(dirt_surface_type(right_rear))
    return "dirt";

  if(dirt_surface_type(left_rear))
    return "dirt";

  return "dust";
}

play_screen_fx_dirt(localclientnum) {
  pick_one = randomintrange(0, 4);

  if(pick_one == 0)
    animateui(localclientnum, "fullscreen_dirt", "dirt", "in", 0);
  else if(pick_one == 1)
    animateui(localclientnum, "fullscreen_dirt", "dirt_right_splash", "in", 0);
  else if(pick_one == 2)
    animateui(localclientnum, "fullscreen_dirt", "dirt_left_splash", "in", 0);
  else
    animateui(localclientnum, "fullscreen_dirt", "blurred_dirt_random", "in", 0);
}

play_screen_fx_dust(localclientnum) {
  pick_one = randomintrange(0, 4);

  if(pick_one == 0)
    animateui(localclientnum, "fullscreen_dust", "dust", "in", 0);
  else if(pick_one == 1)
    animateui(localclientnum, "fullscreen_dust", "dust_right_splash", "in", 0);
  else if(pick_one == 2)
    animateui(localclientnum, "fullscreen_dust", "dust_left_splash", "in", 0);
  else
    animateui(localclientnum, "fullscreen_dust", "blurred_dust_random", "in", 0);
}

play_driving_fx_firstperson(localclientnum, speed, speed_fraction) {
  if(speed > 0 && speed_fraction >= 0.25) {
    viewangles = getlocalclientangles(localclientnum);
    pitch = angleclamp180(viewangles[0]);

    if(pitch > -10.0) {
      current_additional_time = 0;

      if(pitch < 10.0)
        current_additional_time = 1000 * ((pitch - 10.0) / (-10.0 - 10.0));

      if(self.last_screen_dirt + self.screen_dirt_delay + current_additional_time < getrealtime()) {
        screen_fx_type = self correct_surface_type_for_screen_fx();

        if(screen_fx_type == "dirt")
          play_screen_fx_dirt(localclientnum);
        else
          play_screen_fx_dust(localclientnum);

        self.last_screen_dirt = getrealtime();
        self.screen_dirt_delay = randomintrange(250, 500);
      }
    }
  }
}

play_driving_fx(localclientnum) {
  self endon("entityshutdown");
  self.last_screen_dirt = 0;
  self.screen_dirt_delay = 0;
  speed_fraction = 0;

  while(true) {
    speed = self getspeed();
    maxspeed = self getmaxspeed();

    if(speed < 0)
      maxspeed = self getmaxreversespeed();

    if(maxspeed > 0)
      speed_fraction = abs(speed) / maxspeed;
    else
      speed_fraction = 0;

    if(self iswheelcolliding("back_left") || self iswheelcolliding("back_right")) {
      if(self islocalclientdriver(localclientnum))
        play_driving_fx_firstperson(localclientnum, speed, speed_fraction);
    }

    wait 0.1;
  }
}

collision_thread(localclientnum) {
  self endon("entityshutdown");

  while(true) {
    self waittill("veh_collision", hip, hitn, hit_intensity);

    if(self islocalclientdriver(localclientnum)) {
      player = getlocalplayer(localclientnum);

      if(isDefined(player)) {
        if(hit_intensity > 15) {
          volume = get_impact_vol_from_speed();
          id = playsound(0, "veh_suspension_lg_hd", self.origin, volume);
          player earthquake(0.5, 0.5, player.origin, 200);
          player playrumbleonentity(localclientnum, "damage_heavy");
        } else {
          volume = get_impact_vol_from_speed();
          id = playsound(0, "veh_suspension_lg_lt", self.origin, volume);
          player earthquake(0.3, 0.3, player.origin, 200);
          player playrumbleonentity(localclientnum, "damage_light");
        }
      }
    }
  }
}

jump_landing_thread(localclientnum) {
  self endon("entityshutdown");

  while(true) {
    self waittill("veh_landed");

    if(self islocalclientdriver(localclientnum)) {
      player = getlocalplayer(localclientnum);

      if(isDefined(player)) {
        volume = get_impact_vol_from_speed();
        id = playsound(0, "veh_suspension_lg_hd", self.origin, volume);
        player earthquake(0.7, 1.2, player.origin, 200);
        player playrumbleonentity(localclientnum, "damage_heavy");
      }
    }
  }
}

suspension_thread(localclientnum) {
  self endon("entityshutdown");

  while(true) {
    self waittill("veh_suspension_limit_activated");

    if(self islocalclientdriver(localclientnum)) {
      player = getlocalplayer(localclientnum);

      if(isDefined(player)) {
        volume = get_impact_vol_from_speed();
        id = playsound(0, "veh_suspension_lg_lt", self.origin, volume);
        player playrumbleonentity(localclientnum, "damage_light");
      }
    }
  }
}

get_impact_vol_from_speed() {
  curspeed = self getspeed();
  maxspeed = self getmaxspeed();
  volume = scale_speed(0, maxspeed, 0, 1, curspeed);
  volume = volume * volume * volume;
  return volume;
}