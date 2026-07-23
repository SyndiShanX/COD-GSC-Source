/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1464.gsc
**************************************/

main() {
  codescripts\character::setmodelfromarray(xmodelalias/alias_so_martyrdom_smg_bodies::main());
  self attach("head_opforce_arab_c", "", 1);
  self.headmodel = "head_opforce_arab_c";
  self.voice = "russian";
}

precache() {
  codescripts\character::precachemodelarray(xmodelalias/alias_so_martyrdom_smg_bodies::main());
  precachemodel("head_opforce_arab_c");
}