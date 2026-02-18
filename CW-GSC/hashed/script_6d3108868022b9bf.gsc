/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6d3108868022b9bf.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_1b9f100b85b7e21d;
#using script_35ae72be7b4fec10;
#using script_4052585f7ae90f3a;
#using script_5513c8efed5ff300;
#using script_5c15c1ec5f38f19c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\statemachine_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\collectibles;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\load;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\ui\interactive_map;
#using scripts\cp_common\util;
#namespace namespace_fa335fda;

function function_12624bb8(var_9e3df858, var_7b80750a) {
  player = self;

  function_5ac4dc99("<dev string:x38>", 0);
  function_cd140ee9("<dev string:x38>", &function_31c143a8);
  util::init_dvar("<dev string:x4c>", 0, &function_97c5cb9a);
  level.var_5bd2109 = getdvarint(#"hash_1fe50f2a47161399", 0) > 0;
  level.var_99e01934 = getdvarint(#"hash_4ea6d647c6120234", 0) > 0;

  collectibles::add_callback(#"hash_2bfb881b2d0ed7f7", &function_b3f7df56);
  var_98901c49 = statemachine::create("eboard_state_machine", player, "eboard_state_change");
  function_fa4f5603(var_98901c49, var_9e3df858);
  var_98901c49 statemachine::add_state("board_default_state", &function_6d01a6c8, undefined, &function_964c7ad2, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_overview", &function_bdf71927, &function_f77a1784, &function_559b452b, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_mission_detail", &function_5b9bb291, &function_c7ffe282, &function_96e31558, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_evidence_review", &function_e2e9758c, &function_109f3f2, &function_3db40935, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_review_suspects", &function_de709256, &function_35a396ee, &function_3740b568, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_decrypt_floppy", &function_e6734894, &function_d4497273, &function_dd090dfe, &function_361f6bd8);
  var_98901c49 statemachine::add_state("board_evidence_callback", &function_c4deb1a2, &function_b00f82b, &function_340179ff, &function_361f6bd8);
  var_98901c49 statemachine::add_interrupt_connection("board_default_state", "board_overview", "eboard_enter_overview");
  var_98901c49 statemachine::add_interrupt_connection("board_overview", "board_default_state", "evidence_board_closed");
  var_98901c49 statemachine::add_interrupt_connection("board_overview", "board_mission_detail", "evidence_board_mission_selected");
  var_98901c49 statemachine::add_interrupt_connection("board_mission_detail", "board_overview", "eboard_exit_current_menu");
  var_98901c49 statemachine::add_interrupt_connection("board_mission_detail", "board_evidence_review", "evidence_board_review_selected");
  var_98901c49 statemachine::add_interrupt_connection("board_evidence_review", "board_mission_detail", "eboard_exit_current_menu");
  var_98901c49 statemachine::add_interrupt_connection("board_mission_detail", "board_review_suspects", "evidence_board_review_suspects_selected");
  var_98901c49 statemachine::add_interrupt_connection("board_review_suspects", "board_mission_detail", "eboard_exit_current_menu");
  var_98901c49 statemachine::add_interrupt_connection("board_mission_detail", "board_decrypt_floppy", "evidence_board_decrypt_floppy_selected");
  var_98901c49 statemachine::add_interrupt_connection("board_decrypt_floppy", "board_mission_detail", "eboard_exit_current_menu");
  var_98901c49 statemachine::add_interrupt_connection("board_evidence_review", "board_evidence_callback", "evidence_board_evidence_callback_execute");
  var_98901c49 statemachine::add_interrupt_connection("board_evidence_callback", "board_evidence_review", "evidence_board_evidence_callback_finished");
  var_98901c49 statemachine::add_interrupt_connection("board_decrypt_floppy", "board_evidence_callback", "evidence_board_evidence_callback_execute");
  var_98901c49 statemachine::add_interrupt_connection("board_evidence_callback", "board_decrypt_floppy", "evidence_board_evidence_floppy_callback_finished");
  player thread function_e0cfa93c(var_7b80750a);
}

function private function_31c143a8(params) {
  assert(params.name == "<dev string:x38>");
  level.var_47df5f11 = params.value > 0;
}

function private function_97c5cb9a(params) {
  assert(params.name == "<dev string:x4c>");

  if(params.value) {
    var_cf1f3586 = ["<dev string:x6a>", "<dev string:x79>", "<dev string:x8a>", "<dev string:x9d>", "<dev string:xaf>", "<dev string:xc2>", "<dev string:xd0>", "<dev string:xe3>", "<dev string:xf8>", "<dev string:x108>", "<dev string:x117>", "<dev string:x132>"];

    foreach(mission_name in var_cf1f3586) {
      if(is_true(savegame::function_2ee66e93(mission_name + "<dev string:x14b>"))) {
        savegame::set_player_data(mission_name + "<dev string:x14b>", 0);
      }
    }

    setDvar(#"hash_432a49c2505fa5fe", 0);
  }
}

function private function_fa4f5603(statemachine, var_9e3df858) {
  blackboard = {};

  blackboard.var_9e3df858 = var_9e3df858;

  var_e55cb845 = struct::get("darkening_plane_origin", "targetname");
  var_1bfff22b = spawn("script_model", var_e55cb845.origin);
  var_1bfff22b.angles = var_e55cb845.angles;
  var_1bfff22b setModel("p9_sr_evidence_board_darkening_multiply_01");
  var_1bfff22b hide();
  blackboard.var_1bfff22b = var_1bfff22b;
  var_b6e3d0a = getscriptbundle(#"evidenceboardlist");
  var_625dd793 = undefined;

  foreach(var_f2dfb976 in var_b6e3d0a.var_c8099c2) {
    if(var_f2dfb976.var_4c5c8430 == var_9e3df858) {
      foreach(mapentry in var_f2dfb976.var_bd48fa38) {
        if(!isDefined(var_625dd793)) {
          var_625dd793 = [];
        } else if(!isarray(var_625dd793)) {
          var_625dd793 = array(var_625dd793);
        }

        var_625dd793[var_625dd793.size] = mapentry.var_3a61b479;
      }

      break;
    }
  }

  assert(isDefined(var_625dd793), "<dev string:x15f>" + var_9e3df858);
  blackboard.var_3cb3ede5 = function_89f058b1(var_b6e3d0a.var_48be729c, var_625dd793);

  foreach(evidencedata in blackboard.var_3cb3ede5) {
    if(is_true(evidencedata.isSideMission)) {
      if(var_9e3df858 != "post_takedown" && evidencedata.var_dade7c7f.size > 0) {
        if(!isDefined(var_625dd793)) {
          var_625dd793 = [];
        } else if(!isarray(var_625dd793)) {
          var_625dd793 = array(var_625dd793);
        }

        if(!isinarray(var_625dd793, evidencedata.var_8ca1d4a)) {
          var_625dd793[var_625dd793.size] = evidencedata.var_8ca1d4a;
        }
      }
    } else if(savegame::function_1b212e67(evidencedata.var_8ca1d4a)) {
      if(evidencedata.var_8ca1d4a == "cp_nam_prisoner" || evidencedata.var_8ca1d4a == "cp_rus_duga" || evidencedata.var_8ca1d4a == "cp_rus_siege") {
        continue;
      }

      if(!isDefined(var_625dd793)) {
        var_625dd793 = [];
      } else if(!isarray(var_625dd793)) {
        var_625dd793 = array(var_625dd793);
      }

      if(!isinarray(var_625dd793, evidencedata.var_8ca1d4a)) {
        var_625dd793[var_625dd793.size] = evidencedata.var_8ca1d4a;
      }
    }

    if(blackboard.var_9e3df858 == "<dev string:x198>" && evidencedata.var_8ca1d4a == "<dev string:xe3>") {
      evidencedata.var_e4f432d9 = undefined;
    }
  }

  blackboard.mdl_bulb_left = getent("mdl_bulb_left", "script_noteworthy");
  blackboard.mdl_bulb_right = getent("mdl_bulb_right", "script_noteworthy");
  blackboard.var_3c3d8c0b = [];
  var_d771858a = function_f98394d8(var_625dd793, blackboard.var_3cb3ede5);

  foreach(e in var_d771858a) {
    if(e.classname == "trigger_multiple") {
      if(!isDefined(blackboard.var_3c3d8c0b)) {
        blackboard.var_3c3d8c0b = [];
      } else if(!isarray(blackboard.var_3c3d8c0b)) {
        blackboard.var_3c3d8c0b = array(blackboard.var_3c3d8c0b);
      }

      blackboard.var_3c3d8c0b[blackboard.var_3c3d8c0b.size] = e;
      continue;
    }

    e show();
  }

  function_1e294fd9(var_625dd793, blackboard.var_3cb3ede5);
  function_580e9a17(var_625dd793, blackboard.var_3cb3ede5);
  blackboard.var_625dd793 = var_625dd793;
  var_a5519791 = struct::get("evidence_board_player_pos", "targetname");
  blackboard.var_f9e7327d = util::spawn_model("tag_origin", var_a5519791.origin + (0, 0, -60), var_a5519791.angles);
  blackboard.var_33e067df = 0.75;
  blackboard.var_8e1686c8 = 0.25;
  blackboard.var_f3592501 = 0.5;
  blackboard.var_b2257d78 = 0.5;
  var_ab72a295 = struct::get("hint_evidence_board", "targetname");
  var_63754fbc = util::spawn_model("tag_origin", var_ab72a295.origin);
  blackboard.var_63754fbc = var_63754fbc;
  blackboard.var_7117f05e = [# "menu/recruit", #"menu/regular", #"hash_5eb0fe85b0c234b0", #"menu/veteran", #"menu/heroic"];
  statemachine.blackboard = blackboard;
}

function private function_89f058b1(var_67e21ca2, var_625dd793) {
  var_3cb3ede5 = [];

  foreach(var_eeb11904 in var_625dd793) {
    if(isDefined(var_eeb11904.var_8ca1d4a) && var_eeb11904.var_8ca1d4a != # "cp_ger_hub8") {
      if(isDefined(var_eeb11904.collectiblelist)) {
        collectibles = var_eeb11904.collectiblelist;
        var_eeb11904.var_9c01f410 = [];
        var_eeb11904.var_dade7c7f = [];
        var_eeb11904.var_1ccfca62 = 0;
        var_eeb11904.var_1ca68c21 = 0;

        foreach(index, item in collectibles) {
          collectible = getscriptbundle(item.collectible);
          var_be645ac2 = isDefined(collectible.callback) && collectible.callback == # "chaos_floppy_disk";
          collectible.var_2a51713 = index;

          if(collectible.var_4292acd3 === 1 && !var_be645ac2) {
            var_eeb11904.var_1ccfca62++;
            isunlocked = collectibles::function_1fe63475(var_eeb11904.var_8ca1d4a, index);

            if(level.var_5bd2109) {
              isunlocked = 1;
            }

            collectible.isunlocked = isunlocked;

            if(isunlocked && (isDefined(collectible.var_5eeb1ad0) ? collectible.var_5eeb1ad0 : "") != "") {
              assert(!isDefined(collectible.callback), "<dev string:x1a4>");
              collectible.callback = # "hash_2bfb881b2d0ed7f7";
            }

            if(!var_eeb11904.var_1ca68c21) {
              if(isunlocked && collectibles::function_ee216b9e(var_eeb11904.var_8ca1d4a, collectible.var_2a51713)) {
                var_eeb11904.var_1ca68c21 = 1;
              }
            }

            if(!isDefined(var_eeb11904.var_dade7c7f)) {
              var_eeb11904.var_dade7c7f = [];
            } else if(!isarray(var_eeb11904.var_dade7c7f)) {
              var_eeb11904.var_dade7c7f = array(var_eeb11904.var_dade7c7f);
            }

            var_eeb11904.var_dade7c7f[var_eeb11904.var_dade7c7f.size] = collectible;
          }

          if(!isDefined(var_eeb11904.var_9c01f410)) {
            var_eeb11904.var_9c01f410 = [];
          } else if(!isarray(var_eeb11904.var_9c01f410)) {
            var_eeb11904.var_9c01f410 = array(var_eeb11904.var_9c01f410);
          }

          var_eeb11904.var_9c01f410[var_eeb11904.var_9c01f410.size] = collectible;
        }
      }

      var_3cb3ede5[var_eeb11904.var_8ca1d4a] = var_eeb11904;
    }
  }

  return var_3cb3ede5;
}

function private function_eaf23d80(clusterdata) {
  assert(isDefined(clusterdata));

  foreach(collectible in clusterdata.var_dade7c7f) {
    if(is_true(collectible.isunlocked)) {
      return true;
    }
  }

  return false;
}

function private function_f98394d8(var_625dd793, var_3cb3ede5) {
  var_d771858a = [];

  for(i = 0; i < var_625dd793.size; i++) {
    var_663c51cb = var_625dd793[i];
    assert(isstring(var_663c51cb));
    var_d771858a = function_e768ae1e(var_d771858a, var_663c51cb, var_3cb3ede5);
  }

  return var_d771858a;
}

function private function_e768ae1e(var_d771858a, var_663c51cb, var_3cb3ede5) {
  var_6711328d = getEntArray("mdl_" + var_663c51cb + "_first_items", "script_noteworthy");

  foreach(e in var_6711328d) {
    if(!isDefined(var_d771858a)) {
      var_d771858a = [];
    } else if(!isarray(var_d771858a)) {
      var_d771858a = array(var_d771858a);
    }

    var_d771858a[var_d771858a.size] = e;
  }

  t = getent(var_663c51cb, "script_noteworthy");

  if(!isDefined(var_d771858a)) {
    var_d771858a = [];
  } else if(!isarray(var_d771858a)) {
    var_d771858a = array(var_d771858a);
  }

  var_d771858a[var_d771858a.size] = t;
  var_181973be = var_3cb3ede5[var_663c51cb].var_9c01f410;

  if(isDefined(var_181973be)) {
    foreach(evidencedata in var_181973be) {
      if(isDefined(evidencedata.isunlocked) && evidencedata.isunlocked == 0) {
        continue;
      }

      if(isDefined(evidencedata.tagname)) {
        e = getent(evidencedata.tagname, "script_noteworthy");

        if(!isDefined(var_d771858a)) {
          var_d771858a = [];
        } else if(!isarray(var_d771858a)) {
          var_d771858a = array(var_d771858a);
        }

        var_d771858a[var_d771858a.size] = e;
      }
    }
  }

  return var_d771858a;
}

function private function_1e294fd9(var_625dd793, var_3cb3ede5) {
  foreach(mapname in var_625dd793) {
    clusterdata = var_3cb3ede5[mapname];
    var_4ff3b76c = getent(clusterdata.var_4ff3b76c, "script_noteworthy");
    var_4ff3b76c show();
    var_f215acc = 1;

    if(function_8c91b796(clusterdata)) {
      var_f215acc = 0;
    } else if(function_1447e257(clusterdata)) {
      var_f215acc = 0;
    }

    if(var_f215acc) {
      if(savegame::function_ac15668a(mapname)) {
        var_4ff3b76c setModel(clusterdata.var_711c13dc);
      } else {
        var_4ff3b76c setModel(clusterdata.var_653c7d7d);
      }

      continue;
    }

    var_4ff3b76c setModel(clusterdata.var_839276ad);
  }
}

function private function_580e9a17(var_625dd793, var_3cb3ede5) {
  foreach(mapname in var_625dd793) {
    clusterdata = var_3cb3ede5[mapname];
    var_d65f7c8b = !is_true(clusterdata.isSideMission) && !function_1447e257(clusterdata) && !savegame::function_ac15668a(mapname);

    if(is_true(level.var_99e01934)) {
      var_d65f7c8b = 1;
    }

    if(var_d65f7c8b) {
      function_a548b274(clusterdata);
    } else {
      function_5fbd9a9c(clusterdata);
    }

    HasNewEvidence = clusterdata.var_1ca68c21;

    if(is_true(level.var_99e01934)) {
      HasNewEvidence = 1;
    }

    if(HasNewEvidence) {
      function_a40db718(clusterdata);
      continue;
    }

    function_50542db7(clusterdata);
  }
}

function private function_a548b274(clusterdata) {
  if(isDefined(clusterdata.var_8349c453)) {
    return;
  }

  assert(isDefined(clusterdata.var_f8097243));
  iconstruct = struct::get(clusterdata.var_f8097243);

  if(isDefined(iconstruct)) {
    clusterdata.var_8349c453 = spawn("script_origin", iconstruct.origin);
  }
}

function private function_5fbd9a9c(clusterdata) {
  if(isDefined(clusterdata.var_8349c453)) {
    clusterdata.var_8349c453 delete();
  }
}

function private function_a40db718(clusterdata) {
  if(isDefined(clusterdata.var_1a7f654)) {
    return;
  }

  assert(isDefined(clusterdata.var_212ee626));
  iconstruct = struct::get(clusterdata.var_212ee626);

  if(isDefined(iconstruct)) {
    clusterdata.var_1a7f654 = spawn("script_origin", iconstruct.origin);
  }
}

function private function_50542db7(clusterdata) {
  if(isDefined(clusterdata.var_1a7f654)) {
    clusterdata.var_1a7f654 delete();
  }
}

function private function_1447e257(clusterdata) {
  return is_true(clusterdata.var_e4f432d9) && !savegame::function_ac15668a(clusterdata.var_d7ba74ee);
}

function private function_8c91b796(clusterdata) {
  return is_true(clusterdata.isSideMission) && !function_eaf23d80(clusterdata);
}

function private function_e0cfa93c(var_7b80750a) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  level.player flag::wait_till(level.var_d7d201ba);

  if(isDefined(var_7b80750a)) {
    level waittill(var_7b80750a);
  }

  statemachine = player function_1bb19090();
  statemachine statemachine::set_state("board_default_state");
  player thread function_e8e65a88(statemachine, "board_default_state");
}

function private function_e8e65a88(statemachine, initialstate) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  blackboard = statemachine.blackboard;
  blackboard.var_481d0fb1 = [initialstate];

  while(true) {
    player waittill(#"eboard_state_change");
    assert(isDefined(statemachine.current_state) && isDefined(statemachine.next_state));
    blackboard.var_68768c5 = statemachine.current_state.name;

    if(!isinarray(blackboard.var_481d0fb1, statemachine.next_state.name)) {
      array::add(blackboard.var_481d0fb1, statemachine.next_state.name);
    } else {
      assert(blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 1] == statemachine.current_state.name && blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 2] == statemachine.next_state.name);
      blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 1] = undefined;
    }

    if(is_true(level.var_47df5f11)) {
      println("<dev string:x237>");

      for(i = 0; i < blackboard.var_481d0fb1.size; i++) {
        println("<dev string:x255>" + i + "<dev string:x25a>" + blackboard.var_481d0fb1[i]);
      }
    }

  }
}

function private function_305352b5() {
  player = self;
  assert(isPlayer(player));
  statemachine = player function_1bb19090();
  var_fe7185f8 = statemachine.blackboard.var_68768c5;

  if(isinarray(statemachine.blackboard.var_481d0fb1, var_fe7185f8)) {
    blackboard = statemachine.blackboard;
    assert(blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 1] == statemachine.current_state.name && blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 2] == var_fe7185f8);
  }

  return isinarray(statemachine.blackboard.var_481d0fb1, var_fe7185f8);
}

function private function_a997529d() {
  player = self;
  assert(isPlayer(player));
  statemachine = player function_1bb19090();

  if(isinarray(statemachine.blackboard.var_481d0fb1, statemachine.next_state.name)) {
    blackboard = statemachine.blackboard;
    assert(blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 1] == statemachine.current_state.name && blackboard.var_481d0fb1[blackboard.var_481d0fb1.size - 2] == statemachine.next_state.name);
  }

  return isinarray(statemachine.blackboard.var_481d0fb1, statemachine.next_state.name);
}

