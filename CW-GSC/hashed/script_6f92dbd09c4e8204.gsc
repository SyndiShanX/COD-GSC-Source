/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6f92dbd09c4e8204.gsc
***********************************************/

#using script_210ec734a4149bac;
#using script_279a5d4e51c06d1a;
#using script_3b7c3b99b28b21b7;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4b6505921addc7bc;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_dd1bf157;

function init_flags() {
  level flag::init("street_begin");
  level flag::init("street_done");
  level flag::init("flag_found_contact");
  level flag::init("bar_dialog_choice_01_finished");
  level flag::init("bar_dialog_choice_02_finished");
  level flag::init("bar_conv_exit_unlocked");
  level flag::init("player_opened_bar_door");
  level flag::init("close_bar_bathroom_door");
  level flag::init("bar_bathroom_door_locked");
}

function function_22b7fffd() {
  animation::add_notetrack_func("cp_ger_stakeout_street::street_raid", &function_3df63143);
}

function start(str_objective) {
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  scene::add_scene_func("aib_vign_stakeout_street_rooftop_descend", &function_bd064da5, "init");
  level scene::init("aib_vign_stakeout_street_rooftop_descend");
  level thread namespace_acaa3a2e::checkpoint_scene(1);
  level thread namespace_acaa3a2e::function_4fbe7d07(1);
  level thread namespace_acaa3a2e::function_85133ec9();
  level thread function_16806e9();
  level thread function_3da072ca();
  level thread namespace_acaa3a2e::function_13778421(1);
  level thread namespace_acaa3a2e::function_e76b838d(1);
}

function main(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    namespace_5ceacc03::music("5.0_kraus");
    level thread function_ab5026e9();
    player setmovespeedscale(0.72);
    level.var_4e5a623b = 1;
    level namespace_979752dc::function_2324f175(0);
  }

  level flag::set("street_begin");
  level thread function_7195dc36();
  level.adler thread function_40900e7c();
  level thread function_c4fa138b();
  level thread function_70978834();
  level thread function_ba99d91b();
  level flag::wait_till("flag_player_cleanup_wall");
  level thread function_e632b562();
  level thread function_cb866b85();
  level flag::wait_till("street_done");
  util::unmake_hero("adler", 1);
  skipto::function_4e3ab877("street");
}

function function_dc6107f7(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    level flag::set("start_rooftop_descend_alley");
    level flag::set("street_done");
  }
}

function function_70978834(skipto) {
  player = getplayers()[0];
  player enableweaponcycling();
  player val::set("street_stealth", "allow_melee", 0);
  player val::set("street_stealth", "allow_sprint", 0);
  level thread namespace_11998b8f::function_de88eefd();
  player namespace_979752dc::set_disguised(1);
  wait 1;
  level thread function_5bb4901();

  if(!is_true(skipto)) {
    player thread namespace_acaa3a2e::function_6ea5318c(1);
    level flag::wait_till("start_rooftop_descend_alley");
    wait 0.75;
  }

  namespace_11998b8f::stakeout_stow_weapon();
  level flag::set("stop_supressed_hint");
  player spy_camera::function_b83af2a9();
  player setcinematicmotionoverride("cinematicmotion_kgb");
  level flag::wait_till("bar_done");
  player val::reset("street_stealth", "allow_melee");
  player val::reset("street_stealth", "allow_sprint");
}

