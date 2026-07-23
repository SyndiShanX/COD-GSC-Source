/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18775.gsc
**************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias/alias_russian_naval_bodies::main());
  codescripts\character::attachhead("alias_russian_naval_heads", xmodelalias/alias_russian_naval_heads::main());
  self.voice = "russian";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias/alias_russian_naval_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias/alias_russian_naval_heads::main());
}