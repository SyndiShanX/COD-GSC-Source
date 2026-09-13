/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_77dda09afb222de3.gsc
***********************************************/

_id_93A03EB03BC2C8AE(_id_E2A66792E953B612) {
  if(getdvarint("dvar_C98DC370C6DFBF22", 1) == 0) {
    return;
  }
  level._id_EA7F4DBBC87F7E22 = 0;

  if(getdvarint("dvar_33C788C7C04D2276", 0) == 1)
    level._id_EA7F4DBBC87F7E22 = 1;

  if(!isDefined(_id_E2A66792E953B612))
    _id_E2A66792E953B612 = 0;

  level._id_B66460F12E76861E = getdvarint("dvar_55589A53FF290C2C", _id_E2A66792E953B612);
  _id_A95CF9509CE0D814 = "brightZone";

  if(level._id_B66460F12E76861E == 1)
    _id_A95CF9509CE0D814 = "darkZone";

  triggers = _func_F159C10D5CF8F0B4(_id_A95CF9509CE0D814, "targetname");

  if(!isDefined(triggers)) {
    return;
  }
  if(triggers.size == 0) {
    return;
  }
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("lightZones");

    foreach(trigger in triggers) {
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(trigger.origin, 1, 1);
      _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "lightZones", trigger);
    }

    foreach(_id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
    level thread _id_DB690B3317074F2C(_id_B205D90302DA2F07["name"]);
  } else {
    level._id_729DA2159F5F554C = spawnStruct();
    level._id_729DA2159F5F554C.triggers = triggers;
    level thread _id_23C3FB7201561442();
  }
}

_id_DB690B3317074F2C(_id_171F90B9C4C76D44) {
  if(!isDefined(_id_171F90B9C4C76D44)) {
    return;
  }
  level endon("game_ended");
  triggers = _id_5DEF7AF2A9F04234::_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, "lightZones");

  if(!isDefined(triggers) || triggers.size == 0) {
    return;
  }
  for(;;) {
    if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])) {
      foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
        _id_99C6D948F787DA56 = _id_BB16BD2BA27883CA(player, triggers);

        if(0 || level._id_EA7F4DBBC87F7E22) {
          if(_id_99C6D948F787DA56) {} else {}
        }

        _func_3B992A66C2E901BB(player, !_id_99C6D948F787DA56);
      }
    }

    wait 1;
  }
}

_id_23C3FB7201561442() {
  level endon("game_ended");

  for(;;) {
    foreach(player in level.players) {
      _id_8034062BEBF15F98 = !level._id_B66460F12E76861E;
      _id_F5A62EA4F4C7F032 = _id_BB16BD2BA27883CA(player, level._id_729DA2159F5F554C.triggers);

      if(_id_F5A62EA4F4C7F032)
        _id_8034062BEBF15F98 = level._id_B66460F12E76861E;

      _func_3B992A66C2E901BB(player, _id_8034062BEBF15F98);
    }

    wait 1;
  }
}

_id_BB16BD2BA27883CA(player, triggers) {
  foreach(trigger in triggers) {
    if(ispointinvolume(player.origin, trigger))
      return 1;
  }

  return 0;
}

_id_4EFF5099D01F8C7A(ent, triggers) {
  foreach(trigger in triggers) {
    if(ispointinvolume(ent.origin, trigger))
      return 1;
  }

  return 0;
}

_id_FF6EC457112FC056(agent) {
  agent endon("left_lightdark_trigger");
  agent endon("death");

  for(;;)
    waitframe();
}

_id_3D7298D1B868205B(_id_4E94C5615C36AB4E) {
  if(getdvarint("dvar_D1A4FF4BC746059A", 1) == 0) {
    return;
  }
  triggers = _func_F159C10D5CF8F0B4("sandstormZone", "targetname");

  if(!isDefined(triggers)) {
    return;
  }
  if(triggers.size == 0) {
    return;
  }
  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("sandstormZones");

    foreach(trigger in triggers) {
      _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(trigger.origin, 1, 1);
      _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_171F90B9C4C76D44, "sandstormZones", trigger);
    }

    foreach(_id_B205D90302DA2F07 in level._id_B205D90302DA2F07)
    level thread _id_89CCEE52F247D9A3(_id_B205D90302DA2F07["name"]);
  } else {
    level._id_6A7C968ACCF74C57 = spawnStruct();
    level._id_6A7C968ACCF74C57.triggers = triggers;
    level thread _id_3798FE70F2134791();
  }
}

