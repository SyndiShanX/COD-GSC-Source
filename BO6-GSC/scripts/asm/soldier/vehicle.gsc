/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\vehicle.gsc
*******************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;
#namespace vehicle;

function setvehiclearchetype(asmname, statename, params) {
  self setoverridearchetype("\xb3VC-\xc6c\xb2", self._blackboard.currentvehicleanimalias, 1);
}

function clearvehiclearchetype(asmname, statename, params) {
  self clearoverridearchetype("\xb3VC-\xc6c\xb2", 0, 1);
}

function function_832ff39c595bada9(asmname, statename, tostatename, params) {
  if(!isDefined(self._blackboard.currentvehicle)) {
    return true;
  }

  var_1fdabd490b017732 = distancesquared(self.origin, self._blackboard.currentvehicle.origin);

  if(var_1fdabd490b017732 > 50000) {
    return false;
  }

  return true;
}

function function_4f2a3a6670010736() {
  alias = "";

  if(istrue(self.vehicleseatonleft)) {
    alias += "}h";
  } else {
    alias += "\xa7~";
  }

  if(isDefined(self.enemy)) {
    toenemy = self.enemy.origin - self.origin;
    toenemyyaw = angleclamp180(vectortoyaw(toenemy) - self.angles[1]);

    if(toenemyyaw < 0) {
      alias += ">[\xb3-@\xa2";
    } else {
      alias += "\"\x17\x1d\xdd\xfeg";
    }
  } else if(istrue(self.vehicleseatonleft)) {
    alias += "\"\x17\x1d\xdd\xfeg";
  } else {
    alias += ">[\xb3-@\xa2";
  }

  return alias;
}

function getpainalias(aianims) {
  alias = "";
  flashed = utility::isflashed();

  if(isDefined(self.damageyaw) && !flashed) {
    if(self.damageyaw > 135) {
      alias += "\xbed";
    } else if(self.damageyaw > 45) {
      alias += "}h";
    } else if(self.damageyaw > -45) {
      alias += "9G";
    } else if(self.damageyaw > -135) {
      alias += "\xa7~";
    } else {
      alias += "\xbed";
    }
  }

  return alias;
}

function chooseanim_vehicle(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, self._blackboard.chosenvehicleanimpos_seatalias);
}

function function_92f9f62ce96d9ab7(asmname, statename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);
    alias += getpainalias(aianims);
  }

  animresult = archetypegetrandomalias(arcname, statename, alias, asm::asm_isfrantic());

  if(isDefined(animresult)) {
    return asm::asm_lookupanimfromalias(statename, alias);
  }

  return asm::asm_lookupanimfromalias(statename, self._blackboard.chosenvehicleanimpos_seatalias);
}

function function_9958e6884ac983af(asmname, statename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);
  }

  return asm::asm_lookupanimfromalias(statename, alias);
}

function function_da1b169db5d5dcdd(asmname, statename, params) {
  return chooseanim_vehicle(asmname, statename, params);
}

function function_364adb1589768a53(asmname, statename, params) {
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self.vehicleseatonleft)) {
    switchsidesalias = function_4f2a3a6670010736();
    alias += switchsidesalias;
    self.vehicleseatonleft = !self.vehicleseatonleft;
    self._blackboard.var_875b39f7301fc34a = self.vehicleseatonleft;
  }

  return asm::asm_lookupanimfromalias(statename, alias);
}

function function_96b061f67fd33a8b(asmname, statename, tostatename, param) {
  return self[[self.fnisinstealthidle]]();
}

function vehicleincombat(asmname, statename, tostatename, params) {
  if(weaponclass(self.weapon) == "\x03\xb0\xa1\xa9\x04\xac\x88\x82\x88\x18\xb6\xed\xe1\x82" && !istrue(self.vehiclerpg)) {
    return false;
  }

  return asm::asm_getdemeanor() == "\xe3\xd0\xc3e\x85h" && !self[[self.fnisinstealthhunt]]();
}

function function_72e0d74bee81f907(asmname, statename, param) {
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(archetypegetrandomalias(self._blackboard.currentvehicleanimalias, statename, alias, asm::asm_isfrantic()))) {
    return asm::asm_lookupanimfromalias(statename, alias);
  }

  alias = alias + "w" + self._blackboard.vehicledir;
  assert(isDefined(self.collision_data), "<dev string:x24>");
  vehicle = self._blackboard.currentvehicle;
  forward = anglesToForward(vehicle.angles);
  normal = self.collision_data.normal;
  function_10332bf08c601c58();

  setdvarifuninitialized(@ "hash_e4eece17e1ee5b59", 0);

  ccos45 = 0.70711;
  forwarddotimpact = vectordot(forward, normal);

  if(forwarddotimpact > ccos45) {
    alias += "\xbed";

    if(getdvarint(@ "hash_e4eece17e1ee5b59") != 0) {
      print3d(self.origin, alias, (0, 1, 0), 1, 0.5, 100, 1);
    }

    return asm::asm_lookupanimfromalias(statename, alias);
  } else if(forwarddotimpact < -1 * ccos45) {
    alias += "9G";

    if(getdvarint(@ "hash_e4eece17e1ee5b59") != 0) {
      print3d(self.origin, alias, (0, 1, 0), 1, 0.5, 100, 1);
    }

    return asm::asm_lookupanimfromalias(statename, alias);
  }

  var_2fae3371f60d2a0d = vectorcross(forward, normal);

  if(var_2fae3371f60d2a0d[2] > 0) {
    alias += "\xa7~";

    if(getdvarint(@ "hash_e4eece17e1ee5b59") != 0) {
      print3d(self.origin, alias, (0, 1, 0), 1, 0.5, 100, 1);
    }

    return asm::asm_lookupanimfromalias(statename, alias);
  }

  alias += "}h";

  if(getdvarint(@ "hash_e4eece17e1ee5b59") != 0) {
    print3d(self.origin, alias, (0, 1, 0), 1, 0.5, 100, 1);
  }

  return asm::asm_lookupanimfromalias(statename, alias);
}

function function_e4735a408a1d1037(asmname, statename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self._blackboard.vehicledir) && self._blackboard.vehicledir != 8) {
    alias = alias + "w" + self._blackboard.vehicledir;
  }

  weaponclassalias = "w" + weaponclass(self.weapon);
  var_e931b4249ccfed91 = archetypegetrandomalias(arcname, statename, alias + weaponclassalias, asm::asm_isfrantic());

  if(isDefined(var_e931b4249ccfed91)) {
    return asm::asm_lookupanimfromalias(statename, alias + weaponclassalias);
  }

  animresult = archetypegetrandomalias(arcname, statename, alias, asm::asm_isfrantic());

  if(isDefined(animresult)) {
    return asm::asm_lookupanimfromalias(statename, alias);
  }

  var_e931b4249ccfed91 = archetypegetrandomalias(arcname, statename, self._blackboard.chosenvehicleanimpos_seatalias + weaponclassalias, asm::asm_isfrantic());

  if(isDefined(var_e931b4249ccfed91)) {
    return asm::asm_lookupanimfromalias(statename, self._blackboard.chosenvehicleanimpos_seatalias + weaponclassalias);
  }

  return asm::asm_lookupanimfromalias(statename, self._blackboard.chosenvehicleanimpos_seatalias);
}

