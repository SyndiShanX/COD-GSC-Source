/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_70b5255e06b3968.gsc
***********************************************/

_id_F6F479C00697BD9C() {}

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "rumble_mgl") {
    return;
  }
  init();
}

init() {
  _id_4A0D1F5F6BE0F8C7::init();
  _id_CA38CEBFA1A5DEA5();
}

_id_CA38CEBFA1A5DEA5() {
  _id_618A1163576C3819();
  init_locations();
  _id_F4A8BAD1C5ECD382();
  _id_A350BFD2C433F946();
  level._id_18C3A736721CD3A4 = ::_id_794FC0B829B8026F;
  level.bots_gametype_handles_class_choice = 0;
  thread _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mp_rmbl_sfx");
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["small_snowhit"] = loadfx("vfx/core/impacts/small_snowhit");
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");
  _id_362C58E8BB39BCDA::disablefeature("playerCountLandmarks");
  _id_362C58E8BB39BCDA::disablefeature("movingCircle");
  _id_362C58E8BB39BCDA::disablefeature("randomizeCircleCenter");
  _id_362C58E8BB39BCDA::disablefeature("planeSnapToOOB");
  _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");
  _id_362C58E8BB39BCDA::disablefeature("match_start_VO");
  _id_362C58E8BB39BCDA::disablefeature("c130PlaneLine");
  _id_362C58E8BB39BCDA::enablefeature("planeUseCircleRadius");
  _id_362C58E8BB39BCDA::enablefeature("circleEarlyStart");
  _id_362C58E8BB39BCDA::enablefeature("allowEndGameXPBonus");
  level.br_circle_init_func = ::_id_271D81A8C041DB8C;
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onStartGameType");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onPlayerKilled");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("modifyPlayerDamage");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("playerWelcomeSplashes");
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onMarkPlayerAsEliminated");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onStartGameType", ::onstartgametype);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("lastStandAllowed", ::laststandallowed);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("getFinalCircleCenter", ::_id_56F449F97165EFFC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mapCenterFinalCircle", ::_id_56F449F97165EFFC);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addToC130Infil", ::addtoc130infil);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("createC130PathStruct", ::createc130pathstruct);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::playerrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::onplayerkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onMarkPlayerAsEliminated", ::_id_0F5CFF6DA44A3790);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("infilSequence", ::_id_73BDF8B18E29B13F);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("skipInfilSequence", ::_id_715A028B934AD0C5);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnInitialVehicles", ::_id_684F92AF5A6434C1);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("dangerCircleTick", ::dangercircletick);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addDropOnPlayerDeath", ::adddroponplayerdeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("addSpawnLootContents", ::_id_E6F6246810DFF59F);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", ::modifyplayerdamage);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("endGame", ::_id_504238C900093E09);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("delayedShowTablets", ::delayedshowtablets);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("calculateBRBonusXP", ::calculatebrbonusxp);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("postEndGameSplash", ::_id_2FD05C170B1FF244);
  level.bypassclasschoicefunc = ::_id_2F61EBDBB2A4C86F;

  if(istrue(level._id_059C0B24BA708E3C))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("canTakePickup", ::cantakepickup);

  _id_7FEAED3F883FE324::init();
  _id_48E8D54911F858D3::init();
  _id_14724B3FF6D35BF9::init();
  setDvar("voice_proximity_team", 1);
  setDvar("voice_proximity_enemy", 0);
  setDvar("voice_proximity_radius", -1);
  level thread _id_C1A312EFBD0BD432();
}

_id_618A1163576C3819() {
  level._id_0104CEC67C308610 = spawnStruct();
  level._id_0104CEC67C308610._id_A1D0B894E2371613 = getdvarint("dvar_87FF36A727FE4B49", 0);
  level._id_0104CEC67C308610._id_89EE7450C8FBD311 = getdvarint("dvar_158E120B76320E05", 12000);
  level._id_0104CEC67C308610._id_18D64418918AD507 = getDvar("dvar_D912BC87B0ACA9D5", "random");
  level._id_0104CEC67C308610._id_3415B33E430AE534 = getdvarint("dvar_CF511F289869D90A", 3000);
  level._id_0104CEC67C308610._id_338C433CDF958BC5 = getdvarfloat("dvar_8CF8ABFACB02184F", 0.0);
  level._id_0104CEC67C308610._id_2BFF91208DB9E3B0 = getdvarfloat("dvar_A51F21F5E7FE766A", 5);
  level._id_0104CEC67C308610._id_3DC00B86B4ADCF49 = getdvarfloat("dvar_6A13BFEA6111B547", 1.0);
  level._id_0104CEC67C308610._id_5AD7CF63DBB694AF = getdvarint("dvar_26132418D27D0E81", 1);
  level._id_0104CEC67C308610._id_B1CA423AF95EC976 = getdvarint("dvar_18E5E14A6F648E84", 1);
  level._id_0104CEC67C308610._id_B731201BAD0FB7C8 = getdvarint("dvar_884EE427BE8A789A", 3);
  level._id_0104CEC67C308610._id_A46E3C2E09BCCE8A = getdvarint("dvar_19BEA3FFF760F738", 1);
  level._id_0104CEC67C308610._id_210EAD19055C18E0 = getdvarint("dvar_4383B6C5C9A354E6", 1) == 1;
  level._id_0104CEC67C308610._id_E38B4338820ADAF6 = getdvarint("dvar_6147CB946BDB1A20", 1);
  level._id_0104CEC67C308610._id_7699E75AF0F019BA = getdvarint("dvar_8300E00B1BED4F20", 125);
  level._id_0104CEC67C308610._id_E28B5289D91C6949 = getdvarint("dvar_091D89FBC76D31A7", 25);
  level._id_0104CEC67C308610._id_F987B863624B149D = getdvarint("dvar_5D1B2C7CD8285A43", 100);
  level._id_0104CEC67C308610._id_B486C7577277E222 = getdvarint("dvar_78AC000B35F8A778", 300);
  level._id_0104CEC67C308610._id_02B8025758DCDF88 = getdvarint("dvar_5116B9082D2A1436", 5000);
  level._id_0104CEC67C308610._id_F10850FEE51041C1 = getdvarint("dvar_37EAF070469FAE87", 3000);
  level._id_0104CEC67C308610._id_CEA4F4AED1B051A7 = getdvarfloat("dvar_41546B98F16947D8", 450);
  level._id_0104CEC67C308610._id_90204C7420012EF4 = getdvarint("dvar_F726E7155AFA7F52", 10);
  level._id_0104CEC67C308610._id_BDB5F3EA99833FB7 = getdvarint("dvar_341777E4FFE32225", 5);
  level._id_0104CEC67C308610._id_7B4F16DE8DD44BCB = getdvarint("dvar_28B4B06FABA850F9", 1000);
  level._id_0104CEC67C308610._id_DA8C79754A42FFB2 = getdvarint("dvar_EF7849CA264B300C", 2000);
  level._id_0104CEC67C308610._id_EB84142EF4AD4429 = getdvarint("dvar_C9F7083090E31FD7", 1);
  level._id_0104CEC67C308610._id_E22C01D7A8ED89CA = getdvarint("dvar_FA9385A2BDA67CD3", 680);
  level._id_0104CEC67C308610._id_2A703750A536EC9D = getdvarint("dvar_5C36FC13A330FDD4", 440);
  level._id_0104CEC67C308610._id_0C702BF88DE625C5 = getdvarint("dvar_B06F7254D16CA3D8", 200);
  level._id_0104CEC67C308610._id_F3625A19B2A4F328 = getdvarint("dvar_54755FD62355A106", 0);
  level._id_0104CEC67C308610._id_EA94283EF41D334E = getdvarint("dvar_306EB66EE32270CA", 750);
  level._id_0104CEC67C308610._id_1DCF195956835ACB = getdvarint("dvar_05C8DE11F068B2A2", 45);
  level._id_0104CEC67C308610._id_4FA10F408B75E7B2 = getdvarfloat("dvar_FC551640617DC653", 2.0);
  level._id_0104CEC67C308610._id_513889924E9D92FF = getdvarint("dvar_3B17AA4471E951A9", 0);
  level._id_0104CEC67C308610._id_47737B189C97B49E = getdvarint("dvar_D11CE53045DAC8A0", 120);
  level._id_0104CEC67C308610._id_181F5B611D5A7C6D = getdvarint("dvar_09DFF7181DBD1957", 6000);
  level._id_0104CEC67C308610._id_7CF0A048C2999AB0 = getdvarint("dvar_9DBD9767C3E8763E", 6000);
  level._id_0104CEC67C308610._id_D8976FF357E2A8C4 = getdvarint("dvar_554ADC930AFBC689", 150);
  level._id_0104CEC67C308610._id_BEBDA217EBF6901F = getdvarint("dvar_31E995E43BD371BD", 6);
  level._id_0104CEC67C308610._id_B632C2DCAED34F63 = getdvarint("dvar_ADEAAD91A1969301", 3);
  level._id_0104CEC67C308610._id_FFC9C156B2BA484D = getdvarint("dvar_B8141183D503EB4B", 10);
  level._id_0104CEC67C308610._id_83637D460DD87EE3 = getdvarfloat("dvar_4AC90639AA44DF06", 30.0);
  level._id_0104CEC67C308610._id_C5F76C878C8A9A99 = getdvarint("dvar_44610C91C0758583", 0);
  level._id_0104CEC67C308610._id_B4C111365C4590EE = getdvarfloat("dvar_50BFA60DB8605D88", 5.0);
  level._id_0104CEC67C308610.spawned_vehicles = [];
  level._id_0104CEC67C308610._id_46F0FEF76D38D30D = ["tac_rover", "atv", "veh9_mil_cargo_truck", "veh9_suv_1996", "little_bird_mg", "veh9_utv", "veh9_palfa", "cargo_truck_susp_aa"];
  level._id_0104CEC67C308610._id_6354FD2722A0051D = [];
  level._id_0104CEC67C308610._id_C49B1D649A8D9C34 = _id_715028F54BAD19A1::_id_FDD0A4EFCD97F3BE;
  level._id_0104CEC67C308610._id_2833A507B388532E = _id_715028F54BAD19A1::_id_2F0FB1B1516DF8F8;

  if(getdvarint("dvar_56EE05D329A9188E", 1)) {
    level._id_5A81CD5A6AE1C552 = getdvarfloat("dvar_7CD394FAAA319BD0", 20);
    level._id_ED3BBED90E848793 = [];
    level._id_ED3BBED90E848793["uav"] = [];
  }

  level.useautorespawn = getdvarint("dvar_67AF73AA66F5530B", 1);
  level.autorespawnwaittime = getdvarfloat("dvar_3643B69156468195", 5.0);
  level.tokenrespawnwaittime = getdvarint("dvar_B6185A7F1D3C4B08", level.autorespawnwaittime);
  level.incrementalrespawnpunish = getdvarint("dvar_8245DDEA294ACB9B", 0);
  level.incrementalrespawnpunishmax = getdvarfloat("dvar_6BD6CD1F48D06C4A", 15);
  level.respawnheightoverride = getdvarint("dvar_189CE7D96E20BAE2", 3000);
  level.respawntimedisable = getdvarint("dvar_3A0D69C43EFAC51C", 0);
  level.parachutedeploydelay = getdvarfloat("dvar_D4120F34FC87B36C", 0.5);
  level._id_2DAF0F726F89D5E7 = spawnStruct();
  level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = undefined;
  level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = undefined;
  level.skipweapondropondeath = getdvarint("dvar_FB39282BBDB8342A", 1);
  level.skipequipmentdropondeath = getdvarint("dvar_1FCEF5EDF966CD76", 1);
  level.forcearmordropondeath = getdvarint("dvar_34F5D0B786668451", 1);
  level._id_CCAA13C7226BF84D = getdvarint("dvar_58E53C976CAB3D83", 1);
  level.adddroponplayerdeath = ::adddroponplayerdeath;
  level.laststand = getdvarint("dvar_32F8AD37D1023740", 0);
  level.forcedisablelaststand = !level.laststand;
  level.brdisablefinalkillcam = 1;
  level.shownonspectatingwinnersplash = 1;
  level._id_E466FD83409A58E2 = 1;
  level._id_059C0B24BA708E3C = getdvarint("dvar_23DEA472C0EA9E3D", 1);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("body", ::_id_814FEE984765974E);
}

_id_5CB13357351637C7(_id_BEE44214BE167736) {
  level._id_94325EE040AD72C3 = [];

  switch (_id_BEE44214BE167736) {
    case "island_storage":
      level._id_94325EE040AD72C3[level._id_94325EE040AD72C3.size] = [(-25959, 14148, 2220), (0, 0, 0)];
      level._id_94325EE040AD72C3[level._id_94325EE040AD72C3.size] = [(-29851, -2135, 3100), (0, 0, 0)];
      break;
    case "island_docks":
      level._id_94325EE040AD72C3[level._id_94325EE040AD72C3.size] = [(22326, 44353, 688), (0, 135, 0)];
      level._id_94325EE040AD72C3[level._id_94325EE040AD72C3.size] = [(11367, 53645, 316), (0, 0, 0)];
      break;
    default:
      break;
  }
}

_id_F4A8BAD1C5ECD382() {
  _setdomflagiconinfo("waypoint_captureneutral_br_a", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_b", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_c", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_d", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_captureneutral_br_e", "neutral", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_capture_br_a", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_capture_br_b", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_capture_br_c", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_capture_br_d", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_capture_br_e", "enemy", "MP_BR_INGAME/DOM_CAPTURE", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defend_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defend_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defend_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defend_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defend_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defending_br_a", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defending_br_b", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defending_br_c", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defending_br_d", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defending_br_e", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_contested_br_a", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_contested_br_b", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_contested_br_c", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_contested_br_d", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_contested_br_e", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_taking_br_a", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_taking_br_b", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_taking_br_c", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_taking_br_d", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_taking_br_e", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_losing_br_a", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_losing_br_b", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_losing_br_c", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_losing_br_d", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_losing_br_e", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1);
  level._effect["vfx_smk_signal_green"] = loadfx("vfx/iw8_cp/prop/vfx_smk_signal_green");
  _id_25E2B333B4736A48::setupdom();
  level thread _id_A1577D7A88E90D7D();
}

_id_D9C64C99BD5F47A0() {
  waittillframeend;
  game["dialog"]["gametype"] = "gametype_rumble";
  game["dialog"]["primary_objective"] = "gametype_desc_rumble_alt";
  game["dialog"]["score_friendly_50_percent"] = "score_friendly_50_percent";
  game["dialog"]["score_friendly_90_percent"] = "score_friendly_90_percent";
  game["dialog"]["score_friendly_ahead_50"] = "score_friendly_ahead_50";
  game["dialog"]["score_friendly_win"] = "score_friendly_win";
  game["dialog"]["score_enemy_50_percent"] = "score_enemy_50_percent";
  game["dialog"]["score_enemy_90_percent"] = "score_enemy_90_percent";
  game["dialog"]["score_enemy_ahead_50"] = "score_enemy_ahead_50";
  game["dialog"]["score_enemy_win"] = "score_enemy_win";
  game["dialog"]["dom_point_incoming"] = "dom_point_incoming";
  game["dialog"]["dom_point_started"] = "dom_point_started";
  game["dialog"]["dom_point_friendly_capture_single"] = "dom_point_friendly_capture";
  game["dialog"]["dom_point_friendly_capture_1"] = "dom_point_friendly_capture_1";
  game["dialog"]["dom_point_friendly_capture_2"] = "dom_point_friendly_capture_2";
  game["dialog"]["dom_point_friendly_capture_all"] = "dom_point_friendly_capture_all";
  game["dialog"]["dom_point_enemy_capture_single"] = "dom_point_enemy_capture";
  game["dialog"]["dom_point_enemy_capture_1"] = "dom_point_enemy_capture_1";
  game["dialog"]["dom_point_enemy_capture_2"] = "dom_point_enemy_capture_2";
  game["dialog"]["dom_point_enemy_capture_all"] = "dom_point_enemy_capture_all";
  game["dialog"]["power_zone_incoming"] = "dx_bra_bchr_clsh_power_zone_incoming";
  game["dialog"]["power_zone_active"] = "dx_bra_bchr_clsh_power_zone_active";

  if(!isDefined(game["dialogForAllTeams"]))
    game["dialogForAllTeams"] = [];

  game["dialogForAllTeams"]["power_zone_incoming"] = 1;
  game["dialogForAllTeams"]["power_zone_active"] = 1;
  game["dialog"]["hvt_incoming"] = "hvt_incoming";
  game["dialog"]["hvt_started"] = "hvt_started";
  game["dialog"]["hvt_hunted"] = "hvt_hunted";
  game["dialog"]["hvt_survived"] = "hvt_survived";
  game["dialog"]["hvt_friendly_down"] = "hvt_friendly_down";
  game["dialog"]["hvt_all_friendlies_down"] = "hvt_friendlies_down";
  game["dialog"]["hvt_enemy_down"] = "hvt_enemy_down";
  game["dialog"]["hvt_all_enemies_down"] = "hvt_enemies_down_all";
}

_setdomflagiconinfo(name, colors, string, icon, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 0;
  level.waypointstring[name] = string;
  level.waypointshader[name] = icon;
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

_id_A1577D7A88E90D7D() {
  level waittill("br_dialog_initialized");
  level.disableinitplayergameobjects = 0;
}

laststandallowed(_id_90D58DA134EF125F) {
  if(level.laststand)
    return 1;

  return 0;
}

_id_C1A312EFBD0BD432() {
  waitframe();
  level._id_F6C3CEC4663A225D = ::_id_05B532C43333DDB1;
  level.ontimelimit = ::_id_65C35EB1566A42BC;
  level.endgame = ::endgame;
  level.br_endgamesplashcallback = ::_id_099E535CAC0AD68B;
  _id_1E222FE3807B7BBC::_id_E08EE6939EBFDB4D(::_id_90AA80A0D854DD5D);
  scripts\mp\rank::registerscoreinfo("kill", "stat_7CE4FD9430E80CEA", level._id_0104CEC67C308610._id_7699E75AF0F019BA);
  scripts\mp\rank::registerscoreinfo("assist", "stat_7CE4FD9430E80CEA", level._id_0104CEC67C308610._id_E28B5289D91C6949);
  scripts\mp\rank::registerscoreinfo("br_cacheopen", "stat_7CE4FD9430E80CEA", level._id_0104CEC67C308610._id_F987B863624B149D);

  if(!level.laststand)
    scripts\mp\tweakables::settweakablevalue("player", "laststand", 0);

  _id_362C58E8BB39BCDA::disablefeature("waitLoadoutDone");
  scripts\mp\flags::gameflaginit("rumble_location_selected", 1);
  scripts\mp\flags::gameflaginit("infil_complete", 0);
  scripts\mp\flags::gameflaginit("rumble_ui_hq_objectives_init_finish", 0);
  level thread _id_D9C64C99BD5F47A0();
  level thread _id_C00A33B9A89F6639();
}

_id_C00A33B9A89F6639() {
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  scripts\mp\flags::gameflagwait("infil_complete");
  level.br_ending_delay = 5;
  level thread _id_47E6AFB49EFD70B2();
  level thread _id_A3D1311AEB840D52();
  level thread _id_9CF505D78659AF0D();
  level thread _id_3BFE3FB3E7FE088F();
}

_id_13E7F97CCFE0F228() {}

_id_271D81A8C041DB8C() {
  level.br_level.staticcircle = 1;
  _id_BEE44214BE167736 = _id_61C0CDEAF03EF60C();
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC = _id_F158F856C08C573C(_id_BEE44214BE167736);
  _id_5CB13357351637C7(_id_BEE44214BE167736);

  if(!scripts\mp\flags::gameflagexists("rumble_location_selected "))
    scripts\mp\flags::gameflaginit("rumble_location_selected", 1);

  level notify("rumble_location_selected");
  level._id_E6BDEFD8842BDD49 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013;
  _id_5605A6B8DC0CC05F = getdvarint("scr_br_timelimit");
  level.br_level.br_circledelaytimes = [_id_5605A6B8DC0CC05F * 2];
  level.br_level.br_circleclosetimes = [_id_5605A6B8DC0CC05F * 2];
  level.br_level.br_circleradii = [level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius];
  level.br_level.br_circleminimapradii = [level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius];
  level.br_level.br_circleshowdelaydanger = [0];
  level.br_level.br_circleshowdelaysafe = [0];
  _id_B4BC8E806C1993A4();
}

_id_56F449F97165EFFC() {
  return level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013;
}

createc130pathstruct() {
  _id_F9CBFF5134DA960B = (level.br_level.br_circlecenters[0][0], level.br_level.br_circlecenters[0][1], 0);
  _id_E5BD279D3767139F = level.br_level.br_circleradii[0] * 0.66;
  c130pathstruct = _id_45B2B4A889E633FA::createtestc130path(_id_F9CBFF5134DA960B, _id_E5BD279D3767139F);
  return c130pathstruct;
}

addtoc130infil() {
  thread kickplayersatcircleedge();
}

kickplayersatcircleedge() {
  level endon("game_ended");
  self endon("death");
  _id_432421C6EC2BFCD9 = distance(self.pathstruct.startpt, self.pathstruct.endptui);
  _id_42F65B4B53C1F5D4 = _id_432421C6EC2BFCD9 / _id_45B2B4A889E633FA::getc130speed() - 5;
  wait(_id_42F65B4B53C1F5D4);

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.br_infil_type) && player.br_infil_type == "c130" && !isDefined(player.jumptype)) {
      player.jumptype = "outOfBounds";
      player notify("halo_kick_c130");
    }
  }
}

_id_54E570DB2C402475() {}

_id_53D3FF5E1EA3CCFA() {
  if(istrue(level._id_0104CEC67C308610._id_8D001511B174EF1E)) {
    if(!istrue(self._id_DDB5596A39F6A62E)) {
      _id_852E518BEF02E263();
      thread _id_2373F9D37EBDCA9B();
    }
  }
}

_id_852E518BEF02E263() {
  if(!istrue(self._id_DDB5596A39F6A62E)) {
    if(!isalive(self) && !istrue(self.waitingtospawnamortize))
      scripts\mp\playerlogic::spawnplayer(0);

    if(istrue(self.br_iseliminated))
      _id_0A34750D17473C49::unmarkplayeraseliminated(self);

    self setclientomnvar("ui_br_infil_started", 1);
    self setclientomnvar("ui_br_infiled", 0);
    self setclientomnvar("ui_show_mode_announcement", 1);
    spawnpoint = _id_5FB9C973E0589472();
    _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    self._id_DDB5596A39F6A62E = 1;
  }
}

