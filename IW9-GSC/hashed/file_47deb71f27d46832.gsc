/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_47deb71f27d46832.gsc
***********************************************/

init() {
  level._id_21B6EAFDC9B89B24 = getdvarint("scr_br_playtest_tool_phoenix", 0);
  level._id_81699AA174DD5A52 = getdvarint("dvar_10D7B61BFF0B17A3", 1);

  if(!istrue(getdvarint("dlog_is_playtest", 0))) {
    return;
  }
  level thread _id_21B6EAFDC9B89B24();
  level thread _id_81699AA174DD5A52();
}

_id_21B6EAFDC9B89B24() {
  if(!level._id_21B6EAFDC9B89B24) {
    return;
  }
  level endon("game_ended");
  wait 10;

  for(;;) {
    _id_87F59B7E34EA1556 = "";
    _id_864DB7311B329A5B = 0;

    for(;;) {
      _id_87F59B7E34EA1556 = getDvar("dvar_8B0A93B6B93B8800");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_8B0A93B6B93B8800", "");
        _id_864DB7311B329A5B = 1;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_0DCBB0A9EE95AE26");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_0DCBB0A9EE95AE26", "");
        _id_864DB7311B329A5B = 2;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_5752F63F26AB4917");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_5752F63F26AB4917", "");
        _id_864DB7311B329A5B = 3;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_A592A729D729C65A");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_A592A729D729C65A", "");
        _id_864DB7311B329A5B = 4;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_BC15D9396473711B");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_BC15D9396473711B", "");
        _id_864DB7311B329A5B = 5;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_5556CA8EEEED2341");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_5556CA8EEEED2341", "");
        _id_864DB7311B329A5B = 6;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_0B18CA3F4DA7B911");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_0B18CA3F4DA7B911", "");
        _id_864DB7311B329A5B = 7;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_668AADA014B1731F");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_668AADA014B1731F", "");
        _id_864DB7311B329A5B = 8;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_FE237CA99386656B");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_FE237CA99386656B", "");
        _id_864DB7311B329A5B = 9;
        break;
      }

      _id_87F59B7E34EA1556 = getDvar("dvar_9D6F9499C51C772D");

      if(_id_87F59B7E34EA1556 != "") {
        setDvar("dvar_9D6F9499C51C772D", "");
        _id_864DB7311B329A5B = 10;
        break;
      }

      wait 0.5;
    }

    _id_9DBFA659B21102E3 = strtok(_id_87F59B7E34EA1556, getDvar("dvar_C72DAF352FF527F5", "^P^"));
    _id_93CDBA842F067FEE = tolower(getDvar("scr_br_redeploy_playtester"));

    if(_id_C7A92F961200261C(_id_93CDBA842F067FEE, _id_9DBFA659B21102E3[0])) {
      foreach(player in level.players) {
        if(issubstr(tolower(player.name), tolower(_id_9DBFA659B21102E3[0]))) {
          if(!isDefined(player._id_23D753FB0A1F6D0C))
            player._id_23D753FB0A1F6D0C = 0;

          player._id_23D753FB0A1F6D0C++;

          switch (_id_864DB7311B329A5B) {
            case 1:
              player thread _id_8AFDB2A6D45E4E52(_id_9DBFA659B21102E3[1]);
              break;
            case 2:
              player _id_469CA703F3BBF800();
              break;
            case 3:
              player _id_5C954A0E511B0FD4();
              break;
            case 4:
              player thread _id_B9DFEAEC51CC29BE();
              break;
            case 5:
              player thread _id_D3F145C1DBA935B3();
              break;
            case 6:
              player thread _id_59810F0834D29D33(_id_9DBFA659B21102E3[1]);
              break;
            case 7:
              player thread _id_37EAF21515EF583A();
              break;
            case 8:
              player _id_D34FDB063D216EF7(_id_9DBFA659B21102E3[1], _id_9DBFA659B21102E3[2]);
              break;
            case 9:
              player _id_40CF035B8D30CB57(_id_9DBFA659B21102E3[1]);
              break;
            case 10:
              player _id_6392DAD3AC3D32EE();
              break;
            default:
              break;
          }
        }
      }
    }
  }
}

