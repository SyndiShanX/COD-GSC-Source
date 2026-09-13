/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_collision.gsc
********************************************************/

vehicle_collision_init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_collision", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_collision", "init")]]();

  level._id_F2A4F97F05F255F1 = getdvarint("dvar_72990C24F27D9759", 1) == 1;
  level._id_1A644E62FD06F9FB = getdvarint("dvar_51781D75E2DDDA6A", 1) == 1;
  level._id_09D53E72E2AB97F5 = getdvarfloat("dvar_BA56DA9845F4904F", 1.0);
  thread vehicle_collision_update();
}

vehicle_collision_update() {
  level endon("game_ended");

  for(;;) {
    level._id_29FA8B0C83A6CC5F = [];
    waitframe();
  }
}

vehicle_collision_updateinstance(vehicle) {
  level endon("game_ended");
  data = vehicle_collision_getleveldataforvehicle(vehicle.vehiclename, 0, 1);

  if(!isDefined(data)) {
    return;
  }
  _id_788EC4D12A429647 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), "handleWorldCollision"))
    _id_788EC4D12A429647 = scripts\cp_mp\utility\script_utility::getsharedfunc(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), "handleWorldCollision");

  vehicle notify("vehicle_collision_updateInstance");
  vehicle endon("vehicle_collision_updateInstance");
  vehicle endon("death");
  _id_0C8054F08CA543E1 = vehicle getentitynumber();
  _id_26170C216671748F = gettime() + 5000;
  vehicle vehphys_enablecollisioncallback(1);

  while(isDefined(vehicle)) {
    vehicle waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(isDefined(ent) && istrue(ent.iscrossbowbolt)) {
      continue;
    }
    _id_593A829032A8C193(vehicle, ent);

    if(isDefined(vehicle._id_4B75A4EE07200D3B) && !ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(ent.classname) && ent.classname != "worldspawn")
      [[vehicle._id_4B75A4EE07200D3B]](vehicle, ent);

    if(isDefined(_id_788EC4D12A429647) && (!isDefined(ent) || !isDefined(ent.classname) || ent.classname == "worldspawn" || ent == vehicle))
      vehicle thread[[_id_788EC4D12A429647]](position);

    if(istrue(vehicle._id_09882CD795C6BFAA)) {
      continue;
    }
    if(gettime() < _id_26170C216671748F) {
      continue;
    }
    if(isDefined(level._id_29FA8B0C83A6CC5F[_id_0C8054F08CA543E1]) || isDefined(ent) && isDefined(ent getentitynumber()) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(level._id_29FA8B0C83A6CC5F[ent getentitynumber()])) {
      continue;
    }
    _id_42A333103449127C = isDefined(ent) && isent(ent) && isDefined(ent getentitynumber()) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() && ent != vehicle;
    level._id_29FA8B0C83A6CC5F[_id_0C8054F08CA543E1] = 1;

    if(_id_42A333103449127C)
      level._id_29FA8B0C83A6CC5F[ent getentitynumber()] = 1;

    if(level._id_F2A4F97F05F255F1) {
      if(!_id_42A333103449127C && isDefined(partenum) && partenum == 5)
        level thread _id_74CE9DC0A18AC393(vehicle, position, normal, normalspeed);
      else
        level thread _id_10D733624BFDA604(vehicle, ent, body0, body1, flag0, flag1, position, normal, normalspeed, partenum);
    }

    if(_id_42A333103449127C) {
      foreach(_id_4D5BCD9C2F5354D9 in [vehicle, ent]) {
        if(isDefined(_id_4D5BCD9C2F5354D9.handleeventcallback))
          _id_4D5BCD9C2F5354D9[[_id_4D5BCD9C2F5354D9.handleeventcallback]](scripts\engine\utility::array_remove([vehicle, ent], _id_4D5BCD9C2F5354D9)[0]);

        _id_E2818AD39A3341B4 = vehicle_collision_getleveldataforvehicle(_id_4D5BCD9C2F5354D9 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD(), 0, 1);

        if(!isDefined(_id_E2818AD39A3341B4)) {
          continue;
        }
        if(isDefined(_id_E2818AD39A3341B4.handleeventcallback))
          [[_id_E2818AD39A3341B4.handleeventcallback]](vehicle, ent);
      }
    }
  }
}