_id_73BDF8B18E29B13F() {
  level._id_0104CEC67C308610._id_8D001511B174EF1E = 1;

  if(!_id_362C58E8BB39BCDA::isbrgametypefuncdefined("handleBRLateSpawnPlayer"))
    _id_362C58E8BB39BCDA::registerbrgametypefunc("handleBRLateSpawnPlayer", ::_id_53D3FF5E1EA3CCFA);

  scripts\mp\deathicons::removealldeathicons();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(!isDefined(player)) {
      continue;
    }
    player _id_852E518BEF02E263();
  }

  wait 2.0;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread _id_2373F9D37EBDCA9B();
  }

  level thread _id_300AD85795587692();
  game["music"]["losing_axis"] = [];
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_1";
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_2";
  game["music"]["losing_axis"][game["music"]["losing_axis"].size] = "mus_easterneurope_losing_3";
  game["music"]["losing_allies"] = [];
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_1";
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_2";
  game["music"]["losing_allies"][game["music"]["losing_allies"].size] = "mus_easterneurope_losing_3";
  game["music"]["winning_axis"] = [];
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_1";
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_2";
  game["music"]["winning_axis"][game["music"]["winning_axis"].size] = "mus_easterneurope_winning_3";
  game["music"]["winning_allies"] = [];
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_1";
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_2";
  game["music"]["winning_allies"][game["music"]["winning_allies"].size] = "mus_easterneurope_winning_3";
  scripts\mp\flags::gameflagset("prematch_fade_done");
  scripts\mp\flags::gameflagset("infil_complete");
  waitframe();

  if(!getdvarint("dvar_7EE59002A8A6D262", 1))
    level thread _id_3ACF1C0EBAF602F2::disablealltablets();

  setomnvar("ui_br_circle_state", 4);
}

_id_300AD85795587692() {
  level endon("game_ended");
  wait 10;
  level thread scripts\mp\music_and_dialog::stopsuspensemusic();
}

_id_715A028B934AD0C5() {
  scripts\mp\flags::gameflagset("infil_complete");
}

onstartgametype() {
  level thread _id_05B532C43333DDB1();
}

_id_4F3F1021AFEDED8F() {}

playerwelcomesplashes(data) {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  self waittill("player_rumble_spawn_complete");
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("gametype", self, 0);
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0);

  while(!self isonground())
    waitframe();

  _id_715028F54BAD19A1::branalytics_landing(self);
}

_id_B4BC8E806C1993A4() {
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnheight["allies"] = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnheight["axis"] = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_36EA54569DB6D93E;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["allies"] = anglesToForward((0, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_0FC62D67B6110893, 0));
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["axis"] = anglesToForward((0, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_3207814114EB2E20, 0));
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_FEAD98BEAF6F8FFB;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemax = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_FE8A8EBEAF493245;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_DBB390417265EF42;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemax = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_DB907A41723F7728;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnoffsettacinsertmin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_CD36405F71D648DC;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnoffsettacinsertmax = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_CD132E5F71AFD98E;
  _id_0DF617B966607158 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["allies"] * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin;
  _id_96FF9E43E1802A0B = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["axis"] * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["allies"] = _id_0DF617B966607158;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["axis"] = _id_96FF9E43E1802A0B;
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.faceenemyspawn = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A66534BFF0EFD6E3;
  level thread _id_89318FBCC221765E();
}

_id_89318FBCC221765E() {
  level.redeployspawns = [];
  level.redeployspawns["allies"] = [];
  level.redeployspawns["axis"] = [];
  spawncount = getdvarint("dvar_4838B7C39021124C", 50);
  _id_E14067C17E332089 = getdvarint("dvar_10ADDADE211A63A8", 5);

  while(!isDefined(level.teamnamelist))
    waitframe();

  _id_7426330C61B55320 = 0;
  _id_FC6473E43863F340 = 0;

  foreach(team in level.teamnamelist) {
    if(_id_FC6473E43863F340 && team == "team_two_hundred") {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawncount; _id_AC0E594AC96AA3A8++) {
      spawnpoint = spawnStruct();
      spawnangles = vectortoangles(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector[team]);
      _id_6768A915ED3C9351 = randomfloatrange(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemax);
      spawnvector = anglesToForward((0, spawnangles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), _id_6768A915ED3C9351, _id_6768A915ED3C9351 * -1), 0));
      _id_53A3ED00687ACC12 = randomfloatrange(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemax);
      spawnorigin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + spawnvector * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * _id_53A3ED00687ACC12;

      if(istrue(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.faceenemyspawn)) {
        _id_D663E897E8857AC3 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin[scripts\mp\utility\game::getotherteam(team)[0]] - spawnorigin;
        spawnangles = vectortoangles(_id_D663E897E8857AC3);
      } else
        spawnangles = vectortoangles(spawnvector * -1);

      _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
      _id_914989D39AD0D603 = 0;
      highesttraceindex = 0;
      _id_C0FD4E75A105DEAE = 10;
      results = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_E14067C17E332089; _id_AC0E5C4AC96AAA41++) {
        result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000) + anglesToForward(spawnangles) * _id_AC0E5C4AC96AAA41 * 2000, undefined, _id_FBCABD62B8F66EB8)["position"];
        results[results.size] = result;

        if(result[2] > _id_914989D39AD0D603) {
          _id_914989D39AD0D603 = result[2];
          highesttraceindex = _id_AC0E5C4AC96AAA41;
        }

        _id_7426330C61B55320++;

        if(_id_7426330C61B55320 == 5) {
          waitframe();
          _id_7426330C61B55320 = 0;
        }
      }

      spawnorigin = (spawnorigin[0], spawnorigin[1], _id_914989D39AD0D603 + level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnheight[team]);
      spawnpoint.origin = spawnorigin;
      spawnpoint.traceresults = results;
      spawnpoint.highesttraceindex = highesttraceindex;
      spawnpoint.angles = spawnangles;
      spawnpoint.time = gettime();
      spawnpoint.team = team;
      spawnpoint.index = -1;
      level.redeployspawns[team][level.redeployspawns[team].size] = spawnpoint;
    }
  }
}

_id_5FB9C973E0589472() {
  if(!isDefined(self.redeployspawn)) {
    self.redeployspawn = spawnStruct();
    return _id_ADB98D6A85A67283();
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    spawnpoint = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      foreach(_id_F90358454413407F in level.teamnamelist) {
        if(_id_F90358454413407F != self.team)
          self playsoundtoteam("tactical_spawn", _id_F90358454413407F);
      }
    }

    foreach(tank in level.ugvs) {
      if(distancesquared(tank.origin, self.setspawnpoint.playerspawnpos) < 1024)
        tank notify("damage", 5000, tank.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, makeweapon("killstreak_jammer_mp"));
    }

    spawnangles = vectortoangles(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector[self.team]);
    _id_6768A915ED3C9351 = randomfloatrange(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnanglemax);
    spawnvector = anglesToForward((0, spawnangles[1] + scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), _id_6768A915ED3C9351, _id_6768A915ED3C9351 * -1), 0));
    _id_53A3ED00687ACC12 = randomfloatrange(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnoffsettacinsertmin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnoffsettacinsertmax);
    spawnorigin = self.setspawnpoint.playerspawnpos + spawnvector * _id_53A3ED00687ACC12;

    if(distance2dsquared(spawnorigin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013) > level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius) {
      _id_2099C256F875AD40 = vectorNormalize(spawnorigin - level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013);
      spawnorigin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + _id_2099C256F875AD40 * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * 0.99;
    }

    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    groundorigin = scripts\engine\utility::drop_to_ground(spawnorigin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
    spawnorigin = (spawnorigin[0], spawnorigin[1], groundorigin[2]);
    spawnorigin = spawnorigin + (0, 0, 1) * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnheight[self.team];
    self.redeployspawn.origin = spawnorigin;
    self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.time = gettime();
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
  } else if(self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid)
    return _id_ADB98D6A85A67283();

  return self.redeployspawn;
}

_id_ADB98D6A85A67283() {
  index = randomint(level.redeployspawns[self.team].size);
  spawnpoint = level.redeployspawns[self.team][index];
  self.redeployspawn.origin = spawnpoint.origin;
  self.redeployspawn.angles = spawnpoint.angles;
  self.redeployspawn.time = gettime();
  self.redeployspawn.team = self.team;
  self.redeployspawn.index = -1;
  self.redeployspawn.lifeid = self.lifeid;
  return self.redeployspawn;
}

_id_D873616665B0F13E() {
  _id_C40592D1D3225AC7 = (0, randomintrange(0, 360), 0);
  spawnvector = anglesToForward(_id_C40592D1D3225AC7);
  _id_53A3ED00687ACC12 = randomfloatrange(0, 0.9);
  _id_AD3758FD3576AE97 = _id_0930A1E7BD882C1D::getinfilspawnoffset();
  spawnorigin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + spawnvector * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * _id_53A3ED00687ACC12;
  spawnorigin = spawnorigin + (0, 0, _id_AD3758FD3576AE97);
  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = _id_C40592D1D3225AC7;
  spawnpoint.time = gettime();
  spawnpoint.team = self.team;
  spawnpoint.index = -1;
  spawnpoint.lifeid = self.lifeid;
  return spawnpoint;
}

_id_2373F9D37EBDCA9B() {
  self endon("disconnect");
  _id_2CEDCC356F1B9FC8::_id_2DCD6A9EB79260A6();
  self._id_18EF015C510995E4 = 1;
  self.respawningbr = 1;
  self.plotarmor = 1;

  if(!isalive(self) && !istrue(self.waitingtospawnamortize))
    scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.br_iseliminated))
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);

  waitframe();
  thread _id_1682B2D0DA06FFA2();
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  self.plotarmor = undefined;
  self.respawningbr = undefined;
  self.brneverlanded = 1;
  self freezecontrols(1);
  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_rumble_mgl::player_first_spawn_setup()");
  thread _id_8626D7309E9F7FD5();
}

_id_2F61EBDBB2A4C86F() {
  _id_0AC2E2DC79F3D177 = "";

  if(isbot(self) && scripts\mp\bots\bots_loadout::_id_A693C24DEF6FB1ED())
    _id_0AC2E2DC79F3D177 = "callback";
  else {
    _id_C7DAB7E6D3E3E3FD = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
    _id_0AC2E2DC79F3D177 = scripts\mp\menus::getclasschoice(_id_C7DAB7E6D3E3E3FD);
  }

  self.pers["class"] = _id_0AC2E2DC79F3D177;
  self.class = _id_0AC2E2DC79F3D177;
  return _id_0AC2E2DC79F3D177;
}

_id_702F4B8644CDF855() {
  self setclientomnvar("ui_show_mode_announcement", 0);
  waitframe();
  self setclientomnvar("ui_show_mode_announcement", -1);
}

_id_8626D7309E9F7FD5() {
  self endon("disconnect");
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  spawnpoint = _id_5FB9C973E0589472();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1, undefined, undefined, undefined, 1);
  self setclientomnvar("ui_br_infiled", 1);
  thread _id_702F4B8644CDF855();
  self notify("player_rumble_spawn_complete");

  if(istrue(self.br_iseliminated))
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);

  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
  thread _id_5E68F864CF03CC57();

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    if(level.mapname == "mp_don4" || level.mapname == "mp_don4_pm" || level.mapname == "mp_wz_island")
      _id_7BCC0B40D1921628();

    thread _id_623391230F801E2B();
  }

  waittillframeend;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self._id_18EF015C510995E4 = 0;
  _id_258C4F40DEE8189A();
  thread _id_90024CAC0C9C5F6D();
}

_id_258C4F40DEE8189A(_id_BDE7478B4A6080AD, _id_BDE7468B4A607E7A, radius) {
  if(isDefined(_id_BDE7478B4A6080AD) && isDefined(_id_BDE7468B4A607E7A) && isDefined(radius)) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", _id_BDE7478B4A6080AD);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", _id_BDE7468B4A607E7A);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", getdvarfloat("dvar_DD9AF11D93097CD7", 1.0));
  } else if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", level.br_circle.dangercircleent.origin[0]);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", level.br_circle.dangercircleent.origin[1]);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", getdvarfloat("dvar_DD9AF11D93097CD7", 1.0));
  } else {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_x", 0);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_cursor_pos_override_y", 0);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_compass_tacopsmap_size_override", 0);
  }
}

_id_623391230F801E2B() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("rumble_remove_spawn_protection");
  self._id_C6336909F8A63778 = 1;
  thread _id_8A422CB2F391651D();
}

_id_8A422CB2F391651D() {
  thread _id_467591EC9CA1BE6F();
  level endon("game_ended");
  self endon("disconnect");
  self endon("rumble_remove_spawn_protection");
  scripts\engine\utility::waittill_any_timeout_3(10, "vehicle_enter", "weapon_fired", "rumble_remove_spawn_protection_early");
  thread _id_B4142509F4DAFDE1();
}

_id_B4142509F4DAFDE1() {
  self._id_C6336909F8A63778 = 0;
  self notify("rumble_remove_spawn_protection");
}

_id_467591EC9CA1BE6F() {
  self endon("death_or_disconnect");

  while(!self isonground())
    waitframe();

  self notify("rumble_remove_spawn_protection_early");
}

playerrespawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(game["state"] == "playing" && !level.timerstopped) {
    _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining() / 1000;

    if(_id_8DD9F2EB8215A139 < 12.0)
      return 0;
  }

  thread playerspawn(_id_642470E1ABC1BBF9);
  return 1;
}

playerspawn(_id_642470E1ABC1BBF9) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("dvar_1560ECA11FD78307", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  if(istrue(level.gameended))
    level waittill("forever");

  while(istrue(self.killcam))
    waitframe();

  _id_30839284ADD41CED = level.autorespawnwaittime;
  _id_AC5CF023CA77DB21 = getdvarfloat("dvar_0DE56EB4B8051C0E", 5.0);

  if(_id_30839284ADD41CED < _id_AC5CF023CA77DB21)
    _id_30839284ADD41CED = _id_AC5CF023CA77DB21;

  if(level.respawntimedisable != 0)
    _id_30839284ADD41CED = 0;

  thread _id_8E7500031785B051(_id_30839284ADD41CED);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  _id_A294C35CBB452CBF = _id_30839284ADD41CED - _id_AC5CF023CA77DB21;
  _id_D2F5422694822652 = _id_30839284ADD41CED - _id_A294C35CBB452CBF;
  _id_C445F6D6BC71ED85 = _id_30839284ADD41CED - getdvarfloat("dvar_1FAAC73789CEF04E", 6.0);
  thread fadetogearingup();
  thread updateprestreamrespawn();
  _id_E1381852E44DDAD3 = getdvarfloat("dvar_A288850F2A1EAF9D", 1.0);
  wait(_id_E1381852E44DDAD3);
  self notify("stop_updatePrestreamRespawn");
  spawnpoint = _id_5FB9C973E0589472();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(undefined, 0);

  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1);
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit) && self.operatorcustomization.suit != "iw9_defaultsuit_mp") {
    self.operatorcustomization.suit = "iw9_defaultsuit_mp";
    scripts\mp\utility\player::_setsuit("iw9_defaultsuit_mp");
  }

  if(isDefined(self._id_AC902DA8D5271412))
    self._id_AC902DA8D5271412 = undefined;

  if(scripts\mp\flags::gameflag("prematch_fade_done")) {
    if(level.mapname == "mp_don4" || level.mapname == "mp_don4_pm" || level.mapname == "mp_wz_island")
      _id_7BCC0B40D1921628();

    thread _id_623391230F801E2B();
  }
}

_id_8E7500031785B051(_id_CEBDB0E614D4D7D2) {
  self endon("disconnect");
  scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_CEBDB0E614D4D7D2 * 1000));

  if(isDefined(_id_CEBDB0E614D4D7D2))
    wait(_id_CEBDB0E614D4D7D2);

  thread _id_1491AF5E96C708E4();
}

_id_1491AF5E96C708E4() {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
}

_id_5E68F864CF03CC57() {
  self endon("death_or_disconnect");
  waitframe();
  _id_07C40FA80892A721::givestartingarmor();
}

fadetogearingup(waittime) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  thread _id_F8715341BB95FCFA();
  _id_B59F471C2C064E56 = 1.0;
  wait(_id_B59F471C2C064E56 - 0.25);
  thread _id_90024CAC0C9C5F6D();
  _id_258C4F40DEE8189A();
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 2);
  wait 0.25;

  if(getdvarint("dvar_E912E88184530F28", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = _id_5FB9C973E0589472();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

_id_F8715341BB95FCFA() {
  level endon("game_ended");
  self endon("disconnect");
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  self waittill("spawned_player");
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

_id_1682B2D0DA06FFA2() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = _id_5FB9C973E0589472();
      currenttime = gettime();

      if(currenttime - self.intermissionspawntime >= getdvarfloat("dvar_B72FC168D3582ECE", 2.0) * 1000) {
        spawnpoint = _id_5FB9C973E0589472();
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = _id_5FB9C973E0589472();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1.0;
  }
}

spawnhandled(player) {
  if(isDefined(player))
    return istrue(player._id_DDB5596A39F6A62E);

  return scripts\mp\flags::gameflag("prematch_done");
}

modifyplayerdamage(_id_E23543CE88861E63) {
  idamage = _id_E23543CE88861E63.damage;
  eattacker = _id_E23543CE88861E63.attacker;

  if(istrue(self._id_C6336909F8A63778)) {
    if(isDefined(eattacker) && (isPlayer(eattacker) || isbot(eattacker))) {
      idamage = 0;
      eattacker _id_5762AC2F22202BA2::updatedamagefeedback("hitspawnprotect");
    }
  } else
    idamage = _id_4A0D1F5F6BE0F8C7::modifyplayerdamage(_id_E23543CE88861E63);

  return idamage;
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(level.gameended) {
    return;
  }
  victim = _id_642470E1ABC1BBF9.victim;
  attacker = _id_642470E1ABC1BBF9.attacker;
  _id_24ABB0ECA69C20E4::_id_FA66101B60F4D9BC(_id_642470E1ABC1BBF9);
  _id_48E8D54911F858D3::_id_FA66101B60F4D9BC(_id_642470E1ABC1BBF9);
  _id_CF2E52A95817434F(attacker, victim, _id_642470E1ABC1BBF9.meansofdeath);

  if(!isDefined(attacker) || !isPlayer(attacker) || !isDefined(victim)) {
    return;
  }
  if(victim == attacker) {
    return;
  }
  _id_B4DBBE7DED40FEF5(attacker, victim);
  _id_642479D7AB426BE0(attacker, victim);
  _id_0C4F79070E147BCA(attacker, victim);

  if(isDefined(attacker.team)) {
    _id_A47AF4BCED433AAE = level._id_0104CEC67C308610._id_5AD7CF63DBB694AF;

    if(istrue(level._id_0104CEC67C308610._id_E38B4338820ADAF6)) {
      if(istrue(attacker._id_D933C184544F70FC))
        _id_A47AF4BCED433AAE = _id_A47AF4BCED433AAE * 2;

      if(istrue(attacker._id_C2CB1DE83671B60D))
        _id_A47AF4BCED433AAE = _id_A47AF4BCED433AAE * 2;
    } else if(istrue(attacker._id_D933C184544F70FC) || istrue(attacker._id_C2CB1DE83671B60D))
      _id_A47AF4BCED433AAE = _id_A47AF4BCED433AAE * 2;

    level scripts\mp\gamescore::giveteamscoreforobjective(attacker.pers["team"], _id_A47AF4BCED433AAE, 0);
  }
}

_id_0F5CFF6DA44A3790(player) {
  _id_4A0D1F5F6BE0F8C7::_id_305F60799DC60D7C(player);
}

adddroponplayerdeath(dropstruct, attacker, meansofdeath, weaponobj) {
  if(!isDefined(attacker) || !isDefined(self) || attacker == self) {
    return;
  }
  _id_7BD83AA11DDAB79F = getdvarint("dvar_ACD4420F1ADC812D", 33);

  if(istrue(self._id_C2CB1DE83671B60D))
    _id_7BD83AA11DDAB79F = 100;

  _id_7FEAED3F883FE324::_id_92BA9D24DB6AE86D(dropstruct, _id_7BD83AA11DDAB79F);
}

onplayerconnect(player) {
  player endon("disconnect");
  player waittill("spawned_player");

  if(istrue(level._id_0104CEC67C308610._id_A1D0B894E2371613))
    player _id_B6CFEF2BF78FE1B3();

  player thread _id_5E68F864CF03CC57();
  player thread _id_061A6648C0A01CAD();
}

_id_061A6648C0A01CAD() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    thread _id_5E68F864CF03CC57();
  }
}

playerdropplunderondeath(dropstruct, attacker) {
  if(istrue(self.c130))
    return 1;

  if(istrue(level.gameended))
    return 1;

  if(isDefined(self.plundercount) && self.plundercount > 0)
    _id_258681915091F653 = self.plundercount;
  else
    _id_258681915091F653 = 0;

  if(istrue(self.isdisconnecting)) {
    _id_6AEE9C9054F09ED5 = 0;
    _id_B64F283113C99581 = level._id_0104CEC67C308610._id_2BFF91208DB9E3B0;
  } else {
    _id_6AEE9C9054F09ED5 = int(_id_258681915091F653 * level._id_0104CEC67C308610._id_3DC00B86B4ADCF49 + 0.5);
    _id_B64F283113C99581 = int(level._id_0104CEC67C308610._id_2BFF91208DB9E3B0 + _id_258681915091F653 * level._id_0104CEC67C308610._id_338C433CDF958BC5 + 0.5);
  }

  self.plundercountondeath = _id_6AEE9C9054F09ED5;
  _id_6AFF3948CF4CCA03::playersetplundercount(_id_6AEE9C9054F09ED5);

  if(_id_B64F283113C99581 <= 0) {
    return;
  }
  _id_6AFF3948CF4CCA03::dropcondensedplunder(_id_B64F283113C99581, dropstruct);
  return 1;
}

_id_DA239C94ED5C7867() {}

init_locations() {
  if(level.mapname == "mp_wz_island") {
    _id_7911DF47EA68D2B6("island_mines", 1);
    _id_7911DF47EA68D2B6("island_agport", 1);
    _id_7911DF47EA68D2B6("island_beachhead", 1);
    _id_7911DF47EA68D2B6("island_village", 0);
    _id_7911DF47EA68D2B6("island_capital", 1);
    _id_7911DF47EA68D2B6("island_airfield", 1);
    _id_7911DF47EA68D2B6("island_docks", 1);
    _id_7911DF47EA68D2B6("island_storage", 1);
    _id_7911DF47EA68D2B6("island_full", 0);
  } else if(level.mapname == "mp_sm_island_1")
    _id_7911DF47EA68D2B6("dragons_den", 1);
  else if(level.mapname == "mp_don3_mobile" || level.mapname == "mp_mgl_verdansk") {
    _id_7911DF47EA68D2B6("don3_storage", 1);
    _id_7911DF47EA68D2B6("don3_port", 1);
    _id_7911DF47EA68D2B6("don3_quarry", 1);
    _id_7911DF47EA68D2B6("don3_lumber", 1);
    _id_7911DF47EA68D2B6("don3_boneyard", 1);
    _id_7911DF47EA68D2B6("don3_farm", 1);
    _id_7911DF47EA68D2B6("don3_downtown", 1);
    _id_7911DF47EA68D2B6("don3_promeast", 1);
  }
}

_id_7911DF47EA68D2B6(_id_4E07A0BFBE25A9D2, _id_D7CCC18AD08F0269) {
  if(!isDefined(level._id_0104CEC67C308610._id_2E76A31DD403AAA9))
    level._id_0104CEC67C308610._id_2E76A31DD403AAA9 = [];

  _id_D7CCC18AD08F0269 = getdvarint(_func_2EF675C13CA1C4AF("dvar_7F010821DC7CEE6A", _id_4E07A0BFBE25A9D2), _id_D7CCC18AD08F0269);
  level._id_0104CEC67C308610._id_2E76A31DD403AAA9[_id_4E07A0BFBE25A9D2] = _id_D7CCC18AD08F0269;
}

