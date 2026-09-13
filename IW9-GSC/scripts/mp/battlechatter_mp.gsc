/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\battlechatter_mp.gsc
***********************************************/

init() {
  level.battlechatterenabled = getdvarint("dvar_7BDF6D033065EF17", 1) == 1;
  _id_6B2B70199C346E46 = getdvarint("dvar_FC4B1A7D66DBEB32", 1800);
  level._id_98014172CE4B4E67 = _id_6B2B70199C346E46 * _id_6B2B70199C346E46;
  level.speakers = [];
  level.bcinfo = [];
  level.bcinfo["max_wait_time"] = 1000;
  level.bcinfo["soundEventHistory"] = [];
  _id_C56207BDA09B3A36 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  level._id_C49BB6749E2CE50C = physics_createcontents(_id_C56207BDA09B3A36);

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    level.isteamspeaking[_id_FABF84450735DD93] = 0;
    level.speakers[_id_FABF84450735DD93] = [];
    level.bcinfo["queued"][_id_FABF84450735DD93] = "none";
  }

  setupselfvo();
  _id_9CD008247BA86BCD();
  registerbcsoundtype("stat_40D708EB58419C23", undefined, 1.0, 1.0, 10, 10, 0);
  scriptbundlename = "battlechatter_list";

  if(getdvarint("t10") > 0)
    scriptbundlename = scriptbundlename + "_iw9_mp";
  else if(_id_2CEDCC356F1B9FC8::_id_55B494A07469298A())
    scriptbundlename = scriptbundlename + "_mgl_ftue";
  else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scriptbundlename = scriptbundlename + "_wz2_br";
  else
    scriptbundlename = scriptbundlename + "_iw9_mp";

  _id_D442547D75DFFD09 = getscriptbundle("battlechatterlist:" + scriptbundlename);

  if(isDefined(_id_D442547D75DFFD09)) {
    foreach(event in _id_D442547D75DFFD09._id_2B444E3956D2A059) {
      eventname = event.eventname;
      _id_4F632C1568AF9FC0 = event._id_0CBFCBD7B8D7CBB0;
      priority = event.priority;
      _id_302E82DA1A1989AD = event._id_302E82DA1A1989AD;
      _id_5451DCA91A942C16 = event._id_5451DCA91A942C16;
      _id_C3924093B71EC9DD = event._id_C3924093B71EC9DD;
      _id_3910458D599E5E01 = event._id_3910458D599E5E01;
      registerbcsoundtype(eventname, _id_4F632C1568AF9FC0, priority, _id_302E82DA1A1989AD, _id_5451DCA91A942C16, _id_C3924093B71EC9DD, _id_3910458D599E5E01);
    }

    foreach(event in _id_D442547D75DFFD09._id_CE140ADD99A4D5C4) {
      eventname = event.eventname;
      _id_4F632C1568AF9FC0 = event._id_0CBFCBD7B8D7CBB0;
      priority = event.priority;
      _id_302E82DA1A1989AD = event._id_302E82DA1A1989AD;
      _id_5451DCA91A942C16 = event._id_5451DCA91A942C16;
      _id_C3924093B71EC9DD = event._id_C3924093B71EC9DD;
      _id_3910458D599E5E01 = event._id_3910458D599E5E01;
      registerbcsoundtype(eventname, _id_4F632C1568AF9FC0, priority, _id_302E82DA1A1989AD, _id_5451DCA91A942C16, _id_C3924093B71EC9DD, _id_3910458D599E5E01);
    }
  }

  level.func_bcs_location_trigs = scripts\mp\battlechatter_trigs::extra_location_trigger_mapping;
  scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  gametype = getDvar("g_gametype");
  level.istacticalbc = 0;

  if(gametype == "sd" || gametype == "cyber" || gametype == "arena")
    level.istacticalbc = 1;

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

_id_9CD008247BA86BCD() {
  _id_4C2643BE02ACC9D2("ping_objective_go_flag");
  _id_4C2643BE02ACC9D2("ping_enemy_killed");
  _id_4C2643BE02ACC9D2("ping_inv_need_gun");
  _id_4C2643BE02ACC9D2("ping_objective_destroy_generic");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_ammo");
  _id_4C2643BE02ACC9D2("ping_inv_need_smallcal");
  _id_4C2643BE02ACC9D2("ping_inv_need_launcher");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_selfrevive");
  _id_4C2643BE02ACC9D2("ping_request_revive");
  _id_4C2643BE02ACC9D2("ping_request_assimilation_deny");
  _id_4C2643BE02ACC9D2("ping_request_assimilation_join_me");
  _id_4C2643BE02ACC9D2("ping_social_seeyoulater");
  _id_4C2643BE02ACC9D2("ping_contract_trap_alarm");
  _id_4C2643BE02ACC9D2("ping_enemy_downed");
  _id_4C2643BE02ACC9D2("ping_location_regroup");
  _id_4C2643BE02ACC9D2("ping_buystation_request_revive");
  _id_4C2643BE02ACC9D2("ping_help_interrogate");
  _id_4C2643BE02ACC9D2("ping_contract_confirm_mostwanted");
  _id_4C2643BE02ACC9D2("ping_contract_confirm_hunt");
  _id_4C2643BE02ACC9D2("ping_contract_confirm_hostage");
  _id_4C2643BE02ACC9D2("ping_location_looted");
  _id_4C2643BE02ACC9D2("ping_need_killstreak");
  _id_4C2643BE02ACC9D2("ping_objective_defend_generic");
  _id_4C2643BE02ACC9D2("ping_inv_need_cash");
  _id_4C2643BE02ACC9D2("ping_inv_need_armor");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_armor");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_weapon");
  _id_4C2643BE02ACC9D2("ping_enemy_sniper");
  _id_4C2643BE02ACC9D2("ping_enemy_tier1");
  _id_4C2643BE02ACC9D2("ping_gulag_escape_hatch");
  _id_4C2643BE02ACC9D2("ping_gulag_escaped");
  _id_4C2643BE02ACC9D2("ping_inv_have_ammo_shotgun");
  _id_4C2643BE02ACC9D2("ping_enemy_tier3");
  _id_4C2643BE02ACC9D2("ping_vehicle_husk_generic");
  _id_4C2643BE02ACC9D2("ping_vehicle_gunner");
  _id_4C2643BE02ACC9D2("ping_killstreak_juggernaut");
  _id_4C2643BE02ACC9D2("ping_vehicle_bailout");
  _id_4C2643BE02ACC9D2("ping_killstreak_choppergunner_hostile");
  _id_4C2643BE02ACC9D2("ping_inv_have_weapon_dmr");
  _id_4C2643BE02ACC9D2("ping_inv_have_ammo_launcher");
  _id_4C2643BE02ACC9D2("ping_vehicle_husk_danger_generic");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_generic");
  _id_4C2643BE02ACC9D2("ping_vehicle_danger_generic");
  _id_4C2643BE02ACC9D2("ping_enemy_interrogate");
  _id_4C2643BE02ACC9D2("ping_inv_have_weapon_sniper");
  _id_4C2643BE02ACC9D2("ping_enemy_mountedturret");
  _id_4C2643BE02ACC9D2("ping_request_assimilation_confirm");
  _id_4C2643BE02ACC9D2("ping_request_leaveme_confirm");
  _id_4C2643BE02ACC9D2("ping_objective_go_device");
  _id_4C2643BE02ACC9D2("ping_social_goodjob");
  _id_4C2643BE02ACC9D2("ping_request_assimilation_join_other");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_gasmask");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_fieldupgrade");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_medical");
  _id_4C2643BE02ACC9D2("ping_location_landing");
  _id_4C2643BE02ACC9D2("ping_location_help");
  _id_4C2643BE02ACC9D2("ping_request_leaveme");
  _id_4C2643BE02ACC9D2("ping_inv_have_weapon_assaultrifle");
  _id_4C2643BE02ACC9D2("ping_loot_confirm_buzzsaw");
  _id_4C2643BE02ACC9D2("ping_social_commend");
  _id_4C2643BE02ACC9D2("ping_social_goodgame");
  _id_4C2643BE02ACC9D2("ping_contract_confirm_generic");
  _id_4C2643BE02ACC9D2("ping_social_goodplay");
  _id_4C2643BE02ACC9D2("ping_location_landing_confirm");
  _id_4C2643BE02ACC9D2("ping_loot_killstreak_juggernaut_box");
  _id_4C2643BE02ACC9D2("ping_location_visited");
  _id_4C2643BE02ACC9D2("ping_inv_have_killstreak_generic");
  _id_4C2643BE02ACC9D2("bc_status_player_respawn");
  _id_4C2643BE02ACC9D2("bc_combat_inform_check_fire_ally");
  _id_4C2643BE02ACC9D2("bc_combat_inform_taking_fire");
  _id_4C2643BE02ACC9D2("bc_equipment_action_grenade_throwback");
  _id_4C2643BE02ACC9D2("bc_status_inform_last_one");
  _id_4C2643BE02ACC9D2("bc_fieldupgrade_action_battlerage");
  _id_4C2643BE02ACC9D2("bc_status_player_last_stand");
  _id_4C2643BE02ACC9D2("bc_equipment_action_grenade");
  _id_4C2643BE02ACC9D2("bc_equipment_action_bandage");
  _id_4C2643BE02ACC9D2("bc_combat_action_execution");
  _id_4C2643BE02ACC9D2("bc_fieldupgrade_action_deadsilence");
  _id_4C2643BE02ACC9D2("bc_combat_killfirm_infantry");
  _id_4C2643BE02ACC9D2("bc_status_player_revived");
  _id_4C2643BE02ACC9D2("bc_status_player_selfrevived");
  _id_4C2643BE02ACC9D2("bc_status_action_reviving");
  _id_4C2643BE02ACC9D2("bc_fieldupgrade_action_aprounds");
  _id_4C2643BE02ACC9D2("bc_status_player_low_health");
  _id_4C2643BE02ACC9D2("bc_status_player_recover");
  _id_4C2643BE02ACC9D2("bc_flavor_player_awesome");
  _id_4C2643BE02ACC9D2("bc_flavor_player_suppressed");
  _id_4C2643BE02ACC9D2("bc_killstreak_killfirm_juggernaut");
  _id_4C2643BE02ACC9D2("bc_flavor_player_closecall");
  _id_4C2643BE02ACC9D2("bc_flavor_player_negative");
  _id_4C2643BE02ACC9D2("bc_flavor_player_save");
  _id_4C2643BE02ACC9D2("bc_flavor_player_revenge");
  _id_4C2643BE02ACC9D2("bc_flavor_player_surprise");
  _id_4C2643BE02ACC9D2("bc_vehicle_killfirm_jetski");
  _id_4C2643BE02ACC9D2("bc_flavor_player_headshotlong");
  _id_4C2643BE02ACC9D2("bc_flavor_player_positive");
  _id_4C2643BE02ACC9D2("bc_killstreak_action_nuke");
  _id_4C2643BE02ACC9D2("bc_equipment_action_stim");
  _id_4C2643BE02ACC9D2("bc_killstreak_action_juggernaut");
}

