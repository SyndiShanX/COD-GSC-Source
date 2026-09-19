/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_ee_hc.gsc
******************************************************/

init() {
  thread hc_quest_bat_init();
  thread hc_quest_dagger_init();
  thread hc_quest_finale_init();
  thread hc_quest_axe_init();
  thread hc_quest_hats_init();
}

_______________________bat_______________________() {}

hc_quest_bat_init() {
  common_scripts\utility::flag_init("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step02_give_jolts_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_step03_open_door_complete");
  common_scripts\utility::flag_init("flag_hc_quest_bat_give_pp_weapon_complete");
  var_0 = getEntArray("hc_bat_final_room_prop", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  hc_quest_bat_logic();
}

hc_quest_bat_logic() {
  thread hc_quest_bat_step02_ammo_generate();
  hc_quest_bat_step01_handler();
  hc_quest_bat_step02_handler();
  hc_quest_bat_step03_handler();
}

hc_quest_bat_step01_handler() {
  thread hc_quest_bat_step01_register_listen();
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step01_open_register_complete");
  thread hc_quest_bat_step01_generate_code();
  thread hc_quest_bat_step01_radio_code_listen();
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step01_contact_survivor_complete");
  thread hc_quest_bat_step01_cleanup();
}

hc_quest_bat_step01_register_listen() {
  var_0 = _getent("hc_smuggler_register", "script_noteworthy");
  var_1 = _getent("hc_smuggler_register_clip_open", "script_noteworthy");
  var_1 notsolid();
  var_2 = _getent("hc_smuggler_register_trig", "script_noteworthy");
  var_2 setcontents(var_2 _meth_85A0() | 256);
  var_3 = _getent("hc_register_date", "script_noteworthy");
  var_3 linkto(var_0, "drawer");

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_bat_step01_open_register_complete")) {
    var_2 waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(var_13 == "wunderbuss_zm") {
      var_0 scriptmodelplayanim("s2_zom_zbr_cash_register_open", "cash_register_open");
      _id_0378::_id_8D74("smugglers_bat_cash_register", var_0.origin);
      var_1 solid();
      common_scripts\utility::flag_set("flag_hc_quest_bat_step01_open_register_complete");
    }

    waitframe();
  }
}

hc_quest_bat_step01_generate_code() {
  var_0 = 15;
  var_1 = 5;
  var_2 = 1;
  var_3 = 12;

  for(;;) {
    var_4 = 0;
    var_5 = 0;
    var_2 = _randomintrange(1, 3);
    var_1 = _randomintrange(1, 9);
    var_3 = _randomintrange(1, 13);
    var_0 = var_2 + "" + var_1;
    var_0 = _id_0547::_id_9470(var_0);
    level.hc_smuggler_code_left = var_0;
    level.hc_smuggler_code_right = var_3;

    if(level.hc_smuggler_code_left != level.radio_code_left && _abs(level.hc_smuggler_code_left - level.radio_code_left) > 5)
      var_4 = 1;

    if(level.hc_smuggler_code_right != level.radio_code_right && _abs(level.hc_smuggler_code_right - level.radio_code_right) > 5)
      var_5 = 1;

    if(var_4 && var_5) {
      break;
    }

    waitframe();
  }

  if(var_0 < 10)
    var_6 = "0" + var_0;
  else
    var_6 = var_0;

  if(var_3 < 10)
    var_7 = "0" + var_3;
  else
    var_7 = var_3;

  var_8 = _getent("hc_register_date", "script_noteworthy");
  var_8 _meth_8695("TAG_DATE");
  var_9 = "TAG_DATE_T0" + var_2;
  var_8 _meth_8696(var_9);
  var_10 = "TAG_DATE_D0" + var_1;
  var_8 _meth_8696(var_10);
  var_11 = "TAG_DATE_M" + var_7;
  var_8 _meth_8696(var_11);
}

hc_quest_bat_step01_radio_code_listen() {
  level endon("flag_hc_quest_bat_step01_contact_survivor_complete");

  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  var_0 = 0;

  while(!var_0) {
    while(!maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_right, "right") || !maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_left, "left"))
      waitframe();

    var_1 = 2500;
    var_2 = gettime();
    var_3 = 0;

    while(var_1 > var_3) {
      if(maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_right, "right") && maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_left, "left")) {
        var_3 = gettime() - var_2;

        if(var_1 <= var_3) {
          var_0 = 1;
          break;
        }
      }

      waitframe();
    }
  }

  if(!isDefined(level.possible_radio_codes))
    level.possible_radio_codes = [];

  var_4 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_4] = [];
  level.possible_radio_codes[var_4]["left"] = level.hc_smuggler_code_left;
  level.possible_radio_codes[var_4]["right"] = level.hc_smuggler_code_right;
  _iprintlnbold("You've contacted The Smuggler!");
  wait 2;
  _id_0378::_id_8D74("aud_radio_tuning", "smuggler_dialog_playing", "zmb_berl_gsmg_hc_smuggler_intro");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_contact_survivor_complete");
}

hc_quest_bat_step01_cleanup() {}

hc_quest_bat_step02_handler() {
  _id_054D::giveplayersexp("berlin_exp_ref_10");
  thread hc_quest_bat_step02_manhole_wait_for_damage("hc_smuggler_hole_weapon");
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step02_open_gun_cover_complete");
  thread hc_quest_bat_step02_gun_drop_listen();
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step02_give_weapon_complete");
  _id_054D::giveplayersexp("berlin_exp_ref_7");
  thread hc_quest_bat_step02_wave_wait("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  thread hc_quest_bat_step02_manhole_wait_for_damage("hc_smuggler_hole_jolt");
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  thread hc_quest_bat_step02_jolt_drop_listen();
  common_scripts\utility::_id_3C9F("flag_hc_quest_bat_step02_give_jolts_complete");
  _id_054D::giveplayersexp("berlin_exp_ref_0");
  hc_quest_bat_step02_cleanup();
}

hc_quest_bat_step02_vo_hole_discovery(var_0) {
  var_1 = self;

  if(var_0 == "hc_smuggler_hole_weapon") {
    var_2 = _getent("hc_org_smuggler_hole_weapon_place", "script_noteworthy");
    var_1 _id_0367::_id_8E3C("hc_smuggler_found");
    _id_0380::_id_6844("zmb_berl_gsmg_hc_smuggler_found", undefined, var_2);
  } else if(var_0 == "hc_smuggler_hole_jolt") {
    var_2 = _getent("hc_bat_trig_use_jolt_drop", "script_noteworthy");
    var_1 _id_0367::_id_8E3C("hc_smuggler_found_jolts");
    _id_0380::_id_6844("zmb_berl_gsmg_hc_smuggler_found_jolts", undefined, var_2);
  }
}

hc_quest_bat_step02_ammo_generate() {
  var_0 = _randomintrange(0, 3);

  switch (var_0) {
    case 0:
      level.survivor_ammo_type = "12ga";
      break;
    case 1:
      level.survivor_ammo_type = "9mm";
      break;
    case 2:
      level.survivor_ammo_type = "7.92x57mm";
      break;
    case 3:
      level.survivor_ammo_type = "10.6x25mm";
      break;
    default:
      break;
  }

  var_1 = getEntArray("hc_smuggler_ammo", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  switch (level.survivor_ammo_type) {
    case "12ga":
      var_5 = getEntArray("hc_smuggler_ammo_12ga", "script_noteworthy");

      foreach(var_3 in var_5) {
        var_3 show();
        var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
      }

      break;
    case "9mm":
      var_8 = getEntArray("hc_smuggler_ammo_9mm", "script_noteworthy");

      foreach(var_3 in var_8) {
        var_3 show();
        var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
      }

      break;
    case "7.92x57mm":
      var_11 = getEntArray("hc_smuggler_ammo_792", "script_noteworthy");

      foreach(var_3 in var_11) {
        var_3 show();
        var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
      }

      break;
    case "10.6x25mm":
      var_14 = getEntArray("hc_smuggler_ammo_revolver", "script_noteworthy");

      foreach(var_3 in var_14) {
        var_3 show();
        var_1 = common_scripts\utility::_id_0F93(var_1, var_3);
      }

      break;
    default:
      break;
  }

  foreach(var_3 in var_1)
  var_3 delete();
}

hc_quest_bat_step02_manhole_wait_for_damage(var_0) {
  var_1 = getEntArray("hc_bat_smuggler_hole_cover", "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4._id_0165 == var_0)
      var_2 = var_4;
  }

  var_6 = getEntArray("hc_trig_dmg_smuggler_hole", "targetname");
  var_7 = undefined;
  var_8 = "smugglers_bat_gas_cover_open_01";

  foreach(var_10 in var_6) {
    if(var_10._id_0165 == var_0) {
      for(;;) {
        var_10 waittill("damage", var_11, var_7, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19);

        if(var_0 == "hc_smuggler_hole_weapon") {
          var_8 = "smugglers_bat_gas_cover_open_01";
          common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_gun_cover_complete");
        }

        if(var_0 == "hc_smuggler_hole_jolt") {
          var_8 = "smugglers_bat_gas_cover_open_02";
          common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_jolt_cover_complete");
        }

        wait 0.5;

        if(isDefined(var_8))
          _id_0378::_id_8D74(var_8, var_2.origin);

        var_2 movey(14, 1.25, 0.25, 0.25);
        break;
      }

      break;
    }
  }

  var_7 thread hc_quest_bat_step02_vo_hole_discovery(var_0);
}

hc_quest_bat_step02_gun_drop_listen() {
  level endon("weapon_given");
  var_0 = _getent("hc_bat_trig_use_gun_drop_1", "script_noteworthy");
  var_1 = undefined;

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_3 = var_2 getcurrentprimaryweapon();

    if(!issubstr(var_3, "shovel"))
      var_2 _id_0586::_id_0790(var_3);
    else
      continue;

    var_2 _id_0367::_id_8E3D("hc_smuggler_weapon_given");
    var_4 = var_2 getweaponlistprimaries();
    var_4 = common_scripts\utility::_id_0F93(var_4, var_3);

    if(var_4.size > 0)
      var_2 switchtoweapon(var_4[0]);
    else {
      var_5 = _id_0548::_id_454B(var_2, "shovel_zm");
      var_2 switchtoweapon(var_5);
    }

    var_6 = _getent("hc_org_smuggler_hole_weapon_place", "script_noteworthy");
    var_6._id_92F0 = var_6.origin;
    var_6._id_92B8 = var_6.angles;
    var_6 rotatepitch(-90, 0.05);
    waitframe();
    var_6 rotateyaw(90, 0.05);
    waitframe();
    _id_0378::_id_8D74("smugglers_bat_weapon_drop", var_0.origin);
    var_7 = "weapon_" + var_3;
    var_8 = spawn(var_7, var_6.origin);
    var_8 linkto(var_6);
    var_8 makeunusable();
    var_6 movez(-80, 2);
    wait 3;
    var_8 delete();
    var_6.origin = var_6._id_92F0;
    var_6.angles = var_6._id_92B8;
    var_9 = undefined;

    if(issubstr(var_3, "m30") || issubstr(var_3, "walther") || issubstr(var_3, "winchester1897") || issubstr(var_3, "model21")) {
      var_9 = "12ga";
      var_1 = "smugglers_bat_combat_walther";
    } else if(issubstr(var_3, "mp28") || issubstr(var_3, "mp40") || issubstr(var_3, "m712") || issubstr(var_3, "luger") || issubstr(var_3, "p38") || issubstr(var_3, "sten") || issubstr(var_3, "beretta")) {
      var_9 = "9mm";

      if(issubstr(var_3, "luger") || issubstr(var_3, "p38"))
        var_1 = "smugglers_bat_combat_p38";
      else
        var_1 = "smugglers_bat_combat_mp40";
    } else if(issubstr(var_3, "mg15") || issubstr(var_3, "mg42") || issubstr(var_3, "karabin") || issubstr(var_3, "fg42") || issubstr(var_3, "g43") || issubstr(var_3, "mg81")) {
      var_9 = "7.92x57mm";

      if(issubstr(var_3, "g43") || issubstr(var_3, "karabin"))
        var_1 = "smugglers_bat_combat_g43";
      else if(issubstr(var_3, "fg42"))
        var_1 = "smugglers_bat_combat_fg42";
      else
        var_1 = "smugglers_bat_combat_mg42";
    } else if(issubstr(var_3, "reich")) {
      var_9 = "10.6x25mm";
      var_1 = "smugglers_bat_combat_reichrevolver";
    }

    if(isDefined(var_9) && var_9 == level.survivor_ammo_type) {
      _iprintlnbold("You hear gunshots coming from the hole in the ground.");
      _id_0380::_id_6844("zmb_berl_gsmg_hc_smuggler_weapon_right", undefined, var_6);
      common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_weapon_complete");
      var_0 common_scripts\utility::_id_9D9F();
      level.survivor_wep_is_pap = 0;

      if(issubstr(var_3, "pap"))
        level.survivor_wep_is_pap = 1;

      level notify("weapon_given");
      wait 3;

      if(!isDefined(var_1))
        var_1 = "smugglers_bat_combat_mp40";

      _id_0378::_id_8D74("smugglers_bat_start_combat_loop", var_0.origin - (0, 0, -100), var_1);
    } else {
      wait 1;
      _iprintlnbold("I have no bullets for this weapon!");
      _id_0380::_id_6844("zmb_berl_gsmg_hc_smuggler_weapon_wrong", undefined, var_6);
    }

    wait 1;
  }
}

hc_quest_bat_step02_wave_wait(var_0) {
  var_1 = level._id_A980 + 2;

  while(level._id_A980 <= var_1)
    wait 1;

  _id_0378::_id_8D74("smugglers_bat_stop_combat_loop");
  common_scripts\utility::flag_set(var_0);
}

hc_quest_bat_step02_jolt_drop_listen() {
  level.bat_hc_jolts_dropped = 0;
  var_0 = _getent("hc_bat_trig_use_jolt_drop", "script_noteworthy");

  while(!isDefined(level._id_8AD2))
    waitframe();

  while(level.bat_hc_jolts_dropped < 1500) {
    level waittill("spawned_money_share");

    foreach(var_2 in level._id_8AD2) {
      if(!var_0 _meth_858B(var_2.origin)) {
        continue;
      }
      var_3 = var_2._id_0117;
      var_4 = var_3 getentitynumber();
      level.bat_hc_jolts_dropped = level.bat_hc_jolts_dropped + 250;
      var_2 _id_0544::_id_8ADD(var_4, 0);
      var_2._id_6FD4 = 0;
      var_2._id_6FCB = 0;
      _iprintlnbold("You drop your jolts into the hole below!");
      var_3 _id_0367::_id_8E3D("hc_smuggler_weapon_given");
    }

    waitframe();
  }

  var_6 = _getent("hc_smuggler_drop_pod", "script_noteworthy");
  var_6 scriptmodelplayanim("s2_zom_drop_pod_open", "smuggler_drop_pod_open");
  _iprintlnbold("Danke! Come to my apartment");
  _id_0380::_id_6844("zmb_berl_gsmg_hc_smuggler_jolts_used", undefined, var_0);
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_jolts_complete");
}

hc_quest_bat_step02_cleanup() {}

hc_quest_bat_step03_handler() {
  wait(_randomfloatrange(27, 42));
  thread hc_quest_bat_step03_door_listen();
}

hc_quest_bat_step03_door_listen() {
  var_0 = _getent("hc_bat_dmg_trig_smuggler_door", "script_noteworthy");
  var_1 = 0;

  while(var_1 < 3) {
    var_0 waittill("trigger");
    var_1 = var_1 + 1;
    _id_0378::_id_8D74("smugglers_bat_door_pound", var_0.origin);
  }

  if(level.survivor_wep_is_pap)
    thread hc_quest_bat_step03_door_open_escaped();
  else
    thread hc_quest_bat_step03_door_open_follower();

  foreach(var_3 in level.players)
  var_3 thread hc_quest_bat_step03_vo_smuggler_room();

  var_5 = _getent("bat_pickup_trigger", "targetname");
  maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_5, "bat");
}