_id_8AFDB2A6D45E4E52(_id_89D9AE99507076C3) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  foreach(_id_7B32D7CCDA8D42DB in level.players) {
    if(tolower(_id_7B32D7CCDA8D42DB.name) == tolower(_id_89D9AE99507076C3)) {
      _id_89D9AE99507076C3 = _id_7B32D7CCDA8D42DB;
      break;
    }

    if(issubstr(tolower(_id_7B32D7CCDA8D42DB.name), tolower(_id_89D9AE99507076C3))) {
      _id_89D9AE99507076C3 = _id_7B32D7CCDA8D42DB;
      break;
    }
  }

  if(isstring(_id_89D9AE99507076C3) || istrue(_id_89D9AE99507076C3._id_6873FB522FCD2866) || !istrue(level.br_prematchstarted)) {
    return;
  }
  _id_89D9AE99507076C3._id_6873FB522FCD2866 = 1;

  if(!isalive(_id_89D9AE99507076C3) && !_id_89D9AE99507076C3 _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    _id_F0EA4030349A33D5 = _id_89D9AE99507076C3;
    _id_6D5ED003AF1F9612 = level.teamdata[_id_89D9AE99507076C3.team]["players"];

    foreach(_id_AC0E424AC96A7113 in _id_6D5ED003AF1F9612) {
      if(_id_AC0E424AC96A7113 == _id_89D9AE99507076C3) {
        continue;
      }
      _id_F0EA4030349A33D5 = _id_AC0E424AC96A7113;
    }

    if(isDefined(_id_F0EA4030349A33D5)) {
      _id_F0EA4030349A33D5 = _id_6D5ED003AF1F9612[0];
      _id_F0EA4030349A33D5 _id_7E52B56769FA7774::addrespawntoken(1);
      _id_89D9AE99507076C3 thread _id_67708F418B1FAC79::playergulagautowin("phoenix", _id_F0EA4030349A33D5, 1, 1);
      _id_89D9AE99507076C3 _id_911D879942B38A0A("phx_respawn");
      _id_22A8656C33A5530F = "redeploy_self";

      if(player != _id_89D9AE99507076C3)
        _id_22A8656C33A5530F = "redeploy_other";

      _id_89D9AE99507076C3 _id_0378C051E72D6871("redeploy", _id_22A8656C33A5530F, 1);
      player playlocalsound("ui_select_purchase_confirm");
    }
  } else {
    player playlocalsound("br_pickup_deny");
    _id_22A8656C33A5530F = "redeploy_self";

    if(player != _id_89D9AE99507076C3)
      _id_22A8656C33A5530F = "redeploy_other";

    _id_89D9AE99507076C3 _id_0378C051E72D6871("redeploy", _id_22A8656C33A5530F, 0);
  }

  wait 3;
  _id_89D9AE99507076C3._id_6873FB522FCD2866 = undefined;
}

_id_C7A92F961200261C(_id_93CDBA842F067FEE, _id_29AE84FFF122E2A6) {
  if(_id_93CDBA842F067FEE == "any")
    return 1;
  else {
    _id_FC081BBE060BD007 = strtok(_id_93CDBA842F067FEE, " ");

    if(scripts\engine\utility::array_contains(_id_FC081BBE060BD007, tolower(_id_29AE84FFF122E2A6)))
      return 1;
  }

  _id_B36DB4E605C398D7 = level.players[0];

  foreach(player in level.players) {
    if(tolower(player.name) == tolower(_id_29AE84FFF122E2A6)) {
      _id_B36DB4E605C398D7 = player;
      break;
    }

    if(issubstr(tolower(player.name), tolower(_id_29AE84FFF122E2A6))) {
      _id_B36DB4E605C398D7 = player;
      break;
    }
  }

  _id_B36DB4E605C398D7 playlocalsound("br_pickup_deny");
  _id_B36DB4E605C398D7 _id_0378C051E72D6871("access_denied", "access_denied", 0);
  return 0;
}

_id_469CA703F3BBF800() {
  player = self;

  if(!isDefined(player.gulaguses))
    player.gulaguses = 0;

  player.gulaguses = player.gulaguses - 1;
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_add_gulag_try");
  player _id_0378C051E72D6871("add_gulag_use", "gulag_use_self", 1);
}

_id_5C954A0E511B0FD4() {
  player = self;
  params = [];
  params[params.size] = "clientID";
  params[params.size] = player.clientid;
  params[params.size] = "origin";
  params[params.size] = player.origin;
  params[params.size] = "session";
  params[params.size] = player.sessionstate;
  params[params.size] = "health";
  params[params.size] = player.health;
  params[params.size] = "armor";
  params[params.size] = player.armorhealth;
  params[params.size] = "currentWeapon";

  if(isDefined(player.currentweapon))
    params[params.size] = player.currentweapon.basename;
  else
    params[params.size] = "undefined";

  gulaguses = -1;

  if(isDefined(player.gulaguses))
    gulaguses = gulaguses + player.gulaguses;

  params[params.size] = "gulag_uses";
  params[params.size] = gulaguses;
  params[params.size] = "is_eliminated";
  params[params.size] = istrue(player.br_iseliminated);
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_player_info", params);
  player _id_0378C051E72D6871("print_log", "log_self", 1);
}

