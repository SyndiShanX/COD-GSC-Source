/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\elevators.gsc
***********************************************/

_id_D8DE1E0BC05F3B3A() {
  level waittill("scriptables_ready");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("button", ::_id_3F9F543D197015B3);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_ext_button", ::_id_52B0636366EFD3E4);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_int_button", ::_id_D99E32E6787622FE);
  level._id_FDD3DFF47723BE1F = [];
  level._id_FDD3DFF47723BE1F["waiting"] = ::_id_4497EC9C55F12123;
  level._id_FDD3DFF47723BE1F["doors_open"] = ::_id_EC009A967D1D5EB9;
  level._id_FDD3DFF47723BE1F["doors_closing"] = ::_id_8B680B3EF155FC34;
  level._id_FDD3DFF47723BE1F["moving"] = ::_id_082893C609A46609;
  level.elevators = [];
  level._id_40E610580F1CBAF8 = [];
  level._id_ADB18014BBFC01A8 = ::_id_ADB18014BBFC01A8;
  script_model_anims("default");
  _id_40E610580F1CBAF8 = getentitylessscriptablearray("elevator_stop", "script_noteworthy");

  foreach(stop in _id_40E610580F1CBAF8)
  _id_B0811DEBA3748E9D(stop);

  _id_9C512BD31F6B92D0 = scripts\engine\utility::getStructArray("elevator_car", "script_noteworthy");

  foreach(_id_68333DFC5840CBD8, _id_DDF67F48730C77B1 in level._id_40E610580F1CBAF8) {
    if(_id_DDF67F48730C77B1.size != 2) {
      continue;
    }
    _id_EEC55FABA21F3653 = _id_C0032A2E585D337B(_id_DDF67F48730C77B1, _id_9C512BD31F6B92D0);
    _id_EEC55FABA21F3653 thread _id_12E75AC514F84D03();
  }
}

_id_B0811DEBA3748E9D(stop) {
  stop.open = 0;
  _id_A4DE0BB1CFAF96E8 = getentitylessscriptablearray(stop.target, "targetname");
  stop._id_0E4118BDA122B112 = _id_A4DE0BB1CFAF96E8[0];
  stop.doors = getentitylessscriptablearray(stop._id_0E4118BDA122B112.target, "targetname");
  stop._id_F6104AEADE1A9E68 = [];

  foreach(door in stop.doors)
  door.open = 0;

  if(stop.doors.size == 1)
    stop._id_0646B88B6B0468F9 = stop.doors[0].origin;
  else
    stop._id_0646B88B6B0468F9 = averagepoint([stop.doors[0].origin, stop.doors[1].origin]);

  _id_68333DFC5840CBD8 = stop._id_0646B88B6B0468F9[0] + "," + stop._id_0646B88B6B0468F9[1];

  if(!isDefined(level._id_40E610580F1CBAF8[_id_68333DFC5840CBD8]))
    level._id_40E610580F1CBAF8[_id_68333DFC5840CBD8] = [];

  level._id_40E610580F1CBAF8[_id_68333DFC5840CBD8][level._id_40E610580F1CBAF8[_id_68333DFC5840CBD8].size] = stop;
  stop._id_E7E26D136416C9BC = 0;

  if(isDefined(stop.doors[0].target)) {
    _id_348E7E549BEB7E1D = _func_F159C10D5CF8F0B4(stop.doors[0].target, "targetname");
    stop.trigger = _id_348E7E549BEB7E1D[0];

    if(isDefined(stop.trigger))
      stop thread _id_E7DD97852A7B0BAF();
  }

  return _id_68333DFC5840CBD8;
}

