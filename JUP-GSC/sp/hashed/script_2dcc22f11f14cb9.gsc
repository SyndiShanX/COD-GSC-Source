/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2dcc22f11f14cb9.gsc
************************************************/

#using script_151f37cd7136b363;
#using script_389a9d54d8274d2a;
#using script_3ef1b643f06851a8;
#using script_49511723a3204d35;
#using script_654ffaecd1155946;
#using script_ff8b2e2a2a57828;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\civilian\script_funcs;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\utility;
#namespace namespace_b70aaea56eab28ad;

function function_49f04025505c224f() {}

function function_ccace4f2a1963b03() {
  var_9682448e6f12c45c = getStruct("scene_jup_surge_0010_igc_intro", "targetname");
  actors = [level.var_d18d63c6d75cd1e, level.ai_hacker];
}

function function_562650cee5b48ad3() {
  showcinematicletterboxing(0, 0);
  var_9682448e6f12c45c = getStruct("scene_jup_surge_0010_igc_intro", "targetname");
  var_9682448e6f12c45c scene::function_8207074e79f22926(self, "soap_hidden", "soap_igc_intro");
  actors = [level.var_d18d63c6d75cd1e, level.ai_hacker];
  shots = ["sh0005", "sh0010", "sh0020", "sh0043", "sh0047", "sh0050", "sh0060_plr"];
  var_9682448e6f12c45c scene::pre_stream(actors);
  flag_wait("park_spawn_allies_complete");
  flag_wait("spawn_hacker_complete");
  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  wait 3;
  level notify("audio_level_fade_in");
  level.player thread scripts\sp\hud_util::fade_in(2, "black");
  thread function_9a13056242aa2c1b();
  thread function_6baba53404e0a1c9();
  level thread namespace_85a51fd192b9a590::function_22a5aeaa16ae2674();
  level.player hideviewmodel();
  var_9682448e6f12c45c scene::play(actors, shots);
  flag_set("park_dof_scripting_enabled");
  player_start = var_9682448e6f12c45c scene::get_entity("soap_igc_intro");
  player_start delete();
}

function function_9a13056242aa2c1b() {
  var_9682448e6f12c45c = getStruct("scene_jup_surge_0010_igc_intro", "targetname");
  var_9682448e6f12c45c scene::function_8207074e79f22926(self, "start_gaz_idle", "soap_igc_intro");
  self waittill("start_gaz_idle");
  thread function_45040b01e83f74e6("flg_park_cctv_1_start");
}

function function_6baba53404e0a1c9() {
  var_9682448e6f12c45c = getStruct("scene_jup_surge_0010_igc_intro", "targetname");
  var_9682448e6f12c45c scene::function_8207074e79f22926(self, "start_gaz_idle", "soap_igc_intro");
  self waittill("start_gaz_idle");
  wait 4.3;
  hidecinematicletterboxing(1.5, 0);
}

function function_725531478da9a290() {
  var_968f568e6f210077 = getStruct("scene_jup_surge_0020_cctv_command", "targetname");
  var_968f568e6f210077 scene::pre_stream();
}

function function_af8cc52dde1fec72() {
  var_968f568e6f210077 = getStruct("scene_jup_surge_0020_cctv_command", "targetname");
  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  wait 1;
  level.player thread scripts\sp\hud_util::fade_in(2, "black");
  var_968f568e6f210077 scene::play();
  var_968f568e6f210077 scene::cleanup();
}

function function_bc60742de6e979ab() {
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_12890444d983f3b5();
}

function scene_0110() {
  var_877b958e63de22a3 = getStruct("scene_jup_surge_0110_park_target_reveal", "targetname");
  var_877b958e63de22a3 scene::function_8207074e79f22926(level.player, "display_plr_cig", "player_cig");
  var_877b958e63de22a3 scene::add_spawn_function(&function_1ef9237ee2cfae7f, "player_cig");
  level.var_d18d63c6d75cd1e scripts\asm\shared\utility::disabledefaultfacialanims(1);
  level.var_d18d63c6d75cd1e set_name("");
  level.var_d18d63c6d75cd1e.callsign = undefined;

  if(isplatformps4()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "33.33");
  }

  var_877b958e63de22a3 scene::play([level.var_d18d63c6d75cd1e, level.player], "blend_smoke");
  level.player val::set("park_no_prone", "prone", 0);
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_476b266a5d575d91();
  flag_clear("flg_park_blended");

  if(isplatformps4()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "16.66");
  }

  level.var_d18d63c6d75cd1e set_name("Gaz");
  level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
  flag_set("flg_park_gaz_blend_done");
  var_877b958e63de22a3 thread scene::play([level.var_d18d63c6d75cd1e], "idle02");
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_a5c7dce5a458f75e();
  flag_set("park_dof_scripting_enabled");
  flag_wait("flg_park_stealth_done");
  var_877b958e63de22a3 scene::stop();
  level.var_d18d63c6d75cd1e stop_magic_bullet_shield();
  level.var_d18d63c6d75cd1e delete();
}

function function_3514b08077a9e67f() {
  s_park_intro_hide_ref = getStruct("s_park_intro_hide_ref", "targetname");
  a_ai = get_all_closest_living(s_park_intro_hide_ref.origin, getaiarray("all"), 50);

  if(a_ai.size > 0) {
    a_ai[0] hide();
  }
}

function function_1ef9237ee2cfae7f() {
  waitframe();
  self hide();
  level.player waittill("display_plr_cig");
  self show();
}

function function_45040b01e83f74e6(var_bab2d71dccda7436) {
  while(!isDefined(level.var_d18d63c6d75cd1e)) {
    waitframe();
  }

  var_877b958e63de22a3 = getStruct("scene_jup_surge_0110_park_target_reveal", "targetname");
  var_877b958e63de22a3 thread scene::play([level.var_d18d63c6d75cd1e], "idle01");
  level thread function_3514b08077a9e67f();

  if(isDefined(var_bab2d71dccda7436)) {
    flag_wait(var_bab2d71dccda7436);
    var_877b958e63de22a3 scene::stop();

    if(isDefined(level.var_d18d63c6d75cd1e)) {
      level.var_d18d63c6d75cd1e stop_magic_bullet_shield();
      level.var_d18d63c6d75cd1e delete();
      level.var_d18d63c6d75cd1e = undefined;
    }

    wait 0.5;
    flag_set("gaz_ready_for_respawn");
  }
}

function scene_0120() {
  var_876ea38e63d02ce8 = getStruct("scene_jup_surge_0120_park_dead_drop", "targetname");
  var_876ea38e63d02ce8 thread function_3d071e08c5d630a8();
  var_876ea38e63d02ce8 scene::play([level.ai_hacker], "whiskey_enter");
  flag_set("flg_begin_handoff");
  var_876ea38e63d02ce8 scene::play([level.ai_hacker], "handoff");
  flag_wait("flg_blending_intro_done");
  var_876ea38e63d02ce8 scene::play([level.ai_hacker], "whiskey_exit");
}

function function_3d071e08c5d630a8() {
  flag_wait("flg_begin_handoff");
  scene::play([level.var_d122bf82b81a4b63], "target_handoff");
  flag_wait("flg_blending_intro_done");
  scene::play([level.var_d122bf82b81a4b63], "target_exit");
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_476b266a5d575d91();
}

function scene_0130() {
  trigger_wait("trigger_price_convo_nod", "targetname");
  var_8772a98e63d42ff1 = getStruct("scene_jup_surge_0130_park_convo", "targetname");
  var_8772a98e63d42ff1 scene::play([level.ai_price], "nod");
  var_8772a98e63d42ff1 thread scene::play([level.ai_price], "idle");
}

function function_c6ba32a773682835() {
  var_8772a98e63d42ff1 = getStruct("scene_jup_surge_0130_park_convo", "targetname");
  var_8772a98e63d42ff1 thread scene::play([level.ai_price], "idle");
}

function function_bc53672de6db488f() {
  var_8772ac8e63d4368a = getStruct("scene_jup_surge_0135_park_postcard", "targetname");
  level flag_set("blending_anim_starting");
  flag_set("flg_park_final_blend_in_progress");
  var_8772ac8e63d4368a scene::play(undefined, "postcard_blend");
  ent_flag_set("blending_anim_done");
  var_8772ac8e63d4368a thread scene::play(undefined, "postcard_end");
  level flag_clear("blending_anim_starting");
  flag_set("park_dof_scripting_enabled");
  flag_clear("flg_park_final_blend_in_progress");
  flag_wait("flg_park_stealth_done");
  var_8772ac8e63d4368a scene::stop();
}

function function_5aa86d2363e5b5bb() {
  var_8772ac8e63d4368a = getStruct("scene_jup_surge_0135_park_postcard", "targetname");
  var_8772ac8e63d4368a thread scene::play(undefined, "postcard_idle");
}

function function_9602c26b3bba96() {
  var_8772ac8e63d4368a = getStruct("scene_jup_surge_0135_park_postcard_b", "targetname");
  var_8772ac8e63d4368a scene::play(undefined, "postcard_blend");
  level flag_set("scene_0135b_anim_done");
}

function function_bc53692de6db4cf5() {
  var_8772aa8e63d43224 = getStruct("scene_jup_surge_0137_park_phone", "targetname");
  flag_set("flg_park_final_blend_in_progress");
  thread function_76937748c8a5795b();
  var_8772aa8e63d43224 scene::play();
  flag_set("park_dof_scripting_enabled");
  flag_clear("flg_park_final_blend_in_progress");
}

function function_bc6d662de6f76f66() {
  var_878d2d8e63f17b47 = getStruct("scene_jup_surge_0150_park_call", "targetname");
  var_878d2d8e63f17b47 thread scene::play([level.ai_hacker], "call");
}

function function_c236e6ba4290dfab() {
  var_878d2d8e63f17b47 = getStruct("scene_jup_surge_0150_park_call", "targetname");
  var_878d2d8e63f17b47 scene::play([level.ai_hacker], "call_exit");
}

function scene_0160() {
  var_87801b8e63e33f2c = getStruct("scene_jup_surge_0160_park_shoe", "targetname");
  level thread function_e3173a05d290a4d9();
  var_87801b8e63e33f2c scene::function_8207074e79f22926(level.player, "shoetie_look_left_start", "Actor 1");
  var_87801b8e63e33f2c scene::function_8207074e79f22926(level.player, "shoetie_look_left_end", "Actor 1");
  var_87801b8e63e33f2c scene::play([level.ai_hacker], "enter");
  var_87801b8e63e33f2c thread scene::play([level.ai_hacker], "loop");
  wait 5;
  var_87801b8e63e33f2c scene::play([level.ai_hacker], "exit");
}

function function_e3173a05d290a4d9() {
  level.player waittill("shoetie_look_left_start");
  tr_park_hacker_los_shoetie = getEnt("tr_park_hacker_los_shoetie", "targetname");
  tr_park_hacker_los_shoetie trigger_on();
  level.player waittill("shoetie_look_left_end");
  tr_park_hacker_los_shoetie trigger_off();
}

