/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\battlechatter_wrapper.gsc
***********************************************/

evaluatemoveevent(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }
  [[level._battlechatter.fnevaluatemoveevent]](var_0);
}

evaluatereloadevent() {
  if(!isDefined(level._battlechatter)) {
    return;
  }
  [[level._battlechatter.fnevaluatereloadevent]]();
}

addthreatevent(var_0, var_1, var_2) {
  if(!isDefined(level._battlechatter)) {
    return;
  }
  [[level._battlechatter.fnaddthreatevent]](var_0, var_1, var_2);
}

evaluateattackevent(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }
  [[level._battlechatter.fnevaluateattackevent]](var_0);
}

playbattlechatter(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }
  [[level._battlechatter.fnplaybattlechatter]](var_0);
}