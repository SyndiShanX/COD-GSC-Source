/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai_brutus.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\debug;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\infection;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\player\player_damage;
#include scripts\wz_common\wz_ai_utils;
#include scripts\wz_common\wz_ai_zombie;

#namespace wz_ai_brutus;

autoexec __init__system__() {
  system::register(#"wz_ai_brutus", &__init__, &__main__, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"brutus", &function_debbd9da);
  spawner::function_89a2cd87(#"brutus", &function_6090f71a);
  clientfield::register("actor", "brutus_shock_attack", 15000, 1, "counter");
  clientfield::register("actor", "brutus_spawn_clientfield", 15000, 1, "int");
  clientfield::register("toplayer", "brutus_shock_attack_player", 15000, 1, "counter");
  callback::on_actor_killed(&on_brutus_killed);
}

__main__() {}

private function_517fd069() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_666b2409;
  self.___archetypeonbehavecallback = &function_3cdbfffd;
}

private function_3cdbfffd(entity) {}

private function_666b2409(entity) {
  self.__blackboard = undefined;
  self function_517fd069();
}

function_debbd9da() {
  self function_517fd069();
  self wz_ai_utils::function_9758722("walk");
  aiutility::addaioverridedamagecallback(self, &function_83a6d3ae);
  self callback::function_d8abfc3d(#"on_ai_melee", &wz_ai_zombie::zombie_on_melee);
  self callback::function_d8abfc3d(#"on_ai_killed", &on_brutus_killed);
  self callback::function_d8abfc3d(#"hash_4e449871617e2c25", &function_6a482c74);
  self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &wz_ai_utils::function_16e2f075);
  self function_bad305c7();
  self.var_65e57a10 = 1;
  self.health = 6000;
  self.hashelmet = 1;
  self.helmethits = 0;
  self.var_96b5e3f1 = 0;
  self.invulnerabletime = 0;
  self.var_905e4ce2 = self ai::function_9139c839().var_267bc182;
  self.meleedamage = 150;
  self.var_f46fbf3f = 1;
  self.var_e38eaee5 = 0;
  self.var_a0193213 = 500;
  self.instakill_doors = 1;
  self.is_miniboss = 1;
  self.var_737e8510 = 96;
  self thread wz_ai_zombie::function_6c308e81();
  self setavoidancemask("avoid none");
  self.cant_move_cb = &wz_ai_zombie::function_9c573bc6;
  self.ignorepathenemyfightdist = 1;
  self.var_31a789c0 = 1;
  self.var_872e52b0 = &wz_ai_zombie::function_833ce8c8;
  self.var_721a3dbd = 1;
}

function_6a482c74(params) {
  switch (params.state) {
    case 3:
      self wz_ai_utils::function_9758722("run");
      break;
    default:
      break;
  }
}

function_bad305c7() {
  self.var_2cee3556 = [];
  self.var_2cee3556[#"brutus_base_itemlist_all"] = 15;
}

function_6090f71a() {
  self.explosive_dmg_req = 50;

  if(!getdvarint(#"survival_prototype", 0)) {
    self thread wz_ai_zombie::function_e261b81d();
  } else {
    self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &wz_ai_zombie::function_bb3c1175);
    self wz_ai_zombie::function_b670d610();
  }

  self clientfield::set("brutus_spawn_clientfield", 1);
  var_7dd9d338 = "c_t8_zmb_mob_brutus_baton";

  if(self.subarchetype === #"brutus_special") {
    var_7dd9d338 = "c_t8_zmb_mob_brutus_boss_baton";
  }

  self attach(var_7dd9d338, "tag_weapon_right");

  if(isDefined(self.ai_zone)) {
    node = getnode(self.ai_zone.zone_name + "_patrol", "targetname");

    if(isDefined(node)) {
      self.patrol_path = wz_ai_utils::get_pathnode_path(node);
      self.var_5d58d4c0 = &function_b510a832;
    }
  }
}

function_ea3e1b6c(entity) {
  entity.fovcosine = 0.5;
  entity.maxsightdistsqrd = 900 * 900;
}

on_brutus_killed(params) {
  self clientfield::set("brutus_spawn_clientfield", 0);
  playsoundatposition(#"zmb_ai_brutus_death", self.origin);
  self destructserverutils::togglespawngibs(self, 1);
  self destructserverutils::function_629a8d54(self, "tag_weapon_right");
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_3006441d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_df1d28cebbb75f6", &function_3006441d);
  assert(isscriptfunctionptr(&function_3bda3c55));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d8653062b32a601", &function_3bda3c55);
  assert(isscriptfunctionptr(&function_4ec678fe));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643443bf9243e4ff", &function_4ec678fe);
  assert(isscriptfunctionptr(&function_f4a61e6a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5800441474109ca6", &function_f4a61e6a);
  assert(isscriptfunctionptr(&function_5ca455a0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31bfd48e9c8557f0", &function_5ca455a0);
  assert(isscriptfunctionptr(&function_d996f07c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4fe62c9a1dbe75d3", &function_d996f07c);
  assert(isscriptfunctionptr(&function_e2ab1df7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14196abc66fc78ee", &function_e2ab1df7);
  assert(isscriptfunctionptr(&function_1bd1ebe7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6df8ee94ab700109", &function_1bd1ebe7);
  animationstatenetwork::registernotetrackhandlerfunction("hit_ground", &function_85e8940a);
}

private function_5ca455a0(entity) {
  entity val::set(#"brutus_cleanup", "blockingpain", 1);
  entity.var_8a96267d = undefined;
  entity.var_bc0e449a = 1;
}

private function_d996f07c(entity) {
  entity notify(#"is_underground");
  entity.var_bc0e449a = undefined;
}

private function_9d76e96c(entity) {
  entity val::set(#"brutus_cleanup", "allowoffnavmesh", 0);
  entity val::reset(#"brutus_cleanup", "blockingpain");
  entity ghost();
  entity notsolid();
  entity pathmode("dont move", 1);
  entity function_d4c687c9();
  entity clientfield::set("brutus_spawn_clientfield", 0);
}

private function_e2ab1df7(entity) {
  entity solid();
  entity.var_8ba6ede3 = undefined;
}

private function_1bd1ebe7(entity) {
  entity val::reset(#"brutus_cleanup", "allowoffnavmesh");
  entity show();
  entity clientfield::set("brutus_spawn_clientfield", 1);
  entity pathmode("move allowed");
  entity notify(#"not_underground");
}

private function_3006441d(entity) {
  if(!isDefined(entity.var_722a34a3) || !isDefined(entity.var_52e3b294) || distancesquared(entity.var_52e3b294, entity.origin) > 10 * 10) {
    return false;
  }

  return true;
}

private function_4ec678fe(entity) {
  if(!isDefined(entity.var_722a34a3)) {
    return;
  }

  monkeybomb = entity.var_722a34a3;
  level notify(#"hash_79c0225ea09cd215", {
    #brutus: self, 
    #var_cee6bd0b: monkeybomb.origin, 
    #var_569d804d: monkeybomb.angles
  });

  if(isDefined(monkeybomb.damagearea)) {
    monkeybomb.damagearea delete();
  }

  monkeybomb delete();
}

private function_3bda3c55(entity) {
  if(entity.var_96b5e3f1 > gettime()) {
    return false;
  }

  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }

  if(!wz_ai_utils::is_player_valid(entity.favoriteenemy)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.favoriteenemy.origin[2]) > 72) {
    return false;
  }

  if(distance2dsquared(entity.origin, entity.favoriteenemy.origin) > entity ai::function_9139c839().var_b4c77cfb * entity ai::function_9139c839().var_b4c77cfb) {
    return false;
  }

  if(lengthsquared(entity.favoriteenemy getvelocity()) > 90 * 90) {
    return false;
  }

  return true;
}

private function_f4a61e6a(entity) {
  entity.var_96b5e3f1 = gettime() + int(entity ai::function_9139c839().var_d5427206 * 1000);
}

private function_85e8940a(entity) {
  if(isDefined(entity.var_bc0e449a) && entity.var_bc0e449a) {
    function_9d76e96c(entity);
    return;
  }

  var_aa6baab8 = entity ai::function_9139c839().var_1709a39;
  players = getplayers(#"all", entity.origin, var_aa6baab8);
  shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");
  entity clientfield::increment("brutus_shock_attack", 1);

  foreach(player in players) {
    if(!wz_ai_utils::is_player_valid(player)) {
      continue;
    }

    if(player.origin[2] - entity.origin[2] < -32) {
      continue;
    }

    if(player.origin[2] - entity.origin[2] > 200) {
      continue;
    }

    if(!bullettracepassed(entity.origin, player gettagorigin("j_spine4"), 0, entity, player)) {
      continue;
    }

    damage = mapfloat(entity getpathfindingradius() + 15, entity ai::function_9139c839().var_1709a39, entity ai::function_9139c839().var_7ea758e1, 0, distance(entity.origin, player.origin));
    damage = int(max(10, damage));
    player dodamage(damage, entity.origin, entity, entity, "none", "MOD_PROJECTILE_SPLASH");
    player status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
    player clientfield::increment_to_player("brutus_shock_attack_player", 1);
  }
}

private function_97f51aa3(v_org) {
  grenade = self magicgrenadetype(getweapon(#"willy_pete"), v_org, (0, 0, 0), 0.4);
  grenade.owner = self;
}

function_530c54e3() {
  self.hashelmet = 0;
  destructserverutils::function_9885f550(self, "helmet");
  self playSound(#"evt_brutus_helmet");

  if(isalive(self)) {}
}

private function_55bb9c72(attacker, damage, weapon, var_81dcad68, damagemultiplier) {
  if(!(isDefined(self.hashelmet) && self.hashelmet)) {
    return (damage * var_81dcad68);
  }

  self.helmethits++;

  if(self.helmethits >= self.var_905e4ce2) {
    self function_530c54e3();
  }

  return damage * damagemultiplier;
}

private function_83a6d3ae(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex) {
  var_9000ab2 = isDefined(level.brutus_damage_percent) ? level.brutus_damage_percent : 0.5;
  var_81dcad68 = 1.5;

  if(isplayer(attacker) && attacker infection::is_infected()) {
    return 0;
  }

  if(self.invulnerabletime > gettime()) {
    if(isplayer(attacker)) {
      attacker util::show_hit_marker();
    }

    return 0;
  }

  self player::function_74a5d514(attacker, damage, meansofdeath, weapon, shitloc);

  if(isDefined(weapon) && meansofdeath !== "MOD_DOT") {
    dot_params = function_f74d2943(weapon, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, weapon, inflictor);
    }
  }

  if(isDefined(inflictor) && !isDefined(self.attackable) && isDefined(inflictor.var_b79a8ac7) && isarray(inflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, weapon)) {
    if(inflictor wz_ai_utils::get_attackable_slot(self)) {
      self.attackable = inflictor;
    }
  }

  if(isDefined(weapon) && weapon.weapclass == "spread") {
    var_9000ab2 *= 1.2;
    var_81dcad68 *= 1.2;
  }

  final_damage = 0;

  if(isDefined(meansofdeath) && (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE")) {
    if(!isDefined(self.explosivedmgtaken)) {
      self.explosivedmgtaken = 0;
    }

    self.explosivedmgtaken += damage;
    scaler = var_9000ab2;

    if(self.explosivedmgtaken >= self.explosive_dmg_req && isDefined(self.hashelmet) && self.hashelmet) {
      self function_530c54e3();
    }

    final_damage = damage * scaler;
  } else if(shitloc !== "head" && shitloc !== "helmet") {
    final_damage = damage * var_9000ab2;
  } else {
    final_damage = int(self function_55bb9c72(attacker, damage, weapon, var_81dcad68, var_9000ab2));
  }

  if(isDefined(level.var_85a39c96) && level.var_85a39c96) {
    final_damage = self.health + 1;
  }

    return final_damage;
}

private getclosestnode(entity, nodes) {
  if(nodes.size > 16) {
    filtered_nodes = arraysortclosest(nodes, entity.origin, 16);
  } else {
    filtered_nodes = nodes;
  }

  origins = [];

  foreach(node in filtered_nodes) {
    if(!isDefined(origins)) {
      origins = [];
    } else if(!isarray(origins)) {
      origins = array(origins);
    }

    origins[origins.size] = node.origin;
  }

  pathdata = generatenavmeshpath(entity.origin, origins, entity);

  if(isDefined(pathdata) && pathdata.status === "succeeded") {
    goalpos = pathdata.pathpoints[pathdata.pathpoints.size - 1];
    return arraygetclosest(goalpos, filtered_nodes);
  }

  return arraygetclosest(entity.origin, filtered_nodes);
}

function_b510a832() {
  level endon(#"game_ended");
  self endon(#"death", #"state_changed");
  start_node = getclosestnode(self, self.patrol_path.path);
  start_index = 0;

  foreach(index, node in self.patrol_path.path) {
    if(node == start_node) {
      start_index = index;
      break;
    }
  }

  while(true) {
    for(i = 0; i < self.patrol_path.path.size; i++) {
      var_cf88d3eb = self.patrol_path.path[(start_index + i) % self.patrol_path.path.size];
      next_goal = getclosestpointonnavmesh(var_cf88d3eb.origin, 100, self getpathfindingradius());

      if(!isDefined(next_goal)) {
        break;
      }

      self.var_80780af2 = next_goal;
      self.var_9a79d89d = next_goal;
      waitresult = self waittilltimeout(30, #"goal");

      if(isDefined(self.var_50826790) && self.var_50826790) {
        self.var_ef59b90 = 5;
        self.var_50826790 = 0;
      }

      if(waitresult._notify !== "timeout") {
        idle_time = randomfloatrange(3, 5);
        wait idle_time;
      }
    }
  }
}