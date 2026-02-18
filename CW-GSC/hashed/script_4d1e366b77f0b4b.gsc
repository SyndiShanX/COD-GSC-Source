/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d1e366b77f0b4b.gsc
***********************************************/

#using script_1940fc077a028a81;
#using script_2c5daa95f8fec03c;
#using script_3411bb48d41bd3b;
#using script_36f4be19da8eb6d0;
#using script_3d3c03b88e16a244;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\ai\archetype_locomotion_utility;
#using scripts\core_common\ai\archetype_mocomps_utility;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_blackboard;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\animation_state_machine_mocomp;
#using scripts\core_common\ai\systems\animation_state_machine_notetracks;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\systems\debug;
#using scripts\core_common\ai\systems\destructible_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\powerup\zm_powerup_nuke;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_behavior;
#using scripts\zm_common\zm_cleanup_mgr;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_pack_a_punch_util;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_spawning;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_transformation;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_88795f45;

function private autoexec __init__system__() {
  system::register(#"hash_338a74f5c94ba66a", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  registerbehaviorscriptfunctions();

  execdevgui("<dev string:x38>");
  level thread function_e96e00cc();
  level thread update_dvars();

  spawner::add_archetype_spawn_function(#"hash_7c0d83ac1e845ac2", &function_7ec99c76);
  spawner::function_89a2cd87(#"hash_7c0d83ac1e845ac2", &function_cf0706a7);
  clientfield::register("actor", "steiner_radiation_bomb_prepare_fire_clientfield", 1, 1, "int");
  clientfield::register("scriptmover", "radiation_bomb_play_landed_fx", 1, 2, "int");
  clientfield::register("missile", "radiation_bomb_trail_fx_clientfield", 1, 1, "int");
  clientfield::register("actor", "steiner_split_combine_fx_clientfield", 1, 1, "int");
  clientfield::register("actor", "steiner_perform_split_clientfield", 1, 1, "counter");
  clientfield::register("actor", "steiner_cleanup_teleport_clientfield", 4000, 1, "counter");
  callback::on_actor_killed(&function_f26fe009);
  callback::on_actor_damage(&function_61e1c2a1);
  callback::on_player_damage(&function_bc9fe637);
  zm_utility::function_d0f02e71(#"hash_7c0d83ac1e845ac2");
  zm_cleanup::function_cdf5a512(#"hash_7c0d83ac1e845ac2", &function_99c14949);
  zm_round_spawning::register_archetype(#"hash_7c0d83ac1e845ac2", &function_f4788553, &round_spawn, undefined, 100);
  zm_round_spawning::function_306ce518(#"hash_7c0d83ac1e845ac2", &function_3ced6468);
  zm::function_84d343d(#"hash_2b47921791da6f0", &function_7709f2df);
  zm::function_84d343d(#"hash_67307aa00ad6f686", &function_7ff0ce68);
}

function private postinit() {}

function private registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&function_7a893a7));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7280253b8045f3aa", &function_7a893a7);
  assert(isscriptfunctionptr(&function_e6d0f1d4));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25f6a58aa44b9b2a", &function_e6d0f1d4);
  assert(isscriptfunctionptr(&function_b46c0796));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79642ea6dc02eebd", &function_b46c0796);
  assert(isscriptfunctionptr(&function_fb61fd57));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_42117ec3b040839a", &function_fb61fd57);
  assert(isscriptfunctionptr(&function_b52cb76c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4cc6cc5dc62bf114", &function_b52cb76c);
  assert(isscriptfunctionptr(&function_e9e122fa));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_154f7a6870ab70d2", &function_e9e122fa);
  assert(isscriptfunctionptr(&function_15c1e3df));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ad94e79dd5192", &function_15c1e3df);
  assert(isscriptfunctionptr(&function_7cac529b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7d62ea78150d61ab", &function_7cac529b);
  assert(isscriptfunctionptr(&function_29744716));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a17e3794c739769", &function_29744716);
  assert(isscriptfunctionptr(&function_52479a49));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f21279adbfeb5c6", &function_52479a49);
  assert(isscriptfunctionptr(&function_dcac38af));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6ada226476fbbc5a", &function_dcac38af);
  assert(isscriptfunctionptr(&function_efc7dca5));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4db554ff25b3f605", &function_efc7dca5);
  assert(isscriptfunctionptr(&function_e6b7aa9d));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_50a4fe24c23b6d27", &function_e6b7aa9d);
  assert(isscriptfunctionptr(&function_dab44559));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_23c568af83b67b77", &function_dab44559);
  assert(isscriptfunctionptr(&function_2745a754));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34d3f0d3d41d76e5", &function_2745a754);
  assert(isscriptfunctionptr(&function_5142fcce));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e44bc48a1f81235", &function_5142fcce);
  assert(isscriptfunctionptr(&function_4b261274));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a396809551c1af9", &function_4b261274);
  assert(isscriptfunctionptr(&function_f9eee290));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4b68c168ade3461c", &function_f9eee290);
  assert(isscriptfunctionptr(&function_baffe829));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1146baaf761ec6ed", &function_baffe829);
  assert(isscriptfunctionptr(&function_fe1e617c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57c7c778e27ffa59", &function_fe1e617c);
  assert(isscriptfunctionptr(&function_4245d56f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_98b56eef8e28325", &function_4245d56f);
  assert(isscriptfunctionptr(&function_45fabe41));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1658d524a973ce91", &function_45fabe41);
  assert(isscriptfunctionptr(&function_99608cba));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a163703acd2ed3f", &function_99608cba);
  assert(isscriptfunctionptr(&function_779b5a9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2bb826405d693ccb", &function_779b5a9);
  assert(isscriptfunctionptr(&function_363c063));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f175e396e0073c6", &function_363c063);
  assert(isscriptfunctionptr(&function_380fc4a5));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4f54754f71b9dd6e", &function_380fc4a5);
  assert(isscriptfunctionptr(&function_545f48af));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_305325825d9f1ae9", &function_545f48af);
  assert(isscriptfunctionptr(&function_42d0830a));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_188114dd969b5dd5", &function_42d0830a);
  assert(isscriptfunctionptr(&function_5c25cce9));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79093a39082de682", &function_5c25cce9);
  assert(isscriptfunctionptr(&function_5070830c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4544909102899fea", &function_5070830c);
  assert(isscriptfunctionptr(&function_d33f94e));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_170557ad6e763f0c", &function_d33f94e);
  assert(isscriptfunctionptr(&function_4b63f114));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5676e5630fdedd2c", &function_4b63f114);
  assert(isscriptfunctionptr(&function_46e10c70));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7cb881b920ccf02e", &function_46e10c70);
  assert(isscriptfunctionptr(&function_d778b630));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e786509dc63e8d5", &function_d778b630);
  assert(isscriptfunctionptr(&function_44c1658c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65a3b6de862fb75a", &function_44c1658c);
  assert(isscriptfunctionptr(&function_6e3a88b1));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4b147f3238fcde5e", &function_6e3a88b1);
  assert(isscriptfunctionptr(&function_a14fcce8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ce32e790014a59", &function_a14fcce8);
  assert(isscriptfunctionptr(&function_3bdb520f));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_dd673574a092994", &function_3bdb520f);
  assert(isscriptfunctionptr(&function_2154581b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_604e4765f2e53c69", &function_2154581b);
  assert(isscriptfunctionptr(&function_7b89edb0));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4a436c24681915c9", &function_7b89edb0);
  assert(isscriptfunctionptr(&function_8e782bd8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e8af19176b18981", &function_8e782bd8);
  assert(isscriptfunctionptr(&function_850378bc));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f99aa9fd7ca1763", &function_850378bc);
  assert(isscriptfunctionptr(&function_c9181afb));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d426e2923cd605f", &function_c9181afb);
  assert(isscriptfunctionptr(&function_bf6d273f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e9c0fd10ee65237", &function_bf6d273f);
  assert(isscriptfunctionptr(&function_bd9179c));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1122d04b4a1feb63", &function_bd9179c);
  assert(isscriptfunctionptr(&function_13f6d246));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_136f063162bf4aa2", &function_13f6d246);
  assert(isscriptfunctionptr(&function_e37d4e19));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_24bc3164c6e2d00a", &function_e37d4e19);
  assert(isscriptfunctionptr(&function_218044b0));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_347c189df97826cb", &function_218044b0);
  assert(isscriptfunctionptr(&function_553ec0ae));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e07bf77046e74de", &function_553ec0ae);
  assert(isscriptfunctionptr(&function_f60a1f74));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_789e829d5e75ebb6", &function_f60a1f74);
  assert(isscriptfunctionptr(&function_9397dd2f));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29e39b41a2ae57c6", &function_9397dd2f);
  assert(isscriptfunctionptr(&function_d5e64bba));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_696fd459823b4d1c", &function_d5e64bba);
  assert(isscriptfunctionptr(&function_6fc64eed));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72b6cfe3e9c93972", &function_6fc64eed);
  assert(isscriptfunctionptr(&function_6254c264));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52b10d159b214f3d", &function_6254c264);
  assert(isscriptfunctionptr(&function_e5ef0d0d));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_375d2172d1ccc231", &function_e5ef0d0d);
  assert(isscriptfunctionptr(&function_e456ad9b));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78f3493bbe2fc0a6", &function_e456ad9b);
  animationstatenetwork::registernotetrackhandlerfunction("steiner_blast_fire", &function_46f4d406);
  animationstatenetwork::registernotetrackhandlerfunction("steiner_bomb_fire", &function_fc9189dd);
  animationstatenetwork::registernotetrackhandlerfunction("steiner_end_split_invulnerability", &function_208c255d);
  assert(isscriptfunctionptr(&function_829cfcc8));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3bd518a057cb317c", &function_829cfcc8);
}

function function_7ec99c76() {
  self.no_gib = 1;
  self.instakill_func = &zm_powerups::function_16c2586a;
  self.zombie_move_speed = "walk";
  self.cant_move_cb = &zombiebehavior::function_79fe956f;
  self.var_306ee014 = &function_cabc8b69;
  self.var_81e5ae7 = &function_82654cab;
  self.closest_player_override = &zm_utility::function_3d70ba7a;
  self.allowdeath = 1;
  self.variant_type = 0;
  self.var_15d21bbf = 1;
  self.var_126d7bef = 1;
  self.ignore_round_spawn_failsafe = 1;
  self.var_f0d59f6d = 0;
  self.var_216935f8 = 1;

  if(!isDefined(self.subarchetype) || self function_ba878b50() || self.subarchetype === # "hash_5605f3a585b3ef9f") {
    self.var_53bac70d = 1;
  }

  if(!isDefined(self.subarchetype) || self function_3758a4e7() || self.subarchetype === # "hash_5605f3a585b3ef9f") {
    self.var_22b8f534 = 1;
  }

  if(!isDefined(self.subarchetype) || self.subarchetype === # "hash_5605f3a585b3ef9f") {
    self.var_8d1d18aa = 1;
  }

  self.var_3ad8ef86 = 0;
  self.var_b52fc691 = 0;
  self.var_fcca372 = 0;

  if(!isDefined(self.ai)) {
    self.ai = spawnStruct();
  }

  self.ai.var_a02f86e7 = 0;
  self.ai.var_5dc77566 = 0;
  self.ai.var_b13e6817 = 0;
  self.ai.var_76786d9c = 0;
  self.ai.var_fad877bf = 0;
  self.ai.currentskill = 0;
  self.ai.var_a29f9a91 = 0;
  self.ai.var_8c90ae8e = 0;
  self.ai.var_bb06b848 = 1;
  self.ai.var_e875a95c = 0;
  self.ai.var_e93366a = 0;
  self.ai.var_a49798e7 = 0;
  self.ai.var_3dbed9a0 = 0;
  self.ai.cansplit = 1;
  self.ai.var_8c8fb85a = 0;
  self.ai.var_26b09b96 = 1;
  self.var_28621cf4 = "j_head";
  self.var_e5365d8a = (0, 0, 0);
  self.var_67faa700 = 1;

  if(!zm_utility::is_survival()) {
    self.no_powerups = 1;
  }

  self.ai.var_b90dccd6 = 0;
  self.ai.var_62741bfb = 0;

  if(is_true(self.var_22b8f534) && !isDefined(level.var_879dbfb8)) {
    level.var_879dbfb8 = 0;
  }

  self.var_b077b73d = &function_b077b73d;
  self.var_fe72f961 = &function_617dea8a;
  self.var_ee833cd6 = &function_ef8a9f03;
  aiutility::addaioverridedamagecallback(self, &function_4e005f8f);
  zm_score::function_e5d6e6dd(#"hash_7c0d83ac1e845ac2", 60);
  self zm_score::function_82732ced();
  self zm_powerup_nuke::function_9a79647b(0.5);
  level thread zm_spawner::zombie_death_event(self);
  self thread function_ed79082a();

  if(getdvarint(#"hash_7bb1af7c8592abdf", 0)) {
    self function_5ac86e25();
  }

  if(!self function_6b87eed1()) {
    self.var_94378ef = 1;

    if(self function_1e521615()) {
      self.var_94378ef = 1;
    }
  }

  if(self function_6b87eed1()) {
    self thread function_3c494a14();
  }

  self flag::init("steiner_split_invulnerable", 0);

  if(self function_6b87eed1()) {
    if(getdvarint(#"hash_63879de6b2db7236", 1) > 0 && self.targetname !== "debug_ai" && self.targetname !== "debug_idle_ai") {
      self flag::set_val("steiner_split_invulnerable", 1);
      self thread function_2d1a3809();
    }
  }
}

function private function_2d1a3809() {
  level endon(#"end_game");
  self endon(#"death");
  self waittilltimeout(1, #"hash_200053f79d3c5c19");

  if(isDefined(self.var_3a51c5dc)) {
    anim_length = getanimlength(self.var_3a51c5dc);
    var_3a41f908 = getnotetracktimes(self.var_3a51c5dc, "steiner_end_split_invulnerability")[0];
    time = anim_length * var_3a41f908;
    wait time;
  }

  function_208c255d(self);
}

function private function_ef8a9f03() {
  self.no_powerups = 0;
}

function function_cf0706a7() {
  namespace_81245006::initweakpoints(self);
}

function private function_e96e00cc() {
  if(isarchetypeloaded(#"hash_7c0d83ac1e845ac2")) {
    level flag::wait_till("<dev string:x5a>");
    zm_devgui::add_custom_devgui_callback(&function_15677aa0);
    function_1d9f7b18();
  }
}

function private function_1d9f7b18() {
  if(is_true(level.var_a4fe61a4)) {
    return;
  }

  level.var_a4fe61a4 = 1;
}

function private function_15677aa0(cmd) {
  switch (cmd) {
    case # "hash_fb30e673c6ed7ed":
    case # "hash_3710ddeafb2df7df":
    case # "hash_7791897f03cdc3bf":
    case # "steiner_spawn":
      player = getplayers()[0];
      v_direction = player getplayerangles();
      v_direction = anglesToForward(v_direction) * 8000;
      eye = player getEye();
      trace = bulletTrace(eye, eye + v_direction, 0, undefined);
      var_380c580a = positionquery_source_navigation(trace[# "position"], 128, 256, 128, 20);
      s_spot = spawnStruct();

      if(isDefined(var_380c580a) && var_380c580a.data.size > 0) {
        s_spot.origin = var_380c580a.data[0].origin;
      } else {
        s_spot.origin = player.origin;
      }

      s_spot.angles = (0, player.angles[1] - 180, 0);
      spawner = # "spawner_zm_steiner";

      if(cmd == "<dev string:x90>") {
        spawner = # "spawner_zm_steiner_split_radiation_blast";
      } else if(cmd == "<dev string:xad>") {
        spawner = # "spawner_zm_steiner_split_radiation_bomb";
      } else if(cmd == "<dev string:x76>") {
        function_f045e7c(s_spot, 0);
        break;
      }

      steiner = spawnactor(spawner, s_spot.origin, s_spot.angles);

      if(isDefined(steiner)) {
        steiner forceteleport(s_spot.origin);
      }

      break;
    case # "hash_7168487d1ca40ace":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");

      foreach(steiner in steiners) {
        steiner thread function_735ef74d();
      }

      break;
    case # "hash_56fe56d42aeaae84":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");

      foreach(steiner in steiners) {
        if(isalive(steiner)) {
          steiner function_bf898e7e(!steiner function_b37b32b9());
        }
      }

      break;
    case # "hash_6c5505a13bdeb727":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");

      foreach(steiner in steiners) {
        if(isalive(steiner)) {
          if(!isDefined(steiner.subarchetype) || steiner function_ba878b50() || steiner.subarchetype === # "hash_5605f3a585b3ef9f") {
            steiner function_af554aaf(!is_true(steiner.var_53bac70d));
          }
        }
      }

      break;
    case # "hash_359a6fc8ff117087":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");

      foreach(steiner in steiners) {
        if(isalive(steiner)) {
          if(!isDefined(steiner.subarchetype) || steiner function_3758a4e7() || steiner.subarchetype === # "hash_5605f3a585b3ef9f") {
            steiner function_16a8babd(!is_true(steiner.var_22b8f534));
          }
        }
      }

      break;
    case # "hash_24ad0cbc87557614":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");

      foreach(steiner in steiners) {
        if(isalive(steiner)) {
          steiner.ai.var_bb06b848 = !steiner.ai.var_bb06b848;
        }
      }

      break;
    case # "hash_2359be32da56aa21":
      steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
      split_blast = undefined;
      split_bomb = undefined;

      foreach(steiner in steiners) {
        if(!isDefined(steiner.subarchetype) || steiner.subarchetype === # "hash_5605f3a585b3ef9f") {
          continue;
        }

        if(steiner function_ba878b50() && !isDefined(split_blast)) {
          split_blast = steiner;
        } else if(steiner function_3758a4e7() && !isDefined(split_bomb)) {
          split_bomb = steiner;
        }

        if(isDefined(split_blast) && isDefined(split_bomb)) {
          level thread function_67a0e9a2([split_blast, split_bomb], split_blast);
          break;
        }
      }

      break;
    case # "hash_108d247458cb597b":
      function_bbb547de(250);
      break;
    case # "hash_77e4b4a0f4904933":
      function_32af84be(level.players[0]);
      break;
    default:
      break;
  }
}

function update_dvars() {
  while(true) {
    wait 1;
    level.var_a71c09f8 = getdvarint(#"hash_65428d4970618b19", 0);
  }
}

function function_ee21651d(message) {
  if(is_true(level.var_a71c09f8)) {
    println("<dev string:xc9>" + message);
  }
}

function spawn_single(b_force_spawn, var_eb3a8721 = 0, var_bc66d64b) {
  if(!var_eb3a8721 && !function_fbb9b8fb()) {
    return undefined;
  }

  a_s_locs = struct::get_array("spawn_location", "script_noteworthy");

  if(a_s_locs.size > 0) {
    s_spawn_loc = a_s_locs[0];
  }

  if(!isDefined(s_spawn_loc)) {
    if(getdvarint(#"hash_1f8efa579fee787c", 0)) {
      iprintlnbold("<dev string:xd9>");
    }

    return undefined;
  }

  if(isDefined(level.var_9d098364)) {
    spawner_name = level.var_9d098364;
  } else {
    spawner_name = # "spawner_zm_steiner";
  }

  ai = spawnactor(spawner_name, s_spawn_loc.origin, s_spawn_loc.angles);

  if(isDefined(ai)) {
    ai.script_string = s_spawn_loc.script_string;
    ai.find_flesh_struct_string = s_spawn_loc.find_flesh_struct_string;
    ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    ai.ignore_enemy_count = 1;

    if(isDefined(var_bc66d64b)) {
      ai forceteleport(var_bc66d64b.origin, var_bc66d64b.angles);
    } else {
      ai thread function_f0811059();
    }
  }

  return ai;
}

function function_f0811059() {
  level endon(#"game_ended");
  self endon(#"death");
  count = 0;

  while(count < 10) {
    if(isDefined(level.var_2a8acd42)) {
      s_spawn_loc = [[level.var_2a8acd42]]();
    } else if(level.zm_loc_types[# "steiner_location"].size > 0) {
      s_spawn_loc = array::random(level.zm_loc_types[# "steiner_location"]);
    }

    if(isDefined(s_spawn_loc)) {
      if(self teleport(s_spawn_loc.origin, s_spawn_loc.angles)) {
        return;
      }
    }

    count++;
    wait 0.3;
  }

  if(isDefined(s_spawn_loc)) {
    self forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
  }
}

function function_99c14949() {
  self endon(#"death");

  function_ee21651d("<dev string:x10c>");

  while(true) {
    var_31f7011a = arraysortclosest(getplayers(), self.origin);

    foreach(player in var_31f7011a) {
      if(zm_utility::is_player_valid(player)) {
        closest_player = player;
        break;
      }
    }

    if(isDefined(closest_player)) {
      break;
    }

    util::wait_network_frame();
  }

  s_spawn_locs = [];

  if(isDefined(level.var_2a8acd42)) {
    spawn_locs = [[level.var_2a8acd42]](1);

    if(isarray(spawn_locs)) {
      s_spawn_locs = spawn_locs;
    } else {
      array::add(s_spawn_locs, spawn_locs);
    }
  } else if(level.zm_loc_types[# "steiner_location"].size > 0) {
    s_spawn_locs = level.zm_loc_types[# "steiner_location"];
  }

  var_69681a59 = [];

  if(isDefined(level.active_zone_names) && isarray(s_spawn_locs) && s_spawn_locs.size > 0) {
    foreach(spawn_loc in s_spawn_locs) {
      if(isDefined(spawn_loc.zone_name) && array::contains(level.active_zone_names, spawn_loc.zone_name)) {
        if(!isDefined(var_69681a59)) {
          var_69681a59 = [];
        } else if(!isarray(var_69681a59)) {
          var_69681a59 = array(var_69681a59);
        }

        var_69681a59[var_69681a59.size] = spawn_loc;
      }
    }
  }

  if(var_69681a59.size < 1) {
    function_ee21651d("<dev string:x12c>");

    return true;
  }

  spawn_points = arraysortclosest(var_69681a59, closest_player.origin, undefined, 500);

  if(spawn_points.size > 0) {
    var_b2aa54a9 = spawn_points[0];
  } else {
    var_b2aa54a9 = arraygetfarthest(closest_player.origin, var_69681a59);
  }

  if(!isDefined(var_b2aa54a9)) {
    function_ee21651d("<dev string:x1a0>");

    return true;
  }

  function_ee21651d("<dev string:x1e1>" + self.origin + "<dev string:x211>" + var_b2aa54a9.origin);

  self function_bf898e7e(0);
  self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
  self clientfield::increment("steiner_cleanup_teleport_clientfield");
  self function_bf898e7e(1);
  return true;
}

function private function_735ef74d() {
  if(isalive(self)) {
    self.marked_for_death = 1;
    self.allowdeath = 1;
    self.var_98f1f37c = 1;
    self kill(undefined, undefined, undefined, undefined, undefined, 1);
    waitframe(1);

    if(isDefined(self)) {
      self delete();
    }
  }
}

function function_f4788553(var_dbce0c44) {
  if(isDefined(level.var_ad49daf9) && level.round_number < level.var_ad49daf9) {
    return 0;
  }

  n_player_count = zm_utility::function_a2541519(getplayers().size);

  if(n_player_count == 1) {
    switch (level.var_b15745d6) {
      case 0:
      case 1:
      case 2:
        var_2506688 = 1;
        var_1797c23a = 1;
        break;
      default:
        var_2506688 = 1;
        var_1797c23a = 2;
        break;
    }
  } else {
    switch (level.var_b15745d6) {
      case 0:
      case 1:
        var_2506688 = 1;
        var_1797c23a = 1;
        break;
      case 2:
      case 3:
        var_2506688 = 2;
        var_1797c23a = 2;
        break;
      default:
        var_2506688 = 3;
        var_1797c23a = 3;
        break;
    }
  }

  return randomintrangeinclusive(var_2506688, var_1797c23a);
}

function function_3ced6468(n_round_number) {
  level endon(#"end_game");

  if(!isDefined(level.var_b15745d6)) {
    level.var_b15745d6 = 0;
  }

  while(true) {
    level waittill(#"hash_5d3012139f083ccb");

    if(zm_round_spawning::function_d0db51fc(#"hash_7c0d83ac1e845ac2")) {
      level.var_b15745d6++;
      n_player_count = zm_utility::function_a2541519(getplayers().size);

      if(n_player_count == 1) {
        level.var_ad49daf9 = level.round_number + randomintrangeinclusive(3, 5);
        continue;
      }

      level.var_ad49daf9 = level.round_number + randomintrangeinclusive(3, 4);
    }
  }
}

function round_spawn() {
  ai = spawn_single();

  if(isDefined(ai)) {
    return true;
  }

  return false;
}

function function_fbb9b8fb() {
  var_77c7cc93 = function_5e039106();
  var_60f05a03 = function_1f8ac25d();

  if(!is_true(level.var_76934955) && (is_true(level.var_fe2bb2ac) || var_77c7cc93 >= var_60f05a03 || !level flag::get("spawn_zombies"))) {
    return false;
  }

  return true;
}

function function_1f8ac25d() {
  n_player_count = zm_utility::function_a2541519(getplayers().size);

  switch (n_player_count) {
    case 1:
      return 1;
    case 2:
      return 3;
    case 3:
      return 3;
    case 4:
      return 3;
    case 5:
      return 3;
  }

  return 1;
}

function function_5e039106() {
  var_5a2d0d60 = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
  var_77c7cc93 = var_5a2d0d60.size;

  foreach(var_494993c6 in var_5a2d0d60) {
    if(!isalive(var_494993c6) || is_true(var_494993c6.ai.var_b90dccd6)) {
      var_77c7cc93--;
    }
  }

  return var_77c7cc93;
}

function function_f26fe009(params) {
  if(self.archetype !== # "hash_7c0d83ac1e845ac2") {
    return;
  }

  self function_bf898e7e(0);
  self thread function_4b193227();

  if(self function_9cc1ebd1()) {
    level notify(#"hash_7e3660d8d125a63a", {
      #position: self.origin, #aitype: self.aitype
    });
  }
}

function function_61e1c2a1(params) {
  if(self.archetype !== # "hash_7c0d83ac1e845ac2") {
    return;
  }

  if(self.team == # "allies") {
    self.health = self.maxhealth;

    if(!isPlayer(params.eattacker)) {
      if(self.ai.var_8c90ae8e) {
        self.ai.var_a49798e7 = 1;
        self notify(#"hash_39f4b987812e1540");
        self thread function_2a30b3a3(6);
      }
    }
  }

  if(isDefined(params.weapon) && namespace_b376a999::function_5fef4201(params.weapon)) {
    self thread function_c235ead4(3);
  }

  if(isDefined(params.idamage)) {
    ratio = params.idamage / self.maxhealth;

    if(self function_617dea8a(ratio) == "heavy") {
      self.ai.var_7555ca97 = gettime();

      function_ee21651d("<dev string:x219>");
    }
  }
}

function function_4e005f8f(inflictor, attacker, damage, dflags, mod, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(isPlayer(point) && self.team === point.team) {
    return 0;
  }

  damage_type = 1;
  weakpoint = namespace_81245006::function_3131f5dd(self, modelindex, 1);

  if(weakpoint.var_3765e777 === 1 && aiutility::function_e2278a4b(offsettime, hitloc)) {
    damage_type = 2;
  }

  modified_damage = dir;

  if(function_cabc8b69(self)) {
    modified_damage = 0;
    damage_type = 4;
  } else if(!function_6b87eed1()) {
    var_dbf39ac4 = function_60722139(self);
    modified_damage = min(dir, max(0, self.health - var_dbf39ac4));

    if(self.health - modified_damage <= var_dbf39ac4) {
      damage_type = 4;
    }
  }

  if(damage_type === 4) {
    var_5f6e2918 = self.var_95d94ac4;

    if(!isDefined(var_5f6e2918)) {
      var_5f6e2918 = 5;
    }

    if(self ai::is_stunned() && isDefined(self.var_31cadcc9[# "eq_slow_grenade"]) && isDefined(self.var_31cadcc9[# "eq_slow_grenade"].time) && self.var_31cadcc9[# "eq_slow_grenade"].time > gettime() - var_5f6e2918 * 1000) {
      self.var_136c407 = 1;
    }
  }

  if(!aiutility::function_493e5914(hitloc)) {
    boneindex = aiutility::function_cb552839(self);
  }

  self.var_6936b30b = {
    #weakpoint: weakpoint, #var_ebcff177: damage_type
  };
  return modified_damage;
}

function private function_cabc8b69(entity) {
  if(self function_6b87eed1()) {
    return self flag::get("steiner_split_invulnerable");
  } else if(self flag::get("kill_hvt_teleporting")) {
    return 1;
  } else {
    var_dbf39ac4 = function_60722139(self);

    if(self.health <= var_dbf39ac4) {
      return 1;
    }
  }

  return 0;
}

function private function_208c255d(entity) {
  entity flag::set_val("steiner_split_invulnerable", 0);
}

function function_82654cab(enemy) {
  enemypos = groundtrace(enemy.origin + (0, 0, 8), enemy.origin + (0, 0, -100000), 0, enemy)[# "position"];
  return !ispointonnavmesh(enemypos, self getpathfindingradius());
}

function function_bf898e7e(enable) {
  if(isDefined(self)) {
    self.var_216935f8 = is_true(enable);
  }
}

function function_b37b32b9() {
  return isDefined(self) && is_true(self.var_216935f8);
}

function private function_5ac86e25() {
  level endon(#"end_game");
  self endon(#"death", #"entitydeleted");
  var_ef4f2892 = 250;

  if(self function_6b87eed1()) {
    var_ef4f2892 = int(125);
  }

  var_1e2b1cca = var_ef4f2892 * var_ef4f2892;
  var_bb604001 = self gettagorigin("j_head");
  var_8b1f38b5 = var_bb604001[2] - self.origin[2];
  params = getstatuseffect("dot_steiner_radiation_aura");

  while(isDefined(self) && isalive(self)) {
    if(!is_true(self.var_216935f8)) {
      wait 0.2;
      continue;
    }

    players = function_a1ef346b(undefined, self.origin, var_ef4f2892);

    foreach(player in players) {
      if(player inlaststand()) {
        continue;
      }

      if(abs(player.origin[2] - self.origin[2]) > var_8b1f38b5) {
        continue;
      }

      player status_effect::status_effect_apply(params, undefined, self);
    }

    wait 0.2;
  }
}

function function_bc9fe637(s_params) {
  attacker = s_params.eattacker;

  if(isDefined(attacker) && isDefined(attacker.archetype) && attacker.archetype == # "hash_7c0d83ac1e845ac2" && s_params.idamage > 0) {
    if(s_params.smeansofdeath == "MOD_MELEE") {
      attacker function_5a481a84(self);
    }
  }
}

function private function_c235ead4(time) {
  if(!getDvar(#"hash_7bb1af7c8592abdf", 0)) {
    return;
  }

  if(!isDefined(time) || time <= 0) {
    return;
  }

  if(!is_true(self.var_216935f8) && !isDefined(self.var_7f1f0ba)) {
    return;
  }

  self notify(#"hash_2a19d3b2750fdda9");
  self endon(#"death", #"hash_2a19d3b2750fdda9");
  self function_bf898e7e(0);
  var_7f1f0ba = gettime() + int(time * 1000);

  if(isDefined(self.var_7f1f0ba)) {
    self.var_7f1f0ba = int(max(self.var_7f1f0ba, var_7f1f0ba));
  } else {
    self.var_7f1f0ba = var_7f1f0ba;
  }

  while(isalive(self) && isDefined(self.var_7f1f0ba)) {
    if(gettime() >= self.var_7f1f0ba) {
      self function_bf898e7e(1);
      return;
    }

    waitframe(1);
  }
}

function private get_enemy() {
  if(!zm_utility::is_survival()) {
    return (isDefined(self.var_93a62fe) ? self.var_93a62fe : self.enemy);
  }

  if(isentity(self.attackable)) {
    return self.attackable;
  }

  var_36f6524c = zm_ai_utility::function_825317c(self);

  if(isPlayer(var_36f6524c) && var_36f6524c isinvehicle()) {
    var_36f6524c = var_36f6524c getvehicleoccupied();
  }

  if(!isDefined(var_36f6524c)) {
    var_36f6524c = self.favoriteenemy;
  }

  return var_36f6524c;
}

function private function_b860fc37(enemy) {
  return isvehicle(enemy) || isalive(enemy) && (!isPlayer(enemy) || !enemy inlaststand()) && !is_true(enemy.ignoreme) && !enemy isnotarget();
}

function private can_see_enemy() {
  if(!isDefined(self.can_see_enemy)) {
    self.can_see_enemy = 0;
  }

  if(!isDefined(self.var_6ed00311)) {
    self.var_6ed00311 = 0;
  }

  enemy = self get_enemy();

  if(isDefined(enemy) && self.var_6ed00311 < gettime()) {
    self.can_see_enemy = self cansee(enemy);
    self.var_6ed00311 = gettime() + 50;
  }

  return self.can_see_enemy;
}

function private function_880fad96() {
  return self.ai.currentskill != 0;
}

function private function_c124c913(skill) {
  return self.ai.currentskill === skill;
}

function private function_1da02b50(var_b268a2ed) {
  assert(var_b268a2ed >= 0 && var_b268a2ed <= 3);
  self.ai.currentskill = var_b268a2ed;
}

function private function_9ee55afa() {
  self.ai.currentskill = 0;
  self.var_fcca372 = gettime() + int(3 * 1000);
  self notify(#"hash_58f0b0e23afeccb9");
}

function private function_efd416d6() {
  return !is_true(self.var_25e2200c) && (!isDefined(self.var_fcca372) || self.var_fcca372 < gettime());
}

function private function_969dd1ca(var_ada67e63) {
  return self.ai.currentskill === var_ada67e63;
}

function function_af554aaf(enable) {
  if(!isDefined(self)) {
    return;
  }

  var_53bac70d = is_true(self.var_53bac70d);
  self.var_53bac70d = is_true(enable);

  if(var_53bac70d != self.var_53bac70d) {
    self.var_3ad8ef86 = 0;
  }
}

function private function_7a893a7(entity) {
  if(!is_true(entity.var_53bac70d)) {
    return 0;
  }

  if(is_true(entity.var_10552fac)) {
    return 0;
  }

  if(entity function_969dd1ca(1)) {
    return 1;
  }

  enemy = self get_enemy();

  if(!function_b860fc37(enemy)) {
    return 0;
  } else if(!is_true(entity.var_1fa24724)) {
    var_8ff86729 = distance2dsquared(self.origin, enemy.origin);

    if(var_8ff86729 <= 90000) {
      return 0;
    }
  }

  return entity.ai.var_a02f86e7;
}

function private function_baffe829(entity) {
  entity function_1da02b50(1);
}

function private function_fe1e617c(entity) {
  if(isalive(entity)) {
    var_16122b95 = 2 * 0.25;
    cooldown = randomfloatrange(1, 2);
    entity.var_3ad8ef86 = gettime() + int((var_16122b95 + cooldown) * 1000);
    entity.ai.var_a02f86e7 = 0;
    entity.var_f0d59f6d += 1;
    entity.variant_type = 0;

    if(is_true(entity.ai.var_de17c5a5)) {
      entity.variant_type = 2;
      entity.ai.var_de17c5a5 = undefined;
    }

    entity function_9ee55afa();
  }
}

function private function_3aa93442(entity) {
  level endon(#"end_game");
  entity endon(#"death", #"entitydeleted");
  weapon = getweapon(#"hash_2b47921791da6f0");
  tags = ["j_head", "j_head", "j_head"];

  if(entity function_6b87eed1()) {
    tags = ["j_head", "j_head", "j_head"];
  }

  assert(tags.size >= 3);
  count = 0;
  var_8c0e4cc3 = undefined;

  while(count < 3) {
    if(!isalive(entity)) {
      return;
    }

    enemy = entity get_enemy();

    if(function_b860fc37(enemy)) {
      target_origin = enemy.origin;
      velocity = enemy getvelocity();
      dist = distance(entity.origin, target_origin);
      var_b98d779c = dist / weapon.projectilespeed;
      target_origin += velocity * var_b98d779c;
      var_68ff3c95 = enemy.origin[2] - entity.origin[2];

      if(var_68ff3c95 > 80) {
        target_origin += (0, 0, 36);
      } else {
        rand_offset = randomintrange(30, 100);
        rand_x = randomintrange(0, rand_offset);
        rand_y = rand_offset - rand_x;

        if(math::cointoss()) {
          rand_x *= -1;
        }

        if(math::cointoss()) {
          rand_y *= -1;
        }

        target_origin += (rand_x, rand_y, 0);
      }

      if(isDefined(var_8c0e4cc3)) {
        var_5193085 = distancesquared(target_origin, var_8c0e4cc3);

        if(var_5193085 < 2500) {
          rand_x = randomintrange(0, 50);
          rand_y = 50 - rand_x;

          if(math::cointoss()) {
            rand_x *= -1;
          }

          if(math::cointoss()) {
            rand_y *= -1;
          }

          target_origin += (rand_x, rand_y, 0);
        }
      }

      var_21e2ce99 = entity gettagorigin(tags[count]);
      entity playsoundontag(#"hash_67495e1530f787db", tags[count]);

      if(getdvarint(#"hash_77b40b42481ff900", 0)) {
        recordsphere(target_origin, 20, (1, 0, 0));
      }

      magicbullet(weapon, var_21e2ce99, target_origin, entity);
      var_8c0e4cc3 = target_origin;
    }

    count++;

    if(true) {
      wait 0.25;
    }
  }
}

function private function_7709f2df(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7aa37d9f = surfacetype;

  if(isDefined(psoffsettime) && isDefined(boneindex) && isDefined(psoffsettime.team) && isDefined(boneindex.team) && psoffsettime.team == boneindex.team) {
    var_7aa37d9f = 0;
  }

  return var_7aa37d9f;
}

function private function_46f4d406(entity) {
  if(isalive(entity)) {
    level thread function_3aa93442(entity);
  }
}

function private function_829cfcc8(entity) {
  if(entity function_880fad96()) {
    return;
  }

  if(self.ignoreall) {
    return;
  }

  if(!isDefined(entity.var_f8bb81c1)) {
    random = randomintrange(1, 3);
    entity.var_f8bb81c1 = random;
  }

  if(entity function_6b87eed1()) {
    entity.var_f8bb81c1 = 0;
  }

  entity.ai.var_a02f86e7 = 0;
  entity.ai.var_5dc77566 = 0;
  entity.ai.var_b13e6817 = 0;

  if(!entity function_efd416d6()) {
    return;
  }

  enemy = entity get_enemy();

  if(!isDefined(enemy) || !function_b860fc37(enemy)) {
    if(!zm_utility::is_survival()) {
      entity clearentitytarget();
    }

    if(zm_utility::is_classic() && !isDefined(entity.var_cc1c538e)) {
      entity.var_cc1c538e = entity zm_cleanup::get_escape_position();
    }

    if(isDefined(entity.var_cc1c538e)) {
      entity setgoal(entity.var_cc1c538e.origin, 0, 32);
      return;
    }

    if(!zm_utility::is_survival()) {
      entity setgoal(entity.origin, 0, 32);
    }

    return;
  } else {
    entity.var_cc1c538e = undefined;
  }

  if(!zm_utility::is_survival() && function_b860fc37(enemy)) {
    entity setentitytarget(enemy);
  }

  currentvelocity = self getvelocity();
  currentspeed = length(currentvelocity);
  var_eab3f54a = distance2dsquared(entity.origin, enemy.origin);

  if(is_true(entity.var_22b8f534) && entity.var_b52fc691 < gettime() && !function_2bde9dfa(entity) && entity.var_f8bb81c1 <= entity.var_f0d59f6d) {
    var_477db4d3 = currentspeed < 0 ? var_eab3f54a <= 1000000 : var_eab3f54a <= 810000;

    if(var_477db4d3 && entity can_see_enemy()) {
      entity.ai.var_b13e6817 = 1;
      entity.ai.var_5dc77566 = 1;
    }
  } else if(is_true(entity.var_53bac70d) && entity.var_3ad8ef86 < gettime() && !function_2bde9dfa(entity)) {
    var_477db4d3 = currentspeed < 0 ? var_eab3f54a <= 1000000 : var_eab3f54a <= 810000;

    if(var_477db4d3 && entity can_see_enemy()) {
      entity.ai.var_a02f86e7 = 1;
    }
  }

  if(isDefined(entity.ai.var_6d3ee308) && (entity.ai.var_5dc77566 || entity.ai.var_a02f86e7 || zombiebehavior::zombieshouldmeleecondition(entity))) {
    if(entity.ai.var_6d3ee308 < gettime()) {
      entity.variant_type = 0;
    } else {
      entity.variant_type = 1;

      function_ee21651d("<dev string:x233>");
    }

    entity.ai.var_6d3ee308 = undefined;
  }
}

function function_16a8babd(enable) {
  if(!isDefined(self)) {
    return;
  }

  var_22b8f534 = is_true(self.var_22b8f534);
  self.var_22b8f534 = is_true(enable);

  if(var_22b8f534 != self.var_22b8f534) {
    self.var_b52fc691 = 0;
  }
}

function private function_e6d0f1d4(entity) {
  if(!is_true(entity.var_22b8f534)) {
    return false;
  }

  if(is_true(entity.var_10552fac)) {
    return false;
  }

  if(entity function_969dd1ca(2)) {
    return true;
  }

  enemy = self get_enemy();

  if(!function_b860fc37(enemy)) {
    return false;
  } else if(!is_true(entity.var_1fa24724)) {
    var_8ff86729 = distance2dsquared(self.origin, enemy.origin);

    if(var_8ff86729 <= 90000) {
      return false;
    }
  }

  return entity.ai.var_5dc77566 && entity function_52562969();
}

function private function_52562969() {
  if(isDefined(self.var_90c3aec8) && self.var_90c3aec8.size >= 3) {
    return false;
  }

  enemy = self get_enemy();

  if(!function_b860fc37(enemy)) {
    return false;
  } else if(!is_true(self.var_1fa24724)) {
    var_8ff86729 = distance2dsquared(self.origin, enemy.origin);

    if(var_8ff86729 <= 90000) {
      return false;
    }
  }

  return level.var_879dbfb8 < 9;
}

function private function_99608cba(entity) {}

function private function_779b5a9(entity) {}

function private function_4245d56f(entity) {
  if(entity function_52562969()) {
    level.var_879dbfb8++;
    entity.var_4d0d199c = 1;
    entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 1);
    entity function_1da02b50(2);
    return;
  }

  entity.var_4d0d199c = 0;
}

function private function_45fabe41(entity) {
  if(is_true(entity.var_4d0d199c)) {
    entity.var_4d0d199c = 0;
  }

  cooldown = randomfloatrange(3, 5);

  if(entity function_6b87eed1()) {
    cooldown = randomfloatrange(1, 2.5);
  }

  entity.var_b52fc691 = gettime() + int(cooldown * 1000);
  entity.ai.var_5dc77566 = 0;
  entity.var_f0d59f6d = 0;
  entity.var_f8bb81c1 = undefined;
  entity.variant_type = 0;

  if(is_true(entity.ai.var_de17c5a5)) {
    entity.variant_type = 3;
    entity.ai.var_de17c5a5 = undefined;
  }

  entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 0);
  entity function_9ee55afa();
}

function private function_7ff0ce68(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  var_7aa37d9f = surfacetype;

  if(isDefined(psoffsettime) && isDefined(boneindex) && isDefined(psoffsettime.team) && isDefined(boneindex.team) && psoffsettime.team == boneindex.team) {
    var_7aa37d9f = 0;
  }

  return var_7aa37d9f;
}

function private function_bf8080c1(entity) {
  entity clientfield::set("steiner_radiation_bomb_prepare_fire_clientfield", 0);
  var_c29d35bd = getweapon(#"hash_67307aa00ad6f686");
  enemy = entity get_enemy();

  if(!function_b860fc37(enemy)) {
    return false;
  }

  var_dd6bc3a6 = var_c29d35bd.projectilespeed;
  var_8598bad6 = entity gettagorigin("tag_bombthrower_FX");

  if(!isDefined(var_8598bad6)) {
    return false;
  }

  var_6b98218b = enemy gettagorigin("j_ankle_ri");

  if(!isDefined(var_6b98218b)) {
    var_6b98218b = enemy.origin;
  }

  var_c9c9e975 = enemy gettagorigin("j_ankle_le");

  if(!isDefined(var_c9c9e975)) {
    var_c9c9e975 = enemy.origin;
  }

  if(!bullettracepassed(var_8598bad6, var_6b98218b, 0, self) && !bullettracepassed(var_8598bad6, var_c9c9e975, 0, self)) {
    var_dd6bc3a6 /= 2;
  }

  target_dist = distance(self.origin, enemy.origin);
  var_b6897326 = target_dist / var_dd6bc3a6;
  rand = randomfloatrange(0.5, 1);
  var_b6897326 += rand;
  var_6e3ad56b = enemy.origin;

  if(isPlayer(enemy)) {
    velocity = enemy getvelocity();
    var_6e3ad56b += velocity * var_b6897326;
  }

  target_pos = groundtrace(enemy.origin + (0, 0, 64), enemy.origin + (0, 0, -100000), 0, enemy)[# "position"];
  angles = vectortoangles(target_pos - entity.origin);
  dir = anglesToForward(angles);
  dist = distance(var_8598bad6, target_pos);
  velocity = dir * var_dd6bc3a6;
  to_target = target_pos - var_8598bad6;
  time = length((to_target[0], to_target[1], to_target[2])) / var_dd6bc3a6;
  launch_speed = (to_target[2] + 0.5 * getdvarfloat(#"bg_lowgravity", 400) * sqr(time)) / time;
  velocity = (velocity[0], velocity[1], launch_speed);
  entity playsoundontag(#"hash_24961baa62849a57", "tag_bombthrower_FX");

  if(getdvarint(#"hash_65abc910bc611782", 0)) {
    recordsphere(target_pos, 16, (0, 1, 0));
    recordline(var_8598bad6, target_pos, (0, 1, 0));
    function_ee21651d("<dev string:x26c>" + enemy.origin + "<dev string:x29c>" + target_pos);
    i = 0;

    while(i <= time) {
      height = var_8598bad6[2] + launch_speed * i - 0.5 * getdvarfloat(#"bg_lowgravity", 400) * sqr(i);
      debug_pos = (var_8598bad6[0] + velocity[0] * i, var_8598bad6[1] + velocity[1] * i, height);
      recordsphere(debug_pos, 8, (0, 1, 0));
      i += 0.1;
    }
  }

  grenade = entity magicgrenadetype(var_c29d35bd, var_8598bad6, velocity);

  if(isDefined(grenade)) {
    grenade.owner = entity;
    grenade.team = entity.team;
    grenade thread function_a56050b0();
  }

  return true;
}

function private function_2bde9dfa(entity) {
  if(entity.ai.var_5dc77566 || entity.ai.var_b13e6817) {
    return 1;
  }

  return 0;
}

function private function_a56050b0() {
  level endon(#"end_game");
  self endon(#"entitydeleted");
  owner = self.owner;
  self setModel("tag_origin");
  waitframe(1);
  self clientfield::set("radiation_bomb_trail_fx_clientfield", 1);
  s_waitresult = self waittill(#"death", #"projectile_impact_explode", #"explode", #"hash_38b24dfa52842786");

  if(s_waitresult._notify == "death") {
    self deletedelay();
    s_waitresult = self waittilltimeout(float(function_60d95f53()) / 1000, #"projectile_impact_explode", #"explode", #"hash_38b24dfa52842786");

    if(s_waitresult._notify == "timeout") {
      return;
    }
  }

  if(isalive(owner) && s_waitresult._notify == "projectile_impact_explode") {
    function_ee21651d("<dev string:x2b1>" + self.origin + "<dev string:x2d8>" + s_waitresult.position);

    if(getdvarint(#"hash_65abc910bc611782", 0)) {
      recordsphere(self.origin, 16, (0, 1, 0));
    }

    var_b308e59c = util::spawn_model("tag_origin", s_waitresult.position, s_waitresult.normal);
    var_b308e59c clientfield::set("radiation_bomb_play_landed_fx", 1);
    var_b308e59c.owner = owner;
    owner function_4d70c1d3(var_b308e59c);
    var_b308e59c thread function_fac064dc();
  }

  self clientfield::set("radiation_bomb_trail_fx_clientfield", 0);
}

function private function_4d70c1d3(ent) {
  if(!isDefined(self.var_90c3aec8)) {
    self.var_90c3aec8 = [];
  }

  if(!isDefined(self.var_90c3aec8)) {
    self.var_90c3aec8 = [];
  } else if(!isarray(self.var_90c3aec8)) {
    self.var_90c3aec8 = array(self.var_90c3aec8);
  }

  self.var_90c3aec8[self.var_90c3aec8.size] = ent;
}

function private function_f2cb8145(var_ec2c535e, destroyed) {
  if(is_true(destroyed)) {
    self clientfield::set("radiation_bomb_play_landed_fx", 2);
  } else {
    self clientfield::set("radiation_bomb_play_landed_fx", 0);
  }

  if(is_true(var_ec2c535e) && isDefined(self.owner) && isDefined(self.owner.var_90c3aec8)) {
    arrayremovevalue(self.owner.var_90c3aec8, self);
  }

  if(is_true(self.var_5d15d0b2)) {
    return;
  }

  self.var_5d15d0b2 = 1;
  util::wait_network_frame();
  level.var_879dbfb8--;
  assert(level.var_879dbfb8 >= 0);

  if(isDefined(self.trigger_damage)) {
    self.trigger_damage delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function private function_4b193227() {
  if(!isDefined(self.var_90c3aec8) || !self.var_90c3aec8.size) {
    return;
  }

  array::thread_all(self.var_90c3aec8, &function_f2cb8145, 0);
  self.var_90c3aec8 = [];
}

function private function_fac064dc() {
  level endon(#"end_game");
  self endon(#"death");
  self thread function_5afaa306(128);
  var_6f13bbe0 = gettime() + int(10000);
  origin = self.origin;
  owner = self.owner;
  weapon = getweapon(#"tear_gas");
  params = getstatuseffect("dot_steiner_radiation_bomb");

  while(gettime() < var_6f13bbe0) {
    alive_players = function_a1ef346b(undefined, origin, 128);

    foreach(player in alive_players) {
      var_2df27ba0 = 0;
      in_vehicle = player isinvehicle();

      if(in_vehicle) {
        vehicle = player getvehicleoccupied();
        var_2df27ba0 = is_true(vehicle.var_9a6644f2);
      }

      height = abs(origin[2] - player.origin[2]);

      if(player laststand::player_is_in_laststand() === 0 && height <= 72 && !var_2df27ba0) {
        player status_effect::status_effect_apply(params, weapon, self);
      }
    }

    var_15978c43 = getentitiesinradius(origin, 128, 12);

    foreach(vehicle in var_15978c43) {
      self namespace_85745671::function_2713ff17(vehicle, 25);
    }

    wait 0.2;
  }

  self thread function_f2cb8145(1);
}

function private function_5afaa306(trigger_radius) {
  self endon(#"death");
  self.trigger_damage = spawn("trigger_damage", self.origin, 0, trigger_radius, 24);
  self.trigger_damage endon(#"death");

  while(true) {
    s_result = self.trigger_damage waittill(#"damage");

    if(isPlayer(s_result.attacker)) {
      if(isDefined(s_result.weapon) && namespace_b376a999::function_5fef4201(s_result.weapon)) {
        self thread function_f2cb8145(1, 1);

        if(is_true(s_result.var_98e101b0)) {
          s_result.attacker thread function_410ca78d(self.origin);
        }

        return;
      }
    }
  }
}

function private function_410ca78d(center) {
  self endon(#"death", #"weapon_switch_started");
  level endon(#"game_ended");
  waittime = 1;

  while(waittime > 0) {
    if(!mayspawnentity()) {
      break;
    }

    rotation = randomint(360);
    start_pos = center + (cos(rotation), sin(rotation), 0) * randomint(128);
    level thread namespace_b376a999::function_6dbf1bb3(self, 3, start_pos);
    waittime -= 0.05;
    wait 0.05;
  }
}

function private function_fc9189dd(entity) {
  if(isalive(entity)) {
    function_bf8080c1(entity);
  }
}

function private function_ac56fb75() {
  level endon(#"end_game");
  self endon(#"death", #"entitydeleted");

  if(!isalive(self)) {
    return;
  }

  if(is_true(self.var_8576e0be) || is_true(self.var_9b474709)) {
    return;
  }

  if(!self.ai.cansplit) {
    self thread function_735ef74d();
    return;
  }

  if(self function_880fad96()) {
    self.var_9b474709 = 1;
    waitresult = self waittill(#"hash_58f0b0e23afeccb9", #"stop_wait_for_split");

    if(!isalive(self) || waitresult._notify == "stop_wait_for_split") {
      return;
    }

    self.var_9b474709 = 0;
  }

  while(getailimit() - getaicount() < 2) {
    function_ee21651d("<dev string:x2eb>");

    waitframe(1);
  }

  self.var_8576e0be = 1;
  self.var_c3083789 = 1;

  if(isPlayer(self.attacker)) {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: self.attacker, #scoreevent: "steiner_split_zm"});

    if(is_true(self.var_136c407)) {
      self.attacker zm_stats::increment_challenge_stat(#"hash_4ec43679ab49c017");
    }
  }

  self function_1da02b50(3);
  health = int(self.maxhealth * 1);

  if(self function_1e521615()) {
    health = int(self.maxhealth * 0.25);
  }

  if(isDefined(level.var_c42bdd1b)) {
    var_9f7c58e6 = level.var_c42bdd1b;

    if(self function_1e521615()) {
      if(isDefined(level.var_68b26ea)) {
        var_9f7c58e6 = level.var_68b26ea;
      } else {
        var_9f7c58e6 = # "hash_7f957e36b4f6160f";
      }
    }
  } else {
    var_9f7c58e6 = # "spawner_zm_steiner_split_radiation_blast";

    if(self function_1e521615()) {
      var_9f7c58e6 = # "hash_7f957e36b4f6160f";
    }
  }

  if(isDefined(level.var_dc38daf)) {
    var_a0024591 = level.var_dc38daf;

    if(self function_1e521615()) {
      if(isDefined(level.var_887c5017)) {
        var_a0024591 = level.var_887c5017;
      } else {
        var_a0024591 = # "hash_6904f5c7bef64405";
      }
    }
  } else {
    var_a0024591 = # "spawner_zm_steiner_split_radiation_bomb";

    if(self function_1e521615()) {
      var_a0024591 = # "hash_6904f5c7bef64405";
    }
  }

  var_188c5348 = self.var_fde10e1d === 30;
  var_c0bfa8c2 = !isDefined(self.var_fde10e1d);
  var_33867b8b = self function_eafb4701(var_9f7c58e6, self, health, var_188c5348, var_c0bfa8c2);
  var_863c0d4d = self function_eafb4701(var_a0024591, self, health, var_188c5348, var_c0bfa8c2);
  function_7fd70892(var_33867b8b, var_863c0d4d);

  if(isDefined(var_33867b8b) && isDefined(var_863c0d4d)) {
    var_33867b8b.var_e293f8ac = [];

    if(!isDefined(var_33867b8b.var_e293f8ac)) {
      var_33867b8b.var_e293f8ac = [];
    } else if(!isarray(var_33867b8b.var_e293f8ac)) {
      var_33867b8b.var_e293f8ac = array(var_33867b8b.var_e293f8ac);
    }

    if(!isinarray(var_33867b8b.var_e293f8ac, var_863c0d4d)) {
      var_33867b8b.var_e293f8ac[var_33867b8b.var_e293f8ac.size] = var_863c0d4d;
    }

    var_863c0d4d.var_e293f8ac = [];

    if(!isDefined(var_863c0d4d.var_e293f8ac)) {
      var_863c0d4d.var_e293f8ac = [];
    } else if(!isarray(var_863c0d4d.var_e293f8ac)) {
      var_863c0d4d.var_e293f8ac = array(var_863c0d4d.var_e293f8ac);
    }

    if(!isinarray(var_863c0d4d.var_e293f8ac, var_33867b8b)) {
      var_863c0d4d.var_e293f8ac[var_863c0d4d.var_e293f8ac.size] = var_33867b8b;
    }

    var_33867b8b.var_24f0cbe0 = self function_7f0363e8(1);
    var_863c0d4d.var_24f0cbe0 = self function_7f0363e8(1);
  }

  if(isDefined(self.var_9d59692c)) {
    self[[self.var_9d59692c]](var_33867b8b, var_863c0d4d);
  }

  debug_str = isDefined(var_33867b8b) ? "<dev string:x31a>" + var_33867b8b getentitynumber() + "<dev string:x333>" + health : "<dev string:x344>";
  function_ee21651d(debug_str);
  debug_str = isDefined(var_863c0d4d) ? "<dev string:x366>" + var_863c0d4d getentitynumber() + "<dev string:x333>" + health : "<dev string:x37e>";
  function_ee21651d(debug_str);

  self function_bf898e7e(0);
  self pathmode("dont move");
  self.suicidaldeath = 1;
  waitframe(1);
  self notify(#"spawned_split_ai");
  self function_9ee55afa();
  self thread function_735ef74d();
}

function private function_eafb4701(aitype, location, health, var_188c5348, var_c0bfa8c2) {
  if(!isDefined(location.angles)) {
    angles = (0, 0, 0);
  } else {
    angles = location.angles;
  }

  entity = spawnactor(aitype, location.origin, angles);

  if(!isDefined(entity)) {
    return;
  }

  entity notify(#"split_intro", {
    #origin: location.origin, #angles: angles, #var_188c5348: var_188c5348, #var_c0bfa8c2: var_c0bfa8c2
  });
  entity.maxhealth = health;
  entity.health = health;
  entity setmaxhealth(health);
  entity.ignore_enemy_count = 1;
  return entity;
}

function function_7fd70892(var_f6aecc0e, var_5a069f1) {
  if(isDefined(var_f6aecc0e) && isDefined(var_5a069f1)) {
    var_f6aecc0e settwin(var_5a069f1);
    var_5a069f1 settwin(var_f6aecc0e);
  }
}

function private settwin(brother) {
  self.hastwin = 1;
  self.twin = brother;
}

function private function_9cc1ebd1() {
  return is_true(self.hastwin) && !isalive(self.twin);
}

function private function_3c494a14() {
  self endon(#"death");
  self.var_8576e0be = 1;
  waitresult = self waittilltimeout(1, #"split_intro");

  if(waitresult._notify == # "timeout") {
    return;
  }

  self pathmode("dont move", 1);
  self ghost();
  self dontinterpolate();
  self forceteleport(waitresult.origin, waitresult.angles);
  waitframe(1);
  self show();
  animation = is_true(waitresult.var_188c5348) ? # "ai_t9_zm_steiner_left_com_pain_split_01" : is_true(waitresult.var_c0bfa8c2) ? # "hash_4f7125d4a1219db1" : # "ai_t9_zm_steiner_left_com_pain_split_01_wide";

  if(self function_ba878b50()) {
    animation = is_true(waitresult.var_188c5348) ? # "ai_t9_zm_steiner_right_com_pain_split_01" : is_true(waitresult.var_c0bfa8c2) ? # "hash_6703e70213b1b7e4" : # "ai_t9_zm_steiner_right_com_pain_split_01_wide";
  }

  self.var_3a51c5dc = animation;
  self.var_188c5348 = waitresult.var_188c5348;
  self notify(#"hash_200053f79d3c5c19");
  self animcustom(&split_intro_run, &split_intro_end, "split_intro_run", "split_intro_end");
}

function split_intro_run() {
  self endoncallback(&function_5311b652, #"death", #"killanimscript");
  self val::set(#"split_intro", "ignoreall", 1);
  self ai::disable_pain();
  self.ignore_all_poi = 1;

  if(self isragdoll()) {
    return;
  }

  self orientmode("face angle", self.angles[1]);
  self animmode("noclip");
  self pathmode("dont move", 1);
  self animscripted(self.var_3a51c5dc, self.origin, self.angles, self.var_3a51c5dc, "custom");
  self thread function_51fb171c();
  var_74ee8be8 = getnotetracktimes(self.var_3a51c5dc, "noclip_end")[0];

  if(isDefined(var_74ee8be8)) {
    var_74ee8be8 *= getanimlength(self.var_3a51c5dc);
  } else {
    var_74ee8be8 = 0;
  }

  wait var_74ee8be8;
  self animmode("gravity");
  wait getanimlength(self.var_3a51c5dc) - var_74ee8be8;
}

function split_intro_end() {
  if(isalive(self)) {
    self.var_8576e0be = 0;
    self val::reset(#"split_intro", "ignoreall");
    self ai::enable_pain();
    self.ignore_all_poi = 0;
    self.var_3a51c5dc = undefined;
    self pathmode("move allowed");
  }
}

function function_5311b652(str_notify) {
  if(str_notify === # "death") {
    self zm_utility::start_ragdoll();
  }
}

function private function_b46c0796(entity) {
  var_87222bcb = function_60722139(entity);

  if(isalive(entity) && is_true(entity.var_8d1d18aa) && entity.health <= var_87222bcb && !is_true(entity.marked_for_death)) {
    if(!entity function_3108de07(60)) {
      entity function_3108de07(30);
    }

    if(!is_true(entity.var_8576e0be)) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function private function_60722139(entity) {
  var_87222bcb = entity.var_94378ef;
  return ceil(var_87222bcb);
}

function private function_363c063(entity) {
  entity orientmode("face default");
  level notify(#"hash_2f3cb0b1b50d517a");
}

function private function_380fc4a5(entity) {
  entity clientfield::increment("steiner_perform_split_clientfield");
  entity thread function_ac56fb75();
}

function private function_3108de07(var_fde10e1d) {
  var_f62bfdc0 = anglestoright(self.angles);
  var_8e6411bf = var_f62bfdc0 * var_fde10e1d;
  startposition = function_9cc082d2(self.origin, 30);
  startposition = isDefined(startposition[# "point"]) ? startposition[# "point"] : self.origin;
  rightposition = function_9cc082d2(startposition + var_8e6411bf, var_fde10e1d);
  rightposition = isDefined(rightposition[# "point"]) ? rightposition[# "point"] : undefined;
  var_d9ca447f = isDefined(rightposition) && distancesquared(startposition, rightposition) + 1 >= sqr(var_fde10e1d) && bullettracepassed(startposition + (0, 0, 30), rightposition + (0, 0, 30) + var_f62bfdc0 * self getpathfindingradius(), 0, self);
  leftposition = function_9cc082d2(startposition - var_8e6411bf, var_fde10e1d);
  leftposition = isDefined(leftposition[# "point"]) ? leftposition[# "point"] : undefined;
  var_290edef9 = isDefined(leftposition) && distancesquared(startposition, leftposition) + 1 >= sqr(var_fde10e1d) && bullettracepassed(startposition + (0, 0, 30), leftposition + (0, 0, 30) - var_f62bfdc0 * self getpathfindingradius(), 0, self);

  if(var_d9ca447f && var_290edef9) {
    function_ee21651d("<dev string:x39f>" + self.origin + "<dev string:x3b8>" + var_fde10e1d);

    self.var_fde10e1d = var_fde10e1d;
    return true;
  }

  if(level.var_a71c09f8) {
    if(isDefined(rightposition)) {
      color = is_true(var_d9ca447f) ? (0, 1, 0) : (1, 0, 0);
      recordsphere(rightposition, 2, color);
      recordline(startposition + (0, 0, 30), rightposition + (0, 0, 30), color);
    }

    if(isDefined(leftposition)) {
      color = is_true(var_290edef9) ? (0, 1, 0) : (1, 0, 0);
      recordsphere(leftposition, 2, color);
      recordline(startposition + (0, 0, 30), leftposition + (0, 0, 30), color);
    }
  }

  function_ee21651d("<dev string:x3cb>" + self.origin);

  return false;
}

function private function_51fb171c() {
  ents = getaiarchetypearray(#"zombie");
  var_9762dbfe = is_true(self.var_188c5348) ? 30 : 60;
  var_3521085c = sqr(var_9762dbfe);

  foreach(ent in ents) {
    if(is_true(ent.knockdown)) {
      continue;
    }

    if(gibserverutils::isgibbed(ent, 384)) {
      continue;
    }

    if(distancesquared(ent.origin, self.origin) > var_3521085c) {
      continue;
    }

    ent thread zombie_utility::setup_zombie_knockdown(self);
  }
}

function private function_fb61fd57(entity) {
  if(entity.ai.var_fad877bf) {
    return 1;
  }

  return 0;
}

function private function_d33f94e(entity) {}

function private function_4b63f114(entity) {
  entity.ai.var_fad877bf = 0;
}

function private function_15c1e3df(entity) {
  if(is_true(entity.var_10552fac)) {
    return false;
  }

  if(function_fb61fd57(entity)) {
    return true;
  }

  if(function_e9e122fa(entity) && function_b52cb76c(entity) && zombiebehavior::function_1b8c9407(entity)) {
    return true;
  }

  return false;
}

function private function_b52cb76c(entity) {
  if(is_true(entity.suicidaldeath)) {
    return false;
  }

  if(!hasasm(entity)) {
    return false;
  }

  return !is_true(entity.missinglegs);
}

function private function_e9e122fa(entity) {
  if(isDefined(entity.ai.var_7555ca97) && gettime() - entity.ai.var_7555ca97 < 2500) {
    if(entity function_c124c913(1) || entity function_c124c913(2)) {
      entity.ai.var_de17c5a5 = 1;
    }

    function_ee21651d("<dev string:x3e7>" + entity getentitynumber() + "<dev string:x3f3>");

    return true;
  }

  return false;
}

function function_617dea8a(ratio) {
  if(ratio >= 0.33) {
    return "heavy";
  }

  return "light";
}

function private function_218044b0(entity) {
  entity.ai.var_7555ca97 = undefined;

  if(entity.variant_type === 2 || entity.variant_type === 3) {
    entity.variant_type = 0;
  }

  if(is_true(entity.ai.var_fad877bf)) {
    entity.ai.var_fad877bf = 0;
  }
}

function function_b077b73d(time) {
  if(!isDefined(time) || time <= 0) {
    return;
  }

  self thread function_392a816a(time);
}

function private function_392a816a(time) {
  if(is_true(self.var_8576e0be)) {
    return;
  }

  if(!is_true(self.var_8d1d18aa) && !isDefined(self.var_e1f39584)) {
    return;
  }

  self notify(#"hash_1126b46a114399d");
  self endon(#"death", #"hash_1126b46a114399d");

  function_ee21651d("<dev string:x40c>");

  self.var_8d1d18aa = 0;

  if(is_true(self.var_9b474709)) {
    self notify(#"stop_wait_for_split");
    self.var_9b474709 = 0;
  }

  var_e1f39584 = gettime() + int(time * 1000);

  if(isDefined(self.var_e1f39584)) {
    self.var_e1f39584 = int(max(self.var_e1f39584, var_e1f39584));
  } else {
    self.var_e1f39584 = var_e1f39584;
  }

  while(isalive(self) && isDefined(self.var_e1f39584)) {
    if(gettime() >= self.var_e1f39584) {
      self.var_8d1d18aa = 1;

      function_ee21651d("<dev string:x437>");

      return;
    }

    waitframe(1);
  }
}

function private function_d778b630(entity) {
  entity.ai.var_76786d9c = 0;
  entity.ai.var_80045105 = gettime();
}

function private function_46e10c70(entity) {
  if(entity.ai.var_76786d9c) {
    entity.ai.var_fad877bf = 1;
    entity.ai.var_76786d9c = 0;
    return 4;
  }

  return 5;
}

function private function_44c1658c(entity) {
  entity.variant_type = 0;
}

function private function_5a481a84(player) {
  dist = distance(self.origin, player.origin);
  targetorigin = (player.origin[0], player.origin[1], self.origin[2]);
  var_a6470558 = vectornormalize(targetorigin - self.origin);
  aimeleerange = self.meleeweapon.aimeleerange;
  var_32708f81 = 100 + aimeleerange;
  var_8cf8f805 = mapfloat(0, aimeleerange, 100, var_32708f81, dist);
  player playerknockback(1);
  player applyknockback(int(var_8cf8f805), var_a6470558);
  player playerknockback(0);
}

function private function_6e3a88b1(entity) {
  function_ee21651d("<dev string:x449>");

  function_d778b630(entity);
  entity.ai.var_ae3359f = 1;
}

function private function_a14fcce8(entity) {
  function_ee21651d("<dev string:x464>");

  entity.ai.var_ae3359f = 0;
  entity function_fc82d5c7();
}

function private function_fc82d5c7() {
  self.ai.var_4902424b = gettime() + 5000;
  self.zombie_move_speed = "walk";

  function_ee21651d("<dev string:x483>");
}

function function_7cac529b(behaviortreeentity) {
  if(isDefined(behaviortreeentity.var_9ecae3b4) || isDefined(behaviortreeentity.var_cc1c538e) && !behaviortreeentity isatgoal()) {
    return 1;
  }

  if(behaviortreeentity getpathmode() == "dont move" || behaviortreeentity.ignoreall) {
    return 0;
  }

  if(is_true(behaviortreeentity.ai.var_48ae6dbf)) {
    return 1;
  }

  if(is_true(behaviortreeentity.ai.var_db6715c9)) {
    return 1;
  }

  if(isDefined(behaviortreeentity.ai.var_5810aebe) && behaviortreeentity.ai.var_5810aebe > gettime()) {
    return 0;
  }

  if(behaviortreeentity.ai.var_3dbed9a0 > gettime()) {
    return 1;
  }

  enemy = behaviortreeentity get_enemy();

  if(isDefined(enemy) && function_b860fc37(enemy)) {
    var_eab3f54a = distance2dsquared(behaviortreeentity.origin, enemy.origin);
    canseeenemy = behaviortreeentity can_see_enemy();
    return behaviortreeentity function_3e6b7dd4(enemy, var_eab3f54a, canseeenemy);
  } else if(is_true(self.ai.var_870d0893) && self haspath()) {
    return 1;
  }

  return 0;
}

function function_3bdb520f(entity) {
  if(is_true(entity.ai.var_d9f167ee) && !isDefined(entity.ai.var_f38a2e83)) {
    entity.ai.var_f38a2e83 = gettime();

    function_ee21651d("<dev string:x4a4>");
  }

  return true;
}

function function_2154581b(behaviortreeentity) {
  if(function_7a893a7(behaviortreeentity) || function_e6d0f1d4(behaviortreeentity)) {
    behaviortreeentity clearpath();

    function_ee21651d("<dev string:x4c1>");
  }

  if(isDefined(behaviortreeentity.ai.var_f38a2e83) && behaviortreeentity.ai.var_f38a2e83 + 10000 <= gettime()) {
    behaviortreeentity function_fc82d5c7();
    behaviortreeentity.ai.var_f38a2e83 = undefined;
  }

  return true;
}

function private function_7b89edb0(behaviortreeentity) {
  if(!behaviortreeentity function_dd070839()) {
    behaviortreeentity clearpath();
  }

  behaviortreeentity.ai.var_3dbed9a0 = gettime();

  function_ee21651d("<dev string:x4f4>");

  return true;
}

function function_553ec0ae(behaviortreeentity) {
  behaviortreeentity.ai.var_48ae6dbf = 1;

  function_ee21651d("<dev string:x512>");

  return true;
}

function function_f60a1f74(behaviortreeentity) {
  behaviortreeentity.ai.var_48ae6dbf = 0;

  function_ee21651d("<dev string:x535>");

  return true;
}

function function_efc7dca5(behaviortreeentity) {
  return behaviortreeentity.ai.var_e875a95c;
}

function private function_3e6b7dd4(enemy, var_eab3f54a, canseeenemy) {
  radiussqr = sqr(self getpathfindingradius());

  if(!isDefined(enemy)) {
    self clearpath();
    return false;
  }

  if(var_eab3f54a <= radiussqr) {
    self clearpath();
    return false;
  }

  goal = getclosestpointonnavmesh(enemy.origin, 128, 30);

  if(!isDefined(goal)) {
    function_ee21651d("<dev string:x557>" + enemy.origin);

    var_515f97cf = 1000;

    if(var_eab3f54a < 1000000) {
      var_515f97cf = sqrt(var_eab3f54a);
    }

    goal = getrandomnavpoint(enemy.origin, var_515f97cf, 30);
  }

  if(isDefined(goal)) {
    var_57e5ec79 = distancesquared(enemy.origin, goal);
    var_600ef3ea = var_57e5ec79 > 1024;

    if(is_true(var_600ef3ea) && is_true(canseeenemy) && isPlayer(enemy) && isDefined(self.var_2d5cbb7[enemy getentitynumber()])) {
      var_cd8d027d = self.var_2d5cbb7[enemy getentitynumber()].dist;
      var_f4bc864a = distancesquared(self.origin, goal);

      if(var_cd8d027d >= var_f4bc864a * 9) {
        var_98f31071 = checknavmeshdirection(self.origin, enemy.origin - self.origin, distance(self.origin, enemy.origin), self getpathfindingradius());
        var_2bd124ce = distancesquared(enemy.origin, var_98f31071);

        if(var_2bd124ce < 1000000 || var_2bd124ce < 1000000) {
          goal = var_98f31071;
          var_eab3f54a = distance2dsquared(self.origin, goal);

          if(var_eab3f54a <= radiussqr) {
            function_ee21651d("<dev string:x58c>" + self.origin);

            self clearpath();
            return false;
          } else {
            function_ee21651d("<dev string:x59f>" + goal + "<dev string:x5b9>");
            function_ee21651d("<dev string:x5dd>" + sqrt(var_2bd124ce) + "<dev string:x601>" + sqrt(var_57e5ec79));
          }
        }
      }
    }

    if(zm_utility::is_survival()) {
      if(is_true(self.var_1fa24724) && isDefined(level.var_d1a2ae79)) {
        var_8d66aa5c = [[level.var_d1a2ae79]](self, goal);

        if(isDefined(var_8d66aa5c)) {
          goal = var_8d66aa5c;
        }
      }

      namespace_e292b080::zombieupdategoal(goal);
    } else {
      self setgoal(goal);
    }

    if(self haspath()) {
      self setblackboardattribute("_run_n_gun_variation", "variation_forward");
      self.ai.var_3dbed9a0 = gettime() + 1000;
      self function_21746f2d(var_eab3f54a);
    } else {
      function_ee21651d("<dev string:x623>" + self.origin + "<dev string:x211>" + goal);
    }
  } else {
    function_ee21651d("<dev string:x648>" + self.origin + "<dev string:x663>");
  }

  if(self.ai.var_3dbed9a0 <= gettime()) {
    self.ai.var_d9f167ee = 0;
    self.ai.var_f38a2e83 = undefined;
  }

  return self.ai.var_3dbed9a0 > gettime();
}

function private function_a788e366(var_eab3f54a, canseeenemy) {
  if(is_true(self.ai.var_bb06b848)) {
    return false;
  }

  if(var_eab3f54a > 360000 || var_eab3f54a < 10000) {
    return false;
  }

  if(is_true(canseeenemy)) {
    return false;
  }

  return true;
}

function private function_bb5d7e92(var_5920d6a6, enemy) {
  right = anglestoright(self.angles);
  var_900963e4 = is_true(enemy) ? -1 : 1;
  strafedist = randomintrange(100, 300);
  targetpoint = self.origin + vectorscale(right, strafedist * var_900963e4);
  nav_mesh = getclosestpointonnavmesh(targetpoint, self getpathfindingradius(), 30);

  if(isDefined(nav_mesh) && tracepassedonnavmesh(self.origin, nav_mesh, self getpathfindingradius()) && sighttracepassed(self.origin + (0, 0, 80), nav_mesh + (0, 0, 30), 0, self)) {
    if(self haspath()) {
      self setblackboardattribute("_run_n_gun_variation", enemy ? "variation_strafe_1" : "variation_strafe_2");
      attribute = self getblackboardattribute("_run_n_gun_variation");
      self setgoal(nav_mesh);
      self.ignore_find_flesh = 1;
      return true;
    }
  }

  return false;
}

function private function_8e782bd8(behaviortreeentity) {
  attribute = behaviortreeentity getblackboardattribute("_run_n_gun_variation");

  if(behaviortreeentity getblackboardattribute("<dev string:x674>") === "<dev string:x68c>") {
    function_ee21651d("<dev string:x6a2>");
  } else if(behaviortreeentity getblackboardattribute("<dev string:x674>") === "<dev string:x6c0>") {
    function_ee21651d("<dev string:x6d6>");
  } else {
    function_ee21651d("<dev string:x6f5>");
  }

  behaviortreeentity.ai.var_db6715c9 = 1;
}

function private function_850378bc(behaviortreeentity) {
  if(behaviortreeentity isatgoal()) {
    behaviortreeentity.ignore_find_flesh = 0;
    behaviortreeentity.ai.var_db6715c9 = 0;

    function_ee21651d("<dev string:x740>");

    return 4;
  }

  return 5;
}

function private function_c9181afb(behaviortreeentity) {
  function_ee21651d("<dev string:x75e>");

  behaviortreeentity.ignore_find_flesh = 0;
  behaviortreeentity.ai.var_db6715c9 = 0;
}

function function_e6b7aa9d(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_48ae6dbf)) {
    return false;
  }

  return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_walk";
}

function function_dab44559(behaviortreeentity) {
  if(is_true(behaviortreeentity.ai.var_48ae6dbf)) {
    return false;
  }

  return behaviortreeentity getblackboardattribute("_locomotion_speed_zombie") === "locomotion_speed_run";
}

function private function_21746f2d(var_eab3f54a) {
  if(isDefined(self.ai.var_4902424b) && self.ai.var_4902424b > gettime()) {
    self.zombie_move_speed = "walk";
    return;
  }

  if(!is_true(self.ai.var_d9f167ee) && (var_eab3f54a <= 90000 || is_true(self.var_10552fac))) {
    self.ai.var_d9f167ee = 1;

    function_ee21651d("<dev string:x775>");
  }

  var_533af8f8 = !is_true(self.ai.var_e93366a);

  if(var_eab3f54a > 90000 && var_eab3f54a <= 562500 && !is_true(self.ai.var_8c8fb85a)) {
    var_533af8f8 = 0;
  }

  isrunning = self.zombie_move_speed == "run";

  if(var_533af8f8 != isrunning) {
    if(var_533af8f8) {
      currentvelocity = self getvelocity();
      currentspeed = length(currentvelocity);

      if(!isrunning || currentspeed > 0) {
        self.zombie_move_speed = "run";
        self.ai.rundelay = undefined;

        function_ee21651d("<dev string:x793>");
      }

      return;
    }

    self.zombie_move_speed = "walk";

    function_ee21651d("<dev string:x7ae>");
  }
}

function private function_29744716(entity) {
  return entity.ai.var_b90dccd6;
}

function private function_2745a754(entity) {
  return entity.ai.var_8c90ae8e && !entity.ai.var_a49798e7;
}

function private function_bf6d273f(entity) {}

function private function_bd9179c(entity) {}

function function_dede41c0() {
  enemy = self get_enemy();

  if(!zm_utility::is_survival()) {
    if(isDefined(enemy) && function_b860fc37(enemy)) {
      predictedpos = self lastknownpos(enemy);

      if(isDefined(predictedpos)) {
        turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
        return turnyaw;
      }
    }

    codegoal = self function_4794d6a3();

    if(isDefined(codegoal.goalangles)) {
      turnyaw = absangleclamp360(self.angles[1] - codegoal.goalangles[1]);
      return turnyaw;
    }
  } else {
    pos = undefined;

    if(issentient(enemy)) {
      pos = self lastknownpos(enemy);
    } else if(isDefined(enemy)) {
      pos = enemy.origin;
    }

    if(isDefined(pos)) {
      turnyaw = absangleclamp360(self.angles[1] - vectortoangles(pos - self.origin)[1]);
      return turnyaw;
    }
  }

  return undefined;
}

function function_5142fcce(entity) {
  if(entity.ai.var_a49798e7) {
    return 1;
  }

  return 0;
}

function function_13f6d246(entity) {}

function function_e37d4e19(entity) {}

function private function_2a30b3a3(n_duration) {
  self endon(#"hash_362dfacc3f97bf98", #"hash_39f4b987812e1540", #"death", #"entitydeleted");
  function_c01f9453();
  wait n_duration;
  self.ai.var_a49798e7 = 0;
  self notify(#"hash_362dfacc3f97bf98");
}

function function_67a0e9a2(var_2fa3c4c9, location) {
  level.var_f0c367c9 = location;
  level.var_8cc83376 = [];

  foreach(split in var_2fa3c4c9) {
    if(isactor(split) && isalive(split)) {
      if(!isDefined(split.ai)) {
        split.ai = [];
      }

      split.ai.var_b90dccd6 = 0;
      split.ai.var_62741bfb = 1;
      split setgoal(split.origin, 1);
      split.ignoreall = 1;
    }
  }
}

function private function_52479a49(entity) {
  return is_true(entity.ai.var_62741bfb);
}

function private function_5c25cce9(entity) {}

function private function_5070830c(entity) {
  array::add(level.var_8cc83376, entity, 0);
  entity.ai.var_62741bfb = 0;

  if(level.var_8cc83376.size == 2) {
    level thread function_aed09e18(level.var_8cc83376);
    level.var_8cc83376 = [];
  }
}

function private function_dcac38af(entity) {
  return entity.ai.var_a29f9a91;
}

function private function_545f48af(entity) {}

function private function_42d0830a(entity) {
  if(entity.variant_type < 3) {
    entity.variant_type += 1;
    return;
  }

  entity.variant_type = 0;
  entity.ai.var_a29f9a91 = 0;
}

function private function_aed09e18(var_2fa3c4c9, location) {
  foreach(split in var_2fa3c4c9) {
    if(isDefined(split)) {
      split hide();
      split deletedelay();
    }
  }

  if(isDefined(location)) {
    spawner = # "spawner_zm_steiner_f";

    if(var_2fa3c4c9[0] function_1e521615()) {
      spawner = # "hash_acac3fe7a341329";
    }

    steiner = spawnactor(#"spawner_zm_steiner_f", location.origin, location.angles);

    if(isDefined(steiner)) {
      steiner forceteleport(location.origin, location.angles);
      steiner.team = # "allies";
      steiner.ignoreall = 1;
      steiner.ignore_find_flesh = 1;
      steiner.ignoreme = 1;
      steiner.ignore_nuke = 1;
      steiner.ignore_all_poi = 1;
      steiner.var_8d1d18aa = 0;
      steiner.ai.var_a29f9a91 = 1;
      steiner.variant_type = 0;
      steiner function_bf898e7e(0);
      steiner function_af554aaf(0);
      steiner function_16a8babd(0);
      steiner.ignore_player = getplayers();
    }
  }

  level flag::set("steiner_merge_done");
}

function function_f045e7c(location, var_c406df14) {
  steiner = spawnactor(#"spawner_zm_steiner_f", location.origin, location.angles);

  if(isDefined(steiner)) {
    steiner forceteleport(location.origin, location.angles);
    steiner.team = # "allies";
    steiner.ignoreall = 1;
    steiner.ignore_find_flesh = 1;
    steiner.ignoreme = 0;
    steiner.ignore_nuke = 1;
    steiner.ignore_all_poi = 1;
    steiner.instakill_func = &zm_powerups::function_16c2586a;
    steiner.is_companion = 1;
    steiner.takedamage = 1;
    steiner.var_8d1d18aa = 0;
    steiner.ai.var_a29f9a91 = var_c406df14;
    steiner.variant_type = 0;
    steiner function_bf898e7e(0);
    steiner function_af554aaf(0);
    steiner function_16a8babd(0);
    steiner.ignore_player = getplayers();
    return steiner;
  }
}

function function_7e855c12(point, str_speed) {
  self.var_9ecae3b4 = 1;

  if(isDefined(str_speed)) {
    self.zombie_move_speed = str_speed;
  } else {
    self.zombie_move_speed = "walk";
  }

  self setgoal(point, 0);
  self waittill(#"goal");
  self.var_9ecae3b4 = undefined;
  self setgoal(self.origin, 1);
}

function function_c6579189(target) {
  if(!isDefined(target)) {
    return;
  }

  self setgoal(self.origin, 0, undefined, undefined, vectortoangles(target.origin - self.origin));
}

function private function_46d99f6b() {
  steiners = getaiarchetypearray(#"hash_7c0d83ac1e845ac2");
  var_ddb534a3 = [];

  foreach(steiner in steiners) {
    if(isalive(steiner) && steiner.team == # "allies") {
      if(!isDefined(var_ddb534a3)) {
        var_ddb534a3 = [];
      } else if(!isarray(var_ddb534a3)) {
        var_ddb534a3 = array(var_ddb534a3);
      }

      var_ddb534a3[var_ddb534a3.size] = steiner;
    }
  }

  return var_ddb534a3;
}

function function_6b87eed1() {
  if(!isDefined(self.subarchetype)) {
    return 0;
  }

  var_6f8997fc = array(#"hash_5653bbc44a034094", #"hash_70162f4bc795092", #"hash_12fa854f3a7721b9", #"hash_3498fb1fbfcd0cf");
  return isinarray(var_6f8997fc, self.subarchetype);
}

function function_3758a4e7() {
  if(!isDefined(self.subarchetype)) {
    return 0;
  }

  var_6f8997fc = array(#"hash_70162f4bc795092", #"hash_3498fb1fbfcd0cf");
  return isinarray(var_6f8997fc, self.subarchetype);
}

function function_ba878b50() {
  if(!isDefined(self.subarchetype)) {
    return 0;
  }

  var_6f8997fc = array(#"hash_5653bbc44a034094", #"hash_12fa854f3a7721b9");
  return isinarray(var_6f8997fc, self.subarchetype);
}

function function_1e521615() {
  if(!isDefined(self.subarchetype)) {
    return 0;
  }

  var_6f8997fc = array(#"hash_5605f3a585b3ef9f", #"hash_3498fb1fbfcd0cf", #"hash_12fa854f3a7721b9");
  return isinarray(var_6f8997fc, self.subarchetype);
}

function function_bbb547de(dist) {
  var_ddb534a3 = function_46d99f6b();

  foreach(steiner in var_ddb534a3) {
    fwd = vectorscale(vectornormalize(anglesToForward(steiner.angles)), dist);
    eye = steiner.origin + (0, 0, 80);
    trace = bulletTrace(eye, eye + fwd, 0, undefined);
    var_380c580a = positionquery_source_navigation(trace[# "position"], 128, 256, 128, 20);
    point = steiner.origin;

    if(isDefined(var_380c580a) && var_380c580a.data.size > 0) {
      point = var_380c580a.data[0].origin;
    }

    goal = getclosestpointonnavmesh(point);

    if(isDefined(goal)) {
      steiner thread function_7e855c12(goal);
    }
  }
}

function function_32af84be(target) {
  var_ddb534a3 = function_46d99f6b();

  foreach(steiner in var_ddb534a3) {
    steiner thread function_c6579189(target);
  }
}

function function_ed79082a() {
  self.var_d03a9e80 = 1;
}

function function_1ebe48df() {
  self endon(#"death", #"entitydeleted");

  while(true) {
    self waittill(#"hash_3eea9a5090ab2f4b");

    if(is_true(self.var_d03a9e80)) {
      self.var_d03a9e80 = 0;
      continue;
    }

    self.var_d03a9e80 = 1;
  }
}

function function_5e09bd0f() {
  self endon(#"death", #"entitydeleted");

  while(true) {
    if(is_true(self.var_d03a9e80)) {
      self playsoundontag(#"hash_5d4fa1004dc72f03", "tag_eye");
    }

    wait randomintrange(3, 9);
  }
}

function function_4b261274(entity) {
  if(entity.ignoreall) {
    return false;
  }

  if(is_true(entity.ai.var_ae3359f)) {
    return true;
  }

  enemy = entity get_enemy();

  if(!isDefined(enemy) || !function_b860fc37(enemy)) {
    return false;
  }

  var_ff38566a = lengthsquared(enemy getvelocity());
  var_17c3916f = 10000;

  if(var_ff38566a < 30625) {
    var_17c3916f = 36100;
  }

  if(!is_true(level.intermission)) {
    if(distancesquared(entity.origin, enemy.origin) > var_17c3916f) {
      return false;
    }

    if(!tracepassedonnavmesh(entity.origin, enemy.origin, self getpathfindingradius())) {
      return false;
    }
  }

  yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(enemy.origin - entity.origin)[1]);

  if(abs(yawtoenemy) > 60) {
    return false;
  }

  return true;
}

function function_f9eee290(entity) {
  return isDefined(entity.damageweapon) && namespace_b376a999::function_5fef4201(entity.damageweapon);
}

function private function_9397dd2f(entity) {
  entity asmsetanimationrate(1);
}

function private function_6fc64eed(entity) {
  entity asmsetanimationrate(1);
  entity.ai.var_2a4908cd = gettime();
}

function private function_d5e64bba(entity) {
  if(function_7a893a7(entity) || function_e6d0f1d4(entity) || zombiebehavior::zombieshouldmeleecondition(entity)) {
    entity.ai.var_6d3ee308 = gettime() + 500;
    return (gettime() - entity.ai.var_2a4908cd);
  }

  return 1500;
}

function private function_6254c264(entity) {
  if(isDefined(entity.var_2e874959)) {
    entity asmsetanimationrate(entity.var_2e874959);

    function_ee21651d("<dev string:x7ca>" + entity.var_2e874959);
  }

  entity.ai.var_7555ca97 = undefined;

  if(is_true(entity.ai.var_fad877bf)) {
    entity.ai.var_fad877bf = 0;
  }
}

function private function_e5ef0d0d(entity) {
  entity asmsetanimationrate(1);
}

function private function_e456ad9b(entity) {
  if(isDefined(entity.var_2e874959)) {
    entity asmsetanimationrate(entity.var_2e874959);

    function_ee21651d("<dev string:x806>" + entity.var_2e874959);
  }

  entity.ai.var_7555ca97 = undefined;

  if(is_true(entity.ai.var_fad877bf)) {
    entity.ai.var_fad877bf = 0;
  }
}

function private function_c01f9453() {
  a_zombies = getaispeciesarray(level.zombie_team);
  var_e5cc0a0a = [];

  foreach(zombie in a_zombies) {
    if(distancesquared(self.origin, zombie.origin) < 10000) {
      if(!isDefined(var_e5cc0a0a)) {
        var_e5cc0a0a = [];
      } else if(!isarray(var_e5cc0a0a)) {
        var_e5cc0a0a = array(var_e5cc0a0a);
      }

      var_e5cc0a0a[var_e5cc0a0a.size] = zombie;
    }
  }

  var_86cccd7b = array::random(var_e5cc0a0a);

  if(isDefined(var_86cccd7b)) {
    if(is_true(self.ai.var_26b09b96)) {
      var_86cccd7b zombie_utility::setup_zombie_knockdown(self);
      self.ai.var_26b09b96 = 0;
      self thread function_964739ed();
    }
  }
}

function private function_964739ed() {
  self endon(#"death");
  wait 5;
  self.ai.var_26b09b96 = 1;
}