function function_bc64fa2de6ee9634() {}

function function_bc83642de70f9e33() {
  var_87541f8e63b2e192 = getStruct("scene_jup_surge_0180_park_spotted", "targetname");
  var_87541f8e63b2e192 scene::play([level.ai_hacker]);
}

function function_bc7efe2de70ac80a() {
  var_8758a58e63b7fe1b = getStruct("scene_jup_surge_0190_park_pet", "targetname");
  level.dog stopanimScripted();
  level flag_set("blending_anim_starting");
  var_8758a58e63b7fe1b thread function_a7fccf73a0607228(level.dog, "scene_0190_interact_done");
  var_8758a58e63b7fe1b scene::play(undefined, "interact");
  ent_flag_set("blending_anim_done");
  level flag_clear("blending_anim_starting");
  flag_set("park_dof_scripting_enabled");
  var_8758a58e63b7fe1b thread scene::play(undefined, "idle");
  flag_wait("flg_park_stealth_done");
  var_8758a58e63b7fe1b scene::stop();
  level notify("audio_dog_setup_end");
}

function function_a7fccf73a0607228(e_dog, str_flag) {
  level notify("audio_dog_interact_started");
  scene::play(undefined, "plr_interact");
  level flag_set(str_flag);
  e_dog.team = "allies";
  e_dog.name = "Riley";
}

function function_ab9cf7d3daae04fa(var_bab2d71dccda7436) {
  var_8758a58e63b7fe1b = getStruct("scene_jup_surge_0190_park_pet", "targetname");
  var_8758a58e63b7fe1b thread scene::play(undefined, "idle");
  level.dog = var_8758a58e63b7fe1b scene::get_entity("dog");
  level.dog.team = "allies";
  level.dog thread namespace_85a51fd192b9a590::function_a91261b17ab0252f();

  if(isDefined(var_bab2d71dccda7436)) {
    flag_wait(var_bab2d71dccda7436);
    var_8758a58e63b7fe1b scene::stop();

    if(isDefined(level.dog)) {
      level.dog delete();
    }
  }
}

function function_9c811b19afc44813() {}

function function_cb6f8f2df226f496() {
  function_123c15b9c0463d22("cctv_rewind_scene_1");
}

function function_cb6f902df226f6c9() {
  level.var_c9788dc58ee12aca = getStruct("jup_surge_0280_street_cctv_civilians", "targetname");
  level.var_de984c505c7586f = getStruct("jup_surge_0280_street_cctv_vehicles", "targetname");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_e45ac94927cc7a6d, "car01");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_e45ac94927cc7a6d, "car02");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car03");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car04");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car05");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car06");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car07");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_4fdee4e4c1a6ce64, "car08");
  level.var_de984c505c7586f scene::add_spawn_function(&namespace_85a51fd192b9a590::function_bf738267dd44f324, "car09");
  level.var_c9788dc58ee12aca thread scene::play(undefined, undefined, undefined, 0.35);
  level.var_de984c505c7586f thread scene::play(undefined, undefined, undefined, 0.35);
  flag_wait("end_cctv02_scene");
  level.var_c9788dc58ee12aca scene::stop();
  level.var_de984c505c7586f scene::stop();
}

function function_cb6f8d2df226f030() {
  hideout_gate = getEnt("jup_surge_hideout_showdown_gate", "targetname");
  hideout_gate hide();
  function_123c15b9c0463d22("cctv_rewind_civilians", "cctv_rewind_vehicles");
  var_9677e661912fa552 = level.var_c9788dc58ee12aca;
  var_9677e661912fa552 scene::init();
  level.var_dca0d204a160d002 = var_9677e661912fa552 scene::get_entity("target");
  flag_wait("flg_end_scene_202");
  function_452314cba17d863b();
  flag_set("cctv_rewind_1_done");
  hideout_gate show();
}

function function_cb6f8e2df226f263() {
  level endon("game_ended");
  flag_wait("cctv_rewind_1_done");
  function_123c15b9c0463d22("cctv_rewind_scene_4");
  var_7867f58e589b8d62 = getStruct("jup_surge_0280_street_cctv04", "targetname");
  var_7867f58e589b8d62 thread scene::play();
  level.var_7d7f0b9f883c729c = 0.225;

  while(level.var_7d7f0b9f883c729c <= 0.92) {
    waitframe();
  }

  flag_set("flag_target_entered_hideout");
  wait 2;
  function_452314cba17d863b();
}

function function_78f2424a5f74e493() {
  var_8ebb5f805feaa0c4 = getStruct("jup_surge_0280_street_cctv03_loop", "targetname");
  var_8ebb5f805feaa0c4 thread scene::play();
}

function function_cb6b292df2221e6d() {
  var_785b028e588d9574 = getStruct("scene_jup_surge_0230_street_target_enter", "targetname");
  var_785b028e588d9574 scene::play(level.ai_target, "enter");
  level flag_set("scene_0230_done");
}

function function_4890485a43912e5b() {}

function function_95b92e88851f75ae() {
  showcinematicletterboxing(0, 0);
  var_6b8bd98e4fc924c4 = getStruct("scene_jup_surge_0300_hideout_showdown", "targetname");
  var_160ae94e252b3cdc = getStruct("scene_jup_surge_0300_hideout_showdown_ghost", "targetname");
  var_c507d543c89341c = getStruct("s_start_hideout_intro_teleport", "targetname");
  var_7eb56c05d60c0d1a = var_6b8bd98e4fc924c4.origin;
  var_478fe830b0125302 = var_160ae94e252b3cdc.origin;
  var_6b8bd98e4fc924c4 scene::pre_stream();
  hideout_gate = getEnt("jup_surge_hideout_showdown_gate", "targetname");
  hideout_gate.animname = "hideout_gate";
  level.player hideviewmodel();
  thread function_d6c0f8679aea277f();
  level thread namespace_85a51fd192b9a590::function_99852192d1d4e1ee();
  autosave_by_name();
  var_6b8bd98e4fc924c4.origin = var_478fe830b0125302;
  var_6b8bd98e4fc924c4 scene::play(level.ai_ghost, "sh010", "scene_jup_surge_0300_hideout_showdown");
  var_6b8bd98e4fc924c4.origin = var_7eb56c05d60c0d1a;
  function_7dcc5e04ab79399b(["jup_surge_city_park_tr"]);
  delaythread(10, &function_da7a442dfd5f9958);
  var_6b8bd98e4fc924c4 scene::play(hideout_gate, ["sh020", "sh030"]);
  var_6b8bd98e4fc924c4 thread function_7bee4cf8f3203f8();
  var_90130ef798ea70ef = var_6b8bd98e4fc924c4 scene::function_d9be975d8d1c9db3("sh040");
  thread function_e0954f826c294968(var_90130ef798ea70ef);
  var_6b8bd98e4fc924c4 scene::play(hideout_gate, "sh040");
  level.player unlink();
  level.player showviewmodel();
  flag_set("flag_scene_0300_player_entered_gate_complete");
  var_6b8bd98e4fc924c4 thread function_55d10412e9c53372();
}

function function_55d10412e9c53372() {
  police_car = scene::get_entity("police_car");
  jltv_01 = scene::get_entity("jltv_01");
  jltv_02 = scene::get_entity("jltv_02");
  flag_wait("flg_hideout_cqc_hallway_advance_2_skip");

  if(isDefined(police_car)) {
    police_car delete();
  }

  if(isDefined(jltv_01)) {
    jltv_01 delete();
  }

  if(isDefined(jltv_02)) {
    jltv_02 delete();
  }
}

function function_d6c0f8679aea277f() {
  setomnvar("ui_cctv_active", 0);
  wait 0.15;
  thread function_ef9fa613f23d50ec();
  wait 0.1;
}

function function_ef9fa613f23d50ec() {
  if(flag("cctv_enable_camera")) {
    var_a89e5cce10fb8fe3 = getStructArray("s_start_hideout_intro", "targetname");

    if(var_a89e5cce10fb8fe3.size > 1) {
      foreach(s_start_hideout_intro in var_a89e5cce10fb8fe3) {
        if(s_start_hideout_intro.script_noteworthy == "player") {
          var_379e0c9e767eeaa6 = s_start_hideout_intro;
        }
      }
    } else {
      var_379e0c9e767eeaa6 = var_a89e5cce10fb8fe3[0];
    }

    level.player freezecontrols(1);
    flag_clear("cctv_enable_camera");
    flag_set("cctv_end");
    level.player unlink();
    level.player dontinterpolate();
    level.player lerpfovscalefactor(1, 0);
    level.player teleport_player(var_379e0c9e767eeaa6);
    level.player clearsoundsubmix("surg_cctv_mix");
    level.player playSound("surge_cctv_stop");
    level.player thread namespace_ced163a8b0e3e1ba::cctv_camera_look_speed(0);
    level.player modifybasefov(65, 2);
    visionsetnaked("", 0);
    thread namespace_ced163a8b0e3e1ba::function_9246006fb1dba7d4();
    setsaveddvar(@ "hash_7f682bcfe7bf6600", ter_op(isDefined(level.var_ce6c2a5a52b1fc4b), level.var_ce6c2a5a52b1fc4b, 100));
    level.player notifyonplayercommandremove("cctv_scan_face", "+activate");
    level.player notifyonplayercommandremove("cctv_scan_face_pad", "+usereload");
    level.player notifyonplayercommandremove("cycle_camera_forward", "+frag");
    level.player notifyonplayercommandremove("cycle_camera_back", "+smoke");
    level.player notifyonplayercommandremove("select_camera", "+weapnext");
    level.player notifyonplayercommandremove("select_camera_pad", "+gostand");
    level.player notifyonplayercommandremove("cctv_stop_scan_face", "-activate");
    level.player notifyonplayercommandremove("cctv_stop_scan_face", "-usereload");
    motion_blur_enable();
    flag_wait("flag_scene_0300_player_entered_gate_complete");
    level.player freezecontrols(0);
    level.player enableweapons();
    level.player showlegsandshadow();
    level.player allowprone(1);
    level.player allowcrouch(1);
    level.player.ignoreme = 0;
    level.player scripts\sp\player::allow_player_weapon_info(0);
  }
}

function function_7bee4cf8f3203f8() {
  var_34da6b83b14273eb = scene::get_entities();
  var_516ff48dede38fa1 = ["igc_300_price", "hideout_gate", "police_car", "jltv_01", "jltv_02"];

  foreach(entity in var_34da6b83b14273eb) {
    if(isDefined(entity) && !function_5b7e9a4c946f3a13(entity.animname, var_516ff48dede38fa1)) {
      entity delete();
    }
  }
}

function function_e0954f826c294968(waittime) {
  wait waittime - 2;
  hidecinematicletterboxing(1.5, 0);
}

