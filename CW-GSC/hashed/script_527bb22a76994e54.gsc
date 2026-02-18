/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_527bb22a76994e54.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_35ae72be7b4fec10;
#using script_4052585f7ae90f3a;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\ui\interactive_map;
#using scripts\cp_common\util;
#namespace namespace_cd80be1c;

function function_107f09b() {
  level.var_c1ef80d2 = spawnStruct();
  var_fe5aa0de = getscriptbundle(#"evidenceboardlist");
  var_67e21ca2 = var_fe5aa0de.var_48be729c;
  var_3cb3ede5 = [];

  foreach(var_839fe80a in var_67e21ca2) {
    if(isDefined(var_839fe80a.var_8ca1d4a)) {
      if(isDefined(var_839fe80a.collectiblelist)) {
        collectibles = var_839fe80a.collectiblelist;
        var_839fe80a.var_9c01f410 = [];
        var_839fe80a.var_dade7c7f = [];

        foreach(k, v in collectibles) {
          collectible = getscriptbundle(v.collectible);
          var_839fe80a.var_9c01f410[k] = collectible;

          if(collectible.var_4292acd3 === 1) {
            if(!isDefined(var_839fe80a.var_dade7c7f)) {
              var_839fe80a.var_dade7c7f = [];
            } else if(!isarray(var_839fe80a.var_dade7c7f)) {
              var_839fe80a.var_dade7c7f = array(var_839fe80a.var_dade7c7f);
            }

            var_839fe80a.var_dade7c7f[var_839fe80a.var_dade7c7f.size] = collectible;
          }
        }
      }

      var_3cb3ede5[var_839fe80a.var_8ca1d4a] = var_839fe80a;
    }
  }

  level.var_3cb3ede5 = var_3cb3ede5;
}

function function_49ddbbf1(player, var_f587343a) {
  var_f587343a.var_e6eca916 = player getlightingstate();
  level function_9b006527(var_f587343a);
  var_f587343a.mdl_bulb_left = getent("mdl_bulb_left", "script_noteworthy");
  var_f587343a.mdl_bulb_right = getent("mdl_bulb_right", "script_noteworthy");
  var_f587343a.var_82d1fb6b = getEntArray("hub_hidden_mdl", "targetname");
  s_pos = struct::get("evidence_board_player_pos", "targetname");

  if(!isDefined(var_f587343a.var_bb194ec6)) {
    var_f587343a.var_bb194ec6 = util::spawn_model("tag_origin", s_pos.origin + (0, 0, -60), s_pos.angles);
  }

  var_f587343a.var_fa32835f = 0.75;
  var_f587343a.var_27d52210 = 0.5;
  var_f587343a.var_d0401fc8 = 0.5;
  var_f587343a.var_61992e19 = undefined;
  var_f587343a.var_c311ad4d = undefined;
  var_f587343a.var_bb88df0e = undefined;
  var_f587343a.var_ec2b6ba1 = undefined;
  var_f587343a.var_c2a4938f = undefined;
  var_f587343a.var_c72514a7 = undefined;
  var_f587343a.var_c6a7eb4e = undefined;
  var_f587343a.var_a3ae6fbc = -16;
  var_f587343a.var_d3f12b87 = 0.05;
  var_f587343a.var_17178bb3 = 0.2;
  return var_f587343a;
}

function function_3fc4da12(var_8ced85ea, var_1789c41) {
  var_f587343a = spawnStruct();
  a_ents = level function_85303021(var_8ced85ea);
  var_f587343a.a_triggers = [];

  foreach(e in a_ents) {
    if(e.classname == "trigger_multiple") {
      var_f587343a.a_triggers[var_f587343a.a_triggers.size] = e;
      continue;
    }

    e show();
  }

  level.player flag::wait_till(level.var_d7d201ba);

  if(isDefined(var_1789c41)) {
    level waittill(var_1789c41);
  }

  level thread function_d812ff0b();

  while(true) {
    self thread function_a1353526();
    var_21de0571 = struct::get("hint_evidence_board", "targetname");
    level.var_8c892633 = util::spawn_model("tag_origin", var_21de0571.origin);
    level.var_8c892633 util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_400e97432023f9f3", 160);
    level.player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 0);
    level.player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", 0);
    level.var_8c892633 waittill(#"trigger");
    level thread namespace_4ed3ce47::function_d2bce2b8();
    thread namespace_4ed3ce47::duck_evidence_board_enter();
    level flag::set("flag_player_used_evidence_board");
    level flag::set("flag_player_using_evidence_board");

    foreach(var_3d43d7b8 in level.a_ai_allies) {
      if(isDefined(var_3d43d7b8[0])) {
        var_3d43d7b8[0] notify(#"kill_dialog");
      }
    }

    level function_49ddbbf1(self, var_f587343a);
    self hide();
    level thread function_16c9cb0a();
    self function_1e3889e5(var_f587343a);
    level.player thread clientfield::set_to_player("set_hub_fov", 4);
    level.player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 1);
    level.player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_overview", 1);
    self function_836e2594(var_f587343a);
    waitframe(1);
    self function_a69227f8(var_f587343a);
    wait 2;
  }
}

function function_12259d55(var_62bce5b6) {
  level notify(#"evidence_board_mission_selected");
}

function function_efa71f22(var_62bce5b6) {
  return !namespace_61e6d095::should_hide(#"interactive_map");
}

function function_a69227f8(var_f587343a) {
  level endon(#"evidence_board_closed");
  level.var_f587343a = var_f587343a;
  self interactive_map::open(#"hash_79bcfa1ce8d9fd7f", undefined, undefined, 0, undefined, undefined, undefined, undefined, undefined, 1);
  self interactive_map::function_59b2a130(var_f587343a.a_triggers);
  self interactive_map::function_879505e1(1, #"hash_181a347630cebe70");
  self interactive_map::function_835fb58e(1);
  self interactive_map::function_23036faa(#"cursor", "year", 0);
  self interactive_map::function_23036faa(#"cursor", "player", #"");
  self interactive_map::function_23036faa(#"cursor", "progress", 0);
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_1bf05148cc28df3c");
  namespace_c8e236da::function_ebf737f8(#"hash_3525b00a38f72def");

  if(!self gamepadusedlast()) {
    setDvar(#"ui_busyblockingamemenu", 1);
  }

  var_96b6affa = {
    #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_6c7bb285599937ba", #complete_callback: &function_12259d55, #var_be77841a: 0, #var_531201f1: &function_efa71f22
  };

  foreach(trigger in var_f587343a.a_triggers) {
    trigger.var_f90e2591 = &function_e976f5d3;
    trigger.var_938b0e9b = &function_cab79d7e;
    trigger.var_d9b5c896 = level.var_3cb3ede5[trigger.script_noteworthy].levelname;
    trigger.var_94ca2a30 = level.var_3cb3ede5[trigger.script_noteworthy].var_2dd3e7b0;
    trigger interactive_map::function_b5c2702b(#"confirm", var_96b6affa);
  }

  self thread function_6f86dee1(var_f587343a);
  self thread function_472dcec7(var_f587343a);

  while(true) {
    self setstance("stand");
    self allowprone(0);
    self allowcrouch(0);
    self util::delay(var_f587343a.var_fa32835f, undefined, &function_33c1dc6d);
    level waittill(#"hash_3e8dc841ce47f8fd");
    level thread namespace_4ed3ce47::function_f60575fd();
    level.player thread clientfield::set_to_player("set_hub_fov", 4);
    self thread function_a6052025(2);
    level scene::stop("scene_hub_eboard_handler");
    self util::delay(var_f587343a.var_fa32835f, undefined, &function_a6052025, 28);
  }
}

function function_e976f5d3() {
  level.var_8d26dee2 = self.script_noteworthy;
  level thread function_be29d21d(level.var_f587343a);
  evidence = level.var_3cb3ede5[level.var_8d26dee2];

  if(isDefined(evidence)) {
    interactive_map::function_23036faa(#"cursor", "year", evidence.var_2200aced);
    interactive_map::function_23036faa(#"cursor", "player", evidence.LevelPresence);
    interactive_map::function_23036faa(#"cursor", "progress", 0.4);
  }

  level flag::set("flag_cursor_over_mission");
  level thread namespace_4ed3ce47::function_7edafa59("evidence_board_mission");
}

function function_cab79d7e() {
  interactive_map::function_23036faa(#"cursor", "year", 0);
  interactive_map::function_23036faa(#"cursor", "player", #"");
  interactive_map::function_23036faa(#"cursor", "progress", 0);
  level notify(#"hash_7c11efb940bfa7e2");
  level thread namespace_4ed3ce47::function_7edafa59("evidence_board_main");
  level flag::clear("flag_cursor_over_mission");
}

function function_836e2594(var_f587343a) {
  var_aec08bc5 = 0.25;
  var_802a1814 = 0.5;
  self playerlinktoblend(var_f587343a.var_bb194ec6, "tag_origin", var_f587343a.var_fa32835f, var_aec08bc5, var_802a1814, var_f587343a.var_fa32835f, var_aec08bc5, var_802a1814);
  wait var_f587343a.var_fa32835f;
  waitframe(1);
  v_player_pos = self getplayercamerapos();
  v_player_angles = self getplayerangles();
  self camerasetposition(v_player_pos, v_player_angles);
  self cameraactivate(1);
}

function function_a6052025(var_6ed357c6) {
  self clientfield::set_to_player("eboard_camera_position", var_6ed357c6);
}

function function_33c1dc6d() {
  level endon(#"evidence_board_closed");
  level endon(#"evidence_board_mission_selected");

  while(!self namespace_61e6d095::function_57fbd346()) {
    waitframe(1);
  }

  namespace_c8e236da::removelist();
  self.var_65558489 = 1;
  self.var_c2b6a937 = 1;
  level notify(#"evidence_board_closed");
}

function function_be29d21d(var_f587343a) {
  level endon(#"hash_7c11efb940bfa7e2");
  level endon(#"evidence_board_mission_selected");
  level endon(#"evidence_board_closed");
  n_offset = -2;
  e_parent = getent(level.var_8d26dee2 + "_parent", "targetname");
  var_4c91fb99 = e_parent.origin;

  foreach(mdl in var_f587343a.var_82d1fb6b) {
    if(isDefined(mdl.groupname) && mdl.groupname == "eboard_" + level.var_8d26dee2) {
      mdl linkto(e_parent);
    }
  }

  level thread function_8ce19d62(e_parent, var_4c91fb99);

  if((isDefined(level.var_f5552371) ? level.var_f5552371 : "") != "post_kgb" && level.var_8d26dee2 == "cp_nic_revolucion") {
    return;
  }

  var_eaea54da = (e_parent.origin[0], e_parent.origin[1] + n_offset, e_parent.origin[2]);
  e_parent moveto((var_eaea54da[0], var_eaea54da[1], var_eaea54da[2]), 0.01);
}

function function_8ce19d62(e_parent, var_4c91fb99) {
  level endon(#"hash_3e8dc841ce47f8fd");
  level waittill(#"evidence_board_mission_selected", #"hash_7c11efb940bfa7e2", #"evidence_board_closed");
  e_parent.origin = var_4c91fb99;
}

function function_1e3889e5(var_f587343a) {
  return var_f587343a;
}

function function_6f86dee1(var_f587343a) {
  level endon(#"evidence_board_closed");
  var_f5cadbe8 = (0, 0, -60);

  while(true) {
    level waittill(#"evidence_board_mission_selected");
    level thread namespace_4ed3ce47::function_6fe99ae0();
    self thread function_f961cba6(var_f587343a);
    self thread function_c23b1611();
    waitframe(1);
    self thread function_487cf276(var_f587343a);
    self thread function_bc88736c(var_f587343a);
    wait var_f587343a.var_27d52210;
  }
}

function function_c23b1611() {
  level endon(#"evidence_board_closed");
  evidence = level.var_3cb3ede5[level.var_8d26dee2];
  namespace_61e6d095::function_df0d7a85(#"hash_3ccc1702bc979da8", [# "interactive_map"]);

  if(!namespace_61e6d095::exists(#"hash_3ccc1702bc979da8")) {
    namespace_61e6d095::create(#"hash_3ccc1702bc979da8", #"hash_4130605c2e66825d");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "AlignRight", 1);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "MapName", "");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "Year", 0);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelName", #"");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LongDescription", #"");
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelPresence", #"");
    var_9f97b0c5 = isDefined(evidence.AlignRight) && evidence.AlignRight == 1;
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "AlignRight", var_9f97b0c5);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "MapName", level.var_8d26dee2);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "Year", evidence.var_2200aced);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelName", evidence.levelname);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LongDescription", evidence.var_47b1727b);
    namespace_61e6d095::function_9ade1d9b(#"hash_3ccc1702bc979da8", "LevelPresence", evidence.LevelPresence);

    foreach(index, var_e8c1b531 in evidence.var_4458275e) {
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "IsPrimaryObjective", var_e8c1b531.IsPrimaryObjective === 1);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "Index", var_e8c1b531.itemindex);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "Title", var_e8c1b531.title);
    }

    if(isDefined(evidence.var_dade7c7f)) {
      var_68c47b96 = 9;
      index = evidence.var_4458275e.size + 1;
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "IsPrimaryObjective", 0);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "Index", index);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "Count", evidence.var_dade7c7f.size);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "EvidenceCollectedCount", var_68c47b96);
      namespace_61e6d095::function_f2a9266(#"hash_3ccc1702bc979da8", index, "Title", #"");
    }
  }

  namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 1);
  waitframe(3);
  self thread function_6baebf65();
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_1bf05148cc28df3c");
  namespace_c8e236da::function_ebf737f8(#"hash_3525b00a38f72def");
  level waittill(#"hash_3e8dc841ce47f8fd");

  if(namespace_61e6d095::exists(#"hash_3ccc1702bc979da8")) {
    namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 0);
    namespace_61e6d095::remove(#"hash_3ccc1702bc979da8");
  }
}

function function_c469b424() {
  level endon(#"evidence_board_closed", #"hash_3e8dc841ce47f8fd");

  if(!namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
    namespace_61e6d095::create(#"hash_afc09dfd34bcde0", #"hash_102694e2bfda6f95");
  }

  namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "LevelName", #"");
  evidence = level.var_3cb3ede5[level.var_8d26dee2];
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_ebf737f8(#"hash_1bf05148cc28df3c");
  namespace_c8e236da::function_ebf737f8(#"hash_3525b00a38f72def");

  if(isDefined(evidence.var_dade7c7f)) {
    foreach(index, collectible in evidence.var_dade7c7f) {
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Title", collectible.title);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "SubTitle", collectible.subtitle);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Description", collectible.description);
      namespace_61e6d095::function_f2a9266(#"hash_afc09dfd34bcde0", index, "Thumbnail", collectible.thumbnail);
    }

    namespace_61e6d095::function_73c9a490(#"hash_afc09dfd34bcde0", 1);
    namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "text", evidence.levelname);
    namespace_c8e236da::function_ebf737f8(#"hash_5b42bcce1de4f193");
    namespace_c8e236da::function_ebf737f8(#"hash_480d246174c7faa7");
  }
}

function function_f961cba6(var_f587343a) {
  evidence = level.var_3cb3ede5[level.var_8d26dee2];

  if(isDefined(evidence.var_89616eaa)) {
    level scene::play("scene_hub_eboard_handler", evidence.var_89616eaa);
  }

  if(isDefined(evidence.var_8f98dad8)) {
    level thread scene::play("scene_hub_eboard_handler", evidence.var_8f98dad8);
  }
}

function function_24ce8669() {
  level waittill(#"hash_3e8dc841ce47f8fd");
}

function function_6baebf65() {
  level endon(#"hash_3e8dc841ce47f8fd");
  level thread function_c38c0276();
}

function function_c38c0276() {
  level endon(#"hash_3e8dc841ce47f8fd");

  while(true) {
    option = level waittill(#"evidence_board_option_selected");

    if(option.optindex == 1) {
      level notify(#"evidence_board_review_selected");
      break;
    }

    if(option.optindex == 2) {
      level notify(#"hash_3e8dc841ce47f8fd");
      continue;
    }

    iscomplete = is_true(savegame::function_6440b06b(#"persistent", level.var_8d26dee2).complete);

    if(iscomplete) {}

    savegame::function_81534803(#"transient", level.var_8d26dee2);
    load::function_c9154eb7(level.var_8d26dee2);
  }
}

function function_487cf276(var_f587343a) {
  level endon(#"evidence_board_closed");

  while(true) {
    level waittill(#"evidence_board_review_selected");

    if(namespace_61e6d095::exists(#"hash_3ccc1702bc979da8")) {
      namespace_61e6d095::function_73c9a490(#"hash_3ccc1702bc979da8", 0);
      namespace_61e6d095::remove(#"hash_3ccc1702bc979da8");
    }

    var_75c8057d = 0;
    evidence = level.var_3cb3ede5[level.var_8d26dee2];

    if(isDefined(evidence.var_dade7c7f)) {
      var_75c8057d = evidence.var_dade7c7f.size;
    }

    if(var_75c8057d > 0) {
      thread function_c469b424();
      level flag::set("flag_review_mode_active");
      level.player clientfield::set_to_player("set_hub_dof", 5);
      level.player thread clientfield::set_to_player("set_hub_fov", 1);
      self thread function_72c0d712(var_75c8057d);
      var_f587343a.var_a83e0330 = spawn("script_model", (0, 0, 0));
      self function_f2dbcc31(0, var_f587343a);

      while(true) {
        self thread function_5c499dd2(var_f587343a);
        var_b7e306fc = level waittill(#"evidence_board_review_index_update", #"evidence_board_review_unselected");

        if(isDefined(var_b7e306fc._notify) && var_b7e306fc._notify == "evidence_board_review_index_update") {
          var_f587343a = function_f2dbcc31(var_b7e306fc.selected_index, var_f587343a);
          wait 0.4;
        }

        if(isDefined(var_b7e306fc._notify) && var_b7e306fc._notify == "evidence_board_review_unselected") {
          level util::delay(0.2, undefined, &flag::clear, "flag_review_mode_active");
          level.player clientfield::set_to_player("set_hub_dof", 4);
          level function_cd10e6da(var_f587343a);

          if(namespace_61e6d095::exists(#"hash_afc09dfd34bcde0")) {
            namespace_61e6d095::function_73c9a490(#"hash_afc09dfd34bcde0", 0);
            namespace_61e6d095::remove(#"hash_afc09dfd34bcde0");
          }

          namespace_c8e236da::removelist();
          var_f587343a.currentindex = 0;
          level notify(#"evidence_board_mission_selected");
          return;
        }
      }

      continue;
    }

    level notify(#"hash_3e8dc841ce47f8fd");
  }
}

function private function_f2dbcc31(index, var_f587343a) {
  evidence = level.var_3cb3ede5[level.var_8d26dee2];

  if(isDefined(evidence.var_dade7c7f)) {
    if(isDefined(var_f587343a.currentindex)) {
      data = evidence.var_dade7c7f[var_f587343a.currentindex];
      var_e55e330a = getent(data.tagname, "script_noteworthy");
      var_e55e330a show();
    }

    data = evidence.var_dade7c7f[index];
    var_f587343a.var_101ef952 = getent(data.tagname, "script_noteworthy");
    var_f587343a.var_9c56f5af = data.uimodel;
    var_f587343a.currentindex = index;

    if(isDefined(var_f587343a.var_101ef952)) {
      var_f587343a.var_101ef952 hide();
    }

    if(isDefined(var_f587343a.var_9c56f5af)) {
      var_f587343a.var_a83e0330 setModel(var_f587343a.var_9c56f5af);
      var_f587343a.var_a83e0330 clientfield::set("eboard_review_handle_viewmodel", 1);
    }

    return var_f587343a;
  }

  return var_f587343a;
}

function function_5c499dd2(var_f587343a) {}

function private function_72c0d712(var_75c8057d) {
  level endon(#"evidence_board_closed");
  left_pressed = 0;
  right_pressed = 0;
  selected = 0;
  old_selected = undefined;
  var_ac545d74 = 0;
  player = getplayers()[0];
  namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "count", 0);

  while(true) {
    if(self namespace_61e6d095::function_57fbd346()) {
      level notify(#"evidence_board_review_unselected");
      break;
    }

    if(old_selected !== selected) {
      namespace_61e6d095::function_9ade1d9b(#"hash_afc09dfd34bcde0", "count", selected);
      level notify(#"evidence_board_review_index_update", {
        #selected_index: selected
      });
      old_selected = selected;
    }

    if(gettime() - var_ac545d74 > 250) {
      left_pressed = 0;
      right_pressed = 0;
    }

    left_right = util::function_b5338ccb(player getnormalizedmovement()[1], 0.2);

    if(!left_pressed) {
      if(player actionslotthreebuttonPressed() || left_right < 0) {
        left_pressed = 1;
        var_ac545d74 = gettime();
        selected--;
      }
    } else if(!player actionslotthreebuttonPressed() && left_right >= 0) {
      left_pressed = 0;
    }

    if(!right_pressed) {
      if(player actionslotfourbuttonPressed() || left_right > 0) {
        right_pressed = 1;
        var_ac545d74 = gettime();
        selected++;
      }
    } else if(!player actionslotfourbuttonPressed() && left_right <= 0) {
      right_pressed = 0;
    }

    selected = function_c3f8fae7(selected, var_75c8057d);
    waitframe(1);
  }
}

function private function_c3f8fae7(selected, var_834d338d) {
  if(selected < 0) {
    selected = 0;
  }

  if(selected >= var_834d338d) {
    selected = var_834d338d - 1;
  }

  return selected;
}

function function_85303021(var_8ced85ea) {
  switch (var_8ced85ea) {
    case # "post_takedown":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 0);
      break;
    case # "post_armada":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 0);
      break;
    case # "post_yamantau":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 1, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 0);
      break;
    case # "post_kgb":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1);
      break;
    case # "post_cuba":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1);
      break;
    case # "post_prisoner":
      a_ents = level function_f2f0bdcc("cp_nic_revolucion", 0, "cp_takedown", 1, "cp_nam_armada", 1, "cp_ger_stakeout", 1, "cp_rus_amerika", 1, "cp_rus_yamantau", 1, "cp_rus_kgb", 1);
      break;
    default:

      iprintlnbold("<dev string:x38>");

      break;
  }

  return a_ents;
}

function function_f2f0bdcc(var_cb423287, var_140c4b11, var_9cff5602, var_f6d510a3, var_b0be7d80, var_967b5c8, var_827f2102, var_db29594c, var_55a44785, var_edf4fee3, var_65e66809, var_af8d8215, var_b0ec7de4, var_c25e27b6, var_822d2066, var_94f3cce2, var_540e4421, var_76bb9072, var_22363af9, var_70ab949a) {
  a_ents = [];

  if(isDefined(var_cb423287) && isDefined(var_140c4b11)) {
    a_ents = function_e0cf12d6(a_ents, var_cb423287, var_140c4b11);
  }

  if(isDefined(var_9cff5602) && isDefined(var_f6d510a3)) {
    a_ents = function_e0cf12d6(a_ents, var_9cff5602, var_f6d510a3);
  }

  if(isDefined(var_b0be7d80) && isDefined(var_967b5c8)) {
    a_ents = function_e0cf12d6(a_ents, var_b0be7d80, var_967b5c8);
  }

  if(isDefined(var_827f2102) && isDefined(var_db29594c)) {
    a_ents = function_e0cf12d6(a_ents, var_827f2102, var_db29594c);
  }

  if(isDefined(var_55a44785) && isDefined(var_edf4fee3)) {
    a_ents = function_e0cf12d6(a_ents, var_55a44785, var_edf4fee3);
  }

  if(isDefined(var_65e66809) && isDefined(var_af8d8215)) {
    a_ents = function_e0cf12d6(a_ents, var_65e66809, var_af8d8215);
  }

  if(isDefined(var_b0ec7de4) && isDefined(var_c25e27b6)) {
    a_ents = function_e0cf12d6(a_ents, var_b0ec7de4, var_c25e27b6);
  }

  if(isDefined(var_822d2066) && isDefined(var_94f3cce2)) {
    a_ents = function_e0cf12d6(a_ents, var_822d2066, var_94f3cce2);
  }

  if(isDefined(var_540e4421) && isDefined(var_76bb9072)) {
    a_ents = function_e0cf12d6(a_ents, var_540e4421, var_76bb9072);
  }

  if(isDefined(var_22363af9) && isDefined(var_70ab949a)) {
    a_ents = function_e0cf12d6(a_ents, var_22363af9, var_70ab949a);
  }

  return a_ents;
}

function function_e0cf12d6(a_ents, var_bdf4b952, n_state) {
  var_6711328d = getEntArray("mdl_" + var_bdf4b952 + "_first_items", "script_noteworthy");

  foreach(e in var_6711328d) {
    a_ents[a_ents.size] = e;
  }

  switch (var_bdf4b952) {
    case # "cp_takedown":
      t = getent("cp_takedown", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        break;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_takedown" + "_cluster", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_03", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_04", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_05", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_06", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_07", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_08", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_takedown_item_09", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_nam_armada":
      t = getent("cp_nam_armada", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        e = getent("mdl_" + "cp_nam_armada" + "_string_red", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_label_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_label_next_bottom", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_bg_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_1", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_2", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_3", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_5", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_nam_armada" + "_1", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_2", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_3", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_4", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_5", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_string_white", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_label", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_armada" + "_bg", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_ger_stakeout":
      t = getent("cp_ger_stakeout", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        e = getent("mdl_" + "cp_ger_stakeout" + "_cluster", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_03", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_04", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_05", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_06", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_07", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_08", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_ger_stakeout" + "_cluster", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_03", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_04", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_05", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_06", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_07", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_ger_stakeout_item_08", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_rus_amerika":
      t = getent("cp_rus_amerika", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        break;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_rus_amerika" + "_cluster", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_03", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_04", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_05", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_06", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_07", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_08", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_09", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_10", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_amerika_item_11", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_rus_yamantau":
      t = getent("cp_rus_yamantau", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        e = getent("mdl_" + "cp_rus_yamantau" + "_string_red", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_label_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_label_next_bottom", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_bg_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_rus_yamantau" + "_1", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_3", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_string_white", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_label", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_bg", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_string_extra_white", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_nail_extra_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_rus_yamantau" + "_nail_extra_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_rus_kgb":
      t = getent("cp_rus_kgb", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        e = getent("mdl_" + "cp_rus_kgb" + "_cluster", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_01", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_02", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_03", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_04", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_05", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_06", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_07", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_08", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_09", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_10", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_11", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_cp_rus_kgb_item_12", "script_noteworthy");
        a_ents[a_ents.size] = e;
      }

      if(n_state != 0) {
        break;
      } else {
        break;
      }
    case # "cp_nic_revolucion":
      if((isDefined(level.var_f5552371) ? level.var_f5552371 : "") == "post_kgb") {
        t = getent("cp_nic_revolucion", "script_noteworthy");
        a_ents[a_ents.size] = t;
      }

      if(n_state == 0) {
        e = getent("mdl_" + "cp_nic_revolucion" + "_string_red", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_label_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_label_next_bottom", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_bg_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_nic_revolucion" + "_2", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_4", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_string_white", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_label", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nic_revolucion" + "_bg", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    case # "cp_nam_prisoner":
      t = getent("cp_nam_prisoner", "script_noteworthy");
      a_ents[a_ents.size] = t;

      if(n_state == 0) {
        e = getent("mdl_" + "cp_nam_prisoner" + "_string_red", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_label_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_label_next_bottom", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_bg_next", "script_noteworthy");
        a_ents[a_ents.size] = e;
      }

      if(n_state != 0) {
        e = getent("mdl_" + "cp_nam_prisoner" + "_1", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_2", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_3", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_string_white", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_label", "script_noteworthy");
        a_ents[a_ents.size] = e;
        e = getent("mdl_" + "cp_nam_prisoner" + "_bg", "script_noteworthy");
        a_ents[a_ents.size] = e;
        break;
      } else {
        break;
      }
    default:

      iprintlnbold("<dev string:x7a>");

      break;
  }

  return a_ents;
}

function function_472dcec7(var_f587343a) {
  level waittill(#"evidence_board_closed");
  namespace_61e6d095::function_f96376c5(#"hash_3ccc1702bc979da8");
  interactive_map::close();
  setDvar(#"ui_busyblockingamemenu", 0);
  self thread function_c03c56f4(var_f587343a);
  level thread function_a40a2b20();
  level thread namespace_4ed3ce47::function_dd520714();
  thread namespace_4ed3ce47::duck_evidence_board_exit();
  self thread clientfield::set_to_player("set_hub_fov", 2);
  level.player thread clientfield::set_to_player("pstfx_t9_cp_hub_eboard_vignette", 0);
  wait var_f587343a.var_fa32835f;
  level flag::clear("flag_player_using_evidence_board");
  self show();
  self cameraactivate(0);
  waitframe(1);
  self unlink();
  self allowprone(1);
  self allowcrouch(1);
}

function function_d812ff0b() {
  while(true) {
    level waittill(#"hash_5b9b855ef17e6ca4");
    var_bfca66fd = level.var_8c892633.origin;
    level.var_8c892633.origin = (var_bfca66fd[0], var_bfca66fd[1], var_bfca66fd[2] - 2000);
    level waittill(#"hash_1745d1d7e74ea81b");
    level.var_8c892633.origin = var_bfca66fd;
  }
}

function function_a40a2b20() {
  level thread namespace_4ed3ce47::function_7edafa59("ambient");
}

function function_c03c56f4(var_f587343a) {
  var_f587343a.mdl_bulb_right setModel("p8_zm_zod_light_bulb_01_on");
  var_f587343a.mdl_bulb_left setModel("p8_zm_zod_light_bulb_01_on");
}

function function_bc88736c(var_f587343a) {
  level waittill(#"hash_3e8dc841ce47f8fd");

  switch (level.var_8d26dee2) {
    case # "cp_takedown":
      break;
    case # "cp_nam_armada":
      break;
    case # "cp_ger_stakeout":
      break;
    case # "cp_rus_amerika":
      break;
    case # "cp_rus_yamantau":
      break;
    case # "cp_rus_kgb":
      break;
    case # "cp_nic_revolucion":
      break;
  }

  level util::delay_notify(var_f587343a.var_27d52210, "evidence_board_mission_focus_in");
  level util::delay(var_f587343a.var_27d52210, undefined, &namespace_61e6d095::function_f96376c5, #"hash_3ccc1702bc979da8");
  level.player clientfield::set_to_player("set_hub_dof", 1);

  if(isDefined(var_f587343a.var_5e93e3a6)) {
    var_f587343a.var_5e93e3a6 delete();
  }

  if(isDefined(var_f587343a.var_a9b3741b)) {
    var_f587343a.var_a9b3741b delete();
  }
}

function function_cd10e6da(var_f587343a) {
  if(isDefined(var_f587343a.var_101ef952)) {
    var_f587343a.var_101ef952 show();
  }

  if(isDefined(var_f587343a.var_a83e0330)) {
    var_f587343a.var_a83e0330 delete();
  }
}

function function_9b006527(var_f587343a) {
  switch (isDefined(level.var_f5552371) ? level.var_f5552371 : "") {
    case # "post_takedown":
      break;
    case # "post_armada":
      break;
    case # "post_yamantau":
      break;
    case # "post_kgb":
      break;
    default:
      break;
  }

  return var_f587343a;
}

function function_a1353526() {
  level endon(#"evidence_board_closed");

  while(true) {
    s_result = level waittill(#"evidence_board_mission_selected", #"hash_3e8dc841ce47f8fd");

    switch (s_result._notify) {
      case # "evidence_board_mission_selected":
        level clientfield::set("eboard_notify_from_server", 1);
        break;
      case # "hash_3e8dc841ce47f8fd":
        level clientfield::set("eboard_notify_from_server", 2);
        break;
    }
  }
}

function function_16c9cb0a() {
  level thread namespace_4ed3ce47::function_7edafa59("evidence_board_main");
}