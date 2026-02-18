/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_15ddefec0f2c1a92.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_455b9cb22d561924;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_774302f762d76254;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
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
#using scripts\core_common\oob;
#using scripts\core_common\util_shared;
#namespace namespace_53a8fe5e;

function init() {
  clientfield::register("actor", "hellhound_fx", 1, 1, "int");
  namespace_250e9486::function_252dff4d("wolf_ghosthound", 19, &function_3ba58018, &function_df18852, 45);
  namespace_250e9486::function_252dff4d("wolf_hellhound", 20, &function_ebb53c52, &function_df18852, 65);
  registerbehaviorscriptfunctions();
  function_8c1ad7f9();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_52fd1aa8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_347361909496bb67", &function_52fd1aa8);
  assert(isscriptfunctionptr(&function_ee68dfca));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_589814e7ae852fb7", &function_ee68dfca);
  assert(isscriptfunctionptr(&function_86104a92));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2c51dac6b31ae16e", &function_86104a92);
  assert(isscriptfunctionptr(&function_cf98d4f7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d690a74a315c5c3", &function_cf98d4f7);
  assert(isscriptfunctionptr(&function_ad163d5a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c13ee431006ea01", &function_ad163d5a);
  assert(!isDefined(&wolfmeleeaction) || isscriptfunctionptr(&wolfmeleeaction));
  assert(!isDefined(undefined) || isscriptfunctionptr(undefined));
  assert(!isDefined(&function_8d42c979) || isscriptfunctionptr(&function_8d42c979));
  behaviortreenetworkutility::registerbehaviortreeaction("wolfMeleeAction", &wolfmeleeaction, undefined, &function_8d42c979);
}

function function_8c1ad7f9() {
  ai::registermatchedinterface(#"zombie_dog", #"min_run_dist", 500);
  ai::registermatchedinterface(#"zombie_dog", #"sprint", 0, array(1, 0));
  ai::registermatchedinterface(#"zombie_dog", #"patrol", 0, array(1, 0));
}

function function_3ba58018() {
  function_ebb53c52();
  self.doa.var_74e4ded8 = 1;
  self setavoidancemask("avoid none");
  self collidewithactors(0);
  self setplayercollision(0);
  self.health = 1500;
  self.var_af545843 = 1;
  self.var_abe67a20 = 1;
  self.var_bbdaef90 = 1;
}

function function_ebb53c52() {
  self namespace_250e9486::function_25b2c8a9();
  self namespace_ec06fe4a::function_8c808737();
  self.shouldrun = 0;
  self.var_3b227abd = randomintrange(10, 30) * 1000;

  if(namespace_4dae815d::function_59a9cf1d() != 0) {
    self.var_717a48cb = 0;
    self.var_f506c5cd = 1200;
    self.var_32d07c96 = sqr(self.var_f506c5cd);
    self.var_c8b974fe = self.origin;
  }

  self.var_cc28f8dc = 80;
  self.showdelay = 2;
  self.health = 4000;
  self.var_1c8b76d3 = 1;
  self.no_gib = 1;
  self.var_27860c49 = 1;
  self.var_96cd28f6 = 0;
  self thread function_92312127();
  self thread function_47c86b9e(self);
  self thread function_b8558f62();
  self enableaimassist();
  aiutility::addaioverridedamagecallback(self, &function_da4ec7ea);
}

function private function_da4ec7ea(inflictor, attacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(modelindex >= self.health) {
    self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_ghosthound_vocal_sprint");
    self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_hellhound_vocal_sprint");
    self namespace_ec06fe4a::function_8c808737();
    self notsolid();
    orb = namespace_ec06fe4a::spawnmodel(self.origin);

    if(!isDefined(orb)) {
      return modelindex;
    }

    orb thread namespace_ec06fe4a::function_52afe5df(0.4);
    profilestart();

    if(self.script_noteworthy === "wolf_ghosthound") {
      orb namespace_83eb6304::function_3ecfde67("ghosthound_death");
      orb namespace_83eb6304::function_3ecfde67("electrical_explo");
      orb namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghosthound_explode");
    } else if(self.script_noteworthy === "wolf_hellhound") {
      orb namespace_e32bb68::function_3a59ec34("zmb_doa_ai_hellhound_explode");
      orb namespace_83eb6304::function_3ecfde67("hellhound_death");
    }

    profilestop();
  }

  return modelindex;
}

function function_b4b1df9c(params) {
  self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_plaguehound_vocal_sprint");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_plaguehound_explode");
  self namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
  trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", self.origin, 2 | 1 | 512, 40, 50);

  if(isDefined(trigger)) {
    trigger thread namespace_ec06fe4a::function_52afe5df(3);
    trigger thread function_86555fba();
  }
}

function function_1c24aba3() {
  self endon(#"death");

  while(true) {
    self namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
    wait 0.25;
  }
}

function function_86555fba() {
  self endon(#"death");
  org = namespace_ec06fe4a::spawnmodel(self.origin);

  if(isDefined(org)) {
    org thread namespace_ec06fe4a::function_d55f042c(self, "death");
    org thread function_1c24aba3();
  }

  while(true) {
    result = self waittill(#"trigger");

    if(isDefined(org)) {
      org namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
    }

    if(isDefined(result.activator) && !is_true(result.activator.boss)) {
      result.activator thread namespace_250e9486::function_b5feb0bf();
    }
  }
}

function damagewatch() {
  self notify("54541a049aceddf6");
  self endon("54541a049aceddf6");
  self endon(#"death");
  result = self waittill(#"damage");

  if(isDefined(result.attacker) && issentient(result.attacker)) {
    self.favoriteenemy = result.attacker;
    self.hasseenfavoriteenemy = 1;
    self namespace_250e9486::function_41354e51(get_locomotion_target(self), 1);
    self.var_717a48cb = 0;
  }
}

function function_df18852() {
  self endon(#"death");
  self thread damagewatch();
  self thread function_a47b7e79(1);
  self function_56bb65ac("WALK");
  self.var_84f9cc2e = gettime() + 1000;
  var_30d02a4c = 0;

  while(true) {
    self namespace_250e9486::function_89c95270();

    while(self function_ad163d5a()) {
      wait 0.5;
    }

    self.shouldrun = need_to_run();
    self function_56bb65ac(self.shouldrun ? "RUN" : "WALK");
    wait self.doa.thinkrate;
  }
}

function function_47c86b9e(ai) {
  ai endon(#"death");
  ai namespace_ec06fe4a::function_8c808737();
  ai.takedamage = 0;
  ai setfreecameralockonallowed(0);

  if(isDefined(ai.favoriteenemy)) {
    angle = vectortoangles(ai.favoriteenemy.origin - ai.origin);
    angles = (ai.angles[0], angle[1], ai.angles[2]);
  } else {
    angles = ai.angles;
  }

  ai dontinterpolate();
  ai forceteleport(ai.origin, angles);

  if(ai.script_noteworthy === "wolf_plaguehound") {
    ai namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
  } else {
    ai namespace_83eb6304::function_3ecfde67("lightningStrike");
  }

  ai.takedamage = 1;
  wait 0.4;
  ai namespace_ec06fe4a::function_4f72130c();
  ai setfreecameralockonallowed(1);

  if(ai.script_noteworthy === "wolf_hellhound") {
    ai clientfield::set("hellhound_fx", 1);
  }

  ai notify(#"hash_6f1cd023691af538");
}

function function_b8558f62() {
  if(self.script_noteworthy === "wolf_plaguehound") {
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_plaguehound_spawn");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_plaguehound_vocal_sprint");
    return;
  }

  if(self.script_noteworthy === "wolf_hellhound") {
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_hellhound_spawn");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_hellhound_vocal_sprint");
    return;
  }

  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghosthound_spawn");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_ghosthound_vocal_sprint");
}

function function_2e6b2ca9() {
  namespace_250e9486::function_4b49bf0d();
  force = 0;

  if(isDefined(self.favoriteenemy) && level.doa.world_state == 0) {
    force = 1;
    self.hasseenfavoriteenemy = 1;
    self thread function_a47b7e79(1);
  } else if(!is_true(self.hasseenfavoriteenemy) && isDefined(self.favoriteenemy)) {
    infov = self util::point_in_fov(self.favoriteenemy.origin, 0.8, 1);
    cansee = infov && self cansee(self.favoriteenemy);

    if(isDefined(self.favoriteenemy) && isPlayer(self.favoriteenemy) && self.favoriteenemy isinmovemode("<dev string:x38>", "<dev string:x3f>")) {
      cansee = 0;
    }

    if(cansee) {
      force = 1;
      self.hasseenfavoriteenemy = 1;
      self thread function_a47b7e79(1);
    }
  }

  if(isDefined(self.favoriteenemy) && is_true(self.hasseenfavoriteenemy)) {
    self namespace_250e9486::function_8f172270(get_locomotion_target(self));
    self.var_717a48cb = 0;
    return;
  }

  if(!is_true(self.hasseenfavoriteenemy)) {
    time = gettime();

    if(self.var_717a48cb < time) {
      var_86faa86d = doa_enemy::function_4b2f19cb();
      self.var_717a48cb = time + randomintrange(12000, 24000);

      if(isDefined(var_86faa86d)) {
        self namespace_250e9486::function_41354e51(var_86faa86d);
        self.lasttargetposition = var_86faa86d;
      }

      return;
    }

    goalinfo = self function_4794d6a3();

    if(is_true(goalinfo.isatgoal)) {
      function_a47b7e79(randomint(100) > 80);
    }
  }
}

function get_locomotion_target(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.favoriteenemy)) {
    return undefined;
  }

  return behaviortreeentity namespace_250e9486::function_bd5a9fa6();
}

function need_to_run() {
  run_yaw = 35;
  run_pitch = 30;
  run_height = 64;

  if(!isDefined(self.enemy)) {
    return false;
  }

  if(self.health < self.maxhealth) {
    return true;
  }

  if(isDefined(self.favoriteenemy) && !is_true(self.hasseenfavoriteenemy)) {
    return false;
  }

  height = self.origin[2] - self.enemy.origin[2];

  if(abs(height) > run_height) {
    return false;
  }

  yaw = self namespace_ec06fe4a::absyawtoenemy();

  if(yaw > run_yaw) {
    return false;
  }

  pitch = angleclamp180(vectortoangles(self.origin - self.enemy.origin)[0]);

  if(abs(pitch) > run_pitch) {
    return false;
  }

  return true;
}

function function_56bb65ac(speed = "WALK") {
  self setblackboardattribute("_wolf_should_run", speed);
}

function function_ad163d5a(behaviortreeentity) {
  return self getblackboardattribute("_wolf_should_howl") === "HOWL";
}

function function_a47b7e79(howl = 1) {
  self endon(#"death");

  if(howl) {
    self setblackboardattribute("_wolf_should_howl", "HOWL");
    self waittilltimeout(2, #"damage");
  }

  self setblackboardattribute("_wolf_should_howl", "DONT_HOWL");
}

function get_last_valid_position(bimmediate) {}

function is_target_valid(dog, target) {
  if(!isDefined(target)) {
    return false;
  }

  if(!isalive(target)) {
    return false;
  }

  if(dog.team == target.team) {
    return false;
  }

  if(isPlayer(target) && !namespace_7f5aeb59::isplayervalid(target)) {
    return false;
  }

  if(is_true(target.ignoreme)) {
    return false;
  }

  if(target isnotarget()) {
    return false;
  }

  return true;
}

function function_52fd1aa8(behaviortreeentity) {
  return behaviortreeentity getblackboardattribute("_wolf_should_run") === "WALK";
}

function function_ee68dfca(behaviortreeentity) {
  return behaviortreeentity getblackboardattribute("_wolf_should_run") === "RUN";
}

function function_86104a92(behaviortreeentity) {
  return behaviortreeentity getblackboardattribute("_wolf_should_run") === "SPRINT";
}

function function_cf98d4f7(behaviortreeentity) {
  if(behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
    return false;
  }

  time = gettime();

  if(isDefined(self.var_96cd28f6) && time - self.var_96cd28f6 < 1000) {
    return false;
  }

  meleedist = 72;

  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < sqr(meleedist) && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
    return true;
  }

  return false;
}

function function_a19ebce9(target) {
  if(!isDefined(target)) {
    return;
  }

  if(distancesquared(self.origin, target.origin) > sqr(36)) {
    return;
  }

  self.var_96cd28f6 = gettime();
  registernotice_walla = anglesToForward(self.angles);
  var_2f706708 = self gettagorigin("j_neck");
  var_c1324bcf = vectornormalize(target.origin - self.origin);
  var_aa74cdcb = vectordot(var_c1324bcf, registernotice_walla);

  if(var_aa74cdcb > 0.8) {
    in_front = 1;
  }

  if(!is_true(in_front)) {
    return;
  }

  target_origin = (target.origin[0], target.origin[1], target.origin[2] + 32);

  if(bullettracepassed(var_2f706708, target_origin, 0, self)) {
    target dodamage(self.var_cc28f8dc, self.origin, self, self, "none", "MOD_MELEE");

    if(isPlayer(target)) {
      target playrumbleonentity("damage_heavy");
    }
  }
}

function function_92312127() {
  self endon(#"death");

  while(true) {
    result = self waittill(#"dog_melee");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_hound_bite");
    self function_a19ebce9(self.enemy);
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

function wolfmeleeaction(behaviortreeentity, asmstatename) {
  behaviortreeentity clearpath();
  context = "high";

  if(behaviortreeentity use_low_attack()) {
    context = "low";
  }

  behaviortreeentity setblackboardattribute("_context", context);
  animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
  return 5;
}

function function_8d42c979(behaviortreeentity, asmstatename) {
  asmstatename setblackboardattribute("_context", undefined);
  return 4;
}