/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\318.gsc
**************************************/

init() {
  common_scripts\utility::flag_init("_escalator_on");
  common_scripts\utility::flag_set("_escalator_on");
  level.escalator_movespeed = 0.5;
  var_0 = getEntArray("escalator", "targetname");
  common_scripts\utility::array_thread(var_0, ::escalator_startup);
}

escalator_startup() {
  for(var_0 = self; isDefined(var_0.target); var_0 = var_0.next_step) {
    var_0 startusinglessfrequentlighting();
    var_0.true_origin = var_0.origin;
    var_0.next_step = getEnt(var_0.target, "targetname");
  }

  var_0.true_origin = var_0.origin;
  var_0.last = 1;
  var_0.next_step = self;
  thread escalator_move(self);
}

escalator_move(var_0) {
  var_1 = var_0;
  var_2 = var_1.origin;

  while(common_scripts\utility::flag("_escalator_on")) {
    var_3 = level.escalator_movespeed;
    var_4 = var_1.next_step;
    var_1 show();

    if(var_4 != var_0) {
      var_1 moveTo(var_4.true_origin, var_3);
    } else {
      var_1.origin = var_2;
    }
    if(var_4 == var_0) {
      var_1 hide();
      var_1.true_origin = var_2;
      var_0 = var_1;
      wait(var_3);
      continue;
    }

    var_1.true_origin = var_4.true_origin;
    var_1 = var_4;
  }

  var_1 = var_0;

  for(;;) {
    var_3 = 2;
    var_4 = var_1.next_step;
    var_1 show();
    var_1 thread final_move(var_3, var_4);

    if(var_4 == var_0) {
      var_1 hide();
      var_1.true_origin = var_2;
    }

    var_1.true_origin = var_4.true_origin;
    var_1 = var_4;

    if(var_1 == var_0) {
      return;
    }
  }
}

final_move(var_0, var_1) {
  self moveTo(var_1.true_origin, var_0, 0, var_0);
  wait(var_0);
  self moveTo(self.origin, 0.05);
}