_id_B9DFEAEC51CC29BE() {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(player._id_9A5ECFF773217589)) {
    return;
  }
  player._id_9A5ECFF773217589 = 1;
  player.plotarmor = 1;
  player hudoutlineenableforclients(level.players, "outlinefill_depth_yellow");
  player _id_911D879942B38A0A("phx_afk");
  player _id_0378C051E72D6871("afk", "afk_self", 1);
  wait 10;
  player._id_9A5ECFF773217589 = undefined;
  player.plotarmor = undefined;
  player hudoutlinedisableforclient(player);
}

_id_D3F145C1DBA935B3() {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(player._id_E43E346A9BEA0F84)) {
    player playlocalsound("br_pickup_deny");
    return;
  }

  player._id_E43E346A9BEA0F84 = 1;
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_third_person");
  player _id_0378C051E72D6871("third_person", "third_person_self", 1);
  _id_176AABF0A43881DE = player.origin + (70, 0, 50);
  _id_C9FCF2EFAFE74B04 = player.origin + (0, 70, 50);
  _id_AEB098BDBDECFC16 = player.origin + (-70, 0, 50);
  _id_BE939C6230E8D9AE = player.origin + (0, -70, 50);
  camera = spawn("script_model", _id_176AABF0A43881DE);
  camera setModel("tag_origin");
  camera.angles = (0, -180, 0);
  player cameralinkTo(camera, "tag_origin", 1, 1);
  wait 3;
  camera moveTo(_id_C9FCF2EFAFE74B04, 2.8, 0.1, 0.1);
  camera rotateTo((0, -90, 0), 2.8, 0.1, 0.1);
  wait 2.9;
  camera moveTo(_id_AEB098BDBDECFC16, 2.8, 0.1, 0.1);
  camera rotateTo((0, 0, 0), 2.8, 0.1, 0.1);
  wait 2.9;
  camera moveTo(_id_BE939C6230E8D9AE, 2.8, 0.1, 0.1);
  camera rotateTo((0, 90, 0), 2.8, 0.1, 0.1);
  wait 3.5;
  player cameraunlink();
  camera delete();
  player._id_E43E346A9BEA0F84 = undefined;
}

_id_59810F0834D29D33(_id_FA11525E6C758D38) {
  player = self;
  player endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(player._id_DD0D54C21B4103E5)) {
    player playlocalsound("br_pickup_deny");
    return;
  }

  player._id_DD0D54C21B4103E5 = 1;

  switch (_id_FA11525E6C758D38) {
    case "buystation":
    case "stronghold":
    case "ai":
      player _id_02B80E02E445998E(_id_FA11525E6C758D38);
      break;
    case "heli":
    case "boat":
    case "car":
      player _id_4A1E9A264E6580A1(_id_FA11525E6C758D38);
      break;
    case "champions_quest":
    case "most_wanted":
    case "safecracker":
    case "bounty":
      player _id_E80A9A27F77F247D(_id_FA11525E6C758D38);
      break;
    case "player":
      player _id_4BCE3BCD181830C2(_id_FA11525E6C758D38);
      break;
    case "area":
      player _id_8368B4BAD19BB29E(_id_FA11525E6C758D38);
      break;
    case "air":
      player _id_7990EFCCF3B2E1CD();
      break;
    default:
      player playlocalsound("br_pickup_deny");
      break;
  }

  wait 3;
  player._id_DD0D54C21B4103E5 = undefined;
}

_id_02B80E02E445998E(_id_FA11525E6C758D38) {
  player = self;
  params = [];
  params[params.size] = "teleport_type";
  params[params.size] = "Objective";
  params[params.size] = "teleport_target";
  params[params.size] = _id_FA11525E6C758D38;
  params[params.size] = "success";

  switch (_id_FA11525E6C758D38) {
    case "buystation":
      if(isDefined(level.br_armory_kiosk) && level.br_armory_kiosk.scriptables.size > 0) {
        playerorigin = _id_C26886473593156D(level.br_armory_kiosk.scriptables, 100);
        player _id_5D369F91E522D2EE(playerorigin);
        params[params.size] = 1;
        player playlocalsound("ui_select_purchase_confirm");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "buystation", 1);
      } else {
        params[params.size] = 0;
        player playlocalsound("br_pickup_deny");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "buystation", 0);
      }

      break;
    case "stronghold":
      if(isDefined(level._id_F1073FBD45B59A06) && isDefined(level._id_F1073FBD45B59A06._id_DF987907A483DF89) && level._id_F1073FBD45B59A06._id_DF987907A483DF89.size > 0) {
        _id_603BC23AB555C5B9 = _id_C26886473593156D(level._id_F1073FBD45B59A06._id_DF987907A483DF89, 700);
        playerorigin = getclosestpointonnavmesh(_id_603BC23AB555C5B9);
        player _id_5D369F91E522D2EE(playerorigin);
        params[params.size] = 1;
        player playlocalsound("ui_select_purchase_confirm");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "stronghold", 1);
      } else {
        params[params.size] = 0;
        player playlocalsound("br_pickup_deny");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "stronghold", 0);
      }

      break;
    case "ai":
      agents = _func_7EB04CA16D045775("activeWarzone");

      if(isDefined(agents) && agents.size > 0) {
        playerorigin = _id_C26886473593156D(agents, 900);
        player _id_5D369F91E522D2EE(playerorigin);
        params[params.size] = 1;
        player playlocalsound("ui_select_purchase_confirm");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "active_wz", 1);
      } else {
        params[params.size] = 0;
        player playlocalsound("br_pickup_deny");
        player _id_911D879942B38A0A("phx_teleport", params);
        player _id_0378C051E72D6871("teleport", "active_wz", 0);
      }

      break;
    default:
      break;
  }
}

