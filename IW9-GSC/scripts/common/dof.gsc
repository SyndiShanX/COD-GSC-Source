/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\dof.gsc
***********************************************/

_id_9030FF462F3DAA1A() {
  if(getbuildversion() == "IW9") {
    return;
  }
  _id_E4268DB2ECB6FF71 = "scr_dyndofexp_clientnum";
  setdvarifuninitialized(_id_E4268DB2ECB6FF71, 0);
  _id_DCE8969E86D8A573 = "scr_dyndofexp_enable";
  setdvarifuninitialized(_id_DCE8969E86D8A573, 0);
  _id_37728F5D1856D25E = "scr_dyndofexp_fstop";
  setdvarifuninitialized(_id_37728F5D1856D25E, 1.2);
  _id_B8424BEC9BA28117 = "scr_dyndofexp_focusspeed";
  setdvarifuninitialized(_id_B8424BEC9BA28117, 5);
  _id_F2D0BA32B887FFDF = "scr_dyndofexp_aperturespeed";
  setdvarifuninitialized(_id_F2D0BA32B887FFDF, 5);
  values = [];
  values[_id_37728F5D1856D25E] = -1;
  values[_id_B8424BEC9BA28117] = -1;
  values[_id_F2D0BA32B887FFDF] = -1;
  clientnum = -1;
  _id_18D25E8C9F508A2B = 0;

  for(;;) {
    wait 1;

    if(!getdvarint(_id_DCE8969E86D8A573)) {
      if(_id_18D25E8C9F508A2B) {
        _id_18D25E8C9F508A2B = 0;
        level notify("stop_dyndof");
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      continue;
    }

    if(scripts\common\utility::ismp() && getdvarint(_id_E4268DB2ECB6FF71) != clientnum) {
      for(;;) {
        clientnum = getdvarint(_id_E4268DB2ECB6FF71);

        if(isDefined(_id_CB47153207FC68D2(clientnum))) {
          break;
        }

        waitframe();
      }

      _id_0DB7BAE3D5D2E993(_id_CB47153207FC68D2(clientnum));
    }

    _id_C3FB6FB403780040 = 0;

    foreach(dvar, val in values) {
      if(val != getdvarfloat(dvar)) {
        _id_C3FB6FB403780040 = 1;
        break;
      }
    }

    if(_id_C3FB6FB403780040 || !_id_18D25E8C9F508A2B) {
      fstop = getdvarfloat(_id_37728F5D1856D25E);
      focusspeed = getdvarfloat(_id_B8424BEC9BA28117);
      aperturespeed = getdvarfloat(_id_F2D0BA32B887FFDF);
      values[_id_37728F5D1856D25E] = fstop;
      values[_id_B8424BEC9BA28117] = focusspeed;
      values[_id_F2D0BA32B887FFDF] = aperturespeed;
      _id_18D25E8C9F508A2B = 1;
      level thread _id_C1F42ED707642A04(fstop, focusspeed, aperturespeed);
    }
  }
}

_id_0DB7BAE3D5D2E993(player) {
  if(!isDefined(level.dyndof)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  level.dyndof notify("new_player");

  if(isDefined(level.dyndof.player)) {
    level.dyndof.player disablephysicaldepthoffieldscripting();
    player enablephysicaldepthoffieldscripting();
  }

  level.dyndof.player = player;
  level.dyndof.ignorelist = [player];

  if(scripts\common\utility::ismp())
    thread _id_BEE71193BCA6C80C();
}

_id_BEE71193BCA6C80C() {
  level.dyndof endon("new_player");
  level.dyndof.player endon("disconnected");

  for(;;) {
    level.dyndof.player waittill("death");

    if(!isDefined(level.dyndof.player)) {
      return;
    }
    level.dyndof.player waittill("spawned");

    if(!isDefined(level.dyndof.player)) {
      return;
    }
    level.dyndof.player enablephysicaldepthoffieldscripting();
  }
}

_id_CB47153207FC68D2(num) {
  foreach(player in level.players) {
    if(player getentitynumber() == num)
      return player;
  }

  return undefined;
}

_id_C7A153413FA65E8D(fstop, focusspeed, aperturespeed) {
  level.dyndof.fstop = fstop;
  level.dyndof.focusspeed = focusspeed;
  level.dyndof.aperturespeed = aperturespeed;
}

_id_C1F42ED707642A04(fstop, focusspeed, aperturespeed) {
  if(isDefined(level.dyndof)) {
    _id_C7A153413FA65E8D(fstop, focusspeed, aperturespeed);
    return;
  }

  if(!isDefined(focusspeed))
    focusspeed = 1.0;

  if(!isDefined(aperturespeed))
    aperturespeed = 2.0;

  level notify("stop_dyndof");

  if(!scripts\engine\utility::flag_exist("dyndofexp_disable"))
    scripts\engine\utility::flag_init("dyndofexp_disable");

  if(isDefined(level.dyndof)) {
    level.dyndof = undefined;
    level notify("stop_dyndof");
  }

  level.dyndof = _id_4A2CE820849A53F7();
  _id_C7A153413FA65E8D(fstop, focusspeed, aperturespeed);
  level.dyndof._id_A94780CFBEFAD9CE = -1;
  level.dyndof._id_A28A7E3E13FA8C7F = 3.5;
  level.dyndof._id_E44CD1048EFCCA59 = 30;
  level.dyndof._id_E429E3048ED6AA37 = 72;
  level.dyndof._id_21146C5C5D706CBE = focusspeed * 5;
  level.dyndof._id_CFBD6DC46C776A0A = 30;
  level.dyndof._id_CFE077C46C9DC7C0 = 72;
  level.dyndof._id_D453B380DFD6161D = 0;
  level.dyndof.issp = scripts\common\utility::issp();

  if(level.dyndof.issp) {
    setsaveddvar("r_dof_physical_enable", 1);
    _id_0DB7BAE3D5D2E993(level.player);
  } else
    _id_0DB7BAE3D5D2E993(_id_CB47153207FC68D2(getdvarint("scr_dyndofexp_clientnum")));

  level.dyndof.player enablephysicaldepthoffieldscripting();
  _id_8EC129EE5A53F0BC();
  _id_50C7801FC0ABBD3A();
  level thread _id_91D67D689E8A5AC5();
}

_id_4A2CE820849A53F7() {
  struct = spawnStruct();
  struct.maxfocusdist = 50000;
  struct.contents = _id_121B9C1E3A5664AF();
  struct._id_E00802AD31E19EE4 = _id_0E7A3F680F309A5A();
  struct.traceangle = 3;
  struct.prevangles = (0, 0, 0);
  struct.prevorigin = (0, 0, 0);
  return struct;
}

_id_121B9C1E3A5664AF() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water", "physicscontents_characterproxy"];
  return physics_createcontents(contents);
}

_id_0E7A3F680F309A5A() {
  contents = ["physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(contents);
}

_id_91D67D689E8A5AC5() {
  level endon("stop_dyndof");
  _id_0EB2609C9A7A036F = gettime() + 500;
  _id_9E471B081EA6E696 = level.dyndof._id_D453B380DFD6161D;
  setdvarifuninitialized("scr_dyndofexp", 1);
  _id_0D6656715A63C5AC = 0;

  for(;;) {
    if(scripts\engine\utility::flag("dyndofexp_disable") || !getdvarint("scr_dyndofexp")) {
      if(!_id_0D6656715A63C5AC) {
        _id_0D6656715A63C5AC = 1;
        level.dyndof.player disablephysicaldepthoffieldscripting();
      }

      wait 0.5;
      continue;
    }

    if(_id_0D6656715A63C5AC) {
      level.dyndof.player enablephysicaldepthoffieldscripting();
      _id_0D6656715A63C5AC = 0;
    }

    if(!isDefined(level.dyndof.player)) {
      wait 0.5;
      continue;
    }

    if(gettime() > _id_0EB2609C9A7A036F) {
      _id_0EB2609C9A7A036F = gettime() + 500;
      _id_8EC129EE5A53F0BC();
      _id_9E471B081EA6E696 = level.dyndof._id_D453B380DFD6161D;
    }

    object = _id_DDD1E6B7BD85C6D1();

    if(getdvarint("scr_dyndofexp_debug", 0)) {}

    if(object._id_6AEF61126A847ED6 < level.dyndof._id_E429E3048ED6AA37) {
      frac = scripts\engine\math::normalize_value(level.dyndof._id_E44CD1048EFCCA59, level.dyndof._id_E429E3048ED6AA37, object._id_6AEF61126A847ED6);
      fstop = scripts\engine\math::lerp(level.dyndof._id_A28A7E3E13FA8C7F, level.dyndof.fstop, frac);
    } else
      fstop = level.dyndof.fstop;

    if(object._id_6AEF61126A847ED6 < level.dyndof._id_CFE077C46C9DC7C0) {
      frac = scripts\engine\math::normalize_value(level.dyndof._id_CFBD6DC46C776A0A, level.dyndof._id_CFE077C46C9DC7C0, object._id_6AEF61126A847ED6);
      focusspeed = scripts\engine\math::lerp(level.dyndof._id_21146C5C5D706CBE, level.dyndof.focusspeed, frac);
    } else
      focusspeed = level.dyndof.focusspeed;

    level.dyndof.player setphysicaldepthoffield(fstop, 1, focusspeed, level.dyndof.aperturespeed, object.origin);
    waitframe();
  }
}

_id_DDD1E6B7BD85C6D1() {
  self endon("death");
  _id_D72CBD1B5B80586B = _id_7641C664CF37B604();
  _id_A66FD1B124C32F51 = level.dyndof.player getplayerangles();
  level.dyndof.prevorigin = _id_D72CBD1B5B80586B;
  level.dyndof.prevangles = _id_A66FD1B124C32F51;
  _id_0CAB8F864AC7D1B1 = _id_B23EB6EBE631CCDC(_id_D72CBD1B5B80586B, _id_A66FD1B124C32F51);

  if(getdvarint("scr_dyndofexp_debug") == 3)
    _id_0CAB8F864AC7D1B1._id_CA6D02ADA0248C95 = 0;

  _id_A3D92ABC0BCA4A49 = _id_0AC3EC9D38FD2434(_id_D72CBD1B5B80586B, _id_A66FD1B124C32F51);

  if(getdvarint("scr_dyndofexp_debug") == 4)
    _id_A3D92ABC0BCA4A49._id_600483BE071C0218 = 0;

  if(isDefined(_id_A3D92ABC0BCA4A49) && _id_A3D92ABC0BCA4A49._id_600483BE071C0218 > _id_0CAB8F864AC7D1B1._id_CA6D02ADA0248C95) {
    if(getdvarint("scr_dyndofexp_debug")) {}

    return _id_A3D92ABC0BCA4A49;
  } else {
    if(getdvarint("scr_dyndofexp_debug")) {}

    return _id_0CAB8F864AC7D1B1;
  }
}

_id_8EC129EE5A53F0BC() {
  _id_3855BF447C80FB8A = getdvarint("cg_targetBaseFov");

  if(getdvarint("cg_targetBaseFov") == level.dyndof._id_D453B380DFD6161D) {
    return;
  }
  _id_16A279669870D122 = 8;
  _id_F9CCDE8E142055EF = 4;
  angle = _id_3855BF447C80FB8A * 0.6 / _id_16A279669870D122;
  level.dyndof._id_D453B380DFD6161D = _id_3855BF447C80FB8A;
  _id_801C42D2E14B7C0C = angle * _id_16A279669870D122 * -1;
  _id_6B84C5404B57E175 = angle * _id_F9CCDE8E142055EF * -1;
  _id_C57C437404405A37 = _id_16A279669870D122 * 2;
  _id_4C1DEC663DB42F82 = _id_F9CCDE8E142055EF * 2;
  _id_2B9E8BC3BE1DBD7E[0][0] = 0;
  _id_3C141DF65714D228 = 12000;
  _id_47EF1080427D4D3A = 0;

  for(x = 0; x < _id_C57C437404405A37 + 1; x++) {
    for(y = 0; y < _id_4C1DEC663DB42F82 + 1; y++) {
      struct = spawnStruct();
      struct._id_F85AB554F9F088C8 = (y * angle + _id_6B84C5404B57E175, x * angle + _id_801C42D2E14B7C0C, 0);
      _id_2B9E8BC3BE1DBD7E[x][y] = struct;
      _id_4ECF940F285AB6D2 = _id_16A279669870D122 - abs(_id_16A279669870D122 - x) + (_id_F9CCDE8E142055EF - abs(_id_F9CCDE8E142055EF - y));
      struct._id_174CF20FBA5BAC82 = exp(_id_4ECF940F285AB6D2 * 1);

      if(struct._id_174CF20FBA5BAC82 > _id_47EF1080427D4D3A) {
        _id_47EF1080427D4D3A = struct._id_174CF20FBA5BAC82;
        continue;
      }

      if(struct._id_174CF20FBA5BAC82 < _id_3C141DF65714D228)
        _id_3C141DF65714D228 = struct._id_174CF20FBA5BAC82;
    }
  }

  level.dyndof._id_E2A735FF704C61AA = _id_2B9E8BC3BE1DBD7E[_id_16A279669870D122][_id_F9CCDE8E142055EF];

  foreach(x, array in _id_2B9E8BC3BE1DBD7E) {
    foreach(y, struct in array)
    struct._id_174CF20FBA5BAC82 = scripts\engine\math::normalize_value(_id_3C141DF65714D228, _id_47EF1080427D4D3A, struct._id_174CF20FBA5BAC82) * 10;
  }

  level.dyndof._id_72574FBB08A1BE5C = _id_2B9E8BC3BE1DBD7E;
}

_id_B23EB6EBE631CCDC(_id_D72CBD1B5B80586B, _id_A66FD1B124C32F51) {
  traces = [];
  _id_D5618CFA8D092E87 = 0;
  _id_1BBD65EC7FE70A49 = undefined;

  foreach(array in level.dyndof._id_72574FBB08A1BE5C) {
    foreach(struct in array) {
      struct.trace = _id_77D9A6389A3305EE(_id_D72CBD1B5B80586B, _id_A66FD1B124C32F51, struct._id_F85AB554F9F088C8);
      struct.origin = struct.trace["position"];
      struct._id_6AEF61126A847ED6 = distance(_id_D72CBD1B5B80586B, struct.origin);
      _id_D5618CFA8D092E87 = _id_D5618CFA8D092E87 + struct._id_6AEF61126A847ED6;

      if(!isDefined(_id_1BBD65EC7FE70A49)) {
        _id_1BBD65EC7FE70A49 = struct;
        continue;
      }

      if(struct._id_6AEF61126A847ED6 < _id_1BBD65EC7FE70A49._id_6AEF61126A847ED6)
        _id_1BBD65EC7FE70A49 = struct;
    }
  }

  level.dyndof._id_1FEF56BC059B6F9A = _id_1BBD65EC7FE70A49;
  _id_57C487E02C82AE4B = [];
  _id_9CEA65C4CFF49987 = [];

  foreach(x, array in level.dyndof._id_72574FBB08A1BE5C) {
    foreach(y, struct in array) {
      div = abs(_id_1BBD65EC7FE70A49._id_6AEF61126A847ED6 - struct._id_6AEF61126A847ED6) / 30;

      if(div > 6)
        div = 6;

      struct._id_0CB63D1EC2AC5378 = int(max(div, 1));
      _id_25942E825FEBC4CA = 1 + scripts\engine\math::normalize_value(0, 7, 7 - struct._id_0CB63D1EC2AC5378);
      struct._id_600483BE071C0218 = int(_id_25942E825FEBC4CA * struct._id_174CF20FBA5BAC82 * 10);

      if(!isDefined(_id_57C487E02C82AE4B[struct._id_0CB63D1EC2AC5378])) {
        _id_57C487E02C82AE4B[struct._id_0CB63D1EC2AC5378] = 0;
        _id_9CEA65C4CFF49987[struct._id_0CB63D1EC2AC5378] = 0;
      }

      _id_57C487E02C82AE4B[struct._id_0CB63D1EC2AC5378] = _id_57C487E02C82AE4B[struct._id_0CB63D1EC2AC5378] + struct._id_600483BE071C0218;
      _id_9CEA65C4CFF49987[struct._id_0CB63D1EC2AC5378]++;
    }
  }

  keys = getarraykeys(_id_57C487E02C82AE4B);
  _id_1041BF9752418D22 = _id_57C487E02C82AE4B[keys[0]];
  _id_2F61B87587E59816 = keys[0];

  foreach(index, _id_37A3B21EE1EBEA60 in _id_57C487E02C82AE4B) {
    if(_id_1041BF9752418D22 < _id_37A3B21EE1EBEA60) {
      _id_1041BF9752418D22 = _id_37A3B21EE1EBEA60;
      _id_2F61B87587E59816 = index;
    }
  }

  _id_C7761B0132ABCFA7 = 0;
  _id_824EBAB3E990A6BA = undefined;

  foreach(x, array in level.dyndof._id_72574FBB08A1BE5C) {
    foreach(y, struct in array) {
      if(struct._id_0CB63D1EC2AC5378 != _id_2F61B87587E59816) {
        continue;
      }
      if(struct._id_600483BE071C0218 > _id_C7761B0132ABCFA7) {
        _id_C7761B0132ABCFA7 = struct._id_600483BE071C0218;
        _id_824EBAB3E990A6BA = struct;
      }
    }
  }

  if(!isDefined(_id_824EBAB3E990A6BA))
    _id_824EBAB3E990A6BA = level.dyndof._id_E2A735FF704C61AA;

  if(getdvarint("scr_dyndofexp_debug")) {}

  _id_824EBAB3E990A6BA._id_CA6D02ADA0248C95 = _id_57C487E02C82AE4B[_id_824EBAB3E990A6BA._id_0CB63D1EC2AC5378];
  level thread _id_ABFBC195C3AAC94C(_id_D72CBD1B5B80586B, _id_2F61B87587E59816);
  return _id_824EBAB3E990A6BA;
}

_id_50C7801FC0ABBD3A() {
  if(gettime() > level.dyndof._id_A94780CFBEFAD9CE) {
    level.dyndof._id_A94780CFBEFAD9CE = gettime() + 1000;
    level.dyndof.cosfov = cos(getdvarfloat("cg_targetBaseFov"));
    level.dyndof._id_4CC8F2B112CADDE0 = level.dyndof.cosfov * 50;
  }
}

_id_0AC3EC9D38FD2434(_id_B3D7CE1408952F4D, _id_3C70A7175FBFA3FC) {
  ents = getaiarray();

  if(!level.dyndof.issp) {
    players = [];

    foreach(player in level.players) {
      if(player == level.dyndof.player) {
        continue;
      }
      players[players.size] = player;
    }

    ents = scripts\engine\utility::array_combine(ents, players);
  }

  if(isDefined(level._id_7FFFA6C3F269FFC9))
    ents = scripts\engine\utility::array_combine(ents, [[level._id_7FFFA6C3F269FFC9]]());

  ents = scripts\engine\utility::array_removeundefined(ents);

  foreach(ent in ents) {
    if(ent.classname != "script_model") {
      continue;
    }
    if(isDefined(ent._id_5CB5BEA2F8851B21)) {
      continue;
    }
    _id_DE8A45DD2BF968EC = getsubstr(ent.model, 0, 5);

    if(_id_DE8A45DD2BF968EC == "body_") {
      ent._id_5CB5BEA2F8851B21 = 1;
      continue;
    }

    ent._id_5CB5BEA2F8851B21 = 0;
  }

  _id_50C7801FC0ABBD3A();
  _id_20AF753DED3657E1 = anglesToForward(_id_3C70A7175FBFA3FC);

  foreach(ent in ents) {
    _id_6EA84411E400D974 = 0;

    if(isai(ent) || isDefined(ent._id_5CB5BEA2F8851B21) || isPlayer(ent))
      _id_6EA84411E400D974 = 1;

    ent._id_600483BE071C0218 = 0;

    if(_id_6EA84411E400D974 && distancesquared(level.dyndof.player.origin, ent.origin) < 62500)
      _id_47293B1E94FF8FB0 = _id_41AE85DD67830A98(ent, _id_B3D7CE1408952F4D, _id_20AF753DED3657E1);
    else
      _id_47293B1E94FF8FB0 = ent.origin + (0, 0, 60);

    ent._id_965C7DB1CDC6F221 = _id_47293B1E94FF8FB0;
    dot = _id_CE15D73CABDC73A4(_id_47293B1E94FF8FB0, _id_B3D7CE1408952F4D, _id_20AF753DED3657E1);
    ent._id_3281B3968A75B9B9 = dot;

    if(dot > level.dyndof.cosfov) {
      _id_0425C05C7E072828 = scripts\engine\math::normalize_value(level.dyndof.cosfov, 1, dot);
      score = pow(_id_0425C05C7E072828, 15) * 1100;
      ent._id_600483BE071C0218 = ent._id_600483BE071C0218 + score;

      if(getdvarint("scr_dyndofexp_debug")) {}
    }

    if(ent._id_600483BE071C0218 == 0) {
      continue;
    }
    ent._id_6AEF61126A847ED6 = distance(_id_47293B1E94FF8FB0, _id_B3D7CE1408952F4D);

    if(ent._id_6AEF61126A847ED6 < 2000) {
      if(ent._id_6AEF61126A847ED6 < 200) {
        frac = ent._id_6AEF61126A847ED6 / 200;
        _id_7A73315D7CA78155 = 100 + 300 * pow(1 - frac, 2);
        ent._id_600483BE071C0218 = ent._id_600483BE071C0218 + _id_7A73315D7CA78155;
      } else {
        frac = ent._id_6AEF61126A847ED6 / 2000;
        _id_7A73315D7CA78155 = 100 * (1 - frac);
        ent._id_600483BE071C0218 = ent._id_600483BE071C0218 + _id_7A73315D7CA78155;
      }

      if(getdvarint("scr_dyndofexp_debug")) {}
    } else {
      _id_E9A9875D12A0A4F1 = 2000 / ent._id_6AEF61126A847ED6 * 0.5;
      ent._id_600483BE071C0218 = ent._id_600483BE071C0218 * (_id_E9A9875D12A0A4F1 * 0.5);

      if(getdvarint("scr_dyndofexp_debug")) {}
    }

    if(ent._id_600483BE071C0218 > 0) {
      trace = scripts\engine\trace::ray_trace(_id_B3D7CE1408952F4D, _id_47293B1E94FF8FB0, [ent, level.dyndof.player], level.dyndof.contents, 1);

      if(trace["fraction"] > 0.9) {
        scale = 1;
        ent._id_600483BE071C0218 = ent._id_600483BE071C0218 * scale;
      } else {
        scale = 0;
        ent._id_600483BE071C0218 = 0;
      }

      if(getdvarint("scr_dyndofexp_debug")) {}
    }

    ent._id_600483BE071C0218 = int(ent._id_600483BE071C0218);

    if(getdvarint("scr_dyndofexp_debug")) {}
  }

  _id_5B11B54680162012 = [];
  _id_6E2B9D3E75679206 = level.dyndof.issp;

  if(_id_6E2B9D3E75679206) {
    foreach(ent in ents) {
      if(!isPlayer(ent) && !isai(ent) && !isDefined(ent._id_5CB5BEA2F8851B21)) {
        continue;
      }
      if(ent._id_600483BE071C0218 > 0 && ent._id_3281B3968A75B9B9 > 0.9) {
        _id_5B11B54680162012[_id_5B11B54680162012.size] = ent;

        if(getdvarint("scr_dyndofexp_debug")) {}
      }
    }

    _id_5B11B54680162012 = sortbydistance(_id_5B11B54680162012, _id_B3D7CE1408952F4D);
  }

  _id_053A4DA52F050A4F = 80;
  _id_BC03C69DED904A6C = undefined;

  foreach(ent in ents) {
    if(!isDefined(ent)) {
      continue;
    }
    if(_id_6E2B9D3E75679206 && (isai(ent) || isDefined(ent._id_5CB5BEA2F8851B21)) && ent._id_600483BE071C0218 > 0 && ent._id_3281B3968A75B9B9 > 0.99) {
      foreach(_id_363574E3062381D5 in _id_5B11B54680162012) {
        if(_id_363574E3062381D5 == ent) {
          continue;
        }
        if(_id_363574E3062381D5._id_6AEF61126A847ED6 < ent._id_6AEF61126A847ED6 && _id_7D02F8D29555766E(_id_B3D7CE1408952F4D, ent._id_965C7DB1CDC6F221, _id_363574E3062381D5.origin)) {
          ent._id_600483BE071C0218 = 0;

          if(getdvarint("scr_dyndofexp_debug")) {}

          break;
        }
      }
    }

    if(ent._id_600483BE071C0218 > _id_053A4DA52F050A4F) {
      _id_BC03C69DED904A6C = ent;
      _id_053A4DA52F050A4F = ent._id_600483BE071C0218;
    }
  }

  struct = undefined;

  if(isDefined(_id_BC03C69DED904A6C)) {
    struct = spawnStruct();
    struct.origin = _id_BC03C69DED904A6C.origin;
    struct._id_600483BE071C0218 = _id_BC03C69DED904A6C._id_600483BE071C0218;
    struct.origin = _id_BC03C69DED904A6C._id_965C7DB1CDC6F221;
    struct._id_6AEF61126A847ED6 = _id_BC03C69DED904A6C._id_6AEF61126A847ED6;

    if(getdvarint("scr_dyndofexp_debug")) {}
  }

  return struct;
}

_id_41AE85DD67830A98(ent, _id_B3D7CE1408952F4D, _id_20AF753DED3657E1) {
  _id_8DFE400822854558 = ["j_spineupper"];
  _id_16282B6EA4DB8F90 = "tag_eye";
  _id_1D79B096FABF6E52 = ent gettagorigin(_id_16282B6EA4DB8F90);
  _id_0385B66E74A17EC7 = _id_CE15D73CABDC73A4(_id_1D79B096FABF6E52, _id_B3D7CE1408952F4D, _id_20AF753DED3657E1);

  foreach(tag in _id_8DFE400822854558) {
    tagorigin = ent gettagorigin(tag);
    dot = _id_CE15D73CABDC73A4(tagorigin, _id_B3D7CE1408952F4D, _id_20AF753DED3657E1);

    if(dot > _id_0385B66E74A17EC7) {
      _id_0385B66E74A17EC7 = dot;
      _id_16282B6EA4DB8F90 = tag;
      _id_1D79B096FABF6E52 = tagorigin;
    }
  }

  return _id_1D79B096FABF6E52;
}

_id_CE15D73CABDC73A4(targetorigin, sourcepos, _id_4B83E9936868EA11) {
  normal = vectorNormalize(targetorigin - sourcepos);
  return vectordot(_id_4B83E9936868EA11, normal);
}

_id_77D9A6389A3305EE(_id_D72CBD1B5B80586B, _id_3C70A7175FBFA3FC, _id_F85AB554F9F088C8, pos) {
  angles = combineangles(_id_3C70A7175FBFA3FC, _id_F85AB554F9F088C8);

  if(!isDefined(pos))
    pos = _id_D72CBD1B5B80586B + anglesToForward(angles) * level.dyndof.maxfocusdist;

  trace = physics_raycast(_id_D72CBD1B5B80586B, pos, level.dyndof._id_E00802AD31E19EE4, level.dyndof.ignorelist, 1, "physicsquery_closest", 1);

  if(!isDefined(trace) || trace.size == 0)
    trace = scripts\engine\trace::internal_pack_default_trace(pos);
  else
    trace = trace[0];

  return trace;
}

_id_7641C664CF37B604() {
  if(level.dyndof.player islinked()) {
    linkedent = level.dyndof.player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(scripts\engine\utility::hastag(linkedent.model, "tag_camera"))
          linkedent.dyndof_hastag = 1;
      }
    }

    if(linkedent.dyndof_hastag)
      return linkedent gettagorigin("tag_camera");
  }

  return level.dyndof.player getvieworigin();
}

