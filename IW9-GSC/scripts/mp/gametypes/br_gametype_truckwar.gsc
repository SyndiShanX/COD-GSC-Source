/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_truckwar.gsc
*********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "truckwar") {
    return;
  }
  init();
}

init() {
  scripts\cp_mp\vehicles\vehicle::_id_66AB4FB2175555E1("veh9_mil_lnd_mrap");
  level thread brtruck_initfeatures();
  level thread brtruck_initpostmain();
  level thread brtruck_initdialog();
  level thread brtruck_initexternalfeatures();
  level.respawntimedisable = getdvarint("dvar_E12689CC1F69A798", 0);
  level._id_4B3D0771DF2C44A9 = 0;
  level._id_45496C9DF00F2BD4 = 1;
  level._id_AF6EC941D2B4E283 = getdvarint("dvar_FAD98DA2F37E7FCF", 1) == 1;
  level._id_E12122C5431959B5 = getdvarint("dvar_0BC6DEBD70E4D4F9", 1) == 1;
  level._id_944B40A215902330 = 15;
  _id_AE79928DC9519C10 = getDvar("dvar_8FA9E9DB3F08ED0C", "80000 50000 40000 30000 20000 15000 10000 0");

  if(_id_AE79928DC9519C10 != "") {
    level._id_5A41C5287237C308 = [];
    _id_ED059B813D0A9274 = strtok(_id_AE79928DC9519C10, " ");

    foreach(_id_A61C75B156FC1EE0 in _id_ED059B813D0A9274)
    level._id_5A41C5287237C308[level._id_5A41C5287237C308.size] = float(_id_A61C75B156FC1EE0);
  }

  _id_3DE8C20BA880C90E = getDvar("dvar_A957DB23CA8FAB2A", "330 120 100 90 80 70 60 50");

  if(_id_3DE8C20BA880C90E != "") {
    level._id_3D86F613DC0BFA16 = [];
    _id_52903C0C13091421 = strtok(_id_3DE8C20BA880C90E, " ");

    foreach(_id_A61C75B156FC1EE0 in _id_52903C0C13091421)
    level._id_3D86F613DC0BFA16[level._id_3D86F613DC0BFA16.size] = float(_id_A61C75B156FC1EE0);
  }

  _id_58FE32902D17047D = getDvar("dvar_61AE4AC51FF20D99", "120 120 90 75 60 45 30 20");

  if(_id_58FE32902D17047D != "") {
    level._id_DC008290077A7185 = [];
    _id_4C462DE43E6A8ED0 = strtok(_id_58FE32902D17047D, " ");

    foreach(_id_A61C75B156FC1EE0 in _id_4C462DE43E6A8ED0)
    level._id_DC008290077A7185[level._id_DC008290077A7185.size] = float(_id_A61C75B156FC1EE0);
  }

  level._id_59FF09549058DDA2 = 1;
  level._id_5431E3914CFC0E23 = 1;
  level._id_0A9CCAF325F3A76D = getdvarint("dvar_E1A4B7A04F5A3725", 1) == 1;
  level._id_A02389E5D5497129 = getdvarfloat("dvar_0952460A08702C65", 50000);
  level._id_8FC109DF2D334CDA = getdvarfloat("dvar_6940EE2D192FF206", 40000);
  level._id_463ABA47317CACC2 = getdvarfloat("dvar_4B8F9A9113C965F6", 10000);
  level._id_886566E69EE53D98 = getdvarfloat("dvar_C06D40315E54BC8C", 30);
  level._id_E182232B582AA5D6 = getdvarfloat("dvar_085028CD7A792B52", 220);
  level._id_411CE67DC4849722 = getdvarfloat("dvar_C9183F48BB5DC926", 40);
  level._id_F28E1ED7F6ADF52D = getdvarfloat("dvar_3863B34660BF0D09", 60);
  level._id_84F1C23ED82E4EC5 = getdvarfloat("dvar_B7628DB816399549", 10);
  level._id_4D77D157099CF459 = getdvarfloat("dvar_941583466B9CCB2D", 10);
  level._id_BE52F2D0DEE6B894 = getdvarint("dvar_D4939FDB84B794F0", 1);
  level._id_15415172069D735F = getdvarfloat("dvar_620BA5611E3D420B", 120);
  level._id_837CD01DC6486D8C = getdvarfloat("dvar_92B3C04BD3014008", 330);
  level._id_6D02A364E8331928 = getdvarfloat("dvar_F56E42C98F9F52BC", 1);

  if(level._id_AF6EC941D2B4E283) {
    setDvar("scr_br_moving_circle_enabled", 1);
    level.br_circle_init_func = ::alternatebrcircle;
  }

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("tag_buystation", ::_id_FE081D074870C23D);
  level init_airdrop_anims();
  level thread _id_A614E0FEE13ECA53();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::_id_C21D160BC19FC200);
}

brtruck_initfeatures() {
  if(getdvarint("dvar_32B7F75982043672", 0) == 1) {
    _id_362C58E8BB39BCDA::disablefeature("circle");
    _id_362C58E8BB39BCDA::disablefeature("dropbag");
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");
  }

  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("vehicleSpawns");
  _id_362C58E8BB39BCDA::disablefeature("c130PlaneLine");
  _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
}

brtruck_initpostmain() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::brtruck_playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onStartGameType", ::onstartgametype);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::playerkilledspawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("markPlayerAsEliminatedOnKilled", ::markplayeraseliminatedonkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("mayConsiderPlayerDead", ::mayconsiderplayerdead);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isTeamEliminated", ::isteameliminated);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("infilSequence", ::_id_73BDF8B18E29B13F);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerNakedDropLoadout", ::_id_8D45FF943DE1CFC4);
  waittillframeend;
  _id_A5E20D193142774D();

  if(!isDefined(level.br_badcircleareas))
    level.br_badcircleareas = [];

  if(issubstr(level.mapname, "saba")) {
    level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea((67000, -40000, 0), 30000);
    level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea((-3500, -47300, 0), 20000);
    level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea((-42000, -64500, 0), 20000);
    level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea((-39500, -31000, 0), 22000);
    level.br_badcircleareas[level.br_badcircleareas.size] = _id_2695A20D4011076D::createinvalidcirclearea((-49000, -8200, 0), 21000);
  }

  scripts\mp\flags::gameflaginit("use_truck_respawn", 0);
  level.ontimelimit = ::brtruck_ontimelimit;
  level.modeplayerkilledspawn = ::playerkilledspawn;
  brtruck_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level.startjuggdelivery = 0;

  if(!isDefined(level._id_C7B9749BCC6A6207))
    level._id_C7B9749BCC6A6207 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh9_mil_lnd_mrap")._id_29F1EA79ED2B40DD;

  if(level._id_AF6EC941D2B4E283)
    level thread _id_D4864F0577158363();
}

_id_A5E20D193142774D() {
  _id_70DA934903AC5A5D("classtable:classtable_br_resurgence");
  _id_70DA934903AC5A5D("classtable:classtable_br_resurgence_circle2");
  _id_70DA934903AC5A5D("classtable:classtable_br_resurgence_circle3");
}

_id_70DA934903AC5A5D(table) {
  if(!isDefined(level._id_C04B5EDF3F9EA340))
    level._id_C04B5EDF3F9EA340 = [];

  _id_A78225C464121E51 = level._id_C04B5EDF3F9EA340.size;
  _id_07D958726E11B327 = scripts\mp\class::_id_DF2933F96D726D71(table);
  level._id_C04B5EDF3F9EA340[_id_A78225C464121E51] = [];

  for(_id_089688461C79EF11 = 0; _id_089688461C79EF11 < _id_07D958726E11B327; _id_089688461C79EF11++)
    level._id_C04B5EDF3F9EA340[_id_A78225C464121E51][level._id_C04B5EDF3F9EA340[_id_A78225C464121E51].size] = _id_A89B0EF8D36B3436(_id_089688461C79EF11, table);

  level._id_77C121D31E587BA8 = [];

  foreach(circleindex, _id_1A9E152363126A93 in level._id_C04B5EDF3F9EA340) {
    if(isDefined(level._id_C04B5EDF3F9EA340[circleindex]) && level._id_C04B5EDF3F9EA340[circleindex].size > 0)
      level._id_77C121D31E587BA8[circleindex] = randomintrange(0, level._id_C04B5EDF3F9EA340[circleindex].size);
  }
}

_id_A89B0EF8D36B3436(_id_089688461C79EF11, table) {
  _id_CFA6985254954FB3 = scripts\mp\class::_id_0C7A0B640C398497(table, _id_089688461C79EF11);
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = _id_CFA6985254954FB3.primaryweapon.weapon;
  loadout["loadoutPrimaryAttachment"] = _id_CFA6985254954FB3.primaryweapon._id_59F68715C04CE28F;
  loadout["loadoutPrimaryAttachment2"] = _id_CFA6985254954FB3.primaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutPrimaryAttachment3"] = _id_CFA6985254954FB3.primaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutPrimaryAttachment4"] = _id_CFA6985254954FB3.primaryweapon._id_59F68215C04CD790;
  loadout["loadoutPrimaryAttachment5"] = _id_CFA6985254954FB3.primaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutPrimaryCamo"] = _id_CFA6985254954FB3.primaryweapon.camo;
  loadout["loadoutPrimaryReticle"] = _id_CFA6985254954FB3.primaryweapon.reticle;
  loadout["loadoutSecondary"] = _id_CFA6985254954FB3.secondaryweapon.weapon;
  loadout["loadoutSecondaryAttachment"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68715C04CE28F;
  loadout["loadoutSecondaryAttachment2"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68815C04CE4C2;
  loadout["loadoutSecondaryAttachment3"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68915C04CE6F5;
  loadout["loadoutSecondaryAttachment4"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68215C04CD790;
  loadout["loadoutSecondaryAttachment5"] = _id_CFA6985254954FB3.secondaryweapon._id_59F68315C04CD9C3;
  loadout["loadoutSecondaryCamo"] = _id_CFA6985254954FB3.secondaryweapon.camo;
  loadout["loadoutSecondaryReticle"] = _id_CFA6985254954FB3.secondaryweapon.reticle;
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = _id_CFA6985254954FB3.equipment.primary;
  loadout["loadoutEquipmentSecondary"] = _id_CFA6985254954FB3.equipment._id_D7B9856A19F9B6B5;
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = [_id_CFA6985254954FB3.perks._id_16680ABD1742C050, _id_CFA6985254954FB3.perks._id_16680DBD1742C6E9, _id_CFA6985254954FB3.perks._id_16680CBD1742C4B6, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680ABD1742C050, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680DBD1742C6E9, _id_CFA6985254954FB3._id_50D0559DCBA571E2._id_16680CBD1742C4B6];
  loadout["loadoutGesture"] = "playerData";
  loadout["tableColumn"] = _id_089688461C79EF11;
  return loadout;
}

brtruck_initdialog() {
  level endon("game_ended");
  game["dialog"]["match_start"] = "trkw_wzan_mdnt";
  game["dialog"]["primary_objective"] = "trkw_wzan_mdbs";
  game["dialog"]["vehicle_spawn_enabled"] = "trkw_wzan_vsnb";
  game["dialog"]["vehicle_spawn_disabled"] = "trkw_wzan_vsds";
  game["dialog"]["vehicle_under_attack"] = "trkw_wzan_vndt";
  game["dialog"]["vehicle_destroyed"] = "trkw_wzan_vhcd";
  game["dialog"]["vehicle_spawn_over"] = "trkw_wzan_vsvr";
  game["dialog"]["armor_upgraded"] = "trkw_wzan_armr";
  game["dialog"]["trophy_activated"] = "trkw_wzan_trph";
  game["dialog"]["uav_activated"] = "trkw_wzan_uav0";
  game["dialog"]["barrel_activated"] = "trkw_wzan_brrl";
  game["dialog"]["grenade_turret_activated"] = "trkw_wzan_trrt";
  game["dialog"]["engine_activated"] = "trkw_wzan_engn";
  game["dialog"]["smoke_activated"] = "trkw_wzan_smke";
  game["dialog"]["reminder_purchase"] = "trkw_wzan_rmdp";
  game["dialog"]["resurgence_on_player_disconnect"] = "rsrg_wzan_tadj";
}

brtruck_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

brtruck_initexternalfeatures() {
  level._effect["light_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

onstartgametype() {
  initspawns();
  level thread initvehicles();
  level thread _id_8D947898C35B8068();
  level thread _id_6E7B6151ABA26DC2();
}

brtruck_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");

  if(!istrue(self.pers["streamSyncComplete"]))
    self waittill("player_active");

  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_truckwar_prematch_welcome");
  self waittill("do_welcome_splashes");
  wait 2;
  soundalias = _id_2CEDCC356F1B9FC8::_id_93550B34F0A49DD9("match_start", self, "dx_br_bds5_");
  _id_1499E7C2D69E0074 = undefined;

  if(isDefined(soundalias) && soundexists(soundalias))
    _id_1499E7C2D69E0074 = lookupsoundlength(soundalias) * 0.001 + 2.0;

  thread _id_9F5606E3BD1C508D("match_start", [self]);
  thread _id_9F5606E3BD1C508D("primary_objective", [self], _id_1499E7C2D69E0074);
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("truckwar_welcome", [self]);

  while(!self isonground())
    waitframe();

  _id_715028F54BAD19A1::branalytics_landing(self);
}

brtruck_ontimelimit() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

mayconsiderplayerdead(player) {
  return 1;
}

markplayeraseliminatedonkilled() {
  return 1;
}

vehiclespawn_getspawndata(loc) {
  spawndata = spawnStruct();
  spawndata.origin = loc.origin;
  spawndata.angles = loc.angles;
  spawndata.spawntype = "GAME_MODE";
  spawndata.showheadicon = 1;
  return spawndata;
}

registervehicletype(refname, _id_E4015CFE956F4F3F) {
  vehicleinfo = spawnStruct();
  vehicleinfo.refname = refname;
  vehicleinfo.spawncallback = _id_E4015CFE956F4F3F;
  vehicleinfo.vehiclespawns = scripts\cp_mp\vehicles\vehicle_spawn::_id_B08E7E3A0B14F76F(refname);
  level.vehicleinfo[refname] = vehicleinfo;
}

_id_5C3211A52B3B56F9(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  spawndata._id_427538F5A2AD4F8B = 1;
  spawndata._id_EC76FFDBE2F37C5B = 1;
  spawndata._id_065DA0A245B653CC = 1;
  spawndata._id_D04816FE2F5BCEE6 = 1;
  _id_EFB5620DEEAD5E9B = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_lnd_mrap", spawndata, _id_EE8DA5624236DC89);
  _id_EFB5620DEEAD5E9B setscriptablepartstate("tag_buystation", "buystation_usable");
  return _id_EFB5620DEEAD5E9B;
}

vehiclespawn_littlebird(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("little_bird", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_atv(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("atv", spawndata, _id_EE8DA5624236DC89);
}

vehiclespawn_tacrover(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata, _id_EE8DA5624236DC89);
}

_id_C43C5200D882B134(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_utv", spawndata, _id_EE8DA5624236DC89);
}

_id_C6436C7F3E995D85(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_hummer", spawndata, _id_EE8DA5624236DC89);
}

_id_9D7D93DEF34D9958(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_overland_2016", spawndata, _id_EE8DA5624236DC89);
}

_id_292BAE242D3583B7(loc, _id_EE8DA5624236DC89) {
  if(!isDefined(loc.angles))
    loc.angles = (0, randomfloat(360), 0);

  spawndata = vehiclespawn_getspawndata(loc);
  return scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_civ_lnd_dirt_bike", spawndata, _id_EE8DA5624236DC89);
}

initvehicles() {
  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "veh9_mil_lnd_mrap"), 1) == 1)
    registervehicletype("veh9_mil_lnd_mrap", ::_id_5C3211A52B3B56F9);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "little_bird"), 1) == 1)
    registervehicletype("little_bird", ::vehiclespawn_littlebird);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "atv"), 1) == 1)
    registervehicletype("atv", ::vehiclespawn_atv);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "tac_rover"), 1) == 1)
    registervehicletype("tac_rover", ::vehiclespawn_tacrover);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "veh9_utv"), 1) == 1)
    registervehicletype("veh9_utv", ::_id_C43C5200D882B134);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "veh9_hummer"), 1) == 1)
    registervehicletype("veh9_hummer", ::_id_C6436C7F3E995D85);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "veh9_overland_2016"), 1) == 1)
    registervehicletype("veh9_overland_2016", ::_id_9D7D93DEF34D9958);

  if(getdvarint(_func_2EF675C13CA1C4AF("dvar_E4FA5E1677F011E4", "veh9_civ_lnd_dirt_bike"), 1) == 1)
    registervehicletype("veh9_civ_lnd_dirt_bike", ::_id_292BAE242D3583B7);

  level waittill("prematch_fade_done");
  wait 2.0;
}

