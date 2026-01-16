/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: codescripts\character_mp.gsc
****************************************/

#include codescripts\character;

setmodelfromarray(a) {
  self setmodel(a[randomint(a.size)]);
}

precachemodelarray(a) {
  for(i = 0; i < a.size; i++)
    precachemodel(a[i]);
}

attachfromarray(a) {
  self attach(codescripts\character::randomelement(a), "", 1);
}