hc_quest_bat_step03_door_open_follower() {
  var_0 = _getent("hc_bat_smuggler_body", "script_noteworthy");
  var_0 show();
  var_1 = _getent("hc_bat_smuggler_bat", "script_noteworthy");
  var_1 show();
  var_2 = common_scripts\utility::_id_46B5("hc_bat_smuggler_door_follower_spawner", "targetname");
  var_3 = _id_054D::_id_90BA("zombie_heavy", var_2, "smuggler jumpscare", 0, 1, 1);
  var_4 = _getent("hc_bat_smuggler_door", "script_noteworthy");
  var_5 = _getent("hc_bat_smuggler_door_clip", "script_noteworthy");
  var_5 notsolid();
  var_5 connectpaths();
  var_5 solid();
  _id_0378::_id_8D74("smugglers_bat_door_break_down", var_4.origin);
  var_4 rotateroll(-90, 0.25);
  var_4 movez(2, 0.05);
  var_5 movex(100, 0.25);
  wait 0.5;
  var_5 movex(-100, 0.1);
  var_5 delete();
}

hc_quest_bat_step03_door_open_escaped() {
  var_0 = _getent("hc_bat_follower_body", "script_noteworthy");
  var_0 show();
  var_1 = _getent("hc_bat_follower_bat", "script_noteworthy");
  var_1 show();
  var_2 = _getent("hc_bat_smuggler_door", "script_noteworthy");
  var_3 = _getent("hc_bat_smuggler_door_clip", "script_noteworthy");
  _id_0378::_id_8D74("smugglers_bat_door_open_squeaky", var_2.origin);
  var_2 rotateyaw(120, 2, 0.8, 0.4);
  var_3 notsolid();
  var_3 connectpaths();
  var_4 = getEntArray("hc_bat_smuggler_door_escape", "script_noteworthy");

  foreach(var_6 in var_4)
  var_6.angles = var_6.angles - (0, 15, 0);
}

hc_quest_bat_step03_vo_smuggler_room() {
  var_0 = _getent("bat_pickup_trigger", "targetname");

  for(;;) {
    if(distance(self.origin, var_0.origin) < 100) {
      if(level.survivor_wep_is_pap) {} else {
        _id_0367::_id_8E3D("hc_smuggler_dead_found");
        break;
      }
    }

    wait 1;
  }
}

hc_quest_bat_step03_cleanup() {}

hc_quest_bat_debug_start() {
  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;

  if(!isDefined(level.radio_code_left))
    level.radio_code_left = 20;

  if(!isDefined(level.radio_code_right))
    level.radio_code_right = 11;
}

hc_quest_bat_debug_skip_step01() {
  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_contact_survivor_complete");
}

hc_quest_bat_debug_skip_step02_drop_gun() {
  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_weapon_complete");
  level.survivor_wep_is_pap = 0;
}

hc_quest_bat_debug_skip_step02() {
  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_jolts_complete");
  level.survivor_wep_is_pap = 0;
}

hc_quest_bat_debug_skip_step02_alt() {
  if(!isDefined(level.tuner_values))
    level.tuner_values = [];

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::flag_set("flag_hc_quest_bat_step02_give_jolts_complete");
  level.survivor_wep_is_pap = 1;
}

_____________________dagger_____________________() {}

hc_quest_dagger_init() {
  common_scripts\utility::flag_init("flag_hc_quest_dagger_step01_film_reel_complete");
  common_scripts\utility::flag_init("apartment_dagger_painting_found");
  common_scripts\utility::flag_init("flag_hc_quest_dagger_step01_painting_complete");
  common_scripts\utility::flag_init("flag_hc_quest_dagger_step01_projector_on_complete");
  common_scripts\utility::flag_init("flag_hc_quest_dagger_step02_soul_collection_complete");
  common_scripts\utility::flag_init("flag_hc_quest_dagger_step03_safe_opened");
  hc_quest_dagger_logic();
}

hc_quest_dagger_logic() {
  hc_quest_dagger_step01_handler();
  hc_quest_dagger_step03_handler();
}

hc_quest_dagger_step01_handler() {
  thread hc_quest_dagger_step01_turn_on_projection();
  thread hc_quest_dagger_step01_film_reel();
  thread hc_quest_dagger_step01_painting();
  thread hc_quest_dagger_step01_turn_on_projector();
  thread hc_quest_dagger_step03_safe_think();
  common_scripts\utility::_id_3CA0("flag_hc_quest_dagger_step01_film_reel_complete", "flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete");
  thread hc_quest_dagger_step01_cleanup();
}

hc_quest_dagger_step01_film_reel() {
  var_0 = _getent("film_final_location", "targetname");
  var_1 = _getent("film_start_location", "targetname");
  var_2 = _getent("film_placed", "targetname");
  var_3 = _getent("film_pickup_trigger", "targetname");
  var_4 = _getent("projector_use_trig", "targetname");
  var_5 = _getent("projector", "targetname");
  var_6 = _getent("projector_full", "targetname");
  var_0 hide();
  var_2 hide();
  var_6 hide();
  var_1 setcandamage(1);
  var_1 waittill("damage");
  _id_0378::_id_8D74("ddagger_film_canister_fall", var_1);
  var_7 = var_0.origin - var_1.origin;
  var_8 = _sqrt(_abs(var_7[2] * 2 / 800));
  var_9 = 1 / var_8;
  var_10 = var_7 * (var_9, var_9, 0);
  var_1 movegravity(var_10, var_8);
  var_1 rotateto(var_0.angles, var_8);
  wait(var_8);
  var_1.origin = var_0.origin;
  var_1 delete();
  var_0 show();
  var_3 waittill("trigger");
  var_3 delete();
  _id_0378::_id_8D74("ddagger_film_canister_pickup", var_0);
  var_0 delete();
  var_4 waittill("trigger");
  var_2 show();
  var_6 show();
  var_5 delete();
  _id_0378::_id_8D74("ddagger_projector_attach_reel", var_6.origin);
  common_scripts\utility::flag_set("flag_hc_quest_dagger_step01_film_reel_complete");

  if(common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step01_projector_on_complete"))
    hc_quest_dagger_step02_handler();
}

hc_quest_dagger_step01_painting() {
  var_0 = getEntArray("cabaret_dagger_painting", "targetname");
  var_1 = hc_quest_dagger_step01_painting_get_org(var_0);

  foreach(var_3 in var_0) {
    if(var_3 != var_1)
      var_3 hide();
  }

  var_5 = _getent("apartment_dagger_painting_trig", "targetname");
  var_5 waittill("trigger");
  var_5 delete();
  common_scripts\utility::flag_set("apartment_dagger_painting_found");
  _id_054D::giveplayersexp("berlin_exp_ref_1");
  var_6 = getEntArray("apartment_dagger_painting", "targetname");
  var_7 = hc_quest_dagger_step01_painting_get_org(var_6);
  _id_0378::_id_8D74("ddagger_picture_remove", var_7.origin);
  hc_quest_dagger_step01_painting_apartment_cleanup(var_6);
  var_8 = _getent("projector_use_trig", "targetname");
  var_8 waittill("trigger", var_9);
  _id_0378::_id_8D74("ddagger_picture_placement", var_1.origin);
  hc_quest_dagger_step01_painting_place_on_projector(var_0, var_1);
  common_scripts\utility::flag_set("flag_hc_quest_dagger_step01_painting_complete");
}

hc_quest_dagger_step01_painting_get_org(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.classname == "script_origin") {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

hc_quest_dagger_step01_painting_apartment_cleanup(var_0) {
  foreach(var_2 in var_0)
  var_2 delete();
}

hc_quest_dagger_step01_painting_place_on_projector(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3.classname != "script_origin") {
      var_3 show();
      var_3 linktosynchronizedparent(var_1);
    }
  }

  var_5 = _getent("painting_end_org", "targetname");
  var_1 moveto(var_5.origin, 2, 1, 1);
  var_1 rotateto(var_5.angles, 2, 1, 1);
}

hc_quest_dagger_step01_turn_on_projector() {
  var_0 = _getent("projector_damage_trig", "targetname");
  var_0 setcontents(var_0 _meth_85A0() | 256);

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(var_10 == "wunderbuss_zm") {
      break;
    } else
      waitframe();
  }

  level childthread common_scripts\_exploder::_id_088E(204);
  var_11 = _getent("projector", "targetname");
  var_12 = _getent("projector_full", "targetname");

  if(isDefined(var_11))
    var_11 scriptmodelplayanimdeltamotion("hub_movie_projector_anim_01");

  var_12 scriptmodelplayanimdeltamotion("hub_movie_projector_anim_01");
  _id_0378::_id_8D74("ddagger_projector_on", var_12.origin);
  common_scripts\utility::flag_set("flag_hc_quest_dagger_step01_projector_on_complete");

  if(common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step01_film_reel_complete"))
    hc_quest_dagger_step02_handler();
}

hc_quest_dagger_step01_turn_on_projection() {
  var_0 = _getent("map_projection", "targetname");
  var_0 hide();
  common_scripts\utility::_id_3CA0("flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete");
  level notify("suspend_node_vfx");
  _id_054D::giveplayersexp("berlin_exp_ref_15");
  wait 1.75;
  var_0 show();
  level notify("resume_node_vfx");
}

hc_quest_dagger_step01_cleanup() {
  var_0 = _getent("projector_use_trig", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

hc_quest_dagger_step02_handler() {
  thread hc_quest_dagger_step02_collection_think();
  common_scripts\utility::_id_3C9F("flag_hc_quest_dagger_step02_soul_collection_complete");
  thread hc_quest_dagger_step02_cleanup();
}

hc_quest_dagger_step02_collection_think() {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_0 = common_scripts\utility::_id_46B7("hc_quest_dagger_soulbucket_map_node", "targetname");
  level.safe_combination = [];
  var_1 = hc_quest_dagger_step02_get_random_collection_nodes(var_0);
  level.current_bucket_node = undefined;

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step03_safe_opened")) {
    for(var_2 = 0; var_2 < 4; var_2++) {
      level.current_bucket_node = var_1[var_2];
      hc_quest_dagger_step02_waitfor_node_collection_complete(var_1[var_2]);
    }

    common_scripts\utility::flag_set("flag_hc_quest_dagger_step02_soul_collection_complete");
  }
}

hc_quest_dagger_step02_get_random_collection_nodes(var_0, var_1) {
  var_0 = common_scripts\utility::array_randomize(var_0);
  var_2 = [];
  var_3 = undefined;
  var_4 = undefined;

  if(!isDefined(var_1))
    var_1 = 4;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_2[var_5] = var_0[var_5];
    var_4 = _randomintrange(4, 10);

    if(isDefined(var_3) && var_4 == var_3)
      var_4 = var_4 - 1;

    var_3 = var_4;
    var_2[var_5].value = var_4;
    var_2[var_5].collection_radius = 192;
    level.safe_combination[var_5] = var_2[var_5].value;
  }

  return var_2;
}

