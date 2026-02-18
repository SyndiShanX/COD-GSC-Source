/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1cdcb9e0e5c220f6.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_44aef2868ad2e317;
#using script_47734f62e0b3b388;
#using script_4ec222619bffcfd1;
#using script_5513c8efed5ff300;
#using script_779f525443585713;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_rus_kgb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_ins_rv;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level thread scene::init("scene_kgb_poison_tea");
  level thread scene::init("scene_kgb_elevator_holdup");
  namespace_e77bf565::function_e2e72d4(0);
}

function main(var_d3440450, var_50cc0d4f) {
  level thread function_9987ec40();
  level scene::add_scene_func("scene_kgb_walkup_charkov", &function_ec6bb2ec);
  level thread function_57279bf6();

  if(is_true(var_50cc0d4f)) {
    level thread scene::init("scene_kgb_walkup_adler");
    kgb_ins_prepare::function_52f0fcb3(var_d3440450);
    kgb_ins_prepare::function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa(var_d3440450);
    level thread namespace_e77bf565::function_ada6d016();
    level thread kgb_ins_prepare::function_799b3854();
    level thread function_1f4d29f8();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
  }

  level flag::set("no_corpse_pickup");
  level flag::wait_till("ins_rv_complete");
  level thread namespace_e77bf565::function_8191bcdc();
  level flag::clear("no_corpse_pickup");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {
  level flag::init("ins_rv_complete");
  level flag::init("flag_player_swap");
  level flag::init("flag_player_swap_complete");
  level flag::init("flag_takedown_success");
  level flag::init("flag_elevator_activated");
  level flag::init("remove_takedown_prompt");
  level flag::init("remove_clothing_prompt");
  level flag::init("flag_prep_elevator");
  level flag::init("flag_checkpoint_done");
  level flag::init("flag_player_bag");
  level flag::init("flag_player_passed_checkpoint");
  level flag::init("flag_start_rv_bread");
  level flag::init("flag_gate_pass");
  level flag::init("checkpoint_crossed");
  level flag::init("flag_door_picked");
  level flag::init("flag_fake_touch");
}

function init_clientfields() {}

function function_22b7fffd() {
  spawner::add_spawn_function_group("prison_guys", "script_noteworthy", &function_c1e43496);
}

function function_1f4d29f8() {
  level flag::set("flag_start_rv_bread");

  if(isDefined(level.var_bbfad301)) {
    var_53aae2e9 = struct::get("prison_door_interact", "targetname");
    objectives::function_4eb5c04a(#"hash_7c076479fd71fa98", var_53aae2e9.origin, #"hash_4e76340f1479c31a");
    level.var_bbfad301 prompts::set_objective(#"hash_7c076479fd71fa98");
    level flag::wait_till("flag_open_basement");
  } else {
    var_b81aabcb = struct::get("rv_bread_2", "targetname");
    objectives::function_4eb5c04a(#"hash_7c076479fd71fa98", var_b81aabcb.origin, #"hash_4e76340f1479c31a");
  }

  level flag::wait_till_any(["flag_rv_bread_1", "flag_rv_bread_2", "flag_rv_bread_3", "flag_open_basement"]);
  var_b81aabcb = struct::get("rv_bread_2", "targetname");
  objectives::update_position(#"hash_7c076479fd71fa98", var_b81aabcb.origin);
  level flag::wait_till_any(["flag_rv_bread_2", "flag_rv_bread_3", "flag_rv_bread_4"]);
  var_a9f00f76 = struct::get("rv_bread_3", "targetname");
  objectives::update_position(#"hash_7c076479fd71fa98", var_a9f00f76.origin);
  level flag::wait_till_any(["flag_rv_bread_3", "flag_rv_bread_4"]);
  var_1accf12e = struct::get("rv_bread_4", "targetname");
  objectives::update_position(#"hash_7c076479fd71fa98", var_1accf12e.origin);
  level flag::wait_till("flag_rv_bread_4");
  var_c8754a3 = struct::get("struct_swap_door_handle", "targetname");
  objectives::update_position(#"hash_7c076479fd71fa98", var_c8754a3.origin);
  level flag::wait_till("flag_player_swap");
  callback::remove_on_ai_killed(&namespace_e77bf565::function_efb66186);
  namespace_e77bf565::function_a43c15af();
  level flag::clear("kgb_enable_context_melee");
  namespace_e77bf565::function_c4de67de();
  objectives::complete(#"hash_7c076479fd71fa98");
  namespace_353d803e::music("deactivate_6.0_basement");
  level flag::wait_till("flag_player_swap_complete");
  level thread function_eb4677fe();
}

function function_eb4677fe() {
  location = struct::get("struct_elevator_activate", "targetname");
  objectives::follow(#"hash_7013ad55135deb2e", [level.adler], #"hash_440a805ccf9d5df8", 0);
  level flag::wait_till("flag_aslt_entry_prompt_door");
  objectives::hide(#"hash_7013ad55135deb2e", [level.adler]);
  spot = struct::get("checkpoint_interact");
  objectives::function_4eb5c04a(#"hash_418d7e86c7441a8b", spot.origin, undefined, 0, 1);
  spot prompts::set_objective(#"hash_418d7e86c7441a8b");
  objectives_ui::function_49dec5b(#"hash_418d7e86c7441a8b", undefined, #"hash_1b2da47a0dd85d2d");
  level flag::wait_till("flag_aslt_entry_door");
  objectives::remove(#"hash_418d7e86c7441a8b");
  objectives::show(#"hash_7013ad55135deb2e", [level.adler]);
  level flag::wait_till("team_in_elevator");
  objectives::complete(#"hash_7013ad55135deb2e", [level.adler]);
}

function function_165e5918() {
  level endon(#"hash_43fb421b5c84be9d");
  var_2757e05d = ["vox_cp_rkgb_02000_blkv_adleriswaitingo_9d", "vox_cp_rkgb_02000_blkv_mykeycardtaskis_5b"];
  var_67f23465 = 25;

  for(count = 0; !level flag::get("flag_player_swap"); count++) {
    wait var_67f23465 + count * 5;
    level.players[0] thread objectives_ui::show_objectives();
  }
}

function function_9987ec40() {
  level thread function_a459deb9();
  level flag::wait_till("flag_checkpoint_done");
  level flag::set("ins_rv_complete");
}

function function_57279bf6() {
  level thread scene::init("scene_kgb_prisoner_vignette");
  level flag::wait_till("flag_prison_scene");
  level thread scene::play("scene_kgb_prisoner_vignette");
}

function function_32137f1e(prompt) {
  return level flag::get("flag_allow_boiler_door");
}

function function_a459deb9() {
  level.player endon(#"death");
  level.player clientfield::set_to_player("stream_belikov_rv_assets", 1);
  var_d21147d1 = getent("basement_door_clip_open", "targetname");
  var_d21147d1 notsolid();
  level thread scene::init("scene_kgb_acquire_disguises_player");
  level flag::wait_till("flag_allow_boiler_door");
  struct = struct::get("struct_swap_door_handle", "targetname");
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1b2da47a0dd85d2d", 32, 0.25, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &function_32137f1e);
  struct prompts::set_objective(#"hash_7c076479fd71fa98");
  struct waittill(#"trigger");
  function_9b6d9815(1);
  level.belikov = namespace_e77bf565::function_e4660071(undefined);
  level.belikov.ignoreme = 1;
  level.belikov.ignoreall = 1;
  level.belikov util::stop_magic_bullet_shield();
  level.adler = namespace_e77bf565::function_52fe0eb3("kgb_ins_rv");
  level.adler.ignoreme = 1;
  level.adler.ignoreall = 1;
  level.adler namespace_e77bf565::function_5770c74("civ");
  doorclip = getent("basement_door_clip", "targetname");
  doorclip notsolid();
  var_d21147d1 solid();
  level.player setmovespeedscale(0.5);
  level notify(#"hash_43fb421b5c84be9d");
  level flag::set("flag_player_swap");
  level.player.ignoreme = 1;
  level.player.ignoreall = 1;
  level.player notify(#"show_itin");
  level thread function_4105690c();
  level notify(#"hash_2b4c93f5ce723277");
  function_ea00197c();
  level notify(#"hash_58a05e82d72c9b91");
  level thread function_4a8d44b7();
  level thread function_7c1c5aff("Fail", 0);
  util::delay_notify(6.5, "takedown_logic_cleanup");
  level waittill(#"hash_2a29732c8cdf857f");
  level thread function_44416c38();
  level thread scene::play("scene_kgb_acquire_disguises_inside", "Insideman_Exit");
  level thread scene::play("scene_kgb_acquire_disguises_player", "Insideman_Exit");
  level function_484bfb02();
  level.player clientfield::set_to_player("stream_belikov_rv_assets", 0);
  level thread scene::stop("scene_kgb_acquire_disguises_player");
  waitframe(1);
  level thread scene::init("scene_kgb_acquire_disguises_player");
  doorclip = getent("basement_door_clip", "targetname");
  doorclip solid();

  if(isDefined(var_d21147d1)) {
    var_d21147d1 delete();
  }

  level notify(#"hash_1f303ec0c8e6bc2b");
  level thread function_203098f4();
  level.adler namespace_e77bf565::function_5770c74();
  struct = struct::get("tag_align_security");
  door = getent("kgb_boiler_room_door", "targetname");
  door animation::first_frame("t9_kgb_walkup_boilerroom_door", struct.origin, struct.angles);
  level thread scene::play("scene_kgb_acquire_disguises_player", "Outro");
  level thread scene::play("scene_kgb_acquire_disguises_bag", "Outro");
  level scene::play("scene_kgb_acquire_disguises_actors", "Outro");
  level thread scene::init("scene_kgb_walkup_adler");
  level flag::set("flag_player_swap_complete");
  snd::client_msg(#"hash_260009c64f919000");
  thread namespace_353d803e::function_3390e801();
  level thread function_1e56b6d7();
  function_9b6d9815(0);
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 1");
  level scene::play("scene_kgb_walkup_adler", "Shot 1", [level.adler]);
  level thread scene::play("scene_kgb_walkup_adler", "Shot 2", [level.adler]);
  level flag::wait_till("flag_aslt_upstairs");
  level thread kgb_aslt_entry::function_272c06e0();
  level flag::set("flag_prep_elevator");
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 2");
  level thread scene::play("scene_kgb_walkup_adler", "Shot 3", [level.adler]);
  snd::client_msg(#"hash_66f0b482b018f16c");
  namespace_353d803e::music("8.2_cello_stingers_1");
  level flag::set("flag_checkpoint_done");
  level thread function_f59868de();
}

function function_f59868de() {
  wait 15;
  level flag::set("flag_aslt_entry_prompt_door");
}

function function_7f604b6c(a_ents) {
  level.player endon(#"death");
  var_6c8e469b = a_ents[# "guard1"];
  var_6c8e469b endon(#"entitydeleted");
  var_6c8e469b.ignoreme = 1;
  var_6c8e469b.ignoreall = 1;
  var_56c10933 = a_ents[# "guard2"];
  var_56c10933 endon(#"entitydeleted");
  var_56c10933.ignoreme = 1;
  var_56c10933.ignoreall = 1;
  var_4040d2b7 = "c_t9_cp_rus_kgb_hq_officer_nude_body1";
  var_732d50b1 = "c_t9_shg_npc_a_smirnov_kgb";
  level thread function_62724642();
  var_6c8e469b thread function_f5422572();
  var_56c10933 thread function_f5422572();
  var_dd7544b0 = level.player namespace_70eba6e6::function_33bf99f8(2);

  if(var_dd7544b0 == 2) {
    var_6c8e469b setModel("c_t9_cp_rus_female_kgb_hq_officer_body1");
    var_6c8e469b detach(var_6c8e469b.head);

    if(isDefined(var_6c8e469b.hatmodel)) {
      var_6c8e469b detach(var_6c8e469b.hatmodel);
    }

    waitframe(1);
    var_6c8e469b attach("c_t9_ger_civ_female_head06");
    var_4040d2b7 = "c_t9_base_female_nude_body";
    var_732d50b1 = "c_t9_ger_civ_female_head01";
  } else {
    var_6c8e469b detach(var_6c8e469b.head);
    var_6c8e469b attach("c_t9_shg_npc_a_smirnov_kgb");
  }

  var_56c10933 detach(var_56c10933.head);
  waitframe(1);
  var_56c10933 attach("c_t9_shg_npc_e_reshetnikov_kgb");
  level waittill(#"hash_2a29732c8cdf857f");
  var_6c8e469b notsolid();
  var_56c10933 notsolid();
  level waittill(#"hash_1f303ec0c8e6bc2b");
  var_56c10933 setModel("c_t9_cp_rus_kgb_hq_officer_nude_body1");
  var_6c8e469b setModel(var_4040d2b7);

  if(var_dd7544b0 != 2) {
    var_6c8e469b detach(var_6c8e469b.head);
  }

  waitframe(1);

  if(var_dd7544b0 != 2) {}

  level.player thread cp_rus_kgb::function_e876a652("kgb_officer", 0);
  waitframe(1);

  if(isDefined(var_6c8e469b.hatmodel)) {
    var_6c8e469b detach(var_6c8e469b.hatmodel);
  }

  if(isDefined(var_56c10933.hatmodel)) {
    var_56c10933 detach(var_56c10933.hatmodel);
  }
}

function function_f5422572() {
  level.player endon(#"death");
  level endon(#"takedown_logic_cleanup");
  guy = self;

  while(true) {
    if(guy function_7f7143e4(level.player, 1) && !level.var_2f043e81) {
      level flag::set("flag_player_caught");
      break;
    }

    waitframe(1);
  }
}

function function_62724642() {
  level endon(#"takedown_logic_cleanup");
  level flag::wait_till("flag_player_caught");

  if(level flag::get("flag_takedown_success")) {
    return;
  }

  util::missionfailedwrapper(#"hash_550c07dd465d6af7", #"hash_279386ca165e2a02");
}

function function_ea00197c() {
  level scene::add_scene_func("scene_kgb_acquire_disguises_actors", &function_7f604b6c);
  level thread scene::play("scene_kgb_acquire_disguises_player", "Intro");
  level thread scene::play("scene_kgb_acquire_disguises_actors", "Intro");
  level thread scene::play("scene_kgb_acquire_disguises_bag", "Intro");
  level thread function_18aea9a4();
  level thread scene::play("scene_kgb_acquire_disguises_inside", "Intro");
  wait 59.8;
}

function function_18aea9a4() {
  level.var_2f043e81 = 0;
  wait 38;
  level thread function_98815e2e();
  struct = struct::get("struct_takedown_hide", "targetname");
  objectives::goto("hide_spot", struct.origin, undefined, undefined, 0, "cp_waypoint_kgb_hide");
  level thread function_b6b893f4();
  level waittill(#"hash_58a05e82d72c9b91");
  objectives::complete("hide_spot");
}

function function_b6b893f4() {
  level endon(#"takedown_logic_cleanup");
  level.player endon(#"death");
  vol = getent("vol_takedown_hide", "targetname");

  while(true) {
    if(level.player istouching(vol)) {
      level.var_2f043e81 = 1;
      objectives::hide("hide_spot");

      while(level.player istouching(vol)) {
        waitframe(1);
      }

      level.var_2f043e81 = 0;
      objectives::show("hide_spot");
    }

    waitframe(1);
  }
}

function function_e006a09a() {
  level thread scene::play("scene_kgb_acquire_disguises_inside", "Kill_Loop");
  level thread scene::play("scene_kgb_acquire_disguises_actors", "Kill_Loop");
}

function function_7c1c5aff(shot_name, var_8cb24cdb) {
  level notify(#"hash_37cef3976d327d1f");
  level endon(#"hash_37cef3976d327d1f");

  if(var_8cb24cdb) {
    level childthread scene::play("scene_kgb_acquire_disguises_player", shot_name);
    level childthread function_15386625(shot_name);
    level scene::play("scene_kgb_acquire_disguises_inside", shot_name);
  } else {
    level childthread scene::play("scene_kgb_acquire_disguises_bag", shot_name);
    level childthread function_15386625(shot_name);
    level scene::play("scene_kgb_acquire_disguises_inside", shot_name);
  }

  level notify(#"hash_2a29732c8cdf857f");
}

function function_15386625(shot_name) {
  level thread scene::play("scene_kgb_acquire_disguises_bag", shot_name);
  level scene::play("scene_kgb_acquire_disguises_actors", shot_name);
  level thread scene::play("scene_kgb_acquire_disguises_bag", "Fail_Loop");
  level thread scene::play("scene_kgb_acquire_disguises_actors", "Fail_Loop");
}

function function_8f07753c() {
  level thread scene::play("scene_kgb_acquire_disguises_bag", "Fail_Loop");
  level thread scene::play("scene_kgb_acquire_disguises_actors", "Fail_Loop");
}

function function_203098f4() {
  level.player endon(#"death");
  wait 0.5;
  level.player thread lui::screen_fade_in(1);
}

function function_ab071d71() {
  level.player endon(#"death");
  level waittill(#"hash_4261efb41698295d");
  level.player lui::screen_fade_out(1.5, "black");
}

function function_4a8d44b7() {
  level.player endon(#"death");
  level endon(#"takedown_logic_cleanup");
  wait 0.05;
  level.player notifyonplayercommand("weapon_melee", "+melee");
  level.player notifyonplayercommand("weapon_melee", "+melee_zoom");
  struct = struct::get("struct_takedown_prompt", "targetname");
  trig = spawn("trigger_radius", struct.origin, 0, 96, 96);
  trig sethintstring(#"hash_56cec4baa5332ed0");
  trig setteamfortrigger(level.player.team);
  trig thread function_b3dcc32f();
  level thread function_6cff03c4();

  while(true) {
    if(level.player istouching(trig)) {
      level flag::set("flag_fake_touch");

      while(level.player istouching(trig)) {
        waitframe(1);
      }

      level flag::clear("flag_fake_touch");
    }

    waitframe(1);
  }
}

function function_6cff03c4() {
  level.player endon(#"death");
  level endon(#"takedown_logic_cleanup");

  while(true) {
    level.player waittill(#"weapon_melee");

    if(level flag::get("flag_fake_touch")) {
      level thread function_5f64631f();
      break;
    }

    waitframe(1);
  }
}

function function_5f64631f(prompt_struct) {
  level flag::set("flag_takedown_success");
  level notify(#"takedown_logic_cleanup");
  namespace_353d803e::music("7.1_attack_sting");
  level thread function_7c1c5aff("Success", 1);
}

function function_b3dcc32f() {
  level waittill(#"takedown_logic_cleanup");
  level flag::set("remove_takedown_prompt");
  self delete();
}

function function_484bfb02() {
  level.player endon(#"death");
  wait 9;
  struct = struct::get("struct_takedown_clothes", "targetname");
  tag = spawn("script_model", struct.origin);
  tag setModel("tag_origin");
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_2d8a46f8111bd39c", 80);
  tag waittill(#"trigger");
  namespace_353d803e::music("8.0_undercover", 3.5);
  diff = tag.origin - level.player.origin;
  tag delete();
  level thread function_3262752b(2);
  level flag::set("remove_clothing_prompt");

  if(diff[0] < 0) {
    level thread scene::play("scene_kgb_acquire_disguises_actors", "Change_Clothes");
    level scene::play("scene_kgb_acquire_disguises_player", "Change_Clothes");
    return;
  }

  level thread scene::play("scene_kgb_acquire_disguises_actors", "Change_Clothes_Alt");
  level scene::play("scene_kgb_acquire_disguises_player", "Change_Clothes_Alt");
}

function function_3262752b(time) {
  level.player endon(#"death");
  wait time;
  level.player thread lui::screen_fade_out(1.5, "black");
}

function function_3f5c3b7c() {}

function function_4105690c() {
  level.player endon(#"death");
  level waittill(#"hash_64846a612e785746");
  level.player lui::screen_fade_out(0.75, "black");
  wait 0.8;
  level.player thread cp_rus_kgb::function_e876a652("civilian", 1);
  wait 0.2;
  level.player lui::screen_fade_in(0.5);
  wait 0.5;
  level thread globallogic_ui::function_7bc0e4b9(0, 1);
  level thread savegame::checkpoint_save();
  namespace_353d803e::music("7.0_tunnels");
}

function function_1e56b6d7() {
  level thread function_3209e378();
  level thread function_49f1319a();
  level flag::wait_till("flag_player_checkpoint_start");
  level scene::stop("scene_kgb_walkup_hall_talk", 1);
  level scene::stop("scene_kgb_walkup_stairs_duo", 1);
  level scene::stop("scene_kgb_walkup_charkov", 1);
}

function function_3209e378() {
  level thread scene::play("scene_kgb_walkup_hall_talk", "Shot 1");
  level.adler waittill(#"hash_2c9839971e87b765");
  namespace_353d803e::music("8.2_cello_stingers_1");
  level thread scene::play("scene_kgb_walkup_hall_talk", "Shot 2");

  if(level flag::get("flag_checkpoint_moment_done")) {
    level thread scene::play("scene_kgb_walkup_charkov");
  }
}

function function_49f1319a() {
  level.adler waittill(#"hash_5f3452bc1c48bf4d");
  level thread scene::play("scene_kgb_walkup_stairs_duo", "Shot 1");
}

function function_7f7143e4(player, var_7b20e52b) {
  if(isDefined(self.targetname) && self.targetname == "prisoner") {
    return false;
  }

  angles = self gettagangles("tag_eye");
  v_forward = anglesToForward(angles);
  v_loc = player getEye();
  v_dir = vectornormalize(v_loc - self gettagorigin("tag_eye"));
  dp = vectordot(v_forward, v_dir);

  if(dp > 0.1) {
    if(is_true(var_7b20e52b)) {
      v_loc = player.origin + (0, 0, 48);

      if(sighttracepassed(self gettagorigin("tag_eye"), v_loc, 0, self)) {
        return true;
      }
    }

    return false;
  }

  return false;
}

function function_ce801c8b(skipto, var_50cc0d4f) {
  level flag::set("flag_player_swap");
  level.player endon(#"death");
  level scene::add_scene_func("scene_kgb_walkup_charkov", &function_ec6bb2ec);
  level flag::set("flag_player_swap_complete");
  level flag::set("flag_checkpoint_moment_done");
  level thread function_9987ec40();
  level.adler = namespace_e77bf565::function_52fe0eb3("kgb_ins_rv");
  level.adler.ignoreme = 1;
  level.adler.ignoreall = 1;
  level thread namespace_99e99ffa::function_99e99ffa(var_50cc0d4f);
  level thread scene::play("scene_kgb_acquire_disguises_player", "Outro");
  level thread scene::play("scene_kgb_acquire_disguises_bag", "Outro");
  level scene::play("scene_kgb_acquire_disguises_actors", "Outro");
  level.adler namespace_e77bf565::function_5770c74();
  level thread function_1e56b6d7();
  level.player setmovespeedscale(0.5);
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 1");
  level scene::play("scene_kgb_walkup_adler", "Shot 1", [level.adler]);
  level thread scene::play("scene_kgb_walkup_adler", "Shot 2", [level.adler]);
  level flag::wait_till("flag_aslt_upstairs");
  level flag::set("flag_prep_elevator");
  level thread kgb_aslt_entry::function_272c06e0();
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 2");
  level thread scene::play("scene_kgb_walkup_adler", "Shot 3", [level.adler]);
}

function function_7a89c7d8(a_ents) {
  a_ents[# "hash_25c349eb26f191d7"] thread function_c1e43496();
  a_ents[# "hash_25c34aeb26f1938a"] thread function_c1e43496();
}

function function_32e58509(a_ents) {
  a_ents[# "warden"] thread function_c1e43496();
  a_ents[# "guard01"] thread function_c1e43496();
  a_ents[# "guard02"] thread function_c1e43496();
}

function function_c1e43496() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.propername = kgb_ins_prepare::function_70594daa();
  weapon = getweapon("smg_heavy_t9");
  self setweapon(weapon);
}

function function_ec6bb2ec(a_ents) {
  var_8a3834d = a_ents[# "hash_22e4f0609e73cccc"];
  var_8a3834d thread entname::add(#"hash_50d58662d307f9c7", #"axis");
}

function function_9b6d9815(off = 1) {
  clip = getent("boiler_room_exit_clip", "targetname");
  level.player endon(#"death");

  if(off) {
    level.player setstance("stand");
    level.player val::set(#"hash_5814be4ed0ae9e2b", "allow_stand", 1);
    level.player val::set(#"hash_5814be4ed0ae9e2b", "allow_crouch", 0);
    level.player val::set(#"hash_5814be4ed0ae9e2b", "allow_prone", 0);
    clip.origin += (0, 0, -256);
    return;
  }

  level.player val::reset_all(#"hash_5814be4ed0ae9e2b");
  clip delete();
}

function function_98815e2e() {
  var_c2958343 = getent("kgb_boiler_room_door_2", "targetname");
  var_c2958343.origin += (0, 0, -256);
}

function function_44416c38() {
  wait 0.25;
  var_c2958343 = getent("kgb_boiler_room_door_2", "targetname");
  var_c2958343 delete();
}