/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\vehicle.gsc
***********************************************/

function setvehiclearchetype(var_0, var_1, var_2) {
  scripts\asm\shared\utility::setoverridearchetype("vehicle", self._blackboard.currentvehicleanimalias, 1);
}

function clearvehiclearchetype(var_0, var_1, var_2) {
  scripts\asm\shared\utility::clearoverridearchetype("vehicle", 0, 1);
}

function chooseanim_vehicle(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position));
}

function shouldentervehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.currentvehicle) && istrue(self._blackboard.movedtovehicle)) {
    return true;
  }

  return false;
}

function getvehicleanimtargetoriginandangles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(isDefined(var_2)) {
    var_6 = var_0 gettagorigin(var_2);
    var_7 = var_0 gettagangles(var_2);
    var_8 = getstartorigin(var_6, var_7, var_1);
    var_9 = getstartangles(var_6, var_7, var_1);
    var_10 = getmovedelta(var_1, 0, var_4);
    var_11 = getangledelta3d(var_1, 0, var_4)[1];
    var_5 = var_8;
    var_5 = var_9;
    var_5 = rotatevector(var_10, var_9) + var_8;
    var_5 = (var_9[0], angleclamp(var_9[1] + var_11), var_9[2]);
  } else {
    GscBinSkip0(0x2e, "startOrigin", self.origin);
  }

  return var_5;
}

function linktovehicle(var_0, var_1, var_2, var_3) {
  self forceteleport(var_0, var_1);

  if(istrue(var_2)) {
    self linktoblendtotag(self._blackboard.currentvehicle, var_3, 0);
  } else {
    self linktomoveoffset(self._blackboard.currentvehicle, var_3);
  }

  if(isagent(self)) {
    self playerlinkedoffsetenable();
  }

  self._blackboard.linkedtovehicle = 1;
}

function faceenemyincombat(var_0, var_1) {
  self endon(var_1 + "_finished");

  for(;;) {
    var_2 = istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && (!isDefined(self.canshootinvehicle) || istrue(self.canshootinvehicle));
    var_3 = isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.currentvehicle.vehicledisableturningwhileshooting);
    var_4 = isDefined(self.enemy) && (!(isPlayer(self.enemy) || isai(self.enemy)) || isalive(self.enemy));
    var_5 = vehicleincombat(var_0, var_1, var_1);

    if(var_5 && var_4 && var_2 && var_3) {
      var_6 = anglestoaxis(self._blackboard.currentvehicle.angles);
      var_7 = var_6["forward"];
      var_8 = var_6["up"];
      var_9 = scripts\engine\utility::getyaw(self.enemy.origin) - self._blackboard.currentvehicle.angles[1];
      var_9 = angleclamp180(var_9);
      var_10 = rotatepointaroundvector(var_8, var_7, var_9);
      var_11 = axistoangles(var_10, vectorcross(var_10, var_8), var_8);
      self orientmode("face angle 3d", var_11);
    } else {
      self orientmode("face current angles");
    }

    waitframe();
  }
}

function playanim_vehicleidle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.leftaimlimit = 90;
  self.rightaimlimit = -90;
  setvehiclearchetype();

  if(!istrue(self._blackboard.linkedtovehicle) && isDefined(self._blackboard.currentvehicle)) {
    var_3 = scripts\asm\asm::asm_getanim(var_0, "vehicle_idle");
    var_4 = scripts\asm\asm::asm_getxanim("vehicle_idle", var_3);
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var_4, self._blackboard.chosenvehicleanimpos.sittag, self._blackboard.chosenvehicleposition);
    linktovehicle(self.asm.targetvalues["targetOrigin"], self.asm.targetvalues["targetAngles"], self._blackboard.chosenvehicleanimpos.linktoblend, self._blackboard.chosenvehicleanimpos.sittag);
  }

  self animmode("nogravity");
  self orientmode("face current angles");
  thread faceenemyincombat(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_5);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

function waitforturn(var_0, var_1) {
  self endon(var_1 + "_finished");

  if(isDefined(self._blackboard.chosenvehicleanimpos.sittag)) {
    self animmode("none");
    self orientmode("face angle", self._blackboard.chosenvehicleposition.angles[1]);

    while(abs(self.angles[1] - self._blackboard.chosenvehicleposition.angles[1]) > 5) {
      waitframe();
    }

    self motionwarp(self._blackboard.chosenvehicleposition.origin, self._blackboard.chosenvehicleposition.angles, 250);
    wait 0.25;
  }

  scripts\asm\asm::asm_fireevent(var_0, "end");
}

