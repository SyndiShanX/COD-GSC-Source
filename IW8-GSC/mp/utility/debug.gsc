/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\debug.gsc
***********************************************/

drawent(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(var_3 / level.framedurationseconds);

  for(var_6 = 0; var_6 < var_5; var_6++)
    waitframe();
}

drawline(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++)
    waitframe();
}

drawsphere(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++)
    waitframe();
}

drawangles(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = int(var_2 / level.framedurationseconds);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = anglesToForward(var_1);
    var_7 = anglestoright(var_1);
    var_8 = anglestoup(var_1);
    waitframe();
  }
}