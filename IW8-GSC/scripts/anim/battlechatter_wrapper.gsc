/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_wrapper.gsc
**************************************************/

function evaluatemoveevent(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluatemoveevent]](var_0);
}

function evaluatereloadevent() {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluatereloadevent]]();
}

function addthreatevent(var_0, var_1, var_2) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnaddthreatevent]](var_0, var_1, var_2);
}

function evaluateattackevent(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnevaluateattackevent]](var_0);
}

function playbattlechatter(var_0) {
  if(!isDefined(level._battlechatter)) {
    return;
  }

  [[level._battlechatter.fnplaybattlechatter]](var_0);
}