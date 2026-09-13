/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\bunkerbuster.gsc
*************************************************/

_id_D5FE78860931C577(glgrenade, objweapon) {
  glgrenade endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  _id_A681B7890CD017C7 = spawnStruct();
  childthread _id_9C3216631600C8A9(glgrenade, _id_A681B7890CD017C7);
  childthread _id_2DB5F44DBF46AE26(glgrenade, _id_A681B7890CD017C7);
  glgrenade waittill("missile_stuck", stuckto, _id_16A48D7056E5C472, surfacetype, velocity, position, normal);
  waittillframeend;
  self notify("stopBunkerbusterStuckMonitors");
  _id_8775D2527B5D0349 = _id_5C205DC5E843711C(glgrenade);
  grenade = scripts\mp\utility\weapon::_launchgrenade(_id_8775D2527B5D0349, glgrenade.origin, (0, 0, 0));
  scripts\mp\weapons::grenadeinitialize(grenade, makeweapon(_id_8775D2527B5D0349));
  grenade.angles = glgrenade.angles;
  grenade.glgrenadeparent = self getcurrentweapon();
  grenade.glgrenade = glgrenade;
  grenade._id_805FE3E45F3BCBE0 = 1;
  grenade._id_A681B7890CD017C7 = _id_A681B7890CD017C7;
  grenade._id_939636F512801E8E = glgrenade._id_939636F512801E8E;

  if(isDefined(stuckto)) {
    if(isPlayer(stuckto) || isagent(stuckto)) {
      if(stuckto scripts\cp_mp\utility\player_utility::_isalive()) {
        thread scripts\mp\weapons::grenadestuckto(grenade, stuckto);

        if(isDefined(_id_16A48D7056E5C472))
          grenade linkTo(stuckto, _id_16A48D7056E5C472);
        else
          grenade linkTo(stuckto, "j_spine4", (0, 0, 0));
      }
    } else if(shouldlink(stuckto, _id_16A48D7056E5C472)) {
      if(isDefined(_id_16A48D7056E5C472) && _id_16A48D7056E5C472 != "scriptbrushmodeldummy")
        grenade linkTo(stuckto, _id_16A48D7056E5C472);
      else
        grenade linkTo(stuckto);
    }

    grenade._id_A681B7890CD017C7.stuckto = stuckto;
    grenade thread _id_50975E0BBD033649(stuckto);
  } else {
    _id_CE509EB5353C18AB = scripts\engine\utility::spawn_script_origin(glgrenade.origin, normal);
    grenade linkTo(_id_CE509EB5353C18AB);
    grenade._id_E14BA1D91FAF13C4 = _id_CE509EB5353C18AB;
  }

  grenade thread _id_AD336C2696ABFCC5();
  grenade thread _id_F74EDE2695719F2F();
  thread _id_3D78DD516C25EF77(grenade);
}

_id_3D78DD516C25EF77(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("explode");
  grenade endon("death");
  grenade thread _id_BE84A39B52576D18();
  grenade thread _id_E241396812ED67B2();

  if(_id_805FE3E45F3BCBE0(grenade))
    _id_A681B7890CD017C7 = grenade._id_A681B7890CD017C7;
  else
    _id_A681B7890CD017C7 = grenade scripts\mp\equipment::_id_F69ED22535D90B78();

  _id_2D7C3D3CBA3B7824(grenade, _id_A681B7890CD017C7);
}

_id_2D7C3D3CBA3B7824(grenade, _id_A681B7890CD017C7) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  _id_E29C6802D3127907 = getdvarfloat("dvar_0F1406BA08FA573E", 0.25);
  wait(_id_E29C6802D3127907);
  grenade setscriptablepartstate("effects", "plant", 0);
  stuckto = _id_A681B7890CD017C7.stuckto;
  _id_6150B9D03028F80C = _id_A681B7890CD017C7._id_6150B9D03028F80C;

  if(istrue(_id_6150B9D03028F80C))
    _id_AD251EF4525BDED7(grenade);
  else if(isDefined(stuckto)) {
    if(!isPlayer(stuckto))
      grenade childthread scripts\mp\equipment::_id_4AF015619E2534BA(stuckto, ::_id_A5A20B852C325190, 0);

    grenade.stuckto = stuckto;

    if(isPlayer(stuckto) || isagent(stuckto) && !istrue(stuckto._id_950C1AB89C9C4E2A))
      _id_34D256476DEC6EE7(grenade, stuckto, istrue(grenade._id_16AC6FAC07EACBC3));
    else if(stuckto.classname == "grenade" || stuckto.classname == "misc_turret" || stuckto.classname == "scriptable" || istrue(stuckto._id_950C1AB89C9C4E2A))
      _id_1A7E2803D7DDF81A(grenade);
    else if(stuckto.classname == "script_vehicle")
      _id_6E25A608EAFBC362(grenade, stuckto);
    else
      _id_9C1241B88A86E763(grenade);
  } else
    _id_9C1241B88A86E763(grenade);
}

