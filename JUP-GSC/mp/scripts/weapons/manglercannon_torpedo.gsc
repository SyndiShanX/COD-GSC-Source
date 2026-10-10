/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\weapons\manglercannon_torpedo.gsc
********************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace manglercannon_torpedo;

function function_abdaf24ee06fa15(var_bbfb261ebc534765, launch_direction, target, target_pos, detonation_dist, velocity, var_1c9240866ae6b48c, max_range, var_550cc6b3d7ba166e, blast_radius, var_a48a77da6458589f, var_354a01f56bc89544, var_684e3c5cb08fedc0, var_682b525cb069d66a, var_627480a059b7fa92, var_26a92f43ecb7b5c5, var_aebe69bbb1a115f3, var_e3fe928071464c51, weapon, var_6234e3685c2bd000) {
  torpedo = spawn("script_model", var_bbfb261ebc534765);
  torpedo setModel(var_6234e3685c2bd000);
  torpedo.var_c1c5e743347d6d58 = self;
  torpedo.is_detonating = 0;
  vec_to_enemy = launch_direction;
  angles_to_enemy = vectortoangles(vec_to_enemy);
  torpedo.angles = angles_to_enemy;
  normal_vector = vectorNormalize(vec_to_enemy);
  torpedo.var_5062366a62e407ba = normal_vector;
  torpedo.knockdown_iterations = 0;
  torpedo.var_5fd209e315aa8d1c = 0;
  torpedo.var_e46418ba389f71d7 = detonation_dist * detonation_dist;
  torpedo.var_57472ddc2380cf7d = detonation_dist;
  torpedo.var_b87b30c6fcc96cc6 = velocity;
  torpedo.var_e8d473ca55b7a24c = var_1c9240866ae6b48c;
  torpedo.var_ed29901add8ac16b = max_range;
  torpedo.var_1576e303e351e52e = var_550cc6b3d7ba166e;
  torpedo.var_3f273a84c85d65b4 = blast_radius;
  torpedo.var_27373e318049fe5f = var_a48a77da6458589f;
  torpedo.var_b7f7c84c87bc6e04 = var_354a01f56bc89544;
  torpedo.var_af7b9904fbe32780 = var_684e3c5cb08fedc0;
  torpedo.var_af58af04fbbd102a = var_682b525cb069d66a;
  torpedo.var_627480a059b7fa92 = var_627480a059b7fa92;
  torpedo.var_aebe69bbb1a115f3 = var_aebe69bbb1a115f3;
  torpedo.var_26a92f43ecb7b5c5 = var_26a92f43ecb7b5c5;
  torpedo.weapon = weapon;
  torpedo thread function_234c95c888cbd6e5(target, target_pos);
  torpedo thread function_d57971b3bf8cccf4(target, target_pos);

  if(var_e3fe928071464c51) {
    torpedo thread function_e4e471b602c48286(target, target_pos);
  }
}

function private function_e910e4a416ca1b50(var_ee55be6386b87736, target_pos) {
  if(isDefined(var_ee55be6386b87736)) {
    var_5e092c19c1754edd = var_ee55be6386b87736 getcentroid();
  } else {
    var_5e092c19c1754edd = target_pos;
  }

  return var_5e092c19c1754edd;
}

function private function_e4e471b602c48286(var_82a9df7d880bfc84, target_pos) {
  self endon("death");
  self endon("detonated");
  torpedo = self;
  var_8aa7d2100bc6ac47 = isDefined(var_82a9df7d880bfc84);

  while(isDefined(torpedo) && (!var_8aa7d2100bc6ac47 || isDefined(var_82a9df7d880bfc84))) {
    if(var_8aa7d2100bc6ac47) {
      var_aa2fd664102522d5 = var_82a9df7d880bfc84 getcentroid();
    } else {
      var_aa2fd664102522d5 = target_pos;
    }

    if(distancesquared(torpedo.origin, var_aa2fd664102522d5) <= self.var_e46418ba389f71d7) {
      torpedo thread function_aee10c8eff4e52e5(0);
    }

    waitframe();
  }
}

function private function_234c95c888cbd6e5(target, target_pos) {
  self endon("death");
  self endon("detonated");
  torpedo = self;
  var_ffc20deed7f6c3ee = self.var_b87b30c6fcc96cc6 * self.var_e8d473ca55b7a24c;
  max_trail_iterations = int(self.var_ed29901add8ac16b / var_ffc20deed7f6c3ee);
  var_8aa7d2100bc6ac47 = isDefined(target);

  while(isDefined(torpedo)) {
    if(var_8aa7d2100bc6ac47 && !isDefined(target) || torpedo.var_5fd209e315aa8d1c >= max_trail_iterations) {
      torpedo thread function_aee10c8eff4e52e5(0);
    } else {
      torpedo function_44a047e6d84dc69c(target, target_pos);
      torpedo.var_5fd209e315aa8d1c += 1;
    }

    wait self.var_e8d473ca55b7a24c;
  }
}

