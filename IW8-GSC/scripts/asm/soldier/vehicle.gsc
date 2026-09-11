/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\vehicle.gsc
***********************************************/

function setvehiclearchetype(var0, var1, var2) {
  scripts\asm\shared\utility::setoverridearchetype("vehicle", self._blackboard.currentvehicleanimalias, 1);
}

function clearvehiclearchetype(var0, var1, var2) {
  scripts\asm\shared\utility::clearoverridearchetype("vehicle", 0, 1);
}

function chooseanim_vehicle(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position));
}

function shouldentervehicle(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.currentvehicle) && istrue(self._blackboard.movedtovehicle)) {
    return true;
  }

  return false;
}

function getvehicleanimtargetoriginandangles(var0, var1, var2, var3, var4) {
  var5 = [];

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(isDefined(var2)) {
    var6 = var0 gettagorigin(var2);
    var7 = var0 gettagangles(var2);
    var8 = getstartorigin(var6, var7, var1);
    var9 = getstartangles(var6, var7, var1);
    var10 = getmovedelta(var1, 0, var4);
    var11 = getangledelta3d(var1, 0, var4)[1];
    var5 = var8;
    var5 = var9;
    var5 = rotatevector(var10, var9) + var8;
    var5 = (var9[0], angleclamp(var9[1] + var11), var9[2]);
  } else {
    GscBinSkip0(0x2e, "startOrigin", self.origin);
  }

  return var5;
}

function linktovehicle(var0, var1, var2, var3) {
  self forceteleport(var0, var1);

  if(istrue(var2)) {
    self linktoblendtotag(self._blackboard.currentvehicle, var3, 0);
  } else {
    self linktomoveoffset(self._blackboard.currentvehicle, var3);
  }

  if(isagent(self)) {
    self playerlinkedoffsetenable();
  }

  self._blackboard.linkedtovehicle = 1;
}

function faceenemyincombat(var0, var1) {
  self endon(var1 + "_finished");

  for(;;) {
    var2 = istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && (!isDefined(self.canshootinvehicle) || istrue(self.canshootinvehicle));
    var3 = isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.currentvehicle.vehicledisableturningwhileshooting);
    var4 = isDefined(self.enemy) && (!(isPlayer(self.enemy) || isai(self.enemy)) || isalive(self.enemy));
    var5 = vehicleincombat(var0, var1, var1);

    if(var5 && var4 && var2 && var3) {
      var6 = anglestoaxis(self._blackboard.currentvehicle.angles);
      var7 = var6["forward"];
      var8 = var6["up"];
      var9 = scripts\engine\utility::getyaw(self.enemy.origin) - self._blackboard.currentvehicle.angles[1];
      var9 = angleclamp180(var9);
      var10 = rotatepointaroundvector(var8, var7, var9);
      var11 = axistoangles(var10, vectorcross(var10, var8), var8);
      self orientmode("face angle 3d", var11);
    } else {
      self orientmode("face current angles");
    }

    waitframe();
  }
}

function playanim_vehicleidle(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.leftaimlimit = 90;
  self.rightaimlimit = -90;
  setvehiclearchetype();

  if(!istrue(self._blackboard.linkedtovehicle) && isDefined(self._blackboard.currentvehicle)) {
    var3 = scripts\asm\asm::asm_getanim(var0, "vehicle_idle");
    var4 = scripts\asm\asm::asm_getxanim("vehicle_idle", var3);
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var4, self._blackboard.chosenvehicleanimpos.sittag, self._blackboard.chosenvehicleposition);
    linktovehicle(self.asm.targetvalues["targetOrigin"], self.asm.targetvalues["targetAngles"], self._blackboard.chosenvehicleanimpos.linktoblend, self._blackboard.chosenvehicleanimpos.sittag);
  }

  self animmode("nogravity");
  self orientmode("face current angles");
  thread faceenemyincombat(var0, var1);
  var5 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var5);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function waitforturn(var0, var1) {
  self endon(var1 + "_finished");

  if(isDefined(self._blackboard.chosenvehicleanimpos.sittag)) {
    self animmode("none");
    self orientmode("face angle", self._blackboard.chosenvehicleposition.angles[1]);

    while(abs(self.angles[1] - self._blackboard.chosenvehicleposition.angles[1]) > 5) {
      waitframe();
    }

    self motionwarp(self._blackboard.chosenvehicleposition.origin, self._blackboard.chosenvehicleposition.angles, 250);
    wait 0.25;
  }

  scripts\asm\asm::asm_fireevent(var0, "end");
}

