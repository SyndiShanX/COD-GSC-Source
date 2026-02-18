/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5991d6501121591f.gsc
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
#namespace namespace_232ddc52;

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

function music(str_msg, n_delay = 0, var_37a6c96) {
  level thread function_7edafa59(str_msg, n_delay, var_37a6c96);
  level thread function_e80c0ccf(str_msg);
}

function function_7edafa59(str_msg, n_delay, var_37a6c96) {
  switch (str_msg) {
    case # "hash_15fb340cedd54be0":
    case # "12.0_contact":
    case # "6.0_courtyard":
    case # "hash_3a9df7a31adcbe86":
    case # "hash_43dc315825596956":
    case # "hash_4a2df20c6bf3fde8":
    case # "14.0_airhook":
    case # "13.1_rooftop":
    case # "1.0_intro":
    case # "4.0_palace":
    case # "hash_5caedcc33eee2ae5":
    case # "hash_68e666f52326ec97":
    case # "5.0_minefield":
    case # "3.0_plaza":
      if(isDefined(var_37a6c96)) {
        flag::wait_till(var_37a6c96);
      }

      music::setmusicstate(str_msg, undefined, n_delay);
      break;
    case # "hash_5d430841fdfe87c0":
      music::function_edda155f(str_msg, n_delay);
      break;
    case # "14.2_airhook_lazar":
    case # "14.1_airhook_park":
    case # "14.3_airhook_fail":
      music::function_edda155f(str_msg, n_delay);
      music::setmusicstate("none", undefined, n_delay);
      break;
    case # "hash_2193c42e21ea2e63":
      music::function_2af5f0ec(str_msg);
      break;
    case # "deactivate_6.0_courtyard":
    case # "hash_65aec99d0190420f":
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
    case # "1.0_intro":
      snd::client_msg(#"musictrack_cp_cuba_1");
      break;
    case # "4.0_palace":
      snd::client_msg(#"musictrack_cp_cuba_2");
      break;
    case # "hash_3a9df7a31adcbe86":
      snd::client_msg(#"musictrack_cp_cuba_3");
      break;
    case # "hash_4a2df20c6bf3fde8":
      snd::client_msg(#"musictrack_cp_cuba_4");
      break;
    case # "13.1_rooftop":
      snd::client_msg(#"musictrack_cp_cuba_5");
      break;
  }
}

function function_b7d8556a() {
  level waittill(#"chyron_menu_closed");
  snd::client_msg("audio_level_begin_duck_stop");
}