/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_vehicle.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_helicopter_sounds;

init_vehicles() {
  level.vehicles_inited = 1;
}

vehicle_rumble(localclientnum) {
  self endon("entityshutdown");

  if(!isDefined(self.rumbletype) || self.rumbleradius == 0) {
    return;
  }
  if(!isDefined(self.rumbleon))
    self.rumbleon = 1;

  height = self.rumbleradius * 2;
  zoffset = -1 * self.rumbleradius;
  self.player_touching = 0;
  radius_squared = self.rumbleradius * self.rumbleradius;
  wait 2;

  while(true) {
    if(distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() == 0) {
      wait 0.2;
      continue;
    }

    if(isDefined(self.rumbleon) && !self.rumbleon) {
      wait 0.2;
      continue;
    }

    self playrumblelooponentity(localclientnum, self.rumbletype);

    while(distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 0) {
      self earthquake(self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
      wait(self.rumblebasetime + randomfloat(self.rumbleadditionaltime));
    }

    self stoprumble(localclientnum, self.rumbletype);
  }
}

vehicle_treads(localclientnum) {
  waittillframeend;

  if(!isDefined(level.vehicles_inited) || !isDefined(self.treadfx)) {
    return;
  }
  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }
  if(self is_plane()) {
    return;
  }
  if(self.vehicleclass == "boat" && self.vehicletype != "inc_base_jump_spotlight") {
    tag = self.vehicletype == "boat_soct_player" ? "tag_body" : "tag_wake";
    self thread wake(localclientnum, tag);
    self thread splash(localclientnum);
    self thread splash_small();

    if(issubstr(self.vehicletype, "soct")) {
      self thread boat_tread(localclientnum, "tag_wheel_back_left", "back_left");
      self thread boat_tread(localclientnum, "tag_wheel_back_right", "back_right");
    }
  } else if(self.vehicleclass == "motorcycle")
    self thread tread(localclientnum, "tag_wheel_back", "back_left");
  else {
    self thread tread(localclientnum, "tag_wheel_back_left", "back_left");
    self thread tread(localclientnum, "tag_wheel_back_right", "back_right");
  }
}

vehicle_kill_treads_forever() {
  self notify("kill_treads_forever");
}

get_throttle_effect(throttle) {
  if(isDefined(self.throttlefx)) {
    if(throttle < 0.3)
      return self.throttlefx[0];
    else if(throttle < 0.7)
      return self.throttlefx[1];
    else
      return self.throttlefx[2];
  }

  return undefined;
}

wake_mon(localclientnum) {
  self endon("entityshutdown");
  self waittill("kill_treads_forever");

  if(isDefined(self.wake_fxhandle)) {
    deletefx(localclientnum, self.wake_fxhandle, 0);
    self.wake_fxhandle = undefined;
  }
}