function function_da7a442dfd5f9958() {
  door = getEnt("surge_hideout_door", "targetname");
  door_clip = getEnt("jup_door_clip_hideout_breach", "targetname");
  var_6b905f8e4fce414d = getStruct("scene_jup_surge_0310_hideout_breach", "targetname");
  door_clip movez(128, 0.1);
  wait 0.1;
  door_clip linkTo(door);
  door_clip disconnectPaths();
  var_d645bd0c27461c61 = getspawnerarray("ai_hideout_sfo_interior_1");
  level.ai_hideout_sfo_interior_1 = array_spawn(var_d645bd0c27461c61, 1);
  scene_actors = [];

  foreach(ai in level.ai_hideout_sfo_interior_1) {
    ai.animname = ai.script_noteworthy;
    scene_actors = array_add(scene_actors, ai);
  }

  scene_actors = array_add(scene_actors, door);
  var_6b905f8e4fce414d scene::play(undefined, "enter");
  var_6b905f8e4fce414d thread scene::play(undefined, "idle");

  foreach(ai in level.ai_hideout_sfo_interior_1) {
    if(isDefined(ai) && isalive(ai)) {
      ai function_c1e075c4168a8bea(0, 1);

      if(ai.script_noteworthy == "hideoutally01") {
        ai thread function_16a594417ddabeb1(1, 0);
      } else if(ai.script_noteworthy == "hideoutally02") {
        ai thread function_16a594417ddabeb1(1, 1);
        ai thread function_ddde7369b63b3113();
      } else if(ai.script_noteworthy == "hideoutally03") {
        ai thread function_16a594417ddabeb1(1, 1);
      } else if(ai.script_noteworthy == "hideoutally04") {
        ai thread function_16a594417ddabeb1(1, 0);
      } else if(ai.script_noteworthy == "hideoutally05") {
        ai thread function_16a594417ddabeb1(1, 1);
      } else if(ai.script_noteworthy == "hideoutally06") {
        ai thread function_16a594417ddabeb1(1, 1);
      }

      if(!issubstr(ai.classname, "jup_ally_uk_police")) {
        ai thread function_ddde7369b63b3113();
      }

      ai thread function_94b3d4076f1146ab();
    }
  }

  flag_wait_or_timeout("flg_hideout_breach_setup_vo_complete", 40);
  flag_set("breach_start");
  wait 1.5;
  door_clip connectpaths();

  foreach(ai in level.ai_hideout_sfo_interior_1) {
    if(isDefined(ai) && isalive(ai)) {
      ai thread function_3584723028fe3574();
    }
  }

  var_6b905f8e4fce414d thread function_bc54c5fdacb585e3();
  var_6b905f8e4fce414d scene::play(door, "end");
  var_6b905f8e4fce414d thread scene::play(undefined, "end_idle");
  flag_wait("flg_hideout_stairwell_advance");
  var_6b905f8e4fce414d scene::cleanup();
  flag_set("breach_end");

  foreach(ai in level.ai_hideout_sfo_interior_1) {
    if(isDefined(ai) && isalive(ai)) {
      ai function_c1e075c4168a8bea(1, 1);
    }
  }

  flag_wait("flg_hideout_intro_done");
  door solid();
}

function function_bc54c5fdacb585e3() {
  var_52b4ab89758c004b = getnodearray("nd_hideout_sfo_skipto_cqc", "script_noteworthy");
  ally02 = scene::get_entity("hideoutally02");
  wait 8.5;
  ally02 stopanimScripted();
  var_e6627efad15dda76 = getclosestnodeinsight(ally02.origin);
  ally02 setgoalnode(var_e6627efad15dda76);
}

function function_3584723028fe3574() {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hideoutally03") {
    wait 2.7;
    nd_breach = getnode("nd_hideout_breach_ally03", "targetname");

    if(isDefined(nd_breach)) {
      self setgoalnode(nd_breach);
    }

    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hideoutally04") {
    wait 3.8;
    nd_breach = getnode("nd_hideout_breach_ally04", "targetname");

    if(isDefined(nd_breach)) {
      self setgoalnode(nd_breach);
    }

    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hideoutally05") {
    self orientmode("face goal");
    wait 1;
    s_breach = getStruct("s_hideout_breach_ally05", "targetname");

    if(isDefined(s_breach)) {
      thread scripts\sp\spawner::go_to_node(s_breach);
    }
  }
}

function function_da87b62dfd6ea893() {}

function scene_0330() {}

function scene_0340() {
  var_6b7a418e4fb5cc20 = getStruct("scene_jup_surge_0340_hideout_plan_reveal", "targetname");
  var_9eda11961efba476 = getStruct("scene_jup_surge_0340_hideout_plan_reveal_cctv01", "targetname");
  e_hideout_plan_reveal_laptop_pre_igc = getEnt("e_hideout_plan_reveal_laptop_pre_igc", "targetname");
  e_hideout_plan_reveal_laptop_top_pre_igc = getEnt("e_hideout_plan_reveal_laptop_top_pre_igc", "targetname");
  e_hideout_plan_reveal_laptop_pre_igc hide();
  e_hideout_plan_reveal_laptop_top_pre_igc hide();
  var_6b7a418e4fb5cc20 thread scene::play([level.var_d18d63c6d75cd1e], "scene_gaz");
  var_6b7a418e4fb5cc20 thread scene::play([level.ai_soap], "scene_soap");
  var_6b7a418e4fb5cc20 thread scene::play(undefined, "laptop_open");
}

function function_869936d980d8156a() {
  registered = "hideout_usb";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  var_6b7a418e4fb5cc20 = getStruct("scene_jup_surge_0340_hideout_plan_reveal", "targetname");
  var_9eda11961efba476 = getStruct("scene_jup_surge_0340_hideout_plan_reveal_cctv01", "targetname");
  var_9eda10961efba243 = getStruct("scene_jup_surge_0340_hideout_plan_reveal_cctv02", "targetname");
  var_9eda0f961efba010 = getStruct("scene_jup_surge_0340_hideout_plan_reveal_cctv03", "targetname");
  thread function_146295a1d631d44();
  var_6b7a418e4fb5cc20 thread scene::play([level.var_d18d63c6d75cd1e, level.ai_soap], "laptop_interact");
  wait 4.9;
  wait 1;
  level thread namespace_85a51fd192b9a590::function_fefb488747b65ddd();
  level thread namespace_85a51fd192b9a590::function_cfaed15dafc0d676();
  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  wait 0.5;
  level.player thread scripts\sp\hud_util::fade_in(0.5, "black");
  level thread function_98ba421762a73b3b();
  level waittill("skippable_cinematic_done");
  level flag_set("scene_0340_cctv_done");
  visionsetnaked("", 0);
}

function function_146295a1d631d44() {
  wait 4.6;
  var_2eda2be8546dadd6 = 0;
  var_ea1e6a586be81a36 = 1;
  level play_skippable_cinematic("sp_jup_surge_b_cine", undefined, undefined, var_2eda2be8546dadd6, var_ea1e6a586be81a36);
}

function function_59460a9e6c862035() {
  flag_wait("flg_hideout_finale_start");
  e_hideout_plan_reveal_laptop_pre_igc = getEnt("e_hideout_plan_reveal_laptop_pre_igc", "targetname");
  e_hideout_plan_reveal_laptop_top_pre_igc = getEnt("e_hideout_plan_reveal_laptop_top_pre_igc", "targetname");
  e_hideout_plan_reveal_laptop_pre_igc hide();
  e_hideout_plan_reveal_laptop_top_pre_igc hide();
  var_6b7a418e4fb5cc20 = getStruct("scene_jup_surge_0340_hideout_plan_reveal", "targetname");
  var_6b7a418e4fb5cc20 scene::play(undefined, "laptop_open");
}

function function_98ba421762a73b3b() {
  level endon("skippable_cinematic_done");
  var_c8a117fa7a96c085 = function_20481d652e9a859a("sp_jup_surge_b_cine");
  wait var_c8a117fa7a96c085 - 2.4;
  level.player scripts\sp\hud_util::fade_out(0.5, "black");
}

function function_3b2dcb215a17b132(var_46a738a8167e99b5) {
  showcinematicletterboxing(0, 0);
  level flag_wait("flg_init_allies_spawned");
  level.player hideviewmodel();
  level.var_5c7c9e8e448b6379 = getStruct("scene_jup_surge_0400_chunnel_intro", "targetname");
  level.var_5c7c9e8e448b6379 scene::init([level.ai_soap, level.var_d18d63c6d75cd1e]);
  ghost = level.var_5c7c9e8e448b6379 scene::get_entity("ghost");
  price = level.var_5c7c9e8e448b6379 scene::get_entity("price_chunnel_intro");
  player_start = level.var_5c7c9e8e448b6379 scene::get_entity("price_chunnel_intro");
  var_d030c1f755e70bb = level.var_5c7c9e8e448b6379 scene::get_entity("chunnel_sfo01");
  actors = [price, level.ai_soap, level.var_d18d63c6d75cd1e, ghost];
  level.var_5c7c9e8e448b6379 scene::pre_stream(actors, undefined, -1);
  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  wait 2;
  level.player thread scripts\sp\hud_util::fade_in(2, "black");
  price gun_remove();
  price_gun = make_weapon("jup_jp04_sm_umike_sp", ["jup_umike_rec", "jup_jp04_sm_umike_bar", "jup_jp04_sm_umike_stock_folding", "jup_jp04_sm_umike_mag_30_45acp", "jup_reflex02_tall", "jup_silencer_sm_05", "jup_jp04_sm_umike_pgrip_tac", "grip_vert01", "lasercyl_ads01"]);
  price scripts\anim\shared::forceuseweapon(price_gun, "primary");
  var_d030c1f755e70bb function_16a594417ddabeb1(1, 0);
  thread function_66963a5ed3c75b61();
  level notify("audio_chunnel_post_cctv_amb_duck");
  level thread namespace_85a51fd192b9a590::function_1cf5c48c5eadd2eb();
  level.var_5c7c9e8e448b6379 scene::pre_stream(actors, undefined, 0.1);
  level.var_5c7c9e8e448b6379 scene::play(actors);
  level.player teleport_player(player_start);
  level flag_set("scene_0400_igc_done");
  level.player showviewmodel();
  level.var_5c7c9e8e448b6379 thread function_d378cacd2071d2d0();
}

function function_d378cacd2071d2d0() {
  jltv_01 = scene::get_entity("truck");
  jltv_02 = scene::get_entity("truck02");
  flag_wait("flg_chunnel_intro_track_start");

  if(isDefined(jltv_01)) {
    jltv_01 delete();
  }

  if(isDefined(jltv_02)) {
    jltv_02 delete();
  }
}

function function_e2414b697919b02a() {
  actor_price = level.var_5c7c9e8e448b6379 scene::get_entity("price_chunnel_intro");
  level.var_5c7c9e8e448b6379 scene::function_8207074e79f22926(self, "delete_price", "price_chunnel_intro");
  level waittill("delete_price");
  actor_price delete();
}

