/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_23ec1e44b29c405a.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\c_jup_zmb_zombie_base_male_track_jacket_body_yz;
#using xmodelalias\c_jup_zmb_zombie_base_track_jacket_head_yz;
#namespace namespace_f214ddb248cddd98;

function private autoexec init() {
  character = #"hash_65cb7a17a97fd31c";

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
    level.var_44bf7e31237b3073[%"hash_4bec6e52eed85af3"] = &function_ecf17a96e49ab67;
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
  self function_6b0082dec4510b24("c_jup_zmb_zombie_base_male_track_jacket_body_yz", xmodelalias\c_jup_zmb_zombie_base_male_track_jacket_body_yz::main());
  scripts\code\character::attachhead("c_jup_zmb_zombie_base_track_jacket_head_yz", xmodelalias\c_jup_zmb_zombie_base_track_jacket_head_yz::main());
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
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_male_track_jacket_body_yz::main());
  scripts\code\character::precachemodelarray(xmodelalias\c_jup_zmb_zombie_base_track_jacket_head_yz::main());
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_42087e218eeb04db":
      return xmodelalias\c_jup_zmb_zombie_base_male_track_jacket_body_yz::main();
    case #"hash_d0cfad0b4b2bfbdf":
      return xmodelalias\c_jup_zmb_zombie_base_track_jacket_head_yz::main();
  }

  assert(0, "<dev string:x1c>");
}