function chooseanim_vehicleturret(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, "\x9a\x93\xb5\xc4I");
}

function chooseanim_vehicleturretdeath(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, "\xec\x95\x86KccY\xd7\xe8\xaeNNe\xa3\xfa\x8c\x95a:h");
}

function getvehicleanimtargetoriginandangles(vehicle, vehicleanim, vehicletag, vehiclelocation, vehicleangles, animendfrac) {
  result = [];

  if(!isDefined(animendfrac)) {
    animendfrac = 1;
  }

  if(isDefined(vehicle) && isDefined(vehicletag)) {
    tagorigin = vehicle gettagorigin(vehicletag);
    tagangles = vehicle gettagangles(vehicletag);
    seatinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_70902d09f32053a7);

    if(isDefined(seatinfo) && isDefined(seatinfo.linkoffset)) {
      tagorigin += rotatevector(seatinfo.linkoffset, vehicle.angles);
    }

    if(isDefined(seatinfo) && isDefined(seatinfo.linkangle)) {
      tagangles += seatinfo.linkangle;
    }

    startorigin = getstartorigin(tagorigin, tagangles, vehicleanim);
    startangles = getstartangles(tagorigin, tagangles, vehicleanim);
    movedelta = getmovedelta(vehicleanim, 0, animendfrac);
    angledelta = getangledelta3d(vehicleanim, 0, animendfrac);
    result["h3\xc8\t\xbf\x15\x11\xc3\xcf\xa5\xd2"] = startorigin;
    result[";P\xb4\x94\x1a\x8e\x03\xa3_\x92\xb0"] = startangles;
    result["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"] = rotatevector(movedelta, startangles) + startorigin;
    result["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"] = startangles + angledelta;
  } else {
    result["h3\xc8\t\xbf\x15\x11\xc3\xcf\xa5\xd2"] = self.origin;
    result[";P\xb4\x94\x1a\x8e\x03\xa3_\x92\xb0"] = self.angles;
    result["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"] = vehiclelocation;
    result["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"] = vehicleangles;
  }

  return result;
}

function linktovehicle(org, ang, linktoblend, sittag) {
  self forceteleport(org, ang);

  if(istrue(linktoblend)) {
    self linktoblendtotag(self._blackboard.currentvehicle, sittag, 0);
  } else {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);

    if(isDefined(aianims.linkoffset) && isDefined(aianims.linkangle)) {
      self linktomoveoffset(self._blackboard.currentvehicle, sittag, aianims.linkoffset, aianims.linkangle);
    } else if(istrue(self._blackboard.currentvehicle.var_2d3853acc08178ae)) {
      self linktomoveoffset(self._blackboard.currentvehicle, sittag);
    } else {
      self linktomoveoffset(self._blackboard.currentvehicle, sittag, (0, 0, 0), (0, 0, 0));
    }
  }

  if(isagent(self)) {
    self playerlinkedoffsetenable();
    self fixlinktointerpolationbug(1);
  }

  self._blackboard.linkedtovehicle = 1;
}

function faceenemyincombat(asmname, statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    canshootinvehicle = istrue(self._blackboard.var_5c6cf4dcbd69fba) && istrue(self.canshootinvehicle);
    canrotate = isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.currentvehicle.vehicledisableturningwhileshooting);
    enemyisalive = isDefined(self.enemy) && (!(isPlayer(self.enemy) || isai(self.enemy)) || isalive(self.enemy));
    incombat = vehicleincombat(asmname, statename, statename);

    if(incombat && enemyisalive && canshootinvehicle && canrotate) {
      axis = anglestoaxis(self._blackboard.currentvehicle.angles);
      forward = axis["\xa17\xd3\x9fT\x14P"];
      up = axis["\xf3\xf2"];
      yaw = utility::getyaw(self.enemy.origin) - self._blackboard.currentvehicle.angles[1];
      yaw = angleclamp180(yaw);
      facing = rotatepointaroundvector(up, forward, yaw);
      faceangles = axistoangles(facing, vectorcross(facing, up), up);
      self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", faceangles);
    } else {
      self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");
    }

    if(getdvarint(@ "hash_e8e7feb9b789f1d7") && incombat) {
      sphere(self.origin + (0, 0, 40), 2.5, (0, 1, 0), 0, 1);
      line(self.origin + (0, 0, 40), self.origin + (0, 0, 40) + anglesToForward(self.angles) * 10, (0, 1, 0), 1, 0, 1);
    }

    waitframe();
  }
}

function playanim_vehicleidle(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  setvehiclearchetype();

  if(isDefined(self.vehicleaimyawspeed)) {
    self.aimyawspeed = self.vehicleaimyawspeed;
  } else {
    self.aimyawspeed = 108;
  }

  if(isDefined(self.var_8308bc504651092b)) {
    self.var_297b474a8588368e = self.var_8308bc504651092b;
  } else {
    self.var_8308bc504651092b = -1;
  }

  if(!istrue(self._blackboard.linkedtovehicle) && isDefined(self._blackboard.currentvehicle)) {
    self.leftaimlimit = 180;
    self.rightaimlimit = -180;
    animindexidle = asm::asm_getanim(asmname, "j\x16\xef\x0f6\xf0x]\xda\xc5\xbc\xb2");
    xanimidle = asm::asm_getxanim("j\x16\xef\x0f6\xf0x]\xda\xc5\xbc\xb2", animindexidle);
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanimidle, self._blackboard.chosenvehicleanimpos_sittag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles);
    linktovehicle(self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"], self.asm.targetvalues["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag);
  }

  self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
  self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");
  animindex = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animindex);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function function_36931f9a8b220919(asmname, statename, params) {
  setvehiclearchetype();
  asm::asm_playanimstate(asmname, statename, params);
}

function function_bb26437d55301c7c(asmname, statename, params) {
  setvehiclearchetype();
  pain::playpainanim(asmname, statename, params);
}

function function_bcd68e0f2185ed05(asmname, statename, params) {
  setvehiclearchetype();
  pain::playanim_flashed(asmname, statename, params);
}

function vehicleturretshootthread(turret) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\a-\xf8\xc8 \x9b");
  self endon("\xf6\xc3\x1c\x84\xf6\xba\x01\x96[\xee\\\xe7|");
  turret utility::self_func("\xd5\t6|\xe3\x1em\xb7\xd0~@", 2);
  turret setmode("\x80Gk\xed2\x17");
  turret.gunner = self;
  self linktoblendtotag(turret, "{\x12\xae\x05\x0fd\xc2\xeet\xca", 0);
  mercy = 0;
  maxmercy = 2;
  var_9929d8f5137c1ef0 = 0;
  loseplayertime = 7000;

  while(isalive(self)) {
    if(isDefined(self.enemy)) {
      turret settargetentity(self.enemy);
      turret waittill("\x8a7\xb86a\x101\xd5\xc5%\x15A4\xe0\xb4\x8c");
      burst = randomintrange(12, 18);
      shots = 0;
      minshots = randomintrange(7, 12);

      for(i = 0; i < burst; i++) {
        shots++;
        turret shootturret();
        wait 0.05;

        if(randomint(100) < 25) {
          wait randomfloatrange(0.1, 0.2);
        }

        target = turret getturrettarget(0);

        if(isDefined(target) && isPlayer(target) && mercy < maxmercy && target.health < 60) {
          mercy++;
          wait 3;
        }

        if(shots > minshots) {
          if(isDefined(target) && issentient(target) && !isalive(target)) {
            break;
          }
        }
      }

      var_9929d8f5137c1ef0 = gettime() + loseplayertime;
    } else if(var_9929d8f5137c1ef0 <= gettime()) {
      turret cleartargetentity();
    }

    wait 0.8 + randomfloat(1);
  }
}