function function_66963a5ed3c75b61() {
  wait 36.5;
  hidecinematicletterboxing(1.5, 0);
}

function function_e980f32e08943b11() {
  var_5c89b08e44999f94 = getStruct("scene_jup_surge_0450_chunnel_explosion", "targetname");
  var_5c89b08e44999f94 scene::play(undefined, "boom");
}

function scene_0460() {}

function function_e989df2e089e2dc3() {}

function function_e96af52e087c0c44() {}

function scene_0490() {}

function function_2d79fe9272ff0542() {}

function function_772e1a80606fed47() {
  level.var_f7ff086a1f7ecc52 = getStruct("scene_jup_surge_0500_tracks_train01_short", "targetname");
  level.var_f7ff086a1f7ecc52.train_number = 1;
  level.var_f7ff086a1f7ecc52.var_eea1e4a76e9d5815 = 1;
  scene::add_scene_func("jup_surge_0500_tracks_train01_short", &train_setup, "callback_play");
  scene::add_scene_func("jup_surge_0500_tracks_train01_short", &train_cleanup, "callback_done");
  level.var_f7ff086a1f7ecc52 scene::play();
}

function function_23d0e83df014aeaa() {
  level endon("flg_chunnel_diffuse_done");
  level.var_f76b29c280893d5f = getStruct("scene_jup_surge_0500_tracks_train01", "targetname");
  level.var_f76b29c280893d5f.train_number = 1;
  level.var_f76b29c280893d5f function_abee50e7970ed959();
  scene::add_scene_func("jup_surge_0500_tracks_train01", &train_setup, "callback_play");
  scene::add_scene_func("jup_surge_0500_tracks_train01", &train_cleanup, "callback_done");

  while(true) {
    level.var_f76b29c280893d5f waittill("train_start", var_374103a6ca06468e, var_eea1e4a76e9d5815);
    level.var_f76b29c280893d5f scene::play(undefined, undefined, undefined, var_374103a6ca06468e);
    level.var_f76b29c280893d5f notify("train_anim_finished");
  }
}

function function_23d0e73df014ac77() {
  level endon("flg_chunnel_diffuse_done");
  level.var_f76b2ac280893f92 = getStruct("scene_jup_surge_0500_tracks_train02", "targetname");
  level.var_f76b2ac280893f92.train_number = 2;
  level.var_f76b2ac280893f92 function_abee50e7970ed959();
  scene::add_scene_func("jup_surge_0500_tracks_train02", &train_setup, "callback_play");
  scene::add_scene_func("jup_surge_0500_tracks_train02", &train_cleanup, "callback_done");

  while(true) {
    level.var_f76b2ac280893f92 waittill("train_start");
    level.var_f76b2ac280893f92 scene::play();
    level.var_f76b2ac280893f92 notify("train_anim_finished");
  }
}

function train_setup() {
  self endon("train_clean_up");
  level.player endon("death");
  flag_set("train_0" + self.train_number + "_moving");
  waitframe();
  self.var_573c7a1092b362c = scene::get_entities();
  self.var_dc44b039fbe4bcfe = [];
  childthread function_84b6866000c1ce19(self.var_573c7a1092b362c);
  childthread function_8389606a3cec622b();

  foreach(var_a3dd760234cf2c97 in self.var_573c7a1092b362c) {
    var_a3dd760234cf2c97.var_128e748fcc0a6687 = 1;
    var_a3dd760234cf2c97 childthread function_b6bdc8df73d41601();
    var_a3dd760234cf2c97 childthread function_5d2b18ef5d71a9ff(self.train_number);
    var_a3dd760234cf2c97 childthread function_d83d645447201039(self.train_number);
    var_a3dd760234cf2c97 childthread function_bcaf98a4f92ddb1e(self.train_number, self.sound_struct);
    var_a3dd760234cf2c97 childthread function_873785f3e9b08728(self.var_eea1e4a76e9d5815);
    var_a3dd760234cf2c97 childthread function_542e3d64f33f9f13(self);
    var_a3dd760234cf2c97 childthread function_78cf8deaaffdd319(self);
    var_a3dd760234cf2c97 childthread function_e8555b61f020853b();
  }
}

function function_84b6866000c1ce19(var_573c7a1092b362c, var_1fc8a153cf951377) {
  if(!isDefined(var_1fc8a153cf951377)) {
    var_1fc8a153cf951377 = "flg_chunnel_crossover_detonate";
  }

  var_475f70b73d8b2291 = 4096;
  var_ede9eff3383324e0 = 236;
  var_fcc76490599d8dab = "train_0" + self.train_number + "_near_player";
  var_5b15b888c05c96b = "train_0" + self.train_number + "_moving";
  flag_clear(var_fcc76490599d8dab);
  flag_wait(var_5b15b888c05c96b);

  while(flag(var_5b15b888c05c96b)) {
    if(flag(var_1fc8a153cf951377)) {
      return;
    }

    var_2c70d2eeebd6a178 = sortbydistancecullbyradius(var_573c7a1092b362c, level.player.origin, var_475f70b73d8b2291);
    var_e71c536bc724c297 = sortbydistancecullbyradius(var_573c7a1092b362c, level.player.origin, var_ede9eff3383324e0);

    if(var_2c70d2eeebd6a178.size > 0) {
      flag_set(var_fcc76490599d8dab);

      if(var_e71c536bc724c297.size > 0) {
        flag_set("flg_chunnel_player_almost_hit_by_train");
      }
    } else {
      flag_clear(var_fcc76490599d8dab);
    }

    wait 0.5;
  }

  flag_clear(var_fcc76490599d8dab);
  flag_clear("flg_chunnel_player_almost_hit_by_train");
}

function function_542e3d64f33f9f13(var_e6d3976099a5c9cf) {
  flag_clear("train_0" + var_e6d3976099a5c9cf.train_number + "_crossed_safe_point");

  switch (self.animname) {
    case #"hash_ed49946bfff8e78a":
      if(isDefined(var_e6d3976099a5c9cf.var_2c51d63c60938594)) {
        var_9f98575a3b7040db = getStruct(var_e6d3976099a5c9cf.var_2c51d63c60938594, "targetname");

        while(distance2dsquared(self.origin, var_9f98575a3b7040db.origin) > 10000) {
          waitframe();
        }

        flag_set("train_0" + var_e6d3976099a5c9cf.train_number + "_crossed_safe_point");
      }

      break;
    default:
      break;
  }
}

function function_d83d645447201039(train_number) {
  self endon("entitydeleted");

  switch (self.animname) {
    case #"hash_ec69fbee2cad5b9b":
      train_spotlight = getEnt("train_headlight_spot_" + train_number, "targetname");
      train_spotlight linkTo(self, "tag_headlight_le", (0, -30, 0), (0, 0, 0));
      train_spotlight setlightintensity(0.02);
      break;
    default:
      break;
  }
}

function function_bcaf98a4f92ddb1e(train_number, var_33fccf5ea4b74cc3) {
  if(isDefined(var_33fccf5ea4b74cc3)) {
    while(distance2dsquared(self.origin, var_33fccf5ea4b74cc3.origin) > 10000) {
      waitframe();
    }

    var_7d0b56f349adbc65 = var_33fccf5ea4b74cc3.targetname;
  } else {
    var_7d0b56f349adbc65 = "intro_train";
  }

  self endon("entitydeleted");

  switch (var_7d0b56f349adbc65) {
    case #"hash_3eff4899d5abdc98":
      switch (self.animname) {
        case #"hash_ec69fbee2cad5b9b":
          train_spotlight = getEnt("train_headlight_spot_" + train_number, "targetname");
          train_spotlight playSound("evt_surge_chunnel_vent_train_engine");
          break;
        case #"hash_a1733e299633e3f6":
          self playLoopSound("evt_surge_chunnel_vent_train_engine_lp");
          break;
        case #"hash_ed49946bfff8e78a":
          self playSound("evt_surge_chunnel_vent_train_caboose_engine");
          break;
      }

      break;
    default:
      switch (self.animname) {
        case #"hash_ec69fbee2cad5b9b":
          train_spotlight = getEnt("train_headlight_spot_" + train_number, "targetname");
          train_spotlight playSound("evt_surge_chunnel_train_engine");
          break;
        case #"hash_a1733e299633e3f6":
          self playLoopSound("evt_surge_chunnel_train_engine_lp");
          break;
        case #"hash_ed49946bfff8e78a":
          self playSound("evt_surge_chunnel_train_caboose_engine");
          break;
      }

      break;
  }
}

function function_873785f3e9b08728(var_eea1e4a76e9d5815) {
  self endon("entitydeleted");

  if(isDefined(var_eea1e4a76e9d5815) && istrue(var_eea1e4a76e9d5815)) {
    scalemax = 0.175;
    scalemid = 0.14;
    scalemin = 0.0455;
    duration = 0.05;
    scalemaxrange = 800;
    var_a90593f8a59c9972 = 3000;
    scaleminrange = 8000;
  } else {
    scalemax = 0.14;
    scalemid = 0.105;
    scalemin = 0.0105;
    duration = 0.05;
    scalemaxrange = 800;
    var_a90593f8a59c9972 = 3000;
    scaleminrange = 8600;
  }

  switch (self.animname) {
    case #"hash_ec69fbee2cad5b9b":
      exploder("vfx_chunnel_train_falling_dust_1a");
      exploder("vfx_chunnel_train_falling_dust_1");
      self playLoopSound("evt_surge_chunnel_train_rumble_lp");

      while(true) {
        if(flag("flg_player_in_vents")) {
          function_e45e5fd94ec4af36(scalemax * 0.5, scalemid * 0.5, scalemin * 0.5, duration, self.origin, scalemaxrange, var_a90593f8a59c9972, scaleminrange);
        } else {
          function_e45e5fd94ec4af36(scalemax, scalemid, scalemin, duration, self.origin, scalemaxrange, var_a90593f8a59c9972, scaleminrange);
        }

        playrumbleonposition("train_rumble_heavy", self.origin);
        wait 0.05;
      }

      break;
    default:
      while(true) {
        playrumbleonposition("train_rumble_light", self.origin);
        wait 0.05;
      }

      break;
  }
}

