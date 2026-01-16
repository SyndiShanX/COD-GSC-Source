/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_ai_blight_father.gsc
*******************************************************/

#include script_2c5daa95f8fec03c;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\gametypes\ct_ai_zombie;

#namespace ct_ai_blight_father;

autoexec __init__system__() {
  system::register(#"ct_ai_blight_father", &__init__, undefined, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"blight_father", &function_7c52f40);
  spawner::function_89a2cd87(#"blight_father", &function_95a6fbef);
  callback::on_spawned(&on_player_spawned);
  clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter");
  clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter");
  clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int");
  clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int");
  clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int");
  clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter");
  clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int");

  if(true) {
    level.var_445e24c8 = [];

    for(i = 0; i < 12; i++) {
      trigger = spawn("trigger_damage", (0, 0, 0), 0, 40, 40);
      trigger enablelinkto();
      trigger.inuse = 0;
      trigger triggerenable(0);

      if(!isDefined(level.var_445e24c8)) {
        level.var_445e24c8 = [];
      } else if(!isarray(level.var_445e24c8)) {
        level.var_445e24c8 = array(level.var_445e24c8);
      }

      level.var_445e24c8[level.var_445e24c8.size] = trigger;
    }
  }

  level.var_c2981ce9 = [#"tag_mouth_weakspot":&function_fa7c080, #"tag_elbow_weakspot_le":&function_9bbe631c, #"tag_elbow_weakspot_ri":&function_5a1a4ad, #"tag_eggsack_weakspot_le":&function_40034805, #"tag_eggsack_weakspot_ri":&function_33b2c99e];
}

private on_player_spawned() {
  self.grapple_tag = "j_mainroot";
}

private function_7c52f40() {
  self endon(#"death");
  self.var_ef46cd4 = #"zombie_e1_itemlist";
  self.clamptonavmesh = 0;
  self.ignorepathenemyfightdist = 1;
  self.var_bb185cc5 = 0;
  self.var_1c0eb62a = 180;
  self.var_737e8510 = 128;
  self mp_ai_zombie::function_9758722("walk");
  self thread mp_ai_zombie::function_6c308e81();
  self thread mp_ai_zombie::function_e261b81d();
  self.maxhealth = level.startinghealth;
  self.health = self.maxhealth;
  self.var_5ee91cf = gettime() + 10000;
  self.zombie_move_speed = "sprint";
  self.var_f46fbf3f = 1;
  self.var_2703428f = self ai::function_9139c839().var_fc5eff78;
  self attach("c_t8_zmb_blightfather_mouth_noreveal");
  self attach("c_t8_zmb_blightfather_elbow1_le_noreveal");
  self attach("c_t8_zmb_blightfather_elbow1_ri_noreveal");
  self attach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  aiutility::addaioverridedamagecallback(self, &function_afce1cf);
  self.var_c8088bcb = {
    #traces: [], 
    #timestamp: gettime()
  };
  self.var_b2a80abc = gettime() + self ai::function_9139c839().var_f246f6de;
  self.ignorepathenemyfightdist = 1;

  if(!isDefined(self.var_506922ab)) {
    self.var_506922ab = [];
  }

  if(!isDefined(self.var_506922ab)) {
    self.var_506922ab = [];
  } else if(!isarray(self.var_506922ab)) {
    self.var_506922ab = array(self.var_506922ab);
  }

  self.var_506922ab[self.var_506922ab.size] = &function_36b05ed0;
  self allowpitchangle(1);
  self setpitchorient();
  self collidewithactors(1);

  if(!isDefined(level.var_6213dc32)) {
    level.var_6213dc32 = getweapon("zombie_ai_defaultmelee");
  }

  self callback::function_d8abfc3d(#"hash_45b50cc48ee7f9d8", &function_4b103bc4);
  self hide();
  self.var_8ba6ede3 = 1;
  util::wait_network_frame();
  self clientfield::set("blight_father_weakpoint_l_elbow_fx", 1);
  self clientfield::set("blight_father_weakpoint_r_elbow_fx", 1);
  self clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 1);
  self clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 1);
  self clientfield::set("blight_father_weakpoint_jaw_fx", 1);
  self clientfield::set("blight_father_amb_sac_clientfield", 1);
  target_set(self);
}

private function_95a6fbef() {
  self.maxhealth = 900;
  self.health = self.maxhealth;
  namespace_81245006::initweakpoints(self, #"c_t8_wz_blightfather_weakpoint_def");
  self show();
  self showallparts();
}

private function_36b05ed0(entity) {
  entity.var_fbec06fa = undefined;
  entity.knockdown = undefined;
}

private killed_callback(e_attacker) {
  if(self.archetype != #"blight_father") {
    return;
  }

  self clientfield::set("blight_father_amb_sac_clientfield", 0);
}

function_ee833cd6() {
  self.completed_emerging_into_playable_area = 1;
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_8383fdf9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73649a2d01c11f41", &function_8383fdf9);
  assert(isscriptfunctionptr(&blightfathershouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldshowpain", &blightfathershouldshowpain);
  assert(isscriptfunctionptr(&function_3515ad4b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_41aa80b14334caac", &function_3515ad4b);
  assert(isscriptfunctionptr(&function_abfcd61e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40ced68ca68094d7", &function_abfcd61e);
  assert(isscriptfunctionptr(&function_30f3bb2c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7767c66e27990a60", &function_30f3bb2c);
  assert(isscriptfunctionptr(&blightfathershouldspawn));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldspawn", &blightfathershouldspawn);
  assert(isscriptfunctionptr(&function_a2155a63));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d6c2aa71a2d55cf", &function_a2155a63);
  assert(isscriptfunctionptr(&blightfatherdeathstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherdeathstart", &blightfatherdeathstart);
  assert(isscriptfunctionptr(&function_d5a0a1eb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1db7e3af327c9b04", &function_d5a0a1eb);
  assert(isscriptfunctionptr(&function_e0d8f770));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7817d265f22976fd", &function_e0d8f770);
  assert(isscriptfunctionptr(&function_283b9654));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3598ca6c9a0b1b1", &function_283b9654);
  assert(isscriptfunctionptr(&function_173d7fb2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4913708f18cd3e3e", &function_173d7fb2);
  assert(isscriptfunctionptr(&function_8d9b9683));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77b88d91d0990898", &function_8d9b9683);
  assert(isscriptfunctionptr(&function_d83ac1e7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e5059e0839da879", &function_d83ac1e7);
  assert(isscriptfunctionptr(&blightfatherspawnstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherspawnstart", &blightfatherspawnstart);
  assert(isscriptfunctionptr(&function_819f6f9d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_71909144f263d807", &function_819f6f9d);
  assert(isscriptfunctionptr(&function_87d42d96));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5906b38f80513efb", &function_87d42d96);
  assert(isscriptfunctionptr(&function_af7555b9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7429af10c7fbf280", &function_af7555b9);
  assert(isscriptfunctionptr(&function_2e8ab165));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2be380c82a777611", &function_2e8ab165);
  assert(isscriptfunctionptr(&function_8c813f66));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a311ecee563e7b8", &function_8c813f66);
  assert(isscriptfunctionptr(&zombieshouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
  assert(isscriptfunctionptr(&function_c3116eee));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5a914a87313bbbee", &function_c3116eee, 1);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_fa33f4aa) || isscriptfunctionptr(&function_fa33f4aa));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7b6603199659e6ff", undefined, &function_fa33f4aa, undefined);
  animationstatenetwork::registernotetrackhandlerfunction("fire_left", &function_d2b91209);
  animationstatenetwork::registernotetrackhandlerfunction("fire_right", &function_78f5c48e);
  animationstatenetwork::registernotetrackhandlerfunction("blight_father_melee", &function_ac921de9);
  animationstatenetwork::registernotetrackhandlerfunction("blightfather_explode", &function_b78adc65);
  assert(isscriptfunctionptr(&function_f2914d65));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_116b298d64ab0478", &function_f2914d65);
}

function_30f3bb2c(entity) {
  return isDefined(entity.var_8a96267d) && entity.var_8a96267d;
}

function_87d42d96(entity) {
  entity.var_8a96267d = undefined;
  entity pathmode("dont move", 1);
}

function_af7555b9(entity) {
  entity ghost();
  entity notsolid();
  entity clientfield::set("zombie_riser_fx", 0);
  entity notify(#"is_screamed");
  return true;
}

blightfathershouldspawn(entity) {
  return isDefined(entity.var_8ba6ede3) && entity.var_8ba6ede3;
}

blightfatherspawnstart(entity) {
  entity solid();
  entity clientfield::set("zombie_riser_fx", 1);
  entity.var_8ba6ede3 = undefined;
}

function_819f6f9d(entity) {
  entity clientfield::set("zombie_riser_fx", 0);
  entity pathmode("move allowed");
  entity notify(#"not_underground");
}

function_a2155a63(entity) {
  return false;
}

zombieshouldstun(behaviortreeentity) {
  return behaviortreeentity ai::is_stunned();
}

zombieshouldknockdown(behaviortreeentity) {
  if(isDefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown) {
    return true;
  }

  return false;
}

function_b78adc65(entity) {
  if(entity isragdoll()) {
    if(entity isattached("c_t8_zmb_blightfather_eggsack1_both_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
      return;
    }

    if(entity isattached("c_t8_zmb_blightfather_eggsack1_le_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
      return;
    }

    if(entity isattached("c_t8_zmb_blightfather_eggsack1_ri_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
    }

    return;
  }

  if(isDefined(entity.gib_model)) {
    entity.gib_model clientfield::set("blight_father_gib_explosion", 1);
    entity.gib_model stopanimscripted(0, 1);
    entity.gib_model startragdoll();
  }

  entity delete();
}

private function_529b7fb9() {
  self endon(#"death");
  level waittilltimeout(300, #"clear_all_corpses");

  if(isDefined(self)) {
    self delete();
  }
}

function_4589bd24() {
  if(isDefined(self.favoriteenemy)) {
    predictedpos = self lastknownpos(self.favoriteenemy);

    if(isDefined(predictedpos)) {
      turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
      return turnyaw;
    }
  }

  return undefined;
}

function_753b4884() {
  return undefined;
}

private function_f2914d65(entity) {
  enemies = getaiarchetypearray(#"zombie");
  enemies = arraycombine(enemies, getaiarchetypearray(#"catalyst"), 0, 0);
  enemies = array::filter(enemies, 0, &function_3d752709, entity);

  foreach(enemy in enemies) {
    enemy.knockdown_type = "knockdown_shoved";
  }
}

private function_3d752709(enemy, target) {
  if(isDefined(enemy.knockdown) && enemy.knockdown) {
    return false;
  }

  if(gibserverutils::isgibbed(enemy, 384)) {
    return false;
  }

  if(distancesquared(enemy.origin, target.origin) > self ai::function_9139c839().var_2e53b0a6 * self ai::function_9139c839().var_2e53b0a6) {
    return false;
  }

  facingvec = anglesToForward(target.angles);
  enemyvec = enemy.origin - target.origin;
  var_3e3c8075 = (enemyvec[0], enemyvec[1], 0);
  var_c2ee8451 = (facingvec[0], facingvec[1], 0);
  var_3e3c8075 = vectornormalize(var_3e3c8075);
  var_c2ee8451 = vectornormalize(var_c2ee8451);
  enemydot = vectordot(var_c2ee8451, var_3e3c8075);

  if(enemydot < 0) {
    return false;
  }

  return true;
}

private blightfathershouldshowpain(entity) {
  if(isDefined(entity.var_fbec06fa)) {
    return true;
  }

  return false;
}

private function_8d9b9683(entity) {
  function_173d7fb2(entity);
}

private function_3515ad4b(entity) {
  return blightfathershouldshowpain(entity);
}

private function_173d7fb2(entity) {
  entity.var_fbec06fa = undefined;
}

private blightfatherdeathstart(entity) {
  entity val::set(#"blight_father_death", "takedamage", 0);

  if(level.var_79b2615b === entity) {
    level.var_79b2615b = undefined;
  }

  if(!entity isragdoll()) {
    gib_model = util::spawn_anim_model("c_t8_zmb_blightfather_body1_gib", entity.origin, entity.angles);

    if(!isDefined(gib_model)) {
      return;
    }

    gib_model animscripted(#"hash_56a346d1e0dd61cd", gib_model.origin, gib_model.angles, #"hash_3e937fff0e0a4362", "normal");
    gib_model thread function_529b7fb9();
    entity.gib_model = gib_model;
  }
}

private function_ac921de9(entity) {
  meleerange = entity ai::function_9139c839().var_558fb394;
  meleerangesq = meleerange * meleerange;
  potential_players = [];

  foreach(player in getplayers()) {
    if(meleerangesq < distancesquared(entity.origin, player.origin)) {
      continue;
    }

    if(!isDefined(potential_players)) {
      potential_players = [];
    } else if(!isarray(potential_players)) {
      potential_players = array(potential_players);
    }

    if(!isinarray(potential_players, player)) {
      potential_players[potential_players.size] = player;
    }
  }

  bhtnactionstartevent(entity, "attack_melee");
  registernotice_walla = anglesToForward(entity.angles);
  var_2f706708 = entity gettagorigin("j_spine4");
  var_9b246038 = entity ai::function_9139c839().var_4e8d4c24;

  foreach(player in potential_players) {
    vec_to_player = vectornormalize(player.origin - entity.origin);

    if(vectordot(vec_to_player, registernotice_walla) < var_9b246038) {
      continue;
    }

    if(bullettracepassed(var_2f706708, player getEye(), 0, entity)) {
      player dodamage(entity.meleeweapon.playerdamage, entity.origin, entity, entity, "none", "MOD_MELEE");
    }
  }

  if(isDefined(entity.attackable) && isDefined(entity.attackable.is_active) && entity.attackable.is_active) {
    if(isDefined(entity.is_at_attackable) && entity.is_at_attackable) {
      if(isDefined(level.attackablecallback)) {
        entity.attackable[[level.attackablecallback]](entity);
      }
    }
  }
}

private function_283b9654(entity) {}

private function_fa33f4aa(entity, asmstatename) {
  if(entity ai::is_stunned()) {
    return 5;
  }

  return 4;
}

private function_4b103bc4() {
  function_2e8ab165(self);
}

private function_abfcd61e(entity) {
  return entity.var_5ee91cf < gettime() && isDefined(self.isonnavmesh) && self.isonnavmesh && isDefined(self.favoriteenemy) && !(isDefined(entity.var_c8f98f87) && entity.var_c8f98f87);
}

private function_2e8ab165(entity) {
  entity.var_5ee91cf = gettime() + 10000;
}

private function_8c813f66(entity) {}

private function_d83ac1e7(entity) {}

private function_775f8cf2() {
  if(isDefined(self.var_177b7a47) && self.var_177b7a47) {
    return "left_sac_destroyed";
  }

  if(isDefined(self.var_7c54fb46) && self.var_7c54fb46) {
    return "right_sac_destroyed";
  }

  return undefined;
}

private function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity.var_2703428f--;
  entity destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
}

private function_fa7c080(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity.var_c8f98f87 = 1;
  entity.var_6ee32f47 = 1;
  entity clientfield::set("blight_father_weakpoint_jaw_fx", 0);
  entity attach("c_t8_zmb_blightfather_mouth_dmg1");
  entity.var_3acacb18 = undefined;
}

private function_9bbe631c(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity clientfield::set("blight_father_weakpoint_l_elbow_fx", 0);
}

private function_5a1a4ad(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity clientfield::set("blight_father_weakpoint_r_elbow_fx", 0);
}

private function_40034805(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity.var_177b7a47 = 1;
  entity clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 0);

  if(isDefined(entity.var_7c54fb46) && entity.var_7c54fb46) {
    entity detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
    return;
  }

  entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  entity attach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
}

private function_33b2c99e(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity.var_7c54fb46 = 1;
  entity clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 0);

  if(isDefined(entity.var_177b7a47) && entity.var_177b7a47) {
    entity detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
    return;
  }

  entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  entity attach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
}

private function_cacd1506(var_84ed9a13, entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(namespace_81245006::function_f29756fe(var_84ed9a13) != 1) {
    return;
  }

  namespace_81245006::damageweakpoint(var_84ed9a13, damage);
  inflictor thread function_6f109d76(self);

  if(namespace_81245006::function_f29756fe(var_84ed9a13) == 3) {
    if(isDefined(level.var_c2981ce9[var_84ed9a13.var_51e8b151])) {
      entity[[level.var_c2981ce9[var_84ed9a13.var_51e8b151]]](entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    }

    if(!entity isplayinganimscripted() && !entity.blockingpain) {
      entity.var_fbec06fa = var_84ed9a13.var_51e8b151;
      entity setblackboardattribute("_blight_father_weak_point", var_84ed9a13.var_51e8b151);
    }

    bone = boneindex;
    function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, bone, modelindex);
  }
}

function_6f109d76(ai) {}

function_422fdfd4(entity, attacker, weapon, var_5457dc44, hitloc, point, var_ebcb86d6, var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927) {
  var_8d3f5b7d = isalive(attacker) && isplayer(attacker);

  if(isDefined(var_ebcb86d6)) {
    var_84ed9a13 = var_ebcb86d6;
  } else {
    var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_37e3f011(entity, var_5457dc44);
    }

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
    }
  }

  registerzombie_bgb_used_reinforce = isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
  var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== #"armor";
  var_c6cc6205 = var_b85996d4;
  var_fff93f95 = var_159ce525;
  var_cee56a92 = var_ddd319d6;
  var_e008ecea = var_d2314927;

  if(!var_30362eca) {
    var_b1c1c5cf = isDefined(var_c6cc6205) ? var_c6cc6205 : entity ai::function_9139c839().damagescale;
  } else if(var_30362eca) {
    var_b1c1c5cf = isDefined(var_fff93f95) ? var_fff93f95 : entity ai::function_9139c839().weakpointdamagescale;
  }

  return {
    #damage_scale: var_b1c1c5cf, 
    #var_84ed9a13: var_84ed9a13, 
    #registerzombie_bgb_used_reinforce: registerzombie_bgb_used_reinforce
  };
}

private function_afce1cf(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;

  if(damage > 40) {
    damage = 40;
  }

  if(isDefined(entity.enemy) && isDefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle) {
    return 10;
  }

  var_786d7e06 = function_422fdfd4(entity, attacker, weapon, boneindex);
  damage_scale = var_786d7e06.damage_scale;
  var_84ed9a13 = var_786d7e06.var_84ed9a13;
  registerzombie_bgb_used_reinforce = var_786d7e06.registerzombie_bgb_used_reinforce;
  final_damage = int(damage * damage_scale);

  if(isDefined(var_84ed9a13) && registerzombie_bgb_used_reinforce) {
    function_cacd1506(var_84ed9a13, entity, inflictor, attacker, final_damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
  }

  if(entity.var_2703428f <= 0) {
    origin = entity.origin;

    if(isDefined(inflictor)) {
      origin = inflictor.origin;
    }

    entity kill(origin, attacker, inflictor, weapon, 0, 1);
    final_damage = 0;
  } else {
    final_damage *= 1 / entity.var_2703428f;
  }

  return final_damage;
}

private function_f9d9f198(entity) {
  var_bee929e7 = entity astsearch("grapple_attack_vomit@blight_father");
  animname = animationstatenetworkutility::searchanimationmap(entity, var_bee929e7[#"animation"]);
  tag_pos = getanimtagorigin(animname, 0, "tag_tongue");
  var_2db07c66 = rotatepoint(tag_pos, entity gettagangles("tag_origin"));
  var_2db07c66 += entity.origin;
  return var_2db07c66;
}

private function_5d7f8057(entity, player) {
  if(entity.var_c8088bcb.timestamp !== gettime()) {
    entity.var_c8088bcb.traces = [];
    entity.var_c8088bcb.timestamp = gettime();
  } else if(isDefined(entity.var_c8088bcb.traces[player getentitynumber()])) {
    return entity.var_c8088bcb.traces[player getentitynumber()];
  }

  clip_mask = 1 | 8;

  if(player haspart("j_mainroot")) {
    trace = physicstrace(entity.origin + (0, 0, 35), player gettagorigin("j_mainroot"), (-15, -15, -20), (15, 15, 40), entity, clip_mask);
  } else {
    trace = physicstrace(entity.origin + (0, 0, 35), player.origin, (-15, -15, -20), (15, 15, 40), entity, clip_mask);
  }

  entity.var_c8088bcb.traces[player getentitynumber()] = trace;
  return trace;
}

private function_c3116eee(entity) {
  if(function_8fe8a946(entity)) {
    entity.var_4678c6fa = 1;
  }
}

private function_37d1a803(entity) {
  return entity ai::function_9139c839().var_f246f6de;
}

private function_71b8279d(entity) {
  return isDefined(entity.var_6ee32f47) && entity.var_6ee32f47;
}

private function_63b7576d() {
  var_3c533fa2 = 0;

  foreach(trigger in level.var_445e24c8) {
    if(!trigger.inuse) {
      var_3c533fa2++;
    }
  }

  return var_3c533fa2;
}

private function_c48604c0() {
  foreach(trigger in level.var_445e24c8) {
    if(!trigger.inuse) {
      trigger.inuse = 1;
      trigger triggerenable(1);
      return trigger;
    }
  }

  return undefined;
}

private function_da2c4ce9(trigger) {
  trigger.inuse = 0;
  trigger triggerenable(0);
  trigger.origin = (0, 0, 0);
}

private function_8383fdf9(entity) {
  return isDefined(entity.var_4678c6fa) && entity.var_4678c6fa;
}

private function_8fe8a946(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }

  if(!isplayer(entity.favoriteenemy)) {
    return false;
  }

  if(isDefined(entity.var_177b7a47) && entity.var_177b7a47 && isDefined(entity.var_7c54fb46) && entity.var_7c54fb46) {
    return false;
  }

  if(isDefined(level.var_79b2615b) && level.var_79b2615b != entity && isalive(level.var_79b2615b)) {
    return false;
  }

  if(!function_71b8279d(entity) && entity.var_b2a80abc > gettime()) {
    return false;
  }

  var_d0651e10 = function_63b7576d();

  if(var_d0651e10 <= 0) {
    return false;
  } else if(!(isDefined(entity.var_177b7a47) && entity.var_177b7a47) && !(isDefined(entity.var_7c54fb46) && entity.var_7c54fb46) && var_d0651e10 < 3) {
    return false;
  }

  forward = anglesToForward(entity.angles);
  forward2d = vectornormalize((forward[0], forward[1], 0));
  dirtotarget = entity.favoriteenemy.origin - entity.origin;
  var_854904a = vectornormalize((dirtotarget[0], dirtotarget[1], 0));
  dot = vectordot(forward2d, var_854904a);

  if(dot < entity ai::function_9139c839().var_aa503e5a) {
    return false;
  }

  if(!(isDefined(entity.var_177b7a47) && entity.var_177b7a47)) {
    tracestart = entity gettagorigin("tag_sac_fx_le");
  } else {
    tracestart = entity gettagorigin("tag_sac_fx_ri");
  }

  if(!bullettracepassed(tracestart, self.favoriteenemy.origin + (0, 0, 35), 0, self)) {
    return false;
  }

  height = self.maxs[2] - self.mins[2];
  forward = anglesToForward(self.angles);
  var_725b8fb5 = forward * entity ai::function_9139c839().var_167cbf22;
  var_edabd3cd = bullettracepassed(self.origin + (0, 0, height), self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);

  recordline(self.origin + (0, 0, height), self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));

    if(!var_edabd3cd) {
      return false;
    }

  var_9c2b856b = distancesquared(entity.origin, entity.favoriteenemy.origin);

  if(var_9c2b856b < entity ai::function_9139c839().var_cdf6b76d * entity ai::function_9139c839().var_cdf6b76d || var_9c2b856b > entity ai::function_9139c839().var_652a36f2 * entity ai::function_9139c839().var_652a36f2) {
    return false;
  }

  return true;
}

private function_d5a0a1eb(entity) {
  entity clientfield::set("blight_father_amb_sac_clientfield", 0);
  entity.var_4678c6fa = undefined;
}

private function_e0d8f770(entity) {
  entity.var_b2a80abc = gettime() + function_37d1a803(entity);
  level.var_79b2615b = undefined;
  entity clientfield::set("blight_father_amb_sac_clientfield", 1);
}

private function_d2b91209(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    println("<dev string:x38>");
    return;
  }

  entity clientfield::increment("blight_father_spawn_maggot_fx_left");
  entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_le");
}

private function_78f5c48e(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    println("<dev string:x38>");
    return;
  }

  entity clientfield::increment("blight_father_spawn_maggot_fx_right");
  entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_ri");
}

private function_ebd22bba() {
  self endon(#"death");
  util::wait_network_frame();
  self clientfield::set("blight_father_maggot_trail_fx", 1);
}

private blightfatherlaunchchaosmissile(var_f794172e, var_61622673, var_f3486358) {
  var_ced3ec54 = self gettagorigin(var_f3486358);
  var_27e1ee12 = var_f794172e.origin + var_61622673;

  if(isDefined(self.var_6ee32f47) && self.var_6ee32f47) {
    self.var_6ee32f47 = 0;
  }

  var_892397fd = util::spawn_model(#"tag_origin", var_ced3ec54);
  var_a9494306 = function_c48604c0();
  var_a9494306.origin = var_892397fd.origin;
  var_a9494306.angles = var_892397fd.angles;
  var_a9494306 linkto(var_892397fd, "tag_origin");
  var_892397fd.trigger = var_a9494306;
  var_892397fd thread function_b2be1340(self ai::function_9139c839().var_a2519bb8);
  var_892397fd thread function_ebd22bba();
  var_892397fd thread function_a6a20b2c(var_a9494306);
  var_892397fd.var_f3d1c928 = 0;
  var_892397fd.var_52334e8c = self;
  angles_to_enemy = self gettagangles(var_f3486358);
  normal_vector = anglesToForward(angles_to_enemy);
  var_892397fd.angles = angles_to_enemy;
  var_892397fd.var_209ff2fa = normal_vector * self ai::function_9139c839().var_f988064f;
  max_trail_iterations = int(self ai::function_9139c839().var_652a36f2 / self ai::function_9139c839().var_52bddd4 * self ai::function_9139c839().var_9e5ebf3c);
  var_892397fd.missile_target = var_f794172e;
  var_892397fd thread function_5f3390fd(var_61622673, 60);
  var_892397fd playLoopSound(#"hash_5b21b7c645692f8", 0.1);
  var_892397fd moveto(self gettagorigin(var_f3486358) + var_61622673, self ai::function_9139c839().var_20c6e4ca);
  var_eb325a79 = self ai::function_9139c839().var_9e5ebf3c;
  var_b446b077 = self ai::function_9139c839().var_94fefe66;
  var_3fa92868 = self ai::function_9139c839().var_52bddd4;
  wait self ai::function_9139c839().var_20c6e4ca;

  while(isDefined(var_892397fd)) {
    if(var_892397fd.var_f3d1c928 >= max_trail_iterations) {
      var_892397fd thread function_124486ee(0);
    } else {
      var_892397fd function_1974d26f(var_3fa92868, var_b446b077, var_eb325a79);
      var_892397fd.var_f3d1c928 += 1;
    }

    wait var_eb325a79;
  }
}

function_a6a20b2c(var_3797b49d) {
  self waittill(#"death");
  var_3797b49d unlink();
  function_da2c4ce9(var_3797b49d);
}

function_b2be1340(starting_health) {
  self endon(#"detonated");
  self.n_health = starting_health;

  while(self.n_health > 0) {
    s_notify = self.trigger waittill(#"damage");

    if(isDefined(s_notify.attacker) && isplayer(s_notify.attacker) && s_notify.amount > 0) {
      self.n_health -= s_notify.amount;
    }
  }

  self thread function_124486ee(0);
}

private function_581a06c7(forward_dir, var_ced3ec54, var_27e1ee12, max_angle) {
  vec_to_enemy = var_27e1ee12 - var_ced3ec54;
  vec_to_enemy_normal = vectornormalize(vec_to_enemy);
  angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);

  if(angle_to_enemy >= max_angle) {
    return vec_to_enemy_normal;
  }

  plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
  perpendicular_normal = vectorcross(plane_normal, forward_dir);
  var_21f9edfd = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
  return var_21f9edfd;
}

private function_5f3390fd(var_61622673, var_4fee43d4) {
  self endon(#"death", #"detonated");
  var_892397fd = self;

  while(isDefined(var_892397fd)) {
    player_origins = [];
    players = getplayers();

    foreach(player in players) {
      if(!isDefined(player_origins)) {
        player_origins = [];
      } else if(!isarray(player_origins)) {
        player_origins = array(player_origins);
      }

      player_origins[player_origins.size] = player.origin + var_61622673;
    }

    players = arraysortclosest(player_origins, var_892397fd.origin, undefined, 0, var_4fee43d4);

    if(players.size > 0) {
      var_892397fd thread function_124486ee(0);
    }

    waitframe(1);
  }
}

private function_1974d26f(var_3fa92868, var_10ed5867, var_eb325a79) {
  self endon(#"detonated", #"death");

  if(!isDefined(self.var_3b8e09f5)) {
    self.var_3b8e09f5 = cos(var_10ed5867 * var_eb325a79);
  }

  if(isDefined(self.missile_target) && isDefined(self.var_209ff2fa)) {
    if(isplayer(self.missile_target) && isDefined(self.missile_target.usingvehicle) && self.missile_target.usingvehicle) {
      vehicle = self.missile_target getvehicleoccupied();
      var_6d0a510 = vehicle.origin;
    } else if(isplayer(self.missile_target)) {
      var_6d0a510 = self.missile_target getplayercamerapos();
    } else {
      var_6d0a510 = self.missile_target getcentroid();
    }

    vector_to_target = var_6d0a510 - self.origin;
    normal_vector = vectornormalize(vector_to_target);
    dot = vectordot(normal_vector, self.var_209ff2fa);

    if(dot >= 1) {
      dot = 1;
    } else if(dot <= -1) {
      dot = -1;
    }

    new_vector = normal_vector - self.var_209ff2fa;
    angle_between_vectors = acos(dot);

    if(!isDefined(angle_between_vectors)) {
      angle_between_vectors = 180;
    }

    if(angle_between_vectors == 0) {
      angle_between_vectors = 0.0001;
    }

    ratio = var_10ed5867 * var_eb325a79 / angle_between_vectors;

    if(ratio > 1) {
      ratio = 1;
    }

    new_vector *= ratio;
    new_vector += self.var_209ff2fa;
    normal_vector = vectornormalize(new_vector);
  } else {
    normal_vector = self.var_209ff2fa;
  }

  move_distance = var_3fa92868 * var_eb325a79;
  move_vector = var_3fa92868 * var_eb325a79 * normal_vector;
  move_to_point = self.origin + move_vector;
  trace = bulletTrace(self.origin, move_to_point, 0, self);

  if(trace[#"surfacetype"] !== "none") {
    detonate_point = trace[#"position"];
    dist_sq = distancesquared(detonate_point, self.origin);
    move_dist_sq = move_distance * move_distance;
    ratio = dist_sq / move_dist_sq;
    delay = ratio * var_eb325a79;
    self thread function_124486ee(delay);
  }

  self.var_209ff2fa = normal_vector;
  self moveto(move_to_point, var_eb325a79);
}

private function_124486ee(delay) {
  self endon(#"death");

  if(!isDefined(self)) {
    return;
  }

  var_892397fd = self;
  missile_owner = var_892397fd.var_52334e8c;
  blast_radius = 128;
  var_83f35abe = 45;
  var_6927cfa0 = 40;
  var_c45ef84c = 60 * 60;

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(var_892397fd)) {
    var_892397fd notify(#"detonated");
    var_892397fd moveto(var_892397fd.origin, 0.05);
    var_892397fd clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
    e_blightfather = var_892397fd.var_52334e8c;
    w_weapon = getweapon(#"none");
    var_892397fd function_8e8b1dfc(var_c45ef84c, e_blightfather, w_weapon);
    explosion_point = var_892397fd.origin;
    function_44e3e0d1(explosion_point + (0, 0, 18));
    util::wait_network_frame();
    radiusdamage(explosion_point + (0, 0, 18), blast_radius, var_83f35abe, var_6927cfa0, e_blightfather, "MOD_UNKNOWN", w_weapon);

    if(isDefined(var_892397fd)) {
      var_892397fd clientfield::set("blight_father_maggot_trail_fx", 0);
      var_892397fd delete();
    }
  }
}

private function_44e3e0d1(var_51a7ab9c) {
  players = getplayers();
  v_length = 100 * 100;

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

    if(isDefined(player.ignoreme) && player.ignoreme) {
      continue;
    }

    if(player isnotarget()) {
      continue;
    }

    n_distance = distance2dsquared(var_51a7ab9c, player.origin);

    if(n_distance < 0.01) {
      continue;
    }

    if(n_distance < v_length) {
      v_dir = player.origin - var_51a7ab9c;
      v_dir = (v_dir[0], v_dir[1], 0.1);
      v_dir = vectornormalize(v_dir);
      n_push_strength = getdvarint(#"hash_708ca0a943843f57", 500);
      n_push_strength = 200 + randomint(n_push_strength - 200);
      v_player_velocity = player getvelocity();
      player setvelocity(v_player_velocity + v_dir * n_push_strength);
    }
  }
}

private function_8e8b1dfc(var_c45ef84c, blight_father, weapon) {
  for(i = 0; i < level.activeplayers.size; i++) {
    if(!isDefined(level.activeplayers[i])) {
      continue;
    }

    distancesq = distancesquared(self.origin, level.activeplayers[i].origin + (0, 0, 5));

    if(distancesq > var_c45ef84c) {
      continue;
    }

    status_effect = getstatuseffect(#"hash_7867f8f9aaaa0c40");
    level.activeplayers[i] status_effect::status_effect_apply(status_effect, weapon, blight_father);
    level.activeplayers[i] clientfield::increment_to_player("blight_father_chaos_missile_rumble_clientfield", 1);
  }
}