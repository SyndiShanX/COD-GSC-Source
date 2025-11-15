/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\oic.csc
***********************************************/

#namespace oic;

event_handler[gametype_init] main(eventstruct) {
  level.var_8eef5741 = 1;
  var_1f99b9e8 = [];

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"hero_annihilator" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_standard_t8" + "_oic", "uber");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_fullauto_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_topbreak_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "pistolscope");

  if(!isDefined(var_1f99b9e8)) {
    var_1f99b9e8 = [];
  } else if(!isarray(var_1f99b9e8)) {
    var_1f99b9e8 = array(var_1f99b9e8);
  }

  var_1f99b9e8[var_1f99b9e8.size] = getweapon(#"pistol_revolver_t8" + "_oic", "uber");
  gunselection = getgametypesetting(#"gunselection");
  level.var_bf82f6b0 = var_1f99b9e8[gunselection];

  if(isDefined(level.var_bf82f6b0) && isDefined(level.var_bf82f6b0.worldmodel)) {
    forcestreamxmodel(level.var_bf82f6b0.worldmodel);
  }
}