/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\debug_utility.gsc
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

drawcylinder(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(var_3 / level.framedurationseconds);

  for(var_6 = 0; var_6 < var_5; var_6++)
    waitframe();
}

drawboxfrompoints(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  thread drawline(var_0, var_1, var_8, var_9);
  thread drawline(var_0, var_4, var_8, var_9);
  thread drawline(var_0, var_2, var_8, var_9);
  thread drawline(var_1, var_3, var_8, var_9);
  thread drawline(var_1, var_5, var_8, var_9);
  thread drawline(var_2, var_6, var_8, var_9);
  thread drawline(var_2, var_3, var_8, var_9);
  thread drawline(var_3, var_7, var_8, var_9);
  thread drawline(var_4, var_5, var_8, var_9);
  thread drawline(var_4, var_6, var_8, var_9);
  thread drawline(var_5, var_7, var_8, var_9);
  thread drawline(var_7, var_6, var_8, var_9);
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