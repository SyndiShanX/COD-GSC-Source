/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_utils.gsc
**********************************************/

____________________generic_util____________________() {}

complete_quest_on_trigger(param_00, param_01) {
  level endon(lib_0557::func_7838(param_00, param_01));
  self waittill("trigger");
  lib_0557::func_782D(param_00, param_01);
}

earthquake_alive_players(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in level.var_744A) {
    if(isalive(var_05)) {
      var_03[var_03.size] = var_05;
    }
  }

  earthquake(param_00, param_01, (0, 0, 0), 9999999, var_03);
}

earthquake_alive_players_with_origin(param_00, param_01, param_02, param_03) {
  var_04 = [];
  foreach(var_06 in level.var_744A) {
    if(isalive(var_06) && distance(var_06.var_116, param_03.var_116) <= param_02) {
      var_04[var_04.size] = var_06;
    }
  }

  if(var_04.size > 0) {
    earthquake(param_00, param_01, param_03.var_116, param_02, var_04);
  }
}

flag_try_set(param_00) {
  if(!common_scripts\utility::func_3C83(param_00)) {
    return;
  }

  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  common_scripts\utility::func_3C8F(param_00);
}

get_special_melee_weapon_flag_name(param_00) {
  return "hc_" + param_00 + "_revealed";
}

special_melee_weapon_pickup_think(param_00, param_01) {
  level endon("game_over");
  for(;;) {
    param_00 waittill("trigger", var_02);
    iprintlnbold(var_02.var_109 + " picked up the: " + param_01);
    if(param_01 == "sword") {
      var_02 lib_0378::func_8D74("aud_pickup_barbarosa_sword");
    }

    var_02.special_melee_weapon = param_01;
    var_03 = special_melee_get_weapon_name(param_01);
    if(issubstr(var_03, "shovel")) {
      var_03 = maps\mp\zombies\_zombies_magicbox::func_454B(var_02, "shovel_zm");
    }

    var_02 lib_0586::func_78C(var_03);
    var_02 lib_0586::func_78E(var_03);
    try_give_exp_to_players_for_weap(param_01);
    wait(1);
    if(param_01 == "bat") {
      var_02 lib_0367::func_8E3D("hc_bat_reveal");
      lib_0378::func_8D74("smugglers_bat_pickup", param_00.var_116);
    }

    flag_try_set(get_special_melee_weapon_flag_name(param_01));
  }
}

try_give_exp_to_players_for_weap(param_00) {
  if(!isDefined(level.expweapongiven)) {
    level.expweapongiven = [];
  }

  if(!isDefined(level.expweapongiven[param_00])) {
    level.expweapongiven[param_00] = 0;
  }

  if(!level.expweapongiven[param_00]) {
    level.expweapongiven[param_00] = 1;
    switch (param_00) {
      case "bat":
        lib_054D::giveplayersexp("berlin_exp_ref_2");
        break;

      case "pickaxe":
        lib_054D::giveplayersexp("berlin_exp_ref_11");
        break;

      case "wunderbuss_zm":
        lib_054D::giveplayersexp("berlin_exp_ref_20");
        break;

      case "dagger":
        lib_054D::giveplayersexp("berlin_exp_ref_14");
        break;

      case "sword":
        maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_6();
        lib_054D::giveplayersexp("berlin_exp_ref_4");
        break;
    }
  }
}

special_melee_get_weapon_name(param_00) {
  var_01 = undefined;
  if(isDefined(param_00)) {
    switch (param_00) {
      case "bat":
        var_01 = "zom_dlc2_1hc_zm";
        break;

      case "pickaxe":
        var_01 = "zom_dlc2_3hc_zm";
        break;

      case "dagger":
        var_01 = "zom_dlc2_2hc_zm";
        break;

      case "sword":
        var_01 = "zom_dlc2_4_zm";
        break;

      case "bat_casual":
        var_01 = "zom_dlc2_1_zm";
        break;

      case "pickaxe_casual":
        var_01 = "zom_dlc2_3_zm";
        break;

      case "dagger_casual":
        var_01 = "zom_dlc2_2_zm";
        break;

      case "shovel_casual":
        var_01 = "shovel_zm";
        break;
    }
  }

  return var_01;
}

lockin_system_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::knock_off_battery("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

lockin_system_monitor_unuse(param_00, param_01, param_02) {
  self endon("stop_using_station");
  wait 0.05;
  if(isDefined(param_01) && param_01) {
    thread lockin_system_monitor_b_button();
  }

  if(common_scripts\utility::func_562E(param_02)) {
    thread lockin_system_monitor_use_button_exit();
  }

  if(!isDefined(param_00)) {
    return;
  }

  for(;;) {
    param_00 waittill("trigger", var_03);
    if(self == var_03) {
      break;
    }
  }

  self notify("stop_using_station");
}

lockin_system_monitor_b_button() {
  self endon("stop_using_station");
  for(;;) {
    if(self method_84F1()) {
      break;
    }

    wait 0.05;
  }

  self setstance("stand");
  self notify("stop_using_station");
}

lockin_system_monitor_use_button_exit() {
  self endon("stop_using_station");
  while(self useButtonPressed()) {
    wait 0.05;
  }

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  self notify("stop_using_station");
}

zombies_players_secret_room_handle_ignore(param_00) {
  if(!isPlayer(param_00)) {
    return 0;
  }

  var_01 = agents_are_separated(param_00, self);
  return var_01;
}

agents_are_separated(param_00, param_01) {
  return param_01 agent_is_in_secret_room(1) != agent_is_in_secret_room();
}

agent_is_in_secret_room(param_00) {
  var_01 = undefined;
  if(common_scripts\utility::func_562E(param_00) && !common_scripts\utility::func_562E(self.wasteleported)) {
    var_01 = lib_0547::func_5565(self.var_9024, level.current_secret_room_zone);
  }

  return common_scripts\utility::func_562E(var_01) || lib_055A::func_AC29(self, level.current_secret_room_zone);
}

set_default_spawn_room(param_00, param_01, param_02) {
  level.temp_spawn_locations = param_01;
  level.temp_spawn_location_players = param_00;
  foreach(var_04 in param_00) {
    var_04 thread set_default_room_for_player(param_02);
  }
}

set_default_room_for_player(param_00) {}

onberlinstartgame() {
  initberlinwavestories();
  level.var_7F22["normal"] = ::berlinroundstart;
  level.var_7F22["zombie_dog"] = ::berlinroundstart;
  level.var_7F18["normal"] = ::berlinroundend;
  lib_0547::remove_wallbuys_from_box();
}

initberlinwavestories() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_pods_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_pods_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_pods_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_pods_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_airships_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_airships_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_airships_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_airships_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_war_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_war_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_war_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_war_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_sizzler_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_sizzler_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_sizzler_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_sizzler_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_ww_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_ww_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_ww_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_ww_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
  var_00 = [];
  var_00[var_00.size] = ["zmb_berl_mari_wavebreak_airship_lo", 1];
  var_00[var_00.size] = ["zmb_berl_oliv_wavebreak_airship_lo", 1];
  var_00[var_00.size] = ["zmb_berl_dros_wavebreak_airship_lo", 1];
  var_00[var_00.size] = ["zmb_berl_jeff_wavebreak_airship_lo", 1];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_00, 1);
}

