/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_mines.gsc
****************************************************/

vehicle_mines_init() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.minedata = [];
  level.vehicle.minetriggerdata = _id_962A30A9BB8C0F09;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "init")]]();
}

vehicle_mines_getleveldata() {
  return level.vehicle.minetriggerdata;
}

vehicle_mines_getleveldataforvehicle(_id_7731ADEF63E19B0C, create) {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle(_id_7731ADEF63E19B0C, create);

  if((!isDefined(_id_E2818AD39A3341B4) || !isDefined(_id_E2818AD39A3341B4.frontextents)) && istrue(create)) {
    if(!isDefined(_id_E2818AD39A3341B4))
      _id_E2818AD39A3341B4 = spawnStruct();

    _id_E2818AD39A3341B4.frontextents = 90;
    _id_E2818AD39A3341B4.backextents = 115;
    _id_E2818AD39A3341B4.leftextents = 38;
    _id_E2818AD39A3341B4.rightextents = 38;
    _id_E2818AD39A3341B4.bottomextents = 20;
    _id_E2818AD39A3341B4.distancetobottom = 35;
    _id_E2818AD39A3341B4.loscheckoffset = (0, 0, 37);
    scripts\cp_mp\vehicles\vehicle::_id_29B4292C92443328(_id_7731ADEF63E19B0C).damage = _id_E2818AD39A3341B4;
  }

  return _id_E2818AD39A3341B4;
}

vehicle_mines_getleveldataformine(_id_1189BD7FBE2861F8, create) {
  _id_962A30A9BB8C0F09 = vehicle_mines_getleveldata();
  _id_574564C86203493F = _id_962A30A9BB8C0F09.minedata[_id_1189BD7FBE2861F8];

  if(!isDefined(_id_574564C86203493F) && istrue(create)) {
    _id_574564C86203493F = spawnStruct();
    _id_574564C86203493F.radius = 10;
    _id_574564C86203493F.triggercallback = undefined;
    _id_962A30A9BB8C0F09.minedata[_id_1189BD7FBE2861F8] = _id_574564C86203493F;
  }

  return _id_574564C86203493F;
}

