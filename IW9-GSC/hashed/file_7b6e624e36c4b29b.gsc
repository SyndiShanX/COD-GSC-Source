/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7b6e624e36c4b29b.gsc
***********************************************/

_id_021DBD0C4441BF5C() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "chemist";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_8B25D699C46A45AF;
  _id_AED74300DAF62896.spawnfunc = ::_id_9D38E08C2C04308A;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_E2DF928A64382E04;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_763E62DC3AF2D2E7;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "main", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_8B25D699C46A45AF(_id_AED74300DAF62896) {
  setdvarifuninitialized("dvar_0CAFFD60D24A61BF", 0.0);
  level._id_9053145480027BCA = getdvarfloat("dvar_23FEB445A52BC7C5", 3000);
  level._id_3D9C65201FB73745 = getdvarfloat("dvar_517120ABD0FE58D8", 1) == 1;

  if(level._id_3D9C65201FB73745) {
    _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];

    if(!isDefined(level.struct_class_names["script_noteworthy"]["boss_chemist"])) {
      level._id_3D9C65201FB73745 = 0;
      return;
    }

    foreach(node in level.struct_class_names["script_noteworthy"]["boss_chemist"])
    _id_AED74300DAF62896._id_BFE291B401A9BF2A[_id_AED74300DAF62896._id_BFE291B401A9BF2A.size] = node;
  }
}

_id_9D38E08C2C04308A() {
  if(getdvarint("dvar_DE56F19C5CA487F6", 1) != 1) {
    return;
  }
  if(randomfloat(1.0) > getdvarfloat("dvar_CB6CA50A8934B8B1", 1)) {
    return;
  }
  if(!_id_4459CC59BEA7AE2A(level.mapname)) {
    return;
  }
  level thread _id_AA4974941A745900(3000, getdvarint("dvar_75A29DE7293516D4", 6));
  timer = getdvarint("dvar_776ADE2E8FBDE7B0", -1);

  if(timer >= 0)
    level thread _id_18737145326A757F(timer);
}

_id_4459CC59BEA7AE2A(mapname) {
  if(level._id_3D9C65201FB73745) {
    points = [];

    foreach(set in level._id_C40817516B7D2B68) {
      if(isDefined(set.points)) {
        foreach(point in set.points) {
          if(isDefined(point.origin))
            points[points.size] = point;
        }
      }

      if(isDefined(set.origin))
        points[points.size] = set;
    }

    _id_29D9D2428185616D = scripts\engine\utility::array_randomize(level._id_6A4C9FBD7AA58544["chemist"]._id_BFE291B401A9BF2A);
    _id_0BAA08EA813E9752 = _id_29D9D2428185616D[0];

    foreach(_id_BFE291B401A9BF2A in _id_29D9D2428185616D) {
      _id_05956C54E54EBF3D = 1;

      foreach(start in points) {
        if(distance2d(start.origin, _id_BFE291B401A9BF2A.origin) < 4200) {
          _id_05956C54E54EBF3D = 0;
          break;
        }
      }

      if(_id_05956C54E54EBF3D) {
        _id_0BAA08EA813E9752 = _id_BFE291B401A9BF2A;
        break;
      }
    }

    if(!isDefined(_id_0BAA08EA813E9752) || !isDefined(_id_0BAA08EA813E9752.target))
      return 0;

    _id_58C817414D96DE59 = spawnStruct();
    _id_58C817414D96DE59.nodes = [];
    _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_0BAA08EA813E9752.target, "targetname");

    foreach(node in _id_A942AE9112CD6BDE) {
      if(!isDefined(_id_58C817414D96DE59.nodes[node.script_noteworthy]))
        _id_58C817414D96DE59.nodes[node.script_noteworthy] = [];

      _id_58C817414D96DE59.nodes[node.script_noteworthy][_id_58C817414D96DE59.nodes[node.script_noteworthy].size] = node;
    }

    level._id_CCA9EFC57D868315 = _id_58C817414D96DE59;
    level._id_2CDF30478FA435FF = [_id_0BAA08EA813E9752.origin];
    return 1;
  } else if(mapname == "mp_saba" || mapname == "mp_saba2" || mapname == "mp_saba_pm") {
    level._id_2CDF30478FA435FF = [(-26338, -12129, 1321), (-34332, 3107, 1996), (-13845, 31494, 328), (28950, -18949, 612), (13216, 11140, 424), (288, -3452, 2403)];

    if(getdvarint("dvar_9477D8978952A307", -1) != -1)
      level._id_2CDF30478FA435FF = [level._id_2CDF30478FA435FF[getdvarint("dvar_9477D8978952A307", 0)]];

    return 1;
  } else if(mapname == "mp_br_mechanics") {
    level._id_2CDF30478FA435FF = [(0, 0, 0), (0, 1000, 0), (1000, 0, 0)];

    if(getdvarint("dvar_9477D8978952A307", -1) != -1)
      level._id_2CDF30478FA435FF = [level._id_2CDF30478FA435FF[getdvarint("dvar_9477D8978952A307", 0)]];

    return 1;
  }

  return 0;
}