function private function_44a047e6d84dc69c(target, target_pos) {
  self endon("death");
  self endon("detonated");

  if(!isDefined(self.var_cbe892c4afc77bbd)) {
    var_a59b061da67d8850 = self.var_1576e303e351e52e * self.var_e8d473ca55b7a24c;
    self.var_cbe892c4afc77bbd = cos(var_a59b061da67d8850);
  }

  var_5e092c19c1754edd = function_e910e4a416ca1b50(target, target_pos);
  vector_to_target = var_5e092c19c1754edd - self.origin;
  normal_vector = vectorNormalize(vector_to_target);

  if(isDefined(self.var_5062366a62e407ba)) {
    var_a87749dadb058ac = vectorNormalize((normal_vector[0], normal_vector[1], 0));
    var_334420c9f59c32a6 = vectorNormalize((self.var_5062366a62e407ba[0], self.var_5062366a62e407ba[1], 0));
    dot = vectordot(var_a87749dadb058ac, var_334420c9f59c32a6);

    if(dot >= 1) {
      dot = 1;
    } else if(dot <= -1) {
      dot = -1;
    }

    if(dot < self.var_cbe892c4afc77bbd) {
      new_vector = normal_vector - self.var_5062366a62e407ba;
      angle_between_vectors = acos(dot);

      if(!isDefined(angle_between_vectors)) {
        angle_between_vectors = 180;
      }

      if(angle_between_vectors == 0) {
        angle_between_vectors = 0.0001;
      }

      var_91e206eb624dbde3 = self.var_1576e303e351e52e * self.var_e8d473ca55b7a24c;
      ratio = var_91e206eb624dbde3 / angle_between_vectors;

      if(ratio > 1) {
        ratio = 1;
      }

      new_vector *= ratio;
      new_vector += self.var_5062366a62e407ba;
      normal_vector = vectorNormalize(new_vector);
    }
  }

  move_distance = self.var_b87b30c6fcc96cc6 * self.var_e8d473ca55b7a24c;
  move_vector = move_distance * normal_vector;
  move_to_point = self.origin + move_vector;
  trace = scripts\engine\trace::ray_trace_detail(self.origin, move_to_point, self, undefined, 1, 0, 1);

  if(trace["hittype"] == "hittype_world") {
    detonate_point = trace["position"];
    delay = function_16c8413e4688a5b(self.origin, detonate_point, move_distance, self.var_e8d473ca55b7a24c);
    thread function_aee10c8eff4e52e5(delay);
  } else if(trace["hittype"] == "hittype_entity") {
    hitentity = trace["entity"];

    if(!isai(hitentity)) {
      detonate_point = trace["position"];
      delay = function_16c8413e4688a5b(self.origin, detonate_point, move_distance, self.var_e8d473ca55b7a24c);
      thread function_aee10c8eff4e52e5(delay);
    }
  }

  self.var_5062366a62e407ba = normal_vector;
  self moveTo(move_to_point, self.var_e8d473ca55b7a24c);
}

function private function_16c8413e4688a5b(current_point, detonate_point, move_distance, time_interval) {
  dist_sq = distancesquared(detonate_point, current_point);
  move_dist_sq = move_distance * move_distance;
  ratio = dist_sq / move_dist_sq;
  delay = ratio * time_interval;
  return delay;
}

function private function_aee10c8eff4e52e5(delay) {
  self endon("death");
  self notify("detonated");
  self endon("detonated");
  torpedo = self;
  var_c1c5e743347d6d58 = self.var_c1c5e743347d6d58;
  self.is_detonating = 1;

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(self)) {
    function_c82ca8d576cb037a();
    self setscriptablepartstate("torpedo", "detonate");
    explosion_point = torpedo.origin;
    meansofdeath = "MOD_PROJECTILE";

    if(!isDefined(var_c1c5e743347d6d58)) {
      var_c1c5e743347d6d58 = undefined;
      radiusdamage(explosion_point, self.var_3f273a84c85d65b4, self.var_b7f7c84c87bc6e04, self.var_27373e318049fe5f, var_c1c5e743347d6d58, meansofdeath, self.weapon);
    } else {
      var_c1c5e743347d6d58 radiusdamage(explosion_point, self.var_3f273a84c85d65b4, self.var_b7f7c84c87bc6e04, self.var_27373e318049fe5f, var_c1c5e743347d6d58, meansofdeath, self.weapon);
    }

    function_6e37d8347a416e3(explosion_point);
    params = spawnStruct();
    params.damage = int((self.var_b7f7c84c87bc6e04 + self.var_27373e318049fe5f) / 2);
    params.origin = explosion_point;
    params.radius = self.var_3f273a84c85d65b4;
    params.meansofdeath = meansofdeath;

    recordsphere(params.origin, 5, (1, 0, 0));

    self.var_c1c5e743347d6d58 callback::callback("damage_point", params);
    wait 0.5;

    if(isDefined(self)) {
      self delete();
    }
  }
}