_id_AD251EF4525BDED7(grenade) {
  _id_C39F2C11290B6AEA = "dig_fail";
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA);
  _id_3A35103112044E22(grenade);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_1A7E2803D7DDF81A(grenade) {
  _id_C39F2C11290B6AEA = "dig_fail";
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA);
  _id_3A35103112044E22(grenade);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_34D256476DEC6EE7(grenade, stuckto, hasriotshield) {
  if(hasriotshield)
    _id_0649E631C4395E0C(grenade, stuckto);
  else
    _id_0E0F1675A8FE53D0(grenade, stuckto);
}

_id_0649E631C4395E0C(grenade, stuckto) {
  victim = stuckto;
  _id_C39F2C11290B6AEA = "dig_success";
  _id_078E31B7617D8FE4 = anglestoup(grenade.angles) * -1;
  _id_5CB6E728DFD846F1 = getdvarint("dvar_3550D36068C86A93", 12);
  offset = _id_078E31B7617D8FE4 * _id_5CB6E728DFD846F1;
  spawnpoint = grenade.origin + offset;
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA, spawnpoint, _id_078E31B7617D8FE4);
  _id_88831F8BE20721FE(grenade, spawnpoint);
  grenade._id_57A5AFD100D3BFDA.stuckto = victim;
  thread scripts\mp\weapons::grenadestuckto(grenade._id_57A5AFD100D3BFDA, victim);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_0E0F1675A8FE53D0(grenade, stuckto) {
  victim = stuckto;
  _id_C39F2C11290B6AEA = "character_stuck";
  thread scripts\mp\weapons::grenadestuckto(grenade, victim);
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA, undefined, undefined, isagent(victim));
  _id_3A35103112044E22(grenade);
  grenade._id_57A5AFD100D3BFDA.stuckto = victim;
  thread scripts\mp\weapons::grenadestuckto(grenade._id_57A5AFD100D3BFDA, victim);

  if(!isagent(victim))
    victim childthread _id_7685538105C42E44(grenade);

  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_7685538105C42E44(grenade) {
  _id_E601ACF6AD00AF27 = getdvarint("dvar_27353F6EDCE1388C", 1);
  _id_6A9734D81CBB50E7 = getdvarint("dvar_5C787C65F30196DE", 5);
  maxtime = getdvarfloat("dvar_378EA9E4243680E5", 0.6);
  starttime = gettime();
  self playlocalsound("eqp_bunkerbuster_drill_npc");

  for(_id_5FA323075902C461 = 0; _id_5FA323075902C461 < _id_6A9734D81CBB50E7; _id_5FA323075902C461++) {
    self dodamage(_id_E601ACF6AD00AF27, grenade.origin, grenade.owner, grenade, "MOD_RIFLE_BULLET", grenade.weapon_object, "torso_upper");
    wait(maxtime / _id_6A9734D81CBB50E7);
  }
}

