/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_silo\sp_jup_silo.gsc
**********************************************************/

#using script_10bb9f045d0c567a;
#using script_4d3f1e28f2ed7fa4;
#using script_52b75c98a3627627;
#using script_664d49b08f516f55;
#using script_73e89fcb51b31802;
#using script_9feb66b51ab34e8;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_silo\sp_jup_silo_fx;
#using scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player\offhand_box;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace sp_jup_silo;

function main() {
  namespace_c1e54d24548158fc::main();
  scripts\sp\maps\sp_jup_silo\sp_jup_silo_fx::main();
  namespace_6296f71367e91e31::main();
  scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::main();
  namespace_318af18595992d06::main();
  precache();
  nil = undefined;
  set_default_start("intro_drone");
  add_start("intro_drone", &intro_start, &intro_main, nil, &intro_catchup);
  add_start("stealth_fields", &stealth_fields_start, &function_53a1e1f1c6563534, nil, &function_11acb2b641276495);
  add_start("stealth_base", &stealth_base_start, &function_1f1941529a0fb430, nil, &function_10525fa200c350c9);
  add_start("lower_base", &lower_base_start, &function_37f4d6b0e1674c92, nil, &function_4469ee24762ae7a3);
  add_start("server_room", &function_1700389a6495888b, &function_75ce0864a6ec40bc, nil, &function_ee4ba7cebcb42a6d);
  add_start("second_floor", &second_floor_start, &second_floor_main, nil, &second_floor_catchup);
  add_start("maintenance_door", &function_6096030287339a4e, &function_8b81a38e620a00d7, nil, &function_8da8491fe37fc54);
  add_start("missile_room", &missile_room_start, &function_ad5dcd76778dd281, nil, &function_ba9a9423ac548b2e);
  add_start("exit_tunnel", &exit_tunnel_start, &function_73fa224d01ddf284, nil, &function_fa9ddd3cab0c2165);
  add_start("exit_hatch", &function_1f20bcef5d5ccf3f, &function_e972bdc1c1628668, nil, &function_fb5b9a581abaa551);
  add_start("outro", &outro_start, &outro_main, nil, &function_d53be00830317b3d);
  add_start("CCTV_shot", &cctv_shot);
  add_start("CCTV_explosion", &cctv_explosion);
  add_start("CCTV_idle", &cctv_idle);
  audio::set_audio_level_fade_time(0);
  scripts\sp\load::main();
  flag_init("introscreen_start_wait");
  setup_player();
  namespace_5643a6b7e3dcbf23::function_61e183b8af11995();
  thread namespace_5b6d7d7426cd03ec::spawn_weapons();
  thread namespace_5643a6b7e3dcbf23::ammo_refill();
  thread namespace_5643a6b7e3dcbf23::function_a4c4199bfb798025();
  thread namespace_5643a6b7e3dcbf23::lock_doors();
  thread namespace_5643a6b7e3dcbf23::function_ef39228649b4fb51();
  thread namespace_5643a6b7e3dcbf23::function_4f8b3a424771dd64();
  thread namespace_1542dec1529315d1::drone_init();
  thread namespace_5643a6b7e3dcbf23::function_25ed56105e3958be();
  scripts\sp\utility::function_1a9f269761ab7db1("stealth_fields_armor_pickup");
}

function precache() {
  namespace_1542dec1529315d1::function_63a5492602bdb505();
  namespace_5b6d7d7426cd03ec::function_ae7015994b968e96();
  function_5c8aa2cb21963afd();
  silo_dvars();
  thread scripts\sp\player\offhand_box::offhand_box_setup();
}

function function_18d45df64b0a39f() {
  var_31b36d4fd205f8a7 = [];
  struct1 = spawnStruct();
  struct1.origin = (4454, -387.5, -403.5);
  struct1.angles = (0, 270, -90);
  var_31b36d4fd205f8a7[var_31b36d4fd205f8a7.size] = struct1;
  struct2 = spawnStruct();
  struct2.origin = (4454, -372.5, -403.5);
  struct2.angles = (0, 270, -90);
  var_31b36d4fd205f8a7[var_31b36d4fd205f8a7.size] = struct2;

  foreach(struct in var_31b36d4fd205f8a7) {
    scripts\sp\utility::function_eb4400096efae0a7(struct);
  }
}