_id_AA4974941A745900(_id_CB920E03144E9344, num) {
  _id_48814951E916AF89::_id_2FC80954FA70D153();

  if(!isDefined(level._id_33A2175A9A4306BC)) {
    return;
  }
  _id_D8C070CD075B3D73(_id_CB920E03144E9344, num, level._id_33A2175A9A4306BC.origin);
  _id_C1AEACBB2BB10BF7(level._id_33A2175A9A4306BC.origin);
}

_id_D8C070CD075B3D73(_id_CB920E03144E9344, num, pos) {
  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_F7F734122B6C8CD9 = spawnStruct();
  _id_F7F734122B6C8CD9._id_C85CACF712BEB462 = [];
  _id_F7F734122B6C8CD9._id_A3CFCED66FFAADBE = [];
  _id_27FFA7274F57AA0E = getunusedlootcachepoints(pos, _id_CB920E03144E9344);

  if(_id_27FFA7274F57AA0E.size > 0) {
    _id_2E820A09BEDB5F50 = 0;

    foreach(loc in scripts\engine\utility::array_randomize(_id_27FFA7274F57AA0E)) {
      scriptable = spawnscriptable("br_loot_cache_lege", loc.origin, loc.angles);
      scriptable setscriptablepartstate("body", "closed_usable");
      _id_2E820A09BEDB5F50++;

      if(_id_2E820A09BEDB5F50 > num) {
        break;
      }
    }
  }

  if(isDefined(level._id_CCA9EFC57D868315)) {
    _id_58C817414D96DE59 = level._id_CCA9EFC57D868315;

    foreach(_id_D123D2FEB80B6C3A in _id_58C817414D96DE59.nodes["boss_chemist_patrol"]) {
      _id_F7B6E820EEA0369F = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 5; _id_AC0E5C4AC96AAA41++) {
        spawnpos = getclosestpointonnavmesh(_id_D123D2FEB80B6C3A.origin + rotatevector((50, 0, 0), (0, 120 * _id_AC0E5C4AC96AAA41, 0)));
        _id_3138C7EBA9B7AA1F = _id_0173EDDC3A8EE506(scripts\engine\utility::drop_to_ground(spawnpos));

        if(!isDefined(_id_3138C7EBA9B7AA1F)) {
          continue;
        }
        _id_F7B6E820EEA0369F[_id_F7B6E820EEA0369F.size] = _id_3138C7EBA9B7AA1F;
        _id_F7F734122B6C8CD9._id_A3CFCED66FFAADBE[_id_F7F734122B6C8CD9._id_A3CFCED66FFAADBE.size] = _id_3138C7EBA9B7AA1F;
      }

      pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(_id_D123D2FEB80B6C3A);
      level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(_id_F7B6E820EEA0369F, pathstruct);
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_217C1C856C59A550 = _id_AC0E594AC96AA3A8 * 90.0;
      nodes = _id_6AC19DDA680D2498(pos + rotatevector((_id_CB920E03144E9344 * 0.5, 0, 0), (0, _id_217C1C856C59A550, 0)), 1000);
      _id_F7F734122B6C8CD9._id_C85CACF712BEB462[_id_AC0E594AC96AA3A8] = nodes[0];
      targetpos = getclosestpointonnavmesh(pos + rotatevector((_id_CB920E03144E9344 * 1.3, 0, 0), (0, _id_217C1C856C59A550, 0)));
      _id_F7B6E820EEA0369F = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 3; _id_AC0E5C4AC96AAA41++) {
        spawnpos = getclosestpointonnavmesh(targetpos + rotatevector((50, 0, 0), (0, 120 * _id_AC0E5C4AC96AAA41, 0)));
        _id_3138C7EBA9B7AA1F = _id_0173EDDC3A8EE506(scripts\engine\utility::drop_to_ground(spawnpos));

        if(!isDefined(_id_3138C7EBA9B7AA1F)) {
          continue;
        }
        _id_F7B6E820EEA0369F[_id_F7B6E820EEA0369F.size] = _id_3138C7EBA9B7AA1F;
        _id_F7F734122B6C8CD9._id_A3CFCED66FFAADBE[_id_F7F734122B6C8CD9._id_A3CFCED66FFAADBE.size] = _id_3138C7EBA9B7AA1F;
      }

      _id_C79916C8DF58D478 = [];

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 3; _id_AC0E5C4AC96AAA41++)
        _id_C79916C8DF58D478[_id_C79916C8DF58D478.size] = getclosestpointonnavmesh(pos + rotatevector((_id_CB920E03144E9344 * 1.3, 0, 0), (0, _id_217C1C856C59A550 + _id_AC0E5C4AC96AAA41 * 30, 0)));

      _id_E0C08758EB0006BE = _id_7C5AF0C683EAC10E(_id_C79916C8DF58D478);
      level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(_id_F7B6E820EEA0369F, _id_E0C08758EB0006BE);
    }
  }

  level._id_6E22F627DD92F1C0 = _id_F7F734122B6C8CD9;
}