_id_9C1241B88A86E763(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  upvec = anglestoup(grenade.angles);
  _id_A048549727655A17 = _id_C38D0C6D56A3D8BC(grenade);
  _id_2FC7B90001702E5C = [grenade];
  offset = _id_A048549727655A17;
  _id_EC9C47F7D01C1033 = grenade.origin;
  _id_5E8EDE0EF6D7F3AB = anglestoup(grenade.angles);
  _id_5996067FA75E09D4 = 0;
  _id_5230E3E1EA57D7F1 = _id_B628A9F30E4B39C7(grenade);

  while(offset <= _id_5230E3E1EA57D7F1) {
    _id_28AE17B3CCEE3B7E = upvec * -1 * offset;
    endorigin = grenade.origin + _id_28AE17B3CCEE3B7E;
    _id_18C1624C21C1E9C1 = scripts\engine\trace::ray_trace(endorigin, grenade.origin, _id_2FC7B90001702E5C, scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0, 0, 0), 1);

    if(_id_18C1624C21C1E9C1["hittype"] != "hittype_none") {
      _id_EC9C47F7D01C1033 = _id_18C1624C21C1E9C1["position"] - grenade.origin;
      _id_5E8EDE0EF6D7F3AB = vectorNormalize(_id_18C1624C21C1E9C1["position"] - grenade.origin);
      _id_5996067FA75E09D4 = 1;
      break;
    }

    offset = offset + _id_A048549727655A17;
    waitframe();
  }

  if(_id_5996067FA75E09D4)
    _id_5996067FA75E09D4 = _id_8F7774E4E68D2A43(grenade, _id_EC9C47F7D01C1033, _id_5E8EDE0EF6D7F3AB);

  _id_303D9FA226476812 = anglestoup(self getworldupreferenceangles());
  _id_C83A8D3D629F1DAC = anglestoup(grenade.angles);
  _id_0FCCBF8939AD0065 = vectordot(_id_303D9FA226476812, _id_C83A8D3D629F1DAC);
  grenade._id_BFCF780C7F28FBD4 = _id_0FCCBF8939AD0065 >= -0.5 && _id_0FCCBF8939AD0065 <= 0.5;
  _id_C39F2C11290B6AEA = scripts\engine\utility::ter_op(_id_5996067FA75E09D4, "dig_success", "dig_fail");
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA, _id_EC9C47F7D01C1033, _id_5E8EDE0EF6D7F3AB);
  _id_2A21B9990F69270E = getdvarfloat("dvar_DCC19C96AF625740", 0.0);
  wait(_id_2A21B9990F69270E);

  if(!_id_5996067FA75E09D4)
    _id_3A35103112044E22(grenade);
  else
    _id_5F9B222EF93F265E(grenade, _id_EC9C47F7D01C1033, _id_5E8EDE0EF6D7F3AB);

  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_C8FD05BF21971A04(grenade, _id_318555433A0D7DA0, _id_AD3758FD3576AE97, _id_30F3BD16D27CF3BC, _id_417C6CDAF53E0DCE) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  spawnpoint = grenade.origin;

  if(!isDefined(spawnpoint))
    spawnpoint = _id_AD3758FD3576AE97 + grenade.origin;

  if(!isDefined(_id_30F3BD16D27CF3BC))
    _id_30F3BD16D27CF3BC = anglesToForward(grenade.angles);

  if(_id_318555433A0D7DA0 == "dig_fail") {
    _id_F2C94EC1C211C6D6 = scripts\engine\utility::spawn_script_origin(spawnpoint, grenade.angles);
    grenade setscriptablepartstate("effects", "sizzle-fail", 0);
  } else {
    _id_F2C94EC1C211C6D6 = spawn("script_model", spawnpoint);
    _id_F2C94EC1C211C6D6.angles = vectortoangles(_id_30F3BD16D27CF3BC);
    _id_F2C94EC1C211C6D6 setModel("equip_bunkerbuster_burrowed");
    _id_F2C94EC1C211C6D6 linkTo(grenade);

    if(_id_318555433A0D7DA0 == "character_stuck" && isdismembermentenabled() && !istrue(_id_417C6CDAF53E0DCE))
      grenade setscriptablepartstate("effects", "sizzle-player-stuck", 0);
    else {
      grenade setscriptablepartstate("effects", "sizzle-success", 0);
      _id_A2D683023DD73ECC = getdvarfloat("dvar_DD3F674055086845", 0.75);
      wait(_id_A2D683023DD73ECC);
      _id_F2C94EC1C211C6D6 setscriptablepartstate("thermal_lance", "active", 0);
    }
  }

  grenade._id_F2C94EC1C211C6D6 = _id_F2C94EC1C211C6D6;
}

_id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("explode");
  grenade endon("death");
  _id_AD5532BD0A7F34D7 = getdvarfloat("dvar_7ECEF2F8627473E8", 1.0);

  if(_id_C39F2C11290B6AEA == "vehicle_stuck")
    _id_AD5532BD0A7F34D7 = 3.0;

  if(_id_C39F2C11290B6AEA == "character_stuck")
    _id_AD5532BD0A7F34D7 = 1.5;

  wait(getdvarfloat("dvar_4E0C2A5ACE3ABB90", _id_AD5532BD0A7F34D7));
  _id_500B28A55F3ECC0E(grenade, _id_C39F2C11290B6AEA);
}

