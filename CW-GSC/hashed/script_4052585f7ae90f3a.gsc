/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4052585f7ae90f3a.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#namespace namespace_4ed3ce47;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
  snd::wait_init();
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  level.var_dafd41b2 = [];
  level thread function_f58905f1();
  level thread function_28dfb441();

  snd::dvar("<dev string:x38>", "<dev string:x4e>" + 4, &function_5e7cc862);
  snd::dvar("<dev string:x52>", "<dev string:x4e>" + 40, &function_5e7cc862);
}

function function_8bd27331() {
  snd::play("evt_cp_ger_hub_radio_alert_team_lie");
}

function evt_cp_ger_hub_tv_change() {
  snd::play("evt_cp_ger_hub_tv_change");
}

function function_89070bfe() {
  snd::play("emt_fire_flareup_safehouse_03", (-2.7, -569.5, 16.3));
  var_f5de4997 = (-2.7, -569.5, 16.3);
  var_13cb0a3a = "emt_fire_gasoline_safehouse_hvy_01_lp";
  level.var_89070bfe = snd::play(var_13cb0a3a, var_f5de4997);
}

function function_8d5b23ae() {
  snd::play("emt_fire_flareup_safehouse_02", (-368, 298, 7));
  var_b22a1a58 = (-368, 298, 7);
  var_73f21acc = "emt_fire_gasoline_safehouse_hvy_02_lp";
  level.var_8d5b23ae = snd::play(var_73f21acc, var_b22a1a58);
}

function function_5bae4a7e(alias) {
  level.var_629f8c1e[alias] = snd::play(alias, (-299.926, 134.423, 33.9824));
}

function function_1ca6cc19(alias) {
  if(isDefined(level.var_629f8c1e[alias])) {
    snd::stop(level.var_629f8c1e[alias]);
    level.var_629f8c1e[alias] = undefined;
  }
}

function function_90b786f0() {
  function_1ca6cc19("emt_tapemach_nagra_play_lp");
  function_1ca6cc19("emt_tapemach_nagra_rew_lp");
  function_1ca6cc19("emt_tapemach_nagra_ff_lp");
  function_1ca6cc19("emt_tapemach_nagra_rec_lp");
  function_1ca6cc19("emt_tapemach_nagra_idle_lp");
}

function function_8f4b8ec9() {
  snd::stop(level.var_9506561c);
  snd::stop(level.var_30b99a98);
  snd::stop(level.var_625dc7b3);
  level.var_625dc7b3 = snd::play("vox_cp_ger_hub_radio_park_surveillance_02", (-292, 166, 42));
}

function function_326eae5c() {
  snd::stop(level.var_9506561c);
  snd::stop(level.var_30b99a98);
  snd::stop(level.var_625dc7b3);
  level.var_30b99a98 = snd::play("vox_cp_ger_hub_radio_park_surveillance_ff", (-292, 166, 42));
}

function function_12b07b90() {
  snd::stop(level.var_9506561c);
  snd::stop(level.var_30b99a98);
  snd::stop(level.var_625dc7b3);
  level.var_9506561c = snd::play("vox_cp_ger_hub_radio_park_surveillance_rew", (-292, 166, 42));
}

function function_a6bc28c4() {
  snd::stop(level.var_30b99a98);
  snd::stop(level.var_625dc7b3);
  snd::stop(level.var_9506561c);
}

function function_f58905f1() {
  level.var_629f8c1e = [];

  while(true) {
    var_c5e8d21e = function_9b8a74e0(self, "nagra_play", "nagra_rew", "nagra_ff", "nagra_stop", "nagra_rec");
    function_90b786f0();
    function_5bae4a7e("emt_tapemach_" + var_c5e8d21e + "_lp");
    snd::play("emt_tapemach_nagra_trans_button_push", (-299.926, 134.423, 33.9824));
    snd::play("emt_tapemach_" + var_c5e8d21e + "_mech", (-299.926, 134.423, 33.9824));
  }
}

