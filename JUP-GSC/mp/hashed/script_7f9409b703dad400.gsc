/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7f9409b703dad400.gsc
*************************************************/

#using scripts\common\progress_tracker;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_51f0c667ac06536b;

function function_eb40bea3220ba871(var_84b03d3d5cf4dd29, var_a629870a7927d675) {
  var_eec7d321c580f401 = function_b58813f6489727f2(0, var_84b03d3d5cf4dd29);

  if(!isDefined(var_a629870a7927d675)) {
    var_a629870a7927d675 = 0.25;
  }

  var_eec7d321c580f401.paused = 0;
  var_eec7d321c580f401 thread function_45319216cd4c8a7e(0, var_a629870a7927d675);
  return var_eec7d321c580f401;
}

function function_3eec8a169e8a0936(timeinseconds, var_a629870a7927d675) {
  var_62f399d3210cb2a6 = function_b58813f6489727f2(timeinseconds, 0);

  if(!isDefined(var_a629870a7927d675)) {
    var_a629870a7927d675 = 0.25;
  }

  var_62f399d3210cb2a6.paused = 0;
  var_62f399d3210cb2a6 thread function_45319216cd4c8a7e(1, var_a629870a7927d675);
  return var_62f399d3210cb2a6;
}

function function_194d5c2394f0c8f6(var_ded14ae1ea8c4446, var_a629870a7927d675) {
  var_ad4459eadc3dee86 = function_b58813f6489727f2(0, var_ded14ae1ea8c4446.size);

  if(!isDefined(var_a629870a7927d675)) {
    var_a629870a7927d675 = 0.5;
  }

  var_ad4459eadc3dee86 thread function_5d2069574f42cf13(var_ded14ae1ea8c4446, var_a629870a7927d675);
  return var_ad4459eadc3dee86;
}

function function_45319216cd4c8a7e(shoulddecrement, var_a629870a7927d675) {
  self endon("progress_tracking_concluded");
  var_be685114ee68c2f3 = gettime();

  while(!iscomplete()) {
    var_b7d39a4661f3460 = gettime();
    timepassedinseconds = (var_b7d39a4661f3460 - var_be685114ee68c2f3) / 1000;
    var_be685114ee68c2f3 = var_b7d39a4661f3460;

    if(istrue(shoulddecrement)) {
      function_1e9e5153831d8c68(timepassedinseconds);
    } else {
      function_a370b85e4225923c(timepassedinseconds);
    }

    if(self.paused) {
      self waittill("resume");
      var_be685114ee68c2f3 = gettime();
    }

    wait var_a629870a7927d675;
  }
}

function function_5d2069574f42cf13(var_ded14ae1ea8c4446, var_a629870a7927d675) {
  self endon("progress_tracking_concluded");
  enemiesremaining = var_ded14ae1ea8c4446.size;

  while(!iscomplete()) {
    var_ded14ae1ea8c4446 = var_ded14ae1ea8c4446 function_fdc9d5557c53078e(var_ded14ae1ea8c4446);

    if(var_ded14ae1ea8c4446.size < enemiesremaining) {
      recentkills = enemiesremaining - var_ded14ae1ea8c4446.size;
      function_a370b85e4225923c(recentkills);
      enemiesremaining = var_ded14ae1ea8c4446.size;
    }

    wait var_a629870a7927d675;
  }
}