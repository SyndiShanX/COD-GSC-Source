/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_dragunov_lightset.gsc
***************************************/

dragunov_scope_init() {
  var_0 = [];
  var_0["bog_b"] = "bog_b_dragunov";
  var_0["armada"] = "armada_dragunov";

  if(isdefined(var_0[level.script]))
    thread dragunov_scope_monitor(var_0[level.script]);
}

dragunov_scope_monitor(var_0) {
  var_1 = 0;
  var_2 = 0;

  for (;;) {
    var_3 = level.player getcurrentweapon();
    var_4 = level.player playerads();
    var_5 = var_4 == 1.0 || var_4 > var_1;
    var_6 = isdefined(var_3) && var_3 == "dragunov" && var_5;

    if(var_6 && !var_2)
      level.player lightsetoverrideenableforplayer(var_0, 0);
    else if(!var_6 && var_2)
      level.player lightsetoverridedisableforplayer(0);

    var_2 = var_6;
    var_1 = var_4;
    wait 0.05;
  }
}