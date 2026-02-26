/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5a7c9cfbe3d9580c.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_1351b3cdb6539f9b;
#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_4937c6974f43bb71;
#using script_61fee52bb750ac99;
#using script_7d45a9db3b7a66b2;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp\cp_nam_prisoner_fx;
#using scripts\cp_common\achievements;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;
#namespace namespace_b508dca;

function function_99791793(str_objective) {
  if(isDefined(level.var_731c10af.var_42659717) && level.var_731c10af.var_42659717 != 2) {
    level exploder::exploder("lgt_doorlight");
  }

  if(level.var_731c10af.var_42659717 == 1 && isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da != level.var_baa7cf92) {
    level thread function_bf552fd1();
  }
}

function function_690ab87a(str_objective, var_50cc0d4f) {
  level flag::set("flag_in_memory");
  util::delay(3, undefined, &districts::function_930f8c81, ["memory_2_obey", "memory_2_disobey", "memory_2_jungle_path_fork_right", "memory_2_jungle_path_fork_left", "memory_3"]);
  level thread function_cae2d8f5();
  level thread namespace_d9b153b9::function_744492ec();
  namespace_82bfe441::fade(1, "FadeImmediate");
  level.players[0] util::delay(3, undefined, &clientfield::set_to_player, "rt_character_visibility", 2);
  level thread namespace_d9b153b9::force_weapon_loadout(str_objective);

  if(var_50cc0d4f) {
    level flag::wait_till("level_intro_complete");
  } else {
    level flag::wait_till("bunker_door_start_function_end");
  }

  if(str_objective == "memory_4") {
    level flag::set("start_outro");

    if(!isDefined(level.var_731c10af.var_58ca484f) && !level flag::get("flag_last_room_wall") && !level flag::get("flag_memory_4_disobey")) {
      level.player stats::function_dad108fa(#"hash_205258067ba85bbb", 1);
    }
  }

  if(level flag::exists("flag_" + str_objective) && !level flag::get("flag_" + str_objective)) {
    level flag::set("flag_" + str_objective);
  }

  level thread namespace_b6fe1dbe::function_99791793();
  level thread function_2861fe5a();

  if(!isDefined(level.bunker_door)) {
    level.var_2986f812 = namespace_d9b153b9::door_setup("bunker_1_door_struct", undefined, 1);
    level.bunker_door = 1;
  }

  if(isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da == level.var_baa7cf92) {
    level.player districts::function_930f8c81("lab");
    level thread namespace_d9b153b9::function_49b8435c();
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + str_objective + "_obey";
    bb::function_cd497743(str, level.player);
    obey(str_objective);
    level thread namespace_d9b153b9::function_1a8b3140();
    var_ae9e693 = str_objective + "_obey";
  } else {
    switch (str_objective) {
      case # "memory_2":
      case # "memory_1":
        level.player districts::function_930f8c81("bunker");
        level thread namespace_d9b153b9::function_49b8435c();
        break;
      case # "memory_3":
        level.player districts::function_a7d79fcb("lab");
        break;
      case # "memory_4":
        level.player districts::function_930f8c81("lab");
        break;
      default:
        break;
    }

    level thread namespace_d9b153b9::function_eab02ceb();
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + str_objective + "_disobey";
    bb::function_cd497743(str, level.player);
    disobey(str_objective);
    level thread namespace_d9b153b9::function_821d8772();
    level thread namespace_d9b153b9::function_1a8b3140();
    var_ae9e693 = str_objective + "_disobey";
  }

  level flag::wait_till("flag_start_memory_end");

  if(!level flag::get("flag_memory_4")) {
    level.player districts::function_a7d79fcb("rice_paddies");
    level thread namespace_d9b153b9::function_179cab4a();

    if(level flag::get("flag_memory_2")) {
      level thread namespace_d9b153b9::function_8d5f7d63();
    }
  }

  level flag::wait_till("visit_restart");

  if(!level flag::get("flag_memory_4")) {
    level flag::wait_till_clear("visit_restart");
    waitframe(1);
  }

  level.players[0] clientfield::set_to_player("rt_character_visibility", 1);

  if(isDefined(var_ae9e693)) {
    if(var_ae9e693 == "memory_4_obey" || var_ae9e693 == "memory_4_disobey") {
      var_ae9e693 = "memory_4";
    }

    if(!isDefined(level.var_9fd1c625.var_204d167f)) {
      level.var_9fd1c625.var_204d167f = [];
    } else if(!isarray(level.var_9fd1c625.var_204d167f)) {
      level.var_9fd1c625.var_204d167f = array(level.var_9fd1c625.var_204d167f);
    }

    if(!isinarray(level.var_9fd1c625.var_204d167f, hash(var_ae9e693))) {
      level.var_9fd1c625.var_204d167f[level.var_9fd1c625.var_204d167f.size] = hash(var_ae9e693);
    }

    level.player stats::function_505387a6(#"hash_15134f1ecf5353a", hash(var_ae9e693), 1);

    for(i = 0; i < level.var_93b4bbca; i++) {
      entry = level.var_607cc7b3[i];

      if(level.player stats::function_e3eb9a8b(#"hash_15134f1ecf5353a", entry)) {
        if(!isDefined(level.var_9fd1c625.var_204d167f)) {
          level.var_9fd1c625.var_204d167f = [];
        } else if(!isarray(level.var_9fd1c625.var_204d167f)) {
          level.var_9fd1c625.var_204d167f = array(level.var_9fd1c625.var_204d167f);
        }

        if(!isinarray(level.var_9fd1c625.var_204d167f, entry)) {
          level.var_9fd1c625.var_204d167f[level.var_9fd1c625.var_204d167f.size] = entry;
        }
      }
    }

    if(level.var_9fd1c625.var_204d167f.size >= level.var_93b4bbca && level.var_9fd1c625.var_e3cc02a9.size >= level.var_9ba0ebb2) {
      level.player achievements::give_achievement(#"cp_achievement_mind_trip");
    }
  }

  level flag::clear("flag_in_memory");
  level skipto::function_4e3ab877(str_objective);

  if(level flag::get("flag_memory_4")) {
    player_decision::function_8c0836dd(0);
    skipto::function_1c2dfc20("cp_ger_hub8");
  }
}

function function_cae2d8f5() {
  wait 2;
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 1);
  level flag::wait_till("visit_restart");
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 0);
}

function function_e4f91def(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player == "memory_1") {}

  if(player == "memory_2") {
    level thread function_ec67c2bd();
    level thread function_5a11fdd5();
  }

  if(player == "memory_3") {
    level thread namespace_b092382c::function_be61f4c4();
    level thread function_b1f3ab09();
  }
}

function function_c26b0bc0() {
  level flag::init("flag_in_memory");
  level flag::init("caves_door_opened");
  level flag::init("village_door_opened");
  level flag::init("sniper_overlook_door_opened");
  level flag::init("rat_tunnels_door_opened");
  level flag::init("outro_door_opened");
  level flag::init("flag_bunker_door_interact_used");
  level flag::init("bunker_door_start_function_end");
  level flag::init("flag_memory_1");
  level flag::init("flag_memory_2");
  level flag::init("flag_memory_3");
  level flag::init("flag_memory_4");
  level flag::init("flag_memory_4_obey");
  level flag::init("flag_memory_4_disobey");
  level flag::init("memory_1_complete");
  level flag::init("memory_2_complete");
  level flag::init("memory_3_complete");
  level flag::init("memory_4_complete");
  level flag::init("memory_reaction_vo_start");
  level flag::init("memory_reaction_vo_complete");
  level flag::init("flag_start_memory_end");
  level flag::init("flag_video_finished");
  level flag::init("flag_last_room_wall");
  level flag::init("player_in_bunker_room");
  level flag::init("flag_bunker_file_cabinet_used");
  level flag::init("flag_bunker_computer_used");
  level flag::init("flag_bunker_main_table_used");
  level flag::init("flag_bunker_side_table_used");
  level flag::init("flag_bunker_map_used");
  level flag::init("flag_bunker_desk_used");
  level flag::init("start_long_lab_hallway_rob");
  level flag::init("lab_hallway_teleport_into_lab");
  level flag::init("lab_hallway_exited");
  level flag::init("flag_slide_projector_1_win");
  level flag::init("flag_slide_projector_2_win");
  level flag::init("stop_bunker_puzzle_room_hint");
  level flag::init("bunker_puzzle_room_unsolved");
  level flag::init("bunker_puzzle_room_solved");
  level flag::init("bunker_puzzle_room_exited");
  level flag::init("bunker_3_dt0_complete");
  level flag::init("bunker_3_dt1_complete");
  level flag::init("bunker_3_dt2_complete");
  level flag::init("bunker_room_final_complete");
  level flag::init("start_outro");
  level flag::init("flag_outro");
}

function function_a08d5cab() {
  level flag::clear("bunker_door_start_function_end");
  level flag::clear("memory_reaction_vo_start");
  level flag::clear("memory_reaction_vo_complete");
  level flag::clear("flag_start_memory_end");
  level flag::clear("player_in_bunker_room");
  level flag::clear("flag_start_memory");
  level flag::clear("flag_start_memory_perseus");
  level flag::clear("flag_start_memory_03");
}

function function_133140de(var_c79d614f, destination) {
  self thread function_c70cb408();
  self scene::init("scene_pri_bunker_unlock", self.door_left);

  if(level.var_731c10af.var_e15e5b51.size == 2) {
    self thread namespace_b6fe1dbe::function_2982df9f(1);
  } else {
    self thread namespace_b6fe1dbe::function_2982df9f();
  }

  util::waittill_any_ents(self.door_interact, "trigger", level, "start_outro");
  level flag::set("flag_bunker_door_interact_used");

  if(level flag::get("start_outro")) {
    return;
  }

  level notify(#"hash_39f79162a63bad6e");
  level flag::set("flag_fx_exploder_end_rice_paddies");
  level flag::set("flag_fx_exploder_end_jungle_path");
  level flag::set("flag_fx_exploder_end_waterfall_path");
  level flag::set("flag_fx_exploder_end_river_path");
  level flag::set("flag_fx_exploder_end_creek_path");
  level flag::set("flag_fx_exploder_end_bridge_path");
  level flag::set("flag_fx_exploder_end_sniper_overlook");
  level flag::set("flag_fx_exploder_end_village");
  level flag::set("flag_fx_exploder_end_caves");
  level flag::set("flag_fx_exploder_end_rat_tunnels");
  level thread function_a978eba(var_c79d614f);

  if(issubstr(var_c79d614f, "memory_4")) {
    namespace_b6fe1dbe::music("deactivate_21.0_crazy_doors");
    str = "memory_4";

    if(level flag::exists("flag_" + str) && !level flag::get("flag_" + str)) {
      level flag::set("flag_" + str);
    }

    flag = "flag_" + str + "_" + destination;

    if(level flag::exists(flag) && !level flag::get(flag)) {
      level flag::set(flag);
    }
  }

  level thread namespace_d9b153b9::pstfx_teleport(1, 0, "door");

  if(level.var_731c10af.var_42659717 != 2) {
    level exploder::exploder("lgt_doorlight");
  }

  if(!isDefined(level.var_7f958422)) {
    self scene::play("scene_pri_bunker_unlock", self.door_left);
  }

  level flag::set("bunker_door_start_function_end");
  self notify(#"door_opened");
  level flag::clear("flag_bunker_door_interact_used");
  level thread util::delay(0.4, undefined, &flag::set, "flag_clear_teleport_fx");
}

function function_a978eba(var_c79d614f) {
  wait 0.75;

  if(level flag::exists(var_c79d614f + "_door_opened") && !level flag::get(var_c79d614f + "_door_opened")) {
    level flag::set(var_c79d614f + "_door_opened");
  }
}

function function_c70cb408() {
  util::waittill_any_ents(self, "door_opened", level, "start_outro");
  wait 1;
  self namespace_d9b153b9::function_736b8a03();

  if(isDefined(self.linked_ents)) {
    foreach(ent in self.linked_ents) {
      if(isDefined(ent)) {
        ent delete();
      }
    }
  }
}

function obey(var_c79d614f) {
  if(isDefined(level.var_872cf153)) {
    level thread function_b8252dde(var_c79d614f);
    level thread function_5ab2ed57(var_c79d614f);
    return;
  }

  level thread namespace_d9b153b9::function_fa427f65("bunker");

  if(level.var_731c10af.var_e15e5b51.size == 0) {
    level thread function_f59ac31d(level.var_2986f812);
    level.player util::delay(2, undefined, &clientfield::set_to_player, "lerp_fov", 6);
  } else if(level.var_731c10af.var_e15e5b51.size == 1) {
    door_struct = struct::get("memory_22_obey_door_struct", "targetname");
    level thread function_146b013();
    level namespace_b092382c::function_7841bdbc(door_struct, "p9_vnm_door_bunker_metal_01c", undefined, "scene_pri_bunker_open");
    level exploder::stop_exploder("lgt_doorlight");
    level thread function_65186aa7();
    level flag::wait_till("bunker_puzzle_room_exited");
    level exploder::exploder("lgt_doorlight");
    level thread function_f59ac31d(level.var_2986f812);
    level.player util::delay(2, undefined, &clientfield::set_to_player, "lerp_fov", 6);
  } else if(level.var_731c10af.var_e15e5b51.size == 2) {
    if(!level flag::get("infinite_hallway_exited")) {
      level namespace_b092382c::infinite_hallway();
    }

    bunker_3_door_struct = namespace_d9b153b9::door_setup("bunker_3_door_struct", undefined, 1);
    level thread function_f59ac31d(bunker_3_door_struct);
  } else if(level.var_731c10af.var_e15e5b51.size == 3) {
    level thread function_f59ac31d(level.var_2986f812);
  }

  level thread function_b8252dde(var_c79d614f);
  level thread function_5ab2ed57(var_c79d614f);
}

function disobey(var_c79d614f) {
  level thread namespace_d9b153b9::function_fa427f65("lab");

  if(level.var_731c10af.var_e15e5b51.size == 0) {
    videostart("cp_prisoner_tv_footage_grid_v2", 1);
    door_struct = struct::get("memory_1_disobey_door_struct", "targetname");
    level namespace_b092382c::function_7841bdbc(door_struct, "p9_vnm_door_bunker_metal_01c", undefined, "scene_pri_bunker_open");
    level exploder::stop_exploder("lgt_doorlight");
    level thread function_65186aa7();
    interact = struct::get("memory_1_disobey_interact", "targetname");
    interact function_c326193d();
    videostop("cp_prisoner_tv_footage_grid_v2");
    level thread namespace_b6fe1dbe::cinematic_duck_start();
    level thread function_7c927add(#"hash_47bcfb2ef64c56c2");
    level flag::set("flag_start_memory_end");
  } else if(level.var_731c10af.var_e15e5b51.size == 1) {
    level exploder::exploder("Ambfx_Lab_Visit_2_Disobey");
    level thread function_7ab09ebb();
    level function_23a50f0f();
    level flag::set("flag_start_memory_end");
    level thread namespace_b6fe1dbe::cinematic_duck_start(1.25);
    level util::delay(1.25, undefined, &function_7c927add, #"hash_47bcfa2ef64c550f");
    level exploder::stop_exploder("Ambfx_Lab_Visit_2_Disobey");
  } else if(level.var_731c10af.var_e15e5b51.size == 2) {
    if(!level flag::get("infinite_hallway_exited")) {
      level namespace_b092382c::infinite_hallway();
    }

    level thread function_3440cd05();
    videostart("cp_prisoner_tv_footage_grid_v2", 1);
    door_struct = struct::get("memory_3_disobey_door_struct", "targetname");
    level namespace_b092382c::function_7841bdbc(door_struct, "p9_vnm_door_bunker_metal_01c", undefined, "scene_pri_bunker_open");
    level exploder::stop_exploder("lgt_doorlight");
    level flag::set("flag_memory_3_disobey_door");
    interact = struct::get("memory_3_disobey_interact", "targetname");
    interact function_c326193d();
    videostop("cp_prisoner_tv_footage_grid_v2");
    level thread namespace_b6fe1dbe::cinematic_duck_start();
    level thread function_7c927add(#"hash_47bcf92ef64c535c");
    level flag::set("flag_start_memory_end");
  } else if(level.var_731c10af.var_e15e5b51.size == 3) {
    level function_f59ac31d(level.var_2986f812);
    level thread function_b8252dde(var_c79d614f);
  }

  level thread function_5ab2ed57(var_c79d614f);
}

function function_f59ac31d(door_struct) {
  door_struct scene::play("scene_pri_bunker_open", door_struct.door_left);
  level exploder::stop_exploder("lgt_doorlight");
}

function function_cd37b55f() {
  level thread namespace_d9b153b9::function_c318ce4a("slide_projector_1_light");
  level thread namespace_d9b153b9::function_c318ce4a("slide_projector_2_light");
  level.projector_1_background = getent("projector_1_background", "targetname");
  level.projector_2_background = getent("projector_2_background", "targetname");
  level.slide_projector_1_slides = getEntArray("slide_projector_1_slides", "targetname");
  level.slide_projector_2_slides = getEntArray("slide_projector_2_slides", "targetname");
  level function_4fc0917f(level.projector_1_background, 1);
  level function_4fc0917f(level.projector_2_background, 1);
  level function_4fc0917f(level.slide_projector_1_slides, 1);
  level function_4fc0917f(level.slide_projector_2_slides, 1);
}

function function_4fc0917f(ent_array, hide) {
  if(!isarray(ent_array)) {
    ent_array = [ent_array];
  }

  if(isDefined(hide)) {
    foreach(ent in ent_array) {
      if(isDefined(ent)) {
        ent hide();
      }
    }

    return;
  }

  foreach(ent in ent_array) {
    if(isDefined(ent)) {
      ent show();
    }
  }
}

function function_65186aa7() {
  wait 0.5;
  level.player clientfield::set_to_player("lerp_fov", 5);
  wait 5;
  level.player clientfield::set_to_player("lerp_fov", 0);
}

function function_146b013() {
  level function_cd37b55f();
  var_e12cd9e4 = 6;
  var_765442a = struct::get("slide_projector_1_interact", "targetname");
  var_fbfb5ea0 = struct::get("slide_projector_2_interact", "targetname");
  var_765442a.str = "slide_projector_1";
  var_fbfb5ea0.str = "slide_projector_2";
  var_765442a.slide_projector = getent("slide_projector_1", "targetname");
  var_fbfb5ea0.slide_projector = getent("slide_projector_2", "targetname");
  var_765442a.slide_projector useanimtree("generic");
  var_fbfb5ea0.slide_projector useanimtree("generic");
  var_765442a.slides = level.slide_projector_1_slides;

  if(var_765442a.slides.size != var_e12cd9e4) {
    for(i = var_765442a.slides.size; i < var_e12cd9e4; i++) {
      if(!isDefined(var_765442a.slides)) {
        var_765442a.slides = [];
      } else if(!isarray(var_765442a.slides)) {
        var_765442a.slides = array(var_765442a.slides);
      }

      var_765442a.slides[var_765442a.slides.size] = level.projector_1_background;
    }
  }

  var_fbfb5ea0.slides = level.slide_projector_2_slides;

  if(var_fbfb5ea0.slides.size != var_e12cd9e4) {
    for(i = var_fbfb5ea0.slides.size; i < var_e12cd9e4; i++) {
      if(!isDefined(var_fbfb5ea0.slides)) {
        var_fbfb5ea0.slides = [];
      } else if(!isarray(var_fbfb5ea0.slides)) {
        var_fbfb5ea0.slides = array(var_fbfb5ea0.slides);
      }

      var_fbfb5ea0.slides[var_fbfb5ea0.slides.size] = level.projector_2_background;
    }
  }

  var_765442a.slides = array::randomize(var_765442a.slides);

  if(isDefined(var_765442a.slides[0].script_noteworthy) && var_765442a.slides[0].script_noteworthy == "solution" || isDefined(var_765442a.slides[1].script_noteworthy) && var_765442a.slides[1].script_noteworthy == "solution" || isDefined(var_765442a.slides[2].script_noteworthy) && var_765442a.slides[2].script_noteworthy == "solution" || isDefined(var_765442a.slides[3].script_noteworthy) && var_765442a.slides[3].script_noteworthy == "solution") {
    while(true) {
      if(var_765442a.slides[0].script_noteworthy == "solution" || var_765442a.slides[1].script_noteworthy == "solution" || var_765442a.slides[2].script_noteworthy == "solution" || var_765442a.slides[3].script_noteworthy == "solution") {
        var_765442a.slides = array::randomize(var_765442a.slides);
      } else {
        break;
      }

      wait 0.05;
    }
  }

  for(i = 0; i < var_765442a.slides.size; i++) {
    if(isDefined(var_765442a.slides[i].script_noteworthy) && var_765442a.slides[i].script_noteworthy == "solution") {
      var_765442a.var_38f7782d = i;
      break;
    }
  }

  var_fbfb5ea0.slides = array::randomize(var_fbfb5ea0.slides);

  for(i = 0; i < var_fbfb5ea0.slides.size; i++) {
    if(isDefined(var_fbfb5ea0.slides[i].script_noteworthy) && var_fbfb5ea0.slides[i].script_noteworthy == "solution") {
      var_fbfb5ea0.var_38f7782d = i;
      break;
    }
  }

  if(isDefined(var_fbfb5ea0.slides[0].script_noteworthy) && var_fbfb5ea0.slides[0].script_noteworthy == "solution" || isDefined(var_fbfb5ea0.slides[1].script_noteworthy) && var_fbfb5ea0.slides[1].script_noteworthy == "solution" || isDefined(var_fbfb5ea0.slides[2].script_noteworthy) && var_fbfb5ea0.slides[2].script_noteworthy == "solution" || isDefined(var_fbfb5ea0.slides[3].script_noteworthy) && var_fbfb5ea0.slides[3].script_noteworthy == "solution" || var_fbfb5ea0.var_38f7782d == var_765442a.var_38f7782d) {
    while(true) {
      if(var_fbfb5ea0.slides[0].script_noteworthy == "solution" || var_fbfb5ea0.slides[1].script_noteworthy == "solution" || var_fbfb5ea0.slides[2].script_noteworthy == "solution" || var_fbfb5ea0.slides[3].script_noteworthy == "solution" || var_fbfb5ea0.var_38f7782d == var_765442a.var_38f7782d) {
        var_fbfb5ea0.slides = array::randomize(var_fbfb5ea0.slides);

        for(i = 0; i < var_fbfb5ea0.slides.size; i++) {
          if(isDefined(var_fbfb5ea0.slides[i].script_noteworthy) && var_fbfb5ea0.slides[i].script_noteworthy == "solution") {
            var_fbfb5ea0.var_38f7782d = i;
            break;
          }
        }
      } else {
        break;
      }

      wait 0.05;
    }
  }

  var_765442a.background = level.projector_1_background;
  var_fbfb5ea0.background = level.projector_2_background;
  var_765442a thread function_dc9da967();
  var_fbfb5ea0 thread function_dc9da967();
  level thread function_f870d144();
  level flag::wait_till("bunker_puzzle_room_exited");
}

function function_dc9da967() {
  self.usable = spawn("script_model", self.origin);
  self.usable setModel("tag_origin");
  self.count = -1;
  self.var_e12cd9e4 = 6;
  level thread namespace_b6fe1dbe::projector_room_enter();

  while(!level flag::get("bunker_puzzle_room_exited")) {
    self.usable util::create_cursor_hint("tag_origin", (0, 0, 8), #"hash_1cbb97e6dd4209d1");
    util::waittill_any_ents(self.usable, "trigger", level, "bunker_puzzle_room_exited");
    self.usable util::remove_cursor_hint();

    if(!isDefined(self.used_once)) {
      self.used_once = 1;
      level thread function_4fc0917f(self.background);
      level thread namespace_d9b153b9::function_b96db417(self.str + "_light");
      self thread function_2493220a();
    }

    if(level flag::get("bunker_puzzle_room_exited")) {
      break;
    }

    level thread function_408ba1f0();
    level.player hideviewmodel();
    level.player setstance("stand");
    level.player val::set("teleport_controls", "freezecontrols", 1);
    level.player allowcrouch(0);
    level.player allowprone(0);
    player_pos = struct::get(self.str + "_player_pos", "targetname");
    org = util::spawn_model("tag_origin", player_pos.origin);
    org.angles = player_pos.angles;
    level.player playerlinktoblend(org, "tag_origin", 0.3, 0.1, 0.1);
    wait 0.3;
    level.player playerlinktodelta(org, "tag_origin", 0, 70, 70, 15, 15);
    level.player check_input(self);
    wait 1;
    level.player showviewmodel();
    level.player val::set("teleport_controls", "freezecontrols", 0);
    level.player allowcrouch(1);
    level.player allowprone(1);
    level flag::clear("stop_bunker_puzzle_room_hint");
    wait 0.05;
  }

  level thread namespace_b6fe1dbe::projector_room_exit();

  if(isDefined(self.usable)) {
    self.usable delete();
  }

  self thread function_2493220a(1);
}

function function_ec67c2bd() {
  var_b17fef8d = getEntArray("bunker_black_void_room_lights", "script_noteworthy");
  array::thread_all(var_b17fef8d, &namespace_d9b153b9::ent_cleanup);
  slide_projector_1 = getent("slide_projector_1", "targetname");
  slide_projector_1 thread namespace_d9b153b9::ent_cleanup();
  slide_projector_2 = getent("slide_projector_2", "targetname");
  slide_projector_2 thread namespace_d9b153b9::ent_cleanup();

  if(!isDefined(level.projector_1_background)) {
    level.projector_1_background = getent("projector_1_background", "targetname");
  }

  if(!isDefined(level.projector_2_background)) {
    level.projector_2_background = getent("projector_2_background", "targetname");
  }

  level.projector_1_background thread namespace_d9b153b9::ent_cleanup();
  level.projector_2_background thread namespace_d9b153b9::ent_cleanup();

  if(!isDefined(level.slide_projector_1_slides)) {
    level.slide_projector_1_slides = getEntArray("slide_projector_1_slides", "targetname");
  }

  array::thread_all(level.slide_projector_1_slides, &namespace_d9b153b9::ent_cleanup);

  if(!isDefined(level.slide_projector_2_slides)) {
    level.slide_projector_2_slides = getEntArray("slide_projector_2_slides", "targetname");
  }

  array::thread_all(level.slide_projector_2_slides, &namespace_d9b153b9::ent_cleanup);
  bunker_room_puzzle_door_model = getent("bunker_room_puzzle_door_model", "targetname");
  bunker_room_puzzle_door_model thread namespace_d9b153b9::ent_cleanup();
}

function function_f870d144() {
  door_struct = struct::get("bunker_puzzle_exit_door_struct", "targetname");
  interact = struct::get("bunker_puzzle_exit_door_interact", "targetname");
  door_interact = spawn("script_model", interact.origin);
  door_interact setModel("tag_origin");

  while(true) {
    level flag::wait_till("bunker_puzzle_room_solved");
    door_struct.door_left = getent("bunker_room_puzzle_door_model", "targetname");
    door_interact util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_1cbb97e6dd4209d1");
    util::waittill_any_ents(door_interact, "trigger", level, "bunker_puzzle_room_unsolved");

    if(level flag::get("bunker_puzzle_room_unsolved")) {
      door_interact util::remove_cursor_hint();
      continue;
    }

    break;
  }

  level thread namespace_d9b153b9::function_1e281213("bunker_room_puzzle_door_model", 6, undefined, "render_texture_switch", "visit_restart");
  scene::add_scene_func("scene_pri_bunker_unlock", &function_3886e509);
  door_struct thread scene::play("scene_pri_bunker_unlock", door_struct.door_left);

  while(level.player getanimtime("t9_pri_bunker_door_player_unlock") < 0.7) {
    waitframe(1);
  }

  level thread namespace_d9b153b9::pstfx_teleport(1, 0, "door");

  while(level.player getanimtime("t9_pri_bunker_door_player_unlock") < 1) {
    waitframe(1);
  }

  level.player.n_script_anim_rate = 1;
  scene::remove_scene_func("scene_pri_bunker_unlock", &function_3886e509);
  level flag::set("bunker_puzzle_room_exited");
  wait 0.4;
  level flag::set("flag_clear_teleport_fx");

  if(isDefined(door_interact)) {
    door_interact delete();
  }

  level flag::wait_till("flag_start_memory_end");
  level.player.n_script_anim_rate = undefined;
}

function function_3886e509(a_ents) {
  foreach(ent in a_ents) {
    ent.n_script_anim_rate = 0.5;
  }
}

function function_408ba1f0() {
  namespace_c8e236da::function_ebf737f8(#"hash_2404b7b62786fa93");
  namespace_c8e236da::function_ebf737f8(#"hash_2404b8b62786fc46");
  level flag::wait_till("stop_bunker_puzzle_room_hint");
  namespace_c8e236da::removelist();
}

function check_input(struct) {
  var_1ffa92cb = self useButtonPressed();

  while(true) {
    v_norm = self getnormalizedmovement();

    if(self gamepadusedlast() && self actionslotfourbuttonPressed() || !self gamepadusedlast() && self attackButtonPressed()) {
      if(isDefined(struct)) {
        level namespace_d9b153b9::function_c318ce4a(struct.str + "_light");
        struct thread function_2493220a(1);

        if(isDefined(struct.var_8bea1e7e)) {
          if(struct.var_8bea1e7e != struct.background) {
            level thread function_4fc0917f(struct.var_8bea1e7e, 1);
          }
        }

        struct.count++;

        if(struct.count >= struct.var_e12cd9e4) {
          struct.count = 0;
        }

        struct.slide_projector clientfield::set("slide_projector_anim", 1);
        struct.slide_projector setanim(#"hash_5ded2bc1daee5a9b", 1, 0, 1);
        flag = "flag_" + struct.str + "_win";

        if(isDefined(struct.var_8bea1e7e.script_noteworthy) && struct.var_8bea1e7e.script_noteworthy != "solution") {
          if(level flag::get(flag)) {
            level flag::clear(flag);
          }
        }

        struct.var_8bea1e7e = struct.slides[struct.count];
        wait 0.5;
        struct.slide_projector clearanim(#"hash_5ded2bc1daee5a9b", 0);
        struct.slide_projector clientfield::set("slide_projector_anim", 0);
        level namespace_d9b153b9::function_b96db417(struct.str + "_light");
        struct thread function_2493220a();

        if(struct.var_8bea1e7e != struct.background) {
          level thread function_4fc0917f(struct.var_8bea1e7e);
        }

        if(isDefined(struct.var_8bea1e7e.script_noteworthy) && struct.var_8bea1e7e.script_noteworthy == "solution") {
          if(!level flag::get(flag)) {
            level flag::set(flag);
          }
        } else if(level flag::get(flag)) {
          level flag::clear(flag);
        }

        level function_a5a3d1ad();
        wait 0.25;
      }
    }

    if(self actionslotthreebuttonPressed()) {}

    isusinggamepad = self gamepadusedlast();

    if(namespace_61e6d095::function_70217795(1)) {
      level flag::set("stop_bunker_puzzle_room_hint");
      level.player unlink();
      break;
    }

    var_1ffa92cb = self useButtonPressed();
    wait 0.05;
  }
}

function function_2493220a(off) {
  if(isDefined(off)) {
    if(self.str == "slide_projector_1") {
      exploder::kill_exploder("projection_room_proj_l_cone");
    } else {
      exploder::kill_exploder("projection_room_proj_r_cone");
    }

    self thread namespace_b6fe1dbe::function_6467c4e8();
    return;
  }

  if(self.str == "slide_projector_1") {
    exploder::exploder("projection_room_proj_l_cone");
  } else {
    exploder::exploder("projection_room_proj_r_cone");
  }

  self thread namespace_b6fe1dbe::function_82b14d0c();
}

function function_a5a3d1ad() {
  if(level flag::get("flag_slide_projector_1_win") && level flag::get("flag_slide_projector_2_win")) {
    if(!level flag::get("bunker_puzzle_room_solved")) {
      level flag::clear("bunker_puzzle_room_unsolved");
      level flag::set("bunker_puzzle_room_solved");
    }

    return;
  }

  if(level flag::get("bunker_puzzle_room_solved")) {
    level flag::clear("bunker_puzzle_room_solved");
    level flag::set("bunker_puzzle_room_unsolved");
  }
}

function function_c326193d(var_71b9f0c0) {
  self.usable = spawn("script_model", self.origin);
  self.usable setModel("tag_origin");
  self.usable util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_1cbb97e6dd4209d1", undefined, undefined, undefined, undefined, var_71b9f0c0);
  self.usable waittill(#"trigger");
  self.usable util::remove_cursor_hint();
  self.usable delete();
}

function function_5ab2ed57(var_c79d614f) {
  level flag::wait_till("flag_start_memory_end");
  level.player clientfield::set_to_player("lerp_fov", 7);

  if(level.var_731c10af.var_e15e5b51.size >= 3) {
    level flag::set("exit_ready");
  }

  level thread namespace_b6fe1dbe::music(var_c79d614f + "_end");
  level thread namespace_d9b153b9::pstfx_teleport(undefined, 1, "door");
  wait 1;
  level thread namespace_d9b153b9::function_5f3438c4();
  level.player setstance("stand");
  level.player val::set("teleport_controls", "freezecontrols", 1);
  level.player val::set("teleport_weapons", "disable_weapons", 1);

  if(var_c79d614f != "memory_4") {
    level thread scene::init("scene_pri_intro_short");
  }

  level flag::wait_till("flag_video_finished");

  if(level.var_731c10af.var_e15e5b51.size != 3) {
    wait 2;
  }

  level.player clientfield::set_to_player("lerp_fov", 0);
  level flag::set("memory_reaction_vo_start");
  level flag::wait_till("memory_reaction_vo_complete");
  level flag::set(var_c79d614f + "_complete");
  waitframe(1);
  level flag::set("visit_restart");
  level flag::clear("flag_video_finished");

  if(level flag::get("flag_memory_3_disobey_door")) {
    level flag::clear("flag_memory_3_disobey_door");
  }

  namespace_d9b153b9::function_e106e062(var_c79d614f, 1);
}

function function_2861fe5a() {
  while(level.players[0] scene::is_igc_active()) {
    waitframe(1);
  }

  wait 1;

  if(level.var_731c10af.var_e15e5b51.size == 0) {
    level thread function_8790323c();
    return;
  }

  if(level.var_731c10af.var_e15e5b51.size == 1) {
    level thread function_72b36315();
    return;
  }

  if(level.var_731c10af.var_e15e5b51.size == 2) {
    level thread function_33822068();
    return;
  }

  if(level.var_731c10af.var_e15e5b51.size == 3) {
    level thread function_9975759a();
  }
}

function function_8790323c() {
  wait 1;

  if(isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da == level.var_baa7cf92) {
    dialogue::radio("vox_cp_prsn_06000_adlr_yesgoodthebunke_0f");
    level flag::wait_till("memory_reaction_vo_start");
    level thread dialogue::radio("vox_cp_prsn_03000_adlr_wealmosthaditle_bc", undefined, 1);
    wait 3;
    level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_03000_park_okayready_23", "vox_cp_prsn_03000_lazr_readytogo_1c", "vox_cp_prsn_03000_sims_ready_23");
    wait 1.5;
    dialogue::radio("vox_cp_prsn_03000_adlr_bellwevegotajob_e7");
    thread namespace_b6fe1dbe::function_6acff073();
  } else {
    level thread function_3fedd4a8();
    wait 2;
    level util::dialog_gender_vo("vox_cp_prsn_03500_adlr_christwhatshapp_55", "vox_cp_prsn_03500_adlr_christwhatshapp_56", "vox_cp_prsn_03500_adlr_christwhatshapp_c5");

    if(!level flag::get("flag_start_memory_end")) {
      var_f17f3414 = util::function_3ac6fa36("vox_cp_prsn_03500_lazr_idontunderstand_7f", "vox_cp_prsn_03500_lazr_idontunderstand_f2", "vox_cp_prsn_03500_lazr_idontunderstand_d0");
      namespace_d9b153b9::function_f76551eb("vox_cp_prsn_03500_park_amildseizuresim_57", var_f17f3414, "vox_cp_prsn_03500_sims_ivenofuckingide_6d");
    }

    level flag::wait_till("memory_reaction_vo_start");
    dialogue::radio("vox_cp_prsn_03500_adlr_letsupthedosage_e8");
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_03000_park_okayready_23", "vox_cp_prsn_03000_lazr_readytogo_1c", "vox_cp_prsn_03000_sims_ready_23");
  }

  wait 0.5;
  level flag::set("memory_reaction_vo_complete");
}

function function_72b36315() {
  if(isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da == level.var_baa7cf92) {
    wait 0.25;
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_06000_park_thiscouldbetheo_e0", "vox_cp_prsn_06000_lazr_parkwrotesomeno_61", "vox_cp_prsn_06000_sims_idontknowmaybeo_52");
    level flag::wait_till("bunker_puzzle_room_solved");
    level flag::wait_till("flag_start_memory");
    level flag::wait_till("memory_reaction_vo_start");
    level thread dialogue::radio("vox_cp_prsn_06000_adlr_nodontstopbellf_9b", undefined, 1);
    wait 5.5;
    level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_06000_park_hereitis_ab", "vox_cp_prsn_06000_lazr_hereyougo_25", "vox_cp_prsn_06000_sims_here_b2");
    wait 0.72;
    dialogue::radio("vox_cp_prsn_06000_adlr_bellwevegotajob_e7");
    thread namespace_b6fe1dbe::function_6ec11225();
  } else {
    level.player setmovespeedscale(0.75);
    var_cc1a036 = 7;

    for(i = 1; i < var_cc1a036; i++) {
      level thread function_4eb8ee2d(i);
    }

    wait 3;
    dialogue::radio("vox_cp_prsn_06500_adlr_alabthatdoesnts_d3");
    level flag::wait_till("flag_rob_test");
    level thread dialogue::radio("vox_cp_prsn_06500_adlr_thisisntworking_ec", undefined, 1);
    wait 1.5;
    level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_06500_park_administering1c_db", "vox_cp_prsn_06500_lazr_parksnotessugge_f4", "vox_cp_prsn_06500_sims_icantrysomeadre_d9");
    wait 2.7;
    level.player util::blend_movespeedscale(0.4, 0.05);
    level flag::set("start_long_lab_hallway_rob");
    level thread function_208bb35a();
    wait 1.5;
    level.player util::blend_movespeedscale(1, 2);
    level util::delay_notify(5, "stop_heartbeat");
    level flag::wait_till("memory_reaction_vo_start");

    if(!array::contains(level.var_731c10af.var_e53f209f, "caves")) {
      level dialogue::radio("vox_cp_prsn_06500_adlr_anotherdosewell_89");
    } else if(array::contains(level.var_731c10af.var_e53f209f, "caves") && !array::contains(level.var_731c10af.var_e53f209f, "village")) {
      level dialogue::radio("vox_cp_prsn_06500_adlr_anotherdosewell_b7");
    }

    if(isDefined(level.var_9a750f)) {
      dialogue::radio("vox_cp_prsn_06500_park_iwouldntadviset_38");
      dialogue::radio("vox_cp_prsn_06500_adlr_ididntask_30");
    }
  }

  wait 0.5;
  level flag::set("memory_reaction_vo_complete");
}

function function_208bb35a() {
  level.player endon(#"death");
  self notify("2d3c6d3b564ddebc");
  self endon("2d3c6d3b564ddebc");
  self notify(#"stop_heartbeat");
  self endon(#"stop_heartbeat");

  while(true) {
    level.player playrumbleonentity("heartbeat_low");
    wait 0.25;
    level.player playrumbleonentity("heartbeat_low");
    wait 0.75;
  }
}

function function_4eb8ee2d(number) {
  level endon(#"lab_hallway_exited");

  if(number == 1) {}

  if(number == 2) {}

  if(number == 3) {}

  if(number == 4) {
    level waittill(#"hash_663d8dd4ee025b9");
    wait 1;
    dialogue::radio("vox_cp_prsn_06500_adlr_thatsitbellthat_fa");
  }
}

function function_33822068() {
  if(!level flag::get("flag_drop_player_through_floor")) {
    level thread namespace_b092382c::function_4d08a806();
  }

  if(isDefined(level.var_731c10af.var_d8a772da) && level.var_731c10af.var_d8a772da == level.var_baa7cf92) {
    level flag::wait_till("flag_start_memory");
    thread function_41e45b2d();
    wait 1;
    level flag::wait_till("memory_reaction_vo_start");
  } else {
    level flag::wait_till("infinite_hallway_exited");
    level thread function_3fedd4a8();
    wait 3;
    level dialogue::radio("vox_cp_prsn_10000_adlr_werelosingbellw_03");
    namespace_d9b153b9::function_f76551eb("vox_cp_prsn_10000_park_bellsbeenthroug_1f", "vox_cp_prsn_10000_lazr_maybebellisjust_59", "vox_cp_prsn_10000_sims_wellhellbellsbl_1d");

    if(!level flag::get("flag_start_memory_end")) {
      level dialogue::radio("vox_cp_prsn_10000_adlr_wehavenoleadsle_21");
    }

    level flag::wait_till("memory_reaction_vo_start");
  }

  level thread dialogue::radio("vox_cp_prsn_09500_adlr_canbellsurvivea_7d", undefined, 1);
  wait 1.6;
  level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09500_park_nowyoureaskingm_7d", "vox_cp_prsn_09500_lazr_youreaskingme_09", "vox_cp_prsn_09500_sims_ihavenoidea_eb");
  wait 1.25;
  level thread dialogue::radio("vox_cp_prsn_09500_adlr_doitwerenotleav_15", undefined, 1);
  thread namespace_b6fe1dbe::function_9d794a0e();
  wait 4;
  level thread namespace_d9b153b9::function_f76551eb("vox_cp_prsn_09500_park_ready_23", "vox_cp_prsn_09500_lazr_ready_23", "vox_cp_prsn_09500_sims_ready_23");
  wait 1;
  level dialogue::radio("vox_cp_prsn_09500_adlr_bellwevegotajob_13");
  wait 0.5;
  level flag::set("memory_reaction_vo_complete");
}

function function_3fedd4a8() {
  level flag::wait_till("flag_start_memory_end");
  level dialogue::function_9e580f95();
}

function function_9975759a() {
  level flag::wait_till("flag_start_memory");
  wait 1;
  level flag::wait_till("memory_reaction_vo_start");
  wait 0.1;
  level flag::set("memory_reaction_vo_complete");
}

function function_41e45b2d() {
  snd::client_targetname(level.var_afaf5a6d, "perseus");
  level waittill(#"hash_4fef8a23b1544f54");
  snd::client_msg(#"hash_4fef8a23b1544f54");
}

function function_ed113f39(hide, door_name, key_name) {
  if(isstring(door_name)) {
    if(isDefined(key_name) && key_name != "struct") {
      door_struct = struct::get(door_name, key_name);
    } else {
      door_struct = struct::get(door_name, "targetname");
    }
  } else if(isstruct(door_name)) {
    door_struct = door_name;
  }

  if(!(isDefined(door_struct.door_setup) && isDefined(door_struct) && isDefined(door_struct.linked_ents))) {
    if(isDefined(key_name) && key_name == "struct") {
      door_struct = namespace_d9b153b9::door_setup(undefined, door_name);
    } else {
      door_struct = namespace_d9b153b9::door_setup(door_name);
    }
  }

  if(isDefined(hide)) {
    if(isDefined(door_struct.linked_ents)) {
      foreach(linked_ent in door_struct.linked_ents) {
        if(isDefined(linked_ent)) {
          if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy == "door_interact") {
            door_struct namespace_d9b153b9::function_736b8a03();
            continue;
          }

          if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy == "door_lights") {
            if(!isDefined(linked_ent.default_intensity)) {
              linked_ent.default_intensity = linked_ent getlightintensity();
            }

            linked_ent setlightintensity(0.01);
            continue;
          }

          linked_ent hide();
          linked_ent notsolid();
        }
      }
    }

    return;
  }

  if(isDefined(door_struct.linked_ents)) {
    foreach(linked_ent in door_struct.linked_ents) {
      if(isDefined(linked_ent)) {
        if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy == "door_interact") {
          door_struct namespace_d9b153b9::function_736b8a03(1);
          continue;
        }

        if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy == "door_lights") {
          if(isDefined(linked_ent.default_intensity)) {
            linked_ent setlightintensity(linked_ent.default_intensity);
          }

          continue;
        }

        linked_ent show();
        linked_ent solid();
      }
    }
  }
}

function function_810379ec(str_door_name) {
  var_cad35a6 = struct::get_array("final_door_struct", "targetname");

  foreach(s_door in var_cad35a6) {
    s_door = namespace_d9b153b9::door_setup(undefined, s_door, 1);
    level function_ed113f39(1, s_door, "struct");
  }
}

function function_c066544() {
  level thread function_b332d74d("final_door_trigger_creeka", "final_door_struct_creeka");
  level thread function_b332d74d("final_door_trigger_creekb", "final_door_struct_creekb");
  level thread function_b332d74d("final_door_trigger_creekc", "final_door_struct_creekc");
  level thread function_b332d74d("final_door_trigger_creekd", "final_door_struct_creekd");
  level thread function_b332d74d("final_door_trigger_creeke", "final_door_struct_creeke");
  level thread function_b332d74d("final_door_trigger_creekf", "final_door_struct_creekf");
  level thread function_b332d74d("final_door_trigger_creekg", "final_door_struct_creekg");
  level thread function_b332d74d("final_door_trigger_creekh", "final_door_struct_creekh");
  level thread function_b332d74d("final_door_trigger_creeki", "final_door_struct_creeki", 1);
  level thread function_b332d74d("final_door_trigger_creekj", "final_door_struct_creekj");
  level thread function_b332d74d("final_door_trigger_creekk", "final_door_struct_creekk");
  level thread function_b332d74d("final_door_trigger_creekl", "final_door_struct_creekl");
  level thread function_b332d74d("final_door_trigger_creekm", "final_door_struct_creekm");
  level thread function_b332d74d("final_door_trigger_watera", "final_door_struct_watera", 1);
  level thread function_b332d74d("final_door_trigger_waterb", "final_door_struct_waterb");
  level thread function_b332d74d("final_door_trigger_waterc", "final_door_struct_waterc", 1);
  level thread function_b332d74d("final_door_trigger_waterd", "final_door_struct_waterd");
  level thread function_b332d74d("final_door_trigger_watere", "final_door_struct_watere", 1);
  level thread function_b332d74d("final_door_trigger_waterf", "final_door_struct_waterf");
  level thread function_b332d74d("final_door_trigger_waterg", "final_door_struct_waterg");
  level thread function_b332d74d("final_door_trigger_waterh", "final_door_struct_waterh");
  level thread function_b332d74d("final_door_trigger_wateri", "final_door_struct_wateri");
  level thread function_b332d74d("final_door_trigger_waterj", "final_door_struct_waterj", 1);
  level thread function_b332d74d("final_door_trigger_waterk", "final_door_struct_waterk", 1);
  level thread function_b332d74d("final_door_trigger_waterl", "final_door_struct_waterl");
  level thread function_b332d74d("final_door_trigger_waterm", "final_door_struct_waterm", 1);
  level thread function_b332d74d("final_door_trigger_watern", "final_door_struct_watern", 1);
}

function function_b332d74d(str_trigger_name, str_door_name, var_690e93a6) {
  e_trigger = getent(str_trigger_name, "targetname");
  e_trigger waittill(#"trigger");
  s_door = struct::get(str_door_name, "script_noteworthy");
  s_door = namespace_d9b153b9::door_setup(undefined, s_door, undefined, undefined, 1);
  level function_ed113f39(undefined, str_door_name, "script_noteworthy");
  s_door.origin -= (0, 0, 1024);

  foreach(linked_ent in s_door.linked_ents) {
    if(isDefined(linked_ent)) {
      linked_ent movez(-1024, 1, 0.5);

      if(isDefined(linked_ent.script_noteworthy) && linked_ent.script_noteworthy == "door_fx") {
        var_4324ced2 = linked_ent;
      }
    }
  }

  thread namespace_b6fe1dbe::function_61bc0002(linked_ent);
  wait 0.5;
  level.player clientfield::set_to_player("lerp_fov", 8);
  wait 0.5;
  thread namespace_b6fe1dbe::function_501657c8(linked_ent, var_690e93a6);
  linked_ent playrumbleonentity("explosion_generic");
  level.player clientfield::set_to_player("lerp_fov", 0);
  waitframe(1);

  if(is_true(var_690e93a6)) {
    playFX("maps/cp_prisoner/fx9_prisoner_fallingdoor_imp_water_01", var_4324ced2.origin, anglesToForward(var_4324ced2.angles), anglestoup(var_4324ced2.angles));
  } else {
    playFX("maps/cp_prisoner/fx9_prisoner_fallingdoor_imp_dirt_01", var_4324ced2.origin, anglesToForward(var_4324ced2.angles), anglestoup(var_4324ced2.angles));
  }

  playFX("maps/cp_prisoner/fx9_prisoner_fallingdoor_dist_01", var_4324ced2.origin, anglesToForward(var_4324ced2.angles), anglestoup(var_4324ced2.angles));
  screenshake(var_4324ced2.origin, 0.5, 0.1, 0, 0.3, 0.05, 0.05, 700, 10, 10);
  println("<dev string:x38>");
  s_door function_133140de("memory_4_obey", "disobey");
}

function function_b8252dde(var_c79d614f, var_bd555ec2) {
  level thread savegame::checkpoint_save();
  level.player allowjump(0);
  level.player allowsprint(0);
  level flag::set("player_in_bunker_room");

  if(level.var_731c10af.var_e15e5b51.size == 0) {
    scene::add_scene_func("scene_pri_bunker_room_hidden", &function_4c29c028);
    level thread scene::play("scene_pri_bunker_room_hidden");
    level flag::wait_till("flag_start_memory");
    level thread function_cae214f4(var_bd555ec2, "scene_pri_bunker_room_hidden");
    level thread function_7c927add();
  } else if(level.var_731c10af.var_e15e5b51.size == 1) {
    scene::add_scene_func("scene_pri_bunker_room_v2", &function_4c29c028);
    level thread scene::play("scene_pri_bunker_room_v2", "Shot 1");
    level flag::wait_till("flag_start_memory");
    level thread scene::play("scene_pri_bunker_room_v2", "Shot 2");
    level thread function_cae214f4(var_bd555ec2, "scene_pri_bunker_room_v2");
    wait 1;
    level thread function_7c927add();
  } else if(level.var_731c10af.var_e15e5b51.size == 2) {
    scene::add_scene_func("scene_pri_bunker_room_v3", &function_4c29c028);
    tag_align_bunker_3 = struct::get("tag_align_bunker_3", "targetname");
    tag_align_bunker_3 thread scene::play("scene_pri_bunker_room_v3", "Shot 1");
    level flag::wait_till("flag_start_memory");
    tag_align_bunker_3 thread scene::play("scene_pri_bunker_room_v3", "Shot 2");
    tag_align_bunker_3 thread function_cae214f4(var_bd555ec2, "scene_pri_bunker_room_v3");
    level thread function_2538952c();
    level flag::wait_till("bunker_3_computer_complete");
    level thread function_7c927add(#"hash_47bcf92ef64c535c");
  } else {
    level thread bunker_room_final();
    level flag::wait_till("bunker_room_final_complete");
    level flag::set("flag_video_finished");
    level flag::set("memory_reaction_vo_complete");
  }

  level flag::set("flag_start_memory_end");
  level.player allowjump(1);
  level.player allowsprint(1);
}

function function_2538952c() {
  level thread function_cb6665bc();
  interact = struct::get("bunker_3_computer_org", "targetname");
  interact function_c326193d(700);
  level.player clientfield::set_to_player("lerp_fov", 0);
  level notify(#"hash_60555e66236a2649");
  level thread namespace_b6fe1dbe::function_b44ada9a();
  level scene::play("scene_kgb_restricted_area_hack", "Enter");
  level thread scene::play("scene_kgb_restricted_area_hack", "Loop");
  wait 0.5;
  function_819bc4e6();
}

function function_cb6665bc() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.5;
  namespace_6f1d35e1::function_eea42dd9(#"hash_27050e599034898f");
  namespace_6f1d35e1::function_487b4340(#"hash_6dd620902fe6b283");
  namespace_6f1d35e1::function_5d2e6f6a(1);
  namespace_6f1d35e1::function_4951a2c8(1, 1);
  level flag::wait_till("flag_video_finished");
  namespace_6f1d35e1::function_b2911127(1);
}

function function_819bc4e6() {
  namespace_6f1d35e1::function_487b4340(#"hash_2830fd6cdc71ab59");
  namespace_6f1d35e1::function_5d2e6f6a(2);
  namespace_6f1d35e1::function_4951a2c8(1, 50);
  level waittill(#"typing_complete");
  level thread function_141307f2();
}

function function_141307f2() {
  function_c59f3e2f();
  level.var_5728f3c0 = [];
  level.var_bc16d767 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_bc16d767 dialog_tree::function_6bb91351(1);
  level.var_bc16d767 dialog_tree::add_option(#"hash_18d9ea12dce66d6", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt0_complete", &function_ee23cb4c);
  level.var_bc16d767 dialog_tree::add_option(#"hash_7da642e411dd5f54", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt0_complete", &function_e8ed938b);
  level.var_bc16d767 dialog_tree::add_option(#"hash_4cd5e4e83f1b2b21", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt0_complete", &function_54846c05);
  level.var_23743909 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_23743909 dialog_tree::function_6bb91351(1);
  level.var_23743909 dialog_tree::add_option(#"hash_720b6fe0d5b8d56c", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt1_complete", &function_6bf54254);
  level.var_23743909 dialog_tree::add_option(#"hash_5ee30f8a5b291a52", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt1_complete", &function_7e04d0d0);
  level.var_23743909 dialog_tree::add_option(#"hash_2a9f09a33b2a3149", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt1_complete", &function_ac8e0a7f);
  level.var_c2e71e62 = dialog_tree::new_tree(undefined, undefined, 1);
  level.var_c2e71e62 dialog_tree::function_6bb91351(1);
  level.var_c2e71e62 dialog_tree::add_option(#"hash_720b70e0d5b8d71f", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt2_complete", &function_5a647d51);
  level.var_c2e71e62 dialog_tree::add_option(#"hash_5ee3108a5b291c05", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt2_complete", &function_5a647d51);
  level.var_c2e71e62 dialog_tree::add_option(#"hash_2a9f08a33b2a2f96", undefined, undefined, undefined, undefined, undefined, "bunker_3_dt2_complete", &function_5a647d51);
  level.var_bc16d767 thread dialog_tree::run();
}

function function_c59f3e2f() {
  namespace_6f1d35e1::function_487b4340(#"hash_29e5d1b731771567");
  namespace_6f1d35e1::function_5d2e6f6a(2);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  namespace_6f1d35e1::function_5d2e6f6a(7);
  wait 2;
  namespace_6f1d35e1::function_487b4340(#"hash_3d1ba8ca98db9b7");
  namespace_6f1d35e1::function_5d2e6f6a(6);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  wait 1;
  namespace_6f1d35e1::function_4951a2c8(2, 10);
  level waittill(#"typing_complete");
}

function function_ee23cb4c() {
  namespace_6f1d35e1::function_14291ddf(#"hash_8c84bbac536de7");
  namespace_6f1d35e1::function_487b4340(#"hash_6fed9de9bb212370");
  namespace_6f1d35e1::function_5d2e6f6a(12);
  namespace_6f1d35e1::function_4951a2c8(1, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 1);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(5, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt0_complete");
  level.var_23743909 thread dialog_tree::run();
}

function function_e8ed938b() {
  namespace_6f1d35e1::function_487b4340(#"hash_382779157d665d18");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt0_complete");
  level.var_23743909 thread dialog_tree::run();
}

function function_54846c05() {
  namespace_6f1d35e1::function_487b4340(#"hash_532d165238802b27");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 10);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt0_complete");
  level.var_23743909 thread dialog_tree::run();
}

function function_6bf54254() {
  namespace_6f1d35e1::function_487b4340(#"hash_70c2e275cbdb7af3");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 1);
  namespace_6f1d35e1::function_4951a2c8(4, 1);
  namespace_6f1d35e1::function_4951a2c8(5, 10);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt1_complete");
  level.var_c2e71e62 thread dialog_tree::run();
}

function function_7e04d0d0() {
  namespace_6f1d35e1::function_487b4340(#"hash_74a6922d4fb6992f");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 1);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, 1);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt1_complete");
  level.var_c2e71e62 thread dialog_tree::run();
}

function function_ac8e0a7f() {
  namespace_6f1d35e1::function_487b4340(#"hash_417ea9ef47d64790");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 10);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 1);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, 1);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  level flag::set("bunker_3_dt1_complete");
  level.var_c2e71e62 thread dialog_tree::run();
}

function function_5a647d51() {
  namespace_6f1d35e1::function_5d2e6f6a(7);
  wait 2;
  namespace_6f1d35e1::function_487b4340(#"hash_3db698a1195eb71c");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 20);
  level waittill(#"typing_complete");
  wait 1;
  level flag::set("bunker_3_computer_complete");
  wait 2;
  level flag::set("bunker_3_dt2_complete");
}

function function_4c29c028(a_ents) {
  level.var_9fd1d22e = a_ents[#"adler"];
  level.var_afaf5a6d = a_ents[#"hash_10ee8d147d84e3f6"];

  if(isDefined(level.var_afaf5a6d)) {
    if(isDefined(level.var_afaf5a6d._scene_object._o_scene._e_root.scriptbundlename)) {
      level.var_afaf5a6d.propername = # "hash_7f6eed032db2f3ba";
    } else {
      level.var_afaf5a6d.propername = # "hash_7f6eed032db2f3ba";
    }
  }

  foreach(ent in a_ents) {
    ent.ignoreall = 1;
  }
}

function function_cae214f4(var_c79d614f, scene) {
  level flag::wait_till(var_c79d614f + "_complete");
  self scene::stop(scene);
  self scene::delete_scene_spawned_ents(scene);
}

function function_c07fb5b0() {
  level thread scene::init_streamer(#"scene_pri_bunker_room_final", getplayers());
  level flag::wait_till("flag_start_memory");
  level.player util::streamer_wait(undefined, 0, 0, undefined, #"scene_pri_bunker_room_final");
}

function bunker_room_final() {
  level thread function_c07fb5b0();
  level thread namespace_d9b153b9::function_8229554e();
  tag_align_bunker = struct::get("tag_align_bunker", "targetname");
  tag_align_bunker_4 = struct::get("tag_align_bunker_4", "targetname");
  level util::function_bfa9c188("bunker_room_final_player_chair_dynmodel", 1);
  level util::function_bfa9c188("bunker_room_final_part2_dynmodels", 1);
  tag_align_bunker scene::init("scene_pri_bunker_room_final");
  scene::add_scene_func("scene_pri_bunker_room_final", &function_4c29c028, "pt1");
  scene::add_scene_func("scene_pri_bunker_room_final", &function_4c29c028, "pt2");
  bunker_room_final_part1_script_brushmodels = getEntArray("bunker_room_final_part1_script_brushmodels", "targetname");
  level flag::set("flag_memory_4_final_bunker_smart_models_p1");
  wait 1;
  level thread namespace_b6fe1dbe::bunker_room_final();
  videostart("cp_prisoner_tv_footage_grid_v2", 1);
  interact = struct::get("bunker_room_final_chair_interact", "targetname");
  interact function_c326193d(700);
  level flag::wait_till("flag_start_memory");
  tag_align_bunker thread scene::play("scene_pri_bunker_room_final", "sit_down");

  while(level.player getanimtime("t9_pri_bunker_room_final_player_sitdown") < 0.85) {
    wait 0.05;
  }

  level thread namespace_d9b153b9::pstfx_teleport(1, 1, "bunker1");
  var_111fbf0c = snd::play([0.5, "amb_final_briefing_tvs_lp", 1], (-1123, 11249, -1039));
  wait 0.5;
  tag_align_bunker_4 scene::stop("scene_pri_bunker_room_final", 1);
  tag_align_bunker_4 thread scene::play("scene_pri_bunker_room_final", "loop");
  exploder::exploder("lgt_bunker_final_01");
  wait 0.5;
  level flag::set("flag_clear_teleport_fx");
  wait 4;
  tag_align_bunker_4 thread scene::play("scene_pri_bunker_room_final", "pt1");
  level thread function_c0b1e5dc();
  wait 1;
  level waittill(#"slam");
  snd::stop(var_111fbf0c, 0.5);
  level thread lui::screen_fade_out(0, "white");
  level thread namespace_d9b153b9::pstfx_teleport(1, 0, "bunker2");
  videostop("cp_prisoner_tv_footage_grid_v2");
  level util::function_bfa9c188("bunker_room_final_part1_dynmodels", 1);

  foreach(ent in bunker_room_final_part1_script_brushmodels) {
    if(isDefined(ent)) {
      ent hide();
    }
  }

  level util::function_bfa9c188("bunker_room_final_part2_dynmodels", 0);
  level flag::clear("flag_memory_4_final_bunker_smart_models_p1");
  wait 0.5;
  tag_align_bunker_4 scene::stop("scene_pri_bunker_room_final", 1);
  tag_align_bunker_4 thread scene::play("scene_pri_bunker_room_final", "pt2");
  level thread function_af67248c();
  exploder::stop_exploder("lgt_bunker_final_01");
  exploder::exploder("lgt_bunker_final_02");
  wait 0.25;
  level flag::set("flag_clear_teleport_fx");
  level thread lui::screen_fade_in(0.5, "white");
  level waittill(#"hash_4758bbe70ecd6191");
  wait 0.5;
  level thread namespace_d9b153b9::pstfx_teleport(1, 1, "bunker3");
  wait 0.75;
  level flag::set("flag_clear_teleport_fx");
  level waittill(#"hash_4758bbe70ecd6191");
  wait 0.4;
  level thread namespace_d9b153b9::pstfx_teleport(1, 1, "bunker4");
  wait 0.75;
  exploder::stop_exploder("lgt_bunker_final_02");
  exploder::exploder("lgt_bunker_final_03");
  level flag::set("flag_clear_teleport_fx");

  while(!isDefined(level.var_afaf5a6d)) {
    wait 0.05;
  }

  while(level.player getanimtime("t9_pri_bunker_room_final_p2_player_start") < 0.96) {
    wait 0.05;
  }

  level.player val::set("teleport_controls", "freezecontrols", 1);
  level.player val::set("teleport_weapons", "disable_weapons", 1);
  level thread namespace_d9b153b9::pstfx_teleport(1, 1, "bunker5");
  level notify(#"hash_3418b4d6c156bcff");
  level thread namespace_d9b153b9::function_1b1c6dee();
}

function function_c0b1e5dc() {
  wait 1;
}

function function_af67248c() {
  level waittill(#"hash_3418b4d6c156bcff");
  level flag::set("bunker_room_final_complete");
}

function function_c743468f(var_c79d614f) {
  level thread scene::init("scene_pri_bunker_room_v4");
  scene::add_scene_func("scene_pri_bunker_room_v4", &function_4c29c028);
  level thread scene::play("scene_pri_bunker_room_v4", "Shot 1");
  level flag::wait_till("flag_start_memory");
  scene::add_scene_func("scene_pri_bunker_room_v4", &function_4c29c028);
  level scene::play("scene_pri_bunker_room_v4", "Shot 2");
  level thread function_cae214f4(var_c79d614f, "scene_pri_bunker_room_v4");
}

function function_7ab09ebb() {
  videostart("cp_prisoner_tv_footage_grid_v2", 1);
  level flag::wait_till("lab_hallway_teleport_into_lab");
  videostop("cp_prisoner_tv_footage_grid_v2");
  waitframe(1);
  videostart("cp_shared_vietnam_brainwash", 1);
  level flag::wait_till("flag_start_memory_end");
  wait 1.15;
  videostop("cp_shared_vietnam_brainwash");
}

function function_23a50f0f() {
  namespace_b6fe1dbe::music("11.0_lab");
  level thread function_f96a3619();
  level.var_7ed8f58b = namespace_d9b153b9::door_setup("lab_hallway_door_struct", undefined, 1);
  level thread function_c0e8eda7(3);
  level thread function_c0e8eda7(4);
  level thread function_c0e8eda7(5);
  level thread scene::play("lab_hallway_window_3_reel_to_reel");
  level thread scene::play("lab_hallway_window_6_reel_to_reel");
  level thread function_aad550cf("1");
  level thread function_aad550cf("2");
  level thread function_aad550cf("3");
  level thread function_aad550cf("4");
  level thread function_aad550cf("5");
  level thread function_aad550cf("6");
  level.var_7ed8f58b scene::init("scene_pri_bunker_open", level.var_7ed8f58b.door_left);
  level.var_7ed8f58b scene::play("scene_pri_bunker_open", level.var_7ed8f58b.door_left);
  level exploder::stop_exploder("lgt_doorlight");
  level flag::wait_till("lab_hallway_teleport_into_lab");
  interact = struct::get("memory_2_disobey_interact", "targetname");
  interact function_c326193d();
  level flag::set("lab_hallway_exited");
  level util::delay(2, undefined, &scene::stop, "lab_hallway_window_3_reel_to_reel", 1);
  level util::delay(2, undefined, &scene::stop, "lab_hallway_window_6_reel_to_reel", 1);
}

function function_bf552fd1(var_fbbd71c3) {
  if(isDefined(var_fbbd71c3)) {
    level flag::wait_till(var_fbbd71c3);
  }

  level thread scene::init("scene_pri_lab_hall_tile_sequence_01");
  level thread scene::init("scene_pri_lab_hall_tile_sequence_02");
  level thread scene::init("scene_pri_lab_hall_tile_sequence_03");
  level thread scene::init("scene_pri_lab_hall_tile_sequence_04");
}

function function_f96a3619() {
  level thread function_bf552fd1();
  level flag::wait_till("start_long_lab_hallway_rob");
  level thread namespace_b6fe1dbe::function_8d29676a();
  level thread namespace_d9b153b9::function_1e281213("ent_lab_hallway_render_objects", 2, "start_long_lab_hallway_rob", "render_texture_switch", "lab_hallway_exited");
  level thread scene::play("hallway_tile_anim_1", "script_noteworthy");
  wait 1;
  level.player clientfield::set_to_player("lerp_fov", 7);
  level thread scene::play("hallway_tile_anim_2", "script_noteworthy");
  wait 0.75;
  level thread scene::play("hallway_tile_anim_3", "script_noteworthy");
  wait 0.75;
  level thread scene::play("hallway_tile_anim_4", "script_noteworthy");
  wait 3;
  level.player clientfield::set_to_player("lerp_fov", 0);
}

function function_c0e8eda7(number) {
  if(number == 3) {
    scene::add_scene_func("scene_pri_lab_hall_long_adler", &function_f0e80189);
    level thread scene::play("scene_pri_lab_hall_long_adler", "Shot 1");
    util::waittill_any_ents(level, "adler_turns_to_window", level, "lab_hallway_exited");

    if(!level flag::get("lab_hallway_exited")) {
      wait 2;
      level thread scene::play("scene_pri_lab_hall_long_adler", "Shot 2");
      util::waittill_any_ents(level, "button_press", level, "lab_hallway_exited");
    }

    animation = "scene_pri_lab_hall_long_adler";
  }

  if(number == 4) {
    scene::add_scene_func("scene_pri_bunker_room_v3", &function_4c29c028);
    tag_align_bunker_lab_hallway = struct::get("tag_align_bunker_lab_hallway", "targetname");
    tag_align_bunker_lab_hallway thread scene::play("scene_pri_bunker_room_v3", "Shot 1");
    animation = "scene_pri_bunker_room_v3";
  }

  if(number == 5) {
    scene::add_scene_func("scene_pri_lab_hall_hub_vision", &function_a36bacf8, "init");
    level thread scene::init("scene_pri_lab_hall_hub_vision");

    while(!isDefined(level.var_b2721da4)) {
      wait 0.05;
    }

    if(isDefined(level.var_9a750f)) {
      var_ef191d3c = spawner::simple_spawn_single("ally_park_bridge");
      wait 0.05;
      var_ef191d3c.targetname = "Actor 4";

      if(!isDefined(level.var_b2721da4)) {
        level.var_b2721da4 = [];
      } else if(!isarray(level.var_b2721da4)) {
        level.var_b2721da4 = array(level.var_b2721da4);
      }

      if(!isinarray(level.var_b2721da4, var_ef191d3c)) {
        level.var_b2721da4[level.var_b2721da4.size] = var_ef191d3c;
      }

      level thread scene::play("scene_pri_lab_hall_hub_vision", level.var_b2721da4);
    } else if(isDefined(level.var_6c6e6d75)) {
      var_7ac9696f = spawner::simple_spawn_single("ally_lazar_bridge");
      wait 0.05;
      var_7ac9696f.targetname = "Actor 5";

      if(!isDefined(level.var_b2721da4)) {
        level.var_b2721da4 = [];
      } else if(!isarray(level.var_b2721da4)) {
        level.var_b2721da4 = array(level.var_b2721da4);
      }

      if(!isinarray(level.var_b2721da4, var_7ac9696f)) {
        level.var_b2721da4[level.var_b2721da4.size] = var_7ac9696f;
      }

      level thread scene::play("scene_pri_lab_hall_hub_vision", level.var_b2721da4);
    } else {
      level thread scene::play("scene_pri_lab_hall_hub_vision");
    }

    animation = "scene_pri_lab_hall_hub_vision";
  }

  level flag::wait_till("lab_hallway_exited");
  level thread scene::stop(animation);
  level scene::delete_scene_spawned_ents(animation);
}

function function_f0e80189(a_ents) {
  level.var_a9274912 = a_ents[#"actor 2"];

  if(isDefined(level.var_a9274912)) {
    level.var_a9274912.propername = # "hash_7f6eed032db2f3ba";
  }

  if(isDefined(level.gender)) {
    if(level.gender == 0 || level.gender == 1) {
      level.var_a9274912 thread namespace_d9b153b9::function_b0ea272("c_t9_cp_rus_pl_m_agent_global_undrcvr_civ_body2", "p9_rus_kgb_prisoner_hood_male_head");
    } else if(level.gender == 2) {
      level.var_a9274912 thread namespace_d9b153b9::function_b0ea272("c_t9_pl_f_agent_global_undrcvr_civ_body2", "p9_rus_kgb_prisoner_hood_female_head");
    }
  }

  adler = a_ents[#"actor 1"];

  if(isDefined(adler)) {
    adler.propername = # "hash_7f6eed032db2f3ba";
    adler thread function_c6a03680("adler_turns_to_window", #"hash_7edabf22111a04da");
  }
}

function function_a36bacf8(a_ents) {
  level.var_740b3f5b = a_ents[#"actor 2"];

  if(isDefined(level.var_740b3f5b)) {
    level.var_740b3f5b.propername = # "hash_7f6eed032db2f3ba";

    if(isDefined(level.gender)) {
      if(level.gender == 0 || level.gender == 1) {
        level.var_740b3f5b thread namespace_d9b153b9::function_b0ea272("c_t9_cp_rus_pl_m_agent_global_undrcvr_civ_body2", undefined, 1);
      } else if(level.gender == 2) {
        level.var_740b3f5b thread namespace_d9b153b9::function_b0ea272("c_t9_pl_f_agent_global_undrcvr_civ_body2", undefined, 1);
      }
    }
  }

  if(!isDefined(level.var_b2721da4)) {
    level.var_b2721da4 = [];

    foreach(ent in a_ents) {
      if(!isDefined(level.var_b2721da4)) {
        level.var_b2721da4 = [];
      } else if(!isarray(level.var_b2721da4)) {
        level.var_b2721da4 = array(level.var_b2721da4);
      }

      if(!isinarray(level.var_b2721da4, ent)) {
        level.var_b2721da4[level.var_b2721da4.size] = ent;
      }
    }
  }

  adler = a_ents[#"actor 1"];

  if(isDefined(adler) && !isDefined(adler.var_45c9d5e8)) {
    adler.propername = # "hash_7f6eed032db2f3ba";
    adler thread function_c6a03680("window_5", #"hash_7edabf22111a04da");
    adler.var_45c9d5e8 = 1;
  }

  sims = a_ents[#"actor 3"];

  if(isDefined(sims) && !isDefined(sims.var_45c9d5e8)) {
    sims.propername = # "hash_7f6eed032db2f3ba";
    sims thread function_c6a03680("window_5", #"hash_726674254495739e");
    sims.var_45c9d5e8 = 1;
  }

  park = a_ents[#"actor 4"];

  if(isDefined(park)) {
    park.propername = # "hash_7f6eed032db2f3ba";
    park thread function_c6a03680("window_5", #"hash_a0d642b09afc71a");
  }

  lazar = a_ents[#"actor 5"];

  if(isDefined(lazar)) {
    lazar.propername = # "hash_7f6eed032db2f3ba";
    lazar thread function_c6a03680("window_5", #"hash_6a46f5c74f586cb6");
  }
}

function function_c6a03680(var_c35279ad, propername) {
  self endon(#"death", #"entity_deleted");
  level endon(#"lab_hallway_exited");
  level waittill(var_c35279ad);
  self.propername = propername;
}

function function_aad550cf(number) {
  var_9a2b8307 = struct::get("long_hall_window_interact_0" + number, "targetname");
  var_f4204486 = spawn("script_model", var_9a2b8307.origin);
  var_f4204486 setModel("tag_origin");
  var_f4204486 util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_4aba34f692d535a6");
  var_f4204486.cursor_hint = 1;
  window = getent("long_hall_window_0" + number, "targetname");
  window clientfield::set("render_texture_switch_window", 2);
  util::waittill_any_ents(var_f4204486, "trigger", level, "lab_hallway_exited");
  var_f4204486 util::remove_cursor_hint();
  var_f4204486 delete();

  if(!level flag::get("lab_hallway_exited")) {
    notify_str = "lab_hallway_window_" + number;
    level notify(notify_str);
    window clientfield::set("render_texture_switch_window", 3);
    wait 0.05;
    window clientfield::set("render_texture_switch_window", 4);
    snd::play("evt_teleport_light");

    if(number == 1) {
      namespace_b6fe1dbe::music("11.1_window_stinger_1");
    }

    if(number == 3) {
      namespace_b6fe1dbe::music("11.2_window_stinger_2");
      level notify(#"adler_turns_to_window");
      util::waittill_any_ents(level, "button_press", level, "lab_hallway_exited");
      window clientfield::set("render_texture_switch_window", 5);
      wait 0.05;
      window clientfield::set("render_texture_switch_window", 6);
    }

    if(number == 4) {
      level notify(#"window_4");
    }

    if(number == 5) {
      namespace_b6fe1dbe::music("11.3_window_stinger_3");
      level notify(#"window_5");
    }

    if(number == "6") {
      teleport = struct::get("long_hall_player_teleport", "targetname");
      var_48587765 = level.player getplayerangles();
      new_angles = (var_48587765[0], var_48587765[1] + 180, var_48587765[2]);
      level.player setorigin(teleport.origin);
      level.player setplayerangles(new_angles);
      level flag::set("lab_hallway_teleport_into_lab");
    }
  }

  level flag::wait_till("lab_hallway_exited");
  window clientfield::set("render_texture_switch_window", 3);
  wait 0.05;
  window clientfield::set("render_texture_switch_window", 5);
  wait 0.05;

  if(number == 3) {
    window clientfield::set("render_texture_switch_window", 7);
  }
}

function function_5a11fdd5() {
  if(!isDefined(level.var_7ed8f58b)) {
    level.var_7ed8f58b = namespace_d9b153b9::door_setup("lab_hallway_door_struct", 1, 1);
  }

  level.var_7ed8f58b thread namespace_d9b153b9::ent_cleanup();
  level scene::delete_scene_spawned_ents("hallway_tile_anim_1,script_noteworthy");
  level scene::delete_scene_spawned_ents("hallway_tile_anim_2,script_noteworthy");
  level scene::delete_scene_spawned_ents("hallway_tile_anim_3,script_noteworthy");
  level scene::delete_scene_spawned_ents("hallway_tile_anim_4,script_noteworthy");
  wait 1;
  var_cc1a036 = 7;

  for(i = 1; i < var_cc1a036; i++) {
    window = getent("long_hall_window_0" + i, "targetname");

    if(isDefined(window)) {
      window delete();
    }
  }

  var_1da2a9b2 = getEntArray("ent_lab_hallway_render_objects", "targetname");

  foreach(var_63151ff2 in var_1da2a9b2) {
    if(isDefined(var_63151ff2)) {
      var_63151ff2 delete();
    }
  }
}

function function_7c927add(var_ec670c03) {
  level waittilltimeout(0.76, #"hash_35bc1cd22912ce5c");

  if(isDefined(var_ec670c03)) {
    level lui::play_movie(var_ec670c03, "fullscreen", 0, 0, 1);
  }

  level flag::set("flag_video_finished");
}

function function_3440cd05() {
  level.var_a5e0d8d4 = [];
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_bellthisiswhere_20";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_bellyourelookin_ee";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_niceworkproduci_d8";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_iknowyoucandoth_32";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_yougrabtheintel_2a";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_nomorehalfassin_85";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_belllistentomei_52";
  level.var_a5e0d8d4[level.var_a5e0d8d4.size] = "vox_cp_prsn_38000_adlr_wevegotajobtodo_fc";
  level.var_dc077055 = 0;
  lab_long_tv_script_structs = struct::get_array("lab_long_tv_script_structs", "targetname");
  array::thread_all(lab_long_tv_script_structs, &function_9e371412);
}

function function_9e371412() {
  if(!isDefined(self)) {
    return;
  }

  self.script_model = spawn("script_model", self.origin);
  self.script_model.angles = self.angles;
  self.script_model setModel(self.model);
  self.script_model thread namespace_d9b153b9::ent_cleanup("flag_start_memory_end", 1);
  self.script_model hide();
  level flag::wait_till("flag_memory_3_disobey_door");
  threshold = 125;

  while(true) {
    distance = distancesquared(level.player.origin, self.origin);

    if(distance < threshold * threshold) {
      break;
    }

    if(level flag::get("flag_start_memory_end")) {
      break;
    }

    wait 0.05;
  }

  self thread namespace_b6fe1dbe::function_c298c625(threshold);

  if(!level flag::get("flag_start_memory_end")) {
    self.script_model show();
    self.script_model.on = 1;
    wait randomfloatrange(2, 4);
    alias = function_abcaf2d3();

    if(isDefined(alias) && isDefined(self.script_model)) {
      self thread function_fbb777c7();
      snd::play(alias, self.script_model.origin);
    }
  }
}

function function_fbb777c7() {
  level flag::wait_till("flag_start_memory_end");

  if(isDefined(self.script_model)) {
    snd::stop(self.script_model);
  }
}

function function_abcaf2d3() {
  if(level.var_dc077055 >= level.var_a5e0d8d4.size - 1) {
    level.var_dc077055 = 0;
  } else {
    level.var_dc077055++;
  }

  return level.var_a5e0d8d4[level.var_dc077055];
}

function function_b1f3ab09() {
  lab_long_tv_script_brushmodels = getEntArray("lab_long_tv_script_brushmodels", "targetname");
  array::thread_all(lab_long_tv_script_brushmodels, &namespace_d9b153b9::ent_cleanup);
}

function function_fbfe814c() {
  wait 3;
}

function function_9e5ba421() {
  if(isDefined(self.script_noteworthy)) {
    distance = int(self.script_noteworthy);
    distancestart = distance * distance;
  } else {
    distancestart = 1000000;
  }

  self show();

  while(true) {
    infov = level.players[0] util::point_in_fov(self.origin, 0.42, 1);
    var_a2d6d849 = distance2dsquared(self.origin, level.players[0].origin);

    if(infov && distancestart > var_a2d6d849) {
      break;
    }

    wait 0.1;
  }

  wait 1;

  while(true) {
    infov = level.players[0] util::point_in_fov(self.origin, 0.98, 1);

    if(infov) {
      eye = level.players[0] getEye();
      a_trace = beamtrace(eye, self.origin + (0, 0, 20), 1, level.players[0]);
      visible = self sightconetrace(eye, level.players[0], level.players[0].angles, 10);

      if(visible) {
        break;
      }
    }

    wait 0.1;
  }

  wait 1;
  self hide();
}