/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_41a5f0bf29408720.gsc
***********************************************/

_id_764239E6A246C46A() {
  _id_FE7E82F6D37CDA80 = [];
  _id_FE7E82F6D37CDA80["shouldRun"] = ::_id_DCBFF0F91B68341D;
  _id_FE7E82F6D37CDA80["init"] = ::_id_DB991B1EC8386695;
  _id_FE7E82F6D37CDA80["enableForClient"] = ::_id_4999A7FD384D2FB4;
  _id_FE7E82F6D37CDA80["disable"] = ::_id_11F7A27364A8B75D;
  _id_FE7E82F6D37CDA80["checkForDataUpdates"] = ::_id_5D19D3F8062E4BEE;
  _id_FE7E82F6D37CDA80["getADSWeaponDist"] = ::_id_553772F1F998AA41;
  _id_FE7E82F6D37CDA80["getTargetArray"] = ::_id_6BE4502BDBD97C85;
  _id_FE7E82F6D37CDA80["outlineOccluded"] = ::_id_E392446751B714F6;
  return _id_FE7E82F6D37CDA80;
}

_id_DCBFF0F91B68341D() {
  return 1;
}

_id_DB991B1EC8386695() {
  level thread _id_72F2B775F465B38D();
}

_id_72F2B775F465B38D() {
  level endon("game_ended");
  wait 5;
  _id_6BFE39BD5C12F84A::_id_7068F93AACF2EF59("kiosk_objective", "uin_ping_buy_station");
}

_id_4999A7FD384D2FB4(_id_2C6CA80E296FED3A, assetname, prioritygroup) {
  return scripts\cp\cp_outline_utility::outlineenableforplayer(self, _id_2C6CA80E296FED3A, assetname, prioritygroup);
}

_id_11F7A27364A8B75D(id) {
  scripts\cp\cp_outline_utility::outlinedisable(id, self);
}

_id_553772F1F998AA41() {
  weapon = self getcurrentweapon();

  if(weaponclass(weapon) == "sniper")
    return 8192;

  return 2048;
}

_id_6BE4502BDBD97C85(_id_2C6CA80E296FED3A) {
  _id_DA96C8943126A950 = getaiarray();
  players = level.players;
  return scripts\engine\utility::array_combine(players, _id_DA96C8943126A950);
}

_id_E392446751B714F6(startpoint, endpoint) {
  return scripts\cp\cp_outline_utility::outlineoccluded(startpoint, endpoint);
}

_id_5D19D3F8062E4BEE() {
  for(;;) {
    wait 1;

    if(!isDefined(level.players)) {
      continue;
    }
    foreach(player in level.players) {
      _id_D1B436910914F40E = player getplayerdata(level.loadoutsgroup, "squadMembers", "highVisibilityMode");

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

_id_1871237039503CA1() {
  while(level.players.size == 0)
    wait 1;

  wait 5;

  foreach(player in level.players)
  player _id_971B12CE83D4D457();
}

_id_971B12CE83D4D457() {
  self setblurforplayer(5, 1);
}

_id_68FCFF86246CB0E8() {}