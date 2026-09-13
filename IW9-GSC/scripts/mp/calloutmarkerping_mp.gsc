/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\calloutmarkerping_mp.gsc
***********************************************/

calloutmarkerping_init() {
  scripts\cp_mp\calloutmarkerping::calloutmarkerping_initcommon();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(scripts\cp_mp\calloutmarkerping::calloutmarkerping_onplayerdisconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer", ::calloutmarkerping_squadleaderbeaconkillforplayer);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_watchItemTakenFromContainer", ::_id_46B859BD05600A10);
  scripts\cp_mp\utility\script_utility::registersharedfunc("container", "isContainerEmpty", scripts\mp\loot::_id_23A3BB1172216C05);
  scripts\cp_mp\utility\script_utility::registersharedfunc("container", "getIndexForLootIDInContainer", scripts\mp\loot::_id_EA8078BE364FF10F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("container", "getLoadoutDoubleBackpackLootID", scripts\mp\loot::_id_4DF382B17698F0C5);
  scripts\cp_mp\utility\script_utility::registersharedfunc("container", "getLootIDAtContainerIndex", scripts\mp\loot::_id_F478CA9D3C44018C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("loot", "lootGetScriptableName", _id_7E52B56769FA7774::_id_155B1A2C8879BDA5);
}

calloutmarkerping_squadleaderbeaconcreate(_id_6E5DCC903725AD78) {}

calloutmarkerping_squadleaderbeaconplayerfirstlanded() {
  player = self;

  if(!getdvarint("dvar_317946383876293F", 0)) {
    return;
  }
  if(!istrue(player.squadleaderbeacon_isactive)) {
    return;
  }
  if(scripts\engine\utility::ispointinsidecircle(player.origin, player.squadleaderbeacon_circleorigin, player.squadleaderbeacon_circleradius)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup"))
      player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_beacon_bonus");
  }

  player.squadleaderbeacon_fxent delete();
  player.squadleaderbeacon_circleorigin = undefined;
  player.squadleaderbeacon_circleradius = undefined;
  player.squadleaderbeacon_isactive = undefined;
}

calloutmarkerping_squadleaderbeaconkillforplayer(player) {
  if(!getdvarint("dvar_317946383876293F", 0)) {
    return;
  }
  if(isDefined(player.squadleaderbeacon_fxent)) {
    player.squadleaderbeacon_fxent delete();
    player.squadleaderbeacon_circleorigin = undefined;
    player.squadleaderbeacon_circleradius = undefined;
    player.squadleaderbeacon_isactive = undefined;
  }
}

_id_46B859BD05600A10(player, _id_69E96A4CAA72D794, lootid) {
  if(!isDefined(player) || !isDefined(_id_69E96A4CAA72D794) || !isDefined(lootid)) {
    return;
  }
  player endon("death_or_disconnect");
  _id_69E96A4CAA72D794 endon("death");
  _id_D54A79024C228770 = undefined;
  _id_BF23A60678978C19 = undefined;

  for(;;) {
    if(!isDefined(_id_69E96A4CAA72D794) || !isDefined(_id_69E96A4CAA72D794.contents)) {
      return;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("container", "isContainerEmpty") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("container", "isContainerEmpty")]](_id_69E96A4CAA72D794)) {
      return;
    }
    if(!isDefined(_id_69E96A4CAA72D794.opener)) {
      waitframe();
      continue;
    }

    if(!isDefined(_id_D54A79024C228770) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("container", "getIndexForLootIDInContainer"))
      [_id_D54A79024C228770, _id_BF23A60678978C19] = [[scripts\cp_mp\utility\script_utility::getsharedfunc("container", "getIndexForLootIDInContainer")]](_id_69E96A4CAA72D794, lootid);

    if(!isDefined(_id_D54A79024C228770) || !isDefined(_id_BF23A60678978C19)) {
      return;
    }
    _id_699DE62155C8C832 = undefined;

    if(istrue(_id_BF23A60678978C19)) {
      if(_id_D54A79024C228770 == 100)
        _id_699DE62155C8C832 = _id_69E96A4CAA72D794._id_A06E7128C001851D;
      else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("container", "getLoadoutDoubleBackpackLootID"))
        _id_699DE62155C8C832 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("container", "getLoadoutDoubleBackpackLootID")]](_id_69E96A4CAA72D794, _id_D54A79024C228770, 0);

      if(!istrue(_id_699DE62155C8C832) || _id_699DE62155C8C832 != lootid)
        return;
    } else {
      if(_id_D54A79024C228770 == 100)
        _id_699DE62155C8C832 = _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7;
      else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("container", "getLootIDAtContainerIndex"))
        _id_699DE62155C8C832 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("container", "getLootIDAtContainerIndex")]](_id_69E96A4CAA72D794.opener, _id_D54A79024C228770, _id_69E96A4CAA72D794, 0);

      if(!istrue(_id_699DE62155C8C832) || _id_699DE62155C8C832 != lootid)
        return;
    }

    waitframe();
  }
}