_id_4C2643BE02ACC9D2(eventname) {
  if(!isDefined(level._id_05A42555B2750C3A))
    level._id_05A42555B2750C3A = [];

  level._id_05A42555B2750C3A[_func_1823FF50BB28148D(eventname)] = _func_2EF675C13CA1C4AF("dvar_EE1BA8E906086C3C", eventname);
}

_id_BC76CF7ADDA53DE3(eventname) {
  if(isDefined(level._id_05A42555B2750C3A) && isDefined(level._id_05A42555B2750C3A[eventname]))
    return getdvarint("dvar_A48E01AB7C276EF4", 0) != 0 || getdvarint(level._id_05A42555B2750C3A[eventname], 0) != 0;

  return 0;
}

registerbcsoundtype(_id_FD2287F1DB15A3E0, _id_4F632C1568AF9FC0, priority, _id_302E82DA1A1989AD, _id_5451DCA91A942C16, _id_C3924093B71EC9DD, _id_3910458D599E5E01) {
  if(!isDefined(_id_FD2287F1DB15A3E0)) {
    return;
  }
  if(!isDefined(priority) || priority == 1)
    priority = undefined;

  if(!isDefined(_id_302E82DA1A1989AD) || _id_302E82DA1A1989AD == 0.0 || _id_BC76CF7ADDA53DE3(_id_FD2287F1DB15A3E0))
    _id_302E82DA1A1989AD = undefined;

  if(!isDefined(_id_5451DCA91A942C16) || _id_5451DCA91A942C16 == 1.0)
    _id_5451DCA91A942C16 = undefined;
  else
    _id_5451DCA91A942C16 = _id_5451DCA91A942C16 * 1000;

  if(!isDefined(_id_C3924093B71EC9DD) || _id_C3924093B71EC9DD == 1.0)
    _id_C3924093B71EC9DD = undefined;
  else
    _id_C3924093B71EC9DD = _id_C3924093B71EC9DD * 1000;

  if(!isDefined(_id_3910458D599E5E01) || _id_3910458D599E5E01 == 0)
    _id_3910458D599E5E01 = undefined;

  level.bcinfo["asset"][_id_FD2287F1DB15A3E0] = _id_4F632C1568AF9FC0;
  level.bcinfo["priority"][_id_FD2287F1DB15A3E0] = priority;
  level.bcinfo["chance"][_id_FD2287F1DB15A3E0] = _id_302E82DA1A1989AD;
  level.bcinfo["timeout_pos"][_id_FD2287F1DB15A3E0] = _id_5451DCA91A942C16;
  level.bcinfo["timeout_player"][_id_FD2287F1DB15A3E0] = _id_C3924093B71EC9DD;
  level.bcinfo["req_friendly"][_id_FD2287F1DB15A3E0] = _id_3910458D599E5E01;
}

onplayerspawned() {
  self.bcinfoqueued = "none";
  self._id_CF34556D563B92AE = 0;
  self.recentattackers = [];
  self.bcinfolastsaytimes = [];

  if(level.splitscreen) {
    return;
  }
  if(!level.teambased || level.istacticalbc || istrue(level.disablebattlechatter) || scripts\mp\utility\game::isanymlgmatch())
    self.bcdisabled = 1;
  else {
    if(!scripts\mp\utility\game::runleanthreadmode() || istrue(level.br_practice_match)) {
      thread reloadtracking();
      thread threatcallouttracking();
      thread onsixfriendlytracking();

      if(istrue(self.wassquadspawned)) {
        level thread trysaylocalsound(self, "stat_213C1CF2E5154626");
        return;
      }

      return;
    }

    if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      self.bcdisabled = 1;
  }
}

hurtbadlywait() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bc_damage_taken");
  wait 1.5;
  level thread trysaylocalsound(self, "stat_C9F3C24DF8902B3D");
}

validaterecentattackers() {
  if(!isDefined(self.recentattackers)) {
    self.recentattackers = [];
    return;
  }

  _id_9225A7E3E5CC65FF = [];
  currenttime = gettime();

  foreach(event in self.recentattackers) {
    if(currenttime < event.ignoreaftertime)
      _id_9225A7E3E5CC65FF[_id_9225A7E3E5CC65FF.size] = event;
  }

  self.recentattackers = _id_9225A7E3E5CC65FF;
}

addrecentattacker(attacker) {
  if(!isDefined(self.recentattackers))
    self.recentattackers = [];

  _id_161EE527AA374CCA = 0;

  foreach(event in self.recentattackers) {
    if(event.attacker == attacker) {
      _id_161EE527AA374CCA = 1;
      event.time = gettime();
      event.ignoreaftertime = event.time + 2000;
      break;
    }
  }

  if(!_id_161EE527AA374CCA) {
    event = spawnStruct();
    event.time = gettime();
    event.attacker = attacker;
    event.ignoreaftertime = event.time + 2000;
    self.recentattackers[self.recentattackers.size] = event;
  }

  validaterecentattackers();
}

launcherfired(missile) {
  missile endon("death");

  for(;;) {
    _id_EF269077A28646EB = scripts\common\utility::playersinsphere(missile.origin, 500);

    foreach(player in _id_EF269077A28646EB) {
      if(!isDefined(player) || !player scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(isDefined(missile.owner) && !missile.owner scripts\cp_mp\utility\player_utility::isenemy(player)) {
        continue;
      }
      level thread trysaylocalsound(player, "stat_818E8617ACC1D296");
      return;
    }

    waitframe();
  }
}

javelinfired(team, target) {
  if(!level.teambased) {
    return;
  }
  enemyteam = scripts\engine\utility::random(scripts\mp\utility\game::getotherteam(team));
  _id_6022F416C78A2D65 = scripts\mp\utility\player::getplayersinradius(target, 360000, enemyteam);

  if(_id_6022F416C78A2D65.size == 0)
    return;
  else {
    player = scripts\engine\utility::random(_id_6022F416C78A2D65);
    level thread trysaylocalsound(player, "stat_818E8617ACC1D296", undefined, 0.5);
  }
}

ongrenadeuse(grenade) {
  _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(grenade.weapon_object);

  switch (_id_49E6EF3EDADD524E) {
    case "frag_grenade":
      level thread trysaylocalsound(self, "stat_87DC683C44E94CE5");
      break;
    case "semtex":
      level thread trysaylocalsound(self, "stat_E0F134F0AA8E5E19");
      break;
    case "molotov":
      level thread trysaylocalsound(self, "stat_4E002B99FDD8BB21");
      break;
    case "thermite":
      level thread trysaylocalsound(self, "stat_90A59654FFB287E7");
      break;
    case "c4":
      level thread trysaylocalsound(self, "stat_45C1622EFE49213A");
      break;
    case "claymore":
      level thread trysaylocalsound(self, "stat_87ECE9915948EA41");
      break;
    case "at_mine":
      level thread trysaylocalsound(self, "stat_98BD43C783A97C73");
      break;
    case "flash_grenade":
      level thread trysaylocalsound(self, "stat_88D1A27B743BAE2F");
      break;
    case "concussion_grenade":
      level thread trysaylocalsound(self, "stat_2F8B921B0E23A1D9");
      break;
    case "sensor_grenade":
      level thread trysaylocalsound(self, "stat_914AE16742EAE945");
      break;
    case "smoke_grenade":
      level thread trysaylocalsound(self, "stat_5610FA46327FB2AE");
      break;
    case "gas_grenade":
      level thread trysaylocalsound(self, "stat_AF8782DA03DE19DA");
      break;
    case "decoy_grenade":
      level thread trysaylocalsound(self, "stat_B2FA51B9F1FA0D4F");
      break;
    case "adrenaline":
      level thread trysaylocalsound(self, "stat_2F2CAF1B0DD33E9C");
      break;
    case "shock_stick":
      level thread trysaylocalsound(self, "stat_BB9AB22BA578E5AB");
      break;
    case "bunkerbuster":
      level thread trysaylocalsound(self, "stat_93D3BFB8EFBD9554");
      break;
    case "trophy":
      level thread trysaylocalsound(self, "stat_8C7D28CBEB991D35");
      break;
    case "ammo_box":
      level thread trysaylocalsound(self, "stat_7B8768313AC02AE6");
      break;
  }
}

_id_204AEBA40A2AA027(_id_EBEC497FF8B18A45) {
  switch (_id_EBEC497FF8B18A45) {
    case "super_armor_drop":
      level thread trysaylocalsound(self, "stat_792D7CE252E00D97");
      break;
    case "super_suppression_rounds":
      level thread trysaylocalsound(self, "stat_F9AA61CFA10B735B");
      break;
    case "super_battlerage":
      if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.operatorref) && self.operatorcustomization.operatorref == "nikto_eastern") {
        return;
      }
      level thread trysaylocalsound(self, "stat_0AC1A2F277B83330");
      break;
    case "super_deadsilence":
      level thread trysaylocalsound(self, "stat_59169AED8D3F8D14");
      break;
    case "super_tac_cover":
      level thread trysaylocalsound(self, "stat_B590BF555735BEA3");
      break;
    case "super_emp_pulse":
      level thread trysaylocalsound(self, "stat_D661AEA88FC83C08");
      break;
    case "super_deployed_decoy":
      level thread trysaylocalsound(self, "stat_02CC9EA480EDC6A1");
      break;
    case "super_recon_drone":
      level thread trysaylocalsound(self, "stat_34C337EF42F2F060");
      break;
    case "super_smoke_airdrop":
      level thread trysaylocalsound(self, "stat_CAECA91607599DB9");
      break;
    case "super_sonar_pulse":
      level thread trysaylocalsound(self, "stat_7ABDFAD5856C2B17");
      break;
    case "super_sound_veil":
      level thread trysaylocalsound(self, "stat_64AA80C8C0C43056");
      break;
    case "super_stimpistol":
      level thread trysaylocalsound(self, "stat_D7D84E89961EB44D");
      break;
    case "super_tac_camera":
      level thread trysaylocalsound(self, "stat_4858AFD598E340BE");
      break;
    default:
      break;
  }

  if(isDefined(self.team))
    level notify("fieldUpgrade_used_" + self.team, _id_EBEC497FF8B18A45);
}