function function_78cf8deaaffdd319(var_e6d3976099a5c9cf) {
  switch (self.animname) {
    case #"hash_ec69fbee2cad5b9b":
      while(true) {
        var_eb617ff92acf9479 = getentarrayinradius("vol_train_0" + var_e6d3976099a5c9cf.train_number + "_badplace", "targetname", self.origin, 550);

        foreach(var_73109a06528ab1b9 in var_eb617ff92acf9479) {
          if(!array_contains(var_e6d3976099a5c9cf.var_dc44b039fbe4bcfe, var_73109a06528ab1b9)) {
            var_73109a06528ab1b9 disconnectPaths();
            var_e6d3976099a5c9cf.var_dc44b039fbe4bcfe = array_add(var_e6d3976099a5c9cf.var_dc44b039fbe4bcfe, var_73109a06528ab1b9);
          }
        }

        waitframe();
      }

      break;
    case #"hash_ed49946bfff8e78a":
      var_b182a924b891ae11 = [];

      while(true) {
        var_d9b6ca54ab6391ca = getentarrayinradius("vol_train_0" + var_e6d3976099a5c9cf.train_number + "_badplace", "targetname", self.origin, 550);
        var_48d02c6188e165c = array_difference(var_b182a924b891ae11, var_d9b6ca54ab6391ca);

        foreach(var_73109a06528ab1b9 in var_48d02c6188e165c) {
          var_73109a06528ab1b9 connectpaths();
          var_e6d3976099a5c9cf.var_dc44b039fbe4bcfe = array_remove(var_e6d3976099a5c9cf.var_dc44b039fbe4bcfe, var_73109a06528ab1b9);
        }

        var_b182a924b891ae11 = var_d9b6ca54ab6391ca;
        waitframe();
      }

      break;
    default:
      break;
  }
}

function function_abee50e7970ed959() {
  var_28c0346a61904584 = getEntArray("vol_train_0" + self.train_number + "_badplace", "targetname");

  foreach(var_12cda1b161aa7fc4 in var_28c0346a61904584) {
    var_12cda1b161aa7fc4 connectpaths();
  }
}

function function_e8555b61f020853b() {
  level.player endon("death");
  utility::flag_clear("flg_train_passed_player");

  switch (self.animname) {
    case #"hash_ed49946bfff8e78a":
      while(true) {
        level.player waittill_entity_in_range(self, 1000);
        level.player waittill_entity_out_of_range(self, 1000);
        utility::flag_set("flg_train_passed_player");
      }

      break;
    default:
      break;
  }
}

function train_cleanup() {
  self notify("train_clean_up");
  self endon("entitydeleted");
  flag_clear("train_0" + self.train_number + "_moving");
  waitframe();

  if(flag("disable_autosaves")) {
    flag_clear("disable_autosaves");
  }

  var_573c7a1092b362c = scene::get_entities();

  foreach(var_a3dd760234cf2c97 in var_573c7a1092b362c) {
    var_a3dd760234cf2c97 childthread function_ccb97eb89c292ca9(self.train_number);
    var_a3dd760234cf2c97 childthread function_d8197346c3e5a80e();
  }
}

function function_ccb97eb89c292ca9(train_number) {
  train_spotlight = getEnt("train_headlight_spot_" + train_number, "targetname");
  train_spotlight setlightintensity(0);
  train_spotlight unlink();
}

function function_d8197346c3e5a80e() {
  if(self.animname == "car3") {
    self stoploopsound("evt_surge_chunnel_train_engine_lp");
    self stoploopsound("evt_surge_chunnel_vent_train_engine_lp");
    self stoploopsound("evt_surge_chunnel_train_rumble_lp");
  }
}

function function_dbbf72cf7916990a() {}

function function_34d5d706dd8aeb92() {
  if(!isDefined(level.var_b680f0b90d32078b)) {
    level.var_b680f0b90d32078b = [];
  }

  ai_chunnel_hostage_1 = getspawner("ai_chunnel_hostage_1", "targetname");
  ai_chunnel_hostage_2 = getspawner("ai_chunnel_hostage_2", "targetname");
  ai_chunnel_hostage_taker = getspawner("ai_chunnel_hostage_taker", "targetname");
  ai_chunnel_hostage_1 scripts\engine\sp\utility::add_spawn_function(&function_2c1f2d34b1a2e169);
  ai_chunnel_hostage_2 scripts\engine\sp\utility::add_spawn_function(&function_2c1f2d34b1a2e169, 1);
  ai_chunnel_hostage_taker scripts\engine\sp\utility::add_spawn_function(&function_30533298f5e74ec9);
  level.ai_chunnel_hostage_1 = ai_chunnel_hostage_1 spawn_ai(1);
  level.ai_chunnel_hostage_2 = ai_chunnel_hostage_2 spawn_ai(1);
  level.ai_chunnel_hostage_taker = ai_chunnel_hostage_taker spawn_ai(1);
  level.var_3edf96459054e230 = [level.ai_chunnel_hostage_1, level.ai_chunnel_hostage_2];
  level thread function_31409eb2b2d758f4();
}

function function_31409eb2b2d758f4() {
  level.var_5e17ba895e178c = 0;
  level.var_370ed1f8bb2fac54 = 0;
  level flag_wait("flg_chunnel_crossover_open_door");
  level.var_5e17ba895e178c = undefined;
  level.var_370ed1f8bb2fac54 = undefined;
}

function function_2c1f2d34b1a2e169(var_cea84b689c1af7f1) {
  if(!isDefined(var_cea84b689c1af7f1)) {
    var_cea84b689c1af7f1 = 0;
  }

  self endon("death");
  self endon("entitydeleted");
  self.animname = "hostage";
  self function_b661b022700ba72f("script", 1);
  self function_d5cda8a759cc36bc("relaxed");
  function_89007ae298fb4b15();
  thread function_ba32fe6d2b577e83();
  thread function_80ce055c4cf16f58();
  self.script_pushable = 0;
  self.pushable = 0;
  s_struct = getStruct(self.target, "targetname");
  s_struct thread anim_loop_solo(self, s_struct.animation, "stop_loop");
  str_notify = waittill_any_return("damage_konni", "damage_player", "hostage_taker_killed", "hostage_taker_alerted");

  if(str_notify == "damage_konni") {
    s_struct notify("stop_loop");

    if(var_cea84b689c1af7f1 == 0) {
      str_anim = "jup_surge_0600_chunnel_hostages_bdie_civ01";
    } else {
      str_anim = "jup_surge_0600_chunnel_hostages_bdie_civ02";
    }

    level.var_5e17ba895e178c++;

    switch (level.var_5e17ba895e178c) {
      case 0:
        break;
      case 1:
        flag_set("flg_chunnel_vents_garage_hostage_casualties");
        break;
      case 2:
      default:
        flag_set("flg_chunnel_vents_garage_all_hostages_dead");
        break;
    }

    s_struct anim_single_solo(self, str_anim);
    self.team = "neutral";
    self.allowdeath = 1;
    self.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;
    s_struct thread anim_last_frame_solo(self, str_anim);
    waitframe();
    self kill();
  } else if(str_notify == "damage_player") {
    s_struct notify("stop_loop");

    if(var_cea84b689c1af7f1 == 0) {
      str_anim = "jup_surge_0600_chunnel_hostage_civ_dies_civ01";
    } else {
      str_anim = "jup_surge_0600_chunnel_hostage_civ_dies_civ02";
    }

    s_struct anim_single_solo(self, str_anim);
    self.team = "neutral";
    self.allowdeath = 1;
    self.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;
    s_struct thread anim_last_frame_solo(self, str_anim);
    waitframe();
    self kill();
  } else if(str_notify == "hostage_taker_killed" || str_notify == "hostage_taker_alerted") {
    thread function_d86c5d1f2bbd5f21();
    s_struct notify("stop_loop");

    if(var_cea84b689c1af7f1 == 0) {
      str_anim = "jup_surge_0600_chunnel_hostages_blive_civ01";
    } else {
      str_anim = "jup_surge_0600_chunnel_hostage_enemy_dies_civ02";
    }

    set_allowdeath(1);
    s_struct anim_single_solo(self, str_anim);
    self stopanimScripted();
    self function_d5cda8a759cc36bc("cower");

    while(level.var_370ed1f8bb2fac54 < level.var_b680f0b90d32078b.size) {
      waitframe();
    }

    set_forcegoal();
    self function_d5cda8a759cc36bc("flee");

    if(var_cea84b689c1af7f1 == 0) {
      var_a4378cd9c7704c58 = getnode("nd_garage_hostage_1_final", "targetname");
    } else {
      var_a4378cd9c7704c58 = getnode("nd_garage_hostage_2_final", "targetname");
    }

    self setgoalnode(var_a4378cd9c7704c58);
    function_d45457463f7a8eab(200);
    function_92c056ec351f2f6e(200);
  }

  flag_set("flg_garage_hostage_takers_engaged");
  flag_wait("flg_player_on_train_track");
  self delete();
}

function function_d86c5d1f2bbd5f21() {
  level endon("flg_chunnel_garage_vo_complete");
  self waittill("death");
  level.var_5e17ba895e178c++;

  switch (level.var_5e17ba895e178c) {
    case 0:
      break;
    case 1:
      flag_set("flg_chunnel_vents_garage_hostage_casualties");
      break;
    case 2:
    default:
      flag_set("flg_chunnel_vents_garage_all_hostages_dead");
      break;
  }
}

function function_ba32fe6d2b577e83() {
  self endon("death");
  self endon("entitydeleted");

  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker == level.ai_chunnel_hostage_taker) {
      self notify("damage_konni");
      break;
    }

    if(attacker == level.player) {
      if(amount > 1) {
        self notify("damage_player");
        break;
      }
    }
  }
}

function function_fed6014acdd13b3() {
  self endon("death");
  self endon("entitydeleted");
  flag_wait("stealth_spotted");
  self notify("stealth_spotted");
}

