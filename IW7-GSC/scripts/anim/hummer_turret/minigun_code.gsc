/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\minigun_code.gsc
*******************************************************/

main(var_0) {
  var_0._id_6D6F = 0.1;
  var_0._id_4292 = 45;
  var_0._id_6D65 = ::_id_6D64;
  var_0._id_10953 = ::_id_B79D;
  var_0._id_4FEA = 20;
  scripts\anim\hummer_turret\common::_id_91E0(var_0, "minigun");
  wait 0.05;
  var_0 notify("turret_ready");
}

_id_B79D(var_0, var_1) {
  if(var_1 _meth_810A() > 0) {
    var_1 _meth_83A2();
  }
}

_id_6D64(var_0) {
  self endon("death");
  self endon("dismount");
  var_0 endon("kill_fireController");
  var_0 endon("death");
  var_0._id_6A4F = 600;
  var_0._id_6A4E = 900;
  var_1 = -1;
  var_2 = undefined;
  var_3 = undefined;
  var_0._id_6A52 = 250;
  var_0._id_6A51 = 2250;
  var_4 = -1;
  var_5 = undefined;
  var_6 = 0;
  var_7 = 0;
  var_0._id_F0C7 = 15;

  if(isDefined(var_0._id_F0C8)) {
    var_0._id_F0C7 = var_0._id_F0C8;
  }

  var_0._id_6D96 = 0;
  scripts\anim\hummer_turret\common::_id_57DB(var_0);

  for(;;) {
    if(var_0._id_5855 && !var_6 && !self._id_9DA6) {
      var_6 = 1;

      if(!var_7) {
        var_0 _id_B7A2();
        var_7 = 1;
      }

      var_0 notify("startfiring");
      var_1 = gettime();
      scripts\anim\hummer_turret\common::_id_5AAA(var_0);
      wait 0.05;
    } else if(!var_0._id_5855 && var_6) {
      if(!isDefined(var_2)) {
        var_2 = gettime();
      }

      if(!isDefined(var_3)) {
        var_3 = randomfloatrange(var_0._id_6A4F, var_0._id_6A4E);
      }

      if(gettime() - var_2 >= var_3) {
        var_6 = 0;
        scripts\anim\hummer_turret\common::_id_57DB(var_0);
        var_4 = gettime();
        var_2 = undefined;
        var_3 = undefined;
      }
    } else if(!var_0._id_5855 && !var_6 && var_7) {
      if(!isDefined(var_5)) {
        var_5 = randomfloatrange(var_0._id_6A52, var_0._id_6A51);
      }

      if(self._id_9DA6 || gettime() - var_4 >= var_5) {
        var_0 _meth_83A2();
        var_7 = 0;
        var_5 = undefined;
      }
    }

    if(var_0._id_12A94 == "fire") {
      var_0._id_6D96 = var_0._id_6D96 + 0.05;
    }

    if(var_0._id_6D96 > var_0._id_F0C7) {
      var_0._id_5855 = 0;
      var_6 = 0;
      scripts\anim\hummer_turret\common::_id_57DB(var_0);
      var_4 = -1;
      var_2 = undefined;
      var_3 = undefined;
      thread scripts\anim\hummer_turret\common::_id_5A65(var_0);
      var_0._id_6D96 = 0;
    }

    wait 0.05;

    if(!isDefined(var_0)) {
      break;
    }
  }
}

_id_B7A2() {
  if(self _meth_810A() == 1) {
    return;
  }
  self _meth_8395();

  while(self _meth_810A() < 1) {
    wait 0.05;
  }
}