wunderbuss_ammo_tracker() {
  self endon("death");
  self endon("wunderbuss_stop_tracking");
  for(;;) {
    common_scripts\utility::func_A70C(self, "weapon_fired", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");
    if(self hasweapon("wunderbuss_zm")) {
      self.wunderbuss_prev_ammo = self getweaponammoclip("wunderbuss_zm");
    }
  }
}

wunderbuss_drop_watcher() {
  var_00 = self;
  for(;;) {
    var_01 = common_scripts\utility::func_A715("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");
    if(var_01 == "weapon_change") {
      if(lib_0547::func_577E(self)) {
        continue;
      } else if(!lib_0547::func_73F9(self, "wunderbuss_zm")) {
        self notify("wunderbuss_stop_tracking");
        return;
      }

      continue;
    }

    if(var_01 == "bleedout" || var_01 == "becameSpectator" || var_01 == "disconnect") {
      self notify("wunderbuss_stop_tracking");
      return;
    }
  }
}

____________________radio_system____________________() {}

radio_system_setup() {
  level.radio_codes = [];
  level.radio_map_location = undefined;
  level.radio_map_series_num = undefined;
  level.radio_map_model_num = undefined;
  level.radio_code_left = undefined;
  level.radio_code_right = undefined;
  level.radio_codes["ober_havel"] = [];
  level.radio_codes["ober_havel"]["series"] = [];
  level.radio_codes["ober_havel"]["series"]["RS"] = 50.2;
  level.radio_codes["ober_havel"]["series"]["TX"] = 63.4;
  level.radio_codes["ober_havel"]["series"]["LS"] = 70.5;
  level.radio_codes["ober_havel"]["series"]["ZX"] = 71.4;
  level.radio_codes["ober_havel"]["Model"] = [];
  level.radio_codes["ober_havel"]["Model"]["0"] = 5.5;
  level.radio_codes["ober_havel"]["Model"]["1"] = 19.2;
  level.radio_codes["ober_havel"]["Model"]["2"] = 55;
  level.radio_codes["ober_havel"]["Model"]["3"] = 60.2;
  level.radio_codes["barnim"] = [];
  level.radio_codes["barnim"]["series"] = [];
  level.radio_codes["barnim"]["series"]["RS"] = 1.2;
  level.radio_codes["barnim"]["series"]["TX"] = 26.5;
  level.radio_codes["barnim"]["series"]["LS"] = 51.1;
  level.radio_codes["barnim"]["series"]["ZX"] = 95.1;
  level.radio_codes["barnim"]["Model"] = [];
  level.radio_codes["barnim"]["Model"]["0"] = 27.9;
  level.radio_codes["barnim"]["Model"]["1"] = 34.1;
  level.radio_codes["barnim"]["Model"]["2"] = 44.6;
  level.radio_codes["barnim"]["Model"]["3"] = 50.1;
  level.radio_codes["elbe_elster"] = [];
  level.radio_codes["elbe_elster"]["series"] = [];
  level.radio_codes["elbe_elster"]["series"]["RS"] = 50.2;
  level.radio_codes["elbe_elster"]["series"]["TX"] = 63.4;
  level.radio_codes["elbe_elster"]["series"]["LS"] = 70.5;
  level.radio_codes["elbe_elster"]["series"]["ZX"] = 71.4;
  level.radio_codes["elbe_elster"]["Model"] = [];
  level.radio_codes["elbe_elster"]["Model"]["0"] = 70.2;
  level.radio_codes["elbe_elster"]["Model"]["1"] = 78.6;
  level.radio_codes["elbe_elster"]["Model"]["2"] = 90.6;
  level.radio_codes["elbe_elster"]["Model"]["3"] = 93;
  level.radio_codes["oder_spree"] = [];
  level.radio_codes["oder_spree"]["series"] = [];
  level.radio_codes["oder_spree"]["series"]["RS"] = 24.1;
  level.radio_codes["oder_spree"]["series"]["TX"] = 34.2;
  level.radio_codes["oder_spree"]["series"]["LS"] = 44.7;
  level.radio_codes["oder_spree"]["series"]["ZX"] = 51.2;
  level.radio_codes["oder_spree"]["Model"] = [];
  level.radio_codes["oder_spree"]["Model"]["0"] = 9.6;
  level.radio_codes["oder_spree"]["Model"]["1"] = 63.4;
  level.radio_codes["oder_spree"]["Model"]["2"] = 70.5;
  level.radio_codes["oder_spree"]["Model"]["3"] = 71.4;
  level.radio_codes["prignitz"] = [];
  level.radio_codes["prignitz"]["series"] = [];
  level.radio_codes["prignitz"]["series"]["RS"] = 5.2;
  level.radio_codes["prignitz"]["series"]["TX"] = 16.5;
  level.radio_codes["prignitz"]["series"]["LS"] = 50;
  level.radio_codes["prignitz"]["series"]["ZX"] = 87.2;
  level.radio_codes["prignitz"]["Model"] = [];
  level.radio_codes["prignitz"]["Model"]["0"] = 25.1;
  level.radio_codes["prignitz"]["Model"]["1"] = 29.5;
  level.radio_codes["prignitz"]["Model"]["2"] = 54.2;
  level.radio_codes["prignitz"]["Model"]["3"] = 99;
  level.radio_codes["uckermark"] = [];
  level.radio_codes["uckermark"]["series"] = [];
  level.radio_codes["uckermark"]["series"]["RS"] = 12.2;
  level.radio_codes["uckermark"]["series"]["TX"] = 25.6;
  level.radio_codes["uckermark"]["series"]["LS"] = 29.2;
  level.radio_codes["uckermark"]["series"]["ZX"] = 82.1;
  level.radio_codes["uckermark"]["Model"] = [];
  level.radio_codes["uckermark"]["Model"]["0"] = 2.2;
  level.radio_codes["uckermark"]["Model"]["1"] = 8.2;
  level.radio_codes["uckermark"]["Model"]["2"] = 16.1;
  level.radio_codes["uckermark"]["Model"]["3"] = 43.7;
  level.radio_codes["teltow_flaming"] = [];
  level.radio_codes["teltow_flaming"]["series"] = [];
  level.radio_codes["teltow_flaming"]["series"]["RS"] = 24.1;
  level.radio_codes["teltow_flaming"]["series"]["TX"] = 63.1;
  level.radio_codes["teltow_flaming"]["series"]["LS"] = 78.3;
  level.radio_codes["teltow_flaming"]["series"]["ZX"] = 84;
  level.radio_codes["teltow_flaming"]["Model"] = [];
  level.radio_codes["teltow_flaming"]["Model"]["0"] = 21.6;
  level.radio_codes["teltow_flaming"]["Model"]["1"] = 30.2;
  level.radio_codes["teltow_flaming"]["Model"]["2"] = 57;
  level.radio_codes["teltow_flaming"]["Model"]["3"] = 60;
  level.radio_codes["markisch_oderland"] = [];
  level.radio_codes["markisch_oderland"]["series"] = [];
  level.radio_codes["markisch_oderland"]["series"]["RS"] = 5.2;
  level.radio_codes["markisch_oderland"]["series"]["TX"] = 11.2;
  level.radio_codes["markisch_oderland"]["series"]["LS"] = 52.2;
  level.radio_codes["markisch_oderland"]["series"]["ZX"] = 60;
  level.radio_codes["markisch_oderland"]["Model"] = [];
  level.radio_codes["markisch_oderland"]["Model"]["0"] = 22.2;
  level.radio_codes["markisch_oderland"]["Model"]["1"] = 27.3;
  level.radio_codes["markisch_oderland"]["Model"]["2"] = 35.7;
  level.radio_codes["markisch_oderland"]["Model"]["3"] = 49.4;
  level.radio_codes["spree_neisse"] = [];
  level.radio_codes["spree_neisse"]["series"] = [];
  level.radio_codes["spree_neisse"]["series"]["RS"] = 12.2;
  level.radio_codes["spree_neisse"]["series"]["TX"] = 25.7;
  level.radio_codes["spree_neisse"]["series"]["LS"] = 85.2;
  level.radio_codes["spree_neisse"]["series"]["ZX"] = 92.1;
  level.radio_codes["spree_neisse"]["Model"] = [];
  level.radio_codes["spree_neisse"]["Model"]["0"] = 10;
  level.radio_codes["spree_neisse"]["Model"]["1"] = 17.1;
  level.radio_codes["spree_neisse"]["Model"]["2"] = 30.2;
  level.radio_codes["spree_neisse"]["Model"]["3"] = 45.1;
  level.radio_codes["dahme_spreewald"] = [];
  level.radio_codes["dahme_spreewald"]["series"] = [];
  level.radio_codes["dahme_spreewald"]["series"]["RS"] = 2.5;
  level.radio_codes["dahme_spreewald"]["series"]["TX"] = 74.3;
  level.radio_codes["dahme_spreewald"]["series"]["LS"] = 80.2;
  level.radio_codes["dahme_spreewald"]["series"]["ZX"] = 87;
  level.radio_codes["dahme_spreewald"]["Model"] = [];
  level.radio_codes["dahme_spreewald"]["Model"]["0"] = 86.2;
  level.radio_codes["dahme_spreewald"]["Model"]["1"] = 90;
  level.radio_codes["dahme_spreewald"]["Model"]["2"] = 94.9;
  level.radio_codes["dahme_spreewald"]["Model"]["3"] = 98.1;
  var_00 = getent("map_pushpin", "script_noteworthy");
  var_01 = getent("map_pushpin_origin", "script_noteworthy");
  var_00 method_8449(var_01);
  var_02 = common_scripts\utility::func_46B7("map_pinpoint", "script_noteworthy");
  var_03 = common_scripts\utility::func_7A33(var_02);
  var_01.var_116 = var_03.var_116;
  level.radio_map_location = var_03.var_8260;
  var_04 = 4;
  var_05 = randomintrange(0, var_04);
  var_06 = randomintrange(0, var_04);
  var_07 = "X";
  var_08 = "X";
  switch (var_05) {
    case 0:
      var_07 = "R";
      var_08 = "S";
      break;

    case 1:
      var_07 = "T";
      var_08 = "X";
      break;

    case 2:
      var_07 = "L";
      var_08 = "S";
      break;

    case 3:
      var_07 = "Z";
      var_08 = "X";
      break;
  }

  level.radio_map_series_num = var_07 + var_08;
  level.radio_map_model_num = common_scripts\utility::func_9AAD(var_06);
  var_09 = common_scripts\utility::func_46B5("radio_series_org_1", "targetname");
  var_0A = spawn("script_model", var_09.var_116);
  var_0A setModel("zbr_rus_radio_01_letter_" + var_07);
  var_0A.var_1D = var_09.var_1D;
  var_0A.var_28BE = 500;
  var_0B = common_scripts\utility::func_46B5("radio_series_org_2", "targetname");
  var_0C = spawn("script_model", var_0B.var_116);
  var_0C setModel("zbr_rus_radio_01_letter_" + var_08);
  var_0C.var_1D = var_0B.var_1D;
  var_0C.var_28BE = 500;
  var_0D = common_scripts\utility::func_46B5("radio_model_number_org", "targetname");
  var_0E = spawn("script_model", var_0D.var_116);
  var_0E setModel("zbr_rus_radio_01_num_0" + common_scripts\utility::func_9AAD(var_06));
  var_0E.var_1D = var_0D.var_1D;
  var_0E.var_28BE = 500;
  level.radio_code_left = level.radio_codes[level.radio_map_location]["series"][level.radio_map_series_num];
  level.radio_code_right = level.radio_codes[level.radio_map_location]["Model"][level.radio_map_model_num];
}

radio_system_init() {
  var_00 = getent("radio_tuner_use_trig", "targetname");
  var_01 = (0, 0, 0);
  var_02 = (0, 0, 0);
  var_03 = getent("radio_tuner_link_org", "targetname");
  var_04 = getent("radio_tuner_player_org", "targetname");
  var_05 = undefined;
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  thread radio_system_light_swap_handler();
  for(;;) {
    var_00 waittill("trigger", var_06);
    var_06 lib_0378::func_8D74("player_using_radio");
    level notify("player_used_radio", var_06);
    if(var_06 method_83B8() || var_06 method_82E5()) {
      continue;
    }

    var_05 = var_06;
    level.player_using_radio = var_06;
    var_05 method_8322();
    var_07 = var_05 getstance();
    if(var_05 getstance() != "crouch") {
      var_05 setstance("crouch");
      if(var_07 == "stand") {
        wait(0.4);
      } else if(var_07 == "prone") {
        wait(0.55);
      } else {
        wait(0.55);
      }
    }

    var_05 method_812C(0);
    var_01 = var_06.var_116;
    var_02 = var_06.var_1D;
    var_04.var_116 = var_05.var_116;
    var_04.var_1D = var_05.var_1D;
    var_05 playerlinkto(var_04, undefined, 0.1, 0, 0, 0, 0);
    var_04 moveto(var_03.var_116, 0.5, 0, 0);
    var_04 rotateto(var_03.var_1D, 0.5, 0, 0);
    wait(0.5);
    var_05 thread radio_system_start_tuning();
    var_05 waittill("stop_using_station");
    var_05 method_8323();
    var_04 moveto(var_01 + (0, 0, 1), 0.5);
    var_04 rotateto(var_02, 0.5);
    wait(0.5);
    var_05 unlink();
    var_05 method_812C(1);
    var_05 setstance("stand");
    wait(0.5);
    level.player_using_radio = undefined;
  }
}

radio_system_light_swap_handler() {
  level endon("game_over");
  var_00 = function_021F("radio_light", "targetname")[0];
  var_00 setscriptablepartstate("0", "0");
  while(!isDefined(level.possible_radio_codes) || !isDefined(level.possible_radio_codes[0]["left"]) || !isDefined(level.possible_radio_codes[0]["right"])) {
    wait 0.05;
  }

  var_01 = 2;
  for(;;) {
    foreach(var_03 in level.possible_radio_codes) {
      var_04 = var_03["left"];
      var_05 = level.tuner_values["radio_tuner"]["left"];
      var_06 = abs(var_05 - var_04);
      var_07 = var_03["right"];
      var_08 = level.tuner_values["radio_tuner"]["right"];
      var_09 = abs(var_08 - var_07);
      if(var_06 <= var_01 && var_09 <= var_01) {
        var_00 setscriptablepartstate("0", "1");
        while(var_06 <= var_01 && var_09 <= var_01) {
          wait 0.05;
          var_05 = level.tuner_values["radio_tuner"]["left"];
          var_06 = abs(var_05 - var_04);
          var_08 = level.tuner_values["radio_tuner"]["right"];
          var_09 = abs(var_08 - var_07);
        }

        var_00 setscriptablepartstate("0", "0");
        wait 0.05;
        continue;
      }
    }

    wait(0.25);
  }
}

radio_system_start_tuning() {
  thread lockin_system_monitor_death();
  thread radio_system_show_controls_hint();
  var_00 = undefined;
  var_01 = undefined;
  if(common_scripts\utility::func_55E0()) {
    thread lib_0547::monitor_stick_input();
    self.radioinputleftprevious = 0;
    self.radioinputrightprevious = 0;
    var_00 = ::radio_left_tuner_input_gamepad;
    var_01 = ::radio_right_tuner_input_gamepad;
  } else {
    thread lockin_system_monitor_unuse(undefined, 0, 1);
    var_00 = ::radio_left_tuner_input_pc;
    var_01 = ::radio_right_tuner_input_pc;
  }

  var_02 = getent("radio_tuner_left", "targetname");
  var_03 = getent("radio_tuner_left_knob", "targetname");
  var_03 method_8449(var_02);
  var_04 = getent("radio_tuner_left_needle", "targetname");
  thread radio_system_handle_tuner(var_02, "left", 1, level.tuner_values["radio_tuner"]["left"], "radio_tuner", var_00, var_04);
  var_05 = getent("radio_tuner_right", "targetname");
  var_06 = getent("radio_tuner_right_knob", "targetname");
  var_06 method_8449(var_05);
  var_07 = getent("radio_tuner_right_needle", "targetname");
  thread radio_system_handle_tuner(var_05, "right", 1, level.tuner_values["radio_tuner"]["right"], "radio_tuner", var_01, var_07);
}

radio_system_show_controls_hint() {
  if(common_scripts\utility::func_55E0()) {
    self forceusehinton(&"ZOMBIE_BERLIN_RADIO_USE_HINT");
    radio_system_show_controls_hint_breakout();
    self forceusehintoff(&"ZOMBIE_BERLIN_RADIO_USE_HINT");
    return;
  }

  self forceusehinton(&"ZOMBIE_BERLIN_RADIO_USE_HINT_PC");
  radio_system_show_controls_hint_breakout();
  self forceusehintoff(&"ZOMBIE_BERLIN_RADIO_USE_HINT_PC");
}

radio_system_show_controls_hint_breakout() {
  common_scripts\utility::func_A71A(5, "stop_using_station");
}

radio_system_get_turn_difference(param_00, param_01) {
  var_02 = param_00 - param_01;
  var_02 = angleclamp180(var_02);
  return var_02;
}

radio_left_tuner_input_gamepad() {
  var_00 = lib_0547::get_left_stick_input();
  var_01 = radio_system_get_turn_difference(self.radioinputleftprevious, var_00);
  self.radioinputleftprevious = var_00;
  return var_01;
}

radio_right_tuner_input_gamepad() {
  var_00 = lib_0547::get_right_stick_input();
  var_01 = radio_system_get_turn_difference(self.radioinputrightprevious, var_00);
  self.radioinputrightprevious = var_00;
  return var_01;
}

pc_tuner_speed() {
  var_00 = 12.5;
  if(self method_83C1()) {
    var_00 = var_00 * 10;
  }

  return var_00;
}

radio_left_tuner_input_pc() {
  var_00 = self getnormalizedmovement();
  var_01 = var_00[1];
  if(var_01 == 0) {
    return 0;
  }

  var_02 = pc_tuner_speed() * var_01;
  return var_02;
}

radio_right_tuner_input_pc() {
  var_00 = 0;
  if(self adsButtonPressed(1)) {
    var_00 = 1;
  } else if(self attackButtonPressed()) {
    var_00 = -1;
  }

  if(var_00 == 0) {
    return 0;
  }

  var_00 = var_00 * pc_tuner_speed();
  return var_00;
}

radio_system_handle_tuner(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("stop_using_station");
  var_07 = 0;
  if(param_01 == "left") {
    var_07 = 1;
  }

  level.should_suspend_tuning = 0;
  var_08 = param_03;
  var_09 = 0;
  var_0A = 2;
  var_0B = 0;
  var_0C = 1;
  lib_0378::func_8D74("radio_stop_using_watcher");
  var_0D = undefined;
  if(isDefined(param_06)) {
    var_0D = getent(param_06.var_1A2, "targetname");
    param_06 method_8449(var_0D);
  }

  for(;;) {
    if(!level.should_suspend_tuning) {
      if(abs(var_09) > 0.1) {
        var_0B = 0;
        var_0E = var_09 < 0;
        var_0F = 0;
        if(var_0C) {
          lib_0378::func_8D74("aud_radio_tuning", "tuning");
          var_0C = 0;
        }

        if(common_scripts\utility::func_562E(var_0E)) {
          var_0F = angleclamp360(param_00.var_1D[2] + 5);
          var_08 = var_08 + 0.9 * var_09 / 100;
        } else {
          var_0F = angleclamp360(param_00.var_1D[2] - 5);
          var_08 = var_08 + 0.9 * var_09 / 100;
        }

        param_00.var_1D = (param_00.var_1D[0], param_00.var_1D[1], var_0F);
      } else {
        var_0B++;
      }

      if(var_0B > var_0A && !var_0C) {
        lib_0378::func_8D74("aud_radio_tuning", "idle");
        var_0C = 1;
      }

      var_09 = self[[param_05]]();
      if(var_09 != 0 && var_07) {
        var_09 = 0;
        var_07 = 0;
        self notify("player_is_tuning");
      }

      if(common_scripts\utility::func_562E(param_02)) {
        var_10 = int(var_08);
        if(var_10 > 99) {
          var_08 = 99;
          var_10 = 99;
        } else if(var_10 < 1) {
          var_08 = 1;
          var_10 = 1;
        }

        if(isDefined(var_0D)) {
          var_0D thread radio_system_update_tuner_needle(var_10, param_01);
        }

        level.tuner_values[param_04][param_01] = var_10;
        if(var_10 < 10) {
          var_10 = "0" + var_10;
        }
      }
    }

    wait 0.05;
  }
}

radio_system_suspend_tuning_for_time(param_00) {
  level.should_suspend_tuning = 1;
  wait(param_00);
  level.should_suspend_tuning = 0;
}

radio_system_suspend_tuning_for_response() {
  level.should_suspend_tuning = 1;
  level waittill("radio_response_done");
  level.should_suspend_tuning = 0;
}

radio_system_update_tuner_needle(param_00, param_01) {
  var_02 = 0;
  if(!isDefined(param_01) || param_01 == "left") {
    var_03 = 108;
    var_02 = 43.5;
  } else {
    var_03 = 203;
    var_02 = 1;
  }

  var_04 = param_00 - 50;
  var_05 = var_04 / 100;
  var_06 = var_03 * var_05 + var_02;
  self.var_1D = (self.var_1D[0], self.var_1D[1], -1 * var_06);
}

____________________airships____________________() {}

airship_straub_summon() {
  common_scripts\utility::func_3C8F("flag_airship_summoned");
}

airship_objects_show(param_00) {
  self method_805B();
  self solid();
  if(isDefined(param_00) && param_00) {
    self method_805F();
  }
}

airship_objects_hide(param_00) {
  self method_805C();
  self notsolid();
  if(isDefined(param_00) && param_00) {
    self method_8060();
  }
}

airship_interior_state_swap() {
  hack_station_init();
  if(!level.airship_active) {
    level.airship_active = 1;
    foreach(var_01 in level.airship) {
      var_01 airship_objects_show();
    }

    level notify("show_hack_stations");
    level thread power_source_effects();
    return;
  }

  level.airship_active = 0;
  foreach(var_01 in level.airship) {
    var_01 airship_objects_hide();
  }

  level notify("hide_hack_stations");
}

airship_pods_animation() {
  var_00 = getEntArray("zeppelin_drop_pods", "targetname");
  lib_0378::func_8D74("aud_start_drop_pod_sway");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_1") {
      var_02 scriptmodelplayanim("zep_int_pod_calm");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_2") {
      var_02 scriptmodelplayanim("zep_int_pod_calm1");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_3") {
      var_02 scriptmodelplayanim("zep_int_pod_calm2");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_shake") {
      var_02 scriptmodelplayanim("zep_int_pod_calm1_2");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_shake1") {
      var_02 scriptmodelplayanim("zep_int_pod_calm_2");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_open") {
      var_02 scriptmodelplayanim("zep_int_pod_calm_open");
    }
  }

  level waittill("escape_airship_start");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_1") {
      var_02 scriptmodelplayanim("zep_int_pod_crazy");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_2") {
      var_02 scriptmodelplayanim("zep_int_pod_crazy1");
    }

    if(isDefined(var_02.var_165) && var_02.var_165 == "variant_3") {
      var_02 scriptmodelplayanim("zep_int_pod_crazy2");
    }
  }
}