function function_30533298f5e74ec9() {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "hostage_taker";
  set_goal_radius(32);
  self setgoalpos(self.origin, 32);
  self.casualkiller = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.pathenemyfightdist = 0;
  self.fixednode = 1;
  utility::demeanor_override("combat");
  thread function_933bce8b9c0ec8c9();
  thread function_fed6014acdd13b3();
  thread function_91a37530b9d090c6();
  set_allowdeath(0);
  level.var_b680f0b90d32078b = array_add(level.var_b680f0b90d32078b, self);
  s_struct = getStruct(self.target, "targetname");
  s_struct thread anim_loop_solo(self, s_struct.animation, "stop_loop");
  str_notify = waittill_any_return("squad_alert", "damage", "execute_timeout", "bulletwhizby", "stealth_spotted", "explosion", "grenade danger");

  if(str_notify == "execute_timeout") {
    thread function_e3b68fe25176ec61();
    set_allowdeath(1);
    s_struct notify("stop_loop");
    self stopanimScripted();

    if(isDefined(level.ai_chunnel_hostage_2) && isalive(level.ai_chunnel_hostage_2)) {
      e_garage_hostage_2_faketarget = getEnt("e_garage_hostage_2_faketarget", "targetname");
      self.var_abc30858a62a19a = e_garage_hostage_2_faketarget.origin;
      self setentitytarget(e_garage_hostage_2_faketarget);
      wait 0.25;
      self clearentitytarget();
    }

    if(isDefined(level.ai_chunnel_hostage_1) && isalive(level.ai_chunnel_hostage_1)) {
      e_garage_hostage_1_faketarget = getEnt("e_garage_hostage_1_faketarget", "targetname");
      self.var_abc30858a62a19a = e_garage_hostage_1_faketarget.origin;
      wait 1.5;
      self setentitytarget(e_garage_hostage_1_faketarget);
      wait 1.5;

      if(isDefined(self)) {
        self clearentitytarget();
      }
    }

    wait 1.5;
    scripts\stealth\utility::enable_stealth_for_ai(1);
    self.script_stealthgroup = "sg_chunnel_intro_vents_2";
    thread scripts\stealth\enemy::main();
    waitframe();
    nd_chunnel_hostage_taker_final = getnode("nd_chunnel_hostage_taker_final", "targetname");
    self setgoalnode(nd_chunnel_hostage_taker_final);
  } else if(str_notify == "damage") {
    s_struct notify("stop_loop");

    if(isDefined(level.ai_chunnel_hostage_1) && isalive(level.ai_chunnel_hostage_1)) {
      level.ai_chunnel_hostage_1 notify("hostage_taker_killed");
    }

    if(isDefined(level.ai_chunnel_hostage_2) && isalive(level.ai_chunnel_hostage_2)) {
      level.ai_chunnel_hostage_2 notify("hostage_taker_killed");
    }

    level.var_370ed1f8bb2fac54++;
    self dropweapon(self.weapon, "right", 0);
    gun_remove();
    flag_set("flg_garage_hostage_takers_engaged");
    s_struct anim_single_solo(self, "jup_surge_0600_chunnel_hostage_enemy_dies_enemy01");
    self.allowdeath = 1;
    self.deathfunction = &scripts\sp\anim::function_ce450b9957138bd5;
    s_struct thread anim_last_frame_solo(self, "jup_surge_0600_chunnel_hostage_enemy_dies_enemy01");
    waitframe();
    self kill();
  } else if(str_notify == "bulletwhizby" || str_notify == "stealth_spotted" || str_notify == "explosion" || str_notify == "grenade danger") {
    s_struct notify("stop_loop");
    set_allowdeath(1);
    flag_set("flg_garage_hostage_takers_engaged");

    if(isDefined(level.ai_chunnel_hostage_1) && isalive(level.ai_chunnel_hostage_1)) {
      level.ai_chunnel_hostage_1 notify("hostage_taker_alerted");
    }

    if(isDefined(level.ai_chunnel_hostage_2) && isalive(level.ai_chunnel_hostage_2)) {
      level.ai_chunnel_hostage_2 notify("hostage_taker_alerted");
    }

    s_struct anim_single_solo(self, "jup_surge_0600_chunnel_hostages_blive_enemy01");
    set_favoriteenemy(level.player);
    self getenemyinfo(level.player);
  }

  flag_wait("flg_player_on_train_track");
  self delete();
}

function function_91a37530b9d090c6() {
  level endon("flg_crossover_finale_arrived");
  self waittill("death");
  flag_set("flg_garage_hostage_takers_engaged");

  if(isDefined(level.var_370ed1f8bb2fac54)) {
    level.var_370ed1f8bb2fac54++;
  }
}

function function_e3b68fe25176ec61() {
  self waittill("death");

  if(isDefined(level.ai_chunnel_hostage_1) && isalive(level.ai_chunnel_hostage_1)) {
    level.ai_chunnel_hostage_1 notify("hostage_taker_alerted");
  }

  if(isDefined(level.ai_chunnel_hostage_2) && isalive(level.ai_chunnel_hostage_2)) {
    level.ai_chunnel_hostage_2 notify("hostage_taker_killed");
  }
}

function function_933bce8b9c0ec8c9() {
  self endon("death");
  self endon("damage");
  self endon("bullethit");
  self endon("bulletwhizby");
  self endon("entitydeleted");
  var_62b4165bf977e0e8 = 15;
  var_158d4357b41c8ec0 = 0;
  flag_wait("flg_chunnel_intro_garage_01");
  flag_wait_or_timeout("flg_chunnel_garage_hostage_execution_start", 15);
  self notify("execute_timeout");
}

function function_8bad4601f2fcbfe1() {
  level.var_3eeac88e2eaa5fa3 thread scene::play(undefined, "Enter");
  var_f8fdbde6ee9e6d8b = level.var_3eeac88e2eaa5fa3 scene::get_entity("Civilian 1");
  var_f8fdbee6ee9e6fbe = level.var_3eeac88e2eaa5fa3 scene::get_entity("Civilian 2");
  var_f6319aa4c761814b = level.var_3eeac88e2eaa5fa3 scene::get_entity("Enemy PMC");
  waittill_any_ents_array(level.var_b680f0b90d32078b, "damage", "bullethit", "bulletwhizby", "gunshot_teammate", "projectile_impact", "stealth_spotted");
  function_121027a7c75be15a();
  var_f6319aa4c761814b stopanimScripted();
}

function function_ca81c573362bb08d() {
  level.var_3eeac88e2eaa5fa3 scene::play(undefined, "Both_Die");
}

function function_e15a43a6fe94a3bb() {
  level.var_3eeac88e2eaa5fa3 scene::play(undefined, "Both_Live");
}

function function_95cef1dcd31610a2() {
  level.var_3eeac88e2eaa5fa3 scene::play(undefined, "Civ_Dies");
}

function function_38a5f04bfdfa2df0() {
  level.var_3eeac88e2eaa5fa3 scene::play(undefined, "Enemy_Dies");
}

function function_121027a7c75be15a() {
  level.var_3eeac88e2eaa5fa3 scene::play(undefined, "React");
}

function function_e5fa48a822fb67ea() {}

function scene_0900() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 thread function_f8205b034e56a791();
  var_3f858855833ee128 = getStruct("s_chunnel_finale_service_door_light", "targetname");
  var_29672e7bc4270e5e = getStruct("s_chunnel_finale_service_door_light_door_closed", "targetname");
  e_service_door_light = getEnt("e_chunnel_finale_service_door_light", "targetName");
  e_service_door_light moveTo(var_3f858855833ee128.origin, 0.05);
  level.dirty_bomb = getStruct("dirty_bomb_ent", "targetname");
  var_13f0578e0f5cbd02 thread scene::play([level.dirty_bomb], "bomb_idle");

  if(!is_after_start("chunnel_finale")) {
    var_13f0578e0f5cbd02 thread scene::play([level.ai_soap], "scene_enter");
    level flag_wait("flg_start_wave_two");
    var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "scene_loop");
    var_13f0578e0f5cbd02 thread namespace_f43c40f7bcbe17e7::function_504bcda7256bc4bf();
    level flag_wait("flg_start_enter_nags");
    var_13f0578e0f5cbd02 thread namespace_f43c40f7bcbe17e7::function_9081dba75d5595c7();
    level flag_wait("flg_first_bomb_interact_complete");
    var_13f0578e0f5cbd02 thread scene::play([level.ai_soap], "cable_cut_enter");
    var_13f0578e0f5cbd02 scene::play(undefined, "cable_cut_enter_plr");
    level flag_set("flg_cable_cut_enter_complete");
    var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_loop");
    level flag_wait("flg_start_third_fight");
    var_13f0578e0f5cbd02 thread namespace_f43c40f7bcbe17e7::function_f1a20db8bdb4e9d3();
    var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_loop");
    var_13f0578e0f5cbd02 thread scene::play(undefined, "snakecam_on_floor");
    level flag_wait("flag_chunnel_finale_wave_3_dead");
    var_13f0578e0f5cbd02 thread namespace_f43c40f7bcbe17e7::function_9081dca75d5597fa();
    level flag_wait("flg_third_bomb_interact_complete");
    var_13f0578e0f5cbd02 scene::play(undefined, "alt_cc_enter_plr");
    level flag_set("flg_alt_enter_2_complete");
  }

  level flag_wait("flg_chunnel_diffuse_done");
  level.player lerpfovscalefactor(0, 0);
  level flag_wait_all("flg_fight_scene_enemies_ready", "flg_fight_scene_ai_ready");
  thread function_cfd935504ff32edc();
  var_13f0578e0f5cbd02 thread scene::play([level.dirty_bomb], "bomb_outro_idle");
  var_2fb7e344a609a7e3 = make_weapon("iw9_pi_golf18_sp");
  level.var_85e0e3c0d71ec871 scripts\anim\shared::forceuseweapon(var_2fb7e344a609a7e3, "primary");
  level thread function_571c95da552c2ca5();
  var_13f0578e0f5cbd02 thread function_737fa062c38d4301();
  flag_wait("flg_door_closed");
  e_service_door_light moveTo(var_29672e7bc4270e5e.origin, 0.05);
}

function function_737fa062c38d4301() {
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "gaz_ghost_callouts", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "magic_bullet_note", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "end", "gaz");
  scene::function_8207074e79f22926(level.player, "soap_dead_pos", "plr");
  scene::function_8207074e79f22926(level.outro_konni3, "end", "outro_konni3");
  scene::function_8207074e79f22926(level.outro_konni4, "end", "outro_konni4");
  scene::function_8207074e79f22926(level.outro_konni1, "end", "outro_konni1");
  scene::function_8207074e79f22926(level.outro_konni2, "end", "outro_konni2");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "makarov_found_them", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "defuse_fight_mak_hand_crush", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "makarov_speech", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "makarov_stabbed", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "mak_muz_flash", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "konni_call_out", "makarov");
  scene::function_8207074e79f22926(level.var_85e0e3c0d71ec871, "end", "makarov");
  scene::function_8207074e79f22926(level.ai_soap, "soap_line_cut_off", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "soap_chest_shot", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "defuse_soap_end", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "end", "soap");
  scene::function_8207074e79f22926(level.player, "cable_exit_complete", "plr");
  scene::function_8207074e79f22926(level.player, "plr_take_damage_during_fight", "plr");
  scene::function_8207074e79f22926(level.player, "plr_kicked_in_face", "plr");
  scene::function_8207074e79f22926(level.player, "hide_fight_letterbox", "plr");
  scene::function_8207074e79f22926(level.player, "plr_fight_end", "plr");
  thread function_5d5ef4127aa3f62b();
  level.var_85e0e3c0d71ec871.fixednode = 0;
  level.var_d18d63c6d75cd1e.fixednode = 0;
  level.ai_ghost.fixednode = 0;
  thread scene::play([level.ai_soap, level.ai_ghost, level.var_d18d63c6d75cd1e, level.var_85e0e3c0d71ec871, level.outro_konni1, level.outro_konni2, level.outro_konni3, level.outro_konni4], "exit_fight_combined");
  thread function_9c133a1840d519a0();
  thread function_e77db6cfb3f0033();
  thread function_c20e8d22addc1877();
  thread function_be472e42e4006410();
}

function function_cfd935504ff32edc() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 thread scene::play(undefined, "wirecutter_idle");
  var_c24a3b6dc1bbda63 = var_13f0578e0f5cbd02 scene::get_entity("wire_cutter");
  level flag_wait("flg_final_defuse_interact_triggered");
  var_c24a3b6dc1bbda63 hide();
}

