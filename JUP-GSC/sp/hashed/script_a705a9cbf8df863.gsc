/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_a705a9cbf8df863.gsc
************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civ_russian_male_body_flashback;
#using xmodelalias\civ_russian_male_head_1_flashback;
#namespace namespace_74b6bfc08ba62475;

function private autoexec init() {
  character = #"hash_e9eb513342c81e19";

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
    level.fncharacterxmodelalias[%"hash_18084e3166da9722"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civ_russian_male_body_flashback", xmodelalias\c_jup_civ_russian_male_body_flashback::main());
  scripts\code\character::attachhead("civ_russian_male_head_1_flashback", xmodelalias\civ_russian_male_head_1_flashback::main());
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civ_russian_male_body_flashback::main());
  scripts\code\character::precachemodelarray(xmodelalias\civ_russian_male_head_1_flashback::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_1f0e8fb5797c9af2":
      return xmodelalias\c_jup_civ_russian_male_body_flashback::main();
    case #"hash_d1d30bfb5ae024f2":
      return xmodelalias\civ_russian_male_head_1_flashback::main();
  }

  assert(0, "c_jup_civ_russian_male_flashback do not have any xmodelalias");
}