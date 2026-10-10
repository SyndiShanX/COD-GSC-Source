/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\vehicle\vehicle_common.gsc
*************************************************/

#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\engine\utility;
#namespace vehicle_common;

function requestentervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos) {
  self._blackboard.var_b5096603d1631c0b = vehicle;
  self._blackboard.var_83aebffe3c7883c9 = spawninvehicle;
  self._blackboard.var_d59400d26aee998e = chosenvehicleposition.origin;
  self._blackboard.var_a3111c437379d9e9 = chosenvehicleposition.angles;
  self._blackboard.var_9176cae5619d7fba = chosenvehicleposition.vehicle_position;
  self._blackboard.var_6a69fa6b0b354c93 = istrue(chosenvehicleposition.canshootinvehicle);
  self._blackboard.currentvehicleanimalias = vehicle.vehicleanimalias;
  self._blackboard.var_1745d2b69c72c627 = chosenvehicleanimpos.sittag;
  self._blackboard.var_f6d06d1e68f4f4e5 = istrue(chosenvehicleanimpos.linktoblend);
  self._blackboard.var_e5ec3a6afd92645d = chosenvehicleanimpos.fastroperig;

  if(isDefined(chosenvehicleanimpos.vehicle_getoutanim)) {
    self._blackboard.var_a43d8e6e8a225cd2 = getanimname(chosenvehicleanimpos.vehicle_getoutanim);
  } else {
    self._blackboard.var_a43d8e6e8a225cd2 = undefined;
  }

  self._blackboard.var_80912ec8ade08716 = istrue(chosenvehicleanimpos.deathragdoll);
  self._blackboard.var_41c9f8c7891f19da = istrue(chosenvehicleanimpos.deathimpulse);
  self._blackboard.vehiclerequested = 1;
}

function waitforentervehicle() {
  msg = waittill_any_return_4("entervehicle", "death", "long_death", "failedentervehicle");

  if(msg != "entervehicle") {
    return false;
  }

  self function_5847240c0f9900f2(0);
  self._blackboard.vehiclerequested = 0;

  thread function_9ec907df2fa3ceb7();

  return true;
}

function waitforarrivedatvehicle() {
  self endon("death");
  self endon("long_death");

  while(istrue(self._blackboard.vehiclerequested) || isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.startedenteringvehicle) && !istrue(self._blackboard.enteredvehicle) && !self._blackboard.invehicle) {
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

  while(!istrue(self._blackboard.hasexitedvehicle)) {
    waitframe();
  }

  self function_5847240c0f9900f2(1);
  self._blackboard.hasexitedvehicle = 0;
}

function exitvehicle() {
  requestexitvehicle();
  waitforexitvehicle();
}

function hasvehicle() {
  return istrue(self._blackboard.vehiclerequested) || isDefined(self._blackboard) && isDefined(self._blackboard.currentvehicle);
}

function setuprope() {
  self._blackboard.vehiclesetuprope = 1;
}

function function_b795d4c865a7bc7e() {
  model = self.vehiclemodel;

  if(model == "") {
    model = self.model;
  }

  if(issubstr(model, "::")) {
    model = strtok(model, "::")[1];
  }

  if(isDefined(level.vehicle.templates.husk[model]) && !istrue(self.var_b3f762a51e1ed52a)) {
    return true;
  }

  return false;
}

function cancelentervehicle() {
  self notify("stop_loading");
  self._blackboard.isrunningtovehicle = 0;
}

function function_ffd4bd7b834e69eb(var_1f37a785bba731e3) {
  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle)) {
    return false;
  }

  if(self._blackboard.var_9176cae5619d7fba == var_1f37a785bba731e3) {
    return true;
  }

  if(var_1f37a785bba731e3 >= vehicle.usedpositions.size) {
    return false;
  }

  if(vehicle.usedpositions[var_1f37a785bba731e3] == 1) {
    return false;
  }

  self._blackboard.var_e38c46be257216d3 = var_1f37a785bba731e3;
  thread function_b2841b0708f2b5d4();
  return true;
}

function function_b2841b0708f2b5d4() {
  self endon("death");
  self endon("long_death");
  self._blackboard.var_3769628964ac89c1 = 0;

  while(!self._blackboard.var_3769628964ac89c1) {
    waitframe();
  }

  self._blackboard.var_9176cae5619d7fba = self._blackboard.var_e38c46be257216d3;
  vehicleanims = scripts\common\vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard.var_9176cae5619d7fba);
  self._blackboard.var_1745d2b69c72c627 = vehicleanims.sittag;
  self._blackboard.var_f6d06d1e68f4f4e5 = istrue(vehicleanims.linktoblend);
  self._blackboard.var_e5ec3a6afd92645d = vehicleanims.fastroperig;

  if(isDefined(vehicleanims.vehicle_getoutanim)) {
    self._blackboard.var_a43d8e6e8a225cd2 = getanimname(vehicleanims.vehicle_getoutanim);
  } else {
    self._blackboard.var_a43d8e6e8a225cd2 = undefined;
  }

  self._blackboard.var_80912ec8ade08716 = istrue(vehicleanims.deathragdoll);
  self._blackboard.var_41c9f8c7891f19da = istrue(vehicleanims.deathimpulse);
  self._blackboard.var_e38c46be257216d3 = undefined;
}