_id_89CCEE52F247D9A3(_id_171F90B9C4C76D44) {
  level endon("game_ended");
  triggers = _id_5DEF7AF2A9F04234::_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, "sandstormZones");

  if(!isDefined(triggers) || triggers.size == 0) {
    return;
  }
  if(!isDefined(level._id_41670C1C65F3D3CF)) {
    return;
  }
  for(;;) {
    if(isDefined(level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"])) {
      foreach(player in level._id_B205D90302DA2F07[_id_171F90B9C4C76D44]["players"]) {
        _id_F3695FC64154D3AD = _id_491D53F82FEB781B(player, triggers);
        _func_3B992A66C2E901BB(player, _id_F3695FC64154D3AD);
      }

      foreach(agent in _func_7E3F22E620F3F71E(_id_171F90B9C4C76D44, "everybody")) {
        if(!isalive(agent) || isint(agent)) {
          continue;
        }
        _id_F3695FC64154D3AD = _id_491D53F82FEB781B(agent, triggers);

        if(!isDefined(agent._id_F3695FC64154D3AD) || agent._id_F3695FC64154D3AD != _id_F3695FC64154D3AD) {
          agent._id_F3695FC64154D3AD = _id_F3695FC64154D3AD;

          if(_id_F3695FC64154D3AD) {
            if(0)
              agent thread _id_7F12B9FEC2560C48(agent);

            _id_48814951E916AF89::_id_C9DAD3876B9D8755(agent, "in_sandstorm");
            continue;
          }

          if(0)
            agent notify("left_sandstorm");

          _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47(_id_171F90B9C4C76D44);
          _id_41BA451876D0900C::_id_E04DBE0BD8A25BE7(agent, _id_ACA1544C91A292FD);
        }
      }
    }

    wait 1;
  }
}

_id_3798FE70F2134791() {
  level endon("game_ended");

  if(!isDefined(level._id_6A7C968ACCF74C57.triggers) || level._id_6A7C968ACCF74C57.triggers.size == 0) {
    return;
  }
  for(;;) {
    foreach(player in level.players) {
      _id_F3695FC64154D3AD = _id_491D53F82FEB781B(player, level._id_6A7C968ACCF74C57.triggers);
      _func_3B992A66C2E901BB(player, _id_F3695FC64154D3AD);
    }

    foreach(agent in level.agentarray) {
      if(!isalive(agent)) {
        continue;
      }
      _id_F3695FC64154D3AD = _id_491D53F82FEB781B(agent, level._id_6A7C968ACCF74C57.triggers);

      if(!isDefined(agent._id_F3695FC64154D3AD) || agent._id_F3695FC64154D3AD != _id_F3695FC64154D3AD) {
        agent._id_F3695FC64154D3AD = _id_F3695FC64154D3AD;

        if(_id_F3695FC64154D3AD) {
          if(0)
            agent thread _id_7F12B9FEC2560C48(agent);

          _id_48814951E916AF89::_id_C9DAD3876B9D8755(agent, "in_sandstorm");
          continue;
        }

        if(0)
          agent notify("left_sandstorm");

        _id_ACA1544C91A292FD = _id_41BA451876D0900C::_id_5CC0C507E92F7B47();
        _id_41BA451876D0900C::_id_E04DBE0BD8A25BE7(agent, _id_ACA1544C91A292FD);
      }
    }

    wait 1;
  }
}

_id_491D53F82FEB781B(ent, triggers) {
  foreach(trigger in triggers) {
    if(ispointinvolume(ent.origin, trigger))
      return 1;
  }

  return 0;
}

_id_7F12B9FEC2560C48(agent) {
  agent endon("left_sandstorm");
  agent endon("death");

  for(;;)
    waitframe();
}