_id_6E25A608EAFBC362(grenade, vehicle) {
  scripts\cp_mp\utility\weapon_utility::_id_69D45A21A6D4E9F8(vehicle, self.team);
  _id_C39F2C11290B6AEA = "vehicle_stuck";
  grenade._id_A5D118F040F60DB0 = vehicle;
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA);
  _id_3A35103112044E22(grenade);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_5F9B222EF93F265E(grenade, _id_AD3758FD3576AE97, _id_5E8EDE0EF6D7F3AB) {
  spawnpoint = grenade.origin;

  if(isDefined(_id_AD3758FD3576AE97))
    spawnpoint = spawnpoint + _id_AD3758FD3576AE97;

  _id_F3714CD7B3B5526D = _id_085123E3A93096CB(grenade);
  grenade._id_57A5AFD100D3BFDA = scripts\mp\utility\weapon::_launchgrenade(_id_F3714CD7B3B5526D, spawnpoint, (0, 0, 0), 100, 1);
  grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon(_id_F3714CD7B3B5526D);
  scripts\mp\weapons::grenadeinitialize(grenade._id_57A5AFD100D3BFDA, grenade._id_57A5AFD100D3BFDA.weapon_object);
  grenade._id_57A5AFD100D3BFDA.angles = grenade._id_F2C94EC1C211C6D6.angles;
  grenade._id_57A5AFD100D3BFDA linkTo(grenade._id_F2C94EC1C211C6D6);
  grenade setscriptablepartstate("effects", "sizzle-success", 0);
  grenade._id_57A5AFD100D3BFDA setscriptablepartstate("danger-icon", "on", 0);
}

_id_3A35103112044E22(grenade) {
  _id_BED6499E83E9B59E = _id_4BDB5FCE70A89130(grenade);
  _id_F3714CD7B3B5526D = _id_085123E3A93096CB(grenade);
  _id_57A5AFD100D3BFDA = scripts\mp\utility\weapon::_launchgrenade(_id_BED6499E83E9B59E, grenade.origin, (0, 0, 0), 100, 1);
  _id_57A5AFD100D3BFDA linkTo(grenade._id_F2C94EC1C211C6D6);
  grenade._id_57A5AFD100D3BFDA = _id_57A5AFD100D3BFDA;
  grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon(_id_F3714CD7B3B5526D);
  scripts\mp\weapons::grenadeinitialize(grenade._id_57A5AFD100D3BFDA, grenade._id_57A5AFD100D3BFDA.weapon_object);
}

_id_88831F8BE20721FE(grenade, spawnpoint) {
  _id_BED6499E83E9B59E = _id_4BDB5FCE70A89130(grenade);
  _id_F3714CD7B3B5526D = _id_085123E3A93096CB(grenade);
  _id_57A5AFD100D3BFDA = scripts\mp\utility\weapon::_launchgrenade(_id_BED6499E83E9B59E, spawnpoint, (0, 0, 0), 100, 1);
  _id_57A5AFD100D3BFDA linkTo(grenade._id_F2C94EC1C211C6D6);
  grenade._id_57A5AFD100D3BFDA = _id_57A5AFD100D3BFDA;
  grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon(_id_F3714CD7B3B5526D);
  scripts\mp\weapons::grenadeinitialize(grenade._id_57A5AFD100D3BFDA, grenade._id_57A5AFD100D3BFDA.weapon_object);
}

_id_8F7774E4E68D2A43(grenade, _id_CB3A5854C8269A89, _id_2B268884E45F090A) {
  offset = getdvarint("dvar_8FEB82DD51A5A0C2", 25);
  _id_256392925C393BD0 = _id_CB3A5854C8269A89 + grenade.origin;
  _id_256392925C393BD0 = _id_256392925C393BD0 + _id_2B268884E45F090A * offset;
  isoob = scripts\mp\outofbounds::ispointinoutofbounds(_id_256392925C393BD0, self.team);

  if(isoob)
    return 0;
  else
    return 1;
}

