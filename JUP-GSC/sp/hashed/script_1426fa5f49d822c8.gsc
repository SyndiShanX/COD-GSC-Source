/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1426fa5f49d822c8.gsc
*************************************************/

#using script_2dcc22f11f14cb9;
#using script_389a9d54d8274d2a;
#using script_3ef1b643f06851a8;
#using script_49511723a3204d35;
#using script_654ffaecd1155946;
#using scripts\anim\dialogue;
#using scripts\asm\civilian\script_funcs;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\fakeactor;
#using scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#namespace namespace_8d613d8e5af63184;

function function_780238fe06a47b09() {}

function function_5f33caa564c8cc9c() {
  set_start_location("s_start_park_stealth", array_combine([level.player], level.var_679be75090dd2a47));
  level.player function_8d2c23481bd4016c(0);

  level thread function_c4bed616d3a3036c("<dev string:x1c>");
}

function function_49fc28dbfbaaef37() {
  waitframe();
  transient_load_array(["jup_surge_city_park_tr", "jup_surge_city_periph_tr", "sp_jup_surge_water_tr"]);
}

function function_bff1ad7aec0290c7() {
  level thread function_837bb2142379dbfb("creep");
  level.player allowprone(0);
  level.player allowsupersprint(0);
  level.player val::set("player_speedScalingLogic", "sprint", 1);
  level.player val::set("player_speedScalingLogic", "allow_jump", 0);
  startweapon = make_weapon("iw8_gunless");
  level.player give_weapon(startweapon);
  level.player switchtoweapon(startweapon);
  var_2f7136cf6c5b1b14 = [];
  offhandprecache(var_2f7136cf6c5b1b14);
  scripts\sp\equipment\offhands::function_c7e46ad834e413f("ks_gesture_phone_mp", 0);
}

function function_1d5893b30c552e0d() {
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_95cf17c99337346c();
  level thread namespace_85a51fd192b9a590::function_9c034a6965fbe730();
  level thread function_bff1ad7aec0290c7();
  level thread function_e3a57216f5802c88();
  level thread function_2010f13b637424c8();
  level thread function_fdcadce0aa083a2b();
  level thread function_a23340f45d580cee();
  level thread function_424fc9ed4697bd85();
  level thread function_554254a8f0ee57f0();
  level thread park_music();
  function_9c7e7df0ccb4b7c0();
  level thread function_ab9cf7d3daae04fa("flg_park_cctv_1_start");
  function_5f5f1fbf32f4ef90(1);
  level thread function_5f0b4cbd20240afc();
  flag_wait("flg_intro_done");
}

function park_music() {
  setmusicstate("mx_surge_intro");
}

function function_5f5f1fbf32f4ef90(var_6178616fb710e020) {
  if(isDefined(var_6178616fb710e020) && var_6178616fb710e020 == 1) {
    ai_park_igc_soap_ref = getspawner("ai_park_igc_soap_ref", "targetname");
    ai_park_igc_soap_ref scripts\engine\sp\utility::add_spawn_function(&function_a930207ed379dcc9, "Soap", "flg_park_igc_soap_cleanup", 1);
    level.ai_soap = ai_park_igc_soap_ref spawn_ai(1, 1);
  }

  ai_park_price = getspawner("ai_park_price", "targetname");
  ai_park_price scripts\engine\sp\utility::add_spawn_function(&function_a930207ed379dcc9, "Price", "flg_cctv_3_active", 0);
  level.ai_price = ai_park_price spawn_ai(1, 1);
  level.ai_price.callsign = "Bravo 0-6";
  level.ai_price scripts\common\ai::gun_remove();
  ai_park_gaz = getspawner("ai_park_gaz", "targetname");
  ai_park_gaz scripts\engine\sp\utility::add_spawn_function(&function_a930207ed379dcc9, "Gaz", "flg_park_gaz_delete", 1);
  level.var_d18d63c6d75cd1e = ai_park_gaz spawn_ai(1, 1);
  level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
  flag_set("park_spawn_allies_complete");
}

function function_9c7e7df0ccb4b7c0() {
  level thread function_e179dc089d6a2222("ai_civ_park", "flg_park_stealth_done");
}

function function_5f0b4cbd20240afc() {
  registered = "igc_park";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level.player player::focusdisable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  level thread function_11a71287b86d1e5c();
  level thread function_18ee09d165885c68();
  spawn_hacker(1);
  level thread function_87610c39d187529e();
  delaythread(30, &function_cab089eaa337c908);
  delaythread(32, &function_e179dc089d6a2222, "ai_civ_park_delayed", "flg_park_stealth_done");
  level.player lerpfovscalefactor(0, 1);
  function_562650cee5b48ad3();
  flag_set("flg_intro_done");
  level.player val::set(registered, "show_weapon_hud", 1);
  level.player val::set(registered, "weapon", 1);
  level.player val::set(registered, "freezecontrols", 0);
  level.player player::focusenable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  level.player lerpfovscalefactor(1, 1.5);

  if(isDefined(level.ai_soap)) {
    level.ai_soap hide();
  }
}

function function_18ee09d165885c68() {
  var_9682448e6f12c45c = getStruct("scene_jup_surge_0010_igc_intro", "targetname");
  var_9682448e6f12c45c scene::function_8207074e79f22926(self, "cctv_hud_on", "park_gaz");
  var_9682448e6f12c45c scene::function_8207074e79f22926(self, "cctv_hud_off", "whiskey");
  self waittill("cctv_hud_on");
  utility::flag_set("cctv_enable_camera");
  visionsetnaked("sp_jup_surge_camera_cctv2_letterbox", 0);
  setomnvar("ui_cctv_active", 1);
  setomnvar("ui_cctv_camera_index", 1);
  setomnvar("ui_cctv_zone_index", 1);
  setomnvar("ui_cctv_camera_index", 4);
  self waittill("cctv_hud_off");
  flag_clear("cctv_enable_camera");
  utility::flag_set("cctv_end");
  setomnvar("ui_cctv_active", 0);
  visionsetnaked("", 0);
  level.player modifybasefov(65);
  wait 1;
  utility::flag_clear("cctv_end");
}

function function_17a6747844ea0572() {
  flag_set("flg_intro_done");
}

function function_a9eee0f14f7532ab() {
  level thread function_c6ba32a773682835();
  level thread function_5aa86d2363e5b5bb();
}

function function_9443aa1041a4caa() {}