_id_883240EB5234490E(_id_928BFCD868268253) {
  level thread trysaylocalsound(self, _id_928BFCD868268253);
}

grenadeproximitytracking() {
  if(!isDefined(self)) {
    return;
  }
  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  objweapon = self.weapon_object;
  _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);

  switch (_id_49E6EF3EDADD524E) {
    case "gas_grenade":
    case "sensor_grenade":
    case "flash_grenade":
    case "frag_grenade":
    case "concussion_grenade":
    case "thermite":
    case "semtex":
    case "smoke_grenade":
    case "molotov":
    case "c4":
      break;
    default:
      if(weaponclass(self.weapon_name) == "rocketlauncher") {
        break;
      }

      return;
  }

  owner = self.owner;

  if(!isDefined(owner))
    owner = getmissileowner(self);

  if(!isDefined(owner)) {
    return;
  }
  _id_12EA6E98355ECB10 = self.origin;
  _id_78122E18403A8DC4 = scripts\common\utility::playersnear(_id_12EA6E98355ECB10, 960.0);
  self endon("death");

  while(isDefined(self.origin)) {
    if(distancesquared(_id_12EA6E98355ECB10, self.origin) > 589824) {
      _id_12EA6E98355ECB10 = self.origin;
      _id_78122E18403A8DC4 = scripts\common\utility::playersnear(_id_12EA6E98355ECB10, 960.0);
    }

    foreach(player in _id_78122E18403A8DC4) {
      if(!isDefined(player) || player scripts\cp_mp\utility\player_utility::_isalive() == 0 || isDefined(self.owner) && isalive(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isenemy(player) == 0) {
        continue;
      }
      _id_DB99B2CAE470AE03 = distancesquared(self.origin, player.origin);

      if(isDefined(_id_DB99B2CAE470AE03) && _id_DB99B2CAE470AE03 < 147456) {
        if(!sighttracepassed(player getEye(), self.origin, 0, player)) {
          continue;
        }
        switch (_id_49E6EF3EDADD524E) {
          case "frag_grenade":
            level thread trysaylocalsound(player, "stat_ED1C8A7166B894AF");
            break;
          case "concussion_grenade":
            level thread trysaylocalsound(player, "stat_65F21A33FC38C333");
            break;
          case "flash_grenade":
            level thread trysaylocalsound(player, "stat_5B8DE9F0FCACC509");
            break;
          case "smoke_grenade":
            level thread trysaylocalsound(player, "stat_83C99CA7C7C2F310");
            break;
          case "semtex":
            level thread trysaylocalsound(player, "stat_D894310067F8AA6F");
            break;
          case "molotov":
            level thread trysaylocalsound(player, "stat_86CF3380B9AB1D0F");
            break;
          case "c4":
            level thread trysaylocalsound(player, "stat_9CB65D1BB6A45FF0");
            break;
          case "sensor_grenade":
            level thread trysaylocalsound(player, "stat_83C99CA7C7C2F310");
            break;
          case "thermite":
            level thread trysaylocalsound(player, "stat_5A5FFE8EC30CA285");
            break;
          case "gas_grenade":
            level thread trysaylocalsound(player, "stat_CD28251747015EB8");
            break;
          case "shock_stick":
            level thread trysaylocalsound(player, "stat_9E6F5A8035522781");
            break;
          case "bunkerbuster":
            level thread trysaylocalsound(player, "stat_6D48AF2A13824EBA");
            break;
          default:
            if(weaponclass(self.weapon_name) == "rocketlauncher")
              level thread trysaylocalsound(player, "stat_818E8617ACC1D296");

            break;
        }
      }

      waitframe();
    }

    waitframe();
  }
}

equipmentdestroyed(ent) {
  if(!isDefined(ent)) {
    return;
  }
  if(!isDefined(ent.weapon_name)) {
    return;
  }
  switch (ent.weapon_name) {
    case "c4_mp":
      break;
    case "at_mine_mp":
      break;
    case "claymore_mp":
      break;
    case "trophy_mp":
      break;
    case "deployable_cover_mp":
      break;
    case "decoy_grenade_mp":
      break;
    case "gas_grenade_mp":
      break;
    case "sensor_grenade_mp":
      break;
    case "support_box_mp":
      break;
    case "armor_box_mp":
  }
}

playkillstreakdeploydialog(owner, streakname) {
  if(!isDefined(streakname)) {
    return;
  }
  switch (streakname) {
    case "gunship":
    case "chopper_gunner":
    case "airdrop_escort":
    case "auto_drone":
      level thread trysaylocalsound(owner, "stat_5B7467081A2282E2");
      break;
    case "pac_sentry":
      level thread trysaylocalsound(owner, "stat_0699CD36464CE6F8");
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "juggernaut":
      level thread trysaylocalsound(owner, "stat_A3189F1ECCD8C8FE");
      break;
    case "sentry_gun":
      level thread trysaylocalsound(owner, "stat_255014198B22E8C8");
      break;
    case "nuke_select_location":
    case "nuke_multi":
    case "nuke":
      level thread trysaylocalsound(owner, "stat_28D138C351A647D0");
      break;
    case "napalm_strike":
    case "precision_airstrike":
    case "hover_jet":
    case "cruise_predator":
    case "fuel_airstrike":
      level thread trysaylocalsound(owner, "stat_333D25936F11C70D");
      break;
    case "supply_sweep":
    case "uav_bigmap":
    case "directional_uav":
    case "uav":
      level thread trysaylocalsound(owner, "stat_C836F1CDB2DA4224");
      break;
    case "scrambler_drone_guard":
      level thread trysaylocalsound(owner, "stat_91B8E15F4160568D");
      break;
    case "cluster_spike":
      level thread trysaylocalsound(owner, "stat_1F245D2DB39F9F7E");
      break;
    case "assault_drone":
      level thread trysaylocalsound(owner, "stat_B70A873A72C9B255");
      break;
    case "toma_strike":
      level thread trysaylocalsound(owner, "stat_09A5EEFF4F808296");
      break;
  }
}

killstreakdestroyed(streakname) {
  if(!isDefined(streakname)) {
    return;
  }
  switch (streakname) {
    case "gunship":
      level thread trysaylocalsound(self, "stat_D147E64A154159C1");
      break;
    case "airdrop_multiple":
    case "airdrop":
    case "chopper_gunner":
    case "airdrop_escort":
      level thread trysaylocalsound(self, "stat_00ECDCF88F3403A7");
      break;
    case "pac_sentry":
      level thread trysaylocalsound(self, "stat_97BBA72A073DDA5A");
      break;
    case "hover_jet":
      level thread trysaylocalsound(self, "stat_6C808886C536757E");
      break;
    case "juggernaut":
      level thread trysaylocalsound(self, "stat_3A0F5BB16DF88C43");
      break;
    case "sentry_gun":
      level thread trysaylocalsound(self, "stat_CCD0D9B6011ED142");
      break;
    case "uav_bigmap":
    case "directional_uav":
    case "uav":
      level thread trysaylocalsound(self, "stat_91275601809A9301");
      break;
    case "counter_uav":
    case "scrambler_drone_guard":
      level thread trysaylocalsound(self, "stat_E8D20F891FF1CFB3");
      break;
    case "cluster_spike":
      level thread trysaylocalsound(self, "stat_4F3EDF9D24D47144");
      break;
    case "assault_drone":
      level thread trysaylocalsound(self, "stat_D29A8B89786BF42B");
      break;
    case "radar_drone_recon":
      level thread trysaylocalsound(self, "stat_5DFA154B6FFD1F96");
  }
}

suppressingfiretracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  _id_6882A17EC6A9D934 = undefined;

  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("begin_firing");
    thread suppresswaiter();
    thread suppresstimeout();
    self waittill("stoppedFiring");
  }
}

suppresstimeout() {
  thread waitsuppresstimeout();
  self endon("begin_firing");
  self waittill("end_firing");
  wait 0.3;
  self notify("stoppedFiring");
}

waitsuppresstimeout() {
  self endon("stoppedFiring");
  self waittill("begin_firing");
  thread suppresstimeout();
}

suppresswaiter() {
  self notify("suppressWaiter");
  self endon("suppressWaiter");
  self endon("death_or_disconnect");
  self endon("stoppedFiring");
  wait 1;
}

reloadtracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("reload_start");
    objweapon = self getcurrentweapon();

    if(!isDefined(objweapon)) {
      continue;
    }
    _id_EF3BE25D24D4F062 = scripts\mp\utility\weapon::weaponhasattachment(objweapon, "akimbo");

    if(_id_EF3BE25D24D4F062)
      _id_3483795B0A68EB95 = self getweaponammoclip(objweapon, "right") + self getweaponammoclip(objweapon, "left") + self getweaponammostock(objweapon);
    else
      _id_3483795B0A68EB95 = self getweaponammoclip(objweapon) + self getweaponammostock(objweapon);

    _id_54A24336CC9A143D = istrue(objweapon.isalternate) && (weaponclass(objweapon) == "grenade" || weaponclass(objweapon) == "spread");
    _id_0BC6925748F6B3A6 = scripts\mp\utility\weapon::_id_8A4F25FB9D4C43C8(objweapon);
    _id_58B56EFD3B604E35 = scripts\mp\utility\weapon::_id_F851BB47702A91EA(objweapon);

    if(_id_3483795B0A68EB95 <= weaponclipsize(objweapon) || _id_EF3BE25D24D4F062 && _id_3483795B0A68EB95 <= weaponclipsize(objweapon) * 2) {
      _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);
      _id_38497CE38042ADF7 = 0;

      switch (_id_2669878CF5A1B6BC::getweaponrootname(objweapon)) {
        case "iw8_sn_kilo98":
        case "iw9_la_mike32":
        case "iw9_dm_crossbow":
          _id_38497CE38042ADF7 = 1;
          break;
      }

      _id_DA66AF6058340796 = _id_38497CE38042ADF7 || _id_54A24336CC9A143D;

      if(!_id_DA66AF6058340796) {
        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
          switch (_id_CF4209C200F8BBF4) {
            case "weapon_smg":
            case "weapon_pistol":
              level thread trysaylocalsound(self, "stat_33802C943482A5D8");
              break;
            case "weapon_battle":
            case "weapon_assault":
              level thread trysaylocalsound(self, "stat_FEF42C2E234A4C6F");
              break;
            case "weapon_lmg":
            case "weapon_sniper":
            case "weapon_dmr":
              level thread trysaylocalsound(self, "stat_C5D03EB7313C9667");
              break;
            case "weapon_shotgun":
              level thread trysaylocalsound(self, "stat_61EF7891799956A6");
              break;
            case "weapon_projectile":
              level thread trysaylocalsound(self, "stat_79C2501BF90D6681");
              break;
          }
        } else if(_id_0BC6925748F6B3A6)
          level thread trysaylocalsound(self, "stat_FE2EBC34B62D293F");
        else
          level thread trysaylocalsound(self, "stat_442329CAF50F7C25");
      }

      continue;
    }

    if(_id_58B56EFD3B604E35) {
      validaterecentattackers();
      _id_4291FA32C3861D68 = _id_189B67B2735B981D::_id_7B50742A287D3CA1(self) && scripts\engine\utility::cointoss();

      if(_id_4291FA32C3861D68)
        _id_189B67B2735B981D::_id_C5F05871BA7C3AA3();
      else if(_id_0BC6925748F6B3A6)
        level thread trysaylocalsound(self, "stat_7A11AF8950A9A3FA");
      else
        level thread trysaylocalsound(self, "stat_562601E3A4173F34");
    }
  }
}

sprinttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;)
    self waittill("sprint_begin");
}

threatcallouttracking() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  for(;;) {
    self waittill("enemy_sighted");

    if(getomnvar("ui_prematch_period")) {
      level waittill("prematch_over");
      continue;
    }

    if(saidtoorecently("stat_52B2ADECC602D95C") || saidtoorecently("stat_0CD1D2547E61FB1E") || saidtoorecently("stat_14F86AF7D651B93F")) {
      continue;
    }
    enemies = self getsightedplayers();

    if(!isDefined(enemies)) {
      continue;
    }
    _id_BE2203D59EE928B6 = 0;
    dist = 4000000;
    isads = self playerads() > 0.7;

    if(isads)
      dist = 9000000;

    _id_5486190C6B06A3C9 = get_last_callout_time(self.team);
    cancalloutlocation = !isDefined(_id_5486190C6B06A3C9) || _id_5486190C6B06A3C9 + _id_FFD3470F08FCF7A7("stat_40D708EB58419C23") < gettime();
    _id_40711B9FD17F058D = 0;
    forward = anglesToForward(self.angles);

    foreach(enemy in enemies) {
      _id_9001DA663C7CDFEC = vectorNormalize(enemy.origin - self.origin);

      if(isDefined(enemy) && scripts\mp\utility\player::isreallyalive(enemy) && !enemy scripts\mp\utility\perk::_hasperk("specialty_coldblooded") && distancesquared(self.origin, enemy.origin) < dist && vectordot(forward, _id_9001DA663C7CDFEC) > scripts\engine\utility::ter_op(isads, 0.984808, 0.939692)) {
        location = enemy getvalidlocation(self);
        _id_BE2203D59EE928B6++;

        if(isDefined(location) && cancalloutlocation) {
          alias = "dx_mpo_" + scripts\engine\utility::ter_op(self.team == "allies", "usop", "ruop") + "_loc_enemy_" + location.locationaliases[0];
          location_add_last_callout_time(location.locationaliases[0], self.team);

          if(soundexists(alias)) {
            self playsoundtoteam(alias, self.team);
            _id_40711B9FD17F058D = 1;
          }

          break;
        }
      }
    }

    if(_id_BE2203D59EE928B6 > 0) {
      alias = undefined;

      if(!saidtoorecently("stat_52B2ADECC602D95C"))
        alias = "stat_52B2ADECC602D95C";

      if(!saidtoorecently("stat_0CD1D2547E61FB1E")) {
        if(isDefined(alias)) {
          if(scripts\engine\utility::cointoss())
            alias = "stat_0CD1D2547E61FB1E";
        } else
          alias = "stat_0CD1D2547E61FB1E";
      }

      if(_id_BE2203D59EE928B6 > 1 && !saidtoorecently("stat_14F86AF7D651B93F")) {
        if(isDefined(alias)) {
          if(scripts\engine\utility::cointoss())
            alias = "stat_14F86AF7D651B93F";
        } else
          alias = "stat_14F86AF7D651B93F";
      }

      level thread trysaylocalsound(self, alias);
    }
  }
}