_id_7C5AF0C683EAC10E(_id_455E764D8C345441) {
  path = [];

  foreach(pos in _id_455E764D8C345441) {
    node = spawnStruct();
    node.origin = pos;
    path[path.size] = node;
  }

  level thread _id_A063C83C6C5A459C(path);
  pathstruct = spawnStruct();
  pathstruct.path = path;
  pathstruct.claimed = 0;
  pathstruct._id_4437E81F60B6B5A0 = 1;
  return pathstruct;
}

_id_E820A43F28C1EE18() {
  for(;;) {
    waitframe();

    if(getdvarint("dvar_200CF315B9216221", 0) == 1) {
      level._id_CCA9EFC57D868315 = undefined;
      _id_C1AEACBB2BB10BF7(level.players[0].origin, 1);
      setDvar("dvar_200CF315B9216221", 0);
    }
  }
}

_id_C1AEACBB2BB10BF7(loc, _id_12AF3E839559F976) {
  if(istrue(_id_12AF3E839559F976))
    _id_D8C070CD075B3D73(3000, 0, loc);

  if(isDefined(level._id_CCA9EFC57D868315)) {
    _id_58C817414D96DE59 = level._id_CCA9EFC57D868315;
    nodes = [];
    _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_58C817414D96DE59.nodes["boss_chemist_bossSpawn"][0].target, "targetname");

    foreach(node in _id_A942AE9112CD6BDE) {
      if(!isDefined(nodes[node.script_noteworthy]))
        nodes[node.script_noteworthy] = [];

      nodes[node.script_noteworthy][nodes[node.script_noteworthy].size] = node;
    }

    pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(nodes["boss_chemist_bossPatrol"][0]);
    _id_F7F734122B6C8CD9 = level._id_6E22F627DD92F1C0;

    foreach(_id_6FCBAE6BBFEB6C65 in nodes["boss_chemist_bossRetreatPoint"])
    _id_F7F734122B6C8CD9._id_C85CACF712BEB462[_id_F7F734122B6C8CD9._id_C85CACF712BEB462.size] = _id_6FCBAE6BBFEB6C65;

    _id_7322A8D616C1FAE4 = [];
    loc = _id_58C817414D96DE59.nodes["boss_chemist_bossSpawn"][0].origin;
    _id_2844B5AC95469F34 = _id_1641652FADFA852C(loc);

    if(!isDefined(_id_2844B5AC95469F34)) {
      return;
    }
    _id_7322A8D616C1FAE4[_id_7322A8D616C1FAE4.size] = _id_2844B5AC95469F34;

    foreach(guard in nodes["boss_chemist_guardSpawn"]) {
      _id_11B3BB0A908E9D8D = getclosestpointonnavmesh(guard.origin);
      _id_2844B5AC95469F34 _id_E7E99BAE3AE27C86(_id_11B3BB0A908E9D8D);
    }

    foreach(_id_3138C7EBA9B7AA1F in _id_2844B5AC95469F34._id_F78A17463EEBCB84)
    _id_7322A8D616C1FAE4[_id_7322A8D616C1FAE4.size] = _id_3138C7EBA9B7AA1F;

    level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(_id_7322A8D616C1FAE4, pathstruct);
  } else {
    _id_7322A8D616C1FAE4 = [];
    _id_2844B5AC95469F34 = _id_1641652FADFA852C(loc);

    if(!isagent(_id_2844B5AC95469F34)) {
      return;
    }
    _id_7322A8D616C1FAE4[_id_7322A8D616C1FAE4.size] = _id_2844B5AC95469F34;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
      _id_2844B5AC95469F34 _id_E7E99BAE3AE27C86(loc);

    _id_F8CE681E61F482F0 = [];

    foreach(nodes in level._id_6E22F627DD92F1C0._id_C85CACF712BEB462) {
      if(nodes.size < 1) {
        continue;
      }
      nodes = scripts\engine\utility::array_randomize(nodes);
      _id_F8CE681E61F482F0[_id_F8CE681E61F482F0.size] = nodes[0].origin;
    }

    foreach(_id_3138C7EBA9B7AA1F in _id_2844B5AC95469F34._id_F78A17463EEBCB84)
    _id_7322A8D616C1FAE4[_id_7322A8D616C1FAE4.size] = _id_3138C7EBA9B7AA1F;

    _id_E0C08758EB0006BE = _id_7C5AF0C683EAC10E(_id_F8CE681E61F482F0);
    level thread _id_120270BD0A747A35::_id_25CC93D439C3033A(_id_7322A8D616C1FAE4, _id_E0C08758EB0006BE);
  }
}