_id_ABFBC195C3AAC94C(_id_D72CBD1B5B80586B, _id_1041BF9752418D22) {
  level notify("stop_dyndof_debug");
  level endon("stop_dyndof");
  level endon("stop_dyndof_debug");
}

_id_28AC1E5F07CC8EA8(pos, color) {
  range = 1;

  if(!isDefined(color))
    color = (1, 1, 1);
}

_id_7D02F8D29555766E(start, end, _id_3B4D8AB7E1947F44) {
  _id_5A5ADE6F6717EBC2 = vectorNormalize(end - start);
  radius = 8;
  _id_0007886519945082 = _id_3B4D8AB7E1947F44 + (0, 0, 70);
  _id_3E3553D5BCFB767C = _id_0007886519945082 - _id_3B4D8AB7E1947F44;
  _id_A4753FBD89CE084F = start - _id_3B4D8AB7E1947F44;
  _id_E3516DBA67D45EFB = vectorcross(_id_A4753FBD89CE084F, _id_3E3553D5BCFB767C);
  _id_424283857447CEE9 = vectorcross(_id_5A5ADE6F6717EBC2, _id_3E3553D5BCFB767C);
  _id_9B2F6DD030CC1244 = vectordot(_id_3E3553D5BCFB767C, _id_3E3553D5BCFB767C);
  a = vectordot(_id_424283857447CEE9, _id_424283857447CEE9);
  b = 2 * vectordot(_id_424283857447CEE9, _id_E3516DBA67D45EFB);
  c = vectordot(_id_E3516DBA67D45EFB, _id_E3516DBA67D45EFB) - radius * radius * _id_9B2F6DD030CC1244;
  dist = b * b - 4 * a * c;

  if(dist < 0)
    return 0;

  time = (b * -1 - sqrt(dist)) / (2 * a);

  if(time == length(end - start))
    return 0;

  if(time < 0)
    return 0;

  _id_221FD849D726170C = start + _id_5A5ADE6F6717EBC2 * time;
  return 1;
}