hc_quest_dagger_step02_waitfor_node_collection_complete(var_0) {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_1 = common_scripts\utility::_id_46B5(var_0._id_0165, "targetname");

  if(!isDefined(var_0.tag_org)) {
    var_0.tag_org = spawn("script_model", var_0.origin);
    var_0.tag_org setModel("tag_origin");
  }

  _playfxontag(level._effect["projection_light"], var_0.tag_org, "tag_origin");

  if(!common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step01_painting_complete"))
    thread hc_quest_dagger_step02_waitfor_node_collection_suspend(var_0);

  if(!common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step01_projector_on_complete"))
    common_scripts\utility::_id_3C9F("flag_hc_quest_dagger_step01_projector_on_complete");

  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_1 thread hc_quest_dagger_step02_waitfor_node_collection_additional_fx(var_2);

  if(isDefined(var_1.radius))
    var_0.collection_radius = var_1.radius;

  var_2.ignoresighttrace = 1;
  var_2 maps\mp\mp_zombies_soul_collection::_id_170B(var_0.value, var_0.collection_radius, var_0.collection_radius, "zmb_dagger_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_1 notify("stop_monitoring_collection");
  var_2 common_scripts\utility::_id_2CBE(2, ::delete);
  _killfxontag(level._effect["projection_light"], var_0.tag_org, "tag_origin");
}

hc_quest_dagger_step02_waitfor_node_collection_additional_fx(var_0) {
  self endon("stop_monitoring_collection");

  for(;;) {
    level waittill("zmb_dagger_collection_kill", var_1);

    if(var_1 == self)
      _playfxontag(level._effect["zmb_hc_bucket_indic"], var_0, "tag_origin");

    waitframe();
  }
}

hc_quest_dagger_step02_waitfor_node_collection_suspend(var_0) {
  level waittill("suspend_node_vfx");
  _killfxontag(level._effect["projection_light"], var_0.tag_org, "tag_origin");
  level waittill("resume_node_vfx");
  _playfxontag(level._effect["projection_light"], var_0.tag_org, "tag_origin");
}

hc_quest_dagger_step02_cleanup() {
  common_scripts\utility::_id_3C9F("flag_hc_quest_dagger_step03_safe_opened");

  if(isDefined(level.current_bucket_node) && isDefined(level.current_bucket_node.tag_org))
    _killfxontag(level._effect["projection_light"], level.current_bucket_node.tag_org, "tag_origin");
}

hc_quest_dagger_step03_handler() {
  common_scripts\utility::_id_3C9F("flag_hc_quest_dagger_step03_safe_opened");
  thread hc_quest_dagger_step03_safe_open();
  thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(level.safe_use_trig, "dagger");
  hc_quest_dagger_step03_cleanup();
}

hc_quest_dagger_step03_safe_think() {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_0 = getEntArray("dagger_safe", "targetname");
  level.safe_use_trig = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  level.dagger_safe_knob = undefined;

  foreach(var_5 in var_0) {
    switch (var_5.setlookatent) {
      case "safe_link_org":
        var_2 = var_5;
        break;
      case "safe_player_org":
        var_1 = var_5;
        break;
      case "safe_use_trig":
        level.safe_use_trig = var_5;
        break;
      case "safe_knob":
        var_3 = var_5;
        break;
      case "safe_knob_origin":
        level.dagger_safe_knob = var_5;
        break;
      case "safe_model":
        level.dagger_safe = var_5;
        break;
      default:
        break;
    }
  }

  var_3 linktosynchronizedparent(level.dagger_safe_knob);
  level.correct_safe_combo_used = 0;
  level.final_number = 0;

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_dagger_step03_safe_opened") && (!level.correct_safe_combo_used || !level.final_number)) {
    level.safe_use_trig waittill("trigger", var_7);

    if(var_7 isjumping() || var_7 _meth_82E5()) {
      continue;
    }
    var_8 = var_7;
    var_8 disableweapons();

    if(var_8 getstance() != "stand") {
      var_8 setstance("stand");
      wait 0.7;
    }

    var_8 _meth_812C(0);
    var_9 = var_7.origin;
    var_10 = var_7.angles;
    var_1.origin = var_9;
    var_1.angles = var_10;
    var_8 playerlinkto(var_1, undefined, 0.1, 0, 0, 0, 0);
    var_1 moveto(var_2.origin, 0.5, 0, 0);
    var_1 rotateto(var_2.angles, 0.5, 0, 0);
    wait 0.5;
    var_8 thread hc_quest_dagger_step03_safe_attempt_unlock();
    var_8 waittill("stop_using_station");

    if(level.final_number && level.correct_safe_combo_used)
      self notify("safe_code_correct");

    var_8 enableweapons();
    var_1 moveto(var_9 + (0, 0, 1), 0.5);
    var_1 rotateto(var_10, 0.5);
    wait 0.5;
    var_8 unlink();
    var_8 _meth_812C(1);
    var_8 setstance("stand");
    wait 0.5;
  }

  common_scripts\utility::flag_set("flag_hc_quest_dagger_step03_safe_opened");
}

hc_quest_dagger_step03_safe_attempt_unlock() {
  self endon("stop_using_station");
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_death();
  var_0 = common_scripts\utility::_id_55E0();
  var_1 = var_0;
  var_2 = !var_0;
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_unuse(level.safe_use_trig, var_1, var_2);

  if(!isDefined(level.safe_combination) || level.safe_combination.size < 4)
    hc_quest_dagger_step03_safe_fake_input();

  level.correct_safe_combo_used = 0;
  level.final_number = 0;

  while(!level.correct_safe_combo_used) {
    level.correct_safe_combo_used = hc_quest_dagger_step03_safe_waitfor_input_outcome(level.safe_combination[0], "right");

    if(!level.correct_safe_combo_used) {
      hc_quest_dagger_step03_safe_waitfor_direction_rotation("right");
      continue;
    }

    level.correct_safe_combo_used = hc_quest_dagger_step03_safe_waitfor_input_outcome(level.safe_combination[1], "left");

    if(!level.correct_safe_combo_used) {
      hc_quest_dagger_step03_safe_waitfor_direction_rotation("left");
      continue;
    }

    level.correct_safe_combo_used = hc_quest_dagger_step03_safe_waitfor_input_outcome(level.safe_combination[2], "right");

    if(!level.correct_safe_combo_used) {
      hc_quest_dagger_step03_safe_waitfor_direction_rotation("right");
      continue;
    }

    level.correct_safe_combo_used = 0;
    level.final_number = 1;
    level.correct_safe_combo_used = hc_quest_dagger_step03_safe_waitfor_input_outcome(level.safe_combination[3], "left", 1);

    if(!level.correct_safe_combo_used) {
      level.final_number = 0;
      hc_quest_dagger_step03_safe_waitfor_direction_rotation("left");
      continue;
    }
  }
}

hc_quest_dagger_safe_reset_input_difference() {
  if(common_scripts\utility::_id_55E0())
    hc_quest_dagger_safe_reset_input_difference_gamepad();
}

hc_quest_dagger_safe_get_input_difference() {
  if(common_scripts\utility::_id_55E0())
    return hc_quest_dagger_safe_get_next_input_difference_gamepad();
  else
    return hc_quest_dagger_safe_get_input_difference_pc();
}

hc_quest_dagger_safe_get_input_difference_pc() {
  var_0 = self getnormalizedmovement();
  var_1 = var_0[1];
  var_2 = 0.125;

  if(self sprintbuttonpressed())
    var_2 = var_2 * 6.0;

  return var_2 * var_1;
}

hc_quest_dagger_safe_reset_input_difference_gamepad() {
  self.safe_previous_stick_input = self getnormalizedmovement();
}

hc_quest_dagger_safe_get_next_input_difference_gamepad() {
  var_0 = self getnormalizedmovement();

  if(_abs(var_0[0]) < 0.99 && _abs(var_0[1]) < 0.99) {
    self.safe_previous_stick_input = (0, 0, 0);
    return 0;
  }

  if(self.safe_previous_stick_input == (0, 0, 0) || var_0 == (0, 0, 0)) {
    self.safe_previous_stick_input = var_0;
    return 0;
  }

  var_1 = hc_quest_dagger_step03_safe_get_input(self.safe_previous_stick_input, var_0);
  self.safe_previous_stick_input = var_0;

  if(!isDefined(var_1))
    return 0;

  return var_1;
}

hc_quest_dagger_step03_safe_fake_input() {
  self endon("stop_using_station");
  var_0 = undefined;
  hc_quest_dagger_safe_reset_input_difference();

  while(!isDefined(level.safe_combination) || level.safe_combination.size < 4) {
    waitframe();
    var_1 = hc_quest_dagger_safe_get_input_difference();

    if(!isDefined(var_1) || var_1 == 0) {
      continue;
    }
    var_0 = hc_quest_dagger_step03_safe_update_dial(var_1);
  }
}

hc_quest_dagger_step03_safe_waitfor_input_outcome(var_0, var_1, var_2) {
  self endon("stop_using_station");
  var_3 = undefined;
  var_4 = 1;
  var_5 = 0;
  var_6 = 1;
  hc_quest_dagger_safe_reset_input_difference();

  while(var_4 || isDefined(var_2) && var_2) {
    waitframe();
    var_7 = hc_quest_dagger_safe_get_input_difference();
    var_3 = hc_quest_dagger_step03_safe_update_dial(var_7, var_0);

    if(isDefined(var_2) && var_2) {
      if(var_3 == var_0)
        level.correct_safe_combo_used = 1;
      else
        level.correct_safe_combo_used = 0;
    }

    if(var_1 == "left" && var_7 > 0 || var_1 == "right" && var_7 < 0) {
      var_4 = 0;

      if(var_5 < var_6) {
        var_5++;
        var_4 = 1;
      }

      continue;
    }

    var_5 = 0;
  }

  return isDefined(var_3) && var_3 == var_0;
}

hc_quest_dagger_step03_safe_waitfor_direction_rotation(var_0) {
  self endon("stop_using_station");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  hc_quest_dagger_safe_reset_input_difference();

  while(!var_1) {
    waitframe();
    var_4 = hc_quest_dagger_safe_get_input_difference();
    var_5 = hc_quest_dagger_step03_safe_update_dial(var_4);

    if(var_0 == "left" && var_4 < 0 || var_0 == "right" && var_4 > 0) {
      var_1 = 1;

      if(var_2 < var_3) {
        var_2++;
        var_1 = 0;
      }
    }
  }
}

hc_quest_dagger_step03_safe_get_input(var_0, var_1) {
  self endon("stop_using_station");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;

  if(var_1[0] > 0 && var_1[1] > 0) {
    var_3 = 1;

    if(var_0[0] > var_1[0])
      var_2 = 1;
    else if(var_0[1] < var_1[1])
      var_2 = 1;

    if(var_0 != var_1 && !isDefined(var_2))
      var_2 = 0;

    var_5 = _abs(var_0[0] - var_1[0]);
    var_6 = _abs(var_0[1] - var_1[1]);
    var_4 = var_5 + var_6;
  } else if(var_1[0] < 0 && var_1[1] > 0) {
    var_3 = 2;

    if(var_0[0] > var_1[0])
      var_2 = 1;
    else if(var_0[1] > var_1[1])
      var_2 = 1;

    if(var_0 != var_1 && !isDefined(var_2))
      var_2 = 0;

    var_5 = _abs(var_0[0] - var_1[0]);
    var_6 = _abs(var_0[1] - var_1[1]);
    var_4 = var_5 + var_6;
  } else if(var_1[0] < 0 && var_1[1] < 0) {
    var_3 = 3;

    if(var_0[0] < var_1[0])
      var_2 = 1;
    else if(var_0[1] > var_1[1])
      var_2 = 1;

    if(var_0 != var_1 && !isDefined(var_2))
      var_2 = 0;

    var_5 = _abs(var_0[0] - var_1[0]);
    var_6 = _abs(var_0[1] - var_1[1]);
    var_4 = var_5 + var_6;
  } else if(var_1[0] > 0 && var_1[1] < 0) {
    var_3 = 4;

    if(var_0[0] < var_1[0])
      var_2 = 1;
    else if(var_0[1] < var_1[1])
      var_2 = 1;

    if(var_0 != var_1 && !isDefined(var_2))
      var_2 = 0;

    var_5 = _abs(var_0[0] - var_1[0]);
    var_6 = _abs(var_0[1] - var_1[1]);
    var_4 = var_5 + var_6;
  }

  if(isDefined(var_3)) {
    if(var_0[0] > 0 && var_0[1] > 0) {
      if(var_3 == 4)
        var_2 = 0;
    } else if(var_0[0] < 0 && var_0[1] > 0) {
      if(var_3 == 1)
        var_2 = 0;
    } else if(var_0[0] < 0 && var_0[1] < 0) {
      if(var_3 == 2)
        var_2 = 0;
    } else if(var_0[0] > 0 && var_0[1] < 0) {
      if(var_3 == 3)
        var_2 = 0;
    }
  }

  if(!isDefined(var_2))
    return undefined;
  else if(var_2)
    return var_4;
  else
    return var_4 * -1;
}

hc_quest_dagger_step03_safe_update_dial(var_0, var_1) {
  self endon("stop_using_station");
  var_2 = undefined;

  if(!isDefined(level.tick_sound_offset))
    level.tick_sound_offset = 0;

  var_3 = 12;
  var_4 = 10;
  var_5 = 360 / var_4;
  var_6 = 5;
  var_7 = 0;
  var_8 = 0;
  var_9 = 18;
  var_8 = _angleclamp(level.dagger_safe_knob.angles[2] - var_0 * 10);
  level.dagger_safe_knob.angles = (level.dagger_safe_knob.angles[0], level.dagger_safe_knob.angles[1], var_8);
  var_10 = (var_7 + var_8) % var_5 - var_9;
  level.anglerem = var_10;

  if(var_10 < var_3)
    var_2 = int(var_8 / 360 * 10) % var_4;

  if(isDefined(var_2))
    var_2 = (var_2 + var_6) % var_4;

  if(!isDefined(var_2))
    var_2 = -1;

  level.tick_sound_offset = level.tick_sound_offset + var_0;

  if(_abs(level.tick_sound_offset) >= 1) {
    _id_0378::_id_8D74("ddagger_vault_tick", level.dagger_safe_knob.origin);
    level.tick_sound_offset = 0;
  }

  return var_2;
}

#using_animtree("animated_props_zombies_DLC2");

hc_quest_dagger_step03_safe_open() {
  level.dagger_safe_knob common_scripts\utility::_id_2CBE(1, ::linktosynchronizedparent, level.dagger_safe, "handle");
  level.dagger_safe scriptmodelplayanimdeltamotionfrompos("s2_zom_safe_open", level.dagger_safe.origin, level.dagger_safe.angles);
  maps\mp\_utility::_id_2CED(0.5, _id_0378::_id_8D74, "ddagger_vault_handle_open", level.dagger_safe_knob.origin);
  maps\mp\_utility::_id_2CED(2.25, _id_0378::_id_8D74, "ddagger_vault_door_open", level.dagger_safe.origin);
  wait(_getanimlength(%s2_zom_safe_open));
  level.dagger_safe scriptmodelplayanimdeltamotionfrompos("s2_zom_safe_open_idle", level.dagger_safe.origin, level.dagger_safe.angles);
  wait 3;

  foreach(var_1 in level.players) {
    if(distance(var_1.origin, level.dagger_safe.origin) < 200)
      var_1 _id_0367::_id_8E3D("hc_dagger_reveal");
  }
}

hc_quest_dagger_step03_cleanup() {}

_____________________axe_______________________() {}

hc_quest_axe_init() {
  common_scripts\utility::flag_init("flag_hc_quest_axe_step01_radio_station_found");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step01_map_pin_found");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step01_map_location_found");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step02_obtained_scale_cup");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step02_placed_scale_cup");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_carrying_fodder_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_carrying_pest_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_carrying_sizzler_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_placed_fodder_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_placed_pest_armored_head");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_placed_another_thing");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step04_opened_museum_compartment");
  common_scripts\utility::flag_init("flag_hc_quest_axe_step04_obtained_axe");
  var_0 = _getent("hc_ee_axe_scale_sizzler_head", "script_noteworthy");
  var_1 = _getent("hc_ee_axe_scale_cup", "script_noteworthy");
  var_2 = _getent("hc_ee_axe_scale_cup_church", "script_noteworthy");
  var_3 = _getent("hc_ee_axe_scale_needle", "script_noteworthy");
  var_4 = _getent("map_board_mover_selector", "script_noteworthy");
  var_0 hide();
  var_1 hide();
  var_4 hide();
  var_3 rotatepitch(30, 1, 0.25, 0.25);
  var_5 = getEntArray("hc_ee_axe_radiocode_0_a", "script_noteworthy");
  var_6 = getEntArray("hc_ee_axe_radiocode_0_b", "script_noteworthy");
  var_7 = getEntArray("hc_ee_axe_radiocode_1_a", "script_noteworthy");
  var_8 = getEntArray("hc_ee_axe_radiocode_1_b", "script_noteworthy");
  var_9 = getEntArray("hc_ee_axe_radiocode_2_a", "script_noteworthy");
  var_10 = getEntArray("hc_ee_axe_radiocode_2_b", "script_noteworthy");
  var_11 = common_scripts\utility::_id_0F8C(var_5, var_6);
  var_12 = common_scripts\utility::_id_0F8C(var_7, var_8);
  var_13 = common_scripts\utility::_id_0F8C(var_9, var_10);
  var_14 = common_scripts\utility::_id_0F8C(var_11, var_12);
  var_15 = common_scripts\utility::_id_0F8C(var_14, var_13);

  foreach(var_17 in var_15)
  var_17 hide();

  var_19 = 29;
  var_20 = 89;
  var_21 = 15;
  var_22 = 12;
  var_23 = randomint(3);

  switch (var_23) {
    case 0:
      var_19 = 20.3;
      var_20 = 66.8;
      randomize_code_hint_location(var_23, var_5, var_6);

      foreach(var_17 in var_12)
      var_17 delete();

      foreach(var_17 in var_13)
      var_17 delete();

      break;
    case 1:
      var_19 = 38.9;
      var_20 = 82.4;
      randomize_code_hint_location(var_23, var_7, var_8);

      foreach(var_17 in var_11)
      var_17 delete();

      foreach(var_17 in var_13)
      var_17 delete();

      break;
    case 2:
      var_19 = 56.1;
      var_20 = 82.4;
      randomize_code_hint_location(var_23, var_9, var_10);

      foreach(var_17 in var_11)
      var_17 delete();

      foreach(var_17 in var_12)
      var_17 delete();

      break;
    default:
      break;
  }

  var_36 = randomint(5);

  switch (var_36) {
    case 0:
      var_22 = 12;
      var_21 = 15;
      break;
    case 1:
      var_22 = 18;
      var_21 = 5;
      break;
    case 2:
      var_22 = 10;
      var_21 = 8;
      break;
    case 3:
      var_22 = 19;
      var_21 = 21;
      break;
    case 4:
      var_22 = 8;
      var_21 = 11;
      break;
    default:
      break;
  }

  level thread hc_quest_axe_map_pin_found(var_4);
  level.bat_hc_radio_code_left = var_19;
  level.bat_hc_radio_code_right = var_20;
  level thread quest_step_use_radio_codes_listener(var_20, var_19, var_36);
  common_scripts\utility::_id_3C9F("flag_hc_quest_axe_step01_map_pin_found");
  level thread map_board_think();
  level thread hc_quest_axe_map_board_check_solution(var_21, var_22);
  level thread hc_quest_axe_find_scale_pickup(var_2);
  level thread hc_quest_axe_placed_scale_in_museum(var_0, var_1, var_3);
  common_scripts\utility::_id_3C9F("flag_hc_quest_axe_step02_placed_scale_cup");
  level thread hc_quest_axe_sizzler_kill_init();
  level thread hc_quest_axe_enemykilled_sizzlerneararmor();
}

