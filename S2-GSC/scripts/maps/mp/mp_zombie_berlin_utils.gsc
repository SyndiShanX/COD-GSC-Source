/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_utils.gsc
******************************************************/

____________________generic_util____________________() {}

complete_quest_on_trigger(var_0, var_1) {
  level endon(_id_0557::_id_7838(var_0, var_1));
  self waittill("trigger");
  _id_0557::_id_782D(var_0, var_1);
}

earthquake_alive_players(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(isalive(var_5))
      var_3[var_3.size] = var_5;
  }

  _earthquake(var_0, var_1, (0, 0, 0), 9999999, var_3);
}

earthquake_alive_players_with_origin(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in level.players) {
    if(isalive(var_6) && distance(var_6.origin, var_3.origin) <= var_2)
      var_4[var_4.size] = var_6;
  }

  if(var_4.size > 0)
    _earthquake(var_0, var_1, var_3.origin, var_2, var_4);
}

flag_try_set(var_0) {
  if(!common_scripts\utility::_id_3C83(var_0)) {
    return;
  }
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  common_scripts\utility::flag_set(var_0);
}

get_special_melee_weapon_flag_name(var_0) {
  return "hc_" + var_0 + "_revealed";
}

special_melee_weapon_pickup_think(var_0, var_1) {
  level endon("game_over");

  for(;;) {
    var_0 waittill("trigger", var_2);
    _iprintlnbold(var_2.name + " picked up the: " + var_1);

    if(var_1 == "sword")
      var_2 _id_0378::_id_8D74("aud_pickup_barbarosa_sword");

    var_2.special_melee_weapon = var_1;
    var_3 = special_melee_get_weapon_name(var_1);

    if(issubstr(var_3, "shovel"))
      var_3 = _id_0548::_id_454B(var_2, "shovel_zm");

    var_2 _id_0586::_id_078C(var_3);
    var_2 _id_0586::_id_078E(var_3);
    try_give_exp_to_players_for_weap(var_1);
    wait 1;

    if(var_1 == "bat") {
      var_2 _id_0367::_id_8E3D("hc_bat_reveal");
      _id_0378::_id_8D74("smugglers_bat_pickup", var_0.origin);
    }

    flag_try_set(get_special_melee_weapon_flag_name(var_1));
  }
}

try_give_exp_to_players_for_weap(var_0) {
  if(!isDefined(level.expweapongiven))
    level.expweapongiven = [];

  if(!isDefined(level.expweapongiven[var_0]))
    level.expweapongiven[var_0] = 0;

  if(!level.expweapongiven[var_0]) {
    level.expweapongiven[var_0] = 1;

    switch (var_0) {
      case "bat":
        _id_054D::giveplayersexp("berlin_exp_ref_2");
        break;
      case "pickaxe":
        _id_054D::giveplayersexp("berlin_exp_ref_11");
        break;
      case "wunderbuss_zm":
        _id_054D::giveplayersexp("berlin_exp_ref_20");
        break;
      case "dagger":
        _id_054D::giveplayersexp("berlin_exp_ref_14");
        break;
      case "sword":
        maps\mp\zquests\dlc2_trophies_mp_zombie_berlin::complete_berlin_trophy_event_6();
        _id_054D::giveplayersexp("berlin_exp_ref_4");
        break;
    }
  }
}

special_melee_get_weapon_name(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "bat":
        var_1 = "zom_dlc2_1hc_zm";
        break;
      case "pickaxe":
        var_1 = "zom_dlc2_3hc_zm";
        break;
      case "dagger":
        var_1 = "zom_dlc2_2hc_zm";
        break;
      case "sword":
        var_1 = "zom_dlc2_4_zm";
        break;
      case "bat_casual":
        var_1 = "zom_dlc2_1_zm";
        break;
      case "pickaxe_casual":
        var_1 = "zom_dlc2_3_zm";
        break;
      case "dagger_casual":
        var_1 = "zom_dlc2_2_zm";
        break;
      case "shovel_casual":
        var_1 = "shovel_zm";
        break;
    }
  }

  return var_1;
}

lockin_system_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::_id_A70A("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

lockin_system_monitor_unuse(var_0, var_1, var_2) {
  self endon("stop_using_station");
  waitframe();

  if(isDefined(var_1) && var_1)
    thread lockin_system_monitor_b_button();

  if(common_scripts\utility::_id_562E(var_2))
    thread lockin_system_monitor_use_button_exit();

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(self == var_3) {
      break;
    }
  }

  self notify("stop_using_station");
}

lockin_system_monitor_b_button() {
  self endon("stop_using_station");

  for(;;) {
    if(self _meth_84F1()) {
      break;
    }

    waitframe();
  }

  self setstance("stand");
  self notify("stop_using_station");
}

lockin_system_monitor_use_button_exit() {
  self endon("stop_using_station");

  while(self usebuttonpressed())
    waitframe();

  for(;;) {
    if(self usebuttonpressed()) {
      break;
    }

    waitframe();
  }

  self notify("stop_using_station");
}

zombies_players_secret_room_handle_ignore(var_0) {
  if(!isPlayer(var_0))
    return 0;

  var_1 = agents_are_separated(var_0, self);
  return var_1;
}

agents_are_separated(var_0, var_1) {
  return var_1 agent_is_in_secret_room(1) != agent_is_in_secret_room();
}

agent_is_in_secret_room(var_0) {
  var_1 = undefined;

  if(common_scripts\utility::_id_562E(var_0) && !common_scripts\utility::_id_562E(self.wasteleported))
    var_1 = _id_0547::_id_5565(self._id_9024, level.current_secret_room_zone);

  return common_scripts\utility::_id_562E(var_1) || _id_055A::_id_AC29(self, level.current_secret_room_zone);
}

set_default_spawn_room(var_0, var_1, var_2) {
  level.temp_spawn_locations = var_1;
  level.temp_spawn_location_players = var_0;

  foreach(var_4 in var_0)
  var_4 thread set_default_room_for_player(var_2);
}

set_default_room_for_player(var_0) {}

onberlinstartgame() {
  initberlinwavestories();
  level._id_7F22["normal"] = ::berlinroundstart;
  level._id_7F22["zombie_dog"] = ::berlinroundstart;
  level._id_7F18["normal"] = ::berlinroundend;
  _id_0547::remove_wallbuys_from_box();
}

initberlinwavestories() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_pods_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_pods_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_pods_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_pods_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_airships_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_airships_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_airships_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_airships_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_war_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_war_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_war_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_war_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_sizzler_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_sizzler_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_sizzler_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_sizzler_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_ww_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_ww_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_ww_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_ww_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
  var_0 = [];
  var_0[var_0.size] = ["zmb_berl_mari_wavebreak_airship_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_oliv_wavebreak_airship_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_dros_wavebreak_airship_lo", 1.0];
  var_0[var_0.size] = ["zmb_berl_jeff_wavebreak_airship_lo", 1.0];
  maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_0, 1);
}

wunderbuss_ammo_tracker() {
  self endon("death");
  self endon("wunderbuss_stop_tracking");

  for(;;) {
    common_scripts\utility::_id_A70C(self, "weapon_fired", level, "maxAmmoPickup", self, "heavyMeleeClip_earned");

    if(self hasweapon("wunderbuss_zm"))
      self.wunderbuss_prev_ammo = self getweaponammoclip("wunderbuss_zm");
  }
}