function door_anims() {
  level.escape_door = getStruct("chunnel_finale_mak_escape_door", "targetname");
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_door", "targetname");
  var_13f0578e0f5cbd02 scene::play(level.escape_door, "door_close", undefined, 0.95);
  flag_wait("flg_chunnel_diffuse_done");
  var_13f0578e0f5cbd02 thread scene::play(level.escape_door, "door_open");
  flag_wait("flg_makarov_gone");
  wait 2;
  var_13f0578e0f5cbd02 scene::play(level.escape_door, "door_close");
  level flag_set("flg_door_closed");
}

function function_b20ae3794c9ab5ec() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 scene::play(undefined, "alt_cc_exit_plr");
}

function function_bfd5aaded7fa179f() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 scene::play(undefined, "alt_cc_interrupt_plr");
  var_13f0578e0f5cbd02 thread scene::play(undefined, "snakecam_on_floor");
}

function function_d04060a5afce9b12() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 scene::play([level.ai_soap, level.dirty_bomb], "soap_first_hit_react");
  var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "scene_loop");
}

function function_9c04ab74e3a428ad() {
  var_13f0578e0f5cbd02 = getStruct("scene_jup_surge_0900_defuse", "targetname");
  var_13f0578e0f5cbd02 scene::play([level.ai_soap, level.dirty_bomb], "soap_loop_hit_react");
  var_13f0578e0f5cbd02 thread scene::play([level.ai_soap, level.dirty_bomb], "cable_cut_loop");
}

function function_70cc7dd2f48f07e0(nag_scene, loop_scene, var_25bb31250ec8bb20, var_46fcc804438d934e, actors) {
  animnode = self;
  animnode thread scene::play(actors, loop_scene);

  switch (nag_scene) {
    case #"hash_2cc285fcc11e77f2":
      nag_list = ["scene_nag05", "scene_nag06"];
      var_7582e4ad58d054ba = [5, 1];
      thread namespace_f43c40f7bcbe17e7::function_9081dba75d5595c7();
      break;
    case #"hash_dcc1eaddf44ca0b5":
      nag_list = ["nag6", "nag7"];
      var_7582e4ad58d054ba = [3, 3];
      thread namespace_f43c40f7bcbe17e7::function_e7f1c451b53b8ad2();
      break;
    case #"hash_850c84fcd92c67a9":
      nag_list = ["scene_nag2"];
      var_7582e4ad58d054ba = [5];
      thread namespace_f43c40f7bcbe17e7::function_be9033d931c1127e();
      break;
    default:
      nag_list = [];
      var_7582e4ad58d054ba = [];
      var_8bc3bfa55434e2e3 = [];
      break;
  }

  animnode thread function_3703746c6c2f46bf(nag_scene, var_25bb31250ec8bb20, nag_list, actors, var_7582e4ad58d054ba);
}

function function_3703746c6c2f46bf(nag_scene, var_25bb31250ec8bb20, nag_list, actors, var_7582e4ad58d054ba) {
  animnode = self;

  foreach(actor in actors) {
    actor endon(var_25bb31250ec8bb20);
  }

  if(flag(var_25bb31250ec8bb20)) {
    return;
  }

  nag_count = 0;
  num_nags = nag_list.size;
}

function function_9c133a1840d519a0() {
  level.player.ignoreme = 1;
  level.player scripts\sp\player::remove_all_armor();
  level.player.var_e72d7bb4acd9a5d1 = level.player.offhandinventory;
  level.player.var_6f9e2ec2ceae61d8 = [];

  foreach(offhand in level.player.var_e72d7bb4acd9a5d1) {
    level.player.var_6f9e2ec2ceae61d8[offhand.basename] = level.player getweaponammostock(offhand);
  }

  level.player function_6078d3c20d55c620(1);
  battlechatter_off("allies");
  equiplist = level.player.var_e72d7bb4acd9a5d1;

  foreach(weapon in equiplist) {
    level.player give_offhand(weapon.basename, level.player.var_6f9e2ec2ceae61d8[weapon.basename]);
  }

  level.player waittill("cable_exit_complete");
  level flag_set("flg_cable_cut_scene_complete");
  level thread namespace_85a51fd192b9a590::function_6ec4e95f104d9902();
  level.player waittill("plr_take_damage_during_fight");
  level.player dodamage(20, level.var_85e0e3c0d71ec871.origin, level.var_85e0e3c0d71ec871, level.var_85e0e3c0d71ec871, "MOD_PISTOL_BULLET", level.var_85e0e3c0d71ec871.currentprimaryweapon, "left_arm_upper");
  level.player thread scripts\sp\player::bloodoverlay(0.5, 3, 2);
  level.player waittill("plr_kicked_in_face");
  level.player dodamage(50, level.var_85e0e3c0d71ec871.origin, level.var_85e0e3c0d71ec871, level.var_85e0e3c0d71ec871, "MOD_MELEE", level.var_85e0e3c0d71ec871.meleeweapon, "head");
  level.player thread scripts\sp\player::bloodoverlay(0.3, 3, 5);
  thread function_69c495bbbd136af1();
  level thread namespace_85a51fd192b9a590::function_77dfe79e4f33c2f3();
  level.player waittill("hide_fight_letterbox");
  delaythread(2.5, &autosave_now);
  hidecinematicletterboxing(1.5, 0);
  level.player lerpfovscalefactor(1, 0);
  var_75474eb144d63609 = level.player spawn_tag_origin();
  var_75474eb144d63609 rotateby((0, -62, 0), 0.1);
  level.player waittill("soap_dead_pos");
  var_3a465e75b646f5d4 = getStruct("scene_jup_surge_1000_chunnel_outro", "targetname");
  var_3a465e75b646f5d4 thread scene::play([level.ai_soap], "soap_death_pose");
  level flag_set("flg_soap_dead_pos_handled");
  level.player waittill("plr_fight_end");
  level.player teleport_player(var_75474eb144d63609);
  waitframe();
  level.player clearcinematicmotionoverride();
  level flag_set("flg_plr_fight_complete");
  level flag_set("flg_0900_scene_done");
}

function function_69c495bbbd136af1() {
  visionsetnaked("sp_jup_surge_chunnel_end_vignette", 0.1);
  level flag_wait("flg_soap_died");
  visionsetnaked("");
}

function function_c20e8d22addc1877() {
  level.var_85e0e3c0d71ec871 waittill("makarov_found_them");
  thread namespace_f43c40f7bcbe17e7::function_ca3c3c9efac4f12();
  level.var_85e0e3c0d71ec871 waittill("makarov_stabbed");
  level.var_85e0e3c0d71ec871 setModel("body_c_jup_sp_villain_makarov_shirt_blood");
  level.var_85e0e3c0d71ec871 detach(level.var_85e0e3c0d71ec871.headmodel);
  level.var_85e0e3c0d71ec871 attach("c_jup_head_hero_makarov_shirt_blood", "", 1);
  level.var_85e0e3c0d71ec871.headmodel = "c_jup_head_hero_makarov_shirt_blood";
  level.var_85e0e3c0d71ec871 waittill("mak_muz_flash");
  var_48420fae1af6a838 = spawn_tag_origin();

  if(isDefined(level.var_85e0e3c0d71ec871)) {
    playFXOnTag(level._effect["vfx_outro_pistol_muzzleflash"], level.var_85e0e3c0d71ec871, "tag_accessory_right");
  }

  level.var_85e0e3c0d71ec871 waittill("end");
  thread function_92289e618d44ad44();
  level.var_85e0e3c0d71ec871 set_goalRadius(32);
  level.var_85e0e3c0d71ec871.allowstrafe = 0;
  level.var_85e0e3c0d71ec871 disable_pain();
  var_6f1e37352fa2ce2a = getnode("nd_chunnel_mak_path_start", "targetname");
  level.var_85e0e3c0d71ec871 thread scripts\sp\spawner::go_to_node(var_6f1e37352fa2ce2a);
}

function function_e77db6cfb3f0033() {
  soap_knife = level.ai_soap scripts\common\anim::anim_link_tag_model("parts_jup_knife_diver_weapon", "tag_accessory_left");
  level.ai_soap waittill("soap_line_cut_off");
  level.ai_soap dialogue::stop_dialogue(1, 1);
  level.ai_soap waittill("soap_chest_shot");
  level.ai_soap setModel("body_c_jup_sp_hero_soap_expired");
  level.ai_soap waittill("defuse_soap_end");
  level.var_f76b29c280893d5f notify("end_train_loop");
  level flag_set("flg_soap_died");
  level.ai_soap detach(level.ai_soap.headmodel);
  level.ai_soap attach("head_c_jup_sp_hero_soap_expired", "", 1);
  level.ai_soap.headmodel = "head_c_jup_sp_hero_soap_expired";
  level.ai_soap waittill("end");
  soap_knife hide();

  if(!flag("flg_gaz_ghost_fight_complete")) {
    thread scene::play([level.ai_soap], "soap_dead");
  }

  level.ai_soap set_name("");
  level.ai_soap.callsign = undefined;
}

function function_be472e42e4006410() {
  level.var_d18d63c6d75cd1e waittill("gaz_ghost_callouts");
  level.var_d18d63c6d75cd1e waittill("magic_bullet_note");
  level flag_set("flg_magic_bullet_start");
  level.var_d18d63c6d75cd1e waittill("end");
  level flag_set("flg_gaz_ghost_fight_complete");
  n_chunnel_finale_gaz_post = getnode("n_chunnel_finale_gaz_post", "targetname");
  n_chunnel_finale_ghost_post = getnode("n_chunnel_finale_ghost_post", "targetname");
  level.var_d18d63c6d75cd1e forceteleport(n_chunnel_finale_gaz_post.origin, n_chunnel_finale_gaz_post.angles, 1000, 1);
  level.var_d18d63c6d75cd1e setgoalnode(n_chunnel_finale_gaz_post);
  level.ai_ghost forceteleport(n_chunnel_finale_ghost_post.origin, n_chunnel_finale_ghost_post.angles, 1000, 1);
  level.ai_ghost setgoalnode(n_chunnel_finale_ghost_post);
  e_finale_ghost_cover = getEnt("e_finale_ghost_cover", "targetname");
  var_3c9733f42dcb17df = getEntArray("e_finale_ghost_cover_piece", "targetname");

  foreach(e_finale_ghost_cover_piece in var_3c9733f42dcb17df) {
    e_finale_ghost_cover_piece linkTo(e_finale_ghost_cover);
  }

  s_chunnel_finale_ghost_cover_ref = getStruct("s_chunnel_finale_ghost_cover_ref", "targetname");
  e_finale_ghost_cover moveTo(s_chunnel_finale_ghost_cover_ref.origin, 0.5);
  level flag_wait("flg_soap_dead_pos_handled");
  level thread function_64746350130278();
  wait 0.75;
  function_5c7d06f3485967e8();
}

