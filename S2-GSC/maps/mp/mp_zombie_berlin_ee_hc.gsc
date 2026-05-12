/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_ee_hc.gsc
**********************************************/

func_00D5() {
  thread hc_quest_bat_init();
  thread hc_quest_dagger_init();
  thread hc_quest_finale_init();
  thread hc_quest_axe_init();
  thread hc_quest_hats_init();
}

_______________________bat_______________________() {}

hc_quest_bat_init() {
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step02_give_jolts_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_step03_open_door_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_bat_give_pp_weapon_complete");
  var_00 = getEntArray("hc_bat_final_room_prop", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

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
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step01_open_register_complete");
  thread hc_quest_bat_step01_generate_code();
  thread hc_quest_bat_step01_radio_code_listen();
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step01_contact_survivor_complete");
  thread hc_quest_bat_step01_cleanup();
}

hc_quest_bat_step01_register_listen() {
  var_00 = getent("hc_smuggler_register", "script_noteworthy");
  var_01 = getent("hc_smuggler_register_clip_open", "script_noteworthy");
  var_01 notsolid();
  var_02 = getent("hc_smuggler_register_trig", "script_noteworthy");
  var_02 method_80B0(var_02 method_85A0() | 256);
  var_03 = getent("hc_register_date", "script_noteworthy");
  var_03 linkto(var_00, "drawer");
  while(!common_scripts\utility::func_3C77("flag_hc_quest_bat_step01_open_register_complete")) {
    var_02 waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    if(var_0D == "wunderbuss_zm") {
      var_00 scriptmodelplayanim("s2_zom_zbr_cash_register_open", "cash_register_open");
      lib_0378::func_8D74("smugglers_bat_cash_register", var_00.var_116);
      var_01 solid();
      common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_open_register_complete");
    }

    wait 0.05;
  }
}

hc_quest_bat_step01_generate_code() {
  var_00 = 15;
  var_01 = 5;
  var_02 = 1;
  var_03 = 12;
  for(;;) {
    var_04 = 0;
    var_05 = 0;
    var_02 = randomintrange(1, 3);
    var_01 = randomintrange(1, 9);
    var_03 = randomintrange(1, 13);
    var_00 = var_02 + "" + var_01;
    var_00 = lib_0547::func_9470(var_00);
    level.hc_smuggler_code_left = var_00;
    level.hc_smuggler_code_right = var_03;
    if(level.hc_smuggler_code_left != level.radio_code_left && abs(level.hc_smuggler_code_left - level.radio_code_left) > 5) {
      var_04 = 1;
    }

    if(level.hc_smuggler_code_right != level.radio_code_right && abs(level.hc_smuggler_code_right - level.radio_code_right) > 5) {
      var_05 = 1;
    }

    if(var_04 && var_05) {
      break;
    }

    wait 0.05;
  }

  if(var_00 < 10) {
    var_06 = "0" + var_00;
  } else {
    var_06 = var_01;
  }

  if(var_03 < 10) {
    var_07 = "0" + var_03;
  } else {
    var_07 = var_04;
  }

  var_08 = getent("hc_register_date", "script_noteworthy");
  var_08 method_8695("TAG_DATE");
  var_09 = "TAG_DATE_T0" + var_02;
  var_08 method_8696(var_09);
  var_0A = "TAG_DATE_D0" + var_01;
  var_08 method_8696(var_0A);
  var_0B = "TAG_DATE_M" + var_07;
  var_08 method_8696(var_0B);
}

hc_quest_bat_step01_radio_code_listen() {
  level endon("flag_hc_quest_bat_step01_contact_survivor_complete");
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  var_00 = 0;
  while(!var_00) {
    while(!maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_right, "right") || !maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_left, "left")) {
      wait 0.05;
    }

    var_01 = 2500;
    var_02 = gettime();
    var_03 = 0;
    while(var_01 > var_03) {
      if(maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_right, "right") && maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(level.hc_smuggler_code_left, "left")) {
        var_03 = gettime() - var_02;
        if(var_01 <= var_03) {
          var_00 = 1;
          break;
        }
      }

      wait 0.05;
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_04 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_04] = [];
  level.possible_radio_codes[var_04]["left"] = level.hc_smuggler_code_left;
  level.possible_radio_codes[var_04]["right"] = level.hc_smuggler_code_right;
  iprintlnbold("You\'ve contacted The Smuggler!");
  wait(2);
  lib_0378::func_8D74("aud_radio_tuning", "smuggler_dialog_playing", "zmb_berl_gsmg_hc_smuggler_intro");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_contact_survivor_complete");
}

hc_quest_bat_step01_cleanup() {}

hc_quest_bat_step02_handler() {
  lib_054D::giveplayersexp("berlin_exp_ref_10");
  thread hc_quest_bat_step02_manhole_wait_for_damage("hc_smuggler_hole_weapon");
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step02_open_gun_cover_complete");
  thread hc_quest_bat_step02_gun_drop_listen();
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step02_give_weapon_complete");
  lib_054D::giveplayersexp("berlin_exp_ref_7");
  thread hc_quest_bat_step02_wave_wait("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  thread hc_quest_bat_step02_manhole_wait_for_damage("hc_smuggler_hole_jolt");
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  thread hc_quest_bat_step02_jolt_drop_listen();
  common_scripts\utility::func_3C9F("flag_hc_quest_bat_step02_give_jolts_complete");
  lib_054D::giveplayersexp("berlin_exp_ref_0");
  hc_quest_bat_step02_cleanup();
}

hc_quest_bat_step02_vo_hole_discovery(param_00) {
  var_01 = self;
  if(param_00 == "hc_smuggler_hole_weapon") {
    var_02 = getent("hc_org_smuggler_hole_weapon_place", "script_noteworthy");
    var_01 lib_0367::func_8E3C("hc_smuggler_found");
    lib_0380::func_6844("zmb_berl_gsmg_hc_smuggler_found", undefined, var_02);
    return;
  }

  if(param_00 == "hc_smuggler_hole_jolt") {
    var_02 = getent("hc_bat_trig_use_jolt_drop", "script_noteworthy");
    var_01 lib_0367::func_8E3C("hc_smuggler_found_jolts");
    lib_0380::func_6844("zmb_berl_gsmg_hc_smuggler_found_jolts", undefined, var_02);
  }
}

hc_quest_bat_step02_ammo_generate() {
  var_00 = randomintrange(0, 3);
  switch (var_00) {
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

  var_01 = getEntArray("hc_smuggler_ammo", "targetname");
  foreach(var_03 in var_01) {
    var_03 method_805C();
  }

  switch (level.survivor_ammo_type) {
    case "12ga":
      var_05 = getEntArray("hc_smuggler_ammo_12ga", "script_noteworthy");
      foreach(var_03 in var_05) {
        var_03 method_805B();
        var_01 = common_scripts\utility::func_F93(var_01, var_03);
      }
      break;

    case "9mm":
      var_08 = getEntArray("hc_smuggler_ammo_9mm", "script_noteworthy");
      foreach(var_03 in var_08) {
        var_03 method_805B();
        var_01 = common_scripts\utility::func_F93(var_01, var_03);
      }
      break;

    case "7.92x57mm":
      var_0B = getEntArray("hc_smuggler_ammo_792", "script_noteworthy");
      foreach(var_03 in var_0B) {
        var_03 method_805B();
        var_01 = common_scripts\utility::func_F93(var_01, var_03);
      }
      break;

    case "10.6x25mm":
      var_0E = getEntArray("hc_smuggler_ammo_revolver", "script_noteworthy");
      foreach(var_03 in var_0E) {
        var_03 method_805B();
        var_01 = common_scripts\utility::func_F93(var_01, var_03);
      }
      break;

    default:
      break;
  }

  foreach(var_03 in var_01) {
    var_03 delete();
  }
}

hc_quest_bat_step02_manhole_wait_for_damage(param_00) {
  var_01 = getEntArray("hc_bat_smuggler_hole_cover", "targetname");
  var_02 = undefined;
  foreach(var_04 in var_01) {
    if(var_04.var_165 == param_00) {
      var_02 = var_04;
    }
  }

  var_06 = getEntArray("hc_trig_dmg_smuggler_hole", "targetname");
  var_07 = undefined;
  var_08 = "smugglers_bat_gas_cover_open_01";
  foreach(var_0A in var_06) {
    if(var_0A.var_165 == param_00) {
      for(;;) {
        var_0A waittill("damage", var_0B, var_07, var_0C, var_0D, var_0E, var_0F, var_10, var_11, var_12, var_13);
        if(param_00 == "hc_smuggler_hole_weapon") {
          var_08 = "smugglers_bat_gas_cover_open_01";
          common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_gun_cover_complete");
        }

        if(param_00 == "hc_smuggler_hole_jolt") {
          var_08 = "smugglers_bat_gas_cover_open_02";
          common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_jolt_cover_complete");
        }

        wait(0.5);
        if(isDefined(var_08)) {
          lib_0378::func_8D74(var_08, var_02.var_116);
        }

        var_02 movey(14, 1.25, 0.25, 0.25);
        break;
      }

      break;
    }
  }

  var_07 thread hc_quest_bat_step02_vo_hole_discovery(param_00);
}

hc_quest_bat_step02_gun_drop_listen() {
  level endon("weapon_given");
  var_00 = getent("hc_bat_trig_use_gun_drop_1", "script_noteworthy");
  var_01 = undefined;
  for(;;) {
    var_00 waittill("trigger", var_02);
    var_03 = var_02 getcurrentprimaryweapon();
    if(!issubstr(var_03, "shovel")) {
      var_02 lib_0586::func_790(var_03);
    } else {
      continue;
    }

    var_02 lib_0367::func_8E3D("hc_smuggler_weapon_given");
    var_04 = var_02 getweaponslistprimaries();
    var_04 = common_scripts\utility::func_F93(var_04, var_03);
    if(var_04.size > 0) {
      var_02 switchtoweapon(var_04[0]);
    } else {
      var_05 = maps\mp\zombies\_zombies_magicbox::func_454B(var_02, "shovel_zm");
      var_02 switchtoweapon(var_05);
    }

    var_06 = getent("hc_org_smuggler_hole_weapon_place", "script_noteworthy");
    var_06.var_92F0 = var_06.var_116;
    var_06.var_92B8 = var_06.var_1D;
    var_06 rotatepitch(-90, 0.05);
    wait 0.05;
    var_06 rotateyaw(90, 0.05);
    wait 0.05;
    lib_0378::func_8D74("smugglers_bat_weapon_drop", var_00.var_116);
    var_07 = "weapon_" + var_03;
    var_08 = spawn(var_07, var_06.var_116);
    var_08 linkto(var_06);
    var_08 makeunusable();
    var_06 movez(-80, 2);
    wait(3);
    var_08 delete();
    var_06.var_116 = var_06.var_92F0;
    var_06.var_1D = var_06.var_92B8;
    var_09 = undefined;
    if(issubstr(var_03, "m30") || issubstr(var_03, "walther") || issubstr(var_03, "winchester1897") || issubstr(var_03, "model21")) {
      var_09 = "12ga";
      var_01 = "smugglers_bat_combat_walther";
    } else if(issubstr(var_03, "mp28") || issubstr(var_03, "mp40") || issubstr(var_03, "m712") || issubstr(var_03, "luger") || issubstr(var_03, "p38") || issubstr(var_03, "sten") || issubstr(var_03, "beretta")) {
      var_09 = "9mm";
      if(issubstr(var_03, "luger") || issubstr(var_03, "p38")) {
        var_01 = "smugglers_bat_combat_p38";
      } else {
        var_01 = "smugglers_bat_combat_mp40";
      }
    } else if(issubstr(var_03, "mg15") || issubstr(var_03, "mg42") || issubstr(var_03, "karabin") || issubstr(var_03, "fg42") || issubstr(var_03, "g43") || issubstr(var_03, "mg81")) {
      var_09 = "7.92x57mm";
      if(issubstr(var_03, "g43") || issubstr(var_03, "karabin")) {
        var_01 = "smugglers_bat_combat_g43";
      } else if(issubstr(var_03, "fg42")) {
        var_01 = "smugglers_bat_combat_fg42";
      } else {
        var_01 = "smugglers_bat_combat_mg42";
      }
    } else if(issubstr(var_03, "reich")) {
      var_09 = "10.6x25mm";
      var_01 = "smugglers_bat_combat_reichrevolver";
    }

    if(isDefined(var_09) && var_09 == level.survivor_ammo_type) {
      iprintlnbold("You hear gunshots coming from the hole in the ground.");
      lib_0380::func_6844("zmb_berl_gsmg_hc_smuggler_weapon_right", undefined, var_06);
      common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_weapon_complete");
      var_00 common_scripts\utility::func_9D9F();
      level.survivor_wep_is_pap = 0;
      if(issubstr(var_03, "pap")) {
        level.survivor_wep_is_pap = 1;
      }

      level notify("weapon_given");
      wait(3);
      if(!isDefined(var_01)) {
        var_01 = "smugglers_bat_combat_mp40";
      }

      lib_0378::func_8D74("smugglers_bat_start_combat_loop", var_00.var_116 - (0, 0, -100), var_01);
    } else {
      wait(1);
      iprintlnbold("I have no bullets for this weapon!");
      lib_0380::func_6844("zmb_berl_gsmg_hc_smuggler_weapon_wrong", undefined, var_06);
    }

    wait(1);
  }
}

hc_quest_bat_step02_wave_wait(param_00) {
  var_01 = level.var_A980 + 2;
  while(level.var_A980 <= var_01) {
    wait(1);
  }

  lib_0378::func_8D74("smugglers_bat_stop_combat_loop");
  common_scripts\utility::func_3C8F(param_00);
}

hc_quest_bat_step02_jolt_drop_listen() {
  level.bat_hc_jolts_dropped = 0;
  var_00 = getent("hc_bat_trig_use_jolt_drop", "script_noteworthy");
  while(!isDefined(level.var_8AD2)) {
    wait 0.05;
  }

  while(level.bat_hc_jolts_dropped < 1500) {
    level waittill("spawned_money_share");
    foreach(var_02 in level.var_8AD2) {
      if(!var_00 method_858B(var_02.var_116)) {
        continue;
      }

      var_03 = var_02.var_117;
      var_04 = var_03 getentitynumber();
      level.bat_hc_jolts_dropped = level.bat_hc_jolts_dropped + 250;
      var_02 maps\mp\zombies\_zombies_money::func_8ADD(var_04, 0);
      var_02.var_6FD4 = 0;
      var_02.var_6FCB = 0;
      iprintlnbold("You drop your jolts into the hole below!");
      var_03 lib_0367::func_8E3D("hc_smuggler_weapon_given");
    }

    wait 0.05;
  }

  var_06 = getent("hc_smuggler_drop_pod", "script_noteworthy");
  var_06 scriptmodelplayanim("s2_zom_drop_pod_open", "smuggler_drop_pod_open");
  iprintlnbold("Danke! Come to my apartment");
  lib_0380::func_6844("zmb_berl_gsmg_hc_smuggler_jolts_used", undefined, var_00);
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_jolts_complete");
}

hc_quest_bat_step02_cleanup() {}

hc_quest_bat_step03_handler() {
  wait(randomfloatrange(27, 42));
  thread hc_quest_bat_step03_door_listen();
}

hc_quest_bat_step03_door_listen() {
  var_00 = getent("hc_bat_dmg_trig_smuggler_door", "script_noteworthy");
  var_01 = 0;
  while(var_01 < 3) {
    var_00 waittill("trigger");
    var_01 = var_01 + 1;
    lib_0378::func_8D74("smugglers_bat_door_pound", var_00.var_116);
  }

  if(level.survivor_wep_is_pap) {
    thread hc_quest_bat_step03_door_open_escaped();
  } else {
    thread hc_quest_bat_step03_door_open_follower();
  }

  foreach(var_03 in level.var_744A) {
    var_03 thread hc_quest_bat_step03_vo_smuggler_room();
  }

  var_05 = getent("bat_pickup_trigger", "targetname");
  maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_05, "bat");
}

hc_quest_bat_step03_door_open_follower() {
  var_00 = getent("hc_bat_smuggler_body", "script_noteworthy");
  var_00 method_805B();
  var_01 = getent("hc_bat_smuggler_bat", "script_noteworthy");
  var_01 method_805B();
  var_02 = common_scripts\utility::func_46B5("hc_bat_smuggler_door_follower_spawner", "targetname");
  var_03 = lib_054D::func_90BA("zombie_heavy", var_02, "smuggler jumpscare", 0, 1, 1);
  var_04 = getent("hc_bat_smuggler_door", "script_noteworthy");
  var_05 = getent("hc_bat_smuggler_door_clip", "script_noteworthy");
  var_05 notsolid();
  var_05 method_8060();
  var_05 solid();
  lib_0378::func_8D74("smugglers_bat_door_break_down", var_04.var_116);
  var_04 rotateroll(-90, 0.25);
  var_04 movez(2, 0.05);
  var_05 movex(100, 0.25);
  wait(0.5);
  var_05 movex(-100, 0.1);
  var_05 delete();
}

hc_quest_bat_step03_door_open_escaped() {
  var_00 = getent("hc_bat_follower_body", "script_noteworthy");
  var_00 method_805B();
  var_01 = getent("hc_bat_follower_bat", "script_noteworthy");
  var_01 method_805B();
  var_02 = getent("hc_bat_smuggler_door", "script_noteworthy");
  var_03 = getent("hc_bat_smuggler_door_clip", "script_noteworthy");
  lib_0378::func_8D74("smugglers_bat_door_open_squeaky", var_02.var_116);
  var_02 rotateyaw(120, 2, 0.8, 0.4);
  var_03 notsolid();
  var_03 method_8060();
  var_04 = getEntArray("hc_bat_smuggler_door_escape", "script_noteworthy");
  foreach(var_06 in var_04) {
    var_06.var_1D = var_06.var_1D - (0, 15, 0);
  }
}

hc_quest_bat_step03_vo_smuggler_room() {
  var_00 = getent("bat_pickup_trigger", "targetname");
  for(;;) {
    if(distance(self.var_116, var_00.var_116) < 100) {
      if(level.survivor_wep_is_pap) {} else {
        lib_0367::func_8E3D("hc_smuggler_dead_found");
        break;
      }
    }

    wait(1);
  }
}

hc_quest_bat_step03_cleanup() {}

hc_quest_bat_debug_start() {
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  if(!isDefined(level.radio_code_left)) {
    level.radio_code_left = 20;
  }

  if(!isDefined(level.radio_code_right)) {
    level.radio_code_right = 11;
  }
}

hc_quest_bat_debug_skip_step01() {
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_contact_survivor_complete");
}

hc_quest_bat_debug_skip_step02_drop_gun() {
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_weapon_complete");
  level.survivor_wep_is_pap = 0;
}

hc_quest_bat_debug_skip_step02() {
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_jolts_complete");
  level.survivor_wep_is_pap = 0;
}

hc_quest_bat_debug_skip_step02_alt() {
  if(!isDefined(level.tuner_values)) {
    level.tuner_values = [];
  }

  level.tuner_values["radio_tuner"] = [];
  level.tuner_values["radio_tuner"]["left"] = 9;
  level.tuner_values["radio_tuner"]["right"] = 50;
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_open_register_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step01_contact_survivor_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_gun_cover_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_weapon_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step_02_smuggler_reached_jolt_drop");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_open_jolt_cover_complete");
  common_scripts\utility::func_3C8F("flag_hc_quest_bat_step02_give_jolts_complete");
  level.survivor_wep_is_pap = 1;
}

