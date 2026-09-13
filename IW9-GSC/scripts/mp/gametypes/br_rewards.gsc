/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_rewards.gsc
***********************************************/

init_br_rewards() {
  processkillstreaksintotiers();
  level.tierrewardcounts = [];
  level.tierrewardcounts[3] = 0;
  level.tierrewardcounts[2] = 0;
  level.tierrewardcounts[1] = 0;
  level.tierrewardcounts[0] = 0;
}

runmissionrewarddelivery(_id_96FB3D33FBD543F9, _id_58E8D1412BC688CD, streakname, _id_676B590EA065842F) {
  _id_76A22C18960F72AF = undefined;

  if(!isDefined(_id_96FB3D33FBD543F9.rewardlocation)) {
    _id_76A22C18960F72AF = findclosestdroplocation(_id_96FB3D33FBD543F9);

    if(!isDefined(_id_76A22C18960F72AF))
      _id_76A22C18960F72AF = calculatedroplocationnearlocation(_id_96FB3D33FBD543F9, 64, 2048);
  } else
    _id_76A22C18960F72AF = _id_96FB3D33FBD543F9.rewardlocation;

  if(isDefined(streakname))
    thread runkillstreakreward(_id_76A22C18960F72AF, _id_58E8D1412BC688CD, streakname);
  else if(isDefined(_id_676B590EA065842F))
    thread runkillstreakreward(_id_76A22C18960F72AF, _id_58E8D1412BC688CD, getkillstreak(_id_676B590EA065842F));
  else
    thread runkillstreakreward(_id_76A22C18960F72AF, _id_58E8D1412BC688CD, getkillstreak(3));
}

runkillstreakreward(location, _id_58E8D1412BC688CD, streakname) {
  level endon("game_ended");
  crate = undefined;

  if(!istrue(location.isinside))
    offset = 72;
  else
    offset = 40;

  object = scripts\mp\gameobjects::createobjidobject(location.origin, "neutral", (0, 0, offset), undefined, "any");
  maskobjectivetoplayerssquad(object, _id_58E8D1412BC688CD);
  object.origin = location.origin;
  object.angles = location.angles;
  thread docratedropsmoke(undefined, location, 16);
  object.iconname = "_incoming";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  wait 3;
  wait 1;

  if(!istrue(location.isinside)) {
    crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(_id_58E8D1412BC688CD.team, streakname, location.origin, (0, randomint(360), 0), undefined);
    crate.skipminimapicon = 1;
    crate.nevertimeout = 0;
    crate.waitforobjectiveactivate = 1;
    crate.killminimapicon = 0;
    crate.disallowheadiconid = 1;
    crate.isarmcrate = 1;
    crate waittill("crate_dropped");
    object.useobj = crate;
    object.origin = crate.origin;
  } else {
    object.useobj = spawn("script_model", object.origin);
    object.useobj.disallowheadiconid = 1;
    object.useobj.cratetype = "arm_no_owner";
    _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata(object.useobj.cratetype);
    object.useobj.minimapicon = _id_962A30A9BB8C0F09.minimapicon;
    object.useobj.capturestring = _id_962A30A9BB8C0F09.capturestring;
    object.useobj.rerollstring = _id_962A30A9BB8C0F09.rerollstring;
    object.useobj.supportsreroll = _id_962A30A9BB8C0F09.supportsreroll;
    object.useobj.isdummyarmcrate = 1;
    object.useobj.isarmcrate = 1;
    object.useobj.data = scripts\cp_mp\killstreaks\airdrop::getarmcratedatabystreakname(streakname);
    scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, object.useobj);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 40);
  }

  _id_DE9E30874C191943 = 0;
  interval = 0.1;

  if(istrue(location.isinside))
    waittime = 15;
  else
    waittime = 1;

  wait(waittime);

  if(!istrue(location.isinside)) {
    crate notify("objective_activate");
    scripts\mp\objidpoolmanager::update_objective_onentity(object.objidnum, crate);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 72);
  } else {
    object.useobj scripts\cp_mp\killstreaks\airdrop::makecrateusable();
    _id_962A30A9BB8C0F09 = scripts\cp_mp\killstreaks\airdrop::getleveldata(object.useobj.cratetype);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(object.objidnum, 40);
  }

  object.iconname = "";
  object.lockupdatingicons = 0;
  object scripts\mp\gameobjects::setobjectivestatusicons(streakname);
  object.lockupdatingicons = 1;
  objective_setlabel(object.objidnum, "");

  if(isDefined(crate))
    crate waittill("death");
  else
    object.useobj waittill("death");

  object scripts\mp\gameobjects::setvisibleteam("none");
  object scripts\mp\gameobjects::releaseid();
  object.visibleteam = "none";
}