dosound(_id_FD2287F1DB15A3E0, targetent, location) {
  if(!isDefined(self)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  _id_E7922A94FBD03691 = _id_FD2287F1DB15A3E0;

  if(isDefined(location))
    _id_E7922A94FBD03691 = "loc_callout_" + location;

  if(_id_FD2287F1DB15A3E0 == "stat_197B54B4D0E467B7") {
    if(self.operatorcustomization.executionquip == "none")
      _id_FD2287F1DB15A3E0 = "stat_197B54B4D0E467B7";
  }

  _id_4F632C1568AF9FC0 = level.bcinfo["asset"][_id_FD2287F1DB15A3E0];
  logprint("battlechatter_mp::doSound - PlaySoundEvent()");
  logprint("self = " + self.name);
  logprint("sessionstate = " + self.sessionstate);
  logprint("targetEnt= " + isDefined(targetent));

  if(isDefined(targetent)) {
    logprint("tEntclassname = " + targetent.classname);
    logprint("tEntOrigin= " + targetent.origin);

    if(isPlayer(targetent))
      logprint("tEntSessionstate = " + targetent.sessionstate);
  }

  if(isDefined(targetent) && isent(targetent))
    self _meth_C664A2459D6F3EAA(_id_4F632C1568AF9FC0, targetent);
  else
    self _meth_C664A2459D6F3EAA(_id_4F632C1568AF9FC0);

  if(isDefined(location))
    location_add_last_callout_time(location, self.team);

  priority = _id_336E1F89AE06DFD4(_id_FD2287F1DB15A3E0);
  level thread addspeaker(self, _id_FD2287F1DB15A3E0, priority);
  updatechatter(_id_FD2287F1DB15A3E0);
  return 1;
}

timehack(soundalias, duration) {
  self endon("death_or_disconnect");
  wait(duration);
  self notify(soundalias);
}

isspeakerinrange(player, _id_21B0311D64CADFA2) {
  if(!isDefined(_id_21B0311D64CADFA2))
    _id_21B0311D64CADFA2 = 1000;

  distsq = _id_21B0311D64CADFA2 * _id_21B0311D64CADFA2;

  if(isDefined(player) && isDefined(player.team) && player.team != "spectator") {
    for(index = 0; index < level.speakers[player.team].size; index++) {
      _id_F0EA4030349A33D5 = level.speakers[player.team][index]["player"];

      if(_id_F0EA4030349A33D5 == player)
        return 1;

      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      if(distancesquared(_id_F0EA4030349A33D5.origin, player.origin) < distsq)
        return 1;
    }
  }

  return 0;
}

addspeaker(player, _id_FD2287F1DB15A3E0, priority) {
  team = player.team;
  index = level.speakers[team].size;
  level.speakers[team][index] = [];
  level.speakers[team][index]["player"] = player;
  level.speakers[team][index]["sound_alias"] = _id_FD2287F1DB15A3E0;
  level.speakers[team][index]["sound_type"] = _id_FD2287F1DB15A3E0;
  level.speakers[team][index]["priority"] = priority;
  duration = 1.5;
  player thread timehack(_func_0F28FD66285FA2C9(_id_FD2287F1DB15A3E0), duration);
  player scripts\engine\utility::waittill_any_2(_func_0F28FD66285FA2C9(_id_FD2287F1DB15A3E0), "death_or_disconnect");
  level removespeaker(player, team);
}

removespeaker(player, team) {
  _id_73C8139198918D8B = [];

  for(index = 0; index < level.speakers[team].size; index++) {
    if(isDefined(player) && isDefined(level.speakers[team][index]["player"]) && level.speakers[team][index]["player"] == player) {
      continue;
    }
    _id_73C8139198918D8B[_id_73C8139198918D8B.size] = level.speakers[team][index];
  }

  level.speakers[team] = _id_73C8139198918D8B;
}

disablebattlechatter(player) {
  player.bcdisabled = 1;
}

enablebattlechatter(player) {
  player.bcdisabled = undefined;
}

updatechatter(_id_FD2287F1DB15A3E0) {
  if(!isDefined(level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0]))
    level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0] = [];

  time = gettime();
  cleanuplastsaytimes(_id_FD2287F1DB15A3E0, time);
  self.bcinfolastsaytimes[_id_FD2287F1DB15A3E0] = time;
  data = spawnStruct();
  data.origin = self.origin;
  data.time = time;
  level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0][level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0].size] = data;
}

cleanuplastsaytimes(_id_FD2287F1DB15A3E0, time) {
  _id_50F783A5617F8940 = [];

  foreach(_id_0743AEDAB468ADBB, timestamp in self.bcinfolastsaytimes) {
    timeout = _id_A71193E9DB14C926(_id_0743AEDAB468ADBB) + timestamp;

    if(time < timeout)
      _id_50F783A5617F8940[_id_0743AEDAB468ADBB] = timestamp;
  }

  self.bcinfolastsaytimes = _id_50F783A5617F8940;
  _id_50F783A5617F8940 = [];

  foreach(event in level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0]) {
    if(time < event.time + _id_FFD3470F08FCF7A7(_id_FD2287F1DB15A3E0))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = event;
  }

  level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0] = _id_50F783A5617F8940;
}

getvalidlocation(_id_7D2852D02216C876) {
  _id_6B3D0504A6D07429 = get_all_my_locations();
  _id_6B3D0504A6D07429 = scripts\engine\utility::array_randomize(_id_6B3D0504A6D07429);

  if(_id_6B3D0504A6D07429.size) {
    foreach(location in _id_6B3D0504A6D07429) {
      if(!location_called_out_ever(location) && _id_7D2852D02216C876 cancalloutlocation(location))
        return location;
    }

    foreach(location in _id_6B3D0504A6D07429) {
      if(!location_called_out_recently(location) && _id_7D2852D02216C876 cancalloutlocation(location))
        return location;
    }
  }

  return undefined;
}

get_all_my_locations() {
  alllocations = anim.bcs_locations;
  _id_D2C570326A55A520 = self getistouchingentities(alllocations);
  _id_6B3D0504A6D07429 = [];

  foreach(location in _id_D2C570326A55A520) {
    if(isDefined(location.locationaliases))
      _id_6B3D0504A6D07429[_id_6B3D0504A6D07429.size] = location;
  }

  return _id_6B3D0504A6D07429;
}

location_called_out_ever(location) {
  _id_467203CEB59898BA = location_get_last_callout_time(location.locationaliases[0]);

  if(!isDefined(_id_467203CEB59898BA))
    return 0;

  return 1;
}

location_called_out_recently(location) {
  _id_467203CEB59898BA = location_get_last_callout_time(location.locationaliases[0]);

  if(!isDefined(_id_467203CEB59898BA))
    return 0;

  _id_C5E4B26DBEE9EB39 = _id_467203CEB59898BA + 25000;

  if(gettime() < _id_C5E4B26DBEE9EB39)
    return 1;

  return 0;
}

location_add_last_callout_time(location, team) {
  currenttime = gettime();
  anim.locationlastcallouttimes[location] = currenttime;

  if(!isDefined(level.lastlocationcallouttime))
    level.lastlocationcallouttime = [];

  level.lastlocationcallouttime[team] = currenttime;
}

location_get_last_callout_time(location) {
  if(isDefined(anim.locationlastcallouttimes[location]))
    return anim.locationlastcallouttimes[location];

  return undefined;
}

get_last_callout_time(team) {
  if(isDefined(level.lastlocationcallouttime) && isDefined(level.lastlocationcallouttime[team]))
    return level.lastlocationcallouttime[team];

  return undefined;
}

cancalloutlocation(location) {
  foreach(alias in location.locationaliases) {
    _id_7D3601132C141C9C = getloccalloutalias(alias);
    _id_05956C54E54EBF3D = soundexists(_id_7D3601132C141C9C);

    if(_id_05956C54E54EBF3D)
      return _id_05956C54E54EBF3D;
  }

  return 0;
}

canconcat(location) {
  aliases = location.locationaliases;

  foreach(alias in aliases) {
    if(iscallouttypeconcat(alias, self))
      return 1;
  }

  return 0;
}

getcannedresponse(_id_7D2852D02216C876) {
  _id_0D909D2311D8709D = undefined;
  aliases = self.locationaliases;

  foreach(alias in aliases) {
    if(iscallouttypeqa(alias, _id_7D2852D02216C876) && !isDefined(self.qafinished)) {
      _id_0D909D2311D8709D = alias;
      break;
    }

    if(iscallouttypereport(alias))
      _id_0D909D2311D8709D = alias;
  }

  return _id_0D909D2311D8709D;
}

iscallouttypereport(alias) {
  return issubstr(alias, "_report");
}

iscallouttypeconcat(alias, _id_7D2852D02216C876) {
  _id_3F4CC9DE41415260 = _id_7D2852D02216C876 getloccalloutalias("concat_loc_" + alias);

  if(soundexists(_id_3F4CC9DE41415260))
    return 1;

  return 0;
}

iscallouttypeqa(alias, _id_7D2852D02216C876) {
  if(issubstr(alias, "_qa") && soundexists(alias))
    return 1;

  _id_3F4CC9DE41415260 = _id_7D2852D02216C876 getqacalloutalias(alias, 0);

  if(soundexists(_id_3F4CC9DE41415260))
    return 1;

  return 0;
}

getloccalloutalias(_id_9A1612BF33A317B1) {
  alias = "dx_mpo_" + scripts\engine\utility::ter_op(self.team == "allies", "usop", "ruop") + "_loc_enemy_" + _id_9A1612BF33A317B1;
  return alias;
}

getqacalloutalias(basealias, _id_71981AE9B87A6D81) {
  alias = getloccalloutalias(basealias);
  alias = alias + ("_qa" + _id_71981AE9B87A6D81);
  return alias;
}

battlechatter_canprint() {
  return 0;
}

battlechatter_canprintdump() {
  return 0;
}

battlechatter_print(alias, color) {}

battlechatter_printdump(alias) {}

battlechatter_debugprint(alias, color) {}

getaliastypefromsoundalias(alias) {}

battlechatter_printdumpline(_id_65DC0399D91B7F97, str, _id_ED4FB4807F13F624) {}

friendly_nearby(_id_21B0311D64CADFA2) {
  if(!isDefined(_id_21B0311D64CADFA2))
    _id_21B0311D64CADFA2 = 262144;

  players = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  foreach(player in players) {
    if(player != self && distancesquared(player.origin, self.origin) <= _id_21B0311D64CADFA2)
      return 1;
  }

  return 0;
}

