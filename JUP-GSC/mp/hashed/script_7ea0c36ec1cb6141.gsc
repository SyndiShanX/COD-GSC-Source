/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7ea0c36ec1cb6141.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\body_iw9_aq_smg_1_white;
#namespace namespace_ef113d00ca43143;

function private autoexec init() {
  character = #"hash_2c44a42db6152bbf";

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
    level.fncharacterxmodelalias[%"hash_1110922d8f7d440"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("body_iw9_aq_smg_1_white", xmodelalias\body_iw9_aq_smg_1_white::main());
  self attach("head_sp_opforce_al_qatala_smg", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_smg";
  self setclothtype(#"flowing");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\body_iw9_aq_smg_1_white::main());
  precachemodel("head_sp_opforce_al_qatala_smg");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_2e32adac6ca63178":
      return xmodelalias\body_iw9_aq_smg_1_white::main();
  }

  assert(0, "<dev string:x1c>");
}