function function_babb342ff0e219c6() {
  set_start_location("s_start_park_stealth", array_combine([level.player], level.var_679be75090dd2a47));
  level.player function_8d2c23481bd4016c(0);
  level thread function_49fc28dbfbaaef37();
  level thread function_bff1ad7aec0290c7();
  level thread function_e3a57216f5802c88();
  level thread function_9c7e7df0ccb4b7c0();
  level thread function_5f5f1fbf32f4ef90();
  level thread function_2010f13b637424c8();
  level thread function_fdcadce0aa083a2b();
  level thread function_a23340f45d580cee();
  level thread function_424fc9ed4697bd85();
  level thread function_bdcaa0c5e563956a();
  level thread function_554254a8f0ee57f0();
  level thread function_e179dc089d6a2222("ai_civ_park_delayed", "flg_park_stealth_done");
  spawn_hacker(1);
  level thread function_87610c39d187529e();
  nd_hacker_path_1_start_skipto = getnode("nd_hacker_path_1_start_skipto", "targetname");
  level.ai_hacker forceteleport(nd_hacker_path_1_start_skipto.origin, nd_hacker_path_1_start_skipto.angles);
  level.ai_hacker function_2198a1a54be3d161("nd_hacker_path_1_start_skipto");
  thread function_45040b01e83f74e6("flg_park_cctv_1_start");
  thread function_ab9cf7d3daae04fa("flg_park_cctv_1_start");
}

function function_20297f8e1c35f50f() {
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_3b4d555ff8ee0131();
  level thread namespace_85a51fd192b9a590::function_e678c1b9d8a8282f();
  level thread function_bff1ad7aec0290c7();
  level thread function_e3a57216f5802c88();
  level.player.name = "Soap";
  function_a9eee0f14f7532ab();
  level thread function_ea394f5c50f60267();
  autosave_by_name();
  flag_set("flg_park_stealth_begin");
  level thread function_a8f8b681ba867e0c();
  setsaveddvar(@ "hash_51a7ed1edefec42d", 1);
  level thread function_52ed53889cb89845();
  level thread function_b815630233bea7e9();
  level thread namespace_85a51fd192b9a590::function_a73e8acab82e7f57();
  level thread namespace_85a51fd192b9a590::function_8cda09587d813459();
  createnavbadplacebybounds((115.17, 41.827, 1.25), (32, 32, 32), (0, 271.817, 0));
  createnavbadplacebybounds((276.53, 345.53, 0), (32, 32, 32), (0, 2.63178, 0));
  flag_wait_any("flg_park_blended", "flg_park_hacker_exit_early");
  flag_wait("flg_park_whiskey_path_3_started");

  if(!flag("flg_park_meeting_location_known") || !flag("flg_park_flash_drive_known")) {
    flag_wait_or_timeout("flg_park_eavesdrop_fail", 10);
    scripts\sp\player_death::set_custom_death_quote(508);
    missionfailedwrapper();
    wait 1066;
    return;
  }

  if(flag("flg_park_final_blend_in_progress")) {
    while(flag("flg_park_final_blend_in_progress")) {
      wait 0.1;
      iprintln("Waiting for Blend to end");
    }

    wait 1;
  }

  setomnvar("ui_out_of_bounds_countdown", 0);
  wait 4;
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  function_a1d067908e206e63();
  flag_set("flg_park_stealth_done");
  flag_set("flg_hide_park_vehicles");
}

function function_bdcaa0c5e563956a() {
  flag_wait_all("flg_park_blend_tut_start", "flg_park_walkby_allow");
  flag_set("flg_park_blend_walkby_start");
}

function function_52ed53889cb89845() {
  level thread blend_handler("s_park_gaz_interact_ref", &"SP_JUP_SURGE/PARK_BLEND_GAZ", "flg_park_blended", "flg_park_hacker_exit_early", (-10, -10, 2));
  flag_wait("flg_park_whiskey_shoetie_start");
  level thread blend_handler("s_park_blend_dog_ref", &"SP_JUP_SURGE/PARK_BLEND_DOG", "flg_park_blended", "flg_park_hacker_phone_ringing", (10, 0, 12));
  flag_wait("flg_park_hacker_phone_ringing");
  level thread blend_handler("s_park_blend_postcard_kiosk", &"SP_JUP_SURGE/PARK_BLEND_KIOSK", "flg_park_blended", "flg_park_blended_set_3_done", (0, -5, 5));
  level thread blend_handler("s_park_blend_phone_pic", &"SP_JUP_SURGE/PARK_BLEND_PHONE_PIC", "flg_park_blended", "flg_park_blended_set_3_done", (0, 0, 15));
  level thread function_35cfe25af5bc2f19();
  flag_wait("flg_park_blended_set_3_done");
  wait 0.5;
  flag_set("flg_park_blended_set_4_done");
}

function function_ea394f5c50f60267() {
  level endon("flg_park_failed");
  flag_wait("flg_park_whiskey_leave_1");
  level.ai_hacker thread scripts\sp\spawner::go_to_node(getnode("nd_hacker_path_2_start", "targetname"));
  level.ai_hacker lookatentity(level.player, 1);
  level.ai_hacker thread function_273ab66ca3c2923e();
  level thread function_476c5dc8b8f1da3e();
  nd_hacker_path_2_mid = getnode("nd_hacker_path_2_mid", "targetname");
  f_dist = 999;

  while(f_dist > 12) {
    f_dist = distance2d(level.ai_hacker.origin, nd_hacker_path_2_mid.origin);
    wait 0.01;
  }

  flag_set("flg_park_whiskey_shoetie_start");
  level.ai_hacker lookatentity(undefined);
  flag_set("flg_hacker_in_scene");
  scene_0160();
  flag_clear("flg_hacker_in_scene");
  level.ai_hacker lookatentity(level.player, 1);
  waitframe();
  level.ai_hacker thread scripts\sp\spawner::go_to_node(getnode("nd_hacker_path_2_final_stretch", "targetname"));
  flag_clear("flg_park_whiskey_shoetie_start");
  level thread namespace_85a51fd192b9a590::function_13f19307aff9756d();
  nd_hacker_path_2_end = getnode("nd_hacker_path_2_end", "targetname");
  f_dist = 999;

  while(f_dist > 100) {
    f_dist = distance2d(level.ai_hacker.origin, nd_hacker_path_2_end.origin);
    waitframe();
  }

  while(f_dist > 67) {
    f_dist = distance2d(level.ai_hacker.origin, nd_hacker_path_2_end.origin);
    waitframe();
  }

  flag_set("flg_park_whiskey_path_2_arrived");
  hacker_phone = level.ai_hacker scripts\common\anim::anim_link_tag_model("misc_wm_smartphone_civilian_canal", "tag_accessory_right");
  var_fbd0d0807e505a93 = getStruct("s_park_hacker_phonecall_enter", "targetname");
  level.ai_hacker lookatentity(undefined);
  flag_set("flg_hacker_in_scene");
  var_fbd0d0807e505a93 anim_single_solo(level.ai_hacker, "jup_surge_park_target_phone_call_enter");
  var_fbd0d0807e505a93 thread anim_loop_solo(level.ai_hacker, "jup_surge_park_target_phone_call_scene", "stop_loop");
  flag_wait("flg_park_phonecall_done");
  flag_clear("flg_hacker_in_scene");
  var_fbd0d0807e505a93 notify("stop_loop");
  var_1afe5d32b109fb27 = getStruct("s_park_hacker_phonecall_exit", "targetname");
  thread function_7beaa54ad44e500b(var_fbd0d0807e505a93, hacker_phone);
  flag_set("flg_park_whiskey_path_3_started");
  flag_set("flg_park_blended_set_3_done");
  level.ai_hacker thread scripts\sp\spawner::go_to_node(getnode("nd_hacker_path_3_start", "targetname"));
}

