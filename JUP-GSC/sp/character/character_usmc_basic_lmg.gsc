/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_usmc_basic_lmg.gsc
*****************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_usmc_male;
#namespace character_usmc_basic_lmg;

function private autoexec init() {
  character = #"character_usmc_basic_lmg";

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
    level.fncharacterxmodelalias[%"character_usmc_basic_lmg"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"unitedstates";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_usmc_basic_lmg");
  scripts\code\character::attachhead("heads_usmc_male", xmodelalias\heads_usmc_male::main());
  self.hatmodel = "helmet_usmc_basic_lmg";
  self attach(self.hatmodel);
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
  precachemodel("body_usmc_basic_lmg");
  scripts\code\character::precachemodelarray(xmodelalias\heads_usmc_male::main());
  precachemodel("helmet_usmc_basic_lmg");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_30cc94c91d3460bb":
      return xmodelalias\heads_usmc_male::main();
  }

  assert(0, "character_usmc_basic_lmg do not have any xmodelalias");
}