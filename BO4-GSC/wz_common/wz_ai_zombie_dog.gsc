/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_ai_zombie_dog.gsc
***********************************************/

#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\infection;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\player\player_damage;
#include scripts\wz_common\wz_ai_utils;
#include scripts\wz_common\wz_ai_zombie;

#namespace wz_ai_zombie_dog;

autoexec __init__system__() {
  system::register(#"wz_ai_zombie_dog", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "dog_spawn_fx", 15000, 1, "counter");
  clientfield::register("actor", "dog_fx", 15000, 1, "int");
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"zombie_dog", &function_b9d56970);
}

private function_cef412a7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {

  if(isDefined(level.var_85a39c96) && level.var_85a39c96) {
    idamage = self.health + 1;
  }

    if(isplayer(eattacker) && eattacker infection::is_infected()) {
      return 0;
    }

  if(isDefined(eattacker) && !util::function_fbce7263(self.team, eattacker.team)) {
    return 0;
  }

  if(isDefined(weapon) && smeansofdeath !== "MOD_DOT") {
    dot_params = function_f74d2943(weapon, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, weapon, einflictor);
    }
  }

  self player::function_74a5d514(eattacker, idamage, smeansofdeath, weapon, shitloc);

  if(isDefined(einflictor) && !isDefined(self.attackable) && isDefined(einflictor.var_b79a8ac7) && isarray(einflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, weapon)) {
    if(einflictor wz_ai_utils::get_attackable_slot(self)) {
      self.attackable = einflictor;
    }
  }

  return idamage;
}

