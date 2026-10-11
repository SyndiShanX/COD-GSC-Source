/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_47be1b980187d261.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_3ca648570b3beac5;

function private autoexec init() {
  character = #"hash_872aca792dc58241";

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
  self setModel("body_sp_opforce_pmc_with_radio_1_1");
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
  precachemodel("body_sp_opforce_pmc_with_radio_1_1");
  precachemodel("head_sp_opforce_pmc_no_goggles_3_1");
}

function precache_cpmp() {
  precache();
}