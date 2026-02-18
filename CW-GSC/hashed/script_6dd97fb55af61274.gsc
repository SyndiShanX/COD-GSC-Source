/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6dd97fb55af61274.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\raz;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#namespace namespace_d35b13b1;

function private autoexec __init__system__() {
  system::register(#"hash_7eaac11b6cd35b05", &preinit, undefined, &function_4df027f2, undefined);
}

function private preinit() {
  spawner::add_archetype_spawn_function(#"raz", &function_ce3b36df);
  spawner::function_89a2cd87(#"raz", &function_e7ad996);
  function_c7bb75d5();
}

function function_4df027f2() {}

function private function_c7bb75d5() {}

function function_ce3b36df() {
  if(is_true(level.is_survival)) {
    self.ai.var_870d0893 = 1;
    self.completed_emerging_into_playable_area = 1;
  }

  self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::zombie_on_melee);
  self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::function_95c99579, undefined, [undefined, 1]);
  self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
  self.var_12af7864 = 1;
  self.var_c11b8a5a = 1;
  self.var_b3c613a7 = [1, 1.5, 1.5, 2, 2];
  self.var_414bc881 = 1;
  self.var_97ca51c7 = 2;
  self.melee_distance_check = &namespace_e292b080::function_e8983bf3;
  playFX("zombie/fx_portal_keeper_spawn_burst_zod_zmb", self.origin, anglesToForward((0, 0, 0)), anglestoup((0, 0, 0)));
}

function function_e7ad996() {
  if(is_true(self.ai.var_870d0893)) {
    setup_awareness(self);
  }
}

function function_f9780e50(params) {
  self endon(#"death");

  if(isDefined(self.attackable)) {
    namespace_85745671::function_2b925fa5(self);
  }

  self.var_98f1f37c = 1;
  self kill(undefined, undefined, undefined, undefined, 0, 1);
}

function private setup_awareness(entity) {
  entity.has_awareness = 1;
  entity.ignorelaststandplayers = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
  awareness::register_state(entity, #"wander", &function_1df172de, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
  awareness::register_state(entity, #"investigate", &function_bbd541c7, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
  awareness::register_state(entity, #"chase", &function_7812e703, &function_333a7b23, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
  awareness::set_state(entity, #"wander");
  entity thread awareness::function_fa6e010d();
}

function private function_1df172de(entity) {
  self.fovcosine = 0.5;
  self.maxsightdistsqrd = sqr(1000);
  self.var_1267fdea = 0;
  awareness::function_9c9d96b5(entity);
}

function private function_bbd541c7(entity) {
  self.fovcosine = 0;
  self.maxsightdistsqrd = sqr(1800);
  self.var_1267fdea = 0;
  awareness::function_b41f0471(entity);
}

function private function_7812e703(entity) {
  self.fovcosine = 0;
  self.maxsightdistsqrd = sqr(3000);
  self.var_1267fdea = 0;
  awareness::function_978025e4(entity);
}

function private function_333a7b23(entity) {
  if(isDefined(entity.attackable) && !isDefined(entity.var_b238ef38)) {
    if(!isDefined(entity.var_3f8ea75c)) {
      entity.var_3f8ea75c = namespace_85745671::function_12d90bae(entity, 150, 750, entity.attackable);
    }

    if(isDefined(entity.var_3f8ea75c)) {
      if(!entity isingoal(entity.var_3f8ea75c)) {
        entity setgoal(entity.var_3f8ea75c);
        entity waittill(#"goal", #"attackable_cleared");

        if(isDefined(entity.attackable)) {
          var_bf3a521d = vectortoangles(entity.attackable.origin - entity.origin);
          entity forceteleport(entity.origin, (0, var_bf3a521d[1], 0), 0);
        }

        return;
      }

      if(entity isatgoal()) {
        var_bf3a521d = entity.attackable.origin - entity.origin;
        var_bf3a521d = vectornormalize(var_bf3a521d);

        if(vectordot(var_bf3a521d, anglesToForward(entity.angles)) < 0.99) {
          var_ae7100d7 = vectortoangles(var_bf3a521d);
          entity forceteleport(entity.origin, (0, var_ae7100d7[1], 0), 0);
        }
      }

      return;
    }
  }

  if(is_true(entity.var_1fa24724)) {
    if(!isDefined(entity.var_ba3e3319)) {
      entity.var_ba3e3319 = -1;
    }

    enemy = zm_ai_utility::function_825317c(entity);

    if(isDefined(enemy) && distance2dsquared(enemy.origin, entity.origin) < 2250000 * sqr(0.5)) {
      if(gettime() > entity.var_ba3e3319) {
        entity.var_ba3e3319 = gettime() + int(1 * 1000);
        goal_info = entity function_4794d6a3();
        var_136a3202 = 0;
        target_point = namespace_b619101e::function_3848e282(enemy);

        if(isDefined(goal_info.goalpos)) {
          var_a2904933 = entity gettagorigin("tag_weapon_right") - entity.origin;

          if(bullettracepassed(goal_info.goalpos + var_a2904933, target_point, 0, enemy)) {
            var_136a3202 = 1;
          }
        }

        to_enemy = target_point - entity.origin;
        to_enemy = (to_enemy[0], to_enemy[1], 0);
        to_enemy = vectornormalize(to_enemy);

        if(is_false(var_136a3202)) {
          dist = distance2d(target_point, entity.origin);
          new_goal = checknavmeshdirection(entity.origin, to_enemy * -1, randomfloat(max(750 - dist, 0)), entity getpathfindingradius() * 1.2);
          entity setgoal(new_goal);
          return;
        }

        if(is_true(goal_info.isatgoal)) {
          var_d799417b = vectortoangles(to_enemy);
          entity forceteleport(entity.origin, (0, var_d799417b[1], 0), 0);
        }
      }

      return;
    }
  } else {
    var_bd871069 = !isDefined(entity.enemy_override) && !isDefined(entity.attackable) || isDefined(entity.var_8a3828c6);

    if(var_bd871069) {
      goal_info = entity function_4794d6a3();
      enemy = zm_ai_utility::function_825317c(entity);

      if(is_true(goal_info.isatgoal) && isDefined(enemy)) {
        to_enemy = enemy.origin - self.origin;
        var_d799417b = vectortoangles(to_enemy);
        entity forceteleport(entity.origin, (0, var_d799417b[1], 0), 0);
      }
    }
  }

  awareness::function_39da6c3c(entity);
}

function private function_9cb1b62f(entity) {}