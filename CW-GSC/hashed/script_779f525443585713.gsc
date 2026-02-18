/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_779f525443585713.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_210ec734a4149bac;
#using script_2d443451ce681a;
#using script_32ff16d71b77016b;
#using script_396062ed2667195d;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\util;
#namespace namespace_99e99ffa;

function function_1d90bc4a() {
  level thread scene::init_streamer(#"scene_kgb_ambient_atrium_talk", getplayers());
}

function function_25482400() {
  level flag::init("flag_atrium_ambient_scenes_clear");
  level flag::init("flag_lobby_and_checkpoint_ambient_scenes_clear");
  level flag::init("player_entering_atrium_clear");
  level flag::init("flag_shot_2_single_anim_over");
}

function function_99e99ffa(var_d3440450) {
  function_25482400();
  level.var_d22e9216 = [];
  level.var_89838737 = getdvarint(#"hash_7ed94d53db6a7d54", 99);
  level thread function_7ddaa372();
  spawner::add_spawn_function_group("atrium_civ_walker", "targetname", &function_8828fcf4);
  spawner::add_spawn_function_group("standing_armed_a", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9);
  spawner::add_spawn_function_group("standing_armed_b", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9);
  scene::add_scene_func("scene_kgb_ambient_walk_briefcase_b", &function_612a0725);
  scene::add_scene_func("scene_kgb_ambient_walk_briefcase_a", &function_612a0725);
  scene::add_scene_func("scene_kgb_ambient_walk_and_talk_duo_a", &function_612a0725);
  scene::add_scene_func("scene_kgb_ambient_walk_folder_a", &function_612a0725);
  level.var_31a33946 = [];
  level.var_fdb0359e = spawnStruct();
  level.var_fdb0359e.section = [];
  level thread function_3cb2286e();
  level thread function_41538e53();
  level thread function_21b05565();
  level thread function_46c6575();
  level thread function_d6754bb5();
  level thread function_575ad786("atrium", undefined, undefined, 1, 3);
  level thread function_575ad786("atrium_2nd_floor", "flag_atrium_ambient_scenes", "kgb_ins_rv_completed");
  level thread function_575ad786("lobby_and_checkpoint", undefined, undefined, 1, 3);
  level thread function_575ad786("west_hall", undefined, "kgb_ins_rv_completed", 0, 2);
  level thread function_575ad786("interrogation", undefined, "kgb_ins_rv_completed");

  if(!level flag::get("kgb_ins_prepare_completed")) {
    level thread function_24a7c694();
    level thread function_59bafa47("east_hall");
    level thread function_59bafa47("west_hall", "flag_west_hall_civ_walker");
  }

  level thread function_9da2d35a();
  level thread function_176a7f2();
  level thread function_3bf9566c();

  if(isDefined(level.var_28c22d88) && (array::contains(level.var_28c22d88, "kgb_ins_activation") || array::contains(level.var_28c22d88, "kgb_ins_briefing"))) {
    level thread function_92a2f743();
    level thread function_ea21fe3e();
    level thread function_92169709();
    level thread function_c2a433a();
  }

  if(!level flag::get("kgb_ins_prepare_completed")) {
    thread function_30c46cec();
  }

  scene::add_scene_func("scene_kgb_ambient_phonecall_a", &function_ae16e341);
  scene::add_scene_func("scene_kgb_ambient_phonecall_a", &function_ae16e341, "stop");
  scene::add_scene_func("scene_kgb_ambient_phonecall_b", &function_ae16e341);
  scene::add_scene_func("scene_kgb_ambient_phonecall_b", &function_ae16e341, "stop");
  level thread function_ff442a79();
  scene::add_scene_func("scene_kgb_krav_computer", &function_5e379549, "Exit");
  scene::add_scene_func("scene_kgb_restricted_area_hack", &function_5e379549, "Exit");
}

function function_5e379549(a_ents) {
  setDvar(#"hash_6b57212fd4fcdd3a", 350);
}

function function_46c6575() {
  var_f391a8ff = getspawnerarray("lobby_and_checkpoint_civ_walker", "targetname");
  var_51f76890 = getspawnerarray("atrium_civ_walker", "targetname");
  var_e0213fec = arraycombine(var_f391a8ff, var_51f76890);

  foreach(spawner in var_e0213fec) {
    spawner spawner::add_spawn_function(&function_ff82cb1a);
    spawner spawner::add_spawn_function(&kgb_ins_prepare::function_252c0591);
  }
}

function function_1b3a9d9f(var_620e7062, scenename, var_4d5f9024, var_daffc6cc) {
  if(var_620e7062 == "play") {
    if(isDefined(var_daffc6cc) && var_daffc6cc == 1) {
      if(isDefined(var_4d5f9024)) {
        if(level.var_d22e9216.size < level.var_89838737) {
          level thread scene::play(scenename, var_4d5f9024);
          arrayinsert(level.var_d22e9216, scenename, 0);
        }
      } else if(level.var_d22e9216.size < level.var_89838737) {
        level thread scene::play(scenename);
        arrayinsert(level.var_d22e9216, scenename, 0);
      }
    } else if(isDefined(var_4d5f9024)) {
      if(level.var_d22e9216.size < level.var_89838737) {
        arrayinsert(level.var_d22e9216, scenename, 0);
        level scene::play(scenename, var_4d5f9024);
      }
    } else if(level.var_d22e9216.size < level.var_89838737) {
      arrayinsert(level.var_d22e9216, scenename, 0);
      level scene::play(scenename);
    }

    return;
  }

  if(var_620e7062 == "stop") {
    if(isDefined(var_daffc6cc) && var_daffc6cc == 1) {
      if(isDefined(var_4d5f9024)) {
        level thread scene::stop(scenename, var_4d5f9024);
        arrayremovevalue(level.var_d22e9216, scenename);
      } else {
        level thread scene::stop(scenename);
        arrayremovevalue(level.var_d22e9216, scenename);
      }

      return;
    }

    if(isDefined(var_4d5f9024)) {
      level scene::stop(scenename, var_4d5f9024);
      arrayremovevalue(level.var_d22e9216, scenename);
      return;
    }

    level scene::stop(scenename);
    arrayremovevalue(level.var_d22e9216, scenename);
  }
}

function function_7ddaa372() {
  self endon(#"kgb_fail_mission");

  if(!getdvarint(#"hash_63e6a111fac67bf3", 0)) {
    return;
  }

  var_ce22f5db = 0;
  var_8253fd4b = [];

  while(true) {
    if(level.var_d22e9216.size > var_ce22f5db || level.var_d22e9216.size < var_ce22f5db) {
      var_ce22f5db = level.var_d22e9216.size;
      var_8253fd4b = level scene::get_active_scenes();

      iprintlnbold("<dev string:x38>" + level.var_d22e9216.size);
      iprintln("<dev string:x50>" + level scene::get_active_scenes().size);
    }

    waitframe(1);
    level.var_89838737 = getdvarint(#"hash_7ed94d53db6a7d54", 99);
  }
}

function function_8828fcf4() {
  wait 0.1;

  if((!isDefined(level.var_fdb0359e.section[# "east_hall"].var_cd964f83) || isDefined(level.var_fdb0359e.section[# "east_hall"].var_cd964f83) && !array::contains(level.var_fdb0359e.section[# "east_hall"].var_cd964f83, self)) && isDefined(self.var_639fbd40) && self.var_639fbd40 != "atrium" && isDefined(self) && isDefined(self.start_struct) && isDefined(self.start_struct.targetname) && self.start_struct.targetname != "west_hall_start_1") {
    if(math::cointoss()) {
      if(math::cointoss()) {
        self namespace_f592a7b::function_7bd21c92("BRIEFCASE_LEFT");
      } else {
        self namespace_f592a7b::function_7bd21c92("BRIEFCASE_RIGHT");
      }

      waitresult = self waittill(#"death", #"delete", #"entitydeleted", #"hash_7cbff9b55c2727");

      if(isDefined(self)) {
        self namespace_f592a7b::function_7bd21c92("NONE");
      }
    }
  }
}

function function_3bf9566c() {
  level.player endon(#"death");
  level endon(#"kgb_fail_mission");

  if(level flag::get("kgb_ins_prepare_completed")) {
    return;
  }

  level flag::wait_till("kgb_ins_tutorial_completed");
  var_61d8cb78 = struct::get_array("atrium_hall_struct", "targetname");
  scene::add_scene_func("scene_kgb_ambient_corner_talk_duo_a", &function_4be4b3bc, "Shot 4");
  scene_shots = scene::get_all_shot_names("scene_kgb_ambient_corner_talk_duo_a");
  var_26a0c491 = "Shot 1";
  var_2b1d17ff = 1;

  while(true) {
    level flag::wait_till_any(array("flag_atrium_ambient_scenes", "kgb_ins_rv_completed"));

    if(level flag::get("kgb_ins_rv_completed")) {
      break;
    }

    var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

    if(isDefined(var_8df68fc1.script_noteworthy) && !issubstr(var_8df68fc1.script_noteworthy, "east")) {
      if(!scene::is_active("scene_kgb_ambient_corner_talk_duo_a")) {
        function_1b3a9d9f("play", "scene_kgb_ambient_corner_talk_duo_a", var_26a0c491, 1);
      }

      level flag::function_4bf6d64f(array("player_entering_atrium"), array("flag_atrium_ambient_scenes"));

      if(!level flag::get("flag_atrium_ambient_scenes")) {
        var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

        if(isDefined(var_8df68fc1.script_noteworthy) && !issubstr(var_8df68fc1.script_noteworthy, "east")) {
          function_1b3a9d9f("stop", "scene_kgb_ambient_corner_talk_duo_a", 1, 1);
        } else {
          level flag::function_4bf6d64f(array("flag_atrium_ambient_scenes"), array("flag_east_hall_ambient_scenes"));

          if(!level flag::get("flag_east_hall_ambient_scenes")) {
            function_1b3a9d9f("stop", "scene_kgb_ambient_corner_talk_duo_a", 1, 1);
          }
        }

        wait 0.1;
        continue;
      } else {
        var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

        if(isDefined(var_8df68fc1.script_noteworthy) && !issubstr(var_8df68fc1.script_noteworthy, "east")) {
          var_2b1d17ff++;

          while(true) {
            if(scene::is_active("scene_kgb_ambient_corner_talk_duo_a")) {
              if(var_26a0c491 != "Shot " + var_2b1d17ff) {
                var_26a0c491 = "Shot " + var_2b1d17ff;
                function_1b3a9d9f("play", "scene_kgb_ambient_corner_talk_duo_a", var_26a0c491, 1);
                wait 1;
              }
            }

            if(var_26a0c491 == "Shot 2") {
              level thread function_ae19bb1f();
              level flag::function_4bf6d64f(array("flag_shot_2_single_anim_over"), array("flag_atrium_ambient_scenes"));
              var_2b1d17ff++;
              var_26a0c491 = "Shot " + var_2b1d17ff;
            }

            if(var_26a0c491 == "Shot 4") {
              break;
            }

            level flag::wait_till_clear("player_entering_atrium");
            level flag::function_4bf6d64f(array("player_entering_atrium"), array("flag_atrium_ambient_scenes"));

            if(level flag::get("player_entering_atrium")) {
              var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

              if(isDefined(var_8df68fc1.script_noteworthy) && !issubstr(var_8df68fc1.script_noteworthy, "east")) {
                var_2b1d17ff++;
              }

              wait 0.1;
              continue;
            } else if(!level flag::get("flag_atrium_ambient_scenes")) {
              var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

              if(isDefined(var_8df68fc1.script_noteworthy) && !issubstr(var_8df68fc1.script_noteworthy, "east")) {
                function_1b3a9d9f("stop", "scene_kgb_ambient_corner_talk_duo_a", 1, 1);
              } else {
                level flag::function_4bf6d64f(array("flag_atrium_ambient_scenes"), array("flag_east_hall_ambient_scenes"));

                if(!level flag::get("flag_east_hall_ambient_scenes")) {
                  function_1b3a9d9f("stop", "scene_kgb_ambient_corner_talk_duo_a", 1, 1);
                }
              }

              wait 0.1;
              break;
            }

            wait 0.1;
          }
        }
      }
    } else {
      level flag::wait_till_clear("flag_atrium_ambient_scenes");
    }

    if(var_2b1d17ff >= scene_shots.size || level flag::get("flag_keycard_acquired")) {
      break;
    }

    wait 0.1;
  }

  if(!level flag::get("kgb_ins_rv_completed")) {
    if(isDefined(level.var_fe04fe12)) {
      level.var_fe04fe12 thread function_e21cd128();
    }

    level flag::function_4bf6d64f(array("flag_corner_talk_duo_out_of_sight"), array("flag_atrium_ambient_scenes"));
    var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);

    if(!level flag::get("flag_atrium_ambient_scenes") && isDefined(var_8df68fc1.script_noteworthy) && issubstr(var_8df68fc1.script_noteworthy, "east")) {
      level flag::wait_till("flag_corner_talk_duo_out_of_sight");
    }
  }

  function_1b3a9d9f("stop", "scene_kgb_ambient_corner_talk_duo_a", 1, 1);
}

function function_ae19bb1f() {
  level endon(#"flag_atrium_ambient_scenes_clear");
  level endon(#"flag_shot_2_single_anim_over");
  level waittill(#"shot_2_single_anim_over");
  level flag::set("flag_shot_2_single_anim_over");
}

function function_4be4b3bc(a_ents) {
  level.var_fe04fe12 = a_ents[# "actor 1"];
  level.var_cccf1ba7 = a_ents[# "actor 2"];
  wait 4;

  if(isDefined(level.var_cccf1ba7)) {
    level.var_cccf1ba7 delete();
  }
}

function function_e21cd128() {
  self endon(#"death");
  self endon(#"entitydeleted");
  level endon(#"flag_corner_talk_duo_out_of_sight");
  self function_6353b83d();
  level flag::set("flag_corner_talk_duo_out_of_sight");
}

function function_92a2f743() {
  level endon(#"kgb_fail_mission");

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "kgb_ins_activation")) {
    level flag::wait_till("flag_start_lobby_scene");
    level scene::play("lobby_scene_1", "Shot 1");
    level thread scene::play("lobby_scene_1", "Shot 2");
  } else {
    level thread scene::play("lobby_scene_1", "Shot 2");
  }

  level flag::wait_till("flag_player_seated");
  level scene::stop("lobby_scene_1", 1);
}

function function_ea21fe3e() {
  level endon(#"kgb_fail_mission");

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "kgb_ins_activation")) {
    level flag::wait_till("kgb_ins_activation_completed");
    function_1b3a9d9f("play", "scene_talk_duo_b", "Shot 2");
  }

  function_1b3a9d9f("play", "scene_talk_duo_b", "Shot 3", 1);
  level flag::wait_till("flag_player_seated");
  function_1b3a9d9f("stop", "scene_talk_duo_b", 1);
}

function function_92169709() {
  level endon(#"kgb_fail_mission");

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "kgb_ins_activation")) {
    level waittill(#"hash_b7d623ab42e754a");
    wait 10;
    function_1b3a9d9f("play", "kgb_ins_activation_walk_briefcase_a");
    function_1b3a9d9f("stop", "kgb_ins_activation_walk_briefcase_a", 1);
    return;
  }

  return;
}

function function_c2a433a() {
  level endon(#"kgb_fail_mission");

  if(math::cointoss()) {
    function_1b3a9d9f("play", "activation_atrium_trio_standing_armed_a", undefined, 1);
    level flag::wait_till("flag_player_seated");
    function_1b3a9d9f("stop", "activation_atrium_trio_standing_armed_a", 1);
    return;
  }

  function_1b3a9d9f("play", "activation_lobby_standing_armed_b", undefined, 1);
  level flag::wait_till("flag_player_seated");
  function_1b3a9d9f("stop", "activation_lobby_standing_armed_b", 1);
}

function function_9da2d35a() {
  level endon(#"kgb_fail_mission");
  spawner::add_spawn_function_group("security_guard_splitup", "script_noteworthy", &kgb_ins_prepare::function_862e8bf9);

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "kgb_ins_activation") || array::contains(level.var_28c22d88, "kgb_ins_briefing") || array::contains(level.var_28c22d88, "kgb_ins_tutorial")) {
    level flag::wait_till("kgb_ins_briefing_completed");
    level flag::wait_till("flag_tutorial_map_complete");
    function_1b3a9d9f("play", "scene_kgb_ambient_security_guard_splitup", "Shot 3", 1);
    return;
  }

  var_66cf70ea = getspawnerarray("security_guard_splitup", "script_noteworthy");
  var_ac70b3e5 = spawner::simple_spawn(var_66cf70ea);
}

function function_176a7f2() {
  level endon(#"kgb_fail_mission");

  if(level flag::get("kgb_ins_rv_completed")) {
    return;
  }

  if(isDefined(level.var_28c22d88) && array::contains(level.var_28c22d88, "kgb_ins_activation") || array::contains(level.var_28c22d88, "kgb_ins_briefing") || array::contains(level.var_28c22d88, "kgb_ins_tutorial") || array::contains(level.var_28c22d88, "kgb_ins_prepare")) {
    while(!level flag::get("kgb_ins_briefing_completed") || !level flag::get("kgb_ins_tutorial_completed")) {
      level flag::wait_till("flag_atrium_ambient_scenes");
      function_1b3a9d9f("play", "scene_kgb_ambient_atrium_talk", "Shot 1", 1);
      level flag::wait_till_clear("flag_atrium_ambient_scenes");
      function_1b3a9d9f("stop", "scene_kgb_ambient_atrium_talk", 1);
    }

    while(true) {
      level flag::wait_till("flag_atrium_ambient_scenes");
      function_1b3a9d9f("play", "scene_kgb_ambient_atrium_talk", "Shot 2", 1);
      level flag::function_4bf6d64f(array("player_entering_atrium"), array("flag_atrium_ambient_scenes"));

      if(level flag::get("player_entering_atrium")) {
        break;
      } else {
        function_1b3a9d9f("stop", "scene_kgb_ambient_atrium_talk", 1);
      }

      wait 0.1;
    }

    level flag::wait_till_clear("flag_atrium_ambient_scenes");
    function_1b3a9d9f("stop", "scene_kgb_ambient_atrium_talk", 1);
  }

  while(true) {
    level flag::wait_till_any(array("flag_atrium_ambient_scenes", "kgb_ins_rv_completed"));

    if(level flag::get("kgb_ins_rv_completed")) {
      break;
    }

    function_1b3a9d9f("play", "scene_kgb_ambient_atrium_talk", "Shot 3", 1);
    level flag::function_4bf6d64f(array("kgb_ins_rv_completed"), array("flag_atrium_ambient_scenes"));
    function_1b3a9d9f("stop", "scene_kgb_ambient_atrium_talk", 1);

    if(level flag::get("kgb_ins_rv_completed")) {
      break;
    }
  }

  if(scene::is_active("scene_kgb_ambient_atrium_talk")) {
    function_1b3a9d9f("stop", "scene_kgb_ambient_atrium_talk", 1);
  }
}

function function_d6754bb5() {
  level endon(#"kgb_ins_rv_completed");
  level endon(#"flag_cleanup_kgb_hq");
  level endon(#"kgb_fail_mission");
  level.player endon(#"death");

  if(level flag::get("kgb_ins_rv_completed")) {
    return;
  }

  var_61d8cb78 = struct::get_array("atrium_hall_struct", "targetname");

  while(true) {
    level flag::wait_till("player_entering_atrium");
    level flag::clear("player_entering_atrium_clear");
    level.var_8df68fc1 = arraygetclosest(level.player.origin, var_61d8cb78);
    var_2795d954 = arraygetfarthest(level.player.origin, var_61d8cb78);

    if(!isDefined(var_2795d954)) {
      waitframe(1);
      continue;
    }

    if(isDefined(level.var_8df68fc1.script_noteworthy) && level.var_8df68fc1.script_noteworthy == "atrium_hall_east") {
      var_7153b954 = function_a98ccf16(var_61d8cb78, var_2795d954);

      if(isDefined(var_7153b954)) {
        str = var_7153b954.script_noteworthy + "_scene";
        var_3d7dd6bd = struct::get_array(str, "script_noteworthy");
        var_75307276 = array::random(var_3d7dd6bd);

        if(isDefined(level.var_31fbb1c5) && level.var_31fbb1c5 == var_75307276.scriptbundlename) {
          while(true) {
            if(level.var_31fbb1c5 == var_75307276.scriptbundlename) {
              var_75307276 = array::random(var_3d7dd6bd);
            } else {
              break;
            }

            wait 0.05;
          }
        }

        level.var_31fbb1c5 = var_75307276.scriptbundlename;
        level thread function_3fe5e74f(var_7153b954, var_75307276);
      }

      wait 0.25;
    }

    str = var_2795d954.script_noteworthy + "_scene";
    var_d73d7664 = struct::get_array(str, "script_noteworthy");
    var_bb266cc8 = array::random(var_d73d7664);

    if(isDefined(level.var_31fbb1c5) && level.var_31fbb1c5 == var_bb266cc8.scriptbundlename) {
      while(true) {
        if(level.var_31fbb1c5 == var_bb266cc8.scriptbundlename) {
          var_bb266cc8 = array::random(var_d73d7664);
        } else {
          break;
        }

        wait 0.05;
      }
    }

    level.var_31fbb1c5 = var_bb266cc8.scriptbundlename;
    level thread function_3fe5e74f(var_2795d954, var_bb266cc8);
    clear_flag = "flag_atrium_ambient_scenes_clear";

    if(!isDefined(level.var_fdb0359e.section[# "atrium"].var_5a6384fe) && level flag::get("kgb_ins_briefing_completed") && level flag::exists("kgb_ins_rv_completed") && !level flag::get("kgb_ins_rv_completed")) {
      level thread function_592da021("atrium", clear_flag);
    }

    level flag::wait_till_clear_timeout(30, "player_entering_atrium");

    if(!level flag::get("player_entering_atrium")) {
      wait 5;
    }

    if(!level flag::get("player_entering_atrium")) {
      level flag::set("player_entering_atrium_clear");
    }

    wait 0.1;
  }
}

function function_a98ccf16(structs, farthest) {
  var_91985f47 = arraycopy(structs);
  arrayremovevalue(var_91985f47, farthest);
  return arraygetfarthest(level.player.origin, var_91985f47);
}

function function_3fe5e74f(var_5d4d655a, scene, delay) {
  level.player endon(#"death");

  if(isDefined(delay)) {
    wait delay;
  }

  volume = getent(var_5d4d655a.script_noteworthy + "_volume", "targetname");

  if(isDefined(volume)) {
    var_4014838e = volume ai::function_18c4ff86("all");

    foreach(ai in var_4014838e) {
      if(ai istouchingvolume(volume.origin, volume getmins(), volume getmaxs())) {
        if(isDefined(ai.archetype) && isDefined(ai.targetname)) {
          if(ai.archetype != # "civilian" && ai.targetname == "kgb_hq_guard") {
            return;
          }

          var_7f9418b3 = issubstr(ai.targetname, "walker");

          if(ai.archetype == # "civilian" && issubstr(ai.targetname, "walker") && !isDefined(ai.reached_path_end)) {
            return;
          }
        }
      }
    }

    corpses = getcorpsearray();

    foreach(corpse in corpses) {
      if(corpse istouchingvolume(volume.origin, volume getmins(), volume getmaxs())) {
        return;
      }
    }
  }

  if(!level flag::get("player_exiting_atrium")) {
    max_distance = 950625;
  } else {
    max_distance = 842724;
  }

  distance = distancesquared(level.player.origin, var_5d4d655a.origin);

  if(distance < max_distance) {
    return;
  }

  thread function_c464ca4e(scene);
  function_1b3a9d9f("play", scene.targetname);
  level notify(#"hash_ee5ce4556fbfba0");
  waitframe(1);
  level scene::delete_scene_spawned_ents(scene.targetname);
}

function function_c464ca4e(scene) {
  level endon(#"flag_player_swap");
  level.player endon(#"death");
  var_ecfa6964 = issubstr(scene.targetname, "atrium_hall_east");
  var_b7304209 = issubstr(scene.targetname, "left_to_right");

  if(!var_ecfa6964) {
    return;
  }

  var_d3bc6863 = getent("atrium_stairwell_double_door_left", "targetname");
  var_617e03e8 = getent("atrium_stairwell_double_door_right", "targetname");

  if(var_b7304209) {
    wait 5.1;
  }

  if(issubstr(scene.targetname, "duo")) {
    thread function_c941e0f8(var_d3bc6863);
    wait 0.5;
    thread function_c941e0f8(var_617e03e8);
    return;
  }

  thread function_c941e0f8(var_617e03e8);
}

function function_c941e0f8(door) {
  if(door doors::is_open()) {
    door doors::close();
    return;
  }

  door doors::open();
  wait 0.7;

  if(math::cointoss()) {
    door doors::close();
  }
}

function function_612a0725(a_ents) {
  walk_and_delete_ai_volumes = getEntArray("walk_and_delete_ai_volumes", "script_noteworthy");
  count = 0;

  foreach(volume in walk_and_delete_ai_volumes) {
    foreach(ent in a_ents) {
      if(ent istouching(volume)) {
        count++;
      }

      if(isDefined(ent._scene_object._o_scene._e_root.targetname)) {
        var_8041f35c = ent._scene_object._o_scene._e_root.targetname;
      }
    }

    if(a_ents.size == count) {
      var_6df840cd = volume;
      break;
    }
  }

  if(!isDefined(var_6df840cd)) {
    return;
  }

  while(a_ents.size > 0) {
    var_3cf3d283 = 0;
    function_1eaaceab(a_ents);

    if(a_ents.size == 0) {
      return;
    }

    foreach(ent in a_ents) {
      if(isDefined(ent)) {
        if(!ent istouching(var_6df840cd)) {
          var_3cf3d283++;
        }

        continue;
      }

      function_1eaaceab(a_ents);
    }

    if(var_3cf3d283 == a_ents.size) {
      break;
    }

    wait 0.05;
  }

  if(isDefined(var_8041f35c)) {
    level notify(#"hash_ee5ce4556fbfba0");
    waitframe(1);
    function_1b3a9d9f("stop", var_8041f35c);
    level scene::delete_scene_spawned_ents(var_8041f35c);
  }
}

function function_575ad786(var_c79d614f, section_flag, endon_flag, var_4b179f26 = 2, var_9531ed02 = 4) {
  level.player endon(#"death");

  if(isDefined(endon_flag)) {
    level endon(endon_flag);

    if(flag::get(endon_flag)) {
      return;
    }
  }

  level endon(#"kgb_fail_mission");

  if(!isDefined(level.var_fdb0359e.section[var_c79d614f])) {
    level.var_fdb0359e.section[var_c79d614f] = spawnStruct();
  }

  level.var_fdb0359e.section[var_c79d614f].var_4c49141c = struct::get_array(var_c79d614f + "_scene", "script_noteworthy");
  var_54d74f4b = getspawnerarray(var_c79d614f + "_civ_walker_drone", "targetname");

  if(isDefined(var_54d74f4b) && var_54d74f4b.size > 0) {
    level.var_fdb0359e.section[var_c79d614f].var_23789e35 = 1;
  }

  flag = "flag_" + var_c79d614f + "_ambient_scenes";

  if(isDefined(section_flag)) {
    flag = section_flag;
  }

  clear_flag = "flag_" + var_c79d614f + "_ambient_scenes_clear";

  while(true) {
    level flag::wait_till_any(array(flag, "flag_cleanup_kgb_hq"));

    if(level flag::exists(clear_flag) && level flag::get(clear_flag)) {
      level flag::clear(clear_flag);
    }

    if(level flag::get("flag_cleanup_kgb_hq")) {
      return;
    }

    level function_49dbc9a2(var_c79d614f);

    if(isDefined(level.var_fdb0359e.section[var_c79d614f].var_23789e35) && level.var_fdb0359e.section[var_c79d614f].var_23789e35 == 1) {
      level thread function_28ace0ef(var_c79d614f, clear_flag);
    }

    var_b83afef6 = [];
    var_984196ca = [];
    var_6c775558 = undefined;
    level.var_fdb0359e.section[var_c79d614f].var_4c49141c = array::randomize(level.var_fdb0359e.section[var_c79d614f].var_4c49141c);

    foreach(scene_struct in level.var_fdb0359e.section[var_c79d614f].var_4c49141c) {
      if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
        scene::init(scene_struct.targetname);
      }

      if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "permanent")) {
        if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "multiple_positions")) {
          if(!isDefined(var_6c775558)) {
            var_6c775558 = scene_struct;
          }

          if(isDefined(var_6c775558) && !array::contains(var_984196ca, var_6c775558)) {
            if(!isDefined(var_984196ca)) {
              var_984196ca = [];
            } else if(!isarray(var_984196ca)) {
              var_984196ca = array(var_984196ca);
            }

            var_984196ca[var_984196ca.size] = var_6c775558;
          }
        } else {
          if(!isDefined(var_984196ca)) {
            var_984196ca = [];
          } else if(!isarray(var_984196ca)) {
            var_984196ca = array(var_984196ca);
          }

          var_984196ca[var_984196ca.size] = scene_struct;
        }

        continue;
      }

      if(!array::contains(level.var_fdb0359e.section[var_c79d614f].var_7617d471, scene_struct)) {
        if(!isDefined(var_b83afef6)) {
          var_b83afef6 = [];
        } else if(!isarray(var_b83afef6)) {
          var_b83afef6 = array(var_b83afef6);
        }

        var_b83afef6[var_b83afef6.size] = scene_struct;
      }
    }

    level.var_fdb0359e.section[var_c79d614f].var_7617d471 = [];
    var_85492b3c = [];

    if(level.var_31a33946.size > 1) {
      random_int = 1;
    } else {
      random_int = randomintrange(var_4b179f26, var_9531ed02);
    }

    if(var_b83afef6.size < random_int) {
      random_int = var_b83afef6.size - 1;
    }

    while(var_85492b3c.size < random_int) {
      var_3b33ad8f = array::random(var_b83afef6);
      var_cff12aa9 = [];

      foreach(scene_struct in var_b83afef6) {
        if(scene_struct != var_3b33ad8f) {
          if(!isDefined(var_cff12aa9)) {
            var_cff12aa9 = [];
          } else if(!isarray(var_cff12aa9)) {
            var_cff12aa9 = array(var_cff12aa9);
          }

          var_cff12aa9[var_cff12aa9.size] = scene_struct;
        }
      }

      var_b83afef6 = var_cff12aa9;

      if(!isDefined(var_85492b3c)) {
        var_85492b3c = [];
      } else if(!isarray(var_85492b3c)) {
        var_85492b3c = array(var_85492b3c);
      }

      var_85492b3c[var_85492b3c.size] = var_3b33ad8f;

      if(isDefined(var_3b33ad8f.script_parameters) && issubstr(var_3b33ad8f.script_parameters, "multiple_positions")) {
        var_78e26e2b = [];

        foreach(scene_struct in var_b83afef6) {
          if(scene_struct.scriptbundlename != var_3b33ad8f.scriptbundlename) {
            if(!isDefined(var_78e26e2b)) {
              var_78e26e2b = [];
            } else if(!isarray(var_78e26e2b)) {
              var_78e26e2b = array(var_78e26e2b);
            }

            var_78e26e2b[var_78e26e2b.size] = scene_struct;
          }
        }

        var_b83afef6 = var_78e26e2b;
      }

      if(var_b83afef6.size == 0 && var_85492b3c.size < random_int) {
        break;
      }

      wait 0.05;
    }

    var_888e604f = arraycombine(var_984196ca, var_85492b3c);

    foreach(scene_struct in var_888e604f) {
      if((level flag::get("kgb_ins_rv_completed") || level flag::get("flag_player_swap")) && isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
        arrayremovevalue(var_888e604f, scene_struct);
      }
    }

    foreach(scene_struct in var_888e604f) {
      if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "multiple_shots")) {
        if(!isDefined(scene_struct.str_shots)) {
          scene_struct.str_shots = scene::get_all_shot_names(scene_struct.scriptbundlename);
        }

        if(!isDefined(scene_struct.var_3e2c43ab)) {
          scene_struct.var_3e2c43ab = [];
        }

        if(scene_struct.str_shots.size == scene_struct.var_3e2c43ab.size) {
          scene_struct.var_689ecfec = scene_struct.str_shots[scene_struct.str_shots.size - 1];
        } else {
          foreach(str_shot in scene_struct.str_shots) {
            if(!array::contains(scene_struct.var_3e2c43ab, str_shot)) {
              scene_struct.var_689ecfec = str_shot;

              if(!isDefined(scene_struct.var_3e2c43ab)) {
                scene_struct.var_3e2c43ab = [];
              } else if(!isarray(scene_struct.var_3e2c43ab)) {
                scene_struct.var_3e2c43ab = array(scene_struct.var_3e2c43ab);
              }

              scene_struct.var_3e2c43ab[scene_struct.var_3e2c43ab.size] = str_shot;
              break;
            }
          }
        }

        function_1b3a9d9f("play", scene_struct.targetname, scene_struct.var_689ecfec, 1);
      } else {
        function_1b3a9d9f("play", scene_struct.targetname, undefined, 1);
      }

      if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_7617d471)) {
        level.var_fdb0359e.section[var_c79d614f].var_7617d471 = [];
      } else if(!isarray(level.var_fdb0359e.section[var_c79d614f].var_7617d471)) {
        level.var_fdb0359e.section[var_c79d614f].var_7617d471 = array(level.var_fdb0359e.section[var_c79d614f].var_7617d471);
      }

      level.var_fdb0359e.section[var_c79d614f].var_7617d471[level.var_fdb0359e.section[var_c79d614f].var_7617d471.size] = scene_struct;
    }

    level function_eb07c311(flag, clear_flag, var_c79d614f);
    level notify(#"hash_ee5ce4556fbfba0");
    waitframe(1);

    foreach(struct in level.var_fdb0359e.section[var_c79d614f].var_7617d471) {
      function_1b3a9d9f("stop", struct.targetname);
      level scene::delete_scene_spawned_ents(struct.targetname);
    }

    function_f2359063(var_c79d614f);

    if(level flag::get("flag_cleanup_kgb_hq")) {
      return;
    }

    wait 0.1;
  }
}

function function_eb07c311(flag, var_1609866b, var_c79d614f) {
  while(true) {
    level flag::function_4bf6d64f(array("flag_cleanup_kgb_hq"), array(flag));

    if(isDefined(var_c79d614f)) {
      level function_49dbc9a2(var_c79d614f);
    }

    if(isDefined(var_1609866b)) {
      if(level flag::exists(var_1609866b) && !level flag::get(var_1609866b)) {
        level flag::set(var_1609866b);
      }
    }

    if(level flag::get("flag_cleanup_kgb_hq")) {
      break;
    }

    level flag::wait_till_any_timeout(1, array(flag, "flag_cleanup_kgb_hq"));

    if(isDefined(var_c79d614f)) {
      level function_49dbc9a2(var_c79d614f);
    }

    if(level flag::get(flag) || level flag::get("flag_cleanup_kgb_hq")) {
      if(isDefined(var_1609866b)) {
        if(level flag::exists(var_1609866b) && level flag::get(var_1609866b)) {
          level flag::clear(var_1609866b);
        }
      }

      if(level flag::get("flag_cleanup_kgb_hq")) {
        break;
      }
    } else {
      break;
    }

    wait 0.05;
  }
}

function function_49dbc9a2(var_c79d614f) {
  if(level flag::get("kgb_ins_briefing_completed") && !level flag::get("kgb_ins_rv_completed")) {
    if(isDefined(var_c79d614f) && var_c79d614f == "atrium") {
      level thread function_2bcb6fed(struct::get("atrium_trio_standing_armed_a", "targetname"), "atrium", undefined, "add");
    }
  }

  if(level flag::get("kgb_ins_rv_completed") || level flag::get("flag_player_swap")) {
    if(isDefined(var_c79d614f) && var_c79d614f == "atrium" && !isDefined(level.atrium_scene_post_kgb_ins_rv)) {
      temparray = [];

      foreach(scene_struct in level.var_fdb0359e.section[var_c79d614f].var_4c49141c) {
        if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
          if(!isDefined(temparray)) {
            temparray = [];
          } else if(!isarray(temparray)) {
            temparray = array(temparray);
          }

          temparray[temparray.size] = scene_struct;
        }
      }

      level.var_fdb0359e.section[var_c79d614f].var_4c49141c = struct::get_array("atrium_scene_post_kgb_ins_rv", "script_noteworthy");
      level.var_fdb0359e.section[var_c79d614f].var_4c49141c = arraycombine(level.var_fdb0359e.section[var_c79d614f].var_4c49141c, temparray);
      level.atrium_scene_post_kgb_ins_rv = 1;
    }

    if(isDefined(var_c79d614f) && var_c79d614f == "lobby_and_checkpoint" && !isDefined(level.lobby_and_checkpoint_scene_post_kgb_ins_rv)) {
      temparray = [];

      foreach(scene_struct in level.var_fdb0359e.section[var_c79d614f].var_4c49141c) {
        if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
          if(!isDefined(temparray)) {
            temparray = [];
          } else if(!isarray(temparray)) {
            temparray = array(temparray);
          }

          temparray[temparray.size] = scene_struct;
        }
      }

      level.var_fdb0359e.section[var_c79d614f].var_4c49141c = struct::get_array("lobby_and_checkpoint_scene_post_kgb_ins_rv", "script_noteworthy");
      level.var_fdb0359e.section[var_c79d614f].var_4c49141c = arraycombine(level.var_fdb0359e.section[var_c79d614f].var_4c49141c, temparray);

      if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_4c49141c)) {
        level.var_fdb0359e.section[var_c79d614f].var_4c49141c = [];
      } else if(!isarray(level.var_fdb0359e.section[var_c79d614f].var_4c49141c)) {
        level.var_fdb0359e.section[var_c79d614f].var_4c49141c = array(level.var_fdb0359e.section[var_c79d614f].var_4c49141c);
      }

      level.var_fdb0359e.section[var_c79d614f].var_4c49141c[level.var_fdb0359e.section[var_c79d614f].var_4c49141c.size] = struct::get("lobby_and_checkpoint_guard_entrance_smoking_loop", "targetname");
      level.lobby_and_checkpoint_scene_post_kgb_ins_rv = 1;
    }
  }
}

function function_2bcb6fed(scene_struct, var_c79d614f, flag, var_c3c17d54) {
  level endon(#"flag_cleanup_kgb_hq");
  level endon(#"kgb_fail_mission");

  if(isDefined(var_c3c17d54)) {
    if(var_c3c17d54 == "add") {
      if(isDefined(flag)) {
        level flag::wait_till(flag);
      }

      if(isDefined(scene_struct) && isDefined(level.var_fdb0359e.section[var_c79d614f].var_4c49141c) && !array::contains(level.var_fdb0359e.section[var_c79d614f].var_4c49141c, scene_struct)) {
        if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_4c49141c)) {
          level.var_fdb0359e.section[var_c79d614f].var_4c49141c = [];
        } else if(!isarray(level.var_fdb0359e.section[var_c79d614f].var_4c49141c)) {
          level.var_fdb0359e.section[var_c79d614f].var_4c49141c = array(level.var_fdb0359e.section[var_c79d614f].var_4c49141c);
        }

        level.var_fdb0359e.section[var_c79d614f].var_4c49141c[level.var_fdb0359e.section[var_c79d614f].var_4c49141c.size] = scene_struct;
      }
    }

    if(var_c3c17d54 == "remove") {
      if(isDefined(flag)) {
        level flag::wait_till(flag);
      }

      if(isDefined(scene_struct) && isDefined(level.var_fdb0359e.section[var_c79d614f].var_4c49141c) && array::contains(level.var_fdb0359e.section[var_c79d614f].var_4c49141c, scene_struct)) {
        arrayremovevalue(level.var_fdb0359e.section[var_c79d614f].var_4c49141c, scene_struct);
      }
    }
  }
}

function function_28ace0ef(var_c79d614f, flag) {
  level endon(flag);
  level endon(#"kgb_ins_tutorial_completed");

  if(level flag::get("kgb_ins_tutorial_completed") && issubstr(var_c79d614f, "atrium")) {
    return;
  }

  var_54d74f4b = getspawnerarray(var_c79d614f + "_civ_walker_drone", "targetname");
  var_b16d80e2 = struct::get_array(var_c79d614f + "_civ_walker_drone_start", "targetname");

  while(true) {
    var_7bc9a81c = var_b16d80e2.size + 2;
    var_d20d3998 = randomintrange(1, var_7bc9a81c);
    var_b16d80e2 = array::randomize(var_b16d80e2);
    var_6917cb = [];
    var_6917cb = arraycombine(var_6917cb, var_b16d80e2);

    for(count = 0; count < var_d20d3998; count++) {
      time = randomintrange(2, 5);
      wait time;
      spawner = array::random(var_54d74f4b);

      if(isDefined(var_6917cb) && var_6917cb.size != 0) {
        var_784e2752 = array::random(var_6917cb);
      } else {
        var_784e2752 = array::random(var_b16d80e2);
      }

      arrayremovevalue(var_6917cb, var_784e2752);
      level thread function_a9a4fcb1(spawner, var_784e2752, flag);
    }

    time = randomintrange(15, 20);
    wait time;
    wait 0.1;
  }
}

function function_a9a4fcb1(spawner, struct, flag) {
  spawner.origin = struct.origin;
  spawner.angles = struct.angles;
  spawner.target = struct.target;
  drone = spawner::simple_spawn_single(spawner, &function_226f8d50);
  util::waittill_any_ents(level, flag, drone, "death", drone, "entitydeleted", level, "flag_cleanup_kgb_hq");

  if(level flag::get(flag) || level flag::get("flag_cleanup_kgb_hq")) {
    if(isDefined(drone)) {
      drone delete();
    }
  }
}

function function_226f8d50() {
  self endon(#"death");
  self endon(#"entitydeleted");
  level endon(#"flag_cleanup_kgb_hq");

  if(!isai(self)) {
    self namespace_4e75a347::function_cab4b520("calm");
    return;
  }

  wait 1;

  if(isDefined(self.var_639fbd40) && self.var_639fbd40 == "lobby") {
    if(!isDefined(level.var_31a33946)) {
      level.var_31a33946 = [];
    } else if(!isarray(level.var_31a33946)) {
      level.var_31a33946 = array(level.var_31a33946);
    }

    level.var_31a33946[level.var_31a33946.size] = self;
    self callback::function_d8abfc3d(#"on_ai_killed", &function_79dc78b0);
    self callback::function_d8abfc3d(#"on_entity_deleted", &function_79dc78b0);
  }
}

function function_79dc78b0(str_notify) {
  arrayremovevalue(level.var_31a33946, self);
  function_1eaaceab(level.var_31a33946);
}

function function_592da021(var_c79d614f, flag) {
  level endon(#"kgb_fail_mission");

  if(level.var_31a33946.size == 0) {
    if(isDefined(level.var_8df68fc1.script_noteworthy)) {
      if(issubstr(level.var_8df68fc1.script_noteworthy, "north") || issubstr(level.var_8df68fc1.script_noteworthy, "south")) {
        var_bacd35ee = var_c79d614f + "_east_and_west_start";
      } else if(issubstr(level.var_8df68fc1.script_noteworthy, "east") || issubstr(level.var_8df68fc1.script_noteworthy, "west")) {
        var_bacd35ee = var_c79d614f + "_north_and_south_start";
      }
    }

    var_b16d80e2 = struct::get_array(var_bacd35ee, "targetname");

    if(!isDefined(var_b16d80e2)) {
      return;
    }

    foreach(struct in var_b16d80e2) {
      if(isDefined(struct.script_parameters) && level flag::exists(struct.script_parameters) && !level flag::get(struct.script_parameters)) {
        arrayremovevalue(var_b16d80e2, struct);
      }
    }

    var_b16d80e2 = array::randomize(var_b16d80e2);
    level function_6feed719(var_c79d614f, var_b16d80e2, flag);
  }

  level flag::wait_till_clear("player_entering_atrium");
  level flag::wait_till("player_entering_atrium_clear");

  if(isDefined(level.var_fdb0359e.section[var_c79d614f].var_cd964f83) && level.var_fdb0359e.section[var_c79d614f].var_cd964f83.size == 0) {
    level.var_fdb0359e.section[var_c79d614f].var_5a6384fe = undefined;
  }
}

function function_27e034fe(var_c79d614f, start_struct) {
  var_e0213fec = getspawnerarray(var_c79d614f + "_civ_walker", "targetname");

  if(!isDefined(var_e0213fec) || var_e0213fec.size == 0) {
    var_e0213fec = getspawnerarray("atrium_civ_walker", "targetname");
  }

  spawner = array::random(var_e0213fec);
  spawner.origin = start_struct.origin;
  spawner.angles = start_struct.angles;
  spawner.target = start_struct.target;
  var_15e1308b = spawner::simple_spawn_single(spawner, &function_226f8d50);
  return var_15e1308b;
}

function function_6feed719(var_c79d614f, var_b16d80e2, flag) {
  getplayers()[0] endon(#"death");
  var_b16d80e2 = array::randomize(var_b16d80e2);
  var_784e2752 = array::random(var_b16d80e2);

  if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_725c68b3)) {
    level.var_fdb0359e.section[var_c79d614f].var_725c68b3 = var_784e2752;
  } else {
    if(level.var_fdb0359e.section[var_c79d614f].var_725c68b3 === var_784e2752) {
      while(level.var_fdb0359e.section[var_c79d614f].var_725c68b3 === var_784e2752) {
        var_784e2752 = array::random(var_b16d80e2);
        wait 0.05;
      }
    }

    level.var_fdb0359e.section[var_c79d614f].var_725c68b3 = var_784e2752;
  }

  if(!isDefined(var_784e2752)) {
    return;
  }

  if(!isai(self)) {
    var_15e1308b = function_27e034fe(var_c79d614f, var_784e2752);
  } else {
    var_15e1308b = self;
  }

  var_15e1308b.start_struct = var_784e2752;

  if(isDefined(var_784e2752.script_noteworthy)) {
    var_15e1308b.var_639fbd40 = var_784e2752.script_noteworthy;
  }

  if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_cd964f83)) {
    level.var_fdb0359e.section[var_c79d614f].var_cd964f83 = [];
  }

  if(!isDefined(level.var_fdb0359e.section[var_c79d614f].var_cd964f83)) {
    level.var_fdb0359e.section[var_c79d614f].var_cd964f83 = [];
  } else if(!isarray(level.var_fdb0359e.section[var_c79d614f].var_cd964f83)) {
    level.var_fdb0359e.section[var_c79d614f].var_cd964f83 = array(level.var_fdb0359e.section[var_c79d614f].var_cd964f83);
  }

  level.var_fdb0359e.section[var_c79d614f].var_cd964f83[level.var_fdb0359e.section[var_c79d614f].var_cd964f83.size] = var_15e1308b;
  level.var_fdb0359e.section[var_c79d614f].var_5a6384fe = 1;
  var_15e1308b thread function_13c0420d(flag);
  waitresult = var_15e1308b waittill(#"hash_7b78d67b14e33012", #"reached_path_end", #"hash_4f8182e08dbeba2", #"hash_32280351cf5d49ba", #"death", #"entitydeleted");

  if(!isDefined(var_15e1308b)) {
    return;
  }

  if(isDefined(var_15e1308b.var_639fbd40) && var_15e1308b.var_639fbd40 == "atrium") {
    level function_eb07c311("flag_atrium_ambient_scenes");
  } else {
    var_15e1308b function_6353b83d();
  }

  level notify(#"hash_ee5ce4556fbfba0");
  waitframe(1);

  if(var_15e1308b scene::function_c935c42()) {
    if(isDefined(var_15e1308b._scene_object._o_scene._e_root.targetname)) {
      function_1b3a9d9f("stop", var_15e1308b._scene_object._o_scene._e_root.targetname, 1);
    }
  }

  if(isDefined(var_15e1308b)) {
    var_15e1308b delete();
  }

  function_1eaaceab(level.var_fdb0359e.section[var_c79d614f].var_cd964f83);
}

function function_6353b83d() {
  level endon(#"kgb_fail_mission");
  self endon(#"death");
  self endon(#"entitydeleted");
  level.player endon(#"death");
  count = 0;
  min_time = 50;
  max_time = 100;
  var_d0326866 = 640000;
  max_distance = 250000;
  min_distance = 40000;

  while(isDefined(level.player)) {
    distance = distancesquared(level.player.origin, self.origin);
    eye_pos = level.player getplayercamerapos();
    eye_angles = level.player getplayerangles();
    eye_dir = anglesToForward(eye_angles);
    var_dd9a54cd = cos(45);
    target_pos = self.origin + (0, 0, 30);

    if(util::within_fov(eye_pos, eye_angles, target_pos, var_dd9a54cd)) {
      if(distance > max_distance) {
        var_d94cabb4 = sighttracepassed(level.player getEye(), target_pos, 0, undefined);

        if(!var_d94cabb4) {
          if(count >= max_time) {
            break;
          } else {
            count++;
          }
        } else {
          count = 0;
        }
      }
    } else if(distance > var_d0326866) {
      break;
    } else if(distance > max_distance) {
      if(count >= max_time) {
        break;
      } else {
        count++;
      }
    } else {
      count = 0;
    }

    wait 0.1;
  }

  self notify(#"hash_7cbff9b55c2727");
}

function function_ff82cb1a(a_ents) {
  level endon(#"kgb_fail_mission");
  self endon(#"death");
  self endon(#"entitydeleted");
  self endon(#"path_end");
  self endon(#"hash_4f8182e08dbeba2");
  level.player endon(#"death");
  var_ed8b22a4 = 0;
  var_26a3b8ce = array::random(level.var_d31c810b);

  while(isDefined(level.player)) {
    if(istouching(self.origin, level.player, (18, 18, 100)) && var_ed8b22a4 < 2) {
      self.goalradius = 2048;
      var_f94ad79f = spawner::function_461ce3e9();
      self setgoal(self.origin);
      self ai::look_at(level.player, 0, undefined, 5, 0, undefined, 1);
      self dialogue::queue(var_26a3b8ce[var_ed8b22a4]);
      self pushplayer(1);

      if(var_ed8b22a4 == 0) {
        wait 5;
      } else {
        wait randomintrange(5, 9);
      }

      var_ed8b22a4++;
      self pushplayer(0);
      thread spawner::go_to_node(var_f94ad79f);
      self.goalradius = 16;
      continue;
    }

    if(var_ed8b22a4 >= 2) {
      if(!self function_e827fc0e()) {
        self pushplayer(1);
      }

      self dialogue::queue(var_26a3b8ce[var_ed8b22a4]);
      return;
    }

    wait 0.1;
  }
}

function function_13c0420d(flag) {
  self endon(#"death");
  self endon(#"entitydeleted");
  level flag::wait_till_any(array(flag, "flag_cleanup_kgb_hq"));
  self notify(#"hash_7b78d67b14e33012");
}

function function_24a7c694() {
  level endon(#"flag_west_hall_civ_walker");
  trigger = getent("west_hall_civ_walker_trigger", "targetname");
  trigger.door = trigger namespace_e77bf565::function_3203f263();
  trigger.door doors::waittill_door_opened();
  level flag::set("flag_west_hall_civ_walker");
}

function function_59bafa47(var_c79d614f, flag) {
  level endon(#"flag_cleanup_kgb_hq");
  level endon(#"kgb_fail_mission");
  level endon(#"kgb_ins_rv_completed");

  if(!flag::get("kgb_ins_briefing_completed")) {
    return;
  }

  if(!isDefined(flag)) {
    flag = "flag_" + var_c79d614f + "_ambient_scenes";
  }

  level flag::wait_till(flag);
  var_9e9e1837 = struct::get_array(var_c79d614f + "_start_1", "targetname");
  var_cd5c75b3 = struct::get_array(var_c79d614f + "_start_2", "targetname");

  if(!isDefined(level.var_fdb0359e.section[var_c79d614f])) {
    level.var_fdb0359e.section[var_c79d614f] = spawnStruct();
  }

  if(var_c79d614f == "east_hall") {
    scene::add_scene_func("scene_kgb_ambient_stop_and_chat_duo_b", &function_5838a1f4);
    scene::add_scene_func("scene_kgb_ambient_stop_and_chat_duo_b", &function_e9217daa, "done");
    function_1b3a9d9f("play", "scene_kgb_ambient_stop_and_chat_duo_b", undefined, 1);
    wait 0.1;

    if(isDefined(level.var_94737018)) {
      if(var_cd5c75b3.size > 0) {
        level.var_94737018 thread function_6feed719(var_c79d614f, var_cd5c75b3, flag);
      }

      if(isDefined(level.var_94737018.start_struct)) {
        level.var_94737018.target = level.var_94737018.start_struct.targetname;
        level.var_94737018 thread spawner::go_to_node(level.var_94737018.start_struct);
        level.var_94737018 thread function_226f8d50();
        level.var_94737018 kgb_ins_prepare::function_252c0591();
      }
    }

    if(isDefined(level.var_86b4d49b)) {
      level.var_86b4d49b thread function_6feed719(var_c79d614f, var_9e9e1837, flag);

      if(isDefined(level.var_86b4d49b.start_struct)) {
        level.var_86b4d49b.target = level.var_86b4d49b.start_struct.targetname;
        level.var_86b4d49b thread spawner::go_to_node(level.var_86b4d49b.start_struct);
        level.var_86b4d49b thread function_226f8d50();
        level.var_86b4d49b kgb_ins_prepare::function_252c0591();
      }
    }
  } else {
    level thread function_6feed719(var_c79d614f, var_9e9e1837, flag);
    wait 0.1;

    if(var_cd5c75b3.size > 0) {
      level thread function_6feed719(var_c79d614f, var_cd5c75b3, flag);
    }
  }

  wait 1;

  while(isDefined(level.var_fdb0359e.section[var_c79d614f].var_cd964f83) && level.var_fdb0359e.section[var_c79d614f].var_cd964f83.size > 0) {
    wait 1;
  }

  level.var_fdb0359e.section[var_c79d614f].var_5a6384fe = undefined;
}

function function_5838a1f4(a_ents) {
  level.var_94737018 = a_ents[# "hash_564e9bf9aa88538f"];
  level.var_86b4d49b = a_ents[# "hash_564e9cf9aa885542"];
}

function function_e9217daa(a_ents) {
  level.var_94737018 thread function_ff82cb1a();
  level.var_86b4d49b thread function_ff82cb1a();
}

function function_30c46cec() {
  level endon(#"flag_player_swap");
  level.player endon(#"death");
  var_297d68e3 = getent("breakroom_right_door", "targetname");

  if(!level flag::get("kgb_ins_briefing_completed")) {
    level flag::wait_till("kgb_ins_briefing_completed");
  }

  while(true) {
    trigger::wait_till("atrium_trigger");
    chance = randomintrange(1, 4);

    if(chance == 1) {
      if(var_297d68e3 doors::is_open()) {
        var_297d68e3 doors::close();
      } else {
        var_297d68e3 doors::open();
      }
    }

    wait 60;
  }
}

function function_3cb2286e() {
  level endon(#"flag_cleanup_kgb_hq");
  level endon(#"kgb_fail_mission");

  if(!getdvarint(#"hash_3b256f8d9b7cb004", 1)) {
    return;
  }

  function_a70704f3();
  var_e18ea0f7 = ["vox_cp_rkgb_09850_rmc2_excuseme_8d", "vox_cp_rkgb_09850_rmc2_excuseyou_18", "vox_cp_rkgb_09850_rmc2_fakecough_1e"];
  var_cf387c4b = ["vox_cp_rkgb_09850_rmc2_sorrycomrade_54", "vox_cp_rkgb_09850_rmc2_whatamorning_e7", "vox_cp_rkgb_09850_rmc2_clearingthroat_48"];
  var_9e0199de = ["vox_cp_rkgb_09850_rmc3_myapologies_d7", "vox_cp_rkgb_09850_rmc3_roughdaycomrade_a9", "vox_cp_rkgb_09850_rmc3_fakecough_1e"];
  var_cf1d7c19 = ["vox_cp_rkgb_09850_rmc3_imsorry_3e", "vox_cp_rkgb_09850_rmc3_thisisembarrass_e0", "vox_cp_rkgb_09850_rmc3_clearingthroat_48"];
  level.var_d31c810b = [var_e18ea0f7, var_cf387c4b, var_9e0199de, var_cf1d7c19];
  level.var_b576483 = ["vox_cp_rkgb_09375_rmc2_cough_67", "vox_cp_rkgb_09375_rmc2_cough_67_1", "vox_cp_rkgb_09375_rmc2_hums_0e", "vox_cp_rkgb_09375_rmc2_hums_0e_1", "vox_cp_rkgb_09375_rmc2_sigh_fc", "vox_cp_rkgb_09375_rmc2_sigh_fc_1", "vox_cp_rkgb_09375_rmc2_howmuchlongerno_55", "vox_cp_rkgb_09375_rmc2_anytime_af"];
  level.var_da958300 = ["vox_cp_rkgb_09375_rmc3_cough_67", "vox_cp_rkgb_09375_rmc3_cough_67_1", "vox_cp_rkgb_09375_rmc3_hums_0e", "vox_cp_rkgb_09375_rmc3_hums_0e_1", "vox_cp_rkgb_09375_rmc3_sigh_fc", "vox_cp_rkgb_09375_rmc3_sigh_fc_1", "vox_cp_rkgb_09375_rmc3_hmmm_bd", "vox_cp_rkgb_09375_rmc3_hmmm_bd_1"];
  level.var_bb9797b9 = 120;
  level.var_4ce95d22 = 50;
  level.var_9aa07a0 = 256;
  level.var_30b3395f = 64;
  scene::add_scene_func("scene_kgb_ambient_stop_and_chat_duo_a", &function_c257b422);
  scene::add_scene_func("scene_kgb_ambient_pc_typing_duo_a", &function_382a2785);
  scene::add_scene_func("scene_kgb_ambient_mail_desk_seated", &function_8fc8f7c6);
  scene::add_scene_func("scene_kgb_walkup_stairs_duo", &function_3e91aa3d);
  scene::add_scene_func("scene_kgb_walkup_stairs_civ_guard", &function_3e91aa3d);
  scene::add_scene_func("scene_kgb_walkup_hall_talk", &function_4cc65f99);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_standing_mixed_a", &function_9b3f6c1e);
  scene::function_d0d7d9f7("scene_kgb_ambient_breakroom_smoking", &function_9feb02eb);
  scene::add_scene_func("scene_kgb_ambient_breakroom_counter_duo", &function_26300964);
  scene::add_scene_func("scene_kgb_ambient_breakroom_watercooler_duo", &function_a7b81626);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_desk_a_mixed", &function_6b4f4409);
  scene::add_scene_func("scene_kgb_ambient_talking_trio_standing_mixed_a", &function_45eaefef);
  scene::add_scene_func("scene_kgb_ambient_corner_talk_duo_b", &function_5c2bc4eb, "Shot 2");
  scene::add_scene_func("scene_kgb_ambient_atrium_talk", &function_b31d08b0, "Shot 1");
  scene::add_scene_func("scene_kgb_ambient_atrium_talk", &function_792c3bbe, "Shot 1");
  scene::function_d0d7d9f7("scene_kgb_ambient_atrium_talk", &function_a44bd33e);
  scene::add_scene_func("scene_kgb_ambient_pc_typing_duo_b", &function_ae1c1004);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_desk_c_mixed", &function_6bd39879);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_desk_d_mixed", &function_858c98d);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_standing_a", &function_838eb65b);
  scene::add_scene_func("scene_kgb_ambient_talking_duo_standing_mixed_b_atrium", &function_dedcb768);
  scene::add_scene_func("scene_kgb_ambient_pc_typing_lady_a", &function_d99a120);
  scene::add_scene_func("scene_kgb_ambient_atrium_talking_duo", &function_ac04ad89, "Shot 1");
  scene::add_scene_func("scene_kgb_ambient_atrium_talking_duo", &function_aebfcfbf, "Shot 2");
  scene::add_scene_func("scene_kgb_walkup_stairs_civ_guard", &function_acddd6ae, "Loop");
  scene::add_scene_func("scene_kgb_ambient_talking_trio_standing_armed_a", &function_9aeb9e94);
  scene::add_scene_func("scene_kgb_ambient_railing_duo", &function_28b6b100);
  scene::add_scene_func("scene_kgb_ambient_corner_talk_duo_a", &function_c2d37011, "Shot 2");
  scene::add_scene_func("scene_kgb_ambient_talking_trio_standing_a", &function_18206d92);
  scene::add_scene_func("scene_kgb_ambient_talking_trio_standing_armed_b", &function_cebe3d1b);
  scene::add_scene_func("scene_kgb_ambient_security_vignette", &function_65dea10);
  scene::add_scene_func("scene_kgb_ambient_smoking_standing_a", &function_dfbd6bbc);
  scene::add_scene_func("scene_kgb_ambient_smoking_standing_b", &function_dfbd6bbc);
  scene::add_scene_func("scene_kgb_ambient_smoking_seated_a_loop", &function_dfbd6bbc);
  scene::add_scene_func("scene_kgb_ambient_smoking_seated_a", &function_dfbd6bbc);
  scene::add_scene_func("scene_kgb_ambient_smoking_seated_b", &function_dfbd6bbc);
  scene::add_scene_func("scene_kgb_ambient_typing_female_a_loop", &function_265c4b2b);
  scene::add_scene_func("scene_kgb_ambient_window_cleaning", &function_8fcab530);
  scene::add_scene_func("scene_kgb_bodybag_vignette", &function_a5bc671a, "Duo_Loop");
  scene::add_scene_func("scene_kgb_bodybag_vignette", &function_a5bc671a, "Transition");
  scene::add_scene_func("scene_kgb_ambient_stop_and_chat_duo_b", &function_75c06a2f);
  scene::add_scene_func("scene_kgb_ambient_harass_ask_questions", &function_789de3e1);
  scene::add_scene_func("scene_kgb_ambient_harass_check_papers", &function_8dcdb8c9);
  scene::add_scene_func("scene_kgb_ambient_harass_pat_down", &function_c2e8e3e2);
  scene::add_scene_func("scene_kgb_ambient_harass_wall_frisk", &function_b8bc6f25);
  scene::add_scene_func("scene_kgb_ambient_harass_zakhaev_kravchenko", &function_645c6620);
}

function function_a70704f3() {
  level.var_f83c3b53 = spawnStruct();
  level.var_f83c3b53.locations = [];
  breakroom = spawnStruct();
  breakroom.var_a4ec1473 = [];
  level.var_f83c3b53.locations[# "breakroom"] = breakroom;
  mailroom = spawnStruct();
  mailroom.var_a4ec1473 = [];
  level.var_f83c3b53.locations[# "mailroom"] = mailroom;
  lobby = spawnStruct();
  lobby.var_a4ec1473 = [];
  level.var_f83c3b53.locations[# "lobby"] = lobby;
  atrium = spawnStruct();
  atrium.var_a4ec1473 = [];
  level.var_f83c3b53.locations[# "atrium"] = atrium;
  level.var_f83c3b53.locations[# "breakroom"].var_e720f04f = 2;
  level.var_f83c3b53.locations[# "mailroom"].var_e720f04f = 2;
  level.var_f83c3b53.locations[# "lobby"].var_e720f04f = 2;
  level.var_f83c3b53.locations[# "atrium"].var_e720f04f = 2;
}

function function_7042f8ce(str_scenename, str_location) {
  var_d0638f89 = 0;

  if(level.var_f83c3b53.locations[str_location].var_a4ec1473.size < level.var_f83c3b53.locations[str_location].var_e720f04f && math::cointoss()) {
    arrayinsert(level.var_f83c3b53.locations[str_location].var_a4ec1473, str_scenename, 0);
    var_d0638f89 = 1;
  } else if(level.var_f83c3b53.locations[str_location].var_a4ec1473.size == level.var_f83c3b53.locations[str_location].var_e720f04f) {
    var_d0638f89 = 0;
  }

  return var_d0638f89;
}

function function_f2359063(str_area) {
  switch (str_area) {
    case # "atrium":
      level.var_f83c3b53.locations[# "atrium"].var_a4ec1473 = [];
      break;
    case # "lobby_and_checkpoint":
      level.var_f83c3b53.locations[# "lobby"].var_a4ec1473 = [];
      level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473 = [];
      break;
    case # "west_hall":
      level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473 = [];
      break;
  }
}

function function_c257b422(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_110f5a406d2a4c8e"];
  var_6c6006 = a_ents[# "hash_6321012cb8c6dd17"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  civ_male waittill(#"hash_6f629dc582906c2e");

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09205_rmc3_spartakkickedyo_89");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09205_rmc2_giveitarestwhat_de");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09205_rmc3_bettingonthewro_d9");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09205_rmc2_oksuregavrilovi_22");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09205_rmc3_ohyesthoseweret_16");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09205_rmc2_yeahweneedtopus_48");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_382a2785(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "civ_male"];
  var_6c6006 = a_ents[# "hash_6e83c9503d67b052"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  civ_male thread function_3aa52402();
  var_6c6006 thread function_3aa52402();

  if(!isDefined(level.var_a88fc2c9)) {
    trigger_struct = struct::get("scene_kgb_ambient_mailroom_triggerstruct", "targetname");
    level.var_a88fc2c9 = spawn("trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);
  }

  level.var_a88fc2c9 waittill(#"trigger");

  if(isDefined(level.var_a88fc2c9)) {
    level.var_a88fc2c9 delete();
  }

  while(!function_7042f8ce("scene_kgb_ambient_pc_typing_duo_a", "mailroom")) {
    wait 1;
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_pc_typing_duo_a")) {
      arrayinsert(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_pc_typing_duo_a", 0);
    }

    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_isthismanbritis_8b");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_britishfromwhat_9c");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_thatsanimportan_37");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_okwherewerewe_11");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_andwiththatiwou_8f");
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_holdonisntparty_e1");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_imnotsurethatan_83");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_fineletsjustgow_e5");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_the2ndofmaysir_49");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_ofcoursethe2ndo_9e");
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_incidentsir_04");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_doyoureallyneed_d9");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_nosir_85");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09210_rmc3_imsorrythiswhol_0f");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09210_rmc1_understoodsir_ef");
    arrayremovevalue(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_pc_typing_duo_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_pc_typing_duo_a", "mailroom")) {
      wait 1;
    }
  }
}

function function_8fc8f7c6(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  civ_male endon(#"death", #"delete");
  var_4a608bb7 = ["vox_cp_rkgb_09215_rms4_whistles_c4", "vox_cp_rkgb_09215_rms4_hmmmm_2a", "vox_cp_rkgb_09215_rms4_clearsthroat_7d", "vox_cp_rkgb_09215_rms4_snickerhellomrs_aa", "vox_cp_rkgb_09215_rms4_riacanada_48", "vox_cp_rkgb_09215_rms4_somethingspecia_bb", "vox_cp_rkgb_09245_rms4_whistling_2a", "vox_cp_rkgb_09245_rms4_letsseekurganob_e3", "vox_cp_rkgb_09245_rms4_mmmhmm_b7", "vox_cp_rkgb_09245_rms4_konpedalniiinte_0e", "vox_cp_rkgb_09245_rms4_oisakharovsakha_5a", "vox_cp_rkgb_09245_rms4_sigh_fc", "vox_cp_rkgb_09245_rms4_yes_e9", "vox_cp_rkgb_09245_rms4_clearsthroat_7d"];
  level thread function_8c1733b2();
  function_d47c1165();

  while(true) {
    civ_male dialogue::queue(array::random(var_4a608bb7));
    wait randomfloatrange(10, 20);
  }
}

function function_d47c1165() {
  level endon(#"kgb_aslt_elev_down_completed");
  level endon(#"flag_player_swap");
  level.player endon(#"death");
  door = getent("manager_office_door", "targetname");
  door doors::waittill_door_opened();
}

function function_8c1733b2() {
  level endon(#"flag_player_swap");
  level endon(#"kgb_aslt_elev_down_completed");
  level.player endon(#"death");
  door = getent("manager_office_door", "targetname");

  while(true) {
    level flag::wait_till_any(["flag_manager_office_door", "kgb_ins_rv_completed"]);

    if(door doors::is_open()) {
      door doors::close();
    } else if(level flag::get("kgb_ins_rv_completed")) {
      return;
    }

    wait 10;
    level flag::clear("flag_manager_office_door");
  }
}

function function_3e91aa3d(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_ab67015 = a_ents[# "hash_25c349eb26f191d7"];
  var_e0ed1c83 = a_ents[# "hash_25c34aeb26f1938a"];
  var_ab67015 endon(#"death", #"delete");
  var_e0ed1c83 endon(#"death", #"delete");
  var_ab67015 waittill(#"hash_6f629dc582906c2e");

  while(true) {
    var_ab67015 dialogue::queue("vox_cp_rkgb_09230_rms4_heyoleghaveyous_30");
    wait randomfloatrange(0.5, 1.5);
    var_e0ed1c83 dialogue::queue("vox_cp_rkgb_09230_rms1_hejustwentthrou_1b");
    wait randomfloatrange(0.5, 1.5);
    var_ab67015 dialogue::queue("vox_cp_rkgb_09230_rms4_colonelkravchen_d0");
    wait randomfloatrange(0.5, 1.5);
    var_e0ed1c83 dialogue::queue("vox_cp_rkgb_09230_rms1_wheniseehimilll_19");
    wait randomfloatrange(0.5, 1.5);
    var_ab67015 dialogue::queue("vox_cp_rkgb_09230_rms4_youbetcantwaitt_d3");
    wait randomfloatrange(0.5, 1.5);
    var_e0ed1c83 dialogue::queue("vox_cp_rkgb_09230_rms1_thatluckydevilh_45");
    var_ab67015 dialogue::queue("vox_cp_rkgb_09230_rms4_laughyeahsometh_db");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_4cc65f99(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_ce201c54 = a_ents[# "hash_1e4175ab2617aa0e"];
  var_42a4ecb2 = a_ents[# "hash_19d610982dec579b"];
  var_306b483f = a_ents[# "hash_19d611982dec594e"];
  var_ce201c54 endon(#"death", #"delete");
  var_42a4ecb2 endon(#"death", #"delete");
  var_306b483f endon(#"death", #"delete");
  level waittill(#"hash_55df6c0a103a9ce2");
  var_ce201c54 dialogue::queue("vox_cp_rkgb_09235_rms1_didyouhearabout_dc");
  wait 1;
  var_306b483f dialogue::queue("vox_cp_rkgb_09235_rms3_nowhathappened_61");
  wait 1;
  var_ce201c54 dialogue::queue("vox_cp_rkgb_09235_rms1_hesinsurgery_71");
  wait 1;
  var_306b483f dialogue::queue("vox_cp_rkgb_09235_rms3_whathisheart_97");
  wait 1;
  var_ce201c54 dialogue::queue("vox_cp_rkgb_09235_rms1_noheshavinghisc_16");
  wait 0.1;
  var_306b483f dialogue::queue("vox_cp_rkgb_09235_rms3_snicker_40");
  wait 0.1;
  var_42a4ecb2 dialogue::queue("vox_cp_rkgb_09235_rms2_snicker_40");
}

function function_9b3f6c1e(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_72c69989e63ce232"];
  civ_male = a_ents[# "civ_male"];

  if(isDefined(var_4f3a9c97._scene_object._o_scene._e_root.targetname) && issubstr(var_4f3a9c97._scene_object._o_scene._e_root.targetname, "lobby")) {
    script_struct = struct::get("scene_kgb_ambient_talking_duo_standing_mixed_a_lobby_triggerstruct");
  } else {
    script_struct = struct::get("scene_kgb_ambient_talking_duo_standing_mixed_a_atrium_triggerstruct");
  }

  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(issubstr(var_4f3a9c97._scene_object._o_scene._e_root.targetname, "atrium")) {
    location = "atrium";
  } else {
    location = "lobby";
  }

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_mixed_a", location)) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(var_4f3a9c97.trigger)) {
    var_4f3a9c97.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[location].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_a")) {
      arrayinsert(level.var_f83c3b53.locations[location].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_a", 0);
    }

    if(isDefined(var_4f3a9c97._scene_object._o_scene._e_root.targetname) && issubstr(var_4f3a9c97._scene_object._o_scene._e_root.targetname, "atrium")) {
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09240_rfc1_itshumblingtose_c5");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09240_rmc1_yesitsquitebrea_a6");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09240_rfc1_thearchitecture_01");
      civ_male dialogue::queue("vox_cp_rkgb_09240_rmc1_laughtheysayyou_fd");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09240_rfc1_sergeitheycanpr_24");
      civ_male dialogue::queue("vox_cp_rkgb_09240_rmc1_lightlaughyesso_a4");
    } else {
      civ_male dialogue::queue("vox_cp_rkgb_09320_rmc4_lastnightwefina_e9");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09320_rfc2_youwenttoolomou_af");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09320_rmc4_tellthemeveryth_41");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09320_rfc2_thestroganoffis_84");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09320_rmc4_haveyoueverbeen_a8");
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09320_rfc2_dontsayitiateth_77");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09320_rmc4_ohirinaiwasjust_53");
    }

    arrayremovevalue(level.var_f83c3b53.locations[location].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_mixed_a", location)) {
      wait 1;
    }
  }
}

function function_9feb02eb(a_ents, str_shot) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  chair = a_ents[# "chair"];
  civ_male endon(#"death", #"delete");
  civ_male thread function_3aa52402();

  while(!function_7042f8ce("scene_kgb_ambient_breakroom_smoking", "breakroom")) {
    wait 1;
  }

  waitframe(1);

  if(str_shot == "start_loop") {
    trigger = spawn("trigger_radius", civ_male.origin, 0, 128, 64);
  } else if(str_shot == "transition_to_table" || str_shot == "table_loop") {
    trigger = spawn("trigger_radius", chair.origin, 0, 128, 64);
  }

  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_smoking")) {
      arrayinsert(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_smoking", 0);
    }

    if(str_shot == "start_loop") {
      civ_male dialogue::queue("vox_cp_rkgb_09250_rmc2_comeonidonthave_e6");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09250_rmc2_loudsigh_d0");
    } else if(str_shot == "transition_to_table" || str_shot == "table_loop") {
      civ_male function_1e9f3294("vox_cp_rkgb_09250_rmc3_itellthecoffeem_78");
      wait randomfloatrange(0.5, 1.5);
      civ_male function_1e9f3294("vox_cp_rkgb_09250_rmc3_cheapchemicalim_27");
      wait randomfloatrange(0.5, 1.5);
      civ_male function_1e9f3294("vox_cp_rkgb_09250_rmc3_unacceptable_f5");
      wait randomfloatrange(0.5, 1.5);
      civ_male function_1e9f3294("vox_cp_rkgb_09250_rmc3_imputtinginacom_12");
    }

    arrayremovevalue(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_smoking");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_breakroom_smoking", "breakroom")) {
      wait 1;
    }
  }
}

function function_26300964(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "actor 2"];
  civ_male = a_ents[# "actor 1"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  var_4f3a9c97 thread function_3aa52402();
  civ_male thread function_3aa52402();

  while(!function_7042f8ce("scene_kgb_ambient_breakroom_counter_duo", "breakroom")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", var_4f3a9c97.origin, 0, level.var_9aa07a0, level.var_30b3395f);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(var_4f3a9c97.trigger)) {
    var_4f3a9c97.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_counter_duo")) {
      arrayinsert(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_counter_duo", 0);
    }

    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_icantbelievethe_76");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_idontmindititdo_80");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_withenoughsugar_0c");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_ialwaysthoughti_4f");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_whyisthat_44");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_imeanwhodoesntw_44");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_cannotsayihavee_c2");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_andprobablyalit_dc");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_dontyouworkinle_47");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_yes_5f");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09252_rmc2_thatcanbeexciti_ee");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09252_rfc1_isupposeso_a8");
    arrayremovevalue(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_counter_duo");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_breakroom_counter_duo", "breakroom")) {
      wait 1;
    }
  }
}

function function_a7b81626(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "actor 2"];
  civ_male = a_ents[# "actor 1"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  var_4f3a9c97 thread function_3aa52402();
  civ_male thread function_3aa52402();

  while(!function_7042f8ce("scene_kgb_ambient_breakroom_watercooler_duo", "breakroom")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", var_4f3a9c97.origin, 0, level.var_9aa07a0, level.var_30b3395f);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(var_4f3a9c97.trigger)) {
    var_4f3a9c97.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_watercooler_duo")) {
      arrayinsert(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_watercooler_duo", 0);
    }

    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_iamprettysurehe_f4");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09254_rfc2_whatgaveitaway_65");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_besidesthebagsu_63");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09254_rfc2_arentyouasnoop_70");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_iamjustlookingo_7f");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09254_rfc2_itisabusytimefo_0e");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_idontthinkhisas_87");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09254_rfc2_yeahthatguyispr_0d");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_thatdoesntsurpr_f6");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 function_1e9f3294("vox_cp_rkgb_09254_rfc2_icantbelievehes_29");
    wait randomfloatrange(0.5, 1.5);
    civ_male function_1e9f3294("vox_cp_rkgb_09254_rmc3_youmighthaveapo_6b");
    arrayremovevalue(level.var_f83c3b53.locations[# "breakroom"].var_a4ec1473, "scene_kgb_ambient_breakroom_watercooler_duo");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_breakroom_watercooler_duo", "breakroom")) {
      wait 1;
    }
  }
}

function function_6b4f4409(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_316f37d6bad3208e"];
  civ_male = a_ents[# "hash_65ce105def67e4a1"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(!isDefined(level.var_a88fc2c9)) {
    trigger_struct = struct::get("scene_kgb_ambient_mailroom_triggerstruct", "targetname");
    level.var_a88fc2c9 = spawn("trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);
  }

  level.var_a88fc2c9 waittill(#"trigger");

  if(isDefined(level.var_a88fc2c9)) {
    level.var_a88fc2c9 delete();
  }

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_a_mixed", "mailroom")) {
    wait 1;
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_a_mixed")) {
      arrayinsert(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_a_mixed", 0);
    }

    civ_male dialogue::queue("vox_cp_rkgb_09260_rmc1_comeonewaillpic_b3");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09260_rfc1_wouldntyouknowi_c4");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09260_rmc1_nikoyoutwoneedt_44");
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09260_rfc1_laughohyeswellg_27");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09260_rmc1_ewaimanintellig_71");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09260_rfc1_unrivaledpersis_4e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09260_rmc1_thenitson_18");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09260_rfc1_ifbyonyoumeanmy_4e");
    arrayremovevalue(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_a_mixed");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_a_mixed", "mailroom")) {
      wait 1;
    }
  }
}

function function_45eaefef(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_72c69989e63ce232"];
  civ_male = a_ents[# "civ_male"];
  var_6c6006 = a_ents[# "hash_6e83c9503d67b052"];
  script_struct = struct::get("scene_kgb_ambient_talking_trio_standing_mixed_a_triggerstruct");
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_mixed_a", "lobby")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(var_4f3a9c97.trigger)) {
    var_4f3a9c97.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_mixed_a")) {
      arrayinsert(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_mixed_a", 0);
    }

    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09265_rmc3_thecabshouldhav_d4");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09265_rmc2_iconfirmedthepi_78");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09265_rmc3_wecantkeepmrbog_6a");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09265_rfc1_ifwehadwalkedli_6b");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09265_rmc2_relaxfriendswhe_7c");
    arrayremovevalue(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_mixed_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_mixed_a", "lobby")) {
      wait 1;
    }
  }
}

function function_5c2bc4eb(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  var_6c6006 = a_ents[# "actor 2"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, level.var_9aa07a0, level.var_30b3395f);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09270_rms4_heyvasilydidthe_d4");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09270_rms1_nonotyetithinkh_59");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09270_rms4_kravchenkosound_f3");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09270_rms1_everyonesbeenon_95");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09270_rms4_thatwouldbesome_c7");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09270_rms1_hehasweputhimin_36");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_b31d08b0(a_ents) {
  waitframe(1);
  level endon(#"kgb_aslt_elev_down_completed");

  if(level flag::get("kgb_ins_tutorial_completed")) {
    return;
  }

  civ_male = a_ents[# "hash_318b8cfa118b1fa1"];
  var_6c6006 = a_ents[# "hash_318b8bfa118b1dee"];
  script_struct = struct::get("scene_kgb_ambient_atrium_talk_bench_triggerstruct");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body6") {
      civ_male setModel("c_t9_ger_civ_male_urban_body6");
    }

    waitframe(1);

    if(!civ_male isattached("c_t9_ger_civ_male_head02")) {
      civ_male detach(civ_male.head);
      civ_male attach("c_t9_ger_civ_male_head02");
    }
  }

  if(isDefined(var_6c6006)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body8") {
      var_6c6006 setModel("c_t9_ger_civ_male_urban_body8");
    }

    waitframe(1);

    if(!var_6c6006 isattached("c_t9_ger_civ_male_head03")) {
      var_6c6006 detach(var_6c6006.head);
      var_6c6006 attach("c_t9_ger_civ_male_head03");
    }
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09275_rmc4_haveyoueverbeen_42");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09275_rmc3_yeahonatripwith_11");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09275_rmc4_ahfundidyougett_d9");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09275_rmc3_weswamquiteabit_16");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09275_rmc4_ihearthepolesha_9a");
    var_6c6006 dialogue::queue("vox_cp_rkgb_09275_rmc3_laughthatsounds_5b");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09275_rmc3_haveyoubeenther_32");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09275_rmc4_yeponlyofficial_24");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09275_rmc3_pewexnottoodiff_13");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_792c3bbe(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");

  if(level flag::get("kgb_ins_tutorial_completed")) {
    return;
  }

  var_4f3a9c97 = a_ents[# "hash_39f8c33aac6f91c7"];
  civ_male = a_ents[# "hash_318b89fa118b1a88"];
  script_struct = struct::get("scene_kgb_ambient_atrium_talk_secretary_triggerstruct");
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(isDefined(var_4f3a9c97)) {
    if(isDefined(var_4f3a9c97.model) && var_4f3a9c97.model != "c_t9_cp_rus_civ_female_office_01_body_e") {
      var_4f3a9c97 setModel("c_t9_cp_rus_civ_female_office_01_body_e");
    }

    waitframe(1);

    if(!var_4f3a9c97 isattached("c_t9_ger_civ_female_head04")) {
      var_4f3a9c97 detach(var_4f3a9c97.head);
      var_4f3a9c97 attach("c_t9_ger_civ_female_head04");
    }
  }

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body1") {
      civ_male setModel("c_t9_ger_civ_male_urban_body1");
    }

    waitframe(1);

    if(!civ_male isattached("c_t9_ger_civ_male_head01")) {
      civ_male detach(civ_male.head);
      civ_male attach("c_t9_ger_civ_male_head01");
    }
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09280_rfc2_howmayihelpyou_83");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09280_rmc2_imheretopickupo_41");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09280_rfc2_andyournamesare_cd");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09280_rmc2_yurisuslovandre_dc");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09280_rfc2_letmeseeahyesyo_02");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09280_rmc2_yescomrade_66");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09280_rfc2_underordersfrom_a3");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09280_rmc2_thatscorrect_3f");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09280_rfc2_illputyourpaper_4d");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09280_rmc2_thankyoucomrade_a8");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_a44bd33e(a_ents, str_shot) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_318b89fa118b1a88"];
  var_6c6006 = a_ents[# "hash_318b8cfa118b1fa1"];
  var_f5b94aac = a_ents[# "hash_318b8bfa118b1dee"];
  var_4f3a9c97 = a_ents[# "hash_39f8c33aac6f91c7"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  var_f5b94aac endon(#"death", #"delete");
  var_4f3a9c97 endon(#"death", #"delete");

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body1") {
      civ_male setModel("c_t9_ger_civ_male_urban_body1");
    }

    waitframe(1);

    if(!civ_male isattached("c_t9_ger_civ_male_head01")) {
      civ_male detach(civ_male.head);
      civ_male attach("c_t9_ger_civ_male_head01");
    }
  }

  if(isDefined(var_6c6006)) {
    if(isDefined(var_6c6006.model) && var_6c6006.model != "c_t9_ger_civ_male_urban_body6") {
      var_6c6006 setModel("c_t9_ger_civ_male_urban_body6");
    }

    waitframe(1);

    if(!var_6c6006 isattached("c_t9_ger_civ_male_head02")) {
      var_6c6006 detach(var_6c6006.head);
      var_6c6006 attach("c_t9_ger_civ_male_head02");
    }
  }

  if(isDefined(var_f5b94aac)) {
    if(isDefined(var_f5b94aac.model) && var_f5b94aac.model != "c_t9_ger_civ_male_urban_body8") {
      var_f5b94aac setModel("c_t9_ger_civ_male_urban_body8");
    }

    waitframe(1);

    if(!var_f5b94aac isattached("c_t9_ger_civ_male_head03")) {
      var_f5b94aac detach(var_f5b94aac.head);
      var_f5b94aac attach("c_t9_ger_civ_male_head03");
    }
  }

  if(isDefined(var_4f3a9c97)) {
    if(isDefined(var_4f3a9c97.model) && var_4f3a9c97.model != "c_t9_cp_rus_civ_female_office_01_body_e") {
      var_4f3a9c97 setModel("c_t9_cp_rus_civ_female_office_01_body_e");
    }

    waitframe(1);

    if(!var_4f3a9c97 isattached("c_t9_ger_civ_female_head04")) {
      var_4f3a9c97 detach(var_4f3a9c97.head);
      var_4f3a9c97 attach("c_t9_ger_civ_female_head04");
    }
  }

  civ_male pushplayer(1);

  if(str_shot == "shot 2") {
    civ_male waittill(#"hash_6f629dc582906c2e");
  } else if(str_shot == "shot 3") {
    script_struct = struct::get("scene_kgb_ambient_atrium_talk_bench_triggerstruct");
    waitframe(1);
    trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius + 15, script_struct.height);
    civ_male.trigger = trigger;
    civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
    civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
    trigger waittill(#"trigger");

    if(isDefined(civ_male.trigger)) {
      civ_male.trigger delete();
    }
  } else {
    return;
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09285_rmc2_okweshouldbeabl_af");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09285_rmc4_greatdowehavean_a7");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09285_rmc2_henrykcukierdau_7c");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09285_rmc3_okperfectdestin_42");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09285_rmc2_yescomradelenin_e7");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09285_rmc3_doyouhavethegea_27");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09285_rmc4_whatdoyouthinki_f9");
    var_6c6006 dialogue::queue("vox_cp_rkgb_09285_rmc3_laughimsorryias_51");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_858c98d(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_2b3082be7a0d9955"];
  civ_male = a_ents[# "hash_338d1396aeba7252"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(!isDefined(level.var_a88fc2c9)) {
    trigger_struct = struct::get("scene_kgb_ambient_mailroom_triggerstruct", "targetname");
    level.var_a88fc2c9 = spawn("trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);
  }

  level.var_a88fc2c9 waittill(#"trigger");

  if(isDefined(level.var_a88fc2c9)) {
    level.var_a88fc2c9 delete();
  }

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_d_mixed", "mailroom")) {
    wait 1;
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_d_mixed")) {
      arrayinsert(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_d_mixed", 0);
    }

    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09290_rfc2_andyousaidyouha_8f");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09290_rmc1_withcomradeusti_89");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09290_rfc2_couldyourepeaty_9e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09290_rmc1_valentinutkin_9a");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09290_rfc2_department_53");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09290_rmc1_gdrbureau_8f");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09290_rfc2_andyourbusiness_8e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09290_rmc1_idrathernotsayr_16");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09290_rfc2_thingsareabitun_4e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09290_rmc1_thatsfine_ef");
    arrayremovevalue(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_d_mixed");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_d_mixed", "mailroom")) {
      wait 1;
    }
  }
}

function function_6bd39879(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_3b65ea69f89ba5d4"];
  civ_male = a_ents[# "hash_36441969acaf17cf"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body1") {
      civ_male setModel("c_t9_ger_civ_male_urban_body1");
    }
  }

  if(!isDefined(level.var_a88fc2c9)) {
    trigger_struct = struct::get("scene_kgb_ambient_mailroom_triggerstruct", "targetname");
    level.var_a88fc2c9 = spawn("trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);
  }

  level.var_a88fc2c9 waittill(#"trigger");

  if(isDefined(level.var_a88fc2c9)) {
    level.var_a88fc2c9 delete();
  }

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_c_mixed", "mailroom")) {
    wait 1;
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_c_mixed")) {
      arrayinsert(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_c_mixed", 0);
    }

    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09295_rfc1_comradesmirnova_f2");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09295_rmc3_yesthatstrueiwa_d3");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09295_rfc1_strictsecurityp_68");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09295_rmc3_yescomradeimawa_95");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09295_rfc1_doyouadmittorai_ff");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09295_rmc3_idocomrade_71");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09295_rfc1_andyoualsoadmit_38");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09295_rmc3_yesthatseemstob_82");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09295_rfc1_pleasereportwit_1e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09295_rmc3_areyouseriousid_6e");
    arrayremovevalue(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_talking_duo_desk_c_mixed");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_desk_c_mixed", "mailroom")) {
      wait 1;
    }
  }
}

function function_ae1c1004(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_7c83cf8c388f5def"];
  civ_male = a_ents[# "hash_5b5c01597811fdb4"];
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  if(isDefined(var_4f3a9c97)) {
    if(isDefined(var_4f3a9c97.model) && var_4f3a9c97.model != "c_t9_cp_rus_civ_female_office_03_body_b") {
      var_4f3a9c97 setModel("c_t9_cp_rus_civ_female_office_03_body_b");
    }
  }

  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, 96, level.var_30b3395f);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09300_rfc1_comradezakhaevi_ff");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09300_rmc1_tryholdingthepo_52");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09300_rfc1_okaysighareyous_d7");
    civ_male dialogue::queue("vox_cp_rkgb_09300_rmc1_laughohgoodluck_ee");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09300_rfc1_icandream_f2");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09300_rmc1_indeed_77");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_838eb65b(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_466e7d5eb78abd77"];
  var_6c6006 = a_ents[# "hash_466e7e5eb78abf2a"];
  script_struct = struct::get("scene_kgb_ambient_talking_duo_standing_a_triggerstruct");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_a", "lobby")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_a")) {
      arrayinsert(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_a", 0);
    }

    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_iwentelkhunting_c6");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09305_rmc4_thatright_0e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_hebuiltasmokeho_db");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09305_rmc4_imnotafanofhunt_43");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_igetitlookatitt_4c");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_ifishootoneelki_0f");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_didyouknowthata_8f");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09305_rmc4_evseiilearnsome_18");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09305_rmc1_haveyouevergrow_cf");
    arrayremovevalue(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_a", "lobby")) {
      wait 1;
    }
  }
}

function function_dedcb768(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "actor 2"];
  civ_male = a_ents[# "actor 1"];
  script_struct = struct::get("scene_kgb_ambient_talking_duo_standing_mixed_b_triggerstruct");
  var_4f3a9c97 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");

  while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_mixed_b", "atrium")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(var_4f3a9c97.trigger)) {
    var_4f3a9c97.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_b")) {
      arrayinsert(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_b", 0);
    }

    civ_male dialogue::queue("vox_cp_rkgb_09310_rmc2_itsfartoohotinh_12");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09310_rfc2_thatsbecausewej_42");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09310_rmc2_iheartheyhavead_dd");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09310_rfc2_shushstepanyouk_e9");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09310_rmc2_alliwantisaradi_31");
    wait randomfloatrange(0.5, 1.5);
    var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09310_rfc2_keepitdownstepa_77");
    arrayremovevalue(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_duo_standing_mixed_b");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_duo_standing_mixed_b", "atrium")) {
      wait 1;
    }
  }
}

function function_d99a120(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "actor 1"];
  var_4f3a9c97 endon(#"death", #"delete");

  if(!isDefined(level.var_a88fc2c9)) {
    trigger_struct = struct::get("scene_kgb_ambient_mailroom_triggerstruct", "targetname");
    level.var_a88fc2c9 = spawn("trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);
  }

  level.var_a88fc2c9 waittill(#"trigger");

  if(isDefined(level.var_a88fc2c9)) {
    level.var_a88fc2c9 delete();
  }

  while(!function_7042f8ce("scene_kgb_ambient_typing_female_b_loop", "mailroom")) {
    wait 1;
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_typing_female_b_loop")) {
      arrayinsert(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_typing_female_b_loop", 0);
    }

    switch (randomintrange(1, 4)) {
      case 1:
        var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09315_rfc1_canyouguyspleas_e0");
        break;
      case 2:
        var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09315_rfc1_loudsigh_d0");
        break;
      case 3:
        var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09315_rfc1_loudlyclearsthr_36");
        break;
    }

    arrayremovevalue(level.var_f83c3b53.locations[# "mailroom"].var_a4ec1473, "scene_kgb_ambient_typing_female_b_loop");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_typing_female_b_loop", "mailroom")) {
      wait 1;
    }
  }
}

function function_ac04ad89(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  var_6c6006 = a_ents[# "actor 2"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body7b") {
      civ_male setModel("c_t9_ger_civ_male_urban_body7b");
    }

    waitframe(1);

    if(!civ_male isattached("c_t9_ger_civ_male_head06")) {
      civ_male detach(civ_male.head);
      civ_male attach("c_t9_ger_civ_male_head06");
    }
  }

  if(isDefined(var_6c6006)) {
    if(isDefined(var_6c6006.model) && var_6c6006.model != "c_t9_ger_civ_male_urban_body3") {
      var_6c6006 setModel("c_t9_ger_civ_male_urban_body3");
    }

    waitframe(1);

    if(!var_6c6006 isattached("c_t9_ger_civ_male_head04")) {
      var_6c6006 detach(var_6c6006.head);
      var_6c6006 attach("c_t9_ger_civ_male_head04");
    }
  }

  civ_male pushplayer(1);
  var_6c6006 pushplayer(1);
}

function function_aebfcfbf(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  var_6c6006 = a_ents[# "actor 2"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  if(isDefined(civ_male)) {
    if(isDefined(civ_male.model) && civ_male.model != "c_t9_ger_civ_male_urban_body7b") {
      civ_male setModel("c_t9_ger_civ_male_urban_body7b");
    }

    waitframe(1);

    if(!civ_male isattached("c_t9_ger_civ_male_head06")) {
      civ_male detach(civ_male.head);
      civ_male attach("c_t9_ger_civ_male_head06");
    }
  }

  if(isDefined(var_6c6006)) {
    if(isDefined(var_6c6006.model) && var_6c6006.model != "c_t9_ger_civ_male_urban_body3") {
      var_6c6006 setModel("c_t9_ger_civ_male_urban_body3");
    }

    waitframe(1);

    if(!var_6c6006 isattached("c_t9_ger_civ_male_head04")) {
      var_6c6006 detach(var_6c6006.head);
      var_6c6006 attach("c_t9_ger_civ_male_head04");
    }
  }

  civ_male pushplayer(1);
  var_6c6006 pushplayer(1);

  while(true) {
    wait 0.5;
    civ_male dialogue::queue("vox_cp_rkgb_09325_rmc1_idontknowyourqu_5b");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09325_rmc3_areyousurewecan_ee");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
    civ_male dialogue::queue("vox_cp_rkgb_09325_rmc1_andthisisasfara_94");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09325_rmc1_evenifsecretary_26");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09325_rmc3_doeshecomehereo_7b");
    civ_male dialogue::queue("vox_cp_rkgb_09325_rmc1_laughnever_b0");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09325_rmc3_whythismorning_69");
  }
}

function function_acddd6ae(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  guard = a_ents[# "hash_51e2b425fc21decb"];
  civ_male = a_ents[# "hash_2d3d6c83fbf60ddb"];
  guard endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, level.var_9aa07a0, level.var_30b3395f * 2);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_youregoingtomex_0a");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09330_rmc1_newmexico_dd");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_sorryimusthavem_fc");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09330_rmc1_technicallyiwil_ed");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_willthatbeachal_d3");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09330_rmc1_crossingoverita_d4");
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_laughsnewyorkci_80");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_doyoumindifiask_51");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09330_rmc1_theyhaventevent_d1");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09330_rmc3_wellimenviousih_30");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09330_rmc1_iwillinmexicoci_cb");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_9aeb9e94(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_2b3d34c3eeb09572"];
  var_6c6006 = a_ents[# "hash_2b3d33c3eeb093bf"];
  var_f5b94aac = a_ents[# "hash_2b3d32c3eeb0920c"];
  script_struct = struct::get("scene_kgb_ambient_talking_trio_standing_armed_a_triggerstruct");

  if(isDefined(civ_male)) {
    civ_male endon(#"death", #"delete");
  }

  if(isDefined(var_6c6006)) {
    var_6c6006 endon(#"death", #"delete");
  }

  if(isDefined(var_f5b94aac)) {
    var_f5b94aac endon(#"death", #"delete");
  }

  while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_armed_a", "atrium")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);

  if(isDefined(civ_male)) {
    civ_male.trigger = trigger;
    civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
    civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  }

  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  if(isDefined(trigger)) {
    trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_a")) {
      arrayinsert(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_a", 0);
    }

    var_f5b94aac dialogue::queue("vox_cp_rkgb_09335_rms4_icantwaittomeet_5e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09335_rms2_howitsnotlikeyo_7e");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09335_rms4_nobutmaybewells_e3");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09335_rms2_iguessitiskindo_fb");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09335_rms3_itsdefinitelyha_be");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09335_rms2_younevergetanyt_0c");
    var_6c6006 dialogue::queue("vox_cp_rkgb_09335_rms3_thatsfair_ef");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09335_rms4_comeonyoudontwa_14");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09335_rms2_suremaybehellpr_d4");
    civ_male thread dialogue::queue("vox_cp_rkgb_09335_rms2_laugh_62");
    wait randomfloatrange(0.1, 0.5);
    var_6c6006 thread dialogue::queue("vox_cp_rkgb_09335_rms3_laugh_62");
    wait 0.1;
    var_f5b94aac thread dialogue::queue("vox_cp_rkgb_09335_rms4_laugh_62");
    arrayremovevalue(level.var_f83c3b53.locations[# "atrium"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_armed_a", "atrium")) {
      wait 1;
    }
  }
}

function function_28b6b100(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "civ_male"];
  var_6c6006 = a_ents[# "hash_6e83c9503d67b052"];
  script_struct = struct::get("scene_kgb_ambient_railing_duo_triggerstruct");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09345_rmc2_areyoukiddingih_d1");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09345_rmc3_ithinknowisthet_9e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09345_rmc2_waitarewetalkin_81");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09345_rmc3_imjustsayingtak_66");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09345_rmc2_wellmywifecerta_ed");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09345_rmc3_ithinkweregoing_0e");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_c2d37011(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  var_6c6006 = a_ents[# "actor 2"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  civ_male waittill(#"hash_6f629dc582906c2e");

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09350_rmc1_viktordidyouhea_16");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09350_rmc2_hearaboutititsm_f8");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09350_rmc1_wonderfulaftera_00");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09350_rmc2_imamanofmyword_93");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09350_rmc1_imgoingtogoturn_80");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09350_rmc2_notatall_ad");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09350_rmc1_canigetyoualast_e2");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09350_rmc2_ivealreadyeaten_6d");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09350_rmc1_alrightwellitwa_eb");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09350_rmc2_likewise_6b");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_18206d92(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "civ_male"];
  var_6c6006 = a_ents[# "hash_6e83c9503d67b052"];
  var_f5b94aac = a_ents[# "hash_6e83ca503d67b205"];
  script_struct = struct::get("scene_kgb_ambient_talking_trio_standing_a_triggerstruct");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  var_f5b94aac endon(#"death", #"delete");

  while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_a", "lobby")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_a")) {
      arrayinsert(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_a", 0);
    }

    civ_male dialogue::queue("vox_cp_rkgb_09355_rmc1_youmeantheonewh_cd");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09355_rmc3_youmeanmaid_24");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09355_rmc1_noimeanthebutle_50");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09355_rmc2_icanseeit_23");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09355_rmc3_thatsnotthemovi_dd");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09355_rmc2_notringinganybe_07");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09355_rmc1_soundshilarious_9a");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09355_rmc2_notreallymycupo_c5");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09355_rmc3_remindmenottoge_22");
    arrayremovevalue(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_a");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_a", "lobby")) {
      wait 1;
    }
  }
}

function function_cebe3d1b(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_4bc9d223eb723333"];
  var_6c6006 = a_ents[# "hash_4bc9d323eb7234e6"];
  var_f5b94aac = a_ents[# "hash_4bc9d423eb723699"];
  script_struct = struct::get("scene_kgb_ambient_talking_trio_standing_armed_b_triggerstruct");
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  var_f5b94aac endon(#"death", #"delete");

  while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_armed_b", "lobby")) {
    wait 1;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    if(!isinarray(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_b")) {
      arrayinsert(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_b", 0);
    }

    civ_male dialogue::queue("vox_cp_rkgb_09360_rms2_mountyamantau_b2");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09360_rms3_idontknowwhatha_20");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09360_rms4_buttherewasanin_f9");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09360_rms3_thatswhatiheard_8e");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09360_rms2_fascinatingidid_86");
    wait randomfloatrange(0.5, 1.5);
    var_f5b94aac dialogue::queue("vox_cp_rkgb_09360_rms4_wedontasfarasik_6f");
    wait randomfloatrange(0.5, 1.5);
    var_6c6006 dialogue::queue("vox_cp_rkgb_09360_rms3_dontmentionisai_95");
    arrayremovevalue(level.var_f83c3b53.locations[# "lobby"].var_a4ec1473, "scene_kgb_ambient_talking_trio_standing_armed_b");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);

    while(!function_7042f8ce("scene_kgb_ambient_talking_trio_standing_armed_b", "lobby")) {
      wait 1;
    }
  }
}

function function_65dea10(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  soldier = a_ents[# "guard01"];
  var_b4fc88b3 = a_ents[# "guard02"];
  civ_male = a_ents[# "guy01"];
  soldier endon(#"death", #"delete");
  var_b4fc88b3 endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", soldier.origin, 0, level.var_9aa07a0, level.var_30b3395f);
  soldier.trigger = trigger;
  soldier callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  soldier callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(soldier.trigger)) {
    soldier.trigger delete();
  }

  while(true) {
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_imsorryyoulljus_67");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_idrovehourstoge_2f");
    wait randomfloatrange(0.5, 1.5);
    var_b4fc88b3 dialogue::queue("vox_cp_rkgb_09365_rms4_thatsnotourprob_25");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_iknowitisntbuti_0a");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_citizenwecantju_79");
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_iwastoldtoshowu_a0");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_citizen_04");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_citizenitisnotu_8c");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_reallywhatwillh_c2");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_whatwillhappen_47");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_howwouldiknow_00");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_youshouldleaven_bb");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_noiwanttospeakt_1c");
    wait randomfloatrange(0.5, 1.5);
    soldier dialogue::queue("vox_cp_rkgb_09365_rms3_dontforceustodr_ab");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_thisisoutrageou_23");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09365_rmc1_iwastoldihadtod_f2");
    wait randomfloatrange(0.5, 1.5);
    var_b4fc88b3 dialogue::queue("vox_cp_rkgb_09365_rms4_noonenewwillbea_b3");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_dfbd6bbc(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  a_keys = getarraykeys(a_ents);

  if(array::contains(a_keys, "smoking_standing_a_guy_01")) {
    var_78beab00 = "smoking_standing_a_guy_01";
  } else if(array::contains(a_keys, "smoking_standing_b_guy01")) {
    var_78beab00 = "smoking_standing_b_guy01";
  } else if(array::contains(a_keys, "smoking_sitting_a_guy01")) {
    var_78beab00 = "smoking_sitting_a_guy01";
  } else if(array::contains(a_keys, "smoking_sitting_b_guy01")) {
    var_78beab00 = "smoking_sitting_b_guy01";
  }

  civ_male = a_ents[var_78beab00];
  civ_male endon(#"death", #"delete");
  civ_male thread function_3aa52402();
  var_abff3bef = level.var_b576483;

  if(math::cointoss()) {
    var_abff3bef = level.var_da958300;
  }

  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, 128, level.var_30b3395f);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male function_1e9f3294(array::random(var_abff3bef));
    wait randomfloatrange(10, 20);
  }
}

function function_265c4b2b(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  var_4f3a9c97 = a_ents[# "hash_439b879f5b00af06"];
  var_4f3a9c97 endon(#"death", #"delete");

  if(isDefined(var_4f3a9c97)) {
    if(isDefined(var_4f3a9c97.model) && var_4f3a9c97.model != "c_t9_cp_rus_civ_female_office_02_body_e") {
      var_4f3a9c97 setModel("c_t9_cp_rus_civ_female_office_02_body_e");
    }

    waitframe(1);

    if(!var_4f3a9c97 isattached("c_t9_ger_civ_female_head06")) {
      var_4f3a9c97 detach(var_4f3a9c97.head);
      var_4f3a9c97 attach("c_t9_ger_civ_female_head06");
    }
  }

  waitframe(1);
  trigger = spawn("trigger_radius", var_4f3a9c97.origin, 0, 128, 64);
  var_4f3a9c97.trigger = trigger;
  var_4f3a9c97 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_4f3a9c97 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);

  while(true) {
    trigger waittill(#"trigger");
    var_4f3a9c97 ai::look_at(level.player, 0, undefined, 10, 0, undefined, 1);
    wait 1;

    if(math::cointoss()) {
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09390_rfc2_goodmorning_d1");
    } else {
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09390_rfc2_hello_22");
    }

    wait randomfloatrange(30, 60);
  }
}

function function_8fcab530(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "actor 1"];
  civ_male endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, 128, level.var_30b3395f);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    switch (randomintrange(1, 5)) {
      case 1:
        civ_male dialogue::queue("vox_cp_rkgb_09395_rmc2_hums_0e");
        break;
      case 2:
        civ_male dialogue::queue("vox_cp_rkgb_09395_rmc2_hums_0e_1");
        break;
      case 3:
        civ_male dialogue::queue("vox_cp_rkgb_09395_rmc2_justdonttouchth_53");
        break;
      case 4:
        civ_male dialogue::queue("vox_cp_rkgb_09395_rmc2_theybringtheirk_d7");
        break;
    }

    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_a5bc671a(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "guy01"];
  var_6c6006 = a_ents[# "guy02"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");

  if(isDefined(self) && isDefined(self.targetname) && self.targetname == "data_murder_investigation") {
    if(isDefined(a_ents[# "guy03"]) && !isDefined(level.var_9ba3920f)) {
      level.var_9ba3920f = a_ents[# "guy03"];
      level.var_9ba3920f endon(#"death", #"delete");
    } else {
      return;
    }
  }

  waitframe(1);
  trigger = spawn("trigger_radius", civ_male.origin, 0, level.var_9aa07a0, level.var_30b3395f);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    if(isDefined(civ_male._scene_object._o_scene._e_root.targetname) && issubstr(civ_male._scene_object._o_scene._e_root.targetname, "camera")) {
      civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_howcouldthishav_a5");
      wait randomfloatrange(0.5, 1.5);
      var_6c6006 dialogue::queue("vox_cp_rkgb_09400_rms2_thismustberelat_96");
    } else if(isDefined(civ_male._scene_object._o_scene._e_root.targetname) && issubstr(civ_male._scene_object._o_scene._e_root.targetname, "records")) {
      if(math::cointoss()) {
        civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_whowouldhavekil_31");
      } else {
        var_6c6006 dialogue::queue("vox_cp_rkgb_09400_rms2_wehavenofootage_e0");
        wait randomfloatrange(0.5, 1.5);
        civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_watchyourback_c5");
      }
    } else if(isDefined(civ_male._scene_object._o_scene._e_root.targetname) && issubstr(civ_male._scene_object._o_scene._e_root.targetname, "server")) {
      if(math::cointoss()) {
        var_6c6006 dialogue::queue("vox_cp_rkgb_09400_rms2_whatisgoingonar_ae");
        wait randomfloatrange(0.5, 1.5);
        civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_loudsigh_d0");
      } else {
        civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_dudnikiwasjustt_8e");
        wait randomfloatrange(0.5, 1.5);
        var_6c6006 dialogue::queue("vox_cp_rkgb_09400_rms2_haskravchenkohe_30");
      }
    } else if(isDefined(civ_male._scene_object._o_scene._e_root.targetname) && issubstr(civ_male._scene_object._o_scene._e_root.targetname, "data")) {
      var_6c6006 dialogue::queue("vox_cp_rkgb_09400_rms2_glebovhadnoenem_dd");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09400_rms1_hopefullyhedied_52");
      wait randomfloatrange(0.5, 1.5);

      if(isDefined(level.var_9ba3920f)) {
        level.var_9ba3920f dialogue::queue("vox_cp_rkgb_09400_rms4_doyoutwoneedany_d6");
      }
    }

    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_75c06a2f(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  civ_male = a_ents[# "hash_564e9bf9aa88538f"];
  var_6c6006 = a_ents[# "hash_564e9cf9aa885542"];
  civ_male endon(#"death", #"delete");
  var_6c6006 endon(#"death", #"delete");
  civ_male waittill(#"hash_6f629dc582906c2e");
  civ_male dialogue::queue("vox_cp_rkgb_09405_rmc4_fyodordoyouhave_f3");
  wait randomfloatrange(0.5, 1.5);
  var_6c6006 dialogue::queue("vox_cp_rkgb_09405_rmc3_ofcoursenotitwa_8f");
  wait randomfloatrange(0.5, 1.5);
  civ_male dialogue::queue("vox_cp_rkgb_09405_rmc4_annoyedgroan_76");
}

function function_789de3e1(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  guard = a_ents[# "hash_371d509595ac85a4"];
  var_cd0ea04d = a_ents[# "hash_371d539595ac8abd"];
  civ_male = a_ents[# "hash_5e382a0b608737da"];

  if(isDefined(guard._scene_object._o_scene._e_root.targetname) && issubstr(guard._scene_object._o_scene._e_root.targetname, "lobby")) {
    script_struct = struct::get("scene_kgb_ambient_harass_ask_questions_lobby_triggerstruct");
  } else {
    script_struct = struct::get("scene_kgb_ambient_harass_ask_questions_atrium_triggerstruct");
  }

  guard endon(#"death", #"delete");
  var_cd0ea04d endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  guard.trigger = trigger;
  guard callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  guard callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(guard.trigger)) {
    guard.trigger delete();
  }

  while(true) {
    if(isDefined(guard._scene_object._o_scene._e_root.targetname) && issubstr(guard._scene_object._o_scene._e_root.targetname, "lobby")) {
      civ_male dialogue::queue("vox_cp_rkgb_09410_rmc3_thisisridiculou_af");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09410_rms1_wecanthaveanyon_e3");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09410_rmc3_idontknowanythi_4b");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09410_rms4_yesalottobeconc_b8");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09410_rmc3_imsorryillletyo_8d");
    } else {
      guard dialogue::queue("vox_cp_rkgb_09415_rms2_itsgoingtotakea_c5");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09415_rmc1_whatisgoingonov_61");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09415_rms2_justletusaskthe_be");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09415_rmc1_iwishiknewwhatw_65");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09415_rms3_didyouhaveaprio_ca");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09415_rmc1_huh_64");
    }

    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_8dcdb8c9(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  guard = a_ents[# "hash_2dbc076c79842779"];
  var_cd0ea04d = a_ents[# "hash_2dbc046c79842260"];
  civ_male = a_ents[# "hash_2b50d92ebdd550d7"];
  var_4f3a9c97 = a_ents[# "hash_6dfdafd9fe6b62cd"];

  if(isDefined(guard._scene_object._o_scene._e_root.targetname) && issubstr(guard._scene_object._o_scene._e_root.targetname, "lobby")) {
    script_struct = struct::get("scene_kgb_ambient_harass_check_papers_lobby_triggerstruct");
  } else {
    script_struct = struct::get("scene_kgb_ambient_harass_check_papers_atrium_triggerstruct");
  }

  guard endon(#"death", #"delete");
  var_cd0ea04d endon(#"death", #"delete");
  civ_male endon(#"death", #"delete");
  var_4f3a9c97 endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  guard.trigger = trigger;
  guard callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  guard callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(guard.trigger)) {
    guard.trigger delete();
  }

  while(true) {
    if(isDefined(guard._scene_object._o_scene._e_root.targetname) && issubstr(guard._scene_object._o_scene._e_root.targetname, "lobby")) {
      civ_male dialogue::queue("vox_cp_rkgb_09420_rmc1_ourmeetingwassc_fb");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09420_rms2_nooneisgoingino_aa");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09420_rfc1_itsjustthatweve_ee");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09420_rms3_justfollowourin_4b");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09420_rms2_yourbirthdatema_a8");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09420_rfc1_may22nd1954_ca");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09420_rms2_thankyouandyour_47");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09420_rmc1_areyougoingtote_57");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09420_rms3_andwhowasityour_67");
    } else {
      civ_male dialogue::queue("vox_cp_rkgb_09420_rmc2_wellthisisnew_1f");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09420_rfc2_isthisnecessary_c0");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09420_rms1_weareexperienci_bb");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09420_rms4_itsforyoursafet_14");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09420_rmc2_mybusinessiwork_c2");
      wait randomfloatrange(0.5, 1.5);
      var_4f3a9c97 dialogue::queue("vox_cp_rkgb_09420_rfc2_sorryhejusthate_1e");
      wait randomfloatrange(0.5, 1.5);
      civ_male dialogue::queue("vox_cp_rkgb_09420_rmc2_itsnotlikewehav_98");
      wait randomfloatrange(0.5, 1.5);
      var_cd0ea04d dialogue::queue("vox_cp_rkgb_09420_rms4_justasyouseethe_01");
      wait randomfloatrange(0.5, 1.5);
      guard dialogue::queue("vox_cp_rkgb_09420_rms1_yoursupervisorw_8f");
    }

    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_c2e8e3e2(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  guard = a_ents[# "hash_2872d42d037e3ca9"];
  var_cd0ea04d = a_ents[# "hash_2872d12d037e3790"];
  civ_male = a_ents[# "hash_75cd1b9fa8049707"];
  script_struct = struct::get("scene_kgb_ambient_harass_pat_down_triggerstruct");
  civ_male endon(#"death", #"delete");
  guard endon(#"death", #"delete");
  var_cd0ea04d endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09425_rmc1_hesimplyaskedfo_6d");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09425_rms3_areyousure_b3");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09425_rmc1_amisure_bf");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09425_rms3_whatareyoudoing_d9");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09425_rmc1_nothingwhat_f8");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09425_rms3_whatdoyouthinka_1a");
    wait randomfloatrange(0.5, 1.5);
    var_cd0ea04d dialogue::queue("vox_cp_rkgb_09425_rms4_ithinkhemaybely_33");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09425_rms3_tellusmoreabout_41");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_b8bc6f25(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  guard = a_ents[# "hash_7bc3bee53096bac5"];
  civ_male = a_ents[# "hash_76167e0ae2eaea8b"];
  script_struct = struct::get("scene_kgb_ambient_harass_wall_frisk_triggerstruct");
  civ_male endon(#"death", #"delete");
  guard endon(#"death", #"delete");
  waitframe(1);
  trigger = spawn("trigger_radius", script_struct.origin, 0, script_struct.radius, script_struct.height);
  civ_male.trigger = trigger;
  civ_male callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  civ_male callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  trigger waittill(#"trigger");

  if(isDefined(civ_male.trigger)) {
    civ_male.trigger delete();
  }

  while(true) {
    civ_male dialogue::queue("vox_cp_rkgb_09430_rmc3_iwaswaitingtome_d4");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_andshenevercame_e5");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09430_rmc3_noimeanyesitsth_e8");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09430_rmc3_ijustwanttogoho_f9");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_turnaroundpleas_1a");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_handsagainstthe_47");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_alright_f9");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_onceagainwhatis_42");
    wait randomfloatrange(0.5, 1.5);
    civ_male dialogue::queue("vox_cp_rkgb_09430_rmc3_icantjustgoonre_b9");
    wait randomfloatrange(0.5, 1.5);
    guard dialogue::queue("vox_cp_rkgb_09430_rms2_ithinkyoucanlet_af");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_645c6620(a_ents) {
  level endon(#"kgb_aslt_elev_down_completed");
  level endon(#"hash_184a766cab2b78a7");
  var_7198a076 = a_ents[# "hash_713540a10ff22151"];
  kravchenko = a_ents[# "kravchenko"];
  var_7198a076 endon(#"death", #"delete");
  kravchenko endon(#"death", #"delete");
  waitframe(1);
  thread function_fe077ca7(var_7198a076, kravchenko);
  var_7c29e364 = spawn("trigger_radius", var_7198a076.origin, 0, 256, 64);
  var_7198a076.trigger = var_7c29e364;
  var_7198a076 callback::function_d8abfc3d(#"on_ai_killed", &function_dc6db93b);
  var_7198a076 callback::function_d8abfc3d(#"on_entity_deleted", &function_dc6db93b);
  var_7c29e364 waittill(#"trigger");

  if(isDefined(var_7198a076.trigger)) {
    var_7198a076.trigger delete();
  }

  while(true) {
    var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_andyoubelievehi_29");
    wait randomfloatrange(0.5, 1.5);
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_idontknowwhatto_14");
    wait randomfloatrange(0.5, 1.5);
    var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_charkovandbelik_2c");
    wait randomfloatrange(0.5, 1.5);
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_theydo_bb");
    wait randomfloatrange(0.5, 1.5);
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_imstilltryingto_d5");
    wait randomfloatrange(0.5, 1.5);
    var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_findbelikoviwan_54");
    wait randomfloatrange(0.5, 1.5);
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_accordingtochar_40");
    wait randomfloatrange(level.var_4ce95d22, level.var_bb9797b9);
  }
}

function function_fe077ca7(var_7198a076, kravchenko) {
  level.player endon(#"death");
  var_7198a076 endon(#"death", #"delete");
  level endon(#"kgb_aslt_elev_down_completed");
  var_633aa908 = spawn("trigger_radius", var_7198a076.origin, 0, 96, 64);
  var_7198a076.var_c84284f1 = var_633aa908;
  var_7198a076 callback::function_d8abfc3d(#"on_ai_killed", &function_ec8e9354);
  var_7198a076 callback::function_d8abfc3d(#"on_entity_deleted", &function_ec8e9354);
  var_633aa908 waittill(#"trigger");

  if(isDefined(var_7198a076.var_c84284f1)) {
    var_7198a076.var_c84284f1 delete();
  }

  level notify(#"hash_184a766cab2b78a7");
  var_7198a076 ai::look_at(level.player, 0, undefined, 600, 0, undefined, 1);
  kravchenko ai::look_at(level.player, 0, undefined, 600, 0, undefined, 1);
  var_7198a076 thread dialogue::function_47b06180();
  kravchenko thread dialogue::function_47b06180();
  level notify(#"hash_184a766cab2b78a7");

  if(math::cointoss()) {
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_waitamoment_f4", undefined, 1);
  } else {
    var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_holdon_b2", undefined, 1);
  }

  wait randomfloatrange(1.5, 2.5);

  if(math::cointoss()) {
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_doyouseesomethi_86");
  } else {
    var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_canihelpyou_00");
  }

  wait randomfloatrange(1.5, 2.5);

  if(math::cointoss()) {
    kravchenko dialogue::queue("vox_cp_rkgb_09430_krav_iwouldgetmoving_7a");
    return;
  }

  var_7198a076 dialogue::queue("vox_cp_rkgb_09430_zakh_perhapsyoushoul_24");
}

function function_dc6db93b() {
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
}

function function_ec8e9354() {
  if(isDefined(self.var_c84284f1)) {
    self.var_c84284f1 delete();
  }
}

function function_41538e53() {
  level endon(#"kgb_fail_mission");

  while(!isDefined(level.player)) {
    wait 1;
  }

  level.player endon(#"death");

  if(!level flag::get("kgb_ins_rv_completed")) {
    level flag::wait_till("kgb_ins_rv_completed");
  }

  var_8b2c48f = getent("mailroom_playercollision", "targetname");

  if(isDefined(var_8b2c48f)) {
    var_8b2c48f delete();
  }

  namespace_94c47ce5::function_aa622b93();

  if(!level flag::get("kgb_aslt_elev_down_completed")) {
    level flag::wait_till("kgb_aslt_elev_down_completed");
  }

  a_volumes = getEntArray("walk_and_delete_ai_volumes", "script_noteworthy");

  foreach(volume in a_volumes) {
    if(isDefined(volume)) {
      volume delete();
    }
  }

  var_d2455957 = getent("eavesdropping_prison_vol", "targetname");

  if(isDefined(var_d2455957)) {
    var_d2455957 delete();
  }

  phone = getent("lobby_phone", "targetname");

  if(isDefined(phone)) {
    phone delete();
  }

  phone = getent("mailroom_phone", "targetname");

  if(isDefined(phone)) {
    phone delete();
  }

  if(isDefined(level.mailroom_phone)) {
    level.mailroom_phone delete();
  }

  if(isDefined(level.lobby_phone)) {
    level.lobby_phone delete();
  }
}

function function_21b05565() {
  level.player endon(#"death");
  level flag::wait_till("flag_cleanup_kgb_hq");
  wait 1;

  if(isDefined(level.var_fdb0359e.section[# "lobby_and_checkpoint"]) && isDefined(level.var_fdb0359e.section[# "lobby_and_checkpoint"].var_4c49141c)) {
    foreach(scene_struct in level.var_fdb0359e.section[# "lobby_and_checkpoint"].var_4c49141c) {
      if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
        scene::stop(scene_struct.targetname, 1);
      }
    }
  }

  if(isDefined(level.var_fdb0359e.section[# "atrium"]) && isDefined(level.var_fdb0359e.section[# "atrium"].var_4c49141c)) {
    foreach(scene_struct in level.var_fdb0359e.section[# "atrium"].var_4c49141c) {
      if(isDefined(scene_struct.script_parameters) && issubstr(scene_struct.script_parameters, "mailroom")) {
        scene::stop(scene_struct.targetname, 1);
      }
    }
  }
}

function function_fb149e45() {
  level endon(#"kgb_fail_mission");

  while(!isDefined(level.player)) {
    wait 1;
  }

  level.player endon(#"death");

  if(!level flag::get("harass_scenes_collision_toggler_running")) {
    level flag::set("harass_scenes_collision_toggler_running");
  } else {
    return;
  }

  harass_scenes_collision = getent("harass_scenes_collision", "targetname");

  if(level flag::get("kgb_aslt_elev_down_completed")) {
    if(isDefined(harass_scenes_collision)) {
      harass_scenes_collision delete();
    }

    return;
  }

  harass_scenes_collision notsolid();
  harass_scenes_collision connectpaths();
  level flag::wait_till("kgb_ins_rv_completed");
  harass_scenes_collision solid();
  harass_scenes_collision disconnectpaths();
  level flag::wait_till("kgb_aslt_elev_down_completed");

  if(isDefined(harass_scenes_collision)) {
    harass_scenes_collision delete();
  }

  level flag::clear("harass_scenes_collision_toggler_running");
}

function function_a214429c() {
  slides = getEntArray("kgb_conference_room_slides", "targetname");
  level flag::wait_till("flag_cleanup_kgb_hq");

  foreach(slide in slides) {
    if(isDefined(slide)) {
      slide delete();
    }
  }
}

function function_2493220a(off) {
  if(isDefined(off)) {
    self notify(#"stop_sound");
    return;
  }

  self thread namespace_353d803e::function_82b14d0c();
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

function function_ff442a79() {
  level.player endon(#"death");

  if(level flag::get("kgb_ins_rv_completed")) {
    return;
  }

  level flag::wait_till("flag_player_swap");
  vol = getent("eavesdropping_prison_vol", "targetname");

  while(true) {
    if(isDefined(vol) && level.player istouching(vol) && getdvarint(#"hash_7fb1be9520b9a725", 100) == 100) {
      setDvar(#"hash_7fb1be9520b9a725", 700);
      setDvar(#"hash_6b57212fd4fcdd3a", 701);
    } else if(level flag::get("kgb_ins_rv_completed")) {
      break;
    }

    wait 1;
  }

  setDvar(#"hash_7fb1be9520b9a725", 100);
  setDvar(#"hash_6b57212fd4fcdd3a", 350);
  setDvar(#"hash_4ad75035d6026ea2", 0.819);

  if(isDefined(vol)) {
    vol delete();
  }
}

function function_ae16e341(a_ents) {
  if(isDefined(self) && isDefined(self.script_string) && isDefined(getent(self.script_string, "targetname"))) {
    phone = getent(self.script_string, "targetname");

    if(issubstr(self.script_string, "lobby")) {
      level.var_835bee53 = phone.origin;
    } else {
      level.var_15e0b1fd = phone.origin;
    }

    if(isDefined(phone)) {
      phone delete();
    }

    return;
  }

  if(getsubstr(self.targetname, 31) == "a" && !isDefined(level.mailroom_phone) && isDefined(level.var_15e0b1fd)) {
    level.mailroom_phone = spawn("script_model", level.var_15e0b1fd);
    level.mailroom_phone setModel("p9_usa_mil_phone_01");
    level.mailroom_phone.angles = (0, 105.552, 0);
    return;
  } else if(getsubstr(self.targetname, 31) == "a" && isDefined(level.mailroom_phone)) {
    if(isDefined(level.mailroom_phone)) {
      level.mailroom_phone delete();
    }

    return;
  }

  if(getsubstr(self.targetname, 31) == "b" && !isDefined(level.lobby_phone)) {
    level.lobby_phone = spawn("script_model", level.var_835bee53);
    level.lobby_phone setModel("p9_usa_mil_phone_01");
    level.lobby_phone.angles = (0, 148.645, 0);
    return;
  }

  if(getsubstr(self.targetname, 31) == "b" && isDefined(level.lobby_phone)) {
    if(isDefined(level.lobby_phone)) {
      level.lobby_phone delete();
    }

    return;
  }
}

function function_3aa52402() {
  self endon(#"death");
  flag = "flag_mouth_covered";

  while(true) {
    self waittill(#"mouth_covered");
    self flag::set(flag);
    self waittill(#"hash_12f91f7a1ff7d984");
    self flag::clear(flag);
  }
}

function function_1e9f3294(str) {
  self endon(#"death");
  self flag::wait_till_clear("flag_mouth_covered");
  self dialogue::queue(str);
}

function function_8fb7b0bb(a_ents) {}