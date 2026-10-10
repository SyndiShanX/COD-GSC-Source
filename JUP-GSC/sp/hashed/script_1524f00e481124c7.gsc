/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1524f00e481124c7.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_civilian_uk_girl_surge_1;
#using xmodelalias\heads_civilian_uk_girl_surge_1;
#namespace namespace_1f60831f63fa2689;

function private autoexec init() {
  character = #"hash_f89699d778b70e3d";

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
    level.var_44bf7e31237b3073[%"hash_72db04c57a3acfc6"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "civilian_react";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_civilian_uk_girl_surge_1", xmodelalias\bodies_civilian_uk_girl_surge_1::main());
  scripts\code\character::attachhead("heads_civilian_uk_girl_surge_1", xmodelalias\heads_civilian_uk_girl_surge_1::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_civilian_uk_girl_surge_1::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_civilian_uk_girl_surge_1::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_96fb56b0990b0efa":
      return xmodelalias\bodies_civilian_uk_girl_surge_1::main();
    case #"hash_bfb85bbaed0f89fd":
      return xmodelalias\heads_civilian_uk_girl_surge_1::main();
  }

  assert(0, "character_civilian_uk_girl_surge_1 do not have any xmodelalias");
}