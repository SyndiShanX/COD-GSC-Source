/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\global_fx_code.gsc
***********************************************/

function global_fx(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::getStructArray(var0, "targetname");

  if(var5.size <= 0) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = randomfloatrange(-20, -15);
  }

  if(!isDefined(var3)) {
    var3 = var1;
  }

  foreach(var7 in var5) {
    if(!isDefined(level._effect)) {
      level._effect = [];
    }

    if(!isDefined(level._effect[var3])) {
      level._effect[var3] = loadfx(var1);
    }

    if(!isDefined(var7.angles)) {
      var7.angles = (0, 0, 0);
    }

    var8 = scripts\engine\utility::createoneshoteffect(var3);
    var8.v["origin"] = var7.origin;
    var8.v["angles"] = var7.angles;
    var8.v["fxid"] = var3;
    var8.v["delay"] = var2;

    if(isDefined(var4)) {
      var8.v["soundalias"] = var4;
    }
  }
}