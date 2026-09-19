/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\zombies.gsc
*************************************************/

main() {
  if(gettime() > 300)
    level.zombie_game_was_restarted = 1;

  resetomnvars();
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();
  _id_0541::main();
  setDvar("1936", 1);
  setDvar("2335", 1);
  setDvar("scr_dlcRoundMode", 0);
  level._id_8D62 = _id_0366::_id_8E25;

  if(_func_133()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  }

  _func_035("4696", 0);
  _func_035("5539", 2);
  _func_035("scr_zombies_timeLimit", 0);
  _func_035("scr_zombies_numLives", 1);
  _func_035("2298", 5000);
  _func_035("scr_game_matchstarttime", 0);
  _func_035("scr_game_playerwaittime", 5);
  _func_035("scr_game_playerwaittime_ds", 5);
  _func_035("scr_game_graceperiod", 5);
  _func_035("scr_game_graceperiod_ds", 5);
  _func_035("scr_player_healthregentime", 4);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  _id_872E();
  _id_054A::init();
  _id_532F();
  _id_5DE9();
  _id_0547::_id_A2A1();
  _id_0547::_id_9597();
  _id_0542::_id_5329();
  _id_0547::_id_52B0();
  _id_0547::_id_7BD0("nuke_stun", ::_id_6865, ::_id_6864, 4);
  maps\mp\_utility::_id_873B(1);
  level._id_585D = 1;
  level._id_2F85 = 1;

  if(getdvarint("scr_zombiesAlwaysDrawFriendlyNames"))
    level._id_0CB4 = 1;

  level._id_80AB = 1;
  level._id_0C25 = 1;
  level._id_8C87 = 1;
  level._id_6706 = 1;
  level._id_10EB = 1;
  level._id_5A6F = 0;
  level._id_2FAB = 1;
  level.gamehasstarted = 0;
  level.rankedmatch = 0;
  level._id_746E = "allies";
  level._id_3772 = "axis";
  _func_390("axis");
  level._id_7F1B = 20;
  level._id_268D = 5;
  level._id_5BFA = 2000;
  level._id_4867 = 0;
  level._id_7426 = 150;
  level._id_7484 = 1000;
  level._id_73E0 = 500;
  level.gametypemovespeedmaxscalar = 2.0;
  level._id_9A87 = 0;
  level._id_62B3 = [];
  level._id_29E0 = [];
  level._id_7F24 = 5;
  level.zombieweaponclass = [];
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6BA7 = ::_id_6B81;
  level._id_62AD = ::_id_62AF;
  level.callbackplayerlaststand = _id_0553::_id_1E6E;
  level.gametypemovespeedscalefunc = _id_0547::zombiesmovespeedscale;
  level.callbackplayerdamage = ::callback_playerdamage;
  level._id_6B77 = ::_id_6B77;
  level._id_1DEA = ::_id_AC20;
  level._id_6AE2 = ::_id_6AE2;
  level._id_6BB2 = ::_id_6B5C;
  level._id_A9C5 = ::_id_34B8;
  level._id_1385 = ::_id_AC53;
  level._id_A9F9 = ::_id_AC76;
  level._id_2980 = _id_054E::_id_AB3D;
  level._id_297F = _id_054E::_id_AB3C;
  level._id_2067 = _id_0547::_id_7CE5;
  level.callbackplayergrenadesuicide = ::_id_6B41;
  level._id_2FA0 = ::_id_2FA0;
  level._id_1E41 = ::_id_1E38;
  level._id_7BF5 = _id_054B::_id_7BF6;
  level._id_6B4E = _id_054A::_id_0F35;
  level._id_300C = ::_id_AC54;
  level._id_36C3 = ::_id_AC55;
  level._id_3FE0 = _id_054A::_id_A27B;
  level._id_3FDE = _id_054A::_id_536E;
  level._id_3FDD = _id_054A::_id_0F39;
  level._id_446F = ::_id_446E;
  level._id_5827 = _id_0547::_id_5863;
  level._id_5834 = _id_0547::_id_5866;
  level._id_73CD = ::_id_73CD;
  level._id_47C4 = _id_0586::_zm_give_weapon_mp_api;
  level._id_95F7 = _id_0586::_id_0790;
  level._id_A9C8 = [];
  level.resetclientomnvarcallback = ::resetclientomnvars;
  level thread maps\mp\_events_z::init();
  level._id_0788 = _id_0498::init;
  level._id_0789 = _id_0498::_id_5EB1;
  thread _id_ABF6();
}