_id_61C0CDEAF03EF60C() {
  if(level.mapname != "mp_sm_island_1" && level.mapname != "mp_wz_island" && level.mapname != "mp_don3_mobile" && level.mapname != "mp_mgl_verdansk")
    return "default";

  if(isDefined(level._id_0104CEC67C308610._id_18D64418918AD507) && level._id_0104CEC67C308610._id_18D64418918AD507 != "random") {
    foreach(_id_0AE984386F500B3F, _id_9D4463C4C7989A27 in level._id_0104CEC67C308610._id_2E76A31DD403AAA9) {
      if(level._id_0104CEC67C308610._id_18D64418918AD507 == _id_0AE984386F500B3F)
        return _id_0AE984386F500B3F;
    }
  }

  _id_2B5E8B97B4BED5BE = 0;

  foreach(_id_9D4463C4C7989A27 in level._id_0104CEC67C308610._id_2E76A31DD403AAA9)
  _id_2B5E8B97B4BED5BE = _id_2B5E8B97B4BED5BE + _id_9D4463C4C7989A27;

  _id_7AD2FA4AB913AE0E = randomintrange(0, _id_2B5E8B97B4BED5BE);

  foreach(_id_0AE984386F500B3F, _id_9D4463C4C7989A27 in level._id_0104CEC67C308610._id_2E76A31DD403AAA9) {
    if(_id_7AD2FA4AB913AE0E < _id_9D4463C4C7989A27)
      return _id_0AE984386F500B3F;

    _id_7AD2FA4AB913AE0E = _id_7AD2FA4AB913AE0E - _id_9D4463C4C7989A27;
  }
}

_id_F158F856C08C573C(_id_4E07A0BFBE25A9D2) {
  _id_E5B4C6599E6DFABC = spawnStruct();
  _id_E5B4C6599E6DFABC._id_957163D1155464E2 = "default";
  _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = getdvarvector("dvar_839699CBB2161BEF", (300, -800, 0));
  _id_E5B4C6599E6DFABC.circle_radius = getdvarint("dvar_CBC36A93CB715198", 6000);
  _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = getdvarint("dvar_3C6256FFBC10F7F7", 0);
  _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = getdvarint("dvar_6296E9B1417B727C", 180);
  _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = level._id_0104CEC67C308610._id_3415B33E430AE534;
  _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = level._id_0104CEC67C308610._id_3415B33E430AE534;
  _id_E5B4C6599E6DFABC._id_FEAD98BEAF6F8FFB = 0;
  _id_E5B4C6599E6DFABC._id_FE8A8EBEAF493245 = 30;
  _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = getdvarfloat("dvar_3E5058F01264959E", 0.9);
  _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = getdvarfloat("dvar_3E2C6AF0123C427C", 0.99);
  _id_E5B4C6599E6DFABC._id_A66534BFF0EFD6E3 = 1;
  _id_E5B4C6599E6DFABC._id_CD36405F71D648DC = 1000;
  _id_E5B4C6599E6DFABC._id_CD132E5F71AFD98E = 3000;
  _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (0, 0, 0);
  _id_E5B4C6599E6DFABC._id_31693CA294154353 = (0, 0, 0);

  switch (_id_4E07A0BFBE25A9D2) {
    case "don3_storage":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-25639, 7915, 0);
      _id_E5B4C6599E6DFABC.circle_radius = 6500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 100;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 260;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 550;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 550;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.74;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.78;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-28588, 2815, 4135);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (317, 59, 0);
      break;
    case "don3_port":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (35537, -27378, -100);
      _id_E5B4C6599E6DFABC.circle_radius = 6800;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 26;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 200;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 500;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.76;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.8;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (39542, -25318, 3300);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (25, 198, 0);
      break;
    case "don3_quarry":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (32144.4, 39857.1, 840);
      _id_E5B4C6599E6DFABC.circle_radius = 6500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 45;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 225;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 550;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 550;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.74;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.78;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (36820.1, 37653.5, 2050.06);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (341, 163, 0);
      break;
    case "don3_lumber":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (51038.1, 4310.12, 110.01);
      _id_E5B4C6599E6DFABC.circle_radius = 6000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = -25;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 155;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 400;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 400;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.66;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.7;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      break;
    case "don3_boneyard":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-26702, -11100, 859.58);
      _id_E5B4C6599E6DFABC.circle_radius = 6700;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 110;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 290;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 350;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 350;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.68;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.72;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-27016.6, -14083.4, 1190.17);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (337.95, 64.05, 0);
      break;
    case "don3_farm":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (47179.2, -11917.1, 727.4);
      _id_E5B4C6599E6DFABC.circle_radius = 6500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 0;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 180;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 500;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.74;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.78;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (43785.1, -16082.5, 1724.76);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (334.8, 49.55, 0);
      break;
    case "don3_downtown":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (24565.1, -14769.6, 957.91);
      _id_E5B4C6599E6DFABC.circle_radius = 6500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 0;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 180;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 500;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.74;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.78;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (25239.2, -14508.7, 6303.63);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (0, 180, 0);
      break;
    case "don3_promeast":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-5339.72, -21986.9, 124.43);
      _id_E5B4C6599E6DFABC.circle_radius = 6500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = -15;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 165;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 500;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.74;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.78;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-10423.7, -24690, 1251.01);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (345.3, 35.7, 0);
      break;
    case "island_full":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-1004, 2162, 3098);
      _id_E5B4C6599E6DFABC.circle_radius = 65000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 0;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 180;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 10000;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 10000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.45;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.55;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-8516, 16084, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (-8540, 29070, 3022);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-8655, 3188, 3022);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-18783, 16139, 4381));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-1430, 16412, 2737));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-8516, 16084, 2060));
      level _id_21099472BCEB8812((-8211, 8553, 1315), (0, 255, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-9242, 4462, 671), (0, 87, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-12413, 6341, 909), (0, 84, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-7641, 6095, 1024), (0, 84, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8109, 9459, 1376), (0, 55, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-12285, 8144, 1049), (0, 105, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8514, 6759, 1015), (0, 62, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-5822, 7771, 1400), (0, 126, 0));
      level _id_21099472BCEB8812((-12541, 16090, 2443), (0, 174, 0));
      level _id_21099472BCEB8812((-1762, 14977, 3610), (0, 96, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-13237, 17049, 2531), (0, 279, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-1685, 17036, 3231), (0, 160, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (-11470, 16776, 1997), (0, 1, 0));
      level _id_21099472BCEB8812((-8989, 22726, 2000), (0, 96, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-5942, 25656, 902), (0, 325, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-9402, 25915, 1685), (0, 277, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-5260, 23883, 1169), (0, 313, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-10385, 23478, 2009), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-10974, 26085, 2048), (0, 267, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8557, 26235, 1298), (0, 289, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-12140, 25429, 2729), (0, 279, 0));
      break;
    case "island_mines":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-8516, 16084, 2060);
      _id_E5B4C6599E6DFABC.circle_radius = 15000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 90;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 270;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 3500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 4250;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.85;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.95;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-8516, 16084, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (-8540, 29070, 3022);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-8655, 3188, 3022);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-13166, 16035, 2492), 600);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-1430, 16412, 2737), 600);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-6530, 16065, 1743), 600);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-18867, 16264, 4357));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-8532, 16420, 2062));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((3379, 16189, 6277));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-15199, 16405, 3667));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-2777, 16333, 3234));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-7165, 16211, 1741));
      level _id_21099472BCEB8812((-8211, 8553, 1315), (0, 255, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-9242, 4462, 671), (0, 87, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-12413, 6341, 909), (0, 84, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-7641, 6095, 1024), (0, 84, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8109, 9459, 1376), (0, 55, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-12285, 8144, 1049), (0, 105, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8514, 6759, 1015), (0, 62, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-5822, 7771, 1400), (0, 126, 0));
      level _id_21099472BCEB8812((-12541, 16090, 2443), (0, 174, 0));
      level _id_21099472BCEB8812((-1762, 14977, 3610), (0, 96, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-13237, 17049, 2531), (0, 279, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-1685, 17036, 3231), (0, 160, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (-11470, 16776, 1997), (0, 1, 0));
      level _id_21099472BCEB8812((-8989, 22726, 2000), (0, 96, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-5942, 25656, 902), (0, 325, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-9402, 25915, 1685), (0, 277, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-5260, 23883, 1169), (0, 313, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-10385, 23478, 2009), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-10974, 26085, 2048), (0, 267, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8557, 26235, 1298), (0, 289, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-12140, 25429, 2729), (0, 279, 0));
      break;
    case "island_agport":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-2059, -16473, 2150);
      _id_E5B4C6599E6DFABC.circle_radius = 15000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 90;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 270;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 3000;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 3000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.85;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.95;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-12703, -16709, 946));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (8382, -16352, 2243));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-2100, -16483, 2167), 600);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((10965, -16137, 2220));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-2048, -15945, 2161));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-10578, -16134, 946));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-4303, -15918, 1879));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((3343, -15967, 2640));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-4508, -16198, 1866));
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (-2012, -3744, 2720);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-2020, -29244, 2799);
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-7825, -25502, 1855), (0, 78, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-1409, -25350, 1958), (0, 78, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (4968, -25468, 2505), (0, 103, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8756, -26103, 1750), (0, 112, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (6413, -24807, 2514), (0, 75, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-2867, -25782, 1966), (0, 126, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (1253, -25449, 2071), (0, 72, 0));
      level _id_21099472BCEB8812((-2014, -25419, 1962), (0, 285, 0));
      level _id_21099472BCEB8812((6966, -24236, 2487), (0, 272, 0));
      level _id_21099472BCEB8812((-8899, -26425, 1761), (0, 279, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-8430, -8272, 1444), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (4250, -7760, 1874), (0, 288, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-7588, -8571, 1472), (0, 252, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-2287, -7904, 1712), (0, 271, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (7652, -8708, 1882), (0, 250, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-2938, -8037, 1717), (0, 284, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (1162, -7671, 1709), (0, 274, 0));
      level _id_21099472BCEB8812((-2676, -7781, 1705), (0, 90, 0));
      level _id_21099472BCEB8812((-7318, -8382, 1471), (0, 81, 0));
      level _id_21099472BCEB8812((6451, -7819, 1889), (0, 85, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-9640, -16157, 882), (0, 269, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (9772, -14495, 1968), (0, 202, 0));
      level _id_21099472BCEB8812((-5594, -17685, 1647), (0, 180, 0));
      level _id_21099472BCEB8812((2455, -17363, 2436), (0, 351, 0));
      break;
    case "island_beachhead":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (42336, 26470, 1129);
      _id_E5B4C6599E6DFABC.circle_radius = 14000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 65;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 245;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 3500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 3300;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.75;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.85;
      _id_E5B4C6599E6DFABC._id_FE8A8EBEAF493245 = 20;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (37138, 30559, 2073), 600);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (46599, 24269, 479), 600);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (41798, 27031, 1164), 600);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((32589, 32742, 2998));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((42300, 26859, 1128));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((48834, 23696, 388));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((38480, 28289, 1625));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((45135, 24556, 655));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((40370, 27510, 1182));
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (47759, 37415, 256);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (37190, 15324, 2004);
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (39695.7, 24954.5, 1130), (0, 348, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (42922.1, 18544.5, 558.325), (357.935, 136, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (34096.9, 23605.4, 1710.88), (356.229, 33.7372, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (45750.7, 19208.1, 306.481), (358.154, 111.497, 8.19));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (38916.6, 15767.8, 1943.53), (0, 118.21, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (39756.8, 21830.9, 1125.45), (0, 105.435, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (48147.1, 28409.3, 461.216), (7, 322.284, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (43660.2, 30007, 1075.76), (360, 245.605, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (39184.2, 36813.3, 1345.95), (355.382, 129.98, 2.7));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (50226.5, 31617.5, 285.036), (358.317, 229.303, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (47794, 36873, 259), (0, 287, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (45469.3, 32590.9, 651.305), (353.611, 233.427, 3.74));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (49588.8, 23375.7, 289.755), (3.44, 325.306, 0));
      level _id_21099472BCEB8812((51176, 28266, 323), (0, 288.994, 0));
      level _id_21099472BCEB8812((40633, 36646, 1281), (0, 200, 0));
      level _id_21099472BCEB8812((46589, 36622, 212), (0, 353.999, 0));
      level _id_21099472BCEB8812((35152, 25856, 1731), (357.699, 284.999, -0.4002));
      level _id_21099472BCEB8812((38790, 17955, 1946), (0, 218.2, 0));
      level _id_21099472BCEB8812((44393, 18577, 287), (0, 320.198, 0));
      level _id_21099472BCEB8812((43762, 25225, 807), (0, 307.897, 0));
      level _id_21099472BCEB8812((45917, 26832, 736), (0, 0.596145, 0));
      break;
    case "island_village":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-41927, 11992, 1492);
      _id_E5B4C6599E6DFABC.circle_radius = 14000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 90;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 270;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 2500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 3000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.8;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.9;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-43582, 6013, 1121);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (7, 55, 0);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B(_id_E5B4C6599E6DFABC._id_A64F9929D18C1013);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-49969, 11480, 246));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-46388, 11467, 1059));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-37979, 11630, 1498));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-34072, 11677, 1905));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-31189, 11333, 2916));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-48102, 11889, 217), 750);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-37194, 11387, 1539), 750);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-42142, 12350, 1525), 550);
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (-41944, 23939, 1525);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-41932, 348, 1054);
      level _id_21099472BCEB8812((-38905, 20922, 1741), (0, 343.899, 0));
      level _id_21099472BCEB8812((-42695, 22591, 1411), (0, 180, 0));
      level _id_21099472BCEB8812((-46930, 16795, 1405), (0, 301.598, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-40796.3, 18705, 1888.2), (350, 329.353, 0.01));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-37331.9, 19336.4, 1805.74), (0, 226, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-45080, 18300, 1593.75), (0, 217, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (-43040.6, 23448.1, 1444.46), (8.22, 296.332, 5.29));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-48144.4, 18403.9, 220.901), (0, 212, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-34261, 22942, 883), (0, 321, 0));
      level _id_21099472BCEB8812((-44041, 9432, 1461), (0, 343.899, 0));
      level _id_21099472BCEB8812((-38439, 12616, 1573), (0, 44.797, 0));
      level _id_21099472BCEB8812((-40898, 15989, 2010), (0, 163.996, 0));
      level _id_21099472BCEB8812((-40230, 7295, 1119), (0, 257.595, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-43816.7, 11136.3, 1457.79), (358.261, 39.1391, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-40236, 11779, 1316.24), (0, 359, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-48475.4, 13147, 201.345), (6.14, 182.449, 3.70617));
      level _id_21099472BCEB8812((-43744, 2748, 946), (0, 1.79359, 0));
      level _id_21099472BCEB8812((-38980, 2597, 1463), (0, 269.292, 0));
      level _id_21099472BCEB8812((-48214, 7522, 544), (0, 151.398, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-45607.2, 5247.57, 953.857), (0, 105.099, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-41428.5, 5815.72, 1035.08), (359, 76.7339, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-36834.5, 6922.72, 2272), (354, 72.36, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (-43302, 1791.85, 908.082), (357.468, 1.05, 4.76));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-49482.4, 6606.3, 258.88), (2.39, 97.24, -8.16));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-33852.1, 5157.71, 2792.52), (358.549, 133.215, -6.60096));
      break;
    case "island_capital":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (25362, -48470, 586);
      _id_E5B4C6599E6DFABC.circle_radius = 14000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 20;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 200;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 3000;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 3000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.7;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.8;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_67ACB632727E8183 = 500;
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (22047, -43116, 853), _id_67ACB632727E8183);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (30008, -57560, 381), _id_67ACB632727E8183);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (26159, -49077, 596), _id_67ACB632727E8183);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((21759, -36974, 2799));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((25157, -47678, 593));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((28808, -56469, 363));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((23270, -44078, 762));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((26505, -50982, 554));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((27854, -53423, 402));
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (14776, -52301, 983);
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (17931, -50466, 383), (0, 2.7, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (19083, -54517, 301), (0, 10, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (17881, -52344, 295), (0, 354, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (17604, -54495, 265), (0, 23, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (16854, -48015, 702), (0, 14, 0));
      level _id_21099472BCEB8812((17450, -54980, 253), (0, 192, 0));
      level _id_21099472BCEB8812((18303, -51204, 400), (0, 186, 0));
      level _id_21099472BCEB8812((16079, -47258, 776), (0, 198, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (31430, -46001, 504), (0, 185, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (34931, -48822, 337), (0, 223, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (30520, -43227, 440), (0, 231, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (34187, -49643, 370), (0, 206, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (27757, -41061, 656), (0, 222, 0));
      level _id_21099472BCEB8812((31933, -44949, 557), (0, 82, 0));
      level _id_21099472BCEB8812((35730, -49415, 318), (0, 24, 0));
      level _id_21099472BCEB8812((27941, -40452, 647), (0, 35, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (30082, -55769, 310), (0, 255, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (24282, -46307, 589), (0, 31, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("little_bird_mg", (24025, -47102, 1006), (0, 303, 0));
      level _id_21099472BCEB8812((27868, -51665, 625), (0, 329, 0));
      level _id_21099472BCEB8812((21421, -41686, 906), (0, 120, 0));
      level _id_21099472BCEB8812((24864, -46841, 624), (0, 120, 0));
      break;
    case "island_airfield":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-24922, -19948, 945);
      _id_E5B4C6599E6DFABC.circle_radius = 20000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 45;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 225;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 4000;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 4000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.52;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.62;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_F7E9F4A9D88E68D1 = 450;
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-31385, -14497, 622), _id_F7E9F4A9D88E68D1);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-18945, -26037, 933), _id_F7E9F4A9D88E68D1);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-25383, -19500, 945), _id_F7E9F4A9D88E68D1);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-37223, -7070, 875));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-24873, -20054, 945));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-13428, -31227, 2152));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-17939, -25998, 940));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-29664, -15299, 1070));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-21948, -20997, 946));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-30846, -22007, 905), (0, 59, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-28882, -22814, 887), (0, 69, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-26396, -28261, 888), (0, 47, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-25040, -7574, 650), (0, 199, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-30205, -29269, 942), (0, 41, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-27998, -28310, 942), (0, 44, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-26382, -25572, 942), (0, 44, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("cargo_truck_susp_aa", (-13274, -28859, 2340), (0, 57, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("cargo_truck_susp_aa", (-30445, -26797, 885), (0, 312, 0));
      level _id_21099472BCEB8812((-24217, -29554, 887), (0, 225, 0));
      level _id_21099472BCEB8812((-28090, -22981, 888), (0, 222, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-21724, -12245, 883), (0, 221, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-17802, -13318, 887), (0, 226, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-14440, -17086, 889), (0, 204, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-25040, -7574, 650), (0, 199, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-15116, -14244, 942), (0, 223, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-16228, -16680, 942), (0, 225, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_palfa", (-18773, -18010, 942), (0, 223, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("cargo_truck_susp_aa", (-13714, -16711, 885), (0, 176, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-14098, -20800, 883), (0, 219, 0));
      level _id_21099472BCEB8812((-18227, -13066, 946), (0, 43, 0));
      level _id_21099472BCEB8812((-15846, -19813, 895), (0, 43, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-18101, -27845, 861), (0, 127, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-35382, -11706, 408), (0, 328, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-27259, -13524, 998), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("cargo_truck_susp_aa", (-29837, -6907, 769), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-29837, -6907, 769), (0, 270, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (-23466, -20145, 885), (0, 318, 0));
      level _id_21099472BCEB8812((-27862, -15622, 1002), (0, 133, 0));
      level _id_21099472BCEB8812((-18269, -28491, 867), (0, 313, 0));
      level _id_21099472BCEB8812((-24002, -19673, 888), (0, 313, 0));
      break;
    case "island_docks":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (16657, 49035, 479);
      _id_E5B4C6599E6DFABC.circle_radius = 14500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 135;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 315;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 3000;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 3000;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.6;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.7;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-2059, -16473, 5000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_F49EF034DCF02923 = 550;
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (12229, 45655, 1059), _id_F49EF034DCF02923);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (21608, 53388, 335), _id_F49EF034DCF02923);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (16657, 49035, 479), _id_F49EF034DCF02923);
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (12726, 53523, 317), (0, 312, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (16585, 56520, 320), (0, 314, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (16994, 55944, 229), (0, 307, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (15477, 56027, 317), (0, 320, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (8454, 50718, 876), (0, 340, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (8789, 49615, 905), (0, 4, 0));
      level _id_21099472BCEB8812((14020, 52995, 321), (0, 138, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (22232, 46647, 264), (0, 127, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (24289, 48605, 259), (0, 145, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (23630, 49169, 249), (0, 164, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (19568, 44581, 411), (0, 137, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (17716, 42182, 648), (0, 164, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (17130, 42484, 604), (0, 174, 0));
      level _id_21099472BCEB8812((20305, 45593, 422), (0, 314, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (17657, 50874, 414), (0, 226, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (8948, 43935, 1070), (0, 30, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (15285, 48254, 430), (0, 40, 0));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((15798, 49897, 475));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((17421, 48137, 475));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((18334, 51135, 338));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((22744, 54128, 237));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((13944, 46436, 989));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((10847, 44006, 965));
      break;
    case "island_storage":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (-27318, 5535, 3325);
      _id_E5B4C6599E6DFABC.circle_radius = 12500;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 165;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 345;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 1800;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 1800;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.5;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.6;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (-27318, 5535, 3325);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (21, 63, 0);
      _id_0D27A96FCB3CB058 = 500;
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-26163, 11898, 2387), _id_0D27A96FCB3CB058);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (-28944, -1422, 3688), _id_0D27A96FCB3CB058);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (-27402, 5377, 3331), _id_0D27A96FCB3CB058);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-28207, 1387, 3952));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-27887, 4174, 3389));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-28081, 5607, 3501));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-26703, 5256, 3485));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-27205, 6944, 3261));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-27105, 10299, 2558));
      level _id_21099472BCEB8812((-24867, 3672, 3330), (0, 343, 0));
      level _id_21099472BCEB8812((-24975, 7610, 3209), (0, 344, 0));
      level _id_21099472BCEB8812((-31023, 4522, 3394), (0, 167, 0));
      level _id_21099472BCEB8812((-29622, 8111, 3202), (0, 166, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-24473, 9643, 2864), (0, 115, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-29010, 9843, 3054), (0, 38, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-27239, 7509, 3201), (0, 70, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (-28347, 2823, 3393), (0, 68, 0));
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (-33338, 7020, 4461);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-21013, 3850, 4461);
      break;
    case "dragons_den":
      _id_E5B4C6599E6DFABC._id_957163D1155464E2 = _id_4E07A0BFBE25A9D2;
      _id_E5B4C6599E6DFABC._id_A64F9929D18C1013 = (1087.26, -114.74, 1526.75);
      _id_E5B4C6599E6DFABC.circle_radius = 15000;
      _id_E5B4C6599E6DFABC._id_0FC62D67B6110893 = 0;
      _id_E5B4C6599E6DFABC._id_3207814114EB2E20 = 180;
      _id_E5B4C6599E6DFABC._id_0A52C8E38CF6C3C1 = 2500;
      _id_E5B4C6599E6DFABC._id_36EA54569DB6D93E = 2500;
      _id_E5B4C6599E6DFABC._id_DBB390417265EF42 = 0.8;
      _id_E5B4C6599E6DFABC._id_DB907A41723F7728 = 0.9;
      _id_E5B4C6599E6DFABC._id_FE3ED83A689478FD = (0, 0, 15000);
      _id_E5B4C6599E6DFABC._id_31693CA294154353 = (7, 55, 0);
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((3021, 6566, 1434));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((539, -1764, 449));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-6905, -2847, 1104));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((10865, 1528, 641));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((8022, -5128, 545));
      _id_E5B4C6599E6DFABC _id_3B02306F15C7109B((-5416, 2414, 1273));
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (1875, 4610, 1470), 750);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(0, (407, -4452, 201), 750);
      _id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(1, (15, -1098, 1264), 750);
      level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7 = (12661.2, 611.71, 876.23);
      level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C = (-9029.59, -1547.42, 1108.31);
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (5394, -3585, 47), (0, 121, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (9036, 2460, 919), (0, 65, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (13605, 257, 173), (0, 267, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_mil_cargo_truck", (2079, 5169, 1369), (0, 146, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("little_bird_mg", (-2858, 43, 2563), (0, 238, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (6839, 3257, 1187), (0, 225, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-9874, -1389, 332), (0, 262, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-6181, -5403, 515), (0, 169, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-4203, -426, 1162), (0, 10, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("little_bird_mg", (11760, -3899, 600), (0, 131, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("atv", (1156, -1520, 397), (0, 160, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("tac_rover", (-2306, -4208, 48), (0, 177, 0));
      _id_E5B4C6599E6DFABC _id_05792CAB2875BBA3("veh9_suv_1996", (-4501, 3505, 1305), (0, 319, 0));
      break;
    default:
  }

  _id_E5B4C6599E6DFABC _id_B061A8949147DACA(_id_4E07A0BFBE25A9D2);
  _id_E5B4C6599E6DFABC _id_C2D7A69D4E04603F(_id_4E07A0BFBE25A9D2);
  _id_E5B4C6599E6DFABC _id_38B23DB5B0EB1CFE(_id_4E07A0BFBE25A9D2);
  level thread _id_AE0CA9254991FD60();
  return _id_E5B4C6599E6DFABC;
}

_id_C2D7A69D4E04603F(location) {
  if(location == "default") {
    return;
  }
  _id_9535D98CD9A64C7A = "mp/rumble_info_table.csv";
  _id_BC0ACFF6D6B20A34 = tablelookupgetnumrows(_id_9535D98CD9A64C7A);

  if(!isDefined(_id_BC0ACFF6D6B20A34)) {
    return;
  }
  _id_B9793705ECD77C9D = 0;
  _id_1E1ED3524648DAA7 = 1;
  _id_BB717BDC22D80E71 = 2;
  _id_E19556DFBF2F8876 = 3;
  _id_769C1C0B9E7CA9DE = ",";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BC0ACFF6D6B20A34; _id_AC0E594AC96AA3A8++) {
    _id_1A60D1436D32D29B = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_B9793705ECD77C9D);

    if(_id_1A60D1436D32D29B == location) {
      _id_9901A85D4A3F3384 = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_1E1ED3524648DAA7);

      if(scripts\engine\utility::array_contains(level._id_0104CEC67C308610._id_46F0FEF76D38D30D, _id_9901A85D4A3F3384)) {
        _id_193D6E7CAF09FE5F = strtok(tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_BB717BDC22D80E71), _id_769C1C0B9E7CA9DE);
        _id_58CBB815E41A545A = strtok(tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_E19556DFBF2F8876), _id_769C1C0B9E7CA9DE);
        _id_BDE41C1A65A73BD1 = "Rumble CSV Info | row:" + _id_AC0E594AC96AA3A8 + " | ";

        if(!isDefined(_id_193D6E7CAF09FE5F[0]) && !isDefined(_id_58CBB815E41A545A[0]))
          continue;
        else if(!isDefined(_id_193D6E7CAF09FE5F[0]))
          continue;
        else if(!isDefined(_id_58CBB815E41A545A[0])) {
          continue;
        }
        _id_949D9008FC020806 = (float(_id_193D6E7CAF09FE5F[0]), float(_id_193D6E7CAF09FE5F[1]), float(_id_193D6E7CAF09FE5F[2]));
        _id_288F1DFDCCAD7F63 = (float(_id_58CBB815E41A545A[0]), float(_id_58CBB815E41A545A[1]), float(_id_58CBB815E41A545A[2]));
        _id_05792CAB2875BBA3(_id_9901A85D4A3F3384, _id_949D9008FC020806, _id_288F1DFDCCAD7F63);
      }
    }
  }
}