_id_C0032A2E585D337B(_id_DDF67F48730C77B1, _id_9C512BD31F6B92D0, _id_0CECD1599DBCC976) {
  _id_EEC55FABA21F3653 = spawnStruct();
  _id_EEC55FABA21F3653.parts = [];
  _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6 = [];
  _id_EEC55FABA21F3653.state = "doors_open";

  if(_id_DDF67F48730C77B1.size > 1)
    _id_D8ACB6785F746668 = scripts\engine\utility::ter_op(_id_DDF67F48730C77B1[0].origin[2] < _id_DDF67F48730C77B1[1].origin[2], 0, 1);
  else
    _id_D8ACB6785F746668 = 0;

  foreach(stop in _id_DDF67F48730C77B1)
  stop._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;

  _id_8518FDD0909B90FD = _id_DDF67F48730C77B1[_id_D8ACB6785F746668].origin;
  _id_636C8575D7A7768B = undefined;
  _id_21EFBD9501C439BA = undefined;

  foreach(car in _id_9C512BD31F6B92D0) {
    if(!isDefined(_id_636C8575D7A7768B)) {
      _id_636C8575D7A7768B = distancesquared(car.origin, _id_8518FDD0909B90FD);
      _id_21EFBD9501C439BA = car;
      continue;
    }

    dist = distancesquared(car.origin, _id_8518FDD0909B90FD);

    if(dist < _id_636C8575D7A7768B) {
      _id_636C8575D7A7768B = dist;
      _id_21EFBD9501C439BA = car;
    }
  }

  car = spawn("script_model", _id_21EFBD9501C439BA.origin);
  car.angles = _id_21EFBD9501C439BA.angles;
  car setModel(scripts\engine\utility::_id_53C4C53197386572(_id_0CECD1599DBCC976, "building_saba_elevator_set_int"));
  car.animname = "elevator";
  car scripts\common\anim::setanimtree();
  car setscriptablepartstate("lights", "on");
  car._id_EEC55FABA21F3653 = _id_EEC55FABA21F3653;
  car.occupants = [];
  car._id_27ABFC12040D5908 = 0;

  if(isDefined(_id_21EFBD9501C439BA.target)) {
    _id_3978E8604D576990 = scripts\engine\utility::getStruct(_id_21EFBD9501C439BA.target, "targetname");

    if(isDefined(_id_3978E8604D576990)) {
      _id_3978EB604D577029 = scripts\engine\utility::getStruct(_id_3978E8604D576990.target, "targetname");

      if(isDefined(_id_3978EB604D577029)) {
        _id_3978EA604D576DF6 = scripts\engine\utility::getStruct(_id_3978EB604D577029.target, "targetname");

        if(isDefined(_id_3978EA604D576DF6)) {
          _id_3978ED604D57748F = scripts\engine\utility::getStruct(_id_3978EA604D576DF6.target, "targetname");

          if(isDefined(_id_3978ED604D57748F)) {
            car._id_98700DA2E6C8D502 = 144;
            car._id_3978E8604D576990 = _id_3978E8604D576990.origin;
            car._id_3978EB604D577029 = _id_3978EB604D577029.origin;
            car._id_3978EA604D576DF6 = _id_3978EA604D576DF6.origin;
            car._id_3978ED604D57748F = _id_3978ED604D57748F.origin;
            car._id_27ABFC12040D5908 = 1;
          }
        }
      }
    }
  }

  if(!car._id_27ABFC12040D5908 && car.model == "building_saba_elevator_set_int") {
    _id_258CD90357571677 = -84;
    _id_258CDA03575718AA = 76;
    _id_1465200349CB879C = -88;
    _id_1465230349CB8E35 = 88;
    car._id_98700DA2E6C8D502 = 144;
    car._id_3978E8604D576990 = car.origin + rotatepointaroundvector((0, 0, 1), (_id_258CD90357571677, _id_1465200349CB879C, 0), car.angles[1]);
    car._id_3978EB604D577029 = car.origin + rotatepointaroundvector((0, 0, 1), (_id_258CD90357571677, _id_1465230349CB8E35, 0), car.angles[1]);
    car._id_3978EA604D576DF6 = car.origin + rotatepointaroundvector((0, 0, 1), (_id_258CDA03575718AA, _id_1465230349CB8E35, 0), car.angles[1]);
    car._id_3978ED604D57748F = car.origin + rotatepointaroundvector((0, 0, 1), (_id_258CDA03575718AA, _id_1465200349CB879C, 0), car.angles[1]);
    car._id_27ABFC12040D5908 = 1;
  }

  _id_61F15908243423CC = _func_F159C10D5CF8F0B4("elevator_occupancy_trig", "targetname");

  if(isDefined(_id_61F15908243423CC) && _id_61F15908243423CC.size > 0) {
    _id_BF33D00C58D36FB9 = sortbydistance(_id_61F15908243423CC, car.origin);
    _id_45D0836F831471CF = 0;
    tolerance = 48;

    for(car._id_7486049051C97774 = undefined; _id_45D0836F831471CF < _id_BF33D00C58D36FB9.size; _id_45D0836F831471CF++) {
      if(scripts\engine\utility::distance_2d_squared(car.origin, _id_BF33D00C58D36FB9[_id_45D0836F831471CF].origin) < tolerance * tolerance) {
        car._id_7486049051C97774 = _id_BF33D00C58D36FB9[_id_45D0836F831471CF];
        break;
      }
    }

    car._id_27ABFC12040D5908 = 1;
  }

  car forcenetfieldhighlod(1);
  car setmoveroptimized(1);
  car setmoverantilagged(1);
  car markkeyframedmover();
  _id_EEC55FABA21F3653.car = car;
  _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0] = _id_DDF67F48730C77B1[_id_D8ACB6785F746668];
  _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0]._id_5DCB93DB1678CDAF = 0;
  _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0]._id_E340247A219F2577 = _id_EEC55FABA21F3653.car.origin[2];

  if(_id_DDF67F48730C77B1.size > 1) {
    _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[1] = _id_DDF67F48730C77B1[scripts\engine\utility::ter_op(_id_D8ACB6785F746668 == 0, 1, 0)];
    _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[1]._id_5DCB93DB1678CDAF = 1;
    _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[1]._id_E340247A219F2577 = _id_EEC55FABA21F3653.car.origin[2] + (_id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[1]._id_0646B88B6B0468F9[2] - _id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0]._id_0646B88B6B0468F9[2]);
  }

  _id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0 = 0;
  _id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = 0;
  level.elevators[level.elevators.size] = _id_EEC55FABA21F3653;
  return _id_EEC55FABA21F3653;
}

