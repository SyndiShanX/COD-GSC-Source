/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23445.gsc
**************************************/

main() {
  self setModel("body_africa_militia_assault_a");
  codescripts\character::attachhead("alias_africa_militia_heads_a", xmodelalias/alias_africa_militia_heads_a::main());

  if(isendstr(self.headmodel, "_hat")) {
    codescripts\character::attachhat("alias_africa_militia_hats_a", xmodelalias/alias_africa_militia_hats_a::main());
  }
  self.voice = "african";
}

precache() {
  precachemodel("body_africa_militia_assault_a");
  codescripts\character::precachemodelarray(xmodelalias/alias_africa_militia_heads_a::main());
  codescripts\character::precachemodelarray(xmodelalias/alias_africa_militia_hats_a::main());
}