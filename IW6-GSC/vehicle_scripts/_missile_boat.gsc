/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_missile_boat.gsc
*********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("missile_boat", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_boat_underneath_2");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_drive( % ship_graveyard_boat_propellers, undefined, 2);
}