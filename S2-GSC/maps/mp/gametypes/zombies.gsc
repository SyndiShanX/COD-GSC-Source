/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\zombies.gsc
*********************************************/

func_00F9() {
  if(gettime() > 300) {
    level.zombie_game_was_restarted = 1;
  }

  resetomnvars();
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  lib_0541::func_00F9();
  setDvar("1936", 1);
  setDvar("2335", 1);
  setDvar("scr_dlcRoundMode", 0);
  level.var_8D62 = ::lib_0366::func_8E25;
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 1);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
  }

  setdynamicdvar("4696", 0);
  setdynamicdvar("5539", 2);
  setdynamicdvar("scr_zombies_timeLimit", 0);
  setdynamicdvar("scr_zombies_numLives", 1);
  setdynamicdvar("2298", 5000);
  setdynamicdvar("scr_game_matchstarttime", 0);
  setdynamicdvar("scr_game_playerwaittime", 5);
  setdynamicdvar("scr_game_playerwaittime_ds", 5);
  setdynamicdvar("scr_game_graceperiod", 5);
  setdynamicdvar("scr_game_graceperiodf_ds", 5);
  setdynamicdvar("scr_player_healthregentime", 4);
  maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
  func_872E();
  maps\mp\zombies\_zombies_perks::func_00D5();
  func_532F();
  func_5DE9();
  lib_0547::func_A2A1();
  lib_0547::func_9597();
  lib_0542::func_5329();
  lib_0547::func_52B0();
  lib_0547::func_7BD0("nuke_stun", ::func_6865, ::func_6864, 4);
  maps\mp\_utility::func_873B(1);
  level.var_585D = 1;
  level.var_2F85 = 1;
  if(getdvarint("scr_zombiesAlwaysDrawFriendlyNames")) {
    level.var_0CB4 = 1;
  }

  level.var_80AB = 1;
  level.var_0C25 = 1;
  level.var_8C87 = 1;
  level.var_6706 = 1;
  level.var_10EB = 1;
  level.var_5A6F = 0;
  level.var_2FAB = 1;
  level.var_3FA6 = 0;
  level.var_7A67 = 0;
  level.var_746E = "allies";
  level.var_3772 = "axis";
  function_0390("axis");
  level.var_7F1B = 20;
  level.var_268D = 5;
  level.var_5BFA = 2000;
  level.var_4867 = 0;
  level.var_7426 = 150;
  level.var_7484 = 1000;
  level.var_73E0 = 500;
  level.gametypemovespeedmaxscalar = 2;
  level.var_9A87 = 0;
  level.var_62B3 = [];
  level.var_29E0 = [];
  level.var_7F24 = 5;
  level.zombieweaponclass = [];
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6BA7 = ::func_6B81;
  level.var_62AD = ::func_62AF;
  level.var_1E7C = ::lib_0553::func_1E6E;
  level.gametypemovespeedscalefunc = ::lib_0547::zombiesmovespeedscale;
  level.var_1E78 = ::func_1E68;
  level.var_6B77 = ::func_6B77;
  level.var_1DEA = ::func_AC20;
  level.var_6AE2 = ::func_6AE2;
  level.var_6BB2 = ::func_6B5C;
  level.var_A9C5 = ::func_34B8;
  level.var_1385 = ::func_AC53;
  level.var_A9F9 = ::func_AC76;
  level.var_2980 = ::lib_054E::func_AB3D;
  level.var_297F = ::lib_054E::func_AB3C;
  level.var_2067 = ::lib_0547::func_7CE5;
  level.var_1E7A = ::func_6B41;
  level.var_2FA0 = ::func_2FA0;
  level.var_1E41 = ::func_1E38;
  level.var_7BF5 = ::maps\mp\zombies\_zombies_roles::func_7BF6;
  level.var_6B4E = ::maps\mp\zombies\_zombies_perks::func_0F35;
  level.var_300C = ::func_AC54;
  level.var_36C3 = ::func_AC55;
  level.var_3FE0 = ::maps\mp\zombies\_zombies_perks::func_A27B;
  level.var_3FDE = ::maps\mp\zombies\_zombies_perks::func_536E;
  level.var_3FDD = ::maps\mp\zombies\_zombies_perks::func_0F39;
  level.var_446F = ::func_446E;
  level.var_5827 = ::lib_0547::func_5863;
  level.var_5834 = ::lib_0547::func_5866;
  level.var_73CD = ::func_73CD;
  level.var_47C4 = ::lib_0586::_zm_give_weapon_mp_api;
  level.var_95F7 = ::lib_0586::func_0790;
  level.var_A9C8 = [];
  level.resetclientomnvarcallback = ::resetclientomnvars;
  level thread maps\mp\_events_z::func_00D5();
  level.var_0788 = ::maps\mp\_zm_breadcrumbdata::func_00D5;
  level.var_0789 = ::maps\mp\_zm_breadcrumbdata::func_5EB1;
  thread func_ABF6();
}