_id_B061A8949147DACA(location) {
  if(location == "default") {
    return;
  }
  _id_9535D98CD9A64C7A = "mp/rumble_info_table.csv";
  _id_BC0ACFF6D6B20A34 = tablelookupgetnumrows(_id_9535D98CD9A64C7A);

  if(!isDefined(_id_BC0ACFF6D6B20A34)) {
    return;
  }
  _id_B9793705ECD77C9D = 0;
  _id_1E1ED3524648DAA7 = 1;
  _id_BB717BDC22D80E71 = 2;
  _id_E19556DFBF2F8876 = 3;
  _id_769C1C0B9E7CA9DE = ",";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BC0ACFF6D6B20A34; _id_AC0E594AC96AA3A8++) {
    _id_1A60D1436D32D29B = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_B9793705ECD77C9D);

    if(_id_1A60D1436D32D29B == location) {
      _id_1E16AC09176FC107 = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_1E1ED3524648DAA7);

      if(_id_1E16AC09176FC107 == "kiosk") {
        _id_193D6E7CAF09FE5F = strtok(tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_BB717BDC22D80E71), _id_769C1C0B9E7CA9DE);
        _id_58CBB815E41A545A = strtok(tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_E19556DFBF2F8876), _id_769C1C0B9E7CA9DE);
        _id_BDE41C1A65A73BD1 = "Rumble CSV Info | row:" + _id_AC0E594AC96AA3A8 + " | ";

        if(!isDefined(_id_193D6E7CAF09FE5F[0]) && !isDefined(_id_58CBB815E41A545A[0]))
          continue;
        else if(!isDefined(_id_193D6E7CAF09FE5F[0]))
          continue;
        else if(!isDefined(_id_58CBB815E41A545A[0])) {
          continue;
        }
        _id_949D9008FC020806 = (float(_id_193D6E7CAF09FE5F[0]), float(_id_193D6E7CAF09FE5F[1]), float(_id_193D6E7CAF09FE5F[2]));
        _id_288F1DFDCCAD7F63 = (float(_id_58CBB815E41A545A[0]), float(_id_58CBB815E41A545A[1]), float(_id_58CBB815E41A545A[2]));
        _id_21099472BCEB8812(_id_949D9008FC020806, _id_288F1DFDCCAD7F63);
      }
    }
  }
}

_id_38B23DB5B0EB1CFE(location) {
  if(location == "default") {
    return;
  }
  _id_9535D98CD9A64C7A = "mp/rumble_info_table.csv";
  _id_BC0ACFF6D6B20A34 = tablelookupgetnumrows(_id_9535D98CD9A64C7A);

  if(!isDefined(_id_BC0ACFF6D6B20A34)) {
    return;
  }
  _id_B9793705ECD77C9D = 0;
  _id_42587A377FD9ABCD = 1;
  _id_BB717BDC22D80E71 = 2;
  _id_15F936F88F6AEE02 = 3;
  _id_5BC6FB050DDEA2EF = 4;
  _id_769C1C0B9E7CA9DE = ",";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BC0ACFF6D6B20A34; _id_AC0E594AC96AA3A8++) {
    _id_1A60D1436D32D29B = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_B9793705ECD77C9D);

    if(_id_1A60D1436D32D29B == location) {
      _id_1E1ED3524648DAA7 = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_42587A377FD9ABCD);

      if(_id_1E1ED3524648DAA7 == "dom_flag") {
        _id_193D6E7CAF09FE5F = strtok(tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_BB717BDC22D80E71), _id_769C1C0B9E7CA9DE);
        _id_A58FDBBC62DA73D4 = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_15F936F88F6AEE02);
        _id_64E463DAC6E091B7 = tablelookupbyrow(_id_9535D98CD9A64C7A, _id_AC0E594AC96AA3A8, _id_5BC6FB050DDEA2EF);
        _id_BDE41C1A65A73BD1 = "Rumble CSV Info | row:" + _id_AC0E594AC96AA3A8 + " | ";

        if(!isDefined(_id_193D6E7CAF09FE5F[0]) && !isDefined(_id_A58FDBBC62DA73D4))
          continue;
        else if(!isDefined(_id_193D6E7CAF09FE5F[0]))
          continue;
        else if(!isDefined(_id_A58FDBBC62DA73D4)) {
          continue;
        }
        _id_949D9008FC020806 = (float(_id_193D6E7CAF09FE5F[0]), float(_id_193D6E7CAF09FE5F[1]), float(_id_193D6E7CAF09FE5F[2]));
        _id_5E426ED02F55A9A4 = int(_id_A58FDBBC62DA73D4);
        _id_FE69DAC25B2C3B1F = int(_id_64E463DAC6E091B7);
        _id_8353AA87C9026F4E(_id_5E426ED02F55A9A4, _id_949D9008FC020806, _id_FE69DAC25B2C3B1F);
      }
    }
  }
}

_id_AE0CA9254991FD60() {
  level endon("game_ended");

  if(level._id_0104CEC67C308610._id_6354FD2722A0051D.size < 1) {
    return;
  }
  while(!isDefined(level.br_armory_kiosk))
    waitframe();

  wait 1.0;
  _id_4384ABBF498DF6A7::setspawninstances(level._id_0104CEC67C308610._id_6354FD2722A0051D);
}

_id_21099472BCEB8812(_id_8E5FF8E8F635F7C1, _id_7C645B23074DCDDA) {
  _id_FF594191D0B7B890 = getgroundposition(_id_8E5FF8E8F635F7C1, 2.5);
  _id_15B89FF206500554 = spawnscriptable("br_plunder_box", _id_FF594191D0B7B890, _id_7C645B23074DCDDA);
  level._id_0104CEC67C308610._id_6354FD2722A0051D[level._id_0104CEC67C308610._id_6354FD2722A0051D.size] = _id_15B89FF206500554;
}

_id_05792CAB2875BBA3(_id_3D22F278EFD315CC, _id_0C95C2773DD1279E, _id_8F15A6D432357CE4) {
  if(_id_3D22F278EFD315CC == "little_bird_mg" && getdvarfloat("dvar_D7497D748394BDAB", 100) < 1)
    _id_3D22F278EFD315CC = "little_bird";

  if(!scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_canspawnVehicle(_id_3D22F278EFD315CC)) {
    return;
  }
  if(!isDefined(self._id_F7F3A366D07028E0))
    self._id_F7F3A366D07028E0 = [];

  self._id_F7F3A366D07028E0[self._id_F7F3A366D07028E0.size] = [_id_3D22F278EFD315CC, _id_0C95C2773DD1279E, _id_8F15A6D432357CE4];
}

_id_684F92AF5A6434C1() {
  level endon("game_ended");
  spawn_vehicles = 0;

  if(!scripts\mp\flags::gameflag("prematch_done")) {} else
    spawn_vehicles = 1;

  if(!spawn_vehicles) {
    return;
  }
  scripts\mp\flags::gameflagwait("rumble_location_selected");

  if(!isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_F7F3A366D07028E0)) {
    return;
  }
  foreach(_id_AC0E594AC96AA3A8, vehicle_info in level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_F7F3A366D07028E0) {
    _id_BECCD53F4573C239 = spawnStruct();
    _id_BECCD53F4573C239.ref = vehicle_info[0];
    _id_BECCD53F4573C239.origin = vehicle_info[1];
    _id_BECCD53F4573C239.angles = vehicle_info[2];
    _id_BECCD53F4573C239._id_C07EDBF8D1F86DC4 = _id_AC0E594AC96AA3A8;
    level thread _id_274905E19DD3F834(_id_BECCD53F4573C239);
  }
}

_id_E96B313C43211D8B(vehicle) {
  level._id_0104CEC67C308610.spawned_vehicles[vehicle._id_BECCD53F4573C239._id_C07EDBF8D1F86DC4] = vehicle;
}

_id_72D50E7F87A96460(vehicle) {
  level._id_0104CEC67C308610.spawned_vehicles[vehicle._id_BECCD53F4573C239._id_C07EDBF8D1F86DC4] = undefined;
}

_id_274905E19DD3F834(_id_BECCD53F4573C239) {
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_BECCD53F4573C239.ref, _id_BECCD53F4573C239);
  vehicle._id_BECCD53F4573C239 = _id_BECCD53F4573C239;
  _id_E96B313C43211D8B(vehicle);
  vehicle thread vehicle_death_watcher();
  vehicle thread _id_639DC57F5FF4F8A1();
}

_id_C4B2E7C0C498ED8F(_id_BECCD53F4573C239) {
  level endon("game_ended");
  wait 45.0;
  _id_274905E19DD3F834(_id_BECCD53F4573C239);
}

_id_639DC57F5FF4F8A1() {
  level endon("game_ended");
  self endon("death");
  self endon("vehicle_pending_respawn");
  start_position = self.origin;
  _id_EF04566DBEA411D3 = 1500.0;
  _id_7BAD893B291C0BE2 = 60;
  self._id_1AE83DE8843B200F = undefined;
  self._id_7B7ADB2F03A93E6C = 0;
  self._id_C0AB1E665D342394 = undefined;
  self._id_A7F29930A5DD5069 = undefined;

  for(;;) {
    self._id_C7F2A05C6FC0BD4E = distance2d(start_position, self.origin);
    self._id_4A78D90231CC4D20 = isDefined(self getvehicleowner());

    if(!self._id_7B7ADB2F03A93E6C && self._id_C7F2A05C6FC0BD4E > _id_EF04566DBEA411D3 && !self._id_4A78D90231CC4D20) {
      self._id_C0AB1E665D342394 = gettime();
      self._id_A7F29930A5DD5069 = gettime() + _id_7BAD893B291C0BE2 * 1000;
      self._id_7B7ADB2F03A93E6C = 1;
    } else if(self._id_7B7ADB2F03A93E6C && self._id_4A78D90231CC4D20) {
      self._id_7B7ADB2F03A93E6C = 0;
      self._id_C0AB1E665D342394 = undefined;
      self._id_A7F29930A5DD5069 = undefined;
      self._id_1AE83DE8843B200F = undefined;
    }

    if(isDefined(self._id_C0AB1E665D342394) && isDefined(self._id_A7F29930A5DD5069)) {
      _id_DE20130BA0323CE1 = gettime();
      self._id_1AE83DE8843B200F = (self._id_A7F29930A5DD5069 - _id_DE20130BA0323CE1) / 1000;
      _id_C4154050A2053C5E = 0;

      if(_id_DE20130BA0323CE1 >= self._id_A7F29930A5DD5069) {
        foreach(player in level.players) {
          if(distance(player.origin, self.origin) < _id_EF04566DBEA411D3) {
            self._id_A7F29930A5DD5069 = _id_DE20130BA0323CE1 + _id_7BAD893B291C0BE2 / 2 * 1000;
            _id_C4154050A2053C5E = 1;
            break;
          }
        }

        if(!_id_C4154050A2053C5E) {
          _id_4724784E2530A13F = self.health * 0.95;
          self dodamage(_id_4724784E2530A13F, self.origin);
          break;
        }
      }
    }

    wait 1.0;
  }
}

vehicle_death_watcher() {
  level endon("game_ended");
  _id_FBD77BDA0002A7F2 = self._id_BECCD53F4573C239;
  self waittill("death");
  self notify("vehicle_pending_respawn");
  _id_72D50E7F87A96460(self);

  if(_id_2695A20D4011076D::ispointincurrentsafecircle(_id_FBD77BDA0002A7F2.origin))
    _id_C4B2E7C0C498ED8F(_id_FBD77BDA0002A7F2);
}

_id_A3FA4776B1C47C84() {}

_id_05B532C43333DDB1() {
  level endon("game_ended");
  _id_24A7F5F1BE614DF3 = 0;
  _id_07A24A8AA61CA8AE = 0;
  _id_22F4691D4917F178 = 0;
  _id_9FEDEDEE54E7AF24 = 0;
  _id_98F7893E84443025 = 0;
  _id_3117F65F501D4162 = 0;
  _id_71ECCB2968E09509 = 0;
  _id_70E5D40612C9C78A = scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 5, 2);
  scripts\mp\flags::_id_1240434F4201AC9D("infil_complete");

  while(game["state"] == "playing") {
    if(!level.timerstopped && scripts\mp\utility\game::gettimelimit()) {
      _id_8DD9F2EB8215A139 = scripts\mp\gamelogic::gettimeremaining() / 1000;
      _id_F8912399577F51CA = int(_id_8DD9F2EB8215A139 + 0.5);
      _id_A8088865FD3EFD6D = 0;

      if(_id_70E5D40612C9C78A == 2 && _id_F8912399577F51CA % 2 == 1)
        _id_A8088865FD3EFD6D = 1;

      if(!_id_24A7F5F1BE614DF3 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_E22C01D7A8ED89CA + 1 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_E22C01D7A8ED89CA)) {
        if(level._id_0104CEC67C308610._id_EB84142EF4AD4429 || scripts\engine\utility::cointoss())
          level thread _id_3D3CC3E223ED16C2(0);
        else
          level thread _id_FA75A18C001E9354(0);

        _id_24A7F5F1BE614DF3 = 1;
      } else if(!_id_9FEDEDEE54E7AF24 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_CEA4F4AED1B051A7 + 1 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_CEA4F4AED1B051A7)) {
        level notify("quest_tablets_refill");
        _id_9FEDEDEE54E7AF24 = 1;
      } else if(!_id_07A24A8AA61CA8AE && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_2A703750A536EC9D + 1 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_2A703750A536EC9D)) {
        if(scripts\engine\utility::cointoss())
          level thread _id_3D3CC3E223ED16C2(1);
        else
          level thread _id_FA75A18C001E9354(1);

        _id_07A24A8AA61CA8AE = 1;
      } else if(level._id_0104CEC67C308610._id_513889924E9D92FF && !_id_22F4691D4917F178 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_0C702BF88DE625C5 + 1 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == level._id_0104CEC67C308610._id_0C702BF88DE625C5)) {
        if(level._id_0104CEC67C308610._id_F3625A19B2A4F328 && scripts\engine\utility::cointoss())
          level._id_0104CEC67C308610._id_7DB4F44FD3537013 _id_BF7C1B64CC2B8DC1();
        else
          level thread _id_1E253808F533D0E7();

        _id_22F4691D4917F178 = 1;
      } else if(!_id_98F7893E84443025 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == 61 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == 60)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_sixty");
        level notify("match_ending_soon", "time");
        _id_98F7893E84443025 = 1;
      } else if(!_id_3117F65F501D4162 && (_id_A8088865FD3EFD6D == 1 && _id_F8912399577F51CA == 31 || _id_A8088865FD3EFD6D == 0 && _id_F8912399577F51CA == 30)) {
        level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup_thirty");
        level notify("match_ending_soon", "time");
        _id_3117F65F501D4162 = 1;
      } else if(!_id_98F7893E84443025 && !_id_3117F65F501D4162 && !_id_71ECCB2968E09509 && (_id_F8912399577F51CA >= 30 && _id_F8912399577F51CA <= 45)) {
        _id_71ECCB2968E09509 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup");
        level notify("match_ending_soon", "time");
      }

      if(_id_F8912399577F51CA <= 10 || _id_F8912399577F51CA <= 30 && _id_F8912399577F51CA % _id_70E5D40612C9C78A == _id_A8088865FD3EFD6D) {
        if(!_id_71ECCB2968E09509 && _id_F8912399577F51CA <= 10)
          _id_71ECCB2968E09509 = level scripts\mp\music_and_dialog::matchendingsoonleaderdialog("timesup", _id_F8912399577F51CA);

        level notify("match_ending_very_soon");
        _id_3E3368AA252685C2 = 1;

        if(_id_F8912399577F51CA == 0) {
          break;
        }

        if(isDefined(level.overridetimelimitclock) && level.overridetimelimitclock < _id_F8912399577F51CA)
          _id_3E3368AA252685C2 = 0;

        if(_id_3E3368AA252685C2) {
          _id_14CCD6E81FCE3BD4 = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);
          playsoundatpos((0, 0, 0), _id_14CCD6E81FCE3BD4);
        }
      }

      if(_id_8DD9F2EB8215A139 - floor(_id_8DD9F2EB8215A139) >= 0.05) {
        wait(_id_8DD9F2EB8215A139 - floor(_id_8DD9F2EB8215A139));
        continue;
      }
    }

    wait 1.0;
  }
}

_id_D98D2225ACD25E19() {}

_id_FA75A18C001E9354(_id_39697B9BD80B8068) {
  level endon("game_ended");

  if(!isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B))
    level._id_0104CEC67C308610._id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(_id_39697B9BD80B8068, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013);

  _id_A8976AE75F6E2D39 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B[_id_39697B9BD80B8068];
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_42DFDF4DE1193973 = _id_39697B9BD80B8068;

  if(!isDefined(_id_A8976AE75F6E2D39) || _id_A8976AE75F6E2D39.size <= 0) {
    return;
  }
  _id_8DF63A3026C606E6();

  if(getdvarint("dvar_1966033557794E8C", 0) == 0) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("power_zone_incoming", 0);
    _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_double_point_zones_incoming");
    wait 20;
  }

  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("power_zone_active", 0);
  _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_double_point_zones_online");
  wait 3.0;
  level thread _id_0CFCB533C1015057();
}

