/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_pap_quest.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_lockdown_util;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zodt8_pap_quest;

init() {
  clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int");
  clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int");
  clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int");
  level flag::init("pap_quest_complete");

  if(zm_custom::function_901b751c(#"zmpapenabled") == 0) {
    var_7156d2c4 = [];
    var_ce12b8d3 = array("stairs_pap_location", "poop_deck_pap_location", "engine_room_pap_location", "cargo_pap_location");

    foreach(var_d38ae9b1 in var_ce12b8d3) {
      var_7156d2c4 = arraycombine(var_7156d2c4, getEntArray(var_d38ae9b1, "prefabname"), 0, 0);
    }

    foreach(e_chunk in var_7156d2c4) {
      e_chunk hide();
    }

    return;
  }

  level.s_pap_quest = struct::spawn();
  level.s_pap_quest.a_s_locations = struct::get_array("pap_quest_interact");
  level.s_pap_quest.var_ac28fc4d = level.s_pap_quest.a_s_locations.size;
  level.s_pap_quest.var_be6e6f65 = 0;

  foreach(s_loc in level.s_pap_quest.a_s_locations) {
    level thread function_4d55584c(s_loc);
  }

  level.pack_a_punch.custom_power_think = &function_9b917fd5;

  if(!zm_utility::is_standard()) {
    level thread function_61748fa3();
  }

  if(zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    level thread function_62933c32();
  }

}

function_62933c32() {
  level waittill(#"initial_fade_in_complete");
  array::thread_all(level.s_pap_quest.a_s_locations, &function_d6076798, 1);

  if(!zm_utility::is_standard()) {
    level.s_pap_quest.var_4ee2e2ab = randomintrange(0, level.s_pap_quest.a_s_locations.size);
  }

  level flag::wait_till("start_zombie_round_logic");

  foreach(s_loc in level.s_pap_quest.a_s_locations) {
    s_loc.unitrigger_stub thread function_5c299a0f();
  }

  waitframe(1);
  function_1563bfc3();
}

function_4d55584c(s_loc) {
  s_loc.unitrigger_stub = spawnStruct();
  s_loc.unitrigger_stub.origin = s_loc.origin;
  s_loc.unitrigger_stub.angles = s_loc.angles;
  s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
  s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_loc.unitrigger_stub.script_width = 96;
  s_loc.unitrigger_stub.script_height = 96;
  s_loc.unitrigger_stub.script_length = 96;
  s_loc.unitrigger_stub.require_look_at = 0;
  s_loc.unitrigger_stub.target = s_loc.target;
  s_loc.unitrigger_stub.b_used = 0;
  s_loc.unitrigger_stub.prompt_and_visibility_func = &function_668e3f89;
  var_aa8a2a51 = getEntArray(s_loc.prefabname, "prefabname");

  foreach(var_402a204c in var_aa8a2a51) {
    if(var_402a204c iszbarrier()) {
      s_loc.unitrigger_stub.pap_machine = var_402a204c;
      continue;
    }

    s_loc.unitrigger_stub.var_d3a15d55 = var_402a204c;
  }

  s_loc.unitrigger_stub.var_d3a15d55 notsolid();
  hidemiscmodels(s_loc.prefabname);

  while(!level flag::exists("power_on")) {
    waitframe(1);
  }

  level flag::wait_till("power_on");
  s_loc thread function_d6076798();
}

function_d6076798(var_c41947a6 = 0) {
  if(isDefined(self.b_revealed) && self.b_revealed) {
    return;
  }

  self.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);

  if(var_c41947a6) {
    level flag::wait_till("start_zombie_round_logic");
  } else if(!zm_utility::is_standard()) {
    level waittill(self.prefabname);
  }

  self.b_revealed = 1;
  self.unitrigger_stub.var_d3a15d55 solid();
  showmiscmodels(self.prefabname);
  self.unitrigger_stub.pap_machine zm_pack_a_punch::set_state_initial();

  if(self.prefabname === "poop_deck_pap_location") {
    var_96bd0a5d = getent("poop_deck_PAP_box", "targetname");

    if(isDefined(var_96bd0a5d)) {
      var_96bd0a5d delete();
    }
  }

  if(!var_c41947a6) {
    self.unitrigger_stub.pap_machine pap_chunk_big_rune_on();
  }

  zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_3efad767);
  zm_unitrigger::function_c4a5fdf5(self.unitrigger_stub, 1);
  self thread function_11c3f280();
}

