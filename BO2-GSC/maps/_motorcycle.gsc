/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_motorcycle.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include animscripts\utility;
#include animscripts\shared;
#include animscripts\shoot_behavior;
#include animscripts\weaponlist;

main() {
  build_aianims(::setanims, ::set_vehicle_anims);
}

#using_animtree("generic_human");

setanims() {
  positions = [];

  for(i = 0; i < 1; i++)
    positions[i] = spawnstruct();

  positions[0].sittag = "tag_driver";
  positions[0].idle = % crew_bike_m72_drive_straight;
  positions[0].getin = % crew_bike_m72_drive_straight;
  positions[0].getout = % crew_bike_m72_drive_straight;
  return positions;
}

set_vehicle_anims(positions) {
  return positions;
}

ride_and_shoot(bike) {
  self.ridingvehicle = bike;
  self animcustom(::ai_ride_and_shoot);
}

ai_ride_and_shoot() {
  self endon("death");
  self endon("start_ragdoll");
  self endon("stop_riding");
  self.bikerisarmed = 0;
  self.bikerisaiming = 0;
  self.bikershouldjump = 0;
  self.bikershouldland = 0;
  self.prevbikeryawaimweight = 0;
  self.prevbikerpitchaimweight = 0;
  self.prevsideanimweight = 99999;
  self.max_bike_aim_yaw_angle = 70;
  self.max_bike_aim_pitch_angle = 60;
  self.max_bike_aim_angle_delta = 30;
  self.max_bike_side_yaw_angle = 90;

  if(!isDefined(self.max_bike_total_yaw_angle))
    self.max_bike_total_yaw_angle = self.max_bike_side_yaw_angle + self.max_bike_aim_yaw_angle;

  self.max_bike_roll_angle = 30;

  if(!isDefined(self.min_blindspot_time))
    self.min_blindspot_time = 0.5;

  blindspottime = 0;

  if(!isDefined(level.ai_motorcycle_death_launch_vector))
    level.ai_motorcycle_death_launch_vector = (200, 200, 40);

  self maps\_utility::disable_pain();
  self maps\_utility::disable_react();
  self.overrideactordamage = ::ai_ride_and_shoot_damage_override;
  self animscripts\shared::placeweaponon(self.primaryweapon, "left");
  self animmode("point relative");
  self.fixedlinkyawonly = 0;
  self ai_ride_and_shoot_linkto_bike();
  self ai_ride_and_shoot_idle();
  self thread ai_ride_and_shoot_watch_jump();
  self thread animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");

  while(true) {
    if(isDefined(self.shootent)) {
      shootpos = self.shootent getshootatpos(self);
      shootfrompos = self animscripts\shared::trackloopgetshootfrompos();
      shootfromangles = self animscripts\shared::trackloopgetshootfromangles();
      vectortoshootpos = shootpos - shootfrompos;
      anglestoshootpos = vectortoangles(vectortoshootpos);
      facingvector = anglestoforward(shootfromangles);
      yawtoenemy = angleclamp180(shootfromangles[1] - anglestoshootpos[1]);
      pitchtoenemy = angleclamp180(shootfromangles[0] - anglestoshootpos[0]);
      realyawtoenemy = self getyawtoorigin(shootpos);

      if(abs(realyawtoenemy) < self.max_bike_total_yaw_angle) {
        if(!self.bikerisarmed) {
          self ai_ride_and_shoot_gun_pullout();
          continue;
        }

        yawaimweight = abs(yawtoenemy / self.max_bike_aim_yaw_angle);
        aimdelta = yawaimweight - self.prevbikeryawaimweight;
        maxweightchange = self.max_bike_aim_angle_delta / self.max_bike_aim_yaw_angle;

        if(abs(aimdelta) > maxweightchange)
          yawaimweight = self.prevbikeryawaimweight + maxweightchange * sign(aimdelta);

        if(yawaimweight > 1)
          yawaimweight = 1;

        if(yawtoenemy < 0) {
          self setanimlimited( % moto_aim_4, yawaimweight, 0.05);
          self setanimlimited( % moto_aim_6, 0, 0.05);
        } else {
          self setanimlimited( % moto_aim_6, yawaimweight, 0.05);
          self setanimlimited( % moto_aim_4, 0, 0.05);
        }

        pitchaimweight = abs(pitchtoenemy / self.max_bike_aim_pitch_angle);

        if(abs(pitchaimweight) > 1)
          pitchaimweight = sign(pitchaimweight);

        aimdelta = pitchaimweight - self.prevbikerpitchaimweight;
        maxweightchange = self.max_bike_aim_angle_delta / self.max_bike_aim_pitch_angle;

        if(abs(aimdelta) > maxweightchange)
          pitchaimweight = self.prevbikerpitchaimweight + maxweightchange * sign(aimdelta);

        if(pitchtoenemy < 0) {
          self setanimlimited( % moto_aim_2, pitchaimweight, 0.05);
          self setanimlimited( % moto_aim_8, 0, 0.05);
        } else {
          self setanimlimited( % moto_aim_8, pitchaimweight, 0.05);
          self setanimlimited( % moto_aim_2, 0, 0.05);
        }

        self.prevbikeryawaimweight = yawaimweight;
        self.prevbikerpitchaimweight = pitchaimweight;
        blindspottime = 0;
      } else {
        blindspottime = blindspottime + 0.05;

        if(blindspottime > self.min_blindspot_time) {
          self ai_ride_and_shoot_gun_blindfire();
          self ai_ride_and_shoot_gun_putaway(0);
          blindspottime = 0;
          continue;
        } else if(self.bikerisarmed)
          self ai_ride_and_shoot_gun_putaway();
      }
    } else if(self.bikerisarmed)
      self ai_ride_and_shoot_gun_putaway();

    if(self.bikerisarmed)
      self ai_ride_and_shoot_aim_idle();
    else
      self ai_ride_and_shoot_idle();

    wait 0.05;
  }
}