_id_9E97F797DC8E211C() {
  level.vehiclespawnlocs = [];
  level._id_8D137603BD840E40 = [];

  foreach(vehicleinfo in level.vehicleinfo) {
    switch (vehicleinfo.refname) {
      case "veh9_mil_lnd_mrap":
        vehicleinfo.vehiclespawns = gettruckspawns("veh9_mil_lnd_mrap");
        break;
    }

    foreach(spawnpoint in vehicleinfo.vehiclespawns) {
      index = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[index] = spawnpoint;
      level.vehiclespawnlocs[index].refname = vehicleinfo.refname;
    }
  }

  if(0) {
    foreach(loc in level.vehiclespawnlocs) {
      if(loc.refname != "veh9_mil_lnd_mrap") {
        continue;
      }
      thread scripts\mp\utility\debug::drawline(loc.origin, loc.origin + (0, 0, 1500), 1000, (1, 0, 0));
      thread scripts\mp\utility\debug::drawangles(loc.origin, loc.angles, 1000, 100);
    }
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);

  if(0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.vehiclespawnlocs.size; _id_AC0E594AC96AA3A8++) {
      loc = level.vehiclespawnlocs[_id_AC0E594AC96AA3A8];

      if(loc.refname != "veh9_mil_lnd_mrap") {
        continue;
      }
      thread scripts\mp\utility\debug::drawline(loc.origin + (0, 0, 1500), loc.origin + (0, 0, 2500), 1000, (0, 1, 0));
      thread scripts\mp\utility\debug::drawangles(loc.origin, loc.angles, 1000, 100);
    }
  }

  _id_ED58EDB716C4A6C3 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players").size == 0) {
      continue;
    }
    while(_id_ED58EDB716C4A6C3 < level.vehiclespawnlocs.size) {
      loc = level.vehiclespawnlocs[_id_ED58EDB716C4A6C3];

      if(isDefined(loc)) {
        if(loc.refname == "veh9_mil_lnd_mrap") {
          level._id_8D137603BD840E40[_id_F90358454413407F] = loc;
          _id_ED58EDB716C4A6C3++;
          break;
        }
      }

      _id_ED58EDB716C4A6C3++;
    }
  }

  scripts\mp\flags::gameflagset("trucks_spawn_complete");
}

spawnvehicles() {
  vehicles = [];

  foreach(team, loc in level._id_8D137603BD840E40) {
    vehicleinfo = level.vehicleinfo[loc.refname];
    vehicle = [[vehicleinfo.spawncallback]](loc);
    vehicles[vehicles.size] = vehicle;
  }

  level.teamvehicles = vehicles;
  maxvehiclecount = getdvarint("dvar_58C9645BC2B9D636", 120);
  _id_95D1B9EDAE469D81 = maxvehiclecount - vehicles.size;

  for(index = 0; index < level.vehiclespawnlocs.size && _id_95D1B9EDAE469D81 > 0; index++) {
    loc = level.vehiclespawnlocs[index];

    if(isDefined(loc)) {
      if(loc.refname != "veh9_mil_lnd_mrap") {
        vehicleinfo = level.vehicleinfo[loc.refname];
        vehicle = [[vehicleinfo.spawncallback]](loc);
        _id_95D1B9EDAE469D81--;
      }
    }
  }
}

assignvehiclestoteams() {
  vehicles = level.teamvehicles;
  level.teamvehicles = [];
  level.teamcanrespawn = [];
  level._id_E3CCF0898A949BEC = [];
  index = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players").size == 0) {
      continue;
    }
    vehicle = vehicles[index];
    _id_020B77FBF1AF1A5D(vehicle, _id_F90358454413407F);
    index++;
  }
}

_id_020B77FBF1AF1A5D(vehicle, team, _id_E751C7771E6A1E5C) {
  if(!isDefined(team)) {
    return;
  }
  level.teamvehicles[team] = vehicle;
  level.teamcanrespawn[team] = 1;
  setomnvar("ui_truckwar_trucks_remaining", level.teamvehicles.size);
  level thread watchvehicleingas(vehicle, team);
  level thread _id_66E49BF742FCCB61(vehicle, team);
  level thread _id_3E5A0635A240EDE5(vehicle, team);
  level thread notifyteamonvehicledeath(vehicle, team);
  level thread _id_46ED8B0B237087F8(vehicle, team);
  level thread _id_AD382245D8D861F3(vehicle, team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, team);
  vehicle setscriptablepartstate("objective", "on");
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);

    if(istrue(_id_E751C7771E6A1E5C) && getdvarint("dvar_051DF9C2CA5EE638", 1) == 1 && !istrue(level._id_24380DB31E302A78)) {
      if(istrue(player.br_iseliminated)) {
        player.setspawnpoint = undefined;
        player thread playerrespawn(1);
      }
    }
  }

  _id_5FD118F91AE96E57(vehicle);
  _id_256806BCFDF38C83(team);
}

watchvehicleingas(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle._id_A8C0F140C771864F = 0;
  vehicle._id_08636E467BA2CE9A = 0;
  vehicle._id_5D74AE3615FF1BBA = 0;
  _id_42EEC56BE1C18A86 = getdvarfloat("dvar_6E9602ADCD53F742", 15.0);
  _id_57D36501A55EB4D9 = getdvarfloat("dvar_88FAD367B10FC4CD", 30.0);
  _id_18DFC5318AA3C007 = getdvarfloat("dvar_593518C70A322693", 45.0);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player scripts\engine\utility::ent_flag_init("respawn_vehicle_in_gas");

  while(isDefined(vehicle)) {
    if(istrue(vehicle._id_FB98158AABA0AE49)) {
      waitframe();
      continue;
    }

    if(istrue(level.circleclosing)) {
      if(!vehicle._id_A8C0F140C771864F && _id_875871597AB85666(vehicle.origin, _id_42EEC56BE1C18A86)) {
        showsplashtoteam(team, "truckwar_gas_close");
        vehicle._id_A8C0F140C771864F = 1;
        vehicle._id_08636E467BA2CE9A = 1;
        vehicle._id_5D74AE3615FF1BBA = 1;
      } else if(!vehicle._id_08636E467BA2CE9A && _id_875871597AB85666(vehicle.origin, _id_57D36501A55EB4D9)) {
        showsplashtoteam(team, "truckwar_gas_medium");
        vehicle._id_08636E467BA2CE9A = 1;
        vehicle._id_5D74AE3615FF1BBA = 1;
      } else if(!vehicle._id_5D74AE3615FF1BBA && _id_875871597AB85666(vehicle.origin, _id_18DFC5318AA3C007)) {
        showsplashtoteam(team, "truckwar_gas_far");
        vehicle._id_5D74AE3615FF1BBA = 1;
      }
    } else {
      vehicle._id_A8C0F140C771864F = 0;
      vehicle._id_08636E467BA2CE9A = 0;
      vehicle._id_5D74AE3615FF1BBA = 0;
    }

    _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
    _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();
    _id_0DCDCEA34083B6B8 = getdvarint("dvar_54E04086872E7D2C", 0) == 1;

    if(_id_0DCDCEA34083B6B8 || distance2dsquared(_id_819EDACDACB810E4, vehicle.origin) > _id_E86632D645C137D0 * _id_E86632D645C137D0) {
      vehicle thread _id_6C35D65FC1F38EB8();

      if(level.teamcanrespawn[team] == 1) {
        level.teamcanrespawn[team] = 0;
        players = scripts\mp\utility\teams::getteamdata(team, "players");

        foreach(player in players)
        player scripts\engine\utility::ent_flag_set("respawn_vehicle_in_gas");

        showsplashtoteam(team, "truckwar_vehicle_spawn_disabled");
        thread _id_9F5606E3BD1C508D("vehicle_spawn_disabled", level.teamdata[team]["players"]);
        level thread[[level.updategameevents]]();
      }
    } else if(level.teamcanrespawn[team] == 0) {
      vehicle notify("vehicle_gas_exit");
      vehicle._id_C2B8326EF7ABCAE6 = 0;
      level.teamcanrespawn[team] = 1;
      players = scripts\mp\utility\teams::getteamdata(team, "players");

      foreach(player in players)
      player scripts\engine\utility::ent_flag_clear("respawn_vehicle_in_gas");

      showsplashtoteam(team, "truckwar_vehicle_spawn_enabled");
      thread _id_9F5606E3BD1C508D("vehicle_spawn_enabled", level.teamdata[team]["players"]);
      level thread[[level.updategameevents]]();
    }

    waitframe();
  }
}

_id_6C35D65FC1F38EB8() {
  self endon("death");
  self endon("vehicle_gas_exit");

  if(istrue(self._id_C2B8326EF7ABCAE6)) {
    return;
  }
  self._id_C2B8326EF7ABCAE6 = 1;
  _id_796DBBB5B21A7303 = getdvarfloat("dvar_A705A5CAA6EA4DAF", 0.05);
  _id_C4C191BEFB977DB0 = self.maxhealth * _id_796DBBB5B21A7303;

  while(isDefined(self)) {
    wait 1.0;
    self dodamage(_id_C4C191BEFB977DB0, self.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  }
}

_id_66E49BF742FCCB61(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  vehicle._id_35A334482F930BE6 = 0;
  _id_EC4AD047DE451525 = getdvarfloat("dvar_38E9F472CCA85346", 15.0);
  _id_B36B64992D102A16 = getdvarfloat("dvar_32657FE607D73D8C", 5.0);
  _id_9B92432ED202E143 = vehicle.isempty;
  _id_3D655108468FA202 = 0;
  _id_58E94F4FCB19BD9B = undefined;

  for(;;) {
    if(!_id_9B92432ED202E143 && vehicle.isempty)
      _id_58E94F4FCB19BD9B = gettime() + _id_EC4AD047DE451525 * 1000;

    _id_9B92432ED202E143 = vehicle.isempty;

    if(isDefined(_id_58E94F4FCB19BD9B) && gettime() < _id_58E94F4FCB19BD9B || _id_3D655108468FA202) {
      isoob = 0;
      inflictor = undefined;

      foreach(trigger in level.outofboundstriggers) {
        if(vehicle istouching(trigger)) {
          vehicle._id_35A334482F930BE6 = vehicle._id_35A334482F930BE6 + level.framedurationseconds;
          isoob = 1;
          inflictor = trigger;
          break;
        }
      }

      _id_3D655108468FA202 = isoob;

      if(!isoob)
        vehicle._id_35A334482F930BE6 = vehicle._id_35A334482F930BE6 - level.framedurationseconds;

      vehicle._id_35A334482F930BE6 = clamp(vehicle._id_35A334482F930BE6, 0, _id_B36B64992D102A16);

      if(vehicle._id_35A334482F930BE6 == _id_B36B64992D102A16)
        vehicle dodamage(999999, vehicle.origin, inflictor, inflictor, "MOD_TRIGGER_HURT");
    }

    waitframe();
  }
}

_id_3E5A0635A240EDE5(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");
  _id_5CC086A792B04FCE = getdvarfloat("dvar_DEF42F45937BE461", 15.0) * 1000;
  lastplayedtime = undefined;

  while(isDefined(vehicle)) {
    vehicle waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);
    vehicle.lastdamagedtime = gettime();
    _id_256806BCFDF38C83(team);
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", vehicle.health);
      player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", vehicle.maxhealth);
    }

    if(smeansofdeath == "MOD_TRIGGER_HURT" || isDefined(eattacker) && eattacker.classname == "worldspawn") {
      continue;
    }
    if(isDefined(lastplayedtime) && lastplayedtime + _id_5CC086A792B04FCE > gettime()) {
      continue;
    }
    lastplayedtime = gettime();
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    showsplashtoteam(team, "truckwar_vehicle_under_attack");
    thread _id_9F5606E3BD1C508D("vehicle_under_attack", level.teamdata[team]["players"]);
  }
}

