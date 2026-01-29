/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\minigun_code.gsc
******************************************************/

main(var_0) {
  var_0._id_489C = 0.1;
  var_0._id_489D = 45;
  var_0._id_489E = ::_id_48CC;
  var_0._id_489F = ::_id_48CB;
  var_0._id_4898 = 20;
  animscripts\hummer_turret\common::_id_4885(var_0, "minigun");
  wait 0.05;
  var_0 notify("turret_ready");
}

_id_48CB(var_0, var_1) {
  if(var_1 getbarrelspinrate() > 0) {
    var_1 stopbarrelspin();
  }
}

_id_48CC(var_0) {
  self endon("death");
  self endon("dismount");
  var_0 endon("kill_fireController");
  var_0 endon("death");
  var_0._id_48CD = 600;
  var_0._id_48CE = 900;
  var_1 = -1;
  var_2 = undefined;
  var_3 = undefined;
  var_0._id_48CF = 250;
  var_0._id_48D0 = 2250;
  var_4 = -1;
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_0._id_48D1 = 15;

  if(isDefined(var_0._id_48D2)) {
    var_0._id_48D1 = var_0._id_48D2;

  }
  var_0._id_488A = 0;
  animscripts\hummer_turret\common::_id_48B6(var_0);

  for(;;) {
    if(var_0._id_488B && !var_6 && !self._id_4887) {
      var_6 = 1;

      if(!var_7) {
        var_0 _id_48D3();
        var_7 = 1;
      }

      var_0 notify("startfiring");
      var_1 = gettime();
      animscripts\hummer_turret\common::_id_227C(var_0);
      wait 0.05;
    } else if(!var_0._id_488B && var_6) {
      if(!isDefined(var_2)) {
        var_2 = gettime();

      }
      if(!isDefined(var_3)) {
        var_3 = randomfloatrange(var_0._id_48CD, var_0._id_48CE);

      }
      if(gettime() - var_2 >= var_3) {
        var_6 = 0;
        animscripts\hummer_turret\common::_id_48B6(var_0);
        var_4 = gettime();
        var_2 = undefined;
        var_3 = undefined;
      }
    } else if(!var_0._id_488B && !var_6 && var_7) {
      if(!isDefined(var_5)) {
        var_5 = randomfloatrange(var_0._id_48CF, var_0._id_48D0);

      }
      if(self._id_4887 || gettime() - var_4 >= var_5) {
        var_0 stopbarrelspin();
        var_7 = 0;
        var_5 = undefined;
      }
    }

    if(var_0._id_4889 == "fire") {
      var_0._id_488A = var_0._id_488A + 0.05;

    }
    if(var_0._id_488A > var_0._id_48D1) {
      var_0._id_488B = 0;
      var_6 = 0;
      animscripts\hummer_turret\common::_id_48B6(var_0);
      var_4 = -1;
      var_2 = undefined;
      var_3 = undefined;
      thread animscripts\hummer_turret\common::_id_48BE(var_0);
      var_0._id_488A = 0;
    }

    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }
  }
}

_id_48D3() {
  if(self getbarrelspinrate() == 1) {
    return;
  }
  self startbarrelspin();

  while(self getbarrelspinrate() < 1) {
    wait 0.05;
  }
}