_____________________dagger_____________________() {}

hc_quest_dagger_init() {
  common_scripts\utility::func_3C87("flag_hc_quest_dagger_step01_film_reel_complete");
  common_scripts\utility::func_3C87("apartment_dagger_painting_found");
  common_scripts\utility::func_3C87("flag_hc_quest_dagger_step01_painting_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_dagger_step01_projector_on_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_dagger_step02_soul_collection_complete");
  common_scripts\utility::func_3C87("flag_hc_quest_dagger_step03_safe_opened");
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
  common_scripts\utility::func_3CA0("flag_hc_quest_dagger_step01_film_reel_complete", "flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete");
  thread hc_quest_dagger_step01_cleanup();
}

hc_quest_dagger_step01_film_reel() {
  var_00 = getent("film_final_location", "targetname");
  var_01 = getent("film_start_location", "targetname");
  var_02 = getent("film_placed", "targetname");
  var_03 = getent("film_pickup_trigger", "targetname");
  var_04 = getent("projector_use_trig", "targetname");
  var_05 = getent("projector", "targetname");
  var_06 = getent("projector_full", "targetname");
  var_00 method_805C();
  var_02 method_805C();
  var_06 method_805C();
  var_01 setCanDamage(1);
  var_01 waittill("damage");
  lib_0378::func_8D74("ddagger_film_canister_fall", var_01);
  var_07 = var_00.var_116 - var_01.var_116;
  var_08 = sqrt(abs(var_07[2] * 2 / 800));
  var_09 = 1 / var_08;
  var_0A = var_07 * (var_09, var_09, 0);
  var_01 gravitymove(var_0A, var_08);
  var_01 rotateto(var_00.var_1D, var_08);
  wait(var_08);
  var_01.var_116 = var_00.var_116;
  var_01 delete();
  var_00 method_805B();
  var_03 waittill("trigger");
  var_03 delete();
  lib_0378::func_8D74("ddagger_film_canister_pickup", var_00);
  var_00 delete();
  var_04 waittill("trigger");
  var_02 method_805B();
  var_06 method_805B();
  var_05 delete();
  lib_0378::func_8D74("ddagger_projector_attach_reel", var_06.var_116);
  common_scripts\utility::func_3C8F("flag_hc_quest_dagger_step01_film_reel_complete");
  if(common_scripts\utility::func_3C77("flag_hc_quest_dagger_step01_projector_on_complete")) {
    hc_quest_dagger_step02_handler();
  }
}

hc_quest_dagger_step01_painting() {
  var_00 = getEntArray("cabaret_dagger_painting", "targetname");
  var_01 = hc_quest_dagger_step01_painting_get_org(var_00);
  foreach(var_03 in var_00) {
    if(var_03 != var_01) {
      var_03 method_805C();
    }
  }

  var_05 = getent("apartment_dagger_painting_trig", "targetname");
  var_05 waittill("trigger");
  var_05 delete();
  common_scripts\utility::func_3C8F("apartment_dagger_painting_found");
  lib_054D::giveplayersexp("berlin_exp_ref_1");
  var_06 = getEntArray("apartment_dagger_painting", "targetname");
  var_07 = hc_quest_dagger_step01_painting_get_org(var_06);
  lib_0378::func_8D74("ddagger_picture_remove", var_07.var_116);
  hc_quest_dagger_step01_painting_apartment_cleanup(var_06);
  var_08 = getent("projector_use_trig", "targetname");
  var_08 waittill("trigger", var_09);
  lib_0378::func_8D74("ddagger_picture_placement", var_01.var_116);
  hc_quest_dagger_step01_painting_place_on_projector(var_00, var_01);
  common_scripts\utility::func_3C8F("flag_hc_quest_dagger_step01_painting_complete");
}

hc_quest_dagger_step01_painting_get_org(param_00) {
  var_01 = undefined;
  foreach(var_03 in param_00) {
    if(var_03.var_3A == "script_origin") {
      var_01 = var_03;
      break;
    }
  }

  return var_01;
}

hc_quest_dagger_step01_painting_apartment_cleanup(param_00) {
  foreach(var_02 in param_00) {
    var_02 delete();
  }
}

hc_quest_dagger_step01_painting_place_on_projector(param_00, param_01) {
  foreach(var_03 in param_00) {
    if(var_03.var_3A != "script_origin") {
      var_03 method_805B();
      var_03 method_8449(param_01);
    }
  }

  var_05 = getent("painting_end_org", "targetname");
  param_01 moveto(var_05.var_116, 2, 1, 1);
  param_01 rotateto(var_05.var_1D, 2, 1, 1);
}

hc_quest_dagger_step01_turn_on_projector() {
  var_00 = getent("projector_damage_trig", "targetname");
  var_00 method_80B0(var_00 method_85A0() | 256);
  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(var_0A == "wunderbuss_zm") {
      break;
    } else {
      wait 0.05;
    }
  }

  level childthread common_scripts\_exploder::func_88E(204);
  var_0B = getent("projector", "targetname");
  var_0C = getent("projector_full", "targetname");
  if(isDefined(var_0B)) {
    var_0B method_8278("hub_movie_projector_anim_01");
  }

  var_0C method_8278("hub_movie_projector_anim_01");
  lib_0378::func_8D74("ddagger_projector_on", var_0C.var_116);
  common_scripts\utility::func_3C8F("flag_hc_quest_dagger_step01_projector_on_complete");
  if(common_scripts\utility::func_3C77("flag_hc_quest_dagger_step01_film_reel_complete")) {
    hc_quest_dagger_step02_handler();
  }
}

hc_quest_dagger_step01_turn_on_projection() {
  var_00 = getent("map_projection", "targetname");
  var_00 method_805C();
  common_scripts\utility::func_3CA0("flag_hc_quest_dagger_step01_painting_complete", "flag_hc_quest_dagger_step01_projector_on_complete");
  level notify("suspend_node_vfx");
  lib_054D::giveplayersexp("berlin_exp_ref_15");
  wait(1.75);
  var_00 method_805B();
  level notify("resume_node_vfx");
}

hc_quest_dagger_step01_cleanup() {
  var_00 = getent("projector_use_trig", "targetname");
  if(isDefined(var_00)) {
    var_00 delete();
  }
}

hc_quest_dagger_step02_handler() {
  thread hc_quest_dagger_step02_collection_think();
  common_scripts\utility::func_3C9F("flag_hc_quest_dagger_step02_soul_collection_complete");
  thread hc_quest_dagger_step02_cleanup();
}

hc_quest_dagger_step02_collection_think() {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_00 = common_scripts\utility::func_46B7("hc_quest_dagger_soulbucket_map_node", "targetname");
  level.safe_combination = [];
  var_01 = hc_quest_dagger_step02_get_random_collection_nodes(var_00);
  level.current_bucket_node = undefined;
  while(!common_scripts\utility::func_3C77("flag_hc_quest_dagger_step03_safe_opened")) {
    for(var_02 = 0; var_02 < 4; var_02++) {
      level.current_bucket_node = var_01[var_02];
      hc_quest_dagger_step02_waitfor_node_collection_complete(var_01[var_02]);
    }

    common_scripts\utility::func_3C8F("flag_hc_quest_dagger_step02_soul_collection_complete");
  }
}