wake(localclientnum, tagname) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  treadfx = treadget(self, "back_left");

  if(treadfx == -1) {
    return;
  }
  offset = vectorscale((0, 0, -1), 10.0);
  self thread wake_mon(localclientnum);

  if(isDefined(self.wake_fxhandle))
    deletefx(localclientnum, self.wake_fxhandle, 0);

  self.wake_fxhandle = undefined;
  wakestate = -1;

  for(;;) {
    speed = self getspeed();

    if(!isDefined(self.wakefx)) {
      if(abs(speed) < 100 || !self isvehicleinwater()) {
        if(isDefined(self.wake_fxhandle)) {
          deletefx(localclientnum, self.wake_fxhandle, 0);
          self.wake_fxhandle = undefined;
        }
      } else if(!isDefined(self.wake_fxhandle))
        self.wake_fxhandle = playfxontag(localclientnum, treadfx, self, tagname);
    } else if(self isvehicleinwater()) {
      newstate = 0;

      if(speed > 150 && self getthrottle() < 0)
        newstate = 0;
      else if(speed < 70)
        newstate = 1;
      else if(speed < 300)
        newstate = 2;
      else if(speed < 600)
        newstate = 3;
      else
        newstate = 4;

      if(wakestate != newstate) {
        if(isDefined(self.wake_fxhandle)) {
          deletefx(localclientnum, self.wake_fxhandle, 0);
          self.wake_fxhandle = undefined;
        }

        wakestate = newstate;
        fx = self.wakefx[wakestate];
        self.wake_fxhandle = playfxontag(localclientnum, fx, self, tagname);
      }

      throttle = self getthrottle();

      if(throttle > 0.0) {
        throttleeffect = self get_throttle_effect(throttle);

        if(isDefined(throttleeffect)) {
          effectorigin = self gettagorigin(tagname);
          fwd = self gettagforwardvector(tagname);
          playfx(localclientnum, throttleeffect, effectorigin, fwd);
        }
      }
    } else {
      wakestate = -1;

      if(isDefined(self.wake_fxhandle)) {
        deletefx(localclientnum, self.wake_fxhandle, 0);
        self.wake_fxhandle = undefined;
      }
    }

    wait 0.1;
  }
}

splash(localclientnum) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");

  if(!isDefined(self.splashfx)) {
    return;
  }
  wasinwater = 1;
  offset = vectorscale((0, 0, -1), 10.0);
  last_water_check_pos = self.origin + anglestoforward(self.angles) * 100 + offset;

  for(;;) {
    wait 0.5;
    water_check_pos = self.origin + anglestoforward(self.angles) * 100 + offset;
    water_height = getwaterheight(water_check_pos);
    isinwater = water_check_pos[2] < water_height;
    vertical_speed = water_check_pos[2] - last_water_check_pos[2];

    if(!wasinwater && isinwater) {
      vertical_speed = water_check_pos[2] - last_water_check_pos[2];

      if(self getspeed() > 300 && vertical_speed < -2) {
        splashorigin = self gettagorigin("snd_bow_center");
        effectorigin = self gettagorigin("tag_wake");
        fwd = self gettagforwardvector("tag_wake");
        playfx(localclientnum, self.splashfx, effectorigin, fwd);
        id = playsound(0, "veh_boat_splash", splashorigin);
      }
    }

    wasinwater = isinwater;
    last_water_check_pos = water_check_pos;
  }
}

splash_small() {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  offset = vectorscale((0, 0, -1), 10.0);
  wait(randomfloat(0.5));

  for(;;) {
    water_check_pos = self.origin + anglestoforward(self.angles) * 100 + offset;
    wait 0.5;
    water_check_pos_2 = self.origin + anglestoforward(self.angles) * 100 + offset;
    water_height = getwaterheight(water_check_pos);
    isinwater = water_check_pos[2] < water_height;
    vertical_speed = water_check_pos[2] - water_check_pos_2[2];

    if(isinwater) {
      vertical_speed = water_check_pos_2[2] - water_check_pos[2];

      if(self getspeed() > 100 && vertical_speed < -0.6) {
        splashorigin = self gettagorigin("snd_bow_center");

        if(!isDefined(splashorigin))
          splashorigin = self gettagorigin("tag_origin");

        id = playsound(0, "veh_boat_splash_small", splashorigin);
        wait 1.6;
      }
    }
  }
}

tread(localclientnum, tagname, side) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  treadfx = treadget(self, side);

  if(treadfx == -1) {
    return;
  }
  wait(randomfloat(0.5));

  for(;;) {
    speed = self getspeed();

    if(speed == 0 || speed > -1 && speed < 1) {
      wait 0.11;
      continue;
    }

    if(speed > 350)
      waittime = 0.1;
    else if(speed < 166)
      waittime = 0.3;
    else
      waittime = 35 / speed;

    wait(waittime);
    treadfx = treadget(self, side);

    if(treadfx != -1) {
      forwardvec = self gettagforwardvector(tagname);

      if(!isDefined(forwardvec)) {
        return;
      }
      effectorigin = self gettagorigin(tagname);
      forwardvec = vectorscale(forwardvec, waittime);
      playfx(localclientnum, treadfx, effectorigin, (0, 0, 0) - forwardvec);
    }
  }
}