dropcrate(_id_D8061F26B5ECA018, _id_76A22C18960F72AF, team) {
  crate = scripts\cp_mp\killstreaks\airdrop::droparmcratefromscriptedheli(team, _id_D8061F26B5ECA018, _id_76A22C18960F72AF.origin, (0, randomint(360), 0), undefined);
  return crate;
}

docratedropsmoke(crate, _id_76A22C18960F72AF, duration) {
  _id_E0D03A39E88DFF15 = _id_76A22C18960F72AF.origin + (0, 0, 2000);
  spawnpos = scripts\common\utility::groundpos(_id_E0D03A39E88DFF15, (0, 0, 1));
  _id_76A22C18960F72AF.vfxent = spawn("script_model", spawnpos);
  _id_76A22C18960F72AF.vfxent setModel("tag_origin");
  _id_76A22C18960F72AF.vfxent.angles = (0, 0, 0);
  _id_76A22C18960F72AF.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  wait 1;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), _id_76A22C18960F72AF.vfxent, "tag_origin");

  if(isDefined(crate))
    crate scripts\engine\utility::waittill_any_timeout_1(duration, "crate_dropped");
  else
    wait(duration);

  stopFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_gr"), _id_76A22C18960F72AF.vfxent, "tag_origin");
  _id_76A22C18960F72AF.vfxent delete();
}

getkillstreak(tier) {
  if(!isDefined(level.killstreaktierlist))
    processkillstreaksintotiers();

  level.killstreaktierlist[tier] = scripts\engine\utility::array_randomize(level.killstreaktierlist[tier]);
  return level.killstreaktierlist[tier][0];
}

br_getrandomkillstreakreward() {
  _id_C7856E174C7CA8DD = 0;
  _id_C4BA6DD2B83A8BB5 = 0;
  _id_78D4698C80FE0610 = 0;
  _id_84F3D2D3ACDF03F5 = 0;
  _id_D2BA4103F3A95696 = 0;
  _id_62760130E376FEA3 = 0;
  _id_7F64B15A67FCD125 = 10;
  _id_7F64B05A67FCCEF2 = 35;
  _id_7F64AF5A67FCCCBF = 35;
  _id_7F64AE5A67FCCA8C = 20;

  if(isDefined(level.tierrewardcounts[0]) && level.tierrewardcounts[0] < 2 || 0)
    _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD + 10;
  else {
    _id_78D4698C80FE0610 = 1;
    _id_7F64B15A67FCD125 = 0;
  }

  if(isDefined(level.tierrewardcounts[1]) && level.tierrewardcounts[1] < -1 || 1) {
    _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD + 35;

    if(!_id_78D4698C80FE0610)
      _id_7F64B05A67FCCEF2 = _id_7F64B05A67FCCEF2 + 10;
  } else {
    _id_84F3D2D3ACDF03F5 = 1;
    _id_7F64B05A67FCCEF2 = 0;
  }

  if(isDefined(level.tierrewardcounts[2]) && level.tierrewardcounts[2] < -1 || 1) {
    _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD + 35;

    if(!_id_78D4698C80FE0610)
      _id_7F64AF5A67FCCCBF = _id_7F64AF5A67FCCCBF + 10;

    if(!_id_84F3D2D3ACDF03F5)
      _id_7F64AF5A67FCCCBF = _id_7F64AF5A67FCCCBF + 35;
  } else {
    _id_D2BA4103F3A95696 = 1;
    _id_7F64AF5A67FCCCBF = 0;
  }

  if(isDefined(level.tierrewardcounts[3]) && level.tierrewardcounts[3] < 15 || 0) {
    _id_C7856E174C7CA8DD = _id_C7856E174C7CA8DD + 20;

    if(!_id_78D4698C80FE0610)
      _id_7F64AE5A67FCCA8C = _id_7F64AE5A67FCCA8C + 10;

    if(!_id_84F3D2D3ACDF03F5)
      _id_7F64AE5A67FCCA8C = _id_7F64AE5A67FCCA8C + 35;

    if(!_id_84F3D2D3ACDF03F5)
      _id_7F64AE5A67FCCA8C = _id_7F64AE5A67FCCA8C + 35;
  } else {
    _id_62760130E376FEA3 = 1;
    _id_7F64AE5A67FCCA8C = 0;
  }

  _id_8B591B0BC361AB3D = randomintrange(1, _id_C7856E174C7CA8DD);

  if(_id_8B591B0BC361AB3D <= _id_7F64B15A67FCD125) {
    level.tierrewardcounts[0]++;
    _id_25F8F5DA15B55857 = scripts\engine\utility::array_randomize(level.killstreaktierlist[0]);
    return _id_25F8F5DA15B55857[0];
  } else if(_id_8B591B0BC361AB3D <= _id_7F64B05A67FCCEF2) {
    level.tierrewardcounts[1]++;
    _id_25F8F5DA15B55857 = scripts\engine\utility::array_randomize(level.killstreaktierlist[1]);
    return _id_25F8F5DA15B55857[0];
  } else if(_id_8B591B0BC361AB3D <= _id_7F64AF5A67FCCCBF) {
    level.tierrewardcounts[2]++;
    _id_25F8F5DA15B55857 = scripts\engine\utility::array_randomize(level.killstreaktierlist[2]);
    return _id_25F8F5DA15B55857[0];
  } else {
    level.tierrewardcounts[3]++;
    _id_25F8F5DA15B55857 = scripts\engine\utility::array_randomize(level.killstreaktierlist[3]);
    return _id_25F8F5DA15B55857[0];
  }
}