hc_quest_dagger_step02_get_random_collection_nodes(param_00, param_01) {
  param_00 = common_scripts\utility::func_F92(param_00);
  var_02 = [];
  var_03 = undefined;
  var_04 = undefined;
  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  for(var_05 = 0; var_05 < param_01; var_05++) {
    var_02[var_05] = param_00[var_05];
    var_04 = randomintrange(4, 10);
    if(isDefined(var_03) && var_04 == var_03) {
      var_04 = var_04 - 1;
    }

    var_03 = var_04;
    var_02[var_05].var_A281 = var_04;
    var_02[var_05].collection_radius = 192;
    level.safe_combination[var_05] = var_02[var_05].var_A281;
  }

  return var_02;
}

hc_quest_dagger_step02_waitfor_node_collection_complete(param_00) {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_01 = common_scripts\utility::func_46B5(param_00.var_165, "targetname");
  if(!isDefined(param_00.tag_org)) {
    param_00.tag_org = spawn("script_model", param_00.var_116);
    param_00.tag_org setModel("tag_origin");
  }

  playFXOnTag(level.var_611["projection_light"], param_00.tag_org, "tag_origin");
  if(!common_scripts\utility::func_3C77("flag_hc_quest_dagger_step01_painting_complete")) {
    thread hc_quest_dagger_step02_waitfor_node_collection_suspend(param_00);
  }

  if(!common_scripts\utility::func_3C77("flag_hc_quest_dagger_step01_projector_on_complete")) {
    common_scripts\utility::func_3C9F("flag_hc_quest_dagger_step01_projector_on_complete");
  }

  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("tag_origin");
  var_01 thread hc_quest_dagger_step02_waitfor_node_collection_additional_fx(var_02);
  if(isDefined(var_01.var_14F)) {
    param_00.collection_radius = var_01.var_14F;
  }

  var_02.ignoresighttrace = 1;
  var_02 maps\mp\mp_zombies_soul_collection::func_170B(param_00.var_A281, param_00.collection_radius, param_00.collection_radius, "zmb_dagger_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_01 notify("stop_monitoring_collection");
  var_02 common_scripts\utility::func_2CBE(2, ::delete);
  killfxontag(level.var_611["projection_light"], param_00.tag_org, "tag_origin");
}

hc_quest_dagger_step02_waitfor_node_collection_additional_fx(param_00) {
  self endon("stop_monitoring_collection");
  for(;;) {
    level waittill("zmb_dagger_collection_kill", var_01);
    if(var_01 == self) {
      playFXOnTag(level.var_611["zmb_hc_bucket_indic"], param_00, "tag_origin");
    }

    wait 0.05;
  }
}

hc_quest_dagger_step02_waitfor_node_collection_suspend(param_00) {
  level waittill("suspend_node_vfx");
  killfxontag(level.var_611["projection_light"], param_00.tag_org, "tag_origin");
  level waittill("resume_node_vfx");
  playFXOnTag(level.var_611["projection_light"], param_00.tag_org, "tag_origin");
}

hc_quest_dagger_step02_cleanup() {
  common_scripts\utility::func_3C9F("flag_hc_quest_dagger_step03_safe_opened");
  if(isDefined(level.current_bucket_node) && isDefined(level.current_bucket_node.tag_org)) {
    killfxontag(level.var_611["projection_light"], level.current_bucket_node.tag_org, "tag_origin");
  }
}

hc_quest_dagger_step03_handler() {
  common_scripts\utility::func_3C9F("flag_hc_quest_dagger_step03_safe_opened");
  thread hc_quest_dagger_step03_safe_open();
  thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(level.safe_use_trig, "dagger");
  hc_quest_dagger_step03_cleanup();
}

hc_quest_dagger_step03_safe_think() {
  level endon("flag_hc_quest_dagger_step03_safe_opened");
  var_00 = getEntArray("dagger_safe", "targetname");
  level.safe_use_trig = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  level.dagger_safe_knob = undefined;
  foreach(var_05 in var_00) {
    switch (var_05.var_8260) {
      case "safe_link_org":
        var_02 = var_05;
        break;

      case "safe_player_org":
        var_01 = var_05;
        break;

      case "safe_use_trig":
        level.safe_use_trig = var_05;
        break;

      case "safe_knob":
        var_03 = var_05;
        break;

      case "safe_knob_origin":
        level.dagger_safe_knob = var_05;
        break;

      case "safe_model":
        level.dagger_safe = var_05;
        break;

      default:
        break;
    }
  }

  var_03 method_8449(level.dagger_safe_knob);
  level.correct_safe_combo_used = 0;
  level.final_number = 0;
  while(!common_scripts\utility::func_3C77("flag_hc_quest_dagger_step03_safe_opened") && !level.correct_safe_combo_used || !level.final_number) {
    level.safe_use_trig waittill("trigger", var_07);
    if(var_07 method_83B8() || var_07 method_82E5()) {
      continue;
    }

    var_08 = var_07;
    var_08 method_8322();
    if(var_08 getstance() != "stand") {
      var_08 setstance("stand");
      wait(0.7);
    }

    var_08 method_812C(0);
    var_09 = var_07.var_116;
    var_0A = var_07.var_1D;
    var_01.var_116 = var_09;
    var_01.var_1D = var_0A;
    var_08 playerlinkto(var_01, undefined, 0.1, 0, 0, 0, 0);
    var_01 moveto(var_02.var_116, 0.5, 0, 0);
    var_01 rotateto(var_02.var_1D, 0.5, 0, 0);
    wait(0.5);
    var_08 thread hc_quest_dagger_step03_safe_attempt_unlock();
    var_08 waittill("stop_using_station");
    if(level.final_number && level.correct_safe_combo_used) {
      self notify("safe_code_correct");
    }

    var_08 method_8323();
    var_01 moveto(var_09 + (0, 0, 1), 0.5);
    var_01 rotateto(var_0A, 0.5);
    wait(0.5);
    var_08 unlink();
    var_08 method_812C(1);
    var_08 setstance("stand");
    wait(0.5);
  }

  common_scripts\utility::func_3C8F("flag_hc_quest_dagger_step03_safe_opened");
}

hc_quest_dagger_step03_safe_attempt_unlock() {
  self endon("stop_using_station");
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_death();
  var_00 = common_scripts\utility::func_55E0();
  var_01 = var_00;
  var_02 = !var_00;
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_unuse(level.safe_use_trig, var_01, var_02);
  if(!isDefined(level.safe_combination) || level.safe_combination.size < 4) {
    hc_quest_dagger_step03_safe_fake_input();
  }

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
  if(common_scripts\utility::func_55E0()) {
    hc_quest_dagger_safe_reset_input_difference_gamepad();
  }
}

hc_quest_dagger_safe_get_input_difference() {
  if(common_scripts\utility::func_55E0()) {
    return hc_quest_dagger_safe_get_next_input_difference_gamepad();
  }

  return hc_quest_dagger_safe_get_input_difference_pc();
}

hc_quest_dagger_safe_get_input_difference_pc() {
  var_00 = self getnormalizedmovement();
  var_01 = var_00[1];
  var_02 = 0.125;
  if(self method_83C1()) {
    var_02 = var_02 * 6;
  }

  return var_02 * var_01;
}

hc_quest_dagger_safe_reset_input_difference_gamepad() {
  self.safe_previous_stick_input = self getnormalizedmovement();
}

hc_quest_dagger_safe_get_next_input_difference_gamepad() {
  var_00 = self getnormalizedmovement();
  if(abs(var_00[0]) < 0.99 && abs(var_00[1]) < 0.99) {
    self.safe_previous_stick_input = (0, 0, 0);
    return 0;
  }

  if(self.safe_previous_stick_input == (0, 0, 0) || var_00 == (0, 0, 0)) {
    self.safe_previous_stick_input = var_00;
    return 0;
  }

  var_01 = hc_quest_dagger_step03_safe_get_input(self.safe_previous_stick_input, var_00);
  self.safe_previous_stick_input = var_00;
  if(!isDefined(var_01)) {
    return 0;
  }

  return var_01;
}

hc_quest_dagger_step03_safe_fake_input() {
  self endon("stop_using_station");
  var_00 = undefined;
  hc_quest_dagger_safe_reset_input_difference();
  while(!isDefined(level.safe_combination) || level.safe_combination.size < 4) {
    wait 0.05;
    var_01 = hc_quest_dagger_safe_get_input_difference();
    if(!isDefined(var_01) || var_01 == 0) {
      continue;
    }

    var_00 = hc_quest_dagger_step03_safe_update_dial(var_01);
  }
}

hc_quest_dagger_step03_safe_waitfor_input_outcome(param_00, param_01, param_02) {
  self endon("stop_using_station");
  var_03 = undefined;
  var_04 = 1;
  var_05 = 0;
  var_06 = 1;
  hc_quest_dagger_safe_reset_input_difference();
  while(var_04 || isDefined(param_02) && param_02) {
    wait 0.05;
    var_07 = hc_quest_dagger_safe_get_input_difference();
    var_03 = hc_quest_dagger_step03_safe_update_dial(var_07, param_00);
    if(isDefined(param_02) && param_02) {
      if(var_03 == param_00) {
        level.correct_safe_combo_used = 1;
      } else {
        level.correct_safe_combo_used = 0;
      }
    }

    if((param_01 == "left" && var_07 > 0) || param_01 == "right" && var_07 < 0) {
      var_04 = 0;
      if(var_05 < var_06) {
        var_05++;
        var_04 = 1;
      }

      continue;
    }

    var_05 = 0;
  }

  return isDefined(var_03) && var_03 == param_00;
}

hc_quest_dagger_step03_safe_waitfor_direction_rotation(param_00) {
  self endon("stop_using_station");
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  hc_quest_dagger_safe_reset_input_difference();
  while(!var_01) {
    wait 0.05;
    var_04 = hc_quest_dagger_safe_get_input_difference();
    var_05 = hc_quest_dagger_step03_safe_update_dial(var_04);
    if((param_00 == "left" && var_04 < 0) || param_00 == "right" && var_04 > 0) {
      var_01 = 1;
      if(var_02 < var_03) {
        var_02++;
        var_01 = 0;
      }
    }
  }
}

hc_quest_dagger_step03_safe_get_input(param_00, param_01) {
  self endon("stop_using_station");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = 0;
  if(param_01[0] > 0 && param_01[1] > 0) {
    var_03 = 1;
    if(param_00[0] > param_01[0]) {
      var_02 = 1;
    } else if(param_00[1] < param_01[1]) {
      var_02 = 1;
    }

    if(param_00 != param_01 && !isDefined(var_02)) {
      var_02 = 0;
    }

    var_05 = abs(param_00[0] - param_01[0]);
    var_06 = abs(param_00[1] - param_01[1]);
    var_04 = var_05 + var_06;
  } else if(param_01[0] < 0 && param_01[1] > 0) {
    var_03 = 2;
    if(param_00[0] > param_01[0]) {
      var_02 = 1;
    } else if(param_00[1] > param_01[1]) {
      var_02 = 1;
    }

    if(param_00 != param_01 && !isDefined(var_02)) {
      var_02 = 0;
    }

    var_05 = abs(param_00[0] - param_01[0]);
    var_06 = abs(param_00[1] - param_01[1]);
    var_04 = var_05 + var_06;
  } else if(param_01[0] < 0 && param_01[1] < 0) {
    var_03 = 3;
    if(param_00[0] < param_01[0]) {
      var_02 = 1;
    } else if(param_00[1] > param_01[1]) {
      var_02 = 1;
    }

    if(param_00 != param_01 && !isDefined(var_02)) {
      var_02 = 0;
    }

    var_05 = abs(param_00[0] - param_01[0]);
    var_06 = abs(param_00[1] - param_01[1]);
    var_04 = var_05 + var_06;
  } else if(param_01[0] > 0 && param_01[1] < 0) {
    var_03 = 4;
    if(param_00[0] < param_01[0]) {
      var_02 = 1;
    } else if(param_00[1] < param_01[1]) {
      var_02 = 1;
    }

    if(param_00 != param_01 && !isDefined(var_02)) {
      var_02 = 0;
    }

    var_05 = abs(param_00[0] - param_01[0]);
    var_06 = abs(param_00[1] - param_01[1]);
    var_04 = var_05 + var_06;
  }

  if(isDefined(var_03)) {
    if(param_00[0] > 0 && param_00[1] > 0) {
      if(var_03 == 4) {
        var_02 = 0;
      }
    } else if(param_00[0] < 0 && param_00[1] > 0) {
      if(var_03 == 1) {
        var_02 = 0;
      }
    } else if(param_00[0] < 0 && param_00[1] < 0) {
      if(var_03 == 2) {
        var_02 = 0;
      }
    } else if(param_00[0] > 0 && param_00[1] < 0) {
      if(var_03 == 3) {
        var_02 = 0;
      }
    }
  }

  if(!isDefined(var_02)) {
    return undefined;
  }

  if(var_02) {
    return var_04;
  }

  return var_04 * -1;
}

hc_quest_dagger_step03_safe_update_dial(param_00, param_01) {
  self endon("stop_using_station");
  var_02 = undefined;
  if(!isDefined(level.tick_sound_offset)) {
    level.tick_sound_offset = 0;
  }

  var_03 = 12;
  var_04 = 10;
  var_05 = 360 / var_04;
  var_06 = 5;
  var_07 = 0;
  var_08 = 0;
  var_09 = 18;
  var_08 = angleclamp360(level.dagger_safe_knob.var_1D[2] - param_00 * 10);
  level.dagger_safe_knob.var_1D = (level.dagger_safe_knob.var_1D[0], level.dagger_safe_knob.var_1D[1], var_08);
  var_0A = var_07 + var_08 % var_05 - var_09;
  level.anglerem = var_0A;
  if(var_0A < var_03) {
    var_02 = int(var_08 / 360 * 10) % var_04;
  }

  if(isDefined(var_02)) {
    var_02 = var_02 + var_06 % var_04;
  }

  if(!isDefined(var_02)) {
    var_02 = -1;
  }

  level.tick_sound_offset = level.tick_sound_offset + param_00;
  if(abs(level.tick_sound_offset) >= 1) {
    lib_0378::func_8D74("ddagger_vault_tick", level.dagger_safe_knob.var_116);
    level.tick_sound_offset = 0;
  }

  return var_02;
}

hc_quest_dagger_step03_safe_open() {
  level.dagger_safe_knob common_scripts\utility::func_2CBE(1, ::method_8449, level.dagger_safe, "handle");
  level.dagger_safe method_8495("s2_zom_safe_open", level.dagger_safe.var_116, level.dagger_safe.var_1D);
  maps\mp\_utility::func_2CED(0.5, ::lib_0378::func_8D74, "ddagger_vault_handle_open", level.dagger_safe_knob.var_116);
  maps\mp\_utility::func_2CED(2.25, ::lib_0378::func_8D74, "ddagger_vault_door_open", level.dagger_safe.var_116);
  wait(getanimlength(%s2_zom_safe_open));
  level.dagger_safe method_8495("s2_zom_safe_open_idle", level.dagger_safe.var_116, level.dagger_safe.var_1D);
  wait(3);
  foreach(var_01 in level.var_744A) {
    if(distance(var_01.var_116, level.dagger_safe.var_116) < 200) {
      var_01 lib_0367::func_8E3D("hc_dagger_reveal");
    }
  }
}

hc_quest_dagger_step03_cleanup() {}

_____________________axe_______________________() {}

hc_quest_axe_init() {
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step01_radio_station_found");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step01_map_pin_found");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step01_map_location_found");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step02_obtained_scale_cup");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step02_placed_scale_cup");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_carrying_fodder_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_carrying_pest_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_carrying_sizzler_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_placed_fodder_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_placed_pest_armored_head");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_placed_another_thing");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step04_opened_museum_compartment");
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step04_obtained_axe");
  var_00 = getent("hc_ee_axe_scale_sizzler_head", "script_noteworthy");
  var_01 = getent("hc_ee_axe_scale_cup", "script_noteworthy");
  var_02 = getent("hc_ee_axe_scale_cup_church", "script_noteworthy");
  var_03 = getent("hc_ee_axe_scale_needle", "script_noteworthy");
  var_04 = getent("map_board_mover_selector", "script_noteworthy");
  var_00 method_805C();
  var_01 method_805C();
  var_04 method_805C();
  var_03 rotatepitch(30, 1, 0.25, 0.25);
  var_05 = getEntArray("hc_ee_axe_radiocode_0_a", "script_noteworthy");
  var_06 = getEntArray("hc_ee_axe_radiocode_0_b", "script_noteworthy");
  var_07 = getEntArray("hc_ee_axe_radiocode_1_a", "script_noteworthy");
  var_08 = getEntArray("hc_ee_axe_radiocode_1_b", "script_noteworthy");
  var_09 = getEntArray("hc_ee_axe_radiocode_2_a", "script_noteworthy");
  var_0A = getEntArray("hc_ee_axe_radiocode_2_b", "script_noteworthy");
  var_0B = common_scripts\utility::func_F8C(var_05, var_06);
  var_0C = common_scripts\utility::func_F8C(var_07, var_08);
  var_0D = common_scripts\utility::func_F8C(var_09, var_0A);
  var_0E = common_scripts\utility::func_F8C(var_0B, var_0C);
  var_0F = common_scripts\utility::func_F8C(var_0E, var_0D);
  foreach(var_11 in var_0F) {
    var_11 method_805C();
  }

  var_13 = 29;
  var_14 = 89;
  var_15 = 15;
  var_16 = 12;
  var_17 = randomint(3);
  switch (var_17) {
    case 0:
      var_13 = 20.3;
      var_14 = 66.8;
      randomize_code_hint_location(var_17, var_05, var_06);
      foreach(var_11 in var_0C) {
        var_11 delete();
      }

      foreach(var_11 in var_0D) {
        var_11 delete();
      }
      break;

    case 1:
      var_13 = 38.9;
      var_14 = 82.4;
      randomize_code_hint_location(var_17, var_07, var_08);
      foreach(var_11 in var_0B) {
        var_11 delete();
      }

      foreach(var_11 in var_0D) {
        var_11 delete();
      }
      break;

    case 2:
      var_13 = 56.1;
      var_14 = 82.4;
      randomize_code_hint_location(var_17, var_09, var_0A);
      foreach(var_11 in var_0B) {
        var_11 delete();
      }

      foreach(var_11 in var_0C) {
        var_11 delete();
      }
      break;

    default:
      break;
  }

  var_24 = randomint(5);
  switch (var_24) {
    case 0:
      var_16 = 12;
      var_15 = 15;
      break;

    case 1:
      var_16 = 18;
      var_15 = 5;
      break;

    case 2:
      var_16 = 10;
      var_15 = 8;
      break;

    case 3:
      var_16 = 19;
      var_15 = 21;
      break;

    case 4:
      var_16 = 8;
      var_15 = 11;
      break;

    default:
      break;
  }

  level thread hc_quest_axe_map_pin_found(var_04);
  level.bat_hc_radio_code_left = var_13;
  level.bat_hc_radio_code_right = var_14;
  level thread quest_step_use_radio_codes_listener(var_14, var_13, var_24);
  common_scripts\utility::func_3C9F("flag_hc_quest_axe_step01_map_pin_found");
  level thread map_board_think();
  level thread hc_quest_axe_map_board_check_solution(var_15, var_16);
  level thread hc_quest_axe_find_scale_pickup(var_02);
  level thread hc_quest_axe_placed_scale_in_museum(var_00, var_01, var_03);
  common_scripts\utility::func_3C9F("flag_hc_quest_axe_step02_placed_scale_cup");
  level thread hc_quest_axe_sizzler_kill_init();
  level thread hc_quest_axe_enemykilled_sizzlerneararmor();
}