_id_5DE9() {
  level._effect["mutant_blood_pool"] = loadfx("vfx/blood/dlc_zombie_gib_bloodpool");
  level._effect["mutant_gib_death"] = loadfx("vfx/blood/dlc_zombie_gib_burst");
  level._effect["electrical_arc"] = loadfx("vfx/test/test_fx");
  level._effect["slow_zone"] = loadfx("vfx/test/hms_mutant_ooze_impact_burst");
  level._effect["torso_arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_le");
  level._effect["torso_arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_arm_ri");
  level._effect["torso_head_loss"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_2");
  level._effect["torso_head_loss_p_melee_fdr_02"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_02");
  level._effect["torso_head_loss_p_melee_fdr_03"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_03");
  level._effect["torso_head_loss_p_melee_fdr_04"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_fdr_04");
  level._effect["zmb_paired_melee_head_pop_fdr_02"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_02");
  level._effect["zmb_paired_melee_head_pop_fdr_03"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_03");
  level._effect["zmb_paired_melee_head_pop_fdr_04"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_fdr_04");
  level._effect["torso_loss_head_p_melee_spr_01"] = loadfx("vfx/blood/dlc_zombie_torso_loss_head_p_melee_spr_01");
  level._effect["zmb_paired_melee_head_pop_spr_01"] = loadfx("vfx/blood/zmb_paired_melee_head_pop_spr_01");
  level._effect["torso_head_loss_small"] = loadfx("vfx/blood/dlc_zombie_torso_squirt_up");
  level._effect["torso_loss_left"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_le");
  level._effect["torso_loss_right"] = loadfx("vfx/blood/dlc_zombie_torso_loss_impact_ri");
  level._effect["arm_loss_left"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_le");
  level._effect["arm_loss_right"] = loadfx("vfx/blood/dlc_zombie_arm_loss_impact_ri");
  level._effect["head_gibs"] = loadfx("vfx/blood/zom_head_impact_01");
  level._effect["limb_loss_left"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_le");
  level._effect["limb_loss_right"] = loadfx("vfx/blood/dlc_zombie_limb_loss_impact_ri");
  level._effect["gib_full_body"] = loadfx("vfx/blood/dlc_zombie_gib_full_body");
  level._effect["gib_full_body_cheap"] = loadfx("vfx/blood/dlc_zombie_gib_full_body_cheap");
  level._effect["gib_bloodpool"] = loadfx("vfx/blood/dlc_zombie_blood_tread_fx");
  level._effect["crawl_dust"] = loadfx("vfx/treadfx/DLC/crawl_dust");
  level._effect["nuke_blast"] = loadfx("vfx/gameplay/mp/zombie/zombie_nuke_burst");
  level._effect["player_screen_burn"] = loadfx("vfx/fire/fire_player_impact_cam");
  level._effect["eye_zombie_generic"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla");
  level._effect["eye_zombie_berserker"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla");
  level._effect["eye_zombie_exploder"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla");
  level._effect["eye_zombie_heavy"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_vanilla");
  level._effect["pickup_nuke"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_apocalypse");
  level._effect["pickup_doublepoints"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_dble_pts");
  level._effect["pickup_base"] = loadfx("vfx/gameplay/mp/zombie/zmb_holo_icon_base");
  level._effect["pickup_instakill"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_insta_kill");
  level._effect["pickup_maxammo"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_max_ammo");
  level._effect["pickup_tombstone"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_tombstone");
  level._effect["pickup_abilityfill"] = loadfx("vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_overcharge");
  level._effect["sticky_grenade_splat"] = loadfx("vfx/weaponimpact/sticky_grenade_splat");
  level._effect["mine_launch"] = loadfx("vfx/weaponimpact/bouncing_betty_launch_dirt");
  level._effect["mine_spin"] = loadfx("vfx/dust/bouncing_betty_swirl");
  level._effect["mine_explode"] = loadfx("vfx/explosion/zmb_bouncing_betty_explosion");
  level._effect["mine_beacon_enemy"] = loadfx("vfx/lights/light_c4_blink");
  level._effect["mine_beacon_friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
  level._effect["zmb_electroschnelle_player"] = loadfx("vfx/lights/mp_zombie_nest/zmb_electroschnelle_player");
  level._effect["serrated_edge_bleed"] = loadfx("vfx/blood/zmb_death_serrated_edge_drip");
}

_id_AC76(var_0) {
  return 4;
}

_id_532F() {
  level._id_6FC9 = [];
  level._id_60A9 = _id_457B();
  level._id_6F4A = _id_4600();
  level._id_34AA = 0;
  level._id_2958 = 0;
  level._id_6FCC = [];
  level._id_6FD2 = [];
  level._id_6FD3 = 0;
  level._id_6FD0 = undefined;
  level._id_3C1B = 0;
  level._id_6FBF["ammo"]["func"] = ::_id_0DB9;
  level._id_6FBF["ammo"]["fx"] = "pickup_maxammo";
  level._id_6FBF["ammo"]["model"] = "ger_container_ammo_metal_02_zm";
  level._id_6FBF["ammo"]["outline"] = 1;
  level._id_6FBF["ammo"]["delayPickUp"] = 0;
  level._id_6FBF["insta_kill"]["func"] = ::_id_53DD;
  level._id_6FBF["insta_kill"]["fx"] = "pickup_instakill";
  level._id_6FBF["insta_kill"]["delayPickUp"] = 0;
  level._id_6FBF["double_points"]["func"] = ::_id_32C8;
  level._id_6FBF["double_points"]["fx"] = "pickup_doublepoints";
  level._id_6FBF["double_points"]["delayPickUp"] = 0;
  level._id_6FBF["nuke"]["func"] = ::_id_685F;
  level._id_6FBF["nuke"]["fx"] = "pickup_nuke";
  level._id_6FBF["nuke"]["model"] = "usa_fighter_thunderbolt_bomb_zm";
  level._id_6FBF["nuke"]["outline"] = 1;
  level._id_6FBF["nuke"]["delayPickUp"] = 0;
  level._id_6FBF["ability_fill"]["func"] = ::_id_0840;
  level._id_6FBF["ability_fill"]["fx"] = "pickup_abilityfill";
  level._id_6FBF["ability_fill"]["delayPickUp"] = 0;
  level._id_6FC8 = 1;
  _id_76AD();
  _id_7A55();

  if(isDefined(level.dropschedulefunc))
    level thread[[level.dropschedulefunc]]();
  else
    level thread _id_809A();
}

_id_76AD() {
  var_0 = 4;

  for(var_1 = 0; var_1 < var_0; var_1++)
    _id_907F();
}

_id_4608() {
  var_0 = undefined;

  foreach(var_2 in level._id_6FC9) {
    if(!var_2._id_54F5) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0))
    var_0 = _id_907F();

  var_0 _meth_805B();
  var_0._id_54F5 = 1;
  var_0 _meth_808C();
  var_0._id_9D65 _meth_808C();
  return var_0;
}

_id_907F() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("dlc_dogtags_zombie_invisible");
  var_0 _meth_8511();
  var_0._id_54F5 = 0;
  var_0._id_9D65 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  var_0._id_6A55 = var_0 _meth_85A0();
  level._id_6FC9[level._id_6FC9.size] = var_0;
  return var_0;
}

_id_6FC7() {
  return 0;
}

_id_7A55() {
  level._id_6FD2 = [];

  foreach(var_3, var_1 in level._id_6FBF) {
    var_2 = level._id_6FBF[var_3]["canBeDroppedByZombies"];

    if(isDefined(var_2) && ![[var_2]]()) {
      continue;
    }
    level._id_6FD2[level._id_6FD2.size] = var_3;
  }

  for(level._id_6FD2 = common_scripts\utility::array_randomize(level._id_6FD2); isDefined(level._id_6FD0) && level._id_6FD2.size > 1 && level._id_6FD2[0] == level._id_6FD0; level._id_6FD2 = common_scripts\utility::array_randomize(level._id_6FD2)) {}
}

_id_83B4() {
  if(level._id_6FD3 >= level._id_6FD2.size) {
    level._id_6FD3 = 0;
    _id_7A55();
  }

  if(isDefined(level._id_6FD0) && level._id_6FD2[level._id_6FD3] == level._id_6FD0 && level._id_6FD3 < level._id_6FD2.size - 1) {
    var_0 = level._id_6FD2[level._id_6FD3];
    level._id_6FD2[level._id_6FD3] = level._id_6FD2[level._id_6FD3 + 1];
    level._id_6FD2[level._id_6FD3 + 1] = var_0;
  }

  var_1 = level._id_6FD2[level._id_6FD3];
  level._id_6FD3++;
  return var_1;
}

_id_5775(var_0) {
  if(isDefined(level._id_6FD0) && var_0 == level._id_6FD0)
    return 0;

  return 1;
}

_id_83B5() {
  for(var_0 = _id_83B4(); !_id_5775(var_0); var_0 = _id_83B4()) {}

  return var_0;
}

_id_83B6(var_0) {
  var_1 = _id_83B5();

  if(var_1 != var_0)
    return var_1;

  while(var_1 == var_0)
    var_1 = _id_83B5();

  for(var_2 = level._id_6FD2.size - 1; var_2 >= level._id_6FD3; var_2--)
    level._id_6FD2[var_2 + 1] = level._id_6FD2[var_2];

  level._id_6FD2[level._id_6FD3] = var_0;

  if(level._id_6FD3 < level._id_6FD2.size - 1 && level._id_6FD2[level._id_6FD3] == level._id_6FD2[level._id_6FD3 + 1])
    level._id_6FD3++;

  return var_1;
}

_id_809A() {
  level waittill("zombie_wave_started");
  var_0 = level.players.size * 1000;
  var_1 = level.players.size * 2000;

  if(_id_0547::_id_0F0F("specialty_class_resourceful_zm"))
    var_1 = level.players.size * 1500;

  var_2 = 1.14;
  var_3 = var_2;
  var_4 = var_0 + var_1;
  _id_6FC8("Next Scheduled at " + var_4 + " points");

  for(;;) {
    var_5 = 0;

    foreach(var_7 in level.players) {
      if(isDefined(var_7._id_62D7))
        var_5 = var_5 + var_7._id_62D7;
    }

    if(var_5 > var_4) {
      level._id_34AA = 1;
      _id_6FC8("Reached Scheduled " + var_5 + ">" + var_4);
      var_1 = level.players.size * 2000;

      if(_id_0547::_id_0F0F("specialty_class_resourceful_zm"))
        var_1 = level.players.size * 1500;

      var_4 = var_5 + var_1 * var_3;
      var_3 = var_3 * var_2;
      _id_6FC8("Next Scheduled at " + var_4 + " points");
    }

    wait 0.5;
  }
}

_id_457B() {
  var_0 = _id_0547::_id_45C9() + 1;
  var_0 = clamp(var_0, 2, 4);

  if(_id_0547::_id_0F0F("specialty_class_resourceful_zm"))
    var_0 = var_0 + 1;

  return var_0;
}

_id_4600() {
  return 1;
}

_id_5300() {
  maps\mp\_utility::_id_8653();
  _func_035("scr_zombies_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
  _func_035("scr_zombies_roundlimit", 1);
  maps\mp\_utility::registerroundlimitdvar(level.gametype, 1);
  _func_035("scr_zombies_winlimit", 1);
  maps\mp\_utility::registerwinlimitdvar(level.gametype, 1);
  _func_035("scr_zombies_halftime", 0);
  maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
  _func_035("scr_zombies_timeLimit", 0);
  maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
  _func_035("scr_zombies_numLives", 1);
  maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
  _func_035("5539", 1);
}

_id_6BAF() {
  _func_157("auto_change");

  if(!isDefined(game["switchedsides"]))
    game["switchedsides"] = 0;

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = "ui_zm_characterClient_" + var_0;
    _func_032(var_1, -1);
    var_1 = "ui_zm_character_" + var_0;
    _func_032(var_1, -1);
  }

  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DOM");
  maps\mp\_utility::setobjectivescoretext("allies", &"HORDE_OBJECTIVE_SCORE");
  maps\mp\_utility::setobjectivescoretext("axis", &"HORDE_OBJECTIVE_SCORE");
  maps\mp\_utility::setobjectivehinttext("allies", undefined);
  maps\mp\_utility::setobjectivehinttext("axis", undefined);
  _id_0494::_id_5258();
  thread _id_050D::_id_10E4();
  thread _id_5264();
  var_2[0] = level.gametype;
  _id_04D1::main(var_2);
  _id_5372();
  level _id_054C::init();
  level thread _id_054D::init();
  level thread _id_AC6F();
  level thread _id_6B72();
  level thread _id_0547::_id_4AD7();
  level thread _id_056D::init();
  level thread maps\mp\zombies\zombie_weapon_kits_shared::weaponkitsinitshared();
  level thread _id_056C::_id_A9CE();
  level thread _id_0548::init();
  level thread _id_0543::init();
  level thread _id_0545::init();
  level thread _id_053F::init();
  level thread _id_0569::_id_5326();
  level thread _id_056A::init();
  level thread _id_0559::init();
  level thread _id_0552::init();
  level thread _id_0546::init();
  level thread _id_0556::init();
  level thread _id_0586::_id_AC73();
  level thread _id_054E::init();
  level thread _id_0549::init();
  level thread _id_053E::init();
  level thread _id_0540::init();
  level thread _id_055B::init();
  level thread _id_0561::init();
  level thread _id_054F::init();
  level thread _id_0547::_id_ABE5();
  level thread _id_0547::_id_A2A2();
  level thread _id_054B::init();
  level thread _id_7FE3();
  level thread _id_4B0A();
  level thread _id_4ADB();
  level thread _id_0555::_id_531F();
  level _id_0565::_id_5373();
  _id_0565::_id_7C07("wicht_set");
  thread _id_4DF4();

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun) && isDefined(level.onstartshotgunfunc))
    [[level.onstartshotgunfunc]]();

  if(isDefined(level._id_6BB0))
    [[level._id_6BB0]]();
}

_id_5372() {
  maps\mp\_utility::gameflaginit("insta_kill", 0);
  maps\mp\_utility::gameflaginit("double_points", 0);
  maps\mp\_utility::gameflaginit("fire_sale", 0);
  maps\mp\_utility::gameflaginit("power_off", 0);
  common_scripts\utility::flag_init("flag_rounds_unpaused");
  common_scripts\utility::flag_set("flag_rounds_unpaused");
  level._id_A980 = 0;
  level._id_AC9D = 0;
  level._id_ACC3 = 0;
  level._id_ACC4 = 0;
  level._id_90D3 = 0;
  level._id_90D2 = 0;
  level._id_7F2A = "normal";
  level._id_5B95 = (0, 0, 0);
  level._id_AC21 = 0;
  level._id_3294 = 0;
  level._id_7543 = 1;
  level._id_77B7 = 0;
  level._id_745F = 0;
  level._id_AC60 = [];
  _id_0547::_id_7D79();
  level._id_32CF = 0;
  level._id_6082 = 200;
  level._id_7541 = [];
  level._id_7541["damage_body"] = int(10 * level._id_7543);
  level._id_7541["damage_head"] = int(10 * level._id_7543);
  level._id_7541["kill_trap"] = int(10 * level._id_7543);
  level._id_7541["kill_limb"] = int(50 * level._id_7543);
  level._id_7541["kill_streak"] = int(40 * level._id_7543);
  level._id_7541["kill_body"] = int(60 * level._id_7543);
  level._id_7541["kill_head"] = int(100 * level._id_7543);
  level._id_7541["kill_melee"] = int(130 * level._id_7543);
  level._id_7541["kill_HeavyMelee"] = int(60 * level._id_7543);
  level._id_7541["kill_HeavyMeleeBonus"] = int(150 * level._id_7543);
  level._id_7541["kill_melee_aoe"] = int(60 * level._id_7543);
  level._id_7541["kill_reward_trap"] = int(60 * level._id_7543);
  level._id_7541["kill_follower"] = int(200 * level._id_7543);
  level._id_7541["kill_fireman"] = int(750 * level._id_7543);
  level._id_7541["kill_fireman_assist"] = int(500 * level._id_7543);
  level._id_7541["power_on"] = int(100 * level._id_7543);
  level._id_7541["atm"] = int(100 * level._id_7543);
  level._id_7541["atm_jackpot"] = int(10 * level._id_7543);
  level._id_7541["cure"] = int(100 * level._id_7543);
  level._id_7541["crate"] = int(500 * level._id_7543);
  level._id_7541["nuke"] = int(400 * level._id_7543);
  level._id_7541["reward_bronze"] = int(500 * level._id_7543);
  level._id_7541["reward_silver"] = int(1000 * level._id_7543);
  level._id_7541["reward_gold"] = int(2000 * level._id_7543);
  level._id_7541["breach_fix"] = int(200 * level._id_7543);
  level._id_7541["repair"] = int(10 * level._id_7543);
  level._id_7541["perfectRound"] = int(100 * level._id_7543);
  level._id_7541["mercReward"] = int(5 * level._id_7543);
  level._id_7541["damage_over_time"] = int(5 * level._id_7543);
  level._id_7541["one_shot_one_kill"] = int(20 * level._id_7543);
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

  if(!isDefined(level._id_3283))
    level._id_3283 = [];
}

_id_AC53() {
  thread _id_04E8::_id_873A("allies");
  self._id_0179 = "allies";
}

_id_6B72() {
  for(;;) {
    level waittill("connected", var_0);

    if(common_scripts\utility::_id_562E(level.immediately_skip_loading_cinematic))
      _func_292(var_0);

    var_0 thread monitor_loading_cinematic_state();
    var_0 thread nocontrolduringcinematic();
    thread compassgodhack(var_0);

    if(!isbot(var_0)) {
      _id_0555::_id_83DD("join", var_0);
      level thread _id_637E(var_0);
    }

    var_0 thread _id_054E::_id_5165();
    level thread _id_637D(var_0);
    var_0 thread _id_742A();
    level thread _id_2820(var_0);
    var_0 _id_054C::_id_5370();
    var_0 _id_054C::_id_7B39();
    var_1 = 0;

    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(level.players[var_2].clientid == var_0.clientid) {
        var_1 = 1;

        if(!isbot(var_0))
          _id_0555::_id_83DD("re_join", var_0);
      }
    }

    if(!var_1)
      level._id_745F++;

    var_0._id_32CE = level._id_6082;
    var_3 = undefined;

    if(isDefined(level._id_477F))
      var_0[[level._id_477F]](var_3);
    else
      var_0 _id_0547::_id_4780(var_3);

    if(isbot(var_0)) {
      continue;
    }
    _id_054B::onplayerconnect(var_0);
    var_0 thread _id_0561::_id_5332();
    _id_054A::onplayerconnect(var_0);
    var_0 thread _id_056A::onplayerconnect();
    var_0 thread _id_7272();
  }
}

compassgodhack(var_0) {
  if(getdvarint("2161")) {
    var_0 endon("death");
    waittillframeend;
    waittillframeend;
    waittillframeend;
    waittillframeend;
    var_0 _meth_84C0(1);
    waitframe();
    var_0 _meth_84C0(1);
    waitframe();
    var_0 _meth_84C0(1);

    for(;;) {
      waitframe();

      for(var_1 = 0; var_1 < 5; var_1++) {
        if(!var_0 _meth_85F0())
          var_0 _meth_84C0(1);

        waittillframeend;
      }
    }
  }
}

_id_742A() {
  self endon("disconnect");

  for(;;) {
    if(self _meth_8346()) {
      if(isDefined(self.origin) && isDefined(self._id_5BA3) && self.hasspawned) {
        var_0 = _func_0E1(self._id_5BA3, self.origin);
        var_1 = self._id_9092 == self.origin;
        var_2 = 100 > var_0 && var_0 > 0;

        if((!var_1 || var_1 && self._id_4B7A) && var_2) {
          self._id_4B7A = 1;
          self._id_3036 = self._id_3036 + var_0;

          if(self _meth_83DD())
            self._id_3034 = self._id_3034 + var_0;
        }
      }

      self._id_5BA3 = self.origin;
    }

    waitframe();
  }
}

_id_2820(var_0) {
  var_0._id_A9EB = [];
  var_0._id_A9DF = [];
  var_0._id_AC5D = [];
  var_0.besttimetrialtimes = [];
  var_0._id_7545 = [];
  var_0._id_00B7 = 0;
  var_0._id_014D = 0;
  var_0._id_5F7C = 0;
  var_0._id_9CFF = 0;
  var_0.zombiepointsearned = 0;
  var_0._id_4BF7 = 0;
  var_0._id_60EC = 0;
  var_0._id_4868 = 0;
  var_0.equipmentkills = 0;
  var_0.equipmentused = 0;
  var_0._id_394C = 0;
  var_0._id_6882 = 0;
  var_0._id_6881 = 0;
  var_0._id_178B = 0;
  var_0._id_68A0 = 0;
  var_0._id_7D10 = 0;
  var_0._id_AACE = 0;
  var_0._id_6F5F = 0;
  var_0._id_3295 = 0;
  var_0._id_90CC = 0;
  var_0._id_7E5F = 0;
  var_0._id_598C = 0;
  var_0._id_6E48 = 0;
  var_0._id_2AB8 = 0;
  var_0._id_99F8 = 0;
  var_0._id_32CD = 0;
  var_0._id_5BF3 = 0;
  var_0._id_8B3D = 0;
  var_0._id_8B33 = 0;
  var_0._id_4DC4 = 0;
  var_0._id_4DC5 = 0;
  var_0._id_831B = [];
  var_0._id_3036 = 0;
  var_0._id_3034 = 0;
  var_0._id_4B7A = 0;
  var_0._id_7F1D = 0;
  var_0._id_7F1E = 0;
  var_0._id_99F8 = 0;
  var_0._id_32CD = 0;
  var_0._id_5BF3 = 0;
  var_0._id_5A52 = 0;
  var_0._id_4BF8 = 0;
  var_0._id_3963 = 0;
  var_0._id_178B = 0;
  var_0._id_32D1 = 0;
  var_0._id_5F7D = 0;
  var_0._id_6F60 = 0;
  var_0._id_3296 = 0;
  var_0._id_5F7D = 0;
  var_0._id_90CD = 0;
  var_0._id_7E60 = 0;
  var_0._id_598D = 0;
  var_0._id_6E49 = 0;
  var_0._id_3037 = 0;
  var_0._id_3035 = 0;
  var_0._id_4DE1 = 0;
  var_0._id_8B39 = 0;
  var_0._id_801D = 0;
  var_0._id_39E6 = 0;
  var_0._id_39E4 = 0;
  level._id_745F = level.players.size;
  var_0._id_7F11 = 0;
  var_0._id_7F06 = 0;
  var_0._id_7EFE = 0;
  var_0._id_7F09 = 0;
  var_0._id_7F10 = 0;
  var_0._id_7F07 = 0;
  var_0._id_7F04 = 0;
  var_0._id_7F0B = 0;
  var_0._id_7F0D = 0;
  var_0._id_7F08 = 0;
  var_0._id_801C = 0;
  var_0._id_39E5 = 0;
  var_0._id_39E3 = 0;
  var_0._id_AC30 = [];
  var_1 = "mp/zombieTypeTable.csv";
  var_2 = _func_27A(var_1);

  if(var_2 > 24) {}

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _func_1AE(var_1, var_3, 1);
    var_0._id_AC5D[var_4] = 0;
  }

  var_5 = 500;

  if(_id_0544::_id_2698() >= 10)
    var_5 = 0;

  var_5 = var_5 - _id_0544::_id_467F(var_0);
  var_5 = int(max(0, var_5));
  var_0 _id_7D63(var_5);
  var_0 _id_5361();
  var_0 _id_0547::_id_7454(0);
  _id_283D(var_0, "shovel_zm");
  level thread _id_63C8(var_0);
  level thread _id_7407(var_0);
}

_id_A14A() {
  var_0 = 999999999;
  var_1 = self._id_62D6;

  if(var_1 > var_0)
    var_1 = var_0;

  var_2 = self._id_62D7;

  if(var_2 > var_0)
    var_2 = var_0;

  var_3 = 9999999;
  var_4 = var_1;

  if(var_4 > var_3)
    var_4 = var_3;

  if(isDefined(self.characterclientindex))
    _func_032("ui_zm_points_" + self.characterclientindex, var_4);

  self.score = var_1;
  self._id_008F = var_2;
  maps\mp\_utility::setpersstat("score", var_1);
  maps\mp\_utility::setpersstat("extrascore0", var_2);
}

_id_7D63(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 = int(var_0);
  self._id_62D6 = var_0;
  self._id_62D7 = var_0;
  _id_A14A();
  self notify("money_update");
  self _meth_82FF("ui_zm_award_points", 0);
}

_id_4798(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 = int(var_0);

  if(!isDefined(var_1) || var_1 != 1)
    var_1 = 0;

  var_2 = var_0;

  if(var_2 > 9999)
    var_2 = 9999;

  self._id_7545[self._id_7545.size] = var_2;
  self._id_62D6 = self._id_62D6 + var_0;

  if(isDefined(level.zmb_events_player_zombie_aquired_jolts))
    self thread[[level.zmb_events_player_zombie_aquired_jolts]](var_0, var_1);

  if(!var_1) {
    self._id_62D7 = self._id_62D7 + var_0;

    if(isDefined(self._id_7F1D))
      self._id_7F1D = self._id_7F1D + var_0;
  }

  _id_A14A();
  self notify("money_update");
}

_id_90F5(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 = int(var_0);
  var_2 = 0 - var_0;

  if(var_2 < -9999)
    var_2 = -9999;

  self._id_7545[self._id_7545.size] = var_2;
  self._id_62D6 = self._id_62D6 - var_0;

  if(isDefined(self._id_7F1E))
    self._id_7F1E = self._id_7F1E + var_0;

  if(isDefined(self.gamemoneyspent) && !common_scripts\utility::_id_562E(var_1))
    self.gamemoneyspent = self.gamemoneyspent + var_0;

  _id_A14A();
  self notify("money_update");
}

_id_4480(var_0) {
  return var_0._id_62D6;
}

_id_5361() {
  var_0 = self getplayerdata(common_scripts\utility::_id_46A7(), "tokensAvailable");
  _id_874B(var_0);
}

_id_46E8() {
  return 1000;
}

_id_4B9D(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  return self._id_9A86 >= var_0;
}

_id_47C0(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_874B(self._id_9A86 + var_0);
}

_id_90F6(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_874B(self._id_9A86 - var_0);
}

_id_874B(var_0) {
  if(level._id_9A87) {
    if(var_0 < 0)
      var_0 = 0;

    self._id_9A86 = var_0;
    self setplayerdata(common_scripts\utility::_id_46A7(), "tokensAvailable", self._id_9A86);
    self _meth_82FF("ui_zm_token_count", self._id_9A86);
  } else {
    self._id_9A86 = -1;
    self _meth_82FF("ui_zm_token_count", -1);
  }
}

_id_283D(var_0, var_1) {
  var_2 = _func_05F(var_1);

  if(_id_0547::_id_4BA8(var_0, var_2)) {
    return;
  }
  var_0._id_A9EB[var_2]["level"] = 1;
}

_id_A9DB(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    var_0 common_scripts\utility::_id_A70A("weaponLevelEarned", "weapon_change");
    var_1 = _id_0547::_id_462A(var_0);
    var_2 = _func_05F(var_1);

    if(!_id_0547::_id_4BA8(var_0, var_2)) {
      continue;
    }
    var_3 = var_0._id_A9EB[var_2]["level"];

    if(100 < var_3)
      var_3 = 100;

    var_0 _meth_82FF("ui_horde_count", var_3);
  }
}

_id_7407(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("spawned");
  var_1 = 0;

  if(isDefined(level._id_A980))
    var_1 = level._id_A980 - 1;

  var_0 _id_0547::_id_7B37(var_1);
}

_id_637E(var_0) {
  level endon("game_ended");
  var_1 = var_0 getentitynumber();
  var_0 waittill("disconnect");
  _id_0555::_id_83DD("leave", var_1);
  _id_0547::clearrangedperk(var_1);
}

_id_637D(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
  level notify("player_disconnected");
}

_id_AC20() {
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";
  self.pers["gamemodeLoadout"] = level._id_629B[level._id_746E];
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
}

_id_6B81() {
  if(_func_1EF(self))
    self thread[[maps\mp\agents\_agent_utility::_id_0A59("spawn")]]();
  else
    thread _id_6BA4();
}

_id_6BA4(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawnplayer_giveloadout");
  _id_0547::_id_AC16(0, "class");
  _id_054A::_id_6B81();
  _id_051E::_id_2400();

  if(_id_0547::_id_5767(self)) {
    var_1 = "shovel_zm";

    if(isPlayer(self)) {
      var_2 = "ui_zm_character_" + self.characterclientindex + "_alive";
      _func_032(var_2, 1);
      _func_032("ui_zm_points_" + self.characterclientindex, self._id_62D6);
      var_3 = self _meth_834A();

      if(var_3 != "none")
        _id_0548::_id_3AC1(self, var_3);

      maps\mp\_utility::giveperk("specialty_pistoldeath");
      maps\mp\_utility::giveperk("specialty_coldblooded");
      maps\mp\_utility::giveperk("specialty_sprintreload");
      maps\mp\_utility::giveperk("specialty_falldamage");
      maps\mp\_utility::_id_861B();

      if(level._id_A980 <= 1 && !isDefined(self._id_596A))
        self._id_596A = 1;

      if(level._id_A980 <= 5 && !isDefined(self.joinedearlyrounds))
        self.joinedearlyrounds = 1;

      self._id_4D13 = undefined;

      if(isDefined(self._id_18A8))
        self._id_18A8 delete();

      if((!isDefined(self._id_7216) || !self._id_7216) && (!isDefined(level._id_AC28) || !level._id_AC28) && _id_4458() != "none") {
        _id_74BD();
        self._id_7216 = 1;
      } else {
        self._id_8C8B = 1;
        var_1 = self _meth_8317();
        var_4 = _id_0548::_id_454B(self, "shovel_zm");
        var_5 = _id_056C::getzombiepaintjob(self, var_4);
        maps\mp\_utility::_giveweapon(var_4, undefined, var_5);
        self setspawnweapon(var_1, 1, 1);
      }

      _id_0547::_id_0A00(self, self _meth_8317());
      thread _id_4AE1();
      var_6 = getmatchdata("players", self.clientid, "utc_first_spawn_time_s");

      if(!isDefined(var_6) || var_6 == 0)
        setmatchdata("players", self.clientid, "utc_first_spawn_time_s", _func_131());
    }

    thread _id_054B::_id_6B81();
    _id_0547::_id_7ACD();
  }

  if(isDefined(level._id_6BA5))
    self[[level._id_6BA5]]();

  self notify("zombie_player_spawn_finished");
}

_id_A799(var_0) {
  for(;;) {
    if(self _meth_842C(self, var_0)) {
      break;
    }

    waitframe();
  }
}

_id_3E8D() {
  self endon("disconnect");
  self freezecontrols(1);
  wait 4.0;
  self freezecontrols(0);
}

_id_4458() {
  switch (self._id_20D8) {
    default:
      return "none";
  }
}

_id_4457() {
  switch (self._id_20D8) {
    default:
      return "";
  }
}

_id_74BD() {
  var_0 = _id_4458();
  var_1 = self _meth_8317();

  if(isDefined(var_0)) {
    var_2[0] = "shovel_zm";
    var_2[1] = var_0;
    _id_A799(var_2);
    thread _id_3E8D();
    wait 1;
    _id_0586::_id_078C(var_0);
    _id_0586::_id_078E(var_0, 1);
    self _meth_8326();
    self _meth_812B(0);
    wait 3.6;
    self _meth_8327();
    self _meth_812B(1);
    _id_0586::_id_0790(var_0);
  }

  _id_0586::_id_078C("shovel_zm");
  _id_0586::_id_078E(var_1, 1);
}

_id_74EB(var_0, var_1) {
  if(_id_0547::_id_577E(self)) {
    return;
  }
  var_2 = self getcurrentweapon(1);

  if(issubstr(var_2, "turrethead")) {
    return;
  }
  self._id_74B9 = 1;
  _id_0586::_id_078C(var_0);
  _id_0586::_id_078E(var_0, 1);
  self _meth_8326();
  self _meth_812B(0);
  wait(var_1);
  self _meth_812B(1);
  _id_0586::_id_0790(var_0);

  if(!_id_0547::_id_577E(self)) {
    self _meth_8327();
    _id_0586::_id_078E(var_2, 1);
  }

  self._id_74B9 = 0;
}

_id_2440() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();

  if(!_func_1EF(self))
    thread maps\mp\gametypes\_playerlogic::_id_8753(-1);
}

_id_A79D() {
  maps\mp\_utility::gameflagwait("prematch_done");
  _func_032("ui_match_countdown_title", 0);

  if(!isDefined(level._id_585D) || !level._id_585D) {
    while(!isDefined(level._id_1A6E) || level._id_1A6E == 0)
      waitframe();
  }

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(!var_2 player_is_playing_loading_cinematic()) {
        var_0 = 1;
        break;
      }
    }

    if(var_0) {
      break;
    }

    waitframe();
  }

  _func_28F();
  level.immediately_skip_loading_cinematic = 1;
}

_id_A90F() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    var_0 = int(max(_func_0AF(level._id_A980, 9999), 1));
    _func_032("ui_zm_round_number", var_0);

    foreach(var_2 in level.players) {
      if(_func_0C1(var_2)) {
        continue;
      }
      if(!isDefined(var_2)) {
        continue;
      }
      if(!isDefined(var_2._id_4DF5)) {
        continue;
      }
      if(!var_2._id_4DF5.size) {
        continue;
      }
      var_3 = var_2._id_4DF5.size;

      for(var_4 = 0; var_4 < var_3; var_4++) {
        if(!isDefined(var_2)) {
          continue;
        }
        if(!_func_1EF(var_2))
          var_2 _meth_82FF("ui_horde_update_perk", var_2._id_4DF5[var_4]["index"]);

        waitframe();
      }
    }
  }
}

_id_0997(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_AAFD))
    level._id_AAFD = [];

  var_4 = spawnStruct();
  level._id_AAFD[var_0] = var_4;
  var_4._id_920F = var_1;
  var_4._id_367E = var_2;
  var_4._id_51D5 = var_3;
}

_id_5294(var_0) {
  common_scripts\utility::flag_init("safe_haven_closed");

  foreach(var_2 in level._id_AAFD)
  level thread[[var_2._id_51D5]]();

  _id_92EC(var_0);
}

_id_92EC(var_0) {
  if(isDefined(level._id_76DE)) {}

  if(isDefined(level._id_2957)) {
    level thread[[level._id_2957._id_367E]]();
    level._id_76DE = level._id_2957;
  }

  level._id_2957 = level._id_AAFD[var_0];
  level thread[[level._id_2957._id_920F]]();
}

_id_37BE() {
  _id_802A();
  level notify("entered_safe_haven");
}

_id_802A(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(common_scripts\utility::_id_3C77("flag_rounds_unpaused")) {
    if(!level._id_AC28) {
      level waittill("zombie_wave_started");
      wait 1;
    }

    level notify("zombie_wave_interrupt");
    wait 0.5;

    if(var_0) {
      var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

      foreach(var_3 in var_1)
      var_3 suicide();
    }

    level._id_AC11 = 0;
    level notify("zombie_wave_ended");
    common_scripts\utility::_id_3C7B("flag_rounds_unpaused");
  }
}

_id_8029() {
  common_scripts\utility::flag_set("flag_rounds_unpaused");
}

_id_8028(var_0) {
  level._id_ACC3 = 0;
  level._id_AC9D = 1;
  level._id_ACC4 = level._id_A980;
}

_id_38F4() {
  level notify("leaving_safe_haven");
  _id_8029();
}

_id_7FCA() {
  self endon("cleanup_safe_haven_trigger");
  level endon("safe_haven_closing");
  var_0 = common_scripts\utility::_id_41F0();

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname) && isDefined(var_2._id_0165)) {
      if(var_2.targetname == "door" && var_2._id_0165 == "safe_haven")
        self._id_537E = var_2;
      else if(var_2.targetname == "door" && var_2._id_0165 == "closeable")
        self._id_6C6E = var_2;
    }

    if(isDefined(self._id_537E) && isDefined(self._id_6C6E)) {
      break;
    }
  }

  thread _id_7FC9();
  thread _id_63DA();
  thread _id_7FCB();
}

_id_4240(var_0, var_1, var_2) {
  var_3 = var_0 * var_1;
  var_4 = _func_0D5(var_1 * var_2);
  return var_3 + "/" + var_4;
}

_id_63DA() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0.5;

  while(var_0 < var_2) {
    level waittill("safe_haven_trigger_ratio", var_0, var_1);

    if(var_0 < var_2) {
      var_3 = _id_4240(var_0, var_1, var_2);
      _func_18C(var_3 + " vote to open Safe Haven");
    }
  }

  level notify("safe_haven_opening");
  common_scripts\utility::_id_3C7B("safe_haven_closed");
  var_4 = 1;
  var_2 = 1.0;

  while(var_0 < var_2) {
    var_3 = _id_4240(var_0, var_1, var_2);
    _func_18C(var_3 + " vote to close Safe Haven");
    level waittill("safe_haven_trigger_ratio", var_0, var_1);
  }

  common_scripts\utility::flag_set("safe_haven_closed");
  self._id_537E notify("open");
  self._id_6C6E notify("close");
}

_id_7FC9() {
  self._id_5BCC = 0;

  for(;;) {
    if(self._id_5BCC == 0)
      self waittill("trigger");
    else
      maps\mp\_utility::waitfortimeornotify(0.5, "trigger");

    var_0 = 0;
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(maps\mp\_utility::isreallyalive(var_3)) {
        var_0++;

        if(self istouching(var_3))
          var_1++;
      }
    }

    if(var_0 == 0)
      var_5 = 0;
    else
      var_5 = var_1 / var_0;

    if(var_5 != self._id_5BCC) {
      level notify("safe_haven_trigger_ratio", var_5, var_0);
      self._id_5BCC = var_5;
    }

    wait 0.5;
  }
}

_id_5A4E() {
  common_scripts\utility::_id_3C9F("safe_haven_closed");

  foreach(var_1 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_1) && !self istouching(var_1))
      var_1 suicide();
  }
}

