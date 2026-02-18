/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_736b4607e813f2e5.gsc
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
#using script_79cafc73107dd980;
#using scripts\core_common\ai\blackboard_vehicle;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#namespace namespace_6e561646;

function init() {
  clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int");
  clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int");
  clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter");
  clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter");
  clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int");
  clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int");
  clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter");
  clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int");
  namespace_250e9486::function_252dff4d("blight_father", 1, &function_22de5bc1);
  registerbehaviorscriptfunctions();
  level.var_c2981ce9 = [# "tag_mouth_weakspot": &function_fa7c080, #"tag_elbow_weakspot_le": &function_9bbe631c, #"tag_elbow_weakspot_ri": &function_5a1a4ad, #"tag_eggsack_weakspot_le": &function_40034805, #"tag_eggsack_weakspot_ri": &function_33b2c99e];

  if(true) {
    level.var_445e24c8 = [];

    for(i = 0; i < 6; i++) {
      trigger = spawn("trigger_damage", (0, 0, 0), 0, 40, 40);
      trigger enablelinkto();
      trigger.inuse = 0;
      trigger triggerenable(0);
      trigger.targetname = "blightfather_chaos_missile";

      if(!isDefined(level.var_445e24c8)) {
        level.var_445e24c8 = [];
      } else if(!isarray(level.var_445e24c8)) {
        level.var_445e24c8 = array(level.var_445e24c8);
      }

      level.var_445e24c8[level.var_445e24c8.size] = trigger;
    }
  }

  level.doa.var_da713110 = 0;
}

function function_22de5bc1() {
  if(!isDefined(level.doa.var_6b8705f1)) {
    level.doa.var_6b8705f1 = doa_enemy::function_d7c5adee("crawler_zombie");
  }

  if(!isDefined(level.doa.var_314b1f0)) {
    level.doa.var_314b1f0 = doa_enemy::function_d7c5adee("spider");
  }

  namespace_250e9486::function_25b2c8a9();
  self namespace_250e9486::function_db744d28();
  self.maxhealth += 250000 + int(100000 * namespace_ec06fe4a::function_ef369bae()) + level.doa.var_6c58d51 * 300000;
  self.health = self.maxhealth;
  self.var_1c8b76d3 = 1;
  self.no_gib = 1;
  self.var_3a001247 = 1;
  self.zombie_move_speed = "sprint";
  self.var_c28230ee = gettime() + 5000;
  self attach("c_t8_zmb_blightfather_mouth_noreveal");
  self attach("c_t8_zmb_blightfather_elbow1_le_noreveal");
  self attach("c_t8_zmb_blightfather_elbow1_ri_noreveal");
  self attach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  self.overrideactordamage = &function_afce1cf;
  self.var_c8088bcb = {
    #traces: [], #timestamp: gettime()
  };
  self.var_b2a80abc = gettime() + 3000;
  self allowpitchangle(1);
  self setpitchorient();
  self collidewithactors(1);
  self clientfield::set("blight_father_weakpoint_l_elbow_fx", 1);
  self clientfield::set("blight_father_weakpoint_r_elbow_fx", 1);
  self clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 1);
  self clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 1);
  self clientfield::set("blight_father_weakpoint_jaw_fx", 1);
  self clientfield::set("blight_father_amb_sac_clientfield", 1);
  target_set(self);
  namespace_81245006::initweakpoints(self);
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_spawn");
  self thread namespace_9fc66ac::function_ba33d23d(#"hash_4d91ba683ffb7c6e", #"hash_4d91ba683ffb7c6e", #"hash_5f3161f401802be0");
  level.doa.var_da713110++;
}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_8383fdf9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73649a2d01c11f41", &function_8383fdf9);
  assert(isscriptfunctionptr(&blightfathershouldshowpain));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldshowpain", &blightfathershouldshowpain);
  assert(isscriptfunctionptr(&function_3515ad4b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_41aa80b14334caac", &function_3515ad4b);
  assert(isscriptfunctionptr(&function_aaad8487));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_124ccb4b34a00c0f", &function_aaad8487);
  assert(isscriptfunctionptr(&function_4bd1c37e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_667d737e6c9aba40", &function_4bd1c37e);
  assert(isscriptfunctionptr(&function_764f26b5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_36ae5ced58f7bca9", &function_764f26b5);
  assert(isscriptfunctionptr(&blightfatherdeathstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherdeathstart", &blightfatherdeathstart);
  assert(isscriptfunctionptr(&function_d5a0a1eb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1db7e3af327c9b04", &function_d5a0a1eb);
  assert(isscriptfunctionptr(&function_e0d8f770));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7817d265f22976fd", &function_e0d8f770);
  assert(isscriptfunctionptr(&function_8d9b9683));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77b88d91d0990898", &function_8d9b9683);
  assert(!isDefined(&function_643a6055) || isscriptfunctionptr(&function_643a6055));
  assert(!isDefined(&function_9b5faaf6) || isscriptfunctionptr(&function_9b5faaf6));
  assert(!isDefined(&function_d6ccc9e9) || isscriptfunctionptr(&function_d6ccc9e9));
  behaviortreenetworkutility::registerbehaviortreeaction("blightFatherVomitAction", &function_643a6055, &function_9b5faaf6, &function_d6ccc9e9);
  animationstatenetwork::registernotetrackhandlerfunction("blight_father_vomit_start", &function_7a634eaa);
  animationstatenetwork::registernotetrackhandlerfunction("fire_left", &function_d2b91209);
  animationstatenetwork::registernotetrackhandlerfunction("fire_right", &function_78f5c48e);
  animationstatenetwork::registernotetrackhandlerfunction("blight_father_melee", &function_ac921de9);
  animationstatenetwork::registernotetrackhandlerfunction("blightfather_explode", &function_b78adc65);
  assert(isscriptfunctionptr(&function_b3f66ac3));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a04596792c5199d", &function_b3f66ac3);
}

function function_b78adc65(entity) {
  if(entity isragdoll()) {
    if(entity isattached("c_t8_zmb_blightfather_eggsack1_both_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
      return;
    }

    if(entity isattached("c_t8_zmb_blightfather_eggsack1_le_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
      return;
    }

    if(entity isattached("c_t8_zmb_blightfather_eggsack1_ri_noreveal")) {
      entity detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
    }

    return;
  }

  if(isDefined(entity.gib_model)) {
    entity.gib_model clientfield::set("blight_father_gib_explosion", 1);
    entity.gib_model stopanimscripted(0, 1);
    entity.gib_model startragdoll();
  }

  entity delete();
}

function private function_529b7fb9() {
  self endon(#"death");
  level waittilltimeout(300, #"clear_all_corpses");

  if(isDefined(self)) {
    self delete();
  }
}

function private blightfathershouldshowpain(entity) {
  if(isDefined(entity.var_fbec06fa)) {
    return true;
  }

  return false;
}

function private function_8d9b9683(entity) {}

function private function_3515ad4b(entity) {
  return blightfathershouldshowpain(entity) || namespace_250e9486::shouldstun(entity);
}

function private function_764f26b5(entity) {
  if(is_true(entity.var_eaacf62b) && namespace_250e9486::function_60f6a9e()) {
    return false;
  }

  return entity.var_c28230ee < gettime();
}

function private function_643a6055(entity, asmstate) {
  animationstatenetworkutility::requeststate(entity, asmstate);
  entity.var_eaacf62b = 1;
  entity namespace_83eb6304::function_3ecfde67("blightfather_vomit");
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_vocal_puke_start");
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_vocal_puke_lp");
  entity.var_f4c4ff2c = gettime() + randomintrange(3000, 6000);
  entity.var_e2724436 = vectorscale(anglesToForward(entity.angles), 5);
  entity.var_cacacf22 = entity gettagorigin("tag_jaw");
  return 5;
}

function private function_9b5faaf6(entity, asmstate) {
  if(asmstate.var_f4c4ff2c < gettime()) {
    asmstate asmrequestsubstate("vomit_end@blight_father");
    return 4;
  }

  asmstate blightfathercreatecrawleregg();
  return 5;
}

function private function_d6ccc9e9(entity, asmstate) {
  asmstate.var_c28230ee = gettime() + randomintrange(5000, 15000);

  if(is_true(asmstate.var_eaacf62b)) {
    asmstate namespace_83eb6304::turnofffx("blightfather_vomit");
    asmstate namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_vocal_puke_end");
    asmstate namespace_e32bb68::function_ae271c0b("zmb_doa_ai_bfather_vocal_puke_lp");
  }

  asmstate.var_eaacf62b = 0;
  return 4;
}

function private blightfathercreatecrawleregg() {
  if(randomint(100) < 15) {
    egg = namespace_ec06fe4a::spawnmodel(self.var_cacacf22, "zombietron_crawler_egg", undefined, "blightFatherCreateCrawlerEgg");

    if(isDefined(egg)) {
      egg thread function_7512b675(self.var_e2724436);
    }
  }
}

function private function_9251853b() {
  self notify("457fd8acc68bda71");
  self endon("457fd8acc68bda71");
  self endon(#"death");

  while(self.health > 0) {
    result = self waittill(#"damage");
  }

  self.takedamage = 0;
  self.health = 1;
  self namespace_83eb6304::function_3ecfde67("egg_explode");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_egg_explode");
  self namespace_ec06fe4a::function_8c808737();
  self thread namespace_ec06fe4a::function_52afe5df(0.2);
}

function function_475aaa85() {
  self notify("383d1e3189d7e4f5");
  self endon("383d1e3189d7e4f5");
  self endon(#"death");
  result = level waittill(#"hash_c1cceae4479f2e5");
  distsq = distancesquared(self.origin, result.origin);

  if(distsq < sqr(1000)) {
    self.health = 1;
    self namespace_83eb6304::function_3ecfde67("egg_explode");
    self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_egg_explode");
    self namespace_ec06fe4a::function_8c808737();
    self thread namespace_ec06fe4a::function_52afe5df(0.2);
    return;
  }

  self thread function_475aaa85();
}

function private function_7512b675(launchdir) {
  self notify("4a3e218ccbf4897a");
  self endon("4a3e218ccbf4897a");
  self endon(#"death");
  self enableaimassist();
  self physicslaunch(self.origin, launchdir);
  self.takedamage = 1;
  self.health = 500;
  self thread namespace_ec06fe4a::function_ad852085(level, "arena_completed");
  self thread namespace_ec06fe4a::function_ad852085(level, "exit_taken");
  self thread namespace_ec06fe4a::function_ad852085(level, "round_over");
  self thread function_9251853b();
  self thread function_475aaa85();
  var_a729d295 = randomintrange(7000, 15000);
  starttime = gettime();
  timeleft = starttime + var_a729d295;

  while(true) {
    if(level flag::get("doa_game_is_over")) {
      self thread namespace_ec06fe4a::function_570729f0(0.1);
      return;
    }

    time = gettime();
    scale = mapfloat(starttime, timeleft, 1, 5, time);

    if(time > timeleft) {
      break;
    }

    self setscale(scale);
    waitframe(1);
  }

  self namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
  self namespace_83eb6304::function_3ecfde67("egg_explode");
  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_egg_spawn");
  self namespace_ec06fe4a::function_8c808737();
  ai = doa_enemy::function_db55a448(level.doa.var_6b8705f1, self.origin);
  self thread namespace_ec06fe4a::function_52afe5df(0.2);
}

function private blightfatherdeathstart(entity) {
  entity val::set(#"blight_father_death", "takedamage", 0);

  if(level.var_79b2615b === entity) {
    level.var_79b2615b = undefined;
  }

  if(!entity isragdoll()) {
    gib_model = util::spawn_anim_model("c_t8_zmb_blightfather_body1_gib", entity.origin, entity.angles);

    if(!isDefined(gib_model)) {
      return;
    }

    gib_model animscripted(#"hash_56a346d1e0dd61cd", gib_model.origin, gib_model.angles, #"hash_3e937fff0e0a4362", "normal");
    gib_model thread function_529b7fb9();
    entity.gib_model = gib_model;
  }
}

function private function_ac921de9(entity) {
  meleerange = entity ai::function_9139c839().var_558fb394;
  meleerangesq = sqr(meleerange);
  potential_players = [];

  foreach(player in getplayers()) {
    if(meleerangesq < distancesquared(entity.origin, player.origin)) {
      continue;
    }

    if(!isDefined(potential_players)) {
      potential_players = [];
    } else if(!isarray(potential_players)) {
      potential_players = array(potential_players);
    }

    if(!isinarray(potential_players, player)) {
      potential_players[potential_players.size] = player;
    }
  }

  bhtnactionstartevent(entity, "attack_melee");
  entity namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_vocal_melee");
  registernotice_walla = anglesToForward(entity.angles);
  var_2f706708 = entity gettagorigin("j_spine4");
  var_9b246038 = entity ai::function_9139c839().var_4e8d4c24;

  foreach(player in potential_players) {
    vec_to_player = vectornormalize(player.origin - entity.origin);

    if(vectordot(vec_to_player, registernotice_walla) < var_9b246038) {
      continue;
    }

    if(bullettracepassed(var_2f706708, player getEye(), 0, entity)) {
      player dodamage(200, entity.origin, entity, entity, "none", "MOD_MELEE");
    }
  }
}

function private function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
}

function private function_fa7c080(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  modelindex.var_c8f98f87 = 1;
  modelindex.var_6ee32f47 = 1;
  modelindex clientfield::set("blight_father_weakpoint_jaw_fx", 0);
  modelindex attach("c_t8_zmb_blightfather_mouth_dmg1");
}

function private function_9bbe631c(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  modelindex clientfield::set("blight_father_weakpoint_l_elbow_fx", 0);
}

function private function_5a1a4ad(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  modelindex clientfield::set("blight_father_weakpoint_r_elbow_fx", 0);
}

function private function_40034805(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  modelindex.var_177b7a47 = 1;
  modelindex clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 0);

  if(is_true(modelindex.var_7c54fb46)) {
    modelindex detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
    return;
  }

  modelindex detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  modelindex attach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
}

function private function_33b2c99e(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  modelindex.var_7c54fb46 = 1;
  modelindex clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 0);

  if(is_true(modelindex.var_177b7a47)) {
    modelindex detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
    return;
  }

  modelindex detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
  modelindex attach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
}

function private function_cacd1506(var_84ed9a13, entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(namespace_81245006::function_f29756fe(var_84ed9a13) != 1) {
    return;
  }

  namespace_81245006::damageweakpoint(var_84ed9a13, damage);

  if(namespace_81245006::function_f29756fe(var_84ed9a13) == 3) {
    if(isDefined(level.var_c2981ce9[var_84ed9a13.var_51e8b151])) {
      entity[[level.var_c2981ce9[var_84ed9a13.var_51e8b151]]](entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
    }

    if(!entity isplayinganimscripted()) {
      entity.var_fbec06fa = var_84ed9a13.var_51e8b151;
      entity setblackboardattribute("_blight_father_weak_point", var_84ed9a13.var_51e8b151);
    }

    bone = boneindex;

    if(namespace_ec06fe4a::is_explosive_damage(meansofdamage)) {
      bone = var_84ed9a13.var_51e8b151;
    }

    function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, bone, modelindex);
  }
}

function private function_afce1cf(inflictor, attacker, damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  entity = self;
  var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, hitloc, 1);

  if(!isDefined(var_dd54fdb1)) {
    var_dd54fdb1 = namespace_81245006::function_73ab4754(self, point, 1);
  }

  var_786d7e06 = namespace_250e9486::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point, var_dd54fdb1);
  damage_scale = var_786d7e06.damage_scale;
  var_84ed9a13 = var_786d7e06.var_84ed9a13;
  registerzombie_bgb_used_reinforce = var_786d7e06.registerzombie_bgb_used_reinforce;

  if(namespace_ec06fe4a::is_explosive_damage(meansofdamage)) {
    damage_scale = max(damage_scale, entity ai::function_9139c839().explosivedamagescale);
    final_damage = int(damage * damage_scale);

    if(meansofdamage === "MOD_PROJECTILE" && isDefined(var_84ed9a13) && registerzombie_bgb_used_reinforce) {
      function_cacd1506(var_84ed9a13, entity, inflictor, attacker, var_84ed9a13.health, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
  } else {
    final_damage = int(damage * damage_scale);

    if(isDefined(var_84ed9a13) && registerzombie_bgb_used_reinforce) {
      function_cacd1506(var_84ed9a13, entity, inflictor, attacker, final_damage, flags, meansofdamage, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
  }

  var_799e18e5 = point;
  var_5f32808d = 1;

  if(final_damage >= 1000) {
    var_5f32808d = 2;
  }

  self namespace_ec06fe4a::function_2f4b0f9(self.health - final_damage, attacker, var_799e18e5, final_damage, var_5f32808d);
  return final_damage;
}

function private function_5d7f8057(entity, player) {
  if(entity.var_c8088bcb.timestamp !== gettime()) {
    entity.var_c8088bcb.traces = [];
    entity.var_c8088bcb.timestamp = gettime();
  } else if(isDefined(entity.var_c8088bcb.traces[player getentitynumber()])) {
    return entity.var_c8088bcb.traces[player getentitynumber()];
  }

  clip_mask = 1 | 8;

  if(player haspart("j_mainroot")) {
    trace = physicstrace(entity.origin + (0, 0, 35), player gettagorigin("j_mainroot"), (-15, -15, -20), (15, 15, 40), entity, clip_mask);
  } else {
    trace = physicstrace(entity.origin + (0, 0, 35), player.origin, (-15, -15, -20), (15, 15, 40), entity, clip_mask);
  }

  entity.var_c8088bcb.traces[player getentitynumber()] = trace;
  return trace;
}

function private function_aaad8487(entity) {
  if(!isDefined(level.var_e82b911f) || level.var_e82b911f === entity) {
    level.var_e82b911f = entity;
    return true;
  }

  return false;
}

function private function_3782350(entity) {
  level.var_e82b911f = undefined;
}

function private function_4bd1c37e(entity) {
  if(function_aaad8487(entity)) {
    if(function_8383fdf9(entity)) {
      return true;
    }
  }

  return false;
}

function private function_7a634eaa(entity) {
  entity clientfield::set("blight_father_vomit_fx", 2);
}

function private function_b3f66ac3(entity) {
  entity clientfield::set("blight_father_vomit_fx", 0);
}

function private function_37d1a803(entity) {
  return entity ai::function_9139c839().var_f246f6de;
}

function private function_71b8279d(entity) {
  return is_true(entity.var_6ee32f47);
}

function private function_63b7576d() {
  var_3c533fa2 = 0;

  foreach(trigger in level.var_445e24c8) {
    if(!trigger.inuse) {
      var_3c533fa2++;
    }
  }

  return var_3c533fa2;
}

function private function_c48604c0() {
  foreach(trigger in level.var_445e24c8) {
    if(!trigger.inuse) {
      trigger.inuse = 1;
      trigger triggerenable(1);
      return trigger;
    }
  }

  return undefined;
}

function private function_da2c4ce9(trigger) {
  trigger.inuse = 0;
  trigger triggerenable(0);
  trigger.origin = (0, 0, 0);
}

function private function_8383fdf9(entity) {
  var_329b1080 = function_19249d10(entity);
  function_3782350(entity);
  return var_329b1080;
}

function private function_19249d10(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    return false;
  }

  if(!isPlayer(entity.favoriteenemy)) {
    return false;
  }

  if(is_true(entity.var_177b7a47) && is_true(entity.var_7c54fb46)) {
    return false;
  }

  if(isDefined(level.var_79b2615b) && level.var_79b2615b != entity && isalive(level.var_79b2615b)) {
    return false;
  }

  if(!function_71b8279d(entity) && entity.var_b2a80abc > gettime()) {
    return false;
  }

  var_d0651e10 = function_63b7576d();

  if(var_d0651e10 <= 0) {
    return false;
  } else if(!is_true(entity.var_177b7a47) && !is_true(entity.var_7c54fb46) && var_d0651e10 < 3) {
    return false;
  }

  forward = anglesToForward(entity.angles);
  forward2d = vectornormalize((forward[0], forward[1], 0));
  dirtotarget = entity.favoriteenemy.origin - entity.origin;
  var_854904a = vectornormalize((dirtotarget[0], dirtotarget[1], 0));
  dot = vectordot(forward2d, var_854904a);

  if(dot < entity ai::function_9139c839().var_aa503e5a) {
    return false;
  }

  test_trace = function_5d7f8057(entity, entity.favoriteenemy);

  if(test_trace[# "fraction"] < 1 && test_trace[# "entity"] !== entity.favoriteenemy) {
    return false;
  }

  height = self.maxs[2] - self.mins[2];
  forward = anglesToForward(self.angles);
  var_725b8fb5 = forward * entity ai::function_9139c839().var_167cbf22;
  var_edabd3cd = bullettracepassed(self.origin + (0, 0, height), self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);

  recordline(self.origin + (0, 0, height), self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));

  if(var_edabd3cd) {
    var_c46a2de3 = forward * entity ai::function_9139c839().var_baa42d79;
    var_edabd3cd = bullettracepassed(self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), self.origin + var_c46a2de3 + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);

    recordline(self.origin + var_725b8fb5 + (0, 0, height + entity ai::function_9139c839().var_73212b51), self.origin + var_c46a2de3 + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));
  }

  if(!var_edabd3cd) {
    return false;
  }

  var_9c2b856b = distancesquared(entity.origin, entity.favoriteenemy.origin);

  if(var_9c2b856b < sqr(entity ai::function_9139c839().var_cdf6b76d) || var_9c2b856b > sqr(entity ai::function_9139c839().var_652a36f2)) {
    return false;
  }

  return true;
}

function private function_d5a0a1eb(entity) {
  entity clientfield::set("blight_father_amb_sac_clientfield", 0);
}

function private function_e0d8f770(entity) {
  entity.var_b2a80abc = gettime() + function_37d1a803(entity);
  level.var_79b2615b = undefined;
  entity clientfield::set("blight_father_amb_sac_clientfield", 1);
}

function private function_d2b91209(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    println("<dev string:x38>");
    return;
  }

  entity clientfield::increment("blight_father_spawn_maggot_fx_left");
  entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_le");
}

function private function_78f5c48e(entity) {
  if(!isDefined(entity.favoriteenemy)) {
    println("<dev string:x38>");
    return;
  }

  entity clientfield::increment("blight_father_spawn_maggot_fx_right");
  entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, (0, 0, 5), "tag_sac_fx_ri");
}

function private function_ebd22bba() {
  self endon(#"death");
  util::wait_network_frame();
  self clientfield::set("blight_father_maggot_trail_fx", 1);
}

function private blightfatherlaunchchaosmissile(var_f794172e, var_61622673, var_f3486358) {
  var_ced3ec54 = self gettagorigin(var_f3486358);
  var_27e1ee12 = var_f794172e.origin + var_61622673;

  if(is_true(self.var_6ee32f47)) {
    self.var_6ee32f47 = 0;
  }

  self namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_vocal_missile");
  var_892397fd = namespace_ec06fe4a::spawnmodel(var_ced3ec54, "tag_origin");

  if(!isDefined(var_892397fd)) {
    return;
  }

  var_892397fd.targetname = "blightfatherLaunchChaosMissile";
  var_a9494306 = function_c48604c0();

  if(!isDefined(var_a9494306)) {
    var_892397fd delete();
    return;
  }

  var_a9494306.origin = var_892397fd.origin;
  var_a9494306.angles = var_892397fd.angles;
  var_a9494306 linkto(var_892397fd, "tag_origin");
  var_892397fd.trigger = var_a9494306;
  var_892397fd thread function_b2be1340(self ai::function_9139c839().var_a2519bb8);
  var_892397fd thread function_ebd22bba();
  var_892397fd thread function_a6a20b2c(var_a9494306);
  var_892397fd namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_missile_start");
  var_892397fd namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_missile_lp");
  var_892397fd.var_f3d1c928 = 0;
  var_892397fd.var_52334e8c = self;
  angles_to_enemy = self gettagangles(var_f3486358);
  normal_vector = anglesToForward(angles_to_enemy);
  var_892397fd.angles = angles_to_enemy;
  var_892397fd.var_209ff2fa = normal_vector * self ai::function_9139c839().var_f988064f;
  max_trail_iterations = int(self ai::function_9139c839().var_652a36f2 / self ai::function_9139c839().var_52bddd4 * self ai::function_9139c839().var_9e5ebf3c);
  var_892397fd.missile_target = var_f794172e;
  var_892397fd thread function_5f3390fd(var_61622673, 40);
  var_892397fd moveto(self gettagorigin(var_f3486358) + var_61622673, self ai::function_9139c839().var_20c6e4ca);
  var_eb325a79 = self ai::function_9139c839().var_9e5ebf3c;
  var_b446b077 = self ai::function_9139c839().var_94fefe66;
  var_3fa92868 = self ai::function_9139c839().var_52bddd4;
  wait self ai::function_9139c839().var_20c6e4ca;

  while(isDefined(var_892397fd)) {
    if(!is_player_valid(var_892397fd.missile_target, 1)) {
      var_892397fd.missile_target = undefined;
      players = getplayers();
      players = arraysortclosest(players, var_892397fd.origin);

      foreach(player in players) {
        if(is_player_valid(player, 1)) {
          var_892397fd.missile_target = player;
          break;
        }
      }
    }

    if(var_892397fd.var_f3d1c928 >= max_trail_iterations) {
      var_892397fd thread function_124486ee(0);
    } else {
      var_892397fd function_1974d26f(var_3fa92868, var_b446b077, var_eb325a79);
      var_892397fd.var_f3d1c928 += 1;
    }

    wait var_eb325a79;
  }
}

function function_a6a20b2c(var_3797b49d) {
  self waittill(#"death");
  var_3797b49d unlink();
  function_da2c4ce9(var_3797b49d);
}

function function_b2be1340(starting_health) {
  self endon(#"detonated");
  self.n_health = starting_health;

  while(self.n_health > 0) {
    s_notify = self.trigger waittill(#"damage");

    if(isDefined(s_notify.attacker) && isPlayer(s_notify.attacker) && s_notify.amount > 0) {
      self.n_health -= s_notify.amount;
    }
  }

  self thread function_124486ee(0);
}

function private function_581a06c7(forward_dir, var_ced3ec54, var_27e1ee12, max_angle) {
  vec_to_enemy = var_27e1ee12 - var_ced3ec54;
  vec_to_enemy_normal = vectornormalize(vec_to_enemy);
  angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);

  if(angle_to_enemy >= max_angle) {
    return vec_to_enemy_normal;
  }

  plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
  perpendicular_normal = vectorcross(plane_normal, forward_dir);
  var_21f9edfd = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
  return var_21f9edfd;
}

function private function_5f3390fd(var_61622673, var_4fee43d4) {
  self endon(#"death", #"detonated");
  var_892397fd = self;

  while(isDefined(var_892397fd)) {
    player_origins = [];
    players = getplayers();

    foreach(player in players) {
      if(!isDefined(player_origins)) {
        player_origins = [];
      } else if(!isarray(player_origins)) {
        player_origins = array(player_origins);
      }

      player_origins[player_origins.size] = player getplayercamerapos();
    }

    players = arraysortclosest(player_origins, var_892397fd.origin, undefined, 0, var_4fee43d4);

    if(players.size > 0) {
      var_892397fd thread function_124486ee(0);
    }

    waitframe(1);
  }
}

function private function_1974d26f(var_3fa92868, var_10ed5867, var_eb325a79) {
  self endon(#"detonated", #"death");

  if(!isDefined(self.var_3b8e09f5)) {
    self.var_3b8e09f5 = cos(var_10ed5867 * var_eb325a79);
  }

  if(isDefined(self.missile_target) && isDefined(self.var_209ff2fa)) {
    var_6d0a510 = self.missile_target getcentroid();

    if(isPlayer(self.missile_target)) {
      var_6d0a510 = self.missile_target getplayercamerapos();
    }

    vector_to_target = var_6d0a510 - self.origin;
    normal_vector = vectornormalize(vector_to_target);
    dot = vectordot(normal_vector, self.var_209ff2fa);

    if(dot >= 1) {
      dot = 1;
    } else if(dot <= -1) {
      dot = -1;
    }

    new_vector = normal_vector - self.var_209ff2fa;
    angle_between_vectors = acos(dot);

    if(!isDefined(angle_between_vectors)) {
      angle_between_vectors = 180;
    }

    if(angle_between_vectors == 0) {
      angle_between_vectors = 0.0001;
    }

    ratio = var_10ed5867 * var_eb325a79 / angle_between_vectors;

    if(ratio > 1) {
      ratio = 1;
    }

    new_vector *= ratio;
    new_vector += self.var_209ff2fa;
    normal_vector = vectornormalize(new_vector);
  } else {
    normal_vector = self.var_209ff2fa;
  }

  move_distance = var_3fa92868 * var_eb325a79;
  move_vector = var_3fa92868 * var_eb325a79 * normal_vector;
  move_to_point = self.origin + move_vector;
  trace = bulletTrace(self.origin, move_to_point, 0, self);

  if(trace[# "surfacetype"] !== "none") {
    detonate_point = trace[# "position"];
    dist_sq = distancesquared(detonate_point, self.origin);
    move_dist_sq = move_distance * move_distance;
    ratio = dist_sq / move_dist_sq;
    delay = ratio * var_eb325a79;
    self thread function_124486ee(delay);
  }

  self.var_209ff2fa = normal_vector;
  self moveto(move_to_point, var_eb325a79);
}

function private function_124486ee(delay) {
  if(!isDefined(self)) {
    return;
  }

  var_892397fd = self;
  missile_owner = var_892397fd.var_52334e8c;
  blast_radius = 128;
  var_83f35abe = 45;
  var_6927cfa0 = 40;
  var_c45ef84c = sqr(40);

  if(delay > 0) {
    wait delay;
  }

  if(isDefined(var_892397fd)) {
    var_892397fd notify(#"detonated");
    var_892397fd moveto(var_892397fd.origin, 0.05);
    var_892397fd clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
    e_blightfather = var_892397fd.var_52334e8c;
    w_weapon = getweapon(#"none");
    var_892397fd function_8e8b1dfc(var_c45ef84c, e_blightfather, w_weapon);
    var_892397fd namespace_83eb6304::function_3ecfde67("nova_crawler_burst");
    var_892397fd namespace_e32bb68::function_3a59ec34("zmb_doa_ai_bfather_missile_imp");
    var_892397fd namespace_e32bb68::function_ae271c0b("zmb_doa_ai_bfather_missile_lp");
    offset = (0, 0, 18);

    if(bullettracepassed(var_892397fd.origin, var_892397fd.origin + offset, 0, 1)) {
      explosion_point = var_892397fd.origin + offset;
    } else {
      explosion_point = var_892397fd.origin;
    }

    util::wait_network_frame();
    players = getplayers();

    foreach(player in players) {
      player.var_c29c44ca = player.health;
    }

    groundpos = namespace_ec06fe4a::function_65ee50ba(explosion_point);
    trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", groundpos, 2 | 1 | 512, 50, 60);

    if(isDefined(trigger)) {
      trigger thread namespace_ec06fe4a::function_52afe5df(3);
      trigger thread namespace_f6712ec9::function_86555fba();
    }

    if(isDefined(var_892397fd)) {
      var_892397fd clientfield::set("blight_father_maggot_trail_fx", 0);
      util::wait_network_frame();

      if(isDefined(var_892397fd)) {
        var_892397fd delete();
      }
    }
  }
}

function private function_44e3e0d1(var_51a7ab9c) {
  players = getplayers();
  v_length = sqr(100);

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isalive(player)) {
      continue;
    }

    if(player.sessionstate == "spectator") {
      continue;
    }

    if(player.sessionstate == "intermission") {
      continue;
    }

    if(is_true(player.ignoreme)) {
      continue;
    }

    if(player isnotarget()) {
      continue;
    }

    n_distance = distance2dsquared(var_51a7ab9c, player.origin);

    if(n_distance < 0.01) {
      continue;
    }

    if(!bullettracepassed(var_51a7ab9c, player.origin, 0, 1)) {
      continue;
    }

    if(n_distance < v_length) {
      v_dir = player.origin - var_51a7ab9c;
      v_dir = (v_dir[0], v_dir[1], 0.1);
      v_dir = vectornormalize(v_dir);
      n_push_strength = getdvarint(#"hash_708ca0a943843f57", 500);
      n_push_strength = 200 + randomint(n_push_strength - 200);
      v_player_velocity = player getvelocity();
      player setvelocity(v_player_velocity + v_dir * n_push_strength);
    }
  }
}

function private function_8e8b1dfc(var_c45ef84c, blight_father, weapon) {
  foreach(player in function_a1ef346b()) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.birthtime === gettime()) {
      continue;
    }

    distancesq = distancesquared(self.origin, player.origin + (0, 0, 48));

    if(distancesq > weapon) {
      continue;
    }

    player clientfield::increment_to_player("blight_father_chaos_missile_rumble_clientfield", 1);
  }
}

function is_player_valid(player, checkignoremeflag = 1, ignore_laststand_players = 1) {
  if(!isDefined(player)) {
    return 0;
  }

  if(!isalive(player)) {
    return 0;
  }

  if(!isPlayer(player)) {
    return 0;
  }

  if(player.sessionstate == "spectator") {
    return 0;
  }

  if(player.sessionstate == "intermission") {
    return 0;
  }

  if(is_true(player.intermission)) {
    return 0;
  }

  if(!is_true(ignore_laststand_players)) {
    if(is_true(player.laststand)) {
      return 0;
    }
  }

  if(is_true(checkignoremeflag) && (player.ignoreme || player isnotarget())) {
    return 0;
  }

  if(isDefined(level.is_player_valid_override)) {
    return [[level.is_player_valid_override]](player);
  }

  return 1;
}