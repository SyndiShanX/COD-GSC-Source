/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5701633066d199f2.gsc
***********************************************/

#using script_1510b5c03c279e8f;
#using script_15ddefec0f2c1a92;
#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_2c7754f0e88c7dd4;
#using script_3bbf85ab4cb9f3c2;
#using script_3faf478d5b0850fe;
#using script_40eb62810357ba9b;
#using script_40f967ad5d18ea74;
#using script_44dc341d87a68571;
#using script_46777b16a6ea6667;
#using script_47851dbeea22fe66;
#using script_49adc60ba76a57c7;
#using script_4d748e58ce25b60c;
#using script_5133d88c555e460;
#using script_52608be2732b3c77;
#using script_5701633066d199f2;
#using script_5e8f7ecf981ad9a3;
#using script_5f20d3b434d24884;
#using script_6281e493de3ff80b;
#using script_68cdf0ca5df5e;
#using script_6dce1fe6a7dd35c7;
#using script_71971f45043d4dfe;
#using script_736b4607e813f2e5;
#using script_74a56359b7d02ab6;
#using script_761ab8de8f97d130;
#using script_774302f762d76254;
#using script_7857e1ad7dfdbc95;
#using script_79cafc73107dd980;
#using script_7a9e25472d14a1ff;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace namespace_250e9486;

function init() {
  clientfield::register("actor", "enable_on_radar", 1, 1, "int");
  clientfield::register("vehicle", "enable_on_radar", 1, 1, "int");
  level.callbackactordamage = &function_dab7edc;
  level.callbackactorkilled = &function_9b31d191;
  level.callbackvehicledamage = &function_c36e5cab;
  level.callbackvehiclekilled = &function_5800e038;
  level.doa.var_695258a5 = 0;
  level.doa.var_4eb7c3f0 = 0;
  namespace_81522b3c::init();
  namespace_df4fbf0::init();
  namespace_f6712ec9::init();
  namespace_be2ae534::init();
  namespace_2e61cc4b::init();
  namespace_514c8ebc::init();
  namespace_a204c0f4::init();
  namespace_a0fa2b5::init();
  namespace_d1abdcb5::init();
  namespace_58e19d6::init();
  namespace_6479037a::init();
  namespace_b5ca279a::init();
  namespace_2a445563::init();
  namespace_53a8fe5e::init();
  namespace_146875e::init();
  namespace_8c89a9e9::init();
  namespace_6e561646::init();
  namespace_7457b8d5::init();
  level.var_deb2145c = &function_52fd55a;
  registerbehaviorscriptfunctions();

  if(!isDefined(level.var_7d6449a0)) {
    level.var_7d6449a0 = new class_c6c0e94();
    level.var_48894e85 = new class_c6c0e94();
    level.var_79a3ec93 = new class_c6c0e94();
    [[level.var_7d6449a0]] - > initialize("arenaThrottle", 4, float(function_60d95f53()) / 1000);
    [[level.var_48894e85]] - > initialize("wildThrottle", 6, float(function_60d95f53()) / 1000);
    [[level.var_79a3ec93]] - > initialize("dunegeonThrottle", 6, float(function_60d95f53()) / 1000);
  }

  level thread function_23f77d98();
}

