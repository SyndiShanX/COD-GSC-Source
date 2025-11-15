/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mig17.gsc
**************************************/

#include maps\_vehicle;
#include maps\_plane_weapons;

main() {
  if(isDefined(self.script_numbombs) && self.script_numbombs > 0)
    self thread maps\_plane_weapons::bomb_init(self.script_numbombs);
}

mig_setup_bombs(type) {
  precachemodel("aircraft_bomb");
  loadfx("explosions/fx_mortarExp_dirt");
  maps\_plane_weapons::build_bombs(type, "aircraft_bomb", "explosions/fx_mortarExp_dirt", "artillery_explosion");
  maps\_plane_weapons::build_bomb_explosions(type, 0.5, 2.0, 1024, 768, 400, 25);
}