function playanim_vehicleturret(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  utility::use_turret(self._blackboard.currentvehicle.mgturret[0], undefined);

  if(isDefined(self._blackboard.currentvehicle.mgturret[0]) && !istrue(self._blackboard.currentvehicle.mgturret[0].var_4df31d35aecdb533)) {
    if(isDefined(self._blackboard.currentvehicle.customattackfunc)) {
      self._blackboard.currentvehicle thread[[self._blackboard.currentvehicle.customattackfunc]]();
    } else {
      thread vehicleturretshootthread(self._blackboard.currentvehicle.mgturret[0]);
    }

    self._blackboard.currentvehicle.mgturret[0].var_4df31d35aecdb533 = 1;
  }

  setvehiclearchetype();
  self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
  self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");
  animindex = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animindex);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function playanim_vehicleturret_terminate(asmname, statename, params) {
  clearvehiclearchetype();

  if(isDefined(self._blackboard.currentvehicle) && isDefined(self._blackboard.currentvehicle.mgturret)) {
    if(isDefined(self._blackboard.currentvehicle.mgturret[0])) {
      self._blackboard.currentvehicle.mgturret[0] cleartargetentity();
      self._blackboard.currentvehicle.mgturret[0].var_4df31d35aecdb533 = 0;
    }
  }
}

function rotatetocurrentangles() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("&.\xf8(rq\x18ch\x1d\xe3\"\r\xe4\xee\r4l\xd8L");
  self endon(":\r\xf3p /\n\x89\x92]\x0f\xb9\xfa\v\aV\x17\x03nq\xff7\xebO");

  while(true) {
    self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", self.angles);
    waitframe();
  }
}

function enterexitvehiclemotionwarp(asmname, statename, xanim, vehicletag, exiting, xanimtargetoverride) {
  if(isPlayer(self)) {
    self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  } else {
    self endon("\x1e\xfd\xd1\xa2\a");
  }

  self endon("&.\xf8(rq\x18ch\x1d\xe3\"\r\xe4\xee\r4l\xd8L");
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  seatinfo = vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard.var_70902d09f32053a7);
  animlength = getanimlength(xanim);
  animstartfrac = 0;
  startnote = undefined;

  if(animhasnotetrack(xanim, "z\xa8#\xe2\x15-z\x80\x03,\xf3\xe0&>\xbaXR")) {
    animstartfrac = getnotetracktimes(xanim, "z\xa8#\xe2\x15-z\x80\x03,\xf3\xe0&>\xbaXR")[0];
    startnote = "z\xa8#\xe2\x15-z\x80\x03,\xf3\xe0&>\xbaXR";
  }

  animendfrac = 1;
  endnote = undefined;

  if(animhasnotetrack(xanim, "\xb5\xed\xe8Z\xb7\xcd\xeb\xbb,r\xe0\xbeY\xb9\x8c")) {
    animendfrac = getnotetracktimes(xanim, "\xb5\xed\xe8Z\xb7\xcd\xeb\xbb,r\xe0\xbeY\xb9\x8c")[0];
    endnote = "\xb5\xed\xe8Z\xb7\xcd\xeb\xbb,r\xe0\xbeY\xb9\x8c";
  }

  if(animhasnotetrack(xanim, "\xc9\x8e.\xcd\xf0F\x1a~\x91\xdb2\x9b\xe0\xd7\xb8c\xd5\xfb\xc0L\x02\b")) {
    var_6a6f4399082ea1f9 = getnotetracktimes(xanim, "\xc9\x8e.\xcd\xf0F\x1a~\x91\xdb2\x9b\xe0\xd7\xb8c\xd5\xfb\xc0L\x02\b")[0];

    if(exiting) {
      self.var_a19f1ca3c66a74b = gettime();
      self.var_3f4acb520fb46d06 = gettime() + 1000 * animlength * var_6a6f4399082ea1f9;
    } else {
      self.var_a19f1ca3c66a74b = gettime() + 1000 * animlength * var_6a6f4399082ea1f9;
      self.var_3f4acb520fb46d06 = gettime() + 1000 * animlength;
    }
  }

  linkpos = self._blackboard.currentvehicle gettagorigin(vehicletag);
  linkang = self._blackboard.currentvehicle gettagangles(vehicletag);

  if(isDefined(seatinfo.linkoffset)) {
    linkpos += rotatevector(seatinfo.linkoffset, self._blackboard.currentvehicle.angles);
  }

  if(isDefined(seatinfo.linkangle)) {
    linkang += seatinfo.linkangle;
  }

  animindex = asm::asm_getanim(asmname, statename);
  waittime = animlength * animstartfrac;

  if(vehicle_common::function_ab1070f459e6ea5a(3)) {
    sphere(self.origin, 2, (1, 0, 0), 0, 300);
  }

  if(exiting) {
    if(isDefined(self._blackboard.chosenvehicleanimpos_fastroperig)) {
      thread rotatetocurrentangles();
    } else {
      if(isDefined(xanimtargetoverride)) {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac);
      } else {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac);
      }

      self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", self.asm.targetvalues[";P\xb4\x94\x1a\x8e\x03\xa3_\x92\xb0"]);

      if(vehicle_common::function_ab1070f459e6ea5a(3)) {
        sphere(self.asm.targetvalues["<dev string:xbb>"], 3, (0, 0, 1), 0, 300);
      }
    }
  } else {
    self aisetanim(statename, animindex);
    var_199b78500560c4ac = self.origin - self._blackboard.currentvehicle gettagorigin(vehicletag);
    invlinkang = invertangles(self._blackboard.currentvehicle gettagangles(vehicletag));
    localtargetpos = rotatevector(var_199b78500560c4ac, invlinkang);
    var_50b7c0298b1a38de = combineanglesinverted(linkang, self.angles);
    self linktomoveoffset(self._blackboard.currentvehicle, vehicletag, localtargetpos, var_50b7c0298b1a38de);
    self._blackboard.linkedtovehicle = 1;
  }

  wait waittime;

  if(vehicle_common::function_ab1070f459e6ea5a(3)) {
    print3d(self.origin + (0, 0, 60), "<dev string:xcb>", (1, 1, 1), 1, 0.3, 300);
    sphere(self.origin, 2, (1, 0, 0), 0, 300);
  }

  self motionwarpcancel();

  if(!isDefined(self.asm)) {
    return;
  }

  self notify(":\r\xf3p /\n\x89\x92]\x0f\xb9\xfa\v\aV\x17\x03nq\xff7\xebO");

  if(isDefined(xanimtargetoverride)) {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanimtargetoverride, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac);
  } else {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, xanim, vehicletag, self._blackboard.chosenvehiclelocation, self._blackboard.chosenvehicleangles, animendfrac);
  }

  targetpoint = self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"];
  targetangles = self.asm.targetvalues["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"];

  if(exiting) {
    targetangles = (0, self.asm.targetvalues["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"][1], 0);
    targetpoint = getclosestpointonnavmesh(self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"]);

    if(distance2dsquared(targetpoint, self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"]) > 16384) {
      if(vehicle_common::function_ab1070f459e6ea5a(3)) {
        print3d(self.origin, "<dev string:xe0>", (1, 1, 1), 1, 0.3, 2000, 0);
        line(self.origin, targetpoint, (255, 165, 0), 1, 0, 2000);
        sphere(targetpoint, 5, (255, 165, 0), 0, 2000);
      }

      targetpoint = self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"];
    }

    contents = trace::create_solid_ai_contents(1);
    ignorelist = [];

    if(isDefined(self)) {
      ignorelist[ignorelist.size] = self;
    }

    if(isDefined(self._blackboard.currentvehicle)) {
      ignorelist[ignorelist.size] = self._blackboard.currentvehicle;
    }

    spherecaststart = targetpoint + (0, 0, 72);
    spherecastend = targetpoint + (0, 0, -1000);
    collisionresults = physics_spherecast(spherecaststart, spherecastend, 12, contents, ignorelist, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft");

    if(isDefined(collisionresults) && collisionresults.size > 0) {
      targetpoint = collisionresults[0]["\xc1\xbd\xdci\xe8i{7"];
    }

    self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", targetangles);

    if(getdvarint(@ "hash_516c8a0d29dad543", 0) == 1) {
      startpoint = self.asm.targetvalues["<dev string:x102>"];
      startangles = self.asm.targetvalues["<dev string:x111>"];
      startendpoint = startpoint + anglesToForward(startangles) * 5;
      line(startpoint, startendpoint, (0, 1, 0), 1, 0, 2000);
      sphere(startpoint, 1, (0, 1, 0), 0, 2000);
      line(targetpoint, self.origin, (0, 0, 1), 1, 0, 2000);
      sphere(targetpoint, 5, (0, 0, 1), 0, 2000);
      line(self.asm.targetvalues["<dev string:xbb>"], self.origin, (1, 0, 0), 1, 0, 2000);
      sphere(self.asm.targetvalues["<dev string:xbb>"], 5, (1, 0, 0), 0, 2000);
    }
  }

  if(vehicle_common::function_ab1070f459e6ea5a(3)) {
    sphere(targetpoint, 3, (0, 1, 0), 0, 300);
  }

  warpduration = (animendfrac - animstartfrac) * animlength;

  if(exiting) {
    self animmode("b\xf21\xbc\xeb{");
    utility::motionwarpwithnotetracks(xanim, targetpoint, targetangles, startnote, endnote, int(warpduration * 1000));
  } else {
    movedelta = getmovedelta(xanim, animstartfrac, animendfrac);
    angledelta = getangledelta3d(xanim, animstartfrac, animendfrac);
    startangle = targetangles - angledelta;
    startangle = angleclamp180(startangle);
    startpos = targetpoint - rotatevector(movedelta, startangle);
    self aisetanim(statename, animindex);
    self aisetanimtime(xanim, animstartfrac);
    self motionwarpwithanim(startpos, startangle, targetpoint, targetangles, int(warpduration * 1000));
  }

  wait warpduration;

  if(vehicle_common::function_ab1070f459e6ea5a(3)) {
    print3d(self.origin + (0, 0, 60), "<dev string:x120>", (1, 1, 1), 1, 0.3, 300);
    sphere(self.origin, 2, (1, 0, 0), 0, 300);
  }

  if(exiting) {
    if(!isDefined(self._blackboard)) {
      return;
    }

    endvehiclemotionwarp();
    self unlink();
    self._blackboard.linkedtovehicle = 0;
    self animmode("\x1b\x9e\x86\xecr\x97\xa2");
    return;
  }

  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));

  if(!(isDefined(self._blackboard) && isDefined(self))) {
    return;
  }

  if(!istrue(self._blackboard.linkedtovehicle)) {
    linktovehicle(self.origin, self.angles, self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag);
  }
}