setupselfvo() {
  level.selfvomap = [];
  level.selfvomap["plr_killfirm_c6"] = "kill_rig";
  level.selfvomap["plr_killfirm_ftl"] = "kill_rig";
  level.selfvomap["plr_killfirm_ghost"] = "kill_rig";
  level.selfvomap["plr_killfirm_merc"] = "kill_rig";
  level.selfvomap["plr_killfirm_stryker"] = "kill_rig";
  level.selfvomap["plr_killfirm_warfighter"] = "kill_rig";
  level.selfvomap["plr_killfirm_generic"] = "kill_gen";
  level.selfvomap["plr_killfirm_amf"] = "kill_amf";
  level.selfvomap["plr_killfirm_headshot"] = "kill_headshot";
  level.selfvomap["plr_killfirm_grenade"] = "kill_grenade";
  level.selfvomap["plr_killfirm_rival"] = "kill_rival";
  level.selfvomap["plr_killfirm_semtex"] = "kill_semtex";
  level.selfvomap["plr_killfirm_multi"] = "kill_multi";
  level.selfvomap["plr_killfirm_twofer"] = "kill_twofer";
  level.selfvomap["plr_killfirm_threefer"] = "kill_threefer";
  level.selfvomap["plr_killfirm_killstreak"] = "kill_ss";
  level.selfvomap["plr_killstreak_destroy"] = "kill_other_ss";
  level.selfvomap["plr_killstreak_target"] = "targeted_by_ss";
  level.selfvomap["plr_hit_back"] = "dmg_back";
  level.selfvomap["plr_damaged_light"] = "dmg_light";
  level.selfvomap["plr_damaged_heavy"] = "dmg_heavy";
  level.selfvomap["plr_damaged_emp"] = "dmg_emp";
  level.selfvomap["plr_healing"] = "healing";
  level.selfvomap["plr_kd_high"] = "kd_high";
  level.selfvomap["plr_firefight"] = "firefight";
  level.selfvomap["plr_target_generic"] = "enemy_sighted";
  level.selfvomap["plr_perk_super"] = "super_activate";
  level.selfvomap["plr_perk_trophy"] = "super_activate";
  level.selfvomap["plr_perk_turret"] = "super_activate";
  level.selfvomap["plr_perk_amplify"] = "super_activate";
  level.selfvomap["plr_perk_overdrive"] = "super_activate";
  level.selfvomap["plr_perk_ftl"] = "super_activate";
  level.selfvomap["plr_perk_pulse"] = "super_activate";
  level.selfvomap["plr_perk_rewind"] = "super_activate";
  level.selfvomap["plr_perk_super_kill"] = "super_kill";
  level.selfvomap["plr_perk_trophy_block"] = "super_kill";
  level.selfvomap["plr_perk_turret_kill"] = "super_kill";
  level.selfvomap["plr_killfirm_shift"] = "super_kill";
  level.selfvomap["plr_perk_railgun"] = "super_kill";
  level.selfvomap["plr_perk_stealth"] = "super_kill";
  level.selfvomap["plr_perk_armor"] = "super_kill";
  level.selfvomap["plr_perk_charge"] = "super_kill";
  level.selfvomap["plr_perk_dragon"] = "super_kill";
  level.selfvomap["plr_perk_pound"] = "super_kill";
  level.selfvomap["plr_perk_reaper"] = "super_kill";
  level.selfvoinfo = [];
  setselfvoinfo("kill_rig", 15, 0.3, 0.25);
  setselfvoinfo("kill_gen", 30, 0.1, 0.25);
  setselfvoinfo("kill_amf", 15, 0.5, 0.5);
  setselfvoinfo("kill_headshot", 15, 0.7, 0.25);
  setselfvoinfo("kill_grenade", 15, 0.5, 0.25);
  setselfvoinfo("kill_rival", 15, 0.7, 0.25);
  setselfvoinfo("kill_semtex", 15, 0.5, 0.25);
  setselfvoinfo("kill_multi", 20, 0.6, 0.25);
  setselfvoinfo("kill_twofer", 10, 0.7, 0.75);
  setselfvoinfo("kill_threefer", 10, 0.8, 0.75);
  setselfvoinfo("kill_ss", 10, 0.5, 0.2);
  setselfvoinfo("kill_other_ss", 10, 0.7, 0.75);
  setselfvoinfo("targeted_by_ss", 10, 0.4, 0.33);
  setselfvoinfo("dmg_back", 20, 0.5, 0.5);
  setselfvoinfo("dmg_light", 20, 0.4, 0.1);
  setselfvoinfo("dmg_heavy", 20, 0.5, 0.2);
  setselfvoinfo("healing", 10, 0.3, 0.1);
  setselfvoinfo("kd_high", 20, 0.7, 0.8);
  setselfvoinfo("enemy_sighted", 20, 0.2, 0.25);
  setselfvoinfo("firefight", 10, 0.4, 0.33);
  setselfvoinfo("super_activate", 10, 1.0, 1.0);
  setselfvoinfo("super_kill", 10, 0.9, 0.66);
}

setselfvoinfo(_id_83FCA5A43F291A90, timeout, priority, _id_302E82DA1A1989AD) {
  level.selfvoinfo[_id_83FCA5A43F291A90]["timeout_pos"] = timeout;
  level.selfvoinfo[_id_83FCA5A43F291A90]["priority"] = priority;
  level.selfvoinfo[_id_83FCA5A43F291A90]["chance"] = _id_302E82DA1A1989AD;
}

saytoself(player, aliasname, _id_717D5FAD1F38887C, delay) {
  if(1) {
    return;
  }
  if(isagent(player) || !isPlayer(player)) {
    return;
  }
  if(istrue(player.bcdisabled)) {
    return;
  }
  _id_0E4731409BD255E0 = getintensitysuffix(player);
  _id_1B47EC827F34BD5B = "";

  if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.voice) && isDefined(aliasname))
    _id_1B47EC827F34BD5B = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;

  if(!isDefined(aliasname) || !soundexists(_id_1B47EC827F34BD5B)) {
    if(!isDefined(_id_717D5FAD1F38887C)) {
      return;
    }
    aliasname = _id_717D5FAD1F38887C;
    _id_1B47EC827F34BD5B = "dx_mpb_" + player.operatorcustomization.voice + "_" + aliasname;

    if(!soundexists(_id_1B47EC827F34BD5B))
      return;
  }

  if(!isDefined(player.selfvohistory)) {
    player.selfvohistory = [];
    player.playingselfvo = 0;
    player.queuedvo = "none";
  }

  if(isDefined(player.selfvohistory[level.selfvomap[aliasname]]) && player.selfvohistory[level.selfvomap[aliasname]] > 0) {
    return;
  }
  if(!isDefined(player.pers["selfVOBonusChance"]))
    player thread updateselfvobonuschance();

  if(randomfloat(1.0) > level.selfvoinfo[level.selfvomap[aliasname]]["chance"] + player.pers["selfVOBonusChance"]) {
    return;
  }
  player thread trysetqueuedselfvo(aliasname, delay);
}

updateselfvobonuschance() {
  self endon("disconnect");
  level endon("game_ended");
  self.pers["selfVOBonusChance"] = 0;

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    for(;;) {
      self.pers["selfVOBonusChance"] = self.pers["selfVOBonusChance"] + 0.1;
      wait 3.0;
    }
  } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self.pers["selfVOBonusChance"] = 0.25;
}

trysetqueuedselfvo(aliasname, delay) {
  self endon("death_or_disconnect");

  if(self.queuedvo == aliasname) {
    return;
  }
  if(self.queuedvo == "none" || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] < level.selfvoinfo[level.selfvomap[aliasname]]["priority"] || level.selfvoinfo[level.selfvomap[self.queuedvo]]["priority"] == level.selfvoinfo[level.selfvomap[aliasname]]["priority"] && scripts\engine\utility::cointoss())
    self.queuedvo = aliasname;
  else
    return;

  self notify("addToSelfVOQueue");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 1;

  if(isDefined(delay))
    thread selfvodelay(delay);

  waittime = getprioritywaittime(aliasname);
  _id_33C2A141EBC8F7AE = gettime();

  while(self.playingselfvo || !self.selfvodelaycomplete || waittime > gettime()) {
    if(gettime() > _id_33C2A141EBC8F7AE + 2000) {
      self.queuedvo = "none";
      return;
    }

    wait 0.05;
  }

  waitframe();
  thread playselfvo(aliasname);
}

getprioritywaittime(aliasname) {
  if(!isDefined(self.lastselfvotime))
    self.lastselfvotime = 0;

  return self.lastselfvotime + 2000 + 10000 * (1.0 - level.selfvoinfo[level.selfvomap[aliasname]]["priority"]);
}

selfvodelay(delay) {
  self endon("death_or_disconnect");
  self endon("addToSelfVOQueue");
  self.selfvodelaycomplete = 0;
  wait(delay);
  self.selfvodelaycomplete = 1;
}

playselfvo(aliasname) {
  self endon("death_or_disconnect");
  _id_0E4731409BD255E0 = getintensitysuffix(self);
  _id_1B47EC827F34BD5B = "dx_mpb_" + self.operatorcustomization.voice + "_" + aliasname;
  self.pers["selfVOBonusChance"] = 0;
  self.queuedvo = "none";
  duration = lookupsoundlength(_id_1B47EC827F34BD5B) / 1000;
  self.lastselfvotime = gettime();
  thread playingselfvotracking(duration);
  thread updateselfvohistory(aliasname);
  self playsoundtoplayer(_id_1B47EC827F34BD5B, self);
}

playingselfvotracking(duration) {
  self endon("disconnect");
  self.playingselfvo = 1;
  wait(duration);
  self.playingselfvo = 0;
}

updateselfvohistory(aliasname) {
  self endon("disconnect");
  self.selfvohistory[level.selfvomap[aliasname]] = gettime();
  wait(level.selfvoinfo[level.selfvomap[aliasname]]["timeout_pos"]);
  self.selfvohistory[level.selfvomap[aliasname]] = 0;
}

