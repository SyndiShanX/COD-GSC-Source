/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6c0510483f3bae37.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_44aef2868ad2e317;
#using script_47734f62e0b3b388;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
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
#using scripts\cp_common\flashback_tv;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\object_descriptions;
#using scripts\cp_common\util;
#namespace kgb_aslt_elev_down;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level thread scene::init("scene_kgb_poison_tea");
  level.adler = namespace_e77bf565::function_52fe0eb3(var_d3440450);
  level.adler.ignoreme = 1;
  level.adler.ignoreall = 1;
  level thread scene::init("scene_kgb_elevator_holdup");
  namespace_e77bf565::function_e2e72d4(0);
  doors::function_f35467ac();
  level thread namespace_99e99ffa::function_1d90bc4a();
  level thread util::function_3e65fe0b(1);
}

function main(var_d3440450, var_50cc0d4f) {
  level.player endon(#"death");
  level flag::set("aslt_elev_down_start");
  level thread function_a8bd0b05();
  level thread function_84594864();
  var_92ce6586 = getEntArray("fake_basement_elevator", "targetname");

  foreach(piece in var_92ce6586) {
    piece delete();
  }

  level.player.ignoreme = 1;
  level.player.ignoreall = 1;

  if(is_true(var_50cc0d4f)) {
    kgb_ins_prepare::function_52f0fcb3(var_d3440450);
    kgb_ins_prepare::function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa(var_d3440450);
    level thread namespace_e77bf565::function_ada6d016();
    namespace_e77bf565::function_c4de67de();
    namespace_e77bf565::function_a43c15af();
    kgb_aslt_entry::function_b8027a11();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
    level thread function_e99c40a4();

    level.player savegame::set_player_data(#"hash_33ece87e9704b6c", 0);
  }

  level thread function_1989d4e4();
  level flag::wait_till("aslt_elev_down_complete");
  level thread util::function_3e65fe0b(0);
  level thread namespace_e77bf565::cleanup_corpses();

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {
  level thread namespace_e77bf565::function_27006ab9();
  level thread namespace_99e99ffa::function_41538e53();
  namespace_93648050::remove_all();
  projector = getent("kgb_conference_room_projector", "targetname");

  if(isDefined(projector)) {
    projector delete();
  }

  blinds_open = getent("charkov_blinds_open", "targetname");

  if(isDefined(blinds_open)) {
    blinds_open delete();
  }

  var_b36d9c38 = getent("charkov_blinds_closed", "targetname");

  if(isDefined(var_b36d9c38)) {
    var_b36d9c38 delete();
  }

  a_structs = [];
  a_structs[a_structs.size] = "prisoner_start";
  a_structs[a_structs.size] = "cuffs";
  a_structs[a_structs.size] = "prisoner_chat";
  a_structs[a_structs.size] = "swipe_card";
  a_structs[a_structs.size] = "poison_chat";
  a_structs[a_structs.size] = "map_distract";
  a_structs[a_structs.size] = "family_distract";
  a_structs[a_structs.size] = "war_distract";
  a_structs[a_structs.size] = "poison_swap";
  a_structs[a_structs.size] = "struct_computer_hack";
  a_structs[a_structs.size] = "armory_button";
  a_structs[a_structs.size] = "paperwork";
  a_structs[a_structs.size] = "prison_door_interact";
  a_structs[a_structs.size] = "ins_restricted_area_locker_poison";
  a_structs[a_structs.size] = "ins_restricted_area_locker_lock_interact";
  a_structs[a_structs.size] = "krav_computer_struct";
  a_structs[a_structs.size] = "ins_restricted_area_computer_org";
  a_structs[a_structs.size] = "false_intel_org";
  a_structs[a_structs.size] = "tutorial_button";
  a_structs[a_structs.size] = "check_body";
  a_structs[a_structs.size] = "struct_interrogation_open";
  a_structs[a_structs.size] = "struct_interrogation_close";

  foreach(struct in a_structs) {
    var_afea3d3b = struct::get(struct);
    var_afea3d3b util::remove_cursor_hint();
  }
}

function init_flags() {
  level flag::init("aslt_elev_down_start");
  level flag::init("question_fail");
  level flag::init("knock_out_boris");
  level flag::init("team_in_elevator");
  level flag::init("aslt_elev_down_complete");
  level flag::init("attack_success");
  level flag::init("stop_attack_prompt");
  level flag::init("flag_cleanup_kgb_hq");
  level flag::init("boris_get_off");
}

function init_clientfields() {
  scene::add_scene_func("scene_kgb_elevator_holdup", &function_9165ed13, "Question1");
}

function function_22b7fffd() {}

function function_a8bd0b05() {
  level function_dbef1d1a();
  level flag::set("aslt_elev_down_complete");
}

function function_ff614b0d() {
  self.player_actions.enabled[# "body_shield_grenade"] = 1;
  self cp_rus_kgb::function_c235774c();
  self val::reset_all(#"hash_5fa17b60e571053a");
  self val::reset_all(#"hash_bc68371784a550b");
  self val::reset_all(#"hash_5029f31f15e64e63");
  self val::reset_all(#"hash_674e1e53ededa27f");
  self val::reset_all(#"hash_74d0164cfdcf8bfe");
  self val::reset_all(#"hash_192dddd4b6f92f9");
  self allowslide(1);
  self setmovespeedscale(1);
  self clearcinematicmotionoverride();
}

function function_6df467f6() {
  var_4f2ba130 = self getweaponslistprimaries();

  foreach(e_w in var_4f2ba130) {
    self takeweapon(e_w);
  }
}

function function_9165ed13(a_ents) {
  level.vip = a_ents[# "boris"];
  level.vip thread entname::add(#"hash_6a1195604c394694", #"axis");
}

function function_e99c40a4() {
  level thread scene::play("scene_kgb_security_checkpoint_ambient_right");
  level thread scene::play("scene_kgb_security_checkpoint_ambient");
  level thread scene::play("scene_kgb_security_checkpoint", "Intro_Loop");
  level flag::wait_till("team_in_elevator");
  level thread scene::stop("scene_kgb_security_checkpoint_ambient_right", 1);
  level thread scene::stop("scene_kgb_security_checkpoint_ambient", 1);
  level thread scene::stop("scene_kgb_security_checkpoint", 1);
}

function function_dbef1d1a() {
  level.player endon(#"death");
  level thread scene::play("scene_kgb_elevator_holdup", "Intro");
  level flag::set("flag_prep_elevator");
  level flag::wait_till("flag_player_near_elevator");
  level thread savegame::checkpoint_save();
  level thread scene::play("scene_kgb_elevator_holdup", "Call_Elevator");
  namespace_353d803e::music("8.3_cello_stingers_2");
  wait 4;
  struct = struct::get("struct_call_elevator", "targetname");
  tag = spawn("script_model", struct.origin);
  tag setModel("tag_origin");
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_6064d25f8d7de0de");
  tag waittill(#"trigger");
  snd::client_msg(#"hash_562e2588670856dc");
  level.player districts::function_930f8c81(["kgb_hq_prison_stairs", "kgb_hq_front_04", "kgb_hq_second_floor", "kgb_hq_armory_wing", "kgb_hq_courtyard"]);
  setDvar(#"hash_76c0d7e6385ee6de", 0.9);
  thread namespace_353d803e::function_d2bfe6bd();
  tag util::remove_cursor_hint();
  tag delete();
  level flag::set("team_in_elevator");
  snd::client_msg(#"hash_2b37662433e62e4a");
  level scene::delete_scene_spawned_ents("scene_kgb_briefing");
  level scene::play("scene_kgb_elevator_holdup", "Question1");
  level flag::set("flag_cleanup_kgb_hq");
  level thread scene::play("scene_kgb_elevator_holdup", "Question1_Loop");
  function_56ebd96e();

  if(!level flag::get("knock_out_boris")) {
    level scene::play("scene_kgb_elevator_holdup", "Question2");
    level thread scene::play("scene_kgb_elevator_holdup", "Question2_Loop");
    function_8d79f364();

    if(!level flag::get("knock_out_boris")) {
      if(!level flag::get("question_fail")) {
        level thread function_c40f1128();
        thread namespace_353d803e::function_c6140081();
        thread namespace_353d803e::function_8b168679();
        level thread namespace_e77bf565::function_c1a88e8b();
        level scene::play("scene_kgb_elevator_holdup", "Success");
      } else {
        level thread function_867e4e68();
        level thread function_195e2ff1();
        level thread scene::play("scene_kgb_elevator_holdup", "Attack");
        level flag::wait_till_timeout(8.4, "attack_success");
        level flag::set("stop_attack_prompt");

        if(level flag::get("attack_success")) {
          entname::remove_all();
          level scene::play("scene_kgb_elevator_holdup", "Attack_Success");
        } else {
          level flag::set("attack_failed");
          level thread Attack_Fail();
          level scene::play("scene_kgb_elevator_holdup", "Attack_Fail");
        }
      }
    } else {
      level notify(#"hash_7d8046bc5c3382d4");
      level scene::play("scene_kgb_elevator_holdup", "Knockout");
    }
  } else {
    level notify(#"hash_7d8046bc5c3382d4");
    level scene::play("scene_kgb_elevator_holdup", "Knockout");
  }

  level.player districts::function_930f8c81(["kgb_hq_elevator", "kgb_hq_east_wing", "kgb_hq_intersection"]);
  level.player districts::function_a7d79fcb(["kgb_und_vault_bunker_main"]);
  level thread scene::play("scene_kgb_elevator_holdup", "Gear_Up");
  snd::client_msg(#"hash_284e37a8f41f8182");
  thread namespace_353d803e::function_3e72b69a();
  level waittill(#"hash_330539a9fb3725f");
  level.player function_ff614b0d();
  namespace_979752dc::set_disguised(0);
  thread namespace_353d803e::function_f3f9a760();
  setDvar(#"hash_76c0d7e6385ee6de", 0.3);
}

function function_56ebd96e() {
  var_38e8431f = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_38e8431f dialog_tree::add_option(#"hash_109e8c5a813dbd41", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa);
  var_38e8431f dialog_tree::add_option(#"hash_109e895a813db828", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa);
  var_38e8431f dialog_tree::add_option(#"hash_109e8a5a813db9db", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa);
  var_38e8431f dialog_tree::add_option(#"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, "knock_out_boris", undefined, &knock_out_boris);
  var_38e8431f dialog_tree::run(undefined, undefined, 6);
}

function function_8d79f364() {
  var_4ea26e93 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_4ea26e93 dialog_tree::add_option(#"hash_74bf855a70ebbd1c", undefined, undefined, undefined, 1, undefined, undefined, &function_5af4b73);
  var_4ea26e93 dialog_tree::add_option(#"hash_74bf885a70ebc235", undefined, undefined, undefined, 1, undefined, undefined, &function_ec2ce1aa);
  var_4ea26e93 dialog_tree::add_option(#"hash_74bf875a70ebc082", undefined, undefined, undefined, 1, undefined, undefined, &function_5af4b73);
  var_4ea26e93 dialog_tree::add_option(#"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, "knock_out_boris", undefined, &knock_out_boris);
  var_4ea26e93 dialog_tree::run(undefined, undefined, 6);
}

function function_ff8e7eb0() {
  hack = dialog_tree::new_tree(undefined, undefined, 1, 1);
  hack dialog_tree::add_option(#"hash_6ab903ee7d727152", undefined, undefined, undefined, 1, undefined, undefined, &function_3ca9698a);
  hack dialog_tree::run(undefined, undefined, 6);
}

function function_5af4b73() {
  level flag::set("question_fail");
}

function function_ec2ce1aa() {
  level flag::set("boris_get_off");
}

function knock_out_boris() {
  entname::remove_all();
  level flag::set("knock_out_boris");
}

function Attack_Fail() {
  level.player endon(#"death");
  level.player thread lui::screen_fade_out(0.5, "black");
  util::missionfailedwrapper();
}

function function_867e4e68() {
  wait 2;
  level thread function_ff8e7eb0();
}

function function_3ca9698a() {
  level flag::set("attack_success");
}

function function_bd2b281() {
  level.player endon(#"death");
  f_time = 1.75;
  wait f_time;
  level.player playrumbleonentity(#"hash_5b7713a379ba4843");
  wait 6 - f_time;
  level.player playrumbleonentity(#"hash_557fcb9fd5f0f812");
  wait 8;
  level.player playrumbleonentity(#"hash_599c601d51bf76cf");
  level flag::wait_till("flag_cleanup_kgb_hq");
  level thread function_d801675e();
}

function function_d801675e() {
  level.player endon(#"death");
  level endon(#"hash_7d8046bc5c3382d4");

  while(true) {
    level.player playrumbleonentity(#"hash_557fcb9fd5f0f812");
    wait 5;
  }
}

function function_195e2ff1() {
  level.player endon(#"death");
  namespace_353d803e::music("deactivate_9.0_infiltrating");
  wait 2;
  level notify(#"hash_7d8046bc5c3382d4");
  level.player playrumbleonentity(#"hash_3b1938b38d96e123");
  level flag::wait_till("attack_success");
  wait 0.5;
  level.player playrumbleonentity(#"hash_5b7713a379ba4843");
}

function function_1ef3bb4() {
  level.player endon(#"death");
  namespace_353d803e::music("deactivate_9.0_infiltrating");
  wait 1;
  level notify(#"hash_7d8046bc5c3382d4");
  level.player stoprumble(#"hash_557fcb9fd5f0f812");
  level.player playrumbleonentity(#"hash_109e3e977480ca06");
  wait 2.25;
  level.player playrumbleonentity(#"hash_5b7713a379ba4843");
}

function function_ca1bfb16() {
  level.player endon(#"death");
  level.player playrumbleonentity(#"hash_3b1938b38d96e123");
  wait 10;
  level.player playrumbleonentity(#"hash_599c601d51bf76cf");
}

function function_beefb420() {
  wait 5;
  playrumbleonposition(#"hash_599c601d51bf76cf", level.elevator.origin);
}

function function_c40f1128() {
  level.player endon(#"death");
  namespace_353d803e::music("deactivate_9.0_infiltrating");
  wait 4;
  level notify(#"hash_7d8046bc5c3382d4");
  wait 3;
  level.player playrumbleonentity(#"hash_599c601d51bf76cf");
  wait 7;
  level.player playrumbleonentity(#"hash_599c601d51bf76cf");
}

function function_84594864() {
  level.player endon(#"death");
  level waittill(#"hash_38b5a7da1af26414");
  level.player thread lui::screen_fade_out(0.5, "black");
  level waittill(#"hash_22a50ec8726e2044");

  if(isDefined(level.vip)) {
    level.vip delete();
  }

  level.player thread cp_rus_kgb::function_e876a652("kgb_officer_exfil", 0);
  level.adler namespace_e77bf565::function_5770c74("assault");
  level waittill(#"hash_1447c9bdddb708f");
  level.player thread lui::screen_fade_in(1);
}

function function_1989d4e4() {
  level.player endon(#"death");
  level endon(#"aslt_elev_down_complete");
  tvs = getEntArray("security_tv_on", "targetname");
  var_361c788c = getEntArray("security_tv_flashback_extra", "targetname");
  tvs = arraycombine(tvs, var_361c788c);

  foreach(tv in tvs) {
    tv setModel("p9_rus_security_monitor_01_on_cinematic");
  }

  level.player thread flashback_tv::function_15eaa2db("cp_safehouse_tv_static", "cp_shared_vietnam_brainwash", "flag_player_approached_flashback_TV", "flag_player_not_near_camera_room", "flashback_tv_lookat", undefined, undefined, #"hash_33ece87e9704b6c", struct::get("flashback_tv_lookat"));
}