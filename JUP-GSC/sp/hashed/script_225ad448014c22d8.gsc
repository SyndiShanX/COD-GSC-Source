/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_225ad448014c22d8.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_female_surge_2;
#using xmodelalias\heads_civilian_uk_female_surge_2;
#namespace namespace_548f168492b6ebaa;

function private autoexec init() {
  character = #"hash_8bfa6a7e191cdb46";

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
    level.var_44bf7e31237b3073[%"hash_6edeba2df2145589"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_uk_female_surge_2", xmodelalias\bodies_civilian_uk_female_surge_2::main());
  scripts\code\character::attachhead("heads_civilian_uk_female_surge_2", xmodelalias\heads_civilian_uk_female_surge_2::main());
  self setclothtype(#"nylon");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_female_surge_2::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_female_surge_2::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_34f1952b13ba1785":
      return xmodelalias\bodies_civilian_uk_female_surge_2::main();
    case #"hash_f9c54281ea2ec526":
      return xmodelalias\heads_civilian_uk_female_surge_2::main();
  }

  assert(0, "character_civilian_uk_female_surge_2 do not have any xmodelalias");
}