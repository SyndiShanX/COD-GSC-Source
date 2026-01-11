/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_dissolve.csc
**************************************************/

#include clientscripts\_utility;

start_zombie_dissolve(localClientNum, colorIndex, durationMsec) {
  self thread run_dissolve_effect(localClientNum, colorIndex, durationMsec);
}

run_dissolve_effect(localClientNum, colorIndex, durationMsec) {
  self endon("entityshutdown");
  durationMsec = durationMsec * 2.0;
  self mapshaderconstant(localClientNum, 0, "scriptVector0");
  begin_time = GetRealTime();
  while(1) {
    age = GetRealTime() - begin_time;
    t = age / durationMsec;
    if(t > 1.0) {
      t = 1.0;
    }
    colorDissolve = t * 2.0;
    if(colorDissolve > 1.0) {
      colorDissolve = 1.0;
    }
    alphaDissolve = (t - 0.5) * 2.0;
    if(alphaDissolve < 0.0) {
      alphaDissolve = 0.0;
    }
    if(alphaDissolve > 1.0) {
      alphaDissolve = 1.0;
    }
    alphaDissolveMaskCompression = 4.0;
    alphaDissolveAmount = (alphaDissolve - 0.5) * 2.0 * alphaDissolveMaskCompression;
    colorDissolveAmount = (colorDissolve - 0.5) * 2.0;
    colIndex = clamp(colorIndex, 0, 3);
    colIndex = 3;
    if(!isDefined(self)) {
      return;
    }
    self setshaderconstant(localClientNum, 0, alphaDissolveMaskCompression, alphaDissolveAmount, colIndex * (1.0 / 127.0), colorDissolveAmount);
    if(t == 1.0) {
      break;
    }
    realwait(0.05);
  }
}