_id_0CFCB533C1015057() {
  _id_6107468585B068B1 = ["_a", "_b", "_c", "_d", "_e"];

  if(!isDefined(level._id_0104CEC67C308610._id_E57AA541604469A8))
    level._id_0104CEC67C308610._id_E57AA541604469A8 = 0;

  _id_39697B9BD80B8068 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_42DFDF4DE1193973;
  _id_A8976AE75F6E2D39 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B[_id_39697B9BD80B8068];

  foreach(index, _id_D9AA5FF72CC35CF4 in _id_A8976AE75F6E2D39) {
    _id_3ACF1C0EBAF602F2::utilflare_shootflare(_id_D9AA5FF72CC35CF4.location, "attack");
    _id_ED0FC303D04A6B6F = scripts\engine\utility::ter_op(isDefined(_id_D9AA5FF72CC35CF4._id_A2D14269AAE8C44B), _id_D9AA5FF72CC35CF4._id_A2D14269AAE8C44B, level._id_0104CEC67C308610._id_181F5B611D5A7C6D);
    _id_CD25F37F5A816BF6 = scripts\engine\utility::ter_op(isDefined(_id_D9AA5FF72CC35CF4._id_DAAD6622C53116DA), _id_D9AA5FF72CC35CF4._id_DAAD6622C53116DA, level._id_0104CEC67C308610._id_7CF0A048C2999AB0);
    _id_E29C3D3F3A14F7EC = _id_D9AA5FF72CC35CF4.location - (0, 0, _id_CD25F37F5A816BF6 / 3);

    if(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_957163D1155464E2 == "island_storage")
      _id_ED0FC303D04A6B6F = 3000;

    _id_F1A7F6C5BF6A2F3F = spawn("trigger_radius", _id_E29C3D3F3A14F7EC, 0, int(_id_ED0FC303D04A6B6F), int(_id_CD25F37F5A816BF6));
    _id_F1A7F6C5BF6A2F3F.script_label = _id_6107468585B068B1[level._id_0104CEC67C308610._id_E57AA541604469A8];
    _id_F1A7F6C5BF6A2F3F.iconname = _id_6107468585B068B1[level._id_0104CEC67C308610._id_E57AA541604469A8];
    _id_F1A7F6C5BF6A2F3F.vfxent = _id_D9AA5FF72CC35CF4.vfxent;
    level._id_0104CEC67C308610._id_E57AA541604469A8++;
    _id_A8976AE75F6E2D39[index].trigger = _id_F1A7F6C5BF6A2F3F;
    _id_F1A7F6C5BF6A2F3F scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Double_Point_Zone_Rumble", _id_F1A7F6C5BF6A2F3F.origin, int(_id_ED0FC303D04A6B6F));
    _id_F1A7F6C5BF6A2F3F scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
    _id_F1A7F6C5BF6A2F3F thread _id_7B4837725DEA0DDD();
    _id_F1A7F6C5BF6A2F3F thread _id_C2FEBABF3A4A4627();
    _id_F1A7F6C5BF6A2F3F thread _id_23084390FF9E40DA();
    _id_F1A7F6C5BF6A2F3F thread _id_AF4162D5049B7624(_id_D9AA5FF72CC35CF4.location);
    _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "DOUBLE_POINT_ZONE" + _id_F1A7F6C5BF6A2F3F.script_label, "start");
    wait 0.5;
  }
}

_id_7B4837725DEA0DDD() {
  level endon("game_ended");
  self endon("death");
  self._id_74CD31DA10A00E02 = [];

  foreach(player in level.players) {
    if(player istouching(self) && isalive(player))
      _id_92A5CD00E7A94648(player);
  }

  for(;;) {
    self waittill("trigger", player);

    if((isPlayer(player) || isbot(player)) && !scripts\engine\utility::array_contains(self._id_74CD31DA10A00E02, player))
      _id_92A5CD00E7A94648(player);
  }
}

_id_C2FEBABF3A4A4627() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_74CD31DA10A00E02.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(self._id_74CD31DA10A00E02[_id_AC0E594AC96AA3A8]) && !self._id_74CD31DA10A00E02[_id_AC0E594AC96AA3A8] istouching(self) || !isalive(self._id_74CD31DA10A00E02[_id_AC0E594AC96AA3A8])) {
        _id_9E880639B601EA46(self._id_74CD31DA10A00E02[_id_AC0E594AC96AA3A8]);
        _id_AC0E594AC96AA3A8--;
      }
    }

    wait 0.1;
  }
}

_id_92A5CD00E7A94648(player) {
  self._id_74CD31DA10A00E02 = scripts\engine\utility::array_add(self._id_74CD31DA10A00E02, player);
  player._id_C2CB1DE83671B60D = 1;
  player playlocalsound("mp_powerup_activate_2x_plr");
  playfxontagforclients(level._effect["vfx_2x_points_screen_fx"], player, "tag_origin", player);
  player setclientomnvar("ui_show_double_points_hint", 1);
}

_id_9E880639B601EA46(player) {
  self._id_74CD31DA10A00E02 = scripts\engine\utility::array_remove(self._id_74CD31DA10A00E02, player);
  player._id_C2CB1DE83671B60D = 0;
  stopfxontagforclients(level._effect["vfx_2x_points_screen_fx"], player, "tag_origin", player);

  if(isDefined(player._id_2E1D8025416DC840))
    player._id_2E1D8025416DC840 destroy();

  player setclientomnvar("ui_show_double_points_hint", 0);
}

_id_23084390FF9E40DA() {
  level endon("game_ended");
  wait(level._id_0104CEC67C308610._id_D8976FF357E2A8C4);
  thread _id_567A9181885169A0();
}

_id_567A9181885169A0() {
  level thread _id_696EA7B58651631C();
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "DOUBLE_POINT_ZONE" + self.script_label, "end");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), self.vfxent, "tag_origin");
  self.vfxent delete();
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  self delete();
}

_id_696EA7B58651631C() {
  foreach(player in level.players) {
    if(istrue(player._id_C2CB1DE83671B60D)) {
      player._id_C2CB1DE83671B60D = 0;
      stopfxontagforclients(level._effect["vfx_2x_points_screen_fx"], player, "tag_origin", player);

      if(isDefined(player._id_2E1D8025416DC840))
        player._id_2E1D8025416DC840 destroy();

      player setclientomnvar("ui_show_double_points_hint", 0);
    }
  }
}

_id_B4DBBE7DED40FEF5(attacker, victim) {
  if(istrue(attacker._id_C2CB1DE83671B60D)) {
    playFX(level._effect["vfx_2x_points_victim_explosion"], victim.origin);
    _id_C40F543B5CAD5C1E = spawnscriptable("brloot_rumble_powerup_sfx", victim.origin);
    _id_C40F543B5CAD5C1E setscriptablepartstate("sfx", "2x_victim_death_3D");
    attacker playlocalsound("mp_powerup_victim_death_2x_plr");
    attacker thread scripts\mp\rank::giverankxp("rumble_double_point_zone_kill", 50, attacker.weapon, 0, 1);
    attacker thread scripts\mp\rank::scoreeventpopup("rumble_double_point_zone_kill");
  }
}

_id_13C3C66023DD793B() {}

_id_8353AA87C9026F4E(_id_13E6F2B18753A07F, location, _id_57B70900A9230CC0, _id_A2D14269AAE8C44B) {
  if(!isDefined(_id_57B70900A9230CC0))
    _id_57B70900A9230CC0 = level._id_0104CEC67C308610._id_EA94283EF41D334E;

  if(!isDefined(self._id_E9388D101A92080B))
    self._id_E9388D101A92080B = [];

  if(!isDefined(self._id_E9388D101A92080B[_id_13E6F2B18753A07F]))
    self._id_E9388D101A92080B[_id_13E6F2B18753A07F] = [];

  _id_58D7C0B3C77397AD = spawnStruct();
  _id_58D7C0B3C77397AD._id_13E6F2B18753A07F = _id_13E6F2B18753A07F;
  _id_58D7C0B3C77397AD.location = getgroundposition(location, 5);
  _id_58D7C0B3C77397AD._id_57B70900A9230CC0 = _id_57B70900A9230CC0;
  _id_58D7C0B3C77397AD._id_A2D14269AAE8C44B = _id_A2D14269AAE8C44B;
  self._id_E9388D101A92080B[_id_13E6F2B18753A07F] = scripts\engine\utility::array_add(self._id_E9388D101A92080B[_id_13E6F2B18753A07F], _id_58D7C0B3C77397AD);
}

_id_3D3CC3E223ED16C2(_id_39697B9BD80B8068) {
  level endon("game_ended");

  if(!isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B))
    level._id_0104CEC67C308610._id_E5B4C6599E6DFABC _id_8353AA87C9026F4E(_id_39697B9BD80B8068, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013);

  _id_A8976AE75F6E2D39 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B[_id_39697B9BD80B8068];
  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_42DFDF4DE1193973 = _id_39697B9BD80B8068;

  if(!isDefined(_id_A8976AE75F6E2D39) || _id_A8976AE75F6E2D39.size <= 0) {
    return;
  }
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "DOM_FLAG", "start");
  _id_8DF63A3026C606E6();
  level.objectivescaler = 1;

  if(getdvarint("dvar_1966033557794E8C", 0) == 0) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("dom_point_incoming", 0);
    _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_dom_flags_incoming");
    wait 20;
  }

  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("dom_point_started", 0);
  _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_dom_flags_online");
  wait 3.0;
  level thread _id_4FE70389E4F67C41();
}

_id_8DF63A3026C606E6() {
  _id_39697B9BD80B8068 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_42DFDF4DE1193973;
  _id_A8976AE75F6E2D39 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B[_id_39697B9BD80B8068];

  foreach(index, _id_D9AA5FF72CC35CF4 in _id_A8976AE75F6E2D39)
  _id_D9AA5FF72CC35CF4 thread _id_B453C63D786AFE89();
}

_id_4FE70389E4F67C41() {
  _id_6107468585B068B1 = ["_a", "_b", "_c", "_d", "_e"];

  if(!isDefined(level._id_0104CEC67C308610._id_854CFFC5385B5FB3)) {
    level._id_0104CEC67C308610._id_854CFFC5385B5FB3 = [];
    level._id_0104CEC67C308610._id_854CFFC5385B5FB3["allies"] = 0;
    level._id_0104CEC67C308610._id_854CFFC5385B5FB3["axis"] = 0;
  }

  if(!isDefined(level._id_0104CEC67C308610._id_E57AA541604469A8))
    level._id_0104CEC67C308610._id_E57AA541604469A8 = 0;

  if(!isDefined(level.domflags))
    level.domflags = [];

  _id_39697B9BD80B8068 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_42DFDF4DE1193973;
  _id_A8976AE75F6E2D39 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_E9388D101A92080B[_id_39697B9BD80B8068];

  foreach(index, _id_D9AA5FF72CC35CF4 in _id_A8976AE75F6E2D39) {
    _id_FDA3C589F5D2E91E = scripts\engine\utility::ter_op(isDefined(_id_D9AA5FF72CC35CF4._id_57B70900A9230CC0), _id_D9AA5FF72CC35CF4._id_57B70900A9230CC0, level._id_0104CEC67C308610._id_EA94283EF41D334E);
    _id_F1A7F6C5BF6A2F3F = spawn("trigger_radius", _id_D9AA5FF72CC35CF4.location, 0, int(_id_FDA3C589F5D2E91E), int(level.br_domheight));
    _id_F1A7F6C5BF6A2F3F.script_label = _id_6107468585B068B1[level._id_0104CEC67C308610._id_E57AA541604469A8];
    _id_F1A7F6C5BF6A2F3F.iconname = _id_6107468585B068B1[level._id_0104CEC67C308610._id_E57AA541604469A8];
    level._id_0104CEC67C308610._id_E57AA541604469A8++;
    _id_A8976AE75F6E2D39[index].trigger = _id_F1A7F6C5BF6A2F3F;
    _id_DD024ED57162C83A = _id_6663215F917210AE::setupobjective(_id_A8976AE75F6E2D39[index].trigger, "neutral");
    _id_DD024ED57162C83A.onuse = ::_id_324E15340E79D683;
    _id_DD024ED57162C83A.onbeginuse = ::_id_9470C2004C2756B4;
    _id_DD024ED57162C83A.onuseupdate = ::_id_E3E406A7A75AEB22;
    _id_DD024ED57162C83A.onenduse = ::_id_D5D7F4BCC077E934;
    _id_DD024ED57162C83A.oncontested = ::_id_0B6E67280BCD1281;
    _id_DD024ED57162C83A.onuncontested = ::_id_CED2A036A033CF28;
    _id_DD024ED57162C83A.onunoccupied = ::_id_2532FF0E4F7F59D3;
    _id_DD024ED57162C83A.onpinnedstate = ::_id_7CD59A939C8804D7;
    _id_DD024ED57162C83A.onunpinnedstate = ::_id_57EC19022D98A02E;
    _id_DD024ED57162C83A.stompeenemyprogressupdate = ::_id_97AD85249D03590E;
    _id_DD024ED57162C83A.stompprogressreward = ::_id_F5C27722997DFB6A;
    _id_DD024ED57162C83A.id = "domFlag";
    _id_DD024ED57162C83A.pinobj = 1;
    _id_DD024ED57162C83A.lockupdatingicons = 0;
    _id_DD024ED57162C83A.trigger = _id_F1A7F6C5BF6A2F3F;
    _id_DD024ED57162C83A._id_6DFAEE5EE2B3FA4B = 0;
    _id_DD024ED57162C83A._id_57B70900A9230CC0 = _id_FDA3C589F5D2E91E;
    _id_DD024ED57162C83A.pos = _id_D9AA5FF72CC35CF4.location;
    _id_DD024ED57162C83A.vfxent = _id_D9AA5FF72CC35CF4.vfxent;
    _id_DD024ED57162C83A scripts\mp\gameobjects::setcapturebehavior("persistent");
    _id_DD024ED57162C83A scripts\mp\gameobjects::setusetime(level._id_0104CEC67C308610._id_1DCF195956835ACB);
    objective_sethideelevation(_id_DD024ED57162C83A.objidnum, 1);
    _id_DD024ED57162C83A._id_5D4568577BCE6997 = [];
    _id_DD024ED57162C83A._id_5D4568577BCE6997["ally"] = spawnStruct();
    _id_DD024ED57162C83A._id_5D4568577BCE6997["enemy"] = spawnStruct();
    _id_DD024ED57162C83A._id_5D4568577BCE6997["neutral"] = spawnStruct();
    _id_DD024ED57162C83A._id_62280BF1B9E80D56 = "undefined";
    _id_DD024ED57162C83A._id_5D4568577BCE6997["neutral"] _id_5949B95B93CF07D1(_id_DD024ED57162C83A.curorigin, _id_FDA3C589F5D2E91E);
    _id_DD024ED57162C83A._id_5D4568577BCE6997["ally"] _id_5949B95B93CF07D1(_id_DD024ED57162C83A.curorigin, _id_FDA3C589F5D2E91E);
    _id_DD024ED57162C83A._id_5D4568577BCE6997["enemy"] _id_5949B95B93CF07D1(_id_DD024ED57162C83A.curorigin, _id_FDA3C589F5D2E91E);
    _id_DD024ED57162C83A _id_77CE7FB86B354B90("neutral");
    _id_DD024ED57162C83A thread _id_DC6831D079FA3947();
    _id_DD024ED57162C83A thread _id_44CC92122434BCC5();
    _id_A8976AE75F6E2D39[index]._id_DD024ED57162C83A = _id_DD024ED57162C83A;
    level.domflags[_id_DD024ED57162C83A.objectivekey] = _id_DD024ED57162C83A;
    wait 0.5;
  }

  setomnvar("ui_num_dom_flags", level.domflags.size);
}

_id_432A94723758BF86(player) {
  self._id_74CD31DA10A00E02 = scripts\engine\utility::array_add(self._id_74CD31DA10A00E02, player);
  player._id_1E1515CB65BE2BA9 = 1;
}

_id_83F8C40955D47070(player) {
  self._id_74CD31DA10A00E02 = scripts\engine\utility::array_remove(self._id_74CD31DA10A00E02, player);
  player._id_1E1515CB65BE2BA9 = 0;
}

_id_DC6831D079FA3947() {
  level endon("game_ended");
  self._id_74CD31DA10A00E02 = [];

  while(!self._id_6DFAEE5EE2B3FA4B) {
    self.trigger waittill("trigger", player);

    if((isPlayer(player) || isbot(player)) && !scripts\engine\utility::array_contains(self._id_74CD31DA10A00E02, player))
      _id_432A94723758BF86(player);

    waitframe();
  }
}

_id_44CC92122434BCC5() {
  level endon("game_ended");

  while(!self._id_6DFAEE5EE2B3FA4B) {
    foreach(player in self._id_74CD31DA10A00E02) {
      if(!player istouching(self.trigger) || !isalive(player))
        _id_83F8C40955D47070(player);
    }

    wait 0.1;
  }

  foreach(player in self._id_74CD31DA10A00E02)
  _id_83F8C40955D47070(player);
}

_id_642479D7AB426BE0(attacker, victim) {
  if(istrue(victim._id_1E1515CB65BE2BA9)) {
    attacker thread scripts\mp\rank::giverankxp("rumble_dom_flag_enemy_kill", 20, attacker.weapon, 0, 1);
    attacker thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_enemy_kill");
  }

  if(istrue(attacker._id_1E1515CB65BE2BA9)) {
    attacker thread scripts\mp\rank::giverankxp("rumble_dom_flag_defend_kill", 20, attacker.weapon, 0, 1);
    attacker thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_defend_kill");
  }
}

_id_5949B95B93CF07D1(origin, _id_FDA3C589F5D2E91E) {
  scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Dom_Flag_Rumble", origin, int(_id_FDA3C589F5D2E91E));
}

_id_77CE7FB86B354B90(_id_38E40C668A6A7CFF) {
  if(_id_38E40C668A6A7CFF != self._id_62280BF1B9E80D56) {
    self._id_62280BF1B9E80D56 = _id_38E40C668A6A7CFF;

    foreach(circle in self._id_5D4568577BCE6997)
    circle scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();

    _id_5ECB27F5876161B5 = self._id_62280BF1B9E80D56 != "axis" && self._id_62280BF1B9E80D56 != "allies";
    _id_94B27D6B0287AE65 = undefined;

    foreach(player in level.players) {
      _id_65D7D6385A34AD87 = player.team == self._id_62280BF1B9E80D56;

      if(_id_5ECB27F5876161B5)
        _id_94B27D6B0287AE65 = self._id_5D4568577BCE6997["neutral"];
      else
        _id_94B27D6B0287AE65 = scripts\engine\utility::ter_op(_id_65D7D6385A34AD87, self._id_5D4568577BCE6997["ally"], self._id_5D4568577BCE6997["enemy"]);

      if(isDefined(_id_94B27D6B0287AE65))
        _id_94B27D6B0287AE65 scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
    }

    if(isDefined(_id_94B27D6B0287AE65))
      scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, _id_38E40C668A6A7CFF);
  }
}

_id_5262AD19D7AB1217() {
  foreach(marker in self._id_5D4568577BCE6997)
  marker scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
}

_id_324E15340E79D683(_id_22282E7D48CA3400) {
  team = _id_22282E7D48CA3400.team;
  self._id_BC2378291C83A06D = team;
  self.capturetime = gettime();
  self._id_6DFAEE5EE2B3FA4B = 1;

  if(self.touchlist[team].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  self notify("pe_dom_flag_end");
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "DOM_FLAG", "end");
  thread _id_F49920F402F583AF(team);
}

_id_9470C2004C2756B4(_id_22282E7D48CA3400) {
  self.userate = 1.0;

  if(!isDefined(self.obj_icon_revealed) || !self.obj_icon_revealed) {
    self.obj_icon_revealed = 1;
    _id_3ACF1C0EBAF602F2::utilflare_shootflare(self.curorigin, "dom");
    _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(_id_22282E7D48CA3400.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

_id_E3E406A7A75AEB22(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  self.userate = 1.0;

  if(progress < 1.0 && !level.gameended && !istrue(self._id_6DFAEE5EE2B3FA4B))
    play_spotrep_capture_sfx(progress, team);

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;

  _id_77CE7FB86B354B90(team);
}

_id_D5D7F4BCC077E934(team, player, success) {
  _id_6663215F917210AE::dompoint_onuseend(team, player, success);
}

_id_0B6E67280BCD1281() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_contested_br");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  level thread _id_2CEDCC356F1B9FC8::brleaderdialog("exfil_contested");
  ownerteam = scripts\mp\gameobjects::getownerteam();
}

_id_CED2A036A033CF28(lastclaimteam) {
  ownerteam = scripts\mp\gameobjects::getownerteam();
  _id_6D8AD977256D66FC = undefined;
  _id_55773A75EDB2C052 = _id_F224CC04806FBD08();

  if(_id_55773A75EDB2C052 <= 1) {
    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

      if(_id_75016344BDEE1D3A > 0) {
        _id_6D8AD977256D66FC = _id_F90358454413407F;
        break;
      }
    }

    if(isDefined(_id_6D8AD977256D66FC))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, _id_6D8AD977256D66FC);
    else if(ownerteam != "neutral")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, ownerteam);
    else if(lastclaimteam != "none")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);

    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");

    if(lastclaimteam == "none" || ownerteam == "neutral")
      self.didstatusnotify = 0;
  }
}

_id_2532FF0E4F7F59D3() {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_captureneutral_br");
  else
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");

  self.didstatusnotify = 0;
}

_id_7CD59A939C8804D7(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");
}

_id_57EC19022D98A02E(player) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defend_br", "waypoint_capture_br");
}

_id_97AD85249D03590E(team) {
  self.userate = level._id_0104CEC67C308610._id_4FA10F408B75E7B2;
  _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(team);
  progress = undefined;

  foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
    _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

    if(_id_75016344BDEE1D3A > 0)
      progress = _id_75016344BDEE1D3A / self.usetime;
  }
}

_id_F5C27722997DFB6A(player) {
  player thread scripts\mp\utility\points::giveunifiedpoints("obj_prog_defend");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_defending_br", "waypoint_capture_br");

  if(isDefined(self.lastprogressteam))
    self.lastprogressteam = undefined;
}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

_id_F49920F402F583AF(team) {
  if(isDefined(team) && team != "tie") {
    level._id_0104CEC67C308610._id_854CFFC5385B5FB3[team] = level._id_0104CEC67C308610._id_854CFFC5385B5FB3[team] + 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(team, 15, 0);

    foreach(player in level.players) {
      if(isDefined(player) && isDefined(player.team) && player.team == team) {
        player thread _id_801BD8BEE01E3697(1, team);
        player thread scripts\mp\hud_message::showsplash("br_rumble_pe_dom_flag_captured_ally");
        continue;
      }

      if(isDefined(player) && isDefined(player.team) && player.team != team) {
        player thread _id_801BD8BEE01E3697(0, team);
        player thread scripts\mp\hud_message::showsplash("br_rumble_pe_dom_flag_captured_enemy");
      }
    }

    foreach(_id_13AAAB0EE500428D in self.touchlist[team]) {
      player = _id_13AAAB0EE500428D.player;
      player thread scripts\mp\rank::giverankxp("rumble_dom_flag_capture", 250, player getcurrentprimaryweapon());
      player thread scripts\mp\rank::scoreeventpopup("rumble_dom_flag_capture");
    }

    thread _id_AF4162D5049B7624(self.pos);
    thread _id_C6578015E73027B3(self);
  }
}

_id_801BD8BEE01E3697(_id_AEC2F50555D1D619, team) {
  _id_57F961E6B4249ACE = level._id_0104CEC67C308610._id_854CFFC5385B5FB3[team];

  switch (_id_57F961E6B4249ACE) {
    case 1:
      if(_id_AEC2F50555D1D619)
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_friendly_capture_1", self);
      else
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_enemy_capture_1", self);

      break;
    case 2:
      if(_id_AEC2F50555D1D619)
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_friendly_capture_2", self);
      else
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_enemy_capture_2", self);

      break;
    case 3:
      if(_id_AEC2F50555D1D619)
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_friendly_capture_all", self);
      else
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("dom_point_enemy_capture_all", self);

      break;
  }
}

_id_C6578015E73027B3(_id_DD024ED57162C83A) {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), _id_DD024ED57162C83A.vfxent, "tag_origin");
  _id_DD024ED57162C83A.vfxent delete();
  _id_DD024ED57162C83A _id_5262AD19D7AB1217();
  level.domflags[_id_DD024ED57162C83A.objectivekey] = undefined;
  _id_6663215F917210AE::removeobjective(_id_DD024ED57162C83A);
  setomnvar("ui_num_dom_flags", level.domflags.size);
}

_id_B453C63D786AFE89() {
  vfxent = spawn("script_model", self.location - (0, 0, 3));
  vfxent setModel("tag_origin");
  self.vfxent = vfxent;
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_green"), vfxent, "tag_origin");
}

