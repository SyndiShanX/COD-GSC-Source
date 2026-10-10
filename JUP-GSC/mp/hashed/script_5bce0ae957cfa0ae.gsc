/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5bce0ae957cfa0ae.gsc
*************************************************/

#using scripts\code\character;
#using scripts\common\utility;
#using xmodelalias\body_iw9_aq_shotgun_1_white;
#namespace namespace_200d66782a62552c;

function private autoexec init() {
  character = #"hash_bb87ddf37a92600";

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
    level.var_44bf7e31237b3073[%"hash_6d7c9cadb6e10747"] = &function_ecf17a96e49ab67;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "rebel";
  self.voice = #"alqatala";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self function_6b0082dec4510b24("body_iw9_aq_shotgun_1_white", xmodelalias\body_iw9_aq_shotgun_1_white::main());
  self attach("head_sp_opforce_al_qatala_shotgun", "", 1);
  self.headmodel = "head_sp_opforce_al_qatala_shotgun";
  self setclothtype(#"flowing");
  self function_8abe5a968cc3c220(#"milmedgr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  scripts\code\character::precachemodelarray(xmodelalias\body_iw9_aq_shotgun_1_white::main());
  precachemodel("head_sp_opforce_al_qatala_shotgun");
}

function precache_cpmp() {
  precache();
}

function function_ecf17a96e49ab67(xmodelalias) {
  switch (xmodelalias) {
    case #"hash_73b376cad585f69f":
      return xmodelalias\body_iw9_aq_shotgun_1_white::main();
  }

  assert(0, "<dev string:x1c>");
}