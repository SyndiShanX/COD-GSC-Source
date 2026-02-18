/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_761ab8de8f97d130.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_2c5daa95f8fec03c;
#using script_3faf478d5b0850fe;
#using script_47851dbeea22fe66;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_60c9f7551ce6c823;
#using script_774302f762d76254;
#using script_79315a6ccf4fce3d;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_eye_glow;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b5ca279a;

function init() {
  namespace_250e9486::function_252dff4d("basic_zombie", 21, &function_7f78da, undefined, 0);
  namespace_250e9486::function_252dff4d("barreler_zombie", 22, &function_ef2758f9, undefined, 9);
  namespace_250e9486::function_252dff4d("riser_zombie", 23, &function_a4b27d0e, undefined, 17);
  namespace_250e9486::function_252dff4d("smoke_zombie", 25, &function_83a2d68c, undefined, 21);
  namespace_250e9486::function_252dff4d("pole_zombie", 28, &function_38f9cf8c, undefined, 33, &function_56304f4a);
  namespace_250e9486::function_252dff4d("blood_riser", 24, &function_1eb8e7ef, undefined, 41, &function_c291edbd);
  registration = namespace_250e9486::function_3dd94c25("barreler_zombie");

  if(!isDefined(registration.var_71e54e3a)) {
    registration.var_71e54e3a = [];
  } else if(!isarray(registration.var_71e54e3a)) {
    registration.var_71e54e3a = array(registration.var_71e54e3a);
  }

  registration.var_71e54e3a[registration.var_71e54e3a.size] = "kgb";
  registerbehaviorscriptfunctions();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_63e044e7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_11f0b891a9d2e6c7", &function_63e044e7);
  assert(isscriptfunctionptr(&function_9e433573));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b2a4705912ffb22", &function_9e433573);
  assert(isscriptfunctionptr(&function_55b7ea22));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7561185fb9f89048", &function_55b7ea22);
  assert(isscriptfunctionptr(&function_98b102d8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_66d076094cefbdbb", &function_98b102d8);
  assert(isscriptfunctionptr(&function_4402c40a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_530185ba74913077", &function_4402c40a);
  assert(isscriptfunctionptr(&function_6a3bcddc));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_545373e09d03a06c", &function_6a3bcddc);
  assert(isscriptfunctionptr(&function_b9b03294));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1f70e1d883cae162", &function_b9b03294);
  assert(isscriptfunctionptr(&zombietraversalservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"doazombietraversalservice", &zombietraversalservice);
  assert(isscriptfunctionptr(&function_f637b05d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52efb6ed5d3a4220", &function_f637b05d, 1);
}

function function_7f78da() {
  self namespace_250e9486::function_25b2c8a9();
  self.var_1038c5e0 = "ai_zombie_riser";
  self.var_596fb6ed = "ai_zombie_riser";
  animrate = 1 + level.doa.var_6c58d51 * 0.025;
  self asmsetanimationrate(animrate);
  self.ignorevortices = 0;
  self.basic = 1;
  self.var_c3ce559a = 0;
  self.var_bb68380c = namespace_4dae815d::function_59a9cf1d() == 0 && !isDefined(level.doa.var_6f3d327);
  self.shouldspawn = !self.var_bb68380c;
  self thread zombie_eye_glow::function_b43f92cd();

  if(self.var_bb68380c) {
    self thread function_e6634b0c();
    self thread function_a00c9d13();
  } else if(self.zombie_move_speed == "walk") {
    self.zombie_move_speed = math::cointoss() ? "sprint" : "run";
  }

  self thread namespace_9fc66ac::function_ba33d23d(#"hash_6298fe3f8c45ac9f", #"hash_8c6429df541c34c", #"hash_774f44ae3771ad84");
}

function function_c291edbd() {
  if(!isDefined(level.doa.var_39e3fa99)) {
    return false;
  }

  return [[level.doa.var_39e3fa99]] - > function_7856fdb6() == # "bloodlake";
}

function function_1eb8e7ef() {
  function_a4b27d0e();
  self.var_1038c5e0 = "ai_blood_riser";
  self.var_596fb6ed = "ai_blood_riser";
}

function function_a4b27d0e() {
  self function_7f78da();
  self.ignorevortices = 0;
  self.basic = undefined;
  self.shouldspawn = 1;
  self.ignorevortices = 0;
  self asmsetanimationrate(1.1);
  self.zombie_arms_position = randomint(100) < 50 ? "down" : "up";
  self.zombie_move_speed = isDefined(level.doa.var_13e8f9c9) ? level.doa.var_13e8f9c9 : "run";

  if(isDefined(level.doa.var_a598a835)) {
    self.spawnloc = [[level.doa.var_a598a835]]();
    return;
  }

  assert(isDefined(level.doa.var_39e3fa99));
  self.spawnloc = [[level.doa.var_39e3fa99]] - > function_59fc184c();
}

function function_ef2758f9() {
  self function_7f78da();
  self.ignorevortices = 0;
  self.basic = undefined;
  self.zombie_arms_position = "up";
  self setavoidancemask("avoid none");
  self.zombie_move_speed = isDefined(level.doa.var_13e8f9c9) ? level.doa.var_13e8f9c9 : "run";
  barrel = namespace_fb2125f::function_f1ca69a7("zombietron_explosive_barrel", undefined, self.origin, self.angles, 0);

  if(isDefined(barrel)) {
    barrel notsolid();
    barrel enablelinkto();
    self enablelinkto();
    barrel disableaimassist();
    barrel.carried = 1;
    barrel.takedamage = 1;
    barrel.health = 99999;
    barrel linkto(self, "j_head", (0, 0, 15), (90, 0, 0));
    barrel thread function_bd3de922(self);
    barrel thread namespace_ec06fe4a::function_52afe5df(120);
  }
}

function function_56304f4a() {
  return level.doa.var_8d14dcbf.size < 75;
}

function function_38f9cf8c() {
  self function_7f78da();
  self.ignorevortices = 0;
  self.basic = undefined;
  self.var_2b989b2e = 1;
  self.var_4dcf6637 = 1;
  self.zombie_arms_position = "up";
  self setavoidancemask("avoid none");
  self.zombie_move_speed = "sprint";
  self.maxhealth = int(5000 + 2500 * level.doa.var_6c58d51);
  self.health = self.maxhealth;
  self thread function_9bca3cb6();
  self.var_d415ee14 = 1;

  if(namespace_4dae815d::function_59a9cf1d() == 0 && level.doa.var_8d14dcbf.size > 38) {
    return;
  }

  if(randomint(100) > 45) {
    self thread function_7b1377e8();
  }
}

function function_9bca3cb6() {
  self endon(#"death");

  while(true) {
    wait randomfloatrange(0.3, 0.6);
    self namespace_83eb6304::function_3ecfde67("pole_zombie_elecBurst");
  }
}

function function_711927a1(origin) {
  org = namespace_ec06fe4a::spawnmodel(origin);

  if(!isDefined(org)) {
    return;
  }

  org thread namespace_ec06fe4a::function_52afe5df(3.4);
  trap = {};
  trap.origin = origin + (0, 0, -100);
  trap.angles = (0, 0, 0);
  pole = namespace_53f73cda::function_28826539(trap, 0);

  if(!isDefined(pole)) {
    return;
  }

  level.doa.var_8d14dcbf[level.doa.var_8d14dcbf.size] = pole;
  pole moveto(origin, 2);

  while(isDefined(org)) {
    org namespace_83eb6304::function_3ecfde67("pole_blast");
    wait randomfloatrange(0.5, 1.2);
  }
}

function function_7b1377e8() {
  self endon(#"death");
  wait 5;

  while(true) {
    wait 0.2;

    if(randomint(100) < 4) {
      break;
    }
  }

  self.ignoreall = 1;
  self.var_c0bd8c06 = 1;
  self thread namespace_ec06fe4a::function_570729f0(10);
  self waittilltimeout(4, #"hash_12b1eb419a23e3bd");
  level thread function_711927a1(self.origin);
}

function function_bd3de922(carrier) {
  self endon(#"death");
  carrier waittill(#"death");
  self unlink();
  self solid();
  impulse = anglesToForward(self.angles) + (0, 0, 5);
  impulse = vectorscale(impulse, 3);
  self physicslaunch(self.origin, impulse);
  self enableaimassist();
  self thread namespace_fb2125f::function_db4a8bad(1, self);
}

function function_83a2d68c() {
  self namespace_250e9486::function_25b2c8a9();
  self.var_1038c5e0 = "shadow_rez_in";
  self.var_596fb6ed = "shadow_appear";
  self.var_bb68380c = namespace_4dae815d::function_59a9cf1d() == 0;
  self.shouldspawn = 1;
  self.var_c5348ec8 = randomint(2) + 1;
  self.zombie_move_speed = isDefined(level.doa.var_13e8f9c9) ? level.doa.var_13e8f9c9 : "sprint";

  if(isDefined(level.doa.var_a598a835)) {
    self.spawnloc = [[level.doa.var_a598a835]]();
  } else {
    assert(isDefined(level.doa.var_39e3fa99));
    self.spawnloc = [[level.doa.var_39e3fa99]] - > function_70fb5745();
  }

  self.org = namespace_ec06fe4a::spawnmodel(self.spawnloc.origin + (0, 0, 40), "tag_origin");

  if(isDefined(self.org)) {
    self.org.takedamage = 0;
    self.org.targetname = "shadowTeleportMeNow";
    self.org thread namespace_ec06fe4a::function_d55f042c(self, "death");
  }

  self.var_e66cd6fb = 1;
  self.no_armor = 1;
  self.var_4dcf6637 = 1;
  aiutility::addaioverridedamagecallback(self, &function_a86c6bf8);
  self thread shadowteleportmenow(1, self.spawnloc.origin);
}

function shadowteleportmenow(initial = 0, origin = self.origin) {
  if(!isDefined(level.doa.var_39e3fa99)) {
    self thread namespace_ec06fe4a::function_570729f0();
    return;
  }

  self endon(#"death");

  if(is_true(self.intransition)) {
    return;
  }

  assert(self.var_c5348ec8 > 0);
  self.intransition = 1;

  if(!initial) {
    self.var_c5348ec8--;
  }

  spot = [[level.doa.var_39e3fa99]] - > function_70fb5745(origin, 256, 1400).origin;
  self.ignoreall = 1;
  self.takedamage = 0;
  self namespace_83eb6304::function_3ecfde67("shadow_fade");
  self namespace_83eb6304::function_3ecfde67("spawnZombie");
  wait 0.1;

  if(isDefined(self.org)) {
    self.org.origin = self.origin + (0, 0, 40);
    util::wait_network_frame();
    self.org namespace_83eb6304::function_3ecfde67("shadow_move");
    self.org namespace_83eb6304::function_3ecfde67("shadow_glow");
    self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_smokeman_lp");
    self.org namespace_e32bb68::function_3a59ec34("zmb_doa_ai_smokeman_teleport_out");
    wait 0.3;
    self namespace_ec06fe4a::function_8c808737();
    self notsolid();
    self setplayercollision(0);
    self linkto(self.org);
    self.org moveto(spot + (0, 0, 40), 2);
    self.org waittilltimeout(2.1, #"movedone");
    self.org namespace_83eb6304::function_3ecfde67("shadow_appear");
    self.org namespace_e32bb68::function_3a59ec34("zmb_doa_ai_smokeman_teleport_in_pre");
    wait 1.9;
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_smokeman_teleport_in");
    self unlink();
    self forceteleport(spot);
    self namespace_ec06fe4a::function_4f72130c();
    self solid();
    self setplayercollision(1);
    self.org namespace_83eb6304::turnofffx("shadow_move");
    self.org namespace_83eb6304::turnofffx("shadow_glow");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_smokeman_lp");
  }

  self namespace_83eb6304::function_3ecfde67("spawnZombie");
  wait 1;
  self.ignoreall = 0;
  self.takedamage = 1;
  self.intransition = undefined;
  self.var_72283e28 = 0;
}

function function_a86c6bf8(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
  if(self.var_c5348ec8 > 0) {
    if(surfacenormal >= self.health) {
      surfacenormal = self.health - 1;
    }

    self thread shadowteleportmenow();
  } else if(surfacenormal >= self.health) {
    self namespace_e32bb68::function_ae271c0b("zmb_doa_ai_smokeman_lp");
    self namespace_ec06fe4a::function_4f72130c();
    self.takedamage = 0;
    self.aioverridedamage = undefined;
    orb = namespace_ec06fe4a::spawnmodel(self.origin);

    if(isDefined(orb)) {
      orb thread namespace_ec06fe4a::function_52afe5df(0.4);
      orb namespace_83eb6304::function_3ecfde67("shadow_die");
      orb namespace_e32bb68::function_3a59ec34("zmb_doa_ai_smokeman_death");
    }
  }

  return surfacenormal;
}

function function_a00c9d13() {
  self endon(#"death");
  self waittill(#"speed_change");
  self.var_860a34b9 = undefined;
  self.var_72283e28 = 0;
  self thread function_e6634b0c(self.var_fe2082cc);
}

function function_e6634b0c(var_11b86a4c = 45) {
  if(!isDefined(level.doa.var_39e3fa99)) {
    return;
  }

  self notify("760fbd4bb35afa69");
  self endon("760fbd4bb35afa69");
  self endon(#"death");

  if(self.zombie_move_speed != "walk") {
    self waittilltimeout(var_11b86a4c, #"wander");

    if(isDefined(self.var_ce1aa55f) && gettime() - self.var_ce1aa55f <= 10000) {
      self thread function_e6634b0c();
    }

    self.zombie_move_speed = namespace_250e9486::function_bb0817aa(self.zombie_move_speed);
  } else {
    self waittill(#"wander", #"speed_change");
  }

  spot = [[level.doa.var_39e3fa99]] - > function_70fb5745(self.origin, 300, 2048);

  if(isDefined(spot)) {
    self.var_860a34b9 = spot.origin;
  } else {
    self.var_860a34b9 = self.startposition;
  }

  self.oldradius = self.goalradius;
  self.goalradius = 256;
  self.var_72283e28 = 0;
  self namespace_250e9486::function_41354e51(self.var_860a34b9, 1, 1);
  self waittilltimeout(10, #"goal");
  self.var_860a34b9 = undefined;
  self.goalradius = self.oldradius;
  self thread function_e6634b0c(var_11b86a4c);
}

function function_f637b05d(behaviortreeentity) {
  behaviortreeentity.var_93a62fe = namespace_7f5aeb59::function_7781556b(behaviortreeentity.origin, 1);
}

function zombietraversalservice(entity) {
  if(isDefined(entity.traversestartnode)) {
    entity collidewithactors(0);
    return true;
  }

  return false;
}

function private function_b9b03294(entity) {
  if(self function_3c566724()) {
    return true;
  }

  startnode = entity.traversestartnode;

  if(!isDefined(startnode) || !isnodeenabled(startnode)) {
    return false;
  }

  return true;
}

function private function_4402c40a(entity) {
  if(!is_true(entity.var_e5ad72a0)) {
    if(isDefined(entity.var_1038c5e0)) {
      entity namespace_83eb6304::function_3ecfde67(entity.var_1038c5e0);
    }

    entity.var_c0bd8c06 = undefined;
    entity.var_e5ad72a0 = 1;
    entity disableaimassist();
    entity pathmode("dont move", 1);
  }

  return true;
}

function private function_6a3bcddc(entity) {
  entity namespace_ec06fe4a::function_8c808737();
  entity notsolid();
  entity notify(#"hash_12b1eb419a23e3bd");
  entity.var_e5ad72a0 = undefined;
  return true;
}

function private function_55b7ea22(entity) {
  if(!is_true(entity.var_1f2d0447)) {
    entity solid();

    if(isDefined(entity.var_596fb6ed)) {
      entity namespace_83eb6304::function_3ecfde67(entity.var_596fb6ed);
    }

    entity pathmode("dont move");
    entity.var_1f2d0447 = 1;
    entity.shouldspawn = undefined;
    entity disableaimassist();
  }
}

function private function_98b102d8(entity) {
  entity.var_1f2d0447 = undefined;
  entity pathmode("move allowed");
  entity enableaimassist();
  entity notify(#"not_underground");
  entity.doa.original_origin = self.origin;
}

function private function_63e044e7(entity) {
  return is_true(entity.shouldspawn);
}

function private function_9e433573(entity) {
  return is_true(entity.var_c0bd8c06);
}

function function_d2fee26e(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
  if(isDefined(shitloc) && shitloc.team === self.team) {
    return 0;
  }

  if(boneindex === # "mod_unknown") {
    return psoffsettime;
  }

  self.var_426947c4 = undefined;
  weakpoint = namespace_81245006::function_3131f5dd(self, modelindex, 1);

  if(isDefined(weakpoint) && weakpoint.type === # "armor") {
    namespace_81245006::damageweakpoint(weakpoint, psoffsettime);

    if(namespace_81245006::function_f29756fe(weakpoint) === 3 && isDefined(weakpoint.var_f371ebb0)) {
      destructserverutils::function_8475c53a(self, weakpoint.var_f371ebb0);
      self.var_426947c4 = 1;

      if(weakpoint.var_f371ebb0 === "body_armor") {
        callback::callback(#"hash_7d67d0e9046494fb");
      }
    }

    if(self.subarchetype === # "hash_7a778318514578f7") {
      psoffsettime = int(psoffsettime * 0.25);
    } else if(self.subarchetype === # "zombie_medium_armor") {
      psoffsettime = int(psoffsettime * 0.5);
    }

    self.var_67f98db0 = 1;
    var_43f0e034 = function_f4e9bba4(self);
    self function_2d4173a8(var_43f0e034);
  }

  return psoffsettime;
}

function function_f4e9bba4(entity) {
  max_health = 0;
  curr_health = 0;
  weakpoints = namespace_81245006::function_fab3ee3e(entity);

  if(!isDefined(weakpoints)) {
    return 0;
  }

  foreach(weakpoint in weakpoints) {
    if(weakpoint.type === # "armor") {
      max_health += weakpoint.maxhealth;
      curr_health += max(weakpoint.health, 0);
    }
  }

  if(max_health == 0) {
    return 0;
  }

  return curr_health / max_health;
}