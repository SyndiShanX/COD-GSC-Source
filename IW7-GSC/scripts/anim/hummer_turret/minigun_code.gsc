/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\minigun_code.gsc
*******************************************************/

main(param_00) {
  param_00.var_6D6F = 0.1;
  param_00.var_4292 = 45;
  param_00.var_6D65 = ::func_6D64;
  param_00.var_10953 = ::func_B79D;
  param_00.var_4FEA = 20;
  scripts\anim\hummer_turret\common::func_91E0(param_00, "minigun");
  wait(0.05);
  param_00 notify("turret_ready");
}

func_B79D(param_00, param_01) {
  if(param_01 _meth_810A() > 0) {
    param_01 _meth_83A2();
  }
}

func_6D64(param_00) {
  self endon("death");
  self endon("dismount");
  param_00 endon("kill_fireController");
  param_00 endon("death");
  param_00.var_6A4F = 600;
  param_00.var_6A4E = 900;
  var_01 = -1;
  var_02 = undefined;
  var_03 = undefined;
  param_00.var_6A52 = 250;
  param_00.var_6A51 = 2250;
  var_04 = -1;
  var_05 = undefined;
  var_06 = 0;
  var_07 = 0;
  param_00.var_F0C7 = 15;
  if(isDefined(param_00.var_F0C8)) {
    param_00.var_F0C7 = param_00.var_F0C8;
  }

  param_00.var_6D96 = 0;
  scripts\anim\hummer_turret\common::func_57DB(param_00);
  for(;;) {
    if(param_00.var_5855 && !var_06 && !self.var_9DA6) {
      var_06 = 1;
      if(!var_07) {
        param_00 func_B7A2();
        var_07 = 1;
      }

      param_00 notify("startfiring");
      var_01 = gettime();
      scripts\anim\hummer_turret\common::func_5AAA(param_00);
      wait(0.05);
    } else if(!param_00.var_5855 && var_06) {
      if(!isDefined(var_02)) {
        var_02 = gettime();
      }

      if(!isDefined(var_03)) {
        var_03 = randomfloatrange(param_00.var_6A4F, param_00.var_6A4E);
      }

      if(gettime() - var_02 >= var_03) {
        var_06 = 0;
        scripts\anim\hummer_turret\common::func_57DB(param_00);
        var_04 = gettime();
        var_02 = undefined;
        var_03 = undefined;
      }
    } else if(!param_00.var_5855 && !var_06 && var_07) {
      if(!isDefined(var_05)) {
        var_05 = randomfloatrange(param_00.var_6A52, param_00.var_6A51);
      }

      if(self.var_9DA6 || gettime() - var_04 >= var_05) {
        param_00 _meth_83A2();
        var_07 = 0;
        var_05 = undefined;
      }
    }

    if(param_00.var_12A94 == "fire") {
      param_00.var_6D96 = param_00.var_6D96 + 0.05;
    }

    if(param_00.var_6D96 > param_00.var_F0C7) {
      param_00.var_5855 = 0;
      var_06 = 0;
      scripts\anim\hummer_turret\common::func_57DB(param_00);
      var_04 = -1;
      var_02 = undefined;
      var_03 = undefined;
      thread scripts\anim\hummer_turret\common::func_5A65(param_00);
      param_00.var_6D96 = 0;
    }

    wait(0.05);
    if(!isDefined(param_00)) {
      break;
    }
  }
}

func_B7A2() {
  if(self _meth_810A() == 1) {
    return;
  }

  self _meth_8395();
  while(self _meth_810A() < 1) {
    wait(0.05);
  }
}