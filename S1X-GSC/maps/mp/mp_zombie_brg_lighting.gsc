/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_brg_lighting.gsc
**********************************************/

main() {
  set_level_lighting_values();
  thread lightintensityflicker("sewers_pit_flicker_aa", 1, 55000, 0.01, 0.1);
  thread lightintensityflicker("gasStation_fire_flicker_aa", 1, 155000, 0.01, 0.1);
}

set_level_lighting_values() {
  if(isusinghdr()) {
    return;
  }
}

lightintensityflicker(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getent(var_0, "targetname");

  if(!isDefined(var_5)) {
    return;
  }
  for(;;) {
    var_6 = randomfloatrange(var_1, var_2);
    var_5 setlightintensity(var_6);
    wait(randomfloatrange(var_3, var_4));
  }
}