function function_476c5dc8b8f1da3e() {
  level endon("flg_park_failed");
  level endon("flg_park_stealth_done");
  var_563875b25d194f9e = getEntArray("tr_park_hidden_set_1", "targetname");
  var_563874b25d194d6b = getEntArray("tr_park_hidden_set_2", "targetname");
  var_563873b25d194b38 = getEntArray("tr_park_hidden_set_3", "targetname");
  var_56387ab25d195a9d = getEntArray("tr_park_hidden_set_4", "targetname");
  var_563879b25d19586a = getEntArray("tr_park_hidden_set_5", "targetname");
  tr_park_hidden_set_post_dog = getEnt("tr_park_hidden_set_post_dog", "targetname");
  tr_park_hacker_los_shoetie = getEnt("tr_park_hacker_los_shoetie", "targetname");
  tr_park_hidden_set_post_dog trigger_off();
  tr_park_hacker_los_shoetie trigger_off();

  foreach(trigger in var_563874b25d194d6b) {
    trigger trigger_off();
  }

  foreach(trigger in var_563873b25d194b38) {
    trigger trigger_off();
  }

  foreach(trigger in var_56387ab25d195a9d) {
    trigger trigger_off();
  }

  foreach(trigger in var_563879b25d19586a) {
    trigger trigger_off();
  }

  flag_wait("flg_park_hacker_hidden_set_2");

  foreach(trigger in var_563874b25d194d6b) {
    trigger trigger_on();
  }

  foreach(trigger in var_563875b25d194f9e) {
    trigger trigger_off();
  }

  if(!flag("flg_park_dont_reset_blend")) {
    flag_clear("flg_park_hidden");
  }

  flag_wait("flg_park_hacker_hidden_set_3");

  foreach(trigger in var_563873b25d194b38) {
    trigger trigger_on();
  }

  foreach(trigger in var_563874b25d194d6b) {
    trigger trigger_off();
  }

  if(!flag("flg_park_dont_reset_blend")) {
    flag_clear("flg_park_hidden");
  }

  flag_wait("flg_park_hacker_hidden_set_4");

  foreach(trigger in var_56387ab25d195a9d) {
    trigger trigger_on();
  }

  foreach(trigger in var_563873b25d194b38) {
    trigger trigger_off();
  }

  if(!flag("flg_park_dont_reset_blend")) {
    flag_clear("flg_park_hidden");
  }

  flag_wait("flg_park_whiskey_path_2_arrived");

  foreach(trigger in var_563879b25d19586a) {
    trigger trigger_on();
  }

  foreach(trigger in var_56387ab25d195a9d) {
    trigger trigger_off();
  }

  if(!flag("flg_park_dont_reset_blend")) {
    flag_clear("flg_park_hidden");
  }
}

function function_7beaa54ad44e500b(var_1afe5d32b109fb27, hacker_phone) {
  var_1afe5d32b109fb27 anim_single_solo(level.ai_hacker, "jup_surge_park_target_phone_call_end");
  hacker_phone delete();
}

function function_87610c39d187529e() {
  s_park_hacker_intro_ref = getStruct("s_park_hacker_intro_ref", "targetname");

  if(scripts\sp\starts::is_after_start("park_igc")) {
    s_park_hacker_intro_ref thread anim_loop_solo(level.ai_hacker, s_park_hacker_intro_ref.animation, "stop_loop");
  }

  wait 2;
  level.ai_hacker function_f51ff412609193b9(1, "script");
  flag_wait("flg_park_stealth_begin");
  s_park_hacker_intro_ref notify("stop_loop");
  level.ai_hacker stopanimScripted();
  level.ai_hacker setgoalpos(level.ai_hacker.origin);
  flag_wait_any("flg_park_blended", "flg_park_hacker_exit_early");

  if(!flag("flg_park_hacker_exit_early")) {
    wait 8;
  }

  level notify("audio_boat_interval_start");
  flag_set("flg_park_whiskey_leave_1");
}

function function_2010f13b637424c8() {
  ai_civ_streets_a_flag = getspawner("ai_civ_streets_a_flag", "targetname");
  ai_civ_streets_a_flag scripts\engine\sp\utility::add_spawn_function(&function_e92e2de5964389c2, undefined, 1);
  ai_civ_streets_a_flag = ai_civ_streets_a_flag spawn_ai(1);
  ai_civ_streets_a_flag function_b661b022700ba72f("script", 1);
  ai_civ_streets_a_flag thread civ_handler(0, "flg_park_stealth_done");
  e_tour_guide_flag = getEnt("e_tour_guide_flag", "targetname");
  e_tour_guide_flag linkTo(ai_civ_streets_a_flag, "j_wrist_ri", (2, -1, 1), (120, 75, 105));
  flag_wait("flg_park_stealth_done");
  e_tour_guide_flag delete();
}

function function_fdcadce0aa083a2b() {
  level.player endon("death");
  ai_civ_park_statue = getspawner("ai_civ_park_statue", "targetname");
  ai_civ_park_statue = ai_civ_park_statue spawn_ai(1);
  ai_civ_park_statue.animname = "generic";
  ai_civ_park_statue function_b661b022700ba72f("script", 1);
  ai_civ_park_statue function_d5cda8a759cc36bc("relaxed");
  ai_civ_park_statue.ignoreme = 1;
  ai_civ_park_statue.ignoreall = 1;
  ai_civ_park_statue.goalradius = 32;
  ai_civ_park_statue function_e99626add202fe1a(1, "entity");
  ai_civ_park_statue setModel("body_c_jup_civ_surge_busker_b");
  ai_civ_park_statue detach(ai_civ_park_statue.headmodel);
  ai_civ_park_statue attach("head_c_jup_civ_surge_busker_b", "", 1);
  ai_civ_park_statue.headmodel = "head_c_jup_civ_surge_busker_b";
  s_struct = getStruct(ai_civ_park_statue.target, "targetname");
  s_struct thread anim_first_frame_solo(ai_civ_park_statue, s_struct.animation);
  flag_wait("flg_park_stealth_done");
  ai_civ_park_statue delete();
}