_id_AF4162D5049B7624(_id_254F9C6C23AD6894) {
  level thread _id_C38578F093C16790(_id_254F9C6C23AD6894, "loot_table_dom_flag_capture_cash", 25);
  level thread _id_C38578F093C16790(_id_254F9C6C23AD6894, "loot_table_dom_flag_capture_weapons", 5);
}

_id_F224CC04806FBD08() {
  _id_6686E1CB99A097C7 = 0;

  foreach(index, _id_5759BFD9CFF3ECAD in self.numtouching) {
    if(_id_5759BFD9CFF3ECAD > 0 && (!isstring(index) || index != "none"))
      _id_6686E1CB99A097C7++;
  }

  return _id_6686E1CB99A097C7;
}

_id_83E20FE5AF1E31DE() {}

_id_3B02306F15C7109B(_id_F8307191D62CC285) {
  if(!isDefined(self._id_A0B7A33A8D360857))
    self._id_A0B7A33A8D360857 = [];

  self._id_A0B7A33A8D360857[self._id_A0B7A33A8D360857.size] = _id_F8307191D62CC285;
}

_id_1E253808F533D0E7() {
  level endon("game_ended");
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "BONUS_POINT_CRATES", "start");
  _id_2E910C80B9B6B13B();
  level thread _id_3C9E0700257A86F9(level._id_0104CEC67C308610._id_B632C2DCAED34F63);

  if(getdvarint("dvar_1966033557794E8C", 0) == 0) {
    _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_bonus_point_crates_incoming");
    wait 20;
  }

  _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_bonus_point_crates_online");
  wait 3.0;
  level thread _id_86931A3CABCFEA54();
}

_id_2E910C80B9B6B13B() {
  level._id_0104CEC67C308610._id_D89D6BC0B884C364 = spawnStruct();
  level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_0CB1AE2171EF55CA = [];
  level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_A46A0C992292906F = [];

  if(!isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857)) {
    _id_204651639FA2E52E = (0, 0, 0);

    if(isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013))
      _id_204651639FA2E52E = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013;

    level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857 = [_id_204651639FA2E52E + (0, 0, 0), _id_204651639FA2E52E + (1500, 1500, 0), _id_204651639FA2E52E + (1500, -1500, 0), _id_204651639FA2E52E + (-1500, 1500, 0), _id_204651639FA2E52E + (-1500, -1500, 0), _id_204651639FA2E52E + (3000, 3000, 0), _id_204651639FA2E52E + (3000, -3000, 0), _id_204651639FA2E52E + (-3000, 3000, 0), _id_204651639FA2E52E + (-3000, -3000, 0)];
  }

  level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857 = scripts\engine\utility::array_randomize(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857);
  _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata("bonus_points_crate");
  _id_962A30A9BB8C0F09.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  _id_962A30A9BB8C0F09.dummymodel = "military_carepackage_01_br_legendary";
  _id_962A30A9BB8C0F09.friendlymodel = undefined;
  _id_962A30A9BB8C0F09.enemymodel = undefined;
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.minimapicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 0;
  _id_962A30A9BB8C0F09.ownerusetime = level._id_0104CEC67C308610._id_B4C111365C4590EE;
  _id_962A30A9BB8C0F09.otherusetime = level._id_0104CEC67C308610._id_B4C111365C4590EE;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_A2C6E9BD8230CD91;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_C94D01A822F6BE94;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
}

_id_86931A3CABCFEA54() {
  level endon("game_ended");
  _id_C133979F6F9158B3 = level._id_0104CEC67C308610._id_B632C2DCAED34F63;
  _id_D0D783FC227DD4C4 = level._id_0104CEC67C308610._id_BEBDA217EBF6901F - _id_C133979F6F9158B3;
  _id_8BD4C2A69C3CF140(_id_C133979F6F9158B3);

  if(level._id_0104CEC67C308610._id_83637D460DD87EE3 > 20)
    wait(level._id_0104CEC67C308610._id_83637D460DD87EE3 - 20);

  level thread _id_3C9E0700257A86F9(_id_D0D783FC227DD4C4, _id_C133979F6F9158B3);
  wait 20;
  _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_bonus_point_crates_online");
  wait 3.0;
  _id_8BD4C2A69C3CF140(_id_D0D783FC227DD4C4, _id_C133979F6F9158B3);
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "BONUS_POINT_CRATES", "end");
}

_id_8BD4C2A69C3CF140(_id_684BE885275FC40C, _id_8F064B1FEC073A16) {
  level endon("game_ended");

  if(!isDefined(_id_8F064B1FEC073A16))
    _id_8F064B1FEC073A16 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_684BE885275FC40C; _id_AC0E594AC96AA3A8++) {
    _id_BBA9345ED0F43C7A = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857[_id_AC0E594AC96AA3A8 + _id_8F064B1FEC073A16];
    _id_BBA9345ED0F43C7A = _id_BBA9345ED0F43C7A + (0, 0, 2000);
    _id_81DB42F1ECEB1029 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, undefined, "bonus_points_crate", _id_BBA9345ED0F43C7A, (0, randomint(360), 0));
    level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_0CB1AE2171EF55CA[level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_0CB1AE2171EF55CA.size] = _id_81DB42F1ECEB1029;
    _id_81DB42F1ECEB1029 thread _id_57FEC0320FFC5B2A();
    _id_81DB42F1ECEB1029 thread _id_918D7159C5CFFC35();
    wait 2.5;
  }
}

_id_57FEC0320FFC5B2A() {
  _id_254F9C6C23AD6894 = scripts\engine\utility::drop_to_ground(self.origin, 50, -3000, (0, 0, 1));
  self._id_06C42F44EF2EE2BA = spawn("script_model", _id_254F9C6C23AD6894 + (0, 0, 3));
  self._id_06C42F44EF2EE2BA setModel("scr_smoke_grenade");
  wait 1.0;
  self._id_06C42F44EF2EE2BA setscriptablepartstate("smoke", "on");
  self._id_06C42F44EF2EE2BA setscriptablepartstate("br_rumble_bonus_point_audio", "smoke_sfx");
}

_id_918D7159C5CFFC35() {
  self setscriptablepartstate("objective", "bonus_points_10");
}

_id_3C9E0700257A86F9(_id_684BE885275FC40C, _id_8F064B1FEC073A16) {
  if(!isDefined(_id_8F064B1FEC073A16))
    _id_8F064B1FEC073A16 = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_684BE885275FC40C; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857[_id_AC0E594AC96AA3A8 + _id_8F064B1FEC073A16])) {
      return;
    }
    level thread _id_55860650F026DE50(_id_AC0E594AC96AA3A8 + _id_8F064B1FEC073A16);
    wait 2.0;
  }
}

_id_55860650F026DE50(_id_04591DEDF9B5DB1B) {
  _id_F8307191D62CC285 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A0B7A33A8D360857[_id_04591DEDF9B5DB1B];
  _id_3ACF1C0EBAF602F2::utilflare_shootflare(_id_F8307191D62CC285, "dom");
}

_id_A2C6E9BD8230CD91(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

_id_C94D01A822F6BE94(player) {
  level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_0CB1AE2171EF55CA = scripts\engine\utility::array_remove(level._id_0104CEC67C308610._id_D89D6BC0B884C364._id_0CB1AE2171EF55CA, self);
  self setscriptablepartstate("jugg_drop_beacon", "off");
  self setscriptablepartstate("bonus_points_audio", "expl_sfx");
  level thread _id_1BF0625B4D22A0E8(player.team);
  self notify("captured");
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), self.origin);
  item_count = randomintrange(3, 5);
  level thread _id_6D7971E13B2E3B2A::_id_889A4446BB24EC16("bonus_points_crate", self.origin, item_count, 0);
  level scripts\mp\gamescore::giveteamscoreforobjective(player.pers["team"], level._id_0104CEC67C308610._id_FFC9C156B2BA484D, 0);

  if(isDefined(self.objectiveiconid))
    objective_delete(self.objectiveiconid);

  playFX(level._effect["small_snowhit"], self._id_06C42F44EF2EE2BA.origin);
  self._id_06C42F44EF2EE2BA delete();
}

_id_1BF0625B4D22A0E8(_id_02EA49D6356F3AD8) {
  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.team) && player.team == _id_02EA49D6356F3AD8)
      player thread scripts\mp\hud_message::showsplash("br_rumble_pe_bonus_point_crate_captured_ally");
  }
}

_id_78155E0796EDAA49() {}

_id_9CF505D78659AF0D() {
  level._id_0104CEC67C308610._id_7DB4F44FD3537013 = spawnStruct();
  level._id_0104CEC67C308610._id_7DB4F44FD3537013.active = 0;
  level._id_0104CEC67C308610._id_7DB4F44FD3537013 _id_C3DB8977A40CE00E();
  level._id_0104CEC67C308610._id_7DB4F44FD3537013.inited = 1;
}

_id_BF7C1B64CC2B8DC1() {
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "KILL_LEADER", "start");

  if(getdvarint("dvar_1966033557794E8C", 0) == 0) {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("hvt_incoming", 0);
    _id_337BD370F7C5E6F9::showsplashtoall("br_rumble_pe_kill_leader_event_incoming");
    wait 20;
  }

  level._id_0104CEC67C308610._id_7DB4F44FD3537013.active = 1;
  level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719 = [];
  level._id_0104CEC67C308610._id_7DB4F44FD3537013 _id_33FF407DA18EA5ED();
  wait 3.0;
  level._id_0104CEC67C308610._id_7DB4F44FD3537013 thread _id_69CE333D1E5DBBD9();
  level._id_0104CEC67C308610._id_7DB4F44FD3537013 thread _id_67686004B75DD2C5();
}

_id_0C4F79070E147BCA(attacker, victim) {
  if(!isDefined(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719)) {
    return;
  }
  _id_EA612FA54001DAE1 = 500;
  _id_24DAEF913FC7B624 = undefined;

  foreach(_id_0BA89A03FF462799 in level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719) {
    if(_id_0BA89A03FF462799.team == attacker.team && _id_0BA89A03FF462799 != attacker) {
      _id_7DE3059B3405A834 = distance2d(_id_0BA89A03FF462799.origin, victim.origin) < _id_EA612FA54001DAE1;
      _id_39A5F9449D91ACBD = abs(_id_0BA89A03FF462799.origin[2] - victim.origin[2]) < 500;
      _id_1A37E862D49007D1 = _id_7DE3059B3405A834 && _id_39A5F9449D91ACBD;
      _id_D0ED700A32FB6F97 = distance2d(_id_0BA89A03FF462799.origin, victim.origin) < _id_EA612FA54001DAE1;
      _id_41D3823D6B7BAF7E = abs(_id_0BA89A03FF462799.origin[2] - victim.origin[2]) < 500;
      _id_372D3EBEB208CBB4 = _id_D0ED700A32FB6F97 && _id_41D3823D6B7BAF7E;

      if(_id_1A37E862D49007D1 || _id_372D3EBEB208CBB4) {
        attacker thread scripts\mp\rank::giverankxp("rumble_hvt_defend_kill", int(50), attacker getcurrentprimaryweapon());
        attacker thread scripts\mp\rank::scoreeventpopup("rumble_hvt_defend_kill");
        break;
      }
    }
  }
}

_id_67686004B75DD2C5() {
  level endon("game_ended");
  self endon("pe_kill_leader_event_end");
  _id_A7F29930A5DD5069 = gettime() + (level._id_0104CEC67C308610._id_47737B189C97B49E - 3.0) * 1000;
  _id_FC7BD6576D8C85BE = spawn("script_origin", (0, 0, 0));
  _id_FC7BD6576D8C85BE hide();
  level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_FC7BD6576D8C85BE = _id_FC7BD6576D8C85BE;
  setomnvar("ui_publicevent_timer_type", 3);
  setomnvar("ui_publicevent_timer", _id_A7F29930A5DD5069);
  wait(level._id_0104CEC67C308610._id_47737B189C97B49E - 5 - 3.0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    _id_FC7BD6576D8C85BE playSound("ui_mp_fire_sale_timer");
    wait 1.0;
  }

  level._id_0104CEC67C308610._id_7DB4F44FD3537013 thread _id_D270DBE64F3F8B20();
}

_id_D270DBE64F3F8B20(result, delay_time) {
  level endon("game_ended");
  level._id_0104CEC67C308610._id_7DB4F44FD3537013.active = 0;

  if(isDefined(delay_time) && delay_time > 0)
    wait(delay_time);

  if(!isDefined(result))
    result = "default";

  if(isDefined(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_FC7BD6576D8C85BE))
    level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_FC7BD6576D8C85BE delete();

  setomnvar("ui_publicevent_timer_type", 0);
  _id_0AA81B2C7E0A29A1 = _id_AFDF075622B2B672();
  _id_9D01F90972661D79 = "br_rumble_pe_kill_leader_event_end_early_contested";
  _id_AE2B5B0F11B09E51 = result == "hvt_team_wiped" && _id_0AA81B2C7E0A29A1 != "contested";

  foreach(player in level.players) {
    if(_id_AE2B5B0F11B09E51) {
      if(player.team == _id_0AA81B2C7E0A29A1) {
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("hvt_all_enemies_down", player, 0);
        _id_9D01F90972661D79 = "br_rumble_pe_kill_leader_event_end_early_eliminated_enemy";
      } else {
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("hvt_all_friendlies_down", player, 0);
        _id_9D01F90972661D79 = "br_rumble_pe_kill_leader_event_end_early_eliminated_ally";
      }
    }

    player thread scripts\mp\hud_message::showsplash(_id_9D01F90972661D79);
  }

  level._id_0104CEC67C308610 _id_E9964B52CB43D0C3();
  _id_BE56E650A1744068();
  level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719 = [];
  _id_362C58E8BB39BCDA::runbrgametypefunc("onPublicEvent", "KILL_LEADER", "end");
  self notify("pe_kill_leader_event_end");
}

_id_624AD28A5E1B3673() {
  _id_00F48ABA7417F944 = _id_7752474D613E35CF();
  _id_A79C6833167BC89B = _id_00F48ABA7417F944["axis"];
  _id_F572BE73CFC174B0 = _id_00F48ABA7417F944["allies"];

  if(_id_A79C6833167BC89B == 0 || _id_F572BE73CFC174B0 == 0 || level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719.size == 0) {
    _id_B8D5E9A7FE5F0982 = 0;
    _id_0AA81B2C7E0A29A1 = undefined;
    level._id_0104CEC67C308610._id_7DB4F44FD3537013 thread _id_D270DBE64F3F8B20("hvt_team_wiped", 2.0);
  }
}

_id_7752474D613E35CF() {
  _id_A79C6833167BC89B = 0;
  _id_F572BE73CFC174B0 = 0;
  _id_C2FF525CC0819CED = [];
  _id_C2FF525CC0819CED["axis"] = 0;
  _id_C2FF525CC0819CED["allies"] = 0;

  foreach(player in level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719) {
    switch (player.team) {
      case "axis":
        _id_C2FF525CC0819CED["axis"]++;
        break;
      case "allies":
        _id_C2FF525CC0819CED["allies"]++;
        break;
    }
  }

  return _id_C2FF525CC0819CED;
}

_id_AFDF075622B2B672() {
  _id_00F48ABA7417F944 = _id_7752474D613E35CF();
  _id_A79C6833167BC89B = _id_00F48ABA7417F944["axis"];
  _id_F572BE73CFC174B0 = _id_00F48ABA7417F944["allies"];

  if(_id_A79C6833167BC89B == _id_F572BE73CFC174B0)
    return "contested";

  return scripts\engine\utility::ter_op(_id_A79C6833167BC89B > _id_F572BE73CFC174B0, "axis", "allies");
}

_id_E9964B52CB43D0C3() {
  foreach(player in level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719) {
    player _id_147FE8A0BB56F478();
    player _id_DCA79042529DDCCF();
    player._id_9A68B3D36F171DEF._id_6523F332569C288E = 0;
    level scripts\mp\gamescore::giveteamscoreforobjective(player.team, 5, 0);
    player thread _id_6AFF3948CF4CCA03::playerplunderpickup(50);
    player thread _id_22DBB2121945DE95();
  }
}

_id_22DBB2121945DE95() {
  self endon("death_or_disconnect");
  wait 4;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("hvt_survived", self, 0);
  thread scripts\mp\hud_message::showsplash("br_rumble_pe_kill_leader_event_survived_player", 5);
  thread scripts\mp\rank::giverankxp("rumble_hvt_survivor", 250, self getcurrentprimaryweapon());
  thread scripts\mp\rank::scoreeventpopup("rumble_hvt_survivor");
}

_id_69CE333D1E5DBBD9() {
  _id_00F48ABA7417F944 = _id_7752474D613E35CF();
  _id_A79C6833167BC89B = _id_00F48ABA7417F944["axis"];
  _id_F572BE73CFC174B0 = _id_00F48ABA7417F944["allies"];

  foreach(player in level.players) {
    if(isDefined(player)) {
      switch (player.team) {
        case "axis":
          _id_24DB96216C5F6124 = scripts\engine\utility::string(_id_A79C6833167BC89B) + scripts\engine\utility::string(_id_F572BE73CFC174B0) + scripts\engine\utility::string(1);
          player setclientomnvar("rebirth_tracked_teams", int(_id_24DB96216C5F6124));
          break;
        case "allies":
          _id_24DB96216C5F6124 = scripts\engine\utility::string(_id_F572BE73CFC174B0) + scripts\engine\utility::string(_id_A79C6833167BC89B) + scripts\engine\utility::string(1);
          player setclientomnvar("rebirth_tracked_teams", int(_id_24DB96216C5F6124));
          break;
      }
    }
  }
}

_id_BE56E650A1744068() {
  foreach(player in level.players) {
    if(isDefined(player))
      player setclientomnvar("rebirth_tracked_teams", 0);
  }
}

_id_EAE765F2D3C6518B(victim) {
  _id_A79C6833167BC89B = 0;
  _id_F572BE73CFC174B0 = 0;

  foreach(player in level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719) {
    switch (player.team) {
      case "axis":
        _id_A79C6833167BC89B++;
        break;
      case "allies":
        _id_F572BE73CFC174B0++;
        break;
    }
  }

  teams = [];
  teams["axis"] = _id_A79C6833167BC89B;
  teams["allies"] = _id_F572BE73CFC174B0;
  _id_EB7693FEF0043E5D = teams[self.team];
  _id_1A7EDD4E9533ED49 = teams[scripts\engine\utility::get_enemy_team(self.team)];
  _id_24DB96216C5F6124 = scripts\engine\utility::string(_id_EB7693FEF0043E5D) + scripts\engine\utility::string(_id_1A7EDD4E9533ED49) + scripts\engine\utility::string(1);
  self setclientomnvar("rebirth_tracked_teams", int(_id_24DB96216C5F6124));
}

_id_8899CF9DCE4CC3C1(player) {
  if(!isDefined(player._id_9A68B3D36F171DEF)) {
    stats = spawnStruct();
    stats._id_6523F332569C288E = 0;
    stats.obj_id = undefined;
    player._id_9A68B3D36F171DEF = stats;
  }
}

_id_C3DB8977A40CE00E() {
  foreach(player in level.players) {
    if(isDefined(player))
      _id_8899CF9DCE4CC3C1(player);
  }
}

_id_CF2E52A95817434F(attacker, victim, meansofdeath) {
  if(!isDefined(victim) || !isDefined(level._id_0104CEC67C308610._id_7DB4F44FD3537013) || !isDefined(level._id_0104CEC67C308610._id_7DB4F44FD3537013.inited) || !level._id_0104CEC67C308610._id_7DB4F44FD3537013.active) {
    return;
  }
  if(scripts\engine\utility::array_contains(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719, victim)) {
    _id_3152A2A3C434F5F8 = isDefined(meansofdeath) && (meansofdeath == "MOD_SUICIDE" || meansofdeath == "MOD_FALLING") || isDefined(attacker) && attacker == victim;
    victim _id_D89594F053E9F8C8(attacker, _id_3152A2A3C434F5F8);
    victim _id_DCA79042529DDCCF();
    victim _id_147FE8A0BB56F478();
    playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), victim.origin);
    playsoundatpos(victim.origin, "br_splash_vip_eliminated");

    if(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719.size > 1)
      level._id_0104CEC67C308610._id_7DB4F44FD3537013 thread _id_59DE696073D47FF9(victim);

    victim._id_9A68B3D36F171DEF._id_6523F332569C288E = 0;
    level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719 = scripts\engine\utility::array_remove(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719, victim);

    foreach(player in level.players)
    player _id_EAE765F2D3C6518B(victim);
  }

  _id_624AD28A5E1B3673();
}

_id_59DE696073D47FF9(victim) {
  level endon("game_ended");

  if(!isDefined(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_0E9E0055DB487F69))
    level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_0E9E0055DB487F69 = 0;

  if(!level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_0E9E0055DB487F69) {
    level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_0E9E0055DB487F69 = 1;
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hvt_friendly_down", victim.team);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("hvt_enemy_down", scripts\engine\utility::get_enemy_team(victim.team));
    wait 8.0;
    level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_0E9E0055DB487F69 = 0;
  }
}

_id_D89594F053E9F8C8(attacker, _id_3152A2A3C434F5F8) {
  _id_FF8BD721AF677C90 = scripts\engine\utility::get_enemy_team(self.team);
  _id_FD11AE5E0579A7D6 = 4;
  _id_ECA5D6354CB0175F = 25;

  if(istrue(_id_3152A2A3C434F5F8)) {
    _id_FD11AE5E0579A7D6 = _id_FD11AE5E0579A7D6 + 1;
    level scripts\mp\gamescore::giveteamscoreforobjective(_id_FF8BD721AF677C90, _id_FD11AE5E0579A7D6, 0);
    return;
  }

  if(isDefined(attacker) && istrue(attacker._id_D933C184544F70FC)) {
    _id_FD11AE5E0579A7D6 = _id_FD11AE5E0579A7D6 * 2;
    _id_ECA5D6354CB0175F = _id_ECA5D6354CB0175F * 2;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(_id_FF8BD721AF677C90, _id_FD11AE5E0579A7D6, 0);

  if(isDefined(attacker) && isPlayer(attacker))
    attacker thread _id_6AFF3948CF4CCA03::playerplunderpickup(_id_ECA5D6354CB0175F);
}

_id_33FF407DA18EA5ED() {
  teams = ["axis", "allies"];

  foreach(team in teams) {
    _id_5BEBEBD097B1B1D5 = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_6002C2AFC202F10C = 0;
    _id_81A1C1801A5F264E = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
      _id_ED0728A97B5FC740 = undefined;
      _id_61ACCA2AB76E50D4 = 0;

      foreach(player in _id_5BEBEBD097B1B1D5) {
        if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player) || istrue(player._id_9A68B3D36F171DEF._id_6523F332569C288E) || scripts\engine\utility::array_contains(_id_81A1C1801A5F264E, player.squadindex)) {
          continue;
        }
        if(player.pers["kills"] > _id_61ACCA2AB76E50D4) {
          _id_ED0728A97B5FC740 = player;
          _id_61ACCA2AB76E50D4 = player.pers["kills"];
        }
      }

      if(isDefined(_id_ED0728A97B5FC740)) {
        _id_ED0728A97B5FC740 _id_56A11C50E0B8564D();
        _id_81A1C1801A5F264E[_id_81A1C1801A5F264E.size] = _id_ED0728A97B5FC740.squadindex;
        _id_6002C2AFC202F10C++;
        continue;
      }

      break;
    }

    _id_C747512A8505DB08 = 5 - _id_6002C2AFC202F10C;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C747512A8505DB08; _id_AC0E594AC96AA3A8++) {
      _id_5BEBEBD097B1B1D5 = scripts\engine\utility::array_randomize(_id_5BEBEBD097B1B1D5);
      _id_ED0728A97B5FC740 = undefined;

      foreach(_id_74F707A38E49E310 in _id_5BEBEBD097B1B1D5) {
        if(istrue(_id_74F707A38E49E310._id_9A68B3D36F171DEF._id_6523F332569C288E) || scripts\engine\utility::array_contains(_id_81A1C1801A5F264E, _id_74F707A38E49E310.squadindex) || !scripts\mp\utility\player::isreallyalive(_id_74F707A38E49E310)) {
          continue;
        }
        _id_ED0728A97B5FC740 = _id_74F707A38E49E310;
      }

      if(isDefined(_id_ED0728A97B5FC740)) {
        _id_ED0728A97B5FC740 _id_56A11C50E0B8564D();
        _id_81A1C1801A5F264E[_id_81A1C1801A5F264E.size] = _id_ED0728A97B5FC740.squadindex;
        _id_6002C2AFC202F10C++;
        continue;
      }

      break;
    }
  }

  foreach(player in level.players) {
    if(!istrue(player._id_9A68B3D36F171DEF._id_6523F332569C288E)) {
      level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("hvt_started", player, 0);
      player thread scripts\mp\hud_message::showsplash("br_rumble_pe_kill_leader_event_start_as_hunter");
    }
  }
}

