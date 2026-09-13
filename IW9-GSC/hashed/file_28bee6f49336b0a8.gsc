/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_28bee6f49336b0a8.gsc
***********************************************/

init() {
  _id_046CF752D93DC17B::init();
  level._id_5D2AF95280A3CF58 = getdvarint("dvar_36A630E359EA8611", 16000);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_supply_drop", _id_046CF752D93DC17B::_id_94FF06D2DB58E807);
  dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("dmz_c17_drop", "military_carepackage_03_dmz");
  _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("dmz_c17_drop", "onDropSpawned", ::_id_BAA146D001C08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("dmz_samsite_drop", "military_carepackage_03_dmz_samsite");
  _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("dmz_samsite_drop", "onDropSpawned", ::_id_BAA146D001C08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("dmz_supply_drop", "military_carepackage_03_dmz_supply");
  _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("dmz_supply_drop", "onDropSpawned", ::_id_BAA146D001C08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
  dropstruct = _id_046CF752D93DC17B::_id_69B2E5235BFB7998("dmz_boss_drop", "military_carepackage_03_dmz_boss");
  _id_046CF752D93DC17B::_id_80E49E34FC8D70B8("dmz_boss_drop", "onDropSpawned", ::_id_BAA146D001C08201);
  dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";

  if(getdvarint("dvar_531F1530CB50BB4A", 1) == 0) {
    return;
  }
  level thread _id_9A7D934B60433CD9();
}

_id_BAA146D001C08201(_id_8EE83E2CBD3D747D) {
  _id_40920B1903F4682A = "cashdrop_common";
  self setscriptablepartstate("objective_map", _id_40920B1903F4682A, 0);
}

_id_9A7D934B60433CD9() {
  scripts\mp\flags::gameflagwait("prematch_done");
  waittime = getdvarint("dvar_7AFFEDBE66B614EA", 300);
  wait(waittime);
  level thread _id_9BCDECC2B1FCC04C();
  _id_652F47620AC4713F = level.teamswithplayers.size;

  if(_id_652F47620AC4713F > 1) {
    _id_4540E9373196EAAF = _id_593929A3BE0BB12D(level.teamswithplayers[0]);
    _id_AB5B12377CA2B989 = _id_593929A3BE0BB12D(level.teamswithplayers[1]);

    if(isDefined(_id_4540E9373196EAAF) && isDefined(_id_AB5B12377CA2B989)) {
      pos = (_id_4540E9373196EAAF + _id_AB5B12377CA2B989) / 2;
      _id_046CF752D93DC17B::_id_1A01863A6EC2AD05(scripts\engine\utility::drop_to_ground(pos), "dmz_c17_drop");
      return;
    }
  } else {
    foreach(player in level.players) {
      if(scripts\mp\utility\player::isreallyalive(player)) {
        _id_3EE855CFE6F5F8D5(player);
        return;
      }
    }
  }
}

_id_9BCDECC2B1FCC04C() {
  wait 3;
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_supply_drop", level.players);
}

_id_3EE855CFE6F5F8D5(player) {
  _id_5BF3E22BDB650432 = player.origin;
  _id_491F9F618AD350F6 = getdvarint("dvar_AB10323144550ACF", 2000);
  _id_5E1FCD736AA390A3 = getdvarint("dvar_A002DDE97CD0623E", 3000);
  _id_5BF3E22BDB650432 = scripts\engine\utility::drop_to_ground(_id_5BF3E22BDB650432 + vectorNormalize(scripts\engine\utility::_id_6174330574A2A273()) * (randomint(_id_5E1FCD736AA390A3) + _id_491F9F618AD350F6), 10500);
  _id_046CF752D93DC17B::_id_1A01863A6EC2AD05(_id_5BF3E22BDB650432, "dmz_c17_drop");
}

_id_593929A3BE0BB12D(team) {
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player) && isDefined(player.origin))
      return player.origin;
  }

  return undefined;
}