ai_ride_stop_riding() {
  self endon("death");
  self endon("start_ragdoll");
  self notify("stop_riding");
  self clearanim( % root, 0);
  self unlink();
}

ai_ride_and_shoot_linkto_bike() {
  assert(isDefined(self.ridingvehicle));
  tag_driver_origin = self.ridingvehicle gettagorigin("tag_driver");
  tag_driver_angles = self.ridingvehicle gettagangles("tag_driver");
  self forceteleport(tag_driver_origin, tag_driver_angles);
  self linkto(self.ridingvehicle, "tag_driver");
  self clearanim( % root, 0);
}

ai_ride_and_shoot_aiming_on(sideanimweight) {
  if(!isDefined(sideanimweight))
    sideanimweight = 0;

  if(sideanimweight < 0) {
    sideanimweight = abs(sideanimweight);
    self setanimknoblimited( % crew_bike_m72_aim_l_2, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_l_4, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_l_6, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_l_8, sideanimweight, 0);

    if(sideanimweight > 0.5)
      self setflaggedanimlimited("fireAnim", % crew_bike_m72_l_fire, sideanimweight, 0);
    else
      self setanimlimited( % crew_bike_m72_l_fire, sideanimweight, 0);
  } else {
    self setanimknoblimited( % crew_bike_m72_aim_r_2, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_r_4, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_r_6, sideanimweight, 0);
    self setanimknoblimited( % crew_bike_m72_aim_r_8, sideanimweight, 0);

    if(sideanimweight > 0.5)
      self setflaggedanimlimited("fireAnim", % crew_bike_m72_r_fire, sideanimweight, 0);
    else
      self setanimlimited( % crew_bike_m72_r_fire, sideanimweight, 0);
  }

  self setanimlimited( % crew_bike_m72_aim_f_2, 1 - sideanimweight, 0);
  self setanimlimited( % crew_bike_m72_aim_f_4, 1 - sideanimweight, 0);
  self setanimlimited( % crew_bike_m72_aim_f_6, 1 - sideanimweight, 0);
  self setanimlimited( % crew_bike_m72_aim_f_8, 1 - sideanimweight, 0);

  if(sideanimweight < 1) {
    if(sideanimweight < 0.5)
      self setflaggedanimlimited("fireAnim", % crew_bike_m72_f_fire, 1 - sideanimweight, 0);
    else
      self setanimlimited( % crew_bike_m72_f_fire, 1 - sideanimweight, 0);
  }

  self animscripts\weaponlist::refillclip();
}

