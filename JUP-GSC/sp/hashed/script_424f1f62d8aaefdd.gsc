/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_424f1f62d8aaefdd.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_9caca9d89d8279f5;

function private autoexec init() {
  character = #"hash_7644e7b344228e99";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.fncharacterprecache)) {
    level.fncharacterprecache = [];
  }

  if(!isDefined(level.fncharacterxmodelalias)) {
    level.fncharacterxmodelalias = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.fncharacterprecache[character] = &precache_sp;
    return;
  }

  level.fncharacterprecache[character] = &precache_cpmp;
}

function main() {
  level.fncharacterprecache = undefined;
  self.animationarchetype = "soldier";
  self.voice = #"shadowcompany";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_opforce_shadow_company_armored_smg_1_1");
  self attach("head_sp_opforce_shadow_company_armored_smg_1_1", "", 1);
  self.headmodel = "head_sp_opforce_shadow_company_armored_smg_1_1";
  self setclothtype(#"nylon");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_opforce_shadow_company_armored_smg_1_1");
  precachemodel("head_sp_opforce_shadow_company_armored_smg_1_1");
}

function precache_cpmp() {
  precache();
}