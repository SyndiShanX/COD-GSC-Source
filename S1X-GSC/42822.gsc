/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42822.gsc
**************************************/

monitor_microdrone_launch() {
  level._effect["mdl_sticky_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
  level._effect["mdl_sticky_blinking"] = loadfx("vfx/lights/light_semtex_blinking");
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(issubstr(var_1, "iw5_microdronelauncher_mp")) {
      var_0 setotherent(self);
    }
  }
}

determine_projectile_position(var_0) {
  self endon("death");

  for(;;) {
    if(!isDefined(self.previous_position)) {
      self.previous_position = self.origin;
    }

    wait 0.05;
    self.previous_position = self.origin;
  }
}

determine_sticky_position(var_0) {
  var_0 endon("spawned_player");

  if(!isDefined(self.previous_position)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  var_1 = self.origin - self.previous_position;
  var_2 = vectortoangles(var_1);
  var_3 = anglesToForward(var_2) * 8000;
  var_4 = self.origin + var_3;
  var_5 = bulletTrace(self.previous_position, var_4, 1, var_0, 1, 1);

  if(var_5["fraction"] < 1 && isDefined(var_5["position"])) {
    var_6 = spawn("script_model", var_5["position"]);
    var_6 setModel("projectile_semtex_grenade");

    if(isDefined(var_5["entity"])) {
      if(isPlayer(var_5["entity"])) {
        var_0 thread show_stuck_fanfare();
        var_5["entity"] thread show_stuck_fanfare();
      }

      var_6 linkto(var_5["entity"]);
    }

    var_6 thread sticky_timer(var_0);
    var_6 thread sticky_fx(var_0);
    var_6 thread remove_sticky(var_0);
  }
}

microdronelauncher_cleanup() {
  common_scripts\utility::waittill_any("death", "disconnect", "faux_spawn");

  if(isDefined(self.huditem)) {
    foreach(var_1 in self.huditem) {
      var_1 destroy();
    }

    self.huditem = undefined;
  }
}

show_stuck_fanfare() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isDefined(self.huditem)) {
    self.huditem = [];
  }

  if(isDefined(self.huditem) && !isDefined(self.huditem["mdlStuckText"])) {
    self.huditem["mdlStuckText"] = newclienthudelem(self);
    self.huditem["mdlStuckText"].x = 0;
    self.huditem["mdlStuckText"].y = -170;
    self.huditem["mdlStuckText"].alignx = "center";
    self.huditem["mdlStuckText"].aligny = "middle";
    self.huditem["mdlStuckText"].horzalign = "center";
    self.huditem["mdlStuckText"].vertalign = "middle";
    self.huditem["mdlStuckText"].fontscale = 3.0;
    self.huditem["mdlStuckText"].alpha = 0.0;
    self.huditem["mdlStuckText"] settext("STUCK!");
    thread microdronelauncher_cleanup();
  }

  if(isDefined(self.huditem["mdlStuckText"])) {
    self.huditem["mdlStuckText"].alpha = 1.0;
    wait 2.0;
    self.huditem["mdlStuckText"].alpha = 0.0;
  }
}

sticky_timer(var_0) {
  var_0 endon("spawned_player");
  wait 3;
  playFX(common_scripts\utility::getfx("mdl_sticky_explosion"), self.origin);
  physicsexplosionsphere(self.origin, 256, 32, 1.0);
  radiusdamage(self.origin, 256, 130, 15, var_0, "MOD_EXPLOSIVE", "iw5_microdronelauncher_mp");
  self notify("exploded");
}

sticky_fx(var_0) {
  var_0 endon("spawned_player");
  self endon("exploded");
  self.fx_origin = common_scripts\utility::spawn_tag_origin();
  self.fx_origin.origin = self.origin;
  self.fx_origin show();
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("mdl_sticky_blinking"), self.fx_origin, "tag_origin");
}

remove_sticky(var_0) {
  thread remove_sticky_on_explosion(var_0);
  thread remove_sticky_on_respawn(var_0);
}

