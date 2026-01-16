/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_white_nova_crawler.gsc
***********************************************/

#include scripts\core_common\ai\archetype_nova_crawler;
#include scripts\core_common\ai\systems\animation_state_machine_notetracks;
#include scripts\core_common\ai\systems\animation_state_machine_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm\ai\zm_ai_nova_crawler;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_behavior;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_ai_white_nova_crawler;

autoexec __init__system__() {
  system::register(#"zm_ai_white_nova_crawler", &__init__, &__main__, #"zm_ai_nova_crawler");
}

__init__() {
  function_7efe7cea();
  assert(isscriptfunctionptr(&function_20ff9616));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7263cdcd4718301", &function_20ff9616);
  assert(isscriptfunctionptr(&function_8261512d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a314f5acde8baa1", &function_8261512d);
  assert(isscriptfunctionptr(&function_8b694c31));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5fbc8804a8a15bd5", &function_8b694c31);
  assert(isscriptfunctionptr(&function_48aba0aa));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_383a0954f0b27e24", &function_48aba0aa);
  assert(isscriptfunctionptr(&function_1ded4b3e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_16995abde3a3d069", &function_1ded4b3e);
  assert(isscriptfunctionptr(&function_6e16f65f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45ddcfb4be875c5c", &function_6e16f65f);
  assert(isscriptfunctionptr(&function_12aaa2f7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6dad997b42434d2b", &function_12aaa2f7);
  assert(isscriptfunctionptr(&function_f89eddf1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4945b1ee9080ca23", &function_f89eddf1);
  assert(isscriptfunctionptr(&function_c21c2cf7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6aa0f71f46cc11e2", &function_c21c2cf7);
  assert(isscriptfunctionptr(&function_5b7e50b0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29ec8f4e038a8fd6", &function_5b7e50b0);
  assert(isscriptfunctionptr(&function_4c2972f1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57b68575535e3417", &function_4c2972f1);
  assert(isscriptfunctionptr(&function_90388f5b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5a621a5df6ec80c2", &function_90388f5b);
  assert(isscriptfunctionptr(&function_fc9e257f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_349daa17bc587fc4", &function_fc9e257f);
  assert(isscriptfunctionptr(&function_f0eb1b7e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5f37165a6a364df0", &function_f0eb1b7e);
  assert(isscriptfunctionptr(&function_c708afa4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_39d5538a04bc1a69", &function_c708afa4);
  assert(isscriptfunctionptr(&function_d7aebbd6));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_760fe53dc320cc37", &function_d7aebbd6);
  assert(isscriptfunctionptr(&function_80c8bbd3));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_63678c7c76fd4eb9", &function_80c8bbd3, 1);
  assert(isscriptfunctionptr(&function_677d42d1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1eae14f47f78c61e", &function_677d42d1, 1);
  assert(!isDefined(&function_82777ad1) || isscriptfunctionptr(&function_82777ad1));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_c44757b4) || isscriptfunctionptr(&function_c44757b4));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2d128ce6a4a5097f", &function_82777ad1, undefined, &function_c44757b4);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_6b950494) || isscriptfunctionptr(&function_6b950494));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_250e8c7b6d2e0855", undefined, undefined, &function_6b950494);
  assert(!isDefined(&function_ae4a399b) || isscriptfunctionptr(&function_ae4a399b));
  assert(!isDefined(&function_9fcedb9c) || isscriptfunctionptr(&function_9fcedb9c));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2e4e4b981dde7ba6", &function_ae4a399b, &function_9fcedb9c, undefined);
  animationstatenetwork::registernotetrackhandlerfunction("projectile_attack", &function_270b3dee);
  animationstatenetwork::registernotetrackhandlerfunction("spore_attack", &function_13d38964);
  animationstatenetwork::registernotetrackhandlerfunction("phase_start", &function_3bd2bba5);
  spawner::add_archetype_spawn_function(#"nova_crawler", &function_582a3075);

  zm_devgui::function_c7dd7a17("<dev string:x38>", "<dev string:x47>");
  zm_devgui::function_c7dd7a17("<dev string:x38>", "<dev string:x5c>");
  zm_devgui::function_c7dd7a17("<dev string:x38>", "<dev string:x70>");
  adddebugcommand("<dev string:x86>");
  adddebugcommand("<dev string:xbb>");

    clientfield::register("actor", "nova_buff_aura_clientfield", 8000, 1, "int");
  clientfield::register("actor", "white_nova_crawler_phase_end_clientfield", 8000, 1, "counter");
  clientfield::register("actor", "nova_gas_cloud_fx_clientfield", 8000, 1, "counter");
  clientfield::register("actor", "white_nova_crawler_spore_impact_clientfield", 8000, 1, "counter");
  clientfield::register("scriptmover", "white_nova_crawler_spore_clientfield", 8000, 1, "int");
  zm::function_84d343d(#"white_nova_crawler_projectile", &function_51ab2a44);
  zm::register_actor_damage_callback(&function_ac651298);
  level.white_nova_crawler_sniper_locations = struct::get_array("white_nova_crawler_sniper_location", "script_noteworthy");
  level.white_nova_crawler_sniper_escape_locations = struct::get_array("white_nova_crawler_sniper_escape_location", "script_noteworthy");
  level.var_e6cea2c0 = 0;
}

__main__() {}

function_7efe7cea() {
  level.var_bb3415b1 = [];

  for(i = 0; i < 6; i++) {
    spore = spawn("script_model", (0, 0, 0));
    spore setModel("tag_origin");

    if(!isDefined(level.var_bb3415b1)) {
      level.var_bb3415b1 = [];
    } else if(!isarray(level.var_bb3415b1)) {
      level.var_bb3415b1 = array(level.var_bb3415b1);
    }

    level.var_bb3415b1[level.var_bb3415b1.size] = spore;
  }
}

private function_582a3075() {
  self zm_ai_nova_crawler::function_1d34f2b6();
  self.actor_killed_override = &function_b1676105;
  self.var_71841cf9 = -1;
  self.var_2208281f = -1;
  self.var_34b2e48 = 0;
  self.lgt_env_helping_hand_room_1 = 1;
  self.var_442eb649 = 0;
  function_ba6a44f();
  function_3df69749();
  function_8eb7fbb7();
  function_349ae23d();
  function_41d1cdd5();

  if(function_2e8ceddd()) {
    function_605e733f();
  } else if(function_b06bbbba()) {
    function_ee3e7dc8();
  } else {
    self.can_phase = 0;
    self.can_shoot = 0;
    self.var_349e111e = 0;
    self.var_f1f44412 = 1;
    self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_aura";
  }

  self thread function_536a70c5();

}

private function_2e8ceddd() {
  return isDefined(self.subarchetype) && self.subarchetype == #"blue_nova_crawler";
}

private function_b06bbbba() {
  return isDefined(self.subarchetype) && self.subarchetype == #"ranged_nova_crawler";
}

private function_605e733f() {
  self.can_shoot = 1;
  self.can_phase = 0;
  self.var_349e111e = 0;
  self.var_f1f44412 = 0;
  self.b_ignore_cleanup = 1;
  self.ignore_nuke = 1;
  self.ignoreme = 1;
  self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_mq_aura";
}

private function_ee3e7dc8() {
  self.can_shoot = 1;
  self.var_b421bafe = 0;
  self.can_phase = 1;
  self.var_349e111e = 0;
  self.var_f1f44412 = 0;
  self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_elec_aura";
  self._effect[#"hash_571a3bab8b805854"] = "zm_ai/fx8_nova_crawler_elec_teleport_flash";
  self._effect[#"nova_crawler_phase_teleport_end_fx"] = "zm_ai/fx8_nova_crawler_elec_teleport_appear";
  self playSound(#"hash_27b6a39054ad63ec");
}

function_dc0238e4() {
  if(function_b06bbbba()) {
    self.var_b421bafe = 1;
  }
}

private function_536a70c5() {
  self endon(#"death");

  while(true) {
    waitframe(1);

    enabled = getdvarint(#"hash_6f365f1cee0a5d80", 0);

    if(enabled) {
      centroid = self getcentroid();
      color = (1, 0, 0);

      if(function_561b76c5()) {
        color = (0, 1, 0);
      }

      if(isDefined(self.favoriteenemy)) {
        self thread function_e5ffb77c(self.favoriteenemy.origin, self.origin, 0.1);
      }

      sphere(centroid, 10, color, 0.5, 0, 8, 1);
    }

  }
}

private function_b1676105(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  function_c33d4387();
  zm_ai_nova_crawler::function_c5b157a6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

private function_e5ffb77c(start, end, duration) {
  current_time = duration * 20;

  while(current_time > 0) {
    waitframe(1);
    line(start, end, (1, 0, 0), 1, 1);
    sphere(end, 2, (1, 0, 0), 1, 0, 4, 1);
    distance = distance(start, end);
    print3d(end + (0, 0, 30), "<dev string:x115>" + distance, (1, 0, 0), 1, 1, 1);
    current_time -= 1;
  }

}

private function_debf98ad(location, radius, duration) {
  current_time = duration * 20;

  while(current_time > 0) {
    waitframe(1);
    sphere(location, radius, (0, 1, 0), 0.1, 0, 8, 1);
    current_time -= 1;
  }

}

private function_80c8bbd3(entity) {
  if(entity function_b06bbbba()) {
    function_f2ce2a46(entity);
    return;
  }

  entity zm_behavior::zombiefindflesh(entity);
}

private function_f2ce2a46(entity) {
  var_5e1a56a9 = 0;

  if(isDefined(entity.favoriteenemy)) {
    var_5e1a56a9 = distance2d(entity.origin, entity.favoriteenemy.origin);
  }

  var_46503089 = 700 / 2;

  if(var_5e1a56a9 < 200 || var_5e1a56a9 > 500 || var_5e1a56a9 > var_46503089 && !entity isingoal(entity.origin) || !entity can_see_enemy() || entity function_68469a59()) {
    entity zm_behavior::zombiefindflesh(entity);
    return;
  }

  entity setgoal(entity.origin);
}

private function_4ee74b24() {
  if(!isDefined(self.var_4ee74b24)) {
    self.var_4ee74b24 = 0;
  }

  if(!isDefined(self.var_6d5a7a2d)) {
    self.var_6d5a7a2d = 0;
  }

  if(isDefined(self.favoriteenemy) && self.var_6d5a7a2d < gettime()) {
    var_4bd2cffc = self.favoriteenemy.origin - self.origin;
    var_7453ab4f = anglesToForward(self.angles);
    var_4bd2cffc = vectornormalize(var_4bd2cffc * (1, 1, 0));
    var_7453ab4f = vectornormalize(var_7453ab4f * (1, 1, 0));
    dot = vectordot(var_7453ab4f, var_4bd2cffc);
    cosine_angle = cos(3);
    self.var_6d5a7a2d = gettime() + 50;

    if(dot >= cosine_angle) {
      self.var_4ee74b24 = 1;
    } else {
      self.var_4ee74b24 = 0;
    }
  }

  return self.var_4ee74b24;
}

private can_see_enemy() {
  if(!isDefined(self.can_see_enemy)) {
    self.can_see_enemy = 0;
  }

  if(!isDefined(self.var_6ed00311)) {
    self.var_6ed00311 = 0;
  }

  if(isDefined(self.favoriteenemy) && self.var_6ed00311 < gettime()) {
    self.can_see_enemy = self cansee(self.favoriteenemy);
    self.var_6ed00311 = gettime() + 50;
  }

  return self.can_see_enemy;
}

private function_68469a59() {
  if(!isDefined(self.var_68469a59)) {
    self.var_68469a59 = 0;
  }

  if(!isDefined(self.var_8127535)) {
    self.var_8127535 = 0;
  }

  if(self.var_8127535 < gettime()) {
    zombie_poi = self zm_utility::get_zombie_point_of_interest(self.origin);

    if(isDefined(zombie_poi)) {
      self.var_68469a59 = 1;
    } else {
      self.var_68469a59 = 0;
    }

    self.var_8127535 = gettime() + 50;
  }

  return self.var_68469a59;
}

private function_20ff9616(entity) {
  return function_68469a59();
}

private function_561b76c5() {
  if(!isDefined(self.var_561b76c5)) {
    self.var_561b76c5 = 0;
  }

  if(!isDefined(self.var_463fafcf)) {
    self.var_463fafcf = 0;
  }

  if(isDefined(self.favoriteenemy) && isplayer(self.favoriteenemy) && self.var_463fafcf < gettime()) {
    self.var_561b76c5 = self.favoriteenemy islookingat(self);
    self.var_463fafcf = gettime() + 50;
  }

  return self.var_561b76c5;
}

private function_8ae62d74(entity) {
  var_3ac99fac = "NONE";
  navmeshpoint = undefined;

  if(isDefined(self.favoriteenemy)) {
    var_6fb2b27e = distancesquared(self.origin, self.favoriteenemy.origin);

    if(var_6fb2b27e >= 22500) {
      navmeshpoint = getclosestpointonnavmesh(entity.origin, 64, 15);
    }
  }

  if(isDefined(navmeshpoint)) {
    forward = anglesToForward(entity.angles);
    left = rotatepointaroundaxis(forward, (0, 0, 1), 60);
    right = rotatepointaroundaxis(forward, (0, 0, 1), -60);
    var_f53c23cf = checknavmeshdirection(navmeshpoint, left, 100, 0);
    var_379116fa = checknavmeshdirection(navmeshpoint, right, 100, 0);
    var_cfa253f9 = [];
    var_d3c9cafc = 1;

    if(distance(navmeshpoint, var_f53c23cf) + var_d3c9cafc >= 100) {
      var_cfa253f9[var_cfa253f9.size] = "LEFT";
    }

    if(distance(navmeshpoint, var_379116fa) + var_d3c9cafc >= 100) {
      var_cfa253f9[var_cfa253f9.size] = "RIGHT";
    }

    if(var_cfa253f9.size > 0) {
      var_3ac99fac = array::random(var_cfa253f9);
    }
  }

  entity setblackboardattribute("_phase_direction", var_3ac99fac);
}

private function_488ba9cc() {
  result = 0;
  navmeshpoint = getclosestpointonnavmesh(self.origin, 64, 15);

  if(isDefined(navmeshpoint)) {
    forward = anglesToForward(self.angles);
    var_6296423e = checknavmeshdirection(navmeshpoint, forward, 150, 0);
    var_cfa253f9 = [];

    if(distance(navmeshpoint, var_6296423e) >= 150) {
      result = 1;
    }
  }

  return result;
}

private function_6e16f65f(entity) {
  result = 0;

  if(isDefined(self.can_phase) && self.can_phase && gettime() > entity.var_95a46290 && isDefined(entity.favoriteenemy) && distance2dsquared(entity.origin, entity.favoriteenemy.origin) > 250000 && entity can_see_enemy() && entity function_488ba9cc() && !entity function_68469a59()) {
    phase_direction = entity getblackboardattribute("_phase_direction");
    result = phase_direction != "NONE";
  }

  return result;
}

private function_3df69749() {
  self.var_95a46290 = gettime() + randomfloatrange(2, 4) * 1000;
}

private function_12aaa2f7(entity) {
  function_3df69749();
  self.var_a89d0c1a = gettime() + randomfloatrange(3, 4) * 1000;
}

private function_f89eddf1(entity) {
  result = 0;

  if(isDefined(self.can_phase) && self.can_phase && (gettime() > entity.var_a89d0c1a || gettime() > entity.var_5b8bf6ba && entity function_561b76c5()) && entity can_see_enemy() && !entity function_68469a59()) {
    function_8ae62d74(entity);
    phase_direction = entity getblackboardattribute("_phase_direction");
    result = phase_direction != "NONE";
  }

  return result;
}

private function_c21c2cf7(entity) {
  function_ba6a44f();
}

private function_ba6a44f() {
  self.var_a89d0c1a = gettime() + randomfloatrange(3, 4) * 1000;
  self.var_5b8bf6ba = gettime() + randomfloatrange(0, 1.5) * 1000;
}

private function_3bd2bba5(entity) {
  function_46660930();
}

private function_46660930() {
  self endon(#"death");
  origin = self gettagorigin("j_spine4");
  playFX(self._effect[#"hash_571a3bab8b805854"], origin);
  self hide();
  self collidewithactors(0);
  self waittilltimeout(1, #"phase_end");
  self show();
  self collidewithactors(1);

  if(self.health > 0) {
    zm_net::network_safe_play_fx_on_tag("nova_crawler_aura", 2, self._effect[#"nova_crawler_aura_fx"], self, "j_spine4");
    zm_net::network_safe_play_fx_on_tag("nova_crawler_phase_teleport_end_fx", 2, self._effect[#"nova_crawler_phase_teleport_end_fx"], self, "j_spine4");
    playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
  }
}

private function_d7aebbd6(entity) {
  result = 0;

  if(!function_b06bbbba() || entity function_dd070839() || entity isonground()) {
    result = 1;
  }

  return result;
}

private function_ae4a399b(entity, asmstatename) {
  if(!entity isonground()) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
  }

  return 5;
}

private function_9fcedb9c(entity, asmstatename) {
  result = 5;

  if(entity isonground()) {
    result = 4;
  }

  return result;
}

private function_ac651298(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(self.archetype == #"nova_crawler" && isDefined(self.var_b421bafe) && self.var_b421bafe && self.var_71841cf9 == -1) {
    self.var_71841cf9 = gettime() + randomfloatrange(1, 3) * 1000;
  } else if(self.archetype == #"nova_crawler" && isDefined(self.subarchetype) && self.subarchetype == #"blue_nova_crawler" && !isplayer(attacker)) {
    return 0;
  }

  return -1;
}

private function_677d42d1(entity) {
  entity.favoriteenemy = entity.var_93a62fe;
}

private function_5b7e50b0(entity) {
  result = 0;

  if(isDefined(entity.var_b421bafe) && entity.var_b421bafe && isDefined(entity.can_shoot) && entity.can_shoot && isDefined(level.white_nova_crawler_sniper_locations) && level.white_nova_crawler_sniper_locations.size > 0 && isDefined(level.white_nova_crawler_sniper_escape_locations) && level.white_nova_crawler_sniper_escape_locations.size > 0) {
    result = 1;
  }

  return result;
}

private function_4c2972f1(entity) {
  result = 0;

  if(isDefined(entity.var_b421bafe) && entity.var_b421bafe && !isDefined(entity.var_3fc4c097)) {
    result = 1;
  }

  return result;
}

function_51e81aba(locations) {
  var_f37b8acb = [];
  var_764cc1f9 = undefined;

  foreach(location in locations) {
    if(!(isDefined(location.is_claimed) && location.is_claimed) && isDefined(location.zone_name) && level.zones[location.zone_name].is_occupied) {
      var_f37b8acb[var_f37b8acb.size] = location;
    }
  }

  if(var_f37b8acb.size > 0) {
    var_764cc1f9 = array::random(var_f37b8acb);
  }

  return var_764cc1f9;
}

private function_c33d4387() {
  if(isDefined(self.var_3fc4c097)) {
    self.var_3fc4c097 thread function_46aa5dda();
    self.var_3fc4c097 = undefined;
  }
}

private function_46aa5dda() {
  wait randomfloatrange(4, 5);
  self.is_claimed = undefined;
}

private function_90388f5b(entity) {
  sniper_location = function_51e81aba(level.white_nova_crawler_sniper_locations);

  if(isDefined(sniper_location)) {
    entity forceteleport(sniper_location.origin, sniper_location.angles);
    entity.var_3fc4c097 = sniper_location;
    sniper_location.is_claimed = 1;
    entity clientfield::increment("white_nova_crawler_phase_end_clientfield");
    entity.var_2208281f = gettime() + 30000;
    entity.no_powerups = 1;
  }
}

private function_fc9e257f(entity) {
  result = 0;

  if(entity.var_71841cf9 < 0 && isDefined(entity.var_3fc4c097) && isDefined(entity.favoriteenemy) && distancesquared(entity.origin, entity.favoriteenemy.origin) > 1024 * 1024) {
    entity.var_71841cf9 = gettime() + randomfloatrange(1, 3) * 1000;
  }

  if(entity.var_71841cf9 < 0 && entity.var_2208281f > 0 && gettime() > entity.var_2208281f) {
    entity.var_71841cf9 = gettime() + randomfloatrange(1, 3) * 1000;
  }

  if(isDefined(entity.var_b421bafe) && entity.var_b421bafe && isDefined(entity.var_3fc4c097) && entity.var_71841cf9 > 0) {
    result = gettime() > entity.var_71841cf9;
  }

  return result;
}

private function_c708afa4(entity) {
  var_96820b80 = function_51e81aba(level.white_nova_crawler_sniper_escape_locations);

  if(isDefined(var_96820b80)) {
    playFX(self._effect[#"hash_571a3bab8b805854"], entity.origin);
    entity forceteleport(var_96820b80.origin, var_96820b80.angles);
    function_c33d4387();
    entity.var_b421bafe = 0;
    entity clientfield::increment("white_nova_crawler_phase_end_clientfield");
    entity.no_powerups = 0;
  }
}

private function_f0eb1b7e(entity) {
  self.var_15aa1ae0 = gettime() + randomfloatrange(3, 5) * 1000;
  function_349ae23d();
  function_8eb7fbb7();
}

private function_8261512d(entity) {
  result = 0;

  if(isDefined(entity.can_shoot) && entity.can_shoot && level.var_e6cea2c0 < gettime() && gettime() > entity.var_42ecd9f3 && isDefined(entity.favoriteenemy)) {
    var_eab3f54a = distance2dsquared(entity.origin, entity.favoriteenemy.origin);

    if(var_eab3f54a > 200 * 200 && entity function_4ee74b24() && entity can_see_enemy() && !entity function_68469a59()) {
      result = 1;
    }
  }

  return result;
}

private function_82777ad1(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  level.var_e6cea2c0 = gettime() + 100;
  entity.var_67faa700 = 1;
  return 5;
}

private function_c44757b4(entity, asmstatename) {
  entity.var_67faa700 = undefined;
  function_8eb7fbb7();
  return 4;
}

private function_8eb7fbb7() {
  random_delay = 0;

  if(isDefined(self.var_b421bafe) && self.var_b421bafe) {
    random_delay = randomfloatrange(2, 3) * 1000;
  } else {
    random_delay = randomfloatrange(2, 3) * 1000;
  }

  self.var_42ecd9f3 = gettime() + random_delay;
}

private function_51ab2a44(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7aa37d9f = damage;

  if(isDefined(inflictor) && inflictor.team == self.team) {
    var_7aa37d9f = 0;
  }

  return var_7aa37d9f;
}

private function_270b3dee(entity) {
  if(isactor(entity) && isDefined(entity.favoriteenemy)) {
    start_location = entity gettagorigin("tag_tongue_3");
    target_location = entity.favoriteenemy getcentroid();

    if(isDefined(start_location)) {
      function_91582c6(entity, start_location, target_location);
    }
  }
}

private function_91582c6(entity, start_location, target_location) {
  weapon_name = "white_nova_crawler_projectile";

  if(isDefined(entity.subarchetype) && entity.subarchetype == #"blue_nova_crawler") {
    weapon_name = "blue_nova_crawler_projectile";
  }

  projectile_weapon = getweapon(weapon_name);
  projectile = magicbullet(projectile_weapon, start_location, target_location, entity, entity.favoriteenemy);
}

private function_7d162bd0(projectile, entity) {
  result = projectile waittill(#"projectile_impact_player", #"death");

  if(isDefined(projectile.origin)) {
    level thread function_5c3c88fe(projectile.origin);
  }
}

function_c36cef22(origin) {
  players = getplayers();
  zombies = getaiteamarray(level.zombie_team);

  foreach(zombie in zombies) {
    if(zombie != #"nova_crawler" && distancesquared(origin, zombie.origin) <= 6400) {
      zombie thread function_850768d1();
    }
  }

  foreach(player in players) {
    if(distancesquared(origin, player.origin) <= 6400) {
      player status_effect::status_effect_apply(getstatuseffect(#"zm_white_nova_gas"), undefined, player, 0);
    }
  }

  playrumbleonposition("zm_nova_explosion_rumble", origin);
}

private function_5c3c88fe(location) {
  var_d0feb0fe = spawn("trigger_radius", location, 0, 80, 100);
  n_gas_time = 0;
  var_d0feb0fe thread function_6d9aeb0f();
  var_d0feb0fe thread function_3ec863f5();

  while(n_gas_time <= 7) {
    wait 1;
    n_gas_time += 1;
  }

  var_d0feb0fe delete();
}

function_6d9aeb0f() {
  self endon(#"death");

  while(true) {
    zombies = getaiteamarray(level.zombie_team);

    foreach(zombie in zombies) {
      if(zombie istouching(self)) {
        zombie thread function_850768d1();
      }
    }

    waitframe(1);
  }
}

function_3ec863f5() {
  self endon(#"death");

  while(true) {
    players = getplayers();

    foreach(player in players) {
      if(player istouching(self)) {
        player status_effect::status_effect_apply(getstatuseffect(#"zm_white_nova_gas"), undefined, player, 1);
      }
    }

    wait 0.15;
  }
}

function_850768d1(b_respawn = 0) {
  self notify("4757156a6fd357df");
  self endon("4757156a6fd357df");

  if(!isDefined(self.var_6e2628f7) && self.archetype == #"zombie") {
    if(!b_respawn) {
      self.health = int(self.health * 2);
    }

    self.var_6e2628f7 = 1;
    level notify(#"buffed", {
      #ai: self
    });
    self.var_bd2c55ef = 1;

    if(!isDefined(self.var_e0d660f6)) {
      self.var_e0d660f6 = [];
    } else if(!isarray(self.var_e0d660f6)) {
      self.var_e0d660f6 = array(self.var_e0d660f6);
    }

    if(!isinarray(self.var_e0d660f6, &function_4018ef0d)) {
      self.var_e0d660f6[self.var_e0d660f6.size] = &function_4018ef0d;
    }

    self clientfield::set("nova_buff_aura_clientfield", 1);
    self.voiceprefix = "zombie_buff";
    wait 0.5;

    if(isDefined(self) && isalive(self)) {
      s_movespeed = self zombie_utility::function_33da7a07();

      if(s_movespeed == "sprint") {
        self zombie_utility::set_zombie_run_cycle("super_sprint");
      } else {
        self zombie_utility::set_zombie_run_cycle("sprint");
      }

      self waittill(#"death");

      if(isDefined(self)) {
        self clientfield::set("nova_buff_aura_clientfield", 0);
      }
    }
  }
}

private function_4018ef0d() {
  self thread function_850768d1(1);
}

private function_8b694c31(entity) {
  result = 0;

  if(isDefined(entity.var_349e111e) && entity.var_349e111e && function_aaf0b660(entity) && !entity function_68469a59()) {
    result = 1;
  }

  return result;
}

private function_aaf0b660(entity) {
  return gettime() > entity.var_926f011e;
}

private function_349ae23d() {
  self.var_926f011e = gettime() + randomfloatrange(5, 8) * 1000;
}

private function_e4d675eb(entity) {
  if(isactor(entity)) {
    var_d9016f6f = entity gettagorigin("j_mainroot");

    if(isDefined(var_d9016f6f)) {
      entity clientfield::increment("nova_gas_cloud_fx_clientfield");
      level thread function_5c3c88fe(var_d9016f6f);
    }
  }
}

private function_48aba0aa(entity) {
  function_349ae23d();
}

private function_1ded4b3e(entity) {
  result = 0;

  if(isDefined(entity.var_f1f44412) && entity.var_f1f44412 && gettime() > entity.var_ce83fefe && !entity function_68469a59()) {
    ai_zombies = array::get_all_closest(entity.origin, getaiteamarray(entity.team), undefined, undefined, 300);

    if(ai_zombies.size > 0) {
      foreach(zombie in ai_zombies) {
        if(zombie.archetype == #"zombie" && isalive(zombie) && !(isDefined(zombie.var_6e2628f7) && zombie.var_6e2628f7)) {
          result = 1;
          break;
        }
      }
    }
  }

  return result;
}

private function_41d1cdd5() {
  self.var_ce83fefe = gettime() + randomfloatrange(5, 8) * 1000;
}

private function_13d38964(entity) {
  if(isDefined(entity) && isalive(entity) && isDefined(entity.favoriteenemy)) {
    ai_zombies = array::get_all_closest(entity.origin, getaiteamarray(entity.team), undefined, undefined, 300);

    if(ai_zombies.size > 0) {
      foreach(zombie in ai_zombies) {
        if(zombie.archetype == #"zombie" && isalive(zombie) && !(isDefined(zombie.var_6e2628f7) && zombie.var_6e2628f7)) {
          spore = function_d24f01d4();

          if(isDefined(spore)) {
            function_a7cc9606(entity, spore);
            entity thread shoot_spore(spore, zombie);
            continue;
          }

          break;
        }
      }
    }
  }
}

private function_6b950494(entity, asmstatename) {
  function_41d1cdd5();
  return 4;
}

private function_d24f01d4() {
  foreach(spore in level.var_bb3415b1) {
    if(isalive(spore.owner) || spore clientfield::get("white_nova_crawler_spore_clientfield") == 1) {
      continue;
    }

    return spore;
  }

  return undefined;
}

private function_a7cc9606(entity, spore) {
  assert(!isalive(spore.owner));
  spore.owner = entity;
}

private function_c2ca573f(spore) {
  spore.owner = undefined;
}

private function_b262d632(start, end, duration) {
  current_time = duration * 20;

  while(current_time > 0) {
    waitframe(1);
    line(start, end, (0, 1, 0), 1, 1);
    sphere(self.origin, 3, (1, 1, 0), 1, 0, 8, 1);
    current_time -= 1;
  }

}

shoot_spore(spore, target) {
  spore endon(#"death");
  start_location = self gettagorigin("j_spine4");
  target_velocity = target getvelocity();
  target_location = target getcentroid() + target_velocity * 0.5;
  spore.origin = start_location;
  wait 0.1;
  spore clientfield::set("white_nova_crawler_spore_clientfield", 1);
  spore moveto(target_location, 0.5);
  spore waittill(#"movedone");

  if(isDefined(target) && isalive(target)) {
    target clientfield::increment("white_nova_crawler_spore_impact_clientfield");
    target thread function_850768d1();
  }

  spore clientfield::set("white_nova_crawler_spore_clientfield", 0);

  if(isDefined(spore.owner)) {
    function_c2ca573f(spore);
  }
}