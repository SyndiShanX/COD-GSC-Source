/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_447fd33040331bee.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_fbbb7653df37fc26;

function private autoexec init() {
  character = #"hash_1ae8f329a30ab62a";

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
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_sp_opforce_pmc_with_strap_1_1");
  self attach("head_sp_opforce_pmc_no_goggles_3_1", "", 1);
  self.headmodel = "head_sp_opforce_pmc_no_goggles_3_1";
  self setclothtype(#"vestlight");
  self setgeartype(#"milmedgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_opforce_pmc_with_strap_1_1");
  precachemodel("head_sp_opforce_pmc_no_goggles_3_1");
}

function precache_cpmp() {
  precache();
}