function function_23f77d98() {
  self notify("5fdcef14ef431335");
  self endon("5fdcef14ef431335");

  while(true) {
    allies = namespace_7f5aeb59::function_23e1f90f();
    zombies = getaiteamarray(#"axis");

    foreach(ally in allies) {
      ally.doa.var_ab338943 = 0;
    }

    foreach(zombie in zombies) {
      if(!is_true(zombie.basic)) {
        continue;
      }

      foreach(ally in allies) {
        if(zombie.favoriteenemy === ally) {
          ally.doa.var_ab338943++;
          break;
        }
      }
    }

    waitframe(1);
  }
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_33f06519));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_459fdfeaf87cae96", &function_33f06519);
  assert(isscriptfunctionptr(&function_dbce9550));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2aebaa8271a615b", &function_dbce9550);
  assert(isscriptfunctionptr(&function_b87b3fef));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"doawaskilledbytesla", &function_b87b3fef);
  assert(isscriptfunctionptr(&function_e90927b7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2e09996956de0a27", &function_e90927b7);
  assert(!isDefined(&function_9b6830c9) || isscriptfunctionptr(&function_9b6830c9));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_fbdc2cc4) || isscriptfunctionptr(&function_fbdc2cc4));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_1a0fd593ee4f4d13", &function_9b6830c9, undefined, &function_fbdc2cc4);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_73a2a53598a6f94c", undefined, undefined, undefined);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_3793e8ada1f18447", undefined, undefined, undefined);
  assert(!isDefined(&function_1f0241e) || isscriptfunctionptr(&function_1f0241e));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2e49b8797978f93e", &function_1f0241e, undefined, undefined);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_16f749aefbd4ce23", undefined, undefined, undefined);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombieidleaction", undefined, undefined, undefined);
  assert(!isDefined(&zombietraverseaction) || isscriptfunctionptr(&zombietraverseaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&zombietraverseactionterminate) || isscriptfunctionptr(&zombietraverseactionterminate));
  behaviortreenetworkutility::registerbehaviortreeaction(#"zombietraverseaction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
  assert(isscriptfunctionptr(&function_abb6c18a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_70f5a4ae6dc526d3", &function_abb6c18a);
  assert(isscriptfunctionptr(&function_e5fc1f3c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18eef53c3b7c9c68", &function_e5fc1f3c);
  assert(isscriptfunctionptr(&function_99ed5179));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ceb7142be5709e8", &function_99ed5179);
  assert(isscriptfunctionptr(&function_50547dae));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6c4bbcf0db9f4832", &function_50547dae);
  assert(isscriptfunctionptr(&zombieshouldknockdown));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
  assert(isscriptfunctionptr(&zombieknockdownactionstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieknockdownactionstart", &zombieknockdownactionstart);
  assert(isscriptfunctionptr(&function_c8939973));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_a6273a84b4237ce", &function_c8939973);
  assert(isscriptfunctionptr(&zombiegetupactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegetupactionterminate", &zombiegetupactionterminate);
  assert(isscriptfunctionptr(&shouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &shouldstun);
  assert(isscriptfunctionptr(&shouldstun));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ed5637600484f3c", &shouldstun);
  assert(!isDefined(&function_645230f8) || isscriptfunctionptr(&function_645230f8));
  assert(!isDefined(&function_83a9ca0f) || isscriptfunctionptr(&function_83a9ca0f));
  assert(!isDefined(&function_4bc5ddbb) || isscriptfunctionptr(&function_4bc5ddbb));
  behaviortreenetworkutility::registerbehaviortreeaction(#"stunaction", &function_645230f8, &function_83a9ca0f, &function_4bc5ddbb);
  assert(isscriptfunctionptr(&stunstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f551ce50701a441", &stunstart);
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_83a9ca0f) || isscriptfunctionptr(&function_83a9ca0f));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_5ab8d15ff77f1b6f", undefined, &function_83a9ca0f, undefined);
  assert(isscriptfunctionptr(&function_de68bf47));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_e568b63ec039220", &function_de68bf47);
  assert(isscriptfunctionptr(&function_e2da0652));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2363b19a9d5f0aa8", &function_e2da0652);
}

function function_52fd55a() {}

function function_17d3b57() {
  curcount = namespace_ec06fe4a::function_38de0ce8();

  if(isDefined(level.doa.var_39e3fa99) && namespace_4dae815d::function_59a9cf1d() == 0) {
    available = [[level.doa.var_39e3fa99]] - > function_c892290a() - curcount;
    return available;
  }

  if(namespace_4dae815d::function_59a9cf1d() == 5) {
    return (40 - curcount);
  }

  if(namespace_4dae815d::function_59a9cf1d() == 4) {
    return (40 - curcount);
  }

  assert(0);
  return 40 - curcount;
}

function function_60f6a9e() {
  if(is_true(level.doa.var_1b8c7044)) {
    return false;
  }

  if(isDefined(level.hostmigrationtimer)) {
    return false;
  }

  var_b4c55c59 = namespace_ec06fe4a::function_fb4eb048(#"axis");

  if(isDefined(level.doa.var_39e3fa99) && namespace_4dae815d::function_59a9cf1d() == 0) {
    if(var_b4c55c59 >= [[level.doa.var_39e3fa99]] - > function_c892290a()) {
      return false;
    }
  }

  if(namespace_4dae815d::function_59a9cf1d() == 5) {
    if(var_b4c55c59 >= 40) {
      return false;
    }
  } else if(namespace_4dae815d::function_59a9cf1d() == 4) {
    if(var_b4c55c59 >= 40) {
      return false;
    }
  }

  var_1c446dd6 = namespace_ec06fe4a::function_38de0ce8();

  if(var_1c446dd6 >= 40) {
    return false;
  }

  return true;
}

function function_252dff4d(name, aitype, var_d240d5de, var_41157a40, unlocklevel, var_c8ceaddf = undefined, chance = 100) {
  if(!isDefined(level.doa.var_3a73503f)) {
    level.doa.var_3a73503f = [];
  }

  assert(isDefined(aitype));
  struct = spawnStruct();
  struct.name = name;
  struct.type = aitype;
  struct.var_d240d5de = var_d240d5de;
  struct.var_41157a40 = var_41157a40;
  struct.var_c8ceaddf = var_c8ceaddf;
  struct.spawnchance = chance;
  struct.unlocklevel = isDefined(unlocklevel) ? unlocklevel : -1;
  struct.var_71e54e3a = [];

  if(aitype != -1 && aitype <= 29) {
    level.doa.var_695258a5 |= 1 << aitype;
    level.doa.var_4eb7c3f0++;
  }

  foreach(spawner in level.doa.var_3a73503f) {
    if(spawner.type == aitype && aitype != -1) {
      assert(0, "<dev string:x38>");
    }
  }

  level.doa.var_3a73503f[level.doa.var_3a73503f.size] = struct;
}

function function_d1bc3f11(var_463f7b07, reset = 0) {
  assert(var_463f7b07 >= 0, "<dev string:x53>");

  if(reset) {
    level.doa.var_329c97a3 = [];
  }

  foreach(entry in level.doa.var_3a73503f) {
    if(entry.unlocklevel == -1) {
      continue;
    }

    if(entry.unlocklevel <= var_463f7b07) {
      def = doa_enemy::function_251ee3bd(entry.name);
      [[def]] - > function_7edd7727(6);
    }
  }
}

function function_2c6dd74c(spawner) {
  foreach(reg in level.doa.var_3a73503f) {
    if(reg.name === spawner.script_noteworthy) {
      return reg;
    }
  }

  return undefined;
}

function function_3dd94c25(name) {
  foreach(reg in level.doa.var_3a73503f) {
    if(reg.name === name) {
      return reg;
    }
  }

  return undefined;
}

function function_fce39c7a() {
  self notify("5639eeefb2d08db2");
  self endon("5639eeefb2d08db2");
  self endon(#"death");
  self.var_968a296f = undefined;
  result = self waittill(#"bad_path");

  if(!isDefined(self.doa.var_baa2991d)) {
    self.doa.var_baa2991d = 0;
  }

  self.doa.var_baa2991d++;
  self.var_968a296f = 1;
  nextpos = getclosestpointonnavmesh(result.position, 128, self getpathfindingradius());

  if(isDefined(nextpos)) {
    namespace_1e25ad94::debugmsg("Entity " + (isDefined(self.entnum) ? self.entnum : self getentitynumber()) + " got a bad path notification going to: " + result.position + ". Redirecting to: " + nextpos + " BP Count = " + self.doa.var_baa2991d);
    self function_41354e51(nextpos, 1);
    self.var_72283e28 = gettime() + 10000;
    result = self waittilltimeout(10, #"goal");

    if(result._notify == "goal") {
      self.doa.var_baa2991d = 0;
      self.var_72283e28 = 0;
    }
  }

  self thread function_fce39c7a();
}

function function_472bf4() {
  if(!isactor(self)) {
    return;
  }

  self endon(#"death");

  while(true) {
    level thread namespace_1e25ad94::debugline(self.origin, self.goalpos, 0.05, self haspath() ? (0, 1, 0) : (1, 0, 0));
    level thread namespace_1e25ad94::function_b57a9d84(self.goalpos, 0, 20, 20, 20, 0.05, self isatgoal() ? (0, 1, 0) : (1, 0, 0));
    waitframe(1);
  }
}

function function_d138afd9() {
  if(self.zombie_type === # "silverback") {
    return;
  }

  self endon(#"hash_717d9188a95b458f");
  self waittill(#"death");

  if(is_true(self.marked_for_death) && isDefined(level.doa.var_a77e6349)) {
    return;
  }

  if(isDefined(self.var_d1fac34a)) {
    if(isinarray(self.var_d1fac34a.enemylist, self)) {
      arrayremovevalue(self.var_d1fac34a.enemylist, self);
    }

    self.var_d1fac34a = undefined;
  }

  spot = self.origin;
  roll = randomint(100);
  level namespace_dfc652ee::function_68442ee7(spot, 20, 128, 1);

  if(roll > 25) {
    level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_boots"), spot + (randomintrange(-40, 40), randomintrange(-40, 40), 0), undefined, undefined, 1);
  }

  if(roll > 35) {
    level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_boxing_glove"), spot + (randomintrange(-40, 40), randomintrange(-40, 40), 0), undefined, undefined, 1);
  }

  if(roll > 65) {
    level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_gift_box"), spot + (randomintrange(-40, 40), randomintrange(-40, 40), 0), undefined, undefined, 1);
  }

  if(roll > 75) {
    level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_chicken"), spot + (randomintrange(-40, 40), randomintrange(-40, 40), 0), undefined, undefined, 1);
  }

  if(roll > 95) {
    level namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_potion_orange"), spot + (randomintrange(-40, 40), randomintrange(-40, 40), 0), undefined, undefined, 1);
  }
}

function function_db744d28(var_370ac26d = getdvarint(#"hash_4321f22c262c3ad1", 1000)) {
  self.boss = 1;
  self.var_32c5c724 = 1;
  self.ignorevortices = 1;
  self.var_c7121c91 = 1;
  self.var_3505487 = 1;
  self.var_ae3a888 = 1;
  self.var_4dcf6637 = 1;
  self.var_b88e74c3 = 1;
  self.var_af545843 = 1;
  self.var_abe67a20 = 1;
  self.var_bbdaef90 = 1;
  self.var_d415ee14 = 1;
  self.var_47267079 = 1;
  self.var_2b989b2e = 1;
  self.var_9be3628d = array(0, 0, 0, 0);
  self.var_f979e699 = 5000;
  self thread function_d138afd9();
  self thread function_a25f74a5();
  self thread function_39451598(var_370ac26d);
  self notify(#"hash_71199e509f750629");
}

function ai_guard(radius = 1024, baseorigin) {
  self notify("64eed2939466a40");
  self endon("64eed2939466a40");
  self endon(#"death", #"hash_232ad18a32353b62");
  self notify(#"ai_guard");

  if(!isDefined(baseorigin)) {
    baseorigin = self.origin;
  }

  if(isDefined(self.target)) {
    base = struct::get(self.target);

    if(isDefined(base)) {
      baseorigin = base.origin;
    }
  }

  radiussq = sqr(radius);
  self.engagementdistance = radius;
  self.var_a84a3d40 = radiussq;
  self.var_2dc9f085 = 0;
  self clearenemy();
  self.favoriteenemy = undefined;
  self.lastknownenemypos = undefined;
  self.var_860a34b9 = undefined;
  self function_41354e51(baseorigin, 1);
  self.var_101082d1 = 0;
  var_92c9a6e = int(self.maxhealth * 0.02);
  var_71110327 = baseorigin;
  points = getrandomnavpoints(baseorigin, radius >> 1, 32, 30);
  self thread function_572e5496(radius, baseorigin);

  while(true) {
    wait 1;
    time = gettime();
    self.var_4bd563dd = 0;

    if(!isDefined(self.enemy)) {
      if(time < self.var_2dc9f085 + 5000) {
        continue;
      }

      self.var_101082d1--;

      if(self.var_101082d1 > 0) {
        continue;
      }

      var_71110327 = baseorigin;

      if(isDefined(points) && points.size) {
        var_71110327 = points[randomint(points.size)];
      }

      self.zombie_move_speed = "walk";
      self.var_860a34b9 = var_71110327;
      self function_41354e51(var_71110327, 1, 1);
      self waittilltimeout(15, #"goal", #"enemy");
      self.var_101082d1 = randomint(20);
      continue;
    }

    self.var_860a34b9 = undefined;
    self.var_2dc9f085 = time;
  }
}

function function_572e5496(radius, baseorigin) {
  self notify("7bfec1e63f142294");
  self endon("7bfec1e63f142294");
  self endon(#"death", #"ai_guard");
  wait 5;
  maxdist = radius + (radius >> 1);
  maxdistsq = sqr(maxdist);
  minhealth = int(self.maxhealth * 0.75);
  var_9b39fe40 = sqr(256);

  while(true) {
    wait 1;
    distsq = distancesquared(self.origin, baseorigin);

    if(distsq >= maxdistsq) {
      if(isDefined(self.enemy)) {
        distsq = distancesquared(self.origin, self.enemy.origin);

        if(distsq < var_9b39fe40) {
          continue;
        }
      }

      self notify(#"hash_232ad18a32353b62");
      self.var_834ad023 = 1;
      self clearenemy();
      self.favoriteenemy = undefined;
      self.lastknownenemypos = undefined;
      self.var_860a34b9 = baseorigin;
      self function_41354e51(baseorigin, 1, 1);
      result = self waittill(#"goal", #"damage");
      self.var_834ad023 = 0;

      if(result._notify === "goal") {
        if(self.health < minhealth) {
          self.health = minhealth;
        }
      }

      self thread ai_guard(radius, baseorigin);
      return;
    }
  }
}

function function_a25f74a5() {
  self endon(#"death");
  wait 1;
  var_a465da0e = int(self.maxhealth * 0.01);
  latch = 0;

  while(true) {
    if(!isDefined(self.enemy)) {
      if(latch == 0) {
        latch = 1;
        wait 8;
        continue;
      }

      self.health = math::clamp(self.health + var_a465da0e, 0, self.maxhealth);
      self thread namespace_ec06fe4a::function_2f4b0f9(self.health);
    } else {
      latch = 0;
    }

    wait 1;
  }
}

function function_39451598(var_370ac26d = getdvarint(#"hash_4321f22c262c3ad1", 1000)) {
  self endon(#"death");
  self notify("7415aa24bfa8ab0b");
  self endon("7415aa24bfa8ab0b");

  while(isDefined(self)) {
    waitresult = self waittill(#"damage");

    if(isDefined(waitresult.attacker) && isPlayer(waitresult.attacker)) {
      if(waitresult.amount >= self.health) {
        namespace_7f5aeb59::function_f8645db3(var_370ac26d);
        return;
      }
    }
  }
}

function function_25b2c8a9(spawner, str_targetname, force_spawn) {
  self function_166a9ab7();
  self clientfield::set("enable_on_radar", 1);
  self callback::function_d8abfc3d(#"on_ai_melee", &function_448dac71);
  self callback::function_d8abfc3d(#"on_ai_killed", &function_21ef174b);
  self thread function_fce39c7a();

  if(getdvarint(#"hash_207746eb90f92763", 0)) {
    self thread namespace_1e25ad94::debugorigin(999, 20, (1, 0, 0));
  }

  self.doa = spawnStruct();
  self.doa.birthtime = gettime();
  self.doa.stunned = 0;
  self.doa.original_origin = self.origin;
  self.doa.var_ab338943 = 0;
  self.doa.thinkrate = 0.25;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.pacifist = 0;
  self.ignorevortices = 1;
  self.goalradius = 20;
  self.var_b98d779c = 0.25;
  self.engagementdistance = 2400;
  self.var_a84a3d40 = sqr(self.engagementdistance);
  self.var_f578c3a2 = sqr(36);
  self.shouldspawn = 1;
  self.var_c0bd8c06 = 0;
  self.var_f6b9e96d = 0;
  self.missinglegs = 0;
  self.var_f9d01c76 = 0;
  self.var_4bd563dd = 0;
  self.var_f95bc76f = 0;
  self.meleedistsq = 1764;
  self.updatesight = 0;
  self.doa.var_37d6fd5 = 0;
  self.var_1b2af7dc = 1;
  self.entnum = self getentitynumber();
  self.var_f7f65924 = is_true(self.var_d55f22cb) ? 5 : 10;
  self.zombie_move_speed = is_true(level.doa.hardcoremode) ? "sprint" : isDefined(level.doa.var_13e8f9c9) ? level.doa.var_13e8f9c9 : "walk";
  self.var_72283e28 = 0;
  self.health = level.doa.zombie_health;
  self.maxhealth = level.doa.zombie_health;
  self.lastposition = self.origin;
  self.lastknowntime = 0;
  self.var_2a85c480 = 0;
  self.startposition = self.origin;
  self.zombie_type = isDefined(self.spawndef) ? [[self.spawndef]] - > getname() : "unknown AI";

  if(isactor(self)) {
    self pathmode("move allowed");
    self collidewithactors(1);
    self thread updatespeed();
  }

  self setavoidancemask("avoid none");
  self thread function_9ee1ee56();
  self thread function_60c093e1();
  self thread function_fc77d638();

  if(getdvarint(#"hash_44eeefdc002143f7", 0)) {
    self thread function_472bf4();
  }

  gamestate = namespace_4dae815d::function_59a9cf1d();

  if(gamestate == 5) {
    self.var_9b6df834 = level.var_79a3ec93;
  } else if(gamestate == 4) {
    self.var_9b6df834 = level.var_48894e85;
  } else if(gamestate == 0) {
    self.var_9b6df834 = level.var_7d6449a0;
  }

  if(namespace_4dae815d::function_59a9cf1d() == 0 && !isDefined(level.doa.var_6f3d327)) {
    self thread namespace_ec06fe4a::function_aef7e3f6();
    self thread namespace_ec06fe4a::function_2552a0a0();
  }

  if(isDefined(self.target)) {
    base = struct::get(self.target);

    if(isDefined(base)) {
      if(!isDefined(base.radius)) {
        base.radius = 1024;
      }

      self thread ai_guard(int(base.radius), base.origin);
    }
  }
}

function function_fc77d638() {
  self endon(#"death");
  self disableaimassist();
  waitframe(1);

  while(is_true(self.var_1f2d0447)) {
    wait 1;
  }

  self enableaimassist();
}

function function_60c093e1() {
  self notify("4750b5b4dd7f0de1");
  self endon("4750b5b4dd7f0de1");
  self endon(#"death", #"hash_2ca65c35156a24dc");
  level waittill(#"doa_game_is_over");
  self thread namespace_ec06fe4a::function_570729f0(randomfloatrange(1, 5));
}

function function_166a9ab7() {
  self.__blackboard = undefined;
  blackboard::createblackboardforentity(self);
  ai::createinterfaceforentity(self);
  self.___archetypeonanimscriptedcallback = &function_deb871fd;
  self.___archetypeonbehavecallback = &function_c61d79a9;
}

function private function_c61d79a9(entity) {}

function private function_deb871fd(entity) {
  self.__blackboard = undefined;
  self function_166a9ab7();
}

function function_c1f37cab() {
  if(!isDefined(self)) {
    return;
  }

  if(gettime() < self.var_f9d01c76) {
    return;
  }

  if(is_true(self.boss)) {
    return;
  }

  if(is_true(self.var_76cb41b3)) {
    return;
  }

  if(isDefined(self.var_28313669)) {
    return;
  }

  if(isDefined(self.var_d1fac34a) && isactor(self) && self isatgoal()) {
    return;
  }

  self.var_f9d01c76 = gettime() + 1000;
  dist = distancesquared(self.lastposition, self.origin);
  self.lastposition = self.origin;

  if(dist < sqr(12)) {
    self.var_4bd563dd++;
  } else {
    self.var_4bd563dd = 0;
  }

  if(isDefined(self.var_c8b974fe)) {
    distsq = distancesquared(self.origin, self.var_c8b974fe);

    if(distsq > self.var_32d07c96) {
      distsq = distancesquared(self.origin, self.goalpos);

      if(distsq < sqr(512)) {
        self.var_4bd563dd++;
      } else {
        self.var_4bd563dd = self.var_f7f65924;
      }
    }

    if(gettime() - self.doa.birthtime > 30000) {
      self.var_4bd563dd = self.var_f7f65924;
    }
  }

  if(self.origin[2] < -2300) {
    self.var_4bd563dd = self.var_f7f65924;
  }

  if(self.var_4bd563dd >= self.var_f7f65924 && !is_true(self.var_227e7c79)) {
    self.var_28313669 = gettime();
    self doa_enemy::function_c89f6305();

    if(isDefined(self.var_5603780)) {
      [[self.var_5603780]]();
      return;
    }

    assert(!is_true(self.boss));
    self.var_c0bd8c06 = 1;
    self thread namespace_ec06fe4a::deletemeonnotify(#"hash_12b1eb419a23e3bd");
    self thread namespace_ec06fe4a::function_570729f0(5);
  }
}

function function_8f172270(target) {
  if(is_true(self.var_1f2d0447)) {
    return;
  }

  if(!isvehicle(self)) {
    function_c1f37cab();
  }

  self.lastknownenemypos = self function_bd5a9fa6();

  if(isDefined(self.lastknownenemypos)) {
    self function_41354e51(self.lastknownenemypos);
  }
}

function function_9ee1ee56() {
  self endon(#"death");

  if(!isDefined(level.doa.var_6f3d327) && level.doa.world_state == 0) {
    self.arena = level.doa.var_39e3fa99;
  }

  if(!isDefined(self.arena)) {
    return;
  }

  center = [[self.arena]] - > function_ffcf1d1();
  minz = center[2] - 1000;

  while(true) {
    if(self.arena !== level.doa.var_39e3fa99) {
      namespace_1e25ad94::debugmsg("Enemy " + (isDefined(self.aitype) ? self.aitype : self.classname) + " at (" + self.origin + ") was killed for not being in the active arena!", 1);
      self.takedamage = 1;
      self.allowdeath = 1;
      self dodamage(self.health + 187, self.origin);
    }

    if(self.origin[2] < minz) {
      type = self.aitype;

      if(!isDefined(type)) {
        if(isvehicle(self)) {
          type = self.spawner.script_noteworthy;
        }
      }

      namespace_1e25ad94::debugmsg("Enemy " + type + " at (" + self.origin + ") was killed for being beneath the minZ value!", 1);
      self.takedamage = 1;
      self.allowdeath = 1;
      self dodamage(self.health + 187, self.origin);
    }

    distsq = distancesquared(center, self.origin);

    if(distsq > sqr(2048)) {
      namespace_1e25ad94::debugmsg("Enemy " + (isDefined(self.aitype) ? self.aitype : self.classname) + " at (" + self.origin + ") was killed for being to far from center (" + center + ") Dist:" + distsq, 1);
      self.takedamage = 1;
      self.allowdeath = 1;
      self dodamage(self.health + 187, self.origin);
    }

    wait 1;
  }
}

function function_89c95270() {
  self endon(#"death");
  result = function_e00f51af(self);
  self function_4b49bf0d();

  if(result === 0) {
    function_8f172270(self.enemy);
  }
}

function function_8971bbb7() {
  self endon(#"death");
  waitframe(1);

  while(true) {
    if(self function_cf2c9af()) {
      self function_89c95270();
    }

    wait self.doa.thinkrate;
  }
}

function function_1bbf4511(origin, onpath, context) {
  assert(isDefined(onpath));
  self endon(#"death");

  if(!is_true(self.boss) && isDefined(self.var_9b6df834)) {
    [[self.var_9b6df834]] - > waitinqueue(self);

    if(context == 0) {
      onpath = self function_bd5a9fa6();
    }
  }

  if(context == 1 || context == 2) {
    adjustedorigin = onpath;
  } else if(context == 0) {
    adjustedorigin = onpath;

    if(isDefined(self.enemy)) {
      if(is_true(self.var_968a296f) || self.var_f95bc76f === 10) {
        radius = self getpathfindingradius();
        adjustedorigin = getclosestpointonnavmesh(onpath, 72, radius + 4);

        if(!isDefined(adjustedorigin)) {
          adjustedorigin = onpath;
        }
      }
    }
  }

  onpath = adjustedorigin;
  assert(isDefined(onpath));

  if(isactor(self)) {}

  self setgoal(onpath);
  distsq = distancesquared(self.origin, onpath);
  frac = math::clamp(distsq / sqr(800), 0, 1);

  if(isDefined(self.zombie_move_speed)) {
    if(self.zombie_move_speed == "walk" || is_true(self.missinglegs)) {
      frac += 0.2;
    }

    if(self.zombie_move_speed == "sprint") {
      frac -= 0.2;
    }

    if(frac < 0.1) {
      frac = 0.1;
    }
  }

  repathdelay = int(frac * 800);

  if(repathdelay < 50) {
    repathdelay = 50;
  }

  if(isDefined(self.doa.var_492aef80) && repathdelay > self.doa.var_492aef80) {
    repathdelay = self.doa.var_492aef80;
  }

  self.var_72283e28 = gettime() + repathdelay;

  if(!self haspath() && (!isactor(self) || !self isatgoal())) {
    self.var_f95bc76f = math::clamp(self.var_f95bc76f + 1, 0, 10);
    self.var_72283e28 += randomintrange(200 * self.var_f95bc76f, 500 * self.var_f95bc76f);
    return;
  }

  self.var_f95bc76f = 0;
}

function function_41354e51(origin, force = 0, context = 0) {
  if(!isDefined(origin)) {
    return;
  }

  distsq = distancesquared(origin, self.origin);

  if(distsq > sqr(2500)) {
    if(!is_true(self.boss) && !isDefined(self.target)) {
      level thread namespace_1e25ad94::debugmsg("Killing Entity: " + self getentitynumber() + " for trying to path to target distance away: " + int(distance(self.origin, origin)) + " units");
      self thread namespace_ec06fe4a::function_570729f0(1);
    }

    return;
  }

  if(isDefined(self.spawndef)) {
    distsq = distancesquared(origin, self.spawndef.var_edee94ca.origin);

    if(distsq < sqr(128)) {
      origin = self.origin;
    }
  }

  if(is_true(self.boss) && !self haspath()) {
    force = 1;
  }

  if(force || gettime() >= self.var_72283e28) {
    setpath = 1;
  } else {
    setpath = 0;
  }

  if(!setpath) {
    distsq = distancesquared(origin, self.goalpos);
    var_5aad8687 = distancesquared(self.origin, self.goalpos);
    scale = max(1, var_5aad8687 / sqr(256));
    var_2773df6d = int(self.var_f578c3a2 * scale);

    if(distsq > var_2773df6d) {
      self.var_72283e28 -= 150;
    }

    return;
  }

  self function_1bbf4511(origin, self haspath(), context);
}

function function_622f5b91(var_77cbeb28) {
  i = 8;
  var_a8bd6ee9 = sqr(128);

  foreach(ally in var_77cbeb28) {
    ally.rank = i * 50;

    if(self.favoriteenemy === ally) {
      ally.rank += 100;
    }

    if(self.lastattacker === ally) {
      ally.rank += 40;
    }

    distsq = distancesquared(self.origin, ally.origin);

    if(distsq < var_a8bd6ee9) {
      amount = 300 - int(mapfloat(0, var_a8bd6ee9, 0, 300, distsq));
      ally.rank += amount;
    }

    i--;
  }

  myteam = getaiteamarray(self.team);

  foreach(guy in myteam) {
    if(!is_true(guy.basic) || guy == self) {
      continue;
    }

    foreach(ally in var_77cbeb28) {
      if(guy.favoriteenemy === ally) {
        ally.rank -= 20;
      }
    }
  }

  var_86411b18 = array::quick_sort(var_77cbeb28, &function_8f915b47);
  return var_86411b18;
}

function function_8f915b47(a, b) {
  return a.rank > b.rank;
}

function function_4b49bf0d() {
  if(self.birthtime === gettime()) {
    return undefined;
  }

  if(is_true(self.ignoreall)) {
    self clearenemy();
    self.favoriteenemy = undefined;
    return undefined;
  }

  if(!isDefined(self.enemy)) {
    self.favoriteenemy = undefined;
  }

  if(isDefined(self.favoriteenemy) && isalive(self.favoriteenemy)) {
    distsq = distancesquared(self.origin, self.favoriteenemy.origin);

    if(distsq > self.var_a84a3d40 || is_true(self.favoriteenemy.laststand)) {
      self.favoriteenemy = undefined;
    }
  }

  time = gettime();

  if(isDefined(self.favoriteenemy) && isalive(self.favoriteenemy)) {
    if(is_true(self.var_4f1b8d2b) || time < self.doa.var_37d6fd5) {
      return self.favoriteenemy;
    }
  }

  if(self.team != # "allies") {
    time = gettime();
    validtargets = arraycombine(getaiteamarray("allies"), namespace_7f5aeb59::function_518c4c78(), 0, 0);
    targets = [];

    foreach(target in validtargets) {
      distsq = distancesquared(self.origin, target.origin);

      if(distsq >= sqr(2500)) {
        continue;
      }

      if(!isDefined(level.doa.var_39e3fa99) && distsq >= self.var_a84a3d40) {
        continue;
      }

      if(isDefined(self.var_d04a8ee) && abs(target.origin[2] - self.origin[2]) >= self.var_d04a8ee) {
        continue;
      }

      if(isDefined(target.var_d57eeb7f) && target.var_d57eeb7f > 0) {
        continue;
      }

      if(is_true(self.var_ae3a888) && is_true(target.var_c497caa3)) {
        continue;
      }

      targets[targets.size] = target;
    }

    validtargets = targets;

    if(!isDefined(level.doa.var_39e3fa99) && isDefined(self.engagementdistance)) {
      sorted = arraysortclosest(validtargets, self.origin, 8, 0, self.engagementdistance);
    } else {
      sorted = arraysortclosest(validtargets, self.origin, 8);
    }

    if(sorted.size > 1 && level.doa.world_state == 0 && level.doa.var_6c58d51 == 0) {
      sorted = function_622f5b91(sorted);
    }
  } else {
    sorted = arraysortclosest(getaiteamarray("axis"), self.origin);
  }

  closest = undefined;

  foreach(target in sorted) {
    if(is_true(target.ignoreme)) {
      continue;
    }

    if(target.birthtime == time || target.doa.birthtime === time) {
      continue;
    }

    origin = target.origin;

    if(is_true(self.basic)) {
      if(isDefined(target.last_valid_position)) {
        origin = target.last_valid_position;
      }
    }

    if(is_true(self.var_3a001247) && !isDefined(closest)) {
      closest = target;
    }

    distsq = distancesquared(self.origin, origin);

    if(distsq <= self.meleedistsq) {
      closest = target;
      break;
    }

    if(is_true(self.var_5112b4b1)) {
      closest = target;
      break;
    }

    canpath = self findpath(self.origin, origin, 1, 0);

    if(!canpath) {
      radius = self getpathfindingradius();
      point = getclosestpointonnavmesh(origin, 72, radius + 4);

      if(!isDefined(point)) {
        continue;
      }

      canpath = self findpath(self.origin, point, 1, 0);

      if(!canpath) {
        if(isDefined(target.last_valid_position)) {
          canpath = self findpath(self.origin, target.last_valid_position, 1, 0);

          if(!canpath) {
            continue;
          }
        }
      }

      target.last_valid_position = point;
    }

    closest = target;
    break;
  }

  var_f65b257b = 99999999;

  if(isDefined(closest)) {
    var_f65b257b = distancesquared(closest.origin, self.origin);
  }

  if(isDefined(closest)) {
    if(closest !== self.favoriteenemy) {
      self setentitytarget(closest);
      self.favoriteenemy = closest;
      self.hasseenfavoriteenemy = 0;
    }

    self.doa.var_37d6fd5 = time + randomintrange(2000, 4000);
  } else {
    self clearenemy();
    self.favoriteenemy = undefined;
  }

  return self.favoriteenemy;
}

function function_e00f51af(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.doa)) {
    return 2;
  }

  if(level flag::get("doa_game_is_over")) {
    behaviortreeentity function_41354e51(behaviortreeentity.origin, undefined, 2);
    return 2;
  }

  if(isDefined(behaviortreeentity.var_860a34b9)) {
    behaviortreeentity function_41354e51(behaviortreeentity.var_860a34b9, undefined, 1);
    return 1;
  }

  if(isDefined(behaviortreeentity.doa) && behaviortreeentity.doa.stunned == 1) {
    self function_41354e51(self.doa.var_db417b61, undefined, self.doa.var_33b29baf);
    return self.doa.var_33b29baf;
  }

  if(!is_true(behaviortreeentity.var_1c8b76d3)) {
    poi = namespace_ec06fe4a::function_ff7594d7(behaviortreeentity.origin);

    if(isDefined(poi)) {
      behaviortreeentity.doa.poi = poi;
      origin = poi.origin;
      behaviortreeentity function_41354e51(origin, undefined, 1);
      return 1;
    }
  }

  if(isDefined(behaviortreeentity.enemy) && (behaviortreeentity.enemy.team == behaviortreeentity.team || is_true(behaviortreeentity.enemy.laststand))) {
    behaviortreeentity clearenemy();
    behaviortreeentity.favoriteenemy = undefined;
  }

  return 0;
}

function function_bb0817aa(curspeed) {
  if(isDefined(self.var_35ee5f2c)) {
    return "crawl";
  }

  if(isDefined(self.var_f00db61)) {
    return "walk";
  }

  if(isDefined(self.var_237cb7a4)) {
    return "run";
  }

  if(isDefined(self.var_9658ee9f)) {
    return "sprint";
  }

  if(curspeed == "walk") {
    return "run";
  } else if(curspeed == "run") {
    return "sprint";
  }

  return "sprint";
}

function function_6caf68(curspeed) {
  if(isDefined(self.var_35ee5f2c)) {
    return "crawl";
  }

  if(isDefined(self.var_f00db61)) {
    return "walk";
  }

  if(isDefined(self.var_237cb7a4)) {
    return "run";
  }

  if(isDefined(self.var_9658ee9f)) {
    return "sprint";
  }

  if(curspeed == "run") {
    return "walk";
  } else if(curspeed == "sprint") {
    return "run";
  } else if(curspeed == "super_sprint") {
    return "sprint";
  }

  return "walk";
}

function private function_16aba2a6() {
  self endon(#"death");
  self endon(#"hash_f7f7d6234100d72");

  while(level flag::get("doa_round_spawning")) {
    wait 1;
  }

  while(true) {
    wait randomintrange(1, 4);

    if(self.team != # "axis") {
      continue;
    }

    speed = self.zombie_move_speed;

    if(is_true(self.var_bb68380c)) {
      if(level flag::get("doa_round_spawning") == 0) {
        left = namespace_ec06fe4a::function_fb4eb048("axis");

        if(left <= 6) {
          if(is_true(self.missinglegs) && !is_true(self.var_c3ce559a)) {
            self thread namespace_ec06fe4a::function_570729f0(randomfloatrange(1, 5));
          }

          self.zombie_move_speed = function_bb0817aa(self.zombie_move_speed);
        }
      }
    }

    if(!is_true(self.var_bb68380c) && isDefined(self.var_4bd563dd) && self.var_4bd563dd > 2) {
      self.zombie_move_speed = function_6caf68(self.zombie_move_speed);
    }

    if(speed != self.zombie_move_speed) {
      self notify(#"speed_change");
    }
  }
}

function updatespeed() {
  if(is_true(level.doa.hardcoremode)) {
    self.zombie_move_speed = "sprint";
    return;
  }

  self thread function_16aba2a6();

  if(isDefined(level.doa.var_13e8f9c9)) {
    self.zombie_move_speed = level.doa.var_13e8f9c9;
    return;
  }

  if(is_true(level.doa.world_state == 4)) {
    self.var_9658ee9f = 1;
  }

  if(isDefined(self.var_35ee5f2c)) {
    self.zombie_move_speed = "crawl";
    return;
  }

  if(isDefined(self.var_f00db61)) {
    self.zombie_move_speed = "walk";
    return;
  }

  if(isDefined(self.var_237cb7a4)) {
    self.zombie_move_speed = "run";
    return;
  }

  if(isDefined(self.var_9658ee9f)) {
    self.zombie_move_speed = "sprint";
    return;
  }

  if(level.doa.roundnumber == 1) {
    self.zombie_move_speed = "walk";
    return;
  }

  rand = randomintrange(level.doa.var_f4cf4e3 - 24, level.doa.var_f4cf4e3 + 24);

  if(rand <= 60) {
    self.zombie_move_speed = "run";
    return;
  }

  self.zombie_move_speed = "sprint";
}

function function_bd5a9fa6() {
  if(isDefined(self.enemy) && isDefined(self.enemy.birthtime) && gettime() > self.enemy.birthtime) {
    if(isDefined(self.enemy.doa) && isDefined(self.enemy.doa.vehicle)) {
      if(isDefined(self.enemy.doa.var_baad518e)) {
        return self.enemy.doa.var_baad518e;
      } else {
        return self.enemy.doa.vehicle.origin;
      }
    }

    if(isDefined(self.enemy.last_valid_position)) {
      return self.enemy.last_valid_position;
    }

    self.lastknowntime = gettime();
    return self.enemy.origin;
  }

  if(self.lastknowntime + 8000 < gettime()) {
    self.lastknownenemypos = undefined;
  }

  if(isDefined(self.lastknownenemypos)) {
    return self.lastknownenemypos;
  }

  if(namespace_4dae815d::function_59a9cf1d() == 0) {
    return self.origin;
  }

  return self.startposition;
}

function getyawtoenemy() {
  pos = undefined;

  if(isDefined(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function function_33f06519(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  if(is_true(behaviortreeentity.enemy.ignoreme)) {
    return false;
  }

  if(is_true(behaviortreeentity.ignoreall)) {
    return false;
  }

  if(!isDefined(behaviortreeentity.meleedistsq)) {
    return false;
  }

  targetorigin = behaviortreeentity.enemy.origin;

  if(distance2dsquared(behaviortreeentity.origin, targetorigin) > behaviortreeentity.meleedistsq) {
    return false;
  }

  yaw = abs(getyawtoenemy());

  if(yaw > 45) {
    behaviortreeentity orientmode("face point", targetorigin);
    return false;
  }

  return true;
}

function function_b87b3fef(behaviortreeentity) {
  if(is_true(behaviortreeentity.tesla_death)) {
    return true;
  }

  return false;
}

function function_21ef174b(s_params) {
  self.meleeinfo = undefined;

  if(!is_true(self.var_63f6a059)) {
    roll = randomint(200);

    if(roll == 0) {
      namespace_dfc652ee::function_68442ee7(self.origin, 1, 12, 1, 1);
    }
  }

  level.doa.var_afae28e0++;
  attacker = s_params.eattacker;

  if(isDefined(attacker) && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(isDefined(attacker)) {
    if(!is_true(self.var_d55f22cb) && isPlayer(attacker)) {
      attacker namespace_eccff4fb::enemykill(self.var_22b748b, self.var_f979e699);
    }

    if(!isDefined(self.var_22b748b) || self.var_22b748b == -1) {
      return;
    }

    if(isPlayer(attacker) && isDefined(attacker.doa.var_9c66788e)) {
      attacker[[attacker.doa.var_9c66788e]](self.var_22b748b);
    }

    if(is_true(self.boss)) {
      if(namespace_4dae815d::function_59a9cf1d() >= 4 && isDefined(level.doa.var_be3ad33f)) {
        level.doa.var_be3ad33f++;
      }

      foreach(player in getplayers()) {
        if(isbot(player)) {
          continue;
        }

        if(player === attacker) {
          continue;
        }

        entnum = player getentitynumber();

        if(entnum >= self.var_9be3628d.size) {
          continue;
        }

        if(self.var_9be3628d[entnum] > 0 && isDefined(player.doa.var_9c66788e)) {
          player[[player.doa.var_9c66788e]](self.var_22b748b);
        }
      }
    }
  }
}

function function_448dac71() {
  self.var_4bd563dd = 0;
}

function function_9b6830c9(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity pathmode("dont move");
  return 5;
}

function function_fbdc2cc4(entity, asmstatename) {
  asmstatename pathmode("move allowed");
  return 4;
}

function function_1f0241e(behaviortreeentity, asmstatename) {
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_6aac668f() {
  if(is_true(self.var_e5ad72a0) || is_true(self.var_1f2d0447)) {
    return true;
  }

  return false;
}

function function_cf2c9af() {
  if(is_true(self.var_834ad023)) {
    return false;
  }

  if(self function_6aac668f()) {
    return false;
  }

  return true;
}

function stunstart(behaviortreeentity) {
  behaviortreeentity pathmode("dont move", 1);
  callback::callback(#"hash_1eda827ff5e6895b");
}

function function_de68bf47(behaviortreeentity) {
  behaviortreeentity pathmode("move allowed");
  callback::callback(#"hash_210adcf09e99fba1");
}

function function_645230f8(behaviortreeentity, asmstatename) {
  stunstart(behaviortreeentity);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_83a9ca0f(behaviortreeentity, asmstatename) {
  if(asmstatename ai::is_stunned()) {
    return 5;
  }

  return 4;
}

function function_4bc5ddbb(behaviortreeentity, asmstatename) {
  function_de68bf47(asmstatename);
  return 4;
}

function function_dbce9550(behaviortreeentity) {
  if(self function_6aac668f()) {
    return false;
  }

  if(self isatgoal()) {
    return false;
  }

  return behaviortreeentity.allowoffnavmesh || behaviortreeentity haspath();
}

function private function_e90927b7(entity) {
  return entity.var_85c3882d === 1;
}

function shouldstun(entity) {
  return entity ai::is_stunned() && function_5c82fd66(entity);
}

function private function_5c82fd66(entity) {
  return true;
}

function zombietraverseaction(behaviortreeentity, asmstatename) {
  aiutility::traverseactionstart(behaviortreeentity, asmstatename);
  behaviortreeentity.var_9ed3cc11 = behaviortreeentity function_e827fc0e();
  behaviortreeentity pushplayer(1);
  behaviortreeentity callback::callback(#"hash_1518febf00439d5");
  return 5;
}

function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
  aiutility::wpn_debug_bot_joinleave(behaviortreeentity, asmstatename);

  if(behaviortreeentity asmgetstatus() == "asm_status_complete") {
    if(!is_true(behaviortreeentity.missinglegs)) {
      behaviortreeentity collidewithactors(0);
      behaviortreeentity.enablepushtime = gettime() + 1000;
    }

    if(isDefined(behaviortreeentity.var_9ed3cc11)) {
      behaviortreeentity pushplayer(behaviortreeentity.var_9ed3cc11);
      behaviortreeentity.var_9ed3cc11 = undefined;
    }
  }

  behaviortreeentity callback::callback(#"hash_34b65342cbfdadac");
  return 4;
}

function function_abb6c18a(entity) {
  if(!is_true(entity.var_e5ad72a0)) {
    if(isDefined(entity.var_d1bf288)) {
      if(!isDefined(entity.despawntimer)) {
        entity.despawntimer = gettime() + entity.var_d1bf288;
      }
    }

    if(isDefined(entity.var_1038c5e0)) {
      entity namespace_83eb6304::function_3ecfde67(entity.var_1038c5e0);
    }

    entity.var_c0bd8c06 = undefined;
    entity.var_e5ad72a0 = 1;
    entity pathmode("dont move", 1);
  }

  return 4;
}

function function_e5fc1f3c(entity) {
  if(isDefined(entity.despawntimer)) {
    if(gettime() < entity.despawntimer) {
      return 5;
    }
  }

  return 4;
}

function function_99ed5179(entity) {
  if(isDefined(entity.var_df416181)) {
    entity namespace_83eb6304::function_3ecfde67(entity.var_df416181);
  }

  entity ghost();
  entity notsolid();
  entity notify(#"hash_12b1eb419a23e3bd");
  entity.var_e5ad72a0 = undefined;
  return 4;
}

function function_50547dae(entity) {
  return is_true(entity.var_c0bd8c06);
}

function function_dab7edc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
  self endon(#"death");

  if(eattacker === self) {
    return;
  }

  time = gettime();

  if(is_true(self.boss) && self.birthtime > time - 2000) {
    return;
  }

  if(isDefined(eattacker) && isDefined(eattacker.meleedamage)) {
    idamage = eattacker.meleedamage;
  }

  if(isDefined(einflictor) && einflictor.team == self.team || isDefined(eattacker) && eattacker.team == self.team) {
    self finishactordamage(einflictor, eattacker, 10, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
    return;
  }

  if(self.team == "allies") {
    idamage = math::clamp(idamage, 100, self.health);

    namespace_1e25ad94::debugmsg("<dev string:x6b>" + self.archetype + "<dev string:x7f>" + idamage);
  }

  if(is_true(self.basic)) {
    if(smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE") {
      var_5ab6fbf = level.doa.zombie_health / 1000;
      var_2c320110 = max(var_5ab6fbf * 0.4, 1);
      idamage = int(idamage * var_2c320110);
    }
  }

  if(isDefined(self.allowdeath) && self.allowdeath == 0 && idamage >= self.health) {
    idamage = self.health - 1;
  }

  self.lastattacker = eattacker;

  if(isDefined(self.fx) && self.health <= idamage) {
    self namespace_83eb6304::turnofffx(self.fx);
    self.fx = undefined;
  }

  if(isDefined(weapon) && isDefined(level.doa.var_d7e090f7[weapon.name])) {
    var_36ee3765 = level[[level.doa.var_d7e090f7[weapon.name]]](self, idamage, eattacker, vdir, smeansofdeath, weapon);

    if(isDefined(var_36ee3765)) {
      idamage += int(var_36ee3765);
    }
  }

  if(!is_true(self.boss)) {
    self namespace_ed80aead::function_5e680689(eattacker, idamage, smeansofdeath, weapon, var_fd90b0bb, shitloc, vdir);
  }

  if(smeansofdeath == "MOD_BURNED") {
    namespace_1e25ad94::debugmsg("<dev string:x91>" + idamage + "<dev string:xa0>" + self.health + (idamage < self.health ? "<dev string:xc2>" : "<dev string:xb1>"));
  }

  if(smeansofdeath == "MOD_CRUSH") {
    if(is_true(self.boss)) {
      idamage = 0;
    } else {
      idamage = self.health;
    }
  }

  if(isDefined(self.overrideactordamage)) {
    idamage = self[[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
  }

  if(isDefined(level.overrideactordamage)) {
    idamage = self[[level.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
  }

  if(isDefined(self.aioverridedamage)) {
    if(isarray(self.aioverridedamage)) {
      foreach(cb in self.aioverridedamage) {
        idamage = self[[cb]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
      }
    } else {
      idamage = self[[self.aioverridedamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
    }
  }

  if(isDefined(eattacker) && isDefined(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(idamage >= self.health) {
    self zombie_eye_glow_stop();
  }

  var_5f32808d = 1;

  if(idamage >= 1000) {
    var_5f32808d = 2;
  } else if(idamage == 0) {
    var_5f32808d = 3;

    if(is_true(self.no_armor)) {
      var_5f32808d = 0;
    }
  }

  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
    var_799e18e5 = vpoint;
  } else {
    var_799e18e5 = self.origin + (0, 0, 60);
  }

  if(var_5f32808d > 0) {
    damage = idamage;

    if(damage >= 10) {
      damage = int(damage / 10);
    }

    hud::function_c9800094(eattacker, var_799e18e5, damage, var_5f32808d);
  }

  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.idflags = idflags;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.var_fd90b0bb = var_fd90b0bb;
  params.vpoint = vpoint;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.vdamageorigin = vdamageorigin;
  params.psoffsettime = timeoffset;
  self.var_ce1aa55f = time;
  self callback::callback(#"on_ai_damage", params);

  if(idamage > 0 && isPlayer(eattacker)) {
    if(is_true(self.boss)) {
      assert(isDefined(self.var_9be3628d));
      self.var_9be3628d[eattacker.entnum] += idamage;
    }

    if(!isDefined(eattacker.pers[# "damagedone"])) {
      eattacker.pers[# "damagedone"] = 0;
    }

    eattacker.pers[# "damagedone"] += idamage;
  }

  if(is_true(level.doa.var_598305fe)) {
    hud::function_c9800094(eattacker, vdamageorigin, idamage, idamage < 1000 ? 1 : 2);
  }

  self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
}

function function_9b31d191(einflictor, eattacker, idamage, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(vdir)) {
    self.damageinflictor = vdir;
  }

  self asmsetanimationrate(1);

  if(self.team == "allies") {
    namespace_1e25ad94::debugmsg("<dev string:xc6>" + self.archetype);
  }

  if(isDefined(self.fx)) {
    self namespace_83eb6304::turnofffx(self.fx);
  }

  if(randomint(100) < 50) {
    switch (randomint(3)) {
      case 0:
        self namespace_83eb6304::function_3ecfde67("headshot");
        break;
      case 1:
        self namespace_83eb6304::function_3ecfde67("headshot_nochunks");
        break;
      default:
        self namespace_83eb6304::function_3ecfde67("bloodspurt");
        break;
    }
  }

  if(!is_true(self.var_4dcf6637) && is_true(self.annihilate) || is_true(self.interdimensional_gun_kill) || isDefined(damagefromunderneath) && is_true(damagefromunderneath.bulletimpactexplode)) {
    self namespace_ed80aead::function_586ef822();

    if(is_true(self.interdimensional_gun_kill)) {
      namespace_dfc652ee::function_b8f6a8cd(level.doa.var_4b113826, self.origin + (0, 0, 40), 1, 1, 1, self.angles);
    }
  }

  if(isDefined(vdir)) {
    if(is_true(vdir.var_7b9e42c2)) {
      vdir.owner namespace_d2efac9a::function_6753bc5e();
      vdir.killcount++;
    } else {
      owner = isvehicle(vdir) ? vdir getvehicleowner() : isDefined(vdir.owner) ? vdir.owner : undefined;
      vehicle = isDefined(owner) && isDefined(owner.doa) ? owner.doa.vehicle : isvehicle(vdir) ? vdir : undefined;

      if(isDefined(vehicle)) {
        if(is_true(vehicle.var_b9bb0656) || is_true(vehicle.isplayervehicle)) {
          if(isDefined(owner) && isPlayer(owner)) {
            owner namespace_d2efac9a::vehiclekill();
          }
        }
      }
    }
  }

  if(isDefined(shitloc)) {
    if(isPlayer(shitloc)) {
      if(is_true(shitloc.doa.infps)) {
        shitloc namespace_d2efac9a::function_dc4e1885();
      }

      if(is_true(self.var_eeaac918) || is_true(self.var_6dc6e670)) {
        shitloc namespace_d2efac9a::function_dd188769();
      }
    }

    if(isactor(shitloc) && isDefined(shitloc.owner) && isPlayer(shitloc.owner)) {
      shitloc = shitloc.owner;
    }
  }

  if(timeoffset == "MOD_CRUSH") {
    assert(!is_true(self.boss));
    self namespace_ed80aead::function_1f275794(undefined, shitloc);

    if(isDefined(shitloc)) {
      shitloc notify(#"hash_6d92185248475f65");
    }
  }

  if(timeoffset == "MOD_ELECTROCUTED" && isDefined(vdir)) {
    dir = self.origin - vdir.origin;
    self thread namespace_ec06fe4a::function_b4ff2191(dir, 100, 0.1, vdir);
  }

  params = spawnStruct();
  params.einflictor = vdir;
  params.eattacker = shitloc;
  params.idamage = vdamageorigin;
  params.smeansofdeath = timeoffset;
  params.weapon = damagefromunderneath;
  params.vdir = modelindex;
  params.shitloc = partname;
  params.psoffsettime = vsurfacenormal;
  self callback::callback(#"on_ai_killed", params);
}

function function_c36e5cab(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(eattacker) && eattacker.team == self.team) {
    idamage = 0;
  }

  if(isDefined(self.owner) && isPlayer(self.owner) && is_true(self.playercontrolled)) {
    if(isDefined(eattacker) && is_true(eattacker.var_98801d44)) {}

    idamage = 0;
  }

  if(isDefined(self.overridevehicledamage)) {
    idamage = self[[self.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  } else if(isDefined(level.overridevehicledamage)) {
    idamage = self[[level.overridevehicledamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  }

  if(idamage == 0) {
    return;
  }

  var_5f32808d = 1;

  if(idamage >= 1000) {
    var_5f32808d = 2;
  }

  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
    var_799e18e5 = vpoint;
  } else {
    var_799e18e5 = self.origin + (0, 0, 60);
  }

  hud::function_c9800094(eattacker, var_799e18e5, int(idamage / 10), var_5f32808d);
  idamage = int(idamage);

  if(idamage > 0 && isPlayer(eattacker)) {
    if(!isDefined(eattacker.pers[# "damagedone"])) {
      eattacker.pers[# "damagedone"] = 0;
    }

    eattacker.pers[# "damagedone"] += idamage;
  }

  self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
}

function function_5800e038(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(isDefined(einflictor)) {
    self.damageinflictor = einflictor;
  }

  params = spawnStruct();
  params.einflictor = einflictor;
  params.eattacker = eattacker;
  params.idamage = idamage;
  params.smeansofdeath = smeansofdeath;
  params.weapon = weapon;
  params.vdir = vdir;
  params.shitloc = shitloc;
  params.psoffsettime = psoffsettime;
  self callback::callback(#"on_vehicle_killed", params);
  self callback::callback(#"on_ai_killed", params);

  if(isDefined(self.overridevehiclekilled)) {
    self[[self.overridevehiclekilled]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

function zombie_eye_glow_stop() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.no_eye_glow) || !self.no_eye_glow) {}
}

function approximate_path_dist(player) {
  aiprofile_beginentry("approximate_path_dist");
  goal_pos = player.origin;

  if(isDefined(player.last_valid_position)) {
    goal_pos = player.last_valid_position;
  }

  if(is_true(player.b_teleporting)) {
    if(isDefined(player.teleport_location)) {
      goal_pos = player.teleport_location;

      if(!ispointonnavmesh(goal_pos, self)) {
        position = getclosestpointonnavmesh(goal_pos, 100, 15);

        if(isDefined(position)) {
          goal_pos = position;
        }
      }
    }
  }

  approx_dist = pathdistance(self.origin, goal_pos, 1, self);
  aiprofile_endentry();
  return approx_dist;
}

function zombieshouldknockdown(behaviortreeentity) {
  if(!zombiehaslegs(behaviortreeentity)) {
    return false;
  }

  if(is_true(behaviortreeentity.knockdown)) {
    return true;
  }

  return false;
}

function zombiehaslegs(entity) {
  if(entity.missinglegs === 1) {
    return false;
  }

  return true;
}

function zombieknockdownactionstart(behaviortreeentity) {
  behaviortreeentity setblackboardattribute("_knockdown_direction", behaviortreeentity.knockdown_direction);
  behaviortreeentity setblackboardattribute("_knockdown_type", behaviortreeentity.knockdown_type);
  behaviortreeentity setblackboardattribute("_getup_direction", behaviortreeentity.getup_direction);
  behaviortreeentity collidewithactors(0);
  behaviortreeentity.blockingpain = 1;
}

function private function_c8939973(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
  behaviortreeentity.blockingpain = 0;
}

function private zombiegetupactionterminate(behaviortreeentity) {
  behaviortreeentity.knockdown = 0;
  behaviortreeentity collidewithactors(1);
}

function function_e2da0652(entity) {
  enemies = getaiarchetypearray(#"zombie");
  enemies = arraycombine(enemies, getaiarchetypearray(#"catalyst"), 0, 0);
  enemies = array::filter(enemies, 0, &function_3d752709, entity);

  foreach(enemy in enemies) {
    enemy setup_zombie_knockdown(entity);
    enemy.knockdown_type = "knockdown_shoved";
  }
}

function setup_zombie_knockdown(var_5f02306b, var_43b3242) {
  if(!isactor(self) || is_true(self.missinglegs) || is_true(self.var_5dd07a80) || is_true(self.isinmantleaction) || self isplayinganimscripted() || self function_dd070839() && !is_true(var_43b3242)) {
    return;
  }

  if(!isDefined(var_5f02306b)) {
    return;
  }

  self.knockdown = 1;

  if(isvec(var_5f02306b)) {
    zombie_to_entity = var_5f02306b - self.origin;
  } else {
    zombie_to_entity = var_5f02306b.origin - self.origin;
  }

  zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
  zombie_forward = anglesToForward(self.angles);
  zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
  zombie_right = anglestoright(self.angles);
  zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
  dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);

  if(dot >= 0.5) {
    self.knockdown_direction = "front";
    self.getup_direction = "getup_back";
    return;
  }

  if(dot < 0.5 && dot > -0.5) {
    dot = vectordot(zombie_to_entity_2d, zombie_right_2d);

    if(dot > 0) {
      self.knockdown_direction = "right";

      if(math::cointoss()) {
        self.getup_direction = "getup_back";
      } else {
        self.getup_direction = "getup_belly";
      }
    } else {
      self.knockdown_direction = "left";
      self.getup_direction = "getup_belly";
    }

    return;
  }

  self.knockdown_direction = "back";
  self.getup_direction = "getup_belly";
}

function function_3d752709(enemy, var_bd97c6ae) {
  if(!isDefined(enemy) || !isDefined(var_bd97c6ae)) {
    return false;
  }

  if(is_true(enemy.knockdown) || is_true(enemy.var_6edab899)) {
    return false;
  }

  if(gibserverutils::isgibbed(enemy, 384)) {
    return false;
  }

  if(distancesquared(enemy.origin, var_bd97c6ae.origin) > sqr(60)) {
    return false;
  }

  facingvec = anglesToForward(var_bd97c6ae.angles);
  enemyvec = enemy.origin - var_bd97c6ae.origin;
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

function function_5a481a84(player, dist = 100) {
  dist = distance(self.origin, player.origin);
  targetorigin = (player.origin[0], player.origin[1], self.origin[2]);
  var_a6470558 = vectornormalize(targetorigin - self.origin);
  aimeleerange = self.meleeweapon.aimeleerange;
  var_32708f81 = dist + aimeleerange;
  var_8cf8f805 = mapfloat(0, aimeleerange, dist, var_32708f81, dist);
  player playerknockback(1);
  player applyknockback(int(var_8cf8f805), var_a6470558);
  player playerknockback(0);
}

function function_422fdfd4(entity, attacker, weapon, var_5457dc44, hitloc, point, var_ebcb86d6, var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927) {
  var_8d3f5b7d = isalive(var_ebcb86d6) && isPlayer(var_ebcb86d6);
  var_84ed9a13 = function_de3dda83(var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927);
  registerzombie_bgb_used_reinforce = isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
  var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== # "armor";
  var_b1c1c5cf = 1;

  if(var_8d3f5b7d) {
    has_weakpoints = isDefined(namespace_81245006::function_fab3ee3e(self));

    if(var_30362eca && var_ebcb86d6 hasperk(#"specialty_mod_awareness")) {
      if(var_b1c1c5cf < 1) {
        var_b1c1c5cf += 0.2;
      } else {
        var_b1c1c5cf *= 1.2;
      }
    }
  }

  return {
    #damage_scale: var_b1c1c5cf, #var_84ed9a13: var_84ed9a13, #registerzombie_bgb_used_reinforce: registerzombie_bgb_used_reinforce
  };
}

function function_de3dda83(var_5457dc44, hitloc, point, var_ebcb86d6) {
  if(isDefined(var_ebcb86d6)) {
    var_84ed9a13 = var_ebcb86d6;
  } else {
    var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_37e3f011(self, var_5457dc44);
    }

    if(!isDefined(var_84ed9a13)) {
      var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
    }
  }

  return var_84ed9a13;
}

function function_e10af211(var_a349a77f, trailfx, impactfx = "turret_impact", var_f635f46a = 1, var_48f202a3 = 0) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  if(!isDefined(var_a349a77f)) {
    if(namespace_4dae815d::function_59a9cf1d() == 0) {
      var_a349a77f = [[level.doa.var_39e3fa99]] - > function_70fb5745().origin + (0, 0, 2000);
    } else {
      assert(0, "<dev string:xe1>");
    }
  }

  if(!isDefined(var_a349a77f)) {
    return;
  }

  self.spawnloc = {
    #origin: var_a349a77f, #angles: self.angles
  };

  if(isactor(self)) {
    self forceteleport(var_a349a77f, self.angles);
  } else {
    self.origin = var_a349a77f;
  }

  groundpos = namespace_ec06fe4a::function_65ee50ba(var_a349a77f, 32, -3000);

  if(is_true(var_f635f46a)) {
    var_13aa549b = namespace_ec06fe4a::spawnmodel(groundpos + (0, 0, 24), "tag_origin");

    if(isDefined(var_13aa549b)) {
      var_13aa549b namespace_83eb6304::function_3ecfde67("incoming_impact");
      var_13aa549b thread namespace_ec06fe4a::function_d55f042c(self, "death");
      var_13aa549b thread namespace_ec06fe4a::function_d55f042c(self, "dropped");
      var_13aa549b thread namespace_ec06fe4a::function_52afe5df(5);
    }
  }

  if(isDefined(trailfx)) {
    self namespace_83eb6304::function_3ecfde67(trailfx);
  }

  if(is_true(var_48f202a3)) {
    self thread function_abec6179(groundpos, 32, "dropped");
    self waittill(#"dropped");
  } else {
    var_9159be43 = namespace_ec06fe4a::spawnmodel(var_a349a77f, "tag_origin");

    if(isDefined(var_9159be43)) {
      var_9159be43 thread namespace_ec06fe4a::function_d55f042c(self, "death");
      var_9159be43 thread namespace_ec06fe4a::function_52afe5df(2.5);
      self linkto(var_9159be43);
      var_9159be43 moveto(groundpos, 2);
      var_9159be43 waittill(#"movedone");
      self notify(#"dropped");
      self unlink();
      var_9159be43 namespace_83eb6304::function_3ecfde67(impactfx);
    }
  }

  if(isDefined(trailfx)) {
    self namespace_83eb6304::turnofffx(trailfx);
  }
}

function function_abec6179(var_5a1d7118, proximity, note, timeout = 5) {
  self endon(#"death");
  var_b235b0cb = sqr(proximity);
  timeout = gettime() + timeout * 1000;

  while(gettime() < timeout) {
    if(distancesquared(self.origin, var_5a1d7118) <= var_b235b0cb) {
      break;
    }

    waitframe(1);
  }

  self notify(note);
}

function function_b5feb0bf() {
  self notify("1f41e11641a17d2d");
  self endon("1f41e11641a17d2d");
  self endon(#"death");

  if(isvehicle(self)) {
    return;
  }

  if(is_true(self.var_a592ffaa)) {
    return;
  }

  if(is_true(self.var_d33de52f)) {
    return;
  }

  self.var_4ee91a53 = gettime() + 5000;
  var_36313dca = isDefined(self.animrate) ? self.animrate : 1;

  if(self.team == # "axis") {
    animrate = 1.17;
  }

  if(self.team == # "allies") {
    animrate = 0.65;
  }

  if(isPlayer(self)) {
    self thread namespace_7f5aeb59::function_ec9a307f(5, animrate);
    return;
  } else if(isactor(self) && !isDefined(self.var_26471e4b)) {
    self.var_26471e4b = animrate;
    self asmsetanimationrate(animrate);
    self namespace_83eb6304::function_3ecfde67("nova_crawler_aura_fx");
  }

  while(gettime() < self.var_4ee91a53) {
    wait 0.5;
  }

  self.var_26471e4b = undefined;

  if(isactor(self) && isDefined(var_36313dca)) {
    self asmsetanimationrate(var_36313dca);
  }

  self namespace_83eb6304::turnofffx("nova_crawler_aura_fx");
  self.var_4ee91a53 = undefined;
}