_id_ADB18014BBFC01A8() {
  thread onspawnfinished();
}

onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(self.ti_spawn)
    _id_8E2D666B5B0F2BD3();
}

_id_5C07037726AE5001(ent) {
  if(!isent(ent)) {
    return;
  }
  if(isarray(self)) {
    foreach(_id_EEC55FABA21F3653 in self)
    _id_EEC55FABA21F3653 thread _id_5C07037726AE5001(ent);

    return;
  }

  level endon("game_ended");
  ent endon("death");

  for(;;) {
    if(isDefined(ent)) {
      if(isDefined(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger)) {
        self waittill("elevator_doors_unblocking");

        if(!isDefined(ent)) {
          return;
        }
        if(self.state == "moving") {
          if(ispointinvolume(ent.origin, self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2].trigger))
            ent thread[[ent._id_D1659ED0A33BF98F]]();
        }

        if(ispointinvolume(ent.origin, self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger))
          ent thread[[ent._id_D1659ED0A33BF98F]]();
      } else
        return;
    } else
      return;

    wait 1;
  }
}

_id_29DE8F099A0A63DF(ent) {
  if(!isent(ent)) {
    return;
  }
  if(isarray(self)) {
    foreach(_id_EEC55FABA21F3653 in self)
    _id_EEC55FABA21F3653 thread _id_29DE8F099A0A63DF(ent);

    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  ent endon("death");

  for(;;) {
    if(isDefined(ent)) {
      if(isDefined(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger)) {
        self waittill("elevator_doors_closing");

        if(!isDefined(ent)) {
          return;
        }
        if(ispointinvolume(ent.origin, self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger)) {
          self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC = 1;
          self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] notify("player_blocked");
          self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_BD1CD7B7C484F126();
          wait 0.5;

          while(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC == 1) {
            if(!isDefined(ent)) {
              return;
            }
            if(ispointinvolume(ent.origin, self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger)) {
              self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC = 1;
              self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] notify("player_blocked");
              self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_BD1CD7B7C484F126();
            }

            wait 0.5;
          }
        }
      } else
        break;
    } else
      break;
  }
}