function function_5c8aa2cb21963afd() {
  utility::add_hint_string("locate_gate", &"SP_JUP_SILO/HINT_LOCATE_GATE", &function_9fc62c8428c71f23);
  utility::add_hint_string("drone_zoom", &"SP_JUP_SILO/HINT_DRONE_ZOOM", &function_70b033482ac1a273);
  utility::add_hint_string("locate_hill", &"SP_JUP_SILO/HINT_LOCATE_HILL", &function_5430f10a8cfbf553);
  utility::add_hint_string("locate_huts", &"SP_JUP_SILO/HINT_LOCATE_HUTS", &function_ad1ba65164ac06c8);
  utility::add_hint_string("use_drone", &"SP_JUP_SILO/HINT_USE_DRONE", &function_40b5ac91b0c3b168);
  utility::add_hint_string("exit_drone", &"SP_JUP_SILO/HINT_EXIT_DRONE", &function_cab7c63bf8ce5da3);
  utility::add_hint_string("use_grass", &"SP_JUP_SILO/HINT_USE_GRASS");
  utility::add_hint_string("need_keycard", &"SP_JUP_SILO/HINT_NEED_KEYCARD");
  utility::add_hint_string("drone_not_available", &"SP_JUP_SILO/HINT_NO_DRONE");
  utility::add_hint_string("full_enemies", &"SP_JUP_SILO/FULL_ENEMIES");
  utility::add_hint_string("primaryoffhand", &"MP_BR_INGAME/LETHAL_TYPE_FULL");
  utility::add_hint_string("secondaryoffhand", &"MP_BR_INGAME/TACTICAL_TYPE_FULL");
}

function silo_dvars() {
  setdvarifuninitialized(@ "hash_a5a70c5c6668524", 0);
  setdvarifuninitialized(@ "hash_76852036995dc6cc", 0);
  setdvarifuninitialized(@ "hash_d08a5047ea23e363", 0);
  setdvarifuninitialized(@ "hash_83e64f9accd4abd4", 0);
  setdvarifuninitialized(@ "hash_c31d41bdcbf10067", 0);
  setdvarifuninitialized(@ "hash_23f04eacda6008de", 0);
  setdvarifuninitialized(@ "hash_ad5032a034d0186b", 0);
  setdvarifuninitialized(@ "hash_cea5f5bb0f90163c", 0);
}

function setup_player() {
  function_7d89f98164b6df3d("vm_c_jup_sp_hero_price_desert");
  level.player utility::function_c4ec7d985422ce24("vb_c_jup_sp_hero_price_desert");
  var_2f7136cf6c5b1b14 = ["frag", "flash"];
  utility::offhandprecache(var_2f7136cf6c5b1b14);
  primaryweapon = undefined;
  secondaryweapon = undefined;
  stock = 0;

  if(scripts\sp\starts::is_after_start("server_room")) {
    primaryweapon = utility::make_weapon("iw9_ar_akilo105_sp", ["iw9_minireddot02_tall", "stock_sm_tactical_p04", "bar_ar_heavy_p04", "mag_ar_lgtlarge_p04", "grip_vert01", "comp_ar_01"]);
    secondaryweapon = utility::make_weapon("iw9_sh_mike1014_sp");
  } else {
    primaryweapon = utility::make_weapon("iw9_dm_mike14_sp", ["silencer01_br", "ammo_762n", "arscope_vz02", "bar_dm_p18_mike14", "grip_vertshort03", "iw9_rec_mike14", "mag_sn_large_p18", "pgrip_dm_p18", "stock_dm_light_p18"]);
    secondaryweapon = utility::make_weapon("iw9_pi_golf17_sp", ["silencer01_pi"]);
    stock = 1;
  }

  level.player utility::give_weapon(primaryweapon);
  level.player utility::give_weapon(secondaryweapon, 0, 0, 0, 1);
  level.player utility::give_offhand("frag", 2);
  level.player utility::give_offhand("flash", 2);
  level.player switchtoweapon(primaryweapon);
  level.player setperk("specialty_pistoldraw", 1);

  if(istrue(stock)) {
    level.player setweaponammostock(primaryweapon, 60);
    return;
  }

  level.player setweaponammostock(primaryweapon, 180);
}

function function_7d89f98164b6df3d(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    level.player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    level.player setshadowmodel(shadowmodel);
  }
}

function intro_start() {
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_861747b965da3832();
  utility::set_start_location("intro_start", [level.player]);
}

