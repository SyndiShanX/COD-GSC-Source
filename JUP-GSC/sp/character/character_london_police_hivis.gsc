/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_london_police_hivis.gsc
*******************************************************/



#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_london_police;
#namespace character_london_police_hivis;

function private autoexec init() {
  character = #"character_london_police_hivis";

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
    level.fncharacterxmodelalias[%"character_london_police_hivis"] = &function_ecf17a96e49ab67;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier_pistol";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("civilian_london_police_male_1_body");
  scripts\code\character::attachhead("heads_london_police", xmodelalias\heads_london_police::main());
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
  precachemodel("civilian_london_police_male_1_body");
  scripts\code\character::precachemodelarray(xmodelalias\heads_london_police::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_e2135c17a101148e":
      return xmodelalias\heads_london_police::main();
  }

  assert(0, "character_london_police_hivis do not have any xmodelalias");
}