processkillstreaksintotiers() {
  level.killstreaktierlist = [];
  level.killstreaktierlist[3] = ["cruise_predator", "scrambler_drone_guard", "uav"];
  level.killstreaktierlist[2] = ["precision_airstrike", "multi_airstrike", "bradley"];
  level.killstreaktierlist[1] = ["toma_strike", "uav", "pac_sentry", "white_phosphorus"];
  level.killstreaktierlist[0] = ["uav"];
}

br_getrewardicon(streakname) {
  _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[streakname];

  if(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09.hudicon))
    return _id_D442547D75DFFD09.hudicon;

  return "";
}

dropweaponcarepackage(position) {
  level endon("game_ended");
  dropstruct = scripts\cp_mp\killstreaks\airdrop::dropcratefrommanualheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), 3000, 3000, position, scripts\cp_mp\killstreaks\airdrop::getbrcratedatabytype("weapon"));

  if(!isDefined(dropstruct))
    return undefined;
  else if(!isDefined(dropstruct.crate))
    return undefined;

  return dropstruct.crate;
}

initdropbagsystem() {
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(16, ::_id_B90101A9DB963BD1, ::_id_26A4C7CF6DA4E2C0);
  scripts\cp_mp\killstreaks\airdrop::initplundercratedata();
  level.waypointstring["icon_waypoint_marker"] = "DROP_BAG";
  level.dropbagstruct = spawnStruct();
  level.dropbagstruct.clusters = scripts\engine\utility::getStructArray("dropBagCluterNode", "script_noteworthy");
  _id_0CF73B12323D082A = scripts\engine\utility::getStructArray("dropBagLocation", "script_noteworthy");

  foreach(location in _id_0CF73B12323D082A) {
    location.inuse = 0;

    foreach(_id_3402D60C1EF6B931 in level.dropbagstruct.clusters) {
      if(location.target == _id_3402D60C1EF6B931.targetname) {
        if(!isDefined(_id_3402D60C1EF6B931.droplocations))
          _id_3402D60C1EF6B931.droplocations = [];

        if(_id_3402D60C1EF6B931.droplocations.size < 7)
          _id_3402D60C1EF6B931.droplocations[_id_3402D60C1EF6B931.droplocations.size] = location;

        continue;
      }
    }
  }

  initdropbagvo();
}

initdropbagvo() {
  game["dialog"]["dropbag_incoming"] = "dpbi_wzan_gams";
}