randomize_code_hint_location(param_00, param_01, param_02) {
  var_03 = randomint(2);
  switch (var_03) {
    case 0:
      foreach(var_05 in param_01) {
        var_05 method_805B();
      }

      foreach(var_05 in param_02) {
        var_05 delete();
      }
      break;

    case 1:
      foreach(var_05 in param_02) {
        var_05 method_805B();
      }

      foreach(var_05 in param_01) {
        var_05 delete();
      }
      break;

    default:
      break;
  }
}

quest_step_use_radio_codes_listener(param_00, param_01, param_02) {
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_contact_hq", "step_use_radio"));
  var_03 = 0;
  while(!var_03) {
    while(!maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(param_00, "right") || !maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(param_01, "left")) {
      wait 0.05;
    }

    var_04 = 2500;
    var_05 = gettime();
    var_06 = 0;
    while(var_04 > var_06) {
      if(maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(param_00, "right") && maps\mp\mp_zombie_berlin_ee::quest_step_use_radio_codes_check(param_01, "left")) {
        var_06 = gettime() - var_05;
        if(var_04 <= var_06) {
          var_03 = 1;
          break;
        }
      }

      wait 0.05;
    }
  }

  if(!isDefined(level.possible_radio_codes)) {
    level.possible_radio_codes = [];
  }

  var_07 = level.possible_radio_codes.size;
  level.possible_radio_codes[var_07] = [];
  level.possible_radio_codes[var_07]["left"] = param_01;
  level.possible_radio_codes[var_07]["right"] = param_00;
  thread maps\mp\mp_zombie_berlin_utils::radio_system_suspend_tuning_for_response();
  switch (param_02) {
    case 0:
      lib_0378::func_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_12_15");
      break;

    case 1:
      lib_0378::func_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_18_5");
      break;

    case 2:
      lib_0378::func_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_10_8");
      break;

    case 3:
      lib_0378::func_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_19_21");
      break;

    case 4:
      lib_0378::func_8D74("aud_radio_tuning", "morse_code", "zmb_berl_radio_morse_8_11");
      break;

    default:
      break;
  }
}

map_board_think() {
  var_00 = getEntArray("berlin_map_board", "targetname");
  common_scripts\utility::func_3C87("map_interaction_disabled");
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  level.mapboard_pos = [1, 1];
  var_04 = getent("map_board_mover_selector", "script_noteworthy");
  level.map_start_pos = common_scripts\utility::func_46B5("map_board_start_pos", "script_noteworthy");
  foreach(var_06 in var_00) {
    if(isDefined(var_06.var_8260)) {
      switch (var_06.var_8260) {
        case "map_board_link_org":
          var_03 = var_06;
          break;

        case "map_board_player_org":
          var_02 = var_06;
          break;

        case "map_board_use_trig":
          var_01 = var_06;
          break;

        default:
          break;
      }
    }
  }

  while(!common_scripts\utility::func_3C77("map_interaction_disabled")) {
    var_01 waittill("trigger", var_08);
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
    var_02.var_116 = var_0A;
    var_02.var_1D = var_0B;
    var_09 playerlinkto(var_02, undefined, 0.1, 0, 0, 0, 0);
    var_02 moveto(var_03.var_116, 0.5, 0, 0);
    var_02 rotateto(var_03.var_1D, 0.5, 0, 0);
    wait(0.5);
    var_09 thread map_board_start_moving(var_01);
    var_09 waittill("stop_using_station");
    level notify("stop_using_mapboard");
    var_09 method_8323();
    var_02 moveto(var_0A + (0, 0, 1), 0.5);
    var_02 rotateto(var_0B, 0.5);
    wait(0.5);
    var_09 unlink();
    var_09 method_812C(1);
    var_09 setstance("stand");
    wait(0.5);
  }
}

map_board_start_moving(param_00) {
  self endon("stop_using_station");
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_death();
  var_01 = common_scripts\utility::func_55E0();
  var_02 = var_01;
  var_03 = !var_01;
  thread maps\mp\mp_zombie_berlin_utils::lockin_system_monitor_unuse(param_00, var_02, var_03);
  map_board_handle_inputs();
}

map_board_handle_inputs() {
  self endon("stop_using_station");
  level endon("map_interaction_disabled");
  var_00 = [0, 0, 0];
  var_01 = [0, 0, 0];
  for(;;) {
    var_00 = self getnormalizedmovement();
    if(abs(var_00[0]) > abs(var_00[1])) {
      var_00 = (var_00[0], 0, 0);
    } else if(abs(var_00[1]) > abs(var_00[0])) {
      var_00 = (0, var_00[1], 0);
    }

    if(var_00[0] != 0 || var_00[1] != 0) {
      map_board_update_mover(var_00);
      wait(0.25);
      continue;
    }

    wait 0.05;
  }
}

map_board_update_mover(param_00) {
  var_01 = self.var_116;
  var_02 = var_01;
  var_03 = getent("map_board_mover_selector", "script_noteworthy");
  var_03 map_board_send_mover_to_offsets(param_00[0], param_00[1]);
}

map_board_send_mover_to_offsets(param_00, param_01) {
  var_02 = self.var_116;
  if(param_00 > 0.8 && level.mapboard_pos[0] > 1) {
    level.mapboard_pos[0] = level.mapboard_pos[0] - 1;
    var_02 = self.var_116 + (0, 0, 2);
  }

  if(param_00 < -0.8 && level.mapboard_pos[0] < 25) {
    level.mapboard_pos[0] = level.mapboard_pos[0] + 1;
    var_02 = self.var_116 - (0, 0, 2);
  }

  if(param_01 < -0.8 && level.mapboard_pos[1] > 1) {
    level.mapboard_pos[1] = level.mapboard_pos[1] - 1;
    var_02 = self.var_116 + (0, 2, 0);
  }

  if(param_01 > 0.8 && level.mapboard_pos[1] < 25) {
    level.mapboard_pos[1] = level.mapboard_pos[1] + 1;
    var_02 = self.var_116 - (0, 2, 0);
  }

  self.var_116 = var_02;
}

hc_quest_axe_map_board_check_solution(param_00, param_01) {
  while(!common_scripts\utility::func_3C77("flag_hc_quest_axe_step01_map_location_found")) {
    level waittill("stop_using_mapboard");
    if(level.mapboard_pos[0] == param_00 && level.mapboard_pos[1] == param_01) {
      common_scripts\utility::func_3C8F("flag_hc_quest_axe_step01_map_location_found");
      iprintlnbold("You done it!");
      wait(0.5);
      var_02 = getent("mapboard_lockbox_door", "script_noteworthy");
      var_02 lib_0378::func_8D74("aud_axe_hc_amoire_open");
      var_02 rotateyaw(42, 1, 0.25, 0.25);
    }
  }
}

