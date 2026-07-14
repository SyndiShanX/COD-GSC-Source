/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\t10_flash.gsc
**********************************************/

#using scripts\sp\equipment\flash;
#using scripts\sp\equipment\offhands;
#namespace t10_flash;

function private autoexec function_ccae869f14439e87() {
  offhands::registerprecachefunc("\xf6\x01\x1b\xc5ek\xd9SX\xe0\xac\fd\xcc\\\xe6\xe5\xb8\xbb\xb5", &precache);
}

function private precache(offhand) {
  flash::precache(offhand);
  offhands::overrideweaponoffhandtype(offhand, 0);
}