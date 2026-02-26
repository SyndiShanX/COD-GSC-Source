/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_290b454abd681dd4.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
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
#namespace namespace_c1cfab6c;

function private event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_5e69f468(&_objective);
}

function private event_handler[event_cc819519] function_686b88aa(eventstruct) {
  snd::wait_init();
  snd::waitforplayers();
}

function private _objective(objective) {
  switch (objective) {
    case # "tundra_intro":
      level thread intro();
      break;
    case # "tundra_combat":
      level thread function_eb09e7df();
      break;
    case # "dev_vip_active":
      level thread function_eb09e7df();
      break;
    case # "tundra_outro":
      level thread outro();
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
  level.var_825fa088[#"infiltrate"] = "2_0_infiltrate";
  level.var_825fa088[#"inside"] = "3_0_inside";
  level.var_825fa088[#"last_building"] = "4_0_last_building";
  level.var_825fa088[#"chase"] = "5_0_chase";
  level.var_825fa088[#"breach"] = "6_0_breach";
  level.var_825fa088[#"kill_confirmed"] = "7_0_kill_confirmed";
  level.var_825fa088[#"defend"] = "8_0_defend";
  level.var_825fa088[#"exfil"] = "9_0_exfil";

  if(var_b12adf3 == "combat" || var_b12adf3 == "search") {
    var_b12adf3 = function_95410ce0();
  }

  state = level.var_825fa088[var_b12adf3];

  if(!isDefined(var_b12adf3) || !isDefined(state)) {
    state = "";
  }

  snd::waitforplayers();
  music::setmusicstate(state);
}

function function_53e12236() {
  clear_flags = ["search_objective_1_cleared", "search_objective_2_cleared", "search_objective_3_cleared"];
  var_a2cb6282 = 0;

  foreach(clear in clear_flags) {
    if(flag::get(clear)) {
      var_a2cb6282++;
    }
  }

  return var_a2cb6282;
}

function function_95410ce0() {
  combat_music = ["infiltrate", "inside", "last_building", "chase"];
  var_d885a2f8 = function_53e12236();
  var_b12adf3 = combat_music[var_d885a2f8];
  return var_b12adf3;
}

function function_eb09e7df() {
  level notify(#"hash_891ea93a03b3ed7");
  level endon(#"hash_891ea93a03b3ed7");
  cleared = -1;

  while(cleared < 3) {
    var_6fd94a1c = function_53e12236();

    if(cleared != var_6fd94a1c) {
      cleared = var_6fd94a1c;
      wait 3;
      var_b12adf3 = function_95410ce0();
      music(var_b12adf3);

      if(cleared >= 3) {
        break;
      }
    }

    waitframe(1);
  }
}

function intro() {
  music("intro");
  missile = getent("tundra_intro_missile", "targetname");
  level waittill(#"hash_227caa557c6d6e99");

  if(isDefined(missile)) {
    snd::client_targetname(missile, "missile");
  }

  level waittill(#"hash_75e302a823ba736d");
  wait 0.5;
  level thread function_eb09e7df();
}

function breach() {
  level waittill(#"hash_30f8c0265810bdb1");
  snd::play("evt_door_kick_plr");
  wait 0.1;
  music("breach");
  assert(isDefined(level.vip), "<dev string:x60>");
  level.vip waittill(#"death");
  wait 1;
  music("kill_confirmed");
}

function function_875ba096() {
  level waittill(#"hash_6daf71d27b25e000");
  level waittill(#"hash_4329d565ec8d390e");
}

function function_ac85ea08() {
  thread function_a089d999();
  thread function_241c95b4();
}

function function_a089d999() {
  wait 25;
  var_4687b77a = snd::play("veh_evac_chopper_fake_dist_lp", level.var_7d23cf81);
}

function function_241c95b4() {
  level waittill(#"hash_2f4020343cecc6f0");
  thread function_c0f7776d();
  var_ec619483 = snd::play("veh_evac_chopper_jetwhine_lp", level.vehicle_evac_heli);
  snd::function_f4f3a2a(var_ec619483, level.vehicle_evac_heli);
}

function function_c0f7776d() {
  level waittill(#"evac_helicopter_board_trigger");
  snd::client_msg(#"hash_5c7e1a43ba45c2b4");
}

function outro() {
  wait 2;
  music("defend");
  level waittill(#"evac_helicopter_board_trigger");
  wait 1;
  music("exfil");
}