function private function_6e37d8347a416e3(var_9e26f7c0622c2303) {
  players = function_883458a342af3041(var_9e26f7c0622c2303, 100);

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isalive(player)) {
      continue;
    }

    if(!player isonground()) {
      continue;
    }

    n_distance = distance2dsquared(var_9e26f7c0622c2303, player.origin);

    if(n_distance < 0.01) {
      continue;
    }

    v_dir = player.origin - var_9e26f7c0622c2303;
    v_dir = (v_dir[0], v_dir[1], 0.1);
    v_dir = vectorNormalize(v_dir);
    n_push_strength = self.var_af58af04fbbd102a;
    n_push_strength = self.var_af7b9904fbe32780 + randomint(int(n_push_strength) - int(self.var_af7b9904fbe32780));
    player knockback(v_dir, n_push_strength);
  }
}

function private function_c82ca8d576cb037a() {
  earthquake(0.4, 0.8, self.origin, 300);
  players = function_883458a342af3041(self.origin, self.var_57472ddc2380cf7d);

  foreach(player in players) {
    player playRumbleOnEntity("damage_heavy");

    if(player isscriptable()) {
      player setscriptablepartstate("mangler_cannon_projectile_audio", "hit");
    }
  }
}

function private function_d57971b3bf8cccf4(var_82a9df7d880bfc84, target_pos) {
  self endon("death");
  self endon("detonated");

  while(isDefined(self) && !self.is_detonating) {
    a_zombies = [];

    if(isDefined(var_82a9df7d880bfc84)) {
      var_209d8c67db6ff9c6 = var_82a9df7d880bfc84 getcentroid();
    } else {
      var_209d8c67db6ff9c6 = target_pos;
    }

    prediction_time = 0.3;

    if(isDefined(self.knockdown_iterations) && self.knockdown_iterations < 3) {
      if(self.knockdown_iterations == 0) {
        prediction_time = 0.075;
      }

      if(self.knockdown_iterations == 1) {
        prediction_time = 0.15;
      }

      if(self.knockdown_iterations == 2) {
        prediction_time = 0.225;
      }
    }

    self.knockdown_iterations += 1;
    vector_to_target = var_209d8c67db6ff9c6 - self.origin;
    normal_vector = vectorNormalize(vector_to_target);
    move_distance = self.var_b87b30c6fcc96cc6 * prediction_time;
    move_vector = move_distance * normal_vector;
    self.angles = vectortoangles(move_vector);
    predicted_pos = self.origin + move_vector;
    a_zombies = getaiarrayinradius(predicted_pos, 100);

    foreach(zombie in a_zombies) {
      if(!isalive(zombie) || zombie == self.var_c1c5e743347d6d58) {
        continue;
      }

      if(zombie.type == "zombie") {
        var_4de1db0246152e59 = self.origin;
        enemy_pos = zombie getcentroid();
        facing_vec = anglesToForward(self.angles);
        enemy_vec = enemy_pos - var_4de1db0246152e59;
        var_6525c1f762dd7866 = (enemy_vec[0], enemy_vec[1], 0);
        var_8102553ecea71192 = (facing_vec[0], facing_vec[1], 0);
        var_6525c1f762dd7866 = vectorNormalize(var_6525c1f762dd7866);
        var_8102553ecea71192 = vectorNormalize(var_8102553ecea71192);
        enemy_dot = vectordot(var_8102553ecea71192, var_6525c1f762dd7866);

        if(enemy_dot < 0) {
          continue;
        }

        if(!istrue(zombie._blackboard.zombieinknockdown) && (!isDefined(zombie.aicategory) || zombie.aicategory == "normal")) {
          if(issharedfuncdefined("zombie", "knockdownZombie")) {
            zombie[[getsharedfunc("zombie", "knockdownZombie")]](self.origin);
          }
        }

        if(self.var_26a92f43ecb7b5c5 && isDefined(zombie.aicategory) && zombie.aicategory == "elite") {
          if(issharedfuncdefined("zombie", "stunZombie")) {
            zombie[[getsharedfunc("zombie", "stunZombie")]](1);
          }
        }

        if(self.var_aebe69bbb1a115f3 && isDefined(zombie.aicategory) && (zombie.aicategory == "special" || zombie.aicategory == "elite")) {
          delay = function_16c8413e4688a5b(self.origin, enemy_pos, move_distance, prediction_time);
          thread function_aee10c8eff4e52e5(delay);
          break;
        }

        if(self.var_627480a059b7fa92 > 0) {
          zombie dodamage(self.var_627480a059b7fa92, zombie.origin, self.var_c1c5e743347d6d58, self, "MOD_PROJECTILE");
        }
      }
    }

    wait 0.2;
  }
}