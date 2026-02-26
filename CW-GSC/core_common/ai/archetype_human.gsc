/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human.gsc
***********************************************/

#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_human_interface;
#using scripts\core_common\ai\archetype_human_locomotion;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#namespace archetypehuman;

function autoexec init() {
  spawner::add_archetype_spawn_function(#"human", &archetypehumanblackboardinit);
  spawner::add_archetype_spawn_function(#"human", &archetypehumaninit);
  humaninterface::registerhumaninterfaceattributes();
  registerbehaviorscriptfunctions();
  clientfield::register("actor", "facial_dial", 1, 1, "int");
  clientfield::register("actor", "lipflap_anim", 1, 2, "int");
  function_c8cb67cb(#"human", "shuffle", 56);
  function_c8cb67cb(#"human", "walk", 56);
  function_c8cb67cb(#"human", "fast", 120);
  function_c8cb67cb(#"human", "jog", 145);
  function_c8cb67cb(#"human", "run", 170);
  function_c8cb67cb(#"human", "sprint", 220);

  level.__ai_forcegibs = getdvarint(#"ai_forcegibs", 0);

  util::init_dvar("enableHipFlip", 1, &function_1ed72d78);
  thread function_b98fe2d6();

  if(!isDefined(level.var_1516eaca)) {
    level.var_1516eaca = &function_f27f3a91;
  }
}

function private function_b98fe2d6() {
  if(!isDefined(level.flag) || !is_true(level.flag[#"load_main_complete"])) {
    level waittill(#"load_main_complete");
  }

  triggers = getEntArray("trigger_multiple_slope", "variantname");

  foreach(trig in triggers) {
    trig thread function_2f2d0057();
  }
}

function private function_2f2d0057() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    other = waitresult.activator;

    if(!is_true(other.var_a8f2b553)) {
      other.var_a8f2b553 = 1;
      other thread function_168bc21c(self);
    }
  }
}

function private function_168bc21c(trigger) {
  self endon(#"death");

  while(isDefined(trigger) && self istouching(trigger)) {
    waitframe(1);
  }

  self.var_a8f2b553 = undefined;
}

function function_1ed72d78(params) {
  level.enablehipflip = int(params.value);
}

function private archetypehumaninit() {
  entity = self;
  aiutility::addaioverridedamagecallback(entity, &damageoverride);
  aiutility::addaioverridekilledcallback(entity, &humangibkilledoverride);
  locomotiontypes = array("alt1", "alt2", "alt3");
  var_1818b7d9 = array::random(locomotiontypes);
  entity setblackboardattribute("_human_locomotion_variation", var_1818b7d9);
  entity trackblackboardattribute("_traversal_type");
  entity finalizetrackedblackboardattributes();

  if(isDefined(entity.script_demeanor)) {
    entity ai::set_behavior_attribute("demeanor", tolower(self.script_demeanor));
  }
}

function private archetypehumanblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypehumanonanimscriptedcallback;
  self.___archetypeonbehavecallback = &archetypehumanonbehavecallback;

  if(self.accuratefire && self.var_ee448041) {
    self thread aiutility::function_7bbe1407(self);
    self thread aiutility::function_efed8903(self);
  }

  destructserverutils::togglespawngibs(self, 1);
  gibserverutils::togglespawngibs(self, 1);
}

function private archetypehumanonbehavecallback(entity) {
  if(btapi_isatcovercondition(entity)) {
    entity setblackboardattribute("_previous_cover_mode", "cover_alert");
    entity setblackboardattribute("_cover_mode", "cover_mode_none");
  }

  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrower = entity;
  blackboard::addblackboardevent("self_grenade_throw", grenadethrowinfo, randomintrange(3000, 4000));
}

function private archetypehumanonanimscriptedcallback(entity) {
  vignettemode = ai::getaiattribute(entity, "vignette_mode");
  humansoldierserverutils::vignettemodecallback(entity, "vignette_mode", vignettemode, vignettemode);
}

function private humangibkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, var_fd90b0bb, dir, hitloc, offsettime) {
  entity = self;

  if(math::cointoss()) {
    return weapon;
  }

  attackerdistance = 0;

  if(isDefined(meansofdeath)) {
    attackerdistance = distancesquared(meansofdeath.origin, entity.origin);
  }

  isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), var_fd90b0bb);
  forcegibbing = 0;

  if(isDefined(dir.weapclass) && dir.weapclass == "turret") {
    forcegibbing = 1;

    if(isDefined(damage)) {
      isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), var_fd90b0bb);
      iscloseexplosive = distancesquared(damage.origin, entity.origin) <= sqr(60);

      if(isdirectexplosive && iscloseexplosive) {
        gibserverutils::annihilate(entity);
      }
    }
  }

  if(forcegibbing || isexplosive || isDefined(level.__ai_forcegibs) && level.__ai_forcegibs || dir.dogibbing && attackerdistance <= sqr(dir.maxgibdistance)) {
    gibserverutils::togglespawngibs(entity, 1);
    destructserverutils::togglespawngibs(entity, 1);
    trygibbinglimb(entity, weapon, dir, hitloc, offsettime, isexplosive || forcegibbing);
    trygibbinglegs(entity, weapon, dir, hitloc, offsettime, isexplosive);
  }

  return weapon;
}

function private trygibbinghead(entity, damage, weapon, var_fd90b0bb, hitloc, isexplosive) {
  var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

  if(isexplosive) {
    gibserverutils::gibhead(damage, var_c3317960);
    return;
  }

  if(isinarray(array("head", "neck", "helmet"), hitloc)) {
    gibserverutils::gibhead(damage, var_c3317960);
  }
}

function private trygibbinglimb(entity, damage, weapon, var_fd90b0bb, hitloc, isexplosive) {
  var_c3317960 = gibserverutils::function_de4d9d(weapon, var_fd90b0bb);

  if(isexplosive) {
    randomchance = randomfloatrange(0, 1);

    if(randomchance < 0.5) {
      gibserverutils::gibrightarm(damage, var_c3317960);
    } else {
      gibserverutils::gibleftarm(damage, var_c3317960);
    }

    return;
  }

  if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
    gibserverutils::gibleftarm(damage, var_c3317960);
    return;
  }

  if(isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
    gibserverutils::gibrightarm(damage, var_c3317960);
    return;
  }

  if(isinarray(array("torso_upper"), hitloc) && math::cointoss()) {
    if(math::cointoss()) {
      gibserverutils::gibleftarm(damage, var_c3317960);
      return;
    }

    gibserverutils::gibrightarm(damage, var_c3317960);
  }
}

function private trygibbinglegs(entity, damage, weapon, var_fd90b0bb, hitloc, isexplosive, attacker) {
  var_c3317960 = gibserverutils::function_de4d9d(var_fd90b0bb, hitloc);

  if(attacker) {
    randomchance = randomfloatrange(0, 1);

    if(randomchance < 0.33) {
      gibserverutils::gibrightleg(weapon, var_c3317960);
    } else if(randomchance < 0.66) {
      gibserverutils::gibleftleg(weapon, var_c3317960);
    } else {
      gibserverutils::giblegs(weapon, var_c3317960);
    }

    return;
  }

  if(isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), isexplosive)) {
    gibserverutils::gibleftleg(weapon, var_c3317960);
    return;
  }

  if(isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), isexplosive)) {
    gibserverutils::gibrightleg(weapon, var_c3317960);
    return;
  }

  if(isinarray(array("torso_lower"), isexplosive) && math::cointoss()) {
    if(math::cointoss()) {
      gibserverutils::gibleftleg(weapon, var_c3317960);
      return;
    }

    gibserverutils::gibrightleg(weapon, var_c3317960);
  }
}

function damageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  entity = self;
  entity destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);

  if(is_true(entity.var_d3fb5ec5)) {
    return idamage;
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && (smeansofdeath === "MOD_RIFLE_BULLET" || smeansofdeath === "MOD_PISTOL_BULLET" || smeansofdeath === "MOD_HEAD_SHOT") && isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet" || shitloc == "neck")) {
    level.var_d7e2833c = 1;
    idamage *= 5;
  }

  self.var_ec422675 = undefined;

  if(isDefined(eattacker) && !isPlayer(eattacker) && !isvehicle(eattacker)) {
    dist = distancesquared(entity.origin, eattacker.origin);

    if(dist < 65536) {
      ratio = idamage / 100;

      if(ratio <= 0.7) {
        self.var_ec422675 = "light";
      }

      level.var_d7e2833c = 1;
      idamage = int(idamage * 10);
    }
  }

  if(weapon.name == "incendiary_grenade") {
    idamage = entity.health;
  }

  if(weapon.name == # "hash_165cf52ce418f5a1") {
    self.var_ec422675 = "light";
  }

  return idamage;
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_51f81dca));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_711d337e62079ce5", &function_51f81dca);
  assert(isscriptfunctionptr(&function_30579259));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_44855828fd88ae3f", &function_30579259);
  assert(isscriptfunctionptr(&function_f7392d4f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42cba931f258b705", &function_f7392d4f);
  assert(isscriptfunctionptr(&function_15543ed6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_61218309eb6a4cf5", &function_15543ed6);
  assert(isscriptfunctionptr(&function_51074ea9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_439ccb7b4d3533b9", &function_51074ea9);
  assert(isscriptfunctionptr(&function_51074ea9));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_439ccb7b4d3533b9", &function_51074ea9);
  assert(isscriptfunctionptr(&function_f59fad45));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f9c3e0cbd2e33ee", &function_f59fad45);
  assert(isscriptfunctionptr(&function_f59fad45));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4f9c3e0cbd2e33ee", &function_f59fad45);
  assert(isscriptfunctionptr(&function_a6e2c113));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77587e005bf8ed0c", &function_a6e2c113);
  assert(isscriptfunctionptr(&function_a6e2c113));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_77587e005bf8ed0c", &function_a6e2c113);
  assert(isscriptfunctionptr(&function_235ee25b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a5b8d95d2cea3e5", &function_235ee25b);
  assert(isscriptfunctionptr(&function_dfe73cad));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6549250bc3f3abf1", &function_dfe73cad);
  assert(isscriptfunctionptr(&function_dfe73cad));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6549250bc3f3abf1", &function_dfe73cad);
  assert(isscriptfunctionptr(&function_13cd8bfe));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c4b738cd34cfb6f", &function_13cd8bfe);
  assert(isscriptfunctionptr(&function_13cd8bfe));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5c4b738cd34cfb6f", &function_13cd8bfe);
  assert(isscriptfunctionptr(&function_964f867d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5f6787edb60603cb", &function_964f867d);
  assert(isscriptfunctionptr(&function_964f867d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5f6787edb60603cb", &function_964f867d);
  assert(isscriptfunctionptr(&function_ecaeb285));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ade614f1d457dd3", &function_ecaeb285);
  assert(isscriptfunctionptr(&function_ecaeb285));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3ade614f1d457dd3", &function_ecaeb285);
  assert(isscriptfunctionptr(&function_bbd29e0c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58f473f468ec50e8", &function_bbd29e0c);
  assert(isscriptfunctionptr(&function_bbd29e0c));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_58f473f468ec50e8", &function_bbd29e0c);
  assert(isscriptfunctionptr(&function_3e09cbf3));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_551ab6c678be0ac", &function_3e09cbf3);
  assert(isscriptfunctionptr(&function_d5f8b410));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_118cb9e3912f8b36", &function_d5f8b410);
  assert(isscriptfunctionptr(&function_4e71bfb4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6cc5acfe12a25320", &function_4e71bfb4);
  assert(isscriptfunctionptr(&function_2c95bf72));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6168b88229c55261", &function_2c95bf72);
  assert(isscriptfunctionptr(&function_7d7cd25d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_55fa05bf88eac67", &function_7d7cd25d);
}

function private function_51f81dca(entity) {
  if(entity getblackboardattribute("_human_demeanor") === "COMBAT") {
    return true;
  }

  if(entity getblackboardattribute("_human_demeanor") === "CQB") {
    return true;
  }

  return false;
}

function function_30579259(entity) {
  if(entity getblackboardattribute("_human_demeanor") === "PATROL") {
    return true;
  }

  return false;
}

function private function_f7392d4f(entity) {
  if(entity getblackboardattribute("_human_demeanor") === "CQB") {
    return true;
  }

  return false;
}

function private function_15543ed6(entity) {
  if(entity getblackboardattribute("_human_demeanor") === "ALERT") {
    return true;
  }

  return false;
}

function private function_f59fad45(entity) {
  if(entity haspath()) {
    if(is_true(entity.isarriving)) {
      return 1;
    } else {
      run_n_gun = !function_51074ea9(entity);
      return run_n_gun;
    }
  }

  return 0;
}

function private function_51074ea9(entity) {
  if(entity haspath()) {
    if(!entity.disablesprint && entity.forcesprint) {
      return false;
    }

    if(isDefined(entity.var_e7ea517e) && !entity.var_e7ea517e) {
      return false;
    }

    if(is_true(entity.var_73e3e2aa) || isDefined(entity.ai.var_4183a6fc.startpos) && distance2dsquared(entity.origin, entity.ai.var_4183a6fc.startpos) < sqr(120)) {
      return false;
    }

    if(function_f7392d4f(entity)) {
      return true;
    }

    var_9b6862f8 = function_4816f390(self);

    if(var_9b6862f8 == "arrival" || var_9b6862f8 == "goal") {
      var_7320b70a = self function_72ce1270();

      if(var_7320b70a == "run_n_gun" || var_7320b70a == "non_combat_run") {
        return false;
      }

      if(var_7320b70a == "cqb") {
        return true;
      }
    }

    if(btapi_shouldtacticalwalk(entity)) {
      return true;
    }
  }

  return false;
}

function private function_235ee25b(entity) {
  entity.ai.replannedcoverarrival = 0;
  result = function_a6e2c113(entity);
  entity.ai.var_c978f9a1 = 1;
  return result;
}

function private function_a6e2c113(entity) {
  aiutility::resetcoverparameters(entity);
  aiutility::setcanbeflanked(entity, 0);
  entity.ai.exitstance = entity getblackboardattribute("_stance");
  entity setblackboardattribute("_stance", "stand");
  entity ai::function_fc7bd6c7();
  entity function_ee4915e0();
  entity function_ed7c3705("cqb");
  entity.ai.var_798e85cd = entity function_144f21ef();
  entity.ai.var_7979fbb2 = entity.ai.var_798e85cd;
  entity.ai.var_f92c6536 = gettime();
  entity.ai.var_c978f9a1 = 0;

  if(isfunctionptr(self.var_d28ad254)) {
    return self[[self.var_d28ad254]](entity);
  }

  return 1;
}

function private function_dfe73cad(entity) {
  if(function_51074ea9(entity)) {
    if(!aiutility::function_c94f0d1(entity) && entity.isarrivalpending) {
      entity.ai.replannedcoverarrival = 0;
      entity function_d4c687c9();
    }

    entity.ai.var_798e85cd = entity.ai.var_7979fbb2;
    entity.ai.var_7979fbb2 = entity function_144f21ef();

    if(isfunctionptr(self.var_40dd40ac)) {
      return self[[self.var_40dd40ac]](entity);
    }

    return 1;
  }

  return 0;
}

function private function_13cd8bfe(entity) {
  entity.ai.var_c978f9a1 = undefined;
  entity.ai.exitstance = undefined;
  entity function_ed7c3705("none");
  entity ai::function_f6060793();
  entity function_fbc6c789();

  if(isfunctionptr(self.var_ee308dc1)) {
    return self[[self.var_ee308dc1]](entity);
  }

  return 1;
}

function private function_964f867d(entity) {
  entity function_ed7c3705("cqb");
  return true;
}

function private function_ecaeb285(entity) {
  entity function_ed7c3705("cqb");
  return true;
}

function private function_bbd29e0c(entity) {
  entity function_ed7c3705("none");
  return true;
}

function function_3e09cbf3(entity) {
  var_9ef80b55 = entity aiutility::function_9144ba8();

  if(var_9ef80b55 == "heavy") {
    var_7d558504 = entity hasvalidinterrupt("pain");

    if(!var_7d558504) {
      record3dtext("<dev string:x38>", entity.origin, (1, 0, 0), "<dev string:x4d>", entity);
    } else {
      record3dtext("<dev string:x5b>", entity.origin, (1, 0.5, 0), "<dev string:x4d>", entity);
    }

    return var_7d558504;
  }

  return 0;
}

function function_88dcd11f() {
  self notify(#"hash_797e6bb8a86ac7b2");
  self notify(#"hash_484aea430942b919");
  self endon(#"hash_797e6bb8a86ac7b2", #"death");
  self.var_ca796dd1 = 0;
  self.var_6a36b46d = self.var_ca796dd1;
  self.var_dd1cd771 = undefined;

  while(true) {
    self waittill(#"path_set");
    var_d3d7b85f = self.lookaheaddir;

    if(!isDefined(var_d3d7b85f) || lengthsquared(var_d3d7b85f) == 0) {
      continue;
    }

    if(!isDefined(self.enemy)) {
      continue;
    }

    pathpoints = self function_f14f56a8();

    if(isDefined(pathpoints) && pathpoints.size > 1) {
      nextpoint = pathpoints[1];
      dir = nextpoint - self.origin;
      dir = vectornormalize(dir);
      dot = vectordot(var_d3d7b85f, dir);
      var_ca796dd1 = dot < 0.5;
      self.var_ca796dd1 = var_ca796dd1;
      self.var_6a36b46d = var_ca796dd1;

      if(var_ca796dd1) {
        self animmode("zonly_physics");
        self thread function_aa0b0ac5();
      }
    }
  }
}

function private function_aa0b0ac5() {
  self notify(#"hash_484aea430942b919");
  self endon(#"hash_484aea430942b919", #"death");
  self.var_31162969 = angleclamp180(self.var_55a3f1d3 + 180);
  self.var_dd1cd771 = 1;
  self waittilltimeout(1, #"corner");
  self.var_dd1cd771 = undefined;
}

function function_9b60b3a4() {
  self.var_ca796dd1 = 0;
  self notify(#"hash_797e6bb8a86ac7b2");
}

function private function_ee4915e0() {
  if(isfunctionptr(self.var_c017b6d)) {
    self thread[[self.var_c017b6d]]();
    return;
  }

  self thread function_88dcd11f();
}

function private function_fbc6c789() {
  if(isfunctionptr(self.var_3f246c60)) {
    self thread[[self.var_3f246c60]]();
    return;
  }

  self function_9b60b3a4();
}

function private function_d5f8b410(entity) {
  if(entity haspath()) {
    speedsqr = length2dsquared(entity getvelocity());

    if(speedsqr >= sqr(80)) {
      return true;
    }
  }

  return false;
}

function private function_7d7cd25d(entity) {
  if(!isDefined(entity.var_b01e0de4)) {
    entity.var_b01e0de4 = randomintrange(0, 5) / 8;
    entity asmsetanimationrate(0.1);
    entity thread function_405a8025();
  }
}

function private function_405a8025() {
  self endon(#"death", #"hash_8ec72b512d886d2");
  wait self.var_b01e0de4;
  self asmsetanimationrate(1);
}

function private function_2c95bf72(entity) {
  entity notify(#"hash_8ec72b512d886d2");
  entity.var_b01e0de4 = undefined;
  entity asmsetanimationrate(1);
  aiutility::releaseclaimnode(entity);
}

function private function_4e71bfb4(entity) {
  if(!isDefined(entity.var_8061b3cd)) {
    var_7894038a = randomintrange(0, 9) * 250;
    var_7894038a += 4000;
    entity.var_8061b3cd = gettime() + var_7894038a;
  } else if(gettime() >= entity.var_8061b3cd) {
    entity.var_8061b3cd = undefined;
    return false;
  }

  return true;
}

function function_f27f3a91() {
  if(self.damageweapon.name == # "hash_165cf52ce418f5a1") {
    return "bow";
  }

  return undefined;
}