/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_brutus.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\archetype_brutus;
#include scripts\core_common\ai\archetype_brutus_interface;
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
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\powerup\zm_powerup_nuke;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\util\ai_brutus_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_lockdown_util;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_brutus;

autoexec __init__system__() {
  system::register(#"zm_ai_brutus", &__init__, &__main__, undefined);
}

__init__() {
  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"brutus", &function_debbd9da);
  spawner::function_89a2cd87(#"brutus", &function_6090f71a);
  level._effect[#"brutus"] = [];
  level._effect[#"brutus"][#"lockdown_stub_type_pap"] = "maps/zm_escape/fx8_alcatraz_perk_lock";
  level._effect[#"brutus"][#"lockdown_stub_type_perks"] = "maps/zm_escape/fx8_alcatraz_perk_s_lock";
  level._effect[#"brutus"][#"lockdown_stub_type_crafting_tables"] = "maps/zm_escape/fx8_alcatraz_w_bench_lock";
  level thread aat::register_immunity("zm_aat_brain_decay", #"brutus", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_frostbite", #"brutus", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_kill_o_watt", #"brutus", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_plasmatic_burst", #"brutus", 1, 1, 1);
  clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter");
  clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int");
  clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter");
  callback::on_actor_killed(&on_brutus_killed);
  zm_cleanup::function_cdf5a512(#"brutus", &function_88efcb);

  zm_devgui::function_c7dd7a17("<dev string:x38>");

}

__main__() {}

function_debbd9da() {
  self zombie_utility::set_zombie_run_cycle("run");
  aiutility::addaioverridedamagecallback(self, &function_83a6d3ae);
  self.hashelmet = 1;
  self.helmethits = 0;
  self.var_96b5e3f1 = 0;
  self.invulnerabletime = 0;
  self.var_905e4ce2 = self ai::function_9139c839().var_267bc182;
  self.meleedamage = self ai::function_9139c839().var_da7f4645;
  self.instakill_func = &instakill_override;
  self.var_f46fbf3f = 1;
  self.var_126d7bef = 1;
  self.var_e38eaee5 = 0;
  self.var_72411ccf = &brutustargetservice;
  self.cant_move_cb = &zombiebehavior::function_79fe956f;
  self.closest_player_override = &zm_utility::function_c52e1749;
  self zm_powerup_nuke::function_9a79647b(0.25);
  self thread zm_audio::zmbaivox_notifyconvert();
  self thread zm_audio::play_ambient_zombie_vocals();
  self callback::function_d8abfc3d(#"hash_6f9c2499f805be2f", &function_f2f4ced8);

  if(!isDefined(self.subarchetype)) {
    self attach("c_t8_zmb_mob_brutus_baton", "tag_weapon_right");
  }

  self setavoidancemask("avoid none");
  self.cant_move_cb = &function_188c83c7;
  self.var_63d2fce2 = &function_7b6e791e;
  self.ignorepathenemyfightdist = 1;
}

function_7b6e791e() {
  self.var_67faa700 = 0;
  self collidewithactors(1);
}

function_188c83c7() {
  self endon(#"death");
  self notify(#"hash_74044076f321434a");
  self endon(#"hash_74044076f321434a");
  self clearpath();
  self collidewithactors(0);

  if(isDefined(self.var_ece4a895)) {
    var_b378abd6 = self[[self.var_ece4a895]]();

    if(isDefined(var_b378abd6)) {
      self.var_67faa700 = 1;
      self setgoal(var_b378abd6, 1);
    }
  }
}

function_f2f4ced8() {
  self clientfield::set("brutus_spawn_clientfield", 1);

  if(isDefined(level.var_779eb5f5) && level.var_779eb5f5) {
    return;
  }

  playsoundatposition(#"zmb_ai_brutus_spawn", self.origin);

  if(!isDefined(level.var_b491030) || level flag::get(#"main_quest_completed")) {
    self playSound(#"hash_5d69a47fd8c0e9e5");
  }
}

function_c7ea6c73() {
  if(!isDefined(level.brutus_last_spawn_round)) {
    level.brutus_last_spawn_round = 0;
  }

  if(!isDefined(level.brutus_round_count)) {
    level.brutus_round_count = 0;
  }

  if(level.round_number > level.brutus_last_spawn_round) {
    level.brutus_round_count++;
    level.brutus_last_spawn_round = level.round_number;
  }
}

function_24c1b38f() {
  a_players = getplayers();
  n_player_modifier = 1;

  if(a_players.size > 1) {
    n_player_modifier = a_players.size * self ai::function_9139c839().var_854eebd;
  }

  var_eb6e4e3a = self ai::function_9139c839().var_544b0295 * n_player_modifier * level.brutus_round_count;
  var_eb6e4e3a = int(min(var_eb6e4e3a, self ai::function_9139c839().var_d0d2e3ce * n_player_modifier));
  return var_eb6e4e3a;
}

function_6090f71a() {
  if(!isDefined(self.starting_health)) {
    function_c7ea6c73();
    self.maxhealth = int(self zm_ai_utility::function_8d44707e(1, level.brutus_round_count) * (isDefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
    self.health = int(self zm_ai_utility::function_8d44707e(1, level.brutus_round_count) * (isDefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
  } else {
    self.maxhealth = self.starting_health;
    self.health = self.starting_health;
  }

  self.starting_health = undefined;
  self.explosive_dmg_req = self function_24c1b38f();
  starting_round = isDefined(self._starting_round_number) ? self._starting_round_number : level.round_number;
  ai::set_behavior_attribute("can_ground_slam", starting_round > self ai::function_9139c839().var_af3fff17);
}

on_brutus_killed(params) {
  if(self.archetype !== #"brutus") {
    return;
  }

  self clientfield::set("brutus_spawn_clientfield", 0);
  playsoundatposition(#"zmb_ai_brutus_death", self.origin);
  self destructserverutils::togglespawngibs(self, 1);
  self destructserverutils::function_629a8d54(self, "tag_weapon_right");
}

private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_fbb311db));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68d081058095794", &function_fbb311db);
  assert(isscriptfunctionptr(&function_3006441d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_df1d28cebbb75f6", &function_3006441d);
  assert(isscriptfunctionptr(&function_3bda3c55));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d8653062b32a601", &function_3bda3c55);
  assert(isscriptfunctionptr(&function_20fa0d4c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_691307470629f20e", &function_20fa0d4c);
  assert(isscriptfunctionptr(&function_3536f675));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_526dcca6d6d76bfe", &function_3536f675);
  assert(isscriptfunctionptr(&brutuslockdownstub));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"brutuslockdownstub", &brutuslockdownstub);
  assert(isscriptfunctionptr(&function_4ec678fe));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643443bf9243e4ff", &function_4ec678fe);
  assert(isscriptfunctionptr(&function_f4a61e6a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5800441474109ca6", &function_f4a61e6a);
  animationstatenetwork::registernotetrackhandlerfunction("hit_ground", &function_85e8940a);
  animationstatenetwork::registernotetrackhandlerfunction("locked", &brutuslockdownstub);
  animationstatenetwork::registeranimationmocomp("mocomp_purchase_lockdown@brutus", &function_14ed6be, undefined, undefined);
  assert(isscriptfunctionptr(&function_3c3e6f4a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1ba2ab8d76e1cd9b", &function_3c3e6f4a);
  assert(isscriptfunctionptr(&function_eb1f805));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_cc119947efb49cf", &function_eb1f805);
}

private function_943e4c08(entity, minplayerdist) {
  playerpositions = [];

  foreach(player in getplayers()) {
    if(!isDefined(playerpositions)) {
      playerpositions = [];
    } else if(!isarray(playerpositions)) {
      playerpositions = array(playerpositions);
    }

    if(!isinarray(playerpositions, isDefined(player.last_valid_position) ? player.last_valid_position : player.origin)) {
      playerpositions[playerpositions.size] = isDefined(player.last_valid_position) ? player.last_valid_position : player.origin;
    }
  }

  navmesh_origin = getclosestpointonnavmesh(entity.origin, entity getpathfindingradius());

  if(isDefined(navmesh_origin)) {
    pathdata = generatenavmeshpath(navmesh_origin, playerpositions, entity);

    if(isDefined(pathdata) && pathdata.status === "succeeded" && pathdata.pathdistance < minplayerdist) {
      return false;
    }
  }

  return true;
}

private brutustargetservice(entity) {
  if(isDefined(entity.ignoreall) && entity.ignoreall) {
    return 0;
  }

  entity.favoriteenemy = entity.var_93a62fe;

  if(!isDefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity)) {
    zone = zm_utility::get_current_zone();

    if(isDefined(zone)) {
      wait_locations = level.zones[zone].a_loc_types[#"wait_location"];

      if(isDefined(wait_locations) && wait_locations.size > 0) {
        entity zm_utility::function_64259898(wait_locations[0].origin, 200);
        return 1;
      }
    }

    entity setgoal(entity.origin);
    return 1;
  }

  zm_lockdown_util::function_f3cff6ff(entity);

    if(!isDefined(entity.var_722a34a3)) {
      entity.var_52e3b294 = undefined;
      pointofinterest = entity zm_utility::get_zombie_point_of_interest(entity.origin);

      if(isDefined(pointofinterest) && pointofinterest.size > 0) {
        foreach(poi in pointofinterest) {
          if(isDefined(poi) && isentity(poi) && isDefined(poi.classname) && poi.classname == "grenade") {
            goalpos = getclosestpointonnavmesh(poi.origin, 10, self getpathfindingradius());

            if(isDefined(goalpos)) {
              entity.var_722a34a3 = poi;
              entity.var_52e3b294 = goalpos;
            }
          }
        }
      }
    }

  if(isDefined(entity.var_52e3b294) && entity zm_utility::function_64259898(entity.var_52e3b294)) {
    return 1;
  }

  if(isDefined(entity.var_d646708c)) {
    entity function_a57c34b7(entity.var_d646708c);
    return 1;
  }

  goalent = entity.favoriteenemy;

  if(isplayer(goalent)) {
    goalent = zm_ai_utility::function_a2e8fd7b(entity, entity.favoriteenemy);
  }

  return entity zm_utility::function_64259898(goalent.origin);
}

private function_3c3e6f4a(entity) {
  var_65ba9602 = zm_lockdown_util::function_87c1193e(entity);

  if(isDefined(entity.var_722a34a3) || !isDefined(var_65ba9602) || !zm_lockdown_util::function_c9105448(entity, var_65ba9602)) {
    zm_lockdown_util::function_77caff8b(var_65ba9602);
    entity.var_d646708c = undefined;
  }

  if(isDefined(entity.var_722a34a3) || isDefined(var_65ba9602)) {
    return;
  }

  if(entity.var_e38eaee5 > gettime()) {
    return 0;
  }

  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return 0;
  }

  if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area")) {
    entity.var_d646708c = undefined;
    return 0;
  }

  zm_lockdown_util::function_f3cff6ff(entity);

    stub_types = [];
  array::add(stub_types, "lockdown_stub_type_crafting_tables");
  array::add(stub_types, "lockdown_stub_type_perks");
  array::add(stub_types, "lockdown_stub_type_pap");
  array::add(stub_types, "lockdown_stub_type_magic_box");
  array::add(stub_types, "lockdown_stub_type_boards");
  array::add(stub_types, "lockdown_stub_type_traps");
  registerlotus_right = zm_lockdown_util::function_9b84bb88(entity, stub_types, entity ai::function_9139c839().var_58b424ec, entity ai::function_9139c839().var_e81712d);
  entity.var_e38eaee5 = gettime() + 500;

  if(registerlotus_right.size == 0) {
    return 0;
  }

  stub = registerlotus_right[0];

  if(!function_943e4c08(entity, entity ai::function_9139c839().var_78a5f50)) {

    zm_lockdown_util::function_78eae22a(entity, stub, 9);

      return 0;
  }

  var_801b2d64 = undefined;
  var_f1591c10 = zm_lockdown_util::function_dab6d796(entity, stub);

  if(!isDefined(var_f1591c10)) {
    var_7162cf15 = zm_utility::function_b0eeaada(stub.origin);
    halfheight = 32;

    if(!isDefined(var_7162cf15)) {
      var_7162cf15 = [];
      var_7162cf15[#"point"] = stub.origin;
      halfheight = (stub.origin - zm_utility::groundpos(stub.origin))[2] + 1;
    }

    queryresults = positionquery_source_navigation(var_7162cf15[#"point"], 0, 256, halfheight, 20, 1);

    if(queryresults.data.size == 0) {
      return 0;
    }

    var_801b2d64 = queryresults.data[0].origin;
  } else {
    var_801b2d64 = getclosestpointonnavmesh(var_f1591c10.origin, 200, 24);
  }

  if(!isDefined(var_801b2d64)) {
    return 0;
  }

  entity.var_d646708c = var_801b2d64;
  zm_lockdown_util::function_50ba1eb0(entity, stub);
  entity setblackboardattribute("_lockdown_type", zm_lockdown_util::function_22aeb4e9(stub.lockdowntype));

  zm_lockdown_util::function_f3cff6ff(entity);

    return 1;
}

private function_eb1f805(entity) {
  velocity = entity getvelocity();
  velocitymag = length(velocity);
  predicttime = 0.2;
  movevector = velocity * predicttime;
  predictedpos = entity.origin + movevector;
  zombiesarray = getaiarchetypearray(#"zombie");
  zombiesarray = arraycombine(zombiesarray, getaiarchetypearray(#"catalyst"), 0, 0);
  var_86476d47 = array::filter(zombiesarray, 0, &namespace_9ff9f642::function_865a83f8, entity, predictedpos, ai::function_9139c839().var_b7366094);

  if(var_86476d47.size > 0) {
    foreach(zombie in var_86476d47) {
      zombie zombie_utility::function_fc0cb93d(entity);
    }
  }
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

function_20fa0d4c(entity) {
  if(!isDefined(entity.enemy)) {
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

  if(isDefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone) {
    meleedistsq = entity.meleeweapon.aimeleerange * entity.meleeweapon.aimeleerange;
  }

  if(!isDefined(meleedistsq)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq) {
    return false;
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  if(!entity cansee(entity.enemy)) {
    return false;
  }

  if(distancesquared(entity.origin, entity.enemy.origin) < 40 * 40) {
    return true;
  }

  if(!tracepassedonnavmesh(entity.origin, isDefined(entity.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin, entity getpathfindingradius())) {
    return false;
  }

  return true;
}

private function_3536f675(entity) {
  return entity ai::has_behavior_attribute("scripted_mode") && entity ai::get_behavior_attribute("scripted_mode") === 1;
}

private function_3bda3c55(entity) {
  if(!entity ai::get_behavior_attribute("can_ground_slam")) {
    return false;
  }

  if(entity.var_96b5e3f1 > gettime()) {
    return false;
  }

  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }

  if(!(isDefined(entity.favoriteenemy.am_i_valid) && entity.favoriteenemy.am_i_valid)) {
    return false;
  }

  if(abs(entity.origin[2] - entity.favoriteenemy.origin[2]) > 72) {
    return false;
  }

  if(distance2dsquared(entity.origin, entity.favoriteenemy.origin) > entity ai::function_9139c839().var_b4c77cfb * entity ai::function_9139c839().var_b4c77cfb) {
    return false;
  }

  return true;
}

private function_f4a61e6a(entity) {
  entity.var_96b5e3f1 = gettime() + int(entity ai::function_9139c839().var_d5427206 * 1000);
}

private function_85e8940a(entity) {
  players = getplayers();
  zombies = getaiteamarray(level.zombie_team);
  ents = arraycombine(players, zombies, 0, 0);
  ents = arraysortclosest(ents, entity.origin, undefined, 0, entity ai::function_9139c839().var_1709a39);
  shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");
  entity clientfield::increment("brutus_shock_attack", 1);
  level notify(#"hash_7a4ba7676000c3c6", {
    #brutus: self
  });

  foreach(ent in ents) {
    if(isplayer(ent)) {
      if(!zombie_utility::is_player_valid(ent, 0, 0)) {
        continue;
      }

      if(!bullettracepassed(entity.origin, ent gettagorigin("j_spine4"), 0, entity, ent)) {
        continue;
      }

      damage = mapfloat(entity getpathfindingradius() + 15, entity ai::function_9139c839().var_1709a39, entity ai::function_9139c839().var_7ea758e1, 0, distance(entity.origin, ent.origin));
      damage = int(max(10, damage));
      ent dodamage(damage, entity.origin, entity, entity, "none");
      ent status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
      ent clientfield::increment_to_player("brutus_shock_attack_player", 1);
      continue;
    }

    if(isai(ent)) {
      if(ent.zm_ai_category === #"basic") {
        ent zombie_utility::setup_zombie_knockdown(entity);
      }
    }
  }
}

private function_fbb311db(entity) {
  if(!isDefined(entity.var_d646708c) || !zm_lockdown_util::function_7bfa8895(entity)) {
    return false;
  }

  if(distancesquared(entity.var_d646708c, entity.origin) > entity ai::function_9139c839().var_98d0b358 * entity ai::function_9139c839().var_98d0b358) {
    return false;
  }

  return true;
}

function_c1844128(player) {
  if(zm_utility::is_standard()) {
    if(function_8b1a219a()) {
      self sethintstring(#"hash_43bfefdaa25b6b9c");
    } else {
      self sethintstring(#"hash_41048087f44fc9b0");
    }
  } else if(function_8b1a219a()) {
    self sethintstring(#"hash_451dc9a0469e39ff", self.stub.var_534571f);
  } else {
    self sethintstring(#"hash_5bdb56428055a4c1", self.stub.var_534571f);
  }

  return zm_lockdown_util::function_b5dd9241(self.stub);
}

private function_30afd2be(type, stub) {
  if(!isDefined(stub.var_50a8d231)) {
    stub.var_50a8d231 = 0;
  }

  var_b8576908 = 2000;

  switch (type) {
    case #"lockdown_stub_type_crafting_tables":
      var_491c5d62 = 1;
      break;
    case #"lockdown_stub_type_magic_box":
      var_491c5d62 = 1;
      break;
    case #"lockdown_stub_type_pap":
      var_491c5d62 = 3;
      break;
    case #"lockdown_stub_type_perks":
      var_491c5d62 = 3;
      break;
    default:
      var_491c5d62 = 1;
      break;
  }

  stub.var_50a8d231 = int(min(stub.var_50a8d231 + 1, var_491c5d62));
  return var_b8576908 * stub.var_50a8d231;
}

private function_32551326() {
  self endon(#"death");

  for(;;) {
    waitresult = self waittill(#"trigger");

    if(!isDefined(waitresult.activator) || !zm_utility::is_player_valid(waitresult.activator) || isDefined(self.stub) && isDefined(self.stub.var_6156031a) && self.stub.var_6156031a) {
      continue;
    }

    player = waitresult.activator;

    if(!player zm_score::can_player_purchase(self.stub.var_534571f)) {
      continue;
    }

    player zm_score::minus_to_player_score(self.stub.var_534571f);
    level notify(#"unlock_purchased", {
      #s_stub: self.stub
    });

    if(!isDefined(self.stub.var_6f08706b)) {
      if(self.stub.lockdowntype == "lockdown_stub_type_magic_box") {
        self.stub.trigger_target.zbarrier thread zm_magicbox::set_magic_box_zbarrier_state("unlocking");
      }
    }

    self.stub thread zm_lockdown_util::function_61a9bc58();
  }
}

private brutuslockdownstub(entity) {
  stub = zm_lockdown_util::function_87c1193e(entity);

  if(isDefined(stub)) {
    if(!zm_lockdown_util::function_c9105448(entity, stub)) {
      zm_lockdown_util::function_77caff8b(stub);
      entity.var_d646708c = undefined;
      return;
    }

    if(stub.lockdowntype == "lockdown_stub_type_magic_box") {
      stub.trigger_target.zbarrier zm_magicbox::set_magic_box_zbarrier_state("locking");
    }

    if(isDefined(stub.lockdowntype)) {
      var_80f22b97 = function_30afd2be(stub.lockdowntype, stub);
    } else {
      var_80f22b97 = 2000;
    }

    stub.var_534571f = var_80f22b97;
    level notify(#"brutus_locked", {
      #s_stub: stub
    });
    zm_lockdown_util::function_7258b5cc(entity, &function_c1844128, &function_32551326);
    entity setblackboardattribute("_lockdown_type", "INVALID");
  }
}

private function_14ed6be(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  stub = zm_lockdown_util::function_87c1193e(entity);

  if(isDefined(stub)) {
    entity orientmode("face point", stub.origin);
  }
}

private function_97f51aa3(v_org) {
  grenade = self magicgrenadetype(getweapon(#"willy_pete"), v_org, (0, 0, 0), 0.4);
  grenade.owner = self;
}

function_530c54e3() {
  self.hashelmet = 0;
  self zombie_utility::set_zombie_run_cycle("sprint");
  self.invulnerabletime = gettime() + int(self ai::function_9139c839().var_d463e760 * 1000);
  destructserverutils::function_9885f550(self, "helmet");
  self playSound(#"evt_brutus_helmet");
  self thread zm_audio::zmbaivox_playvox(self, "roar", 1, 3);

  if(isalive(self)) {
    function_97f51aa3(self gettagorigin("TAG_WEAPON_LEFT"));
    function_97f51aa3(self gettagorigin("TAG_WEAPON_RIGHT"));

    if(math::cointoss(50)) {
      level thread smoke_vo(self.origin);
    }
  }
}

smoke_vo(v_pos) {
  t_smoke = spawn("trigger_radius", v_pos, 0, 200, 80);
  t_smoke endon(#"death");
  t_smoke thread function_9a4a6d02();

  while(true) {
    waitresult = t_smoke waittill(#"trigger");

    if(isplayer(waitresult.activator)) {
      b_played = waitresult.activator zm_audio::create_and_play_dialog(#"brutus", #"smoke_react");

      if(isDefined(b_played) && b_played) {
        t_smoke notify(#"hash_617485dc39ba3f5e");
      }
    }

    wait randomfloatrange(0.666667, 1.33333);
  }
}

function_9a4a6d02() {
  self waittilltimeout(20, #"hash_617485dc39ba3f5e");
  self delete();
}

private function_55bb9c72(attacker, damage, weapon, var_81dcad68, damagemultiplier, damageoverride) {
  if(!(isDefined(self.hashelmet) && self.hashelmet)) {
    if(isDefined(attacker) && isplayer(attacker) && attacker hasperk(#"specialty_mod_awareness")) {
      if(self.zm_ai_category === #"boss") {
        damage *= 1.1;
      } else {
        damage *= 1.2;
      }
    }

    return (damage * (damageoverride ? damagemultiplier : var_81dcad68));
  }

  if(weaponhasattachment(weapon, "fmj2")) {
    if(self.zm_ai_category === #"boss") {
      damagemultiplier *= 1.1;
    } else {
      damagemultiplier = min(1, damagemultiplier + 0.1);
    }
  }

  self.helmethits++;

  if(self.helmethits >= self.var_905e4ce2) {
    self function_530c54e3();

    if(isDefined(attacker) && isplayer(attacker) && isDefined(level.brutus_points_for_helmet)) {
      attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
      attacker notify(#"hash_1413599b710f10bd");
    }
  }

  return damage * damagemultiplier;
}

private function_83a6d3ae(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex) {
  var_9000ab2 = isDefined(level.brutus_damage_percent) ? level.brutus_damage_percent : 0.1;
  var_127e9e7d = 1.5;
  var_81dcad68 = 1;

  if(self.invulnerabletime > gettime()) {
    if(isplayer(attacker)) {
      attacker util::show_hit_marker();
    }

    return 0;
  }

  var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex, shitloc, vpoint);
  var_9000ab2 = var_786d7e06.damage_scale;
  var_58640bc4 = self zm_ai_utility::function_94d76123(weapon);

  if(isDefined(attacker) && isalive(attacker) && isplayer(attacker) && attacker zm_powerups::is_insta_kill_active()) {
    var_81dcad68 = 2;
  }

  if(isDefined(weapon) && weapon.weapclass == "spread") {
    var_9000ab2 *= var_127e9e7d;
    var_81dcad68 *= var_127e9e7d;
  }

  if(zm_utility::is_explosive_damage(meansofdeath)) {
    if(!isDefined(self.explosivedmgtaken)) {
      self.explosivedmgtaken = 0;
    }

    self.explosivedmgtaken += damage;
    scaler = var_9000ab2;

    if(self.explosivedmgtaken >= self.explosive_dmg_req && isDefined(self.hashelmet) && self.hashelmet) {
      self function_530c54e3();

      if(isDefined(attacker) && isplayer(attacker) && isDefined(level.brutus_points_for_helmet)) {
        attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
        attacker notify(#"hash_1413599b710f10bd");
      }
    }

    return (damage * scaler);
  }

  if(shitloc !== "head" && shitloc !== "helmet") {
    if(weaponhasattachment(weapon, "fmj") && var_9000ab2 < 1) {
      if(self.zm_ai_category == #"boss") {
        var_9000ab2 *= 1.1;
      } else {
        var_9000ab2 = min(1, var_9000ab2 + 0.1);
      }
    }

    return (damage * var_9000ab2);
  }

  return int(self function_55bb9c72(attacker, damage, weapon, var_81dcad68, var_9000ab2, var_58640bc4));
}

instakill_override(player, mod, shitloc) {
  if(self.archetype === #"brutus") {
    return true;
  }

  return false;
}

function_88efcb() {
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return true;
  }

  if(isDefined(level.var_f47ae5da)) {
    s_spawn_loc = [[level.var_f47ae5da]]();
  } else if(level.zm_loc_types[#"brutus_location"].size > 0) {
    s_spawn_loc = zombie_brutus_util::get_best_brutus_spawn_pos();
  }

  if(!isDefined(s_spawn_loc)) {
    return true;
  }

  var_38007f6f = zm_lockdown_util::function_87c1193e(self);

  if(isDefined(var_38007f6f) && zm_lockdown_util::function_c9105448(self, var_38007f6f)) {
    zm_lockdown_util::function_77caff8b(var_38007f6f);
    self.var_d646708c = undefined;
  }

  self zm_ai_utility::function_a8dc3363(s_spawn_loc);

  if(isDefined(self)) {
    self thread zombie_brutus_util::brutus_lockdown_client_effects();
    self playSound(#"zmb_ai_brutus_spawn_2d");
  }

  return true;
}