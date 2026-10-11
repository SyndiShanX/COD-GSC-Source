/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_e9e8090769c484c.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_72ebd206079afbd8;

function private autoexec init() {
  character = #"hash_978425de95547604";

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
  self.animationarchetype = "warlord_allforone";
  self.voice = #"shadowcompany";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_sp_opforce_pmc_1_1");
  self attach("head_sp_opforce_pmc_1_1", "", 1);
  self.headmodel = "head_sp_opforce_pmc_1_1";
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
  precachemodel("body_sp_opforce_pmc_1_1");
  precachemodel("head_sp_opforce_pmc_1_1");
}

function precache_cpmp() {
  precache();
}