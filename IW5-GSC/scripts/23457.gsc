/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23457.gsc
**************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias/alias_hamburg_hostage_bodies::main());
  codescripts\character::attachhead("alias_hamburg_hostage_heads", xmodelalias/alias_hamburg_hostage_heads::main());
  self.voice = "russian";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias/alias_hamburg_hostage_bodies::main());
  codescripts\character::precachemodelarray(xmodelalias/alias_hamburg_hostage_heads::main());
}