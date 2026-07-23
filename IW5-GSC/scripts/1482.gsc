/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1482.gsc
**************************************/

main() {
  self setModel("body_so_juggernaut_blue");
  self attach("head_so_juggernaut_blue_hat", "", 1);
  self.headmodel = "head_so_juggernaut_blue_hat";

  if(isendstr(self.headmodel, "_hat")) {
    self.hatmodel = "hat_so_juggernaut_blue";
    self attach(self.hatmodel);
  }

  self.voice = "russian";
}

precache() {
  precachemodel("body_so_juggernaut_blue");
  precachemodel("head_so_juggernaut_blue_hat");
  precachemodel("hat_so_juggernaut_blue");
}