_id_1641652FADFA852C(loc) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar");
  _id_2844B5AC95469F34 = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc, (0, 0, 0), "absolute", "bosses", "chemistBoss", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(isagent(_id_2844B5AC95469F34))
    _id_5CA98B0869DADEF3(_id_2844B5AC95469F34);

  return _id_2844B5AC95469F34;
}

_id_5B6A346743EA0C08(icon) {
  self endon("death");

  for(;;) {
    waitframe();
    icon.origin = self.origin;
  }
}

_id_5CA98B0869DADEF3(agent) {
  agent _meth_8ABE5A968CC3C220("scubagr");
  agent setclothtype("nylon");
  agent._id_FB23C52F35F8A8B2 = 2;
  agent._id_CE90AEED0C13AA01 = 0;

  if(getdvarint("dvar_49B37FC622A4D585", 0) == 1)
    agent _meth_3DE79443C911D4A5(1, 4, "MP_DMZ_MISSIONS/DMZ_BOSS_JUGG_NAME");

  _id_A738703F5A2F75B0(agent);
  _id_8C75C28DA153BEC6 = _id_1174ABEDBEFE9ADA::_id_F3FB60F986F267C5();
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("chemist");
  instance.agent = agent;
  instance._id_E2958F412A7425C0 = agent;
  instance._id_9329E0D3CE1D5CA8 = "chemist";
  agent._id_0566868292EE2A1B = instance;
  instance _id_2FDEB8023287BE67::_id_8002B09B8348902C((_id_8C75C28DA153BEC6[0], _id_8C75C28DA153BEC6[1], agent.origin[2] + 750), "ui_map_icon_boss_chemist");
  instance thread _id_3679FEFDCC04665E();
  agent _id_2FDEB8023287BE67::_id_720C3B7ABF4BAAC8("chemist");
  instance notify("boss_spawned");
  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["dmz_boss_chemist_retreat"];
  _id_985AE874212B863E["combat"] = ["dmz_boss_chemist_loud"];
  _id_6B9A0DBBF039DECE = 1;
  instance thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(instance, _id_985AE874212B863E, _id_6B9A0DBBF039DECE);
}

