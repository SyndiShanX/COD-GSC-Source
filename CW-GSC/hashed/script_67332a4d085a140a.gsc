/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_67332a4d085a140a.gsc
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
#namespace namespace_61150688;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  level thread exfil();
}

function private _objective(objective) {
  switch (objective) {
    case # "tkdn_heli_intro":
      level thread heli_intro();
      break;
    case # "tkdn_heli_trailer_park":
    case # "tkdn_heli_hotel_parking_lot":
    case # "tkdn_heli_convoy_aslt":
      music("combat");
      break;
    case # "tkdn_heli_hotel_breach":
      music("");
      break;
    case # "tkdn_heli_exfil":
      music("");
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>");

      break;
  }
}

function music(var_b12adf3) {
  level.var_825fa088 = [];
  level.var_825fa088[#"intro"] = "1_0_intro";
  level.var_825fa088[#"combat"] = "2_1_combat";
  level.var_825fa088[#"breach"] = "3_0_breach";
  level.var_825fa088[#"kill_confirmed"] = "4_0_kill_confirmed";
  level.var_825fa088[#"chopper_down"] = "5_0_chopper_down";
  level.var_825fa088[#"escape"] = "6_1_escape";
  level.var_825fa088[#"exfil"] = "7_0_exfil";
  state = level.var_825fa088[var_b12adf3];

  if(!isDefined(var_b12adf3) || !isDefined(state)) {
    state = "";
  }

  snd::waitforplayers();
  music::setmusicstate(state);
}

function heli_intro() {
  level waittill(#"hash_7fd5da39cde7ddef");
  music("intro");
  snd::client_msg("heli_intro_music");
  level waittill(#"hash_6bd0c3833569cd67");
  snd::client_msg("heli_door_open");
  level waittill(#"hash_68135a607affd904");
  wait 1;
  music("combat");
}

function breach() {
  level waittill(#"hash_30f8c0265810bdb1");
  wait 0.1;
  music("breach");
  level flag::wait_till("aldrich_dead");
  wait 1;
  music("kill_confirmed");
}

function function_e6aee48f() {
  wait 2.2;
  snd::play("evt_sm_tkd_heli_spinout_rpg", level.var_9a3944f4);
  wait 5.08;
  snd::play("evt_sm_tkd_heli_crash_mountain_explo", level.var_9a3944f4);
}

function function_d27e1651() {
  music("");
  wait 0.3;
  music("chopper_down");
  wait 6;
  music("escape");
}

function exfil() {
  level flag::wait_till("gas_station_escape_complete");
  music("exfil");
}