treadget(vehicle, side) {
  if(vehicle.vehicleclass == "boat") {
    if(!isDefined(vehicle.treadfx["water"])) {
      println("clientside treadfx not setup for boat type( only needs water ): ", vehicle.vehicletype);

      wait 10;
      return -1;
    }

    return vehicle.treadfx["water"];
  }

  surface = self getwheelsurface(side);

  if(!isDefined(vehicle.vehicletype)) {
    treadfx = -1;
    return treadfx;
  }

  if(!isDefined(vehicle.treadfx[surface])) {
    wait 10;
    return -1;
  }

  treadfx = vehicle.treadfx[surface];
  return treadfx;
}

boat_tread(localclientnum, tagname, side) {
  self endon("entityshutdown");
  self endon("kill_treads_forever");
  level endon("kill_treads_forever");
  treadfx = treadgetboat(self, side);

  if(treadfx == -1) {
    return;
  }
  wait(randomfloat(0.5));

  for(;;) {
    speed = self getspeed();

    if(speed == 0 || speed > -1 && speed < 1) {
      wait 0.11;
      continue;
    }

    if(speed > 350)
      waittime = 0.1;
    else if(speed < 166)
      waittime = 0.3;
    else
      waittime = 35 / speed;

    wait(waittime);
    treadfx = treadgetboat(self, side);

    if(treadfx != -1) {
      forwardvec = self gettagforwardvector(tagname);

      if(!isDefined(forwardvec)) {
        return;
      }
      effectorigin = self gettagorigin(tagname);
      forwardvec = vectorscale(forwardvec, waittime);
      playfx(localclientnum, treadfx, effectorigin, (0, 0, 0) - forwardvec);
    }
  }
}

treadgetboat(vehicle, side) {
  surface = self getwheelsurface(side);

  if(!isDefined(vehicle.vehicletype) || surface == "water")
    return -1;

  if(!isDefined(vehicle.treadfx[surface])) {
    wait 10;
    return -1;
  }

  return vehicle.treadfx[surface];
}

play_exhaust(localclientnum, tag_left, tag_right) {
  if(!isDefined(tag_left))
    tag_left = "tag_engine_left";

  if(!isDefined(tag_right))
    tag_right = "tag_engine_right";

  if(isDefined(self.csf_no_exhaust) && self.csf_no_exhaust) {
    return;
  }
  if(!isDefined(self.exhaust_fx) && isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    if(!isDefined(level._effect[self.exhaustfxname]))
      level._effect[self.exhaustfxname] = loadfx(self.exhaustfxname);

    self.exhaust_fx = level._effect[self.exhaustfxname];
  }

  if(isDefined(self.exhaust_fx) && isDefined(self.exhaustfxname) && self.exhaustfxname != "") {
    if(isDefined(self) && self isalive() && isDefined(self.exhaust_fx)) {
      self.exhaust_id_left = playfxontag(localclientnum, self.exhaust_fx, self, tag_left);

      if(!isDefined(self.exhaust_id_right) && !self.oneexhaust)
        self.exhaust_id_right = playfxontag(localclientnum, self.exhaust_fx, self, tag_right);

      self thread kill_exhaust_watcher(localclientnum);
    }
  }
}

kill_exhaust_watcher(localclientnum) {
  self waittill("stop_exhaust_fx");

  if(isDefined(self.exhaust_id_left)) {
    stopfx(localclientnum, self.exhaust_id_left);
    self.exhaust_id_left = undefined;
  }

  if(isDefined(self.exhaust_id_right)) {
    stopfx(localclientnum, self.exhaust_id_right);
    self.exhaust_id_right = undefined;
  }
}