function intro_main() {
  level.player setsoundsubmix("iw8_remove_plr_weap_foley", 0);
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_intro_drone_flyby", 0.1, 0);
  thread namespace_5643a6b7e3dcbf23::set_objective("intro");
  thread namespace_5b6d7d7426cd03ec::function_2acc52248a375fa3();
  thread namespace_1542dec1529315d1::function_568859054f402d9f();
  utility::exploder("drone_pov");
  animnode = utility::getStruct("intro_animnode", "targetname");
  animation = level.scr_anim["fakePlayer"]["infil_2"];
  origin = getstartorigin(animnode.origin, animnode.angles, animation);
  angles = getstartangles(animnode.origin, animnode.angles, animation);
  level.player setOrigin(origin);
  level.player setplayerangles(angles);
  utility::delaythread(2.5, &utility::flag_set, "introscreen_start_wait");
  thread namespace_1542dec1529315d1::function_e1ffc56a9d16f161(1, 1);
  namespace_1542dec1529315d1::function_26177122c2752196();
  thread utility::kill_exploder("drone_pov");
  namespace_1542dec1529315d1::function_62b4751385efd14b();
  thread utility::autosave_by_name("intro_finished");
}

function intro_catchup() {
  utility::flag_set("locate_gate");
  utility::flag_set("gate_spotted");
  utility::flag_set("locate_mound");
  utility::flag_set("hill_spotted");
  utility::flag_set("locate_huts");
  utility::flag_set("boss_spotted");
  utility::flag_set("finish_upper_base_spawn");
  thread namespace_5b6d7d7426cd03ec::function_2acc52248a375fa3();
  thread namespace_1542dec1529315d1::function_568859054f402d9f();
}

