/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_79e60fd0034306f4.gsc
***********************************************/

#using script_11d98532ca8f6c58;
#using script_2d443451ce681a;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4ab78e327b76395f;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using script_9bfd3d8a6a89e5e;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\perks;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace namespace_f8073734;

function init_flags() {
  level flag::init("warehouse_intro_opening_vo_done");
  level flag::init("kill_greta");
  level flag::init("warehouse_intro_ai_rappelling");
  level flag::init("warehouse_intro_park_goal_reached");
  level flag::init("warehouse_intro_give_player_gun");
  level flag::init("warehouse_dialog_end_a");
  level flag::init("warehouse_dialog_end_b");
}

function intro_start(str_objective) {
  level.var_375ea1c1 = spawner::simple_spawn_single("warehouse_volkov");
}

function intro_main(str_objective, var_50cc0d4f) {
  if(var_50cc0d4f) {
    clientfield::set("force_stream_warehouse", 1);
  }

  util::function_3e65fe0b(1);
  level.player val::set("wake_up", "show_weapon_hud", 0);
  exploder::exploder("fx_exp_moon_card");
  util::streamer_wait(undefined, 2, 10);
  level thread function_ea2f2e25();
  level scene::init("p9_fxanim_cp_stakeout_elevated_train_01_bundle");
  level flag::set("no_corpse_pickup ");
  level notify(#"hash_617ae3084a75a5b0");
  util::function_268bdf4f("park");
  level.lazar = spawner::simple_spawn_single("warehouse_lazar");
  level.lazar.is_hero = 1;
  level.lazar util::magic_bullet_shield();
  level.adler = spawner::simple_spawn_single("warehouse_adler");
  level.adler.is_hero = 1;
  level.adler util::magic_bullet_shield();
  level thread function_e807f2c6();
  level thread function_639f072c();
  level thread function_131f5dc5();
  level thread function_677b97d8("park_window_grenade", "glass_park", "park_window_shatter");
  level thread function_677b97d8("lazar_window_grenade", "glass_lazar", "lazar_window_shatter");
  level thread function_677b97d8("adler_window_grenade", "glass_adler", "adler_window_shatter");
  level thread function_853aef38();
  level flag::wait_till("warehouse_intro_done");
  clientfield::set("force_stream_warehouse", 0);
  util::function_3e65fe0b(0);
  skipto::function_4e3ab877("warehouse_intro");
}

function intro_catchup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  clientfield::set("cull_rear_warehouse", 1);
}