_id_C26886473593156D(_id_FEBA646AE86D7634, _id_5B63C63419C2942A) {
  if(istrue(level.br_circle_disabled)) {
    object = scripts\engine\utility::array_get_first_item(_id_FEBA646AE86D7634);
    playerorigin = object.origin + (0, 0, _id_5B63C63419C2942A);
    return playerorigin;
  }

  _id_66FC6C57CFA88EA2 = 1;
  playerorigin = scripts\engine\utility::random(_id_FEBA646AE86D7634).origin;
  _id_C4B448E975A0779B = 30;

  while(_id_66FC6C57CFA88EA2) {
    _id_C4B448E975A0779B--;

    if(_id_C4B448E975A0779B <= 0) {
      break;
    }

    playerorigin = scripts\engine\utility::random(_id_FEBA646AE86D7634).origin + (0, 0, _id_5B63C63419C2942A);

    if(_id_2695A20D4011076D::ispointincurrentsafecircle(playerorigin))
      _id_66FC6C57CFA88EA2 = 0;
  }

  return playerorigin;
}

_id_4A1E9A264E6580A1(_id_FA11525E6C758D38) {
  player = self;
  _id_DA3B728F470D7F11 = _id_0E0CF0A7580DADAE(_id_FA11525E6C758D38);
  playerorigin = _id_5850101116D3E6F7(_id_DA3B728F470D7F11);
  params = [];
  params[params.size] = "teleport_type";
  params[params.size] = "Vehicle";
  params[params.size] = "teleport_target";
  params[params.size] = _id_DA3B728F470D7F11;
  params[params.size] = "success";

  if(isDefined(playerorigin)) {
    player _id_5D369F91E522D2EE(playerorigin);
    params[params.size] = 1;
    player playlocalsound("ui_select_purchase_confirm");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 1);
  } else {
    params[params.size] = 0;
    player playlocalsound("br_pickup_deny");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 0);
  }
}

_id_5850101116D3E6F7(_id_FA11525E6C758D38) {
  player = self;
  playerorigin = undefined;

  if(isDefined(level.vehicle.instances)) {
    foreach(_id_7731ADEF63E19B0C, _id_E5CD5CE5EE8DC6C9 in level.vehicle.instances) {
      if(_id_7731ADEF63E19B0C == _id_FA11525E6C758D38) {
        playerorigin = _id_C26886473593156D(_id_E5CD5CE5EE8DC6C9, 90);
        return playerorigin;
      }
    }
  }
}

_id_E80A9A27F77F247D(_id_FA11525E6C758D38) {
  player = self;
  _id_5482880CC4EACF3F = _id_C3FCE0F247F1929A(_id_FA11525E6C758D38);
  playerorigin = _id_8DD2EB6B9D1C1AF3(_id_5482880CC4EACF3F);
  params = [];
  params[params.size] = "teleport_type";
  params[params.size] = "Contract";
  params[params.size] = "teleport_target";
  params[params.size] = _id_5482880CC4EACF3F;
  params[params.size] = "success";

  if(isDefined(playerorigin)) {
    player _id_5D369F91E522D2EE(playerorigin);
    params[params.size] = 1;
    player playlocalsound("ui_select_purchase_confirm");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 1);
  } else {
    params[params.size] = 0;
    player playlocalsound("br_pickup_deny");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 0);
  }
}

_id_8DD2EB6B9D1C1AF3(_id_FA11525E6C758D38) {
  player = self;
  playerorigin = undefined;

  if(isDefined(level._id_41F4BC9EE8C7C9C6.activetablets)) {
    foreach(tablet in level._id_41F4BC9EE8C7C9C6.activetablets) {
      if(tablet.type == _id_FA11525E6C758D38) {
        _id_DE5538C1E87E6BF7 = getclosestpointonnavmesh(tablet.origin);

        if(!istrue(level.br_circle_disabled) || _id_2695A20D4011076D::ispointincurrentsafecircle(_id_DE5538C1E87E6BF7))
          return _id_DE5538C1E87E6BF7;
      }
    }
  }
}