_id_10D733624BFDA604(vehicle, _id_AE9ACDDA1C693FA6, body0, body1, flag0, flag1, position, normal, normalspeed, partenum) {
  _id_8D948973EDDCEB98 = _id_67D6D7481D8AC827(vehicle);
  _id_DFC13CCEE5420527 = _id_67D6D7481D8AC827(_id_AE9ACDDA1C693FA6);
  waitframe();
  _id_EF174A6CFA1ABCDD = _id_3066F0DD7BE2478C(vehicle);
  _id_FDD958D93299102C = _id_3066F0DD7BE2478C(_id_AE9ACDDA1C693FA6);
  _id_7B2C3E974FA33CF2 = isDefined(_id_AE9ACDDA1C693FA6) && _id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()) && isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).damage) && isDefined(vehicle);
  _id_D71630B8BAF84FA8 = length(_id_EF174A6CFA1ABCDD - _id_8D948973EDDCEB98) + length(_id_DFC13CCEE5420527 - _id_FDD958D93299102C);
  _id_02B2C1E04DF704F3 = undefined;
  _id_556FB0D021203D03 = undefined;

  if(!_id_7B2C3E974FA33CF2) {
    if(isDefined(_id_AE9ACDDA1C693FA6) && _id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(_id_AE9ACDDA1C693FA6.maxhealth))
      _id_02B2C1E04DF704F3 = _id_AE9ACDDA1C693FA6;
    else if(isDefined(vehicle) && isDefined(vehicle.maxhealth))
      _id_02B2C1E04DF704F3 = vehicle;
    else
      return;

    ref = _id_02B2C1E04DF704F3 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

    if(!isDefined(ref)) {
      return;
    }
    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(ref)) {
      return;
    }
    if(!level._id_1A644E62FD06F9FB && isDefined(_id_02B2C1E04DF704F3.riders) && _id_02B2C1E04DF704F3.riders.size > 0) {
      return;
    }
    _id_AA1E988C155B6A10 = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(ref);

    if(!isDefined(_id_AA1E988C155B6A10) || !isDefined(_id_AA1E988C155B6A10.damage)) {
      return;
    }
    _id_556FB0D021203D03 = _id_AA1E988C155B6A10.damage;
    _id_98EA5AFB293A76A2 = 1.0;

    if(_id_02B2C1E04DF704F3 scripts\cp_mp\vehicles\vehicle::_id_9502AA416CCD1247())
      _id_98EA5AFB293A76A2 = scripts\engine\utility::_id_53C4C53197386572(_id_556FB0D021203D03._id_6C10B5DC07FD6459, 1.0);
    else
      _id_98EA5AFB293A76A2 = scripts\engine\utility::_id_53C4C53197386572(_id_556FB0D021203D03._id_5C7F497B7EE6EE55, 1.0);

    if(_id_98EA5AFB293A76A2 <= 0) {
      return;
    }
    _id_D71630B8BAF84FA8 = _id_D71630B8BAF84FA8 * _id_98EA5AFB293A76A2;
  }

  if(_id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::_id_2A503318E000E11D()) {
    if(isDefined(_id_AE9ACDDA1C693FA6._id_96419179A661CF96)) {
      [[_id_AE9ACDDA1C693FA6._id_96419179A661CF96]](_id_AE9ACDDA1C693FA6, _id_D71630B8BAF84FA8);
      return;
    }
  }

  _id_D8C07FE7864940FC = 1.0;
  radius = 35.0;

  if(_id_D71630B8BAF84FA8 > 650) {
    _id_D8C07FE7864940FC = 1.0;
    radius = 110.0;
  } else if(_id_D71630B8BAF84FA8 > 450) {
    _id_D8C07FE7864940FC = 0.75;
    radius = 90.0;
  } else if(_id_D71630B8BAF84FA8 > 275) {
    _id_D8C07FE7864940FC = 0.5;
    radius = 75.0;
  } else
    return;

  if(_id_7B2C3E974FA33CF2) {
    _id_EFFA95D8378A8504 = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).damage;
    _id_35ABECBEEEE613A1 = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).damage;
    _id_A2C3A84CD1ACA2A4 = scripts\engine\utility::_id_53C4C53197386572(_id_EFFA95D8378A8504.class, "medium");
    _id_B70E7FD9AD4E445B = scripts\engine\utility::_id_53C4C53197386572(_id_35ABECBEEEE613A1.class, "medium");
    [_id_392A5991268E9527, _id_5DF589527E694864] = _id_1AB37F5B6734E44D(_id_A2C3A84CD1ACA2A4, _id_B70E7FD9AD4E445B);
    [_id_11E6DB65A89A9642, _id_AEF2E55425C6C3E7] = _id_DCBD541C875C2D66(length(_id_8D948973EDDCEB98), length(_id_DFC13CCEE5420527));
    _id_F5C8FEF008FFF1DD = scripts\engine\utility::ter_op(isDefined(vehicle.maxhealth), vehicle.maxhealth, 1) * 2 * _id_D8C07FE7864940FC * _id_11E6DB65A89A9642 * _id_392A5991268E9527 * _id_53C04CEFB8ACF030(_id_A2C3A84CD1ACA2A4) * level._id_09D53E72E2AB97F5;
    _id_4FBFB8C6CC2DD0DC = scripts\engine\utility::ter_op(isDefined(_id_AE9ACDDA1C693FA6.maxhealth), _id_AE9ACDDA1C693FA6.maxhealth, 1) * 2 * _id_D8C07FE7864940FC * _id_AEF2E55425C6C3E7 * _id_5DF589527E694864 * _id_53C04CEFB8ACF030(_id_B70E7FD9AD4E445B) * level._id_09D53E72E2AB97F5;
    _id_EA0C87DA6BD69881 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(vehicle);
    _id_7545D0607FBFB423 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(_id_AE9ACDDA1C693FA6);

    if(istrue(_id_EFFA95D8378A8504.skipburndown))
      vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);

    if(istrue(_id_35ABECBEEEE613A1.skipburndown))
      _id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);

    vehicle dodamage(int(_id_F5C8FEF008FFF1DD), position, _id_7545D0607FBFB423, _id_AE9ACDDA1C693FA6, "MOD_CRUSH", _id_AE9ACDDA1C693FA6.objweapon);
    _id_AE9ACDDA1C693FA6 dodamage(int(_id_4FBFB8C6CC2DD0DC), position, _id_EA0C87DA6BD69881, vehicle, "MOD_CRUSH", vehicle.objweapon);
    vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);
    _id_AE9ACDDA1C693FA6 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);
    scripts\cp_mp\vehicles\vehicle_damage::_id_9C23735BF7534AFA(vehicle, _id_F5C8FEF008FFF1DD * 0.75, position, radius);
    scripts\cp_mp\vehicles\vehicle_damage::_id_9C23735BF7534AFA(_id_AE9ACDDA1C693FA6, _id_4FBFB8C6CC2DD0DC * 0.75, position, radius);

    if(_id_AEF2E55425C6C3E7 > 0.9 && isDefined(vehicle.owner) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(_id_AE9ACDDA1C693FA6, vehicle.owner)) {
      vehicle.owner scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(vehicle, "high_speed_ram");
      return;
    }

    if(_id_11E6DB65A89A9642 > 0.9 && isDefined(_id_AE9ACDDA1C693FA6.owner) && scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(vehicle, _id_AE9ACDDA1C693FA6.owner)) {
      _id_AE9ACDDA1C693FA6.owner scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(_id_AE9ACDDA1C693FA6, "high_speed_ram");
      return;
    }

    return;
  } else {
    damage = _id_02B2C1E04DF704F3.maxhealth * _id_278754969816F33A(scripts\engine\utility::_id_53C4C53197386572(_id_556FB0D021203D03.class, "medium"));

    if(istrue(_id_02B2C1E04DF704F3._id_6DF468049C1F41DC))
      damage = _id_02B2C1E04DF704F3.maxhealth;

    scripts\cp_mp\vehicles\vehicle_damage::_id_9C23735BF7534AFA(_id_02B2C1E04DF704F3, damage * 0.75, position, radius);

    if(damage <= 0 || _id_D8C07FE7864940FC <= 0.5) {
      return;
    }
    if(istrue(_id_556FB0D021203D03.skipburndown))
      _id_02B2C1E04DF704F3 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);

    _id_02B2C1E04DF704F3 dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");
    _id_02B2C1E04DF704F3 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);
  }
}