wunderbuss_drop_watcher() {
  var_0 = self;

  for(;;) {
    var_1 = common_scripts\utility::waittill_any_return("bleedout", "weapon_change", "becameSpectator", "disconnect", "death");

    if(var_1 == "weapon_change") {
      if(_id_0547::_id_577E(self))
        continue;
      else if(!_id_0547::_id_73F9(self, "wunderbuss_zm")) {
        self notify("wunderbuss_stop_tracking");
        return;
      }
    } else if(var_1 == "bleedout" || var_1 == "becameSpectator" || var_1 == "disconnect") {
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
  level.radio_codes["ober_havel"]["Model"]["2"] = 55.0;
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
  level.radio_codes["elbe_elster"]["Model"]["3"] = 93.0;
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
  level.radio_codes["prignitz"]["series"]["LS"] = 50.0;
  level.radio_codes["prignitz"]["series"]["ZX"] = 87.2;
  level.radio_codes["prignitz"]["Model"] = [];
  level.radio_codes["prignitz"]["Model"]["0"] = 25.1;
  level.radio_codes["prignitz"]["Model"]["1"] = 29.5;
  level.radio_codes["prignitz"]["Model"]["2"] = 54.2;
  level.radio_codes["prignitz"]["Model"]["3"] = 99.0;
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
  level.radio_codes["teltow_flaming"]["series"]["ZX"] = 84.0;
  level.radio_codes["teltow_flaming"]["Model"] = [];
  level.radio_codes["teltow_flaming"]["Model"]["0"] = 21.6;
  level.radio_codes["teltow_flaming"]["Model"]["1"] = 30.2;
  level.radio_codes["teltow_flaming"]["Model"]["2"] = 57.0;
  level.radio_codes["teltow_flaming"]["Model"]["3"] = 60.0;
  level.radio_codes["markisch_oderland"] = [];
  level.radio_codes["markisch_oderland"]["series"] = [];
  level.radio_codes["markisch_oderland"]["series"]["RS"] = 5.2;
  level.radio_codes["markisch_oderland"]["series"]["TX"] = 11.2;
  level.radio_codes["markisch_oderland"]["series"]["LS"] = 52.2;
  level.radio_codes["markisch_oderland"]["series"]["ZX"] = 60.0;
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
  level.radio_codes["spree_neisse"]["Model"]["0"] = 10.0;
  level.radio_codes["spree_neisse"]["Model"]["1"] = 17.1;
  level.radio_codes["spree_neisse"]["Model"]["2"] = 30.2;
  level.radio_codes["spree_neisse"]["Model"]["3"] = 45.1;
  level.radio_codes["dahme_spreewald"] = [];
  level.radio_codes["dahme_spreewald"]["series"] = [];
  level.radio_codes["dahme_spreewald"]["series"]["RS"] = 2.5;
  level.radio_codes["dahme_spreewald"]["series"]["TX"] = 74.3;
  level.radio_codes["dahme_spreewald"]["series"]["LS"] = 80.2;
  level.radio_codes["dahme_spreewald"]["series"]["ZX"] = 87.0;
  level.radio_codes["dahme_spreewald"]["Model"] = [];
  level.radio_codes["dahme_spreewald"]["Model"]["0"] = 86.2;
  level.radio_codes["dahme_spreewald"]["Model"]["1"] = 90.0;
  level.radio_codes["dahme_spreewald"]["Model"]["2"] = 94.9;
  level.radio_codes["dahme_spreewald"]["Model"]["3"] = 98.1;
  var_0 = _getent("map_pushpin", "script_noteworthy");
  var_1 = _getent("map_pushpin_origin", "script_noteworthy");
  var_0 linktosynchronizedparent(var_1);
  var_2 = common_scripts\utility::_id_46B7("map_pinpoint", "script_noteworthy");
  var_3 = common_scripts\utility::random(var_2);
  var_1.origin = var_3.origin;
  level.radio_map_location = var_3.setlookatent;
  var_4 = 4;
  var_5 = _randomintrange(0, var_4);
  var_6 = _randomintrange(0, var_4);
  var_7 = "X";
  var_8 = "X";

  switch (var_5) {
    case 0:
      var_7 = "R";
      var_8 = "S";
      break;
    case 1:
      var_7 = "T";
      var_8 = "X";
      break;
    case 2:
      var_7 = "L";
      var_8 = "S";
      break;
    case 3:
      var_7 = "Z";
      var_8 = "X";
      break;
  }

  level.radio_map_series_num = var_7 + var_8;
  level.radio_map_model_num = common_scripts\utility::_id_9AAD(var_6);
  var_9 = common_scripts\utility::_id_46B5("radio_series_org_1", "targetname");
  var_10 = spawn("script_model", var_9.origin);
  var_10 setModel("zbr_rus_radio_01_letter_" + var_7);
  var_10.angles = var_9.angles;
  var_10._id_28BE = 500;
  var_11 = common_scripts\utility::_id_46B5("radio_series_org_2", "targetname");
  var_12 = spawn("script_model", var_11.origin);
  var_12 setModel("zbr_rus_radio_01_letter_" + var_8);
  var_12.angles = var_11.angles;
  var_12._id_28BE = 500;
  var_13 = common_scripts\utility::_id_46B5("radio_model_number_org", "targetname");
  var_14 = spawn("script_model", var_13.origin);
  var_14 setModel("zbr_rus_radio_01_num_0" + common_scripts\utility::_id_9AAD(var_6));
  var_14.angles = var_13.angles;
  var_14._id_28BE = 500;
  level.radio_code_left = level.radio_codes[level.radio_map_location]["series"][level.radio_map_series_num];
  level.radio_code_right = level.radio_codes[level.radio_map_location]["Model"][level.radio_map_model_num];
}

radio_system_init() {
  var_0 = _getent("radio_tuner_use_trig", "targetname");
  var_1 = (0, 0, 0);
  var_2 = (0, 0, 0);
  var_3 = _getent("radio_tuner_link_org", "targetname");
  var_4 = _getent("radio_tuner_player_org", "targetname");
  var_5 = undefined;

  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  thread radio_system_light_swap_handler();

  for(;;) {
    var_0 waittill("trigger", var_6);
    var_6 _id_0378::_id_8D74("player_using_radio");
    level notify("player_used_radio", var_6);

    if(var_6 isjumping() || var_6 _meth_82E5()) {
      continue;
    }
    var_5 = var_6;
    level.player_using_radio = var_6;
    var_5 disableweapons();
    var_7 = var_5 getstance();

    if(var_5 getstance() != "crouch") {
      var_5 setstance("crouch");

      if(var_7 == "stand")
        wait 0.4;
      else if(var_7 == "prone")
        wait 0.55;
      else
        wait 0.55;
    }

    var_5 _meth_812C(0);
    var_1 = var_6.origin;
    var_2 = var_6.angles;
    var_4.origin = var_5.origin;
    var_4.angles = var_5.angles;
    var_5 playerlinkto(var_4, undefined, 0.1, 0, 0, 0, 0);
    var_4 moveto(var_3.origin, 0.5, 0, 0);
    var_4 rotateto(var_3.angles, 0.5, 0, 0);
    wait 0.5;
    var_5 thread radio_system_start_tuning();
    var_5 waittill("stop_using_station");
    var_5 enableweapons();
    var_4 moveto(var_1 + (0, 0, 1), 0.5);
    var_4 rotateto(var_2, 0.5);
    wait 0.5;
    var_5 unlink();
    var_5 _meth_812C(1);
    var_5 setstance("stand");
    wait 0.5;
    level.player_using_radio = undefined;
  }
}

radio_system_light_swap_handler() {
  level endon("game_over");
  var_0 = _getscriptablearray("radio_light", "targetname")[0];
  var_0 setscriptablepartstate("0", "0");

  while(!isDefined(level.possible_radio_codes) || !isDefined(level.possible_radio_codes[0]["left"]) || !isDefined(level.possible_radio_codes[0]["right"]))
    waitframe();

  var_1 = 2;

  for(;;) {
    foreach(var_3 in level.possible_radio_codes) {
      var_4 = var_3["left"];
      var_5 = level.tuner_values["radio_tuner"]["left"];
      var_6 = _abs(var_5 - var_4);
      var_7 = var_3["right"];
      var_8 = level.tuner_values["radio_tuner"]["right"];
      var_9 = _abs(var_8 - var_7);

      if(var_6 <= var_1 && var_9 <= var_1) {
        var_0 setscriptablepartstate("0", "1");

        while(var_6 <= var_1 && var_9 <= var_1) {
          waitframe();
          var_5 = level.tuner_values["radio_tuner"]["left"];
          var_6 = _abs(var_5 - var_4);
          var_8 = level.tuner_values["radio_tuner"]["right"];
          var_9 = _abs(var_8 - var_7);
        }

        var_0 setscriptablepartstate("0", "0");
        waitframe();
        continue;
      }
    }

    wait 0.25;
  }
}

radio_system_start_tuning() {
  thread lockin_system_monitor_death();
  thread radio_system_show_controls_hint();
  var_0 = undefined;
  var_1 = undefined;

  if(common_scripts\utility::_id_55E0()) {
    thread _id_0547::monitor_stick_input();
    self.radioinputleftprevious = 0;
    self.radioinputrightprevious = 0;
    var_0 = ::radio_left_tuner_input_gamepad;
    var_1 = ::radio_right_tuner_input_gamepad;
  } else {
    thread lockin_system_monitor_unuse(undefined, 0, 1);
    var_0 = ::radio_left_tuner_input_pc;
    var_1 = ::radio_right_tuner_input_pc;
  }

  var_2 = _getent("radio_tuner_left", "targetname");
  var_3 = _getent("radio_tuner_left_knob", "targetname");
  var_3 linktosynchronizedparent(var_2);
  var_4 = _getent("radio_tuner_left_needle", "targetname");
  thread radio_system_handle_tuner(var_2, "left", 1, level.tuner_values["radio_tuner"]["left"], "radio_tuner", var_0, var_4);
  var_5 = _getent("radio_tuner_right", "targetname");
  var_6 = _getent("radio_tuner_right_knob", "targetname");
  var_6 linktosynchronizedparent(var_5);
  var_7 = _getent("radio_tuner_right_needle", "targetname");
  thread radio_system_handle_tuner(var_5, "right", 1, level.tuner_values["radio_tuner"]["right"], "radio_tuner", var_1, var_7);
}

radio_system_show_controls_hint() {
  if(common_scripts\utility::_id_55E0()) {
    self forceusehinton(&"ZOMBIE_BERLIN_RADIO_USE_HINT");
    radio_system_show_controls_hint_breakout();
    self forceusehintoff(&"ZOMBIE_BERLIN_RADIO_USE_HINT");
  } else {
    self forceusehinton(&"ZOMBIE_BERLIN_RADIO_USE_HINT_PC");
    radio_system_show_controls_hint_breakout();
    self forceusehintoff(&"ZOMBIE_BERLIN_RADIO_USE_HINT_PC");
  }
}

radio_system_show_controls_hint_breakout() {
  common_scripts\utility::_id_A71A(5, "stop_using_station");
}

radio_system_get_turn_difference(var_0, var_1) {
  var_2 = var_0 - var_1;
  var_2 = _angleclamp180(var_2);
  return var_2;
}

radio_left_tuner_input_gamepad() {
  var_0 = _id_0547::get_left_stick_input();
  var_1 = radio_system_get_turn_difference(self.radioinputleftprevious, var_0);
  self.radioinputleftprevious = var_0;
  return var_1;
}

radio_right_tuner_input_gamepad() {
  var_0 = _id_0547::get_right_stick_input();
  var_1 = radio_system_get_turn_difference(self.radioinputrightprevious, var_0);
  self.radioinputrightprevious = var_0;
  return var_1;
}

pc_tuner_speed() {
  var_0 = 12.5;

  if(self sprintbuttonpressed())
    var_0 = var_0 * 10.0;

  return var_0;
}

radio_left_tuner_input_pc() {
  var_0 = self getnormalizedmovement();
  var_1 = var_0[1];

  if(var_1 == 0)
    return 0;

  var_2 = pc_tuner_speed() * var_1;
  return var_2;
}

radio_right_tuner_input_pc() {
  var_0 = 0.0;

  if(self adsbuttonpressed(1))
    var_0 = 1.0;
  else if(self attackbuttonpressed())
    var_0 = -1.0;

  if(var_0 == 0.0)
    return 0;

  var_0 = var_0 * pc_tuner_speed();
  return var_0;
}

radio_system_handle_tuner(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_using_station");
  var_7 = 0;

  if(var_1 == "left")
    var_7 = 1;

  level.should_suspend_tuning = 0;
  var_8 = var_3;
  var_9 = 0;
  var_10 = 2;
  var_11 = 0;
  var_12 = 1;
  _id_0378::_id_8D74("radio_stop_using_watcher");
  var_13 = undefined;

  if(isDefined(var_6)) {
    var_13 = _getent(var_6.target, "targetname");
    var_6 linktosynchronizedparent(var_13);
  }

  for(;;) {
    if(!level.should_suspend_tuning) {
      if(_abs(var_9) > 0.1) {
        var_11 = 0;
        var_14 = var_9 < 0;
        var_15 = 0;

        if(var_12) {
          _id_0378::_id_8D74("aud_radio_tuning", "tuning");
          var_12 = 0;
        }

        if(common_scripts\utility::_id_562E(var_14)) {
          var_15 = _angleclamp(var_0.angles[2] + 5);
          var_8 = var_8 + 0.9 * (var_9 / 100);
        } else {
          var_15 = _angleclamp(var_0.angles[2] - 5);
          var_8 = var_8 + 0.9 * (var_9 / 100);
        }

        var_0.angles = (var_0.angles[0], var_0.angles[1], var_15);
      } else
        var_11++;

      if(var_11 > var_10 && !var_12) {
        _id_0378::_id_8D74("aud_radio_tuning", "idle");
        var_12 = 1;
      }

      var_9 = self[[var_5]]();

      if(var_9 != 0 && var_7) {
        var_9 = 0;
        var_7 = 0;
        self notify("player_is_tuning");
      }

      if(common_scripts\utility::_id_562E(var_2)) {
        var_16 = int(var_8);

        if(var_16 > 99) {
          var_8 = 99;
          var_16 = 99;
        } else if(var_16 < 1) {
          var_8 = 1;
          var_16 = 1;
        }

        if(isDefined(var_13))
          var_13 thread radio_system_update_tuner_needle(var_16, var_1);

        level.tuner_values[var_4][var_1] = var_16;

        if(var_16 < 10)
          var_16 = "0" + var_16;
      }
    }

    waitframe();
  }
}

radio_system_suspend_tuning_for_time(var_0) {
  level.should_suspend_tuning = 1;
  wait(var_0);
  level.should_suspend_tuning = 0;
}

radio_system_suspend_tuning_for_response() {
  level.should_suspend_tuning = 1;
  level waittill("radio_response_done");
  level.should_suspend_tuning = 0;
}

radio_system_update_tuner_needle(var_0, var_1) {
  var_2 = 0;

  if(!isDefined(var_1) || var_1 == "left") {
    var_3 = 108;
    var_2 = 43.5;
  } else {
    var_3 = 203;
    var_2 = 1;
  }

  var_4 = var_0 - 50;
  var_5 = var_4 / 100;
  var_6 = var_3 * var_5 + var_2;
  self.angles = (self.angles[0], self.angles[1], -1 * var_6);
}

____________________airships____________________() {}

airship_straub_summon() {
  common_scripts\utility::flag_set("flag_airship_summoned");
}

airship_objects_show(var_0) {
  self show();
  self solid();

  if(isDefined(var_0) && var_0)
    self disconnectpaths();
}

airship_objects_hide(var_0) {
  self hide();
  self notsolid();

  if(isDefined(var_0) && var_0)
    self connectpaths();
}

airship_interior_state_swap() {
  hack_station_init();

  if(!level.airship_active) {
    level.airship_active = 1;

    foreach(var_1 in level.airship)
    var_1 airship_objects_show();

    level notify("show_hack_stations");
    level thread power_source_effects();
  } else {
    level.airship_active = 0;

    foreach(var_1 in level.airship)
    var_1 airship_objects_hide();

    level notify("hide_hack_stations");
  }
}

airship_pods_animation() {
  var_0 = getEntArray("zeppelin_drop_pods", "targetname");
  _id_0378::_id_8D74("aud_start_drop_pod_sway");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_1")
      var_2 scriptmodelplayanim("zep_int_pod_calm");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_2")
      var_2 scriptmodelplayanim("zep_int_pod_calm1");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_3")
      var_2 scriptmodelplayanim("zep_int_pod_calm2");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_shake")
      var_2 scriptmodelplayanim("zep_int_pod_calm1_2");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_shake1")
      var_2 scriptmodelplayanim("zep_int_pod_calm_2");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_open")
      var_2 scriptmodelplayanim("zep_int_pod_calm_open");
  }

  level waittill("escape_airship_start");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_1")
      var_2 scriptmodelplayanim("zep_int_pod_crazy");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_2")
      var_2 scriptmodelplayanim("zep_int_pod_crazy1");

    if(isDefined(var_2._id_0165) && var_2._id_0165 == "variant_3")
      var_2 scriptmodelplayanim("zep_int_pod_crazy2");
  }
}

