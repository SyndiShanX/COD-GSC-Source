/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3d6cf0d984c55aac.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4d0e7ced9714e7d4;
#using script_63ae018f589c2e64;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\ending;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_d6f0b09d;

function function_ad4c4af2(str_objective) {
  level thread scene::init_streamer("scene_duga_intro", getplayers());
  level thread scene::init_streamer("scene_duga_intro_adler", getplayers());
  animation::add_notetrack_func("duga_intro::bannerocks_brake", &function_1ab4d3a1);
}

function function_be4e11a7(name, starting, direct, player) {
  level flag::set("flag_comprimised_complete");

  if(player) {
    level thread function_fa8186e9();
  }
}

function function_fa8186e9() {
  s_org = struct::get("tag_align_duga_intro", "targetname");
  level flag::wait_till(#"all_players_spawned");
  mdl_door = util::spawn_model("p9_duga_checkpoint_gate", s_org.origin, s_org.angles);
  mdl_door.animname = "gate_left";
  var_1ac40948 = util::spawn_model("veh_t9_civ_us_truck_4x4_cp_duga", s_org.origin, s_org.angles);
  var_1ac40948.animname = "adler_truck";
  mdl_door useanimtree("generic");
  var_1ac40948 useanimtree("generic");
  mdl_door animation::last_frame("t9_duga_intro_dt_gate_idle", s_org);
  var_1ac40948 animation::last_frame("t9_duga_intro_dt_truck_idle", s_org);
}

function function_73f39397() {
  e_player = getplayers()[0];
  e_player val::set(#"hash_4d99b770ba54ea0d", "freezecontrols", 1);
  var_b29e95a1 = [level.woods, level.mason];

  if(isDefined(level.var_deda09e)) {
    array::add(var_b29e95a1, level.var_c1881cdd);
  }

  var_b29e95a1[var_b29e95a1.size] = getplayers()[0];
  level.adler thread scene::play("scene_duga_intro_adler", "dt4_end", level.adler);
  level thread scene::play("scene_duga_intro", "dt4_end", var_b29e95a1);
  e_player thread function_d64a7119();
  level flag::wait_till("flag_execution_blackscreen_up");
  ai_array = getaiteamarray();

  foreach(ai in ai_array) {
    if(isDefined(ai)) {
      ai delete();
    }
  }

  while(level scene::is_playing("scene_duga_intro", "dt4_end")) {
    waitframe(1);
  }
}

function function_d64a7119() {
  self endon(#"death");
  self val::set(#"hash_10cb7a30f6931b6b", "health_regen", 0);
  self val::reset(#"dialog_tree", "takedamage");
  self val::reset(#"hash_503248554f03cf44", "takedamage");
  self val::reset(#"hash_503248554f03cf44", "allowdeath");
  self waittill(#"player_damage");
  self.var_4d9b2bc3 = 0;
  self dodamage(self.health * 0.4, level.adler.origin);
  self clientfield::set_to_player("pstfx_player_executed", 1);
  self waittill(#"blackscreen_up");
  self.var_4d9b2bc3 = 1;
  self val::set(#"hash_10cb7a30f6931b6b", "health_regen", 1);
  level flag::set("flag_execution_blackscreen_up");
  self clientfield::set_to_player("pstfx_player_executed", 0);
  self.health = 100;
}

function function_60a583d8(str_objective, var_50cc0d4f) {
  level.var_c0c469ea = 2.5;
  level battlechatter::function_2ab9360b(0);
  level thread function_7de1bd9d();
  var_5a17d5a0 = getent("lazar", "targetname");
  var_ad36234a = getent("park", "targetname");
  var_5a17d5a0 spawner::add_spawn_function(&function_677d3651);
  var_ad36234a spawner::add_spawn_function(&function_e240f461);
  e_player = getplayers()[0];
  e_player showcrosshair(0);
  namespace_82bfe441::fade(1, "FadeImmediate");
  e_player takeallweapons();
  var_9e22157a = getweapon(#"ar_standard_t9", array("stalker"));
  var_d9338b9c = getweapon(#"pistol_semiauto_t9", array("extbarrel", "fastreload"));
  e_player giveweapon(var_9e22157a);
  e_player givemaxammo(var_9e22157a);
  e_player giveweapon(var_d9338b9c);
  e_player givemaxammo(var_d9338b9c);
  e_player shoulddoinitialweaponraise(var_9e22157a, 0);
  e_player switchtoweaponimmediate(var_9e22157a);
  level function_1a0d08a6();
  level thread namespace_e1ccb37b::function_83409f31(level.var_c0c469ea);
  level thread function_3047261f();
  clientfield::set("stream_intro_truck", 1);
  level namespace_ac5221d7::function_ed760ecb("adler");
  level namespace_ac5221d7::function_ed760ecb("woods");
  level namespace_ac5221d7::function_ed760ecb("mason");
  a_ar = getweapon(#"ar_accurate_t9");
  level.adler hms_util::function_65d14a19(a_ar);
  a_actors = [level.woods, level.mason];

  if(isDefined(level.var_deda09e)) {
    level namespace_ac5221d7::function_ed760ecb(namespace_ac5221d7::function_7b37895());
    array::add(a_actors, level.var_c1881cdd);
  }

  e_player flag::set(level.var_d7d201ba);
  scene::function_d0d7d9f7("scene_duga_intro", &namespace_ac5221d7::function_6f94ced5);
  a_actors = [level.woods, level.mason];

  if(isDefined(level.var_deda09e)) {
    array::add(a_actors, level.var_c1881cdd);
  }

  var_3e3877e9 = spawner::simple_spawn("spawners_intro_redshirts");
  a_actors = arraycombine(a_actors, var_3e3877e9);
  a_actors[a_actors.size] = getplayers()[0];
  level thread scene::play("scene_duga_intro", "introCam", a_actors);
  level thread scene::play("scene_duga_intro_adler", "introCam", [level.adler]);
  level waittill(#"hash_4eb1d6bbf8be77fc");
  level thread scene::play("scene_duga_intro", "dt_enter", a_actors);
  level thread scene::play("scene_duga_intro_adler", "dt_enter", [level.adler]);
  level waittill(#"hash_459a515290c970dc");
  level thread scene::play("scene_duga_intro_adler", "dt_idle", [level.adler]);
  level.var_1bf038f6 dialog_tree::run(level.adler);
  s_result = level flag::wait_till_any([#"flag_ambush_signaled", #"hash_49d647c310f93e45"]);
  clientfield::set("stream_intro_truck", 0);

  if(s_result._notify === "flag_ambush_signaled") {
    level flag::set("flag_comprimised_complete");
    skipto::function_4e3ab877(var_50cc0d4f);
    return;
  }

  function_73f39397();
  level.var_9706ce90 = 1;
  level namespace_ac5221d7::function_ae1eba32();
  skipto::function_f02f0c63();
  skipto::function_1c2dfc20();
}

function function_3047261f() {
  level waittill(#"hash_3eb5622b1b945f73");
  level thread globallogic_ui::function_7bc0e4b9(0);
}

function function_e240f461() {
  self setdedicatedshadow(1);
}

function function_677d3651() {
  self setdedicatedshadow(1);
}

function function_1a0d08a6() {
  var_2fab6c8d = "";

  if(!isDefined(level.var_deda09e)) {
    var_2fab6c8d = "vox_cp_duga_01000_masn_adlernosignsofm_50";
  } else if(level.var_deda09e === "park") {
    var_2fab6c8d = "vox_cp_duga_01000_park_adlerstillseein_a0";
  } else {
    var_2fab6c8d = "vox_cp_duga_01000_lazr_adlernocontacto_8c";
  }

  wait 2;
  level.player dialogue::radio(var_2fab6c8d);
  wait 0.75;
  level.player dialogue::radio("vox_cp_duga_01000_wood_sameihaventseen_bb");
  wait 1.25;
  level.player dialogue::radio("vox_cp_duga_01000_adlr_alrighteveryone_3c");
  wait 2;
}

function function_7de1bd9d() {
  var_681b585d = level.var_96d76ea;
  var_7b500845 = "dt_idle";
  var_8bba7bce = 20;
  level.var_1bf038f6 = dialog_tree::new_tree(undefined, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce);
  var_9d78df2a = "vox_cp_duga_01100_adlr_ihadnootherchoi_ce";
  var_21eb0ff0 = "vox_cp_duga_01100_adlr_whatkindoffucke_20";
  var_bdac1482 = "vox_cp_duga_01100_adlr_whatawasteyouac_39";
  level.var_1bf038f6 dialog_tree::add_option(#"hash_2b270bbc8e926055", undefined, "dt1_res1", "dt_idle", 1, undefined, undefined, &function_cece5b3e);
  level.var_1bf038f6 dialog_tree::add_option(#"hash_2b23e3bc8e8fe686", undefined, "dt1_res2", "dt_idle", 1, undefined, undefined, &function_cece5b3e);

  if(is_true(var_681b585d)) {
    level.var_1bf038f6 dialog_tree::add_option(#"hash_65dfd8ecb8e90e2f", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab, 1);
    level.var_1bf038f6 dialog_tree::function_6ebd37a4();
  }

  level.var_2daedc73 = dialog_tree::new_tree(&function_e7dca05b, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce);
  var_9d78df2a = "vox_cp_duga_01100_adlr_thosenukesweref_58";
  var_21eb0ff0 = "vox_cp_duga_01100_adlr_theresnowinnerh_67";
  var_1ee51ad7 = "vox_cp_duga_01100_adlr_youllregretthis_2e";
  level.var_2daedc73 dialog_tree::add_option(#"hash_7de0ebb62c198152", undefined, "dt2_res1", "dt_idle", 1, undefined, undefined, &function_33ff1feb);
  level.var_2daedc73 dialog_tree::add_option(#"hash_7de413b62c1bfb21", undefined, "dt2_res2", "dt_idle", 1, undefined, undefined, &function_33ff1feb);

  if(is_true(var_681b585d)) {
    level.var_2daedc73 dialog_tree::add_option(#"hash_3092ff7b2aa8cc8f", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab, 1);
    level.var_2daedc73 dialog_tree::function_6ebd37a4();
  }

  level.var_305ce1cf = dialog_tree::new_tree(&function_f3ddb2c5, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce);
  var_9d78df2a = "vox_cp_duga_01100_adlr_youreflattering_89";
  var_21eb0ff0 = "vox_cp_duga_01100_adlr_apparentlywedid_6e";
  var_fe0dc6ea = "vox_cp_duga_01100_adlr_imcomfortablewi_ab";
  var_66b4a54 = "vox_cp_duga_01100_adlr_timesupkid_b4";
  level.var_305ce1cf dialog_tree::add_option(#"hash_2773b7ae90a8ee17", undefined, "dt3_res1", "dt_idle", 1, undefined, undefined, &function_32bc6252);
  level.var_305ce1cf dialog_tree::add_option(#"hash_277ea7ae90b2da6c", undefined, "dt3_res2", "dt_idle", 1, undefined, undefined, &function_32bc6252);

  if(is_true(var_681b585d)) {
    level.var_305ce1cf dialog_tree::add_option(#"hash_65c8ebb6d6f2f8e1", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab, 1);
    level.var_305ce1cf dialog_tree::function_6ebd37a4();
  }

  level.var_4222855a = dialog_tree::new_tree(&function_a9cf5806, undefined, 1, 1, "scene_duga_intro_adler", 1);
  level.var_4222855a dialog_tree::add_option(#"hash_3e50d706852384a4", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab);
  level.var_4222855a dialog_tree::function_6ebd37a4();
  level.var_4222855a dialog_tree::add_option(#"hash_762b5d6397cfcbbd", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab);
  level.var_4222855a dialog_tree::function_6ebd37a4();
  var_1584d516 = getplayers()[0] player_decision::function_1c4fb6d4();

  var_9a7b5d79 = getdvarint(#"hash_4dd19684bf68597b", -1);

  if(var_9a7b5d79 != -1) {
    var_1584d516 = var_9a7b5d79;
  }

  switch (var_1584d516) {
    case 0:
      level.var_4222855a dialog_tree::add_option(#"hash_5ccf7beaba70f824", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab);
      level.var_4222855a dialog_tree::function_6ebd37a4();
      break;
    case 1:
      level.var_4222855a dialog_tree::add_option(#"hash_6a96859fd1722324", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab);
      level.var_4222855a dialog_tree::function_6ebd37a4();
      break;
    case 2:
      level.var_4222855a dialog_tree::add_option(#"hash_4befaf7450e295c5", undefined, undefined, "dt_idle", 1, undefined, undefined, &function_b31036ab);
      level.var_4222855a dialog_tree::function_6ebd37a4();
      break;
  }
}

function function_cece5b3e() {
  self waittill(#"hash_12324459eb2bc76d");
  level.var_2daedc73 thread dialog_tree::run(level.adler);
}

function function_e7dca05b() {
  waitframe(1);
  level.adler scene::play("scene_duga_intro_adler", "dt2_enter");
  level.adler thread scene::play("scene_duga_intro_adler", "dt_idle");
}

function function_33ff1feb() {
  self waittill(#"hash_12324459eb2bc76d");
  level.var_305ce1cf thread dialog_tree::run(level.adler);
}

function function_f3ddb2c5() {
  waitframe(1);
  level.adler scene::play("scene_duga_intro_adler", "dt3_enter");
  level.adler thread scene::play("scene_duga_intro_adler", "dt_idle");
}

function function_32bc6252() {
  self waittill(#"hash_12324459eb2bc76d");

  if(is_true(level.var_96d76ea)) {
    level.var_4222855a thread dialog_tree::run(level.adler);
    return;
  }

  waitframe(1);
  level.adler scene::play("scene_duga_intro_adler", "dt4_enter");
  level flag::set(#"hash_49d647c310f93e45");
}

function function_a9cf5806() {
  waitframe(1);
  level.adler scene::play("scene_duga_intro_adler", "dt4_enter");
}

function function_b31036ab(var_d62d7ec3) {
  var_b29e95a1 = [level.woods, level.mason];

  if(isDefined(level.var_deda09e)) {
    array::add(var_b29e95a1, level.var_c1881cdd);
  }

  level flag::set(#"flag_ambush_signaled");
}

function function_1ab4d3a1(parms) {
  println("<dev string:x38>");
  self vehicle::toggle_force_driver_taillights(1);
}