/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5133d88c555e460.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3bbf85ab4cb9f3c2;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#namespace namespace_58e19d6;

function init() {
  level.doa.var_78fe553b = [];
  clientfield::register("actor", "silverback_spawn", 1, 1, "counter");
  namespace_250e9486::function_252dff4d("silverback", 29, &function_644621c0, &function_12462f60);
  namespace_250e9486::function_252dff4d("silverback_raygun", -1, &function_644621c0, &function_12462f60);
  registerbehaviorscriptfunctions();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_7ea2ce80));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_13a7c5f0e3443c41", &function_7ea2ce80);
  assert(isscriptfunctionptr(&function_5ea59a34));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2e4df6a195ecfec9", &function_5ea59a34);
  assert(isscriptfunctionptr(&function_f23c95c0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5842fe16f70c7666", &function_f23c95c0);
  assert(isscriptfunctionptr(&function_57a2b7f5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d98d9c9ffa44e4a", &function_57a2b7f5);
  assert(isscriptfunctionptr(&function_393e6415));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5e697a4c27f75b89", &function_393e6415);
  assert(isscriptfunctionptr(&function_300bba8c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_54f2476b821b6122", &function_300bba8c);
  assert(!isDefined(&function_33d8ef00) || isscriptfunctionptr(&function_33d8ef00));
  assert(!isDefined(&function_3e4a0d4f) || isscriptfunctionptr(&function_3e4a0d4f));
  assert(!isDefined(&function_a0e76e3c) || isscriptfunctionptr(&function_a0e76e3c));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_40d132fce22a5e1f", &function_33d8ef00, &function_3e4a0d4f, &function_a0e76e3c);
  assert(!isDefined(&function_6d8dd464) || isscriptfunctionptr(&function_6d8dd464));
  assert(!isDefined(&function_3eb8351a) || isscriptfunctionptr(&function_3eb8351a));
  assert(!isDefined(&function_fcbe1c10) || isscriptfunctionptr(&function_fcbe1c10));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2154c6eadedb4030", &function_6d8dd464, &function_3eb8351a, &function_fcbe1c10);
  assert(!isDefined(&function_a1f4593d) || isscriptfunctionptr(&function_a1f4593d));
  assert(!isDefined(&function_78e41d77) || isscriptfunctionptr(&function_78e41d77));
  assert(!isDefined(&function_aacc3221) || isscriptfunctionptr(&function_aacc3221));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_3f09038802c74759", &function_a1f4593d, &function_78e41d77, &function_aacc3221);
  assert(!isDefined(&function_ea163d5b) || isscriptfunctionptr(&function_ea163d5b));
  assert(!isDefined(&function_cea06112) || isscriptfunctionptr(&function_cea06112));
  assert(!isDefined(&function_ebaf98e0) || isscriptfunctionptr(&function_ebaf98e0));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_507d2a221b595a43", &function_ea163d5b, &function_cea06112, &function_ebaf98e0);
  assert(!isDefined(&function_77e73b0) || isscriptfunctionptr(&function_77e73b0));
  assert(!isDefined(&function_ae656597) || isscriptfunctionptr(&function_ae656597));
  assert(!isDefined(&function_3a5a0b29) || isscriptfunctionptr(&function_3a5a0b29));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_32d2aabab53b4ba6", &function_77e73b0, &function_ae656597, &function_3a5a0b29);
}

function function_644621c0() {
  self namespace_250e9486::function_25b2c8a9();
  self namespace_250e9486::function_db744d28(getdvarint(#"hash_6c6cccd30dfa33fc", 2500));
  self.var_f979e699 = 20000;
  self.animrate = 1;
  self.var_1077b9da = 0;
  self.var_9540e8e7 = 0;
  self.var_6e5b38d9 = 0;
  self.var_3b0b5ef8 = 0;
  self.var_434f2387 = 0;
  self.var_aff8ab1 = 0;
  self.var_131a202d = 0;
  self.var_1c8b76d3 = 1;
  self.health = 350000 + level.doa.var_6c58d51 * 1000000 + int(700000 * namespace_ec06fe4a::function_ef369bae());
  self.maxhealth = self.health;
  self.meleedistsq = sqr(80);
  self.var_b0f99546 = undefined;
  self setavoidancemask("avoid none");
  self.goalradius = 80;
  self.doa.var_ad888d1f = [];
  self.doa.var_6b4163f1 = 0;
  self setteam(#"neutral");
  self.no_gib = 1;
  self function_678d90a1(0.001001);
  self.var_5603780 = &function_ddfdaf41;
  self.overrideactordamage = &function_7ff8a49e;
  self callback::function_d8abfc3d(#"on_ai_killed", &function_31f5e5b);
  self thread namespace_ec06fe4a::function_d55f042c(level, "round_about_to_start");
  self notify(#"hash_2ca65c35156a24dc");
  self.var_febfd0 = namespace_ec06fe4a::spawnorigin(self.origin);

  if(isDefined(self.var_febfd0)) {
    self.var_febfd0.owner = self;
    self.var_febfd0 thread namespace_ec06fe4a::function_d55f042c(self, "death");
  }

  self.trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", self.origin, 2 | 1 | 512, 50, 50);

  if(isDefined(self.trigger)) {
    self.trigger thread function_f87ac23b(self);
    self.trigger enablelinkto();
    self.trigger linkto(self);
    self.trigger thread namespace_ec06fe4a::function_d55f042c(self, "death");
    self.trigger thread namespace_ec06fe4a::function_d55f042c(self, "killTrigger");
  }

  self namespace_83eb6304::function_3ecfde67("player_trail_red");
  self thread function_fa03570e();
  self thread function_27adf2ff();
  self thread function_2fdfff05();
  self thread function_8ef296ea();
  self function_add8c81a();

  self thread function_d140ebbd();

  if(!isDefined(level.doa.var_5598fe58)) {
    level.doa.var_5598fe58 = [];
  }

  if(!isDefined(level.doa.var_5598fe58)) {
    level.doa.var_5598fe58 = [];
  } else if(!isarray(level.doa.var_5598fe58)) {
    level.doa.var_5598fe58 = array(level.doa.var_5598fe58);
  }

  level.doa.var_5598fe58[level.doa.var_5598fe58.size] = self;
}

function function_d140ebbd() {
  self endon(#"death");
  self waittill(#"hash_737e3431bf19a6aa");
  self function_27adf2ff(0, 0);
}

function function_8ef296ea() {
  if(!isDefined(level.doa.var_5598fe58)) {
    level.doa.var_5598fe58 = [];
  }

  self endon(#"death");

  while(true) {
    level waittill(#"hash_11f6c6a82650cca2");

    if(is_true(self.collector)) {
      return;
    }

    function_1eaaceab(level.doa.var_5598fe58);
    chance = 100 - level.doa.var_5598fe58.size * 25 + getplayers().size * 10;

    foreach(monkey in level.doa.var_5598fe58) {
      if(monkey.var_b0f99546 === # "hash_3dd480845ef2e135") {
        if(monkey == self) {
          chance = 25;
          break;
        }

        chance -= 15;
      }
    }

    chance = math::clamp(chance, 10, 95);

    if(randomint(100) < chance) {
      self.var_6e5b38d9 = 0;
      self.var_1077b9da = 1;
      self.var_b0f99546 = # "hash_3dd480845ef2e135";
    }
  }
}

function function_2fdfff05() {
  self endon(#"death");
  var_89586b31 = 0;

  while(true) {
    curhealth = self.health;
    wait 1;
    var_dc5a778a = curhealth - self.health;
    namespace_1e25ad94::debugmsg("this interval, Mamaback hit for " + var_dc5a778a + " damage, health left:" + self.health);

    if(var_dc5a778a > 65000) {
      time = gettime();

      if(time > var_89586b31) {
        self.var_6e5b38d9 = 0;
        self.var_1077b9da = 1;
        self.var_b0f99546 = # "hash_3dd480845ef2e135";
        self.evading = 1;
        var_89586b31 = time + 10000;
        self thread namespace_6e90e490::function_47e11416(1);
      }
    }
  }
}

function function_12462f60() {
  self endon(#"death");

  if(!is_true(self.collector)) {
    self thread function_11e05208();
    self thread function_d1183a88();
  }

  self thread namespace_250e9486::function_8971bbb7();
  var_9a615a35 = 0;

  while(true) {
    if(var_9a615a35 < 200 && self.zombie_move_speed == "run" || self.zombie_move_speed == "walk") {
      var_9a615a35++;
    }

    if(var_9a615a35 > 0 && self.zombie_move_speed == "sprint") {
      var_9a615a35 -= 3;

      if(var_9a615a35 <= 0) {
        var_9a615a35 = 0;
        self function_add8c81a(self.var_993e6488);
      }
    }

    if(self.zombie_move_speed == "run" && var_9a615a35 >= 200) {
      self function_add8c81a("sprint");
    }

    self namespace_dfc652ee::function_d936944a();
    self namespace_dfc652ee::function_cbae9ca3();
    wait 0.2;
  }
}

function function_d1183a88() {
  self notify("35693ccf110437e6");
  self endon("35693ccf110437e6");
  self endon(#"death");
  wait 8;

  while(true) {
    wait 1;

    if(isDefined(self.favoriteenemy)) {
      if(isDefined(self.favoriteenemy.doa) && isDefined(self.favoriteenemy.doa.vehicle)) {
        break;
      }
    }
  }

  var_4fb43dc5 = self.favoriteenemy;

  foreach(player in getplayers()) {
    if(!isalive(player) || is_true(player.laststand)) {
      continue;
    }

    if(isDefined(player.doa.vehicle)) {
      continue;
    }

    if(is_true(self.var_ae3a888) && is_true(player.var_c497caa3)) {
      continue;
    }

    if(player !== self.favoriteenemy) {
      self clearenemy();
      self clearpath();
      self setgoal(self.origin);
      var_4fb43dc5 = player;
      break;
    }
  }

  if(self.favoriteenemy !== var_4fb43dc5) {
    self.favoriteenemy = var_4fb43dc5;

    if(isDefined(self.favoriteenemy)) {
      self setentitytarget(self.favoriteenemy);
    }
  }

  self thread function_d1183a88();
}

function function_11e05208() {
  self notify("57574d220446d239");
  self endon("57574d220446d239");
  self endon(#"death");
  wait 3;
  var_a3750609 = 5;
  lastpos = self.origin;

  while(var_a3750609) {
    wait 1;
    deltasq = distancesquared(lastpos, self.origin);

    if(deltasq < sqr(12)) {
      var_a3750609--;
      continue;
    }

    self thread function_11e05208();
  }

  var_4fb43dc5 = self.favoriteenemy;

  foreach(player in getplayers()) {
    if(!isalive(player) || is_true(player.laststand)) {
      continue;
    }

    if(is_true(self.var_ae3a888) && is_true(player.var_c497caa3)) {
      continue;
    }

    if(player !== self.favoriteenemy) {
      self clearenemy();
      self clearpath();
      self setgoal(self.origin);
      var_4fb43dc5 = player;
      break;
    }
  }

  if(self.favoriteenemy !== var_4fb43dc5) {
    self.favoriteenemy = var_4fb43dc5;

    if(isDefined(self.favoriteenemy)) {
      self setentitytarget(self.favoriteenemy);
    }
  }

  self thread function_11e05208();
}

function function_add8c81a(rate = "run") {
  if(rate == "next" && self.zombie_move_speed == "walk") {
    rate = "run";
  }

  if(rate == "next" && self.zombie_move_speed == "run") {
    rate = "sprint";
  }

  if(rate == "next" && self.zombie_move_speed == "sprint") {
    rate = "super_sprint";
  }

  if(rate == "walk") {} else if(rate == "run") {} else if(rate == "sprint") {}

  self.var_993e6488 = self.zombie_move_speed;
  self.zombie_move_speed = rate;
}

function function_ca4a3a4f(position) {
  self.var_860a34b9 = getclosestpointonnavmesh(position, self.goalradius, self getpathfindingradius());

  if(!isDefined(self.var_860a34b9)) {
    self.var_860a34b9 = position;
  }

  self.ignoreall = 1;
  self namespace_250e9486::function_41354e51(self.var_860a34b9, 1, 1);

  self thread function_31f34cee();
}

function function_31f34cee() {
  self endon(#"death");
  self notify("48dc5908e0a8583f");
  self endon("48dc5908e0a8583f");

  while(isDefined(self.var_860a34b9)) {
    level thread namespace_1e25ad94::function_1d1f2c26(self.var_860a34b9, 0.05, 24, (1, 0, 0));
    waitframe(1);
  }
}

function function_27adf2ff(on = 1, var_a53a6d94 = 1) {
  assert(isDefined(self.trigger));

  if(isDefined(self.trigger)) {
    self.trigger endon(#"death");
  }

  if(on) {
    self namespace_83eb6304::function_3ecfde67("silverback_shield");
    self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_start");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_shield_lp");
    self.takedamage = 0;
  } else {
    self namespace_83eb6304::turnofffx("silverback_shield");
    self namespace_e32bb68::function_3a59ec34("evt_doa_player_shield_stop");
    self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_silverback_shield_lp");
    self.takedamage = 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger triggerenable(var_a53a6d94);
  }
}

function function_f87ac23b(owner) {
  self endon(#"death");

  while(true) {
    result = self waittill(#"trigger");

    if(isDefined(result.activator)) {
      if(result.activator.team == # "allies") {
        result.activator dodamage(result.activator.health, self.origin, owner, owner);
        continue;
      }

      if(result.activator.team == # "axis") {
        if(namespace_250e9486::function_3d752709(result.activator)) {
          result.activator namespace_250e9486::setup_zombie_knockdown(owner);
          result.activator.knockdown_type = "knockdown_shoved";
        }
      }
    }
  }
}

function function_ddfdaf41() {
  self.var_6e5b38d9 = 0;
  self.var_1077b9da = 1;
  self.var_b0f99546 = # "hash_3dd480845ef2e135";
}

function function_7ff8a49e(inflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex) {
  if(is_false(self.takedamage) || is_true(self.collector)) {
    return 0;
  }

  var_799e18e5 = modelindex;
  var_5f32808d = 1;

  if(boneindex >= 1000) {
    var_5f32808d = 2;
  }

  self namespace_ec06fe4a::function_2f4b0f9(self.health - boneindex, timeoffset, var_799e18e5, boneindex, var_5f32808d);
  return boneindex;
}

function function_fa03570e() {
  self endon(#"death");

  while(true) {
    self waittill(#"hash_c7574e887244a9c");
    radiusdamage(self.origin, 100, 20000, 20000, self, "MOD_CRUSH");
  }
}

function function_31f5e5b(params) {
  if(is_true(level.doa.var_41adf604)) {
    foreach(player in getplayers()) {
      player namespace_d2efac9a::function_3f112727();
    }
  }

  if(namespace_ec06fe4a::function_a8975c67()) {
    self playSound(#"hash_37a5a1ff99e806d");
  }

  if(isDefined(self.wig)) {
    self.wig delete();
  }

  if(isDefined(self.glasses)) {
    self.glasses delete();
  }

  if(isDefined(self.spoon)) {
    self.spoon delete();
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self.var_febfd0)) {
    self.var_febfd0 delete();
  }

  arrayremovevalue(level.doa.var_5598fe58, self);
}

function function_7ea2ce80(entity) {
  if(entity.var_1077b9da) {
    entity.var_1077b9da = 0;
    return isDefined(entity.var_b0f99546);
  }

  if(is_true(entity.var_6ea9e4cf)) {
    return false;
  }

  if(is_true(entity.var_9540e8e7)) {
    return false;
  }

  if(isDefined(entity.var_b0f99546)) {
    return true;
  }

  if(!isDefined(entity.enemy)) {
    return false;
  }

  time = gettime();

  if(time < entity.var_6e5b38d9) {
    return false;
  }

  if(randomint(100) > 30) {
    entity.var_6e5b38d9 = time + 3000;
    return false;
  }

  var_92423047 = [];

  if(time > entity.var_aff8ab1 && randomint(100) < 30) {
    var_92423047[var_92423047.size] = # "hash_aea0ed21dcd8548";
  }

  if(time > entity.var_434f2387 && randomint(100) < 50) {
    var_92423047[var_92423047.size] = # "hash_3dd480845ef2e135";
  }

  if(time > entity.var_131a202d && randomint(100) < 30) {
    var_92423047[var_92423047.size] = # "hash_65e4e48a8b85b3ac";
  }

  if(var_92423047.size == 0) {
    return false;
  }

  entity.var_b0f99546 = var_92423047[randomint(var_92423047.size)];
  return true;
}

function function_6ae08d6c(origin, raygun = 0) {
  if(raygun == 0) {
    silverback = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("silverback"), origin);
  } else {
    silverback = doa_enemy::function_db55a448(doa_enemy::function_d7c5adee("silverback_raygun"), origin);
  }

  if(isDefined(silverback)) {
    silverback.targetname = "silverback";
    silverback clientfield::increment("silverback_spawn", 1);
    function_1eaaceab(level.doa.var_5598fe58);

    if(!isDefined(level.doa.var_5598fe58)) {
      level.doa.var_5598fe58 = [];
    } else if(!isarray(level.doa.var_5598fe58)) {
      level.doa.var_5598fe58 = array(level.doa.var_5598fe58);
    }

    level.doa.var_5598fe58[level.doa.var_5598fe58.size] = silverback;
  }

  return silverback;
}

function function_571bb3ac() {
  assert(isDefined(level.doa.var_39e3fa99));
  sides = array("top", "bottom", "left", "right");
  center = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();
  spot = [[level.doa.var_39e3fa99]] - > function_635991ca();
  silverback = function_6ae08d6c(spot.origin);

  if(isDefined(silverback)) {
    silverback endon(#"death");
    silverback function_add8c81a("walk");
    silverback.ignoreall = 1;
    silverback.var_6ea9e4cf = 1;
    silverback.goalradius = 16;
    silverback thread function_2c4249ed(sqr(28));
    result = level waittilltimeout(60, #"damage", #"doa_exit_taken", #"hash_72523790f36bd2a8", #"teleporter_taken", #"enter_the_wild", #"hash_7270a59e1f502d96");
    silverback notify(#"hash_72523790f36bd2a8");
    silverback.var_6ea9e4cf = undefined;

    if(result._notify == # "timeout" || result._notify == # "hash_72523790f36bd2a8" || result._notify == # "damage") {
      silverback.var_37f6ce66 = 0;
      silverback.var_860a34b9 = undefined;
      silverback.ignoreall = 0;
      silverback function_add8c81a("run");
      silverback thread namespace_6e90e490::function_47e11416(6);
      silverback.var_6e5b38d9 = gettime() + 11000;
      result = level waittilltimeout(10, #"doa_exit_taken", #"teleporter_taken", #"enter_the_wild", #"hash_7270a59e1f502d96", #"hash_72523790f36bd2a8");
    }

    silverback thread namespace_6e90e490::function_47e11416(6);
    silverback.var_1077b9da = 1;
    silverback.var_b0f99546 = # "hash_3dd480845ef2e135";
    level waittilltimeout(15, #"move_to_pos_downward_cycle", #"hash_1b322de3d2e3e781");
    silverback delete();
  }
}

function function_2c4249ed(distsq) {
  self notify("6152e7d8ce12e7fa");
  self endon("6152e7d8ce12e7fa");
  self endon(#"death");
  self endon(#"hash_726c573f1b22d654");

  while(true) {
    if(distancesquared(self.origin, self.goalpos) <= distsq) {
      self notify(#"near_goal");
    }

    waitframe(1);
  }
}

function function_5ea59a34(entity) {
  return is_true(entity.var_6ea9e4cf);
}

function private function_77e73b0(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);

  if(namespace_ec06fe4a::function_a8975c67()) {
    self playSound("zmb_simianaut_roar");
  }

  entity thread function_89406011();
  return 5;
}

function private function_ae656597(entity, asmstatename) {
  if(is_true(asmstatename.var_6ea9e4cf)) {
    return 5;
  }

  return 4;
}

function private function_3a5a0b29(entity, asmstatename) {
  asmstatename.var_6ea9e4cf = undefined;
  asmstatename.ignoreall = 0;
  asmstatename.var_860a34b9 = undefined;
  return 4;
}

function function_e0c89bfe() {
  self notify("7e7d7c33d69b3c77");
  self endon("7e7d7c33d69b3c77");
  self endon(#"death", #"hash_72523790f36bd2a8");
  wait 20;
  self function_add8c81a("run");
}

function function_89406011() {
  self notify("3d337ae202752ba6");
  self endon("3d337ae202752ba6");
  self endon(#"death");
  self thread function_e0c89bfe();
  self.var_418c1493 = 1;
  currenttarget = undefined;
  var_8d48d5f2 = undefined;
  pickups = arraysortclosest(level.doa.var_cc831548, self.origin);
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_gather_lp");

  while(is_true(self.var_6ea9e4cf)) {
    while(level.doa.var_cc831548.size) {
      pickups = arraysortclosest(level.doa.var_cc831548, self.origin, 12, 64);
      currenttarget = undefined;

      foreach(pickup in pickups) {
        if(is_true(pickup.var_23b495d)) {
          continue;
        }

        currenttarget = pickup;
        break;
      }

      if(!isDefined(currenttarget)) {
        self notify(#"hash_72523790f36bd2a8");
        level notify(#"hash_72523790f36bd2a8");
        self.pacifist = 0;
        self.ignoreall = 0;
        self.var_860a34b9 = undefined;
        self.var_6ea9e4cf = undefined;
        self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_silverback_gather_lp");
        return;
      }

      pos = namespace_ec06fe4a::function_65ee50ba(currenttarget.origin);
      self function_ca4a3a4f(pos);

      if(getdvarint(#"hash_267a8e5d4aab4191", 0) != 0) {
        self thread function_bf037906(currenttarget.origin);
      }

      if(self haspath() == 0 && self.var_f95bc76f === 10) {
        currenttarget.var_23b495d = 1;
        continue;
      }

      timeout = 20;

      while(timeout > 0 && isDefined(currenttarget) && !is_true(currenttarget.pickedup)) {
        lastorigin = self.origin;
        result = self waittilltimeout(0.5, #"near_goal", #"picked_up");

        if(result._notify == # "timeout") {
          timeout--;
        }

        if(isDefined(self.var_860a34b9) && distancesquared(self.var_860a34b9, self.origin) > sqr(12) && distancesquared(lastorigin, self.origin) < sqr(8)) {
          if(isDefined(currenttarget)) {
            currenttarget.var_23b495d = 1;
          }

          break;
        }

        if(!isDefined(currenttarget) || result.item === currenttarget || is_true(currenttarget.pickedup)) {
          break;
        }
      }
    }

    break;
  }

  self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_silverback_gather_lp");
  self notify(#"hash_72523790f36bd2a8");
  level notify(#"hash_72523790f36bd2a8");
  self.pacifist = 0;
  self.ignoreall = 0;
  self.var_860a34b9 = undefined;
}

function function_bf037906(origin) {
  self endon(#"death");
  self endon(#"hash_72523790f36bd2a8");
  self notify("6437725e824ab0d3");
  self endon("6437725e824ab0d3");

  while(is_true(self.var_6ea9e4cf)) {
    level thread namespace_1e25ad94::debugcircle(origin + (0, 0, 20), 30, 0.05, (1, 0, 0));
    level thread namespace_1e25ad94::debugline(self.origin + (0, 0, 20), origin + (0, 0, 20), 0.05, (1, 0, 0));
    waitframe(1);
  }
}

function function_f23c95c0(entity) {
  if(is_true(entity.var_ba88972)) {
    return true;
  }

  if(gettime() < entity.var_3b0b5ef8) {
    return false;
  }

  entity.var_3b0b5ef8 += randomint(1000);
  return randomint(100) < 5;
}

function private function_33d8ef00(entity, asmstatename) {
  entity.var_3b0b5ef8 = gettime() + 18000 + randomint(6000);
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity thread function_5dfb821d();
  return 5;
}

function private function_3e4a0d4f(entity, asmstatename) {
  if(is_true(asmstatename.var_ba88972)) {
    return 5;
  }

  return 4;
}

function private function_a0e76e3c(entity, asmstatename) {
  asmstatename.var_ba88972 = undefined;
  return 4;
}

function function_5dfb821d() {
  self notify("d4299be5a7cb9e7");
  self endon("d4299be5a7cb9e7");
  self endon(#"death");
  self.var_ba88972 = 1;
  result = self waittilltimeout(2, #"taunt_end", #"end");
  self.var_ba88972 = undefined;
}

function function_393e6415(entity) {
  return entity.var_b0f99546 === # "hash_aea0ed21dcd8548";
}

function private function_6d8dd464(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity pathmode("dont move");
  entity.var_febfd0.angles = entity.angles;
  entity.var_febfd0.origin = entity.origin;
  entity linkto(entity.var_febfd0);
  entity.var_c4b93228 = randomint(3) + 2;
  entity thread namespace_6e90e490::function_47e11416(6);
  entity thread function_396fbf53(entity.var_febfd0, entity.var_c4b93228);

  if(isDefined(entity.trigger)) {
    entity.trigger triggerenable(1);
  }

  return 5;
}

function private function_3eb8351a(entity, asmstatename) {
  if(function_393e6415(asmstatename)) {
    return 5;
  }

  return 4;
}

function private function_fcbe1c10(entity, asmstatename) {
  asmstatename pathmode("move allowed");
  asmstatename unlink();

  if(isDefined(asmstatename.trigger)) {
    asmstatename.trigger triggerenable(0);
  }

  asmstatename.var_aff8ab1 = gettime() + 5000;
  asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint(3000);
  asmstatename.var_b0f99546 = undefined;
  return 4;
}

function function_396fbf53(var_febfd0, numattacks = 1) {
  if(!isDefined(self.enemy)) {
    return;
  }

  self endon(#"death");
  var_accea2d5 = sqr(64);
  anim_ang = vectortoangles(self.enemy.origin - self.origin);
  var_febfd0 rotateto((0, anim_ang[1], 0), 0.5);
  self waittill(#"hash_4effc2ad460c79a6");

  while(numattacks && isDefined(self.enemy)) {
    numattacks--;
    targetorigin = self.enemy.origin;
    anim_ang = vectortoangles(targetorigin - self.origin);
    var_febfd0 rotateto((0, anim_ang[1], 0), 0.5);
    var_febfd0 waittill(#"rotatedone");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_boost");
    playrumbleonposition("explosion_generic", self.origin);
    dist = distance(targetorigin, self.origin) + 256;
    forward = anglesToForward(var_febfd0.angles);
    var_49e4e4be = var_febfd0.origin + forward * dist;
    trace = groundtrace(var_febfd0.origin + (0, 0, 30), var_49e4e4be + (0, 0, 30), 0, self);
    var_49e4e4be = trace[#"position"] + forward * -64;
    distsq = distancesquared(var_febfd0.origin, var_49e4e4be);
    var_e1f43424 = math::clamp(int(distsq / var_accea2d5), 1, 9999);
    traveltime = math::clamp(var_e1f43424 * 0.005, 0, 0.7);

    if(getdvarint(#"hash_370090a969cdbc39", 0)) {
      level thread namespace_1e25ad94::debugcircle(var_49e4e4be + (0, 0, 20), 30, 3, (1, 0, 0));
      level thread namespace_1e25ad94::debugline(var_49e4e4be + (0, 0, 20), self.origin + (0, 0, 20), 3, (1, 0, 0));
      var_febfd0 thread namespace_1e25ad94::debugorigin(3, 20, (1, 0, 0));
    }

    var_febfd0 thread function_51226983(self.enemy);
    self.boosting = 1;
    var_febfd0 moveto(var_49e4e4be, traveltime);
    var_febfd0 waittilltimeout(traveltime + 2, #"movedone");
    self.boosting = undefined;
    var_febfd0 notify(#"hash_531e95963631c569");

    if(getdvarint(#"hash_370090a969cdbc39", 0)) {
      var_febfd0 notify(#"hash_60eabc6ae83239fe");
    }
  }

  self.var_b0f99546 = undefined;
}

function private function_51226983(target) {
  if(!isDefined(target)) {
    return;
  }

  self notify("3871cafa5cd4a172");
  self endon("3871cafa5cd4a172");
  self endon(#"death", #"hash_531e95963631c569");
  target endon(#"death", #"disconnect");

  while(isDefined(target)) {
    anim_ang = vectortoangles(target.origin - self.origin);
    self rotateto((0, anim_ang[1], 0), 0.5);
    self waittill(#"rotatedone");
  }
}

function function_300bba8c(entity) {
  return entity.var_b0f99546 === # "hash_3dd480845ef2e135";
}

function private function_a1f4593d(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity pathmode("dont move");
  entity.var_febfd0.angles = entity.angles;
  entity.var_febfd0.origin = entity.origin;
  entity linkto(entity.var_febfd0);
  entity.var_66f5fb1a = randomint(3) + 1;
  entity thread function_de1c2fc3(entity.var_febfd0, entity.var_66f5fb1a);

  if(isDefined(entity.trigger)) {
    entity.trigger triggerenable(1);
  }

  return 5;
}

function private function_78e41d77(entity, asmstatename) {
  if(function_300bba8c(asmstatename)) {
    return 5;
  }

  return 4;
}

function private function_aacc3221(entity, asmstatename) {
  asmstatename pathmode("move allowed");
  asmstatename unlink();

  if(isDefined(asmstatename.trigger)) {
    asmstatename.trigger triggerenable(0);
  }

  asmstatename.var_7d10766 = gettime() + 3000;
  asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint(3000);
  asmstatename.var_b0f99546 = undefined;
  return 4;
}

function function_de1c2fc3(var_febfd0, numattacks = 1) {
  self endon(#"death");
  self waittill(#"hash_3b8882dbdaef63bf");
  self notify(#"jumping");

  if(is_true(self.evading)) {
    numattacks = 4;
    self.evading = undefined;
    var_3aeed2b5 = 1;
  }

  while(numattacks) {
    numattacks--;
    targetpos = undefined;

    if(!is_true(var_3aeed2b5)) {
      players = namespace_7f5aeb59::function_23e1f90f();

      if(players.size == 0) {
        break;
      }

      if(players.size == 1) {
        self.favoriteenemy = players[0];
      } else {
        if(isDefined(self.enemy)) {
          arrayremovevalue(players, self.enemy);
        }

        if(players.size > 0) {
          if(players.size == 1) {
            self.favoriteenemy = players[0];
          } else {
            self.favoriteenemy = players[randomint(players.size)];
          }
        }
      }

      if(isDefined(self.favoriteenemy) && function_7d0161cb(self.favoriteenemy)) {
        targetpos = self.favoriteenemy.origin;
      }
    }

    if(!isDefined(targetpos)) {
      if(isDefined(level.doa.var_39e3fa99)) {
        spot = [[level.doa.var_39e3fa99]] - > function_70fb5745();
        targetpos = spot.origin;
      } else {
        targetpos = self.origin;
      }
    }

    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_jet_takeoff");
    self namespace_83eb6304::function_3ecfde67("silverback_launch");
    playrumbleonposition("explosion_generic", self.origin);
    height = 1000;
    timems = height / 1000 * 3000;
    var_febfd0.angles = self.angles;
    var_febfd0.origin = self.origin;
    self linkto(var_febfd0);

    if(getdvarint(#"hash_225943d24ee71d", 0)) {
      level thread namespace_1e25ad94::debugcircle(targetpos + (0, 0, 20), 30, 3, (1, 0, 0));
      var_febfd0 thread namespace_1e25ad94::debugorigin(3, 20, (1, 0, 0));
    }

    var_febfd0 thread function_51226983(self.enemy);
    self thread function_3a558b65("move_to_pos_downward_cycle");
    var_febfd0 function_36e94670(targetpos, timems, height);

    if(isDefined(self.var_617140d4)) {
      self.var_617140d4 unlink();
      self.var_617140d4 = undefined;
    }

    var_febfd0 notify(#"hash_531e95963631c569");

    if(getdvarint(#"hash_225943d24ee71d", 0)) {
      var_febfd0 notify(#"hash_60eabc6ae83239fe");
    }

    self namespace_83eb6304::function_3ecfde67("silverback_land");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_jet_land");
    physicsexplosionsphere(self.origin, 200, 128, 2);
    earthquake(0.6, 0.75, self.origin, 200);
    targetpos = undefined;
  }

  self.var_b0f99546 = undefined;
}

function private function_3a558b65(var_8767c017) {
  self notify("3bc44bd3b2c292ff");
  self endon("3bc44bd3b2c292ff");
  self endon(#"death");
  level waittill(var_8767c017);
  self thread function_bf9a2a1d(getplayers().size + 1);
}

function function_7d0161cb(ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(!isPlayer(ent)) {
    return false;
  }

  if(isDefined(ent.doa) && isDefined(ent.doa.vehicle)) {
    return false;
  }

  if(!isDefined(level.doa.var_39e3fa99) || ![[level.doa.var_39e3fa99]] - > function_94e37da2(ent)) {
    return false;
  }

  return true;
}

function function_36e94670(destination, timems, var_fbe64ccb) {
  self endon(#"death");
  frames = timems / 50;
  delta = (destination - self.origin) / frames;
  stoptime = gettime() + timems;
  var_9843db1b = 0;

  if(isDefined(var_fbe64ccb)) {
    deltaz = var_fbe64ccb / frames / 2;
    var_aa3b6b10 = gettime() + timems / 2;

    while(true) {
      time = gettime();

      if(time > stoptime) {
        break;
      }

      if(time < var_aa3b6b10) {
        var_9b7b5074 = delta + (0, 0, deltaz);
        var_9843db1b = 1;
      } else {
        if(is_true(var_9843db1b)) {
          level notify(#"move_to_pos_downward_cycle");
          self notify(#"move_to_pos_downward_cycle");

          if(getdvarint(#"hash_4c32f1957a11eb6b", 0)) {
            self.owner thread namespace_ec06fe4a::function_b4ff2191((0, 0, 1), 300);
          }
        }

        var_9843db1b = 0;
        var_9b7b5074 = delta - (0, 0, deltaz);
      }

      newspot = self.origin + var_9b7b5074;

      if(!var_9843db1b && newspot[2] < destination[2]) {
        newspot = (newspot[0], newspot[1], destination[2]);

        if(isai(self)) {
          self forceteleport(newspot);
          return;
        }

        self.origin = newspot;
        return;
      }

      if(isai(self)) {
        self forceteleport(newspot);
      } else {
        self.origin = newspot;
      }

      waitframe(1);
    }

    return;
  }

  while(gettime() < stoptime) {
    if(isai(self)) {
      self forceteleport(self.origin + delta);
    } else {
      self.origin += delta;
    }

    waitframe(1);
  }
}

function function_57a2b7f5(entity) {
  return entity.var_b0f99546 === # "hash_65e4e48a8b85b3ac";
}

function private function_ea163d5b(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  self thread function_36f40887();

  if(function_1d0310f4()) {
    banana1 = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_banana");

    if(isDefined(banana1)) {
      banana1.targetname = "banana1";
      banana1 setModel("zombietron_banana");
      banana1 enablelinkto();
      banana1 linkto(self, "j_thumb_ri_3", (0, 0, 0), (0, 0, 0));
      banana1 thread function_bcfd19b2(self, "fire_banana_right");
    }
  }

  if(function_1d0310f4()) {
    banana2 = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_banana");

    if(isDefined(banana2)) {
      banana2.targetname = "banana2";
      banana2 setModel("zombietron_banana");
      banana2 enablelinkto();
      banana2 linkto(self, "j_thumb_le_3", (0, 0, 0), (0, 0, 0));
      banana2 thread function_bcfd19b2(self, "fire_banana_left");
    }
  }

  return 5;
}

function private function_cea06112(entity, asmstatename) {
  if(function_57a2b7f5(asmstatename)) {
    return 5;
  }

  return 4;
}

function private function_ebaf98e0(entity, asmstatename) {
  asmstatename.var_131a202d = gettime() + 3000;
  asmstatename.var_6e5b38d9 = gettime() + 3000 + randomint(3000);
  asmstatename.var_b0f99546 = undefined;
  return 4;
}

function function_1d0310f4() {
  return level.doa.var_78fe553b.size <= 6;
}

function function_36f40887() {
  self endon(#"death");
  self waittill(#"hash_25e58964d378516");
  self.var_b0f99546 = undefined;
}

function function_bf9a2a1d(number = 5) {
  self endon(#"death");
  baseangle = self.angles;
  increment = (0, 360 / (number + 1), 80);

  while(number) {
    banana1 = namespace_ec06fe4a::spawnmodel(self.origin, "zombietron_banana");

    if(isDefined(banana1)) {
      banana1.targetname = "banana1";
      banana1 setModel("zombietron_banana");
      banana1 thread function_bcfd19b2(self, undefined, baseangle);
      baseangle += increment;
    }

    number--;
  }
}

function function_bcfd19b2(silverback, note, angles) {
  level.doa.var_78fe553b[level.doa.var_78fe553b.size] = self;

  if(isDefined(angles)) {
    forward = anglesToForward(angles);
  } else {
    forward = anglesToForward(silverback.angles);
  }

  target_point = silverback.origin + 64 * forward + (randomfloatrange(2 * -1, 2), randomfloatrange(2 * -1, 2), 130);
  dir = vectornormalize(target_point - silverback.origin);

  if(isDefined(note)) {
    silverback waittilltimeout(2, note, #"death");
    self unlink();
  }

  vel = mapfloat(sqr(32), sqr(1600), 1.8, 5.5, distancesquared(target_point, self.origin));
  throw = dir * vel;
  self notsolid();
  self physicslaunch(self.origin, throw);
  wait 0.2;
  self solid();
  self namespace_83eb6304::function_3ecfde67("explo_warning_light");
  self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_redbarrel_warning");
  wait 5;
  self namespace_83eb6304::function_3ecfde67("silverback_banana_explo");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_silverback_banana_explo");
  waitframe(1);
  trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", self.origin, 0, 128, 64);
  trigger thread namespace_ec06fe4a::function_52afe5df(5 + 0.1);
  arrayremovevalue(level.doa.var_78fe553b, self);
  self namespace_ec06fe4a::function_8c808737();
  self thread namespace_ec06fe4a::function_52afe5df(5 + 0.1);

  if(isDefined(trigger)) {
    trigger.targetname = "banana";
    trigger thread function_d70f65d0();
    wait 5;
    trigger delete();
  }
}

function private function_d70f65d0() {
  self endon(#"death");
  self playLoopSound("zmb_doa_ai_silverback_banana_gas_lp");

  while(true) {
    result = self waittill(#"trigger");

    if(isPlayer(result.activator)) {
      if(!isDefined(result.activator.var_76eebaf0) || gettime() > result.activator.var_76eebaf0) {
        result.activator thread namespace_250e9486::function_b5feb0bf();
        result.activator.var_76eebaf0 = gettime() + 1000;
      }
    }
  }
}