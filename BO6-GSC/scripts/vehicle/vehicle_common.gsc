/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\vehicle\vehicle_common.gsc
**********************************************/

#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_collision;
#using scripts\engine\utility;
#namespace vehicle_common;

function requestentervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos) {
  self._blackboard.var_cc2bc3c7a5a9a60c = vehicle;
  self._blackboard.var_75ac653affbae238 = spawninvehicle;
  self._blackboard.chosenvehiclelocation = chosenvehicleposition.origin;
  self._blackboard.chosenvehicleangles = chosenvehicleposition.angles;
  self._blackboard.var_25799974c1f2939b = chosenvehicleposition.vehicle_position;
  self._blackboard.var_fef1650fd4ff6f6 = istrue(chosenvehicleposition.canshootinvehicle);
  self._blackboard.currentvehicleanimalias = vehicle.vehicleanimalias;
  self._blackboard.chosenvehicleanimpos_sittag = chosenvehicleanimpos.sittag;

  if(isDefined(chosenvehicleanimpos.seataliasoverride) && chosenvehicleanimpos.seataliasoverride != "") {
    self._blackboard.chosenvehicleanimpos_seatalias = chosenvehicleanimpos.seataliasoverride;
  } else {
    self._blackboard.chosenvehicleanimpos_seatalias = string(self._blackboard.var_25799974c1f2939b);
  }

  self._blackboard.chosenvehicleanimpos_linktoblend = istrue(chosenvehicleanimpos.linktoblend);

  if(isDefined(chosenvehicleanimpos.fastroperig)) {
    self._blackboard.chosenvehicleanimpos_fastroperig = chosenvehicleanimpos.fastroperig;
  }

  self._blackboard.canchangeseats = istrue(chosenvehicleanimpos.var_9398f3113dced1d0);

  if(isDefined(chosenvehicleanimpos.vehicle_getoutanim)) {
    self._blackboard.chosenvehicleanimpos_getoutanim = getanimname(chosenvehicleanimpos.vehicle_getoutanim);
  } else {
    self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
  }

  self._blackboard.chosenvehicleanimpos_deathragdoll = istrue(chosenvehicleanimpos.deathragdoll);
  self._blackboard.chosenvehicleanimpos_deathimpulse = istrue(chosenvehicleanimpos.deathimpulse);
  self._blackboard.vehiclerequested = 1;
  seatinfo = vehicle_aianim::anim_pos(vehicle, chosenvehicleposition.vehicle_position);
  function_3cf475131c534031(seatinfo);
}

function function_f6cae8cbbd08eb08(seatinfo) {
  if(seatinfo.do_not_unload) {
    self._blackboard.var_f6cae8cbbd08eb08 = 0;
    return;
  }

  self._blackboard.var_f6cae8cbbd08eb08 = 1;
}

function function_3cf475131c534031(seatinfo) {
  if(seatinfo.var_14f441f730dc229d) {
    self.var_d2ea0f73eb94d74c = 1;
    return;
  }

  self.var_d2ea0f73eb94d74c = 0;
}