airship_puzzle_doors_disable_buy() {
  wait 10;

  foreach(var_1 in level._id_AC1D) {
    foreach(var_3 in var_1._id_9DC2) {
      if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable")
        var_3 common_scripts\utility::_id_9D9F();
    }
  }
}

airship_route_blockers_state_swap() {
  if(!level.airship_doors_open) {
    level.airship_doors_open = 1;

    foreach(var_1 in level.airship_route_blockers)
    var_1 airship_objects_hide(1);
  } else {
    level.airship_doors_open = 0;

    foreach(var_1 in level.airship_route_blockers)
    var_1 airship_objects_show(1);
  }
}

airship_camera_sway() {
  level endon("airship_escape");

  for(;;) {
    var_0 = _randomfloatrange(0.25, 1);
    var_1 = _randomfloatrange(3, 4);
    level._id_953D rotateto((var_0, var_0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
    level._id_953D rotateto((0 - var_0, 0 - var_0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
  }
}

airship_camera_sway_extreme() {
  level endon("berlin_cinematic_done");

  for(;;) {
    var_0 = _randomfloatrange(1, 2);
    var_1 = _randomfloatrange(4, 6);
    level._id_953D rotateto((var_0, var_0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
    level._id_953D rotateto((0 - var_0, 0 - var_0, 0), var_1, var_1 * 0.5, var_1 * 0.5);
    wait(var_1);
  }
}

airship_lowering_handler() {
  level endon("flag_airship_fully_lowered");
  var_0 = _getvehiclenode("end_node_airship_straub_lowered", "targetname");
  level.airship_lower_percentage = 0;

  while(level.airship_lower_percentage < 100)
    waitframe();

  wait 0.5;
  common_scripts\utility::flag_set("flag_airship_fully_lowered");
}

airship_lowering_handler_fully_lower() {
  level.airship_lower_percentage = 100;
}

___sizzler_cannon___() {}

airship_turret_build(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _spawnturret("misc_turret", self.origin, var_0);
  var_6.angles = self.angles;
  var_6 setModel(var_1);
  var_6 setdefaultdroppitch(0.0);
  var_6 setmode("auto_nonai");
  var_6 setsentryowner(undefined);
  var_6 setturretminimapvisible(0);
  var_6 maketurretsolid();
  var_6 makeunusable();
  var_6 setturretteam("allies");
  var_6 setentityowner(var_6);
  var_6 set_tool_hudelem(1);

  if(isDefined(var_2))
    var_6._id_62AD = var_2;

  if(isDefined(var_3))
    var_6._id_6B73 = var_3;

  if(isDefined(var_4))
    var_6.modifyagentdamage = var_4;

  if(isDefined(var_5))
    var_6.onagentdamage = var_5;

  return var_6;
}

airship_turret_modify_player_damage(var_0) {
  return 0;
}

airship_turret_on_player_damage(var_0) {}

airship_turret_modify_agent_damage(var_0) {
  return 0;
}

airship_turret_on_agent_damage(var_0) {
  var_1 = self;
}

airship_turret_think() {
  level endon("entered_airship_sizzler_pause");
  level.airship_valid_zones = ["zone_underbelly_start", "zone_underbelly_rubble", "zone_underbelly_intact", "zone_street", "zone_museum_hall", "zone_club_interior", "zone_church_garden", "zone_church_interior", "zone_airship", "zone_airship_middle_front", "zone_airship_left", "zone_airship_right", "zone_finale"];
  level.airship_zone_volumes = [];
  var_0 = [40, 35, 30, 25];

  for(var_1 = 0; var_1 < level.airship_valid_zones.size; var_1++) {
    var_2 = getEntArray(level.airship_valid_zones[var_1], "targetname");
    level.airship_zone_volumes = common_scripts\utility::_id_0F73(level.airship_zone_volumes, var_2);
  }

  common_scripts\utility::_id_3C9F("flag_airship_summoned");
  level thread airship_turret_disable_listener();

  for(;;) {
    wait(var_0[level.players.size - 1]);

    while(_id_0547::_id_585E())
      waitframe();

    if(!airship_turret_is_safe_to_shoot()) {
      continue;
    }
    var_3 = undefined;

    while(!isDefined(var_3) || !isalive(var_3)) {
      if(!isDefined(level.straub_airship.valid_targets) || level.straub_airship.valid_targets.size <= 0) {
        wait 5;
        continue;
      }

      foreach(var_5 in level.straub_airship.valid_targets) {
        if(!_isagent(var_5) || !isalive(var_5) || var_5 _meth_85A5() != "zombie_animclass" || common_scripts\utility::_id_562E(var_5.transformingtosizzler))
          level.straub_airship.valid_targets = common_scripts\utility::_id_0F93(level.straub_airship.valid_targets, var_5);
      }

      var_7 = [];

      foreach(var_9 in level.players) {
        if(isalive(var_9) && !_id_0547::_id_577E(var_9))
          var_7[var_7.size] = var_9;
      }

      if(var_7.size > 0) {
        var_11 = common_scripts\utility::random(level.players);
        var_3 = common_scripts\utility::_id_4461(var_11.origin, level.straub_airship.valid_targets);
      } else
        var_3 = common_scripts\utility::_id_4461(self.origin, level.straub_airship.valid_targets);

      if(!isDefined(var_3)) {
        wait 5;
        continue;
      }

      var_12 = 0;

      for(var_1 = 0; var_1 < level.airship_zone_volumes.size; var_1++) {
        if(var_3 istouching(level.airship_zone_volumes[var_1]))
          var_12 = 1;
      }

      if(!var_12)
        var_3 = undefined;

      wait 0.25;
    }

    if(isalive(var_3))
      airship_turret_shoot_target(var_3);
  }
}

airship_turret_is_safe_to_shoot() {
  if(!common_scripts\utility::_id_562E(level.straub_airship.canmakesizzlers))
    return 0;

  if(!maps\mp\zombies\zombie_sizzler::zombie_sizzler_slot_available())
    return 0;

  if(!isDefined(level.straub_airship.valid_targets) || level.straub_airship.valid_targets.size <= 0)
    return 0;

  return 1;
}

airship_turret_disable_listener() {
  level waittill("entered_airship_sizzler_pause");
  airship_turret_clear_target();
}

airship_turret_shoot_target(var_0) {
  var_1 = level.straub_airship.siz_cannon gettagorigin("TAG_PITCH");
  var_2 = spawn("script_model", var_1);
  var_2 setModel("Tag_Origin");
  var_2 linktosynchronizedparent(level.straub_airship.siz_cannon);
  var_3 = level.straub_airship.siz_cannon gettagorigin("TAG_AIM");
  var_4 = level.straub_airship.siz_cannon gettagangles("TAG_AIM");
  var_5 = anglesToForward(var_4);
  var_6 = vectorNormalize(var_0.origin - var_3);
  var_7 = vectordot(var_5, var_6);
  level._id_8C4C = level.straub_airship.siz_cannon gettagorigin("TAG_AIM");
  level._id_8C46 = var_0.origin;
  var_8 = common_scripts\utility::_id_8FFC();
  var_8.origin = var_0.origin + (0, 0, -12);
  airship_turret_set_target(var_8);
  _playfxontag(common_scripts\utility::_id_44F5("zmb_zeppelin_shot_charge_barrel"), level.straub_airship.siz_cannon, "TAG_AIM");
  wait 0.65;
  airship_turret_start_firing();
  var_9 = _func_382("zmb_geistkraft_reg_beam_med", level.straub_airship.siz_cannon, "tag_flash", var_0, "tag_origin");
  var_10 = -1 * var_6;

  if(isalive(var_0))
    var_0 thread maps\mp\zombies\zombie_sizzler::zombie_make_sizzler(var_10, 1);

  airship_turret_stop_firing();
  playFX(level._effect["zmb_ber_zep_lightning_bolt"], var_8.origin, var_2.origin - var_8.origin);
  airship_turret_clear_target();
  var_2 delete();
  wait 0.15;
  var_9 delete();
  var_8 delete();
}

airship_turret_set_target(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level.straub_airship.siz_cannon settargetentity(var_0, (0, 0, 0), 1);
}

airship_turret_get_target() {
  return level.straub_airship.siz_cannon _meth_80FC();
}

airship_turret_clear_target() {
  level.straub_airship.siz_cannon cleartargetentity();
}

airship_turret_is_zombie_targeted(var_0) {
  var_1 = airship_turret_get_target();
  return isDefined(var_1) && var_1 == var_0;
}

airship_turret_start_firing() {
  if(randomint(3) == 0)
    thread maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("straub_sizzler_intro_alt", "exterior", 0, level.straub_airship);

  level.straub_airship.siz_cannon startfiring();
  level.straub_airship.siz_cannon _id_0378::_id_8D74("blimp_projectile");
}

airship_turret_stop_firing() {
  level.straub_airship.siz_cannon stopfiring();
}

airship_turret_is_firing() {
  level.straub_airship.siz_cannon isfiringturret();
}

airship_turret_update_valid_targets() {
  level endon("entered_airship_sizzler_pause");
  var_0 = maps\mp\zombies\zombie_sizzler::noofsizzlerscanspawn();

  if(var_0 <= 0) {
    return;
  }
  var_1 = _id_0547::_id_4090("zombie_generic");
  level.straub_airship.valid_targets = [];

  foreach(var_3 in var_1) {
    var_4 = var_3 _meth_85A5();

    if(var_4 == "zombie_animclass" || !common_scripts\utility::_id_562E(var_3.transformingtosizzler)) {
      if(airship_turret_is_valid_target(var_3))
        level.straub_airship.valid_targets[level.straub_airship.valid_targets.size] = var_3;
    }
  }
}

airship_turret_is_valid_target(var_0) {
  if(var_0._id_0BA4 == "traverse")
    return 0;

  if(common_scripts\utility::_id_562E(var_0._id_0103))
    return 0;

  if(!var_0 _id_0547::_id_4B2C())
    return 0;

  return 1;
}

___airship_animation___() {}

#using_animtree("animated_props_zombies_DLC2");

airship_distant_handler(var_0) {
  wait(var_0);

  while(!common_scripts\utility::_id_3C77("flag_drop_pod_reached_airship")) {
    wait 5;
    self scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_extra_zep", self.origin, self.angles);
    wait(_getanimlength(%s2_zom_zep_extra_zep));
    wait(_randomfloatrange(0, 3));
  }

  self delete();
}

airship_animation_master_handler() {
  var_0 = _getent("zeppelin_animation_node", "targetname");
  thread airship_animation_straub_entrance(var_0);
  common_scripts\utility::_id_3C9F("flag_airship_summoned");
  thread airship_animation_enter_and_shoot_tethers(var_0);
  thread airship_animation_pull_down_airship(var_0);
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_bring_down_airship", "step_enter_dropcage"));
  thread airship_animation_drop_pod_movement(var_0);
  common_scripts\utility::_id_3C9F("flag_drop_pod_reached_airship");
  thread airship_animation_airship_drop_pod_open();
  thread airship_animation_airship_drop_pod_move_down(var_0);
}

airship_animation_straub_entrance(var_0) {
  common_scripts\utility::_id_3C9F("flag_exit_underbelly");
  level.straub_airship show();
  level.straub_airship scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_intro", var_0.origin, var_0.angles);
  level.straub_airship playzeppelinfx();

  foreach(var_2 in level.players)
  var_2 thread airship_animation_straub_entrance_play_rumbles();

  level.straub_airship _id_0378::_id_8D74("start_straub_airship_loop");
  level.straub_airship _id_0378::_id_8D74("straub_airship_entrance");
  wait(_getanimlength(%s2_zom_zep_intro));
  common_scripts\utility::flag_set("flag_airship_reached_middle");
  level.straub_airship _id_0378::_id_8D74("stop_airship_loop", 10.0);
}

airship_animation_straub_entrance_play_rumbles() {
  self endon("disconnect");
  wait 7.5;
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 0.1, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("damage_light", 0.1, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("damage_heavy", 0.3, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 3, 0.1);
  airship_animation_straub_entrance_play_rumble_for_time("viewmodel_small", 7, 0.15);
}

airship_animation_straub_entrance_play_rumble_for_time(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0.15;

  while(var_1 > 0) {
    self playrumbleonentity(var_0);
    wait(var_2);
    var_1 = var_1 - var_2;
  }
}

playzeppelinfx() {
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_L_01");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_L_02");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_R_01");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zeppelin_spotlight"), self, "TAG_FX_R_02");
  waitframe();
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zep_prop_spin"), self, "prop_left");
  _playfxontag(common_scripts\utility::_id_44F5("zmb_ber_zep_prop_spin"), self, "prop_right");
}

airship_animation_enter_and_shoot_tethers(var_0) {
  var_1 = getEntArray("airship_anchor_model", "script_noteworthy");
  var_2 = _getent("drop_pod_cable", "script_noteworthy");
  var_3 = _getent("drop_pod_model", "script_noteworthy");
  level.anchor_courtyard = undefined;
  level.anchor_museum = undefined;
  level.anchor_refuge = undefined;
  level.anchor_underbelly = undefined;

  if(!isDefined(level.straub_airship_model))
    level.straub_airship_model = _getent("straub_airship_exterior_model", "script_noteworthy");

  level.straub_airship _id_0378::_id_8D74("start_straub_airship_loop");
  level.straub_airship _id_0378::_id_8D74("straub_airship_entrance");
  level.cable_courtyard = spawn("script_model", level.straub_airship.origin);
  level.cable_courtyard setModel("zbr_zeppelin_tether_cable_01");
  level.cable_museum = spawn("script_model", level.straub_airship_model.origin);
  level.cable_museum setModel("zbr_zeppelin_tether_cable_01");
  level.cable_refuge = spawn("script_model", level.straub_airship_model.origin);
  level.cable_refuge setModel("zbr_zeppelin_tether_cable_01");
  level.cable_underbelly = spawn("script_model", level.straub_airship_model.origin);
  level.cable_underbelly setModel("zbr_zeppelin_tether_cable_01");

  foreach(var_5 in var_1) {
    switch (var_5.setlookatent) {
      case "airship_tether_courtyard":
        level.anchor_courtyard = var_5;
        break;
      case "airship_tether_museum":
        level.anchor_museum = var_5;
        break;
      case "airship_tether_refuge":
        level.anchor_refuge = var_5;
        break;
      case "airship_tether_underbelly":
        level.anchor_underbelly = var_5;
        break;
      default:
        break;
    }
  }

  wait 1;
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_into", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_into", var_0.origin, var_0.angles);
  var_3 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_into", var_0.origin, var_0.angles);
  var_7 = _getanimlength(%s2_zom_zep_tether_scene_zep_into);
  level.straub_airship_model common_scripts\utility::_id_2CBE(var_7, ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_zep_into_idle", var_0.origin, var_0.angles);
  var_2 common_scripts\utility::_id_2CBE(var_7, ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_zep_drop_pod_cable_into_idle", var_0.origin, var_0.angles);
  level.anchor_courtyard solid();
  level.anchor_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_into", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_into", var_0.origin, var_0.angles);
  level.cable_courtyard common_scripts\utility::_id_2CBE(_getanimlength(%s2_zom_zep_tether_scene_tether_bolt_br_cable_into), ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_tether_bolt_br_cable_into_idle", var_0.origin, var_0.angles);
  level.anchor_courtyard thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_br_into, 0.9799, 0.5);
  level.anchor_museum solid();
  level.anchor_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_into", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_into", var_0.origin, var_0.angles);
  level.cable_museum common_scripts\utility::_id_2CBE(_getanimlength(%s2_zom_zep_tether_scene_tether_bolt_fr_cable_into), ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_tether_bolt_fr_cable_into_idle", var_0.origin, var_0.angles);
  level.anchor_museum thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_fr_into, 0.9833, 0.3);
  level.anchor_refuge solid();
  level.anchor_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_into", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_into", var_0.origin, var_0.angles);
  level.cable_refuge common_scripts\utility::_id_2CBE(_getanimlength(%s2_zom_zep_tether_scene_tether_bolt_bl_cable_into), ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_tether_bolt_bl_cable_into_idle", var_0.origin, var_0.angles);
  level.anchor_refuge thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_bl_into, 0.9813, 0.9);
  level.anchor_underbelly solid();
  level.anchor_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_into", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_into", var_0.origin, var_0.angles);
  level.cable_underbelly common_scripts\utility::_id_2CBE(_getanimlength(%s2_zom_zep_tether_scene_tether_bolt_fl_cable_into), ::scriptmodelplayanimdeltamotionfrompos, "s2_zom_zep_tether_scene_tether_bolt_fl_cable_into_idle", var_0.origin, var_0.angles);
  level.anchor_underbelly thread play_tether_impact_shake(%s2_zom_zep_tether_scene_tether_bolt_fl_into, 0.9826, 0.15);
  wait 3;
  common_scripts\utility::flag_set("airship_tethers_out");
}

play_tether_impact_shake(var_0, var_1, var_2) {
  var_3 = 0.75;
  var_4 = _getanimlength(var_0) * var_1;
  maps\mp\_utility::_id_2CED(var_4 - var_2, ::earthquake_alive_players_with_origin, 1, 1, 1000, self);
  wait(var_4 - var_3);
  _id_0378::_id_8D74("tether_ground_impact");
  wait(var_3);

  if(self == level.anchor_courtyard) {
    level notify("airship_anchor_courtyard_impact");
    var_5 = _getent("anchor_a_clip", "targetname");
    var_5.origin = var_5.origin + (0, 0, 512);
    var_5 disconnectpaths();
    var_6 = _id_0547::_id_408F();

    if(isDefined(var_6) && var_6.size > 0) {
      foreach(var_8 in var_6) {
        if(var_8 istouching(var_5))
          var_8 dodamage(999999, var_8.origin);
      }
    }
  }
}

airship_animation_pull_down_airship(var_0) {
  var_1 = _getent("drop_pod_cable", "script_noteworthy");
  var_2 = _getent("drop_pod_model", "script_noteworthy");

  if(!isDefined(level.airship_anchor_flag_array))
    level.airship_anchor_flag_array = ["flag_airship_anchor_a_reeled", "flag_airship_anchor_b_reeled", "flag_airship_anchor_c_reeled", "flag_airship_anchor_d_reeled"];

  var_3 = level.airship_anchor_flag_array;
  var_4 = common_scripts\utility::_id_3CA3(var_3);

  foreach(var_6 in level.players)
  var_6 thread airship_drop_pod_push_players();

  var_3 = common_scripts\utility::_id_0F93(var_3, var_4);
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down", var_0.origin, var_0.angles);
  level.anchor_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_down", var_0.origin, var_0.angles);
  level.anchor_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_down", var_0.origin, var_0.angles);
  level.anchor_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_down", var_0.origin, var_0.angles);
  level.anchor_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_down", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down", var_0.origin, var_0.angles);
  var_8 = "25percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_8);
  var_9 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_down);
  wait(var_9);
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_idle", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_idle", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_idle", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_idle", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_idle", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_idle", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_idle", var_0.origin, var_0.angles);
  var_10 = common_scripts\utility::_id_3CA3(var_3);
  var_3 = common_scripts\utility::_id_0F93(var_3, var_10);
  level.straub_airship scriptmodelclearanim();
  var_2 scriptmodelclearanim();
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_02", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_02", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_02", var_0.origin, var_0.angles);
  level.anchor_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_down", var_0.origin, var_0.angles);
  level.anchor_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_down", var_0.origin, var_0.angles);
  level.anchor_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_down", var_0.origin, var_0.angles);
  level.anchor_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_down", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_02", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_02", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_02", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_02", var_0.origin, var_0.angles);
  var_8 = "50percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_8);
  var_11 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_02);
  wait(var_11);
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_02_idle", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_02_idle", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_02_idle", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_02_idle", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_02_idle", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_02_idle", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_02_idle", var_0.origin, var_0.angles);
  var_12 = common_scripts\utility::_id_3CA3(var_3);
  var_3 = common_scripts\utility::_id_0F93(var_3, var_12);
  level.straub_airship scriptmodelclearanim();
  var_2 scriptmodelclearanim();
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_03", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_03", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_03", var_0.origin, var_0.angles);
  level.anchor_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_down", var_0.origin, var_0.angles);
  level.anchor_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_down", var_0.origin, var_0.angles);
  level.anchor_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_down", var_0.origin, var_0.angles);
  level.anchor_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_down", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_03", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_03", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_03", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_03", var_0.origin, var_0.angles);
  var_8 = "75percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_8);
  var_13 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_03);
  wait(var_13);
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_03_idle", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_03_idle", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_03_idle", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_03_idle", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_03_idle", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_03_idle", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_03_idle", var_0.origin, var_0.angles);
  level.fourth_flag = var_3[0];
  common_scripts\utility::_id_3C9F(level.fourth_flag);
  level.straub_airship scriptmodelclearanim();
  var_2 scriptmodelclearanim();
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_04", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_04", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_04", var_0.origin, var_0.angles);
  level.anchor_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_down_04", var_0.origin, var_0.angles);
  level.anchor_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_down_04", var_0.origin, var_0.angles);
  level.anchor_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_down_04", var_0.origin, var_0.angles);
  level.anchor_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_down_04", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_04", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_04", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_04", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_04", var_0.origin, var_0.angles);
  var_8 = "100percent";
  thread maps\mp\mp_zombie_berlin_lighting::airship_lowering_light_intensity_control(var_8);
  var_14 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_down_04);
  wait(var_14);
  level.straub_airship_model scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_down_04_idle", var_0.origin, var_0.angles);
  level.cable_courtyard scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_br_cable_down_04_idle", var_0.origin, var_0.angles);
  level.cable_museum scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fr_cable_down_04_idle", var_0.origin, var_0.angles);
  level.cable_underbelly scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_fl_cable_down_04_idle", var_0.origin, var_0.angles);
  level.cable_refuge scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_tether_bolt_bl_cable_down_04_idle", var_0.origin, var_0.angles);
  var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_down_04_idle", var_0.origin, var_0.angles);
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_down_04_idle", var_0.origin, var_0.angles);
  var_15 = _getent("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_15 solid();
  var_15 disconnectpaths();
  var_16 = _getent("clip_door", "script_noteworthy");
  var_16 notsolid();
  var_16 connectpaths();
  var_2 scriptmodelclearanim();
  var_2 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
  var_2 = _getent("drop_pod_model", "script_noteworthy");
  _triggerfx(var_2.lightfx);
  var_17 = _getent("dropcage_push_trigger", "targetname");
  var_17 delete();
  var_18 = _getent("pod_underneath_clip", "targetname");
  var_18 solid();
  var_18 disconnectpaths();
}

