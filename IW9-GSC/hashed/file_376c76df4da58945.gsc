/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_376c76df4da58945.gsc
***********************************************/

_id_8AE98122B56FD357() {
  _id_695A872D7D692EFA::_id_8D0BCD24E525CA55();
  _id_F89A8EE6056432E8("mgl_snowman_large", 900);
}

_id_F1D5801907F9F17D(item) {
  _id_88CF5D42344516FF = item getscriptablepartstate("health");

  if(isDefined(_id_88CF5D42344516FF) && _id_88CF5D42344516FF == "broken") {
    item _meth_F35957C991FCFD3F();
    return 1;
  }
}

_id_F019B80AB8A07366(meansofdeath, mindistance, weaponclass, weaponname, attacker, inflictor) {
  _id_7C3011400034B78E = spawnStruct();
  _id_7C3011400034B78E.meansofdeath = meansofdeath;
  _id_7C3011400034B78E.mindistance = mindistance;
  _id_7C3011400034B78E.weaponclass = weaponclass;
  _id_7C3011400034B78E.weaponname = weaponname;
  _id_7C3011400034B78E.attacker = attacker;
  _id_7C3011400034B78E.inflictor = inflictor;
  return _id_7C3011400034B78E;
}

_id_0AE464BCF89AC874(damagedata, _id_7C3011400034B78E) {
  if(isDefined(_id_7C3011400034B78E.meansofdeath) && damagedata.smeansofdeath != _id_7C3011400034B78E.meansofdeath)
    return 0;

  if(isDefined(_id_7C3011400034B78E.mindistance) && distance(damagedata.eattacker.origin, damagedata.instance.origin) < _id_7C3011400034B78E.mindistance)
    return 0;

  if(isDefined(_id_7C3011400034B78E.weaponclass) && damagedata.objweapon.classname != _id_7C3011400034B78E.weaponclass)
    return 0;

  if(isDefined(_id_7C3011400034B78E.weaponname) && damagedata.objweapon.basename != _id_7C3011400034B78E.weaponname)
    return 0;

  if(isDefined(_id_7C3011400034B78E.attacker) && damagedata.eattacker != _id_7C3011400034B78E.attacker)
    return 0;

  if(isDefined(_id_7C3011400034B78E.inflictor) && damagedata.einflictor != _id_7C3011400034B78E.inflictor)
    return 0;

  return 1;
}

_id_E8198B70AD5427EE(name, key) {
  if(!isDefined(name)) {
    return;
  }
  if(!isDefined(key))
    key = "script_noteworthy";

  ent = getEnt(name, key);
  spawnpoint = spawnStruct();
  spawnpoint.origin = ent.origin;
  spawnpoint.angles = ent.angles;
  return spawnpoint;
}

_id_240FEC50BE236D8D(name, key) {
  if(!isDefined(name)) {
    return;
  }
  if(!isDefined(key))
    key = "script_noteworthy";

  spawnpoints = spawnStruct();
  spawnpoints.free = [];
  spawnpoints.occupied = [];
  _id_FF1AA7A587AEA124 = getEntArray(name, "script_noteworthy");

  foreach(point in _id_FF1AA7A587AEA124) {
    spawnpoint = spawnStruct();
    spawnpoint.origin = point.origin;
    spawnpoint.angles = point.angles;
    spawnpoints.free = scripts\engine\utility::array_add(spawnpoints.free, spawnpoint);
  }

  return spawnpoints;
}

_id_EC76D6CE38E20AC3(amount, _id_DC8625458EE5ED14) {
  spawnpoints = spawnStruct();
  spawnpoints.free = [];
  spawnpoints.occupied = [];

  if(!isDefined(_id_DC8625458EE5ED14))
    _id_DC8625458EE5ED14 = spawnStruct();

  if(!isDefined(_id_DC8625458EE5ED14.x))
    _id_DC8625458EE5ED14.x = [level.br_level.br_mapbounds[1][0], level.br_level.br_mapbounds[0][0]];

  if(!isDefined(_id_DC8625458EE5ED14.y))
    _id_DC8625458EE5ED14.y = [level.br_level.br_mapbounds[1][1], level.br_level.br_mapbounds[0][1]];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    _id_81954D580B24281B = randomintrange(int(_id_DC8625458EE5ED14.x[0]), int(_id_DC8625458EE5ED14.x[1]));
    _id_E4F34F3A01C6FFF2 = randomintrange(int(_id_DC8625458EE5ED14.y[0]), int(_id_DC8625458EE5ED14.y[1]));
    spawnpoint = spawnStruct();
    spawnpoint.isinuse = 0;
    spawnpoint.origin = scripts\engine\utility::drop_to_ground((_id_81954D580B24281B, _id_E4F34F3A01C6FFF2, 0));
    spawnpoint.angles = (0, randomint(359), 0);
    spawnpoints.free = scripts\engine\utility::array_add(spawnpoints.free, spawnpoint);
  }

  return spawnpoints;
}

