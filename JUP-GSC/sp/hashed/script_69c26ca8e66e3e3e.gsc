/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_69c26ca8e66e3e3e.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_russian_female_body_flashback;
#using xmodelalias\civilian_russian_female_head_flashback;
#namespace namespace_70244ee2196d648;

function private autoexec init() {
  character = #"hash_ac0a208e540f962c";

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
    level.var_44bf7e31237b3073[%"hash_643e7f011a669a97"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"alqatalafemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civilian_russian_female_body_flashback", xmodelalias\c_jup_civilian_russian_female_body_flashback::main());
  scripts\code\character::attachhead("civilian_russian_female_head_flashback", xmodelalias\civilian_russian_female_head_flashback::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civilian_russian_female_body_flashback::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_russian_female_head_flashback::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_f73280ffc66c4c2c":
      return xmodelalias\c_jup_civilian_russian_female_body_flashback::main();
    case #"hash_2a378a2028ce50fc":
      return xmodelalias\civilian_russian_female_head_flashback::main();
  }

  assert(0, "c_jup_civ_russian_female_flashback do not have any xmodelalias");
}