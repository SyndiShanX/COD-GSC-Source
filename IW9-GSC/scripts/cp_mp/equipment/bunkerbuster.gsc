/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\bunkerbuster.gsc
****************************************************/

_id_3D78DD516C25EF77(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("explode");
  grenade endon("death");
  grenade thread _id_BE84A39B52576D18();
  grenade thread _id_E241396812ED67B2();
  grenade waittill("missile_stuck", stuckto);
  _id_2D7C3D3CBA3B7824(grenade, stuckto);
}

_id_2D7C3D3CBA3B7824(grenade, _id_A9F071BAF842F12A) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  _id_E29C6802D3127907 = getdvarfloat("dvar_0F1406BA08FA573E", 0.25);
  wait(_id_E29C6802D3127907);
  grenade setscriptablepartstate("effects", "plant", 0);
  stuckto = _id_A9F071BAF842F12A;
  _id_6150B9D03028F80C = undefined;

  if(istrue(_id_6150B9D03028F80C)) {
    _id_C8FD05BF21971A04(grenade, "dig_fail");
    _id_3A35103112044E22(grenade);
    _id_2C9EC2084CA01277(grenade, 0);
  } else if(isDefined(stuckto)) {
    grenade childthread _id_A7E67BCACD313B7D(stuckto);
    grenade.stuckto = stuckto;

    if(isPlayer(stuckto))
      _id_A9DFE926FABD3B25(grenade);
    else if(isai(stuckto))
      _id_0579620DC242D8F0(grenade, stuckto);
    else if(stuckto.classname == "grenade" || stuckto.classname == "misc_turret" || stuckto.classname == "scriptable") {
      _id_C8FD05BF21971A04(grenade, "dig_fail");
      _id_3A35103112044E22(grenade);
      _id_2C9EC2084CA01277(grenade, 0);
    } else if(stuckto.classname == "script_vehicle")
      _id_6E25A608EAFBC362(grenade, stuckto);
    else
      _id_9C1241B88A86E763(grenade);
  } else
    _id_9C1241B88A86E763(grenade);
}

_id_A7E67BCACD313B7D(stuckto) {
  self endon("death");
  self endon("explode");

  if(isPlayer(stuckto)) {
    return;
  }
  stuckto waittill("death");
  thread _id_A5A20B852C325190();
}

_id_0579620DC242D8F0(grenade, stuckto) {
  victim = stuckto;
  _id_C39F2C11290B6AEA = "player_stuck";
  grenade thread _id_74502A9E0EF1F19C::grenadestuckto(grenade, victim);
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA);
  victim childthread _id_03355863915967BB(grenade);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_03355863915967BB(grenade) {
  _id_E601ACF6AD00AF27 = getdvarint("dvar_36B6FE748DB87BEE", 5);
  _id_6A9734D81CBB50E7 = getdvarint("dvar_D7DF18C5F0EC5694", 8);
  maxtime = getdvarfloat("dvar_6EB6BA9E7CE00943", 0.6);
  starttime = gettime();

  for(_id_5FA323075902C461 = 0; _id_5FA323075902C461 < _id_6A9734D81CBB50E7; _id_5FA323075902C461++) {
    self dodamage(_id_E601ACF6AD00AF27, grenade.origin, grenade.owner, grenade, "MOD_EXPLOSIVE", grenade.weapon_object);
    wait(maxtime / _id_6A9734D81CBB50E7);
  }
}

_id_A9DFE926FABD3B25(grenade) {
  victim = grenade.stuckto;
  grenade thread _id_74502A9E0EF1F19C::grenadestuckto(grenade, victim);
  _id_C8FD05BF21971A04(grenade, 1);
  _id_3A35103112044E22(grenade);
  thread _id_2C9EC2084CA01277(grenade);
}

