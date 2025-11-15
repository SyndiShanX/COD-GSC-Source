/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_nosferatu.gsc
**************************************************/

#include script_1f0e83e43bf9c3b9;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace archetypenosferatu;

class class_1546f28e {
  var adjustmentstarted;
  var var_425c4c8b;

  constructor() {
    adjustmentstarted = 0;
    var_425c4c8b = 1;
  }

}

autoexec init() {
  namespace_b3c8cf82::function_da6eecb2();
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"nosferatu", &function_5b800648);
  clientfield::register("actor", "nfrtu_leap_melee_rumb", 8000, 1, "counter");
}

private function_dbd0360f() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &function_f8ab724f;
  self.___archetypeonbehavecallback = &function_b1df7220;
}

private function_b1df7220(entity) {}

private function_f8ab724f(entity) {
  self.__blackboard = undefined;
  self function_dbd0360f();
}

private function_5b800648() {
  assert(isDefined(self.ai));
  function_dbd0360f();
  self.ignorepathenemyfightdist = 1;
  self.var_ceed8829 = 1;
  self.zigzag_activation_distance = 400;
  self.var_7d39ec6a = 1;
  self setavoidancemask("avoid actor");
  self callback::function_d8abfc3d(#"on_ai_melee", &function_2e5f2af4);
}

private function_2e5f2af4() {
  if(isDefined(self.meleeinfo)) {
    radiusdamage(self.origin, 150, 15, 5, self, "MOD_MELEE");
  }
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&nosferatushouldmelee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"nosferatushouldmelee", &nosferatushouldmelee);
  assert(isscriptfunctionptr(&function_7ffbbff));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_986eb7e87a024a", &function_7ffbbff);
  assert(isscriptfunctionptr(&function_85d8b15d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_12fd6029cfc2a603", &function_85d8b15d);
  assert(isscriptfunctionptr(&function_4df0b87d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_571c2407eee0f7ce", &function_4df0b87d);
  assert(isscriptfunctionptr(&function_ed80a3bc));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_326882aa02157f0d", &function_ed80a3bc);
  assert(isscriptfunctionptr(&function_15d413b9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c559b769f33559e", &function_15d413b9);
  assert(isscriptfunctionptr(&function_e9819a23));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7c46d4f8f6bd8a19", &function_e9819a23);
  assert(isscriptfunctionptr(&function_b5047448));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d557a256994b864", &function_b5047448);
  assert(isscriptfunctionptr(&function_15d413b9));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4c559b769f33559e", &function_15d413b9);
  assert(isscriptfunctionptr(&function_a41a5aea));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2392a1b5bcda2a4d", &function_a41a5aea);
  assert(isscriptfunctionptr(&function_b5305a8f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_55bb0ab8a037fcca", &function_b5305a8f);
  assert(isscriptfunctionptr(&function_ebe0e1b5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38a10af328e33bf7", &function_ebe0e1b5);
  assert(isscriptfunctionptr(&function_76505306));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ba3133a0e93c9f1", &function_76505306);
  assert(isscriptfunctionptr(&function_e0ad0db2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77c524bf92130b36", &function_e0ad0db2);
  assert(isscriptfunctionptr(&function_b75dd595));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_544b52e495ac560e", &function_b75dd595);
  assert(isscriptfunctionptr(&function_8b2173e0));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4d02bd1f2f959be9", &function_8b2173e0);
  assert(isscriptfunctionptr(&function_b758de87));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_ee12d5fffc3b8bb", &function_b758de87);
  animationstatenetwork::registeranimationmocomp("mocomp_nfrtu_leap_attack", &function_1ad502a0, &function_3511ecd1, &function_b472ba3d);
  animationstatenetwork::registeranimationmocomp("mocomp_nfrtu_latch_attack", &function_1ad502a0, &function_3511ecd1, &function_b472ba3d);
  animationstatenetwork::registeranimationmocomp("mocomp_nfrtu_run_attack", &function_37d5cfc, undefined, &function_4b55eb0a);
  animationstatenetwork::registernotetrackhandlerfunction("nosferatu_leap_attack_rumble", &nfrtuleaprumble);
  animationstatenetwork::registernotetrackhandlerfunction("nosferatu_bite", &function_2e8014e);
}

function_2e8014e(entity) {
  if(isDefined(entity) && isDefined(entity.enemy)) {
    entity.enemy dodamage(25, entity.enemy.origin, entity, entity, "neck", "MOD_MELEE");
  }
}

private function_b75dd595(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity.subarchetype !== #"crimson_nosferatu") {
    return false;
  }

  var_ae9326df = blackboard::getblackboardevents("nfrtu_move_dash");

  if(isDefined(var_ae9326df) && var_ae9326df.size) {
    foreach(var_d86ae1c4 in var_ae9326df) {
      if(var_d86ae1c4.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_8b2173e0(entity) {
  var_d86ae1c4 = spawnStruct();
  var_d86ae1c4.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_move_dash", var_d86ae1c4, randomintrange(8500, 10000));
  return true;
}

private function_3df24b25(entity) {
  if(getdvarint(#"hash_5ebc5d42d65e6fd1", 0)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_935d5acc = blackboard::getblackboardevents("nfrtu_latch_melee");

  if(isDefined(var_935d5acc) && var_935d5acc.size) {
    foreach(var_1e5d8d32 in var_935d5acc) {
      if(var_1e5d8d32.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_15d413b9(entity) {
  entity.var_1c33120d = 1;
  var_1e5d8d32 = spawnStruct();
  var_1e5d8d32.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_latch_melee", var_1e5d8d32, randomintrange(30000, 50000));
  return true;
}

private function_b758de87(entity) {
  entity.var_1c33120d = 0;
  entity clearpath();
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_leap_melee", var_3bfe8ebe, randomintrange(6000, 9000));
}

private function_b5305a8f(entity) {
  if(isDefined(entity.enemy)) {
    entity thread function_20a76c21(entity);
  }

  return true;
}

private function_2ad18645(notifyhash) {
  player = self;

  if(isDefined(self) && !isplayer(self) && isDefined(self.enemy) && isplayer(self.enemy)) {
    player = self.enemy;
  }

  if(isDefined(player)) {
    player val::reset(#"nosferatu_latch", "ignoreme");
    player val::reset(#"nosferatu_latch", "disable_weapons");
  }
}

private function_fb3fdf43(entity, latch_enemy) {
  entity endoncallback(&function_2ad18645, #"death");
  latch_enemy endoncallback(&function_2ad18645, #"disconnect", #"death");

  if(isDefined(self) && isDefined(entity) && isDefined(latch_enemy)) {
    self scene::play(#"aib_vign_cust_mnsn_nfrtu_attack_latch_01", array(entity, latch_enemy));
  }

  if(isDefined(entity)) {
    entity.meleeinfo = undefined;
    entity.var_1c33120d = 0;
  }

  if(isDefined(self)) {
    self notify(#"hash_7a32b2af2eef5415");
  }
}

private function_20a76c21(entity) {
  entity endoncallback(&function_2ad18645, #"death");
  latch_enemy = entity.enemy;
  latch_enemy endoncallback(&function_2ad18645, #"disconnect", #"death");

  if(isDefined(latch_enemy)) {
    latch_enemy thread function_db62d88a();
  }

  alignnode = spawnStruct();
  alignnode.origin = entity.enemy.origin;
  alignnode.angles = entity.enemy.angles;
  alignnode thread function_fb3fdf43(entity, latch_enemy);
  alignnode waittilltimeout(7, #"hash_7a32b2af2eef5415");

  if(isDefined(alignnode)) {
    alignnode struct::delete();
  }

  if(isDefined(latch_enemy)) {
    latch_enemy val::reset(#"nosferatu_latch", "disable_weapons");
    latch_enemy notify(#"hash_7a32b2af2eef5415");
  }

  if(isDefined(entity)) {
    entity.var_1c33120d = 0;
    entity clearpath();
  }

  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = latch_enemy;
  blackboard::addblackboardevent("nfrtu_leap_melee", var_3bfe8ebe, randomintrange(6000, 9000));
}

private function_db62d88a() {
  self endon(#"disconnect", #"death");
  self val::set(#"nosferatu_latch", "ignoreme", 1);
  w_current = self getcurrentweapon();

  if(isDefined(w_current) && isDefined(w_current.isheroweapon) && w_current.isheroweapon) {
    self val::set(#"nosferatu_latch", "disable_weapons", 1);
  }

  wait 8;
  self val::reset(#"nosferatu_latch", "ignoreme");
}

private function_a41a5aea(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!isplayer(entity.enemy)) {
    return false;
  }

  if(isDefined(entity.enemy.var_7ebdb2c9) && entity.enemy.var_7ebdb2c9) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
    return false;
  }

  distancesq = distancesquared(entity.origin, entity.enemy.origin);

  if(distancesq >= 96 * 96) {
    return false;
  }

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  enemyangles = entity.enemy getplayerangles();

  if(!util::within_fov(entity.enemy.origin, enemyangles, self.origin, cos(25))) {
    return false;
  }

  if(!tracepassedonnavmesh(entity.origin, entity.enemy.origin, entity getpathfindingradius())) {
    return false;
  }

  return true;
}

private function_b5047448(entity) {
  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    if(!entity haspath()) {
      return false;
    }

    if(!btapi_shouldchargemelee(entity)) {
      return false;
    }

    if(!function_c2f87d6(entity)) {
      return false;
    }

    if(!isplayer(entity.enemy)) {
      return false;
    }

    if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
      return false;
    }

    if(!entity cansee(entity.enemy)) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, entity.enemy.origin, entity getpathfindingradius())) {
      return false;
    }

    return true;
  }

  return false;
}

private function_e9819a23(entity) {
  if(entity.subarchetype !== #"crimson_nosferatu") {
    return false;
  }

  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    if(!btapi_shouldchargemelee(entity)) {
      return false;
    }

    if(!function_3df24b25(entity)) {
      return false;
    }

    if(!isplayer(entity.enemy)) {
      return false;
    }

    if(isDefined(entity.enemy.var_7ebdb2c9) && entity.enemy.var_7ebdb2c9) {
      return false;
    }

    if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
      return false;
    }

    predictedenemypos = entity.enemy.origin;
    velocity = entity.enemy getvelocity();

    if(length(velocity) > 0) {
      predictedenemypos += vectorscale(velocity, 0.25);
    }

    distancesq = distancesquared(entity.origin, predictedenemypos);

    if(distancesq <= 128 * 128) {
      return false;
    }

    if(distancesq >= 100 * 100) {
      if(entity.enemy issprinting()) {
        enemyvelocity = vectornormalize(entity.enemy getvelocity());
        var_7a61ad67 = vectornormalize(entity getvelocity());

        if(vectordot(var_7a61ad67, enemyvelocity) > cos(20)) {
          record3dtext("<dev string:x38>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

          return false;
        }
      }
    }

    if(!entity cansee(entity.enemy)) {
      return false;
    }

    enemyangles = entity.enemy getplayerangles();

    if(!util::within_fov(entity.enemy.origin, enemyangles, self.origin, cos(25))) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, predictedenemypos, entity getpathfindingradius())) {
      return false;
    }

    return true;
  }

  return false;
}

private function_85d8b15d(entity) {
  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.enemy)) {
    if(!btapi_shouldchargemelee(entity)) {
      return false;
    }

    if(!function_105988a0(entity)) {
      return false;
    }

    if(!isplayer(entity.enemy)) {
      return false;
    }

    if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
      return false;
    }

    predictedenemypos = entity.enemy.origin;
    velocity = entity.enemy getvelocity();

    if(length(velocity) > 0) {
      predictedenemypos += vectorscale(velocity, 0.25);
    }

    distancesq = distancesquared(entity.origin, predictedenemypos);

    if(distancesq <= 128 * 128) {
      return false;
    }

    if(distancesq >= 100 * 100) {
      if(entity.enemy issprinting()) {
        enemyvelocity = vectornormalize(entity.enemy getvelocity());
        var_7a61ad67 = vectornormalize(entity getvelocity());

        if(vectordot(var_7a61ad67, enemyvelocity) > cos(20)) {
          record3dtext("<dev string:x38>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

          return false;
        }
      }
    }

    if(!entity cansee(entity.enemy)) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, predictedenemypos, entity getpathfindingradius())) {
      return false;
    }

    return true;
  }

  return false;
}

function_ebe0e1b5(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_623b3520 = blackboard::getblackboardevents("nfrtu_full_pain");

  if(isDefined(var_623b3520) && var_623b3520.size) {
    foreach(var_77d2339d in var_623b3520) {
      if(var_77d2339d.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_76505306(entity) {
  var_77d2339d = spawnStruct();
  var_77d2339d.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_full_pain", var_77d2339d, randomintrange(4500, 6500));
}

private function_e0ad0db2(entity) {
  entity pathmode("move allowed");
}

private nosferatushouldmelee(entity) {
  if(function_85d8b15d(entity) || function_7ffbbff(entity) || function_e9819a23(entity) || function_b5047448(entity)) {
    return true;
  }

  return false;
}

private function_7ffbbff(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(isDefined(entity.ignoremelee) && entity.ignoremelee) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > 80 * 80) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > (isDefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60)) {
    return false;
  }

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  if(!tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity.enemy getpathfindingradius())) {
    return false;
  }

  return true;
}

private function_105988a0(entity) {
  if(getdvarint(#"hash_541d64bc060bdd29", 0)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_33f55f67 = blackboard::getblackboardevents("nfrtu_leap_melee");

  if(isDefined(var_33f55f67) && var_33f55f67.size) {
    foreach(var_3bfe8ebe in var_33f55f67) {
      if(var_3bfe8ebe.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_c2f87d6(entity) {
  if(getdvarint(#"hash_43a13163c1956e08", 0)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  var_33f55f67 = blackboard::getblackboardevents("nfrtu_run_melee");

  if(isDefined(var_33f55f67) && var_33f55f67.size) {
    foreach(var_3bfe8ebe in var_33f55f67) {
      if(var_3bfe8ebe.data.enemy === entity.enemy) {
        return false;
      }
    }
  }

  return true;
}

private function_ed80a3bc(entity) {
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_run_melee", var_3bfe8ebe, randomintrange(10000, 12000));
}

private function_4df0b87d(entity) {
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_leap_melee", var_3bfe8ebe, randomintrange(6000, 9000));
}

function_37d5cfc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("zonly_physics", 1);
  entity orientmode("face enemy");
  entity pathmode("dont move", 0);
  entity.usegoalanimweight = 1;
}

function_4b55eb0a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
  entity orientmode("face default");
  entity pathmode("move delayed", 0, 0.2);
}

function_1ad502a0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("gravity", 1);
  entity orientmode("face angle", entity.angles[1]);
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity pathmode("dont move", 1);
  entity collidewithactors(0);

  if(isDefined(entity.enemy)) {
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
  }

  if(!isDefined(entity.meleeinfo)) {
    entity.meleeinfo = new class_1546f28e();
    entity.meleeinfo.var_9bfa8497 = entity.origin;
    entity.meleeinfo.var_98bc84b7 = getnotetracktimes(mocompanim, "start_adjust")[0];
    entity.meleeinfo.var_6392c3a2 = getnotetracktimes(mocompanim, "end_adjust")[0];
    var_e397f54c = getmovedelta(mocompanim, 0, 1, entity);
    entity.meleeinfo.var_cb28f380 = entity localtoworldcoords(var_e397f54c);

    movedelta = getmovedelta(mocompanim, 0, 1, entity);
    animendpos = entity localtoworldcoords(movedelta);
    distance = distance(entity.origin, animendpos);
    recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x53>");
    record3dtext("<dev string:x5c>" + distance, animendpos, (0, 1, 0), "<dev string:x53>");

  }
}

function_3511ecd1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  assert(isDefined(entity.meleeinfo));
  currentanimtime = entity getanimtime(mocompanim);

  if(isDefined(entity.enemy) && !entity.meleeinfo.adjustmentstarted && entity.meleeinfo.var_425c4c8b && currentanimtime >= entity.meleeinfo.var_98bc84b7) {
    predictedenemypos = entity.enemy.origin;
    velocity = entity.enemy getvelocity();

    if(length(velocity) > 0) {
      predictedenemypos += vectorscale(velocity, 0.25);
    }

    entity.meleeinfo.adjustedendpos = predictedenemypos;
    var_cf699df5 = distancesquared(entity.meleeinfo.var_9bfa8497, entity.meleeinfo.var_cb28f380);
    var_776ddabf = distancesquared(entity.meleeinfo.var_cb28f380, entity.meleeinfo.adjustedendpos);
    var_65cbfb52 = distancesquared(entity.meleeinfo.var_9bfa8497, entity.meleeinfo.adjustedendpos);
    var_201660e6 = tracepassedonnavmesh(entity.meleeinfo.var_9bfa8497, entity.meleeinfo.adjustedendpos, entity getpathfindingradius());
    traceresult = bulletTrace(entity.origin, entity.meleeinfo.adjustedendpos + (0, 0, 30), 0, entity, 0, 0, entity.enemy);
    isvisible = traceresult[#"fraction"] == 1;
    var_535d098c = 0;

    if(isDefined(traceresult[#"hitloc"]) && traceresult[#"hitloc"] == "riotshield") {
      var_cc075bd0 = vectornormalize(entity.origin - entity.meleeinfo.adjustedendpos);
      entity.meleeinfo.adjustedendpos += vectorscale(var_cc075bd0, 50);
      var_535d098c = 1;
    }

    if(traceresult[#"fraction"] < 0.9) {
      record3dtext("<dev string:x5f>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

      entity.meleeinfo.var_425c4c8b = 0;
    } else if(!var_201660e6) {
      record3dtext("<dev string:x6f>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

      entity.meleeinfo.var_425c4c8b = 0;
    } else if(var_cf699df5 > var_65cbfb52 && var_776ddabf >= 130 * 130) {
      record3dtext("<dev string:x80>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

      entity.meleeinfo.var_425c4c8b = 0;
    } else if(var_65cbfb52 >= 450 * 450) {
      record3dtext("<dev string:x8e>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

      entity.meleeinfo.var_425c4c8b = 0;
    }

    if(var_535d098c) {
      record3dtext("<dev string:x9c>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");

      entity.meleeinfo.var_425c4c8b = 1;
    }

    if(entity.meleeinfo.var_425c4c8b) {
      var_776ddabf = distancesquared(entity.meleeinfo.var_cb28f380, entity.meleeinfo.adjustedendpos);
      myforward = anglesToForward(entity.angles);
      var_1c3641f2 = (entity.enemy.origin[0], entity.enemy.origin[1], entity.origin[2]);
      dirtoenemy = vectornormalize(var_1c3641f2 - entity.origin);
      zdiff = entity.meleeinfo.var_cb28f380[2] - entity.enemy.origin[2];
      withinzrange = abs(zdiff) <= 64;
      withinfov = vectordot(myforward, dirtoenemy) > cos(50);
      var_7948b2f3 = withinzrange && withinfov;
      var_425c4c8b = (isvisible || var_535d098c) && var_7948b2f3;

      reasons = "<dev string:xaf>" + isvisible + "<dev string:xb6>" + withinzrange + "<dev string:xbc>" + withinfov;

      if(var_425c4c8b) {
        record3dtext(reasons, entity.origin + (0, 0, 60), (0, 1, 0), "<dev string:x53>");
      } else {
        record3dtext(reasons, entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x53>");
      }

      if(var_425c4c8b) {
        var_90c3cdd2 = length(entity.meleeinfo.adjustedendpos - entity.meleeinfo.var_cb28f380);
        timestep = function_60d95f53();
        animlength = getanimlength(mocompanim) * 1000;
        starttime = entity.meleeinfo.var_98bc84b7 * animlength;
        stoptime = entity.meleeinfo.var_6392c3a2 * animlength;
        starttime = ceil(starttime / timestep);
        stoptime = ceil(stoptime / timestep);
        adjustduration = stoptime - starttime;
        entity.meleeinfo.var_10b8b6d1 = vectornormalize(entity.meleeinfo.adjustedendpos - entity.meleeinfo.var_cb28f380);
        entity.meleeinfo.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
        entity.meleeinfo.var_425c4c8b = 1;
        entity.meleeinfo.adjustmentstarted = 1;
      } else {
        entity.meleeinfo.var_425c4c8b = 0;
      }
    }
  }

  if(entity.meleeinfo.adjustmentstarted) {
    if(currentanimtime <= entity.meleeinfo.var_6392c3a2) {
      assert(isDefined(entity.meleeinfo.var_10b8b6d1) && isDefined(entity.meleeinfo.var_8b9a15a6));

      recordsphere(entity.meleeinfo.var_cb28f380, 3, (0, 1, 0), "<dev string:x53>");
      recordsphere(entity.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x53>");

      adjustedorigin = entity.origin + entity.meleeinfo.var_10b8b6d1 * entity.meleeinfo.var_8b9a15a6;
      entity forceteleport(adjustedorigin);
      return;
    }

    if(isDefined(entity.enemy)) {
      entity orientmode("face enemy");
    }
  }
}

function_b472ba3d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity.blockingpain = 0;
  entity.usegoalanimweight = 0;
  entity orientmode("face enemy");
  entity collidewithactors(1);
  entity clearpath();
  entity pathmode("move delayed", 1, 0.2);
  entity.meleeinfo = undefined;
}

nfrtuleaprumble(entity) {
  entity clientfield::increment("nfrtu_leap_melee_rumb");
}