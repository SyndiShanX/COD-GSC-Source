/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_nosferatu.gsc
**************************************************/

#using script_1f0e83e43bf9c3b9;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace archetypenosferatu;
class class_1546f28e {
  var adjustmentstarted;
  var var_425c4c8b;

  constructor() {
    adjustmentstarted = 0;
    var_425c4c8b = 1;
  }
}

function autoexec init() {
  namespace_b3c8cf82::function_da6eecb2();
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"nosferatu", &function_5b800648);
  clientfield::register("actor", "nfrtu_leap_melee_rumb", 8000, 1, "counter");
}

function private function_dbd0360f() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &function_f8ab724f;
  self.___archetypeonbehavecallback = &function_b1df7220;
}

function private function_b1df7220(entity) {}

function private function_f8ab724f(entity) {
  self.__blackboard = undefined;
  self function_dbd0360f();
}

function private function_5b800648() {
  assert(isDefined(self.ai));
  function_dbd0360f();
  self.ignorepathenemyfightdist = 1;
  self.var_ceed8829 = 1;
  self.zigzag_activation_distance = 400;
  self.var_7d39ec6a = 1;
  self setavoidancemask("avoid actor");
  self callback::function_d8abfc3d(#"on_ai_melee", &function_2e5f2af4);
}

function private function_2e5f2af4() {
  if(isDefined(self.meleeinfo)) {
    radiusdamage(self.origin, 150, 15, 5, self, "MOD_MELEE");
  }
}

function private registerbehaviorscriptfunctions() {
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

function function_2e8014e(entity) {
  if(isDefined(entity) && isDefined(entity.enemy)) {
    entity.enemy dodamage(25, entity.enemy.origin, entity, entity, "neck", "MOD_MELEE");
  }
}

function private function_b75dd595(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity.subarchetype !== # "crimson_nosferatu") {
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

function private function_8b2173e0(entity) {
  var_d86ae1c4 = spawnStruct();
  var_d86ae1c4.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_move_dash", var_d86ae1c4, randomintrange(8500, 10000));
  return true;
}

function private function_3df24b25(entity) {
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

function private function_15d413b9(entity) {
  entity.var_1c33120d = 1;
  var_1e5d8d32 = spawnStruct();
  var_1e5d8d32.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_latch_melee", var_1e5d8d32, randomintrange(30000, 50000));
  return true;
}

function private function_b758de87(entity) {
  entity.var_1c33120d = 0;
  entity clearpath();
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_leap_melee", var_3bfe8ebe, randomintrange(6000, 9000));
}

function private function_b5305a8f(entity) {
  if(isDefined(entity.enemy)) {
    entity thread function_20a76c21(entity);
  }

  return true;
}

function private function_2ad18645(notifyhash) {
  player = self;

  if(isDefined(self) && !isPlayer(self) && isDefined(self.enemy) && isPlayer(self.enemy)) {
    player = self.enemy;
  }

  if(isDefined(player)) {
    player val::reset(#"nosferatu_latch", "ignoreme");
    player val::reset(#"nosferatu_latch", "disable_weapons");
  }
}

function private function_fb3fdf43(entity, latch_enemy) {
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

function private function_20a76c21(entity) {
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

function private function_db62d88a() {
  self endon(#"death");
  self val::set(#"nosferatu_latch", "ignoreme", 1);
  w_current = self getcurrentweapon();

  if(isDefined(w_current) && is_true(w_current.isheroweapon)) {
    self val::set(#"nosferatu_latch", "disable_weapons", 1);
  }

  wait 8;
  self val::reset(#"nosferatu_latch", "ignoreme");
}

function private function_a41a5aea(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!isPlayer(entity.enemy)) {
    return false;
  }

  if(is_true(entity.enemy.var_7ebdb2c9)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
    return false;
  }

  distancesq = distancesquared(entity.origin, entity.enemy.origin);

  if(distancesq >= sqr(96)) {
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

function private function_b5047448(entity) {
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

    if(!isPlayer(entity.enemy)) {
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

function private function_e9819a23(entity) {
  if(entity.subarchetype !== # "crimson_nosferatu") {
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

    if(!isPlayer(entity.enemy)) {
      return false;
    }

    if(is_true(entity.enemy.var_7ebdb2c9)) {
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

    if(distancesq <= sqr(128)) {
      return false;
    }

    if(distancesq >= sqr(100)) {
      if(entity.enemy issprinting()) {
        enemyvelocity = vectornormalize(entity.enemy getvelocity());
        var_7a61ad67 = vectornormalize(entity getvelocity());

        if(vectordot(var_7a61ad67, enemyvelocity) > cos(20)) {
          record3dtext("<dev string:x38>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

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

function private function_85d8b15d(entity) {
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

    if(!isPlayer(entity.enemy)) {
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

    if(distancesq <= sqr(128)) {
      return false;
    }

    if(distancesq >= sqr(100)) {
      if(entity.enemy issprinting()) {
        enemyvelocity = vectornormalize(entity.enemy getvelocity());
        var_7a61ad67 = vectornormalize(entity getvelocity());

        if(vectordot(var_7a61ad67, enemyvelocity) > cos(20)) {
          record3dtext("<dev string:x38>", entity.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

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

function function_ebe0e1b5(entity) {
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

function private function_76505306(entity) {
  var_77d2339d = spawnStruct();
  var_77d2339d.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_full_pain", var_77d2339d, randomintrange(4500, 6500));
}

function private function_e0ad0db2(entity) {
  entity pathmode("move allowed");
}

function private nosferatushouldmelee(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(is_true(entity.enemy.ignoreme)) {
    return false;
  }

  if(function_85d8b15d(entity) || function_7ffbbff(entity) || function_e9819a23(entity) || function_b5047448(entity)) {
    return true;
  }

  return false;
}

function private function_7ffbbff(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity asmistransitionrunning() || entity asmistransdecrunning()) {
    return false;
  }

  if(isDefined(entity.marked_for_death)) {
    return false;
  }

  if(is_true(entity.ignoremelee)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > sqr(80)) {
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

function private function_105988a0(entity) {
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

function private function_c2f87d6(entity) {
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

function private function_ed80a3bc(entity) {
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_run_melee", var_3bfe8ebe, randomintrange(10000, 12000));
}

function private function_4df0b87d(entity) {
  var_3bfe8ebe = spawnStruct();
  var_3bfe8ebe.enemy = entity.enemy;
  blackboard::addblackboardevent("nfrtu_leap_melee", var_3bfe8ebe, randomintrange(6000, 9000));
}

function function_37d5cfc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("zonly_physics", 1);
  mocompduration orientmode("face enemy");
  mocompduration pathmode("dont move", 0);
  mocompduration.usegoalanimweight = 1;
}

function function_4b55eb0a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.blockingpain = 0;
  mocompduration.usegoalanimweight = 0;
  mocompduration orientmode("face default");
  mocompduration pathmode("move delayed", 0, 0.2);
}

function function_1ad502a0(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompanimflag animmode("gravity", 1);
  mocompanimflag orientmode("face angle", mocompanimflag.angles[1]);
  mocompanimflag.blockingpain = 1;
  mocompanimflag.usegoalanimweight = 1;
  mocompanimflag pathmode("dont move", 1);
  mocompanimflag collidewithactors(0);

  if(isDefined(mocompanimflag.enemy)) {
    dirtoenemy = vectornormalize(mocompanimflag.enemy.origin - mocompanimflag.origin);
    mocompanimflag forceteleport(mocompanimflag.origin, vectortoangles(dirtoenemy));
  }

  if(!isDefined(mocompanimflag.meleeinfo)) {
    mocompanimflag.meleeinfo = new class_1546f28e();
    mocompanimflag.meleeinfo.var_9bfa8497 = mocompanimflag.origin;
    mocompanimflag.meleeinfo.var_98bc84b7 = getnotetracktimes(mocompduration, "start_adjust")[0];
    mocompanimflag.meleeinfo.var_6392c3a2 = getnotetracktimes(mocompduration, "end_adjust")[0];
    var_e397f54c = getmovedelta(mocompduration, 0, 1);
    mocompanimflag.meleeinfo.var_cb28f380 = mocompanimflag localtoworldcoords(var_e397f54c);

    movedelta = getmovedelta(mocompduration, 0, 1);
    animendpos = mocompanimflag localtoworldcoords(movedelta);
    distance = distance(mocompanimflag.origin, animendpos);
    recordcircle(animendpos, 3, (0, 1, 0), "<dev string:x54>");
    record3dtext("<dev string:x5e>" + distance, animendpos, (0, 1, 0), "<dev string:x54>");
  }
}

function function_3511ecd1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  if(!isalive(mocompanimflag)) {
    return;
  }

  assert(isDefined(mocompanimflag.meleeinfo));
  currentanimtime = mocompanimflag getanimtime(mocompduration);

  if(isDefined(mocompanimflag.enemy) && !mocompanimflag.meleeinfo.adjustmentstarted && mocompanimflag.meleeinfo.var_425c4c8b && currentanimtime >= mocompanimflag.meleeinfo.var_98bc84b7) {
    predictedenemypos = mocompanimflag.enemy.origin;
    velocity = mocompanimflag.enemy getvelocity();

    if(length(velocity) > 0) {
      predictedenemypos += vectorscale(velocity, 0.25);
    }

    mocompanimflag.meleeinfo.adjustedendpos = predictedenemypos;
    var_cf699df5 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.var_cb28f380);
    var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
    var_65cbfb52 = distancesquared(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos);
    var_201660e6 = tracepassedonnavmesh(mocompanimflag.meleeinfo.var_9bfa8497, mocompanimflag.meleeinfo.adjustedendpos, mocompanimflag getpathfindingradius());
    traceresult = bulletTrace(mocompanimflag.origin, mocompanimflag.meleeinfo.adjustedendpos + (0, 0, 30), 0, mocompanimflag, 0, 0, mocompanimflag.enemy);
    isvisible = traceresult[# "fraction"] == 1;
    var_535d098c = 0;

    if(isDefined(traceresult[# "hitloc"]) && traceresult[# "hitloc"] == "riotshield") {
      var_cc075bd0 = vectornormalize(mocompanimflag.origin - mocompanimflag.meleeinfo.adjustedendpos);
      mocompanimflag.meleeinfo.adjustedendpos += vectorscale(var_cc075bd0, 50);
      var_535d098c = 1;
    }

    if(traceresult[# "fraction"] < 0.9) {
      record3dtext("<dev string:x62>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    } else if(!var_201660e6) {
      record3dtext("<dev string:x73>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    } else if(var_cf699df5 > var_65cbfb52 && var_776ddabf >= sqr(130)) {
      record3dtext("<dev string:x85>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    } else if(var_65cbfb52 >= sqr(450)) {
      record3dtext("<dev string:x94>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

      mocompanimflag.meleeinfo.var_425c4c8b = 0;
    }

    if(var_535d098c) {
      record3dtext("<dev string:xa3>", mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");

      mocompanimflag.meleeinfo.var_425c4c8b = 1;
    }

    if(mocompanimflag.meleeinfo.var_425c4c8b) {
      var_776ddabf = distancesquared(mocompanimflag.meleeinfo.var_cb28f380, mocompanimflag.meleeinfo.adjustedendpos);
      myforward = anglesToForward(mocompanimflag.angles);
      var_1c3641f2 = (mocompanimflag.enemy.origin[0], mocompanimflag.enemy.origin[1], mocompanimflag.origin[2]);
      dirtoenemy = vectornormalize(var_1c3641f2 - mocompanimflag.origin);
      zdiff = mocompanimflag.meleeinfo.var_cb28f380[2] - mocompanimflag.enemy.origin[2];
      withinzrange = abs(zdiff) <= 64;
      withinfov = vectordot(myforward, dirtoenemy) > cos(50);
      var_7948b2f3 = withinzrange && withinfov;
      var_425c4c8b = (isvisible || var_535d098c) && var_7948b2f3;

      reasons = "<dev string:xb7>" + isvisible + "<dev string:xbf>" + withinzrange + "<dev string:xc6>" + withinfov;

      if(var_425c4c8b) {
        record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (0, 1, 0), "<dev string:x54>");
      } else {
        record3dtext(reasons, mocompanimflag.origin + (0, 0, 60), (1, 0, 0), "<dev string:x54>");
      }

      if(var_425c4c8b) {
        var_90c3cdd2 = length(mocompanimflag.meleeinfo.adjustedendpos - mocompanimflag.meleeinfo.var_cb28f380);
        timestep = function_60d95f53();
        animlength = getanimlength(mocompduration) * 1000;
        starttime = mocompanimflag.meleeinfo.var_98bc84b7 * animlength;
        stoptime = mocompanimflag.meleeinfo.var_6392c3a2 * animlength;
        starttime = ceil(starttime / timestep);
        stoptime = ceil(stoptime / timestep);
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

      recordsphere(mocompanimflag.meleeinfo.var_cb28f380, 3, (0, 1, 0), "<dev string:x54>");
      recordsphere(mocompanimflag.meleeinfo.adjustedendpos, 3, (0, 0, 1), "<dev string:x54>");

      adjustedorigin = mocompanimflag.origin + mocompanimflag.meleeinfo.var_10b8b6d1 * mocompanimflag.meleeinfo.var_8b9a15a6;
      mocompanimflag forceteleport(adjustedorigin);
      return;
    }

    if(isDefined(mocompanimflag.enemy)) {
      mocompanimflag orientmode("face enemy");
    }
  }
}

function function_b472ba3d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration.blockingpain = 0;
  mocompduration.usegoalanimweight = 0;
  mocompduration orientmode("face enemy");
  mocompduration collidewithactors(1);
  mocompduration clearpath();
  mocompduration pathmode("move delayed", 1, 0.2);
  mocompduration.meleeinfo = undefined;
}

function nfrtuleaprumble(entity) {
  entity clientfield::increment("nfrtu_leap_melee_rumb");
}