hc_quest_axe_find_scale_pickup(param_00) {
  var_01 = getent("map_board_take_scale", "script_noteworthy");
  while(!common_scripts\utility::func_3C77("flag_hc_quest_axe_step02_obtained_scale_cup")) {
    var_01 waittill("trigger", var_02);
    if(common_scripts\utility::func_3C77("flag_hc_quest_axe_step01_map_location_found")) {
      common_scripts\utility::func_3C8F("flag_hc_quest_axe_step02_obtained_scale_cup");
      lib_0378::func_8D74("aud_axe_hc_pickup_scale", param_00.var_116);
      iprintlnbold("You got the golden scale cup!");
      param_00 delete();
    }

    wait(0.5);
  }

  lib_054D::giveplayersexp("berlin_exp_ref_13");
  var_01 delete();
}

hc_quest_axe_placed_scale_in_museum(param_00, param_01, param_02) {
  var_03 = getent("scale_use", "script_noteworthy");
  while(!common_scripts\utility::func_3C77("flag_hc_quest_axe_step02_placed_scale_cup")) {
    var_03 waittill("trigger", var_04);
    if(common_scripts\utility::func_3C77("flag_hc_quest_axe_step02_obtained_scale_cup")) {
      common_scripts\utility::func_3C8F("flag_hc_quest_axe_step02_placed_scale_cup");
      iprintlnbold("You returned the golden scale cup to its rightful location.");
      lib_0378::func_8D74("aud_axe_hc_place_scale_piece", param_01);
      param_01 method_805B();
      param_02 rotatepitch(-5, 1, 0.25, 0.25);
    }

    wait(0.5);
  }

  while(!common_scripts\utility::func_3C77("flag_hc_quest_axe_step03_placed_sizzler_armored_head")) {
    var_03 waittill("trigger", var_04);
    if(isDefined(level.hc_axe_ee_head_carried)) {
      switch (level.hc_axe_ee_head_carried) {
        case "flag_hc_quest_axe_step03_carrying_sizzler_armored_head":
          common_scripts\utility::func_3C8F("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
          iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          lib_0378::func_8D74("aud_axe_hc_place_head", param_00);
          param_00 method_805B();
          param_02 rotatepitch(-25, 1, 0.25, 0.25);
          if(param_00.var_106 != "zom_sizzler_head_gib") {
            param_00 setModel("zom_sizzler_head_gib");
          }
          break;

        case "flag_hc_quest_axe_step03_carrying_fodder_armored_head":
          common_scripts\utility::func_3C8F("flag_hc_quest_axe_step03_placed_fodder_armored_head");
          iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          param_00 method_805B();
          param_00 setModel("zom_ger_head_fdr_03_gib");
          param_02 rotatepitch(-15, 1, 0.25, 0.25);
          break;

        case "flag_hc_quest_axe_step03_carrying_pest_armored_head":
          common_scripts\utility::func_3C8F("flag_hc_quest_axe_step03_placed_pest_armored_head");
          iprintlnbold("You placed the geistchild charged zombie head on the scale.");
          param_00 method_805B();
          param_00 setModel("zom_ger_head_spr_01_gib");
          param_02 rotatepitch(-10, 1, 0.25, 0.25);
          break;

        default:
          break;
      }
    }

    wait(0.5);
  }

  lib_0547::func_2D8C(::hc_quest_axe_enemykilled_sizzlerneararmor);
  lib_054D::giveplayersexp("berlin_exp_ref_8");
  var_05 = getent("hc_ee_axe_scale_soul_collector", "script_noteworthy");
  var_05 maps\mp\mp_zombies_soul_collection::func_170B(10, 140, 100, "zmb_hc_ee_axe_scale_zombie_killed", undefined, "tag_origin", undefined, "tag_origin");
  iprintlnbold("The Nazi War Axe is revealed beneath the scale!");
  var_06 = getent("hc_ee_axe_scale_drawer", "script_noteworthy");
  var_07 = getent("hc_ee_axe_pickup_axe", "script_noteworthy");
  var_08 = getent("hc_ee_axe_origin_mover", "script_noteworthy");
  var_06 method_8449(var_08);
  var_07 method_8449(var_08);
  lib_0378::func_8D74("aud_axe_hc_drawer_open", var_06);
  var_08 movey(-15, 1.5, 0.3, 0.3);
  foreach(var_04 in level.var_744A) {
    if(distance(var_04.var_116, level.dagger_safe.var_116) < 200) {
      var_04 lib_0367::func_8E3D("hc_axe_reveal");
    }
  }

  var_0B = getent("axe_pickup_trigger", "targetname");
  level thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_0B, "pickaxe");
}

test_bunny_collection() {
  var_00 = getent("hc_ee_axe_scale_soul_collector", "script_noteworthy");
  var_00 maps\mp\mp_zombies_soul_collection::func_170B(10, 140, 100, "zmb_hc_ee_axe_scale_zombie_killed", undefined, "tag_origin", undefined, "tag_origin");
}

hc_quest_axe_sizzler_kill_init() {
  lib_0547::func_7BA9(::hc_quest_axe_enemykilled_sizzlerneararmor);
  level.armor_machines = common_scripts\utility::func_46B7("armor_buy", "targetname");
}

hc_quest_axe_enemykilled_sizzlerneararmor(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_00) || !isPlayer(param_00)) {
    return;
  }

  var_09 = common_scripts\utility::func_40B0(self.var_116, level.armor_machines);
  var_0A = distance2d(var_09[0].var_116, self.var_116);
  var_0B = var_09[0];
  if(var_0A <= 100 && lib_0547::func_5864(param_04) || lib_0547::func_5752(param_04)) {
    if(isDefined(self.var_A4B)) {
      switch (self.var_A4B) {
        case "zombie_sizzler":
          hc_quest_axe_sever_head("sizzler", var_0B);
          break;

        case "zombie_generic":
          hc_quest_axe_sever_head("fodder", var_0B);
          break;

        case "zombie_berserker":
          hc_quest_axe_sever_head("pest", var_0B);
          break;

        default:
          break;
      }
    }
  }
}

hc_quest_axe_sever_head(param_00, param_01) {
  if(isDefined(param_01.color)) {
    if(isDefined(param_01.color.headfx)) {
      param_01.color.headfx delete();
    }

    foreach(var_03 in param_01.var_9DC2) {
      var_03 notify("head_replaced");
    }

    param_01.color delete();
  }

  var_05 = param_01.var_F5F.var_1D;
  param_01.color = spawn("script_model", param_01.var_9DC2[0].var_116);
  param_01.color.var_1D = var_05 - (0, 0, 0);
  param_01.color.var_116 = param_01.color.var_116 + 15 * anglestoright(param_01.var_F5F.var_1D) * -1;
  param_01.color.var_116 = param_01.color.var_116 - 1.5 * anglestoright(param_01.color.var_116);
  if(isDefined(param_01.var_8260) && param_01.var_8260 == "street_machine") {
    param_01.color.var_116 = param_01.color.var_116 + 2.5 * anglestoright(param_01.color.var_116);
    param_01.color.var_116 = param_01.color.var_116 - 1.25 * anglestoup(param_01.color.var_116);
  }

  if(isDefined(param_01.var_8260) && param_01.var_8260 == "museum_machine") {
    param_01.color.var_116 = param_01.color.var_116 + 4 * anglestoright(param_01.color.var_116);
    param_01.color.var_116 = param_01.color.var_116 + 3 * anglesToForward(param_01.color.var_116);
    param_01.color.var_116 = param_01.color.var_116 + (-0.5, 1, 3);
  }

  if(isDefined(param_01.var_8260) && param_01.var_8260 == "underbelly_machine") {
    param_01.color.var_116 = param_01.color.var_116 + (1.9, 0, 0);
  }

  if(isDefined(param_01.var_8260) && param_01.var_8260 == "church_machine") {
    param_01.color.var_116 = param_01.color.var_116 + (2, 0, 0);
  }

  switch (param_00) {
    case "sizzler":
      param_01.color setModel("zom_sizzler_head_gib");
      sever_head_fx(param_01.color);
      break;

    case "fodder":
      param_01.color setModel("zom_ger_head_fdr_03_gib");
      sever_head_fx(param_01.color);
      break;

    case "pest":
      param_01.color setModel("zom_ger_head_spr_01_gib");
      sever_head_fx(param_01.color);
      param_01.color.var_116 = param_01.color.var_116 - (0, 0, 2);
      break;

    default:
      break;
  }

  foreach(var_03 in param_01.var_9DC2) {
    var_03 thread hc_quest_axe_used_head_armor(param_01.color, param_01.var_106);
  }
}

sever_head_fx(param_00) {
  if(isDefined(param_00)) {
    param_00.headfx = spawnfx(common_scripts\utility::func_44F5("zmb_ber_hc_ee_armor_head"), param_00.var_116, anglesToForward(param_00.var_1D));
    triggerfx(param_00.headfx);
  }
}

hc_quest_axe_used_head_armor(param_00, param_01) {
  self endon("head_replaced");
  while(isDefined(param_00)) {
    self waittill("trigger", var_02);
    var_03 = lib_056A::func_4602(var_02, self);
    if(var_02 maps\mp\gametypes\zombies::func_11C2(var_03)) {
      hc_quest_axe_buy_head(param_00);
      continue;
    }

    continue;
    wait 0.05;
  }
}