function function_134a8f5d5a23d3cb() {
  if(isDefined(self._blackboard.currentvehicle)) {
    self._blackboard.currentvehicle.usedpositions[self._blackboard.var_25799974c1f2939b] = 0;
    self._blackboard.var_25799974c1f2939b = self._blackboard.var_84de977d30197688;
    self._blackboard.currentvehicle.usedpositions[self._blackboard.var_84de977d30197688] = 1;
    self._blackboard.var_3b97675e43c4276d = 0;
    self._blackboard.currentvehicle.var_2c1b14ee4b7cd97c[self._blackboard.var_84de977d30197688] = 0;
    self.exitposition = self._blackboard.var_84de977d30197688;
    vehicleanimpos = vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard.var_25799974c1f2939b);
    self._blackboard.chosenvehicleanimpos_sittag = vehicleanimpos.sittag;

    if(isDefined(vehicleanimpos.seataliasoverride) && vehicleanimpos.seataliasoverride != "") {
      self._blackboard.chosenvehicleanimpos_seatalias = vehicleanimpos.seataliasoverride;
    } else {
      self._blackboard.chosenvehicleanimpos_seatalias = string(self._blackboard.var_25799974c1f2939b);
    }

    self._blackboard.chosenvehicleanimpos_linktoblend = istrue(vehicleanimpos.linktoblend);
    self._blackboard.chosenvehicleanimpos_fastroperig = vehicleanimpos.fastroperig;
    self._blackboard.var_fef1650fd4ff6f6 = istrue(vehicleanimpos.canshootinvehicle);
    self._blackboard.canchangeseats = istrue(vehicleanimpos.var_9398f3113dced1d0);

    if(isDefined(vehicleanimpos.vehicle_getoutanim)) {
      self._blackboard.chosenvehicleanimpos_getoutanim = getanimname(vehicleanimpos.vehicle_getoutanim);
    } else {
      self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
    }

    self._blackboard.chosenvehicleanimpos_deathragdoll = istrue(vehicleanimpos.deathragdoll);
    self._blackboard.chosenvehicleanimpos_deathimpulse = istrue(vehicleanimpos.deathimpulse);
    function_3cf475131c534031(vehicleanimpos);
    function_f6cae8cbbd08eb08(vehicleanimpos);
  }
}

function private get_velocity(vehicle, lastcollision) {
  if(!isDefined(vehicle) || !isent(vehicle) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static()) {
    return (0, 0, 0);
  }

  if(isDefined(vehicle.velocity)) {
    return vehicle.velocity;
  }

  if(lastcollision) {
    return vehicle function_19e2beab469c788e();
  }

  return vehicle vehicle_getvelocity();
}

function vehiclecollisionwatcher() {
  self endon("EndVehicleCollisionThread");
  self endon("death");
  self endon("long_death");

  while(true) {
    if(!isDefined(self._blackboard.currentvehicle)) {
      return;
    }

    self._blackboard.currentvehicle waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);
    var_4528dc04bda9ec95 = get_velocity(self, 1);
    var_4cdc7c696999f528 = get_velocity(ent, 1);
    waitframe();
    var_366bdf70365083e6 = get_velocity(self);
    var_244de96e6b3df4ed = get_velocity(ent);
    impulse = length(var_366bdf70365083e6 - var_4528dc04bda9ec95) + length(var_4cdc7c696999f528 - var_244de96e6b3df4ed);

    if(self asmeventfired(self.asmname, "allow_reimpulse")) {
      self.canreimpulse = 1;
    } else {
      self.canreimpulse = 0;
    }

    self.collision_data = spawnStruct();
    self.collision_data.position = position;
    self.collision_data.normal = normal;
    self.collision_data.impulse = impulse;

    setdvarifuninitialized(@ "hash_e4eece17e1ee5b59", 0);
    displayinfo = getdvarint(@ "hash_e4eece17e1ee5b59");

    if(displayinfo) {
      forward = anglesToForward(self.angles);
      line(position, position + normal * impulse * 1000, (0, 1, 0), 1, 0, 100);
      line(position, position + forward * 100, (1, 0, 0), 1, 0, 100);
      sphere(position, 20, (0, 1, 0), 0, 100);
    }

    waitframe();
  }
}

function waitforentervehicle() {
  msg = utility::waittill_any_return("entervehicle", "death", "long_death", "failedentervehicle");

  if(msg != "entervehicle") {
    return false;
  }

  self allowvehiclepredictiveragdoll(0);
  self._blackboard.vehiclerequested = 0;
  self._blackboard.currentvehicle.usedpositions[self._blackboard.var_25799974c1f2939b] = 1;
  vehicledata = vehicle::get_data(self._blackboard.currentvehicle vehicle::get_ref());

  if(vehicledata.ai.sightconfigtemplate) {
    self.var_3a27d82916f53b40 = self getsightconfigtemplateoverride();
    self setsightconfigtemplateoverride(vehicledata.ai.sightconfigtemplate);
  }

  self._blackboard.currentvehicle thread function_4637bce4207a6a03(self);
  thread vehiclecollisionwatcher();

  thread function_fab5752ad344ba76();

  vehicleanimpos = vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard.var_25799974c1f2939b);
  function_f6cae8cbbd08eb08(vehicleanimpos);
  return true;
}

