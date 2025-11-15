/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_homunculus.gsc
***************************************************/

#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace gadget_homunculus;

autoexec __init__system__() {
  system::register(#"homunculus", &__init__, undefined, undefined);
}

private __init__() {
  level.var_2da60c10 = [];

  if(isDefined(getgametypesetting(#"wzenablehomunculus")) && getgametypesetting(#"wzenablehomunculus")) {
    level.var_cc310d06 = &function_7bfc867f;
    level thread function_c83057f0();
    callback::on_finalize_initialization(&function_1c601b99);
    level scene::add_scene_func(#"aib_t8_zm_zod_homunculus_jump_up_01", &jump);
  }
}

function_1c601b99() {
  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon(#"homunculus"), &function_127fb8f3);
  }
}

private function_c83057f0() {
  level endon(#"game_ended");

  while(true) {
    foreach(homunculus in level.var_2da60c10) {
      if(!isDefined(homunculus) || homunculus.spawning === 1) {
        continue;
      }

      if(gettime() >= homunculus.despawn_time) {
        homunculus function_7bfc867f();
        continue;
      }

      if(homunculus.attacking === 1) {
        continue;
      }

      if(function_9ce07f7c(homunculus)) {
        homunculus thread function_bb17ec5a();
        continue;
      }

      if(homunculus.dancing !== 1) {
        homunculus thread function_b053b486();
      }

      waitframe(1);
    }

    arrayremovevalue(level.var_2da60c10, undefined);
    waitframe(1);
  }
}

private function_9ce07f7c(homunculus) {
  var_b1de6a06 = getentitiesinradius(homunculus.origin, 250, 15);

  foreach(actor in var_b1de6a06) {
    if(function_62318121(homunculus, actor)) {
      return true;
    }
  }

  return false;
}

private function_90cc805b(homunculus) {
  var_b1de6a06 = getentitiesinradius(homunculus.origin, 250, 15);
  var_9db93b2e = [];

  foreach(nearby_actor in var_b1de6a06) {
    if(function_62318121(homunculus, nearby_actor)) {
      if(!isDefined(var_9db93b2e)) {
        var_9db93b2e = [];
      } else if(!isarray(var_9db93b2e)) {
        var_9db93b2e = array(var_9db93b2e);
      }

      var_9db93b2e[var_9db93b2e.size] = nearby_actor;
    }
  }

  return arraysortclosest(var_9db93b2e, homunculus.origin, undefined, undefined, 250);
}

private function_62318121(homunculus, ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(ent.archetype == "zombie" && util::function_fbce7263(ent.team, homunculus.team)) {
    return true;
  }

  return false;
}

private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(eventstruct.weapon.name == #"homunculus") {
    grenade = eventstruct.projectile;
    grenade ghost();
    grenade.angles = self.angles;
    homunculus = util::spawn_model(grenade.model, grenade.origin, grenade.angles);
    homunculus.spawning = 1;
    homunculus.identifier_weapon = grenade.item;
    homunculus.player = grenade.thrower;
    grenade.homunculus = homunculus;
    grenade.homunculus linkto(grenade);
    grenade.homunculus.team = grenade.team;
    grenade.homunculus clientfield::set("enemyequip", 1);
    var_66ae7054 = 0;

    if(math::cointoss() && math::cointoss()) {
      homunculus playsoundontag(#"hash_8d020e5460f4a95", "j_head");
      var_66ae7054 = 1;
    } else {
      homunculus playsoundontag(#"hash_689f11fd8983d1a6", "j_head");
    }

    homunculus thread scene::play(#"aib_t8_zm_zod_homunculus_throw_loop_01", homunculus);
    grenade waittill(#"stationary", #"death");

    if(isDefined(grenade)) {
      homunculus unlink();
      grenade delete();

      if(isDefined(homunculus)) {
        homunculus.var_acdc8d71 = getclosestpointonnavmesh(homunculus.origin, 360, 15.1875);

        if(!isDefined(level.var_2da60c10)) {
          level.var_2da60c10 = [];
        } else if(!isarray(level.var_2da60c10)) {
          level.var_2da60c10 = array(level.var_2da60c10);
        }

        level.var_2da60c10[level.var_2da60c10.size] = homunculus;
        homunculus.despawn_time = gettime() + int(120 * 1000);
        playFX(#"zm_weapons/fx8_equip_homunc_spawn", homunculus.origin);
        homunculus playSound(#"hash_21206f1b7fb27f81");
        var_255a121f = 0;

        if(math::cointoss() && math::cointoss() && !var_66ae7054) {
          homunculus playsoundontag(#"hash_6b4fa8bf14690e0c", "j_head");
          var_255a121f = 1;
        } else {
          homunculus playsoundontag(#"hash_1d6e8d28eabdb1fb", "j_head");
        }

        mover = util::spawn_model("tag_origin", homunculus.origin, homunculus.angles);
        homunculus linkto(mover);
        homunculus.mover = mover;
        homunculus drop_to_ground(1);
        homunculus scene::stop();

        if(!var_255a121f) {
          homunculus thread function_1dba4a2();
        }

        homunculus.mover scene::play(#"aib_t8_zm_zod_homunculus_deploy_01", homunculus);
        homunculus notify(#"hash_3e410dbcd9e66000");
        homunculus.spawning = undefined;
      }

      return;
    }

    if(isDefined(homunculus)) {
      homunculus delete();
    }
  }
}

function_1dba4a2() {
  self endon(#"death", #"hash_3e410dbcd9e66000");
  self.mover endon(#"death");

  while(true) {
    waitresult = self waittill(#"snddeployvox");

    if(isDefined(waitresult.str_alias)) {
      self playsoundontag(waitresult.str_alias, "j_head");
    }
  }
}

private function_bb17ec5a() {
  self endon(#"death");
  self.attacking = 1;
  self.mover scene::stop();
  self.dancing = undefined;

  iprintlnbold("<dev string:x38>");

  start_attack = 1;

  while(true) {
    var_c7f2fbb7 = function_90cc805b(self);

    if(!var_c7f2fbb7.size) {
      break;
    }

    foreach(enemy in var_c7f2fbb7) {
      if(isalive(enemy) && bullettracepassed(self.origin + (0, 0, 16), enemy getcentroid(), 0, self, enemy)) {
        self face_target(enemy);

        if(start_attack === 1) {
          start_attack = undefined;

          if(math::cointoss() && math::cointoss()) {
            self playSound(#"hash_22c88cff01a4691b");
          }

          self.mover scene::stop();
          self.mover scene::play(#"aib_t8_zm_zod_homunculus_jump_up_01", self);
          self.mover thread scene::play(#"aib_t8_zm_zod_homunculus_attack_01", self);

          if(!isalive(enemy)) {
            continue;
          }
        }

        n_dist = distancesquared(self.origin, enemy.origin);
        n_time = n_dist / 48400;
        n_time *= 0.5;
        self function_c8f642f6(enemy, n_time);
      }

      waitframe(1);
    }

    wait 0.1;
  }

  self drop_to_ground();
  self.attacking = undefined;
}

private function_b053b486() {
  self endon(#"death");
  self.dancing = 1;
  self.mover scene::play(#"aib_t8_zm_zod_homunculus_idle_01", self);
}

private drop_to_ground(b_immediate = 0) {
  self endon(#"death");
  s_trace = groundtrace(self.origin + (0, 0, 16), self.origin + (0, 0, -1000), 0, self);
  var_a75fe4be = s_trace[#"position"];

  if(b_immediate) {
    self.mover moveto(var_a75fe4be, 0.01);
    self.mover waittill(#"movedone");
    return;
  }

  if(abs(self.origin[2] - var_a75fe4be[2]) > 1) {
    n_time = 0.25;
    self.mover scene::stop();
    self.mover moveto(var_a75fe4be, 0.25);
    self.mover scene::play(#"aib_t8_zm_zod_homunculus_jump_down_01", self);
  }
}

private jump(scene_ents) {
  scene_ents[#"homunculus"] endon(#"death");
  scene_ents[#"homunculus"] waittill(#"jumped");

  if(isDefined(scene_ents[#"homunculus"].mover)) {
    scene_ents[#"homunculus"].mover movez(40, 0.35);
  }
}

private face_target(target) {
  v_dir = vectornormalize(target.origin - self.origin);
  v_dir = (v_dir[0], v_dir[1], 0);
  v_angles = vectortoangles(v_dir);
  self.mover rotateto(v_angles, 0.15);
}

private function_c8f642f6(enemy, n_time) {
  self.mover movez(16, n_time);
  self.mover waittill(#"movedone");

  if(isalive(enemy)) {
    v_target = enemy gettagorigin("j_head");

    if(!isDefined(v_target)) {
      v_target = enemy getcentroid() + (0, 0, 16);
    }

    self.mover moveto(v_target, n_time);
    self.mover waittill(#"movedone");

    if(isalive(enemy)) {
      if(math::cointoss() && math::cointoss()) {
        self playSound(#"hash_ba5815eb0dc4d97");
      }

      enemy playSound(#"hash_3a99f739009a77fa");
      enemy dodamage(enemy.health + 666, enemy.origin, self.player, undefined, undefined, "MOD_UNKNOWN", 0, getweapon(#"homunculus"));
      gibserverutils::gibhead(enemy);
    }
  }
}

function_7bfc867f() {
  self playsoundontag(#"hash_6e471fde121d0263", "j_head");
  self drop_to_ground();
  self.mover scene::stop();
  self.mover scene::play(#"aib_t8_zm_zod_homunculus_dth_01", self);
  playFX(#"zm_weapons/fx8_equip_homunc_death_exp", self.origin);
  self delete();
}

function_bd59a592(zombie) {
  var_2d9e38fc = 360 * 360;
  var_128c12c9 = undefined;
  var_b26b6492 = undefined;

  foreach(homunculus in level.var_2da60c10) {
    if(!isDefined(homunculus)) {
      continue;
    }

    dist_sq = distancesquared(zombie.origin, homunculus.origin);

    if(isDefined(homunculus) && homunculus.attacking === 1 && dist_sq < var_2d9e38fc) {
      if(!isDefined(var_128c12c9) || dist_sq < var_128c12c9) {
        var_128c12c9 = dist_sq;
        var_b26b6492 = homunculus;
      }
    }
  }

  return var_b26b6492;
}

function_127fb8f3(homunculus, attackingplayer) {
  homunculus endon(#"death");
  randangle = randomfloat(360);

  if(isDefined(level._equipment_emp_destroy_fx)) {
    playFX(level._equipment_emp_destroy_fx, homunculus.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(homunculus.angles));
  }

  wait 1.1;
  homunculus function_7bfc867f();
}