airship_puzzle_doors_disable_buy() {
  wait(10);
  foreach(var_01 in level.var_AC1D) {
    foreach(var_03 in var_01.var_9DC2) {
      if(isDefined(var_01.var_3280) && var_01.var_3280 == "closeable") {
        var_03 common_scripts\utility::func_9D9F();
      }
    }
  }
}

airship_route_blockers_state_swap() {
  if(!level.airship_doors_open) {
    level.airship_doors_open = 1;
    foreach(var_01 in level.airship_route_blockers) {
      var_01 airship_objects_hide(1);
    }

    return;
  }

  level.airship_doors_open = 0;
  foreach(var_01 in level.airship_route_blockers) {
    var_01 airship_objects_show(1);
  }
}

airship_camera_sway() {
  level endon("airship_escape");
  for(;;) {
    var_00 = randomfloatrange(0.25, 1);
    var_01 = randomfloatrange(3, 4);
    level.var_953D rotateto((var_00, var_00, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
    level.var_953D rotateto((0 - var_00, 0 - var_00, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
  }
}

airship_camera_sway_extreme() {
  level endon("berlin_cinematic_done");
  for(;;) {
    var_00 = randomfloatrange(1, 2);
    var_01 = randomfloatrange(4, 6);
    level.var_953D rotateto((var_00, var_00, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
    level.var_953D rotateto((0 - var_00, 0 - var_00, 0), var_01, var_01 * 0.5, var_01 * 0.5);
    wait(var_01);
  }
}

airship_lowering_handler() {
  level endon("flag_airship_fully_lowered");
  var_00 = getvehiclenode("end_node_airship_straub_lowered", "targetname");
  level.airship_lower_percentage = 0;
  while(level.airship_lower_percentage < 100) {
    wait 0.05;
  }

  wait(0.5);
  common_scripts\utility::func_3C8F("flag_airship_fully_lowered");
}

airship_lowering_handler_fully_lower() {
  level.airship_lower_percentage = 100;
}

___sizzler_cannon___() {}

airship_turret_build(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = spawnturret("misc_turret", self.var_116, param_00);
  var_06.var_1D = self.var_1D;
  var_06 setModel(param_01);
  var_06 setdefaultdroppitchyaw(0);
  var_06 setmode("auto_nonai");
  var_06 method_80F9(undefined);
  var_06 method_80FB(0);
  var_06 method_8131();
  var_06 makeunusable();
  var_06 method_8130("allies");
  var_06 setentityowner(var_06);
  var_06 turretdontresetanglesonexitornotarget(1);
  if(isDefined(param_02)) {
    var_06.var_62AD = param_02;
  }

  if(isDefined(param_03)) {
    var_06.var_6B73 = param_03;
  }

  if(isDefined(param_04)) {
    var_06.modifyagentdamage = param_04;
  }

  if(isDefined(param_05)) {
    var_06.onagentdamage = param_05;
  }

  return var_06;
}

airship_turret_modify_player_damage(param_00) {
  return 0;
}

airship_turret_on_player_damage(param_00) {}

airship_turret_modify_agent_damage(param_00) {
  return 0;
}

airship_turret_on_agent_damage(param_00) {
  var_01 = self;
}

airship_turret_think() {
  level endon("entered_airship_sizzler_pause");
  level.airship_valid_zones = ["zone_underbelly_start", "zone_underbelly_rubble", "zone_underbelly_intact", "zone_street", "zone_museum_hall", "zone_club_interior", "zone_church_garden", "zone_church_interior", "zone_airship", "zone_airship_middle_front", "zone_airship_left", "zone_airship_right", "zone_finale"];
  level.airship_zone_volumes = [];
  var_00 = [40, 35, 30, 25];
  for(var_01 = 0; var_01 < level.airship_valid_zones.size; var_01++) {
    var_02 = getEntArray(level.airship_valid_zones[var_01], "targetname");
    level.airship_zone_volumes = common_scripts\utility::func_F73(level.airship_zone_volumes, var_02);
  }

  common_scripts\utility::func_3C9F("flag_airship_summoned");
  level thread airship_turret_disable_listener();
  for(;;) {
    wait(var_00[level.var_744A.size - 1]);
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(!airship_turret_is_safe_to_shoot()) {
      continue;
    }

    var_03 = undefined;
    while(!isDefined(var_03) || !isalive(var_03)) {
      if(!isDefined(level.straub_airship.valid_targets) || level.straub_airship.valid_targets.size <= 0) {
        wait(5);
        continue;
      }

      foreach(var_05 in level.straub_airship.valid_targets) {
        if(!function_01EF(var_05) || !isalive(var_05) || var_05 method_85A5() != "zombie_animclass" || common_scripts\utility::func_562E(var_05.transformingtosizzler)) {
          level.straub_airship.valid_targets = common_scripts\utility::func_F93(level.straub_airship.valid_targets, var_05);
        }
      }

      var_07 = [];
      foreach(var_09 in level.var_744A) {
        if(isalive(var_09) && !lib_0547::func_577E(var_09)) {
          var_07[var_07.size] = var_09;
        }
      }

      if(var_07.size > 0) {
        var_0B = common_scripts\utility::func_7A33(level.var_744A);
        var_03 = common_scripts\utility::func_4461(var_0B.var_116, level.straub_airship.valid_targets);
      } else {
        var_03 = common_scripts\utility::func_4461(self.var_116, level.straub_airship.valid_targets);
      }

      if(!isDefined(var_03)) {
        wait(5);
        continue;
      }

      var_0C = 0;
      for(var_01 = 0; var_01 < level.airship_zone_volumes.size; var_01++) {
        if(var_03 istouching(level.airship_zone_volumes[var_01])) {
          var_0C = 1;
        }
      }

      if(!var_0C) {
        var_03 = undefined;
      }

      wait(0.25);
    }

    if(isalive(var_03)) {
      airship_turret_shoot_target(var_03);
    }
  }
}

airship_turret_is_safe_to_shoot() {
  if(!common_scripts\utility::func_562E(level.straub_airship.canmakesizzlers)) {
    return 0;
  }

  if(!maps\mp\zombies\zombie_sizzler::zombie_sizzler_slot_available()) {
    return 0;
  }

  if(!isDefined(level.straub_airship.valid_targets) || level.straub_airship.valid_targets.size <= 0) {
    return 0;
  }

  return 1;
}

airship_turret_disable_listener() {
  level waittill("entered_airship_sizzler_pause");
  airship_turret_clear_target();
}

airship_turret_shoot_target(param_00) {
  var_01 = level.straub_airship.siz_cannon gettagorigin("TAG_PITCH");
  var_02 = spawn("script_model", var_01);
  var_02 setModel("Tag_Origin");
  var_02 method_8449(level.straub_airship.siz_cannon);
  var_03 = level.straub_airship.siz_cannon gettagorigin("TAG_AIM");
  var_04 = level.straub_airship.siz_cannon gettagangles("TAG_AIM");
  var_05 = anglesToForward(var_04);
  var_06 = vectornormalize(param_00.var_116 - var_03);
  var_07 = vectordot(var_05, var_06);
  level.var_8C4C = level.straub_airship.siz_cannon gettagorigin("TAG_AIM");
  level.var_8C46 = param_00.var_116;
  var_08 = common_scripts\utility::func_8FFC();
  var_08.var_116 = param_00.var_116 + (0, 0, -12);
  airship_turret_set_target(var_08);
  playFXOnTag(common_scripts\utility::func_44F5("zmb_zeppelin_shot_charge_barrel"), level.straub_airship.siz_cannon, "TAG_AIM");
  wait(0.65);
  airship_turret_start_firing();
  var_09 = launchbeam("zmb_geistkraft_reg_beam_med", level.straub_airship.siz_cannon, "tag_flash", param_00, "tag_origin");
  var_0A = -1 * var_06;
  if(isalive(param_00)) {
    param_00 thread maps\mp\zombies\zombie_sizzler::zombie_make_sizzler(var_0A, 1);
  }

  airship_turret_stop_firing();
  playFX(level.var_611["zmb_ber_zep_lightning_bolt"], var_08.var_116, var_02.var_116 - var_08.var_116);
  airship_turret_clear_target();
  var_02 delete();
  wait(0.15);
  var_09 delete();
  var_08 delete();
}

airship_turret_set_target(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  level.straub_airship.siz_cannon setturrettargetentity(param_00, (0, 0, 0), 1);
}

airship_turret_get_target() {
  return level.straub_airship.siz_cannon getturrettargetent();
}

airship_turret_clear_target() {
  level.straub_airship.siz_cannon clearturrettargetentity();
}

airship_turret_is_zombie_targeted(param_00) {
  var_01 = airship_turret_get_target();
  return isDefined(var_01) && var_01 == param_00;
}

airship_turret_start_firing() {
  if(randomint(3) == 0) {
    thread maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("straub_sizzler_intro_alt", "exterior", 0, level.straub_airship);
  }

  level.straub_airship.siz_cannon method_80D5();
  level.straub_airship.siz_cannon lib_0378::func_8D74("blimp_projectile");
}

airship_turret_stop_firing() {
  level.straub_airship.siz_cannon method_80D6();
}

airship_turret_is_firing() {
  level.straub_airship.siz_cannon method_80D7();
}

airship_turret_update_valid_targets() {
  level endon("entered_airship_sizzler_pause");
  var_00 = maps\mp\zombies\zombie_sizzler::noofsizzlerscanspawn();
  if(var_00 <= 0) {
    return;
  }

  var_01 = lib_0547::func_4090("zombie_generic");
  level.straub_airship.valid_targets = [];
  foreach(var_03 in var_01) {
    var_04 = var_03 method_85A5();
    if(var_04 == "zombie_animclass" || !common_scripts\utility::func_562E(var_03.transformingtosizzler)) {
      if(airship_turret_is_valid_target(var_03)) {
        level.straub_airship.valid_targets[level.straub_airship.valid_targets.size] = var_03;
      }
    }
  }
}

airship_turret_is_valid_target(param_00) {
  if(param_00.var_BA4 == "traverse") {
    return 0;
  }

  if(common_scripts\utility::func_562E(param_00.var_103)) {
    return 0;
  }

  if(!param_00 lib_0547::func_4B2C()) {
    return 0;
  }

  return 1;
}

___airship_animation___() {}

airship_distant_handler(param_00) {
  wait(param_00);
  while(!common_scripts\utility::func_3C77("flag_drop_pod_reached_airship")) {
    wait(5);
    self method_8495("s2_zom_zep_extra_zep", self.var_116, self.var_1D);
    wait(getanimlength(%s2_zom_zep_extra_zep));
    wait(randomfloatrange(0, 3));
  }

  self delete();
}

airship_animation_master_handler() {
  var_00 = getent("zeppelin_animation_node", "targetname");
  thread airship_animation_straub_entrance(var_00);
  common_scripts\utility::func_3C9F("flag_airship_summoned");
  thread airship_animation_enter_and_shoot_tethers(var_00);
  thread airship_animation_pull_down_airship(var_00);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_bring_down_airship", "step_enter_dropcage"));
  thread airship_animation_drop_pod_movement(var_00);
  common_scripts\utility::func_3C9F("flag_drop_pod_reached_airship");
  thread airship_animation_airship_drop_pod_open();
  thread airship_animation_airship_drop_pod_move_down(var_00);
}

airship_animation_straub_entrance(param_00) {
  common_scripts\utility::func_3C9F("flag_exit_underbelly");
  level.straub_airship method_805B();
  level.straub_airship method_8495("s2_zom_zep_intro", param_00.var_116, param_00.var_1D);
  level.straub_airship playzeppelinfx();
  foreach(var_02 in level.var_744A) {
    var_02 thread airship_animation_straub_entrance_play_rumbles();
  }

  level.straub_airship lib_0378::func_8D74("start_straub_airship_loop");
  level.straub_airship lib_0378::func_8D74("straub_airship_entrance");
  wait(getanimlength(%s2_zom_zep_intro));
  common_scripts\utility::func_3C8F("flag_airship_reached_middle");
  level.straub_airship lib_0378::func_8D74("stop_airship_loop", 10);
}

airship_animation_straub_entrance_play_rumbles() {
  self endon("disconnect");
  wait(7.5);
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 0.1, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("damage_light", 0.1, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("damage_heavy", 0.3, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 3, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 7, 0.15);
}

airship_animation_straub_entrance_play_rumble_for_time(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 0.15;
  }

  while(param_01 > 0) {
    self playrumbleonentity(param_00);
    wait(param_02);
    param_01 = param_01 - param_02;
  }
}

playzeppelinfx() {
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_L_01");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_L_02");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_R_01");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_R_02");
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zep_prop_spin"), self, "prop_left");
  playFXOnTag(common_scripts\utility::func_44F5("zmb_ber_zep_prop_spin"), self, "prop_right");
}

airship_animation_enter_and_shoot_tethers(param_00) {
  var_01 = getEntArray("airship_anchor_model", "script_noteworthy");
  var_02 = getent("drop_pod_cable", "script_noteworthy");
  var_03 = getent("drop_pod_model", "script_noteworthy");
  level.anchor_courtyard = undefined;
  level.anchor_museum = undefined;
  level.anchor_refuge = undefined;
  level.anchor_underbelly = undefined;
  if(!isDefined(level.straub_airship_model)) {
    level.straub_airship_model = getent("straub_airship_exterior_model", "script_noteworthy");
  }

  level.straub_airship lib_0378::func_8D74("start_straub_airship_loop");
  level.straub_airship lib_0378::func_8D74("straub_airship_entrance");
  level.cable_courtyard = spawn("script_model", level.straub_airship.var_116);
  level.cable_courtyard setModel("zbr_zeppelin_tether_cable_01");
  level.cable_museum = spawn("script_model", level.straub_airship_model.var_116);
  level.cable_museum setModel("zbr_zeppelin_tether_cable_01");
  level.cable_refuge = spawn("script_model", level.straub_airship_model.var_116);
  level.cable_refuge setModel("zbr_zeppelin_tether_cable_01");
  level.cable_underbelly = spawn("script_model", level.straub_airship_model.var_116);
  level.cable_underbelly setModel("zbr_zeppelin_tether_cable_01");
  foreach(var_05 in var_01) {
    switch (var_05.var_8260) {
      case "airship_tether_courtyard":
        level.anchor_courtyard = var_05;
        break;

      case "airship_tether_museum":
        level.anchor_museum = var_05;
        break;

      case "airship_tether_refuge":
        level.anchor_refuge = var_05;
        break;

      case "airship_tether_underbelly":
        level.anchor_underbelly = var_05;
        break;

      default:
        break;
    }
  }

  wait(1);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_into", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_into", param_00.var_116, param_00.var_1D);
  var_03 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_into", param_00.var_116, param_00.var_1D);
  var_07 = getanimlength(%s2_zom_zep_tether_scene_zep_into);
  level.straub_airship_model common_scripts\utility::func_2CBE(var_07, ::method_8495, "s2_zom_zep_tether_scene_zep_into_idle", param_00.var_116, param_00.var_1D);
  var_02 common_scripts\utility::func_2CBE(var_07, ::method_8495, "s2_zom_zep_tether_scene_zep_drop_pod_cable_into_idle", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard solid();
  level.anchor_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_into", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_into", param_00.var_116, param_00.var_1D);
  level.cable_courtyard common_scripts\utility::func_2CBE(getanimlength(%s2_zom_zep_tether_scene_tether_bolt_br_cable_into), ::method_8495, "s2_zom_zep_tether_scene_tether_bolt_br_cable_into_idle", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_br_into, 0.9799, 0.5);
  level.anchor_museum solid();
  level.anchor_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_into", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_into", param_00.var_116, param_00.var_1D);
  level.cable_museum common_scripts\utility::func_2CBE(getanimlength(%s2_zom_zep_tether_scene_tether_bolt_fr_cable_into), ::method_8495, "s2_zom_zep_tether_scene_tether_bolt_fr_cable_into_idle", param_00.var_116, param_00.var_1D);
  level.anchor_museum thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_fr_into, 0.9833, 0.3);
  level.anchor_refuge solid();
  level.anchor_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_into", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_into", param_00.var_116, param_00.var_1D);
  level.cable_refuge common_scripts\utility::func_2CBE(getanimlength(%s2_zom_zep_tether_scene_tether_bolt_bl_cable_into), ::method_8495, "s2_zom_zep_tether_scene_tether_bolt_bl_cable_into_idle", param_00.var_116, param_00.var_1D);
  level.anchor_refuge thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_bl_into, 0.9813, 0.9);
  level.anchor_underbelly solid();
  level.anchor_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_into", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_into", param_00.var_116, param_00.var_1D);
  level.cable_underbelly common_scripts\utility::func_2CBE(getanimlength(%s2_zom_zep_tether_scene_tether_bolt_fl_cable_into), ::method_8495, "s2_zom_zep_tether_scene_tether_bolt_fl_cable_into_idle", param_00.var_116, param_00.var_1D);
  level.anchor_underbelly thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_fl_into, 0.9826, 0.15);
  wait(3);
  common_scripts\utility::func_3C8F("airship_tethers_out");
}