_id_A465AA01FA0187D8(ent) {
  if(!isent(ent)) {
    return;
  }
  if(isarray(self)) {
    foreach(_id_EEC55FABA21F3653 in self)
    _id_EEC55FABA21F3653 thread _id_A465AA01FA0187D8(ent);

    return;
  }

  level endon("game_ended");
  ent endon("death");

  for(;;) {
    if(isDefined(ent)) {
      if(isDefined(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger)) {
        self waittill("elevator_doors_unblocking");

        if(!isDefined(ent)) {
          return;
        }
        if(self.state == "moving") {
          if(ent.collision istouching(self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2].trigger))
            ent thread[[ent._id_D1659ED0A33BF98F]]();
        }

        if(ent.collision istouching(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].trigger))
          ent thread[[ent._id_D1659ED0A33BF98F]]();
      } else
        return;
    } else
      return;

    wait 1;
  }
}

_id_E7DD97852A7B0BAF() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self.trigger waittill("trigger", _id_505C75DD826B0F6F);

    if(istrue(self._id_EEC55FABA21F3653.car._id_27ABFC12040D5908))
      childthread _id_E735BB7C91F218C5(_id_505C75DD826B0F6F, self._id_EEC55FABA21F3653.car);

    if(isPlayer(_id_505C75DD826B0F6F) || isDefined(_id_505C75DD826B0F6F.helperdronetype) || _id_505C75DD826B0F6F scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      self._id_E7E26D136416C9BC = 1;
      self notify("player_blocked");
      thread _id_BD1CD7B7C484F126();
    }

    waitframe();
  }
}

_id_BD1CD7B7C484F126() {
  self endon("player_blocked");
  wait 0.7;

  if(isDefined(self)) {
    self._id_E7E26D136416C9BC = 0;
    self notify("player_unblocked");
  }
}

_id_12E75AC514F84D03() {
  wait 1;
  thread _id_580E82173AE3940C();
}

_id_52B0636366EFD3E4(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance._id_5DCB93DB1678CDAF)) {
    if(instance._id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0 == instance._id_5DCB93DB1678CDAF)
      instance._id_EEC55FABA21F3653.state = "doors_open";
    else
      instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = instance._id_5DCB93DB1678CDAF;

    instance._id_EEC55FABA21F3653 notify("stop_waiting");
    instance._id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2] setscriptablepartstate("elevator_ext_button", "disabled");

    if(instance._id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0 > instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2)
      instance._id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2] setscriptablepartstate("elevator_button_lights", "up");
    else
      instance._id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[instance._id_EEC55FABA21F3653._id_3EAD649FC902FEC2] setscriptablepartstate("elevator_button_lights", "down");
  }
}

_id_D99E32E6787622FE(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(player))
    player playSound("mp_elevator_button_press");

  instance.entity._id_EEC55FABA21F3653._id_3EAD649FC902FEC2 = scripts\engine\utility::ter_op(instance.entity._id_EEC55FABA21F3653._id_33DE00DF8A9FBBE0 == 0, 1, 0);
  instance.entity._id_EEC55FABA21F3653 notify("stop_waiting");
}

_id_C327C9E30F9DF682() {
  foreach(part in self.parts) {
    if(isDefined(part.info)) {
      part.owner = self;
      self._id_E108D0ABDB42CFF6[part._id_5DCB93DB1678CDAF] = part;
    }
  }
}

_id_3F9F543D197015B3(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance._id_5DCB93DB1678CDAF)) {
    if(instance._id_5DCB93DB1678CDAF == 0)
      instance.owner._id_3EAD649FC902FEC2 = scripts\engine\utility::ter_op(instance.owner._id_33DE00DF8A9FBBE0 == 1, 2, 1);
    else if(instance.owner._id_33DE00DF8A9FBBE0 == instance._id_5DCB93DB1678CDAF)
      instance.owner.state = "doors_open";
    else
      instance.owner._id_3EAD649FC902FEC2 = instance._id_5DCB93DB1678CDAF;

    instance.owner notify("stop_waiting");
  }
}