hc_quest_axe_buy_head(param_00) {
  if(isDefined(param_00)) {
    switch (param_00.var_106) {
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

    param_00.headfx delete();
    param_00 delete();
  }
}

hc_quest_axe_clear_other_head_flags(param_00) {
  var_01 = ["flag_hc_quest_axe_step03_carrying_fodder_armored_head", "flag_hc_quest_axe_step03_carrying_sizzler_armored_head", "flag_hc_quest_axe_step03_carrying_pest_armored_head"];
  foreach(var_03 in var_01) {
    if(var_03 != param_00) {
      common_scripts\utility::func_3C7B(var_03);
    }
  }

  common_scripts\utility::func_3C8F(param_00);
  level.hc_axe_ee_head_carried = param_00;
}

hc_quest_axe_map_pin_found(param_00) {
  var_01 = getent("script_pickup_map_pin", "script_noteworthy");
  var_02 = getent("trigger_use_cabaret_map", "script_noteworthy");
  var_02 waittill("trigger", var_03);
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step01_map_pin_found");
  var_01 delete();
  param_00 method_805B();
}

hc_quest_axe_debug_skip_step01a() {
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step01_map_pin_found");
}

hc_quest_axe_debug_skip_step01b() {
  hc_quest_axe_debug_skip_step01a();
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step01_map_location_found");
  var_00 = getent("mapboard_lockbox_door", "script_noteworthy");
  var_00 rotateyaw(40, 1, 0.25, 0.25);
}

hc_quest_axe_debug_skip_step02() {
  hc_quest_axe_debug_skip_step01b();
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step02_obtained_scale_cup");
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step02_placed_scale_cup");
  var_00 = getent("hc_ee_axe_scale_cup", "script_noteworthy");
  var_01 = getent("hc_ee_axe_scale_needle", "script_noteworthy");
  var_00 method_805B();
  var_01 rotatepitch(-5, 1, 0.25, 0.25);
}

hc_quest_axe_debug_skip_step03() {
  hc_quest_axe_debug_skip_step02();
  common_scripts\utility::func_3C87("flag_hc_quest_axe_step03_obtained_sizzler_armored_head");
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step03_obtained_sizzler_armored_head");
  common_scripts\utility::func_3C8F("flag_hc_quest_axe_step03_placed_sizzler_armored_head");
  var_00 = getent("hc_ee_axe_scale_sizzler_head", "script_noteworthy");
  var_00 method_805B();
}

hc_quest_axe_debug_skip_all() {
  hc_quest_axe_debug_skip_step03();
}

_____________________finale_____________________() {}

hc_quest_finale_init() {
  common_scripts\utility::func_3C87("flag_hc_quest_finale_weapons_collected");
  common_scripts\utility::func_3C87("flag_hc_quest_finale_door_open");
  common_scripts\utility::func_3C87("statue_puzzle_success");
  common_scripts\utility::func_3C87("flag_hc_quest_finale_sword_door_open");
  var_00 = getent("garden_keyhole_placed_sword", "targetname");
  var_00 method_805C();
  hc_quest_finale_logic();
}

hc_quest_finale_logic() {
  hc_quest_finale_step01_handler();
  lib_054D::giveplayersexp("berlin_exp_ref_6");
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
  while(!level.bat_key_placed || !level.dagger_key_placed || !level.pickaxe_key_placed) {
    wait 0.05;
  }

  var_00 = getent("garden_keyhole_placed_dagger", "targetname");
  var_01 = getent("garden_keyhole_placed_bat", "targetname");
  var_02 = getent("garden_keyhole_placed_pickaxe", "targetname");
  var_03 = spawn("script_model", var_00.var_116 - (5, 0, 0));
  var_03 setModel("tag_origin");
  var_03.desired_zombie_type = "zombie_generic";
  var_03.ignoresighttrace = 1;
  var_03 maps\mp\mp_zombies_soul_collection::func_170B(20, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_03.desired_zombie_type = "zombie_sizzler";
  var_03.var_116 = var_02.var_116 - (5, 0, 0);
  var_03 maps\mp\mp_zombies_soul_collection::func_170B(10, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  var_03.desired_zombie_type = "zombie_berserker";
  var_03.var_116 = var_01.var_116 - (5, 0, 0);
  var_03 maps\mp\mp_zombies_soul_collection::func_170B(9, 360, 128, "garden_door_collection_kill", undefined, "tag_origin", undefined, "tag_origin");
  common_scripts\utility::func_3C8F("flag_hc_quest_finale_door_open");
  raven_puzzle_init();
  hc_quest_finale_utility_open_doors();
}

hc_quest_finale_step02_handler() {
  level.bird_models = getEntArray("bird_model", "targetname");
  foreach(var_01 in level.bird_models) {
    thread raven_puzzle_hide_raven_until_found(var_01);
  }

  common_scripts\utility::func_3C9F("flag_airship_anchor_a_reeled");
  level.current_secret_room_zone = "zone_finale";
  level.var_8B96 = ::maps\mp\mp_zombie_berlin_utils::zombies_players_secret_room_handle_ignore;
  hc_quest_finale_utility_close_doors();
  lib_0547::playerspawneroverrideset("blade");
  maps\mp\gametypes\zombies::register_addition_revive_rule(::hc_quest_finale_step02_separated_by_combat_event, ::hc_quest_finale_step02_debug_highlight_player_separation, "scr_hightLightPlayerSeparation");
  hc_quest_finale_step02_statue_puzzle_init();
  var_03 = getent("sword_pickup_trig", "targetname");
  thread maps\mp\mp_zombie_berlin_utils::special_melee_weapon_pickup_think(var_03, "sword");
  foreach(var_05 in level.var_744A) {
    if(distance(var_05.var_116, var_03.var_116) < 450) {
      var_05 lib_0367::func_8E3D("hc_sword_reveal");
    }
  }
}

hc_quest_finale_step02_separated_by_combat_event(param_00, param_01) {
  if(!isDefined(level.zombies_active_spawn_event) || level.zombies_active_spawn_event != "blade") {
    return 0;
  }

  var_02 = [level.current_secret_room_zone];
  var_03 = self;
  var_04 = param_00 lib_0547::player_validate_is_in_zones(var_02);
  var_05 = param_01 lib_0547::player_validate_is_in_zones(var_02);
  var_06 = var_04 == var_05;
  return !var_06;
}

hc_quest_finale_step02_debug_highlight_player_separation() {}

raven_puzzle_init() {
  common_scripts\utility::func_3C87("raven_puzzle_wall01_success");
  common_scripts\utility::func_3C87("raven_puzzle_wall02_success");
  common_scripts\utility::func_3C87("raven_puzzle_wall03_success");
  common_scripts\utility::func_3C87("raven_puzzle_wall04_success");
  common_scripts\utility::func_3C87("raven_puzzle_currently_rotating");
  raven_puzzle_wall_progression();
}

raven_puzzle_wall_progression() {
  thread raven_puzzle_handle_wall_with_targetname("first_wall_statue", "flag_airship_anchor_a_reeled", "raven_puzzle_wall01_success", "01");
  thread raven_puzzle_handle_wall_with_targetname("second_wall_statue", "raven_puzzle_wall01_success", "raven_puzzle_wall02_success", "02");
  thread raven_puzzle_handle_wall_with_targetname("third_wall_statue", "raven_puzzle_wall02_success", "raven_puzzle_wall03_success", "03");
  thread raven_puzzle_handle_wall_with_targetname("fourth_wall_statue", "raven_puzzle_wall03_success", "raven_puzzle_wall04_success", "04");
}

raven_puzzle_handle_wall_with_targetname(param_00, param_01, param_02, param_03) {
  var_04 = getEntArray(param_00, "targetname");
  foreach(var_06 in var_04) {
    var_06 thread raven_puzzle_wall_statue_handler(param_01, param_02);
  }

  thread raven_puzzle_check_completion(var_04, param_01, param_02, param_03);
}

raven_puzzle_wall_statue_handler(param_00, param_01) {
  var_02 = 90;
  var_03 = int(360 / var_02);
  self.start_rotation = self.var_1D;
  self.correctly_rotated = 0;
  var_04 = getEntArray(self.var_1A2, "targetname");
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  foreach(var_09 in var_04) {
    if(var_09.var_3A == "trigger_damage") {
      var_06 = var_09;
      continue;
    }

    if(var_09.var_3A == "script_model") {
      var_05 = var_09;
    }
  }

  if(issubstr(var_05.var_106, "01")) {
    var_07 = 1;
  } else if(issubstr(var_05.var_106, "02")) {
    var_07 = 2;
  } else if(issubstr(var_05.var_106, "03")) {
    var_07 = 3;
  } else if(issubstr(var_05.var_106, "04")) {
    var_07 = 4;
  }

  var_05 method_8449(self);
  var_0B = randomintrange(1, var_03) * var_07;
  var_0C = var_0B * var_02;
  self.var_1D = self.var_1D - (0, var_0C, 0);
  self.var_1D = (0, angleclamp360(self.var_1D[1]), 0);
  if(self.var_1D[1] % 360 == self.start_rotation[1] % 360) {
    self.correctly_rotated = 1;
  }

  common_scripts\utility::func_3C9F(param_00);
  var_0D = 0;
  var_0E = spawn("script_model", self.var_116 + (0, 0, var_0D));
  var_0E.var_1D = (var_0E.var_1D[0] - 90, var_0E.var_1D[1], var_0E.var_1D[2]);
  var_0E setModel("tag_origin");
  var_0E.start_offset = var_0D;
  while(!common_scripts\utility::func_3C77(param_01)) {
    raven_puzzle_wall_statue_waitfor_interact(var_06, param_01, var_0E);
    raven_puzzle_wall_statue_play_trigger_fx(var_0E);
    if(!common_scripts\utility::func_3C77(param_01)) {
      raven_puzzle_wall_statue_apply_angle_offset(var_07, var_02);
    }

    common_scripts\utility::func_3CA9("raven_puzzle_currently_rotating");
  }
}

raven_puzzle_wall_statue_waitfor_interact(param_00, param_01, param_02) {
  level endon(param_01);
  self endon("raven_puzzle_wall_statue_interact");
  param_00 method_80B0(param_00 method_85A0() | 256);
  var_03 = 16;
  param_02.current_fx = undefined;
  while(!common_scripts\utility::func_3C77(param_01)) {
    for(var_04 = 0; var_04 < var_03; var_04++) {
      param_00 waittill("trigger");
      if(var_04 == var_03 * 0.75) {
        if(isDefined(param_02.current_fx)) {
          killfxontag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        }

        param_02.current_fx = "crest_charge_100";
        playFXOnTag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        continue;
      }

      if(var_04 == var_03 * 0.5) {
        if(isDefined(param_02.current_fx)) {
          killfxontag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        }

        param_02.current_fx = "crest_charge_75";
        playFXOnTag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        continue;
      }

      if(var_04 == var_03 * 0.25) {
        if(isDefined(param_02.current_fx)) {
          killfxontag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        }

        param_02.current_fx = "crest_charge_50";
        playFXOnTag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        continue;
      }

      if(var_04 == 0) {
        if(isDefined(param_02.current_fx)) {
          killfxontag(level.var_611[param_02.current_fx], param_02, "tag_origin");
        }

        param_02.current_fx = "crest_charge_25";
        playFXOnTag(level.var_611[param_02.current_fx], param_02, "tag_origin");
      }
    }

    if(!common_scripts\utility::func_3C77("raven_puzzle_currently_rotating")) {
      break;
    } else {
      common_scripts\utility::func_3CA9("raven_puzzle_currently_rotating");
    }
  }

  var_05 = getEntArray(self.var_1A5, "targetname");
  var_06 = common_scripts\utility::func_40B0(self.var_116, var_05, [self], 2, self.var_14F);
  if(isDefined(var_06) && var_06.size > 0) {
    foreach(var_08 in var_06) {
      var_08 notify("raven_puzzle_wall_statue_interact");
    }
  }
}

raven_puzzle_wall_statue_play_trigger_fx(param_00) {
  if(isDefined(param_00.current_fx)) {
    killfxontag(level.var_611[param_00.current_fx], param_00, "tag_origin");
  }

  param_00.var_116 = (param_00.var_116[0], param_00.var_116[1], self.var_116[2] + param_00.start_offset);
  param_00.current_fx = "crest_charge_detonate";
  playFXOnTag(level.var_611[param_00.current_fx], param_00, "tag_origin");
}

raven_puzzle_wall_statue_apply_angle_offset(param_00, param_01) {
  var_02 = 1.8 / param_00;
  common_scripts\utility::func_3C8F("raven_puzzle_currently_rotating");
  lib_0378::func_8D74("aud_statue_rotate_handler");
  for(var_03 = 0; var_03 < param_00; var_03++) {
    var_04 = angleclamp360(self.var_1D[1] - param_01);
    var_04 = raven_puzzle_wall_statue_clamp_yaw(var_04);
    var_05 = (0, var_04, 0);
    self rotateto(var_05, var_02, 0.2, 0.2);
    wait(var_02);
    self.var_1D = var_05;
  }

  var_06 = self.var_1D[1] % 360;
  var_07 = self.start_rotation[1] % 360;
  if(var_06 == var_07) {
    self.correctly_rotated = 1;
    level notify("raven_puzzle_statue_rotation_correct");
  } else {
    self.correctly_rotated = 0;
  }

  wait(0.15);
  common_scripts\utility::func_3C7B("raven_puzzle_currently_rotating");
  lib_0378::func_8D74("aud_statue_rotate_handler");
}

raven_puzzle_wall_statue_clamp_yaw(param_00) {
  int(param_00);
  var_01 = param_00 % 90;
  if(var_01 != 0) {
    if(var_01 < 45) {
      param_00 = param_00 - var_01;
    } else {
      param_00 = param_00 + var_01;
    }
  }

  return param_00;
}

raven_puzzle_check_completion(param_00, param_01, param_02, param_03) {
  common_scripts\utility::func_3C9F(param_01);
  while(!common_scripts\utility::func_3C77(param_02)) {
    level waittill("raven_puzzle_statue_rotation_correct");
    common_scripts\utility::func_3CA9("raven_puzzle_currently_rotating");
    var_04 = 0;
    foreach(var_06 in param_00) {
      if(!var_06.correctly_rotated) {
        var_04 = 0;
        break;
      } else {
        var_04 = 1;
      }
    }

    if(var_04) {
      common_scripts\utility::func_3C8F(param_02);
      lib_0378::func_8D74("aud_statue_wall_complete");
      continue;
    }

    wait 0.05;
  }

  iprintlnbold(param_02 + " flag set! YOU DID IT!");
  raven_puzzle_show_raven_with_index(param_03);
}

raven_puzzle_hide_raven_until_found(param_00) {
  param_00 method_805C();
  param_00 common_scripts\utility::func_A732("found_bird_statue", "hc_quest_finale_skip_step02_parta");
  param_00 method_805B();
}

raven_puzzle_show_raven_with_index(param_00) {
  foreach(var_02 in level.bird_models) {
    if(isDefined(var_02) && isDefined(var_02.var_165) && var_02.var_165 == param_00) {
      var_02 notify("found_bird_statue");
    }
  }

  lib_054D::giveplayersexp("berlin_exp_ref_5");
}

hc_quest_finale_step02_statue_puzzle_init() {
  level.bird_data = [];
  level.bird_data["found"] = [];
  level.bird_data["placed"] = [];
  level.bird_data["placed_models"] = [];
  level.bird_data["base_model"] = "zbr_statue_puzzle_bird_";
  level.bird_data["statue"] = getent("bird_statue", "targetname");
  level.bird_data["start_vol"] = getent("bird_puzzle_start", "targetname");
  foreach(var_01 in level.bird_models) {
    thread hc_quest_finale_step02_statue_puzzle_bird_model_think(var_01);
  }

  common_scripts\utility::func_3CA2("raven_puzzle_wall01_success", "raven_puzzle_wall02_success", "raven_puzzle_wall03_success", "raven_puzzle_wall04_success");
  hc_quest_finale_step02_statue_puzzle_place_birds_think();
}

hc_quest_finale_step02_statue_puzzle_bird_model_think(param_00) {
  level endon("game_over");
  param_00 waittill("found_bird_statue");
  var_01 = param_00.var_165;
  while(!common_scripts\utility::func_3C77("statue_puzzle_success")) {
    param_00 hc_quest_finale_step02_statue_puzzle_bird_model_make_usable();
    var_02 = 0;
    while(!var_02) {
      wait 0.05;
      param_00 waittill("player_used", var_03);
      if(distancesquared(param_00.var_116, var_03.var_116) < 10000) {
        var_02 = 1;
        lib_0378::func_8D74("aud_pickup_bird", param_00.var_116);
      }
    }

    param_00.var_9D65 delete();
    param_00 delete();
    level notify("new_bird_acquired");
    level.bird_data["found"] = common_scripts\utility::func_F86(level.bird_data["found"], var_01, 0);
    var_04 = level common_scripts\utility::func_A715("birds_placed_incorrectly", "birds_placed_correctly");
    if(var_04 == "birds_placed_incorrectly") {
      param_00 = hc_quest_finale_step02_statue_puzzle_reset_bird_with_index(var_01);
    }

    wait 0.05;
  }
}

hc_quest_finale_step02_statue_puzzle_bird_model_make_usable() {
  lib_0547::func_AC41(" ");
}

hc_quest_finale_step02_statue_puzzle_reset_bird_with_index(param_00) {
  var_01 = undefined;
  foreach(var_03 in level.bird_data["placed_models"]) {
    if(var_03.var_106 == level.bird_data["base_model"] + param_00) {
      var_01 = var_03;
      hc_quest_finale_step02_statue_puzzle_reset_bird_fx(var_01.var_116);
      var_01 method_805C();
      var_04 = common_scripts\utility::func_46B7("bird_ground_org_" + param_00, "targetname");
      var_05 = common_scripts\utility::func_7A33(var_04);
      var_01.var_116 = var_05.var_116;
      var_01 common_scripts\utility::func_2CBE(0.05, ::method_805B);
      level.bird_data["placed_models"] = common_scripts\utility::func_F93(level.bird_data["placed_models"], var_03);
      break;
    }
  }

  return var_01;
}

hc_quest_finale_step02_statue_puzzle_reset_bird_fx(param_00) {
  param_00 = param_00 - (0, 0, 20);
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin");
  var_01.var_1D = (var_01.var_1D[0] - 90, var_01.var_1D[1], var_01.var_1D[2]);
  wait(randomfloatrange(0.25, 2));
  playFXOnTag(level.var_611["statue_bolt"], var_01, "tag_origin");
  var_01 common_scripts\utility::func_2CBE(3, ::delete);
  wait 0.05;
}

hc_quest_finale_step02_statue_puzzle_place_birds_think() {
  level endon("game_over");
  var_00 = 4;
  while(!common_scripts\utility::func_3C77("statue_puzzle_success")) {
    var_01 = 1;
    while(level.bird_data["placed"].size < var_00) {
      while(level.bird_data["found"].size <= 0) {
        wait 0.05;
      }

      var_02 = hc_quest_finale_step02_statue_puzzle_place_current_bird();
      if(isDefined(var_02) && !var_02) {
        var_01 = 0;
      }

      if(isDefined(var_02) && level.bird_data["placed"].size < var_00) {
        wait(1);
      }
    }

    level.bird_data["placed"] = [];
    level.bird_data["found"] = [];
    if(!var_01) {
      hc_quest_finale_step02_statue_puzzle_play_fail_fx();
      level notify("birds_placed_incorrectly");
      continue;
    }

    level notify("birds_placed_correctly");
    common_scripts\utility::func_3C8F("statue_puzzle_success");
    wait 0.05;
  }

  hc_quest_finale_step02_statue_puzzle_play_pass_fx();
}

hc_quest_finale_step02_statue_puzzle_play_fail_fx() {
  var_00 = 3;
  foreach(var_02 in level.bird_data["placed_models"]) {
    var_02 thread hc_quest_finale_step02_statue_puzzle_play_fail_fx_on_bird(var_00);
  }

  wait(var_00);
}

hc_quest_finale_step02_statue_puzzle_play_fail_fx_on_bird(param_00) {
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  playFXOnTag(level.var_611["statue_light_white"], var_01, "tag_origin");
  wait(param_00 / 2);
  stopFXOnTag(level.var_611["statue_light_white"], var_01, "tag_origin");
  playFXOnTag(level.var_611["statue_light_red"], var_01, "tag_origin");
  iprintlnbold("Incorrect!");
  wait(param_00 / 2);
  stopFXOnTag(level.var_611["statue_light_red"], var_01, "tag_origin");
  var_01 common_scripts\utility::func_2CBE(0.25, ::delete);
}

hc_quest_finale_step02_statue_puzzle_play_pass_fx() {
  var_00 = 3;
  foreach(var_02 in level.bird_data["placed_models"]) {
    var_02 thread hc_quest_finale_step02_statue_puzzle_play_pass_fx_on_bird(var_00);
  }

  thread hc_quest_finale_step02_statue_puzzle_play_crumble_fx();
  wait(var_00);
}

hc_quest_finale_step02_statue_puzzle_play_crumble_fx() {
  level thread common_scripts\_exploder::func_88E(206);
  lib_0378::func_8D74("aud_sword_reveal");
  wait(0.7);
  var_00 = getent("bird_statue_sword_bit", "targetname");
  var_00 delete();
}

hc_quest_finale_step02_statue_puzzle_play_pass_fx_on_bird(param_00) {
  var_01 = spawn("script_model", self.var_116);
  var_01 setModel("tag_origin");
  playFXOnTag(level.var_611["statue_light_white"], var_01, "tag_origin");
  wait(param_00);
  stopFXOnTag(level.var_611["statue_light_white"], var_01, "tag_origin");
  playFXOnTag(level.var_611["statue_light_green"], var_01, "tag_origin");
  iprintlnbold("Correct!");
}

hc_quest_finale_step02_statue_puzzle_place_current_bird() {
  level endon("new_bird_acquired");
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    var_02 thread hc_quest_finale_step02_statue_puzzle_player_place_bird();
  }

  level waittill("bird_placed", var_04);
  var_00 = var_04;
  level.bird_data["placed"][level.bird_data["placed"].size] = level.bird_data["found"][0];
  level.bird_data["found"] = common_scripts\utility::func_F9A(level.bird_data["found"], 0);
  return var_00;
}

hc_quest_finale_step02_statue_puzzle_player_place_bird() {
  wait 0.05;
  level endon("bird_placed");
  level endon("new_bird_acquired");
  while(!self istouching(level.bird_data["start_vol"])) {
    wait(5);
  }

  var_00 = 0;
  var_01 = level.bird_data["found"][0];
  self.current_stencil = undefined;
  thread hc_quest_finale_step02_statue_puzzle_handle_stencil_cleanup();
  while(!var_00) {
    while(distance2d(self.var_116, level.bird_data["statue"].var_116) > 125) {
      wait 0.05;
    }

    while(distance2d(self.var_116, level.bird_data["statue"].var_116) <= 125) {
      var_02 = common_scripts\utility::func_46B7("bird_org_" + var_01, "targetname");
      var_02 = common_scripts\utility::func_40B0(self getEye(), var_02, undefined, 10, 65);
      var_03 = undefined;
      foreach(var_05 in var_02) {
        if(common_scripts\utility::func_AA4A(self getEye(), self.var_1D, var_05.var_116, cos(25))) {
          var_03 = var_05;
          break;
        }
      }

      if(isDefined(var_03) && !isDefined(self.current_stencil)) {
        self.current_stencil = spawn("script_model", var_03.var_116);
        self.current_stencil setModel(level.bird_data["base_model"] + var_01 + "_obj");
        self.current_stencil.var_1D = var_03.var_1D;
      } else if(isDefined(var_03) && isDefined(self.current_stencil)) {
        self.current_stencil.var_1D = var_03.var_1D;
        self.current_stencil.var_116 = var_03.var_116;
      } else if(!isDefined(var_03) && isDefined(self.current_stencil)) {
        self.current_stencil delete();
      }

      if(self useButtonPressed() && isDefined(var_03)) {
        var_00 = 1;
        var_07 = 0;
        if(var_03.var_165 == "correct") {
          var_07 = 1;
        }

        var_08 = spawn("script_model", var_03.var_116);
        var_08 setModel(level.bird_data["base_model"] + var_01);
        var_08.var_1D = var_03.var_1D;
        lib_0378::func_8D74("aud_place_bird", var_08.var_116);
        level.bird_data["placed_models"][level.bird_data["placed_models"].size] = var_08;
        level notify("bird_placed", var_07);
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

hc_quest_finale_step02_statue_puzzle_handle_stencil_cleanup() {
  level common_scripts\utility::func_A732("bird_placed", "new_bird_acquired");
  if(isDefined(self.current_stencil)) {
    self.current_stencil delete();
  }
}

hc_quest_finale_step03_handler() {
  level.sword_key_placed = 0;
  thread hc_quest_finale_utility_place_weapon_with_name("sword");
  while(!level.sword_key_placed) {
    wait 0.05;
  }

  common_scripts\utility::func_3C8F("flag_hc_quest_finale_sword_door_open");
  lib_0547::playerspawneroverrideclear();
  hc_quest_finale_utility_open_doors();
  level.current_secret_room_zone = "";
  level.var_8B96 = undefined;
}

hc_quest_finale_utility_place_weapon_with_name(param_00, param_01, param_02) {
  var_03 = getent("garden_door_" + param_00 + "_keyhole", "targetname");
  var_04 = getent("garden_keyhole_placed_" + param_00, "targetname");
  var_04 method_805C();
  var_05 = 0;
  while(!var_05) {
    var_03 waittill("trigger", var_06);
    if(isDefined(var_06.special_melee_weapon) && var_06.special_melee_weapon == param_00) {
      var_06.special_melee_weapon = "";
      var_05 = 1;
      var_04 method_805B();
      lib_0378::func_8D74("aud_place_weapon_in_slot", param_00, var_04.var_116);
    }
  }

  hc_quest_finale_utility_place_weapon_set_boolean(param_00, 1);
}

hc_quest_finale_utility_place_weapon_set_boolean(param_00, param_01) {
  switch (param_00) {
    case "bat":
      level.bat_key_placed = param_01;
      break;

    case "dagger":
      level.dagger_key_placed = param_01;
      break;

    case "pickaxe":
      level.pickaxe_key_placed = param_01;
      break;

    case "sword":
      level.sword_key_placed = param_01;
      break;

    default:
      break;
  }
}

hc_quest_finale_utility_open_doors(param_00) {
  var_01 = getent("hc_finale_gate_l", "targetname");
  var_02 = getent("hc_finale_gate_clip_l", "targetname");
  var_03 = getent("hc_finale_gate_l_org", "targetname");
  var_01 method_8449(var_03);
  var_02 method_8449(var_03);
  var_04 = getent("hc_finale_gate_r", "targetname");
  var_05 = getent("hc_finale_gate_clip_r", "targetname");
  var_06 = getent("hc_finale_gate_r_org", "targetname");
  var_04 method_8449(var_06);
  var_05 method_8449(var_06);
  var_02 notsolid();
  var_05 notsolid();
  var_02 method_8060();
  var_05 method_8060();
  var_02 solid();
  var_05 solid();
  lib_0378::func_8D74("aud_open_barbarosa_area_door", var_01.var_116);
  var_06 rotateto((0, 75, 0), 3, 0.5, 0.5);
  var_03 rotateto((0, 285, 0), 3, 0.5, 0.5);
  wait(3);
  var_02 method_805F();
  var_05 method_805F();
}

hc_quest_finale_utility_close_doors() {
  var_00 = getent("hc_finale_gate_l", "targetname");
  var_01 = getent("hc_finale_gate_clip_l", "targetname");
  var_02 = getent("hc_finale_gate_l_org", "targetname");
  var_00 method_8449(var_02);
  var_01 method_8449(var_02);
  var_03 = getent("hc_finale_gate_r", "targetname");
  var_04 = getent("hc_finale_gate_clip_r", "targetname");
  var_05 = getent("hc_finale_gate_r_org", "targetname");
  var_03 method_8449(var_05);
  var_04 method_8449(var_05);
  var_01 notsolid();
  var_04 notsolid();
  var_01 method_8060();
  var_04 method_8060();
  var_01 solid();
  var_04 solid();
  lib_0378::func_8D74("aud_close_barbarosa_area_door", var_00.var_116);
  var_02 rotateto((0, 0, 0), 1.5, 0, 0);
  var_05 rotateto((0, 0, 0), 1.5, 0, 0);
  wait(1.5);
  var_01 method_805F();
  var_04 method_805F();
}

_____________________hats_____________________() {}

hc_quest_hats_init() {
  common_scripts\utility::func_3C87("flag_hat_stack_ee_complete");
  thread hat_spawn();
  thread hat_spawn_2();
  thread hat_spawn_3();
  thread hat_spawn_4();
  thread hat_spawn_5();
  var_00 = getEntArray("table_think_trig", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread hatrack_table_think();
  }

  thread hat_stacker();
  wait(5);
  level thread maps\mp\_utility::func_6F74(::hat_check_player_disconnect);
}

hat_spawn() {
  var_00 = common_scripts\utility::func_46B7("hat_1_possible_location", "targetname");
  var_01 = common_scripts\utility::func_7A33(var_00);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("aac_hats_men_02");
  var_02.var_1D = var_01.var_1D;
  var_03 = getent("hat_1_trig", "targetname");
  var_03.var_116 = var_01.var_116;
  var_03 common_scripts\utility::func_9DA3();
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isDefined(var_04.hat_inventory)) {
      var_04.hat_inventory = "empty";
    }

    if(var_04.hat_inventory == "empty") {
      var_04.hat_inventory = "hat_1";
      var_03 common_scripts\utility::func_9D9F();
      var_02 delete();
      break;
    }
  }
}

hat_spawn_2() {
  var_00 = common_scripts\utility::func_46B7("hat_2_possible_location", "targetname");
  var_01 = common_scripts\utility::func_7A33(var_00);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("ger_m43cap_org2");
  var_02.var_1D = var_01.var_1D;
  var_03 = getent("hat_2_trig", "targetname");
  var_03.var_116 = var_01.var_116;
  var_03 common_scripts\utility::func_9DA3();
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isDefined(var_04.hat_inventory)) {
      var_04.hat_inventory = "empty";
    }

    if(var_04.hat_inventory == "empty") {
      var_04.hat_inventory = "hat_2";
      var_03 common_scripts\utility::func_9D9F();
      var_02 delete();
      break;
    }
  }
}

hat_spawn_3() {
  var_00 = common_scripts\utility::func_46B7("hat_3_possible_location", "targetname");
  var_01 = common_scripts\utility::func_7A33(var_00);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("ger_alfakey_m34capm44hp_r1c1");
  var_02.var_1D = var_01.var_1D;
  var_03 = getent("hat_3_trig", "targetname");
  var_03.var_116 = var_01.var_116;
  var_03 common_scripts\utility::func_9DA3();
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isDefined(var_04.hat_inventory)) {
      var_04.hat_inventory = "empty";
    }

    if(var_04.hat_inventory == "empty") {
      var_04.hat_inventory = "hat_3";
      var_03 common_scripts\utility::func_9D9F();
      var_02 delete();
      break;
    }
  }
}

