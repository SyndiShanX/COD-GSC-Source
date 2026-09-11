/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\vehicle_heavy_destruction.gsc
****************************************************/

function init_vehicle_heavy_destruction() {}

function reverse_impact_think() {
  self endon("stop_heavy_damage");
  self setCanDamage(1);
  var0 = 1;
  var1 = 12;
  var2 = scripts\engine\trace::create_all_contents();

  for(;;) {
    self waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
    var13 = var6;
    var14 = var6;

    for(var15 = 0; var15 < var0; var15++) {
      var14 = var13 + var5 * 0.5;
      var13 = var14 + var5 * var1;
      var16 = (randomfloat(1), randomfloat(1), randomfloat(1));
      jku_arrow(var13, var14, var16, 1, 1, 200, var5);
      magicbullet("veh_exit_hack", var13, var14);
      waitframe();
    }
  }
}

function jku_arrow(var0, var1, var2, var3, var4, var5, var6) {
  setdvarifuninitialized("jkudebug", 0);

  if(getdvarint("jkudebug") == 1) {
    if(!isDefined(var2)) {
      var2 = (randomfloat(1), randomfloat(1), randomfloat(1));
    }

    return;
  }
}

function jku_point(var0, var1, var2, var3) {
  setdvarifuninitialized("jkudebug", 0);

  if(getdvarint("jkudebug") == 1) {
    if(!isDefined(var0)) {
      return;
    } else {
      var4 = var0;
    }

    if(!isDefined(var1)) {
      var1 = 6;
    }

    if(!isDefined(var2)) {
      var2 = (1, 1, 1);
    }

    if(!isDefined(var3)) {
      var3 = 400;
    }

    return;
  }
}