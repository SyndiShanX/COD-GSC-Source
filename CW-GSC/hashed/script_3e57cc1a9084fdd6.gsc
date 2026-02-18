/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3e57cc1a9084fdd6.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\ai\zm_ai_dog;
#using scripts\zm_common\ai\zombie_dog_toxic_cloud;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_ec0691f8;

function private autoexec __init__system__() {
  system::register(#"hash_4863f776a30a1247", &function_d29d4c99, undefined, undefined, undefined);
}

function function_d29d4c99() {
  clientfield::register("actor", "sr_dog_pre_spawn_fx", 1, 1, "counter");
  clientfield::register("actor", "sr_dog_spawn_fx", 1, 1, "counter");
  clientfield::register("actor", "sr_dog_fx", 1, 1, "int");
  registerbehaviorscriptfunctions();

  if(zm_utility::is_survival()) {
    spawner::add_archetype_spawn_function(#"zombie_dog", &function_51d21736);
    spawner::add_archetype_spawn_function(#"zombie_dog", &function_26a59150);
    spawner::function_89a2cd87(#"zombie_dog", &function_e79ec851);
  }
}

function private function_cef412a7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(is_true(level.var_85a39c96)) {
    damagefromunderneath = self.health + 1;
  }

  if(isDefined(psoffsettime) && !util::function_fbce7263(self.team, psoffsettime.team)) {
    return 0;
  }

  if(isDefined(partname) && modelindex !== "MOD_DOT") {
    dot_params = function_f74d2943(partname, 7);

    if(isDefined(dot_params)) {
      status_effect::status_effect_apply(dot_params, partname, shitloc);
    }
  }

  if(isDefined(shitloc) && !isDefined(self.attackable) && isDefined(shitloc.var_b79a8ac7) && isarray(shitloc.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, partname)) {
    if(shitloc namespace_85745671::get_attackable_slot(self)) {
      self.attackable = shitloc;
    }
  }

  if(is_true(level.is_survival) && !isDefined(self.enemy_override) && !isDefined(self.favoriteenemy) && isDefined(psoffsettime) && isPlayer(psoffsettime)) {
    if(isDefined(modelindex) && (modelindex == "MOD_MELEE" || modelindex == "MOD_MELEE_WEAPON_BUTT") || isDefined(partname) && partname.statname === # "hatchet") {
      n_radius = 512;
    } else {
      n_radius = 2048;
    }

    awareness::function_e732359c(1, self.origin, n_radius, self, {
      #position: psoffsettime.origin
    });
  }

  return damagefromunderneath;
}

function function_51d21736() {
  self.ai.var_870d0893 = 1;
  self callback::function_d8abfc3d(#"on_ai_melee", &namespace_85745671::zombie_on_melee);
  self callback::function_d8abfc3d(#"hash_45b50cc48ee7f9d8", &function_69c3e2ac);
  self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &namespace_85745671::function_16e2f075);
  self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &namespace_85745671::function_5cb3181e);
  self callback::function_d8abfc3d(#"hash_790882ac8688cee5", &function_2272dcba);
  self callback::function_d8abfc3d(#"on_dog_killed", &on_dog_killed);
  aiutility::addaioverridedamagecallback(self, &function_cef412a7);

  if(self.subarchetype === # "hash_2a5479b83161cb35") {
    self.var_12af7864 = 1;
  }

  self.var_65e57a10 = 1;
  self.cant_move_cb = &function_9c573bc6;
  self.var_31a789c0 = 1;
  self.var_1c0eb62a = 180;
  self.var_13138acf = 1;
  self.var_cbc65493 = 1.5;
  self.var_a9db7324 = 4;
  self.var_f1b4d6d3 = 1;
  self.var_6daa6190 = 1;
  self.var_c50d964 = 35;
  self.var_721a3dbd = 1;
  self.var_28621cf4 = "j_spine3";
  self.var_e5365d8a = (0, 0, 3);
  self.completed_emerging_into_playable_area = 1;
  self.canbetargetedbyturnedzombies = 1;
}

function function_26a59150() {
  self.var_b3c613a7 = [1, 1, 1, 1, 1];
  self.var_414bc881 = 0.5;
}

function function_e79ec851() {
  function_c2400b01();
}

function function_2272dcba(params) {}

function private function_9c573bc6(entity) {
  self notify("5c2a82620d7bf511");
  self endon("77ae64c1f0aa89ae", #"death");

  if(isDefined(self.enemy_override)) {
    return;
  }

  self collidewithactors(0);
  wait 2;
  self collidewithactors(1);
}

function function_c2400b01() {
  self endon(#"death");
  self.has_awareness = 1;
  self.ignorelaststandplayers = 1;
  self.var_1267fdea = 1;
  self callback::function_d8abfc3d(#"on_ai_damage", &awareness::function_5f511313);
  self callback::function_d8abfc3d(#"hash_4afe635f36531659", &awareness::function_c6b1009e);
  awareness::register_state(self, #"wander", &function_9f9d7a80, &awareness::function_4ebe4a6d, &awareness::function_b264a0bc, undefined, &awareness::function_555d960b);
  awareness::register_state(self, #"investigate", &function_461711c2, &awareness::function_9eefc327, &function_2114b12b, undefined, &awareness::function_a360dd00);

  if(self.subarchetype === # "hash_28e36e7b7d5421f") {
    awareness::register_state(self, #"chase", &function_6f207918, &function_d005c417, &function_cf29908a, &awareness::function_5c40e824, undefined);
  } else {
    awareness::register_state(self, #"chase", &function_6f207918, &zm_ai_dog::function_90da9686, &function_cf29908a, &awareness::function_5c40e824, undefined);
  }

  awareness::set_state(self, #"wander");
  self thread awareness::function_c6b1009e();
  self thread awareness::function_fa6e010d();
}

function private function_9f9d7a80(entity) {
  entity.fovcosine = 0.5;
  entity.maxsightdistsqrd = sqr(1400);
  entity.var_1267fdea = 0;
  entity namespace_85745671::function_9758722(#"walk");
  self.var_6daa6190 = 1;
  awareness::function_9c9d96b5(entity);
}

function private function_461711c2(entity) {
  entity.fovcosine = 0;
  entity.maxsightdistsqrd = sqr(2000);
  entity.var_1267fdea = 0;
  util::delay(randomfloatrange(0.1, 1), "state_changed", &namespace_85745671::function_9758722, #"run");
  awareness::function_b41f0471(entity);
}

function private function_2114b12b(entity) {
  awareness::function_34162a25(entity);
}

function private function_6f207918(entity) {
  entity.fovcosine = 0;
  entity.maxsightdistsqrd = sqr(3000);
  entity.var_1267fdea = 0;
  self namespace_85745671::function_9758722(#"super_sprint");
  awareness::function_978025e4(entity);
}

function private function_cf29908a(entity) {
  awareness::function_b9f81e8b(entity);
}

function registerbehaviorscriptfunctions() {
  spawner::add_archetype_spawn_function(#"zombie_dog", &archetypezombiedogblackboardinit);
  assert(isscriptfunctionptr(&function_5bac75b6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77ab4b89c5221f6a", &function_5bac75b6);
  assert(isscriptfunctionptr(&function_4cc712c8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6125f61af86f0b68", &function_4cc712c8);
  assert(isscriptfunctionptr(&function_e393f5fe));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_105b4f2a2302e4fc", &function_e393f5fe);
  assert(isscriptfunctionptr(&function_80f985a4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_39dff89e44839780", &function_80f985a4);
  assert(isscriptfunctionptr(&function_47e1bdeb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_17b0ff54092cd3bd", &function_47e1bdeb);
  assert(isscriptfunctionptr(&function_a5103696));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_741bad83e4d39bf2", &function_a5103696);
  assert(isscriptfunctionptr(&function_648f6c9b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5dacd9fb020cb77b", &function_648f6c9b);
  assert(isscriptfunctionptr(&function_a5c4f83b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c24ff85e2293300", &function_a5c4f83b);
  animationstatenetwork::registeranimationmocomp("mocomp_dog_lightning_teleport", &function_90dbd41, &function_2fa3612a, &function_1f51eea3);
  animationstatenetwork::registernotetrackhandlerfunction("zombie_dog_death_vocal", &function_6f24d732);
  animationstatenetwork::registernotetrackhandlerfunction("show_hound", &function_2705e687);
}

function archetypezombiedogblackboardinit() {
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
}

function private archetypezombiedogonanimscriptedcallback(entity) {
  entity.__blackboard = undefined;
  entity archetypezombiedogblackboardinit();
}

function private function_2705e687(entity) {
  entity endon(#"death");
  earthquake(0.5, 0.75, self.origin, 1000);

  if(isDefined(self.favoriteenemy)) {
    angle = vectortoangles(self.favoriteenemy.origin - self.origin);
    angles = (self.angles[0], angle[1], self.angles[2]);
  } else {
    angles = self.angles;
  }

  self dontinterpolate();
  self forceteleport(self.origin, angles);
  self clientfield::increment("sr_dog_spawn_fx");
  self val::reset(#"dog_spawn", "takedamage");
  wait 0.1;
  self show();
  self setfreecameralockonallowed(1);
  self val::reset(#"dog_spawn", "ignoreme");
  self pathmode("move allowed");
  self clientfield::set("sr_dog_fx", 1);
}

function private function_6f24d732(params) {
  self clientfield::set("sndAwarenessChange", 0);

  if(self.subarchetype === # "hash_2a5479b83161cb35") {
    self playSound(#"hash_6e603d5f1970365b");
    return;
  }

  self playSound(#"hash_120ccc6f833fa6dc");
}

function private on_dog_killed(params) {
  if(!isDefined(self.subarchetype)) {
    blast_radius = 150;
    var_83f35abe = 20;
    var_6927cfa0 = 1;

    if(zm_utility::is_survival()) {
      blast_radius = 100;
      var_83f35abe = 5;
    }

    radiusdamage(self.origin + (0, 0, 18), blast_radius, var_83f35abe, var_6927cfa0, undefined, "MOD_PROJECTILE_SPLASH");
    self clientfield::set("sr_dog_fx", 0);
    self ghost();
    self notsolid();
    playsoundatposition(#"zmb_hellhound_explode", self.origin);
  }

  if(zm_ai_dog::function_a82712bc(self)) {
    function_2bf6dd1c(self);
  }

  self.var_7a68cd0c = 1;
}

function private function_69c3e2ac() {
  self.hasseenfavoriteenemy = isDefined(self.enemy_override) || isDefined(self.favoriteenemy);
}

function bb_getshouldhowlstatus() {
  if(self ai::has_behavior_attribute("howl_chance") && is_true(self.hasseenfavoriteenemy)) {
    if(!isDefined(self.shouldhowl)) {
      chance = self ai::get_behavior_attribute("howl_chance");
      self.shouldhowl = randomfloat(1) <= chance;
    }

    return (self.shouldhowl ? "howl" : "dont_howl");
  }

  return "dont_howl";
}

function function_5bac75b6(behaviortreeentity) {
  return is_true(self.var_8a96267d);
}

function function_4cc712c8(behaviortreeentity) {
  return is_true(self.var_8ba6ede3);
}

function function_e393f5fe(behaviortreeentity) {
  enemy = behaviortreeentity.favoriteenemy;

  if(isPlayer(enemy) && util::within_fov(enemy getplayercamerapos(), enemy getplayerangles(), behaviortreeentity.origin, 0.5)) {
    behaviortreeentity setblackboardattribute("_dog_jump_explode", 1);
  }

  return true;
}

function function_80f985a4(behaviortreeentity) {
  if(behaviortreeentity.subarchetype === # "hash_2a5479b83161cb35") {
    return true;
  }

  return false;
}

function function_2bf6dd1c(entity) {
  barricade = entity.var_597f08bf;

  if(isDefined(barricade)) {
    playFX(#"hash_215c503e2406cf77", barricade.origin);
    barricade notify(#"hash_5cfbbb6ee8378665");
    return 1;
  }
}

function use_low_attack() {
  if(!isDefined(self.enemy) || !isPlayer(self.enemy)) {
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

function function_648f6c9b(behaviortreeentity) {
  behaviortreeentity.var_8a96267d = undefined;
  behaviortreeentity clientfield::set("sr_dog_fx", 0);
  behaviortreeentity ghost();
  behaviortreeentity notsolid();
  behaviortreeentity pathmode("dont move", 1);
  playsoundatposition(#"zmb_hellhound_explode", behaviortreeentity.origin);
}

function function_a5c4f83b(behaviortreeentity) {
  behaviortreeentity notify(#"is_underground");
}

function function_47e1bdeb(behaviortreeentity) {
  behaviortreeentity solid();
  behaviortreeentity.var_8ba6ede3 = undefined;
}

function function_a5103696(behaviortreeentity) {
  behaviortreeentity thread function_1980a07a(behaviortreeentity);
}

function private function_1980a07a(behaviortreeentity) {
  behaviortreeentity endon(#"death");
  behaviortreeentity pathmode("move allowed");
  behaviortreeentity.var_8ba6ede3 = undefined;
  behaviortreeentity notify(#"not_underground");
}

function private function_90dbd41(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration clientfield::increment("sr_dog_spawn_fx");
  mocompduration ghost();
  mocompduration notsolid();
}

function private function_2fa3612a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {}

function private function_1f51eea3(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration dontinterpolate();
  mocompduration forceteleport(mocompduration.traverseendnode.origin, mocompduration.traverseendnode.angles, 0);
  mocompduration clientfield::increment("sr_dog_spawn_fx");
  mocompduration show();
  mocompduration solid();
}

function function_d005c417(entity) {
  if(is_true(entity.var_1fa24724)) {
    if(!isPlayer(entity.enemy) || float(gettime() - entity.enemy.var_dbb28b34) / 1000 > 5) {
      entity.var_6324ed63 = undefined;
    }

    if(isDefined(entity.origin)) {
      goal = getclosestpointonnavmesh(entity.origin, 2 * 39.3701, entity getpathfindingradius() * 1.2);
    }

    if(isDefined(level.var_d1a2ae79)) {
      var_8d66aa5c = [[level.var_d1a2ae79]](self, goal);

      if(isDefined(var_8d66aa5c)) {
        goal = var_8d66aa5c;
      }
    }

    if(isDefined(goal)) {
      entity setgoal(goal);
    } else {
      entity setgoal(self.origin);
    }
  }

  if(!isDefined(entity.enemy_override) && !isDefined(entity.attackable) && !awareness::function_2bc424fd(entity, entity.enemy)) {
    awareness::set_state(entity, #"wander");
    return;
  }

  if(isDefined(entity.var_b238ef38) && isDefined(entity.var_b238ef38.position) && is_true(entity.var_b238ef38.slot.on_navmesh)) {
    entity namespace_e292b080::zombieupdategoal(entity.var_b238ef38.position);
    return;
  }

  if(isDefined(entity.enemy_override)) {
    goal = getclosestpointonnavmesh(entity.enemy_override.origin, 200, entity getpathfindingradius() * 1.2);

    if(isDefined(goal)) {
      entity setgoal(goal);
      entity namespace_e292b080::zombieupdategoal(goal);
      return;
    }
  }

  if(isDefined(entity.favoriteenemy)) {
    if(isentity(entity) && isentity(entity.enemy)) {
      lastknownpos = entity lastknownpos(entity.enemy);
    }

    if(isDefined(lastknownpos)) {
      in_vehicle = isDefined(entity.favoriteenemy) && isPlayer(entity.favoriteenemy) && entity.favoriteenemy isinvehicle();

      if(in_vehicle) {
        lastknownpos = namespace_85745671::function_401070dd();
      }

      if(isvec(lastknownpos)) {
        goal = getclosestpointonnavmesh(lastknownpos, 200, entity getpathfindingradius() * 1.2);
      }

      if(isvec(goal)) {
        entity namespace_e292b080::zombieupdategoal(goal);
      }
    }

    return;
  }

  if(isvec(entity.origin)) {
    goal = getclosestpointonnavmesh(entity.origin, 200, entity getpathfindingradius() * 1.2);

    if(isDefined(goal)) {
      entity namespace_e292b080::zombieupdategoal(goal);
      return;
    }

    entity setgoal(self.origin);
  }
}