hat_spawn_4() {
  var_00 = common_scripts\utility::func_46B7("hat_4_possible_location", "targetname");
  var_01 = common_scripts\utility::func_7A33(var_00);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("zom_m40officercap_org1");
  var_02.var_1D = var_01.var_1D;
  var_03 = getent("hat_4_trig", "targetname");
  var_03.var_116 = var_01.var_116;
  var_03 common_scripts\utility::func_9DA3();
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isDefined(var_04.hat_inventory)) {
      var_04.hat_inventory = "empty";
    }

    if(var_04.hat_inventory == "empty") {
      var_04.hat_inventory = "hat_4";
      var_03 common_scripts\utility::func_9D9F();
      var_02 delete();
      break;
    }
  }
}

hat_spawn_5() {
  var_00 = common_scripts\utility::func_46B7("hat_5_possible_location", "targetname");
  var_01 = common_scripts\utility::func_7A33(var_00);
  var_02 = spawn("script_model", var_01.var_116);
  var_02 setModel("rus_balthazar_m35pilotka_r4c3");
  var_02.var_1D = var_01.var_1D;
  var_03 = getent("hat_5_trig", "targetname");
  var_03.var_116 = var_01.var_116;
  var_03 common_scripts\utility::func_9DA3();
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(!isDefined(var_04.hat_inventory)) {
      var_04.hat_inventory = "empty";
    }

    if(var_04.hat_inventory == "empty") {
      var_04.hat_inventory = "hat_5";
      var_03 common_scripts\utility::func_9D9F();
      var_02 delete();
      break;
    }
  }
}