vehicle_mines_shouldvehicletriggermine(vehicle, mine) {
  if(!vehicle scripts\cp_mp\vehicles\vehicle::isvehicle())
    return 0;

  _id_E2818AD39A3341B4 = vehicle_mines_getleveldataforvehicle(vehicle.vehiclename);

  if(!isDefined(_id_E2818AD39A3341B4))
    return 0;

  _id_574564C86203493F = vehicle_mines_getleveldataformine(mine.equipmentref);

  if(!isDefined(_id_574564C86203493F))
    return 0;

  if(istrue(mine.exploding))
    return 0;

  if(lengthsquared(vehicle vehicle_getvelocity()) < 100) {
    if(lengthsquared(vehicle vehicle_getangularvelocity()) < 400)
      return 0;
  }

  if(vehicle scripts\cp_mp\vehicles\vehicle::isvehicledestroyed())
    return 0;

  _id_582EA6264B9BEA73 = anglesToForward(vehicle.angles) * _id_E2818AD39A3341B4.frontextents;
  _id_9A6186F76E294501 = anglesToForward(vehicle.angles) * -1 * _id_E2818AD39A3341B4.frontextents;
  _id_3CD550B17AE64A43 = anglestoright(vehicle.angles) * -1 * _id_E2818AD39A3341B4.leftextents;
  _id_EB1154E05304E3D4 = anglestoright(vehicle.angles) * _id_E2818AD39A3341B4.rightextents;
  _id_6F3A90A6B2B8799D = vehicle.origin + _id_E2818AD39A3341B4.loscheckoffset;
  _id_F5AB4AFACCAD6ABD = _id_6F3A90A6B2B8799D + _id_582EA6264B9BEA73 + _id_3CD550B17AE64A43;
  _id_B54061A455C5D876 = _id_6F3A90A6B2B8799D + _id_582EA6264B9BEA73 + _id_EB1154E05304E3D4;
  _id_0768679BEA3A3D2B = _id_6F3A90A6B2B8799D + _id_9A6186F76E294501 + _id_3CD550B17AE64A43;
  _id_8374082768CA2834 = _id_6F3A90A6B2B8799D + _id_9A6186F76E294501 + _id_EB1154E05304E3D4;
  _id_6BD8D3846AB52BF3 = (_id_B54061A455C5D876 - _id_F5AB4AFACCAD6ABD) * (1, 1, 0);
  _id_29C1906132100543 = (_id_F5AB4AFACCAD6ABD - _id_0768679BEA3A3D2B) * (1, 1, 0);
  _id_8423818ECF85A883 = _id_F5AB4AFACCAD6ABD - mine.origin;
  _id_572B697257CDE81E = vectordot(vectorNormalize(vehicle_mines_getnormal2d(_id_6BD8D3846AB52BF3)), _id_8423818ECF85A883);

  if(_id_572B697257CDE81E > _id_574564C86203493F.radius)
    return 0;

  _id_572B697257CDE81E = vectordot(vectorNormalize(vehicle_mines_getnormal2d(_id_29C1906132100543)), _id_8423818ECF85A883);

  if(_id_572B697257CDE81E > _id_574564C86203493F.radius)
    return 0;

  _id_15701247FDEED7F1 = (_id_0768679BEA3A3D2B - _id_8374082768CA2834) * (1, 1, 0);
  _id_430A35006E71A02C = (_id_8374082768CA2834 - _id_B54061A455C5D876) * (1, 1, 0);
  _id_8423818ECF85A883 = _id_8374082768CA2834 - mine.origin;
  _id_572B697257CDE81E = vectordot(vectorNormalize(vehicle_mines_getnormal2d(_id_15701247FDEED7F1)), _id_8423818ECF85A883);

  if(_id_572B697257CDE81E > _id_574564C86203493F.radius)
    return 0;

  _id_572B697257CDE81E = vectordot(vectorNormalize(vehicle_mines_getnormal2d(_id_430A35006E71A02C)), _id_8423818ECF85A883);

  if(_id_572B697257CDE81E > _id_574564C86203493F.radius)
    return 0;

  _id_8423818ECF85A883 = _id_6F3A90A6B2B8799D + anglestoup(vehicle.angles) * _id_E2818AD39A3341B4.bottomextents - mine.origin;
  _id_572B697257CDE81E = vectordot(_id_8423818ECF85A883, anglestoup(vehicle.angles));

  if(_id_572B697257CDE81E > _id_E2818AD39A3341B4.distancetobottom)
    return 0;
  else if(_id_572B697257CDE81E < 0)
    return 0;

  return 1;
}

vehicle_mines_minetrigger(vehicle, mine) {
  _id_574564C86203493F = vehicle_mines_getleveldataformine(mine.equipmentref);

  if(isDefined(_id_574564C86203493F.triggercallback))
    thread[[_id_574564C86203493F.triggercallback]](vehicle, mine);

  _id_E2818AD39A3341B4 = vehicle_mines_getleveldataforvehicle(vehicle.vehiclename);

  if(isDefined(_id_E2818AD39A3341B4.triggercallback))
    thread[[_id_E2818AD39A3341B4.triggercallback]](vehicle, mine);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_mines", "trigger"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_mines", "trigger")]](vehicle, mine);
}

vehicle_mines_isfriendlytomine(mine) {
  _id_C665C37B6477E11C = 0;

  if(level.teambased) {
    _id_97B6E63A45F782AB = mine.team;

    if(!isDefined(_id_97B6E63A45F782AB)) {
      if(isDefined(mine.owner))
        _id_97B6E63A45F782AB = mine.owner.team;
    }

    if(isDefined(_id_97B6E63A45F782AB))
      _id_C665C37B6477E11C = scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam(self, _id_97B6E63A45F782AB);
  } else if(isDefined(mine.owner))
    _id_C665C37B6477E11C = scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(self, mine.owner);

  if(!istrue(_id_C665C37B6477E11C)) {
    if(isDefined(self.owner)) {
      if(level.teambased) {
        if(isDefined(mine.team) && self.owner.team == mine.team)
          _id_C665C37B6477E11C = 1;
      } else if(isDefined(mine.owner) && self.owner == mine.owner)
        _id_C665C37B6477E11C = 1;
    }
  }

  return _id_C665C37B6477E11C;
}

vehicle_mines_getnormal2d(_id_16290C9DDA466BCE) {
  return (_id_16290C9DDA466BCE[1], _id_16290C9DDA466BCE[0] * -1, 0);
}

vehicle_mines_getloscheckcontents() {
  return physics_createcontents(["physicscontents_water", "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_ainosight"]);
}