function function_9b8a74e0(otherent, string1, string2, string3, string4, string5) {
  otherent endon(#"death");
  ent = spawnStruct();

  if(isDefined(string1)) {
    level thread util::waittill_level_string(string1, ent, otherent);
  }

  if(isDefined(string2)) {
    level thread util::waittill_level_string(string2, ent, otherent);
  }

  if(isDefined(string3)) {
    level thread util::waittill_level_string(string3, ent, otherent);
  }

  if(isDefined(string4)) {
    level thread util::waittill_level_string(string4, ent, otherent);
  }

  if(isDefined(string5)) {
    level thread util::waittill_level_string(string5, ent, otherent);
  }

  if(isDefined(otherent)) {
    otherent thread util::waittill_string("death", ent);
  }

  waitresult = ent waittill(#"returned");
  ent notify(#"die");
  return waitresult.msg;
}

function private _objective(objective) {
  level thread allies_init();

  switch (objective) {
    case # "chapter_selection":
      break;
    case # "post_takedown":
    case # "post_takedown_skip_briefing":
      break;
    case # "post_armada":
    case # "post_armada_skip_briefing":
      break;
    case # "post_yamantau":
    case # "post_yamantau_skip_briefing":
      break;
    case # "post_kgb":
    case # "post_kgb_skip_briefing":
      break;
    case # "post_cuba":
    case # "hash_6245569317a5039e":
      break;
    case # "post_prisoner":
    case # "hash_65bc9e5b3b128daf":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x68>" + objective + "<dev string:x8b>");

      break;
  }
}

function private event_handler[runnotetrackhandler] runnotetrackhandler(eventstruct) {
  assert(isarray(eventstruct.notetracks));

  for(index = 0; index < eventstruct.notetracks.size; index++) {
    ent = eventstruct.entity;
    notetrack = eventstruct.notetracks[index];

    if(isDefined(notetrack)) {}
  }
}

function allies_init() {
  level.var_dafd41b2 = [];
  snd::waitforplayers();

  while(!isDefined(level.adler)) {
    waitframe(1);
  }

  level.var_dafd41b2[level.var_dafd41b2.size] = level.adler;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.lazar;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.park;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.sims;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.hudson;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.woods;
  level.var_dafd41b2[level.var_dafd41b2.size] = level.mason;
  arrayremovevalue(level.var_dafd41b2, undefined);
  var_c11d92ab = [];
  var_c11d92ab[#"adler"] = "adler";
  var_c11d92ab[#"lazar"] = "lazar";
  var_c11d92ab[#"park"] = "park";
  var_c11d92ab[#"sims"] = "sims";
  var_c11d92ab[#"hudson"] = "hudson";
  var_c11d92ab[#"woods"] = "woods";
  var_c11d92ab[#"mason"] = "mason";
  var_c11d92ab[#"hash_4a80558bcd5f168d"] = "adler";
  var_c11d92ab[#"lazar_cuba"] = "lazar";
  var_c11d92ab[#"park_cuba"] = "park";
  var_c11d92ab[#"hash_36e48d20b2a2a817"] = "sims";
  var_c11d92ab[#"hash_1cdd5d46cf8f0056"] = "hudson";
  var_c11d92ab[#"hash_4d2b01aab553821b"] = "woods";
  var_c11d92ab[#"hash_2f2bc790a3127bb"] = "mason";

  foreach(ally in level.var_dafd41b2) {
    if(isstring(ally.targetname)) {
      name = var_c11d92ab[ally.targetname];

      if(snd::function_81fac19d(!isDefined(name), "allies_init '" + ally.targetname + "' has no remapped name!")) {
        continue;
      }

      snd::client_targetname(ally, name);
    }
  }
}

function function_5e7cc862(key, value) {
  function_4b193e02();
  function_8a58b4f();
  return value;
}

function function_4b193e02() {
  level notify(#"hash_7ad75056b30c451a");
  level notify(#"hash_63850bb43dbc38de");

  foreach(ally in level.var_dafd41b2) {
    ally.var_2de4672c = undefined;
  }
}

function function_c26120ff(ent) {
  type = array::random(["cough", "sniff", "throat"]);
  name = ent.targetname;

  if(isstring(name)) {
    if(issubstr(name, "adler")) {
      name = "adler";
    }

    if(issubstr(name, "lazar")) {
      name = "lazar";
    }

    if(issubstr(name, "mason")) {
      name = "mason";
    }

    if(issubstr(name, "park")) {
      name = "park";
    }
  }

  alias = "vox_" + name + "_" + type;

  if(!soundexists(alias)) {
    return ("vox_male_" + type);
  }

  return alias;
}

function function_8a58b4f() {
  min_time = getdvarfloat(#"hash_5a9d5543cb5829b3", 4);
  max_time = getdvarfloat(#"hash_5ab96b43cb70c9cd", 40);

  foreach(ally in level.var_dafd41b2) {
    if(!isDefined(ally.var_2de4672c)) {
      ally thread snd::function_9299618(&function_c26120ff, [min_time, max_time]);
    }
  }
}

function function_28dfb441() {
  level waittill(#"eboard_ready");
  wait 0.1;

  snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x90>");

  level thread allies_init();
  function_8a58b4f();
}

function function_93cce074(n_start_time) {
  self endon(#"death");
  level.var_d14d678 = "emt_wall_clock_tick";
  var_30d4078d = n_start_time * 3600 - 4;
  time_offset = var_30d4078d / 30;
  var_4d3606d8 = int(time_offset);
  var_258bfe43 = time_offset - var_4d3606d8;
  wait_time = 1 - var_258bfe43;
  wait var_258bfe43;

  while(isDefined(self)) {
    self snd::play(level.var_d14d678, self);
    wait 1;
  }
}

function dia_focus_on() {
  snd::client_msg("dia_focus_on");
}

function dia_focus_off() {
  snd::client_msg("dia_focus_off");
}

function ambient_override_return_to_normal() {
  snd::client_msg("ambient_override_return_to_normal");
}

function ambient_ext_override() {
  snd::client_msg("ambient_ext_override");
}

function ambient_int_override() {
  snd::client_msg("ambient_int_override");
}

function function_e81e970a() {
  snd::client_msg("amb_takedown");
}

function function_3c39b015() {
  snd::client_msg("amb_armada");
}

function function_d701d197() {
  snd::client_msg("amb_yamantau");
}

function function_91962847() {
  snd::client_msg("amb_kgb");
}

function function_b7c50de7() {
  snd::client_msg("amb_cuba");
}

function function_d3856f8a() {
  snd::client_msg("amb_prisoner");
}

function function_ef8c9b18() {
  snd::client_msg("amb_burns");
}

function function_d2bce2b8() {
  snd::play("uin_transition_evidence_board_enter");
}

function function_dd520714() {
  snd::play("uin_transition_evidence_board_exit");
}

function function_6fe99ae0() {
  snd::play("uin_map_whoosh_paper");
}

function function_f60575fd() {
  snd::play("uin_map_camera_move_whoosh");
}

function function_dc08e48d() {
  snd::play("evt_fan_portable_switch_on", (57, -448, 19));
  snd::play("evt_fan_portable_idle_lp", (57, -448, 19));
  snd::play("evt_fan_portable_switch_on_ramp_up", (57, -448, 19));
}

function emt_projector_slide_change_forward() {
  snd::play("emt_projector_slide_change_forward", (72, 261, 46));
}

function function_7edafa59(str_msg) {
  if(isDefined(level.var_41fc1341)) {
    if(level.var_41fc1341 != str_msg) {
      level.var_2c9b406b = level.var_41fc1341;
    }
  }

  switch (str_msg) {
    case # "ambient":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("ambient");
      break;
    case # "evidence_board_main":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("evidence_board_main");
      break;
    case # "hash_75e670280bd9b6de":
      level.var_41fc1341 = str_msg;
      break;
    case # "post_takedown_briefing":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_takedown");
      break;
    case # "post_armada_briefing":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_armada");
      break;
    case # "post_yamantau_briefing":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_yamantau");
      break;
    case # "post_kgb_briefing":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_kgb");
      break;
    case # "post_cuba_briefing":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_cuba");
      break;
    case # "hash_210b4ac6f58c7279":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("briefing_prisoner");
      break;
    case # "prisoner_part1_safehouse":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part1_safehouse");
      break;
    case # "prisoner_part2_takedown_flashback":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part2_takedown_flashback");
      break;
    case # "prisoner_part3_safehouse":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part3_safehouse");
      break;
    case # "prisoner_part4_vietnam_flashback":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part4_vietnam_flashback");
      break;
    case # "prisoner_part5_safehouse":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part5_safehouse");
      break;
    case # "prisoner_part6_reddoor_flashback":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part6_reddoor_flashback");
      break;
    case # "prisoner_part7_safehouse":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part7_safehouse");
      break;
    case # "prisoner_part8_perseus_flashback":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part8_perseus_flashback");
      break;
    case # "prisoner_part9_safehouse":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_part9_safehouse");
      break;
    case # "character_creation_screen":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("character_creation_screen");
      break;
    case # "prisoner_lie":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("prisoner_lie");
      break;
    case # "none":
      level.var_41fc1341 = str_msg;
      music::setmusicstate("none");
      break;
    default:

      iprintlnbold("<dev string:xa0>" + str_msg + "<dev string:xb2>");

      break;
  }
}

function function_44ce38f6() {
  snd::play("uin_transition_lowender_takedown");
}

function fly_arcade_machine_interact_hub_approach() {
  snd::play("fly_arcade_machine_interact_hub_approach");
  snd::client_msg("duck_cp_ger_hub_arcade_machine_enter");
}

function fly_arcade_machine_interact_hub_quit() {
  snd::play("fly_arcade_machine_interact_hub_quit");
  snd::client_msg("duck_cp_ger_hub_arcade_machine_exit");
}

function function_e043da15() {
  level waittill(#"hash_30a43574a5dc7eaf");
  level thread function_7edafa59("ambient");
}

function function_9ac95ec9() {
  level waittill(#"hash_1c9f12be6eb51878");
  level thread function_7edafa59("ambient");
}

function function_37c997de() {
  level waittill(#"hash_55da63f0f51c5d6c");
  level thread function_7edafa59("ambient");
}

function function_4aa573e7() {
  level waittill(#"hash_2a423f7844789ffa");
  level thread function_7edafa59("ambient");
}

function function_d89aa829() {
  level waittill(#"hash_117dd9247812a234");
  level thread function_7edafa59("ambient");
}

function function_46f173b2() {
  level waittill(#"hash_3b68231254fe41c0");
  level thread function_7edafa59("ambient");
}

function function_849d7772() {
  level waittill(#"hash_62067a3d17f16ce0");
  level thread function_7edafa59("ambient");
}

function function_e25181b5() {
  level thread function_7edafa59("prisoner_lie");
}

function function_a0289367() {
  level thread function_7edafa59("none");
}

function function_bc5cf85e() {
  level thread function_7edafa59("character_creation_screen");
}

function function_e522e5de() {
  level thread function_7edafa59("prisoner_part1_safehouse");
}

function function_a59705f8() {
  level thread function_7edafa59("prisoner_part2_takedown_flashback");
}

function function_f526df02() {
  level thread function_7edafa59("prisoner_part3_safehouse");
}

function function_3f60bc38() {
  level thread function_7edafa59("prisoner_part4_vietnam_flashback");
}

function function_4825c155() {
  level thread function_7edafa59("prisoner_part5_safehouse");
}

function function_85d1dd20() {
  level thread function_7edafa59("prisoner_part6_reddoor_flashback");
}

function function_32eb5fd4() {
  level thread function_7edafa59("prisoner_part7_safehouse");
}

function function_d73cc011() {
  level thread function_7edafa59("prisoner_part8_perseus_flashback");
}

function function_7aef4705() {
  level thread function_7edafa59("prisoner_part9_safehouse");
}

function duck_evidence_board_enter() {
  snd::client_msg("duck_evidence_board_enter");
}

function duck_evidence_board_exit() {
  snd::client_msg("duck_evidence_board_exit");
}

function function_ef676505() {
  snd::client_msg("post_armada");
}

function function_2d62fc6f() {
  snd::client_msg("post_kgb");
}

function function_d6c61f8() {
  snd::client_msg("post_cuba");
}

function function_dd79396d() {
  snd::client_msg("post_prisoner");
}

function function_7f23d560() {
  snd::client_msg("post_prisoner_burn_scene");
}

function function_c7f31c4b() {
  snd::client_msg("post_takedown");
}

function function_938891c9() {
  snd::client_msg("post_yamantau");
}