_id_888A901C55A0C460(team) {
  self endon("death");
  self notify("blockHealing");
  self endon("blockHealing");
  self._id_A2DA885FCC826D37 = 1;
  _id_256806BCFDF38C83(team);
  _id_5CC086A792B04FCE = getdvarfloat("dvar_AA27DEA6D1C24CA3", 15.0);
  wait(_id_5CC086A792B04FCE);
  self._id_A2DA885FCC826D37 = 0;
  _id_256806BCFDF38C83(team);
}

_id_46ED8B0B237087F8(vehicle, team) {
  vehicle endon("death");
  level endon("game_ended");

  while(isDefined(vehicle)) {
    vehicle waittill("upgrade_message", message);

    if(message != "trophy_ammo_used") {
      _id_F7B6CC6C062A7A43 = _id_E50C00059892A159(message);
      showsplashtoteam(team, _id_F7B6CC6C062A7A43);
      thread _id_9F5606E3BD1C508D(message, level.teamdata[team]["players"]);

      foreach(player in level.teamdata[team]["players"]) {
        if(isDefined(player.br_kiosk) && player.br_kiosk._id_114E759371623080) {
          _id_15B89FF206500554 = player.br_kiosk;
          _id_6B3C6B40C0598D85 = player _id_4384ABBF498DF6A7::_id_B88D64CD67BBE60F(_id_15B89FF206500554);
          player setclientomnvar("ui_buystation_limited_item_amount", _id_6B3C6B40C0598D85);
        }
      }
    }

    _id_256806BCFDF38C83(team);
  }
}

_id_AD382245D8D861F3(vehicle, team) {
  level endon("game_ended");
  vehicle endon("death");
  vehicle endon("give_upgrade");
  wait 60;

  foreach(player in level.teamdata[team]["players"])
  player _id_21C19CFC7139D773::_id_1976438A8865AC27("br_ftue_truckwar_upgrade");
}

_id_E50C00059892A159(message) {
  switch (message) {
    case "armor_upgraded":
      return "truckwar_vehicle_armor_upgraded";
    case "trophy_activated":
      return "truckwar_vehicle_trophy_upgraded";
    case "uav_activated":
      return "truckwar_vehicle_portable_radar_upgraded";
    case "barrel_activated":
      return "truckwar_vehicle_barrel_upgraded";
    case "trophy_no_ammo":
      return "truckwar_vehicle_trophy_no_ammo";
    case "trophy_ammo_refill":
      return "truckwar_vehicle_trophy_refilled";
    case "grenade_turret_activated":
      return "truckwar_vehicle_turret_upgraded";
    case "smoke_activated":
      return "truckwar_vehicle_smoke_upgraded";
    case "engine_activated":
      return "truckwar_vehicle_engine_upgraded";
  }
}

notifyteamonvehicledeath(vehicle, team) {
  level endon("game_ended");
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players)
  player scripts\engine\utility::ent_flag_init("respawn_vehicle_death");

  vehicle waittill("death");
  level.teamcanrespawn[team] = 0;
  level.teamvehicles[team] = undefined;
  setomnvar("ui_truckwar_trucks_remaining", level.teamvehicles.size);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", 0);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", 1);
    player scripts\engine\utility::ent_flag_set("respawn_vehicle_death");
  }

  showsplashtoteam(team, "truckwar_vehicle_destroyed");
  thread _id_9F5606E3BD1C508D("vehicle_destroyed", level.teamdata[team]["players"]);
  thread _id_BC2CB59695039E19(team);
  level thread[[level.updategameevents]]();
  _id_256806BCFDF38C83(team);
}

_id_BC2CB59695039E19(team) {
  level endon("game_ended");

  for(;;) {
    waittime = randomfloatrange(180, 300);
    wait(waittime);

    if(istrue(level.teamcanrespawn[team])) {
      break;
    }

    thread _id_9F5606E3BD1C508D("reminder_purchase", level.teamdata[team]["players"]);
  }
}

gettruckspawns(_id_7731ADEF63E19B0C) {
  if(level.mapname != "mp_br_mechanics" && getdvarint("dvar_692B4B274D3B7BDC", 0) == 0) {
    _id_29D9D2428185616D = getpresettruckspawns(_id_7731ADEF63E19B0C);

    if(isDefined(_id_29D9D2428185616D) && _id_29D9D2428185616D.size > 0)
      return _id_29D9D2428185616D;
  }

  _id_0EB62FAD9344BDA2 = level.teamnamelist.size;
  _id_F806489200F3B88B = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "players").size > 0)
      _id_F806489200F3B88B++;
  }

  _id_0EB62FAD9344BDA2 = _id_F806489200F3B88B;
  _id_C0FD4E75A105DEAE = 360 / _id_0EB62FAD9344BDA2;
  circlecenter = (0, 0, 100);

  if(level.mapname == "mp_br_mechanics") {
    circlecenter = (0, 0, 100);
    _id_73562BF0DDC8B02D = 9000;
  } else {
    circlecenter = (0, 0, 100);
    _id_73562BF0DDC8B02D = 40000;
  }

  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_29D9D2428185616D = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EB62FAD9344BDA2; _id_AC0E594AC96AA3A8++) {
    angles = _id_AC0E594AC96AA3A8 * _id_C0FD4E75A105DEAE;
    forward = anglesToForward((0, angles, 0));
    origin = circlecenter + forward * _id_73562BF0DDC8B02D;
    groundorigin = scripts\engine\utility::drop_to_ground(origin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
    origin = (origin[0], origin[1], groundorigin[2] + 200);
    vehicle = spawnStruct();
    vehicle.origin = origin;
    _id_7224BACAB3F8EE26 = (0, 0, 0);
    vehicle.angles = vectortoangles(forward * -1);
    vehicle.targetname = _id_7731ADEF63E19B0C;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
  }

  return _id_29D9D2428185616D;
}

getpresettruckspawns(_id_7731ADEF63E19B0C) {
  _id_A36AA7AE98DA9C1F = [];
  _id_A36AA7AE98DA9C1F = scripts\engine\utility::getStructArray("mp_truckwar_team_start_spawn", "targetname");

  if(_id_A36AA7AE98DA9C1F.size == 0)
    return undefined;

  _id_A36AA7AE98DA9C1F = scripts\engine\utility::array_randomize(_id_A36AA7AE98DA9C1F);
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  _id_20ACB030A0BF7A84 = 0;

  foreach(struct in _id_A36AA7AE98DA9C1F) {
    groundorigin = scripts\engine\utility::drop_to_ground(struct.origin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
    origin = (struct.origin[0], struct.origin[1], struct.origin[2] + 200);
    struct.origin = origin;
    _id_20ACB030A0BF7A84++;

    if(_id_20ACB030A0BF7A84 >= 5) {
      _id_20ACB030A0BF7A84 = 0;
      waitframe();
    }
  }

  _id_29D9D2428185616D = [];
  _id_0EB62FAD9344BDA2 = _id_A36AA7AE98DA9C1F.size;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EB62FAD9344BDA2; _id_AC0E594AC96AA3A8++) {
    vehicle = spawnStruct();
    vehicle.origin = _id_A36AA7AE98DA9C1F[_id_AC0E594AC96AA3A8].origin;
    vehicle.angles = _id_A36AA7AE98DA9C1F[_id_AC0E594AC96AA3A8].angles;
    vehicle.targetname = _id_7731ADEF63E19B0C;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
  }

  return _id_29D9D2428185616D;
}

gethelispawns(_id_7731ADEF63E19B0C) {
  _id_29D9D2428185616D = [];
  _id_0EB62FAD9344BDA2 = 3;
  _id_C0FD4E75A105DEAE = 360 / _id_0EB62FAD9344BDA2;
  circlecenter = (0, 0, 100);
  _id_73562BF0DDC8B02D = 1000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_0EB62FAD9344BDA2; _id_AC0E594AC96AA3A8++) {
    angles = _id_AC0E594AC96AA3A8 * _id_C0FD4E75A105DEAE;
    forward = anglesToForward((0, angles, 0));
    origin = circlecenter + forward * _id_73562BF0DDC8B02D;
    vehicle = spawnStruct();
    vehicle.origin = origin;
    _id_7224BACAB3F8EE26 = (0, 0, 0);
    vehicle.angles = vectortoangles(forward * -1);
    vehicle.targetname = _id_7731ADEF63E19B0C;
    _id_29D9D2428185616D[_id_29D9D2428185616D.size] = vehicle;
  }

  return _id_29D9D2428185616D;
}

isteameliminated(team) {
  if(!isDefined(level.teamcanrespawn))
    return 0;

  return scripts\mp\utility\teams::getteamdata(team, "aliveCount") == 0 && (!istrue(level.teamcanrespawn[team]) || istrue(level._id_24380DB31E302A78));
}

playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(!scripts\mp\flags::gameflag("use_truck_respawn"))
    return 0;

  _id_642470E1ABC1BBF9.victim thread playerrespawn(0, _id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);
  _id_642470E1ABC1BBF9.victim thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);
  return 1;
}

playerrespawn(_id_5A1633A0A398BEE1, _id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("gulag_auto_win");
  self notify("playerRespawn");
  self endon("playerRespawn");

  if(istrue(level.gameended)) {
    return;
  }
  if(istrue(level._id_24380DB31E302A78) || isteameliminated(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread _id_6489FCDFE6FA2E36::triggereliminatedoverlay();
    return;
  }

  if(getdvarint("dvar_1560ECA11FD78307", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  _id_30839284ADD41CED = _id_CC3F506623DAF71D(self);

  if(istrue(_id_5A1633A0A398BEE1))
    _id_30839284ADD41CED = 0;

  _id_AC5CF023CA77DB21 = getdvarint("dvar_0DE56EB4B8051C0E", 5);

  if(_id_30839284ADD41CED < _id_AC5CF023CA77DB21)
    _id_30839284ADD41CED = _id_AC5CF023CA77DB21;

  if(level.respawntimedisable != 0)
    _id_30839284ADD41CED = 0;

  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  _id_A294C35CBB452CBF = _id_30839284ADD41CED - _id_AC5CF023CA77DB21;
  _id_D2F5422694822652 = _id_30839284ADD41CED - _id_A294C35CBB452CBF;
  _id_C445F6D6BC71ED85 = _id_30839284ADD41CED - getdvarint("dvar_3AE7661F87C2CF43", 5);

  if(_id_30839284ADD41CED > 0) {
    _id_B6B4285E173DD004(self);
    thread _id_74AE749DB3ACB35E(self, _id_30839284ADD41CED);
  }

  result = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", _id_A294C35CBB452CBF);

  if(result != "respawn_vehicle_death") {
    thread updateprestreamrespawn();
    result = scripts\engine\utility::waittill_notify_or_timeout_return("respawn_vehicle_death", _id_D2F5422694822652);
  }

  self notify("stop_updatePrestreamRespawn");
  thread fadeoutin();
  _id_218D7F561BC41A41(self);
  wait 0.5;

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death"))
    thread _id_6489FCDFE6FA2E36::setbuybackpingmessage();
  else if(scripts\engine\utility::ent_flag("respawn_vehicle_in_gas"))
    scripts\mp\utility\lower_message::setlowermessageomnvar("vehicle_in_gas");

  while(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && !scripts\engine\utility::ent_flag("respawn_vehicle_death") && !level.teamcanrespawn[self.team] || scripts\cp_mp\utility\player_utility::isusingremote())
    waitframe();

  if(scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death"))
    thread _id_6489FCDFE6FA2E36::setbuybackpingmessage();

  if(isteameliminated(self.team) || scripts\engine\utility::ent_flag_exist("respawn_vehicle_death") && scripts\engine\utility::ent_flag("respawn_vehicle_death")) {
    thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);
    thread _id_6489FCDFE6FA2E36::triggereliminatedoverlay();
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
    _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
    return;
  }

  spawnpoint = getspawnpoint();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  flareorigin = level.teamvehicles[self.team].origin;

  if(getdvarint("scr_skip_respawn_gate", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.cachedomnars = [];
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();
  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1, undefined, 0, 0, 1);
  spawnangles = vectortoangles(flareorigin - _id_11F3B4465C8B637B);
  self setplayerangles(spawnangles);
  self notify("respawn_view_set");
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "player_respawn");

  if(isDefined(level.teamvehicles[self.team])) {
    flareorigin = level.teamvehicles[self.team].origin;
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", level.teamvehicles[self.team].health);
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", level.teamvehicles[self.team].maxhealth);
  }

  level thread _id_3ACF1C0EBAF602F2::utilflare_shootflare(flareorigin, "revive");
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
  _id_256806BCFDF38C83(self.team);
}

_id_64E94E8B1E610263() {
  level.brgametype.respawndelay["_solos"][0] = getdvarint("dvar_BC01B0A06D2DBDE9", 15);
  level.brgametype.respawndelay["_solos"][1] = getdvarint("dvar_BC01ADA06D2DB750", 20);
  level.brgametype.respawndelay["_solos"][2] = getdvarint("dvar_BC01AEA06D2DB983", 30);
  level.brgametype.respawndelay["_duos"][0] = getdvarint("dvar_FC1EF4784978935A", 15);
  level.brgametype.respawndelay["_duos"][1] = getdvarint("dvar_FC1EF37849789127", 20);
  level.brgametype.respawndelay["_duos"][2] = getdvarint("dvar_FC1EF27849788EF4", 30);
  level.brgametype.respawndelay["_trios"][0] = getdvarint("dvar_CC07978496A297A0", 20);
  level.brgametype.respawndelay["_trios"][1] = getdvarint("dvar_CC079A8496A29E39", 30);
  level.brgametype.respawndelay["_trios"][2] = getdvarint("dvar_CC07998496A29C06", 40);
  level.brgametype.respawndelay["_quads"][0] = getdvarint("dvar_F5BDD5587FD7F1F9", 25);
  level.brgametype.respawndelay["_quads"][1] = getdvarint("dvar_F5BDD2587FD7EB60", 35);
  level.brgametype.respawndelay["_quads"][2] = getdvarint("dvar_F5BDD3587FD7ED93", 45);
}

_id_338BA9B353A9A78B(player) {
  _id_89850B370A87AA3C = getdvarint("dvar_4838B7C39021124C", 1) - 1;

  if(istrue(level.brgametype._id_BB9B77186CB79AE6)) {
    players = scripts\mp\utility\player::getteamarray(player.team);
    _id_89850B370A87AA3C = players.size - 1;

    foreach(player in players) {
      if(isDefined(player) && istrue(player._id_632BAD3EDB4E449E))
        _id_89850B370A87AA3C--;
    }
  }

  _id_89850B370A87AA3C = int(max(min(_id_89850B370A87AA3C, level.brgametype._id_34AF112C77C2C381.size - 1), 0));
  return level.brgametype._id_34AF112C77C2C381[_id_89850B370A87AA3C];
}

_id_CC3F506623DAF71D(player) {
  _id_53A4A1C920DEF4BD = _id_338BA9B353A9A78B(player);

  if(level.br_circle.circleindex < 0)
    return level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][0];

  circleindex = int(min(level.br_circle.circleindex, level.brgametype.respawndelay[_id_53A4A1C920DEF4BD].size - 1));
  return level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][circleindex];
}

_id_74AE749DB3ACB35E(player, time) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("respawn_vehicle_death");

  while(time >= 0) {
    _id_53C22FBE6B489EC1(player, time);
    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("respawnInSeconds", time);
    time--;
    wait 1;
  }
}

