/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1471.gsc
**************************************/

main() {
  self setModel("body_africa_militia_smg_c");
  self attach("head_africa_militia_c_hat", "", 1);
  self.headmodel = "head_africa_militia_c_hat";

  if(isendstr(self.headmodel, "_hat")) {
    codescripts\character::attachhat("alias_africa_militia_hats_c", _id_05BC::main());
  }
  self.voice = "african";
}

precache() {
  precachemodel("body_africa_militia_smg_c");
  precachemodel("head_africa_militia_c_hat");
  codescripts\character::precachemodelarray(_id_05BC::main());
}