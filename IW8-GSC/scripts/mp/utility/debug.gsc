/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\debug.gsc
***********************************************/

function drawent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(var_3 / level.framedurationseconds);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    waitframe();
  }
}

function drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

function drawsphere(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

function drawangles(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = anglesToForward(var_1);
    var_7 = anglestoright(var_1);
    var_8 = anglestoup(var_1);
    waitframe();
  }
}