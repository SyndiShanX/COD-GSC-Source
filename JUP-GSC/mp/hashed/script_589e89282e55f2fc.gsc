/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_589e89282e55f2fc.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz;
#namespace namespace_7307c5b8ecdbf680;

function private autoexec init() {
  character = #"hash_880d4518c4e12ae4";

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
    level.var_44bf7e31237b3073[%"hash_5af2cfb07ca0ad65"] = &function_ecf17a96e49ab67;
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
  self setModel("c_jup_zmb_zombie_base_male_shortsleeve_body_yz");
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_male_shortsleeve_head_yz", xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main());
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
  precachemodel("c_jup_zmb_zombie_base_male_shortsleeve_body_yz");
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_9f81095ee5027585":
      return xmodelalias\c_jup_zmb_zombie_base_male_shortsleeve_head_yz::main();
  }

  assert(0, "<dev string:x1c>");
}