function shouldorienttoentervehicle(var_0, var_1, var_2, var_3) {
  if(shouldentervehicle(var_0, var_1, var_2, var_3)) {
    if(abs(self._blackboard.chosenvehicleposition.angles[1] - self.angles[1]) > 3) {
      return true;
    }

    if(distance2d(self._blackboard.chosenvehicleposition.origin, self.origin) > 5) {
      return true;
    }
  }

  return false;
}

function shouldentervehicleearly(var_0, var_1, var_2, var_3) {
  if(shouldentervehicle(var_0, var_1, var_2, var_3) && !shouldorienttoentervehicle(var_0, var_1, var_2, var_3)) {
    return true;
  }

  return false;
}

function playanim_arriveatvehicle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  thread waitforturn(var_0, var_1);
  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
}

function arriveatvehicle_terminate(var_0, var_1, var_2) {
  self motionwarpcancel();
}

function rotatetocurrentangles() {
  self endon("death");
  self endon("EndVehicleMotionWarp");
  self endon("EndRotateToCurrentAngles");

  for(;;) {
    self orientmode("face angle 3d", self.angles);
    waitframe();
  }
}

function enterexitvehiclemotionwarp(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("EndVehicleMotionWarp");
  var_5 = getanimlength(var_1);
  var_6 = getnotetracktimes(var_1, "motion_warp_begin")[0];
  var_7 = getnotetracktimes(var_1, "motion_warp_end")[0];

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(var_3) {
    if(isDefined(self._blackboard.chosenvehicleanimpos.fastroperig)) {
      thread rotatetocurrentangles();
    } else {
      if(isDefined(var_4)) {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var_4, var_2, self._blackboard.chosenvehicleposition, var_7);
      } else {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var_1, var_2, self._blackboard.chosenvehicleposition, var_7);
      }

      self orientmode("face angle 3d", self.asm.targetvalues["startAngles"]);
    }
  }

  var_8 = var_5 * var_6;
  wait var_8;

  if(!isDefined(self.asm)) {
    return;
  }

  self notify("EndRotateToCurrentAngles");

  if(isDefined(var_4)) {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var_4, var_2, self._blackboard.chosenvehicleposition, var_7);
  } else {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var_1, var_2, self._blackboard.chosenvehicleposition, var_7);
  }

  var_9 = self.asm.targetvalues["targetOrigin"];

  if(var_3) {
    self.asm.targetvalues["targetAngles"] = (0, self.asm.targetvalues["targetAngles"][1], 0);
    var_9 = getclosestpointonnavmesh(self.asm.targetvalues["targetOrigin"]);
    var_10 = scripts\engine\trace::create_solid_ai_contents(1);
    var_11 = [self, self._blackboard.currentvehicle];
    var_12 = var_9 + (0, 0, 64);
    var_13 = var_9 + (0, 0, -1000);
    var_14 = physics_spherecast(var_12, var_13, 12, var_10, var_11, "physicsquery_closest");

    if(isDefined(var_14) && var_14.size > 0) {
      var_9 = var_14[0]["position"];
    }

    self orientmode("face angle 3d", self.asm.targetvalues["targetAngles"]);
  }

  var_18 = (var_7 - var_6) * var_5;
  self motionwarp(var_9, self.asm.targetvalues["targetAngles"], int(var_18 * 1000));

  if(var_3) {
    wait var_18;

    if(!isDefined(self._blackboard)) {
      return;
    }

    if(istrue(self._blackboard.linkedtovehicle)) {
      self unlink();
      self._blackboard.linkedtovehicle = undefined;
      self orientmode("face angle", self.asm.targetvalues["targetAngles"][1]);
      self animmode("gravity");
    }

    self notify("jumpedout");
    return;
  }
}

function playanim_entervehicle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  setvehiclearchetype();
  self.asm.customdata.arrivalangles = undefined;
  self._blackboard.startedenteringvehicle = 1;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self animmode("nogravity");
  self orientmode("face current angles");

  if(isDefined(self._blackboard.currentvehicle)) {
    if(!istrue(self._blackboard.linkedtovehicle)) {
      linktovehicle(self.origin, self.angles, self._blackboard.chosenvehicleanimpos.linktoblend, self._blackboard.chosenvehicleanimpos.sittag);
    }

    var_5 = scripts\asm\asm::asm_getanim(var_0, "vehicle_idle");
    var_6 = scripts\asm\asm::asm_getxanim("vehicle_idle", var_5);
    thread enterexitvehiclemotionwarp(var_1, var_4, self._blackboard.chosenvehicleanimpos.sittag, 0, var_6);
  }

  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