getintensitysuffix(player) {
  _id_CC603A1672682874 = scripts\mp\utility\game::gettimepassedpercentage();
  intensity = player getbcintensity();

  if(intensity > 5000 || _id_CC603A1672682874 >= 80 || scripts\mp\utility\game::inovertime())
    return "high";
  else
    return "mid";
}

addtointensitybuffer(type, intensity, ignoreaftertime) {
  if(!isDefined(self.battlechatterintensitybuffer))
    self.battlechatterintensitybuffer = [];

  event = spawnStruct();
  event.time = gettime();
  event.value = intensity;
  event.ignoreaftertime = event.time + ignoreaftertime * 1000;
  self.battlechatterintensitybuffer[self.battlechatterintensitybuffer.size] = event;
}

getbcintensity() {
  if(!isDefined(self.battlechatterintensitybuffer))
    return 0;

  _id_BF0609730FEBA76C = [];
  intensity = 0;
  currenttime = gettime();

  foreach(event in self.battlechatterintensitybuffer) {
    if(currenttime < event.ignoreaftertime) {
      intensity = intensity + event.value;
      _id_BF0609730FEBA76C[_id_BF0609730FEBA76C.size] = event;
    }
  }

  self.battlechatterintensitybuffer = _id_BF0609730FEBA76C;
  self.intensity = intensity;
  return intensity;
}

testweaponfiredtolisteners(attacker, objweapon) {
  _id_378D3B538B839D2C = scripts\common\utility::playersnear(attacker.origin, 4000);

  foreach(player in _id_378D3B538B839D2C) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    distsq = max(scripts\engine\utility::distance_2d_squared(attacker.origin, player.origin), 1.0);

    if(scripts\mp\utility\weapon::iscacprimaryweapon(objweapon.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon.basename)) {
      intensity = 0;
      _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);

      switch (_id_CF4209C200F8BBF4) {
        case "weapon_smg":
          intensity = 50;
          break;
        case "weapon_assault":
          intensity = 60;
          break;
        case "weapon_battle":
          intensity = 60;
          break;
        case "weapon_sniper":
          intensity = 90;
          break;
        case "weapon_dmr":
          intensity = 70;
          break;
        case "weapon_lmg":
          intensity = 80;
          break;
        case "weapon_shotgun":
          intensity = 80;
          break;
        case "weapon_projectile":
          intensity = 70;
          break;
        case "weapon_pistol":
          intensity = 40;
          break;
        case "weapon_machine_pistol":
          intensity = 50;
          break;
        default:
          break;
      }

      if(intensity == 0) {
        continue;
      }
      if(scripts\mp\utility\weapon::weaponhasattachment(objweapon, "silencer"))
        intensity = intensity * 0.25;

      if(distsq < 10000)
        _id_808B4CAFF75E3E3D = 5.0;
      else if(distsq < 250000)
        _id_808B4CAFF75E3E3D = 3.0;
      else if(distsq < 1000000)
        _id_808B4CAFF75E3E3D = 2.0;
      else if(distsq < 4000000)
        _id_808B4CAFF75E3E3D = 0.5;
      else if(distsq < 9000000)
        _id_808B4CAFF75E3E3D = 0.25;
      else
        _id_808B4CAFF75E3E3D = 0.1;

      _id_3042A94E9A4AD389 = 1.0 - distsq / 16000000;
      _id_808B4CAFF75E3E3D = _id_808B4CAFF75E3E3D * _id_3042A94E9A4AD389;
      intensity = intensity * _id_808B4CAFF75E3E3D;
      player addtointensitybuffer("weaponFired", int(intensity), 3.0);
    }
  }
}

adddamagetaken(attacker, objweapon, idamage) {
  if(scripts\mp\utility\game::isprophuntgametype()) {
    return;
  }
  _id_35722C9340D87E9F = 0;

  if(isDefined(objweapon) && isDefined(attacker)) {
    _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);

    if(_id_CF4209C200F8BBF4 == "weapon_sniper" || _id_CF4209C200F8BBF4 == "weapon_dmr") {
      if(distance2d(self.origin, attacker.origin) > 2250000)
        _id_35722C9340D87E9F = 1;
    }
  }

  if(_id_35722C9340D87E9F)
    level thread trysaylocalsound(self, "stat_FFA7904A61FA07BE", undefined, 0.75);
  else
    level thread trysaylocalsound(self, "stat_CF3CF044A0DFDABF", undefined, 0.75);
}

onsixfriendlytracking() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 5;

  for(;;) {
    if(!saidtoorecently("stat_213C1CF2E5154626")) {
      _id_D1A3029ED3BCFFD8 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

      foreach(_id_6727329A89208345 in _id_D1A3029ED3BCFFD8) {
        if(_id_6727329A89208345 == self) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(_id_6727329A89208345)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(self)) {
          continue;
        }
        if(validatelistener(self, _id_6727329A89208345)) {
          level thread trysaylocalsound(self, "stat_213C1CF2E5154626");
          break;
        }
      }
    } else
      wait(randomfloatrange(1, 4));

    wait 0.15;
  }
}

validatelistener(_id_7D2852D02216C876, _id_6727329A89208345) {
  _id_7E08CBA3AD354379 = _id_6727329A89208345 getEye();
  _id_2B35B8BFBE7695C4 = _id_7D2852D02216C876 getEye();
  distsq = distancesquared(_id_7E08CBA3AD354379, _id_2B35B8BFBE7695C4);

  if(distsq > 90000)
    return 0;

  _id_FE137DA3505E8574 = anglesToForward(_id_6727329A89208345 getplayerangles());
  _id_C1123C1DA640A028 = vectorNormalize(_id_7E08CBA3AD354379 - _id_2B35B8BFBE7695C4);
  dot = vectordot(_id_FE137DA3505E8574, _id_C1123C1DA640A028);
  _id_5895FF7BD007DC69 = 0.05;

  if(dot > _id_5895FF7BD007DC69) {
    trace = scripts\engine\trace::ray_trace(_id_2B35B8BFBE7695C4, _id_7E08CBA3AD354379, _id_7D2852D02216C876, level._id_C49BB6749E2CE50C);

    if(isDefined(trace["entity"]) && isPlayer(trace["entity"]) || trace["fraction"] > 0.8)
      return 1;
  }

  return 0;
}

getlistenerdirection() {
  return anglesToForward(self getplayerangles());
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {}

checkcasualty() {
  players = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

  foreach(player in players) {
    if(player == self) {
      continue;
    }
    if(distancesquared(self.origin, player.origin) <= 262144) {
      _id_ED24AF7CF5CDC3DD = anglesToForward(player getplayerangles());

      if(length(player.origin - self.origin) > 0) {
        if(scripts\engine\math::anglebetweenvectors(_id_ED24AF7CF5CDC3DD, player.origin - self.origin) < 80) {
          break;
        }
      }
    }
  }
}

getsoundlength() {}

trysaylocalsound(player, _id_FD2287F1DB15A3E0, targetent, delay, location) {
  if(!istrue(level.battlechatterenabled)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  if(istrue(player.bcdisabled) && _id_FD2287F1DB15A3E0 != "flavor_execution") {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(player)) {
    return;
  }
  if(player.team == "spectator") {
    return;
  }
  if(player.team == "codcaster") {
    return;
  }
  if(!isDefined(player.bcinfolastsaytimes)) {
    return;
  }
  if(istrue(player.isspeakingbc)) {
    return;
  }
  if(player scripts\mp\utility\player::isusingremote()) {
    return;
  }
  if(player scripts\mp\utility\perk::_hasperk("specialty_no_battle_chatter")) {
    return;
  }
  if(isDefined(player._id_C3A0F3B16CCE4CA9) && istrue(player._id_C3A0F3B16CCE4CA9.underwater)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && 0 != getdvarint("dvar_25AD2925D6075C8F", 0) && !isDefined(player.bcinfolastsaytimes)) {
    return;
  }
  if(_id_0B96F48DBDCD7110(_id_FD2287F1DB15A3E0) && !player friendly_nearby(level._id_98014172CE4B4E67) && !istrue(level.br_practice_match)) {
    return;
  }
  _id_6294B4374DACFAD4 = randomfloat(1);
  _id_86D4994958E57FB1 = _id_C02B6BA215C2DCA8(_id_FD2287F1DB15A3E0);

  if(_id_6294B4374DACFAD4 > _id_86D4994958E57FB1) {
    return;
  }
  if(!isDefined(delay))
    delay = 0;

  waittime = player getbcwaittime(_id_FD2287F1DB15A3E0, delay);

  if(waittime > level.bcinfo["max_wait_time"] + delay * 1000) {
    return;
  }
  if(gettime() > player._id_CF34556D563B92AE + level.bcinfo["max_wait_time"] + delay * 1000) {
    player.bcinfoqueued = "none";
    player._id_CF34556D563B92AE = 0;
  }

  if(comparesoundpriorities(_id_FD2287F1DB15A3E0, player.bcinfoqueued)) {
    player.bcinfoqueued = _id_FD2287F1DB15A3E0;
    player._id_CF34556D563B92AE = gettime();
  } else
    return;

  level notify("kill_queued_bc_sound_" + player.name);
  return player saylocalsound(waittime, _id_FD2287F1DB15A3E0, targetent, delay, location);
}

saylocalsound(waittime, _id_FD2287F1DB15A3E0, targetent, delay, location) {
  level endon("kill_queued_bc_sound_" + self.name);
  self endon("death_or_disconnect");
  wait(waittime / 1000);

  if(saidtoorecently(_id_FD2287F1DB15A3E0)) {
    return;
  }
  while(waittime <= level.bcinfo["max_wait_time"] + delay * 1000) {
    _id_7AC6C541E01DAE06 = getspeakerinfo(self, _id_336E1F89AE06DFD4(_id_FD2287F1DB15A3E0));

    if(isDefined(_id_7AC6C541E01DAE06["higher"])) {
      time = gettime();
      _id_7AC6C541E01DAE06["higher"]["player"] scripts\engine\utility::waittill_any_3(_func_0F28FD66285FA2C9(_id_7AC6C541E01DAE06["higher"]["sound_alias"]), "death", "disconnect");
      waitframe();
      waittime = waittime + (gettime() - time);
      continue;
    }

    info = _id_7AC6C541E01DAE06["lower"];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < info.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(info[_id_AC0E594AC96AA3A8]["player"])) {
        info[_id_AC0E594AC96AA3A8]["player"] notify(_func_0F28FD66285FA2C9(info[_id_AC0E594AC96AA3A8]["sound_alias"]) + "_interrupt");

        if(soundexists(info[_id_AC0E594AC96AA3A8]["sound_alias"]))
          info[_id_AC0E594AC96AA3A8]["player"] stoplocalsound(info[_id_AC0E594AC96AA3A8]["sound_alias"]);
      }
    }

    break;
  }

  if(waittime > level.bcinfo["max_wait_time"] + delay * 1000) {
    self.bcinfoqueued = "none";
    return;
  } else {
    self.bcinfoqueued = "none";
    return dosound(_id_FD2287F1DB15A3E0, targetent, location);
  }
}