remove_sticky_on_explosion(var_0) {
  var_0 endon("spawned_player");
  self waittill("exploded");

  if(isDefined(self)) {
    cleanup_sticky();
  }
}

remove_sticky_on_respawn(var_0) {
  self endon("exploded");
  var_0 waittill("spawned_player");

  if(isDefined(self)) {
    cleanup_sticky();
  }
}

cleanup_sticky() {
  stopFXOnTag(common_scripts\utility::getfx("mdl_sticky_blinking"), self.fx_origin, "tag_origin");
  self delete();
}

microdrone_think(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");
  var_1 = self.origin;
  get_differentiated_velocity();
  wait 0.05;
  get_differentiated_velocity();
  wait 0.05;
  var_2 = 0.1;
  var_3 = get_differentiated_velocity();

  for(;;) {
    var_4 = get_differentiated_velocity();
    var_5 = 0;

    if(var_2 >= 0.35) {
      var_6 = microdrone_get_best_target(var_1, vectornormalize(var_3), var_4, var_0);

      if(isDefined(var_6)) {
        self missile_settargetent(var_6, microdrone_get_target_offset(var_6));
        var_5 = 1;
        var_3 = var_4;
      }
    } else {}

    if(!var_5) {
      var_7 = vectornormalize(var_3 + (0, 0, -400.0 * squared(var_2)));
      self missile_settargetpos(self.origin + var_7 * 10000);
    }

    wait 0.05;
    var_2 = var_2 + 0.05;
  }
}

microdrone_get_best_target(var_0, var_1, var_2, var_3) {
  var_4 = cos(15);
  var_5 = undefined;
  var_6 = cos(15);

  foreach(var_8 in level.players) {
    if(var_8 == var_3) {
      continue;
    }
    if(var_8.team == var_3.team) {
      continue;
    }
    var_9 = microdrone_get_target_pos(var_8);
    var_10 = vectordot(vectornormalize(var_2), vectornormalize(var_9 - self.origin));

    if(var_10 > var_6) {
      if(bullettracepassed(self.origin, var_9, 0, var_8)) {
        var_5 = var_8;
        var_6 = var_10;
        continue;
      }
    }
  }

  return var_5;
}

is_enemy_target(var_0, var_1) {
  var_2 = undefined;

  if(isai(var_0)) {
    var_2 = var_0.team;
  } else if(isDefined(var_0.script_team)) {
    var_2 = var_0.script_team;
  }

  return isenemyteam(var_2, var_1.team);
}

microdrone_get_target_pos(var_0) {
  return var_0 getpointinbounds(0, 0, 0);
}

microdrone_get_target_offset(var_0) {
  return microdrone_get_target_pos(var_0) - var_0.origin;
}

get_differentiated_velocity() {
  differentiate_motion();
  return self.differentiated_velocity;
}

differentiate_motion() {
  var_0 = gettime() * 0.001;

  if(!isDefined(self.differentiated_last_update)) {
    self.differentiated_last_update = var_0;
    self.differentiated_last_origin = self.origin;
    self.differentiated_last_velocity = (0, 0, 0);
    self.differentiated_last_acceleration = (0, 0, 0);
    self.differentiated_jerk = (0, 0, 0);
    self.differentiated_acceleration = (0, 0, 0);
    self.differentiated_velocity = (0, 0, 0);
    self.differentiated_speed = 0;
  } else if(self.differentiated_last_update != var_0) {
    var_1 = var_0 - self.differentiated_last_update;
    self.differentiated_last_update = var_0;
    self.differentiated_jerk = (self.differentiated_acceleration - self.differentiated_last_acceleration) / var_1;
    self.differentiated_last_acceleration = self.differentiated_acceleration;
    self.differentiated_acceleration = (self.differentiated_velocity - self.differentiated_last_velocity) / var_1;
    self.differentiated_last_velocity = self.differentiated_velocity;
    self.differentiated_velocity = (self.origin - self.differentiated_last_origin) / var_1;
    self.differentiated_last_origin = self.origin;
    self.differentiated_speed = length(self.differentiated_velocity);
  }
}