randomize_code_hint_location(var_0, var_1, var_2) {
  var_3 = randomint(2);

  switch (var_3) {
    case 0:
      foreach(var_5 in var_1)
      var_5 show();

      foreach(var_5 in var_2)
      var_5 delete();

      break;
    case 1:
      foreach(var_5 in var_2)
      var_5 show();

      foreach(var_5 in var_1)
      var_5 delete();

      break;
    default:
      break;
  }
}

quest_step_use_radio_codes_listener(var_0, var_1, var_2) {
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("quest_contact_hq", "step_use_radio"));
  var_3 = 0;

  while(!var_3) {
    while(!maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(var_0, "right") || !maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(var_1, "left"))
      waitframe();

    var_4 = 2500;
    var_5 = gettime();
    var_6 = 0;

    while(var_4 > var_6) {
      if(maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(var_0, "right") && maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(var_1, "left")) {
        var_6 = gettime() - var_5;

        if(var_4 <= var_6) {
          var_3 = 1;
          break;
        }
      }

      waitframe();
    }
  }

  if(!isDefined(level.possible_radio_codes))
    level.possible_radio_codes = [];

  var_7 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_7] = [];
  level.possible_radio_codes[var_7]["left"] = var_1;
  level.possible_radio_codes[var_7]["right"] = var_0;
  thread maps\mp\mp_zombie_berlin_utils::radio_system_suspend_tuning_for_response();

  switch (var_2) {
    case 0:
      _id_0378::_id_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_12_15");
      break;
    case 1:
      _id_0378::_id_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_18_5");
      break;
    case 2:
      _id_0378::_id_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_10_8");
      break;
    case 3:
      _id_0378::_id_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_19_21");
      break;
    case 4:
      _id_0378::_id_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_8_11");
      break;
    default:
      break;
  }
}

map_board_think() {
  var_0 = getEntArray("berlin_map_board", "targetname");
  common_scripts\utility::flag_init("map_interaction_disabled");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  level.mapboard_pos = [1, 1];
  var_4 = _getent("map_board_mover_selector", "script_noteworthy");
  level.map_start_pos = common_scripts\utility::_id_46B5("map_board_start_pos", "script_noteworthy");

  foreach(var_6 in var_0) {
    if(isDefined(var_6.setlookatent)) {
      switch (var_6.setlookatent) {
        case "map_board_link_org":
          var_3 = var_6;
          break;
        case "map_board_player_org":
          var_2 = var_6;
          break;
        case "map_board_use_trig":
          var_1 = var_6;
          break;
        default:
          break;
      }
    }
  }

  while(!common_scripts\utility::_id_3C77("map_interaction_disabled")) {
    var_1 waittill("trigger", var_8);

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
    var_2.origin = var_10;
    var_2.angles = var_11;
    var_9 playerlinkto(var_2, undefined, 0.1, 0, 0, 0, 0);
    var_2 moveto(var_3.origin, 0.5, 0, 0);
    var_2 rotateto(var_3.angles, 0.5, 0, 0);
    wait 0.5;
    var_9 thread map_board_start_moving(var_1);
    var_9 waittill("stop_using_station");
    level notify("stop_using_mapboard");
    var_9 enableweapons();
    var_2 moveto(var_10 + (0, 0, 1), 0.5);
    var_2 rotateto(var_11, 0.5);
    wait 0.5;
    var_9 unlink();
    var_9 _meth_812C(1);
    var_9 setstance("stand");
    wait 0.5;
  }
}

map_board_start_moving(var_0) {
  self endon("stop_using_station");
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_death();
  var_1 = common_scripts\utility::_id_55E0();
  var_2 = var_1;
  var_3 = !var_1;
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_unuse(var_0, var_2, var_3);
  map_board_handle_inputs();
}