precomputedropbagpositions(_id_D0DE15F793F14825) {
  playerlist = [];
  _id_F4AB694B30FF6942 = [];
  circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
  circleradius = _id_2695A20D4011076D::getsafecircleradius();
  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    if(level.teamdata[team]["teamCount"] > 0) {
      _id_F115BAFF60D7FFFA = 0;
      _id_4CCCC55B861F079E = undefined;

      foreach(player in level.teamdata[team]["alivePlayers"]) {
        if(!isDefined(_id_4CCCC55B861F079E) && !istrue(player.gulag) && !istrue(player._id_E6204058F06B94E5))
          _id_4CCCC55B861F079E = player;

        if(istrue(player.issquadleader) && !istrue(player.gulag) && !istrue(player._id_E6204058F06B94E5)) {
          _id_F115BAFF60D7FFFA = 1;
          playerlist[playerlist.size] = player;

          if(istrue(_id_D0DE15F793F14825) && isDefined(level.br_spawns[player.team].groundorigin))
            _id_F4AB694B30FF6942[_id_F4AB694B30FF6942.size] = level.br_spawns[player.team].groundorigin;
          else
            _id_F4AB694B30FF6942[_id_F4AB694B30FF6942.size] = player.origin;

          break;
        }
      }

      if(!_id_F115BAFF60D7FFFA) {
        if(isDefined(_id_4CCCC55B861F079E)) {
          player = _id_4CCCC55B861F079E;
          playerlist[playerlist.size] = player;

          if(istrue(_id_D0DE15F793F14825) && isDefined(level.br_spawns[player.team].groundorigin))
            _id_F4AB694B30FF6942[_id_F4AB694B30FF6942.size] = level.br_spawns[player.team].groundorigin;
          else
            _id_F4AB694B30FF6942[_id_F4AB694B30FF6942.size] = player.origin;
        } else if(level.teamdata[team]["aliveCount"] > 0) {
          player = level.teamdata[team]["alivePlayers"][0];
          playerlist[playerlist.size] = player;
          _id_9E5D403038E4C071 = randomfloat(360.0);
          _id_97AD91666291CF6F = randomfloat(circleradius);
          _id_357C72EBBA546824 = circleorigin + (cos(_id_9E5D403038E4C071) * _id_97AD91666291CF6F, sin(_id_9E5D403038E4C071) * _id_97AD91666291CF6F, 0.0);
          _id_F4AB694B30FF6942[_id_F4AB694B30FF6942.size] = _id_357C72EBBA546824;
        }
      }
    }
  }

  _id_342822C35FBA7025 = 5;

  if(isDefined(level.dropbagstruct.clusters) && level.dropbagstruct.clusters.size && isDefined(level.dropbagstruct.clusters[0].droplocations))
    _id_342822C35FBA7025 = level.dropbagstruct.clusters[0].droplocations.size;

  _id_2827E1B47AE2AB6E = getdvarfloat("scr_dropbag_mindist", 3000);
  _id_DEEEF4B8CB10CAE0 = getdvarfloat("scr_dropbag_maxdist", 7000);
  _id_833736327534C698 = spawnStruct();
  _id_833736327534C698.origin = (0, 0, 0);
  _id_E4B7E99A96C8829F = [_id_833736327534C698];
  _id_AEED6CE6E6FF3F3E = getdvarint("dvar_5A52E56AD2E6CDFB", 128);

  if(isDefined(level.br_level)) {
    if(circleradius > 0)
      _id_E4B7E99A96C8829F = computedropbagpositions(_id_F4AB694B30FF6942, level.dropbagstruct.clusters, level.br_level.br_mapbounds, _id_2827E1B47AE2AB6E, _id_DEEEF4B8CB10CAE0, 2000, _id_342822C35FBA7025, _id_AEED6CE6E6FF3F3E, circleorigin, circleradius);
    else
      _id_E4B7E99A96C8829F = computedropbagpositions(_id_F4AB694B30FF6942, level.dropbagstruct.clusters, level.br_level.br_mapbounds, _id_2827E1B47AE2AB6E, _id_DEEEF4B8CB10CAE0, 2000, _id_342822C35FBA7025, _id_AEED6CE6E6FF3F3E);
  }

  if(isDefined(_id_E4B7E99A96C8829F)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E4B7E99A96C8829F.size; _id_AC0E594AC96AA3A8++) {
      player = playerlist[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].node)) {
        _id_3C6BB864DCC6CDA7 = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].node;
        _id_3402D60C1EF6B931 = level.dropbagstruct.clusters[_id_3C6BB864DCC6CDA7];
        _id_0C62B5998026B34F = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].index;
        player.precomputeddropbagpos = _id_3402D60C1EF6B931.droplocations[_id_0C62B5998026B34F].origin;
        continue;
      }

      player.precomputeddropbagpos = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8].origin;
    }

    level.precomputeddropbags = 1;
    level thread spawndropbagsovertime(playerlist);
  }

  level thread managedropbags();
}

