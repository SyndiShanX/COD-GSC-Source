/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6dce1fe6a7dd35c7.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;
#namespace namespace_2a445563;
class class_9f07f58e {
  var adjustmentstarted;
  var var_425c4c8b;

  constructor() {
    adjustmentstarted = 0;
    var_425c4c8b = 1;
  }
}

function init() {
  clientfield::register("actor", "wrwlf_silver_death_fx", 1, 1, "int");
  clientfield::register("actor", "wrwlf_weakpoint_fx", 1, 2, "counter");
  clientfield::register("actor", "wrwlf_silver_hit_fx", 1, 1, "counter");
  clientfield::register("actor", "wrwlf_leap_attack_rumble", 1, 1, "counter");
  namespace_250e9486::function_252dff4d("werewolf", 18, &function_afc62ca5, undefined);
  registerbehaviorscriptfunctions();
  registerwerewolfinterfaceattributes();
}

function function_afc62ca5() {
  namespace_250e9486::function_25b2c8a9();
  self namespace_250e9486::function_db744d28();
  self.var_9329a57c = 0;
  self.maxhealth += 250000 + int(50000 * namespace_ec06fe4a::function_ef369bae()) + level.doa.var_6c58d51 * 300000;
  self.health = self.maxhealth;
  self.var_c59b482e = self.maxhealth * (0.1 + 0.15 * namespace_ec06fe4a::function_ef369bae());
  self.var_d04a8ee = 200;
  aiutility::addaioverridedamagecallback(self, &function_ebf85268);
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.fovcosinez = 0;
  self.var_1c8b76d3 = 1;
  self.no_gib = 1;
  self.var_1a60ad62 = 0;
  self.var_b7ba7211 = 0;
  self.var_9d9575a4 = 0;
  self.goalradius = 56;
  self.meleedistsq = sqr(92);
  self.var_ccb2e201 = 0;
  self.var_f46fbf3f = 1;
  self.ignorepathenemyfightdist = 1;
  self.var_ceed8829 = 1;
  self.var_7d39ec6a = 1;
  self callback::function_d8abfc3d(#"on_ai_killed", &on_werewolf_killed);
  self setavoidancemask("avoid none");
  self collidewithactors(1);
  self function_11578581(70);
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
  self setblackboardattribute("_werewolf_stance", "upright");
  self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
  self.var_c6213c58 = doa_enemy::function_d7c5adee("wolf_ghosthound");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_werewolf_vocal_summon");
  self thread namespace_9fc66ac::function_ba33d23d(#"hash_64aff27de2337435", #"hash_64aff27de2337435", #"hash_2b3a9f1a898594d7");
  target_set(self);
  self.showdelay = 0.7;
  earthquake(0.5, 0.75, self.origin, 1000);
  self namespace_83eb6304::function_3ecfde67("lightningStrike");
  self namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
}

function on_werewolf_killed(params) {}

function registerwerewolfinterfaceattributes() {
  ai::registermatchedinterface(#"werewolf", #"patrol", 0, array(1, 0), &function_2341cdf0);
  ai::registermatchedinterface(#"werewolf", #"summon_wolves", 0, array(1, 0), &function_2c67c3e1);
}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&werewolfstunstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfstunstart", &werewolfstunstart);
  assert(isscriptfunctionptr(&function_6bfc7a5f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50eb50a32d0c4791", &function_6bfc7a5f);
  assert(isscriptfunctionptr(&werewolfshouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfshouldstun", &werewolfshouldstun);
  assert(isscriptfunctionptr(&werewolfidlestart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfidlestart", &werewolfidlestart);
  assert(isscriptfunctionptr(&function_4014790a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5bd93c0cfe1ada6", &function_4014790a);
  assert(isscriptfunctionptr(&function_1917d76d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d2da6c50e1bc111", &function_1917d76d);
  assert(isscriptfunctionptr(&function_f8912291));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_603662b9e4017e3f", &function_f8912291);
  assert(isscriptfunctionptr(&function_f5d7dc0a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6268b60dd4b1a7d4", &function_f5d7dc0a);
  assert(isscriptfunctionptr(&function_fcc1c537));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ce96736fe43832a", &function_fcc1c537);
  assert(isscriptfunctionptr(&function_f2e3495a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f2cd3c4d5ecbf8d", &function_f2e3495a);
  assert(isscriptfunctionptr(&function_ee311142));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1516ae5422f14ad8", &function_ee311142);
  assert(isscriptfunctionptr(&function_6488bc7e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_28bbc81deeedc395", &function_6488bc7e);
  assert(isscriptfunctionptr(&function_ba605111));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_37194f1a33dd9fa9", &function_ba605111);
  assert(isscriptfunctionptr(&werewolfshouldreset));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfshouldreset", &werewolfshouldreset);
  assert(isscriptfunctionptr(&werewolfshouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfshouldshowpain", &werewolfshouldshowpain);
  assert(isscriptfunctionptr(&function_1ab1a5b3));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2485d20310e0248c", &function_1ab1a5b3);
  assert(isscriptfunctionptr(&werewolfshouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"werewolfshouldmelee", &werewolfshouldmelee);
  assert(isscriptfunctionptr(&function_9e901f61));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ac66a354287014b", &function_9e901f61);
  assert(isscriptfunctionptr(&function_da984f51));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_645ddbbfa8bea6f9", &function_da984f51);
  assert(isscriptfunctionptr(&function_7e2f67cf));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5e3e49240f58c3fb", &function_7e2f67cf);
  assert(isscriptfunctionptr(&function_390c9423));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45de1aecce571c1", &function_390c9423);
  assert(isscriptfunctionptr(&function_7a66357b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3bca879f16f06962", &function_7a66357b);
  assert(isscriptfunctionptr(&function_a5c42011));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_599e12fb160520d7", &function_a5c42011);
  animationstatenetwork::registernotetrackhandlerfunction("summon_wolves", &summonwolves);
  animationstatenetwork::registernotetrackhandlerfunction("werewolf_leap_melee", &werewolfleapattack);
  animationstatenetwork::registernotetrackhandlerfunction("werewolf_disable_pain", &werewolfdisablepain);
  animationstatenetwork::registernotetrackhandlerfunction("wrwlf_silver_death_fx", &function_b74b9f01);
  animationstatenetwork::registernotetrackhandlerfunction("werewolf_leap_rumble", &function_e980911c);
  animationstatenetwork::registernotetrackhandlerfunction("start_breakout", &function_dc05cd83);
  animationstatenetwork::registernotetrackhandlerfunction("end_breakout", &function_2d5048be);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_8ddb1128) || isscriptfunctionptr(&function_8ddb1128));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4f16c6f87860a582", undefined, &function_8ddb1128, undefined);
  animationstatenetwork::registeranimationmocomp("mocomp_werewolf_leap_attack", &function_7ad7aa7d, &function_8b63ee0e, &function_76968111);
}

function werewolfshouldstun(entity) {
  if(namespace_250e9486::shouldstun(entity) && function_833670b7(entity)) {
    return true;
  }

  return false;
}

function private function_833670b7(entity) {
  var_7a69f7e9 = blackboard::getblackboardevents("wrwlf_stun");

  if(isDefined(var_7a69f7e9) && var_7a69f7e9.size) {
    foreach(event in var_7a69f7e9) {
      if(event.werewolf === entity) {
        return false;
      }
    }
  }

  return true;
}

function werewolfstunstart(entity) {
  namespace_250e9486::stunstart(entity);
  var_268f1415 = spawnStruct();
  var_268f1415.werewolf = entity;
  blackboard::addblackboardevent("wrwlf_stun", var_268f1415, randomintrange(10000, 12000));
  entity.var_cc2d7568 = 1;
}

function private function_8ddb1128(entity, asmstatename) {
  if(asmstatename ai::is_stunned()) {
    return 5;
  }

  return 4;
}

function function_6bfc7a5f(entity) {
  namespace_250e9486::function_de68bf47(entity);
  entity.var_cc2d7568 = 0;
}

function werewolfidlestart(entity) {
  if(is_true(entity.var_cc2d7568)) {
    entity.var_cc2d7568 = 0;

    if(entity getpathmode() == "dont move") {
      entity pathmode("move allowed");
    }
  }
}

function private function_dc05cd83(entity) {
  self.var_2037a949 = 1;
}

function private function_2d5048be(entity) {
  self.var_2037a949 = 0;
}

function private function_ebf85268(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(point) && self === point) {
    dir = 0;
  }

  var_786d7e06 = namespace_250e9486::function_422fdfd4(self, point, hitloc, modelindex, boneindex, offsettime);
  final_damage = int(dir * var_786d7e06.damage_scale);
  var_934e9dce = isDefined(var_786d7e06.var_84ed9a13) && is_true(var_786d7e06.registerzombie_bgb_used_reinforce) && isDefined(point) && isPlayer(point);

  if(var_934e9dce) {
    self.var_265cb589 = 1;
    self.var_4bb78ac7 = gettime() + 1000;
    point playhitmarker(undefined, 5, undefined, 1, 0);

    if(var_786d7e06.var_84ed9a13.var_51e8b151 === "tag_chest_ws") {
      clientfield::increment("wrwlf_weakpoint_fx", 1);
    } else {
      clientfield::increment("wrwlf_weakpoint_fx", 2);
    }
  } else if(isDefined(self.var_4bb78ac7) && gettime() < self.var_4bb78ac7) {
    self.var_265cb589 = 1;
  } else {
    self.var_265cb589 = 0;
  }

  if(isDefined(self.var_c59e2dbf)) {
    self.var_c59e2dbf += final_damage;
  } else {
    self.var_c59e2dbf = final_damage;
  }

  if(!is_true(self.var_48baa747) && !is_true(self.var_e9ed8a62) && self.var_c59e2dbf > self.maxhealth * self ai::function_9139c839().var_96b9b674 / 100) {
    if(self.var_b7ba7211 < gettime() && hasasm(self) && self function_ebbebf56() >= 1) {
      self.var_1cfbbe3d = 1;
    }

    self.var_c59e2dbf = 0;
  }

  if(isDefined(point) && isPlayer(point)) {
    if(is_true(var_934e9dce) && is_true(self.var_48baa747) && is_true(self.var_2037a949) && hasasm(self) && self function_ebbebf56() >= 1) {
      self.var_1cfbbe3d = 1;
      self.blockingpain = 0;
    }

    if(gettime() >= self.ai.var_9465ce93) {
      self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
      self.var_125e7ef = 1;
      self clientfield::increment("wrwlf_silver_hit_fx");
    }
  }

  var_799e18e5 = offsettime;
  var_5f32808d = 1;

  if(dir >= 1000) {
    var_5f32808d = 2;
  }

  self namespace_ec06fe4a::function_2f4b0f9(self.health - final_damage, point, var_799e18e5, final_damage, var_5f32808d);
  return final_damage;
}

function function_7e2f67cf(entity) {
  currentstance = entity getblackboardattribute("_werewolf_stance");

  if(currentstance == "upright" && is_true(self.var_125e7ef)) {
    self.var_125e7ef = 0;
    return true;
  }

  self.var_125e7ef = 0;
  return false;
}

function private function_390c9423(entity) {
  currentstance = entity getblackboardattribute("_werewolf_stance");

  if(currentstance == "upright") {
    return true;
  }

  return false;
}

function private function_7a66357b(entity) {
  if(is_true(entity.var_1cfbbe3d)) {
    return true;
  }

  return false;
}

function private function_da984f51(entity) {
  if(is_true(entity.var_e0f90289)) {
    return true;
  }

  return false;
}

function private werewolfshouldreset(entity) {
  if(is_true(entity.var_1cfbbe3d)) {
    return true;
  }

  return false;
}

function private werewolfshouldshowpain(entity) {
  if(function_7a66357b(entity)) {
    return true;
  }

  if(!werewolfshouldmelee(entity) && btapi_locomotionbehaviorcondition(entity) && function_390c9423(entity)) {
    return true;
  }

  return false;
}

function private function_4014790a(entity) {
  entity.var_1cfbbe3d = undefined;
  entity.var_b7ba7211 = gettime() + int(entity ai::function_9139c839().var_bd87ef4d * 1000);
  entity.blockingpain = 1;
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_werewolf_vocal_pain");
  function_43f02cf0(entity);
}

function private function_1917d76d(entity) {
  entity.blockingpain = 0;
  entity pathmode("move allowed");
}

function private werewolfdisablepain(entity) {
  entity.var_e9ed8a62 = 1;
}

function function_b74b9f01(entity) {
  self clientfield::set("wrwlf_silver_death_fx", 1);
  self thread function_fc2777d9();
}

function private function_fc2777d9() {
  wait 3;

  if(isDefined(self)) {
    self delete();
  }
}

function function_2341cdf0(entity, attribute, oldvalue, value) {
  attribute.b_ignore_cleanup = value;

  if(value == 0 && oldvalue != value) {
    attribute notify(#"patrol_done");
  }
}

function stop_patrol(entity) {
  if(entity ai::has_behavior_attribute("patrol")) {
    entity ai::set_behavior_attribute("patrol", 0);
  }

  entity notify(#"stop_patrol");
}

function private function_4b392ea3(entity) {
  if(entity function_ebbebf56() != 1) {
    return false;
  }

  if(isDefined(entity.ai.var_d6cd1d4e)) {
    if(gettime() < entity.ai.var_d6cd1d4e) {
      return false;
    }
  }

  var_34529779 = blackboard::getblackboardevents("wrlf_stance_change");

  if(isDefined(var_34529779) && var_34529779.size) {
    foreach(var_462d3042 in var_34529779) {
      if(isDefined(var_462d3042.data.pos) && distancesquared(var_462d3042.data.pos, entity.origin) <= sqr(800)) {
        return false;
      }
    }
  }

  return true;
}

function private function_a5c42011(entity) {
  currentstance = entity getblackboardattribute("_werewolf_stance");
  desiredstance = currentstance;
  pathgoalpos = entity.pathgoalpos;

  if(function_4b392ea3(entity)) {
    if(isDefined(pathgoalpos)) {
      distsq = distancesquared(entity.origin, pathgoalpos);

      if(currentstance == "upright" && distsq > sqr(entity ai::function_9139c839().var_ed83d6e9)) {
        desiredstance = "quad";
        self allowpitchangle(1);
        self setpitchorient();
      } else if(currentstance == "quad" && distsq < sqr(entity ai::function_9139c839().var_e5f93adc)) {
        desiredstance = "upright";
        self allowpitchangle(0);
        self clearpitchorient();
      }
    } else {
      desiredstance = "upright";
    }

    entity.ai.var_d6cd1d4e = gettime() + int(entity ai::function_9139c839().var_6d4b0dd6 * 1000);
    entity setblackboardattribute("_werewolf_stance", desiredstance);
    var_462d3042 = spawnStruct();
    var_462d3042.pos = entity.origin;
    blackboard::addblackboardevent("wrlf_stance_change", var_462d3042, randomintrange(1000, 5000));
  }
}

function private function_6488bc7e(entity) {
  zombies = getaiteamarray("axis");
  zombies = arraysortclosest(zombies, entity.origin, undefined, 0, entity getpathfindingradius() + 20);
  var_31a419e0 = [];

  foreach(zombie in zombies) {
    if(is_true(zombie.basic)) {
      if(!isDefined(var_31a419e0)) {
        var_31a419e0 = [];
      } else if(!isarray(var_31a419e0)) {
        var_31a419e0 = array(var_31a419e0);
      }

      var_31a419e0[var_31a419e0.size] = zombie;
    }
  }

  foreach(zombie in var_31a419e0) {
    zombie namespace_250e9486::setup_zombie_knockdown(entity);
  }

  return true;
}

function private function_ee311142(entity) {
  return true;
}

function private function_ba605111(entity) {
  return true;
}

function private function_f5d7dc0a(entity) {
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("vlf_melee_event", var_3bfe8ebe, randomintrange(6000, 8500));
  return true;
}

function private function_e84f3864(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_33f55f67 = blackboard::getblackboardevents("vlf_melee_event");

  if(isDefined(var_33f55f67) && var_33f55f67.size) {
    foreach(var_3bfe8ebe in var_33f55f67) {
      if(var_3bfe8ebe.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

function private werewolfshouldmelee(entity) {
  if(!function_2801a911(entity)) {
    return false;
  }

  if(btapi_shouldnormalmelee(entity) || function_9e901f61(entity)) {
    return true;
  }

  return false;
}

function private function_2801a911(entity) {
  if(entity.ignoreall) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(abs(entity.enemy.origin[2] - entity.origin[2]) > 64) {
    return false;
  }

  return true;
}

function private function_6cde7a8b(entity, predictedenemypos) {
  enemypos = entity.enemy.origin;

  if(isDefined(predictedenemypos)) {
    enemypos = predictedenemypos;
  }

  dirtoenemy = vectornormalize(enemypos - entity.origin);
  dirtoenemy = vectornormalize(dirtoenemy);
  return enemypos + dirtoenemy * -1 * 45;
}

function private function_93211521(entity, var_856465ed) {
  vectoenemy = var_856465ed - entity.origin;
  var_c43ad98d = entity.origin + vectorscale(vectoenemy, 0.5);
  results = physicstraceex(var_c43ad98d, var_c43ad98d + (0, 0, 120), (-15, -15, -5), (15, 15, 5), self);

  if(results[# "fraction"] == 1) {
    return true;
  }

  return false;
}

function private function_9e901f61(entity) {
  if(entity function_ebbebf56() != 1) {
    return false;
  }

  if(entity.ignoreall) {
    return false;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!function_e84f3864(entity)) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    var_856465ed = function_6cde7a8b(entity);
    distancesq = distancesquared(entity.origin, var_856465ed);

    if(!ispointonnavmesh(entity.enemy.origin, entity.enemy)) {
      return false;
    }

    if(!ispointonnavmesh(entity.enemy.origin, entity)) {
      return false;
    }

    if(!ispointonnavmesh(var_856465ed, 60)) {
      return false;
    }

    if(!ispointonnavmesh(var_856465ed, entity.enemy)) {
      return false;
    }

    if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
      return false;
    }

    if(abs(entity.origin[2] - var_856465ed[2]) > 64) {
      return false;
    }

    if(distancesq < sqr(entity ai::function_9139c839().var_2a25aee8)) {
      return false;
    }

    if(distancesq > sqr(entity ai::function_9139c839().chargemeleedist)) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, var_856465ed, entity getpathfindingradius())) {
      return false;
    }

    if(!util::within_fov(self.origin, self.angles, var_856465ed, cos(40))) {
      return false;
    }

    if(!function_93211521(entity, var_856465ed)) {
      return false;
    }

    return true;
  }

  return false;
}

function private werewolfleapattack(entity) {
  if(entity.ignoreall) {
    return;
  }

  if(!isDefined(entity.enemy)) {
    return;
  }

  if(entity.enemy.ignoreme) {
    return;
  }

  radiusdamage(entity.origin, 48, 15, 5, entity, "MOD_MELEE");
  zombies = getaiarchetypearray(#"zombie", "axis");
  zombies = arraysortclosest(zombies, self.origin + anglesToForward(self.angles) * 65 * 0.5, undefined, undefined, self getpathfindingradius() + 65);

  foreach(zombie in zombies) {
    zombie namespace_250e9486::setup_zombie_knockdown(self);
    zombie.knockdown_type = "knockdown_stun";
  }

  entity melee(anglesToForward(entity.angles));
}

function private function_e980911c(entity) {
  entity clientfield::increment("wrwlf_leap_attack_rumble");
}

function private function_f2e3495a(entity) {
  entity.var_e9ed8a62 = undefined;
}

function private function_7ad7aa7d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompanimflag animmode("gravity", 1);
  mocompanimflag orientmode("face angle", mocompanimflag.angles[1]);
  mocompanimflag.blockingpain = 1;
  mocompanimflag.takedamage = 0;
  mocompanimflag.usegoalanimweight = 1;
  mocompanimflag pathmode("dont move");
  mocompanimflag collidewithactors(0);
  mocompanimflag.var_b736fc8b = 1;

  if(isDefined(mocompanimflag.enemy)) {
    dirtoenemy = vectornormalize(mocompanimflag.enemy.origin - mocompanimflag.origin);
    mocompanimflag forceteleport(mocompanimflag.origin, vectortoangles(dirtoenemy));
  }

  if(!isDefined(self.meleeinfo)) {
    self.meleeinfo = new class_9f07f58e();
    self.meleeinfo.var_9bfa8497 = mocompanimflag.origin;
    self.meleeinfo.var_98bc84b7 = getnotetracktimes(mocompduration, "start_procedural")[0];
    self.meleeinfo.var_6392c3a2 = getnotetracktimes(mocompduration, "stop_procedural")[0];
    var_e397f54c = getmovedelta(mocompduration, 0, 1);
    self.meleeinfo.var_cb28f380 = mocompanimflag localtoworldcoords(var_e397f54c);
  }
}

function function_8b63ee0e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(mocompanimflag.health <= 0) {
    return;
  }

  assert(isDefined(mocompanimflag.meleeinfo));
  currentanimtime = mocompanimflag getanimtime(mocompduration);
  zombies = getaiarchetypearray(#"zombie", "axis");
  zombies = arraysortclosest(zombies, mocompanimflag.origin, undefined, 0, mocompanimflag getpathfindingradius() + 15);
  var_7bfb4133 = 0;

  foreach(zombie in zombies) {
    if(is_true(zombie.knockdown)) {
      continue;
    }

    zombie namespace_250e9486::setup_zombie_knockdown(mocompanimflag);
    var_7bfb4133++;

    if(var_7bfb4133 >= 5) {
      break;
    }
  }

  if(isDefined(mocompanimflag.enemy) && !mocompanimflag.meleeinfo.adjustmentstarted && mocompanimflag.meleeinfo.var_425c4c8b && currentanimtime >= mocompanimflag.meleeinfo.var_98bc84b7) {
    predictedenemypos = mocompanimflag.enemy.origin;
    var_856465ed = function_6cde7a8b(mocompanimflag, predictedenemypos);
    mocompanimflag.meleeinfo.adjustedendpos = var_856465ed;
    var_cc075bd0 = vectornormalize(mocompanimflag.origin - mocompanimflag.meleeinfo.adjustedendpos);
    var_cf699df5 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.var_cb28f380);
    var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
    var_65cbfb52 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos);
    var_201660e6 = tracepassedonnavmesh(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos, mocompanimflag getpathfindingradius());
    traceresult = bulletTrace(mocompanimflag.origin, mocompanimflag.meleeinfo.adjustedendpos + (0, 0, 30), 0, mocompanimflag);
    isvisible = traceresult[# "fraction"] == 1;
    var_535d098c = 0;

    if(isDefined(traceresult[# "hitloc"]) && traceresult[# "hitloc"] == "riotshield") {
      mocompanimflag.meleeinfo.adjustedendpos += vectorscale(var_cc075bd0, 50);
      var_535d098c = 1;
    }

    if(!var_201660e6) {
      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    } else if(var_cf699df5 > var_65cbfb52 && var_776ddabf >= sqr(mocompanimflag ai::function_9139c839().var_d781a7cc)) {
      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    } else if(var_776ddabf >= sqr(mocompanimflag ai::function_9139c839().var_e49498dc)) {
      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    }

    if(var_535d098c) {
      mocompanimflag.meleeinfo.var_425c4c8b = 1;
    }

    if(mocompanimflag.meleeinfo.var_425c4c8b) {
      var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
      myforward = anglesToForward(mocompanimflag.angles);
      var_1c3641f2 = (var_856465ed[0], var_856465ed[1], mocompanimflag.origin[2]);
      dirtoenemy = vectornormalize(var_1c3641f2 - mocompanimflag.origin);
      zdiff = mocompanimflag.meleeinfo.var_cb28f380[2] - var_856465ed[2];
      withinzrange = abs(zdiff) <= mocompanimflag ai::function_9139c839().var_3c41cb92;
      withinfov = vectordot(myforward, dirtoenemy) > mocompanimflag ai::function_9139c839().var_e2b09972;
      var_7948b2f3 = withinzrange && withinfov;
      var_425c4c8b = (isvisible || var_535d098c) && var_7948b2f3;

      if(var_425c4c8b) {
        var_90c3cdd2 = length(mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380);
        timestep = function_60d95f53();
        animlength = getanimlength(mocompduration) * 1000;
        starttime = mocompanimflag.meleeinfo.var_98bc84b7 * animlength;
        stoptime = mocompanimflag.meleeinfo.var_6392c3a2 * animlength;
        starttime = floor(starttime / timestep);
        stoptime = floor(stoptime / timestep);
        adjustduration = stoptime - starttime;
        mocompanimflag.meleeinfo.var_10b8b6d1 = vectornormalize(mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380);
        mocompanimflag.meleeinfo.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
        mocompanimflag.meleeinfo.var_425c4c8b = 1;
        mocompanimflag.meleeinfo.adjustmentstarted = 1;
      } else {
        mocompanimflag.meleeinfo.var_425c4c8b = 0;
      }
    }
  }

  if(mocompanimflag.meleeinfo.adjustmentstarted) {
    if(currentanimtime <= mocompanimflag.meleeinfo.var_6392c3a2) {
      assert(isDefined(mocompanimflag.meleeinfo.var_10b8b6d1) && isDefined(mocompanimflag.meleeinfo.var_8b9a15a6));
      adjustedorigin = mocompanimflag.origin + mocompanimflag.meleeinfo.var_10b8b6d1 * mocompanimflag.meleeinfo.var_8b9a15a6;
      mocompanimflag forceteleport(adjustedorigin);
      return;
    }

    if(isDefined(mocompanimflag.enemy)) {
      mocompanimflag orientmode("face enemy");
    }
  }
}

function function_76968111(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.takedamage = 1;
  mocompduration.blockingpain = 0;
  mocompduration.usegoalanimweight = 0;
  mocompduration clearpath();
  mocompduration orientmode("face enemy");
  mocompduration pathmode("move delayed", 1, 0.2);
  mocompduration collidewithactors(1);
  mocompduration.meleeinfo = undefined;
  mocompduration.var_b736fc8b = 0;
}

function function_e1743aa(entity) {
  right = anglestoright(entity.angles) * 50;
  point = getclosestpointonnavmesh(entity.origin + right, 80);

  if(isDefined(point)) {
    doa_enemy::function_a6b807ea(entity.var_c6213c58, 1, point, 0, undefined, entity.enemy);
    point = getclosestpointonnavmesh(entity.origin - right, 80);
    doa_enemy::function_a6b807ea(entity.var_c6213c58, 1, point, 0, undefined, entity.enemy);
  }

  if(getplayers().size > 1) {
    if(isDefined(point)) {
      doa_enemy::function_a6b807ea(entity.var_c6213c58, 1, point, 0, undefined, entity.enemy);
      point = getclosestpointonnavmesh(entity.origin - right, 80);
      doa_enemy::function_a6b807ea(entity.var_c6213c58, 1, point, 0, undefined, entity.enemy);
    }
  }
}

function function_2c67c3e1(entity, attribute, oldvalue, value) {
  oldvalue.summon_wolves = value;
}

function private function_43f02cf0(entity) {
  if(is_true(entity.summon_wolves)) {
    return 0;
  }

  if(entity function_ebbebf56() != 1) {
    return 0;
  }

  if(entity.health / entity.maxhealth > entity ai::function_9139c839().var_8c0e8cfb / 100) {
    return 0;
  }

  if(entity.var_1a60ad62 > gettime()) {
    return 0;
  }

  if(randomintrangeinclusive(0, 100) < entity ai::function_9139c839().var_d9838997) {
    entity.summon_wolves = 1;
  }
}

function private function_1ab1a5b3(entity) {
  return is_true(entity.summon_wolves);
}

function private function_f8912291(entity) {
  entity.var_48baa747 = 1;
  entity.summon_wolves = undefined;
  entity.var_1a60ad62 = gettime() + entity ai::function_9139c839().var_fe050356;
  entity.blockingpain = 1;
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_werewolf_vocal_summon");
}

function private function_fcc1c537(entity) {
  entity.var_48baa747 = 0;
  entity.ai.var_d6cd1d4e = gettime() + int(entity ai::function_9139c839().var_6d4b0dd6 * 1000);
  entity.var_1a60ad62 = gettime() + entity ai::function_9139c839().var_fe050356;
  entity.blockingpain = 0;
}

function private summonwolves(entity) {
  self.health = int(min(self.health + self.var_c59b482e, self.maxhealth));
  self.var_c59b482e = int(math::clamp(self.var_c59b482e * 0.9, 25000, self.maxhealth));
  self thread namespace_ec06fe4a::function_2f4b0f9(self.health);
  function_e1743aa(entity);
}