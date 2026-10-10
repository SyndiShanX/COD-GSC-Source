/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_london_police_hivis.gsc
**********************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\heads_london_police;
#namespace character_london_police_hivis;

function private autoexec init() {
  character = #"character_london_police_hivis";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    level.var_44bf7e31237b3073[%"character_london_police_hivis"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "soldier_pistol";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("civilian_london_police_male_1_body");
  scripts\code\character::attachhead("heads_london_police", xmodelalias\heads_london_police::main());
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"millghtgr");
  self function_1863f51c1339d80f(#"none");

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