play_tether_impact_shake(param_00, param_01, param_02) {
  var_03 = 0.75;
  var_04 = getanimlength(param_00) * param_01;
  maps\mp\_utility::func_2CED(var_04 - param_02, ::earthquake_alive_players_with_origin, 1, 1, 1000, self);
  wait(var_04 - var_03);
  lib_0378::func_8D74("tether_ground_impact");
  wait(var_03);
  if(self == level.anchor_courtyard) {
    level notify("airship_anchor_courtyard_impact");
    var_05 = getent("anchor_a_clip", "targetname");
    var_05.var_116 = var_05.var_116 + (0, 0, 512);
    var_05 method_805F();
    var_06 = lib_0547::func_408F();
    if(isDefined(var_06) && var_06.size > 0) {
      foreach(var_08 in var_06) {
        if(var_08 istouching(var_05)) {
          var_08 dodamage(999999, var_08.var_116);
        }
      }
    }
  }
}

airship_animation_pull_down_airship(param_00) {
  var_01 = getent("drop_pod_cable", "script_noteworthy");
  var_02 = getent("drop_pod_model", "script_noteworthy");
  if(!isDefined(level.airship_anchor_flag_array)) {
    level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];
  }

  var_03 = level.airship_anchor_flag_array;
  var_04 = common_scripts\utility::func_3CA3(var_03);
  foreach(var_06 in level.var_744A) {
    var_06 thread airship_drop_pod_push_players();
  }

  var_03 = common_scripts\utility::func_F93(var_03, var_04);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_down", param_00.var_116, param_00.var_1D);
  level.anchor_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_down", param_00.var_116, param_00.var_1D);
  level.anchor_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_down", param_00.var_116, param_00.var_1D);
  level.anchor_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_down", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down", param_00.var_116, param_00.var_1D);
  var_08 = "25percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_08);
  var_09 = getanimlength(%s2_zom_zep_tether_scene_zep_drop_down);
  wait(var_09);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_idle", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_idle", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_idle", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_idle", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_idle", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_idle", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_idle", param_00.var_116, param_00.var_1D);
  var_0A = common_scripts\utility::func_3CA3(var_03);
  var_03 = common_scripts\utility::func_F93(var_03, var_0A);
  level.straub_airship scriptmodelclearanim();
  var_02 scriptmodelclearanim();
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_02", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_02", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_02", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_down", param_00.var_116, param_00.var_1D);
  level.anchor_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_down", param_00.var_116, param_00.var_1D);
  level.anchor_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_down", param_00.var_116, param_00.var_1D);
  level.anchor_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_down", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_02", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_02", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_02", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_02", param_00.var_116, param_00.var_1D);
  var_08 = "50percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_08);
  var_0B = getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_02);
  wait(var_0B);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_02_idle", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_02_idle", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_02_idle", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_02_idle", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_02_idle", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_02_idle", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_02_idle", param_00.var_116, param_00.var_1D);
  var_0C = common_scripts\utility::func_3CA3(var_03);
  var_03 = common_scripts\utility::func_F93(var_03, var_0C);
  level.straub_airship scriptmodelclearanim();
  var_02 scriptmodelclearanim();
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_03", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_03", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_03", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_down", param_00.var_116, param_00.var_1D);
  level.anchor_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_down", param_00.var_116, param_00.var_1D);
  level.anchor_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_down", param_00.var_116, param_00.var_1D);
  level.anchor_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_down", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_03", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_03", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_03", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_03", param_00.var_116, param_00.var_1D);
  var_08 = "75percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_08);
  var_0D = getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_03);
  wait(var_0D);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_03_idle", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_03_idle", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_03_idle", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_03_idle", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_03_idle", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_03_idle", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_03_idle", param_00.var_116, param_00.var_1D);
  level.fourth_flag = var_03[0];
  common_scripts\utility::func_3C9F(level.fourth_flag);
  level.straub_airship scriptmodelclearanim();
  var_02 scriptmodelclearanim();
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_04", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_04", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_04", param_00.var_116, param_00.var_1D);
  level.anchor_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_down_04", param_00.var_116, param_00.var_1D);
  level.anchor_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_down_04", param_00.var_116, param_00.var_1D);
  level.anchor_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_down_04", param_00.var_116, param_00.var_1D);
  level.anchor_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_down_04", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_04", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_04", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_04", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_04", param_00.var_116, param_00.var_1D);
  var_08 = "100percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_08);
  var_0E = getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_04);
  wait(var_0E);
  level.straub_airship_model method_8495("s2_zom_zep_tether_scene_zep_drop_down_04_idle", param_00.var_116, param_00.var_1D);
  level.cable_courtyard method_8495("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_04_idle", param_00.var_116, param_00.var_1D);
  level.cable_museum method_8495("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_04_idle", param_00.var_116, param_00.var_1D);
  level.cable_underbelly method_8495("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_04_idle", param_00.var_116, param_00.var_1D);
  level.cable_refuge method_8495("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_04_idle", param_00.var_116, param_00.var_1D);
  var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_04_idle", param_00.var_116, param_00.var_1D);
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_down_04_idle", param_00.var_116, param_00.var_1D);
  var_0F = getent("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_0F solid();
  var_0F method_805F();
  var_10 = getent("clip_door", "script_noteworthy");
  var_10 notsolid();
  var_10 method_8060();
  var_02 scriptmodelclearanim();
  var_02 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
  var_02 = getent("drop_pod_model", "script_noteworthy");
  triggerfx(var_02.lightfx);
  var_11 = getent("dropcage_push_trigger", "targetname");
  var_11 delete();
  var_12 = getent("pod_underneath_clip", "targetname");
  var_12 solid();
  var_12 method_805F();
}