_id_74CE9DC0A18AC393(vehicle, position, normal, _id_0FAA5640B98769E9) {
  _id_A291B7EA9E74500F = -1 * scripts\engine\utility::ips_to_mph(vehicle vehicle_getvelocity()[2]);

  if(_id_A291B7EA9E74500F < 15) {
    return;
  }
  data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD()).damage;
  _id_98EA5AFB293A76A2 = scripts\engine\utility::_id_53C4C53197386572(data._id_87F38C5C118285C6, 1.0);

  if(_id_98EA5AFB293A76A2 <= 0) {
    return;
  }
  _id_0FAA5640B98769E9 = _id_0FAA5640B98769E9 * _id_98EA5AFB293A76A2;
  _id_89134ACB0056DE26 = [2.0, 2.75, 3.5, 4.5, 10.0];

  if(getdvarint("dvar_12CA000DD2976EBC", 0))
    _id_89134ACB0056DE26 = [4.5, 6.0, 7.5, 9.5, 15.0];

  _id_C40B0D3609E9B480 = 0;

  for(tier = _id_89134ACB0056DE26.size; tier > 0; tier--) {
    _id_7C462121DD5C5AE0 = _id_89134ACB0056DE26[tier - 1];

    if(_id_0FAA5640B98769E9 > _id_7C462121DD5C5AE0) {
      _id_C40B0D3609E9B480 = tier;
      break;
    }
  }

  if(!_id_C40B0D3609E9B480) {
    return;
  }
  _id_D8C07FE7864940FC = 1.0;
  _id_154BA718AB3A0961 = 50;
  _id_5D5F540EC81C82A9 = 0;

  switch (_id_C40B0D3609E9B480) {
    case 5:
      _id_D8C07FE7864940FC = 1.0;
      _id_154BA718AB3A0961 = 250;
      _id_5D5F540EC81C82A9 = 4;
      break;
    case 4:
      _id_D8C07FE7864940FC = 0.8;
      _id_154BA718AB3A0961 = 250;
      _id_5D5F540EC81C82A9 = 4;
      break;
    case 3:
      _id_D8C07FE7864940FC = 0.6;
      _id_154BA718AB3A0961 = 150;
      _id_5D5F540EC81C82A9 = 2;
      break;
    case 2:
      _id_D8C07FE7864940FC = 0.4;
      _id_154BA718AB3A0961 = 100;
      _id_5D5F540EC81C82A9 = 1;
      break;
    case 1:
      _id_D8C07FE7864940FC = 0.2;
      _id_154BA718AB3A0961 = 40;
      _id_5D5F540EC81C82A9 = 1;
      break;
    default:
      break;
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_ECDF1217E332C7D7(vehicle, _id_154BA718AB3A0961, position, _id_5D5F540EC81C82A9);
  class = scripts\engine\utility::_id_53C4C53197386572(data.class, "medium");
  damage = _id_A991A29602381DF7(class) * _id_D8C07FE7864940FC * vehicle.maxhealth;

  if(istrue(data.skipburndown))
    vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(1);

  vehicle dodamage(int(damage), position, undefined, undefined, "MOD_CRUSH");
  vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_disablestatedamagefloor(0);

  if(_id_0FAA5640B98769E9 > 5 && isDefined(vehicle.owner))
    vehicle.owner scripts\cp_mp\challenges::_id_5C3AA65DB46763FF(vehicle, "vehicle_hang_time");
}