function private function_1bb19090() {
  player = self;
  assert(isPlayer(player));
  assert(isDefined(player.state_machines));
  assert(isDefined(player.state_machines[# "eboard_state_machine"]));
  return player.state_machines[# "eboard_state_machine"];
}

function private function_361f6bd8(params) {
  assertmsg("<dev string:x260>");
  return false;
}

function private function_6d01a6c8(params) {
  player = self;
  assert(isPlayer(player));

  player function_fc845aca();

  level.statemachine = player function_1bb19090();
  level.statemachine.blackboard.var_63754fbc util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_400e97432023f9f3", 160, undefined, &function_b0a92909);
  player thread clientfield::set_to_player("set_hub_fov", 2);
  player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 0);
  player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", 0);
}

function private function_964c7ad2(params) {
  player = self;
  assert(isPlayer(player));
  assert(!level flag::get("<dev string:x2a0>"));

  player function_d530ce5a();
}

function private function_b0a92909(params) {
  assert(isDefined(params.player));

  statemachine = params.player function_1bb19090();
  assert(statemachine.current_state.name == "<dev string:x2c4>");

  params.player notify(#"eboard_enter_overview");
}

function private function_5501ae88() {
  player = self;
  player endon(#"death");

  if(!savegame::function_2ee66e93("ExamineEvidenceHintShown", 0)) {
    wait 0.5;
    player hint_tutorial::function_4c2d4fc4(#"hash_12271ba90c5284d8", #"hash_6de0c50ffde2d869", 4);
    player hint_tutorial::function_df08d48(5);
    namespace_61e6d095::function_46df0bc7(#"hint_tutorial", 999);
    namespace_61e6d095::function_d3c3e5c3(#"hint_tutorial", [# "dialog_tree", #"computer"]);
    savegame::set_player_data("ExamineEvidenceHintShown", 1);
    waitframe(1);
    player hint_tutorial::pause(undefined, undefined, 2, undefined, undefined, 1);
    wait 0.5;
  }
}

function private function_587e1291(blackboard) {
  player = self;
  player endon(#"death");

  if(!savegame::function_2ee66e93("SideMissionUnlockedHintShown", 0)) {
    var_e0e794c5 = 0;

    foreach(mapname in blackboard.var_625dd793) {
      clusterdata = blackboard.var_3cb3ede5[mapname];

      if(is_true(clusterdata.isSideMission)) {
        var_e0e794c5 = 1;
        break;
      }
    }

    if(!var_e0e794c5) {
      return;
    }

    wait 0.5;
    player hint_tutorial::function_4c2d4fc4(#"hash_3012969fa356381", #"hash_39bac5818104980f");
    player hint_tutorial::function_df08d48(5);
    namespace_61e6d095::function_46df0bc7(#"hint_tutorial", 999);
    namespace_61e6d095::function_d3c3e5c3(#"hint_tutorial", [# "dialog_tree", #"computer"]);
    savegame::set_player_data("SideMissionUnlockedHintShown", 1);
    waitframe(1);
    player hint_tutorial::pause(undefined, undefined, 2, undefined, undefined, 1);
    wait 0.5;
  }
}

function private function_bdf71927(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");

  player function_fc845aca();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 1);
  player clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", 1);

  if(player function_305352b5()) {
    player function_3ab14abb();
    level thread namespace_4ed3ce47::function_d2bce2b8();
    player thread namespace_4ed3ce47::duck_evidence_board_enter();
    level thread namespace_4ed3ce47::function_7edafa59("evidence_board_main");
    level flag::set("flag_player_used_evidence_board");
    level flag::set("flag_player_using_evidence_board");

    foreach(var_3d43d7b8 in level.a_ai_allies) {
      if(isDefined(var_3d43d7b8[0])) {
        var_3d43d7b8[0] notify(#"kill_dialog");
      }
    }

    player hide();
    player setstance("stand");
    player val::set(#"evidence_board", "allow_prone", 0);
    player val::set(#"evidence_board", "allow_crouch", 0);
    player function_44d63ecd(0, 0.5);
    player function_d50da7b8(blackboard);
    player.var_c9b94b07 = player function_43ee4470();
    player setcinematicmotionoverride("cinematicmotion_static");
    player function_5501ae88();
    player function_587e1291(blackboard);
    player interactive_map::open(#"hash_79bcfa1ce8d9fd7f", undefined, undefined, 0, undefined, undefined, undefined, undefined, undefined, 1);
    player interactive_map::function_23036faa(#"cursor", "year", 0);
    player interactive_map::function_23036faa(#"cursor", "player", #"");
    player interactive_map::function_23036faa(#"cursor", "progress", 0);
    player interactive_map::function_23036faa(#"cursor", "collectibleCount", 0);
    player interactive_map::function_23036faa(#"cursor", "missionState", -1);
    player interactive_map::function_59b2a130(blackboard.var_3c3d8c0b);
    var_96b6affa = {
      #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_6c7bb285599937ba", #complete_callback: &function_fb5a7ab1, #var_be77841a: 0, #var_531201f1: &function_4b717253
    };

    foreach(trigger in blackboard.var_3c3d8c0b) {
      trigger.var_f90e2591 = &function_e976f5d3;
      trigger.var_938b0e9b = &function_cab79d7e;
      clusterdata = blackboard.var_3cb3ede5[trigger.script_noteworthy];

      if(function_1447e257(clusterdata)) {
        trigger.var_d9b5c896 = isDefined(clusterdata.var_c4ac97e4) ? clusterdata.var_c4ac97e4 : clusterdata.levelname;
        trigger.var_94ca2a30 = isDefined(clusterdata.var_bd8e2ffe) ? clusterdata.var_bd8e2ffe : clusterdata.var_2dd3e7b0;
      } else {
        trigger.var_d9b5c896 = clusterdata.levelname;
        trigger.var_94ca2a30 = clusterdata.var_2dd3e7b0;
      }

      trigger interactive_map::function_b5c2702b(#"confirm", var_96b6affa);
    }

    player interactive_map::function_879505e1(1, #"hash_181a347630cebe70");
    player interactive_map::function_835fb58e(1);
  }

  function_580e9a17(blackboard.var_625dd793, blackboard.var_3cb3ede5);
  assert(!isDefined(blackboard.var_48b0cd0f));
  blackboard.var_48b0cd0f = [];

  foreach(mapdata in blackboard.var_3cb3ede5) {
    if(isDefined(mapdata.var_8349c453)) {
      uid = hash("icon_next_mission_" + mapdata.var_8ca1d4a);
      namespace_61e6d095::create(uid, #"hash_21d9a29850806057");
      namespace_61e6d095::function_d3c3e5c3(uid, #"interactive_map");
      namespace_61e6d095::set_state(uid, 0);
      namespace_61e6d095::set_ent(uid, mapdata.var_8349c453);

      if(!isDefined(blackboard.var_48b0cd0f)) {
        blackboard.var_48b0cd0f = [];
      } else if(!isarray(blackboard.var_48b0cd0f)) {
        blackboard.var_48b0cd0f = array(blackboard.var_48b0cd0f);
      }

      blackboard.var_48b0cd0f[blackboard.var_48b0cd0f.size] = uid;
    }

    if(isDefined(mapdata.var_1a7f654)) {
      uid = hash("icon_new_evidence_" + mapdata.var_8ca1d4a);
      namespace_61e6d095::create(uid, #"hash_21d9a29850806057");
      namespace_61e6d095::function_d3c3e5c3(uid, #"interactive_map");

      if(is_true(mapdata.isSideMission)) {
        namespace_61e6d095::set_state(uid, 2);
      } else {
        namespace_61e6d095::set_state(uid, 1);
      }

      namespace_61e6d095::set_ent(uid, mapdata.var_1a7f654);

      if(!isDefined(blackboard.var_48b0cd0f)) {
        blackboard.var_48b0cd0f = [];
      } else if(!isarray(blackboard.var_48b0cd0f)) {
        blackboard.var_48b0cd0f = array(blackboard.var_48b0cd0f);
      }

      blackboard.var_48b0cd0f[blackboard.var_48b0cd0f.size] = uid;
    }
  }

  player val::set(#"eboard", "show_hud", 0);
  namespace_c8e236da::removelist();
  self function_5f8cfb0f(0);
  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
}

function private function_3ab14abb() {
  player = self;
  player clientfield::set_to_player("set_hub_dof", 1);
  player clientfield::set_to_player("set_hub_fov", 4);
}

function private function_d50da7b8(blackboard) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  player val::set(#"hash_5f70dbe5f8e16583", "freezecontrols", 1);
  player stopgestureviewmodel("dem_lowreadyup", blackboard.var_33e067df);
  player playerlinktoblend(blackboard.var_f9e7327d, "tag_origin", blackboard.var_33e067df, blackboard.var_8e1686c8, blackboard.var_f3592501, blackboard.var_33e067df, blackboard.var_8e1686c8, blackboard.var_f3592501);
  wait blackboard.var_33e067df;
  waitframe(1);
  playerpos = player getplayercamerapos();
  playerangles = player getplayerangles();
  player camerasetposition(playerpos, playerangles);
  player cameraactivate(1);
  waitframe(1);
  player val::reset_all(#"hash_5f70dbe5f8e16583");
}

function private function_f77a1784(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"eboard_state_change");
  player namespace_61e6d095::function_b0bad5ff("eboard_state_change");
  player function_44d63ecd(1, 0.8);
  player notify(#"evidence_board_closed");
}

function private function_fb5a7ab1(var_5a02549b) {
  player = getplayers()[0];
  player notify(#"evidence_board_mission_selected");
}

function private function_4b717253(var_5a02549b) {
  return !namespace_61e6d095::should_hide(#"interactive_map");
}

function private function_e976f5d3() {
  missionname = self.script_noteworthy;
  player = getplayers()[0];
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  blackboard.var_c5bde695 = missionname;
  evidence = blackboard.var_3cb3ede5[missionname];
  assert(isDefined(evidence));
  interactive_map::function_23036faa(#"cursor", "missionState", -1);
  interactive_map::function_23036faa(#"cursor", "isSideMission", evidence.isSideMission);
  interactive_map::function_23036faa(#"cursor", "year", evidence.var_2200aced);

  if(function_1447e257(evidence)) {
    interactive_map::function_23036faa(#"cursor", "player", isDefined(evidence.var_fcfeae68) ? evidence.var_fcfeae68 : # "");
  } else {
    interactive_map::function_23036faa(#"cursor", "player", evidence.LevelPresence);
  }

  interactive_map::function_23036faa(#"cursor", "progress", 0.4);

  if(isDefined(evidence.var_8349c453)) {
    interactive_map::function_23036faa(#"cursor", "missionState", 0);
  }

  if(isDefined(evidence.var_1a7f654)) {
    if(evidence.isSideMission === 1) {
      interactive_map::function_23036faa(#"cursor", "missionState", 2);
    } else {
      interactive_map::function_23036faa(#"cursor", "missionState", 1);
    }
  }

  if(isDefined(evidence.var_dade7c7f) && isDefined(evidence.var_8ca1d4a)) {
    var_61b3cfd0 = collectibles::function_9f976c54(evidence.var_8ca1d4a);
    assert(var_61b3cfd0 < 8);
    var_68c47b96 = collectibles::function_7be39f53(evidence.var_8ca1d4a);
    assert(var_68c47b96 < 8);
    var_2ed2359a = var_61b3cfd0;
    var_2ed2359a |= var_68c47b96 << 3;
    interactive_map::function_23036faa(#"cursor", "collectibleCount", var_2ed2359a);
  } else {
    interactive_map::function_23036faa(#"cursor", "collectibleCount", 0);
  }

  level thread namespace_4ed3ce47::function_7edafa59("evidence_board_mission");
}

function private function_cab79d7e() {
  player = getplayers()[0];
  statemachine = player function_1bb19090();
  statemachine.blackboard.var_c5bde695 = undefined;
  interactive_map::function_23036faa(#"cursor", "year", 0);
  interactive_map::function_23036faa(#"cursor", "player", #"");
  interactive_map::function_23036faa(#"cursor", "progress", 0);
  interactive_map::function_23036faa(#"cursor", "collectibleCount", 0);
  interactive_map::function_23036faa(#"cursor", "missionState", -1);
  level notify(#"hash_7c11efb940bfa7e2");
  level thread namespace_4ed3ce47::function_7edafa59("evidence_board_main");
}

function private function_559b452b(params) {
  player = self;
  assert(isPlayer(player));

  player function_d530ce5a();

  namespace_c8e236da::removelist();
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;

  foreach(uid in blackboard.var_48b0cd0f) {
    namespace_61e6d095::remove(uid);
  }

  blackboard.var_48b0cd0f = undefined;

  if(player function_a997529d()) {
    player thread function_22ec525a(blackboard);
  }
}

function private function_22ec525a(blackboard) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  blackboard.var_c5bde695 = undefined;
  player val::set(#"eboard", "show_hud", 1);
  namespace_c8e236da::removelist();
  interactive_map::close();
  level thread namespace_4ed3ce47::function_7edafa59("ambient");
  level thread namespace_4ed3ce47::function_dd520714();
  player thread namespace_4ed3ce47::duck_evidence_board_exit();
  player show();
  player cameraactivate(0);

  if(isDefined(player.var_c9b94b07)) {
    player setcinematicmotionoverride(player.var_c9b94b07);
    player.var_c9b94b07 = undefined;
  } else {
    player clearcinematicmotionoverride();
  }

  waitframe(1);
  player unlink();
  player playgestureviewmodel("dem_lowreadyup", undefined, undefined, 1);
  player val::reset_all(#"evidence_board");
  level flag::clear("flag_player_using_evidence_board");
}

function private function_5b9bb291(params) {
  player = self;
  assert(isPlayer(player));

  player function_fc845aca();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
  assert(!namespace_61e6d095::exists(#"hash_3ccc1702bc979da8"));
  namespace_61e6d095::create(#"hash_3ccc1702bc979da8", #"hash_4130605c2e66825d");
  namespace_61e6d095::function_d3c3e5c3(#"hash_3ccc1702bc979da8", #"interactive_map");
  var_9f97b0c5 = isDefined(evidence.AlignRight) && evidence.AlignRight == 1;
  namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "AlignRight", var_9f97b0c5);
  namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "MapName", blackboard.var_c5bde695);
  namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "Year", evidence.var_2200aced);
  namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "HasNewEvidence", is_true(evidence.var_1ca68c21));
  var_6f3b6154 = function_1447e257(evidence);

  if(var_6f3b6154) {
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "CanPlayMission", 0);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelName", isDefined(evidence.var_c4ac97e4) ? evidence.var_c4ac97e4 : evidence.levelname);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelDifficulty", "");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LongDescription", isDefined(evidence.var_c8c2549a) ? evidence.var_c8c2549a : evidence.var_47b1727b);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelPresence", isDefined(evidence.var_fcfeae68) ? evidence.var_fcfeae68 : evidence.LevelPresence);
  } else {
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "CanPlayMission", 1);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelName", evidence.levelname);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelDifficulty", "");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LongDescription", evidence.var_47b1727b);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelPresence", evidence.LevelPresence);
  }

  missiondata = savegame::function_6440b06b(#"persistent", blackboard.var_c5bde695);

  if(is_true(missiondata.complete) && isDefined(missiondata.var_8757a567)) {
    var_4a19e561 = blackboard.var_7117f05e[missiondata.var_8757a567];
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelDifficulty", var_4a19e561);
  }

  namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LastSelectedButton", isDefined(blackboard.var_bcb26d08) ? blackboard.var_bcb26d08 : -1);

  if(isDefined(evidence.var_4458275e)) {
    var_84c8fadd = 0;

    for(var_d871a85c = 0; var_d871a85c < evidence.var_4458275e.size; var_d871a85c++) {
      if(player_decision::function_6efc0ff8(blackboard.var_c5bde695, var_d871a85c)) {
        var_e8c1b531 = evidence.var_4458275e[var_d871a85c];
        namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", var_84c8fadd, "IsPrimaryObjective", var_e8c1b531.IsPrimaryObjective === 1);
        namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", var_84c8fadd, "IsEvilObjective", var_e8c1b531.IsEvilObjective === 1);
        namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", var_84c8fadd, "Index", var_e8c1b531.itemindex);
        namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", var_84c8fadd, "Title", var_e8c1b531.title);
        var_84c8fadd++;
      }
    }
  }

  namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 0);
  player clientfield::set_to_player("set_hub_dof", 4);
  player clientfield::set_to_player("set_hub_fov", 1);
  namespace_c8e236da::removelist();
  var_5c5bb311 = is_true(savegame::function_2ee66e93(blackboard.var_c5bde695 + "_intro_vo_played"));

  if(player function_305352b5()) {
    level thread namespace_4ed3ce47::function_6fe99ae0();
    namespace_61e6d095::function_df0d7a85(#"hash_3ccc1702bc979da8", [# "interactive_map"]);
    player clientfield::set_to_player("set_player_pbg_bank", 1);

    if(isDefined(evidence.var_89616eaa)) {
      level scene::play("scene_hub_eboard_handler", evidence.var_89616eaa);
    }

    if(isDefined(evidence.var_8f98dad8)) {
      level thread scene::play("scene_hub_eboard_handler", evidence.var_8f98dad8);
    }

    if(isDefined(evidence.intro_vo) && evidence.intro_vo.size > 0 && !var_5c5bb311) {
      player thread function_93dd1a56(evidence.intro_vo);
      savegame::set_player_data(blackboard.var_c5bde695 + "_intro_vo_played", 1);
    }

    level clientfield::set("eboard_notify_from_server", 1);
  }

  namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 1);

  if(var_5c5bb311) {
    namespace_c8e236da::function_ebf737f8(#"hash_21282e1a3a54e697");
    self function_5f8cfb0f(1);
  } else {
    self function_5f8cfb0f(0);
  }

  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
}

function private function_93dd1a56(vo_array) {
  self endon(#"death", #"eboard_state_change");

  foreach(vox in vo_array) {
    self dialogue::radio(vox.vox);
    wait randomfloatrange(0.5, 0.8);
  }
}

function private function_d2acd9a1() {
  player = self;
  player endon(#"death");

  while(true) {
    player waittill(#"ui_alt1");
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert(isDefined(blackboard.var_c5bde695));
    evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];

    if(isDefined(evidence.intro_vo) && evidence.intro_vo.size > 0) {
      player function_93dd1a56(evidence.intro_vo);
    }
  }
}

function private function_c7ffe282(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"eboard_state_change");
  player childthread function_e14ba795();

  if(namespace_c8e236da::function_295a2a9e(#"hash_21282e1a3a54e697")) {
    player childthread function_d2acd9a1();
  }

  while(true) {
    option = level waittill(#"evidence_board_option_selected");

    if(!namespace_61e6d095::exists(#"hash_3ccc1702bc979da8")) {
      continue;
    }

    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    blackboard.var_bcb26d08 = option.optindex;

    if(option.optindex == 1) {
      assert(isDefined(blackboard.var_c5bde695));
      evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];

      if(isDefined(evidence.var_dade7c7f) && evidence.var_dade7c7f.size > 0) {
        player notify(#"evidence_board_review_selected");
        break;
      }

      continue;
    }

    if(option.optindex == 0) {
      assert(isDefined(blackboard.var_c5bde695));
      safehouse = savegame::function_8136eb5a();
      nextmission = blackboard.var_c5bde695;
      var_cc500e2b = function_2717b55f(nextmission);
      savegame::set_player_data("previous_safehouse", safehouse);
      var_a71d5880 = savegame::function_6440b06b(#"persistent", nextmission);
      namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 0);

      if(nextmission == "cp_nic_revolucion" && !is_true(var_a71d5880.complete)) {
        player thread globallogic_ui::function_4e49c51d(#"hash_53f4004442386d39", #"hash_4f8c4e1b714e2e90", 0, &function_1c9f3744, &function_5058b4e9, nextmission);
      } else if(isDefined(var_cc500e2b) && is_true(var_cc500e2b.isSideMission)) {
        var_a71d5880 = savegame::function_6440b06b(#"persistent", nextmission);

        if(is_true(var_a71d5880.complete)) {
          function_9f6854a1(nextmission);
        } else if(nextmission == "cp_sidemission_takedown") {
          if(!is_true(player_decision::function_ee124ba3())) {
            player thread globallogic_ui::function_4e49c51d(#"hash_7f4487a7da679130", #"hash_746b9b6a5211589d", 0, &function_9f6854a1, &function_5058b4e9, nextmission);
          } else {
            function_9f6854a1(nextmission);
          }
        } else if(nextmission == "cp_sidemission_tundra") {
          var_a24e9150 = savegame::function_2ee66e93(#"hash_470832ca3fa7ae83", []);
          var_8f36ce4a = 0;

          foreach(var_7253f96e in var_a24e9150) {
            if(is_true(var_7253f96e.ismarked)) {
              var_8f36ce4a++;
            }
          }

          if(var_8f36ce4a < 3) {
            player thread globallogic_ui::function_4e49c51d(#"hash_1c8813eba3d3c667", #"hash_67bdd3726f291f0e", 1, undefined, &function_5058b4e9, nextmission);
          } else {
            player thread globallogic_ui::function_4e49c51d(#"hash_1c8813eba3d3c667", #"hash_2db99449b922dd5c", 0, &function_9f6854a1, &function_5058b4e9, nextmission);
          }
        }
      } else {
        function_1c9f3744(nextmission);
      }

      continue;
    }

    if(option.optindex == 3) {
      assert(blackboard.var_c5bde695 == "<dev string:x132>");
      player notify(#"evidence_board_review_suspects_selected");
      break;
    }

    if(option.optindex == 4) {
      assert(blackboard.var_c5bde695 == "<dev string:x117>");
      player notify(#"evidence_board_decrypt_floppy_selected");
      break;
    }

    assertmsg("<dev string:x2db>" + option.optindex);
  }
}

function private function_5058b4e9(params) {
  namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 1);
}

function private function_1c9f3744(nextmission) {
  player = getplayers()[0];
  player notify(#"hash_3ac28b014653cac6");
  skipto::function_1c2dfc20(nextmission);
}

function private function_9f6854a1(nextmission) {
  self notify("18d00d06dc4ed404");
  self endon("18d00d06dc4ed404");
  self endon(#"disconnect");
  player = self;
  assert(isPlayer(player));
  player notify(#"hash_3ac28b014653cac6");

  if(!isDefined(nextmission)) {
    statemachine = player function_1bb19090();
    blackboard = statemachine.blackboard;
    assert(isDefined(blackboard.var_c5bde695));
    nextmission = blackboard.var_c5bde695;
  }

  safehouse = savegame::function_8136eb5a();

  if(player stats::get_stat(#"hash_1e7fdd28f2a28f78", nextmission, #"missionindex") <= 0) {
    player stats::set_stat(#"hash_1e7fdd28f2a28f78", nextmission, #"missionindex", getmaporder(safehouse) + 1);
  }

  skipto::function_1c2dfc20(nextmission);
}

function private function_96e31558(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  player notify(#"hash_3ac28b014653cac6");

  player function_d530ce5a();

  namespace_c8e236da::removelist();
  assert(namespace_61e6d095::exists(#"hash_3ccc1702bc979da8"));
  namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 0);
  namespace_61e6d095::remove(#"hash_3ccc1702bc979da8");
  statemachine = player function_1bb19090();

  if(player function_a997529d()) {
    statemachine.blackboard.var_bcb26d08 = undefined;
    player clientfield::set_to_player("set_player_pbg_bank", 0);
    level clientfield::set("eboard_notify_from_server", 2);
    level thread namespace_4ed3ce47::function_f60575fd();
    level scene::stop("scene_hub_eboard_handler");
    player function_3ab14abb();
    player clientfield::set_to_player("eboard_camera_position", 2);
    wait statemachine.blackboard.var_b2257d78;
    player clientfield::set_to_player("eboard_camera_position", 28);
    namespace_61e6d095::function_f96376c5(#"hash_3ccc1702bc979da8");
  }

  player thread function_7dfbe539();
}

function private function_7dfbe539() {
  player = self;
  util::wait_network_frame();
  player dialogue::function_9e580f95();
}

function private function_de709256(params) {
  player = self;
  assert(isPlayer(player));

  player function_fc845aca();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
  namespace_61e6d095::function_df0d7a85(#"hash_34f10865afcf9af7", [# "interactive_map"]);
  var_fc34020f = savegame::function_ac15668a(blackboard.var_c5bde695);
  namespace_46c3c08e::function_eadf5d0b(var_fc34020f);
  waitframe(1);
  player clientfield::set_to_player("eboard_review_handle_viewmodel", 2);
  namespace_c8e236da::removelist();

  if(!var_fc34020f) {
    namespace_c8e236da::function_ebf737f8(#"hash_7711aac8b3b77847");
  }

  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
  namespace_c8e236da::function_ebf737f8(#"hash_545a24d4a3a88817");
  namespace_c8e236da::function_ebf737f8(#"hash_700b367af088c0c3");
  blackboard.var_1bfff22b show();
}

function private function_35a396ee(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"eboard_state_change");
  player childthread function_e14ba795();
  var_26d73535 = namespace_46c3c08e::function_f9edf6c2();
  statemachine = player function_1bb19090();
  var_fc34020f = savegame::function_ac15668a(statemachine.blackboard.var_c5bde695);
  assert(var_26d73535 > 0);
  current_index = 0;

  while(true) {
    result = player waittillmatch({
      #menu: # "ScriptedHudWidgetMenu"}, #"menuresponse");

    if(!namespace_61e6d095::exists(#"hash_34f10865afcf9af7")) {
      continue;
    }

    if(result.response == # "hash_7fff5f0605764d7") {
      player thread function_54e62ef2(current_index, result.intpayload);
      current_index = result.intpayload;
      continue;
    }

    if(result.response == # "hash_79587d9fe84f7a23") {
      if(!var_fc34020f) {
        namespace_46c3c08e::function_407ee527(current_index);
      }
    }
  }
}

function private function_54e62ef2(oldindex, newindex) {
  player = self;
  assert(isPlayer(player));
}

function private function_85225ecb() {
  player = getplayers()[0];
  player notify(#"hash_6508d37e574b09be");
}

function private function_3740b568() {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  player notify(#"hash_3ac28b014653cac6");
  namespace_46c3c08e::function_2340e15a();
  player clientfield::set_to_player("eboard_review_handle_viewmodel", 0);
  waitframe(1);
  namespace_61e6d095::function_f96376c5(#"hash_34f10865afcf9af7");
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));
  blackboard.var_1bfff22b hide();
  waitframe(1);
}

function private function_e6734894(params) {
  player = self;
  assert(isPlayer(player));

  player function_fc845aca();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695) && blackboard.var_c5bde695 == "<dev string:x117>");
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];

  foreach(var_38d97d58 in evidence.var_9c01f410) {
    if(isDefined(var_38d97d58.callback) && var_38d97d58.callback == # "chaos_floppy_disk") {
      var_7fb2f6df = var_38d97d58;
      break;
    }
  }

  assert(isDefined(var_7fb2f6df));
  blackboard.var_7fb2f6df = var_7fb2f6df;
  var_fc34020f = savegame::function_ac15668a(blackboard.var_c5bde695);
  var_ccb596bd = player_decision::function_ee124ba3();

  if(var_ccb596bd) {
    hinttext = # "hash_7297c1617beaa420";
  } else if(var_fc34020f) {
    hinttext = # "hash_4633544551d3491a";
  } else {
    hinttext = # "hash_2879a6ccf4f083c8";
  }

  blackboard.var_9b52b1bf = !var_fc34020f || var_ccb596bd;
  assert(!namespace_61e6d095::exists(#"hash_afc09dfd34bcde0"));
  namespace_61e6d095::create(#"hash_afc09dfd34bcde0", #"hash_102694e2bfda6f95");
  namespace_61e6d095::function_d3c3e5c3(#"hash_afc09dfd34bcde0", #"interactive_map");
  namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "evidenceEarnedCount", 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "evidenceTotalCount", 0);
  var_625081d5 = 0;
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "Ref", var_7fb2f6df.name);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "Title", var_7fb2f6df.title);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "SubTitle", var_7fb2f6df.subtitle);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "Description", var_7fb2f6df.description);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "Thumbnail", var_7fb2f6df.thumbnail);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "IsUnlocked", 1);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "UnlockType", var_7fb2f6df.UnlockType);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "UnlockMap", var_7fb2f6df.UnlockMap);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "Hint", hinttext);
  namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", var_625081d5, "IsCompleted", var_fc34020f || var_ccb596bd);
  player clientfield::set_to_player("set_hub_dof", 1);
  player clientfield::set_to_player("set_hub_fov", 1);
  var_7fb2f6df.isunlocked = 1;
  function_aa81758f(var_7fb2f6df, 0);
  player clientfield::set_to_player("eboard_review_handle_viewmodel", 1);
  blackboard.var_1bfff22b show();
  namespace_61e6d095::function_73c9a490(#"hash_afc09dfd34bcde0", 1);
  namespace_c8e236da::removelist();

  if(blackboard.var_9b52b1bf) {
    if(var_ccb596bd) {
      namespace_c8e236da::function_ebf737f8(#"hash_7f24e58a797a8ecb");
    } else {
      namespace_c8e236da::function_ebf737f8(#"hash_1dcd987d46fd8a85");
    }
  }

  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
  namespace_c8e236da::function_ebf737f8(#"hash_545a24d4a3a88817");
  namespace_c8e236da::function_ebf737f8(#"hash_700b367af088c0c3");
}

function private function_d4497273(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"eboard_state_change");
  player childthread function_e14ba795();
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  current_index = isDefined(blackboard.var_bcd1e3f9) ? blackboard.var_bcd1e3f9 : 0;

  while(true) {
    result = player waittillmatch({
      #menu: # "ScriptedHudWidgetMenu", #response: # "hash_79587d9fe84f7a23"}, #"menuresponse");

    if(blackboard.var_9b52b1bf) {
      player thread function_85113485();
    }
  }
}

function private function_85113485() {
  player = self;
  assert(isPlayer(player));
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_7fb2f6df));
  player notify(#"evidence_board_evidence_callback_execute", {
    #var_ea190649: blackboard.var_7fb2f6df, #var_8a547b69: "evidence_board_evidence_floppy_callback_finished"});
}

function private function_e8205381() {
  player = self;
  assert(isPlayer(player));
  player notify(#"hash_333d48f5d81e9a37");
}

function private function_dd090dfe(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  player notify(#"hash_3ac28b014653cac6");

  player function_d530ce5a();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;

  if(player function_a997529d()) {
    blackboard.var_1bfff22b hide();
    function_aa81758f(blackboard.var_7fb2f6df, 1);
    blackboard.var_7fb2f6df = undefined;
    player clientfield::set_to_player("eboard_review_handle_viewmodel", 0);
    assert(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0"));
    namespace_61e6d095::remove(#"hash_afc09dfd34bcde0");
    namespace_c8e236da::removelist();
    waitframe(1);
    return;
  }

  if(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
    namespace_61e6d095::remove(#"hash_afc09dfd34bcde0");
  }
}

function private function_c4deb1a2(params) {
  namespace_c8e236da::removelist();
  waitframe(1);
  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
}

function private function_b00f82b(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;

  if(isDefined(params.var_ea190649)) {
    var_38d97d58 = params.var_ea190649;
  } else {
    assert(isDefined(blackboard.var_c5bde695));
    assert(isDefined(blackboard.var_bcd1e3f9));
    evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
    assert(isDefined(evidence.var_dade7c7f) && isDefined(evidence.var_dade7c7f[blackboard.var_bcd1e3f9]));
    var_38d97d58 = evidence.var_dade7c7f[blackboard.var_bcd1e3f9];
  }

  assert(collectibles::function_606a97af(var_38d97d58.callback));
  player clientfield::set_to_player("eboard_review_handle_viewmodel", 0);
  collectibles::function_f539a1fa(var_38d97d58.callback, var_38d97d58);

  while(player namespace_61e6d095::function_70217795()) {
    waitframe(1);
  }

  if(isDefined(params.var_8a547b69)) {
    player notify(params.var_8a547b69);
    return;
  }

  player notify(#"evidence_board_evidence_callback_finished");
}

function private function_340179ff(params) {
  namespace_c8e236da::removelist();
  player = self;
  assert(isPlayer(player));
  player clientfield::set_to_player("eboard_review_handle_viewmodel", 1);
}

function private function_e2e9758c(params) {
  player = self;
  assert(isPlayer(player));

  player function_fc845aca();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));

  if(player function_305352b5()) {
    evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
    assert(isDefined(evidence.var_dade7c7f) && evidence.var_dade7c7f.size > 0);
    assert(!namespace_61e6d095::exists(#"hash_afc09dfd34bcde0"));
    namespace_61e6d095::create(#"hash_afc09dfd34bcde0", #"hash_102694e2bfda6f95");
    namespace_61e6d095::function_d3c3e5c3(#"hash_afc09dfd34bcde0", #"interactive_map");
    var_2a015e7e = collectibles::function_5d5166dd(evidence.var_8ca1d4a);
    var_f8f020e3 = collectibles::function_99c4aa1(evidence.var_8ca1d4a);
    namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "evidenceEarnedCount", var_2a015e7e);
    namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "evidenceTotalCount", var_f8f020e3);

    foreach(index, collectible in evidence.var_dade7c7f) {
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Ref", collectible.name);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Title", collectible.title);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "SubTitle", collectible.subtitle);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "UnlockType", collectible.UnlockType);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "UnlockMap", collectible.UnlockMap);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Hint", #"");
      var_779873c0 = isDefined(collectible.var_779873c0) ? collectible.var_779873c0 : 0;

      if(var_779873c0 == 0) {
        namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Description", collectible.description);
      } else if(var_779873c0 == 1) {
        var_ad094026 = namespace_70eba6e6::function_b6a02677();

        if(var_ad094026 == 1) {
          description = collectible.var_929642ed;
        } else if(var_ad094026 == 2) {
          description = collectible.var_99e879f5;
        } else if(var_ad094026 == 3) {
          description = collectible.var_3fe4f91e;
        } else {
          description = collectible.var_95e66f2a;
        }

        namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Description", description);
      }

      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Thumbnail", collectible.thumbnail);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "IsUnlocked", collectible.isunlocked);
      isnew = collectibles::function_ee216b9e(evidence.var_8ca1d4a, collectible.var_2a51713);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "IsNew", isnew);
    }

    if(function_1447e257(evidence)) {
      namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "text", isDefined(evidence.var_c4ac97e4) ? evidence.var_c4ac97e4 : evidence.levelname);
    } else {
      namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "text", evidence.levelname);
    }

    player clientfield::set_to_player("set_hub_dof", 1);
    player clientfield::set_to_player("set_hub_fov", 1);
    player clientfield::set_to_player("eboard_review_handle_viewmodel", 1);
    blackboard.var_1bfff22b show();
  }

  if(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
    namespace_61e6d095::function_73c9a490(#"hash_afc09dfd34bcde0", 1);
  }

  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_70ea6473ebf66053");
  namespace_c8e236da::function_ebf737f8(#"hash_545a24d4a3a88817");
  namespace_c8e236da::function_ebf737f8(#"hash_700b367af088c0c3");
}

function private function_109f3f2(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"eboard_state_change");
  player childthread function_e14ba795();
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
  var_75c8057d = evidence.var_dade7c7f.size;

  if(!isDefined(blackboard.var_bcd1e3f9)) {
    blackboard.var_bcd1e3f9 = 0;
  }

  while(true) {
    result = player waittillmatch({
      #menu: # "ScriptedHudWidgetMenu"}, #"menuresponse");

    if(!namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
      continue;
    }

    if(result.response == # "hash_7fff5f0605764d7") {
      player thread function_9019d1f0(blackboard.var_bcd1e3f9, result.intpayload);
      blackboard.var_bcd1e3f9 = result.intpayload;
      continue;
    }

    if(result.response == # "hash_79587d9fe84f7a23") {
      player thread function_57c5b410(blackboard.var_bcd1e3f9);
    }
  }
}

function private function_9019d1f0(oldindex, newindex) {
  player = self;
  assert(isPlayer(player));
  namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "count", newindex);
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
  assert(isDefined(evidence.var_dade7c7f) && isDefined(evidence.var_dade7c7f[newindex]));
  var_38d97d58 = evidence.var_dade7c7f[newindex];

  if(is_true(var_38d97d58.isunlocked) && collectibles::function_606a97af(var_38d97d58.callback)) {
    if(var_38d97d58.callback == # "hash_2bfb881b2d0ed7f7") {
      if(namespace_c8e236da::function_295a2a9e(#"hash_6b58b12eb08e0288")) {
        namespace_c8e236da::function_bf642b41(0);
      }

      if(!namespace_c8e236da::function_295a2a9e(#"hash_2d06159224a47a18")) {
        namespace_c8e236da::function_abdf062(0, #"hash_2d06159224a47a18");
      }
    } else {
      if(namespace_c8e236da::function_295a2a9e(#"hash_2d06159224a47a18")) {
        namespace_c8e236da::function_bf642b41(0);
      }

      if(!namespace_c8e236da::function_295a2a9e(#"hash_6b58b12eb08e0288")) {
        namespace_c8e236da::function_abdf062(0, #"hash_6b58b12eb08e0288");
      }
    }
  } else if(namespace_c8e236da::function_295a2a9e(#"hash_6b58b12eb08e0288") || namespace_c8e236da::function_295a2a9e(#"hash_2d06159224a47a18")) {
    namespace_c8e236da::function_bf642b41(0);
  }

  if(oldindex >= 0) {
    namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", oldindex, "IsNew", 0);
  }

  if(is_true(var_38d97d58.isunlocked)) {
    collectibles::function_55fb73ea(evidence.var_8ca1d4a, var_38d97d58.var_2a51713);
  }

  player thread function_1ec0078f(newindex, blackboard);
}

function private function_57c5b410(index) {
  player = self;
  assert(isPlayer(player));
  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;
  assert(isDefined(blackboard.var_c5bde695));
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];
  assert(isDefined(evidence.var_dade7c7f) && isDefined(evidence.var_dade7c7f[index]));
  var_38d97d58 = evidence.var_dade7c7f[index];

  if(is_true(var_38d97d58.isunlocked) && collectibles::function_606a97af(var_38d97d58.callback)) {
    player notify(#"evidence_board_evidence_callback_execute");
  }
}

function private function_5ad666ce() {
  player = self;
  assert(isPlayer(player));
  player notify(#"evidence_board_review_unselected");
}

function private function_1ec0078f(index, blackboard) {
  player = self;
  assert(isPlayer(player));
  self notify("79e3bb6b157e8ca7");
  self endon("79e3bb6b157e8ca7");
  player endon(#"death", #"hash_206b23ce56f8caf7");
  evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];

  if(isDefined(blackboard.var_bcd1e3f9)) {
    data = evidence.var_dade7c7f[blackboard.var_bcd1e3f9];
    function_aa81758f(data, 1);
  }

  data = evidence.var_dade7c7f[index];
  function_aa81758f(data, 0);
}

function private function_3db40935(params) {
  player = self;
  assert(isPlayer(player));
  player endon(#"death");
  player notify(#"hash_3ac28b014653cac6");

  player function_d530ce5a();

  statemachine = player function_1bb19090();
  blackboard = statemachine.blackboard;

  if(player function_a997529d()) {
    blackboard.var_1bfff22b hide();
    player notify(#"hash_206b23ce56f8caf7");
    evidence = blackboard.var_3cb3ede5[blackboard.var_c5bde695];

    if(isDefined(blackboard.var_bcd1e3f9)) {
      data = evidence.var_dade7c7f[blackboard.var_bcd1e3f9];
      function_aa81758f(data, 1);
    }

    if(evidence.var_1ca68c21) {
      var_4eaf209f = 0;

      foreach(var_38d97d58 in evidence.var_dade7c7f) {
        if(collectibles::function_ee216b9e(evidence.var_8ca1d4a, var_38d97d58.var_2a51713)) {
          var_4eaf209f = 1;
          break;
        }
      }

      evidence.var_1ca68c21 = var_4eaf209f;
    }

    assert(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0"));
    namespace_61e6d095::remove(#"hash_afc09dfd34bcde0");
    blackboard.var_bcd1e3f9 = undefined;
    player clientfield::set_to_player("eboard_review_handle_viewmodel", 0);
    namespace_c8e236da::removelist();
    waitframe(1);
    return;
  }

  if(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
    namespace_61e6d095::function_73c9a490(#"hash_afc09dfd34bcde0", 0);
  }
}

function private function_aa81758f(var_520cb95d, isvisible) {
  assert(isDefined(var_520cb95d.isunlocked));

  if(var_520cb95d.isunlocked) {
    var_afbac09f = getent(var_520cb95d.tagname, "script_noteworthy");

    if(isDefined(var_afbac09f)) {
      if(isvisible) {
        var_afbac09f show();
        return;
      }

      var_afbac09f hide();
    }
  }
}

function private function_b3f7df56(var_38d97d58) {
  player = getplayers()[0];
  player endon(#"death");
  assert(isDefined(var_38d97d58.var_5eeb1ad0));
  namespace_c8e236da::function_ebf737f8(#"hash_412ac8802ccc592d");
  namespace_61e6d095::create(#"hash_2ee86a814f89b7c1", #"hash_6ad4f1126c3ec0e1");
  namespace_61e6d095::function_d3c3e5c3(#"hash_2ee86a814f89b7c1", #"interactive_map");
  namespace_61e6d095::function_9ade1d9b(#"hash_2ee86a814f89b7c1", "title", var_38d97d58.var_812bb4e9, 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_2ee86a814f89b7c1", "subtitle", var_38d97d58.var_305bd749, 0);
  namespace_61e6d095::function_9ade1d9b(#"hash_2ee86a814f89b7c1", "text", var_38d97d58.var_5eeb1ad0, 0);
  namespace_61e6d095::function_b0bad5ff();
  namespace_61e6d095::remove(#"hash_2ee86a814f89b7c1");
}

function private function_e14ba795() {
  player = self;
  assert(isPlayer(player));
  player endon(#"death", #"hash_3ac28b014653cac6");
  level endon(#"flag_player_using_evidence_board");

  while(true) {
    while(player namespace_61e6d095::function_70217795()) {
      waitframe(1);
    }

    player namespace_61e6d095::function_b0bad5ff(undefined, "flag_player_using_evidence_board");
    player notify(#"eboard_exit_current_menu");
    wait 0.5;
  }
}

function function_5f8cfb0f(var_88e62a80) {
  if(self gamepadusedlast()) {
    namespace_c8e236da::function_ebf737f8(#"hash_1bf05148cc28df3c");
  }

  self thread function_f1d97432(var_88e62a80);
}

function function_f1d97432(var_88e62a80) {
  self endon(#"death", #"evidence_board_closed", #"eboard_exit_current_menu", #"evidence_board_review_selected");
  isusinggamepad = self gamepadusedlast();

  while(true) {
    var_92e26cfc = self gamepadusedlast();

    if(var_92e26cfc != isusinggamepad) {
      isusinggamepad = var_92e26cfc;

      if(isusinggamepad) {
        if(!namespace_c8e236da::function_295a2a9e(#"hash_1bf05148cc28df3c")) {
          namespace_c8e236da::function_abdf062(var_88e62a80, #"hash_1bf05148cc28df3c");
        }
      } else if(namespace_c8e236da::function_295a2a9e(#"hash_1bf05148cc28df3c")) {
        namespace_c8e236da::function_bf642b41(var_88e62a80);
      }
    }

    waitframe(1);
  }
}

function private function_fc845aca() {
  player = self;
  assert(isPlayer(player));

  if(is_true(level.var_47df5f11)) {
    statemachine = player function_1bb19090();
    println("<dev string:x31f>" + statemachine.current_state.name);
  }
}

function private function_d530ce5a() {
  player = self;
  assert(isPlayer(player));

  if(is_true(level.var_47df5f11)) {
    statemachine = player function_1bb19090();
    println("<dev string:x33a>" + statemachine.current_state.name);
  }
}