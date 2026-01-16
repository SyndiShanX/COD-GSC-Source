/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_668c4fbb94671fb4.gsc
***********************************************/

#include script_46cea9e5d4ef9e21;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm\weapons\zm_weap_spectral_shield;
#include scripts\zm\zm_escape_paschal;
#include scripts\zm\zm_escape_util;
#include scripts\zm_common\ai\zm_ai_utility;
#include scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#include scripts\zm_common\util\ai_brutus_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_characters;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_zonemgr;

#namespace namespace_a9aa9d72;

autoexec __init__system__() {
  system::register(#"hash_3478ed13fc9440e6", &__init__, undefined, undefined);
}

__init__() {
  n_bits = getminbitcountfornum(3);
  clientfield::register("scriptmover", "" + #"hash_632f7bc0b1a15f71", 1, n_bits, "int");
  clientfield::register("scriptmover", "" + #"hash_4614e4fa180c79af", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_53586aa63ca15286", 1, 1, "int");
  clientfield::register("actor", "" + #"hash_65da20412fcaf97e", 1, 2, "int");
  clientfield::register("scriptmover", "" + #"hash_65da20412fcaf97e", 1, 2, "int");
  clientfield::register("toplayer", "" + #"hash_7d4d423d8dabbee3", 1, getminbitcountfornum(10), "int");
  clientfield::register("toplayer", "" + #"hash_46bc4b451b7419bb", 1, getminbitcountfornum(3), "int");
  clientfield::register("toplayer", "" + #"hash_49fecafe0b5d6da4", 1, 2, "counter");
  clientfield::register("vehicle", "" + #"hash_584f13d0c8662647", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_584f13d0c8662647", 1, 1, "int");
  clientfield::register("vehicle", "" + #"hash_22ffb9cf999f16c0", 1, 1, "counter");
  clientfield::register("scriptmover", "" + #"hash_22ffb9cf999f16c0", 1, 1, "counter");
  clientfield::register("scriptmover", "" + #"hash_a51ae59006ab41b", 1, getminbitcountfornum(4), "int");
  clientfield::register("scriptmover", "" + #"hash_64f2dd36b17bf17", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_119729072e708651", 1, 1, "int");
  clientfield::register("actor", "" + #"hash_3e506d7aedac6ae0", 1, getminbitcountfornum(10), "int");
  clientfield::register("actor", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int");
  clientfield::register("scriptmover", "" + #"hash_504d26c38b96651c", 1, getminbitcountfornum(10), "int");
  clientfield::register("vehicle", "" + #"hash_504d26c38b96651c", 1, getminbitcountfornum(10), "int");
  clientfield::register("scriptmover", "" + #"hash_7dc9331ef45ed81f", 1, getminbitcountfornum(10), "int");
  clientfield::register("scriptmover", "" + #"hash_7dc9341ef45ed9d2", 1, getminbitcountfornum(10), "int");
  clientfield::register("scriptmover", "" + #"hash_7dc9351ef45edb85", 1, getminbitcountfornum(10), "int");
  clientfield::register("actor", "" + #"hash_7a8eab5597b25400", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_28a1a80b64f97e05", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hash_7f7790ca43a7fffe", 1, 1, "int");
  clientfield::register("world", "" + #"hash_437bd1912fc36607", 9000, 1, "int");

  if(zm_utility::is_ee_enabled()) {

    level thread function_96ac2d88();

  }

  level thread function_b247e756();
}

private function_b247e756() {
  level waittill(#"all_players_spawned");
  hidemiscmodels("rt_gh_sanim");
}

function_307fdd13(var_a276c861) {
  if(var_a276c861) {
    var_328baab5 = struct::get_array("pa_po_pos", "targetname");

    foreach(s_portal_pos in var_328baab5) {
      var_aa11c23c = util::spawn_model("tag_origin", s_portal_pos.origin, s_portal_pos.angles);
      var_aa11c23c.script_string = s_portal_pos.script_string;
      level thread paschal::function_e998f810("tag_socket_a");
      level thread paschal::function_e998f810("tag_socket_c");
      level thread paschal::function_e998f810("tag_socket_d");
      level thread paschal::function_e998f810("tag_socket_e");
      level thread paschal::function_e998f810("tag_socket_g");
      var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
      exploder::exploder("fxexp_script_l_d");
      exploder::exploder("fxexp_script_l_c");
      exploder::exploder("fxexp_script_l_n_i");
      exploder::exploder("fxexp_script_l_s");
      exploder::exploder("fxexp_script_l_p_p");
      var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 1);
      waitframe(1);
      var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 0);
    }

    return;
  }

  zm::register_actor_damage_callback(&function_1d42763a);
  level clientfield::set("" + #"hash_437bd1912fc36607", 1);
  level.var_85cc9fcc = array("docks", "cellblock", "new_industries", "showers", "power_plant");
  level function_486ef0f6();
  level clientfield::set("" + #"hash_437bd1912fc36607", 0);
  level notify(#"hash_29b90ce9aa921f78");
}

private function_486ef0f6() {
  level endon(#"game_ended", #"hash_54eae43edf7f08cd");

  if(!isDefined(level.var_bbc27d0e)) {
    var_c26c0a90 = struct::get("k_fx_pos", "targetname");
    level.var_bbc27d0e = util::spawn_model(#"hash_4c06bc763e373f0f", var_c26c0a90.origin, var_c26c0a90.angles);
  }

  var_a9b19429 = 0;

  while(level.var_85cc9fcc.size > 0) {
    if(!(isDefined(level.var_d486e9c4) && level.var_d486e9c4)) {
      if(var_a9b19429) {
        level.var_bbc27d0e thread paschal::function_9e723e9(3, 1);
      }

      level.var_bbc27d0e thread function_a9277243();
      level.var_bbc27d0e thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 2", level.var_bbc27d0e);
      level.var_bbc27d0e clientfield::set("" + #"hash_4614e4fa180c79af", 1);
      level.var_bbc27d0e waittill(#"hash_1f3cf68a268a10f1");
      level.var_bbc27d0e clientfield::set("" + #"hash_4614e4fa180c79af", 0);
      level.var_bbc27d0e thread scene::play("p8_fxanim_zm_esc_book_zombie_shuffle_bundle", "Shot 1", level.var_bbc27d0e);
    }

    var_aa11c23c = function_9f38c4a2();
    var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 1);

    switch (var_aa11c23c.script_string) {
      case #"docks":
        str_hint_text = #"hash_4213dc004145588f";
        break;
      case #"cellblock":
        str_hint_text = #"hash_70fa5ff9f448bc96";
        break;
      case #"new_industries":
        str_hint_text = #"hash_786af67b8225aaf4";
        break;
      case #"showers":
        str_hint_text = #"hash_8a1754e2c346504";
        break;
      case #"power_plant":
        str_hint_text = #"hash_7806b6b51cd2aed2";
        break;
    }

    if(!(isDefined(level.var_d486e9c4) && level.var_d486e9c4)) {
      level.var_99b333e1 = level function_23fa3cae();
      var_4894fd91 = "" + level.var_99b333e1[0] + level.var_99b333e1[1] + level.var_99b333e1[2];
      level thread function_c5319ebe();
      callback::on_connect(&function_c5319ebe);
      level thread function_5b7bbc40();

      while(true) {
        s_result = level waittill(#"hash_1ba800da972b0558");

        if(s_result.str_code == var_4894fd91) {
          arrayremovevalue(level.var_d8e7f0cf, level.var_99b333e1);
          level thread function_b3df3f03();
          break;
        }
      }
    }

    var_aa11c23c thread paschal::function_9e723e9();
    level thread function_9b1d9d6a();
    var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 1);

    if(!(isDefined(level.var_d486e9c4) && level.var_d486e9c4)) {
      var_aa11c23c thread function_d3aa5310();
      s_result = var_aa11c23c waittill(#"portal_timeout", #"blast_attack");

      if(s_result._notify == #"portal_timeout") {
        var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
        var_aa11c23c delete();
        var_a9b19429 = 1;
        continue;
      }
    } else {
      level.var_d486e9c4 = undefined;
      waitframe(1);
    }

    var_a9b19429 = 1;
    var_aa11c23c clientfield::set("" + #"hash_53586aa63ca15286", 0);
    s_beam = struct::get("s_p_s1_lh_r_light");
    s_beam.mdl_beam clientfield::set("" + #"hash_1f572bbcdde55d9d", 0);

    switch (var_aa11c23c.script_string) {
      case #"docks":
        var_aa11c23c.var_be009f9c = "tag_socket_g";
        var_81c75ce3 = "fxexp_script_l_d";
        var_aa11c23c thread function_b264ca4d();
        break;
      case #"cellblock":
        var_aa11c23c.var_be009f9c = "tag_socket_e";
        var_81c75ce3 = "fxexp_script_l_c";
        var_aa11c23c thread function_2b37242f();
        break;
      case #"new_industries":
        var_aa11c23c.var_be009f9c = "tag_socket_c";
        var_81c75ce3 = "fxexp_script_l_n_i";
        var_aa11c23c thread function_cdc8090a();
        break;
      case #"showers":
        var_aa11c23c.var_be009f9c = "tag_socket_d";
        var_81c75ce3 = "fxexp_script_l_s";
        var_aa11c23c thread function_b80b6749();
        break;
      case #"power_plant":
        var_aa11c23c.var_be009f9c = "tag_socket_a";
        var_81c75ce3 = "fxexp_script_l_p_p";
        var_aa11c23c thread function_c11e25eb();
        break;
    }

    var_aa11c23c thread function_283daa98();

      s_result = var_aa11c23c waittill(#"hash_300e9fed7925cd69");

    if(isDefined(s_result.b_success) && s_result.b_success) {
      var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 2);
      exploder::exploder(var_81c75ce3);

      foreach(e_player in util::get_active_players()) {
        e_player clientfield::increment_to_player("" + #"hero_katana_vigor_postfx");
        e_player playrumbleonentity("damage_heavy");
      }
    } else {
      var_aa11c23c clientfield::set("" + #"hash_632f7bc0b1a15f71", 0);
      var_aa11c23c delete();

      if(!(isDefined(s_result.var_d0af61fc) && s_result.var_d0af61fc)) {
        level waittill(#"between_round_over");
      }

      continue;
    }

    arrayremovevalue(level.var_85cc9fcc, var_aa11c23c.script_string);
  }

  level.var_bbc27d0e thread paschal::function_9e723e9();
  var_c699e2b5 = struct::get("s_p_s2_ins");

  while(level.var_dd650b0e.size < 6) {
    var_c699e2b5.s_unitrigger_stub waittill(#"hash_4c6ab2a4a99f9539");
  }
}

private function_9f38c4a2() {
  if(isDefined(level.var_daaf0e5d) && isinarray(level.var_85cc9fcc, level.var_daaf0e5d)) {
    var_ce57a284 = level.var_daaf0e5d;
    level.var_daaf0e5d = undefined;
  } else {
    var_ce57a284 = array::random(level.var_85cc9fcc);
  }

  var_328baab5 = struct::get_array("pa_po_pos", "targetname");

  foreach(s_portal_pos in var_328baab5) {
    if(s_portal_pos.script_string === var_ce57a284) {
      var_aa11c23c = util::spawn_model("tag_origin", s_portal_pos.origin, s_portal_pos.angles);
      var_aa11c23c.script_string = s_portal_pos.script_string;
      var_aa11c23c.script_noteworthy = "blast_attack_interactables";
      break;
    }
  }

  return var_aa11c23c;
}

private function_23fa3cae() {
  var_8171dd3a = randomint(10);
  var_8dfff656 = randomint(10);

  for(var_44e1e41b = randomint(10); !namespace_1063645::function_aac7105a(var_8171dd3a, var_8dfff656, var_44e1e41b); var_44e1e41b = randomint(10)) {
    var_8171dd3a = randomint(10);
    var_8dfff656 = randomint(10);
  }

  if(!isDefined(level.var_d8e7f0cf)) {
    level.var_d8e7f0cf = [];
  } else if(!isarray(level.var_d8e7f0cf)) {
    level.var_d8e7f0cf = array(level.var_d8e7f0cf);
  }

  if(!isinarray(level.var_d8e7f0cf, array(var_8171dd3a, var_8dfff656, var_44e1e41b))) {
    level.var_d8e7f0cf[level.var_d8e7f0cf.size] = array(var_8171dd3a, var_8dfff656, var_44e1e41b);
  }

  var_679f0ee5 = struct::get_array("nixie_tubes", "script_noteworthy");

  foreach(var_18b64c03 in var_679f0ee5) {
    switch (var_18b64c03.script_string) {
      case #"nixie_tube_trigger_1":
        n_code = var_8171dd3a;
        break;
      case #"nixie_tube_trigger_2":
        n_code = var_8dfff656;
        break;
      case #"nixie_tube_trigger_3":
        n_code = var_44e1e41b;
        break;
    }
  }

  return array(var_8171dd3a, var_8dfff656, var_44e1e41b);
}

private function_c5319ebe() {
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9351ef45edb85", 0);

  for(i = 0; i < level.var_99b333e1.size; i++) {
    switch (i) {
      case 0:
        var_5a557bfb = "" + #"hash_7dc9331ef45ed81f";
        break;
      case 1:
        var_5a557bfb = "" + #"hash_7dc9341ef45ed9d2";
        break;
      case 2:
        var_5a557bfb = "" + #"hash_7dc9351ef45edb85";
        break;
    }

    if(level.var_99b333e1[i] == 0) {
      level.var_bbc27d0e clientfield::set(var_5a557bfb, 10);
      continue;
    }

    level.var_bbc27d0e clientfield::set(var_5a557bfb, level.var_99b333e1[i]);
  }
}

private function_b3df3f03() {
  callback::remove_on_connect(&function_c5319ebe);
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9331ef45ed81f", 0);
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9341ef45ed9d2", 0);
  level.var_bbc27d0e clientfield::set("" + #"hash_7dc9351ef45edb85", 0);
}

private function_5b7bbc40() {
  foreach(e_player in util::get_players()) {
    w_current = e_player getcurrentweapon();

    if(w_current == level.var_4e845c84 || w_current == level.var_58e17ce3) {
      if(e_player adsbuttonpressed()) {
        e_player clientfield::set("" + #"afterlife_vision_play", 0);
        util::wait_network_frame();
        e_player clientfield::set("" + #"afterlife_vision_play", 1);
      }
    }
  }
}

private function_d3aa5310() {
  self endon(#"death", #"hash_300e9fed7925cd69", #"blast_attack");
  wait 180;
  level waittill(#"between_round_over");
  self notify(#"portal_timeout");
}

private function_b264ca4d() {
  self endoncallback(&function_5711b0c2, #"death", #"hash_300e9fed7925cd69");
  b_success = undefined;
  level.var_5deac933 = [];
  var_3df8381d = level function_5dc786f7();
  var_6433d2a2 = getent("m_c_ra", "targetname");
  var_6433d2a2 thread function_333c93f3(var_3df8381d);
  level waittill(#"hash_3ffb8bc647b5d06b");
  var_6e25652d = getvehiclenode("gh_b_st_node", "targetname");
  level.var_ddea3ebd = vehicle::spawn(undefined, "gh_tb", #"hash_741d76f17830f464", var_6e25652d.origin, var_6e25652d.angles);
  level.var_ddea3ebd thread function_c2f5fca4(var_6e25652d);
  array::thread_all(util::get_players(), &function_29d29761, level.var_ddea3ebd, #"hash_115ac6d40d4cc85b");
  self thread function_c3923440();
  level waittill(#"hash_361c36fab747c7f0");
  var_4f11e61a = struct::get("gh_d_pos", "targetname");
  level.var_ddea3ebd notify(#"stop_path");
  level.var_ddea3ebd vehicle::detach_path();
  level.var_ddea3ebd clientfield::set("" + #"hash_504d26c38b96651c", 0);
  level.var_ddea3ebd clientfield::increment("" + #"hash_22ffb9cf999f16c0");
  waitframe(1);
  level.var_ddea3ebd delete();
  wait 0.5;
  level.var_a33f961e = util::spawn_model(var_4f11e61a.model, var_4f11e61a.origin, var_4f11e61a.angles);
  level.var_a33f961e clientfield::set("" + #"hash_504d26c38b96651c", 1);
  level.var_a33f961e clientfield::set("" + #"hash_584f13d0c8662647", 1);
  waitframe(1);
  level.var_a33f961e clientfield::increment("" + #"hash_22ffb9cf999f16c0");
  level.var_a33f961e playSound(#"hash_2cd9134632e7f398");
  level.var_a33f961e playLoopSound(#"hash_5ca999a30dd19c01");
  var_b9526d6f = struct::get("gh_b_pos", "targetname");
  level.var_aca3d5e = spawn("trigger_radius_new", var_b9526d6f.origin, (512 | 2) + 8, var_b9526d6f.radius);

  while(true) {
    s_result = level.var_aca3d5e waittill(#"trigger");

    if(s_result.activator == level.var_558993a0) {
      callback::remove_on_ai_killed(&function_744712bc);
      level.var_558993a0 notify(#"hash_71716a8e79096aee");

      if(isDefined(level.var_558993a0.t_interact)) {
        level.var_558993a0.t_interact delete();
      }

      var_7df17d61 = level.var_558993a0.origin;
      level.var_558993a0 delete();
      break;
    }
  }

  level.var_aca3d5e delete();
  level.var_a33f961e thread function_dbb17bef(var_4f11e61a);
  var_9c502e92 = 1;

  if(isDefined(var_9c502e92) && var_9c502e92) {
    self thread function_56e41aa6(var_7df17d61);
    level thread function_ac1d7a0e(#"hash_7d360b71501ba662");
  }

  self thread function_5711b0c2();
  self notify(#"hash_300e9fed7925cd69", {
    #b_success: var_9c502e92
  });
}

private function_5711b0c2(var_c34665fc) {
  callback::remove_on_ai_killed(&function_744712bc);

  if(isDefined(level.var_66a47b57)) {
    level.var_66a47b57 delete();
  }

  if(isDefined(level.var_558993a0)) {
    if(isDefined(level.var_558993a0.t_interact)) {
      level.var_558993a0.t_interact delete();
    }

    level.var_558993a0 delete();
  }

  if(isDefined(level.var_ddea3ebd)) {
    level.var_ddea3ebd delete();
  }

  if(isDefined(level.a_t_codes)) {
    while(level.a_t_codes.size) {
      t_code = level.a_t_codes[0];
      t_code delete();
      arrayremovevalue(level.a_t_codes, t_code);
    }

    level.a_t_codes = undefined;
  }

  if(isDefined(level.var_a33f961e)) {
    level.var_a33f961e delete();
  }

  if(isDefined(level.var_aca3d5e)) {
    level.var_aca3d5e delete();
  }
}

private function_c2f5fca4(var_6e25652d) {
  self endon(#"death", #"stop_path");
  waitframe(1);
  self clientfield::increment("" + #"hash_22ffb9cf999f16c0");
  self clientfield::set("" + #"hash_584f13d0c8662647", 1);
  self clientfield::set("" + #"hash_504d26c38b96651c", 1);

  while(true) {
    self vehicle::get_on_and_go_path(var_6e25652d);
    self vehicle::detach_path();
    waitframe(1);
  }
}

private function_5dc786f7() {
  var_304cc83e = randomint(10);
  var_a31c3d78 = randomint(10);
  var_17a14b0b = randomint(10);
  var_3df8381d = var_304cc83e + var_a31c3d78 + var_17a14b0b;
  level.a_t_codes = [];
  var_991213f6 = struct::get_array("m_c_pos", "targetname");

  foreach(var_844fa02e in var_991213f6) {
    t_code = spawn("trigger_radius_new", var_844fa02e.origin, 0, var_844fa02e.radius, 96);
    t_code.script_noteworthy = var_844fa02e.script_noteworthy;
    t_code.targetname = var_844fa02e.targetname;
    t_code.s_lookat = struct::get(var_844fa02e.target, "targetname");

    if(!isDefined(level.a_t_codes)) {
      level.a_t_codes = [];
    } else if(!isarray(level.a_t_codes)) {
      level.a_t_codes = array(level.a_t_codes);
    }

    if(!isinarray(level.a_t_codes, t_code)) {
      level.a_t_codes[level.a_t_codes.size] = t_code;
    }

    switch (var_844fa02e.script_noteworthy) {
      case #"gondola_platform":
        t_code.n_code = var_17a14b0b;
        t_code.n_expl = 2;
        break;
      case #"catwalk":
        t_code.n_code = var_304cc83e;
        t_code.n_expl = 0;
        break;
      case #"model_industries":
        t_code.n_code = var_a31c3d78;
        t_code.n_expl = 1;
        break;
    }

    t_code thread function_45862f35();
  }

  return var_3df8381d;
}

private function_45862f35() {
  level endon(#"hash_3ffb8bc647b5d06b");
  self endon(#"death");

  while(true) {
    s_result = self waittill(#"trigger");

    if(isplayer(s_result.activator) && !(isDefined(s_result.activator.var_f0096e2c) && s_result.activator.var_f0096e2c)) {
      s_result.activator.var_f0096e2c = 1;
      self thread function_76e46dd1(s_result.activator);
    }

    waitframe(1);
  }
}

private function_76e46dd1(e_player) {
  level endon(#"hash_3ffb8bc647b5d06b");
  e_player endon(#"death");
  self endon(#"death");

  while(e_player istouching(self)) {
    w_current = e_player getcurrentweapon();

    if((w_current == level.var_4e845c84 || w_current == level.var_58e17ce3) && e_player util::is_looking_at(self.s_lookat.origin)) {
      e_player thread function_bb88526(self.n_code);

      if(!isDefined(level.var_5deac933)) {
        level.var_5deac933 = [];
      } else if(!isarray(level.var_5deac933)) {
        level.var_5deac933 = array(level.var_5deac933);
      }

      if(!isinarray(level.var_5deac933, self)) {
        level.var_5deac933[level.var_5deac933.size] = self;
      }

      e_player clientfield::set_to_player("" + #"hash_46bc4b451b7419bb", self.n_expl + 1);

      if(level.var_5deac933.size >= 3) {
        level notify(#"hash_31bf59ee8be67433");
      }

      n_start_time = gettime();

      for(n_total_time = 0; n_total_time < 8 && e_player istouching(self) && (w_current == level.var_4e845c84 || w_current == level.var_58e17ce3) && e_player util::is_looking_at(self.s_lookat.origin); n_total_time = (n_current_time - n_start_time) / 1000) {
        wait 0.1;
        w_current = e_player getcurrentweapon();
        n_current_time = gettime();
      }

      e_player clientfield::set_to_player("" + #"hash_46bc4b451b7419bb", 0);

      if(e_player clientfield::get_to_player("" + #"hash_7d4d423d8dabbee3")) {
        e_player clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
      }
    }

    wait 1.6;
  }

  e_player.var_f0096e2c = undefined;
}

private function_bb88526(n_num) {
  if(n_num == 0) {
    self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 10);
    return;
  }

  self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", n_num);
}

private function_333c93f3(var_3df8381d) {
  level.var_66a47b57 = spawn("trigger_radius_use", self.origin, 0, 48);
  level.var_66a47b57 triggerignoreteam();
  level.var_66a47b57 sethintstring(#"");
  level.var_66a47b57 setcursorhint("HINT_NOICON");
  level.var_66a47b57.is_visible = 1;
  level.var_66a47b57 endon(#"death");
  var_ae5529ba = undefined;
  var_9b830416 = 0;
  var_af097de7 = [];
  var_77d58f80 = [];
  var_3ad399df = #"code_dot";
  var_ca1854a9 = #"code_dash";

  if(var_3df8381d == 30) {
    var_ae5529ba = 3;
    var_af097de7 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
  } else if(var_3df8381d >= 20) {
    var_ae5529ba = 2;
    var_af097de7 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
  } else if(var_3df8381d >= 10) {
    var_ae5529ba = 1;
    var_af097de7 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
  }

  switch (var_3df8381d) {
    case 1:
    case 11:
    case 21:
      var_9b830416 = 1;
      var_77d58f80 = array(var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
      break;
    case 2:
    case 12:
    case 22:
      var_9b830416 = 2;
      var_77d58f80 = array(var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9, var_ca1854a9);
      break;
    case 3:
    case 13:
    case 23:
      var_9b830416 = 3;
      var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9, var_ca1854a9);
      break;
    case 4:
    case 14:
    case 24:
      var_9b830416 = 4;
      var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_ca1854a9);
      break;
    case 5:
    case 15:
    case 25:
      var_9b830416 = 5;
      var_77d58f80 = array(var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
      break;
    case 6:
    case 16:
    case 26:
      var_9b830416 = 6;
      var_77d58f80 = array(var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df, var_3ad399df);
      break;
    case 7:
    case 17:
    case 27:
      var_9b830416 = 7;
      var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df, var_3ad399df);
      break;
    case 8:
    case 18:
    case 28:
      var_9b830416 = 8;
      var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df, var_3ad399df);
      break;
    case 9:
    case 19:
    case 29:
      var_9b830416 = 9;
      var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_3ad399df);
      break;
    case 0:
    case 10:
    case 20:
    case 30:
      var_9b830416 = 0;
      var_77d58f80 = array(var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9, var_ca1854a9);
      break;
    default:
      break;
  }

  var_fda79bf3 = 0;

  while(true) {
    s_result = level.var_66a47b57 waittill(#"trigger");
    e_player = s_result.activator;
    level.var_66a47b57 setinvisibletoall();
    level.var_66a47b57.is_visible = 0;

    if(!isplayer(e_player)) {
      level.var_66a47b57 setvisibletoall();
      level.var_66a47b57.is_visible = 1;
      continue;
    }

    if(!(isDefined(var_fda79bf3) && var_fda79bf3)) {
      level.var_66a47b57 thread function_b87b2393();
      var_fda79bf3 = 1;
    }

    if(isDefined(var_ae5529ba) && var_ae5529ba > 0) {
      var_49e994d2 = e_player function_bfe4e5a9(var_af097de7, var_ae5529ba);

      if(!(isDefined(var_49e994d2) && var_49e994d2)) {
        if(isDefined(e_player)) {
          e_player playlocalsound(#"hash_28d80c177e66c724");
        }

        level.var_66a47b57 setvisibletoall();
        level.var_66a47b57.is_visible = 1;
        continue;
      }
    }

    if(isplayer(e_player)) {
      var_5830315f = e_player function_bfe4e5a9(var_77d58f80, var_9b830416);

      if(isDefined(var_5830315f) && var_5830315f) {
        playsoundatposition(#"zmb_lightning_l", level.var_66a47b57.origin);
        level notify(#"hash_3ffb8bc647b5d06b");
        e_player thread zm_audio::create_and_play_dialog(#"success_resp", #"generic");
        level.var_66a47b57 delete();
        return;
      } else if(isDefined(e_player)) {
        e_player playlocalsound(#"hash_28d80c177e66c724");
      }
    }

    level.var_66a47b57 setvisibletoall();
    level.var_66a47b57.is_visible = 1;
  }
}

private function_b87b2393() {
  self endon(#"death");
  level endon(#"hash_3ffb8bc647b5d06b");
  level waittill(#"end_of_round");

  while(isDefined(level.var_66a47b57) && !(isDefined(level.var_66a47b57.is_visible) && level.var_66a47b57.is_visible)) {
    waitframe(1);
  }

  level notify(#"hash_1a286cacd101f4eb", {
    #b_success: 0
  });
}

private function_bfe4e5a9(var_5faf08a9, n_entry) {
  self.var_da61dab6 = 1;
  self thread function_b8dc82a8();
  mdl_radio = getent("m_c_ra", "targetname");

  if(isDefined(level.var_bf412074) && level.var_bf412074) {
    self thread function_bb88526(n_entry);
    wait 6;

    if(isDefined(self)) {
      self clientfield::set_to_player("" + #"hash_7d4d423d8dabbee3", 0);
    }

    return true;
  } else {
    for(i = 0; i < var_5faf08a9.size; i++) {
      var_6dcb990a = var_5faf08a9[i];

      while(isDefined(self) && !self usebuttonpressed() && isDefined(self.var_da61dab6) && self.var_da61dab6) {
        waitframe(1);
      }

      n_start_time = gettime();
      mdl_radio thread scene::play(#"p8_zm_esc_kmc_bundle", "DOWN", mdl_radio);
      mdl_radio clientfield::set("" + #"hash_7f7790ca43a7fffe", 1);

      while(isDefined(self) && self usebuttonpressed() && isDefined(self.var_da61dab6) && self.var_da61dab6) {
        waitframe(1);
      }

      mdl_radio thread scene::play(#"p8_zm_esc_kmc_bundle", "UP", mdl_radio);
      mdl_radio clientfield::set("" + #"hash_7f7790ca43a7fffe", 0);

      if(!isDefined(self) || !(isDefined(self.var_da61dab6) && self.var_da61dab6)) {
        return false;
      }

      offset_con = gettime();
      n_total_time = (offset_con - n_start_time) / 1000;

      if(n_total_time <= 1.25) {
        var_751473a9 = #"code_dot";
      } else {
        var_751473a9 = #"code_dash";
      }

      if(var_751473a9 !== var_6dcb990a) {
        return false;
      }
    }
  }

  return true;
}

private function_b8dc82a8() {
  self endon(#"death");
  level.var_66a47b57 endon(#"death");

  while(distance2d(self.origin, level.var_66a47b57.origin) <= 64) {
    waitframe(1);
  }

  self.var_da61dab6 = undefined;
}

private function_bb47b90d(var_dcd55ef2) {
  self endon(#"death", #"hash_fdbf10dbf063a82");
  var_25d70459 = var_dcd55ef2;

  for(s_next_pos = struct::get(var_dcd55ef2.target, "targetname"); true; s_next_pos = var_dcd55ef2) {
    n_dist = distance(s_next_pos.origin, var_25d70459.origin);
    n_time_travel = n_dist / 45;
    self moveto(s_next_pos.origin, n_time_travel);
    self rotateto(s_next_pos.angles, n_time_travel);
    wait n_time_travel;
    var_25d70459 = s_next_pos;

    if(isDefined(var_25d70459.target)) {
      s_next_pos = struct::get(var_25d70459.target, "targetname");
      continue;
    }
  }
}

private function_c3923440() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  callback::on_ai_killed(&function_744712bc);
  s_result = level waittill(#"hash_4e2f6e88e9985f10");

  if(!isDefined(level.var_558993a0) || s_result.ai_ghost !== level.var_558993a0) {
    self notify(#"hash_300e9fed7925cd69", {
      #b_success: 0, 
      #var_d0af61fc: 1
    });
  }

  level.var_558993a0 endon(#"death");
  self thread function_3e62ca0b(level.var_558993a0);
  level.var_558993a0 thread function_1db8a8b2("in_gh_pa");
  level.var_558993a0 waittill(#"blast_attack");
  level.var_558993a0 notify(#"hash_585dd04498227242");
  level.var_558993a0 setgoal(level.var_558993a0.origin);
  level.var_558993a0 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  level.var_558993a0 thread function_768e71d5();
  level.var_558993a0 waittill(#"hash_17de7292d988f537");
  level.var_558993a0.var_2ef9b50a = 1;
  level.var_558993a0 thread function_4e69659c();
  var_5e7c3fee = getent("pa_do_vol", "targetname");

  while(!level.var_558993a0 istouching(var_5e7c3fee)) {
    wait 1;
  }

  level notify(#"hash_361c36fab747c7f0");
}

function_744712bc(s_params) {
  if(!isDefined(level.var_558993a0) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_infirmary") || self zm_zonemgr::entity_in_zone("zone_infirmary_roof"))) {
    v_teleport_position = self.origin + (0, 0, 5);
    level.var_558993a0 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");

    while(!isDefined(level.var_558993a0)) {
      waitframe(1);
      level.var_558993a0 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "gh_bm");
    }

    level.var_558993a0 function_e128a8d4();
    level.var_558993a0 forceteleport(v_teleport_position, self.angles, 1, 1);
    level.var_558993a0.script_noteworthy = "blast_attack_interactables";
    level.var_558993a0 thread function_a51841a(s_params.eattacker, #"hash_fd8e78c22906fc1");
    level.var_558993a0 thread function_ff88f6aa(v_teleport_position);
    waitframe(1);
    level notify(#"hash_4e2f6e88e9985f10", {
      #ai_ghost: level.var_558993a0
    });
    return;
  }

  if(isDefined(level.var_558993a0) && isplayer(s_params.eattacker) && distance2d(self.origin, level.var_558993a0.origin) < 600 && isDefined(level.var_558993a0.var_2ef9b50a) && level.var_558993a0.var_2ef9b50a) {
    self thread function_b952c1b(level.var_558993a0);
  }
}

private function_e5801a77() {
  self endon(#"death", #"hash_71716a8e79096aee");
  self.var_7fbed236 = 0;

  while(true) {
    s_result = self waittill(#"hash_7b36770a2988e5d1");
    self.var_7fbed236 += 15;
    self notify(#"hash_2499fc5cec93bec8");
  }
}

private function_4e69659c() {
  self endon(#"death", #"hash_71716a8e79096aee");
  self thread function_e5801a77();

  while(true) {
    while(self.var_7fbed236 > 0) {
      self.goalradius = 128;

      if(isalive(self.e_activator)) {
        self thread function_23d7198d(self.e_activator);
        self setgoal(self.e_activator);
      } else {
        self setgoal(self.origin);
      }

      wait 0.25;
      self.var_7fbed236 = math::clamp(self.var_7fbed236 - 0.25, 0, 300);
    }

    self setgoal(self.origin);
    self playSound(#"hash_2d161f5686b2700a");
    s_result = self waittill(#"hash_2499fc5cec93bec8");
  }
}

private function_23d7198d(e_player) {
  if(self zm_utility::function_ab9a9770() && !e_player zm_utility::function_ab9a9770()) {
    n_distance = distance(self.origin, e_player.origin);

    if(n_distance > 128 && !(isDefined(self.b_teleported) && self.b_teleported)) {
      self thread function_54e0f89(e_player);
    }
  }

  if(self zm_utility::function_ab9a9770() && e_player zm_utility::function_ab9a9770()) {
    if(isDefined(self.t_interact) && !(isDefined(e_player.var_c0a4d6b1) && e_player.var_c0a4d6b1)) {
      e_player.var_c0a4d6b1 = 1;
      self.t_interact setinvisibletoplayer(e_player);
      self thread function_524c833(e_player);
    }
  }
}

private function_524c833(e_player) {
  self endon(#"death");
  e_player endon(#"death");

  while(self zm_utility::function_ab9a9770() && e_player zm_utility::function_ab9a9770()) {
    wait 0.2;
  }

  self.t_interact setvisibletoplayer(e_player);
  e_player.var_c0a4d6b1 = undefined;
}

private function_54e0f89(e_player) {
  self endon(#"death");
  v_dir = vectornormalize(e_player.origin - self.origin);
  v_pos = e_player.origin + v_dir * 40;
  v_pos = getclosestpointonnavmesh(v_pos, 128, 16);

  if(isDefined(v_pos)) {
    self.b_teleported = 1;
    self forceteleport(v_pos);
    wait 5;
    self.b_teleported = undefined;
  }
}

private function_dbb17bef(var_25d70459) {
  self endon(#"death");
  s_next_pos = struct::get(var_25d70459.target, "targetname");
  n_dist = distance(s_next_pos.origin, var_25d70459.origin);
  n_time_travel = n_dist / 45;
  self moveto(s_next_pos.origin, n_time_travel);
  self rotateto(s_next_pos.angles, n_time_travel);
  wait n_time_travel;
  self stoploopsound();
  self clientfield::increment("" + #"hash_22ffb9cf999f16c0");
  self clientfield::set("" + #"hash_584f13d0c8662647", 0);
  self clientfield::set("" + #"hash_504d26c38b96651c", 0);
  waitframe(1);
  self delete();
}

private function_2b37242f() {
  self endoncallback(&function_e1137e13, #"death", #"hash_300e9fed7925cd69");
  b_success = undefined;
  self thread function_6c1f6b4e();
  level waittill(#"hash_4e2f6e88e9985f10");
  waitframe(1);
  level.var_7b71cdb7 waittill(#"blast_attack");
  level.var_7b71cdb7 notify(#"hash_71716a8e79096aee");
  self thread function_4c8b4a87();

  if(isDefined(level.var_7b71cdb7.t_interact)) {
    level.var_7b71cdb7.t_interact delete();
  }

  a_s_firewalls = struct::get_array("cellblocks_barrier_fx", "targetname");
  self thread function_cd0d0123(a_s_firewalls, "fxexp_flame_wall_door_glow_shower_cellblock");
  level thread function_2c4516ae("cellblock_start_door");
  self thread function_19df5c43();
  level.var_7b71cdb7 thread function_7de21668();
  level.var_7b71cdb7 val::reset(#"ai_ghost", "ignoreme");
  level.var_7b71cdb7 val::reset(#"ai_ghost", "allowdeath");
  level.var_7b71cdb7 setCanDamage(1);
  level.var_7b71cdb7 solid();

  if(!(isDefined(zm_ai_utility::is_zombie_target(level.var_7b71cdb7)) && zm_ai_utility::is_zombie_target(level.var_7b71cdb7))) {
    zm_ai_utility::make_zombie_target(level.var_7b71cdb7);
  }

  level.var_7b71cdb7 thread function_67a6f551();
  s_result = level.var_7b71cdb7 waittill(#"death", #"hash_6f435cd868870904");

  if(s_result._notify == #"hash_6f435cd868870904") {
    var_9c502e92 = 1;
  } else {
    v_pos = undefined;

    if(isDefined(level.var_7b71cdb7)) {
      v_pos = level.var_7b71cdb7.origin;
    }

    level thread function_4219d0d8(v_pos);
  }

  if(isDefined(level.var_7b71cdb7)) {
    if(isDefined(zm_ai_utility::is_zombie_target(level.var_7b71cdb7)) && zm_ai_utility::is_zombie_target(level.var_7b71cdb7)) {
      zm_ai_utility::remove_zombie_target(level.var_7b71cdb7);
    }

    var_7df17d61 = level.var_7b71cdb7.origin;
  }

  self thread function_e1137e13();

  if(isDefined(var_9c502e92) && var_9c502e92) {
    self thread function_56e41aa6(var_7df17d61);
    level thread function_ac1d7a0e(#"hash_368df266f54ec3b1");
  }

  self notify(#"hash_300e9fed7925cd69", {
    #b_success: var_9c502e92
  });
}

private function_e1137e13(var_c34665fc) {
  callback::remove_on_ai_killed(&function_59945272);

  if(isDefined(level.var_7b71cdb7)) {
    level.var_7b71cdb7 delete();
  }

  hidemiscmodels("rt_gh_sanim");
  exploder::stop_exploder("fxexp_riot_ghoul");
  exploder::stop_exploder("fxexp_riot_ghoul2");
}

private function_4c8b4a87() {
  var_39633c28 = zombie_utility::get_current_zombie_count();

  if(var_39633c28 + level.zombie_total < 4) {
    level.zombie_total += 5;
  }
}

private function_19df5c43() {
  level util::clientnotify("sndriot");
  showmiscmodels("rt_gh_sanim");
  exploder::exploder("fxexp_riot_ghoul");
  exploder::exploder("fxexp_riot_ghoul2");
  self thread function_9ee74e2c();
  self waittill(#"death", #"hash_300e9fed7925cd69");
  level util::clientnotify("sndriot");
  hidemiscmodels("rt_gh_sanim");
  exploder::stop_exploder("fxexp_riot_ghoul");
  exploder::stop_exploder("fxexp_riot_ghoul2");
}

function_9ee74e2c() {
  self endon(#"death", #"hash_300e9fed7925cd69");

  while(true) {
    var_fe655381 = zm_zonemgr::get_players_in_zone("zone_cellblock_east", 1);

    if(var_fe655381.size > 0) {
      e_player = array::random(var_fe655381);
      level thread function_629fa2c8(#"hash_72bb7bc935d4da67", e_player);
      return;
    }

    wait 1;
  }
}

private function_67a6f551() {
  self endon(#"death");
  var_9cdf5d68 = 10;

  while(isalive(self)) {
    s_result = self waittill(#"damage");
    n_percent = self.health / 961;
    n_blood = int(n_percent * 10);

    if(n_blood != var_9cdf5d68) {
      self clientfield::set("" + #"hash_3e506d7aedac6ae0", n_blood);
      var_9cdf5d68 = n_blood;
    }

    self function_1b049b47();
  }
}

private function_1b049b47() {
  self endon(#"death");
  self setCanDamage(0);
  var_a94e126 = 0;
  is_visible = 1;

  while(var_a94e126 < 7) {
    if(isDefined(is_visible) && is_visible) {
      self ghost();
      is_visible = 0;
    } else {
      self show();
      is_visible = 1;
    }

    var_a94e126++;
    wait 0.1;
  }

  self show();
  self setCanDamage(1);
}

function_1d42763a(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(self === level.var_7b71cdb7 && isplayer(eattacker)) {
    return 0;
  }

  return -1;
}

private function_7de21668() {
  self endon(#"death");
  self.goalradius = 64;
  var_397f8272 = struct::get_array("cellblocks_final_path", "script_noteworthy");
  var_25d70459 = arraygetclosest(self.origin, var_397f8272);
  s_next_pos = struct::get(var_25d70459.target, "targetname");
  self setgoal(var_25d70459.origin);
  self waittill(#"goal");

  while(isDefined(s_next_pos)) {
    self setgoal(s_next_pos.origin);
    self waittill(#"goal");

    if(s_next_pos.script_string === "smoke") {
      s_next_pos thread function_e5b11574();
    } else if(s_next_pos.script_string === "brutus_sp") {
      level thread function_b88f57f9();
    }

    var_25d70459 = s_next_pos;

    if(isDefined(var_25d70459.target)) {
      s_next_pos = struct::get(var_25d70459.target, "targetname");
      continue;
    }

    s_next_pos = undefined;
  }

  self notify(#"hash_6f435cd868870904");
}

private function_b88f57f9() {
  s_brutus_location = struct::get("cel_bru_pos", "targetname");
  var_a9c0254c = struct::get(s_brutus_location.target, "targetname");

  if(level.brutus_count + 1 <= level.brutus_max_count) {
    ai_brutus = zombie_utility::spawn_zombie(level.var_d668eae7[0]);

    if(isalive(ai_brutus)) {
      ai_brutus endon(#"death");
      ai_brutus zombie_brutus_util::brutus_spawn(undefined, undefined, undefined, undefined, undefined);
      ai_brutus forceteleport(s_brutus_location.origin, s_brutus_location.angles);
      ai_brutus playSound(#"zmb_ai_brutus_spawn_2d");
      ai_brutus val::set(#"ai_brutus", "ignoreall", 1);
      ai_brutus setgoal(var_a9c0254c.origin);
      ai_brutus waittill(#"goal");
      ai_brutus val::reset(#"ai_brutus", "ignoreall");
    }
  }
}

private function_e5b11574() {
  if(math::cointoss()) {
    v_target_pos = (self.origin[0] + randomfloat(256), self.origin[1] + randomfloat(256), self.origin[2]);
    v_target_pos = getclosestpointonnavmesh(v_target_pos, 256, 16);

    if(isDefined(v_target_pos)) {
      mdl_pos = util::spawn_model("tag_origin", v_target_pos + (0, 0, 32));
      e_grenade = mdl_pos magicgrenadetype(getweapon(#"willy_pete"), v_target_pos, (0, 0, 0), 0.4);
      waitframe(1);
      mdl_pos delete();
    }
  }
}

function_ae8a20de() {
  self endon(#"death", #"hash_6f435cd868870904");

  while(true) {
    var_d8036031 = getaiteamarray(level.zombie_team).size;

    if(var_d8036031 >= function_5b5301c9()) {
      waitframe(1);
      continue;
    }

    str_zone = zm_zonemgr::get_zone_from_position(self.origin);
    str_next_zone = function_9e55b467(str_zone);
    function_eee2ccd4(str_next_zone);
    function_eee2ccd4(str_next_zone);

    if(str_next_zone === "zone_start") {
      function_eee2ccd4(str_next_zone);
    } else if(str_zone === "zone_start") {
      function_eee2ccd4("zone_library");
    }

    wait randomfloatrange(2.9, 6.1);
  }
}

function_5b5301c9() {
  switch (util::get_active_players().size) {
    case 1:
      n_zombies_max = 21;
      break;
    case 2:
      n_zombies_max = 22;
      break;
    case 3:
      n_zombies_max = 23;
      break;
    default:
      n_zombies_max = 26;
      break;
  }

  return n_zombies_max;
}

private function_1eab6e39() {
  self endon(#"death", #"hash_6f435cd868870904");
  self thread function_7c71661a();

  while(true) {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin);
    var_3cd5bf76 = 0;

    if(str_zone != "zone_cellblock_entrance") {
      a_e_zombies = getaiteamarray(level.zombie_team);

      foreach(e_zombie in a_e_zombies) {
        if(isalive(e_zombie) && isDefined(e_zombie.zone_name) && e_zombie.zone_name == str_zone) {
          var_3cd5bf76++;
        }
      }

      if(!level function_7edf3657(var_3cd5bf76)) {
        str_next_zone = function_9e55b467(str_zone);
        level thread function_eee2ccd4(str_next_zone);
      }
    }

    wait randomfloatrange(3, 5);
  }
}

private function_7c71661a() {
  self endon(#"death", #"hash_6f435cd868870904");
  level thread function_eee2ccd4("zone_cellblock_entrance");
  var_d4c2136c = 0;
  var_fe69e6bb = 0;
  var_adf35a34 = 0;
  var_70edc3d5 = 0;
  var_629eec30 = 0;

  while(!var_629eec30) {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin);

    if(str_zone == "zone_cellblock_east" && !var_d4c2136c) {
      var_d4c2136c = 1;
      level thread function_eee2ccd4("zone_library");
    } else if(str_zone == "zone_cellblock_entrance" && !var_fe69e6bb) {
      var_fe69e6bb = 1;
      level thread function_eee2ccd4("zone_library");
    } else if(str_zone == "zone_start" && !var_adf35a34) {
      var_adf35a34 = 1;
      level thread function_eee2ccd4("zone_cellblock_west");
    } else if(str_zone == "zone_library" && !var_70edc3d5) {
      var_70edc3d5 = 1;
      level thread function_eee2ccd4("zone_broadway_floor_2");
    } else if(str_zone == "zone_cellblock_west" && !var_629eec30) {
      var_629eec30 = 1;
      level thread function_eee2ccd4("zone_cellblock_west_warden");
    }

    wait 1;
  }
}

private function_7edf3657(var_3cd5bf76) {
  switch (util::get_players().size) {
    case 1:
      n_threshold = 3;
      break;
    case 2:
      n_threshold = 4;
      break;
    case 3:
      n_threshold = 5;
      break;
    case 4:
      n_threshold = 6;
      break;
  }

  if(var_3cd5bf76 >= n_threshold) {
    return 1;
  }

  return 0;
}

private function_9e55b467(str_zone) {
  str_next_zone = "zone_cafeteria";

  if(!isDefined(str_zone)) {
    return str_next_zone;
  }

  switch (str_zone) {
    case #"zone_cafeteria_end":
      str_next_zone = "zone_cellblock_east";
      break;
    case #"zone_cafeteria":
      str_next_zone = "zone_cellblock_entrance";
      break;
    case #"zone_cellblock_east":
      str_next_zone = "zone_start";
      break;
    case #"zone_cellblock_entrance":
      str_next_zone = "zone_library";
      break;
    case #"zone_start":
      str_next_zone = "zone_cellblock_west";
      break;
    case #"zone_library":
      str_next_zone = "zone_broadway_floor_2";
      break;
    case #"zone_cellblock_west":
      str_next_zone = "zone_cellblock_west_barber";
      break;
    case #"zone_broadway_floor_2":
      str_next_zone = "zone_cellblock_west_warden";
      break;
    case #"zone_cellblock_west_barber":
      str_next_zone = "zone_sally_port";
      break;
    case #"zone_cellblock_west_warden":
      str_next_zone = "zone_sally_port";
      break;
  }

  return str_next_zone;
}

private function_eee2ccd4(str_zone) {
  var_7d53907e = getnode(str_zone, "targetname");
  var_f3f7c164 = struct::get_array(var_7d53907e.target);
  var_5ab4bb90 = [];

  foreach(s_spawner in var_f3f7c164) {
    if(s_spawner.script_noteworthy != "dog_location" && s_spawner.script_noteworthy != "brutus_location" && s_spawner.script_noteworthy != "wait_location") {
      if(!isDefined(var_5ab4bb90)) {
        var_5ab4bb90 = [];
      } else if(!isarray(var_5ab4bb90)) {
        var_5ab4bb90 = array(var_5ab4bb90);
      }

      var_5ab4bb90[var_5ab4bb90.size] = s_spawner;
    }
  }

  var_8f2dfb2c = function_8f06b9dc();

  for(i = 0; i < var_8f2dfb2c; i++) {
    s_spawn_location = array::random(var_5ab4bb90);
    e_enemy = undefined;

    while(!isDefined(e_enemy)) {
      e_enemy = zombie_utility::spawn_zombie(level.zombie_spawners[0], undefined, s_spawn_location);
      waitframe(1);
    }

    e_enemy thread zm_escape_util::function_24d3ec02(undefined, 1);
    waitframe(1);
  }
}

function_8f06b9dc() {
  switch (util::get_players().size) {
    case 1:
      n_zombies = 3;
      break;
    case 2:
      n_zombies = 4;
      break;
    case 3:
      n_zombies = 5;
      break;
    case 4:
      n_zombies = 6;
      break;
  }

  return n_zombies;
}

private function_6c1f6b4e() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  callback::on_ai_killed(&function_59945272);
  s_result = level waittill(#"hash_4e2f6e88e9985f10");

  if(!isDefined(level.var_7b71cdb7) || s_result.ai_ghost !== level.var_7b71cdb7) {
    self notify(#"hash_300e9fed7925cd69", {
      #b_success: 0, 
      #var_d0af61fc: 1
    });
  }

  level.var_7b71cdb7 endon(#"death");
  self thread function_3e62ca0b(level.var_7b71cdb7);
  level.var_7b71cdb7 thread function_1db8a8b2("ce_gh_pa");
  level.var_7b71cdb7 waittill(#"blast_attack");
  level.var_7b71cdb7 notify(#"hash_585dd04498227242");
  level.var_7b71cdb7.b_is_visible = 1;
  level.var_7b71cdb7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  level.var_7b71cdb7 thread function_ae8a20de();
}

function_59945272(s_params) {
  if(!isDefined(level.var_7b71cdb7) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_cafeteria") || self zm_zonemgr::entity_in_zone("zone_cafeteria_end"))) {
    callback::remove_on_ai_killed(&function_59945272);
    v_teleport_position = self.origin + (0, 0, 5);
    level.var_7b71cdb7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "cb_gh");

    while(!isDefined(level.var_7b71cdb7)) {
      waitframe(1);
      level.var_7b71cdb7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "cb_gh");
    }

    level.var_7b71cdb7 function_e128a8d4(0);
    level.var_7b71cdb7.var_238b3806 = 1;
    level.var_7b71cdb7 forceteleport(v_teleport_position, self.angles, 1, 1);
    level.var_7b71cdb7.script_noteworthy = "blast_attack_interactables";
    level.var_7b71cdb7 thread function_a51841a(s_params.eattacker, #"hash_2ea20c8cd81b5464");
    level.var_7b71cdb7 thread function_ff88f6aa(v_teleport_position);
    level notify(#"hash_4e2f6e88e9985f10", {
      #ai_ghost: level.var_7b71cdb7
    });
  }
}

private function_4219d0d8(v_pos) {
  foreach(e_player in util::get_active_players()) {
    if(isDefined(v_pos) && e_player zm_utility::is_player_looking_at(v_pos + (0, 0, 32))) {
      level thread function_629fa2c8(#"ghost_disappears", e_player);
    }

    waitframe(1);
  }

  e_player = array::random(util::get_active_players());
  level thread function_629fa2c8(#"ghost_disappears", e_player);
}

private function_cdc8090a() {
  self endoncallback(&function_4b6d9f06, #"death", #"hash_300e9fed7925cd69");
  b_success = undefined;
  self thread function_d2bf4eeb();
  level waittill(#"hash_4e2f6e88e9985f10");
  waitframe(1);
  level.var_acc853e7 waittill(#"hash_585dd04498227242");
  self thread function_729b2218(level.var_acc853e7);
  s_result = self waittilltimeout(6, #"hash_754ca63bdd999035");

  if(s_result._notify == "timeout") {
    self notify(#"hash_141c4fe73e47836f");
  }

  level.var_acc853e7 thread function_3c3c455c();
  level.var_acc853e7 thread function_3f90c49f();
  level.var_acc853e7 waittill(#"hash_57648a286155c924");
  array::thread_all(util::get_players(), &function_2992f8fe, level.var_acc853e7, #"hash_7cf90fc327de893e");
  level thread function_2c4516ae("door_model_west_side_exterior_to_new_industries");
  level.var_acc853e7 thread function_a50552d1();
  level.var_acc853e7 waittill(#"hash_42d705f0ff5334bb");
  level zm_audio::function_6191af93(#"trap_activate", #"zm_spinning_trap", "", "");
  level zm_audio::function_6191af93(#"spin_trap", #"hook", "", "");
  level.var_acc853e7 ai::set_behavior_attribute("run", 0);

  if(level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e")) {
    level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  }

  level scene::add_scene_func(#"aib_vign_zm_mob_spoon_ghost_stab", &function_e78de01b, "init");
  level thread scene::init(#"aib_vign_zm_mob_spoon_ghost_stab");
  level.var_acc853e7 thread function_7f71a2b2(self);
  var_e4f517f0 = getEntArray("zm_spinning_trap", "script_noteworthy");
  array::thread_all(var_e4f517f0, &function_f8da844f, self);
  s_result = level.var_acc853e7 waittill(#"death", #"hash_436fe34b5e12d99a");
  var_7df17d61 = level.var_acc853e7.origin;

  if(s_result._notify == "death") {
    var_9c502e92 = 1;
    level thread scene::stop(#"aib_vign_zm_mob_spoon_ghost_stab");
  } else {
    self waittilltimeout(9, #"hash_17cc254c45796829");
    e_player = array::random(util::get_active_players());
    level thread function_629fa2c8(#"hash_7ab135537c096a5a", e_player);
  }

  level thread function_4b6d9f06();

  if(isDefined(var_9c502e92) && var_9c502e92) {
    self thread function_56e41aa6(var_7df17d61);
    level thread function_ac1d7a0e(#"hash_53aafd7783e33981");
  }

  self notify(#"hash_300e9fed7925cd69", {
    #b_success: var_9c502e92
  });
}

function_2992f8fe(e_ghost, var_5b9ba5a5) {
  e_ghost endon(#"death", #"ghost_seen");
  self endon(#"disconnect");
  wait 1.6;

  while(true) {
    var_da2705ac = self zm_utility::is_player_looking_at(e_ghost getcentroid());
    var_8924ba8b = self clientfield::get("" + #"afterlife_vision_play");
    var_383e18aa = isDefined(level.var_acc853e7.var_c95261d) && level.var_acc853e7.var_c95261d;

    if(var_da2705ac && (var_8924ba8b || var_383e18aa)) {
      if(!(isDefined(level.var_9cb7c32e) && level.var_9cb7c32e)) {
        level.var_9cb7c32e = 1;
        level function_629fa2c8(#"hash_57e9c23bed1bd753", self);
        wait 0.5;
      }

      level thread function_629fa2c8(var_5b9ba5a5, self);
      e_ghost notify(#"ghost_seen");
    }

    waitframe(1);
  }
}

private function_729b2218(ai_ghost) {
  self endon(#"death", #"hash_300e9fed7925cd69", #"hash_141c4fe73e47836f");

  foreach(e_player in util::get_active_players()) {
    if(e_player util::is_looking_at(ai_ghost getcentroid())) {
      self notify(#"hash_754ca63bdd999035");
      return;
    }
  }
}

private function_d2bf4eeb() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  callback::on_ai_killed(&function_995231f6);
  s_result = level waittill(#"hash_4e2f6e88e9985f10");

  if(!isDefined(level.var_acc853e7) || s_result.ai_ghost !== level.var_acc853e7) {
    self notify(#"hash_300e9fed7925cd69", {
      #b_success: 0, 
      #var_d0af61fc: 1
    });
  }

  level.var_acc853e7 endon(#"death");
  self thread function_3e62ca0b(level.var_acc853e7);
  level.var_acc853e7 thread function_1db8a8b2("ni_gh_pa");
  level.var_acc853e7 waittill(#"blast_attack");
  level.var_acc853e7 notify(#"hash_585dd04498227242");
  level.var_acc853e7 setgoal(level.var_acc853e7.origin);
  level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  level.var_acc853e7.var_c95261d = 1;
  level.var_68fa1bc = level.var_acc853e7;
  level.var_acc853e7 solid();
}

function_995231f6(s_params) {
  if(!isDefined(level.var_acc853e7) && isplayer(s_params.eattacker) && (self zm_zonemgr::entity_in_zone("zone_library") || self zm_zonemgr::entity_in_zone("zone_start"))) {
    callback::remove_on_ai_killed(&function_995231f6);
    v_teleport_position = self.origin + (0, 0, 5);
    level.var_acc853e7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "ni_gh");

    while(!isDefined(level.var_acc853e7)) {
      waitframe(1);
      level.var_acc853e7 = zombie_utility::spawn_zombie(getent("g_rob_zombie_spawner", "targetname"), "ni_gh");
    }

    level.var_acc853e7 function_e128a8d4(0);
    level.var_acc853e7 forceteleport(v_teleport_position, self.angles, 1, 1);
    level.var_acc853e7.script_noteworthy = "blast_attack_interactables";
    level.var_acc853e7 thread function_a51841a(s_params.eattacker, #"hash_1d191ca6765471c6");
    level.var_acc853e7 thread function_ff88f6aa(v_teleport_position);
    level.var_acc853e7.var_238b3806 = 1;
    level notify(#"hash_4e2f6e88e9985f10", {
      #ai_ghost: level.var_acc853e7
    });
  }
}

private function_3f90c49f() {
  self endon(#"death");
  var_14a84ac9 = struct::get_array("ni_sp_pos", "targetname");
  v_pos = undefined;
  var_14a84ac9 = array::randomize(var_14a84ac9);

  while(!isDefined(v_pos)) {
    foreach(var_24f2b6cf in var_14a84ac9) {
      v_pos = getclosestpointonnavmesh(var_24f2b6cf.origin, 128, 16);
      v_angles = var_24f2b6cf.angles;

      if(isDefined(v_pos)) {
        path_success = self findpath(self.origin, v_pos, 1, 0);

        if(path_success) {
          break;
        } else {

          iprintln("<dev string:x38>" + var_24f2b6cf.origin);

        }

        continue;
      }

      iprintln("<dev string:x5f>" + var_24f2b6cf.origin);

    }
  }

  level.var_9e23e046 = util::spawn_model(#"wpn_t8_zm_spoon_world", v_pos, v_angles);
  self.goalradius = 64;

  while(distance2d(self.origin, v_pos) > 80) {
    self setgoal(v_pos);
    self waittilltimeout(6, #"goal");
  }

  self notify(#"hash_57648a286155c924");
  self scene::play(#"aib_vign_zm_mob_ghost_spoon_pickup", self);

  if(isDefined(level.var_9e23e046)) {
    level.var_9e23e046 delete();
  }

  self.mdl_spoon = util::spawn_model(#"wpn_t8_zm_spoon_world", self gettagorigin("tag_weapon_right"), self gettagangles("tag_weapon_right"));
  self.mdl_spoon linkto(self, "tag_weapon_right");
  self.mdl_spoon clientfield::set("" + #"hash_28a1a80b64f97e05", 1);
}

private function_3c3c455c() {
  self endon(#"death", #"hash_3cef5405e0643505", #"hash_436fe34b5e12d99a");
  self thread function_685fffc4();
  wait 11;
  level.var_acc853e7.var_c95261d = undefined;
  level.var_68fa1bc = undefined;
  level.var_acc853e7 notsolid();
  level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 2);

  while(true) {
    level.var_acc853e7 waittill(#"blast_attack");
    level.var_acc853e7.var_c95261d = 1;
    level.var_68fa1bc = level.var_acc853e7;
    level.var_acc853e7 solid();
    level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    wait 11;
    level.var_acc853e7.var_c95261d = undefined;
    level.var_68fa1bc = undefined;
    level.var_acc853e7 notsolid();
    level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 2);
  }
}

function_ae0bae8() {
  var_9636ee0 = 61;

  switch (util::get_players().size) {
    case 1:
      var_9636ee0 = 30.5;
      break;
    case 2:
      var_9636ee0 = 42.7;
      break;
    case 3:
      var_9636ee0 = 48.8;
      break;
    case 4:
      break;
  }

  return var_9636ee0;
}

private function_685fffc4() {
  self endon(#"death", #"hash_42d705f0ff5334bb");
  var_9636ee0 = function_ae0bae8();
  var_31adaadb = 0;
  var_e5b1f8d7 = undefined;
  var_49154180 = 10;

  while(var_31adaadb <= var_9636ee0) {
    if(isDefined(self.var_c95261d) && self.var_c95261d && isDefined(self.var_5bf7575e) && self.var_5bf7575e) {
      var_31adaadb++;
    }

    var_36f8baa8 = (var_9636ee0 - var_31adaadb) / var_9636ee0;
    var_b25755cf = int(var_36f8baa8 * 10);

    if(var_b25755cf != var_49154180) {
      self clientfield::set("" + #"hash_3e506d7aedac6ae0", var_b25755cf);
      var_49154180 = var_b25755cf;
    }

    if(var_36f8baa8 == 0.25 || var_36f8baa8 == 0.5 || var_36f8baa8 == 0.75 && var_e5b1f8d7 !== var_36f8baa8) {
      var_e5b1f8d7 = var_36f8baa8;
      iprintlnbold("<dev string:x80>" + var_36f8baa8);
    }

      wait 1;
  }

  level.var_acc853e7 notify(#"hash_3cef5405e0643505");
  level.var_acc853e7 playSound(#"zmb_sq_souls_release");
  waitframe(1);

  if(level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e")) {
    level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  }

  iprintlnbold("<dev string:x9d>");

    level.var_acc853e7.var_c95261d = undefined;
  level.var_68fa1bc = undefined;
  level.var_acc853e7.var_238b3806 = undefined;
  level.var_acc853e7 notsolid();
  level.var_acc853e7 ai::set_behavior_attribute("run", 1);
}

private function_a50552d1() {
  self endon(#"death");
  var_38da48af = struct::get("ni_gh_fi", "targetname");
  var_38da48af.origin = (7888, 11072, 320);
  self.goalradius = 64;

  while(distance2d(self.origin, var_38da48af.origin) > 92) {
    self setgoal(var_38da48af.origin);
    self waittilltimeout(30, #"goal");
  }

  self notify(#"hash_42d705f0ff5334bb");
}

private function_7f71a2b2(var_aa11c23c) {
  self endon(#"death");
  var_aa11c23c endon(#"hash_300e9fed7925cd69");
  var_48bbb849 = struct::get("gh_vi_pos", "targetname");
  self.goalradius = 24;

  while(distance2d(self.origin, var_48bbb849.origin) > self.goalradius) {
    self setgoal(var_48bbb849.origin, 1);
    self waittilltimeout(15, #"goal");
  }

  self notify(#"hash_436fe34b5e12d99a");
  waitframe(1);

  if(isalive(level.var_acc853e7) && level.var_acc853e7 clientfield::get("" + #"hash_65da20412fcaf97e")) {
    level.var_acc853e7 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
  }

  level scene::play(#"aib_vign_zm_mob_spoon_ghost_stab");
  var_aa11c23c notify(#"hash_17cc254c45796829");
}

private function_f8da844f(var_aa11c23c) {
  level.var_acc853e7 endon(#"death");
  var_aa11c23c endon(#"hash_300e9fed7925cd69");

  while(true) {
    s_result = self waittill(#"trigger");

    if(isDefined(self._trap_in_use) && self._trap_in_use && s_result.activator === level.var_acc853e7 && !(isDefined(level.var_acc853e7.var_238b3806) && level.var_acc853e7.var_238b3806)) {
      wait 1.6;
      level.var_acc853e7 val::reset(#"ai_ghost", "allowdeath");
      level.var_acc853e7 setCanDamage(1);
      level.var_acc853e7 clientfield::set("" + #"hash_7a8eab5597b25400", 1);
      playsoundatposition("zmb_spoon_ghost_annihilate", level.var_acc853e7.origin);
      gibserverutils::annihilate(level.var_acc853e7);
      level.var_acc853e7 dodamage(level.var_acc853e7.health + 1000, self.origin, undefined, self);
    }
  }
}

private function_4b6d9f06(var_c34665fc) {
  callback::remove_on_ai_killed(&function_995231f6);

  if(isDefined(level.var_acc853e7)) {
    if(isDefined(level.var_acc853e7.mdl_spoon)) {
      level.var_acc853e7.mdl_spoon clientfield::set("" + #"hash_28a1a80b64f97e05", 0);
      level.var_acc853e7.mdl_spoon delete();
    }

    level.var_acc853e7 delete();
  }

  if(isDefined(level.var_9488f62c)) {
    level.var_9488f62c delete();
  }

  if(isDefined(level.var_9e23e046)) {
    level.var_9e23e046 delete();
  }

  level zm_audio::function_e1666976(#"trap_activate", #"zm_spinning_trap");
  level zm_audio::function_e1666976(#"spin_trap", #"hook");
}

function_e78de01b(a_ents) {
  if(isDefined(a_ents[#"ni_gh_vi"])) {
    level.var_9488f62c = a_ents[#"ni_gh_vi"];
  }
}

private function_b80b6749() {
  self endoncallback(&function_549f1fcd, #"death", #"hash_300e9fed7925cd69");
  b_success = undefined;
  var_aa851834 = undefined;
  a_str_zones = array("cellblock_shower");

  while(!(isDefined(var_aa851834) && var_aa851834)) {
    foreach(e_player in util::get_players()) {
      if(isDefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones)) {
        var_aa851834 = 1;
        break;
      }
    }

    waitframe(1);
  }

  s_scene = struct::get("sh_b_scene", "targetname");
  scene::remove_scene_func(s_scene.scriptbundlename, &function_fdfca800, "init");
  s_scene scene::add_scene_func(s_scene.scriptbundlename, &function_fdfca800, "init");
  s_scene scene::init(#"aib_vign_zm_mob_banjo_ghost");
  wait 5;
  level thread function_629fa2c8(#"hash_1e0663f4102106fa", level.var_9d950ce5.e_activator);
  level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
  level.var_9d950ce5.t_interact setinvisibletoall();
  level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 9);

  iprintlnbold("<dev string:xc1>");

    exploder::exploder("fxexp_shower_ambient_ground_fog");
  a_s_firewalls = struct::get_array("sh_ba_fx", "targetname");
  self thread function_cd0d0123(a_s_firewalls, "fxexp_flame_wall_door_glow_shower");
  level flag::clear(#"hash_107c5504e3325022");
  s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_of");
  wait 2;

  if(util::get_players().size == 1) {
    self thread function_3854c592();
  }

  level.var_9d950ce5.t_interact setvisibletoall();
  level.var_9d950ce5.e_activator = undefined;
  level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
  level.var_9d950ce5.t_interact setinvisibletoall();
  self thread function_580723de(0, level.var_9d950ce5.e_activator);
  level thread function_629fa2c8(#"hash_46252c9e0b200ae6", level.var_9d950ce5.e_activator);
  self thread function_b1aeb165(s_scene);
  self thread function_33701563();
  s_result = self waittill(#"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");

  if(s_result._notify == #"hash_4636f041ae52f0fa" || !isalive(level.var_9d950ce5.e_activator)) {
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
    var_c74251a4 = scene::function_8582657c(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
    wait var_c74251a4;
  } else {

    iprintlnbold("<dev string:xe1>");

      foreach(e_player in util::get_active_players()) {
        e_player clientfield::increment_to_player("" + #"hero_katana_vigor_postfx");
        e_player playsoundtoplayer(#"hash_3f03a6b2d8cfc1b9", e_player);
      }

    if(isDefined(level.var_9d950ce5.t_interact)) {
      level.var_9d950ce5.t_interact setvisibletoplayer(level.var_9d950ce5.e_activator);
      level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
    }

    self thread function_580723de(1);
    var_7df17d61 = level.var_9d950ce5.origin;
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
    var_c74251a4 = scene::function_8582657c(#"aib_vign_zm_mob_banjo_ghost", "shot_out");
    wait var_c74251a4;
    var_9c502e92 = 1;
  }

  exploder::stop_exploder("fxexp_shower_ambient_ground_fog");

  if(isDefined(var_9c502e92) && var_9c502e92) {
    self thread function_56e41aa6(var_7df17d61);
    level thread function_ac1d7a0e(#"hash_51300ea0974da947", level.var_9d950ce5.e_activator);
  }

  self thread function_549f1fcd();
  self notify(#"hash_300e9fed7925cd69", {
    #b_success: var_9c502e92
  });
}

function_fdfca800(a_ents) {
  if(isDefined(a_ents[#"gh_sh"])) {
    level.var_9d950ce5 = a_ents[#"gh_sh"];
    level.var_9d950ce5 thread function_768e71d5();
  }

  if(isDefined(a_ents[#"gh_ba"])) {
    level.var_4dad7caf = a_ents[#"gh_ba"];
    level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 10);
  }
}

private function_b1aeb165(s_scene) {
  self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
  s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_wa");

  while(true) {
    level.var_9d950ce5.t_interact setvisibletoplayer(level.var_9d950ce5.e_activator);
    self thread function_aa26a9be(level.var_9d950ce5.e_activator);
    level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
    self thread function_580723de(1);
    level.var_9d950ce5.e_activator notify(#"hash_c5c509724d92ec4");
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_of");
    level.var_9d950ce5.t_interact setvisibletoall();
    level.var_9d950ce5.e_activator = undefined;
    level.var_9d950ce5 waittill(#"hash_17de7292d988f537");
    level.var_9d950ce5.t_interact setinvisibletoall();
    self thread function_580723de(0, level.var_9d950ce5.e_activator);
    s_scene thread scene::play(#"aib_vign_zm_mob_banjo_ghost", "shot_wa");
    wait 2;
  }
}

private function_549f1fcd(var_c34665fc) {
  level flag::set(#"hash_107c5504e3325022");

  if(isDefined(level.var_9d950ce5)) {
    if(isDefined(level.var_9d950ce5.t_interact)) {
      level.var_9d950ce5.t_interact delete();
    }

    level.var_9d950ce5 delete();
  }

  if(isDefined(level.var_4dad7caf)) {
    level.var_4dad7caf delete();
  }

  if(isDefined(level.var_7c9cd6ae)) {
    level.var_7c9cd6ae delete();
  }

  self notify(#"hash_7953672ffc47be3");
}

private function_aa26a9be(e_player) {
  e_player endon(#"death", #"hash_c5c509724d92ec4");
  self endon(#"death", #"hash_300e9fed7925cd69", #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
  self thread function_58808acb(e_player);
  wait 60;

  while(isalive(e_player)) {
    e_player dodamage(10, e_player.origin);
    wait 1;
  }
}

function_58808acb(e_player) {
  e_player endon(#"hash_c5c509724d92ec4");
  self endon(#"death", #"hash_300e9fed7925cd69", #"hash_7953672ffc47be3");
  e_player waittill(#"death", #"player_downed");
  self notify(#"hash_4636f041ae52f0fa");
  e_speaker = zm_utility::get_closest_player(e_player.origin);
  level thread function_629fa2c8(#"hash_26aa170c4122be2b", e_speaker);
}

private function_33701563() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  var_64aaa12a = struct::get_array("showers_kill_pos", "targetname");
  callback::on_ai_killed(&function_c8d4b885);
  level.var_b1060d52 = 0;

  while(true) {
    inventory_picku = array::random(var_64aaa12a);
    var_81de1755 = util::spawn_model("tag_origin", inventory_picku.origin, inventory_picku.angles);
    self thread function_6bb299fa();
    self thread function_613cf0a7(var_81de1755);
    var_d61ccd7e = randomfloatrange(16, 29);
    s_result = self waittilltimeout(var_d61ccd7e, #"hash_4636f041ae52f0fa", #"hash_7953672ffc47be3");
    var_81de1755 playSound(#"hash_6f41c19432e2559a");
    var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 0);
    var_81de1755 delete();
    level.var_3f1b1c67 delete();

    if(s_result._notify == #"hash_7953672ffc47be3" || s_result._notify == #"hash_4636f041ae52f0fa") {
      callback::remove_on_ai_killed(&function_c8d4b885);
      level.var_b1060d52 = undefined;
      return;
    }

    self notify(#"hash_60f9171b687c9d06");
  }
}

private function_613cf0a7(var_81de1755) {
  self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
  level.var_3f1b1c67 = spawn("trigger_radius_new", var_81de1755.origin, (512 | 1) + 2, 80, 64);
  var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 1);

  while(isDefined(var_81de1755)) {
    var_db30ff9a = 0;

    foreach(e_player in util::get_active_players()) {
      if(e_player istouching(level.var_3f1b1c67)) {
        var_db30ff9a++;
      }
    }

    switch (var_db30ff9a) {
      case 0:
        if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 1) {
          var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 1);
          level.var_3f1b1c67.maxs = (80, 80, 64);
        }

        break;
      case 1:
        if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 2) {
          var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 2);
          level.var_3f1b1c67.maxs = (98, 98, 64);
        }

        break;
      case 2:
        if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 3) {
          var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 3);
          level.var_3f1b1c67.maxs = (112, 112, 64);
        }

        break;
      case 3:
      case 4:
        if(var_81de1755 clientfield::get("" + #"hash_a51ae59006ab41b") !== 4) {
          var_81de1755 clientfield::set("" + #"hash_a51ae59006ab41b", 4);
          level.var_3f1b1c67.maxs = (128, 128, 64);
        }

        break;
    }

    waitframe(1);
  }
}

private function_6bb299fa() {
  self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");
  var_9cdf5d68 = 2;
  var_202d423f = function_841bb7a7();

  while(level.var_b1060d52 < var_202d423f) {
    n_percent = level.var_b1060d52 / 29;
    n_blood = int(10 - n_percent * 10);

    if(n_blood != var_9cdf5d68 && n_blood < 9) {
      if(isDefined(level.var_4dad7caf)) {
        level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", n_blood);
      }

      var_9cdf5d68 = n_blood;

      if(isDefined(level.var_7c9cd6ae)) {
        level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", n_blood);
      }
    }

    wait 0.2;
  }

  self notify(#"hash_7953672ffc47be3");

  if(isDefined(level.var_4dad7caf)) {
    level.var_4dad7caf clientfield::set("" + #"hash_504d26c38b96651c", 1);
  }

  if(isDefined(level.var_7c9cd6ae)) {
    level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", 1);
  }
}

function_841bb7a7() {
  var_550d6907 = 0;

  foreach(player in util::get_active_players()) {
    if(player zm_zonemgr::is_player_in_zone("cellblock_shower")) {
      var_550d6907++;
    }
  }

  var_202d423f = 29 * var_550d6907;
  return var_202d423f;
}

function_c8d4b885(s_params) {
  if(isplayer(s_params.eattacker) && isDefined(level.var_3f1b1c67) && s_params.eattacker istouching(level.var_3f1b1c67)) {
    if(isDefined(level.var_9d950ce5) && isDefined(level.var_9d950ce5.e_activator) && isDefined(level.var_3f1b1c67) && level.var_9d950ce5.e_activator istouching(level.var_3f1b1c67)) {
      self thread function_b952c1b(level.var_9d950ce5.e_activator, "tag_weapon_right");
      level.var_b1060d52++;
    }
  }
}

private function_580723de(var_1bb50dab = 1, e_player) {
  self endon(#"death", #"hash_60f9171b687c9d06", #"hash_4636f041ae52f0fa", #"hash_300e9fed7925cd69");

  if(var_1bb50dab) {
    if(isDefined(level.var_7c9cd6ae)) {
      level.var_7c9cd6ae unlink();
      level.var_7c9cd6ae delete();
    }

    if(isDefined(level.var_4dad7caf)) {
      level.var_4dad7caf show();
    }

    return;
  }

  if(isDefined(level.var_4dad7caf)) {
    level.var_4dad7caf ghost();
  }

  if(isDefined(e_player)) {
    level.var_7c9cd6ae = util::spawn_model(#"hash_122bc018037432b0", e_player gettagorigin("tag_stowed_back"), e_player gettagangles("tag_stowed_back"));
    level.var_7c9cd6ae linkto(e_player, "tag_stowed_back", (30, -2, -5), (0, 90, -90));
    level.var_7c9cd6ae clientfield::set("" + #"hash_504d26c38b96651c", 10);
    level.var_7c9cd6ae setinvisibletoplayer(e_player);
  }
}

private function_3854c592() {
  var_bdf9e3c2 = "cellblock_shower";
  a_str_active_zones = zm_cleanup::get_adjacencies_to_zone(var_bdf9e3c2);
  arrayremovevalue(a_str_active_zones, var_bdf9e3c2);
  zone_shower = level.zones[var_bdf9e3c2];
  a_str_zones = arraycopy(a_str_active_zones);

  foreach(str_zones in a_str_zones) {
    if(zone_shower.adjacent_zones[str_zones].is_connected) {
      zone_shower.adjacent_zones[str_zones].is_connected = 0;
      continue;
    }

    arrayremovevalue(a_str_active_zones, str_zones);
  }

  self waittill(#"death", #"hash_300e9fed7925cd69");

  foreach(str_zones in a_str_active_zones) {
    zone_shower.adjacent_zones[str_zones].is_connected = 1;
  }
}

private function_c11e25eb() {
  self endoncallback(&function_bc57a72c, #"death", #"hash_300e9fed7925cd69");
  b_success = undefined;
  var_4c18a58 = undefined;
  a_str_zones = array("zone_powerhouse");

  while(!(isDefined(var_4c18a58) && var_4c18a58)) {
    foreach(e_player in util::get_players()) {
      if(isDefined(e_player zm_zonemgr::is_player_in_zone(a_str_zones)) && e_player zm_zonemgr::is_player_in_zone(a_str_zones)) {
        var_4c18a58 = 1;
        break;
      }
    }

    waitframe(1);
  }

  self thread function_fb553d70();
  self function_adf8de89(e_player);
  var_58774a5e = struct::get("ph_gen_pos", "targetname");
  self thread function_eab368cb(var_58774a5e);
  self waittill(#"hash_47037a033334904");
  playsoundatposition(#"hash_7a1782a9382ccd72", var_58774a5e.origin);
  self thread function_718e6106();
  var_7ed2d43 = self waittill(#"hash_2877e7dda4d090c8");
  e_generator = getent("b64_si_gen", "script_noteworthy");
  e_generator setModel(#"p8_fxanim_zm_esc_generator_lrg_on_mod");
  e_generator thread scene::play(e_generator.bundle, "ON", e_generator);
  playsoundatposition(#"hash_5a77a78c82aebb7", e_generator.origin);
  exploder::exploder("lgtexp_building64_power_on");

  if(!(isDefined(var_7ed2d43.b_success) && var_7ed2d43.b_success)) {
    self notify(#"hash_300e9fed7925cd69", {
      #b_success: b_success
    });
    self thread function_bc57a72c();
    return;
  }

  self thread function_1fb1907c();
  s_result = self waittill(#"punchcard_pickup");
  level thread function_629fa2c8(#"hash_57a7dd2d1b78a952", s_result.activator);
  self thread function_ca9ddf1b();
  self waittill(#"hash_1548855706869d2f");
  self thread function_34e153c7();
  self thread function_bd132295();
  var_9c502e92 = self function_cadaca27();
  self notify(#"hash_3e30564346f7cd94");
  var_7df17d61 = level.var_8eec9430.origin;
  self thread function_bc57a72c();

  if(isDefined(var_9c502e92) && var_9c502e92) {
    self thread function_56e41aa6(var_7df17d61);
    level thread function_ac1d7a0e(#"hash_34aad6dd5eebdb0b", e_player);
  }

  self notify(#"hash_300e9fed7925cd69", {
    #b_success: var_9c502e92
  });
}

private function_adf8de89(e_player) {
  self endon(#"death", #"hash_300e9fed7925cd69");

  if(!isDefined(level.var_8eec9430)) {
    var_bc84fb2a = struct::get("ph_gh_sp", "targetname");
    level.var_8eec9430 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_bc84fb2a);

    while(!isDefined(level.var_8eec9430)) {
      waitframe(1);
      level.var_8eec9430 = zombie_utility::spawn_zombie(getent("g_zombie_spawner", "targetname"), "ph_gh", var_bc84fb2a);
    }
  }

  level.var_8eec9430 function_e128a8d4();
  level.var_8eec9430 thread function_a51841a(e_player, #"hash_4c753651e8079572");
  self thread function_dc369dee("ph_gh_pa");
}

private function_dc369dee(var_b51b4b08) {
  level.var_8eec9430 endon(#"death", #"hash_585dd04498227242");
  self endon(#"death", #"hash_300e9fed7925cd69");
  level.var_8eec9430.goalradius = 16;
  var_3741f4b0 = struct::get_array(var_b51b4b08, "script_noteworthy");
  level.var_8eec9430 waittilltimeout(20, #"goal");
  var_922f086e = 1;
  s_next_pos = array::random(var_3741f4b0);
  level.var_ed42611e = [];

  while(!(isDefined(level.var_8eec9430.var_ecdd7879) && level.var_8eec9430.var_ecdd7879)) {
    level.var_8eec9430 setgoal(s_next_pos.origin);
    level.var_8eec9430 waittilltimeout(20, #"goal");

    if(isDefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible && isinarray(level.var_62f48651, s_next_pos.script_int)) {
      mdl_lever = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
      mdl_lever scene::play(#"aib_vign_zm_mob_power_ghost_opperate_success", array(level.var_8eec9430, mdl_lever));

      if(!isDefined(level.var_ed42611e)) {
        level.var_ed42611e = [];
      } else if(!isarray(level.var_ed42611e)) {
        level.var_ed42611e = array(level.var_ed42611e);
      }

      if(!isinarray(level.var_ed42611e, mdl_lever)) {
        level.var_ed42611e[level.var_ed42611e.size] = mdl_lever;
      }

      arrayremovevalue(level.var_62f48651, s_next_pos.script_int);
      level.var_8eec9430 notify(#"hash_6f38117315565110", {
        #b_success: 1
      });
      self thread function_3b4d7656(s_next_pos.script_int);
    } else {
      mdl_lever = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
      mdl_lever scene::play(#"aib_vign_zm_mob_power_ghost_opperate_fail", level.var_8eec9430);

      if(!isinarray(level.var_ed42611e, mdl_lever)) {
        if(isDefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible && isinarray(level.var_62f48651, s_next_pos.script_int)) {
          mdl_lever = getent("flicker_" + s_next_pos.script_int + 1, "targetname");
          mdl_lever scene::play(#"aib_vign_zm_mob_power_ghost_opperate_success", array(level.var_8eec9430, mdl_lever));

          if(!isDefined(level.var_ed42611e)) {
            level.var_ed42611e = [];
          } else if(!isarray(level.var_ed42611e)) {
            level.var_ed42611e = array(level.var_ed42611e);
          }

          if(!isinarray(level.var_ed42611e, mdl_lever)) {
            level.var_ed42611e[level.var_ed42611e.size] = mdl_lever;
          }

          arrayremovevalue(level.var_62f48651, s_next_pos.script_int);
          level.var_8eec9430 notify(#"hash_6f38117315565110", {
            #b_success: 1
          });
          self thread function_3b4d7656(s_next_pos.script_int);
        } else if(isDefined(level.var_8eec9430.b_visible) && level.var_8eec9430.b_visible) {
          level.var_8eec9430 notify(#"hash_6f38117315565110", {
            #b_success: 0
          });
        }
      }
    }

    wait 1;
    var_25d70459 = s_next_pos;

    if(var_922f086e && isDefined(var_25d70459.target)) {
      s_next_pos = struct::get(var_25d70459.target, "targetname");
      continue;
    }

    if(var_922f086e && !isDefined(var_25d70459.target)) {
      var_922f086e = 0;
      s_next_pos = struct::get(var_25d70459.targetname, "target");
      continue;
    }

    if(!var_922f086e && var_25d70459.script_int != 0) {
      s_next_pos = struct::get(var_25d70459.targetname, "target");
      continue;
    }

    if(!var_922f086e && var_25d70459.script_int == 0) {
      var_922f086e = 1;
      s_next_pos = struct::get(var_25d70459.target, "targetname");
    }
  }
}

private function_34e153c7() {
  exploder::exploder("lgtexp_comm_monitors_on");
  var_3ab52107 = array(0, 1, 2, 3, 4, 5);
  var_3ab52107 = array::randomize(var_3ab52107);
  level.var_72ea8db7 = [];

  for(i = 0; i < 6; i++) {
    if(!isDefined(level.var_72ea8db7)) {
      level.var_72ea8db7 = [];
    } else if(!isarray(level.var_72ea8db7)) {
      level.var_72ea8db7 = array(level.var_72ea8db7);
    }

    level.var_72ea8db7[level.var_72ea8db7.size] = var_3ab52107[i];
  }

  var_3ab52107 = array::randomize(var_3ab52107);
  level.var_e2279748 = [];

  for(i = 0; i < 6; i++) {
    if(!isDefined(level.var_e2279748)) {
      level.var_e2279748 = [];
    } else if(!isarray(level.var_e2279748)) {
      level.var_e2279748 = array(level.var_e2279748);
    }

    level.var_e2279748[level.var_e2279748.size] = var_3ab52107[i];
  }

  level.var_62f48651 = [];

  for(i = 0; i < level.var_30e1cfa.size; i++) {
    n_result = level.var_e2279748[level.var_30e1cfa[i]];

    if(!isDefined(level.var_62f48651)) {
      level.var_62f48651 = [];
    } else if(!isarray(level.var_62f48651)) {
      level.var_62f48651 = array(level.var_62f48651);
    }

    level.var_62f48651[level.var_62f48651.size] = n_result;
  }

  level.var_6df70f90 = getEntArray("jcc_01", "targetname");

  foreach(mdl_monitor in level.var_6df70f90) {
    var_aa794395 = mdl_monitor.origin + anglesToForward(mdl_monitor.angles) * -15;
    mdl_monitor.t_interact = spawn("trigger_radius_use", var_aa794395, 0, 64, 64);
    mdl_monitor.t_interact sethintstring(#"");
    mdl_monitor.t_interact setcursorhint("HINT_NOICON");
    mdl_monitor.t_interact triggerignoreteam();
    mdl_monitor thread function_a9c796c9(1);
    mdl_monitor thread function_3f41df11(self);
  }

  self waittill(#"death", #"hash_300e9fed7925cd69");

  foreach(mdl_monitor in level.var_6df70f90) {
    mdl_monitor setModel(#"p8_zm_esc_comm_monitor_sml_01_screen_off");
    mdl_monitor.t_interact delete();
    mdl_monitor thread function_a9c796c9(0);
  }

  var_e1b1210d = getent("md_te_mi", "targetname");
  var_e1b1210d setModel(#"hash_75a106abbb5f5fa1");
  var_e1b1210d playSound(#"hash_4bf7a429b9e473");
  var_e1b1210d stoploopsound();
  exploder::stop_exploder("lgtexp_comm_monitors_on");
}

function_a9c796c9(var_ad361c37) {
  self endon(#"death");
  wait randomfloatrange(0, 0.4);

  if(var_ad361c37) {
    self playSound(#"hash_36db3f0a61c9a48f");
    self playLoopSound(#"hash_36df3b0a61cd869a");
    return;
  }

  self stoploopsound();
  self playSound(#"hash_4bf7a429b9e473");
}

private function_3f41df11(var_aa11c23c) {
  var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69");
  var_fda10a91 = array(#"hash_7b807c00f606fd42", #"hash_7b807b00f606fb8f", #"hash_7b807a00f606f9dc", #"hash_7b807900f606f829", #"hash_7b807800f606f676", #"hash_7b807700f606f4c3", #"hash_7b807600f606f310", #"hash_7b808500f6070c8d", #"hash_7b808400f6070ada", #"hash_7b7cf700f603e56c", #"hash_7b7cf800f603e71f", #"hash_7b7cf900f603e8d2");
  n_ph = level.var_72ea8db7[self.script_int];
  var_d7fe6e89 = var_fda10a91[n_ph];
  var_888f63a1 = level.var_e2279748[n_ph] + 6;
  var_6695748c = var_fda10a91[var_888f63a1];
  self setModel(var_d7fe6e89);
  var_a9ef48ba = var_6695748c;

  while(isDefined(self.t_interact)) {
    s_result = self.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      self setModel(var_a9ef48ba);
      self playSound(#"hash_552ae6616a45cb98");

      if(var_a9ef48ba == var_6695748c) {
        var_a9ef48ba = var_d7fe6e89;
      } else {
        var_a9ef48ba = var_6695748c;
      }
    }

    wait 0.15;
  }
}

private function_cadaca27() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  level.var_8eec9430 endon(#"death");
  level.var_8eec9430.script_noteworthy = "blast_attack_interactables";

  while(!(isDefined(level.var_8eec9430.var_ecdd7879) && level.var_8eec9430.var_ecdd7879)) {
    level.var_8eec9430 waittill(#"blast_attack");
    level.var_8eec9430 clientfield::set("" + #"hash_65da20412fcaf97e", 0);
    level.var_8eec9430.b_visible = 1;
    s_result = level.var_8eec9430 waittill(#"hash_6f38117315565110");
    level.var_8eec9430 clientfield::set("" + #"hash_65da20412fcaf97e", 2);
    level.var_8eec9430.b_visible = undefined;

    if(!(isDefined(s_result.b_success) && s_result.b_success)) {
      level.var_8eec9430.var_ecdd7879 = 1;
      return false;
    }

    if(level.var_62f48651.size <= 0) {
      level.var_8eec9430.var_ecdd7879 = 1;
      return true;
    }
  }

  return false;
}

function_3b4d7656(n_num) {
  level.var_8eec9430 endon(#"death", #"hash_585dd04498227242");
  self endon(#"death", #"hash_300e9fed7925cd69");

  switch (n_num) {
    case 0:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
    case 1:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
    case 2:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
    case 3:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
    case 4:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
    case 5:
      mdl_panel = getent("ph_p_1", "script_noteworthy");
      break;
  }

  mdl_panel thread scene::play(mdl_panel.bundle, "GREEN", mdl_panel);
  mdl_panel playSound(#"hash_30d4c7c667c80123");
  wait 3;
  mdl_panel thread scene::play(mdl_panel.bundle, "RESET", mdl_panel);
}

private function_eab368cb(s_interact) {
  self endon(#"death", #"hash_300e9fed7925cd69");
  e_generator = getent("b64_si_gen", "script_noteworthy");
  e_generator setModel(#"p8_fxanim_zm_esc_generator_lrg_mod");
  e_generator thread scene::play(e_generator.bundle, "OFF", e_generator);
  s_interact.var_b31fa41a = util::spawn_model("tag_origin", s_interact.origin, s_interact.angles);
  s_interact.var_b31fa41a clientfield::set("" + #"hash_64f2dd36b17bf17", 1);
  s_interact.t_interact = spawn("trigger_radius_use", s_interact.origin, 0, 128, 64);
  s_interact.t_interact sethintstring(#"");
  s_interact.t_interact setcursorhint("HINT_NOICON");
  s_interact.t_interact triggerignoreteam();
  s_interact.t_interact setvisibletoall();

  while(true) {
    s_result = s_interact.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      s_interact.e_activator = s_result.activator;
      break;
    }
  }

  s_interact.t_interact delete();
  s_interact.var_b31fa41a clientfield::set("" + #"hash_64f2dd36b17bf17", 0);
  s_interact.var_b31fa41a delete();
  exploder::stop_exploder("lgtexp_building64_power_on");
  self notify(#"hash_47037a033334904");
}

private function_718e6106() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  b_success = undefined;

  if(!isDefined(level.var_6ab72806)) {
    level.var_6ab72806 = 5;
  }

  if(!isDefined(level.var_f7febee4)) {
    level function_18b599e0();
  }

  b_success = self function_dc164d78();
  self notify(#"hash_3e30564346f7cd94");
  self notify(#"hash_2877e7dda4d090c8", {
    #b_success: b_success
  });

  if(isDefined(b_success) && b_success) {
    level.var_f7febee4 = array::randomize(level.var_f7febee4);
    level.var_30e1cfa = array(level.var_f7febee4[0].script_int, level.var_f7febee4[1].script_int, level.var_f7febee4[2].script_int);
    var_abad41d = [];

    foreach(var_7b2c16b1 in level.var_f7febee4) {
      if(isinarray(level.var_30e1cfa, var_7b2c16b1.script_int)) {
        if(!isDefined(var_abad41d)) {
          var_abad41d = [];
        } else if(!isarray(var_abad41d)) {
          var_abad41d = array(var_abad41d);
        }

        if(!isinarray(var_abad41d, var_7b2c16b1.mdl_light)) {
          var_abad41d[var_abad41d.size] = var_7b2c16b1.mdl_light;
        }

        var_7b2c16b1.mdl_light setModel(#"p8_zm_zod_light_bulb_01_on");
        var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
        continue;
      }

      var_7b2c16b1.mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
      var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
    }

    wait 6;
    var_a94e126 = 0;
    var_47df32b8 = 1;

    while(var_a94e126 < 7) {
      foreach(mdl_light in var_abad41d) {
        if(isDefined(var_47df32b8) && var_47df32b8) {
          mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
          var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
          var_47df32b8 = 0;
          continue;
        }

        mdl_light setModel(#"p8_zm_zod_light_bulb_01_on");
        var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
        var_47df32b8 = 1;
      }

      var_a94e126++;
      wait 0.2;
    }
  }

  level.var_89231fe9 = undefined;
  level.var_84fbe7bc = undefined;

  if(isDefined(level.var_f7febee4)) {
    foreach(var_7b2c16b1 in level.var_f7febee4) {
      if(isDefined(var_7b2c16b1.mdl_light)) {
        var_7b2c16b1.mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
        var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
      }

      if(isDefined(var_7b2c16b1.t_interact)) {
        var_7b2c16b1.t_interact setinvisibletoall();
      }
    }
  }
}

function_18b599e0() {
  level.var_f7febee4 = struct::get_array("64_sm_pos", "targetname");

  foreach(var_7b2c16b1 in level.var_f7febee4) {
    var_7b2c16b1.mdl_symbol = util::spawn_model(var_7b2c16b1.model, var_7b2c16b1.origin, var_7b2c16b1.angles);
    var_7b2c16b1.mdl_light = getent(var_7b2c16b1.target, "targetname");
    var_7b2c16b1.t_interact = spawn("trigger_radius_use", var_7b2c16b1.origin, 0, 64, 64);
    var_7b2c16b1.t_interact sethintstring(#"");
    var_7b2c16b1.t_interact setcursorhint("HINT_NOICON");
    var_7b2c16b1.t_interact triggerignoreteam();
    var_7b2c16b1.t_interact setinvisibletoall();
  }

  level.var_b530c85c = [];
  var_dcb38ed6 = struct::get_array("ph_sm_pos", "targetname");

  foreach(var_85151c86 in var_dcb38ed6) {
    mdl_symbol = util::spawn_model(var_85151c86.model, var_85151c86.origin, var_85151c86.angles);

    if(!isDefined(level.var_b530c85c)) {
      level.var_b530c85c = [];
    } else if(!isarray(level.var_b530c85c)) {
      level.var_b530c85c = array(level.var_b530c85c);
    }

    if(!isinarray(level.var_b530c85c, mdl_symbol)) {
      level.var_b530c85c[level.var_b530c85c.size] = mdl_symbol;
    }
  }
}

private function_dc164d78() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  level.var_84fbe7bc = function_1b0a3e6e();
  var_56eace20 = 1;
  b_trace_passed = 0;
  n_start_time = gettime();

  for(n_total_time = 0; !(isDefined(b_trace_passed) && b_trace_passed)&n_total_time < 6.1; n_total_time = (n_current_time - n_start_time) / 1000) {
    foreach(e_player in util::get_players()) {
      if(isDefined(level.var_84fbe7bc[0].mdl_symbol sightconetrace(e_player getEye(), e_player, vectornormalize(e_player getplayerangles()), 30)) && level.var_84fbe7bc[0].mdl_symbol sightconetrace(e_player getEye(), e_player, vectornormalize(e_player getplayerangles()), 30)) {
        b_trace_passed = 1;
        break;
      }
    }

    waitframe(1);
    n_current_time = gettime();
  }

  self thread function_bd132295();

  while(var_56eace20 <= level.var_6ab72806) {
    for(i = 0; i < var_56eace20; i++) {
      level.var_84fbe7bc[i].mdl_light setModel(#"p8_zm_zod_light_bulb_01_on");
      level.var_84fbe7bc[i].mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
      wait 3.9;
      level.var_84fbe7bc[i].mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
      level.var_84fbe7bc[i].mdl_light clientfield::set("" + #"hash_119729072e708651", 0);

      if(var_56eace20 > 1) {
        wait 1.3;
      }
    }

    foreach(var_7b2c16b1 in level.var_f7febee4) {
      var_7b2c16b1.t_interact setvisibletoall();
    }

    level.var_89231fe9 = 0;
    array::thread_all(level.var_f7febee4, &function_81650808, self, var_56eace20);
    s_result = self waittilltimeout(30, #"hash_34486fb413da1672");

    foreach(var_7b2c16b1 in level.var_f7febee4) {
      var_7b2c16b1.t_interact setinvisibletoall();
    }

    if(!(isDefined(s_result.b_success) && s_result.b_success)) {
      if(isDefined(s_result.e_player)) {
        s_result.e_player playlocalsound(#"hash_1588095b858588d");
      }

      return false;
    }

    foreach(var_7b2c16b1 in level.var_f7febee4) {
      if(isDefined(var_7b2c16b1.mdl_light)) {
        var_7b2c16b1.mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
        var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
      }
    }

    var_56eace20++;
    level.var_84fbe7bc = function_1b0a3e6e();
  }

  playsoundatposition(#"hash_2218138040c6b2ff", (0, 0, 0));
  return true;
}

private function_81650808(var_aa11c23c, var_56eace20) {
  var_aa11c23c endon(#"death", #"hash_300e9fed7925cd69", #"hash_34486fb413da1672");

  while(level.var_89231fe9 < var_56eace20) {
    s_result = self.t_interact waittill(#"trigger");
    self.mdl_light setModel(#"p8_zm_zod_light_bulb_01_on");
    self.mdl_light clientfield::set("" + #"hash_119729072e708651", 1);
    wait 1;
    self.mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
    self.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
    wait 1;

    if(self !== level.var_84fbe7bc[level.var_89231fe9]) {
      var_aa11c23c notify(#"hash_34486fb413da1672", {
        #b_success: 0, 
        #e_player: s_result.activator
      });
    }

    level.var_89231fe9++;
  }

  var_aa11c23c notify(#"hash_34486fb413da1672", {
    #b_success: 1, 
    #e_player: s_result.activator
  });
}

private function_1b0a3e6e() {
  var_84fbe7bc = [];
  var_f3b29ae8 = undefined;

  for(i = 0; i < level.var_6ab72806; i++) {
    s_pos[i] = array::random(level.var_f7febee4);

    if(i >= 2 && s_pos[i] == var_f3b29ae8 && s_pos[i] == s_pos[i - 2]) {
      while(s_pos[i] === var_f3b29ae8) {
        s_pos[i] = array::random(level.var_f7febee4);
      }
    }

    if(!isDefined(var_84fbe7bc)) {
      var_84fbe7bc = [];
    } else if(!isarray(var_84fbe7bc)) {
      var_84fbe7bc = array(var_84fbe7bc);
    }

    var_84fbe7bc[var_84fbe7bc.size] = s_pos[i];
    var_f3b29ae8 = s_pos[i];
  }

  return var_84fbe7bc;
}

private function_bc57a72c(var_c34665fc) {
  if(isDefined(level.var_ed42611e) && level.var_ed42611e.size) {
    foreach(var_7cc5799f in level.var_ed42611e) {
      if(!isDefined(var_7cc5799f)) {
        continue;
      }

      var_7cc5799f scene::stop(#"aib_vign_zm_mob_power_ghost_opperate_success");
      var_7cc5799f animation::stop();
      waitframe(1);

      if(isDefined(var_7cc5799f)) {
        var_7cc5799f thread scene::init(#"aib_vign_zm_mob_power_ghost_opperate_success", array(level.var_8eec9430, var_7cc5799f));
      }
    }

    level.var_ed42611e = undefined;
  }

  if(isDefined(level.var_8eec9430)) {
    level.var_8eec9430 notify(#"hash_585dd04498227242");
    level.var_8eec9430 delete();
  }

  var_58774a5e = struct::get("ph_gen_pos", "targetname");

  if(isDefined(var_58774a5e.t_interact)) {
    var_58774a5e.t_interact delete();
  }

  if(isDefined(var_58774a5e.var_b31fa41a)) {
    var_58774a5e.var_b31fa41a delete();
  }

  level.var_89231fe9 = undefined;
  level.var_84fbe7bc = undefined;

  if(isDefined(level.var_f7febee4)) {
    foreach(var_7b2c16b1 in level.var_f7febee4) {
      if(isDefined(var_7b2c16b1.mdl_light)) {
        var_7b2c16b1.mdl_light setModel(#"p8_zm_zod_light_bulb_01_off");
        var_7b2c16b1.mdl_light clientfield::set("" + #"hash_119729072e708651", 0);
      }

      if(isDefined(var_7b2c16b1.t_interact)) {
        var_7b2c16b1.t_interact setinvisibletoall();
      }
    }
  }

  var_78fda516 = struct::get("ph_pc_pos", "targetname");

  if(isDefined(var_78fda516.var_11e3fffb)) {
    var_78fda516.var_11e3fffb delete();
  }

  if(isDefined(var_78fda516.t_interact)) {
    var_78fda516.t_interact delete();
  }

  var_e1b1210d = getent("md_te_mi", "targetname");

  if(isDefined(var_e1b1210d)) {
    var_e1b1210d setModel(#"hash_75a106abbb5f5fa1");

    if(isDefined(var_e1b1210d.t_interact)) {
      var_e1b1210d.t_interact delete();
    }
  }
}

private function_1fb1907c() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  var_78fda516 = struct::get("ph_pc_pos", "targetname");
  var_78fda516.var_11e3fffb = util::spawn_model(var_78fda516.model, var_78fda516.origin, var_78fda516.angles);
  var_78fda516.var_11e3fffb playSound(#"hash_13aeee936e183bc7");
  var_78fda516.t_interact = spawn("trigger_radius_use", var_78fda516.origin, 0, 64, 64);
  var_78fda516.t_interact sethintstring(#"");
  var_78fda516.t_interact setcursorhint("HINT_NOICON");
  var_78fda516.t_interact triggerignoreteam();

  while(true) {
    s_result = var_78fda516.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      s_result.activator playSound(#"hash_5cc174edb720191c");
      var_78fda516.var_11e3fffb delete();
      break;
    }
  }

  self notify(#"punchcard_pickup", {
    #activator: s_result.activator
  });
}

private function_ca9ddf1b() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  var_e1b1210d = getent("md_te_mi", "targetname");
  var_aa794395 = var_e1b1210d.origin + anglesToForward(var_e1b1210d.angles) * -15 + (0, 0, 5);
  var_e1b1210d.t_interact = spawn("trigger_radius_use", var_aa794395, 0, 64, 64);
  var_e1b1210d.t_interact sethintstring(#"");
  var_e1b1210d.t_interact setcursorhint("HINT_NOICON");
  var_e1b1210d.t_interact triggerignoreteam();

  while(isDefined(var_e1b1210d.t_interact)) {
    s_result = var_e1b1210d.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      var_e1b1210d setModel(#"hash_1cfe304d7d3199a5");
      var_e1b1210d playSound(#"hash_2ebc34552a47c16f");
      var_e1b1210d playLoopSound(#"hash_2ebf30552a49f07a");
      self notify(#"hash_1548855706869d2f");
      var_e1b1210d.t_interact delete();
    }
  }
}

private function_fb553d70() {
  level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_01", &function_23467a20, "play");
  level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_02", &function_23467a20, "play");
  level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_03", &function_23467a20, "play");
  level scene::add_scene_func(#"p8_fxanim_zm_escape_pigeon_standing_04", &function_23467a20, "play");
  a_s_pigeons = struct::get_array("ph_gh_pi", "targetname");

  foreach(s_pigeon in a_s_pigeons) {
    s_pigeon thread scene::play();
  }

  self waittill(#"death", #"hash_300e9fed7925cd69");

  foreach(s_pigeon in a_s_pigeons) {
    s_pigeon thread scene::stop();
  }
}

function_23467a20(a_ents) {
  foreach(e_ent in a_ents) {
    e_ent clientfield::set("" + #"hash_504d26c38b96651c", 1);
    e_ent clientfield::set("" + #"hash_65da20412fcaf97e", 1);
  }
}

private function_bd132295() {
  self endon(#"death", #"hash_300e9fed7925cd69", #"hash_3e30564346f7cd94");

  if(util::get_players().size == 1) {
    return;
  }

  while(true) {
    wait randomfloatrange(3, 15);

    if(zombie_utility::get_current_zombie_count() < zombie_utility::get_zombie_var(#"zombie_max_ai")) {
      ai_dog = zombie_utility::spawn_zombie(level.dog_spawners[0]);
    }
  }
}

private function_629fa2c8(var_5b9ba5a5, e_player) {
  level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");

  if(!isalive(e_player)) {
    e_player = array::random(util::get_active_players());
  }

  switch (var_5b9ba5a5) {
    case #"hash_57e9c23bed1bd753":
      str_vo_line = #"hash_e6dbc38573eb591";
      break;
    case #"ghost_disappears":
      str_vo_line = #"hash_75dd4d3a12f7a4ff";
      break;
    case #"hash_2ea20c8cd81b5464":
      str_vo_line = #"hash_2db7e999104e9d85";
      break;
    case #"hash_72bb7bc935d4da67":
      str_vo_line = #"hash_7908358765812286";
      break;
    case #"hash_fd8e78c22906fc1":
      str_vo_line = #"hash_5f84ae79adca64b4";
      break;
    case #"hash_115ac6d40d4cc85b":
      str_vo_line = #"hash_459548ac9c477e2e";
      break;
    case #"hash_1d191ca6765471c6":
      str_vo_line = #"hash_58698646dc41b7cc";
      break;
    case #"hash_7cf90fc327de893e":
      str_vo_line = #"hash_346283ac47189915";
      break;
    case #"hash_7ab135537c096a5a":
      str_vo_line = #"hash_4de71ac9ed523e0f";
      break;
    case #"hash_4c753651e8079572":
      str_vo_line = #"hash_6a36332b44f8f69";
      break;
    case #"hash_487ac9fba78b1604":
      str_vo_line = #"hash_6aa237e9482e5cd2";
      break;
    case #"hash_57a7dd2d1b78a952":
      str_vo_line = #"hash_449831e8d03243ab";
      break;
    case #"hash_1e0663f4102106fa":
      str_vo_line = #"hash_21d36ad9aebdc862";
      break;
    case #"hash_46252c9e0b200ae6":
      str_vo_line = #"hash_420cd62afa5f7e5f";
      break;
    case #"hash_26aa170c4122be2b":
      str_vo_line = #"hash_7cf068b4ca0db57b";
      break;
  }

  e_player zm_vo::function_a2bd5a0c(str_vo_line, 0, 1, 9999, 0, 0, 1);
}

private function_ac1d7a0e(var_5b9ba5a5, e_player) {
  level endon(#"hash_11fb44a7b531b27d", #"hash_54eae43edf7f08cd");

  if(!isalive(e_player)) {
    e_player = array::random(util::get_active_players());
  }

  e_richtofen = paschal::function_b1203924();
  var_2c5c52cb = e_player zm_characters::function_d35e4c92() - 5;

  switch (var_5b9ba5a5) {
    case #"hash_368df266f54ec3b1":
      str_vo_line = #"hash_49abe33ce5251a4b";
      var_6d4b089d = #"hash_4a5baedb3bc6ec08";
      var_566e10e3 = #"hash_49abe53ce5251db1";
      break;
    case #"hash_7d360b71501ba662":
      str_vo_line = #"hash_647c6e21cc49b3cc";
      var_6d4b089d = #"hash_1ec507e435e1a4bd";
      var_566e10e3 = #"hash_647c7021cc49b732";
      break;
    case #"hash_53aafd7783e33981":
      str_vo_line = #"hash_6fb17b666e2addfb";
      var_6d4b089d = #"hash_5cfddff273a7cf98";
      var_566e10e3 = #"hash_6fb17d666e2ae161";
      break;
    case #"hash_34aad6dd5eebdb0b":
      str_vo_line = #"hash_da5ecd0d4841b4a";
      var_6d4b089d = #"hash_4b6f538c82ce10eb";
      var_566e10e3 = #"hash_da5ead0d48417e4";
      break;
    case #"hash_51300ea0974da947":
      str_vo_line = #"hash_3563aeaee897cb95";
      var_6d4b089d = #"hash_54fabdc91a5724b2";
      var_566e10e3 = #"hash_3563acaee897c82f";
      break;
    case #"hash_334295910a49036e":
      str_vo_line = #"hash_780ebb7a9f39cdc8";
      var_6d4b089d = #"hash_69a626c29083fc71";
      var_566e10e3 = #"hash_780ebd7a9f39d12e";
      break;
  }

  for(b_said = undefined; !(isDefined(b_said) && b_said); b_said = e_player zm_vo::function_a2bd5a0c(str_vo_line, 0, 1, 9999)) {
    zm_vo::function_3c173d37(e_player.origin, 512);
  }

  if(!isDefined(e_richtofen) || !isalive(e_richtofen) || !(isDefined(e_richtofen.var_59dde2f6) && e_richtofen.var_59dde2f6)) {
    return;
  }

  e_richtofen zm_vo::vo_stop();
  b_say = e_richtofen zm_vo::vo_say(var_6d4b089d, 0, 1, 9999, 1, 1, 1);

  for(var_350e5be3 = undefined; !(isDefined(var_350e5be3) && var_350e5be3) && isalive(e_richtofen); var_350e5be3 = e_richtofen zm_vo::function_a2bd5a0c(var_566e10e3, 0, 1, 9999)) {
    zm_vo::function_3c173d37(e_richtofen.origin, 512);
  }
}

private function_29d29761(e_ghost, var_5b9ba5a5) {
  e_ghost endon(#"death", #"ghost_seen");
  self endon(#"disconnect");

  while(true) {
    if(self zm_utility::is_player_looking_at(e_ghost getcentroid()) && self clientfield::get("" + #"afterlife_vision_play")) {
      if(!(isDefined(level.var_9cb7c32e) && level.var_9cb7c32e)) {
        level.var_9cb7c32e = 1;
        level function_629fa2c8(#"hash_57e9c23bed1bd753", self);
        wait 0.5;
      }

      level thread function_629fa2c8(var_5b9ba5a5, self);
      e_ghost notify(#"ghost_seen");
    }

    waitframe(1);
  }
}

private function_a9277243() {
  self endon(#"death");
  self.t_interact = spawn("trigger_radius_use", self.origin, 0, 94, 64);
  self.t_interact sethintstring(#"");
  self.t_interact setcursorhint("HINT_NOICON");
  self.t_interact triggerignoreteam();

  while(isDefined(self.t_interact)) {
    s_result = self.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      self notify(#"hash_1f3cf68a268a10f1");
      self.t_interact delete();
    }
  }
}

private function_e128a8d4(var_982513ee = 1) {
  if(!var_982513ee) {
    self clientfield::set("" + #"hash_3e506d7aedac6ae0", 10);
  }

  self setteam(util::get_enemy_team(level.zombie_team));
  self.health = 961;
  self val::set(#"ai_ghost", "ignoreme", 1);
  self val::set(#"ai_ghost", "ignoreall", 1);
  self val::set(#"ai_ghost", "allowdeath", 0);
  self setCanDamage(0);
  self.b_ignore_cleanup = 1;
  self.var_77858b62 = &function_1cda4094;
  self.disable_flame_fx = 1;
  self notsolid();
}

private function_3e62ca0b(ai_ghost) {
  self endon(#"death", #"hash_300e9fed7925cd69");
  ai_ghost endon(#"death", #"blast_attack", #"hash_585dd04498227242");
  wait 90;
  level waittill(#"between_round_over");
  self notify(#"hash_300e9fed7925cd69", {
    #b_success: 0, 
    #var_d0af61fc: 1
  });
}

private function_a51841a(e_attacker, var_5b9ba5a5) {
  self clientfield::set("" + #"hash_65da20412fcaf97e", 1);
  array::thread_all(util::get_players(), &function_29d29761, self, var_5b9ba5a5);
}

private function_1db8a8b2(var_b51b4b08) {
  self endon(#"death", #"hash_585dd04498227242");
  var_3741f4b0 = struct::get_array(var_b51b4b08, "script_noteworthy");
  var_25d70459 = arraygetclosest(self.origin, var_3741f4b0);
  s_next_pos = struct::get(var_25d70459.target, "targetname");
  self.goalradius = 64;
  v_pos = getclosestpointonnavmesh(var_25d70459.origin, 128, 16);
  assert(isDefined(v_pos), "<dev string:xfa>" + var_25d70459.origin);
  wait 2.9;
  self setgoal(v_pos);
  self waittilltimeout(20, #"goal");

  while(true) {
    self setgoal(s_next_pos.origin);
    self waittilltimeout(20, #"goal");
    var_25d70459 = s_next_pos;

    if(isDefined(var_25d70459.target)) {
      s_next_pos = struct::get(var_25d70459.target, "targetname");
    }
  }
}

private function_768e71d5() {
  self endon(#"death", #"hash_71716a8e79096aee");
  self.t_interact = spawn("trigger_radius_use", self.origin + anglesToForward(self.angles) * 15 + (0, 0, 5), 0, 64, 64);
  self.t_interact enablelinkto();
  self.t_interact linkto(self);
  self.t_interact sethintstring(#"");
  self.t_interact setcursorhint("HINT_NOICON");
  self.t_interact triggerignoreteam();
  self.t_interact setvisibletoall();
  self.t_interact endon(#"death");

  while(true) {
    s_result = self.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      self notify(#"hash_17de7292d988f537");
      self.e_activator = s_result.activator;
      self playSound(#"hash_3ebf00b76f5438f8");
    }
  }
}

private function_cd0d0123(a_s_firewalls, str_exploder) {
  var_d3c21d73 = (0, 0, 48);
  level zm_bgb_anywhere_but_here::function_886fce8f(0);

  foreach(s_firewall in a_s_firewalls) {
    s_firewall.var_3cefdbf5 = util::spawn_model("collision_player_wall_128x128x10", s_firewall.origin + var_d3c21d73, s_firewall.angles);
    s_firewall.var_3cefdbf5 ghost();
  }

  if(isDefined(str_exploder)) {
    exploder::exploder(str_exploder);
  }

  self waittill(#"death", #"hash_300e9fed7925cd69");

  if(isDefined(str_exploder)) {
    exploder::stop_exploder(str_exploder);
  }

  foreach(s_firewall in a_s_firewalls) {
    if(isDefined(s_firewall.var_3cefdbf5)) {
      s_firewall.var_3cefdbf5 delete();
    }
  }

  level zm_bgb_anywhere_but_here::function_886fce8f(1);
}

function_1cda4094(e_player) {
  self notify(#"hash_3f91506396266ee6");
  self endon(#"hash_3f91506396266ee6");
  e_player endon(#"disconnect");

  if(!isalive(self) || isDefined(self.var_5bf7575e) && self.var_5bf7575e || isDefined(self.aat_turned) && self.aat_turned || !(isDefined(self.var_c95261d) && self.var_c95261d)) {
    return;
  }

  self.var_5bf7575e = 1;
  self ai::stun();
  self.instakill_func = &function_6472c628;

  if(!self clientfield::get("" + #"zombie_spectral_key_stun")) {
    var_21c1ba1 = e_player getentitynumber();
    self clientfield::set("" + #"zombie_spectral_key_stun", var_21c1ba1 + 1);
    e_player clientfield::set("" + #"spectral_key_beam_flash", 2);
  }

  while(e_player.var_f1b20bef === self && isalive(self) && isDefined(self.var_c95261d) && self.var_c95261d) {
    waitframe(1);
  }

  var_d64818ae = e_player clientfield::get("" + #"spectral_key_beam_flash");

  if(e_player attackbuttonpressed() && var_d64818ae === 2) {
    e_player clientfield::set("" + #"spectral_key_beam_flash", 1);
  }

  if(isalive(self)) {
    if(self clientfield::get("" + #"zombie_spectral_key_stun")) {
      self clientfield::set("" + #"zombie_spectral_key_stun", 0);
    }

    self.var_5bf7575e = 0;
    self ai::clear_stun();
    self.instakill_func = undefined;
  }
}

private function_6472c628(e_player, mod, shitloc) {
  w_current = e_player getcurrentweapon();

  if(w_current === level.var_d7e67022 || w_current === level.var_637136f3) {
    return true;
  }

  return false;
}

private function_b952c1b(var_4bdd091b, str_tag = "j_spinelower") {
  var_4bdd091b endon(#"death", #"hash_71716a8e79096aee");
  v_pos = self getcentroid();
  var_88f24b00 = util::spawn_model("tag_origin", v_pos + (0, 0, 12), self.angles);
  var_88f24b00 clientfield::set("" + #"spectral_key_essence", 1);
  var_88f24b00 playSound(#"zmb_sq_souls_release");
  n_dist = distance(var_88f24b00.origin, var_4bdd091b gettagorigin(str_tag));
  n_move_time = n_dist / 800;
  n_dist_sq = distance2dsquared(var_88f24b00.origin, var_4bdd091b gettagorigin(str_tag));
  n_start_time = gettime();
  n_total_time = 0;

  while(n_dist_sq > 576 && isalive(var_4bdd091b)) {
    var_88f24b00 moveto(var_4bdd091b gettagorigin(str_tag), n_move_time);
    wait 0.1;

    if(isalive(var_4bdd091b)) {
      n_current_time = gettime();
      n_total_time = (n_current_time - n_start_time) / 1000;
      n_move_time = var_4bdd091b zm_weap_spectral_shield::function_f40aa0ef(var_88f24b00, n_total_time);

      if(n_move_time == 0) {
        break;
      }

      n_dist_sq = distance2dsquared(var_88f24b00.origin, var_4bdd091b getEye());
    }
  }

  var_4bdd091b playSound(#"zmb_sq_souls_impact");
  var_88f24b00 clientfield::set("" + #"spectral_key_essence", 0);
  wait 0.5;
  var_4bdd091b notify(#"hash_7b36770a2988e5d1");
  var_88f24b00 delete();
}

private function_56e41aa6(var_7df17d61) {
  var_be009f9c = self.var_be009f9c;

  if(!isDefined(var_7df17d61)) {
    return 0;
  }

  var_b212834c = getclosestpointonnavmesh(var_7df17d61, 128, 16);

  if(isDefined(var_b212834c)) {
    var_7df17d61 = var_b212834c;
    var_b212834c = groundtrace(var_7df17d61 + (0, 0, 100), var_7df17d61 + (0, 0, -1000), 0, undefined, 0)[#"position"];

    if(isDefined(var_b212834c)) {
      var_7df17d61 = var_b212834c;
    }
  }

  b_success = level function_252499a3(var_7df17d61);

  if(b_success) {
    if(!isDefined(level.var_659daf1d)) {
      level.var_659daf1d = [];
    } else if(!isarray(level.var_659daf1d)) {
      level.var_659daf1d = array(level.var_659daf1d);
    }

    if(!isinarray(level.var_659daf1d, var_be009f9c)) {
      level.var_659daf1d[level.var_659daf1d.size] = var_be009f9c;
    }
  }

  return b_success;
}

private function_252499a3(v_pos) {
  mdl_orb = util::spawn_model(#"p8_zm_esc_orb_red_small", v_pos + (0, 0, 5));
  mdl_orb setscale(4);
  mdl_orb playSound(#"hash_748c338212771d3");
  mdl_orb.t_interact = spawn("trigger_radius_use", v_pos + (0, 0, 20), 0, 64, 64);
  mdl_orb.t_interact sethintstring(#"");
  mdl_orb.t_interact setcursorhint("HINT_NOICON");
  mdl_orb.t_interact triggerignoreteam();

  while(isDefined(mdl_orb)) {
    s_result = mdl_orb.t_interact waittill(#"trigger");

    if(isplayer(s_result.activator)) {
      playsoundatposition(#"hash_6aa220e65103f345", mdl_orb.origin);
      mdl_orb.t_interact delete();
      mdl_orb delete();
      s_result.activator thread zm_audio::create_and_play_dialog(#"generic", #"response_positive");
      return 1;
    }
  }
}

private function_2c4516ae(str_door_name) {
  a_e_zombie_doors = getEntArray(str_door_name, "target");

  foreach(zombie_door in a_e_zombie_doors) {
    if(isDefined(zombie_door.b_opened) && zombie_door.b_opened) {
      continue;
    }

    zombie_door notify(#"trigger", {
      #activator: zombie_door, 
      #is_forced: 1
    });
    zombie_door.script_flag_wait = undefined;
    zombie_door notify(#"power_on");
    zombie_door.b_opened = 1;
  }
}

private function_ff88f6aa(v_teleport_position) {
  self endon(#"blast_attack", #"death");

  while(true) {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin);

    if(!isDefined(str_zone)) {
      self forceteleport(v_teleport_position, self.angles, 1, 1);
    }

    wait 1;
  }
}

private function_9b1d9d6a() {
  var_2d52f9db = struct::get("p_l_exp");
  var_fe4d15a4 = var_2d52f9db.scene_ents[#"prop 1"];
  var_2287bf7c = [];

  foreach(e_player in util::get_players()) {
    if(isalive(e_player) && var_fe4d15a4 sightconetrace(e_player getweaponmuzzlepoint(), e_player, e_player getweaponforwarddir(), 70)) {
      if(!isDefined(var_2287bf7c)) {
        var_2287bf7c = [];
      } else if(!isarray(var_2287bf7c)) {
        var_2287bf7c = array(var_2287bf7c);
      }

      var_2287bf7c[var_2287bf7c.size] = e_player;
    }

    waitframe(1);
  }

  if(var_2287bf7c.size > 0) {
    var_2287bf7c = array::randomize(var_2287bf7c);

    foreach(e_player in var_2287bf7c) {
      if(e_player zm_audio::can_speak()) {
        str_alias = #"hash_2240a0ede7e89d42" + e_player zm_characters::function_d35e4c92();
        var_db4208eb = zm_audio::get_valid_lines(str_alias);
        var_346ed7cd = 5 - level.var_85cc9fcc.size;
        str_alias = var_db4208eb[var_346ed7cd];
        zm_vo::function_3c173d37(e_player.origin, 512);
        e_player thread zm_vo::vo_say(str_alias, 0, 0, 9999);
        return;
      }
    }
  }
}

function_96ac2d88() {
  if(!getdvarint(#"zm_debug_ee", 0)) {
    return;
  }

  zm_devgui::add_custom_devgui_callback(&function_2d0990d7);
  adddebugcommand("<dev string:x125>");
  adddebugcommand("<dev string:x196>");
  adddebugcommand("<dev string:x219>");
  adddebugcommand("<dev string:x292>");
  adddebugcommand("<dev string:x307>");
  adddebugcommand("<dev string:x384>");
  adddebugcommand("<dev string:x3f1>");
  adddebugcommand("<dev string:x470>");
  adddebugcommand("<dev string:x4e5>");
  adddebugcommand("<dev string:x556>");
  adddebugcommand("<dev string:x5cf>");
  adddebugcommand("<dev string:x645>");
  adddebugcommand("<dev string:x6c1>");
  adddebugcommand("<dev string:x733>");
  adddebugcommand("<dev string:x79f>");
}

function_2d0990d7(cmd) {
  switch (cmd) {
    case #"hash_77f372679d07a739":
      level.var_daaf0e5d = "<dev string:x80b>";
      break;
    case #"hash_439f7c3b2be3e69e":
      level.var_daaf0e5d = "<dev string:x813>";
      break;
    case #"hash_4c0666160f60f30c":
      level.var_daaf0e5d = "<dev string:x824>";
      break;
    case #"hash_18772c2e191751b2":
      level.var_daaf0e5d = "<dev string:x830>";
      break;
    case #"hash_476f76510ea19e0a":
      level.var_daaf0e5d = "<dev string:x83a>";
      break;
    case #"hash_7993d72e5b3831ee":
      level.var_d486e9c4 = 1;
      level.var_daaf0e5d = "<dev string:x80b>";
      break;
    case #"hash_619ec063638bb2df":
      level.var_d486e9c4 = 1;
      level.var_daaf0e5d = "<dev string:x813>";
      break;
    case #"hash_63836a8684b4a3db":
      level.var_d486e9c4 = 1;
      level.var_daaf0e5d = "<dev string:x824>";
      break;
    case #"hash_6efe06e0e34fcda1":
      level.var_d486e9c4 = 1;
      level.var_daaf0e5d = "<dev string:x830>";
      break;
    case #"hash_55764ba6b85e2f4d":
      level.var_d486e9c4 = 1;
      level.var_daaf0e5d = "<dev string:x83a>";
      break;
    case #"hash_18be8ae474605ed0":
      level notify(#"hash_1a286cacd101f4eb", {
        #b_success: 0
      });
      break;
    case #"hash_58ae202f026c337":
      level notify(#"hash_1a286cacd101f4eb", {
        #b_success: 1
      });
      break;
    case #"hash_6499ce5666508b":
      level.var_bf412074 = 1;
      break;
    case #"hash_70db80c9c71f4e66":
      level.var_6ab72806 = 1;
      break;
    case #"hash_70db7ec9c71f4b00":
      level.var_6ab72806 = 3;
      break;
  }
}

private function_283daa98() {
  self endon(#"death", #"hash_300e9fed7925cd69");
  s_result = level waittill(#"hash_1a286cacd101f4eb");

  if(isDefined(s_result.b_success) && s_result.b_success) {
    self notify(#"hash_300e9fed7925cd69", {
      #b_success: 1
    });
    return;
  }

  self notify(#"hash_300e9fed7925cd69", {
    #b_success: 0
  });
}