function function_745ac044fcee731b(value) {
  if(getdvarint(@ "ai_debugentindex") == -1 || getdvarint(@ "ai_debugentindex") == self getentitynumber()) {
    if(getdvarint(@ "hash_3a76c9f686d280fc", 0) == value) {
      return 1;
    }
  }

  return 0;
}

function function_9ec907df2fa3ceb7() {
  self endon("<dev string:x1c>");
  debugtextsize = 0.3;

  while(isDefined(self._blackboard.currentvehicle)) {
    vehicle = self._blackboard.currentvehicle;

    if(function_745ac044fcee731b(1)) {
      var_4931d79784405058 = "<dev string:x22>" + string(vehicle scripts\common\vehicle_code::get_vehicle_classname());
      var_93f33954046fbb10 = "<dev string:x2c>";

      if(isDefined(self._blackboard.var_9176cae5619d7fba)) {
        var_93f33954046fbb10 += string(self._blackboard.var_9176cae5619d7fba);
      }

      var_16614ab5a07da138 = "<dev string:x35>";

      if(isDefined(self._blackboard.currentvehicleanimalias)) {
        var_16614ab5a07da138 += string(self._blackboard.currentvehicleanimalias);
      }

      var_e1f23551d8e893e8 = "<dev string:x3b>";

      if(isDefined(self._blackboard.var_1745d2b69c72c627)) {
        var_e1f23551d8e893e8 += string(self._blackboard.var_1745d2b69c72c627);
      }

      print3d(self.origin + (0, 0, 69), var_4931d79784405058, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 66), var_93f33954046fbb10, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 63), var_16614ab5a07da138, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 60), var_e1f23551d8e893e8, (1, 1, 1), 1, debugtextsize);
      selffwd = anglesToForward(self.angles);
      draw_arrow(self.origin, self.origin + selffwd * 20, (1, 1, 1));
      seattagorigin = vehicle gettagorigin(self._blackboard.var_1745d2b69c72c627);
      var_4924aef698f4949c = vehicle gettagangles(self._blackboard.var_1745d2b69c72c627);
      var_51bdc0c94c45a24d = anglesToForward(var_4924aef698f4949c);
      var_965bea2644cdb628 = (0, 0, 1);
      draw_arrow(seattagorigin + var_965bea2644cdb628, seattagorigin + var_51bdc0c94c45a24d * 15 + var_965bea2644cdb628, (0.6, 0, 0.6));
      var_da07d0498e5b65c7 = scripts\common\vehicle_aianim::anim_pos(vehicle, self._blackboard.var_9176cae5619d7fba);
      linkangle = (0, 0, 0);
      linkoffset = (0, 0, 0);

      if(isDefined(var_da07d0498e5b65c7.linkangle)) {
        linkangle = var_da07d0498e5b65c7.linkangle;
      }

      if(isDefined(var_da07d0498e5b65c7.linkoffset)) {
        linkoffset = var_da07d0498e5b65c7.linkoffset;
      }

      if(linkangle != (0, 0, 0) || linkoffset != (0, 0, 0)) {
        var_4b54cdde50ba9ce9 = rotatevector(var_51bdc0c94c45a24d, linkangle);
        draw_arrow(seattagorigin + linkoffset + var_965bea2644cdb628, seattagorigin + linkoffset + var_965bea2644cdb628 + var_4b54cdde50ba9ce9 * 15, (1, 0.2, 0.2));
      }
    } else if(function_745ac044fcee731b(2)) {
      var_da07d0498e5b65c7 = scripts\common\vehicle_aianim::anim_pos(vehicle, self._blackboard.var_9176cae5619d7fba);
      var_adbf2061fb4e443d = "<dev string:x46>";

      if(istrue(var_da07d0498e5b65c7.canshootinvehicle)) {
        var_adbf2061fb4e443d = "<dev string:x5f>";
      }

      var_7e03637d68944c16 = "<dev string:x77>";

      if(istrue(var_da07d0498e5b65c7.var_a06d61eb83f02f4)) {
        var_7e03637d68944c16 = "<dev string:x90>";
      }

      var_461e599857a1a70f = "<dev string:xa8>";

      if(istrue(var_da07d0498e5b65c7.deathragdoll)) {
        var_461e599857a1a70f = "<dev string:xbc>";
      }

      var_1165ae8c3a544686 = "<dev string:xcf>";

      if(istrue(var_da07d0498e5b65c7.bhasgunwhileriding)) {
        var_1165ae8c3a544686 = "<dev string:xe8>";
      }

      print3d(self.origin + (0, 0, 69), var_adbf2061fb4e443d, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 66), var_7e03637d68944c16, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 63), var_461e599857a1a70f, (1, 1, 1), 1, debugtextsize);
      print3d(self.origin + (0, 0, 60), var_1165ae8c3a544686, (1, 1, 1), 1, debugtextsize);
    } else if(function_745ac044fcee731b(3)) {
      var_10effa490054d61e = isDefined(self.var_d9134148f9bb887) && isDefined(self.var_f39c6b01b1d95542) && gettime() >= self.var_f39c6b01b1d95542 && gettime() < self.var_d9134148f9bb887;
      var_a755a62b691f10e3 = "<dev string:x100>";

      if(var_10effa490054d61e) {
        var_a755a62b691f10e3 += "<dev string:x101>";
      }

      print3d(self.origin + (0, 0, 69), var_a755a62b691f10e3, (1, 1, 1), 1, debugtextsize);
    }

    waitframe();
  }
}

# /