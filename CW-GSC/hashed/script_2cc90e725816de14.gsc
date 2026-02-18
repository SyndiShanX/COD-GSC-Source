/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2cc90e725816de14.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\mechz;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\mechz_firebomb;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_behavior;
#namespace namespace_394b7174;

function private autoexec __init__system__() {
  system::register(#"hash_76fcf333cf2abd11", &__init__, undefined, &function_4df027f2, undefined);
}

function __init__() {
  spawner::add_archetype_spawn_function(#"mechz", &function_b8e86206);
  spawner::function_89a2cd87(#"mechz", &function_3f369eaa);
}

function private function_4df027f2() {
  level thread aat::register_immunity("ammomod_brainrot", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_brainrot_1", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_brainrot_2", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_brainrot_3", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_brainrot_4", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_brainrot_5", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze_1", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze_2", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze_3", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze_4", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_cryofreeze_5", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire_1", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire_2", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire_3", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire_4", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_deadwire_5", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst_1", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst_2", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst_3", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst_4", #"mechz", 1, 1, 1);
  level thread aat::register_immunity("ammomod_napalmburst_5", #"mechz", 1, 1, 1);
}

function function_b8e86206() {
  self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::zombie_on_melee);
  self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_3076443);
  self.var_12af7864 = 1;
  self.blockingpain = 1;
  self.var_d8695234 = 1;
  self.var_90d0c0ff = "anim_mechz_spawn";
  self.var_ecbef856 = "anim_mechz_despawn";
  self.should_zigzag = 0;
  self.ai.var_870d0893 = 1;
  self.var_f7c8ccf5 = &function_f7c8ccf5;
  self.var_b3c613a7 = [1, 1.5, 1.5, 2, 2];
  self.var_414bc881 = 0.5;
  self.var_97ca51c7 = 2;
  self.var_5e55975f = &namespace_e292b080::zombieshouldmelee;
}

function function_3f369eaa() {
  self function_8d5f13fa();

  if(is_true(self.var_1a5b6b7e)) {
    self endon(#"death");
    awareness::pause(self);
    self animscripted("rise_anim", self.origin, (0, self.angles[1], 0), #"ai_t9_zm_mechz_arrive", "normal", undefined, 1, 0.2);
    self waittillmatch({
      #notetrack: "end"}, #"rise_anim");
    awareness::resume(self);
  }
}

function function_3076443(params) {
  self endon(#"death");

  if(isDefined(self.attackable)) {
    namespace_85745671::function_2b925fa5(self);
  }

  self animscripted("despawn_anim", self.origin, self.angles, #"ai_t9_zm_mechz_exit", "normal", undefined, 1, 0.2);
  self waittillmatch({
    #notetrack: "end"}, #"despawn_anim");
  self ghost();
  self notsolid();
  waittillframeend();
  self.var_98f1f37c = 1;
  self.allowdeath = 1;
  self kill(undefined, undefined, undefined, undefined, 0, 1);
}

function function_8d5f13fa() {
  self.fovcosine = 0.5;
  self.maxsightdistsqrd = sqr(900);
  self.has_awareness = 1;
  self.ignorelaststandplayers = 1;
  self.var_1267fdea = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
  awareness::register_state(self, #"wander", &function_65f28890, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
  awareness::register_state(self, #"investigate", &awareness::function_b41f0471, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
  awareness::register_state(self, #"chase", &function_43c21e81, &function_3715dbff, &function_dca46c2e, &awareness::function_5c40e824, undefined);
  awareness::register_state(self, #"relocate", &function_3a6dfa8b, &function_6e7d7d1, &function_7ea826b6, &awareness::function_5c40e824, undefined);
  awareness::register_state(self, #"scripted", &function_235c2ec8, undefined, &function_39e16337);
  awareness::set_state(self, #"wander");
  self callback::function_d8abfc3d(#"hash_1c5ac76933317a1d", &awareness::pause, undefined, array(self));
  self callback::function_d8abfc3d(#"hash_6ce1d15fa3e62552", &function_a84a928b);
  self callback::on_ai_damage(&function_d3f3bff7);
  self thread awareness::function_fa6e010d();
}

function function_65f28890(entity) {
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
  entity.fovcosine = 0.5;
  entity.maxsightdistsqrd = sqr(1000);
  entity.var_1267fdea = 0;
  awareness::function_9c9d96b5(entity);
}

function function_64072d21(entity) {
  entity.fovcosine = 0;
  entity.maxsightdistsqrd = sqr(1800);
  entity.var_1267fdea = 0;
  awareness::function_b41f0471(entity);
}

function private function_32309e80(entity) {
  return isDefined(entity.var_a8e56aa3) && entity.var_a8e56aa3 > gettime();
}

function private function_cdbe8d0a(entity) {
  return isDefined(entity.var_e05f2c0a) && entity.var_e05f2c0a > gettime();
}

function function_43c21e81(entity) {
  entity.fovcosine = 0;
  entity.maxsightdistsqrd = sqr(3000);
  entity.var_1267fdea = 0;
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
  entity.maxsightdistsqrd = sqr(3000);
  entity.var_972b23bb = 1;
  zm_ai_utility::function_4d22f6d1(entity);
  awareness::function_978025e4(entity);
}

function private function_f7c8ccf5(entity, point1, point2) {
  if(isDefined(entity.var_a8eff0f2) && gettime() - entity.var_a8eff0f2 < int(1 * 1000)) {
    return false;
  }

  trace = physicstraceex(point1, point2, entity getmins(), entity getmaxs(), entity);
  return trace[# "fraction"] >= 1;
}

function function_3715dbff(entity) {
  if(is_true(entity.var_1fa24724) && isDefined(entity.enemy)) {
    zm_behavior::function_483766be(entity);
    var_db31ebd5 = !entity haspath() && abs(entity.enemy.origin[2] - self.origin[2]) > 120;

    if(var_db31ebd5) {
      return;
    }
  }

  target = isDefined(entity.favoriteenemy) ? entity.favoriteenemy : entity.attackable;

  if(isDefined(target) && entity.var_9329a57c < gettime()) {
    if(namespace_3444cb7b::mechzisinsafezone(entity) && entity cansee(target)) {
      distsqr = distancesquared(entity.origin, entity.favoriteenemy.origin);
      record3dtext("<dev string:x38>" + 225 + "<dev string:x55>" + 600 + "<dev string:x5a>" + sqrt(distsqr), entity.origin, (0, 1, 0));
      recordline(entity.origin, target.origin, (0, 1, 0));

      if(!namespace_3444cb7b::mechzshouldshootgrenade(entity)) {
        if(function_cdbe8d0a(entity)) {
          awareness::set_state(entity, #"relocate");
          return;
        }

        var_274bac27 = 90000;

        if(distancesquared(entity.origin, target.origin) > var_274bac27) {
          awareness::function_39da6c3c(entity);
        }
      }

      return;
    }
  }

  awareness::function_39da6c3c(entity);
}

function function_dca46c2e(entity) {
  entity.maxsightdistsqrd = sqr(900);
  entity.var_972b23bb = undefined;

  if(isDefined(entity.cluster) && entity.cluster.status === 0) {
    entity callback::callback(#"hash_10ab46b52df7967a");
    return;
  }

  awareness::function_b9f81e8b(entity);
}

function function_3a6dfa8b(entity) {
  function_43c21e81(entity);
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
  enemy = entity.favoriteenemy;
  assert(isDefined(enemy));
  var_1f1d655 = vectortoangles(entity.origin - entity.favoriteenemy.origin)[1];
  var_8daf3ac3 = 300;
  var_5c85bc30 = [];
  angle_offsets = [30, -30];

  foreach(angle in angle_offsets) {
    target_angle = absangleclamp360(var_1f1d655 + angle);
    target_vec = anglesToForward((0, target_angle, 0));
    target_pos = enemy.origin + target_vec * var_8daf3ac3;
    var_c38ec8b1 = getclosestpointonnavmesh(target_pos, 64, entity getpathfindingradius());

    if(isDefined(var_c38ec8b1)) {
      var_5c85bc30[var_5c85bc30.size] = var_c38ec8b1;
    }
  }

  var_e3a26bf0 = undefined;
  var_9da770d9 = 0;
  var_e1aa7e8 = undefined;
  var_6481e3f2 = entity getangles()[1];
  forward_vec = anglesToForward((0, var_6481e3f2, 0));

  foreach(pos in var_5c85bc30) {
    var_2872f5ac = pos - entity.origin;
    dot = vectordot(var_2872f5ac, forward_vec);

    if(dot > 0) {
      var_e3a26bf0 = pos;
    }

    if(!isDefined(var_e1aa7e8)) {
      var_e1aa7e8 = dot;
    }

    if(math::sign(dot) != math::sign(var_e1aa7e8)) {
      var_9da770d9 = 1;
    }

    var_e1aa7e8 = dot;

    recordsphere(pos, 10, (1, 0, 0), "<dev string:x66>");
    record3dtext("<dev string:x70>" + dot, pos + (0, 0, -10), (1, 0, 0));
  }

  if(var_9da770d9) {} else if(isPlayer(enemy)) {
    player_yaw = enemy getplayerangles()[1];
    var_ae507841 = anglesToForward((0, player_yaw, 0));
    var_ba9c64fa = enemy.origin + var_ae507841 * var_8daf3ac3;

    recordsphere(var_ba9c64fa, 10, (0, 1, 0), "<dev string:x66>");

    var_3393a039 = 2147483647;

    foreach(pos in var_5c85bc30) {
      dist_sqr = distancesquared(var_ba9c64fa, pos);

      if(dist_sqr < var_3393a039) {
        var_3393a039 = dist_sqr;
        var_e3a26bf0 = pos;
      }
    }
  } else if(var_5c85bc30.size > 0) {
    var_e3a26bf0 = var_5c85bc30[randomint(var_5c85bc30.size)];
  }

  if(isDefined(var_e3a26bf0)) {
    entity setgoal(var_e3a26bf0);

    recordsphere(var_e3a26bf0, 10, (0, 0, 1), "<dev string:x66>");
  }
}

function function_6e7d7d1(entity) {
  record3dtext("<dev string:x79>", entity.origin + (0, 20, 0), (0, 0, 1));

  if(is_true(entity.var_1fa24724)) {
    awareness::set_state(entity, #"chase");
    return;
  }

  if(isDefined(entity.favoriteenemy)) {
    goalinfo = entity function_4794d6a3();
    var_127a38a7 = distancesquared(goalinfo.goalpos, entity.origin);

    if(!namespace_3444cb7b::mechzisinsafezone(entity) || goalinfo.isatgoal || var_127a38a7 < sqr(64)) {
      awareness::set_state(entity, #"chase");
    }
  }
}

function function_7ea826b6(entity) {
  function_dca46c2e(entity);
}

function function_235c2ec8(entity) {
  entity.favoriteenemy = undefined;
  entity clearpath();
  entity setgoal(entity.origin, 1);
}

function function_39e16337(entity) {
  entity.favoriteenemy = undefined;
  entity clearpath();
  entity setgoal(entity.origin, 1);
}

function function_d3f3bff7(params) {
  if(isDefined(params.einflictor) && !isDefined(self.attackable) && isDefined(params.einflictor.var_b79a8ac7) && isarray(params.einflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, params.weapon)) {
    if(params.einflictor namespace_85745671::get_attackable_slot(self)) {
      self.attackable = params.einflictor;
    }
  }

  if(!isDefined(self.favoriteenemy) && isDefined(params.einflictor) && !isDefined(self.var_4b559171)) {
    awareness::function_c241ef9a(self, params.einflictor, 8);
    pointonnavmesh = getclosestpointonnavmesh(params.einflictor.origin, 256, self getpathfindingradius() * 1.2);
    var_f2f7ce25 = getclosestpointonnavmesh(self.origin, 256, self getpathfindingradius() * 1.2);

    if(!isDefined(pointonnavmesh) || !isDefined(var_f2f7ce25)) {
      return;
    }

    to_origin = self.origin - pointonnavmesh;
    goalpos = checknavmeshdirection(pointonnavmesh, to_origin, 96, self getpathfindingradius() * 1.2);
    self.var_4b559171 = goalpos;
  }
}

function function_a84a928b(params) {
  awareness::resume(self);
  nearby_zombies = getentitiesinradius(self.origin, self getpathfindingradius() * 3, 15);

  foreach(zombie in nearby_zombies) {
    if(zombie.archetype == # "zombie") {
      zombie zombie_utility::setup_zombie_knockdown(self);
    }
  }
}