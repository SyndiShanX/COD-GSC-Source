/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\318.gsc
**************************************/

init() {
  common_scripts\utility::flag_init("_escalator_on");
  common_scripts\utility::flag_set("_escalator_on");
  level._id_1DD5 = 0.5;
  var_0 = getEntArray("escalator", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_1DD6);
}

_id_1DD6() {
  for(var_0 = self; isDefined(var_0.target); var_0 = var_0._id_1DD8) {
    var_0 startusinglessfrequentlighting();
    var_0._id_1DD7 = var_0.origin;
    var_0._id_1DD8 = getent(var_0.target, "targetname");
  }

  var_0._id_1DD7 = var_0.origin;
  var_0._id_1DD9 = 1;
  var_0._id_1DD8 = self;
  thread _id_1DDA(self);
}

_id_1DDA(var_0) {
  var_1 = var_0;
  var_2 = var_1.origin;

  while(common_scripts\utility::flag("_escalator_on")) {
    var_3 = level._id_1DD5;
    var_4 = var_1._id_1DD8;
    var_1 show();

    if(var_4 != var_0) {
      var_1 moveto(var_4._id_1DD7, var_3);
    } else {
      var_1.origin = var_2;

    }
    if(var_4 == var_0) {
      var_1 hide();
      var_1._id_1DD7 = var_2;
      var_0 = var_1;
      wait(var_3);
      continue;
    }

    var_1._id_1DD7 = var_4._id_1DD7;
    var_1 = var_4;
  }

  var_1 = var_0;

  for(;;) {
    var_3 = 2;
    var_4 = var_1._id_1DD8;
    var_1 show();
    var_1 thread _id_1DDB(var_3, var_4);

    if(var_4 == var_0) {
      var_1 hide();
      var_1._id_1DD7 = var_2;
    }

    var_1._id_1DD7 = var_4._id_1DD7;
    var_1 = var_4;

    if(var_1 == var_0) {
      return;
    }
  }
}

_id_1DDB(var_0, var_1) {
  self moveto(var_1._id_1DD7, var_0, 0, var_0);
  wait(var_0);
  self moveto(self.origin, 0.05);
}