function function_5d5ef4127aa3f62b() {
  if(isDefined(level.outro_konni1)) {
    level.outro_konni1 thread function_cdf46b9810b31846(18, 12, "SMG");
    level.outro_konni1 thread function_88efefe2dc031539(0, 0);
  }

  if(isDefined(level.outro_konni2)) {
    level.outro_konni2 thread function_cdf46b9810b31846(17, 4, "LMG");
    level.outro_konni2 thread function_88efefe2dc031539(0, 0);
  }

  if(isDefined(level.outro_konni3)) {
    level.outro_konni3 thread function_88efefe2dc031539(0, 0);
  }

  if(isDefined(level.outro_konni4)) {
    level.outro_konni4 thread function_cdf46b9810b31846(19, 8, "AR");
    level.outro_konni4 thread function_88efefe2dc031539(0, 0);
  }
}

function function_88efefe2dc031539(f_delay, var_8882a2b18276fbf) {
  if(var_8882a2b18276fbf == 1) {
    self.fixednode = 0;
    self setgoalpos(self.origin);
    self.goalradius = 32;
  }

  self waittill("end");
  wait f_delay;
  self kill();
  self visiblenotsolid();
}

function function_92289e618d44ad44() {
  level.var_31ceffc5fc31d2ab = getStruct("scene_jup_surge_0500_tracks_train_finale", "targetname");
  level.var_31ceffc5fc31d2ab.train_number = 3;
  level.var_31ceffc5fc31d2ab.sound_struct = getStruct("s_train_02_sound", "targetname");
  scene::add_scene_func("jup_surge_0500_tracks_train_finale", &train_setup, "callback_play");
  scene::add_scene_func("jup_surge_0500_tracks_train_finale", &train_cleanup, "callback_done");
  level notify("audio_makarov_train_start");
  level.var_31ceffc5fc31d2ab scene::play();
  level flag_set("flg_train_finale_done");
}

function function_1a13b222bbe425fe(price_outro) {
  var_3a465e75b646f5d4 = getStruct("scene_jup_surge_1000_chunnel_outro", "targetname");
  var_3a465e75b646f5d4 scene::pre_stream([level.var_d18d63c6d75cd1e, level.ai_soap, level.ai_ghost, level.dirty_bomb, price_outro], ["sh010", "sh020", "sh030"], -1);
}

function function_5c7d06f3485967e8() {
  var_3a465e75b646f5d4 = getStruct("scene_jup_surge_1000_chunnel_outro", "targetname");
  var_3a465e75b646f5d4 thread function_d46b28f291783463();
  var_3a465e75b646f5d4 thread function_e7141ef3f8d05579();
  var_3a465e75b646f5d4 delaythread(0.1, &function_ed50313d9313e055);
  var_3a465e75b646f5d4 thread scene::play([level.var_d18d63c6d75cd1e], "enter");
  level.var_f76b29c280893d5f scene::stop();
  level.var_d18d63c6d75cd1e waittill("gaz_start_nags_note");
  level flag_set("flg_outro_enter_complete");
  level.var_f76b29c280893d5f.sound_struct = getStruct("s_train_01_sound", "targetname");
  level.var_f76b29c280893d5f thread scene::play();
  level thread namespace_85a51fd192b9a590::function_cee9774af8aa6e9();
  var_3a465e75b646f5d4 thread function_70cc7dd2f48f07e0("1000_first", "loop", "flg_final_defuse_interact_triggered", level.var_d18d63c6d75cd1e, [level.var_d18d63c6d75cd1e, level.ai_soap, level.ai_ghost]);
}

function function_ed50313d9313e055() {
  var_45e0dcdc7772f2d3 = scene::get_entity("gaz_gun");
  var_45e0dcdc7772f2d3 hide();
  level.var_d18d63c6d75cd1e waittill("gaz_gun_swap");
  var_45e0dcdc7772f2d3 show();
  wait 0.8;
  level.var_d18d63c6d75cd1e gun_remove();
}

function function_537e4616fcb30ffb() {
  var_3a465e75b646f5d4 = getStruct("scene_jup_surge_1000_chunnel_outro", "targetname");
  thread function_c413eea07ee984ff();
  level flag_wait("flg_final_defuse_interact_triggered");
  var_3a465e75b646f5d4 thread scene::play([level.var_d18d63c6d75cd1e, level.dirty_bomb], "scene_enter");
  level.var_d18d63c6d75cd1e waittill("bomb_defuse_finale_enter");
  level thread function_c01ae6bb604460df();
  level flag_set("flg_final_scene_enter_complete");
  level.player modifybasefov(53, 2);
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(14, 7);
  thread function_f75865108ed4a9f4();
  level.var_d18d63c6d75cd1e waittill("bomb_defuse_window_start");
  level flag_set("flg_clear_to_defuse_bomb");
  level thread function_89934621f17fe0c();
  flag_wait_any("flg_play_outro_time", "flag_success_window_missed");

  if(flag("flag_success_window_missed")) {
    flag_set("flag_defusal_fail");
  }

  flag_wait("flg_play_outro_time");
  level.player scripts\sp\player::focusdisable();
  level thread namespace_85a51fd192b9a590::function_168481f8f9fc75();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  thread soap_music();
  var_3a465e75b646f5d4 scene::stop();
  price_outro = var_3a465e75b646f5d4 scene::get_entity("price");
  thread function_1a13b222bbe425fe(price_outro);

  if(isDefined(price_outro)) {
    price_outro detach(price_outro.headmodel);
    price_outro attach("head_hero_price_nohat_blood_lod", "", 1);
    price_outro.headmodel = "head_hero_price_nohat_blood_lod";
    price_outro set_name("");
  }

  level.player lerpfovscalefactor(0, 0);
  level.player enableinvulnerability();
  level thread function_7decc58c8d79efd4();
  function_1158d89007e04047();
  var_3a465e75b646f5d4 scene::play([level.var_d18d63c6d75cd1e, level.ai_soap, level.ai_ghost, level.dirty_bomb], ["sh010"], undefined, 0.001);
  level.player_rig hide();
  var_3a465e75b646f5d4 scene::play([level.var_d18d63c6d75cd1e, level.ai_soap, level.ai_ghost, level.dirty_bomb], ["sh020"], undefined, 0.001);
  var_3a465e75b646f5d4 scene::play([level.var_d18d63c6d75cd1e, level.ai_soap, level.ai_ghost, level.dirty_bomb], ["sh030"], undefined, 0.001);
  level.player lerpfovscalefactor(1, 0);
}

function function_541ca12c694ccfba() {
  while(true) {
    level.player waittill("damage", amount, attacker);
    wait 1;
  }
}

function soap_music() {
  setmusicstate("mx_surge_exfil_end");
  wait 3;
  stopmusicstate("mx_surge_soap");
}

function function_f75865108ed4a9f4() {
  while(!flag("flg_clear_to_defuse_bomb")) {
    if(flag("flg_bomb_defused")) {
      flag_set("flag_defusal_fail");
      break;
    }

    wait 0.5;
  }
}

function function_89934621f17fe0c() {
  level endon("flg_play_outro_time");
  level.var_d18d63c6d75cd1e waittill("fail_player_after_count");
  flag_set("flag_success_window_missed");
}

function function_a44710b577359d3b() {
  showcinematicletterboxing(1, 0);
}

function function_7decc58c8d79efd4() {
  showcinematicletterboxing(1.5, 0);
}

function function_571c95da552c2ca5() {
  registered = "igc_chunnel_fight";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level flag_wait("flg_plr_fight_complete");
  level.player val::set(registered, "show_weapon_hud", 1);
  level.player val::set(registered, "show_hud", 1);
  level.player val::set(registered, "weapon", 1);
  level.player val::set(registered, "freezecontrols", 0);
}

function function_1158d89007e04047() {
  registered = "igc_chunnel_finale";
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
}

function function_c413eea07ee984ff() {
  level flag_wait("flg_outro_enter_complete");
  var_3616f81650fe11b6 = getStruct("s_interact_finale_bomb", "targetname");
  var_3616f81650fe11b6 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_SURGE/FINALE_BOMB", 35, 4000, 100, 0, undefined, undefined, undefined, undefined, undefined, undefined, 180);
  var_3616f81650fe11b6 waittill("trigger");
  registered = "igc_chunnel_defuse_bomb";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level flag_set("flg_final_defuse_interact_triggered");
  level flag_wait("flg_final_scene_enter_complete");
  var_6a5e49b51b7ad9ae = getStruct("s_struct_final_wire_cut", "targetname");
  var_6a5e49b51b7ad9ae scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_SURGE/FINALE_WIRE_CUT", 35, 4000, 100, 1, undefined, undefined, undefined, "duration_none", undefined, undefined, 180);
  var_6a5e49b51b7ad9ae waittill("trigger");
  flag_set("flg_bomb_defused");
  level flag_set("flg_play_outro_time");
}

function function_e7141ef3f8d05579() {
  wait 0.2;
  thread scene::play([level.ai_soap, level.ai_ghost], "ghostSoap_enter");
}

function function_df1c9cb3cf6d20b2(var_25bb31250ec8bb20, line_list, var_985a20dda12c032c) {
  level endon(var_25bb31250ec8bb20);

  if(flag(var_25bb31250ec8bb20)) {
    level flag_set("flg_end_soap_enter_anim");
    return;
  }

  line_count = 0;
  num_lines = line_list.size;
  wait 1;

  while(!flag(var_25bb31250ec8bb20)) {
    if(line_count >= num_lines) {
      break;
    }

    var_985a20dda12c032c[line_count] say_team(line_list[line_count]);
    line_count++;
  }

  level flag_set("flg_end_soap_enter_anim");
}

function function_f8205b034e56a791() {
  scene::function_8207074e79f22926(level.ai_soap, "audio_price_check_it", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "start_wave_two_konni", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "s_note_show_interact", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "defuse_soap_affirm", "soap");
  scene::function_8207074e79f22926(level.ai_soap, "defuse_soap_end", "soap");

  if(!is_after_start("chunnel_finale")) {
    thread namespace_f43c40f7bcbe17e7::function_edcb9b6a1989fdad();
  }

  level flag_wait("flg_chunnel_diffuse_done");
  thread namespace_f43c40f7bcbe17e7::function_ef8381859b661508();
}

function function_d46b28f291783463() {
  scene::function_8207074e79f22926(level.ai_ghost, "ghost_calling_johnny", "ghost");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "gaz_calling_price", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "gaz_gun_swap", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "gaz_start_nags_note", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "bomb_defuse_finale_enter", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "bomb_defuse_window_start", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "fail_player_after_count", "gaz");
  scene::function_8207074e79f22926(level.var_d18d63c6d75cd1e, "outro_price_final_comms", "gaz");
  thread namespace_f43c40f7bcbe17e7::function_b4f901f92a5157d4();
}

function function_76937748c8a5795b() {
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  cinematicingameloop("jup_sp_surge_0137_park_phone_screen ", 1);
  wait 13;
  stopcinematicingame();
  wait 1;
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
}