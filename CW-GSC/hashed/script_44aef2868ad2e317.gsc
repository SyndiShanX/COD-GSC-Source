/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_44aef2868ad2e317.gsc
***********************************************/

#using script_13114d8a31c6152a;
#using script_146fc25c29195773;
#using script_1cdcb9e0e5c220f6;
#using script_1fd2c6e5fc8cb1c3;
#using script_210ec734a4149bac;
#using script_35ae72be7b4fec10;
#using script_3626f1b2cf51a99c;
#using script_396062ed2667195d;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_4ab78e327b76395f;
#using script_4ec222619bffcfd1;
#using script_52da18c20f45c56a;
#using script_5431e074c1428743;
#using script_779f525443585713;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\lockpick;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\note_display;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\interactive_map;
#using scripts\cp_common\ui\object_descriptions;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_ins_prepare;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level thread scene::init("scene_kgb_poison_tea");
  level thread scene::init("scene_kgb_elevator_holdup");
  level thread scene::init("scene_kgb_walkup_adler");
  level.checkpoint_clip = getent("checkpoint_clip", "targetname");
  level.checkpoint_clip notsolid();
  level.checkpoint_clip_right = getent("checkpoint_clip_right", "targetname");
  level.checkpoint_clip_right notsolid();
  level thread namespace_99e99ffa::function_1d90bc4a();
}

