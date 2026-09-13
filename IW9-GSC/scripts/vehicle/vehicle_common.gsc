/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\vehicle_common.gsc
***********************************************/

requestentervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos) {
  self._blackboard._id_B5096603D1631C0B = vehicle;
  self._blackboard._id_83AEBFFE3C7883C9 = spawninvehicle;
  self._blackboard._id_D59400D26AEE998E = chosenvehicleposition.origin;
  self._blackboard._id_A3111C437379D9E9 = chosenvehicleposition.angles;
  self._blackboard._id_9176CAE5619D7FBA = chosenvehicleposition.vehicle_position;
  self._blackboard._id_6A69FA6B0B354C93 = istrue(chosenvehicleposition.canshootinvehicle);
  self._blackboard.currentvehicleanimalias = vehicle.vehicleanimalias;
  self._blackboard._id_1745D2B69C72C627 = chosenvehicleanimpos.sittag;
  self._blackboard._id_F6D06D1E68F4F4E5 = istrue(chosenvehicleanimpos.linktoblend);
  self._blackboard._id_E5EC3A6AFD92645D = chosenvehicleanimpos.fastroperig;

  if(isDefined(chosenvehicleanimpos.vehicle_getoutanim))
    self._blackboard._id_A43D8E6E8A225CD2 = getanimname(chosenvehicleanimpos.vehicle_getoutanim);
  else
    self._blackboard._id_A43D8E6E8A225CD2 = undefined;

  self._blackboard._id_3299C329AD09645B = istrue(chosenvehicleanimpos._id_EA990BA1B0217EF1);
  self._blackboard._id_80912EC8ADE08716 = istrue(chosenvehicleanimpos._id_D5D9893C266B976C);
  self._blackboard._id_86FE99780C9BC5F9 = istrue(chosenvehicleanimpos._id_2D462059F8AAB76F);
  self._blackboard._id_41C9F8C7891F19DA = istrue(chosenvehicleanimpos._id_6C33A4216D8EFAE0);
  self._blackboard._id_3D633E73BBCDC23D = 1;
}

waitforentervehicle() {
  msg = scripts\engine\utility::waittill_any_return_4("entervehicle", "death", "long_death", "failedentervehicle");

  if(msg != "entervehicle")
    return 0;

  self _meth_5847240C0F9900F2(0);
  return 1;
}

waitforarrivedatvehicle() {
  self endon("death");
  self endon("long_death");

  while(istrue(self._blackboard._id_3D633E73BBCDC23D) || isDefined(self._blackboard.currentvehicle) && !istrue(self._blackboard.startedenteringvehicle) && !istrue(self._blackboard.enteredvehicle) && !self._blackboard.invehicle)
    waitframe();
}

entervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos) {
  requestentervehicle(vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos);
  return waitforentervehicle();
}

requestexitvehicle() {
  self._blackboard.exitvehiclerequested = 1;
}

waitforexitvehicle() {
  self endon("death");
  self endon("long_death");

  while(!istrue(self._blackboard.hasexitedvehicle))
    waitframe();

  self _meth_5847240C0F9900F2(1);
  self._blackboard.hasexitedvehicle = 0;
}

exitvehicle() {
  requestexitvehicle();
  waitforexitvehicle();
}

hasvehicle() {
  return istrue(self._blackboard._id_3D633E73BBCDC23D) || isDefined(self._blackboard) && isDefined(self._blackboard.currentvehicle);
}

setuprope() {
  self._blackboard.vehiclesetuprope = 1;
}

_id_B795D4C865A7BC7E() {
  model = self._id_B8957CD52D1EFA30;

  if(model == "")
    model = self.model;

  if(issubstr(model, "::"))
    model = strtok(model, "::")[1];

  if(isDefined(level.vehicle.templates._id_FB41D1CA75009BF0[model]) && !istrue(self._id_B3F762A51E1ED52A))
    return 1;

  return 0;
}

_id_A09D6BEE466F3189() {
  self notify("stop_loading");
  self._blackboard.isrunningtovehicle = 0;
}

_id_FFD4BD7B834E69EB(_id_1F37A785BBA731E3) {
  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle))
    return 0;

  if(self._blackboard._id_9176CAE5619D7FBA == _id_1F37A785BBA731E3)
    return 1;

  if(_id_1F37A785BBA731E3 >= vehicle.usedpositions.size)
    return 0;

  if(vehicle.usedpositions[_id_1F37A785BBA731E3] == 1)
    return 0;

  self._blackboard._id_E38C46BE257216D3 = _id_1F37A785BBA731E3;
  thread _id_B2841B0708F2B5D4();
  return 1;
}

_id_B2841B0708F2B5D4() {
  self endon("death");
  self endon("long_death");
  self._blackboard._id_3769628964AC89C1 = 0;

  while(!self._blackboard._id_3769628964AC89C1)
    waitframe();

  self._blackboard._id_9176CAE5619D7FBA = self._blackboard._id_E38C46BE257216D3;
  _id_B3E097A826F0B88B = scripts\common\vehicle_aianim::anim_pos(self._blackboard.currentvehicle, self._blackboard._id_9176CAE5619D7FBA);
  self._blackboard._id_1745D2B69C72C627 = _id_B3E097A826F0B88B.sittag;
  self._blackboard._id_F6D06D1E68F4F4E5 = istrue(_id_B3E097A826F0B88B.linktoblend);
  self._blackboard._id_E5EC3A6AFD92645D = _id_B3E097A826F0B88B.fastroperig;

  if(isDefined(_id_B3E097A826F0B88B.vehicle_getoutanim))
    self._blackboard._id_A43D8E6E8A225CD2 = getanimname(_id_B3E097A826F0B88B.vehicle_getoutanim);
  else
    self._blackboard._id_A43D8E6E8A225CD2 = undefined;

  self._blackboard._id_3299C329AD09645B = istrue(_id_B3E097A826F0B88B._id_EA990BA1B0217EF1);
  self._blackboard._id_80912EC8ADE08716 = istrue(_id_B3E097A826F0B88B._id_D5D9893C266B976C);
  self._blackboard._id_86FE99780C9BC5F9 = istrue(_id_B3E097A826F0B88B._id_2D462059F8AAB76F);
  self._blackboard._id_41C9F8C7891F19DA = istrue(_id_B3E097A826F0B88B._id_6C33A4216D8EFAE0);
  self._blackboard._id_E38C46BE257216D3 = undefined;
}