_id_500B28A55F3ECC0E(grenade, _id_C39F2C11290B6AEA) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  stuckto = grenade.stuckto;

  if(isDefined(stuckto) && (_id_C39F2C11290B6AEA == "vehicle_stuck" || _id_C39F2C11290B6AEA == "character_stuck"))
    _id_1CDF454E2F856A7F(grenade);
  else if(_id_C39F2C11290B6AEA == "dig_success") {
    _id_C225480C1FD1C87F = grenade._id_F2C94EC1C211C6D6.angles;
    _id_160A13625801ABEC = grenade._id_57A5AFD100D3BFDA.origin;
    grenade._id_57A5AFD100D3BFDA unlink();
    grenade._id_57A5AFD100D3BFDA delete();
    _id_6E17D9FBF3B64B04 = (0, 0, 0);
    _id_35704482652C4CDC = _id_160A13625801ABEC + anglestoup(grenade.angles) * -1 * 8;
    _id_03249CB1787E8B3F = _id_802E4FE81FEB0DC6(grenade);

    if(isDefined(grenade._id_CE68DE48BC529CD2)) {
      if(istrue(self.hasriotshield))
        _id_35704482652C4CDC = grenade._id_CE68DE48BC529CD2 gettagorigin("j_spine4");
    } else {
      _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglesToForward(_id_C225480C1FD1C87F) * getdvarint("dvar_8766C486F2519FFB", 300);

      if(istrue(grenade._id_BFCF780C7F28FBD4))
        _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglestoup(_id_C225480C1FD1C87F) * getdvarint("dvar_6BFFD30022E9BCAB", 0) * -1;

      _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + _id_239A8AC31714B354();
    }

    grenade._id_57A5AFD100D3BFDA = scripts\mp\utility\weapon::_launchgrenade(_id_03249CB1787E8B3F, _id_35704482652C4CDC, _id_6E17D9FBF3B64B04, 100, 1);
    grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon(_id_03249CB1787E8B3F);
    scripts\mp\weapons::grenadeinitialize(grenade._id_57A5AFD100D3BFDA, grenade._id_57A5AFD100D3BFDA.weapon_object);
    grenade._id_57A5AFD100D3BFDA.angles = _id_C225480C1FD1C87F;
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "shoot", 0);
    grenade setscriptablepartstate("effects", "shoot", 0);
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("danger-icon", "on", 0);

    if(isDefined(grenade._id_CE68DE48BC529CD2) && istrue(grenade._id_CE68DE48BC529CD2.hasriotshield))
      thread scripts\mp\weapons::grenadestuckto(grenade._id_57A5AFD100D3BFDA, grenade._id_CE68DE48BC529CD2, 1);
    else {
      _id_1CA111FF86819C24 = getdvarfloat("dvar_B75D73BDCEFF168F", 0.5);
      grenade._id_57A5AFD100D3BFDA scripts\engine\utility::waittill_any_timeout_1(_id_1CA111FF86819C24, "missile_stuck");
    }

    if(isDefined(grenade._id_57A5AFD100D3BFDA))
      grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode", 0);
  } else
    grenade setscriptablepartstate("effects", "explode", 0);

  wait 0.1;

  if(isDefined(grenade._id_57A5AFD100D3BFDA)) {
    grenade._id_57A5AFD100D3BFDA._id_AD590A75663898F3 = 1;
    grenade._id_57A5AFD100D3BFDA detonate();
  }

  grenade thread _id_A5A20B852C325190(0, scripts\engine\utility::ter_op(_id_C39F2C11290B6AEA == "dig_success", 1, 0));
}

_id_1CDF454E2F856A7F(grenade) {
  stuckto = grenade.stuckto;

  if(stuckto.classname == "script_vehicle")
    _id_E5BE7A1F18A659FB(grenade, stuckto);
  else if(isPlayer(stuckto))
    _id_E41A24EF376DBF52(grenade, stuckto);
}

_id_239A8AC31714B354() {
  _id_6245153AB14FEE9F = (0, 0, 0);
  _id_A2731E6D9AF15254 = self getmovingplatformparent();

  if(isDefined(_id_A2731E6D9AF15254)) {
    _id_9A0A6E697DAC74FE = _id_A2731E6D9AF15254.velocity;

    if(!isDefined(_id_9A0A6E697DAC74FE) && _id_A2731E6D9AF15254 scripts\cp_mp\vehicles\vehicle::isvehicle())
      _id_9A0A6E697DAC74FE = _id_A2731E6D9AF15254 vehicle_getvelocity();

    if(isDefined(_id_9A0A6E697DAC74FE))
      _id_6245153AB14FEE9F = _id_6245153AB14FEE9F + _id_9A0A6E697DAC74FE;
  }

  return _id_6245153AB14FEE9F;
}