_id_56A11C50E0B8564D() {
  self._id_9A68B3D36F171DEF._id_6523F332569C288E = 1;
  level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719 = scripts\engine\utility::array_add(level._id_0104CEC67C308610._id_7DB4F44FD3537013._id_9DA072CB42B63719, self);
  thread _id_F043EDBC3AFB89CE();
  thread _id_BAFB983876363896();
  thread scripts\mp\hud_message::showsplash("br_rumble_pe_kill_leader_event_start_as_target");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("hvt_hunted", self, 0, 0);
}

_id_BAFB983876363896() {
  level endon("game_ended");
  wait 8;
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608 = [];
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0] = spawnStruct();
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1] = spawnStruct();
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("kill_leader_stats_rumble_1", self.origin, 0);
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("kill_leader_stats_rumble_2", self.origin, 0);
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0] scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(0);
  self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1] scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(0);
  _id_FF8BD721AF677C90 = scripts\engine\utility::get_enemy_team(self.team);
  _id_BBCF436A8958AC11 = scripts\mp\utility\teams::getteamdata(_id_FF8BD721AF677C90, "players");

  foreach(player in level.players) {
    _id_CEB3752076F28908 = self.team == player.team;
    self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[scripts\engine\utility::ter_op(_id_CEB3752076F28908, 0, 1)] scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  }

  if(isDefined(self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0]))
    self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0] thread _id_C562B84B8059D4F3(self);

  if(isDefined(self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1]))
    self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1] thread _id_C562B84B8059D4F3(self, 8);
}

_id_C562B84B8059D4F3(player, _id_E2A5E9ED59B3FDC0) {
  level endon("game_ended");

  for(;;) {
    if(!isDefined(player) || !isalive(player) || !isDefined(self.mapcircle)) {
      break;
    }

    scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(player.origin);
    scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(0);

    if(isDefined(_id_E2A5E9ED59B3FDC0)) {
      wait(_id_E2A5E9ED59B3FDC0);
      continue;
    }

    waitframe();
  }

  player _id_147FE8A0BB56F478();
}

_id_147FE8A0BB56F478() {
  if(!isDefined(self._id_9A68B3D36F171DEF._id_FA59EBB74F949608) || !isDefined(self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[0]) || !isDefined(self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[1])) {
    return;
  }
  foreach(_id_AC0E594AC96AA3A8, icon in self._id_9A68B3D36F171DEF._id_FA59EBB74F949608) {
    if(isDefined(icon)) {
      icon scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
      self._id_9A68B3D36F171DEF._id_FA59EBB74F949608[_id_AC0E594AC96AA3A8] = undefined;
    }
  }
}

_id_F043EDBC3AFB89CE() {
  if(isDefined(self._id_9A68B3D36F171DEF.obj_id)) {
    return;
  }
  _id_FAEBA1250FB51F3C = "ui_mp_br_mapmenu_icon_plunder_leader";
  obj_id = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_state(obj_id, "invisible");
  objective_position(obj_id, self.origin + (0, 0, 100));
  objective_setplayintro(obj_id, 0);
  objective_setshowoncompass(obj_id, 0);
  objective_setshowdistance(obj_id, 0);
  _func_C047D7FFE7A83501(obj_id, 0, 1150);
  scripts\mp\objidpoolmanager::update_objective_icon(obj_id, _id_FAEBA1250FB51F3C);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(obj_id, 100);
  scripts\mp\objidpoolmanager::update_objective_onentity(obj_id, self);
  _id_FF8BD721AF677C90 = scripts\engine\utility::get_enemy_team(self.team);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(obj_id, self.team);
  scripts\mp\objidpoolmanager::update_objective_setbackground(obj_id, 6);

  if(!isDefined(self._id_9A68B3D36F171DEF.obj_id))
    self._id_9A68B3D36F171DEF.obj_id = [];

  self._id_9A68B3D36F171DEF.obj_id[self._id_9A68B3D36F171DEF.obj_id.size] = obj_id;

  if(!isDefined(self._id_9A68B3D36F171DEF.obj_id))
    self._id_9A68B3D36F171DEF.obj_id = [];

  self._id_9A68B3D36F171DEF.obj_id[self._id_9A68B3D36F171DEF.obj_id.size] = obj_id;
}

_id_DCA79042529DDCCF() {
  if(!isDefined(self._id_9A68B3D36F171DEF.obj_id)) {
    return;
  }
  foreach(obj_id in self._id_9A68B3D36F171DEF.obj_id)
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(obj_id);

  self._id_9A68B3D36F171DEF.obj_id = undefined;
}

_id_9671B8B3DA9537A7() {}

delayedshowtablets(_id_294684D6A0DEEF46) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  waitframe();
  _id_94E68B79ABE0FC42 = [];

  foreach(tablet in _id_294684D6A0DEEF46) {
    _id_DDF59954FB497439 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius - level._id_0104CEC67C308610._id_DA8C79754A42FFB2;

    if(scripts\engine\utility::ispointinsidecircle(tablet.origin, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013, _id_DDF59954FB497439))
      _id_94E68B79ABE0FC42[_id_94E68B79ABE0FC42.size] = tablet;
  }

  _id_5B1C81A103054032 = [];
  _id_3849E1290EC01D21 = [];
  _id_46D8B39844967CAE = [];

  foreach(tablet in _id_94E68B79ABE0FC42) {
    _id_352D0AA31DD69503 = distance(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["axis"], tablet.origin);
    _id_0401495306D49AEA = distance(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["allies"], tablet.origin);
    _id_A45B8B6C00B4FCBD = abs(_id_352D0AA31DD69503 - _id_0401495306D49AEA);

    if(_id_A45B8B6C00B4FCBD <= level._id_0104CEC67C308610._id_7B4F16DE8DD44BCB) {
      _id_46D8B39844967CAE[_id_46D8B39844967CAE.size] = tablet;
      continue;
    }

    if(_id_352D0AA31DD69503 < _id_0401495306D49AEA) {
      _id_5B1C81A103054032[_id_5B1C81A103054032.size] = tablet;
      continue;
    }

    _id_3849E1290EC01D21[_id_3849E1290EC01D21.size] = tablet;
  }

  _id_22B5FF4E379DDEEC = int(min(_id_5B1C81A103054032.size / 2, _id_3849E1290EC01D21.size / 2));
  _id_22B5FF4E379DDEEC = int(min(_id_22B5FF4E379DDEEC, level._id_0104CEC67C308610._id_90204C7420012EF4));
  _id_6E12F3619ECF6A32 = int(min(_id_46D8B39844967CAE.size / 2, level._id_0104CEC67C308610._id_BDB5F3EA99833FB7));

  for(;;) {
    _id_5B1C81A103054032 = _id_46C4B996C16825A7(_id_5B1C81A103054032, _id_22B5FF4E379DDEEC);
    _id_3849E1290EC01D21 = _id_46C4B996C16825A7(_id_3849E1290EC01D21, _id_22B5FF4E379DDEEC);
    _id_46D8B39844967CAE = _id_46C4B996C16825A7(_id_5B1C81A103054032, _id_6E12F3619ECF6A32);
    level waittill("quest_tablets_refill");
  }
}

_id_46C4B996C16825A7(_id_8210215681A02FDE, _id_82366A3747665984) {
  _id_7AA965DD9A0ECB41 = [];
  _id_5103BC8AADF9AF64 = int(_id_82366A3747665984);
  _id_8210215681A02FDE = scripts\engine\utility::array_randomize(_id_8210215681A02FDE);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8210215681A02FDE.size; _id_AC0E594AC96AA3A8++) {
    if(_id_5103BC8AADF9AF64 > 0) {
      tablet = _id_8210215681A02FDE[_id_AC0E594AC96AA3A8];
      tablet _id_3ACF1C0EBAF602F2::tabletshow();
      _id_5103BC8AADF9AF64--;
      continue;
    }

    _id_7AA965DD9A0ECB41[_id_7AA965DD9A0ECB41.size] = _id_8210215681A02FDE[_id_AC0E594AC96AA3A8];
  }

  return _id_7AA965DD9A0ECB41;
}

calculatebrbonusxp(_id_DDC181B24748057B) {
  _id_81719A5F68CB8A36 = int(scripts\mp\utility\game::gettimepassed() / 1000);
  _id_D99039F33BA6D872 = scripts\mp\utility\game::gettimelimit();
  _id_5E048D3944CA96FC = int(level._id_0104CEC67C308610._id_B486C7577277E222 * (_id_81719A5F68CB8A36 / 60));
  _id_761080F3B8BA099A = _id_81719A5F68CB8A36 / _id_D99039F33BA6D872;
  _id_659BB30A96449958 = level._id_0104CEC67C308610._id_F10850FEE51041C1;

  if(isDefined(_id_DDC181B24748057B) && _id_DDC181B24748057B == 1)
    _id_659BB30A96449958 = level._id_0104CEC67C308610._id_02B8025758DCDF88;

  _id_659BB30A96449958 = int(_id_659BB30A96449958 * _id_761080F3B8BA099A);
  _id_7EE746D32095CD92 = _id_5E048D3944CA96FC + _id_659BB30A96449958;
  return [_id_7EE746D32095CD92, _id_5E048D3944CA96FC, _id_659BB30A96449958];
}

_id_B6CFEF2BF78FE1B3() {
  scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outline_depth_rumble", "level_script");
}

_id_47E6AFB49EFD70B2() {
  level endon("game_ended");
  _id_CD1F27176EF055DF = 0;
  _id_AD68044650DAD1EB = 0;
  _id_3AE218B1295D9BDD = getdvarint("scr_br_scorelimit");

  for(;;) {
    _id_29EF4A118BCFAD22 = int(game["teamScores"]["allies"]);
    _id_69592884DAA8A8EA = _id_29EF4A118BCFAD22 / _id_3AE218B1295D9BDD;
    _id_E967B0B8834FCF29 = int(game["teamScores"]["axis"]);
    _id_015A8C43B47EE4F3 = _id_E967B0B8834FCF29 / _id_3AE218B1295D9BDD;

    if(!_id_CD1F27176EF055DF) {
      if(_id_69592884DAA8A8EA > 0.5 && _id_015A8C43B47EE4F3 > 0.5) {
        _id_CD1F27176EF055DF = 1;
        level thread _id_454D8050131F3CFF("tie", 50);
      } else if(_id_69592884DAA8A8EA > 0.5) {
        _id_CD1F27176EF055DF = 1;
        level thread _id_454D8050131F3CFF("allies", 50);
      } else if(_id_015A8C43B47EE4F3 > 0.5) {
        _id_CD1F27176EF055DF = 1;
        level thread _id_454D8050131F3CFF("axis", 50);
      }
    } else if(!_id_AD68044650DAD1EB) {
      if(_id_69592884DAA8A8EA > 0.9 && _id_015A8C43B47EE4F3 > 0.9) {
        _id_AD68044650DAD1EB = 1;
        level thread _id_454D8050131F3CFF("tie", 90);
      } else if(_id_69592884DAA8A8EA > 0.9) {
        _id_AD68044650DAD1EB = 1;
        level thread _id_454D8050131F3CFF("allies", 90);
      } else if(_id_015A8C43B47EE4F3 > 0.9) {
        _id_AD68044650DAD1EB = 1;
        level thread _id_454D8050131F3CFF("axis", 90);
      }
    }

    waitframe();
  }
}

_id_454D8050131F3CFF(team, _id_3D3865076DA46CCA) {
  _id_5EDF5F85D668150B = undefined;
  _id_A2AD62717DAA97EE = undefined;

  switch (team) {
    case "tie":
      _id_5EDF5F85D668150B = "score_friendly_";
      _id_A2AD62717DAA97EE = "score_friendly_";
      break;
    case "allies":
      _id_5EDF5F85D668150B = "score_friendly_";
      _id_A2AD62717DAA97EE = "score_enemy_";
      break;
    case "axis":
      _id_5EDF5F85D668150B = "score_enemy_";
      _id_A2AD62717DAA97EE = "score_friendly_";
      break;
  }

  _id_5EDF5F85D668150B = _id_5EDF5F85D668150B + _id_3D3865076DA46CCA + "_percent";
  _id_A2AD62717DAA97EE = _id_A2AD62717DAA97EE + _id_3D3865076DA46CCA + "_percent";
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_5EDF5F85D668150B, "allies");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam(_id_A2AD62717DAA97EE, "axis");
}

_id_3BFE3FB3E7FE088F() {
  level endon("game_ended");
  level._id_0104CEC67C308610._id_E8DA1788059FDA4E = 0;
  level._id_0104CEC67C308610._id_3AB7F7397E02802D = 0;

  for(;;) {
    level waittill("assassination_quest_completed", team, squadindex);

    if(team == "axis")
      level._id_0104CEC67C308610._id_E8DA1788059FDA4E++;
    else
      level._id_0104CEC67C308610._id_3AB7F7397E02802D++;

    level scripts\mp\gamescore::giveteamscoreforobjective(team, level._id_0104CEC67C308610._id_A46E3C2E09BCCE8A, 0);
  }
}

_id_E6F6246810DFF59F() {
  _id_36AA9AFF81971A6B = _id_E79352484226A63C(self._id_B7792A6A967C1B9D);

  if(self.type == "br_loot_cache_lege")
    _id_7BD83AA11DDAB79F = getdvarint("dvar_80B0A66853A69D70", 100);
  else
    _id_7BD83AA11DDAB79F = getdvarint("dvar_70111A99EC5843C6", 33);

  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_BDFAA377C23D036A(dropstruct, _id_7BD83AA11DDAB79F, _id_36AA9AFF81971A6B);
}

_id_E79352484226A63C(player) {
  if(!level._id_0104CEC67C308610._id_210EAD19055C18E0) {
    return;
  }
  stats = spawnStruct();
  _id_ADA2DD872EAF6E88 = _id_F18DAB4DC8B0230D();
  _id_0AA81B2C7E0A29A1 = _id_ADA2DD872EAF6E88._id_FAB0AEE81AC7F28F;
  _id_C3389291727181AE = _id_ADA2DD872EAF6E88._id_8922494828E4CDCA;
  stats._id_DCEE39EFDDF5C0DC = player.team != _id_0AA81B2C7E0A29A1 && _id_C3389291727181AE >= 50;

  if(stats._id_DCEE39EFDDF5C0DC) {
    stats._id_6E0E0AC07B93DF77 = -1;
    tiers = [50, 75, 100];
    _id_6C4B53E2E53467BA = [45, 55, 62];

    foreach(_id_AC0E594AC96AA3A8, threshold in tiers) {
      if(_id_C3389291727181AE >= threshold) {
        stats._id_6E0E0AC07B93DF77 = tiers.size - _id_AC0E594AC96AA3A8;
        stats._id_20E2B8E015A904A4 = _id_6C4B53E2E53467BA[_id_AC0E594AC96AA3A8];
      }
    }
  }

  return stats;
}

_id_65C35EB1566A42BC() {
  if(getdvarint("dvar_075E3107239C004C", 0)) {
    return;
  }
  _id_EC15CE3E7A9D1D86 = "tie";
  _id_EC15CE3E7A9D1D86 = scripts\mp\gamescore::gethighestscoringteam();
  _id_1C1DEE64DF9A9C2E = scripts\engine\utility::get_enemy_team(_id_EC15CE3E7A9D1D86);
  logstring("[KEY_MOMENT] time limit, win: " + _id_EC15CE3E7A9D1D86);
  thread _id_1E4A61DB11011446::brendgame(_id_EC15CE3E7A9D1D86, game["end_reason"]["time_limit_reached"], 0);
}

endgame(winner, _id_F0500919D8C387B9, _id_04C15A6F75CC4A6D) {
  _id_1E4A61DB11011446::brendgame(winner, _id_F0500919D8C387B9, 0);
}

_id_099E535CAC0AD68B(winner) {}

_id_2FD05C170B1FF244(winner) {
  if(isDefined(level.br_ending_delay))
    wait(level.br_ending_delay - 0.5);
}

_id_504238C900093E09(_id_037E0FE1F4E33613, _id_F0500919D8C387B9) {
  _id_1C1DEE64DF9A9C2E = scripts\engine\utility::ter_op(_id_037E0FE1F4E33613 == "axis", "allies", "axis");
  level thread _id_8ECDDF2BE0080C4B();
  level thread _id_4D2A7FA941B254D2(_id_037E0FE1F4E33613, _id_1C1DEE64DF9A9C2E);
  level thread _id_A09977E3F4697F9E(_id_037E0FE1F4E33613, _id_F0500919D8C387B9);
  wait(level.br_ending_delay - 0.5);
}

_id_A09977E3F4697F9E(_id_037E0FE1F4E33613, _id_F0500919D8C387B9) {
  foreach(player in level.players)
  player thread _id_1E4A61DB11011446::_id_4E187BEA631FB06A(_id_F0500919D8C387B9);

  level thread _id_1E4A61DB11011446::handleendgamesplash(_id_037E0FE1F4E33613);
  level thread _id_1E4A61DB11011446::handleendgamespectatingsplash(_id_037E0FE1F4E33613);

  if(istrue(level.shownonspectatingwinnersplash))
    level thread _id_1E4A61DB11011446::handleendgamenonwinnersplash(_id_037E0FE1F4E33613);
}

_id_4D2A7FA941B254D2(_id_037E0FE1F4E33613, _id_1C1DEE64DF9A9C2E) {
  wait 1;

  if(_id_037E0FE1F4E33613 == "tie")
    level thread _id_2CEDCC356F1B9FC8::brleaderdialog("mission_draw", 0, undefined, 1);
  else {
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("score_friendly_win", _id_037E0FE1F4E33613);
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("score_enemy_win", _id_1C1DEE64DF9A9C2E);
  }
}

_id_8ECDDF2BE0080C4B() {
  _id_8C52D6B43EF599D2 = level._id_0104CEC67C308610._id_E8DA1788059FDA4E;
  _id_44BB89567F147219 = level._id_0104CEC67C308610._id_3AB7F7397E02802D;

  if(isDefined(level._id_0104CEC67C308610._id_C49B1D649A8D9C34))
    [[level._id_0104CEC67C308610._id_C49B1D649A8D9C34]](_id_8C52D6B43EF599D2, _id_44BB89567F147219, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_957163D1155464E2);

  _id_A0FF08200C2D1BAD = game["teamScores"]["axis"];
  _id_E19CF53A2B0BC17E = game["teamScores"]["allies"];

  if(isDefined(level._id_0104CEC67C308610._id_2833A507B388532E))
    [[level._id_0104CEC67C308610._id_2833A507B388532E]](_id_A0FF08200C2D1BAD, _id_E19CF53A2B0BC17E, level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_957163D1155464E2);
}

dangercircletick(_id_819EDACDACB810E4, _id_52D59C928EB97C81) {
  foreach(vehicle in level._id_0104CEC67C308610.spawned_vehicles) {
    if(!_id_2695A20D4011076D::ispointincurrentsafecircle(vehicle.origin)) {
      _id_4724784E2530A13F = vehicle.maxhealth * 0.15;
      vehicle dodamage(_id_4724784E2530A13F, vehicle.origin);
    }
  }
}

_id_BED77F67B7D4EDA3(_id_683D84459AF3AC51) {
  level endon("game_ended");
  wait 3.0;
  _id_C7984FD0CA0CFD9A = getdvarint("dvar_63DC612F846E16B8", 4400);
  _id_A4DC66CB0097EA97 = getdvarint("dvar_6D32CFB719B1ABB9", 5000);
  _id_068773A0E5605CBF = getdvarint("dvar_F19B5B8DC694B233", 500);
  _id_C32664F42208BF44 = getdvarint("dvar_22723CAF85B4EE22", -1000);
  _id_70384E1BB74CB3FC = scripts\engine\utility::drop_to_ground(self.origin) + vectorNormalize(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector[_id_683D84459AF3AC51]) * _id_068773A0E5605CBF;
  _id_70384E1BB74CB3FC = _id_70384E1BB74CB3FC + (0, 0, _id_C32664F42208BF44);
  _id_598DB1A531E84411 = spawn("trigger_radius", _id_70384E1BB74CB3FC, 0, _id_C7984FD0CA0CFD9A, _id_A4DC66CB0097EA97);
  _id_598DB1A531E84411._id_FABF84450735DD93 = _id_683D84459AF3AC51;
  _id_598DB1A531E84411 scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Camp_Detection_Rumble", _id_70384E1BB74CB3FC, _id_C7984FD0CA0CFD9A);

  for(;;) {
    _id_598DB1A531E84411 waittill("trigger", _id_B25B5C45202C880C);

    if(istrue(_id_B25B5C45202C880C._id_AC902DA8D5271412) || !isPlayer(_id_B25B5C45202C880C) && !isagent(_id_B25B5C45202C880C) || _id_B25B5C45202C880C.team == _id_683D84459AF3AC51) {
      continue;
    }
    _id_B25B5C45202C880C thread _id_88BB72DA1C35191E(_id_598DB1A531E84411);
    wait 0.25;
  }
}

_id_88BB72DA1C35191E(_id_0751FA7EDE77B8FC) {
  self endon("disconnect");
  self._id_AC902DA8D5271412 = 1;
  self setperk("specialty_radarblip", 1);
  thread _id_6D68CFDF0836123C::_id_D16011CEDF620DC6();
  _id_0751FA7EDE77B8FC scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);

  while(self istouching(_id_0751FA7EDE77B8FC) && isalive(self)) {
    thread _id_6D68CFDF0836123C::_id_FA08D1D78CF5CB01();
    self waittill("markedUIUpdate");
    waitframe();
  }

  _id_0751FA7EDE77B8FC scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(self);
  self._id_AC902DA8D5271412 = undefined;
  self unsetperk("specialty_radarblip", 1);
}