_id_FEA8A1D17E4D669F() {
  foreach(door in self.doors) {
    self.open = 1;
    door.open = 1;
    door setscriptablepartstate("door", "open", 0);
  }

  if(isDefined(self._id_0E4118BDA122B112))
    self._id_0E4118BDA122B112 setscriptablepartstate("model", "arrived");
}

_id_7C2ABB1B0D147A89() {
  self._id_EEC55FABA21F3653 endon("emergency_block");

  foreach(door in self.doors) {
    self.open = 0;
    door.open = 0;
    door setscriptablepartstate("door", "closed", 0);
  }
}

_id_580E82173AE3940C() {
  for(;;)
    self[[level._id_FDD3DFF47723BE1F[self.state]]]();
}

_id_4497EC9C55F12123() {
  if(self._id_3EAD649FC902FEC2 != self._id_33DE00DF8A9FBBE0) {
    if(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0].open)
      self.state = "doors_closing";
    else
      self.state = "moving";
  } else
    self waittill("stop_waiting");
}

_id_EC009A967D1D5EB9() {
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "disabled");
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_button_lights", "off");
  self notify("elevator_doors_unblocking");
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_FEA8A1D17E4D669F();
  self.car setscriptablepartstate("door_sounds", "open");
  self.car thread scripts\common\anim::anim_single_solo(self.car, "open");
  wait 5;
  self.state = "waiting";
}

_id_8B680B3EF155FC34() {
  self endon("emergency_block");
  self notify("elevator_doors_closing");
  wait 0.01;

  if(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC == 1) {
    thread _id_5BFC9AAE53C14056();
    self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] waittill("player_unblocked");
  }

  self notify("elevator_doors_unblocking");
  thread _id_0F99E0077B2350E7();
  wait 0.01;
  self.car setscriptablepartstate("door_sounds", "close");
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] thread _id_7C2ABB1B0D147A89();
  self.car thread scripts\common\anim::anim_single_solo(self.car, "close");
  wait 0.5;
  self notify("elevator_stop_block");
  wait 0.5;
  self notify("elevator_closed");
  self.state = "waiting";
  self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0] setscriptablepartstate("elevator_ext_button", "usable");
}

_id_082893C609A46609() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_E108D0ABDB42CFF6.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112)) {
      if(self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_5DCB93DB1678CDAF == self._id_3EAD649FC902FEC2) {
        if(self._id_33DE00DF8A9FBBE0 > self._id_3EAD649FC902FEC2)
          self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112 setscriptablepartstate("model", "down");
        else
          self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112 setscriptablepartstate("model", "up");

        continue;
      }

      if(self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_5DCB93DB1678CDAF > self._id_3EAD649FC902FEC2) {
        self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112 setscriptablepartstate("model", "down");
        continue;
      }

      self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112 setscriptablepartstate("model", "up");
    }
  }

  _id_811DC7CFCFD29886 = abs(self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2]._id_E340247A219F2577 - self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E340247A219F2577);
  duration = max(_id_811DC7CFCFD29886 / 150, 4.25);
  targetpos = (self.car.origin[0], self.car.origin[1], self._id_E108D0ABDB42CFF6[self._id_3EAD649FC902FEC2]._id_E340247A219F2577);

  foreach(ent in self.car.occupants) {
    if(isPlayer(ent) && isalive(ent))
      ent thread _id_07995B0B9C011087(duration);
  }

  self.car moveTo(targetpos, duration, 2, 2);
  self.car setscriptablepartstate("elevator_sounds", "on");
  wait(duration);
  self.car setscriptablepartstate("elevator_sounds", "off");
  wait 0.5;
  self._id_33DE00DF8A9FBBE0 = self._id_3EAD649FC902FEC2;
  self.state = "doors_open";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_E108D0ABDB42CFF6.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112)) {
      if(self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_5DCB93DB1678CDAF != self._id_33DE00DF8A9FBBE0)
        self._id_E108D0ABDB42CFF6[_id_AC0E594AC96AA3A8]._id_0E4118BDA122B112 setscriptablepartstate("model", "off");
    }
  }
}

