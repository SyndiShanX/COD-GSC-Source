/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\t10_frag.gsc
*********************************************/

#using scripts\sp\equipment\frag;
#using scripts\sp\equipment\offhands;
#namespace t10_frag;

function private autoexec function_fba0cc1a8915bfcd() {
  offhands::registerprecachefunc("\x11\xc8#\xc06\xbbwW\x9c\x9d\xacp\xab\x91\xe19\xd8\xf83", &precache);
}

function private precache(offhand) {
  frag::precache(offhand);
  offhands::overrideweaponoffhandtype(offhand, 1);
}