/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_55e395b5a89cc532.gsc
***********************************************/

_id_DA643EDBADA6B491(_id_BF334F5702551108, startingorigin, radius, _id_9DD9D99A95EAE3F1, _id_AE6CB5204A331157, lifetime, _id_76E563DB5D11A0EA, _id_572BCF962191BDA3, _id_87DC03BF741F1135, _id_DC27F870433DFA97, _id_0C89AEF33D5D8E10, _id_D7E5D4F4C2A757B6, _id_88A88A218B58EE09, _id_2C2536DCCDD2D26B) {
  if(!isDefined(level._id_EE4952B54817E69B))
    level._id_EE4952B54817E69B = [];

  if(isDefined(level._id_EE4952B54817E69B[_id_BF334F5702551108])) {
    return;
  }
  if(!isDefined(_id_BF334F5702551108)) {
    return;
  }
  level._id_EE4952B54817E69B[_id_BF334F5702551108] = spawnStruct();
  _id_59021499916E93E8(_id_BF334F5702551108, startingorigin);
  _id_49AA197ACF50958C(_id_BF334F5702551108, radius);
  _id_F4BFF7EE258E9135(_id_BF334F5702551108, _id_9DD9D99A95EAE3F1);
  _id_F9EFF91DF1943190(_id_BF334F5702551108, _id_AE6CB5204A331157);
  _id_83B4F2A44626DC9D(_id_BF334F5702551108, lifetime);
  _id_1C436B0944DB5FDF(_id_BF334F5702551108, _id_76E563DB5D11A0EA);
  _id_661C9A3EA014D8F0(_id_BF334F5702551108, _id_572BCF962191BDA3);
  _id_81698DBDE152777A(_id_BF334F5702551108, _id_87DC03BF741F1135);
  _id_0C41270BF88DAAEE(_id_BF334F5702551108, _id_DC27F870433DFA97);
  _id_A4DADE3F7AC788A3(_id_BF334F5702551108, _id_D7E5D4F4C2A757B6);
  _id_99338B877BA0B11A(_id_BF334F5702551108, _id_88A88A218B58EE09);
  _id_34F47F14C6E790E2 = scripts\engine\utility::_id_53C4C53197386572(_id_2C2536DCCDD2D26B, 0);

  if(_id_34F47F14C6E790E2 == 1)
    _id_8FD8ED53A5EE98CA(_id_BF334F5702551108);
}

_id_1BE5E0D403A7EDDC(id) {
  if(isDefined(id)) {
    if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id]))
      return 1;
  }

  return 0;
}

_id_4D33EE8DA7A6FE0A(id) {
  if(_id_1BE5E0D403A7EDDC(id))
    return level._id_EE4952B54817E69B[id];
}

_id_59021499916E93E8(id, _id_A9706ADAF7C52E27) {
  if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id])) {
    if(isDefined(_id_A9706ADAF7C52E27) && isvector(_id_A9706ADAF7C52E27))
      level._id_EE4952B54817E69B[id].origin = _id_A9706ADAF7C52E27;
    else
      level._id_EE4952B54817E69B[id].origin = (0, 0, 0);
  }
}

_id_49AA197ACF50958C(id, _id_A66785EDEC9E567B) {
  if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id])) {
    if(isDefined(_id_A66785EDEC9E567B) && isnumber(_id_A66785EDEC9E567B))
      level._id_EE4952B54817E69B[id].radius = _id_A66785EDEC9E567B;
    else
      level._id_EE4952B54817E69B[id].radius = 500;
  }
}

_id_F4BFF7EE258E9135(id, _id_B42E60E1AC25640A) {
  if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id])) {
    if(isDefined(_id_B42E60E1AC25640A) && isnumber(_id_B42E60E1AC25640A))
      level._id_EE4952B54817E69B[id].height = _id_B42E60E1AC25640A;
    else
      level._id_EE4952B54817E69B[id].height = 500;
  }
}

_id_F9EFF91DF1943190(id, _id_31026A5EFB6491AB) {
  if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id])) {
    if(isDefined(_id_31026A5EFB6491AB) && isstring(_id_31026A5EFB6491AB))
      level._id_EE4952B54817E69B[id]._id_AE6CB5204A331157 = _id_31026A5EFB6491AB;
    else
      level._id_EE4952B54817E69B[id]._id_AE6CB5204A331157 = "Unknown Damage Circle";
  }
}

_id_83B4F2A44626DC9D(id, _id_0C37FD46193F18E6) {
  if(isDefined(_id_0C37FD46193F18E6) && isfloat(_id_0C37FD46193F18E6)) {
    if(isDefined(level._id_EE4952B54817E69B) && isDefined(level._id_EE4952B54817E69B[id]))
      level._id_EE4952B54817E69B[id].lifetime = _id_0C37FD46193F18E6;
    else
      level._id_EE4952B54817E69B[id].lifetime = -1;
  }
}

_id_1C436B0944DB5FDF(id, _id_903DCF8F7F9D55D2) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_903DCF8F7F9D55D2) && isfloat(_id_903DCF8F7F9D55D2))
      level._id_EE4952B54817E69B[id]._id_76E563DB5D11A0EA = _id_903DCF8F7F9D55D2;
    else
      level._id_EE4952B54817E69B[id]._id_76E563DB5D11A0EA = 1.0;
  }
}