airship_animation_drop_pod_movement(param_00) {
  level endon("drop_pod_reached_airship");
  var_01 = getent("drop_pod_model", "script_noteworthy");
  var_02 = getent("drop_pod_cable", "script_noteworthy");
  var_03 = getent("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_04 = getent("clip_door", "script_noteworthy");
  var_05 = getent("quest_trig_enter_dropcage", "targetname");
  var_06 = getanimlength(%s2_zom_zep_tether_scene_zep_drop_pod_up);
  level.drop_pod_up_start_time = gettime();
  for(;;) {
    level waittill("drop_pod_moving_up");
    foreach(var_08 in level.var_744A) {
      var_08 thread pull_players_inside();
    }

    var_01 scriptmodelclearanim();
    var_01 scriptmodelplayanim("s2_zmb_drop_pod_close_front", "drop_pod_door_close");
    var_01 scriptmodelclearanim();
    var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_up", param_00.var_116, param_00.var_1D);
    var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_up", param_00.var_116, param_00.var_1D);
    level.straub_airship method_8495("s2_zom_zep_tether_scene_zep_up", param_00.var_116, param_00.var_1D);
    level.drop_pod_up_start_time = gettime();
    var_03 notsolid();
    var_03 method_8060();
    var_0A = level common_scripts\utility::func_A74D("drop_pod_moving_down", var_06);
    if(isDefined(var_0A) && var_0A == "timeout") {
      level notify("drop_pod_reached_airship");
    }

    var_0B = gettime() - level.drop_pod_up_start_time * 0.001;
    var_0C = clamp(var_06 - var_0B, 0, var_06);
    var_01 scriptmodelclearanim();
    var_02 scriptmodelclearanim();
    var_01 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_up_reversed", param_00.var_116, param_00.var_1D, "drop_pod_return_to_ground", var_0C);
    var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_cable_up_reversed", param_00.var_116, param_00.var_1D, undefined, var_0C);
    wait(var_0B);
    var_01 scriptmodelclearanim();
    var_01 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
    var_03 solid();
    var_03 method_805F();
    var_03 notsolid();
    var_04 notsolid();
    var_04 method_8060();
  }
}

airship_drop_pod_push_players() {
  var_00 = getent("dropcage_push_trigger", "targetname");
  var_01 = common_scripts\utility::func_46B5("pull_players_here", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_02);
    if(var_02 == self) {
      var_03 = getent("quest_trig_enter_dropcage", "targetname");
      wait 0.05;
      player_pulls_towards(var_01.var_116, 500);
    }

    wait(0.1);
  }
}

pull_players_inside() {
  var_00 = getent("pod_door_trigger", "targetname");
  var_01 = getent("org_tp_plaza", "script_noteworthy");
  var_02 = getent("clip_door", "script_noteworthy");
  if(self istouching(var_00)) {
    self setorigin(var_01.var_116);
  }

  wait(1);
  var_02 solid();
  var_02 method_805F();
}

player_pulls_towards(param_00, param_01) {
  var_02 = param_00 - self.var_116;
  var_03 = param_01 * vectornormalize(var_02);
  var_03 = (var_03[0], var_03[1], 250);
  if(param_01 > 0) {
    self setvelocity(var_03);
  }
}

airship_animation_airship_drop_pod_open() {
  var_00 = getent("model_airship_drop_pod", "script_noteworthy");
  var_00 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "airship_drop_pod_door_open");
}

airship_animation_airship_drop_pod_move_down(param_00) {
  level waittill("airship_drop_pod_moving_down");
  var_01 = getanimlength(%s2_zom_zep_tether_scene_zep_drop_pod_up_reversed);
  var_02 = getent("drop_pod_model", "script_noteworthy");
  var_02 scriptmodelclearanim();
  var_02 method_8495("s2_zom_zep_tether_scene_zep_drop_pod_up_reversed", param_00.var_116, param_00.var_1D);
  var_02 lib_0378::func_8D74("droppod_winch_down");
  thread earthquake_alive_players(0.3, var_01, 1000);
  wait(var_01);
  var_02 scriptmodelclearanim();
  var_02 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
  var_02 lib_0378::func_8D74("droppod_ground_impact");
  level notify("airship_drop_pod_reached_ground");
}

____________________hack_station____________________() {}

hack_station_init() {
  lib_0378::func_8D74("aud_zep_puzzle_spark_loop");
  if(!common_scripts\utility::func_3C83("hack_stations_initialized")) {
    common_scripts\utility::func_3C87("hack_stations_disabled");
    common_scripts\utility::func_3C87("hack_stations_initialized");
    thread hack_station_handler();
    wait 0.05;
  }
}

hack_station_handler() {
  for(;;) {
    hack_station_hide_all();
    level waittill("show_hack_stations");
    hack_station_show_all();
    if(common_scripts\utility::func_3C77("hack_stations_disabled")) {
      common_scripts\utility::func_3C7B("hack_stations_disabled");
    }

    hack_station_start_logic();
    level waittill("hide_hack_stations");
    common_scripts\utility::func_3C8F("hack_stations_disabled");
  }
}

hack_station_hide_all() {
  hack_station_hide("hack_station_00b_terminal");
  hack_station_hide("hack_station_00_terminal");
  hack_station_hide("hack_station_01_terminal");
  hack_station_hide("hack_station_02_terminal");
  hack_station_hide("hack_station_03_terminal");
  var_00 = getEntArray("hack_station_interactable_door", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }
}

hack_station_hide(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.var_3A == "trigger_use") {
      var_03 makeunusable();
      continue;
    }

    if(var_03.var_3A != "script_origin") {
      var_03 method_805C();
    }
  }
}

hack_station_show_all() {
  hack_station_show("hack_station_00b_terminal");
  hack_station_show("hack_station_00_terminal");
  hack_station_show("hack_station_01_terminal");
  hack_station_show("hack_station_02_terminal");
  hack_station_show("hack_station_03_terminal");
  var_00 = getEntArray("hack_station_interactable_door", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 method_805B();
  }
}

hack_station_show(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.var_3A == "trigger_use") {
      var_03 makeusable();
      continue;
    }

    if(var_03.var_3A != "script_origin") {
      var_03 method_805B();
    }
  }
}

hack_station_start_logic() {
  level.hack_station_current_node = undefined;
  thread hack_station_think("hack_station_00b_terminal");
  thread hack_station_think("hack_station_00_terminal");
  thread hack_station_think("hack_station_01_terminal");
  thread hack_station_think("hack_station_02_terminal");
  thread hack_station_think("hack_station_03_terminal");
  thread hack_station_interactable_handler();
  wait 0.05;
  level.hack_station_lights = getEntArray("hack_station_light", "script_noteworthy");
  foreach(var_01 in level.hack_station_lights) {
    var_01.tag_org = spawn("script_model", var_01.var_116);
    var_01.tag_org.var_1D = var_01.var_1D;
    var_01.tag_org setModel("tag_origin");
    var_01.tag_org method_8449(var_01);
    var_01.tag_org_color = "blue";
    var_01 thread hack_station_blinking_light_update_color();
    wait 0.05;
    var_01 thread hack_station_check_color_against_triggers(99);
  }
}

hack_station_think(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  foreach(var_06 in var_01) {
    if(isDefined(var_06.var_8260)) {
      switch (var_06.var_8260) {
        case "hack_station_link_org":
          var_04 = var_06;
          break;

        case "hack_station_player_org":
          var_03 = var_06;
          break;

        case "hack_station_use_trig":
          var_02 = var_06;
          break;

        default:
          break;
      }
    }
  }

  thread hack_station_set_angle_offset_data(param_00, var_04.var_1D[1]);
  while(!common_scripts\utility::func_3C77("hack_stations_disabled")) {
    var_02 waittill("trigger", var_08);
    if(var_08 method_83B8() || var_08 method_82E5()) {
      continue;
    }

    var_09 = var_08;
    var_09 method_8322();
    if(var_09 getstance() != "stand") {
      var_09 setstance("stand");
      wait(0.7);
    }

    var_09 method_812C(0);
    var_0A = var_08.var_116;
    var_0B = var_08.var_1D;
    var_03.var_116 = var_0A;
    var_03.var_1D = var_0B;
    var_09 playerlinkto(var_03, undefined, 0.1, 0, 0, 0, 0);
    var_03 moveto(var_04.var_116, 0.5, 0, 0);
    var_03 rotateto(var_04.var_1D, 0.5, 0, 0);
    wait(0.5);
    level notify("player_activated_hack_console");
    var_09 thread hack_station_start_hacking(param_00, var_02);
    var_09 waittill("stop_using_station");
    thread hack_station_cleanup(param_00);
    var_09 method_8323();
    var_03 moveto(var_0A + (0, 0, 1), 0.5);
    var_03 rotateto(var_0B, 0.5);
    wait(0.5);
    var_09 unlink();
    var_09 method_812C(1);
    var_09 setstance("stand");
    wait(0.5);
  }
}