_id_C3FCE0F247F1929A(_id_FA11525E6C758D38) {
  switch (_id_FA11525E6C758D38) {
    case "bounty":
      return "brloot_assassination_phone";
    case "champions_quest":
      return "brloot_elite_arrow_phone";
    case "most_wanted":
      return "brloot_vip_phone";
    case "safecracker":
      return "brloot_safecracker_phone";
    case "intel":
      return "brloot_intel_phone";
    default:
      return "";
  }
}

_id_0E0CF0A7580DADAE(_id_FA11525E6C758D38) {
  switch (_id_FA11525E6C758D38) {
    case "car":
      return "veh9_sedan_hatchback_1985";
    case "boat":
      return "veh9_patrol_boat";
    case "heli":
      return "little_bird";
    case "armoredtruck":
      return "veh9_techo_rebel_armor";
    case "tank":
      return "veh9_apc_8x8";
    case "utv":
      return "veh9_utv";
    default:
      return "";
  }
}

_id_8368B4BAD19BB29E(_id_FA11525E6C758D38) {
  player = self;
}

_id_7990EFCCF3B2E1CD() {
  player = self;
  _id_FDFE2D4AAF8EC33D = scripts\cp_mp\parachute::getc130height();
  playerorigin = (player.origin[0], player.origin[1], _id_FDFE2D4AAF8EC33D);
  params = [];
  params[params.size] = "teleport_type";
  params[params.size] = "Air";
  params[params.size] = "teleport_target";
  params[params.size] = "Center Map";
  params[params.size] = "success";

  if(isDefined(playerorigin)) {
    player _id_5D369F91E522D2EE(playerorigin);
    params[params.size] = 1;
    _id_BDA1DE83E1856735 = 0;

    if(isDefined(level.parachutedeploydelay))
      _id_BDA1DE83E1856735 = level.parachutedeploydelay;

    player thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
    player playlocalsound("ui_select_purchase_confirm");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", "air", 1);
  } else {
    params[params.size] = 0;
    player playlocalsound("br_pickup_deny");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", "air", 0);
  }
}

_id_4BCE3BCD181830C2(_id_FA11525E6C758D38) {
  player = self;
  params = [];
  params[params.size] = "teleport_type";
  params[params.size] = "Player";
  params[params.size] = "teleport_target";
  params[params.size] = _id_FA11525E6C758D38;
  params[params.size] = "success";
  _id_82106BB7416E62D0 = undefined;

  foreach(_id_AC0E424AC96A7113 in level.players) {
    if(tolower(_id_AC0E424AC96A7113.name) == tolower(_id_FA11525E6C758D38)) {
      _id_82106BB7416E62D0 = _id_AC0E424AC96A7113;
      break;
    }

    if(issubstr(tolower(_id_AC0E424AC96A7113.name), tolower(_id_FA11525E6C758D38))) {
      _id_82106BB7416E62D0 = _id_AC0E424AC96A7113;
      break;
    }
  }

  if(isDefined(_id_82106BB7416E62D0)) {
    _id_DE5538C1E87E6BF7 = getclosestpointonnavmesh(_id_82106BB7416E62D0.origin + (50, 50, 0));
    player _id_5D369F91E522D2EE(_id_DE5538C1E87E6BF7);
    params[params.size] = 1;
    player playlocalsound("ui_select_purchase_confirm");
    player _id_911D879942B38A0A("phx_teleport", params);
    player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 1);
    return;
  }

  params[params.size] = 0;
  player playlocalsound("br_pickup_deny");
  player _id_911D879942B38A0A("phx_teleport", params);
  player _id_0378C051E72D6871("teleport", _id_FA11525E6C758D38, 0);
}

_id_5D369F91E522D2EE(location) {
  player = self;
  player setpredictedstreamloaddist(0.0);
  player _id_2CEDCC356F1B9FC8::playerstreamhintlocation(location);
  player setOrigin(location, 1, 1);
}