function main(var_d3440450, var_50cc0d4f) {
  level.var_b3cae252 = 0;
  setDvar(#"hash_a794df2c802865c", 650);
  setDvar(#"hash_4b04afdbb8712861", 750);

  if(getdvarint(#"hash_7b7dc68533c0bc4b", 0)) {
    level flag::set("<dev string:x38>");
    level flag::set("<dev string:x4b>");
    level flag::set("<dev string:x5e>");
  }

  if(is_true(var_50cc0d4f)) {
    level function_52f0fcb3(var_d3440450);
    level function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa(var_d3440450);
    level thread namespace_e77bf565::function_ada6d016();

    if(namespace_94c47ce5::function_11b2b847()) {
      level flag::set("informant_alive");
    }

    level flag::set("flag_start_finding_ways");
    level flag::set("flag_poi_camera_done");
    level flag::set("flag_tutorial_map_complete");
    level flag::set("disable_all_cameras");
    level thread function_7f81c6e4();
    level thread function_3b309153();
    namespace_e77bf565::function_e2e72d4(0);
    level thread function_6cbe4283();
    level.player thread util::function_5b2f930e(4, #"uie_ui_hud_cp_actionslot_icon_map", "[{+actionslot 4;+map}]");
    scene::init("scene_kgb_camera_shutdown");
    exploder::exploder("Camera_Ctrl_Panel");
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
  }

  level thread namespace_e77bf565::function_47775bba();
  level thread namespace_e77bf565::function_7ad4f5cb();
  level thread function_a58aee07();
  level thread function_1c20e038();
  callback::on_ai_killed(&namespace_e77bf565::function_efb66186);
  level flag::wait_till("flag_keycard_acquired");
  level thread namespace_e77bf565::function_7cc03716();
  level thread function_6bf59c81();
  namespace_353d803e::music("6.0_basement");
  bb::function_cd497743("keycard_acquired", level.player);
  objectives::remove(#"map_waypoint");
  level thread kgb_ins_rv::function_1f4d29f8();
  level thread function_799b3854();
  level flag::wait_till("flag_open_basement");
  level thread function_c7476e69();

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function function_6cbe4283() {
  function_dc6c4b5e();
  level thread function_33e0fa9c();
  level thread function_16e85ca5();
  level thread function_a8f549f8();
  level thread function_2930697c();
  level thread function_ed39356a();
  level thread namespace_e77bf565::function_23f254a8();
  level thread function_50d280db();
  level thread function_e873b4cd();
  level thread function_2388bc70();
}

function function_a58aee07() {
  blocker = getent("frisk_blocker", "targetname");
  blocker notsolid();
  level thread function_e7fcf8ef();
  level thread function_ada5392f();
  level thread function_682ba64c();
  level thread file_room();
  level thread function_c1a40cd6();
  level thread data_entry_guard();
  level thread function_9150e0d9();
  level thread namespace_94c47ce5::function_9b596d4d();
  level flag::set("kgb_enable_context_melee");
}

function cleanup(name, starting, direct, player) {}

function init_flags() {}

function init_clientfields() {
  clientfield::register("scriptmover", "set_camera_fx", 1, 1, "int");
}

function function_22b7fffd() {
  level scene::add_scene_func("scene_kgb_interrogation_room_door", &function_9e511069, "init");
  level scene::init("scene_kgb_interrogation_room_door");
  level scene::add_scene_func("scene_kgb_walkup_gate_guard", &function_5da2f302);
}

function function_c9965ab9(hide) {
  level.player endon(#"death");

  if(hide) {
    level flag::set("disable_mental_map");
    level.player thread util::function_658a8750(4);
    return;
  }

  level flag::clear("disable_mental_map");
  level.player thread util::function_5b2f930e(4, #"uie_ui_hud_cp_actionslot_icon_map", "[{+actionslot 4;+map}]");
}

function function_7f102a89(var_da1a882e) {
  for(i = 0; i < level.var_6d758088.size; i++) {
    if(level.var_6d758088[i].script_noteworthy == var_da1a882e) {
      return level.var_6d758088[i].origin;
    }
  }
}

function function_506c6d6f() {
  level.player endon(#"death");
  var_2b81150f = 589824;

  if(!isDefined(level.player_in_restricted_area)) {
    corpses = getcorpsearray();

    foreach(body in corpses) {
      if(distance2dsquared(level.player.origin, body.origin) > var_2b81150f) {
        body delete();
      }
    }

    return true;
  }

  corpses = getcorpsearray();

  if(corpses.size) {
    for(i = 0; i < corpses.size; i++) {
      if(!corpses[i] namespace_e77bf565::function_127e0d08()) {
        return false;
      }
    }
  }

  return true;
}

function function_16e85ca5() {
  level.player endon(#"death");
  level.var_1b4de43 = [];

  while(!level flag::get("flag_keycard_acquired")) {
    level waittill(#"ping_map");

    if(!level flag::get_any(level.var_e9c8a6d4) && function_506c6d6f()) {
      level thread savegame::checkpoint_save();
    }

    if(level flag::get("flag_keycard_acquired")) {
      return;
    }

    level flag::wait_till_clear_timeout(8, "disable_mental_map");

    if(isDefined(level.var_1b4de43)) {
      foreach(room in level.var_1b4de43) {
        switch (room) {
          case # "office":
            function_dfb343c2("charkov_office");
            function_34b04d5f("charkov_office", "generalsOfficeState");
            break;
          case # "data":
            function_dfb343c2(room);
            function_34b04d5f(room, "technologiesRoomState");
            break;
          case # "checkpoint":
            function_dfb343c2(room);
            function_34b04d5f(room, "securityState");
            break;
          case # "interrogation":
            function_dfb343c2(room);
            function_34b04d5f(room, "interrogationState");
            break;
          case # "camera":
            function_dfb343c2(room);
            function_34b04d5f(room, "cameraRoomState");
            break;
          case # "prison":
            function_dfb343c2(room);
            function_34b04d5f(room, "kravchenkoOfficeState");
            break;
          case # "informant":
            if(namespace_94c47ce5::function_11b2b847()) {
              function_34b04d5f(room, "kravchenkoOfficeState");
            }

            break;
          default:
            break;
        }
      }
    }

    waitframe(1);
    namespace_353d803e::function_5865b09e();
    level thread hint_tutorial::function_4c2d4fc4(#"hash_6a484d4f01f5f697", undefined, 3, undefined, 2, 3);
    level.player thread util::function_ae1d1464(4, 1);
    level.var_1b4de43 = [];
    waitframe(1);
  }
}

function function_337cace2(location) {
  switch (location) {
    case # "office":
      if(level.quest_objectives[# "poison_tea"].tracked) {
        level.player thread objectives_ui::show_objectives();
      }

      break;
    case # "data":
      if(level.quest_objectives[# "key_reprogram"].tracked) {
        level.player thread objectives_ui::show_objectives();
      }

      break;
    case # "checkpoint":
      if(level.quest_objectives[# "making_a_mole"].tracked) {
        level.player thread objectives_ui::show_objectives();
      }

      break;
    case # "interrogation":
      if(level.quest_objectives[# "prisoner_persuasion"].tracked) {
        level.player thread objectives_ui::show_objectives();
      }

      break;
    default:
      break;
  }
}

function function_dfb343c2(location) {
  if(level.quest_objectives[# "poison_tea"].tracked) {
    interactive_map::function_50121b9(function_7f102a89("charkov_office"));
    return;
  }

  if(level.quest_objectives[# "making_a_mole"].tracked) {
    interactive_map::function_50121b9(function_7f102a89("checkpoint"));
    return;
  }

  if(level.quest_objectives[# "prisoner_persuasion"].tracked) {
    interactive_map::function_50121b9(function_7f102a89("interrogation"));
    return;
  }

  if(level.quest_objectives[# "key_reprogram"].tracked) {
    interactive_map::function_50121b9(function_7f102a89("data"));
    return;
  }

  if(!isDefined(location)) {
    interactive_map::function_50121b9(level.player.origin);
    return;
  }

  interactive_map::function_50121b9(function_7f102a89(location));
}

function function_6bf59c81() {
  if(!isDefined(level.player)) {
    return;
  }

  level.player endon(#"death");
  function_73f90a7f();
  namespace_353d803e::function_5865b09e();
  level thread hint_tutorial::function_4c2d4fc4(#"hash_6a484d4f01f5f697", undefined, 3, undefined, 2, 3);
  level.player thread util::function_ae1d1464(4, 1);
  level flag::wait_till_clear_all(level.var_e9c8a6d4);

  if(function_506c6d6f()) {
    level thread savegame::checkpoint_save(1);
  }
}

function function_4f55a6c5() {
  objectives::remove("obj_map_updated_mail");
  objectives::remove("obj_map_updated_armory");
  objectives::remove("obj_map_updated_office");
  objectives::remove("obj_map_updated_records");
  objectives::remove("obj_map_updated_data");
  objectives::remove("obj_map_updated_checkpoint");
  objectives::remove("obj_map_updated_prisoner");
  objectives::remove("obj_map_updated_camera");
}

function function_3b309153() {
  level.var_6d758088 = getEntArray("mental_map_poi", "targetname");

  foreach(point in level.var_6d758088) {
    model_name = undefined;

    switch (point.script_noteworthy) {
      case # "charkov_office":
        point.var_d9b5c896 = # "hash_2a572dd82dffa737";
        model_name = "generalsOfficeState";
        function_2c60d1ba(point);
        break;
      case # "data":
        point.var_d9b5c896 = # "hash_2bb6f605c5e7b52a";
        model_name = "technologiesRoomState";
        function_4ca4fd23(point);
        break;
      case # "camera":
        point.var_d9b5c896 = # "hash_1f3fb2e195d67274";
        function_7733f229(point);
        break;
      case # "checkpoint":
        point.var_d9b5c896 = # "hash_795ca66f92406381";
        model_name = "securityState";
        function_ef7b8da7(point);
        break;
      case # "interrogation":
        point.var_d9b5c896 = # "hash_17ba8a94dd34cf9b";
        model_name = "interrogationState";
        function_731ece55(point);
        break;
      case # "informant":
        if(namespace_94c47ce5::function_11b2b847()) {
          point.var_d9b5c896 = # "hash_531400ca1362803f";
          model_name = "kravchenkoOfficeState";
          function_31cd4ae0(point);
        }

        break;
    }

    if(isDefined(model_name)) {
      point interactive_map::function_9bc3d847(#"cursor_on", model_name, 0, 1);
    }
  }
}

function function_60e6f656() {
  if(!level flag::get("flag_start_finding_ways")) {
    return;
  }

  foreach(point in level.var_6d758088) {
    switch (point.script_noteworthy) {
      case # "charkov_office":
        point.var_d9b5c896 = # "hash_2a572dd82dffa737";
        model_name = "generalsOfficeState";
        function_2c60d1ba(point);
        break;
      case # "informant":
        if(namespace_94c47ce5::function_11b2b847()) {
          point.var_d9b5c896 = # "hash_531400ca1362803f";
          model_name = "kravchenkoOfficeState";
          function_31cd4ae0(point);
        }

        break;
      case # "data":
        point.var_d9b5c896 = # "hash_2bb6f605c5e7b52a";
        model_name = "technologiesRoomState";
        function_4ca4fd23(point);
        break;
      case # "checkpoint":
        point.var_d9b5c896 = # "hash_795ca66f92406381";
        model_name = "securityState";
        function_ef7b8da7(point);
        break;
      case # "interrogation":
        point.var_d9b5c896 = # "hash_17ba8a94dd34cf9b";
        model_name = "interrogationState";
        function_731ece55(point);
        break;
    }
  }
}

function function_34b04d5f(var_cbd7502c, model_name, var_e91f21c1) {
  foreach(point in level.var_6d758088) {
    if(point.script_noteworthy == model_name) {
      point interactive_map::function_9bc3d847(#"cursor_on", var_e91f21c1, 0, 1);
    }
  }
}

function function_73f90a7f() {
  foreach(point in level.var_6d758088) {
    model_name = undefined;

    switch (point.script_noteworthy) {
      case # "charkov_office":
        model_name = "generalsOfficeState";
        break;
      case # "data":
        model_name = "technologiesRoomState";
        break;
      case # "checkpoint":
        model_name = "securityState";
        break;
      case # "interrogation":
        model_name = "interrogationState";
        break;
      case # "camera":
        model_name = "cameraRoomState";
        break;
      case # "informant":
        if(namespace_94c47ce5::function_11b2b847()) {}

        break;
    }

    if(isDefined(model_name)) {
      point interactive_map::function_9bc3d847(#"cursor_on", model_name, 0, 0);
    }
  }
}

function function_2c60d1ba(point) {
  string = # "hash_1d4171274d456234";
  var_ec2c079e = "";

  if(level flag::get("flag_player_scheduled_meeting")) {
    string = # "hash_1d4172274d4563e7";
    var_ec2c079e = "";
  }

  if(level flag::get("flag_poi_mail_poison")) {
    string = # "hash_1d4173274d45659a";
    var_ec2c079e = "";
  }

  if(level flag::get("flag_poi_office_meeting")) {
    string = # "hash_1d4174274d45674d";
    var_ec2c079e = "";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_31cd4ae0(point) {
  string = # "hash_e68f47da83d6ce4";

  if(level flag::get("flag_informant_killed")) {
    point.var_d9b5c896 = # "hash_154e518c3486a457";
    string = # "hash_e68f57da83d6e97";
  }

  point.var_94ca2a30 = string;
}

function function_ff544ce6(point) {
  string = # "hash_14482609a6c3e71a";
  var_ec2c079e = "vox_cp_rkgb_01940_blkv_thearmoryhasrep_63";

  if(level flag::get("flag_poi_armory_guard")) {
    string = # "hash_14482709a6c3e8cd";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_theguardwontlet_09";
  }

  if(level flag::get("flag_poi_armory_paperwork")) {
    string = # "hash_14482409a6c3e3b4";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_ihavethepaperwo_ef";
  }

  if(level flag::get("flag_poi_armory_guy_dead")) {
    string = # "hash_14482509a6c3e567";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_nowthativedealt_8d";
  }

  if(level flag::get("flag_poi_armory_open")) {
    string = # "hash_3a7bf5665ede2932";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_thearmoryhasrep_63";
  }

  if(level flag::get("flag_poi_armory_done")) {
    string = # "hash_14482209a6c3e04e";
    var_ec2c079e = "vox_cp_rkgb_01940_blkv_nowthatihavethe_80";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_4ca4fd23(point) {
  string = # "hash_701c560151221bf0";
  var_ec2c079e = "vox_cp_rkgb_01930_blkv_icouldreprogram_34";

  if(level flag::get("flag_request_armory")) {
    string = # "hash_701c570151221da3";
  }

  if(level flag::get("flag_armory_persuade_03_called")) {
    string = # "hash_2245993cdcf890a6";
  }

  if(level flag::get_any(["flag_has_cigar", "flag_has_paperwork"]) && level flag::get("flag_request_armory")) {
    string = # "hash_701c580151221f56";
  }

  if(level flag::get_any(["flag_poi_armory_open", "flag_poi_armory_guy_dead"])) {
    string = # "hash_2248c13cdcfb0a75";
  }

  if(level flag::get("flag_got_spare_card")) {
    string = # "hash_701c590151222109";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_7733f229(point) {
  string = # "hash_4082e645a7a60d6f";
  var_ec2c079e = "vox_cp_rkgb_01970_blkv_thecameracontro_34";

  if(level flag::get("flag_poi_camera_done")) {
    string = # "hash_4082e545a7a60bbc";
    var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_8d39c999(point) {
  string = # "hash_93d7d1547a7789b";
  var_ec2c079e = "";

  if(level flag::get("false_intel_printed")) {
    string = # "hash_93d7c1547a776e8";
    var_ec2c079e = "";
  }

  if(level flag::get("has_false_intel")) {
    string = # "hash_93d7f1547a77c01";
    var_ec2c079e = "";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "";
  }

  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return false;
}

function function_3829cdfd(point) {
  string = # "hash_3bb1ca1fd8dc18c1";
  var_ec2c079e = "vox_cp_rkgb_01950_blkv_themailroomprov_fc";

  if(level flag::get("combination_lock_exited")) {
    string = # "hash_3bb1c91fd8dc170e";
    var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
  }

  if(level flag::get("combination_lock_opened")) {
    string = # "hash_3bb1c81fd8dc155b";
    var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
  }

  if(level flag::get("flag_has_poison")) {
    string = # "hash_3bb1c71fd8dc13a8";
    var_ec2c079e = "vox_cp_rkgb_01930_blkv_inolongerhaveus_68";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return false;
}

function function_ef7b8da7(point) {
  string = # "hash_d7a7566c2e78af2";
  var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";

  if(level flag::get("flag_poi_krav_chat")) {
    string = # "hash_4ea0109d2f7077c9";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
  }

  if(level flag::get("false_intel_printed")) {
    string = # "hash_d7a7666c2e78ca5";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
  }

  if(level flag::get("has_false_intel")) {
    string = # "hash_d7a7366c2e7878c";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
  }

  if(level flag::get("flag_poi_krav_wait")) {
    string = # "hash_d7a7466c2e7893f";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
  }

  if(level flag::get("flag_poi_krav_opportunity")) {
    string = # "hash_d7a7166c2e78426";
    var_ec2c079e = "vox_cp_rkgb_01920_blkv_allpersonnelpas_bf";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_79b1bbce(point) {
  string = # "hash_213c1ae19515fbb7";
  var_ec2c079e = "vox_cp_rkgb_01650_blkv_adlerswaitingin_31";

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return false;
}

function function_731ece55(point) {
  string = # "hash_5839f3936c6b6581";
  var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovisschedu_bb";

  if(level flag::get("flag_poi_interrogation_file")) {
    string = # "hash_5839f2936c6b63ce";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_theprisonerwont_82";
  }

  if(level flag::get("flag_poi_interrogation_leverage")) {
    string = # "hash_5839f1936c6b621b";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_nowthatiknowthe_2a";
  }

  if(level flag::get("flag_poi_interrogation_uncuff")) {
    string = # "hash_5839f0936c6b6068";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_innermonologuet_4b";
  }

  if(level flag::get("flag_poi_interrogation_wait")) {
    string = # "hash_5839f7936c6b6c4d";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovwillbehe_7c";
  }

  if(level flag::get("flag_poi_interrogation_take")) {
    string = # "hash_5839f6936c6b6a9a";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_charkovisdeadis_aa";
  }

  if(level flag::get("flag_keycard_acquired")) {
    string = # "hash_37f052990d63fe14";
    var_ec2c079e = "vox_cp_rkgb_01910_blkv_mytaskiscomplet_85";
  }

  updated = point.string !== point.var_94ca2a30 || point.var_ec2c079e !== var_ec2c079e;
  point.var_ec2c079e = var_ec2c079e;
  point.var_94ca2a30 = string;
  return updated;
}

function function_aa7cd2d6() {
  level.player endon(#"death");
  level flag::set("disable_mental_map");
  level flag::set("flag_map_tutorial");
  wait 0.5;
  level flag::clear("disable_mental_map");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_static");
  level.player val::set(#"hash_2463ab97c65a943c", "freezecontrols", 1);
  hint_tutorial::function_4c2d4fc4(#"hash_c1552d7f7ecf9bb", #"hash_5a2cb100f420b36c", 2, #"hash_70f26bb1ab701ef8");
  hint_tutorial::function_df08d48(5);
  level flag::wait_till("flag_show_itinerary");
  hint_tutorial::function_9f427d88(0);
  waitframe(1);
  level.player thread util::show_hint_text(#"hash_22e94f6cef70f4cd", 0, undefined, -1);
  level flag::wait_till("flag_tutorial_map_complete");
  level.player notify(#"flag_tutorial_map_complete");
  waitframe(1);
  level.player thread util::show_hint_text(#"hash_1d9e5bec877cc239", 0, "flag_show_itinerary", -1);
  level flag::wait_till_clear("flag_show_itinerary");
  level.player notify(#"flag_show_itinerary");
  level.player val::reset(#"hash_2463ab97c65a943c", "freezecontrols");
}

function function_399a3c34() {
  level endon(#"mission_failed");
  level.player endon(#"death");
  interactive_map::function_87f0056b();
  function_dfb343c2(undefined);
  function_60e6f656();
  interactive_map::open(#"hash_1981501d7d5644aa");
  level.player interactive_map::add_object(#"player", #"uie_map_lubyanka_marker_player", 1, -90);

  if(!isDefined(level.var_dc5a0371)) {
    level.var_dc5a0371 = 0;
  }

  if(isDefined(level.general)) {
    level.general interactive_map::add_object(#"general", #"uie_map_lubyanka_marker_target", 0);
  }

  if(level.var_dc5a0371 && isDefined(level.informant)) {
    level.informant interactive_map::add_object(#"kgb_informant_spawner", level.var_5fc836e5, 0);
  }

  corpses = getcorpsearray();
  tags = [];

  if(corpses.size) {
    for(i = 0; i < corpses.size; i++) {
      tags[i] = spawn("script_model", corpses[i].origin);

      if(!corpses[i] namespace_e77bf565::function_127e0d08()) {
        tags[i] interactive_map::add_object("corpse" + string(i), #"uie_map_lubyanka_marker_corpse", 0);
      }
    }
  }

  var_b33f9bc7 = {
    #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_4bba939c7b77a314", #complete_callback: &interactive_map::function_fabe437a, #var_be77841a: 0
  };
  level.var_a7c109a9 = {
    #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_77bbd9b01cf5911d", #complete_callback: &function_1b3bebea, #var_be77841a: 0
  };
  var_384bed55 = {
    #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_77bbd9b01cf5911d", #complete_callback: &function_eab15e43, #var_be77841a: 0
  };
  level.var_ac82c4c6 = {
    #var_4ac77177: 0, #var_de6f0004: 0, #prompt_text: # "hash_77bbd9b01cf5911d", #complete_callback: &function_5a785465, #var_be77841a: 0
  };

  if(level flag::get("flag_start_finding_ways")) {
    function_10fea201();
    level flag::get("flag_poi_camera_done");
    level flag::set("flag_tutorial_map_complete");
    function_3a103505();
  } else {
    if(level flag::get("flag_tutorial_map_complete")) {
      spot = struct::get("tutorial_button", "targetname");
      spot interactive_map::add_object(#"camera", level.var_5fc836e5, 0, undefined);
    }

    hotspots = getEntArray("mental_map_poi", "targetname");

    foreach(hotspot in hotspots) {
      switch (hotspot.script_noteworthy) {
        case # "camera":
          hotspot.var_d9b5c896 = # "hash_1f3fb2e195d67274";
          model_name = "cameraRoomState";
          hotspot.var_94ca2a30 = # "hash_658c76bc4bf5be3e";

          if(level flag::get("flag_tutorial_1")) {
            hotspot.var_94ca2a30 = # "hash_658c77bc4bf5bff1";
          }

          if(level flag::get("flag_tutorial_2")) {
            hotspot.var_94ca2a30 = # "hash_658c74bc4bf5bad8";
          }

          if(level flag::get("flag_tutorial_3")) {
            hotspot.var_94ca2a30 = # "hash_658c75bc4bf5bc8b";
          }

          if(level flag::get("flag_tutorial_4")) {
            hotspot.var_94ca2a30 = # "hash_658c7abc4bf5c50a";
          }

          if(!level flag::get("flag_tutorial_map_complete")) {
            hotspot interactive_map::function_b5c2702b(#"confirm", var_384bed55);
          }

          hotspot interactive_map::function_9bc3d847(#"cursor_on", model_name, 0, 1);
          interactive_map::function_59b2a130(hotspots);
          break;
        default:
          break;
      }
    }
  }

  namespace_c8e236da::function_ebf737f8(#"hash_70a51dccafa85eb");

  if(level flag::get("flag_tutorial_map_complete")) {
    namespace_c8e236da::function_ebf737f8(#"hash_3895e110abdb2bea");
  }

  namespace_c8e236da::function_f7362969(#"hash_65ea56dc5ff42c5d", !level.player gamepadusedlast());
  level.player thread util::function_658a8750(4);
  waitframe(1);
  function_b2058d81(level.player);
}

function function_b2058d81(player) {
  player endon(#"death");
  level flag::wait_till("flag_tutorial_map_complete");
  player thread namespace_61e6d095::function_b0bad5ff("show_itin");
  player waittill(#"show_itin", #"request_menu_exit");
}

function function_bd719400() {
  location = level.interactive_map.var_2c15274b.object.script_noteworthy;

  if(isDefined(location)) {
    switch (location) {
      case # "charkov_office":
        if(!level flag::get("track_poison_quest")) {
          function_3baa92ca();
          level flag::set("track_poison_quest");
          function_e59622fc();
        }

        break;
      case # "checkpoint":
        if(!level flag::get("track_mole_quest")) {
          function_3baa92ca();
          level flag::set("track_mole_quest");
          function_112ccc00();
        }

        break;
      case # "interrogation":
        if(!level flag::get("track_persuade_quest")) {
          function_3baa92ca();
          level flag::set("track_persuade_quest");
          function_3b6949e3();
        }

        break;
      case # "data":
        if(!level flag::get("track_reprogram_quest")) {
          function_3baa92ca();
          level flag::set("track_reprogram_quest");
          function_7d2cd5a4();
        }

        break;
    }
  }
}

function function_76f6763d() {}

function function_3baa92ca() {
  if(level flag::get("track_poison_quest")) {
    level flag::clear("track_poison_quest");
    function_6f694325();
  }

  if(level flag::get("track_reprogram_quest")) {
    level flag::clear("track_reprogram_quest");
    function_b2389c8a();
  }

  if(level flag::get("track_persuade_quest")) {
    level flag::clear("track_persuade_quest");
    function_13467c6e();
  }

  if(level flag::get("track_mole_quest")) {
    level flag::clear("track_mole_quest");
    function_9e96f7bb();
  }
}

function function_10fea201() {
  if(level flag::get("flag_keycard_acquired")) {
    function_3baa92ca();
    return;
  }

  if(level flag::get("track_poison_quest")) {
    function_e59622fc();
  }

  if(level flag::get("track_reprogram_quest")) {
    function_7d2cd5a4();
  }

  if(level flag::get("track_persuade_quest")) {
    function_3b6949e3();
  }

  if(level flag::get("track_mole_quest")) {
    function_112ccc00();
  }
}

function function_e59622fc() {
  if(!level flag::get("flag_player_scheduled_meeting") && !level flag::get("flag_has_poison") && !level flag::get("flag_start_charkov_investigation")) {
    level.secretary interactive_map::add_object(#"secretary", level.var_5fc836e5, 0, undefined);
    level.secretary.var_d9b5c896 = # "hash_3048014b9f22fee7";
    level.secretary.var_94ca2a30 = # "hash_2d03a5ac2753abb9";
    return;
  }

  if(!level flag::get("flag_has_poison") && !level flag::get("flag_start_charkov_investigation")) {
    level.var_44c39802 = struct::get("ins_restricted_area_locker_lock_interact", "targetname");
    level.var_44c39802 interactive_map::add_object(#"poison", level.var_5fc836e5, 0, undefined);
    level.var_44c39802.var_d9b5c896 = # "hash_25d3f454e42ddb77";
    level.var_44c39802.var_94ca2a30 = # "hash_54b80b0b320497a9";
    return;
  }

  if(level flag::get("flag_has_poison") && !level flag::get("flag_start_charkov_investigation")) {
    level.secretary interactive_map::add_object(#"secretary", level.var_5fc836e5, 0, undefined);
    level.secretary.var_d9b5c896 = # "hash_3048014b9f22fee7";
    level.secretary.var_94ca2a30 = # "hash_17053318d59f96b9";
    return;
  }

  var_fe29c695 = struct::get("poison_chat", "targetname");
  var_fe29c695 interactive_map::add_object(#"hash_2410c0d0b3566fc3", level.var_5fc836e5, 0, undefined);
}

function function_6f694325() {
  interactive_map::remove_object(#"poison");
  interactive_map::remove_object(#"secretary");
  interactive_map::remove_object(#"hash_2410c0d0b3566fc3");
}

function function_7d2cd5a4() {
  if(!level flag::get_any(["flag_poi_armory_guy_dead", "flag_armory_persuade_03_called", "flag_request_armory"])) {
    level.armory_guard interactive_map::add_object(#"armory_guard", level.var_5fc836e5, 0, undefined);
    level.armory_guard.var_d9b5c896 = # "hash_2fcd4173590d62db";
    level.armory_guard.var_94ca2a30 = # "hash_b13b330f776a88d";
    return;
  }

  if((level flag::get("flag_armory_persuade_03_called") || level flag::get("flag_request_armory")) && !level flag::get_any(["flag_has_cigar", "flag_has_paperwork", "flag_poi_armory_guy_dead"])) {
    if(level flag::get("flag_armory_persuade_03_called")) {
      var_d02e0a4b = struct::get_array("cigar", "targetname");

      for(i = 0; i < var_d02e0a4b.size; i++) {
        var_d02e0a4b[i] interactive_map::add_object(hash("cigar_spot_" + string(i)), level.var_5fc836e5, 0, undefined);
        var_d02e0a4b[i].var_d9b5c896 = # "hash_1708543aad064d7f";
        var_d02e0a4b[i].var_94ca2a30 = # "hash_38340b304bba1451";
      }
    }

    if(level flag::get("flag_request_armory")) {
      paperwork = struct::get(#"paperwork", "targetname");
      paperwork interactive_map::add_object(#"paperwork", level.var_5fc836e5, 0, undefined);
      paperwork.var_d9b5c896 = # "hash_c05243a66dfa5d2";
      paperwork.var_94ca2a30 = # "hash_23102b2784b6f902";
    }

    return;
  }

  if(level flag::get_any(["flag_has_cigar", "flag_has_paperwork"]) && !level flag::get("flag_poi_armory_guy_dead") && !level flag::get("flag_poi_armory_open")) {
    level.armory_guard interactive_map::add_object(#"armory_guard", level.var_5fc836e5, 0, undefined);
    level.armory_guard.var_d9b5c896 = # "hash_2fcd4173590d62db";
    level.armory_guard.var_94ca2a30 = # "hash_b13b330f776a88d";
    return;
  }

  if(!level flag::get("flag_got_spare_card")) {
    var_31e7cd3f = struct::get("spare_card", "targetname");
    var_31e7cd3f interactive_map::add_object(#"hash_201b7686113c8dc4", level.var_5fc836e5, 0, undefined);
    var_31e7cd3f.var_d9b5c896 = # "hash_3d4102d1091b0ffa";
    var_31e7cd3f.var_94ca2a30 = # "hash_6cf25d7e7198a0ca";
    return;
  }

  computer = struct::get("struct_computer_hack", "targetname");
  computer interactive_map::add_object(#"reprogram_computer", level.var_5fc836e5, 0, undefined);
}

function function_b2389c8a() {
  interactive_map::remove_object(#"hash_201b7686113c8dc4");
  interactive_map::remove_object(#"paperwork");
  interactive_map::remove_object(#"hash_1f5e5467a23eec9d");
  interactive_map::remove_object(#"hash_1f5e5367a23eeaea");
  interactive_map::remove_object(#"armory_guard");
  interactive_map::remove_object(#"reprogram_computer");
}

function function_3b6949e3() {
  if(!level flag::get("flag_poi_records_file") && !level flag::get("flag_show_family_choice")) {
    level.prisoner interactive_map::add_object(#"prisoner", level.var_5fc836e5, 0, undefined);
    return;
  }

  if(level flag::get("flag_poi_records_file") && !level flag::get("flag_show_family_choice")) {
    records = struct::get("prisoner_chat", "targetname");
    records interactive_map::add_object(#"hash_5ae419835c5428b4", level.var_5fc836e5, 0, undefined);
    records.var_d9b5c896 = # "hash_6f8f144109d9ede5";
    records.var_94ca2a30 = # "hash_31b9cc13fef9b4ef";
    return;
  }

  if(!level flag::get("flag_prisoner_complete")) {
    level.prisoner interactive_map::add_object(#"prisoner", level.var_5fc836e5, 0, undefined);
    return;
  }

  if(!level flag::get("flag_poi_interrogation_take")) {
    level.var_fd2ed10f interactive_map::add_object(#"hash_6aa2aec455594750", level.var_5fc836e5, 0, undefined);
    level.var_fd2ed10f.var_d9b5c896 = # "hash_613c99a21c3b91a8";
    level.var_fd2ed10f.var_94ca2a30 = # "hash_2e090679540515f0";
    return;
  }

  level.general interactive_map::add_object(#"hash_5e264266f6f71bf2", level.var_5fc836e5, 0, undefined);
}

function function_13467c6e() {
  interactive_map::remove_object(#"prisoner");
  interactive_map::remove_object(#"hash_5ae419835c5428b4");
  interactive_map::remove_object(#"hash_5e264266f6f71bf2");
  interactive_map::remove_object(#"hash_6aa2aec455594750");
}

function function_112ccc00() {
  if(!level flag::get("flag_poi_krav_chat") && !level flag::get("false_intel_printed")) {
    level.var_eede7a6 interactive_map::add_object(#"krav", level.var_5fc836e5, 0, undefined);
    return;
  }

  if(!level flag::get("false_intel_printed")) {
    computer = struct::get("ins_restricted_area_computer_org", "targetname");
    computer interactive_map::add_object(#"hash_2712d6284cb32b79", level.var_5fc836e5, 0, undefined);
    computer.var_d9b5c896 = # "hash_729651d3864bcf82";
    computer.var_94ca2a30 = # "hash_297c588e081b5712";
    return;
  }

  if(!level flag::get("has_false_intel")) {
    printer = struct::get("false_intel_org", "targetname");
    printer interactive_map::add_object(#"false_intel", level.var_5fc836e5, 0, undefined);
    printer.var_d9b5c896 = # "hash_12fb1ddd05ada6ad";
    printer.var_94ca2a30 = # "hash_7f5bba8a8aab6817";
    return;
  }

  if(!level flag::get("flag_checkpoint_moment_done")) {
    level.var_eede7a6 interactive_map::add_object(#"krav", level.var_5fc836e5, 0, undefined);
    return;
  }

  struct = struct::get("swipe_card", "targetname");
  struct interactive_map::add_object(#"swipe_card", level.var_5fc836e5, 0, undefined);
}

function function_9e96f7bb() {
  interactive_map::remove_object(#"krav");
  interactive_map::remove_object(#"false_intel");
  interactive_map::remove_object(#"hash_2712d6284cb32b79");
  interactive_map::remove_object(#"swipe_card");
}

function function_bfd7129d(prompt) {
  level.var_f6ee4380 = self;
  level.var_f6ee4380.occupant = level.var_bd2c25cc;
  level flag::set("flag_room_chosen");
}

function function_22af6992(prompt_struct) {
  if(isDefined(self.var_ec2c079e)) {
    level dialogue::function_3db52a33();
    waitframe(1);
  }
}

function function_3bd00673() {
  level.player endon(#"death");
  level.player unlink();
  interactive_map::close();
  namespace_c8e236da::removelist();
  namespace_c8e236da::function_f7362969(#"hash_65ea56dc5ff42c5d", 0);
  level.player thread util::function_ae1d1464(4, 0);
  level.player thread util::function_5b2f930e(4, #"uie_ui_hud_cp_actionslot_icon_map", "[{+actionslot 4;+map}]");
}

function function_951eb017(xoffset, yoffset, str, color = (0, 0, 0), visible = 1) {
  item = newdebughudelem();
  item.alignx = "<dev string:x79>";
  item.horzalign = "<dev string:x81>";
  item.x = xoffset;
  item.y = yoffset;
  item.fontscale = 1;
  item.color = color;
  item.str = str;
  item.visible = visible;

  if(!isDefined(level.var_74a63e8b)) {
    level.var_74a63e8b = [];
  } else if(!isarray(level.var_74a63e8b)) {
    level.var_74a63e8b = array(level.var_74a63e8b);
  }

  level.var_74a63e8b[level.var_74a63e8b.size] = item;
  return item;
}

function function_2930697c() {
  level.player endon(#"death");
  level.player notifyonplayercommand("show_itin", "+actionslot 4");
  level.player notifyonplayercommand("show_itin", "+map");
  level.var_5fc836e5 = # "uie_map_lubyanka_marker_waypoint";

  while(!level flag::get("flag_player_swap")) {
    level.player waittill(#"show_itin");
    bb::function_cd497743("player_opened_map", level.player);

    if(!level flag::get("dialog_tree_active") && level.player actions::function_c11b51e1() && !level flag::get("disable_mental_map") && !level.player flag::get(#"lockpicking") && !level flag::get(#"mission_failed")) {
      level.player notify(#"notify_turn_off_hint_text");

      if(level flag::get("flag_player_swap")) {
        break;
      }

      level flag::set("flag_show_itinerary");
      function_30edf3ee();
      snd::client_msg("map_submix_on");
      function_399a3c34();
      level function_3bd00673();
      thread function_e322b3b5();
      level flag::clear("flag_show_itinerary");
      snd::client_msg("map_submix_off");
    }

    wait 0.5;
    waitframe(1);
  }

  level.player thread util::function_658a8750(4);
  var_bddef49 = undefined;
  waitframe(1);
}

function function_30edf3ee() {
  waitframe(1);
  level.player endon(#"death");
  level.player actions::function_202ab848(0);
  namespace_e77bf565::function_f6eb250d("cinematicmotion_static");
  level.player val::set(#"hash_192dddd4b6f92f9", "show_hud", 0);
}

function function_e322b3b5() {
  level.player endon(#"death");
  level.player thread objectives_ui::show_objectives();
  level.player val::set(#"hash_192dddd4b6f92f9", "show_hud");
  level.player actions::function_202ab848(1);
  namespace_e77bf565::function_f6eb250d();
}

function function_93751453() {
  level.player endon(#"death");
  level endon(#"flag_player_swap");
  level thread function_e1582bd3();
  level.var_8d147d15 = 0;
  var_779947cd = 4;

  while(!level flag::get("flag_player_swap") && level.var_8d147d15 < var_779947cd) {
    if(level.player.stealth.maxthreat > 0.4 && level.var_8d147d15 < var_779947cd) {
      if(level.player flag::get("lockpicking")) {
        level.player thread lockpick::cancel();
        level flag::set("flag_lockpick_warning");
        level.var_8d147d15 += 1;
        wait 1;
      }
    }

    waitframe(1);
  }
}

function function_e1582bd3() {
  level.player endon(#"death");
  level endon(#"flag_player_swap");
  level flag::wait_till("flag_lockpick_warning");
  level dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_ifimseenthiswou_cb");
}

function function_70715735() {
  level thread function_9705705e();

  while(!level flag::get("flag_player_swap") && !level flag::get("kgb_fail_mission")) {
    level flag::wait_till_any(level.var_e9c8a6d4);
    level flag::wait_till("stealth_spotted");
    level.var_f695d653 = function_37c2fed8();
    wait 2.5;

    if(level flag::get("stealth_spotted")) {
      if(!level flag::get("flag_player_swap")) {
        level flag::set("kgb_fail_mission");
      }
    }

    waitframe(1);
  }
}

function function_9705705e() {
  level flag::wait_till_any(["kgb_fail_mission", "flag_combat_event"]);

  if(level flag::get("flag_player_swap")) {
    return;
  }

  level namespace_979752dc::function_2324f175(0);
  level notify(#"hash_632b48ff65789b0b");
  waitframe(1);
  level scene::stop("scene_kgb_generals_office");
  level thread function_9fde9426();
  level.player endon(#"death");

  if(level.player flag::get("lockpicking")) {
    level.player thread lockpick::cancel();
  }

  namespace_353d803e::function_45192a6c();

  if(!isDefined(level.var_f695d653)) {
    level.var_f695d653 = # "hash_48ce6cc8055a83cd";
  }

  util::missionfailedwrapper(#"hash_14c23141aa10eb00", level.var_f695d653);
}

function function_37c2fed8() {
  if(level flag::get("kgb_fail_mission")) {
    return;
  }

  var_8de2baee = # "hash_48ce6cc8055a83cd";
  level.player endon(#"death");

  if(level flag::get_any(level.var_e9c8a6d4)) {
    var_8de2baee = # "hash_328d2a2104c392fe";
  }

  if(level.player flag::get_any(["body_shield_active", "takedown_active"]) || level.player namespace_5f6e61d9::function_cad84e26()) {
    var_8de2baee = # "hash_48ce6cc8055a83cd";
  }

  if(level.player flag::get("lockpicking")) {
    var_8de2baee = # "hash_65c8e89921291224";
  }

  return var_8de2baee;
}

function function_9fde9426() {
  level.player endon(#"death");
  enemies = getaiarray();
  list = [];
  list[list.size] = "civ_frantic_exposed_idle";
  list[list.size] = "civ_frantic_exposed_idle_twitch_a";
  list[list.size] = "civ_frantic_exposed_idle_twitch_c";
  list[list.size] = "civ_frantic_exposed_idle_twitch_d";
  level scene::stop("scene_kgb_ambient_atrium_talk");

  foreach(guy in enemies) {
    if(guy === level.player.takedown.body) {
      continue;
    }

    guy.var_c681e4c1 = 1;

    if(isDefined(guy.targetname) && (issubstr(guy.targetname, "guard") || issubstr(guy.targetname, "general"))) {
      if(issubstr(guy.targetname, "general")) {
        if(isDefined(level.player)) {
          guy thread animation::play("reb_stl_patrol_pstl_idle_react_md_8", guy.origin, vectortoangles(level.player.origin - guy.origin), 0.5);
        } else {
          guy thread animation::play("reb_stl_patrol_pstl_idle_react_md_8", guy.origin, guy.angles);
        }
      }

      continue;
    }

    guy thread function_2d2c7319(array::random(list));
  }
}

function function_2d2c7319(anim) {
  self endon(#"delete");

  if(isDefined(self)) {
    self stopanimscripted(0.5);
  }

  wait 0.25;

  if(isDefined(self)) {
    self namespace_f592a7b::function_7bd21c92("NONE");
    point = getnearestpathpoint(self.origin, 32);

    if(!isDefined(point)) {
      point = self.origin;
    }

    self thread animation::play(anim, point, self.angles, randomfloatrange(0.75, 1), randomfloatrange(0.2, 0.3), undefined, randomfloatrange(0.1, 0.3), randomfloatrange(0, 0.25));
  }
}

function function_e873b4cd() {
  level endon(#"hash_632b48ff65789b0b");
  level endon(#"flag_player_swap");
  level flag::wait_till("flag_social_stealth_failed");
  namespace_353d803e::music("4.3_tension_stingers");

  if(!level flag::get("flag_player_swap")) {
    util::missionfailedwrapper(#"hash_14c23141aa10eb00", #"hash_20fefa05167b6e6a");
    namespace_353d803e::function_45192a6c();
  }
}

function function_33e0fa9c() {
  objectives::scripted(#"hash_65f30a0836d63c", undefined, #"hash_1e13d67a65b66f6d");
  objectives::scripted(#"hash_2e6a6a9287f33bee", undefined, #"hash_20da149f9d0905a", 0);
  objectives::function_6a5ca7ac(#"hash_2e6a6a9287f33bee", undefined, #"hash_65f30a0836d63c", undefined, 0);
  objectives::scripted(#"hash_32c4531a044c1283", undefined, #"hash_25c43a7db98961f7", 0);
  objectives::function_6a5ca7ac(#"hash_32c4531a044c1283", undefined, #"hash_65f30a0836d63c", undefined, 0);
  level flag::wait_till("flag_keycard_acquired");
  objectives::complete(#"hash_65f30a0836d63c");
  objectives::complete(#"hash_2e6a6a9287f33bee");
  objectives::complete(#"hash_32c4531a044c1283");
}

function function_52f0fcb3(var_d3440450) {
  level.var_dae73e42 = [];
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area_charkov_office";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area_war_room";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area_data_entry";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area_records";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_area_office_1";
  level.var_dae73e42[level.var_dae73e42.size] = "player_in_restricted_maintenance_area";
  level.var_a2c1842c = [];
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e4018280225e07b";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e4017280225dec8";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e401a280225e3e1";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e4019280225e22e";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e401c280225e747";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e401b280225e594";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e401e280225eaad";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e401d280225e8fa";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e4010280225d2e3";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e400f280225d130";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c92280222c6f2";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c93280222c8a5";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c90280222c38c";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c91280222c53f";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c8e280222c026";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c8f280222c1d9";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c8c280222bcc0";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c8d280222be73";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c9a280222d48a";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e3c9b280222d63d";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e398c28022086e9";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e398b2802208536";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e398a2802208383";
  level.var_a2c1842c[level.var_a2c1842c.size] = # "hash_7e398928022081d0";

  while(!isDefined(level.stealth)) {
    waitframe(1);
  }

  level.player endon(#"death");
  level.stealth.fnsetdisguised = &function_d2e50cd;
  level.player.player_actions.enabled[# "hash_4ee54ef61a0301b2"] = 0;
  level.player.player_actions.enabled[# "body_shield_grenade"] = 0;
  spawner::simple_spawn("kgb_hq_guard", &function_862e8bf9);
  namespace_979752dc::set_disguised(1);
  level.armory_guard = spawner::simple_spawn_single("armory_guard", &function_f632133);

  if(var_d3440450 == "kgb_ins_activation" || var_d3440450 == "kgb_ins_briefing" || var_d3440450 == "kgb_ins_tutorial") {
    level.doorman = spawner::simple_spawn_single("doorman", &function_e8e968a5);
    level.doorman thread function_23df39ab();
    spawner::simple_spawn("kgb_hq_guard_second_floor", &function_e8e968a5);
  }

  level thread function_9adc9ad7();
}

function function_9adc9ad7() {
  level endon(#"flag_player_swap");
  level flag::wait_till("player_in_restricted_area");
  spawner::simple_spawn_single("restricted_area_guard", &function_e9e9570d);
  spawner::simple_spawn_single("restricted_server_guard_1", &function_a7db4a16);
  spawner::simple_spawn_single("restricted_server_guard_2", &function_e9e9570d);
}

function function_c3120e0e(a_ents) {
  guy = a_ents[# "actor 1"];
  iprintlnbold("Takedown");
  guy.var_1f1bd6ed = (level.player.origin + guy.origin) / 2;
  guy.var_598a8a9 = vectortoangles(guy.origin - level.player.origin);
}

function function_f632133() {
  self.dontdropweapon = 1;
  self namespace_979752dc::function_2324f175(0);
  self.threatsight = 0;
  self.var_c681e4c1 = 0;
  self thread function_f3d677ab("c_t9_shg_npc_e_reshetnikov_kgb");
  self.propername = function_70594daa();
  self function_bbb9c3b2();
  self thread function_65cd1213();
  self thread function_424c5c7b();
  self thread function_12c4b338();
  self thread function_3cf5b786();
  self thread function_7d7d8fd0();
  self actions::function_df6077("body_shield", 0);
  chair = getent("armory_chair", "targetname");
  self.var_a08ba405 = chair;
  struct = struct::get("armory_takedown_struct");
  self.var_1f1bd6ed = struct.origin;
  self.var_598a8a9 = struct.angles;
  self.var_d3f0031c = "td_scene_nonlethal_behind_b";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
  self.var_59212ad0 = "td_scene_nonlethal_behind_b";
  self.var_f535b314 = # "hash_2f16f66c7d8ae1de";
  self.var_7b026ceb = 96;
  self thread function_72ad2b01();
}

function function_a84b38e(struct) {
  corpse = self;
  self animation::last_frame("takedown_nonlethal_behind_b_victim_choke_sitting", self.origin, self.angles);
}

function function_862e8bf9() {
  if(!isactor(self)) {
    return;
  }

  self.dontdropweapon = 1;
  self.holdfire = 1;
  self thread function_12c4b338();
  self thread function_3cf5b786();
  self battlechatter::function_2ab9360b(0);

  if(!issubstr(self.targetname, "informant")) {
    weapon = getweapon("smg_heavy_t9_kgb_cp");
    self setweapon(weapon);
  }

  self.var_59212ad0 = "td_scene_stealth_front_a";
  self.var_d3f0031c = "td_scene_nonlethal_behind_a";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";

  if(!isDefined(level.player_in_restricted_area)) {
    self namespace_979752dc::function_2324f175(0);
    self.threatsight = 0;
  }

  self.propername = function_70594daa();
  self thread function_7d7d8fd0();
  self setteam(#"axis");

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "no_melee") {
      self.var_c681e4c1 = 1;
    } else {
      self thread function_424c5c7b();
    }
  } else {
    self thread function_424c5c7b();
  }

  self thread namespace_e77bf565::function_3f2f4ef1();
  self function_d64500fa(1);
  self function_671753a4();
}

function function_671753a4() {
  self namespace_979752dc::set_event_override("combat", &function_b4b31f5a);
}

function function_b4b31f5a(event) {
  if(!level flag::get_any(level.var_dae73e42) && level flag::get("player_doing_stealth_action")) {
    level.var_f695d653 = function_37c2fed8();
    level flag::set("kgb_fail_mission");
    return false;
  }

  return true;
}

function function_e8e968a5() {
  self.dontdropweapon = 1;
  self.holdfire = 1;
  self thread function_3cf5b786("flag_in_camera_room");
  self.propername = function_70594daa();
  self.var_c681e4c1 = 1;
  self battlechatter::function_2ab9360b(0);
  self thread namespace_e77bf565::function_3f2f4ef1();
  self function_d64500fa(1);
}

function function_23df39ab() {
  self endon(#"death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  level flag::wait_till("flag_start_finding_ways");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

function function_198d6c82() {
  self waittill(#"death");

  if(!level flag::get("flag_player_swap")) {
    namespace_353d803e::music("4.2_search_stingers");
  }
}

function function_424c5c7b() {
  self endon(#"death");
  self.var_c681e4c1 = 1;

  while(isalive(self)) {
    if(level flag::get("kgb_enable_context_melee")) {
      self.var_c681e4c1 = 0;
      level flag::wait_till_clear("kgb_enable_context_melee");
    } else {
      self.var_c681e4c1 = 1;
      level flag::wait_till("kgb_enable_context_melee");
    }

    waitframe(1);
  }
}

function function_7d7d8fd0() {
  self endon(#"death");
  self waittill(#"takedown_begin");
  self notify(#"dialog_wait_cancel");

  if(!level flag::get("flag_player_swap")) {
    namespace_353d803e::music("4.2_search_stingers");
  }
}

function function_70594daa() {
  if(level flag::get_any(["flag_prep_elevator", "flag_player_swap"])) {
    return;
  }

  return array::random(level.var_a2c1842c);
}

function function_3cf5b786(flag_name = "flag_cleanup_kgb_hq") {
  self endon(#"death");
  self endon(#"deleted");
  self endon(#"entitydeleted");
  level flag::wait_till(flag_name);
  waitframe(1);

  if(isDefined(self)) {
    self delete();
  }
}

function function_f3d677ab(name = "c_t9_ger_civ_female_head01") {
  self endon(#"death");
  self detach(self.head);
  waitframe(1);
  self attach(name);
}

function function_12c4b338() {
  level endon(#"flag_player_swap");
  self endon(#"death");
  self waittill(#"corpse_found", #"corpse_seen_claim");

  if(level flag::get("flag_player_swap")) {
    return;
  }

  level flag::set("flag_social_stealth_failed");
}

function function_d2e50cd(disguised = 0) {
  level.player endon(#"death");

  if(disguised) {
    level.stealth.disguised = 1;
    level.stealth.threatsightratescale = 0;
    level.stealth.threatsightdistscale = 0;
    level.stealth.proximity_combat_radius_bump = 0;
    level.stealth.proximity_combat_radius_sight = 0;
    level.stealth.proximity_combat_radius_fake_sight = 0;
    setsaveddvar(#"hash_12c53cd4a01caff3", 0.25);
    setsaveddvar(#"hash_5edb3c8437c5990e", cos(90));
    setsaveddvar(#"hash_30eedc859ec98ad", 0.025);
    setsaveddvar(#"hash_5aaea648688ff01e", 0.25);
    setsaveddvar(#"hash_7bf40e4b6a830d11", 0);
    level.stealth.var_92ee0879 = "sentientevents_stealth_social";
    loadsentienteventparameters(level.stealth.var_92ee0879);
  } else {
    level.stealth.disguised = undefined;

    if(!level flag::get("player_doing_stealth_action") && level flag::get_any(level.var_dae73e42)) {
      level.stealth.threatsightratescale = undefined;
      level.stealth.threatsightdistscale = 1;
    } else if(!level flag::get_any(level.var_dae73e42) && !level.player flag::get("lockpicking")) {
      level.stealth.threatsightratescale = 1.1;
      level.stealth.threatsightdistscale = 3;
    } else {
      level.stealth.threatsightratescale = 0.85;
      level.stealth.threatsightdistscale = 1;
    }

    level.stealth.proximity_combat_radius_bump = 32;
    level.stealth.proximity_combat_radius_sight = 150;
    level.stealth.proximity_combat_radius_fake_sight = 60;

    if(!level flag::get("flag_start_finding_ways")) {
      level.stealth.threatsightratescale = 0.25;
      level.stealth.threatsightdistscale = 0.25;
      level.stealth.proximity_combat_radius_bump = 0;
      level.stealth.proximity_combat_radius_sight = 0;
      level.stealth.proximity_combat_radius_fake_sight = 0;
    }

    setsaveddvar(#"hash_12c53cd4a01caff3", 0.95);
    setsaveddvar(#"hash_5edb3c8437c5990e", cos(180));
    setsaveddvar(#"hash_7bf40e4b6a830d11", 1);
    setsaveddvar(#"hash_30eedc859ec98ad", 0.025);
    setsaveddvar(#"hash_5aaea648688ff01e", 0.25);
  }

  var_210a8489 = getactorarray();

  foreach(ai in var_210a8489) {
    if(!isalive(ai)) {
      continue;
    }

    if(isDefined(ai.stealth) && isDefined(ai.stealth.threat_sight_state)) {
      ai stealth_threat_sight::threat_sight_set_state_parameters();
    }
  }
}

function function_dc6c4b5e() {
  array[# "sight_dist"] = 2500;
  array[# "detect_dist"] = 600;
  array[# "found_dist"] = 32;
  namespace_cc4354b9::set_corpse_ranges(array);
}

function function_84d00884() {
  level thread function_b08d8aa7();
}

function function_b08d8aa7() {
  level.var_7261bb53 = scene::get_scenedefs();

  for(i = 0; i < level.var_7261bb53.size; i++) {
    if(issubstr(level.var_7261bb53[i].name, "ambient") && !issubstr(level.var_7261bb53[i].name, "fake") && !issubstr(level.var_7261bb53[i].name, "mail") && !issubstr(level.var_7261bb53[i].name, "guard") && !issubstr(level.var_7261bb53[i].name, "harass") && !issubstr(level.var_7261bb53[i].name, "typing") && !issubstr(level.var_7261bb53[i].name, "railing") && !issubstr(level.var_7261bb53[i].name, "interr") && !issubstr(level.var_7261bb53[i].name, "read") && !issubstr(level.var_7261bb53[i].name, "mopping") && !issubstr(level.var_7261bb53[i].name, "cleaning") && !issubstr(level.var_7261bb53[i].name, "pc") && !issubstr(level.var_7261bb53[i].name, "checkpoint") && !issubstr(level.var_7261bb53[i].name, "filing") && !issubstr(level.var_7261bb53[i].name, "phone") && !issubstr(level.var_7261bb53[i].name, "writing") && !issubstr(level.var_7261bb53[i].name, "security") && !issubstr(level.var_7261bb53[i].name, "desk") && !issubstr(level.var_7261bb53[i].name, "folder") && !issubstr(level.var_7261bb53[i].name, "reel") && !issubstr(level.var_7261bb53[i].name, "table")) {
      level scene::function_d0d7d9f7(level.var_7261bb53[i].name, &function_4ccaa9ae);
    }
  }
}

function function_4ccaa9ae(a_ents) {
  foreach(ent in a_ents) {
    if(isai(ent)) {
      ent thread function_252c0591();
    }
  }
}

function function_252c0591() {
  if(level flag::get("flag_player_swap")) {
    return;
  }

  if(isDefined(self.var_252c0591) && self.var_252c0591) {
    return;
  }

  self.var_252c0591 = 1;
  self endon(#"death");
  self endon(#"deleted");
  self endon(#"entitydeleted");
  self setteam(#"axis");
  self.script_stealthgroup = "amb_civ";
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.var_c681e4c1 = 1;
  level flag::wait_till_any(["player_doing_stealth_action", "kgb_corpse_on_map"]);
  self thread function_12c4b338();
  waitframe(1);

  if(!isDefined(self.stealth) && !isDefined(self.flag[# "stealth_enabled"])) {
    self namespace_979752dc::do_stealth();
  }

  self namespace_979752dc::set_event_override("investigate", &function_1a9ba24a);
  self namespace_979752dc::set_event_override("cover_blown", &function_691aa4b6);
  self namespace_979752dc::set_event_override("combat", &function_691aa4b6);

  while(isalive(self)) {
    level flag::wait_till_any(["player_doing_stealth_action", "kgb_corpse_on_map"]);
    self.ignoreme = 0;
    self.ignoreall = 0;
    self function_13a62823();
    self.ignoreme = 1;
    self.ignoreall = 1;
    waitframe(1);
  }
}

function function_1a9ba24a(event) {
  return true;
}

function function_691aa4b6(event) {
  return false;
}

function function_102a262a() {
  if(!isDefined(self)) {
    return false;
  }

  dist_check = 1000000;
  level.player endon(#"death");
  civ = self;
  dist = distance2dsquared(self.origin, level.player.origin);
  return dist < dist_check;
}

function function_13a62823() {
  self endon(#"death");
  level endon(#"hash_632b48ff65789b0b");
  level endon(#"hash_ee5ce4556fbfba0");
  level flag::wait_till_clear_all(["player_doing_stealth_action", "kgb_corpse_on_map"]);
}

function function_7e1ccae4() {
  level flag::wait_till("kgb_ins_rv_completed");
  level scene::delete_scene_spawned_ents("ambient_kgb");
}

function function_9150e0d9() {
  level endon(#"hash_632b48ff65789b0b");
  level endon(#"flag_player_swap");
  level.player endon(#"death");
  var_60040c40 = 0;
  corpses = getcorpsearray();

  while(!level flag::get("flag_player_swap")) {
    corpses = getcorpsearray();

    if(isDefined(corpses) && corpses.size) {
      var_60040c40 = 0;

      for(i = 0; i < corpses.size; i++) {
        if(corpses[i] namespace_e77bf565::function_127e0d08()) {
          continue;
        }

        var_60040c40 = 1;
      }

      if(var_60040c40) {
        level flag::set("kgb_corpse_on_map");
      } else {
        level flag::clear("kgb_corpse_on_map");
      }
    } else {
      level flag::clear("kgb_corpse_on_map");
    }

    corpses = undefined;
    wait 0.5;
  }

  level flag::clear("kgb_corpse_on_map");
}

function function_2388bc70() {
  snd::client_msg(#"hash_2d4abae990c4399");
  level thread function_9cdcfd88();
  level.general = spawner::simple_spawn_single("general", &function_6c654d7e);
  level.secretary = spawner::simple_spawn_single("kgb_secretary", &function_74ad7322);
}

function function_6c654d7e() {
  level.player endon(#"death");
  level endon(#"kgb_fail_mission");
  self thread function_12c4b338();
  self thread function_3cf5b786();
  self function_7494fe03();
  self.animname = "general";
  self.dontdropweapon = 1;
  self.propername = # "hash_50d58662d307f9c7";
  self thread function_94385b7e();
  self thread function_bde19b69();
  self actions::function_df6077("body_shield", 0);
  self battlechatter::function_2ab9360b(0);
  self thread function_490a8713();
  self.var_d3f0031c = "td_scene_nonlethal_behind_b";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
  self.var_59212ad0 = "td_scene_stealth_front_a";
  self thread charkov_custom_fail();
  level scene::add_scene_func("scene_kgb_generals_office", &function_9c6821fd, "stop");
  level thread scene::play("scene_kgb_generals_office", self);
  self waittill(#"death");
  level thread function_6cd03c49();
}

function function_9c6821fd(a_ents) {
  if(!level flag::get_any(level.var_dae73e42)) {
    if(isDefined(a_ents[# "book"])) {
      a_ents[# "book"] delete();
    }

    if(isDefined(a_ents[# "hash_ef2f86f22813190"])) {
      a_ents[# "hash_ef2f86f22813190"] delete();
    }

    if(isDefined(a_ents[# "hash_7dc6af6674ff92ee"])) {
      a_ents[# "hash_7dc6af6674ff92ee"] delete();
    }
  }
}

function function_cf96c84a() {
  self endon(#"death");
  level flag::wait_till_any(level.var_dae73e42);
  self.var_d3f0031c = "td_scene_nonlethal_behind_b";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
}

function function_94385b7e() {
  self endon(#"death");
  level.player endon(#"death");
  self waittill(#"takedown_begin");
  self.var_a6ac27c = 1;
  victimfwd = anglesToForward(self.angles);
  playerdelta = vectornormalize(level.player.origin - self.origin);
  dot = vectordot(playerdelta, victimfwd);

  if(dot < 0) {
    self.var_d3f0031c = "td_scene_nonlethal_behind_a";
    self.var_59212ad0 = "td_scene_nonlethal_behind_a";
    self.var_598a8a9 = level.player.angles;
  }

  wait 0.2;
  level scene::stop("scene_kgb_generals_office");
}

function function_7494fe03() {
  self namespace_979752dc::set_event_override("investigate", &function_2283ad6a);
  self namespace_979752dc::set_event_override("cover_blown", &function_c3a87cc);
  self namespace_979752dc::set_event_override("combat", &function_c3a87cc);
}

function function_bbb9c3b2() {
  self namespace_979752dc::set_event_override("cover_blown", &function_cd4b0ed6);
  self namespace_979752dc::set_event_override("combat", &function_cd4b0ed6);
}

function function_cd4b0ed6(event) {
  return false;
}

function function_97bc47c4(event) {
  return false;
}

function function_2283ad6a(event) {
  return true;
}

function function_c3a87cc(event) {
  self endon(#"death");

  if(isDefined(self.var_a6ac27c)) {
    return true;
  }

  if(level flag::get_any(level.var_e9c8a6d4)) {
    level flag::set("charkov_custom_fail");
    return true;
  }

  return true;
}

function charkov_custom_fail() {
  self endon(#"death", #"takedown_begin");
  level flag::wait_till("charkov_custom_fail");
  wait 1;
  self.var_c681e4c1 = 1;
  level.var_f695d653 = function_37c2fed8();
  level flag::set("kgb_fail_mission");
  level flag::set("stealth_spotted");
}

function function_6cd03c49() {
  level.player endon(#"death");

  if(!level flag::get("flag_player_swap") && !level flag::get("flag_keycard_acquired")) {
    namespace_e77bf565::function_e90c279f();
    level thread namespace_353d803e::music("5.2_kill");
    level scene::stop("scene_kgb_generals_office");
    level flag::set("no_corpse_pickup");
    wait 1;
    snd::client_msg(#"hash_75e3c63844a5eb53");
    weapon = getweapon(#"hash_201ae1a63467400c");
    level.player giveweapon(weapon);
    level.player switchtoweaponimmediate(weapon, 1);
    level.player thread gestures::function_b6cc48ed("ges_kgb_keycard_inspect", undefined, 1, 0, undefined, 0, 1);
    level.player namespace_e77bf565::function_f954feae(#"hash_7a524b2fff5dad2c");
    level flag::set("flag_keycard_acquired");
    level flag::clear("no_corpse_pickup");
  }
}

function function_4ba2815c() {
  self endon(#"death");
  self waittill(#"takedown_begin");
  level flag::set("flag_keycard_acquired");
}

function function_bde19b69() {
  level endon(#"flag_start_charkov_investigation");
  level endon(#"flag_poi_interrogation_uncuff");
  self endon(#"death");
  level endon(#"flag_player_swap");
  level.player endon(#"death");
  level flag::wait_till("flag_start_finding_ways");
  wait 3;
  dist_to_check = 122500;
  dist = distance2dsquared(self.origin, level.player.origin);

  while(isDefined(self)) {
    wait 0.5;

    if(!level.player function_80d68e4d(self, cos(25), 1)) {
      dist = distance2dsquared(self.origin, level.player.origin);

      if(dist < dist_to_check) {
        break;
      }
    }
  }

  if(!level flag::get("flag_start_charkov_investigation")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_thereischarkov_10");
  }
}

function function_490a8713() {
  level endon(#"flag_player_swap");
  self endon(#"death");
  tag = spawn("script_model", self.origin);
  tag setModel("tag_origin");
  tag linkto(self, "tag_origin", (0, 0, 44));
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_12aeefa638922fae", 72, undefined, &function_519cff6f, undefined, 128, undefined, undefined, undefined, 1, &function_3b01cf47);
  self function_bf9a3b8d();
  tag util::remove_cursor_hint();
  tag delete();
}

function function_bf9a3b8d() {
  self endon(#"death");
  self endon(#"takedown_begin");
  level endon(#"charkov_custom_fail");
  level flag::wait_till("flag_keycard_acquired");
}

function function_3b01cf47(prompt) {
  return !level flag::get("flag_charkov_in_scene");
}

function function_519cff6f(prompt_struct) {
  level.player endon(#"death");

  if(!level flag::get("flag_keycard_acquired")) {
    snd::client_msg(#"hash_75e3c63844a5eb53");
    weapon = getweapon(#"hash_201ae1a63467400c");
    level.player giveweapon(weapon);
    level.player switchtoweaponimmediate(weapon, 1);
    level.player gestures::function_b6cc48ed("ges_kgb_keycard_inspect", undefined, 1, 0, undefined, 0, 1);
    level.player namespace_e77bf565::function_f954feae(#"hash_7a524b2fff5dad2c");
    level flag::set("flag_keycard_acquired");
  }
}

function function_74ad7322() {
  self thread function_f3d677ab("c_t9_shg_npc_a_smirnov_kgb");
  self thread function_12c4b338();
  self thread function_3cf5b786();
  self thread function_7d7d8fd0();
  self battlechatter::function_2ab9360b(0);
  self.var_c681e4c1 = 1;
  self thread function_ad70221();
  self.propername = function_70594daa();
}

function function_767b075a(guy) {
  guy waittill(#"death");

  if(isDefined(self)) {
    self util::remove_cursor_hint();
  }
}

function function_ad70221() {
  secretary = self;
  self endon(#"death");
  self endon(#"hash_ba0b8dc5bb1537b");
  level thread scene::play("scene_kgb_secretary_dt", "Front_Idle");
  level flag::wait_till("flag_start_finding_ways");
  wait 1.5;
  doors::function_f35467ac("charkov_fake_door", "targetname");
  level.var_753658ee = dialog_tree::new_tree(&function_7abb420b, &function_5cdd5ba8, undefined, 1, "scene_kgb_secretary_dt");
  level.var_753658ee dialog_tree::function_b82713b8(struct::get("secretary_chat_front"), "Intro_Front", "Choice_Loop");
  level.var_753658ee dialog_tree::add_option(#"hash_20e53b05f35a27bb", undefined, "Response_1", "Choice_Loop", undefined, "flag_player_scheduled_meeting");
  level.var_753658ee dialog_tree::function_f5d1891("flag_has_poison", #"hash_20e53c05f35a296e", undefined, undefined, undefined, 1, "flag_start_charkov_investigation", "flag_keycard_aquried", &function_61fd8024);
  level.var_753658ee dialog_tree::function_bc7c03bf();
  level.var_753658ee dialog_tree::add_option(#"hash_246357eddf2857b8", undefined, "Outro_Front", undefined, 1, undefined, "flag_keycard_aquried", &function_c3977dda);
  a_flags = ["flag_keycard_acquired", "flag_cup_poisoned", "flag_poi_krav_wait", "flag_player_swap", "flag_start_charkov_investigation", "flag_prisoner_complete"];
  self thread function_1cca61db(a_flags);

  while(!level flag::get_any(a_flags) && isalive(self)) {
    self thread function_33af2072();
    self dialog_tree::function_cfa96cee(level.var_753658ee, undefined, undefined, 64);

    if(!level flag::get("flag_start_charkov_investigation")) {
      wait 1;
    }
  }

  if(level flag::get("flag_keycard_acquired") || level flag::get("flag_prisoner_complete") || level flag::get("flag_poi_krav_wait")) {
    return;
  }

  level.general_door = doors::function_73f09315("charkov_fake_door", "targetname");
  level scene::stop("scene_kgb_secretary_dt");
  level thread scene::play("scene_kgb_poison_tea", "Office_Intro");
  level thread scene::play("scene_kgb_poison_door", "Office_Intro", level.general_door);
}

function function_61fd8024() {
  level.player endon(#"death");
  doors::unlock("general_door", "targetname", 1, level.player);
  level flag::set("flag_poi_office_meeting");
  charkov_office_restricted_area_trigger = getent("charkov_office_restricted_area_trigger", "targetname");

  if(isDefined(charkov_office_restricted_area_trigger)) {
    charkov_office_restricted_area_trigger delete();
  }

  level.var_1b4de43[level.var_1b4de43.size] = "office";
  level notify(#"ping_map");
  snd::client_msg(#"hash_4ec9a2c1432e46bb");
}

function function_4c61e92b(prompt) {
  level.var_753658ee thread dialog_tree::run(level.secretary);
}

function function_33af2072() {
  self endon(#"death", #"deleted", #"entitydeleted");
  self waittill(#"trigger");
  self stopsounds();
}

function function_7abb420b() {
  level flag::clear("flag_start_secretary_loop");
  level thread function_c9965ab9(1);
}

function function_5cdd5ba8() {
  level thread function_c9965ab9(0);

  if(!level flag::get("flag_has_poison")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_ihaveachancetok_29");
  }

  if(!level flag::get("flag_start_charkov_investigation")) {
    level scene::play("scene_kgb_secretary_dt", "Outro_Front");
  }
}

function function_e7f546e6(prompt) {
  a_flags = ["flag_keycard_acquired", "flag_cup_poisoned", "flag_mail_sent", "flag_player_swap", "dialog_tree_active", "flag_secretary_busy"];
  return !level flag::get_any(a_flags);
}

function function_2e2ec374() {
  level flag::set("flag_poi_interrogation_file");
  level flag::set("flag_poi_records_file");
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");
}

function function_c3977dda() {
  level flag::set("flag_poi_office_secretary");
  level flag::set("flag_start_secretary_loop");
  level.var_1b4de43[level.var_1b4de43.size] = "office";
  level notify(#"ping_map");
}

function function_2d5aaa39() {
  level.secretary thread function_680c8cbe();
}

function function_8aa2b4ee() {
  level flag::set("obj_secretary_done");
}

function function_ada5392f() {
  level.guard = spawner::simple_spawn_single("prison_guard", &function_c1e43496);
  prisoner = spawner::simple_spawn_single("prisoner", &function_c1fe873f);
  level thread function_254d4a95();
}

function function_c1e43496() {
  self.var_c681e4c1 = 1;
  self thread function_12c4b338();
  self thread function_3cf5b786();
  self thread function_7d7d8fd0();
  self thread function_32b152c2();
  self thread function_f3d677ab("c_t9_shg_npc_c_lutz_m35pilotka");
  self stealth_enemy::disable_player_headtracking();
  self battlechatter::function_2ab9360b(0);
  self.propername = function_70594daa();
  weapon = getweapon("smg_heavy_t9_kgb_cp");
  self setweapon(weapon);
}

function function_32b152c2() {
  self endon(#"death");
  guy = self;
  level.var_fd2ed10f = self;
  level thread scene::play("scene_kgb_influence_prisoner_guard_dt", "Loop", [self]);
  wait 2.5;
  var_92a1f38a = dialog_tree::new_tree(undefined, undefined, undefined, 1, "scene_kgb_influence_prisoner_guard_dt");
  var_92a1f38a dialog_tree::set_scriptbundle("scene_kgb_influence_prisoner_guard_dt");
  var_92a1f38a dialog_tree::function_b82713b8(struct::get("struct_prison_guard_chat"), "Intro", "Loop", "Outro");
  var_92a1f38a dialog_tree::add_option(#"hash_586a246b93b5ac22", undefined, "Response1", "Loop", undefined, undefined, "flag_prisoner_complete_call");
  var_92a1f38a dialog_tree::add_option(#"hash_66d10cbf3ef326e0", undefined, "Response2", "Loop", undefined, undefined, "flag_prisoner_complete_call");
  var_92a1f38a dialog_tree::add_option(#"hash_7cffbc1082a46178", undefined, "Response3", "Loop", undefined, undefined, "flag_unlock_prison_door", &function_5d0e53d2);
  var_92a1f38a dialog_tree::add_option(#"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "flag_prisoner_complete_call", &function_99796d90);
  a_flags = ["flag_prisoner_complete", "flag_keycard_acquired"];
  self thread function_1cca61db(a_flags);

  while(!level flag::get_any(a_flags) && isalive(self)) {
    guy dialog_tree::function_cfa96cee(var_92a1f38a, undefined, undefined, undefined, 96, undefined, 10);
    wait 1;
  }

  level flag::set("flag_charkov_in_scene");
  level flag::wait_till("flag_prison_guard_wait");
  wait 30;
  level flag::set("flag_poi_interrogation_take");
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");
  level thread function_8703e51a(struct::get("check_body", "targetname"));
  var_181069db = dialog_tree::new_tree(&function_36beec55, &function_b5c2e9b8, undefined, 1, "scene_kgb_influence_prisoner_exit_dt");
  var_181069db dialog_tree::set_scriptbundle("scene_kgb_influence_prisoner_exit_dt");
  var_181069db dialog_tree::function_b82713b8(struct::get("struct_prison_guard_death_chat"), "Intro", "Loop");
  var_181069db dialog_tree::add_option(#"hash_45bdc476a351ac7f", undefined, "Outro", undefined, 1, "flag_prison_guard_go_away");
  guy dialog_tree::function_cfa96cee(var_181069db, undefined, undefined, undefined, 64);
  level thread scene::play("scene_kgb_influence_prisoner_exit_dt", "Civ_Convo", guy);
  level thread function_d6c85c51();
  level flag::wait_till("flag_player_swap");
  level thread scene::play("scene_kgb_interrogation_room_door", "Close");
  level thread scene::stop("scene_kgb_influence_prisoner_exit_dt", 1);
}

function function_d6c85c51() {
  struct = struct::get("check_body", "targetname");
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_12aeefa638922fae", 64, undefined, &function_bda52e77, undefined, 128, undefined, 0, 1);
  struct prompts::set_objective(#"hash_5e6b451a3d52cb04");
  level flag::wait_till("flag_keycard_acquired");
  struct util::remove_cursor_hint();
}

function function_bda52e77(prompt) {
  level thread function_b8947848();
  level.player namespace_e77bf565::function_f954feae(#"hash_1bcbed68b6504458");
  level flag::set("flag_keycard_acquired");
}

function function_b8947848() {
  level thread function_c9965ab9(1);
  level scene::play("scene_kgb_influence_prisoner", "Grab_Card");
  level thread function_c9965ab9(0);
}

function function_36beec55() {
  self scene::stop("scene_kgb_influence_prisoner");
  level thread disable_mental_map();
}

function function_ec5d1bb7() {
  self thread function_dbfe9c06("struct_prison_guard_death_chat");
  level scene::play("scene_kgb_influence_prisoner_exit_dt", "Intro", self);
  level thread scene::play("scene_kgb_influence_prisoner_exit_dt", "Loop", self);
}

function function_5d0e53d2() {
  level flag::set("flag_unlock_prison_door");
}

function function_ad592f2c() {}

function function_201b919() {
  level flag::wait_till_any(["flag_keycard_acquired", "flag_prisoner_complete", "flag_checkpoint_moment_done"]);

  if(isDefined(self)) {
    self notify(#"dialog_wait_cancel");
  }
}

function function_99796d90() {}

function function_254d4a95() {
  level.player endon(#"death");
  level endon(#"flag_player_swap");

  while(true) {
    var_b99293cd = struct::get("struct_interrogation_open", "targetname");
    var_b99293cd util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1b2da47a0dd85d2d", 96, undefined, &function_46844241, undefined, undefined, 15, 0, 1, 0, &function_9b7b06c0);
    level waittill(#"hash_45cc1be4c32503b7");
    var_b99293cd util::remove_cursor_hint();
    level flag::set("door_is_opened");
    level scene::play("scene_kgb_interrogation_room_door", "Open");

    if(level flag::get("flag_prisoner_complete")) {
      break;
    }

    var_50bc6cb5 = struct::get("struct_interrogation_close", "targetname");
    var_50bc6cb5 util::create_cursor_hint(undefined, (0, 0, 0), #"hash_4142e9454fccf28f", 80, undefined, &function_bb965821, undefined, undefined, undefined, 0, 1, 0, &function_56284cd4);
    level waittill(#"hash_111341e49472de91");
    var_50bc6cb5 util::remove_cursor_hint();
    level flag::clear("door_is_closed");

    if(level flag::get("flag_prisoner_complete")) {
      break;
    }

    level scene::play("scene_kgb_interrogation_room_door", "Close");
  }

  level flag::wait_till("flag_prison_guard_wait");
  level scene::play("scene_kgb_interrogation_room_door", "General_Kill");
}

function function_9b7b06c0(prompt) {
  return !level flag::get_any(["flag_player_swap", "flag_prep_elevator", "flag_keycard_acquired"]);
}

function function_56284cd4(prompt) {
  return !level flag::get_any(["flag_player_swap", "flag_prep_elevator", "flag_keycard_acquired", "flag_prisoner_complete", "door_is_closed"]);
}

function function_9e511069(a_ents) {
  level flag::wait_till("flag_start_finding_ways");
  door = a_ents[# "prop 1"];
  door attach("p9_rus_door_placard_plastic_01", "door_plate_a");
  waitframe(1);
  door attach("p9_rus_door_placard_text_01_" + "interrogation", "door_plate_a");
  waitframe(1);
  door namespace_e77bf565::function_aa042bc7("interrogation", "door_plate_a", 72);
}

function function_bb965821(prompt_struct) {
  level notify(#"hash_111341e49472de91");
}

function function_46844241(prompt_struct) {
  level notify(#"hash_45cc1be4c32503b7");
}

function function_c1fe873f() {
  self thread function_3cf5b786();
  self endon(#"death");
  self thread function_201b919();
  level scene::init("scene_kgb_influence_prisoner");
  level thread function_b9aeac28();
  level thread scene::play("scene_kgb_influence_prisoner", "Wait_Loop", self);
  self detach(self.head);
  self attach("c_t9_ger_civ_male_head01");
  waitframe(1);
  self setModel("c_t9_ger_civ_male_urban_body6b");
  level.prisoner = self;
  guy = self;
  level.prisoner_chat = dialog_tree::new_tree(&function_3170644c, &function_f4f9e3d6, undefined, 1, "scene_kgb_influence_prisoner", 1, undefined, 0);
  guy thread function_88993dba();
  level.prisoner_chat dialog_tree::add_option(#"hash_7f36570537354d29", undefined, "Response_1", "Dialogue_Loop", undefined, "flag_show_file_option", "flag_show_file_option");
  level.prisoner_chat dialog_tree::function_f5d1891("flag_show_family_choice", #"hash_7af495b8d500519b", undefined, "Response_3", "Dialogue_Loop", undefined, "flag_family_options", "flag_family_options");
  level.prisoner_chat dialog_tree::add_option(#"hash_7f36540537354810", undefined, "Response_2", "Dialogue_Loop", undefined, "flag_show_file_option", "flag_show_file_option");
  level.prisoner_chat dialog_tree::function_f5d1891("flag_show_family_choice", #"hash_7af495b8d500519b", undefined, "Response_3", "Dialogue_Loop", undefined, "flag_family_options", "flag_family_options");
  level.var_27b1d47f = level.prisoner_chat dialog_tree::function_6bbbf87("flag_player_swap", #"hash_2f4e958be6986c18", undefined, "Response_3", "Dialogue_Loop", undefined, "flag_family_options", "flag_family_options");
  level.prisoner_chat dialog_tree::function_6bbbf87("flag_family_options", #"hash_2f4e968be6986dcb", undefined, "Response_4", "Dialogue_Loop", undefined, "flag_influence_success", "flag_influence_success");
  level.prisoner_chat dialog_tree::function_6bbbf87("flag_family_options", #"hash_2f4e978be6986f7e", undefined, "Response_5", "Dialogue_Loop", undefined, "flag_influence_success", "flag_influence_success");
  level.prisoner_chat dialog_tree::function_6bbbf87("flag_influence_success", #"hash_67feba656a615798", undefined, "Response_6", "Dialogue_Loop", 1, undefined);
  level.prisoner_chat dialog_tree::add_option(#"hash_32081723b01a955f", undefined, undefined, undefined, 1, undefined, "flag_influence_success", &function_dfc86076);
  level thread function_65935263();
  level thread function_743434d9();
  level thread function_dfc86076();
  level flag::wait_till("flag_influence_success");
  level flag::set("flag_poi_interrogation_uncuff");
  namespace_99e99ffa::function_1b3a9d9f("stop", "interrogation_section_duo_a", 1);
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");

  if(level flag::get("flag_keycard_acquired") || level flag::get("flag_mail_sent")) {
    return;
  }

  level thread function_3f0c6c34();
  level flag::wait_till("flag_prisoner_complete_call");
  level scene::stop("scene_kgb_influence_prisoner");
  level scene::play("scene_kgb_influence_prisoner", "General_Kill_Enter", [level.prisoner, level.guard, level.general]);
  level thread scene::play("scene_kgb_influence_prisoner", "General_Kill_Wait", [level.prisoner, level.guard, level.general]);
  vol = getent("prisoner_volume", "targetname");
  level.player endon(#"death");

  while(level.player istouching(vol)) {
    waitframe(1);
  }

  level thread interrogation_door_clip();
  level.prisoner stealth_enemy::disable_player_headtracking();
  level flag::set("flag_prison_guard_wait");
  level thread scene::play("scene_kgb_influence_prisoner", "General_Kill", [level.prisoner, level.guard, level.general]);
}

function interrogation_door_clip() {
  door = getent("interrogation_door_clip", "targetname");
  door.origin += (0, 0, -128);
  wait 10;
  door delete();
  var_13cf2787 = getent("prisoner_pencil", "targetname");
  var_13cf2787 setModel("un_office_pencil_01_bloody");
  wait 5;

  if(isDefined(level.general)) {
    level.general detach(level.general.head);
    level.general attach("c_t9_rus_kgb_officer_charkov_head01_injured");
  }
}

function function_65935263() {
  level endon(#"flag_prisoner_complete_call");
  level flag::wait_till("flag_show_file_option");

  if(!level flag::get("flag_show_family_choice")) {
    level.prisoner_chat dialog_tree::function_bc7c03bf(level.var_27b1d47f);
  }
}

function function_743434d9() {
  level endon(#"flag_prisoner_complete_call");
  level flag::wait_till_all(["flag_show_family_choice", "flag_show_file_option"]);
  level.prisoner_chat.options[level.var_27b1d47f].show_locked = 0;
}

function function_dfc86076() {
  if(level flag::get("flag_influence_success")) {
    return;
  }

  struct = struct::get("prisoner_start", "targetname");
  struct util::create_cursor_hint(undefined, undefined, #"hash_2700aa498f22c978", 32, undefined, &function_c0a84859, undefined, undefined, undefined, undefined, undefined, undefined, &function_4831c198);
  struct prompts::set_objective("prisoner_persuasion");
}

function function_4831c198(prompt) {
  return !level flag::get_any(["flag_keycard_acquired", "flag_start_charkov_investigation", "flag_poi_krav_wait"]);
}

function function_c0a84859(prompt_struct) {
  level thread function_c9965ab9(1);
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  level.prisoner_chat thread dialog_tree::run(level.prisoner);
  self util::remove_cursor_hint();
}

function function_3170644c() {
  level thread function_680c8cbe();

  if(!isDefined(level.var_17746075)) {
    level thread function_48a24d3b(1.3);
    level.var_17746075 = 1;
  }

  snd::client_msg(#"hash_df2f3038c7a4515");
  level scene::play("scene_kgb_influence_prisoner", "Dialogue_Intro_L");
  level notify(#"hash_111341e49472de91");
  level thread scene::play("scene_kgb_influence_prisoner", "Dialogue_Loop");
}

function function_48a24d3b(delay) {
  wait delay;
  level.prisoner thread dialogue::queue("vox_cp_rkgb_01585_rms2_whoeveryouareyo_06");
}

function function_f4f9e3d6() {
  level thread function_589d3c34();
  snd::client_msg(#"hash_24e50b51fc3d3d2d");
  level scene::play("scene_kgb_influence_prisoner", "Dialogue_Outro");
  namespace_e77bf565::function_f6eb250d();
  level thread scene::play("scene_kgb_influence_prisoner", "Wait_Loop", [level.prisoner]);

  if(level flag::get("flag_influence_success")) {
    level flag::set("flag_prompt_cuffs");
  } else if(!level flag::get("flag_show_family_choice") && level flag::get("flag_show_file_option")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_ivanovwontcoope_ff");
    level flag::set("flag_poi_interrogation_file");
    level flag::set("flag_poi_records_file");
    level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
    level notify(#"ping_map");
  }

  level thread function_c9965ab9(0);
}

function function_88993dba(a_flags = ["flag_keycard_acquired"]) {
  self endon(#"death");
  level flag::wait_till_any(a_flags);
  self notify(#"dialog_wait_cancel");
}

function function_3f0c6c34() {
  struct = struct::get("cuffs", "targetname");
  level flag::wait_till("flag_prompt_cuffs");
  struct util::create_cursor_hint(undefined, undefined, #"hash_8210540516b78ab", 64, undefined, &function_9c0573b2, undefined, undefined, undefined, 0);
  struct prompts::set_objective("prisoner_persuasion");
  level flag::wait_till("flag_prisoner_complete");
  level notify(#"hash_111341e49472de91");
  struct util::remove_cursor_hint();
  level flag::set("flag_poi_interrogation_wait");
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");
}

function function_9c0573b2(prompt_struct) {
  level flag::set("flag_prisoner_complete");
  namespace_353d803e::function_7058432e();
  namespace_353d803e::music("5.0_unlock");
}

function function_b9aeac28() {
  struct = struct::get("prisoner_chat", "targetname");
  struct util::create_cursor_hint(undefined, undefined, #"hash_6dad8ef761859b90", 40, undefined, &function_a1dee806);
  struct prompts::set_objective("prisoner_persuasion");
  level flag::wait_till_any(["flag_show_family_choice", "flag_keycard_acquired"]);
  struct util::remove_cursor_hint();
}

function function_a1dee806(prompt_struct) {
  level thread function_ac832cf3();
}

function function_ac832cf3() {
  level.player endon(#"death");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_static");
  level.player val::set(#"hash_2463ab97c65a943c", "freezecontrols", 1);
  level thread dialogue::function_96171f6d("vox_cp_rkgb_01595_blkv_hisfamilyhasbee_4c");
  level.player note_display::function_97c69304(#"hash_275bada31d40e1ff");
  level.player notifyonplayercommandremove("show_itin", "+actionslot 4");
  level.player notifyonplayercommandremove("show_itin", "+map");
  namespace_353d803e::function_28897188();
  level.player namespace_61e6d095::function_b0bad5ff(undefined, undefined, 1);
  hint_tutorial::function_9f427d88(0);
  level.player notifyonplayercommand("show_itin", "+actionslot 4");
  level.player notifyonplayercommand("show_itin", "+map");
  level.player val::reset(#"hash_2463ab97c65a943c", "freezecontrols");
  level flag::set("flag_poi_records_leverage");
  level flag::set("flag_poi_interrogation_leverage");
  level flag::set("flag_show_family_choice");
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");
  namespace_353d803e::music("4.3_tension_stingers");
  namespace_e77bf565::function_f6eb250d();
}

function function_4562ce85() {
  level.var_914fe418 += 1;

  if(level.var_914fe418 >= 2) {
    level flag::set("flag_influence_success");
  }
}

function function_b30b4469() {
  level flag::set("flag_got_shiv");
  level flag::set("flag_chat_crime");
  level flag::set("flag_chat_general");
  level flag::set("flag_chat_family");
}

function function_e1fa92da() {
  level flag::set("flag_poi_interrogation_file");
  level flag::set("flag_hint_locked_file");
  level flag::set("flag_poi_records_file");
  level.var_1b4de43[level.var_1b4de43.size] = "interrogation";
  level notify(#"ping_map");
}

function file_room() {}

function function_65cd1213() {
  self endon(#"death");
  self endon(#"takedown_begin");
  level thread scene::play("scene_kgb_armory_clerk_dt_setup", "Start_Loop");
  level thread doors::function_f35467ac("armory_door", "targetname");
  level flag::wait_till("flag_start_finding_ways");
  wait 2;
  level thread function_ded6605c();
  guy = self;
  level scene::add_scene_func("scene_kgb_armory_clerk_dt_setup", &function_c88b7d27, "Intro_Front");
  level.var_ae4c3d02 = dialog_tree::new_tree(&function_a99ab850, &function_3e8d1010, undefined, 1, "scene_kgb_armory_clerk_dt_setup");
  level.var_ae4c3d02 dialog_tree::function_b82713b8(struct::get("dialog_armory_front", "targetname"), "Intro_Front", "Choice_Loop", "Outro_Front");
  level.var_ae4c3d02 dialog_tree::add_option(#"hash_1e2a48d585349dad", undefined, "Response_1", "Choice_Loop", undefined, "flag_request_armory", undefined);
  level.var_ae4c3d02 dialog_tree::function_f5d1891("flag_has_paperwork", #"hash_7209f1522432872", undefined, "Response_6", "Choice_Loop", 1, "flag_armory_done", "flag_armory_done", &function_e663b61e);
  level.var_ae4c3d02 dialog_tree::function_bc7c03bf();
  level.var_ae4c3d02 dialog_tree::function_6bbbf87("flag_poi_armory_open", #"hash_7107c9b9a4459a64", undefined, "Response_7", undefined, 1, undefined, undefined, &function_e663b61e);
  level.var_ae4c3d02 dialog_tree::function_6bbbf87("flag_request_armory", #"hash_18d0fbcb98d11b8e", undefined, "Response_2", "Choice_Loop", undefined, "flag_armory_persuade_01_called");
  level.var_ae4c3d02 dialog_tree::function_6bbbf87("flag_armory_persuade_01_called", #"hash_18d0facb98d119db", undefined, "Response_3", "Choice_Loop", undefined, "flag_armory_persuade_02_called");
  level.var_ae4c3d02 dialog_tree::function_6bbbf87("flag_armory_persuade_02_called", #"hash_18d0f9cb98d11828", undefined, "Response_4", "Choice_Loop", undefined, "flag_armory_persuade_03_called", undefined);
  level.var_ae4c3d02 dialog_tree::function_f5d1891("flag_has_cigar", #"hash_18d100cb98d1240d", undefined, "Response_5", "Choice_Loop", 1, "flag_armory_persuade_04_called", "flag_unlock_armory", &function_e663b61e);
  level.var_ae4c3d02 dialog_tree::function_bc7c03bf();
  level.var_ae4c3d02 dialog_tree::add_option(#"hash_17539e81fe5effa1", undefined, undefined, undefined, 1, undefined, "flag_unlock_armory");
  a_flags = ["flag_keycard_acquired", "player_in_restricted_area_data_entry"];
  guy thread function_1cca61db(a_flags, "player_in_restricted_area_data_entry");

  while(isalive(guy) && !level flag::get_any(["flag_keycard_acquired"])) {
    level flag::wait_till_clear_all(["player_in_restricted_area_data_entry", "armory_door_opened"]);
    guy dialog_tree::function_cfa96cee(level.var_ae4c3d02, undefined, undefined, undefined, 88, undefined, undefined);
    level flag::wait_till_clear_all(["player_in_restricted_area_data_entry", "armory_door_opened"]);
    waitframe(1);
  }
}

function enable_armory_quest_dialog_cigar() {
  level flag::wait_till_all(["flag_armory_persuade_03_called", "flag_has_cigar"]);
  level flag::set("enable_armory_quest_dialog_cigar");
}

function function_84d33cbb() {
  level.var_ae4c3d02 dialog_tree::function_bc7c03bf(level.var_fd90324f);
}

function function_c7708dcf() {
  level.var_ae4c3d02 dialog_tree::function_bc7c03bf(level.var_b14551da);
}

function function_b0e70405(a_ents) {
  chair = a_ents[# "chair"];
  guard = a_ents[# "armory_guard"];
  level.var_51b002e1 = [guard, chair];
  paper = a_ents[# "hash_7485e6928c5fcb31"];
  pen = a_ents[# "pen"];
  level.var_2336c4f4 = a_ents;
}

function function_a99ab850(a_ents) {
  level thread function_c9965ab9(1);
}

function function_c88b7d27(a_ents) {
  level.armory_guard thread function_1948ba64("vox_cp_rkgb_01665_rms3_howcanihelpyous_08", "vox_cp_rkgb_01665_rms3_sirwhatcanidofo_e1");
}

function function_1948ba64(line_1, line_2) {
  vo_line = line_1;

  if(math::cointoss()) {
    vo_line = line_2;
  }

  level waittill(#"hash_19e17ffaaac128c7");
  level.armory_guard thread dialogue::queue(vo_line);
}

function function_3e8d1010() {
  self thread function_1948ba64("vox_cp_rkgb_01665_rms3_gooddaysir_af", "vox_cp_rkgb_01665_rms3_sir_5c");
  level thread function_c9965ab9(0);

  if(!level flag::get("flag_poi_armory_guard")) {
    if(!level flag::get_any(["flag_poi_armory_open", "flag_has_paperwork", "flag_has_cigar"]) && level flag::get("flag_request_armory")) {
      level flag::set("flag_poi_armory_guard");
      wait 1;
      level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_theguardwontlet_df");
      level.var_1b4de43[level.var_1b4de43.size] = "data";
      level notify(#"ping_map");
    }
  }
}

function function_e663b61e() {
  if(!level flag::get("flag_poi_armory_open")) {
    level flag::set("flag_unlock_armory");
    level flag::set("flag_poi_armory_open");
    doors::unlock("armory_door", "targetname");
    level.var_1b4de43[level.var_1b4de43.size] = "data";
    level notify(#"ping_map");
    level.var_ae4c3d02 = dialog_tree::new_tree(undefined, undefined, undefined, 1, "scene_kgb_armory_clerk_dt_setup");
    level.var_ae4c3d02 dialog_tree::function_b82713b8(struct::get("dialog_armory_front", "targetname"), "Intro_Front", "Choice_Loop", "Outro_Front");
    level.var_ae4c3d02 dialog_tree::function_b82713b8(struct::get("dialog_armory_side", "targetname"), "Intro_Left", "Choice_Loop", "Outro_Front");
    level.var_ae4c3d02 dialog_tree::add_option(#"hash_1e2a48d585349dad", ["vox_cp_rkgb_01665_rms3_goaheadsirbutpl_c8"], undefined, undefined, 1, undefined, "forever", &function_e663b61e);
    level.var_ae4c3d02 dialog_tree::add_option(#"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "forever");
  }

  level flag::set("armory_door_opened");
  snd::client_msg(#"hash_810337327e9b45d");
}

function function_ded6605c() {
  level endon(#"flag_poi_armory_guy_dead");

  while(true) {
    level flag::wait_till("armory_door_opened");
    doors::open("armory_door", "targetname");
    level flag::wait_till("close_armory_door");
    doors::close("armory_door", "targetname");
    level flag::wait_till_clear("close_armory_door");
    level flag::clear("armory_door_opened");
  }
}

function function_72ad2b01() {
  self waittill(#"death", #"takedown_begin");
  level flag::set("flag_poi_armory_guy_dead");

  if(isDefined(level.var_1b4de43)) {
    level.var_1b4de43[level.var_1b4de43.size] = "data";
    level notify(#"ping_map");
  }
}

function function_682ba64c() {
  guard = spawner::simple_spawn_single("checkpoint", &function_e1286843);
}

function function_e1286843() {
  self thread function_12c4b338();
  self thread function_3cf5b786("flag_player_swap");
  self thread function_7d7d8fd0();
  self endon(#"death");
  self thread function_201b919();
  self battlechatter::function_2ab9360b(0);
  self.propername = # "hash_48b2df68a781d0af";
  goon = spawner::simple_spawn_single("krav_goon", &function_862e8bf9);
  goon thread function_3cf5b786("flag_player_swap");
  level thread scene::play("scene_kgb_frisk_general_guard_dt", "Loop");
  level.var_eede7a6 = self;
  guy = self;
  level flag::wait_till("flag_start_finding_ways");
  wait 1;
  var_e71b15ee = dialog_tree::new_tree(&function_a7cdd04, &function_d47c5461, undefined, 1, "scene_kgb_frisk_general_guard_dt");
  var_e71b15ee dialog_tree::function_b82713b8(struct::get("struct_frisk_start"), "Intro", "Choice_Loop", "Outro");
  var_e71b15ee dialog_tree::add_option(#"hash_42d0527ab5d08788", undefined, "Response2", "Choice_Loop", undefined, "show_pre_exits");
  var_e71b15ee dialog_tree::function_6bbbf87("show_pre_exits", #"hash_6e4b44351840bbd7", undefined, undefined, undefined, 1, "pre_dialog_done");
  var_e71b15ee dialog_tree::function_6bbbf87("show_pre_exits", #"hash_6e4b45351840bd8a", undefined, undefined, undefined, 1, "pre_dialog_done");
  var_92a1f38a = dialog_tree::new_tree(&function_a7cdd04, &function_4e78b39d, undefined, 1, "scene_kgb_frisk_general_guard_dt");
  var_92a1f38a dialog_tree::function_b82713b8(struct::get("struct_frisk_start"), "Intro", "Choice_Loop", undefined);
  var_92a1f38a dialog_tree::add_option(#"hash_708c686d3b0db7b5", undefined, "Response1", "Choice_Loop", undefined, undefined);
  var_92a1f38a dialog_tree::function_f5d1891("has_false_intel", #"hash_708c656d3b0db29c", undefined, "Outro_Success", undefined, 1, "flag_checkpoint_moment_done", undefined);
  var_92a1f38a dialog_tree::function_bc7c03bf();
  var_92a1f38a dialog_tree::add_option(#"hash_6575b40f10d118ae", undefined, "Outro", undefined, 1, undefined, "flag_checkpoint_moment_done");
  a_flags = ["flag_keycard_acquired", "flag_checkpoint_moment_done", "flag_mail_sent", "flag_prisoner_complete", "flag_start_charkov_investigation"];
  guy thread function_1cca61db(a_flags);

  while(isalive(guy) && !level flag::get_any(a_flags)) {
    if(!level flag::get_any(["has_false_intel", "pre_dialog_done"])) {
      guy dialog_tree::function_cfa96cee(var_e71b15ee, undefined, undefined, undefined, 40);
    } else {
      guy dialog_tree::function_cfa96cee(var_92a1f38a, undefined, undefined, undefined, 40);
      level notify(#"hash_5a4d78164a3f7a01");
    }

    if(!level flag::get("flag_checkpoint_moment_done")) {
      wait 1;
    }
  }

  if(level flag::get("flag_keycard_acquired") || level flag::get("flag_prisoner_complete") || level flag::get("flag_start_charkov_investigation")) {
    return;
  }

  level thread function_d41f091c();
}

function function_c682bb41() {
  level endon(#"flag_keycard_acquired");
  level flag::wait_till("has_false_intel");
  self.player_pos[0].var_60a7aecc = "Outro_Sucess";
}

function function_a7cdd04() {
  level thread function_c9965ab9(1);
}

function function_4e78b39d() {
  level thread function_185dfc80();
}

function function_185dfc80() {
  level flag::set("flag_poi_krav_chat");

  if(level flag::get("flag_checkpoint_moment_done")) {
    level thread function_f0b5ab76(12);
    blocker = getent("frisk_blocker", "targetname");
    blocker solid();
    level flag::set("flag_charkov_in_scene");
    level scene::stop("scene_kgb_generals_office");
    level thread scene::play("scene_kgb_precheckpoint_general", [level.general]);
    level flag::set("flag_start_checkpoint_frisk");
    return;
  }

  level thread function_c9965ab9(0);
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
}

function function_f0b5ab76(time) {
  wait time;
  level thread function_c9965ab9(0);
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
}

function function_d47c5461() {
  level flag::set("flag_poi_krav_chat");
  level thread function_c9965ab9(0);
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
  level thread function_752fba39("vox_cp_rkgb_01650_blkv_illbeexposedsoo_81");
}

function function_752fba39(line, time = 2) {
  wait time;
  level thread dialogue::function_96171f6d(line);
}

function function_f9f3811c() {
  level.var_eede7a6 dialogue::queue("vox_cp_rkgb_01680_rms1_howcanihelpyouc_61");
}

function function_d41f091c() {
  level endon(#"flag_player_swap");
  blocker = getent("frisk_blocker", "targetname");
  blocker solid();
  struct = struct::get("obj_checkpoint", "targetname");
  wait 9;
  level flag::wait_till("flag_start_checkpoint_frisk");
  level flag::set("flag_poi_krav_wait");
  level flag::set("flag_charkov_in_scene");
  doors::close("admin_door", "targetname");
  doors::function_f35467ac("admin_door", "targetname");
  level thread function_c9965ab9(0);
  level thread swipe_card();
  level scene::add_scene_func("scene_kgb_frisk_general", &function_69897605);
  level scene::stop("scene_kgb_frisk_general_guard_dt");
  level scene::play("scene_kgb_frisk_general", "Frisk");
  level thread scene::play("scene_kgb_frisk_general", "Loop");
  level flag::set("flag_poi_office_charkov_front");
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
}

function function_69897605(a_ents) {
  level.player endon(#"death");
  level flag::wait_till("flag_player_swap");

  if(isDefined(a_ents[# "checkpoint"])) {
    a_ents[# "checkpoint"] delete();
  }

  if(isDefined(a_ents[# "general"])) {
    a_ents[# "general"] delete();
  }

  if(isDefined(a_ents[# "krav_goon"])) {
    a_ents[# "krav_goon"] delete();
  }

  if(isDefined(a_ents[# "lighter"])) {
    a_ents[# "lighter"] delete();
  }

  if(isDefined(a_ents[# "cigar"])) {
    a_ents[# "cigar"] delete();
  }

  if(isDefined(a_ents[# "hash_2199ca8e0dd77eeb"])) {
    a_ents[# "hash_2199ca8e0dd77eeb"] delete();
  }

  if(isDefined(a_ents[# "prop 1"])) {
    a_ents[# "prop 1"] delete();
  }
}

function swipe_card() {
  wait 31;
  level thread function_2410cb8e();
  struct = struct::get("swipe_card", "targetname");
  level thread function_8703e51a(struct);
  level flag::set("flag_poi_krav_opportunity");
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_12aeefa638922fae", 64, undefined, &function_f17f515c, undefined, 96, undefined, 0, 1, 0);
  struct prompts::set_objective(#"hash_5e6b451a3d52cb04");
  level flag::wait_till_any(["flag_frisk_key_swiped", "flag_keycard_acquired"]);
  struct util::remove_cursor_hint();
  waitframe(1);

  if(level flag::get("flag_frisk_key_swiped")) {
    level thread function_c9965ab9(1);
    level.player namespace_e77bf565::function_f954feae(#"hash_11484ae12865f8c9");

    if(level flag::get("flag_back_checkpoint")) {
      level scene::play("scene_kgb_frisk_general_player_grab", "Back_Grab");
    } else {
      level scene::play("scene_kgb_frisk_general_player_grab", "Front_Grab");
    }

    level flag::set("flag_keycard_acquired");
    level thread function_c9965ab9(0);
  }
}

function function_2410cb8e() {
  wait 19;
  level flag::set("flag_allow_swipe");
}

function function_f17f515c(prompt_struct) {
  if(!level flag::get("flag_allow_swipe")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_oncetheyapprehe_51");
    return;
  }

  level flag::set("flag_frisk_key_swiped");
}

function disable_mental_map() {
  level flag::set("flag_in_dialogue");
}

function function_b5c2e9b8() {
  level flag::clear("flag_in_dialogue");
}

function function_9cdcfd88() {
  level thread function_bc6f8a15();
  level thread function_3fb458b8();
  var_e7ebda92 = getEntArray("charkov_blinds_closed", "targetname");

  foreach(blind in var_e7ebda92) {
    blind hide();
  }
}

function function_bc6f8a15() {
  var_6c4f3cf2 = struct::get_array("cigar", "targetname");

  foreach(cigar in var_6c4f3cf2) {
    cigar thread function_1a2c72f7();
  }
}

function function_1a2c72f7() {
  var_4ac1f1f = util::spawn_anim_model("p8_nt4_soviet_cigar_single", self.origin, self.angles);
  tag = self;
  tag util::create_cursor_hint(undefined, (0, 0, 2), #"hash_263df1cb6b8d9de6", 48, undefined, &function_a723656a, undefined, undefined, undefined, 1, 1);
  level flag::wait_till_any(["flag_has_cigar", "flag_keycard_acquired"]);
  waitframe(1);
  tag util::remove_cursor_hint();
  var_4ac1f1f delete();
}

function function_a723656a(prompt_struct) {
  level flag::set("flag_has_cigar");
  level flag::set("flag_poi_office_cigar");
  level flag::set("flag_poi_mail_cigar");

  if(!level flag::get("flag_armory_persuade_03_called")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_thearmoryguardh_68");
  }

  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level notify(#"ping_map");
  snd::client_msg(#"hash_6c7e5d8f2665fc0c");
}

function function_3fb458b8() {
  level flag::wait_till("flag_start_charkov_investigation");
  level.general.var_c681e4c1 = 1;
  level.general.ignoreall = 1;
  level flag::set("flag_charkov_in_scene");
  level scene::stop("scene_kgb_generals_office");
  hat = getent("charkov_hat", "targetname");
  hat.origin = level.general gettagorigin("j_helmet");
  hat.angles = level.general gettagangles("j_helmet");
  hat linkto(level.general, "j_helmet");
  hat hide();
  chair = getent("charkov_chair", "targetname");
  chair delete();
  waitframe(1);
  level thread scene::play("scene_kgb_poison_tea", "Intro_Loop");
  struct = struct::get("poison_chat", "targetname");
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_2700aa498f22c978", 40, undefined);
  struct prompts::set_objective("poison_tea");
  struct waittill(#"trigger");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  var_e7ebda92 = getEntArray("charkov_blinds_closed", "targetname");

  foreach(blind in var_e7ebda92) {
    blind show();
  }

  var_fa02a280 = getEntArray("charkov_blinds_open", "targetname");

  foreach(blind in var_fa02a280) {
    blind delete();
  }

  level flag::set("player_sat_in_charkovs_office");
  level thread function_c9965ab9(1);
  snd::client_msg(#"hash_9db8f264f5d0a4c");
  level thread scene::play("scene_kgb_poison_tea_player", "Player_Sit");
  level scene::play("scene_kgb_poison_tea", "DT_Intro");
  level thread scene::play("scene_kgb_poison_door", "DT_Intro", level.general_door);
  level thread scene::play("scene_kgb_poison_tea", "DT_Intro_Loop");
  level thread scene::play("scene_kgb_secretary_dt", "Front_Idle");
  wait 1;
  level thread function_3e0c476c("poison_right", 1);
  level thread function_3e0c476c("poison_left", 0);
  level flag::wait_till("flag_start_tea_roulette");
  level.general stopsounds();
  level scene::play("scene_kgb_poison_tea", "DT_Greeting");
  level thread scene::play("scene_kgb_poison_tea", "DT_Choice_1_Loop");
  function_7593f065();
  function_84770868();

  if(!level flag::get("flag_player_drink")) {
    function_4e3dfbd0();
  }

  if(!level flag::get("flag_player_drink")) {
    function_4e3dfbd0();
  }

  struct util::remove_cursor_hint();

  if(!level flag::get("flag_player_drink")) {
    function_6336c33f();
  }
}

function function_3e0c476c(targetname, b_right) {
  struct = struct::get(b_right, "targetname");
  tag = spawn("script_model", struct.origin);
  tag setModel("tag_origin");
  tag.script_noteworthy = b_right;
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_69b474496c3a9512", 128, undefined, &function_d09d1a07, undefined, undefined, 10, 0, 1);
  level flag::wait_till("flag_picked_poison");
  tag util::remove_cursor_hint();
  thread namespace_353d803e::function_ecda5886();
  level flag::set("flag_start_tea_roulette");
}

function function_7593f065() {
  level flag::set("flag_charkov_looking");

  if(level.var_c778a7d3 == "poison_right") {
    level thread scene::play("scene_kgb_poison_tea_player", "Pick_Right");
    level scene::play("scene_kgb_poison_tea", "Pick_Right");
    level.var_76a74dd5 = 1;
    function_8839afce("right");
  } else {
    level thread scene::play("scene_kgb_poison_tea_player", "Pick_Left");
    level scene::play("scene_kgb_poison_tea", "Pick_Left");
    level.var_76a74dd5 = 0;
    function_8839afce("left");
  }

  level thread scene::play("scene_kgb_poison_tea", "DT_Choice_2_Loop");
  level thread scene::play("scene_kgb_poison_tea_player", "Player_Sit_Loop_2");
}

function function_84770868() {
  level flag::set("flag_charkov_looking");
  level.var_22af6992 = dialog_tree::new_tree(&function_70276075, undefined, 1, 1);
  level.var_22af6992 dialog_tree::add_option(#"hash_502bd763ab64c62c", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Map_Response_1");
  level.var_22af6992 dialog_tree::add_option(#"hash_502bda63ab64cb45", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Map_Response_2");
  level.var_22af6992 dialog_tree::add_option(#"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract");
  level.var_22af6992 dialog_tree::add_option(#"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949);
  level.var_c08dee2d = dialog_tree::new_tree(&function_70276075, undefined, 1, 1);
  level.var_c08dee2d dialog_tree::add_option(#"hash_2740da147527d173", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Wife_Response_1");
  level.var_c08dee2d dialog_tree::add_option(#"hash_2740db147527d326", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "Wife_Response_2");
  level.var_c08dee2d dialog_tree::add_option(#"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract");
  level.var_c08dee2d dialog_tree::add_option(#"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949);
  level.var_73955179 = dialog_tree::new_tree(&function_70276075, undefined, 1, 1);
  level.var_73955179 dialog_tree::add_option(#"hash_3d385886e4c2e706", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "War_Response_1");
  level.var_73955179 dialog_tree::add_option(#"hash_3d385786e4c2e553", undefined, undefined, undefined, 1, "flag_chose_distract", "flag_chose_distract", &function_27304cc, "War_Response_2");
  level.var_73955179 dialog_tree::add_option(#"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract");
  level.var_73955179 dialog_tree::add_option(#"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949);
  level.var_e1220a0d = dialog_tree::new_tree(&function_70276075, undefined, 1, 1);
  level.var_e1220a0d dialog_tree::add_option(#"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, "flag_chose_distract");
  level.var_e1220a0d dialog_tree::add_option(#"hash_63e93fbb039d6cd1", undefined, undefined, undefined, 1, "flag_player_drink", "flag_player_drink", &function_b5ce1949);
  level thread function_6ef38bf("map_distract", level.var_22af6992);
  level thread function_6ef38bf("family_distract", level.var_c08dee2d);
  level thread function_6ef38bf("war_distract", level.var_73955179);
  level thread function_6ef38bf("poison_swap", level.var_e1220a0d);
  level flag::wait_till("flag_chose_distract");
  waitframe(1);

  if(level flag::get("flag_player_drink")) {
    return;
  }

  level flag::clear("flag_charkov_looking");
  level scene::play("scene_kgb_poison_tea", level.var_63df18e3);
  level flag::set("flag_charkov_looking");
  level thread scene::play("scene_kgb_poison_tea", "DT_Choice_2_Loop");
}

function function_27304cc(var_63df18e3) {
  level.var_63df18e3 = var_63df18e3;
}

function function_70276075() {}

function function_d45e658e() {}

function function_6ef38bf(var_bc2b55eb, var_162ecf2c) {
  if(level flag::get("flag_player_drink")) {
    return;
  }

  struct = struct::get(var_bc2b55eb, "targetname");
  tag = spawn("script_model", struct.origin);
  tag setModel("tag_origin");
  tag.var_162ecf2c = var_162ecf2c;
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), undefined, 256, undefined, &function_aa840d2b, undefined, undefined, 10, 0, 1, 0, &function_bc457fe3);
}

function function_aa840d2b(prompt) {
  self thread function_ee04db37();
}

function function_ee04db37() {
  wait 0.25;
  level.var_136bf433 = self.var_162ecf2c dialog_tree::run();
}

function function_4e3dfbd0() {
  level flag::clear("flag_chose_distract");

  if(level flag::get("flag_player_drink")) {
    return;
  }

  waitframe(1);
  level flag::wait_till("flag_chose_distract");
  waitframe(1);

  if(level flag::get("flag_player_drink")) {
    return;
  }

  level flag::clear("flag_charkov_looking");
  level scene::play("scene_kgb_poison_tea", level.var_63df18e3);
  level flag::set("flag_charkov_looking");
  level thread scene::play("scene_kgb_poison_tea", "DT_Choice_2_Loop");
}

function function_bc457fe3(prompt) {
  return !level flag::get("dialog_tree_active") && !level flag::get("flag_player_drink") && !level flag::get("flag_chose_distract");
}

function function_8839afce(pick) {
  level.var_18430051 = getent("cup_left", "targetname");
  level.var_e471caeb = getent("cup_right", "targetname");
  level.var_18430051.poison = 0;
  level.var_e471caeb.poison = 0;

  if(pick == "right") {
    level flag::set("charkov_has_cup_1");
  }

  if(level.var_c778a7d3 == "poison_right") {
    level.var_e471caeb.poison = 1;
  } else {
    level.var_18430051.poison = 1;
  }

  function_19a8bc44(pick);
  struct = struct::get("poison_swap", "targetname");
  tag = spawn("script_model", struct.origin);
  tag setModel("tag_origin");
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_2c041cbe0390b7e9", 128, undefined, &function_d94f43d, undefined, undefined, 50, 0, 1, 0, &function_56b67116);
  level thread function_cc8b4145();
}

function function_cc8b4145() {
  level endon(#"hash_69957c24329df643");
  flag = "flag_charkov_turned";
  level flag::set(flag);

  while(true) {
    level waittill(#"hash_305ab0b031ad6a1");

    if(level flag::get(flag)) {
      level flag::clear(flag);
      continue;
    }

    level flag::set(flag);
  }
}

function function_56b67116(prompt) {
  return !level flag::get("flag_charkov_looking") && !level flag::get("flag_charkov_turned");
}

function function_19a8bc44(var_4d5474d1) {
  if(var_4d5474d1 == "left") {
    level.var_62fb0005 = level.var_18430051;
    level.var_18430051 hide();
    level.var_e471caeb show();
    return;
  }

  level.var_62fb0005 = level.var_e471caeb;
  level.var_18430051 show();
  level.var_e471caeb hide();
}

function function_6336c33f() {
  if(level.var_76a74dd5) {
    level thread scene::play("scene_kgb_poison_tea_player", "DT_Toast");
    level scene::play("scene_kgb_poison_tea", "DT_Toast");
  } else {
    level thread scene::play("scene_kgb_poison_tea_player", "DT_Toast");
    level scene::play("scene_kgb_poison_tea", "DT_Toast_Alt");
  }

  level thread scene::play("scene_kgb_poison_tea_player", "DT_Choice_5_Loop");
  level thread scene::play("scene_kgb_poison_tea", "DT_Choice_5_Loop");
  var_bddef49 = dialog_tree::new_tree(undefined, undefined, 1, 1, "scene_kgb_poison_tea");
  var_bddef49 dialog_tree::add_option(#"hash_71d14858321ea9dd", undefined, undefined, undefined, 1);
  var_bddef49 dialog_tree::add_option(#"hash_71d14758321ea82a", undefined, undefined, undefined, 1);
  var_bddef49 dialog_tree::add_option(#"hash_71d14658321ea677", undefined, undefined, undefined, 1);
  choice = var_bddef49 dialog_tree::run();
  level endon(#"hash_69957c24329df643");

  if(!level.var_76a74dd5) {
    level scene::play("scene_kgb_poison_tea", "Confront");
  } else {
    level scene::play("scene_kgb_poison_tea", "Confront_Alt");
  }

  level thread scene::play("scene_kgb_poison_tea", "Confront_Loop");
  var_bddef49 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_bddef49 dialog_tree::add_option(#"hash_499e2e31cb265242", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b, var_bddef49);
  var_bddef49 dialog_tree::add_option(#"hash_529f15be9602ad50", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b, var_bddef49);
  var_bddef49 dialog_tree::add_option(#"hash_23d756657cba7327", undefined, undefined, undefined, 1, undefined, undefined, &function_2aa3292b, var_bddef49);
  wait 1;
  var_bddef49 dialog_tree::run(undefined, undefined, 8);
}

function function_b5ce1949() {
  level flag::set("flag_player_drink");
  level thread function_6336c33f();
}

function function_2aa3292b(var_bddef49) {
  level flag::set("flag_player_drink");

  if(level.var_62fb0005.poison) {
    level thread scene::play("scene_kgb_poison_tea_player", "DT_Player_Dies");
    level thread scene::play("scene_kgb_poison_tea", "DT_Player_Dies");
    namespace_353d803e::function_b93da28b();
    wait 2;
    util::missionfailedwrapper(#"hash_72b39430dc0e8b49", #"hash_73348c6b5dccf418");
    namespace_353d803e::function_45192a6c();
    return;
  }

  level.var_1b4de43[level.var_1b4de43.size] = "office";
  level notify(#"ping_map");
  var_bddef49 dialog_tree::function_bfcc8f29();
  level flag::set("flag_poi_office_charkov_dead");
  level scene::stop("scene_kgb_secretary_dt");
  pen = getent("secretary_pen", "targetname");

  if(isDefined(pen)) {
    pen delete();
  }

  level thread function_ce588e51();

  if(level.var_76a74dd5) {
    level thread scene::play("scene_kgb_poison_tea", "DT_General_Dies");
  } else {
    level thread scene::play("scene_kgb_poison_tea", "DT_General_Dies_Alt");
  }

  level.general notsolid();
  wait 4;
  namespace_e77bf565::function_e90c279f();
  snd::client_msg(#"hash_1d5a01df795ac3d2");
  level thread scene::play("scene_kgb_poison_tea", "Player_Standup");
  chair_clip = getent("poison_chair_blocker", "targetname");
  chair_clip.origin += (0, 0, -256);
  level scene::play("scene_kgb_poison_tea_player", "Player_Standup");
  namespace_e77bf565::function_f6eb250d();
  level flag::clear("flag_charkov_in_scene");
  level scene::stop("scene_kgb_poison_door");
  level.general_door unlink();
  doors::unlock_all(0);
  level thread function_c9965ab9(0);
  level.player namespace_e77bf565::function_f954feae(#"hash_165afba597307403");
  level flag::set("flag_keycard_acquired");
}

function function_ce588e51() {
  hat = getent("charkov_hat", "targetname");
  hat unlink();
  wait 6;

  if(isDefined(level.general.hatmodel)) {
    level.general detach(level.general.hatmodel);
  }

  hat show();
}

function function_8703e51a(struct) {
  objectives::function_4eb5c04a(#"hash_5e6b451a3d52cb04", struct.origin);
  objectives_ui::function_49dec5b(#"hash_5e6b451a3d52cb04", undefined, #"hash_2eb5dbaa39d9d66a");
  level flag::set("bunker_key_placed_in_world");
  level flag::wait_till("flag_keycard_acquired");
  objectives::complete(#"hash_5e6b451a3d52cb04");
}

function function_f9bc244e(prompt) {
  level.var_48be2c6f = 1;

  if(level.var_2949fa57) {
    level scene::play("scene_kgb_poison_tea", "door_open");
  } else {
    level scene::play("scene_kgb_poison_tea", "door_close");
  }

  level.var_2949fa57 = !level.var_2949fa57;
  level.var_48be2c6f = 0;
}

function function_5ea556b8(prompt) {
  return !level.var_48be2c6f && level.var_2949fa57;
}

function function_f34d945b(prompt) {
  return !level.var_48be2c6f && !level.var_2949fa57;
}

function function_d94f43d(prompt) {
  if(level.var_62fb0005 == level.var_18430051) {
    function_19a8bc44("right");
  } else {
    function_19a8bc44("left");
  }

  level flag::set("flag_charkov_looking");

  if(!level.var_76a74dd5) {
    level thread scene::play("scene_kgb_poison_tea_player", "Cup_Swap");
    level thread scene::play("scene_kgb_poison_tea", "Cup_Swap");
  } else {
    level thread scene::play("scene_kgb_poison_tea_player", "Cup_Swap");
    level thread scene::play("scene_kgb_poison_tea", "Cup_Swap_Alt");
  }

  thread namespace_353d803e::function_f25a5965();
}

function function_d09d1a07(prompt_struct) {
  level flag::set("flag_picked_poison");
  level.var_c778a7d3 = self.script_noteworthy;

  if(level.var_c778a7d3 != "poison_right") {
    level thread scene::play("scene_kgb_poison_tea", "Poison_Tea_R");
    level thread scene::play("scene_kgb_poison_tea_player", "Poison_Tea_R");
  } else {
    level thread scene::play("scene_kgb_poison_tea", "Poison_Tea_L");
    level thread scene::play("scene_kgb_poison_tea_player", "Poison_Tea_L");
  }

  wait 5;
}

function function_87e35005(prompt_struct) {
  level flag::set("flag_keycard_acquired");
}

function function_5b602e4f(player, var_7b20e52b) {
  if(isDefined(self.targetname) && self.targetname == "prisoner") {
    return false;
  }

  if(self.ignoreall) {
    return false;
  }

  angles = self gettagangles("tag_eye");
  v_forward = anglesToForward(angles);
  v_loc = player getEye();
  v_dir = vectornormalize(v_loc - self getEye());
  dp = vectordot(v_forward, v_dir);

  if(dp > -0.1) {
    if(is_true(var_7b20e52b)) {
      v_loc = player.origin + (0, 0, 48);

      if(sighttracepassed(self getEye(), v_loc, 0, self)) {
        dist = distance2dsquared(self getEye(), v_loc);

        if(dist < 1960000) {
          return true;
        }
      }
    } else {
      return true;
    }
  }

  return false;
}

function function_2008b07b() {
  level.player endon(#"death");
  level endon(#"flag_player_swap");

  while(!level flag::get("flag_player_swap")) {
    while(!level.player function_70c7a9d0()) {
      waitframe(1);
    }

    if(level.player function_70c7a9d0()) {
      level flag::set("player_doing_stealth_action");
    }

    while(level.player function_70c7a9d0()) {
      waitframe(1);
    }

    var_210a8489 = getactorarray();

    foreach(ai in var_210a8489) {
      if(!isalive(ai)) {
        continue;
      }

      if(isDefined(ai.stealth) && isDefined(ai.stealth.threat_sight_state)) {
        ai stealth_threat_sight::threat_sight_set_state_parameters();
      }
    }

    level flag::clear("player_doing_stealth_action");
    waitframe(1);
  }
}

function function_70c7a9d0() {
  return self flag::get_any(["body_shield_active", "lockpicking", "takedown_active"]) || self namespace_5f6e61d9::function_cad84e26();
}

function function_50127970() {
  waitframe(1);
}

function function_1cca61db(flag_name, var_656138f9) {
  self endon(#"death");
  level flag::wait_till_any(flag_name);
  self notify(#"dialog_wait_cancel");
  self util::remove_cursor_hint();

  if(isDefined(var_656138f9)) {
    level flag::wait_till_clear(var_656138f9);
    function_1cca61db(flag_name);
  }
}

function function_c76cf14c(flag_name) {
  level flag::wait_till(flag_name);

  if(isDefined(self)) {
    self util::remove_cursor_hint();
  }
}

function function_9aff7e5c() {
  self waittill(#"death");
  self notify(#"dialog_wait_cancel");
}

function function_e7fcf8ef() {
  level thread spare_card();
  level thread function_57a55197();
  struct = struct::get("struct_computer_hack", "targetname");
  level.var_9fe9f285 = struct;
  level scene::init("scene_kgb_reprogram_computer");
  level.var_9fe9f285 util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1d1e69534e69a425", 32, undefined, &function_6789cd2e);
  level flag::wait_till_any(["flag_hacked_done", "flag_keycard_acquired", "flag_prisoner_complete_call"]);
  level.var_9fe9f285 util::remove_cursor_hint();
}

function function_6789cd2e(prompt_struct) {
  level thread function_c9965ab9(1);
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  snd::client_msg(#"hash_134c64c3689b26d8");
  level scene::play("scene_kgb_reprogram_computer", "Enter");
  level thread scene::play("scene_kgb_reprogram_computer", "Loop");
  function_76fddb1d();
  var_bddef49 = dialog_tree::new_tree(undefined, &function_8392c914, 1, 1);
  var_bddef49 dialog_tree::function_6bb91351(1);
  var_bddef49 dialog_tree::add_option(#"hash_5a27b68cde8bd03d", undefined, undefined, undefined, undefined, undefined, "flag_keycard_acquired", &function_7e5b34f7);
  var_bddef49 dialog_tree::add_option(#"hash_310a3efc355e1ffb", undefined, undefined, undefined, 1, undefined, "flag_hacked_done", undefined);
  var_bddef49 dialog_tree::run();
  namespace_6f1d35e1::function_b2911127(0);
  level thread function_648033a2();
  var_bddef49 = undefined;
  namespace_e77bf565::function_f6eb250d();
}

function function_76fddb1d() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_1534c55e685d5b11");
  namespace_6f1d35e1::function_5d2e6f6a(1);
  thread namespace_353d803e::function_e45cc0e3();
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 5);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_89075091();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 5);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 5);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_89075091();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(6, 5);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_1849b51();
}

function function_736d0537() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_2a67834942ac9fe7");
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_89075091();
  wait 1.7;
  thread namespace_353d803e::function_a36d53c1();
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  wait 0.7;
}

function function_1e568a52() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_28aa991d9ef9b670");
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_c910d243();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(5, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_89075091();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(7, 75);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_c910d243();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(8, 20);
  level waittill(#"typing_complete");
}

function function_48cb9056() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_5f87c1db1cef3dde");
  namespace_6f1d35e1::function_5d2e6f6a(1);
  thread namespace_353d803e::function_b3167dc7();
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_763b1a5f();
  thread namespace_353d803e::function_4c22f066();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_4c22f066();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_4c22f066();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_4c22f066();
  wait 1.7;
  namespace_6f1d35e1::function_4951a2c8(7, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_4c22f066();
  wait 1.7;
  thread namespace_353d803e::function_6c74df12();
  namespace_6f1d35e1::function_4951a2c8(8, 20);
  level waittill(#"typing_complete");
}

function function_648033a2() {
  if(level flag::get("flag_keycard_acquired")) {
    snd::client_msg(#"hash_13de9c8b5a620fc3");
    level scene::play("scene_kgb_reprogram_computer", "Exit_Key");
  } else {
    snd::client_msg(#"hash_326d7039d6caf74");
    level scene::play("scene_kgb_reprogram_computer", "Exit");
  }

  level flag::set("flag_poi_data_computer");
  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level thread function_c9965ab9(0);
  level notify(#"ping_map");
}

function function_a51fea1b() {}

function function_8392c914() {
  if(level flag::get("flag_keycard_acquired")) {
    return;
  }

  level.var_9fe9f285 util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1d1e69534e69a425", 32, undefined, &function_6789cd2e);
}

function function_7e5b34f7() {
  function_a9168808();
}

function function_a9168808() {
  if(level flag::get("flag_got_spare_card")) {
    function_1e568a52();
    level thread savegame::checkpoint_save(1);
    level scene::play("scene_kgb_reprogram_computer", "Insert");
    level thread scene::play("scene_kgb_reprogram_computer", "Loop");
    function_48cb9056();
    level.player namespace_e77bf565::function_f954feae(#"hash_2423208923ced64e");
    level flag::set("flag_keycard_acquired");
    snd::client_msg(#"hash_8fb789398a122bf");
    return;
  }

  function_736d0537();
  level flag::set("flag_poi_data_need_popov");
  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level notify(#"ping_map");

  if(level flag::get("flag_popov_1") && level flag::get("flag_popov_2")) {
    level flag::set("flag_poi_data_need_various");
  }
}

function function_8dccd5df() {
  level thread function_875438fc();
}

function function_875438fc() {
  namespace_6f1d35e1::function_487b4340(#"hash_40151610fdd399a2");
  namespace_6f1d35e1::function_5d2e6f6a(2);
  namespace_6f1d35e1::function_4951a2c8(1, 40);
}

function spare_card() {
  tag = getent("armory_spare_card", "targetname");
  level scene::init("scene_kgb_armory_keycard");
  tag util::create_cursor_hint("tag_origin", (0, 0, 0), #"hash_460325cda2b5dc30", 48, undefined, &function_c7de39b1, undefined, undefined, undefined, 0, 0);
  tag thread function_1416f12d();
  a_flags = ["flag_got_spare_card", "flag_keycard_acquired"];
  level flag::wait_till_any(a_flags);
  tag util::remove_cursor_hint();
  tag delete();
}

function function_1416f12d() {
  level endon(#"flag_got_spare_card");
  level endon(#"flag_keycard_acquired");
  self endon(#"deleted");
  level flag::wait_till("flag_poi_armory_open");
  wait 1;

  if(isDefined(self)) {
    self prompts::set_objective("key_reprogram");
  }
}

function function_c7de39b1(prompt_struct) {
  level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_indataentryicou_d7");
  namespace_353d803e::music("4.3_tension_stingers");
  snd::client_msg(#"hash_2ef69949c5586784");
  level scene::play("scene_kgb_armory_keycard");
  level flag::set("flag_got_spare_card");
  level flag::set("flag_poi_armory_done");
  level flag::set("flag_poi_swap_have");
  level flag::set("flag_poi_data_card");
  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level notify(#"ping_map");
}

function function_57a55197() {
  struct = struct::get("armory_button", "targetname");
  a_flags = ["flag_unlock_armory", "flag_keycard_acquired"];
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_6b548b89534b739b", 48, undefined, &armory_button, undefined, undefined, undefined, undefined, undefined, 0, &function_ad2e6f60);
  struct thread function_2fc620ae();
  level flag::wait_till_any(a_flags);
  struct util::remove_cursor_hint();
}

function function_2fc620ae() {
  level endon(#"flag_keycard_acquired");
  level endon(#"flag_got_spare_card");
  level flag::wait_till("flag_poi_armory_guy_dead");
  wait 1;

  if(isDefined(self)) {
    self prompts::set_objective("key_reprogram");
  }
}

function function_ad2e6f60(prompt) {
  return level flag::get("player_in_restricted_area_data_entry") && level flag::get("flag_poi_armory_guy_dead");
}

function armory_button(prompt_struct) {
  snd::client_msg(#"hash_2520e050afad6b28");
  level flag::set("flag_unlock_armory");
  level flag::set("flag_poi_armory_open");
  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level notify(#"ping_map");
  doors::unlock("armory_door", "targetname", 1);
}

function data_entry_guard() {
  guy = spawner::simple_spawn_single("data_entry_guard", &function_862e8bf9);
  guy thread function_3cf5b786("flag_player_swap");
  guy endon(#"death");
  level flag::wait_till("flag_data_entry_break");
  level thread scene::play("data_entry_break", "Data_Entry", guy);
}

function function_c1a40cd6() {
  paper = struct::get("paperwork", "targetname");
  paper thread function_e0ecf6aa();
  guy = spawner::simple_spawn_single("war_room_guard", &function_862e8bf9);
  guy thread function_3cf5b786("flag_player_swap");
  guy endon(#"death");
  level flag::wait_till_any(["flag_has_paperwork", "flag_escape_office"]);
  guy namespace_979752dc::function_bc54026c("cover_blown");
  guy namespace_979752dc::function_bc54026c("combat");
  guy namespace_979752dc::set_event_override("investigate", &function_ee841d37);
  guy namespace_979752dc::set_event_override("cover_blown", &function_c51d7f49);
  guy namespace_979752dc::set_event_override("combat", &function_c503e7c4);
  guy thread function_eb58056d();
  guy clientfield::set("set_flashlight_fx", 1);
  guy flashlight::function_7c2f623b();
  guy flashlight::function_65e5c8c8(1);
  level scene::play("war_room_flashlight_look", guy);
  guy stopanimscripted();
  guy namespace_979752dc::function_bc54026c("investigate");
  guy namespace_979752dc::function_bc54026c("cover_blown");
  guy namespace_979752dc::function_bc54026c("combat");
  guy function_671753a4();
  guy flashlight::light_off();
  guy flashlight::function_bfffb3fe();
  node = getnode(guy.target, "targetname");
  guy thread spawner::go_to_node(node);
}

function function_ee841d37(event) {
  return true;
}

function function_c51d7f49(event) {
  return true;
}

function function_c503e7c4(event) {
  return false;
}

function function_eb58056d() {
  self endon(#"death");
  guy = self;
  guy clientfield::set("set_flashlight_fx", 1);
  guy flashlight::function_7c2f623b();
  guy flashlight::function_65e5c8c8(1);
  guy waittill(#"detach");
  guy flashlight::light_off();
  guy flashlight::function_bfffb3fe();
}

function function_1c634e1d() {
  self endon(#"death");
  self waittill(#"attach");
  self clientfield::set("set_flashlight_fx", 1);
  self flashlight::function_7c2f623b();
  self flashlight::function_65e5c8c8(1);
  self function_9d4bbfa9();
  self flashlight::light_off();
  self flashlight::function_bfffb3fe();
}

function function_9d4bbfa9() {
  self endon(#"detach");
  self endon(#"death");
  level flag::wait_till("stealth_spotted");
}

function function_e0ecf6aa() {
  struct = self;
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_60ccfb5dfa852713", 64, undefined, &function_2fb03191);
  level flag::wait_till_any(["flag_has_paperwork", "flag_keycard_acquired"]);
  level flag::set("flag_poi_armory_paperwork");
  level.var_1b4de43[level.var_1b4de43.size] = "data";
  level notify(#"ping_map");
  struct util::remove_cursor_hint();
}

function function_2fb03191(prompt) {
  namespace_353d803e::music("4.3_tension_stingers");

  if(!level flag::get("flag_request_armory")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_thesewillgiveme_1f");
  }

  level flag::set("flag_has_paperwork");
  snd::client_msg(#"hash_2582bdd148041a03");
}

function function_aa7e876() {
  level flag::wait_till("flag_start_finding_ways");
}

function function_7f81c6e4() {
  level flag::wait_till("level_is_go");
  wait 1;
  tvs = getEntArray("security_tv_on", "targetname");

  foreach(monitor in tvs) {
    monitor thread function_6d4b662c();
  }

  wait 3;
  tvs = undefined;
}

function function_6d4b662c() {
  min_time = 0.25;
  max_time = 1.75;
  wait randomfloatrange(min_time, max_time);
  self setModel("p9_rus_security_monitor_01_off");
  wait 0.5;
  self setModel("p9_rus_security_monitor_01_on");
}

function function_799b3854() {
  level dialogue::function_96171f6d("vox_cp_rkgb_02000_blkv_nowtoheadtotheb_d6");
  level flag::wait_till_any(["flag_rv_bread_3", "flag_rv_bread_4"]);
  level dialogue::function_96171f6d("vox_cp_rkgb_02000_blkv_adlersteamwilln_a7");
  function_ebf2af84();
  wait 1;
  level dialogue::function_96171f6d("vox_cp_rkgb_02000_blkv_thisisbelikovin_a4");
  wait 0.5;
  level.player playrumbleonentity("anim_light");
  level flag::set("flag_allow_boiler_door");
}

function function_ebf2af84() {
  weapon = getweapon(#"hash_29f63236a13ced42");
  level thread hint_tutorial::function_4c2d4fc4(#"hash_39f8c689d87e79ca", undefined, undefined, undefined, 2);
  level.player notifyonplayercommand("radio_guards", "+smoke");
  level.player notifyonplayercommand("radio_guards", "+equip_toggle_throw");
  level.player waittill(#"radio_guards");
  level.player notifyonplayercommandremove("radio_guards", "+smoke");
  level.player notifyonplayercommandremove("radio_guards", "+equip_toggle_throw");
  level hint_tutorial::function_9f427d88();
  level.player giveweapon(weapon);
  level.player switchtoweaponimmediate(weapon, 1);
  level.player playrumbleonentity("anim_light");
  level.player gestures::function_b6cc48ed("ges_t9_radio_call_kgb", undefined, 1, 0, undefined, 0, 1);
}

function function_af2de12b(start = 1, dof = 2) {
  if(start) {
    level.player thread clientfield::set_to_player("set_fov", 2);
    level.player thread clientfield::set_to_player("set_dof", dof);
    return;
  }

  level.player thread clientfield::set_to_player("set_fov", 1);
  level.player thread clientfield::set_to_player("set_dof", 1);
}

function function_680c8cbe(start, dof) {
  level thread function_af2de12b(1);

  if(isai(self) && isDefined(self.stealth)) {
    self thread ai::look_at(level.player getplayercamerapos());
  }
}

function function_f9603eed() {
  function_680c8cbe(1, 3);
}

function function_589d3c34() {
  level thread function_af2de12b(0);

  if(isai(self) && isDefined(self.stealth)) {
    self thread ai::look_at(undefined);
  }
}

function function_c7476e69() {
  level thread scene::play("scene_kgb_walkup_hall_talk", "Loop");
  level thread scene::play("scene_kgb_walkup_stairs_civ_guard", "Loop");
  level flag::wait_till("flag_player_swap");
  level scene::stop("scene_kgb_walkup_hall_talk", 1);
  level scene::stop("scene_kgb_walkup_stairs_civ_guard", 1);
}

function function_5b366e56() {}

function function_6b524517(a_ents) {}

function function_1c20e038() {
  level thread function_6ed43003();
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 1");
  level flag::wait_till("flag_open_basement");
  level thread scene::play("scene_kgb_walkup_gate_guard", "Shot 2");
  level thread scene::play("scene_kgb_walkup_adler", "Open");
  snd::client_msg(#"hash_7573f73261e72989");
  wait 2;
}

function function_5da2f302(a_ents) {
  a_ents[# "guard01"] thread entname::add(#"hash_5adf107d46cc0546", #"axis");
  level.var_1c20e038 = a_ents[# "guard01"];
}

function function_6ed43003() {
  level.var_bbfad301 = struct::get("prison_door_interact", "targetname");
  level.var_7dc87e06 = dialog_tree::new_tree(&function_255d9a99, &function_a4756f23, 0, 1);
  level.var_7dc87e06 dialog_tree::function_b82713b8(struct::get("struct_gate_guard_dt"), undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level.var_7dc87e06 dialog_tree::function_6bbbf87("flag_keycard_acquired", #"hash_1da99e6790aaa1a7", undefined, undefined, undefined, 1, "flag_open_basement", "flag_open_basement");
  level.var_7dc87e06 dialog_tree::function_bc7c03bf();
  level.var_7dc87e06 dialog_tree::add_option(#"hash_699c4e4234817fee", undefined, undefined, undefined, 1, undefined, "flag_open_basement", undefined);
  level.var_bbfad301 util::create_cursor_hint(undefined, (0, 0, 0), #"OBJECTIVES/TALK_TO", 32, undefined, &function_678d5d44);
  level flag::wait_till("flag_open_basement");
  level.var_bbfad301 util::remove_cursor_hint();
  level.var_7dc87e06 = undefined;
}

function function_678d5d44(struct) {
  level.var_7dc87e06 dialog_tree::run();
}

function function_255d9a99() {
  wait 1.5;
  level.var_1c20e038 dialogue::queue("vox_cp_rkgb_09950_camg_howcanihelpyous_08");
}

function function_a4756f23() {
  if(level flag::get("flag_open_basement")) {
    return;
  }

  level.var_bbfad301 util::create_cursor_hint(undefined, (0, 0, 0), #"OBJECTIVES/TALK_TO", 32, undefined, &function_678d5d44);
}

function function_9d40e1c(prompt) {
  doors::unlock_all(0);
  level flag::set("flag_got_key");
}

function function_736e8e64() {
  level.player endon(#"death");
  a_flags = [];
  a_flags[a_flags.size] = "player_basement_vent";
  a_flags[a_flags.size] = "player_data_vent";

  while(!level flag::get("flag_player_swap")) {
    if(!level.player namespace_5f6e61d9::function_cad84e26() && level flag::get_any(a_flags)) {
      level.player hideviewmodel();
      level flag::set("no_corpse_pickup");
      level.player thread util::blend_movespeedscale(0.4, 1);
      level flag::wait_till_clear_all(a_flags);
      level.player showviewmodel();
      level flag::clear("no_corpse_pickup");
      level.player thread util::blend_movespeedscale(1, 1);
    }

    waitframe(1);
  }
}

function function_5389a722() {
  level.player endon(#"death");
  level endon(#"flag_player_swap");

  while(!level flag::get("flag_player_swap")) {
    level flag::wait_till_any(level.var_e9c8a6d4);

    if(level flag::get_any(level.var_dae73e42)) {
      objectives_ui::function_b6d41b41(#"hash_2fed4b2a96944db4", 5);
      level thread function_aa172244();
    } else {
      objectives_ui::function_b6d41b41(#"hash_256e2a486b5f55cf", 5);
      level thread function_a72a9e93();
    }

    if(!level.player flag::get("body_shield_active")) {
      level.player thread util::blend_movespeedscale(1, 6);
    }

    level.player namespace_979752dc::set_disguised(0);
    level thread restricted_area_first_entered();
    guys = getaiarray();

    foreach(guy in guys) {
      guy namespace_979752dc::function_2324f175(1);
      guy.threatsight = 1;
    }

    level.player_in_restricted_area = 1;
    level flag::wait_till_clear_all(level.var_e9c8a6d4);
    objectives_ui::function_be5b472b();
    level.player thread util::blend_movespeedscale(0.85, 6);
    namespace_979752dc::set_disguised(1);
    guys = getaiarray();

    foreach(guy in guys) {
      guy namespace_979752dc::function_2324f175(0);
      guy.threatsight = 0;
    }

    level.player_in_restricted_area = undefined;
  }

  namespace_979752dc::set_disguised(1);
}

function function_a72a9e93() {
  level flag::wait_till_clear("player_doing_stealth_action");

  if(level flag::get_any(level.var_dae73e42)) {
    objectives_ui::function_b6d41b41(#"hash_2fed4b2a96944db4", 5);
    level thread function_aa172244();
  }
}

function function_aa172244() {
  level flag::wait_till_clear_all(level.var_dae73e42);

  if(level flag::get("player_doing_stealth_action")) {
    objectives_ui::function_b6d41b41(#"hash_256e2a486b5f55cf", 5);
    level thread function_a72a9e93();
  }
}

function function_9016f31d(time, var_9be855ca = 0) {
  level flag::wait_till("level_is_go");
  doors = doors::get_doors("stealth_door", "targetname");

  foreach(door in doors) {
    if(isDefined(door.c_door.m_s_bundle.door_start_sound)) {
      door.var_85c0f03 = door.c_door.m_s_bundle.door_start_sound;
    }

    if(isDefined(door.c_door.m_s_bundle.door_start_sound)) {
      door.var_fd8de6dd = door.c_door.m_s_bundle.door_stop_sound;
    }

    if(var_9be855ca) {
      door.c_door.m_s_bundle.door_start_sound = door.var_85c0f03;
      door.c_door.m_s_bundle.door_stop_sound = door.var_fd8de6dd;
      continue;
    }

    door.c_door.m_s_bundle.door_start_sound = "tmp_interact_lever_a";
    door.c_door.m_s_bundle.door_stop_sound = "tmp_interact_lever_a";
  }
}

function restricted_area_first_entered() {
  if(!level flag::get("restricted_area_first_entered") && !level flag::get("player_doing_stealth_action")) {
    level.player thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_thisareaisrestr_de");
    level flag::set("restricted_area_first_entered");
    return;
  }

  if(level flag::get("player_doing_stealth_action") && !level flag::get("first_lockpick_warning") && level flag::get("flag_start_finding_ways")) {
    level flag::set("first_lockpick_warning");
  }
}

function function_50d280db() {
  level.var_e9c8a6d4 = [];
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area_charkov_office";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area_war_room";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area_data_entry";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area_records";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_doing_stealth_action";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_area_office_1";
  level.var_e9c8a6d4[level.var_e9c8a6d4.size] = "player_in_restricted_maintenance_area";
  level thread function_70715735();
  level thread function_2008b07b();
  level thread function_5389a722();
  level thread function_736e8e64();
  level thread function_d3357b0e();
  level thread function_4facbf56();
  level thread function_5b17e90e();
  level thread function_6cee2b2b();
  level thread function_93751453();
  level thread function_84d975d5("data_entry_side", "flag_data_entry_side_opened");
  level thread function_84d975d5("data_entry_front", "flag_data_entry_front_opened");
}

function function_e9e9570d() {
  self.dontdropweapon = 1;
  self.holdfire = 1;
  self thread function_12c4b338();
  self battlechatter::function_2ab9360b(0);
  self.var_59212ad0 = "td_scene_stealth_front_a";
  self.var_d3f0031c = "td_scene_nonlethal_behind_a";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
  self thread function_3cf5b786("flag_player_swap");
  self.propername = function_70594daa();
  self thread function_7d7d8fd0();
}

function function_a7db4a16() {
  self endon(#"death");
  self thread function_e9e9570d();
  level flag::wait_till("false_intel_printed");
  spawner::simple_spawn_single("restricted_server_guard_1_a", &function_e9e9570d);
  self delete();
}

function function_6cee2b2b() {
  level flag::wait_till_any(["flag_unlock_southeast_door", "flag_keycard_acquried"]);
  doors::unlock("below_atrium_stairwell_double_door_right", "targetname", 0);
  doors::function_f35467ac("below_atrium_stairwell_double_door_right", "targetname");
  waitframe(1);
  doors::function_f5dd4f8f("below_atrium_stairwell_double_door_right", "targetname");
}

function function_84d975d5(var_b16a56e7, var_2a7f2052) {
  level thread function_e9015523(var_b16a56e7, var_2a7f2052);

  while(!level flag::get_any(["flag_keycard_acquried", var_2a7f2052])) {
    level flag::wait_till("player_in_restricted_area_data_entry");
    function_fb66780e(var_b16a56e7, var_2a7f2052);
    level flag::wait_till_clear("player_in_restricted_area_data_entry");
    function_b288a88b(var_b16a56e7, var_2a7f2052);

    if(level flag::get_all(["flag_data_entry_side_opened", "flag_data_entry_front_opened"])) {
      break;
    }
  }
}

function function_e9015523(var_b16a56e7, var_335a8dcc) {
  doors::waittill_door_opened(var_b16a56e7);
  level flag::set(var_335a8dcc);
}

function function_fb66780e(var_b16a56e7, var_e007da5c) {
  if(!level flag::get(var_e007da5c)) {
    doors::unlock(var_b16a56e7, "targetname", 0);
    doors::function_f35467ac(var_b16a56e7, "targetname");
    waitframe(1);
    doors::function_f5dd4f8f(var_b16a56e7, "targetname");
  }
}

function function_b288a88b(var_b16a56e7, var_e007da5c) {
  if(!level flag::get(var_e007da5c)) {
    doors::lock(var_b16a56e7, "targetname");
    doors::function_f35467ac(var_b16a56e7, "targetname");
    waitframe(1);
    doors::function_f5dd4f8f(var_b16a56e7, "targetname");
  }
}

function function_5b17e90e() {
  level thread function_15559a36();
  org = struct::get("ins_restricted_area_locker_lock_interact", "targetname");
  function_ca7fd487(org);
}

function function_15559a36() {
  level scene::init("scene_kgb_grab_poison_locker");
  poison = struct::get("ins_restricted_area_locker_poison", "targetname");
  level flag::wait_till("flag_combo_correct_and_complete");
  thread namespace_353d803e::function_ca0f1dd6();
  level scene::play("scene_kgb_grab_poison_locker", "Open");
  poison util::create_cursor_hint(undefined, (0, 0, 0), #"hash_2f8d1816b48968eb", 40, undefined, undefined, undefined, undefined, undefined, 0, 1, 1, undefined);
  poison prompts::set_objective("poison_tea");
  poison waittill(#"trigger");

  if(!level flag::get("flag_poi_office_secretary")) {
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_icouldschedulea_0a");
  }

  namespace_353d803e::function_2ecd85bc();
  level scene::play("scene_kgb_grab_poison_locker", "Grab");
  level flag::set("flag_poi_mail_poison");
  level.var_1b4de43[level.var_1b4de43.size] = "office";
  level notify(#"ping_map");
  namespace_353d803e::music("4.3_tension_stingers");
  level flag::set("flag_has_poison");
}

function function_ca7fd487(origin) {
  level.player endon(#"death");
  level endon(#"flag_player_swap");

  while(true) {
    origin util::create_cursor_hint(undefined, (0, 0, 0), #"hash_6a3223c9e4640186", 40, undefined, &function_f5ee087c, undefined, undefined, undefined, undefined, undefined, 1, undefined);
    s_result = level.player waittill(#"exit", #"combination_correct");
    namespace_e77bf565::function_f6eb250d();

    if(s_result._notify == # "exit") {
      function_c9965ab9(0);
      continue;
    }

    if(s_result._notify == # "combination_correct") {
      origin util::remove_cursor_hint();
      lock = getent("ins_restricted_area_locker_lock", "targetname");

      if(isDefined(lock)) {
        lock delete();
      }

      lock_pieces = getEntArray("lock_pieces", "targetname");

      foreach(piece in lock_pieces) {
        door = getent(piece.target, "targetname");
        piece linkto(door);
      }

      wait 1;
      namespace_6fdcb0::function_838e9ba9();
      function_c9965ab9(0);
      level flag::set("flag_combination_correct");
      break;
    }
  }
}

function function_f5ee087c() {
  level.player function_61f60c40();
  level.player notifyonplayercommandremove("show_itin", "+actionslot 4");
  level.player notifyonplayercommandremove("show_itin", "+map");
  level.player hide();
  level.player endon(#"death");
  function_c9965ab9(1);
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  namespace_6fdcb0::function_912776e6(#"hash_1345b8c1d1ad23a9");
  namespace_c8e236da::function_ebf737f8(#"hash_2c16a04fab0346fa");
  namespace_c8e236da::function_ebf737f8(#"hash_87cb1efbc51f19b");
  namespace_c8e236da::function_ebf737f8(#"hash_5c8c8fae13b36286");
  namespace_c8e236da::function_ebf737f8(#"hash_68ecec68c06f225b");
  namespace_c8e236da::function_ebf737f8(#"hash_7d0ad4e924d219af");

  while(true) {
    s_result = level.player waittill(#"exit", #"combination_correct");

    if(s_result._notify == # "exit") {
      level flag::set("combination_lock_exited");
      self notify(#"exit");
      break;
    }

    if(s_result._notify == # "combination_correct") {
      level flag::set("combination_lock_opened");
      combination_correct = 1;
      self notify(#"combination_correct");
      break;
    }

    wait 0.05;
  }

  level.player function_a1af304b();
  level.player notifyonplayercommand("show_itin", "+actionslot 4");
  level.player notifyonplayercommand("show_itin", "+map");
  level.player show();
  namespace_c8e236da::removelist();
}

function function_61f60c40() {
  self setstance("stand");
  self val::set(#"hash_2463ab97c65a943c", "freezecontrols", 1);
  self val::set(#"hash_25ec54e9c679c85a", "show_hud", 0);
  snd::play("evt_kgb_combo_lock_start");
  ins_restricted_area_locker_player_pos = struct::get("ins_restricted_area_locker_player_pos", "targetname");
  level.var_8deab66f = util::spawn_model("tag_origin", ins_restricted_area_locker_player_pos.origin, ins_restricted_area_locker_player_pos.angles);
  level.var_8deab66f dontinterpolate();
  self playerlinktoblend(level.var_8deab66f, "tag_origin", 0.5, 0, 0, 0.5, 0, 0, 0);
  wait 0.5;
}

function function_a1af304b() {
  self val::reset(#"hash_25ec54e9c679c85a", "show_hud");
  self unlink();

  if(isentity(level.var_8deab66f)) {
    level.var_8deab66f delete();
  }

  snd::play("evt_kgb_combo_lock_exit");
  wait 0.05;
  self val::reset(#"hash_2463ab97c65a943c", "freezecontrols");
  waitframe(1);

  if(level flag::get("combination_lock_opened")) {
    level flag::set("flag_combo_correct_and_complete");
  }
}

function function_a6dc6fea() {
  level flag::wait_till("translate_table");
  level.player dialogue::queue("vox_cp_rkgb_01650_blkv_maybetheresaclu_f6");
  var_f3b47ae = getent("periodic_translate_1", "targetname");
  namespace_93648050::register_trigger(hash("krav_clue_1"), var_f3b47ae, #"hash_617f7cd3a1666c29", 256, undefined, 4);
  var_20f66b24 = getent("periodic_translate_2", "targetname");
  namespace_93648050::register_trigger(hash("krav_clue_2"), var_20f66b24, #"hash_617f79d3a1666710", 256, undefined, 4);
  var_a5167306 = getent("periodic_translate_3", "targetname");
  namespace_93648050::register_trigger(hash("krav_clue_3"), var_a5167306, #"hash_617f7ad3a16668c3", 256, undefined, 4);
}

function function_d3357b0e() {
  level thread function_a6dc6fea();
  level.var_d177b2eb = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_d177b2eb dialog_tree::function_6bb91351(1);
  level.var_d177b2eb dialog_tree::add_option(#"hash_7d34d3de982050e9", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_c8954f13);
  level.var_d177b2eb dialog_tree::add_option(#"hash_7d34d0de98204bd0", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_caa6a3ae);
  level.var_d177b2eb dialog_tree::add_option(#"hash_7d34d1de98204d83", undefined, undefined, undefined, 1, "flag_krav_computer_end", "flag_player_swap");
  level.var_be570ce6 = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_be570ce6 dialog_tree::function_6bb91351(1);
  level.var_be570ce6 dialog_tree::add_option(#"hash_5f5be4cba62a1a79", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_2a54d579);
  level.var_be570ce6 dialog_tree::add_option(#"hash_7d34d0de98204bd0", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_caa6a3ae);
  level.var_be570ce6 dialog_tree::add_option(#"hash_7d34d1de98204d83", undefined, undefined, undefined, 1, "flag_krav_computer_end", "flag_player_swap");
  level.var_95307118 = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_95307118 dialog_tree::function_6bb91351(1);
  level.var_95307118 dialog_tree::add_option(#"hash_7eb613067ab2118c", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_c8954f13);
  level.var_95307118 dialog_tree::add_option(#"hash_7d34d0de98204bd0", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_caa6a3ae);
  level.var_95307118 dialog_tree::add_option(#"hash_7d34d1de98204d83", undefined, undefined, undefined, 1, "flag_krav_computer_end", "flag_player_swap");
  level.var_c076dbe2 = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_c076dbe2 dialog_tree::function_6bb91351(1);
  level.var_c076dbe2 dialog_tree::add_option(#"hash_7d34d3de982050e9", undefined, undefined, undefined, 1, undefined, "flag_player_swap", &function_c8954f13);
  level.var_c076dbe2 dialog_tree::add_option(#"hash_7d34d1de98204d83", undefined, undefined, undefined, 1, "flag_krav_computer_end", "flag_player_swap");
  struct = struct::get("krav_computer_struct", "targetname");

  while(true) {
    struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1d1e69534e69a425", 48);
    struct waittill(#"trigger");
    function_4674ac30();
  }
}

function function_4674ac30() {
  level flag::clear("flag_krav_computer_end");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  level thread function_c9965ab9(1);
  snd::client_msg(#"hash_305096503618cca");
  level scene::play("scene_kgb_krav_computer", "Enter");
  level thread scene::play("scene_kgb_krav_computer", "Loop");
  function_85aa7da();
  level.var_d177b2eb thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
  level flag::wait_till("flag_krav_computer_end");
  namespace_6f1d35e1::function_b2911127(0);
  snd::client_msg(#"hash_1d0a63220c75a83c");
  level scene::play("scene_kgb_krav_computer", "Exit");
  level thread function_c9965ab9(0);
  namespace_e77bf565::function_f6eb250d();
}

function function_85aa7da() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_36b7601e290f25d6", 1, 1);
  namespace_6f1d35e1::function_5d2e6f6a(1);
  thread namespace_353d803e::function_99a69ad6();
  wait 1;
  namespace_6f1d35e1::function_5d2e6f6a(4);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 75);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_46be75ae();
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
}

function function_c8954f13() {
  level flag::clear("flag_nova6_more");
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_57b8ffd5faae9aa", 1, 1);
  namespace_6f1d35e1::function_5d2e6f6a(5);
  thread namespace_353d803e::function_de7dc0e1();
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(7, 20);
  level waittill(#"typing_complete");
  level.var_be570ce6 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_2a54d579() {
  level flag::set("flag_nova6_more");
  namespace_6f1d35e1::function_5d2e6f6a(6);
  level.var_95307118 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
  thread namespace_353d803e::function_d528ae37();
  level flag::set("translate_table");
}

function function_caa6a3ae() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_6f5c0c413d982cf5", 1, 1);
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_c9581995();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_fa415a96();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_fa415a96();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_e03f1f30();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_a4f9d0d5();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(6, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_51e882d1();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(7, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_51e882d1();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(8, 10);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_51e882d1();
  level.var_c076dbe2 thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_6144219f() {
  function_85aa7da();
  wait 2;
  level.var_d177b2eb thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_4facbf56() {
  level.var_5b202469 = 10;
  level scene::init("scene_kgb_restricted_area_hack");
  level.var_a997edb = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_a997edb dialog_tree::function_6bb91351(1);
  level.var_a997edb dialog_tree::add_option(#"hash_309527a5b69f205e", undefined, undefined, undefined, 0, undefined, undefined, &function_c8feadcf);
  level.var_a997edb dialog_tree::function_9e36808(#"hash_309526a5b69f1eab", undefined, undefined, undefined, 0, undefined, undefined, &function_bded9011);
  level.var_a997edb dialog_tree::function_9e36808(#"hash_309525a5b69f1cf8", undefined, undefined, undefined, 1, undefined, undefined, &function_4526244e);
  level.hack_start = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.hack_start dialog_tree::function_6bb91351(1);
  level.hack_start dialog_tree::add_option(#"hash_37bb5d17341c5dd9", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_1788a45e, 1);
  level.var_1788a45e = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_1788a45e dialog_tree::function_6bb91351(1);
  level.var_1788a45e dialog_tree::add_option(#"hash_aae848a2bc1cb06", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  level.var_1788a45e dialog_tree::add_option(#"hash_aae838a2bc1c953", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  level.var_1788a45e dialog_tree::add_option(#"hash_aae828a2bc1c7a0", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_674ac3e5);
  level.var_674ac3e5 = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_674ac3e5 dialog_tree::function_6bb91351(1);
  level.var_674ac3e5 dialog_tree::add_option(#"hash_285ef8a27471b17", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  level.var_674ac3e5 dialog_tree::add_option(#"hash_285f08a27471cca", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &function_44277d9b);
  level.var_674ac3e5 dialog_tree::add_option(#"hash_285f18a27471e7d", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  level.var_44277d9b = dialog_tree::new_tree(undefined, undefined, 1, 1, undefined, 0);
  level.var_44277d9b dialog_tree::function_6bb91351(1);
  level.var_44277d9b dialog_tree::add_option(#"hash_77d1368a20a2a8bc", undefined, undefined, undefined, 1, undefined, "flag_server_computer_done", &hack_done);
  level.var_44277d9b dialog_tree::add_option(#"hash_77d1398a20a2add5", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  level.var_44277d9b dialog_tree::add_option(#"hash_77d1388a20a2ac22", undefined, undefined, undefined, 1, undefined, undefined, &function_1788a45e);
  ins_restricted_area_computer_org = struct::get("ins_restricted_area_computer_org", "targetname");
  ins_restricted_area_computer_org util::create_cursor_hint(undefined, (0, 0, 0), #"hash_1d1e69534e69a425", 48, undefined, &function_3f19c1c2, undefined, undefined, undefined, undefined, undefined, 1);
}

function function_1788a45e(start = 0) {
  if(!start) {
    function_dfa1824b(0);
  } else {
    function_9ee7f44b();
  }

  wait 2;
  level.var_1788a45e thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_674ac3e5() {
  function_dfa1824b(1);
  wait 2;
  level.var_674ac3e5 thread dialog_tree::run(undefined, undefined, level.var_5b202469, undefined, 1);
}

function function_44277d9b() {
  function_dfa1824b(1);
  wait 2;
  level.var_44277d9b thread dialog_tree::run(undefined, undefined, level.var_5b202469, undefined, 1);
}

function hack_done() {
  function_23cd85cd();
  wait 2;
  level.var_a997edb thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
}

function function_3f19c1c2(prompt) {
  level.player endon(#"death");
  level thread function_c9965ab9(1);
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  snd::client_msg(#"hash_4692f2d7c81a7c95");

  if(!level flag::get("flag_poi_krav_chat")) {
    level flag::set("flag_poi_krav_chat");
    level thread dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_theyretracingmy_12");
  }

  level scene::play("scene_kgb_restricted_area_hack", "Enter");
  level thread scene::play("scene_kgb_restricted_area_hack", "Loop");
  level.hack_start thread dialog_tree::run(undefined, undefined, undefined, undefined, 1);
  level flag::wait_till("false_intel_printed");
  level scene::play("scene_kgb_restricted_area_hack", "Exit");
  level thread function_c9965ab9(0);
  namespace_e77bf565::function_f6eb250d();
}

function function_c8feadcf() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_6064caa1b7a63903");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  thread namespace_353d803e::function_8d402f0e();
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
}

function function_9ee7f44b() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_b3d19381fa4b284");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  thread namespace_353d803e::function_25edef6f();
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
}

function function_dfa1824b(success = 0) {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  thread namespace_353d803e::function_2cf22b09();

  if(success) {
    namespace_6f1d35e1::function_487b4340(#"hash_611c4961fbe7922d");
    thread namespace_353d803e::function_988ff988();
  } else {
    namespace_6f1d35e1::function_487b4340(#"hash_7e79ced2793f615a");
    thread namespace_353d803e::function_5811b2f5();
  }

  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  wait 0.7;
}

function function_23cd85cd() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_b3d19381fa4b284");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  namespace_6f1d35e1::function_4951a2c8(6, 30);
  thread namespace_353d803e::function_4460a1c4();
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(7, 20);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_f62e9223();
  wait 0.7;
  thread namespace_353d803e::function_6b2b346f();
  namespace_6f1d35e1::function_4951a2c8(8, 20);
  level waittill(#"typing_complete");
}

function function_bded9011() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_7b2a28e49a6a92af");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  thread namespace_353d803e::function_a7ec91c7();
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(3, 30);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_46f1ef8();
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  snd::client_msg(#"hash_645d2b3398bf399c");
  thread namespace_353d803e::function_3207124a();
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  wait 0.7;
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  level waittill(#"typing_complete");
}

function function_4526244e() {
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.05;
  namespace_6f1d35e1::function_eea42dd9(#"hash_36ad27d8fa250b03");
  namespace_6f1d35e1::function_487b4340(#"hash_7083c5b3995b2394");
  namespace_6f1d35e1::function_5d2e6f6a(3);
  thread namespace_353d803e::function_bc17bb84();
  namespace_6f1d35e1::function_4951a2c8(1, 30);
  level waittill(#"typing_complete");
  wait 1;
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  snd::client_msg(#"hash_1a618ec692a1e9e3");
  level waittill(#"typing_complete");
  wait 0.5;
  namespace_6f1d35e1::function_4951a2c8(3, 20);
  level waittill(#"typing_complete");
  wait 0.5;
  namespace_6f1d35e1::function_4951a2c8(4, 20);
  level waittill(#"typing_complete");
  wait 0.5;
  namespace_6f1d35e1::function_4951a2c8(5, 20);
  level waittill(#"typing_complete");
  wait 0.5;
  namespace_6f1d35e1::function_4951a2c8(6, 20);
  snd::client_msg(#"hash_3e2a2b64b78567ad");
  level waittill(#"typing_complete");
  wait 0.5;
  namespace_6f1d35e1::function_b2911127(0);
  level thread function_19064ad8();
}

function function_19064ad8() {
  struct = struct::get("false_intel_org", "targetname");
  struct util::create_cursor_hint(undefined, (0, 0, 0), #"hash_799cc020cae47520", 42, undefined, undefined, undefined, undefined, undefined, 0, 1, 1, undefined);
  level flag::set("false_intel_printed");
  level scene::init("scene_kgb_grab_forged_doc");
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
  objectives::function_4eb5c04a(#"hash_31de057f9d4529f0", struct.origin);
  objectives::function_64eaa790(#"hash_31de057f9d4529f0", struct.origin, 240, 0);
  level thread function_4bccd512();
  struct waittill(#"trigger");
  level scene::play("scene_kgb_grab_forged_doc", "Grab");
  level flag::set("has_false_intel");
  level.var_eede7a6 notify(#"dialog_wait_cancel");
  level.var_1b4de43[level.var_1b4de43.size] = "checkpoint";
  level notify(#"ping_map");
}

function function_4bccd512() {
  level flag::wait_till_any(["has_false_intel", "flag_keycard_acquired"]);
  objectives::complete(#"hash_31de057f9d4529f0", undefined, 0);
}

function function_ed39356a() {
  level flag::wait_till("level_is_go");
  level.quest_objectives = [];
  function_eb745490();
  function_b0a7c6ab();
  function_c66af6b6();
  function_f152863f();
  level thread function_940ae8f6();
}

function function_940ae8f6() {
  var_5626983c = [];
  var_5626983c[var_5626983c.size] = "bunker_key_placed_in_world";
  var_5626983c[var_5626983c.size] = "flag_keycard_acquired";
  level flag::wait_till_any(var_5626983c);
  hotspots = getEntArray("mental_map_poi", "targetname");

  foreach(hotspot in hotspots) {
    hotspot interactive_map::function_4b1a5235(#"alt1");
  }

  if(isDefined(level.quest_objectives)) {
    keys = getarraykeys(level.quest_objectives);

    if(isDefined(keys)) {
      foreach(key in keys) {
        id = objectives::function_285e460(key);

        if(isDefined(id)) {
          objectives::remove(key);
        }
      }
    }
  }
}

function function_1b3bebea(prompt_struct) {
  data = prompt_struct;
  namespace_353d803e::function_5865b09e();
  location = level.interactive_map.var_2c15274b.object.script_noteworthy;

  if(isDefined(location)) {
    switch (location) {
      case # "hash_215b2b6854de7388":
      case # "charkov_office":
        objective_name = "poison_tea";
        break;
      case # "checkpoint":
      case # "server":
        objective_name = "making_a_mole";
        break;
      case # "interrogation":
      case # "records":
        objective_name = "prisoner_persuasion";
        break;
      case # "data":
      case # "armory":
        objective_name = "key_reprogram";
        break;
      default:
        break;
    }
  }

  keys = getarraykeys(level.quest_objectives);

  if(!isDefined(level.quest_objectives[objective_name])) {
    return;
  }

  foreach(key in keys) {
    if(key == objective_name) {
      if(isDefined(level.quest_objectives[key])) {
        level.quest_objectives[key].tracked = 1;
      }

      id = objectives::function_285e460(key);

      if(isDefined(id)) {
        thread objectives_ui::function_f3ac479c(id);
        objectives::show(key);

        if(key == "key_reprogram") {
          var_aed3a664 = objectives::function_285e460("key_reprogram_0");

          if(isDefined(var_aed3a664)) {
            thread objectives_ui::function_f3ac479c(var_aed3a664);
            var_b3aeaaf1 = objectives::function_285e460("key_reprogram_0");
            thread objectives_ui::function_f3ac479c(var_b3aeaaf1);
            objectives::show("key_reprogram_0");
            objectives::show("key_reprogram_1");
          }
        }
      }

      continue;
    }

    if(isDefined(level.quest_objectives[key])) {
      level.quest_objectives[key].tracked = 0;
    }

    id = objectives::function_285e460(key);

    if(isDefined(id)) {
      objectives::hide(key);

      if(key == "key_reprogram") {
        var_aed3a664 = objectives::function_285e460("key_reprogram_0");

        if(isDefined(var_aed3a664)) {
          objectives::hide("key_reprogram_0");
          objectives::hide("key_reprogram_1");
        }
      }
    }
  }

  function_bd719400();
  function_3a103505();
}

function function_5a785465(prompt_struct) {
  namespace_353d803e::function_5865b09e();
  level.var_dc5a0371 = !level.var_dc5a0371;

  if(isDefined(level.informant)) {
    if(level.var_dc5a0371) {
      level.informant interactive_map::add_object(#"kgb_informant_spawner", level.var_5fc836e5, 0);
      objectives::show(#"hash_76daa952e81173e7");
      return;
    }

    level.informant interactive_map::remove_object(#"kgb_informant_spawner");
    objectives::hide(#"hash_76daa952e81173e7");
  }
}

function function_3a103505() {
  hotspots = getEntArray("mental_map_poi", "targetname");

  for(i = 0; i < hotspots.size; i++) {
    hotspots[i] interactive_map::function_4b1a5235(#"confirm");

    switch (hotspots[i].script_noteworthy) {
      case # "charkov_office":
        if(!level.quest_objectives[# "poison_tea"].tracked) {
          hotspots[i] interactive_map::function_b5c2702b(#"confirm", level.var_a7c109a9);
        }

        break;
      case # "checkpoint":
        if(!level.quest_objectives[# "making_a_mole"].tracked) {
          hotspots[i] interactive_map::function_b5c2702b(#"confirm", level.var_a7c109a9);
        }

        break;
      case # "interrogation":
        if(!level.quest_objectives[# "prisoner_persuasion"].tracked) {
          hotspots[i] interactive_map::function_b5c2702b(#"confirm", level.var_a7c109a9);
        }

        break;
      case # "data":
        if(!level.quest_objectives[# "key_reprogram"].tracked) {
          hotspots[i] interactive_map::function_b5c2702b(#"confirm", level.var_a7c109a9);
        }

        break;
      case # "informant":
        if(namespace_94c47ce5::function_11b2b847() && !level flag::get("flag_informant_killed")) {
          hotspots[i] interactive_map::function_b5c2702b(#"confirm", level.var_ac82c4c6);
        }

        break;
      default:
        break;
    }
  }

  interactive_map::function_59b2a130(hotspots);
}

function function_eb745490() {
  objective_name = "poison_tea";
  level.quest_objectives[objective_name] = spawnStruct();
  level.quest_objectives[objective_name].tracked = 0;
  level thread function_3657d953(objective_name);
}

function function_b0a7c6ab() {
  objective_name = "making_a_mole";
  level.quest_objectives[objective_name] = spawnStruct();
  level.quest_objectives[objective_name].tracked = 0;
  level thread function_aecd702e(objective_name);
}

function function_c66af6b6() {
  objective_name = "prisoner_persuasion";
  level.quest_objectives[objective_name] = spawnStruct();
  level.quest_objectives[objective_name].tracked = 0;
  level thread function_240afef6(objective_name);
}

function function_f152863f() {
  objective_name = "key_reprogram";
  level.quest_objectives[objective_name] = spawnStruct();
  level.quest_objectives[objective_name].tracked = 0;
  level thread function_88437b4d(objective_name);
}

function function_3657d953(objective_name) {
  level endon(#"flag_keycard_acquired");

  while(!isDefined(level.secretary)) {
    waitframe(1);
  }

  loc = struct::get("fake_secretary_chat", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_b02843f7037ef32");
  objectives::hide(objective_name);
  level flag::wait_till_any(["flag_has_poison", "flag_player_scheduled_meeting"]);
  loc = struct::get("ins_restricted_area_locker_lock_interact", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);

  if(isDefined(loc.var_3e95b88f)) {
    loc prompts::set_objective(objective_name);
  }

  level flag::wait_till("flag_combination_correct");
  loc = struct::get("ins_restricted_area_locker_poison", "targetname");

  if(isDefined(loc)) {
    objectives::update_position(objective_name, loc.origin);
  }

  level flag::wait_till("flag_has_poison");
  loc = struct::get("fake_secretary_chat", "targetname");
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("flag_poi_office_meeting");
  loc = struct::get("poison_chat", "targetname");
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("player_sat_in_charkovs_office");
  objectives::remove(objective_name);
}

function function_aecd702e(objective_name) {
  level endon(#"flag_keycard_acquired");

  while(!isDefined(level.var_eede7a6)) {
    waitframe(1);
  }

  loc = struct::get("struct_obj_mule_guard", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_5990a66ba2d79b35");
  objectives::hide(objective_name);
  level flag::wait_till_any(["false_intel_printed", "flag_poi_krav_chat"]);
  loc = struct::get("ins_restricted_area_computer_org", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);

  if(isDefined(loc.var_3e95b88f)) {
    loc prompts::set_objective(objective_name);
  }

  level flag::wait_till("false_intel_printed");
  objectives::remove(objective_name);
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("has_false_intel");
  loc = struct::get("struct_obj_mule_guard", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);

  if(!level.quest_objectives[objective_name].tracked) {
    objectives::hide(objective_name);
  } else {
    objectives::show(objective_name);
  }

  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("flag_checkpoint_moment_done");
  loc = struct::get("obj_checkpoint", "targetname");
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("bunker_key_placed_in_world");
  objectives::remove(objective_name);
}

function function_240afef6(objective_name) {
  level endon(#"flag_keycard_acquired");
  loc = struct::get("prisoner_start", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0, undefined);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_585e9e16f7a506c6");
  objectives::hide(objective_name);
  var_be11e544 = [];
  var_be11e544[var_be11e544.size] = "flag_poi_records_file";
  var_be11e544[var_be11e544.size] = "flag_poi_interrogation_file";
  var_be11e544[var_be11e544.size] = "flag_poi_interrogation_leverage";
  msg = level flag::wait_till_any(var_be11e544);
  loc prompts::set_objective(undefined);
  objectives_ui::function_278c15e6(objective_name, undefined, 0);

  switch (msg._notify) {
    case # "flag_poi_interrogation_file":
      loc = struct::get("prisoner_chat", "targetname");
      objectives::update_position(objective_name, loc.origin);
      level flag::wait_till("flag_poi_interrogation_leverage");
      break;
    case # "hash_3757a56b6dde424":
    case # "flag_poi_records_file":
      loc = struct::get("prisoner_chat", "targetname");
      objectives::update_position(objective_name, loc.origin);
      level flag::wait_till("flag_poi_interrogation_leverage");
      break;
    case # "flag_poi_interrogation_leverage":
      break;
    default:
      break;
  }

  loc = struct::get("prisoner_start", "targetname");

  if(isDefined(loc.var_3e95b88f)) {
    loc prompts::set_objective(objective_name);
  }

  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("flag_poi_interrogation_uncuff");
  loc = struct::get("cuffs", "targetname");
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("flag_prisoner_complete");
  loc = struct::get("outside_interrogation_room", "targetname");
  objectives::update_position(objective_name, loc.origin);
  level flag::wait_till("flag_poi_interrogation_take");
  namespace_e77bf565::function_e90c279f();
  objectives::update_position(objective_name, level.var_fd2ed10f);
  level flag::wait_till("flag_prison_guard_go_away");
  objectives::remove(objective_name);
}

function function_88437b4d(objective_name) {
  level endon(#"flag_keycard_acquired");

  while(!isDefined(level.armory_guard)) {
    waitframe(1);
  }

  loc = struct::get("armory_guard_obj", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_649578d6e61c5747");
  objectives::hide(objective_name);
  level flag::wait_till_any(["flag_poi_armory_guy_dead", "flag_armory_persuade_03_called", "flag_request_armory"]);
  loc = struct::get("spare_card", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  loc = struct::get("spare_card", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  level flag::wait_till_any(["flag_poi_armory_guy_dead", "flag_poi_armory_guard"]);
  loc = struct::get("paperwork", "targetname");
  objectives::update_position(objective_name, loc.origin);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_770e19675ef089cb");

  if(isDefined(loc.var_3e95b88f)) {
    loc prompts::set_objective(objective_name);
  }

  msg = level flag::wait_till_any(["flag_poi_armory_guy_dead", "flag_poi_armory_paperwork", "flag_has_cigar", "flag_armory_persuade_03_called"]);

  if(msg._notify == "flag_armory_persuade_03_called") {
    var_d02e0a4b = struct::get_array("cigar", "targetname");

    for(i = 0; i < var_d02e0a4b.size; i++) {
      var_d3d9d3b = objective_name + "_" + string(i);
      objectives::goto(var_d3d9d3b, var_d02e0a4b[i].origin, undefined, 0);

      if(isDefined(var_d02e0a4b[i].var_3e95b88f)) {
        var_d02e0a4b[i] prompts::set_objective(var_d3d9d3b);
      }

      objectives_ui::function_49dec5b(var_d3d9d3b, undefined, #"hash_4b89c25b2524b4d2");
      objectives::function_6a5ca7ac(var_d3d9d3b, undefined, objective_name);

      if(!level.quest_objectives[objective_name].tracked) {
        objectives::hide(var_d3d9d3b);
      }
    }

    level flag::wait_till_any(["flag_poi_armory_guy_dead", "flag_poi_armory_paperwork", "flag_has_cigar"]);
  }

  if(isDefined(var_d02e0a4b)) {
    for(i = 0; i < var_d02e0a4b.size; i++) {
      var_d3d9d3b = objective_name + "_" + string(i);
      objectives::complete(var_d3d9d3b);
    }
  }

  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_649578d6e61c5747");

  if(!level flag::get("flag_poi_armory_guy_dead")) {
    loc = struct::get("armory_guard_obj", "targetname");
    objectives::goto(objective_name, loc.origin, undefined, 0);
  } else {
    loc = struct::get("armory_button", "targetname");
    objectives::goto(objective_name, loc.origin, undefined, 0);
  }

  level flag::wait_till("flag_poi_armory_open");
  loc = struct::get("spare_card", "targetname");
  objectives::goto(objective_name, loc.origin, undefined, 0);
  objectives_ui::function_49dec5b(objective_name, undefined, #"hash_649578d6e61c5747");
  level flag::wait_till("flag_got_spare_card");
  loc = struct::get("struct_computer_hack", "targetname");
  objectives::update_position(objective_name, loc.origin);

  if(isDefined(level.var_9fe9f285.var_3e95b88f)) {
    level.var_9fe9f285 prompts::set_objective("key_reprogram");
  }

  level flag::wait_till("flag_hacked_done");
  objectives::remove(objective_name);
}

function function_9202e546() {
  objective_name = "key_reprogram";
  var_d02e0a4b = struct::get_array("cigar", "targetname");

  for(i = 0; i < var_d02e0a4b.size; i++) {
    var_d3d9d3b = objective_name + "_" + string(i);
    objectives::goto(var_d3d9d3b, var_d02e0a4b[i].origin, undefined, 0);
    objectives_ui::function_49dec5b(var_d3d9d3b, undefined, #"hash_4b89c25b2524b4d2");
    objectives::function_6a5ca7ac(var_d3d9d3b, undefined, objective_name);
  }
}

function function_1e1716d5() {}

function function_a79c8909(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level thread scene::init("scene_kgb_poison_tea");
  level thread scene::init("scene_kgb_elevator_holdup");
  level thread scene::init("scene_kgb_walkup_adler");
  level.checkpoint_clip = getent("checkpoint_clip", "targetname");
  level.checkpoint_clip notsolid();
  level.checkpoint_clip_right = getent("checkpoint_clip_right", "targetname");
  level.checkpoint_clip_right notsolid();
  level thread namespace_99e99ffa::function_1d90bc4a();
}

function function_79e00661(var_d3440450, var_50cc0d4f) {
  if(is_true(var_50cc0d4f)) {
    level function_52f0fcb3(var_d3440450);
    level function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa(var_d3440450);
    level thread namespace_e77bf565::function_ada6d016();
    namespace_e77bf565::function_e2e72d4(1);
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
  }

  level.var_1b4de43 = [];
  level function_b797bde9();

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function function_b791ea12(name, starting, direct, player) {}

function function_b797bde9() {
  level.player endon(#"death");
  level scene::init("scene_kgb_camera_shutdown");
  var_288bb012 = struct::get("tutorial_button", "targetname");
  level.var_6d758088 = getEntArray("mental_map_poi", "targetname");
  level thread function_9368d359();
  level thread function_aa7cd2d6();
  level thread function_6cbe4283();
  level flag::wait_till("flag_show_itinerary");
  level.player thread dialogue::function_96171f6d("vox_cp_rkgb_01505_blkv_imbeingwatchedi_f3");
  level thread namespace_353d803e::function_5f16d3f3();
  level thread namespace_353d803e::function_fe19f3c9();
  level flag::wait_till("flag_tutorial_map_complete");
  level thread savegame::checkpoint_save();
  doors::function_f5dd4f8f("camera_room", "targetname");
  doors::function_f5dd4f8f("disable_camera_door", "targetname");
  doors::function_f5dd4f8f("camera_shutdown_door", "targetname");
  doors::waittill_door_opened("camera_room");
  objectives::update_position(#"kgb_tutorial", var_288bb012.origin);
  level flag::wait_till("player_in_restricted_maintenance_area");
  setDvar(#"hash_a794df2c802865c", 300);
  namespace_e77bf565::function_e2e72d4(0);
  doors::close("camera_room", "targetname");
  doors::function_f35467ac("disable_camera_door", "targetname");
  doors::function_f35467ac("camera_room", "targetname");
  function_5536d46d();
  level flag::set("flag_tutorial_2");
  function_3035c80d();
  var_288bb012 util::create_cursor_hint(undefined, (0, 0, 0), #"hash_37d2ed210df2f4d0", 32, undefined, undefined, undefined, 64, undefined, 0, 0);
  var_288bb012 prompts::set_objective(#"kgb_tutorial");
  var_288bb012 waittill(#"trigger");
  level thread function_c9965ab9(1);
  objectives::complete("kgb_tutorial");
  thread namespace_353d803e::function_ac0aa1e6();
  level notify(#"hash_1c1549a38fffb2f4");
  level scene::play("scene_kgb_camera_shutdown", "Shutdown");
  level flag::set("flag_poi_camera_done");
  level flag::set("disable_all_cameras");
  namespace_353d803e::music("4.3_tension_stingers");
  level thread function_7f81c6e4();
  level flag::set("no_corpse_pickup");
  wait 4;
  level thread function_c9965ab9(0);
  level thread function_da84b47c();
  setDvar(#"hash_a794df2c802865c", 650);
}

function function_3035c80d() {
  if(level flag::get("flag_camera_guy_dead")) {
    return;
  }

  objectives::hide(#"kgb_tutorial");
  objectives::function_4eb5c04a(#"hash_2e1eda22f13a70ad", level.var_2f572cd9.origin + (0, 0, 48), undefined, undefined);
  objectives_ui::function_49dec5b(#"hash_2e1eda22f13a70ad", undefined, #"hash_7c372ef896016d27");
  level flag::wait_till("flag_camera_guy_dead");
  objectives::complete(#"hash_2e1eda22f13a70ad");
  level waittill(#"hash_7158dbd72a2043b0", #"hash_2e50440663441b0a");
  objectives::show(#"kgb_tutorial");
}

function function_3fe94b24() {
  level.player endon(#"death");
  level.player endon(#"disconnect");
  level endon(#"stealth_spotted");
  level endon(#"hash_2e50440663441b0a");
  level endon(#"flag_player_stashing");
  level flag::wait_till("flag_camera_guy_dead");

  if(isDefined(level.player)) {
    level.player dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_nowtostashthebo_a9");
    function_94f34503();
    level.player dialogue::function_96171f6d("vox_cp_rkgb_01650_blkv_howaboutoneofth_55");
  }
}

function function_94f34503() {
  level.player endon(#"death");
  level.player endon(#"disconnect");
  level endon(#"hash_2e50440663441b0a");
  spot = struct::get("tutorial_locker_hide");

  while(!util::within_fov(level.player.origin, level.player.angles, spot.origin, cos(20))) {
    waitframe(1);
  }
}

function function_a8f549f8() {
  level flag::wait_till("level_is_go");
  doors::function_f35467ac();
  namespace_353d803e::function_f3d767c7();
  level flag::wait_till("flag_start_finding_ways");
  doors::function_f5dd4f8f();
}

function function_9368d359() {
  level.var_2f572cd9 = spawner::simple_spawn_single("tutorial_guy", &function_5b0a20a7);
  level thread function_3fe94b24();
}

function function_5b0a20a7() {
  self.dontdropweapon = 1;
  self.holdfire = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self actions::function_df6077("body_shield", 0);
  self.var_7b026ceb = 48;
  self endon(#"death");

  if(!isDefined(level.player_in_restricted_area)) {
    self namespace_979752dc::function_2324f175(0);
    self.threatsight = 0;
  }

  self.propername = function_70594daa();
  self.var_c681e4c1 = 1;
  self thread function_7d7d8fd0();
  self thread function_46b46212();
  self thread function_d76e3cea();
  scene::add_scene_func("scene_kgb_tutorial_camera_guard", &function_68dd1c91, "stop");
  level thread scene::play("scene_kgb_tutorial_camera_guard", "Forward_Loop");
  level flag::wait_till("flag_in_camera_room");
  self thread dialogue::queue("vox_cp_rkgb_09950_camg_sir_6d");
  level scene::play("scene_kgb_tutorial_camera_guard", "Greeting");
  level thread scene::play("scene_kgb_tutorial_camera_guard", "Forward_Loop");
  level flag::wait_till("flag_tutorial_2");
  self thread function_6f070100();
  chair = getent("tutorial_chair", "targetname");
  self.var_a08ba405 = chair;
  self.var_d3f0031c = "td_scene_nonlethal_behind_b";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
  self.var_59212ad0 = "td_scene_nonlethal_behind_b";
  self.var_f535b314 = # "hash_2f16f66c7d8ae1de";
  self.ignoreme = 0;
  self.ignoreall = 0;
  self thread function_90ba5cf6();
  level endon(#"stealth_spotted");

  while(isalive(self)) {
    if(level flag::get("player_in_restricted_maintenance_area") && isalive(self)) {
      if(isDefined(self) && isalive(self)) {
        level scene::play("scene_kgb_tutorial_camera_guard", "Watch");

        if(math::cointoss()) {
          self thread dialogue::queue("vox_cp_rkgb_09950_camg_howcanihelpyous_08");
        } else {
          self thread dialogue::queue("vox_cp_rkgb_09950_camg_sirwhatcanidofo_e1");
        }

        level thread scene::play("scene_kgb_tutorial_camera_guard", "Watch_Loop");
      }

      level flag::wait_till_clear_any(["player_in_restricted_maintenance_area"]);

      if(isDefined(self) && isalive(self)) {
        level scene::play("scene_kgb_tutorial_camera_guard", "Unalert");
        level thread scene::play("scene_kgb_tutorial_camera_guard", "Forward_Loop");
      }
    }

    waitframe(1);
  }
}

function function_68dd1c91(a_ents) {
  if(!isDefined(a_ents[# "tutorial_guy"])) {
    return;
  }

  guy = a_ents[# "tutorial_guy"];
  guy.var_1f1bd6ed = guy.origin;
  guy.var_598a8a9 = guy.angles;
  guy.var_caa295ea = 0;
}

function function_6f070100() {
  self endon(#"death");
  level.player endon(#"death");

  while(isalive(self)) {
    if(self function_5b602e4f(level.player, 0)) {
      self.var_c681e4c1 = 1;
    } else {
      self.var_c681e4c1 = 0;
    }

    waitframe(1);
  }
}

function function_90ba5cf6() {
  self endon(#"death");
  level flag::wait_till("stealth_spotted");
  self.var_ab101371 = undefined;
  self.var_1f1bd6ed = undefined;
  self.var_598a8a9 = undefined;
  level scene::stop("scene_kgb_tutorial_camera_guard");
  level thread scene::play("scene_kgb_tutorial_camera_guard", "Alerted");
}

function function_46b46212() {
  self waittill(#"death");
  level flag::set("flag_camera_guy_dead");
}

function function_d76e3cea() {
  chair = getent("tutorial_chair", "targetname");
  self.var_d3f0031c = "td_scene_nonlethal_behind_b";
  self.var_4f8ed4b2 = # "hash_2f16f66c7d8ae1de";
  self.var_59212ad0 = "td_scene_nonlethal_behind_b";
  self.var_f535b314 = # "hash_2f16f66c7d8ae1de";
  self.var_1f1bd6ed = chair.origin;
  self.var_598a8a9 = chair.angles;
  self.var_caa295ea = 0;
}

function function_5536d46d() {
  level.player endon(#"death");
  level.player hint_tutorial::function_4c2d4fc4(#"hash_7538688156dd5b8b", #"hash_7f4b0f582eadb7c", 1);
  level.player hint_tutorial::pause();
  level notify(#"hash_5f12484bb8ff1fdf");
}

function function_eab15e43(prompt_struct) {
  if(level flag::get("flag_tutorial_map_complete")) {
    return;
  }

  level flag::set("flag_tutorial_map_complete");
  namespace_c8e236da::function_ebf737f8(#"hash_3895e110abdb2bea");
  door = struct::get("tutorial_door", "targetname");
  objectives::function_4eb5c04a(#"kgb_tutorial", door.origin);
  objectives_ui::function_49dec5b(#"kgb_tutorial", undefined, #"hash_37d2ed210df2f4d0");
  door_ent = doors::function_73f09315("camera_room");
  door_ent prompts::set_objective(#"kgb_tutorial");
  spot = struct::get("tutorial_button", "targetname");
  spot interactive_map::add_object(#"camera", level.var_5fc836e5, 0, undefined);
  hotspots = getEntArray("mental_map_poi", "targetname");
  interactive_map::function_b2ece0a3();

  for(i = 0; i < hotspots.size; i++) {
    hotspots[i] interactive_map::function_4b1a5235(#"confirm");
  }

  interactive_map::function_59b2a130(hotspots);
}

function function_da84b47c() {
  level.player endon(#"death");
  level flag::set("flag_start_finding_ways");
  level thread function_3b309153();
  wait 0.5;
  namespace_e77bf565::function_f6eb250d("cinematicmotion_static");
  doors::function_f5dd4f8f("camera_room", "targetname");
  level.player val::set(#"hash_2463ab97c65a943c", "freezecontrols", 1);
  hint_tutorial::function_4c2d4fc4(#"hash_5e8c24c2263361fc", #"hash_25fcf94c023c66fd", 2, #"hash_70f26bb1ab701ef8");
  namespace_61e6d095::function_24e5fa63(#"hint_tutorial", [# "ui_confirm", #"ui_cancel"], 1);
  hint_tutorial::function_df08d48(10);
  level flag::wait_till("flag_show_itinerary");
  level thread dialogue::function_96171f6d("vox_cp_rkgb_01570_blkv_nowthatcharkovh_cd");
  hint_tutorial::function_9f427d88(0);
  level flag::wait_till_clear("flag_show_itinerary");
  level.player val::reset(#"hash_2463ab97c65a943c", "freezecontrols");
  level flag::clear("no_corpse_pickup");
}

function function_4a1580b6(a_ents) {
  radio = a_ents[# "prop 1"];

  if(!isDefined(radio)) {
    return;
  }

  radio endon(#"delete");
  radio physicslaunch();
}

function function_dbfe9c06(s_targetname) {
  spot = struct::get(s_targetname, "targetname");
  level.player endon(#"death");
  self endon(#"death");
  level.player.animnode = level.player util::spawn_model("tag_origin", spot.origin, spot.angles);
  blend_time = 1;
  var_73e95cd9 = 0.4;
  var_538574ac = 0.4;
  level.player thread clientfield::set_to_player("set_fov", 2);
  level.player thread clientfield::set_to_player("set_dof", 2);
  level.player playerlinktoblend(level.player.animnode, "tag_origin", blend_time, var_73e95cd9, var_538574ac);
  wait blend_time;
  level.player playerlinktodelta(level.player.animnode, "tag_origin", 1, 10, 10, 5, 5, 1, 1);
}

function function_6c5203f5() {
  level.player endon(#"death");
  var_5f75397b = vectornormalize(level.player.origin - self.origin);
  v_forward = anglesToForward(self.angles);
  var_3f9826ab = vectordot(var_5f75397b, v_forward);
  v_right = anglestoright(self.angles);
  var_8ecbd20e = vectordot(var_5f75397b, v_right);

  if(self haspath()) {
    var_186a9be1 = 1;
  }

  if(is_true(var_186a9be1)) {
    if(var_3f9826ab >= 0.5) {
      if(var_8ecbd20e <= -0.5) {
        return "player_in_front_left_walking";
      } else if(var_8ecbd20e >= 0.5) {
        return "player_in_front_right_walking";
      } else {
        return "player_in_front_walking";
      }
    } else if(var_3f9826ab <= -0.5) {
      if(var_8ecbd20e <= -0.5) {
        return "player_in_back_left_walking";
      } else if(var_8ecbd20e >= 0.5) {
        return "player_in_back_right_walking";
      } else {
        return "player_in_back_walking";
      }
    } else if(var_8ecbd20e <= -0.5) {
      return "player_to_left_walking";
    } else {
      return "player_to_right_walking";
    }

    return;
  }

  if(var_3f9826ab >= 0.7) {
    return "player_in_front";
  }

  if(var_3f9826ab <= -0.7) {
    return "player_in_back";
  }

  if(var_8ecbd20e <= -0.7) {
    return "player_to_left";
  }

  return "player_to_right";
}

function function_41bc2f44(var_38d4ed7) {
  level.player endon(#"death");
  self endon(#"death");
  var_d77e2032 = 1;
  var_8b9f0a1a = 1;
  level.player function_1e785651();
  player_eye = level.player getplayercamerapos();
  var_57f29522 = var_38d4ed7;
  dist = distance(player_eye, var_57f29522);
  height_diff = player_eye[2] - var_57f29522[2];
  var_dadcdf5 = 1;

  if(height_diff < var_dadcdf5) {
    height_diff = var_dadcdf5;
  }

  level.player.orig_origin = level.player.origin;
  level.player.animnode = level.player util::spawn_model("tag_origin", level.player.origin, level.player.angles);
  level.player.animnode dontinterpolate();
  blend_time = 0.8;
  var_73e95cd9 = 0.4;
  var_538574ac = 0.4;
  var_56ec0c47 = height_diff * var_d77e2032;
  yaw_diff = vectortoangles(level.player getplayercamerapos() - var_38d4ed7);
  level.player.animnode.angles = (level.player.animnode.angles[0] + var_56ec0c47, yaw_diff[1] + 180, level.player.animnode.angles[2]);
  var_370455d2 = level.player function_f0108ec(level.player.animnode, self);

  if(isDefined(var_370455d2)) {
    yaw_diff = vectortoangles(var_370455d2 - var_38d4ed7);
    level.player.animnode.angles = (level.player.animnode.angles[0] + var_56ec0c47, yaw_diff[1] + 180, level.player.animnode.angles[2]);
    level.player.animnode.origin = var_370455d2 - (0, 0, 1);
    level.player.animnode dontinterpolate();
  }

  wait 0.05;
  level.player thread clientfield::set_to_player("set_fov", 2);
  level.player thread clientfield::set_to_player("set_dof", 2);
  level.player playerlinktoblend(level.player.animnode, "tag_origin", blend_time, var_73e95cd9, var_538574ac);
  wait blend_time;
  level.player playerlinktodelta(level.player.animnode, "tag_origin", 1, 10, 10, 5, 5, 1, 1);
}

function function_f0108ec(animnode, guy) {
  var_2f81ae48 = 52;
  var_7be0fa76 = 48;
  var_81adfce0 = 58;
  zoffset = (0, 0, 1);
  start = guy.var_a2d321ae + zoffset;
  end = start + anglesToForward(guy.var_a28b010e) * var_2f81ae48 + zoffset;

  if(playerphysicstraceignoreent(start, end, guy) == end) {
    start = self.origin + zoffset;

    if(playerphysicstraceignoreent(start, end, self) == end) {
      return end;
    }
  }

  var_d17e4076 = distance(self.origin, guy.var_a2d321ae);
  start = self.origin + (0, 0, 1);

  if(var_d17e4076 >= var_7be0fa76 && var_d17e4076 <= var_81adfce0) {
    return undefined;
  }

  if(var_d17e4076 > var_81adfce0) {
    end = start + anglesToForward(animnode.angles) * (var_d17e4076 - var_81adfce0) + zoffset;
    return phys_trace(self, start, end, guy, var_7be0fa76, var_81adfce0);
  }

  if(var_d17e4076 < var_7be0fa76) {
    end = start + anglesToForward(animnode.angles) * (var_d17e4076 - var_7be0fa76) + zoffset;
    return phys_trace(self, start, end, guy, var_7be0fa76, var_81adfce0);
  }

  return undefined;
}

function function_1e785651() {
  stance = self getstance();

  if(stance != "stand") {
    self setstance("stand");

    while(self getstance() != "stand") {
      wait 0.05;
    }
  }
}

function phys_trace(player, start, end, guy, var_7be0fa76, var_81adfce0) {
  var_95269084 = playerphysicstraceignoreent(var_7be0fa76, var_81adfce0, guy);
  return var_95269084;
}