_id_E5BE7A1F18A659FB(grenade, vehicle) {
  if(isDefined(vehicle)) {
    scripts\cp_mp\utility\weapon_utility::_id_28E583BFECC38A25(vehicle, self.team);

    if(!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoteam(vehicle, self.team)) {
      damagedata = spawnStruct();
      damagedata.inflictor = grenade;
      damagedata.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43(vehicle.vehiclename));
      damagedata.meansofdeath = "MOD_EXPLOSIVE";
      damagedata.attacker = grenade.owner;
      _id_29187EC6E45D7481 = spawnStruct();
      _id_29187EC6E45D7481.nocorpse = 1;
      vehicle scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(vehicle, damagedata, _id_29187EC6E45D7481);
    }
  }

  if(isDefined(grenade._id_57A5AFD100D3BFDA)) {
    grenade._id_57A5AFD100D3BFDA unlink();
    grenade._id_57A5AFD100D3BFDA = scripts\mp\utility\weapon::_launchgrenade("bunkerbuster_burrowed_mp", vehicle.origin, (0, 0, 0), undefined, 1, grenade._id_57A5AFD100D3BFDA);
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode", 0);
    grenade._id_57A5AFD100D3BFDA linkTo(vehicle, "tag_origin");
  }
}

_id_E41A24EF376DBF52(grenade, player) {
  if(isdismembermentenabled() || isagent(player))
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode-player-stuck", 0);
  else
    grenade setscriptablepartstate("effects", "explode", 0);
}

_id_BE84A39B52576D18() {
  level endon("game_ended");
  self endon("explode");
  self.owner scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  thread _id_A5A20B852C325190();
}

_id_A5A20B852C325190(immediate, _id_5996067FA75E09D4) {
  level endon("game_ended");
  self endon("death");
  self notify("explode");

  if(!isDefined(self) || istrue(self.exploding)) {
    return;
  }
  self.exploding = 1;

  if(istrue(_id_5996067FA75E09D4)) {
    _id_4B54B08A970445F6 = getdvarfloat("dvar_A72D28A8EEF62114", 0.5);
    wait(_id_4B54B08A970445F6);
  }

  self setscriptablepartstate("effects", "destroy", 0);

  if(!istrue(immediate))
    wait 0.25;

  thread _id_F0ACD469CE8642B9();
}

_id_F0ACD469CE8642B9() {
  self notify("death");
  _id_7F69923DC06F01D7();
  self delete();
}

_id_E241396812ED67B2() {
  level endon("game_ended");
  self endon("explode");
  self waittill("death");
  _id_7F69923DC06F01D7();
}

_id_7F69923DC06F01D7() {
  if(isDefined(self._id_57A5AFD100D3BFDA) && !istrue(self._id_57A5AFD100D3BFDA._id_AD590A75663898F3))
    self._id_57A5AFD100D3BFDA delete();

  if(isDefined(self._id_F2C94EC1C211C6D6))
    self._id_F2C94EC1C211C6D6 delete();

  if(isDefined(self._id_CE509EB5353C18AB))
    self._id_CE509EB5353C18AB delete();
}

_id_66629D921C921905(data) {
  grenade = data.inflictor;
  victim = data.victim;

  if(data.meansofdeath == "MOD_IMPACT") {
    if(isDefined(data.hitloc) && data.hitloc == "shield") {
      grenade._id_16AC6FAC07EACBC3 = 1;

      if(isDefined(victim))
        grenade._id_CE68DE48BC529CD2 = victim;
    }
  }
}

_id_C4EA262B1D9B9791(data) {
  grenade = data.inflictor;
  victim = data.victim;

  if(data.meansofdeath == "MOD_IMPACT") {
    if(isDefined(data.hitloc) && data.hitloc == "shield") {
      grenade._id_16AC6FAC07EACBC3 = 1;

      if(isDefined(victim))
        grenade._id_CE68DE48BC529CD2 = victim;
    }
  }
}

_id_B628A9F30E4B39C7(grenade) {
  if(_id_805FE3E45F3BCBE0(grenade))
    return 120;
  else
    return 200;
}

