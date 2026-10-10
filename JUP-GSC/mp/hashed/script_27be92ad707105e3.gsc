/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_27be92ad707105e3.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_suit_body_yz;
#using xmodelalias\c_jup_zmb_zombie_base_male_suit_head_yz;
#namespace namespace_e1677df186ae38d1;

function private autoexec init() {
  character = #"hash_6dbe727027b33df5";

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
    level.var_44bf7e31237b3073[%"hash_5ed61d02c6a1d7a2"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_suit_body_yz", xmodelalias\c_jup_zmb_zombie_base_male_suit_body_yz::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_male_suit_head_yz", xmodelalias\c_jup_zmb_zombie_base_male_suit_head_yz::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_suit_body_yz::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_suit_head_yz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_e9b04256a278f6b4":
      return xmodelalias\c_jup_zmb_zombie_base_male_suit_body_yz::main();
    case #"hash_36e45511bc1ca3fe":
      return xmodelalias\c_jup_zmb_zombie_base_male_suit_head_yz::main();
  }

  assert(0, "<dev string:x1c>");
}