_id_B8EE86EF281D80E8(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!istrue(self._id_B880B485EB635035)) {
    self._id_B880B485EB635035 = 1;
    self playsoundonmovingent("dx_br_dbos_dbli_dbcm_bitr");
  }

  if(isDefined(einflictor.team) && !isDefined(einflictor.vehicletype))
    _id_2FDEB8023287BE67::_id_0AE49568842BCE7E(eattacker, "chemist", 1);

  if((self.armorhealth < level._id_9053145480027BCA / 2 || self.helmethealth < self._id_CFC69E5588A5BED6 / 2) && self._id_FB23C52F35F8A8B2 > 0 && gettime() - self._id_CE90AEED0C13AA01 > 10000) {
    self playsoundonmovingent("dx_br_dbos_dbli_dbcm_btau");
    self._id_CE90AEED0C13AA01 = gettime();
    self._id_FB23C52F35F8A8B2 = self._id_FB23C52F35F8A8B2 - 1;
    _id_25F022C4ECD83DE6(eattacker);
    thread _id_E6114DD810D8CE1F();
  }

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);

  if(isalive(self))
    self._id_A288A9250A329995 = self._id_A288A9250A329995 + idamage;

  self.lasttimedamaged = gettime();
}

_id_E6114DD810D8CE1F() {
  self endon("death");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_0F2C6E7B3FC1C38A = scripts\engine\utility::_id_6174330574A2A273() * 100;
    pos = scripts\engine\utility::drop_to_ground(self.origin + _id_0F2C6E7B3FC1C38A);
    magicgrenademanual("smoke_grenade_mp", pos, (0, 0, -10), 0.5);
    wait 0.2;

    if(isDefined(self._id_F78A17463EEBCB84)) {
      foreach(_id_3138C7EBA9B7AA1F in self._id_F78A17463EEBCB84) {
        if(isalive(_id_3138C7EBA9B7AA1F)) {
          _id_0F2C6E7B3FC1C38A = scripts\engine\utility::_id_6174330574A2A273() * 100;
          pos = scripts\engine\utility::drop_to_ground(_id_3138C7EBA9B7AA1F.origin + _id_0F2C6E7B3FC1C38A);
          magicgrenademanual("smoke_grenade_mp", pos, (0, 0, -10), 0.5);
          wait 0.2;
        }
      }
    }

    wait 2;
  }
}

