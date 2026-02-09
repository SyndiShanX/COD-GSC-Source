/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_mig17.gsc
**************************************/

#include maps\_vehicle;
#using_animtree("vehicles");
main() {
  if(isDefined(self.script_numbombs) && self.script_numbombs > 0) {
    self thread maps\_plane_weapons::bomb_init(self.script_numbombs);
  }
}
mig17_setup_bombs() {
  precachemodel("aircraft_bomb");
  LoadFx("explosions/fx_mortarExp_dirt");
  maps\_plane_weapons::build_bombs("plane_mig17", "aircraft_bomb", "explosions/fx_mortarExp_dirt", "artillery_explosion");
  maps\_plane_weapons::build_bomb_explosions("plane_mig17", 0.5, 2.0, 1024, 768, 400, 25);
}