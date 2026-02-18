/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3b2905ec05ed796.gsc
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
#namespace namespace_95f223d5;

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
    case # "infil":
      break;
    case # "emp_flash":
      break;
    case # "Courtyard":
      break;
    case # "catacombs":
      break;
    case # "graveyard":
      break;
    case # "hash_7433baf853004942":
      break;
    case # "looseends":
      break;
    case # "no_game":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>");

      break;
  }
}

function music(str_msg, n_delay = 0, var_37a6c96) {
  level thread function_7edafa59(str_msg, n_delay, var_37a6c96);
  level thread function_e80c0ccf(str_msg);
}

function function_7edafa59(str_msg, n_delay, var_37a6c96) {
  switch (str_msg) {
    case # "hash_285fcad4eed33c36":
    case # "5.0_graveyard":
    case # "hash_311870cc10f713f7":
    case # "1.5_approach_checkpoint":
    case # "hash_3bc476ac50672ed8":
    case # "hash_3e2efa7311d0cb4c":
    case # "6.0_danger_close":
    case # "1.0_approach":
    case # "hash_7eaa1ee46f7c9913":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_581c2b78798ae4fb":
      music::function_edda155f(str_msg, n_delay);
      break;
    case # "hash_2193c42e21ea2e63":
      music::function_2af5f0ec(str_msg);
      break;
    case # "hash_31402ddc8eade354":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate("none", undefined, n_delay);
      break;
    default:

      iprintlnbold("<dev string:x60>" + str_msg + "<dev string:x72>");

      break;
  }
}

function function_e80c0ccf(str_msg) {
  switch (str_msg) {
    case # "1.0_approach":
      snd::client_msg(#"musictrack_cp_siege_1");
      break;
    case # "hash_311870cc10f713f7":
      snd::client_msg(#"musictrack_cp_siege_2");
      break;
  }
}

function function_b7d8556a() {
  level waittill(#"chyron_menu_closed");
  snd::client_msg("audio_level_begin_duck_stop");
}

function ending_fade_out() {
  level waittill(#"ending_fade_out");
  snd::client_msg("ending_fade_out");
}