function playanim_entervehicle(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  setvehiclearchetype();
  self.customarrivalangles = undefined;
  self._blackboard.startedenteringvehicle = 1;
  animindex = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animindex);
  assert(isDefined(xanim), "<dev string:x133>" + self._blackboard.chosenvehicleanimpos_seatalias + "<dev string:x149>" + self._blackboard.currentvehicleanimalias + "<dev string:x15b>" + statename + "<dev string:x16a>" + self.classname + "<dev string:x173>");
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);
    animindexidle = asm::asm_getanim(asmname, "j\x16\xef\x0f6\xf0x]\xda\xc5\xbc\xb2");
    xanimidle = asm::asm_getxanim("j\x16\xef\x0f6\xf0x]\xda\xc5\xbc\xb2", animindexidle);
    thread enterexitvehiclemotionwarp(asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 0, undefined);
  }
}

function entervehicle_terminate(asmname, statename, params) {
  clearvehiclearchetype();

  if(isalive(self)) {
    if(!istrue(self._blackboard.linkedtovehicle) && isalive(self._blackboard.currentvehicle)) {
      linktovehicle(self.asm.targetvalues["H\x18\xa0\x85\x7f\xeb\xe1\x83[L\x93\xd6"], self.asm.targetvalues["U\x88\xd7n\xfd(\xcf\xf7cu\xe9k"], self._blackboard.chosenvehicleanimpos_linktoblend, self._blackboard.chosenvehicleanimpos_sittag);
      self.asm.targetvalues = undefined;
    }

    if(isalive(self._blackboard.currentvehicle)) {
      self._blackboard.enteredvehicle = 1;
    }
  } else {
    setvehiclearchetype();
    xanim = asm::asm_getxanim(statename, self._blackboard.chosenvehicleanimpos_seatalias);
    animtime = self aigetanimtime(statename, self._blackboard.chosenvehicleanimpos_seatalias);
    animlength = getanimlength(xanim);
    transitiontime = getnotetracktimes(xanim, "\xc9\x8e.\xcd\xf0F\x1a~\x91\xdb2\x9b\xe0\xd7\xb8c\xd5\xfb\xc0L\x02\b")[0];

    if(isDefined(transitiontime)) {
      if(animtime < transitiontime) {
        self.diedintransition = 1;
      } else {
        self._blackboard.vehicledeathwait = (1 - animtime) * animlength;
        self._blackboard.var_f7de4e717d02bfb7 = animtime;
        self._blackboard.var_29ef821cdef9008d = statename;
        self.var_e7f149c86d7792f = 1;
      }
    } else {
      self.diedintransition = 1;
    }
  }

  self motionwarpcancel();
}