_id_9C1241B88A86E763(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");
  upvec = anglestoup(grenade.angles);
  offset = getdvarint("dvar_E3ECBCC6D770D476", 50);
  _id_2FC7B90001702E5C = [grenade];
  _id_B376FA2D061141C0 = grenade.origin;
  _id_5E8EDE0EF6D7F3AB = anglestoup(grenade.angles);
  _id_5996067FA75E09D4 = 0;

  while(offset <= 200) {
    _id_28AE17B3CCEE3B7E = upvec * -1 * offset;
    endorigin = grenade.origin + _id_28AE17B3CCEE3B7E;
    _id_18C1624C21C1E9C1 = scripts\engine\trace::ray_trace(endorigin, grenade.origin, _id_2FC7B90001702E5C, scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0, 0, 0), 1);

    if(_id_18C1624C21C1E9C1["hittype"] != "hittype_none") {
      _id_B376FA2D061141C0 = _id_18C1624C21C1E9C1["position"];
      _id_5E8EDE0EF6D7F3AB = _id_18C1624C21C1E9C1["normal"];
      _id_5996067FA75E09D4 = 1;
      break;
    }

    offset = offset + getdvarint("dvar_E3ECBCC6D770D476", 50);
    waitframe();
  }

  if(_id_5996067FA75E09D4)
    _id_5996067FA75E09D4 = _id_8F7774E4E68D2A43(grenade, _id_B376FA2D061141C0, _id_5E8EDE0EF6D7F3AB);

  _id_303D9FA226476812 = anglestoup(self getworldupreferenceangles());
  _id_C83A8D3D629F1DAC = anglestoup(grenade.angles);
  _id_0FCCBF8939AD0065 = vectordot(_id_303D9FA226476812, _id_C83A8D3D629F1DAC);
  grenade._id_BFCF780C7F28FBD4 = _id_0FCCBF8939AD0065 >= -0.5 && _id_0FCCBF8939AD0065 <= 0.5;
  _id_C39F2C11290B6AEA = scripts\engine\utility::ter_op(_id_5996067FA75E09D4, "dig_success", "dig_fail");
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA, _id_B376FA2D061141C0, _id_5E8EDE0EF6D7F3AB);
  _id_2A21B9990F69270E = getdvarfloat("dvar_DCC19C96AF625740", 0.0);
  wait(_id_2A21B9990F69270E);

  if(!_id_5996067FA75E09D4)
    _id_3A35103112044E22(grenade);
  else
    _id_5F9B222EF93F265E(grenade, _id_B376FA2D061141C0, _id_5E8EDE0EF6D7F3AB);

  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_C8FD05BF21971A04(grenade, _id_318555433A0D7DA0, spawnpoint, _id_30F3BD16D27CF3BC, _id_5BCDE5D4993ABF00) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  grenade endon("explode");

  if(!isDefined(spawnpoint))
    spawnpoint = grenade.origin;

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

    if(_id_318555433A0D7DA0 == "player_stuck")
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

  if(istrue(grenade._id_25939B3C785FABB9))
    _id_AD5532BD0A7F34D7 = 3.0;

  if(istrue(grenade._id_5BCDE5D4993ABF00))
    _id_AD5532BD0A7F34D7 = 1.5;

  wait(getdvarfloat("dvar_4E0C2A5ACE3ABB90", _id_AD5532BD0A7F34D7));
  _id_500B28A55F3ECC0E(grenade, _id_C39F2C11290B6AEA);
}

_id_6E25A608EAFBC362(grenade, vehicle) {
  grenade._id_25939B3C785FABB9 = 1;
  grenade _id_5A71826BEC10F4F0(vehicle);
  grenade thread _id_B0492540CA02A187(vehicle);
  _id_C39F2C11290B6AEA = "vehicle_stuck";
  _id_C8FD05BF21971A04(grenade, _id_C39F2C11290B6AEA);
  _id_3A35103112044E22(grenade);
  _id_2C9EC2084CA01277(grenade, _id_C39F2C11290B6AEA);
}