function waitforarrivedatvehicle() {
  self endon("death");
  self endon("long_death");

  while(self._blackboard.vehiclerequested || isDefined(self._blackboard.currentvehicle) && !self._blackboard.startedenteringvehicle && !self._blackboard.enteredvehicle && !self._blackboard.invehicle) {
    waitframe();
  }
}

function entervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos) {
  requestentervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos);
  return waitforentervehicle();
}

function requestexitvehicle() {
  self._blackboard.exitvehiclerequested = 1;
  self._blackboard.vehiclerequested = 0;
}

function waitforexitvehicle() {
  self endon("death");
  self endon("long_death");
  vehicle = self._blackboard.currentvehicle;

  while(!self._blackboard.hasexitedvehicle) {
    waitframe();
  }

  self notify("unloaded");
  self notify("EndVehicleCollisionThread");
  self allowvehiclepredictiveragdoll(1);
  self._blackboard.hasexitedvehicle = 0;
  vehicledata = vehicle::get_data(vehicle vehicle::get_ref());

  if(vehicledata.ai.sightconfigtemplate) {
    if(self.var_3a27d82916f53b40) {
      self setsightconfigtemplateoverride(self.var_3a27d82916f53b40);
      self.var_3a27d82916f53b40 = undefined;
    } else if(level.stealth.sightconfigtemplate) {
      self setsightconfigtemplateoverride(level.stealth.sightconfigtemplate);
    } else {
      self setsightconfigtemplateoverride(undefined);
    }
  }

  if(vehicle && vehicle vehicle::is_vehicle()) {
    vehicle.usedpositions[self._blackboard.var_25799974c1f2939b] = 0;
    thread vehicle_collision::function_e3bc60c772acd609(vehicle, self);
  }

  if(!ispointonnavmesh(self.origin, self)) {
    navpos = getclosestpointonnavmesh(self.origin, self);
    groundpos = getgroundposition(navpos, 16);
    self forceteleport(groundpos, self.angles);
  }
}

function exitvehicle() {
  requestexitvehicle();
  waitforexitvehicle();
}

function hasvehicle() {
  return isDefined(self._blackboard) && (self._blackboard.vehiclerequested || isDefined(self._blackboard.currentvehicle));
}

function setuprope() {
  self._blackboard.vehiclesetuprope = 1;
}

function cancelentervehicle() {
  self notify("stop_loading");
  self._blackboard.isrunningtovehicle = 0;
}

function getmaxriders(vehicledata) {
  if(!isDefined(vehicledata.ai) || !vehicledata.ai.supportsai) {
    return 0;
  }

  var_e8e10d49bc04a5b8 = 0;

  for(i = 0; i < vehicledata.aiseats.size; i++) {
    if(vehicledata.aiseats[i].var_60b6d3b20648a38f ?? 1) {
      var_e8e10d49bc04a5b8++;
    }
  }

  return var_e8e10d49bc04a5b8;
}

function function_953694d5d41fce58(var_77759608d2ca8592, var_2674264c094cd023) {
  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle)) {
    return false;
  }

  if(self._blackboard.var_25799974c1f2939b == var_77759608d2ca8592) {
    return true;
  }

  if(var_77759608d2ca8592 >= vehicle.usedpositions.size) {
    return false;
  }

  if(vehicle.usedpositions[var_77759608d2ca8592] || vehicle.var_2c1b14ee4b7cd97c[var_77759608d2ca8592]) {
    return false;
  }

  if(!isDefined(var_2674264c094cd023)) {
    var_2674264c094cd023 = -1;
  }

  seatinfo = vehicle_aianim::anim_pos(vehicle, var_77759608d2ca8592);
  self._blackboard.var_84de977d30197688 = var_77759608d2ca8592;
  self._blackboard.var_d26a80bcdfbf2fc1 = var_2674264c094cd023;

  if(isDefined(seatinfo.seataliasoverride) && seatinfo.seataliasoverride != "") {
    self._blackboard.var_357610f2b1b38df6 = seatinfo.seataliasoverride;
  } else {
    self._blackboard.var_357610f2b1b38df6 = string(var_77759608d2ca8592);
  }

  self._blackboard.var_3b97675e43c4276d = 1;
  return true;
}