airship_animation_drop_pod_movement(var_0) {
  level endon("drop_pod_reached_airship");
  var_1 = _getent("drop_pod_model", "script_noteworthy");
  var_2 = _getent("drop_pod_cable", "script_noteworthy");
  var_3 = _getent("clip_drop_pod_nav_blocker", "script_noteworthy");
  var_4 = _getent("clip_door", "script_noteworthy");
  var_5 = _getent("quest_trig_enter_dropcage", "targetname");
  var_6 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_pod_up);
  level.drop_pod_up_start_time = gettime();

  for(;;) {
    level waittill("drop_pod_moving_up");

    foreach(var_8 in level.players)
    var_8 thread pull_players_inside();

    var_1 scriptmodelclearanim();
    var_1 scriptmodelplayanim("s2_zmb_drop_pod_close_front", "drop_pod_door_close");
    var_1 scriptmodelclearanim();
    var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_up", var_0.origin, var_0.angles);
    var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_up", var_0.origin, var_0.angles);
    level.straub_airship scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_up", var_0.origin, var_0.angles);
    level.drop_pod_up_start_time = gettime();
    var_3 notsolid();
    var_3 connectpaths();
    var_10 = level common_scripts\utility::_id_A74D("drop_pod_moving_down", var_6);

    if(isDefined(var_10) && var_10 == "timeout")
      level notify("drop_pod_reached_airship");

    var_11 = (gettime() - level.drop_pod_up_start_time) * 0.001;
    var_12 = clamp(var_6 - var_11, 0, var_6);
    var_1 scriptmodelclearanim();
    var_2 scriptmodelclearanim();
    var_1 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_up_reversed", var_0.origin, var_0.angles, "drop_pod_return_to_ground", var_12);
    var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_cable_up_reversed", var_0.origin, var_0.angles, undefined, var_12);
    wait(var_11);
    var_1 scriptmodelclearanim();
    var_1 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
    var_3 solid();
    var_3 disconnectpaths();
    var_3 notsolid();
    var_4 notsolid();
    var_4 connectpaths();
  }
}