function shouldorienttoentervehicle(var0, var1, var2, var3) {
  if(shouldentervehicle(var0, var1, var2, var3)) {
    if(abs(self._blackboard.chosenvehicleposition.angles[1] - self.angles[1]) > 3) {
      return true;
    }

    if(distance2d(self._blackboard.chosenvehicleposition.origin, self.origin) > 5) {
      return true;
    }
  }

  return false;
}

function shouldentervehicleearly(var0, var1, var2, var3) {
  if(shouldentervehicle(var0, var1, var2, var3) && !shouldorienttoentervehicle(var0, var1, var2, var3)) {
    return true;
  }

  return false;
}

function playanim_arriveatvehicle(var0, var1, var2) {
  self endon(var1 + "_finished");
  thread waitforturn(var0, var1);
  scripts\asm\asm::asm_loopanimstate(var0, var1, 1);
}

function arriveatvehicle_terminate(var0, var1, var2) {
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

function enterexitvehiclemotionwarp(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("EndVehicleMotionWarp");
  var5 = getanimlength(var1);
  var6 = getnotetracktimes(var1, "motion_warp_begin")[0];
  var7 = getnotetracktimes(var1, "motion_warp_end")[0];

  if(!isDefined(var6)) {
    var6 = 0;
  }

  if(!isDefined(var7)) {
    var7 = 1;
  }

  if(var3) {
    if(isDefined(self._blackboard.chosenvehicleanimpos.fastroperig)) {
      thread rotatetocurrentangles();
    } else {
      if(isDefined(var4)) {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var4, var2, self._blackboard.chosenvehicleposition, var7);
      } else {
        self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var1, var2, self._blackboard.chosenvehicleposition, var7);
      }

      self orientmode("face angle 3d", self.asm.targetvalues["startAngles"]);
    }
  }

  var8 = var5 * var6;
  wait var8;

  if(!isDefined(self.asm)) {
    return;
  }

  self notify("EndRotateToCurrentAngles");

  if(isDefined(var4)) {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var4, var2, self._blackboard.chosenvehicleposition, var7);
  } else {
    self.asm.targetvalues = getvehicleanimtargetoriginandangles(self._blackboard.currentvehicle, var1, var2, self._blackboard.chosenvehicleposition, var7);
  }

  var9 = self.asm.targetvalues["targetOrigin"];

  if(var3) {
    self.asm.targetvalues["targetAngles"] = (0, self.asm.targetvalues["targetAngles"][1], 0);
    var9 = getclosestpointonnavmesh(self.asm.targetvalues["targetOrigin"]);
    var10 = scripts\engine\trace::create_solid_ai_contents(1);
    var11 = [self, self._blackboard.currentvehicle];
    var12 = var9 + (0, 0, 64);
    var13 = var9 + (0, 0, -1000);
    var14 = physics_spherecast(var12, var13, 12, var10, var11, "physicsquery_closest");

    if(isDefined(var14) && var14.size > 0) {
      var9 = var14[0]["position"];
    }

    self orientmode("face angle 3d", self.asm.targetvalues["targetAngles"]);
  }

  var18 = (var7 - var6) * var5;
  self motionwarp(var9, self.asm.targetvalues["targetAngles"], int(var18 * 1000));

  if(var3) {
    wait var18;

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

function playanim_entervehicle(var0, var1, var2) {
  self endon(var1 + "_finished");
  setvehiclearchetype();
  self.asm.customdata.arrivalangles = undefined;
  self._blackboard.startedenteringvehicle = 1;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self animmode("nogravity");
  self orientmode("face current angles");

  if(isDefined(self._blackboard.currentvehicle)) {
    if(!istrue(self._blackboard.linkedtovehicle)) {
      linktovehicle(self.origin, self.angles, self._blackboard.chosenvehicleanimpos.linktoblend, self._blackboard.chosenvehicleanimpos.sittag);
    }

    var5 = scripts\asm\asm::asm_getanim(var0, "vehicle_idle");
    var6 = scripts\asm\asm::asm_getxanim("vehicle_idle", var5);
    thread enterexitvehiclemotionwarp(var1, var4, self._blackboard.chosenvehicleanimpos.sittag, 0, var6);
  }

  self aisetanim(var1, var3);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function entervehicle_terminate(var0, var1, var2) {
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

function shouldexitvehicle(var0, var1, var2, var3) {
  if(istrue(self._blackboard.exitingvehicle)) {
    return true;
  }

  return false;
}

function exitvehiclewatchpath(var0) {
  self endon(var0 + "_finished");

  for(;;) {
    if(isDefined(self.pathgoalpos)) {
      self animmode("normal");
      self orientmode("face motion");
      return;
    }

    waitframe();
  }
}

function playanim_exitvehicle(var0, var1, var2) {
  self endon(var1 + "_finished");
  self setdefaultaimlimits();
  self.requestopendoor = 1;
  self.requestopendoorparams = var2;
  scripts\engine\utility::set_movement_speed(60);
  self aisettargetspeed(60);
  self.exitvehicle_oldturnrate = self.turnrate;
  self.turnrate = 0.3;

  if(istrue(self._blackboard.chosenvehicleanimpos.death_no_ragdoll)) {
    self.noragdoll = undefined;
  }

  setvehiclearchetype();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self._blackboard.exitvehicleanimindex = var3;

  if(isDefined(self._blackboard.currentvehicle)) {
    if(isDefined(self._blackboard.chosenvehicleanimpos.exittag)) {
      thread enterexitvehiclemotionwarp(var1, var4, self._blackboard.chosenvehicleanimpos.exittag, 1, undefined);
    } else {
      thread enterexitvehiclemotionwarp(var1, var4, self._blackboard.chosenvehicleanimpos.sittag, 1, undefined);
    }
  }

  self animmode("nogravity");
  self aisetanim(var1, var3);
  var5 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), undefined, undefined, 0);

  if(var5 == "code_move") {
    thread exitvehiclewatchpath(var1);
    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), undefined, undefined, 0);
  }

  scripts\asm\asm::asm_fireevent(var0, "end");
}