ai_ride_and_shoot_idle() {
  if(self.bikershouldjump) {
    self ai_ride_and_shoot_jump();
    return;
  }

  self.bikerisaiming = 0;
  self.bikerisarmed = 0;
  self setanim( % crew_bike_m72_drive_straight, 1 - 0, 0.2, 1);
}

ai_ride_and_shoot_aim_idle(blendtime) {
  if(self.bikershouldjump) {
    self ai_ride_and_shoot_jump();
    return;
  }

  self.bikerisaiming = 1;
  assert(isDefined(self.shootent));
  realyawtoenemy = self getyawtoorigin(self.shootent.origin);
  sideanimweight = realyawtoenemy / self.max_bike_side_yaw_angle;

  if(abs(sideanimweight) > 1)
    sideanimweight = sign(sideanimweight);

  if(self.prevsideanimweight == sideanimweight) {
    return;
  }
  self.prevsideanimweight = sideanimweight;
  ai_ride_and_shoot_aiming_on(sideanimweight);

  if(!isDefined(blendtime))
    blendtime = 0.05;

  if(sideanimweight < 0) {
    sideanimweight = abs(sideanimweight);
    self setanim( % crew_bike_m72_aim_l_5, sideanimweight, blendtime, 1);
    self setanim( % crew_bike_m72_aim_r_5, 0, blendtime, 1);
  } else {
    self setanim( % crew_bike_m72_aim_r_5, sideanimweight, blendtime, 1);
    self setanim( % crew_bike_m72_aim_l_5, 0, blendtime, 1);
  }

  self setanim( % crew_bike_m72_aim_f_5, 1 - sideanimweight, blendtime, 1);
}

ai_ride_and_shoot_lean() {
  rollanimweight = abs(self.ridingvehicle.angles[2]) / self.max_bike_roll_angle;

  if(rollanimweight > 1)
    rollanimweight = 1;

  if(self.bikerisaiming) {
    if(self.ridingvehicle.angles[2] < 0) {
      self setanim( % crew_bike_m72_lean_left_armed, rollanimweight, 0.2, 1);
      self setanim( % crew_bike_m72_lean_right_armed, 0, 0.2, 1);
    } else {
      self setanim( % crew_bike_m72_lean_left_armed, 0, 0.2, 1);
      self setanim( % crew_bike_m72_lean_right_armed, rollanimweight, 0.2, 1);
    }
  } else if(self.ridingvehicle.angles[2] < 0) {
    self setanim( % crew_bike_m72_lean_left_unarmed, rollanimweight, 0.2, 1);
    self setanim( % crew_bike_m72_lean_right_unarmed, 0, 0.2, 1);
  } else {
    self setanim( % crew_bike_m72_lean_left_unarmed, 0, 0.2, 1);
    self setanim( % crew_bike_m72_lean_right_unarmed, rollanimweight, 0.2, 1);
  }

  return rollanimweight;
}

ai_ride_and_shoot_gun_pullout() {
  self setflaggedanimknoballrestart("ride", % crew_bike_m72_aim_gun_pullot, % body, 1, 0.2, 1);
  self waittillmatch("ride", "end");
  self.prevsideanimweight = 99999;

  if(isDefined(self.shootent)) {
    self clearanim( % crew_bike_m72_aim_gun_pullot, 0.2);
    self clearanim( % crew_bike_m72_lean_left_unarmed, 0.2);
    self clearanim( % crew_bike_m72_lean_right_unarmed, 0.2);
    self.bikerisarmed = 1;
    self.prevbikeryawaimweight = 0;
    self.prevbikerpitchaimweight = 0;
    self ai_ride_and_shoot_aim_idle(0.2);
    wait 0.2;
    self thread ai_ride_and_shoot_gun_shoot();
  } else
    self ai_ride_and_shoot_gun_putaway(0);
}

ai_ride_and_shoot_gun_putaway(aimforwardtime) {
  self notify("stopShooting");
  self setanim( % moto_fire, 0, 0);

  if(!isDefined(aimforwardtime))
    aimforwardtime = 0.3;

  self setanimlimited( % moto_aim_4, 0, aimforwardtime);
  self setanimlimited( % moto_aim_6, 0, aimforwardtime);
  wait(aimforwardtime);
  self setflaggedanimknoballrestart("ride", % crew_bike_m72_aim_gun_putaway, % body, 1, 0.2, 1);
  self waittillmatch("ride", "end");
  self clearanim( % crew_bike_m72_aim_gun_putaway, 0.2);
  self clearanim( % crew_bike_m72_lean_left_armed, 0.2);
  self clearanim( % crew_bike_m72_lean_right_armed, 0.2);
  self.bikerisarmed = 0;
  self ai_ride_and_shoot_idle();
}