function private function_4637bce4207a6a03(rider) {
  self endon("death");
  rider endon("unloaded");
  exitposition = rider._blackboard.var_25799974c1f2939b;

  while(isDefined(self) && isalive(rider)) {
    exitposition = rider._blackboard.var_25799974c1f2939b;
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  self.usedpositions[exitposition] = 0;
}

function function_1b2539f38f15adae(value) {
  if(getdvarint(@ "ai_debugentindex") == -1 || getdvarint(@ "ai_debugentindex") == self getentitynumber()) {
    if(getdvarint(@ "ai_debugvehicleinfo", 0) == value) {
      return 1;
    }
  }

  return 0;
}

function function_fab5752ad344ba76() {
  self endon("<dev string:x24>");
  debugtextsize = 0.3;

  while(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;

    if(function_1b2539f38f15adae(1)) {
      debugvehicleinfo = "<dev string:x2d>" + string(vehicle vehicle_code::get_vehicle_classname());
      var_336d1d20474a22fd = "<dev string:x3a>";

      if(isDefined(self._blackboard.var_25799974c1f2939b)) {
        var_336d1d20474a22fd += string(self._blackboard.var_25799974c1f2939b);
      }

      var_336d1d20474a22fd += "<dev string:x46>";

      if(isDefined(self._blackboard.chosenvehicleanimpos_seatalias)) {
        var_336d1d20474a22fd += self._blackboard.chosenvehicleanimpos_seatalias;
      }

      var_8678d89bf4d49fd3 = "<dev string:x52>";

      if(isDefined(self._blackboard.currentvehicleanimalias)) {
        var_8678d89bf4d49fd3 += string(self._blackboard.currentvehicleanimalias);
      }

      debugtaginfo = "<dev string:x5b>";

      if(isDefined(self._blackboard.chosenvehicleanimpos_sittag)) {
        debugtaginfo += string(self._blackboard.chosenvehicleanimpos_sittag);
      }

      print3d(self.origin + (0, 0, 69), debugvehicleinfo, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 66), var_336d1d20474a22fd, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 63), var_8678d89bf4d49fd3, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 60), debugtaginfo, (1, 1, 1), 1, debugtextsize);
      selffwd = anglesToForward(self.angles);
      utility::draw_arrow(self.origin, self.origin + selffwd * 20, (1, 1, 1));
      seattagorigin = vehicle gettagorigin(self._blackboard.chosenvehicleanimpos_sittag);
      seattagangles = vehicle gettagangles(self._blackboard.chosenvehicleanimpos_sittag);
      seattagfwd = anglesToForward(seattagangles);
      var_c5134ff1389727cf = (0, 0, 1);
      utility::draw_arrow(seattagorigin + var_c5134ff1389727cf, seattagorigin + seattagfwd * 15 + var_c5134ff1389727cf, (0.6, 0, 0.6));
      vehiclebundleinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_25799974c1f2939b);
      linkangle = (0, 0, 0);
      linkoffset = (0, 0, 0);

      if(isDefined(vehiclebundleinfo.linkangle)) {
        linkangle = vehiclebundleinfo.linkangle;
      }

      if(isDefined(vehiclebundleinfo.linkoffset)) {
        linkoffset = rotatevector(vehiclebundleinfo.linkoffset, vehicle.angles);
      }

      if(linkangle != (0, 0, 0) || linkoffset != (0, 0, 0)) {
        fwdlinkoffset = rotatevector(seattagfwd, linkangle);
        utility::draw_arrow(seattagorigin + linkoffset + var_c5134ff1389727cf, seattagorigin + linkoffset + var_c5134ff1389727cf + fwdlinkoffset * 15, (1, 0.2, 0.2));
      }
    } else if(function_1b2539f38f15adae(2)) {
      vehiclebundleinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_25799974c1f2939b);
      var_8cbe2e91dc58fc58 = "<dev string:x69>";

      if(vehiclebundleinfo.canshootinvehicle) {
        var_8cbe2e91dc58fc58 = "<dev string:x85>";
      }

      var_70611c8c7070b1eb = "<dev string:xa0>";

      if(vehiclebundleinfo.canmeleeinvehicle) {
        var_70611c8c7070b1eb = "<dev string:xbc>";
      }

      var_5c10d68fc649c4fe = "<dev string:xd7>";

      if(vehiclebundleinfo.deathragdoll) {
        var_5c10d68fc649c4fe = "<dev string:xee>";
      }

      var_a84e8f37a18faaff = "<dev string:x104>";

      if(vehiclebundleinfo.bhasgunwhileriding) {
        var_a84e8f37a18faaff = "<dev string:x120>";
      }

      var_6b2e9979e128dd5d = "<dev string:x13b>";

      if(vehiclebundleinfo.var_9398f3113dced1d0) {
        var_6b2e9979e128dd5d = "<dev string:x154>";
      }

      print3d(self.origin + (0, 0, 69), var_8cbe2e91dc58fc58, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 66), var_70611c8c7070b1eb, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 63), var_5c10d68fc649c4fe, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 60), var_a84e8f37a18faaff, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 57), var_6b2e9979e128dd5d, (1, 1, 1), 1, debugtextsize);
    } else if(function_1b2539f38f15adae(3)) {
      var_262ca37d18da7525 = isDefined(self.var_61ac0cadde089972) && isDefined(self.var_9f2be75059f33907) && gettime() >= self.var_9f2be75059f33907 && gettime() < self.var_61ac0cadde089972;
      debugtransitioninfo = "<dev string:x16c>";

      if(var_262ca37d18da7525) {
        debugtransitioninfo += "<dev string:x170>";
      }

      print3d(self.origin + (0, 0, 69), debugtransitioninfo, (1, 1, 1), 1, debugtextsize);
    } else if(function_1b2539f38f15adae(4)) {
      vehiclebundleinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_25799974c1f2939b);

      if(self._blackboard.var_3b97675e43c4276d) {
        var_58d71081bcb4e134 = "<dev string:x16c>";

        if(self._blackboard.var_d8b9e2ebdf7d6e95) {
          var_58d71081bcb4e134 = "<dev string:x185>";
        } else {
          var_58d71081bcb4e134 = "<dev string:x19b>";
        }

        toseatinfo = "<dev string:x1b8>" + string(self._blackboard.var_84de977d30197688);

        if(self._blackboard.var_d26a80bcdfbf2fc1 != -1) {
          toseatinfo += "<dev string:x1c2>" + string(self._blackboard.var_d26a80bcdfbf2fc1);
        }

        var_58d71081bcb4e134 += toseatinfo;
        print3d(self.origin + (0, 0, 69), var_58d71081bcb4e134, (1, 1, 1), 1, debugtextsize);
        toseatinfo = vehicle_aianim::anim_pos(vehicle, self._blackboard.var_84de977d30197688);
        var_799fa0288efb418c = vehicle gettagorigin(toseatinfo.sittag);

        if(isDefined(toseatinfo.linkoffset)) {
          var_799fa0288efb418c += rotatevector(toseatinfo.linkoffset, vehicle.angles);
        }

        sphere(self.origin, 2, (0, 0.2, 1), 0, 1);
        sphere(var_799fa0288efb418c, 2, (0, 0.2, 1), 0, 1);
        utility::draw_arrow(self.origin, var_799fa0288efb418c, (0, 0.2, 1));
      }
    }

    waitframe();
  }
}

# /