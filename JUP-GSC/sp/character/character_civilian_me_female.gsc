/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_civilian_me_female.gsc
*********************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\civilian_me_female_bodies;
#using xmodelalias\civilian_me_female_heads;
#namespace character_civilian_me_female;

function private autoexec init() {
  character = #"character_civilian_me_female";

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
    level.var_44bf7e31237b3073[%"character_civilian_me_female"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"fsafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("civilian_me_female_bodies", xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::attachhead("civilian_me_female_heads", xmodelalias\civilian_me_female_heads::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_bodies::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_me_female_heads::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_2ea77bff67edb529":
      return xmodelalias\civilian_me_female_bodies::main();
    case #"hash_a5e3635a140ed050":
      return xmodelalias\civilian_me_female_heads::main();
  }

  assert(0, "character_civilian_me_female do not have any xmodelalias");
}