_id_36925DBC82D6E653(_id_B92F1CF567538EEE) {
  while(_id_B92F1CF567538EEE._id_4BA72F218EB934E0) {
    level waittill("item_destruction", damagedata);
    _id_E7C4A756073656AD = damagedata.instance;

    if(_id_E7C4A756073656AD.type == _id_B92F1CF567538EEE._id_4B4B03CC9E68B30A) {
      if(isDefined(_id_E7C4A756073656AD.spawnpoint))
        _id_4A82604DC5A18D82(_id_B92F1CF567538EEE.spawnpoints, _id_E7C4A756073656AD.spawnpoint);

      spawnpoint = _id_B78E051D9B9BBCFB(_id_B92F1CF567538EEE.spawnpoints);

      if(isDefined(spawnpoint)) {
        scriptable = _id_405B1D325FB9651F(_id_B92F1CF567538EEE._id_4B4B03CC9E68B30A, spawnpoint);

        if(isDefined(_id_B92F1CF567538EEE._id_C4434A60A73730B7))
          _id_B92F1CF567538EEE._id_C4434A60A73730B7 = scripts\engine\utility::array_add(_id_B92F1CF567538EEE._id_C4434A60A73730B7, scriptable);
      }
    }
  }
}

_id_B78E051D9B9BBCFB(spawnpoints) {
  if(!isarray(spawnpoints.free)) {
    return;
  }
  if(spawnpoints.free.size < 1) {
    return;
  }
  spawnpoint = scripts\engine\utility::_id_7A2AAA4A09A4D250(spawnpoints.free);
  spawnpoints.free = scripts\engine\utility::array_remove(spawnpoints.free, spawnpoint);
  spawnpoints.occupied = scripts\engine\utility::array_add(spawnpoints.occupied, spawnpoint);
  return spawnpoint;
}

_id_4A82604DC5A18D82(spawnpoints, spawnpoint) {
  if(!isDefined(spawnpoints) || !isDefined(spawnpoint)) {
    return;
  }
  spawnpoints.occupied = scripts\engine\utility::array_remove(spawnpoints.occupied, spawnpoint);
  spawnpoints.free = scripts\engine\utility::array_add(spawnpoints.free, spawnpoint);
}

_id_405B1D325FB9651F(scriptable, spawnpoint) {
  if(!isDefined(scriptable) || !isDefined(spawnpoint)) {
    return;
  }
  _id_CEDDC0C9EFBFEC06 = spawnscriptable(scriptable, spawnpoint.origin, spawnpoint.angles);
  _id_CEDDC0C9EFBFEC06.spawnpoint = spawnpoint;
  return _id_CEDDC0C9EFBFEC06;
}

_id_45A78D93C6A9DB7A(item, time, _id_C9E915E56C1B6170) {
  maxtime = time;
  timeelapsed = 0;

  while(timeelapsed <= maxtime) {
    timeelapsed = timeelapsed + 0.05;
    _id_5C5A60CDB5304628 = scripts\engine\math::lerp(0, _id_C9E915E56C1B6170[0], min(1, timeelapsed / maxtime));
    _id_5C5A61CDB530485B = scripts\engine\math::lerp(0, _id_C9E915E56C1B6170[1], min(1, timeelapsed / maxtime));
    _id_5C5A62CDB5304A8E = scripts\engine\math::lerp(0, _id_C9E915E56C1B6170[2], min(1, timeelapsed / maxtime));
    item.origin = (item.origin[0] + _id_5C5A60CDB5304628, item.origin[1] + _id_5C5A61CDB530485B, item.origin[2] + _id_5C5A62CDB5304A8E);
    wait 0.05;
  }
}

_id_4138B4F738793B0B(item, time, _id_069FB8ED6A22E7FC, _id_3DF8FF290801ABE5) {
  maxtime = time;
  timeelapsed = 0;
  _id_5AC688E9E8F9BDD5 = item.origin[0];
  _id_5AC687E9E8F9BBA2 = item.origin[1];
  angle = 90;

  while(timeelapsed <= maxtime) {
    timeelapsed = timeelapsed + 0.05;
    _id_5CAABC9F456B8007 = _id_069FB8ED6A22E7FC * cos(angle);
    _id_5CAABB9F456B7DD4 = _id_069FB8ED6A22E7FC * sin(angle);
    angle = angle + _id_3DF8FF290801ABE5;

    if(angle >= 360)
      angle = 0;

    item.origin = (_id_5AC688E9E8F9BDD5 + _id_5CAABC9F456B8007, _id_5AC687E9E8F9BBA2 + _id_5CAABB9F456B7DD4, item.origin[2]);
    wait 0.05;
  }
}

_id_EE6AF2593B3F4F9F(item, time, points, speed) {
  for(;;) {
    _id_207328C575E11BE9(item, time, points, speed);
    waitframe();
  }
}

_id_1F6BD16AEB6B3B3F(item, time, points, speed) {
  _id_D2C4D283A38AF064 = scripts\engine\utility::array_reverse(points);

  for(;;) {
    _id_207328C575E11BE9(item, time, points, speed);
    _id_207328C575E11BE9(item, time, _id_D2C4D283A38AF064, speed);
    waitframe();
  }
}

