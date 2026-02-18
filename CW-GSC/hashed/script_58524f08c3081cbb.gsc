/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_58524f08c3081cbb.gsc
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
#namespace namespace_5d7a2dac;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
  thread function_b7d8556a();
}

function private _objective(objective) {
  switch (objective) {
    case # "hash_65e6eae762f128ac":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>");

      break;
  }
}

function music(str_msg, n_delay = 0) {
  level thread function_7edafa59(str_msg, n_delay);
  level thread function_e80c0ccf(str_msg);
}

function function_7edafa59(str_msg, n_delay) {
  switch (str_msg) {
    case # "hash_2ee5843b582dba8":
    case # "hash_e896bbfc4467554":
    case # "7.0_combat_3":
    case # "hash_168af7f88044b6ce":
    case # "hash_3298180a203dc742":
    case # "8.0_ireadyou":
    case # "hash_58f346e277c63b97":
    case # "hash_5905b34ca4b2af82":
    case # "hash_5b9d3c7755ed2641":
    case # "6.0_tunnel":
    case # "10.0_surveying":
    case # "11.0_dig_site":
    case # "9.0_reunited":
    case # "11.2_airlift":
    case # "hash_7f14e478924d3d3f":
      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_ce25a6502e59743":
    case # "hash_356eaedb9f6c3dc3":
      music::function_edda155f(str_msg, n_delay);
      break;
    case # "hash_2193c42e21ea2e63":
      music::function_2af5f0ec(str_msg);
      break;
    case # "hash_77247bb51de4a650":
      music::setmusicstate("none", undefined, n_delay);
      break;
    default:

      iprintlnbold("<dev string:x60>" + str_msg + "<dev string:x72>");

      break;
  }
}

function function_e80c0ccf(str_msg) {
  switch (str_msg) {
    case # "hash_58f346e277c63b97":
      snd::client_msg(#"musictrack_cp_yamantau_1");
      break;
    case # "hash_7f14e478924d3d3f":
      snd::client_msg(#"musictrack_cp_yamantau_2");
      break;
    case # "6.0_tunnel":
      snd::client_msg(#"musictrack_cp_yamantau_3");
      break;
    case # "10.0_surveying":
      snd::client_msg(#"musictrack_cp_yamantau_4");
      break;
    case # "11.0_dig_site":
      snd::client_msg(#"musictrack_cp_yamantau_5");
      break;
  }
}

function function_b7d8556a() {
  level waittill(#"chyron_menu_closed");
  snd::client_msg("audio_level_begin_duck_stop");
}