airship_drop_pod_push_players() {
  var_0 = _getent("dropcage_push_trigger", "targetname");
  var_1 = common_scripts\utility::_id_46B5("pull_players_here", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_2 == self) {
      var_3 = _getent("quest_trig_enter_dropcage", "targetname");
      waitframe();
      player_pulls_towards(var_1.origin, 500);
    }

    wait 0.1;
  }
}

pull_players_inside() {
  var_0 = _getent("pod_door_trigger", "targetname");
  var_1 = _getent("org_tp_plaza", "script_noteworthy");
  var_2 = _getent("clip_door", "script_noteworthy");

  if(self istouching(var_0))
    self setOrigin(var_1.origin);

  wait 1;
  var_2 solid();
  var_2 disconnectpaths();
}

player_pulls_towards(var_0, var_1) {
  var_2 = var_0 - self.origin;
  var_3 = var_1 * vectorNormalize(var_2);
  var_3 = (var_3[0], var_3[1], 250);

  if(var_1 > 0)
    self setvelocity(var_3);
}

airship_animation_airship_drop_pod_open() {
  var_0 = _getent("model_airship_drop_pod", "script_noteworthy");
  var_0 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "airship_drop_pod_door_open");
}

airship_animation_airship_drop_pod_move_down(var_0) {
  level waittill("airship_drop_pod_moving_down");
  var_1 = _getanimlength(%s2_zom_zep_tether_scene_zep_drop_pod_up_reversed);
  var_2 = _getent("drop_pod_model", "script_noteworthy");
  var_2 scriptmodelclearanim();
  var_2 scriptmodelplayanimdeltamotionfrompos("s2_zom_zep_tether_scene_zep_drop_pod_up_reversed", var_0.origin, var_0.angles);
  var_2 _id_0378::_id_8D74("droppod_winch_down");
  thread earthquake_alive_players(0.3, var_1, 1000);
  wait(var_1);
  var_2 scriptmodelclearanim();
  var_2 scriptmodelplayanim("s2_zmb_drop_pod_open_front", "drop_pod_door_open");
  var_2 _id_0378::_id_8D74("droppod_ground_impact");
  level notify("airship_drop_pod_reached_ground");
}

____________________hack_station____________________() {}

hack_station_init() {
  _id_0378::_id_8D74("aud_zep_puzzle_spark_loop");

  if(!common_scripts\utility::_id_3C83("hack_stations_initialized")) {
    common_scripts\utility::flag_init("hack_stations_disabled");
    common_scripts\utility::flag_init("hack_stations_initialized");
    thread hack_station_handler();
    waitframe();
  }
}

hack_station_handler() {
  for(;;) {
    hack_station_hide_all();
    level waittill("show_hack_stations");
    hack_station_show_all();

    if(common_scripts\utility::_id_3C77("hack_stations_disabled"))
      common_scripts\utility::_id_3C7B("hack_stations_disabled");

    hack_station_start_logic();
    level waittill("hide_hack_stations");
    common_scripts\utility::flag_set("hack_stations_disabled");
  }
}

hack_station_hide_all() {
  hack_station_hide("hack_station_00b_terminal");
  hack_station_hide("hack_station_00_terminal");
  hack_station_hide("hack_station_01_terminal");
  hack_station_hide("hack_station_02_terminal");
  hack_station_hide("hack_station_03_terminal");
  var_0 = getEntArray("hack_station_interactable_door", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();
}

hack_station_hide(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_use") {
      var_3 makeunusable();
      continue;
    }

    if(var_3.classname != "script_origin")
      var_3 hide();
  }
}

hack_station_show_all() {
  hack_station_show("hack_station_00b_terminal");
  hack_station_show("hack_station_00_terminal");
  hack_station_show("hack_station_01_terminal");
  hack_station_show("hack_station_02_terminal");
  hack_station_show("hack_station_03_terminal");
  var_0 = getEntArray("hack_station_interactable_door", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 show();
}

hack_station_show(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_use") {
      var_3 makeusable();
      continue;
    }

    if(var_3.classname != "script_origin")
      var_3 show();
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
  waitframe();
  level.hack_station_lights = getEntArray("hack_station_light", "script_noteworthy");

  foreach(var_1 in level.hack_station_lights) {
    var_1.tag_org = spawn("script_model", var_1.origin);
    var_1.tag_org.angles = var_1.angles;
    var_1.tag_org setModel("tag_origin");
    var_1.tag_org linktosynchronizedparent(var_1);
    var_1.tag_org_color = "blue";
    var_1 thread hack_station_blinking_light_update_color();
    waitframe();
    var_1 thread hack_station_check_color_against_triggers(99);
  }
}

hack_station_think(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    if(isDefined(var_6.setlookatent)) {
      switch (var_6.setlookatent) {
        case "hack_station_link_org":
          var_4 = var_6;
          break;
        case "hack_station_player_org":
          var_3 = var_6;
          break;
        case "hack_station_use_trig":
          var_2 = var_6;
          break;
        default:
          break;
      }
    }
  }

  thread hack_station_set_angle_offset_data(var_0, var_4.angles[1]);

  while(!common_scripts\utility::_id_3C77("hack_stations_disabled")) {
    var_2 waittill("trigger", var_8);

    if(var_8 isjumping() || var_8 _meth_82E5()) {
      continue;
    }
    var_9 = var_8;
    var_9 disableweapons();

    if(var_9 getstance() != "stand") {
      var_9 setstance("stand");
      wait 0.7;
    }

    var_9 _meth_812C(0);
    var_10 = var_8.origin;
    var_11 = var_8.angles;
    var_3.origin = var_10;
    var_3.angles = var_11;
    var_9 playerlinkto(var_3, undefined, 0.1, 0, 0, 0, 0);
    var_3 moveto(var_4.origin, 0.5, 0, 0);
    var_3 rotateto(var_4.angles, 0.5, 0, 0);
    wait 0.5;
    level notify("player_activated_hack_console");
    var_9 thread hack_station_start_hacking(var_0, var_2);
    var_9 waittill("stop_using_station");
    thread hack_station_cleanup(var_0);
    var_9 enableweapons();
    var_3 moveto(var_10 + (0, 0, 1), 0.5);
    var_3 rotateto(var_11, 0.5);
    wait 0.5;
    var_9 unlink();
    var_9 _meth_812C(1);
    var_9 setstance("stand");
    wait 0.5;
  }
}

hack_station_set_angle_offset_data(var_0, var_1) {
  while(!isDefined(level.hackstationdata))
    waitframe();

  waittillframeend;

  if(var_1 == 90 || var_1 == 270)
    level.hackstationdata[var_0]["should_apply_yaw_offset"] = 1;
  else
    level.hackstationdata[var_0]["should_apply_yaw_offset"] = 0;
}

