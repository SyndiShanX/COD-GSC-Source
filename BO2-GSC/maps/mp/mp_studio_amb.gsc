/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_studio_amb.gsc
**************************************/

main() {
  destructibles = getEntArray("destructible", "targetname");

  foreach(dest in destructibles) {
    if(dest.destructibledef == "veh_t6_dlc_electric_cart_destructible") {
      dest thread cart_fire_think();
      dest thread cart_death_think();
    }
  }
}

cart_fire_think() {
  self endon("car_dead");

  for(;;) {
    self waittill("broken", event);

    if(event == "destructible_car_fire") {
      self playLoopSound("amb_fire_med");
      return;
    }
  }
}

cart_death_think() {
  self waittill("car_dead");
  self playSound("exp_barrel");
}