_id_661C9A3EA014D8F0(id, _id_2D951E852AF24F47) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_2D951E852AF24F47) && isfloat(_id_2D951E852AF24F47))
      level._id_EE4952B54817E69B[id]._id_572BCF962191BDA3 = _id_2D951E852AF24F47;
    else
      level._id_EE4952B54817E69B[id]._id_572BCF962191BDA3 = 1.0;
  }
}

_id_364ADECE553CCB86(id, _id_62A39A040C10984C, _id_4961664664DC46E9, _id_92B14DB427332651) {
  vfx = undefined;

  if(_id_1BE5E0D403A7EDDC(id)) {
    origin = _id_CA8969486A1BA4CC(id);
    vfxent = spawnscriptable(_id_62A39A040C10984C, origin);
    vfxent setscriptablepartstate(_id_4961664664DC46E9, _id_92B14DB427332651, 0);
    level._id_EE4952B54817E69B[id].vfxent = vfxent;
  }
}

_id_81698DBDE152777A(id, _id_B3DA2B03E029F331) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_B3DA2B03E029F331) && isnumber(_id_B3DA2B03E029F331))
      level._id_EE4952B54817E69B[id]._id_87DC03BF741F1135 = _id_B3DA2B03E029F331;
    else
      level._id_EE4952B54817E69B[id]._id_87DC03BF741F1135 = 1;
  }
}

_id_0C41270BF88DAAEE(id, _id_B1699B23B473B12B) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_B1699B23B473B12B) && isnumber(_id_B1699B23B473B12B))
      level._id_EE4952B54817E69B[id]._id_DC27F870433DFA97 = _id_B1699B23B473B12B;
    else
      level._id_EE4952B54817E69B[id]._id_DC27F870433DFA97 = 1;
  }
}

_id_3A457EAE513BAA58(id) {
  level endon("game_ended");

  while(istrue(level._id_EE4952B54817E69B[id].isactive)) {
    level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD = level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD - 1;

    if(level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD <= 0)
      level._id_EE4952B54817E69B[id].isactive = 0;

    wait 1;
  }
}

_id_A4DADE3F7AC788A3(id, _id_9B7815840EE2619A) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_9B7815840EE2619A) && isnumber(_id_9B7815840EE2619A))
      level._id_EE4952B54817E69B[id]._id_D7E5D4F4C2A757B6 = _id_9B7815840EE2619A;
    else
      level._id_EE4952B54817E69B[id]._id_D7E5D4F4C2A757B6 = 1;
  }
}

_id_99338B877BA0B11A(id, _id_03F49997004B2DE5) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(_id_03F49997004B2DE5) && isnumber(_id_03F49997004B2DE5))
      level._id_EE4952B54817E69B[id]._id_88A88A218B58EE09 = _id_03F49997004B2DE5;
    else
      level._id_EE4952B54817E69B[id]._id_88A88A218B58EE09 = 0;
  }
}

_id_8FD8ED53A5EE98CA(id) {
  level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD = level._id_EE4952B54817E69B[id].lifetime;
  level._id_EE4952B54817E69B[id].isactive = 1;
  level._id_EE4952B54817E69B[id] thread _id_1CD0DD01BEB1E503(id);
  level._id_EE4952B54817E69B[id] thread _id_C6354FF1634CB81F(id);

  if(level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD > 0)
    level._id_EE4952B54817E69B[id] thread _id_3A457EAE513BAA58(id);
}

_id_D9CD87EA2DEA51FD(id) {
  if(_id_1BE5E0D403A7EDDC(id))
    level._id_EE4952B54817E69B[id]._id_B7E5026DFAF00CCD = level._id_EE4952B54817E69B[id].lifetime;
}

_id_1CD0DD01BEB1E503(id) {
  level endon("game_ended");

  if(!level._id_EE4952B54817E69B[id]._id_87DC03BF741F1135) {
    return;
  }
  while(istrue(level._id_EE4952B54817E69B[id].isactive)) {
    if(istrue(level._id_289DF80E1DED586F)) {
      if(isDefined(level.agentarray)) {
        foreach(agent in level.agentarray) {
          if(isDefined(agent) && isalive(agent) && _id_798B7526DBF940F7(id, agent))
            _id_720F7524463FEBB1(id, agent);
        }
      }
    }

    wait(_id_11DF9AF20130B828(id));
  }
}

_id_720F7524463FEBB1(id, agent) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    damage = _id_06563E466F2B8752(id);
    agent dodamage(int(damage), agent.origin, agent, undefined, "MOD_TRIGGER_HURT");
  }
}