function entervehicle_terminate(var_0, var_1, var_2) {
  clearvehiclearchetype();

  if(isalive(self)) {
    if(!istrue(self._blackboard.linkedtovehicle) && isDefined(self._blackboard.currentvehicle)) {
      linktovehicle(self.asm.targetvalues["targetOrigin"], self.asm.targetvalues["targetAngles"]);
      self.asm.targetvalues = undefined;
    }

    self._blackboard.enteredvehicle = 1;
  }

  self motionwarpcancel();
}

function shouldexitvehicle(var_0, var_1, var_2, var_3) {
  if(istrue(self._blackboard.exitingvehicle)) {
    return true;
  }

  return false;
}

function exitvehiclewatchpath(var_0) {
  self endon(var_0 + "_finished");

  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      self animmode("normal");
      self orientmode("face motion");
      return;
    }

    waitframe();
  }
}

function playanim_exitvehicle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self setdefaultaimlimits();
  self.requestopendoor = 1;
  self.requestopendoorparams = var_2;
  scripts\engine\utility::set_movement_speed(60);
  self aisettargetspeed(60);
  self.exitvehicle_oldturnrate = self.turnrate;
  self.turnrate = 0.3;

  if(istrue(self._blackboard.chosenvehicleanimpos.death_no_ragdoll)) {
    self.noragdoll = undefined;
  }

  setvehiclearchetype();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self._blackboard.exitvehicleanimindex = var_3;

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.chosenvehicleanimpos.exittag)) {
      thread enterexitvehiclemotionwarp(var_1, var_4, self._blackboard.chosenvehicleanimpos.exittag, 1, undefined);
    } else {
      thread enterexitvehiclemotionwarp(var_1, var_4, self._blackboard.chosenvehicleanimpos.sittag, 1, undefined);
    }
  }

  self animmode("nogravity");
  self aisetanim(var_1, var_3);
  var_5 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), undefined, undefined, 0);

  if(var_5 == "code_move") {
    thread exitvehiclewatchpath(var_1);
    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(var_0, "end");
}

function endvehiclemotionwarp() {
  self notify("EndVehicleMotionWarp");
  self.asm.targetvalues = undefined;
  self motionwarpcancel();
}

function exitvehicle_terminate(var_0, var_1, var_2) {
  self._blackboard.invehicle = undefined;
  scripts\common\utility::clear_movement_speed();

  if(isDefined(self.exitvehicle_oldturnrate)) {
    self.turnrate = self.exitvehicle_oldturnrate;
    self.exitvehicle_oldturnrate = undefined;
  }

  if(!isalive(self) && !istrue(self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll)) {
    var_3 = scripts\asm\asm::asm_getxanim(var_1, self._blackboard.exitvehicleanimindex);
    var_4 = self aigetanimtime(var_1, self._blackboard.exitvehicleanimindex);
    var_5 = getanimlength(var_3);
    var_6 = getnotetracktimes(var_3, "vehicle_death_wait")[0];
    var_7 = getnotetracktimes(var_3, "vehicle_death_ragdoll")[0];
    var_8 = self._blackboard.currentvehicle scripts\common\vehicle::ishelicopter() && self._blackboard.currentvehicle scripts\common\vehicle::vehicle_is_crashing();

    if(isDefined(var_6) && isDefined(var_7)) {
      if(var_4 < var_6) {
        self._blackboard.invehicle = 1;
      } else if(var_4 < var_7) {
        if(var_8) {
          self._blackboard.invehicle = 1;
        } else {
          self._blackboard.vehicledeathwait = (var_7 - var_4) * var_5;
          self._blackboard.vehicleexitanimtime = var_4;
          self._blackboard.vehicleexitstatename = var_1;
        }
      }
    }
  } else if(istrue(self._blackboard.linkedtovehicle)) {
    self unlink();
    self._blackboard.linkedtovehicle = undefined;
    self notify("jumpedout");
  }

  if(!isDefined(self._blackboard.vehicledeathwait)) {
    endvehiclemotionwarp();
    self._blackboard.exitvehicleanimindex = undefined;
  }

  self._blackboard.exitingvehicle = undefined;
  self.requestopendoor = undefined;
  self.requestopendoorparams = undefined;
  clearvehiclearchetype();
}