_id_C28D94289C4A6ECD(scriptable, _id_1D4BC315E3007530) {
  player = self;

  if(!isDefined(scriptable))
    return 0;

  _id_54216530F9ADE838 = scripts\mp\utility\teams::getfriendlyplayers(player.team, 1);

  foreach(_id_B9F4F3092E5E6E9B in _id_54216530F9ADE838) {
    if(_id_B9F4F3092E5E6E9B != player) {
      if(_id_B9F4F3092E5E6E9B _meth_BEE315A15CF61820(scriptable.index)) {
        if(isDefined(_id_1D4BC315E3007530)) {
          _id_69E96A4CAA72D794 = scriptable;
          _id_394466C2DDB208CB = _id_B9F4F3092E5E6E9B scripts\cp_mp\calloutmarkerping::_id_76ECF74C7D722B52(5);

          if(isDefined(_id_394466C2DDB208CB)) {
            _id_41A4A181B6606B16 = _id_B9F4F3092E5E6E9B _meth_0A7E757D42B550A6(_id_394466C2DDB208CB);

            if(_id_41A4A181B6606B16 == 25) {
              _id_C876B325333C55A3 = _id_B9F4F3092E5E6E9B calloutmarkerping_getEnt(_id_394466C2DDB208CB);

              if(isDefined(_id_C876B325333C55A3) && _id_C876B325333C55A3.index == _id_69E96A4CAA72D794.index) {
                _id_75BC450AF3921C3B = _id_B9F4F3092E5E6E9B _meth_C4E0716FBD549E2D(_id_394466C2DDB208CB);

                if(isDefined(_id_75BC450AF3921C3B) && _id_75BC450AF3921C3B == _id_1D4BC315E3007530)
                  return 1;
              }
            }
          }
        } else
          return 1;
      }
    }
  }

  return 0;
}

_id_4864C58AB9B1F07E(scriptable, _id_0F0456519EAAE430) {
  player = self;

  if(!isDefined(scriptable))
    return 0;

  scriptablename = scriptable.type;

  if(isDefined(_id_0F0456519EAAE430) && _id_0F0456519EAAE430) {
    if(!isDefined(scriptable._id_1EEF5048F92C4951))
      return 0;

    _id_1EEF5048F92C4951 = scriptable._id_1EEF5048F92C4951;

    if(player == _id_1EEF5048F92C4951 || player.team != _id_1EEF5048F92C4951.team)
      return 0;
  }

  _id_DA07265F8351BD9E = player _meth_368AF07F7897FD79(5);

  if(!_id_DA07265F8351BD9E)
    return 0;

  _id_394466C2DDB208CB = player scripts\cp_mp\calloutmarkerping::_id_76ECF74C7D722B52(5);

  if(!isDefined(_id_394466C2DDB208CB))
    return 0;

  _id_41A4A181B6606B16 = player _meth_0A7E757D42B550A6(_id_394466C2DDB208CB);

  if(_id_41A4A181B6606B16 != 22 && _id_41A4A181B6606B16 != 23)
    return 0;

  _id_F45D3A6BD11D3F74 = player _meth_C4E0716FBD549E2D(_id_394466C2DDB208CB);

  if(!isDefined(_id_F45D3A6BD11D3F74))
    return 0;

  _id_1B715FD06C46C7C2 = 0;

  switch (_id_F45D3A6BD11D3F74) {
    case 16257:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::_id_B989EDD9AF4F42C7(scriptablename);
      break;
    case 16264:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::_id_D7C5786A0C42EF6C(scriptablename);
      break;
    case 16269:
    case 16265:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::isweaponpickup(scriptablename);
      break;
    case 16266:
      _id_1B715FD06C46C7C2 = _id_2CEDCC356F1B9FC8::isarmorplate(scriptablename);
      break;
    case 16267:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::_id_9E3428357E5DF2E3(scriptablename);
      break;
    case 16268:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::isplunder(scriptablename);
      break;
    case 16270:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::_id_82D45592D750D388(scriptablename);
      break;
    case 16271:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::issuperpickup(scriptablename);
      break;
    case 16272:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::iskillstreak(scriptablename);
      break;
    case 16273:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::isrevivepickup(scriptablename);
      break;
    case 16274:
      _id_1B715FD06C46C7C2 = _id_7E52B56769FA7774::isgasmask(scriptablename);
      break;
    default:
      if(_id_2CEDCC356F1B9FC8::isammo(scriptablename)) {
        _id_C7C80454A3D3E1E8 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

        if(isDefined(_id_C7C80454A3D3E1E8) && _id_C7C80454A3D3E1E8 == _id_F45D3A6BD11D3F74)
          _id_1B715FD06C46C7C2 = 1;
      } else if(_id_7E52B56769FA7774::isweaponpickup(scriptablename)) {
        weapon = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname(scriptablename);

        if(isDefined(weapon)) {
          ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon);

          if(isDefined(ammotype)) {
            _id_C7C80454A3D3E1E8 = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(ammotype);

            if(isDefined(_id_C7C80454A3D3E1E8) && _id_C7C80454A3D3E1E8 == _id_F45D3A6BD11D3F74)
              _id_1B715FD06C46C7C2 = 1;
          }
        }
      }

      break;
  }

  if(_id_1B715FD06C46C7C2)
    player scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(_id_394466C2DDB208CB);

  return _id_1B715FD06C46C7C2;
}