managedropbags() {
  level endon("game_ended");
  level notify("manageDropBags");
  level endon("manageDropBags");
  _id_C192239C59747190 = -1;

  for(;;) {
    if(!isDefined(level.br_pickups.crates) || !level.br_pickups.crates.size) {
      _id_C192239C59747190 = -1;
      wait 1.0;
      continue;
    }

    _id_C192239C59747190 = (_id_C192239C59747190 + 1) % level.br_pickups.crates.size;
    crate = level.br_pickups.crates[_id_C192239C59747190];

    if(!isDefined(crate)) {
      level.br_pickups.crates = scripts\engine\utility::array_removeundefined(level.br_pickups.crates);
      waitframe();
      continue;
    }

    if(isDefined(crate.team)) {
      numuses = 0;

      if(isDefined(crate.numuses))
        numuses = crate.numuses;

      if(numuses >= level.teamdata[crate.team]["teamCount"]) {
        crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        waitframe();
        continue;
      }
    }

    waitframe();
  }
}

_id_B90101A9DB963BD1(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;
  _id_C434624FF361BBA2 = _id_52D59C928EB97C81 * _id_52D59C928EB97C81;

  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate)) {
      continue;
    }
    _id_E4E4AE4481958D2E = distance2dsquared(crate.origin, _id_819EDACDACB810E4) + level._id_53C0FA66001CFF52 > _id_C434624FF361BBA2;

    if(_id_E4E4AE4481958D2E)
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

_id_26A4C7CF6DA4E2C0() {
  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate)) {
      continue;
    }
    _id_E4E4AE4481958D2E = !_id_58F20490049AF6AC::_id_EE854FDD1E77EFC4(crate.origin, level._id_53C0FA66001CFF52);
    _id_8724C89E365130A7 = _id_58F20490049AF6AC::_id_A465E3C1371D7DAB(crate.origin);

    if(_id_E4E4AE4481958D2E && !_id_8724C89E365130A7)
      crate thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

cleanupallbutxcratesforteam(team, _id_A3F2F28D570440EB) {
  _id_52190E94BA536878 = [];

  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != team) {
      continue;
    }
    _id_52190E94BA536878[_id_52190E94BA536878.size] = crate;
  }

  _id_6E95FA22AAD7C8A5 = _id_52190E94BA536878.size - _id_A3F2F28D570440EB;

  if(_id_6E95FA22AAD7C8A5 <= 0) {
    return;
  }
  for(index = _id_6E95FA22AAD7C8A5 - 1; index >= 0; index--) {
    _id_4F7EC11230295C92 = _id_52190E94BA536878[index];
    _id_4F7EC11230295C92 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }
}

_id_B4255B6F102B056D(_id_26784414A3B75D58) {
  _id_68E6F05A4EE24DEE = physics_createcontents(["physicscontents_water", "physicscontents_playerclip"]);
  _id_7C89350C1BCAC4F0 = _id_26784414A3B75D58 + (0, 0, 100);
  _id_66D7B2C988606651 = _id_7C89350C1BCAC4F0 + (0, 0, -10000);
  _id_E021C2744CC7ED68 = physics_raycast(_id_7C89350C1BCAC4F0, _id_66D7B2C988606651, _id_68E6F05A4EE24DEE, undefined, 0, "physicsquery_closest");

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    _id_23892B9AB76D2BF3 = _id_E021C2744CC7ED68[0]["surfaceflags"];
    _id_4B5A75D5223543C8 = physics_getsurfacetypefromflags(_id_23892B9AB76D2BF3);
    _id_2B9C39598D19EA34 = _id_4B5A75D5223543C8["name"];

    if(isstartstr(_id_2B9C39598D19EA34, "surftype_water"))
      return 1;
  }

  return 0;
}