_id_B0492540CA02A187(vehicle) {
  self endon("death");
  vehicle endon("death");
  level endon("game_ended");

  for(;;) {
    vehicle waittill("vehicle_owner_update");
    _id_5A71826BEC10F4F0(vehicle);
  }
}

_id_5A71826BEC10F4F0(vehicle) {
  _id_709B8964351947BB = 0;

  if(self.owner.team != vehicle.team && vehicle.team != "neutral")
    _id_709B8964351947BB = 1;

  if(!_id_709B8964351947BB) {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

    if(occupants.size > 0) {
      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(isDefined(_id_F85572CD5F6117C6)) {
          if(_id_F85572CD5F6117C6.team != self.owner.team)
            _id_709B8964351947BB = 1;
          else
            _id_709B8964351947BB = 0;

          break;
        }
      }
    }
  }

  if(_id_709B8964351947BB)
    scripts\cp_mp\utility\weapon_utility::_id_69D45A21A6D4E9F8(vehicle);
}

_id_5F9B222EF93F265E(grenade, spawnpoint, _id_5E8EDE0EF6D7F3AB) {
  grenade._id_57A5AFD100D3BFDA = scripts\cp\utility::_launchgrenade("bunkerbuster_burrowed_mp", spawnpoint + anglestoup(grenade.angles) * -1 * 8, (0, 0, 0), 100, 1);
  grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon("bunkerbuster_burrowed_mp");
  grenade._id_57A5AFD100D3BFDA linkTo(grenade._id_F2C94EC1C211C6D6);
  grenade._id_57A5AFD100D3BFDA.angles = vectortoangles(_id_5E8EDE0EF6D7F3AB);
  grenade setscriptablepartstate("effects", "sizzle-success", 0);
  grenade._id_57A5AFD100D3BFDA setscriptablepartstate("danger-icon", "on", 0);
  level thread scripts\engine\utility::draw_angles(grenade._id_57A5AFD100D3BFDA.angles, grenade._id_57A5AFD100D3BFDA.origin, (1, 0, 0), 1000, 50.0);
}

_id_3A35103112044E22(grenade) {
  _id_57A5AFD100D3BFDA = scripts\cp\utility::_launchgrenade("bunkerbuster_not_burrowed_mp", grenade.origin, (0, 0, 0), 100, 1);
  _id_57A5AFD100D3BFDA linkTo(grenade._id_F2C94EC1C211C6D6);
  grenade._id_57A5AFD100D3BFDA = _id_57A5AFD100D3BFDA;
  grenade._id_57A5AFD100D3BFDA.weapon_object = makeweapon("bunkerbuster_burrowed_mp");
}

_id_8F7774E4E68D2A43(grenade, _id_256392925C393BD0, _id_2B268884E45F090A) {
  offset = getdvarint("dvar_8FEB82DD51A5A0C2", 25);
  _id_256392925C393BD0 = _id_256392925C393BD0 + _id_2B268884E45F090A * offset;
  isoob = scripts\cp\cp_outofbounds::ispointinoutofbounds(_id_256392925C393BD0, self.team);

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

  if(isDefined(stuckto) && (_id_C39F2C11290B6AEA == "vehicle_stuck" || _id_C39F2C11290B6AEA == "player_stuck"))
    _id_1CDF454E2F856A7F(grenade);
  else if(_id_C39F2C11290B6AEA == "dig_success") {
    _id_C225480C1FD1C87F = grenade._id_F2C94EC1C211C6D6.angles;
    _id_160A13625801ABEC = grenade._id_57A5AFD100D3BFDA.origin;
    grenade._id_57A5AFD100D3BFDA unlink();
    grenade._id_57A5AFD100D3BFDA delete();
    _id_6E17D9FBF3B64B04 = (0, 0, 0);
    _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglesToForward(_id_C225480C1FD1C87F) * getdvarint("dvar_8766C486F2519FFB", 300);

    if(istrue(grenade._id_BFCF780C7F28FBD4))
      _id_6E17D9FBF3B64B04 = _id_6E17D9FBF3B64B04 + anglestoup(_id_C225480C1FD1C87F) * getdvarint("dvar_6BFFD30022E9BCAB", 0) * -1;

    grenade._id_57A5AFD100D3BFDA = scripts\cp\utility::_launchgrenade("bunkerbuster_round_mp", _id_160A13625801ABEC, _id_6E17D9FBF3B64B04, 100, 1);
    grenade._id_57A5AFD100D3BFDA.angles = _id_C225480C1FD1C87F;
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "shoot", 0);
    grenade setscriptablepartstate("effects", "shoot", 0);
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("danger-icon", "on", 0);
    _id_1CA111FF86819C24 = getdvarfloat("dvar_B75D73BDCEFF168F", 0.5);
    grenade._id_57A5AFD100D3BFDA scripts\engine\utility::waittill_any_timeout_1(_id_1CA111FF86819C24, "missile_stuck");
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode", 0);
  } else
    grenade setscriptablepartstate("effects", "explode", 0);

  wait 0.1;

  if(isDefined(grenade._id_57A5AFD100D3BFDA))
    grenade._id_57A5AFD100D3BFDA detonate();

  grenade thread _id_A5A20B852C325190(0, scripts\engine\utility::ter_op(_id_C39F2C11290B6AEA == "dig_success", 1, 0));
}

