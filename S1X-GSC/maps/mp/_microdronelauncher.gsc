/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_microdronelauncher.gsc
***************************************************/

#include common_scripts\utility;

CONST_microdrone_weaponname = "iw5_microdronelauncher_mp";
CONST_max_homing_angle_from_grenade = 15;
CONST_begin_homing_time = .35;
CONST_drop_accel = 800;

CONST_explosion_delay_time = 3;

monitor_microdrone_launch() {
  level._effect["mdl_sticky_explosion"] = LoadFx("vfx/explosion/frag_grenade_default");
  level._effect["mdl_sticky_blinking"] = LoadFx("vfx/lights/light_semtex_blinking");

  Assert(IsPlayer(self) || IsAgent(self));
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  while(true) {
    self waittill("missile_fire", projectile, weaponName);
    if(IsSubStr(weaponName, CONST_microdrone_weaponname)) {
      projectile setOtherEnt(self);
    }
  }
}

determine_projectile_position(firing_player) {
  self endon("death");

  while(true) {
    if(!isDefined(self.previous_position)) {
      self.previous_position = self.origin;
    }

    wait(0.05);

    self.previous_position = self.origin;
  }
}

determine_sticky_position(firing_player) {
  firing_player endon("spawned_player");

  if(!isDefined(self.previous_position)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  previous_to_current = self.origin - self.previous_position;
  trajectory = VectorToAngles(previous_to_current);
  forward = anglesToForward(trajectory) * 8000;
  end = self.origin + forward;

  trace = bulletTrace(self.previous_position, end, true, firing_player, true, true);

  if(trace["fraction"] < 1 && isDefined(trace["position"])) {
    sticky_grenade = spawn("script_model", trace["position"]);
    sticky_grenade setModel("projectile_semtex_grenade");

    if(isDefined(trace["entity"])) {
      if(IsPlayer(trace["entity"])) {
        firing_player thread show_stuck_fanfare();
        trace["entity"] thread show_stuck_fanfare();
      }

      sticky_grenade LinkTo(trace["entity"]);
    }

    sticky_grenade thread sticky_timer(firing_player);
    sticky_grenade thread sticky_fx(firing_player);
    sticky_grenade thread remove_sticky(firing_player);
  }
}

microdronelauncher_cleanup() {
  self waittill_any("death", "disconnect", "faux_spawn");

  if(isDefined(self.HUDItem)) {
    foreach(hudItem in self.HUDItem) {
      hudItem Destroy();
    }
    self.HUDItem = undefined;
  }
}

show_stuck_fanfare() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isDefined(self.HUDItem)) {
    self.HUDItem = [];
  }

  if(isDefined(self.HUDItem) && !isDefined(self.HUDItem["mdlStuckText"])) {
    self.HUDItem["mdlStuckText"] = NewClientHudElem(self);
    self.HUDItem["mdlStuckText"].x = 0;
    self.HUDItem["mdlStuckText"].y = -170;
    self.HUDItem["mdlStuckText"].alignX = "center";
    self.HUDItem["mdlStuckText"].alignY = "middle";
    self.HUDItem["mdlStuckText"].horzAlign = "center";
    self.HUDItem["mdlStuckText"].vertAlign = "middle";
    self.HUDItem["mdlStuckText"].fontScale = 3.0;
    self.HUDItem["mdlStuckText"].alpha = 0.0;
    self.HUDItem["mdlStuckText"] SetText("STUCK!");
    self thread microdronelauncher_cleanup();
  }

  if(isDefined(self.HUDItem["mdlStuckText"])) {
    self.HUDItem["mdlStuckText"].alpha = 1.0;
    wait(2.0);
    self.HUDItem["mdlStuckText"].alpha = 0.0;
  }
}

sticky_timer(firing_player) {
  firing_player endon("spawned_player");

  wait(CONST_explosion_delay_time);

  playFX(getfx("mdl_sticky_explosion"), self.origin);
  PhysicsExplosionSphere(self.origin, 256, 32, 1.0);
  RadiusDamage(self.origin, 256, 130, 15, firing_player, "MOD_EXPLOSIVE", "iw5_microdronelauncher_mp");

  self notify("exploded");
}

sticky_fx(firing_player) {
  firing_player endon("spawned_player");
  self endon("exploded");

  self.fx_origin = spawn_tag_origin();
  self.fx_origin.origin = self.origin;
  self.fx_origin Show();

  wait(0.1);

  playFXOnTag(getfx("mdl_sticky_blinking"), self.fx_origin, "tag_origin");
}

