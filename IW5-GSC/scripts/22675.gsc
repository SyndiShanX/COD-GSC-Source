/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\22675.gsc
**************************************/

main() {
  self setModel("body_fso_vest_a");
  codescripts\character::attachhead("alias_fso_heads", xmodelalias/alias_fso_heads::main());
  self.voice = "russian";
}

precache() {
  precachemodel("body_fso_vest_a");
  codescripts\character::precachemodelarray(xmodelalias/alias_fso_heads::main());
}