function endvehiclemotionwarp() {
  self notify("EndVehicleMotionWarp");
  self.asm.targetvalues = undefined;
  self motionwarpcancel();
}

function exitvehicle_terminate(var0, var1, var2) {
  self._blackboard.invehicle = undefined;
  scripts\common\utility::clear_movement_speed();

  if(isDefined(self.exitvehicle_oldturnrate)) {
    self.turnrate = self.exitvehicle_oldturnrate;
    self.exitvehicle_oldturnrate = undefined;
  }

  if(!isalive(self) && !istrue(self._blackboard.chosenvehicleanimpos.vehicle_death_ragdoll)) {
    var3 = scripts\asm\asm::asm_getxanim(var1, self._blackboard.exitvehicleanimindex);
    var4 = self aigetanimtime(var1, self._blackboard.exitvehicleanimindex);
    var5 = getanimlength(var3);
    var6 = getnotetracktimes(var3, "vehicle_death_wait")[0];
    var7 = getnotetracktimes(var3, "vehicle_death_ragdoll")[0];
    var8 = self._blackboard.currentvehicle scripts\common\vehicle::ishelicopter() && self._blackboard.currentvehicle scripts\common\vehicle::vehicle_is_crashing();

    if(isDefined(var6) && isDefined(var7)) {
      if(var4 < var6) {
        self._blackboard.invehicle = 1;
      } else if(var4 < var7) {
        if(var8) {
          self._blackboard.invehicle = 1;
        } else {
          self._blackboard.vehicledeathwait = (var7 - var4) * var5;
          self._blackboard.vehicleexitanimtime = var4;
          self._blackboard.vehicleexitstatename = var1;
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
    var0 = self._blackboard.currentvehicle;

    for(;;) {
      if(!isDefined(self)) {
        return;
      }

      if(!isDefined(var0) || var0 scripts\common\vehicle_code::vehicle_iscorpse()) {
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

function playanim_vehicledeath(var0, var1, var2) {
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
      var3 = animsetgetallanimindicesforalias(self._blackboard.currentvehicleanimalias, self._blackboard.vehicleexitstatename, self._blackboard.exitvehicleanimindex);
      self aisetanim(self._blackboard.vehicleexitstatename, self._blackboard.exitvehicleanimindex, 1);
      self aisetanimtime(var3, self._blackboard.vehicleexitanimtime);
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

  scripts\asm\soldier\death::playdeathanim(var0, var1, var2);
}

function playanim_vehicle(var0, var1, var2) {
  setvehiclearchetype();
  scripts\asm\asm::asm_playanimstate(var0, var1, var2);
}

function playanim_vehiclereload(var0, var1, var2) {
  self endon("reload_terminate");
  self endon(var1 + "_finished");
  setvehiclearchetype();
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1, undefined, undefined, undefined, 1);
}

function vehiclereload_terminate(var0, var1, var2) {
  scripts\asm\soldier\script_funcs::reload_cleanup(var0, var1, var2);
  clearvehiclearchetype();
}

function isinvehicle(var0, var1, var2, var3) {
  return istrue(self._blackboard.invehicle);
}

function isnotinvehicle(var0, var1, var2, var3) {
  return !istrue(self._blackboard.invehicle);
}

function vehicleincombat(var0, var1, var2, var3) {
  if(weaponclass(self.weapon) == "rocketlauncher") {
    return false;
  }

  return scripts\asm\asm::asm_getdemeanor() == "combat";
}

function vehiclecanshoot(var0, var1, var2, var3) {
  return istrue(self._blackboard.chosenvehicleposition.canshootinvehicle) && vehiclehasalias(var0, var1, var2, var3) && (!isDefined(self.canshootinvehicle) || istrue(self.canshootinvehicle));
}

function vehiclecanshootlmg(var0, var1, var2, var3) {
  var4 = weaponclass(self.weapon);

  if(var4 == "mg") {
    return vehiclecanshoot(var0, var1, var2, var3);
  }

  return false;
}

function vehicleshouldhide(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_iswhizbyrequested()) {
    return 0;
  }

  scripts\asm\asm_bb::bb_requestwhizby(undefined);
  self._blackboard.vehiclehidetime = gettime() + randomintrange(1000, 3000);
  return vehiclehasalias(var0, var1, var2, var3);
}

function vehicleshouldstophide(var0, var1, var2, var3) {
  return gettime() > self._blackboard.vehiclehidetime;
}

function vehiclehasalias(var0, var1, var2, var3) {
  var4 = self._blackboard.currentvehicleanimalias;
  var5 = scripts\engine\utility::string(self._blackboard.chosenvehicleposition.vehicle_position);
  var6 = archetypegetrandomalias(var4, var2, var5, scripts\asm\asm::asm_isfrantic());
  return isDefined(var6);
}

function vehicleshouldrunexit(var0, var1, var2, var3) {
  return vehiclehasalias(var0, var1, var2, var3) && istrue(self.vehiclerunexit);
}

function vehicleshouldsetuprope(var0, var1, var2, var3) {
  if(istrue(self._blackboard.vehiclesetuprope)) {
    self._blackboard.vehiclesetuprope = undefined;
    return true;
  }

  return false;
}

function vehiclegetoutcodemove(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfired(var0, "code_move") && isDefined(self.pathgoalpos)) {
    return true;
  }

  return false;
}