/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1385.gsc
**************************************/

main() {
  var_0 = getEntArray("treeburst", "script_noteworthy");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] thread _id_435F();
  }
}

_id_435F() {
  self waittill("treeburst");

  if(isDefined(self._id_4360)) {
    var_0 = self._id_4360;
  } else {
    var_0 = randomint(360);
  }
  var_1 = (self.angles[0], var_0, self.angles[2]);
  var_2 = anglesToForward(var_1);
  var_2 = var_2 * 100;
  var_3 = self.origin + var_2 + (0, 0, 512);
  var_4 = var_3 + (0, 0, -1024);
  var_5 = bulletTrace(var_3, var_4, 0, self);
  var_6 = self.origin + var_2 - var_5["position"];
  var_7 = var_6[2];
  var_8 = 0;
  var_9 = 0;
  var_10 = var_9;
  var_11 = 0;

  for(var_12 = var_11; var_9 < var_7; var_11++) {
    var_8 = var_8 + 340;
    var_10 = var_9;
    var_9 = var_9 + var_8;
    var_12 = var_11;
  }

  var_13 = var_10 - var_7;

  if(var_13 < 0) {
    var_13 = var_13 * -1;
  }
  var_14 = var_12 + var_13 / var_8;
  self movegravity(var_2, var_14);
  self waittill("movedone");
  var_15 = vectornormalize(var_2);
  var_15 = var_15 * 320;
  var_3 = self.origin + var_15 + (0, 0, 512);
  var_4 = var_3 + (0, 0, -1024);
  var_5 = bulletTrace(var_3, var_4, 0, self);
  var_16 = var_5["position"];
  var_17 = anglestoup(self.angles);
  var_18 = vectortoangles(var_17);
  var_19 = var_16 - self.origin;
  var_20 = vectortoangles(var_19);
  var_21 = spawn("script_origin", self.origin);
  var_21.origin = self.origin;
  var_21.angles = (var_18[0], var_20[1], var_20[2]);
  self linkto(var_21);
  var_21 rotateto(var_20, 1.15, 0.5, 0);
  var_21 waittill("rotatedone");
  var_21 rotatepitch(-2.5, 0.21, 0.05, 0.15);
  var_21 waittill("rotatedone");
  var_21 rotatepitch(2.5, 0.26, 0.15, 0.1);
  var_21 waittill("rotatedone");
  self unlink();
  var_21 delete();
}

drawline(var_0, var_1, var_2, var_3) {
  for(;;) {
    wait 0.05;
  }
}

_id_4361(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  if(isDefined(var_1)) {
    for(;;) {
      wait 0.05;
    }
  } else {
    for(;;) {
      var_3 = (1, 0, 0);
      var_4 = (0, 1, 0);
      var_5 = (0, 0, 1);
      wait 0.05;
    }
  }
}