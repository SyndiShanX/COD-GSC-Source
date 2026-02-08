/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: codescripts\character_mp.gsc
****************************************/

setModelFromArray(a) {
  self setModel(a[randomint(a.size)]);
}

precacheModelArray(a) {
  for(i = 0; i < a.size; i++)
    precacheModel(a[i]);
}

attachFromArray(a) {
  self attach(codescripts\character::randomElement(a), "", true);
}