map_board_handle_inputs() {
  self endon("stop_using_station");
  level endon("map_interaction_disabled");
  var_0 = [0, 0, 0];
  var_1 = [0, 0, 0];

  for(;;) {
    var_0 = self getnormalizedmovement();

    if(_abs(var_0[0]) > _abs(var_0[1]))
      var_0 = (var_0[0], 0, 0);
    else if(_abs(var_0[1]) > _abs(var_0[0]))
      var_0 = (0, var_0[1], 0);

    if(var_0[0] != 0 || var_0[1] != 0) {
      map_board_update_mover(var_0);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

map_board_update_mover(var_0) {
  var_1 = self.origin;
  var_2 = var_1;
  var_3 = _getent("map_board_mover_selector", "script_noteworthy");
  var_3 map_board_send_mover_to_offsets(var_0[0], var_0[1]);
}

map_board_send_mover_to_offsets(var_0, var_1) {
  var_2 = self.origin;

  if(var_0 > 0.8 && level.mapboard_pos[0] > 1) {
    level.mapboard_pos[0] = level.mapboard_pos[0] - 1;
    var_2 = self.origin + (0, 0, 2);
  }

  if(var_0 < -0.8 && level.mapboard_pos[0] < 25) {
    level.mapboard_pos[0] = level.mapboard_pos[0] + 1;
    var_2 = self.origin - (0, 0, 2);
  }

  if(var_1 < -0.8 && level.mapboard_pos[1] > 1) {
    level.mapboard_pos[1] = level.mapboard_pos[1] - 1;
    var_2 = self.origin + (0, 2, 0);
  }

  if(var_1 > 0.8 && level.mapboard_pos[1] < 25) {
    level.mapboard_pos[1] = level.mapboard_pos[1] + 1;
    var_2 = self.origin - (0, 2, 0);
  }

  self.origin = var_2;
}

hc_quest_axe_map_board_check_solution(var_0, var_1) {
  while(!common_scripts\utility::_id_3C77("flag_hc_quest_axe_step01_map_location_found")) {
    level waittill("stop_using_mapboard");

    if(level.mapboard_pos[0] == var_0 && level.mapboard_pos[1] == var_1) {
      common_scripts\utility::flag_set("flag_hc_quest_axe_step01_map_location_found");
      _iprintlnbold("You done it!");
      wait 0.5;
      var_2 = _getent("mapboard_lockbox_door", "script_noteworthy");
      var_2 _id_0378::_id_8D74("aud_axe_hc_amoire_open");
      var_2 rotateyaw(42, 1, 0.25, 0.25);
    }
  }
}

hc_quest_axe_find_scale_pickup(var_0) {
  var_1 = _getent("map_board_take_scale", "script_noteworthy");

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_axe_step02_obtained_scale_cup")) {
    var_1 waittill("trigger", var_2);

    if(common_scripts\utility::_id_3C77("flag_hc_quest_axe_step01_map_location_found")) {
      common_scripts\utility::flag_set("flag_hc_quest_axe_step02_obtained_scale_cup");
      _id_0378::_id_8D74("aud_axe_hc_pickup_scale", var_0.origin);
      _iprintlnbold("You got the golden scale cup!");
      var_0 delete();
    }

    wait 0.5;
  }

  _id_054D::giveplayersexp("berlin_exp_ref_13");
  var_1 delete();
}

hc_quest_axe_placed_scale_in_museum(var_0, var_1, var_2) {
  var_3 = _getent("scale_use", "script_noteworthy");

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_axe_step02_placed_scale_cup")) {
    var_3 waittill("trigger", var_4);

    if(common_scripts\utility::_id_3C77("flag_hc_quest_axe_step02_obtained_scale_cup")) {
      common_scripts\utility::flag_set("flag_hc_quest_axe_step02_placed_scale_cup");
      _iprintlnbold("You returned the golden scale cup to its rightful location.");
      _id_0378::_id_8D74("aud_axe_hc_place_scale_piece", var_1);
      var_1 show();
      var_2 rotatepitch(-5, 1, 0.25, 0.25);
    }

    wait 0.5;
  }

  while(!common_scripts\utility::_id_3C77("flag_hc_quest_axe_step03_placed_sizzler_armored_head")) {
    var_3 waittill("trigger", var_4);

    if(isDefined(level.hc_axe_ee_head_carried)) {
      switch (level.hc_axe_ee_head_carried) {
        case "flag_hc_quest_axe_step03_carrying_sizzler_armored_head":
          common_scripts\utility::flag_set("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
          _iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          _id_0378::_id_8D74("aud_axe_hc_place_head", var_0);
          var_0 show();
          var_2 rotatepitch(-25, 1, 0.25, 0.25);

          if(var_0.model != "zom_sizzler_head_gib")
            var_0 setModel("zom_sizzler_head_gib");

          break;
        case "flag_hc_quest_axe_step03_carrying_fodder_armored_head":
          common_scripts\utility::flag_set("flag_hc_quest_axe_step03_placed_fodder_armored_head");
          _iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          var_0 show();
          var_0 setModel("zom_ger_head_fdr_03_gib");
          var_2 rotatepitch(-15, 1, 0.25, 0.25);
          break;
        case "flag_hc_quest_axe_step03_carrying_pest_armored_head":
          common_scripts\utility::flag_set("flag_hc_quest_axe_step03_placed_pest_armored_head");
          _iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          var_0 show();
          var_0 setModel("zom_ger_head_spr_01_gib");
          var_2 rotatepitch(-10, 1, 0.25, 0.25);
          break;
        default:
          break;
      }
    }

    wait 0.5;
  }

  _id_0547::_id_2D8C(::hc_quest_axe_enemykilled_sizzlerneararmor);
  _id_054D::giveplayersexp("berlin_exp_ref_8");
  var_5 = _getent("hc_ee_axe_scale_soul_collector", "script_noteworthy");
  var_5 maps\mp\mp_zombies_soul_collection::_id_170B(10, 140, 100, "zmb_hc_ee_axe_scale_zombie_killed", undefined, "tag_origin", undefined, "tag_origin");
  _iprintlnbold("The Nazi War Axe is revealed beneath the scale!");
  var_6 = _getent("hc_ee_axe_scale_drawer", "script_noteworthy");
  var_7 = _getent("hc_ee_axe_pickup_axe", "script_noteworthy");
  var_8 = _getent("hc_ee_axe_origin_mover", "script_noteworthy");
  var_6 linktosynchronizedparent(var_8);
  var_7 linktosynchronizedparent(var_8);
  _id_0378::_id_8D74("aud_axe_hc_drawer_open", var_6);
  var_8 movey(-15, 1.5, 0.3, 0.3);

  foreach(var_4 in level.players) {
    if(distance(var_4.origin, level.dagger_safe.origin) < 200)
      var_4 _id_0367::_id_8E3D("hc_axe_reveal");
  }

  var_11 = _getent("axe_pickup_trigger", "targetname");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_11, "pickaxe");
}

test_bunny_collection() {
  var_0 = _getent("hc_ee_axe_scale_soul_collector", "script_noteworthy");
  var_0 maps\mp\mp_zombies_soul_collection::_id_170B(10, 140, 100, "zmb_hc_ee_axe_scale_zombie_killed", undefined, "tag_origin", undefined, "tag_origin");
}

hc_quest_axe_sizzler_kill_init() {
  _id_0547::_id_7BA9(::hc_quest_axe_enemykilled_sizzlerneararmor);
  level.armor_machines = common_scripts\utility::_id_46B7("armor_buy", "targetname");
}

hc_quest_axe_enemykilled_sizzlerneararmor(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  var_9 = common_scripts\utility::_id_40B0(self.origin, level.armor_machines);
  var_10 = _distance2d(var_9[0].origin, self.origin);
  var_11 = var_9[0];

  if(var_10 <= 100 && (_id_0547::_id_5864(var_4) || _id_0547::_id_5752(var_4))) {
    if(isDefined(self._id_0A4B)) {
      switch (self._id_0A4B) {
        case "zombie_sizzler":
          hc_quest_axe_sever_head("sizzler", var_11);
          break;
        case "zombie_generic":
          hc_quest_axe_sever_head("fodder", var_11);
          break;
        case "zombie_berserker":
          hc_quest_axe_sever_head("pest", var_11);
          break;
        default:
          break;
      }
    }
  }
}

hc_quest_axe_sever_head(var_0, var_1) {
  if(isDefined(var_1._id_00B9)) {
    if(isDefined(var_1._id_00B9.headfx))
      var_1._id_00B9.headfx delete();

    foreach(var_3 in var_1._id_9DC2)
    var_3 notify("head_replaced");

    var_1._id_00B9 delete();
  }

  var_5 = var_1._id_0F5F.angles;
  var_1._id_00B9 = spawn("script_model", var_1._id_9DC2[0].origin);
  var_1._id_00B9.angles = var_5 - (0, 0, 0);
  var_1._id_00B9.origin = var_1._id_00B9.origin + 15 * (anglestoright(var_1._id_0F5F.angles) * -1);
  var_1._id_00B9.origin = var_1._id_00B9.origin - 1.5 * anglestoright(var_1._id_00B9.origin);

  if(isDefined(var_1.setlookatent) && var_1.setlookatent == "street_machine") {
    var_1._id_00B9.origin = var_1._id_00B9.origin + 2.5 * anglestoright(var_1._id_00B9.origin);
    var_1._id_00B9.origin = var_1._id_00B9.origin - 1.25 * anglestoup(var_1._id_00B9.origin);
  }

  if(isDefined(var_1.setlookatent) && var_1.setlookatent == "museum_machine") {
    var_1._id_00B9.origin = var_1._id_00B9.origin + 4 * anglestoright(var_1._id_00B9.origin);
    var_1._id_00B9.origin = var_1._id_00B9.origin + 3 * anglesToForward(var_1._id_00B9.origin);
    var_1._id_00B9.origin = var_1._id_00B9.origin + (-0.5, 1, 3);
  }

  if(isDefined(var_1.setlookatent) && var_1.setlookatent == "underbelly_machine")
    var_1._id_00B9.origin = var_1._id_00B9.origin + (1.9, 0, 0);

  if(isDefined(var_1.setlookatent) && var_1.setlookatent == "church_machine")
    var_1._id_00B9.origin = var_1._id_00B9.origin + (2, 0, 0);

  switch (var_0) {
    case "sizzler":
      var_1._id_00B9 setModel("zom_sizzler_head_gib");
      sever_head_fx(var_1._id_00B9);
      break;
    case "fodder":
      var_1._id_00B9 setModel("zom_ger_head_fdr_03_gib");
      sever_head_fx(var_1._id_00B9);
      break;
    case "pest":
      var_1._id_00B9 setModel("zom_ger_head_spr_01_gib");
      sever_head_fx(var_1._id_00B9);
      var_1._id_00B9.origin = var_1._id_00B9.origin - (0, 0, 2);
      break;
    default:
      break;
  }

  foreach(var_3 in var_1._id_9DC2)
  var_3 thread hc_quest_axe_used_head_armor(var_1._id_00B9, var_1.model);
}

sever_head_fx(var_0) {
  if(isDefined(var_0)) {
    var_0.headfx = _spawnfx(common_scripts\utility::_id_44F5("zmb_ber_hc_ee_armor_head"), var_0.origin, anglesToForward(var_0.angles));
    _triggerfx(var_0.headfx);
  }
}

hc_quest_axe_used_head_armor(var_0, var_1) {
  self endon("head_replaced");

  while(isDefined(var_0)) {
    self waittill("trigger", var_2);
    var_3 = _id_056A::_id_4602(var_2, self);

    if(var_2 maps\mp\gametypes\zombies::_id_11C2(var_3))
      hc_quest_axe_buy_head(var_0);
    else
      continue;

    waitframe();
  }
}

hc_quest_axe_buy_head(var_0) {
  if(isDefined(var_0)) {
    switch (var_0.model) {
      case "zom_sizzler_head_gib":
        hc_quest_axe_clear_other_head_flags("flag_hc_quest_axe_step03_carrying_sizzler_armored_head");
        break;
      case "zom_ger_head_fdr_03_gib":
        hc_quest_axe_clear_other_head_flags("flag_hc_quest_axe_step03_carrying_fodder_armored_head");
        break;
      case "zom_ger_head_spr_01_gib":
        hc_quest_axe_clear_other_head_flags("flag_hc_quest_axe_step03_carrying_pest_armored_head");
        break;
      default:
        break;
    }

    var_0.headfx delete();
    var_0 delete();
  }
}

hc_quest_axe_clear_other_head_flags(var_0) {
  var_1 = ["flag_hc_quest_axe_step03_carrying_fodder_armored_head", "flag_hc_quest_axe_step03_carrying_sizzler_armored_head", "flag_hc_quest_axe_step03_carrying_pest_armored_head"];

  foreach(var_3 in var_1) {
    if(var_3 != var_0)
      common_scripts\utility::_id_3C7B(var_3);
  }

  common_scripts\utility::flag_set(var_0);
  level.hc_axe_ee_head_carried = var_0;
}

hc_quest_axe_map_pin_found(var_0) {
  var_1 = _getent("script_pickup_map_pin", "script_noteworthy");
  var_2 = _getent("trigger_use_cabaret_map", "script_noteworthy");
  var_2 waittill("trigger", var_3);
  common_scripts\utility::flag_set("flag_hc_quest_axe_step01_map_pin_found");
  var_1 delete();
  var_0 show();
}

hc_quest_axe_debug_skip_step01a() {
  common_scripts\utility::flag_set("flag_hc_quest_axe_step01_map_pin_found");
}

hc_quest_axe_debug_skip_step01b() {
  hc_quest_axe_debug_skip_step01a();
  common_scripts\utility::flag_set("flag_hc_quest_axe_step01_map_location_found");
  var_0 = _getent("mapboard_lockbox_door", "script_noteworthy");
  var_0 rotateyaw(40, 1, 0.25, 0.25);
}

hc_quest_axe_debug_skip_step02() {
  hc_quest_axe_debug_skip_step01b();
  common_scripts\utility::flag_set("flag_hc_quest_axe_step02_obtained_scale_cup");
  common_scripts\utility::flag_set("flag_hc_quest_axe_step02_placed_scale_cup");
  var_0 = _getent("hc_ee_axe_scale_cup", "script_noteworthy");
  var_1 = _getent("hc_ee_axe_scale_needle", "script_noteworthy");
  var_0 show();
  var_1 rotatepitch(-5, 1, 0.25, 0.25);
}

hc_quest_axe_debug_skip_step03() {
  hc_quest_axe_debug_skip_step02();
  common_scripts\utility::flag_init("flag_hc_quest_axe_step03_obtained_sizzler_armored_head");
  common_scripts\utility::flag_set("flag_hc_quest_axe_step03_obtained_sizzler_armored_head");
  common_scripts\utility::flag_set("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
  var_0 = _getent("hc_ee_axe_scale_sizzler_head", "script_noteworthy");
  var_0 show();
}

hc_quest_axe_debug_skip_all() {
  hc_quest_axe_debug_skip_step03();
}

_____________________finale_____________________() {}

hc_quest_finale_init() {
  common_scripts\utility::flag_init("flag_hc_quest_finale_weapons_collected");
  common_scripts\utility::flag_init("flag_hc_quest_finale_door_open");
  common_scripts\utility::flag_init("statue_puzzle_success");
  common_scripts\utility::flag_init("flag_hc_quest_finale_sword_door_open");
  var_0 = _getent("garden_keyhole_placed_sword", "targetname");
  var_0 hide();
  hc_quest_finale_logic();
}

hc_quest_finale_logic() {
  hc_quest_finale_step01_handler();
  _id_054D::giveplayersexp("berlin_exp_ref_6");
  hc_quest_finale_step02_handler();
  hc_quest_finale_step03_handler();
}

hc_quest_finale_step01_handler() {
  hc_quest_finale_step01_place_weapons_handler();
}

hc_quest_finale_step01_place_weapons_handler() {
  level.bat_key_placed = 0;
  level.dagger_key_placed = 0;
  level.pickaxe_key_placed = 0;
  thread hc_quest_finale_utility_place_weapon_with_name("bat", 5, "zombie_berserker");
  thread hc_quest_finale_utility_place_weapon_with_name("dagger", 20, "zombie_generic");
  thread hc_quest_finale_utility_place_weapon_with_name("pickaxe", 5, "zombie_sizzler");

  while(!level.bat_key_placed || !level.dagger_key_placed || !level.pickaxe_key_placed)
    waitframe();

  var_0 = _getent("garden_keyhole_placed_dagger", "targetname");
  var_1 = _getent("garden_keyhole_placed_bat", "targetname");
  var_2 = _getent("garden_keyhole_placed_pickaxe", "targetname");
  var_3 = spawn("script_model", var_0.origin - (5, 0, 0));
  var_3 setModel("tag_origin");
  var_3.desired_zombie_type = "zombie_generic";
  var_3.ignoresighttrace = 1;
  var_3 maps\mp\mp_zombies_soul_collection::_id_170B(20, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_3.desired_zombie_type = "zombie_sizzler";
  var_3.origin = var_2.origin - (5, 0, 0);
  var_3 maps\mp\mp_zombies_soul_collection::_id_170B(10, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_3.desired_zombie_type = "zombie_berserker";
  var_3.origin = var_1.origin - (5, 0, 0);
  var_3 maps\mp\mp_zombies_soul_collection::_id_170B(9, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::flag_set("flag_hc_quest_finale_door_open");
  raven_puzzle_init();
  hc_quest_finale_utility_open_doors();
}

hc_quest_finale_step02_handler() {
  level.bird_models = getEntArray("bird_model", "targetname");

  foreach(var_1 in level.bird_models)
  thread raven_puzzle_hide_raven_until_found(var_1);

  common_scripts\utility::_id_3C9F("flag_airship_anchor_a_reeled");
  level.current_secret_room_zone = "zone_finale";
  level._id_8B96 = maps\mp\mp_zombie_berlin_utils::zombies_players_secret_room_handle_ignore;
  hc_quest_finale_utility_close_doors();
  _id_0547::playerspawneroverrideset("blade");
  maps\mp\gametypes\zombies::register_addition_revive_rule(::hc_quest_finale_step02_separated_by_combat_event, ::hc_quest_finale_step02_debug_highlight_player_separation, "scr_hightLightPlayerSeparation");
  hc_quest_finale_step02_statue_puzzle_init();
  var_3 = _getent("sword_pickup_trig", "targetname");
  thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_3, "sword");

  foreach(var_5 in level.players) {
    if(distance(var_5.origin, var_3.origin) < 450)
      var_5 _id_0367::_id_8E3D("hc_sword_reveal");
  }
}

hc_quest_finale_step02_separated_by_combat_event(var_0, var_1) {
  if(!isDefined(level.zombies_active_spawn_event) || level.zombies_active_spawn_event != "blade")
    return 0;

  var_2 = [level.current_secret_room_zone];
  var_3 = self;
  var_4 = var_0 _id_0547::player_validate_is_in_zones(var_2);
  var_5 = var_1 _id_0547::player_validate_is_in_zones(var_2);
  var_6 = var_4 == var_5;
  return !var_6;
}

hc_quest_finale_step02_debug_highlight_player_separation() {}

raven_puzzle_init() {
  common_scripts\utility::flag_init("raven_puzzle_wall01_success");
  common_scripts\utility::flag_init("raven_puzzle_wall02_success");
  common_scripts\utility::flag_init("raven_puzzle_wall03_success");
  common_scripts\utility::flag_init("raven_puzzle_wall04_success");
  common_scripts\utility::flag_init("raven_puzzle_currently_rotating");
  raven_puzzle_wall_progression();
}

raven_puzzle_wall_progression() {
  thread raven_puzzle_handle_wall_with_targetname("first_wall_statue", "flag_airship_anchor_a_reeled", "raven_puzzle_wall01_success", "01");
  thread raven_puzzle_handle_wall_with_targetname("second_wall_statue", "raven_puzzle_wall01_success", "raven_puzzle_wall02_success", "02");
  thread raven_puzzle_handle_wall_with_targetname("third_wall_statue", "raven_puzzle_wall02_success", "raven_puzzle_wall03_success", "03");
  thread raven_puzzle_handle_wall_with_targetname("fourth_wall_statue", "raven_puzzle_wall03_success", "raven_puzzle_wall04_success", "04");
}

raven_puzzle_handle_wall_with_targetname(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray(var_0, "targetname");

  foreach(var_6 in var_4)
  var_6 thread raven_puzzle_wall_statue_handler(var_1, var_2);

  thread raven_puzzle_check_completion(var_4, var_1, var_2, var_3);
}

raven_puzzle_wall_statue_handler(var_0, var_1) {
  var_2 = 90;
  var_3 = int(360 / var_2);
  self.start_rotation = self.angles;
  self.correctly_rotated = 0;
  var_4 = getEntArray(self.target, "targetname");
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_4) {
    if(var_9.classname == "trigger_damage") {
      var_6 = var_9;
      continue;
    }

    if(var_9.classname == "script_model")
      var_5 = var_9;
  }

  if(issubstr(var_5.model, "01"))
    var_7 = 1;
  else if(issubstr(var_5.model, "02"))
    var_7 = 2;
  else if(issubstr(var_5.model, "03"))
    var_7 = 3;
  else if(issubstr(var_5.model, "04"))
    var_7 = 4;

  var_5 linktosynchronizedparent(self);
  var_11 = _randomintrange(1, var_3) * var_7;
  var_12 = var_11 * var_2;
  self.angles = self.angles - (0, var_12, 0);
  self.angles = (0, _angleclamp(self.angles[1]), 0);

  if(self.angles[1] % 360 == self.start_rotation[1] % 360)
    self.correctly_rotated = 1;

  common_scripts\utility::_id_3C9F(var_0);
  var_13 = 0;
  var_14 = spawn("script_model", self.origin + (0, 0, var_13));
  var_14.angles = (var_14.angles[0] - 90, var_14.angles[1], var_14.angles[2]);
  var_14 setModel("tag_origin");
  var_14.start_offset = var_13;

  while(!common_scripts\utility::_id_3C77(var_1)) {
    raven_puzzle_wall_statue_waitfor_interact(var_6, var_1, var_14);
    raven_puzzle_wall_statue_play_trigger_fx(var_14);

    if(!common_scripts\utility::_id_3C77(var_1))
      raven_puzzle_wall_statue_apply_angle_offset(var_7, var_2);

    common_scripts\utility::flag_waitopen("raven_puzzle_currently_rotating");
  }
}

raven_puzzle_wall_statue_waitfor_interact(var_0, var_1, var_2) {
  level endon(var_1);
  self endon("raven_puzzle_wall_statue_interact");
  var_0 setcontents(var_0 _meth_85A0() | 256);
  var_3 = 16;
  var_2.current_fx = undefined;

  while(!common_scripts\utility::_id_3C77(var_1)) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_0 waittill("trigger");

      if(var_4 == var_3 * 0.75) {
        if(isDefined(var_2.current_fx))
          _killfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");

        var_2.current_fx = "crest_charge_100";
        _playfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");
        continue;
      }

      if(var_4 == var_3 * 0.5) {
        if(isDefined(var_2.current_fx))
          _killfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");

        var_2.current_fx = "crest_charge_75";
        _playfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");
        continue;
      }

      if(var_4 == var_3 * 0.25) {
        if(isDefined(var_2.current_fx))
          _killfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");

        var_2.current_fx = "crest_charge_50";
        _playfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");
        continue;
      }

      if(var_4 == 0) {
        if(isDefined(var_2.current_fx))
          _killfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");

        var_2.current_fx = "crest_charge_25";
        _playfxontag(level._effect[var_2.current_fx], var_2, "tag_origin");
      }
    }

    if(!common_scripts\utility::_id_3C77("raven_puzzle_currently_rotating")) {
      break;
    } else
      common_scripts\utility::flag_waitopen("raven_puzzle_currently_rotating");
  }

  var_5 = getEntArray(self.targetname, "targetname");
  var_6 = common_scripts\utility::_id_40B0(self.origin, var_5, [self], 2, self.radius);

  if(isDefined(var_6) && var_6.size > 0) {
    foreach(var_8 in var_6)
    var_8 notify("raven_puzzle_wall_statue_interact");
  }
}

raven_puzzle_wall_statue_play_trigger_fx(var_0) {
  if(isDefined(var_0.current_fx))
    _killfxontag(level._effect[var_0.current_fx], var_0, "tag_origin");

  var_0.origin = (var_0.origin[0], var_0.origin[1], self.origin[2] + var_0.start_offset);
  var_0.current_fx = "crest_charge_detonate";
  _playfxontag(level._effect[var_0.current_fx], var_0, "tag_origin");
}

raven_puzzle_wall_statue_apply_angle_offset(var_0, var_1) {
  var_2 = 1.8 / var_0;
  common_scripts\utility::flag_set("raven_puzzle_currently_rotating");
  _id_0378::_id_8D74("aud_statue_rotate_handler");

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = _angleclamp(self.angles[1] - var_1);
    var_4 = raven_puzzle_wall_statue_clamp_yaw(var_4);
    var_5 = (0, var_4, 0);
    self rotateto(var_5, var_2, 0.2, 0.2);
    wait(var_2);
    self.angles = var_5;
  }

  var_6 = self.angles[1] % 360;
  var_7 = self.start_rotation[1] % 360;

  if(var_6 == var_7) {
    self.correctly_rotated = 1;
    level notify("raven_puzzle_statue_rotation_correct");
  } else
    self.correctly_rotated = 0;

  wait 0.15;
  common_scripts\utility::_id_3C7B("raven_puzzle_currently_rotating");
  _id_0378::_id_8D74("aud_statue_rotate_handler");
}