_id_E7E99BAE3AE27C86(loc) {
  if(!isDefined(self._id_F78A17463EEBCB84))
    self._id_F78A17463EEBCB84 = [];

  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("strikeunit", 3);
  _id_3138C7EBA9B7AA1F = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc, (0, 0, 0), "high", "bossMinions", "chemistBossMinion", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_3138C7EBA9B7AA1F))
    return undefined;

  _id_2197EC1C9D939627(_id_3138C7EBA9B7AA1F);
  _id_3138C7EBA9B7AA1F._id_B582B10663B5B2A9 = 0;
  self._id_F78A17463EEBCB84[self._id_F78A17463EEBCB84.size] = _id_3138C7EBA9B7AA1F;
  _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(_id_3138C7EBA9B7AA1F, "chemist_overridePersonalMinion", ::_id_2197EC1C9D939627);
  return _id_3138C7EBA9B7AA1F;
}

_id_0173EDDC3A8EE506(loc) {
  aitype = _id_48814951E916AF89::_id_7F1A2E2EBE0C1693("ar", 2);
  _id_3138C7EBA9B7AA1F = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, loc, (0, 0, 0), "medium", "bossMinions", "chemistBossMinion", undefined, undefined, undefined, "bossArea", 0, 0, 0);

  if(!isDefined(_id_3138C7EBA9B7AA1F))
    return undefined;

  _id_371B4C2AB5861E62::_id_58AAB2EDAEC2599F(_id_3138C7EBA9B7AA1F, "chemist_overrideMinion", ::_id_19459818D3A8D04F);

  if(isagent(_id_3138C7EBA9B7AA1F)) {
    _id_19459818D3A8D04F(_id_3138C7EBA9B7AA1F);
    return _id_3138C7EBA9B7AA1F;
  }
}

_id_A738703F5A2F75B0(agent) {
  if(!isDefined(agent)) {
    return;
  }
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, undefined, 108);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "interactable_note_chemist_pmc", undefined, undefined, 1);
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_valuable_sulfuric_acid_chemist", undefined, undefined, 1);
  agent._id_A4738C70736D3A61 = ::_id_B8EE86EF281D80E8;
  agent._id_9329E0D3CE1D5CA8 = "chemist";
  agent.health = 500;
  agent._id_A288A9250A329995 = 0;
  agent._id_65771500F49956C1 = 1;
  body = "fullbody_sp_opforce_al_qatala_boss_chemist";
  roll = randomint(100);
  weapon = level.br_lootiteminfo["brloot_weapon_ar_mike4_chemist"].fullweaponobj;

  if(roll < 35)
    weapon = level.br_lootiteminfo["brloot_weapon_br_msecho_chemist"].fullweaponobj;

  if(getdvarint("dvar_2F83E02F5B876153", 1) == 1)
    _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_plate_carrier_3_medic", undefined, undefined, 1);

  _id_136ECFAAAADE9D08 = _id_2669878CF5A1B6BC::buildweapon_blueprint("iw9_ar_mcharlie", undefined, undefined, 3, undefined, undefined);
  weapon = _id_136ECFAAAADE9D08;
  _id_A664AAD02EE98BD2 = "gas_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  armor = level._id_9053145480027BCA;
  helmet = 10;
  agent._id_668B72F41E87C75A = 1;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(body, undefined, weapon, _id_A664AAD02EE98BD2, 3, armor, helmet, 1);
  agent.baseaccuracy = getdvarfloat("dvar_298D4EA8B0934E31", 1.2);

  if(istrue(level._id_22405C0E11052FFF))
    agent thread _id_2FDEB8023287BE67::_id_49725DC1ABCC7B7E(2000);
}

_id_2197EC1C9D939627(agent) {
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, undefined, 108);
  weapon = level.br_lootiteminfo["brloot_weapon_ar_akilo_chemist_minion"].fullweaponobj;
  agent._id_65771500F49956C1 = 1;

  if(!istrue(agent._id_102A9D2CF99AB325)) {
    agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
    agent._id_102A9D2CF99AB325 = 1;
  }

  _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
  grenadeammo = 3;
  armor = 1000;
  helmet = 3;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, weapon, _id_A664AAD02EE98BD2, grenadeammo, armor, helmet);
  agent._id_CD6A3A50F09688B9 = ::_id_FD51AA68089E7F71;
}

