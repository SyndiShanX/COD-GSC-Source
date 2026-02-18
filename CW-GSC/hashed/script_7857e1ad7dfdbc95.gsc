/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7857e1ad7dfdbc95.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_774302f762d76254;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_skeleton;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace namespace_d1abdcb5;

function init() {
  clientfield::register("scriptmover", "" + # "spartoi_reassemble_clientfield", 1, 1, "int");
  clientfield::register("actor", "" + # "hash_3a6a3e4ef0a1a999", 1, 1, "counter");
  clientfield::register("actor", "skel_spawn_fx", 1, 1, "counter");
  namespace_250e9486::function_252dff4d("skeleton", 12, &function_2ee0142d, undefined, 65);
  namespace_250e9486::function_252dff4d("skeleton_spear", -1, &function_a54cde8b, undefined);
  namespace_250e9486::function_252dff4d("skeleton_giant", 13, &function_30a4da95, undefined);
  assert(isscriptfunctionptr(&function_27745f02));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_131d230bd57fc075", &function_27745f02);
  assert(isscriptfunctionptr(&function_b11208a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ff3aed5e43634ee", &function_b11208a);
  assert(isscriptfunctionptr(&function_5a24dacc));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_545a1de0dddc4e02", &function_5a24dacc);
  assert(isscriptfunctionptr(&function_826b49d4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_8d9bd77480759bc", &function_826b49d4);
  assert(isscriptfunctionptr(&function_8e634de));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f53494fbc1fb570", &function_8e634de);
  assert(isscriptfunctionptr(&function_b4537f07));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2162befd5ace1b3d", &function_b4537f07);
  assert(isscriptfunctionptr(&function_a641b0ef));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ef21635535887a7", &function_a641b0ef);
  assert(isscriptfunctionptr(&function_e86abfca));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_49c7799480c40847", &function_e86abfca);
  assert(isscriptfunctionptr(&function_c4d9fd77));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_585e3f641c1990a6", &function_c4d9fd77);
  assert(isscriptfunctionptr(&function_3311572f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4e45ca62c0385e32", &function_3311572f);
  level.var_dd9ff360 = &function_af85a094;
  level.var_3291f056 = new throttle();
  [[level.var_3291f056]] - > initialize(1, float(function_60d95f53()) / 1000);
  level.var_64800a5a = &function_be0c9c8b;
  level.var_a5007a40 = &function_137603f;
  level.var_51e07970 = &function_e4ead132;
  level.doa.var_33daab96 = 0;
  level.var_8eaf991c = [];

  if(!isDefined(level.var_8eaf991c)) {
    level.var_8eaf991c = [];
  } else if(!isarray(level.var_8eaf991c)) {
    level.var_8eaf991c = array(level.var_8eaf991c);
  }

  level.var_8eaf991c[level.var_8eaf991c.size] = {
    #round: 10, #limit: 2
  };

  if(!isDefined(level.var_8eaf991c)) {
    level.var_8eaf991c = [];
  } else if(!isarray(level.var_8eaf991c)) {
    level.var_8eaf991c = array(level.var_8eaf991c);
  }

  level.var_8eaf991c[level.var_8eaf991c.size] = {
    #round: 30, #limit: 4
  };
  assert(isscriptfunctionptr(&function_6318bedf));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_706fe37c04dae8e1", &function_6318bedf);
}

function private function_8e634de(entity) {
  return gettime() > entity.var_6e5b38d9;
}

function private function_27745f02(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  if(!util::within_fov(entity.origin, entity.angles, entity.enemy.origin, 0.6)) {
    return false;
  }

  return gettime() > entity.var_95bfdd95 && entity cansee(self.enemy);
}

function private function_b11208a(entity) {
  if(!namespace_250e9486::function_60f6a9e()) {
    enemylist = getaiteamarray("axis");
    targets = [];

    foreach(enemy in enemylist) {
      if(is_true(enemy.boss) || !is_true(enemy.var_d55f22cb)) {
        continue;
      }

      targets[targets.size] = enemy;
    }

    sorted = arraysort(targets, entity.origin, 0, 8);

    foreach(guy in sorted) {
      guy thread namespace_ec06fe4a::function_570729f0();

      dist = distance2d(guy.origin, entity.origin);
      namespace_1e25ad94::debugmsg("<dev string:x38>" + guy getentitynumber() + "<dev string:x7d>" + (isDefined(guy.aitype) ? guy.aitype : guy.classname) + "<dev string:x89>" + guy.origin + "<dev string:x96>" + dist);
    }
  }

  return true;
}

function private function_5a24dacc(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  distsq = distancesquared(entity.enemy.origin, entity.origin);

  if(distsq < sqr(40) || distsq > sqr(210)) {
    return false;
  }

  if(!util::within_fov(entity.origin, entity.angles, entity.enemy.origin, 0.6)) {
    return false;
  }

  return gettime() > entity.var_60188515;
}

function private function_826b49d4(entity) {
  if(!isDefined(entity.enemy)) {
    return false;
  }

  distsq = distancesquared(entity.enemy.origin, entity.origin);

  if(distsq > sqr(120)) {
    return false;
  }

  if(!util::within_fov(entity.origin, entity.angles, entity.enemy.origin, 0.6)) {
    return false;
  }

  return gettime() > entity.var_249206b6;
}

function private function_c91fa191() {
  self endon(#"death");
  self notify("7debe29bdea3f840");
  self endon("7debe29bdea3f840");

  while(true) {
    result = self waittill(#"hash_4c72e79bdad8315e");
    result.ai namespace_83eb6304::function_3ecfde67("lightningStrike");
  }
}

function private function_e855118e() {
  self endon(#"death");
  self notify("497f128207c281cf");
  self endon("497f128207c281cf");
  self waittill(#"lightning");
  self namespace_83eb6304::function_3ecfde67("skeleton_hand_lightning");
  self waittill(#"lightning");
  self namespace_83eb6304::function_3ecfde67("skeleton_hand_lightning");
  self waittill(#"lightning");
  self namespace_83eb6304::function_3ecfde67("skeleton_hand_lightning");
  self waittill(#"hash_1ccd672f2fb11598");
  self namespace_83eb6304::function_3ecfde67("skeleton_hand_energy");
  self waittill(#"hash_2201232e09d14552");
  self namespace_83eb6304::turnofffx("skeleton_hand_energy");
  self thread function_c91fa191();
  amount = randomintrange(4, 8) + getplayers().size * randomint(4);
  doa_enemy::function_a6b807ea(self.var_33dcf942, randomintrange(4, 8), self.origin + anglesToForward(self.angles) * 40, 50, undefined, self.enemy, self, undefined, undefined, 1);
  self waittill(#"hash_2201232e09d14552");
  self namespace_83eb6304::turnofffx("skeleton_hand_energy");
}

function private function_b4537f07(entity) {
  entity pathmode("dont move", 1);
  entity thread function_e855118e();
  return 5;
}

function private function_fe8bad69() {
  self endon(#"death");
  self notify("4376a9b22db79d62");
  self endon("4376a9b22db79d62");
  self waittill(#"fire_eyes");

  if(isDefined(self.enemy)) {
    launchangles = self gettagangles("tag_eye");
    launchorigin = self gettagorigin("tag_eye");
    up = anglestoup(launchangles);
    launchorigin += up * (0, 0, -10);
    v_dir = anglesToForward(launchangles) * 50;
    v_right = anglestoright(launchangles) * 10;
    var_ce35a286 = launchorigin + v_dir + (0, 0, 80);

    if(namespace_ec06fe4a::function_a8975c67()) {
      missile = magicbullet(self.var_5ab15c1a, launchorigin + v_right, var_ce35a286, self, self.enemy);
      missile thread function_d63e2f4a();
    }

    wait 0.4;

    if(namespace_ec06fe4a::function_a8975c67()) {
      if(isDefined(self.enemy)) {
        missile = magicbullet(self.var_5ab15c1a, launchorigin - v_right, var_ce35a286, self, self.enemy);
        missile thread function_d63e2f4a();
      }
    }
  }
}

function function_d63e2f4a() {
  self endon(#"death");
  self.takedamage = 1;
  self enableaimassist();
  result = self waittill(#"damage");

  if(namespace_ec06fe4a::function_a8975c67()) {
    playFX("explosions/fx_exp_grenade_dirt", self.origin);
    playsoundatposition(#"zmb_doa_ai_bfather_missile_imp", self.origin);
  }

  self deletedelay();
}

function private function_c4d9fd77(entity) {
  entity pathmode("dont move", 1);
  entity.var_95bfdd95 = gettime() + randomintrange(10000, 16000);
  entity thread function_fe8bad69();
  return 5;
}

function private function_165f51f1() {
  self endon(#"death");
  self notify("73596e70f64ebb0e");
  self endon("73596e70f64ebb0e");
  self waittill(#"impact");
  var_29efcb02 = self gettagorigin("j_ball_ri");
  earthquake(1, 1, var_29efcb02, 64);
  playFX("doa/fx9_impact_turret_land", var_29efcb02);
  self namespace_83eb6304::function_3ecfde67("skel_stomp_impact");
  var_4d891710 = sqr(64);

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    if(distancesquared(var_29efcb02, player.origin) > var_4d891710) {
      continue;
    }

    player dodamage(145, var_29efcb02, self, self, "none", "MOD_EXPLOSIVE");
  }
}

function private function_a641b0ef(entity) {
  entity pathmode("dont move", 1);
  entity.var_60188515 = gettime() + randomintrange(6000, 16000) + 2000;
  entity thread function_165f51f1();
  return 5;
}

function private function_724727fb() {
  self endon(#"death");
  self notify("7883cd7298d87ed6");
  self endon("7883cd7298d87ed6");
  self waittill(#"impact");
  forward = anglesToForward(self.angles);
  var_29efcb02 = self.origin + forward * 150;
  earthquake(1, 1, var_29efcb02, 92);
  playFX("explosions/fx_exp_grenade_dirt", var_29efcb02);
  var_4d891710 = sqr(92);

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    if(distancesquared(var_29efcb02, player.origin) > var_4d891710) {
      continue;
    }

    player dodamage(145, var_29efcb02, self, self, "none", "MOD_EXPLOSIVE");
  }
}

function private function_e86abfca(entity) {
  entity pathmode("dont move", 1);
  entity.var_249206b6 = gettime() + randomintrange(6000, 16000) + 2000;
  entity thread function_724727fb();
  return 5;
}

function private function_3311572f(entity) {
  entity.var_6e5b38d9 = gettime() + randomintrange(8000, 16000);
  entity pathmode("move allowed");
  return 4;
}

function function_e7667c0d() {
  self endon(#"death");

  while(true) {
    if(isDefined(self.enemy) && !self haspath()) {
      self.var_6e5b38d9 -= 2500;
      self.var_95bfdd95 -= 3500;
      self.var_60188515 -= 1500;
      self.var_249206b6 -= 500;
    }

    wait 1;
  }
}

function function_30a4da95() {
  self namespace_250e9486::function_25b2c8a9();
  self namespace_250e9486::function_db744d28();
  self.health = 400000 + int(150000 * namespace_ec06fe4a::function_ef369bae());
  self.maxhealth = self.health;
  self.var_418bd7f0 = 0;
  self.should_zigzag = 0;
  self setavoidancemask("avoid ai");
  self.var_63d2fce2 = &function_979c19d0;
  self.is_zombie = 1;
  self.no_gib = 1;
  self.var_3a001247 = 1;
  self.meleedistsq = sqr(185);
  self.goalradius = 128;
  self.engagementdistance = 2400;
  self.var_a84a3d40 = sqr(self.engagementdistance);
  self.var_6e5b38d9 = gettime() + 6000;
  self.var_95bfdd95 = self.var_6e5b38d9 + randomint(10000);
  self.var_60188515 = self.var_6e5b38d9 + randomint(10000);
  self.var_249206b6 = self.var_6e5b38d9 + randomint(10000);
  self.zombie_move_speed = "walk";
  self.var_f00db61 = 1;
  self.var_490042cd = gettime();
  self attach("zombietron_skeleton_sword_giant", "tag_weapon_right");
  self enableaimassist();
  self attach("zombietron_giant_skeleton_heart", "j_spinelower");
  self namespace_83eb6304::function_3ecfde67("giantSkelHeartGlow");
  self.var_5ab15c1a = getweapon("zombietron_giant_skeleton_blaster");
  self.var_33dcf942 = doa_enemy::function_d7c5adee("skeleton");
  self thread function_e7667c0d();
  aiutility::addaioverridedamagecallback(self, &function_33864934);
  namespace_81245006::initweakpoints(self);
}

function private function_33864934(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  var_799e18e5 = modelindex;
  var_5f32808d = 1;

  if(boneindex >= 1000) {
    var_5f32808d = 2;
  }

  self namespace_ec06fe4a::function_2f4b0f9(self.health - boneindex, offsettime, var_799e18e5, boneindex, var_5f32808d);
  return boneindex;
}

function function_2ee0142d() {
  self namespace_250e9486::function_25b2c8a9();
  self.var_418bd7f0 = 0;
  self.doa.var_74e4ded8 = 1;
  self.should_zigzag = 0;
  self.var_dafc95a5 = 3000;
  self setavoidancemask("avoid ai");
  self.var_63d2fce2 = &function_979c19d0;
  self.is_zombie = 1;
  self.no_gib = 1;
  run = randomint(100) > 20;

  if(run) {
    self.zombie_move_speed = "run";
  }

  self.health = 1700 + getplayers().size * 350;
  self.maxhealth = self.health;
  self.var_490042cd = gettime();
  self callback::function_d8abfc3d(#"on_ai_killed", &function_4ac532fd);
  self namespace_83eb6304::function_3ecfde67("ai_zombie_riser");
  namespace_81245006::initweakpoints(self);
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_skeleton_spawn");
  self thread namespace_9fc66ac::function_ba33d23d(#"hash_2c08738c0df69ea0", #"hash_3ad61af02a6bb837", #"hash_18df36d19c573215");
}

function function_a54cde8b() {
  self namespace_ec06fe4a::function_8c808737();
  self thread function_2ee0142d();
  self.team = "allies";
  self.guardian = 1;
  self.zombie_move_speed = "run";
  self.showdelay = 0.5;
  self.var_76cb41b3 = 1;
  self.meleedistsq = sqr(90);
  self.maxhealth = 20000;
  self.health = self.maxhealth;
  self setplayercollision(0);
  self clientfield::increment("skel_spawn_fx", 1);
  self thread function_6e5de5bd(50);
  aiutility::addaioverridedamagecallback(self, &function_abab78a7);
}

function private function_abab78a7(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(boneindex) && is_true(boneindex.boss)) {
    modelindex *= 8;
  }

  return modelindex;
}

function function_6e5de5bd(time = 45) {
  self endon(#"death");
  wait time;
  self thread namespace_ec06fe4a::function_570729f0(0.25);
}

function private function_4ac532fd(s_params) {
  if(is_true(self.is_charging)) {
    level.doa.var_33daab96--;
  }

  if(!is_true(self.fake_death)) {
    destructserverutils::togglespawngibs(self, 1);
    destructserverutils::function_629a8d54(self, "tag_weapon_right");
    destructserverutils::function_629a8d54(self, "tag_weapon_left");
    destructserverutils::function_629a8d54(self, "j_helmet");
  }
}

function private function_979c19d0() {
  self setavoidancemask("avoid ai");
}

function private function_af85a094(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isDefined(attacker) && attacker.team === self.team) {
    return 0;
  }

  if(meansofdeath === # "mod_unknown") {
    return damage;
  }

  if(isDefined(boneindex)) {
    bonename = getpartname(self, boneindex);

    if(isDefined(self.var_dafc95a5) && self.var_dafc95a5 > 0 && bonename === "j_skeleton_shield" || bonename === "tag_weapon_left") {
      self.var_dafc95a5 -= damage;

      if(self.var_490042cd <= gettime()) {
        self.var_490042cd = gettime() + 300;
        self clientfield::increment("" + # "hash_3a6a3e4ef0a1a999", 1);

        if(self.var_dafc95a5 <= 0) {
          destructserverutils::togglespawngibs(self, 1);
          destructserverutils::function_629a8d54(self, "tag_weapon_left");
          self.var_3420e847 = 1;
        }
      }

      return 0;
    }
  }

  var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);

  if(!isDefined(var_84ed9a13)) {
    var_84ed9a13 = namespace_81245006::function_37e3f011(self, boneindex);
  }

  if(!isDefined(var_84ed9a13)) {
    var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
  }

  registerzombie_bgb_used_reinforce = isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
  var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== # "armor";

  if(registerzombie_bgb_used_reinforce && var_84ed9a13.type === # "armor") {
    namespace_81245006::damageweakpoint(var_84ed9a13, damage);

    if(namespace_81245006::function_f29756fe(var_84ed9a13) === 3) {
      if(is_true(var_84ed9a13.var_641ce20e)) {
        namespace_81245006::function_6742b846(self, var_84ed9a13);
        self.var_992c3917 = 1;

        if(namespace_ec06fe4a::function_a8975c67()) {
          self playsoundontag(#"hash_7241c61ae34b51a1", "j_head");
        }
      }

      if(boneindex == 0 && isDefined(var_84ed9a13.hittags) && var_84ed9a13.hittags.size > 0) {
        boneindex = var_84ed9a13.hittags[0];
      }

      var_dc905145 = namespace_81245006::function_37e3f011(self, boneindex, 2);

      if(isDefined(var_dc905145)) {
        namespace_81245006::function_6c64ebd3(var_dc905145, 1);
      }

      destructserverutils::handledamage(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
  }

  if(!isDefined(self.var_418bd7f0)) {
    self.var_418bd7f0 = 0;
  }

  if(!is_true(self.marked_for_death) && self.var_418bd7f0 > 0 && self.health <= damage && !registerzombie_bgb_used_reinforce && hitloc !== "head" && hitloc !== "helmet" && isDefined(meansofdeath) && meansofdeath != "MOD_UNKNOWN") {
    self thread function_c9f197d2();
    damage = 0;
    self.var_418bd7f0--;
    attacker util::show_hit_marker(!isalive(self));
  }

  if(self.health <= damage) {
    org = namespace_ec06fe4a::spawnmodel(self.origin, "tag_origin", self.angles, "skeleton_org");

    if(isDefined(org)) {
      org thread namespace_ec06fe4a::function_52afe5df(1);

      if(is_true(self.boss)) {
        org namespace_83eb6304::function_3ecfde67("skeleton_giant_death");
      } else {
        org namespace_83eb6304::function_3ecfde67("skeleton_death");
      }
    }
  }

  return damage;
}

function private function_6318bedf(entity) {
  entity.knockdown = 0;
  self thread function_c9f197d2();
}

function function_c9f197d2() {
  self endon(#"death");
  self.fake_death = 1;
  self.var_7b0667d9 = 1;
  self.var_b4bc9e1f = 1;
  self val::set(#"hash_65edbe063d05f17b", "takedamage", 0);
  self val::set(#"hash_65edbe063d05f17b", "ignoreall", 1);
  self.canbetargetedbyturnedzombies = 0;
  self.b_ignore_cleanup = 1;
  self.ignore_nuke = 1;
  self.var_2f68be48 = undefined;
  self.var_28aab32a = undefined;

  if(hasasm(self)) {
    self asmsetanimationrate(1);
  }

  if(!is_true(self.isdying)) {
    self thread function_42a1dabd();
    waitresult = self waittilltimeout(60, #"hash_782dbc5eec90f62f");

    if(waitresult._notify == # "timeout") {
      self val::reset(#"hash_65edbe063d05f17b", "takedamage");
      self kill();
    }

    self solid();
    self namespace_ec06fe4a::function_4f72130c();
  }

  if(isDefined(self)) {
    self.health = int(self.maxhealth);
    weakpoints = namespace_81245006::function_fab3ee3e(self);

    if(isDefined(weakpoints)) {
      foreach(weakpoint in weakpoints) {
        if(weakpoint.type === # "weakpoint") {
          weakpoint_state = namespace_81245006::function_f29756fe(weakpoint);
          namespace_81245006::function_26901d33(weakpoint);
          namespace_81245006::function_6c64ebd3(weakpoint, weakpoint_state);
        }
      }
    }

    self.fake_death = 0;
    self.var_7b0667d9 = undefined;
    self.var_b4bc9e1f = undefined;
    self val::reset(#"hash_65edbe063d05f17b", "takedamage");
    self val::reset(#"hash_65edbe063d05f17b", "ignoreall");
    self.canbetargetedbyturnedzombies = 1;
    self.var_6d23c054 = 1;
    self.b_ignore_cleanup = undefined;
    self.ignore_nuke = undefined;
    self.var_2f68be48 = 1;
    self.var_28aab32a = self ai::function_9139c839().var_10460f1e;
  }
}

function private function_42a1dabd() {
  if(!isalive(self)) {
    return;
  }

  self endon(#"death");
  var_67f0b3a6 = # "aib_vign_cust_zm_red_spart_swrd_dth_f_00";
  self namespace_ec06fe4a::function_8c808737();
  self notsolid();
  var_ee3cfcfe = {
    #origin: self.origin, #angles: self.angles
  };
  var_ee3cfcfe thread scene::play(var_67f0b3a6, array(self));
  self.var_e0c4c154 = 0;
  wait 3 + randomfloatrange(1, 6);
  [[level.var_3291f056]] - > waitinqueue(self);
  var_708e5e40 = var_ee3cfcfe;
  self solid();

  if(isDefined(self)) {
    var_ee3cfcfe scene::stop(var_67f0b3a6);
    var_cee6fc30 = # "ai_t8_zm_red_spar_swrd_rebuild_01";

    if(self.subarchetype == # "skeleton_spear" || self.subarchetype == # "hash_1520c8987a671df0") {
      var_cee6fc30 = # "ai_t8_zm_red_spar_spear_rebuild_01";
    }

    var_93a62fe = namespace_7f5aeb59::function_7781556b(self.origin);

    if(isDefined(var_93a62fe)) {
      angles = vectortoangles(vectornormalize(var_93a62fe.origin - self.origin));
      self forceteleport(self.origin, angles);
      var_ee3cfcfe.angles = angles;
    }

    self thread animation::play(var_cee6fc30, undefined, undefined, 1, 0, 0);
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_skeleton_spawn");
    var_708e5e40.angles = (var_ee3cfcfe.angles[0], var_ee3cfcfe.angles[1] + 90, var_ee3cfcfe.angles[2]);
    var_704f0f40 = # "p8_fxanim_zm_red_spartoi_rise_no_helm_bundle";

    if(is_true(self.var_3420e847)) {
      var_704f0f40 = # "hash_27a8f88c6e23290e";
    }

    if(self.subarchetype == # "hash_fd7b9665529dd42" && !is_true(self.var_992c3917)) {
      var_704f0f40 = # "p8_fxanim_zm_red_spartoi_rise_bundle";
    } else if(self.subarchetype == # "hash_1520c8987a671df0" && !is_true(self.var_992c3917)) {
      var_704f0f40 = # "p8_fxanim_zm_red_spartoi_rise_spear_bundle";
    } else if(self.subarchetype == # "hash_1520c8987a671df0" || self.subarchetype == # "skeleton_spear") {
      var_704f0f40 = # "p8_fxanim_zm_red_spartoi_rise_spear_no_helm_bundle";
    }

    var_708e5e40 scene::play(var_704f0f40);
    self namespace_ec06fe4a::function_4f72130c();
    self.var_534a42ac = undefined;
    self.var_45bfef99 = undefined;
    archetype_skeleton::function_9f7eb359(self);
    self.var_e0c4c154 = 1;
    self.marked_for_death = undefined;

    if(isDefined(var_708e5e40) && isDefined(var_708e5e40.tacpoint)) {
      var_708e5e40.tacpoint.var_94bf7609 = undefined;
    }
  }

  if(isDefined(self)) {
    self notify(#"hash_782dbc5eec90f62f");
  }
}

function private function_be0c9c8b(entity) {
  var_1423159a = 0;

  foreach(var_d2287bdc in level.var_8eaf991c) {
    if(level.doa.roundnumber < var_d2287bdc.round) {
      break;
    }

    var_1423159a = var_d2287bdc.limit;
  }

  if(level.doa.var_33daab96 >= var_1423159a) {
    return false;
  }

  return true;
}

function private function_137603f() {
  level.doa.var_33daab96++;
}

function private function_e4ead132() {
  level.doa.var_33daab96--;
}