function function_5bb4901() {
  ai_array = getaiteamarray("axis");
  level flag::wait_till_any(array("stealth_spotted", "flag_fail_street"));

  if(level flag::get("bar_bathroom_door_locked")) {
    return;
  }

  ai_array = getaiteamarray("axis");

  foreach(guy in ai_array) {
    ai::setaiattribute(guy, "can_melee", 0);
  }

  player = getplayers()[0];
  player namespace_979752dc::set_disguised(0);
  closest_guy = arraygetclosest(player.origin, ai_array);
  closest_guy thread dialogue::queue("vox_cp_stkt_07130_gms2_stoppolice_64");
  wait 2;
  var_ac09f234 = arraysortclosest(ai_array, player.origin, 3);

  foreach(guy in var_ac09f234) {
    guy.holdfire = 0;
  }

  wait 1;

  if(!level flag::get("start_rooftop_descend_alley")) {
    level util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_4e9d4bf1d65f17f5");
    return;
  }

  level util::missionfailedwrapper(#"hash_4c5af5a1cd80371", #"hash_18b8caabd523d66b");
}

function function_40900e7c() {
  level.adler endon(#"death");
  level.adler val::set("street", "ignoreall", 1);
  level.adler val::set("street", "ignoreme", 1);
  level thread rooftop_descend();
  level thread function_3f99d722();
  level waittill(#"hash_260399978a422f37");
  level thread function_4b0934d0();
  level flag::wait_till("player_opened_bar_door");
  level thread function_82814d33();
  util::unmake_hero("adler", 1);
}

function rooftop_descend() {
  level.adler.var_5b22d53 = 0;
  level.adler util::delay("hide_pistol", "death", &val::set, "rooftop_descend", "take_weapons", 1);
  level scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_roof");

  if(!level flag::get("start_rooftop_descend_stairs")) {
    level thread scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_roof_loop");
    level flag::wait_till("start_rooftop_descend_stairs");
  }

  thread namespace_5ceacc03::rooftop_descend();
  level scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_stairs");

  if(!level flag::get("start_rooftop_descend_alley")) {
    level thread scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_stairs_loop");
    level flag::wait_till("start_rooftop_descend_alley");
  }

  level thread namespace_5ceacc03::function_dceebb0a();
  player = getplayers()[0];
  player thread util::blend_movespeedscale(0.8, 1.5);
  level scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_alley");
  level thread scene::play("aib_vign_stakeout_street_rooftop_descend", "rooftop_descend_alley_loop");
  level flag::wait_till("street_done");

  if(isDefined(level.rooftop_descend_door_01_clip)) {
    level.rooftop_descend_door_01_clip delete();
  }

  if(isDefined(level.rooftop_descend_door_02_clip)) {
    level.rooftop_descend_door_02_clip delete();
  }

  if(isDefined(level.var_47fb3484)) {
    level.var_47fb3484 delete();
  }

  if(isDefined(level.var_a23ce906)) {
    level.var_a23ce906 delete();
  }
}

function function_3f99d722() {
  level waittill(#"hash_2fd991dc5737be3f");
  dialogue::radio("vox_cp_stkt_05300_park_lazarandiareatt_db");
}

function function_bd064da5(a_ents) {
  level.rooftop_to_street_anim_org = struct::get("rooftop_to_street_anim_org", "targetname");
  assert(isDefined(level.rooftop_to_street_anim_org), "<dev string:x38>");
  level.var_47fb3484 = a_ents[#"hash_77e429d3dc04d06"];
  level.var_47fb3484 attach("stk_door_metal_painted_rusted_01_orange", "j_prop_1");
  level.rooftop_descend_door_01_clip = getent("rooftop_descend_door_01_clip", "targetname");

  if(isDefined(level.rooftop_descend_door_01_clip)) {
    level.rooftop_descend_door_01_clip linkto(level.var_47fb3484, "j_prop_1", (0, 0, 0), (0, 0, 0));
  }

  level.var_a23ce906 = a_ents[#"hash_77e419d3dc04b53"];
  level.var_a23ce906 attach("stk_door_metal_painted_rusted_01_orange", "j_prop_1");
  level.rooftop_descend_door_02_clip = getent("rooftop_descend_door_02_clip", "targetname");

  if(isDefined(level.rooftop_descend_door_02_clip)) {
    level.rooftop_descend_door_02_clip linkto(level.var_a23ce906, "j_prop_1", (0, 0, 0), (0, 0, 0));
  }

  waitframe(1);
  namespace_5ceacc03::door_init(level.var_47fb3484);
  namespace_5ceacc03::door_init(level.var_a23ce906);
}

function function_c4fa138b(skipto) {
  if(!is_true(skipto)) {
    level waittill(#"hash_260399978a422f37");
  }

  var_de3630d1 = struct::get("struct_street_door_obj", "targetname");

  if(!isDefined(objectives::function_285e460(#"hash_1e9e59810ef392e9"))) {
    objectives::scripted(#"hash_1e9e59810ef392e9", undefined, #"hash_2afea3284a778717");
    level thread function_a51eff8d();
  }

  if(!is_true(skipto)) {
    objectives::goto(#"hash_701db995108ff54", var_de3630d1.origin, undefined, 0);
    objectives::function_67f87f80(#"hash_701db995108ff54", undefined, #"hash_2767c5698dd71966");
    level flag::wait_till("player_opened_bar_door");
    objectives::remove(#"hash_701db995108ff54");
  }

  level flag::wait_till("flag_found_contact");
  objectives::complete(#"hash_116f8a0affe35d82");
  objectives::complete(#"hash_1e9e59810ef392e9");
}

function function_a51eff8d() {
  self notify("7ef2d8f45e308b79");
  self endon("7ef2d8f45e308b79");
  t_bar_search_area = getent("t_bar_search_area", "targetname");
  objectives::area(#"hash_116f8a0affe35d82", t_bar_search_area, undefined, undefined, 0, 0, undefined, #"hash_b1305ea2f0825bd");
  level endon(#"flag_found_contact");

  while(true) {
    level flag::wait_till("player_in_bar");
    exploder::exploder("fx_exp_bar_window_rain");
    level flag::wait_till_clear("player_in_bar");
    exploder::stop_exploder("fx_exp_bar_window_rain");
  }
}

function function_16806e9() {
  spawner::add_spawn_function_group("street_civ_walker", "script_noteworthy", &function_942b1325);
  var_260d2a42 = spawner::simple_spawn("street_guard_ambient", &function_90592726);
  level thread namespace_11998b8f::function_91a7f501("street_ambient_harass_loop", "bar_bathroom_door_locked");
  level thread namespace_11998b8f::function_91a7f501("street_ambient_harass_loop_2", "flag_found_contact");
  wait 1.5;
  var_57b95aeb = spawner::get_ai_group_ai("street_looper");

  foreach(guy in var_57b95aeb) {
    guy thread namespace_acaa3a2e::function_fadf5523("street");
  }

  level flag::wait_till("start_rooftop_descend_alley");
  var_84c671ac = spawner::simple_spawn("street_guard_ambient_2", &function_90592726);
  level thread namespace_11998b8f::function_91a7f501("street_ambient_harass_loop_3", "bar_bathroom_door_locked");
  level thread namespace_11998b8f::function_91a7f501("street_ambient_harass_loop_4", "flag_found_contact");
  var_57b95aeb = spawner::get_ai_group_ai("street_looper_2");

  foreach(guy in var_57b95aeb) {
    guy thread namespace_acaa3a2e::function_fadf5523("street");
  }
}

function function_942b1325() {
  self endon(#"death");

  if(math::cointoss()) {
    self namespace_f592a7b::function_7bd21c92("UMBRELLA_LEFT");
  } else {
    self namespace_f592a7b::function_7bd21c92("UMBRELLA_RIGHT");
  }

  self val::set(#"hash_63a53c05cf06f7f7", "push_player", 1);
  self thread namespace_11998b8f::function_a09d85a9();
  level flag::wait_till("bar_bathroom_door_locked");
  self delete();
}

function function_90592726() {
  self endon(#"death");
  self.holdfire = 1;
  self thread function_17e9330d();
  self thread namespace_acaa3a2e::function_fadf5523("street");
}

function function_17e9330d() {
  self endon(#"death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "can_delete") {
    level flag::wait_till("flag_found_contact");
    self delete();
    return;
  }

  level flag::wait_till("bar_bathroom_door_locked");
  self delete();
}

function function_7195dc36() {
  level flag::clear("flag_amb_civ_lighton_start");
  level scene::init("scene_z_stk_amb_lighton");
  level flag::wait_till("flag_amb_civ_lighton_start");
  level scene::play_from_time("scene_z_stk_amb_lighton", undefined, undefined, 3, 0);
}

function function_3da072ca() {
  level flag::wait_till("move_kraus_into_bar");
  level thread namespace_11998b8f::function_973a721b("street_checkpoint_car", "flag_found_contact");
}

function function_ba99d91b() {
  level flag::wait_till("start_rooftop_descend_alley");
  savegame::checkpoint_save(1);
}

function function_a0a11086() {
  street_checkpoint_pullup_car = getEntArray("street_checkpoint_pullup_car", "script_noteworthy");

  if(isDefined(street_checkpoint_pullup_car)) {
    array::delete_all(street_checkpoint_pullup_car);
  }
}

function function_4a622f64() {}

function function_ae924b50(str_objective) {
  level thread namespace_acaa3a2e::checkpoint_scene(1);
  level thread function_16806e9();
  level thread namespace_acaa3a2e::function_e76b838d(1);
  level thread function_c4fa138b(1);
  level thread function_e632b562(1);
}

function function_9145f67a(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    namespace_11998b8f::stakeout_stow_weapon();
    level thread function_70978834(1);
    level thread function_ab5026e9("bar");
    player setmovespeedscale(0.8);
    level.var_4e5a623b = 1;
    level namespace_979752dc::function_2324f175(0);
    level thread function_82814d33();
    level thread function_cb866b85(1);
    level flag::wait_till("level_is_go");
  }

  level battlechatter::function_2ab9360b(0);
  level flag::set("bar_begin");
  level.bar_bathroom_door = doors::function_73f09315("bar_bathroom_door");
  level.bar_bathroom_door thread function_510e7c9e();
  level thread bar_dialogue_enter();
  level thread namespace_5ceacc03::function_4b6fc5b8();
  level thread namespace_5ceacc03::function_4e7aa055();
  level flag::wait_till("bar_bathroom_door_locked");
  player = getplayers()[0];
  clientfield::set("force_stream_bar", 0);
  skipto::function_4e3ab877("bar");
}

function function_34aae650(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  var_33b3e0a3 = getent("adler_alley_door", "targetname");
  var_2e0784ad = getent(var_33b3e0a3.target, "targetname");

  if(isDefined(var_33b3e0a3)) {
    var_33b3e0a3 delete();
  }

  if(isDefined(var_2e0784ad)) {
    var_2e0784ad delete();
  }

  var_8bf7c32b = getent("adler_roof_door1", "targetname");
  var_3d2edef2 = getent(var_8bf7c32b.target, "targetname");

  if(isDefined(var_8bf7c32b)) {
    var_8bf7c32b delete();
  }

  if(isDefined(var_3d2edef2)) {
    var_3d2edef2 delete();
  }

  level thread function_d2de5ec5("cin_stakeout_wall_bar_enter");
  level thread function_d2de5ec5("cin_stakeout_street_bar_contact");
  level thread function_d2de5ec5("cin_stakeout_street_bar_guy07");
  level thread function_d2de5ec5("cin_stakeout_street_bar_ladies_loop");
  level thread function_d2de5ec5("cin_stakeout_street_bar_guys");
  level thread function_d2de5ec5("cin_stakeout_street_bar_guys_playing_cards");
  level thread function_d2de5ec5("scene_z_stk_bar_street_raid");
  level thread function_d2de5ec5("aib_vign_stakeout_wall_checkpoint_scene");
  level thread function_d2de5ec5("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_02_bundle");
  level thread function_d2de5ec5("scene_z_stk_tower_patrol");

  if(isDefined(level.bar_officer01)) {
    level.bar_officer01 delete();
  }

  if(isDefined(level.bar_officer02)) {
    level.bar_officer02 delete();
  }

  if(player) {
    var_3a22167a = getEntArray("west_berlin_window_cards", "targetname");
    array::delete_all(var_3a22167a);
  }
}

function function_d2de5ec5(scenedef) {
  if(level scene::is_active(scenedef)) {
    level scene::stop(scenedef, 1);
  }
}

function function_ab5026e9(str_id) {
  if(!isDefined(level.kraus)) {
    level.kraus = spawner::simple_spawn_single("kraus_cp_streets");
    level.kraus.var_5b22d53 = 0;
    level.kraus.var_34fc6abf = getent("kraus_cp_umbrella", "targetname");
    level.kraus.var_34fc6abf.animname = "kraus_umbrella";
    level.kraus.briefcase = getent("kraus_cp_briefcase", "targetname");
    level.kraus.briefcase.animname = "kraus_briefcase";
    level.kraus namespace_acaa3a2e::function_bfd89ef1();
    wait 0.5;
    level.kraus thread namespace_acaa3a2e::function_9a126ef9(str_id);
  }
}

function function_e632b562(skipto) {
  player = getplayers()[0];
  clientfield::set("force_stream_bar", 1);
  level thread function_6c634ee9();

  if(!isDefined(level.var_e8ddef56)) {
    level.var_e8ddef56 = struct::get("contact_convo_anim_org", "targetname");
  }

  scene::add_scene_func("cin_stakeout_street_bar_contact", &function_93407046, "init");
  level scene::init("cin_stakeout_street_bar_contact");
  scene::add_scene_func("cin_stakeout_street_bar_guys", &function_e9963fec, "init");
  level scene::init("cin_stakeout_street_bar_guys");
  level.bar_guy07 = spawner::simple_spawn_single("bar_guy07");
  scene::add_scene_func("scene_z_stk_bar_amb", &function_ca4c9d7c, "init");
  level scene::init("scene_z_stk_bar_amb");
  level flag::set("flag_bar_ready");
  scene::add_scene_func("cin_stakeout_street_bar_guys_playing_cards", &function_75b7378e, "init");
  level scene::init("cin_stakeout_street_bar_guys_playing_cards");
  scene::add_scene_func("cin_stakeout_street_bar_guy07", &function_a8b581af, "init");
  level scene::init("cin_stakeout_street_bar_guy07");
  scene::add_scene_func("cin_stakeout_street_bar_ladies_loop", &function_c532243b, "init");
  level scene::init("cin_stakeout_street_bar_ladies_loop");
  wait 0.5;
  level thread function_1b06b6df();
  level thread bar_guy07();
}

function function_510e7c9e() {
  level flag::wait_till("bar_done");
  level flag::wait_till("close_bar_bathroom_door");
  bar_bathroom_door_close_safely_clip = getent("bar_bathroom_door_close_safely_clip", "targetname");

  if(isDefined(bar_bathroom_door_close_safely_clip)) {
    bar_bathroom_door_close_safely_clip.origin += (0, 0, 128);
  }

  bathroom_door = doors::function_73f09315("bar_bathroom_door");
  doors::close("bar_bathroom_door");
  level thread function_7691a965();
  doors::lock("bar_bathroom_door");
  level flag::set("bar_bathroom_door_closing");

  if(isDefined(bathroom_door.c_door)) {
    bathroom_door.c_door flag::wait_till("door_fully_closed");
  }

  wait 0.5;
  level flag::set("bar_bathroom_door_locked");

  if(isDefined(bar_bathroom_door_close_safely_clip)) {
    bar_bathroom_door_close_safely_clip delete();
  }
}

function function_8cb46516(modelname, var_b92254fd, var_8964d1a4, spawnfunc = undefined) {
  assert(isDefined(modelname), "<dev string:x5c>");
  assert(isDefined(var_b92254fd), "<dev string:x84>");
  prop = spawn("script_model", self.origin);
  prop setModel(modelname);
  prop linkto(self, var_b92254fd, (0, 0, 0), (0, 0, 0));

  if(isDefined(spawnfunc)) {
    prop thread[[spawnfunc]]();
  }

  if(isDefined(var_8964d1a4)) {
    level flag::wait_till(var_8964d1a4);

    if(isDefined(prop)) {
      prop unlink();
      prop delete();
    }
  }
}

function function_93407046(a_ents) {
  level.bar_contact = a_ents[#"bar_contact"];
  level.var_fb6f2b39 = a_ents[#"hash_9ed8929ecade2d1"];
  level.var_1922a1f3 = a_ents[#"hash_138ab38d70041928"];
  level.var_1922a1f3 thread function_8cb46516("aac_kitchen_chair_01", "j_prop_1", "bar_bathroom_door_locked");
  level.var_1922a1f3 thread function_8cb46516("par_glassware_03", "j_prop_2", "bar_bathroom_door_locked");
  level.var_1922a1f3 thread function_8cb46516("cob_cigarette_pack_01", "j_prop_4", "bar_bathroom_door_locked");
  level.var_1922a1f3 thread function_8cb46516("ndy_cigarette_static_01_lit_long", "j_prop_5", "bar_bathroom_door_locked", &cp_ger_stakeout_fx::function_943c286e);
  level.var_1922a1f3 thread function_8cb46516("decor_ashtray_cigarette_01_drk", "j_prop_6", "bar_bathroom_door_locked");
  level.var_1922a1f3 thread function_8cb46516("ndy_cigarette_static_01_lit_long", "j_prop_7", "bar_bathroom_door_locked");
  level.var_ee1e1434 = a_ents[#"hash_4261c3b16eb03ccd"];
  level.var_ee1e1434 hide();
  level.var_bff9a427 = a_ents[#"hash_23b3016798978dbf"];
  level.var_bff9a427 hide();
  level.var_d3081b95 = a_ents[#"hash_14b186511fdb3df7"];
  level.var_d3081b95 attach("aac_kitchen_chair_01", "j_prop_1", 1);
  level.var_d3081b95 attach("cob_cigarette_pack_01", "j_prop_2", 1);
}

function function_e9963fec(a_ents) {
  level.var_dd43ea07 = a_ents[#"hash_2ea9c8cdee3cd84a"];
  a_ents[#"hash_2ea9c8cdee3cd84a"] setModel(#"hash_322f0af6c1be1b88");
  level.var_90258347 = a_ents[#"hash_7c416f8b69782e94"];
  a_ents[#"hash_7c416f8b69782e94"] setModel(#"hash_1d1f55abc907ac00");
  level.var_90258347 thread function_37d7e316();
  level.var_9de42dec = a_ents[#"hash_82d37dad8ad0efd"];
  a_ents[#"hash_82d37dad8ad0efd"] setModel(#"hash_322f0bf6c1be1d3b");
  level.var_f4b6db4c = a_ents[#"hash_82d34dad8ad09e4"];
  a_ents[#"hash_82d34dad8ad09e4"] setModel(#"hash_322f0df6c1be20a1");
  level.var_77534a72 = a_ents[#"hash_179a86c5a48ab1fc"];
  a_ents[#"hash_179a86c5a48ab1fc"] setModel(#"hash_1d1f5cabc907b7e5");
  level.var_899eef09 = a_ents[#"hash_179a89c5a48ab715"];
  a_ents[#"hash_179a89c5a48ab715"] setModel(#"hash_1d1f56abc907adb3");
  waitframe(1);
  level.var_b20c744c = a_ents[#"hash_321592f79988a4a3"];
  level.var_b20c744c attach("par_glassware_01", "j_prop_1", 1);
  level.var_9add4841 = a_ents[#"hash_7157295a64f1fad"];
  level.var_9add4841 attach("stk_serving_tray_01", "j_prop_1", 1);
  level.var_9add4841 attach("par_glassware_03", "j_prop_2", 1);
  level.var_5f8afdc7 = a_ents[#"hash_24bc4280065483dd"];
  level.var_5f8afdc7 attach("par_glassware_01", "j_prop_2", 1);
  level.var_ae6a9219 = a_ents[#"hash_154bfafb62cd0af3"];
  level.var_6bd49be4 = a_ents[#"hash_3c56139fe8f88d4"];
  level.var_6bd49be4 attach("aac_kitchen_chair_01", "j_prop_1", 1);
  level.var_6bd49be4 attach("par_glassware_01", "j_prop_2", 1);
  waitframe(1);
  level.var_7bd40b4f = a_ents[#"hash_51a76c887b70705e"];
  level.var_7bd40b4f attach("aac_kitchen_chair_01", "j_prop_1", 1);
  level.var_7bd40b4f attach("aac_kitchen_chair_01", "j_prop_2", 1);
  level.var_7bd40b4f attach("stk_glass_beer_bottle_01_open", "j_prop_3", 1);
  level.var_7bd40b4f attach("par_glassware_03", "j_prop_4", 1);
  var_cdec639c = a_ents[#"hash_2ea9c8cdee3cd84a"];
  var_906b811d = a_ents[#"hash_82d34dad8ad09e4"];
  level.var_f249468f = a_ents[#"hash_82d37dad8ad0efd"];
  level.var_5b216319 = a_ents[#"hash_179a86c5a48ab1fc"];
  level thread function_4742334a(var_cdec639c, var_906b811d);
  level thread function_464221cf();
}

function function_37d7e316() {
  level waittill(#"hash_17201698dc812fea");

  if(self scene::function_c935c42()) {
    [[self._scene_object]] - > stop();
  }

  if(level.var_9add4841 scene::function_c935c42()) {
    [[level.var_9add4841._scene_object]] - > stop();
  }

  if(isDefined(level.var_9add4841)) {
    level.var_9add4841 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_4742334a(var_cdec639c, var_906b811d) {
  level waittill(#"hash_680b61fcaf2f8006");
  wait 2;
  var_cdec639c dialogue::queue("vox_cp_stkt_06260_gmc3_greathavehersto_dc");
  var_906b811d dialogue::queue("vox_cp_stkt_06260_gmc2_illdothatthanks_c5");
}

function function_75b7378e(a_ents) {
  level.var_b946e46d = a_ents[#"hash_82d32dad8ad067e"];
  a_ents[#"hash_82d32dad8ad067e"] setModel(#"hash_322f0ef6c1be2254");
  level.var_b946e46d val::set("bar_patrons", "ignoreall", 1);
  level.var_b946e46d val::set("bar_patrons", "ignoreme", 1);
  level.var_ab91c903 = a_ents[#"hash_82d33dad8ad0831"];
  a_ents[#"hash_82d33dad8ad0831"] setModel(#"hash_322f0ff6c1be2407");
  level.var_ab91c903 val::set("bar_patrons", "ignoreall", 1);
  level.var_ab91c903 val::set("bar_patrons", "ignoreme", 1);
  level.var_425c76da = a_ents[#"hash_82d30dad8ad0318"];
  a_ents[#"hash_82d30dad8ad0318"] setModel(#"hash_322f0cf6c1be1eee");
  level.var_425c76da val::set("bar_patrons", "ignoreall", 1);
  level.var_425c76da val::set("bar_patrons", "ignoreme", 1);
  level.var_a36cb321 = a_ents[#"hash_44d03776a8eca114"];
  level.var_a36cb321 thread function_8cb46516("aac_kitchen_chair_01", "j_prop_1", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("par_glassware_03", "j_prop_2", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_glass_beer_bottle_01_open", "j_prop_3", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_glass_beer_bottle_01_open", "j_prop_4", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("cob_playing_cards_01", "j_prop_5", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_004", "j_prop_6", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_008", "j_prop_7", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("cob_playing_cards_01", "j_prop_8", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_001", "j_prop_9", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_007", "j_prop_10", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("cob_playing_cards_01", "j_prop_11", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_002", "j_prop_12", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_006", "j_prop_13", "bar_bathroom_door_locked");
  level.var_a36cb321 thread function_8cb46516("stk_cards_playing_single_015", "j_prop_14", "bar_bathroom_door_locked");
}

function function_c532243b(a_ents) {
  level.var_a31721f9 = a_ents[#"hash_179a88c5a48ab562"];
  a_ents[#"hash_179a88c5a48ab562"] setModel(#"hash_1d1f57abc907af66");
  level.var_5f04560a = a_ents[#"hash_2973a0047eb6753b"];
  level.var_5f04560a attach("par_glassware_03", "j_prop_1", 1);
}

function function_a8b581af(a_ents) {
  a_ents[#"bar_guy07"] setModel(#"hash_322f11f6c1be276d");
  level.var_5abddee0 = a_ents[#"hash_6c70e733ac26ab82"];
  level.var_5abddee0 attach("par_glassware_03", "j_prop_1", 1);
  level.var_5abddee0 attach("ndy_cigarette_static_01_lit_long", "j_prop_2", 1);
}

function function_ca4c9d7c(a_ents) {
  level.var_221cd219 = a_ents[#"hash_523c40dd793e9ddf"];
  a_ents[#"hash_523c40dd793e9ddf"] setModel(#"hash_322f08f6c1be1822");
  level.var_305cee99 = a_ents[#"hash_523c3fdd793e9c2c"];
}

function bar_guy07() {
  level endon(#"flag_bar_dialogue_exit");
  wait 0.5;
  guys = [];
  guys[guys.size] = level.bar_guy07;
  guys[guys.size] = level.var_5abddee0;
  level flag::wait_till("flag_found_contact");
  wait 4;
  level.bar_guy07.var_5b22d53 = 0;
  level scene::play("cin_stakeout_street_bar_guy07", "move_to_table");
  level thread scene::play("cin_stakeout_street_bar_guy07", "loop_at_table");
  wait 4;
  level scene::play("cin_stakeout_street_bar_guy07", "move_to_bar");
  level thread scene::play("cin_stakeout_street_bar_guy07", "loop_at_bar");
  wait 4;
  level scene::play("cin_stakeout_street_bar_guy07", "move_to_table");
  level thread scene::play("cin_stakeout_street_bar_guy07", "loop_at_table");
}

function function_cb866b85(skipto) {
  if(!isDefined(level.var_c0e9c7c4)) {
    level.var_c0e9c7c4 = doors::function_73f09315("bar_front_door");
  }

  if(!is_true(skipto)) {
    level.var_c0e9c7c4 thread function_b41a23bd();
    doors::waittill_door_opened("bar_front_door");
  }

  if(is_true(skipto)) {
    level flag::wait_till("flag_bar_ready");
    doors::function_f35467ac("bar_front_door");
  }

  level flag::set("player_opened_bar_door");
  level thread scene::play("cin_stakeout_street_bar_guys_playing_cards", "bar_entry");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_entry");
  namespace_5ceacc03::music("deactivate_5.0_kraus");
  level flag::wait_till("player_in_bar");

  if(!level flag::get("stealth_spotted")) {
    level flag::set("street_done");
  }
}

function function_b41a23bd() {
  level endon(#"game_ended");
  level endon(#"bar_bathroom_door_locked");

  while(true) {
    self waittill(#"trigger");
    level thread namespace_5ceacc03::function_106f9fd1();

    while(true) {
      distsquared = distance2dsquared(self.origin, getplayers()[0].origin);

      if(level flag::get("player_in_bar") && distsquared >= 16384) {
        doors::function_f35467ac("bar_front_door");
        doors::close("bar_front_door");
        level thread namespace_5ceacc03::Bar_Door_Close();
        level scene::stop("scene_z_stk_wall_umbrella_civs", 1);
        level scene::stop("scene_z_stk_wall_umbrella_civs2", 1);
        level thread function_d2de5ec5("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_01_bundle");
        level thread function_d2de5ec5("p9_fxanim_cp_stakeout_spotlights_rooftop_tower_03_bundle");
        level thread function_d2de5ec5("p9_fxanim_cp_stakeout_spotlights_rooftop_scripted_bundle");
        break;
      }

      waitframe(1);
      continue;
    }
  }
}

function function_6c634ee9() {
  var_6c634ee9 = getEntArray("bar_fan", "targetname");

  if(isDefined(var_6c634ee9)) {
    array::thread_all(var_6c634ee9, &namespace_11998b8f::function_638d18a, "bar_bathroom_door_locked", 3);
  }
}

function bar_dialogue_enter() {
  player = getplayers()[0];
  contact_convo_interact_org = struct::get("contact_convo_interact_org", "targetname");
  var_54a1c7b9 = util::spawn_model("tag_origin", contact_convo_interact_org.origin, contact_convo_interact_org.angles);
  var_54a1c7b9 util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_42f5f0e2657a29da", 64);
  var_54a1c7b9 waittill(#"trigger");
  player clearcinematicmotionoverride();
  level thread scene::add_scene_func("scene_z_stk_bar_street_raid", &function_3d51da22, "play");
  namespace_82bfe441::fade(1, "FadeImmediate");
  level thread function_a0a11086();
  doors::close("bar_bathroom_door");
  level flag::clear("close_bar_bathroom_door");
  player val::set("bar_dialogue", "ignoreme", 1);
  level thread function_394fb635();
  level flag::set("flag_found_contact");
  var_54a1c7b9 util::remove_cursor_hint();
  var_54a1c7b9 delete();
  player setstance("stand");
  level.var_d3081b95 show();
  level.var_bff9a427 show();
  doors::function_f35467ac("bar_front_door");
  doors::close("bar_front_door");
  level thread scene::play("cin_stakeout_wall_bar_enter", "bar_dialogue_enter");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_enter");
  level scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_enter");
  level thread scene::play("cin_stakeout_wall_bar_enter", "bar_dialogue_enter_loop");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_enter_loop");
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_enter_loop");
  player thread function_b1ab3cdd();
  player notifyonplayercommand("use_listening_device", "+actionslot 3");
  player notifyonplayercommand("use_listening_device", "+equip_toggle_actionslot 3");
  player waittill(#"use_listening_device");
  player notify(#"hide_listening_hint");
  level thread namespace_5ceacc03::police_build_up_bar();
  level thread scene::play("cin_stakeout_wall_bar_enter", "bar_dialogue_enter_finish");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_enter_finish");
  level scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_enter_finish");
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_idle");
  waitframe(1);
  level thread function_8c530932();
  var_30762b3e = dialog_tree::new_tree(undefined, undefined, 1);
  dialog_tree::function_21780fc5(var_30762b3e, array(240, 650));
  var_30762b3e dialog_tree::add_option(#"hash_e889328976eab5", undefined, undefined, undefined, 0, undefined, undefined, &bar_dialogue_choice_01);
  var_30762b3e dialog_tree::add_option(#"hash_e886328976e59c", undefined, undefined, undefined, 0, undefined, undefined, &bar_dialogue_choice_02);
  var_30762b3e dialog_tree::add_option(#"hash_e887328976e74f", undefined, undefined, undefined, 1, undefined, undefined, &function_2bf10776);
  level.var_30762b3e = var_30762b3e;
  level.var_1a913976 = dialog_tree::new_tree();
  dialog_tree::function_21780fc5(level.var_1a913976, array(240, 650));
  level.var_1a913976 dialog_tree::add_option(#"hash_204e8df950ad32a", undefined, undefined, undefined, 1, undefined, undefined, &function_f752e215);

  if(!player gamepadusedlast()) {
    player setviewclamp(20, 20, 20, 20, 0, 1, 0);
  }

  var_30762b3e dialog_tree::run(level.bar_contact, level.var_e8ddef56);

  if(!player gamepadusedlast()) {
    player setviewclamp(20, 20, 20, 20, 0, 0, 1);
  }
}

function function_b1ab3cdd() {
  self endon(#"hide_listening_hint");

  while(true) {
    self util::show_hint_text(#"hash_24324e9ec8e2335c", undefined, "hide_listening_hint", 8);
    wait 18;
  }
}

function function_8c530932() {
  level flag::wait_till_all(array("bar_dialog_choice_01_finished", "bar_dialog_choice_02_finished"));
  level flag::set("bar_conv_exit_unlocked");
}

function bar_dialogue_choice_01() {
  level flag::set("bar_dialog_choice_01_finished");
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_choice_01");
  waitframe(1);
  level.bar_contact flag::wait_till_clear(#"scriptedanim");
  level thread bar_dialogue_exit();
}

function bar_dialogue_choice_02() {
  level flag::set("bar_dialog_choice_02_finished");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_choice_02");
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_choice_02");
  waitframe(1);
  level.bar_contact flag::wait_till_clear(#"scriptedanim");
  level thread bar_dialogue_exit();
}

function function_2bf10776() {
  if(level flag::get("bar_dialog_choice_02_finished")) {
    level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_choice_04_02_finished");
  } else {
    level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_choice_04");
  }

  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_choice_04");
  level.var_ee1e1434 show();
  waitframe(1);
  level.var_ee1e1434 thread function_a96305d1();
  level.bar_contact flag::wait_till_clear(#"scriptedanim");
  player = getplayers()[0];

  if(!player gamepadusedlast()) {
    player setviewclamp(20, 20, 20, 20, 0, 1, 0);
  }

  level.var_1a913976 thread dialog_tree::run(level.bar_contact, level.var_e8ddef56);

  if(!player gamepadusedlast()) {
    player setviewclamp(20, 20, 20, 20, 0, 0, 1);
  }
}

function function_f752e215() {
  level thread namespace_4dc9a074::function_da707a70();
  level flag::set("learned_about_alley_stasi_field_house");
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_choice_04a");
  waitframe(1);
  level.bar_contact flag::wait_till_clear(#"scriptedanim");
  level thread bar_dialogue_exit();

  if(!level flag::get("bar_dialog_choice_01_finished") || !level flag::get("bar_dialog_choice_02_finished") || !level flag::get("learned_about_alley_stasi_field_house")) {
    player = getplayers()[0];

    if(!player gamepadusedlast()) {
      player setviewclamp(20, 20, 20, 20, 0, 1, 0);
    }

    level.var_30762b3e thread dialog_tree::run(level.bar_contact, level.var_e8ddef56);

    if(!player gamepadusedlast()) {
      player setviewclamp(20, 20, 20, 20, 0, 0, 1);
    }
  }
}

function bar_dialogue_exit() {
  if(!level flag::get("bar_dialog_choice_01_finished")) {
    return;
  }

  if(!level flag::get("bar_dialog_choice_02_finished")) {
    return;
  }

  if(!level flag::get("learned_about_alley_stasi_field_house")) {
    return;
  }

  level flag::set("bar_exit_starting");
  wait 0.5;
  level.bar_officer01 = spawner::simple_spawn_single("bar_officer01");
  level.bar_officer02 = spawner::simple_spawn_single("bar_officer02");
  level.bar_officer01.holdfire = 1;
  level.bar_officer02.holdfire = 1;
  level.bar_officer01.var_c5553760 = 1;
  level.bar_officer02.var_c5553760 = 1;
  level.bar_informer = spawner::simple_spawn_single("bar_informer");
  level.bar_informer setModel(#"hash_322f09f6c1be19d5");
  namespace_5ceacc03::music("6.0_incoming", 3);
  level thread namespace_5ceacc03::bar_incoming();
  level flag::set("flag_bar_dialogue_exit");
  level thread scene::play("cin_stakeout_wall_bar_enter", "bar_dialogue_exit", array(level.kraus, level.kraus.briefcase));
  level thread scene::play("cin_stakeout_street_bar_ladies_loop", "bar_dialogue_exit");
  level thread scene::play("cin_stakeout_street_bar_guys", "bar_dialogue_exit");
  level thread scene::play("cin_stakeout_street_bar_guy07", "bar_dialogue_exit");
  level thread scene::play("cin_stakeout_street_bar_guys_playing_cards", "bar_dialogue_exit");
  waitframe(1);
  level thread function_bf0b5031();
  level thread function_4bb16d5();
  level thread scene::play("cin_stakeout_street_bar_contact", "bar_dialogue_exit");
  doors::unlock("bar_bathroom_door", undefined, 0);
  player = getplayers()[0];
  player flag::wait_till_clear(#"scriptedanim");
  savegame::checkpoint_save(1);
  player val::reset("bar_dialogue", "ignoreme");
  player setcinematicmotionoverride("cinematicmotion_kgb");
  level namespace_979752dc::function_2324f175(1);
  level.bar_officer01 thread namespace_acaa3a2e::function_fadf5523("bar");
  level.bar_officer02 thread namespace_acaa3a2e::function_fadf5523("bar");

  if(isDefined(level.var_bff9a427)) {
    level.var_bff9a427 delete();
  }

  wait 5;
  level.bar_officer01 val::reset("bar", "ignoreall");
  level.bar_officer02 val::reset("bar", "ignoreall");
}

function function_bf0b5031() {
  player = getplayers()[0];
  player val::set("alley1", "allow_melee", 0);
  player val::set("alley1", "allow_sprint", 0);
  player waittill(#"hash_6b37ff1b3eda2e5f");
  player notify(#"hash_52a4e28df0e31dc1");
}

function function_394fb635() {
  getplayers()[0] clientfield::set_to_player("lerp_fov", 3);
  getplayers()[0] waittill(#"hash_6373a88215561f04");
  getplayers()[0] waittill(#"hash_6b37ff1b3eda2e5f");
  getplayers()[0] clientfield::set_to_player("lerp_fov", 4);
}

function function_a96305d1() {
  self endon(#"death");
  self flag::wait_till_clear(#"scriptedanim");

  if(isDefined(self)) {
    self delete();
  }
}

function function_3df63143(params) {
  level thread scene::play("scene_z_stk_bar_street_raid");
}

function function_3d51da22(a_ents) {
  e_car = a_ents[#"car1"];
  e_car clientfield::set("constraint_toggle_field", 1);
  e_car thread cp_ger_stakeout_fx::function_93e3e68a(1);
  e_car thread cp_ger_stakeout_fx::function_ad03f35b(1);
  level flag::wait_till("bar_bathroom_door_locked");
  e_car thread cp_ger_stakeout_fx::function_93e3e68a();
  e_car thread cp_ger_stakeout_fx::function_ad03f35b();
  thread namespace_5ceacc03::end_bar_door_police_amb();
}

function function_4bb16d5() {
  getplayers()[0] flag::wait_till_clear(#"scriptedanim");
  level flag::set("bar_done");
}

function function_7691a965() {
  level endon(#"get_to_safehouse_meetup_breadcrumb_01_org_reached");
  wait 2;
  bar_bathroom_audio_org = struct::get("bar_bathroom_audio_org", "targetname");
  org = bar_bathroom_audio_org.origin;
  wait 2;

  while(true) {
    var_500e35ed = playsoundatposition("vox_cp_stkt_06600_gms1_openupthisisthe_2c", org);
    wait randomfloatrange(1, 4);
    var_1cd886c0 = playsoundatposition("evt_stk_apt_door_pound", org);

    if(level flag::get("get_to_safehouse_meetup_breadcrumb_01_org_reached")) {
      return;
    }

    wait randomfloatrange(2, 5);
    var_500e35ed = playsoundatposition("vox_cp_stkt_06600_gms1_openthisdoornow_ee", org);
    wait randomfloatrange(2, 5);
    var_1cd886c0 = playsoundatposition("evt_stk_apt_door_pound", org);

    if(level flag::get("get_to_safehouse_meetup_breadcrumb_01_org_reached")) {
      return;
    }

    wait randomfloatrange(2, 5);
    var_500e35ed = playsoundatposition("vox_cp_stkt_06600_gms1_doyouhearmeopen_29", org);
    wait randomfloatrange(2, 5);
    var_1cd886c0 = playsoundatposition("evt_stk_apt_door_pound", org);

    if(level flag::get("get_to_safehouse_meetup_breadcrumb_01_org_reached")) {
      return;
    }

    wait randomfloatrange(2, 5);
    var_500e35ed = playsoundatposition("vox_cp_stkt_06600_gms1_unlockthisdoori_ed", org);
    wait randomfloatrange(2, 5);
    var_1cd886c0 = playsoundatposition("evt_stk_apt_door_pound", org);

    if(level flag::get("get_to_safehouse_meetup_breadcrumb_01_org_reached")) {
      return;
    }

    wait randomfloatrange(2, 5);
    var_500e35ed = playsoundatposition("vox_cp_stkt_06600_gms1_iorderyoutocome_26", org);
    wait randomfloatrange(2, 5);
    var_1cd886c0 = playsoundatposition("evt_stk_apt_door_pound", org);

    if(level flag::get("get_to_safehouse_meetup_breadcrumb_01_org_reached")) {
      return;
    }
  }
}

function function_4b0934d0() {
  level endon(#"player_opened_bar_door");
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06250_adlr_gotothebarandme_d3";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06250_adlr_gettothemeeting_66";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06250_adlr_bellthecontacts_16";
  var_1ee7233e = [];
  var_1ee7233e[var_1ee7233e.size] = "vox_cp_stkt_06250_adlr_gotothebarandme_d3_1";
  var_1ee7233e[var_1ee7233e.size] = "vox_cp_stkt_06250_adlr_gettothemeeting_66_1";
  var_1ee7233e[var_1ee7233e.size] = "vox_cp_stkt_06250_adlr_bellthecontacts_16_1";
  e_vol = getent("vol_street_in_talk_range", "targetname");
  player = getplayers()[0];
  start_time = gettime();

  while(true) {
    cur_time = gettime();
    var_a486489a = 25000 - cur_time - start_time;

    if(var_a486489a <= 0) {
      var_a486489a = 25000;
      start_time = gettime();
    }

    var_a486489a /= 1000;

    if(player istouching(e_vol)) {
      level notify(#"stop_street_radio_nag");
      level.adler thread namespace_11998b8f::function_ec76072d(var_a486489a, var_38d138fb, 30, "player_opened_bar_door", "stop_street_vo_nag");

      while(player istouching(e_vol)) {
        waitframe(1);
      }

      continue;
    }

    level notify(#"stop_street_vo_nag");
    level thread namespace_11998b8f::function_ec76072d(var_a486489a, var_1ee7233e, 30, "player_opened_bar_door", "stop_street_radio_nag");

    while(!player istouching(e_vol)) {
      waitframe(1);
    }
  }
}

function function_82814d33() {
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06280_adlr_bellfindthecont_e7";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06280_adlr_thecontacthasab_54";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_06280_adlr_belllookfortheb_b2";
  namespace_11998b8f::function_ec76072d(15, var_38d138fb, 22, "flag_found_contact");
}

function function_1b06b6df() {
  level.var_b946e46d endon(#"death");
  level.var_ab91c903 endon(#"death");
  level.var_425c76da endon(#"death");

  while(true) {
    level.var_ab91c903 dialogue::queue("vox_cp_stkt_06255_gmc1_howdidyourdatew_bd");
    level.var_425c76da dialogue::queue("vox_cp_stkt_06255_gmc2_itwasfinewehadd_5d");
    level.var_b946e46d dialogue::queue("vox_cp_stkt_06255_gmc3_youwentonadatew_b8");
    level.var_425c76da dialogue::queue("vox_cp_stkt_06255_gmc2_imnotgoingtotel_8d");
    level.var_ab91c903 dialogue::queue("vox_cp_stkt_06255_gmc1_ahsosomethingdi_13");
    level.var_425c76da dialogue::queue("vox_cp_stkt_06255_gmc2_sabinesanicegir_9d");
    level.var_b946e46d dialogue::queue("vox_cp_stkt_06255_gmc3_ohyeahsabinesni_0e");
    level.var_425c76da dialogue::queue("vox_cp_stkt_06255_gmc2_heydonttalkabou_4c");
    level.var_ab91c903 dialogue::queue("vox_cp_stkt_06255_gmc1_finefinedidyoug_c6");
    level.var_425c76da dialogue::queue("vox_cp_stkt_06255_gmc2_yeahweregoingou_20");
    level.var_b946e46d dialogue::queue("vox_cp_stkt_06255_gmc3_heycongratsbeat_db");
    wait 3;
  }
}

function function_464221cf() {
  level endon(#"bar_exit_starting");
  wait 3;
  party = [];
  party[party.size] = ["gmc3", level.var_f249468f];
  party[party.size] = ["gfc1", level.var_5b216319];
  convo = [];
  convo[convo.size] = "vox_cp_stkt_06262_gmc3_hannahwhysosady_72";
  convo[convo.size] = 1.6;
  convo[convo.size] = "vox_cp_stkt_06262_gfc1_idontknowiguess_8c";
  convo[convo.size] = 0.6;
  convo[convo.size] = "vox_cp_stkt_06262_gmc3_youneedtostopli_08";
  convo[convo.size] = 0.3;
  convo[convo.size] = "vox_cp_stkt_06262_gfc1_isit_9f";
  convo[convo.size] = 1.25;
  convo[convo.size] = "vox_cp_stkt_06262_gmc3_illdigourfamily_16";
  convo[convo.size] = 0.4;
  convo[convo.size] = "vox_cp_stkt_06262_gfc1_nowyourepatroni_81";
  convo[convo.size] = 1.75;
  convo[convo.size] = "vox_cp_stkt_06262_gmc3_thisweekletsjus_c9";
  convo[convo.size] = 12;
  level thread namespace_c80e7f5f::function_f29bdbdf(party, convo, 1, "bar_exit_starting");
}