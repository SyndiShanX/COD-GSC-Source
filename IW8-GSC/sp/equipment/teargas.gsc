/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\teargas.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::teargasfiremain);
}

teargasfiremain(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 waittill("explode", var_1);
  wait 0.75;
  createnavbadplacebybounds(var_1, (150, 150, 150), (0, 0, 0));
}