_id_7FCB() {
  thread _id_5A4E();
  level waittill("safe_haven_opening");

  if(common_scripts\utility::_id_3C77("safe_haven_closed")) {
    return;
  }
  level endon("safe_haven_closed");
  var_0 = 60;
  var_1 = gettime() + var_0 * 1000;
  var_2 = 5;

  for(;;) {
    var_3 = max(0, var_1 - gettime()) / 1000;
    var_4 = _func_0D5(var_3 / 5) * 5;

    if(var_4 > 0)
      _func_18C("Safe House Closes: " + var_4);

    if(var_3 > var_2) {
      wait(var_2);
      continue;
    }

    if(var_3 > 0) {
      wait(var_3);
      continue;
    }

    break;
  }

  common_scripts\utility::flag_set("safe_haven_closed");
}

_id_6B5C(var_0, var_1, var_2) {
  var_0 thread _id_0553::deathmonitorabandonment();
}

_id_6B41(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(level.players.size > 1 || isPlayer(var_0) && var_0 _id_0547::_id_73BF())
    var_0 _meth_82CA();

  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
}

_id_2FA0(var_0) {
  return !self.hasspawned && level._id_A980 > 1 && isDefined(level._id_AC11) && level._id_AC11;
}

_id_1E38(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = "standard";

  if(_id_0547::_id_580B(var_5))
    var_11 = "none";
  else if(_func_1EF(self) && isDefined(self.is_fellow_human) && self.is_fellow_human)
    var_11 = "none";
  else {
    if(var_5 == "iw5_microwavezm_mp")
      var_11 = "nosound";

    if(var_2 < self.health) {
      if(isDefined(self.zombie_shielding_func))
        var_11 = "minor";
      else if(self._id_0A4B == "zombie_heavy") {
        if(_id_0567::_id_ABBF(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10))
          var_11 = "weakpoint";
        else if(var_8 == "head" || var_8 == "helmet" || var_8 == "neck" || var_5 == "panzerschreck_zm" || issubstr(var_5, "fliegerfaust") || issubstr(var_5, "razergun"))
          var_11 = "standard";
        else
          var_11 = "minor";
      } else if(self._id_0A4B == "zombie_exploder") {
        if(_id_0563::_id_AB95(self, var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10))
          var_11 = "weakpoint";

        if(common_scripts\utility::_id_562E(self.sgvip) && common_scripts\utility::_id_562E(self._id_392C) && _id_0547::_id_5565(var_10, _func_117("TAG_WEAPON")))
          var_11 = "minor";
      } else if(self._id_0A4B == "zombie_bob" && common_scripts\utility::_id_562E(self.allow_non_engine_hits)) {
        if(var_5 != "wunderbuss_zm") {
          var_12 = self gettagorigin("engine");

          if(distancesquared(var_12, var_6) > 256)
            var_11 = "minor";
          else
            var_11 = "weakpoint";
        }
      } else if(self._id_0A4B == "zombie_fireman") {
        if(var_10 == "j_backpack") {
          if(self._id_3FEE == 0)
            var_11 = "weakpoint";
          else
            var_11 = "minor";

          if(common_scripts\utility::_id_562E(self.godtank))
            var_11 = "minor";
        } else if(!common_scripts\utility::_id_562E(self.godtank) && self._id_3FEE == 0) {
          if(var_5 == "panzerschreck_zm" || issubstr(var_5, "fliegerfaust") || issubstr(var_5, "tesla_gun") || issubstr(var_5, "razergun") || var_5 == "bazooka_zm")
            var_11 = "standard";
          else
            var_11 = "minor";
        } else
          var_11 = "standard";
      } else if(_id_0547::_id_5565(self._id_0A4B, "zombie_guardian")) {
        if(common_scripts\utility::_id_562E(self.zombie_guardian_can_take_damage))
          var_11 = "weakpoint";
        else
          var_11 = "minor";
      } else if(_id_0547::_id_5565(self._id_0A4B, "zombie_king")) {
        switch (var_8) {
          case "soft":
            var_11 = "headshot";
            break;
        }
      } else {
        switch (var_8) {
          case "neck":
          case "helmet":
          case "head":
            var_11 = "headshot";
            break;
        }
      }
    } else if(self._id_0A4B == "zombie_heavy") {
      if(_id_0567::_id_ABBF(var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10))
        var_11 = "killshot_headshot";
      else
        var_11 = "killshot";
    } else {
      switch (var_8) {
        case "neck":
        case "helmet":
        case "head":
          var_11 = "killshot_headshot";
          break;
        default:
          var_11 = "killshot";
          break;
      }
    }
  }

  return var_11;
}

callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(maps\mp\_utility::_id_4571() == "mp_zombie_descent" && isDefined(var_1) && isDefined(var_1.classname) && issubstr(var_1.classname, "trigger_hurt")) {
    foreach(var_12, var_11 in level._id_6F5C)
    _id_056A::_id_95D7(var_12);

    if(isDefined(level._id_5F20))
      [[level._id_5F20]]();
  }

  if((var_4 == "MOD_MELEE" || var_4 == "MOD_IMPACT") && (isDefined(var_0) && isDefined(var_0._id_0A4B) && !common_scripts\utility::_id_562E(_id_5736(self, var_1)) && var_0._id_0A4B == "zombie_heavy"))
    self _meth_8182("zm_heavy_hit", 1, 0, 0);

  if(isDefined(level.callbackplayerdamagesecondaryhandling))
    self thread[[level.callbackplayerdamagesecondaryhandling]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  maps\mp\gametypes\_damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_6B77(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isPlayer(self))
    _id_053B::_id_6B73(var_1);

  if(isDefined(var_1) && isDefined(var_1._id_0A4B) && (var_1._id_0A4B == "zombie_fireman" || common_scripts\utility::_id_562E(var_1.isfireassassin)) && var_4 == "MOD_ENERGY" && isPlayer(self))
    _func_14D(level._effect["player_screen_burn"], self, "TAG_ORIGIN", self);

  if(isPlayer(self))
    thread _id_21E5(var_1);
}

_id_21E5(var_0) {
  if(isDefined(level._id_7F2A) && level._id_7F2A == "zombie_dog") {
    if(isDefined(var_0) && isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zombie_berserker") {
      self._id_4DCB = 1;
      self._id_31AB = 0;
    }
  }
}

_id_60F8() {
  self endon("death");
  level endon("game_ended");
  self _meth_8308(0);
  waitframe();

  if(isalive(self))
    self _meth_8308(1);
}

_id_740B(var_0, var_1, var_2) {
  if(_id_0547::_id_57C2(var_0)) {
    if(isDefined(var_2) && var_2 == "MOD_TRIGGER_HURT")
      return 0;

    if(isDefined(var_1)) {
      if(common_scripts\utility::_id_562E(var_1._id_5869))
        return 0;

      if(_func_0C1(var_1) && !_func_2BF(var_1))
        return 0;
    }

    return 1;
  }

  return 0;
}

_id_62AF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = var_3;

  if(isDefined(level.callbackzombiesdamagesecondaryhandling))
    level thread[[level.callbackzombiesdamagesecondaryhandling]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_0._id_480F) && var_0._id_480F)
    return 0;

  if(isDefined(var_0._id_6B51) && var_0._id_6B51) {
    if(isDefined(var_2) && !(isDefined(var_2._id_60F5) && var_2._id_60F5 == "large"))
      return 0;
  }

  if(isPlayer(var_0) && (isDefined(var_2) && isPlayer(var_2))) {
    if(issubstr(var_5, "chatelleroult") && issubstr(var_5, "_pap_zm") && !isDefined(var_0.linkedbubblefx)) {
      var_2 thread _id_04C7::_id_A102("minor");
      playFX(common_scripts\utility::_id_44F5("zmb_mm_tracer_purp_hit"), var_6 + (0, 0, -30));

      if(!isDefined(var_0.chatelleroult_count)) {
        var_0.chatelleroult_count = [];
        var_0.chatelleroult_count["g43_pap_zm"] = 0;
        var_0.chatelleroult_count["chatelleroult_pap_zm"] = 0;
      }

      if(issubstr(var_5, "chatelleroult_pap_zm"))
        var_0.chatelleroult_count["chatelleroult_pap_zm"]++;
      else
        var_0.chatelleroult_count["g43_pap_zm"]++;

      if(var_0.chatelleroult_count["g43_pap_zm"] >= 5 || var_0.chatelleroult_count["chatelleroult_pap_zm"] >= 10) {
        var_0 thread _id_4798(50);
        var_2 thread _id_4798(50);
        _id_0378::_id_8D74("zmb_pomel_grenade_detonate", var_0.origin);
        _id_0378::_id_8D74("zmb_pomel_grenade_force_field", var_0.origin);
        var_0.chatelleroult_count["g43_pap_zm"] = 0;
        var_0.chatelleroult_count["chatelleroult_pap_zm"] = 0;

        if(isDefined(level.bren_bubble_func))
          var_0[[level.bren_bubble_func]]();
      }
    }
  }

  if(isDefined(var_2) && isDefined(var_2._id_0117))
    var_2 = var_2._id_0117;

  var_11 = maps\mp\_utility::_id_118D(var_0, var_2);
  var_12 = _func_05F(var_5);

  if(!isDefined(var_12))
    var_12 = "none";

  if(isDefined(level._id_29E0[var_12]))
    var_12 = level._id_29E0[var_12];

  if(isDefined(level._id_2C9F) && common_scripts\utility::_id_562E(var_0._id_56C2) && _func_0C1(var_2) && !_func_2BF(var_2))
    var_10 = int(var_10 * level._id_2C9F);

  if(common_scripts\utility::_id_562E(var_0.is_fellow_human) && (_id_0547::_id_5864(var_5) || _id_0547::_id_5752(var_5))) {
    if(isDefined(var_0.vignettepartner) && isalive(var_0.vignettepartner))
      var_0.vignettepartner common_scripts\utility::_id_2CBE(0, ::_meth_8059, var_3, var_6, var_2, var_1, var_4, var_5, var_8);

    return 0;
  }

  if(isPlayer(var_0)) {
    if(var_5 == "drag_explosive_zombie_zm" || var_5 == "frag_skull_zm" || issubstr(var_5, "teslagun") || issubstr(var_5, "raven_sword_zm") || var_5 == "turretweapon_ger_btry_flak38_mp_zombie")
      return 0;

    if(issubstr(var_5, "frag_grenade_funderbuss_zm"))
      return 0;

    if(issubstr(var_5, "bazooka_zm") || issubstr(var_5, "panzerschreck_zm") || issubstr(var_5, "fliegerfaust") || issubstr(var_5, "tesla_gun") || _id_0547::_id_585C(var_5) || isPlayer(var_2) && var_2 == var_0 && _func_17B(var_4)) {
      if(var_0 _id_0547::_id_4BA7("specialty_class_flak_jacket_zm"))
        return 0;

      var_10 = 20;
    }

    if(var_0 _id_054A::_id_21B2())
      return 0;

    if(_func_0C1(var_2) && var_2 _id_0547::_id_AC70())
      return 0;

    if(var_11)
      return 0;

    if(_id_0547::_id_577E(var_0))
      return 0;

    if(_id_0547::_id_5565(var_4, "MOD_FALLING"))
      return 0;

    if(_id_740B(var_0, var_1, var_4))
      return 0;

    if(isDefined(var_0._id_5BD7)) {
      var_13 = 1000;

      if(gettime() - var_0._id_5BD7 < var_13)
        return 0;
    }

    if(maps\mp\_utility::iskillstreakweapon(var_5) || _id_0546::_id_56E6(var_5) || var_5 == "exploder_zm_small_mp")
      return 20;

    if(isDefined(var_2) && _func_0C1(var_2)) {
      var_13 = 500;

      if(_func_2BF(var_2) && isDefined(var_0._id_5C14) && gettime() - var_0._id_5C14 < var_13)
        return 0;

      if(_func_2BF(var_2) && var_2._id_0A4B == "zombie_heavy") {
        if(common_scripts\utility::_id_562E(_id_5736(var_0, var_2)))
          return 0;
      }

      var_14 = level._id_0A50[var_2._id_0A4B]._id_60D4;
      var_15 = level._id_0A50[var_2._id_0A4B]._id_29AA;

      if(isDefined(var_14) && var_4 == "MOD_MELEE")
        var_10 = int(max(var_10 * var_14, 1));
      else if(isDefined(var_15))
        var_10 = int(max(var_10 * var_15, 1));
    }

    if(isDefined(var_2) && _func_0C1(var_2)) {
      if(isDefined(level._id_6AE0) && isDefined(level._id_6AE0[var_2._id_0A4B]))
        var_2[[level._id_6AE0[var_2._id_0A4B]]](var_0);
    }

    if(isDefined(var_2) && var_2.classname == "misc_turret" && isDefined(var_1)) {
      if(isDefined(var_2._id_62AD))
        var_10 = var_0[[var_2._id_62AD]](var_10);

      if(isDefined(var_2._id_6B73))
        var_0[[var_2._id_6B73]](var_1);
    }

    if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.isinvisiblevisionzombie))
      return 0;

    if(var_5 == "exploder_zm_large_mp")
      var_0 _meth_854F();

    if(isDefined(var_0.deathravenenergy_test_func) && [[var_0.deathravenenergy_test_func]]() && var_10 >= var_0.health && var_4 != "MOD_ARMOR" && var_4 != "MOD_TRIGGER_HURT") {
      var_0 notify("dr_shield_activate", var_5);
      return 0;
    }

    if(isDefined(var_0.bloodshieldblock_test_func) && [[var_0.bloodshieldblock_test_func]](var_2, var_1) && var_4 != "MOD_TRIGGER_HURT") {
      var_0 notify("br_block_hit", var_10, var_5);
      var_0.shield_hit_blocked = gettime();
      return 0;
    }

    if(var_0 _id_0547::_id_73E9() > 0 && var_10 >= var_0.health && var_4 != "MOD_ARMOR") {
      var_0 _id_0547::_id_7442(1);

      if(!isDefined(var_6))
        var_6 = var_0.origin;

      var_0 _meth_8059(40, var_6, var_2, var_1, "MOD_ARMOR", var_5, var_8);
      var_0._id_5C14 = gettime();
      var_0.health = 1;

      if(isDefined(var_2)) {
        if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_heavy"))
          var_0._id_5C13 = var_2;
      }

      return 0;
    }
  }

  if(_func_0C1(var_0) && !isPlayer(var_0) && (!isDefined(var_2) || !_func_0C1(var_2) && !isPlayer(var_2))) {
    if(var_4 == "MOD_FALLING")
      return 0;

    if(var_5 == "exploder_zm_small_mp" || var_5 == "exploder_zm_large_mp")
      var_10 = int(level._id_A980 * 100 + 50);

    if(isDefined(var_2) && var_2.classname == "misc_turret" && isDefined(var_1) && !_id_0547::_id_5565(var_5, "turretweapon_ger_btry_flak38_mp_zombie")) {
      if(isDefined(var_2.modifyagentdamage))
        var_10 = var_0[[var_2.modifyagentdamage]](var_10);
      else
        var_10 = var_0.health + 1;

      if(isDefined(var_2.onagentdamage))
        var_0[[var_2.onagentdamage]](var_1);
      else {
        var_16 = 5000 * vectorNormalize(var_0.origin - var_1.origin);
        var_16 = (var_16[0], var_16[1], 5000);
        var_0._id_78D5 = var_16;
        var_0._id_78D2 = 1;
        var_0._id_78D3 = "torso_lower";
      }
    }

    var_10 = var_0 _id_053A::_id_62A6(var_10);

    if(!_id_0547::_id_580B(var_5) && _id_0547::_id_5731() && !var_0 _id_0547::_id_53DC() && var_10 != 0)
      var_10 = var_0.maxhealth + 10;
  }

  if(_func_0C1(var_0) && !isPlayer(var_0) && _func_0C1(var_2)) {
    if(!_func_2BF(var_2) && _func_26C(var_0, var_2))
      return 0;

    if(isDefined(var_0._id_0A4B) && var_0._id_0A4B == "zm_squadmate") {
      var_15 = level._id_0A50[var_2._id_0A4B]._id_29DB;

      if(isDefined(var_15))
        var_10 = int(var_10 * var_15);
    }

    if(isDefined(var_2) && isDefined(var_2.modifyagentdamage))
      var_10 = var_0[[var_2.modifyagentdamage]](var_10, var_2);
  }

  if(isDefined(var_2) && isPlayer(var_2) && _func_0C1(var_0) && !isPlayer(var_0)) {
    var_10 = _id_0586::_id_ABD6(var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8);

    if(common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
      var_17 = _id_0547::_id_AAF9(var_12, 0, 0);
      var_18 = _func_2FF(var_17, "_zm") + "_mp";

      if(isDefined(level._id_A9CB[var_18])) {
        var_19 = var_2 getplayerdata(common_scripts\utility::_id_46A8(), "weaponBuildKits", var_18, "bossupgrade");

        if(isDefined(var_19) && var_19)
          var_10 = var_10 * 1.1;
      }
    }

    if(getdvarint("spv_zm_difficulty_enabled", 0) == 1 && !common_scripts\utility::_id_562E(level.nolevelup[var_5]))
      var_10 = maps\mp\zombies\_zombies_progression::zombie_shotgun_mode_bonus_damage(var_2, var_10, var_5);

    if(isDefined(level._id_62B3[var_12]))
      var_10 = [[level._id_62B3[var_12]]](var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(level._id_62B4) && isDefined(var_0._id_0A4B)) {
      if(isDefined(level._id_62B4[var_0._id_0A4B]) && isDefined(level._id_62B4[var_0._id_0A4B][var_12]))
        var_10 = [[level._id_62B4[var_0._id_0A4B][var_12]]](var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8);
    }

    if(_id_0547::_id_4BA8(var_2, var_12)) {
      var_20 = 0.2;

      if(isDefined(var_2._id_A9EB[var_12]["weapon_level_increase"]))
        var_20 = var_2._id_A9EB[var_12]["weapon_level_increase"];

      var_10 = int(var_10 + var_10 * var_20 * (var_2._id_A9EB[var_12]["level"] - 1));
    }

    var_10 = var_0 _id_62B0(var_2, var_5, var_10, var_4, var_6);

    if(isDefined(var_4) && var_4 == "MOD_MELEE" && var_10 > 0) {
      if(var_2 _meth_8545())
        var_10 = level._id_73E0;
      else if(_id_0542::attemptheavymeleekill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
        var_10 = var_0.maxhealth + 1;

        if(var_0.health > 0) {
          var_2 notify("paired_heavy_melee_kill", var_5);
          var_2 _id_0542::onplayerheavymeleekillstart(var_0, var_5);
          var_0._id_0103 = 1;
        }
      } else {
        var_10 = max(var_10, level._id_7426);
        var_10 = max(var_10, _id_1E59() / 4 + 1);
      }

      if(var_2 _id_056A::_id_4B85()) {
        var_21 = _id_1E59();
        var_10 = max(var_10, var_21 / 3 + 1);
        var_10 = var_10 + level._id_7484;
      }

      if(issubstr(var_5, "razergun")) {
        if(var_2 _meth_8661()) {
          if(var_2 _id_056A::_id_4B85())
            var_10 = max(var_10, _id_1E59() * 3 + level._id_7484);
          else
            var_10 = max(var_10, _id_1E59() * 3);
        } else
          var_10 = var_10 + 1000;
      }

      if(var_2 _id_0547::_id_4BA7("specialty_class_finishing_blow_zm") && var_0.health <= var_0.maxhealth / 2) {
        var_10 = var_10 * 2.0;
        var_2 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_finishing_blow_zm");
      }

      if(isDefined(var_0._id_14EB)) {
        var_10 = var_10 * 4;
        var_0._id_14EB = undefined;
      }
    }

    var_10 = var_2 _id_32C5(var_10, var_4);
    var_10 = var_0 _id_65CA(var_5, var_10, var_8, var_4);
    var_10 = var_0 _id_9CF9(var_5, var_10, var_8, var_4);

    if(common_scripts\utility::_id_562E(var_0._id_50D9))
      var_10 = var_10 * 2;

    if(isDefined(level._id_ABEE)) {
      if(isDefined(level._id_5BF9) && level._id_5BF9 == 1 && _id_0547::_id_577E(var_2))
        var_10 = var_10 * 4;
    }

    if(var_2 _id_0547::_id_4BA7("specialty_class_discipline_zm")) {
      var_22 = var_2 _meth_8178();

      if(isDefined(var_1) && isDefined(var_1._id_3C1D))
        var_22 = var_1._id_3C1D;

      if(!_id_0547::_id_577E(var_2)) {
        switch (var_22) {
          case "crouch":
            var_10 = var_10 * 1.1;
            var_2 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_discipline_zm");
            break;
          case "prone":
            var_10 = var_10 * 1.2;
            var_2 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_discipline_zm");
            break;
          default:
            break;
        }
      }
    }

    if(var_2 _id_0547::_id_4BA7("specialty_class_lucky_crit_zm")) {
      if(var_0[[var_0 maps\mp\agents\_agent_utility::_id_0A59("is_hit_weak_point")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9)) {
        var_23 = _func_0A3(1.0);

        if(var_23 < 0.075) {
          var_0.luckycrit = 1;
          var_24 = _id_1E59() + 1;

          if(common_scripts\utility::_id_562E(var_0.lucky_crit_nerf))
            var_24 = 0;

          var_10 = max(var_10 * 2.0, var_24);
          var_2 _meth_866C(&"trigger_mod_proc", 1, "specialty_class_lucky_crit_zm");
        }
      }
    }

    if(var_2 _id_0547::_id_4BA7("specialty_class_gungho_zm")) {
      if(issubstr(var_5, "winchester1897") || issubstr(var_5, "walther") || issubstr(var_5, "model21") || issubstr(var_5, "m30") || issubstr(var_5, "blunderbuss"))
        var_10 = var_10 * 1.25;
    }

    if(isDefined(var_2) && common_scripts\utility::_id_562E(var_2.indamagebuffzone) && isPlayer(var_2)) {
      if(isDefined(level.damagebuffzonemultiplier))
        var_10 = var_10 * level.damagebuffzonemultiplier;
      else
        var_10 = var_10 * 1.5;
    }

    var_10 = var_0 _id_053B::_id_62A6(var_10, var_2, var_4);
    var_10 = var_0 _id_0539::_id_62A6(var_10, var_2, var_4);
    var_10 = var_0 _id_053A::_id_62A6(var_10);
    var_10 = var_0 _id_0538::_id_62A6(var_10, var_2, var_8);
    var_10 = var_0 _id_0537::_id_62A6(var_10, var_1, var_2, var_4, var_5);

    if(common_scripts\utility::_id_562E(level.nodamagescalingweapons[var_5]))
      var_10 = var_3;

    if(!_id_0547::_id_580B(var_5) && _id_0547::_id_5731() && !var_0 _id_0547::_id_53DC() && var_10 != 0) {
      if(isDefined(level.modifyweapondamageoninstakill) && isDefined(level.modifyweapondamageoninstakill[var_5]))
        var_10 = [[level.modifyweapondamageoninstakill[var_5]]](var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8);
      else
        var_10 = var_0.maxhealth + 10;
    }

    if(common_scripts\utility::_id_562E(var_0.zmdemigod))
      var_10 = _func_0AF(var_10, var_0.health - 1);

    if(var_0 _id_0547::_id_AC70())
      return 0;

    if(var_0 _id_0547::_id_AC59(var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8)) {
      var_0 thread _id_0547::_id_AC19(var_0, var_2, var_10, var_4, var_5, var_6, var_7, var_8);
      return 0;
    }

    if(!_id_0547::_id_5774(var_0))
      var_2 _id_47AD(var_0, var_10, var_4, var_5, var_6, var_7, var_8, 0);
  }

  if(isPlayer(var_0)) {
    var_0 _id_054E::_id_72A3(var_2, var_10, var_4);

    if(isDefined(var_2) && _func_0C1(var_2) && _func_2BF(var_2)) {
      var_0._id_5C14 = gettime();

      if(var_2._id_0A4B == "zombie_heavy")
        var_0._id_5C13 = var_2;
    }
  } else if(_func_0C1(var_0) && _func_2BF(var_0))
    var_0 _id_054E::_id_ABCD(var_2, var_10);

  return int(var_10);
}

