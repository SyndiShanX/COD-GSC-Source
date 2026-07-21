/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\vehicle_heavy_destruction.gsc
***********************************************/

init_vehicle_heavy_destruction() {}

reverse_impact_think() {
  self endon("stop_heavy_damage");
  self setCanDamage(1);
  var_0 = 1;
  var_1 = 12;
  var_2 = scripts\engine\trace::create_all_contents();

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    var_13 = var_6;
    var_14 = var_6;

    for(var_15 = 0; var_15 < var_0; var_15++) {
      var_14 = var_13 + var_5 * 0.5;
      var_13 = var_14 + var_5 * var_1;
      var_16 = (randomfloat(1), randomfloat(1), randomfloat(1));
      jku_arrow(var_13, var_14, var_16, 1, 1, 200, var_5);
      magicbullet("veh_exit_hack", var_13, var_14);
      waitframe();
    }
  }
}

jku_arrow(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  setdvarifuninitialized("jkudebug", 0);

  if(getdvarint("jkudebug") == 1) {
    if(!isDefined(var_2))
      var_2 = (randomfloat(1), randomfloat(1), randomfloat(1));
  }
}

jku_point(var_0, var_1, var_2, var_3) {
  setdvarifuninitialized("jkudebug", 0);

  if(getdvarint("jkudebug") == 1) {
    if(!isDefined(var_0))
      return;
    else
      var_4 = var_0;

    if(!isDefined(var_1))
      var_1 = 6;

    if(!isDefined(var_2))
      var_2 = (1, 1, 1);

    if(!isDefined(var_3))
      var_3 = 400;
  }
}