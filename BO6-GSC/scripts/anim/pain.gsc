/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\pain.gsc
**************************************/

#using scripts\asm\asm_sp;
#namespace anim_pain;

function main() {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  asm_sp::paininternal();
}

function initpainfx() {
  level._effect["\xef\xeap\x8b\xef\x19\xe0=s\xb7\x0f~\x86\xc3\xc0t\xb5M&\x18@&\xe3\t\xbe\xa3"] = loadfxasset("o.\x01$\xdf)\x12rqk\xd0\xc8>\xc5\xd8\xb4g\xba\xbc\x16\xa7\x87\x8c\xa6F\x02\xdc*?,\xd4\xc4=\x84");
}