/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1496.gsc
**************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias/alias_so_russian_naval_bodies::main());
  codescripts\character::attachhead("alias_russian_naval_heads", xmodelalias/alias_russian_naval_heads::main());
  self.voice = "russian";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias/alias_so_russian_naval_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias/alias_russian_naval_heads::main());
}