_id_37EAF21515EF583A() {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(istrue(player._id_A51C65A939FD8BB0) || !istrue(level.br_prematchstarted)) {
    player playlocalsound("br_pickup_deny");
    return;
  }

  if(!isalive(player) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag()) {
    _id_F0EA4030349A33D5 = player;
    _id_6D5ED003AF1F9612 = level.teamdata[player.team]["players"];

    foreach(_id_AC0E424AC96A7113 in _id_6D5ED003AF1F9612) {
      if(_id_AC0E424AC96A7113 == player) {
        continue;
      }
      _id_F0EA4030349A33D5 = _id_AC0E424AC96A7113;
    }

    if(isDefined(_id_F0EA4030349A33D5)) {
      _id_F0EA4030349A33D5 = _id_6D5ED003AF1F9612[0];
      _id_F0EA4030349A33D5 _id_7E52B56769FA7774::addrespawntoken(1);
      player thread _id_67708F418B1FAC79::playergulagautowin("phoenix", _id_F0EA4030349A33D5, 1, 1);
      wait 8;

      if(!isDefined(player))
        return;
    }
  }

  player._id_A51C65A939FD8BB0 = 1;
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_spectator");
  player _id_0378C051E72D6871("spectator", "spectator_self", 1);

  if(isDefined(level.parachuterestoreweaponscb))
    player[[level.parachuterestoreweaponscb]]();

  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113(1);
  player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_dev_phoenix::phoenix_spectator()");
  player sethidenameplate(1);
  player setthreatbiasgroup();
  _id_D088B204F6DDD806 = player.origin;
  _id_CDC9BEE1ECFE4526 = player;
  uavtype = "directional_uav";
  _id_E20E6E6EBDA4CEF5 = 1;
  _id_D1D51FC956008EA7 = 9999;
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("directional_uav", player);
  streakinfo.skipequippedstreakcheck = 1;
  scripts\cp_mp\killstreaks\uav::_id_36F7C24094D12C70(_id_D088B204F6DDD806, _id_CDC9BEE1ECFE4526, uavtype, streakinfo, _id_E20E6E6EBDA4CEF5, _id_D1D51FC956008EA7);
  _id_AEA051C033B84A83 = _id_02BDEFC4B5300716::_id_5F352FB76C54705C();
  _id_7A8B23E91AF57C28 = _id_160D0F1B81840667::_id_5F352FB76C54705C();

  if(_id_AEA051C033B84A83) {
    quests = _id_3ACF1C0EBAF602F2::getquestdata("assassination");
    _id_D88AABB60AB5A11D = undefined;

    if(isDefined(quests)) {
      foreach(instance in quests.instances) {
        if(instance.targetteam == player.team)
          _id_D88AABB60AB5A11D = instance;
      }
    }

    _id_D88AABB60AB5A11D _id_02BDEFC4B5300716::_id_319BA124F0EC457C(player);
  }

  if(_id_7A8B23E91AF57C28)
    player thread _id_160D0F1B81840667::_id_761664D012E7F359(0);

  player.gulaguses = 50;
  player.plotarmor = 1;
  _id_0A34750D17473C49::markplayeraseliminated(player, "phoenix_spectator");
  player scripts\mp\playerlogic::removefromlivescount();
  _id_1E4A61DB11011446::shutdowngulagforalivecount();
  [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player _id_1E4A61DB11011446::calculatebrbonusxp(150, player.team);

  if(_id_B5D67493FB854F58 > 0) {
    player _id_1E4A61DB11011446::givebrbonusxp(_id_B5D67493FB854F58, undefined, "disconnect");
    player.matchbonus = _id_1B70C48B930405F0;
    player.placementbonus = _id_D6A23FDABD1D282C;
  }

  player _id_7E52B56769FA7774::droponplayerdeath();
  player _id_1E4A61DB11011446::setplacementstats(150);
  player _id_1E4A61DB11011446::stopchallengetimers();
  scripts\mp\gamelogic::_setplayerteamrank(player, 150);
  _id_1E4A61DB11011446::updateclientmatchdata(player);
  level thread _id_1E4A61DB11011446::updateplayerandteamcountui();
  level notify("player_killed");
  player scripts\mp\playerlogic::removeplayerondisconnect();
  player scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
  player scripts\cp_mp\utility\game_utility::removefromcharactersarray();
  player scripts\cp_mp\utility\player_utility::removefromdismembermentlist();

  if(isDefined(player.team)) {
    player scripts\mp\playerlogic::removefromteamcount();

    if(scripts\engine\utility::array_contains(level.teamdata[player.team]["alivePlayers"], player)) {
      scripts\mp\playerlogic::removefromalivecount(1, "disconnect");
      scripts\mp\utility\teams::validatealivecount("disconnect", player.team, player);
    }
  }

  _id_3FF084F114B7F6C9::_id_BB4125D6847AF349(player, "permanent");

  if(level.gameended)
    player scripts\mp\gamescore::removedisconnectedplayerfromplacement();

  aliveplayers = scripts\mp\utility\teams::getteamdata(player.team, "alivePlayers");

  if(aliveplayers.size == 1) {
    thread _id_1E4A61DB11011446::onsquadeliminated(player.team);
    scripts\mp\gamelogic::default_ondeadevent(player.team);
  }
}

_id_D34FDB063D216EF7(_id_2CCB7355D3B3918C, _id_E8F056EE80DDBB44) {
  player = self;
  params = [];
  params[params.size] = "bug_text";
  params[params.size] = _id_E8F056EE80DDBB44;
  params[params.size] = "success";
  params[params.size] = 1;
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_report_bug", params);
  player _id_0378C051E72D6871("report_bug", "report_bug", 1);
  _func_DE33E306FB1C62E9(_id_2CCB7355D3B3918C, _id_E8F056EE80DDBB44);
}

_id_40CF035B8D30CB57(_id_5868B7D3B245CC07) {
  player = self;
  spawnpos = player.origin + anglesToForward(player.angles) * 80 + (0, 0, 12);
  [_id_4B4B03CC9E68B30A, _id_B20505170ABF9491] = _id_3BBC6D6A3335B93F(_id_5868B7D3B245CC07);

  if(_id_4B4B03CC9E68B30A == "") {
    player playlocalsound("br_pickup_deny");
    return;
  }

  _id_494DAFFF3D2C8E06 = 0;

  if(isDefined(level.br_pickups.counts[_id_4B4B03CC9E68B30A]))
    _id_494DAFFF3D2C8E06 = level.br_pickups.counts[_id_4B4B03CC9E68B30A];

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(spawnpos);

  if(_id_B20505170ABF9491 == "plunder") {
    item = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);
    item = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);
    item = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);
    item = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);
  }

  item = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, _id_494DAFFF3D2C8E06);

  if(_id_7E52B56769FA7774::_id_55F0DAEA8408E3A9(_id_4B4B03CC9E68B30A))
    _id_3AACF02225CA0DA5::_id_3E7EE85CB0D3504C(item);

  if(_id_7E52B56769FA7774::isquesttablet(_id_4B4B03CC9E68B30A))
    _id_64ACB6CE534155B7::_id_8A25384BACDD7B79(item, _id_4B4B03CC9E68B30A);

  if(isDefined(item)) {
    contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
    ignorelist = [];
    caststart = item.origin + (0, 0, 50);
    castend = caststart + (0, 0, -200);
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(isDefined(_id_1F0571D36D0DF95B["entity"]) && isDefined(_id_1F0571D36D0DF95B["entity"].targetname) && _id_1F0571D36D0DF95B["entity"].targetname == "train_wz") {
      trainent = _id_1F0571D36D0DF95B["entity"];
      _id_EA3B9640A6AD3C8E = rotatevectorinverted(item.origin - trainent.origin, trainent.angles);
      localangles = combineangles(invertangles(trainent.angles), item.angles);
      item scripts\common\utility::_id_6E506F39F121EA8A(trainent, _id_EA3B9640A6AD3C8E, localangles);
    }
  }

  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_spawn_item");
  player _id_0378C051E72D6871("spawn_item", _id_B20505170ABF9491, 1);
}