_id_07995B0B9C011087(duration) {
  self endon("death_or_disconnect");
  self allowprone(0);
  wait(duration + 0.5);
  self allowprone(1);
}

_id_0F99E0077B2350E7() {
  self endon("elevator_closed");
  self endon("elevator_doors_closing");
  self endon("elevator_stop_block");

  for(;;) {
    if(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC == 1) {
      self notify("emergency_block");
      self.state = "doors_open";
      wait 0.025;
      self.state = "doors_closing";
      return;
    }

    waitframe();
  }
}

_id_0EF19D9446FC2352(num) {
  return self._id_E108D0ABDB42CFF6[num].child.child.child.origin;
}

_id_C78DF968F4751498() {
  _id_BC48943904164E29("elevator_button_floor_01");
  _id_BC48943904164E29("elevator_button_floor_02");
  _id_BC48943904164E29("elevator_button_00_inside");
}

_id_BC48943904164E29(str) {
  _id_651616B5A0834BF3 = self.parts[str];
  _id_ECFDF8AB3E8BE509 = _id_651616B5A0834BF3.origin;
  _id_F0AD0C6AFE8AD911 = _id_651616B5A0834BF3.angles + (90, 0, 0);
  button = spawnscriptable("scriptable_test_button", _id_ECFDF8AB3E8BE509, _id_F0AD0C6AFE8AD911);
  button.parent = _id_651616B5A0834BF3.parent;
  button.child = _id_651616B5A0834BF3.child;
  button.originalpos = _id_651616B5A0834BF3.originalpos;
  button.info = str;
  button._id_5DCB93DB1678CDAF = int(_id_651616B5A0834BF3.script_label);

  if(isDefined(_id_651616B5A0834BF3.children))
    button.children = _id_651616B5A0834BF3.children;

  self.parts[str] = button;
}

#using_animtree("script_model");

script_model_anims(subtype) {
  switch (subtype) {
    default:
      level.scr_animtree["elevator"] = #animtree;
      level.scr_anim["elevator"]["close"] = % iw9_elevator_int_door_close;
      level.scr_animname["elevator"]["close"] = "iw9_elevator_int_door_close";
      level.scr_eventanim["elevator"]["close"] = "iw9_elevator_int_door_close";
      level.scr_animtree["elevator"] = #animtree;
      level.scr_anim["elevator"]["open"] = % iw9_elevator_int_door_open;
      level.scr_animname["elevator"]["open"] = "iw9_elevator_int_door_open";
      level.scr_eventanim["elevator"]["open"] = "iw9_elevator_int_door_open";
      break;
  }
}

_id_E735BB7C91F218C5(_id_505C75DD826B0F6F, car) {
  _id_505C75DD826B0F6F notify("elevator_occupancy_tracking");
  _id_505C75DD826B0F6F endon("elevator_occupancy_tracking");
  _id_505C75DD826B0F6F endon("death");
  _id_505C75DD826B0F6F endon("disconnect");
  _id_8A35F106D988F4D7 = 0.1;
  _id_2ED821A1AF2D6D99 = 1.5;
  _id_91CCF825CD08C4FA = _id_2ED821A1AF2D6D99;
  _id_1DA4FDB9CCE88177 = 140;

  while(isDefined(_id_505C75DD826B0F6F)) {
    car _id_E7DE8F7B4F13CD26(_id_505C75DD826B0F6F, 1);

    while(!_id_505C75DD826B0F6F _id_8E2D666B5B0F2BD3(car)) {
      wait(_id_8A35F106D988F4D7);
      _id_91CCF825CD08C4FA = _id_91CCF825CD08C4FA - _id_8A35F106D988F4D7;

      if(_id_91CCF825CD08C4FA < 0) {
        _id_91CCF825CD08C4FA = _id_2ED821A1AF2D6D99;

        if(scripts\engine\utility::distance_2d_squared(_id_505C75DD826B0F6F.origin, car.origin) > _id_1DA4FDB9CCE88177 * _id_1DA4FDB9CCE88177)
          return;
      }
    }

    car _id_E7DE8F7B4F13CD26(_id_505C75DD826B0F6F);

    while(_id_505C75DD826B0F6F _id_8E2D666B5B0F2BD3(car))
      wait(_id_8A35F106D988F4D7);
  }
}