_id_207328C575E11BE9(item, time, points, speed) {
  currenttime = gettime();
  starttime = currenttime;
  _id_0AF8D4CC519C65DE = 0;
  _id_3B969D8C66F20F14 = 1;
  _id_5914DC8594357CF6 = 1.0;
  _id_4ED790D17BA45789 = 1.5;
  _id_E46DA62B29DE231A = 0;

  if(isDefined(speed))
    _id_620FA9F00E8F7299(points, speed);

  _id_16E8B22C9904EAD8 = scripts\common\csplines::cspline_makepath(points, _id_3B969D8C66F20F14);

  for(time = 0; time <= scripts\common\csplines::cspline_time(_id_16E8B22C9904EAD8); time = time + (gettime() - currenttime)) {
    currenttime = gettime();
    _id_29376CACC64CC4E6 = scripts\common\csplines::cspline_getpointattime(_id_16E8B22C9904EAD8, time);
    item.origin = _id_29376CACC64CC4E6["pos"];
    waitframe();
  }
}

_id_620FA9F00E8F7299(points, speed) {
  foreach(point in points)
  point.speed = speed;
}

_id_69DF5E0C6C8EB388(_id_F5F465D3866830A2, _id_5F6EFFB5FFEB0640, _id_C003DAB546DD7E2C, spawnposition, time, _id_902FCFFD5545E0F0, _id_1D50F7111B6492E7, _id_BBDF8FFD772A694C, _id_C9CA4E6733F86D6C) {
  if(!isDefined(_id_F5F465D3866830A2) || !isDefined(_id_5F6EFFB5FFEB0640)) {
    return;
  }
  if(!isDefined(spawnposition))
    spawnposition = _id_5F6EFFB5FFEB0640 + (0, 0, 10000);

  if(!isDefined(time))
    time = 5;

  if(!isDefined(_id_902FCFFD5545E0F0))
    _id_902FCFFD5545E0F0 = 0;

  if(!isDefined(_id_1D50F7111B6492E7))
    _id_1D50F7111B6492E7 = "ee_rock_boulder_01";

  if(!isDefined(_id_BBDF8FFD772A694C))
    _id_BBDF8FFD772A694C = ["vfx_quests_meteor_trail"];

  if(isDefined(_id_C003DAB546DD7E2C)) {
    _id_12B839D2A79160E2 = randomfloatrange(-1 * _id_C003DAB546DD7E2C, _id_C003DAB546DD7E2C);
    _id_12B83AD2A7916315 = randomfloatrange(-1 * _id_C003DAB546DD7E2C, _id_C003DAB546DD7E2C);
    _id_5F6EFFB5FFEB0640 = _id_5F6EFFB5FFEB0640 + (_id_12B839D2A79160E2, _id_12B83AD2A7916315, 0);
  }

  _id_C52E2ACE0F01D10A = spawn("script_model", spawnposition);
  _id_C52E2ACE0F01D10A setModel(_id_1D50F7111B6492E7);
  waitframe();
  _id_2CE3819674F7D9C1 = [];

  if(isDefined(_id_BBDF8FFD772A694C) && isarray(_id_BBDF8FFD772A694C)) {
    foreach(effect in _id_BBDF8FFD772A694C) {
      if(scripts\engine\utility::fxexists(effect)) {
        effectid = scripts\engine\utility::getfx(effect);
        _id_2CE3819674F7D9C1 = scripts\engine\utility::array_add(_id_2CE3819674F7D9C1, effectid);
        playFXOnTag(effectid, _id_C52E2ACE0F01D10A, "tag_origin");
      }
    }
  }

  _id_C52E2ACE0F01D10A moveTo(_id_5F6EFFB5FFEB0640, time, _id_902FCFFD5545E0F0);

  while(distance(_id_C52E2ACE0F01D10A.origin, _id_5F6EFFB5FFEB0640) > 1)
    waitframe();

  _id_AAFFF520E214082E = spawnscriptable(_id_F5F465D3866830A2, _id_C52E2ACE0F01D10A.origin, _id_C52E2ACE0F01D10A.angles);

  foreach(effect in _id_2CE3819674F7D9C1)
  stopFXOnTag(effect, _id_C52E2ACE0F01D10A, "tag_origin");

  _id_C52E2ACE0F01D10A delete();
}

_id_1E00432625D13A4E(_id_EA747F1AB72CD3F2, callback, param1, param2, param3, param4, param5, param6) {
  level notify(_id_EA747F1AB72CD3F2 + "_end");
  level endon(_id_EA747F1AB72CD3F2 + "_end");

  if(!isDefined(_id_EA747F1AB72CD3F2) || !isDefined(callback)) {
    return;
  }
  for(;;) {
    level waittill(_id_EA747F1AB72CD3F2, _id_1C2D55EC04D979E7);
    thread scripts\common\utility::trycall(callback, param1, param2, param3, param4, param5, param6);
    waitframe();
  }
}

_id_EF1BDFFE228C45F1(scriptable) {}

_id_F89A8EE6056432E8(scriptable, amount, _id_DC8625458EE5ED14) {}

_id_BBB3AB596752E043(_id_58CAB040FD809108, _id_5DB3E5D123915705) {}