dyndof(fstop, _id_B3AEFAFBA795117F, focusspeed, aperturespeed, angles, _id_387062334AB0E50E, ignorelist, ignorecollision, _id_4A0992CE3FF1D7EA) {
  if(!isDefined(focusspeed))
    focusspeed = 1.0;

  if(!isDefined(aperturespeed))
    aperturespeed = 2.0;

  if(!isDefined(ignorecollision))
    ignorecollision = 0;

  player = self;
  player notify("stop_dyndof");

  if(scripts\common\utility::issp())
    setsaveddvar("r_dof_physical_enable", 1);

  player enablephysicaldepthoffieldscripting();

  if(isDefined(player.dyndof))
    player.dyndof = player destroy_dyndof();

  player.dyndof = create_dyndof();
  player.dyndof.fstop = fstop;
  player.dyndof.focusspeed = focusspeed;
  player.dyndof.aperturespeed = aperturespeed;

  if(isstring(_id_387062334AB0E50E))
    player.dyndof.desiredbone = _id_387062334AB0E50E;
  else if(isvector(_id_387062334AB0E50E))
    player.dyndof._id_B25886E4707AC7CD = _id_387062334AB0E50E;
  else if(isnumber(_id_387062334AB0E50E))
    player.dyndof._id_1BAE2B3ECE322CB6 = _id_387062334AB0E50E;

  player.dyndof.ignorecollision = ignorecollision;
  player.dyndof._id_4A0992CE3FF1D7EA = _id_4A0992CE3FF1D7EA;

  if(isDefined(ignorelist))
    player.dyndof.ignorelist = ignorelist;
  else
    player.dyndof.ignorelist = [player];

  if(isDefined(angles))
    player.dyndof.traceangle = angles;

  player thread dyndof_thread(_id_B3AEFAFBA795117F);
}