_id_8E2D666B5B0F2BD3(car) {
  if(!isDefined(self) || !isalive(self))
    return 0;

  if(!isDefined(level.elevators))
    return 0;

  if(!isDefined(car)) {
    _id_9C512BD31F6B92D0 = [];

    foreach(_id_EEC55FABA21F3653 in level.elevators)
    _id_9C512BD31F6B92D0[_id_9C512BD31F6B92D0.size] = _id_EEC55FABA21F3653.car;

    car = scripts\engine\utility::getclosest(self.origin, _id_9C512BD31F6B92D0);

    if(!isDefined(car))
      return 0;
  }

  if(!istrue(car._id_27ABFC12040D5908))
    return 0;

  if(getdvarint("dvar_24B1D20863CDD66A", 0) == 1) {
    if(isDefined(car._id_7486049051C97774) && ispointinvolume(self.origin, car._id_7486049051C97774)) {
      if(!istrue(self._id_8E2D666B5B0F2BD3))
        car _id_E7DE8F7B4F13CD26(self);

      return 1;
    }

    if(isDefined(car._id_3978E8604D576990)) {
      _id_A1582B9803FB64B3 = 16;

      if(self.origin[2] < car.origin[2] - _id_A1582B9803FB64B3 && self.origin[2] > car.origin[2] + car._id_98700DA2E6C8D502 + _id_A1582B9803FB64B3)
        return 0;

      if(_id_CBA565314AC6A79E(self.origin, car._id_3978E8604D576990, car._id_3978EB604D577029, car._id_3978EA604D576DF6, car._id_3978ED604D57748F)) {
        if(!istrue(self._id_8E2D666B5B0F2BD3))
          car _id_E7DE8F7B4F13CD26(self);

        return 1;
      }
    }

    return 0;
  } else {
    if(isDefined(car._id_7486049051C97774) && !ispointinvolume(self.origin, car._id_7486049051C97774))
      return 0;

    if(isDefined(car._id_3978E8604D576990) && !_id_CBA565314AC6A79E(self.origin, car._id_3978E8604D576990, car._id_3978EB604D577029, car._id_3978EA604D576DF6, car._id_3978ED604D57748F))
      return 0;

    _id_8E2633C8A746BA9A = 16;
    _id_FCF847BAEC7225BB = car._id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[0]._id_E340247A219F2577 - _id_8E2633C8A746BA9A;
    _id_700C97BB40709445 = car._id_EEC55FABA21F3653._id_E108D0ABDB42CFF6[1]._id_E340247A219F2577 + car._id_98700DA2E6C8D502 + 5;

    if(self.origin[2] <= car.origin[2] - _id_8E2633C8A746BA9A || self.origin[2] >= car.origin[2] + car._id_98700DA2E6C8D502) {
      if(self.origin[2] >= _id_FCF847BAEC7225BB && self.origin[2] <= _id_700C97BB40709445) {
        _id_9D2CCFD4406C98B7 = self.origin;
        _id_065A66F89BC16EA1 = (self.origin[0], self.origin[1], car.origin[2]);
        _id_065A66F89BC16EA1 = vectorlerp(car.origin, _id_065A66F89BC16EA1, 0.85) + (0, 0, _id_8E2633C8A746BA9A);

        if(isDefined(car._id_7486049051C97774) && !ispointinvolume(self.origin, car._id_7486049051C97774) || isDefined(car._id_3978E8604D576990) && !_id_CBA565314AC6A79E(self.origin, car._id_3978E8604D576990, car._id_3978EB604D577029, car._id_3978EA604D576DF6, car._id_3978ED604D57748F))
          _id_065A66F89BC16EA1 = car.origin + (randomintrange(-48, 48), randomintrange(-48, 48), _id_8E2633C8A746BA9A);

        self setOrigin(_id_065A66F89BC16EA1);
        return 1;
      }

      return 0;
    }

    if(!istrue(self._id_8E2D666B5B0F2BD3))
      car _id_E7DE8F7B4F13CD26(self);

    return 1;
  }
}