getbcwaittime(_id_FD2287F1DB15A3E0, delay) {
  if(!isDefined(delay))
    delay = 0;

  _id_8F6BC8056E2628FC = 0;
  _id_6327AA8854038FF3 = 0;

  if(isDefined(level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0])) {
    if(_id_FD2287F1DB15A3E0 == "stat_52B2ADECC602D95C" || _id_FD2287F1DB15A3E0 == "stat_0CD1D2547E61FB1E" || _id_FD2287F1DB15A3E0 == "stat_14F86AF7D651B93F") {
      _id_B53830FF2A079E80 = [];
      _id_B53830FF2A079E80[_id_B53830FF2A079E80.size] = "stat_52B2ADECC602D95C";
      _id_B53830FF2A079E80[_id_B53830FF2A079E80.size] = "stat_0CD1D2547E61FB1E";
      _id_B53830FF2A079E80[_id_B53830FF2A079E80.size] = "stat_14F86AF7D651B93F";

      foreach(_id_F90358454413407F in _id_B53830FF2A079E80) {
        if(!isDefined(level.bcinfo["soundEventHistory"][_id_F90358454413407F])) {
          continue;
        }
        foreach(event in level.bcinfo["soundEventHistory"][_id_F90358454413407F]) {
          if(distancesquared(event.origin, self.origin) < 4000000) {
            _id_C4AC6795E14927D0 = event.time + _id_FFD3470F08FCF7A7(_id_F90358454413407F);

            if(_id_C4AC6795E14927D0 > _id_8F6BC8056E2628FC) {
              _id_8F6BC8056E2628FC = _id_C4AC6795E14927D0;
              _id_6327AA8854038FF3 = 1;
            }
          }
        }

        if(_id_6327AA8854038FF3) {
          break;
        }
      }
    } else if(_id_FD2287F1DB15A3E0 == "stat_213C1CF2E5154626") {
      foreach(event in level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0]) {
        if(distancesquared(event.origin, self.origin) < 2250000) {
          _id_C4AC6795E14927D0 = event.time + _id_FFD3470F08FCF7A7(_id_FD2287F1DB15A3E0);

          if(_id_C4AC6795E14927D0 > _id_8F6BC8056E2628FC) {
            _id_8F6BC8056E2628FC = _id_C4AC6795E14927D0;
            _id_6327AA8854038FF3 = 1;
          }
        }
      }
    } else {
      foreach(event in level.bcinfo["soundEventHistory"][_id_FD2287F1DB15A3E0]) {
        if(distancesquared(event.origin, self.origin) < 1048576) {
          _id_C4AC6795E14927D0 = event.time + _id_FFD3470F08FCF7A7(_id_FD2287F1DB15A3E0);

          if(_id_C4AC6795E14927D0 > _id_8F6BC8056E2628FC) {
            _id_8F6BC8056E2628FC = _id_C4AC6795E14927D0;
            _id_6327AA8854038FF3 = 1;
          }
        }
      }
    }
  }

  if(!isDefined(self.bcinfolastsaytimes[_id_FD2287F1DB15A3E0]))
    self.bcinfolastsaytimes[_id_FD2287F1DB15A3E0] = 0;

  _id_DCBB8C92238F7098 = self.bcinfolastsaytimes[_id_FD2287F1DB15A3E0] + _id_A71193E9DB14C926(_id_FD2287F1DB15A3E0);
  _id_EF22548E76B6EB82 = gettime() + delay * 1000;

  if(_id_6327AA8854038FF3)
    timeouttime = max(_id_DCBB8C92238F7098, max(_id_8F6BC8056E2628FC, _id_EF22548E76B6EB82));
  else
    timeouttime = max(_id_DCBB8C92238F7098, _id_EF22548E76B6EB82);

  waittime = timeouttime - gettime();
  return waittime;
}

getspeakerinfo(player, priority, range) {
  if(!isDefined(range))
    range = 1000;

  distsq = range * range;
  _id_139B1D1BF64D28F0 = [];
  _id_139B1D1BF64D28F0["lower"] = [];

  if(isDefined(player) && isDefined(player.team) && player.team != "spectator") {
    for(index = 0; index < level.speakers[player.team].size; index++) {
      _id_7AC6C541E01DAE06 = level.speakers[player.team][index];
      _id_F0EA4030349A33D5 = _id_7AC6C541E01DAE06["player"];
      _id_1F109C1FB8F2D15A = _id_7AC6C541E01DAE06["priority"];

      if(!isDefined(_id_F0EA4030349A33D5)) {
        continue;
      }
      if(distancesquared(_id_F0EA4030349A33D5.origin, player.origin) < distsq) {
        if(isDefined(_id_1F109C1FB8F2D15A)) {
          if(_id_1F109C1FB8F2D15A > priority || _id_1F109C1FB8F2D15A == priority && scripts\engine\utility::cointoss()) {
            _id_139B1D1BF64D28F0["higher"] = _id_7AC6C541E01DAE06;
            return _id_139B1D1BF64D28F0;
          } else
            _id_139B1D1BF64D28F0["lower"][_id_139B1D1BF64D28F0["lower"].size] = _id_7AC6C541E01DAE06;
        }
      }
    }
  }

  return _id_139B1D1BF64D28F0;
}

comparesoundpriorities(_id_CDD17478F51BEEB5, _id_CDD17178F51BE81C) {
  none = _id_CDD17178F51BE81C == "none";

  if(none)
    return none;

  _id_D2BFC86B6D21E9DE = _id_336E1F89AE06DFD4(_id_CDD17178F51BE81C) < _id_336E1F89AE06DFD4(_id_CDD17478F51BEEB5);
  _id_35470D4859F3E586 = _id_336E1F89AE06DFD4(_id_CDD17178F51BE81C) == _id_336E1F89AE06DFD4(_id_CDD17478F51BEEB5) && scripts\engine\utility::cointoss();
  return _id_D2BFC86B6D21E9DE || _id_35470D4859F3E586;
}

saidtoorecently(_id_FD2287F1DB15A3E0, delay) {
  if(!isDefined(self) || !scripts\mp\utility\teams::isgameplayteam(self.team))
    return 1;

  if(!isDefined(delay))
    delay = 0;

  waittime = getbcwaittime(_id_FD2287F1DB15A3E0, delay);

  if(waittime > level.bcinfo["max_wait_time"] + delay * 1000)
    return 1;
  else
    return 0;
}

_id_336E1F89AE06DFD4(_id_FD2287F1DB15A3E0) {
  return scripts\engine\utility::ter_op(isDefined(level.bcinfo["priority"][_id_FD2287F1DB15A3E0]), level.bcinfo["priority"][_id_FD2287F1DB15A3E0], 1);
}

_id_C02B6BA215C2DCA8(_id_FD2287F1DB15A3E0) {
  return scripts\engine\utility::ter_op(isDefined(level.bcinfo["chance"][_id_FD2287F1DB15A3E0]), level.bcinfo["chance"][_id_FD2287F1DB15A3E0], 0.0);
}

_id_FFD3470F08FCF7A7(_id_FD2287F1DB15A3E0) {
  return scripts\engine\utility::ter_op(isDefined(level.bcinfo["timeout_pos"][_id_FD2287F1DB15A3E0]), level.bcinfo["timeout_pos"][_id_FD2287F1DB15A3E0], 1000.0);
}

_id_A71193E9DB14C926(_id_FD2287F1DB15A3E0) {
  return scripts\engine\utility::ter_op(isDefined(level.bcinfo["timeout_player"][_id_FD2287F1DB15A3E0]), level.bcinfo["timeout_player"][_id_FD2287F1DB15A3E0], 1000.0);
}

_id_0B96F48DBDCD7110(_id_FD2287F1DB15A3E0) {
  return scripts\engine\utility::ter_op(isDefined(level.bcinfo["req_friendly"][_id_FD2287F1DB15A3E0]), level.bcinfo["req_friendly"][_id_FD2287F1DB15A3E0], 0);
}