/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_wrapper.gsc
**************************************************/

function evaluatemoveevent(var0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluatemoveevent]](var0);
}

function evaluatereloadevent() {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluatereloadevent]]();
}

function addthreatevent(var0, var1, var2) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnaddthreatevent]](var0, var1, var2);
}

function evaluateattackevent(var0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluateattackevent]](var0);
}

function playbattlechatter(var0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnplaybattlechatter]](var0);
}