_id_5736(var_0, var_1) {
  var_2 = 1000;
  var_1._id_1F52 = 1;

  if(isDefined(var_0._id_5C13) && var_1 == var_0._id_5C13 && gettime() - var_0._id_5C14 < var_2) {
    var_1._id_1F52 = undefined;
    return 1;
  }
}

_id_32C5(var_0, var_1) {
  if(!maps\mp\_utility::isbulletdamage(var_1))
    return var_0;

  if(isDefined(self._id_6F66) && isDefined(self._id_6F66["doubletap"]))
    var_0 = var_0 * 2;

  return var_0;
}

_id_62B0(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 == "MOD_IMPACT" && !issubstr(var_1, "throwingknife")) {
    if(var_0 _id_0547::_id_4BA7("specialty_class_fast_hands_zm"))
      var_2 = var_2 * 1.5;

    return var_2;
  }

  if(isDefined(var_1) && var_1 == "repulsor_zombie_mp") {
    if(_id_0547::_id_53DC())
      return 0;

    if(isDefined(self._id_0A4B) && issubstr(self._id_0A4B, "ranged_elite_soldier_goliath"))
      return 0;

    var_5 = 0;

    foreach(var_7 in level._id_0A50) {
      var_8 = _id_1E59(var_7, level._id_A980);

      if(var_8 > var_5)
        var_5 = var_8;
    }

    return var_5 + 1;
  }

  var_10 = 1;

  if(_id_0547::_id_585C(var_1) || _id_0546::_id_56E6(var_1)) {
    if(issubstr(var_1, "throwingknife"))
      var_2 = max(var_2, 2.5 * _id_1E59() + 1);
    else
      var_2 = common_scripts\utility::_id_98E7(level._id_A980 > 0, level._id_A980, 1) * var_10 * _func_0A4(100, 200);

    if(isDefined(level._id_62B1))
      var_2 = [[level._id_62B1]](var_0, var_1, var_2, var_4);

    if(isDefined(self._id_0A4B) && isDefined(level._id_62A9) && isDefined(level._id_62A9[self._id_0A4B]))
      var_2 = [[level._id_62A9[self._id_0A4B]]](var_1, var_2, var_4);

    if(var_0 _id_0547::_id_4BA7("specialty_class_fast_hands_zm"))
      var_2 = var_2 * 1.5;
  }

  return var_2;
}

_id_65CA(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(self._id_4B6E) && maps\mp\_utility::_id_570A(var_0, var_2, var_3))
    var_1 = int(var_1 * 0.5);

  if(common_scripts\utility::_id_562E(self._id_4B53) && !maps\mp\_utility::_id_570A(var_0, var_2, var_3))
    var_1 = int(var_1 * 0.5);

  return var_1;
}

_id_9CF9(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 == "trap_sniper_zm_mp") {
    if(common_scripts\utility::_id_24A6()) {
      var_1 = self.health + 10;

      if(isDefined(self.maxhealth))
        var_1 = self.maxhealth + 10;
    } else {
      var_1 = int(self.health * 0.5);

      if(isDefined(self.maxhealth))
        var_1 = int(self.maxhealth * 0.5);
    }

    if(_id_0547::_id_580A())
      var_1 = int(var_1 * 0.05);
  }

  if(isDefined(var_0) && var_0 == "zombie_trap_turret_mp") {
    if(_id_0547::_id_580A())
      var_1 = int(var_1 * 0.05);
  }

  return var_1;
}

_id_47AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = maps\mp\_utility::_id_570A(var_3, var_6, var_2, self);
  var_9 = common_scripts\utility::_id_562E(var_0._id_0103);
  var_10 = maps\mp\_utility::_id_5755(var_2) || var_2 == "MOD_IMPACT";
  var_11 = var_1 >= var_0.health;
  var_12 = maps\mp\_utility::iskillstreakweapon(var_3);
  var_13 = _id_0547::_id_580B(var_3);
  var_14 = _id_0547::_id_57AC(var_3);
  var_15 = _id_0547::_id_5752(var_3);
  var_16 = undefined;
  var_17 = undefined;

  if(var_8) {
    self._id_0090++;
    maps\mp\_utility::setpersstat("extrascore1", self._id_0090);
  }

  if(_id_0547::_id_577E(self)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level.zerorewardweapons[var_3])) {
    return;
  }
  if(var_10 && var_6 == "shield") {
    return;
  }
  if(var_0._id_0A4B == "zombie_fireman" && !var_11) {
    return;
  }
  if(var_3 == "turretweapon_ger_btry_flak38_mp_zombie") {
    return;
  }
  if(isDefined(var_0.is_fellow_human) && var_0.is_fellow_human) {
    return;
  }
  var_18 = undefined;

  if(var_11) {
    var_18 = "kill_limb";

    if(var_8 && !var_13) {
      var_18 = "kill_head";
      self._id_4BF7++;

      if(maps\mp\_utility::_id_4431(var_3) == self._id_76D8)
        self._id_A9BA[self._id_76D9]._id_4BF9 = self._id_A9BA[self._id_76D9]._id_4BF9 + 1;
      else {
        var_19 = _id_0547::_id_4837(self, var_3);

        if(var_19 == -1) {
          self._id_76D8 = "";
          self._id_76D9 = -1;
        } else {
          self._id_A9BA[var_19]._id_4BF9 = self._id_A9BA[var_19]._id_4BF9 + 1;
          self._id_76D8 = maps\mp\_utility::_id_4431(var_3);
          self._id_76D9 = var_19;
        }
      }
    }

    if(var_9 && !var_13) {
      var_18 = "kill_HeavyMelee";
      self._id_60EC++;
      var_20 = randomint(100);

      if(var_20 >= 66) {
        var_21 = self _meth_82D4("primary");

        foreach(var_23 in var_21) {
          if(common_scripts\utility::_id_562E(level.nobonusammoreward[var_23])) {
            continue;
          }
          var_24 = _func_1A3(var_23);
          var_25 = self getweaponammostock(var_23);
          self setweaponammostock(var_23, var_25 + var_24);
        }

        self notify("heavyMeleeClip_earned");
        var_18 = "kill_HeavyMelee";
        thread maps\mp\gametypes\_hud_message::_id_9102("zombie_heavy_melee_ammo_clip");
      } else if(var_20 < 66 && var_20 >= 33) {
        var_27 = self _meth_834A();
        var_28 = self getoffhandsecondaryclass();
        var_29 = [var_27];

        foreach(var_31 in var_29) {
          if(var_31 == "none" || var_31 == "zom_moonorb_grenade_emp_zm" || var_31 == "zom_moonorb_grenade_zm" || var_31 == "zom_hammer_grenade_zm") {
            continue;
          }
          var_32 = _func_1A3(var_31);
          self setweaponammoclip(var_31, self getweaponammoclip(var_31) + 1);
          var_18 = "kill_HeavyMelee";
          thread maps\mp\gametypes\_hud_message::_id_9102("zombie_heavy_melee_extra_lethal");
          break;
        }
      } else if(var_20 < 33 && var_20 >= 0) {
        var_18 = "kill_HeavyMeleeBonus";
        thread maps\mp\gametypes\_hud_message::_id_9102("zombie_heavy_melee_extra_jolts");
      } else
        var_18 = "kill_HeavyMelee";
    }

    if(var_15)
      var_18 = "kill_melee_aoe";
    else if(var_10 && !var_13 && !var_9) {
      var_18 = "kill_melee";
      self._id_60EC++;
    } else {
      if(_id_568C(var_3, var_6, var_2, self))
        var_18 = "kill_body";

      if(var_12)
        var_18 = "kill_streak";

      if(var_14)
        var_18 = "kill_reward_trap";
      else if(var_13)
        var_18 = "kill_trap";

      if(isDefined(level._id_47AF))
        var_18 = [[level._id_47AF]](var_18, var_3);
    }

    if(var_10 && !var_13 && (!isDefined(var_0._id_6B53) || var_0._id_6B53)) {
      if(_id_0547::_id_4BA7("specialty_class_mugger_zm")) {
        var_17 = 20;
        self _meth_866C(&"trigger_mod_proc", 1, "specialty_class_mugger_zm");
      }
    }

    if(var_0._id_0A4B == "zombie_fireman")
      var_18 = "kill_fireman";
    else if(var_0._id_0A4B == "zombie_heavy")
      var_18 = "kill_follower";
  } else {
    if(var_12) {
      return;
    }
    if(var_13) {
      return;
    }
    var_18 = "damage_body";

    if(var_8 && (isDefined(var_3) && !maps\mp\_utility::iskillstreakweapon(var_3)))
      var_18 = "damage_head";

    if(_id_0547::_id_56D0(var_3))
      var_18 = "damage_over_time";

    if(!_id_73BC(var_3, var_0))
      return;
  }

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun) && var_10 && !var_9 && common_scripts\utility::_id_562E(level.zmb_sg_no_extra_jolts_for_melee))
    var_16 = 100;

  _id_47AE(var_18, var_16, undefined, var_17);

  if(var_18 == "kill_fireman") {
    foreach(var_35 in level.players) {
      if(var_35 != self && !_id_0547::_id_577E(var_35))
        var_35 _id_47AE("kill_fireman_assist");
    }
  }

  if(var_18 == "kill_limb" || var_18 == "kill_body" || var_18 == "kill_head" || var_18 == "kill_melee" || var_18 == "kill_fireman" || var_18 == "kill_follower")
    _id_47C7(var_18);
}

_id_47C7(var_0) {
  switch (var_0) {
    case "kill_body":
    case "kill_limb":
      var_1 = "body";
      break;
    case "kill_head":
      var_1 = "headshot";
      break;
    case "kill_melee":
      var_1 = "melee";
      break;
    case "kill_follower":
      var_1 = "heavy";
      break;
    case "kill_fireman":
      var_1 = "superheavy";
      break;
    case "kill_trap":
      var_1 = "trap";
      break;
    default:
      var_1 = "body";
      break;
  }

  var_2 = self;
  var_2 _id_054C::_id_AC23(var_1);
}

_id_73BC(var_0, var_1) {
  if(issubstr(var_0, "iw5_em1zm_mp") || var_0 == "turretheadenergy_mp") {
    if(isDefined(self._id_66C0) && gettime() < self._id_66C0)
      return 0;

    self._id_66C0 = gettime() + 200.0;
  }

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun) && common_scripts\utility::_id_562E(level.zmb_sg_disable_jolts_for_damage))
    return 0;

  if(isDefined(level._id_73BD) && ![[level._id_73BD]](var_0, var_1))
    return 0;

  return 1;
}

_id_568C(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    if(isDefined(var_3._id_0117)) {
      if(var_3._id_003B == "script_vehicle")
        return 0;

      if(var_3._id_003B == "misc_turret")
        return 0;

      if(var_3._id_003B == "script_model")
        return 0;
    }

    if(isDefined(var_3._id_0A4B)) {
      if(var_3._id_0A4B == "dog")
        return 0;
    }
  }

  var_4 = var_1 == "torso_upper" || var_1 == "right_arm_upper" || var_1 == "left_arm_upper" || var_1 == "gun" || var_1 == "torso_lower";
  return var_4 && !maps\mp\_utility::_id_5755(var_2) && var_2 != "MOD_IMPACT" && !maps\mp\_utility::_id_56DF(var_0);
}

_id_47AE(var_0, var_1, var_2, var_3) {
  var_4 = level._id_7541[var_0];

  if(isDefined(var_3)) {
    if(isDefined(var_4))
      var_4 = var_4 + var_3;

    if(isDefined(var_1))
      var_1 = var_1 + var_3;
  }

  _id_054B::_id_6B84(var_4, var_0, var_1);

  if(isDefined(var_1))
    var_4 = var_1;

  if(!var_4) {
    return;
  }
  if(common_scripts\utility::_id_562E(level._id_2F6C)) {
    return;
  }
  if(maps\mp\_utility::gameflag("double_points"))
    var_4 = int(var_4 * 2);

  if(isDefined(level.eventpointmultiplier)) {
    var_4 = int(var_4 * level.eventpointmultiplier);

    if(var_4 < 5)
      var_4 = 5;
    else if(var_4 > 5 && var_4 < 10)
      var_4 = 10;
    else if(var_4 > 10 && var_4 < 15)
      var_4 = 15;
  }

  if(isDefined(var_2) && var_2) {
    var_5 = common_scripts\utility::_id_9AAD(var_4);
    var_5 = _func_2BE(var_5);
  }

  if(issubstr(var_0, "kill_") || issubstr(var_0, "damage_"))
    self.zombiepointsearned = self.zombiepointsearned + var_4;

  _id_4798(var_4);
}