function_b9d56970() {
  self callback::function_d8abfc3d(#"on_ai_melee", &wz_ai_zombie::zombie_on_melee);
  self callback::function_d8abfc3d(#"hash_45b50cc48ee7f9d8", &function_69c3e2ac);
  self callback::function_d8abfc3d(#"on_ai_killed", &on_dog_killed);
  self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &wz_ai_utils::function_16e2f075);
  self function_8e13b81e();
  aiutility::addaioverridedamagecallback(self, &function_cef412a7);
  self.var_65e57a10 = 1;
  self.var_872e52b0 = &function_30a35f51;
  self.cant_move_cb = &wz_ai_zombie::function_9c573bc6;
  self.var_31a789c0 = 1;
  self.var_1c0eb62a = 180;
  self.var_a0193213 = 50;
  self.var_13138acf = 1;
  self.instakill_doors = 1;
  self.var_cbc65493 = 1.5;
  self.var_f1b4d6d3 = 1;
  self.var_2c628c0f = 1;
  self.var_20e07206 = 1;
  self.var_721a3dbd = 1;
  zombiedogintro();

  if(isDefined(self)) {
    if(!getdvarint(#"survival_prototype", 0)) {
      self thread wz_ai_zombie::function_e261b81d();
    } else {
      self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &wz_ai_zombie::function_bb3c1175);
      self wz_ai_zombie::function_b670d610();
    }

    self thread function_6c308e81();
  }
}

function_8e13b81e() {
  self.var_2cee3556 = [];
  self.var_2cee3556[#"hellhound_base_itemlist_all"] = 1;
}

private function_8f5f431c(entity) {}

registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function(#"zombie_dog", &archetypezombiedogblackboardinit);
  assert(isscriptfunctionptr(&zombiedogshouldwalk));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldwalk", &zombiedogshouldwalk);
  assert(isscriptfunctionptr(&zombiedogshouldrun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldrun", &zombiedogshouldrun);
  assert(isscriptfunctionptr(&function_5bac75b6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77ab4b89c5221f6a", &function_5bac75b6);
  assert(isscriptfunctionptr(&function_4cc712c8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6125f61af86f0b68", &function_4cc712c8);
  assert(!isDefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
  assert(isscriptfunctionptr(&function_47e1bdeb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_17b0ff54092cd3bd", &function_47e1bdeb);
  assert(isscriptfunctionptr(&function_a5103696));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_741bad83e4d39bf2", &function_a5103696);
  assert(isscriptfunctionptr(&function_648f6c9b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5dacd9fb020cb77b", &function_648f6c9b);
  assert(isscriptfunctionptr(&function_a5c4f83b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c24ff85e2293300", &function_a5c4f83b);
  animationstatenetwork::registeranimationmocomp("mocomp_dog_lightning_teleport", &function_90dbd41, &function_2fa3612a, &function_1f51eea3);
}

archetypezombiedogblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
}

private archetypezombiedogonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombiedogblackboardinit();
}

private zombiedogintro() {
  self endon(#"death");
  self ghost();
  self pathmode("dont move", 1);
  self val::set(#"dog_spawn", "ignoreme");
  self val::set(#"dog_spawn", "allowdeath", 0);
  self setfreecameralockonallowed(0);
  self clientfield::increment("dog_spawn_fx");
  playsoundatposition(#"zmb_hellhound_prespawn", self.origin);
  wait 1.5;
  playsoundatposition(#"zmb_hellhound_bolt", self.origin);
  earthquake(0.5, 0.75, self.origin, 1000);
  playsoundatposition(#"zmb_hellhound_spawn", self.origin);

  if(isDefined(self.favoriteenemy)) {
    angle = vectortoangles(self.favoriteenemy.origin - self.origin);
    angles = (self.angles[0], angle[1], self.angles[2]);
  } else {
    angles = self.angles;
  }

  self dontinterpolate();
  self forceteleport(self.origin, angles);
  self val::reset(#"dog_spawn", "allowdeath");
  wait 0.1;
  self show();
  self setfreecameralockonallowed(1);
  self val::reset(#"dog_spawn", "ignoreme");
  self pathmode("move allowed");
  self clientfield::set("dog_fx", 1);
  self playLoopSound(#"zmb_hellhound_loop_fire");
}

private on_dog_killed(params) {
  if(self ishidden()) {
    return;
  }

  radiusdamage(self.origin + (0, 0, 18), 150, 20, 1, self, "MOD_PROJECTILE_SPLASH", self.weapon);
  self clientfield::set("dog_fx", 0);
  self ghost();
  self notsolid();
  playsoundatposition(#"zmb_hellhound_explode", self.origin);
}

private function_69c3e2ac() {
  self.hasseenfavoriteenemy = isDefined(self.enemy_override) || isDefined(self.favoriteenemy);
}

private function_30a35f51() {
  return true;
}

bb_getshouldrunstatus() {

  if(isDefined(self.ispuppet) && self.ispuppet) {
    return "<dev string:x38>";
  }

    if(isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint") || getdvarint(#"survival_prototype", 0) && isDefined(self.current_state) && self.current_state.name === #"chase") {
      return "run";
    }

  return "walk";
}

bb_getshouldhowlstatus() {
  if(self ai::has_behavior_attribute("howl_chance") && isDefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy) {
    if(!isDefined(self.shouldhowl)) {
      chance = self ai::get_behavior_attribute("howl_chance");
      self.shouldhowl = randomfloat(1) <= chance;
    }

    return (self.shouldhowl ? "howl" : "dont_howl");
  }

  return "dont_howl";
}

zombiedogshouldwalk(behaviortreeentity) {
  return bb_getshouldrunstatus() == "walk";
}

zombiedogshouldrun(behaviortreeentity) {
  return bb_getshouldrunstatus() == "run";
}

function_5bac75b6(behaviortreeentity) {
  return isDefined(self.var_8a96267d) && self.var_8a96267d;
}

function_4cc712c8(behaviortreeentity) {
  return isDefined(self.var_8ba6ede3) && self.var_8ba6ede3;
}

use_low_attack() {
  if(!isDefined(self.enemy) || !isplayer(self.enemy)) {
    return false;
  }

  height_diff = self.enemy.origin[2] - self.origin[2];
  low_enough = 30;

  if(height_diff < low_enough && self.enemy getstance() == "prone") {
    return true;
  }

  melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
  enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);

  if(!bullettracepassed(melee_origin, enemy_origin, 0, self)) {
    return true;
  }

  return false;
}

zombiedogmeleeaction(behaviortreeentity, asmstatename) {
  behaviortreeentity clearpath();
  context = "high";

  if(behaviortreeentity use_low_attack()) {
    context = "low";
  }

  behaviortreeentity setblackboardattribute("_context", context);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
  behaviortreeentity setblackboardattribute("_context", undefined);
  return 4;
}

function_648f6c9b(behaviortreeentity) {
  behaviortreeentity.var_8a96267d = undefined;
  behaviortreeentity clientfield::set("dog_fx", 0);
  behaviortreeentity ghost();
  behaviortreeentity notsolid();
  behaviortreeentity pathmode("dont move", 1);
  playsoundatposition(#"zmb_hellhound_explode", behaviortreeentity.origin);
}

function_a5c4f83b(behaviortreeentity) {
  behaviortreeentity notify(#"is_underground");
}

function_47e1bdeb(behaviortreeentity) {
  behaviortreeentity solid();
  behaviortreeentity.var_8ba6ede3 = undefined;
}

function_a5103696(behaviortreeentity) {
  behaviortreeentity thread function_1980a07a(behaviortreeentity);
}

private function_1980a07a(behaviortreeentity) {
  behaviortreeentity endon(#"death");
  behaviortreeentity zombiedogintro();
  behaviortreeentity pathmode("move allowed");
  behaviortreeentity.var_8ba6ede3 = undefined;
  behaviortreeentity notify(#"not_underground");
}

private function_90dbd41(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity clientfield::increment("dog_spawn_fx");
  entity ghost();
  entity notsolid();
}

private function_2fa3612a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}

private function_1f51eea3(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity dontinterpolate();
  entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
  entity clientfield::increment("dog_spawn_fx");
  entity show();
  entity solid();
}

function_6c308e81() {
  self thread play_ambient_zombie_vocals();
  self thread zmbaivox_playdeath();
}

play_ambient_zombie_vocals() {
  self endon(#"death");

  while(true) {
    type = "ambient";
    float = 3;

    if(bb_getshouldrunstatus() == "walk") {
      type = "ambient";
      float = 5;
    } else if(bb_getshouldrunstatus() == "run") {
      type = "sprint";
      float = 3;
    }

    bhtnactionstartevent(self, type);
    self notify(#"bhtn_action_notify", {
      #action: type
    });
    wait randomfloatrange(1.5, float);
  }
}

zmbaivox_playdeath() {
  self endon(#"disconnect");
  self waittill(#"death");

  if(isDefined(self)) {
    self notify(#"bhtn_action_notify", "death");
  }
}