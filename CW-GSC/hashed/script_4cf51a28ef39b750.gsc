/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4cf51a28ef39b750.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_silver_pap_quest;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#namespace namespace_9d3ef6c5;

function private autoexec __init__system__() {
  system::register(#"hash_3c412421c33b7764", &preinit, undefined, undefined, undefined);
}

function preinit() {
  level.var_7ac95f85 = 1;
  level.var_a5a050c1 = 30;
  level.var_ce0f67cf = 5;
  level.var_e9737821 = &function_c52e8ba;
  level.var_d0fafce1 = 1;
  clientfield::register("scriptmover", "" + # "fasttravel_playfx", 1, 2, "int");
  callback::function_74872db6(&function_786c864d);
  level thread function_76138a38();
  level thread function_d794f3ac();
  level thread function_e663b61e();
  level thread function_9780725f();
  level thread function_ebb262ad();
  level thread function_ca8f3b73();
  level thread function_12f1a9dd();
  level thread function_b5f4f0c();
}

function function_9780725f() {
  level endon(#"end_game");
  level flag::wait_till("all_players_spawned");
  level flag::wait_till(level.var_5bfd847e);
  var_1d1bbd52 = struct::get_array("fasttravel_trigger", "targetname");

  foreach(s_loc in var_1d1bbd52) {
    if(isDefined(s_loc.unitrigger_stub.delay)) {
      s_loc.unitrigger_stub flag::delay_set(s_loc.unitrigger_stub.delay, "delayed");
    }
  }
}

function function_786c864d() {
  if(isDefined(level.var_3161430e) && level.round_number == level.var_3161430e + 10) {
    level flag::set(#"hash_268c943ffdd74fa");
  }
}

function function_c52e8ba(player, var_8d5d092c) {
  b_result = 0;

  if(!isDefined(self.hint_string)) {
    self.hint_string = [];
  }

  n_player_index = player getentitynumber();

  if(level flag::get(#"hash_322c7f92525e008e")) {
    self.hint_string[n_player_index] = # "";
  } else if(is_true(player.var_9c7b96ed[var_8d5d092c])) {
    self.hint_string[n_player_index] = # "hash_7667bd0f83307360";
    b_result = 1;
  } else if(level flag::get(#"hash_268c943ffdd74fa")) {
    if(is_true(level.var_fe6ca5e8)) {
      self.hint_string[n_player_index] = # "zombie/fasttravel_delay";
    } else {
      if(!player zm_score::can_player_purchase(self.stub.zombie_cost)) {
        player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
      }

      self.hint_string[n_player_index] = player zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
      b_result = 1;
    }
  } else if(!level flag::get(#"dark_aether_active")) {
    self.hint_string[n_player_index] = # "";
  } else if(!self zm_fasttravel::function_d06e636b(player) || player isswitchingweapons()) {
    self.hint_string[n_player_index] = # "";
  } else if(isDefined(self.stub.var_a92d1b24) && !level flag::get_all(self.stub.var_a92d1b24)) {
    self.hint_string[n_player_index] = # "";
  } else if(isDefined(self.stub.delay) && !self.stub flag::get("delayed")) {
    self.hint_string[n_player_index] = # "zombie/fasttravel_delay";
    b_result = 1;
  } else if(is_true(level.var_fe6ca5e8)) {
    self.hint_string[n_player_index] = # "zombie/fasttravel_delay";
  } else {
    switch (self.stub.script_string) {
      case # "hash_63156dac534aede7":
        hint_string = # "hash_1b5d024264e26e98";
        break;
      case # "hash_15d6fece382a5cbe":
        hint_string = # "hash_19ae69436c39da09";
        break;
      case # "fasttravel_loc_crash_site_down":
        hint_string = # "hash_3be004aaa3ef2edd";
        break;
      case # "hash_2b732b2cff505c84":
        hint_string = # "hash_5a1913d1fec350f9";
        break;
      case # "hash_5af6096260ab857c":
        hint_string = # "hash_5c514164da699bed";
        break;
      case # "fasttravel_loc_pond_down":
        hint_string = # "hash_5de92cc1bf44a38a";
        break;
      default:
        break;
    }

    if(isDefined(hint_string)) {
      if(!player zm_score::can_player_purchase(self.stub.zombie_cost)) {
        player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
      }

      self.hint_string[n_player_index] = hint_string;
    } else {
      if(!player zm_score::can_player_purchase(self.stub.zombie_cost)) {
        player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
      }

      self.hint_string[n_player_index] = player zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
    }

    b_result = 1;
  }

  return b_result;
}

function private function_76138a38() {
  level endon(#"end_game");
  function_130d4334();
  a_s_fasttravel = struct::get_array("fasttravel_trigger");

  foreach(s_fasttravel in a_s_fasttravel) {
    if(isDefined(s_fasttravel.target)) {
      a_ents = getEntArray(s_fasttravel.target, "targetname");
      array::run_all(a_ents, &hide);
    }
  }
}

function function_ebb262ad() {
  level endon(#"end_game");

  while(true) {
    level flag::wait_till(#"dark_aether_active");

    if(level flag::get(#"hash_268c943ffdd74fa")) {
      break;
    }

    level thread fasttravel_playFX();
    level flag::wait_till_clear(#"dark_aether_active");
    function_2b30b25d();
  }
}

function function_130d4334() {
  level endon(#"hash_268c943ffdd74fa");

  while(true) {
    level flag::wait_till(#"dark_aether_active");
    a_s_fasttravel = struct::get_array("fasttravel_trigger");

    foreach(s_fasttravel in a_s_fasttravel) {
      if(isDefined(s_fasttravel.target)) {
        a_ents = getEntArray(s_fasttravel.target, "targetname");
        array::run_all(a_ents, &hide);
      }
    }

    level flag::wait_till_clear(#"dark_aether_active");

    foreach(s_fasttravel in a_s_fasttravel) {
      if(isDefined(s_fasttravel.target)) {
        a_ents = getEntArray(s_fasttravel.target, "targetname");
        array::run_all(a_ents, &show);
      }
    }
  }
}

function private function_d794f3ac() {
  level endon(#"end_game");
  var_192a77dd = getent("medical_door", "targetname");
  var_192a77dd disconnectpaths();
  level waittill(#"hash_5674ed1aa008ba97");
  level flag::set("connect_zone_trans_north_pap_room_to_zone_trans_north");
  var_192a77dd connectpaths();
  var_ceb9f97e = struct::get("medical_door_shaft", "targetname");
  var_6e000a0e = util::spawn_model("tag_origin", var_ceb9f97e.origin, var_ceb9f97e.angles);
  var_192a77dd linkto(var_6e000a0e);
  var_6e000a0e playSound(#"hash_2bf666c2ef742d89");
  var_6e000a0e rotateto(var_6e000a0e.angles + (0, -120, 0), 1, 0.25, 0.25);
  var_6e000a0e waittill(#"rotatedone");

  if(isDefined(var_6e000a0e)) {
    var_6e000a0e delete();
  }
}

function private function_e663b61e() {
  level endon(#"end_game");
  var_8e0d050c = getent("armory_door", "targetname");
  var_a801f97d = getent(var_8e0d050c.target, "targetname");
  var_a801f97d disconnectpaths();
  level waittill(#"hash_426979dda15dd76f");
  level flag::set("connect_zone_trans_south_pap_room_to_zone_trans_south");
  var_a801f97d connectpaths();
  var_a801f97d linkto(var_8e0d050c);
  var_8e0d050c playSound(#"hash_2170098ce6c0016");
  var_8e0d050c moveto(var_8e0d050c.origin + (0, 0, 90), 2, 0.5, 0.5);
}

function function_12f1a9dd() {
  level endon(#"end_game");
  level waittill(#"hash_3e765c26047c9f54");
  function_2b30b25d();

  while(true) {
    var_bd1d9ca7 = 0;

    foreach(player in function_a1ef346b()) {
      if(is_true(player.var_16735873)) {
        var_bd1d9ca7++;
      }
    }

    if(var_bd1d9ca7 == 0) {
      break;
    }

    waitframe(1);
  }

  if(level.var_1cffd28c === 1) {
    var_7692d390 = getent("script_plane_collision", "targetname");
    var_7692d390 disconnectpaths();
    var_7692d390 solid();
    level scene::play(#"hash_2f425040d5e62683", "drop");
    level.var_1cffd28c = 0;
  }

  if(level.var_5a953d3d === 1) {
    truckcollision = getent("script_truck_collision", "targetname");
    truckcollision disconnectpaths();
    truckcollision solid();
    level scene::play(#"hash_3b239490a05b582e", "drop");
    level.var_5a953d3d = 0;
  }
}

function fasttravel_playFX() {
  level endon(#"dark_side_timeout", #"hash_61e8a39b3a4bee6a", #"end_game");
  a_s_fasttravel = struct::get_array("fasttravel_trigger");
  var_7f26d025 = 0;

  while(true) {
    foreach(s_fasttravel in a_s_fasttravel) {
      if(!isDefined(s_fasttravel.unitrigger_stub.b_play)) {
        if(level flag::get_all(s_fasttravel.unitrigger_stub.var_a92d1b24)) {
          var_b76ed368 = struct::get(s_fasttravel.unitrigger_stub.script_string, "targetname");

          if(!isDefined(s_fasttravel.unitrigger_stub.var_4eadb6a8)) {
            s_fasttravel.unitrigger_stub.var_4eadb6a8 = util::spawn_model("tag_origin", var_b76ed368.origin, (270, 0, 0));
          }

          if(s_fasttravel.var_d7a120b9 === "up") {
            s_fasttravel.unitrigger_stub.var_4eadb6a8 clientfield::set("" + # "fasttravel_playfx", 1);
          } else {
            s_fasttravel.unitrigger_stub.var_4eadb6a8 clientfield::set("" + # "fasttravel_playfx", 2);
          }

          s_fasttravel.unitrigger_stub.b_play = 1;
          s_fasttravel.n_obj_id = zm_utility::function_4a4cf79a(#"hash_2a0965272d69a37b", s_fasttravel.origin);
          var_7f26d025++;
        }
      }
    }

    if(var_7f26d025 === a_s_fasttravel.size) {
      break;
    }

    waitframe(1);
  }
}

function function_2b30b25d() {
  level endon(#"end_game");
  a_s_fasttravel = struct::get_array("fasttravel_trigger");

  foreach(s_fasttravel in a_s_fasttravel) {
    if(is_true(s_fasttravel.unitrigger_stub.b_play)) {
      if(isDefined(s_fasttravel.unitrigger_stub.var_4eadb6a8)) {
        s_fasttravel.unitrigger_stub.var_4eadb6a8 clientfield::set("" + # "fasttravel_playfx", 0);
        util::wait_network_frame();

        if(isDefined(s_fasttravel.unitrigger_stub.var_4eadb6a8)) {
          s_fasttravel.unitrigger_stub.var_4eadb6a8 delete();
        }
      }

      s_fasttravel.unitrigger_stub.b_play = undefined;

      if(isDefined(s_fasttravel.n_obj_id)) {
        zm_utility::function_bc5a54a8(s_fasttravel.n_obj_id);
      }
    }
  }
}

function function_ca8f3b73() {
  level flag::wait_till(#"hash_268c943ffdd74fa");
  level flag::wait_till_clear(#"dark_aether_active");
  wait 1;
  level thread fasttravel_playFX();
  level thread zm_silver_pap_quest::function_c1bd7e55();
  level thread zm_silver_pap_quest::function_40102053();
  level flag::wait_till(#"hash_322c7f92525e008e");
  function_2b30b25d();
}

function function_b5f4f0c() {
  level.var_a43447e4 = [];

  while(true) {
    s_notify = level waittill(#"fasttravel_bought");
    s_notify.player zm_vo::function_604084ea();

    if(!isDefined(level.var_a43447e4)) {
      level.var_a43447e4 = [];
    } else if(!isarray(level.var_a43447e4)) {
      level.var_a43447e4 = array(level.var_a43447e4);
    }

    if(!isinarray(level.var_a43447e4, s_notify.player)) {
      level.var_a43447e4[level.var_a43447e4.size] = s_notify.player;
    }

    s_notify.player thread function_8b483cee();
  }
}

function function_8b483cee() {
  self endon(#"disconnect");
  self waittill(#"fasttravel_finished");

  while(is_true(level.var_f6ea0657)) {
    waitframe(1);
  }

  arrayremovevalue(level.var_a43447e4, self);
}