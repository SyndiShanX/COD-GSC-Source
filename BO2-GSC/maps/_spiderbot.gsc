/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_spiderbot.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;

main() {
  self ent_flag_init("playing_scripted_anim");
  self build_spiderbot_anims();
  self thread watch_mounting();
  self thread spiderbot_animating();
}

#using_animtree("vehicles");

build_spiderbot_anims() {
  level.reverse = 1;
  level.idle = 2;
  level.walk = 3;
  level.run = 4;
  level.sprint = 5;
  level.jump = 6;
  self.in_air = 0;
  self.idle_state = 0;
  self.idle_anim_finished_state = 0;
  self.current_anim_speed = level.idle;
  self._animactive = 0;

  if(isDefined(level.spiderbot_anims_inited)) {
    return;
  }
  level.spiderbot_anims_inited = 1;
  level.spiderbot_speeds = [];
  level.spiderbot_speeds[level.reverse - 1] = -5000;
  level.spiderbot_speeds[level.reverse] = -23;
  level.spiderbot_speeds[level.idle] = 0;
  level.spiderbot_speeds[level.walk] = 18;
  level.spiderbot_speeds[level.run] = 400;
  level.spiderbot_speeds[level.sprint] = 500;
  level.spiderbot_speeds[level.sprint + 1] = 5000;
  level.spiderbot_anims = [];
  level.spiderbot_anims[level.reverse] = % ai_spider_walk_b;
  level.spiderbot_anims[level.idle] = % ai_spider_idle;
  level.spiderbot_anims[level.walk] = % ai_spider_walk_f;
  level.spiderbot_anims[level.run] = % ai_spider_run_f;
  level.spiderbot_anims[level.sprint] = % ai_spider_sprint_f;
  level.spiderbot_anims[level.jump] = [];
  level.spiderbot_anims[level.jump][0] = % ai_spider_idle;
  level.spiderbot_anims[level.jump][1] = % ai_spider_idle;
  level.spiderbot_anims[level.jump][2] = % ai_spider_idle;
}

precache_fx() {
}

update_idle_anim() {
}

spiderbot_animating() {
  self endon("death");
  wait 0.5;
  self.idle_end_time = 0;

  while(true) {
    speed = self getspeed();
    angular_velocity = self getangularvelocity();
    turning_speed = abs(angular_velocity[2]);
    velocity = self.velocity;
    right = anglestoright(self.angles);
    side_vel = vectordot(right, velocity);

    if(self ent_flag("playing_scripted_anim")) {
    } else if(self.in_air) {
    } else if(abs(side_vel) > 0.4 && abs(side_vel) > abs(speed)) {
      anim_rate = abs(side_vel) / 15;
      anim_rate = clamp(anim_rate, 0.0, 1.5);

      if(side_vel < speed)
        self setanimknoball( % ai_spider_strafe_l, % root, 1, 0.2, anim_rate);
      else
        self setanimknoball( % ai_spider_strafe_r, % root, 1, 0.2, anim_rate);

      self.current_anim_speed = level.walk;
    } else if(speed < -0.4) {
      self.current_anim_speed = level.reverse;
      anim_rate = speed / level.spiderbot_speeds[self.current_anim_speed];
      anim_rate = clamp(anim_rate, 0.0, 1.5);
      self setanimknoball(level.spiderbot_anims[level.reverse], % root, 1, 0.2, anim_rate);
    } else if(speed < 1 && turning_speed > 0.2) {
      anim_rate = turning_speed / 3;

      if(angular_velocity[2] > 0)
        self setanimknoball( % ai_spider_idle_turn_l, % root, 1, 0.2, anim_rate);
      else
        self setanimknoball( % ai_spider_idle_turn_r, % root, 1, 0.2, anim_rate);

      self.current_anim_speed = level.idle;
      self.idle_end_time = 0;
    } else if(speed < 0.5)
      self setanimknoball(level.spiderbot_anims[self.current_anim_speed], % root, 1, 0.2, 0);
    else {
      next_anim_delta = level.spiderbot_speeds[self.current_anim_speed + 1] - level.spiderbot_speeds[self.current_anim_speed];
      next_anim_speed = level.spiderbot_speeds[self.current_anim_speed] + next_anim_delta * 0.6;
      prev_anim_delta = level.spiderbot_speeds[self.current_anim_speed] - level.spiderbot_speeds[self.current_anim_speed - 1];
      prev_anim_speed = level.spiderbot_speeds[self.current_anim_speed] - prev_anim_delta * 0.6;

      if(speed > next_anim_speed)
        self.current_anim_speed++;
      else if(speed < prev_anim_speed)
        self.current_anim_speed--;

      if(self.current_anim_speed <= level.idle)
        self.current_anim_speed = level.walk;

      anim_rate = speed / level.spiderbot_speeds[self.current_anim_speed];
      anim_rate = clamp(anim_rate, 0.0, 1.5);
      self setanimknoball(level.spiderbot_anims[self.current_anim_speed], % root, 1, 0.2, anim_rate);
    }

    wait 0.05;
  }
}

check_for_landing() {
  self waittill("veh_landed");
  self.already_landed = 1;
}

watch_for_jump() {
  self endon("death");
  self endon("no_driver");

  while(true) {
    if(self.driver jumpbuttonpressed() && !self.in_air && !self ent_flag("playing_scripted_anim")) {
      self.in_air = 1;
      v_movement = vectornormalize(level.player getnormalizedmovement() + (0, 0, 1));
      v_forward = anglestoforward(self.angles);
      v_right = anglestoright(self.angles);
      v_up = anglestoup(self.angles);

      if(v_up[2] < 0.7071)
        v_force = v_up * 165;
      else {
        v_forward = v_forward * v_movement[0];
        v_right = v_right * v_movement[1];
        v_up = v_up * v_movement[2];
        v_orientation = vectornormalize(v_forward + v_right + v_up);
        v_force = v_orientation * 165;
      }

      self.driver setclientdvar("phys_vehicleGravityMultiplier", 0.5);
      self launchvehicle(v_force, (0, 0, 0), 0);
      self playsound("veh_spiderbot_jump");
      self.already_landed = 0;
      anim_rate = 1;
      self setanimknoball(level.spiderbot_anims[level.jump][0], % root, 1, 0.1, anim_rate);
      self waittill_notify_or_timeout("veh_landed", 2);
      self.driver setclientdvar("phys_vehicleGravityMultiplier", 1.0);
      n_restart_time = gettime() + 0.2;

      while(gettime() < n_restart_time && self.driver jumpbuttonpressed())
        wait 0.05;

      self.in_air = 0;
    }

    while(self.driver jumpbuttonpressed())
      wait 0.05;

    wait 0.05;
  }
}

watch_for_fall() {
  while(true) {
    self waittill("veh_inair");

    if(!self.in_air) {
      self.in_air = 1;
      self setanimknoball(level.spiderbot_anims[level.jump][1], % root, 1, 0.1, 1);
      self waittill_notify_or_timeout("veh_landed", 1);
      self.in_air = 0;
    } else
      self waittill("veh_landed");
  }
}

watch_mounting() {
  self endon("death");
  n_gravity = getdvarfloat(#"bg_gravity");

  while(true) {
    self waittill("enter_vehicle", player);
    setsaveddvar("player_standingViewHeight", level.default_player_height);
    self.driver = player;
    self thread watch_for_jump();
    self thread watch_for_fall();
    maps\_vehicle::lights_on();
    self waittill("exit_vehicle");
    self notify("no_driver");
    maps\_vehicle::lights_off();
    self.driver = undefined;
  }
}