hack_station_set_angle_offset_data(param_00, param_01) {
  while(!isDefined(level.hackstationdata)) {
    wait 0.05;
  }

  waittillframeend;
  if(param_01 == 90 || param_01 == 270) {
    level.hackstationdata[param_00]["should_apply_yaw_offset"] = 1;
    return;
  }

  level.hackstationdata[param_00]["should_apply_yaw_offset"] = 0;
}

hack_station_start_hacking(param_00, param_01) {
  self endon("stop_using_station");
  thread lockin_system_monitor_death();
  var_02 = common_scripts\utility::func_55E0();
  var_03 = var_02;
  var_04 = !var_02;
  thread lockin_system_monitor_unuse(param_01, var_03, var_04);
  hack_station_handle_inputs(param_00);
}

hack_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::knock_off_battery("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

hack_station_handle_inputs(param_00) {
  self endon("stop_using_station");
  level endon("hack_stations_disabled");
  level endon("flag_override_electroschnell_complete");
  var_01 = getEntArray(param_00, "targetname");
  var_02 = [];
  var_03 = [];
  foreach(var_05 in var_01) {
    if(isDefined(var_05.var_8260)) {
      switch (var_05.var_8260) {
        case "hack_station_node":
          var_02[var_02.size] = var_05;
          break;

        case "hack_station_path":
          var_03[var_03.size] = var_05;
          break;

        default:
          break;
      }
    }
  }

  var_07 = [0, 0, 0];
  var_08 = [0, 0, 0];
  var_09 = 3.01;
  for(;;) {
    var_07 = self getnormalizedmovement() / var_09;
    if(abs(var_07[0]) > abs(var_07[1])) {
      var_07 = (var_07[0], 0, 0);
    } else if(abs(var_07[1]) > abs(var_07[0])) {
      var_07 = (0, var_07[1], 0);
    }

    if(var_07[0] != 0 || var_07[1] != 0) {
      hack_station_update_light_positions(var_07, param_00, var_02, var_03);
    }

    wait 0.05;
  }
}

hack_station_update_light_positions(param_00, param_01, param_02, param_03) {
  level endon("flag_override_electroschnell_complete");
  var_04 = self.var_116;
  var_05 = var_04;
  var_06 = undefined;
  foreach(var_08 in level.hack_station_lights) {
    if(var_08.var_1A5 == param_01) {
      var_06 = var_08;
      break;
    }
  }

  var_05 = var_06 hack_station_get_offset_by_inputs(param_00[0], param_00[1]);
  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  foreach(var_0E in param_02) {
    if(ispointinvolume(var_05, var_0E)) {
      var_0A = 1;
      level.hack_station_current_node = var_0E;
      thread hack_station_node_notify_linked_interactable(var_0E, self, "node_highlighted");
      if(var_06.tag_org_color != "green") {
        var_0C = 1;
      }

      break;
    }
  }

  if(!var_0A) {
    foreach(var_0E in param_03) {
      if(ispointinvolume(var_05, var_0E)) {
        var_0A = 1;
        thread hack_station_node_notify_linked_interactable(var_0E, self, "node_abandoned");
        if(var_06.tag_org_color != "blue") {
          var_0C = 1;
        }

        break;
      }
    }
  }

  if(var_0A) {
    for(var_12 = 0; var_12 < level.hack_station_lights.size; var_12++) {
      level.hack_station_lights[var_12] hack_station_send_light_to_offsets(param_00[0], param_00[1], var_0C, var_12);
    }
  }
}

hack_station_node_notify_linked_interactable(param_00, param_01, param_02) {
  level endon("flag_override_electroschnell_complete");
  if(isDefined(level.hack_station_current_node.var_165)) {
    var_03 = getent(level.hack_station_current_node.var_165, "targetname");
    var_03 notify(param_02);
  }
}

hack_station_blinking_light_update_color() {
  level endon("hack_stations_disabled");
  var_00 = common_scripts\utility::func_46B7(self.var_1A5, "targetname");
  var_01 = "blue";
  var_02 = "green";
  var_03 = -0.5;
  var_04 = spawn("script_model", self.tag_org.var_116);
  var_04 setModel("zbr_zeppelin_terminal_light");
  var_04.var_1D = self.tag_org.var_1D;
  var_04.var_116 = var_04.var_116 + anglestoup(var_04.var_1D) * var_03;
  var_04 method_805C();
  for(;;) {
    self waittill("color_swap", var_05);
    if(var_01 == "blue") {
      stopFXOnTag(level.var_611["hack_spark_" + var_01], self.tag_org, "tag_origin");
    }

    wait 0.05;
    if(var_01 != "blue") {
      playFXOnTag(level.var_611["hack_spark_" + var_02], self.tag_org, "tag_origin");
    }

    self.tag_org_color = var_02;
    var_01 = var_02;
    if(var_01 == "blue") {
      var_02 = "green";
      var_04 method_805C();
      var_04 lib_0378::func_8D74("aud_zep_puzzle_light_switch_off");
      continue;
    }

    var_02 = "blue";
    if(isDefined(var_05)) {
      var_06 = common_scripts\utility::func_4461(self.tag_org.var_116, var_00, 5);
      var_04.var_116 = var_06.var_116 + anglestoup(var_06.var_1D) * var_03;
      var_04 common_scripts\utility::func_2CBE(0.05, ::method_805B);
      var_04 lib_0378::func_8D74("aud_zep_puzzle_light_switch");
    }
  }
}

hack_station_send_light_to_offsets(param_00, param_01, param_02, param_03) {
  level endon("flag_override_electroschnell_complete");
  var_04 = hack_station_get_offset_by_inputs(param_00 / 2, param_01 / 2);
  self.var_116 = var_04;
  if(isDefined(param_02) && param_02) {
    hack_station_check_color_against_triggers(param_03);
  }
}

hack_station_update_spark_along_path() {
  while(!isDefined(level.hack_station_current_node)) {
    wait 0.05;
  }

  level.hackstationdata = [];
  level.hackstationdata["right"] = [];
  level.hackstationdata["forward"] = [];
  hack_station_reset_data(getent("airship_node_03_01", "targetname").var_116);
  for(;;) {
    var_00 = getent(level.hack_station_current_node.var_165, "targetname");
    var_01 = hack_station_get_all_nodes_connected_to_node(var_00);
    var_02 = level.hack_station_current_node.var_1A5;
    var_03 = common_scripts\utility::func_4461(level.hack_station_current_node.var_116, getEntArray("hack_station_light", "script_noteworthy"));
    hack_station_hack_station_data_populate(var_01, var_00, var_03, var_02);
    level.hackstationdata["previous_org"] = var_00.var_116 + (level.hackstationdata["forward"]["offset_from_in_world_node"], level.hackstationdata["right"]["offset_from_in_world_node"], 0);
    var_04 = getent("airship_node_03_02", "targetname");
    var_05 = distance2d(var_04.var_116, level.hackstationdata["previous_org"]);
    if(var_05 < 500) {
      var_06 = getent("airship_node_03_03", "targetname");
      var_07 = distance2d(var_06.var_116, var_04.var_116);
      if(var_05 < var_07) {
        level.hackstationdata["previous_org"] = (level.hackstationdata["previous_org"][0], level.hackstationdata["previous_org"][1], var_04.var_116[2]);
      }
    }

    hack_station_reset_data(level.hackstationdata["previous_org"]);
    wait 0.05;
  }
}

hack_station_reset_data(param_00) {
  level.hackstationdata["right"]["total_in_world_dist"] = 0;
  level.hackstationdata["right"]["total_hack_station_dist"] = 0;
  level.hackstationdata["right"]["offset_from_current_station_node"] = 0;
  level.hackstationdata["right"]["offset_from_in_world_node"] = 0;
  level.hackstationdata["forward"] = [];
  level.hackstationdata["forward"]["total_in_world_dist"] = 0;
  level.hackstationdata["forward"]["total_hack_station_dist"] = 0;
  level.hackstationdata["forward"]["offset_from_current_station_node"] = 0;
  level.hackstationdata["forward"]["offset_from_in_world_node"] = 0;
  level.hackstationdata["previous_org"] = param_00;
}

hack_station_hack_station_data_populate(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  for(var_05 = 0; var_05 < param_00.size; var_05++) {
    var_06 = param_00[var_05].var_116[1] - param_01.var_116[1];
    var_07 = param_00[var_05].var_116[0] - param_01.var_116[0];
    if(abs(var_06) > abs(var_07)) {
      if(abs(level.hackstationdata["right"]["total_in_world_dist"]) > 0) {
        var_08 = param_01.var_116[1] - level.hackstationdata["previous_org"][1];
        var_09 = var_06;
        if(var_08 / abs(var_08) != var_06 / abs(var_06)) {
          level.hackstationdata["right"]["total_in_world_dist"] = var_06;
          hack_station_data_populate_scaled_distances("right", param_01, param_00[var_05], param_02, param_03);
          var_04 = param_00[var_05];
        }
      } else {
        level.hackstationdata["right"]["total_in_world_dist"] = var_06;
        hack_station_data_populate_scaled_distances("right", param_01, param_00[var_05], param_02, param_03);
        var_04 = param_00[var_05];
      }

      continue;
    }

    if(abs(level.hackstationdata["forward"]["total_in_world_dist"]) > 0) {
      var_08 = param_01.var_116[0] - level.hackstationdata["previous_org"][0];
      var_0A = undefined;
      if(var_08 != 0) {
        var_0A = var_08 / abs(var_08);
      } else {
        var_0A = 0;
      }

      var_09 = var_07;
      var_0B = undefined;
      if(var_09 != 0) {
        var_0B = var_07 / abs(var_07);
      } else {
        var_0B = 0;
      }

      if(var_0A != var_0B) {
        level.hackstationdata["forward"]["total_in_world_dist"] = var_07;
        hack_station_data_populate_scaled_distances("forward", param_01, param_00[var_05], param_02, param_03);
        var_04 = param_00[var_05];
      }

      continue;
    }

    level.hackstationdata["forward"]["total_in_world_dist"] = var_07;
    hack_station_data_populate_scaled_distances("forward", param_01, param_00[var_05], param_02, param_03);
    var_04 = param_00[var_05];
  }

  if(!isDefined(level.hackstationdata["right"]["total_in_world_dist"]) || level.hackstationdata["right"]["total_in_world_dist"] == 0) {
    hack_station_data_populate_scaled_distances("right", param_01, param_00[0], param_02, param_03);
  }

  if(!isDefined(level.hackstationdata["forward"]["total_in_world_dist"]) || level.hackstationdata["forward"]["total_in_world_dist"] == 0) {
    hack_station_data_populate_scaled_distances("forward", param_01, param_00[0], param_02, param_03);
  }

  var_06 = level.hackstationdata["right"]["offset_from_in_world_node"];
  var_07 = level.hackstationdata["forward"]["offset_from_in_world_node"];
  if(abs(var_06) < abs(var_07)) {
    level.hackstationdata["right"]["offset_from_in_world_node"] = level.hackstationdata["right"]["offset_from_in_world_node"] / 1000;
    level.in_world_spark.var_1D = (level.in_world_spark.var_1D[0], 90, level.in_world_spark.var_1D[2]);
    return;
  }

  level.hackstationdata["forward"]["offset_from_in_world_node"] = level.hackstationdata["forward"]["offset_from_in_world_node"] / 1000;
  level.in_world_spark.var_1D = (level.in_world_spark.var_1D[0], 0, level.in_world_spark.var_1D[2]);
}

hack_station_data_populate_scaled_distances(param_00, param_01, param_02, param_03, param_04) {
  var_05 = common_scripts\utility::func_46B7("hack_station_node_org", "script_noteworthy");
  var_06 = undefined;
  var_07 = getEntArray(param_02.var_1A5, "script_noteworthy");
  foreach(var_09 in var_07) {
    if(var_09.var_1A5 == param_04) {
      var_06 = common_scripts\utility::func_4461(var_09.var_116, var_05, 5);
    }
  }

  var_0B = undefined;
  var_0C = getEntArray(param_01.var_1A5, "script_noteworthy");
  foreach(var_09 in var_0C) {
    if(var_09.var_1A5 == param_04) {
      var_0B = common_scripts\utility::func_4461(var_09.var_116, var_05, 5);
    }
  }

  if(param_00 == "right") {
    if(!isDefined(level.hackstationdata[param_04]) || !level.hackstationdata[param_04]["should_apply_yaw_offset"]) {
      level.hackstationdata[param_00]["total_hack_station_dist"] = var_0B.var_116[1] - var_06.var_116[1];
      level.hackstationdata[param_00]["offset_from_current_station_node"] = var_0B.var_116[1] - param_03.var_116[1];
    } else {
      level.hackstationdata[param_00]["total_hack_station_dist"] = var_0B.var_116[0] - var_06.var_116[0];
      level.hackstationdata[param_00]["offset_from_current_station_node"] = var_0B.var_116[0] - param_03.var_116[0];
    }
  } else if(!isDefined(level.hackstationdata[param_04]) || !level.hackstationdata[param_04]["should_apply_yaw_offset"]) {
    level.hackstationdata[param_00]["total_hack_station_dist"] = var_0B.var_116[0] - var_06.var_116[0];
    level.hackstationdata[param_00]["offset_from_current_station_node"] = var_0B.var_116[0] - param_03.var_116[0];
  } else {
    level.hackstationdata[param_00]["total_hack_station_dist"] = var_0B.var_116[1] - var_06.var_116[1];
    level.hackstationdata[param_00]["offset_from_current_station_node"] = var_0B.var_116[1] - param_03.var_116[1];
  }

  if(abs(level.hackstationdata[param_00]["total_in_world_dist"]) > 0 && abs(level.hackstationdata[param_00]["total_hack_station_dist"]) > 0) {
    var_0F = level.hackstationdata[param_00]["total_in_world_dist"] / level.hackstationdata[param_00]["total_hack_station_dist"];
  } else {
    var_0F = 0;
  }

  level.hackstationdata[param_00]["offset_from_in_world_node"] = level.hackstationdata[param_00]["offset_from_current_station_node"] * var_0F;
}

hack_station_get_all_nodes_connected_to_node(param_00) {
  var_01 = [];
  if(isDefined(param_00.var_1A2)) {
    var_02 = getEntArray(param_00.var_1A2, "targetname");
    if(isDefined(var_02)) {
      foreach(var_04 in var_02) {
        var_01 = common_scripts\utility::func_F6F(var_01, var_04);
      }
    }
  }

  if(isDefined(param_00.var_1A5)) {
    var_02 = getEntArray(param_00.var_1A5, "target");
    if(isDefined(var_02)) {
      foreach(var_04 in var_02) {
        var_01 = common_scripts\utility::func_F6F(var_01, var_04);
      }
    }
  }

  return var_01;
}

hack_station_get_vector_offset(param_00, param_01, param_02) {}

hack_station_check_color_against_triggers(param_00) {
  level endon("hack_stations_disabled");
  var_01 = getEntArray(self.var_1A5, "targetname");
  var_02 = [];
  foreach(var_04 in var_01) {
    if(isDefined(var_04.var_8260)) {
      switch (var_04.var_8260) {
        case "hack_station_node":
          var_02[var_02.size] = var_04;
          break;

        default:
          break;
      }
    }
  }

  var_06 = 0;
  var_07 = undefined;
  foreach(var_09 in var_02) {
    if(var_09 method_858B(self.var_116)) {
      var_07 = var_09;
      var_06 = 1;
      break;
    }
  }

  if(var_06) {
    if(self.tag_org_color == "blue") {
      self notify("color_swap", var_07);
      if(param_00 == 0) {
        thread hack_station_attempt_soul_collection_on_node(var_07);
        return;
      }

      return;
    }

    return;
  }

  if(self.tag_org_color == "green") {
    self notify("color_swap", var_07);
  }
}

hack_station_attempt_soul_collection_on_node(param_00) {
  var_01 = getent(param_00.var_165, "targetname");
  var_01 notify("kill_extra_soulbucket_threads");
  var_01 endon("kill_extra_soulbucket_threads");
  if(isDefined(var_01.soul_charged) && var_01.soul_charged) {
    return;
  }

  var_02 = 256;
  var_03 = 256;
  var_04 = 4;
  var_05 = lib_0547::func_408F();
  var_06 = undefined;
  if(!isDefined(var_05) || var_05.size <= 0) {
    return;
  }

  foreach(var_08 in var_05) {
    if(distance2d(var_01.var_116, var_08.var_116) < var_02 / var_04 && abs(var_01.var_116[2] - var_08.var_116[2]) < var_03 / var_04) {
      var_06 = var_08;
      break;
    }
  }

  if(!isDefined(var_06)) {
    return;
  }

  var_0A = spawn("script_model", var_01.var_116);
  var_0A setModel("tag_origin");
  var_06 thread maps\mp\mp_zombies_soul_collection::func_2024(var_0A, "tag_origin", undefined, "tag_origin");
  if(!common_scripts\utility::func_562E(var_06.var_2FDA) && !lib_0547::func_5565(var_06.var_A4B, "zombie_fireman")) {
    var_06 maps\mp\mp_zombies_soul_collection::func_865C("scripted_soul_eat", 0);
  }

  wait 0.05;
  var_06 dodamage(999999, var_06.var_116);
  var_01.soul_charged = 1;
  level notify("hack_node_soul_collected");
  wait(1);
  var_0A delete();
}

hack_station_get_offset_by_inputs(param_00, param_01) {
  level endon("flag_override_electroschnell_complete");
  var_02 = self.var_116;
  var_02 = var_02 - anglestoright(self.var_1D) * param_01 + anglesToForward(self.var_1D) * param_00;
  return var_02;
}

hack_station_interactable_handler() {
  thread hack_station_update_spark_along_path();
  thread hack_station_interactable_bay_door();
  thread hack_station_interactable_lab_door_left();
  thread hack_station_interactable_lab_door_right();
  thread hack_station_interactable_lab_door_left_back();
  thread hack_station_interactable_lab_door_right_back();
  thread hack_station_interactable_straub_node();
  thread hack_station_moving_spark_handler();
}

hack_station_interactable_bay_door() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_03_03", "targetname");
  var_01 = 0;
  if(!var_01) {
    var_00 waittill("hack_interact");
    foreach(var_03 in level.var_AC1D) {
      if(isDefined(var_03.var_819A) && var_03.var_819A == "airship_bay_door") {
        var_03 notify("open");
      }
    }

    var_01 = 1;
    common_scripts\utility::func_3C8F("flag_open_cargobay_complete");
  }
}

