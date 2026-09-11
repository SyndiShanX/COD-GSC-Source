/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\teargas.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &teargasfiremain);
}

function teargasfiremain(var0) {
  jumpiftrue(isDefined(var0)) LOC_00000009;
  return;
}