function exitvehiclewatchpath(statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    if(isDefined(self.pathgoalpos)) {
      endvehiclemotionwarp();
      self animmode("\x1b\x9e\x86\xecr\x97\xa2");
      self orientmode("\xa1\xd7\x97\xd7\xf4h\xe0%\xbe \xa1");
      return;
    }

    waitframe();
  }
}

function drawdeathnotetracks(xanim) {
  waittime = getnotetracktimes(xanim, "<dev string:x19e>")[0];
  ragdolltime = getnotetracktimes(xanim, "<dev string:x1b4>")[0];

  if(isDefined(waittime) && isDefined(ragdolltime)) {
    animlength = getanimlength(xanim);
    wait waittime * animlength;
    endtime = gettime() + (ragdolltime - waittime) * animlength * 1000;

    while(isDefined(self) && isalive(self) && gettime() < endtime) {
      sphere(self.origin + (0, 0, 60), 4, (1, 0, 0), 0, 1);
      waitframe();
    }
  }
}

function playanim_exitvehicle(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self setdefaultaimlimits();
  self.requestopendoor = 1;
  self.requestopendoorparams = params;
  self.allowpain = 1;

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.chosenvehicleanimpos_getoutanim)) {
      anim_name = self._blackboard.chosenvehicleanimpos_getoutanim;
      self._blackboard.currentvehicle function_1a874f32739758b5(anim_name);
    }
  }

  utility::set_movement_speed(60);
  self aisettargetspeed(60);
  self.exitvehicle_oldturnrate = self.turnrate;
  self.turnrate = 0.3;
  setvehiclearchetype();
  animindex = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animindex);
  assert(isDefined(xanim), "<dev string:x133>" + self._blackboard.chosenvehicleanimpos_seatalias + "<dev string:x149>" + self._blackboard.currentvehicleanimalias + "<dev string:x15b>" + statename + "<dev string:x16a>" + self.classname + "<dev string:x173>");
  self._blackboard.exitvehicleanimindex = animindex;

  if(getdvarint(@ "hash_89424474a6dbe389", 0) == 1) {
    thread drawdeathnotetracks(xanim);
  }

  if(isDefined(self._blackboard.currentvehicle)) {
    thread enterexitvehiclemotionwarp(asmname, statename, xanim, self._blackboard.chosenvehicleanimpos_sittag, 1, undefined);
  }

  self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
  self aisetanim(statename, animindex);
  endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename), undefined, undefined, 0);

  if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
    thread exitvehiclewatchpath(statename);
    asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename), undefined, undefined, 0);
  }

  asm::asm_fireevent(asmname, "8\xdb\x90");
}

function endvehiclemotionwarp() {
  self notify("&.\xf8(rq\x18ch\x1d\xe3\"\r\xe4\xee\r4l\xd8L");
  self.asm.targetvalues = undefined;
  self motionwarpcancel();
}

function exitvehicle_terminate(asmname, statename, params) {
  self._blackboard.invehicle = 0;
  utility::clear_movement_speed();

  if(isDefined(self.exitvehicle_oldturnrate)) {
    self.turnrate = self.exitvehicle_oldturnrate;
    self.exitvehicle_oldturnrate = undefined;
  }

  if(!isalive(self) && !istrue(self._blackboard.chosenvehicleanimpos_deathragdoll)) {
    if(!isDefined(self._blackboard.exitvehicleanimindex)) {
      self._blackboard.exitvehicleanimindex = asm::asm_getanim(asmname, statename);
    }

    xanim = asm::asm_getxanim(statename, self._blackboard.exitvehicleanimindex);
    animtime = self aigetanimtime(statename, self._blackboard.exitvehicleanimindex);
    animlength = getanimlength(xanim);
    waittime = getnotetracktimes(xanim, "\t\xe0\x1bT\xfb\xc2\x16\xe1\x97\x15HYw\xe0p#7p")[0];
    ragdolltime = getnotetracktimes(xanim, "7w\xf93\x168\xb1L\xa6\x01\xfaL8\x8ej6\x8e\xa6X\xd9\xb7")[0];
    crashinghelicopter = isDefined(self._blackboard.currentvehicle) && !self._blackboard.currentvehicle function_b0176e9e85e2d9e9() && self._blackboard.currentvehicle ishelicopter() && self._blackboard.currentvehicle vehicle_is_crashing();

    if(isDefined(waittime) && isDefined(ragdolltime)) {
      if(animtime < waittime) {
        self._blackboard.invehicle = 1;
      } else if(animtime < ragdolltime) {
        if(crashinghelicopter) {
          self._blackboard.invehicle = 1;
        } else {
          self._blackboard.vehicledeathwait = (ragdolltime - animtime) * animlength;
          self._blackboard.var_f7de4e717d02bfb7 = animtime;
          self._blackboard.var_29ef821cdef9008d = statename;
        }
      }
    } else {
      self.diedintransition = 1;
      transitiontime = getnotetracktimes(xanim, "\xc9\x8e.\xcd\xf0F\x1a~\x91\xdb2\x9b\xe0\xd7\xb8c\xd5\xfb\xc0L\x02\b")[0];

      if(isDefined(transitiontime)) {
        if(animtime < transitiontime) {
          self._blackboard.vehicledeathwait = (transitiontime - animtime) * animlength;
          self._blackboard.var_f7de4e717d02bfb7 = animtime;
          self._blackboard.var_29ef821cdef9008d = statename;
        }
      }
    }
  } else if(!isalive(self)) {
    self.diedintransition = 1;

    if(!isDefined(self._blackboard.exitvehicleanimindex)) {
      self._blackboard.exitvehicleanimindex = asm::asm_getanim(asmname, statename);
    }

    xanim = asm::asm_getxanim(statename, self._blackboard.exitvehicleanimindex);
    animtime = self aigetanimtime(statename, self._blackboard.exitvehicleanimindex);
    animlength = getanimlength(xanim);
    transitiontime = getnotetracktimes(xanim, "\xc9\x8e.\xcd\xf0F\x1a~\x91\xdb2\x9b\xe0\xd7\xb8c\xd5\xfb\xc0L\x02\b")[0];

    if(isDefined(transitiontime)) {
      if(animtime < transitiontime) {
        self._blackboard.vehicledeathwait = (transitiontime - animtime) * animlength;
        self._blackboard.var_f7de4e717d02bfb7 = animtime;
        self._blackboard.var_29ef821cdef9008d = statename;
      }
    }
  } else if(istrue(self._blackboard.linkedtovehicle)) {
    endvehiclemotionwarp();
    self unlink();
    self._blackboard.linkedtovehicle = 0;
  }

  if(!isDefined(self._blackboard.vehicledeathwait)) {
    endvehiclemotionwarp();
    self._blackboard.exitvehicleanimindex = undefined;
  }

  self notify("\xb9\xd68)\xb1\x14\xa6\x01\t");
  self notify("\f\xd6\xa5d\xac[\xfa\x87\xb7\xc1<\x14\x0f\xf8");
  self._blackboard.exitingvehicle = 0;
  self.requestopendoor = undefined;
  self.requestopendoorparams = undefined;
  clearvehiclearchetype();
}

