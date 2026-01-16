/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_nosferatu.gsc
***********************************************/

#include script_1f0e83e43bf9c3b9;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_damage_utility;
#include scripts\core_common\ai\archetype_locomotion_utility;
#include scripts\core_common\ai\archetype_mocomps_utility;
#include scripts\core_common\ai\archetype_nosferatu;
#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\ai_blackboard;
#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai\systems\animation_state_machine_mocomp;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_state_machine;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\systems\blackboard;
#include scripts\core_common\ai\systems\debug;
#include scripts\core_common\ai\systems\destructible_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\powerup\zm_powerup_nuke;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_nosferatu;

autoexec __init__system__() {
  system::register(#"zm_ai_nosferatu", &__init__, &__main__, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
  init();
  level.nosferatu_spawn_func = &function_6502a84d;
  spawner::add_archetype_spawn_function(#"nosferatu", &function_c12f7b53);
  zm_cleanup::function_cdf5a512(#"nosferatu", &function_4c71848e);
  callback::on_player_damage(&function_8dc028ba);
  clientfield::register("toplayer", "nosferatu_damage_fx", 8000, 1, "counter");
  clientfield::register("actor", "nosferatu_spawn_fx", 8000, 1, "counter");
  clientfield::register("actor", "nfrtu_silver_hit_fx", 8000, 1, "counter");
  clientfield::register("actor", "summon_nfrtu", 8000, 1, "int");
  clientfield::register("actor", "nfrtu_move_dash", 8000, 1, "int");
  zm_score::function_e5d6e6dd(#"nosferatu", 60);
  zm_score::function_e5d6e6dd(#"crimson_nosferatu", 80);
  zm_round_spawning::register_archetype(#"nosferatu", &function_cf877849, &round_spawn, &function_74f25f8a, 25);
  zm_round_spawning::register_archetype(#"crimson_nosferatu", &function_97f1f86e, &function_a8a8c2fb, undefined, 100);
  zm_round_spawning::function_306ce518(#"crimson_nosferatu", &function_57abef39);
  level.var_243137e = getEntArray("zombie_nosferatu_spawner", "script_noteworthy");
  level.var_13bc407f = getEntArray("zombie_crimson_nosferatu_spawner", "script_noteworthy");

  zm_devgui::function_c7dd7a17("<dev string:x38>");

}

__main__() {}

init() {}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_7d874447));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a6e15c62c2e1958", &function_7d874447);
  assert(isscriptfunctionptr(&function_7fef620b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_258bd98449804a29", &function_7fef620b);
  assert(isscriptfunctionptr(&function_82785646));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50f7728355042178", &function_82785646);
  assert(isscriptfunctionptr(&nosferatustunstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"nosferatustunstart", &nosferatustunstart);
  assert(isscriptfunctionptr(&nosferatushouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"nosferatushouldstun", &nosferatushouldstun);
  assert(isscriptfunctionptr(&function_81c78981));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3a2582998db5774b", &function_81c78981);
  assert(isscriptfunctionptr(&function_475a698c));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3c518f78c393482e", &function_475a698c);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_344a0412) || isscriptfunctionptr(&function_344a0412));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4a2ea3c9e174122a", undefined, &function_344a0412, undefined);
  animationstatenetwork::registernotetrackhandlerfunction("summon_nfrtu", &function_76d6482e);
}

nosferatushouldstun(entity) {
  if(zm_behavior::zombieshouldstun(entity) && function_e060c994(entity)) {
    return true;
  }

  return false;
}

private function_e060c994(entity) {
  var_7a69f7e9 = blackboard::getblackboardevents("nfrtu_stun");

  if(isDefined(var_7a69f7e9) && var_7a69f7e9.size) {
    foreach(event in var_7a69f7e9) {
      if(event.nosferatu === entity) {
        return false;
      }
    }
  }

  return true;
}

nosferatustunstart(entity) {
  zm_behavior::zombiestunstart(entity);
  var_268f1415 = spawnStruct();
  var_268f1415.nosferatu = entity;
  blackboard::addblackboardevent("nfrtu_stun", var_268f1415, randomintrange(10000, 12000));
}

private function_344a0412(entity, asmstatename) {
  if(entity ai::is_stunned()) {
    return 5;
  }

  return 4;
}

function_81c78981(entity) {
  entity clientfield::set("nfrtu_move_dash", 1);
  return true;
}

function_475a698c(entity) {
  entity clientfield::set("nfrtu_move_dash", 0);
  return true;
}

private function_c12f7b53() {
  self.zombie_move_speed = "sprint";
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
  self.completed_emerging_into_playable_area = 1;
  self.ignorepathenemyfightdist = 1;
  var_eb297ead = zm_ai_utility::function_8d44707e(0);
  var_eb297ead *= isDefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1;
  self.health = int(var_eb297ead);
  self.maxhealth = int(var_eb297ead);
  self.is_zombie = 1;
  self.var_fad2bca9 = 1;
  self.var_ccb2e201 = 0;

  if(self.subarchetype === #"crimson_nosferatu") {
    self.var_dd6fe31f = 1;
    self.var_f46fbf3f = 1;
    self.var_126d7bef = 1;
    self.instakill_func = &zm_powerups::function_16c2586a;
    self zm_powerup_nuke::function_9a79647b(0.5);
  } else {
    self.var_2f68be48 = 1;
  }

  self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
  aiutility::addaioverridedamagecallback(self, &function_a13721f);
  self callback::function_d8abfc3d(#"on_ai_killed", &function_8a2cb5ed);
  self zm_score::function_82732ced();
  self thread zm_audio::play_ambient_zombie_vocals();
  self thread zm_audio::zmbaivox_notifyconvert();
  self.var_b467f3a1 = &function_201862b;
  self.deathfunction = &zm_spawner::zombie_death_animscript;
  level thread zm_spawner::zombie_death_event(self);
  self.var_2e5407fc = gettime() + int(self ai::function_9139c839().var_e61d73b0 * 1000);

  self thread function_cd801084();

}

private function_8a2cb5ed(params) {
  if(self.archetype === #"nosferatu") {
    attackerdistance = 0;
    isexplosive = 0;
    iscloseexplosive = 0;

    if(isDefined(params.eattacker) && isDefined(params.smeansofdeath) && isDefined(params.einflictor)) {
      attackerdistance = distancesquared(params.eattacker.origin, self.origin);
      isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), params.smeansofdeath);
      iscloseexplosive = distancesquared(params.einflictor.origin, self.origin) <= 300 * 300;

      if(isexplosive && iscloseexplosive) {
        gibserverutils::annihilate(self);
      }
    }
  }
}

private function_a13721f(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(attacker) && self === attacker) {
    damage = 0;
  }

  if(isDefined(attacker) && isplayer(attacker) && isDefined(weapon) && attacker zm_utility::function_aa45670f(weapon, 0)) {
    if(gettime() >= self.ai.var_9465ce93) {
      self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
      self clientfield::increment("nfrtu_silver_hit_fx");
    }
  }

  return damage;
}

private function_cd801084() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.pathgoalpos)) {

    }

    waitframe(1);
  }
}

private function_2b35beda() {
  self clientfield::increment_to_player("nosferatu_damage_fx");
}

private function_c59b482e() {
  self.health = self.maxhealth;
}

private function_c9a2941c(notifyhash) {
  if(isDefined(self) && isDefined(self.heal)) {
    self val::reset(#"nosferatu", "health_regen");
  }
}

private function_e05b2c36() {
  self notify("1aeb0156174acfac");
  self endon("1aeb0156174acfac");
  self endoncallback(&function_c9a2941c, #"death");
  self.b_nosferatu_damage_fx = 1;
  self val::set(#"nosferatu", "health_regen", 0);
  wait self.var_cd35302f;
  self val::reset(#"nosferatu", "health_regen");
  waitframe(5);
  self.var_cd35302f = undefined;
  self.b_nosferatu_damage_fx = 0;
}

function_8dc028ba(s_params) {
  attacker = s_params.eattacker;

  if(isDefined(attacker) && isDefined(attacker.archetype) && attacker.archetype == #"nosferatu" && s_params.idamage > 0) {
    self function_2b35beda();
    attacker function_c59b482e();

    if(zm_custom::function_901b751c(#"zmhealthregenrate") == 2 && zm_custom::function_901b751c(#"zmhealthregendelay") == 1) {
      self.var_cd35302f = attacker ai::function_9139c839().var_52a41524 + 1.1;
      self thread function_e05b2c36();
    }
  }
}

function_cf877849(var_dbce0c44) {
  if(isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return 0;
  }

  var_f1f220b9 = 1;

  if(level.round_number >= 15) {
    var_f1f220b9 = 3;
  } else if(level.round_number >= 10) {
    var_f1f220b9 = 2;
  }

  var_a87aeae6 = 30;
  var_a1737466 = randomfloatrange(0.02, 0.03);
  n_spawn = max(var_f1f220b9, int(level.zombie_total * var_a1737466));
  return min(var_a87aeae6, n_spawn);
}

function_57abef39(n_round_number) {
  level endon(#"end_game");

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"crimson_nosferatu")) {
      level.var_da92f51a = level.round_number + randomintrangeinclusive(2, 3);
    }
  }
}

function_97f1f86e(var_dbce0c44) {
  if(isDefined(level.var_da92f51a) && level.round_number < level.var_da92f51a || isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return 0;
  }

  var_a87aeae6 = 20;
  var_a1737466 = randomfloatrange(0.01, 0.02);
  return min(var_a87aeae6, int(level.zombie_total * var_a1737466));
}

round_spawn() {
  ai = function_74f25f8a();

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_a8a8c2fb() {
  ai = function_74f25f8a(0, undefined, 1);

  if(isDefined(ai)) {
    level.zombie_total--;
    return true;
  }

  return false;
}

function_74f25f8a(b_force_spawn = 0, var_eb3a8721, b_crimson = 0, round_number) {
  if(!b_force_spawn && !function_1c0cad2c()) {
    return undefined;
  }

  players = getplayers();

  if(isDefined(var_eb3a8721)) {
    s_spawn_loc = var_eb3a8721;
  } else if(isDefined(level.nosferatu_spawn_func)) {
    s_spawn_loc = [[level.nosferatu_spawn_func]]();
  } else if(level.zm_loc_types[#"nosferatu_location"].size > 0) {
    s_spawn_loc = array::random(level.zm_loc_types[#"nosferatu_location"]);
  }

  if(!isDefined(s_spawn_loc)) {
    return undefined;
  }

  if(b_crimson) {
    e_spawner = level.var_13bc407f[0];
  } else {
    e_spawner = level.var_243137e[0];
  }

  ai = zombie_utility::spawn_zombie(e_spawner, undefined, undefined, round_number);

  if(isDefined(ai)) {
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai thread zombie_utility::round_spawn_failsafe();
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);

    if(isDefined(level.var_ae4acb3f)) {
      ai thread[[level.var_ae4acb3f]](s_spawn_loc);
    }

    var_46d2ec35 = get_favorite_enemy();

    if(isDefined(var_46d2ec35)) {
      ai.favoriteenemy = var_46d2ec35;
      ai.favoriteenemy.hunted_by++;
    }
  }

  return ai;
}

function_1c0cad2c() {
  var_e02fe4cb = function_853b43e8();
  var_72385dbc = function_fc977dee();

  if(isDefined(level.var_5e45f817) && level.var_5e45f817 || var_e02fe4cb >= var_72385dbc || !level flag::get("spawn_zombies")) {
    return false;
  }

  return true;
}

function_fc977dee() {
  switch (getplayers().size) {
    case 1:
      return 3;
    case 2:
      return 5;
    case 3:
      return 7;
    case 4:
      return 10;
  }
}

function_853b43e8() {
  var_219a33e2 = getaiarchetypearray(#"nosferatu");
  var_e02fe4cb = var_219a33e2.size;

  foreach(ai_nosferatu in var_219a33e2) {
    if(!isalive(ai_nosferatu)) {
      var_e02fe4cb--;
    }
  }

  return var_e02fe4cb;
}

function_6502a84d(entity) {
  if(isDefined(level.zm_loc_types[#"nosferatu_location"]) && level.zm_loc_types[#"nosferatu_location"].size >= 1) {
    a_locs = array::randomize(level.zm_loc_types[#"nosferatu_location"]);
  }

  if(!isDefined(a_locs) || a_locs.size == 0) {
    return;
  }

  if(isDefined(entity) && isDefined(entity.favoriteenemy) && zm_utility::is_player_valid(entity.favoriteenemy)) {
    var_46d2ec35 = entity.favoriteenemy;
  } else {
    var_46d2ec35 = get_favorite_enemy();
  }

  if(!isDefined(var_46d2ec35) || !isalive(var_46d2ec35)) {
    return array::random(a_locs);
  }

  var_3ca1175 = 3600 * 3600;

  for(i = 0; i < a_locs.size; i++) {
    if(isDefined(level.var_445185e3) && level.var_445185e3 == a_locs[i]) {
      continue;
    }

    n_dist_squared = distancesquared(a_locs[i].origin, var_46d2ec35.origin);

    if(n_dist_squared < var_3ca1175) {
      level.var_445185e3 = a_locs[i];
      return a_locs[i];
    }
  }

  return arraygetclosest(var_46d2ec35.origin, a_locs);
}

get_favorite_enemy() {
  var_8637c743 = getplayers();
  e_least_hunted = var_8637c743[0];

  for(i = 0; i < var_8637c743.size; i++) {
    if(!isDefined(var_8637c743[i].hunted_by)) {
      var_8637c743[i].hunted_by = 0;
    }

    if(!zm_utility::is_player_valid(var_8637c743[i])) {
      continue;
    }

    if(!zm_utility::is_player_valid(e_least_hunted)) {
      e_least_hunted = var_8637c743[i];
    }

    if(var_8637c743[i].hunted_by < e_least_hunted.hunted_by) {
      e_least_hunted = var_8637c743[i];
    }
  }

  if(!zm_utility::is_player_valid(e_least_hunted)) {
    return undefined;
  }

  e_least_hunted.hunted_by += 1;
  return e_least_hunted;
}

function_4c71848e() {
  self endon(#"death");
  a_s_spawn_locs = level.zm_loc_types[#"nosferatu_location"];

  if(isarray(a_s_spawn_locs)) {
    for(i = 0; i < a_s_spawn_locs.size; i++) {
      if(isDefined(a_s_spawn_locs[i].scriptbundlename)) {
        arrayremoveindex(a_s_spawn_locs, i);
        continue;
      }
    }

    if(a_s_spawn_locs.size < 1) {
      self.b_ignore_cleanup = 1;
      return true;
    }
  } else {
    self.b_ignore_cleanup = 1;
    return true;
  }

  if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area")) {
    self.b_ignore_cleanup = 1;
    return true;
  }

  var_31f7011a = arraycopy(getplayers());
  var_31f7011a = arraysortclosest(var_31f7011a, self.origin);
  i = 0;
  var_b2aa54a9 = a_s_spawn_locs[0];
  var_56feeec4 = distancesquared(var_31f7011a[0].origin, var_b2aa54a9.origin);

  foreach(var_d7eff26a in a_s_spawn_locs) {
    if(!zm_utility::is_player_valid(var_31f7011a[i])) {
      i++;

      if(i >= var_31f7011a.size) {
        i = 0;
        util::wait_network_frame();
      }

      continue;
    }

    var_e8ab126e = distancesquared(var_31f7011a[i].origin, var_d7eff26a.origin);

    if(var_e8ab126e < var_56feeec4) {
      var_56feeec4 = var_e8ab126e;
      var_b2aa54a9 = var_d7eff26a;
    }
  }

  self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
  return true;
}

private function_82785646(entity) {
  if(isDefined(level.var_5e45f817) && level.var_5e45f817) {
    return false;
  }

  if(!isDefined(self.subarchetype) || self.subarchetype != #"crimson_nosferatu") {
    return false;
  }

  if(entity.health / entity.maxhealth > entity ai::function_9139c839().var_23f04a87 / 100) {
    return false;
  }

  if(isDefined(entity.var_85480576) && entity.var_85480576) {
    return false;
  }

  if(entity.var_2e5407fc > gettime()) {
    return false;
  }

  if(!(isDefined(level.var_9dc5ff5d) && level.var_9dc5ff5d) && zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit) {
    return false;
  }

  if(!function_c16e1ca1(entity)) {
    return false;
  }

  if(randomintrangeinclusive(0, 100) < entity ai::function_9139c839().var_3b66f582) {
    return true;
  }

  return false;
}

private function_c16e1ca1(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(entity.subarchetype !== #"crimson_nosferatu") {
    return false;
  }

  var_847b3ac1 = blackboard::getblackboardevents("nfrtu_summon");

  if(isDefined(var_847b3ac1) && var_847b3ac1.size) {
    return false;
  }

  return true;
}

private function_7d874447(entity) {
  var_e47d78cb = spawnStruct();
  blackboard::addblackboardevent("nfrtu_summon", var_e47d78cb, randomintrange(50000, 100000));
  entity.var_2e5407fc = gettime() + int(entity ai::function_9139c839().var_e61d73b0 * 1000);
  entity clientfield::set("summon_nfrtu", 1);
}

private function_7fef620b(entity) {
  entity.var_2e5407fc = gettime() + int(entity ai::function_9139c839().var_e61d73b0 * 1000);
  entity clientfield::set("summon_nfrtu", 0);
}

private function_76d6482e(entity) {
  if(isDefined(level.zm_loc_types[#"nosferatu_location"]) && level.zm_loc_types[#"nosferatu_location"].size >= 1) {
    a_locs = array::randomize(level.zm_loc_types[#"nosferatu_location"]);
  }

  if(!isDefined(a_locs)) {
    return;
  }

  var_c9528359 = int(max(0, min(3, level.zombie_ai_limit - zombie_utility::get_current_zombie_count())));
  var_4a07738f = entity getpathfindingradius() + 25;
  queryresult = positionquery_source_navigation(entity.origin, var_4a07738f, 300, 64, 25, entity);

  if(queryresult.data.size == 0) {

    iprintlnbold("<dev string:x44>");

      return;
  }

  if(!var_c9528359) {
    a_ai_zombies = getaiarchetypearray(#"zombie");

    foreach(e_player in util::get_active_players(#"allies")) {
      var_77696b51 = array::get_all_closest(e_player.origin, a_ai_zombies, undefined, undefined, 640);
      a_ai_zombies = array::exclude(a_ai_zombies, var_77696b51);
    }

    var_c9528359 = int(max(0, min(3, a_ai_zombies.size)));

    iprintln("<dev string:x9e>" + var_c9528359 + "<dev string:xad>");

      for(i = 0; i < var_c9528359; i++) {
        a_ai_zombies[i] thread zm_cleanup::cleanup_zombie();
      }
  }

  if(var_c9528359) {

    iprintln("<dev string:xd0>" + var_c9528359 + "<dev string:xe5>");

      entity thread function_13b48cdd(var_c9528359, queryresult);
    return;
  }

  if(var_c9528359 == 0) {
    iprintlnbold("<dev string:xf3>");
  }

}

function_13b48cdd(var_c9528359, queryresult) {
  self endon(#"death");
  point_index = 0;

  while(var_c9528359 > 0) {
    var_18f8f237 = 5;
    point = queryresult.data[point_index];
    point_index++;

    if(isDefined(point)) {
      do {
        ai = function_74f25f8a(1, undefined);
        var_18f8f237--;
        waitframe(1);
      }
      while(!isDefined(ai) && var_18f8f237);
    }

    if(!var_18f8f237 && !isDefined(ai)) {
      iprintlnbold("<dev string:x13d>");
    }

      if(isDefined(ai) && isDefined(point)) {
        ai thread function_b2a2b29e();
        ai.favoriteenemy = zm_utility::get_closest_valid_player(ai.origin, []);
        point thread nosferatu_spawn_fx(ai, {
          #origin: point.origin, 
          #angles: self.angles
        });
        wait 0.2;
      }

    var_c9528359--;
    waitframe(1);
  }
}

function_b2a2b29e() {
  self endon(#"death");
  self.var_126d7bef = 1;
  self.ignore_round_spawn_failsafe = 1;
  self.ignore_enemy_count = 1;
  self.b_ignore_cleanup = 1;
  self waittill(#"completed_emerging_into_playable_area");
  self.no_powerups = 1;
}

nosferatu_spawn_fx(ai, ent) {
  ai endon(#"death");
  ai val::set(#"nosferatu_spawn", "allowdeath", 0);
  ai setfreecameralockonallowed(0);
  wait 1.5;
  earthquake(0.5, 0.75, ent.origin, 1000);

  if(isDefined(ai.favoriteenemy)) {
    angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
    angles = (ai.angles[0], angle[1], ai.angles[2]);
  } else {
    angles = ent.angles;
  }

  ai dontinterpolate();
  ai forceteleport(ent.origin, angles);
  ai clientfield::increment("nosferatu_spawn_fx");
  assert(isDefined(ai), "<dev string:x159>");
  assert(isalive(ai), "<dev string:x16e>");
  ai val::reset(#"nosferatu_spawn", "allowdeath");
  wait 0.1;
  ai show();
  ai setfreecameralockonallowed(1);
  ai val::reset(#"nosferatu_spawn", "ignoreme");
  ai notify(#"visible");
}

function_201862b(eventstruct) {
  notify_string = eventstruct.action;

  switch (notify_string) {
    case #"death":
      if(isDefined(self.bgb_tone_death) && self.bgb_tone_death) {
        level thread zm_audio::zmbaivox_playvox(self, "death_whimsy", 1, 4);
      } else {
        level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 4);
      }

      break;
    case #"pain":
      level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 3);
      break;
    case #"scream":
      level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 3, 1);
      break;
    case #"leap":
    case #"attack_melee":
    case #"attack_bite":
      level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 2, 1);
      break;
    case #"sprint":
    case #"ambient":
      level thread zm_audio::zmbaivox_playvox(self, notify_string, 0, 1);
      break;
    default:
      level thread zm_audio::zmbaivox_playvox(self, notify_string, 0, 2);
      break;
  }
}