_id_B6B4285E173DD004(player) {
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue | 16384;
  player setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_218D7F561BC41A41(player) {
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  _id_8F617FFD000EB682 = currentvalue &~16384;
  player setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_53C22FBE6B489EC1(player, value) {
  currentvalue = player getclientomnvar("ui_resurgenceRespawnTimer");
  _id_0A31AE8D2963FA9D = currentvalue &~16383;
  _id_8F617FFD000EB682 = _id_0A31AE8D2963FA9D | value;
  player setclientomnvar("ui_resurgenceRespawnTimer", _id_8F617FFD000EB682);
}

_id_6E7B6151ABA26DC2() {
  level endon("game_ended");
  level.brgametype._id_C42E40EC22A1F0D4 = 1;
  level.brgametype.respawndelay = [];
  level.brgametype._id_34AF112C77C2C381 = ["_solos", "_duos", "_trios", "_quads"];
  level.brgametype._id_BB9B77186CB79AE6 = getdvarint("dvar_ECD9594BD7C0B2AD", 1) == 1;
  level.brgametype._id_9524142EB719A321 = getdvarint("dvar_CA8DDD67C2B5771A", 1) == 1;
  level.brgametype._id_8947D8F4E61494FA = getdvarint("dvar_24D595ECD1DE09DC", 1) == 1 && istrue(level.brgametype._id_BB9B77186CB79AE6);
  level.brgametype._id_FB997D1846BD5CF4 = getdvarint("dvar_895F0D248F2C4008", 1) == 1 && istrue(level.brgametype._id_9524142EB719A321);
  level.brgametype._id_04AD7C03EC4FA687 = getdvarint("dvar_4838B7C39021124C", 0) == 1;
  setomnvar("ui_br_resurgence_respawn_enabled", 1);
  scripts\mp\flags::gameflagwait("prematch_done");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  thread _id_64E94E8B1E610263();
  thread _id_89473C1117C46C57();
  _id_6B3FE6B83B1C6B9E = _id_0E501CCE5C715CAF();

  foreach(_id_53A4A1C920DEF4BD in level.brgametype._id_34AF112C77C2C381) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6B3FE6B83B1C6B9E; _id_AC0E594AC96AA3A8++) {
      _id_33BFDC2307CF55B4 = getdvarint(_func_2EF675C13CA1C4AF("dvar_FD72EAB87B422F51", _id_AC0E594AC96AA3A8 + 1, _id_53A4A1C920DEF4BD), -1);

      if(_id_33BFDC2307CF55B4 >= 0) {
        level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8] = _id_33BFDC2307CF55B4;
        continue;
      }

      if(_id_AC0E594AC96AA3A8 >= level.brgametype.respawndelay[_id_53A4A1C920DEF4BD].size)
        level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8] = level.brgametype.respawndelay[_id_53A4A1C920DEF4BD][_id_AC0E594AC96AA3A8 - 1];
    }
  }

  waittime = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6B3FE6B83B1C6B9E; _id_AC0E594AC96AA3A8++)
    waittime = waittime + (level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8] + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8]);

  _id_8911F71726832879 = int(waittime * 1000);
  _id_BD5FD506DF61590D = getdvarint("dvar_342776B421CE99FA", 90000);
  level waittill("infils_ready");
  _id_E493CD71687BBCC3 = _id_8911F71726832879 - _id_BD5FD506DF61590D;

  if(_id_E493CD71687BBCC3 > 0) {
    wait(_id_E493CD71687BBCC3 * 0.001);
    _id_8911F71726832879 = _id_BD5FD506DF61590D;
  }

  setomnvarforallclients("ui_br_resurgence_will_disable", 1);
  setomnvarforallclients("ui_br_timed_feature_end_time", int(gettime() + _id_8911F71726832879));
  wait(_id_8911F71726832879 * 0.001);
  setomnvarforallclients("ui_br_timed_feature_end_time", 0);
  level.brgametype._id_C42E40EC22A1F0D4 = 0;
  level.brgametype._id_9524142EB719A321 = 0;
  level.brgametype._id_FB997D1846BD5CF4 = 0;
}

_id_89473C1117C46C57() {
  level endon("game_ended");
  level scripts\engine\utility::flag_wait("StartGameTypeCallbackFinished");
  level.brgametype._id_38D22E79B27C8A08 = _id_04CDABCD91A92977::_id_E3BD94413509BC25() && getdvarint("dvar_FA76FC54E37DA65D", 1);

  if(istrue(level.brgametype._id_38D22E79B27C8A08))
    _id_04CDABCD91A92977::_id_8FE6D6539ED31A88(::_id_FEA438AE40D5637B);
}

_id_FEA438AE40D5637B(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }
  if(istrue(level.brgametype._id_04AD7C03EC4FA687)) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  if(!istrue(level.brgametype._id_BB9B77186CB79AE6)) {
    return;
  }
  if(istrue(level.brgametype._id_8947D8F4E61494FA)) {
    _id_5AAB9D85460F9E87 = scripts\mp\utility\player::getteamarray(player.team);

    foreach(_id_55604B242897E62E in _id_5AAB9D85460F9E87)
    _id_55604B242897E62E thread scripts\mp\hud_message::showsplash("truckwar_ally_rejoin_improvement", undefined, player);
  }
}

_id_C21D160BC19FC200(player) {
  if(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    return;
  }
  if(istrue(level.brgametype._id_04AD7C03EC4FA687)) {
    return;
  }
  if(!istrue(level.brgametype._id_C42E40EC22A1F0D4)) {
    return;
  }
  _id_5AAB9D85460F9E87 = level.teamdata[player.team]["players"];

  if(_id_5AAB9D85460F9E87.size == 1) {
    if(istrue(level.brgametype._id_FB997D1846BD5CF4))
      _id_5AAB9D85460F9E87[0] thread scripts\mp\hud_message::showsplash("truckwar_left_behind_improvement");
  } else {
    foreach(_id_55604B242897E62E in _id_5AAB9D85460F9E87) {
      if(istrue(level.brgametype._id_8947D8F4E61494FA))
        _id_55604B242897E62E thread scripts\mp\hud_message::showsplash("truckwar_ally_left_improvement", undefined, player, undefined, 1);
    }
  }

  if(istrue(level.brgametype._id_BB9B77186CB79AE6))
    _id_2CEDCC356F1B9FC8::brleaderdialog("resurgence_on_player_disconnect", 1, _id_5AAB9D85460F9E87, undefined, 0, undefined, "dx_br_bds4_");
}

fadetogearingup(waittime) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  if(isteameliminated(self.team) || !level.teamcanrespawn[self.team]) {
    return;
  }
  _id_B59F471C2C064E56 = 1.0;
  thread fadeoutin();
  wait(_id_B59F471C2C064E56 - 0.25);
  _id_1E4A61DB11011446::_id_258C4F40DEE8189A();
  scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 2);
  wait 0.25;

  if(isteameliminated(self.team) || !level.teamcanrespawn[self.team]) {
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);
    return;
  }

  if(getdvarint("dvar_E912E88184530F28", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = getspawnpoint();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

fadeoutin() {
  level endon("game_ended");
  self endon("disconnect");
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  result = scripts\engine\utility::waittill_any_return_no_endon_death_3("spawned_player", "respawn_vehicle_in_gas", "gulag_auto_win");

  if(result == "spawned_player" || result == "respawn_vehicle_in_gas")
    self waittill("respawn_view_set");
  else
    scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_transition_type", 0);

  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
}

updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");
  self endon("respawn_vehicle_death");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = getspawnpoint();
      currenttime = gettime();

      if(currenttime - self.intermissionspawntime >= getdvarfloat("dvar_B72FC168D3582ECE", 2.0) * 1000) {
        spawnpoint = getspawnpoint();
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = getspawnpoint();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1.0;
  }
}

initspawns() {
  level.spawnheight = getdvarfloat("dvar_1CDB6B91E9C4A104", 2500);
}

getspawnpoint(isplanejump) {
  if(!isDefined(self.redeployspawn)) {
    self.redeployspawn = spawnStruct();
    return generatespawnpoint(istrue(isplanejump));
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

    spawnorigin = self.setspawnpoint.playerspawnpos;
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    groundorigin = scripts\engine\utility::drop_to_ground(spawnorigin, 10000, -20000, undefined, _id_FBCABD62B8F66EB8);
    spawnorigin = (spawnorigin[0], spawnorigin[1], groundorigin[2]);
    spawnorigin = spawnorigin + (0, 0, 1) * level.brtdm_config.spawnheight[self.team];

    if(getdvarint("dvar_53B56FCD1AD4A8CE") == 1)
      thread scripts\mp\utility\debug::drawline(spawnorigin, groundorigin, 15.0, (1, 1, 0));

    self.redeployspawn.origin = spawnorigin;
    self.redeployspawn.angles = self.setspawnpoint.playerspawnangles;
    self.redeployspawn.lifeid = self.lifeid;
    self.redeployspawn.time = gettime();
    scripts\mp\equipment\tac_insert::spawnpoint_clearspawnpoint(0, 1);
  } else if(self.redeployspawn.team != self.team || self.redeployspawn.lifeid != self.lifeid || istrue(self.redeployspawn.isplanejump))
    return generatespawnpoint(istrue(isplanejump));

  return self.redeployspawn;
}

generatespawnpoint(isplanejump) {
  spawnorigin = level.teamvehicles[self.team].origin;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
  result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000), undefined, _id_FBCABD62B8F66EB8)["position"];
  spawnorigin = (spawnorigin[0], spawnorigin[1], result[2] + level.spawnheight);

  if(istrue(level._id_AF6EC941D2B4E283) && getdvarint("dvar_202E933FD3431D24", 1) == 1) {
    if(istrue(level.circleclosing)) {
      _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
      _id_77E882DA07E78CFE = _id_2695A20D4011076D::getsafecircleradius();
      _id_29D5D9F11D8593C1 = _id_ADD4FD7502A75A8A - spawnorigin;
      _id_E1261BD8C0A31088 = distance2d(_id_ADD4FD7502A75A8A, spawnorigin);

      if(_id_E1261BD8C0A31088 > _id_77E882DA07E78CFE) {
        _id_12878F234651556D = vectorNormalize(_id_29D5D9F11D8593C1);
        _id_FFEB7FABC1A11EEF = 0;
        _id_283154A1960EFB8D = 0;

        if(level.br_circle.circleindex == 0) {
          _id_EC8D1EFD53E76629 = level.br_level.br_circleradii[level.br_circle.circleindex];
          _id_FFEB7FABC1A11EEF = _id_EC8D1EFD53E76629 - _id_77E882DA07E78CFE;
        } else {
          _id_FB0F5A7F828190B1 = level.br_level.br_circlecenters[level.br_circle.circleindex];
          _id_FFEB7FABC1A11EEF = distance2d(_id_ADD4FD7502A75A8A, _id_FB0F5A7F828190B1);
        }

        _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[level.br_circle.circleindex + 1];
        velocity = _id_FFEB7FABC1A11EEF / _id_C2D7D58BFAD1B1EE;
        _id_5FE3A6EBD9433E80 = velocity * getdvarfloat("dvar_4F1AEE380C4C64F8", 10.0);
        spawnorigin = spawnorigin + _id_12878F234651556D * _id_5FE3A6EBD9433E80;
        _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
        _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();

        if(distance2dsquared(spawnorigin, _id_819EDACDACB810E4) > _id_E86632D645C137D0 * _id_E86632D645C137D0) {
          _id_2099C256F875AD40 = vectorNormalize(spawnorigin - _id_819EDACDACB810E4);
          spawnorigin = _id_819EDACDACB810E4 + _id_2099C256F875AD40 * _id_E86632D645C137D0 * 0.99;
        }
      }
    }
  }

  self.redeployspawn.origin = spawnorigin;
  self.redeployspawn.angles = level.teamvehicles[self.team].angles;
  self.redeployspawn.time = gettime();
  self.redeployspawn.team = self.team;
  self.redeployspawn.index = -1;
  self.redeployspawn.lifeid = self.lifeid;
  self.redeployspawn.isplanejump = isplanejump;
  return self.redeployspawn;
}