function watchvehicledeath() {
  self endon("entitydeleted");

  if(self isragdoll()) {
    return;
  }

  if(isDefined(self._blackboard.currentvehicle)) {
    var_0 = self._blackboard.currentvehicle;

    for(;;) {
      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(var_0) || var_0 scripts\common\vehicle_code::vehicle_iscorpse()) {
        self startragdoll();
        self.skipdeathcleanup = 0;
        scripts\asm\soldier\death::deathcleanup();
        return;
      }

      waitframe();
    }

    return;
  }
}

function playanim_vehicledeath(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    return;
  }

  setvehiclearchetype();

  if(!isagent(self)) {
    if(isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
      self.ragdoll_directionscale = 0;
    }

    scripts\asm\soldier\death::handleburningtodeath();
    self.burningtodeath = undefined;

    if(isDefined(self._blackboard.vehicledeathwait)) {
      var_3 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, self._blackboard.vehicleexitstatename, self._blackboard.exitvehicleanimindex);
      self aisetanim(self._blackboard.vehicleexitstatename, self._blackboard.exitvehicleanimindex, 1);
      self aisetanimtime(var_3, self._blackboard.vehicleexitanimtime);
      self animmode("noclip");
      wait self._blackboard.vehicledeathwait;
      self.ragdoll_directionscale = 0;
      endvehiclemotionwarp();
      self._blackboard.exitvehicleanimindex = undefined;
      self._blackboard.vehicledeathwait = undefined;
    }

    self orientmode("face current angles");

    if(!istrue(self._blackboard.invehicle) || istrue(self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll)) {
      self.skipdeathcleanup = 0;
      self.forceragdollimmediate = 1;
      self.nogravityragdoll = 1;
    } else {
      self animmode("nogravity");
      self.noragdoll = 1;
      self.skipdeathcleanup = 1;
      thread watchvehicledeath();
    }
  } else {
    self motionwarpcancel();
    self orientmode("face current angles");
  }

  scripts\asm\soldier\death::playdeathanim(var_0, var_1, var_2);
}

function playanim_vehicle(var_0, var_1, var_2) {
  setvehiclearchetype();
  scripts\asm\asm::asm_playanimstate(var_0, var_1, var_2);
}

function playanim_vehiclereload(var_0, var_1, var_2) {
  self endon("reload_terminate");
  self endon(var_1 + "_finished");
  setvehiclearchetype();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, undefined, 1);
}

function vehiclereload_terminate(var_0, var_1, var_2) {
  scripts\asm\soldier\script_funcs::reload_cleanup(var_0, var_1, var_2);
  clearvehiclearchetype();
}

function isinvehicle(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.invehicle);
}

function isnotinvehicle(var_0, var_1, var_2, var_3) {
  return !istrue(self._blackboard.invehicle);
}

function vehicleincombat(var_0, var_1, var_2, var_3) {
  if(weaponclass(self.weapon) == "rocketlauncher") {
    return false;
  }

  return scripts\asm\asm::asm_getdemeanor() == "combat";
}

function vehiclecanshoot(var_0, var_1, var_2, var_3) {
  return istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && vehiclehasalias(var_0, var_1, var_2, var_3) && (!isDefined(self.canshootinvehicle) || istrue(self.canshootinvehicle));
}

function vehiclecanshootlmg(var_0, var_1, var_2, var_3) {
  var_4 = weaponclass(self.weapon);

  if(var_4 == "mg") {
    return vehiclecanshoot(var_0, var_1, var_2, var_3);
  }

  return false;
}

function vehicleshouldhide(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_iswhizbyrequested()) {
    return 0;
  }

  scripts\asm\asm_bb::bb_requestwhizby(undefined);
  self._blackboard.vehiclehidetime = gettime() + randomintrange(1000, 3000);
  return vehiclehasalias(var_0, var_1, var_2, var_3);
}

function vehicleshouldstophide(var_0, var_1, var_2, var_3) {
  return gettime() > self._blackboard.vehiclehidetime;
}

function vehiclehasalias(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.currentvehicleanimalias;
  var_5 = scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position);
  var_6 = archetypegetrandomalias(var_4, var_2, var_5, scripts\asm\asm::asm_isfrantic());
  return isDefined(var_6);
}

function vehicleshouldrunexit(var_0, var_1, var_2, var_3) {
  return vehiclehasalias(var_0, var_1, var_2, var_3) && istrue(self.vehiclerunexit);
}

function vehicleshouldsetuprope(var_0, var_1, var_2, var_3) {
  if(istrue(self._blackboard.vehiclesetuprope)) {
    self._blackboard.vehiclesetuprope = undefined;
    return true;
  }

  return false;
}

function vehiclegetoutcodemove(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "code_move") && isDefined(self.pathgoalpos)) {
    return true;
  }

  return false;
}