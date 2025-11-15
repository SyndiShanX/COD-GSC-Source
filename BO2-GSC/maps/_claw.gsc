/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_claw.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_death;

init() {
  vehicle_add_main_callback("drone_claw", ::main);
  vehicle_add_main_callback("drone_claw_wflamethrower", ::main);
  vehicle_add_main_callback("drone_claw_rts", ::main);
  vehicle_add_main_callback("drone_claw_suicide", ::main);
  precachestring(&"hud_weapon_heat");
}

main() {
  self ent_flag_init("playing_scripted_anim");
  self build_claw_anims();
  self thread watch_mounting();
  self thread claw_animating();
  self thread claw_death();
}

#using_animtree("vehicles");

build_claw_anims() {
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

  if(isDefined(level.claw_anims_inited)) {
    return;
  }
  level.claw_anims_inited = 1;
  level.claw_speeds = [];
  level.claw_speeds[level.reverse - 1] = -50000;
  level.claw_speeds[level.reverse] = -100;
  level.claw_speeds[level.idle] = 0;
  level.claw_speeds[level.walk] = 100;
  level.claw_speeds[level.run] = 4000;
  level.claw_speeds[level.sprint] = 5000;
  level.claw_speeds[level.sprint + 1] = 50000;
  level.claw_anims = [];
  level.claw_anims[level.reverse] = % int_claw_walk_b;
  level.claw_anims[level.idle] = % int_claw_idle;
  level.claw_anims[level.walk] = % int_claw_walk_f;
  level.claw_anims[level.run] = % int_claw_walk_f;
  level.claw_anims[level.sprint] = % int_claw_walk_f;
  level.claw_anims[level.jump] = [];
  level.claw_anims[level.jump][0] = % int_claw_idle;
  level.claw_anims[level.jump][1] = % int_claw_idle;
  level.claw_anims[level.jump][2] = % int_claw_idle;
}

precache_fx() {
}

claw_animating() {
  self endon("death");
  wait 0.5;
  self.idle_end_time = 0;

  while(true) {
    speed = self getspeed();
    angular_velocity = self getangularvelocity();
    turning_speed = abs(angular_velocity[2]);

    if(self ent_flag("playing_scripted_anim")) {
    } else if(self.in_air) {
    } else if(speed < 55 && speed > -20 && turning_speed > 0.2) {
      anim_rate = turning_speed;
      anim_rate = clamp(anim_rate, 0.0, 3);

      if(angular_velocity[2] > 0)
        self setanimknoball( % int_claw_turn_l, % root, 1, 0.2, anim_rate);
      else
        self setanimknoball( % int_claw_turn_r, % root, 1, 0.2, anim_rate);

      self.current_anim_speed = level.idle;
      self.idle_end_time = 0;
    } else if(speed < -8.0) {
      self.current_anim_speed = level.reverse;
      anim_rate = speed / level.claw_speeds[self.current_anim_speed];
      anim_rate = clamp(anim_rate, 0.0, 1.5);
      self setanimknoball(level.claw_anims[level.reverse], % root, 1, 0.2, anim_rate);
    } else if(speed < 5)
      self setanimknoball(level.claw_anims[self.current_anim_speed], % root, 1, 0.2, 0);
    else {
      next_anim_delta = level.claw_speeds[self.current_anim_speed + 1] - level.claw_speeds[self.current_anim_speed];
      next_anim_speed = level.claw_speeds[self.current_anim_speed] + next_anim_delta * 0.6;
      prev_anim_delta = level.claw_speeds[self.current_anim_speed] - level.claw_speeds[self.current_anim_speed - 1];
      prev_anim_speed = level.claw_speeds[self.current_anim_speed] - prev_anim_delta * 0.6;

      if(speed > next_anim_speed)
        self.current_anim_speed++;
      else if(speed < prev_anim_speed)
        self.current_anim_speed--;

      if(self.current_anim_speed <= level.idle)
        self.current_anim_speed = level.walk;

      anim_rate = speed / level.claw_speeds[self.current_anim_speed];
      anim_rate = clamp(anim_rate, 0.0, 1.5);
      self setanimknoball(level.claw_anims[self.current_anim_speed], % root, 1, 0.2, anim_rate);
    }

    wait 0.05;
  }
}

check_for_landing() {
  self waittill("veh_landed");
  self.already_landed = 1;
}

watch_for_fall() {
  self endon("death");

  while(true) {
    self waittill("veh_inair");

    if(!self.in_air) {
      self.in_air = 1;
      self setanimknoball(level.claw_anims[level.jump][1], % root, 1, 0.1, 1);
      self waittill_notify_or_timeout("veh_landed", 1);
      self.in_air = 0;
    } else
      self waittill("veh_landed");
  }
}

watch_exit_vehicle() {
  self waittill("exit_vehicle");
  self.ignoreme = 0;
  self disableinvulnerability();
}

watch_mounting() {
  self endon("death");

  while(true) {
    self waittill("enter_vehicle", player);
    self.driver = player;
    self thread watch_for_fall();
    vision_set_name = level.script == "pakistan_2" ? "sp_pakistan2_claw" : "firestorm_turret";
    self thread maps\_vehicle_death::vehicle_damage_filter(vision_set_name);
    player.ignoreme = 1;
    player enableinvulnerability();
    self setviewmodelrenderflag(1);
    player thread claw_update_hud();
    player thread watch_exit_vehicle();
    self waittill("exit_vehicle");
    self notify("no_driver");
    self setviewmodelrenderflag(0);
    self.driver = undefined;
  }
}

claw_update_hud() {
  self endon("death");
  self endon("exit_vehicle");
  heat_1 = 0;
  heat_2 = 0;
  overheat_1 = 0;
  overheat_2 = 0;

  while(true) {
    if(isDefined(self.viewlockedentity)) {
      old_heat_1 = heat_1;
      heat_1 = self.viewlockedentity getturretheatvalue(0);
      old_heat_2 = heat_2;
      heat_2 = self.viewlockedentity getturretheatvalue(1);
      old_overheat_1 = overheat_1;
      overheat_1 = self.viewlockedentity isvehicleturretoverheating(0);
      old_overheat_2 = overheat_2;
      overheat_2 = self.viewlockedentity isvehicleturretoverheating(1);

      if(old_heat_1 != heat_1 || old_heat_2 != heat_2 || old_overheat_1 != overheat_1 || old_overheat_2 != overheat_2)
        luinotifyevent(&"hud_weapon_heat", 4, int(heat_1), int(heat_2), overheat_1, overheat_2);
    }

    wait 0.05;
  }
}

claw_death() {
  self waittill("death");
}