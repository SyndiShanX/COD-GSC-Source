/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4dca2ab120688fc.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_2618e0f3e5e11649;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_3a704cbcf4081bfb;
#using scripts\core_common\ai\archetype_mimic;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\zm\ai\zm_ai_mimic;
#using scripts\zm_common\zm_destination_manager;
#namespace namespace_3d98def3;

function private autoexec __init__system__() {
  system::register(#"hash_e87958e045f8b8d", &preinit, undefined, undefined, undefined);
}

function preinit() {
  spawner::add_archetype_spawn_function(#"mimic", &function_76433e31);
  spawner::function_89a2cd87(#"mimic", &function_820e5ac3);
  level.var_f8d5dd16 = &function_bc29cf28;
  level.var_64aa9d51 = &function_64aa9d51;
  level.var_f29dd47 = &function_f29dd47;
  callback::add_callback(#"hash_7cdee03c16eb684a", &zm_ai_mimic::function_218c4ce8);
  namespace_ce1f29cc::add_archetype_spawn_function(#"mimic", &function_21de8113);
}

function function_76433e31() {
  self.ai.var_870d0893 = 1;
  self.var_1c0eb62a = 180;
  self.var_97ca51c7 = 4;
  self flag::set(#"hash_7b1f9f26f086bf39");
  self.melee_distance_check = &namespace_e292b080::function_e8983bf3;
  setup_awareness(self);
  self callback::function_d8abfc3d(#"hash_29cb63a7ebb5d699", &function_5c2b66f6);
  self callback::function_d8abfc3d(#"hash_484127e0cbd8f8cb", &function_7c591227);
}

function function_820e5ac3() {
  if(!is_true(self.var_2ca2d270) && isDefined(self.favoriteenemy)) {
    awareness::set_state(self, #"chase");
    return;
  }

  if(!isDefined(self.never_hide) && (!isDefined(self.reveal_time) || gettime() - self.reveal_time > function_60d95f53())) {
    awareness::set_state(self, #"hidden");
    return;
  }

  awareness::set_state(self, #"wander");
}

function private function_21de8113() {
  self.never_hide = 1;
}

function private setup_awareness(entity) {
  entity.has_awareness = 1;
  entity.ignorelaststandplayers = 1;
  entity.var_e453bcfa = 10;
  entity.var_91a026f2 = 10;
  entity.var_7ee943e1 = 10;
  self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
  awareness::register_state(entity, #"hidden", &function_7c29f2ef, &function_9853eadb, undefined, undefined, undefined);
  awareness::register_state(entity, #"wander", &awareness::function_9c9d96b5, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
  awareness::register_state(entity, #"investigate", &awareness::function_b41f0471, &awareness::function_9eefc327, &awareness::function_34162a25, undefined, &awareness::function_a360dd00);
  awareness::register_state(entity, #"chase", &function_f5ed7704, &function_c5e6cf62, &awareness::function_b9f81e8b, &awareness::function_5c40e824);
  entity callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &function_5394f283);
  entity thread awareness::function_fa6e010d();
}

function function_5394f283(params) {
  self endon(#"death");

  if(isDefined(self.attackable)) {
    namespace_85745671::function_2b925fa5(self);
  }

  self.var_98f1f37c = 1;
  self.allowdeath = 1;
  self kill(undefined, undefined, undefined, undefined, 0, 1);
}

function function_5c2b66f6(prop) {
  awareness::pause(self);
}

function function_7c591227(params) {
  awareness::resume(self);
  random_activator = array::random(params.activators);
  awareness::function_c241ef9a(self, random_activator, 10);
  awareness::set_state(self, #"chase");
}

function function_7c29f2ef(entity) {
  entity endon(#"death");
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");

  if(is_true(entity.var_2ca2d270) || awareness::is_paused(entity)) {
    return;
  }

  entity.should_hide = 1;
}

function function_9853eadb(entity) {
  if(is_true(entity.aat_turned)) {
    if(is_true(entity.var_2ca2d270) && isDefined(entity.trap_prop)) {
      mimic_prop_spawn::transform_spawn(entity.trap_prop, []);
    }

    awareness::set_state(entity, #"chase");
  }
}

function function_f5ed7704(entity) {
  self.fovcosine = 0;
  self.maxsightdistsqrd = sqr(3000);
  self.var_1267fdea = 0;
  entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");

  if(!isDefined(self.never_hide) && !is_true(self.aat_turned)) {
    entity.var_78f5fd91 = # "hidden";
  }

  awareness::function_978025e4(entity);
}

function function_c5e6cf62(entity) {
  if(is_true(entity.aat_turned)) {
    entity.var_78f5fd91 = undefined;
  }

  awareness::function_39da6c3c(entity);
}

function function_3ebfec3e(entity) {
  entity.var_78f5fd91 = undefined;
  awareness::function_b9f81e8b(entity);
}

function function_bc29cf28() {
  var_6be77126 = [#"ammo_cache", #"explore_chests", #"explore_chests_large", #"explore_chests_small", #"safehouse"];
  spawn_structs = zm_destination_manager::function_506afb9e(level.contentmanager.currentdestination, var_6be77126);

  for(i = 0; i < spawn_structs.size; i++) {
    if(!isDefined(spawn_structs[i].trigger)) {
      spawn_structs[i] = "";
    }
  }

  arrayremovevalue(spawn_structs, "", 0);
  return isDefined(spawn_structs) ? spawn_structs : [];
}

function function_64aa9d51(origin, var_783fc5e) {
  return [];
}

function function_f29dd47(var_d0f07bcd, var_3b5d9ccd) {
  return array::random(var_3b5d9ccd);
}