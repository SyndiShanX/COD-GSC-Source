/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2c09271b2d42994d.gsc
***********************************************/

main() {
  _id_00ED35EEACAE6139::main();
  _id_7583DAA7D1134924::main();
  _id_64475BA114D2F7D6::main();
  _id_5B8CBB172999F93C::main();
  _id_678ADBED602DA5EB::_id_534445B413445ADE();
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_47B7445B595408F7", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_565D343F31403893", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_005674A44E0D2658", 2, 0);
  level._id_37190777EEB4333F = 1;
  level._id_F4A07073EC587E25 = 0;
  level._id_D744DAB15887349D = 1;

  if(level.createfx_enabled) {
    return;
  }
  level.default_player_spawns = "boss1_start";
  level._id_CEE48B761F8CA747 = 0;
  level.skip_nav_check_on_spectate_respawn = 1;
  level.disable_start_spawn_on_navmesh = 1;
  level._id_7A9F066F79BED633 = ::_id_EFC042CA6FA12227;
  level._id_A3E60D4FD52EFC95 = 1;
  level._id_D3B90C28E1C7DBBF = 0;
  level.interactions_disabled = 1;
  level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
  _id_382959D7794736CC::_id_0636135391510B93();
  _id_165F87DC9B28463B::_id_1F763DFECFC35564();
  scripts\cp\utility::coop_mode_enable(["sp_stealth"]);
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  scripts\cp\utility::add_start("silo", undefined, _id_13FFCCF97A3E3294::_id_DB5A627EF4F05C84);
  scripts\cp\utility::add_start("silo_power", undefined, _id_13FFCCF97A3E3294::_id_7D4126296031DE02);
  scripts\cp\utility::add_start("silo_2nd_stop", undefined, _id_13FFCCF97A3E3294::_id_3A2450AF7E20A08C);
  scripts\cp\utility::add_start("silo_end", undefined, _id_13FFCCF97A3E3294::_id_ED342BB672D2B406);
  scripts\cp\utility::add_start("floor_is_lava", undefined, _id_13FFCCF97A3E3294::_id_065CD87C519857A8);
  scripts\cp\utility::add_start("floor_is_lava_power", undefined, _id_13FFCCF97A3E3294::_id_9687F16772093008);
  scripts\cp\utility::add_start("floor_is_lava_end", undefined, _id_13FFCCF97A3E3294::_id_9F0486282F27E5FA);
  scripts\cp\utility::add_start("floor_is_lava_vent", undefined, _id_13FFCCF97A3E3294::_id_C4ACB631CECF956E);
  scripts\cp\utility::add_start("subpen_raise_water_1", undefined, _id_13FFCCF97A3E3294::_id_A7CD25832CBE97B9);
  scripts\cp\utility::add_start("subpen_raise_water_2", undefined, _id_13FFCCF97A3E3294::_id_A7CD24832CBE9586);
  scripts\cp\utility::add_start("subpen_reach_catwalks", undefined, _id_13FFCCF97A3E3294::_id_A7CD23832CBE9353);
  scripts\cp\utility::add_start("subpen_saw_doors", undefined, _id_13FFCCF97A3E3294::_id_A7CD22832CBE9120);
  scripts\cp\utility::set_default_start("silo");
  setDvar("dvar_F8332F8A8CEDCA1C", 1);
  scripts\engine\utility::flag_set("interactions_initialized");
  _id_230C7BB3F08D2D78::_id_C773479E45DC40A8();
  level thread _id_34D2771929BD6022::_id_0BCD7DBE50E5AF96();
  level thread scripts\cp\intel\cp_intel::intel_init();
  level thread _id_06F5A19DA88AA4A5();
  level thread _id_1C06BEDD9980B7AF::_id_7B6E96193E81C072();
  scripts\cp_mp\utility\script_utility::registersharedfunc("turret", "movingPlatformOnPlaced", _id_382959D7794736CC::_id_27B3C857D63DC910);
}

_id_06F5A19DA88AA4A5() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level._id_FB7FD80599167F74 = spawn("script_model", (2422.5, 8666.5, 6306.5));
  level._id_FB7FD80599167F74 setModel("clip128x128x128");
  level._id_FB7FD80599167F74.angles = (0, 0, 0);
  doors = getentitylessscriptablearray(undefined, undefined, level._id_FB7FD80599167F74.origin, 256, "door");

  foreach(door in doors) {
    door scriptabledoorfreeze(1);
    door.blocked = 1;
  }

  scripts\engine\utility::flag_wait("both_players_intro_binks_complete");
  wait 5;

  foreach(door in doors) {
    door scriptabledoorfreeze(0);
    door.blocked = 0;
  }

  level._id_FB7FD80599167F74 delete();
}