_id_3BBC6D6A3335B93F(_id_5868B7D3B245CC07) {
  if(!tableexists("mp/phoenix_loot_spawns.csv"))
    return "";

  _id_B20505170ABF9491 = tablelookup("mp/phoenix_loot_spawns.csv", 0, _id_5868B7D3B245CC07, 1);
  _id_E29E2491EC78EA83 = tablelookup("mp/phoenix_loot_spawns.csv", 0, _id_5868B7D3B245CC07, 2);

  if(!isDefined(_id_B20505170ABF9491) || !isDefined(_id_E29E2491EC78EA83)) {
    _id_B20505170ABF9491 = "";
    _id_E29E2491EC78EA83 = "";
  }

  return [_id_E29E2491EC78EA83, tolower(_id_B20505170ABF9491)];
}

_id_911D879942B38A0A(type, params) {
  if(getdvarint("dvar_88F35895CD0E137F", 1))
    iprintln(self.name + " executed Phoenix command: " + type);

  if(!getdvarint("dvar_97D81BDA0EBEE89A", 0)) {
    return;
  }
  _id_37F6ECE6A7C9B800 = "^Z^";
  str = "[PHOENIX] ";
  str = str + (type + _id_37F6ECE6A7C9B800);
  str = str + ("time" + _id_37F6ECE6A7C9B800);
  str = str + (gettime() / 1000 + _id_37F6ECE6A7C9B800);
  str = str + ("player_name" + _id_37F6ECE6A7C9B800);
  str = str + (self.name + _id_37F6ECE6A7C9B800);
  str = str + ("match_id" + _id_37F6ECE6A7C9B800);
  str = str + _func_94C7AE7049488358();

  if(isDefined(params)) {
    if(params.size > 0)
      str = str + _id_37F6ECE6A7C9B800;

    for(_id_FE8F7703F6313ED4 = 0; _id_FE8F7703F6313ED4 + 1 < params.size; _id_FE8F7703F6313ED4 = _id_FE8F7703F6313ED4 + 2) {
      key = params[_id_FE8F7703F6313ED4];
      val = params[_id_FE8F7703F6313ED4 + 1];
      str = str + (key + _id_37F6ECE6A7C9B800);

      if(!isDefined(val))
        str = str + "undefined";
      else if(isstruct(val))
        str = str + "struct";
      else if(isint(val) || isfloat(val) || isstring(val))
        str = str + val;
      else if(isvector(val))
        str = str + ("[" + val[0] + "," + val[1] + "," + val[2] + "]");
      else
        str = str + "\"PHOENIX_TYPE_ERROR\"";

      if(_id_FE8F7703F6313ED4 + 2 < params.size)
        str = str + _id_37F6ECE6A7C9B800;
    }
  }

  logstring(str);
}

