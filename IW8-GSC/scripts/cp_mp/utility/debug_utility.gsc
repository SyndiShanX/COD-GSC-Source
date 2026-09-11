/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\debug_utility.gsc
***************************************************/

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

function drawcylinder(var0, var1, var2, var3, var4) {
  var5 = int(var3 / level.framedurationseconds);

  for(var6 = 0; var6 < var5; var6++) {
    waitframe();
  }
}

function drawboxfrompoints(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  thread drawline(var0, var1, var8, var9);
  thread drawline(var0, var4, var8, var9);
  thread drawline(var0, var2, var8, var9);
  thread drawline(var1, var3, var8, var9);
  thread drawline(var1, var5, var8, var9);
  thread drawline(var2, var6, var8, var9);
  thread drawline(var2, var3, var8, var9);
  thread drawline(var3, var7, var8, var9);
  thread drawline(var4, var5, var8, var9);
  thread drawline(var4, var6, var8, var9);
  thread drawline(var5, var7, var8, var9);
  thread drawline(var7, var6, var8, var9);
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