_id_593A829032A8C193(vehicle, ent) {
  if(!isDefined(ent)) {
    return;
  }
  ent = scripts\engine\utility::_id_53C4C53197386572(ent.cover, ent);

  if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover" && isDefined(ent.deletefunc) && !istrue(ent._id_455A731F2701DD65)) {
    ent._id_455A731F2701DD65 = 1;
    ent thread[[ent.deletefunc]](undefined, 0, 0);
  } else if(isDefined(ent.weapon_name) && ent.weapon_name == "deployed_decoy_mp")
    ent thread[[ent.entdeletefunc]]();
}

_id_3066F0DD7BE2478C(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle())
    return (0, 0, 0);
  else if(isDefined(vehicle.velocity))
    return vehicle.velocity;
  else
    return vehicle vehicle_getvelocity();
}

_id_6EB1FBA746B72F46(vehicle) {
  return scripts\engine\utility::ips_to_mph(length(_id_3066F0DD7BE2478C(vehicle)));
}

_id_67D6D7481D8AC827(vehicle) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle())
    return (0, 0, 0);
  else if(isDefined(vehicle.velocity))
    return vehicle.velocity;
  else
    return vehicle _meth_C33DBA6864D01D35();
}

_id_1AB37F5B6734E44D(_id_1A4E28225E61F02F, _id_1A4E29225E61F262) {
  _id_9B352CD430803EBC = _id_A46DE67AB094E684(_id_1A4E28225E61F02F);
  _id_9B352FD430804555 = _id_A46DE67AB094E684(_id_1A4E29225E61F262);
  _id_BE66DE030B25508C = _id_9B352CD430803EBC + _id_9B352FD430804555;
  return [_id_9B352FD430804555 / _id_BE66DE030B25508C, _id_9B352CD430803EBC / _id_BE66DE030B25508C];
}

