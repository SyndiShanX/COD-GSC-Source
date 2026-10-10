/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5f2b4d1352300441.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark;
#using xmodelalias\civilian_london_female_heads_skintone_dark;
#namespace namespace_647d7c4d4d8be603;

function private autoexec init() {
  character = #"hash_763689b539762467";

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
    level.var_44bf7e31237b3073[%"hash_b67875530cfda28"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react_female";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("c_jup_civilian_london_female_body_02_skintone_dark", xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main());
  scripts\code\character::attachhead("civilian_london_female_heads_skintone_dark", xmodelalias\civilian_london_female_heads_skintone_dark::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main());
  scripts\code\character::precachemodelarray(xmodelalias\civilian_london_female_heads_skintone_dark::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_32ab50c4a7c8d1ef":
      return xmodelalias\c_jup_civilian_london_female_body_02_skintone_dark::main();
    case #"hash_ce6562a382078a15":
      return xmodelalias\civilian_london_female_heads_skintone_dark::main();
  }

  assert(0, "c_jup_civ_london_female_02_skintone_dark do not have any xmodelalias");
}