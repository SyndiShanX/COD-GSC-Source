/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_452c67fa453359ed.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civ_russian_male_body_1;
#using xmodelalias\civ_russian_male_head_1;
#namespace namespace_3ba2bf2d1d1da9c3;

function private autoexec init() {
  character = #"hash_a9fa642741d14f8f";

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
    level.fncharacterxmodelalias[%"hash_291671ee263a588c"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_civ_russian_male_body_1", xmodelalias\c_jup_civ_russian_male_body_1::main());
  scripts\code\character::attachhead("civ_russian_male_head_1", xmodelalias\civ_russian_male_head_1::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civ_russian_male_body_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\civ_russian_male_head_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_8b901f50274024b8":
      return xmodelalias\c_jup_civ_russian_male_body_1::main();
    case #"hash_9741638f65b1ecbc":
      return xmodelalias\civ_russian_male_head_1::main();
  }

  assert(0, "c_jup_civ_russian_male do not have any xmodelalias");
}