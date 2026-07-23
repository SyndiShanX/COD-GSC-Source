/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\23457.gsc
**************************************/

main() {
  codescripts\character::setmodelfromarray(_id_5B9F::main());
  codescripts\character::attachhead("alias_hamburg_hostage_heads", _id_5BA0::main());
  self.voice = "russian";
}

precache() {
  codescripts\character::precachemodelarray(_id_5B9F::main());
  codescripts\character::precachemodelarray(_id_5BA0::main());
}