function function_35b8b67ebc50552(asmname, statename, params) {
  self._blackboard.var_e641aa3138ef776f = 0;

  if(isalive(self)) {
    self motionwarpcancel();
    vehicle = self._blackboard.currentvehicle;
    seatinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_4e0a8702bc5123de);
    linkoffset = (0, 0, 0);
    linkangles = (0, 0, 0);

    if(isDefined(seatinfo.linkoffset)) {
      linkoffset += seatinfo.linkoffset;
    }

    if(isDefined(seatinfo.linkangle)) {
      linkangles += seatinfo.linkangle;
    }

    if(self._blackboard.var_5e85b2aa669fe08d == 2) {
      linkangles += (0, 180, 0);
    } else if(self._blackboard.var_5e85b2aa669fe08d == 4) {
      linkangles += (0, 90, 0);
    } else if(self._blackboard.var_5e85b2aa669fe08d == 6) {
      linkangles += (0, -90, 0);
    }

    self linktomoveoffset(self._blackboard.currentvehicle, seatinfo.sittag, linkoffset, linkangles);
  }

  vehicletransition_terminate(asmname, statename, params);
}

function vehicletransition_terminate(asmname, statename, params) {
  if(!isalive(self)) {
    self motionwarpcancel();
    self.diedintransition = 1;
  }

  clearvehiclearchetype();
}

function watchvehicledeath() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(self isragdoll()) {
    return;
  }

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;

    while(true) {
      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(vehicle) || vehicle vehicle_code::vehicle_iscorpse()) {
        if(istrue(self.deleteonvehicledeath)) {
          self delete();
          return;
        }

        endvehiclemotionwarp();

        if(!istrue(level.var_26895ac24395a571)) {
          self startragdoll();
        }

        self.skipdeathcleanup = 0;
        self.vehicle_idling = 0;
        death::deathcleanup();
        return;
      }

      waitframe();
    }
  }
}

function playanim_vehicledeath(asmname, statename, params) {
  if(!isDefined(self)) {
    return;
  }

  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  setvehiclearchetype();

  if(!isagent(self)) {
    if(istrue(self.diedintransition) || isDefined(self.damagemod) && (self.damagemod == "\b\x89z\xc1\xf1\xd4I\xf3" || self.damagemod == "M\x81\xaf\xee\xc9\xcfD\xef\x91J")) {
      self.var_3c05680ac68db159 = (0, 0, 0);
    }

    death::handleburningtodeath();
    self.burningtodeath = 0;
    vehicleisdead = !isDefined(self._blackboard.currentvehicle) || self._blackboard.currentvehicle vehicle_code::vehicle_iscorpse();

    if(isDefined(self._blackboard.vehicledeathwait)) {
      if(!vehicleisdead) {
        xanimindices = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, self._blackboard.var_29ef821cdef9008d, self._blackboard.chosenvehicleanimpos_seatalias);

        if(xanimindices.size <= 0) {
          return;
        }

        index = xanimindices[0];
        xanim = animsetgetanimfromindex(self._blackboard.currentvehicleanimalias, self._blackboard.var_29ef821cdef9008d, index);
        self aisetanim(self._blackboard.var_29ef821cdef9008d, index, 1);
        self aisetanimtime(xanim, self._blackboard.var_f7de4e717d02bfb7);
        self animmode("b\xf21\xbc\xeb{");

        if(istrue(self.var_e7f149c86d7792f) && isDefined(self._blackboard.currentvehicle)) {
          utility::function_9341cd345c72bbf4(xanim, self._blackboard.currentvehicle, self._blackboard.chosenvehicleanimpos_sittag, (0, 0, 0), (0, 0, 0), self._blackboard.var_f7de4e717d02bfb7, 1);
        }

        thread watchvehicledeath();
        wait self._blackboard.vehicledeathwait;

        if(!isDefined(self)) {
          return;
        }

        self.var_3c05680ac68db159 = (0, 0, 0);
        self._blackboard.exitvehicleanimindex = undefined;
        self._blackboard.vehicledeathwait = undefined;
      }

      endvehiclemotionwarp();
    }

    self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");
    var_481d1b3f34141e9a = undefined;
    self.noragdoll = 0;
    deathanimdata = death::getdeathanimdata(asmname, statename, params);
    assert(isDefined(deathanimdata) && deathanimdata.size == 2);
    notetracks = getnotetracks(deathanimdata[1], "\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");

    if(notetracks.size != 0) {
      var_481d1b3f34141e9a = 1;
    }

    shouldragdoll = vehicleisdead || istrue(self._blackboard.chosenvehicleanimpos_deathragdoll) || istrue(var_481d1b3f34141e9a) || istrue(self.diedintransition);
    var_104201c0699e1451 = !vehicleisdead && istrue(var_481d1b3f34141e9a);

    if(shouldragdoll) {
      self.skipdeathcleanup = 0;
      self.vehicle_idling = 0;

      if(istrue(self.diedintransition)) {
        self.nogravityragdoll = 1;
        self.ragdoll_immediate = 1;
        self.deathstate = "\xfb\x89\xce\xc1\xeb\x1d\"\fn\x8a\xf3*\xf4\x1bi\x8a\xf5\xb6\xef\xcc\xd4\n\xa0K";
        self.deathalias = "\x1e\xfd\xd1\xa2\a";
      } else if(var_104201c0699e1451) {
        self.nogravityragdoll = 1;
        self.ragdolltime = getanimlength(deathanimdata[1]) * notetracks[0]["\x92\xd3\x9f\xbb"];
      } else {
        self.ragdoll_immediate = 1;
      }
    } else {
      self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
      self.noragdoll = 1;
      thread watchvehicledeath();
    }
  } else {
    self motionwarpcancel();
    self orientmode("Y'\xe7\"\x1f\xc5<\x1e\xbc\xa8\xf2\xea\xd2aq\xff\x9f\xae\"");
  }

  death::playdeathanim(asmname, statename, params);
}

function playanim_vehicle(asmname, statename, params) {
  setvehiclearchetype();
  asm::asm_playanimstate(asmname, statename, params);
}

function function_fdd563dccc0a4e8f(asmname, statename, params) {
  setvehiclearchetype();
  self.useanimgoalweight = 1;
  asm::asm_playanimstate(asmname, statename, params);
}

function playanim_vehiclereload(asmname, statename, params) {
  self endon("\x17\xfb=\xc9 \x94\xae\xc8@;\xba\xe0\xc9'\xd8\x92");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  setvehiclearchetype();
  animid = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  xanim = asm::asm_getxanim(statename, animid);
  assert(animhasnotetrack(xanim, "<dev string:x1cd>") || animhasnotetrack(xanim, "<dev string:x1dc>"));
  asm::asm_playfacialanim(asmname, statename, xanim);
  asm::asm_donotetracks(asmname, statename, undefined, undefined, undefined, 1);
}

