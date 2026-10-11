/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42f3a02f95670934.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_iw9_enemy_aq_ar_5;
#using xmodelalias\heads_iw9_enemy_aq_ar_5;
#namespace namespace_c6c98d92b6d5bae4;

function private autoexec init() {
  character = #"hash_b5b2f23a77560948";

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
    level.fncharacterxmodelalias[%"hash_23cfc848104540cd"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("bodies_iw9_enemy_aq_ar_5", xmodelalias\bodies_iw9_enemy_aq_ar_5::main());
  scripts\code\character::attachhead("heads_iw9_enemy_aq_ar_5", xmodelalias\heads_iw9_enemy_aq_ar_5::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_iw9_enemy_aq_ar_5::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_iw9_enemy_aq_ar_5::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_ad9bb2d039ceb831":
      return xmodelalias\bodies_iw9_enemy_aq_ar_5::main();
    case #"hash_1fa3627a475cae48":
      return xmodelalias\heads_iw9_enemy_aq_ar_5::main();
  }

  assert(0, "<dev string:x1c>");
}