hack_station_start_hacking(var_0, var_1) {
  self endon("stop_using_station");
  thread lockin_system_monitor_death();
  var_2 = common_scripts\utility::_id_55E0();
  var_3 = var_2;
  var_4 = !var_2;
  thread lockin_system_monitor_unuse(var_1, var_3, var_4);
  hack_station_handle_inputs(var_0);
}

hack_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::_id_A70A("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

hack_station_handle_inputs(var_0) {
  self endon("stop_using_station");
  level endon("hack_stations_disabled");
  level endon("flag_override_electroschnell_complete");
  var_1 = getEntArray(var_0, "targetname");
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_1) {
    if(isDefined(var_5.setlookatent)) {
      switch (var_5.setlookatent) {
        case "hack_station_node":
          var_2[var_2.size] = var_5;
          break;
        case "hack_station_path":
          var_3[var_3.size] = var_5;
          break;
        default:
          break;
      }
    }
  }

  var_7 = [0, 0, 0];
  var_8 = [0, 0, 0];
  var_9 = 3.01;

  for(;;) {
    var_7 = self getnormalizedmovement() / var_9;

    if(_abs(var_7[0]) > _abs(var_7[1]))
      var_7 = (var_7[0], 0, 0);
    else if(_abs(var_7[1]) > _abs(var_7[0]))
      var_7 = (0, var_7[1], 0);

    if(var_7[0] != 0 || var_7[1] != 0)
      hack_station_update_light_positions(var_7, var_0, var_2, var_3);

    waitframe();
  }
}

hack_station_update_light_positions(var_0, var_1, var_2, var_3) {
  level endon("flag_override_electroschnell_complete");
  var_4 = self.origin;
  var_5 = var_4;
  var_6 = undefined;

  foreach(var_8 in level.hack_station_lights) {
    if(var_8.targetname == var_1) {
      var_6 = var_8;
      break;
    }
  }

  var_5 = var_6 hack_station_get_offset_by_inputs(var_0[0], var_0[1]);
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;

  foreach(var_14 in var_2) {
    if(_ispointinvolume(var_5, var_14)) {
      var_10 = 1;
      level.hack_station_current_node = var_14;
      thread hack_station_node_notify_linked_interactable(var_14, self, "node_highlighted");

      if(var_6.tag_org_color != "green")
        var_12 = 1;

      break;
    }
  }

  if(!var_10) {
    foreach(var_14 in var_3) {
      if(_ispointinvolume(var_5, var_14)) {
        var_10 = 1;
        thread hack_station_node_notify_linked_interactable(var_14, self, "node_abandoned");

        if(var_6.tag_org_color != "blue")
          var_12 = 1;

        break;
      }
    }
  }

  if(var_10) {
    for(var_18 = 0; var_18 < level.hack_station_lights.size; var_18++)
      level.hack_station_lights[var_18] hack_station_send_light_to_offsets(var_0[0], var_0[1], var_12, var_18);
  }
}

hack_station_node_notify_linked_interactable(var_0, var_1, var_2) {
  level endon("flag_override_electroschnell_complete");

  if(isDefined(level.hack_station_current_node._id_0165)) {
    var_3 = _getent(level.hack_station_current_node._id_0165, "targetname");
    var_3 notify(var_2);
  }
}

hack_station_blinking_light_update_color() {
  level endon("hack_stations_disabled");
  var_0 = common_scripts\utility::_id_46B7(self.targetname, "targetname");
  var_1 = "blue";
  var_2 = "green";
  var_3 = -0.5;
  var_4 = spawn("script_model", self.tag_org.origin);
  var_4 setModel("zbr_zeppelin_terminal_light");
  var_4.angles = self.tag_org.angles;
  var_4.origin = var_4.origin + anglestoup(var_4.angles) * var_3;
  var_4 hide();

  for(;;) {
    self waittill("color_swap", var_5);

    if(var_1 == "blue")
      _stopfxontag(level._effect["hack_spark_" + var_1], self.tag_org, "tag_origin");

    waitframe();

    if(var_1 != "blue")
      _playfxontag(level._effect["hack_spark_" + var_2], self.tag_org, "tag_origin");

    self.tag_org_color = var_2;
    var_1 = var_2;

    if(var_1 == "blue") {
      var_2 = "green";
      var_4 hide();
      var_4 _id_0378::_id_8D74("aud_zep_puzzle_light_switch_off");
      continue;
    }

    var_2 = "blue";

    if(isDefined(var_5)) {
      var_6 = common_scripts\utility::_id_4461(self.tag_org.origin, var_0, 5);
      var_4.origin = var_6.origin + anglestoup(var_6.angles) * var_3;
      var_4 common_scripts\utility::_id_2CBE(0.05, ::show);
      var_4 _id_0378::_id_8D74("aud_zep_puzzle_light_switch");
    }
  }
}

hack_station_send_light_to_offsets(var_0, var_1, var_2, var_3) {
  level endon("flag_override_electroschnell_complete");
  var_4 = hack_station_get_offset_by_inputs(var_0 / 2, var_1 / 2);
  self.origin = var_4;

  if(isDefined(var_2) && var_2)
    hack_station_check_color_against_triggers(var_3);
}

hack_station_update_spark_along_path() {
  while(!isDefined(level.hack_station_current_node))
    waitframe();

  level.hackstationdata = [];
  level.hackstationdata["right"] = [];
  level.hackstationdata["forward"] = [];
  hack_station_reset_data(_getent("airship_node_03_01", "targetname").origin);

  for(;;) {
    var_0 = _getent(level.hack_station_current_node._id_0165, "targetname");
    var_1 = hack_station_get_all_nodes_connected_to_node(var_0);
    var_2 = level.hack_station_current_node.targetname;
    var_3 = common_scripts\utility::_id_4461(level.hack_station_current_node.origin, getEntArray("hack_station_light", "script_noteworthy"));
    hack_station_hack_station_data_populate(var_1, var_0, var_3, var_2);
    level.hackstationdata["previous_org"] = var_0.origin + (level.hackstationdata["forward"]["offset_from_in_world_node"], level.hackstationdata["right"]["offset_from_in_world_node"], 0);
    var_4 = _getent("airship_node_03_02", "targetname");
    var_5 = _distance2d(var_4.origin, level.hackstationdata["previous_org"]);

    if(var_5 < 500) {
      var_6 = _getent("airship_node_03_03", "targetname");
      var_7 = _distance2d(var_6.origin, var_4.origin);

      if(var_5 < var_7)
        level.hackstationdata["previous_org"] = (level.hackstationdata["previous_org"][0], level.hackstationdata["previous_org"][1], var_4.origin[2]);
    }

    hack_station_reset_data(level.hackstationdata["previous_org"]);
    waitframe();
  }
}

hack_station_reset_data(var_0) {
  level.hackstationdata["right"]["total_in_world_dist"] = 0;
  level.hackstationdata["right"]["total_hack_station_dist"] = 0;
  level.hackstationdata["right"]["offset_from_current_station_node"] = 0;
  level.hackstationdata["right"]["offset_from_in_world_node"] = 0;
  level.hackstationdata["forward"] = [];
  level.hackstationdata["forward"]["total_in_world_dist"] = 0;
  level.hackstationdata["forward"]["total_hack_station_dist"] = 0;
  level.hackstationdata["forward"]["offset_from_current_station_node"] = 0;
  level.hackstationdata["forward"]["offset_from_in_world_node"] = 0;
  level.hackstationdata["previous_org"] = var_0;
}

hack_station_hack_station_data_populate(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5].origin[1] - var_1.origin[1];
    var_7 = var_0[var_5].origin[0] - var_1.origin[0];

    if(_abs(var_6) > _abs(var_7)) {
      if(_abs(level.hackstationdata["right"]["total_in_world_dist"]) > 0) {
        var_8 = var_1.origin[1] - level.hackstationdata["previous_org"][1];
        var_9 = var_6;

        if(var_8 / _abs(var_8) != var_6 / _abs(var_6)) {
          level.hackstationdata["right"]["total_in_world_dist"] = var_6;
          hack_station_data_populate_scaled_distances("right", var_1, var_0[var_5], var_2, var_3);
          var_4 = var_0[var_5];
        }
      } else {
        level.hackstationdata["right"]["total_in_world_dist"] = var_6;
        hack_station_data_populate_scaled_distances("right", var_1, var_0[var_5], var_2, var_3);
        var_4 = var_0[var_5];
      }

      continue;
    }

    if(_abs(level.hackstationdata["forward"]["total_in_world_dist"]) > 0) {
      var_8 = var_1.origin[0] - level.hackstationdata["previous_org"][0];
      var_10 = undefined;

      if(var_8 != 0)
        var_10 = var_8 / _abs(var_8);
      else
        var_10 = 0;

      var_9 = var_7;
      var_11 = undefined;

      if(var_9 != 0)
        var_11 = var_7 / _abs(var_7);
      else
        var_11 = 0;

      if(var_10 != var_11) {
        level.hackstationdata["forward"]["total_in_world_dist"] = var_7;
        hack_station_data_populate_scaled_distances("forward", var_1, var_0[var_5], var_2, var_3);
        var_4 = var_0[var_5];
      }

      continue;
    }

    level.hackstationdata["forward"]["total_in_world_dist"] = var_7;
    hack_station_data_populate_scaled_distances("forward", var_1, var_0[var_5], var_2, var_3);
    var_4 = var_0[var_5];
  }

  if(!isDefined(level.hackstationdata["right"]["total_in_world_dist"]) || level.hackstationdata["right"]["total_in_world_dist"] == 0)
    hack_station_data_populate_scaled_distances("right", var_1, var_0[0], var_2, var_3);

  if(!isDefined(level.hackstationdata["forward"]["total_in_world_dist"]) || level.hackstationdata["forward"]["total_in_world_dist"] == 0)
    hack_station_data_populate_scaled_distances("forward", var_1, var_0[0], var_2, var_3);

  var_6 = level.hackstationdata["right"]["offset_from_in_world_node"];
  var_7 = level.hackstationdata["forward"]["offset_from_in_world_node"];

  if(_abs(var_6) < _abs(var_7)) {
    level.hackstationdata["right"]["offset_from_in_world_node"] = level.hackstationdata["right"]["offset_from_in_world_node"] / 1000;
    level.in_world_spark.angles = (level.in_world_spark.angles[0], 90, level.in_world_spark.angles[2]);
  } else {
    level.hackstationdata["forward"]["offset_from_in_world_node"] = level.hackstationdata["forward"]["offset_from_in_world_node"] / 1000;
    level.in_world_spark.angles = (level.in_world_spark.angles[0], 0, level.in_world_spark.angles[2]);
  }
}