function function_dc3b7eca5bf0d77e(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self endon("\x1e\xfd\xd1\xa2\a");
  setvehiclearchetype();
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard.var_70902d09f32053a7;
  aianims = vehicle_aianim::anim_pos(vehicle, position);
  melee::playmeleeattacksound();
  target = asm_bb::bb_getmeleetarget();

  if(!isDefined(target)) {
    self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  } else if(target == self.enemy) {
    self orientmode("A\x14N5f\xcd6t\x04\xe6");
  } else {
    self orientmode("\xfc\x9f\\\x9e\x16\xbc\xbe\xca\xed\x12", target.origin);
  }

  asm::asm_fireephemeralevent("\xc3\xd8\x90\x94.;\xa3YY\xa3B2", "\x98\xcav-7");
  self aisetanim(statename, asm::asm_getanim(asmname, statename));
  melee::donotetracks_vsplayer(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  asm::asm_fireevent(asmname, "8\xdb\x90");
}

function vehiclereload_terminate(asmname, statename, params) {
  namespace_ad29b7c653247c74::reload_cleanup(asmname, statename, params);
  clearvehiclearchetype();
}

function isvehicledead(asmname, statename, tostatename, params) {
  return !isalive(self._blackboard.currentvehicle);
}

function isnotinvehicle() {
  return !self._blackboard.invehicle;
}

function function_48591a60510e90b7(asmname, statename, tostatename, params) {
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard.var_70902d09f32053a7;
  aianims = vehicle_aianim::anim_pos(vehicle, position);

  if(!isDefined(aianims) || !istrue(aianims.var_a550acf93590c008)) {
    return false;
  }

  if(self function_52c583f0c5368ad7()) {
    return true;
  }

  return false;
}

function function_7a974ea9979431a5(asmname, statename, tostatename, params) {
  if(isDefined(self._blackboard.vehicledir)) {
    return (self._blackboard.vehicledir == 0 || self._blackboard.vehicledir == 8);
  }

  return true;
}

function function_20c1c04f1a41a404(asmname, statename, params) {
  alias = self._blackboard.chosenvehicleanimpos_seatalias;
  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard.var_70902d09f32053a7;
  aianims = vehicle_aianim::anim_pos(vehicle, position);
  currentdir = self._blackboard.vehicledir;
  alias += "w" + utility::string(self._blackboard.vehicledir);

  if(currentdir == 2) {
    alias += "\xaf:\xab9s\xf5\x8c";
  } else if(currentdir == 4) {
    alias += "\xf5:WN\xb9\xfal";
  } else {
    alias += "?\x1e\xd9-]\x02\xb2";
  }

  return asm::asm_lookupanimfromalias("\x9d\xc2\te\xad\xdb6\xa4 \xe1V\x10\xfc\xa2\xb6s\xe5\xe0u\"\x13\x014\xecQ \xf7\xda\xa4\xd5", alias);
}

function function_a260d83e59322adf(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  setvehiclearchetype();
  self.useanimgoalweight = 1;
  animid = asm::asm_getanim(asmname, statename);
  turnanimstatename = "\x9d\xc2\te\xad\xdb6\xa4 \xe1V\x10\xfc\xa2\xb6s\xe5\xe0u\"\x13\x014\xecQ \xf7\xda\xa4\xd5";
  self aisetanim(turnanimstatename, animid);
  asm::asm_playfacialanim(asmname, turnanimstatename, asm::asm_getxanim(turnanimstatename, animid));
  endnote = asm::asm_donotetracks(asmname, turnanimstatename, asm::asm_getnotehandler(asmname, turnanimstatename));

  if(endnote == "f\x97\xb9`\xd1~\x80(\xca") {
    endnote = asm::asm_donotetracks(asmname, turnanimstatename, asm::asm_getnotehandler(asmname, turnanimstatename));
  }
}

function vehicleshouldstophide(asmname, statename, tostatename, params) {
  if(!self issuppressed() && isDefined(self.vehicleusesuppression) && self.vehicleusesuppression) {
    return 1;
  }

  return gettime() > self._blackboard.vehiclehidetime;
}

function function_459f11312cf1a7ea(asmname, statename, tostatename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);
  }

  animresult = archetypegetrandomalias(arcname, tostatename, alias, asm::asm_isfrantic());
  return isDefined(animresult);
}

function function_63fcf9743bc7c4be(asmname, statename, tostatename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;
    position = self._blackboard.var_70902d09f32053a7;
    aianims = vehicle_aianim::anim_pos(vehicle, position);
    alias += getpainalias(aianims);
  }

  animresult = archetypegetrandomalias(arcname, tostatename, alias, asm::asm_isfrantic());

  if(isDefined(animresult)) {
    return 1;
  }

  animresult = archetypegetrandomalias(arcname, tostatename, self._blackboard.chosenvehicleanimpos_seatalias, asm::asm_isfrantic());
  return isDefined(animresult);
}

function function_3de5fcf85f6f2db4(asmname, statename, tostatename, params) {
  arcname = self._blackboard.currentvehicleanimalias;
  alias = self._blackboard.chosenvehicleanimpos_seatalias;

  if(isDefined(self.vehicleseatonleft)) {
    switchsidesalias = function_4f2a3a6670010736();
    alias += switchsidesalias;
  }

  animresult = archetypegetrandomalias(arcname, tostatename, alias, asm::asm_isfrantic());
  return isDefined(animresult);
}

function vehicleshouldrunexit(asmname, statename, tostatename, params) {
  return istrue(self.vehiclerunexit);
}

function function_3fb5615f2dd12f14(asmname, statename, params) {
  setvehiclearchetype();
  vehicle = self._blackboard.currentvehicle;
  seatinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_4e0a8702bc5123de);
  animindex = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animindex);
  self aisetanim(statename, animindex);
  tagpos = vehicle gettagorigin(seatinfo.sittag);
  tagangle = vehicle gettagangles(seatinfo.sittag);

  if(isDefined(seatinfo.linkoffset)) {
    tagpos += rotatevector(seatinfo.linkoffset, self._blackboard.currentvehicle.angles);
  }

  if(isDefined(seatinfo.linkangle)) {
    tagangle += seatinfo.linkangle;
  }

  if(self._blackboard.var_5e85b2aa669fe08d == 2) {
    tagangle += (0, 180, 0);
  } else if(self._blackboard.var_5e85b2aa669fe08d == 4) {
    tagangle += (0, 90, 0);
  } else if(self._blackboard.var_5e85b2aa669fe08d == 6) {
    tagangle += (0, -90, 0);
  }

  tagangle = angleclamp180(tagangle);
  animlength = getanimlength(xanim);
  movedelta = getmovedelta(xanim, 0, 1);
  angledelta = getangledelta3d(xanim, 0, 1)[1];
  startangle = (tagangle[0], tagangle[1] - angledelta, tagangle[2]);
  startangle = angleclamp180(startangle);
  startpos = tagpos - rotatevector(movedelta, startangle);
  self motionwarpwithanim(startpos, startangle, tagpos, tagangle, int(animlength * 1000));

  if(vehicle_common::function_ab1070f459e6ea5a(4)) {
    sphere(startpos, 3, (0, 1, 1), 0, 300);
    sphere(tagpos, 3, (1, 0, 1), 0, 300);
  }

  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  self motionwarpcancel();
}