hack_station_interactable_lab_door_left() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_01_02", "targetname");
  var_01 = 0;
  if(!var_01) {
    var_00 waittill("hack_interact");
    foreach(var_03 in level.var_AC1D) {
      if(isDefined(var_03.var_819A) && var_03.var_819A == "airship_lab_door_left") {
        var_03 notify("open");
      }
    }

    var_01 = 1;
    common_scripts\utility::func_3C8F("flag_open_cargobay_left_complete");
  }
}

hack_station_interactable_lab_door_left_back() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_02_01", "targetname");
  var_01 = 0;
  if(!var_01) {
    var_00 waittill("hack_interact");
    foreach(var_03 in level.var_AC1D) {
      if(isDefined(var_03.var_819A) && var_03.var_819A == "airship_lab_door_left_back") {
        var_03 notify("open");
      }
    }

    var_01 = 1;
    common_scripts\utility::func_3C8F("flag_open_cargobay_left_back_complete");
  }
}

hack_station_interactable_lab_door_right() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_05_02", "targetname");
  var_01 = 0;
  if(!var_01) {
    var_00 waittill("hack_interact");
    foreach(var_03 in level.var_AC1D) {
      if(isDefined(var_03.var_819A) && var_03.var_819A == "airship_lab_door_right") {
        var_03 notify("open");
      }
    }

    var_01 = 1;
    common_scripts\utility::func_3C8F("flag_open_cargobay_right_complete");
  }
}

hack_station_interactable_lab_door_right_back() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_04_01", "targetname");
  var_01 = 0;
  if(!var_01) {
    var_00 waittill("hack_interact");
    foreach(var_03 in level.var_AC1D) {
      if(isDefined(var_03.var_819A) && var_03.var_819A == "airship_lab_door_right_back") {
        var_03 notify("open");
      }
    }

    var_01 = 1;
    common_scripts\utility::func_3C8F("flag_open_cargobay_right_back_complete");
  }
}

hack_station_interactable_straub_node() {
  var_00 = getent("airship_node_03_05", "targetname");
  if(!isDefined(var_00.var_A203)) {
    var_00 waittill("hack_interact");
    var_00.var_A203 = 1;
    common_scripts\utility::func_3C8F("flag_override_electroschnell_complete");
  }
}

hack_station_moving_spark_handler() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_03_01", "targetname");
  level.in_world_spark = spawn("script_model", var_00.var_116);
  level.in_world_spark setModel("tag_origin");
  thread hack_station_moving_spark_fx_swap();
  while(!isDefined(level.hackstationdata) || !isDefined(level.hackstationdata["previous_org"])) {
    wait 0.05;
  }

  thread hack_station_moving_spark_position_think();
  var_01 = getEntArray("hack_node_generic", "script_noteworthy");
  foreach(var_03 in var_01) {
    var_03 thread hack_station_interactable_generic_node_think();
  }
}

power_source_effects() {
  var_00 = getent("power_source_bottom_model", "targetname");
  var_01 = spawnfx(level.var_611["zmb_ber_zep_power_source_on"], var_00.var_116, anglesToForward(var_00.var_1D));
  triggerfx(var_01);
  common_scripts\utility::func_3C9F("flag_override_electroschnell_complete");
  wait(10);
  lib_0378::func_8D74("aud_electroschnell_overload_explo");
  var_02 = spawnfx(level.var_611["zmb_ber_zep_power_source_buildup"], var_00.var_116, anglesToForward(var_00.var_1D));
  triggerfx(var_02);
  wait(2);
  var_01 delete();
  var_03 = spawnfx(level.var_611["zmb_ber_zep_power_source_overload"], var_00.var_116, anglesToForward(var_00.var_1D));
  triggerfx(var_03);
  wait(0.5);
  thread earthquake_alive_players(0.2, 2, 1000);
  wait(1);
  level thread common_scripts\_exploder::func_2A6D(216, undefined, 0);
  self waittill("airship_escape_drop_pod_doors_complete");
  var_03 delete();
}

hack_station_moving_spark_fx_swap() {
  level endon("flag_override_electroschnell_complete");
  var_00 = getent("airship_node_03_01", "targetname");
  var_01 = spawn("script_model", var_00.var_116);
  var_01 setModel("tag_origin");
  thread hack_station_moving_spark_fx_kill(var_01);
  playFXOnTag(level.var_611["zmb_ber_shp_elec_tube_point"], var_01, "tag_origin");
  for(;;) {
    level.in_world_spark waittill("swap_spark_FX", var_02, var_03, var_04);
    if(isDefined(var_04)) {
      var_01.var_116 = var_04.var_116;
      killfxontag(level.var_611[var_03], level.in_world_spark, "tag_origin");
      playFXOnTag(level.var_611[var_02], var_01, "tag_origin");
      var_01 lib_0378::func_8D74("aud_zep_puzzle_spark_leave");
      continue;
    }

    killfxontag(level.var_611[var_03], var_01, "tag_origin");
    playFXOnTag(level.var_611[var_02], level.in_world_spark, "tag_origin");
    var_01 lib_0378::func_8D74("aud_zep_puzzle_spark_arrive");
  }
}