watchspawninput() {
  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  _id_C6BD826CA92175D8 = 1;

  for(;;) {
    waitframe();

    if(getdvarint("dvar_C8B7643C6637E674", 0) != 0) {
      damage = 1000;
      radiusdamage(level.teamvehicles["axis"].origin, 1000, damage, damage);
    }
  }
}

addspawnlocation() {
  if(!isDefined(level.truckwarspawnlocations))
    level.truckwarspawnlocations = [];

  level.truckwarspawnlocations[level.truckwarspawnlocations.size] = level.players[0].origin;

  foreach(origin in level.truckwarspawnlocations) {}
}

#using_animtree("script_model");

init_airdrop_anims() {
  level.scr_animtree["ac130"] = #animtree;
  level.scr_anim["ac130"]["truck_drop"] = % mp_mkilo23_gunner_drop_acharlie130;
  level.scr_animname["ac130"]["truck_drop"] = "mp_mkilo23_gunner_drop_acharlie130";
  level.scr_anim["ac130"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_acharlie130_trimmed;
  level.scr_animname["ac130"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_acharlie130_trimmed";
  level.scr_animtree["parachute"] = #animtree;
  level.scr_anim["parachute"]["truck_drop"] = % mp_mkilo23_gunner_drop_parachute;
  level.scr_animname["parachute"]["truck_drop"] = "mp_mkilo23_gunner_drop_parachute";
  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", ::_id_E1DFA524DCDF1DD2, "truck_drop");
  level.scr_anim["parachute"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_parachute_trimmed;
  level.scr_animname["parachute"]["truck_drop_trimmed"] = "mp_mkilo23_gunner_drop_parachute_trimmed";
  scripts\common\anim::addnotetrack_customfunction("parachute", "parachute_detach_sfx", ::_id_E1DFA524DCDF1DD2, "truck_drop_trimmed");
  init_airrop_vehicle_anims();
}

_id_A614E0FEE13ECA53() {
  scripts\engine\utility::flag_wait("vehicle_init_complete");

  if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C("veh9_mil_lnd_mrap")) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328("veh9_mil_lnd_mrap");
  data.damage.class = "heavy";
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_applytabletovehicle("veh9_mil_lnd_mrap");
  data.damage._id_3259F2F4FAF8EAA8 = getdvarint("dvar_E20F6B4A3C18E03A", 3);
}

#using_animtree("mp_vehicles_always_loaded");

init_airrop_vehicle_anims() {
  level.scr_animtree["truck"] = #animtree;
  level.scr_anim["truck"]["truck_drop"] = % mp_mkilo23_gunner_drop_mkilo23;
  level.scr_anim["truck"]["truck_drop_trimmed"] = % mp_mkilo23_gunner_drop_mkilo23_trimmed;
}

truck_airdrop(vehicle, position, angles, _id_134736684B51C14B) {
  animation = scripts\engine\utility::ter_op(istrue(_id_134736684B51C14B), "truck_drop", "truck_drop_trimmed");
  vehicle.animname = "truck";
  vehicle._id_AE21E3BF76862551 = 1;
  vehicle vehphys_forcekeyframedmotion();
  vehicle hide();
  scenenode = spawn("script_model", position);
  scenenode.angles = angles;
  scenenode setModel("tag_origin");
  objent = undefined;
  parachute = spawn("script_model", position);
  parachute.angles = angles;
  parachute.animname = "parachute";
  parachute setModel("veh8_mil_lnd_bromeo_parachute");
  parachute scripts\common\anim::setanimtree();
  parachute forcenetfieldhighlod(1);
  parachute hide();
  carrier = undefined;

  if(istrue(_id_134736684B51C14B)) {
    carrier = spawn("script_model", position);
    carrier.angles = angles;
    carrier.animname = "ac130";
    carrier setModel("veh8_mil_air_acharlie130_ks_carrier");
    carrier scripts\common\anim::setanimtree();
    carrier hide();
  }

  scenenode.vehicle = vehicle;
  scenenode.parachute = parachute;
  scenenode.carrier = carrier;
  scenenode.objent = objent;
  _id_5119EBA6031EDF54 = gettime() + level.frameduration;
  scenenode.endtime = gettime();
  scenenode.vehicleendtime = _id_5119EBA6031EDF54 + getanimlength(level.scr_anim["truck"][animation]) * 1000;

  if(scenenode.vehicleendtime > scenenode.endtime)
    scenenode.endtime = scenenode.vehicleendtime;

  scenenode.parachuteendtime = _id_5119EBA6031EDF54 + getanimlength(level.scr_anim["parachute"][animation]) * 1000;

  if(scenenode.parachuteendtime > scenenode.endtime)
    scenenode.endtime = scenenode.parachuteendtime;

  scenenode.carrierendtime = _id_5119EBA6031EDF54 + getanimlength(level.scr_anim["ac130"][animation]) * 1000;

  if(scenenode.carrierendtime > scenenode.endtime)
    scenenode.endtime = scenenode.carrierendtime;

  scenenode thread truck_airdropinternal(animation);
  return vehicle;
}

truck_airdropinternal(animation) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, animation);
  scripts\common\anim::anim_first_frame_solo(self.parachute, animation);

  if(isDefined(self.carrier))
    scripts\common\anim::anim_first_frame_solo(self.carrier, animation);

  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    self.vehicle._id_FB98158AABA0AE49 = 1;
    thread scripts\common\anim::anim_single_solo(self.vehicle, animation);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, animation);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("veh_br_c17_airdrop_lp");
    self.carrier setscriptablepartstate("lights2", "on", 0);
    self.carrier setscriptablepartstate("contrails", "on", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, animation);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime)
      thread truck_detachvehiclefromairdropsequence(self.vehicle);

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime)
      self.parachute delete();

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime)
      self.carrier delete();

    waitframe();
  }

  thread truck_detachvehiclefromairdropsequence(self.vehicle);

  if(isDefined(self.parachute))
    self.parachute delete();

  if(isDefined(self.carrier))
    self.carrier delete();

  self delete();
}

truck_detachvehiclefromairdropsequence(vehicle) {
  self.vehicle = undefined;

  if(isDefined(vehicle)) {
    vehicle vehphys_setdefaultmotion();
    vehicle thread _id_F004D4B200AA4C84();
  }
}

_id_F004D4B200AA4C84() {
  self endon("death");
  self physics_registerforcollisioncallback();
  waitframe();
  endtime = gettime() + 5000;
  _id_E66474B0BA499331 = undefined;
  _id_BEC445E79E2F5B6A = undefined;

  while(gettime() < endtime) {
    if(!isDefined(_id_E66474B0BA499331))
      _id_E66474B0BA499331 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    else {
      _id_544768E59992F277 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      _id_CDD8B2D07410AAB0 = (_id_544768E59992F277 - _id_E66474B0BA499331) / level.framedurationseconds;

      if(isDefined(_id_BEC445E79E2F5B6A)) {
        if(_id_BEC445E79E2F5B6A - _id_CDD8B2D07410AAB0 >= 300) {
          _id_327619A999339E18(self.origin, self.angles);
          break;
        }
      }

      _id_E66474B0BA499331 = _id_544768E59992F277;
      _id_BEC445E79E2F5B6A = _id_CDD8B2D07410AAB0;
    }

    waitframe();
  }

  self physics_unregisterforcollisioncallback();
}

_id_327619A999339E18(position, angles) {
  self._id_FB98158AABA0AE49 = 0;
  thread _id_C1BFB96A5E39A0A7(self);
  thread _id_2D381B790DC27F9F(self);
  playFX(scripts\engine\utility::getfx("light_tank_land"), position, anglesToForward(angles));
  earthquake(0.3, 0.7, position, 800);
  playrumbleonposition("grenade_rumble", position);
  physicsexplosionsphere(position, 800, 400, 0.5);
}

_id_E1DFA524DCDF1DD2(parachute) {}

showsplashtoteam(team, splashname) {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(splashname, level.teamdata[team]["players"]);
}

_id_9F5606E3BD1C508D(ref, players, delay) {
  if(isDefined(game["dialog"][ref]))
    _id_2CEDCC356F1B9FC8::brleaderdialog(ref, 0, players, undefined, delay, undefined, "dx_br_bds5_");
}

_id_73BDF8B18E29B13F(players) {
  thread _id_664EA636B19A418F(players);
  level._id_6273D0C32535D86E = getdvarint("scr_truckwar_repair_station", 0) == 1;
  level._id_EB56E1684153708A = getdvarint("dvar_4E6765B5F47964DF", 0) == 1;

  foreach(_id_E4A6D0A55FD775A7 in level._id_354F6E3EEBCE5123) {
    if(!istrue(_id_E4A6D0A55FD775A7._id_6234172895D0C06F))
      _id_E4A6D0A55FD775A7 setscriptablepartstate(_id_E4A6D0A55FD775A7 _meth_EC5F4851431F3382(), "idle");
  }

  if(istrue(level._id_6273D0C32535D86E))
    level thread _id_E3327F035A47191B();

  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar("scr_br_numlives", 1);
  }

  scripts\mp\deathicons::removealldeathicons();
  scripts\mp\flags::gameflaginit("trucks_spawn_complete", 0);
  level thread _id_9E97F797DC8E211C();
  scripts\mp\flags::gameflagwait("trucks_spawn_complete");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!isalive(player))
      player scripts\mp\playerlogic::spawnplayer(0);

    if(istrue(player.br_iseliminated))
      _id_0A34750D17473C49::unmarkplayeraseliminated(player);

    player setclientomnvar("ui_br_infil_started", 1);
    player setclientomnvar("ui_br_infiled", 1);
    player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
    player thread _id_08AA3182C50A3094();
  }

  wait 2.0;
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(player in level.players)
  player playsoundtoplayer("br_ac130_flyby", player, player);

  wait 2.0;
  spawnvehicles();
  assignvehiclestoteams();

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread _id_927A1C74689CE55A();
  }

  level thread _id_4EC88C05D0625CA0();
  scripts\mp\flags::gameflagset("use_truck_respawn");
}

_id_664EA636B19A418F(players) {
  setmusicstate("mx_jup_rvl_parachute_jump");
  wait 3;

  foreach(player in level.players) {
    player waittill("truckwar_infil_sfx");
    player playlocalsound("evt_br_infil_jump_buzzer", undefined, undefined, 1);
    wait 0.8;
    player playlocalsound("evt_br_infil_jump_stinger", undefined, undefined, 1);
  }
}

_id_08AA3182C50A3094() {
  spawnpoint = spawnStruct();
  spawnpoint.origin = level._id_8D137603BD840E40[self.team].origin;
  spawnpoint.height = getdvarint("dvar_7B079D61A6A1B553", 3000);
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
}

_id_927A1C74689CE55A() {
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.br_iseliminated))
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);

  vehicle = level.teamvehicles[self.team];

  if(!istrue(vehicle._id_AE21E3BF76862551))
    level thread truck_airdrop(vehicle, vehicle.origin, vehicle.angles, 0);

  getspawnpoint(1);
  _id_C1763D3130BBE79A = anglesToForward((0, randomint(360), 0));
  offset = getdvarint("dvar_152992667994717B", 500);
  height = getdvarint("dvar_7B079D61A6A1B553", 3000);
  spawnorigin = self.redeployspawn.origin + _id_C1763D3130BBE79A * offset + (0, 0, 1) * height;
  spawnangles = vectortoangles(self.redeployspawn.origin - spawnorigin);

  while(self isinexecutionattack() || self isinexecutionvictim())
    waitframe();

  waitframe();
  _id_07C40FA80892A721::givestartingarmor();
  self setOrigin(spawnorigin, 1);
  self setplayerangles(spawnangles);
  thread _id_45B2B4A889E633FA::parachute(undefined, 0, undefined, 0);
  self notify("truckwar_infil_sfx");
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self clearsoundsubmix("deaths_door_mp", 1);
  self notify("do_welcome_splashes");
}

