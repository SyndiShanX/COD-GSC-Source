/*****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting.gsc
*****************************************************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_skydiving_lighting;

function main() {
  thread lighting_setup_dvars();
  thread function_9b9701887eb61641();
  level.defaultsunlight = getmapsuncolorandintensity();
  level.defaultsundir = getmapsundirection();
}

function lighting_setup_dvars() {}

function function_9b9701887eb61641() {
  resetsundirection();
  resetsunlight();
}

function function_83165e6c3fba43ff(var_1486d9950068fc3b, var_1eee77dc97d49765, intensity) {
  if(!isDefined(intensity)) {
    intensity = undefined;
  }

  var_e660de2f1c2dc655 = anglesToForward(var_1486d9950068fc3b);
  setsundirection(var_e660de2f1c2dc655);

  if(isDefined(intensity)) {
    setsuncolorandintensity(var_1eee77dc97d49765[0], var_1eee77dc97d49765[1], var_1eee77dc97d49765[2], intensity);
    return;
  }

  setsuncolorandintensity(var_1eee77dc97d49765[0], var_1eee77dc97d49765[1], var_1eee77dc97d49765[2]);
}