_id_EFC042CA6FA12227() {
  self._id_894D1167ACE5B58C = 1;
  self._id_50BA41F491586FBF = 67108864;
}

_id_2CFEF434CE6A1C44() {
  level.custom_onspawnplayer_func = ::onplayerspawned;
  level.custom_onplayerconnect_func = ::onplayerconnect;
}

onplayerconnect(player) {}

onplayerspawned() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("falling");
  thread setup_player_stealth();
  thread _id_1C8C03372BADE56E();
  thread _id_89CCC2FA8B543D70();
  thread _id_59D8A269D3AB61AB();
  _id_1C06BEDD9980B7AF::_id_82E02994003CFFF7(self);
  scripts\cp\utility::allow_player_minimapforcedisable(1);
}

_id_89CCC2FA8B543D70() {
  self endon("death");
  self notify("ledgeHangFallLogic");
  self endon("ledgeHangFallLogic");
  _id_BDA1DE83E1856735 = 0;

  for(;;) {
    if(self isonground() || self _meth_415FE9EECA7B2E2B() || self ismantling() && _id_BDA1DE83E1856735 > 0) {
      _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("falling");
      _id_BDA1DE83E1856735 = 0;
    } else
      _id_BDA1DE83E1856735++;

    if(_id_BDA1DE83E1856735 > 15) {
      if(_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("mantle"))
        _id_3B64EB40368C1450::set("falling", "mantle", 0);
    }

    waitframe();
  }
}

_id_1C8C03372BADE56E() {
  self endon("death_or_disconnect");
  self endon("last_stand");
  level waittill("player_spawned_with_loadout");

  if(_id_7EF95BBA57DC4B82::getequipmentslotammo("primary") <= 0)
    _id_531CB1BE084314F7::br_forcegivecustompickupitem(self, "brloot_offhand_semtex", 0, 2, 0, 0);

  thread scripts\cp\execution::_id_94C333BD965E6685();
}

_id_279964C2C969DDA3() {
  level _id_2272CEA833355E09::setup_functions();
  checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

  if(isDefined(checkpoint) && checkpoint != "" && isDefined(level.registered_checkpoint_funcs[checkpoint]))
    level thread[[level.registered_checkpoint_funcs[checkpoint]]]();
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

_id_C4D555BF9485AC3B() {
  _id_D459E575257144E4();
  level thread _id_FC4803DC319A81D2();

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_01EC781F5C365546 = getdvarint("dvar_6B92186116FA2C1A", 120);
    _id_3AE8C243F1C86858 = getdvarint("dvar_72523AD696A1466C", 90);
    _id_B02AE2D8D510669A = getdvarint("dvar_F85AFB0CAFB8CEDA", 60);
  } else {
    _id_01EC781F5C365546 = getdvarint("dvar_57825A5CAF4A6BA6", 120);
    _id_3AE8C243F1C86858 = getdvarint("dvar_3C9CD8B3E1743AA8", 90);
    _id_B02AE2D8D510669A = getdvarint("dvar_1E73113AA67EC8A6", 60);
  }

  _id_1E22D314CC16F807::_id_6CCB377E839D87C4(_id_01EC781F5C365546 * 60, _id_3AE8C243F1C86858 * 60, _id_B02AE2D8D510669A * 60);
  level._id_95B8B02E43BCA8DB = _id_13FFCCF97A3E3294::_id_366AA8B098553BA0;
  scripts\cp\tripwire_cp::init();
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 0);
  scripts\cp_mp\tripwire::precachetrap("tripwire_trap_c4", "projectile_c4_v0", 0);
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_ar_mike4_mp", ["ammo_556n", "bar_ar_shorthvy_p01_mike4", "grip_vert05_p01", "fourx02", "iw9_selectsemi", "pgrip_p01", "stock_ar_p01_mike4"], "iw9_sh_mviktor_mp", ["minireddot", "grip"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_semtex", "equip_flash");
  _id_CB385B838E10F79E = scripts\cp\utility::_id_BB3E0C926B0667C4;
  [[_id_CB385B838E10F79E]]("silo,silo_power,silo_2nd_stop,silo_end,floor_is_lava,floor_is_lava_power,floor_is_lava_end,floor_is_lava_vent,subpen_raise_water_1,subpen_raise_water_2,subpen_reach_catwalks,subpen_saw_doors");
}

