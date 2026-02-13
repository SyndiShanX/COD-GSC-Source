/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2700.gsc
*************************************************/

_id_4F3F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(var_3 / level._id_5F3A);

  for(var_6 = 0; var_6 < var_5; var_6++) {
    waitframe();
  }
}

_id_4F43(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level._id_5F3A);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

_id_4F48(var_0, var_1, var_2, var_3) {
  var_4 = int(var_2 / level._id_5F3A);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    waitframe();
  }
}

_id_4F32(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = int(var_2 / level._id_5F3A);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = anglesToForward(var_1);
    var_7 = anglestoright(var_1);
    var_8 = anglestoup(var_1);
    waitframe();
  }
}