/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_helicopter_ai.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_death;
#include maps\_turret;

helicopter_think(target) {
  target_set(self);
  self.takedamage = 1;
  self.attack_range_min = 500;
  self.attack_range_max = 1000;
  self.attack_circle_range = 2000;
  self.attack_right_range = 1000;
  self.attack_move_frequency = 2;

  if(isDefined(target))
    self.cur_target = target;

  self thread helicopter_movement();
  self thread helicopter_fire_update2();
}

circle_target() {
  self notify("movementUpdate");
  self endon("movementUpdate");
  self endon("death");
  self clearlookatent();
  vec_from_target = self.origin - self.cur_target.origin;
  yaw = vectortoangles(vec_from_target)[1];

  if(lengthsquared(vec_from_target) < self.attack_circle_range * self.attack_circle_range)
    yaw = yaw + 180;

  while(true) {
    offset = anglestoforward((0, yaw, 0));

    while(!isDefined(self.cur_target))
      wait 1;

    goal = self.cur_target.origin;
    yaw = yaw + 2.0;
    goal = goal + offset * self.attack_circle_range;

    circle(goal, 100, (1, 1, 1), 0, 1);
    line(self.origin, goal, (0, 1, 0), 1, 1, 1);

    ret = goal;
    self setvehgoalpos((goal[0], goal[1], self.cur_target.origin[2] + 1500), 1);
    self cleartargetyaw();
    wait 0.1;
  }
}

setup_defenses() {
}

attack_target() {
  self notify("movementUpdate");
  self endon("movementUpdate");
  self endon("death");
  self thread setup_defenses();
  self clearvehgoalpos();
  self cancelaimove();
  self maps\_turret::add_turret_priority_target(self.cur_target, 0);

  while(isDefined(self.cur_target)) {
    self setlookatent(self.cur_target);
    vec_to_attacker = self.cur_target.origin - self.origin;
    vec_to_attacker = vectornormalize(vec_to_attacker);

    if(self.cur_target isvehicle()) {
      driver = self.cur_target getseatoccupant(0);

      if(isDefined(driver)) {
        vec_to_attacker = vec_to_attacker - anglestoforward(driver getplayerangles());
        vec_to_attacker = vectornormalize(vec_to_attacker);
      }
    } else if(isplayer(self.cur_target)) {
      vec_to_attacker = vec_to_attacker - anglestoforward(self.cur_target getplayerangles());
      vec_to_attacker = vectornormalize(vec_to_attacker);
    }

    right = vectorcross(vec_to_attacker, (0, 0, 1));
    start_pos = self.cur_target.origin - vec_to_attacker * randomfloatrange(self.attack_range_min, self.attack_range_max);
    self setvehgoalpos(start_pos + right * self.attack_right_range, 1);
    self waittill("goal");
    self thread helicopter_fire_rockets();
    self setvehgoalpos(start_pos + right * (self.attack_right_range * -1), 1);
    self waittill("goal");
    self thread helicopter_fire_rockets();
    wait(self.attack_move_frequency);
  }

  self thread circle_target();
}

helicopter_fire_rockets() {
  self setgunnertargetent(self.cur_target, vectorscale((0, 0, 1), 20.0), 0);
  self setgunnertargetent(self.cur_target, vectorscale((0, 0, 1), 20.0), 1);
  self firegunnerweapon(0);
  self firegunnerweapon(1);
}

helicopter_fire_barrage(target) {
  self endon("movementUpdate");
  self endon("death");
  self endon("stop_fire_barrage");

  while(isDefined(target) && distance2dsquared(self.origin, target.origin) > 250000) {
    self firegunnerweapon(0);
    wait 0.5;
    self firegunnerweapon(1);
    wait 0.5;
  }
}

helicopter_damage_watcher() {
  self endon("death");

  while(true) {
    self waittill("damage", damage, attacker, dir, point, type);

    if(isDefined(attacker)) {
      if(isplayer(attacker) && isDefined(attacker.viewlockedentity) && attacker.viewlockedentity isvehicle())
        attacker = attacker.viewlockedentity;

      if(isDefined(self.attacker) && self.attacker == attacker) {
        continue;
      }
      self.cur_target = attacker;
      self thread attack_target();
    }
  }
}

helicopter_movement() {
  self endon("death");
  self setheliheightlock(1);

  while(true) {
    if(isDefined(self.cur_target))
      self attack_target();
    else
      wait 0.05;
  }
}

helicopter_fire_update() {
  self endon("death");
  self maps\_turret::set_turret_burst_parameters(2, 5, 4, 6, 0);
  self thread maps\_turret::enable_turret(0, 0);
  self maps\_turret::set_turret_target_flags(11, 0);

  while(true)
    wait 1;
}

helicopter_fire_update2() {
  self notify("fireUpdate");
  self endon("fireUpdate");
  self endon("death");

  while(true) {
    if(isDefined(self.cur_target)) {
      self maps\_turret::set_turret_target(self.cur_target, (0, 0, 0), 0);
      self maps\_turret::fire_turret_for_time(randomfloatrange(3, 5), 0);
      wait(randomfloatrange(2, 4));
    } else
      wait 0.05;
  }
}