_id_1F32(var_0, var_1) {
  if(var_0 > _id_4480(self)) {
    if(!isDefined(var_1) || !var_1)
      _id_3011(self);

    return 0;
  }

  if(isDefined(self._id_74B9) && self._id_74B9) {
    if(!isDefined(var_1) || !var_1)
      _id_3011(self);

    return 0;
  }

  return 1;
}

_id_11C2(var_0, var_1, var_2, var_3) {
  if(var_0 == 0)
    return 1;

  if(!_id_1F32(var_0, var_1))
    return 0;

  _id_90F5(var_0, var_2);

  if(!common_scripts\utility::_id_562E(var_3)) {
    if(_id_0575::_id_4B8A())
      thread _id_0575::_id_A22F(var_0);
  }

  return 1;
}

_id_3011(var_0) {
  var_0 _meth_860F("zmb_ui_purchase_fail", var_0);
  _id_0555::_id_83DD("poor", var_0);
}

_id_63C8(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    if(var_0._id_7545.size > 0) {
      var_0 _meth_82FF("ui_zm_award_points", var_0._id_7545[var_0._id_7545.size - 1]);
      var_0._id_7545 = _id_7CE6(var_0._id_7545);
    }

    waitframe();
  }
}

_id_7CE6(var_0) {
  var_1 = [];
  var_2 = var_0.size - 1;

  if(var_2 > 100)
    var_2 = 100;

  for(var_3 = 0; var_3 < var_2; var_3++)
    var_1[var_3] = var_0[var_3];

  return var_1;
}

_id_60AF(var_0) {
  if(_func_0C1(self))
    return 0;

  if(!isDefined(var_0) || var_0 == "none")
    return 0;

  if(var_0 == "teslagun_zm_blood" || var_0 == "teslagun_zm_death" || var_0 == "teslagun_zm_moon" || var_0 == "teslagun_zm_storm")
    return 0;

  var_1 = _func_05F(var_0);

  if(issubstr(var_1, "shovel"))
    return 0;

  return 1;
}

_id_34B8(var_0, var_1, var_2) {}

_id_A958() {
  self endon("death");
  self._id_0117 endon("disconnect");

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);

    if(var_0 == self._id_0117) {
      if(_id_1F64(var_0)) {
        break;
      } else
        wait 0.25;
    }
  }

  _id_0548::_id_A7D6(var_0, self._id_9BBB);
  var_0 thread maps\mp\gametypes\_hud_message::_id_9102("zombie_tombstome");
  var_0 playlocalsound("zmb_pickup_general");
  self._id_9D65 delete();
  self delete();
}

_id_1F64(var_0) {
  if(_id_0547::_id_577E(var_0))
    return 0;

  if(isDefined(var_0._id_74B9) && var_0._id_74B9)
    return 0;

  return 1;
}

_id_7D05(var_0) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_0))
    self._id_0117 common_scripts\utility::_id_A70A("started_spawnPlayer", "disconnect");

  wait 52;
  thread _id_930D();
  wait 8;

  if(!isDefined(self)) {
    return;
  }
  self._id_9D65 delete();
  self delete();
}

_id_930D() {
  self endon("trigger");
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self._id_0117)) {
    return;
  }
  self._id_0117 endon("death");
  self._id_0117 endon("disconnect");

  for(;;) {
    self _meth_805C();
    wait 0.25;
    self _meth_8005(self._id_0117);
    wait 0.25;
  }
}

_id_6AE2(var_0) {
  if(var_0 != level._id_3772)
    _id_0553::_id_AC1F();
}

_id_872E() {
  level._id_629B["allies"] = maps\mp\gametypes\_class::_id_44B4();
  level._id_629B["allies"]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(0, 1);
  level._id_629B["allies"]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(0, 1);
}

_id_5264() {
  while(!isDefined(level._id_947C))
    waitframe();

  level._id_3887 = common_scripts\utility::_id_46B7("evac_point", "targetname");
}

_id_3656() {
  var_0 = self;

  for(var_1 = 0; var_1 < 10; var_1++)
    _id_0547::_id_ABCA(var_0, var_1);
}

_id_7FE3() {
  _id_A79D();

  if(!common_scripts\utility::_id_562E(level._id_3230))
    level thread maps\mp\_utility::_id_6F74(::_id_3656);

  level.gamehasstarted = 1;
  level thread _id_054E::_id_714C();

  if(common_scripts\utility::_id_562E(level._id_ABDA)) {
    level waittill("zombies_manual_start");
    level thread _id_7E57();
  }

  if(!isDefined(level.zmb_match_countdown_time) && level common_scripts\utility::_id_3C77("flag_rounds_unpaused"))
    _id_7FAB();
  else if(isDefined(level.zmb_match_countdown_time))
    wait(level.zmb_match_countdown_time);

  level._id_AC28 = 1;

  if(_func_3C4() && getdvarint("2161"))
    level waittill("forever");

  level thread _id_056D::_id_7FE1();

  for(;;) {
    _id_A1A0();

    while(_id_0547::_id_585E())
      waitframe();

    if(isDefined(level._id_AC3B))
      [[level._id_AC3B]]();

    common_scripts\utility::_id_3C9F("flag_rounds_unpaused");
    _id_7FC8(level._id_A980);
    level notify("zombie_wave_started");
    level._id_AC11 = 1;
    _id_08BA(level._id_A980);
    _id_056D::_id_A6DC(level._id_A980);
    level notify("zombie_wave_ended");
    level._id_AC11 = 0;
    var_0 = maps\mp\_utility::_id_4571();

    if(var_0 == "mp_zombie_nest_01") {
      if(level._id_A980 == 25)
        level._id_400E[level._id_400E.size] = ["raven_set 2 1", "all"];

      if(level._id_A980 == 30) {
        level._id_400E[level._id_400E.size] = ["survivalist_set 0 1", "all"];
        level._id_400E[level._id_400E.size] = ["survivalist_set 1 1", "all"];

        if(!common_scripts\utility::_id_562E(level._id_75FD))
          level._id_400E[level._id_400E.size] = ["survivalist_set 2 1", "all"];

        level._id_400E[level._id_400E.size] = ["survivalist_set 3 1", "all"];
        var_1 = 1;

        foreach(var_3 in level.players) {
          if(!isDefined(var_3._id_5F7C) || var_3._id_5F7C == 0)
            var_1 = 0;
        }

        if(common_scripts\utility::_id_562E(var_1))
          level._id_400E[level._id_400E.size] = ["survivalist_set 4 1", "all"];
      }

      if(level._id_A980 == 20 && !_id_053F::_id_328A()) {
        level._id_400E[level._id_400E.size] = ["mountain_man_set 0 1", "all"];
        level._id_400E[level._id_400E.size] = ["mountain_man_set 1 1", "all"];
      }
    } else if(var_0 == "mp_zombie_training") {
      if(level._id_A980 == 25) {
        level._id_400E[level._id_400E.size] = ["mountain_man_set 2 1", "all"];
        level._id_400E[level._id_400E.size] = ["mountain_man_set 3 1", "all"];
        level._id_400E[level._id_400E.size] = ["mountain_man_set 4 1", "all"];
      }
    }

    _id_7FC7();
  }
}

_id_08BA(var_0) {
  foreach(var_2 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
    if(var_2._id_901F <= var_0)
      var_2 thread _id_053C::_id_4F7F("wave advanced", 0);
  }
}

_id_4B0A() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_begin");

    if(level._id_A980 > level._id_7F20)
      _func_3A8(1);

    level._id_2FDD = [];
    level._id_66BF = 0;
    _func_035("4696", 0);

    foreach(var_1 in level.players) {
      var_1 _id_0378::_id_8D8A();
      var_2 = "";

      if(!var_1 _meth_829E())
        var_2 = " not ";
    }
  }
}

_id_4ADB() {
  var_0 = level common_scripts\utility::_id_A717("game_ended");
  _id_0547::_id_AABF();
}

_id_4DF4() {}

_id_7FAB() {
  thread _id_7FC6(10);
  wait 10;
}

get_round_begin_notify(var_0) {
  return "round" + var_0 + "begin";
}

_id_A1A0() {
  level._id_A980++;
  level._id_A98C = gettime();
  level notify("waveupdate");
  level notify(get_round_begin_notify(level._id_A980));
  level._id_ACC3++;
  level._id_60A9 = _id_457B();
  level._id_6F4A = _id_4600();
  level._id_2958 = 0;
  level._id_609C = _func_0AF(500, level._id_A980 * 50);
  _id_1E54();

  if(level._id_A980 > level._id_7F20)
    _func_3A8(1);

  _id_47B7();
  var_0 = _id_0547::_id_AC4B(undefined, "wave");
  var_0 _id_0547::_id_AC44("waveCounter", level._id_A980);
  var_0 _id_0547::_id_AC44("maxRepairReward", level._id_6093);
  var_0 _id_0547::_id_AC4D();
}

_id_47B7() {
  var_0 = undefined;
  var_1 = maps\mp\_utility::_id_4571();

  switch (var_1) {
    case "mp_zombie_lab":
      var_0 = "DLC1_";
      break;
    case "mp_zombie_brg":
      var_0 = "DLC2_";
      break;
    case "mp_zombie_ark":
      var_0 = "DLC3_";
      break;
    default:
      return;
  }

  switch (level._id_A980) {
    case 10:
      var_0 = var_0 + "ZOMBIE_ROUND10";
      break;
    case 25:
      if(var_1 == "mp_zombie_lab") {
        var_0 = var_0 + "ZOMBIE_ROUND30";
        break;
      } else if(var_1 == "mp_zombie_brg") {
        var_0 = var_0 + "ZOMBIE_ROUND25";
        break;
      } else
        return;

      break;
    case 30:
      if(var_1 == "mp_zombie_ark")
        var_0 = var_0 + "ZOMBIE_ROUND30";
      else
        return;

      break;
    default:
      return;
  }

  _id_47A8(var_0);
}

applyhealthcap(var_0, var_1) {
  var_2 = var_1._id_4C07;

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0 > var_2)
    var_0 = var_2;

  return var_0;
}

getzombietotalhealthscale(var_0, var_1) {
  var_2 = var_0._id_4C12;

  if(!isDefined(var_2))
    return 1;

  var_3 = var_1 - 1;

  if(var_3 <= 0)
    return var_2;

  var_4 = var_0.per_extra_player_health_scale;

  if(!isDefined(var_4))
    return var_2;

  var_2 = var_2 * (1 + var_3 * var_4);
  return var_2;
}

_id_1E59(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = _id_0547::_id_0A51("zombie_generic");

  if(isDefined(var_0.overridehealth))
    return int(var_0.overridehealth);

  if(!isDefined(var_1))
    var_1 = level._id_A980;

  if(isDefined(level.wave_health_offset))
    var_1 = var_1 + level.wave_health_offset;

  if(!isDefined(level.wave_healths))
    level.wave_healths = [];

  var_2 = level.wave_healths[var_1];

  if(!isDefined(var_2)) {
    var_3 = 150;
    var_4 = 100;
    var_5 = 0.08;

    for(var_6 = 2; var_6 <= var_1; var_6++) {
      if(var_6 >= 10) {
        var_7 = var_3;
        var_3 = var_3 + int(var_3 * var_5);

        if(var_3 < var_7) {
          var_3 = var_7;
          break;
        }

        continue;
      }

      var_3 = int(var_3 + var_4);
    }

    var_2 = var_3;
    level.wave_healths[var_1] = var_2;
  }

  var_8 = 0;

  if(isDefined(level.players))
    var_8 = level.players.size;

  var_9 = getzombietotalhealthscale(var_0, var_8);
  var_10 = var_2 * var_9;

  if(var_9 < 1 || var_10 > var_2)
    var_2 = var_10;

  var_2 = applyhealthcap(var_2, var_0);
  return int(var_2);
}

_id_7FC6(var_0) {
  var_1 = 0;
  level thread _id_4ACF();
  level endon("zombies_skip_round_intermission");

  if(var_0 < 5) {
    level notify("zombie_round_countdown_started");
    var_1 = 1;
  }

  while(var_0 > 0) {
    while(_id_0547::_id_585E())
      waitframe();

    _func_032("ui_zm_round_countdown", var_0);
    var_0--;
    wait 1;

    if(!var_1 && var_0 < 5) {
      level notify("zombie_round_countdown_started");
      var_1 = 1;
    }
  }

  level notify("zombie_round_countdown_ended");
  _id_7F14();
}

_id_7F14() {
  _func_032("ui_zm_round_countdown", 0);
}

_id_4ACF() {
  level endon("zombie_round_countdown_ended");
  level waittill("zombies_skip_round_intermission");
  _id_7F14();
}

splashdoublexp() {
  foreach(var_1 in level.players) {
    if(!isDefined(var_1.pers["hasSeenDoubleXPSplashes"]) || !var_1.pers["hasSeenDoubleXPSplashes"]) {
      if(isDefined(level.zmxpscale) && level.zmxpscale > 1)
        var_1 thread maps\mp\gametypes\_hud_message::_id_9102("double_rank_xp_zm");

      var_1.pers["hasSeenDoubleXPSplashes"] = 1;
    }
  }
}

_id_7FC8(var_0) {
  splashdoublexp();

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
    if(isDefined(level.zmb_sg_round_start_func))
      level._id_7F2A = [[level.zmb_sg_round_start_func]]();
    else
      level._id_7F2A = "normal";
  } else {
    level._id_7F24 = level._id_7F24 - 1;

    if(level._id_7F24 == 0) {
      level._id_7F2A = "zombie_dog";
      thread _id_31F6();
    } else
      level._id_7F2A = "normal";
  }

  if(isDefined(level._id_7F22[level._id_7F2A]))
    [[level._id_7F22[level._id_7F2A]]]();

  if(isDefined(level.roundstartfuncgeneric))
    [[level.roundstartfuncgeneric]]();

  level._id_7F23 = maps\mp\gametypes\_gamelogic::_id_44F8();
  _func_032("ui_zm_round_start", level._id_7F23 * 1000);

  if(isDefined(level.zmb_round_over_override))
    [[level.zmb_round_over_override]](var_0);
  else
    _func_032("ui_zm_round_number", int(_func_0AF(var_0, 9999)));

  _func_032("ui_zm_round_type", _id_0547::_id_466A(level._id_7F2A));
  _id_0554::_id_20CB("round_" + level._id_7F2A);
  level _id_0547::_id_7B34(var_0 - 1);
}

get_round_complete_notify(var_0) {
  return "round" + var_0 + "complete";
}

_id_7FC7() {
  while(_id_0547::_id_585E())
    waitframe();

  level notify("round complete");
  level notify(get_round_complete_notify(level._id_A980));
  thread _id_0554::_id_20CB("round_end");
  thread _id_0554::_id_20CB("round_intermission");
  level thread _id_7E57();

  foreach(var_1 in level.players)
  var_1._id_7D10 = 0;

  if(common_scripts\utility::_id_562E(level.iszombiesshotgun)) {
    if(isDefined(level.zmb_sg_round_end_func))
      [[level.zmb_sg_round_end_func]](level._id_7F2A);
  }

  if(isDefined(level.roundendfuncgeneric))
    [[level.roundendfuncgeneric]]();

  if(isDefined(level._id_7F18[level._id_7F2A]))
    [[level._id_7F18[level._id_7F2A]]]();

  _id_0586::_id_478A();
  level _id_0547::_id_7B33(level._id_A980 - 1);
  var_3 = level._id_A980;

  if(level._id_A980 > 20)
    var_3 = 21;

  var_4 = "round" + var_3;

  foreach(var_1 in level.players)
  var_1 _id_054C::_id_AC23(var_4);

  var_7 = 20;

  if(isDefined(level._id_7F1B))
    var_7 = level._id_7F1B;

  thread _id_7FC6(var_7);
  level endon("zombies_skip_round_intermission");
  wait(var_7);
}

_id_7E57() {
  foreach(var_1 in level.players)
  _id_7E56(var_1);
}

_id_7E56(var_0) {
  if(var_0.sessionstate == "spectator" || var_0.sessionstate == "dead") {
    var_1 = "ui_zm_character_" + var_0.characterclientindex + "_alive";
    _func_032(var_1, 1);
    var_0 thread _id_0553::_id_7E59();
  } else if(_id_0547::_id_577E(var_0))
    var_0 notify("revive_trigger");

  if(_id_0547::_id_577D(var_0))
    var_0 notify("cured", 0);
}

_id_6FC8(var_0) {
  if(!common_scripts\utility::_id_562E(level._id_6FC8)) {
    return;
  }
  var_1 = maps\mp\gametypes\_gamelogic::_id_44F8();
  var_2 = var_1 - int(_func_033("ui_zm_round_start") / 1000);
}

_id_6FD1(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::_id_562E(var_3) && level._id_2958 == level._id_60A9;
  var_5 = _id_0547::_id_AC4B(var_0, "pickupspawn");
  var_5 _id_0547::_id_AC48("pickup_name", var_1);
  var_5 _id_0547::_id_AC48("pickup_reason", var_2);
  var_5 _id_0547::_id_AC42("pickup_last_in_round", var_4);
  var_5 _id_0547::_id_AC4A();
  var_5 _id_0547::_id_AC4D();
}

_id_20B0(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_1F4F)) {
    return;
  }
  if(isDefined(level._id_1F4F[level._id_7F2A]) && ![[level._id_1F4F[level._id_7F2A]]](var_0)) {
    var_4 = 0;

    if(!var_4)
      return;
  }

  if(level._id_2958 >= level._id_60A9) {
    return;
  }
  if(isDefined(level._id_1F71)) {
    if(![[level._id_1F71]](var_0, var_1, var_2, var_3))
      return 0;
  }

  if(isDefined(var_2) && var_2 == "MOD_SUICIDE") {
    return;
  }
  if(common_scripts\utility::_id_562E(var_1._id_5A3D)) {
    return;
  }
  if(common_scripts\utility::_id_562E(var_1._id_6734)) {
    return;
  }
  if(isDefined(var_3) && _id_0547::_id_580B(var_3)) {
    return;
  }
  if(isDefined(level._id_6733) && level._id_6733 == 1) {
    return;
  }
  if(isDefined(level._id_AC80) && !_id_055A::_id_578A(var_1.origin, 1)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(var_1._id_4BA0)) {
    return;
  }
  level endon("game_ended");
  var_5 = randomint(100);
  var_6 = "none";

  if(var_5 > level._id_6F4A) {
    if(!level._id_34AA) {
      return;
    }
    var_6 = "score";
  } else
    var_6 = "random";

  var_7 = _id_3B9B(var_1.origin);

  if(!isDefined(var_7)) {
    return;
  }
  if(var_6 == "score")
    level._id_34AA = 0;

  var_8 = common_scripts\utility::_id_98E7(level._id_34AA, "true ", "false ");
  var_9 = common_scripts\utility::_id_98E7(var_5 > level._id_6F4A, "false ", "true ");
  var_10 = "Scheduled: " + var_8 + "Chance: " + var_9 + "(" + var_5 + "<=" + level._id_6F4A + ")";
  var_11 = _id_83B5();
  _id_281C(var_11, var_7, var_10, 1, 1);
  level._id_2958++;
  var_1._id_349E = 1;
}

