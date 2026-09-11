/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58335.gsc
***********************************************/

function ref_11fe3(var_0, var_1, var_2) {
  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    scripts\asm\soldier\death::lbravo_spawner_jammer1();
  }

  var_3 = 40;
  var_4 = 40;
  var_5 = self scriptablecanbepinged();

  if(isDefined(var_5)) {
    var_6 = (self.origin + var_5.origin) * 0.5;
    thread oic_hasspawned(level, var_6, var_3);
    return;
  }
}

function oic_hasspawned(var_0, var_1, var_2) {
  var_3 = createnavobstaclebyshapeforlayer(var_0, 6, var_1, var_2);
  wait 3;
  destroynavobstacle(var_3);
}