_id_E7DE8F7B4F13CD26(_id_F85572CD5F6117C6, _id_65BC331F880E4C49) {
  self.occupants = scripts\engine\utility::_id_FDC9D5557C53078E(self.occupants);

  if(!isDefined(_id_F85572CD5F6117C6)) {
    return;
  }
  if(istrue(_id_65BC331F880E4C49)) {
    _id_F85572CD5F6117C6._id_8E2D666B5B0F2BD3 = 0;
    _id_F85572CD5F6117C6._id_A9F709A20B6AA136 = undefined;
    self.occupants = scripts\engine\utility::array_remove(self.occupants, _id_F85572CD5F6117C6);
  } else {
    thread _id_8D0A258612C91593(_id_F85572CD5F6117C6);
    _id_F85572CD5F6117C6._id_8E2D666B5B0F2BD3 = 1;
    _id_F85572CD5F6117C6._id_A9F709A20B6AA136 = self;

    if(!scripts\engine\utility::array_contains(self.occupants, _id_F85572CD5F6117C6))
      self.occupants[self.occupants.size] = _id_F85572CD5F6117C6;
  }
}

_id_8D0A258612C91593(_id_F85572CD5F6117C6) {
  _id_F85572CD5F6117C6 notify("removeOccupantOnDeath");
  _id_F85572CD5F6117C6 endon("removeOccupantOnDeath");
  _id_F85572CD5F6117C6 waittill("death_or_disconnect");

  if(isDefined(_id_F85572CD5F6117C6)) {
    _id_F85572CD5F6117C6._id_8E2D666B5B0F2BD3 = 0;
    _id_F85572CD5F6117C6._id_A9F709A20B6AA136 = undefined;
    self.occupants = scripts\engine\utility::array_remove(self.occupants, _id_F85572CD5F6117C6);
  } else
    self.occupants = scripts\engine\utility::array_removeundefined(self.occupants);
}

_id_CBA565314AC6A79E(point, _id_3978E8604D576990, _id_3978EB604D577029, _id_3978EA604D576DF6, _id_3978ED604D57748F) {
  _id_3978E8604D576990 = (_id_3978E8604D576990[0], _id_3978E8604D576990[1], 0);
  _id_3978EB604D577029 = (_id_3978EB604D577029[0], _id_3978EB604D577029[1], 0);
  _id_3978EA604D576DF6 = (_id_3978EA604D576DF6[0], _id_3978EA604D576DF6[1], 0);
  _id_3978ED604D57748F = (_id_3978ED604D57748F[0], _id_3978ED604D57748F[1], 0);
  point = (point[0], point[1], 0);
  center = vectorlerp(_id_3978E8604D576990, _id_3978EA604D576DF6, 0.5);
  _id_8999387886088D53 = pointonsegmentnearesttopoint(_id_3978E8604D576990, _id_3978EB604D577029, point);
  _id_899D5F78860CD8EF = pointonsegmentnearesttopoint(_id_3978EB604D577029, _id_3978EA604D576DF6, point);

  if(scripts\engine\utility::distance_2d_squared(center, point) <= scripts\engine\utility::distance_2d_squared(center, _id_8999387886088D53) && scripts\engine\utility::distance_2d_squared(center, point) <= scripts\engine\utility::distance_2d_squared(center, _id_899D5F78860CD8EF))
    return 1;

  return 0;
}

_id_5BFC9AAE53C14056() {
  level endon("game_ended");
  self endon("elevator_doors_closing");
  self endon("disconnect");

  while(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC == 1) {
    self.car playSound("mp_elevator_open");

    if(self._id_E108D0ABDB42CFF6[self._id_33DE00DF8A9FBBE0]._id_E7E26D136416C9BC == 0) {
      break;
    }

    wait 3;
  }
}