_id_814FEE984765974E(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(part == "body")
    instance._id_B7792A6A967C1B9D = player;

  if(instance.type == "br_reusable_loot_cache") {
    _id_09B1D310E4A262C7 = 150;
    instance thread _id_892734374DE579F8(instance.origin, _id_09B1D310E4A262C7);
  }
}

_id_892734374DE579F8(position, radius) {
  level endon("game_ended");
  self notify("util_remove_scriptables_nearby");
  self endon("util_remove_scriptables_nearby");
  _id_EF04566DBEA411D3 = 1000;
  wait(getdvarint("dvar_FD0C403FEE9DC217", 90));

  foreach(player in level.players) {
    if(distance(player.origin, self.origin) < _id_EF04566DBEA411D3)
      return;
  }

  _id_567AF94E76A084D2 = getlootscriptablearrayinradius(undefined, undefined, position, radius);
  _id_567AF94E76A084D2 = scripts\engine\utility::array_remove(_id_567AF94E76A084D2, self);

  foreach(scriptable in _id_567AF94E76A084D2) {
    if(!issubstr(scriptable.type, "brloot_")) {
      continue;
    }
    if(scriptable getscriptableisreserved()) {
      scriptable freescriptable();
      continue;
    }

    _id_1080D6BB12D6A0D6 = scriptable _meth_EC5F4851431F3382();
    scriptable setscriptablepartstate(_id_1080D6BB12D6A0D6, "hidden", 1);
  }
}

_id_F18DAB4DC8B0230D() {
  _id_ADA2DD872EAF6E88 = spawnStruct();
  _id_ADA2DD872EAF6E88._id_F273AF799FA32E84 = int(game["teamScores"]["axis"]);
  _id_ADA2DD872EAF6E88._id_6AF6DB02A6C81E2F = int(game["teamScores"]["allies"]);
  _id_ADA2DD872EAF6E88._id_8922494828E4CDCA = abs(_id_ADA2DD872EAF6E88._id_F273AF799FA32E84 - _id_ADA2DD872EAF6E88._id_6AF6DB02A6C81E2F);
  _id_FAB0AEE81AC7F28F = scripts\engine\utility::ter_op(_id_ADA2DD872EAF6E88._id_F273AF799FA32E84 > _id_ADA2DD872EAF6E88._id_6AF6DB02A6C81E2F, "axis", "allies");

  if(_id_ADA2DD872EAF6E88._id_F273AF799FA32E84 == _id_ADA2DD872EAF6E88._id_6AF6DB02A6C81E2F)
    _id_FAB0AEE81AC7F28F = "contested";

  _id_ADA2DD872EAF6E88._id_FAB0AEE81AC7F28F = _id_FAB0AEE81AC7F28F;
  return _id_ADA2DD872EAF6E88;
}

_id_7BCC0B40D1921628() {
  _id_3C590D0EE220B409 = level.mapcorners[0].origin[0];
  _id_C978C90E8E5AB1F7 = level.mapcorners[1].origin[0];
  _id_4CB56D024C774848 = _id_C978C90E8E5AB1F7 - _id_3C590D0EE220B409;
  _id_3C590C0EE220B1D6 = level.mapcorners[0].origin[1];
  _id_C978C80E8E5AAFC4 = level.mapcorners[1].origin[1];
  _id_4CB56E024C774A7B = _id_C978C80E8E5AAFC4 - _id_3C590C0EE220B1D6;

  if(!isDefined(_id_4CB56D024C774848) || !isDefined(_id_4CB56D024C774848)) {
    return;
  }
  _id_81954D580B24281B = (level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013[0] - _id_3C590D0EE220B409) / _id_4CB56D024C774848;
  _id_E4F34F3A01C6FFF2 = (level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013[1] - _id_3C590C0EE220B1D6) / _id_4CB56E024C774A7B;
  setDvar("compassTacmapFixedCenterX", _id_81954D580B24281B);
  setDvar("compassTacmapFixedCenterY", _id_E4F34F3A01C6FFF2);

  if(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_957163D1155464E2 == "island_airfield" || level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_957163D1155464E2 == "island_peak")
    setDvar("compassTacmapFixedMinZoomLevel", 0.3);
  else
    setDvar("compassTacmapFixedMinZoomLevel", 0.23);
}

_id_649CE261B7A00593() {}

_id_A350BFD2C433F946() {
  level._id_0104CEC67C308610._id_5956A6C954276A19 = [];
  _id_36BCC1E84D2A5F78 = [];
  _id_36BCC1E84D2A5F78["nothing"] = getdvarfloat("dvar_6D211C136E85EB04", 5);
  _id_36BCC1E84D2A5F78["brloot_plunder_cash_uncommon_1"] = getdvarfloat("dvar_17EC85BA089996B0", 10);
  _id_36BCC1E84D2A5F78["brloot_plunder_cash_uncommon_2"] = getdvarfloat("dvar_17EC88BA08999D49", 5);
  _id_36BCC1E84D2A5F78["brloot_plunder_cash_uncommon_3"] = getdvarfloat("dvar_17EC87BA08999B16", 2);
  _id_36BCC1E84D2A5F78["brloot_plunder_cash_rare_1"] = getdvarfloat("dvar_C7A7BEE1D94FAC96", 0.5);
  _id_A5E4738B5770B964(_id_36BCC1E84D2A5F78, "loot_table_dom_flag_capture_cash");
  _id_36BCC1E84D2A5F78 = [];
  _id_36BCC1E84D2A5F78["nothing"] = getdvarfloat("dvar_17E01650C9A9366F", 2);
  _id_36BCC1E84D2A5F78["brloot_killstreak_clusterstrike_mgl"] = getdvarfloat("dvar_2AB0A4878DD91F79", 2);
  _id_36BCC1E84D2A5F78["brloot_weapon_la_mike32_epic"] = getdvarfloat("dvar_D2ABE86029060E36", 2);
  _id_36BCC1E84D2A5F78["brloot_weapon_lm_slima_lege"] = getdvarfloat("dvar_170C1535AD4C138A", 1);
  _id_A5E4738B5770B964(_id_36BCC1E84D2A5F78, "loot_table_dom_flag_capture_weapons");
  _id_36BCC1E84D2A5F78 = [];
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_double_points"] = getdvarfloat("dvar_B1A1F27010B6EBEB", 2.2);
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_killmonger"] = getdvarfloat("dvar_0346CB68C361F47F", 1);
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_speed_boost"] = getdvarfloat("dvar_A4DB8FB37E4A701A", 1);
  _id_A5E4738B5770B964(_id_36BCC1E84D2A5F78, "loot_table_random_powerup_favor_2x");
  _id_6D7971E13B2E3B2A::init();
  _id_36BCC1E84D2A5F78 = [];
  _id_36BCC1E84D2A5F78["brloot_plunder_cash_epic_1"] = getdvarfloat("dvar_6E85AAAA0FC55405", 1);
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_killmonger"] = getdvarfloat("dvar_676133F8B89185A0", 1);
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_speed_boost"] = getdvarfloat("dvar_D81DFA2D41030673", 1);
  _id_36BCC1E84D2A5F78["brloot_rumble_powerup_double_points"] = getdvarfloat("dvar_FE40E4FA8300FF52", 1);
  _id_36BCC1E84D2A5F78["brloot_weapon_la_mike32_lege"] = getdvarfloat("dvar_E6C1FB257A748991", 2);

  if(getdvarint("dvar_75B3B0355430AF7B", 1) == 1)
    _id_36BCC1E84D2A5F78["brloot_super_nova_rounds"] = getdvarfloat("dvar_BAFF04DD037383BB", 1.5);

  _id_6D7971E13B2E3B2A::_id_8CD7F4939FAD286D("bonus_points_crate", _id_36BCC1E84D2A5F78);
}

_id_1F6021714CD0AF21(_id_B67D18CAC8627E8C) {
  if(!isDefined(_id_B67D18CAC8627E8C)) {
    return;
  }
  _id_36BCC1E84D2A5F78 = level._id_0104CEC67C308610._id_5956A6C954276A19[_id_B67D18CAC8627E8C];
  _id_3B9EE963911A96C0 = randomfloat(1.0);

  foreach(key, _id_F90358454413407F in _id_36BCC1E84D2A5F78) {
    _id_F35B93A944C13DE8 = _id_F90358454413407F[2];
    _id_02B4EF98997BE493 = _id_F90358454413407F[3];

    if(_id_3B9EE963911A96C0 >= _id_F35B93A944C13DE8 && _id_3B9EE963911A96C0 <= _id_02B4EF98997BE493)
      return key;
  }
}

_id_C38578F093C16790(position, _id_B67D18CAC8627E8C, _id_F7C5216EC1C7191A) {
  playFX(scripts\engine\utility::getfx("vfx_golden_loot_explosion_flare"), position);
  _id_A381B6D2C46A74B8 = spawnStruct();
  _id_A381B6D2C46A74B8.origin = position;
  _id_A381B6D2C46A74B8.angles = (0, 0, randomfloatrange(0.0, 180.0));
  _id_A381B6D2C46A74B8.dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_A381B6D2C46A74B8.dropstruct.dropcount = scripts\engine\utility::ter_op(_id_F7C5216EC1C7191A == 1, 6 + randomintrange(1, 10), 6);
  _id_A381B6D2C46A74B8.dropstruct._id_C718FF19DD627C68 = 0;
  _id_36BCC1E84D2A5F78 = level._id_0104CEC67C308610._id_5956A6C954276A19[_id_B67D18CAC8627E8C];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F7C5216EC1C7191A; _id_AC0E594AC96AA3A8++) {
    _id_3B9EE963911A96C0 = randomfloat(1.0);

    foreach(key, _id_F90358454413407F in _id_36BCC1E84D2A5F78) {
      _id_F35B93A944C13DE8 = _id_F90358454413407F[2];
      _id_02B4EF98997BE493 = _id_F90358454413407F[3];

      if(_id_3B9EE963911A96C0 >= _id_F35B93A944C13DE8 && _id_3B9EE963911A96C0 <= _id_02B4EF98997BE493) {
        _id_1B276F35DD9E0AEA = key;

        if(_id_1B276F35DD9E0AEA == "nothing") {
          continue;
        }
        switch (_id_B67D18CAC8627E8C) {
          case "loot_table_dom_flag_capture_cash":
            _id_A381B6D2C46A74B8.dropstruct.dropcount = _id_A381B6D2C46A74B8.dropstruct.dropcount + 2;
            break;
        }

        thread _id_B370C028CB478783(_id_1B276F35DD9E0AEA, _id_A381B6D2C46A74B8);
        _id_A381B6D2C46A74B8.dropstruct.dropcount = _id_A381B6D2C46A74B8.dropstruct.dropcount + 2;
        waitframe();
      }
    }
  }
}

_id_B370C028CB478783(_id_14208702A0228189, _id_A381B6D2C46A74B8) {
  if(!isDefined(_id_14208702A0228189)) {
    return;
  }
  _id_A381B6D2C46A74B8.legendary = 0;

  if(issubstr(_id_14208702A0228189, "lege")) {
    _id_96F6E3F46DB47B54 = randomintrange(5, 40);
    _id_A381B6D2C46A74B8.dropstruct.dropcount = _id_96F6E3F46DB47B54;
    _id_A381B6D2C46A74B8.legendary = 1;
  }

  spawn_origin = _id_A381B6D2C46A74B8.origin + (0, 0, _id_A381B6D2C46A74B8.dropstruct._id_C718FF19DD627C68);
  _id_63354ED1D936777B = _id_552B8E4EA5FF7DF1::lootspawnitem(_id_14208702A0228189, _id_A381B6D2C46A74B8.dropstruct, spawn_origin, _id_A381B6D2C46A74B8.angles, 0, _id_A381B6D2C46A74B8.legendary, 0);
  _id_A381B6D2C46A74B8.dropstruct._id_C718FF19DD627C68 = _id_A381B6D2C46A74B8.dropstruct._id_C718FF19DD627C68 + 15;
}

_id_0382208ADFA0847C(position) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  dropstruct.origin = position;
  dropstruct.angles = (0, 0, randomfloatrange(0.0, 180.0));
  dropstruct.dropcount = randomintrange(1, 10);
  dropstruct._id_C718FF19DD627C68 = randomintrange(1, 10);
  return dropstruct;
}

_id_A5E4738B5770B964(_id_36BCC1E84D2A5F78, _id_CCF10DEF4015E022) {
  _id_7F076C6B7A5EF5B3 = [];
  _id_7A3C33A815C53CA3 = 0;

  foreach(value in _id_36BCC1E84D2A5F78)
  _id_7A3C33A815C53CA3 = _id_7A3C33A815C53CA3 + value;

  index = 0;
  _id_B67D18CAC8627E8C = getarraykeys(_id_36BCC1E84D2A5F78);
  _id_800802AF73FA0898 = undefined;

  foreach(key, value in _id_36BCC1E84D2A5F78) {
    _id_7F076C6B7A5EF5B3[key] = [];
    _id_716C638075C3B64E = value / _id_7A3C33A815C53CA3;

    if(index == 0) {
      _id_BDE41274F0D07563 = 0;
      _id_B57BE88BB1F41A6E = _id_716C638075C3B64E;
    } else {
      _id_BDE41274F0D07563 = _id_800802AF73FA0898[3];
      _id_B57BE88BB1F41A6E = _id_BDE41274F0D07563 + _id_716C638075C3B64E;
    }

    _id_7F076C6B7A5EF5B3[key] = [value, _id_716C638075C3B64E, _id_BDE41274F0D07563, _id_B57BE88BB1F41A6E];
    _id_800802AF73FA0898 = _id_7F076C6B7A5EF5B3[key];
    index++;
  }

  level._id_0104CEC67C308610._id_5956A6C954276A19[_id_CCF10DEF4015E022] = _id_7F076C6B7A5EF5B3;
}

_id_BDFAA377C23D036A(dropstruct, _id_302E82DA1A1989AD, _id_DFF6DA4BA7945503) {
  if(!isDefined(_id_302E82DA1A1989AD))
    _id_302E82DA1A1989AD = 100;

  _id_7AD2FA4AB913AE0E = randomintrange(1, 101);
  _id_7F9AB5CBB4C8D107 = undefined;
  _id_E89A9A6A3475BD0A = undefined;

  if(istrue(_id_DFF6DA4BA7945503._id_DCEE39EFDDF5C0DC)) {
    if(_id_DFF6DA4BA7945503._id_20E2B8E015A904A4 < _id_7AD2FA4AB913AE0E) {
      return;
    }
    _id_E89A9A6A3475BD0A = _id_1F6021714CD0AF21("loot_table_random_powerup_favor_2x");
  } else {
    if(_id_302E82DA1A1989AD < _id_7AD2FA4AB913AE0E) {
      return;
    }
    _id_7F9AB5CBB4C8D107 = _id_7FEAED3F883FE324::_id_8BFE6434CFCD9099();
    _id_E89A9A6A3475BD0A = "brloot_rumble_powerup_" + _id_7F9AB5CBB4C8D107;
  }

  if(!isent(self) || self isscriptable()) {
    _id_D0E9CE5529FD7B88 = 35;
    _id_CC0BEC21143E13D8 = 75;
    _id_CC0BEC21143E13D8 = _id_CC0BEC21143E13D8 + randomfloatrange(-10, 10);
    _id_0F289334BAA6FC79 = _id_D0E9CE5529FD7B88 + 55 + randomfloatrange(-5, 5);
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, undefined, _id_CC0BEC21143E13D8, _id_0F289334BAA6FC79);
  } else
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);

  _id_7E52B56769FA7774::spawnpickup(_id_E89A9A6A3475BD0A, _id_CB4FAD49263E20C4, 1, 1);
}

cantakepickup(pickup) {
  result = 0;

  if(_id_7E52B56769FA7774::isquesttablet(pickup.scriptablename)) {
    if(!isDefined(level.questinfo._id_05AFA170B3886678))
      level.questinfo._id_05AFA170B3886678 = [];

    _id_9CF0B8C1BE24C64D = scripts\engine\utility::array_contains(level.questinfo._id_05AFA170B3886678, self._id_0FF97225579DE16A);

    if(!_id_9CF0B8C1BE24C64D)
      result = 1;
  }

  return result;
}

_id_0993CF3E6C87FE83() {}

_id_A3D1311AEB840D52() {
  _id_7D3CF95BDBCA0939 = "any";
  origin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + vectorNormalize(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["axis"]) * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0, "icon_small_medium");
  marker.origin = origin;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_mgl_friendly");
  objective_state(marker.objidnum, "active");
  marker.lockupdatingicons = 1;
  marker.team = "axis";
  level._id_2DAF0F726F89D5E7._id_0F5149EBDE25AD12 = marker;
  level._id_2DAF0F726F89D5E7._id_0F5149EBDE25AD12 thread _id_8DD33FD44C6786FB();
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0, "icon_small_medium");
  marker.origin = origin;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_mgl_enemy");
  objective_state(marker.objidnum, "active");
  marker.lockupdatingicons = 1;
  marker.team = "axis";
  level._id_2DAF0F726F89D5E7._id_3AE360368E82E29E = marker;
  level._id_2DAF0F726F89D5E7._id_3AE360368E82E29E thread _id_8DD33FD44C6786FB();
  level._id_2DAF0F726F89D5E7._id_3AE360368E82E29E thread _id_BED77F67B7D4EDA3("axis");
  origin = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013 + vectorNormalize(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnvector["allies"]) * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius * level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawndistancemin;
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0, "icon_small_medium");
  marker.origin = origin;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_mgl_friendly");
  objective_state(marker.objidnum, "active");
  marker.lockupdatingicons = 1;
  marker.team = "allies";
  level._id_2DAF0F726F89D5E7._id_055718C03B891B09 = marker;
  level._id_2DAF0F726F89D5E7._id_055718C03B891B09 thread _id_8DD33FD44C6786FB();
  marker = scripts\mp\gameobjects::createobjidobject(origin, "neutral", (0, 0, 0), undefined, _id_7D3CF95BDBCA0939, 0, "icon_small_medium");
  marker.origin = origin;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(marker.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(marker.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(marker.objidnum, 0);
  marker.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(marker.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(marker.objidnum, "icon_waypoint_hq_mgl_enemy");
  objective_state(marker.objidnum, "active");
  marker.lockupdatingicons = 1;
  marker.team = "allies";
  level._id_2DAF0F726F89D5E7._id_11D367C1020BF073 = marker;
  level._id_2DAF0F726F89D5E7._id_11D367C1020BF073 thread _id_8DD33FD44C6786FB();
  level._id_2DAF0F726F89D5E7._id_11D367C1020BF073 thread _id_BED77F67B7D4EDA3("allies");
  scripts\mp\flags::gameflagset("rumble_ui_hq_objectives_init_finish");
}

_id_8DD33FD44C6786FB() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("rumble_location_selected");
  _id_949D9008FC020806 = scripts\engine\utility::ter_op(self.team == "axis", level._id_2DAF0F726F89D5E7._id_D4F5D4C39467C80C, level._id_2DAF0F726F89D5E7._id_C7ACF699B8F275E7);

  if(!isDefined(_id_949D9008FC020806)) {
    return;
  }
  self.origin = _id_949D9008FC020806;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, _id_949D9008FC020806);
}

_id_90024CAC0C9C5F6D() {
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("rumble_ui_hq_objectives_init_finish");

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_2DAF0F726F89D5E7._id_055718C03B891B09.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_2DAF0F726F89D5E7._id_3AE360368E82E29E.objidnum, self);
  } else {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_2DAF0F726F89D5E7._id_11D367C1020BF073.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level._id_2DAF0F726F89D5E7._id_0F5149EBDE25AD12.objidnum, self);
  }
}

_id_794FC0B829B8026F(_id_E2055BF088954E86) {
  _id_3C263CB6A98D4161 = ["Combat", "Wander"];
  _id_4E5142FAE72C8061 = _id_4A941421347FF7DF::_id_72C9DC29C073EF29();

  switch (_id_E2055BF088954E86) {
    case "babysitter":
    case "default":
      return _id_3C263CB6A98D4161;
    case "sniper":
      return scripts\engine\utility::array_combine(_id_3C263CB6A98D4161, _id_4E5142FAE72C8061);
    default:
      return undefined;
  }
}

_id_90AA80A0D854DD5D() {
  if(!isDefined(level._id_21397777593F3132)) {
    level._id_21397777593F3132 = spawnStruct();
    _id_2780B1A6E44F11A0 = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["allies"];
    _id_16F22C33F4D4D6DB = level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.spawnorigin["axis"];
    level._id_21397777593F3132._id_D6EA465F335FEC7D = _func_767CEA82B001F645(_id_2780B1A6E44F11A0 - _id_16F22C33F4D4D6DB);
    level._id_21397777593F3132.center = (_id_2780B1A6E44F11A0 - _id_16F22C33F4D4D6DB) * 0.5 + _id_16F22C33F4D4D6DB;
    level._id_21397777593F3132._id_5349E6096AD92B88 = (level._id_21397777593F3132._id_D6EA465F335FEC7D[1], -1 * level._id_21397777593F3132._id_D6EA465F335FEC7D[0], 0);
    level._id_21397777593F3132.halfwidth = (level._id_0104CEC67C308610._id_E5B4C6599E6DFABC.circle_radius - distance2d(level._id_0104CEC67C308610._id_E5B4C6599E6DFABC._id_A64F9929D18C1013, level._id_21397777593F3132.center)) * 0.7;
    level._id_21397777593F3132._id_F3EE471DD145DAA5 = level._id_21397777593F3132.halfwidth * 0.4;
    _id_D00B7279A07AD589 = 0.6;
    level._id_21397777593F3132._id_8FC0374C89C76990 = level._id_21397777593F3132._id_D6EA465F335FEC7D * level._id_21397777593F3132._id_F3EE471DD145DAA5 * _id_D00B7279A07AD589;
    level._id_21397777593F3132._id_6E9E44DB04CEFBB3 = level._id_21397777593F3132._id_D6EA465F335FEC7D * -1 * level._id_21397777593F3132._id_F3EE471DD145DAA5 * _id_D00B7279A07AD589;
  }

  _id_332BFCF7ECA6F520 = level._id_21397777593F3132.center + (randomfloat(2) - 1) * level._id_21397777593F3132.halfwidth * level._id_21397777593F3132._id_5349E6096AD92B88 + (randomfloat(2) - 1) * level._id_21397777593F3132._id_F3EE471DD145DAA5 * level._id_21397777593F3132._id_D6EA465F335FEC7D;

  if(self.team == "allies")
    _id_332BFCF7ECA6F520 = _id_332BFCF7ECA6F520 + level._id_21397777593F3132._id_8FC0374C89C76990;
  else
    _id_332BFCF7ECA6F520 = _id_332BFCF7ECA6F520 + level._id_21397777593F3132._id_6E9E44DB04CEFBB3;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  _id_332BFCF7ECA6F520 = scripts\engine\utility::drop_to_ground((_id_332BFCF7ECA6F520[0], _id_332BFCF7ECA6F520[1], 4000), undefined, undefined, undefined, contents);
  _id_332BFCF7ECA6F520 = _id_59FF79D681BB860C::_id_207BA502560FA1D2(_id_332BFCF7ECA6F520);
  return _id_332BFCF7ECA6F520;
}