spawndropbagatposition(pos, _id_ADD790A95B329400) {
  cleanupallbutxcratesforteam(self.team, 1);
  crate = scripts\cp_mp\killstreaks\airdrop::dropbrloadoutcrate(self.team, pos + (0, 0, 4096), pos + (0, 0, 512));
  crate endon("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("redeploy_drone", "dropbag_collision_watcher"))
    crate thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("redeploy_drone", "dropbag_collision_watcher")]]();

  if(_id_1E4A61DB11011446::_id_374B5EC4199E8B21()) {
    crate setscriptablepartstate("objective_map", "custom");
    crate._id_7B5E5C2BBC8F9F79 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(crate._id_7B5E5C2BBC8F9F79 > -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(crate._id_7B5E5C2BBC8F9F79, "current", crate.origin, "ui_map_icon_drop_loadout");

      if(isDefined(crate.team)) {
        objective_removeallfrommask(crate._id_7B5E5C2BBC8F9F79);
        objective_showtoplayersinmask(crate._id_7B5E5C2BBC8F9F79);
        objective_addteamtomask(crate._id_7B5E5C2BBC8F9F79, crate.team);
        objective_setbackground(crate._id_7B5E5C2BBC8F9F79, 1);
      }

      objective_onentity(crate._id_7B5E5C2BBC8F9F79, crate);
      objective_setzoffset(crate._id_7B5E5C2BBC8F9F79, 70);
      crate thread _id_164A7AA37EA0F8DD();
    }
  } else {
    crate._id_ADD790A95B329400 = _id_ADD790A95B329400;
    enabledropbagobjective(crate, _id_ADD790A95B329400);
  }

  choosedropbagmodel(crate);
  _id_3BE0D54D30A3593C = [];

  foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {
    if(isDefined(_id_F0EA4030349A33D5) && !_id_F0EA4030349A33D5 _id_2CEDCC356F1B9FC8::isplayeringulag()) {
      _id_3BE0D54D30A3593C[_id_3BE0D54D30A3593C.size] = _id_F0EA4030349A33D5;

      if(_id_ADD790A95B329400 == 1) {
        _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_airdrop_incoming_squad");
        continue;
      }

      _id_F0EA4030349A33D5 thread scripts\mp\hud_message::showsplash("br_airdrop_incoming");
    }
  }

  if(!_id_2CEDCC356F1B9FC8::istutorial())
    _id_2CEDCC356F1B9FC8::brleaderdialogteam("dropbag_incoming", self.team, 1, 0, undefined, "dx_br_dmzc_");

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_715028F54BAD19A1::branalytics_dropbagdeployed(self, pos, _id_ADD790A95B329400, crate);
}

_id_164A7AA37EA0F8DD() {
  level endon("game_ended");
  self waittill("death");
  scripts\mp\objidpoolmanager::returnobjectiveid(self._id_7B5E5C2BBC8F9F79);
}

spawndropbagsovertime(playerlist) {
  foreach(player in playerlist) {
    if(!isDefined(player)) {
      continue;
    }
    position = player.precomputeddropbagpos;

    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
      circleradius = _id_2695A20D4011076D::getsafecircleradius();

      if(distance2dsquared(circleorigin, position) > circleradius * circleradius) {
        _id_6CC1148E1D19E91E = vectorNormalize(position - circleorigin);
        _id_9A3F472A9B9F9A95 = circleorigin + _id_6CC1148E1D19E91E * circleradius * 0.95;

        if(isnavmeshloaded())
          position = getclosestpointonnavmesh(_id_9A3F472A9B9F9A95);
        else
          position = _id_9A3F472A9B9F9A95;
      }

      if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
        circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
        _id_9A3F472A9B9F9A95 = _id_45B2B4A889E633FA::snappointtooutofboundstriggertrace(circleorigin, position);

        if(isnavmeshloaded())
          position = getclosestpointonnavmesh(_id_9A3F472A9B9F9A95);
        else
          position = _id_9A3F472A9B9F9A95;
      }
    }

    if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
      if(_id_B4255B6F102B056D(position)) {
        if(isnavmeshloaded())
          position = getclosestpointonnavmesh(position);
        else if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
          circleorigin = _id_2695A20D4011076D::getsafecircleorigin();
          position = circleorigin;
        }
      }
    }

    _id_902BF0AE43F091D9 = getdropbagspawntypeenum(0, 1, 0, 0, 0, 0);

    if(getdvarint("dvar_589C7488B192CB36", 0) == 1)
      _id_902BF0AE43F091D9 = getdropbagspawntypeenum(1, 0, 0, 0, 0, 0);

    player spawndropbagatposition(position, _id_902BF0AE43F091D9);
    waitframe();
  }
}

spawndropbagonlanding() {
  choosenlocation = undefined;
  choosenlocation = findunuseddropbaglocation(self);

  if(!isDefined(choosenlocation)) {
    _id_2827E1B47AE2AB6E = getdvarfloat("scr_dropbag_mindist", 3000);
    _id_DEEEF4B8CB10CAE0 = getdvarfloat("scr_dropbag_maxdist", 7000);
    choosenlocation = calculatedroplocationnearlocation(self, _id_2827E1B47AE2AB6E, _id_DEEEF4B8CB10CAE0);
  }

  if(isDefined(choosenlocation)) {
    _id_D20DE36666A6D60A = getdropbagspawntypeenum(0, 0, 0, 0, 1, 0);
    spawndropbagatposition(choosenlocation.origin, _id_D20DE36666A6D60A);
    level thread managedropbags();
  }
}