_id_3B9B(var_0) {
  var_1 = 80;
  var_2 = var_1 * var_1;
  var_3 = 40000;
  setdvarifuninitialized("debugPickupDrop", 0);
  level notify("findValidPickupSpot");
  var_4 = [];
  var_5 = [];
  var_6 = [];

  foreach(var_8 in level.players) {
    if(maps\mp\_utility::isreallyalive(var_8)) {
      var_9 = _func_211(var_0, var_8.origin);

      if(var_9 < var_2)
        var_4[var_4.size] = var_8;

      if(var_9 < var_3)
        var_5[var_5.size] = var_8;

      var_6[var_6.size] = var_8;
    }
  }

  if(var_4.size == 0)
    return var_0;

  var_11 = common_scripts\utility::_id_A2BE();

  foreach(var_8 in var_5)
  var_11 = var_11 + var_8.origin;

  var_11 = var_11 / var_5.size;
  var_11 = (var_11[0], var_11[1], var_0[2]);
  var_14 = var_11 - var_0;
  var_15 = length(var_14);
  var_16 = var_14 * -1 * (var_1 / var_15);
  var_17 = _func_2E1(var_0 + var_16);

  if(_id_991E(var_17, var_5, var_2, var_0))
    return var_17;

  var_18 = var_0;

  if(!_func_2DC(var_0, var_17))
    var_18 = var_17;

  var_19 = _func_2E0(var_18, 140, 16);

  foreach(var_21 in var_19) {
    if(_id_991E(var_21, var_6, var_2))
      return var_21;
  }

  return undefined;
}

_id_991E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_6 in var_1) {
    if(_func_211(var_6.origin, var_0) < var_2) {
      var_4 = 0;
      break;
    }
  }

  if(!isDefined(var_4) && !isDefined(var_3))
    var_4 = 1;

  if(!isDefined(var_4))
    var_4 = !_func_2DC(var_3, var_0);

  return var_4;
}

_id_281D(var_0, var_1, var_2) {
  if(isDefined(level._id_AC80) && _id_055A::_id_578A(var_1 + (0, 0, 1)))
    _id_281C(var_0, var_1, var_2);
  else {
    var_3 = common_scripts\utility::random(level.players);
    [[level._id_6FBF[var_0]["func"]]](var_3);
  }
}

_id_281C(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_562E(var_4))
    level._id_6FD0 = var_0;

  if(!isDefined(var_2))
    var_2 = "<undefined>";

  if(!isDefined(var_3))
    var_3 = 1;

  _id_6FC8(var_0 + " Dropped - " + var_2);
  _id_6FD1(var_1, var_0, var_2, var_4);
  var_5[0] = _id_4608();
  var_6 = level._id_6FBF[var_0]["fx"];
  var_7 = level._id_6FBF[var_0]["model"];

  if(isDefined(var_6))
    var_5[0] setModel("dlc_dogtags_zombie_invisible");
  else
    var_5[0] setModel(var_7);

  if(common_scripts\utility::_id_562E(level._id_6FBF[var_0]["outline"]))
    var_5[0] _meth_83FE(0, 0);

  var_8 = var_5[0]._id_9D65;
  var_9 = _id_04D1::_id_2837(level._id_746E, var_8, var_5, (0, 0, 16), 1);
  var_10 = (0, 0, 22);

  if(isDefined(level._id_6FBF[var_0]["posOffset"]))
    var_10 = level._id_6FBF[var_0]["posOffset"];

  var_11 = var_1 + var_10;
  var_9._id_6FCE = var_0;
  var_9._id_28D4 = var_11;
  var_9._id_9D65.origin = var_11;
  var_9._id_A582[0].origin = var_11;
  var_9.origin = var_11;
  var_12 = level._id_6FBF[var_0]["icon"];

  if(isDefined(var_12) && var_12 != "")
    var_9._id_4FF6 = var_8 _id_0479::_id_869E(level._id_746E, var_12, (0, 0, 30), 14, 14, undefined, undefined, undefined, undefined, undefined, 0);

  var_9 _id_04D1::_id_8A5A(0);
  _id_0380::_id_2889("zmb_pickup_spawn_strt", undefined, var_9.origin);
  var_9._id_8CFF = _id_0380::_id_2889("zmb_pickup_spawn_lp", undefined, var_9.origin);
  var_9 thread _id_2CE9();
  var_9._id_6BBF = level._id_6FBF[var_0]["func"];

  if(isDefined(var_6)) {
    var_10 = (0, 0, 0);

    if(isDefined(level._id_6FBF[var_0]["posOffset"]))
      var_10 = level._id_6FBF[var_0]["posOffset"];

    var_9._id_A582[0] _meth_8276("s2_zmb_holo_icon_spin");
    var_9._id_A582[0].origin = var_1 + var_10;
    var_9.fx = common_scripts\utility::_id_44F5(var_6);
    var_9._id_3F81 = "j_dogtag";
    _func_147(var_9.fx, var_9._id_A582[0], var_9._id_3F81);
    _func_147(level._effect["pickup_base"], var_9._id_A582[0], var_9._id_3F81);
  } else {
    var_13 = (0, 0, 2000);
    var_14 = 2000;
    var_15 = 0.1;
    var_16 = level._id_6FBF[var_0]["phys_overrides"];

    if(isDefined(var_16)) {
      if(isDefined(var_16._id_6F9A))
        var_13 = var_16._id_6F9A;

      if(isDefined(var_16._id_6F9C))
        var_14 = var_16._id_6F9C;

      if(isDefined(var_16._id_6F9B))
        var_15 = var_16._id_6F9B;
    }

    var_9._id_A582[0] _meth_84E0();
    var_9._id_A582[0] _meth_80B0(var_9._id_A582[0]._id_6A55);
    var_9._id_A582[0] _meth_8272(var_9._id_A582[0].origin, var_13, var_14, var_15);
    var_9 thread _id_6FD9();
  }

  checkforuiproc("specialty_class_resourceful_zm");

  if(var_3)
    var_9 thread _id_6FD7();

  return var_9;
}

checkforuiproc(var_0) {
  if(isDefined(level.players)) {
    foreach(var_2 in level.players) {
      if(var_2 _id_0547::_id_4BA7(var_0))
        var_2 _meth_866C(&"trigger_mod_proc", 1, var_0);
    }
  }
}

_id_2CE9() {
  var_0 = level._id_6FBF[self._id_6FCE]["delayPickUp"];

  if(common_scripts\utility::_id_562E(var_0)) {
    _id_04D1::_id_0C30("none");
    wait 1;
  }

  _id_04D1::_id_0C30("friendly");
}

_id_6FD9() {
  self endon("deleted");
  var_0 = self._id_9D65;
  var_1 = self._id_A582[0];

  while(isDefined(var_1)) {
    var_0.origin = var_1.origin;
    waitframe();
  }
}

_id_6FC6() {
  level endon("game_ended");
  self endon("deleted");
  self endon("death");
  var_0 = self;
  var_1 = self._id_28D4;
  var_2 = self._id_28D4 + (0, 0, 12);
  var_3 = 1.25;

  if(isDefined(self._id_A582) && isDefined(self._id_A582[0]))
    var_0 = self._id_A582[0];

  for(;;) {
    var_0 _meth_82B1(var_2, var_3, 0.15, 0.15);
    var_0 _meth_82BA(180, var_3);
    wait(var_3);
    var_0 _meth_82B1(var_1, var_3, 0.15, 0.15);
    var_0 _meth_82BA(180, var_3);
    wait(var_3);
  }
}

_id_6FD7() {
  self endon("deleted");
  waitframe();
  var_0 = 15;
  var_1 = 0;
  var_2 = 0.1;

  while(var_1 < var_0) {
    wait(var_2);
    var_1 = var_1 + var_2;

    if(isDefined(self._id_6FD4))
      var_0 = self._id_6FD4;
  }

  var_3 = level._id_6FBF[self._id_6FCE]["extraTimeoutSecs"];

  if(isDefined(var_3))
    wait(var_3);

  thread _id_6FD5();
  thread _id_6FCA(self._id_28D4);
  var_0 = 8;
  var_1 = 0;
  var_2 = 0.1;

  while(var_1 < var_0) {
    wait(var_2);
    var_1 = var_1 + var_2;

    if(isDefined(self._id_6FCB))
      var_0 = self._id_6FCB;
  }

  playsoundatpos(self._id_28D4, "zmb_pickup_expired");
  level thread _id_7CED(self);
}

_id_6FCA(var_0) {
  var_1 = _func_351("zmb_pickup_timer", undefined, self._id_28D4);
  self waittill("deleted");
  _func_352(var_1, 0.05);
}

_id_6FD5() {
  self endon("deleted");

  for(;;) {
    if(isDefined(self.fx))
      _func_149(self.fx, self._id_A582[0], self._id_3F81);
    else if(isDefined(self._id_A582) && isDefined(self._id_A582[0]))
      self._id_A582[0] _meth_8511();

    wait 0.25;

    if(isDefined(self.fx))
      _func_147(self.fx, self._id_A582[0], self._id_3F81);
    else if(isDefined(self._id_A582) && isDefined(self._id_A582[0]))
      self._id_A582[0] _meth_805B();

    wait 0.25;
  }
}

_id_7CED(var_0) {
  var_1 = level._id_6FBF[var_0._id_6FCE]["onDestroyed"];

  if(isDefined(var_1))
    var_0[[var_1]]();

  if(!isDefined(var_0._id_A582)) {
    return;
  }
  _id_0380::_stoplocalsound(var_0._id_8CFF, 0.25);
  _id_0380::_id_2889("zmb_pickup_spawn_end", undefined, var_0.origin);
  var_0 notify("deleted");
  var_0._id_A582[0] _meth_805B();
  var_0._id_A582[0] _meth_8511();

  if(isDefined(var_0.fx)) {
    _func_148(var_0.fx, var_0._id_A582[0], var_0._id_3F81);
    _func_148(level._effect["pickup_base"], var_0._id_A582[0], var_0._id_3F81);
  }

  var_0._id_A582[0] _meth_84E0();
  var_0._id_A582[0] _meth_80B1();
  var_0._id_9D65.origin = var_0._id_9D65.origin - (0, 0, -10000);
  _id_0547::_id_A6F6();
  var_0._id_A582[0]._id_54F5 = 0;
}

_id_0DB9(var_0, var_1) {
  extra_report_powerup_collected(var_0, var_1);
  _id_8C1C("zombie_max_ammo");
  var_0 playlocalsound("zmb_pickup_general");
  level thread _id_08AE();
  var_0._id_7F08 = var_0._id_7F08 + 1;

  if(!isDefined(var_1))
    level thread _id_7CED(self);
}

_id_08AE() {
  level notify("maxAmmoPickup");

  foreach(var_1 in level.players) {
    if(_id_0547::_id_5767(var_1) && maps\mp\_utility::isreallyalive(var_1)) {
      _id_7B83(var_1);
      var_1 _id_7456();

      if(isDefined(level._id_08AF))
        var_1[[level._id_08AF]]();
    }
  }
}

_id_7B83(var_0) {
  var_1 = var_0 getweaponlistprimaries();
  var_1[var_1.size] = var_0 _meth_834A();

  foreach(var_3 in var_1) {
    if(var_3 == "none") {
      continue;
    }
    if(_id_0547::_id_57AF(var_3) || _id_0547::_id_5862(var_3) || _id_0547::iszombieconsumableweapon(var_3)) {
      continue;
    }
    if(level.weaponmaxammofuncs.size > 0) {
      var_4 = _func_05F(var_3);

      if(isDefined(level.weaponmaxammofuncs[var_4])) {
        var_5 = var_0[[level.weaponmaxammofuncs[var_4]]](var_3);

        if(var_5)
          continue;
      }
    }

    if(_id_0547::_id_585C(var_3)) {
      _id_0548::_id_3AC1(var_0, var_3);
      continue;
    }

    var_6 = var_0 _meth_82F6();
    var_0 givemaxammo(var_3);

    if(var_6 == 0) {
      wait 0.01;

      while(var_0 _meth_833A())
        waitframe();

      var_0 givemaxammo(var_3);
    } else
      _id_0548::_id_3AC1(var_0, var_3);

    if(issubstr(var_3, "dlcgun1")) {
      var_7 = _func_1A3(var_3);
      var_0 setweaponammoclip(var_3, var_7, "right");
    }
  }

  var_9 = var_0 getoffhandsecondaryclass();
  var_3 = var_9;

  if(var_9 == "none") {
    if(common_scripts\utility::_id_562E(var_0._id_4B73))
      var_3 = "jack_in_box_decoy_zm";
  }

  if(var_3 != "none") {
    var_5 = 0;

    if(level.weaponmaxammofuncs.size > 0) {
      if(isDefined(level.weaponmaxammofuncs[var_3]))
        var_5 = var_0[[level.weaponmaxammofuncs[var_3]]](var_3);
    }

    if(!var_5) {
      var_0 setoffhandsecondaryclass(var_3);
      var_0 _id_0586::_id_078C(var_3);
      _id_0548::_id_3AC1(var_0, var_3);
    }
  }

  if(_id_0547::_id_577E(var_0))
    var_0 _id_0553::_id_7B86();
}

_id_53DD(var_0, var_1) {
  extra_report_powerup_collected(var_0, var_1);
  _id_8C1C("zombie_insta_kill");
  var_0 playlocalsound("zmb_pickup_overdrive");
  level thread _id_08AC();
  var_0._id_7F07 = var_0._id_7F07 + 1;

  if(!isDefined(var_1))
    level thread _id_7CED(self);
}

_id_7B8F() {
  var_0 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 _id_054D::_id_A135();
  }
}

_id_08AC() {
  level notify("instaKillPickup");
  level endon("game_ended");
  level endon("instaKillPickup");
  maps\mp\_utility::gameflagset("insta_kill");
  _id_7B8F();
  _id_329C("ui_zm_instakill", level._id_53DE);
  maps\mp\_utility::gameflagclear("insta_kill");
  _id_7B8F();
}

_id_32C8(var_0, var_1) {
  extra_report_powerup_collected(var_0, var_1);
  _id_8C1C("zombie_double_points");
  var_0 playlocalsound("zmb_pickup_general");
  level thread _id_08AA();
  var_0._id_7F04 = var_0._id_7F04 + 1;

  if(!isDefined(var_1))
    level thread _id_7CED(self);
}

_id_08AA() {
  level notify("doublePointsPickup");
  level endon("game_ended");
  level endon("doublePointsPickup");
  maps\mp\_utility::gameflagset("double_points");
  _id_329C("ui_zm_doublepoints", level._id_32C9);
  maps\mp\_utility::gameflagclear("double_points");
}

_id_3C1A(var_0) {
  _id_8C1C("zombie_fire_sale");
  var_0 playlocalsound("zmb_pickup_general");
  level thread _id_08AB();
  level thread _id_7CED(self);
}

_id_08AB() {
  level notify("fireSalePickup");
  level endon("game_ended");
  level endon("fireSalePickup");

  if(!maps\mp\_utility::gameflag("fire_sale")) {
    maps\mp\_utility::gameflagset("fire_sale");

    foreach(var_1 in level._id_5F74)
    level thread _id_9ED2(var_1);
  }

  _id_329C("ui_zm_firesale", level._id_3C1C);
  maps\mp\_utility::gameflagclear("fire_sale");

  foreach(var_1 in level._id_5F74)
  level thread _id_9ECB(var_1);
}

_id_9ED2(var_0) {
  while(var_0._id_56C7)
    waitframe();

  if(var_0._id_08BE)
    _id_0548::_id_08D7(var_0);

  if(!var_0._id_08BE)
    level thread _id_0548::_id_A922(var_0, 1);
  else if(var_0._id_5759) {
    while(var_0._id_5759)
      waitframe();

    level thread _id_0548::_id_A922(var_0, 1);
  }
}

_id_9ECB(var_0) {
  while(var_0._id_56C7)
    waitframe();

  if(!var_0._id_08BE)
    var_0 notify("fireSaleOver");
  else
    _id_0548::_id_08D7(var_0);
}

_id_685F(var_0, var_1) {
  extra_report_powerup_collected(var_0, var_1);
  _id_8C1C("zombie_nuke");
  _func_17F(0.35, 0.95, var_0.origin, 128);
  playFX(common_scripts\utility::_id_44F5("nuke_blast"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
  var_0 playlocalsound("zmb_pickup_apocalypse");
  level thread _id_08B2(var_0.origin);
  var_0._id_7F0B = var_0._id_7F0B + 1;

  if(!isDefined(var_1))
    level thread _id_7CED(self);
}

_id_08B2(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 _id_47AE("nuke");

  if(!common_scripts\utility::_id_562E(var_1))
    var_1 = 0;

  wait 0.2;
  var_5 = maps\mp\agents\_agent_utility::_id_43FD("all");
  var_5 = _func_1AC(var_5, var_0);

  foreach(var_7 in var_5) {
    if(var_7._id_000A == level._id_746E) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_7.longdeath)) {
      continue;
    }
    if(!var_1) {
      if(var_7 _id_0547::_id_53DC()) {
        if(common_scripts\utility::_id_562E(var_7._id_57E8)) {
          continue;
        }
        if(!common_scripts\utility::_id_562E(var_7._id_561D)) {
          var_7 thread _id_0547::_id_7D1A("nuke_stun", [var_0]);
          continue;
        }
      }
    }

    wait 0.1;

    if(isalive(var_7)) {
      var_8 = "MOD_EXPLOSIVE";

      if(!_func_2BF(var_7))
        var_8 = "MOD_ENERGY";

      var_7._id_5A3D = 1;
      var_7 _meth_8059(var_7.health, var_7.origin, undefined, undefined, var_8, level._id_69A6);
    }
  }
}

_id_6865(var_0) {
  if(common_scripts\utility::_id_562E(self._id_57E8)) {
    return;
  }
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "nuke_stun");

  if(!maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
    var_1 = undefined;
    self._id_55C9 = 1;
    var_2 = maps\mp\agents\humanoid\_humanoid_util::_id_29CB(var_0);
    var_3 = _func_0DD(var_2 - self.angles[1]);

    if(_func_0AE(var_3) < 45)
      var_1 = "pain_knockback_front";
    else if(_func_0AE(var_3) > 135)
      var_1 = "pain_knockback_back";
    else if(var_3 > 0)
      var_1 = "pain_knockback_right";
    else
      var_1 = "pain_knockback_left";

    var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
    var_5 = self _meth_83DB(var_4);
    var_6 = randomint(var_5);
    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_6, 1, "stun_anim");
    self _meth_839A(1, 1);
  }

  if(self._id_0A4B == "zombie_fireman") {
    var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("scripted_fire_scream");
    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, 0, 1, "stun_anim");
  }

  if(common_scripts\utility::_id_562E(self._id_561D))
    self waittill("stunning_burst_end");

  self notify("nuke_stun_end");
  _id_AC34();
}

_id_6863() {
  wait 5;

  if(common_scripts\utility::_id_562E(self._id_561D))
    self waittill("stunning_burst_end");

  self notify("nuke_stun_end");
}

_id_AC33() {
  self endon("death");
  self endon("nuke_stun_end");
  var_0 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("stun_hold");
  var_1 = self _meth_83DB(var_0);

  for(;;) {
    var_2 = randomint(var_1);
    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, var_2, 1, "stun_anim");

    if(self._id_0A4B == "zombie_fireman") {
      break;
    }
  }
}

_id_6864(var_0) {
  _id_AC34();
}

_id_AC34() {
  self endon("death");

  if(isalive(self)) {
    self._id_55C9 = 0;
    self _meth_83A2(0);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "nuke_stun");
  }
}

_id_0840(var_0, var_1) {
  extra_report_powerup_collected(var_0, var_1);
  _id_8C1C("zombie_ability_fill");
  var_0 playlocalsound("zmb_pickup_general");
  level thread _id_054B::_id_4789();
  var_0._id_7F0D = var_0._id_7F0D + 1;

  if(!isDefined(var_1))
    level thread _id_7CED(self);
}