_id_1CDF454E2F856A7F(grenade) {
  stuckto = grenade.stuckto;

  if(stuckto.classname == "script_vehicle")
    _id_E5BE7A1F18A659FB(grenade, stuckto);
  else if(isPlayer(stuckto) || isai(stuckto))
    _id_591B951A9D91FFE4(grenade, stuckto);
}

_id_E5BE7A1F18A659FB(grenade, vehicle) {
  scripts\cp_mp\utility\weapon_utility::_id_28E583BFECC38A25(vehicle);
  vehiclename = vehicle.vehiclename;

  if(vehiclename == "apc_russian" || vehiclename == "light_tank" || vehiclename == "veh9_apc_8x8") {
    damagedata = spawnStruct();
    damagedata.inflictor = vehicle;
    damagedata.objweapon = makeweapon(scripts\cp_mp\vehicles\vehicle_damage::_id_7AAA7AE503292F43(vehicle.vehiclename));
    damagedata.meansofdeath = "MOD_EXPLOSIVE";
    damagedata.attacker = grenade.owner;
    _id_29187EC6E45D7481 = spawnStruct();
    _id_29187EC6E45D7481.nocorpse = 1;
    vehicle scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(vehicle, damagedata, _id_29187EC6E45D7481);
  } else {
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle, 0);

    if(isDefined(occupants) && occupants.size > 0) {
      foreach(_id_F85572CD5F6117C6 in occupants)
      _id_F85572CD5F6117C6 dodamage(_id_F85572CD5F6117C6.health, grenade.origin, self, grenade, "MOD_EXPLOSIVE");
    }
  }

  if(isDefined(grenade._id_57A5AFD100D3BFDA)) {
    grenade._id_57A5AFD100D3BFDA unlink();
    grenade._id_57A5AFD100D3BFDA = scripts\cp\utility::_launchgrenade("bunkerbuster_burrowed_mp", vehicle.origin, (0, 0, 0), undefined, 1, grenade._id_57A5AFD100D3BFDA);
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode", 0);
    grenade._id_57A5AFD100D3BFDA linkTo(vehicle, "tag_origin");
  }
}

_id_591B951A9D91FFE4(grenade, player) {
  if(isDefined(grenade._id_57A5AFD100D3BFDA))
    grenade._id_57A5AFD100D3BFDA setscriptablepartstate("shoot", "explode-player-stuck", 0);
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

  if(istrue(self.exploding)) {
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
  if(isDefined(self._id_57A5AFD100D3BFDA))
    self._id_57A5AFD100D3BFDA delete();

  if(isDefined(self._id_F2C94EC1C211C6D6))
    self._id_F2C94EC1C211C6D6 delete();
}