_id_C6354FF1634CB81F(id) {
  if(!level._id_EE4952B54817E69B[id]._id_DC27F870433DFA97) {
    return;
  }
  while(istrue(level._id_EE4952B54817E69B[id].isactive)) {
    damage = _id_06563E466F2B8752(id);

    if(!isDefined(damage)) {
      return;
    }
    foreach(player in level.players) {
      if(isDefined(player)) {
        if(isDefined(player.origin) && !istrue(player.plotarmor) && _id_798B7526DBF940F7(id, player)) {
          if(istrue(level._id_EE4952B54817E69B[id]._id_88A88A218B58EE09)) {
            if(scripts\cp_mp\gasmask::hasgasmask(player) && damage > 0)
              player scripts\cp_mp\gasmask::processdamage(damage);
            else
              _id_02E88EF075A52625(id, player, damage);

            continue;
          }

          _id_02E88EF075A52625(id, player, damage);
        }
      }
    }

    wait(_id_11DF9AF20130B828(id));
  }
}

_id_02E88EF075A52625(id, player, damage) {
  if(damage > 0) {
    player dodamage(damage, player.origin, player, undefined, "MOD_TRIGGER_HURT");

    if(isDefined(self._id_AE6CB5204A331157) && self._id_AE6CB5204A331157 == "Butcher_Level_Damage") {
      player playsoundtoplayer("iw9_butcher_heat_damage", player);
      playFXOnTag(scripts\engine\utility::getfx("vfx_hween_butcher_burn"), player, "tag_origin");
    }

    if(_id_1BE5E0D403A7EDDC(id) && level._id_EE4952B54817E69B[id]._id_D7E5D4F4C2A757B6)
      player _id_07C40FA80892A721::damagearmor(damage);
  }
}

_id_CA8969486A1BA4CC(id) {
  if(_id_1BE5E0D403A7EDDC(id))
    return level._id_EE4952B54817E69B[id].origin;
}

_id_540EDFA451B0B144(id) {
  if(_id_1BE5E0D403A7EDDC(id))
    return level._id_EE4952B54817E69B[id]._id_AE6CB5204A331157;
}

_id_B3F7AA12E1464049(id) {
  if(_id_1BE5E0D403A7EDDC(id))
    return level._id_EE4952B54817E69B[id].height;
}

_id_5D4DE1BEEEA46131(id) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(level._id_EE4952B54817E69B[id].radius) && isnumber(level._id_EE4952B54817E69B[id].radius))
      return level._id_EE4952B54817E69B[id].radius;

    return 500;
  }
}

_id_06563E466F2B8752(id) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(level._id_EE4952B54817E69B[id]._id_76E563DB5D11A0EA) && isnumber(level._id_EE4952B54817E69B[id]._id_76E563DB5D11A0EA))
      return level._id_EE4952B54817E69B[id]._id_76E563DB5D11A0EA;

    return 0;
  }
}

_id_11DF9AF20130B828(id) {
  if(_id_1BE5E0D403A7EDDC(id)) {
    if(isDefined(level._id_EE4952B54817E69B[id]._id_572BCF962191BDA3) && isnumber(level._id_EE4952B54817E69B[id]._id_572BCF962191BDA3))
      return level._id_EE4952B54817E69B[id]._id_572BCF962191BDA3;

    return 1.0;
  }
}

_id_798B7526DBF940F7(id, ent) {
  if(_id_1BE5E0D403A7EDDC(id))
    return _id_8329A5A78F3890D0(id, ent.origin);

  return 0;
}

_id_8329A5A78F3890D0(id, _id_1CFCCAC3E5778BBB) {
  if(_id_1CFCCAC3E5778BBB[2] < level._id_EE4952B54817E69B[id].origin[2] + level._id_EE4952B54817E69B[id].height) {
    if(_id_1BE5E0D403A7EDDC(id) && isDefined(_id_1CFCCAC3E5778BBB) && isvector(_id_1CFCCAC3E5778BBB)) {
      _id_636A5C3EA300E982 = _id_794C0005C0F54659(id, _id_1CFCCAC3E5778BBB);
      return _id_636A5C3EA300E982 < level._id_EE4952B54817E69B[id].radius;
    }
  }

  return 0;
}

_id_794C0005C0F54659(id, _id_1CFCCAC3E5778BBB) {
  if(_id_1BE5E0D403A7EDDC(id) && isDefined(_id_1CFCCAC3E5778BBB) && isvector(_id_1CFCCAC3E5778BBB)) {
    if(isDefined(level._id_EE4952B54817E69B[id].origin))
      return distance2d(_id_1CFCCAC3E5778BBB, level._id_EE4952B54817E69B[id].origin);
  }

  return -1;
}

_id_30182707DC3F181D(id, origin) {
  if(_id_1BE5E0D403A7EDDC(id) && isDefined(origin) && isvector(origin)) {
    if(isDefined(level._id_EE4952B54817E69B[id].origin) && level._id_EE4952B54817E69B[id].radius)
      return distance2d(origin, level._id_EE4952B54817E69B[id].origin) - level._id_EE4952B54817E69B[id].radius;
  }
}

_id_D4355B3F2361DD69(id, origin) {
  if(_id_1BE5E0D403A7EDDC(id) && isDefined(origin) && isvector(origin)) {
    if(isDefined(level._id_EE4952B54817E69B[id].origin))
      return vectorNormalize(level._id_EE4952B54817E69B[id].origin - origin);
  }
}