remove_sticky(firing_player) {
  self thread remove_sticky_on_explosion(firing_player);
  self thread remove_sticky_on_respawn(firing_player);
}

remove_sticky_on_explosion(firing_player) {
  firing_player endon("spawned_player");

  self waittill("exploded");

  if(isDefined(self)) {
    self cleanup_sticky();
  }
}

remove_sticky_on_respawn(firing_player) {
  self endon("exploded");

  firing_player waittill("spawned_player");

  if(isDefined(self)) {
    self cleanup_sticky();
  }
}

cleanup_sticky() {
  stopFXOnTag(getfx("mdl_sticky_blinking"), self.fx_origin, "tag_origin");
  self Delete();
}

microdrone_think(firing_player) {
  self endon("death");

  firing_player endon("death");
  firing_player endon("disconnect");
  firing_player endon("faux_spawn");

  start_origin = self.origin;

  self get_differentiated_velocity();
  wait .05;
  self get_differentiated_velocity();
  wait .05;
  elapsed_time = .1;

  init_vel = self get_differentiated_velocity();
  while(true) {
    cur_vel = self get_differentiated_velocity();

    set_target = false;
    if(elapsed_time >= CONST_begin_homing_time) {
      best_target = microdrone_get_best_target(start_origin, VectorNormalize(init_vel), cur_vel, firing_player);
      if(isDefined(best_target)) {
        self Missile_SetTargetEnt(best_target, microdrone_get_target_offset(best_target));
        set_target = true;

        init_vel = cur_vel;
      }
    } else {}

    if(!set_target) {
      desired_dir = VectorNormalize(init_vel + (0, 0, -.5 * CONST_drop_accel * Squared(elapsed_time)));
      self Missile_SetTargetPos(self.origin + desired_dir * 10000);
    }

    wait .05;
    elapsed_time += .05;
  }
}

microdrone_get_best_target(start_origin, dir, cur_vel, firing_player) {
  min_dot_from_grenade = Cos(CONST_max_homing_angle_from_grenade);

  best_target = undefined;
  best_target_dot = Cos(CONST_max_homing_angle_from_grenade);
  foreach(target in level.players) {
    if(target == firing_player) {
      continue;
    }

    if(target.team == firing_player.team) {
      continue;
    }

    target_pos = microdrone_get_target_pos(target);
    dot = VectorDot(VectorNormalize(cur_vel), VectorNormalize(target_pos - self.origin));
    if(dot > best_target_dot) {
      if(BulletTracePassed(self.origin, target_pos, false, target)) {
        best_target = target;
        best_target_dot = dot;
      } else {}
    }
  }

  return best_target;
}

is_enemy_target(target, firing_player) {
  team = undefined;

  if(IsAi(target)) {
    team = target.team;
  } else if(isDefined(target.script_team)) {
    team = target.script_team;
  }

  return IsEnemyTeam(team, firing_player.team);
}

microdrone_get_target_pos(target) {
  return target GetPointInBounds(0, 0, 0);
}

microdrone_get_target_offset(target) {
  return microdrone_get_target_pos(target) - target.origin;
}

get_differentiated_velocity() {
  self differentiate_motion();
  return self.differentiated_velocity;
}

differentiate_motion() {
  time = GetTime() * .001;

  if(!isDefined(self.differentiated_last_update)) {
    self.differentiated_last_update = time;
    self.differentiated_last_origin = self.origin;
    self.differentiated_last_velocity = (0, 0, 0);
    self.differentiated_last_acceleration = (0, 0, 0);
    self.differentiated_jerk = (0, 0, 0);
    self.differentiated_acceleration = (0, 0, 0);
    self.differentiated_velocity = (0, 0, 0);
    self.differentiated_speed = 0;
  } else if(self.differentiated_last_update != time) {
    dt = time - self.differentiated_last_update;
    self.differentiated_last_update = time;
    self.differentiated_jerk = (self.differentiated_acceleration - self.differentiated_last_acceleration) / dt;
    self.differentiated_last_acceleration = self.differentiated_acceleration;
    self.differentiated_acceleration = (self.differentiated_velocity - self.differentiated_last_velocity) / dt;
    self.differentiated_last_velocity = self.differentiated_velocity;
    self.differentiated_velocity = (self.origin - self.differentiated_last_origin) / dt;
    self.differentiated_last_origin = self.origin;
    self.differentiated_speed = Length(self.differentiated_velocity);
  }
}