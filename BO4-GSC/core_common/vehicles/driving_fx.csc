/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicles\driving_fx.csc
***********************************************/

#include scripts\core_common\audio_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\vehicle_shared;

#namespace driving_fx;

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;
  localclientnum = eventstruct.localclientnum;
  self thread vehicle_enter(localclientnum, vehicle);
}

vehicle_enter(localclientnum, vehicle) {
  self endon(#"death");
  vehicle endon(#"death");
  waitframe(1);

  if(vehicle isvehicle() && vehicle isdrivingvehicle(self)) {
    vehicle thread collision_thread(localclientnum);

    if(vehicle function_b835102b()) {
      vehicle thread jump_landing_thread(localclientnum);
      vehicle thread suspension_thread(localclientnum);
    }

    if(self function_21c0fa55()) {
      vehicle thread function_d79b3148(localclientnum, self);
      vehicle thread vehicle::lights_group_toggle(localclientnum, 1, 0);
    }
  }
}

collision_thread(localclientnum) {
  self endon(#"death");
  self endon(#"exit_vehicle");

  while(true) {
    waitresult = self waittill(#"veh_collision");
    hip = waitresult.velocity;
    hitn = waitresult.normal;
    hit_intensity = waitresult.intensity;
    player = function_5c10bd79(localclientnum);

    if(isDefined(self.driving_fx_collision_override)) {
      if(player function_21c0fa55() && self isdrivingvehicle(player)) {
        self[[self.driving_fx_collision_override]](localclientnum, player, hip, hitn, hit_intensity);
      }

      continue;
    }

    if(isDefined(player) && isDefined(hit_intensity)) {
      if(hit_intensity > self.heavycollisionspeed) {
        volume = get_impact_vol_from_speed();
        var_be2370d6 = self.var_be2370d6;

        if(isDefined(var_be2370d6)) {
          alias = var_be2370d6;
        } else {
          alias = "veh_default_suspension_lg_hd";
        }

        self playSound(localclientnum, alias, undefined, volume);

        if(isDefined(self.heavycollisionrumble) && player function_21c0fa55() && self isdrivingvehicle(player)) {
          player playrumbleonentity(localclientnum, self.heavycollisionrumble);
        }

        continue;
      }

      if(hit_intensity > self.lightcollisionspeed) {
        volume = get_impact_vol_from_speed();
        var_b3195e3c = self.var_b3195e3c;

        if(isDefined(var_b3195e3c)) {
          alias = var_b3195e3c;
        } else {
          alias = "veh_default_suspension_lg_lt";
        }

        self playSound(localclientnum, alias, undefined, volume);

        if(isDefined(self.lightcollisionrumble) && player function_21c0fa55() && self isdrivingvehicle(player)) {
          player playrumbleonentity(localclientnum, self.lightcollisionrumble);
        }
      }
    }
  }
}

jump_landing_thread(localclientnum) {
  self endon(#"death");
  self endon(#"exit_vehicle");

  while(true) {
    self waittill(#"veh_landed");
    player = function_5c10bd79(localclientnum);

    if(isDefined(player)) {
      if(isDefined(self.driving_fx_jump_landing_override)) {
        self[[self.driving_fx_jump_landing_override]](localclientnum, player);
        continue;
      }

      volume = get_impact_vol_from_speed();
      var_be2370d6 = self.var_be2370d6;

      if(isDefined(var_be2370d6)) {
        alias = var_be2370d6;
      } else {
        alias = "veh_default_suspension_lg_hd";
      }

      self playSound(localclientnum, alias, undefined, volume);

      if(isDefined(self.jumplandingrumble) && player function_21c0fa55() && self isdrivingvehicle(player)) {
        player playrumbleonentity(localclientnum, self.jumplandingrumble);
      }
    }
  }
}

suspension_thread(localclientnum) {
  self endon(#"death");
  self endon(#"exit_vehicle");

  while(true) {
    self waittill(#"veh_suspension_limit_activated");
    player = function_5c10bd79(localclientnum);

    if(isDefined(player)) {
      volume = get_impact_vol_from_speed();
      var_b3195e3c = self.var_b3195e3c;

      if(isDefined(var_b3195e3c)) {
        alias = var_b3195e3c;
      } else {
        alias = "veh_default_suspension_lg_lt";
      }

      self playSound(localclientnum, alias, undefined, volume);

      if(player function_21c0fa55() && self isdrivingvehicle(player)) {
        player playrumbleonentity(localclientnum, "damage_light");
      }
    }
  }
}

get_impact_vol_from_speed() {
  curspeed = self getspeed();
  maxspeed = self getmaxspeed();
  volume = audio::scale_speed(0, maxspeed, 0, 1, curspeed);
  volume = volume * volume * volume;
  return volume;
}

function_b6f1b2f1() {
  var_9687e67e = array("front_right", "front_left", "middle_right", "middle_left", "back_right", "back_left");
  surfaces = [];

  foreach(var_2ada890e in var_9687e67e) {
    if(self function_387f3e55(var_2ada890e)) {
      if(!isDefined(surfaces)) {
        surfaces = [];
      } else if(!isarray(surfaces)) {
        surfaces = array(surfaces);
      }

      if(!isinarray(surfaces, function_73e08cca("water"))) {
        surfaces[surfaces.size] = function_73e08cca("water");
      }
    }

    if(!isDefined(surfaces)) {
      surfaces = [];
    } else if(!isarray(surfaces)) {
      surfaces = array(surfaces);
    }

    if(!isinarray(surfaces, function_73e08cca(self getwheelsurface(var_2ada890e)))) {
      surfaces[surfaces.size] = function_73e08cca(self getwheelsurface(var_2ada890e));
    }
  }

  arrayremovevalue(surfaces, undefined);
  return surfaces;
}

function_73e08cca(surface) {
  switch (surface) {
    case #"dirt":
      return #"hash_69a53e8913317ecf";
    case #"water":
    case #"watershallow":
      return #"pstfx_sprite_rain_loop";
  }

  return undefined;
}

stop_postfx_on_exit(var_89ae88b4) {
  self notify("stop_postfx_on_exit_" + var_89ae88b4);
  self endon("stop_postfx_on_exit_" + var_89ae88b4);
  self waittill(#"exit_vehicle", #"death");

  if(isDefined(self) && isDefined(self.var_8e45c356) && isDefined(self.var_8e45c356[var_89ae88b4]) && self postfx::function_556665f2(var_89ae88b4)) {
    self postfx::stoppostfxbundle(var_89ae88b4);
    self.var_8e45c356[var_89ae88b4].exiting = 1;
  }
}

function_ace6c248(var_89ae88b4) {
  if(!isDefined(self.var_8e45c356)) {
    self.var_8e45c356 = [];
  }

  if(!isDefined(self.var_8e45c356[var_89ae88b4])) {
    self.var_8e45c356[var_89ae88b4] = {
      #exiting: 1, 
      #endtime: 0
    };
  }

  if(self.var_8e45c356[var_89ae88b4].exiting && !self postfx::function_556665f2(var_89ae88b4)) {
    self postfx::playpostfxbundle(var_89ae88b4);
    self thread stop_postfx_on_exit(var_89ae88b4);
    self.var_8e45c356[var_89ae88b4].exiting = 0;
  }

  self.var_8e45c356[var_89ae88b4].endtime = gettime() + 1000;
}

function_dc263531(var_fd4bffcb, forcestop) {
  if(!isDefined(self.var_8e45c356)) {
    self.var_8e45c356 = [];
  }

  foreach(key, postfx in self.var_8e45c356) {
    if(postfx.exiting) {
      continue;
    }

    if(forcestop || postfx.endtime <= gettime() && !isinarray(var_fd4bffcb, key)) {
      self postfx::exitpostfxbundle(key);
      self.var_8e45c356[key].exiting = 1;
    }
  }
}

function_d79b3148(localclientnum, driver) {
  self notify("50691db9556b2847");
  self endon("50691db9556b2847");
  self endon(#"death", #"exit_vehicle");

  if(!self isvehicle() || isDefined(self.var_da04aa74) && self.var_da04aa74) {
    return;
  }

  while(true) {
    wait 0.1;
    speed = self getspeed();
    player = function_5c10bd79(localclientnum);

    if(isDefined(self.var_c6a9216)) {
      var_89ae88b4 = self[[self.var_c6a9216]](localclientnum, driver);
    } else {
      var_89ae88b4 = self function_b6f1b2f1();
    }

    var_9dc6e5f2 = 1;

    if(isDefined(self.var_917cf8e3)) {
      var_9dc6e5f2 = self[[self.var_917cf8e3]](localclientnum, driver);
    }

    if(isDefined(self.var_41860110)) {
      var_9979f775 = self[[self.var_41860110]](localclientnum, driver);
    } else {
      var_9979f775 = speed > 200;
    }

    if(isDefined(player)) {
      if(var_9979f775 && var_9dc6e5f2) {
        foreach(postfx_bundle in var_89ae88b4) {
          player function_ace6c248(postfx_bundle);
        }
      }

      player function_dc263531(var_89ae88b4, !var_9979f775 || !var_9dc6e5f2);
    }
  }
}