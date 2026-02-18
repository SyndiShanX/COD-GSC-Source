/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_46407e4cf62c1a9e.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_61150688;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::function_5e69f468(&_objective);
  snd::trigger_init(&_trigger);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  audio::function_21f8b7c3();
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "woods":
      level.woods = ent;
      ent waittill(#"death");
      level.woods = undefined;
      break;
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
    case # "chopper_interior_open":
    case # "chopper_interior":
      break;
    case # "trailer_park":
      break;
    case # "gas_station":
    case # "hash_2f729a7b8a49915c":
    case # "hash_349b30c47da883f7":
      break;
    case # "hash_d51c18e8de6b968":
    case # "hash_de86bed30711149":
    case # "hash_31e3a6f7cf5f48ed":
    case # "hash_58c23e8563e35e75":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x62>" + trigger_name + "<dev string:x5d>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "hash_37a62ab7a23cfc44":
      break;
    case # "hash_515c6d481df889cb":
      forceambientroom("chopper_interior_open");
      thread function_eb8c6b8e();
      break;
    case # "intro_trans_out":
      level notify(#"intro_trans_out");
      forceambientroom("");
      break;
    case # "stop_camera_zoom":
      players = snd::function_da785aa8();
      player = players[0];

      if(isDefined(player.var_1523fda0)) {
        snd::stop(player.var_1523fda0);
      }

      break;
    case # "hash_5c7e1a43ba45c2b4":
      thread function_1477a4b9();
      break;
    case # "hash_305dcf2b80864ec":
      thread function_f9003ea1();
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x86>" + snd::function_783b69(msg, "<dev string:x5d>"));

      break;
  }
}

function private _objective(objective) {
  switch (objective) {
    case # "tkdn_heli_intro":
      forceambientroom("chopper_interior");
      thread function_86127769();
      break;
    case # "tkdn_heli_convoy_aslt":
      function_ed62c9c2("cp_sm_tkdn_heli_interior", 1);
      thread function_cae705ff();
      break;
    case # "tkdn_heli_trailer_park":
      thread function_cae705ff();
      break;
    case # "tkdn_heli_hotel_parking_lot":
      thread function_cae705ff();
      break;
    case # "tkdn_heli_hotel_breach":
      thread function_cae705ff();
      break;
    case # "tkdn_heli_exfil":
      forceambientroom("");
      thread function_cae705ff();
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xa4>" + objective + "<dev string:x5d>");

      break;
  }
}

function function_327abcaf() {
  if(is_true(level.var_a364c876)) {
    return;
  }

  level.var_a364c876 = 1;
  function_5ea2c6e3("cp_sm_tkdn_intro_black", 0, 1);
}

function function_86127769() {
  if(is_true(level.var_b422391c)) {
    return;
  }

  level.var_b422391c = 1;
  function_5ea2c6e3("cp_sm_tkdn_intro_black", 0, 1);
  wait 9;
  function_ed62c9c2("cp_sm_tkdn_intro_black", 4);
  function_5ea2c6e3("cp_sm_tkdn_heli_interior", 4, 1);
}

function function_eb8c6b8e() {
  if(is_true(level.var_75676a02)) {
    return;
  }

  level.var_75676a02 = 1;
  function_5ea2c6e3("cp_sm_tkdn_heli_int_mus_down", 0.1, 1);
  wait 6;
  function_ed62c9c2("cp_sm_tkdn_heli_int_mus_down", 2);
  wait 20;
  function_ed62c9c2("cp_sm_tkdn_heli_interior", 6.5);
}

function function_cae705ff() {
  if(is_true(level.var_eabcd160)) {
    return;
  }

  level.var_eabcd160 = 1;
  function_5ea2c6e3("cp_sm_tkdn_combat", 1, 1);
}

function function_85ebb65() {
  if(is_true(level.var_948dd971)) {
    return;
  }

  level.var_948dd971 = 1;
  function_ed62c9c2("cp_sm_tkdn_combat", 1);
}

function function_1477a4b9() {
  wait 1;
  function_ed62c9c2("cp_sm_tkdn_combat", 1);
  snd::play("evt_evac_chopper_cockpit_lp", 1);
  snd::play("veh_evac_chopper_jetwhine_lp", 1);
  snd::play("veh_evac_chopper_fake_dist_lp", 1);
  function_5ea2c6e3("cp_sm_tkdn_evac_chopper", 1, 1);
  snd::play("evt_evac_chopper_board");
}

function function_f9003ea1() {
  if(is_true(level.var_3565723c)) {
    return;
  }

  level.var_3565723c = 1;
  wait 5;
  function_ed62c9c2("cp_sm_tkdn_evac_chopper", 3.5);
  function_5ea2c6e3("cp_sm_tkdn_outro_fadeout", 3.5, 1);
}