findunuseddropbaglocation(player) {
  _id_16ADD9D62303E2D6 = [];
  _id_2827E1B47AE2AB6E = getdvarfloat("scr_dropbag_mindist", 3000);
  _id_DEEEF4B8CB10CAE0 = getdvarfloat("scr_dropbag_maxdist", 7000);
  _id_4F0FC1C36324AFFB = _id_2827E1B47AE2AB6E * _id_2827E1B47AE2AB6E;
  _id_CDC5DD6C28C9709D = _id_DEEEF4B8CB10CAE0 * _id_DEEEF4B8CB10CAE0;

  foreach(_id_3402D60C1EF6B931 in level.dropbagstruct.clusters) {
    _id_D2E4BDDEDDC9B4F9 = distance2dsquared(player.origin, _id_3402D60C1EF6B931.origin);

    if(_id_D2E4BDDEDDC9B4F9 >= _id_4F0FC1C36324AFFB && _id_D2E4BDDEDDC9B4F9 <= _id_CDC5DD6C28C9709D)
      _id_16ADD9D62303E2D6[_id_16ADD9D62303E2D6.size] = _id_3402D60C1EF6B931;
  }

  if(_id_16ADD9D62303E2D6.size == 0)
    return undefined;

  _id_16ADD9D62303E2D6 = scripts\engine\utility::array_randomize(_id_16ADD9D62303E2D6);
  _id_106AC5FC8E31EC9F = 0;

  foreach(_id_3402D60C1EF6B931 in _id_16ADD9D62303E2D6) {
    _id_D6D0D0AB47B5B334 = scripts\engine\utility::array_randomize(_id_3402D60C1EF6B931.droplocations);

    foreach(location in _id_D6D0D0AB47B5B334) {
      if(!location.inuse) {
        location.inuse = 1;
        return location;
      }
    }
  }

  return undefined;
}

enabledropbagobjective(crate, _id_06884559161F6021) {
  crate setotherent(self);

  if(_id_06884559161F6021 == 1)
    crate setscriptablepartstate("objective", "active_squad");
  else
    crate setscriptablepartstate("objective", "active");

  crate._id_83746F6469687186 = 1;
}

_id_4587A2683D863277(crate) {
  if(crate._id_ADD790A95B329400 == 1)
    crate setscriptablepartstate("objective", "active_squad");
  else
    crate setscriptablepartstate("objective", "active");

  crate._id_83746F6469687186 = 1;
}

disabledropbagobjective(crate) {
  crate setscriptablepartstate("objective", "inactive");
  crate._id_83746F6469687186 = 0;
}

choosedropbagmodel(crate) {
  crate setotherent(self);
  crate setscriptablepartstate("model", "choose");
}

delaydropbags(_id_70BCBF0AD5028219) {
  level endon("game_ended");
  _id_BDB5D362355F04D0 = 0;

  foreach(_id_04400D6A8D876BD9 in _id_70BCBF0AD5028219) {
    waittime = _id_04400D6A8D876BD9 - _id_BDB5D362355F04D0;

    if(waittime > 0)
      wait(waittime);

    _id_BDB5D362355F04D0 = _id_04400D6A8D876BD9;
    precomputedropbagpositions(0);
  }
}

allowreuseofalldropbags() {
  if(_id_362C58E8BB39BCDA::isfeaturedisabled("dropbag")) {
    return;
  }
  foreach(crate in level.br_pickups.crates) {
    if(!isDefined(crate) || !isDefined(crate.team) || crate.team != self.team) {
      continue;
    }
    _id_C9DBA2970D4506FC = isDefined(crate.playerscaptured) && isDefined(crate.playerscaptured[self getentitynumber()]);

    if(_id_C9DBA2970D4506FC) {
      crate.playerscaptured[self getentitynumber()] = undefined;

      for(index = 0; index < crate.playersused.size; index++) {
        if(isDefined(crate.playersused[index]) && crate.playersused[index] == self)
          crate.playersused[index] = undefined;
      }

      crate.playersused = scripts\engine\utility::array_removeundefined(crate.playersused);
      crate.numuses--;
    }

    if(!istrue(crate._id_83746F6469687186))
      _id_4587A2683D863277(crate);
  }
}

onplayerrespawn() {
  allowreuseofalldropbags();
}

