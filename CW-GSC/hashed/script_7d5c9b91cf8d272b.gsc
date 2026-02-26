/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7d5c9b91cf8d272b.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#namespace namespace_361e505d;

function private autoexec __init__system__() {
  system::register(#"hash_7776caebba9c5d5a", &preinit, undefined, undefined, undefined);
}

function preinit() {
  profilestart();

  if(!isarchetypeloaded(#"abom")) {
    profilestop();
    return;
  }

  registerbehaviorscriptfunctions();
  spawner::add_archetype_spawn_function(#"abom", &function_30c823be);
  clientfield::register("scriptmover", "abomLaunchBeamCF", 17000, 1, "int");
  clientfield::register("scriptmover", "abomRegisterBeamTargetCF", 17000, 1, "int");
  clientfield::register("actor", "abomBeamDissolveCF", 17000, 1, "int");
  clientfield::register("actor", "abomHeadDestroyCF", 17000, 2, "int");
  clientfield::register("actor", "abomHeadWeakpointLeCF", 17000, 1, "int");
  clientfield::register("actor", "abomHeadWeakpointMidCF", 17000, 1, "int");
  clientfield::register("actor", "abomHeadWeakpointRiCF", 17000, 1, "int");
  clientfield::register("actor", "abomRoarCF", 17000, 1, "int");
  clientfield::register("actor", "abomMovingCF", 17000, 1, "int");
  clientfield::register("actor", "abomDissolveCF", 17000, 2, "int");
  clientfield::register("toplayer", "abomBullChargeHitPlayerCF", 17000, 1, "int");
  clientfield::register("allplayers", "abomBiteHitPlayerCF", 17000, 1, "counter");

  if(!isDefined(level.var_5ef577c5)) {
    level.var_5ef577c5 = new throttle();
    [[level.var_5ef577c5]] - > initialize(1, float(function_60d95f53()) / 1000 * 2);
  }

  if(util::get_game_type() === # "zsurvival") {
    level.var_1a4cc228[#"hash_7cba8a05511ceedf"] = [#"hash_49adea61f71924bf", #"hash_1798ecca7f98873d", #"hash_26f6708ef92a0eae", #"hash_1c8805fec5806efe", #"hash_4d95f42b33499eba", #"hash_6799427e5e6c417c", #"hash_11e4908180a964c", #"hash_1340313347e93335"];
    level.var_1a4cc228[#"hash_29771ab26cb78d9b"] = [#"hash_69143c727337ba1a", #"hash_299e8cfa6d75ffd4", #"hash_7d223eb036f4a31b", #"hash_11d7f39f088f3822", #"hash_5e074c09a3a31d97", #"hash_1c437f787033a2e5", #"hash_34d9e63476111b5d", #"hash_779daa809936d578"];
    level.var_1a4cc228[#"hash_46c917a1b5ed91e7"] = [#"hash_4729aed4cfa43476"];
    level.var_1a4cc228[#"hash_338eb4103e0ed797"] = [#"hash_59e40ffcdcfbffa6"];
    level.var_1a4cc228[#"hash_124b582ce08d78c0"] = [#"hash_149fa86a9c5d858c", #"hash_63e9d6f275dc720", #"hash_94674cb554826a9", #"hash_6b9e4c8e8e955c71", #"hash_75cfd69ce1d6f3dd", #"hash_33c0e923173d2b48", #"hash_53dbc62471a61f88", #"hash_4ece13caf46c00c7"];
    level.var_1a4cc228[#"hash_30e4941b102093c4"] = [#"hash_5c0dcc3f9d9e1ea5", #"hash_e8b647bb58521c1", #"hash_23492308d6911444", #"hash_5616978b668f07dc", #"hash_31713e12a88def10", #"hash_3e647996c0a4d6b9", #"hash_b35b3dcb7417075", #"hash_53dbc62471a61f88"];
    level.var_1a4cc228[#"hash_78215fa79f5557dc"] = [#"hash_4814b7b3c67568e3"];
    level.var_1a4cc228[#"hash_12a17ab3df5889eb"] = level.var_1a4cc228[#"hash_78215fa79f5557dc"];
    level.var_1a4cc228[#"hash_7a8b592728eec95d"] = [#"hash_2cb37314243526ec"];
    level.var_1a4cc228[#"hash_729b116cf9d044"] = [#"hash_78238b400ae08c28"];
  } else if(util::get_map_name() == "zm_tungsten") {
    level.var_1a4cc228[#"spawner_bo5_zombie_zm_tungsten"] = [#"hash_42c772d33b3b95d7", #"hash_32561af4cae216fa", #"hash_63d74789d0b11dbc", #"hash_5c0dcc3f9d9e1ea5"];
    level.var_1a4cc228[#"spawner_bo5_zombie_zm_tungsten_armor_heavy"] = [#"hash_4729aed4cfa43476"];
    level.var_1a4cc228[#"spawner_bo5_zombie_zm_tungsten_armor_medium"] = [#"hash_59e40ffcdcfbffa6"];
    level.var_1a4cc228[#"hash_517608365a182612"] = [#"hash_65c4a876c73aee27", #"hash_29b24e853bff328a", #"hash_7f1bca93226fa0d6", #"hash_7e8014d9564c6ed5", #"hash_15d9acb30e6d566c"];
    level.var_1a4cc228[#"hash_3263f276cf59dde6"] = [#"hash_65c4a876c73aee27"];
    level.var_1a4cc228[#"hash_3263f176cf59dc33"] = [#"hash_29b24e853bff328a"];
    level.var_1a4cc228[#"hash_3263f076cf59da80"] = [#"hash_15d9acb30e6d566c"];
    level.var_1a4cc228[#"spawner_bo5_zombie_zm_tungsten_omega_soldier"] = [#"hash_656d60e84740cf6b", #"hash_7b3bac29e8e3bf13", #"hash_35d84238103deb46", #"hash_1c8805fec5806efe", #"hash_7151a0027b3ff314", #"hash_78a973a6fb604cf", #"hash_2d07ee0d2dca46d9", #"hash_1c89bc2d12106779"];
  }

  thread function_ac104a3d();
  level thread function_e1f48a38();

  profilestop();
}

function function_30c823be() {
  function_8673af9f();
  self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
  self.var_318a0ac8 = &function_a1e5b1db;
  self.custom_melee_fire = &function_a86617d;
  self.allowpain = 0;
  self.var_58c4c69b = 1;
  self.var_586465e4 = 3;
  self.ai.var_24b39f1f = 10;
  self.var_97ca51c7 = 1;
  self.var_d7fb5a47 = [1, 1, 1];
  self.var_42bc30c = [0, 0, 0];
  self.var_dc06e6af = [0, 0, 0];
  self.var_32309360 = [#"c_t9_zmb_abomination_head_le", #"c_t9_zmb_abomination_head_mid", #"c_t9_zmb_abomination_head_ri"];
  self.var_41ab433a = [#"hash_225113cbb97cb6c4", #"hash_45992c2c2b853aab", #"hash_223d33cbb96c441a"];

  if(is_true(self.var_c588eb)) {
    self.var_32309360 = [#"c_t9_zmb_abomination_head_le_hvt", #"c_t9_zmb_abomination_head_mid_hvt", #"c_t9_zmb_abomination_head_ri_hvt"];
    self.var_41ab433a = [#"hash_3875479bd5ec9589", #"hash_5d4fa8ff5ae6d69e", #"hash_5f0763114ded2197"];
  }

  self.var_7baf0b4d = ["j_head_le", "j_head", "j_head_ri"];
  self.var_a8bb18af = [2, 3, 3];
  self.var_ef229fd6 = [15, 15, 12];
  self.var_ac8b8c0f = ["abomHeadWeakpointLeCF", "abomHeadWeakpointMidCF", "abomHeadWeakpointRiCF"];
  self.var_ef651d05 = ["tag_fx_head_le_throat", "tag_fx_head_center_throat", "tag_fx_head_ri_throat"];
  self.var_460b8f9b = self getpathfindingradius();
  self.var_ca68c386 = self function_6a9ae71();
  self callback::function_d8abfc3d(#"on_ai_damage", &function_f7441304);
  self callback::function_d8abfc3d(#"on_ai_killed", &function_8991b66);
  self callback::add_callback(#"on_ai_killed", &function_ea311395);
  self attach(self.var_32309360[0]);
  self attach(self.var_32309360[1]);
  self attach(self.var_32309360[2]);
  function_9de20709(self, 1, int(20 * 1000));
  function_9de20709(self, 4, int(5 * 1000));
  self thread function_18fd18de(self);
  self thread function_838ac041(self);
  self thread function_940cd1d8();
  self function_2038df41(self);
}

function private function_8673af9f() {
  blackboard::createblackboardforentity(self);
  self.___archetypeonanimscriptedcallback = &function_41c5d1ff;
}

function private function_41c5d1ff(entity) {
  entity.__blackboard = undefined;
  entity function_8673af9f();
}

function registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_40e1bdb2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ccdad05e3dfdf0", &function_40e1bdb2);
  assert(isscriptfunctionptr(&function_d8fde04f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a264fd56611d346", &function_d8fde04f);
  assert(isscriptfunctionptr(&function_c5713c35));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57c0df901a90b8ec", &function_c5713c35);
  assert(isscriptfunctionptr(&function_e1acd797));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e8c8ba5f797cbdd", &function_e1acd797);
  assert(isscriptfunctionptr(&function_e363211b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_67a8cd116f7096a4", &function_e363211b);
  assert(!isDefined(&function_209f64c3) || isscriptfunctionptr(&function_209f64c3));
  assert(!isDefined(&function_132c087b) || isscriptfunctionptr(&function_132c087b));
  assert(!isDefined(&function_25b49d18) || isscriptfunctionptr(&function_25b49d18));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_27d2c66cd3993e87", &function_209f64c3, &function_132c087b, &function_25b49d18);
  assert(isscriptfunctionptr(&function_983f6134));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7e695110b86764c7", &function_983f6134);
  assert(isscriptfunctionptr(&function_6f6a2167));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68791b5401a757d8", &function_6f6a2167);
  assert(isscriptfunctionptr(&function_dd80b921));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_787ad56a97636ea4", &function_dd80b921);
  assert(isscriptfunctionptr(&function_fc02984a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_66f085cf6783c6cb", &function_fc02984a);
  assert(isscriptfunctionptr(&function_48400b3b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5eeebea90ed4ecce", &function_48400b3b);
  assert(isscriptfunctionptr(&function_3e6c0b74));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ac5c748ecc553cf", &function_3e6c0b74);
  assert(!isDefined(&function_998c02dd) || isscriptfunctionptr(&function_998c02dd));
  assert(!isDefined(&function_39d052f1) || isscriptfunctionptr(&function_39d052f1));
  assert(!isDefined(&function_33bbae5c) || isscriptfunctionptr(&function_33bbae5c));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7a0bda56e765e93", &function_998c02dd, &function_39d052f1, &function_33bbae5c);
  assert(isscriptfunctionptr(&function_cb669282));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2f2a98f870343b04", &function_cb669282);
  assert(isscriptfunctionptr(&function_1f33b20c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_268d56d2d40606fe", &function_1f33b20c);
  assert(isscriptfunctionptr(&function_1f33b20c));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_268d56d2d40606fe", &function_1f33b20c);
  assert(isscriptfunctionptr(&function_46855ac8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1a7c6ae7b2d009fd", &function_46855ac8);
  assert(isscriptfunctionptr(&function_8f8e4828));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_13a5f8af435e5047", &function_8f8e4828);
  assert(isscriptfunctionptr(&function_cb669282));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2f2a98f870343b04", &function_cb669282);
  assert(isscriptfunctionptr(&function_d6975705));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_37f63fc90f963787", &function_d6975705);
  assert(isscriptfunctionptr(&function_a81051b8));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3e15369ae2e0ba02", &function_a81051b8);
  assert(isscriptfunctionptr(&function_d6975705));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_37f63fc90f963787", &function_d6975705);
  assert(isscriptfunctionptr(&function_a81051b8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e15369ae2e0ba02", &function_a81051b8);
  assert(isscriptfunctionptr(&function_e75778ab));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d59d21e3b6f7923", &function_e75778ab);
  assert(isscriptfunctionptr(&function_cc49b438));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77dcfd71a9aae1a2", &function_cc49b438);
  assert(isscriptfunctionptr(&function_bbc03cca));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_13d7bf39d33c740c", &function_bbc03cca);
  assert(isscriptfunctionptr(&function_3a175c82));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1337fdf2de40e117", &function_3a175c82);
  assert(isscriptfunctionptr(&function_86e3dd7b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f7408c272e04bcf", &function_86e3dd7b);
  assert(isscriptfunctionptr(&function_fcb91a0d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34f47a9621b05d49", &function_fcb91a0d);
  assert(isscriptfunctionptr(&function_b3bc50af));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_fa82962810e4d26", &function_b3bc50af);
  assert(isscriptfunctionptr(&function_cbeafd0f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_577fbe18c438d63", &function_cbeafd0f);
  assert(isscriptfunctionptr(&function_f8efbadd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_210c7c021c6fb30e", &function_f8efbadd);
  assert(isscriptfunctionptr(&function_9d242adf));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_276abc14e4ebc2fb", &function_9d242adf);
  assert(isscriptfunctionptr(&function_e18a6f50));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3f1cfae2f9295359", &function_e18a6f50);
  assert(isscriptfunctionptr(&function_faf3547e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_22cc5a38534b2ac8", &function_faf3547e);
  assert(isscriptfunctionptr(&function_3160120e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a4c97a14693ce39", &function_3160120e);
  assert(isscriptfunctionptr(&function_3a6d62a1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62b46928d4bca570", &function_3a6d62a1);
  assert(!isDefined(&function_c0e34ca8) || isscriptfunctionptr(&function_c0e34ca8));
  assert(!isDefined(&function_640570ec) || isscriptfunctionptr(&function_640570ec));
  assert(!isDefined(&function_bcf8dd2a) || isscriptfunctionptr(&function_bcf8dd2a));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_74b036e6bb61f73a", &function_c0e34ca8, &function_640570ec, &function_bcf8dd2a);
  assert(isscriptfunctionptr(&function_e7cfd92));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_560f5388a6b3e2e8", &function_e7cfd92);
  assert(isscriptfunctionptr(&function_6791808c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4e52767083f9e130", &function_6791808c);
  assert(isscriptfunctionptr(&function_edcb107c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_cc8a263f2d4daee", &function_edcb107c);
  assert(isscriptfunctionptr(&function_acb229fd));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_399a1a1e26e04f1e", &function_acb229fd);
  assert(isscriptfunctionptr(&function_fe8e1e36));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643d6ada48d2aa54", &function_fe8e1e36);
  assert(isscriptfunctionptr(&function_150b8b34));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_49518eaed69959c2", &function_150b8b34);
  assert(isscriptfunctionptr(&function_6b70d881));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_701b10ec24211ee7", &function_6b70d881);
  assert(!isDefined(&function_59685ed1) || isscriptfunctionptr(&function_59685ed1));
  assert(!isDefined(&function_58607a4e) || isscriptfunctionptr(&function_58607a4e));
  assert(!isDefined(&function_7b02beac) || isscriptfunctionptr(&function_7b02beac));
  behaviortreenetworkutility::registerbehaviortreeaction(#"hash_d0be211581fcc79", &function_59685ed1, &function_58607a4e, &function_7b02beac);
  assert(isscriptfunctionptr(&function_19f30be));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4595b7e254f5e148", &function_19f30be);
  assert(isscriptfunctionptr(&function_69623844));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4aac2bbead44fd09", &function_69623844);
  assert(isscriptfunctionptr(&function_edde2d40));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d49d4032b033e82", &function_edde2d40);
  assert(isscriptfunctionptr(&function_4a5cebe2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64fadb62459a2d3", &function_4a5cebe2);
  assert(isscriptfunctionptr(&function_40c7079));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d45dc0a0c17074c", &function_40c7079);
  assert(isscriptfunctionptr(&function_ecb071b2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_274a29a6c6e57895", &function_ecb071b2);
  assert(isscriptfunctionptr(&function_4d225f59));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6fc7ddb1aba362eb", &function_4d225f59);
  animationstatenetwork::registeranimationmocomp("mocomp_abom_slide_outro", &function_d6971904, undefined, undefined);
  animationstatenetwork::registernotetrackhandlerfunction("abom_death_hide", &function_844fe7cb);
  animationstatenetwork::registernotetrackhandlerfunction("abom_death_dissolve", &abom_death_dissolve);
  animationstatenetwork::registernotetrackhandlerfunction("abom_head_impact", &abom_head_impact);
}

function function_f7441304(params) {
  self.var_3f6ed6d = gettime();

  if(isDefined(params.eattacker) && params.smeansofdeath === "MOD_PROJECTILE_SPLASH") {
    vehicle = params.eattacker getvehicleoccupied();

    if(vehicle.scriptvehicletype === "player_tank") {
      self flag::set_for_time(0.5, #"hash_77145e3b0a3b8a73");
    }
  }
}

function function_8991b66(params) {
  if(!self flag::get(#"hash_582584e89b2833cf")) {
    self.variant_type = 3;
  }

  if(isDefined(self.var_ee2440ac)) {
    self.var_ee2440ac delete();
  }

  if(isDefined(self.head_collision)) {
    self.head_collision delete();
  }
}

function function_ea311395(params) {
  if(params.smeansofdeath !== "MOD_ELECTROCUTED") {
    return;
  }

  if(!isDefined(params.eattacker) || params.eattacker.archetype !== # "abom") {
    return;
  }

  if(self function_ac1ff86e()) {
    self clientfield::set("abomBeamDissolveCF", 1);
    self thread function_5a2447b1(1.2);
  }
}

function function_844fe7cb(entity) {
  entity ghost();
  entity notsolid();
}

function abom_death_dissolve(entity) {
  entity clientfield::set("abomDissolveCF", 2);
}

function function_2038df41(entity) {
  origin_offset = (0, 0, 0);
  angle_offset = (0, 0, 0);
  tag_origin = entity gettagorigin("j_head");
  tag_angles = entity gettagangles("j_head");
  model = util::spawn_model(#"hash_5329fae525fc210", tag_origin, tag_angles);
  model linkto(entity, "j_head", origin_offset, angle_offset);
  model ghost();
  model.parent = entity;
  entity.head_collision = model;
  model thread function_3ee90301();
}

function private function_3ee90301() {
  self endon(#"death");
  self.parent endon(#"death");

  while(isDefined(self) && isDefined(self.parent)) {
    self.parent flag::wait_till_any([#"hash_6e15049502d1637a", #"hash_206c17809d21c1f8"]);

    if(!isDefined(self.parent)) {
      return;
    }

    if(self.parent flag::get_any([#"hash_6e15049502d1637a", #"hash_206c17809d21c1f8"])) {
      self notsolid();
    }

    self.parent flag::wait_till_clear_all([#"hash_6e15049502d1637a", #"hash_206c17809d21c1f8"]);

    if(!isDefined(self.parent)) {
      return;
    }

    if(!self.parent flag::get_all([#"hash_6e15049502d1637a", #"hash_206c17809d21c1f8"])) {
      var_a4b0369c = 0;

      while(!var_a4b0369c && isDefined(self.parent)) {
        players = getplayers(undefined, self.parent.origin, 80);
        var_a4b0369c = players.size <= 0;
        wait 1;
      }

      if(!isDefined(self.parent)) {
        return;
      }

      self solid();
    }
  }
}

function function_a1e5b1db(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(self.var_306ee014) && is_true([[self.var_306ee014]](self))) {
    vdir = 0;
  }

  self.var_426947c4 = undefined;
  var_ebcff177 = 1;
  weakpoint = namespace_81245006::function_3131f5dd(self, surfacetype, 1);

  if(!isDefined(weakpoint)) {
    weakpoint = namespace_81245006::function_73ab4754(self, boneindex, 1);
  }

  if(isDefined(weakpoint) && weakpoint.var_3765e777 === 1 && aiutility::function_e2278a4b(psoffsettime, shitloc)) {
    var_ebcff177 = 2;
    vdir *= 1;
  }

  var_c5a8cbf7 = 0;

  if(shitloc === "MOD_MELEE" || shitloc === "MOD_EXPLOSIVE") {
    damage_origin = shitloc === "MOD_MELEE" && isDefined(vpoint) ? vpoint.origin : boneindex;

    if(isDefined(damage_origin) && function_1c713d40(self)) {
      to_damage = damage_origin - self.origin;
      to_damage = (to_damage[0], to_damage[1], 0);
      dot = vectordot(anglesToForward(self.angles), vectornormalize(to_damage));

      if(dot > 0.5) {
        var_c5a8cbf7 = 1;

        if(!isDefined(weakpoint)) {
          weakpoint = namespace_81245006::function_c6aef8e0(self, damage_origin, 1);
        }
      }
    }
  }

  if(isDefined(weakpoint) && weakpoint.type === # "weakpoint" && namespace_81245006::function_f29756fe(weakpoint) !== 3) {
    var_8df5a32 = self.var_3539aa66;

    if(function_a5cc03cf(weakpoint, vdir, vpoint) && !is_true(self.var_c588eb)) {
      heads_remaining = function_fc845eb6(self);
      health_cap = 0.333333 * heads_remaining;

      if(heads_remaining === 1 && isDefined(var_8df5a32)) {
        var_d238daa9 = gettime() - var_8df5a32;
        var_a19da801 = max(1 - var_d238daa9 / int(10 * 1000), 0) * health_cap;
        health_cap += var_a19da801;
      }

      vdir = max(self.health - health_cap * self.maxhealth, vdir);
    }
  }

  if(isDefined(level.var_1b01acb4)) {
    vdir *= [[level.var_1b01acb4]](self, psoffsettime, vpoint);
  }

  if(isDefined(level.var_59505a17)) {
    if([[level.var_59505a17]](psoffsettime)) {
      if(!var_c5a8cbf7 && !isDefined(weakpoint)) {
        vdir *= 1;
      }
    }
  }

  if(shitloc === "MOD_MELEE") {
    self.var_d3c01fba = gettime();
  }

  if(!isDefined(weakpoint) && !var_c5a8cbf7) {
    vdir *= 0.2;
    var_ebcff177 = 5;
  }

  return {
    #damage: vdir, #weakpoint: weakpoint, #var_ebcff177: var_ebcff177
  };
}

function private function_a5cc03cf(weakpoint, var_31e96b81, eattacker) {
  var_5f61b252 = 0;

  if(var_31e96b81.type === # "weakpoint" && var_31e96b81.currstate === 1) {
    heads_remaining = function_fc845eb6(self);
    var_e5da1214 = 0;

    if(heads_remaining === 1 && var_31e96b81.var_3765e777 === 1) {
      if(isactor(self) && isDefined(var_31e96b81.var_98634dc5)) {
        self clientfield::increment(var_31e96b81.var_98634dc5);
      }

      if(eattacker >= self.health) {
        var_e5da1214 = 1;
        self flag::set(#"hash_582584e89b2833cf");
      }
    } else {
      namespace_81245006::damageweakpoint(var_31e96b81, eattacker);
      var_e5da1214 = namespace_81245006::function_f29756fe(var_31e96b81) === 3;
    }

    if(heads_remaining === 3 && !var_e5da1214) {
      var_a1de855e = function_290a928a(self);
      var_2234b71 = 0.15;

      if(!isDefined(self.var_9b6ec743)) {
        self.var_9b6ec743 = gettime();
      }

      if(gettime() - self.var_9b6ec743 > int(15 * 1000)) {
        var_2234b71 = 0.25;
      }

      if(var_a1de855e < var_2234b71) {
        var_e5da1214 = 1;

        if(is_true(level.var_bb61089c)) {
          println("<dev string:x38>" + "<dev string:x4b>" + var_a1de855e + "<dev string:x7a>");
        }
      }
    }

    if(var_e5da1214) {
      destructserverutils::function_8475c53a(self, var_31e96b81.var_f371ebb0);

      if(isDefined(var_31e96b81.hittags[0])) {
        var_5f61b252 = 1;

        if(is_true(level.var_bb61089c)) {
          println("<dev string:x38>" + "<dev string:x95>" + var_31e96b81.hittags[0] + "<dev string:xa7>" + eattacker);
        }

        switch (var_31e96b81.hittags[0]) {
          case # "tag_fx_jaw_le":
            function_bea34373(self, 0);
            break;
          case # "tag_fx_jaw_center":
            function_bea34373(self, 1);
            break;
          case # "tag_fx_jaw_ri":
            function_bea34373(self, 2);
            break;
        }
      }
    }
  }

  return var_5f61b252;
}

function private function_290a928a(entity, head_index) {
  weakpoints = namespace_81245006::function_fab3ee3e(entity);
  var_179f62f6 = 0;

  if(isDefined(head_index)) {
    var_179f62f6 = max(weakpoints[head_index].health, 0);
  } else {
    for(i = 0; i < 3; i++) {
      var_179f62f6 += max(weakpoints[i].health, 0);
    }
  }

  return float(var_179f62f6 / entity.maxhealth);
}

function function_17ae1df1(entity, head_index) {
  return is_true(entity.var_d7fb5a47[head_index]);
}

function function_bea34373(entity, head_index) {
  if(!is_true(entity.var_d7fb5a47[head_index])) {
    return;
  }

  entity detach(entity.var_32309360[head_index]);

  if(!entity isattached(entity.var_41ab433a[head_index])) {
    entity attach(entity.var_41ab433a[head_index]);
  }

  entity clientfield::set("abomHeadDestroyCF", head_index + 1);
  entity clientfield::set(entity.var_ac8b8c0f[head_index], 0);
  function_8d085377(entity, head_index);
  entity.var_d7fb5a47[head_index] = 0;
  entity.variant_type = head_index;
  entity.var_3539aa66 = gettime();
  entity.var_7ba69527 = 1;
  function_261709aa(entity, 1, int(5 * 1000));
}

function function_fc845eb6(entity) {
  return (entity.var_d7fb5a47[0] ? 1 : 0) + (entity.var_d7fb5a47[1] ? 1 : 0) + (entity.var_d7fb5a47[2] ? 1 : 0);
}

function function_4a5cebe2(entity) {
  return is_true(entity.var_7ba69527);
}

function function_40c7079(entity) {
  entity.var_7ba69527 = 0;

  if(!function_b31e6110(entity, 5)) {
    entity flag::set(#"hash_1b72d36ab70a9107");
  }

  function_9de20709(entity, 5, int(10 * 1000));
  entity thread flag::set_for_time(10, "abom_head_recently_blown_off");
}

function function_4d225f59(entity) {
  if(entity flag::get(#"hash_1b72d36ab70a9107")) {
    return 1000;
  }

  return int(-1);
}

function function_ecb071b2(entity) {
  entity flag::clear(#"hash_1b72d36ab70a9107");
}

function function_b31e6110(entity, attack) {
  if(isDefined(entity.var_95721b4e[attack])) {
    return (gettime() > entity.var_95721b4e[attack]);
  }

  return true;
}

function function_9de20709(entity, attack, time_ms) {
  if(!isDefined(entity.var_95721b4e)) {
    entity.var_95721b4e = [];
  }

  entity.var_95721b4e[attack] = gettime() + time_ms;
}

function function_ef9e3f0(entity, attack, time_ms) {
  if(!isDefined(entity.var_95721b4e)) {
    entity.var_95721b4e = [];
  }

  if(isDefined(entity.var_95721b4e[attack])) {
    var_b4943dff = entity.var_95721b4e[attack] - gettime();

    if(var_b4943dff > time_ms) {
      function_9de20709(entity, attack, time_ms);
    }
  }
}

function function_68ca0622(entity, attack, time_ms) {
  if(!isDefined(entity.var_95721b4e)) {
    entity.var_95721b4e = [];
  }

  if(isDefined(entity.var_95721b4e[attack])) {
    var_b4943dff = entity.var_95721b4e[attack] - gettime();

    if(var_b4943dff < time_ms) {
      function_9de20709(entity, attack, time_ms);
    }
  }
}

function function_261709aa(entity, attack, time_ms) {
  if(!isDefined(entity.var_95721b4e)) {
    entity.var_95721b4e = [];
  }

  if(isDefined(entity.var_95721b4e[attack])) {
    var_b4943dff = entity.var_95721b4e[attack] - gettime();
    new_time = var_b4943dff - time_ms;
    function_9de20709(entity, attack, new_time);

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:xca>" + attack + "<dev string:xe9>" + float(new_time) / 1000);
    }
  }
}

function function_4d4efd70(entity, attack, time_ms) {
  if(!isDefined(entity.var_95721b4e)) {
    entity.var_95721b4e = [];
  }

  if(isDefined(entity.var_95721b4e[attack])) {
    var_b4943dff = entity.var_95721b4e[attack] - gettime();

    if(var_b4943dff < time_ms) {
      function_9de20709(entity, attack, 0);
    }
  }
}

function function_940cd1d8() {
  self endon(#"death");

  if(self flag::get(#"hash_78790bd238b6fdc2")) {
    return;
  }

  self flag::set(#"hash_78790bd238b6fdc2");
  self clientfield::set("abomDissolveCF", 1);
  wait 2;
  self clientfield::set("abomDissolveCF", 0);
  self flag::clear(#"hash_78790bd238b6fdc2");
  wait 1;
  self clientfield::set("abomDissolveCF", 0);
}

function function_69623844(entity) {
  var_f08cc1e0 = function_fc845eb6(entity);
  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](self);
  }

  if(isDefined(enemy)) {
    key_zmb_ke = gettime() - (isDefined(entity.var_3f6ed6d) ? entity.var_3f6ed6d : 0);

    if(var_f08cc1e0 === 3 && key_zmb_ke > int(3 * 1000)) {
      var_f08cc1e0 -= 1;
    }

    if(var_f08cc1e0 === 2 && distancesquared(enemy.origin, entity.origin) > sqr(600) && !entity cansee(enemy) && key_zmb_ke > int(3 * 1000) * 2) {
      var_f08cc1e0 -= 1;
    }
  }

  new_move_speed = "locomotion_speed_walk";

  if(is_true(self.var_c588eb)) {
    new_move_speed = "locomotion_speed_run";
  }

  if(var_f08cc1e0 <= 1) {
    new_move_speed = "locomotion_speed_sprint";
  } else if(var_f08cc1e0 <= 2) {
    new_move_speed = "locomotion_speed_run";
  }

  var_f08cc1e0 = undefined;

  var_3700e49b = getdvarstring(#"hash_57c46d0c21968268", "<dev string:xf9>");

  if(var_3700e49b !== "<dev string:xf9>") {
    new_move_speed = var_3700e49b;
  }

  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(isDefined(new_move_speed) && new_move_speed !== move_speed) {
    entity setblackboardattribute("_locomotion_speed", new_move_speed);
  }

  function_2fe507a5(entity, entity.origin);

  if(!entity flag::get(#"hash_42f4206825b6195")) {
    entity flag::set(#"hash_42f4206825b6195");
    entity clientfield::set("abomMovingCF", 1);
    entity.var_37c36f39 = gettime();
    function_68ca0622(entity, 4, 200);

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:xfd>");
    }
  }

  entity function_d7033ff(function_2fee0cc6(entity));
  ground_trace = groundtrace(entity.origin, entity.origin - (0, 0, 20), 0, entity);
  radius = entity.var_460b8f9b;
  height = entity.var_ca68c386;

  if(ground_trace[#"fraction"] < 1) {
    if(ground_trace[#"normal"][2] < 0.9) {
      radius = getdvarint(#"hash_14c2f74ecadf1614", 15);
    }
  }

  entity setphysparams(radius, 0, height);
}

function private function_19f30be(entity) {
  if(entity flag::get(#"hash_78790bd238b6fdc2")) {
    return 0;
  }

  return btapi_locomotionbehaviorcondition(entity);
}

function private function_edde2d40(entity) {
  entity flag::clear(#"hash_42f4206825b6195");
  entity clientfield::set("abomMovingCF", 0);

  if(is_true(level.var_bb61089c)) {
    println("<dev string:x38>" + "<dev string:x10f>");
  }
}

function private function_838ac041(entity) {
  self endon(#"death");

  while(true) {
    var_30b7a63c = entity predictpath();
    status = var_30b7a63c[#"path_prediction_status"];

    if(status === 2 && !entity function_76f5c546(0)) {
      entity flag::set(#"hash_5c35337a4e15867");
    } else {
      entity flag::clear(#"hash_5c35337a4e15867");

      if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
        function_ae63c292(var_30b7a63c[#"path_prediction_enter_turn_point"], "<dev string:x121>", (0, 1, 0));
        function_ae63c292(var_30b7a63c[#"path_prediction_leave_turn_point"], "<dev string:x135>", (1, 0, 0));
      }
    }

    entity waittill(#"goal", #"goal_changed", #"path_set", #"pathfind_result");
    waitframe(1);
  }
}

function private function_cb669282(entity) {
  var_d40fc7e0 = entity function_be51bf77();

  if(var_d40fc7e0 < 45 || var_d40fc7e0 > 315) {
    return false;
  }

  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    return false;
  }

  return true;
}

function private function_1f33b20c(entity) {
  var_d40fc7e0 = entity function_be51bf77();

  if(var_d40fc7e0 < 90 || var_d40fc7e0 > 270) {
    return false;
  }

  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    return false;
  }

  if(entity flag::get(#"hash_425c5de27320d7f6")) {
    return false;
  }

  return true;
}

function private function_46855ac8(entity) {
  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    return false;
  }

  return true;
}

function private function_8f8e4828(entity) {
  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed !== "locomotion_speed_sprint") {
    return false;
  }

  if(isDefined(entity.var_37c36f39)) {
    var_370511c5 = gettime() - entity.var_37c36f39;

    if(var_370511c5 > 100) {
      return true;
    }
  }

  return false;
}

function private function_d6975705(entity) {
  entity flag::set(#"turning");
  return true;
}

function private function_a81051b8(entity) {
  entity flag::clear(#"turning");
  return true;
}

function private function_be51bf77() {
  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](self);
  }

  if(isDefined(enemy)) {
    predictedpos = self lastknownpos(enemy);

    if(isDefined(predictedpos)) {
      turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
      return turnyaw;
    }
  } else {
    goal_info = self function_4794d6a3();

    if(isDefined(goal_info.goalpos)) {
      turnyaw = absangleclamp360(self.angles[1] - vectortoangles(goal_info.goalpos - self.origin)[1]);
      return turnyaw;
    }
  }

  return 0;
}

function private function_2fee0cc6(entity) {
  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    return 1.5;
  }

  return 1;
}

function function_40e1bdb2(entity) {
  if(is_true(entity.var_a8785ea7)) {
    return true;
  }

  if(getdvarint(#"hash_1d29ba18cfbb1bbb", 0) > 0) {
    return false;
  }

  if(entity flag::get(#"hash_78790bd238b6fdc2")) {
    return false;
  }

  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(!is_true(entity.var_1fa24724) && isDefined(enemy) && zombie_utility::is_player_valid(enemy, 1)) {
    if(entity flag::get(#"hash_5c35337a4e15867")) {
      if(function_b31e6110(entity, 0)) {
        return true;
      }
    }
  }

  return false;
}

function private function_d8fde04f(entity) {
  var_4b5e91d6 = 0;
  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    if(randomfloat(1) < 0.2) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x149>");
      }

      var_4b5e91d6 = 1;
    }
  }

  if(entity flag::get(#"abom_head_recently_blown_off") || entity flag::get(#"hash_1f9ad625c3185bf4") || var_4b5e91d6) {
    entity flag::set(#"hash_1a23f4b19598f1b0");
  }
}

function private function_c5713c35(entity) {
  if(entity flag::get(#"hash_1a23f4b19598f1b0")) {
    return 1000;
  }

  return int(-1);
}

function private function_e1acd797(entity) {
  entity.var_7b0667d9 = 1;
}

function private function_e363211b(entity) {
  entity.var_7b0667d9 = 0;
}

function function_209f64c3(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  entity.var_ccd1e8c = gettime();
  function_9de20709(entity, 0, int(20 * 1000));
  entity.var_4f5d39ac = entity getvelocity();
  entity.var_2bd7ca9d = 0;
  entity flag::clear(#"hash_5047ba8da693e1c5");
  entity.var_2976f01f = entity.origin;
  entity flag::set(#"hash_206c17809d21c1f8");
  return 5;
}

function function_132c087b(behaviortreeentity, asmstatename) {
  velocity = asmstatename getvelocity();

  if(!isDefined(asmstatename.var_4f5d39ac)) {
    asmstatename.var_4f5d39ac = velocity;
  }

  var_71610b41 = 0.2;
  var_9a4357f2 = asmstatename.origin + velocity * var_71610b41;

  if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
    function_ae63c292(var_9a4357f2, "<dev string:x17a>", (0, 0, 1));
  }

  function_2fe507a5(asmstatename, var_9a4357f2, undefined, 1);
  function_e3ae0cb7(asmstatename, var_9a4357f2);
  var_11d22bae = function_849b329(asmstatename, var_9a4357f2);

  if(is_true(var_11d22bae)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x18d>");
    }

    return 4;
  }

  drop_height = 60;
  var_53b2da60 = zombie_utility::function_d446de65(asmstatename, var_9a4357f2, drop_height, 0.5);

  if(isDefined(var_53b2da60)) {
    if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
      function_ae63c292(var_53b2da60, "<dev string:x1b9>", (1, 0, 1));
    }
  }

  trace_z_offset = (0, 0, 70);
  var_1cdbb377 = 40;
  var_b76d460e = (var_1cdbb377 * -1, var_1cdbb377 * -1, -5);
  var_d7c27d70 = (var_1cdbb377, var_1cdbb377, 5);
  trace_point = var_9a4357f2 + vectornormalize(velocity) * 30;
  trace_point = (trace_point[0], trace_point[1], max(var_9a4357f2[2], asmstatename.origin[2]));
  trace = physicstraceex(asmstatename.origin + trace_z_offset, trace_point + trace_z_offset, var_b76d460e, var_d7c27d70);
  trace_hit = isDefined(trace[#"fraction"]) && trace[#"fraction"] < 1;

  if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
    box_origin = trace[#"position"];
    var_7ce15329 = trace_hit ? (1, 0, 0) : (0.75, 0.75, 0.75);
    recordbox(box_origin, var_b76d460e, var_d7c27d70, asmstatename.angles[1], var_7ce15329);
    recordline(asmstatename.origin + trace_z_offset, box_origin, var_7ce15329);

    if(isDefined(trace[#"entity"])) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x1d4>" + trace[#"entity"] getentitynumber() + "<dev string:x1f1>");
      }
    }
  }

  speed_sq = lengthsquared(velocity);
  var_875531fe = lengthsquared(asmstatename.var_4f5d39ac);

  if(speed_sq * 4 <= var_875531fe) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x1f6>" + sqrt(speed_sq));
    }

    asmstatename.var_2bd7ca9d = 1;
    asmstatename thread flag::set_for_time(2.5, #"hash_5047ba8da693e1c5");
    return 4;
  }

  if(trace_hit) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x22b>" + (isDefined(trace[#"normal"]) ? trace[#"normal"] : "<dev string:xf9>"));
    }

    asmstatename.var_2bd7ca9d = 1;
    asmstatename thread flag::set_for_time(2.5, #"hash_5047ba8da693e1c5");
    asmstatename.var_d86b94b3 = {
      #origin: trace[#"position"], #normal: trace[#"normal"]
    };
    return 4;
  }

  if(!isDefined(var_53b2da60)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x26a>" + var_9a4357f2);
    }

    return 4;
  }

  var_5ad0c90c = int(1 * 1000);

  if(speed_sq < 25 && gettime() > asmstatename.var_ccd1e8c + var_5ad0c90c) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x2aa>");
    }

    return 4;
  }

  if(!isDefined(asmstatename.var_f1888c9d)) {
    asmstatename.var_f1888c9d = 0;
  }

  if(gettime() > asmstatename.var_f1888c9d) {
    var_6ff44b20 = 2;

    if(asmstatename flag::get(#"hash_1a23f4b19598f1b0")) {
      var_6ff44b20 = 0.2;
    }

    asmstatename.var_f1888c9d = gettime() + int(var_6ff44b20 * 1000);
    enemy = undefined;

    if(isDefined(level.var_f67b08f5)) {
      enemy = [[level.var_f67b08f5]](asmstatename);
    }

    var_885a3974 = 0;

    if(isDefined(enemy)) {
      var_885a3974 = distance(enemy.origin, asmstatename.origin);
    }

    players = getplayers();
    var_89cc0335 = function_72d3bca6(players, asmstatename.origin, undefined, 0, var_885a3974 + 1500);
    var_7bafb710 = [];
    var_1142e3f3 = 1;
    facing_vec = anglesToForward(asmstatename.angles);

    foreach(player in var_89cc0335) {
      if(isalive(player) && zombie_utility::is_player_valid(player, 1)) {
        if(!function_5020432f(asmstatename, player.origin, facing_vec)) {
          var_1142e3f3 = 0;
          break;
        }
      }
    }

    if(is_true(var_1142e3f3)) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x2d4>");
      }

      return 4;
    }
  }

  return 5;
}

function function_25b49d18(entity, asmstatename) {
  asmstatename.var_a8785ea7 = 0;

  function_68ca0622(asmstatename, 0, 5000);
  function_68ca0622(asmstatename, 1, 5000);
  asmstatename finishtraversal();
  asmstatename flag::clear(#"hash_1a23f4b19598f1b0");
  asmstatename flag::clear(#"hash_206c17809d21c1f8");
  return 4;
}

function private abom_head_impact(entity) {
  if(isDefined(entity.var_d86b94b3)) {
    entity.var_d86b94b3.normal = (entity.var_d86b94b3.normal[0], 0, entity.var_d86b94b3.normal[2]);

    if(lengthsquared(entity.var_d86b94b3.normal) <= 0) {
      entity.var_d86b94b3.normal = anglesToForward(entity.angles) * -1;
    }

    playFX(#"hash_1d65341e8671f3d", entity.var_d86b94b3.origin, entity.var_d86b94b3.normal);
    entity.var_d86b94b3 = undefined;
  }
}

function function_983f6134(entity) {
  if(distancesquared(entity.var_2976f01f, entity.origin) > sqr(100)) {
    return true;
  }

  if(!ispointonnavmesh(entity.origin, entity)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x30e>");
    }

    return true;
  }

  function_9de20709(entity, 0, 0);
  return false;
}

function function_d6971904(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  mocompduration animmode("gravity", 1);
  mocompduration orientmode("face angle", mocompduration.angles[1]);
}

function function_6f6a2167(entity) {
  return is_true(entity.var_2bd7ca9d);
}

function function_dd80b921(entity) {
  alive_players = function_a1ef346b(undefined, entity.origin, 700);

  if(isDefined(alive_players) && alive_players.size > 0) {
    foreach(player in alive_players) {
      player function_bc82f900(#"hash_69900e93e16813de");
    }
  }
}

function function_fc02984a(entity) {
  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(isDefined(enemy)) {
    var_de27dc69 = vectortoyaw(enemy.origin - entity.origin);
    angle_diff = math::angle_dif(int(var_de27dc69), int(entity.angles[1]));

    if(angle_diff > 160) {
      return true;
    }
  }

  return false;
}

function private function_3e6c0b74(entity) {
  entity thread flag::set_for_time(1.5, #"hash_1f9ad625c3185bf4");

  if(entity flag::get(#"hash_5c35337a4e15867")) {
    function_9de20709(entity, 0, 0);
  }
}

function function_998c02dd(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  var_4d93e3bf = 1;
  heads_alive = function_fc845eb6(entity);

  if(heads_alive <= 1) {
    var_4d93e3bf = 0;
  }

  entity.var_aa722082 = gettime() + int(var_4d93e3bf * 1000);
  return 5;
}

function function_39d052f1(entity, asmstatename) {
  if(isDefined(asmstatename.var_aa722082) && gettime() < asmstatename.var_aa722082) {
    return 5;
  }

  return 4;
}

function function_33bbae5c(entity, asmstatename) {
  function_68ca0622(asmstatename, 0, 10000);
  function_68ca0622(asmstatename, 1, 10000);
  return 4;
}

function function_48400b3b(entity) {
  if(!entity flag::get(#"hash_441651e111f0e04d")) {
    entity thread flag::set_for_time(5, #"hash_441651e111f0e04d");
  }
}

function private function_2fe507a5(entity, var_9a4357f2, radius = 48, var_3a5ecec1 = 0) {
  if(!isDefined(entity.var_d2b407f6)) {
    entity.var_d2b407f6 = gettime();
  }

  if(gettime() - entity.var_d2b407f6 < int(0.2 * 1000)) {
    return;
  }

  a_zombies = getentitiesinradius(var_9a4357f2, radius, 15);
  var_eb2cabb5 = array::filter(a_zombies, 0, &function_4a332962, entity);

  foreach(zombie in var_eb2cabb5) {
    zombie zombie_utility::setup_zombie_knockdown(entity.origin);
  }

  if(is_true(var_3a5ecec1)) {
    var_eb2cabb5 = array::filter(a_zombies, 0, &function_13ba4731, entity);

    foreach(zombie in var_eb2cabb5) {
      zombie thread flag::set_for_time(2, #"hash_222ae70a0dc4273a");

      if(isDefined(level.var_81c6aa5b)) {
        [[level.var_81c6aa5b]](entity, zombie);
      }
    }
  }
}

function private function_4a332962(zombie, target) {
  if(zombie.archetype !== # "zombie" || zombie.knockdown === 1 || gibserverutils::isgibbed(zombie, 384)) {
    return false;
  }

  origin = target.origin;
  facing_vec = anglesToForward(target.angles);
  enemy_vec = zombie.origin - origin;
  var_660d1fec = (enemy_vec[0], enemy_vec[1], 0);
  var_58877074 = (facing_vec[0], facing_vec[1], 0);
  var_660d1fec = vectornormalize(var_660d1fec);
  var_58877074 = vectornormalize(var_58877074);
  enemy_dot = vectordot(var_58877074, var_660d1fec);

  if(enemy_dot < 0) {
    return false;
  }

  return true;
}

function private function_13ba4731(zombie, target) {
  if(zombie.archetype === # "zombie" || zombie flag::get(#"hash_222ae70a0dc4273a") === 1) {
    return false;
  }

  origin = target.origin;
  facing_vec = anglesToForward(target.angles);
  enemy_vec = zombie.origin - origin;
  var_660d1fec = (enemy_vec[0], enemy_vec[1], 0);
  var_58877074 = (facing_vec[0], facing_vec[1], 0);
  var_660d1fec = vectornormalize(var_660d1fec);
  var_58877074 = vectornormalize(var_58877074);
  enemy_dot = vectordot(var_58877074, var_660d1fec);

  if(enemy_dot < 0.5) {
    return false;
  }

  return true;
}

function private function_849b329(entity, var_9a4357f2) {
  players = getplayers();
  var_9ce867db = 1.6;
  var_89cc0335 = function_72d3bca6(players, var_9a4357f2, undefined, 0, 40 * var_9ce867db);

  if(isDefined(var_89cc0335) && var_89cc0335.size > 0) {
    var_9ce867db *= 2;
    var_89cc0335 = function_72d3bca6(players, var_9a4357f2, undefined, 0, 40 * var_9ce867db);
  }

  if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
    recordcircle(var_9a4357f2, 40 * var_9ce867db, (0.75, 0.75, 0.75));
  }

  var_26548e5f = 0;
  var_7bafb710 = [];

  foreach(player in var_89cc0335) {
    if(isalive(player)) {
      if(!player flag::get(#"hash_5047ba8da693e1c5")) {
        player thread flag::set_for_time(2, #"hash_5047ba8da693e1c5");
        var_7bafb710[var_7bafb710.size] = player;

        if(is_true(level.var_bb61089c)) {
          println("<dev string:x38>" + "<dev string:x351>" + player getentitynumber() + "<dev string:x1f1>");
        }

        function_a768119c(entity, player, var_9a4357f2);
        continue;
      }

      var_26548e5f = 1;
    }
  }

  return var_26548e5f;
}

function private function_a768119c(entity, player, hit_point) {
  if(!(isDefined(entity) && isDefined(player))) {
    return;
  }

  player playerknockback(1);
  knock_dir = vectornormalize(player.origin - hit_point);
  knock_dir = (knock_dir[0], knock_dir[1], 0.1);
  player applyknockback(int(100), knock_dir);
  player playerknockback(0);
  player function_bc82f900(#"hash_157e567055fd73f7");
  damage = 75;
  damage_scalar = 1;

  if(isDefined(level.var_a2ed0864)) {
    round_number = [[level.var_a2ed0864]]();

    if(round_number > 20) {
      damage_scalar = 1 + (min(round_number, 40) - 20) / 40;
    }
  }

  damage *= damage_scalar;
  player dodamage(int(damage), hit_point, entity, entity, "torso_upper", "MOD_IMPACT");
  player notify(#"hash_45f594b911699a4b");
  player thread function_bda6d3d7(entity, player);
}

function private function_bda6d3d7(entity, player) {
  player endon(#"death", #"hash_45f594b911699a4b");
  player clientfield::set_to_player("abomBullChargeHitPlayerCF", 1);
  wait_time = float(1000) / 1000;
  self shellshock(#"hash_5047ba8da693e1c5", wait_time);
  wait wait_time;

  if(isDefined(player)) {
    player clientfield::set_to_player("abomBullChargeHitPlayerCF", 0);
  }
}

function private function_e3ae0cb7(entity, var_9a4357f2) {
  vehicles = getvehiclearray();
  var_9ce867db = 6;
  var_1378ec51 = function_72d3bca6(vehicles, var_9a4357f2, undefined, 0, 40 * var_9ce867db);
  var_9ce867db = 2;
  var_b208e4a6 = [];

  foreach(vehicle in var_1378ec51) {
    if(!isDefined(vehicle)) {
      continue;
    }

    var_7215755b = math::function_fe4f9da3(var_9a4357f2, vehicle getboundsmidpoint() + vehicle.origin, vehicle getboundshalfsize(), vehicle.angles);
    dist_sq = distancesquared(var_7215755b, var_9a4357f2);

    if(dist_sq < sqr(40 * var_9ce867db)) {
      var_b208e4a6[var_b208e4a6.size] = vehicle;
    }
  }

  foreach(vehicle in var_b208e4a6) {
    if(isDefined(vehicle)) {
      if(!vehicle flag::get(#"hash_5047ba8da693e1c5")) {
        vehicle thread flag::set_for_time(2, #"hash_5047ba8da693e1c5");

        if(is_true(level.var_bb61089c)) {
          println("<dev string:x38>" + "<dev string:x36e>" + vehicle getentitynumber() + "<dev string:x1f1>");
        }

        function_6ccdd373(entity, vehicle, var_9a4357f2);
      }
    }
  }
}

function private function_6ccdd373(entity, vehicle, hit_point) {
  if(!(isDefined(entity) && isDefined(vehicle))) {
    return;
  }

  knock_dir = vectornormalize(vehicle.origin - hit_point);
  knock_dir = (knock_dir[0], knock_dir[1], 0.1);
  vehicle launchvehicle(knock_dir * 100, hit_point, 0);
  var_54fdcc2b = vehicle getvehoccupants();

  foreach(occupant in var_54fdcc2b) {
    occupant function_bc82f900(#"hash_157e567055fd73f7");
  }

  damage = max(200, (isDefined(vehicle.maxhealth) ? vehicle.maxhealth : 0) * 0.2);
  vehicle dodamage(int(damage), hit_point, entity, entity, undefined, "MOD_IMPACT");
}

function function_e75778ab(entity) {
  if(is_true(entity.var_c44e9122)) {
    return true;
  }

  if(isDefined(level.var_87bca031)) {
    var_b498174 = [[level.var_87bca031]](entity);

    if(!var_b498174) {
      return false;
    }

    enemy = undefined;

    if(isDefined(level.var_f67b08f5)) {
      enemy = [[level.var_f67b08f5]](entity);
    }

    if(isDefined(enemy)) {
      var_a889803d = distance2dsquared(enemy.origin, entity.origin);

      if(var_a889803d > sqr(100)) {
        hit_nothing = bullettracepassed(entity getcentroid(), enemy getcentroid(), 0, entity);

        if(!hit_nothing) {
          return false;
        }
      }
    }

    return true;
  }

  return false;
}

function function_cc49b438(entity) {
  if(!function_b31e6110(entity, 6)) {
    return false;
  }

  if(!entity flag::get(#"hash_5c35337a4e15867")) {
    return false;
  }

  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(isDefined(enemy)) {
    var_a889803d = distance2dsquared(enemy.origin, entity.origin);
    var_ab811a0d = sqr(200);

    if(var_a889803d > var_ab811a0d) {
      return false;
    }

    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(enemy.origin - entity.origin)[1]);

    if(abs(yawtoenemy) > 5) {
      return false;
    }

    if(!entity cansee(enemy)) {
      return false;
    }

    return true;
  }

  return false;
}

function function_bbc03cca(entity) {
  function_9de20709(entity, 6, int(5 * 1000));
}

function function_fcb91a0d(entity) {
  if(is_true(entity.var_d7cf94a0)) {
    return true;
  }

  if(isDefined(level.var_87bca031)) {
    entity flag::set(#"hash_49b119b42f4610ea");
    can_melee = [[level.var_87bca031]](entity);
    entity flag::clear(#"hash_49b119b42f4610ea");

    if(is_false(can_melee)) {
      return false;
    }

    enemy = undefined;

    if(isDefined(level.var_f67b08f5)) {
      enemy = [[level.var_f67b08f5]](entity);
    }

    if(isDefined(enemy)) {
      var_a889803d = distance2dsquared(enemy.origin, entity.origin);

      if(var_a889803d > sqr(100)) {
        hit_nothing = bullettracepassed(entity getcentroid(), enemy getcentroid(), 0, entity);

        if(!hit_nothing) {
          return false;
        }
      }
    }
  }

  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(!isDefined(enemy) || !function_5020432f(entity, enemy.origin)) {
    return false;
  }

  if(!function_b31e6110(entity, 3)) {
    return false;
  }

  return true;
}

function function_b3bc50af(entity) {
  entity flag::set(#"hash_33e36dd4c60798b4");
}

function function_cbeafd0f(entity) {
  entity flag::clear(#"hash_33e36dd4c60798b4");
  entity flag::clear(#"hash_49b119b42f4610ea");
  function_9de20709(entity, 3, int(3 * 1000));
}

function function_f8efbadd(entity) {
  entity flag::set(#"hash_6e15049502d1637a");
}

function function_9d242adf(entity) {
  entity flag::clear(#"hash_6e15049502d1637a");
  var_b6949a60 = isDefined(entity.var_dd3458a6) ? entity.var_dd3458a6 : 0;
  var_78138687 = isDefined(self.var_d3c01fba) ? self.var_d3c01fba : 0;
  var_6e9c6b0d = gettime() - var_b6949a60 < 3000;
  var_b5d3943d = gettime() - var_78138687 < 3000;
  entity.var_dd3458a6 = gettime();

  if(var_6e9c6b0d && !var_b5d3943d) {
    entity flag::set(#"hash_547d56829c19d20f");
    function_261709aa(entity, 0, int(2 * 1000));
  } else {
    entity flag::clear(#"hash_547d56829c19d20f");
  }

  entity finishtraversal();
}

function function_e18a6f50(entity) {
  entity flag::set(#"hash_348b902672a3736e");
}

function function_faf3547e(entity) {
  entity flag::clear(#"hash_348b902672a3736e");
  entity thread flag::set_for_time(2, #"hash_425c5de27320d7f6");
}

function private function_3a175c82(entity) {
  var_c0519bcf = 850;
  var_b6949a60 = isDefined(entity.var_dd3458a6) ? entity.var_dd3458a6 : 0;

  if(!entity flag::get(#"hash_547d56829c19d20f") && gettime() - var_b6949a60 < 3000) {
    return var_c0519bcf;
  }

  return int(-1);
}

function function_a86617d() {
  melee_range = self.meleeweapon.aimeleerange;
  melee_damage = 50;

  if(self flag::get(#"hash_348b902672a3736e")) {
    melee_range *= 1.3;
  }

  var_9051190 = [];
  nearby_players = function_a1ef346b(undefined, self.origin, melee_range);
  var_60c8f87a = [];

  foreach(player in nearby_players) {
    if(isDefined(self.var_f6fd2062) && ![[self.var_f6fd2062]](player)) {
      if(!is_true(player.var_b895a3ff)) {
        continue;
      }
    }

    if(!isalive(player)) {
      continue;
    }

    if(flag::get(#"hash_33e36dd4c60798b4")) {
      function_240a4635(player, melee_damage, -180, -90, &var_9051190, 0);
      function_240a4635(player, melee_damage, 90, 180, &var_9051190, 0);
      continue;
    }

    for(head_index = 0; head_index < 3; head_index++) {
      if(!function_17ae1df1(self, head_index) && head_index !== 1) {
        continue;
      }

      var_e3e6e7 = 22.5 * -1 + (head_index - 1) * 45;
      max_yaw = 22.5 + (head_index - 1) * 45;
      var_574fd932 = function_240a4635(player, melee_damage, var_e3e6e7, max_yaw, &var_9051190);

      if(var_574fd932) {
        if(!function_17ae1df1(self, head_index)) {
          if(function_17ae1df1(self, 0)) {
            if(!isDefined(var_60c8f87a)) {
              var_60c8f87a = [];
            } else if(!isarray(var_60c8f87a)) {
              var_60c8f87a = array(var_60c8f87a);
            }

            if(!isinarray(var_60c8f87a, 0)) {
              var_60c8f87a[var_60c8f87a.size] = 0;
            }
          }

          if(function_17ae1df1(self, 2)) {
            if(!isDefined(var_60c8f87a)) {
              var_60c8f87a = [];
            } else if(!isarray(var_60c8f87a)) {
              var_60c8f87a = array(var_60c8f87a);
            }

            if(!isinarray(var_60c8f87a, 2)) {
              var_60c8f87a[var_60c8f87a.size] = 2;
            }
          }

          continue;
        }

        if(!isDefined(var_60c8f87a)) {
          var_60c8f87a = [];
        } else if(!isarray(var_60c8f87a)) {
          var_60c8f87a = array(var_60c8f87a);
        }

        if(!isinarray(var_60c8f87a, head_index)) {
          var_60c8f87a[var_60c8f87a.size] = head_index;
        }
      }
    }
  }

  for(var_bb8837d1 = 0; var_bb8837d1 < var_60c8f87a.size; var_bb8837d1++) {
    var_e4ee29ae = var_60c8f87a[var_bb8837d1];
    playFXOnTag(#"hash_792489c5ae9dfe3c", self, self.var_ef651d05[var_e4ee29ae]);
  }

  var_1ff1751 = 1.2;
  var_15978c43 = getentitiesinradius(self.origin, melee_range * var_1ff1751, 12);

  foreach(vehicle in var_15978c43) {
    if(isinarray(var_9051190, vehicle)) {
      continue;
    }

    if(flag::get(#"hash_33e36dd4c60798b4")) {
      function_640114ff(vehicle, melee_damage, -180, -90, &var_9051190);
      function_640114ff(vehicle, melee_damage, 90, 180, &var_9051190);
      continue;
    }

    for(head_index = 0; head_index < 3; head_index++) {
      if(!function_17ae1df1(self, head_index)) {
        continue;
      }

      var_e3e6e7 = 22.5 * -1 + (head_index - 1) * 45;
      max_yaw = 22.5 + (head_index - 1) * 45;
      function_640114ff(vehicle, melee_damage, var_e3e6e7, max_yaw, &var_9051190);
    }
  }

  attackables = [];

  if(isDefined(level.attackables) && level.attackables.size > 0) {
    attackables = arraysortclosest(level.attackables, self.origin, undefined, undefined, melee_range);
  }

  foreach(attackable in attackables) {
    if(isinarray(var_9051190, attackable)) {
      continue;
    }

    attackable dodamage(melee_damage * 0.5, self.origin, self, self, 0, "MOD_MELEE", 0, self.weapon);
  }

  if(getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
    for(head_index = 2; head_index >= 0; head_index--) {
      if(!function_17ae1df1(self, head_index)) {
        continue;
      }

      var_e3e6e7 = 22.5 * -1 + (head_index - 1) * 45;
      max_yaw = 22.5 + (head_index - 1) * 45;
      recordcircle(self.origin, melee_range, (1, 0, 0));
      recordline(self.origin, self.origin + anglesToForward((0, self.angles[1] + var_e3e6e7, 0)) * melee_range, (1, 0.5, 0));
      recordline(self.origin, self.origin + anglesToForward((0, self.angles[1] + max_yaw, 0)) * melee_range, (1, 0.5, 0));
      recordline(self.origin + anglesToForward((0, self.angles[1] + var_e3e6e7, 0)) * melee_range, self.origin + anglesToForward((0, self.angles[1] + max_yaw, 0)) * melee_range, (1, 0.5, 0));
    }
  }

}

function private function_240a4635(player, melee_damage, var_e3e6e7, max_yaw, var_9051190, b_play_fx) {
  b_damaged = 0;
  var_592c1baa = angleclamp180(self.angles[1] - vectortoangles(melee_damage.origin - self.origin)[1]);

  if(var_592c1baa >= max_yaw && var_592c1baa <= var_9051190) {
    if(melee_damage isinvehicle()) {
      vehicle = melee_damage getvehicleoccupied();

      if(!isinarray(b_play_fx, vehicle)) {
        if(isDefined(level.var_34a02ce7)) {
          [[level.var_34a02ce7]](vehicle, self.var_a0193213);
        }

        if(!isDefined(b_play_fx)) {
          b_play_fx = [];
        } else if(!isarray(b_play_fx)) {
          b_play_fx = array(b_play_fx);
        }

        b_play_fx[b_play_fx.size] = vehicle;
      }

      if(!is_true(vehicle.var_9a6644f2)) {
        b_damaged = 1;
      }
    } else {
      b_damaged = 1;
    }
  }

  if(b_damaged) {
    melee_damage dodamage(var_e3e6e7, self.origin, self, self, 0, "MOD_MELEE", 0, self.weapon);
    melee_damage clientfield::increment("abomBiteHitPlayerCF", 1);
  }

  return b_damaged;
}

function private function_640114ff(vehicle, melee_damage, var_e3e6e7, max_yaw, var_9051190) {
  var_348afc81 = angleclamp180(self.angles[1] - vectortoangles(melee_damage.origin - self.origin)[1]);

  if(var_348afc81 >= var_e3e6e7 && var_348afc81 <= max_yaw) {
    if(isDefined(level.var_34a02ce7)) {
      [[level.var_34a02ce7]](melee_damage, self.var_a0193213);
    }

    if(!isDefined(var_9051190)) {
      var_9051190 = [];
    } else if(!isarray(var_9051190)) {
      var_9051190 = array(var_9051190);
    }

    var_9051190[var_9051190.size] = melee_damage;
  }
}

function function_3160120e(entity) {
  if(is_true(entity.var_f5ffa31e)) {
    return true;
  }

  if(!function_b31e6110(entity, 2)) {
    return false;
  }

  if(!entity flag::get(#"hash_441651e111f0e04d")) {
    return false;
  }

  move_speed = entity getblackboardattribute("_locomotion_speed");

  if(move_speed === "locomotion_speed_sprint") {
    var_d40fc7e0 = entity function_be51bf77();

    if(var_d40fc7e0 > 15 && var_d40fc7e0 < 345) {
      return false;
    }
  }

  return true;
}

function function_3a6d62a1(entity) {
  heads_alive = function_fc845eb6(entity);
  var_c6c7ab63 = 3 - heads_alive;

  if(heads_alive <= 0) {
    return;
  }

  if(!isDefined(entity.var_5c8fc94e)) {
    entity.var_5c8fc94e = -1;
  }

  var_e8bbc3b4 = entity.var_5c8fc94e >= 0;

  if(var_e8bbc3b4) {
    if(!isDefined(entity.var_2d502a2b)) {
      entity.var_2d502a2b = 0;
    }

    var_511099f7 = gettime() - entity.var_2d502a2b;
    var_eeb76b76 = [3, 5, 4];
    var_c1607f0f = int(var_eeb76b76[var_c6c7ab63] * 1000);

    if(var_511099f7 > var_c1607f0f) {
      function_14605606(entity);
      var_21b140fe = [1, 1, 8];
      var_8d0f7b0c = int(var_21b140fe[var_c6c7ab63] * 1000);

      if(entity flag::get(#"hash_204aaf6e250ebdbc")) {
        var_8d0f7b0c *= 0.5;
      }

      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x38c>" + float(var_c1607f0f) / 1000 + "<dev string:x3b0>" + float(var_8d0f7b0c) / 1000);
      }

      function_9de20709(entity, 4, var_8d0f7b0c);
    }

    return;
  }

  if(function_b31e6110(entity, 4) && entity flag::get(#"hash_42f4206825b6195")) {
    var_6a230f24 = [];

    if(function_17ae1df1(entity, 0)) {
      if(!isDefined(var_6a230f24)) {
        var_6a230f24 = [];
      } else if(!isarray(var_6a230f24)) {
        var_6a230f24 = array(var_6a230f24);
      }

      var_6a230f24[var_6a230f24.size] = 0;
    }

    if(function_17ae1df1(entity, 1)) {
      if(!isDefined(var_6a230f24)) {
        var_6a230f24 = [];
      } else if(!isarray(var_6a230f24)) {
        var_6a230f24 = array(var_6a230f24);
      }

      var_6a230f24[var_6a230f24.size] = 1;
    }

    if(function_17ae1df1(entity, 2)) {
      if(!isDefined(var_6a230f24)) {
        var_6a230f24 = [];
      } else if(!isarray(var_6a230f24)) {
        var_6a230f24 = array(var_6a230f24);
      }

      var_6a230f24[var_6a230f24.size] = 2;
    }

    if(var_6a230f24.size > 0) {
      var_d5f97318 = randomint(var_6a230f24.size);
      function_6bafca91(entity, var_6a230f24[var_d5f97318]);
    }
  }
}

function private function_14605606(entity) {
  head_index = isDefined(entity.var_5c8fc94e) ? entity.var_5c8fc94e : -1;

  if(head_index >= 0) {
    function_2c3c388d(entity, head_index);

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x3c8>" + head_index + "<dev string:x3d8>");
    }
  }

  entity.var_5c8fc94e = -1;
}

function private function_6bafca91(entity, head_index) {
  if(!function_17ae1df1(entity, head_index)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x3dd>" + head_index);
    }

    return;
  }

  entity.var_5c8fc94e = head_index;
  entity.var_2d502a2b = gettime();

  if(head_index >= 0) {
    function_efb1766(entity, head_index);

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x41a>" + head_index + "<dev string:x3d8>");
    }
  }
}

function function_c0e34ca8(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  var_a1346113 = 2000;
  heads_alive = function_fc845eb6(entity);
  var_a1346113 *= 1 + heads_alive / 6;

  if(flag::get(#"hash_1c464f9df131fb78")) {
    var_a1346113 = 1500;
  }

  entity.var_f58807b8 = gettime() + var_a1346113;
  entity clientfield::set("abomRoarCF", 1);
  function_2fe507a5(entity, entity.origin, 200);
  function_e119344f(entity);
  return 5;
}

function function_640570ec(behaviortreeentity, asmstatename) {
  if(gettime() < asmstatename.var_f58807b8) {
    return 5;
  }

  return 4;
}

function function_bcf8dd2a(entity, asmstatename) {
  function_48f2cd39(asmstatename);
  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](asmstatename);
  }

  if(isDefined(enemy)) {
    var_7befcf25 = distancesquared(asmstatename.origin, enemy.origin);

    if(var_7befcf25 < sqr(600)) {
      function_68ca0622(asmstatename, 0, int(10 * 1000));
    } else {
      function_ef9e3f0(asmstatename, 0, 0);
    }
  }

  function_9de20709(asmstatename, 2, int(10 * 1000));
  asmstatename clientfield::set("abomRoarCF", 0);
  return 4;
}

function private function_edcb107c(entity) {
  function_e119344f(entity);
}

function private function_6791808c(entity) {
  function_48f2cd39(entity);
}

function function_e119344f(entity) {
  if(entity flag::get(#"hash_762cffc9e7a61f9c")) {
    return;
  }

  entity flag::set(#"hash_762cffc9e7a61f9c");

  for(head_index = 0; head_index < 3; head_index++) {
    function_efb1766(entity, head_index);
  }
}

function function_efb1766(entity, head_index) {
  if(is_true(entity.var_dc06e6af[head_index])) {
    return;
  }

  var_84ed9a13 = entity.var_5ace757d[head_index];

  if(var_84ed9a13.currstate !== 1) {
    return;
  }

  if(!isDefined(var_84ed9a13.var_8b732142)) {
    return;
  }

  if(!function_17ae1df1(entity, head_index)) {
    return;
  }

  if(!isDefined(var_84ed9a13.hitradius)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x429>");
    }

    var_84ed9a13.hitradius = 0;
  }

  var_84ed9a13.var_2c5a8a86 = var_84ed9a13.hitradius;
  var_84ed9a13.hitradius = 20;
  entity.var_dc06e6af[head_index] = 1;

  if(head_index < 3) {
    entity clientfield::set(entity.var_ac8b8c0f[head_index], 1);
  }

  if(is_true(level.var_bb61089c)) {
    println("<dev string:x38>" + "<dev string:x47b>" + head_index + "<dev string:x48a>" + var_84ed9a13.hitradius);
  }
}

function function_48f2cd39(entity) {
  if(!entity flag::get(#"hash_762cffc9e7a61f9c")) {
    return;
  }

  entity flag::clear(#"hash_762cffc9e7a61f9c");

  for(head_index = 0; head_index < 3; head_index++) {
    function_2c3c388d(entity, head_index);
  }
}

function function_2c3c388d(entity, head_index) {
  if(is_false(entity.var_dc06e6af[head_index])) {
    return;
  }

  var_84ed9a13 = entity.var_5ace757d[head_index];

  if(var_84ed9a13.currstate !== 1) {
    return;
  }

  if(!isDefined(var_84ed9a13.var_8b732142)) {
    return;
  }

  if(!isDefined(var_84ed9a13.hitradius)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x4a7>");
    }

    var_84ed9a13.hitradius = 0;
  }

  var_6ee1527f = var_84ed9a13.var_2c5a8a86;

  if(!isDefined(var_84ed9a13.var_2c5a8a86)) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x4fa>");
    }

    return;
  }

  var_84ed9a13.hitradius = var_84ed9a13.var_2c5a8a86;
  entity.var_dc06e6af[head_index] = 0;

  if(head_index < 3) {
    entity clientfield::set(entity.var_ac8b8c0f[head_index], 0);
  }

  if(is_true(level.var_bb61089c)) {
    println("<dev string:x38>" + "<dev string:x47b>" + head_index + "<dev string:x545>" + var_84ed9a13.hitradius);
  }
}

function function_1c713d40(entity, head_index = undefined) {
  if(!isDefined(head_index)) {
    return (function_1c713d40(entity, 0) || function_1c713d40(entity, 1) || function_1c713d40(entity, 2));
  }

  return is_true(entity.var_dc06e6af[head_index]);
}

function function_4be4b4a6(entity) {
  return entity flag::get(#"hash_762cffc9e7a61f9c");
}

function private function_e7cfd92(entity) {
  if(function_e75778ab(entity) || function_3160120e(entity)) {
    return;
  }

  if(!isDefined(entity.var_ee2440ac)) {
    return;
  }

  if(is_true(entity.var_e76a75b4)) {
    forward_vec = anglesToForward(entity gettagangles("j_head"));
    forward_vec = (forward_vec[0], forward_vec[1], 0);
    entity.var_ee2440ac dontinterpolate();
    entity.var_ee2440ac.origin = entity gettagorigin("j_head") + forward_vec * 1000;

    if(!entity flag::get(#"hash_67c62575285677e4")) {
      entity flag::set(#"hash_5a61b819c92c0059");

      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x562>");
      }

      entity thread function_4ac5ff55(entity);
    }

    return;
  }

  if(entity flag::get(#"hash_5a61b819c92c0059")) {
    if(flag::get(#"hash_67c62575285677e4")) {
      entity flag::clear(#"hash_5a61b819c92c0059");

      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x580>");
      }

      entity thread function_8a959784(entity);
    }
  }
}

function function_4ac5ff55(entity) {
  entity endon(#"death");
  entity.var_ee2440ac clientfield::set("abomLaunchBeamCF", 1);

  for(head_index = 0; head_index < 3; head_index++) {
    function_57773958(entity, head_index);
    [[level.var_5ef577c5]] - > waitinqueue(entity);
  }

  if(entity flag::get(#"hash_67c62575285677e4")) {
    entity thread function_e1a54e93(entity);
    entity playSound(#"hash_38c5886415893c76");
    entity playLoopSound(#"hash_522f564c50daffff");
  }
}

function private function_57773958(entity, head_index) {
  if(function_17ae1df1(entity, head_index)) {
    entity.var_42bc30c[head_index] = 1;

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x59d>" + entity getentitynumber() + "<dev string:x5a6>" + head_index);
    }

    function_29abbe4c(entity);
  }
}

function function_8a959784(entity) {
  entity stoploopsound(0.2);

  if(isDefined(entity.var_ee2440ac)) {
    entity.var_ee2440ac clientfield::set("abomLaunchBeamCF", 0);
  }

  for(head_index = 0; head_index < 3; head_index++) {
    function_8d085377(entity, head_index);
    waitframe(1);
  }
}

function private function_8d085377(entity, head_index) {
  if(is_true(level.var_bb61089c)) {
    println("<dev string:x38>" + "<dev string:x59d>" + entity getentitynumber() + "<dev string:x5c5>" + head_index + "<dev string:x5e3>" + function_17ae1df1(entity, head_index) + "<dev string:x5f6>" + is_true(entity.var_42bc30c[head_index]));
  }

  if(function_17ae1df1(entity, head_index) && is_true(entity.var_42bc30c[head_index])) {
    entity.var_42bc30c[head_index] = 0;

    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x59d>" + entity getentitynumber() + "<dev string:x60a>" + head_index);
    }

    function_29abbe4c(entity);
  }
}

function private function_29abbe4c(entity) {
  var_c81f5b16 = 1;

  foreach(var_2e255462 in entity.var_42bc30c) {
    if(is_true(var_2e255462)) {
      var_c81f5b16 = 0;
    }
  }

  if(!var_c81f5b16 !== flag::get(#"hash_67c62575285677e4")) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x627>" + !var_c81f5b16);
    }
  }

  flag::set_val(#"hash_67c62575285677e4", !var_c81f5b16);
}

function private function_e1a54e93(entity) {
  entity endon(#"death");

  while(true) {
    if(!flag::get(#"hash_67c62575285677e4")) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x645>");
      }

      return;
    }

    var_bff560a3 = 1;

    for(head_index = 0; head_index < 3; head_index++) {
      if(function_17ae1df1(entity, head_index)) {
        var_bff560a3 = 0;
        start_pos = entity gettagorigin(entity.var_7baf0b4d[head_index]);
        end_pos = entity.var_ee2440ac gettagorigin("tag_origin");
        trace = beamtrace(start_pos, end_pos, 1, entity);
        hit_ent = undefined;
        hit_vehicle = undefined;

        if(isDefined(trace)) {
          hit_ent = trace[#"entity"];
        }

        if(!isDefined(hit_ent) && isDefined(trace[#"position"]) && is_true(self.var_1fa24724)) {
          var_89cc0335 = getplayers(undefined, trace[#"position"], 150);

          if(isDefined(var_89cc0335[0])) {
            hit_ent = var_89cc0335[0];
          }
        }

        if(isPlayer(hit_ent)) {
          vehicle = hit_ent getvehicleoccupied();

          if(isDefined(vehicle)) {
            hit_vehicle = vehicle;

            if(is_true(vehicle.var_9a6644f2)) {
              hit_ent = undefined;
            }
          }
        }

        if(isDefined(hit_ent)) {
          if(isPlayer(hit_ent)) {
            var_b5caed86 = 0;
            var_b7968902 = hit_ent getgroundent();

            if(!isDefined(var_b7968902)) {
              player_eye_pos = hit_ent getEye();
              var_adedf780 = 15;

              if(abs(trace[#"position"][2] - player_eye_pos[2]) > var_adedf780) {
                var_b5caed86 = 1;

                if(is_true(level.var_bb61089c)) {
                  println("<dev string:x38>" + "<dev string:x675>" + abs(trace[#"position"][2] - player_eye_pos[2]));
                }
              }
            }

            if(!var_b5caed86) {
              if(is_true(level.var_bb61089c)) {
                println("<dev string:x38>" + "<dev string:x690>" + hit_ent getentitynumber());
              }

              entity.var_54529e1e = gettime();
              var_8104fad = 8;

              if(!isDefined(hit_ent.var_e12bf6a3) || gettime() > hit_ent.var_e12bf6a3 + int(3 * 1000)) {
                var_8104fad = 15;
              }

              damage_scalar = 1;

              if(isDefined(level.var_a2ed0864)) {
                round_number = [[level.var_a2ed0864]]();

                if(round_number > 20) {
                  damage_scalar = 1 + (min(round_number, 40) - 20) / 40;
                }
              }

              if(isDefined(hit_ent.health) && isDefined(hit_ent.maxhealth) && !is_true(self.var_c588eb)) {
                if(hit_ent.health < hit_ent.maxhealth * 0.5) {
                  damage_scalar *= hit_ent.health / hit_ent.maxhealth;
                }
              }

              var_8104fad *= damage_scalar;
              var_8104fad = max(var_8104fad, 3);
              hit_ent dodamage(var_8104fad, trace[#"position"], entity, entity, undefined, "MOD_ELECTROCUTED");
              hit_ent.var_e12bf6a3 = gettime();
            }
          } else if(hit_ent.zm_ai_category === # "normal") {
            hit_ent.allowdeath = 1;
            hit_ent dodamage(hit_ent.health, hit_ent.origin, entity, entity, undefined, "MOD_ELECTROCUTED");
            var_ab2fdbbc = gettime() + int(2 * 1000);
            entity.var_16109727 = max(var_ab2fdbbc, entity.var_16109727);
          } else if(hit_ent.zm_ai_category === # "elite" || hit_ent.zm_ai_category === # "special") {
            hit_ent ai::stun(1);
          }

          hit_ent = isDefined(hit_vehicle) ? hit_vehicle : hit_ent;

          if(isvehicle(hit_ent)) {
            if(is_true(level.var_bb61089c)) {
              println("<dev string:x38>" + "<dev string:x6a5>" + hit_ent getentitynumber());
            }

            var_32231de8 = hit_ent getvehoccupants().size > 0;

            if(var_32231de8) {
              entity.var_54529e1e = gettime();
            }

            var_6718e7a0 = 50;
            hit_ent dodamage(var_6718e7a0, trace[#"position"], entity, entity, undefined, "MOD_PROJECTILE");
            hit_ent.var_e12bf6a3 = gettime();
          } else if(isinarray(level.attackables, hit_ent)) {
            var_505e8a5c = 25;
            hit_ent dodamage(var_505e8a5c, trace[#"position"], entity, entity, undefined, "MOD_PROJECTILE");
            hit_ent.var_e12bf6a3 = gettime();
          }
        }

        if(isDefined(trace[#"position"])) {
          target_pos = trace[#"position"];
          var_7ee5d97a = 85;
          height_check = abs(target_pos[2] - start_pos[2]) + var_7ee5d97a;
          var_577fefe8 = distance(start_pos, target_pos) * 1.5;
          var_e86a4d9 = function_c3d68575(start_pos, (var_577fefe8, var_577fefe8, height_check));
          var_21bdf069 = sqr(var_577fefe8);

          foreach(dynent in var_e86a4d9) {
            closest_point = math::closest_point_on_line(dynent.origin, start_pos, target_pos);

            if(distancesquared(dynent.origin, closest_point) > sqr(var_7ee5d97a)) {
              continue;
            }

            dynent notify(#"hash_642d0d9004ae3789");

            if(isDefined(level.var_6d2016b8) && ![[level.var_6d2016b8]](dynent, 1)) {
              continue;
            }

            should_break = 0;

            if(isDefined(level.var_9fbe660b)) {
              should_break = [[level.var_9fbe660b]](dynent);
            }

            if(should_break && dynent.health > 0) {
              dynent dodamage(dynent.health, start_pos, self, self, undefined, "MOD_ELECTROCUTED");
            }
          }
        }
      }
    }

    if(var_bff560a3) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x6bb>");
      }

      return;
    }

    var_e9f9d662 = 0.2;
    wait var_e9f9d662;
  }
}

function function_5a2447b1(time) {
  result = self waittilltimeout(time, #"actor_corpse", #"death");
  waittillframeend();

  if(isDefined(result.corpse)) {
    result.corpse deletedelay();
    return;
  }

  if(isDefined(self)) {
    self deletedelay();
  }
}

function function_ac1ff86e() {
  if(!isDefined(level.var_1a4cc228[self.aitype])) {
    return false;
  }

  self function_f9b43587();
  entitynum = self getentitynumber();
  var_6f4262ed = level.var_1a4cc228[self.aitype];
  self setModel(var_6f4262ed[entitynum % var_6f4262ed.size]);

  if(isDefined(self.gib_state)) {
    gibserverutils::function_96bedd91(self);
  }

  return true;
}

function private function_18fd18de(entity) {
  entity endon(#"death");

  if(isDefined(entity.var_ee2440ac)) {
    return;
  }

  ent = util::spawn_model("tag_origin", entity.origin, (0, 0, 0), undefined, 1);
  ent linkto(entity);
  entity.var_ee2440ac = ent;
  util::wait_network_frame(1);

  if(isDefined(ent)) {
    ent clientfield::set("abomRegisterBeamTargetCF", 1);
  }

  util::wait_network_frame(1);

  if(isDefined(ent)) {
    ent unlink();
  }
}

function function_acb229fd(entity) {
  if(is_true(entity.var_308a238a)) {
    return true;
  }

  if(getdvarint(#"hash_1d29ba18cfbb1bbb", 0) > 0) {
    return false;
  }

  var_e792a112 = function_fc845eb6(entity);

  if(var_e792a112 === 0) {
    return false;
  }

  if(entity flag::get(#"turning")) {
    return false;
  }

  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(!isDefined(enemy) || isPlayer(enemy) && !zombie_utility::is_player_valid(enemy, 1)) {
    return false;
  }

  var_b51839b1 = 0;

  if(!entity cansee(enemy)) {
    if(isPlayer(enemy) && enemy isinvehicle()) {
      vehicle = enemy getvehicleoccupied();
      var_b51839b1 = entity cansee(vehicle);
    }

    if(!var_b51839b1) {
      return false;
    }
  }

  dist_sq = distancesquared(entity.origin, enemy.origin);

  if(dist_sq > sqr((util::get_game_type() == # "zsurvival" ? 1300 : 900) - 100) || dist_sq < sqr(300) && !is_true(entity.var_1fa24724)) {
    return false;
  }

  if(dist_sq > sqr((util::get_game_type() == # "zsurvival" ? 1300 : 900) - 100 - 200)) {
    function_4d4efd70(entity, 1, int(5 * 1000));
  }

  if(!function_b31e6110(entity, 1)) {
    return false;
  }

  trace_z_offset = (0, 0, 50);
  hit_nothing = bullettracepassed(entity.origin + trace_z_offset, enemy.origin + trace_z_offset, 0, enemy, entity);

  if(!hit_nothing && !var_b51839b1) {
    return false;
  }

  return true;
}

function function_fe8e1e36(entity) {
  variant = function_fc845eb6(entity) - 1;

  if(function_1f33b20c(entity)) {
    variant = 0;
  }

  entity.variant_type = variant;
}

function function_150b8b34(entity) {
  if(entity.variant_type === 0) {
    entity function_d7033ff(6);
  }
}

function function_6b70d881(entity) {
  entity function_d7033ff(function_2fee0cc6(entity));
}

function function_59685ed1(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  var_e792a112 = function_fc845eb6(entity);

  if(var_e792a112 === 0) {
    return 5;
  }

  if(entity flag::get(#"hash_78790bd238b6fdc2")) {
    return 5;
  }

  var_72e6d5f = entity.var_a8bb18af[var_e792a112 - 1];
  assert(isDefined(var_72e6d5f), "<dev string:x6e3>");
  entity.var_16109727 = gettime() + int(var_72e6d5f * 1000);
  entity.var_526dce0b = gettime();

  if(is_true(entity.var_308a238a)) {
    var_c066b9a6 = getdvarfloat(#"hash_69e707c32ac2d165", -1);

    if(var_c066b9a6 > 0) {
      entity.var_16109727 = gettime() + int(var_72e6d5f * 1000);
    }
  }

  assert(!entity flag::get(#"hash_67c62575285677e4"), "<dev string:x708>");

  if(!entity flag::get(#"hash_67c62575285677e4")) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x73d>");
    }

    forward_vec = anglesToForward(entity gettagangles("j_head"));
    forward_vec = (forward_vec[0], forward_vec[1], 0);
    entity.var_ee2440ac dontinterpolate();
    entity.var_ee2440ac.origin = entity gettagorigin("j_head") + forward_vec * (util::get_game_type() == # "zsurvival" ? 1300 : 900);
    entity.var_ac71e4ab = (0, 0, 0);
    entity thread function_4ac5ff55(entity);
  }

  entity.var_76ae69b0 = 0;
  entity.var_67839366 = 0;
  return 5;
}

function function_58607a4e(behaviortreeentity, asmstatename) {
  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](asmstatename);
  }

  head_angles = asmstatename gettagangles("j_head");
  head_angles = (0, head_angles[1], head_angles[2]);
  var_d799417b = head_angles;

  if(isDefined(enemy)) {
    var_d799417b = vectortoangles(enemy getcentroid() - asmstatename gettagorigin("j_head"));
    var_b98aaa32 = vectorcross(anglesToForward((0, head_angles[1], 0)), anglesToForward((0, var_d799417b[1], 0)));
    var_8b8deb51 = math::angle_dif(int(head_angles[1]), int(var_d799417b[1])) * math::sign(var_b98aaa32[2]);
    var_dba5e06 = vectorcross(anglesToForward((0, head_angles[0], 0)), anglesToForward((0, var_d799417b[0], 0)));
    var_ac726f4d = math::angle_dif(int(head_angles[0]), int(var_d799417b[0])) * math::sign(var_dba5e06[2]);
    var_6980273c = math::clamp(var_8b8deb51, -30, 30);
    var_5f823b62 = math::clamp(var_ac726f4d, -45, 45);
    var_f7244c05 = (var_5f823b62, var_6980273c, 0);
    var_e792a112 = function_fc845eb6(asmstatename);

    if(var_e792a112 === 0) {
      return 4;
    }

    lerp_factor = 0.25 / (1 + var_e792a112 * 0.4);
    var_78b0f832 = anglelerp(asmstatename.var_ac71e4ab[1], var_6980273c, lerp_factor);
    var_5782852e = anglelerp(asmstatename.var_ac71e4ab[0], var_5f823b62, lerp_factor);
    asmstatename.var_ac71e4ab = (var_5782852e, var_78b0f832, 0);

    if(!asmstatename cansee(enemy) || abs(var_8b8deb51) > 45) {
      asmstatename.var_76ae69b0 += float(function_60d95f53()) / 1000;
    } else {
      asmstatename.var_76ae69b0 = 0;
    }
  }

  if(is_true(asmstatename.var_1fa24724)) {
    var_ab2fdbbc = gettime() + int(1 * 1000);
    asmstatename.var_16109727 = max(var_ab2fdbbc, asmstatename.var_16109727);
  }

  if(!isDefined(asmstatename.var_9120e7f0)) {
    asmstatename.var_9120e7f0 = head_angles[1];
  }

  if(!isDefined(asmstatename.var_67839366)) {
    asmstatename.var_67839366 = 0;
  }

  var_e54e9225 = math::angle_dif(int(asmstatename.var_9120e7f0), int(head_angles[1]));

  if(var_e54e9225 < 5) {
    asmstatename.var_67839366 += float(function_60d95f53()) / 1000;
    asmstatename.var_9120e7f0 = head_angles[1];
  } else {
    asmstatename.var_67839366 = 0;
  }

  forward_vec = anglesToForward(head_angles + asmstatename.var_ac71e4ab);
  asmstatename.var_ee2440ac.origin = asmstatename gettagorigin("j_head") + forward_vec * (util::get_game_type() == # "zsurvival" ? 1300 : 900);

  if(!is_true(asmstatename.var_308a238a)) {
    if(isPlayer(enemy) && !zombie_utility::is_player_valid(enemy, 1)) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x75f>");
      }

      return 4;
    }

    if(asmstatename.var_76ae69b0 > 2) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x794>");
      }

      return 4;
    }

    if(asmstatename.var_67839366 > 1) {
      if(isDefined(asmstatename.var_54529e1e) && float(gettime() - asmstatename.var_54529e1e) / 1000 > 2) {
        if(is_true(level.var_bb61089c)) {
          println("<dev string:x38>" + "<dev string:x7d0>");
        }

        return 4;
      }
    }

    if(asmstatename flag::get(#"hash_77145e3b0a3b8a73")) {
      if(is_true(level.var_bb61089c)) {
        println("<dev string:x38>" + "<dev string:x823>");
      }

      return 4;
    }
  }

  if(gettime() < asmstatename.var_16109727) {
    return 5;
  }

  return 4;
}

function function_7b02beac(entity, asmstatename) {
  if(flag::get(#"hash_67c62575285677e4")) {
    if(is_true(level.var_bb61089c)) {
      println("<dev string:x38>" + "<dev string:x846>");
    }

    asmstatename thread function_8a959784(asmstatename);
  }

  duration_ms = gettime() - asmstatename.var_526dce0b;
  var_e792a112 = function_fc845eb6(asmstatename);

  if(var_e792a112 === 0) {
    return 4;
  }

  var_98b91d3f = asmstatename.var_ef229fd6[var_e792a112 - 1];
  var_c452f02a = asmstatename.var_a8bb18af[var_e792a112 - 1];

  if(duration_ms < int(var_c452f02a * 1000) * 0.5) {
    var_98b91d3f *= 0.5;
  }

  if(is_true(asmstatename.var_1fa24724)) {
    var_98b91d3f *= 0.5;
  }

  if(duration_ms < int(2 * 1000)) {
    asmstatename thread flag::set_for_time(1, #"hash_1c464f9df131fb78");
  }

  function_9de20709(asmstatename, 1, int(var_98b91d3f * 1000));
  return 4;
}

function private function_86e3dd7b(entity) {
  var_c7c3c6f5 = 1200;
  var_e792a112 = function_fc845eb6(entity);

  if(var_e792a112 === 1) {
    return var_c7c3c6f5;
  }

  enemy = undefined;

  if(isDefined(level.var_f67b08f5)) {
    enemy = [[level.var_f67b08f5]](entity);
  }

  if(isDefined(enemy) && distancesquared(enemy.origin, entity.origin) < sqr(300)) {
    return var_c7c3c6f5;
  }

  return int(-1);
}

function private function_5020432f(entity, point, facing_vec = anglesToForward(entity.angles)) {
  return vectordot(facing_vec, point - entity.origin) < 0;
}

function function_ac104a3d() {
  function_5ac4dc99(#"hash_7993983e3d5d27e6", "<dev string:xf9>");
  function_cd140ee9(#"hash_7993983e3d5d27e6", &function_25a1aefe);
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:x88d>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:x8be>" + "<dev string:x8f5>");
  __index++;
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:x8fa>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:x918>" + "<dev string:x8f5>");
  __index++;
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:x941>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:x95f>" + "<dev string:x8f5>");
  __index++;
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:x988>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:x9a6>" + "<dev string:x8f5>");
  __index++;
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:x9cf>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:x9e3>" + "<dev string:x8f5>");
  __index++;
  __index = isDefined(__index) ? __index : 0;
  util::add_debug_command("<dev string:x86b>" + "<dev string:xa0b>" + "<dev string:x8b2>" + __index + "<dev string:x8b7>" + "<dev string:xa1d>" + "<dev string:x8f5>");
  __index++;
}

function function_25a1aefe(dvar) {
  tokens = strtok(dvar.value, "<dev string:xa43>");

  switch (isDefined(tokens[0]) ? tokens[0] : "<dev string:xf9>") {
    case # "hash_ccd4769d7cd0b67":
      function_5427626d();
      break;
    case # "hash_19e4ca4f6a7fcb44":
      function_38b446e();
      break;
    case # "hash_b5154c650a08666":
      function_3da7e651();
      break;
    case # "hash_3453da4f31a58dd1":
      function_bf8145a9();
      break;
    case # "hash_43332ff3554c1df4":
      function_dd021803();
      break;
    case # "launch_ragdoll":
      launch_ragdoll();
      break;
    default:
      return;
  }

  setDvar(#"hash_7993983e3d5d27e6", "<dev string:xf9>");
}

function private function_5427626d() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    abom.var_a8785ea7 = !is_true(abom.var_a8785ea7);
  }
}

function private function_38b446e() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    abom.var_c44e9122 = !is_true(abom.var_c44e9122);
  }
}

function private function_3da7e651() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    abom.var_f5ffa31e = !is_true(abom.var_f5ffa31e);
  }
}

function private function_bf8145a9() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    abom.var_308a238a = !is_true(abom.var_308a238a);
  }
}

function private function_dd021803() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    abom.var_e76a75b4 = !is_true(abom.var_e76a75b4);
  }
}

function private launch_ragdoll() {
  aboms = function_3ecd4ae();

  foreach(abom in aboms) {
    if(isDefined(level.var_8f1e0b55)) {
      abom[[level.var_8f1e0b55]]((0, 0, 300), getplayers()[0]);
    }
  }
}

function private function_e1f48a38() {
  self endon(#"end_game");

  while(true) {
    if(!getdvarint(#"hash_4e47873b8bfbca14", 0) > 0) {
      level.var_bb61089c = 0;
      waitframe(1);
      continue;
    }

    level.var_bb61089c = 1;
    aboms = function_3ecd4ae();

    foreach(abom in aboms) {
      if(getdvarint(#"hash_647193278c68afe1", 0) > 0) {
        var_127eca1 = ["<dev string:xa48>", "<dev string:xa59>", "<dev string:xa6e>"];

        for(i = 0; i < 3; i++) {
          if(function_17ae1df1(abom, i)) {
            recordsphere(abom gettagorigin(var_127eca1[i]), getdvarfloat(#"hash_4b3df2be7b23dc9f", 15), (1, 0, 0));
          }
        }
      }

      if(getdvarint(#"hash_1cd4bd84364131fc", 0) > 0) {
        flag_str = abom flag::get(#"hash_5c35337a4e15867") ? "<dev string:xa7f>" : "<dev string:xa93>";
        flag_col = abom flag::get(#"hash_5c35337a4e15867") ? (0, 1, 0) : (1, 0, 0);
        record3dtext(flag_str, abom.origin + (0, 0, 70), flag_col);
      }
    }

    if(isDefined(level.zm_loc_types[#"hash_b7c88561b5e9b2c"])) {
      foreach(loc_struct in level.zm_loc_types[#"hash_b7c88561b5e9b2c"]) {
        function_ae63c292(loc_struct.origin, "<dev string:xaa8>", (1, 0, 0));
      }
    }

    waitframe(1);
  }
}

function function_ae63c292(pos, text, col) {
  recordsphere(pos, 10, col);
  record3dtext(text, pos + (0, 0, 10), col);
}

function function_3ecd4ae() {
  return getaiarchetypearray(#"abom");
}