dyndof_disable() {
  player = self;
  player notify("stop_dyndof");
  player notify("stop_dyndof_debug");
  player disablephysicaldepthoffieldscripting();
  player destroy_dyndof();
}

dyndof_thread(_id_B3AEFAFBA795117F) {
  player = self;

  if(isDefined(_id_B3AEFAFBA795117F))
    _id_B3AEFAFBA795117F endon("death");

  level endon("stop_dyndof");
  player endon("stop_dyndof");

  for(;;) {
    if(isDefined(player.dyndof._id_B25886E4707AC7CD) && player.dyndof.ignorecollision)
      pos = player.dyndof._id_B25886E4707AC7CD;
    else if(isDefined(player.dyndof._id_1BAE2B3ECE322CB6) && player.dyndof.ignorecollision)
      pos = player.player getEye() + anglesToForward(player.player getgunangles()) * player.dyndof._id_1BAE2B3ECE322CB6;
    else
      pos = player dyndof_distance(_id_B3AEFAFBA795117F);

    if(!isint(pos))
      player setphysicaldepthoffield(player.dyndof.fstop, 1, player.dyndof.focusspeed, player.dyndof.aperturespeed, pos);
    else {}

    waitframe();
  }
}

dyndof_distance(_id_B3AEFAFBA795117F) {
  player = self;

  if(isDefined(_id_B3AEFAFBA795117F)) {
    _id_B3AEFAFBA795117F endon("death");
    _id_E82AAE86D95CE0D9["entity"] = _id_B3AEFAFBA795117F;

    if(isent(_id_B3AEFAFBA795117F) && isDefined(_id_B3AEFAFBA795117F.model)) {
      if(!isDefined(player.dyndof.bone)) {
        if(isDefined(player.dyndof.desiredbone))
          bone = player.dyndof.desiredbone;
        else
          bone = "tag_eye";

        _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F.origin;
        _id_E82AAE86D95CE0D9["hittype"] = bone + " DOESN'T EXIST";
        pos = _id_E82AAE86D95CE0D9["position"];
        _id_E82AAE86D95CE0D9["hittype"] = bone + " DOESN'T EXIST";
        pos = _id_E82AAE86D95CE0D9["position"];

        if(isDefined(_id_B3AEFAFBA795117F.headmodel)) {
          _id_6445EC1E71D64192 = getnumparts(_id_B3AEFAFBA795117F.headmodel);

          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6445EC1E71D64192; _id_AC0E594AC96AA3A8++) {
            if(getpartname(_id_B3AEFAFBA795117F.headmodel, _id_AC0E594AC96AA3A8) == bone) {
              player.dyndof.bone = bone;
              _id_E82AAE86D95CE0D9["hittype"] = player.dyndof.bone;
              _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F gettagorigin(player.dyndof.bone);
              pos = _id_E82AAE86D95CE0D9["position"];
              break;
            }
          }
        }

        if(isDefined(_id_B3AEFAFBA795117F.attachedweaponmodels)) {
          foreach(n, model in _id_B3AEFAFBA795117F.attachedweaponmodels) {
            _id_6445EC1E71D64192 = getnumparts(_id_B3AEFAFBA795117F.attachedweaponmodels[n]);

            for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6445EC1E71D64192; _id_AC0E594AC96AA3A8++) {
              if(getpartname(_id_B3AEFAFBA795117F.attachedweaponmodels[n], _id_AC0E594AC96AA3A8) == bone) {
                player.dyndof.bone = bone;
                _id_E82AAE86D95CE0D9["hittype"] = player.dyndof.bone;
                _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F gettagorigin(player.dyndof.bone);
                pos = _id_E82AAE86D95CE0D9["position"];
                break;
              }
            }
          }
        }

        _id_6445EC1E71D64192 = getnumparts(_id_B3AEFAFBA795117F.model);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6445EC1E71D64192; _id_AC0E594AC96AA3A8++) {
          if(getpartname(_id_B3AEFAFBA795117F.model, _id_AC0E594AC96AA3A8) == bone) {
            player.dyndof.bone = bone;
            _id_E82AAE86D95CE0D9["hittype"] = player.dyndof.bone;
            _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F gettagorigin(player.dyndof.bone);
            pos = _id_E82AAE86D95CE0D9["position"];
            break;
          }
        }
      } else {
        _id_E82AAE86D95CE0D9["hittype"] = player.dyndof.bone;
        _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F gettagorigin(player.dyndof.bone);
        pos = _id_E82AAE86D95CE0D9["position"];
      }
    } else {
      _id_E82AAE86D95CE0D9["hittype"] = "struct or no bones";
      _id_E82AAE86D95CE0D9["position"] = _id_B3AEFAFBA795117F.origin;
      pos = _id_E82AAE86D95CE0D9["position"];
    }

    if(isDefined(player worldpointtoscreenpos(pos, getdvarint("cg_targetBaseFov"))) && dyndof_trace_target(pos)) {
      if(player.dyndof.prevorigin == pos)
        return -1;

      player.dyndof.prevorigin = pos;
      return _id_E82AAE86D95CE0D9["position"];
    } else if(istrue(player.dyndof._id_4A0992CE3FF1D7EA)) {
      _id_377995BB71C43DFB = player getEye();
      _id_6E20E569F2C0DF7F = pos - _id_377995BB71C43DFB;
      _id_B5F9A488EDACFBBE = anglesToForward(player getgunangles());
      dot = vectordot(_id_6E20E569F2C0DF7F, _id_B5F9A488EDACFBBE);

      if(dot > 0)
        _id_92F914F8AED12F65 = _id_377995BB71C43DFB + _id_B5F9A488EDACFBBE * dot;
      else
        _id_92F914F8AED12F65 = _id_377995BB71C43DFB;

      return _id_92F914F8AED12F65;
    }
  }

  pos = dyndof_getplayerorigin();
  angles = dyndof_getplayerangles();

  if(player.dyndof.prevorigin == pos && player.dyndof.prevangles == angles) {
    if(!isDefined(player.dyndof.firstnomovetime))
      player.dyndof.firstnomovetime = gettime();
    else if(gettime() - player.dyndof.firstnomovetime > 2000)
      return -1;
  } else
    player.dyndof.firstnomovetime = undefined;

  player.dyndof.prevorigin = pos;
  player.dyndof.prevangles = angles;
  angles = [];
  angle = player.dyndof.traceangle;
  angles[angles.size] = (angle * -1, 0, 0);
  angles[angles.size] = (0, angle, 0);
  angles[angles.size] = (0, angle * -1, 0);
  angles[angles.size] = (0, 0, 0);
  traces = [];

  foreach(index, a in angles) {
    if(isDefined(player.dyndof._id_B25886E4707AC7CD))
      trace = dyndof_trace_internal(a, player.dyndof._id_B25886E4707AC7CD);
    else
      trace = dyndof_trace_internal(a, undefined);

    if(!isDefined(trace)) {
      continue;
    }
    traces[traces.size] = trace[0];
  }

  if(traces.size == 0) {
    player notify("stop_dyndof_debug");
    return dyndof_getplayerorigin() + anglesToForward(dyndof_getplayerangles()) * player.dyndof.maxfocusdist;
  }

  index = 0;
  _id_E82AAE86D95CE0D9 = traces[index];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < traces.size; _id_AC0E594AC96AA3A8++) {
    if(traces[_id_AC0E594AC96AA3A8]["fraction"] < _id_E82AAE86D95CE0D9["fraction"])
      _id_E82AAE86D95CE0D9 = traces[_id_AC0E594AC96AA3A8];
  }

  return _id_E82AAE86D95CE0D9["position"];
}

