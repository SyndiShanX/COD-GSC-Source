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
    var_5[var_11] thread floater_think(var_6, var_7, var_8, var_10, var_9);
  }
}

floater_think(var_0, var_1, var_2, var_3, var_4) {
  self.range = var_0;
  self.time = 1 / var_1;
  self.acc = self.time * 0.25;
  var_5 = self getorigin();
  var_6 = 360 / var_2;
  var_7 = distance(var_5, var_4);
  var_8 = var_7 * var_6;
  var_9 = sin(var_8);

  if(cos(var_8) < 0) {
    self.range = -1 * self.range;
  }
  var_10 = spawn("script_origin", var_5);
  self linkTo(var_10);
  var_11 = vectortoangles(var_5 - var_4);
  self.nangles = var_10.angles;
  var_10.angles = var_10.angles + (var_3, var_3 * 0.25, var_11[2]);
  self.rangles = var_10.angles;
  thread floater_move(var_9, var_10);
  thread floater_bob(var_9, var_10);
}

floater_bob(var_0, var_1) {
  self endon("death");
  self endon("stop_float_script");
  wait(abval(self.time * var_0));

  for(;;) {
    self.rangles = self.rangles * -1;
    var_1 rotateTo(self.rangles, self.time, self.acc, self.acc);
    var_1 waittill("rotatedone");
  }
}

floater_move(var_0, var_1) {
  self endon("death");
  self endon("stop_float_script");
  wait(abval(self.time * var_0));
  var_1 movez(self.range * 0.5, self.time * 0.5, self.acc, self.acc);

  for(;;) {
    var_1 waittill("movedone");
    self.range = -1 * self.range;
    var_1 movez(self.range, self.time, self.acc, self.acc);
  }
}

abval(var_0) {
  if(var_0 < 0) {
    return -1 * var_0;
  } else {
    return var_0;
  }
}