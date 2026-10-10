/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_35ccbf5e9962bcaa.gsc
*************************************************/

#using script_3b78d23dad7ec5be;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace namespace_277ce153e9305d9d;

function function_f610efe120542831(taskid, params) {
  function_d04d397bd793d2a3(self.var_ae9e4fed8d91c6a4, 1);
  return anim.success;
}

function function_33d5240ded5ff831() {
  self.var_84a9c43b4709d6c9 = 0;
  self.var_71f6000055440911 = 0;
  self.var_ae9e4fed8d91c6a4 = self.zombieaisettings.var_e58a65b7a8f5973c.var_3c2e1b2fc4e3ca9c;
  self.var_1fde3091fa873305 = self.zombieaisettings.var_e58a65b7a8f5973c.var_dc385898295fc39d;
  self.var_500bf04a54885937 = self.zombieaisettings.var_e58a65b7a8f5973c.var_cef69cbba269e885;
  self.var_e2ec899dae6aa861 = self.zombieaisettings.var_e58a65b7a8f5973c.var_29e11c3dbc90eec4;
  self.var_a1988024d67dbabd = self.zombieaisettings.var_e58a65b7a8f5973c.var_746a8b8f7859cf02;
  self function_3e89eb3d8e3f1811("proximity_berserk_range", self.zombieaisettings.var_e58a65b7a8f5973c.proximityberserkrange);
  self function_3e89eb3d8e3f1811("can_proximity_berserk", self.zombieaisettings.var_e58a65b7a8f5973c.var_3c68b1c017f0fa5f);

  if(self.var_500bf04a54885937) {
    callback::add("on_zombie_ai_damaged", &function_4a73d765d40a91d8);
  }
}

function function_4a73d765d40a91d8(params) {
  if(self.health / self.maxhealth < self.var_a1988024d67dbabd) {
    thread function_82e9d00e0769fe40(self.var_e2ec899dae6aa861);
    callback::remove("on_zombie_ai_damaged", &function_4a73d765d40a91d8, 1);
  }
}

function private function_82e9d00e0769fe40(duration) {
  self endon("death");
  wait duration;

  if(!self.var_84a9c43b4709d6c9) {
    self function_3e89eb3d8e3f1811("show_berserk", 1);
  }

  function_d04d397bd793d2a3(0, 0);
}

function function_d04d397bd793d2a3(duration, var_32d512ebca87e270) {
  if(!isalive(self)) {
    return;
  }

  if(self.var_71f6000055440911) {
    return;
  }

  if(self.var_84a9c43b4709d6c9) {
    self notify("enter_berserk");

    if(!istrue(var_32d512ebca87e270) && !self.var_f719fcdc90b79bb8) {
      self function_3e89eb3d8e3f1811("can_ranged_attack", 1);
    }
  } else {
    thread function_f79a85a5da89607();
  }

  self.var_84a9c43b4709d6c9 = 1;
  set("mangler_pain", "pain", 0);
  self enableavoidance(0);
  self.var_274e0c05ec5c89c0 = 0;
  self notify("vox_berserk");

  if(istrue(var_32d512ebca87e270)) {
    self function_3e89eb3d8e3f1811("can_ranged_attack", 0);
  }

  function_f1e5805da192a1ef("sprint", "mangler_berserk", 30);

  if(duration > 0) {
    thread function_af70e03465e6a39c(duration, var_32d512ebca87e270);
    return;
  }

  self.var_71f6000055440911 = 1;
  self function_3e89eb3d8e3f1811("can_proximity_berserk", 0);
}

function function_af70e03465e6a39c(duration, var_32d512ebca87e270) {
  self endon("death");
  self endon("enter_berserk");
  wait duration;
  self.var_84a9c43b4709d6c9 = 0;
  set("mangler_pain", "pain", 1);
  self notify("exit_berserk");
  self.var_274e0c05ec5c89c0 = 1;
  self enableavoidance(1);
  function_f1e5805da192a1ef(undefined, "mangler_berserk", 30);

  if(istrue(var_32d512ebca87e270) && !self.var_f719fcdc90b79bb8) {
    self function_3e89eb3d8e3f1811("can_ranged_attack", 1);
  }

  self function_3e89eb3d8e3f1811("proximity_berserk_timer", gettime() + int(self.var_1fde3091fa873305 * 1000));
  self function_3e89eb3d8e3f1811("in_proximity_berserk", 0);
  self notify("vox_calmdown");
}

function function_f79a85a5da89607() {
  self endon("death");
  self endon("exit_berserk");

  while(isDefined(self)) {
    velocity = self.velocity;
    var_a29bdd7cf93ff78f = lengthsquared(velocity);
    b_sprinting = var_a29bdd7cf93ff78f >= 1600;

    if(b_sprinting) {
      var_65e5bbfa7cef7b42 = 0.2;
      move_vector = velocity * var_65e5bbfa7cef7b42;
      predicted_pos = self.origin + move_vector;
      a_zombies = getaiarrayinradius(predicted_pos, 75);

      foreach(zombie in a_zombies) {
        if(!isalive(zombie) || zombie == self) {
          continue;
        }

        if(zombie.type == "zombie" && (!isDefined(zombie.category) || zombie.category == "normal")) {
          facing_vec = anglesToForward(self.angles);
          enemy_vec = zombie.origin - self.origin;
          var_6525c1f762dd7866 = (enemy_vec[0], enemy_vec[1], 0);
          var_8102553ecea71192 = (facing_vec[0], facing_vec[1], 0);
          var_6525c1f762dd7866 = vectorNormalize(var_6525c1f762dd7866);
          var_8102553ecea71192 = vectorNormalize(var_8102553ecea71192);
          enemy_dot = vectordot(var_8102553ecea71192, var_6525c1f762dd7866);

          if(enemy_dot < 0) {
            continue;
          }

          if(!istrue(zombie._blackboard.zombieinknockdown)) {
            zombie namespace_db1ce2c035564e2c::knockdown_ai(self.origin);
          }
        }
      }
    }

    wait 0.2;
  }
}