hack_station_data_populate_scaled_distances(var_0, var_1, var_2, var_3, var_4) {
  var_5 = common_scripts\utility::_id_46B7("hack_station_node_org", "script_noteworthy");
  var_6 = undefined;
  var_7 = getEntArray(var_2.targetname, "script_noteworthy");

  foreach(var_9 in var_7) {
    if(var_9.targetname == var_4)
      var_6 = common_scripts\utility::_id_4461(var_9.origin, var_5, 5);
  }

  var_11 = undefined;
  var_12 = getEntArray(var_1.targetname, "script_noteworthy");

  foreach(var_9 in var_12) {
    if(var_9.targetname == var_4)
      var_11 = common_scripts\utility::_id_4461(var_9.origin, var_5, 5);
  }

  if(var_0 == "right") {
    if(!isDefined(level.hackstationdata[var_4]) || !level.hackstationdata[var_4]["should_apply_yaw_offset"]) {
      level.hackstationdata[var_0]["total_hack_station_dist"] = var_11.origin[1] - var_6.origin[1];
      level.hackstationdata[var_0]["offset_from_current_station_node"] = var_11.origin[1] - var_3.origin[1];
    } else {
      level.hackstationdata[var_0]["total_hack_station_dist"] = var_11.origin[0] - var_6.origin[0];
      level.hackstationdata[var_0]["offset_from_current_station_node"] = var_11.origin[0] - var_3.origin[0];
    }
  } else if(!isDefined(level.hackstationdata[var_4]) || !level.hackstationdata[var_4]["should_apply_yaw_offset"]) {
    level.hackstationdata[var_0]["total_hack_station_dist"] = var_11.origin[0] - var_6.origin[0];
    level.hackstationdata[var_0]["offset_from_current_station_node"] = var_11.origin[0] - var_3.origin[0];
  } else {
    level.hackstationdata[var_0]["total_hack_station_dist"] = var_11.origin[1] - var_6.origin[1];
    level.hackstationdata[var_0]["offset_from_current_station_node"] = var_11.origin[1] - var_3.origin[1];
  }

  if(_abs(level.hackstationdata[var_0]["total_in_world_dist"]) > 0 && _abs(level.hackstationdata[var_0]["total_hack_station_dist"]) > 0)
    var_15 = level.hackstationdata[var_0]["total_in_world_dist"] / level.hackstationdata[var_0]["total_hack_station_dist"];
  else
    var_15 = 0;

  level.hackstationdata[var_0]["offset_from_in_world_node"] = level.hackstationdata[var_0]["offset_from_current_station_node"] * var_15;
}

hack_station_get_all_nodes_connected_to_node(var_0) {
  var_1 = [];

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    if(isDefined(var_2)) {
      foreach(var_4 in var_2)
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
    }
  }

  if(isDefined(var_0.targetname)) {
    var_2 = getEntArray(var_0.targetname, "target");

    if(isDefined(var_2)) {
      foreach(var_4 in var_2)
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
    }
  }

  return var_1;
}

hack_station_get_vector_offset(var_0, var_1, var_2) {}

hack_station_check_color_against_triggers(var_0) {
  level endon("hack_stations_disabled");
  var_1 = getEntArray(self.targetname, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.setlookatent)) {
      switch (var_4.setlookatent) {
        case "hack_station_node":
          var_2[var_2.size] = var_4;
          break;
        default:
          break;
      }
    }
  }

  var_6 = 0;
  var_7 = undefined;

  foreach(var_9 in var_2) {
    if(var_9 _meth_858B(self.origin)) {
      var_7 = var_9;
      var_6 = 1;
      break;
    }
  }

  if(var_6) {
    if(self.tag_org_color == "blue") {
      self notify("color_swap", var_7);

      if(var_0 == 0)
        thread hack_station_attempt_soul_collection_on_node(var_7);
    }
  } else if(self.tag_org_color == "green")
    self notify("color_swap", var_7);
}

hack_station_attempt_soul_collection_on_node(var_0) {
  var_1 = _getent(var_0._id_0165, "targetname");
  var_1 notify("kill_extra_soulbucket_threads");
  var_1 endon("kill_extra_soulbucket_threads");

  if(isDefined(var_1.soul_charged) && var_1.soul_charged) {
    return;
  }
  var_2 = 256;
  var_3 = 256;
  var_4 = 4;
  var_5 = _id_0547::_id_408F();
  var_6 = undefined;

  if(!isDefined(var_5) || var_5.size <= 0) {
    return;
  }
  foreach(var_8 in var_5) {
    if(_distance2d(var_1.origin, var_8.origin) < var_2 / var_4 && _abs(var_1.origin[2] - var_8.origin[2]) < var_3 / var_4) {
      var_6 = var_8;
      break;
    }
  }

  if(!isDefined(var_6)) {
    return;
  }
  var_10 = spawn("script_model", var_1.origin);
  var_10 setModel("tag_origin");
  var_6 thread maps\mp\mp_zombies_soul_collection::_id_2024(var_10, "tag_origin", undefined, "tag_origin");

  if(!common_scripts\utility::_id_562E(var_6._id_2FDA) && !_id_0547::_id_5565(var_6._id_0A4B, "zombie_fireman"))
    var_6 maps\mp\mp_zombies_soul_collection::_id_865C("scripted_soul_eat", 0);

  waitframe();
  var_6 dodamage(999999, var_6.origin);
  var_1.soul_charged = 1;
  level notify("hack_node_soul_collected");
  wait 1;
  var_10 delete();
}

hack_station_get_offset_by_inputs(var_0, var_1) {
  level endon("flag_override_electroschnell_complete");
  var_2 = self.origin;
  var_2 = var_2 - (anglestoright(self.angles) * var_1 + anglesToForward(self.angles) * var_0);
  return var_2;
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
  var_0 = _getent("airship_node_03_03", "targetname");
  var_1 = 0;

  if(!var_1) {
    var_0 waittill("hack_interact");

    foreach(var_3 in level._id_AC1D) {
      if(isDefined(var_3.getnegotiationnextnode) && var_3.getnegotiationnextnode == "airship_bay_door")
        var_3 notify("open");
    }

    var_1 = 1;
    common_scripts\utility::flag_set("flag_open_cargobay_complete");
  }
}

hack_station_interactable_lab_door_left() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_01_02", "targetname");
  var_1 = 0;

  if(!var_1) {
    var_0 waittill("hack_interact");

    foreach(var_3 in level._id_AC1D) {
      if(isDefined(var_3.getnegotiationnextnode) && var_3.getnegotiationnextnode == "airship_lab_door_left")
        var_3 notify("open");
    }

    var_1 = 1;
    common_scripts\utility::flag_set("flag_open_cargobay_left_complete");
  }
}

hack_station_interactable_lab_door_left_back() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_02_01", "targetname");
  var_1 = 0;

  if(!var_1) {
    var_0 waittill("hack_interact");

    foreach(var_3 in level._id_AC1D) {
      if(isDefined(var_3.getnegotiationnextnode) && var_3.getnegotiationnextnode == "airship_lab_door_left_back")
        var_3 notify("open");
    }

    var_1 = 1;
    common_scripts\utility::flag_set("flag_open_cargobay_left_back_complete");
  }
}

hack_station_interactable_lab_door_right() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_05_02", "targetname");
  var_1 = 0;

  if(!var_1) {
    var_0 waittill("hack_interact");

    foreach(var_3 in level._id_AC1D) {
      if(isDefined(var_3.getnegotiationnextnode) && var_3.getnegotiationnextnode == "airship_lab_door_right")
        var_3 notify("open");
    }

    var_1 = 1;
    common_scripts\utility::flag_set("flag_open_cargobay_right_complete");
  }
}

hack_station_interactable_lab_door_right_back() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_04_01", "targetname");
  var_1 = 0;

  if(!var_1) {
    var_0 waittill("hack_interact");

    foreach(var_3 in level._id_AC1D) {
      if(isDefined(var_3.getnegotiationnextnode) && var_3.getnegotiationnextnode == "airship_lab_door_right_back")
        var_3 notify("open");
    }

    var_1 = 1;
    common_scripts\utility::flag_set("flag_open_cargobay_right_back_complete");
  }
}

hack_station_interactable_straub_node() {
  var_0 = _getent("airship_node_03_05", "targetname");

  if(!isDefined(var_0._id_A203)) {
    var_0 waittill("hack_interact");
    var_0._id_A203 = 1;
    common_scripts\utility::flag_set("flag_override_electroschnell_complete");
  }
}

hack_station_moving_spark_handler() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_03_01", "targetname");
  level.in_world_spark = spawn("script_model", var_0.origin);
  level.in_world_spark setModel("tag_origin");
  thread hack_station_moving_spark_fx_swap();

  while(!isDefined(level.hackstationdata) || !isDefined(level.hackstationdata["previous_org"]))
    waitframe();

  thread hack_station_moving_spark_position_think();
  var_1 = getEntArray("hack_node_generic", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 thread hack_station_interactable_generic_node_think();
}

power_source_effects() {
  var_0 = _getent("power_source_bottom_model", "targetname");
  var_1 = _spawnfx(level._effect["zmb_ber_zep_power_source_on"], var_0.origin, anglesToForward(var_0.angles));
  _triggerfx(var_1);
  common_scripts\utility::_id_3C9F("flag_override_electroschnell_complete");
  wait 10;
  _id_0378::_id_8D74("aud_electroschnell_overload_explo");
  var_2 = _spawnfx(level._effect["zmb_ber_zep_power_source_buildup"], var_0.origin, anglesToForward(var_0.angles));
  _triggerfx(var_2);
  wait 2;
  var_1 delete();
  var_3 = _spawnfx(level._effect["zmb_ber_zep_power_source_overload"], var_0.origin, anglesToForward(var_0.angles));
  _triggerfx(var_3);
  wait 0.5;
  thread earthquake_alive_players(0.2, 2, 1000);
  wait 1;
  level thread common_scripts\_exploder::_id_2A6D(216, undefined, 0);
  self waittill("airship_escape_drop_pod_doors_complete");
  var_3 delete();
}