hack_station_moving_spark_fx_kill(param_00) {
  level waittill("airship_drop_pod_reached_ground");
  killfxontag(level.var_611["hack_node_light_00"], param_00, "tag_origin");
  killfxontag(level.var_611["hack_node_light_01"], param_00, "tag_origin");
  killfxontag(level.var_611["hack_node_light_00"], level.in_world_spark, "tag_origin");
  killfxontag(level.var_611["hack_node_light_01"], level.in_world_spark, "tag_origin");
}

hack_station_moving_spark_position_think() {
  level endon("flag_override_electroschnell_complete");
  for(;;) {
    level.in_world_spark.var_116 = level.hackstationdata["previous_org"];
    wait 0.05;
  }
}

hack_station_interactable_generic_node_think() {
  level endon("flag_override_electroschnell_complete");
  for(;;) {
    self waittill("node_highlighted");
    level.in_world_spark notify("swap_spark_FX", "zmb_ber_shp_elec_tube_point", "zmb_ber_shp_elec_tube1_rnr", self);
    self waittill("node_abandoned");
    level.in_world_spark notify("swap_spark_FX", "zmb_ber_shp_elec_tube1_rnr", "zmb_ber_shp_elec_tube_point");
  }
}

hack_station_cleanup(param_00) {
  if(isDefined(level.hack_station_current_node.var_165)) {
    var_01 = getent(level.hack_station_current_node.var_165, "targetname");
    var_01 notify("hack_interact");
  }
}

____________________vo____________________() {}

berlinroundstart() {
  thread berlinroundstartvo();
}

berlinroundstartvo() {
  wait(randomintrange(2, 6));
  if(!common_scripts\utility::func_3C77("flag_exit_underbelly")) {
    common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("wavebreak_underbelly");
  }

  if(common_scripts\utility::func_3C77("flag_exit_underbelly")) {
    if(!common_scripts\utility::func_3C77("flag quest_contact_hq step_find_radio")) {
      common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("radio_nag");
    }
  }

  if(common_scripts\utility::func_3C77("flag quest_contact_hq step_find_radio")) {
    if(!common_scripts\utility::func_3C77("flag quest_contact_soviets step_contact_soviets")) {
      common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("radio_code_nag");
    }
  }

  if(common_scripts\utility::func_3C77("flag quest_draw_airship step_ignite_flare")) {
    if(!common_scripts\utility::func_3C77("flag_airship_summoned")) {
      common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("flares_nag");
    }
  }

  if(common_scripts\utility::func_3C77("airship_tethers_out")) {
    if(!common_scripts\utility::func_3C77("flag_airship_fully_lowered")) {
      if(isDefined(level.fourth_flag)) {
        if(common_scripts\utility::func_3C77("flag_hc_quest_finale_door_open")) {
          common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("airship_tether_nag");
        }
      } else {
        common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("airship_tether_nag");
      }
    }
  }

  if(common_scripts\utility::func_3C77("flag quest_bring_down_airship step_reel_anchors")) {
    if(!common_scripts\utility::func_3C77("flag quest_bring_down_airship step_raise_dropcage")) {
      common_scripts\utility::func_7A33(level.var_744A) lib_0367::func_8E3D("airship_pod_nag");
    }
  }
}

berlinroundend() {
  thread berlinroundendvo();
}

berlinroundendvo() {
  wait(randomintrange(1, 3));
  if(!common_scripts\utility::func_3C77("flag_straub_death_scene")) {
    switch (level.var_A980) {
      case 3:
        if(common_scripts\utility::func_3C77("flag_exit_underbelly")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      case 5:
        if(common_scripts\utility::func_3C77("flag_exit_underbelly")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      case 7:
        if(common_scripts\utility::func_3C77("flag_exit_underbelly")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      case 9:
        if(common_scripts\utility::func_3C77("flag_exit_underbelly")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      case 11:
        if(common_scripts\utility::func_3C77("flag_airship_summoned")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      case 13:
        if(common_scripts\utility::func_3C77("flag_quest_wunderbuss_wunderbuss_built")) {
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
        }
        break;

      default:
        break;
    }
  }
}

vo_logic() {
  thread vo_straub_entered_airship();
  var_00 = undefined;
  while(!common_scripts\utility::func_562E(var_00)) {
    if(level.var_744A.size > 0) {
      var_00 = 1;
    }

    foreach(var_02 in level.var_744A) {
      var_00 = !var_02 maps\mp\gametypes\zombies::player_is_playing_loading_cinematic() && var_00;
    }

    wait(0.2);
  }

  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("get_bearings");
  common_scripts\utility::func_3CA2("underbelly_to_underbelly_intact", "underbelly_to_underbelly_rubble");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("get_bearings_nag");
  common_scripts\utility::func_3CA2("underbelly_rubble_to_street", "underbelly_intact_to_street");
  thread vo_straub_airship_intro();
  wait(10);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("vo_radio_code()_find");
  foreach(var_02 in level.var_744A) {
    var_02 thread vo_church_reaction();
    var_02 thread vo_cabaret_reaction();
    var_02 thread vo_museum_reaction();
    var_02 thread vo_radio_code();
  }
}

vo_straub_airship_intro() {
  wait(5);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_intro_alt", "exterior", 0, level.straub_airship);
}

vo_straub_airship_anchor_damage() {
  var_00 = level.airship_anchor_flag_array;
  common_scripts\utility::func_3CA3(var_00);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_tether_start_react_alt", "exterior", 1, level.straub_airship);
  common_scripts\utility::func_3CA1(var_00);
  wait(5);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_tether_done_react_alt", "exterior", 1, level.straub_airship);
}

vo_straub_entered_airship() {
  common_scripts\utility::func_3C9F("flag_drop_pod_reached_airship");
  wait(5);
  var_00 = common_scripts\utility::func_46B7("pa_struct_airship_int", "targetname");
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_airship_boarded", "interior", 1, var_00);
  common_scripts\utility::func_3C9F("flag_open_cargobay_complete");
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_trap_react_1", "interior", 1, var_00);
  common_scripts\utility::func_3CA2("flag_open_cargobay_left_complete", "flag_open_cargobay_right_complete");
  common_scripts\utility::func_3CA2("flag_open_cargobay_left_back_complete", "flag_open_cargobay_right_back_complete");
}

vo_straub_death() {
  var_00 = common_scripts\utility::func_46B7("pa_struct_airship_int", "targetname");
  wait(0.4);
  thread vo_player_see_straub_death();
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath1", "interior", 0, var_00);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath2", "interior", 0, var_00);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath3", "interior", 1, var_00);
}

vo_church_reaction() {
  var_00 = getent("church_vo", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(var_01 == self) {
      wait(2);
      var_01 lib_0367::func_8E3D("location_church_react");
      break;
    }

    wait(1);
  }
}

vo_cabaret_reaction() {
  var_00 = getent("cabaret_vo", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(var_01 == self) {
      wait(2);
      var_01 lib_0367::func_8E3D("location_church_response");
      break;
    }

    wait(1);
  }
}

vo_museum_reaction() {
  var_00 = getent("museum_vo", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(var_01 == self) {
      wait(2);
      var_01 lib_0367::func_8E3D("location_museum_react");
      break;
    }

    wait(1);
  }
}

vo_radio_code() {
  var_00 = getent("radio_code_vo", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(var_01 == self) {
      wait(2);
      var_01 lib_0367::func_8E3D("radio_code_discovery");
      break;
    }

    wait(1);
  }
}

vo_first_sizzler_transformation() {
  var_00 = 0;
  while(var_00 == 0) {
    var_01 = lib_0547::func_4090("zombie_generic");
    foreach(var_03 in var_01) {
      if(zombies_look_at(var_03)) {
        if(isDefined(var_03.transformingtosizzler) && var_03.transformingtosizzler == 1) {
          wait(4);
          lib_0367::func_8E3D("sizzler_first_react");
          var_00 = 1;
          break;
        }
      }
    }

    wait(0.1);
  }
}

vo_airship_anchor_damage() {
  level waittill("airship_anchor_damaged");
  wait(2);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_first_damage");
  var_00 = level.airship_anchor_flag_array;
  common_scripts\utility::func_3CA3(var_00);
  common_scripts\utility::func_3C9F("flag_hc_quest_finale_sword_door_open");
  wait(3);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_pod_dropped");
  level waittill("drop_pod_moving_up");
  wait(1);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_pod_interacted");
}

vo_player_enter_airship() {
  wait(5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_establish");
  level waittill("player_activated_hack_console");
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_console");
}

vo_player_see_straub_death() {
  wait(4.5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_electroschnell_dead");
  wait(8);
  snd_zmb_plr_dlg_play_line_without_drostan("straub_dead");
  wait(8);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_alarm");
}

snd_zmb_plr_dlg_play_line_without_drostan(param_00, param_01, param_02, param_03, param_04, param_05) {
  foreach(var_07 in level.var_744A) {
    if(var_07.var_20DA != "arch") {
      var_07 lib_0367::func_8E3D(param_00, param_01, param_02, param_03, param_04, param_05);
    }
  }
}

vo_airship_escape_pod_closing() {
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("escape_doors_closing");
}

vo_say_hello_to_my_little_bob() {
  wait(1.5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_intro");
  level.bob common_scripts\utility::func_379C("bob_sizzle");
  wait(1.5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_level_up_1");
  level.bob common_scripts\utility::func_379C("bob_smoke");
  wait(1.5);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_level_up_2");
  level.bob common_scripts\utility::func_379C("bob_was_koed");
  wait(3);
  lib_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_death");
}

zombies_look_at(param_00) {
  var_01 = param_00.var_116;
  var_02 = self getEye();
  var_03 = vectornormalize(var_01 - var_02);
  var_04 = vectornormalize(anglesToForward(self geteyeangles()));
  var_05 = vectordot(var_03, var_04);
  wait 0.05;
  var_06 = acos(clamp(var_05, -1, 1));
  if(var_06 < 25 && distance(var_01, var_02) < 420) {
    return 1;
  }

  return 0;
}

______________zombie_bolt_taking______________() {}

spine_player_manager() {
  var_00 = self;
  var_00 endon("disconnect");
  level waittill("spine_collected", var_01, var_02);
  if(var_02 == var_00) {
    var_00 thread spine_collect(var_01);
  }
}

spine_zombie_collect_listener(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(common_scripts\utility::func_562E(self.var_AC10) || !isDefined(self.var_A4B) || !isDefined(param_01) || !isDefined(param_04) || !isDefined(param_03) || !maps\mp\_utility::func_5755(param_03)) {
    return;
  }

  level endon("spine_collected");
  var_09 = undefined;
  switch (self.var_A4B) {
    case "zombie_sizzler":
      var_09 = "sizzler_spine";
      break;

    default:
      break;
  }

  iprintln(var_09 + " collected!");
  param_01.spine_hint_complete = 1;
  common_scripts\utility::func_3C8F("flag_quest_wunderbuss_geistbolt_collected");
  level notify("spine_collected", var_09, param_01);
}

spine_collect(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_01 endon("spine_destroyed");
  var_02 = "bolt_inspect_sizzler_zm";
  var_03 = &"ZOMBIE_WEAPONDLC1_SPINE_ZOMBIE";
  var_04 = "ui_transparent";
  var_01 spine_pickup_anim(var_02);
}

spine_pickup_anim(param_00) {
  var_01 = self;
  while(var_01 method_833B()) {
    wait 0.05;
  }

  var_02 = var_01 getcurrentweapon();
  var_01 common_scripts\utility::func_603();
  var_01 common_scripts\utility::func_600();
  var_01 lib_0586::func_78C(param_00);
  var_01 lib_0586::func_78E(param_00, 1);
  var_01 allowjump(0);
  var_01 method_8308(0);
  wait(0.1);
  var_01 setstance("stand");
  var_01 method_8113(0);
  var_01 method_8114(0);
  var_01 waittill("weapon_change");
  wait(3);
  if(!lib_0547::func_73F9(self, var_02)) {
    var_02 = var_01 lib_0547::func_AB2B();
  }

  var_01 lib_0586::func_78E(var_02);
  var_01 common_scripts\utility::func_617();
  var_01 common_scripts\utility::func_614();
  if(var_01 hasweapon(param_00)) {
    var_01 lib_0586::func_790(param_00);
  }

  var_01 allowmovement(1);
  var_01 allowlook(1);
  var_01 method_8308(1);
  var_01 method_8113(1);
  var_01 method_8114(1);
  var_01 allowjump(1);
}