function_11c3f280() {
  while(true) {
    level waittill(#"pap_moved");

    if(level.s_pap_quest.a_s_locations[level.s_pap_quest.var_4ee2e2ab] == self) {
      zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
      continue;
    }

    if(!(isDefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered)) {
      zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_3efad767);
    }
  }
}

function_3efad767() {
  while(!(isDefined(self.stub.b_used) && self.stub.b_used)) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(player zm_utility::in_revive_trigger()) {
      continue;
    }

    if(player zm_utility::is_drinking()) {
      continue;
    }

    if(!zm_utility::is_player_valid(player)) {
      continue;
    }

    self.stub thread function_5c299a0f(player);
  }
}

function_5c299a0f(player) {
  level.s_pap_quest.var_be6e6f65++;
  self.b_used = 1;
  self.pap_machine.var_4a7b80c6 = 1;

  if(isDefined(player)) {
    player playrumbleonentity("zm_castle_interact_rumble");
  }

  for(i = 0; i < level.s_pap_quest.a_s_locations.size; i++) {
    if(!zm_utility::is_standard() && level.s_pap_quest.a_s_locations[i].unitrigger_stub == self) {
      level.s_pap_quest.var_4ee2e2ab = i;
    }
  }

  if(level.s_pap_quest.var_be6e6f65 < level.s_pap_quest.var_ac28fc4d) {
    if(isalive(player)) {
      player util::delay(0.5, "death", &zm_audio::create_and_play_dialog, #"altar", #"activate_generic");
    }
  } else {
    self.pap_machine function_214cd6b3();
    wait 1;
    level flag::set("pap_quest_complete");

    if(isalive(player)) {
      player util::delay(2.25, "death", &zm_audio::create_and_play_dialog, #"pap", #"activate");
    }

    return;
  }

  self.pap_machine function_214cd6b3();
}

function_214cd6b3() {
  self clientfield::set("pap_chunk_big_rune", 1);
  wait 1.8;
  function_a48b2870();
}

function_e19c174f() {
  foreach(s_loc in level.s_pap_quest.a_s_locations) {
    s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", 1);
  }
}

function_668e3f89(e_player) {
  if(!level flag::get("pap_quest_complete")) {
    var_235457fd = self function_afab6169(e_player);

    if(isDefined(self.hint_string)) {
      self sethintstring(self.hint_string);
    }

    return var_235457fd;
  }

  var_d679d54f = !isDefined(level.s_pap_quest.var_69e563d);
  var_7cee75e6 = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_4ee2e2ab].unitrigger_stub === self.stub;
  var_cd46bf62 = isDefined(level.s_pap_quest.var_69e563d) && level.s_pap_quest.var_69e563d.unitrigger_stub === self.stub;

  if(!(isDefined(level.var_efaaea43) && level.var_efaaea43) && var_7cee75e6 || isDefined(level.var_a5340531) && level.var_a5340531 && var_d679d54f || isDefined(level.var_a5340531) && level.var_a5340531 && var_7cee75e6 || isDefined(level.var_a8626e72) && level.var_a8626e72 && var_cd46bf62 || isDefined(level.var_fea7bdae) && level.var_fea7bdae || level flag::exists(#"hash_598d4e6af1cf4c39") && level flag::get(#"hash_598d4e6af1cf4c39") || zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    return 0;
  }

  if(isDefined(level.var_efaaea43) && level.var_efaaea43) {
    self sethintstring(#"hash_73bbee9df5d3c2b1");
  } else {
    switch (level.s_pap_quest.a_s_locations[level.s_pap_quest.var_4ee2e2ab].prefabname) {
      case #"stairs_pap_location":
        self sethintstring(#"hash_15783325b3eeefd5");
        break;
      case #"poop_deck_pap_location":
        self sethintstring(#"hash_250613266b9a4223");
        break;
      case #"engine_room_pap_location":
        self sethintstring(#"hash_4c5f8e23d8258199");
        break;
      case #"cargo_pap_location":
        self sethintstring(#"hash_1deb745365a6cfdd");
        break;
      default:
        self sethintstring(#"");
        break;
    }
  }

  return 1;
}

function_afab6169(e_player) {
  b_result = 0;

  if(!(isDefined(e_player zombie_utility::is_player_valid(e_player)) && e_player zombie_utility::is_player_valid(e_player))) {
    self.hint_string = #"";
  } else if(isDefined(self.stub.b_used) && self.stub.b_used) {
    self.hint_string = #"";
  } else if(level flag::get("pap_quest_complete")) {
    self.hint_string = #"";
  } else {
    if(function_8b1a219a()) {
      self.hint_string = #"hash_36ba40b9e876f572";
    } else {
      self.hint_string = #"hash_15494c7927282ad6";
    }

    b_result = 1;
  }

  return b_result;
}

function_9b917fd5(is_powered) {
  self zm_pack_a_punch::set_state_hidden();

  if(!isDefined(level.var_ea3b08d8)) {
    level.var_ea3b08d8 = [];
  } else if(!isarray(level.var_ea3b08d8)) {
    level.var_ea3b08d8 = array(level.var_ea3b08d8);
  }

  level.var_ea3b08d8[self.prefabname] = self;
  self.var_7c2f9a8b = 1;
  self.var_7e4bc0a2 = 1;
}

function_61748fa3() {
  if(zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    return;
  }

  level flag::wait_till("pap_quest_complete");
  function_306b4f35(1);
  level.var_25e38adf++;

  iprintlnbold("<dev string:x38>");

    while(true) {
      level waittill(#"end_of_round");

      if(zm_utility::is_trials() && level flag::get("round_reset")) {
        continue;
      }

      if(level.round_number >= level.var_25e38adf && !zm_utility::is_standard()) {
        function_306b4f35();
      }
    }
}

function_306b4f35(b_initial = 0) {
  if(!b_initial) {
    level notify(#"hash_14c80c5abb28b07b");
    function_ef3c219a();
    var_3eee8fb4 = level.s_pap_quest.var_4ee2e2ab;
    level.s_pap_quest.var_69e563d = level.s_pap_quest.a_s_locations[var_3eee8fb4];

    if(!isDefined(level.var_dd2ac1f3)) {
      level.var_dd2ac1f3 = [];
    }

    if(!level.var_dd2ac1f3.size) {
      for(i = 0; i < level.s_pap_quest.a_s_locations.size; i++) {
        level.var_dd2ac1f3[i] = i;
      }

      while(level.var_dd2ac1f3[0] == var_3eee8fb4) {
        level.var_dd2ac1f3 = array::randomize(level.var_dd2ac1f3);
      }
    }

    if(!level flag::get(#"hash_452df3df817c57f9") || !isDefined(level.s_pap_quest.var_e9b06709) || level flag::get(#"hash_598d4e6af1cf4c39")) {
      level.s_pap_quest.var_4ee2e2ab = level.var_dd2ac1f3[0];
      level.var_dd2ac1f3 = array::exclude(level.var_dd2ac1f3, level.var_dd2ac1f3[0]);
    } else {
      level.s_pap_quest.var_4ee2e2ab = level.s_pap_quest.var_e9b06709;
      level.var_dd2ac1f3 = array::exclude(level.var_dd2ac1f3, level.s_pap_quest.var_e9b06709);
    }

    level.var_efaaea43 = 1;
  } else {
    function_e19c174f();
  }

  function_9e015223();
  level.var_efaaea43 = 0;
  level.var_25e38adf = level.round_number + randomintrange(2, 4);
}

function_ef3c219a() {
  if(!isDefined(level.pap_machine)) {
    return;
  }

  if(isDefined(level.pap_machine.unitrigger_stub.var_a0fc37f6)) {
    level.pap_machine.unitrigger_stub thread zm_lockdown_util::function_61a9bc58();
  }

  level.pap_machine flag::wait_till("pap_waiting_for_user");
  function_e19c174f();
  level.var_a8626e72 = 1;
  playrumbleonposition("zm_castle_pap_tp", level.pap_machine.origin);
  playsoundatposition(#"hash_5944b4f78bf382e8", level.pap_machine.origin);
  var_88aa74e = level.s_pap_quest.var_88aa74e;

  if(!isDefined(var_88aa74e)) {
    var_88aa74e = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_4ee2e2ab];
  }

  if(isDefined(var_88aa74e)) {
    hidemiscmodels(var_88aa74e.prefabname);
  }

  level.pap_machine clientfield::set("pap_machine_rune", 1);
  level.pap_machine thread zm_pack_a_punch::function_bb629351(0, "leaving", "leave_anim_done");
  level.pap_machine waittill(#"leave_anim_done");
  level.var_a8626e72 = 0;
  level.pap_machine zm_pack_a_punch::set_state_initial();

  if(isDefined(var_88aa74e)) {
    showmiscmodels(var_88aa74e.prefabname);
  }

  level.var_fea7bdae = 1;
}

function_9e015223() {
  level.s_pap_quest.var_88aa74e = level.s_pap_quest.a_s_locations[level.s_pap_quest.var_4ee2e2ab];
  s_new_loc = level.s_pap_quest.var_88aa74e;
  level.pap_machine = s_new_loc.unitrigger_stub.pap_machine;

  if(!isDefined(level.pap_machine)) {
    return;
  }

  level.var_fea7bdae = 0;
  level.var_a5340531 = 1;
  level.pap_machine clientfield::set("pap_machine_rune", 1);
  hidemiscmodels(s_new_loc.prefabname);
  level.pap_machine thread zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
  level.pap_machine waittill(#"arrive_anim_done");
  zm_lockdown_util::function_d67bafb5(level.pap_machine.unitrigger_stub, "lockdown_stub_type_pap");
  level.var_a5340531 = 0;
  showmiscmodels(s_new_loc.prefabname);
  level.pap_machine pap_machine_rune_on();
  level.pap_machine thread function_f7dc54d8();
  level thread function_a48b2870();
  level notify(#"pap_moved");
}

function_1563bfc3() {
  level.var_fea7bdae = 0;
  level.var_a5340531 = 0;

  foreach(s_loc in level.s_pap_quest.a_s_locations) {
    s_machine = s_loc.unitrigger_stub.pap_machine;
    hidemiscmodels(s_loc.prefabname);
    s_machine thread zm_pack_a_punch::function_bb629351(1, "arriving", "arrive_anim_done");
    s_machine waittill(#"arrive_anim_done");
    showmiscmodels(s_loc.prefabname);
  }
}

function_f7dc54d8() {
  a_ai_enemies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, 40, 100);

  foreach(ai_zombie in a_ai_enemies) {
    ai_zombie dodamage(ai_zombie.health + 100, ai_zombie.origin + (0, 100, 0));
  }
}

pap_chunk_big_rune_on() {
  switch (self.prefabname) {
    case #"engine_room_pap_location":
      var_81731c8e = 4;
      break;
    case #"stairs_pap_location":
      var_81731c8e = 2;
      break;
    case #"cargo_pap_location":
      var_81731c8e = 5;
      break;
    case #"poop_deck_pap_location":
      var_81731c8e = 3;
      break;
  }

  self clientfield::set("pap_chunk_big_rune", var_81731c8e);
}

function_a48b2870() {
  if(!level flag::get("pap_quest_complete")) {
    foreach(s_loc in level.s_pap_quest.a_s_locations) {
      if(isDefined(s_loc.unitrigger_stub.pap_machine.var_4a7b80c6) && s_loc.unitrigger_stub.pap_machine.var_4a7b80c6) {
        switch (s_loc.prefabname) {
          case #"engine_room_pap_location":
            var_e636ead7 = 1;
            break;
          case #"stairs_pap_location":
            var_942e881a = 1;
            break;
          case #"cargo_pap_location":
            var_6a69b27 = 1;
            break;
          case #"poop_deck_pap_location":
            var_2380391d = 1;
            break;
        }
      }
    }

    if(isDefined(var_942e881a) && var_942e881a) {
      var_81731c8e = 2;

      if(isDefined(var_2380391d) && var_2380391d) {
        var_81731c8e = 3;

        if(isDefined(var_e636ead7) && var_e636ead7) {
          var_81731c8e = 4;

          if(isDefined(var_6a69b27) && var_6a69b27) {
            var_81731c8e = 16;
          }
        } else if(isDefined(var_6a69b27) && var_6a69b27) {
          var_81731c8e = 5;
        }
      } else if(isDefined(var_e636ead7) && var_e636ead7) {
        var_81731c8e = 6;

        if(isDefined(var_6a69b27) && var_6a69b27) {
          var_81731c8e = 7;
        }
      } else if(isDefined(var_6a69b27) && var_6a69b27) {
        var_81731c8e = 8;
      }
    } else if(isDefined(var_2380391d) && var_2380391d) {
      var_81731c8e = 9;

      if(isDefined(var_e636ead7) && var_e636ead7) {
        var_81731c8e = 10;

        if(isDefined(var_6a69b27) && var_6a69b27) {
          var_81731c8e = 11;
        }
      } else if(isDefined(var_6a69b27) && var_6a69b27) {
        var_81731c8e = 12;
      }
    } else if(isDefined(var_e636ead7) && var_e636ead7) {
      var_81731c8e = 13;

      if(isDefined(var_6a69b27) && var_6a69b27) {
        var_81731c8e = 14;
      }
    } else if(isDefined(var_6a69b27) && var_6a69b27) {
      var_81731c8e = 15;
    } else {
      var_81731c8e = 1;
    }
  } else if(isDefined(level.pap_machine) && !(isDefined(level.var_a5340531) && level.var_a5340531) && !(isDefined(level.var_a8626e72) && level.var_a8626e72)) {
    switch (level.pap_machine.prefabname) {
      case #"engine_room_pap_location":
        var_81731c8e = 13;
        break;
      case #"stairs_pap_location":
        var_81731c8e = 2;
        break;
      case #"cargo_pap_location":
        var_81731c8e = 15;
        break;
      case #"poop_deck_pap_location":
        var_81731c8e = 9;
        break;
    }
  }

  if(isDefined(var_81731c8e)) {
    foreach(s_loc in level.s_pap_quest.a_s_locations) {
      s_loc.unitrigger_stub.pap_machine clientfield::set("pap_chunk_small_rune", var_81731c8e);
    }
  }
}

pap_machine_rune_on() {
  switch (self.prefabname) {
    case #"engine_room_pap_location":
      var_81731c8e = 4;
      break;
    case #"stairs_pap_location":
      var_81731c8e = 2;
      break;
    case #"cargo_pap_location":
      var_81731c8e = 5;
      break;
    case #"poop_deck_pap_location":
      var_81731c8e = 3;
      break;
  }

  self clientfield::set("pap_machine_rune", var_81731c8e);
}

function_765118cf() {
  level.s_pap_quest.var_4ee2e2ab = 0;

  if(!level flag::get("<dev string:x50>")) {
    level waittill(#"stairs_pap_location");
  }

  wait 0.1;
  level flag::set("<dev string:x7e>");
}

function_83d342c7() {
  level flag::wait_till("<dev string:x93>");
  var_4c043770 = getent("<dev string:xa9>", "<dev string:xc1>");

  if(!isDefined(var_4c043770)) {
    return;
  }

  var_4c043770 zm_pack_a_punch::set_state_arriving();

  while(true) {
    for(i = 2; i <= 5; i++) {
      var_4c043770 function_a2a8d76e(i);
    }
  }
}

function_d7dc7c3e(var_c8407ea2) {
  self clientfield::set("<dev string:xce>", var_c8407ea2);
  wait 3;
  self clientfield::set("<dev string:xe3>", var_c8407ea2);
  wait 3;
  self clientfield::set("<dev string:xe3>", 0);
  wait 2;
}

function_a2a8d76e(var_c8407ea2) {
  self clientfield::set("<dev string:xfa>", var_c8407ea2);
  wait 3;
  self clientfield::set("<dev string:xfa>", 1);
  wait 2;
}

function_4944c76f() {
  level endon(#"pap_moved");
  var_710f09a8 = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 100);
  var_737189c4 = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 80);
  var_c1f4ccaf = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 60);
  var_743fd60c = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 40);
  var_56692417 = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 20);
  var_1e3527a8 = self.origin + vectornormalize(anglesToForward(self.angles)) * 160 + (0, 0, 0);

  while(true) {
    print3d(var_710f09a8, "<dev string:x10d>" + self getzbarrierpiecestate(0));
    print3d(var_737189c4, "<dev string:x116>" + self getzbarrierpiecestate(1));
    print3d(var_c1f4ccaf, "<dev string:x11f>" + self getzbarrierpiecestate(2));
    print3d(var_743fd60c, "<dev string:x128>" + self getzbarrierpiecestate(3));
    print3d(var_56692417, "<dev string:x131>" + self getzbarrierpiecestate(4));
    print3d(var_1e3527a8, "<dev string:x13a>" + self getzbarrierpiecestate(5));
    waitframe(1);
  }
}