_id_FD51AA68089E7F71(agent, attacker) {
  agent detach("hat_child_hadir_gas_mask_wm_br", "j_head");
  agent._id_65771500F49956C1 = 0;
  _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(agent, attacker);
}

_id_19459818D3A8D04F(agent) {
  _id_48814951E916AF89::_id_63A043D47490F90D(agent, "brloot_equip_gasmask", undefined, undefined, 108);
  agent._id_65771500F49956C1 = 1;

  if(!istrue(agent._id_102A9D2CF99AB325)) {
    agent attach("hat_child_hadir_gas_mask_wm_br", "j_head");
    agent._id_102A9D2CF99AB325 = 1;
  }

  _id_A664AAD02EE98BD2 = "gas_mp";
  grenadeammo = getdvarint("dvar_537FA443CE212A8A", 4);
  armor = 150;
  helmet = 1;
  agent _id_371B4C2AB5861E62::_id_C37C4F9D687074FF(undefined, undefined, undefined, _id_A664AAD02EE98BD2, 3, armor, helmet);
  agent._id_CD6A3A50F09688B9 = ::_id_FD51AA68089E7F71;
}

_id_E2DF928A64382E04(struct) {
  agent = _id_1641652FADFA852C(struct._id_D20CABB504F78F36.origin);
  agent = _id_E7E99BAE3AE27C86(struct._id_D20CABB504F78F36.origin);
}

_id_3679FEFDCC04665E() {
  self.agent waittill("death", _id_6181DE250AFA5BB6);
  scripts\mp\gameobjects::releaseid();

  if(isDefined(_id_6181DE250AFA5BB6.vehicletype)) {
    if(isDefined(_id_6181DE250AFA5BB6.owner))
      _id_6181DE250AFA5BB6 = _id_6181DE250AFA5BB6.owner;
  }

  if(isDefined(_id_6181DE250AFA5BB6) && isDefined(_id_6181DE250AFA5BB6.team)) {
    _id_65F58F3C394DCF9A::_id_73F954808739F7BC(self, _id_6181DE250AFA5BB6, "dmz_boss_chemist_death");
    _id_74B5B12BB6514385 = 5.0;
    thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_chemist_eliminated", _id_6181DE250AFA5BB6.team, _id_74B5B12BB6514385);
  }
}

_id_94C71415F3E1292E(_id_EB4D81FD840007E2) {
  if(level._id_01AB6CF2D7F3A688 < 0) {
    return;
  }
  if(level._id_01AB6CF2D7F3A688 > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, _id_EB4D81FD840007E2) < level._id_01AB6CF2D7F3A688)
        playerlist[playerlist.size] = player;
    }
  } else
    playerlist = level.players;

  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_EB4D81FD840007E2, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_boss_juggernaut_inbound", playerlist, _id_171F90B9C4C76D44);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("boss_juggernaut_near", playerlist);
}

_id_25F022C4ECD83DE6(attacker) {
  if(istrue(self._id_56847A36049B6371)) {
    return;
  }
  self._id_56847A36049B6371 = 1;

  if(!isDefined(level._id_6E22F627DD92F1C0)) {
    return;
  }
  _id_FFB631393432FCED = level._id_6E22F627DD92F1C0._id_C85CACF712BEB462[0];
  maxdist = 0;

  foreach(node in level._id_6E22F627DD92F1C0._id_C85CACF712BEB462) {
    if(istrue(node.used)) {
      continue;
    }
    _id_D2E4BDDEDDC9B4F9 = distance2d(node.origin, attacker.origin);

    if(_id_D2E4BDDEDDC9B4F9 > maxdist) {
      _id_FFB631393432FCED = node;
      maxdist = _id_D2E4BDDEDDC9B4F9;
    }
  }

  _id_FFB631393432FCED.used = 1;
  _id_120270BD0A747A35::_id_304DA84D9A815C01(_id_FFB631393432FCED.origin, 32, 0);
  scripts\common\ai::set_forcegoal();
  agents = scripts\mp\utility\entity::_id_D9CE8FB00F0E5FA1(self.origin, 4000);
  _id_50F783A5617F8940 = [];

  foreach(agent in agents) {
    if(!isPlayer(agent) && istrue(agent._id_65771500F49956C1)) {
      if(isalive(agent)) {
        if(randomfloat(1.0) > 0.5) {
          level thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, attacker.origin);
          continue;
        }

        level thread _id_120270BD0A747A35::_id_A5117518725DA028(agent, _id_FFB631393432FCED.origin);
      }
    }
  }

  thread _id_C4F574FA06F6A615(_id_FFB631393432FCED.origin);
}

