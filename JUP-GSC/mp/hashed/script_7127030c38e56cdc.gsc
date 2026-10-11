/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7127030c38e56cdc.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\body_iw9_aq_lmg_1_white;
#namespace namespace_4f18e0c3d2fa5712;

function private autoexec init() {
  character = #"hash_c3ca1f45e0c26b86";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    level.fncharacterxmodelalias[%"hash_7add25331e17a845"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "rebel";
  self.voice = #"alqatala";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("body_iw9_aq_lmg_1_white", xmodelalias\body_iw9_aq_lmg_1_white::main());
  self attach("head_sp_opforce_al_qatala_lmg", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_lmg";
  self setclothtype(#"flowing");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\body_iw9_aq_lmg_1_white::main());
  precachemodel("head_sp_opforce_al_qatala_lmg");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_463df8106281068d":
      return xmodelalias\body_iw9_aq_lmg_1_white::main();
  }

  assert(0, "<dev string:x1c>");
}