_id_E3327F035A47191B() {
  level._id_02C467B902768C15 = [];

  if(istrue(level._id_EB56E1684153708A)) {
    _setdomflagiconinfo("waypoint_repair_station_idle", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_idle", 0);
    _setdomflagiconinfo("waypoint_repair_station_in_use", 1, "neutral", "MP_BR_INGAME/REPAIR_STATION", "ui_mp_br_mapmenu_icon_truckwar_repair_in_use", 0);
  }

  if(getdvarint("dvar_E9ACC6AC1A49F7C0", 0) != 1) {
    _id_757D4D2CE1701811 = getdvarint("dvar_B4A41EB239A45BB2", 90000);
    origins = _id_DA77FEE0CBA3F65A();

    foreach(origin in origins) {
      _id_E4A6D0A55FD775A7 = _id_204A1F1178F8CA87(origin, sqrt(_id_757D4D2CE1701811));
      _id_E4A6D0A55FD775A7._id_757D4D2CE1701811 = _id_757D4D2CE1701811;
      level._id_02C467B902768C15[level._id_02C467B902768C15.size] = _id_E4A6D0A55FD775A7;
    }
  }

  _id_757D4D2CE1701811 = getdvarint("dvar_15F14BA39B98E2D7", 90000);
  origins = _id_D1ECD71915270559();

  foreach(origin in origins) {
    _id_E4A6D0A55FD775A7 = _id_204A1F1178F8CA87(origin, sqrt(_id_757D4D2CE1701811));
    _id_E4A6D0A55FD775A7._id_757D4D2CE1701811 = _id_757D4D2CE1701811;
    level._id_02C467B902768C15[level._id_02C467B902768C15.size] = _id_E4A6D0A55FD775A7;
  }

  _id_757D4D2CE1701811 = getdvarint("dvar_C266F4671F4C6F79", 90000);
  origins = _id_B680F9A0DF0C0507();

  foreach(origin in origins) {
    _id_E4A6D0A55FD775A7 = _id_204A1F1178F8CA87(origin, sqrt(_id_757D4D2CE1701811));
    _id_E4A6D0A55FD775A7._id_757D4D2CE1701811 = _id_757D4D2CE1701811;
    level._id_02C467B902768C15[level._id_02C467B902768C15.size] = _id_E4A6D0A55FD775A7;
  }

  _id_757D4D2CE1701811 = getdvarint("dvar_A2C43CBB69AA6A83", 90000);
  origins = _id_040A9065852FC3B1();

  foreach(origin in origins) {
    _id_E4A6D0A55FD775A7 = _id_204A1F1178F8CA87(origin, sqrt(_id_757D4D2CE1701811));
    _id_E4A6D0A55FD775A7._id_757D4D2CE1701811 = _id_757D4D2CE1701811;
    level._id_02C467B902768C15[level._id_02C467B902768C15.size] = _id_E4A6D0A55FD775A7;
  }
}

_setdomflagiconinfo(name, _id_96D1603BEEEFA4EA, colors, string, image, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = _id_96D1603BEEEFA4EA;
  level.waypointstring[name] = string;
  level.waypointshader[name] = image;
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

_id_204A1F1178F8CA87(origin, radius) {
  _id_E4A6D0A55FD775A7 = undefined;

  if(istrue(level._id_EB56E1684153708A)) {
    trigger = spawn("trigger_radius", origin, 0, int(radius), int(radius));
    _id_E4A6D0A55FD775A7 = _id_6663215F917210AE::setupobjective(trigger);
    _id_E4A6D0A55FD775A7.pinobj = 0;
    _id_E4A6D0A55FD775A7 scripts\mp\gameobjects::allowuse("none");
    _id_E4A6D0A55FD775A7.flagmodel hide();
    scripts\mp\objidpoolmanager::update_objective_position(_id_E4A6D0A55FD775A7.objidnum, _id_E4A6D0A55FD775A7.curorigin + (0, 0, 60));
    _func_865F9C5D005F9A08(_id_E4A6D0A55FD775A7.objidnum, 1);
    _id_E4A6D0A55FD775A7 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
  } else
    _id_E4A6D0A55FD775A7 = spawnscriptable("truckwar_repair_station", origin, (0, 0, 1));

  _id_E4A6D0A55FD775A7.inuse = 0;
  _id_E4A6D0A55FD775A7._id_18E4B96D492D6950 = 0;
  return _id_E4A6D0A55FD775A7;
}

_id_DA77FEE0CBA3F65A() {
  origins = [];

  if(level.mapname == "mp_br_mechanics")
    origins[origins.size] = (1850, -50, 0);
  else if(level.mapname == "mp_don4") {
    origins[origins.size] = (-18964, -22238, -165);
    origins[origins.size] = (5507, -29862, 62);
    origins[origins.size] = (-21604, 1168, -254);
    origins[origins.size] = (-6975, 19920, -262);
    origins[origins.size] = (-28578, 46653, 2746);
    origins[origins.size] = (-3099, 56987, 678);
    origins[origins.size] = (19946, 3582, -390);
    origins[origins.size] = (16578, -22869, -146);
    origins[origins.size] = (46055, 24809, -342);
  } else {
    origins[origins.size] = (-18964, -22238, -165);
    origins[origins.size] = (5507, -29862, 62);
    origins[origins.size] = (-21604, 1168, -254);
    origins[origins.size] = (-6975, 19920, -262);
    origins[origins.size] = (-28578, 46653, 2746);
    origins[origins.size] = (-3080, 56856, 678);
    origins[origins.size] = (19946, 3582, -390);
    origins[origins.size] = (16578, -22869, -146);
    origins[origins.size] = (46055, 24809, -342);
  }

  return origins;
}

_id_D1ECD71915270559() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (-30563, 3055, -232);
    origins[origins.size] = (-21165, -15396, -246);
    origins[origins.size] = (-27563, -2557, -256);
    origins[origins.size] = (-22268, -27419, -82);
    origins[origins.size] = (-9895, -34131, 218);
    origins[origins.size] = (10254, -20711, -231);
    origins[origins.size] = (4552, -14424, -229);
    origins[origins.size] = (-11881, 1482, -262);
    origins[origins.size] = (-18095, 6481, -262);
    origins[origins.size] = (10306, 14001, -270);
    origins[origins.size] = (17112, 2074, -534);
    origins[origins.size] = (33549, 26531, 627);
    origins[origins.size] = (44925, 17451, -308);
    origins[origins.size] = (45326, -265, 20);
    origins[origins.size] = (5317, 24973, 50);
    origins[origins.size] = (47951, -9453, 154);
  } else {
    origins[origins.size] = (-30563, 3055, -232);
    origins[origins.size] = (-21165, -15396, -246);
    origins[origins.size] = (-27563, -2557, -256);
    origins[origins.size] = (-22268, -27419, -82);
    origins[origins.size] = (-9895, -34131, 218);
    origins[origins.size] = (10254, -20711, -231);
    origins[origins.size] = (4552, -14424, -229);
    origins[origins.size] = (-11881, 1482, -262);
    origins[origins.size] = (-18095, 6481, -262);
    origins[origins.size] = (10306, 14001, -270);
    origins[origins.size] = (17112, 2074, -534);
    origins[origins.size] = (33549, 26531, 627);
    origins[origins.size] = (44925, 17451, -308);
    origins[origins.size] = (45326, -265, 20);
  }

  return origins;
}

_id_B680F9A0DF0C0507() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (15625, 36254, 1510);
    origins[origins.size] = (28400, 39129, 762);
    origins[origins.size] = (-7544, 33510, -10);
    origins[origins.size] = (25786, 20693, 1383);
    origins[origins.size] = (-13791, 46397, 1833);
    origins[origins.size] = (3195, 50010, 1120);
    origins[origins.size] = (-24770, 34814, 390);
    origins[origins.size] = (-4988, 16480, -214);
  } else {
    origins[origins.size] = (15625, 36254, 1510);
    origins[origins.size] = (28400, 39129, 762);
    origins[origins.size] = (-7544, 33510, -10);
    origins[origins.size] = (26074, 20938, 1384);
    origins[origins.size] = (-13791, 46397, 1833);
    origins[origins.size] = (3195, 50010, 1120);
    origins[origins.size] = (-24770, 34814, 390);
    origins[origins.size] = (-4988, 16480, -214);
  }

  return origins;
}

_id_040A9065852FC3B1() {
  origins = [];

  if(level.mapname == "mp_don4") {
    origins[origins.size] = (18940, -24914, -199);
    origins[origins.size] = (13021, -35175, -422);
    origins[origins.size] = (37931, -30644, -513);
    origins[origins.size] = (54024, -23960, -83);
  } else {
    origins[origins.size] = (18940, -24914, -199);
    origins[origins.size] = (13021, -35175, -422);
    origins[origins.size] = (37931, -30644, -513);
    origins[origins.size] = (54024, -23960, -83);
  }

  return origins;
}

_id_4EC88C05D0625CA0() {
  if(!istrue(level._id_6273D0C32535D86E)) {
    return;
  }
  _id_1CB68A5E7CC26C0F = getdvarfloat("dvar_E7C32B801C5B43A2", 0.025);
  _id_BED888265C10FCC1 = getdvarfloat("dvar_9E06ADB574328430", 1.0);

  for(;;) {
    foreach(_id_E4A6D0A55FD775A7 in level._id_02C467B902768C15)
    _id_E4A6D0A55FD775A7._id_59E9B68F790A1EF1 = 0;

    foreach(team, truck in level.teamvehicles) {
      if(!isDefined(truck)) {
        continue;
      }
      _id_BBBAF88370F158B8 = istrue(truck._id_34F355A9DA5039E1);
      _id_279EBFB6B9DCF247 = 0;

      foreach(_id_E4A6D0A55FD775A7 in level._id_02C467B902768C15) {
        distsq = distancesquared(truck.origin, scripts\engine\utility::ter_op(isDefined(_id_E4A6D0A55FD775A7.origin), _id_E4A6D0A55FD775A7.origin, _id_E4A6D0A55FD775A7.curorigin));

        if(distsq < _id_E4A6D0A55FD775A7._id_757D4D2CE1701811) {
          _id_E4A6D0A55FD775A7 _id_D3210B6035722F9A();
          _id_E4A6D0A55FD775A7._id_59E9B68F790A1EF1 = 1;
          _id_279EBFB6B9DCF247 = 1;

          if(istrue(truck._id_A2DA885FCC826D37)) {
            continue;
          }
          if(truck.health == truck.maxhealth) {
            continue;
          }
          truck._id_34F355A9DA5039E1 = 1;

          if(!_id_BBBAF88370F158B8)
            _id_256806BCFDF38C83(team);

          _id_6F17073F208628D6 = int(_id_1CB68A5E7CC26C0F * truck.maxhealth);
          truck scripts\cp_mp\vehicles\vehicle_damage::_id_653B96CE8310763E(_id_6F17073F208628D6);
          players = scripts\mp\utility\teams::getteamdata(team, "players");

          foreach(player in players) {
            if(getdvarint("dvar_38D15E2D7DDBF066", 0) == 1)
              player _id_5762AC2F22202BA2::hudicontype("truckheal");

            player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_pockets", truck.health);
            player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_cash_banked", truck.maxhealth);
          }

          break;
        }
      }

      if(_id_BBBAF88370F158B8 && !_id_279EBFB6B9DCF247) {
        truck._id_34F355A9DA5039E1 = 0;
        _id_256806BCFDF38C83(team);
      }
    }

    foreach(_id_E4A6D0A55FD775A7 in level._id_02C467B902768C15) {
      if(!_id_E4A6D0A55FD775A7._id_59E9B68F790A1EF1)
        _id_E4A6D0A55FD775A7 _id_EC3B48F24927F84E();
    }

    wait(_id_BED888265C10FCC1);
  }
}

_id_D3210B6035722F9A() {
  self._id_18E4B96D492D6950 = self.inuse;
  self.inuse = 1;

  if(self.inuse != self._id_18E4B96D492D6950) {
    if(istrue(level._id_EB56E1684153708A))
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_in_use");
  }
}

_id_EC3B48F24927F84E() {
  self._id_18E4B96D492D6950 = self.inuse;
  self.inuse = 0;

  if(self.inuse != self._id_18E4B96D492D6950) {
    if(istrue(level._id_EB56E1684153708A))
      scripts\mp\gameobjects::setobjectivestatusicons("waypoint_repair_station_idle");
  }
}

_id_0E501CCE5C715CAF() {
  _id_5CB3866995416341 = getdvarint("dvar_856015437DC2F753", 5);

  if(_id_5CB3866995416341 > level.br_level.br_circleclosetimes.size - 1)
    _id_5CB3866995416341 = level.br_level.br_circleclosetimes.size - 1;

  return _id_5CB3866995416341;
}

_id_8D947898C35B8068() {
  level endon("game_ended");
  level._id_24380DB31E302A78 = 0;
  level waittill("infils_ready");
  _id_5CB3866995416341 = _id_0E501CCE5C715CAF();
  _id_2948CA54731DE34F = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5CB3866995416341 - 1; _id_AC0E594AC96AA3A8++) {
    _id_2948CA54731DE34F = _id_2948CA54731DE34F + level.br_level.br_circleclosetimes[_id_AC0E594AC96AA3A8];
    _id_2948CA54731DE34F = _id_2948CA54731DE34F + level.br_level.br_circledelaytimes[_id_AC0E594AC96AA3A8];
  }

  _id_754110404C0D574F = gettime() + _id_2948CA54731DE34F * 1000;
  setomnvar("ui_gulag_timer", int(_id_754110404C0D574F));

  for(;;) {
    level waittill("br_circle_set");

    if(level.br_circle.circleindex == _id_5CB3866995416341) {
      _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("truckwar_spawn_disabled", level.players);
      thread _id_9F5606E3BD1C508D("vehicle_spawn_over", level.players);
      level._id_24380DB31E302A78 = 1;
      setomnvar("ui_gulag_timer", 0);
      break;
    }
  }
}