function stealth_fields_start() {
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_7dc8d6592d0d97d();
  utility::set_start_location("stealth_fields_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("infil");
  thread namespace_1542dec1529315d1::function_e1ffc56a9d16f161(1, 1);
}

function function_53a1e1f1c6563534() {
  utility::flag_set("intro_finished");
  namespace_1542dec1529315d1::function_cba81cd7e4b0a947();
  utility::flag_set("drone_usable");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_infil_stealth", 3.5, 3.5);
  thread namespace_1542dec1529315d1::function_b78f945ee84591f1("truck_1", "truck_path_start");
  thread namespace_1542dec1529315d1::function_3fcee29c220f5f88("stealth_fields_1_check", "player_close_to_field");
  thread namespace_1542dec1529315d1::function_3fcee29c220f5f88("stealth_fields_2_check", "player_close_to_field_2");
  thread namespace_1542dec1529315d1::stealth_music();
  thread namespace_1542dec1529315d1::function_fe8e9f86a6795da();
  thread namespace_1542dec1529315d1::function_74e3be3043e9b813();
}

function function_11acb2b641276495() {
  utility::flag_set("intro_finished");
  utility::flag_set("drone_usable");
  utility::flag_set("start_story_beat");
  scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_4b65276da49e2658();
}

function stealth_base_start() {
  thread namespace_1542dec1529315d1::function_b78f945ee84591f1("truck_2", "truck_path_alt");
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_c86d5fcf8e295015();
  utility::set_start_location("stealth_base_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("infil");
  thread namespace_1542dec1529315d1::function_e1ffc56a9d16f161(0, 1);

  if(getdvarint(@ "hash_83e64f9accd4abd4")) {
    utility::flag_set("keycard_picked_up");
  }

  if(getdvarint(@ "hash_c31d41bdcbf10067")) {
    namespace_5643a6b7e3dcbf23::function_48da179b4ec16645();
  }

  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_infil_stealth", 3.5, 3.5);
}

function function_1f1941529a0fb430() {
  thread namespace_1542dec1529315d1::function_b491bad79c67c802();
  thread namespace_5643a6b7e3dcbf23::function_b0a5da41ab9f35f5();
  thread namespace_1542dec1529315d1::function_c6856589af842ac1();
  thread namespace_1542dec1529315d1::function_f2910a2af259ff04();
  namespace_1542dec1529315d1::function_9d1aeef22a3c795c();
}

function function_10525fa200c350c9() {
  utility::flag_set("keycard_picked_up");
}

function lower_base_start() {
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_2b50d736d5245e23();
  utility::set_start_location("lower_base_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("lower_base");

  if(getdvarint(@ "hash_c31d41bdcbf10067")) {
    namespace_5643a6b7e3dcbf23::function_48da179b4ec16645();
  }

  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_infil_stealth", 3.5, 3.5);
}

function function_37f4d6b0e1674c92() {
  thread namespace_1542dec1529315d1::function_410e78baa4974258();
  thread namespace_5b6d7d7426cd03ec::function_4886770589d60bca();
  utility::flag_wait("player_close_to_elevator");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_descender", 3.5, 3.5);
  thread namespace_5b6d7d7426cd03ec::function_1bae192de58c8dbe();
  utility::flag_wait("player_in_elevator");
  utility::flag_set("player_is_underground");
  level.player playSound("jup_silo_ascender_elevator_land");
  level.var_ecafb96516684c19 = 1;
  level notify("stop_corpse_loops");
  thread namespace_5643a6b7e3dcbf23::despawn_enemies();
  thread namespace_5b6d7d7426cd03ec::function_6d268c8cf725b5d8();
  thread namespace_5b6d7d7426cd03ec::function_5423cf990f4b6f7a();
  namespace_5b6d7d7426cd03ec::function_d7d941d826e22756();
  utility::flag_clear("stealth_enabled");
  utility::autosave_by_name("farah_opens_door");
}

function function_4469ee24762ae7a3() {
  utility::flag_set("meetup_with_farah");
  utility::flag_set("player_is_underground");
  utility::flag_set("player_in_elevator");
  utility::flag_clear("stealth_enabled");
  level.var_ecafb96516684c19 = 1;
  level notify("stop_corpse_loops");
}

function function_1700389a6495888b() {
  partner = utility::spawn_targetname("partner");
  animnode = utility::getStruct("meetup_animnode", "targetname");
  animnode thread animation::anim_loop_solo(level.partner, "meetup_idle_2", level.partner.var_428407c1b0a62c2f);
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_e86a59c418dd8517();
  utility::set_start_location("lower_base_server_start", [level.player, partner]);
  thread namespace_5643a6b7e3dcbf23::set_objective("server_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_traproom", 3.5, 3.5);
}

function function_75ce0864a6ec40bc() {
  thread namespace_5b6d7d7426cd03ec::function_a494fbcc02aedb37();
  thread namespace_5b6d7d7426cd03ec::function_5f96ca0117e9176a();
  utility::flag_wait("player_in_server_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_server_maze", 3.5, 3.5);
  animnode = utility::getStruct("meetup_animnode", "targetname");
  animnode notify(level.partner.var_428407c1b0a62c2f);
  thread namespace_5b6d7d7426cd03ec::function_ee9104cd95f689e4();
  thread namespace_5b6d7d7426cd03ec::function_89c3970c9f5448d3();
  thread namespace_5b6d7d7426cd03ec::function_5952e3fc7a3d83d0();
  thread namespace_5643a6b7e3dcbf23::function_3be70b1887ed619b("control_room", "control_room_death");
  thread namespace_5b6d7d7426cd03ec::function_aca8777d433c4eae();
  thread namespace_5b6d7d7426cd03ec::function_57bbf30ebc06df80();
}

function function_ee4ba7cebcb42a6d() {
  namespace_5b6d7d7426cd03ec::function_ac114b6e06024b31();
  utility::trigger_off("server_room_spawn_trigger", "script_noteworthy");
  utility::trigger_off("server_room2_spawn_trigger", "script_noteworthy");
  utility::trigger_off("server_room_stairs_spawn_trigger", "script_noteworthy");
  utility::trigger_off("control_room_spawn_trigger", "script_noteworthy");
  utility::trigger_off("control_room2_spawn_trigger", "script_noteworthy");
  utility::flag_set("player_in_elevator");
}

function second_floor_start() {
  partner = utility::spawn_targetname("partner");
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_9650e3f7359ae899();
  utility::set_start_location("lower_base_second_floor_start", [level.player, partner]);
  thread namespace_5643a6b7e3dcbf23::set_objective("server_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_big_screen_room", 3.5, 3.5);
}

function second_floor_main() {
  thread namespace_5643a6b7e3dcbf23::function_3be70b1887ed619b("control_room_2nd_floor", "2nd_floor_ambush_death");
  thread namespace_5b6d7d7426cd03ec::function_1d1b842f443a69b0();
}

function second_floor_catchup() {
  utility::trigger_off("second_floor_spawn_trigger", "script_noteworthy");
  utility::trigger_off("second_floor_combat_trigger", "script_noteworthy");
  utility::flag_set("2nd_floor_ambush_death");
}

function function_6096030287339a4e() {
  partner = utility::spawn_targetname("partner");
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_a4e758a8c87d908();
  utility::set_start_location("lower_base_maintenance_start", [level.player, partner]);
  thread namespace_5643a6b7e3dcbf23::set_objective("server_room");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_big_screen_room", 3.5, 3.5);
}

function function_8b81a38e620a00d7() {
  thread namespace_5b6d7d7426cd03ec::function_b8852401d3d4bc94();
  namespace_5b6d7d7426cd03ec::function_ade8b458bbcf24ac();
  thread utility::autosave_by_name("maintenance_door");
}

function function_8da8491fe37fc54() {
  utility::flag_set("stealth_enabled");
  thread namespace_5b6d7d7426cd03ec::start_fan();
}

function missile_room_start() {
  partner = utility::spawn_targetname("partner");
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_44f9515e001340aa();
  utility::set_start_location("lower_base_missile_room_start", [level.player, partner]);
  thread namespace_5643a6b7e3dcbf23::set_objective("missile_room");
}

function function_ad5dcd76778dd281() {
  thread utility::trigger_off("silo_room_trigger", "targetname");
  thread function_2f6c1faffde1783f();
  namespace_5b6d7d7426cd03ec::function_1917b3350f2de333();
  namespace_5b6d7d7426cd03ec::function_39589eceda13cc2d();
  thread namespace_5b6d7d7426cd03ec::function_a3c019859ba20bab();
  namespace_5b6d7d7426cd03ec::function_353fc1f21ff1b646();
}

function function_ba9a9423ac548b2e() {
  utility::trigger_off("silo_vent_spawn_trigger", "script_noteworthy");
  utility::trigger_off("silo_room_trigger", "targetname");
  level.player scripts\sp\utility::function_fef4d6151e091533();
}

function function_2f6c1faffde1783f() {
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_bunker_lower_missile_room", 3.5, 3.5);
  thread play_loopsound_in_space("scn_jup_silo_missile_steam_lp", (3894, 2548, -216));
  level waittill("audio_timer_started");
  wait 1;
  var_f9b29d74dfec4c38 = spawn("script_origin", (3900, 2550, -200));
  var_f9b29d74dfec4c38 playLoopSound("scn_jup_silo_missile_alarm_lp", (3900, 2550, -200));
  flag_wait_any("timer_ran_out", "audio_final_expl");
  var_f9b29d74dfec4c38 delete();
}

function exit_tunnel_start() {
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_14143b21b303fb2f();
  utility::set_start_location("lower_base_exit_tunnel_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("tunnel_exit");
  thread namespace_5b6d7d7426cd03ec::partner_countdown(3, 0);
}

function function_73fa224d01ddf284() {
  thread namespace_5643a6b7e3dcbf23::function_7af34098c3733bad("tunnel_jugg", "tunnel_jugg_enemy_dead", 135);
  thread namespace_1542dec1529315d1::function_f0f47cc310daabd9();
  utility::flag_wait("player_near_exit_ladder");
  thread namespace_1542dec1529315d1::function_adb8f2f280de1b09(2);
  thread namespace_5643a6b7e3dcbf23::function_d5eb6ecac5c4d41f("tunnel_exit", 105);
}

function function_fa9ddd3cab0c2165() {
  thread namespace_1542dec1529315d1::function_adb8f2f280de1b09(0.05);
  utility::flag_set("player_exiting_tunnels");
}

function function_1f20bcef5d5ccf3f() {
  thread scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting::function_42f8cbedde1b65f9();
  utility::set_start_location("lower_base_hatch_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("tunnel_hatch");
  thread namespace_5b6d7d7426cd03ec::partner_countdown(2, 1);
}

function function_e972bdc1c1628668() {
  thread namespace_1542dec1529315d1::function_19a44b1f37ab195d();
  utility::flag_wait("player_exiting_tunnels");
  thread namespace_1542dec1529315d1::function_5e109671e55c38ac();
  thread namespace_1542dec1529315d1::function_e89741f90abbed17();
  utility::flag_wait("player_is_exiting_hatch");
  utility::flag_clear("player_is_underground");
  level.var_398625fd66048065 = utility::spawn_script_origin((3966, 2605, 0));
  level.var_398625fd66048065 playLoopSound("scn_jup_silo_missile_steam_topside_lfe_lp");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_exfil_firefight", 3.5, 3.5);
  exploder("finale_cctv_kickup");
}

function function_fb5b9a581abaa551() {
  silo_lighting::function_e5d8995bd86eabe6();
  utility::flag_set("command_tower_death");
  utility::flag_clear("player_is_underground");
}

function outro_start() {
  utility::set_start_location("upper_base_finale_start", [level.player]);
  thread namespace_5643a6b7e3dcbf23::set_objective("outro");
  level.var_398625fd66048065 = utility::spawn_script_origin((3966, 2605, 0));
  level.var_398625fd66048065 playLoopSound("scn_jup_silo_missile_steam_topside_lfe_lp");
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_exfil_firefight", 3.5, 3.5);
}

function outro_main() {
  thread namespace_1542dec1529315d1::function_2489a54543e0f936();
  namespace_1542dec1529315d1::function_941171e175abcc49();
  namespace_1542dec1529315d1::function_73cbe7e4760e5b90();
  utility::nextmission();
}

function function_d53be00830317b3d() {}

function cctv_shot() {
  function_44763f38fc2e961b();
  thread function_a162bf76d2c9f8ca();
  exploder("underground_exploder");
}

function function_a162bf76d2c9f8ca() {
  function_301d4b20f9c195af();
  wait 0.3;
  animnode = getStruct("cctv_animnode", "targetname");
  spawner = getspawner("cctv_enemy", "targetname");

  for(i = 1; i <= 11; i++) {
    ai = spawner spawn_ai(1, 1);
    ai.animname = "cctv_" + i;
    ai thread function_1cb1f93f9f04d0e7(animnode);
    waitframe();
  }

  wait 0.4;
  flag_set("start_cctv");
  level waittill("forever");
}

function function_1cb1f93f9f04d0e7(animnode) {
  scripts\common\ai::gun_remove();
  animnode anim_first_frame_solo(self, "cctv");
  flag_wait("start_cctv");
  wait 1;

  while(true) {
    animnode anim_single_solo(self, "cctv");
  }
}

function cctv_explosion() {
  function_44763f38fc2e961b();
  thread function_cce8548a6619ea63();
  exploder("underground_exploder");
  wait 5;
  exploder("finale_cctv_kickup");
  waitframe();
  exploder("finale_cctv_explosion");
}

function function_cce8548a6619ea63() {
  function_2fce22e8802b0c7a();
  level waittill("forever");
}

function cctv_idle() {
  function_44763f38fc2e961b();
  thread function_ede02c8a1734758();
}

function function_ede02c8a1734758() {
  function_2fce22e8802b0c7a();
  level waittill("forever");
}

function function_44763f38fc2e961b() {
  utility::trigger_off("silo_vent_spawn_trigger", "script_noteworthy");
  utility::trigger_off("silo_room_trigger", "targetname");
  thread namespace_5b6d7d7426cd03ec::function_ac114b6e06024b31();
  function_1b03b77dbd5b6c6f();
}

function function_2fce22e8802b0c7a() {
  function_301d4b20f9c195af();
  wait 0.3;
  animnode = getStruct("cctv_animnode", "targetname");
  spawner = getspawner("cctv_enemy", "targetname");
  ai = spawner spawn_ai(1, 1);
  ai.animname = "cctv_1";
  ai hide();
  ai endon("death");

  while(true) {
    animnode anim_single_solo(ai, "cctv");
  }
}

function function_301d4b20f9c195af() {
  level.scr_xcam["cctv"] = "jup_silo_control_room_cctv_cam01";

  if(getdvarint(@ "hash_23f04eacda6008de")) {
    level.scr_xcam["cctv"] = "jup_silo_control_room_cctv_cam02";
  }
}

function function_1b03b77dbd5b6c6f() {
  registered = "igc";
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "cinematic_motion", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "damage", 0);
  level.player val::set(registered, "breath_system", 0);
  level.player val::set(registered, "show_hud", 0);
}

function function_fd7e63a80999d0b9() {
  level endon("end_audio_pa");
  wait 10;
  audioent = spawn("script_origin", (0, 0, 0));
  level waittill("start_audio_pa");

  while(true) {
    audioent playLoopSound("milbase_alarm");
    wait 3;
  }
}