/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_71971f45043d4dfe.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace namespace_6479037a;

function init() {
  namespace_250e9486::function_252dff4d("steiner", 15, &function_a485d734, undefined, 65);
  namespace_250e9486::function_252dff4d("steiner_split_left_arm", 16, &function_a485d734, undefined, 65);
  namespace_250e9486::function_252dff4d("steiner_split_right_arm", 17, &function_a485d734, undefined, 65);
  clientfield::register("actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int");
  clientfield::register("actor", "steiner_split_combine_fx_clientfield", 1, 1, "int");
  function_a767bb1c("zombie_steiner_split_radiation_blast_spawner", "split_blast");
  function_a767bb1c("zombie_steiner_split_radiation_bomb_spawner", "split_bomb");
  registerbehaviorscriptfunctions();
  level.doa.var_ce403221 = getweapon(#"hash_7e3de6b5b2134623");
}

function function_a485d734() {
  if(!isDefined(level.doa.steiner)) {
    level.doa.steiner = doa_enemy::function_d7c5adee("steiner");
    level.doa.var_c1781ccb = doa_enemy::function_d7c5adee("steiner_split_left_arm");
    level.doa.var_e6cf829d = doa_enemy::function_d7c5adee("steiner_split_right_arm");
  }

  self namespace_250e9486::function_25b2c8a9();

  if(!isDefined(self.subarchetype)) {
    if(level.doa.world_state == 0) {
      self.maxhealth = 60000;
    } else {
      self.maxhealth += 60000 + int(15000 * namespace_ec06fe4a::function_ef369bae());
    }

    self.var_8d1d18aa = 1;
    self setblackboardattribute("_run_n_gun_variation", "variation_forward");
  } else {
    self.maxhealth += 25000 + 7000 * getplayers().size;
  }

  self.health = self.maxhealth;
  self.var_f979e699 = isDefined(self.subarchetype) ? 200 : 500;
  self.no_gib = 1;
  self.var_4dcf6637 = 1;
  self.var_e66cd6fb = 1;
  self.zombie_move_speed = "walk";
  self.var_216935f8 = 1;
  self.var_c7121c91 = 1;
  self.var_32c5c724 = 1;
  self.org = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin", (0, 0, 0), "steiner org");

  if(isDefined(self.org)) {
    self.org thread namespace_ec06fe4a::function_d55f042c(self, "death");
  }

  if(!isDefined(self.subarchetype) || self.subarchetype == # "hash_5653bbc44a034094") {
    self.var_53bac70d = 1;
  }

  if(!isDefined(self.subarchetype) || self.subarchetype == # "hash_70162f4bc795092") {
    self.var_22b8f534 = 1;
  }

  self.overrideactordamage = &function_aab3a5fc;
  self.var_3ad8ef86 = 0;
  self.var_b52fc691 = 0;
  self.var_fcca372 = 0;

  if(!isDefined(self.ai)) {
    self.ai = spawnStruct();
  }

  self.ai.var_a02f86e7 = 0;
  self.ai.var_5dc77566 = 0;
  self.ai.var_b13e6817 = 0;
  self.ai.var_76786d9c = 0;
  self.ai.var_fad877bf = 0;
  self.ai.currentskill = 0;
  self.ai.var_a29f9a91 = 0;
  self.ai.var_e93366a = 0;
  self.ai.var_3dbed9a0 = 0;
  self.var_3a001247 = 1;
  self.ai.issplit = 0;
  self.ai.var_b90dccd6 = 0;
  self.ai.var_62741bfb = 0;

  if(is_true(self.var_22b8f534) && !isDefined(level.var_879dbfb8)) {
    level.var_879dbfb8 = 0;
  }

  self.var_b077b73d = &function_b077b73d;
}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_7a893a7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7280253b8045f3aa", &function_7a893a7);
  assert(isscriptfunctionptr(&function_e6d0f1d4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25f6a58aa44b9b2a", &function_e6d0f1d4);
  assert(isscriptfunctionptr(&function_99ab692d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_59de9b23ef7ed486", &function_99ab692d);
  assert(isscriptfunctionptr(&function_b46c0796));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79642ea6dc02eebd", &function_b46c0796);
  assert(isscriptfunctionptr(&function_1dcf9f45));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_200340d1ad88d275", &function_1dcf9f45);
  assert(isscriptfunctionptr(&function_15c1e3df));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ad94e79dd5192", &function_15c1e3df);
  assert(isscriptfunctionptr(&function_29744716));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a17e3794c739769", &function_29744716);
  assert(isscriptfunctionptr(&function_52479a49));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f21279adbfeb5c6", &function_52479a49);
  assert(isscriptfunctionptr(&function_dcac38af));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ada226476fbbc5a", &function_dcac38af);
  assert(isscriptfunctionptr(&function_e6b7aa9d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50a4fe24c23b6d27", &function_e6b7aa9d);
  assert(isscriptfunctionptr(&function_dab44559));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23c568af83b67b77", &function_dab44559);
  assert(isscriptfunctionptr(&function_baffe829));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1146baaf761ec6ed", &function_baffe829);
  assert(isscriptfunctionptr(&function_fe1e617c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57c7c778e27ffa59", &function_fe1e617c);
  assert(isscriptfunctionptr(&function_4245d56f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_98b56eef8e28325", &function_4245d56f);
  assert(isscriptfunctionptr(&function_45fabe41));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1658d524a973ce91", &function_45fabe41);
  assert(isscriptfunctionptr(&function_99608cba));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a163703acd2ed3f", &function_99608cba);
  assert(isscriptfunctionptr(&function_779b5a9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2bb826405d693ccb", &function_779b5a9);
  assert(isscriptfunctionptr(&function_363c063));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f175e396e0073c6", &function_363c063);
  assert(isscriptfunctionptr(&function_380fc4a5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f54754f71b9dd6e", &function_380fc4a5);
  assert(isscriptfunctionptr(&function_545f48af));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_305325825d9f1ae9", &function_545f48af);
  assert(isscriptfunctionptr(&function_42d0830a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_188114dd969b5dd5", &function_42d0830a);
  assert(isscriptfunctionptr(&function_bc86ecfb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3248e7c31b84322a", &function_bc86ecfb);
  assert(isscriptfunctionptr(&function_d94a4d59));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_61916b6e085cb852", &function_d94a4d59);
  assert(isscriptfunctionptr(&function_5c25cce9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79093a39082de682", &function_5c25cce9);
  assert(isscriptfunctionptr(&function_5070830c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4544909102899fea", &function_5070830c);
  assert(isscriptfunctionptr(&function_d33f94e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_170557ad6e763f0c", &function_d33f94e);
  assert(isscriptfunctionptr(&function_4b63f114));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5676e5630fdedd2c", &function_4b63f114);
  assert(isscriptfunctionptr(&function_46e10c70));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7cb881b920ccf02e", &function_46e10c70);
  assert(isscriptfunctionptr(&function_d778b630));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e786509dc63e8d5", &function_d778b630);
  assert(isscriptfunctionptr(&function_56f72e3c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27dfca0196f711e7", &function_56f72e3c);
  assert(isscriptfunctionptr(&function_7b89edb0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a436c24681915c9", &function_7b89edb0);
  animationstatenetwork::registernotetrackhandlerfunction("steiner_blast_fire", &function_46f4d406);
  animationstatenetwork::registernotetrackhandlerfunction("steiner_bomb_fire", &function_fc9189dd);
  assert(isscriptfunctionptr(&function_829cfcc8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3bd518a057cb317c", &function_829cfcc8);
}

function function_aab3a5fc(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(modelindex > self.health) {
    self thread function_4b193227();
  }

  self.lastattacker = boneindex;
  self.var_d429b0ce = offsettime;
  return modelindex;
}

function private get_enemy() {
  return isDefined(self.favoriteenemy) ? self.favoriteenemy : self.enemy;
}

function private function_b860fc37(enemy) {
  if(isPlayer(enemy)) {
    return (isalive(enemy) && !enemy inlaststand());
  }

  return isalive(enemy);
}

function private function_4ee74b24() {
  if(!isDefined(self.var_4ee74b24)) {
    self.var_4ee74b24 = 0;
  }

  if(!isDefined(self.var_6d5a7a2d)) {
    self.var_6d5a7a2d = 0;
  }

  enemy = self get_enemy();

  if(!isDefined(enemy)) {
    self.var_4ee74b24 = 0;
  } else if(self.var_6d5a7a2d < gettime()) {
    self.var_4ee74b24 = util::within_fov((self.origin[0], self.origin[1], 0), self.angles, (enemy.origin[0], enemy.origin[1], 0), cos(30));
    self.var_6d5a7a2d = gettime() + 50;
  }

  return self.var_4ee74b24;
}

function private can_see_enemy() {
  if(!isDefined(self.can_see_enemy)) {
    self.can_see_enemy = 0;
  }

  if(!isDefined(self.var_6ed00311)) {
    self.var_6ed00311 = 0;
  }

  enemy = self get_enemy();

  if(isDefined(enemy) && self.var_6ed00311 < gettime()) {
    self.can_see_enemy = self cansee(enemy);
    self.var_6ed00311 = gettime() + 50;
  }

  return self.can_see_enemy;
}

function private function_880fad96() {
  return self.ai.currentskill != 0;
}

function private function_1da02b50(var_b268a2ed) {
  assert(var_b268a2ed >= 0 && var_b268a2ed <= 3);
  self.ai.currentskill = var_b268a2ed;
}

function private function_9ee55afa() {
  self.ai.currentskill = 0;
  self.var_fcca372 = gettime() + int(3 * 1000);
  self notify(#"hash_58f0b0e23afeccb9");
}

function private function_efd416d6() {
  return !isDefined(self.var_fcca372) || self.var_fcca372 < gettime();
}

function function_af554aaf(enable) {
  if(!isDefined(self)) {
    return;
  }

  var_53bac70d = is_true(self.var_53bac70d);
  self.var_53bac70d = is_true(enable);

  if(var_53bac70d != self.var_53bac70d) {
    self.var_3ad8ef86 = 0;
  }
}

function private function_7a893a7(entity) {
  if(!is_true(entity.var_53bac70d)) {
    return 0;
  }

  return entity.ai.var_a02f86e7;
}

function private function_baffe829(entity) {
  entity function_1da02b50(1);
}

function private function_fe1e617c(entity) {
  if(isalive(entity)) {
    var_16122b95 = 2 * 0.5;
    cooldown = randomintrange(6, 8);
    entity.var_3ad8ef86 = gettime() + int((var_16122b95 + cooldown) * 1000);
    entity.ai.var_a02f86e7 = 0;
    entity function_9ee55afa();
  }
}

function private function_3aa93442(entity) {
  level endon(#"end_game");
  entity endon(#"death", #"entitydeleted");
  weapon = getweapon(#"hash_2124b6f8fa3f7f43");
  count = randomint(3) + 1;
  enemy = entity get_enemy();

  if(!isDefined(enemy)) {
    return;
  }

  wait 0.6;

  while(count) {
    if(!isalive(entity)) {
      return;
    }

    if(namespace_ec06fe4a::function_a8975c67(32)) {
      if(function_b860fc37(enemy)) {
        target_origin = enemy.origin + (0, 0, 8);
        velocity = enemy getvelocity();
        target_origin += velocity;
        org = namespace_ec06fe4a::spawnmodel(target_origin, "tag_origin", (0, 0, 0), "steiner blast org");

        if(isDefined(org)) {
          org thread namespace_ec06fe4a::function_52afe5df(2);
          org thread function_f7d9bc34();
        }

        var_21e2ce99 = entity gettagorigin("J_EyeBall_RI");
        magicbullet(weapon, var_21e2ce99, target_origin, entity);
      }
    }

    count--;

    if(true) {
      wait 0.5;
    }
  }
}

function function_f7d9bc34() {
  self endon(#"disconnect");
  self namespace_83eb6304::function_3ecfde67("incoming_impact");
  wait 1.2;

  if(isDefined(self)) {
    self namespace_83eb6304::turnofffx("incoming_impact");
  }
}

function private function_7709f2df(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7aa37d9f = surfacetype;

  if(isDefined(psoffsettime) && isDefined(boneindex) && isDefined(psoffsettime.team) && isDefined(boneindex.team) && psoffsettime.team == boneindex.team) {
    var_7aa37d9f = 0;
  }

  return var_7aa37d9f;
}

function private function_46f4d406(entity) {
  if(isalive(entity)) {
    level thread function_3aa93442(entity);
  }
}

function private function_829cfcc8(entity) {
  if(entity function_880fad96()) {
    return;
  }

  entity.ai.var_a02f86e7 = 0;
  entity.ai.var_5dc77566 = 0;
  entity.ai.var_b13e6817 = 0;

  if(!entity function_efd416d6()) {
    return;
  }

  enemy = entity get_enemy();

  if(!isDefined(enemy)) {
    return;
  }

  var_eab3f54a = distance2dsquared(entity.origin, enemy.origin);

  if(is_true(entity.var_22b8f534) && entity.var_b52fc691 < gettime() && !function_2bde9dfa(entity)) {
    if(var_eab3f54a <= 1000000 && entity function_4ee74b24() && entity can_see_enemy()) {
      entity.ai.var_b13e6817 = 1;
      entity.ai.var_5dc77566 = 1;
    }

    return;
  }

  if(is_true(entity.var_53bac70d) && entity.var_3ad8ef86 < gettime() && !function_2bde9dfa(entity)) {
    if(var_eab3f54a <= 1000000 && entity function_4ee74b24() && entity can_see_enemy()) {
      entity.ai.var_a02f86e7 = 1;
    }
  }
}

function function_16a8babd(enable) {
  if(!isDefined(self)) {
    return;
  }

  var_22b8f534 = is_true(self.var_22b8f534);
  self.var_22b8f534 = is_true(enable);

  if(var_22b8f534 != self.var_22b8f534) {
    self.var_b52fc691 = 0;
  }
}

function private function_99ab692d(entity) {
  if(!is_true(entity.var_22b8f534)) {
    return 0;
  }

  return entity.ai.var_b13e6817;
}

function private function_e6d0f1d4(entity) {
  if(!is_true(entity.var_22b8f534)) {
    return false;
  }

  return entity.ai.var_5dc77566 && entity function_52562969();
}

function private function_52562969() {
  if(isDefined(self.var_90c3aec8) && self.var_90c3aec8.size >= 3) {
    return false;
  }

  return level.var_879dbfb8 < 9;
}

function private function_99608cba(entity) {
  if(entity function_52562969()) {
    level.var_879dbfb8++;
    entity.var_4d0d199c = 1;
    entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 1);
    entity function_1da02b50(2);
    return;
  }

  entity.var_4d0d199c = 0;
}

function private function_779b5a9(entity) {
  entity.ai.var_b13e6817 = 0;
}

function private function_4245d56f(entity) {}

function private function_45fabe41(entity) {
  if(is_true(entity.var_4d0d199c)) {
    entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 0);
    entity.var_4d0d199c = 0;
  }

  cooldown = randomintrange(19, 21);
  entity.var_b52fc691 = gettime() + int(cooldown * 1000);
  entity.ai.var_5dc77566 = 0;
  entity function_9ee55afa();
}

function private function_7ff0ce68(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7aa37d9f = surfacetype;

  if(isDefined(psoffsettime) && isDefined(boneindex) && isDefined(psoffsettime.team) && isDefined(boneindex.team) && psoffsettime.team == boneindex.team) {
    var_7aa37d9f = 0;
  }

  return var_7aa37d9f;
}

function private function_bf8080c1(entity) {
  enemy = entity get_enemy();

  if(!function_b860fc37(enemy)) {
    return false;
  }

  var_6e3ad56b = enemy.origin;

  if(isPlayer(enemy)) {
    velocity = enemy getvelocity();

    if(length(velocity) >= 0) {
      var_6e3ad56b += vectorscale(velocity, 0.5);
    }
  }

  target_pos = var_6e3ad56b + (0, 0, 32);
  angles = vectortoangles(target_pos - entity.origin);
  dir = anglesToForward(angles);
  var_8598bad6 = entity gettagorigin("tag_bombthrower_FX");
  dist = distance(var_8598bad6, target_pos);
  velocity = vectorscale(dir, dist);
  velocity += (0, 0, 120);

  if(isDefined(entity.org)) {
    entity.org.origin = target_pos;
    entity.org thread function_f7d9bc34();
  }

  grenade = entity magicgrenadetype(getweapon(#"hash_7e3de6b5b2134623"), var_8598bad6, velocity);

  if(isDefined(grenade)) {
    grenade.owner = entity;
    grenade.team = entity.team;
    grenade thread function_a56050b0();
  }

  return true;
}

function private function_2bde9dfa(entity) {
  if(entity.ai.var_5dc77566 || entity.ai.var_b13e6817) {
    return 1;
  }

  return 0;
}

function private function_a56050b0() {
  level endon(#"end_game");
  owner = self.owner;
  self waittill(#"grenade_explode", #"death");

  if(isalive(owner)) {
    origin = self.origin;
    trace = bulletTrace(origin + (0, 0, 50), origin + (0, 0, -50), 0, self);

    if(trace[#"fraction"] < 1) {
      origin = trace[#"position"];
    }

    var_b308e59c = namespace_ec06fe4a::spawnmodel(origin, "tag_origin");

    if(isDefined(var_b308e59c)) {
      var_b308e59c.targetname = "steinerBomb";
      var_b308e59c.owner = owner;
      owner function_4d70c1d3(var_b308e59c);
      var_b308e59c thread function_fac064dc();
    }
  }
}

function private function_4d70c1d3(ent) {
  if(!isDefined(self.var_90c3aec8)) {
    self.var_90c3aec8 = [];
  }

  if(!isDefined(self.var_90c3aec8)) {
    self.var_90c3aec8 = [];
  } else if(!isarray(self.var_90c3aec8)) {
    self.var_90c3aec8 = array(self.var_90c3aec8);
  }

  self.var_90c3aec8[self.var_90c3aec8.size] = ent;
}

function private function_f2cb8145(var_ec2c535e, destroyed) {
  if(is_true(destroyed) && isDefined(self.owner) && isDefined(self.owner.var_90c3aec8)) {
    arrayremovevalue(self.owner.var_90c3aec8, self);
  }

  if(is_true(self.var_5d15d0b2)) {
    return;
  }

  self namespace_ec06fe4a::function_52afe5df(0.2);

  if(level.var_879dbfb8 > 0) {
    level.var_879dbfb8--;
  }
}

function private function_4b193227() {
  if(!isDefined(self.var_90c3aec8) || !self.var_90c3aec8.size) {
    return;
  }

  array::thread_all(self.var_90c3aec8, &function_f2cb8145, 0);
  self.var_90c3aec8 = [];
}

function private function_fac064dc() {
  level endon(#"end_game");
  self endon(#"death");
  var_6f13bbe0 = gettime() + int(4000);
  origin = self.origin;
  owner = self.owner;

  while(gettime() < var_6f13bbe0) {
    self namespace_83eb6304::function_3ecfde67("electrical_explo");
    players = function_a1ef346b(undefined, origin, 36);

    foreach(player in players) {
      if(isDefined(player.var_3de278ea) && gettime() - player.var_3de278ea < 0.5) {
        continue;
      }

      player dodamage(20, origin, owner, self, undefined, "MOD_DOT");
      player.var_3de278ea = gettime();
    }

    wait 0.5;
  }

  self thread function_f2cb8145(1);
}

function private function_fc9189dd(entity) {
  if(isalive(entity)) {
    function_bf8080c1(entity);
  }
}

function private function_a767bb1c(spawner_name, var_5c583e69) {
  if(!isDefined(level.var_f88d42fc)) {
    level.var_f88d42fc = [];
  }

  level.var_f88d42fc[var_5c583e69] = getEntArray(spawner_name, "script_noteworthy");

  if(level.var_f88d42fc[var_5c583e69].size == 0) {
    return;
  }

  foreach(var_694b1d7b in level.var_f88d42fc[var_5c583e69]) {
    var_694b1d7b.is_enabled = 1;
    var_694b1d7b.script_forcespawn = 1;
  }
}

function private function_ac56fb75() {
  level endon(#"end_game");
  self endon(#"death", #"entitydeleted");

  if(is_true(self.var_8576e0be) || is_true(self.var_9b474709)) {
    return;
  }

  if(self function_880fad96()) {
    self.var_9b474709 = 1;
    waitresult = self waittill(#"hash_58f0b0e23afeccb9", #"stop_wait_for_split");

    if(!isalive(self) || waitresult._notify == "stop_wait_for_split") {
      return;
    }

    self.var_9b474709 = 0;
  }

  self.var_8576e0be = 1;
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_steiner_split_start");
  self function_1da02b50(3);
  health = int(ceil(self.health * 0.5));
  right_angles = anglestoright(self.angles);
  var_7584b84b = (right_angles[0], right_angles[1], 0);
  var_53d254e5 = vectorscale(var_7584b84b, 15);
  var_488052a8 = vectorscale(var_7584b84b, -15);
  self thread function_eafb4701(level.doa.var_c1781ccb, self.origin, health, var_488052a8, self.enemy);
  self thread function_eafb4701(level.doa.var_e6cf829d, self.origin, health, var_53d254e5, self.enemy);
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_steiner_split_explode");
  self namespace_83eb6304::function_3ecfde67("zombie_generator_die");
  self namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
  self namespace_ec06fe4a::function_8c808737();
  attacker = self.lastattacker;

  if(isDefined(self.var_d429b0ce) && isDefined(self.var_d429b0ce.owner)) {
    attacker = self.var_d429b0ce.owner;
  }

  self thread namespace_ec06fe4a::function_570729f0(0.4, attacker);
}

function private function_eafb4701(spawndef, location, health, offset, enemy) {
  if(!isDefined(spawndef)) {
    return;
  }

  entity = doa_enemy::function_db55a448(spawndef, location, enemy);

  if(!isDefined(entity)) {
    return;
  }

  if(!isDefined(location.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = location.angles;
  }

  entity.maxhealth = health;
  entity.health = health;
  entity setmaxhealth(health);
  var_99b76528 = 25;
  point = getclosestpointonnavmesh(location + offset, var_99b76528);

  if(!isDefined(point)) {
    point = getclosestpointonnavmesh(location + offset, var_99b76528 * 4);
  }

  if(isDefined(point) && tracepassedonnavmesh(location, point, 15)) {
    entity forceteleport(point, angles);
  }

  point = namespace_ec06fe4a::function_65ee50ba(entity.origin);
  entity forceteleport(point, angles);
}

function private function_b46c0796(entity) {
  if(isalive(entity) && is_true(entity.var_8d1d18aa) && entity.health <= entity.maxhealth * 0.65) {
    if(!is_true(entity.var_8576e0be)) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function private function_363c063(entity) {}

function private function_380fc4a5(entity) {
  entity thread function_ac56fb75();
}

function private function_1dcf9f45(entity) {
  if(is_true(entity.ai.issplit)) {
    return 0;
  }

  return 1;
}

function private function_bc86ecfb(entity) {}

function private function_d94a4d59(entity) {
  entity.ai.issplit = 1;
}

function private function_15c1e3df(entity) {
  if(entity.ai.var_fad877bf) {
    return 1;
  }

  return 0;
}

function private function_d33f94e(entity) {}

function private function_4b63f114(entity) {
  entity.ai.var_fad877bf = 0;
}

function function_b077b73d(time) {
  if(!isDefined(time) || time <= 0) {
    return;
  }

  self thread function_392a816a(time);
}

function private function_392a816a(time) {
  if(is_true(self.var_8576e0be)) {
    return;
  }

  if(!is_true(self.var_8d1d18aa) && !isDefined(self.var_e1f39584)) {
    return;
  }

  self notify(#"hash_1126b46a114399d");
  self endon(#"death", #"hash_1126b46a114399d");
  self.var_8d1d18aa = 0;

  if(is_true(self.var_9b474709)) {
    self notify(#"stop_wait_for_split");
    self.var_9b474709 = 0;
  }

  var_e1f39584 = gettime() + int(time * 1000);

  if(isDefined(self.var_e1f39584)) {
    self.var_e1f39584 = int(max(self.var_e1f39584, var_e1f39584));
  } else {
    self.var_e1f39584 = var_e1f39584;
  }

  while(isalive(self) && isDefined(self.var_e1f39584)) {
    if(gettime() >= self.var_e1f39584) {
      self.var_8d1d18aa = 1;
      return;
    }

    waitframe(1);
  }
}

function private function_d778b630(entity) {
  entity.ai.var_76786d9c = 0;
  entity.ai.var_80045105 = gettime();
}

function private function_46e10c70(entity) {
  if(entity.ai.var_76786d9c) {
    entity.ai.var_fad877bf = 1;
    entity.ai.var_76786d9c = 0;
    return 4;
  }

  return 5;
}

function private function_56f72e3c(behaviortreeentity) {
  behaviortreeentity asmsetanimationrate(1.05);
}

function private function_7b89edb0(behaviortreeentity) {
  behaviortreeentity asmsetanimationrate(1);
}

function function_e6b7aa9d(behaviortreeentity) {
  return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_walk";
}

function function_dab44559(behaviortreeentity) {
  return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_run";
}

function private function_21746f2d(var_eab3f54a) {
  var_533af8f8 = !is_true(self.ai.var_e93366a) && var_eab3f54a > 722500;
  isrunning = self.zombie_move_speed == "run";

  if(var_533af8f8 && !isrunning) {
    if(!isDefined(self.ai.rundelay)) {
      self.ai.rundelay = gettime() + randomintrange(1000, 2000);
    }

    if(self.ai.rundelay > gettime()) {
      var_533af8f8 = 0;
    }
  }

  if(self.ai.var_3dbed9a0 < gettime() && var_533af8f8 != isrunning) {
    if(var_533af8f8) {
      currentvelocity = self getvelocity();
      currentspeed = length(currentvelocity);

      if(!isrunning || currentspeed > 0) {
        self.ai.var_3dbed9a0 = gettime() + 2000;
        self.zombie_move_speed = "run";
        self.ai.rundelay = undefined;
      }

      return;
    }

    self.ai.var_3dbed9a0 = gettime() + 2000;
    self.zombie_move_speed = "walk";
  }
}

function private function_29744716(entity) {
  return entity.ai.var_b90dccd6;
}

function function_67a0e9a2(var_2fa3c4c9, location) {
  level.var_f0c367c9 = location;
  level.var_8cc83376 = [];

  foreach(split in var_2fa3c4c9) {
    split.ai.var_b90dccd6 = 0;
    split.ai.var_62741bfb = 1;
    split setgoal(split.origin, 1);
    split.ignoreall = 1;
  }
}

function private function_52479a49(entity) {
  return entity.ai.var_62741bfb;
}

function private function_5c25cce9(entity) {
  entity clientfield::set("steiner_split_combine_fx_clientfield", 1);
}

function private function_5070830c(entity) {
  array::add(level.var_8cc83376, entity, 0);
  entity clientfield::set("steiner_split_combine_fx_clientfield", 0);
  entity.ai.var_62741bfb = 0;

  if(level.var_8cc83376.size == 2) {
    level thread function_aed09e18(level.var_8cc83376, level.var_f0c367c9);
    level.var_8cc83376 = [];
  }
}

function private function_dcac38af(entity) {
  return entity.ai.var_a29f9a91;
}

function private function_545f48af(entity) {}

function private function_42d0830a(entity) {
  if(isDefined(entity) && isDefined(entity.variant_type)) {
    if(entity.variant_type < 3) {
      entity.variant_type += 1;
      return;
    }

    entity.variant_type = 0;
    entity.ai.var_a29f9a91 = 0;
  }
}

function private function_aed09e18(var_2fa3c4c9, location) {
  foreach(split in var_2fa3c4c9) {
    split hide();
    split deletedelay();
  }

  steiner = doa_enemy::function_db55a448(level.doa.steiner, location, undefined);

  if(isDefined(steiner)) {
    steiner forceteleport(location.origin, location.angles);
    steiner.team = # "allies";
    steiner.ignoreall = 1;
    steiner.ignoreme = 1;
    steiner.ignore_nuke = 1;
    steiner.ignore_all_poi = 1;
    steiner.cant_move_cb = &zombiebehavior::function_79fe956f;
    steiner.takedamage = 0;
    steiner.var_8d1d18aa = 0;
    steiner.ai.var_a29f9a91 = 1;
    steiner.variant_type = 0;
    steiner function_af554aaf(0);
    steiner function_16a8babd(0);
  }

  level flag::set("steiner_merge_done");
}

function function_7e855c12(point) {
  self.var_9ecae3b4 = 1;
  self.zombie_move_speed = "walk";
  self setgoal(point, 0);
  self waittill(#"goal");
  self.var_9ecae3b4 = undefined;
  self setgoal(self.origin, 1);
}

function function_c6579189(target) {
  if(!isDefined(target)) {
    return;
  }

  v_to_target = target.origin - self.origin;
  v_angles = vectortoangles(v_to_target);
  self orientmode("face angle", v_angles);
}

function private function_46d99f6b() {
  steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
  var_ddb534a3 = [];

  foreach(steiner in steiners) {
    if(isalive(steiner) && steiner.team == # "allies") {
      if(!isDefined(var_ddb534a3)) {
        var_ddb534a3 = [];
      } else if(!isarray(var_ddb534a3)) {
        var_ddb534a3 = array(var_ddb534a3);
      }

      var_ddb534a3[var_ddb534a3.size] = steiner;
    }
  }

  return var_ddb534a3;
}