_id_329C(var_0, var_1) {
  var_2 = 30;

  if(isDefined(var_1))
    var_2 = var_1;

  _func_032(var_0, gettime() + var_2 * 1000);
  wait(var_2);
  var_3 = _id_054A::_id_0633();

  if(isDefined(var_3) && var_3 > 0) {
    _func_032(var_0, gettime() + var_3 * 1000);
    wait(var_3);
  }
}

_id_8C1C(var_0) {
  foreach(var_2 in level.players) {
    if(_id_0547::_id_5767(var_2) && maps\mp\_utility::isreallyalive(var_2))
      var_2 thread maps\mp\gametypes\_hud_message::_id_9102(var_0);
  }
}

_id_AC6F() {
  if(isDefined(level._id_AC6F)) {
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 0;
    var_0.alpha = 1.0;
    var_0._id_00C6 = "fullscreen";
    var_0._id_01CA = "fullscreen";
    var_0.sort = 3;
    var_0 setshader(level._id_AC6F, 640, 480);
  }
}

_id_742C() {
  self endon("disconnect");
  self _meth_82FF("ui_energy_ammo", 1);

  for(;;) {
    self waittill("weapon_change", var_0);
    waitframe();
  }
}

_id_73D8(var_0) {
  self endon("disconnect");

  if(!issubstr(var_0, "iw5_em1zm_mp")) {
    if(_id_0547::_id_73F7() && _id_0547::_id_73EA() <= 0 && !_id_73F6() && !_id_0547::_id_577E(self))
      _id_0547::_id_73C6();

    return;
  }

  _id_7455();
  self setweaponammostock(var_0, 0);
  thread _id_7459();
  self waittill("weapon_change");
  self _meth_812B(1);
  self _meth_84A7("fire_em1_weapon", "+attack");
  self _meth_84A7("fire_em1_weapon", "+attack_akimbo_accessible");
}

_id_73F6() {
  var_0 = self getweaponlistprimaries();

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "iw5_em1zm_mp"))
      return 1;
  }

  return 0;
}

_id_7481() {
  var_0 = _id_44B1(1);
  var_1 = _id_0547::_id_73EA();
  var_2 = var_1 / var_0;
  self _meth_82FF("ui_energy_ammo", var_2);
}

_id_7459() {
  self endon("death");
  self endon("disconnect");
  self endon("weapon_change");
  self _meth_82E1("fire_em1_weapon", "+attack");
  self _meth_82E1("fire_em1_weapon", "+attack_akimbo_accessible");
  var_0 = _id_0547::_id_73EA();
  _id_7481();

  if(var_0 <= 0)
    self _meth_812B(0);

  for(;;) {
    if(!self _meth_8342())
      self waittill("fire_em1_weapon");

    var_1 = self getcurrentweapon();

    if(self _meth_833B() || !issubstr(var_1, "iw5_em1zm_mp") || !self _meth_8127() || self _meth_84DE()) {
      waitframe();
      continue;
    }

    var_0 = _id_0547::_id_73EA();
    _id_7481();

    if(var_0 <= 0) {
      var_2 = self getweaponlistprimaries();
      var_3 = maps\mp\_utility::_id_4431(var_2[0]);

      if(var_3 != "iw5_em1zm") {
        self _meth_812B(0);
        _id_0586::_id_078E(var_2[0]);
        waitframe();
        continue;
      }

      if(var_2.size > 1) {
        var_3 = maps\mp\_utility::_id_4431(var_2[1]);

        if(var_3 != "iw5_em1zm") {
          _id_0586::_id_078E(var_2[1]);
          self _meth_812B(0);
          waitframe();
          continue;
        }
      }

      self _meth_812B(0);
      waitframe();
      continue;
    }

    waitframe();

    if(maps\mp\_utility::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo")) {
      continue;
    }
    var_0 = _id_0547::_id_73EA();
    _id_0547::_id_743F(var_0 - 1);
  }
}

_id_7455() {
  if(!isDefined(self.pers["em1Ammo"])) {
    self.pers["em1Ammo"] = spawnStruct();
    _id_7456();
    self _meth_812B(1);
  }
}

_id_44B1(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = 1.0;

  if(!var_0 && self _meth_82AA("specialty_stockpile", 1))
    var_1 = var_1 * 1.2;

  return 1800.0 * var_1;
}

_id_7456() {
  if(isDefined(self.pers["em1Ammo"])) {
    var_0 = _id_44B1();
    self.pers["em1Ammo"]._id_0D95 = var_0;
    _id_7481();
    self _meth_812B(1);
  }
}

_id_7437() {
  self notify("postSlamDeathWaiter");
  self endon("postSlamDeathWaiter");
  self endon("postSlamTimedOut");
  self waittill("death");
  _id_7439();
}

_id_7439() {
  maps\mp\_utility::_id_73AF(1, "postSlam");
}

_id_7438() {
  self notify("postSlamDisableBoost");
  self endon("postSlamDisableBoost");
  self endon("death");
  self endon("disconnect");
  var_0 = 2;
  var_1 = gettime() + var_0 * 1000;
  maps\mp\_utility::_id_73AF(0, "postSlam");
  thread _id_7437();
  wait(var_0);
  self notify("postSlamTimedOut");
  _id_7439();
}

_id_7428() {
  self endon("disconnect");
  self._id_390A = 0;
  self._id_3908 = 0;
  self._id_390C = 0;
  self._id_3909 = 0;
  self._id_390D = 0;

  for(;;) {
    var_0 = common_scripts\utility::_id_A716("exo_boost", "ground_slam", "exo_dodge", "exo_slide");
    self._id_390A = gettime();

    switch (var_0) {
      case "exo_boost":
        self._id_3908 = gettime();
        break;
      case "ground_slam":
        self._id_390C = gettime();
        break;
      case "exo_dodge":
        self._id_3909 = gettime();
        break;
      case "exo_slide":
        self._id_390D = gettime();
        break;
    }
  }
}

_id_47A8(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_3 = [var_1];
  else
    var_3 = level.players;

  if(!isDefined(var_2))
    var_2 = 1;

  foreach(var_1 in var_3) {
    if(common_scripts\utility::_id_562E(var_2) && (!isDefined(var_1.joinedearlyrounds) || !var_1.joinedearlyrounds)) {
      continue;
    }
    var_1 _id_47C8(var_0);
  }
}

_id_47C8(var_0) {
  if(!isDefined(self.alreadyloggedfirstpartytrophy))
    self.alreadyloggedfirstpartytrophy = [];

  if(!isDefined(self.alreadyloggedfirstpartytrophy[var_0])) {
    self.alreadyloggedfirstpartytrophy[var_0] = 1;
    self _meth_8681("telemetry_trophy_event", ["trophy", ["trophy_name", var_0, "level_time_ms", gettime()]]);
  }

  self _meth_80F0(var_0);
}

_id_1E54() {
  var_0 = 1;

  if(isDefined(level._id_7544))
    level._id_7543 = level._id_7544;
  else if(level._id_A980 <= 9)
    level._id_7543 = var_0;
  else
    var_1 = level._id_A980 - 9;

  level._id_7541["damage_body"] = int(10 * level._id_7543);
  level._id_7541["damage_head"] = int(10 * level._id_7543);
  level._id_7541["kill_trap"] = int(10 * level._id_7543);
  level._id_7541["kill_limb"] = int(50 * level._id_7543);
  level._id_7541["kill_streak"] = int(40 * level._id_7543);
  level._id_7541["kill_body"] = int(60 * level._id_7543);
  level._id_7541["kill_head"] = int(100 * level._id_7543);
  level._id_7541["kill_melee"] = int(130 * level._id_7543);
  level._id_7541["kill_reward_trap"] = int(60 * level._id_7543);
  level._id_7541["power_on"] = int(100 * level._id_7543);
  level._id_7541["atm"] = int(100 * level._id_7543);
  level._id_7541["atm_jackpot"] = int(10 * level._id_7543);
  level._id_7541["cure"] = int(100 * level._id_7543);
  level._id_7541["crate"] = int(500 * level._id_7543);
  level._id_7541["nuke"] = int(400 * level._id_7543);
  level._id_7541["reward_bronze"] = int(500 * level._id_7543);
  level._id_7541["reward_silver"] = int(1000 * level._id_7543);
  level._id_7541["reward_gold"] = int(2000 * level._id_7543);
  level._id_7541["breach_fix"] = int(200 * level._id_7543);
  level._id_7541["repair"] = int(10 * level._id_7543);
  level._id_7541["perfectRound"] = int(100 * level._id_7543);
  level._id_7541["mercReward"] = int(5 * level._id_7543);
  level._id_7541["damage_over_time"] = int(5 * level._id_7543);
}

_id_7429() {}

_id_31F6() {
  level waittill("round complete");
  _id_0DB9(level.players[0], 1);

  foreach(var_1 in level.players) {
    if(!common_scripts\utility::_id_562E(var_1._id_4DCB)) {
      if(!isDefined(var_1._id_4DCB))
        var_1._id_4DCB = 0;

      if(!isDefined(var_1._id_31AB))
        var_1._id_31AB = 1;
      else
        var_1._id_31AB++;

      if(var_1._id_31AB >= 3 && maps\mp\_utility::_id_4571() == "mp_zombie_nest_01")
        var_1 _id_47C8("ZM_KNUCKLE");

      continue;
    }

    var_1._id_4DCB = 0;
    var_1._id_31AB = 0;
  }

  level._id_7F24 = 5;
}

_id_AC54(var_0, var_1) {
  level._id_3B5C = undefined;
  var_2 = getdvarint("1316", 0) == 1;

  if(isDefined(level._id_8C7C))
    var_2 = level._id_8C7C;

  if(!var_2) {
    foreach(var_4 in level.players) {
      if(isDefined(var_4._id_2583) || var_4.pers["team"] == "spectator" && !var_4 _meth_8436()) {
        continue;
      }
      var_4 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_0, 0, var_1, 1);
    }
  }

  level notify("game_win", var_0);
  maps\mp\gametypes\_gamelogic::_id_A792();
  level notify("give_match_bonus");
  maps\mp\gametypes\_gamelogic::_id_A792();

  if(!var_2 && _id_746B()) {
    if(!isDefined(level._id_7DD2))
      level._id_7DD2 = 1;

    game["gamestarted"] = undefined;
  }

  if(maps\mp\_utility::iszombiegameshattermode())
    wait 8.0;

  wait 8.0;

  foreach(var_4 in level.players)
  var_4 _meth_82FF("ui_round_end", 0);
}

_id_746B() {
  var_0 = undefined;

  if(!getdvarint("zombiesAllowVoteToRestart", 0))
    var_0 = 0;

  if(isDefined(var_0) && getDvar("1673") == "mp_zombie_training") {
    if(isDefined(level._id_7DD2))
      var_0 = level._id_7DD2;
    else
      var_0 = 1;
  }

  if(isDefined(var_0)) {
    wait 6;
    return var_0;
  }

  var_1 = 10;
  wait 4;

  foreach(var_3 in level.players) {
    var_3.hacky_vote_ui = _func_19B(var_3);
    var_3.hacky_vote_ui.x = 0;
    var_3.hacky_vote_ui.y = 150;
    var_3.hacky_vote_ui.alignx = "center";
    var_3.hacky_vote_ui.aligny = "middle";
    var_3.hacky_vote_ui._id_00C6 = "center";
    var_3.hacky_vote_ui._id_01CA = "middle";
    var_3.hacky_vote_ui.fontscale = 1.3;
    var_3.hacky_vote_ui.alpha = 1.0;
    var_3.hacky_vote_ui.sort = 99999;
    var_3.hacky_vote_ui.foreground = 1;
    var_3.hacky_vote_ui settext(&"ZOMBIES_PRESS_TO_PLAY_AGAIN");
  }

  var_5 = [];

  for(var_6 = 0; var_6 < var_1; var_6 = var_6 + 0.05) {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && var_3 _meth_8341())
        var_5[var_3 _meth_8271()] = 1;
    }

    var_9 = 0;

    foreach(var_3 in level.players) {
      if(isDefined(var_3) && isDefined(var_5[var_3 _meth_8271()])) {
        var_9++;

        if(level.players.size > 1)
          var_3.hacky_vote_ui settext(&"ZOMBIES_WAITING_FOR_OTHER_PLAYERS");

        continue;
      }
    }

    if(var_9 == level.players.size) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3) && isDefined(var_3.hacky_vote_ui))
          var_3.hacky_vote_ui settext(&"ZOMBIES_RESTARTING");
      }

      return 1;
    }

    waitframe();
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3))
      var_3.hacky_vote_ui settext(&"ZOMBIES_GOING_TO_LOBBY");
  }

  return 0;
}

_id_AC55(var_0, var_1, var_2, var_3) {}

_id_446E() {
  var_0 = self getplayerdata(common_scripts\utility::_id_46A8(), "selectedLoadout", "ability");
  setmatchdata("players", self.clientid, "loadout", "special", var_0);
  var_1 = maps\mp\_utility::_id_452B(var_0);

  if(!_id_0547::_id_5823(var_1))
    var_1 = "role_ability_stunning_burst_zm";

  return var_1;
}

_id_061B() {
  var_0 = self getentitynumber();
  return var_0 < 256 || var_0 > 2045;
}

_id_ABF6() {
  if(!_id_0547::_id_AC4C()) {
    return;
  }
  var_0 = 1024;
  var_1 = 1790;
  var_2 = 5;

  while(!isDefined(level._id_947C))
    waitframe();

  var_3 = 0;
  var_4 = var_0;
  var_5 = 0;
  var_6 = var_1;
  var_7 = gettime() + var_2 / 2 * 20;

  while(!common_scripts\utility::_id_562E(level.gameended)) {
    waitframe();

    if(gettime() - var_7 >= var_2 * 1000)
      var_7 = gettime();
    else
      continue;

    var_8 = 0;
    var_9 = 0;
    var_10 = getEntArray();

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(var_10[var_11] _meth_85CC())
        var_8++;

      if(!var_10[var_11] _id_061B())
        var_9++;
    }

    if(var_8 > var_3)
      var_3 = var_8;

    if(var_8 < var_4)
      var_4 = var_8;

    if(var_9 > var_5)
      var_5 = var_9;

    if(var_9 < var_6)
      var_6 = var_9;

    waitframe();
    var_12 = _id_0547::_id_AC4B(undefined, "snapshot_ents");
    var_12 _id_0547::_id_AC44("count", var_8);
    var_12 _id_0547::_id_AC44("count_high_water_mark", var_3);
    var_12 _id_0547::_id_AC44("count_low_water_mark", var_4);
    var_12 _id_0547::_id_AC44("server_count", var_9);
    var_12 _id_0547::_id_AC44("server_count_high_water_mark", var_5);
    var_12 _id_0547::_id_AC44("server_count_low_water_mark", var_6);
    var_12 _id_0547::_id_AC4D();
  }

  var_12 = _id_0547::_id_AC4B(undefined, "snapshot_ent_stats");
  var_12 _id_0547::_id_AC44("count_high_water_mark", var_3);
  var_12 _id_0547::_id_AC44("count_low_water_mark", var_4);
  var_12 _id_0547::_id_AC44("server_count_high_water_mark", var_5);
  var_12 _id_0547::_id_AC44("server_count_low_water_mark", var_6);
  var_12 _id_0547::_id_AC4D();
}

_id_73CD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(_id_0547::_id_AC4C()) {
    var_11 = undefined;
    var_12 = undefined;
    var_13 = undefined;
    var_14 = undefined;

    if(isDefined(var_1)) {
      var_11 = var_1._id_0A4B;
      var_12 = var_1.origin;
      var_13 = _func_0AA(clamp(vectordot(anglesToForward(var_2.angles), vectorNormalize(common_scripts\utility::_id_3D5D(var_1.origin - var_2.origin))), -1, 1));
    }

    var_15 = var_2 _meth_833D();
    var_16 = length(var_15);
    var_17 = var_2 _meth_82F9();
    var_18 = length(var_17) > 0.5 && var_16 < 5;
    var_19 = undefined;

    if(isDefined(var_0))
      var_19 = var_0.origin;

    var_20 = _id_0547::_id_AC4B(var_2.origin, "player_damaged");
    var_20 _id_0547::_id_AC47(var_2);
    var_20 _id_0547::_id_AC49("player_angles", var_2.angles);
    var_20 _id_0547::_id_AC48("hit_loc", var_9);
    var_20 _id_0547::_id_AC48("attacker_type", var_11);
    var_20 _id_0547::_id_AC49("attacker_pos", var_19);
    var_20 _id_0547::_id_AC44("damage", var_3);
    var_20 _id_0547::_id_AC48("weapon", var_6);
    var_20 _id_0547::_id_AC48("damage_type", var_5);
    var_20 _id_0547::_id_AC43("angle_to_attacker", var_13);
    var_20 _id_0547::_id_AC42("blocked", var_18);
    var_20 _id_0547::_id_AC43("player_speed", var_16);
    var_20 _id_0547::_id_AC49("player_stick_input", var_17);
    var_20 _id_0547::_id_AC42("player_sprinting", var_2 _meth_83DD());
    var_20 _id_0547::_id_AC42("player_reloading", var_2 _meth_833A());
    var_20 _id_0547::_id_AC48("player_weapon", var_2 getcurrentweapon());
    var_20 _id_0547::_id_AC4D();
  }
}

_id_7272() {
  var_0 = 10;
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(_func_0A3(var_0));

  for(;;) {
    var_1 = 0;

    if(_id_0547::_id_AC4C()) {
      var_2 = 0;
      var_3 = 0;
      var_4 = 0;
      var_5 = 0;
      var_6 = 0;
      var_7 = 0;
      var_8 = 0;

      foreach(var_10 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
        if(isalive(var_10)) {
          var_11 = distance(self.origin, var_10.origin);
          var_2++;
          var_5 = var_5 + var_11;
          var_8 = var_8 + length(var_10 _meth_833D());

          if(_id_054D::_id_7230(var_10)) {
            var_3++;
            var_6 = var_6 + var_11;
          }

          if(isDefined(var_10._id_0088) && var_10._id_0088 == self) {
            var_4++;
            var_7 = var_7 + var_11;
          }
        }

        var_1 = var_1 + 0.05;
        waitframe();
      }

      var_5 = var_5 / max(1, var_2);
      var_6 = var_6 / max(1, var_3);
      var_7 = var_7 / max(1, var_4);
      var_8 = var_8 / max(1, var_2);
      var_13 = 0;
      var_14 = 0;
      var_15 = 0;

      foreach(var_17 in level.players) {
        if(var_17 != self) {
          var_18 = distance(self.origin, var_17.origin);
          var_14 = var_14 + var_18;

          if(_id_054D::_id_7230(var_17)) {
            var_13++;
            var_15 = var_15 + var_18;
          }
        }
      }

      var_14 = var_14 / max(1, level.players.size - 1);
      var_15 = var_15 / max(1, level.players.size - 1);
      var_1 = var_1 + 0.05;
      waitframe();
      var_20 = _id_0547::_id_AC4B(self.origin, "player_experience");
      var_20 _id_0547::_id_AC44("zombie_count", var_2);
      var_20 _id_0547::_id_AC44("visible_zombie_count", var_3);
      var_20 _id_0547::_id_AC44("attacking_zombie_count", var_4);
      var_20 _id_0547::_id_AC43("average_distance_to_zombie", var_5);
      var_20 _id_0547::_id_AC43("average_distance_to_visible_zombie", var_6);
      var_20 _id_0547::_id_AC43("average_distance_to_attacking_zombie", var_7);
      var_20 _id_0547::_id_AC42("last_stand", _id_0547::_id_577E(self));
      var_20 _id_0547::_id_AC42("spectating", _id_0547::_id_57E1(self));
      var_20 _id_0547::_id_AC44("player_count", _id_0547::_id_45C9());
      var_20 _id_0547::_id_AC42("player_sprinting", self _meth_83DD());
      var_20 _id_0547::_id_AC42("player_reloading", self _meth_833A());
      var_20 _id_0547::_id_AC48("player_weapon", self getcurrentweapon());
      var_20 _id_0547::_id_AC44("visible_player_count", var_13);
      var_20 _id_0547::_id_AC43("average_distance_to_player", var_14);
      var_20 _id_0547::_id_AC43("average_distance_to_visible_player", var_15);
      var_20 _id_0547::_id_AC43("average_zombie_speed", var_8);
      var_20 _id_0547::_id_AC43("player_speed", length(self _meth_833D()));
      var_20 _id_0547::_id_AC4D();
    }

    wait(max(0.5, var_0 - var_1));
  }
}

