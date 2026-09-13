/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_17ff8fa860ec88dc.gsc
***********************************************/

_id_764239E6A246C46A() {
  _id_FE7E82F6D37CDA80 = [];
  _id_FE7E82F6D37CDA80["shouldRun"] = ::_id_DCBFF0F91B68341D;
  _id_FE7E82F6D37CDA80["enableForClient"] = ::_id_4999A7FD384D2FB4;
  _id_FE7E82F6D37CDA80["disable"] = ::_id_11F7A27364A8B75D;
  _id_FE7E82F6D37CDA80["checkForDataUpdates"] = ::_id_5D19D3F8062E4BEE;
  _id_FE7E82F6D37CDA80["getADSWeaponDist"] = ::_id_553772F1F998AA41;
  _id_FE7E82F6D37CDA80["getTargetArray"] = ::_id_6BE4502BDBD97C85;
  _id_FE7E82F6D37CDA80["outlineOccluded"] = ::_id_E392446751B714F6;
  return _id_FE7E82F6D37CDA80;
}

_id_DCBFF0F91B68341D() {
  level endon("game_ended");

  if(scripts\mp\utility\game::ismlgmatch())
    return 0;

  _id_988DCEC550DBC94E = scripts\mp\utility\game::privatematch() || level.systemlink;

  if(!_id_988DCEC550DBC94E)
    return 0;

  while(!isDefined(level.players) || level.players.size == 0)
    wait 0.05;

  wait 0.1;
  _id_2291FA3EF89A8550 = 0;

  while(!_id_2291FA3EF89A8550) {
    _id_2291FA3EF89A8550 = _id_2E2A6C022B5ED8DB();
    wait 3;
  }

  return _id_988DCEC550DBC94E && _id_2291FA3EF89A8550;
}

_id_2E2A6C022B5ED8DB() {
  _id_2291FA3EF89A8550 = 0;

  foreach(player in level.players) {
    if(player ishost()) {
      _id_D1B436910914F40E = _id_7BCB4B0B404DC8A8(player);

      if(isDefined(_id_D1B436910914F40E) && _id_D1B436910914F40E > 0)
        _id_2291FA3EF89A8550 = 1;

      break;
    }
  }

  return _id_2291FA3EF89A8550;
}

_id_4999A7FD384D2FB4(_id_2C6CA80E296FED3A, assetname, prioritygroup) {
  return scripts\mp\utility\outline::outlineenableforplayer(self, _id_2C6CA80E296FED3A, assetname, prioritygroup);
}

_id_11F7A27364A8B75D(id) {
  scripts\mp\utility\outline::outlinedisable(id, self);
}

_id_553772F1F998AA41() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "sniper")
    return 8192;

  return 2048;
}

_id_6BE4502BDBD97C85(_id_2C6CA80E296FED3A) {
  _id_54216530F9ADE838 = scripts\mp\utility\teams::getfriendlyplayers(_id_2C6CA80E296FED3A.team);
  _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(_id_2C6CA80E296FED3A.team);
  _id_DA96C8943126A950 = getaiarray();
  return scripts\engine\utility::array_combine(_id_54216530F9ADE838, _id_024AECB67BB3A207, _id_DA96C8943126A950);
}

_id_E392446751B714F6(startpoint, endpoint) {
  return scripts\mp\utility\outline::outlineoccluded(startpoint, endpoint);
}

_id_5D19D3F8062E4BEE() {
  for(;;) {
    wait 1;

    if(!isDefined(level.players)) {
      continue;
    }
    foreach(player in level.players) {
      _id_D1B436910914F40E = _id_7BCB4B0B404DC8A8(player);

      if(isDefined(_id_D1B436910914F40E)) {
        if(isDefined(player._id_B1D7DCA915C8EB6D)) {
          if(_id_D1B436910914F40E != player._id_B1D7DCA915C8EB6D)
            player _id_6BFE39BD5C12F84A::_id_8C2E8285C9915B12(_id_D1B436910914F40E);

          continue;
        }

        player _id_6BFE39BD5C12F84A::_id_8C2E8285C9915B12(_id_D1B436910914F40E);
      }
    }
  }
}

_id_7BCB4B0B404DC8A8(player) {
  _id_D1B436910914F40E = player getplayerdata(level.loadoutsgroup, "squadMembers", "highVisibilityMode");
  return _id_D1B436910914F40E;
}