_id_6392DAD3AC3D32EE() {
  player = self;
  player playlocalsound("ui_select_purchase_confirm");
  player _id_911D879942B38A0A("phx_clear_debug");
  player _id_0378C051E72D6871("clear_debug", "clear_debug", 1);
}

_id_0378C051E72D6871(_id_879BF96243294FA5, _id_64EABCB0DB041B7C, _id_E18953BAB2027FBD) {
  player = self;
  _id_EC6A81EAC0E4DC61 = [];
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "game_time";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = gettime() / 1000;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_player_used_command";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player._id_23D753FB0A1F6D0C;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_using_controller";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = player usinggamepad();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "game_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = scripts\mp\utility\game::getgametype();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "sub_game_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = getDvar("dvar_7611A2790A0BF7FE", "");
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_players_match";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(level.players.size);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "map_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = level.mapname;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "playlist_id";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = getplaylistid();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "playlist_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = getplaylistname();
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_name_used";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "_" + tolower(player.name);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "player_name_used_on";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "_" + tolower(player.name);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "command_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_879BF96243294FA5;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "target_name_command";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_64EABCB0DB041B7C;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "command_success";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_E18953BAB2027FBD;
  player dlog_recordplayerevent("dlog_event_phoenix_dev", _id_EC6A81EAC0E4DC61);
}

_id_81699AA174DD5A52() {
  if(!istrue(level._id_81699AA174DD5A52)) {
    return;
  }
  level waittill("prematch_done");
  _id_7E8B0243C5674617 = int(gettime() / 1000);
  _id_0A9E157E4D5311B2 = gettime();
  _id_BDDADF7BC9546FCC = 0;
  _id_B02B0B24EADC72CB = 0;
  _id_919AD30244C6E4C7 = 0;
  _id_5B801F795C0CB268 = 0;

  foreach(_id_D43C71D4938F138C in level.teamdata) {
    if(isDefined(_id_D43C71D4938F138C["teamCount"])) {
      switch (_id_D43C71D4938F138C["teamCount"]) {
        case 1:
          _id_BDDADF7BC9546FCC++;
          break;
        case 2:
          _id_B02B0B24EADC72CB++;
          break;
        case 3:
          _id_919AD30244C6E4C7++;
          break;
        case 4:
          _id_5B801F795C0CB268++;
          break;
        default:
          break;
      }
    }
  }

  _id_EC6A81EAC0E4DC61 = [];
  _id_FAF0D2FAC3F47583 = "br";

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_FAF0D2FAC3F47583 = level.brgametype.name;

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "sub_game_type";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_FAF0D2FAC3F47583;
  _id_76C6444F1C3454AD = 0;
  _id_8F3E1B856A8C20B3 = "";

  if(scripts\mp\utility\game::matchmakinggame()) {
    _id_76C6444F1C3454AD = getplaylistid();
    _id_8F3E1B856A8C20B3 = getplaylistname();
  }

  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "playlist_id";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_76C6444F1C3454AD;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "playlist_name";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_8F3E1B856A8C20B3;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "prematch_duration";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_7E8B0243C5674617;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_players";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = int(level.players.size);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_solo_teams";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_BDDADF7BC9546FCC;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_duo_teams";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_B02B0B24EADC72CB;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_trio_teams";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_919AD30244C6E4C7;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "num_quad_teams";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = _id_5B801F795C0CB268;
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = "match_duration";
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size] = 0;
  dlog_recordevent("dlog_event_playtest_data", _id_EC6A81EAC0E4DC61);
  level scripts\engine\utility::waittill_any_2("game_ended", "game_cleanup");
  _id_BD12E1C552278AD6 = int((gettime() - _id_0A9E157E4D5311B2) / 1000);
  _id_EC6A81EAC0E4DC61[_id_EC6A81EAC0E4DC61.size - 1] = _id_BD12E1C552278AD6;
  dlog_recordevent("dlog_event_playtest_data", _id_EC6A81EAC0E4DC61);
}