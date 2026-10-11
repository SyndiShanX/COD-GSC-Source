/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_4d05aca419295699.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_syrkistan_female_head;
#namespace namespace_da52c91eb04dd047;

function private autoexec init() {
  character = #"hash_ac5417feffc25d1b";

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
    level.fncharacterxmodelalias[%"hash_3555c0e6a8b570b0"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("c_jup_body_civ_london_female_1_1");
  scripts\code\character::attachhead("civilian_syrkistan_female_head", xmodelalias\civilian_syrkistan_female_head::main());
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
  precachemodel("c_jup_body_civ_london_female_1_1");
  scripts\code\character::precachemodelarray(xmodelalias\civilian_syrkistan_female_head::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_e3145a0418a4fdd5":
      return xmodelalias\civilian_syrkistan_female_head::main();
  }

  assert(0, "c_jup_civ_london_female_01 do not have any xmodelalias");
}