getdropbagspawntypeenum(_id_DBE2A1D0A7766CFC, _id_EF7A6A300EBF9493, _id_E648E96614161011, _id_283B7B1C42AB77DE, _id_FC0B9EAB91A21B10, _id_56F78457D5BFBAC6) {
  if(istrue(_id_DBE2A1D0A7766CFC))
    return 0;

  if(istrue(_id_EF7A6A300EBF9493))
    return 1;

  if(istrue(_id_E648E96614161011))
    return 1;

  if(istrue(_id_283B7B1C42AB77DE))
    return 2;

  if(istrue(_id_FC0B9EAB91A21B10))
    return 3;

  if(istrue(_id_56F78457D5BFBAC6))
    return 4;

  return -1;
}

testmissionrewards() {
  runmissionrewarddelivery(level.players[0], level.players[0], undefined, 3);
}

findclosestdroplocation(startlocation) {
  _id_206C7349DD628BC8 = startlocation scripts\engine\utility::array_sort_with_func(level.dropbagstruct.clusters, ::sortlocationsbydistance);

  foreach(_id_3402D60C1EF6B931 in _id_206C7349DD628BC8) {
    _id_D6D0D0AB47B5B334 = scripts\engine\utility::array_randomize(_id_3402D60C1EF6B931.droplocations);

    foreach(location in _id_D6D0D0AB47B5B334) {
      if(!location.inuse) {
        location.inuse = 1;
        return location;
      }
    }
  }

  return undefined;
}

sortlocationsbydistance(_id_0FCF7E6E6D8C4861, _id_0FCF7B6E6D8C41C8) {
  return distancesquared(_id_0FCF7E6E6D8C4861.origin, self.origin) < distancesquared(_id_0FCF7B6E6D8C41C8.origin, self.origin);
}

calculatedroplocationnearlocation(location, _id_636C8575D7A7768B, maxdist) {
  pos = location.origin;
  x = undefined;
  y = undefined;
  _id_8B591B0BC361AB3D = randomint(2);
  direction = scripts\engine\utility::ter_op(_id_8B591B0BC361AB3D, -1.0, 1.0);

  if(direction > 0) {
    x = randomfloatrange(pos[0] + _id_636C8575D7A7768B * direction, pos[0] + maxdist * direction);

    if(x >= level.br_level.br_mapbounds[0][0])
      x = level.br_level.br_mapbounds[0][0] - 250;
  } else {
    x = randomfloatrange(pos[0] + maxdist * direction, pos[0] + _id_636C8575D7A7768B * direction);

    if(x <= level.br_level.br_mapbounds[1][0])
      x = level.br_level.br_mapbounds[1][0] + 250;
  }

  _id_8B591B0BC361AB3D = randomint(2);
  direction = scripts\engine\utility::ter_op(_id_8B591B0BC361AB3D, -1.0, 1.0);

  if(direction > 0) {
    y = randomfloatrange(pos[1] + _id_636C8575D7A7768B * direction, pos[1] + maxdist * direction);

    if(y >= level.br_level.br_mapbounds[0][1])
      y = level.br_level.br_mapbounds[0][1] - 250;
  } else {
    y = randomfloatrange(pos[1] + maxdist * direction, pos[1] + _id_636C8575D7A7768B * direction);

    if(y <= level.br_level.br_mapbounds[1][1])
      y = level.br_level.br_mapbounds[1][1] + 250;
  }

  if(isnavmeshloaded()) {
    _id_E24929C0E254D7B4 = getclosestpointonnavmesh((x, y, pos[2]));

    if(isDefined(_id_E24929C0E254D7B4)) {
      _id_76A22C18960F72AF = spawnStruct();
      _id_76A22C18960F72AF.origin = _id_E24929C0E254D7B4;
      return _id_76A22C18960F72AF;
    }
  }

  _id_76A22C18960F72AF = spawnStruct();
  _id_76A22C18960F72AF.origin = (x, y, pos[2]);
  return _id_76A22C18960F72AF;
}

debugsphereonlocation(origin) {}

maskobjectivetoplayerssquad(objective, _id_9C34764B7D5AC247) {
  objective.visibilitymanuallycontrolled = 1;
  objective_removeallfrommask(objective.objidnum);

  foreach(player in level.squaddata[_id_9C34764B7D5AC247.team][_id_9C34764B7D5AC247._id_0FF97225579DE16A].players)
  objective_addclienttomask(objective.objidnum, player);
}