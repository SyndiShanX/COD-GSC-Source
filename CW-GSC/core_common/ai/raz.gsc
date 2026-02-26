/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\raz.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_spawner;
#namespace namespace_b619101e;

function autoexec init() {
  function_c7bb75d5();
  spawner::add_archetype_spawn_function(#"raz", &function_fd79187b);
  spawner::add_archetype_spawn_function(#"raz", &namespace_eb2895::function_3113cf8f);
  spawner::function_89a2cd87(#"raz", &namespace_eb2895::function_ac64daa7);
  clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 1, 1, "int");
  clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 1, 1, "int");
  clientfield::register("scriptmover", "raz_torpedo_play_trail", 1, 1, "counter");
  clientfield::register("actor", "raz_gun_weakpoint_hit", 1, 1, "counter");
  level.var_92e56a0f[#"raz"] = &namespace_eb2895::function_4c13b4e7;
}

function private function_c7bb75d5() {
  assert(isscriptfunctionptr(&razsprintservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razSprintService", &razsprintservice);
  assert(isscriptfunctionptr(&razshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldMelee", &razshouldmelee);
  assert(isscriptfunctionptr(&razshouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowPain", &razshouldshowpain);
  assert(isscriptfunctionptr(&razshouldshowspecialpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowSpecialPain", &razshouldshowspecialpain);
  assert(isscriptfunctionptr(&razshouldshowshieldpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowShieldPain", &razshouldshowshieldpain);
  assert(isscriptfunctionptr(&razshouldshootgroundtorpedo));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShootGroundTorpedo", &razshouldshootgroundtorpedo);
  assert(isscriptfunctionptr(&razshouldgoberserk));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldGoBerserk", &razshouldgoberserk);
  assert(isscriptfunctionptr(&razshouldtraversewindow));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldTraverseWindow", &razshouldtraversewindow);
  assert(isscriptfunctionptr(&razgroundtorpedowasinterrupted));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razGroundTorpedoWasInterrupted", &razgroundtorpedowasinterrupted);
  assert(isscriptfunctionptr(&razshouldcutoffarm));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldCutOffArm", &razshouldcutoffarm);
  assert(isscriptfunctionptr(&razshouldmeleerun));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldMeleeRun", &razshouldmeleerun);
  assert(isscriptfunctionptr(&razstartmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razStartMelee", &razstartmelee);
  assert(isscriptfunctionptr(&razfinishmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishMelee", &razfinishmelee);
  assert(isscriptfunctionptr(&razfinishgroundtorpedo));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishGroundTorpedo", &razfinishgroundtorpedo);
  assert(isscriptfunctionptr(&razgoneberserk));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razGoneBerserk", &razgoneberserk);
  assert(isscriptfunctionptr(&raztookpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razTookPain", &raztookpain);
  assert(isscriptfunctionptr(&razstartdeath));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razStartDeath", &razstartdeath);
  assert(isscriptfunctionptr(&razgroundtorpedostaggerstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("razGroundTorpedoStaggerStart", &razgroundtorpedostaggerstart);
  assert(!isDefined(&function_68ef46bd) || isscriptfunctionptr(&function_68ef46bd));
  assert(!isDefined(&function_46545247) || isscriptfunctionptr(&function_46545247));
  assert(!isDefined(&razfinishgroundtorpedo) || isscriptfunctionptr(&razfinishgroundtorpedo));
  behaviortreenetworkutility::registerbehaviortreeaction("razGroundTorpedoAction", &function_68ef46bd, &function_46545247, &razfinishgroundtorpedo);
  animationstatenetwork::registeranimationmocomp("mocomp_raz_shoot_torpedo", &function_20e100b4, &function_70204084, &function_bf9973c);
  animationstatenetwork::registernotetrackhandlerfunction("mangler_fire", &function_67e66d54);
  animationstatenetwork::registernotetrackhandlerfunction("raz_mangler_gib", &function_c49e4c9);
}

function private function_fd79187b() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &function_1004084b;
}

function private function_1004084b(entity) {
  entity.__blackboard = undefined;
  entity function_fd79187b();

  if(is_true(entity.var_6f97029e)) {
    entity.var_a55d2294 = undefined;
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  }

  if(!is_true(entity.var_5c09e990)) {
    entity setblackboardattribute("_gibbed_limbs", "right_arm");
  }
}

function private bb_getshouldturn() {
  if(isDefined(self.should_turn) && self.should_turn) {
    return "should_turn";
  }

  return "should_not_turn";
}

function private razsprintservice(entity) {
  if(is_true(entity.var_6f97029e)) {
    return 0;
  }

  if(!isDefined(entity.var_a55d2294)) {
    return 0;
  }

  if(gettime() > entity.var_a55d2294) {
    entity.var_a55d2294 = undefined;
    entity.var_6f97029e = 1;
    entity.berserk = 1;
    entity thread function_3c423226();
    entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");

    if(!isDefined(self.var_19ec2cc3)) {
      entity asmsetanimationrate(1);
    }
  }
}

function razshouldmelee(entity) {
  if(entity.ignoreall) {
    return false;
  }

  if(is_true(entity.var_bb461bfb)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 5625) {
    return false;
  }

  yaw = abs(zombie_utility::getyawtoenemy());

  if(yaw > 45) {
    return false;
  }

  return true;
}

function private razshouldshowpain(entity) {
  if(is_true(entity.berserk) && !is_true(entity.var_4e179643) || isDefined(entity.var_3059ea5f) || is_true(entity.var_6d2f7ac8)) {
    return false;
  }

  if(is_true(entity.var_10552fac)) {
    return false;
  }

  if(isDefined(level.var_eeb66e64) && ![[level.var_eeb66e64]](entity)) {
    return false;
  }

  return true;
}

function private razshouldshowspecialpain(entity) {
  var_76279076 = entity getblackboardattribute("_gib_location");

  if(var_76279076 === "right_arm") {
    return true;
  }

  if(!razshouldshowpain(entity)) {
    return false;
  }

  var_a8fd62d7 = gettime() - entity.var_5ed30918;

  if(var_a8fd62d7 > 100) {
    return false;
  }

  if(var_76279076 === "head" || var_76279076 === "arms" || var_76279076 === "right_leg" || var_76279076 === "left_leg" || var_76279076 === "left_arm") {
    return true;
  }

  return false;
}

function private razshouldshowshieldpain(entity) {
  if(isDefined(entity.damageweapon) && isDefined(entity.damageweapon.name)) {
    return (entity.damageweapon.name == "dragonshield");
  }

  return false;
}

function private razshouldgoberserk(entity) {
  if(is_true(entity.berserk) && !is_true(entity.var_4e179643)) {
    return true;
  }

  if(is_true(entity.var_10552fac) && !is_true(entity.berserk)) {
    return true;
  }

  return false;
}

function private razshouldtraversewindow(entity) {
  return is_true(entity.var_54ce29af);
}

function private razgroundtorpedowasinterrupted(entity) {
  return is_true(entity.var_6d2f7ac8);
}

function private razshouldcutoffarm(entity) {
  return entity.var_417905cf <= 0;
}

function private razshouldmeleerun(entity) {
  if(entity.ignoreall) {
    return false;
  }

  if(!isDefined(entity.favoriteenemy) || entity getblackboardattribute("_locomotion_speed") != "locomotion_speed_sprint") {
    return false;
  }

  var_ff38566a = lengthsquared(entity.favoriteenemy getvelocity());
  var_17c3916f = 7225;

  if(var_ff38566a < sqr(100)) {
    var_17c3916f = 30625;
  }

  if(distancesquared(entity.origin, entity.favoriteenemy.origin) > var_17c3916f) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  return true;
}

function private razgoneberserk(entity) {
  entity.var_4e179643 = 1;
}

function private raztookpain(entity) {
  entity setblackboardattribute("_gib_location", "legs");
}

function private razstartdeath(entity) {
  entity playsoundontag("zmb_raz_death", "tag_eye");
  weakpoints = namespace_81245006::function_fab3ee3e(entity);

  if(!isDefined(weakpoints)) {
    return;
  }

  foreach(weakpoint in weakpoints) {
    if(namespace_81245006::function_f29756fe(weakpoint) === 1 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);

      switch (weakpoint.var_f371ebb0) {
        case # "helmet":
          self namespace_eb2895::function_2eb802f5(undefined);
          break;
        case # "body_armor":
          self namespace_eb2895::function_50c2a59e(undefined);
          break;
        case # "left_arm_armor":
          self namespace_eb2895::function_597f31c9(undefined);
          break;
        case # "right_leg_armor":
          self namespace_eb2895::function_578362e9(undefined);
          break;
        case # "left_leg_armor":
          self namespace_eb2895::function_50f53d3b(undefined);
          break;
        case # "right_arm_armor":
          self namespace_eb2895::function_afcd63e1(undefined, undefined, undefined);
          break;
        default:
          break;
      }
    }
  }
}

function private razgroundtorpedostaggerstart(entity) {
  entity.var_6d2f7ac8 = undefined;
}

function private razshouldshootgroundtorpedo(entity) {
  if(entity.ignoreall) {
    return false;
  }

  if(is_true(entity.var_10552fac)) {
    return false;
  }

  if(is_true(entity.var_467d69c7)) {
    return true;
  }

  target = get_target_ent(entity);

  if(!isDefined(target)) {
    return false;
  }

  if(!is_true(entity.var_5c09e990)) {
    return false;
  }

  time = gettime();

  if(time < entity.var_af9cbc1c) {
    return false;
  }

  enemy_dist_sq = distancesquared(entity.origin, target.origin);

  if(!((enemy_dist_sq >= 22500 || is_true(entity.var_1fa24724)) && enemy_dist_sq <= 2250000 && entity function_bb9de4d7(target))) {
    return false;
  }

  if(isDefined(entity.check_point_in_enabled_zone)) {
    var_8a3fbe2f = [[entity.check_point_in_enabled_zone]](entity.origin);

    if(!var_8a3fbe2f) {
      return false;
    }
  }

  if(is_true(entity.var_e8f3d773)) {
    return false;
  }

  return true;
}

function private function_bb9de4d7(enemy) {
  entity = self;
  origin_point = entity gettagorigin("tag_weapon_right");
  target_point = function_3848e282(enemy);
  var_8b96a9fe = anglesToForward(self.angles);
  var_6c822643 = target_point - origin_point;

  if(vectordot(var_8b96a9fe, var_6c822643) <= 0 && !is_true(entity.var_1fa24724)) {
    return false;
  }

  var_69a5225c = anglestoright(self.angles);
  var_6b5b7991 = vectordot(var_6c822643, var_69a5225c);

  if(abs(var_6b5b7991) > 50 && !is_true(entity.var_1fa24724)) {
    return false;
  }

  trace = bulletTrace(origin_point, target_point, 0, enemy);

  if(trace[#"fraction"] === 1) {
    return true;
  }

  return false;
}

function private razstartmelee(entity) {}

function private razfinishmelee(entity) {
  entity.var_bb461bfb = undefined;
}

function private function_68ef46bd(entity, asmstate) {
  animationstatenetworkutility::requeststate(entity, asmstate);
  return 5;
}

function private function_46545247(entity, asmstate) {
  if(isDefined(asmstate.var_417905cf) && isDefined(asmstate.var_3059ea5f) && is_true(asmstate.var_3059ea5f.var_2b605d6f) && asmstate.var_417905cf <= asmstate.var_3059ea5f.var_f4c2aef8) {
    asmstate.var_6d2f7ac8 = 1;
    return 4;
  }

  if(asmstate asmgetstatus() == "asm_status_complete") {
    return 4;
  }

  return 5;
}

function private razfinishgroundtorpedo(entity, asmstate) {
  asmstate.var_467d69c7 = undefined;
  asmstate.var_af9cbc1c = gettime() + 3000;
  return 4;
}

function private function_20e100b4(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompanimflag notify(#"hash_6abeb88b076c8c04");

  if(is_true(mocompanimflag.var_1fa24724)) {
    target = get_target_ent(mocompanimflag);
    mocompanimflag orientmode("face point", target.origin);
  } else {
    mocompanimflag orientmode("face current");
  }

  mocompanimflag animmode("zonly_physics");
  mocompanimflag.blockingpain = 1;
  health_multiplier = 1;
  n_player_count = getplayers().size;
  var_9385094f = n_player_count - 1;

  if(isDefined(self.var_b3c613a7) && isDefined(self.var_b3c613a7[var_9385094f])) {
    health_multiplier = self.var_b3c613a7[var_9385094f];
  }

  var_85c30cab = max(mocompanimflag.var_417905cf - 0.05 * mocompanimflag.maxhealth, 0);

  if(mocompanimflag.subarchetype === # "hash_471ba598e7e8c460") {
    var_85c30cab = max(mocompanimflag.var_417905cf - 0.01 * mocompanimflag.maxhealth, 0);
  }

  mocompanimflag.var_3059ea5f = {
    #var_2b605d6f: 0, #var_f4c2aef8: var_85c30cab, #var_a0a74f78: getnotetracktimes(mocompduration, "raz_vulnerable_start")[0], #var_eea3c0a6: getnotetracktimes(mocompduration, "raz_vulnerable_end")[0]
  };
}

function private function_70204084(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  animtime = mocompanimflag getanimtime(mocompduration);

  if(animtime >= mocompanimflag.var_3059ea5f.var_a0a74f78 && animtime < mocompanimflag.var_3059ea5f.var_eea3c0a6) {
    mocompanimflag.var_3059ea5f.var_2b605d6f = 1;
  } else {
    mocompanimflag.var_3059ea5f.var_2b605d6f = 0;
  }

  return 5;
}

function private function_bf9973c(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.var_3059ea5f = undefined;
  mocompduration.blockingpain = 0;
}

function private function_67e66d54(entity) {
  target = get_target_ent(entity);

  if(!isDefined(target) && !is_true(entity.var_467d69c7)) {
    println("<dev string:x38>");
    return;
  }

  entity function_4860f26d(target, (0, 0, 48));
  entity.var_af9cbc1c = gettime() + 3000;
}

function private function_c49e4c9(entity) {
  namespace_eb2895::function_30df6d2b(entity);
}

function get_target_ent(entity) {
  if(isDefined(entity.attackable)) {
    return entity.attackable;
  }

  return zm_ai_utility::function_825317c(entity);
}

function private function_ca603f82(forward_dir, var_d3db66ab, var_5107adf5, max_angle) {
  vec_to_enemy = var_5107adf5 - var_d3db66ab;
  vec_to_enemy_normal = vectornormalize(vec_to_enemy);
  angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);

  if(angle_to_enemy >= max_angle) {
    return vec_to_enemy_normal;
  }

  plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
  perpendicular_normal = vectorcross(plane_normal, forward_dir);
  var_adf30eca = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
  return var_adf30eca;
}

function private function_4860f26d(var_ad2d46ff, var_e6e4425) {
  var_d3db66ab = self gettagorigin("tag_weapon_right");
  var_5107adf5 = var_ad2d46ff.origin + var_e6e4425;
  var_36dbf72a = spawn("script_model", var_d3db66ab);
  var_36dbf72a setModel("tag_origin");
  var_36dbf72a clientfield::set("raz_torpedo_play_fx_on_self", 1);
  var_36dbf72a.var_90d59738 = 0;
  var_36dbf72a.var_a45c4e6 = self;

  if(!isDefined(level.var_9ded2ca6)) {
    level.var_9ded2ca6 = [];
  } else if(!isarray(level.var_9ded2ca6)) {
    level.var_9ded2ca6 = array(level.var_9ded2ca6);
  }

  level.var_9ded2ca6[level.var_9ded2ca6.size] = var_36dbf72a;
  vec_to_enemy = function_ca603f82(anglesToForward(self.angles), var_d3db66ab, var_5107adf5, 0.7);
  angles_to_enemy = vectortoangles(vec_to_enemy);
  var_36dbf72a.angles = angles_to_enemy;
  normal_vector = vectornormalize(vec_to_enemy);
  var_36dbf72a.var_d070aa8d = normal_vector;
  var_36dbf72a.knockdown_iterations = 0;
  var_36dbf72a thread function_8e224906(var_ad2d46ff);
  var_36dbf72a thread function_265f547e(var_ad2d46ff);
  var_36dbf72a thread function_328c7269(var_ad2d46ff, var_e6e4425);
}

function private function_8e224906(var_ad2d46ff) {
  self endon(#"death", #"detonated");
  var_36dbf72a = self;
  var_3707407 = 70;
  max_trail_iterations = int(1500 / var_3707407);

  while(isDefined(var_36dbf72a)) {
    if(!isDefined(var_ad2d46ff) || var_36dbf72a.var_90d59738 >= max_trail_iterations) {
      var_36dbf72a thread function_ddf221f2(0);
    } else {
      var_36dbf72a function_edb8ac3f(var_ad2d46ff);
      var_36dbf72a.var_90d59738 += 1;
    }

    wait 0.1;
  }
}

function private function_328c7269(var_ad2d46ff, var_e6e4425) {
  self endon(#"death", #"detonated");
  var_36dbf72a = self;

  while(isDefined(var_36dbf72a) && isDefined(var_ad2d46ff)) {
    var_5107adf5 = var_ad2d46ff.origin + var_e6e4425;

    if(distancesquared(var_36dbf72a.origin, var_5107adf5) <= 2304) {
      var_36dbf72a thread function_ddf221f2(0);
    }

    waitframe(1);
  }
}

function function_3848e282(var_14df4369) {
  height_offset = (0, 0, 48);
  var_30c2c6c3 = var_14df4369.origin + height_offset;

  if(isPlayer(var_14df4369)) {
    if(var_14df4369 isinvehicle()) {
      vehicle = var_14df4369 getvehicleoccupied();
      var_30c2c6c3 = (var_14df4369.origin[0], var_14df4369.origin[1], vehicle.origin[2]) + height_offset;
    } else {
      var_30c2c6c3 = var_14df4369 getplayercamerapos();
    }
  }

  return var_30c2c6c3;
}

function private function_edb8ac3f(var_ad2d46ff) {
  self endon(#"death");
  self endon(#"detonated");

  if(!isDefined(self.var_c4f2952f)) {
    var_9c0d0e5b = 2.8;
    self.var_c4f2952f = cos(var_9c0d0e5b);
  }

  if(isDefined(self.var_d070aa8d)) {
    var_30c2c6c3 = function_3848e282(var_ad2d46ff);
    vector_to_target = var_30c2c6c3 - self.origin;
    normal_vector = vectornormalize(vector_to_target);
    var_700ba47b = vectornormalize((normal_vector[0], normal_vector[1], 0));
    var_cb266a = vectornormalize((self.var_d070aa8d[0], self.var_d070aa8d[1], 0));
    dot = vectordot(var_700ba47b, var_cb266a);

    if(dot >= 1) {
      dot = 1;
    } else if(dot <= -1) {
      dot = -1;
    }

    if(dot < self.var_c4f2952f) {
      new_vector = normal_vector - self.var_d070aa8d;
      angle_between_vectors = acos(dot);

      if(!isDefined(angle_between_vectors)) {
        angle_between_vectors = 180;
      }

      if(angle_between_vectors == 0) {
        angle_between_vectors = 0.0001;
      }

      var_fca71723 = 2.8;
      ratio = var_fca71723 / angle_between_vectors;

      if(ratio > 1) {
        ratio = 1;
      }

      new_vector *= ratio;
      new_vector += self.var_d070aa8d;
      normal_vector = vectornormalize(new_vector);
    }
  }

  move_distance = 70;
  move_vector = move_distance * normal_vector;
  move_to_point = self.origin + move_vector;
  trace = bulletTrace(self.origin, move_to_point, 0, self);

  if(trace[#"surfacetype"] !== "none") {
    detonate_point = trace[#"position"];
    dist_sq = distancesquared(detonate_point, self.origin);
    move_dist_sq = move_distance * move_distance;
    ratio = dist_sq / move_dist_sq;
    delay = ratio * 0.1;
    self thread function_ddf221f2(delay);
  }

  self.var_d070aa8d = normal_vector;
  self moveto(move_to_point, 0.1);

  if(getdvarint(#"hash_4901482f884b01dc", 0)) {
    line(self.origin, move_to_point, (0, 0, 1), 1, 0, 500);
  }
}

function private function_fc00dc60() {
  self endon(#"death");
  self endon(#"detonated");
  var_5bac442e = 26;

  if(self.var_90d59738 >= 1) {
    trace = bulletTrace(self.origin + (0, 0, 10), self.origin - (0, 0, var_5bac442e), 0, self);

    if(trace[#"surfacetype"] !== "none") {
      self clientfield::increment("raz_torpedo_play_trail", 1);
    }
  }
}

function private function_f95c27a2(target) {
  self endon(#"death");

  while(isDefined(self)) {
    if(isDefined(target)) {
      if(isPlayer(target)) {
        var_71872c01 = target.origin + (0, 0, 48);
      } else {
        var_71872c01 = target.origin;
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
      vector_to_target = var_71872c01 - self.origin;
      normal_vector = vectornormalize(vector_to_target);
      move_distance = 700 * prediction_time;
      move_vector = move_distance * normal_vector;
      self.angles = vectortoangles(move_vector);
    } else {
      velocity = self getvelocity();
      velocitymag = length(velocity);
      b_sprinting = velocitymag >= 40;

      if(b_sprinting) {
        var_b98d779c = 0.2;
        move_vector = velocity * var_b98d779c;
      }
    }

    if(!isDefined(b_sprinting) || b_sprinting == 1) {
      predicted_pos = self.origin + move_vector;
      a_zombies = getentitiesinradius(predicted_pos, 48, 15);
      var_eb2cabb5 = array::filter(a_zombies, 0, &function_2171139f, self, predicted_pos);
    } else {
      wait 0.2;
      continue;
    }

    foreach(zombie in var_eb2cabb5) {
      zombie zombie_utility::setup_zombie_knockdown(self.origin);
    }

    wait 0.2;
  }
}

function private function_265f547e(var_ad2d46ff) {
  self endon(#"death");
  self endon(#"detonated");
  function_f95c27a2(var_ad2d46ff);
}

function private function_3c423226() {
  self endon(#"death", #"hash_ce013f00056f6fe");
  self notify(#"hash_3d58a1166d034e55");
  self endon(#"hash_3d58a1166d034e55");
  function_f95c27a2();
}

function private function_ddf221f2(delay) {
  self endon(#"death");
  self notify(#"detonated");
  var_36dbf72a = self;
  var_a45c4e6 = self.var_a45c4e6;

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(self)) {
    self function_abaec088();
    w_weapon = getweapon("none");
    explosion_point = var_36dbf72a.origin;
    var_36dbf72a clientfield::set("raz_detonate_ground_torpedo", 1);
    radiusdamage(explosion_point + (0, 0, 18), 96, 75, 50, self.var_a45c4e6, "MOD_EXPLOSIVE", w_weapon);
    function_a90fe496(explosion_point + (0, 0, 18));
    self clientfield::set("raz_torpedo_play_fx_on_self", 0);

    if(isarray(level.var_9ded2ca6)) {
      arrayremovevalue(level.var_9ded2ca6, self);
    }

    wait 0.5;

    if(isDefined(var_a45c4e6) && is_true(level.var_21b0396e)) {
      var_a45c4e6.var_af9cbc1c = gettime();
    }

    if(isDefined(self)) {
      self delete();
    }
  }
}

function private function_a90fe496(var_cf34de7a) {
  players = getplayers();
  v_length = sqr(100);

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isalive(player)) {
      continue;
    }

    if(player.sessionstate == "spectator") {
      continue;
    }

    if(player.sessionstate == "intermission") {
      continue;
    }

    if(is_true(player.ignoreme)) {
      continue;
    }

    if(player isnotarget()) {
      continue;
    }

    if(!player isonground()) {
      continue;
    }

    n_distance = distance2dsquared(var_cf34de7a, player.origin);

    if(n_distance < 0.01) {
      continue;
    }

    if(n_distance < v_length) {
      v_dir = player.origin - var_cf34de7a;
      v_dir = (v_dir[0], v_dir[1], 0.1);
      v_dir = vectornormalize(v_dir);
      n_push_strength = getdvarint(#"hash_3ce74fce73494ef0", 500);
      n_push_strength = 200 + randomint(n_push_strength - 200);
      v_player_velocity = player getvelocity();
      player setvelocity(v_player_velocity + v_dir * n_push_strength);
    }
  }
}

function private function_abaec088() {
  earthquake(0.4, 0.8, self.origin, 300);
  players = getentitiesinradius(self.origin, 48, 1);

  foreach(player in players) {
    player playrumbleonentity("damage_heavy");
  }
}

function private function_2171139f(zombie, target) {
  if(zombie.archetype !== # "zombie" || zombie.knockdown === 1 || gibserverutils::isgibbed(zombie, 384)) {
    return false;
  }

  origin = target.origin;
  facing_vec = anglesToForward(target.angles);
  enemy_vec = zombie.origin - origin;
  var_660d1fec = (enemy_vec[0], enemy_vec[1], 0);
  var_58877074 = (facing_vec[0], facing_vec[1], 0);
  var_660d1fec = vectornormalize(var_660d1fec);
  var_58877074 = vectornormalize(var_58877074);
  enemy_dot = vectordot(var_58877074, var_660d1fec);

  if(enemy_dot < 0) {
    return false;
  }

  return true;
}

#namespace namespace_eb2895;

function private function_3113cf8f() {
  self.var_af9cbc1c = gettime();
  self.var_5c09e990 = 1;
  self.var_e4fc6a2f = 1;
  self.var_9f71af13 = 1;
  self.var_8e205014 = 1;
  self.var_c0a83965 = 1;
  self.var_cb66dfbf = 1;
  self.var_4e179643 = 0;
  self.var_28621cf4 = "j_head";
  self.var_e5365d8a = (0, 0, 0);
  self.canbetargetedbyturnedzombies = 1;
  self.var_2672b13c = 1;
  self.flame_fx_timeout = 3;
  self.var_5ed30918 = 0;
  aiutility::addaioverridedamagecallback(self, &function_85b9ec36);
  self thread function_37c7f369();
  self destructserverutils::togglespawngibs(self, 1);
  self callback::function_d8abfc3d(#"hash_69106b41ba3763f7", &function_9d12d0d2);
  level thread zm_spawner::zombie_death_event(self);
}

function private function_ac64daa7() {
  self.var_417905cf = 0.25 * self.maxhealth;
  self.var_7cda74 = 0.1 * self.maxhealth;
  self.var_e0947b4e = 0.2 * self.maxhealth;
  self.var_d6fdc42c = 0.1 * self.maxhealth;
  self.var_972ecf6d = 0.1 * self.maxhealth;
  self.var_6eabd43c = 0.1 * self.maxhealth;
  self.var_b0f20cfe = &function_1f9940b8;
  namespace_81245006::initweakpoints(self);
  self thread function_1f9940b8();
  self thread function_435778e4();
}

function function_435778e4() {
  self.var_b467f3a1 = &function_2869a8ae;
  self thread function_3d267030();
  self thread function_3c2e8416();
}

function function_2869a8ae(eventstruct) {
  if(!is_true(level.var_2356dff1)) {
    return;
  }

  notify_string = eventstruct.action;
  str_alias = notify_string;
  var_6281c93d = 0;
  n_priority = 1;
  var_c8109157 = 0;

  switch (notify_string) {
    case # "summon":
    case # "ambient_line":
      self thread function_6f9720f9(notify_string);
      return;
    case # "death":
      var_6281c93d = 1;
      n_priority = 4;
      break;
    case # "pain":
    case # "land":
    case # "weapon_fire":
    case # "idle_anim":
    case # "pre_weapon_fire":
      var_6281c93d = 1;
      n_priority = 3;
      break;
    case # "enrage":
    case # "melee_notetrack_2":
      var_6281c93d = 1;
      n_priority = 3;
      var_c8109157 = 1;
      break;
    case # "alerted":
    case # "melee_notetrack":
    case # "jump":
    case # "lose_enemy":
      var_6281c93d = 1;
      n_priority = 2;
      var_c8109157 = 1;
      break;
    case # "ambient":
    case # "ambient_enraged":
    case # "ambient_alert":
      n_priority = 1;
      break;
    case # "attack_melee":
      return;
    default:
      n_priority = 2;
      break;
  }

  level thread zm_audio::zmbaivox_playvox(self, str_alias, var_6281c93d, n_priority, var_c8109157);
}

function function_6f9720f9(str_type) {
  self endon(#"death");

  if(isDefined(self.currentvoxpriority)) {
    if(self.currentvoxpriority >= 3) {
      return;
    }
  }

  if(isDefined(self.currentvox)) {
    self stopsound(self.currentvox);
    waitframe(1);
  }

  str_alias = function_5e4c45ae(str_type);

  if(!isDefined(str_alias)) {
    return;
  }

  self.delayambientvox = 1;
  self thread zm_audio::zmbaivox_ambientdelay();
  self.talking = 1;
  self.currentvox = str_alias;
  self.currentvoxpriority = 4;

  if(self haspart("tag_eye")) {
    self playsoundontag(str_alias, "tag_eye");
  } else if(self haspart("j_neck")) {
    self playsoundontag(str_alias, "j_neck");
  }

  playbacktime = float(max(isDefined(soundgetplaybacktime(str_alias)) ? soundgetplaybacktime(str_alias) : 500, 500)) / 1000;
  wait playbacktime;
  self.talking = 0;
  self.currentvox = undefined;
  self.currentvoxpriority = 1;
}

function function_5e4c45ae(str_type) {
  var_e31ec7b0 = array("vox_obj_hvt_hunt_sumn_mglr_mglr_0", "vox_obj_hvt_hunt_sumn_mglr_mglr_1", "vox_obj_hvt_hunt_sumn_mglr_mglr_2", "vox_obj_hvt_hunt_sumn_mglr_mglr_3");
  var_f7458ee2 = array("vox_obj_hvt_mglr_threat_mglr_0", "vox_obj_hvt_mglr_threat_mglr_1", "vox_obj_hvt_mglr_threat_mglr_2", "vox_obj_hvt_mglr_threat_mglr_3", "vox_obj_hvt_mglr_threat_mglr_4", "vox_obj_hvt_mglr_threat_mglr_5", "vox_obj_hvt_mglr_threat_mglr_6", "vox_obj_hvt_mglr_threat_mglr_7", "vox_obj_hvt_mglr_threat_mglr_8", "vox_obj_hvt_mglr_threat_mglr_9");

  if(str_type === "summon") {
    return var_e31ec7b0[randomintrange(0, var_e31ec7b0.size)];
  }

  return var_f7458ee2[randomintrange(0, var_f7458ee2.size)];
}

function function_3c2e8416() {
  self endon(#"death");
  str_notify = "ambient";

  while(true) {
    min_wait = 2;
    max_wait = 5;

    if(is_true(self.berserk) || is_true(self.var_e8f3d773)) {
      str_notify = "ambient_enraged";
    } else if(isDefined(self.zombie_move_speed) && self.zombie_move_speed === "sprint") {
      str_notify = "ambient_enraged";
    } else if(isDefined(self.awarenesslevelcurrent) && self.awarenesslevelcurrent === "combat") {
      str_notify = "ambient_alert";
    } else {
      str_notify = "ambient";
    }

    if(str_notify === "ambient_alert") {
      if(randomintrangeinclusive(1, 100) <= 9) {
        str_notify = "ambient_line";
        min_wait = 4;
        max_wait = 7;
      }
    }

    bhtnactionstartevent(self, str_notify);
    self notify(#"bhtn_action_notify", {
      #action: str_notify
    });
    wait randomfloatrange(min_wait, max_wait);
  }
}

function function_1f9940b8() {
  self endon(#"death");
  playFX(#"zombie/fx9_onslaught_spawn_sm", self.origin);
  playsoundatposition(#"hash_14247392847093a6", self.origin + (0, 0, 75));
  self.in_the_ground = 1;
  self ghost();
  self pathmode("dont move", 1);
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  self orientmode("face default");

  if(!self isragdoll()) {
    self playSound(#"hash_4b49f05e8c054fd9");
    self animscripted("rise_anim", self.origin, self.angles, #"ai_t9_zm_zombie_base_traverse_ground_dugup", "normal");
    waitframe(1);
  }

  self show();
  self pathmode("move allowed");
  self.in_the_ground = 0;
}

function function_3d267030() {
  self endon(#"death");

  while(isDefined(self)) {
    wait randomintrange(2, 9);
    self playsoundontag("vox_ai_raz_ambient_radio", "tag_eye");
    wait 5;
  }
}

function private function_37c7f369() {
  self endon(#"death");
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"melee_fire", #"zombie_melee");

    if(waitresult._notify === # "melee_fire") {
      zombiebehavior::zombienotetrackmeleefire(self);
    }

    a_zombies = getentitiesinradius(self.origin, 90, 15);
    function_1eaaceab(a_zombies);

    foreach(zombie in a_zombies) {
      if(zombie.archetype !== # "zombie" || is_true(zombie.no_gib)) {
        continue;
      }

      heightdiff = abs(zombie.origin[2] - self.origin[2]);

      if(heightdiff > 50) {
        continue;
      }

      var_49122837 = distance2dsquared(zombie.origin, self.origin);

      if(var_49122837 > sqr(90)) {
        continue;
      }

      var_3e3046da = anglesToForward(self.angles);
      var_6c822643 = zombie.origin - self.origin;

      if(vectordot(var_3e3046da, var_6c822643) <= 0) {
        continue;
      }

      var_69a5225c = anglestoright(self.angles);
      var_6b5b7991 = vectordot(var_6c822643, var_69a5225c);

      if(abs(var_6b5b7991) > 35) {
        continue;
      }

      b_gibbed = 0;
      val = randomint(100);

      if(val > 50) {
        if(!gibserverutils::isgibbed(zombie, 32)) {
          gibserverutils::gibrightarm(zombie, 0);
          b_gibbed = 1;
        }
      }

      val = randomint(100);

      if(val > 50) {
        if(!gibserverutils::isgibbed(zombie, 16)) {
          gibserverutils::gibleftarm(zombie, 0);
          b_gibbed = 1;
        }
      }

      if(!is_true(b_gibbed)) {
        if(!gibserverutils::isgibbed(zombie, 32)) {
          gibserverutils::gibrightarm(zombie, 0);
          continue;
        }

        if(!gibserverutils::isgibbed(zombie, 16)) {
          gibserverutils::gibleftarm(zombie, 0);
        }
      }
    }
  }
}

function private hide_part(var_7527000, bapplytochildren = 1) {
  if(self haspart(var_7527000)) {
    self hidepart(var_7527000, "", bapplytochildren);
  }
}

function private function_7428d843() {
  if(!is_true(self.var_5c09e990)) {
    self hide_part("j_shouldertwist_ri_attach");
    self hide_part("j_shoulder_ri_attach", 0);
  }

  if(!is_true(self.var_8e205014)) {
    self hide_part("j_spine4_attach");
    self hide_part("j_spineupper_attach");
    self hide_part("j_spinelower_attach");
    self hide_part("j_mainroot_attach");
    self hide_part("j_clavicle_ri_attachbp");
    self hide_part("j_clavicle_le_attachbp");
  }

  if(!is_true(self.var_9f71af13)) {
    self hide_part("j_shouldertwist_le_attach");
    self hide_part("j_shoulder_le_attach");
    self hide_part("j_clavicle_le_attach");
  }

  if(!is_true(self.var_c0a83965)) {
    self hide_part("j_hiptwist_ri_attach");
    self hide_part("j_hip_ri_attach");
  }

  if(!is_true(self.var_cb66dfbf)) {
    self hide_part("j_hiptwist_le_attach");
    self hide_part("j_hip_le_attach");
  }

  if(!is_true(self.var_e4fc6a2f)) {
    self hide_part("j_head_attach");
  }
}

function private function_85b9ec36(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  entity.var_be44591a = 0;

  if(isDefined(var_fd90b0bb) && var_fd90b0bb == entity) {
    return 0;
  }

  if(entity flag::get("kill_hvt_teleporting")) {
    weakpoint = namespace_81245006::function_3131f5dd(entity, boneindex, 1);

    if(!isDefined(weakpoint)) {
      weakpoint = namespace_81245006::function_37e3f011(entity, modelindex, 1);
    }

    entity.var_6936b30b = {
      #weakpoint: weakpoint, #var_ebcff177: 4
    };
    return 0;
  }

  var_a70572a9 = 0.4;

  if(isDefined(level.var_1b01acb4)) {
    var_a70572a9 *= [[level.var_1b01acb4]](self, hitloc, var_fd90b0bb);
  }

  if(!isDefined(entity.var_a55d2294) && !is_true(entity.berserk)) {
    entity.var_a55d2294 = gettime() + 60000;
  }

  var_ebcff177 = 1;

  if(namespace_81245006::hasarmor(self) && (dir === "MOD_PROJECTILE_SPLASH" || dir === "MOD_GRENADE_SPLASH" || dir == "MOD_EXPLOSIVE")) {
    var_3cddb028 = 1 * point;
    var_31e96b81 = int(var_3cddb028);

    foreach(weakpoint in self.var_5ace757d) {
      if(weakpoint.type === # "armor" && weakpoint.currstate === 1) {
        function_4c13b4e7(entity, weakpoint, var_fd90b0bb, var_31e96b81, var_a70572a9, hitloc, offsettime, dir, weapon);
      }
    }
  }

  weakpoint = namespace_81245006::function_3131f5dd(self, boneindex, 1);

  if(!isDefined(weakpoint)) {
    weakpoint = namespace_81245006::function_37e3f011(self, modelindex, 1);
  }

  if(isDefined(weakpoint)) {
    function_4c13b4e7(entity, weakpoint, var_fd90b0bb, point, var_a70572a9, hitloc, offsettime, dir, weapon);

    if(weakpoint.type === # "armor" && weakpoint.var_f371ebb0 !== "right_arm_armor") {
      var_ebcff177 = 3;
      point = int(point * var_a70572a9);
    }
  }

  if(weakpoint.var_3765e777 === 1 && aiutility::function_e2278a4b(hitloc, dir)) {
    var_ebcff177 = 2;
  }

  if(is_true(level.var_85a39c96)) {
    point = self.health + 1;
  }

  if(!aiutility::function_493e5914(dir)) {
    var_cdbcfa73 = self gettagorigin("j_head");
    offsettime = var_cdbcfa73 + (0, 0, 0);
  }

  self.var_6936b30b = {
    #weakpoint: weakpoint, #var_ebcff177: var_ebcff177
  };
  var_d58c98fd = 0;

  if(!is_true(self.var_e7d6f7b4) && !is_true(self.blockingpain) && !isDefined(self.var_3059ea5f)) {
    self thread function_1bdbe36c();
  }

  return point;
}

function function_1bdbe36c() {
  self endon(#"death", #"hash_6abeb88b076c8c04");
  level endon(#"end_game", #"game_ended");
  self.var_e7d6f7b4 = 1;
  waittillframeend();
  self.blockingpain = 1;
  wait randomfloatrange(1, 2);
  self.blockingpain = 0;
  self.var_e7d6f7b4 = undefined;
}

function function_4c13b4e7(entity, weakpoint, attacker, damage, var_a70572a9, weapon, point, mod, inflictor) {
  if(weakpoint.type === # "weakpoint") {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: attacker, #scoreevent: "hit_weak_point_zm"});
    return;
  }

  if(weakpoint.type === # "armor") {
    self.var_426947c4 = undefined;

    if(namespace_81245006::function_f29756fe(weakpoint) === 1 && isDefined(weakpoint.var_f371ebb0)) {
      if(isDefined(level.var_56f626bc)) {
        damage_mod = [[level.var_56f626bc]](self, weapon, attacker);
        damage *= damage_mod;
      }

      if(weakpoint.var_f371ebb0 == "right_arm_armor") {
        namespace_81245006::damageweakpoint(weakpoint, damage);
        entity clientfield::increment("raz_gun_weakpoint_hit", 1);
        entity.var_417905cf = weakpoint.health;
      } else {
        damage *= var_a70572a9;
        namespace_81245006::damageweakpoint(weakpoint, damage);
      }
    }

    if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(entity, weakpoint.var_f371ebb0);
      scoreevent = "destroyed_armor_zm";
      self.var_426947c4 = 1;

      if(weakpoint.var_f371ebb0 == "helmet") {
        entity function_2eb802f5(attacker);
      }

      if(weakpoint.var_f371ebb0 == "body_armor") {
        entity function_50c2a59e(attacker);
      }

      if(weakpoint.var_f371ebb0 == "left_arm_armor") {
        entity function_597f31c9(attacker);
      }

      if(weakpoint.var_f371ebb0 == "right_leg_armor") {
        entity function_578362e9(attacker);
      }

      if(weakpoint.var_f371ebb0 == "left_leg_armor") {
        entity function_50f53d3b(attacker);
      }

      if(weakpoint.var_f371ebb0 == "right_arm_armor") {
        scoreevent = "mangler_cannon_destroyed_zm";
        entity function_afcd63e1(attacker, damage, point, weapon, mod, inflictor);

        if(isPlayer(attacker)) {
          attacker stats::function_dad108fa(#"hash_6a37af3afff55532", 1);
        }
      }

      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: attacker, #scoreevent: scoreevent
      });
    }
  }
}

function private function_550f17ad(entity, hitloc, point, location, var_971b8272, tag) {
  var_877657e9 = 0;

  if(isDefined(hitloc) && hitloc != "none") {
    if(hitloc == location) {
      var_877657e9 = 1;
    }
  } else {
    dist_sq = distancesquared(point, entity gettagorigin(tag));

    if(dist_sq <= var_971b8272) {
      var_877657e9 = 1;
    }
  }

  return var_877657e9;
}

function function_30df6d2b(entity) {
  self hide_part("j_shouldertwist_ri_attach");
  self hide_part("j_shoulder_ri_attach", 0);
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");

  if(!isDefined(self.var_19ec2cc3)) {
    entity asmsetanimationrate(1);
  }

  entity setblackboardattribute("_gibbed_limbs", "right_arm");
  entity setblackboardattribute("_gib_location", "right_arm");
  entity.var_5ed30918 = gettime();
}

function function_afcd63e1(attacker, damage, point, damage_weapon, mod, inflictor) {
  entity = self;
  entity.var_417905cf = 0;
  entity.var_5c09e990 = 0;
  entity.var_a55d2294 = undefined;
  entity.var_6f97029e = 1;
  entity thread namespace_b619101e::function_3c423226();

  if(!isDefined(entity.var_3059ea5f) || !is_true(entity.var_3059ea5f.var_2b605d6f)) {
    function_30df6d2b(entity);
  }

  function_7428d843();

  if(isDefined(attacker)) {
    level notify(#"hash_60f75ee59e5d030f", attacker);
    self notify(#"hash_60f75ee59e5d030f", attacker);
  }

  if(isDefined(damage)) {
    var_cdbcfa73 = self gettagorigin("j_head");
    point = var_cdbcfa73 + (0, 0, 0);
    var_64d07420 = entity.health - damage;
    var_8b859118 = entity.maxhealth * 0.33;

    if(entity.subarchetype === # "hash_471ba598e7e8c460") {
      var_8b859118 = entity.maxhealth * 0.15;
    }

    var_fc9b8786 = (var_64d07420 - var_8b859118) / entity.maxhealth;

    if(var_8b859118 >= self.health) {
      level scoreevents::doscoreeventcallback("scoreEventZM", {
        #attacker: attacker, #scoreevent: "mangler_arm_cannon_kill_zm"});
    }

    self zombie_utility::function_6975aa10(damage_weapon);
    self dodamage(var_8b859118, self.origin, attacker, inflictor, "none", mod, 0, damage_weapon);
  }
}

function function_2eb802f5(attacker) {
  entity = self;
  entity.var_e4fc6a2f = 0;
  entity setblackboardattribute("_gib_location", "head");
  entity.var_5ed30918 = gettime();
  println("<dev string:x71>");
  entity function_5027ed0f();

  if(isDefined(attacker)) {
    level notify(#"hash_84a93496c95c377", attacker);
  }
}

function function_50c2a59e(attacker) {
  entity = self;
  entity hide_part("j_spine4_attach");
  entity hide_part("j_spineupper_attach");
  entity hide_part("j_spinelower_attach");
  entity hide_part("j_mainroot_attach");
  entity hide_part("j_clavicle_ri_attachbp");
  entity hide_part("j_clavicle_le_attachbp");
  entity.var_8e205014 = 0;
  entity setblackboardattribute("_gib_location", "arms");
  entity.var_5ed30918 = gettime();
  println("<dev string:xa0>");
  entity function_5027ed0f();
}

function function_597f31c9(attacker) {
  entity = self;
  entity hide_part("j_shouldertwist_le_attach");
  entity hide_part("j_shoulder_le_attach");
  entity hide_part("j_clavicle_le_attach");
  entity.var_9f71af13 = 0;
  entity setblackboardattribute("_gib_location", "left_arm");
  entity.var_5ed30918 = gettime();
}

function function_50f53d3b(attacker) {
  entity = self;
  entity hide_part("j_hiptwist_le_attach");
  entity hide_part("j_hip_le_attach");
  entity.var_cb66dfbf = 0;
  entity setblackboardattribute("_gib_location", "left_leg");
  entity.var_5ed30918 = gettime();
}

function function_578362e9(attacker) {
  entity = self;
  entity hide_part("j_hiptwist_ri_attach");
  entity hide_part("j_hip_ri_attach");
  entity.var_c0a83965 = 0;
  entity setblackboardattribute("_gib_location", "right_leg");
  entity.var_5ed30918 = gettime();
}

function function_296795d8(time) {
  self endon(#"death");
  self notify("66e89018dbaeaa07");
  self endon("66e89018dbaeaa07");
  wait time;
  self.var_4e179643 = 0;
  self.var_e8f3d773 = 0;

  if(!is_true(self.berserk)) {
    self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");

    if(!isDefined(self.var_19ec2cc3)) {
      self asmsetanimationrate(1);
    }

    self notify(#"hash_ce013f00056f6fe");
  }
}

function function_5027ed0f() {
  entity = self;
  entity.var_e8f3d773 = 1;
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  entity thread namespace_b619101e::function_3c423226();
  entity thread function_296795d8(15);

  if(!isDefined(self.var_19ec2cc3)) {
    entity asmsetanimationrate(1);
  }
}

function function_9d12d0d2(params) {
  self.var_a55d2294 = gettime();
}