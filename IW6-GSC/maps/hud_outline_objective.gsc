/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\hud_outline_objective.gsc
******************************************/

outline_enable() {
  if(getdvarint("r_hudoutlineenable", 0) == 1) {
    return;
  }
  setsaveddvar("r_hudoutlineenable", 1);
  setsaveddvar("r_hudOutlineWidth", 1);
}

outline_disable() {
  setsaveddvar("r_hudoutlineenable", 0);
}

outline_set_global_width(var_0) {
  var_1 = getdvarfloat("r_hudOutlineWidth");

  if(var_1 != var_0)
    setsaveddvar("r_hudOutlineWidth", var_0);
}

objective_outline_remove(var_0) {
  var_0 hudoutlinedisable();
}

objective_outline_add(var_0, var_1) {
  outline_enable();
  var_2 = 5;

  if(isDefined(var_1))
    var_2 = var_1;

  var_0 hudoutlineenable(var_2, 1);
}