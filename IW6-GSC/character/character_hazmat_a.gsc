/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: character\character_hazmat_a.gsc
********************************************/

main() {
  self setModel("fullbody_hazmat_a");
  self.voice = "russian";
  self setclothtype("nylon");
}

precache() {
  precachemodel("fullbody_hazmat_a");
}