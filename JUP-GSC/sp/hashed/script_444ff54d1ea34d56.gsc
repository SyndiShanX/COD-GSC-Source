/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_444ff54d1ea34d56.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_asm_female_4;
#using xmodelalias\heads_civilian_asm_female_4;
#namespace namespace_2e95a3b6544dff76;

function private autoexec init() {
  character = #"hash_e49590b611e23412";

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
    level.var_44bf7e31237b3073[%"hash_a9cfc96b687efb7"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_loco";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_asm_female_4", xmodelalias\bodies_civilian_asm_female_4::main());
  scripts\code\character::attachhead("heads_civilian_asm_female_4", xmodelalias\heads_civilian_asm_female_4::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_asm_female_4::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_asm_female_4::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_331b224a38c32097":
      return xmodelalias\bodies_civilian_asm_female_4::main();
    case #"hash_c28e57e15f6edd2":
      return xmodelalias\heads_civilian_asm_female_4::main();
  }

  assert(0, "character_civilian_ams_female_4 do not have any xmodelalias");
}