stop_exhaust(localclientnum) {
  self notify("stop_exhaust_fx");
}

build_gear(vehicletype, model, tag) {
  index = 0;

  if(isDefined(level.vehiclegearmodels)) {
    if(isDefined(level.vehiclegearmodels[vehicletype]))
      index = level.vehiclegearmodels[vehicletype].size;
  }

  level.vehiclegearmodels[vehicletype][index] = model;
  level.vehiclegeartags[vehicletype][index] = tag;
}

vehicle_variants(localclientnum) {
  if(isDefined(level.vehiclegearmodels)) {
    if(isDefined(level.vehiclegearmodels[self.vehicletype])) {
      numgear = level.vehiclegearmodels[self.vehicletype].size;
      maxgear = 2;

      if(numgear < maxgear)
        maxgear = numgear;

      randomconstantnumber = self getentitynumber();

      for(i = 0; i < maxgear; i++) {
        alreadychosen = 1;
        gearchoices[i] = -1;

        while(alreadychosen) {
          alreadychosen = 0;
          gearchoices[i] = randomconstantnumber % numgear;

          for(j = 0; j < i; j++) {
            if(level.vehiclegeartags[self.vehicletype][gearchoices[j]] == level.vehiclegeartags[self.vehicletype][gearchoices[i]]) {
              alreadychosen = 1;
              break;
            }
          }
        }

        self attach(level.vehiclegearmodels[self.vehicletype][gearchoices[i]], level.vehiclegeartags[self.vehicletype][gearchoices[i]]);
        randomconstantnumber++;
      }
    }
  }
}

aircraft_dustkick() {
  waittillframeend;
  self endon("kill_treads_forever");
  self endon("entityshutdown");

  if(isDefined(self.csf_no_tread) && self.csf_no_tread) {
    return;
  }
  if(self is_mig())
    numframespertrace = 1;
  else
    numframespertrace = 3;

  dotracethisframe = numframespertrace;
  repeatrate = 1.0;
  trace = undefined;
  d = undefined;
  trace_ent = self;

  while(isDefined(self)) {
    if(repeatrate <= 0)
      repeatrate = 1.0;

    if(self is_mig())
      repeatrate = 0.02;

    waitrealtime(repeatrate);

    if(!isDefined(self)) {
      return;
    }
    dotracethisframe--;

    if(dotracethisframe <= 0) {
      dotracethisframe = numframespertrace;
      trace = tracepoint(trace_ent.origin, trace_ent.origin - vectorscale((0, 0, 1), 100000.0));
      d = distance(trace_ent.origin, trace["position"]);

      if(d > 350)
        repeatrate = (d - 350) / (1200 - 350) * (0.2 - 0.1) + 0.1;
      else
        repeatrate = 0.1;
    }

    if(isDefined(trace)) {
      if(d > 1200) {
        repeatrate = 1.0;
        continue;
      }

      if(!isDefined(trace["surfacetype"]))
        trace["surfacetype"] = "dirt";

      if(isDefined(self.treadfx[trace["surfacetype"]]))
        playfx(0, self.treadfx[trace["surfacetype"]], trace["position"]);
      else {
        println("SCRIPT PRINT: Unknown surface type " + trace["surfacetype"] + " for vehicle type " + self.vehicletype);

        return;
      }
    }
  }
}

vehicle_weapon_fired() {
  self endon("entityshutdown");

  while(true) {
    self waittill("weapon_fired");
    players = level.localplayers;

    for(i = 0; i < players.size; i++) {
      player_distance = distancesquared(self.origin, players[i].origin);

      if(player_distance < 250000) {
        if(isDefined(self.shootrumble) && self.shootrumble != "")
          playrumbleonposition(i, self.shootrumble, self.origin + vectorscale((0, 0, 1), 32.0));
      }

      if(player_distance < 160000) {
        fraction = player_distance / 160000;
        time = 4 - 3 * fraction;

        if(isDefined(players[i])) {
          if(isDefined(self.shootshock) && self.shootshock != "")
            players[i] shellshock(i, self.shootshock, time);
        }
      }
    }
  }
}

