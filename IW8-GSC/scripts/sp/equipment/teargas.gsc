/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\teargas.gsc
***********************************************/

function precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, &teargasfiremain);
}

function teargasfiremain(var_0) {
  jumpiftrue(isDefined(var_0)) LOC_00000009;
  return;
}