raven_puzzle_wall_statue_clamp_yaw(var_0) {
  int(var_0);
  var_1 = var_0 % 90;

  if(var_1 != 0) {
    if(var_1 < 45)
      var_0 = var_0 - var_1;
    else
      var_0 = var_0 + var_1;
  }

  return var_0;
}

raven_puzzle_check_completion(var_0, var_1, var_2, var_3) {
  common_scripts\utility::_id_3C9F(var_1);

  while(!common_scripts\utility::_id_3C77(var_2)) {
    level waittill("raven_puzzle_statue_rotation_correct");
    common_scripts\utility::flag_waitopen("raven_puzzle_currently_rotating");
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(!var_6.correctly_rotated) {
        var_4 = 0;
        break;
      } else
        var_4 = 1;
    }

    if(var_4) {
      common_scripts\utility::flag_set(var_2);
      _id_0378::_id_8D74("aud_statue_wall_complete");
      continue;
    }

    waitframe();
  }

  _iprintlnbold(var_2 + " flag set! YOU DID IT!");
  raven_puzzle_show_raven_with_index(var_3);
}

raven_puzzle_hide_raven_until_found(var_0) {
  var_0 hide();
  var_0 common_scripts\utility::_id_A732("found_bird_statue", "hc_quest_finale_skip_step02_parta");
  var_0 show();
}

raven_puzzle_show_raven_with_index(var_0) {
  foreach(var_2 in level.bird_models) {
    if(isDefined(var_2) && isDefined(var_2._id_0165) && var_2._id_0165 == var_0)
      var_2 notify("found_bird_statue");
  }

  _id_054D::giveplayersexp("berlin_exp_ref_5");
}

hc_quest_finale_step02_statue_puzzle_init() {
  level.bird_data = [];
  level.bird_data["found"] = [];
  level.bird_data["placed"] = [];
  level.bird_data["placed_models"] = [];
  level.bird_data["base_model"] = "zbr_statue_puzzle_bird_";
  level.bird_data["statue"] = _getent("bird_statue", "targetname");
  level.bird_data["start_vol"] = _getent("bird_puzzle_start", "targetname");

  foreach(var_1 in level.bird_models)
  thread hc_quest_finale_step02_statue_puzzle_bird_model_think(var_1);

  common_scripts\utility::_id_3CA2("raven_puzzle_wall01_success", "raven_puzzle_wall02_success", "raven_puzzle_wall03_success", "raven_puzzle_wall04_success");
  hc_quest_finale_step02_statue_puzzle_place_birds_think();
}