_id_4AE1() {
  var_0 = 585;
  var_1 = 0.5;
  self endon("death");
  self endon("disconnect");

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 == self) {
        continue;
      }
      var_4 = distance(var_3.origin, self.origin) > var_0;
      var_5 = var_4 && !_func_07F(var_3 getEye(), self getEye(), 0, undefined);

      if(var_5) {
        var_6 = 0;

        if(_id_0547::_id_577E(var_3))
          var_6 = 1;

        var_3 _meth_8427(self, var_6, 0);
        continue;
      }

      var_3 _meth_8428(self);
    }

    wait(var_1);
  }
}

setomnvartodefault(var_0, var_1) {
  if(var_1 != _func_033(var_0))
    _func_032(var_0, var_1);
}

setclientomnvartodefault(var_0, var_1) {
  if(var_1 != self _meth_844A(var_0))
    self _meth_82FF(var_0, var_1);
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

resetclientomnvars(var_0) {
  var_0 setclientomnvartodefault("damage_feedback", "none");
  var_0 setclientomnvartodefault("send_map_load_phase", -1);
  var_0 setclientomnvartodefault("ui_minimap_location_callout", -1);
  var_0 setclientomnvartodefault("ui_minimap_antiair_state", 0);
  var_0 setclientomnvartodefault("ui_killcam_end_milliseconds", 0);
  var_0 setclientomnvartodefault("ui_killcam_killedby_id", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_killstreak", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_weapon", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_attachment1", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_attachment2", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_attachment3", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_attachment4", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_1", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_2", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_3", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_4", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_5", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_6", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_7", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_8", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_perk_9", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_division", -1);
  var_0 setclientomnvartodefault("ui_killcam_killedby_weaponReputation", 0);
  var_0 setclientomnvartodefault("ui_killcam_drawTargetBox", 0);
  var_0 setclientomnvartodefault("ui_killcam_paratrooperInsert", 0);
  var_0 setclientomnvartodefault("ui_killcam_copycat", 0);
  var_0 setclientomnvartodefault("ui_killcam_type", 0);
  var_0 setclientomnvartodefault("ui_killcam_action", 0);
  var_0 setclientomnvartodefault("ui_killcam_time_until_spawn", 0);
  var_0 setclientomnvartodefault("ui_killcam_isNemesis", 0);
  var_0 setclientomnvartodefault("ui_killcam_isFriendlyFire", 0);
  var_0 setclientomnvartodefault("ui_killcam_killsOfPlayer", 0);
  var_0 setclientomnvartodefault("ui_killcam_killsByPlayer", 0);
  var_0 setclientomnvartodefault("ui_death_details_attacker_0", -1);
  var_0 setclientomnvartodefault("ui_death_details_attacker_1", -1);
  var_0 setclientomnvartodefault("ui_death_details_attacker_2", -1);
  var_0 setclientomnvartodefault("ui_death_details_attacker_3", -1);
  var_0 setclientomnvartodefault("ui_death_details_hits_0", 0);
  var_0 setclientomnvartodefault("ui_death_details_hits_1", 0);
  var_0 setclientomnvartodefault("ui_death_details_hits_2", 0);
  var_0 setclientomnvartodefault("ui_death_details_hits_3", 0);
  var_0 setclientomnvartodefault("cam_scene_name", "unknown");
  var_0 setclientomnvartodefault("cam_scene_lead", -1);
  var_0 setclientomnvartodefault("cam_scene_support", -1);
  var_0 setclientomnvartodefault("cam_scene_lead_alt", -1);
  var_0 setclientomnvartodefault("cam_scene_support_alt", -1);
  var_0 setclientomnvartodefault("ui_splash_idx", -1);
  var_0 setclientomnvartodefault("ui_splash_killstreak_idx", -1);
  var_0 setclientomnvartodefault("ui_splash_playercard_idx", -1);
  var_0 setclientomnvartodefault("ui_splash_playercard_clientnum", -1);
  var_0 setclientomnvartodefault("ui_splash_playercard_optional_number", 0);
  var_0 setclientomnvartodefault("ui_carrying_bomb", 0);
  var_0 setclientomnvartodefault("ui_capture_icon", 0);
  var_0 setclientomnvartodefault("ui_capture_status_index", 0);
  var_0 setclientomnvartodefault("ui_capture_progress", 0);
  var_0 setclientomnvartodefault("ui_securing", 0);
  var_0 setclientomnvartodefault("ui_securing_progress", 0);
  var_0 setclientomnvartodefault("ui_light_armor", 0);
  var_0 setclientomnvartodefault("ui_session_state", "none");
  var_0 setclientomnvartodefault("ks_used", 0);
  var_0 setclientomnvartodefault("ks_acquired", 0);
  var_0 setclientomnvartodefault("ks_count1", 0);
  var_0 setclientomnvartodefault("ks_points1", 0);
  var_0 setclientomnvartodefault("ks_count2", 0);
  var_0 setclientomnvartodefault("ks_points2", 0);
  var_0 setclientomnvartodefault("ks_count3", 0);
  var_0 setclientomnvartodefault("ks_points3", 0);
  var_0 setclientomnvartodefault("ks_count4", 0);
  var_0 setclientomnvartodefault("ks_points4", 0);
  var_0 setclientomnvartodefault("ks_count_updated", 0);
  var_0 setclientomnvartodefault("ks_selectedIndex", 0);
  var_0 setclientomnvartodefault("ks_hasStreak", 0);
  var_0 setclientomnvartodefault("ks_icon0", 0);
  var_0 setclientomnvartodefault("ks_icon1", 0);
  var_0 setclientomnvartodefault("ks_icon2", 0);
  var_0 setclientomnvartodefault("ks_icon3", 0);
  var_0 setclientomnvartodefault("ks_icon4", 0);
  var_0 setclientomnvartodefault("ui_killstreak_remote", 0);
  var_0 setclientomnvartodefault("ui_hud_shake", 0);
  var_0 setclientomnvartodefault("ui_hud_static", 0);
  var_0 setclientomnvartodefault("ui_options_menu", 0);
  var_0 setclientomnvartodefault("ui_loadout_selected", -1);
  var_0 setclientomnvartodefault("ui_team_selected", -1);
  var_0 setclientomnvartodefault("ui_spectator_selected", -1);
  var_0 setclientomnvartodefault("blur_target", 0);
  var_0 setclientomnvartodefault("blur_duration_ms", 0);
  var_0 setclientomnvartodefault("ui_round_end", 0);
  var_0 setclientomnvartodefault("ui_round_end_title", 0);
  var_0 setclientomnvartodefault("ui_round_end_reason", 0);
  var_0 setclientomnvartodefault("ui_round_end_friendly_score", 0);
  var_0 setclientomnvartodefault("ui_round_end_enemy_score", 0);
  var_0 setclientomnvartodefault("ui_round_end_match_bonus", 0);
  var_0 setclientomnvartodefault("ui_rank_splash_prestige", 0);
  var_0 setclientomnvartodefault("ui_challenge_splash_idx", -1);
  var_0 setclientomnvartodefault("ui_challenge_splash_tier", 0);
  var_0 setclientomnvartodefault("ui_assault_rank_bar_progress", 0);
  var_0 setclientomnvartodefault("ui_hide_hints_hud", 0);
  var_0 setclientomnvartodefault("ui_hide_hud", 0);
  var_0 setclientomnvartodefault("ui_points_popup", -1);
  var_0 setclientomnvartodefault("ui_points_popup_event", -1);
  var_0 setclientomnvartodefault("allow_write_leaderboards", 1);
  var_0 setclientomnvartodefault("ui_use_bar_text", 0);
  var_0 setclientomnvartodefault("ui_use_bar_start_time", 0);
  var_0 setclientomnvartodefault("ui_use_bar_current_time", 0);
  var_0 setclientomnvartodefault("ui_use_bar_end_time", 0);
  var_0 setclientomnvartodefault("ui_streak_overlay_state", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_state", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_timer", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_damage", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_hits", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_distance", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_fired", 0);
  var_0 setclientomnvartodefault("ui_vlobby_round_accuracy", 0);
  var_0 setclientomnvartodefault("ui_ctf_friendly_status", 0);
  var_0 setclientomnvartodefault("ui_ctf_friendly_carrier_clientnum", -1);
  var_0 setclientomnvartodefault("ui_ctf_enemy_status", 0);
  var_0 setclientomnvartodefault("ui_ctf_enemy_carrier_clientnum", -1);
  var_0 setclientomnvartodefault("ui_ctf_status_changed", 0);
  var_0 setclientomnvartodefault("ui_light_armor_percent", 0);
  var_0 setclientomnvartodefault("ui_energy_ammo", 1);
  var_0 setclientomnvartodefault("ui_round_end_stopwatch", 0);
  var_0 setclientomnvartodefault("fov_scale", 1);
  var_0 setclientomnvartodefault("ui_disable_team_change", 0);
  var_0 setclientomnvartodefault("ui_killstreak_blackout", 0);
  var_0 setclientomnvartodefault("ui_killstreak_blackout_fade_end", 0);
  var_0 setclientomnvartodefault("ui_splash_killstreak_slot_idx", -1);
  var_0 setclientomnvartodefault("ui_zm_exo_health", 0);
  var_0 setclientomnvartodefault("ui_zm_exo_slam", 0);
  var_0 setclientomnvartodefault("ui_zm_exo_slam_next_time", 0);
  var_0 setclientomnvartodefault("ui_zm_camo", 0);
  var_0 setclientomnvartodefault("ui_zm_award_points", 0);
  var_0 setclientomnvartodefault("ui_zm_ee_int", 0);
  var_0 setclientomnvartodefault("ui_zm_ee_bool2", 0);
  var_0 setclientomnvartodefault("ui_zm_hud_static", 0);
  var_0 setclientomnvartodefault("ui_zm_perk_order", 0);
  var_0 setclientomnvartodefault("ui_zm_previous_zone_name", "unknown");
  var_0 setclientomnvartodefault("ui_zm_current_zone_name", "unknown");
  var_0 setclientomnvartodefault("ui_zm_quest_hint_0", 0);
  var_0 setclientomnvartodefault("ui_zm_quest_hint_1", 0);
  var_0 setclientomnvartodefault("ui_zm_quest_hint_2", 0);
  var_0 setclientomnvartodefault("ui_zm_step_hint_0", 0);
  var_0 setclientomnvartodefault("ui_zm_step_hint_1", 0);
  var_0 setclientomnvartodefault("ui_zm_step_hint_2", 0);
  var_0 setclientomnvartodefault("ui_zm_has_quest_item_bits_0", 0);
  var_0 setclientomnvartodefault("ui_zm_has_quest_item_bits_1", 0);
  var_0 setclientomnvartodefault("ks_selectedIndex", 0);
  var_0 setclientomnvartodefault("ui_energy_ammo", 1);
  var_0 setclientomnvartodefault("ui_zm_token_count", 0);
  var_0 setclientomnvartodefault("ui_zm_free_role_use", 0);
  var_0 setclientomnvartodefault("zm_unlimited_ammo", 0);
  var_0 setclientomnvartodefault("ui_zm_juggernog", -1);
  var_0 setclientomnvartodefault("ui_zm_fastreload", -1);
  var_0 setclientomnvartodefault("ui_zm_punchperk", -1);
  var_0 setclientomnvartodefault("ui_zm_runperk", -1);
  var_0 setclientomnvartodefault("ui_zm_quickrevive", -1);
  var_0 setclientomnvartodefault("ui_zm_electriccherry", -1);
  var_0 setclientomnvartodefault("ui_zm_doubletap", -1);
  var_0 setclientomnvartodefault("ui_hub_enable_pause", 1);
  var_0 setclientomnvartodefault("ui_show_scorestreak_training_hud", 0);
  var_0 setclientomnvartodefault("ui_show_supply_drop_selection", 0);
  var_0 setclientomnvartodefault("ui_show_hub_leaderboard", 0);
  var_0 setclientomnvartodefault("ui_onevone_show_class_menu", 0);
  var_0 setclientomnvartodefault("ui_onevone_class_1", 0);
  var_0 setclientomnvartodefault("ui_onevone_class_2", 0);
  var_0 setclientomnvartodefault("ui_onevone_class_3", 0);
  var_0 setclientomnvartodefault("ui_onevone_class_4", 0);
  var_0 setclientomnvartodefault("ui_onevone_class_5", 0);
  var_0 setclientomnvartodefault("ui_onevone_opponent_client_num", 0);
  var_0 setclientomnvartodefault("ui_hide_1v1scores", 1);
  var_0 setclientomnvartodefault("ui_show_skip_killcam", 0);
  var_0 setclientomnvartodefault("ui_hide_minimap", 0);
  var_0 setclientomnvartodefault("ui_hide_hud", 0);
  var_0 setclientomnvartodefault("ui_daily_challenge_idx", -1);
  var_0 setclientomnvartodefault("char_scene_state", 0);
  var_0 setclientomnvartodefault("ui_zm_free_ability", 0);
  var_0 setclientomnvartodefault("ui_zm_consumable_count0", 0);
  var_0 setclientomnvartodefault("ui_zm_consumable_count1", 0);
  var_0 setclientomnvartodefault("ui_zm_consumable_ref0", -1);
  var_0 setclientomnvartodefault("ui_zm_consumable_ref1", -1);
  var_0 setclientomnvartodefault("ui_zm_hud_vis_bits", 0);
  var_0 setclientomnvartodefault("ui_damage_flash", 0);
  var_0 setclientomnvartodefault("ui_fullscreen_dirt_left", 0);
  var_0 setclientomnvartodefault("ui_hub_1v1_queueposition", 0);
  var_0 setclientomnvartodefault("ui_vl_monitor_started", 0);
  var_0 setclientomnvartodefault("ui_hub_shootout_opponent_client_num", 0);
  var_0 setclientomnvartodefault("ui_hub_shootout_intro_countdown", 0);
  var_0 setclientomnvartodefault("ui_hub_in_1v1", 0);
  var_0 setclientomnvartodefault("ui_party_manipulation_enabled", 1);
  var_0 setclientomnvartodefault("ui_hub_in_theater", 0);
  var_0 setclientomnvartodefault("ui_hub_in_firingrange", 0);
  var_0 setclientomnvartodefault("ui_hub_opening_supplydrop", 0);
  var_0 setclientomnvartodefault("ui_hub_in_shootout", 0);
  var_0 setclientomnvartodefault("ui_hub_in_flakgun", 0);
  var_0 setclientomnvartodefault("ui_hub_at_vendor", 0);
  var_0 setclientomnvartodefault("ui_player_splash_id_0", -1);
  var_0 setclientomnvartodefault("ui_player_splash_id_1", -1);
  var_0 setclientomnvartodefault("ui_player_splash_id_2", -1);
  var_0 setclientomnvartodefault("ui_player_splash_id_3", -1);
  var_0 setclientomnvartodefault("ui_player_splash_id_4", -1);
  var_0 setclientomnvartodefault("ui_player_splash_id_5", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_0", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_1", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_2", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_3", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_4", -1);
  var_0 setclientomnvartodefault("ui_player_splash_param_5", -1);
  var_0 setclientomnvartodefault("ui_zm_contexthint_data", 0);
  var_0 setclientomnvartodefault("ui_zm_interaction_flags", 0);
  var_0 setclientomnvartodefault("ui_zm_interaction_data", 0);
  var_0 setclientomnvartodefault("ui_show_division_rifle_ability_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_division_smg_ability_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_division_lmg_ability_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_division_shotgun_ability_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_division_sniper_ability_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_m30_rifle_altmode_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_zk383_smg_altmode_prompt", 0);
  var_0 setclientomnvartodefault("ui_show_left_clip_ammo", 0);
  var_0 setclientomnvartodefault("ui_dragon_breath_state", 1);
  var_0 setclientomnvartodefault("ui_suppressor_state", -1);
  var_0 setclientomnvartodefault("ui_m30_rifle_state", -1);
  var_0 setclientomnvartodefault("ui_zk383_smg_state", -1);
  var_0 setclientomnvartodefault("ui_zm_can_use_consumable", 1);
  var_0 setclientomnvartodefault("ui_zm_selected_quest_item", -1);
  var_0 setclientomnvartodefault("ui_zm_owns_quest_items", 0);
  var_0 setclientomnvartodefault("ui_hub_fte_character_select", 0);
  var_0 setclientomnvartodefault("ui_show_fte_division_select", 0);
  var_0 setclientomnvartodefault("ui_fte_welcome_message_status", 0);
  var_0 setclientomnvartodefault("ui_fte_tutorial_completed", 0);
  var_0 setclientomnvartodefault("zm_blitz_items_limit", 4);
  var_0 setclientomnvartodefault("ui_hub_is_preoccupied", 0);
  var_0 setclientomnvartodefault("hub_fte_reset_intro", 0);
}

nocontrolduringcinematic() {
  self endon("disconnect");
  self endon("death");
  self freezecontrols(1);
  self _meth_812B(0);
  self _meth_8324();
  self _meth_84CB();

  while(player_is_playing_loading_cinematic())
    waitframe();

  self freezecontrols(0);
  self _meth_812B(1);
  self _meth_8325();
  self _meth_84CC();
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

  return maps\mp\_utility::_id_585F();
}

monitor_loading_cinematic_state() {
  self endon("disconnect");
  self.last_known_loading_cinematic_state = map_has_loading_cinematic();
  self.last_known_loading_cinematic_state_time = gettime();
  childthread send_loading_cinematic_state_queries();

  while(self.last_known_loading_cinematic_state) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "loading_cinematic_reply") {
      continue;
    }
    if(!var_1 && self.last_known_loading_cinematic_state)
      _func_292(self);

    self.last_known_loading_cinematic_state = var_1;
    self.last_known_loading_cinematic_state_time = gettime();
  }
}

send_loading_cinematic_state_queries() {
  while(self.last_known_loading_cinematic_state) {
    self _meth_85EF(&"loading_cinematic_query");
    wait 0.2;
  }
}

player_is_playing_loading_cinematic() {
  if(!isDefined(self.last_known_loading_cinematic_state))
    return map_has_loading_cinematic();

  if(gettime() - self.last_known_loading_cinematic_state_time > 10000)
    return 0;

  return self.last_known_loading_cinematic_state;
}

orders_and_contracts_report_event(var_0, var_1, var_2, var_3) {
  if(isDefined(level.orders_and_contracts_event_report)) {
    var_4 = get_event_reporter_struct(var_0);

    if(!isDefined(var_4)) {
      return;
    }
    if(isDefined(var_3))
      var_4[[var_4._id_1E61]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      var_4[[var_4._id_1E61]](var_1, var_2);
    else if(isDefined(var_1))
      var_4[[var_4._id_1E61]](var_1);
    else
      var_4[[var_4._id_1E61]]();
  }
}

register_addition_revive_rule(var_0, var_1, var_2) {
  if(!isDefined(level.additional_player_revive_rules))
    level.additional_player_revive_rules = [var_0];
  else
    level.additional_player_revive_rules = common_scripts\utility::_id_0F6F(level.additional_player_revive_rules, var_0);
}

get_event_reporter_struct(var_0) {
  return level.orders_and_contracts_event_report[var_0];
}

extra_report_powerup_collected(var_0, var_1) {
  if(isDefined(level.zmb_events_powerup_collected))
    [[level.zmb_events_powerup_collected]](var_0, var_1);
}