hat_check_player_disconnect() {
  for(;;) {
    common_scripts\utility::knock_off_battery("disconnect", "death");
    if(!isDefined(self.hat_inventory)) {
      self.hat_inventory = "empty";
    }

    if(self.hat_inventory == "hat_1") {
      thread hat_spawn();
    }

    if(self.hat_inventory == "hat_2") {
      thread hat_spawn_2();
    }

    if(self.hat_inventory == "hat_3") {
      thread hat_spawn_3();
    }

    if(self.hat_inventory == "hat_4") {
      thread hat_spawn_4();
    }

    if(self.hat_inventory == "hat_5") {
      thread hat_spawn_5();
    }

    self.hat_inventory = "empty";
  }
}

hatrack_table_think() {
  var_00 = undefined;
  var_01 = common_scripts\utility::func_46B5(self.var_1A2, "targetname");
  self.hatrack = spawn("script_model", var_01.var_116);
  self.hatrack setModel("");
  self.hatrack.var_109 = "empty";
  self.hatrack.var_2BB1 = self.hatrack.var_116;
  self.hatrack.var_2B8F = self.hatrack.var_1D;
  for(;;) {
    self waittill("trigger", var_02);
    self.hatrack setModel("empty_model");
    var_03 = var_02.hat_inventory;
    var_02.hat_inventory = self.hatrack.var_109;
    self.hatrack.var_109 = var_03;
    self.hatrack.var_116 = self.hatrack.var_2BB1;
    self.hatrack.var_1D = self.hatrack.var_2B8F;
    if(isDefined(self.hatrack.var_109) && self.hatrack.var_109 != "empty") {
      if(self.hatrack.var_109 == "hat_1") {
        var_00 = "aac_hats_men_02";
      }

      if(self.hatrack.var_109 == "hat_2") {
        var_00 = "ger_m43cap_org2";
        self.hatrack.var_116 = self.hatrack.var_2BB1 + (0, 0, 4);
        self.hatrack.var_1D = self.hatrack.var_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.var_109 == "hat_3") {
        var_00 = "ger_alfakey_m34capm44hp_r1c1";
        self.hatrack.var_116 = self.hatrack.var_2BB1 + (0, 0, 4);
        self.hatrack.var_1D = self.hatrack.var_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.var_109 == "hat_4") {
        var_00 = "zom_m40officercap_org1";
        self.hatrack.var_116 = self.hatrack.var_2BB1 + (0, 0, 4);
        self.hatrack.var_1D = self.hatrack.var_2B8F + (-90, 0, 0);
      }

      if(self.hatrack.var_109 == "hat_5") {
        var_00 = "rus_balthazar_m35pilotka_r4c3";
        self.hatrack.var_116 = self.hatrack.var_2BB1 + (0, 0, 4);
        self.hatrack.var_1D = self.hatrack.var_2B8F + (-90, 0, 0);
      }
    } else {
      var_00 = "empty_model";
      self.hatrack.var_116 = self.hatrack.var_2BB1;
      self.hatrack.var_1D = self.hatrack.var_2B8F;
    }

    wait 0.05;
    self.hatrack setModel(var_00);
  }
}

hat_stacker() {
  level endon("flag_hat_stack_ee_complete");
  var_00 = getent("hatrack_trig_new", "targetname");
  var_01 = common_scripts\utility::func_46B5("hat_stack_reward", "targetname");
  level.hatrack = [];
  level.officer_hat = 0;
  level.cappy = 0;
  level.hat_cap = 0;
  level.red_cap = 0;
  var_02 = common_scripts\utility::func_46B5("hat_spot_0", "targetname");
  var_03 = common_scripts\utility::func_46B5("hat_spot_1", "targetname");
  var_04 = common_scripts\utility::func_46B5("hat_spot_2", "targetname");
  var_05 = common_scripts\utility::func_46B5("hat_spot_3", "targetname");
  var_06 = common_scripts\utility::func_46B5("hat_spot_4", "targetname");
  var_07 = undefined;
  for(var_08 = 0; var_08 < 5; var_08++) {
    if(var_08 == 0) {
      level.hatrack[var_08] = spawn("script_model", var_02.var_116);
      level.hatrack[var_08].var_1D = var_02.var_1D;
    }

    if(var_08 == 1) {
      level.hatrack[var_08] = spawn("script_model", var_03.var_116);
      level.hatrack[var_08].var_1D = var_03.var_1D;
    }

    if(var_08 == 2) {
      level.hatrack[var_08] = spawn("script_model", var_04.var_116);
      level.hatrack[var_08].var_1D = var_04.var_1D;
    }

    if(var_08 == 3) {
      level.hatrack[var_08] = spawn("script_model", var_05.var_116);
      level.hatrack[var_08].var_1D = var_05.var_1D;
    }

    if(var_08 == 4) {
      level.hatrack[var_08] = spawn("script_model", var_06.var_116);
      level.hatrack[var_08].var_1D = var_06.var_1D;
    }

    level.hatrack[var_08] setModel("");
    level.hatrack[var_08].var_109 = "empty";
    level.hatrack[var_08].var_2BB1 = level.hatrack[var_08].var_116;
    level.hatrack[var_08].var_2B8F = level.hatrack[var_08].var_1D;
  }

  for(;;) {
    var_00 waittill("trigger", var_09);
    if(!isDefined(var_09.hat_inventory) || var_09.hat_inventory == "empty") {
      for(var_08 = level.hatrack.size - 1; var_08 >= 0; var_08--) {
        if(level.hatrack[var_08].var_109 != "empty") {
          if(level.hatrack[var_08].var_109 == "hat_4") {
            level.officer_hat = 0;
          }

          if(level.hatrack[var_08].var_109 == "hat_3") {
            level.cappy = 0;
          }

          if(level.hatrack[var_08].var_109 == "hat_2") {
            level.hat_cap = 0;
          }

          if(level.hatrack[var_08].var_109 == "hat_5") {
            level.red_cap = 0;
          }

          var_09.hat_inventory = level.hatrack[var_08].var_109;
          level.hatrack[var_08].var_109 = "empty";
          level.hatrack[var_08] setModel("empty_model");
          level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1;
          level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F;
          break;
        }
      }

      continue;
    }

    for(var_08 = 0; var_08 < level.hatrack.size; var_08++) {
      if(level.hatrack[var_08].var_109 == "empty") {
        level.hatrack[var_08].var_109 = var_09.hat_inventory;
        if(var_09.hat_inventory == "hat_1") {
          var_07 = "aac_hats_men_02";
        }

        if(var_09.hat_inventory == "hat_2") {
          var_07 = "ger_m43cap_org2";
          level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (0, 0, 4);
          level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-90, 0, 0);
          level.hat_cap = 1;
        }

        if(var_09.hat_inventory == "hat_3") {
          var_07 = "ger_alfakey_m34capm44hp_r1c1";
          level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (-0.5, -0.75, 3.7);
          level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-85, 0, 0);
          level.hatrack[var_08] addyaw(-7.5);
          level.cappy = 1;
        }

        if(var_09.hat_inventory == "hat_4") {
          var_07 = "zom_m40officercap_org1";
          level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (0, 0, 5);
          level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-90, 0, 0);
          level.officer_hat = 1;
        }

        if(var_09.hat_inventory == "hat_5") {
          var_07 = "rus_balthazar_m35pilotka_r4c3";
          if(isDefined(level.hatrack[var_08 - 1])) {
            if(level.hatrack[var_08 - 1].var_109 == "hat_4") {
              level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (1, 0.5, 2.5);
              level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-85, 0, 0);
              level.hatrack[var_08] addyaw(15);
            } else {
              level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (-0.5, -0.75, 3.7);
              level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-85, 0, 0);
              level.hatrack[var_08] addyaw(-7.5);
            }
          } else {
            level.hatrack[var_08].var_116 = level.hatrack[var_08].var_2BB1 + (-0.5, -0.75, 3.7);
            level.hatrack[var_08].var_1D = level.hatrack[var_08].var_2B8F + (-85, 0, 0);
            level.hatrack[var_08] addyaw(-7.5);
          }

          level.red_cap = 1;
        }

        if(level.officer_hat == 1) {
          if(level.hatrack[var_08].var_109 != "hat_4") {
            level.hatrack[var_08].var_116 = level.hatrack[var_08].var_116 + (0, 0, 3);
          }
        }

        if(level.cappy == 1) {
          if(level.hatrack[var_08].var_109 != "hat_3") {
            level.hatrack[var_08].var_116 = level.hatrack[var_08].var_116 + (0, 0, 1.25);
          }
        }

        if(level.red_cap == 1) {
          if(level.hatrack[var_08].var_109 != "hat_5") {
            level.hatrack[var_08].var_116 = level.hatrack[var_08].var_116 + (0, 0, 1.25);
          }
        }

        if(level.hat_cap == 1) {
          if(level.hatrack[var_08].var_109 != "hat_2") {
            level.hatrack[var_08].var_116 = level.hatrack[var_08].var_116 + (0, 0, 1);
          }
        }

        wait 0.05;
        level.hatrack[var_08] setModel(var_07);
        var_09.hat_inventory = "empty";
        if(var_08 == 4) {
          if(level.hatrack[0].var_109 == "hat_1" && level.hatrack[1].var_109 == "hat_2" && level.hatrack[2].var_109 == "hat_3" && level.hatrack[3].var_109 == "hat_4" && level.hatrack[4].var_109 == "hat_5") {
            lib_0380::func_6844("zmb_berl_leopard", undefined, var_00);
            foreach(var_09 in level.var_744A) {
              wait(1.5);
              var_09 maps\mp\gametypes\zombies::func_4798(5);
              wait(1.5);
              var_09 maps\mp\gametypes\zombies::func_4798(2);
              wait(1.5);
              var_09 maps\mp\gametypes\zombies::func_4798(1945);
            }

            wait(1.5);
            maps\mp\gametypes\zombies::func_281C("insta_kill", var_01.var_116);
            wait(1.5);
            maps\mp\gametypes\zombies::func_281C("nuke", var_01.var_116 + (35, 0, 0));
            wait(1.5);
            maps\mp\gametypes\zombies::func_281C("ammo", var_01.var_116 + (70, 0, 0));
            wait(1.5);
            maps\mp\gametypes\zombies::func_281C("double_points", var_01.var_116 + (105, 0, 0));
            wait(1.5);
            maps\mp\gametypes\zombies::func_281C("ability_fill", var_01.var_116 + (140, 0, 0));
            common_scripts\utility::func_3C8F("flag_hat_stack_ee_complete");
          }
        }

        break;
      }
    }
  }
}