hc_quest_finale_step02_statue_puzzle_bird_model_think(var_0) {
  level endon("game_over");
  var_0 waittill("found_bird_statue");
  var_1 = var_0._id_0165;

  while(!common_scripts\utility::_id_3C77("statue_puzzle_success")) {
    var_0 hc_quest_finale_step02_statue_puzzle_bird_model_make_usable();
    var_2 = 0;

    while(!var_2) {
      waitframe();
      var_0 waittill("player_used", var_3);

      if(distancesquared(var_0.origin, var_3.origin) < 10000) {
        var_2 = 1;
        _id_0378::_id_8D74("aud_pickup_bird", var_0.origin);
      }
    }

    var_0._id_9D65 delete();
    var_0 delete();
    level notify("new_bird_acquired");
    level.bird_data["found"] = common_scripts\utility::_id_0F86(level.bird_data["found"], var_1, 0);
    var_4 = level common_scripts\utility::waittill_any_return("birds_placed_incorrectly", "birds_placed_correctly");

    if(var_4 == "birds_placed_incorrectly")
      var_0 = hc_quest_finale_step02_statue_puzzle_reset_bird_with_index(var_1);

    waitframe();
  }
}

hc_quest_finale_step02_statue_puzzle_bird_model_make_usable() {
  _id_0547::_id_AC41(" ");
}

hc_quest_finale_step02_statue_puzzle_reset_bird_with_index(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.bird_data["placed_models"]) {
    if(var_3.model == level.bird_data["base_model"] + var_0) {
      var_1 = var_3;
      hc_quest_finale_step02_statue_puzzle_reset_bird_fx(var_1.origin);
      var_1 hide();
      var_4 = common_scripts\utility::_id_46B7("bird_ground_org_" + var_0, "targetname");
      var_5 = common_scripts\utility::random(var_4);
      var_1.origin = var_5.origin;
      var_1 common_scripts\utility::_id_2CBE(0.05, ::show);
      level.bird_data["placed_models"] = common_scripts\utility::_id_0F93(level.bird_data["placed_models"], var_3);
      break;
    }
  }

  return var_1;
}

hc_quest_finale_step02_statue_puzzle_reset_bird_fx(var_0) {
  var_0 = var_0 - (0, 0, 20);
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  var_1.angles = (var_1.angles[0] - 90, var_1.angles[1], var_1.angles[2]);
  wait(_randomfloatrange(0.25, 2));
  _playfxontag(level._effect["statue_bolt"], var_1, "tag_origin");
  var_1 common_scripts\utility::_id_2CBE(3, ::delete);
  waitframe();
}

hc_quest_finale_step02_statue_puzzle_place_birds_think() {
  level endon("game_over");
  var_0 = 4;

  while(!common_scripts\utility::_id_3C77("statue_puzzle_success")) {
    var_1 = 1;

    while(level.bird_data["placed"].size < var_0) {
      while(level.bird_data["found"].size <= 0)
        waitframe();

      var_2 = hc_quest_finale_step02_statue_puzzle_place_current_bird();

      if(isDefined(var_2) && !var_2)
        var_1 = 0;

      if(isDefined(var_2) && level.bird_data["placed"].size < var_0)
        wait 1;
    }

    level.bird_data["placed"] = [];
    level.bird_data["found"] = [];

    if(!var_1) {
      hc_quest_finale_step02_statue_puzzle_play_fail_fx();
      level notify("birds_placed_incorrectly");
    } else {
      level notify("birds_placed_correctly");
      common_scripts\utility::flag_set("statue_puzzle_success");
    }

    waitframe();
  }

  hc_quest_finale_step02_statue_puzzle_play_pass_fx();
}

hc_quest_finale_step02_statue_puzzle_play_fail_fx() {
  var_0 = 3;

  foreach(var_2 in level.bird_data["placed_models"])
  var_2 thread hc_quest_finale_step02_statue_puzzle_play_fail_fx_on_bird(var_0);

  wait(var_0);
}

hc_quest_finale_step02_statue_puzzle_play_fail_fx_on_bird(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  _playfxontag(level._effect["statue_light_white"], var_1, "tag_origin");
  wait(var_0 / 2);
  _stopfxontag(level._effect["statue_light_white"], var_1, "tag_origin");
  _playfxontag(level._effect["statue_light_red"], var_1, "tag_origin");
  _iprintlnbold("Incorrect!");
  wait(var_0 / 2);
  _stopfxontag(level._effect["statue_light_red"], var_1, "tag_origin");
  var_1 common_scripts\utility::_id_2CBE(0.25, ::delete);
}

hc_quest_finale_step02_statue_puzzle_play_pass_fx() {
  var_0 = 3;

  foreach(var_2 in level.bird_data["placed_models"])
  var_2 thread hc_quest_finale_step02_statue_puzzle_play_pass_fx_on_bird(var_0);

  thread hc_quest_finale_step02_statue_puzzle_play_crumble_fx();
  wait(var_0);
}

hc_quest_finale_step02_statue_puzzle_play_crumble_fx() {
  level thread common_scripts\_exploder::_id_088E(206);
  _id_0378::_id_8D74("aud_sword_reveal");
  wait 0.7;
  var_0 = _getent("bird_statue_sword_bit", "targetname");
  var_0 delete();
}

hc_quest_finale_step02_statue_puzzle_play_pass_fx_on_bird(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  _playfxontag(level._effect["statue_light_white"], var_1, "tag_origin");
  wait(var_0);
  _stopfxontag(level._effect["statue_light_white"], var_1, "tag_origin");
  _playfxontag(level._effect["statue_light_green"], var_1, "tag_origin");
  _iprintlnbold("Correct!");
}

hc_quest_finale_step02_statue_puzzle_place_current_bird() {
  level endon("new_bird_acquired");
  var_0 = 0;

  foreach(var_2 in level.players)
  var_2 thread hc_quest_finale_step02_statue_puzzle_player_place_bird();

  level waittill("bird_placed", var_4);
  var_0 = var_4;
  level.bird_data["placed"][level.bird_data["placed"].size] = level.bird_data["found"][0];
  level.bird_data["found"] = common_scripts\utility::_id_0F9A(level.bird_data["found"], 0);
  return var_0;
}

hc_quest_finale_step02_statue_puzzle_player_place_bird() {
  waitframe();
  level endon("bird_placed");
  level endon("new_bird_acquired");

  while(!self istouching(level.bird_data["start_vol"]))
    wait 5;

  var_0 = 0;
  var_1 = level.bird_data["found"][0];
  self.current_stencil = undefined;
  thread hc_quest_finale_step02_statue_puzzle_handle_stencil_cleanup();

  while(!var_0) {
    while(_distance2d(self.origin, level.bird_data["statue"].origin) > 125)
      waitframe();

    while(_distance2d(self.origin, level.bird_data["statue"].origin) <= 125) {
      var_2 = common_scripts\utility::_id_46B7("bird_org_" + var_1, "targetname");
      var_2 = common_scripts\utility::_id_40B0(self getEye(), var_2, undefined, 10, 65);
      var_3 = undefined;

      foreach(var_5 in var_2) {
        if(common_scripts\utility::within_fov(self getEye(), self.angles, var_5.origin, _cos(25))) {
          var_3 = var_5;
          break;
        }
      }

      if(isDefined(var_3) && !isDefined(self.current_stencil)) {
        self.current_stencil = spawn("script_model", var_3.origin);
        self.current_stencil setModel(level.bird_data["base_model"] + var_1 + "_obj");
        self.current_stencil.angles = var_3.angles;
      } else if(isDefined(var_3) && isDefined(self.current_stencil)) {
        self.current_stencil.angles = var_3.angles;
        self.current_stencil.origin = var_3.origin;
      } else if(!isDefined(var_3) && isDefined(self.current_stencil))
        self.current_stencil delete();

      if(self usebuttonpressed() && isDefined(var_3)) {
        var_0 = 1;
        var_7 = 0;

        if(var_3._id_0165 == "correct")
          var_7 = 1;

        var_8 = spawn("script_model", var_3.origin);
        var_8 setModel(level.bird_data["base_model"] + var_1);
        var_8.angles = var_3.angles;
        _id_0378::_id_8D74("aud_place_bird", var_8.origin);
        level.bird_data["placed_models"][level.bird_data["placed_models"].size] = var_8;
        level notify("bird_placed", var_7);
      }

      waitframe();
    }

    waitframe();
  }
}

hc_quest_finale_step02_statue_puzzle_handle_stencil_cleanup() {
  level common_scripts\utility::_id_A732("bird_placed", "new_bird_acquired");

  if(isDefined(self.current_stencil))
    self.current_stencil delete();
}

hc_quest_finale_step03_handler() {
  level.sword_key_placed = 0;
  thread hc_quest_finale_utility_place_weapon_with_name("sword");

  while(!level.sword_key_placed)
    waitframe();

  common_scripts\utility::flag_set("flag_hc_quest_finale_sword_door_open");
  _id_0547::playerspawneroverrideclear();
  hc_quest_finale_utility_open_doors();
  level.current_secret_room_zone = "";
  level._id_8B96 = undefined;
}

hc_quest_finale_utility_place_weapon_with_name(var_0, var_1, var_2) {
  var_3 = _getent("garden_door_" + var_0 + "_keyhole", "targetname");
  var_4 = _getent("garden_keyhole_placed_" + var_0, "targetname");
  var_4 hide();
  var_5 = 0;

  while(!var_5) {
    var_3 waittill("trigger", var_6);

    if(isDefined(var_6.special_melee_weapon) && var_6.special_melee_weapon == var_0) {
      var_6.special_melee_weapon = "";
      var_5 = 1;
      var_4 show();
      _id_0378::_id_8D74("aud_place_weapon_in_slot", var_0, var_4.origin);
    }
  }

  hc_quest_finale_utility_place_weapon_set_boolean(var_0, 1);
}

hc_quest_finale_utility_place_weapon_set_boolean(var_0, var_1) {
  switch (var_0) {
    case "bat":
      level.bat_key_placed = var_1;
      break;
    case "dagger":
      level.dagger_key_placed = var_1;
      break;
    case "pickaxe":
      level.pickaxe_key_placed = var_1;
      break;
    case "sword":
      level.sword_key_placed = var_1;
      break;
    default:
      break;
  }
}

hc_quest_finale_utility_open_doors(var_0) {
  var_1 = _getent("hc_finale_gate_l", "targetname");
  var_2 = _getent("hc_finale_gate_clip_l", "targetname");
  var_3 = _getent("hc_finale_gate_l_org", "targetname");
  var_1 linktosynchronizedparent(var_3);
  var_2 linktosynchronizedparent(var_3);
  var_4 = _getent("hc_finale_gate_r", "targetname");
  var_5 = _getent("hc_finale_gate_clip_r", "targetname");
  var_6 = _getent("hc_finale_gate_r_org", "targetname");
  var_4 linktosynchronizedparent(var_6);
  var_5 linktosynchronizedparent(var_6);
  var_2 notsolid();
  var_5 notsolid();
  var_2 connectpaths();
  var_5 connectpaths();
  var_2 solid();
  var_5 solid();
  _id_0378::_id_8D74("aud_open_barbarosa_area_door", var_1.origin);
  var_6 rotateto((0, 75, 0), 3, 0.5, 0.5);
  var_3 rotateto((0, 285, 0), 3, 0.5, 0.5);
  wait 3;
  var_2 disconnectpaths();
  var_5 disconnectpaths();
}

hc_quest_finale_utility_close_doors() {
  var_0 = _getent("hc_finale_gate_l", "targetname");
  var_1 = _getent("hc_finale_gate_clip_l", "targetname");
  var_2 = _getent("hc_finale_gate_l_org", "targetname");
  var_0 linktosynchronizedparent(var_2);
  var_1 linktosynchronizedparent(var_2);
  var_3 = _getent("hc_finale_gate_r", "targetname");
  var_4 = _getent("hc_finale_gate_clip_r", "targetname");
  var_5 = _getent("hc_finale_gate_r_org", "targetname");
  var_3 linktosynchronizedparent(var_5);
  var_4 linktosynchronizedparent(var_5);
  var_1 notsolid();
  var_4 notsolid();
  var_1 connectpaths();
  var_4 connectpaths();
  var_1 solid();
  var_4 solid();
  _id_0378::_id_8D74("aud_close_barbarosa_area_door", var_0.origin);
  var_2 rotateto((0, 0, 0), 1.5, 0, 0);
  var_5 rotateto((0, 0, 0), 1.5, 0, 0);
  wait 1.5;
  var_1 disconnectpaths();
  var_4 disconnectpaths();
}

_____________________hats_____________________() {}

hc_quest_hats_init() {
  common_scripts\utility::flag_init("flag_hat_stack_ee_complete");
  thread hat_spawn();
  thread hat_spawn_2();
  thread hat_spawn_3();
  thread hat_spawn_4();
  thread hat_spawn_5();
  var_0 = getEntArray("table_think_trig", "targetname");

  foreach(var_2 in var_0)
  var_2 thread hatrack_table_think();

  thread hat_stacker();
  wait 5;
  level thread maps\mp\_utility::_id_6F74(::hat_check_player_disconnect);
}

