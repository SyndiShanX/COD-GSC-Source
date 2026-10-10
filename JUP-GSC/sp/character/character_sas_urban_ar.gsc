/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\character\character_sas_urban_ar.gsc
***************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\bodies_sas_urban_ar;
#using xmodelalias\heads_sas_urban;
#namespace character_sas_urban_ar;

function private autoexec init() {
  character = #"character_sas_urban_ar";

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
    level.var_44bf7e31237b3073[%"character_sas_urban_ar"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"sas";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("bodies_sas_urban_ar", xmodelalias\bodies_sas_urban_ar::main());
  scripts\code\character::attachhead("heads_sas_urban", xmodelalias\heads_sas_urban::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\bodies_sas_urban_ar::main());
  scripts\code\character::precachemodelarray(xmodelalias\heads_sas_urban::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_e0df6324a16cc9e":
      return xmodelalias\bodies_sas_urban_ar::main();
    case #"hash_dc0bc755de61bf59":
      return xmodelalias\heads_sas_urban::main();
  }

  assert(0, "character_sas_urban_ar do not have any xmodelalias");
}