lights_on(localclientnum) {
  lights_off(localclientnum);

  if(self.vehicletype == "spiderbot_large" || self.vehicletype == "drone_firescout_axis")
    wait 0.1;

  if(isDefined(self.light_fx)) {
    if(!isDefined(self.light_fx_handles))
      self.light_fx_handles = [];

    for(i = 0; i < self.light_fx.size; i++)
      self.light_fx_handles[i] = playfxontag(localclientnum, self.light_fx[i], self, self.lightfxtagarray[i]);
  }

  if(isDefined(self.team) && self.team == "allies") {
    if(isDefined(self.friendly_light_fx))
      self.team_light_fx_handle = playfxontag(localclientnum, self.friendly_light_fx, self, self.enemylightfxtag);
  } else if(isDefined(self.enemy_light_fx))
    self.team_light_fx_handle = playfxontag(localclientnum, self.enemy_light_fx, self, self.friendlylightfxtag);
}

lights_off(localclientnum) {
  if(isDefined(self.light_fx_handles)) {
    for(i = 0; i < self.light_fx_handles.size; i++)
      deletefx(localclientnum, self.light_fx_handles[i]);
  }

  self.light_fx_handles = undefined;

  if(isDefined(self.team_light_fx_handle)) {
    deletefx(localclientnum, self.team_light_fx_handle);
    self.team_light_fx_handle = undefined;
  }
}

vehicle_flag_toggle_sounds(localclientnum, set, newent) {
  if(self is_helicopter()) {
    if(set) {
      self notify("stop_heli_sounds");
      self.should_not_play_sounds = 1;
    } else {
      self notify("play_heli_sounds");
      self.should_not_play_sounds = 0;
    }
  } else {
  }
}

vehicle_flag_turn_off_treadfx(localclientnum, set, newent) {
  if(self is_helicopter() || self is_plane()) {
    println("****CLIENT:: Vehicle Flag Plane");

    if(set) {
      if(isDefined(newent) && newent)
        self.csf_no_tread = 1;
      else
        self vehicle_kill_treads_forever();
    } else {
      if(isDefined(self.csf_no_tread))
        self.csf_no_tread = 0;

      self vehicle_kill_treads_forever();
      self thread aircraft_dustkick();
    }
  } else if(set) {
    println("****CLIENT:: Vehicle Flag Tread FX Set");

    if(isDefined(newent) && newent) {
      println("****CLIENT:: TreadFX NewEnt: " + self getentitynumber());

      self.csf_no_tread = 1;
    } else {
      println("****CLIENT:: TreadFX OldEnt" + self getentitynumber());

      self vehicle_kill_treads_forever();
    }
  } else {
    println("****CLIENT:: Vehicle Flag Tread FX Clear");

    if(isDefined(self.csf_no_tread))
      self.csf_no_tread = 0;

    self vehicle_kill_treads_forever();
    self thread vehicle_treads(localclientnum);
  }
}

vehicle_flag_start_use_engine_damage_low_sounds(localclientnum, set, newent) {
  if(set) {
    self.engine_damage_low = 1;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  } else {
    self.engine_damage_low = 0;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  }
}

vehicle_flag_3_handler(localclientnum, set, newent) {
  if(self is_helicopter())
    vehicle_flag_start_use_engine_damage_low_sounds(localclientnum, set, newent);
  else {
  }
}

vehicle_flag_start_use_engine_damage_high_sounds(localclientnum, set, newent) {
  if(set) {
    self.engine_damage_high = 1;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  } else {
    self.engine_damage_high = 0;
    self clientscripts\_helicopter_sounds::update_helicopter_sounds();
  }
}