_id_C4F574FA06F6A615(pos) {
  self waittill("goal");
  self._id_56847A36049B6371 = 0;
  self.script_forcegoal = 0;

  if(isDefined(self.lasttimedamaged) && gettime() - self.lasttimedamaged > 5000) {
    _id_07C40FA80892A721::_id_AC7803D45979135C(level._id_9053145480027BCA);
    self.helmethealth = self._id_CFC69E5588A5BED6;
  }
}

_id_6AC19DDA680D2498(pos, radius) {
  nodes = _id_2BD868C7E34554C4(pos, radius);

  if(!isDefined(nodes) || nodes.size < 2) {
    nodes = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      node = spawnStruct();
      node.origin = scripts\engine\utility::drop_to_ground(pos + scripts\engine\utility::_id_6174330574A2A273() * 1000);
      nodes[nodes.size] = node;
    }

    return nodes;
  }

  _id_9740F782950674E6 = [];
  _id_811DC7CFCFD29886 = 0;

  foreach(node in nodes)
  _id_811DC7CFCFD29886 = _id_811DC7CFCFD29886 + node.origin[2];

  _id_B653075EF21182D0 = _id_811DC7CFCFD29886 / nodes.size;

  foreach(node in nodes) {
    if(node.origin[2] > _id_B653075EF21182D0) {
      usable = 1;

      foreach(_id_E6A426FC595FE0CD in _id_9740F782950674E6) {
        if(distancesquared(node.origin, _id_E6A426FC595FE0CD.origin) < 250000) {
          usable = 0;
          break;
        }
      }

      if(usable)
        _id_9740F782950674E6[_id_9740F782950674E6.size] = node;
    }
  }

  if(_id_9740F782950674E6.size == 0) {
    _id_B8A10A608DBDA758 = scripts\engine\utility::array_randomize(nodes);
    _id_9740F782950674E6[_id_9740F782950674E6.size] = _id_B8A10A608DBDA758[0];
  }

  level thread _id_A063C83C6C5A459C(_id_9740F782950674E6);
  return _id_9740F782950674E6;
}

_id_A063C83C6C5A459C(_id_D76B59299A263FE5) {}

_id_2BD868C7E34554C4(origin, _id_85EE6BB88B16100B) {
  _id_EA8744DFDF5A7FD3 = getnodesinradius(origin, _id_85EE6BB88B16100B, 0, _id_85EE6BB88B16100B);
  return _id_EA8744DFDF5A7FD3;
}

_id_18737145326A757F(time) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    level scripts\mp\flags::gameflagwait("prematch_done");

  wait(time);
  _id_2FDEB8023287BE67::_id_35826E6CD8838C47("chemist");
}

_id_763E62DC3AF2D2E7(player, showicon) {
  team = player.team;

  if(!isDefined(self._id_7D8AD21E5DFD7C94))
    self._id_7D8AD21E5DFD7C94 = [];

  if(!isDefined(self.agent) || !isalive(self.agent) || scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self.agent.origin, 1);

  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_chemist_revealed", _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_chemist_near", team, 2.0);
  _id_6B9A0DBBF039DECE = 1;
  _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_chemist_approach", _id_6B9A0DBBF039DECE);
  return 1;
}