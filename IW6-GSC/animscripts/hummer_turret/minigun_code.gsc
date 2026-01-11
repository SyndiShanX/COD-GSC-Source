/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\minigun_code.gsc
******************************************************/

main(var_0) {
  var_0.fireinterval = 0.1;
  var_0.closeenoughaimdegrees = 45;
  var_0.firecontrollerfunc = ::firecontroller_minigun;
  var_0.specialcleanupfunc = ::minigun_cleanup_func;
  var_0.default_drop_pitch = 20;
  animscripts\hummer_turret\common::humvee_turret_init(var_0, "minigun");
  wait 0.05;
  var_0 notify("turret_ready");
}

minigun_cleanup_func(var_0, var_1) {
  if(var_1 getbarrelspinrate() > 0) {
    var_1 stopbarrelspin();
  }
}

firecontroller_minigun(var_0) {
  self endon("death");
  self endon("dismount");
  var_0 endon("kill_fireController");
  var_0 endon("death");
  var_0.extrafiretime_min = 600;
  var_0.extrafiretime_max = 900;
  var_1 = -1;
  var_2 = undefined;
  var_3 = undefined;
  var_0.extraspintime_min = 250;
  var_0.extraspintime_max = 2250;
  var_4 = -1;
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_0.secsoffiringbeforereload = 15;

  if(isDefined(var_0.secsoffiringbeforereloaddefault)) {
    var_0.secsoffiringbeforereload = var_0.secsoffiringbeforereloaddefault;
  }

  var_0.firetime = 0;
  animscripts\hummer_turret\common::doaim(var_0);

  for(;;) {
    if(var_0.dofiring && !var_6 && !self.iscustomanimating) {
      var_6 = 1;

      if(!var_7) {
        var_0 minigun_spinup();
        var_7 = 1;
      }

      var_0 notify("startfiring");
      var_1 = gettime();
      animscripts\hummer_turret\common::doshoot(var_0);
      wait 0.05;
    } else if(!var_0.dofiring && var_6) {
      if(!isDefined(var_2)) {
        var_2 = gettime();
      }

      if(!isDefined(var_3)) {
        var_3 = randomfloatrange(var_0.extrafiretime_min, var_0.extrafiretime_max);
      }

      if(gettime() - var_2 >= var_3) {
        var_6 = 0;
        animscripts\hummer_turret\common::doaim(var_0);
        var_4 = gettime();
        var_2 = undefined;
        var_3 = undefined;
      }
    } else if(!var_0.dofiring && !var_6 && var_7) {
      if(!isDefined(var_5)) {
        var_5 = randomfloatrange(var_0.extraspintime_min, var_0.extraspintime_max);
      }

      if(self.iscustomanimating || gettime() - var_4 >= var_5) {
        var_0 stopbarrelspin();
        var_7 = 0;
        var_5 = undefined;
      }
    }

    if(var_0.turretstate == "fire") {
      var_0.firetime = var_0.firetime + 0.05;
    }

    if(var_0.firetime > var_0.secsoffiringbeforereload) {
      var_0.dofiring = 0;
      var_6 = 0;
      animscripts\hummer_turret\common::doaim(var_0);
      var_4 = -1;
      var_2 = undefined;
      var_3 = undefined;
      thread animscripts\hummer_turret\common::doreload(var_0);
      var_0.firetime = 0;
    }

    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }
  }
}

minigun_spinup() {
  if(self getbarrelspinrate() == 1) {
    return;
  }
  self startbarrelspin();

  while(self getbarrelspinrate() < 1) {
    wait 0.05;
  }
}