function function_e807f2c6() {
  level endon(#"mission_failed");
  namespace_11998b8f::stakeout_stow_weapon();
  level waittill(#"hash_7c33da3b415e547d");
  clientfield::set("cull_rear_warehouse", 1);
  level flag::set("warehouse_give_player_weapon");
  level.player val::set("wake_up", "show_weapon_hud", 1);
  level.player val::set("knock_out", "show_crosshair", 1);
  namespace_11998b8f::function_cdb7cc7e();
  namespace_11998b8f::function_a73e6a64();
}

function function_dfdd2f82() {
  level thread namespace_82bfe441::fade(0, "FadeImmediate");
}

function function_aba6a2e8() {
  level.adler colors::set_force_color("b");
  level.lazar colors::set_force_color("g");
  level.park colors::set_force_color("r");
}

function function_94c482e0() {
  level endon(#"mission_failed");
  warehouse_door_to_meeting = doors::get_doors("warehouse_door_to_meeting")[0];
  lock_doors = [];
  warehouse_entrance_door = doors::get_doors("warehouse_entrance_door")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_entrance_door;
  var_195859c8 = doors::get_doors("warehouse_door_to_exit_room")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = var_195859c8;
  warehouse_spawn_closet_door_upper = doors::get_doors("warehouse_spawn_closet_door_upper")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_spawn_closet_door_upper;
  warehouse_spawn_closet_door = doors::get_doors("warehouse_spawn_closet_door")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_spawn_closet_door;

  foreach(door in lock_doors) {
    door doors::lock();
  }
}

function function_131f5dc5() {
  level flag::wait_till("level_is_go");
  waitframe(1);
  player = getplayers()[0];
  player val::reset("apartment_to_warehouse", "freezecontrols");
  level battlechatter::function_2ab9360b(0);
  level.adler val::set("warehouse_intro", "ignoreme", 1);
  level.lazar val::set("warehouse_intro", "ignoreme", 1);
  level.park val::set("warehouse_intro", "ignoreme", 1);
  level thread function_3eeef9bb();
  player.animname = "player 1";
  level.adler.animname = "adler";
  level.lazar.animname = "lazar";
  level.park.animname = "park";
  level thread function_44f6ffee();
  level thread function_66685f();
  var_84ccdeed = # "hash_57683ed4de0128fe";
  var_3997c880 = # "hash_57683dd4de01274b";
  var_1fd89502 = # "hash_57683cd4de012598";
  var_4419dea4 = # "hash_576c66d4de0555cd";
  var_4dcbf208 = # "hash_576c63d4de0550b4";
  var_d98d098c = # "hash_576c64d4de055267";
  level.var_27da2f39 = dialog_tree::new_tree(&function_cddf31f8, undefined, 1, 1, "scene_z_stk_warehouse_dt");
  level.var_27da2f39 dialog_tree::add_option(var_84ccdeed, undefined, "fu_response", "loop", 1, undefined, undefined, &function_f23b762a);
  level.var_27da2f39 dialog_tree::add_option(var_3997c880, undefined, "eliminate_u_response", "loop", 1, undefined, undefined, &function_e31e5b0e);
  level.var_27da2f39 dialog_tree::add_option(var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3);
  level.var_58759087 = dialog_tree::new_tree(undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt");
  level.var_58759087 dialog_tree::add_option(var_3997c880, undefined, "eliminate_u_response", "loop", 1, undefined, undefined, &function_e31e5b0e);
  level.var_58759087 dialog_tree::add_option(var_4419dea4, undefined, undefined, undefined, 1, undefined, undefined, &warehouse_dialog_end_b);
  level.var_58759087 dialog_tree::add_option(var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3);
  level.var_4a3df400 = dialog_tree::new_tree(undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt");
  level.var_4a3df400 dialog_tree::add_option(var_84ccdeed, undefined, undefined, undefined, 1, undefined, undefined, &warehouse_dialog_end_b);
  level.var_4a3df400 dialog_tree::add_option(var_4dcbf208, undefined, "smuggling_nukes_response", "loop", 1, undefined, undefined, &function_acd56d69);
  level.var_4a3df400 dialog_tree::add_option(var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3);
  level.var_cb1375a9 = dialog_tree::new_tree(undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt");
  level.var_cb1375a9 dialog_tree::add_option(var_d98d098c, undefined, "tell_me_where_response", "loop", 1, undefined, undefined, &function_971341e5);
  level.var_cb1375a9 dialog_tree::add_option(var_3997c880, undefined, undefined, undefined, 1, undefined, undefined, &warehouse_dialog_end_a);
  level.var_375ea1c1 val::set("warehouse", "ignoreme", 1);
  level.var_375ea1c1 val::set("warehouse", "ignoreall", 1);
  level.var_27da2f39 dialog_tree::run(level.var_375ea1c1, undefined, undefined, undefined, 1);
}

function function_44f6ffee() {
  player = getplayers()[0];

  if(!player player_decision::function_2da4c32c()) {
    level.var_66d09511 = getent("warehouse_informant", "targetname", 1);
    scene::play("scene_z_stk_warehouse_dt_informant", "intro_start");
    scene::play("scene_z_stk_warehouse_dt_informant", "intro_info");
    scene::play("scene_z_stk_warehouse_dt_informant", "intro_end");
    level thread scene::play("scene_z_stk_warehouse_dt_informant", "loop");
    level flag::wait_till_any(array("warehouse_dialog_end_a", "warehouse_dialog_end_b"));
    level scene::play("scene_z_stk_warehouse_dt_informant", "end");

    if(isDefined(level.var_66d09511) && isalive(level.var_66d09511)) {
      level.var_66d09511 delete();
    }
  }
}

function function_66685f() {
  player = getplayers()[0];
  level.var_ffeb9413 = getent("warehouse_greta", "targetname", 1);
  scene::play("scene_z_stk_warehouse_dt_greta", "intro_start");

  if(!player player_decision::function_2da4c32c()) {
    scene::play("scene_z_stk_warehouse_dt_greta", "intro_info");
  }

  scene::play("scene_z_stk_warehouse_dt_greta", "intro_end");
  level thread scene::play("scene_z_stk_warehouse_dt_greta", "loop");
  level thread function_e736d047();
  level flag::wait_till_any(array("warehouse_dialog_end_a", "warehouse_dialog_end_b"));

  if(!level flag::get("kill_greta")) {
    level scene::play("scene_z_stk_warehouse_dt_greta", "end");
    level thread scene::play("scene_z_stk_warehouse_dt_greta", "loop");
    player_decision::function_b95efbcd(0);
  }
}

function function_e736d047() {
  level flag::wait_till("kill_greta");
  level scene::play("scene_z_stk_warehouse_dt_greta", "fu_response");
  level thread scene::play("scene_z_stk_warehouse_dt_greta", "dead_loop");
  player_decision::function_b95efbcd(1);
}

function function_cddf31f8() {
  player = getplayers()[0];
  level thread function_bae99775();
  scene::play("scene_z_stk_warehouse_dt", "intro_start");

  if(!player player_decision::function_2da4c32c()) {
    scene::play("scene_z_stk_warehouse_dt", "intro_info");
  }

  scene::play("scene_z_stk_warehouse_dt", "intro_end");
  level thread scene::play("scene_z_stk_warehouse_dt", "loop");
}

function function_bae99775() {
  namespace_5ceacc03::music("15.0_captured");
  level waittill(#"intro_end");
  namespace_5ceacc03::music("15.1_volkov");
  level waittill(#"hash_199ad0e08497b811");
  namespace_5ceacc03::music("16.0_finale");
}

function function_3eeef9bb() {
  level.park waittill(#"end_vo");

  if(!level flag::get("kill_greta")) {
    level.park dialogue::queue("vox_cp_stkt_13400_park_illhelpherandse_c4");
  } else {
    level.park dialogue::queue("vox_cp_stkt_13400_park_illsecurethecas_49");
  }

  level thread function_c63cd141();
  level flag::set("warehouse_intro_opening_vo_done");
  level flag::set("warehouse_intro_done");
}

function function_f23b762a() {
  level flag::set("kill_greta");
  level.var_375ea1c1 waittill(#"hash_12324459eb2bc76d");
  level.var_58759087 thread dialog_tree::run(level.var_375ea1c1, undefined, undefined, undefined, 1);
}

function function_e31e5b0e() {
  level.var_375ea1c1 waittill(#"hash_12324459eb2bc76d");
  level.var_4a3df400 thread dialog_tree::run(level.var_375ea1c1, undefined, undefined, undefined, 1);
}

function function_1a6949a3() {
  level.var_375ea1c1 waittill(#"hash_12324459eb2bc76d");
  level.var_cb1375a9 thread dialog_tree::run(level.var_375ea1c1, undefined, undefined, undefined, 1);
}

function function_acd56d69() {
  level.var_375ea1c1 waittill(#"hash_12324459eb2bc76d");
  waitframe(1);
  level thread warehouse_dialog_end_a();
}

function function_971341e5() {
  level.var_375ea1c1 waittill(#"hash_12324459eb2bc76d");
  waitframe(1);
  level warehouse_dialog_end_a();
}

function warehouse_dialog_end_a() {
  level flag::set("warehouse_dialog_end_a");
  level thread function_dc4b560d();
  level thread function_55053e9d();
  level thread function_c6040f8a();
}

function function_c6040f8a() {
  level.var_375ea1c1 scene::play("scene_z_stk_warehouse_dt", "end");
  level.var_375ea1c1 thread scene::play("scene_z_stk_warehouse_dt", "end_loop");
}

function function_55053e9d() {
  level.var_375ea1c1 endon(#"death");
  level thread function_9bb56737();
  level waittill(#"hash_461a0b970870b723");
  level.var_375ea1c1 thread dialogue::queue("vox_cp_stkt_13300_vlkv_youhavefailedno_66");
  level waittill(#"hash_461a0c970870b8d6");
  level.var_375ea1c1 thread dialogue::queue("vox_cp_stkt_13300_vlkv_onlyagravecancu_ef");
  level.var_375ea1c1 thread function_c51f0606();
}

function warehouse_dialog_end_b() {
  level flag::set("warehouse_dialog_end_b");
  level thread function_dc4b560d();
  level thread function_49876c2();
  level thread function_c6040f8a();
}

function function_49876c2() {
  level.var_375ea1c1 endon(#"death");
  level thread function_9bb56737();
  level waittill(#"hash_15d0f8b2beeedb58");
  level.var_375ea1c1 thread dialogue::queue("vox_cp_stkt_13300_vlkv_idonotlikespies_fe");
  level waittill(#"hash_15d0fbb2beeee071");
  level.var_375ea1c1 thread dialogue::queue("vox_cp_stkt_13300_vlkv_doyouthinkyouwi_0c");
  level waittill(#"hash_15d0fab2beeedebe");
  level.var_375ea1c1 thread dialogue::queue("vox_cp_stkt_13300_vlkv_youredamagedgoo_97");
  level.var_375ea1c1 thread function_c51f0606();
}

function function_c63cd141() {
  level thread function_aba6a2e8();
  waitframe(1);
  trigger::use("warehouse_intro_ally_move_01", "targetname");
  level.adler val::set("warehouse_intro", "ignoreall", 0);
  level.adler val::set("warehouse_intro", "ignoreme", 0);
  level.lazar val::set("warehouse_intro", "ignoreall", 0);
  level.lazar val::set("warehouse_intro", "ignoreme", 0);
}

function function_1f6e9d44() {
  player = getplayers()[0];
  self ai::set_behavior_attribute("demeanor", "combat");
}

function function_dc4b560d() {
  level waittill(#"hash_2399d9df0270889e");
  level thread function_332986a1("park_window_shatter", "warehouse_intro_gas_park_start", "warehouse_intro_gas_park_end");
  level thread function_332986a1("lazar_window_shatter", "warehouse_intro_gas_lazar_start", "warehouse_intro_gas_lazar_end");
  level thread function_332986a1("adler_window_shatter", "warehouse_intro_gas_adler_start", "warehouse_intro_gas_adler_end");
  wait 4;
  exploder::exploder("temp_warehouse_smoke");
}

function function_332986a1(break_notify, var_8c04d509, var_ada1e239) {
  level waittill(break_notify);
  var_af827872 = getent(var_8c04d509, "targetname");
  var_af2e70d5 = getent(var_ada1e239, "targetname");
  magicbullet(getweapon(#"pistol_semiauto_t9", "suppressed"), var_af827872.origin, var_af2e70d5.origin);
}

function function_677b97d8(var_ef943c8, var_2d29a1e2, var_79efa269) {
  decal = getent(var_2d29a1e2, "targetname");
  decal hide();
  level waittill(var_ef943c8);
  decal show();
  level waittill(var_79efa269);
  decal delete();
}

function function_c51f0606() {
  self endon(#"death");
  level waittill(#"hash_2c8fbda941438cbe");

  if(isDefined(self)) {
    self val::set("warehouse", "ignoreme", 1);
    self val::set("warehouse", "ignoreall", 1);
    self setCanDamage(0);
    self ai::set_behavior_attribute("demeanor", "combat");
    self thread function_1de6c9b7();
  }
}

function function_1de6c9b7() {
  self endon(#"death");

  if(isDefined(self) && isalive(self)) {
    self clearforcedgoal();
    waitframe(1);
    node = getnode("warehouse_outro_volkov_end_pos", "targetname");
    self forceteleport(node.origin, node.angles);
    self setgoal(node, 1);
    self.fixednode = 1;
  }
}

function function_9bb56737() {
  level waittill(#"hash_758faf8962d0ec61");
  savegame::function_7790f03();
}

function function_853aef38() {
  level flag::wait_till_any(array("warehouse_dialog_end_a", "warehouse_dialog_end_b"));
  level thread scene::play_from_time("p9_fxanim_cp_stakeout_elevated_train_01_bundle", undefined, undefined, 0.2);
}

function start(str_objective) {
  util::function_268bdf4f("park");
  level flag::set("warehouse_intro_done");
  level flag::set("warehouse_give_player_weapon");
  exploder::exploder("fx_exp_moon_card");
  level.lazar = spawner::simple_spawn_single("warehouse_lazar");
  level.lazar.is_hero = 1;
  level.lazar util::magic_bullet_shield();
  level.adler = spawner::simple_spawn_single("warehouse_adler");
  level.adler.is_hero = 1;
  level.adler util::magic_bullet_shield();
  level.adler thread function_ef769f0d("warehouse_combat_adler_start_node");
  level.lazar thread function_ef769f0d("warehouse_combat_lazar_start_node");
  level thread scene::play("scene_z_stk_warehouse_dt", "end_loop");
  level flag::set("no_corpse_pickup ");
  level thread function_639f072c();
  level.var_375ea1c1 = spawner::simple_spawn_single("warehouse_volkov");
  waitframe(1);
  level.lazar clearforcedgoal();
  level.adler clearforcedgoal();
  level.park clearforcedgoal();
  level.park val::set("warehouse_combat", "ignoreall", 1);
  level thread function_aba6a2e8();
  level.var_375ea1c1 = getent("warehouse_volkov", "targetname", 1);
  level.var_375ea1c1 thread function_ef769f0d("warehouse_outro_volkov_end_pos");
  level.var_375ea1c1 setCanDamage(0);
  level.park thread function_ef769f0d("warehouse_combat_park_node");
  wait 2;
  trigger::use("warehouse_intro_ally_move_01", "targetname");
  exploder::exploder("temp_warehouse_smoke");
  music::setmusicstate("16.0_finale");
}

function function_a0f6825d() {
  level scene::play_from_time("scene_z_stk_warehouse_dt_greta", "fu_response", undefined, 0.9, 1, 1, 0, 1);
  level thread scene::play("scene_z_stk_warehouse_dt_greta", "dead_loop");
}

function main(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    namespace_5ceacc03::music("16.0_finale");
    tag_align = struct::get("tag_align_warehouse_start", "targetname");
    briefcase = getent("warehouse_briefcase", "targetname");
    briefcase useanimtree("generic");
    kraus = spawner::simple_spawn_single("warehouse_kraus");
    kraus.a.nodeath = 1;
    briefcase animation::last_frame(#"hash_5eb2470e4963bb6", tag_align);
    kraus animation::last_frame(#"hash_5346029e070611a6", tag_align);
    kraus kill();

    if(player player_decision::function_733a5c27()) {
      level thread function_a0f6825d();
    } else {
      level thread scene::play("scene_z_stk_warehouse_dt_greta", "loop");
    }
  }

  level thread function_55737f44();
  level thread function_59e47159();
  level.park.holdfire = 1;
  level.adler ai::enable_careful();
  level.lazar ai::enable_careful();
  level.adler.script_accuracy = 0.2;
  level.lazar.script_accuracy = 0.2;
  level.adler.ignoresuppression = 1;
  level.lazar.ignoresuppression = 1;
  createthreatbiasgroup("allies");
  createthreatbiasgroup("player");
  createthreatbiasgroup("warehouse_enemies");
  getplayers()[0] setthreatbiasgroup("player");
  level.adler setthreatbiasgroup("allies");
  level.lazar setthreatbiasgroup("allies");
  level thread scene::init("scene_z_stk_warehouse_door_kick");
  level thread function_ad178f3f();
  level thread function_e47b21fa();
  level thread function_2525ab9b();
  level thread warehouse_combat();
  level thread function_2f72365();
  level flag::wait_till("flag_warehouse_outro_door");
  skipto::function_4e3ab877("warehouse");
  getplayers()[0] namespace_6cecf2d8::function_9fa1a484();
}

function function_ad178f3f() {
  player = getplayers()[0];
  objectives::scripted(#"kill_or_capture_obj", undefined, #"hash_1c73a293c174c216");
  wait 0.5;
  var_f8d522f5 = struct::get("obj_outro_door_pos", "targetname");
  objectives::goto(#"outro_door", var_f8d522f5);
  level flag::wait_till("flag_warehouse_combat_vo");
  id = objectives::function_285e460(#"outro_door", var_f8d522f5);
  thread objectives_ui::function_f3ac479c(id);
  player thread objectives_ui::show_objectives();
  level flag::wait_till("flag_warehouse_outro_door");
  objectives::remove(#"kill_or_capture_obj");
  objectives::remove(#"outro_door", var_f8d522f5);
}

function warehouse_combat() {
  level battlechatter::function_2ab9360b(1);
  level thread function_85177212();
  level thread function_2cc3a1be();
  level thread function_be7a4072();
  level thread function_cfbae19c("flag_spawn_wave_01a_player_seek", "warehouse_retreat_enemy_1", "warehouse_enemy_playerseek_01a");
  level thread function_cfbae19c("flag_spawn_wave_01b_player_seek", "warehouse_retreat_enemy_1", "warehouse_enemy_playerseek_01b");
  level thread function_cfbae19c("flag_spawn_wave_02a_player_seek", "warehouse_retreat_enemy_2", "warehouse_enemy_playerseek_02a");
  level thread function_cfbae19c("flag_spawn_wave_02b_player_seek", "warehouse_retreat_enemy_2", "warehouse_enemy_playerseek_02b");
  level thread function_cfbae19c("flag_spawn_wave_03_player_seek", undefined, "warehouse_enemy_playerseek_03");
  level thread function_5b10af6b();
  flag::wait_till_any_timeout(1, ["flag_start_forklift_event", "flag_start_lazar_event"]);
  wave1_enemies = spawner::simple_spawn("warehouse_enemy_wave_01", &function_f471eec0);
  level thread ai::function_b0bd06fa("warehouse_enemies", 3, "warehouse_retreat_enemy_1");
  level flag::wait_till("warehouse_retreat_enemy_1");
  savegame::checkpoint_save();
  waitframe(1);
  level thread function_a099daab("warehouse_ally_move_01");
  level flag::set("warehouse_spawn_wave_02_br");
  wave2_enemies = spawner::simple_spawn("warehouse_enemy_wave_02", &function_f471eec0);
  level thread ai::function_b0bd06fa("warehouse_enemies", 4, "warehouse_retreat_enemy_2");
  level flag::wait_till("warehouse_retreat_enemy_2");
  savegame::checkpoint_save();
  waitframe(1);
  enemies = spawner::get_ai_group_ai("warehouse_enemies");
  var_b6d2a469 = array::random(enemies);

  if(isDefined(var_b6d2a469) && isalive(var_b6d2a469)) {
    var_b6d2a469 ai::set_goal("warehouse_enemy_vol_03_catwalk", "targetname", 1);
  }

  level thread function_a099daab("warehouse_ally_move_03");
  level thread function_a2c72e4b("warehouse_ally_move_01", "warehouse_retreat_enemy_2");
  level thread function_a2c72e4b("warehouse_ally_move_02", "warehouse_retreat_enemy_2");
  var_25dc55fa = spawner::simple_spawn("warehouse_enemy_wave_03", &function_f471eec0);
  level thread ai::function_b0bd06fa("warehouse_enemies", 3, "warehouse_retreat_enemy_3");
  level thread function_db469dbf();
  level flag::wait_till("warehouse_retreat_enemy_3");
  savegame::checkpoint_save();
  waitframe(1);
  level thread function_a099daab("warehouse_ally_move_06");
  level thread function_a2c72e4b("warehouse_ally_move_04", "warehouse_retreat_enemy_3");
  level thread function_a2c72e4b("warehouse_ally_move_05", "warehouse_retreat_enemy_3");
  var_1cb07350 = spawner::simple_spawn("warehouse_enemy_wave_04", &function_f471eec0);
  level thread function_57e42128();
  level thread ai::function_b0bd06fa("warehouse_enemies", 3, "warehouse_retreat_enemy_final");
  flag::wait_till_any_timeout(30, array("warehouse_retreat_enemy_final", "flag_warehouse_enemy_cleanup"));
  savegame::checkpoint_save();
  level thread function_4112631f();
  level thread function_592bf7fa();
  level thread ai::function_b0bd06fa("warehouse_enemies", 0, "warehouse_combat_over");
  flag::wait_till_timeout(5, "warehouse_combat_over");

  if(isDefined(level.adler) && isalive(level.adler)) {
    level.adler.script_accuracy = 100;
    level.adler.perfectaim = 1;
    level.adler.ignoresuppression = 1;
  }

  if(isDefined(level.lazar) && isalive(level.lazar)) {
    level.lazar.script_accuracy = 100;
    level.lazar.perfectaim = 1;
    level.lazar.ignoresuppression = 1;
  }

  level thread function_3266ad2c();
}

function function_2f72365() {
  level endon(#"flag_warehouse_outro_door");
  wait 6;

  while(true) {
    savegame::checkpoint_save(0);
    wait 20;
  }
}

function function_db469dbf() {
  level flag::wait_till("warehouse_retreat_catwalk_enemies");
  namespace_11998b8f::function_d0551a1b("warehouse_enemy_vol_03_catwalk", "warehouse_enemy_vol_04", 1, 2);
}

function function_cfbae19c(var_28c216f0, disable_flag, seekers) {
  if(isDefined(disable_flag)) {
    level endon(disable_flag);
  }

  level flag::wait_till(var_28c216f0);
  var_897f3268 = spawner::simple_spawn(seekers, &function_73b1f5c7);
}

function function_ef769f0d(teleport_node) {
  node = getnode(teleport_node, "targetname");
  self forceteleport(node.origin, node.angles);
  self setgoal(node, 1);
}

function function_85177212() {
  level endon(#"warehouse_kill_bathroom_event");
  player = getplayers()[0];
  level flag::wait_till("flag_warehouse_toilet_enemy");
  wait 0.5;
  namespace_5ceacc03::function_875a6922();

  if(!level flag::get("warehouse_kill_bathroom_event")) {
    var_791550cf = spawner::simple_spawn_single("warehouse_enemy_toilet", &function_f471eec0);

    if(isDefined(var_791550cf) && isalive(var_791550cf)) {
      if(isDefined(player) && isalive(player)) {
        var_791550cf setgoal(player, 1);
      }
    }

    return;
  }
}

function function_2cc3a1be() {
  level endon(#"warehouse_kill_breakroom_event");
  level endon(#"warehouse_retreat_enemy_1");
  player = getplayers()[0];
  level flag::wait_till("flag_warehouse_breakroom_enemy");

  if(!level flag::get("warehouse_kill_breakroom_event") || !level flag::get("warehouse_retreat_enemy_1")) {
    var_c71bf7 = spawner::simple_spawn_single("warehouse_enemy_breakroom", &function_f471eec0);
    var_c71bf7 = spawner::simple_spawn_single("warehouse_enemy_toilet", &function_f471eec0);

    if(isDefined(var_c71bf7) && isalive(var_c71bf7)) {
      if(isDefined(player) && isalive(player)) {
        var_c71bf7 setgoal(player, 1);
      }
    }

    return;
  }
}

function function_57e42128() {
  player = getplayers()[0];
  level flag::wait_till("flag_warehouse_door_kick");
  kicker = spawner::simple_spawn_single("warehouse_door_kicker");
  scene::play("scene_z_stk_warehouse_door_kick", "Enter");

  if(isDefined(kicker) && isalive(kicker)) {
    if(isDefined(player) && isalive(player)) {
      kicker setgoal(player, 1);
      kicker.script_accuracy = 0.75;
    }
  }
}

function function_be7a4072() {
  level endon(#"warehouse_spawn_wave_02_br");
  level flag::wait_till("warehouse_spawn_thrd_aisle_enemy");
  enemy = spawner::simple_spawn_single("warehouse_enemy_thrd_aisle", &function_73b1f5c7);
}

function function_e47b21fa() {
  level flag::wait_till("flag_warehouse_combat_vo");
  player = getplayers()[0];

  if(distance(level.adler.origin, player.origin) <= 256) {
    level.adler dialogue::queue("vox_cp_stkt_13500_adlr_bellvolkovwentt_2b");
  } else {
    level.adler dialogue::radio("vox_cp_stkt_13500_adlr_volkovwentthrou_60");
  }

  level.park dialogue::radio("vox_cp_stkt_13500_park_hesmorevaluable_ca");
}

function function_2525ab9b() {
  level endon(#"flag_warehouse_outro_door");
  flag::wait_till("warehouse_retreat_enemy_3");
  nags = [];
  speaker = [];
  nags[nags.size] = "vox_cp_stkt_13500_adlr_getaftervolkovb_df";
  speaker[speaker.size] = level.adler;
  nags[nags.size] = "vox_cp_stkt_13500_park_wecantletvolkov_61";
  speaker[speaker.size] = level.park;
  nags[nags.size] = "vox_cp_stkt_13500_adlr_volkovsgettinga_20";
  speaker[speaker.size] = level.adler;
  nags[nags.size] = "vox_cp_stkt_13500_park_bellgoaftervolk_95";
  speaker[speaker.size] = level.park;
  wait 5;
  i = 0;

  while(!flag::get("flag_warehouse_outro_door")) {
    speaker[i] dialogue::queue("" + nags[i]);
    i++;

    if(i >= nags.size) {
      i = 0;
    }

    wait 15;
  }
}

function function_f471eec0() {
  self endon(#"death");
  self setthreatbiasgroup("warehouse_enemies");
}

function function_73b1f5c7() {
  self endon(#"death");
  var_55cfeb82 = 256;
  self.ignoresuppression = 1;
  self setgoal(getplayers()[0], 0, var_55cfeb82);
  level flag::wait_till("flag_warehouse_enemy_cleanup");

  if(isDefined(self) && isalive(self)) {
    vol = getent("warehouse_enemy_vol_04", "targetname");
    self setgoal(vol, 1);
    self.health = 1;
  }
}

function function_4112631f() {
  level endon(#"mission_failed");
  player = getplayers()[0];
  enemies = spawner::get_ai_group_ai("warehouse_enemies");

  foreach(guy in enemies) {
    if(isDefined(guy) && isalive(guy) && isDefined(player) && isalive(player)) {
      guy setgoal(player, 1);
    }
  }
}

function function_592bf7fa() {
  level endon(#"mission_failed");
  level flag::wait_till("flag_warehouse_enemy_cleanup");
  enemies = spawner::get_ai_group_ai("warehouse_enemies");

  foreach(guy in enemies) {
    if(isDefined(guy) && isalive(guy)) {
      vol = getent("warehouse_enemy_vol_03", "targetname");
      guy setgoal(vol, 1);
      guy.health = 1;
    }
  }
}

function outro_start(str_objective) {
  util::function_268bdf4f("park");
  doors::lock("warehouse_entrance_door");
  level flag::set("warehouse_intro_done");
  level flag::set("warehouse_give_player_weapon");
  level flag::set("warehouse_combat_over");
  level flag::set("no_corpse_pickup ");
  level flag::set("flag_warehouse_door_kick");
  level.adler = spawner::simple_spawn_single("warehouse_adler");
  level.lazar = spawner::simple_spawn_single("warehouse_lazar");
  waitframe(1);
  level.adler thread function_ef769f0d("warehouse_outro_adler_start_node");
  level.lazar thread function_ef769f0d("warehouse_outro_lazar_node");
  level.park thread function_ef769f0d("warehouse_intro_park_node");
  level.adler colors::set_force_color("b");
  level.park colors::set_force_color("r");
  level thread scene::play("scene_z_stk_warehouse_dt", "end_loop");
  level.var_375ea1c1 = spawner::simple_spawn_single("warehouse_volkov");
  level.var_375ea1c1 thread function_ef769f0d("warehouse_outro_volkov_end_pos");
  level.var_375ea1c1 val::set("warehouse", "ignoreall", 1);
  level.var_375ea1c1 val::set("warehouse", "ignoreme", 1);
  level.var_375ea1c1.animname = "volkov";
  level.var_375ea1c1 setCanDamage(0);
  trigger::use("warehouse_outro_ally_move_01", "targetname");
  level thread scene::skipto_end_noai("scene_z_stk_warehouse_door_kick", "Last_Frame", undefined, 1);
}

function outro_main(str_objective, var_50cc0d4f) {
  player = getplayers()[0];

  if(var_50cc0d4f) {
    tag_align = struct::get("tag_align_warehouse_start", "targetname");
    briefcase = getent("warehouse_briefcase", "targetname");
    briefcase useanimtree("generic");
    kraus = spawner::simple_spawn_single("warehouse_kraus");
    kraus.a.nodeath = 1;
    briefcase animation::last_frame(#"hash_5eb2470e4963bb6", tag_align);
    kraus animation::last_frame(#"hash_5346029e070611a6", tag_align);
    kraus kill();

    if(player player_decision::function_733a5c27()) {
      level thread function_a0f6825d();
    } else {
      level thread scene::play("scene_z_stk_warehouse_dt_greta", "loop");
    }

    level thread function_e47b21fa();
  }

  level battlechatter::function_2ab9360b(0);
  level thread function_27777aad();
  level thread function_6b148d96();

  if(!isDefined(level.var_375ea1c1)) {
    level.var_375ea1c1 = spawner::simple_spawn_single("warehouse_outro_volkov");
  }

  level thread function_82d03a33();
  level thread function_b7a12bcc();
  namespace_5ceacc03::music("17.0_kill_or_capture");
  level.var_375ea1c1 thread function_6aa51edd();
  level thread scene::add_scene_func("scene_z_stk_warehouse_cornered", &function_e5745445, "play");
  level.var_375ea1c1.dontdropweapon = 1;
  level.var_375ea1c1.var_c681e4c1 = 1;
  player.takedown.disabled = 1;
  level thread function_f038b760();
  level flag::wait_till("warehouse_outro_end");
  skipto::function_4e3ab877(str_objective);
  player_decision::function_430ebd4b(6, 2);
  player_decision::function_430ebd4b(5, 3);
  player_decision::function_8c0836dd(0);
  skipto::function_1c2dfc20("cp_rus_amerika");
}

function function_82d03a33() {
  player = getplayers()[0];
  wait 0.5;
  objectives::goto(#"kill_or_capture_obj", level.var_375ea1c1.origin + (0, 0, 75), #"hash_1c73a293c174c216", 1, 0);
  level flag::wait_till("flag_warehouse_outro_scene_start");
  level.var_375ea1c1 setCanDamage(1);

  if(isDefined(level.var_375ea1c1) && isalive(level.var_375ea1c1)) {
    objectives::function_67f87f80(#"kill_or_capture_obj", undefined, #"hash_213a842d18f87d1d");
    waitframe(1);
    waitframe(1);
    player thread objectives_ui::show_objectives();
    level.var_375ea1c1 thread function_b22fe3db();
  }
}

function function_b22fe3db() {
  self endon(#"death");
  player = getplayers()[0];
  level waittill(#"hash_6bc4c4f5b21da722");

  if(isalive(self) && isDefined(self)) {
    level.var_cb14744d = util::spawn_model("tag_origin", self.origin, self.angles);
    level.var_cb14744d linkto(self);
    level.var_cb14744d util::create_cursor_hint("tag_origin", (0, 0, 43), #"hash_42fb441288499922", 110, undefined, undefined, undefined, undefined, undefined, 0, 1);
    level.var_cb14744d prompts::set_objective("kill_or_capture_obj");
    level.var_cb14744d waittill(#"trigger");
    player playrumbleonentity(#"anim_med");
    level flag::set("flag_warehouse_outro_volkov_capture");
    self stopsounds();
    namespace_5ceacc03::music("17.0_capture_volkov");
    objectives::complete(#"kill_or_capture_obj");
    level.var_cb14744d util::remove_cursor_hint();
    player player_decision::function_5d2eb7fa(0);
    player_decision::function_8c0836dd(2);
  }
}

function function_6aa51edd() {
  player = getplayers()[0];
  level flag::wait_till("stun_over");
  self.health = 999;
  self.a.nodeath = 1;
  self.skipdeath = 1;
  self.skipdeathanim = 1;
  self.noragdoll = 1;
  self waittill(#"damage");
  player playhitmarker(undefined, 5, undefined, 1);
  level flag::set("flag_warehouse_outro_volkov_killed");
  self stopsounds();
  namespace_5ceacc03::music("17.0_kill_volkov");
  level scene::stop("scene_z_stk_warehouse_cornered");
  objectives::complete(#"kill_or_capture_obj");

  if(isDefined(level.var_cb14744d)) {
    level.var_cb14744d util::remove_cursor_hint();
  }

  player player_decision::function_5d2eb7fa(1);
  player_decision::function_8c0836dd(1);
  level thread scene::play("scene_z_stk_warehouse_cornered", "death", [self]);
  self waittill(#"death");
  self ai::set_corpse_entity(undefined);
}

function function_e5745445(a_ents) {
  var_1257242b = a_ents[# "hash_760f1b010a2507d9"];
  level flag::wait_till("flag_warehouse_outro_volkov_killed");
  var_1257242b physicslaunch(var_1257242b.origin, (0.2, 0.2, 1));
}

function function_f038b760() {
  level thread scene::play("scene_z_stk_warehouse_cornered", "intro_loop");
  flag::wait_till("flag_warehouse_outro_scene_start");
  scene::stop("scene_z_stk_warehouse_cornered");
  level thread scene::play("scene_z_stk_warehouse_cornered", "shot 1");
  level thread function_bf8b88b7();
  level waittill(#"hash_270d598a9405d904");
  level thread function_40509d9e();
}

function function_27777aad() {
  level endon(#"flag_warehouse_outro_volkov_capture");
  level endon(#"flag_warehouse_outro_volkov_killed");
  level thread function_e7edd44c();
  level thread function_433af336();
  level thread function_da8622e6();
}

function function_40509d9e() {
  level endon(#"flag_warehouse_outro_volkov_killed");
  level endon(#"flag_warehouse_outro_volkov_capture");
  level.var_375ea1c1 dialogue::queue("vox_cp_stkt_13600_vlkv_goaheadtakemeou_7f");
  wait 4;
  level.var_375ea1c1 dialogue::queue("vox_cp_stkt_13600_vlkv_youknowihavesee_95");
  level.var_375ea1c1 dialogue::queue("vox_cp_stkt_13600_vlkv_notsureifyoucan_5f");
  wait 4;
  level.var_375ea1c1 dialogue::queue("vox_cp_stkt_13600_vlkv_yougoingtodosom_e5");
  wait 3;
  level.var_375ea1c1 dialogue::queue("vox_cp_stkt_13600_vlkv_yourepathetic_db");
  wait 1.5;
  level flag::set("warehouse_outro_volkov_attack");
}

function function_e7edd44c() {
  level endon(#"flag_warehouse_outro_volkov_capture");
  level flag::wait_till("flag_warehouse_outro_volkov_killed");

  if(level scene::is_active("scene_z_stk_warehouse_dt")) {
    level thread scene::stop("scene_z_stk_warehouse_dt");
  }

  level thread scene::play("scene_z_stk_warehouse_kill_ending");

  if(!level flag::get("kill_greta")) {
    level thread scene::play("scene_z_stk_warehouse_kill_ending_greta");
  }

  level waittill(#"fade_out");
  level flag::set("warehouse_outro_end");
}

function function_433af336() {
  level endon(#"flag_warehouse_outro_volkov_killed");
  player = getplayers()[0];
  level flag::wait_till("flag_warehouse_outro_volkov_capture");
  scene::stop("scene_z_stk_warehouse_cornered");

  if(level scene::is_active("scene_z_stk_warehouse_dt")) {
    level thread scene::stop("scene_z_stk_warehouse_dt");
  }

  level thread scene::play("scene_z_stk_warehouse_captured_ending");

  if(!level flag::get("kill_greta")) {
    level thread scene::play("scene_z_stk_warehouse_captured_ending_greta");
  }

  player waittill(#"fade_out");
  level flag::set("warehouse_outro_end");
}

function function_da8622e6() {
  level endon(#"flag_warehouse_outro_volkov_killed");
  level endon(#"flag_warehouse_outro_volkov_capture");
  level flag::wait_till("warehouse_outro_volkov_attack");
  player = getplayers()[0];
  scene::stop("scene_z_stk_warehouse_cornered");
  level thread scene::play("scene_z_stk_warehouse_cornered", "shoot");
  level waittill(#"hash_501366e9fb99c760");
  level thread function_3fcd41b5();
}

function function_bf8b88b7() {
  level endon(#"flag_warehouse_outro_volkov_killed");
  level endon(#"flag_warehouse_outro_volkov_capture");
  level flag::wait_till("flag_warehouse_outro_kill_player");
  level thread function_3fcd41b5();
}

function function_3fcd41b5() {
  if(!isalive(level.var_375ea1c1)) {
    return;
  }

  player = getplayers()[0];
  level.var_375ea1c1.perfectaim = 1;
  level.var_375ea1c1.script_accuracy = 1000;

  if(isalive(player)) {
    if(level.var_375ea1c1 cansee(player)) {
      v_org = level.var_375ea1c1 gettagorigin("tag_flash");
    } else {
      v_org = player.origin + anglesToForward(player getplayerangles()) + (0, -128, 56);
    }

    v_dest = player.origin + (0, 0, 50);
    magicbullet(getweapon(#"pistol_semiauto_t9"), v_org, v_dest);

    if(isalive(player) && !player util::function_a1d6293()) {
      player flag::set("death_gesture_skip_mod_check");
      player kill();
    }
  }
}

function function_66c00fee() {
  teleport::hero(level.adler, "warehouse_outro_teleport");
  teleport::hero(level.park, "warehouse_outro_teleport");
  level.adler ai::set_behavior_attribute("demeanor", "cqb");
  level.park ai::set_behavior_attribute("demeanor", "cqb");
  node = getnode("warehouse_outro_adler_node", "targetname");
  level.adler setgoal(node, 1);
  node = getnode("warehouse_outro_park_node", "targetname");
  level.park setgoal(node, 1);
}

function function_6b148d96() {
  level endon(#"flag_warehouse_outro_volkov_killed");
  level endon(#"flag_warehouse_outro_volkov_capture");
  level endon(#"warehouse_outro_volkov_attack");
  player = getplayers()[0];
  checkvol = getent("warehouse_outro_player_check_vol", "targetname");
  level flag::wait_till("warehouse_outro_volkov_attack_start");

  while(true) {
    if(player istouching(checkvol)) {
      level flag::set("warehouse_outro_volkov_attack");
      continue;
    }

    waitframe(1);
  }
}

function function_b7a12bcc() {
  player = getplayers()[0];
  level flag::wait_till("flag_warehouse_outro_start_flash");
  var_455bdfc6 = getent("warehouse_concussion_start", "targetname");
  var_e27a70ee = getent("warehouse_concussion_end", "targetname");
  var_4788e488 = getent("warehouse_concussion_start2", "targetname");
  var_cfb34b60 = getent("warehouse_concussion_end2", "targetname");
  var_2362d320 = getweapon(#"eq_slow_grenade");
  var_a54779bb = vectornormalize(var_e27a70ee.origin - var_455bdfc6.origin) * 400;
  var_2bc9761c = var_455bdfc6 magicgrenadetype(var_2362d320, var_455bdfc6.origin, var_a54779bb, 0.5);
  var_b2f6951d = vectornormalize(var_cfb34b60.origin - var_4788e488.origin) * 400;
  var_6022a8e = var_4788e488 magicgrenadetype(var_2362d320, var_4788e488.origin, var_b2f6951d, 1);
  wait 1.2;
  var_7aa562ca = spawner::simple_spawn("warehouse_slowmo_enemies", &function_44ad2b11);

  foreach(enemy in var_7aa562ca) {
    enemy.health = 50;
    enemy val::set("warehouse", "ignoreme", 1);
  }

  wait 0.5;
  level flag::set("stun_over");
}

function function_44ad2b11() {
  self endon(#"death");
  level flag::wait_till_any(array("flag_warehouse_outro_volkov_capture", "flag_warehouse_outro_volkov_killed"));

  if(isDefined(self) && isalive(self)) {
    self kill();
  }
}

function function_233956ed() {
  level.warehouse_enemies = [];

  if(!isDefined(level.warehouse_enemies)) {
    level.warehouse_enemies = [];
  } else if(!isarray(level.warehouse_enemies)) {
    level.warehouse_enemies = array(level.warehouse_enemies);
  }

  level.warehouse_enemies[level.warehouse_enemies.size] = self;
}

function function_59e47159() {
  node = getnode("warehouse_combat_adler_start_node", "targetname");
  level.adler setgoal(node, 1);
  explo_pos = getent("warehouse_adler_explo_pos", "targetname");
  var_af2e70d5 = getent("warehouse_adler_explo_end_pos", "targetname");
  var_8cafb845 = spawner::simple_spawn("warehouse_adler_enemies");
  namespace_5ceacc03::function_af3d3d18(var_8cafb845);
  level flag::wait_till_any_timeout(3, array("flag_start_lazar_event", "flag_start_forklift_event"));
  magicbullet(getweapon(#"pistol_semiauto_t9"), explo_pos.origin, var_af2e70d5.origin);
}

function function_55737f44() {
  scene::init("aib_vign_stakeout_warehouse_lazar_takedown", [level.lazar]);
  level flag::wait_till_any_timeout(2, array("flag_start_lazar_event", "flag_start_forklift_event"));
  scene::play("aib_vign_stakeout_warehouse_lazar_takedown", [level.lazar]);
  level.lazar.perfectaim = 0;
  level.lazar.script_accuracy = 0.15;
  level.lazar clearentitytarget();
  node = getnode("lazar_anim_finish_node", "targetname");
  level.lazar setgoal(node, 1);
}

function function_ea2f2e25() {
  player = getplayers()[0];
  setDvar(#"hash_252e699c41531f1a", 0);
  player clientfield::set_to_player("knock_out_vision", 1);
  level thread namespace_5ceacc03::warehouse_plr_breathing_start();
  wait 2;
  level lui::screen_fade_in(5);
  level thread namespace_5ceacc03::warehouse_wake_mix_off_1();
  wait 0.5;
  level thread namespace_5ceacc03::warehouse_wake_mix_on_2();
  level lui::screen_fade_out(6);
  wait 1.5;
  level thread namespace_5ceacc03::warehouse_wake_mix_off_2();
  level lui::screen_fade_in(7);
}

function function_5b10af6b() {
  level endon(#"warehouse_combat_over");
  player = getplayers()[0];
  player endon(#"death");
  distsquared = 160000;
  fov = cos(45);

  while(!flag::get("warehouse_combat_over")) {
    e_enemies = spawner::get_ai_group_ai("warehouse_enemies");

    if(e_enemies.size >= 16) {
      foreach(e_ent in e_enemies) {
        if(isDefined(e_ent) && isalive(e_ent) && !e_ent flag::get("in_action") && distancesquared(player.origin, e_ent.origin) > distsquared) {
          if(!util::within_fov(player getEye(), player getplayerangles(), e_ent getEye(), fov)) {
            e_ent util::stop_magic_bullet_shield(e_ent);
            e_ent kill();
          }
        }
      }
    }

    wait 0.25;
  }
}

function function_639f072c() {
  lock_doors = [];
  warehouse_entrance_door = doors::get_doors("warehouse_entrance_door")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_entrance_door;
  var_195859c8 = doors::get_doors("warehouse_door_to_exit_room")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = var_195859c8;
  warehouse_spawn_closet_door_upper = doors::get_doors("warehouse_spawn_closet_door_upper")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_spawn_closet_door_upper;
  warehouse_spawn_closet_door = doors::get_doors("warehouse_spawn_closet_door")[0];

  if(!isDefined(lock_doors)) {
    lock_doors = [];
  } else if(!isarray(lock_doors)) {
    lock_doors = array(lock_doors);
  }

  lock_doors[lock_doors.size] = warehouse_spawn_closet_door;

  foreach(door in lock_doors) {
    door doors::lock();
  }
}

function function_a099daab(var_9c878bb5) {
  wait 1.5;

  if(isDefined(getent(var_9c878bb5, "targetname"))) {
    trigger::use(var_9c878bb5);
  }
}

function function_a2c72e4b(var_9c878bb5, set_flag) {
  if(flag::get(set_flag) && isDefined(getent(var_9c878bb5, "targetname"))) {
    trigger = getent(var_9c878bb5, "targetname");
    trigger delete();
  }
}

function function_3266ad2c() {
  level flag::wait_till("flag_warehouse_enemy_cleanup");
  wait 5;
  enemies = spawner::get_ai_group_ai("warehouse_enemies");

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      enemy thread function_69f192ab();
    }
  }
}

function function_69f192ab(distsquared, fov = 160000, var_a729919a = cos(45)) {
  self endon(#"death");
  e_player = getplayers()[0];
  e_player endon(#"death");

  while(true) {
    wait 0.1;

    if(distancesquared(e_player.origin, self.origin) < fov) {
      continue;
    }

    if(!util::within_fov(e_player getEye(), e_player getplayerangles(), self getEye(), var_a729919a)) {
      self notify(#"hash_17b0a9d5a9585319");

      if(!isDefined(self.magic_bullet_shield)) {
        wait randomfloatrange(0.7, 1.3);

        if(isDefined(self) && isalive(self) && !self flag::get("in_action")) {
          self kill();
        }

        continue;
      }

      wait randomfloatrange(0.7, 1.3);

      if(isDefined(self) && isalive(self) && !self flag::get("in_action")) {
        self util::stop_magic_bullet_shield();
        self kill();
      }
    }
  }
}