_id_D459E575257144E4() {
  scripts\engine\utility::flag_init("silo_ready");
  scripts\engine\utility::flag_init("fil_ready");
  scripts\engine\utility::flag_init("subarea_ready");
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid1_boss1_shell_cs", "cp_raid1_boss1_shell", level.scripted_spawner_func.size, _id_2703F6E818D6E0ED::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid1_boss1_intel_cs", "cp_raid1_boss1_intel", level.scripted_spawner_func.size, _id_42EC5E223D549E73::main);
  level thread _id_56587DFA8B1E9775();
  level thread _id_EE1B1CA8AF314953();
  level thread _id_1C607538015AB913();
}

_id_56587DFA8B1E9775() {
  _id_2A902F205E418713("raid_load_struct_silo");
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid1_boss1_silo_cs", "cp_raid1_boss1_silo_createscript", level.scripted_spawner_func.size, _id_43E4EBA02A2C43B6::main);
  wait 0.05;
  _id_43E4EBA02A2C43B6::main();
  scripts\engine\utility::flag_wait("cp_raid1_boss1_silo_cs_completed");
  _id_0598E0C00C8151F7::_id_C47EE3C82EA9FA70();
  scripts\engine\utility::flag_set("silo_ready");
}

_id_EE1B1CA8AF314953() {
  _id_2A902F205E418713("raid_load_struct_fil");
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid1_boss1_fil_cs", "cp_raid1_boss1_fil_create_script", level.scripted_spawner_func.size, _id_2B25F2B0A48C1A42::main);
  wait 0.05;
  _id_2B25F2B0A48C1A42::main();
  scripts\engine\utility::flag_wait("cp_raid1_boss1_fil_cs_completed");
  _id_0598E0C00C8151F7::_id_C47EE3C82EA9FA70();
  scripts\engine\utility::flag_set("fil_ready");
}

_id_1C607538015AB913() {
  _id_2A902F205E418713("raid_load_struct_subarea");
  scripts\common\create_script_utility::register_create_script_arrays("cp_raid1_boss1_create_script", "cp_raid1_boss1_create_script", level.scripted_spawner_func.size, _id_120A4F027A4AE8F8::main);
  wait 0.05;
  _id_120A4F027A4AE8F8::main();
  scripts\engine\utility::flag_wait("cp_raid1_boss1_create_script_completed");
  _id_0598E0C00C8151F7::_id_C47EE3C82EA9FA70();
  scripts\engine\utility::flag_set("subarea_ready");
}

_id_2A902F205E418713(_id_1D6AA90A9F946BBE) {
  _id_E7C1D5F198601061 = scripts\engine\utility::getStructArray(_id_1D6AA90A9F946BBE, "targetname");

  for(;;) {
    foreach(struct in _id_E7C1D5F198601061) {
      radiussq = squared(int(struct.radius));

      if(!scripts\cp\utility::any_player_nearby(struct.origin, radiussq))
        continue;
      else
        return;
    }

    waitframe();
  }
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  wait 1;
  scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
  thread _id_382959D7794736CC::_id_B6CD3626C14C131E();
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_raid1_boss1_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_raid1_boss1_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
  _id_13FFCCF97A3E3294::register_objectives();
}

_id_D525F1534752BFC7() {
  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  scripts\engine\utility::flag_set("infil_complete");
}

setup_player_stealth() {
  scripts\engine\utility::flag_wait("level_stealth_initialized");
  scripts\stealth\player::main();
  thread scripts\cp\coop_stealth::suspicious_door_monitor();
  thread scripts\cp\coop_stealth::threat_sight_monitor();
}

_id_59D8A269D3AB61AB() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("enter_spectate");

  if(istrue(level.gameended)) {
    return;
  }
  if(isDefined(level._id_142FFEF4BA6476C6) && isDefined(level._id_142FFEF4BA6476C6.clip)) {
    if(self istouching(level._id_142FFEF4BA6476C6) || self istouching(level._id_142FFEF4BA6476C6.clip))
      thread _id_292D66D2E5A9D7DD::_id_1E3C3FCD29F87F9F();
  }
}

_id_633EE74E2649AAC7(_id_8B065B1B8825808B) {
  scripts\cp\cp_checkpoint::checkpoint_set("");
}