function function_a23340f45d580cee() {
  ai_park_statue_phone_civ = getspawner("ai_park_statue_phone_civ", "targetname");

  if(isDefined(ai_park_statue_phone_civ)) {
    ai_park_statue_phone_civ scripts\engine\sp\utility::add_spawn_function(&function_e92e2de5964389c2, undefined, 1);
    ai = fakeactorspawn(ai_park_statue_phone_civ);
    ai thread civ_handler(0, "flg_park_stealth_done");
    ai.run_anim_override = get_animation_from_alias("civilian_react", "relaxed_run_loop", "walk");
    e_statue_phone = getEnt("e_statue_phone", "targetname");

    if(isDefined(e_statue_phone)) {
      e_statue_phone linkTo(ai, "tag_accessory_right", (-8.5, 0, -1), (0, 0, 0));
    }

    flag_wait("flg_park_stealth_done");
    e_statue_phone delete();
  }
}

function function_424fc9ed4697bd85() {
  ai_park_popcorn_civ = getspawner("ai_park_popcorn_civ", "targetname");

  if(isDefined(ai_park_popcorn_civ)) {
    ai_park_popcorn_civ = ai_park_popcorn_civ spawn_ai(1);
    ai_park_popcorn_civ function_b661b022700ba72f("script", 1);
    ai_park_popcorn_civ function_d5cda8a759cc36bc("relaxed");
    ai_park_popcorn_civ function_89007ae298fb4b15();
    ai_park_popcorn_civ.ignoreme = 1;
    ai_park_popcorn_civ.ignoreall = 1;
    ai_park_popcorn_civ.goalradius = 32;
    ai_park_popcorn_civ setModel("body_civ_amsterdam_female_8_4");
    ai_park_popcorn_civ detach(ai_park_popcorn_civ.headmodel);
    ai_park_popcorn_civ attach("head_sc_f_hujbar_bg", "", 1);
    ai_park_popcorn_civ.headmodel = "head_sc_f_hujbar_bg";
    ai_park_popcorn_civ.script_pushable = 0;
    ai_park_popcorn_civ.pushable = 0;
    flag_wait_all("flg_park_popcorn_civ_move", "flg_park_popcorn_allow");

    if(flag("flg_park_popcorn_civ_move_wait")) {
      flag_wait("flg_park_popcorn_civ_move_clear");
    }

    ai_park_popcorn_civ thread function_2198a1a54be3d161("nd_park_popcorn_civ_path");
    flag_wait("flg_park_stealth_done");
    ai_park_popcorn_civ delete();
  }
}

function function_b815630233bea7e9() {
  level endon("flg_park_blended");
  level endon("flg_park_hacker_exit_early");

  while(!flag("flg_park_blended") && !flag("flg_park_hacker_exit_early")) {
    var_57e52ce4fc8e1436 = distance(level.player.origin, level.var_d18d63c6d75cd1e.origin);

    if(var_57e52ce4fc8e1436 <= 150) {
      utility::flag_set("flg_park_player_close_to_gaz");
      break;
    }

    waitframe();
  }
}

function function_35cfe25af5bc2f19() {
  level endon("flg_park_phonecall_done");

  while(!flag("flg_park_phonecall_done")) {
    if(level.var_32e07c7aa6e030a5 <= 260) {
      utility::flag_set("flg_park_eavesdrop_player_close_to_hacker");
    } else {
      utility::flag_clear("flg_park_eavesdrop_player_close_to_hacker");
    }

    waitframe();
  }
}

function function_f5f722059582babc() {
  flag_set("flg_hide_park_vehicles");
}

function function_cf457e755f0bf7da() {}

function function_fd1d689754af745() {
  set_start_location("s_start_hideout_intro", array_combine([level.player], level.var_679be75090dd2a47));
  level.player function_8d2c23481bd4016c(0);
  level thread function_bff1ad7aec0290c7();
  level thread function_e3a57216f5802c88();
  level thread function_554254a8f0ee57f0();
}

function function_b43e8582d88f7e9e() {
  level endon("game_ended");
  autosave_by_name();
  level thread function_2ebf44c80181c535();
  flag_set("flg_park_cctv_1_start");
  flag_clear("park_dof_scripting_enabled");
  thread function_cb6f902df226f6c9();
  flag_set("flg_streets_corner_cctv_start");
  function_ad8155e88c085aeb("s_street_cctv_1", 1);
  wait 4;
  flag_wait("flg_cctv_rewind_1_allow");
  level thread function_b1e9115dd15bf413();
  thread function_cb6f8d2df226f030();
  flag_set("flg_rewind_2_started");

  while(level.var_7d7f0b9f883c729c >= 0.16) {
    wait 0.1;
  }

  flag_set("flg_rewind_target_first_seen");
  thread function_a9ecf995cd9ca35f();
  level thread function_bc0e73fe6e3f192e();
  level thread function_1b4351daebf446a1();
  level thread function_edaeaea2f2b19413();
  level thread function_e3ed72d67406fd4b();
  level thread function_305a7a6a691936f1();
  level thread function_1bbf85d2cdd5473a();
  flag_wait("flg_rewind_target_seen_entering_tunnel");
  level thread namespace_85a51fd192b9a590::function_44b25cf8de40e4bb();
  level thread function_eae70b127f98985b();
  setomnvar("ui_cctv_camera_state", 0);
  setomnvar("ui_cctv_camera_index", 0);
  level.current_cam.var_4f0d076b113c5ea3 = [];

  if(flag("flg_cctv_end_vo_playing")) {
    flag_waitopen("flg_cctv_end_vo_playing");
  } else {
    waitframe();
    flag_waitopen("flg_cctv_end_vo_playing");
  }

  flag_set("flg_end_scene_202");
  level thread scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::function_272906e3119dd8e0();
  flag_set("flg_show_graffiti_tunnel_vehicles");
}

function function_eae70b127f98985b() {
  wait 2.5;
  level.player clearadditionalstreampos();
  var_c6dc70083eeebbf9 = (-2735.5, 3255.9, 55.6);
  level.player function_670863fc4008c3d8(var_c6dc70083eeebbf9);
  utility::flag_wait("flg_streets_cctv_track_done");
  level.player clearadditionalstreampos();
}

function function_a9ecf995cd9ca35f() {
  wait 6;
  setmusicstate("mx_surge_seen");
}

function function_1b4351daebf446a1() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  while(true) {
    if(level.var_7d7f0b9f883c729c > 0.28 && flag("flg_cctv_1_active")) {
      break;
    }

    wait 0.1;
  }

  flag_set("flg_rewind_target_entered_bistro");
}

function function_edaeaea2f2b19413() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  while(true) {
    if(flag("flg_cctv_2_active") && level.var_7d7f0b9f883c729c >= 0.439 && level.var_7d7f0b9f883c729c <= 0.571) {
      break;
    }

    wait 0.1;
  }

  flag_set("bus_is_stationary");
}