_id_C38D0C6D56A3D8BC(grenade) {
  if(_id_805FE3E45F3BCBE0(grenade))
    return getdvarint("dvar_BE292C291D5DE958", 10);
  else
    return getdvarint("dvar_E3ECBCC6D770D476", 50);
}

_id_5C205DC5E843711C(grenade) {
  if(_id_0943B92015D44AE1(grenade))
    return "bunkerbuster_gl_v2_mp";
  else
    return "bunkerbuster_gl_mp";
}

_id_085123E3A93096CB(grenade) {
  if(_id_805FE3E45F3BCBE0(grenade)) {
    if(_id_0943B92015D44AE1(grenade))
      return "bunkerbuster_burrowed_gl_v2_mp";
    else
      return "bunkerbuster_burrowed_gl_mp";
  } else
    return "bunkerbuster_burrowed_mp";
}

_id_4BDB5FCE70A89130(grenade) {
  if(_id_805FE3E45F3BCBE0(grenade)) {
    if(_id_0943B92015D44AE1(grenade))
      return "bunkerbuster_not_burrowed_gl_v2_mp";
    else
      return "bunkerbuster_not_burrowed_gl_mp";
  } else
    return "bunkerbuster_not_burrowed_mp";
}

_id_802E4FE81FEB0DC6(grenade) {
  if(_id_805FE3E45F3BCBE0(grenade)) {
    if(_id_0943B92015D44AE1(grenade))
      return "bunkerbuster_round_gl_v2_mp";
    else
      return "bunkerbuster_round_gl_mp";
  } else
    return "bunkerbuster_round_mp";
}

_id_805FE3E45F3BCBE0(grenade) {
  return isDefined(grenade._id_805FE3E45F3BCBE0);
}

_id_0943B92015D44AE1(grenade) {
  return isDefined(grenade._id_939636F512801E8E) && grenade._id_939636F512801E8E == 2;
}

_id_9C3216631600C8A9(glgrenade, _id_A681B7890CD017C7) {
  self endon("stopBunkerbusterStuckMonitors");
  glgrenade waittill("missile_door_stuck", _id_C1D84AB4C521636D);
  _id_A681B7890CD017C7._id_972C39A514F196D1 = _id_C1D84AB4C521636D;
}

_id_2DB5F44DBF46AE26(glgrenade, _id_A681B7890CD017C7) {
  self endon("stopBunkerbusterStuckMonitors");
  glgrenade waittill("missile_water_impact");
  _id_A681B7890CD017C7._id_6150B9D03028F80C = 1;
}

_id_AD336C2696ABFCC5() {
  level endon("game_ended");
  self endon("explode");
  self endon("death");
  self waittill("unlinkGrenade");

  if(self islinked())
    self unlink();
}

_id_50975E0BBD033649(stuckto) {
  level endon("game_ended");
  self endon("explode");
  self endon("death");

  while(isDefined(stuckto))
    waitframe();

  self notify("unlinkGrenade");
}

_id_F74EDE2695719F2F() {
  level endon("game_ended");
  self endon("explode");
  self endon("death");

  if(isDefined(self._id_A681B7890CD017C7._id_972C39A514F196D1) && self._id_A681B7890CD017C7._id_972C39A514F196D1 scriptableisdoor()) {
    _id_52B3CF8D2E3C1890 = self._id_A681B7890CD017C7._id_972C39A514F196D1 scriptabledoorangle();

    for(;;) {
      wait 0.1;

      if(!isDefined(self._id_A681B7890CD017C7._id_972C39A514F196D1)) {
        break;
      }

      _id_1B1FF29FE94010F6 = self._id_A681B7890CD017C7._id_972C39A514F196D1 scriptabledoorangle();

      if(_id_1B1FF29FE94010F6 != _id_52B3CF8D2E3C1890) {
        break;
      }
    }

    self notify("unlinkGrenade");
  }
}

shouldlink(stuckto, _id_16A48D7056E5C472) {
  if(isDefined(stuckto) && isDefined(stuckto.code_classname) && stuckto.code_classname == "scriptable")
    return 0;

  return 1;
}

_id_EAE0802093A7E5F5(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.weapon_name))
    return 0;

  switch (weapon.weapon_name) {
    case "bunkerbuster_round_mp":
    case "bunkerbuster_not_burrowed_mp":
    case "bunkerbuster_mp":
    case "bunkerbuster_burrowed_mp":
      return 1;
    default:
      return 0;
  }
}