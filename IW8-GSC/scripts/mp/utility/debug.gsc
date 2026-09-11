/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\debug.gsc
***********************************************/

function drawent(var0, var1, var2, var3, var4) {
  var5 = int(var3 / level.framedurationseconds);

  for(var6 = 0; var6 < var5; var6++) {
    waitframe();
  }
}

function drawline(var0, var1, var2, var3) {
  var4 = int(var2 / level.framedurationseconds);

  for(var5 = 0; var5 < var4; var5++) {
    waitframe();
  }
}

function drawsphere(var0, var1, var2, var3) {
  var4 = int(var2 / level.framedurationseconds);

  for(var5 = 0; var5 < var4; var5++) {
    waitframe();
  }
}

function drawangles(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  var4 = int(var2 / level.framedurationseconds);

  for(var5 = 0; var5 < var4; var5++) {
    var6 = anglesToForward(var1);
    var7 = anglestoright(var1);
    var8 = anglestoup(var1);
    waitframe();
  }
}