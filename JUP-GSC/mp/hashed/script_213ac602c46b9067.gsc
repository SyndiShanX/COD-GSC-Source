/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_213ac602c46b9067.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz;
#namespace namespace_67e292a194f8d3fd;

function private autoexec init() {
  character = #"hash_ac69046634566f21";

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
    level.var_44bf7e31237b3073[%"hash_5ac6c58ea19acf36"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "zombie_base";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_base";
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_long_shirt_body_yz", xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_long_shirt_head_yz", xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main());
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_485891bb076e14f0":
      return xmodelalias\c_jup_zmb_zombie_base_male_long_shirt_body_yz::main();
    case #"hash_b9da372d17774d90":
      return xmodelalias\c_jup_zmb_zombie_base_long_shirt_head_yz::main();
  }

  assert(0, "<dev string:x1c>");
}