vehicle_flag_4_handler(localclientnum, set, newent) {
  if(self is_helicopter())
    vehicle_flag_start_use_engine_damage_high_sounds(localclientnum, set, newent);
  else {
  }
}

vehicle_flag_toggle_exhaustfx_handler(localclientnum, set, newent) {
  if(set) {
    if(isDefined(newent) && newent)
      self.csf_no_exhaust = 1;
    else
      self stop_exhaust(localclientnum);
  } else {
    if(isDefined(self.csf_no_exhaust))
      self.csf_no_exhaust = 0;

    self stop_exhaust(localclientnum);
    exhaust_tag_left = issubstr(self.vehicletype, "heli_v78") || issubstr(self.vehicletype, "osprey") ? "tag_fx_engine_left1" : "tag_engine_left";
    exhaust_tag_right = issubstr(self.vehicletype, "heli_v78") || issubstr(self.vehicletype, "osprey") ? "tag_fx_engine_right1" : "tag_engine_right";
    self play_exhaust(localclientnum, exhaust_tag_left, exhaust_tag_right);
  }
}

vehicle_flag_toggle_lights_handler(localclientnum, set, newent) {
  if(set)
    self lights_off(localclientnum);
  else
    self lights_on(localclientnum);
}

vehicle_flag_toggle_lockon_handler(localclientnum, set, newent) {
  if(set)
    self setvehiclelockedon(1);
  else
    self setvehiclelockedon(0);
}

autoexec build_damage_filter_list() {
  if(!isDefined(level.vehicle_damage_filters))
    level.vehicle_damage_filters = [];

  level.vehicle_damage_filters[0] = "generic_filter_vehicle_damage";
  level.vehicle_damage_filters[1] = "generic_filter_sam_damage";
  level.vehicle_damage_filters[2] = "generic_filter_f35_damage";
  level.vehicle_damage_filters[3] = "generic_filter_vehicle_damage_sonar";
  level.vehicle_damage_filters[4] = "generic_filter_rts_vehicle_damage";
}

init_damage_filter(materialid) {
  level.localplayers[0].damage_filter_intensity = 0;
  materialname = level.vehicle_damage_filters[materialid];
  init_filter_vehicle_damage(level.localplayers[0], materialname);
  enable_filter_vehicle_damage(level.localplayers[0], 3, materialname);
  set_filter_vehicle_damage_amount(level.localplayers[0], 3, 0);
  set_filter_vehicle_sun_position(level.localplayers[0], 3, 0, 0);
}

damage_filter_enable(localclientnum, materialid) {
  enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
  level.localplayers[0].damage_filter_intensity = 0;
  set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

damage_filter_disable(localclientnum) {
  level notify("damage_filter_off");
  level.localplayers[0].damage_filter_intensity = 0;
  set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
  disable_filter_vehicle_damage(level.localplayers[0], 3);
}

damage_filter_off(localclientnum) {
  level endon("damage_filter");
  level endon("damage_filter_off");
  level endon("damage_filter_heavy");

  if(!isDefined(level.localplayers[0].damage_filter_intensity)) {
    return;
  }
  while(level.localplayers[0].damage_filter_intensity > 0) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity - 0.0505061;

    if(level.localplayers[0].damage_filter_intensity < 0)
      level.localplayers[0].damage_filter_intensity = 0;

    set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}

damage_filter_light(localclientnum) {
  level endon("damage_filter_off");
  level endon("damage_filter_heavy");
  level notify("damage_filter");

  while(level.localplayers[0].damage_filter_intensity < 0.5) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 0.5)
      level.localplayers[0].damage_filter_intensity = 0.5;

    set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}

damage_filter_heavy(localclientnum) {
  level endon("damage_filter_off");
  level notify("damage_filter_heavy");

  while(level.localplayers[0].damage_filter_intensity < 1) {
    level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;

    if(level.localplayers[0].damage_filter_intensity > 1)
      level.localplayers[0].damage_filter_intensity = 1;

    set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
    wait 0.016667;
  }
}