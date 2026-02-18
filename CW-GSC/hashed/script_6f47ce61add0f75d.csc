/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6f47ce61add0f75d.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_353d803e;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::function_5e69f468(&_objective);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  audio::function_d3790fe();
  function_4999d3f6();
  level.player = snd::getplayerssafe()[0];
}

function function_4999d3f6() {
  plr = undefined;
  var_d4262ab9 = [];
  snd::element_init("$default", var_d4262ab9);
  var_73f90778 = [["amb_elm_door_distant", plr, [15, 30], [700, 1500], [-15, 15]]];
  snd::element_init("kgb_atrium", var_73f90778);
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "player":
      level.player = ent;
      level.player waittill(#"death", #"disconnect");
      level.player = undefined;
      break;
    case # "veh_escape_vehicle":
      level.veh_escape_vehicle = ent;
      ent waittill(#"death");
      level.escape_vehicle = undefined;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + snd::function_783b69(name, "<dev string:x5d>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case # "$default":
      break;
    case # "hash_2c9d4ec293d7e4e":
    case # "hash_c205d7dcba49ef1":
    case # "hash_17e91a001ef73783":
    case # "hash_19ec6f609219919d":
    case # "hash_1e6f9008500856d2":
    case # "hash_2a286a23dcd8c8e0":
    case # "hash_3b88d5b7f1e5c437":
    case # "kgb_atrium":
    case # "hash_6a021f99de04f76a":
    case # "hash_76fa75b94c82dabe":
    case # "hash_790a9135c7f2630d":
      snd::set_element(trigger, trigger_name);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "hash_7527c0556d529822":
      break;
    case # "atrium_reveal":
      level notify(#"atrium_reveal");
      break;
    case # "map_submix_on":
      function_5ea2c6e3("cp_rus_kgb_map", 0.3, 1);
      break;
    case # "map_submix_off":
      function_ed62c9c2("cp_rus_kgb_map", 0.15);
      break;
    case # "hash_695d2aba2d66c4b2":
      thread function_f115b891();
      break;
    case # "hash_4b5a6716aab86d8e":
      thread function_4f6ed87();
      break;
    case # "hash_72fda24008633c70":
      thread function_8d03afce();
      break;
    case # "hash_3d26d1914456dcbe":
      level notify(#"hash_2bc6846f8274a4c4");
      break;
    case # "hash_3398664455247bac":
      thread function_3c3d7227();
      break;
    case # "hash_441b6b70aae75c67":
      wait 3.7;
      thread function_6186bcc6();
      break;
    case # "hash_43c1a41f59a490d6":
      thread function_4df52367();
      break;
    case # "hash_2d4abae990c4399":
      thread function_9c460fd();
      break;
    case # "hash_4ec9a2c1432e46bb":
      level notify(#"hash_173e440cd550970f");
      break;
    case # "hash_c1613dbfb7218d0":
      level notify(#"hash_39ef84876415aee7");
      thread function_359db1e6();
      break;
    case # "hash_68f5c5f77549c363":
      function_672403ca("cp_rus_kgb_briefing", 2, 0.5);
      break;
    case # "hash_4784d9dbd4d07023":
      function_ed62c9c2("cp_rus_kgb_briefing", 1);
      break;
    case # "hash_4692f2d7c81a7c95":
      thread function_1dd0dad7();
      break;
    case # "hash_645d2b3398bf399c":
      thread function_dfe73855();
      break;
    case # "hash_1a618ec692a1e9e3":
      thread function_6ad4463a();
      break;
    case # "hash_3e2a2b64b78567ad":
      thread function_6ec08763();
      break;
    case # "hash_9db8f264f5d0a4c":
      thread function_2f2c3cdf();
      break;
    case # "hash_1d5a01df795ac3d2":
      thread function_48779979();
      break;
    case # "hash_df2f3038c7a4515":
      thread function_b9840();
      break;
    case # "hash_24e50b51fc3d3d2d":
      thread function_c416f75a();
      break;
    case # "hash_2582bdd148041a03":
      thread function_acc47dc2();
      break;
    case # "hash_810337327e9b45d":
      thread function_71130ea6();
      break;
    case # "hash_2ef69949c5586784":
      thread function_b568c231();
      break;
    case # "hash_2520e050afad6b28":
      thread function_535461fd();
      break;
    case # "hash_134c64c3689b26d8":
      thread function_b9d77749();
      break;
    case # "hash_8fb789398a122bf":
      thread function_d005c58b();
      break;
    case # "hash_13de9c8b5a620fc3":
      thread function_3555a373();
      break;
    case # "hash_326d7039d6caf74":
      thread function_a8eb2830();
      break;
    case # "hash_6c7e5d8f2665fc0c":
      thread function_7ebfde85();
      break;
    case # "hash_50da385a52268cf2":
      thread function_126bd5a3();
      break;
    case # "hash_305096503618cca":
      thread function_1954faa8();
      break;
    case # "hash_1d0a63220c75a83c":
      thread function_a44bdb37();
      break;
    case # "hash_7573f73261e72989":
      thread function_7b1d476b();
      break;
    case # "hash_66f0b482b018f16c":
      thread function_e9a2d784();
      break;
    case # "hash_260009c64f919000":
      level notify(#"hash_260009c64f919000");
      break;
    case # "hash_2b37662433e62e4a":
      level notify(#"hash_2b37662433e62e4a");
      break;
    case # "hash_562e2588670856dc":
      thread function_952fa759();
      break;
    case # "hash_284e37a8f41f8182":
      thread function_aeb5c3be();
      break;
    case # "hash_4a58b7be1af1818c":
      thread function_c8547f0b();
      break;
    case # "hash_182e794f60a3848b":
      level notify(#"hash_182e794f60a3848b");
      break;
    case # "hash_2b88d5deda9b0cb8":
      thread function_6e29bca9();
      break;
    case # "hash_71b18c4ea1c4cea2":
      thread function_7ae3098e();
      break;
    case # "hash_2705a705c011de47":
      thread function_a3b23b0f();
      break;
    case # "hash_2d7e4cbd73ad29fb":
      level notify(#"hash_10c1d2c0d2f43070");
      break;
    case # "exfil_car_pullup":
      exfil_car_pullup();
      break;
    case # "exfil_car_enter":
      thread exfil_car_enter();
      thread function_1f99f8ec();
      break;
    case # "musictrack_cp_kgb_1":
    case # "musictrack_cp_kgb_3":
    case # "musictrack_cp_kgb_2":
    case # "musictrack_cp_kgb_4":
    case # "musictrack_cp_kgb_6":
    case # "musictrack_cp_kgb_5":
      function_2cca7b47(0, msg);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  switch (objective) {
    case # "kgb_ins_activation":
      break;
    case # "kgb_ins_briefing":
      thread function_4fb5552e();
      thread function_6186bcc6();
      break;
    case # "kgb_ins_tutorial":
      thread function_4df52367();
      break;
    case # "kgb_ins_prepare":
      thread function_4df52367();
      break;
    case # "kgb_ins_rv":
      thread function_4df52367();
      break;
    case # "kgb_aslt_entry":
      thread function_de171641();
      break;
    case # "kgb_aslt_elev_down":
      thread function_de171641();
      break;
    case # "kgb_aslt_bunker":
      break;
    case # "kgb_aslt_vault_approach":
      break;
    case # "kgb_aslt_vault_breach":
      break;
    case # "kgb_aslt_vault":
      break;
    case # "kgb_aslt_bunker_escape":
      break;
    case # "kgb_aslt_escape_lights_out":
      break;
    case # "kgb_aslt_escape_deploy_gas":
      break;
    case # "kgb_aslt_exfil":
      thread function_478dc292();
      thread function_95b3471f();
      break;
    case # "kgb_aslt_exfil_escape":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>");

      break;
  }
}

function function_f4062e4e() {
  var_85107416 = snd::play("evt_kgb_intro_hallway_door_shut_lp", (-145, -722, 442));
  level waittill(#"hash_351de52eb5de645d");
  snd::stop(var_85107416, 1);
}

function function_f115b891() {
  wait 1.2;
  snd::play("evt_use_computer_power_on_intro", (-252, -713, 447));
  thread function_8362159();
  wait 0.79;
  snd::play("evt_kgb_computer_beep_02");
  snd::play("evt_kgb_intro_bootup_01");
  wait 1.39;
  snd::play("evt_kgb_intro_bootup_02");
  wait 0.9;
  snd::play("evt_kgb_computer_beep_01");
  function_5ea2c6e3("cp_rus_kgb_intro_amb", 4, 1);
  wait 6;
  thread function_4fb5552e();
  level waittill(#"atrium_reveal");
  function_672403ca("cp_rus_kgb_intro_music", 3, 0.3);
  wait 5;
  function_672403ca("cp_rus_kgb_intro_music", 8, 0.5);
}

function function_4fb5552e() {
  if(is_true(level.var_72121827)) {
    return;
  }

  level.var_72121827 = 1;
  function_5ea2c6e3("cp_rus_kgb_intro_music", 4, 0.8);
}

function function_8362159() {
  var_88e5db8 = snd::play("evt_use_computer_hum_lp_intro", (-252, -713, 447));
  level waittill(#"hash_6d1602671b9ea1a9");
  snd::stop(var_88e5db8, 1);
}

function function_4f6ed87() {
  players = snd::function_da785aa8();
  player = players[0];
  snd::play("evt_kgb_intro_connect_lean");
  wait 1.5;
  snd::play("evt_kgb_intro_encrypt_call", [player, "J_Wrist_LE"]);
  wait 4.3;
  var_2a71664d = snd::play("evt_kgb_intro_encryption_static_lp", [player, "J_Wrist_LE"]);
  level waittill(#"hash_2bc6846f8274a4c4");
  snd::play("evt_use_computer_line_keystroke");
  snd::play("evt_kgb_intro_disconnect_call", [player, "J_Wrist_LE"]);
  snd::stop(var_2a71664d, 0.25);
  wait 2.35;
  var_94d28648 = snd::play("evt_kgb_intro_phone_dialtone", [player, "J_Wrist_LE"]);
  level waittill(#"hash_3ba0fc4b818c0ab4");
  snd::stop(var_94d28648, 0.1);
}

function function_8d03afce() {
  snd::play("evt_kgb_intro_door_knock", (-157, -624, 440));
}

function function_3c3d7227() {
  wait 4.4;
  snd::play("evt_kgb_intro_door_open", (-157, -624, 440));
  level notify(#"hash_351de52eb5de645d");
  function_ed62c9c2("cp_rus_kgb_intro_amb", 1);
  wait 0.35;
  snd::play("evt_kgb_intro_door_walla", (-157, -624, 440));
  wait 4;
  function_672403ca("cp_rus_kgb_intro_music", 4, 0.6);
}

function function_6186bcc6() {
  if(is_true(level.var_332d371c)) {
    return;
  }

  level.var_332d371c = 1;
  var_36d39ded = snd::play("amb_walla_atrium_lp", (-19, 24, 548));
  var_fa7f656e = snd::play("amb_atrium_activity_lp", (-19, 24, 548));
  var_8abcf52b = snd::play("amb_office_activity_med_lp_02", (355, -412, 478));
  var_2afb62c5 = snd::play("amb_walla_mailroom_lp", (355, -412, 478));
  var_87ed927d = snd::play("amb_hallway_activity_med_lp_01", (-27, -1061, 478));
  var_2e07bdc4 = snd::play("amb_walla_lobby_lp", (-27, -1061, 478));
  level waittill(#"hash_39ef84876415aee7");
  wait 0.5;
  snd::stop(var_36d39ded, 3);
  snd::stop(var_fa7f656e, 3);
  snd::stop(var_8abcf52b, 3);
  snd::stop(var_2afb62c5, 3);
  snd::stop(var_87ed927d, 3);
  snd::stop(var_2e07bdc4, 3);
}

function function_4df52367() {
  if(is_true(level.var_6e05a2b0)) {
    return;
  }

  level.var_6e05a2b0 = 1;
  var_84cdfd7b = snd::play("amb_walla_atrium_lp", (-19, 24, 548));
  var_683f77ed = snd::play("amb_atrium_activity_lp", (-19, 24, 548));
  var_71941716 = snd::play("amb_office_activity_med_lp_02", (355, -412, 478));
  var_8399f466 = snd::play("amb_walla_mailroom_lp", (355, -412, 478));
  var_2bf95c8e = snd::play("amb_hallway_activity_med_lp_01", (-27, -1061, 478));
  var_47b6f039 = snd::play("amb_walla_lobby_lp", (-27, -1061, 478));
  level waittill(#"hash_260009c64f919000");
  wait 0.5;
  snd::stop(var_84cdfd7b, 5);
  snd::stop(var_683f77ed, 5);
  snd::stop(var_71941716, 5);
  snd::stop(var_8399f466, 5);
  snd::stop(var_2bf95c8e, 5);
  snd::stop(var_47b6f039, 5);
  thread function_de171641();
}

function function_de171641() {
  if(is_true(level.var_2f4322dd)) {
    return;
  }

  level.var_2f4322dd = 1;
  var_ede2fdf9 = snd::play("amb_atrium_lockdown_lp", (-19, 24, 548));
  var_bda079fa = snd::play("amb_walla_atrium_lockdown_lp", (-19, 24, 548));
  var_bfa06f56 = snd::play("amb_walla_lobby_lockdown_lp", (-27, -1061, 478));
  level waittill(#"hash_2b37662433e62e4a");
  snd::stop(var_ede2fdf9, 5);
  snd::stop(var_bda079fa, 5);
  snd::stop(var_bfa06f56, 5);
}

function function_9c460fd() {
  var_4c9bf3e6 = snd::play("emt_radio_stakhanovmovement_lp_mn", (-1046, 979, 477));
  level waittill(#"hash_173e440cd550970f");
  snd::stop(var_4c9bf3e6, 1);
}

function function_359db1e6() {
  function_ed62c9c2("cp_rus_kgb_intro_music", 7);
}

function function_dbc25edd() {}

function function_1dd0dad7() {
  snd::play("evt_use_computer_plr_enter");
  wait 2.7;
  snd::play("evt_use_computer_power_on", (1957, -755, 278));
  var_e7a48d36 = snd::play("evt_use_computer_hum_lp", (1957, -755, 278));
  level waittill(#"hash_76fee64c370b1efe");
  snd::stop(var_e7a48d36, 1);
}

function function_dfe73855() {
  snd::play("evt_frame_charkov_remap_data", (1957, -755, 278));
}

function function_6ad4463a() {
  snd::play("evt_frame_charkov_print_evidence", (1316, -1147, 321));
}

function function_6ec08763() {
  wait 1.2;
  snd::play("evt_use_computer_power_off", (1957, -755, 278));
  level notify(#"hash_76fee64c370b1efe");
  wait 0.54;
  snd::play("evt_use_computer_plr_exit");
}

function function_2f2c3cdf() {}

function function_48779979() {}

function function_b9840() {}

function function_c416f75a() {}

function function_71130ea6() {
  snd::play("evt_obj_program_checkpoint_buzzer", (796, 900, 457));
  wait 0.5;
  snd::play("evt_obj_program_armory_door_open", (631, 935, 503));
}

function function_b568c231() {}

function function_535461fd() {
  snd::play("evt_obj_program_checkpoint_button");
  wait 0.25;
  snd::play("evt_obj_program_checkpoint_buzzer", (796, 900, 457));
  wait 0.5;
  snd::play("evt_obj_program_armory_door_open", (631, 935, 503));
}

function function_acc47dc2() {
  snd::play("evt_obj_program_pickup_paperwork");
}

function function_7ebfde85() {
  snd::play("evt_obj_program_pickup_cigar");
}

function function_b9d77749() {
  snd::play("evt_use_computer_plr_enter");
  wait 0.1;
  snd::play("evt_use_computer_power_on", (1157, 278, 439));
  var_4fa0df74 = snd::play("evt_use_computer_hum_lp", (1157, 278, 439));
  level waittill(#"hash_69d1b68cd250e0e0");
  snd::stop(var_4fa0df74, 1);
}

function function_d005c58b() {
  snd::play("evt_kgb_compute_data_03");
}

function function_3555a373() {
  snd::play("evt_use_computer_power_off", (1157, 278, 439));
  level notify(#"hash_69d1b68cd250e0e0");
  wait 1.66;
  snd::play("evt_use_computer_plr_exit");
}

function function_a8eb2830() {
  snd::play("evt_use_computer_power_off", (1157, 278, 439));
  level notify(#"hash_69d1b68cd250e0e0");
  wait 0.4;
  snd::play("evt_use_computer_plr_exit");
}

function function_1954faa8() {
  snd::play("evt_use_computer_plr_enter");
  wait 0.1;
  snd::play("evt_use_computer_power_on", (852, -964, 280));
  var_4fa0df74 = snd::play("evt_use_computer_hum_lp", (852, -964, 280));
  level waittill(#"hash_50b942fa70264008");
  snd::stop(var_4fa0df74, 1);
}

function function_a44bdb37() {
  snd::play("evt_use_computer_power_off", (852, -964, 280));
  level notify(#"hash_50b942fa70264008");
  wait 0.4;
  snd::play("evt_use_computer_plr_exit");
}

function function_126bd5a3() {
  snd::play("evt_obj_swipe_key_swipe_direct");
}

function function_7b1d476b() {
  wait 4.08;
  snd::play("evt_prison_gate_unlock", (-681, -1149, 458));
  wait 0.91;
  snd::play("evt_prison_gate_open", (-681, -1149, 458));
}

function function_e9a2d784() {
  wait 4.08;
  snd::play("evt_prison_gate_unlock", (-681, -1149, 458));
  wait 0.91;
  snd::play("evt_prison_gate_open", (-681, -1149, 458));
}

function function_952fa759() {
  wait 6.3;
  audio::snd_set_snapshot("cp_rus_kgb_elev_down");
}

function function_aeb5c3be() {
  wait 12.25;
  audio::snd_set_snapshot("");
}

function function_c8547f0b() {
  snd::play("evt_kgb_deploygas_remote_activate");
  wait 0.45;
  function_5ea2c6e3("cp_rus_kgb_deploygas_exp", 0.1, 1);
  snd::play("cin_kgb_deploygas_detonate", (-3276, -494, -1539));
  thread function_478dc292();
  wait 6.7;
  function_ed62c9c2("cp_rus_kgb_deploygas_exp", 2);
  wait 5.7;
  thread function_95b3471f();
}

function function_478dc292() {
  if(is_true(level.var_78495829)) {
    return;
  }

  level.var_78495829 = 1;
  snd::play("evt_deploygas_gas_lp", (-3115, 167, -1538));
  snd::play("evt_deploygas_gas_lp", (-3235, 362, -1592));
  snd::play("evt_deploygas_gas_lp", (-3557, 358, -1592));
  snd::play("evt_deploygas_gas_lp", (-3268, -803, -1589));
  snd::play("evt_deploygas_gas_lp", (-3108, -959, -1506));
  snd::play("evt_deploygas_gas_lp", (-3475, -1045, -1586));
  snd::play("evt_deploygas_gas_lp", (-3385, -776, -1457));
  snd::play("evt_deploygas_gas_lp", (-3102, -1217, -1503));
  snd::play("evt_deploygas_gas_lp", (-3318, -1835, -1707));
  snd::play("evt_deploygas_gas_lp", (-3343, -1824, -1639));
  snd::play("evt_deploygas_gas_lp", (-3226, -2208, -1707));
  snd::play("evt_deploygas_gas_lp", (-3546, -2624, -1656));
  snd::play("evt_deploygas_gas_lp", (-3273, -2744, -1666));
  snd::play("evt_deploygas_gas_lp", (-3242, -2650, -1434));
}

function function_95b3471f() {
  if(is_true(level.var_f30b9486)) {
    return;
  }

  level.var_f30b9486 = 1;
  var_6530ddf1 = snd::play("evt_kgb_gas_mask_breath_lp");
  level waittill(#"hash_182e794f60a3848b");
  wait 1;
  snd::stop(var_6530ddf1, 0.3);
}

function function_6e29bca9() {
  function_5ea2c6e3("cp_rus_kgb_pre_exfil_gearup", 0.1, 1);
  snd::play("evt_c4_bell_gearup_wpn_down");
  wait 6;
  snd::play("evt_c4_bell_gearup_fadeout");
  wait 6;
  function_ed62c9c2("cp_rus_kgb_pre_exfil_gearup", 2);
}

function function_7ae3098e() {
  snd::play("evt_c4_elevator_alarm", (837, 100, 462));
  wait 0.58;
  snd::play("evt_c4_elevator_close", (767, 102, 430));
  wait 1.42;
  snd::play("evt_c4_elevator_start");
  var_566fc3f1 = snd::play("evt_c4_elevator_lp");
  wait 15.5;
  snd::stop(var_566fc3f1, 1);
  snd::play("evt_c4_elevator_open", (767, 102, 430));
  wait 0.8;
  snd::play("evt_c4_sldr_walla_elevator_open", (461, 101, 467));
  thread function_65a78fed();
}

function function_65a78fed() {
  wait 2;
  function_5ea2c6e3("cp_rus_kgb_c4_slowmo", 0.5, 1);
  level waittill(#"hash_10c1d2c0d2f43070");
  snd::play("evt_c4_slowmo_stop");
  function_ed62c9c2("cp_rus_kgb_c4_slowmo", 1);
}

function function_a3b23b0f() {
  snd::play("evt_c4_explo_blast", (499, 99, 446));
  snd::play("evt_c4_explo_debris", (461, 101, 467));
  var_bb843c0 = snd::play("evt_c4_slowmo_lp");
  level waittill(#"hash_10c1d2c0d2f43070");
  snd::stop(var_bb843c0, 1);
}

function exfil_car_pullup() {
  snd::play("cin_exfil_car_pull_up", level.veh_escape_vehicle);
  wait 1.35;
  level.var_c29a15da = snd::play([1.2, "cin_exfil_car_idle_lp", 0.2], level.veh_escape_vehicle);
}

function exfil_car_enter() {
  snd::play("cin_exfil_car_enter", level.player);
  wait 2.6;
  function_5ea2c6e3("cp_rus_kgb_exfil", 0.25, 1);
  snd::stop(level.var_c29a15da, 0.25);
  level.var_e8a77cb2 = snd::play([0, "cin_exfil_car_idle_interior_lp", 0.25], level.veh_escape_vehicle);
  level waittill(#"floor_it_drive");
  wait 2.8;
  snd::play("cin_exfil_car_drive", level.veh_escape_vehicle);
  wait 0.6;
  snd::stop(level.var_e8a77cb2, 1);
  wait 4;
  function_5ea2c6e3("cp_rus_kgb_exfil_crash", 2, 1);
  setsoundcontext("slowmo", "true");
  wait 6.05;
  function_5ea2c6e3("cp_rus_kgb_exfil_crash2", 2, 1);
  wait 2;
  function_ed62c9c2("cp_rus_kgb_exfil_crash", 1);
  function_ed62c9c2("cp_rus_kgb_exfil_crash2", 1);
  setsoundcontext("slowmo", "");
}

function function_1f99f8ec() {
  level waittill(#"hash_2c0beb312425c5c7");
  function_5ea2c6e3("cp_rus_kgb_exfil_slowmo", 0.25, 1);
  snd::play("cin_exfil_car_adler_slowmo");
  level waittill(#"hash_6498bbe6e48dc96d");
  function_ed62c9c2("cp_rus_kgb_exfil_slowmo", 0.25);
  thread function_5b3d1f35();
}

function function_5b3d1f35() {
  wait 8;
  function_5ea2c6e3("cp_rus_kgb_exfil_outro", 0.25, 1);
}

function function_f0a1a424() {
  while(true) {
    level waittill(#"hash_33f4e556bc4883");

    snd::function_3ba3cecb("<dev string:xc7>");
  }
}