hat_spawn() {
  var_0 = common_scripts\utility::_id_46B7("hat_1_possible_location", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("aac_hats_men_02");
  var_2.angles = var_1.angles;
  var_3 = _getent("hat_1_trig", "targetname");
  var_3.origin = var_1.origin;
  var_3 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isDefined(var_4.hat_inventory))
      var_4.hat_inventory = "empty";

    if(var_4.hat_inventory == "empty") {
      var_4.hat_inventory = "hat_1";
      var_3 common_scripts\utility::_id_9D9F();
      var_2 delete();
      break;
    }
  }
}

hat_spawn_2() {
  var_0 = common_scripts\utility::_id_46B7("hat_2_possible_location", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("ger_m43cap_org2");
  var_2.angles = var_1.angles;
  var_3 = _getent("hat_2_trig", "targetname");
  var_3.origin = var_1.origin;
  var_3 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isDefined(var_4.hat_inventory))
      var_4.hat_inventory = "empty";

    if(var_4.hat_inventory == "empty") {
      var_4.hat_inventory = "hat_2";
      var_3 common_scripts\utility::_id_9D9F();
      var_2 delete();
      break;
    }
  }
}

hat_spawn_3() {
  var_0 = common_scripts\utility::_id_46B7("hat_3_possible_location", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("ger_alfakey_m34capm44hp_r1c1");
  var_2.angles = var_1.angles;
  var_3 = _getent("hat_3_trig", "targetname");
  var_3.origin = var_1.origin;
  var_3 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isDefined(var_4.hat_inventory))
      var_4.hat_inventory = "empty";

    if(var_4.hat_inventory == "empty") {
      var_4.hat_inventory = "hat_3";
      var_3 common_scripts\utility::_id_9D9F();
      var_2 delete();
      break;
    }
  }
}

hat_spawn_4() {
  var_0 = common_scripts\utility::_id_46B7("hat_4_possible_location", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("zom_m40officercap_org1");
  var_2.angles = var_1.angles;
  var_3 = _getent("hat_4_trig", "targetname");
  var_3.origin = var_1.origin;
  var_3 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isDefined(var_4.hat_inventory))
      var_4.hat_inventory = "empty";

    if(var_4.hat_inventory == "empty") {
      var_4.hat_inventory = "hat_4";
      var_3 common_scripts\utility::_id_9D9F();
      var_2 delete();
      break;
    }
  }
}

hat_spawn_5() {
  var_0 = common_scripts\utility::_id_46B7("hat_5_possible_location", "targetname");
  var_1 = common_scripts\utility::random(var_0);
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("rus_balthazar_m35pilotka_r4c3");
  var_2.angles = var_1.angles;
  var_3 = _getent("hat_5_trig", "targetname");
  var_3.origin = var_1.origin;
  var_3 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(!isDefined(var_4.hat_inventory))
      var_4.hat_inventory = "empty";

    if(var_4.hat_inventory == "empty") {
      var_4.hat_inventory = "hat_5";
      var_3 common_scripts\utility::_id_9D9F();
      var_2 delete();
      break;
    }
  }
}

hat_check_player_disconnect() {
  for(;;) {
    common_scripts\utility::_id_A70A("disconnect", "death");

    if(!isDefined(self.hat_inventory))
      self.hat_inventory = "empty";

    if(self.hat_inventory == "hat_1")
      thread hat_spawn();

    if(self.hat_inventory == "hat_2")
      thread hat_spawn_2();

    if(self.hat_inventory == "hat_3")
      thread hat_spawn_3();

    if(self.hat_inventory == "hat_4")
      thread hat_spawn_4();

    if(self.hat_inventory == "hat_5")
      thread hat_spawn_5();

    self.hat_inventory = "empty";
  }
}

hatrack_table_think() {
  var_0 = undefined;
  var_1 = common_scripts\utility::_id_46B5(self.target, "targetname");
  self.hatrack = spawn("script_model", var_1.origin);
  self.hatrack setModel("");
  self.hatrack.name = "empty";
  self.hatrack._id_2BB1 = self.hatrack.origin;
  self.hatrack._id_2B8F = self.hatrack.angles;

  for(;;) {
    self waittill("trigger", var_2);
    self.hatrack setModel("empty_model");
    var_3 = var_2.hat_inventory;
    var_2.hat_inventory = self.hatrack.name;
    self.hatrack.name = var_3;
    self.hatrack.origin = self.hatrack._id_2BB1;
    self.hatrack.angles = self.hatrack._id_2B8F;

    if(isDefined(self.hatrack.name) && self.hatrack.name != "empty") {
      if(self.hatrack.name == "hat_1")
        var_0 = "aac_hats_men_02";

      if(self.hatrack.name == "hat_2") {
        var_0 = "ger_m43cap_org2";
        self.hatrack.origin = self.hatrack._id_2BB1 + (0, 0, 4);
        self.hatrack.angles = self.hatrack._id_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.name == "hat_3") {
        var_0 = "ger_alfakey_m34capm44hp_r1c1";
        self.hatrack.origin = self.hatrack._id_2BB1 + (0, 0, 4);
        self.hatrack.angles = self.hatrack._id_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.name == "hat_4") {
        var_0 = "zom_m40officercap_org1";
        self.hatrack.origin = self.hatrack._id_2BB1 + (0, 0, 4);
        self.hatrack.angles = self.hatrack._id_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.name == "hat_5") {
        var_0 = "rus_balthazar_m35pilotka_r4c3";
        self.hatrack.origin = self.hatrack._id_2BB1 + (0, 0, 4);
        self.hatrack.angles = self.hatrack._id_2B8F + (-90, 0, 0);
      }
    } else {
      var_0 = "empty_model";
      self.hatrack.origin = self.hatrack._id_2BB1;
      self.hatrack.angles = self.hatrack._id_2B8F;
    }

    waitframe();
    self.hatrack setModel(var_0);
  }
}

hat_stacker() {
  level endon("flag_hat_stack_ee_complete");
  var_0 = _getent("hatrack_trig_new", "targetname");
  var_1 = common_scripts\utility::_id_46B5("hat_stack_reward", "targetname");
  level.hatrack = [];
  level.officer_hat = 0;
  level.cappy = 0;
  level.hat_cap = 0;
  level.red_cap = 0;
  var_2 = common_scripts\utility::_id_46B5("hat_spot_0", "targetname");
  var_3 = common_scripts\utility::_id_46B5("hat_spot_1", "targetname");
  var_4 = common_scripts\utility::_id_46B5("hat_spot_2", "targetname");
  var_5 = common_scripts\utility::_id_46B5("hat_spot_3", "targetname");
  var_6 = common_scripts\utility::_id_46B5("hat_spot_4", "targetname");
  var_7 = undefined;

  for(var_8 = 0; var_8 < 5; var_8++) {
    if(var_8 == 0) {
      level.hatrack[var_8] = spawn("script_model", var_2.origin);
      level.hatrack[var_8].angles = var_2.angles;
    }

    if(var_8 == 1) {
      level.hatrack[var_8] = spawn("script_model", var_3.origin);
      level.hatrack[var_8].angles = var_3.angles;
    }

    if(var_8 == 2) {
      level.hatrack[var_8] = spawn("script_model", var_4.origin);
      level.hatrack[var_8].angles = var_4.angles;
    }

    if(var_8 == 3) {
      level.hatrack[var_8] = spawn("script_model", var_5.origin);
      level.hatrack[var_8].angles = var_5.angles;
    }

    if(var_8 == 4) {
      level.hatrack[var_8] = spawn("script_model", var_6.origin);
      level.hatrack[var_8].angles = var_6.angles;
    }

    level.hatrack[var_8] setModel("");
    level.hatrack[var_8].name = "empty";
    level.hatrack[var_8]._id_2BB1 = level.hatrack[var_8].origin;
    level.hatrack[var_8]._id_2B8F = level.hatrack[var_8].angles;
  }

  for(;;) {
    var_0 waittill("trigger", var_9);

    if(!isDefined(var_9.hat_inventory) || var_9.hat_inventory == "empty") {
      for(var_8 = level.hatrack.size - 1; var_8 >= 0; var_8--) {
        if(level.hatrack[var_8].name != "empty") {
          if(level.hatrack[var_8].name == "hat_4")
            level.officer_hat = 0;

          if(level.hatrack[var_8].name == "hat_3")
            level.cappy = 0;

          if(level.hatrack[var_8].name == "hat_2")
            level.hat_cap = 0;

          if(level.hatrack[var_8].name == "hat_5")
            level.red_cap = 0;

          var_9.hat_inventory = level.hatrack[var_8].name;
          level.hatrack[var_8].name = "empty";
          level.hatrack[var_8] setModel("empty_model");
          level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1;
          level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F;
          break;
        }
      }

      continue;
    }

    for(var_8 = 0; var_8 < level.hatrack.size; var_8++) {
      if(level.hatrack[var_8].name == "empty") {
        level.hatrack[var_8].name = var_9.hat_inventory;

        if(var_9.hat_inventory == "hat_1")
          var_7 = "aac_hats_men_02";

        if(var_9.hat_inventory == "hat_2") {
          var_7 = "ger_m43cap_org2";
          level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (0, 0, 4);
          level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-90, 0, 0);
          level.hat_cap = 1;
        }

        if(var_9.hat_inventory == "hat_3") {
          var_7 = "ger_alfakey_m34capm44hp_r1c1";
          level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (-0.5, -0.75, 3.7);
          level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-85, 0, 0);
          level.hatrack[var_8] addyaw(-7.5);
          level.cappy = 1;
        }

        if(var_9.hat_inventory == "hat_4") {
          var_7 = "zom_m40officercap_org1";
          level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (0, 0, 5);
          level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-90, 0, 0);
          level.officer_hat = 1;
        }

        if(var_9.hat_inventory == "hat_5") {
          var_7 = "rus_balthazar_m35pilotka_r4c3";

          if(isDefined(level.hatrack[var_8 - 1])) {
            if(level.hatrack[var_8 - 1].name == "hat_4") {
              level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (1, 0.5, 2.5);
              level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-85, 0, 0);
              level.hatrack[var_8] addyaw(15);
            } else {
              level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (-0.5, -0.75, 3.7);
              level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-85, 0, 0);
              level.hatrack[var_8] addyaw(-7.5);
            }
          } else {
            level.hatrack[var_8].origin = level.hatrack[var_8]._id_2BB1 + (-0.5, -0.75, 3.7);
            level.hatrack[var_8].angles = level.hatrack[var_8]._id_2B8F + (-85, 0, 0);
            level.hatrack[var_8] addyaw(-7.5);
          }

          level.red_cap = 1;
        }

        if(level.officer_hat == 1) {
          if(level.hatrack[var_8].name != "hat_4")
            level.hatrack[var_8].origin = level.hatrack[var_8].origin + (0, 0, 3);
        }

        if(level.cappy == 1) {
          if(level.hatrack[var_8].name != "hat_3")
            level.hatrack[var_8].origin = level.hatrack[var_8].origin + (0, 0, 1.25);
        }

        if(level.red_cap == 1) {
          if(level.hatrack[var_8].name != "hat_5")
            level.hatrack[var_8].origin = level.hatrack[var_8].origin + (0, 0, 1.25);
        }

        if(level.hat_cap == 1) {
          if(level.hatrack[var_8].name != "hat_2")
            level.hatrack[var_8].origin = level.hatrack[var_8].origin + (0, 0, 1);
        }

        waitframe();
        level.hatrack[var_8] setModel(var_7);
        var_9.hat_inventory = "empty";

        if(var_8 == 4) {
          if(level.hatrack[0].name == "hat_1" && level.hatrack[1].name == "hat_2" && level.hatrack[2].name == "hat_3" && level.hatrack[3].name == "hat_4" && level.hatrack[4].name == "hat_5") {
            _id_0380::_id_6844("zmb_berl_leopard", undefined, var_0);

            foreach(var_9 in level.players) {
              wait 1.5;
              var_9 maps\mp\gametypes\zombies::_id_4798(5);
              wait 1.5;
              var_9 maps\mp\gametypes\zombies::_id_4798(2);
              wait 1.5;
              var_9 maps\mp\gametypes\zombies::_id_4798(1945);
            }

            wait 1.5;
            maps\mp\gametypes\zombies::_id_281C("insta_kill", var_1.origin);
            wait 1.5;
            maps\mp\gametypes\zombies::_id_281C("nuke", var_1.origin + (35, 0, 0));
            wait 1.5;
            maps\mp\gametypes\zombies::_id_281C("ammo", var_1.origin + (70, 0, 0));
            wait 1.5;
            maps\mp\gametypes\zombies::_id_281C("double_points", var_1.origin + (105, 0, 0));
            wait 1.5;
            maps\mp\gametypes\zombies::_id_281C("ability_fill", var_1.origin + (140, 0, 0));
            common_scripts\utility::flag_set("flag_hat_stack_ee_complete");
          }
        }

        break;
      }
    }
  }
}