alternatebrcircle() {
  _id_0D232DBFD1F080AF = level._id_A02389E5D5497129;
  level.br_level.br_circleclosetimes = [level._id_837CD01DC6486D8C];
  level.br_level.br_circledelaytimes = [level._id_15415172069D735F];
  level.br_level.br_circleshowdelaydanger = [1];
  _id_8A0C6190284443B7 = level.br_level.br_circleminimapradii;
  _id_141BCDD92479E414 = scripts\engine\utility::ter_op(isDefined(level._id_5A41C5287237C308), level._id_5A41C5287237C308, level.br_level.br_circleradii);

  if(level._id_E12122C5431959B5) {
    level.br_level.br_circleshowdelaysafe = [0];
    level.br_level.br_circleminimapradii = [_id_8A0C6190284443B7[0]];
    level.br_level.br_circleradii = [_id_141BCDD92479E414[0], _id_141BCDD92479E414[_id_141BCDD92479E414.size - 1]];
  } else {
    level.br_level.br_circleshowdelaysafe = [0];
    level.br_level.br_circleminimapradii = [int(_id_0D232DBFD1F080AF / 2)];
    level.br_level.br_circleradii = [_id_0D232DBFD1F080AF, _id_0D232DBFD1F080AF];
  }

  setDvar("scr_br_moving_circle_count", level._id_944B40A215902330);
  circleradius = [];
  _id_04F81729168C0B8A = [];
  _id_74B5B12BB6514385 = [];
  _id_1AFD23E03D011EC6 = [];
  _id_525C3ED89B299A14 = level._id_E182232B582AA5D6;
  _id_FCD89A21F4B87835 = level._id_F28E1ED7F6ADF52D;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level._id_944B40A215902330; _id_AC0E594AC96AA3A8++) {
    if(level._id_E12122C5431959B5) {
      _id_A61C75B156FC1EE0 = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 + 1 < _id_141BCDD92479E414.size - 1, _id_141BCDD92479E414[_id_AC0E594AC96AA3A8], _id_141BCDD92479E414[_id_141BCDD92479E414.size - 2]);
      _id_E5BB6F1DD3C507D1 = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 + 1 < _id_8A0C6190284443B7.size - 1, _id_8A0C6190284443B7[_id_AC0E594AC96AA3A8], _id_8A0C6190284443B7[_id_8A0C6190284443B7.size - 2]);
      circleradius[circleradius.size] = _id_A61C75B156FC1EE0;
      _id_1AFD23E03D011EC6[_id_1AFD23E03D011EC6.size] = _id_E5BB6F1DD3C507D1;
    } else {
      circleradius[circleradius.size] = 57300;
      _id_1AFD23E03D011EC6[_id_1AFD23E03D011EC6.size] = 10500;
    }

    if(isDefined(level._id_3D86F613DC0BFA16)) {
      index = scripts\engine\utility::ter_op(level._id_3D86F613DC0BFA16.size <= _id_AC0E594AC96AA3A8, level._id_3D86F613DC0BFA16.size - 1, _id_AC0E594AC96AA3A8);
      _id_525C3ED89B299A14 = level._id_3D86F613DC0BFA16[index];
    } else
      _id_525C3ED89B299A14 = max(level._id_886566E69EE53D98, _id_525C3ED89B299A14 - level._id_411CE67DC4849722);

    if(isDefined(level._id_DC008290077A7185)) {
      index = scripts\engine\utility::ter_op(level._id_DC008290077A7185.size <= _id_AC0E594AC96AA3A8, level._id_DC008290077A7185.size - 1, _id_AC0E594AC96AA3A8);
      _id_FCD89A21F4B87835 = level._id_DC008290077A7185[index];
    } else
      _id_FCD89A21F4B87835 = max(level._id_4D77D157099CF459, _id_FCD89A21F4B87835 - level._id_84F1C23ED82E4EC5);

    _id_04F81729168C0B8A[_id_04F81729168C0B8A.size] = _id_525C3ED89B299A14;
    _id_74B5B12BB6514385[_id_74B5B12BB6514385.size] = _id_FCD89A21F4B87835;
  }

  _id_2695A20D4011076D::extendcirclelist(circleradius, _id_04F81729168C0B8A, _id_74B5B12BB6514385, _id_1AFD23E03D011EC6);
}

_id_D4864F0577158363() {
  level endon("game_ended");
  _id_9CF4AC09E4991562 = getdvarint("dvar_35AC52B0E7E835AA", 10000);
  xoffset = randomfloatrange(_id_9CF4AC09E4991562 * -1, _id_9CF4AC09E4991562);
  yoffset = randomfloatrange(_id_9CF4AC09E4991562 * -1, _id_9CF4AC09E4991562);
  level.br_level.br_circlecenters[0] = level.br_level.br_mapcenter + (xoffset, yoffset, 0);
  level.br_level.br_circlecenters[1] = level.br_level.br_mapcenter + (xoffset, yoffset, 0);

  if(getdvarint("dvar_869EBA038D752C6E", 1) == 1) {
    for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < level.br_level.br_circlecenters.size - 1; _id_AC0E594AC96AA3A8++)
      _id_0A7EFA595A4C994C(_id_AC0E594AC96AA3A8);
  } else {
    for(;;) {
      level waittill("br_circle_set");
      _id_0A7EFA595A4C994C();
    }
  }
}

_id_0A7EFA595A4C994C(index) {
  if(!isDefined(index))
    index = level.br_circle.circleindex + 1;

  if(level.br_level.br_circlecenters.size <= index || !istrue(level._id_AF6EC941D2B4E283)) {
    return;
  }
  _id_D303E81057B8A554 = level.br_level.br_circlecenters[index];
  _id_B65A1BDA511E60AB = level.br_level.br_circleradii[index - 1] * level._id_6D02A364E8331928;
  _id_332BFCF7ECA6F520 = _id_2695A20D4011076D::getrandompointinboundscircle(_id_D303E81057B8A554, _id_B65A1BDA511E60AB, 0.8, 1.0, 1, 0, 1);
  _id_71E7CDE0A5DBE9DA = vectorNormalize(_id_332BFCF7ECA6F520 - _id_D303E81057B8A554) * _id_B65A1BDA511E60AB;
  _id_DA9544331D11402C = _id_D303E81057B8A554 + _id_71E7CDE0A5DBE9DA;

  if(getdvarint("dvar_668D5B4706735002", 1) == 1 && !_id_2695A20D4011076D::isvalidpointinbounds(_id_DA9544331D11402C, 1))
    _id_DA9544331D11402C = _id_D303E81057B8A554 - _id_71E7CDE0A5DBE9DA;

  _id_B755813C92F9BD4A = getdvarint("dvar_5664DA3CA3493F97", 10000);
  _id_E93890B0C58EC649 = vectorNormalize(level.br_level.br_mapcenter - _id_DA9544331D11402C);
  contents = physics_createcontents(["physicscontents_trigger"]);

  for(trace = scripts\engine\trace::ray_trace_ents(_id_D303E81057B8A554, _id_DA9544331D11402C, level.outofboundstriggers, contents); !_id_2695A20D4011076D::isvalidpointinbounds(_id_DA9544331D11402C, 1) || trace["fraction"] < 1.0; trace = scripts\engine\trace::ray_trace_ents(_id_D303E81057B8A554, _id_DA9544331D11402C, level.outofboundstriggers, contents))
    _id_DA9544331D11402C = _id_DA9544331D11402C + _id_E93890B0C58EC649 * _id_B755813C92F9BD4A;

  level.br_level.br_circlecenters[index + 1] = _id_DA9544331D11402C;
}

_id_1E7C5CADD2C12A32(_id_CDCD3178F5176585) {
  _id_DC8625458EE5ED14 = level.br_level.br_mapbounds;
  _id_B1D9D00302A9B4D6 = level._id_BE52F2D0DEE6B894;
  inmapbounds = _id_CDCD3178F5176585[0] < _id_DC8625458EE5ED14[0][0] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[0] > _id_DC8625458EE5ED14[1][0] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[1] < _id_DC8625458EE5ED14[0][1] * _id_B1D9D00302A9B4D6 && _id_CDCD3178F5176585[1] > _id_DC8625458EE5ED14[1][1] * _id_B1D9D00302A9B4D6;
  return inmapbounds;
}

_id_875871597AB85666(point, time) {
  _id_ADD4FD7502A75A8A = _id_2695A20D4011076D::getsafecircleorigin();
  _id_77E882DA07E78CFE = _id_2695A20D4011076D::getsafecircleradius();
  _id_29D5D9F11D8593C1 = _id_ADD4FD7502A75A8A - point;
  _id_E1261BD8C0A31088 = distance2d(_id_ADD4FD7502A75A8A, point);

  if(_id_E1261BD8C0A31088 < _id_77E882DA07E78CFE)
    return 0;

  _id_B5BD7F541CD7DA40 = 0;
  _id_38A99723F45FA9A2 = (0, 0, 0);
  _id_59786C4080C725A3 = 0;
  _id_D262FCBB7FF54D34 = 0;
  _id_910F0A634BF6E83E = 0;
  _id_6F62CED051B4427F = 0;
  _id_C2D7D58BFAD1B1EE = level.br_level.br_circleclosetimes[level.br_circle.circleindex];

  if(level.br_circle.circleindex > 0) {
    _id_FB0F5A7F828190B1 = level.br_level.br_circlecenters[level.br_circle.circleindex];
    _id_B5BD7F541CD7DA40 = distance2d(_id_ADD4FD7502A75A8A, _id_FB0F5A7F828190B1);
    _id_38A99723F45FA9A2 = vectorNormalize(_id_ADD4FD7502A75A8A - _id_FB0F5A7F828190B1);
  }

  _id_59786C4080C725A3 = _id_B5BD7F541CD7DA40 / _id_C2D7D58BFAD1B1EE;
  _id_EC8D1EFD53E76629 = level.br_level.br_circleradii[level.br_circle.circleindex];
  _id_D262FCBB7FF54D34 = _id_EC8D1EFD53E76629 - _id_77E882DA07E78CFE;
  _id_910F0A634BF6E83E = vectorNormalize(_id_29D5D9F11D8593C1);
  _id_6F62CED051B4427F = _id_D262FCBB7FF54D34 / _id_C2D7D58BFAD1B1EE;
  _id_208B20B100E6C745 = point + _id_38A99723F45FA9A2 * -1.0 * time * _id_59786C4080C725A3 + _id_910F0A634BF6E83E * -1.0 * time * _id_6F62CED051B4427F;
  return _id_2695A20D4011076D::_id_024C5A8D31AE262F(_id_208B20B100E6C745);
}

_id_C1BFB96A5E39A0A7(vehicle) {
  vehicle endon("death");

  for(;;) {
    vehicle waittill("give_upgrade", _id_5473A133B9D77893);

    switch (_id_5473A133B9D77893) {
      case "armor":
        _id_22F556FAB80598EB(vehicle);
        break;
      case "trophy":
        _id_852ABB774FF2A90E(vehicle);
        break;
      case "trophy_refill":
        _id_08F4DA0F65951C0B(vehicle);
        break;
      case "uav":
        _id_2B6F04CB613A01E8(vehicle);
        break;
      case "barrel":
        _id_060FDE27C0DD8510(vehicle);
        break;
      case "turret":
        _id_E8779DCE7E960D56(vehicle);
        break;
      case "smoke":
        _id_3CF1AC037CDBC2A5(vehicle);
        break;
      case "engine":
        _id_AB77860B63BE6DA6(vehicle);
        break;
    }
  }
}

_id_22F556FAB80598EB(vehicle) {
  _id_00E9B1E17B0D0BA3(vehicle);
  vehicle._id_4F3E23EE48660F12 = 1;
  vehicle notify("upgrade_message", "armor_upgraded");
  playsoundatpos(vehicle.origin + (0, 0, 20), "veh_truckwars_add_armor");
}

_id_00E9B1E17B0D0BA3(vehicle) {
  armor = ["tag_armor_body_back_01", "tag_armor_body_back_02", "tag_armor_body_back_03", "tag_armor_body_back_04", "tag_armor_body_back_05", "tag_armor_body_back_06", "tag_armor_body_back_07", "tag_armor_body_back_08", "tag_armor_body_back_09", "tag_armor_body_back_10", "tag_armor_body_back_11", "tag_armor_body_back_12", "tag_armor_body_left_01", "tag_armor_body_left_02", "tag_armor_body_left_03", "tag_armor_body_left_04", "tag_armor_body_left_05", "tag_armor_body_left_06", "tag_armor_body_left_07", "tag_armor_body_left_08", "tag_armor_body_left_09", "tag_armor_body_left_10", "tag_armor_body_left_11", "tag_armor_body_right_01", "tag_armor_body_right_02", "tag_armor_body_right_03", "tag_armor_body_right_04", "tag_armor_body_right_05", "tag_armor_body_right_06", "tag_armor_body_right_07", "tag_armor_body_right_08", "tag_armor_body_right_09", "tag_armor_body_right_10", "tag_armor_body_right_11", "tag_armor_bumper_back", "tag_armor_bumper_front", "tag_armor_cabin_front_01", "tag_armor_cabin_front_02", "tag_armor_cabin_front_03", "tag_armor_cabin_front_04", "tag_armor_cabin_front_05", "tag_armor_cabin_front_06", "tag_armor_cabin_front_07", "tag_armor_cabin_front_09", "tag_armor_cabin_left_01", "tag_armor_cabin_left_02", "tag_armor_cabin_left_03", "tag_armor_cabin_left_04", "tag_armor_cabin_left_05", "tag_armor_cabin_right_01", "tag_armor_cabin_right_02", "tag_armor_cabin_right_03", "tag_armor_cabin_right_04", "tag_armor_cabin_right_05", "tag_armor_cabin_top", "tag_armor_door_left", "tag_armor_door_right", "tag_armor_wheel_back_left", "tag_armor_wheel_back_right", "tag_armor_wheel_front_left", "tag_armor_wheel_front_right", "tag_armor_wheel_middle1_left", "tag_armor_wheel_middle1_right", "tag_armor_wheel_middle2_left", "tag_armor_wheel_middle2_right", "tag_armor_wheel_middle2_right"];

  foreach(tag in armor)
  scripts\cp_mp\vehicles\vehicle_damage::_id_963F1CB109B9C186(vehicle, tag);
}

