/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58335.gsc
***********************************************/

function ref_11fe3(var0, var1, var2) {
  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    scripts\asm\soldier\death::lbravo_spawner_jammer1();
  }

  var3 = 40;
  var4 = 40;
  var5 = self scriptablecanbepinged();

  if(isDefined(var5)) {
    var6 = (self.origin + var5.origin) * 0.5;
    thread oic_hasspawned(level, var6, var3);
    return;
  }
}

function oic_hasspawned(var0, var1, var2) {
  var3 = createnavobstaclebyshapeforlayer(var0, 6, var1, var2);
  wait 3;
  destroynavobstacle(var3);
}