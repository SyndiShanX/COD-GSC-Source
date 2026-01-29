/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1356.gsc
**************************************/

main(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getEntArray("script_floater", "targetname");

  if(!var_5.size) {
    return;
  }
  var_6 = 10;
  var_7 = 0.5;
  var_8 = 50;
  var_9 = (0, 0, 0);
  var_10 = 10;

  if(isDefined(var_0)) {
    var_6 = var_0;

  }
  if(isDefined(var_1)) {
    var_7 = var_1;

  }
  if(isDefined(var_2)) {
    var_8 = var_2;

  }
  if(isDefined(var_4)) {
    var_9 = var_4;

  }
  if(isDefined(var_3)) {
    var_10 = var_3;

  }
  for(var_11 = 0; var_11 < var_5.size; var_11++) {
    var_5[var_11] thread _id_409D(var_6, var_7, var_8, var_10, var_9);
  }
}

_id_409D(var_0, var_1, var_2, var_3, var_4) {
  self._id_298F = var_0;
  self.time = 1 / var_1;
  self._id_409E = self.time * 0.25;
  var_5 = self getorigin();
  var_6 = 360 / var_2;
  var_7 = distance(var_5, var_4);
  var_8 = var_7 * var_6;
  var_9 = sin(var_8);

  if(cos(var_8) < 0) {
    self._id_298F = -1 * self._id_298F;

  }
  var_10 = spawn("script_origin", var_5);
  self linkto(var_10);
  var_11 = vectortoangles(var_5 - var_4);
  self._id_409F = var_10.angles;
  var_10.angles = var_10.angles + (var_3, var_3 * 0.25, var_11[2]);
  self._id_40A0 = var_10.angles;
  thread _id_40A2(var_9, var_10);
  thread _id_40A1(var_9, var_10);
}

_id_40A1(var_0, var_1) {
  self endon("death");
  self endon("stop_float_script");
  wait(_id_40A3(self.time * var_0));

  for(;;) {
    self._id_40A0 = self._id_40A0 * -1;
    var_1 rotateto(self._id_40A0, self.time, self._id_409E, self._id_409E);
    var_1 waittill("rotatedone");
  }
}

_id_40A2(var_0, var_1) {
  self endon("death");
  self endon("stop_float_script");
  wait(_id_40A3(self.time * var_0));
  var_1 movez(self._id_298F * 0.5, self.time * 0.5, self._id_409E, self._id_409E);

  for(;;) {
    var_1 waittill("movedone");
    self._id_298F = -1 * self._id_298F;
    var_1 movez(self._id_298F, self.time, self._id_409E, self._id_409E);
  }
}

_id_40A3(var_0) {
  if(var_0 < 0) {
    return -1 * var_0;
  } else {
    return var_0;
  }
}