_id_35F2FF0427594776(vehicle) {
  doors = ["tag_door_front_left", "tag_door_front_right", "tag_windshield_front"];

  foreach(tag in doors)
  scripts\cp_mp\vehicles\vehicle_damage::_id_963F1CB109B9C186(vehicle, tag);

  scripts\cp_mp\vehicles\vehicle_damage::_id_09AE605ED3DC3BD1(vehicle);
}

_id_852ABB774FF2A90E(vehicle) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophy", "init")) {
    _id_D9A1DA35DBDE5E4F = scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophy", "init");
    vehicle._id_FA8480818F379E09 = 3;
    vehicle.isdisabled = 0;
    vehicle thread[[_id_D9A1DA35DBDE5E4F]](72, 280900, ::_id_9F13CC66529C6E8F, ::trophy_protectionsuccessful);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyCreateExplosion", "init"))
      vehicle.explosion = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyCreateExplosion", "init")]](vehicle);

    vehicle notify("upgrade_message", "trophy_activated");
  }
}

_id_08F4DA0F65951C0B(vehicle) {
  vehicle._id_FA8480818F379E09 = 3;
  vehicle.isdisabled = 0;
  vehicle notify("upgrade_message", "trophy_ammo_refill");
}

_id_9F13CC66529C6E8F() {
  return 1;
}

trophy_protectionsuccessful(_id_1DBABE317739127E) {
  _id_D7030318CA9E674A = _id_1DBABE317739127E.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](_id_1DBABE317739127E);

  tag = "tag_origin";
  _id_01331AEFD6D9A100 = vectortoangles(self gettagorigin(tag) - _id_D7030318CA9E674A);
  _id_CC29543DE9737588 = combineangles(_id_01331AEFD6D9A100, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init"))
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](_id_D7030318CA9E674A, _id_CC29543DE9737588);

  if(self._id_FA8480818F379E09 > 0)
    self._id_FA8480818F379E09--;

  if(self._id_FA8480818F379E09 == 0) {
    self.isdisabled = 1;
    self notify("upgrade_message", "trophy_no_ammo");
  }
}

_id_2B6F04CB613A01E8(vehicle) {
  vehicle thread _id_8F5F2701E3CB8E9C();
  vehicle notify("upgrade_message", "uav_activated");
}

_id_8F5F2701E3CB8E9C() {
  self endon("death");
  radius = getdvarint("dvar_00BC348A829ED932", 12000);
  time = getdvarint("dvar_4523720BE81F63AD", 5.0);
  _id_05AB9EA557C8B0A4 = time * 1000;

  for(;;) {
    triggerportableradarpingteam(self.origin, self.team, radius, _id_05AB9EA557C8B0A4);
    wait(time);
  }
}

_id_060FDE27C0DD8510(vehicle) {
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, "iw9_mg_mrap_mp");
  turret _meth_8F6D35F8C518E9A0(getdvarfloat("dvar_6B8CA746928C55DD", 0.07));
  turret _meth_EC33A72C0CB03AA6(getdvarfloat("dvar_8282DFAC90BA34D7", 0.35));
  vehicle notify("upgrade_message", "barrel_activated");
}

_id_E8779DCE7E960D56(vehicle) {
  spawndata = spawnStruct();

  if(isDefined(vehicle._id_FADC8CE0C904ABDA))
    spawndata._id_14CDE247AC3313A4 = vehicle._id_FADC8CE0C904ABDA;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_mil_lnd_mrap", "createGrenadeTurret")) {
    turret = [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_mil_lnd_mrap", "createGrenadeTurret")]](vehicle, spawndata);
    scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon("iw9_tur_mrap_mp"));
    vehicle.occupantsreserving["gunner"] = undefined;
    vehicle._id_065DA0A245B653CC = undefined;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(vehicle);
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(vehicle);
  }

  vehicle notify("upgrade_message", "grenade_turret_activated");
}

_id_3CF1AC037CDBC2A5(vehicle) {
  vehicle._id_EC76FFDBE2F37C5B = 0;
  vehicle._id_09CD07317BA52DF4 = 1;
  vehicle notify("upgrade_message", "smoke_activated");
}

_id_AB77860B63BE6DA6(vehicle) {
  vehicle vehicle_settopspeedforward(42);
  vehicle._id_580DB2147190028A = 0.5;
  vehicle notify("upgrade_message", "engine_activated");
}

_id_5B776E8C62234D00() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.radar))
    self.radar delete();
}

_id_5FD118F91AE96E57(vehicle) {
  spawnorigin = vehicle gettagorigin("tag_screen_left");
  _id_2FA65F34EB9042F5 = spawn("script_model", spawnorigin);
  _id_2FA65F34EB9042F5 linkTo(vehicle, "tag_screen_left");
  _id_2FA65F34EB9042F5.index = 1;
  _id_2FA65F34EB9042F5._id_7940DCDE72827AF7 = 10;
  _id_2FA65F34EB9042F5.playersusing = [];
  _id_2FA65F34EB9042F5._id_114E759371623080 = 1;
  vehicle._id_2FA65F34EB9042F5 = _id_2FA65F34EB9042F5;
}

_id_FE081D074870C23D(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  player._id_C77002478CDFD85F = level.teamvehicles[player.team];
  _id_2FA65F34EB9042F5 = level.teamvehicles[player.team]._id_2FA65F34EB9042F5;
  _id_2FA65F34EB9042F5.playersusing[_id_2FA65F34EB9042F5.playersusing.size] = player;
  player thread _id_4384ABBF498DF6A7::_runpurchasemenu(_id_2FA65F34EB9042F5);
}

_id_2D381B790DC27F9F(vehicle) {
  vehicle endon("death");

  for(;;) {
    _id_256806BCFDF38C83(vehicle.team);
    wait 0.1;
  }
}

_id_256806BCFDF38C83(team, player) {
  vehicle = level.teamvehicles[team];
  _id_5C9DDCF56D36F133 = 0;

  if(isDefined(vehicle) && !istrue(vehicle.isdestroyed)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "uav"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 1;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "armor"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 2;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "trophy")) {
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 4;
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + (vehicle._id_FA8480818F379E09 << 3);

      if(isDefined(vehicle._id_FA8480818F379E09) && vehicle._id_FA8480818F379E09 == 3)
        _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 32;
    }

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "barrel"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 64;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "turret"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 128;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "smoke"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 256;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, "engine"))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 512;

    if(vehicle.health == vehicle.maxhealth)
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 8192;
    else if(!vehicle scripts\cp_mp\vehicles\vehicle_interact::_id_FC271F387096702F())
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 2048;
    else if(isDefined(vehicle._id_90C69F8BA6618910))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 4096;

    if(istrue(vehicle._id_F6B881F5981D97C7))
      _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 16384;
  } else if(_id_81C029669130C0D4(team))
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 32768;
  else
    _id_5C9DDCF56D36F133 = _id_5C9DDCF56D36F133 + 1024;

  _id_A776F097EB36E500 = 0;
  _id_EF26F6C03156BA96 = 0;

  if(isDefined(vehicle)) {
    _id_A776F097EB36E500 = clamp(vehicle.health / vehicle.maxhealth, 0.0, 1.0);
    _id_EF26F6C03156BA96 = clamp(vehicle._id_CF9BA498AF4E41E9 / level._id_C7B9749BCC6A6207, 0.0, 1.0);
  }

  if(isDefined(player)) {
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_status", _id_5C9DDCF56D36F133);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_health", _id_A776F097EB36E500);
    player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_fuel", _id_EF26F6C03156BA96);
  } else {
    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(_id_AC0E424AC96A7113 in players) {
      _id_AC0E424AC96A7113 scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_status", _id_5C9DDCF56D36F133);
      _id_AC0E424AC96A7113 scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_health", _id_A776F097EB36E500);
      _id_AC0E424AC96A7113 scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_armored_truck_fuel", _id_EF26F6C03156BA96);
    }
  }
}

_id_DE1AC98379235D8B(itemname, _id_1DE514083A2FBC8D) {
  if(!isDefined(_id_1DE514083A2FBC8D))
    return undefined;

  player = self;
  stock = 0;
  _id_07637BED9334618E = "";

  switch (itemname) {
    case "vehicleUpgradeArmor":
      _id_07637BED9334618E = "armor";
      break;
    case "vehicleUpgradeBarrel":
      _id_07637BED9334618E = "barrel";
      break;
    case "vehicleUpgradeUAV":
      _id_07637BED9334618E = "uav";
      break;
    case "vehicleUpgradeEngine":
      _id_07637BED9334618E = "engine";
      break;
    case "vehicleUpgradeGrenadeTurret":
      _id_07637BED9334618E = "turret";
      break;
    case "vehicleUpgradeSmoke":
      _id_07637BED9334618E = "smoke";
      break;
    case "vehicleUpgradeTrophy":
      _id_07637BED9334618E = "trophy";
      break;
  }

  if(_id_07637BED9334618E != "") {
    vehicle = level.teamvehicles[player.team];

    if(!isDefined(vehicle))
      return undefined;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_97C32F66EFF29610(vehicle, _id_07637BED9334618E)) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return _id_1DE514083A2FBC8D;
}

_id_59566A4CE3C2C3E2() {
  return getdvarint("dvar_9E315C398CDE8B75", 1);
}

_id_60D5992F51286201(team) {
  if(!isDefined(self) || !isDefined(self.team))
    return 0;

  _id_0FB932F46EF5EC56 = scripts\mp\utility\game::getsubgametype() == "truckwar";
  team = self.team;

  if(!isDefined(level._id_B5A6F27D40059C6A))
    level._id_B5A6F27D40059C6A = [];

  level._id_B5A6F27D40059C6A[self.team] = 1;

  if(_id_0FB932F46EF5EC56)
    _id_256806BCFDF38C83(self.team, self);

  if(_id_59566A4CE3C2C3E2())
    thread _id_7106DA00352CD1E0();
}

_id_81C029669130C0D4(team) {
  if(!isDefined(team)) {
    if(!isDefined(self) || !isDefined(self.team))
      return 0;

    team = self.team;
  }

  if(!isDefined(level._id_B5A6F27D40059C6A))
    return 0;

  return istrue(level._id_B5A6F27D40059C6A[team]);
}

_id_D5D633C35998EBE7(team) {
  if(!isDefined(team))
    return 0;

  level._id_B5A6F27D40059C6A[team] = undefined;
  _id_256806BCFDF38C83(team);
}

_id_7106DA00352CD1E0() {
  level endon("game_ended");
  self endon("vehicle_drop_success");

  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }
  team = self.team;
  level notify("monitor_death_for_airdrop_" + team);
  level endon("monitor_death_for_airdrop_" + team);
  self waittill("death_or_disconnect");
  _id_D5D633C35998EBE7(team);
}

_id_8D45FF943DE1CFC4() {
  level.br_standard_loadout = _id_93E3D45FC14694A2();
  _id_C179E44BD14D2D12 = _id_9577FCF1998C53B7();
  _id_1E4A61DB11011446::givestandardtableloadout(0, 1, _id_C179E44BD14D2D12);

  if(!isDefined(self.equipment) || !isDefined(self.equipment["health"]))
    _id_07C40FA80892A721::_id_BE5C0CDFA0202544();

  return 0;
}

_id_93E3D45FC14694A2() {
  loadout = level.br_standard_loadout;

  if(isDefined(level._id_C04B5EDF3F9EA340)) {
    circleindex = 0;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      circleindex = min(level.br_circle.circleindex, level._id_C04B5EDF3F9EA340.size);
      circleindex = int(circleindex);
    }

    if(isDefined(level._id_77C121D31E587BA8[circleindex]))
      loadout = level._id_C04B5EDF3F9EA340[circleindex][level._id_77C121D31E587BA8[circleindex]];
  }

  return loadout;
}

_id_9577FCF1998C53B7() {
  _id_C179E44BD14D2D12 = 0;

  if(isDefined(level._id_C04B5EDF3F9EA340)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      if(level.br_circle.circleindex == level._id_C04B5EDF3F9EA340.size - 1)
        _id_C179E44BD14D2D12 = 1;
    }
  }

  return _id_C179E44BD14D2D12;
}

_id_81124B7B16101F8B() {
  _id_0FB932F46EF5EC56 = scripts\mp\utility\game::getsubgametype() == "truckwar";

  if(!_id_0FB932F46EF5EC56)
    return 1;

  _id_13D86B0AEA4F84AF = _id_59566A4CE3C2C3E2();

  if(_id_13D86B0AEA4F84AF) {
    if(_id_6E4F7E117D4651C3())
      return 0;
  }

  if(!_id_D48C5142F8271C18())
    return 0;

  return 1;
}

_id_6E4F7E117D4651C3() {
  player = self;
  squad = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_8F7040E569EC9E98 in squad) {
    if(isDefined(_id_8F7040E569EC9E98)) {
      _id_EBEC497FF8B18A45 = _id_8F7040E569EC9E98 scripts\mp\supers::getcurrentsuperref();

      if(isDefined(_id_EBEC497FF8B18A45) && _id_EBEC497FF8B18A45 == "super_vehicle_drop") {
        if(_id_8F7040E569EC9E98 getammocount(_id_8F7040E569EC9E98.super.staticdata.weapon) > 0)
          return 1;
      } else if(_id_8F7040E569EC9E98 _id_2D9D24F7C63AC143::_id_36B1968BFE78916B(9245))
        return 1;
    }
  }

  if(isDefined(level._id_E3CCF0898A949BEC) && istrue(level._id_E3CCF0898A949BEC[player.team]))
    return 1;

  return 0;
}

_id_D48C5142F8271C18() {
  if(_id_81C029669130C0D4())
    return 0;

  if(isDefined(level.teamvehicles) && !isDefined(level.teamvehicles[self.team]))
    return 1;

  return 0;
}