function vehiclegetoutcodemove(asmname, statename, tostatename, params) {
  if(asm::asm_eventfired(asmname, "f\x97\xb9`\xd1~\x80(\xca") && isDefined(self.pathgoalpos)) {
    return true;
  }

  return false;
}

function vehiclecollisionwatcher() {
  self endon("e\xacM1\x13\xc3\xb68&\xd6VRvI\x94\t=\xa4Hq\xb2\xce\xd6<6");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self._blackboard.currentvehicle)) {
    return;
  }

  self._blackboard.currentvehicle waittill("l\xdb\xb1c\x96sio\xb9", body0, body1, flag0, flag1, position, normal, impulse, ent);
  self.collision_data = spawnStruct();
  self.collision_data.position = position;
  self.collision_data.normal = normal;
  self.collision_data.impulse = impulse;
  forward = anglesToForward(self.angles);

  setdvarifuninitialized(@ "hash_e4eece17e1ee5b59", 0);
  displayinfo = getdvarint(@ "hash_e4eece17e1ee5b59");

  if(displayinfo) {
    line(position, position + normal * impulse * 1000, (0, 1, 0), 1, 0, 100);
    line(position, position + forward * 100, (1, 0, 0), 1, 0, 100);
    sphere(position, 20, (0, 1, 0), 0, 100);
  }
}

function function_8861c138d263eccc(asmname, statename, params) {
  thread vehiclecollisionwatcher();
}

function function_10332bf08c601c58() {
  if(isDefined(self.collision_data)) {
    self.collision_data = undefined;
  }
}

function function_be45c4ea281d2e51(asmname, statename, params) {
  self notify("e\xacM1\x13\xc3\xb68&\xd6VRvI\x94\t=\xa4Hq\xb2\xce\xd6<6");
}

function function_d9ab6e78fae083a9() {
  wait 0.5;
  setDvar(@ "ai_vehicletriggerimpulse", 0);
}

function function_4b9dcfb6accbe785(asmname, statename, tostatename, params) {
  if(!(isDefined(self._blackboard.currentvehicle) && isDefined(self._blackboard.var_70902d09f32053a7))) {
    return false;
  }

  vehicle = self._blackboard.currentvehicle;
  position = self._blackboard.var_70902d09f32053a7;
  aianims = vehicle_aianim::anim_pos(vehicle, position);

  setdvarifuninitialized(@ "ai_vehicletriggerimpulse", 0);
  triggerimpulse = getdvarint(@ "ai_vehicletriggerimpulse", 0);

  if(triggerimpulse) {
    self.collision_data = spawnStruct();
    self.collision_data.position = self.origin;
    self.collision_data.normal = (1, 0, 0);
    self.collision_data.impulse = 0.5;
    thread function_d9ab6e78fae083a9();
  }

  if(!isDefined(aianims) || !istrue(aianims.var_a550acf93590c008)) {
    return false;
  }

  if(!isDefined(self.collision_data) || !istrue(aianims.var_1661af1b2569aea9)) {
    return false;
  }

  return true;
}

function function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, message) {
  println("<dev string:x1eb>" + asmname + "<dev string:x23c>" + statename + "<dev string:x249>" + arc + "<dev string:x25a>");
  level.var_46441cab89b4da1b = 0;
  println("<dev string:x260>" + alias + "<dev string:x26e>" + xanim + "<dev string:x26e>" + message);
}

function function_e76bc3103ca0129d(asmname, statename, arc) {
  if(!archetypeassetloaded(arc)) {
    return;
  }

  aliases = archetypegetaliases(arc, statename);

  if(!isDefined(aliases)) {
    return;
  }

  foreach(alias in aliases) {
    organims = archetypegetalias(arc, statename, alias, 0);

    if(isarray(organims.anims)) {
      anims = organims.anims;
    } else {
      anims = [organims.anims];
    }

    foreach(xanim in anims) {
      waittime = getnotetracktimes(xanim, "<dev string:x19e>")[0];
      ragdolltime = getnotetracktimes(xanim, "<dev string:x1b4>")[0];
      var_a0a5241c78d46a35 = getnotetracktimes(xanim, "<dev string:xcb>");
      motionwarpendtimes = getnotetracktimes(xanim, "<dev string:x120>");
      codemovetimes = getnotetracktimes(xanim, "<dev string:x273>");
      finishtimes = getnotetracktimes(xanim, "<dev string:x280>");

      if(isDefined(var_a0a5241c78d46a35) && var_a0a5241c78d46a35.size > 1) {
        function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x28a>");
      }

      if(isDefined(motionwarpendtimes) && motionwarpendtimes.size > 1) {
        function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x2c4>");
      }

      if(isDefined(var_a0a5241c78d46a35) && var_a0a5241c78d46a35.size > 0 && isDefined(motionwarpendtimes) && motionwarpendtimes.size > 0) {
        if(var_a0a5241c78d46a35[0] >= motionwarpendtimes[0]) {
          function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x2fc>");
        }

        if(isDefined(finishtimes)) {
          if(finishtimes.size > 0 && var_a0a5241c78d46a35[0] > finishtimes[0]) {
            function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x335>");
          }

          if(finishtimes.size > 0 && motionwarpendtimes[0] > finishtimes[0]) {
            function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x365>");
          }
        }

        if(isDefined(codemovetimes)) {
          if(codemovetimes.size > 0 && var_a0a5241c78d46a35[0] > codemovetimes[0]) {
            function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x3aa>");
          }

          if(codemovetimes.size > 0 && motionwarpendtimes[0] > codemovetimes[0]) {
            function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x3dd>");
          }
        }

        totalmovedelta = getmovedelta(xanim, 0, 1);
        motionwarpmovedelta = getmovedelta(xanim, var_a0a5241c78d46a35[0], motionwarpendtimes[0]);

        if(abs(motionwarpmovedelta[2]) < abs(totalmovedelta[2]) * 0.5) {
          function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x40e>");
        }
      }

      if(isDefined(waittime) && !isDefined(ragdolltime)) {
        function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x451>");
      }

      if(!isDefined(waittime) && isDefined(ragdolltime)) {
        function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x496>");
      }

      if(isDefined(waittime) && isDefined(ragdolltime) && waittime >= ragdolltime) {
        function_d9784e6256ef3a60(asmname, statename, arc, alias, xanim, "<dev string:x4db>");
      }
    }
  }
}

function function_9493580c1d647517(asmname, statename, params) {
  if(isagent(self)) {
    return;
  }

  archetypes = ["<dev string:x517>", "<dev string:x51e>", "<dev string:x529>", "<dev string:x532>", "<dev string:x542>", "<dev string:x54b>", "<dev string:x558>", "<dev string:x56c>", "<dev string:x576>", "<dev string:x583>", "<dev string:x596>", "<dev string:x5a1>", "<dev string:x5aa>", "<dev string:x5bd>", "<dev string:x5cf>", "<dev string:x5d8>", "<dev string:x5e2>", "<dev string:x5eb>", "<dev string:x5f5>", "<dev string:x5fe>"];

  foreach(arc in archetypes) {
    function_e76bc3103ca0129d(asmname, statename, arc);
  }
}

# /