func_5DE9() {
  level.var_0611["mutant_blood_pool"] = loadfx("vfx/blood/dlc_zombie_gib_bloodpool");
  level.var_0611["mutant_gib_death"] = loadfx("vfx/blood/dlc_zombie_gib_burst");
  level.var_0611["electrical_arc"] = loadfx("vfx/test/test_fx");
  level.var_0611["slow_zone"] = loadfx("vfx/test/hms_mutant_ooze_impact_burst");
  level.var_0611["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
  level.var_0611["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
  level.var_0611["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_2");
  level.var_0611["torso_head_loss_p_melee_fdr_02"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_02");
  level.var_0611["torso_head_loss_p_melee_fdr_03"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_03");
  level.var_0611["torso_head_loss_p_melee_fdr_04"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_04");
  level.var_0611["zmb_paired_melee_head_pop_fdr_02"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_02");
  level.var_0611["zmb_paired_melee_head_pop_fdr_03"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_03");
  level.var_0611["zmb_paired_melee_head_pop_fdr_04"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_04");
  level.var_0611["torso_loss_head_p_melee_spr_01"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_spr_01");
  level.var_0611["zmb_paired_melee_head_pop_spr_01"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_spr_01");
  level.var_0611["torso_head_loss_small"] = loadfx("vfx/blood/dlc_zombie_torso_squirt_up");
  level.var_0611["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
  level.var_0611["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
  level.var_0611["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
  level.var_0611["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
  level.var_0611["head_gibs"] = loadfx("vfx/blood/zom_head_impact_01");
  level.var_0611["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
  level.var_0611["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
  level.var_0611["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
  level.var_0611["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
  level.var_0611["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
  level.var_0611["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
  level.var_0611["nuke_blast"] = loadfx("vfx/gameplay\mp\zombie/zombie_nuke_burst");
  level.var_0611["player_screen_burn"] = loadfx("vfx/fire/fire_player_impact_cam");
  level.var_0611["eye_zombie_generic"] = loadfx("vfx/gameplay\mp\zombie/zombie_eye_vanilla");
  level.var_0611["eye_zombie_berserker"] = loadfx("vfx/gameplay\mp\zombie/zombie_eye_vanilla");
  level.var_0611["eye_zombie_exploder"] = loadfx("vfx/gameplay\mp\zombie/zombie_eye_vanilla");
  level.var_0611["eye_zombie_heavy"] = loadfx("vfx/gameplay\mp\zombie/zombie_eye_vanilla");
  level.var_0611["pickup_nuke"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_apocalypse");
  level.var_0611["pickup_doublepoints"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_dble_pts");
  level.var_0611["pickup_base"] = loadfx("vfx/gameplay\mp\zombie/zmb_holo_icon_base");
  level.var_0611["pickup_instakill"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_insta_kill");
  level.var_0611["pickup_maxammo"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_max_ammo");
  level.var_0611["pickup_tombstone"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_tombstone");
  level.var_0611["pickup_abilityfill"] = loadfx("vfx/gameplay\mp\zombie/dlc_pickup_zombies_01_overcharge");
  level.var_0611["sticky_grenade_splat"] = loadfx("vfx/weaponimpact/sticky_grenade_splat");
  level.var_0611["mine_launch"] = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
  level.var_0611["mine_spin"] = loadfx("vfx/dust/bouncing_betty_swirl");
  level.var_0611["mine_explode"] = loadfx("vfx/explosion/zmb_bouncing_betty_explosion");
  level.var_0611["mine_beacon_enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.var_0611["mine_beacon_friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  level.var_0611["zmb_electroschnelle_player"] = loadfx("vfx/lights/mp_zombie_nest/zmb_electroschnelle_player");
  level.var_0611["serrated_edge_bleed"] = loadfx("vfx/blood/zmb_death_serrated_edge_drip");
}

func_AC76(param_00) {
  return 4;
}

func_532F() {
  level.var_6FC9 = [];
  level.var_60A9 = func_457B();
  level.var_6F4A = func_4600();
  level.var_34AA = 0;
  level.var_2958 = 0;
  level.var_6FCC = [];
  level.var_6FD2 = [];
  level.var_6FD3 = 0;
  level.var_6FD0 = undefined;
  level.var_3C1B = 0;
  level.var_6FBF["ammo"]["func"] = ::func_0DB9;
  level.var_6FBF["ammo"]["fx"] = "pickup_maxammo";
  level.var_6FBF["ammo"]["model"] = "ger_container_ammo_metal_02_zm";
  level.var_6FBF["ammo"]["outline"] = 1;
  level.var_6FBF["ammo"]["delayPickUp"] = 0;
  level.var_6FBF["insta_kill"]["func"] = ::func_53DD;
  level.var_6FBF["insta_kill"]["fx"] = "pickup_instakill";
  level.var_6FBF["insta_kill"]["delayPickUp"] = 0;
  level.var_6FBF["double_points"]["func"] = ::func_32C8;
  level.var_6FBF["double_points"]["fx"] = "pickup_doublepoints";
  level.var_6FBF["double_points"]["delayPickUp"] = 0;
  level.var_6FBF["nuke"]["func"] = ::func_685F;
  level.var_6FBF["nuke"]["fx"] = "pickup_nuke";
  level.var_6FBF["nuke"]["model"] = "usa_fighter_thunderbolt_bomb_zm";
  level.var_6FBF["nuke"]["outline"] = 1;
  level.var_6FBF["nuke"]["delayPickUp"] = 0;
  level.var_6FBF["ability_fill"]["func"] = ::func_0840;
  level.var_6FBF["ability_fill"]["fx"] = "pickup_abilityfill";
  level.var_6FBF["ability_fill"]["delayPickUp"] = 0;
  level.var_6FC8 = 1;
  func_76AD();
  func_7A55();
  if(isDefined(level.dropschedulefunc)) {
    level thread[[level.dropschedulefunc]]();
    return;
  }

  level thread func_809A();
}

func_76AD() {
  var_00 = 4;
  for(var_01 = 0; var_01 < var_00; var_01++) {
    func_907F();
  }
}

func_4608() {
  var_00 = undefined;
  foreach(var_02 in level.var_6FC9) {
    if(!var_02.var_54F5) {
      var_00 = var_02;
      break;
    }
  }

  if(!isDefined(var_00)) {
    var_00 = func_907F();
  }

  var_00 method_805B();
  var_00.var_54F5 = 1;
  var_00 method_808C();
  var_00.var_9D65 method_808C();
  return var_00;
}

func_907F() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("dlc_dogtags_zombie_invisible");
  var_00 method_8511();
  var_00.var_54F5 = 0;
  var_00.var_9D65 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  var_00.var_6A55 = var_00 method_85A0();
  level.var_6FC9[level.var_6FC9.size] = var_00;
  return var_00;
}

func_6FC7() {
  return 0;
}

func_7A55() {
  level.var_6FD2 = [];
  foreach(var_03, var_01 in level.var_6FBF) {
    var_02 = level.var_6FBF[var_03]["canBeDroppedByZombies"];
    if(isDefined(var_02) && ![[var_02]]()) {
      continue;
    }

    level.var_6FD2[level.var_6FD2.size] = var_03;
  }

  level.var_6FD2 = common_scripts\utility::func_0F92(level.var_6FD2);
  while(isDefined(level.var_6FD0) && level.var_6FD2.size > 1 && level.var_6FD2[0] == level.var_6FD0) {
    level.var_6FD2 = common_scripts\utility::func_0F92(level.var_6FD2);
  }
}

func_83B4() {
  if(level.var_6FD3 >= level.var_6FD2.size) {
    level.var_6FD3 = 0;
    func_7A55();
  }

  if(isDefined(level.var_6FD0) && level.var_6FD2[level.var_6FD3] == level.var_6FD0 && level.var_6FD3 < level.var_6FD2.size - 1) {
    var_00 = level.var_6FD2[level.var_6FD3];
    level.var_6FD2[level.var_6FD3] = level.var_6FD2[level.var_6FD3 + 1];
    level.var_6FD2[level.var_6FD3 + 1] = var_00;
  }

  var_01 = level.var_6FD2[level.var_6FD3];
  level.var_6FD3++;
  return var_01;
}

func_5775(param_00) {
  if(isDefined(level.var_6FD0) && param_00 == level.var_6FD0) {
    return 0;
  }

  return 1;
}

func_83B5() {
  for(var_00 = func_83B4(); !func_5775(var_00); var_00 = func_83B4()) {}

  return var_00;
}

func_83B6(param_00) {
  var_01 = func_83B5();
  if(var_01 != param_00) {
    return var_01;
  }

  while(var_01 == param_00) {
    var_01 = func_83B5();
  }

  for(var_02 = level.var_6FD2.size - 1; var_02 >= level.var_6FD3; var_02--) {
    level.var_6FD2[var_02 + 1] = level.var_6FD2[var_02];
  }

  level.var_6FD2[level.var_6FD3] = param_00;
  if(level.var_6FD3 < level.var_6FD2.size - 1 && level.var_6FD2[level.var_6FD3] == level.var_6FD2[level.var_6FD3 + 1]) {
    level.var_6FD3++;
  }

  return var_01;
}

func_809A() {
  level waittill("zombie_wave_started");
  var_00 = level.var_744A.size * 1000;
  var_01 = level.var_744A.size * 2000;
  if(lib_0547::func_0F0F("specialty_class_resourceful_zm")) {
    var_01 = level.var_744A.size * 1500;
  }

  var_02 = 1.14;
  var_03 = var_02;
  var_04 = var_00 + var_01;
  func_6FC8("Next Scheduled at " + var_04 + " points");
  for(;;) {
    var_05 = 0;
    foreach(var_07 in level.var_744A) {
      if(isDefined(var_07.var_62D7)) {
        var_05 = var_05 + var_07.var_62D7;
      }
    }

    if(var_05 > var_04) {
      level.var_34AA = 1;
      func_6FC8("Reached Scheduled " + var_05 + ">" + var_04);
      var_01 = level.var_744A.size * 2000;
      if(lib_0547::func_0F0F("specialty_class_resourceful_zm")) {
        var_01 = level.var_744A.size * 1500;
      }

      var_04 = var_05 + var_01 * var_03;
      var_03 = var_03 * var_02;
      func_6FC8("Next Scheduled at " + var_04 + " points");
    }

    wait(0.5);
  }
}

func_457B() {
  var_00 = lib_0547::func_45C9() + 1;
  var_00 = clamp(var_00, 2, 4);
  if(lib_0547::func_0F0F("specialty_class_resourceful_zm")) {
    var_00 = var_00 + 1;
  }

  return var_00;
}

func_4600() {
  return 1;
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_zombies_roundswitch", 0);
  maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
  setdynamicdvar("scr_zombies_roundlimit", 1);
  maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
  setdynamicdvar("scr_zombies_winlimit", 1);
  maps\mp\_utility::func_7C04(level.var_3FDC, 1);
  setdynamicdvar("scr_zombies_halftime", 0);
  maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
  setdynamicdvar("scr_zombies_timeLimit", 0);
  maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
  setdynamicdvar("scr_zombies_numLives", 1);
  maps\mp\_utility::func_7BF1(level.var_3FDC, 1);
  setdynamicdvar("5539", 1);
}

func_6BAF() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  for(var_00 = 0; var_00 < 4; var_00++) {
    var_01 = "ui_zm_characterClient_" + var_00;
    setomnvar(var_01, -1);
    var_01 = "ui_zm_character_" + var_00;
    setomnvar(var_01, -1);
  }

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_DOM");
  maps\mp\_utility::func_86DB("allies", &"HORDE_OBJECTIVE_SCORE");
  maps\mp\_utility::func_86DB("axis", &"HORDE_OBJECTIVE_SCORE");
  maps\mp\_utility::func_86D8("allies", undefined);
  maps\mp\_utility::func_86D8("axis", undefined);
  maps\mp\_trigger::func_5258();
  thread lib_050D::func_10E4();
  thread func_5264();
  var_02[0] = level.var_3FDC;
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
  func_5372();
  level maps\mp\zombies\_zombies_rank::func_00D5();
  level thread lib_054D::func_00D5();
  level thread func_AC6F();
  level thread func_6B72();
  level thread lib_0547::func_4AD7();
  level thread lib_056D::func_00D5();
  level thread maps\mp\zombies\zombie_weapon_kits_shared::weaponkitsinitshared();
  level thread lib_056C::func_A9CE();
  level thread maps\mp\zombies\_zombies_magicbox::func_00D5();
  level thread maps\mp\zombies\_zombies_power::func_00D5();
  level thread lib_0545::func_00D5();
  level thread lib_053F::func_00D5();
  level thread lib_0569::func_5326();
  level thread lib_056A::func_00D5();
  level thread lib_0559::func_00D5();
  level thread lib_0552::func_00D5();
  level thread maps\mp\zombies\_zombies_traps::func_00D5();
  level thread lib_0556::func_00D5();
  level thread lib_0586::func_AC73();
  level thread lib_054E::func_00D5();
  level thread lib_0549::func_00D5();
  level thread lib_053E::func_00D5();
  level thread lib_0540::func_00D5();
  level thread lib_055B::func_00D5();
  level thread lib_0561::func_00D5();
  level thread lib_054F::func_00D5();
  level thread lib_0547::func_ABE5();
  level thread lib_0547::func_A2A2();
  level thread maps\mp\zombies\_zombies_roles::func_00D5();
  level thread func_7FE3();
  level thread func_4B0A();
  level thread func_4ADB();
  level thread lib_0555::func_531F();
  level lib_0565::func_5373();
  lib_0565::func_7C07("wicht_set");
  thread func_4DF4();
  if(common_scripts\utility::func_562E(level.iszombiesshotgun) && isDefined(level.onstartshotgunfunc)) {
    [[level.onstartshotgunfunc]]();
  }

  if(isDefined(level.var_6BB0)) {
    [[level.var_6BB0]]();
  }
}

func_5372() {
  maps\mp\_utility::func_3FA3("insta_kill", 0);
  maps\mp\_utility::func_3FA3("double_points", 0);
  maps\mp\_utility::func_3FA3("fire_sale", 0);
  maps\mp\_utility::func_3FA3("power_off", 0);
  common_scripts\utility::func_3C87("flag_rounds_unpaused");
  common_scripts\utility::func_3C8F("flag_rounds_unpaused");
  level.var_A980 = 0;
  level.var_AC9D = 0;
  level.var_ACC3 = 0;
  level.var_ACC4 = 0;
  level.var_90D3 = 0;
  level.var_90D2 = 0;
  level.var_7F2A = "normal";
  level.var_5B95 = (0, 0, 0);
  level.var_AC21 = 0;
  level.var_3294 = 0;
  level.var_7543 = 1;
  level.var_77B7 = 0;
  level.var_745F = 0;
  level.var_AC60 = [];
  lib_0547::func_7D79();
  level.var_32CF = 0;
  level.var_6082 = 200;
  level.var_7541 = [];
  level.var_7541["damage_body"] = int(10 * level.var_7543);
  level.var_7541["damage_head"] = int(10 * level.var_7543);
  level.var_7541["kill_trap"] = int(10 * level.var_7543);
  level.var_7541["kill_limb"] = int(50 * level.var_7543);
  level.var_7541["kill_streak"] = int(40 * level.var_7543);
  level.var_7541["kill_body"] = int(60 * level.var_7543);
  level.var_7541["kill_head"] = int(100 * level.var_7543);
  level.var_7541["kill_melee"] = int(130 * level.var_7543);
  level.var_7541["kill_HeavyMelee"] = int(60 * level.var_7543);
  level.var_7541["kill_HeavyMeleeBonus"] = int(150 * level.var_7543);
  level.var_7541["kill_melee_aoe"] = int(60 * level.var_7543);
  level.var_7541["kill_reward_trap"] = int(60 * level.var_7543);
  level.var_7541["kill_follower"] = int(200 * level.var_7543);
  level.var_7541["kill_fireman"] = int(750 * level.var_7543);
  level.var_7541["kill_fireman_assist"] = int(500 * level.var_7543);
  level.var_7541["power_on"] = int(100 * level.var_7543);
  level.var_7541["atm"] = int(100 * level.var_7543);
  level.var_7541["atm_jackpot"] = int(10 * level.var_7543);
  level.var_7541["cure"] = int(100 * level.var_7543);
  level.var_7541["crate"] = int(500 * level.var_7543);
  level.var_7541["nuke"] = int(400 * level.var_7543);
  level.var_7541["reward_bronze"] = int(500 * level.var_7543);
  level.var_7541["reward_silver"] = int(1000 * level.var_7543);
  level.var_7541["reward_gold"] = int(2000 * level.var_7543);
  level.var_7541["breach_fix"] = int(200 * level.var_7543);
  level.var_7541["repair"] = int(10 * level.var_7543);
  level.var_7541["perfectRound"] = int(100 * level.var_7543);
  level.var_7541["mercReward"] = int(5 * level.var_7543);
  level.var_7541["damage_over_time"] = int(5 * level.var_7543);
  level.var_7541["one_shot_one_kill"] = int(20 * level.var_7543);
  level.zombiemeleeweapon = [];
  level.zombieprimaryweapon = [];
  level.zombietacticalweapon = [];
  level.zombielethalweapon = [];
  level.meleeaoeweapons = [];
  level.zerorewardweapons = [];
  level.nopainweapons = [];
  level.nolevelup = [];
  level.nodamagescalingweapons = [];
  level.aebaseweapons = [];
  level.nobonusammoreward = [];
  level.weaponguidoverrides = [];
  if(!isDefined(level.var_3283)) {
    level.var_3283 = [];
  }
}

func_AC53() {
  thread maps\mp\gametypes\_menus::func_873A("allies");
  self.var_0179 = "allies";
}

func_6B72() {
  for(;;) {
    level waittill("connected", var_00);
    if(common_scripts\utility::func_562E(level.immediately_skip_loading_cinematic)) {
      function_0292(var_00);
    }

    var_00 thread monitor_loading_cinematic_state();
    var_00 thread nocontrolduringcinematic();
    thread compassgodhack(var_00);
    if(!isbot(var_00)) {
      lib_0555::func_83DD("join", var_00);
      level thread func_637E(var_00);
    }

    var_00 thread lib_054E::func_5165();
    level thread func_637D(var_00);
    var_00 thread func_742A();
    level thread func_2820(var_00);
    var_00 maps\mp\zombies\_zombies_rank::func_5370();
    var_00 maps\mp\zombies\_zombies_rank::func_7B39();
    var_01 = 0;
    for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
      if(level.var_744A[var_02].var_2418 == var_00.var_2418) {
        var_01 = 1;
        if(!isbot(var_00)) {
          lib_0555::func_83DD("re_join", var_00);
        }
      }
    }

    if(!var_01) {
      level.var_745F++;
    }

    var_00.var_32CE = level.var_6082;
    var_03 = undefined;
    if(isDefined(level.var_477F)) {
      var_00[[level.var_477F]](var_03);
    } else {
      var_00 lib_0547::func_4780(var_03);
    }

    if(isbot(var_00)) {
      continue;
    }

    maps\mp\zombies\_zombies_roles::func_6B6C(var_00);
    var_00 thread lib_0561::func_5332();
    maps\mp\zombies\_zombies_perks::func_6B6C(var_00);
    var_00 thread lib_056A::func_6B6C();
    var_00 thread func_7272();
  }
}

compassgodhack(param_00) {
  if(getdvarint("2161")) {
    param_00 endon("death");
    waittillframeend;
    waittillframeend;
    waittillframeend;
    waittillframeend;
    param_00 setdemigod(1);
    wait 0.05;
    param_00 setdemigod(1);
    wait 0.05;
    param_00 setdemigod(1);
    for(;;) {
      wait 0.05;
      for(var_01 = 0; var_01 < 5; var_01++) {
        if(!param_00 method_85F0()) {
          param_00 setdemigod(1);
        }

        waittillframeend;
      }
    }
  }
}

func_742A() {
  self endon("disconnect");
  for(;;) {
    if(self isonground()) {
      if(isDefined(self.var_0116) && isDefined(self.var_5BA3) && self.var_4B96) {
        var_00 = distance2d(self.var_5BA3, self.var_0116);
        var_01 = self.var_9092 == self.var_0116;
        var_02 = 100 > var_00 && var_00 > 0;
        if((!var_01 || var_01 && self.var_4B7A) && var_02) {
          self.var_4B7A = 1;
          self.var_3036 = self.var_3036 + var_00;
          if(self issprinting()) {
            self.var_3034 = self.var_3034 + var_00;
          }
        }
      }

      self.var_5BA3 = self.var_0116;
    }

    wait 0.05;
  }
}

func_2820(param_00) {
  param_00.var_A9EB = [];
  param_00.var_A9DF = [];
  param_00.var_AC5D = [];
  param_00.besttimetrialtimes = [];
  param_00.var_7545 = [];
  param_00.var_00B7 = 0;
  param_00.var_014D = 0;
  param_00.var_5F7C = 0;
  param_00.var_9CFF = 0;
  param_00.zombiepointsearned = 0;
  param_00.var_4BF7 = 0;
  param_00.var_60EC = 0;
  param_00.var_4868 = 0;
  param_00.equipmentkills = 0;
  param_00.equipmentused = 0;
  param_00.var_394C = 0;
  param_00.var_6882 = 0;
  param_00.var_6881 = 0;
  param_00.var_178B = 0;
  param_00.var_68A0 = 0;
  param_00.var_7D10 = 0;
  param_00.var_AACE = 0;
  param_00.var_6F5F = 0;
  param_00.var_3295 = 0;
  param_00.var_90CC = 0;
  param_00.var_7E5F = 0;
  param_00.var_598C = 0;
  param_00.var_6E48 = 0;
  param_00.var_2AB8 = 0;
  param_00.var_99F8 = 0;
  param_00.var_32CD = 0;
  param_00.var_5BF3 = 0;
  param_00.var_8B3D = 0;
  param_00.var_8B33 = 0;
  param_00.var_4DC4 = 0;
  param_00.var_4DC5 = 0;
  param_00.var_831B = [];
  param_00.var_3036 = 0;
  param_00.var_3034 = 0;
  param_00.var_4B7A = 0;
  param_00.var_7F1D = 0;
  param_00.var_7F1E = 0;
  param_00.var_99F8 = 0;
  param_00.var_32CD = 0;
  param_00.var_5BF3 = 0;
  param_00.var_5A52 = 0;
  param_00.var_4BF8 = 0;
  param_00.var_3963 = 0;
  param_00.var_178B = 0;
  param_00.var_32D1 = 0;
  param_00.var_5F7D = 0;
  param_00.var_6F60 = 0;
  param_00.var_3296 = 0;
  param_00.var_5F7D = 0;
  param_00.var_90CD = 0;
  param_00.var_7E60 = 0;
  param_00.var_598D = 0;
  param_00.var_6E49 = 0;
  param_00.var_3037 = 0;
  param_00.var_3035 = 0;
  param_00.var_4DE1 = 0;
  param_00.var_8B39 = 0;
  param_00.var_801D = 0;
  param_00.var_39E6 = 0;
  param_00.var_39E4 = 0;
  level.var_745F = level.var_744A.size;
  param_00.var_7F11 = 0;
  param_00.var_7F06 = 0;
  param_00.var_7EFE = 0;
  param_00.var_7F09 = 0;
  param_00.var_7F10 = 0;
  param_00.var_7F07 = 0;
  param_00.var_7F04 = 0;
  param_00.var_7F0B = 0;
  param_00.var_7F0D = 0;
  param_00.var_7F08 = 0;
  param_00.var_801C = 0;
  param_00.var_39E5 = 0;
  param_00.var_39E3 = 0;
  param_00.var_AC30 = [];
  var_01 = "mp/zombieTypeTable.csv";
  var_02 = function_027A(var_01);
  if(var_02 > 24) {}

  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = tablelookupbyrow(var_01, var_03, 1);
    param_00.var_AC5D[var_04] = 0;
  }

  var_05 = 500;
  if(maps\mp\zombies\_zombies_money::func_2698() >= 10) {
    var_05 = 0;
  }

  var_05 = var_05 - maps\mp\zombies\_zombies_money::func_467F(param_00);
  var_05 = int(max(0, var_05));
  param_00 func_7D63(var_05);
  param_00 func_5361();
  param_00 lib_0547::func_7454(0);
  func_283D(param_00, "shovel_zm");
  level thread func_63C8(param_00);
  level thread func_7407(param_00);
}

func_A14A() {
  var_00 = 999999999;
  var_01 = self.var_62D6;
  if(var_01 > var_00) {
    var_01 = var_00;
  }

  var_02 = self.var_62D7;
  if(var_02 > var_00) {
    var_02 = var_00;
  }

  var_03 = 9999999;
  var_04 = var_01;
  if(var_04 > var_03) {
    var_04 = var_03;
  }

  if(isDefined(self.characterclientindex)) {
    setomnvar("ui_zm_points_" + self.characterclientindex, var_04);
  }

  self.var_015C = var_01;
  self.var_008F = var_02;
  maps\mp\_utility::func_86F5("score", var_01);
  maps\mp\_utility::func_86F5("extrascore0", var_02);
}

func_7D63(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 = int(param_00);
  self.var_62D6 = param_00;
  self.var_62D7 = param_00;
  func_A14A();
  self notify("money_update");
  self setclientomnvar("ui_zm_award_points", 0);
}

func_4798(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 = int(param_00);
  if(!isDefined(param_01) || param_01 != 1) {
    param_01 = 0;
  }

  var_02 = param_00;
  if(var_02 > 9999) {
    var_02 = 9999;
  }

  self.var_7545[self.var_7545.size] = var_02;
  self.var_62D6 = self.var_62D6 + param_00;
  if(isDefined(level.zmb_events_player_zombie_aquired_jolts)) {
    self thread[[level.zmb_events_player_zombie_aquired_jolts]](param_00, param_01);
  }

  if(!param_01) {
    self.var_62D7 = self.var_62D7 + param_00;
    if(isDefined(self.var_7F1D)) {
      self.var_7F1D = self.var_7F1D + param_00;
    }
  }

  func_A14A();
  self notify("money_update");
}

func_90F5(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 = int(param_00);
  var_02 = 0 - param_00;
  if(var_02 < -9999) {
    var_02 = -9999;
  }

  self.var_7545[self.var_7545.size] = var_02;
  self.var_62D6 = self.var_62D6 - param_00;
  if(isDefined(self.var_7F1E)) {
    self.var_7F1E = self.var_7F1E + param_00;
  }

  if(isDefined(self.gamemoneyspent) && !common_scripts\utility::func_562E(param_01)) {
    self.gamemoneyspent = self.gamemoneyspent + param_00;
  }

  func_A14A();
  self notify("money_update");
}

func_4480(param_00) {
  return param_00.var_62D6;
}

func_5361() {
  var_00 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "tokensAvailable");
  func_874B(var_00);
}

func_46E8() {
  return 1000;
}

func_4B9D(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  return self.var_9A86 >= param_00;
}

func_47C0(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  func_874B(self.var_9A86 + param_00);
}

func_90F6(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  func_874B(self.var_9A86 - param_00);
}

func_874B(param_00) {
  if(level.var_9A87) {
    if(param_00 < 0) {
      param_00 = 0;
    }

    self.var_9A86 = param_00;
    self setrankedplayerdata(common_scripts\utility::func_46A7(), "tokensAvailable", self.var_9A86);
    self setclientomnvar("ui_zm_token_count", self.var_9A86);
    return;
  }

  self.var_9A86 = -1;
  self setclientomnvar("ui_zm_token_count", -1);
}

func_283D(param_00, param_01) {
  var_02 = getweapondisplayname(param_01);
  if(lib_0547::func_4BA8(param_00, var_02)) {
    return;
  }

  param_00.var_A9EB[var_02]["level"] = 1;
}

func_A9DB(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(;;) {
    param_00 common_scripts\utility::func_A70A("weaponLevelEarned", "weapon_change");
    var_01 = lib_0547::func_462A(param_00);
    var_02 = getweapondisplayname(var_01);
    if(!lib_0547::func_4BA8(param_00, var_02)) {
      continue;
    }

    var_03 = param_00.var_A9EB[var_02]["level"];
    if(100 < var_03) {
      var_03 = 100;
    }

    param_00 setclientomnvar("ui_horde_count", var_03);
  }
}

func_7407(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 waittill("spawned");
  var_01 = 0;
  if(isDefined(level.var_A980)) {
    var_01 = level.var_A980 - 1;
  }

  param_00 lib_0547::func_7B37(var_01);
}

func_637E(param_00) {
  level endon("game_ended");
  var_01 = param_00 getentitynumber();
  param_00 waittill("disconnect");
  lib_0555::func_83DD("leave", var_01);
  lib_0547::clearrangedperk(var_01);
}

func_637D(param_00) {
  level endon("game_ended");
  param_00 waittill("disconnect");
  level notify("player_disconnected");
}

func_AC20() {
  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "";
  self.var_012C["gamemodeLoadout"] = level.var_629B[level.var_746E];
  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
}

func_6B81() {
  if(function_01EF(self)) {
    self thread[[maps\mp\agents\_agent_utility::func_0A59("spawn")]]();
    return;
  }

  thread func_6BA4();
}

func_6BA4(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawnplayer_giveloadout");
  lib_0547::func_AC16(0, "class");
  maps\mp\zombies\_zombies_perks::func_6B81();
  maps\mp\killstreaks\_killstreaks::func_2400();
  if(lib_0547::func_5767(self)) {
    var_01 = "shovel_zm";
    if(isPlayer(self)) {
      var_02 = "ui_zm_character_" + self.characterclientindex + "_alive";
      setomnvar(var_02, 1);
      setomnvar("ui_zm_points_" + self.characterclientindex, self.var_62D6);
      var_03 = self method_834A();
      if(var_03 != "none") {
        maps\mp\zombies\_zombies_magicbox::func_3AC1(self, var_03);
      }

      maps\mp\_utility::func_47A2("specialty_pistoldeath");
      maps\mp\_utility::func_47A2("specialty_coldblooded");
      maps\mp\_utility::func_47A2("specialty_sprintreload");
      maps\mp\_utility::func_47A2("specialty_falldamage");
      maps\mp\_utility::func_861B();
      if(level.var_A980 <= 1 && !isDefined(self.var_596A)) {
        self.var_596A = 1;
      }

      if(level.var_A980 <= 5 && !isDefined(self.joinedearlyrounds)) {
        self.joinedearlyrounds = 1;
      }

      self.var_4D13 = undefined;
      if(isDefined(self.var_18A8)) {
        self.var_18A8 delete();
      }

      if((!isDefined(self.var_7216) || !self.var_7216) && (!isDefined(level.var_AC28) || !level.var_AC28) && func_4458() != "none") {
        func_74BD();
        self.var_7216 = 1;
      } else {
        self.var_8C8B = 1;
        var_01 = self getcurrentprimaryweapon();
        var_04 = maps\mp\zombies\_zombies_magicbox::func_454B(self, "shovel_zm");
        var_05 = lib_056C::getzombiepaintjob(self, var_04);
        maps\mp\_utility::func_0642(var_04, undefined, var_05);
        self setspawnweapon(var_01, 1, 1);
      }

      lib_0547::func_0A00(self, self getcurrentprimaryweapon());
      thread func_4AE1();
      var_06 = getmatchdata("players", self.var_2418, "utc_first_spawn_time_s");
      if(!isDefined(var_06) || var_06 == 0) {
        setmatchdata("players", self.var_2418, "utc_first_spawn_time_s", getsystemtime());
      }
    }

    thread maps\mp\zombies\_zombies_roles::func_6B81();
    lib_0547::func_7ACD();
  }

  if(isDefined(level.var_6BA5)) {
    self[[level.var_6BA5]]();
  }

  self notify("zombie_player_spawn_finished");
}

func_A799(param_00) {
  for(;;) {
    if(self method_842C(self, param_00)) {
      break;
    }

    wait 0.05;
  }
}

func_3E8D() {
  self endon("disconnect");
  self freezecontrols(1);
  wait(4);
  self freezecontrols(0);
}

func_4458() {
  switch (self.var_20D8) {
    default:
      return "none";
  }
}

func_4457() {
  switch (self.var_20D8) {
    default:
      return "";
  }
}

func_74BD() {
  var_00 = func_4458();
  var_01 = self getcurrentprimaryweapon();
  if(isDefined(var_00)) {
    var_02[0] = "shovel_zm";
    var_02[1] = var_00;
    func_A799(var_02);
    thread func_3E8D();
    wait(1);
    lib_0586::func_078C(var_00);
    lib_0586::func_078E(var_00, 1);
    self method_8326();
    self method_812B(0);
    wait(3.6);
    self method_8327();
    self method_812B(1);
    lib_0586::func_0790(var_00);
  }

  lib_0586::func_078C("shovel_zm");
  lib_0586::func_078E(var_01, 1);
}

func_74EB(param_00, param_01) {
  if(lib_0547::func_577E(self)) {
    return;
  }

  var_02 = self getcurrentweapon(1);
  if(issubstr(var_02, "turrethead")) {
    return;
  }

  self.var_74B9 = 1;
  lib_0586::func_078C(param_00);
  lib_0586::func_078E(param_00, 1);
  self method_8326();
  self method_812B(0);
  wait(param_01);
  self method_812B(1);
  lib_0586::func_0790(param_00);
  if(!lib_0547::func_577E(self)) {
    self method_8327();
    lib_0586::func_078E(var_02, 1);
  }

  self.var_74B9 = 0;
}

func_2440() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  if(!function_01EF(self)) {
    thread maps\mp\gametypes\_playerlogic::func_8753(-1);
  }
}

func_A79D() {
  maps\mp\_utility::func_3FA5("prematch_done");
  setomnvar("ui_match_countdown_title", 0);
  if(!isDefined(level.var_585D) || !level.var_585D) {
    while(!isDefined(level.var_1A6E) || level.var_1A6E == 0) {
      wait 0.05;
    }
  }

  for(;;) {
    var_00 = 0;
    foreach(var_02 in level.var_744A) {
      if(!var_02 player_is_playing_loading_cinematic()) {
        var_00 = 1;
        break;
      }
    }

    if(var_00) {
      break;
    }

    wait 0.05;
  }

  function_028F();
  level.immediately_skip_loading_cinematic = 1;
}

func_A90F() {
  level endon("game_ended");
  for(;;) {
    level waittill("host_migration_end");
    var_00 = int(max(min(level.var_A980, 9999), 1));
    setomnvar("ui_zm_round_number", var_00);
    foreach(var_02 in level.var_744A) {
      if(isai(var_02)) {
        continue;
      }

      if(!isDefined(var_02)) {
        continue;
      }

      if(!isDefined(var_02.var_4DF5)) {
        continue;
      }

      if(!var_02.var_4DF5.size) {
        continue;
      }

      var_03 = var_02.var_4DF5.size;
      for(var_04 = 0; var_04 < var_03; var_04++) {
        if(!isDefined(var_02)) {
          continue;
        }

        if(!function_01EF(var_02)) {
          var_02 setclientomnvar("ui_horde_update_perk", var_02.var_4DF5[var_04]["index"]);
        }

        wait 0.05;
      }
    }
  }
}

func_0997(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_AAFD)) {
    level.var_AAFD = [];
  }

  var_04 = spawnStruct();
  level.var_AAFD[param_00] = var_04;
  var_04.var_920F = param_01;
  var_04.var_367E = param_02;
  var_04.var_51D5 = param_03;
}

func_5294(param_00) {
  common_scripts\utility::func_3C87("safe_haven_closed");
  foreach(var_02 in level.var_AAFD) {
    level thread[[var_02.var_51D5]]();
  }

  func_92EC(param_00);
}

func_92EC(param_00) {
  if(isDefined(level.var_76DE)) {}

  if(isDefined(level.var_2957)) {
    level thread[[level.var_2957.var_367E]]();
    level.var_76DE = level.var_2957;
  }

  level.var_2957 = level.var_AAFD[param_00];
  level thread[[level.var_2957.var_920F]]();
}

func_37BE() {
  func_802A();
  level notify("entered_safe_haven");
}

func_802A(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(common_scripts\utility::func_3C77("flag_rounds_unpaused")) {
    if(!level.var_AC28) {
      level waittill("zombie_wave_started");
      wait(1);
    }

    level notify("zombie_wave_interrupt");
    wait(0.5);
    if(param_00) {
      var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
      foreach(var_03 in var_01) {
        var_03 suicide();
      }
    }

    level.var_AC11 = 0;
    level notify("zombie_wave_ended");
    common_scripts\utility::func_3C7B("flag_rounds_unpaused");
  }
}

func_8029() {
  common_scripts\utility::func_3C8F("flag_rounds_unpaused");
}

func_8028(param_00) {
  level.var_ACC3 = 0;
  level.var_AC9D = 1;
  level.var_ACC4 = level.var_A980;
}

func_38F4() {
  level notify("leaving_safe_haven");
  func_8029();
}

func_7FCA() {
  self endon("cleanup_safe_haven_trigger");
  level endon("safe_haven_closing");
  var_00 = common_scripts\utility::func_41F0();
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_01A5) && isDefined(var_02.var_0165)) {
      if(var_02.var_01A5 == "door" && var_02.var_0165 == "safe_haven") {
        self.var_537E = var_02;
      } else if(var_02.var_01A5 == "door" && var_02.var_0165 == "closeable") {
        self.var_6C6E = var_02;
      }
    }

    if(isDefined(self.var_537E) && isDefined(self.var_6C6E)) {
      break;
    }
  }

  thread func_7FC9();
  thread func_63DA();
  thread func_7FCB();
}

func_4240(param_00, param_01, param_02) {
  var_03 = param_00 * param_01;
  var_04 = ceil(param_01 * param_02);
  return var_03 + "/" + var_04;
}

func_63DA() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0.5;
  while(var_00 < var_02) {
    level waittill("safe_haven_trigger_ratio", var_00, var_01);
    if(var_00 < var_02) {
      var_03 = func_4240(var_00, var_01, var_02);
      iprintlnbold(var_03 + " vote to open Safe Haven");
    }
  }

  level notify("safe_haven_opening");
  common_scripts\utility::func_3C7B("safe_haven_closed");
  var_04 = 1;
  var_02 = 1;
  while(var_00 < var_02) {
    var_03 = func_4240(var_00, var_01, var_02);
    iprintlnbold(var_03 + " vote to close Safe Haven");
    level waittill("safe_haven_trigger_ratio", var_00, var_01);
  }

  common_scripts\utility::func_3C8F("safe_haven_closed");
  self.var_537E notify("open");
  self.var_6C6E notify("close");
}

func_7FC9() {
  self.var_5BCC = 0;
  for(;;) {
    if(self.var_5BCC == 0) {
      self waittill("trigger");
    } else {
      maps\mp\_utility::func_A6D1(0.5, "trigger");
    }

    var_00 = 0;
    var_01 = 0;
    foreach(var_03 in level.var_744A) {
      if(maps\mp\_utility::func_57A0(var_03)) {
        var_00++;
        if(self istouching(var_03)) {
          var_01++;
        }
      }
    }

    if(var_00 == 0) {
      var_05 = 0;
    } else {
      var_05 = var_01 / var_00;
    }

    if(var_05 != self.var_5BCC) {
      level notify("safe_haven_trigger_ratio", var_05, var_00);
      self.var_5BCC = var_05;
    }

    wait(0.5);
  }
}

func_5A4E() {
  common_scripts\utility::func_3C9F("safe_haven_closed");
  foreach(var_01 in level.var_744A) {
    if(maps\mp\_utility::func_57A0(var_01) && !self istouching(var_01)) {
      var_01 suicide();
    }
  }
}

func_7FCB() {
  thread func_5A4E();
  level waittill("safe_haven_opening");
  if(common_scripts\utility::func_3C77("safe_haven_closed")) {
    return;
  }

  level endon("safe_haven_closed");
  var_00 = 60;
  var_01 = gettime() + var_00 * 1000;
  var_02 = 5;
  for(;;) {
    var_03 = max(0, var_01 - gettime()) / 1000;
    var_04 = ceil(var_03 / 5) * 5;
    if(var_04 > 0) {
      iprintlnbold("Safe House Closes: " + var_04);
    }

    if(var_03 > var_02) {
      wait(var_02);
      continue;
    }

    if(var_03 > 0) {
      wait(var_03);
      continue;
    }

    break;
  }

  common_scripts\utility::func_3C8F("safe_haven_closed");
}

func_6B5C(param_00, param_01, param_02) {
  param_00 thread lib_0553::deathmonitorabandonment();
}

func_6B41(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(level.var_744A.size > 1 || isPlayer(param_00) && param_00 lib_0547::func_73BF()) {
    param_00 method_82CA();
  }

  [[level.var_1E7C]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, 0);
}

func_2FA0(param_00) {
  return !self.var_4B96 && level.var_A980 > 1 && isDefined(level.var_AC11) && level.var_AC11;
}

func_1E38(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = "standard";
  if(lib_0547::func_580B(param_05)) {
    var_0B = "none";
  } else if(function_01EF(self) && isDefined(self.is_fellow_human) && self.is_fellow_human) {
    var_0B = "none";
  } else {
    if(param_05 == "iw5_microwavezm_mp") {
      var_0B = "nosound";
    }

    if(param_02 < self.var_00BC) {
      if(isDefined(self.zombie_shielding_func)) {
        var_0B = "minor";
      } else if(self.var_0A4B == "zombie_heavy") {
        if(lib_0567::func_ABBF(param_00, param_01, param_02, param_04, param_05, param_06, param_07, param_08, param_0A)) {
          var_0B = "weakpoint";
        } else if(param_08 == "head" || param_08 == "helmet" || param_08 == "neck" || param_05 == "panzerschreck_zm" || issubstr(param_05, "fliegerfaust") || issubstr(param_05, "razergun")) {
          var_0B = "standard";
        } else {
          var_0B = "minor";
        }
      } else if(self.var_0A4B == "zombie_exploder") {
        if(lib_0563::func_AB95(self, param_00, param_01, param_02, param_04, param_05, param_06, param_07, param_08, param_0A)) {
          var_0B = "weakpoint";
        }

        if(common_scripts\utility::func_562E(self.sgvip) && common_scripts\utility::func_562E(self.var_392C) && lib_0547::func_5565(param_0A, tolower("TAG_WEAPON"))) {
          var_0B = "minor";
        }
      } else if(self.var_0A4B == "zombie_bob" && common_scripts\utility::func_562E(self.allow_non_engine_hits)) {
        if(param_05 != "wunderbuss_zm") {
          var_0C = self gettagorigin("engine");
          if(distancesquared(var_0C, param_06) > 256) {
            var_0B = "minor";
          } else {
            var_0B = "weakpoint";
          }
        }
      } else if(self.var_0A4B == "zombie_fireman") {
        if(var_0B == "j_backpack") {
          if(self.var_3FEE == 0) {
            var_0C = "weakpoint";
          } else {
            var_0C = "minor";
          }

          if(common_scripts\utility::func_562E(self.godtank)) {
            var_0C = "minor";
          }
        } else if(!common_scripts\utility::func_562E(self.godtank) && self.var_3FEE == 0) {
          if(param_06 == "panzerschreck_zm" || issubstr(param_06, "fliegerfaust") || issubstr(param_06, "tesla_gun") || issubstr(param_06, "razergun") || param_06 == "bazooka_zm") {
            var_0C = "standard";
          } else {
            var_0C = "minor";
          }
        } else {
          var_0C = "standard";
        }
      } else if(lib_0547::func_5565(self.var_0A4B, "zombie_guardian")) {
        if(common_scripts\utility::func_562E(self.zombie_guardian_can_take_damage)) {
          var_0C = "weakpoint";
        } else {
          var_0C = "minor";
        }
      } else if(lib_0547::func_5565(self.var_0A4B, "zombie_king")) {
        switch (param_09) {
          case "soft":
            var_0C = "headshot";
            break;
        }
      } else {
        switch (param_09) {
          case "neck":
          case "helmet":
          case "head":
            var_0C = "headshot";
            break;
        }
      }
    } else if(self.var_0A4B == "zombie_heavy") {
      if(lib_0567::func_ABBF(param_01, param_02, param_03, param_05, param_06, param_07, param_08, param_09, var_0B)) {
        var_0C = "killshot_headshot";
      } else {
        var_0C = "killshot";
      }
    } else {
      switch (param_09) {
        case "neck":
        case "helmet":
        case "head":
          var_0C = "killshot_headshot";
          break;

        default:
          var_0C = "killshot";
          break;
      }
    }
  }

  return var_0C;
}

func_1E68(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(maps\mp\_utility::func_4571() == "mp_zombie_descent" && isDefined(param_01) && isDefined(param_01.var_003A) && issubstr(param_01.var_003A, "trigger_hurt")) {
    foreach(var_0C, var_0B in level.var_6F5C) {
      lib_056A::func_95D7(var_0C);
    }

    if(isDefined(level.var_5F20)) {
      [[level.var_5F20]]();
    }
  }

  if((param_04 == "MOD_MELEE" || param_04 == "MOD_IMPACT") && isDefined(param_00) && isDefined(param_00.var_0A4B) && !common_scripts\utility::func_562E(func_5736(self, param_01)) && param_00.var_0A4B == "zombie_heavy") {
    self shellshock("zm_heavy_hit", 1, 0, 0);
  }

  if(isDefined(level.callbackplayerdamagesecondaryhandling)) {
    self thread[[level.callbackplayerdamagesecondaryhandling]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  maps\mp\gametypes\_damage::func_1E68(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_6B77(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isPlayer(self)) {
    lib_053B::func_6B73(param_01);
  }

  if(isDefined(param_01) && isDefined(param_01.var_0A4B) && (param_01.var_0A4B == "zombie_fireman" || common_scripts\utility::func_562E(param_01.isfireassassin)) && param_04 == "MOD_ENERGY" && isPlayer(self)) {
    playfxontagforclients(level.var_0611["player_screen_burn"], self, "TAG_ORIGIN", self);
  }

  if(isPlayer(self)) {
    thread func_21E5(param_01);
  }
}

func_21E5(param_00) {
  if(isDefined(level.var_7F2A) && level.var_7F2A == "zombie_dog") {
    if(isDefined(param_00) && isDefined(param_00.var_0A4B) && param_00.var_0A4B == "zombie_berserker") {
      self.var_4DCB = 1;
      self.var_31AB = 0;
    }
  }
}

func_60F8() {
  self endon("death");
  level endon("game_ended");
  self method_8308(0);
  wait 0.05;
  if(isalive(self)) {
    self method_8308(1);
  }
}

func_740B(param_00, param_01, param_02) {
  if(lib_0547::func_57C2(param_00)) {
    if(isDefined(param_02) && param_02 == "MOD_TRIGGER_HURT") {
      return 0;
    }

    if(isDefined(param_01)) {
      if(common_scripts\utility::func_562E(param_01.var_5869)) {
        return 0;
      }

      if(isai(param_01) && !function_02BF(param_01)) {
        return 0;
      }
    }

    return 1;
  }

  return 0;
}

func_62AF(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = param_03;
  if(isDefined(level.callbackzombiesdamagesecondaryhandling)) {
    level thread[[level.callbackzombiesdamagesecondaryhandling]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  if(!isDefined(param_00)) {
    return 0;
  }

  if(!isDefined(param_05)) {
    return 0;
  }

  if(isDefined(param_00.var_480F) && param_00.var_480F) {
    return 0;
  }

  if(isDefined(param_00.var_6B51) && param_00.var_6B51) {
    if(isDefined(param_02) && !isDefined(param_02.var_60F5) && param_02.var_60F5 == "large") {
      return 0;
    }
  }

  if(isPlayer(param_00) && isDefined(param_02) && isPlayer(param_02)) {
    if(issubstr(param_05, "chatelleroult") && issubstr(param_05, "_pap_zm") && !isDefined(param_00.linkedbubblefx)) {
      param_02 thread maps\mp\gametypes\_damagefeedback::func_A102("minor");
      playFX(common_scripts\utility::func_44F5("zmb_mm_tracer_purp_hit"), param_06 + (0, 0, -30));
      if(!isDefined(param_00.chatelleroult_count)) {
        param_00.chatelleroult_count = [];
        param_00.chatelleroult_count["g43_pap_zm"] = 0;
        param_00.chatelleroult_count["chatelleroult_pap_zm"] = 0;
      }

      if(issubstr(param_05, "chatelleroult_pap_zm")) {
        param_00.chatelleroult_count["chatelleroult_pap_zm"]++;
      } else {
        param_00.chatelleroult_count["g43_pap_zm"]++;
      }

      if(param_00.chatelleroult_count["g43_pap_zm"] >= 5 || param_00.chatelleroult_count["chatelleroult_pap_zm"] >= 10) {
        param_00 thread func_4798(50);
        param_02 thread func_4798(50);
        lib_0378::func_8D74("zmb_pomel_grenade_detonate", param_00.var_0116);
        lib_0378::func_8D74("zmb_pomel_grenade_force_field", param_00.var_0116);
        param_00.chatelleroult_count["g43_pap_zm"] = 0;
        param_00.chatelleroult_count["chatelleroult_pap_zm"] = 0;
        if(isDefined(level.bren_bubble_func)) {
          param_00[[level.bren_bubble_func]]();
        }
      }
    }
  }

  if(isDefined(param_02) && isDefined(param_02.var_0117)) {
    param_02 = param_02.var_0117;
  }

  var_0B = maps\mp\_utility::func_118D(param_00, param_02);
  var_0C = getweapondisplayname(param_05);
  if(!isDefined(var_0C)) {
    var_0C = "none";
  }

  if(isDefined(level.var_29E0[var_0C])) {
    var_0C = level.var_29E0[var_0C];
  }

  if(isDefined(level.var_2C9F) && common_scripts\utility::func_562E(param_00.var_56C2) && isai(param_02) && !function_02BF(param_02)) {
    var_0A = int(var_0A * level.var_2C9F);
  }

  if(common_scripts\utility::func_562E(param_00.is_fellow_human) && lib_0547::func_5864(param_05) || lib_0547::func_5752(param_05)) {
    if(isDefined(param_00.vignettepartner) && isalive(param_00.vignettepartner)) {
      param_00.vignettepartner common_scripts\utility::func_2CBE(0, ::dodamage, param_03, param_06, param_02, param_01, param_04, param_05, param_08);
    }

    return 0;
  }

  if(isPlayer(param_00)) {
    if(param_05 == "drag_explosive_zombie_zm" || param_05 == "frag_skull_zm" || issubstr(param_05, "teslagun") || issubstr(param_05, "raven_sword_zm") || param_05 == "turretweapon_ger_btry_flak38_mp_zombie") {
      return 0;
    }

    if(issubstr(param_05, "frag_grenade_funderbuss_zm")) {
      return 0;
    }

    if(issubstr(param_05, "bazooka_zm") || issubstr(param_05, "panzerschreck_zm") || issubstr(param_05, "fliegerfaust") || issubstr(param_05, "tesla_gun") || lib_0547::func_585C(param_05) || isPlayer(param_02) && param_02 == param_00 && isexplosivedamagemod(param_04)) {
      if(param_00 lib_0547::func_4BA7("specialty_class_flak_jacket_zm")) {
        return 0;
      }

      var_0A = 20;
    }

    if(param_00 maps\mp\zombies\_zombies_perks::func_21B2()) {
      return 0;
    }

    if(isai(param_02) && param_02 lib_0547::func_AC70()) {
      return 0;
    }

    if(var_0B) {
      return 0;
    }

    if(lib_0547::func_577E(param_00)) {
      return 0;
    }

    if(lib_0547::func_5565(param_04, "MOD_FALLING")) {
      return 0;
    }

    if(func_740B(param_00, param_01, param_04)) {
      return 0;
    }

    if(isDefined(param_00.var_5BD7)) {
      var_0D = 1000;
      if(gettime() - param_00.var_5BD7 < var_0D) {
        return 0;
      }
    }

    if(maps\mp\_utility::func_5740(param_05) || maps\mp\zombies\_zombies_traps::func_56E6(param_05) || param_05 == "exploder_zm_small_mp") {
      return 20;
    }

    if(isDefined(param_02) && isai(param_02)) {
      var_0D = 500;
      if(function_02BF(param_02) && isDefined(param_00.var_5C14) && gettime() - param_00.var_5C14 < var_0D) {
        return 0;
      }

      if(function_02BF(param_02) && param_02.var_0A4B == "zombie_heavy") {
        if(common_scripts\utility::func_562E(func_5736(param_00, param_02))) {
          return 0;
        }
      }

      var_0E = level.var_0A50[param_02.var_0A4B].var_60D4;
      var_0F = level.var_0A50[param_02.var_0A4B].var_29AA;
      if(isDefined(var_0E) && param_04 == "MOD_MELEE") {
        var_0A = int(max(var_0A * var_0E, 1));
      } else if(isDefined(var_0F)) {
        var_0A = int(max(var_0A * var_0F, 1));
      }
    }

    if(isDefined(param_05) && isai(param_05)) {
      if(isDefined(level.var_6AE0) && isDefined(level.var_6AE0[param_05.var_0A4B])) {
        param_05[[level.var_6AE0[param_05.var_0A4B]]](param_03);
      }
    }

    if(isDefined(param_05) && param_05.var_003A == "misc_turret" && isDefined(param_04)) {
      if(isDefined(param_05.var_62AD)) {
        var_0D = param_03[[param_05.var_62AD]](var_0D);
      }

      if(isDefined(param_05.var_6B73)) {
        param_03[[param_05.var_6B73]](param_04);
      }
    }

    if(isDefined(param_05) && common_scripts\utility::func_562E(param_05.isinvisiblevisionzombie)) {
      return 0;
    }

    if(param_08 == "exploder_zm_large_mp") {
      param_03 method_854F();
    }

    if(isDefined(param_03.deathravenenergy_test_func) && [[param_03.deathravenenergy_test_func]]() && var_0D >= param_03.var_00BC && param_07 != "MOD_ARMOR" && param_07 != "MOD_TRIGGER_HURT") {
      param_03 notify("dr_shield_activate", param_08);
      return 0;
    }

    if(isDefined(param_03.bloodshieldblock_test_func) && [[param_03.bloodshieldblock_test_func]](param_05, param_04) && param_07 != "MOD_TRIGGER_HURT") {
      param_03 notify("br_block_hit", var_0D, param_08);
      param_03.shield_hit_blocked = gettime();
      return 0;
    }

    if(param_03 lib_0547::func_73E9() > 0 && var_0D >= param_03.var_00BC && param_07 != "MOD_ARMOR") {
      param_03 lib_0547::func_7442(1);
      if(!isDefined(param_09)) {
        param_09 = param_03.var_0116;
      }

      param_03 dodamage(40, param_09, param_05, param_04, "MOD_ARMOR", param_08, var_0B);
      param_03.var_5C14 = gettime();
      param_03.var_00BC = 1;
      if(isDefined(param_05)) {
        if(lib_0547::func_5565(param_05.var_0A4B, "zombie_heavy")) {
          param_03.var_5C13 = param_05;
        }
      }

      return 0;
    }
  }

  if(isai(param_00) && !isPlayer(param_00) && !isDefined(param_02) || !isai(param_02) && !isPlayer(param_02)) {
    if(param_04 == "MOD_FALLING") {
      return 0;
    }

    if(param_05 == "exploder_zm_small_mp" || param_05 == "exploder_zm_large_mp") {
      var_0A = int(level.var_A980 * 100 + 50);
    }

    if(isDefined(param_02) && param_02.var_003A == "misc_turret" && isDefined(param_01) && !lib_0547::func_5565(param_05, "turretweapon_ger_btry_flak38_mp_zombie")) {
      if(isDefined(param_02.modifyagentdamage)) {
        var_0A = param_00[[param_02.modifyagentdamage]](var_0A);
      } else {
        var_0A = param_00.var_00BC + 1;
      }

      if(isDefined(param_02.onagentdamage)) {
        param_00[[param_02.onagentdamage]](param_01);
      } else {
        var_10 = 5000 * vectornormalize(param_00.var_0116 - param_01.var_0116);
        var_10 = (var_10[0], var_10[1], 5000);
        param_00.var_78D5 = var_10;
        param_00.var_78D2 = 1;
        param_00.var_78D3 = "torso_lower";
      }
    }

    var_0A = param_00 lib_053A::func_62A6(var_0A);
    if(!lib_0547::func_580B(param_05) && lib_0547::func_5731() && !param_00 lib_0547::func_53DC() && var_0A != 0) {
      var_0A = param_00.var_00FB + 10;
    }
  }

  if(isai(param_00) && !isPlayer(param_00) && isai(param_02)) {
    if(!function_02BF(param_02) && isalliedsentient(param_00, param_02)) {
      return 0;
    }

    if(isDefined(param_00.var_0A4B) && param_00.var_0A4B == "zm_squadmate") {
      var_0F = level.var_0A50[param_02.var_0A4B].var_29DB;
      if(isDefined(var_0F)) {
        var_0A = int(var_0A * var_0F);
      }
    }

    if(isDefined(param_02) && isDefined(param_02.modifyagentdamage)) {
      var_0A = param_00[[param_02.modifyagentdamage]](var_0A, param_02);
    }
  }

  if(isDefined(param_02) && isPlayer(param_02) && isai(param_00) && !isPlayer(param_00)) {
    var_0A = lib_0586::func_ABD6(param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08);
    if(common_scripts\utility::func_562E(level.iszombiesshotgun)) {
      var_11 = lib_0547::func_AAF9(var_0C, 0, 0);
      var_12 = function_02FF(var_11, "_zm") + "_mp";
      if(isDefined(level.var_A9CB[var_12])) {
        var_13 = param_02 getrankedplayerdata(common_scripts\utility::func_46A8(), "weaponBuildKits", var_12, "bossupgrade");
        if(isDefined(var_13) && var_13) {
          var_0A = var_0A * 1.1;
        }
      }
    }

    if(getdvarint("spv_zm_difficulty_enabled", 0) == 1 && !common_scripts\utility::func_562E(level.nolevelup[param_05])) {
      var_0A = maps\mp\zombies\_zombies_progression::zombie_shotgun_mode_bonus_damage(param_02, var_0A, param_05);
    }

    if(isDefined(level.var_62B3[var_0C])) {
      var_0A = [[level.var_62B3[var_0C]]](param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08);
    }

    if(isDefined(level.var_62B4) && isDefined(param_00.var_0A4B)) {
      if(isDefined(level.var_62B4[param_00.var_0A4B]) && isDefined(level.var_62B4[param_00.var_0A4B][var_0C])) {
        var_0A = [[level.var_62B4[param_00.var_0A4B][var_0C]]](param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08);
      }
    }

    if(lib_0547::func_4BA8(param_02, var_0C)) {
      var_14 = 0.2;
      if(isDefined(param_02.var_A9EB[var_0C]["weapon_level_increase"])) {
        var_14 = param_02.var_A9EB[var_0C]["weapon_level_increase"];
      }

      var_0A = int(var_0A + var_0A * var_14 * param_02.var_A9EB[var_0C]["level"] - 1);
    }

    var_0A = param_00 func_62B0(param_02, param_05, var_0A, param_04, param_06);
    if(isDefined(param_04) && param_04 == "MOD_MELEE" && var_0A > 0) {
      if(param_02 method_8545()) {
        var_0A = level.var_73E0;
      } else if(lib_0542::attemptheavymeleekill(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
        var_0A = param_00.var_00FB + 1;
        if(param_00.var_00BC > 0) {
          param_02 notify("paired_heavy_melee_kill", param_05);
          param_02 lib_0542::onplayerheavymeleekillstart(param_00, param_05);
          param_00.var_0103 = 1;
        }
      } else {
        var_0A = max(var_0A, level.var_7426);
        var_0A = max(var_0A, func_1E59() / 4 + 1);
      }

      if(param_02 lib_056A::func_4B85()) {
        var_15 = func_1E59();
        var_0A = max(var_0A, var_15 / 3 + 1);
        var_0A = var_0A + level.var_7484;
      }

      if(issubstr(param_05, "razergun")) {
        if(param_02 method_8661()) {
          if(param_02 lib_056A::func_4B85()) {
            var_0A = max(var_0A, func_1E59() * 3 + level.var_7484);
          } else {
            var_0A = max(var_0A, func_1E59() * 3);
          }
        } else {
          var_0A = var_0A + 1000;
        }
      }

      if(param_02 lib_0547::func_4BA7("specialty_class_finishing_blow_zm") && param_00.var_00BC <= param_00.var_00FB / 2) {
        var_0A = var_0A * 2;
        param_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_finishing_blow_zm");
      }

      if(isDefined(param_00.var_14EB)) {
        var_0A = var_0A * 4;
        param_00.var_14EB = undefined;
      }
    }

    var_0A = param_02 func_32C5(var_0A, param_04);
    var_0A = param_00 func_65CA(param_05, var_0A, param_08, param_04);
    var_0A = param_00 func_9CF9(param_05, var_0A, param_08, param_04);
    if(common_scripts\utility::func_562E(param_00.var_50D9)) {
      var_0A = var_0A * 2;
    }

    if(isDefined(level.var_ABEE)) {
      if(isDefined(level.var_5BF9) && level.var_5BF9 == 1 && lib_0547::func_577E(param_02)) {
        var_0A = var_0A * 4;
      }
    }

    if(param_02 lib_0547::func_4BA7("specialty_class_discipline_zm")) {
      var_16 = param_02 getstance();
      if(isDefined(param_01) && isDefined(param_01.var_3C1D)) {
        var_16 = param_01.var_3C1D;
      }

      if(!lib_0547::func_577E(param_02)) {
        switch (var_16) {
          case "crouch":
            var_0A = var_0A * 1.1;
            param_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_discipline_zm");
            break;

          case "prone":
            var_0A = var_0A * 1.2;
            param_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_discipline_zm");
            break;

          default:
            break;
        }
      }
    }

    if(param_02 lib_0547::func_4BA7("specialty_class_lucky_crit_zm")) {
      if(param_00[[param_00 maps\mp\agents\_agent_utility::func_0A59("is_hit_weak_point")]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09)) {
        var_17 = randomfloat(1);
        if(var_17 < 0.075) {
          param_00.luckycrit = 1;
          var_18 = func_1E59() + 1;
          if(common_scripts\utility::func_562E(param_00.lucky_crit_nerf)) {
            var_18 = 0;
          }

          var_0A = max(var_0A * 2, var_18);
          param_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_lucky_crit_zm");
        }
      }
    }

    if(param_02 lib_0547::func_4BA7("specialty_class_gungho_zm")) {
      if(issubstr(param_05, "winchester1897") || issubstr(param_05, "walther") || issubstr(param_05, "model21") || issubstr(param_05, "m30") || issubstr(param_05, "blunderbuss")) {
        var_0A = var_0A * 1.25;
      }
    }

    if(isDefined(param_02) && common_scripts\utility::func_562E(param_02.indamagebuffzone) && isPlayer(param_02)) {
      if(isDefined(level.damagebuffzonemultiplier)) {
        var_0A = var_0A * level.damagebuffzonemultiplier;
      } else {
        var_0A = var_0A * 1.5;
      }
    }

    var_0A = param_00 lib_053B::func_62A6(var_0A, param_02, param_04);
    var_0A = param_00 lib_0539::func_62A6(var_0A, param_02, param_04);
    var_0A = param_00 lib_053A::func_62A6(var_0A);
    var_0A = param_00 lib_0538::func_62A6(var_0A, param_02, param_08);
    var_0A = param_00 lib_0537::func_62A6(var_0A, param_01, param_02, param_04, param_05);
    if(common_scripts\utility::func_562E(level.nodamagescalingweapons[param_05])) {
      var_0A = param_03;
    }

    if(!lib_0547::func_580B(param_05) && lib_0547::func_5731() && !param_00 lib_0547::func_53DC() && var_0A != 0) {
      if(isDefined(level.modifyweapondamageoninstakill) && isDefined(level.modifyweapondamageoninstakill[param_05])) {
        var_0A = [[level.modifyweapondamageoninstakill[param_05]]](param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08);
      } else {
        var_0A = param_00.var_00FB + 10;
      }
    }

    if(common_scripts\utility::func_562E(param_00.zmdemigod)) {
      var_0A = min(var_0A, param_00.var_00BC - 1);
    }

    if(param_00 lib_0547::func_AC70()) {
      return 0;
    }

    if(param_00 lib_0547::func_AC59(param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08)) {
      param_00 thread lib_0547::func_AC19(param_00, param_02, var_0A, param_04, param_05, param_06, param_07, param_08);
      return 0;
    }

    if(!lib_0547::func_5774(param_00)) {
      param_02 func_47AD(param_00, var_0A, param_04, param_05, param_06, param_07, param_08, 0);
    }
  }

  if(isPlayer(param_00)) {
    param_00 lib_054E::func_72A3(param_02, var_0A, param_04);
    if(isDefined(param_02) && isai(param_02) && function_02BF(param_02)) {
      param_00.var_5C14 = gettime();
      if(param_02.var_0A4B == "zombie_heavy") {
        param_00.var_5C13 = param_02;
      }
    }
  } else if(isai(param_00) && function_02BF(param_00)) {
    param_00 lib_054E::func_ABCD(param_02, var_0A);
  }

  return int(var_0A);
}

func_5736(param_00, param_01) {
  var_02 = 1000;
  param_01.var_1F52 = 1;
  if(isDefined(param_00.var_5C13) && param_01 == param_00.var_5C13 && gettime() - param_00.var_5C14 < var_02) {
    param_01.var_1F52 = undefined;
    return 1;
  }
}

func_32C5(param_00, param_01) {
  if(!maps\mp\_utility::func_5694(param_01)) {
    return param_00;
  }

  if(isDefined(self.var_6F66) && isDefined(self.var_6F66["doubletap"])) {
    param_00 = param_00 * 2;
  }

  return param_00;
}

func_62B0(param_00, param_01, param_02, param_03, param_04) {
  if(param_03 == "MOD_IMPACT" && !issubstr(param_01, "throwingknife")) {
    if(param_00 lib_0547::func_4BA7("specialty_class_fast_hands_zm")) {
      param_02 = param_02 * 1.5;
    }

    return param_02;
  }

  if(isDefined(param_01) && param_01 == "repulsor_zombie_mp") {
    if(lib_0547::func_53DC()) {
      return 0;
    }

    if(isDefined(self.var_0A4B) && issubstr(self.var_0A4B, "ranged_elite_soldier_goliath")) {
      return 0;
    }

    var_05 = 0;
    foreach(var_07 in level.var_0A50) {
      var_08 = func_1E59(var_07, level.var_A980);
      if(var_08 > var_05) {
        var_05 = var_08;
      }
    }

    return var_05 + 1;
  }

  var_0A = 1;
  if(lib_0547::func_585C(param_01) || maps\mp\zombies\_zombies_traps::func_56E6(param_01)) {
    if(issubstr(param_01, "throwingknife")) {
      param_02 = max(param_02, 2.5 * func_1E59() + 1);
    } else {
      param_02 = common_scripts\utility::func_98E7(level.var_A980 > 0, level.var_A980, 1) * var_0A * randomintrange(100, 200);
    }

    if(isDefined(level.var_62B1)) {
      param_02 = [[level.var_62B1]](param_00, param_01, param_02, param_04);
    }

    if(isDefined(self.var_0A4B) && isDefined(level.var_62A9) && isDefined(level.var_62A9[self.var_0A4B])) {
      param_02 = [[level.var_62A9[self.var_0A4B]]](param_01, param_02, param_04);
    }

    if(param_00 lib_0547::func_4BA7("specialty_class_fast_hands_zm")) {
      param_02 = param_02 * 1.5;
    }
  }

  return param_02;
}

func_65CA(param_00, param_01, param_02, param_03) {
  if(common_scripts\utility::func_562E(self.var_4B6E) && maps\mp\_utility::func_570A(param_00, param_02, param_03)) {
    param_01 = int(param_01 * 0.5);
  }

  if(common_scripts\utility::func_562E(self.var_4B53) && !maps\mp\_utility::func_570A(param_00, param_02, param_03)) {
    param_01 = int(param_01 * 0.5);
  }

  return param_01;
}

func_9CF9(param_00, param_01, param_02, param_03) {
  if(isDefined(param_00) && param_00 == "trap_sniper_zm_mp") {
    if(common_scripts\utility::func_24A6()) {
      param_01 = self.var_00BC + 10;
      if(isDefined(self.var_00FB)) {
        param_01 = self.var_00FB + 10;
      }
    } else {
      param_01 = int(self.var_00BC * 0.5);
      if(isDefined(self.var_00FB)) {
        param_01 = int(self.var_00FB * 0.5);
      }
    }

    if(lib_0547::func_580A()) {
      param_01 = int(param_01 * 0.05);
    }
  }

  if(isDefined(param_00) && param_00 == "zombie_trap_turret_mp") {
    if(lib_0547::func_580A()) {
      param_01 = int(param_01 * 0.05);
    }
  }

  return param_01;
}

func_47AD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = maps\mp\_utility::func_570A(param_03, param_06, param_02, self);
  var_09 = common_scripts\utility::func_562E(param_00.var_0103);
  var_0A = maps\mp\_utility::func_5755(param_02) || param_02 == "MOD_IMPACT";
  var_0B = param_01 >= param_00.var_00BC;
  var_0C = maps\mp\_utility::func_5740(param_03);
  var_0D = lib_0547::func_580B(param_03);
  var_0E = lib_0547::func_57AC(param_03);
  var_0F = lib_0547::func_5752(param_03);
  var_10 = undefined;
  var_11 = undefined;
  if(var_08) {
    self.var_0090++;
    maps\mp\_utility::func_86F5("extrascore1", self.var_0090);
  }

  if(lib_0547::func_577E(self)) {
    return;
  }

  if(common_scripts\utility::func_562E(level.zerorewardweapons[param_03])) {
    return;
  }

  if(var_0A && param_06 == "shield") {
    return;
  }

  if(param_00.var_0A4B == "zombie_fireman" && !var_0B) {
    return;
  }

  if(param_03 == "turretweapon_ger_btry_flak38_mp_zombie") {
    return;
  }

  if(isDefined(param_00.is_fellow_human) && param_00.is_fellow_human) {
    return;
  }

  var_12 = undefined;
  if(var_0B) {
    var_12 = "kill_limb";
    if(var_08 && !var_0D) {
      var_12 = "kill_head";
      self.var_4BF7++;
      if(maps\mp\_utility::func_4431(param_03) == self.var_76D8) {
        self.var_A9BA[self.var_76D9].var_4BF9 = self.var_A9BA[self.var_76D9].var_4BF9 + 1;
      } else {
        var_13 = lib_0547::func_4837(self, param_03);
        if(var_13 == -1) {
          self.var_76D8 = "";
          self.var_76D9 = -1;
        } else {
          self.var_A9BA[var_13].var_4BF9 = self.var_A9BA[var_13].var_4BF9 + 1;
          self.var_76D8 = maps\mp\_utility::func_4431(param_03);
          self.var_76D9 = var_13;
        }
      }
    }

    if(var_0A && !var_0E) {
      var_13 = "kill_HeavyMelee";
      self.var_60EC++;
      var_14 = randomint(100);
      if(var_14 >= 66) {
        var_15 = self getweaponslist("primary");
        foreach(var_17 in var_15) {
          if(common_scripts\utility::func_562E(level.nobonusammoreward[var_17])) {
            continue;
          }

          var_18 = weaponclipsize(var_17);
          var_19 = self getweaponammostock(var_17);
          self setweaponammostock(var_17, var_19 + var_18);
        }

        self notify("heavyMeleeClip_earned");
        var_13 = "kill_HeavyMelee";
        thread maps\mp\gametypes\_hud_message::func_9102("zombie_heavy_melee_ammo_clip");
      } else if(var_14 < 66 && var_14 >= 33) {
        var_1B = self method_834A();
        var_1C = self method_831F();
        var_1D = [var_1B];
        foreach(var_1F in var_1D) {
          if(var_1F == "none" || var_1F == "zom_moonorb_grenade_emp_zm" || var_1F == "zom_moonorb_grenade_zm" || var_1F == "zom_hammer_grenade_zm") {
            continue;
          }

          var_20 = weaponclipsize(var_1F);
          self method_82FA(var_1F, self getweaponammoclip(var_1F) + 1);
          var_13 = "kill_HeavyMelee";
          thread maps\mp\gametypes\_hud_message::func_9102("zombie_heavy_melee_extra_lethal");
          break;
        }
      } else if(var_14 < 33 && var_14 >= 0) {
        var_13 = "kill_HeavyMeleeBonus";
        thread maps\mp\gametypes\_hud_message::func_9102("zombie_heavy_melee_extra_jolts");
      } else {
        var_13 = "kill_HeavyMelee";
      }
    }

    if(var_11) {
      var_14 = "kill_melee_aoe";
    } else if(var_0C && !var_0F && !var_0B) {
      var_14 = "kill_melee";
      self.var_60EC++;
    } else {
      if(func_568C(param_05, var_08, param_04, self)) {
        var_14 = "kill_body";
      }

      if(var_0E) {
        var_14 = "kill_streak";
      }

      if(var_10) {
        var_14 = "kill_reward_trap";
      } else if(var_0F) {
        var_14 = "kill_trap";
      }

      if(isDefined(level.var_47AF)) {
        var_14 = [[level.var_47AF]](var_14, param_05);
      }
    }

    if(var_0C && !var_0F && !isDefined(param_02.var_6B53) || param_02.var_6B53) {
      if(lib_0547::func_4BA7("specialty_class_mugger_zm")) {
        var_13 = 20;
        self luinotifyeventextraplayer(&"trigger_mod_proc", 1, "specialty_class_mugger_zm");
      }
    }

    if(param_02.var_0A4B == "zombie_fireman") {
      var_14 = "kill_fireman";
    } else if(param_02.var_0A4B == "zombie_heavy") {
      var_14 = "kill_follower";
    }
  } else {
    if(var_0E) {
      return;
    }

    if(var_0F) {
      return;
    }

    var_14 = "damage_body";
    if(var_0A && isDefined(param_05) && !maps\mp\_utility::func_5740(param_05)) {
      var_14 = "damage_head";
    }

    if(lib_0547::func_56D0(param_05)) {
      var_14 = "damage_over_time";
    }

    if(!func_73BC(param_05, param_02)) {
      return;
    }
  }

  if(common_scripts\utility::func_562E(level.iszombiesshotgun) && var_0C && !var_0B && common_scripts\utility::func_562E(level.zmb_sg_no_extra_jolts_for_melee)) {
    var_12 = 100;
  }

  func_47AE(var_14, var_12, undefined, var_13);
  if(var_14 == "kill_fireman") {
    foreach(var_23 in level.var_744A) {
      if(var_23 != self && !lib_0547::func_577E(var_23)) {
        var_23 func_47AE("kill_fireman_assist");
      }
    }
  }

  if(var_14 == "kill_limb" || var_14 == "kill_body" || var_14 == "kill_head" || var_14 == "kill_melee" || var_14 == "kill_fireman" || var_14 == "kill_follower") {
    func_47C7(var_14);
  }
}

func_47C7(param_00) {
  switch (param_00) {
    case "kill_body":
    case "kill_limb":
      var_01 = "body";
      break;

    case "kill_head":
      var_01 = "headshot";
      break;

    case "kill_melee":
      var_01 = "melee";
      break;

    case "kill_follower":
      var_01 = "heavy";
      break;

    case "kill_fireman":
      var_01 = "superheavy";
      break;

    case "kill_trap":
      var_01 = "trap";
      break;

    default:
      var_01 = "body";
      break;
  }

  var_02 = self;
  var_02 maps\mp\zombies\_zombies_rank::func_AC23(var_01);
}

func_73BC(param_00, param_01) {
  if(issubstr(param_00, "iw5_em1zm_mp") || param_00 == "turretheadenergy_mp") {
    if(isDefined(self.var_66C0) && gettime() < self.var_66C0) {
      return 0;
    }

    self.var_66C0 = gettime() + 200;
  }

  if(common_scripts\utility::func_562E(level.iszombiesshotgun) && common_scripts\utility::func_562E(level.zmb_sg_disable_jolts_for_damage)) {
    return 0;
  }

  if(isDefined(level.var_73BD) && ![[level.var_73BD]](param_00, param_01)) {
    return 0;
  }

  return 1;
}

func_568C(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    if(isDefined(param_03.var_0117)) {
      if(param_03.var_003B == "script_vehicle") {
        return 0;
      }

      if(param_03.var_003B == "misc_turret") {
        return 0;
      }

      if(param_03.var_003B == "script_model") {
        return 0;
      }
    }

    if(isDefined(param_03.var_0A4B)) {
      if(param_03.var_0A4B == "dog") {
        return 0;
      }
    }
  }

  var_04 = param_01 == "torso_upper" || param_01 == "right_arm_upper" || param_01 == "left_arm_upper" || param_01 == "gun" || param_01 == "torso_lower";
  return var_04 && !maps\mp\_utility::func_5755(param_02) && param_02 != "MOD_IMPACT" && !maps\mp\_utility::func_56DF(param_00);
}

func_47AE(param_00, param_01, param_02, param_03) {
  var_04 = level.var_7541[param_00];
  if(isDefined(param_03)) {
    if(isDefined(var_04)) {
      var_04 = var_04 + param_03;
    }

    if(isDefined(param_01)) {
      param_01 = param_01 + param_03;
    }
  }

  maps\mp\zombies\_zombies_roles::func_6B84(var_04, param_00, param_01);
  if(isDefined(param_01)) {
    var_04 = param_01;
  }

  if(!var_04) {
    return;
  }

  if(common_scripts\utility::func_562E(level.var_2F6C)) {
    return;
  }

  if(maps\mp\_utility::func_3FA0("double_points")) {
    var_04 = int(var_04 * 2);
  }

  if(isDefined(level.eventpointmultiplier)) {
    var_04 = int(var_04 * level.eventpointmultiplier);
    if(var_04 < 5) {
      var_04 = 5;
    } else if(var_04 > 5 && var_04 < 10) {
      var_04 = 10;
    } else if(var_04 > 10 && var_04 < 15) {
      var_04 = 15;
    }
  }

  if(isDefined(param_02) && param_02) {
    var_05 = common_scripts\utility::func_9AAD(var_04);
    var_05 = function_02BE(var_05);
  }

  if(issubstr(param_00, "kill_") || issubstr(param_00, "damage_")) {
    self.zombiepointsearned = self.zombiepointsearned + var_04;
  }

  func_4798(var_04);
}

func_1F32(param_00, param_01) {
  if(param_00 > func_4480(self)) {
    if(!isDefined(param_01) || !param_01) {
      func_3011(self);
    }

    return 0;
  }

  if(isDefined(self.var_74B9) && self.var_74B9) {
    if(!isDefined(param_01) || !param_01) {
      func_3011(self);
    }

    return 0;
  }

  return 1;
}

func_11C2(param_00, param_01, param_02, param_03) {
  if(param_00 == 0) {
    return 1;
  }

  if(!func_1F32(param_00, param_01)) {
    return 0;
  }

  func_90F5(param_00, param_02);
  if(!common_scripts\utility::func_562E(param_03)) {
    if(lib_0575::func_4B8A()) {
      thread lib_0575::func_A22F(param_00);
    }
  }

  return 1;
}

func_3011(param_00) {
  param_00 method_860F("zmb_ui_purchase_fail", param_00);
  lib_0555::func_83DD("poor", param_00);
}

func_63C8(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(;;) {
    if(param_00.var_7545.size > 0) {
      param_00 setclientomnvar("ui_zm_award_points", param_00.var_7545[param_00.var_7545.size - 1]);
      param_00.var_7545 = func_7CE6(param_00.var_7545);
    }

    wait 0.05;
  }
}

func_7CE6(param_00) {
  var_01 = [];
  var_02 = param_00.size - 1;
  if(var_02 > 100) {
    var_02 = 100;
  }

  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_01[var_03] = param_00[var_03];
  }

  return var_01;
}

func_60AF(param_00) {
  if(isai(self)) {
    return 0;
  }

  if(!isDefined(param_00) || param_00 == "none") {
    return 0;
  }

  if(param_00 == "teslagun_zm_blood" || param_00 == "teslagun_zm_death" || param_00 == "teslagun_zm_moon" || param_00 == "teslagun_zm_storm") {
    return 0;
  }

  var_01 = getweapondisplayname(param_00);
  if(issubstr(var_01, "shovel")) {
    return 0;
  }

  return 1;
}

func_34B8(param_00, param_01, param_02) {}

func_A958() {
  self endon("death");
  self.var_0117 endon("disconnect");
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    if(var_00 == self.var_0117) {
      if(func_1F64(var_00)) {
        break;
      } else {
        wait(0.25);
      }
    }
  }

  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_00, self.var_9BBB);
  var_00 thread maps\mp\gametypes\_hud_message::func_9102("zombie_tombstome");
  var_00 method_8615("zmb_pickup_general");
  self.var_9D65 delete();
  self delete();
}

func_1F64(param_00) {
  if(lib_0547::func_577E(param_00)) {
    return 0;
  }

  if(isDefined(param_00.var_74B9) && param_00.var_74B9) {
    return 0;
  }

  return 1;
}

func_7D05(param_00) {
  self endon("death");
  level endon("game_ended");
  if(!isDefined(param_00)) {
    self.var_0117 common_scripts\utility::func_A70A("started_spawnPlayer", "disconnect");
  }

  wait(52);
  thread func_930D();
  wait(8);
  if(!isDefined(self)) {
    return;
  }

  self.var_9D65 delete();
  self delete();
}

func_930D() {
  self endon("trigger");
  self endon("death");
  level endon("game_ended");
  if(!isDefined(self.var_0117)) {
    return;
  }

  self.var_0117 endon("death");
  self.var_0117 endon("disconnect");
  for(;;) {
    self method_805C();
    wait(0.25);
    self showtoclient(self.var_0117);
    wait(0.25);
  }
}

func_6AE2(param_00) {
  if(param_00 != level.var_3772) {
    lib_0553::func_AC1F();
  }
}

func_872E() {
  level.var_629B["allies"] = maps\mp\gametypes\_class::func_44B4();
  level.var_629B["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(0, 1);
  level.var_629B["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(0, 1);
}

func_5264() {
  while(!isDefined(level.var_947C)) {
    wait 0.05;
  }

  level.var_3887 = common_scripts\utility::func_46B7("evac_point", "targetname");
}

func_3656() {
  var_00 = self;
  for(var_01 = 0; var_01 < 10; var_01++) {
    lib_0547::func_ABCA(var_00, var_01);
  }
}

func_7FE3() {
  func_A79D();
  if(!common_scripts\utility::func_562E(level.var_3230)) {
    level thread maps\mp\_utility::func_6F74(::func_3656);
  }

  level.var_3FA6 = 1;
  level thread lib_054E::func_714C();
  if(common_scripts\utility::func_562E(level.var_ABDA)) {
    level waittill("zombies_manual_start");
    level thread func_7E57();
  }

  if(!isDefined(level.zmb_match_countdown_time) && level common_scripts\utility::func_3C77("flag_rounds_unpaused")) {
    func_7FAB();
  } else if(isDefined(level.zmb_match_countdown_time)) {
    wait(level.zmb_match_countdown_time);
  }

  level.var_AC28 = 1;
  if(function_03C4() && getdvarint("2161")) {
    level waittill("forever");
  }

  level thread lib_056D::func_7FE1();
  for(;;) {
    func_A1A0();
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    if(isDefined(level.var_AC3B)) {
      [[level.var_AC3B]]();
    }

    common_scripts\utility::func_3C9F("flag_rounds_unpaused");
    func_7FC8(level.var_A980);
    level notify("zombie_wave_started");
    level.var_AC11 = 1;
    func_08BA(level.var_A980);
    lib_056D::func_A6DC(level.var_A980);
    level notify("zombie_wave_ended");
    level.var_AC11 = 0;
    var_00 = maps\mp\_utility::func_4571();
    if(var_00 == "mp_zombie_nest_01") {
      if(level.var_A980 == 25) {
        level.var_400E[level.var_400E.size] = ["raven_set 2 1", "all"];
      }

      if(level.var_A980 == 30) {
        level.var_400E[level.var_400E.size] = ["survivalist_set 0 1", "all"];
        level.var_400E[level.var_400E.size] = ["survivalist_set 1 1", "all"];
        if(!common_scripts\utility::func_562E(level.var_75FD)) {
          level.var_400E[level.var_400E.size] = ["survivalist_set 2 1", "all"];
        }

        level.var_400E[level.var_400E.size] = ["survivalist_set 3 1", "all"];
        var_01 = 1;
        foreach(var_03 in level.var_744A) {
          if(!isDefined(var_03.var_5F7C) || var_03.var_5F7C == 0) {
            var_01 = 0;
          }
        }

        if(common_scripts\utility::func_562E(var_01)) {
          level.var_400E[level.var_400E.size] = ["survivalist_set 4 1", "all"];
        }
      }

      if(level.var_A980 == 20 && !lib_053F::func_328A()) {
        level.var_400E[level.var_400E.size] = ["mountain_man_set 0 1", "all"];
        level.var_400E[level.var_400E.size] = ["mountain_man_set 1 1", "all"];
      }
    } else if(var_00 == "mp_zombie_training") {
      if(level.var_A980 == 25) {
        level.var_400E[level.var_400E.size] = ["mountain_man_set 2 1", "all"];
        level.var_400E[level.var_400E.size] = ["mountain_man_set 3 1", "all"];
        level.var_400E[level.var_400E.size] = ["mountain_man_set 4 1", "all"];
      }
    }

    func_7FC7();
  }
}

func_08BA(param_00) {
  foreach(var_02 in maps\mp\agents\_agent_utility::func_43FD("all")) {
    if(var_02.var_901F <= param_00) {
      var_02 thread lib_053C::func_4F7F("wave advanced", 0);
    }
  }
}

func_4B0A() {
  level endon("game_ended");
  for(;;) {
    level waittill("host_migration_begin");
    if(level.var_A980 > level.var_7F20) {
      setnojipzombieswave(1);
    }

    level.var_2FDD = [];
    level.var_66BF = 0;
    setdynamicdvar("4696", 0);
    foreach(var_01 in level.var_744A) {
      var_01 lib_0378::func_8D8A();
      var_02 = "";
      if(!var_01 ishost()) {
        var_02 = " not ";
      }
    }
  }
}

func_4ADB() {
  var_00 = level common_scripts\utility::func_A717("game_ended");
  lib_0547::func_AABF();
}

func_4DF4() {}

func_7FAB() {
  thread func_7FC6(10);
  wait(10);
}

get_round_begin_notify(param_00) {
  return "round" + param_00 + "begin";
}

func_A1A0() {
  level.var_A980++;
  level.var_A98C = gettime();
  level notify("waveupdate");
  level notify(get_round_begin_notify(level.var_A980));
  level.var_ACC3++;
  level.var_60A9 = func_457B();
  level.var_6F4A = func_4600();
  level.var_2958 = 0;
  level.var_609C = min(500, level.var_A980 * 50);
  func_1E54();
  if(level.var_A980 > level.var_7F20) {
    setnojipzombieswave(1);
  }

  func_47B7();
  var_00 = lib_0547::func_AC4B(undefined, "wave");
  var_00 lib_0547::func_AC44("waveCounter", level.var_A980);
  var_00 lib_0547::func_AC44("maxRepairReward", level.var_6093);
  var_00 lib_0547::func_AC4D();
}

func_47B7() {
  var_00 = undefined;
  var_01 = maps\mp\_utility::func_4571();
  switch (var_01) {
    case "mp_zombie_lab":
      var_00 = "DLC1_";
      break;

    case "mp_zombie_brg":
      var_00 = "DLC2_";
      break;

    case "mp_zombie_ark":
      var_00 = "DLC3_";
      break;

    default:
      break;
  }

  switch (level.var_A980) {
    case 10:
      var_00 = var_00 + "ZOMBIE_ROUND10";
      break;

    case 25:
      if(var_01 == "mp_zombie_lab") {
        var_00 = var_00 + "ZOMBIE_ROUND30";
        break;
      } else if(var_01 == "mp_zombie_brg") {
        var_00 = var_00 + "ZOMBIE_ROUND25";
        break;
      } else {
        return;
      }
      break;

    case 30:
      if(var_01 == "mp_zombie_ark") {
        var_00 = var_00 + "ZOMBIE_ROUND30";
      } else {
        return;
      }
      break;

    default:
      break;
  }

  func_47A8(var_00);
}

applyhealthcap(param_00, param_01) {
  var_02 = param_01.var_4C07;
  if(!isDefined(var_02)) {
    return;
  }

  if(param_00 > var_02) {
    param_00 = var_02;
  }

  return param_00;
}

getzombietotalhealthscale(param_00, param_01) {
  var_02 = param_00.var_4C12;
  if(!isDefined(var_02)) {
    return 1;
  }

  var_03 = param_01 - 1;
  if(var_03 <= 0) {
    return var_02;
  }

  var_04 = param_00.per_extra_player_health_scale;
  if(!isDefined(var_04)) {
    return var_02;
  }

  var_02 = var_02 * 1 + var_03 * var_04;
  return var_02;
}

func_1E59(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = lib_0547::func_0A51("zombie_generic");
  }

  if(isDefined(param_00.overridehealth)) {
    return int(param_00.overridehealth);
  }

  if(!isDefined(param_01)) {
    param_01 = level.var_A980;
  }

  if(isDefined(level.wave_health_offset)) {
    param_01 = param_01 + level.wave_health_offset;
  }

  if(!isDefined(level.wave_healths)) {
    level.wave_healths = [];
  }

  var_02 = level.wave_healths[param_01];
  if(!isDefined(var_02)) {
    var_03 = 150;
    var_04 = 100;
    var_05 = 0.08;
    for(var_06 = 2; var_06 <= param_01; var_06++) {
      if(var_06 >= 10) {
        var_07 = var_03;
        var_03 = var_03 + int(var_03 * var_05);
        if(var_03 < var_07) {
          var_03 = var_07;
          break;
        }

        continue;
      }

      var_03 = int(var_03 + var_04);
    }

    var_02 = var_03;
    level.wave_healths[param_01] = var_02;
  }

  var_08 = 0;
  if(isDefined(level.var_744A)) {
    var_08 = level.var_744A.size;
  }

  var_09 = getzombietotalhealthscale(param_00, var_08);
  var_0A = var_02 * var_09;
  if(var_09 < 1 || var_0A > var_02) {
    var_02 = var_0A;
  }

  var_02 = applyhealthcap(var_02, param_00);
  return int(var_02);
}

func_7FC6(param_00) {
  var_01 = 0;
  level thread func_4ACF();
  level endon("zombies_skip_round_intermission");
  if(param_00 < 5) {
    level notify("zombie_round_countdown_started");
    var_01 = 1;
  }

  while(param_00 > 0) {
    while(lib_0547::func_585E()) {
      wait 0.05;
    }

    setomnvar("ui_zm_round_countdown", param_00);
    param_00--;
    wait(1);
    if(!var_01 && param_00 < 5) {
      level notify("zombie_round_countdown_started");
      var_01 = 1;
    }
  }

  level notify("zombie_round_countdown_ended");
  func_7F14();
}

func_7F14() {
  setomnvar("ui_zm_round_countdown", 0);
}

func_4ACF() {
  level endon("zombie_round_countdown_ended");
  level waittill("zombies_skip_round_intermission");
  func_7F14();
}

splashdoublexp() {
  foreach(var_01 in level.var_744A) {
    if(!isDefined(var_01.var_012C["hasSeenDoubleXPSplashes"]) || !var_01.var_012C["hasSeenDoubleXPSplashes"]) {
      if(isDefined(level.zmxpscale) && level.zmxpscale > 1) {
        var_01 thread maps\mp\gametypes\_hud_message::func_9102("double_rank_xp_zm");
      }

      var_01.var_012C["hasSeenDoubleXPSplashes"] = 1;
    }
  }
}

func_7FC8(param_00) {
  splashdoublexp();
  if(common_scripts\utility::func_562E(level.iszombiesshotgun)) {
    if(isDefined(level.zmb_sg_round_start_func)) {
      level.var_7F2A = [[level.zmb_sg_round_start_func]]();
    } else {
      level.var_7F2A = "normal";
    }
  } else {
    level.var_7F24 = level.var_7F24 - 1;
    if(level.var_7F24 == 0) {
      level.var_7F2A = "zombie_dog";
      thread func_31F6();
    } else {
      level.var_7F2A = "normal";
    }
  }

  if(isDefined(level.var_7F22[level.var_7F2A])) {
    [[level.var_7F22[level.var_7F2A]]]();
  }

  if(isDefined(level.roundstartfuncgeneric)) {
    [[level.roundstartfuncgeneric]]();
  }

  level.var_7F23 = maps\mp\gametypes\_gamelogic::func_44F8();
  setomnvar("ui_zm_round_start", level.var_7F23 * 1000);
  if(isDefined(level.zmb_round_over_override)) {
    [[level.zmb_round_over_override]](param_00);
  } else {
    setomnvar("ui_zm_round_number", int(min(param_00, 9999)));
  }

  setomnvar("ui_zm_round_type", lib_0547::func_466A(level.var_7F2A));
  lib_0554::func_20CB("round_" + level.var_7F2A);
  level lib_0547::func_7B34(param_00 - 1);
}

get_round_complete_notify(param_00) {
  return "round" + param_00 + "complete";
}

func_7FC7() {
  while(lib_0547::func_585E()) {
    wait 0.05;
  }

  level notify("round complete");
  level notify(get_round_complete_notify(level.var_A980));
  thread lib_0554::func_20CB("round_end");
  thread lib_0554::func_20CB("round_intermission");
  level thread func_7E57();
  foreach(var_01 in level.var_744A) {
    var_01.var_7D10 = 0;
  }

  if(common_scripts\utility::func_562E(level.iszombiesshotgun)) {
    if(isDefined(level.zmb_sg_round_end_func)) {
      [[level.zmb_sg_round_end_func]](level.var_7F2A);
    }
  }

  if(isDefined(level.roundendfuncgeneric)) {
    [[level.roundendfuncgeneric]]();
  }

  if(isDefined(level.var_7F18[level.var_7F2A])) {
    [[level.var_7F18[level.var_7F2A]]]();
  }

  lib_0586::func_478A();
  level lib_0547::func_7B33(level.var_A980 - 1);
  var_03 = level.var_A980;
  if(level.var_A980 > 20) {
    var_03 = 21;
  }

  var_04 = "round" + var_03;
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23(var_04);
  }

  var_07 = 20;
  if(isDefined(level.var_7F1B)) {
    var_07 = level.var_7F1B;
  }

  thread func_7FC6(var_07);
  level endon("zombies_skip_round_intermission");
  wait(var_07);
}

func_7E57() {
  foreach(var_01 in level.var_744A) {
    func_7E56(var_01);
  }
}

func_7E56(param_00) {
  if(param_00.var_0178 == "spectator" || param_00.var_0178 == "dead") {
    var_01 = "ui_zm_character_" + param_00.characterclientindex + "_alive";
    setomnvar(var_01, 1);
    param_00 thread lib_0553::func_7E59();
  } else if(lib_0547::func_577E(param_00)) {
    param_00 notify("revive_trigger");
  }

  if(lib_0547::func_577D(param_00)) {
    param_00 notify("cured", 0);
  }
}

func_6FC8(param_00) {
  if(!common_scripts\utility::func_562E(level.var_6FC8)) {
    return;
  }

  var_01 = maps\mp\gametypes\_gamelogic::func_44F8();
  var_02 = var_01 - int(getomnvar("ui_zm_round_start") / 1000);
}

func_6FD1(param_00, param_01, param_02, param_03) {
  var_04 = common_scripts\utility::func_562E(param_03) && level.var_2958 == level.var_60A9;
  var_05 = lib_0547::func_AC4B(param_00, "pickupspawn");
  var_05 lib_0547::func_AC48("pickup_name", param_01);
  var_05 lib_0547::func_AC48("pickup_reason", param_02);
  var_05 lib_0547::func_AC42("pickup_last_in_round", var_04);
  var_05 lib_0547::func_AC4A();
  var_05 lib_0547::func_AC4D();
}

func_20B0(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.var_1F4F)) {
    return;
  }

  if(isDefined(level.var_1F4F[level.var_7F2A]) && ![[level.var_1F4F[level.var_7F2A]]](param_00)) {
    var_04 = 0;
    if(!var_04) {
      return;
    }
  }

  if(level.var_2958 >= level.var_60A9) {
    return;
  }

  if(isDefined(level.var_1F71)) {
    if(![[level.var_1F71]](param_00, param_01, param_02, param_03)) {
      return 0;
    }
  }

  if(isDefined(param_02) && param_02 == "MOD_SUICIDE") {
    return;
  }

  if(common_scripts\utility::func_562E(param_01.var_5A3D)) {
    return;
  }

  if(common_scripts\utility::func_562E(param_01.var_6734)) {
    return;
  }

  if(isDefined(param_03) && lib_0547::func_580B(param_03)) {
    return;
  }

  if(isDefined(level.var_6733) && level.var_6733 == 1) {
    return;
  }

  if(isDefined(level.var_AC80) && !lib_055A::func_578A(param_01.var_0116, 1)) {
    return;
  }

  if(!common_scripts\utility::func_562E(param_01.var_4BA0)) {
    return;
  }

  level endon("game_ended");
  var_05 = randomint(100);
  var_06 = "none";
  if(var_05 > level.var_6F4A) {
    if(!level.var_34AA) {
      return;
    }

    var_06 = "score";
  } else {
    var_06 = "random";
  }

  var_07 = func_3B9B(param_01.var_0116);
  if(!isDefined(var_07)) {
    return;
  }

  if(var_06 == "score") {
    level.var_34AA = 0;
  }

  var_08 = common_scripts\utility::func_98E7(level.var_34AA, "true ", "false ");
  var_09 = common_scripts\utility::func_98E7(var_05 > level.var_6F4A, "false ", "true ");
  var_0A = "Scheduled: " + var_08 + "Chance: " + var_09 + "(" + var_05 + "<=" + level.var_6F4A + ")";
  var_0B = func_83B5();
  func_281C(var_0B, var_07, var_0A, 1, 1);
  level.var_2958++;
  param_01.var_349E = 1;
}

func_3B9B(param_00) {
  var_01 = 80;
  var_02 = var_01 * var_01;
  var_03 = -25536;
  setdvarifuninitialized("debugPickupDrop", 0);
  level notify("findValidPickupSpot");
  var_04 = [];
  var_05 = [];
  var_06 = [];
  foreach(var_08 in level.var_744A) {
    if(maps\mp\_utility::func_57A0(var_08)) {
      var_09 = distance2dsquared(param_00, var_08.var_0116);
      if(var_09 < var_02) {
        var_04[var_04.size] = var_08;
      }

      if(var_09 < var_03) {
        var_05[var_05.size] = var_08;
      }

      var_06[var_06.size] = var_08;
    }
  }

  if(var_04.size == 0) {
    return param_00;
  }

  var_0B = common_scripts\utility::func_A2BE();
  foreach(var_08 in var_05) {
    var_0B = var_0B + var_08.var_0116;
  }

  var_0B = var_0B / var_05.size;
  var_0B = (var_0B[0], var_0B[1], param_00[2]);
  var_0E = var_0B - param_00;
  var_0F = length(var_0E);
  var_10 = var_0E * -1 * var_01 / var_0F;
  var_11 = getclosestpointonnavmesh(param_00 + var_10);
  if(func_991E(var_11, var_05, var_02, param_00)) {
    return var_11;
  }

  var_12 = param_00;
  if(!navtrace(param_00, var_11)) {
    var_12 = var_11;
  }

  var_13 = getrandomnavpoints(var_12, 140, 16);
  foreach(var_15 in var_13) {
    if(func_991E(var_15, var_06, var_02)) {
      return var_15;
    }
  }

  return undefined;
}

func_991E(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  foreach(var_06 in param_01) {
    if(distance2dsquared(var_06.var_0116, param_00) < param_02) {
      var_04 = 0;
      break;
    }
  }

  if(!isDefined(var_04) && !isDefined(param_03)) {
    var_04 = 1;
  }

  if(!isDefined(var_04)) {
    var_04 = !navtrace(param_03, param_00);
  }

  return var_04;
}

func_281D(param_00, param_01, param_02) {
  if(isDefined(level.var_AC80) && lib_055A::func_578A(param_01 + (0, 0, 1))) {
    func_281C(param_00, param_01, param_02);
    return;
  }

  var_03 = common_scripts\utility::func_7A33(level.var_744A);
  [[level.var_6FBF[param_00]["func"]]](var_03);
}

func_281C(param_00, param_01, param_02, param_03, param_04) {
  if(common_scripts\utility::func_562E(param_04)) {
    level.var_6FD0 = param_00;
  }

  if(!isDefined(param_02)) {
    param_02 = "<undefined>";
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  func_6FC8(param_00 + " Dropped - " + param_02);

  func_6FD1(param_01, param_00, param_02, param_04);

  var_05[0] = func_4608();
  var_06 = level.var_6FBF[param_00]["fx"];
  var_07 = level.var_6FBF[param_00]["model"];
  if(isDefined(var_06)) {
    var_05[0] setModel("dlc_dogtags_zombie_invisible");
  } else {
    var_05[0] setModel(var_07);
  }

  if(common_scripts\utility::func_562E(level.var_6FBF[param_00]["outline"])) {
    var_05[0] hudoutlineenable(0, 0);
  }

  var_08 = var_05[0].var_9D65;
  var_09 = maps\mp\gametypes\_gameobjects::func_2837(level.var_746E, var_08, var_05, (0, 0, 16), 1);
  var_0A = (0, 0, 22);
  if(isDefined(level.var_6FBF[param_00]["posOffset"])) {
    var_0A = level.var_6FBF[param_00]["posOffset"];
  }

  var_0B = param_01 + var_0A;
  var_09.var_6FCE = param_00;
  var_09.var_28D4 = var_0B;
  var_09.var_9D65.var_0116 = var_0B;
  var_09.var_A582[0].var_0116 = var_0B;
  var_09.var_0116 = var_0B;
  var_0C = level.var_6FBF[param_00]["icon"];
  if(isDefined(var_0C) && var_0C != "") {
    var_09.var_4FF6 = var_08 maps\mp\_entityheadicons::func_869E(level.var_746E, var_0C, (0, 0, 30), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);
  }

  var_09 maps\mp\gametypes\_gameobjects::func_8A5A(0);
  lib_0380::func_2889("zmb_pickup_spawn_strt", undefined, var_09.var_0116);
  var_09.var_8CFF = lib_0380::func_2889("zmb_pickup_spawn_lp", undefined, var_09.var_0116);
  var_09 thread func_2CE9();
  var_09.var_6BBF = level.var_6FBF[param_00]["func"];
  if(isDefined(var_06)) {
    var_0A = (0, 0, 0);
    if(isDefined(level.var_6FBF[param_00]["posOffset"])) {
      var_0A = level.var_6FBF[param_00]["posOffset"];
    }

    var_09.var_A582[0] scriptmodelplayanim("s2_zmb_holo_icon_spin");
    var_09.var_A582[0].var_0116 = param_01 + var_0A;
    var_09.var_3F2F = common_scripts\utility::func_44F5(var_06);
    var_09.var_3F81 = "j_dogtag";
    playFXOnTag(var_09.var_3F2F, var_09.var_A582[0], var_09.var_3F81);
    playFXOnTag(level.var_0611["pickup_base"], var_09.var_A582[0], var_09.var_3F81);
  } else {
    var_0D = (0, 0, 2000);
    var_0E = 2000;
    var_0F = 0.1;
    var_10 = level.var_6FBF[param_00]["phys_overrides"];
    if(isDefined(var_10)) {
      if(isDefined(var_10.var_6F9A)) {
        var_0D = var_10.var_6F9A;
      }

      if(isDefined(var_10.var_6F9C)) {
        var_0E = var_10.var_6F9C;
      }

      if(isDefined(var_10.var_6F9B)) {
        var_0F = var_10.var_6F9B;
      }
    }

    var_09.var_A582[0] method_84E0();
    var_09.var_A582[0] method_80B0(var_09.var_A582[0].var_6A55);
    var_09.var_A582[0] physicslaunchserver(var_09.var_A582[0].var_0116, var_0D, var_0E, var_0F);
    var_09 thread func_6FD9();
  }

  checkforuiproc("specialty_class_resourceful_zm");
  if(param_03) {
    var_09 thread func_6FD7();
  }

  return var_09;
}

checkforuiproc(param_00) {
  if(isDefined(level.var_744A)) {
    foreach(var_02 in level.var_744A) {
      if(var_02 lib_0547::func_4BA7(param_00)) {
        var_02 luinotifyeventextraplayer(&"trigger_mod_proc", 1, param_00);
      }
    }
  }
}

func_2CE9() {
  var_00 = level.var_6FBF[self.var_6FCE]["delayPickUp"];
  if(common_scripts\utility::func_562E(var_00)) {
    maps\mp\gametypes\_gameobjects::func_0C30("none");
    wait(1);
  }

  maps\mp\gametypes\_gameobjects::func_0C30("friendly");
}

func_6FD9() {
  self endon("deleted");
  var_00 = self.var_9D65;
  var_01 = self.var_A582[0];
  while(isDefined(var_01)) {
    var_00.var_0116 = var_01.var_0116;
    wait 0.05;
  }
}

func_6FC6() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  var_00 = self;
  var_01 = self.var_28D4;
  var_02 = self.var_28D4 + (0, 0, 12);
  var_03 = 1.25;
  if(isDefined(self.var_A582) && isDefined(self.var_A582[0])) {
    var_00 = self.var_A582[0];
  }

  for(;;) {
    var_00 moveto(var_02, var_03, 0.15, 0.15);
    var_00 rotateyaw(180, var_03);
    wait(var_03);
    var_00 moveto(var_01, var_03, 0.15, 0.15);
    var_00 rotateyaw(180, var_03);
    wait(var_03);
  }
}

func_6FD7() {
  self endon("deleted");
  wait 0.05;
  var_00 = 15;
  var_01 = 0;
  var_02 = 0.1;
  while(var_01 < var_00) {
    wait(var_02);
    var_01 = var_01 + var_02;
    if(isDefined(self.var_6FD4)) {
      var_00 = self.var_6FD4;
    }
  }

  var_03 = level.var_6FBF[self.var_6FCE]["extraTimeoutSecs"];
  if(isDefined(var_03)) {
    wait(var_03);
  }

  thread func_6FD5();
  thread func_6FCA(self.var_28D4);
  var_00 = 8;
  var_01 = 0;
  var_02 = 0.1;
  while(var_01 < var_00) {
    wait(var_02);
    var_01 = var_01 + var_02;
    if(isDefined(self.var_6FCB)) {
      var_00 = self.var_6FCB;
    }
  }

  playsoundatpos(self.var_28D4, "zmb_pickup_expired");
  level thread func_7CED(self);
}

func_6FCA(param_00) {
  var_01 = playclientsound("zmb_pickup_timer", undefined, self.var_28D4);
  self waittill("deleted");
  stopclientsound(var_01, 0.05);
}

func_6FD5() {
  self endon("deleted");
  for(;;) {
    if(isDefined(self.var_3F2F)) {
      killfxontag(self.var_3F2F, self.var_A582[0], self.var_3F81);
    } else if(isDefined(self.var_A582) && isDefined(self.var_A582[0])) {
      self.var_A582[0] method_8511();
    }

    wait(0.25);
    if(isDefined(self.var_3F2F)) {
      playFXOnTag(self.var_3F2F, self.var_A582[0], self.var_3F81);
    } else if(isDefined(self.var_A582) && isDefined(self.var_A582[0])) {
      self.var_A582[0] method_805B();
    }

    wait(0.25);
  }
}

func_7CED(param_00) {
  var_01 = level.var_6FBF[param_00.var_6FCE]["onDestroyed"];
  if(isDefined(var_01)) {
    param_00[[var_01]]();
  }

  if(!isDefined(param_00.var_A582)) {
    return;
  }

  lib_0380::func_2893(param_00.var_8CFF, 0.25);
  lib_0380::func_2889("zmb_pickup_spawn_end", undefined, param_00.var_0116);
  param_00 notify("deleted");
  param_00.var_A582[0] method_805B();
  param_00.var_A582[0] method_8511();
  if(isDefined(param_00.var_3F2F)) {
    stopFXOnTag(param_00.var_3F2F, param_00.var_A582[0], param_00.var_3F81);
    stopFXOnTag(level.var_0611["pickup_base"], param_00.var_A582[0], param_00.var_3F81);
  }

  param_00.var_A582[0] method_84E0();
  param_00.var_A582[0] method_80B1();
  param_00.var_9D65.var_0116 = param_00.var_9D65.var_0116 - (0, 0, -10000);
  lib_0547::func_A6F6();
  param_00.var_A582[0].var_54F5 = 0;
}

func_0DB9(param_00, param_01) {
  extra_report_powerup_collected(param_00, param_01);
  func_8C1C("zombie_max_ammo");
  param_00 method_8615("zmb_pickup_general");
  level thread func_08AE();
  param_00.var_7F08 = param_00.var_7F08 + 1;
  if(!isDefined(param_01)) {
    level thread func_7CED(self);
  }
}

func_08AE() {
  level notify("maxAmmoPickup");
  foreach(var_01 in level.var_744A) {
    if(lib_0547::func_5767(var_01) && maps\mp\_utility::func_57A0(var_01)) {
      func_7B83(var_01);
      var_01 func_7456();
      if(isDefined(level.var_08AF)) {
        var_01[[level.var_08AF]]();
      }
    }
  }
}

func_7B83(param_00) {
  var_01 = param_00 getweaponslistprimaries();
  var_01[var_01.size] = param_00 method_834A();
  foreach(var_03 in var_01) {
    if(var_03 == "none") {
      continue;
    }

    if(lib_0547::func_57AF(var_03) || lib_0547::func_5862(var_03) || lib_0547::iszombieconsumableweapon(var_03)) {
      continue;
    }

    if(level.weaponmaxammofuncs.size > 0) {
      var_04 = getweapondisplayname(var_03);
      if(isDefined(level.weaponmaxammofuncs[var_04])) {
        var_05 = param_00[[level.weaponmaxammofuncs[var_04]]](var_03);
        if(var_05) {
          continue;
        }
      }
    }

    if(lib_0547::func_585C(var_03)) {
      maps\mp\zombies\_zombies_magicbox::func_3AC1(param_00, var_03);
      continue;
    }

    var_06 = param_00 getcurrentweaponclipammo();
    param_00 givemaxammo(var_03);
    if(var_06 == 0) {
      wait(0.01);
      while(param_00 isreloading()) {
        wait 0.05;
      }

      param_00 givemaxammo(var_03);
    } else {
      maps\mp\zombies\_zombies_magicbox::func_3AC1(param_00, var_03);
    }

    if(issubstr(var_03, "dlcgun1")) {
      var_07 = weaponclipsize(var_03);
      param_00 method_82FA(var_03, var_07, "right");
    }
  }

  var_09 = param_00 method_831F();
  var_03 = var_09;
  if(var_09 == "none") {
    if(common_scripts\utility::func_562E(param_00.var_4B73)) {
      var_03 = "jack_in_box_decoy_zm";
    }
  }

  if(var_03 != "none") {
    var_05 = 0;
    if(level.weaponmaxammofuncs.size > 0) {
      if(isDefined(level.weaponmaxammofuncs[var_03])) {
        var_05 = param_00[[level.weaponmaxammofuncs[var_03]]](var_03);
      }
    }

    if(!var_05) {
      param_00 method_831E(var_03);
      param_00 lib_0586::func_078C(var_03);
      maps\mp\zombies\_zombies_magicbox::func_3AC1(param_00, var_03);
    }
  }

  if(lib_0547::func_577E(param_00)) {
    param_00 lib_0553::func_7B86();
  }
}

func_53DD(param_00, param_01) {
  extra_report_powerup_collected(param_00, param_01);
  func_8C1C("zombie_insta_kill");
  param_00 method_8615("zmb_pickup_overdrive");
  level thread func_08AC();
  param_00.var_7F07 = param_00.var_7F07 + 1;
  if(!isDefined(param_01)) {
    level thread func_7CED(self);
  }
}

func_7B8F() {
  var_00 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_02 in var_00) {
    if(isalive(var_02)) {
      var_02 lib_054D::func_A135();
    }
  }
}

func_08AC() {
  level notify("instaKillPickup");
  level endon("game_ended");
  level endon("instaKillPickup");
  maps\mp\_utility::func_3FA4("insta_kill");
  func_7B8F();
  func_329C("ui_zm_instakill", level.var_53DE);
  maps\mp\_utility::func_3FA1("insta_kill");
  func_7B8F();
}

func_32C8(param_00, param_01) {
  extra_report_powerup_collected(param_00, param_01);
  func_8C1C("zombie_double_points");
  param_00 method_8615("zmb_pickup_general");
  level thread func_08AA();
  param_00.var_7F04 = param_00.var_7F04 + 1;
  if(!isDefined(param_01)) {
    level thread func_7CED(self);
  }
}

func_08AA() {
  level notify("doublePointsPickup");
  level endon("game_ended");
  level endon("doublePointsPickup");
  maps\mp\_utility::func_3FA4("double_points");
  func_329C("ui_zm_doublepoints", level.var_32C9);
  maps\mp\_utility::func_3FA1("double_points");
}

func_3C1A(param_00) {
  func_8C1C("zombie_fire_sale");
  param_00 method_8615("zmb_pickup_general");
  level thread func_08AB();
  level thread func_7CED(self);
}

func_08AB() {
  level notify("fireSalePickup");
  level endon("game_ended");
  level endon("fireSalePickup");
  if(!maps\mp\_utility::func_3FA0("fire_sale")) {
    maps\mp\_utility::func_3FA4("fire_sale");
    foreach(var_01 in level.var_5F74) {
      level thread func_9ED2(var_01);
    }
  }

  func_329C("ui_zm_firesale", level.var_3C1C);
  maps\mp\_utility::func_3FA1("fire_sale");
  foreach(var_01 in level.var_5F74) {
    level thread func_9ECB(var_01);
  }
}

func_9ED2(param_00) {
  while(param_00.var_56C7) {
    wait 0.05;
  }

  if(param_00.var_08BE) {
    maps\mp\zombies\_zombies_magicbox::func_08D7(param_00);
  }

  if(!param_00.var_08BE) {
    level thread maps\mp\zombies\_zombies_magicbox::func_A922(param_00, 1);
    return;
  }

  if(param_00.var_5759) {
    while(param_00.var_5759) {
      wait 0.05;
    }

    level thread maps\mp\zombies\_zombies_magicbox::func_A922(param_00, 1);
  }
}

func_9ECB(param_00) {
  while(param_00.var_56C7) {
    wait 0.05;
  }

  if(!param_00.var_08BE) {
    param_00 notify("fireSaleOver");
    return;
  }

  maps\mp\zombies\_zombies_magicbox::func_08D7(param_00);
}

func_685F(param_00, param_01) {
  extra_report_powerup_collected(param_00, param_01);
  func_8C1C("zombie_nuke");
  earthquake(0.35, 0.95, param_00.var_0116, 128);
  playFX(common_scripts\utility::func_44F5("nuke_blast"), param_00.var_0116, anglesToForward(param_00.var_001D), anglestoup(param_00.var_001D));
  param_00 method_8615("zmb_pickup_apocalypse");
  level thread func_08B2(param_00.var_0116);
  param_00.var_7F0B = param_00.var_7F0B + 1;
  if(!isDefined(param_01)) {
    level thread func_7CED(self);
  }
}

func_08B2(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 func_47AE("nuke");
  }

  if(!common_scripts\utility::func_562E(param_01)) {
    param_01 = 0;
  }

  wait(0.2);
  var_05 = maps\mp\agents\_agent_utility::func_43FD("all");
  var_05 = function_01AC(var_05, param_00);
  foreach(var_07 in var_05) {
    if(var_07.var_000A == level.var_746E) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_07.longdeath)) {
      continue;
    }

    if(!param_01) {
      if(var_07 lib_0547::func_53DC()) {
        if(common_scripts\utility::func_562E(var_07.var_57E8)) {
          continue;
        }

        if(!common_scripts\utility::func_562E(var_07.var_561D)) {
          var_07 thread lib_0547::func_7D1A("nuke_stun", [param_00]);
          continue;
        }
      }
    }

    wait(0.1);
    if(isalive(var_07)) {
      var_08 = "MOD_EXPLOSIVE";
      if(!function_02BF(var_07)) {
        var_08 = "MOD_ENERGY";
      }

      var_07.var_5A3D = 1;
      var_07 dodamage(var_07.var_00BC, var_07.var_0116, undefined, undefined, var_08, level.var_69A6);
    }
  }
}

func_6865(param_00) {
  if(common_scripts\utility::func_562E(self.var_57E8)) {
    return;
  }

  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "nuke_stun");
  if(!maps\mp\agents\humanoid\_humanoid_util::func_56BC()) {
    var_01 = undefined;
    self.var_55C9 = 1;
    var_02 = maps\mp\agents\humanoid\_humanoid_util::func_29CB(param_00);
    var_03 = angleclamp180(var_02 - self.var_001D[1]);
    if(abs(var_03) < 45) {
      var_01 = "pain_knockback_front";
    } else if(abs(var_03) > 135) {
      var_01 = "pain_knockback_back";
    } else if(var_03 > 0) {
      var_01 = "pain_knockback_right";
    } else {
      var_01 = "pain_knockback_left";
    }

    var_04 = maps\mp\agents\_scripted_agent_anim_util::func_434D(var_01);
    var_05 = self method_83DB(var_04);
    var_06 = randomint(var_05);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_04, var_06, 1, "stun_anim");
    self method_839A(1, 1);
  }

  if(self.var_0A4B == "zombie_fireman") {
    var_04 = maps\mp\agents\_scripted_agent_anim_util::func_434D("scripted_fire_scream");
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_04, 0, 1, "stun_anim");
  }

  if(common_scripts\utility::func_562E(self.var_561D)) {
    self waittill("stunning_burst_end");
  }

  self notify("nuke_stun_end");
  func_AC34();
}

func_6863() {
  wait(5);
  if(common_scripts\utility::func_562E(self.var_561D)) {
    self waittill("stunning_burst_end");
  }

  self notify("nuke_stun_end");
}

func_AC33() {
  self endon("death");
  self endon("nuke_stun_end");
  var_00 = maps\mp\agents\_scripted_agent_anim_util::func_434D("stun_hold");
  var_01 = self method_83DB(var_00);
  for(;;) {
    var_02 = randomint(var_01);
    self method_839C("anim deltas");
    self scragentsetorientmode("face angle abs", self.var_001D);
    maps\mp\agents\_scripted_agent_anim_util::func_71FA(var_00, var_02, 1, "stun_anim");
    if(self.var_0A4B == "zombie_fireman") {
      break;
    }
  }
}

func_6864(param_00) {
  func_AC34();
}

func_AC34() {
  self endon("death");
  if(isalive(self)) {
    self.var_55C9 = 0;
    self scragentsetscripted(0);
    maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "nuke_stun");
  }
}

func_0840(param_00, param_01) {
  extra_report_powerup_collected(param_00, param_01);
  func_8C1C("zombie_ability_fill");
  param_00 method_8615("zmb_pickup_general");
  level thread maps\mp\zombies\_zombies_roles::func_4789();
  param_00.var_7F0D = param_00.var_7F0D + 1;
  if(!isDefined(param_01)) {
    level thread func_7CED(self);
  }
}

func_329C(param_00, param_01) {
  var_02 = 30;
  if(isDefined(param_01)) {
    var_02 = param_01;
  }

  setomnvar(param_00, gettime() + var_02 * 1000);
  wait(var_02);
  var_03 = maps\mp\zombies\_zombies_perks::func_0633();
  if(isDefined(var_03) && var_03 > 0) {
    setomnvar(param_00, gettime() + var_03 * 1000);
    wait(var_03);
  }
}

func_8C1C(param_00) {
  foreach(var_02 in level.var_744A) {
    if(lib_0547::func_5767(var_02) && maps\mp\_utility::func_57A0(var_02)) {
      var_02 thread maps\mp\gametypes\_hud_message::func_9102(param_00);
    }
  }
}

func_AC6F() {
  if(isDefined(level.var_AC6F)) {
    var_00 = newhudelem();
    var_00.var_01D3 = 0;
    var_00.var_01D7 = 0;
    var_00.var_0018 = 1;
    var_00.var_00C6 = "fullscreen";
    var_00.var_01CA = "fullscreen";
    var_00.var_0184 = 3;
    var_00 setshader(level.var_AC6F, 640, 480);
  }
}

func_742C() {
  self endon("disconnect");
  self setclientomnvar("ui_energy_ammo", 1);
  for(;;) {
    self waittill("weapon_change", var_00);
    wait 0.05;
  }
}

func_73D8(param_00) {
  self endon("disconnect");
  if(!issubstr(param_00, "iw5_em1zm_mp")) {
    if(lib_0547::func_73F7() && lib_0547::func_73EA() <= 0 && !func_73F6() && !lib_0547::func_577E(self)) {
      lib_0547::func_73C6();
    }

    return;
  }

  func_7455();
  self setweaponammostock(param_00, 0);
  thread func_7459();
  self waittill("weapon_change");
  self method_812B(1);
  self notifyonplayercommandremove("fire_em1_weapon", "+attack");
  self notifyonplayercommandremove("fire_em1_weapon", "+attack_akimbo_accessible");
}

func_73F6() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(issubstr(var_02, "iw5_em1zm_mp")) {
      return 1;
    }
  }

  return 0;
}

func_7481() {
  var_00 = func_44B1(1);
  var_01 = lib_0547::func_73EA();
  var_02 = var_01 / var_00;
  self setclientomnvar("ui_energy_ammo", var_02);
}

func_7459() {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  self notifyonplayercommand("fire_em1_weapon", "+attack");
  self notifyonplayercommand("fire_em1_weapon", "+attack_akimbo_accessible");
  var_00 = lib_0547::func_73EA();
  func_7481();
  if(var_00 <= 0) {
    self method_812B(0);
  }

  for(;;) {
    if(!self attackButtonPressed()) {
      self waittill("fire_em1_weapon");
    }

    var_01 = self getcurrentweapon();
    if(self method_833B() || !issubstr(var_01, "iw5_em1zm_mp") || !self method_8127() || self method_84DE()) {
      wait 0.05;
      continue;
    }

    var_00 = lib_0547::func_73EA();
    func_7481();
    if(var_00 <= 0) {
      var_02 = self getweaponslistprimaries();
      var_03 = maps\mp\_utility::func_4431(var_02[0]);
      if(var_03 != "iw5_em1zm") {
        self method_812B(0);
        lib_0586::func_078E(var_02[0]);
        wait 0.05;
        continue;
      }

      if(var_02.size > 1) {
        var_03 = maps\mp\_utility::func_4431(var_02[1]);
        if(var_03 != "iw5_em1zm") {
          lib_0586::func_078E(var_02[1]);
          self method_812B(0);
          wait 0.05;
          continue;
        }
      }

      self method_812B(0);
      wait 0.05;
      continue;
    }

    wait 0.05;
    if(maps\mp\_utility::func_3FA2("unlimited_ammo") && maps\mp\_utility::func_3FA0("unlimited_ammo")) {
      continue;
    }

    var_00 = lib_0547::func_73EA();
    lib_0547::func_743F(var_00 - 1);
  }
}

func_7455() {
  if(!isDefined(self.var_012C["em1Ammo"])) {
    self.var_012C["em1Ammo"] = spawnStruct();
    func_7456();
    self method_812B(1);
  }
}

func_44B1(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = 1;
  if(!param_00 && self hasperk("specialty_stockpile", 1)) {
    var_01 = var_01 * 1.2;
  }

  return 1800 * var_01;
}

func_7456() {
  if(isDefined(self.var_012C["em1Ammo"])) {
    var_00 = func_44B1();
    self.var_012C["em1Ammo"].var_0D95 = var_00;
    func_7481();
    self method_812B(1);
  }
}

func_7437() {
  self notify("postSlamDeathWaiter");
  self endon("postSlamDeathWaiter");
  self endon("postSlamTimedOut");
  self waittill("death");
  func_7439();
}

func_7439() {
  maps\mp\_utility::func_73AF(1, "postSlam");
}

func_7438() {
  self notify("postSlamDisableBoost");
  self endon("postSlamDisableBoost");
  self endon("death");
  self endon("disconnect");
  var_00 = 2;
  var_01 = gettime() + var_00 * 1000;
  maps\mp\_utility::func_73AF(0, "postSlam");
  thread func_7437();
  wait(var_00);
  self notify("postSlamTimedOut");
  func_7439();
}

func_7428() {
  self endon("disconnect");
  self.var_390A = 0;
  self.var_3908 = 0;
  self.var_390C = 0;
  self.var_3909 = 0;
  self.var_390D = 0;
  for(;;) {
    var_00 = common_scripts\utility::func_A716("exo_boost", "ground_slam", "exo_dodge", "exo_slide");
    self.var_390A = gettime();
    switch (var_00) {
      case "exo_boost":
        self.var_3908 = gettime();
        break;

      case "ground_slam":
        self.var_390C = gettime();
        break;

      case "exo_dodge":
        self.var_3909 = gettime();
        break;

      case "exo_slide":
        self.var_390D = gettime();
        break;
    }
  }
}

func_47A8(param_00, param_01, param_02) {
  if(isDefined(param_01)) {
    var_03 = [param_01];
  } else {
    var_03 = level.var_744A;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  foreach(param_01 in var_03) {
    if(common_scripts\utility::func_562E(param_02) && !isDefined(param_01.joinedearlyrounds) || !param_01.joinedearlyrounds) {
      continue;
    }

    param_01 func_47C8(param_00);
  }
}

func_47C8(param_00) {
  if(!isDefined(self.alreadyloggedfirstpartytrophy)) {
    self.alreadyloggedfirstpartytrophy = [];
  }

  if(!isDefined(self.alreadyloggedfirstpartytrophy[param_00])) {
    self.alreadyloggedfirstpartytrophy[param_00] = 1;
    self dlogevent("telemetry_trophy_event", ["trophy", ["trophy_name", param_00, "level_time_ms", gettime()]]);
  }

  self giveachievement(param_00);
}

func_1E54() {
  var_00 = 1;
  if(isDefined(level.var_7544)) {
    level.var_7543 = level.var_7544;
  } else if(level.var_A980 <= 9) {
    level.var_7543 = var_00;
  } else {
    var_01 = level.var_A980 - 9;
  }

  level.var_7541["damage_body"] = int(10 * level.var_7543);
  level.var_7541["damage_head"] = int(10 * level.var_7543);
  level.var_7541["kill_trap"] = int(10 * level.var_7543);
  level.var_7541["kill_limb"] = int(50 * level.var_7543);
  level.var_7541["kill_streak"] = int(40 * level.var_7543);
  level.var_7541["kill_body"] = int(60 * level.var_7543);
  level.var_7541["kill_head"] = int(100 * level.var_7543);
  level.var_7541["kill_melee"] = int(130 * level.var_7543);
  level.var_7541["kill_reward_trap"] = int(60 * level.var_7543);
  level.var_7541["power_on"] = int(100 * level.var_7543);
  level.var_7541["atm"] = int(100 * level.var_7543);
  level.var_7541["atm_jackpot"] = int(10 * level.var_7543);
  level.var_7541["cure"] = int(100 * level.var_7543);
  level.var_7541["crate"] = int(500 * level.var_7543);
  level.var_7541["nuke"] = int(400 * level.var_7543);
  level.var_7541["reward_bronze"] = int(500 * level.var_7543);
  level.var_7541["reward_silver"] = int(1000 * level.var_7543);
  level.var_7541["reward_gold"] = int(2000 * level.var_7543);
  level.var_7541["breach_fix"] = int(200 * level.var_7543);
  level.var_7541["repair"] = int(10 * level.var_7543);
  level.var_7541["perfectRound"] = int(100 * level.var_7543);
  level.var_7541["mercReward"] = int(5 * level.var_7543);
  level.var_7541["damage_over_time"] = int(5 * level.var_7543);
}

func_7429() {}

func_31F6() {
  level waittill("round complete");
  func_0DB9(level.var_744A[0], 1);
  foreach(var_01 in level.var_744A) {
    if(!common_scripts\utility::func_562E(var_01.var_4DCB)) {
      if(!isDefined(var_01.var_4DCB)) {
        var_01.var_4DCB = 0;
      }

      if(!isDefined(var_01.var_31AB)) {
        var_01.var_31AB = 1;
      } else {
        var_01.var_31AB++;
      }

      if(var_01.var_31AB >= 3 && maps\mp\_utility::func_4571() == "mp_zombie_nest_01") {
        var_01 func_47C8("ZM_KNUCKLE");
      }

      continue;
    }

    var_01.var_4DCB = 0;
    var_01.var_31AB = 0;
  }

  level.var_7F24 = 5;
}

func_AC54(param_00, param_01) {
  level.var_3B5C = undefined;
  var_02 = getdvarint("1316", 0) == 1;
  if(isDefined(level.var_8C7C)) {
    var_02 = level.var_8C7C;
  }

  if(!var_02) {
    foreach(var_04 in level.var_744A) {
      if(isDefined(var_04.var_2583) || var_04.var_012C["team"] == "spectator" && !var_04 method_8436()) {
        continue;
      }

      var_04 thread maps\mp\gametypes\_hud_message::func_985C(param_00, 0, param_01, 1);
    }
  }

  level notify("game_win", param_00);
  maps\mp\gametypes\_gamelogic::func_A792();
  level notify("give_match_bonus");
  maps\mp\gametypes\_gamelogic::func_A792();
  if(!var_02 && func_746B()) {
    if(!isDefined(level.var_7DD2)) {
      level.var_7DD2 = 1;
    }

    game["gamestarted"] = undefined;
  }

  if(maps\mp\_utility::iszombiegameshattermode()) {
    wait(8);
  }

  wait(8);
  foreach(var_04 in level.var_744A) {
    var_04 setclientomnvar("ui_round_end", 0);
  }
}

func_746B() {
  var_00 = undefined;
  if(!getdvarint("zombiesAllowVoteToRestart", 0)) {
    var_00 = 0;
  }

  if(isDefined(var_00) && getDvar("1673") == "mp_zombie_training") {
    if(isDefined(level.var_7DD2)) {
      var_00 = level.var_7DD2;
    } else {
      var_00 = 1;
    }
  }

  if(isDefined(var_00)) {
    wait(6);
    return var_00;
  }

  var_01 = 10;
  wait(4);
  foreach(var_03 in level.var_744A) {
    var_03.hacky_vote_ui = newclienthudelem(var_03);
    var_03.hacky_vote_ui.var_01D3 = 0;
    var_03.hacky_vote_ui.var_01D7 = 150;
    var_03.hacky_vote_ui.var_0010 = "center";
    var_03.hacky_vote_ui.var_0011 = "middle";
    var_03.hacky_vote_ui.var_00C6 = "center";
    var_03.hacky_vote_ui.var_01CA = "middle";
    var_03.hacky_vote_ui.var_009B = 1.3;
    var_03.hacky_vote_ui.var_0018 = 1;
    var_03.hacky_vote_ui.var_0184 = 99999;
    var_03.hacky_vote_ui.var_00A0 = 1;
    var_03.hacky_vote_ui settext(&"ZOMBIES_PRESS_TO_PLAY_AGAIN");
  }

  var_05 = [];
  var_06 = 0;
  while(var_06 < var_01) {
    foreach(var_03 in level.var_744A) {
      if(isDefined(var_03) && var_03 useButtonPressed()) {
        var_05[var_03 getguid()] = 1;
      }
    }

    var_09 = 0;
    foreach(var_03 in level.var_744A) {
      if(isDefined(var_03) && isDefined(var_05[var_03 getguid()])) {
        var_09++;
        if(level.var_744A.size > 1) {
          var_03.hacky_vote_ui settext(&"ZOMBIES_WAITING_FOR_OTHER_PLAYERS");
        }

        continue;
      }
    }

    if(var_09 == level.var_744A.size) {
      foreach(var_03 in level.var_744A) {
        if(isDefined(var_03) && isDefined(var_03.hacky_vote_ui)) {
          var_03.hacky_vote_ui settext(&"ZOMBIES_RESTARTING");
        }
      }

      return 1;
    }

    wait 0.05;
    var_06 = var_06 + 0.05;
  }

  foreach(var_03 in level.var_744A) {
    if(isDefined(var_03)) {
      var_03.hacky_vote_ui settext(&"ZOMBIES_GOING_TO_LOBBY");
    }
  }

  return 0;
}

func_AC55(param_00, param_01, param_02, param_03) {}

func_446E() {
  var_00 = self getrankedplayerdata(common_scripts\utility::func_46A8(), "selectedLoadout", "ability");
  setmatchdata("players", self.var_2418, "loadout", "special", var_00);
  var_01 = maps\mp\_utility::func_452B(var_00);
  if(!lib_0547::func_5823(var_01)) {
    var_01 = "role_ability_stunning_burst_zm";
  }

  return var_01;
}

func_061B() {
  var_00 = self getentitynumber();
  return var_00 < 256 || var_00 > 2045;
}

func_ABF6() {
  if(!lib_0547::func_AC4C()) {
    return;
  }

  var_00 = 1024;
  var_01 = 1790;
  var_02 = 5;
  while(!isDefined(level.var_947C)) {
    wait 0.05;
  }

  var_03 = 0;
  var_04 = var_00;
  var_05 = 0;
  var_06 = var_01;
  var_07 = gettime() + var_02 / 2 * 20;
  while(!common_scripts\utility::func_562E(level.var_3F9D)) {
    wait 0.05;
    if(gettime() - var_07 >= var_02 * 1000) {
      var_07 = gettime();
    } else {
      continue;
    }

    var_08 = 0;
    var_09 = 0;
    var_0A = getEntArray();
    for(var_0B = 0; var_0B < var_0A.size; var_0B++) {
      if(var_0A[var_0B] method_85CC()) {
        var_08++;
      }

      if(!var_0A[var_0B] func_061B()) {
        var_09++;
      }
    }

    if(var_08 > var_03) {
      var_03 = var_08;
    }

    if(var_08 < var_04) {
      var_04 = var_08;
    }

    if(var_09 > var_05) {
      var_05 = var_09;
    }

    if(var_09 < var_06) {
      var_06 = var_09;
    }

    wait 0.05;
    var_0C = lib_0547::func_AC4B(undefined, "snapshot_ents");
    var_0C lib_0547::func_AC44("count", var_08);
    var_0C lib_0547::func_AC44("count_high_water_mark", var_03);
    var_0C lib_0547::func_AC44("count_low_water_mark", var_04);
    var_0C lib_0547::func_AC44("server_count", var_09);
    var_0C lib_0547::func_AC44("server_count_high_water_mark", var_05);
    var_0C lib_0547::func_AC44("server_count_low_water_mark", var_06);
    var_0C lib_0547::func_AC4D();
  }

  var_0C = lib_0547::func_AC4B(undefined, "snapshot_ent_stats");
  var_0C lib_0547::func_AC44("count_high_water_mark", var_03);
  var_0C lib_0547::func_AC44("count_low_water_mark", var_04);
  var_0C lib_0547::func_AC44("server_count_high_water_mark", var_05);
  var_0C lib_0547::func_AC44("server_count_low_water_mark", var_06);
  var_0C lib_0547::func_AC4D();
}

func_73CD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(lib_0547::func_AC4C()) {
    var_0B = undefined;
    var_0C = undefined;
    var_0D = undefined;
    var_0E = undefined;
    if(isDefined(param_01)) {
      var_0B = param_01.var_0A4B;
      var_0C = param_01.var_0116;
      var_0D = acos(clamp(vectordot(anglesToForward(param_02.var_001D), vectornormalize(common_scripts\utility::func_3D5D(param_01.var_0116 - param_02.var_0116))), -1, 1));
    }

    var_0F = param_02 getvelocity();
    var_10 = length(var_0F);
    var_11 = param_02 getnormalizedmovement();
    var_12 = length(var_11) > 0.5 && var_10 < 5;
    var_13 = undefined;
    if(isDefined(param_00)) {
      var_13 = param_00.var_0116;
    }

    var_14 = lib_0547::func_AC4B(param_02.var_0116, "player_damaged");
    var_14 lib_0547::func_AC47(param_02);
    var_14 lib_0547::func_AC49("player_angles", param_02.var_001D);
    var_14 lib_0547::func_AC48("hit_loc", param_09);
    var_14 lib_0547::func_AC48("attacker_type", var_0B);
    var_14 lib_0547::func_AC49("attacker_pos", var_13);
    var_14 lib_0547::func_AC44("damage", param_03);
    var_14 lib_0547::func_AC48("weapon", param_06);
    var_14 lib_0547::func_AC48("damage_type", param_05);
    var_14 lib_0547::func_AC43("angle_to_attacker", var_0D);
    var_14 lib_0547::func_AC42("blocked", var_12);
    var_14 lib_0547::func_AC43("player_speed", var_10);
    var_14 lib_0547::func_AC49("player_stick_input", var_11);
    var_14 lib_0547::func_AC42("player_sprinting", param_02 issprinting());
    var_14 lib_0547::func_AC42("player_reloading", param_02 isreloading());
    var_14 lib_0547::func_AC48("player_weapon", param_02 getcurrentweapon());
    var_14 lib_0547::func_AC4D();
  }
}

func_7272() {
  var_00 = 10;
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(randomfloat(var_00));
  for(;;) {
    var_01 = 0;
    if(lib_0547::func_AC4C()) {
      var_02 = 0;
      var_03 = 0;
      var_04 = 0;
      var_05 = 0;
      var_06 = 0;
      var_07 = 0;
      var_08 = 0;
      foreach(var_0A in maps\mp\agents\_agent_utility::func_43FD("all")) {
        if(isalive(var_0A)) {
          var_0B = distance(self.var_0116, var_0A.var_0116);
          var_02++;
          var_05 = var_05 + var_0B;
          var_08 = var_08 + length(var_0A getvelocity());
          if(lib_054D::func_7230(var_0A)) {
            var_03++;
            var_06 = var_06 + var_0B;
          }

          if(isDefined(var_0A.var_0088) && var_0A.var_0088 == self) {
            var_04++;
            var_07 = var_07 + var_0B;
          }
        }

        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      var_05 = var_05 / max(1, var_02);
      var_06 = var_06 / max(1, var_03);
      var_07 = var_07 / max(1, var_04);
      var_08 = var_08 / max(1, var_02);
      var_0D = 0;
      var_0E = 0;
      var_0F = 0;
      foreach(var_11 in level.var_744A) {
        if(var_11 != self) {
          var_12 = distance(self.var_0116, var_11.var_0116);
          var_0E = var_0E + var_12;
          if(lib_054D::func_7230(var_11)) {
            var_0D++;
            var_0F = var_0F + var_12;
          }
        }
      }

      var_0E = var_0E / max(1, level.var_744A.size - 1);
      var_0F = var_0F / max(1, level.var_744A.size - 1);
      var_01 = var_01 + 0.05;
      wait 0.05;
      var_14 = lib_0547::func_AC4B(self.var_0116, "player_experience");
      var_14 lib_0547::func_AC44("zombie_count", var_02);
      var_14 lib_0547::func_AC44("visible_zombie_count", var_03);
      var_14 lib_0547::func_AC44("attacking_zombie_count", var_04);
      var_14 lib_0547::func_AC43("average_distance_to_zombie", var_05);
      var_14 lib_0547::func_AC43("average_distance_to_visible_zombie", var_06);
      var_14 lib_0547::func_AC43("average_distance_to_attacking_zombie", var_07);
      var_14 lib_0547::func_AC42("last_stand", lib_0547::func_577E(self));
      var_14 lib_0547::func_AC42("spectating", lib_0547::func_57E1(self));
      var_14 lib_0547::func_AC44("player_count", lib_0547::func_45C9());
      var_14 lib_0547::func_AC42("player_sprinting", self issprinting());
      var_14 lib_0547::func_AC42("player_reloading", self isreloading());
      var_14 lib_0547::func_AC48("player_weapon", self getcurrentweapon());
      var_14 lib_0547::func_AC44("visible_player_count", var_0D);
      var_14 lib_0547::func_AC43("average_distance_to_player", var_0E);
      var_14 lib_0547::func_AC43("average_distance_to_visible_player", var_0F);
      var_14 lib_0547::func_AC43("average_zombie_speed", var_08);
      var_14 lib_0547::func_AC43("player_speed", length(self getvelocity()));
      var_14 lib_0547::func_AC4D();
    }

    wait(max(0.5, var_00 - var_01));
  }
}

func_4AE1() {
  var_00 = 585;
  var_01 = 0.5;
  self endon("death");
  self endon("disconnect");
  for(;;) {
    foreach(var_03 in level.var_744A) {
      if(var_03 == self) {
        continue;
      }

      var_04 = distance(var_03.var_0116, self.var_0116) > var_00;
      var_05 = var_04 && !sighttracepassed(var_03 getEye(), self getEye(), 0, undefined);
      if(var_05) {
        var_06 = 0;
        if(lib_0547::func_577E(var_03)) {
          var_06 = 1;
        }

        var_03 hudoutlineenableforclient(self, var_06, 0);
        continue;
      }

      var_03 hudoutlinedisableforclient(self);
    }

    wait(var_01);
  }
}

setomnvartodefault(param_00, param_01) {
  if(param_01 != getomnvar(param_00)) {
    setomnvar(param_00, param_01);
  }
}

setclientomnvartodefault(param_00, param_01) {
  if(param_01 != self getclientomnvar(param_00)) {
    self setclientomnvar(param_00, param_01);
  }
}

resetomnvars() {
  setomnvartodefault("ui_current_round", 1);
  setomnvartodefault("ui_last_round", 0);
  setomnvartodefault("ui_game_duration", 0);
  setomnvartodefault("ui_game_victor", 0);
  setomnvartodefault("ui_bomb_a_state", 0);
  setomnvartodefault("ui_bomb_b_state", 0);
  setomnvartodefault("ui_bomb_a_timer_endtime", 0);
  setomnvartodefault("ui_bomb_b_timer_endtime", 0);
  setomnvartodefault("ui_nuke_end_milliseconds", 0);
  setomnvartodefault("ui_match_countdown", 0);
  setomnvartodefault("ui_match_countdown_title", 0);
  setomnvartodefault("ui_match_countdown_toggle", 0);
  setomnvartodefault("ui_assault_objective_update", 0);
  setomnvartodefault("ui_assault_objective_complete", 0);
  setomnvartodefault("lighting_state", 0);
  setomnvartodefault("ui_alive_player_count_allies", 0);
  setomnvartodefault("ui_alive_player_count_axis", 0);
  setomnvartodefault("ui_attacking_team", 0);
  setomnvartodefault("ui_cg_world_blur", 0);
  setomnvartodefault("ui_cg_world_blur_fade_out", 0);
  setomnvartodefault("ui_zm_characterClient_0", -1);
  setomnvartodefault("ui_zm_characterClient_1", -1);
  setomnvartodefault("ui_zm_characterClient_2", -1);
  setomnvartodefault("ui_zm_characterClient_3", -1);
  setomnvartodefault("ui_zm_character_0", -1);
  setomnvartodefault("ui_zm_character_1", -1);
  setomnvartodefault("ui_zm_character_2", -1);
  setomnvartodefault("ui_zm_character_3", -1);
  setomnvartodefault("ui_zm_instakill", 0);
  setomnvartodefault("ui_zm_doublepoints", 0);
  setomnvartodefault("ui_zm_flamethrower", 0);
  setomnvartodefault("ui_zm_bazooka", 0);
  setomnvartodefault("ui_zm_panzerschreck", 0);
  setomnvartodefault("ui_zm_firesale", 0);
  setomnvartodefault("ui_zm_overcharge", 0);
  setomnvartodefault("ui_zm_infinite_ammo", 0);
  setomnvartodefault("ui_zm_powerdown", 0);
  setomnvartodefault("ui_zm_intermission_swaptime_1", 0);
  setomnvartodefault("ui_zm_intermission_swaptime_2", 0);
  setomnvartodefault("ui_zm_round_countdown", 0);
  setomnvartodefault("ui_zm_round_number", 0);
  setomnvartodefault("ui_zm_round_type", 0);
  setomnvartodefault("ui_zm_round_start", 0);
  setomnvartodefault("ui_zm_ee_player_index", -1);
  setomnvartodefault("ui_zm_ee_int2", 0);
  setomnvartodefault("ui_zm_ee_bool", 0);
  setomnvartodefault("ui_zm_character_0_alive", -1);
  setomnvartodefault("ui_zm_character_1_alive", -1);
  setomnvartodefault("ui_zm_character_2_alive", -1);
  setomnvartodefault("ui_zm_character_3_alive", -1);
  setomnvartodefault("ui_zm_character_0_bleedout_endtime", 0);
  setomnvartodefault("ui_zm_character_1_bleedout_endtime", 0);
  setomnvartodefault("ui_zm_character_2_bleedout_endtime", 0);
  setomnvartodefault("ui_zm_character_3_bleedout_endtime", 0);
  setomnvartodefault("ui_zm_player_0_zone_name", "unknown");
  setomnvartodefault("ui_zm_player_1_zone_name", "unknown");
  setomnvartodefault("ui_zm_player_2_zone_name", "unknown");
  setomnvartodefault("ui_zm_player_3_zone_name", "unknown");
  setomnvartodefault("ui_hud_vendor_interact_distance", 600);
  setomnvartodefault("ui_hub_1v1_timer", 0);
  setomnvartodefault("ui_zm_last_alive_prompt", 0);
  setomnvartodefault("ui_zm_points_0", 0);
  setomnvartodefault("ui_zm_points_1", 0);
  setomnvartodefault("ui_zm_points_2", 0);
  setomnvartodefault("ui_zm_points_3", 0);
  setomnvartodefault("ui_zm_waypoint_ents_type", 0);
  setomnvartodefault("ui_zm_waypoint_ent_a", 0);
  setomnvartodefault("ui_zm_waypoint_float_a", 0);
  setomnvartodefault("ui_zm_waypoint_ent_b", 0);
  setomnvartodefault("ui_zm_waypoint_float_b", 0);
  setomnvartodefault("ui_zm_blitz_0", 0);
  setomnvartodefault("ui_zm_blitz_1", 0);
  setomnvartodefault("ui_zm_blitz_2", 0);
  setomnvartodefault("ui_zm_blitz_3", 0);
  setomnvartodefault("ui_zm_gamemode_mod", 0);
  setomnvartodefault("ui_zm_rs_active", 0);
}

resetclientomnvars(param_00) {
  param_00 setclientomnvartodefault("damage_feedback", "none");
  param_00 setclientomnvartodefault("send_map_load_phase", -1);
  param_00 setclientomnvartodefault("ui_minimap_location_callout", -1);
  param_00 setclientomnvartodefault("ui_minimap_antiair_state", 0);
  param_00 setclientomnvartodefault("ui_killcam_end_milliseconds", 0);
  param_00 setclientomnvartodefault("ui_killcam_killedby_id", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_killstreak", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_weapon", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_attachment1", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_attachment2", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_attachment3", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_attachment4", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_1", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_2", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_3", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_4", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_5", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_6", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_7", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_8", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_perk_9", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_division", -1);
  param_00 setclientomnvartodefault("ui_killcam_killedby_weaponReputation", 0);
  param_00 setclientomnvartodefault("ui_killcam_drawTargetBox", 0);
  param_00 setclientomnvartodefault("ui_killcam_paratrooperInsert", 0);
  param_00 setclientomnvartodefault("ui_killcam_copycat", 0);
  param_00 setclientomnvartodefault("ui_killcam_type", 0);
  param_00 setclientomnvartodefault("ui_killcam_action", 0);
  param_00 setclientomnvartodefault("ui_killcam_time_until_spawn", 0);
  param_00 setclientomnvartodefault("ui_killcam_isNemesis", 0);
  param_00 setclientomnvartodefault("ui_killcam_isFriendlyFire", 0);
  param_00 setclientomnvartodefault("ui_killcam_killsOfPlayer", 0);
  param_00 setclientomnvartodefault("ui_killcam_killsByPlayer", 0);
  param_00 setclientomnvartodefault("ui_death_details_attacker_0", -1);
  param_00 setclientomnvartodefault("ui_death_details_attacker_1", -1);
  param_00 setclientomnvartodefault("ui_death_details_attacker_2", -1);
  param_00 setclientomnvartodefault("ui_death_details_attacker_3", -1);
  param_00 setclientomnvartodefault("ui_death_details_hits_0", 0);
  param_00 setclientomnvartodefault("ui_death_details_hits_1", 0);
  param_00 setclientomnvartodefault("ui_death_details_hits_2", 0);
  param_00 setclientomnvartodefault("ui_death_details_hits_3", 0);
  param_00 setclientomnvartodefault("cam_scene_name", "unknown");
  param_00 setclientomnvartodefault("cam_scene_lead", -1);
  param_00 setclientomnvartodefault("cam_scene_support", -1);
  param_00 setclientomnvartodefault("cam_scene_lead_alt", -1);
  param_00 setclientomnvartodefault("cam_scene_support_alt", -1);
  param_00 setclientomnvartodefault("ui_splash_idx", -1);
  param_00 setclientomnvartodefault("ui_splash_killstreak_idx", -1);
  param_00 setclientomnvartodefault("ui_splash_playercard_idx", -1);
  param_00 setclientomnvartodefault("ui_splash_playercard_clientnum", -1);
  param_00 setclientomnvartodefault("ui_splash_playercard_optional_number", 0);
  param_00 setclientomnvartodefault("ui_carrying_bomb", 0);
  param_00 setclientomnvartodefault("ui_capture_icon", 0);
  param_00 setclientomnvartodefault("ui_capture_status_index", 0);
  param_00 setclientomnvartodefault("ui_capture_progress", 0);
  param_00 setclientomnvartodefault("ui_securing", 0);
  param_00 setclientomnvartodefault("ui_securing_progress", 0);
  param_00 setclientomnvartodefault("ui_light_armor", 0);
  param_00 setclientomnvartodefault("ui_session_state", "none");
  param_00 setclientomnvartodefault("ks_used", 0);
  param_00 setclientomnvartodefault("ks_acquired", 0);
  param_00 setclientomnvartodefault("ks_count1", 0);
  param_00 setclientomnvartodefault("ks_points1", 0);
  param_00 setclientomnvartodefault("ks_count2", 0);
  param_00 setclientomnvartodefault("ks_points2", 0);
  param_00 setclientomnvartodefault("ks_count3", 0);
  param_00 setclientomnvartodefault("ks_points3", 0);
  param_00 setclientomnvartodefault("ks_count4", 0);
  param_00 setclientomnvartodefault("ks_points4", 0);
  param_00 setclientomnvartodefault("ks_count_updated", 0);
  param_00 setclientomnvartodefault("ks_selectedIndex", 0);
  param_00 setclientomnvartodefault("ks_hasStreak", 0);
  param_00 setclientomnvartodefault("ks_icon0", 0);
  param_00 setclientomnvartodefault("ks_icon1", 0);
  param_00 setclientomnvartodefault("ks_icon2", 0);
  param_00 setclientomnvartodefault("ks_icon3", 0);
  param_00 setclientomnvartodefault("ks_icon4", 0);
  param_00 setclientomnvartodefault("ui_killstreak_remote", 0);
  param_00 setclientomnvartodefault("ui_hud_shake", 0);
  param_00 setclientomnvartodefault("ui_hud_static", 0);
  param_00 setclientomnvartodefault("ui_options_menu", 0);
  param_00 setclientomnvartodefault("ui_loadout_selected", -1);
  param_00 setclientomnvartodefault("ui_team_selected", -1);
  param_00 setclientomnvartodefault("ui_spectator_selected", -1);
  param_00 setclientomnvartodefault("blur_target", 0);
  param_00 setclientomnvartodefault("blur_duration_ms", 0);
  param_00 setclientomnvartodefault("ui_round_end", 0);
  param_00 setclientomnvartodefault("ui_round_end_title", 0);
  param_00 setclientomnvartodefault("ui_round_end_reason", 0);
  param_00 setclientomnvartodefault("ui_round_end_friendly_score", 0);
  param_00 setclientomnvartodefault("ui_round_end_enemy_score", 0);
  param_00 setclientomnvartodefault("ui_round_end_match_bonus", 0);
  param_00 setclientomnvartodefault("ui_rank_splash_prestige", 0);
  param_00 setclientomnvartodefault("ui_challenge_splash_idx", -1);
  param_00 setclientomnvartodefault("ui_challenge_splash_tier", 0);
  param_00 setclientomnvartodefault("ui_assault_rank_bar_progress", 0);
  param_00 setclientomnvartodefault("ui_hide_hints_hud", 0);
  param_00 setclientomnvartodefault("ui_hide_hud", 0);
  param_00 setclientomnvartodefault("ui_points_popup", -1);
  param_00 setclientomnvartodefault("ui_points_popup_event", -1);
  param_00 setclientomnvartodefault("allow_write_leaderboards", 1);
  param_00 setclientomnvartodefault("ui_use_bar_text", 0);
  param_00 setclientomnvartodefault("ui_use_bar_start_time", 0);
  param_00 setclientomnvartodefault("ui_use_bar_current_time", 0);
  param_00 setclientomnvartodefault("ui_use_bar_end_time", 0);
  param_00 setclientomnvartodefault("ui_streak_overlay_state", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_state", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_timer", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_damage", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_hits", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_distance", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_fired", 0);
  param_00 setclientomnvartodefault("ui_vlobby_round_accuracy", 0);
  param_00 setclientomnvartodefault("ui_ctf_friendly_status", 0);
  param_00 setclientomnvartodefault("ui_ctf_friendly_carrier_clientnum", -1);
  param_00 setclientomnvartodefault("ui_ctf_enemy_status", 0);
  param_00 setclientomnvartodefault("ui_ctf_enemy_carrier_clientnum", -1);
  param_00 setclientomnvartodefault("ui_ctf_status_changed", 0);
  param_00 setclientomnvartodefault("ui_light_armor_percent", 0);
  param_00 setclientomnvartodefault("ui_energy_ammo", 1);
  param_00 setclientomnvartodefault("ui_round_end_stopwatch", 0);
  param_00 setclientomnvartodefault("fov_scale", 1);
  param_00 setclientomnvartodefault("ui_disable_team_change", 0);
  param_00 setclientomnvartodefault("ui_killstreak_blackout", 0);
  param_00 setclientomnvartodefault("ui_killstreak_blackout_fade_end", 0);
  param_00 setclientomnvartodefault("ui_splash_killstreak_slot_idx", -1);
  param_00 setclientomnvartodefault("ui_zm_exo_health", 0);
  param_00 setclientomnvartodefault("ui_zm_exo_slam", 0);
  param_00 setclientomnvartodefault("ui_zm_exo_slam_next_time", 0);
  param_00 setclientomnvartodefault("ui_zm_camo", 0);
  param_00 setclientomnvartodefault("ui_zm_award_points", 0);
  param_00 setclientomnvartodefault("ui_zm_ee_int", 0);
  param_00 setclientomnvartodefault("ui_zm_ee_bool2", 0);
  param_00 setclientomnvartodefault("ui_zm_hud_static", 0);
  param_00 setclientomnvartodefault("ui_zm_perk_order", 0);
  param_00 setclientomnvartodefault("ui_zm_previous_zone_name", "unknown");
  param_00 setclientomnvartodefault("ui_zm_current_zone_name", "unknown");
  param_00 setclientomnvartodefault("ui_zm_quest_hint_0", 0);
  param_00 setclientomnvartodefault("ui_zm_quest_hint_1", 0);
  param_00 setclientomnvartodefault("ui_zm_quest_hint_2", 0);
  param_00 setclientomnvartodefault("ui_zm_step_hint_0", 0);
  param_00 setclientomnvartodefault("ui_zm_step_hint_1", 0);
  param_00 setclientomnvartodefault("ui_zm_step_hint_2", 0);
  param_00 setclientomnvartodefault("ui_zm_has_quest_item_bits_0", 0);
  param_00 setclientomnvartodefault("ui_zm_has_quest_item_bits_1", 0);
  param_00 setclientomnvartodefault("ks_selectedIndex", 0);
  param_00 setclientomnvartodefault("ui_energy_ammo", 1);
  param_00 setclientomnvartodefault("ui_zm_token_count", 0);
  param_00 setclientomnvartodefault("ui_zm_free_role_use", 0);
  param_00 setclientomnvartodefault("zm_unlimited_ammo", 0);
  param_00 setclientomnvartodefault("ui_zm_juggernog", -1);
  param_00 setclientomnvartodefault("ui_zm_fastreload", -1);
  param_00 setclientomnvartodefault("ui_zm_punchperk", -1);
  param_00 setclientomnvartodefault("ui_zm_runperk", -1);
  param_00 setclientomnvartodefault("ui_zm_quickrevive", -1);
  param_00 setclientomnvartodefault("ui_zm_electriccherry", -1);
  param_00 setclientomnvartodefault("ui_zm_doubletap", -1);
  param_00 setclientomnvartodefault("ui_hub_enable_pause", 1);
  param_00 setclientomnvartodefault("ui_show_scorestreak_training_hud", 0);
  param_00 setclientomnvartodefault("ui_show_supply_drop_selection", 0);
  param_00 setclientomnvartodefault("ui_show_hub_leaderboard", 0);
  param_00 setclientomnvartodefault("ui_onevone_show_class_menu", 0);
  param_00 setclientomnvartodefault("ui_onevone_class_1", 0);
  param_00 setclientomnvartodefault("ui_onevone_class_2", 0);
  param_00 setclientomnvartodefault("ui_onevone_class_3", 0);
  param_00 setclientomnvartodefault("ui_onevone_class_4", 0);
  param_00 setclientomnvartodefault("ui_onevone_class_5", 0);
  param_00 setclientomnvartodefault("ui_onevone_opponent_client_num", 0);
  param_00 setclientomnvartodefault("ui_hide_1v1scores", 1);
  param_00 setclientomnvartodefault("ui_show_skip_killcam", 0);
  param_00 setclientomnvartodefault("ui_hide_minimap", 0);
  param_00 setclientomnvartodefault("ui_hide_hud", 0);
  param_00 setclientomnvartodefault("ui_daily_challenge_idx", -1);
  param_00 setclientomnvartodefault("char_scene_state", 0);
  param_00 setclientomnvartodefault("ui_zm_free_ability", 0);
  param_00 setclientomnvartodefault("ui_zm_consumable_count0", 0);
  param_00 setclientomnvartodefault("ui_zm_consumable_count1", 0);
  param_00 setclientomnvartodefault("ui_zm_consumable_ref0", -1);
  param_00 setclientomnvartodefault("ui_zm_consumable_ref1", -1);
  param_00 setclientomnvartodefault("ui_zm_hud_vis_bits", 0);
  param_00 setclientomnvartodefault("ui_damage_flash", 0);
  param_00 setclientomnvartodefault("ui_fullscreen_dirt_left", 0);
  param_00 setclientomnvartodefault("ui_hub_1v1_queueposition", 0);
  param_00 setclientomnvartodefault("ui_vl_monitor_started", 0);
  param_00 setclientomnvartodefault("ui_hub_shootout_opponent_client_num", 0);
  param_00 setclientomnvartodefault("ui_hub_shootout_intro_countdown", 0);
  param_00 setclientomnvartodefault("ui_hub_in_1v1", 0);
  param_00 setclientomnvartodefault("ui_party_manipulation_enabled", 1);
  param_00 setclientomnvartodefault("ui_hub_in_theater", 0);
  param_00 setclientomnvartodefault("ui_hub_in_firingrange", 0);
  param_00 setclientomnvartodefault("ui_hub_opening_supplydrop", 0);
  param_00 setclientomnvartodefault("ui_hub_in_shootout", 0);
  param_00 setclientomnvartodefault("ui_hub_in_flakgun", 0);
  param_00 setclientomnvartodefault("ui_hub_at_vendor", 0);
  param_00 setclientomnvartodefault("ui_player_splash_id_0", -1);
  param_00 setclientomnvartodefault("ui_player_splash_id_1", -1);
  param_00 setclientomnvartodefault("ui_player_splash_id_2", -1);
  param_00 setclientomnvartodefault("ui_player_splash_id_3", -1);
  param_00 setclientomnvartodefault("ui_player_splash_id_4", -1);
  param_00 setclientomnvartodefault("ui_player_splash_id_5", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_0", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_1", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_2", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_3", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_4", -1);
  param_00 setclientomnvartodefault("ui_player_splash_param_5", -1);
  param_00 setclientomnvartodefault("ui_zm_contexthint_data", 0);
  param_00 setclientomnvartodefault("ui_zm_interaction_flags", 0);
  param_00 setclientomnvartodefault("ui_zm_interaction_data", 0);
  param_00 setclientomnvartodefault("ui_show_division_rifle_ability_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_division_smg_ability_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_division_lmg_ability_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_division_shotgun_ability_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_division_sniper_ability_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_m30_rifle_altmode_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_zk383_smg_altmode_prompt", 0);
  param_00 setclientomnvartodefault("ui_show_left_clip_ammo", 0);
  param_00 setclientomnvartodefault("ui_dragon_breath_state", 1);
  param_00 setclientomnvartodefault("ui_suppressor_state", -1);
  param_00 setclientomnvartodefault("ui_m30_rifle_state", -1);
  param_00 setclientomnvartodefault("ui_zk383_smg_state", -1);
  param_00 setclientomnvartodefault("ui_zm_can_use_consumable", 1);
  param_00 setclientomnvartodefault("ui_zm_selected_quest_item", -1);
  param_00 setclientomnvartodefault("ui_zm_owns_quest_items", 0);
  param_00 setclientomnvartodefault("ui_hub_fte_character_select", 0);
  param_00 setclientomnvartodefault("ui_show_fte_division_select", 0);
  param_00 setclientomnvartodefault("ui_fte_welcome_message_status", 0);
  param_00 setclientomnvartodefault("ui_fte_tutorial_completed", 0);
  param_00 setclientomnvartodefault("zm_blitz_items_limit", 4);
  param_00 setclientomnvartodefault("ui_hub_is_preoccupied", 0);
  param_00 setclientomnvartodefault("hub_fte_reset_intro", 0);
}

nocontrolduringcinematic() {
  self endon("disconnect");
  self endon("death");
  self freezecontrols(1);
  self method_812B(0);
  self method_8324();
  self method_84CB();
  while(player_is_playing_loading_cinematic()) {
    wait 0.05;
  }

  self freezecontrols(0);
  self method_812B(1);
  self method_8325();
  self method_84CC();
}

map_has_loading_cinematic() {
  switch (getDvar("1673")) {
    case "mp_zombie_house":
    case "mp_zombie_nest_01":
      return 0;

    case "mp_zombie_training":
    case "mp_zombie_island":
      return 1;
  }

  return maps\mp\_utility::func_585F();
}

monitor_loading_cinematic_state() {
  self endon("disconnect");
  self.last_known_loading_cinematic_state = map_has_loading_cinematic();
  self.last_known_loading_cinematic_state_time = gettime();
  childthread send_loading_cinematic_state_queries();
  while(self.last_known_loading_cinematic_state) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "loading_cinematic_reply") {
      continue;
    }

    if(!var_01 && self.last_known_loading_cinematic_state) {
      function_0292(self);
    }

    self.last_known_loading_cinematic_state = var_01;
    self.last_known_loading_cinematic_state_time = gettime();
  }
}

send_loading_cinematic_state_queries() {
  while(self.last_known_loading_cinematic_state) {
    self luinotifyevent(&"loading_cinematic_query");
    wait(0.2);
  }
}

player_is_playing_loading_cinematic() {
  if(!isDefined(self.last_known_loading_cinematic_state)) {
    return map_has_loading_cinematic();
  }

  if(gettime() - self.last_known_loading_cinematic_state_time > 10000) {
    return 0;
  }

  return self.last_known_loading_cinematic_state;
}

orders_and_contracts_report_event(param_00, param_01, param_02, param_03) {
  if(isDefined(level.orders_and_contracts_event_report)) {
    var_04 = get_event_reporter_struct(param_00);
    if(!isDefined(var_04)) {
      return;
    }

    if(isDefined(param_03)) {
      var_04[[var_04.var_1E61]](param_01, param_02, param_03);
      return;
    }

    if(isDefined(param_02)) {
      var_04[[var_04.var_1E61]](param_01, param_02);
      return;
    }

    if(isDefined(param_01)) {
      var_04[[var_04.var_1E61]](param_01);
      return;
    }

    var_04[[var_04.var_1E61]]();
    return;
  }
}

register_addition_revive_rule(param_00, param_01, param_02) {
  if(!isDefined(level.additional_player_revive_rules)) {
    level.additional_player_revive_rules = [param_00];
    return;
  }

  level.additional_player_revive_rules = common_scripts\utility::func_0F6F(level.additional_player_revive_rules, param_00);
}

get_event_reporter_struct(param_00) {
  return level.orders_and_contracts_event_report[param_00];
}

extra_report_powerup_collected(param_00, param_01) {
  if(isDefined(level.zmb_events_powerup_collected)) {
    [[level.zmb_events_powerup_collected]](param_00, param_01);
  }
}