hack_station_moving_spark_fx_swap() {
  level endon("flag_override_electroschnell_complete");
  var_0 = _getent("airship_node_03_01", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  thread hack_station_moving_spark_fx_kill(var_1);
  _playfxontag(level._effect["zmb_ber_shp_elec_tube_point"], var_1, "tag_origin");

  for(;;) {
    level.in_world_spark waittill("swap_spark_FX", var_2, var_3, var_4);

    if(isDefined(var_4)) {
      var_1.origin = var_4.origin;
      _killfxontag(level._effect[var_3], level.in_world_spark, "tag_origin");
      _playfxontag(level._effect[var_2], var_1, "tag_origin");
      var_1 _id_0378::_id_8D74("aud_zep_puzzle_spark_leave");
      continue;
    }

    _killfxontag(level._effect[var_3], var_1, "tag_origin");
    _playfxontag(level._effect[var_2], level.in_world_spark, "tag_origin");
    var_1 _id_0378::_id_8D74("aud_zep_puzzle_spark_arrive");
  }
}

hack_station_moving_spark_fx_kill(var_0) {
  level waittill("airship_drop_pod_reached_ground");
  _killfxontag(level._effect["hack_node_light_00"], var_0, "tag_origin");
  _killfxontag(level._effect["hack_node_light_01"], var_0, "tag_origin");
  _killfxontag(level._effect["hack_node_light_00"], level.in_world_spark, "tag_origin");
  _killfxontag(level._effect["hack_node_light_01"], level.in_world_spark, "tag_origin");
}

hack_station_moving_spark_position_think() {
  level endon("flag_override_electroschnell_complete");

  for(;;) {
    level.in_world_spark.origin = level.hackstationdata["previous_org"];
    waitframe();
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

hack_station_cleanup(var_0) {
  if(isDefined(level.hack_station_current_node._id_0165)) {
    var_1 = _getent(level.hack_station_current_node._id_0165, "targetname");
    var_1 notify("hack_interact");
  }
}

____________________vo____________________() {}

berlinroundstart() {
  thread berlinroundstartvo();
}

berlinroundstartvo() {
  wait(_randomintrange(2, 6));

  if(!common_scripts\utility::_id_3C77("flag_exit_underbelly"))
    common_scripts\utility::random(level.players) _id_0367::_id_8E3D("wavebreak_underbelly");

  if(common_scripts\utility::_id_3C77("flag_exit_underbelly")) {
    if(!common_scripts\utility::_id_3C77("flag quest_contact_hq step_find_radio"))
      common_scripts\utility::random(level.players) _id_0367::_id_8E3D("radio_nag");
  }

  if(common_scripts\utility::_id_3C77("flag quest_contact_hq step_find_radio")) {
    if(!common_scripts\utility::_id_3C77("flag quest_contact_soviets step_contact_soviets"))
      common_scripts\utility::random(level.players) _id_0367::_id_8E3D("radio_code_nag");
  }

  if(common_scripts\utility::_id_3C77("flag quest_draw_airship step_ignite_flare")) {
    if(!common_scripts\utility::_id_3C77("flag_airship_summoned"))
      common_scripts\utility::random(level.players) _id_0367::_id_8E3D("flares_nag");
  }

  if(common_scripts\utility::_id_3C77("airship_tethers_out")) {
    if(!common_scripts\utility::_id_3C77("flag_airship_fully_lowered")) {
      if(isDefined(level.fourth_flag)) {
        if(common_scripts\utility::_id_3C77("flag_hc_quest_finale_door_open"))
          common_scripts\utility::random(level.players) _id_0367::_id_8E3D("airship_tether_nag");
      } else
        common_scripts\utility::random(level.players) _id_0367::_id_8E3D("airship_tether_nag");
    }
  }

  if(common_scripts\utility::_id_3C77("flag quest_bring_down_airship step_reel_anchors")) {
    if(!common_scripts\utility::_id_3C77("flag quest_bring_down_airship step_raise_dropcage"))
      common_scripts\utility::random(level.players) _id_0367::_id_8E3D("airship_pod_nag");
  }
}

berlinroundend() {
  thread berlinroundendvo();
}

berlinroundendvo() {
  wait(_randomintrange(1, 3));

  if(!common_scripts\utility::_id_3C77("flag_straub_death_scene")) {
    switch (level._id_A980) {
      case 3:
        if(common_scripts\utility::_id_3C77("flag_exit_underbelly"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      case 5:
        if(common_scripts\utility::_id_3C77("flag_exit_underbelly"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      case 7:
        if(common_scripts\utility::_id_3C77("flag_exit_underbelly"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      case 9:
        if(common_scripts\utility::_id_3C77("flag_exit_underbelly"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      case 11:
        if(common_scripts\utility::_id_3C77("flag_airship_summoned"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      case 13:
        if(common_scripts\utility::_id_3C77("flag_quest_wunderbuss_wunderbuss_built"))
          level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();

        break;
      default:
        break;
    }
  }
}

vo_logic() {
  thread vo_straub_entered_airship();
  var_0 = undefined;

  while(!common_scripts\utility::_id_562E(var_0)) {
    if(level.players.size > 0)
      var_0 = 1;

    foreach(var_2 in level.players)
    var_0 = !var_2 maps\mp\gametypes\zombies::player_is_playing_loading_cinematic() && var_0;

    wait 0.2;
  }

  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("get_bearings");
  common_scripts\utility::_id_3CA2("underbelly_to_underbelly_intact", "underbelly_to_underbelly_rubble");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("get_bearings_nag");
  common_scripts\utility::_id_3CA2("underbelly_rubble_to_street", "underbelly_intact_to_street");
  thread vo_straub_airship_intro();
  wait 10;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("vo_radio_code()_find");

  foreach(var_2 in level.players) {
    var_2 thread vo_church_reaction();
    var_2 thread vo_cabaret_reaction();
    var_2 thread vo_museum_reaction();
    var_2 thread vo_radio_code();
  }
}

vo_straub_airship_intro() {
  wait 5;
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_intro_alt", "exterior", 0, level.straub_airship);
}

vo_straub_airship_anchor_damage() {
  var_0 = level.airship_anchor_flag_array;
  common_scripts\utility::_id_3CA3(var_0);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_tether_start_react_alt", "exterior", 1, level.straub_airship);
  common_scripts\utility::_id_3CA1(var_0);
  wait 5;
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_tether_done_react_alt", "exterior", 1, level.straub_airship);
}

vo_straub_entered_airship() {
  common_scripts\utility::_id_3C9F("flag_drop_pod_reached_airship");
  wait 5;
  var_0 = common_scripts\utility::_id_46B7("pa_struct_airship_int", "targetname");
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_airship_boarded", "interior", 1, var_0);
  common_scripts\utility::_id_3C9F("flag_open_cargobay_complete");
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_straub_trap_react_1", "interior", 1, var_0);
  common_scripts\utility::_id_3CA2("flag_open_cargobay_left_complete", "flag_open_cargobay_right_complete");
  common_scripts\utility::_id_3CA2("flag_open_cargobay_left_back_complete", "flag_open_cargobay_right_back_complete");
}

vo_straub_death() {
  var_0 = common_scripts\utility::_id_46B7("pa_struct_airship_int", "targetname");
  wait 0.4;
  thread vo_player_see_straub_death();
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath1", "interior", 0, var_0);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath2", "interior", 0, var_0);
  maps\mp\mp_zombie_berlin_aud::pa_system_dialogue_all_players("zmb_berl_stra_vidlog_straubdeath3", "interior", 1, var_0);
}

vo_church_reaction() {
  var_0 = _getent("church_vo", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      wait 2;
      var_1 _id_0367::_id_8E3D("location_church_react");
      break;
    }

    wait 1;
  }
}

vo_cabaret_reaction() {
  var_0 = _getent("cabaret_vo", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      wait 2;
      var_1 _id_0367::_id_8E3D("location_church_response");
      break;
    }

    wait 1;
  }
}

vo_museum_reaction() {
  var_0 = _getent("museum_vo", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      wait 2;
      var_1 _id_0367::_id_8E3D("location_museum_react");
      break;
    }

    wait 1;
  }
}

vo_radio_code() {
  var_0 = _getent("radio_code_vo", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == self) {
      wait 2;
      var_1 _id_0367::_id_8E3D("radio_code_discovery");
      break;
    }

    wait 1;
  }
}

vo_first_sizzler_transformation() {
  var_0 = 0;

  while(var_0 == 0) {
    var_1 = _id_0547::_id_4090("zombie_generic");

    foreach(var_3 in var_1) {
      if(zombies_look_at(var_3)) {
        if(isDefined(var_3.transformingtosizzler) && var_3.transformingtosizzler == 1) {
          wait 4;
          _id_0367::_id_8E3D("sizzler_first_react");
          var_0 = 1;
          break;
        }
      }
    }

    wait 0.1;
  }
}

vo_airship_anchor_damage() {
  level waittill("airship_anchor_damaged");
  wait 2;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_first_damage");
  var_0 = level.airship_anchor_flag_array;
  common_scripts\utility::_id_3CA3(var_0);
  common_scripts\utility::_id_3C9F("flag_hc_quest_finale_sword_door_open");
  wait 3;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_pod_dropped");
  level waittill("drop_pod_moving_up");
  wait 1;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("airship_pod_interacted");
}

vo_player_enter_airship() {
  wait 5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_establish");
  level waittill("player_activated_hack_console");
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_console");
}

vo_player_see_straub_death() {
  wait 4.5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_electroschnell_dead");
  wait 8;
  snd_zmb_plr_dlg_play_line_without_drostan("straub_dead");
  wait 8;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("straub_alarm");
}

snd_zmb_plr_dlg_play_line_without_drostan(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach(var_7 in level.players) {
    if(var_7._id_20DA != "arch")
      var_7 _id_0367::_id_8E3D(var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

vo_airship_escape_pod_closing() {
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("escape_doors_closing");
}

vo_say_hello_to_my_little_bob() {
  wait 1.5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_intro");
  level.bob common_scripts\utility::_id_379C("bob_sizzle");
  wait 1.5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_level_up_1");
  level.bob common_scripts\utility::_id_379C("bob_smoke");
  wait 1.5;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_level_up_2");
  level.bob common_scripts\utility::_id_379C("bob_was_koed");
  wait 3;
  _id_0367::snd_zmb_plr_dlg_play_line_on_each_player("bob_death");
}

zombies_look_at(var_0) {
  var_1 = var_0.origin;
  var_2 = self getEye();
  var_3 = vectorNormalize(var_1 - var_2);
  var_4 = vectorNormalize(anglesToForward(self _meth_8566()));
  var_5 = vectordot(var_3, var_4);
  waitframe();
  var_6 = _acos(clamp(var_5, -1, 1));

  if(var_6 < 25 && distance(var_1, var_2) < 420)
    return 1;
  else
    return 0;
}

______________zombie_bolt_taking______________() {}

spine_player_manager() {
  var_0 = self;
  var_0 endon("disconnect");
  level waittill("spine_collected", var_1, var_2);

  if(var_2 == var_0)
    var_0 thread spine_collect(var_1);
}

spine_zombie_collect_listener(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self._id_AC10) || !isDefined(self._id_0A4B) || !isDefined(var_1) || !isDefined(var_4) || !isDefined(var_3) || !maps\mp\_utility::_id_5755(var_3)) {
    return;
  }
  level endon("spine_collected");
  var_9 = undefined;

  switch (self._id_0A4B) {
    case "zombie_sizzler":
      var_9 = "sizzler_spine";
      break;
    default:
      return;
  }

  _iprintln(var_9 + " collected!");
  var_1.spine_hint_complete = 1;
  common_scripts\utility::flag_set("flag_quest_wunderbuss_geistbolt_collected");
  level notify("spine_collected", var_9, var_1);
}

spine_collect(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("spine_destroyed");
  var_2 = "bolt_inspect_sizzler_zm";
  var_3 = &"ZOMBIE_WEAPONDLC1_SPINE_ZOMBIE";
  var_4 = "ui_transparent";
  var_1 spine_pickup_anim(var_2);
}

spine_pickup_anim(var_0) {
  var_1 = self;

  while(var_1 isswitchingweapon())
    waitframe();

  var_2 = var_1 getcurrentweapon();
  var_1 common_scripts\utility::_id_0603();
  var_1 common_scripts\utility::_disableoffhandweapons();
  var_1 _id_0586::_id_078C(var_0);
  var_1 _id_0586::_id_078E(var_0, 1);
  var_1 allowjump(0);
  var_1 allowsprint(0);
  wait 0.1;
  var_1 setstance("stand");
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 waittill("weapon_change");
  wait 3.0;

  if(!_id_0547::_id_73F9(self, var_2))
    var_2 = var_1 _id_0547::_id_AB2B();

  var_1 _id_0586::_id_078E(var_2);
  var_1 common_scripts\utility::_id_0617();
  var_1 common_scripts\utility::_id_0614();

  if(var_1 hasweapon(var_0))
    var_1 _id_0586::_id_0790(var_0);

  var_1 _meth_8546(1);
  var_1 allowlean(1);
  var_1 allowsprint(1);
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1 allowjump(1);
}