dyndof_trace_internal(angles, pos) {
  player = self;
  _id_D539DD4D949070D9 = dyndof_getplayerorigin();
  angles = combineangles(dyndof_getplayerangles(), angles);

  if(isDefined(player.dyndof._id_1BAE2B3ECE322CB6))
    _id_5ADCD7A3E8E73FAC = player.dyndof._id_1BAE2B3ECE322CB6;
  else
    _id_5ADCD7A3E8E73FAC = player.dyndof.maxfocusdist;

  if(!isDefined(pos))
    pos = dyndof_getplayerorigin() + anglesToForward(angles) * _id_5ADCD7A3E8E73FAC;

  return physics_raycast(_id_D539DD4D949070D9, pos, player.dyndof.contents, player.dyndof.ignorelist, 1, "physicsquery_closest", 1);
}

dyndof_trace_target(pos) {
  player = self;

  if(istrue(player.dyndof.ignorecollision))
    return 1;

  trace = dyndof_trace_internal((0, 0, 0), pos);

  if(isDefined(trace) && isDefined(trace[0]) && isDefined(trace[0]["position"])) {
    if(distance(trace[0]["position"], pos) < 8)
      return 1;
    else
      return 0;
  }

  return 1;
}

dyndof_getplayerorigin() {
  player = self;

  if(player islinked()) {
    linkedent = player getlinkedparent();

    if(!isDefined(linkedent.dyndof_hastag)) {
      linkedent.dyndof_hastag = 0;

      if(isDefined(linkedent.model)) {
        if(scripts\engine\utility::hastag(linkedent.model, "tag_camera"))
          linkedent.dyndof_hastag = 1;
      }
    }

    if(linkedent.dyndof_hastag)
      return linkedent gettagorigin("tag_camera");
  }

  return player getvieworigin();
}

dyndof_getplayerangles() {
  player = self;
  angles = player getgunangles();
  return angles;
}

create_dyndof() {
  struct = spawnStruct();
  struct.maxfocusdist = 50000;
  struct.contents = get_dyndof_contents();
  struct.traceangle = 3;
  struct.prevangles = (0, 0, 0);
  struct.prevorigin = (0, 0, 0);
  return struct;
}

destroy_dyndof() {
  if(!isDefined(self.dyndof)) {
    return;
  }
  self.dyndof = undefined;
}

get_dyndof_contents() {
  _id_4558AF14719841A9 = ["physicscontents_characterproxy", "physicscontents_ainoshoot", "physicscontents_clipshot", "physicscontents_item", "physicscontents_vehicle", "physicscontents_water"];
  return physics_createcontents(_id_4558AF14719841A9);
}

dyndof_debug(traces, _id_E82AAE86D95CE0D9) {
  player = self;
  player notify("stop_dyndof_debug");
  player endon("stop_dyndof");
  player endon("stop_dyndof_debug");
}