function function_e3ed72d67406fd4b() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  while(true) {
    if(utility::flag("flg_cctv_4_active") && level.var_7d7f0b9f883c729c > 0.48 && level.var_7d7f0b9f883c729c < 0.584) {
      break;
    }

    wait 0.1;
  }

  flag_set("flg_rewind_target_seen_on_cartensburg_street");
}

function function_305a7a6a691936f1() {
  level endon("flg_rewind_target_seen_entering_tunnel");

  while(true) {
    if(flag("flg_cctv_4_active") && level.var_7d7f0b9f883c729c > 0.6 && level.var_7d7f0b9f883c729c < 0.65 || flag("flg_cctv_5_active") && level.var_7d7f0b9f883c729c > 0.614 && level.var_7d7f0b9f883c729c < 0.69) {
      if(flag("flg_cctv_target_crossing_vo_playing")) {
        wait 0.5;
        continue;
      }

      break;
    }

    wait 0.1;
  }

  flag_set("flg_rewind_target_seen_crossing_street");
}

function function_1bbf85d2cdd5473a() {
  while(!flag("flg_rewind_target_seen_entering_tunnel")) {
    if(level.var_7d7f0b9f883c729c >= 0.715 && level.var_7d7f0b9f883c729c <= 0.775 && flag("flg_cctv_6_active")) {
      while(true) {
        if(level.var_7d7f0b9f883c729c >= 0.76 && flag("flg_cctv_6_active") && level.var_7d7f0b9f883c729c <= 0.78) {
          flag_set("flg_rewind_target_seen_entering_tunnel");
          level notify("stop_cctv_rewind_input");
          flag_set("CCTV_zoom_disabled");
          flag_clear("CCTV_rewind_active");
          level.var_aff681d21d7b60b3 = 1;
          level.var_a067a16459d9d684 = 1;

          if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
            function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
          }

          thread function_45d971942809e316();

          foreach(scene in level.var_855197dadb1d426f) {
            scene thread function_7b2805d01b85c82c(0.00075);
          }

          break;
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function function_bc0e73fe6e3f192e() {
  level endon("flg_rewind_target_seen_entering_tunnel");
  var_f59079a5f8bf073e = "flg_cctv_1_active";
  flag_wait("flg_cctv_allow_tracking_progress");
  flag_set("flg_cctv_target_visible");

  while(true) {
    var_11bb843dbc02d1d2 = function_51ffc85dd7ebde09(["flg_cctv_1_active", "flg_cctv_2_active", "flg_cctv_3_active", "flg_cctv_4_active", "flg_cctv_5_active", "flg_cctv_6_active", "flg_cctv_7_active"]);

    if(var_f59079a5f8bf073e != var_11bb843dbc02d1d2 && flag("flg_cctv_target_fastforward_footage")) {
      flag_clear("flg_cctv_target_fastforward_footage");
    }

    var_f59079a5f8bf073e = var_11bb843dbc02d1d2;

    switch (var_11bb843dbc02d1d2) {
      case #"hash_996c9488b462ddb4":
        if(level.var_7d7f0b9f883c729c >= 0.127 && level.var_7d7f0b9f883c729c <= 0.281) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          if(flag("flg_cctv_allow_reacquire_target_cctv_1")) {
            flag_set("flg_cctv_target_visible");
          }

          flag_set("flg_cctv_target_fastforward_footage");
          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          flag_clear("flg_cctv_target_fastforward_footage");
          flag_set("flg_cctv_target_switch_cameras");

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      case #"hash_20aae99c4b7e8a7":
        if(level.var_7d7f0b9f883c729c >= 0.342 && level.var_7d7f0b9f883c729c <= 0.439) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          flag_set("flg_cctv_target_visible");
          flag_set("flg_cctv_target_fastforward_footage");
          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          if(level.var_7d7f0b9f883c729c > 0.281 && level.var_7d7f0b9f883c729c < 0.342) {
            flag_set("flg_cctv_target_fastforward_footage");
            flag_clear("flg_cctv_target_switch_cameras");
          } else {
            flag_clear("flg_cctv_target_fastforward_footage");
            flag_set("flg_cctv_target_switch_cameras");
          }

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      case #"hash_3a608f6d653c4686":
        flag_clear("flg_cctv_target_fastforward_footage");
        flag_set("flg_cctv_target_switch_cameras");

        if(flag("flg_cctv_target_visible")) {
          thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
        }

        flag_clear("flg_cctv_target_visible");
        break;
      case #"hash_e3331b85b191dba9":
        if(level.var_7d7f0b9f883c729c >= 0.48 && level.var_7d7f0b9f883c729c <= 0.584 || level.var_7d7f0b9f883c729c >= 0.611 && level.var_7d7f0b9f883c729c <= 0.646) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          flag_set("flg_cctv_target_visible");
          flag_set("flg_cctv_target_fastforward_footage");
          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          if(level.var_7d7f0b9f883c729c > 0.439 && level.var_7d7f0b9f883c729c < 0.48 || level.var_7d7f0b9f883c729c > 0.584 && level.var_7d7f0b9f883c729c < 0.611) {
            flag_set("flg_cctv_target_fastforward_footage");
            flag_clear("flg_cctv_target_switch_cameras");
          } else {
            flag_clear("flg_cctv_target_fastforward_footage");
            flag_set("flg_cctv_target_switch_cameras");
          }

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      case #"hash_bab533c97366dc68":
        if(level.var_7d7f0b9f883c729c >= 0.615 && level.var_7d7f0b9f883c729c <= 0.72) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          flag_set("flg_cctv_target_visible");
          flag_set("flg_cctv_target_fastforward_footage");
          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          flag_clear("flg_cctv_target_fastforward_footage");
          flag_set("flg_cctv_target_switch_cameras");

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      case #"hash_dbb6b2fedec5e3eb":
        if(level.var_7d7f0b9f883c729c >= 0.71 && level.var_7d7f0b9f883c729c <= 0.801) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          flag_set("flg_cctv_target_visible");

          if(level.var_7d7f0b9f883c729c >= 0.76) {
            flag_clear("flg_cctv_target_fastforward_footage");
          } else {
            flag_set("flg_cctv_target_fastforward_footage");
          }

          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          flag_clear("flg_cctv_target_fastforward_footage");
          flag_set("flg_cctv_target_switch_cameras");

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      case #"hash_d2a530704793c40a":
        if(level.var_7d7f0b9f883c729c >= 0.549 && level.var_7d7f0b9f883c729c <= 0.589 || level.var_7d7f0b9f883c729c >= 0.615 && level.var_7d7f0b9f883c729c <= 0.655) {
          if(!flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_c81ef10d3cc37fb2();
          }

          flag_set("flg_cctv_target_visible");
          flag_set("flg_cctv_target_fastforward_footage");
          flag_clear("flg_cctv_target_switch_cameras");
        } else {
          if(level.var_7d7f0b9f883c729c > 0.589 && level.var_7d7f0b9f883c729c < 0.615) {
            flag_set("flg_cctv_target_fastforward_footage");
            flag_clear("flg_cctv_target_switch_cameras");
          } else {
            flag_clear("flg_cctv_target_fastforward_footage");
            flag_set("flg_cctv_target_switch_cameras");
          }

          if(flag("flg_cctv_target_visible")) {
            thread namespace_9dd7c42f4da32e8a::function_13118232dd2c9226();
          }

          flag_clear("flg_cctv_target_visible");
        }

        break;
      default:
        flag_clear("flg_cctv_target_visible");
        flag_clear("flg_cctv_target_fastforward_footage");
        flag_clear("flg_cctv_target_switch_cameras");
        break;
    }

    wait 0.1;
  }
}

function function_554254a8f0ee57f0() {
  var_2afdf8ddd5584aa1 = getEntArray("e_tunnel_static_vehicle", "targetname");

  foreach(e_vehicle in var_2afdf8ddd5584aa1) {
    e_vehicle hide();
  }

  flag_wait("flg_hide_park_vehicles");
  var_bfd5ad7d54b32b97 = getEntArray("e_park_static_vehicle", "targetname");

  foreach(e_vehicle in var_bfd5ad7d54b32b97) {
    e_vehicle delete();
  }

  flag_wait("flg_show_graffiti_tunnel_vehicles");

  foreach(e_vehicle in var_2afdf8ddd5584aa1) {
    e_vehicle show();
  }

  var_1527bd56fa228038 = getEnt("e_tunnel_static_police_vehicle", "script_noteworthy");
  playFXOnTag(getfx("vfx_car_police_lights_2"), var_1527bd56fa228038, "tag_origin");
  flag_wait("flg_street_vehicle_cleanup");

  foreach(e_vehicle in var_2afdf8ddd5584aa1) {
    if(isDefined(e_vehicle)) {
      e_vehicle delete();
    }
  }
}

function function_54ab7590d2f1297() {
  flag_set("flg_show_graffiti_tunnel_vehicles");
}

function function_b5e9bf214bf2b05d() {}

function function_e179dc089d6a2222(var_d6fd0fecf21803cf, var_a134b18ad96c9b3f) {
  var_e0f4b3c8cf6c79a = getspawnerarray(var_d6fd0fecf21803cf);
  array_spawn_function(var_e0f4b3c8cf6c79a, &function_e92e2de5964389c2, undefined, 1);

  foreach(ai_civ in var_e0f4b3c8cf6c79a) {
    if(isDefined(ai_civ.script_parameters)) {
      if(ai_civ.script_parameters == "actor") {
        ai = ai_civ spawn_ai(1);
        ai function_b661b022700ba72f("script", 1);
        ai function_89007ae298fb4b15();
        ai thread civ_handler(1, var_a134b18ad96c9b3f);
        ai function_c1e075c4168a8bea(0, 0);
        s_park_civ_avoidance_ref = getStruct("s_park_civ_avoidance_ref", "targetname");
        dist = distance2d(ai.origin, s_park_civ_avoidance_ref.origin);

        if(isDefined(dist) && dist < 15) {
          ai enableavoidance(1);
        } else {
          ai enableavoidance(0, 0);
        }
      }

      continue;
    }

    ai_civ.var_f7e4ad5c054874e1 = 15;
    ai_civ.var_35717e73cad440a1 = 0.1;
    ai = fakeactorspawn(ai_civ);
    ai thread civ_handler(1, var_a134b18ad96c9b3f);
    ai thread civ_handler(0, var_a134b18ad96c9b3f);
    ai.run_anim_override = get_animation_from_alias("civilian_react", "relaxed_run_loop", "walk");
  }

  flag_wait(var_a134b18ad96c9b3f);
}

function blend_handler(var_6fb5618fab5265c3, str_interact, var_56e0c4f3c224cf1e, var_72d9a5cb838b587a, v_offset) {
  if(!isDefined(v_offset)) {
    v_offset = (0, 0, 0);
  }

  s_interact = getStruct(var_6fb5618fab5265c3, "targetname");
  i_interact = spawn_tag_origin(s_interact.origin, s_interact.angles);
  var_af387a9d01d61618 = 50;
  var_7d7af478c9344620 = 120;
  var_29b0af8b73c85a57 = 180;
  var_65fe43c37838c33d = 400;
  i_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", v_offset, str_interact, var_29b0af8b73c85a57, var_65fe43c37838c33d, var_af387a9d01d61618, 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_7d7af478c9344620);
  waittill_any_ents(i_interact, "trigger", level, var_72d9a5cb838b587a);
  i_interact scripts\sp\player\cursor_hint::remove_cursor_hint();
  i_interact delete();

  if(!flag(var_72d9a5cb838b587a)) {
    if(!flag(var_56e0c4f3c224cf1e)) {
      flag_set(var_56e0c4f3c224cf1e);
      level notify(var_56e0c4f3c224cf1e);

      if(var_6fb5618fab5265c3 == "s_park_gaz_interact_ref") {
        flag_set(var_56e0c4f3c224cf1e);
        level.ai_hacker thread function_ad1fc1e84ba347ed(1);
        level thread scene_0110();
        flag_wait("flg_park_whiskey_leave_1");
        flag_set("flg_park_whiskey_path_2_started");
        flag_wait("flg_park_gaz_blend_done");
        flag_clear(var_56e0c4f3c224cf1e);
        level.ai_hacker thread function_ad1fc1e84ba347ed(0);
        iprintln("You are no longer blended.");
        autosave_by_name();
      } else if(var_6fb5618fab5265c3 == "s_park_blend_dog_ref") {
        level.ai_hacker thread function_ad1fc1e84ba347ed(1);
        s_interact thread function_bc7efe2de70ac80a();
        tr_park_hidden_set_post_dog = getEnt("tr_park_hidden_set_post_dog", "targetname");
        tr_park_hidden_set_post_dog trigger_on();

        if(!utility::flag("flg_park_failed") && !utility::flag("flg_park_hacker_react_vo_playing")) {
          level.player thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_pstl_soap_gooddoggy", 0, 5);
        }

        s_interact ent_flag_wait("blending_anim_done");
        level.player stopgestureviewmodel();
        flag_set(var_56e0c4f3c224cf1e);
        flag_clear(var_56e0c4f3c224cf1e);
        level.ai_hacker thread function_ad1fc1e84ba347ed(0);
      } else if(var_6fb5618fab5265c3 == "s_park_blend_postcard_kiosk") {
        level.ai_hacker thread function_ad1fc1e84ba347ed(1);
        flag_set("flg_park_blended_set_3_done");
        s_interact thread function_bc53672de6db488f();
        s_interact ent_flag_wait("blending_anim_done");
        flag_set(var_56e0c4f3c224cf1e);
        flag_wait("flg_park_stealth_done");
        level.ai_hacker thread function_ad1fc1e84ba347ed(0);
      } else if(var_6fb5618fab5265c3 == "s_park_blend_phone_pic") {
        level.ai_hacker thread function_ad1fc1e84ba347ed(1);
        flag_set("flg_park_blended_set_3_done");
        var_35302c60193cdef0 = [level.player, level.var_318c75041f10c73f, level.var_292c01a9cd0b2818, level.ai_hacker];

        if(!utility::flag("flg_park_failed") && !utility::flag("flg_park_phonecall_start") && !dialogue::function_6c31b0b0edd184ed(var_35302c60193cdef0, 1)) {
          level.player thread dialogue::function_fc0eb6b81c66c661(0.3, "dx_sp_surg_pstl_soap_gettinmystepsintoday", 0, 1);
        }

        flag_set(var_56e0c4f3c224cf1e);
        function_bc53692de6db4cf5();
        flag_wait("flg_park_stealth_done");
        level.player stopgestureviewmodel();
        level.ai_hacker thread function_ad1fc1e84ba347ed(0);
      }
    }
  }

  level.player val::set("park_no_prone", "prone", 0);
}

function spawn_hacker(var_7eafdc52084bd6f2) {
  ai_hacker = getspawner("ai_hacker", "targetname");
  level.ai_hacker = ai_hacker spawn_ai(1, 1);
  level.ai_hacker.team = "axis";
  level.ai_hacker.ignoreme = 1;
  level.ai_hacker.ignoreall = 1;
  level.ai_hacker.goalradius = 32;
  level.ai_hacker function_b661b022700ba72f("script", 1);
  level.ai_hacker function_d5cda8a759cc36bc("relaxed");
  level.ai_hacker function_89007ae298fb4b15();
  level.ai_hacker.animname = "generic";
  level.ai_hacker.script_noteworthy = "whiskey";
  level.ai_hacker scripts\sp\utility::context_melee_allow(0);
  level.ai_hacker thread function_6666cc3b4b37ec2();
  level.ai_hacker thread function_5dd641e58065f89c();
  level.ai_hacker thread function_4479bd709046ee16();
  level.ai_hacker.script_pushable = 0;
  level.ai_hacker.pushable = 0;
  level.ai_hacker pushplayer(1);
  level.ai_hacker enableavoidance(0);

  if(var_7eafdc52084bd6f2 == 1) {
    level.ai_hacker thread reveal_nameplate("Hacker", "axis");
    level.ai_hacker.callsign = "Whiskey";
  } else {
    self.name = undefined;
  }

  flag_set("spawn_hacker_complete");
  level.ai_hacker thread function_ef45d05d1b414c9b("flg_streets_corner_cctv_start");
}

function function_4479bd709046ee16() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flg_park_cctv_1_start");
  level.player endon("death");
  level.var_32e07c7aa6e030a5 = 0;

  while(true) {
    level.var_32e07c7aa6e030a5 = distance2d(level.player.origin, self.origin);
    wait 1;
  }
}

function function_273ab66ca3c2923e() {
  level endon("flg_park_whiskey_path_2_arrived");
  flag_set("flag_park_hacker_on_screen");

  while(!flag("flg_park_whiskey_path_2_arrived")) {
    if(!within_fov(level.player.origin, level.player.angles, self.origin, cos(45))) {
      flag_clear("flag_park_hacker_on_screen");
    } else {
      flag_set("flag_park_hacker_on_screen");
    }

    waitframe();
  }
}

function function_5dd641e58065f89c() {
  var_46f7ad3a436261be = 4096;
  var_4561a1815cae4631 = getEntArray("tr_park_hacker_personal_space", "targetname");

  foreach(tr_park_hacker_personal_space in var_4561a1815cae4631) {
    tr_park_hacker_personal_space enablelinkTo();
    tr_park_hacker_personal_space linkTo(self, "tag_eye");
  }

  flag_wait("flg_intro_done");

  while(!flag("flg_park_failed") && !flag("flg_park_cctv_1_start")) {
    var_b2a34e7cc6e186fb = distance2dsquared(self.origin, level.player.origin);

    if(flag("flg_park_hacker_ps") || var_b2a34e7cc6e186fb < var_46f7ad3a436261be) {
      level.ai_hacker thread function_3bc8c54ea5dd06ec();
      wait 2;
    }

    waitframe();
  }
}

function function_3bc8c54ea5dd06ec() {
  level endon("game_ended");
  level.var_e98bcc2bda4e12fc = 0;

  while(level.var_e98bcc2bda4e12fc < 1) {
    level.var_e98bcc2bda4e12fc += 0.2;
    stealth_value = max(level.var_e98bcc2bda4e12fc, level.var_b36f5b25c5c4699b);
    function_c1d35e4e21d91ca0(self, stealth_value, level.player);
    wait 0.1;
  }

  level.var_27842e9538a928a2 += 2;
  level.player playSound("ui_stealth_threat_hud_periph_vision");

  if(level.var_27842e9538a928a2 >= 2 && !flag("flg_park_whiskey_path_3_started")) {
    if(!flag("flg_park_failed")) {
      function_735fb40088dd6a60();
    }
  } else {
    level thread namespace_9dd7c42f4da32e8a::function_42d70b13f4e9e32a();
  }

  while(level.var_e98bcc2bda4e12fc > 0) {
    level.var_e98bcc2bda4e12fc -= 0.2;
    stealth_value = max(level.var_e98bcc2bda4e12fc, level.var_b36f5b25c5c4699b);
    function_c1d35e4e21d91ca0(self, stealth_value, level.player);
    wait 0.1;
  }
}

function function_6666cc3b4b37ec2() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flg_park_cctv_1_start");
  level.var_27842e9538a928a2 = 0;
  level.var_b36f5b25c5c4699b = 0;
  level.var_e98bcc2bda4e12fc = 0;
  tr_park_hacker_los = getEnt("tr_park_hacker_los", "targetname");
  tr_park_hacker_los enablelinkTo();
  tr_park_hacker_los linkTo(self, "tag_eye");
  tr_park_hacker_los_wide = getEnt("tr_park_hacker_los_wide", "targetname");

  if(isDefined(tr_park_hacker_los_wide)) {
    tr_park_hacker_los_wide enablelinkTo();
    tr_park_hacker_los_wide linkTo(self, "tag_eye");
  }

  flag_wait("flg_intro_done");
  scripts\stealth\threat_sight::threat_sight_set_enabled(1);
  self function_24cb3b5e0d4216b1("investigate");
  function_ce78fcefc5534fd6(self, level.player, 0);

  while(!flag("flg_park_failed") && !flag("flg_park_whiskey_path_2_arrived")) {
    if(flag("flg_park_hacker_los")) {
      if(!flag("flg_park_hidden") && !flag("flg_park_blended")) {
        if(level.var_b36f5b25c5c4699b < 0) {
          level.var_b36f5b25c5c4699b = 0;
        }

        level.var_b36f5b25c5c4699b += 0.2;
        stealth_value = max(level.var_e98bcc2bda4e12fc, level.var_b36f5b25c5c4699b);
        function_c1d35e4e21d91ca0(self, stealth_value, level.player);

        if(level.var_b36f5b25c5c4699b == 1 && !flag("flg_park_cctv_1_start")) {
          level.var_27842e9538a928a2 += 1;
          level.player playSound("ui_stealth_threat_hud_periph_vision");

          iprintln("<dev string:x20>" + level.var_27842e9538a928a2 + "<dev string:x3a>");
        }

        if(level.var_b36f5b25c5c4699b >= 10 && !flag("flg_park_cctv_1_start")) {
          level.var_27842e9538a928a2 += 1;
          level.player playSound("ui_stealth_threat_hud_periph_vision");

          iprintln("<dev string:x20>" + level.var_27842e9538a928a2 + "<dev string:x3a>");
        }

        if(level.var_27842e9538a928a2 >= 2 && !flag("flg_park_cctv_1_start")) {
          if(!flag("flg_park_failed")) {
            function_735fb40088dd6a60();
          }
        } else {
          level thread namespace_9dd7c42f4da32e8a::function_ffd1fc2c265a4c38();
        }
      } else {
        if(level.var_b36f5b25c5c4699b > 1) {
          level.var_b36f5b25c5c4699b = 1;
        }

        if(level.var_b36f5b25c5c4699b > 0) {
          level.var_b36f5b25c5c4699b -= 0.05;
        }

        stealth_value = max(level.var_e98bcc2bda4e12fc, level.var_b36f5b25c5c4699b);
        function_c1d35e4e21d91ca0(self, stealth_value, level.player);

        iprintln("<dev string:x3d>");
      }
    } else {
      if(level.var_b36f5b25c5c4699b > 1) {
        level.var_b36f5b25c5c4699b = 1;
      }

      if(level.var_b36f5b25c5c4699b > 0) {
        level.var_b36f5b25c5c4699b -= 0.1;
      }

      stealth_value = max(level.var_e98bcc2bda4e12fc, level.var_b36f5b25c5c4699b);
      function_c1d35e4e21d91ca0(self, stealth_value, level.player);
    }

    wait 0.1;
  }

  while(!flag("flg_park_failed") && !flag("flg_park_cctv_1_start")) {
    if(flag("flg_park_hacker_los_wide")) {
      if(!flag("flg_park_hidden") && !flag("flg_park_blended")) {
        if(level.var_b36f5b25c5c4699b < 0) {
          level.var_b36f5b25c5c4699b = 0;
        }

        level.var_b36f5b25c5c4699b += 0.2;
        function_c1d35e4e21d91ca0(self, level.var_b36f5b25c5c4699b, level.player);

        if(level.var_b36f5b25c5c4699b == 1 && !flag("flg_park_cctv_1_start")) {
          level.var_27842e9538a928a2 += 1;
          level.player playSound("ui_stealth_threat_hud_periph_vision");

          iprintln("<dev string:x20>" + level.var_27842e9538a928a2 + "<dev string:x3a>");
        }

        if(level.var_b36f5b25c5c4699b >= 10 && !flag("flg_park_cctv_1_start")) {
          level.var_27842e9538a928a2 += 1;
          level.player playSound("ui_stealth_threat_hud_periph_vision");

          iprintln("<dev string:x20>" + level.var_27842e9538a928a2 + "<dev string:x3a>");
        }

        if(level.var_27842e9538a928a2 >= 2 && !flag("flg_park_cctv_1_start")) {
          if(!flag("flg_park_failed")) {
            function_735fb40088dd6a60();
          }
        } else {
          level thread namespace_9dd7c42f4da32e8a::function_ffd1fc2c265a4c38();
        }
      } else {
        if(level.var_b36f5b25c5c4699b > 1) {
          level.var_b36f5b25c5c4699b = 1;
        }

        if(level.var_b36f5b25c5c4699b > 0) {
          level.var_b36f5b25c5c4699b -= 0.05;
        }

        function_c1d35e4e21d91ca0(self, level.var_b36f5b25c5c4699b, level.player);

        iprintln("<dev string:x3d>");
      }
    } else {
      if(level.var_b36f5b25c5c4699b > 1) {
        level.var_b36f5b25c5c4699b = 1;
      }

      if(level.var_b36f5b25c5c4699b > 0) {
        level.var_b36f5b25c5c4699b -= 0.1;
      }

      function_c1d35e4e21d91ca0(self, level.var_b36f5b25c5c4699b, level.player);
    }

    wait 0.1;
  }
}

function function_735fb40088dd6a60() {
  level utility::flag_set("flg_park_failed");

  if(!flag("flg_suspicion_vo_cooldown")) {
    if(utility::cointoss()) {
      level.ai_hacker thread dialogue::function_8c1bbaeb5d3fe61a(0.4, "dx_sp_surg_pstl_hack_someonestailingme", 3, 0.1);
    } else {
      level.ai_hacker thread dialogue::function_8c1bbaeb5d3fe61a(0.4, "dx_sp_surg_pstl_hack_imbeingfollowed", 3, 0.1);
    }
  }

  wait 0.5;
  dialogue::function_cb329cf8896edeaa(level.player.team, 1, 1);

  if(flag("flg_hacker_in_scene")) {
    wait 1;
    scripts\sp\player_death::set_custom_death_quote(517);
    missionfailedwrapper();
    return;
  }

  level.ai_hacker function_d5cda8a759cc36bc("flee");
  level.ai_hacker function_d45457463f7a8eab(200);
  level.ai_hacker function_92c056ec351f2f6e(200);
  level.ai_hacker function_2198a1a54be3d161("nd_hacker_path_3_start");

  if(utility::cointoss()) {
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_pstl_lasw_targetsontherunmissi", 3);
  } else {
    level.var_318c75041f10c73f dialogue::function_fc0eb6b81c66c661(0.8, "dx_sp_surg_pstl_lasw_shesontousbravoabort", 3);
  }

  scripts\sp\player_death::set_custom_death_quote(517);
  missionfailedwrapper();
}

function function_b1e9115dd15bf413() {
  level endon("game_ended");
  display_hint_forced("cctv_rewind_hint", undefined, undefined, level, "str_cctv_rewind_tut_done");

  while(!isDefined(level.var_7d7f0b9f883c729c)) {
    waitframe();
  }

  while(level.var_7d7f0b9f883c729c >= 0.16) {
    wait 0.1;
  }

  level notify("str_cctv_rewind_tut_done");
}