ai_ride_and_shoot_gun_shoot() {
  self endon("death");
  self endon("stopShooting");
  self endon("start_ragdoll");
  self setanim( % moto_fire, 1, 0);

  while(true) {
    self waittillmatch("fireAnim", "fire");
    self shootenemywrapper();
    wait 0.05;
  }
}

ai_ride_and_shoot_jump() {
  self endon("death");
  self endon("start_ragdoll");

  if(self.bikerisarmed) {
    self notify("stopShooting");
    self setflaggedanimknoballrestart("jump", % crew_bike_m72_jump_start_armed, % body, 1, 0.2, 1);

    while(!self.bikershouldland)
      wait 0.05;

    self setflaggedanimknoballrestart("jump", % crew_bike_m72_jump_land_armed, % body, 1, 0.2, 1);
    self waittillmatch("jump", "end");
    self clearanim( % crew_bike_m72_jump_land_armed, 0.2);
    self.prevsideanimweight = 99999;
    self thread ai_ride_and_shoot_gun_shoot();
  } else {
    self setflaggedanimknoballrestart("jump", % crew_bike_m72_jump_start_unarmed, % body, 1, 0.2, 1);

    while(!self.bikershouldland)
      wait 0.05;

    self setflaggedanimknoballrestart("jump", % crew_bike_m72_jump_land_unarmed, % body, 1, 0.2, 1);
    self waittillmatch("jump", "end");
    self clearanim( % crew_bike_m72_jump_land_unarmed, 0.2);
  }

  self.bikershouldjump = 0;

  if(self.bikerisarmed && isDefined(self.shootent))
    self ai_ride_and_shoot_aim_idle();
  else
    self ai_ride_and_shoot_idle();
}

ai_ride_and_shoot_watch_jump() {
  self endon("death");
  self endon("start_ragdoll");

  while(true) {
    self.ridingvehicle waittill("veh_inair");
    self.bikershouldland = 0;
    self.bikershouldjump = 1;
    self.ridingvehicle waittill("veh_landed");
    self.bikershouldland = 1;
    self.bikershouldjump = 0;
  }
}

ai_ride_and_shoot_gun_blindfire() {
  self notify("stopShooting");

  if(!self.bikerisarmed) {
    self setflaggedanimknoballrestart("ride", % crew_bike_m72_aim_gun_pullot, % body, 1, 0.2, 1);
    self waittillmatch("ride", "end");
    self.prevsideanimweight = 99999;
    self clearanim( % crew_bike_m72_aim_gun_pullot, 0.2);
    self clearanim( % crew_bike_m72_lean_left_unarmed, 0.2);
    self clearanim( % crew_bike_m72_lean_right_unarmed, 0.2);
    self.bikerisarmed = 1;
  }

  self setflaggedanimknoballrestart("blindfire", % crew_bike_m72_blindfire, % body, 1, 0.2, 1);
  self animscripts\shared::donotetracks("blindfire");
  self clearanim( % crew_bike_m72_blindfire, 0.2);
  self thread ai_ride_and_shoot_gun_shoot();
  self.prevsideanimweight = 99999;
}

ai_ride_and_shoot_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
  self.deathfunction = ::ai_ride_and_shoot_ragdoll_death;
  return self.health + 10;
}

ai_ride_and_shoot_ragdoll_death() {
  self.a.doingragdolldeath = 1;
  self animscripts\shared::dropallaiweapons();
  velocity = anglestoforward(self.angles);
  assert(isDefined(level.ai_motorcycle_death_launch_vector));
  velocity = (velocity[0] * level.ai_motorcycle_death_launch_vector[0], velocity[1] * level.ai_motorcycle_death_launch_vector[1], level.ai_motorcycle_death_launch_vector[2]);
  self unlink();
  self startragdoll();
  self launchragdoll(velocity);

  recordline(self.origin, self.origin + velocity, (1, 0, 0), "Script", self);

  return true;
}