_id_DCBD541C875C2D66(_id_505C9EA2FAD36E67, _id_505C9FA2FAD3709A) {
  _id_BE66DE030B25508C = _id_505C9EA2FAD36E67 + _id_505C9FA2FAD3709A;

  if(_id_BE66DE030B25508C <= 0)
    return [0.5, 0.5];

  return [_id_505C9FA2FAD3709A / _id_BE66DE030B25508C, _id_505C9EA2FAD36E67 / _id_BE66DE030B25508C];
}

_id_A46DE67AB094E684(_id_50CC34C7AD693624) {
  switch (_id_50CC34C7AD693624) {
    case "super_light":
      return 0.1;
    case "light":
      return 0.2;
    case "medium_light":
      return 0.6;
    case "medium":
      return 1;
    case "medium_heavy":
      return 3;
    case "heavy":
      return 5;
    case "super_heavy":
      return 10;
    case "immovable":
      return 1000;
    default:
      return 1;
  }
}

_id_278754969816F33A(_id_50CC34C7AD693624) {
  switch (_id_50CC34C7AD693624) {
    case "super_light":
      return 0.2;
    case "light":
      return 0.15;
    case "medium_light":
      return 0.1;
    case "medium":
      return 0.08;
    case "medium_heavy":
      return 0.05;
    case "heavy":
      return 0.02;
    case "super_heavy":
      return 0;
    case "immovable":
      return 0;
    default:
      return 0;
  }
}

_id_A991A29602381DF7(_id_50CC34C7AD693624) {
  switch (_id_50CC34C7AD693624) {
    case "super_light":
      return 0.6;
    case "light":
      return 0.6;
    case "medium_light":
      return 0.6;
    case "medium":
      return 0.6;
    case "medium_heavy":
      return 0.6;
    case "heavy":
      return 0.5;
    case "super_heavy":
      return 0.5;
    case "immovable":
      return 0;
    default:
      return 0.6;
  }
}

_id_53C04CEFB8ACF030(_id_50CC34C7AD693624) {
  switch (_id_50CC34C7AD693624) {
    case "super_light":
      return 0.6;
    case "light":
      return 0.5;
    case "medium_light":
      return 0.4;
    case "medium":
      return 0.3;
    case "medium_heavy":
      return 0.2;
    case "heavy":
      return 0.15;
    case "super_heavy":
      return 0.1;
    case "immovable":
      return 0;
    default:
      return 0.4;
  }
}

vehicle_collision_getleveldataforvehicle(_id_7731ADEF63E19B0C, create, _id_6ECB77FD1F27C667) {
  if(istrue(create) && (!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage) || !isDefined(scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage.class))) {
    data = undefined;

    if(!scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
      data = spawnStruct();
    else
      data = scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C);

    if(!isDefined(data.damage))
      data.damage = spawnStruct();

    data.damage.ref = _id_7731ADEF63E19B0C;
    data.damage.class = "medium";
    level._id_A0B2C978CA57FFC5[_id_7731ADEF63E19B0C] = data;
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_89DC39DC11F3988C(_id_7731ADEF63E19B0C))
    return scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage;
}

vehicle_collision_ignorefutureevent(vehicle, _id_1BEEDBE11156EA33, duration) {
  vehicle endon("death");

  if(!isDefined(vehicle.vehcolignorelist))
    vehicle.vehcolignorelist = [];

  _id_DF5B18E61839E87E = _id_1BEEDBE11156EA33 getentitynumber();
  vehicle.vehcolignorelist[_id_DF5B18E61839E87E] = _id_1BEEDBE11156EA33;
  wait(duration);

  if(isDefined(vehicle) && isDefined(vehicle.vehcolignorelist))
    vehicle.vehcolignorelist[_id_DF5B18E61839E87E] = undefined;

  if(isDefined(vehicle) && isDefined(vehicle.vehcolignorelist) && vehicle.vehcolignorelist.size == 0)
    vehicle.vehcolignorelist = undefined;
}

_id_D88AED99025A81E4(vehicle, _id_9CB7C709F17E1C56) {
  _id_86366C6F89CBFA6B = _id_9CB7C709F17E1C56 getentitynumber();

  if(isDefined(vehicle.vehcolignorelist) && isDefined(vehicle.vehcolignorelist.size) && vehicle.vehcolignorelist.size > 0) {
    if(isDefined(vehicle.vehcolignorelist[_id_86366C6F89CBFA6B]))
      return 1;
  }

  return 0;
}