/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7ad262e5056e0dec.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_676958f2d031ef1e;

function private autoexec init() {
  character = #"hash_d63cd1f3d39f73a";

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
  self.voice = #"unitedstates";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_mp_milsim_navy_frogman_1_1");
  self attach("head_mp_milsim_navy_frogman_1_1", "", 1);
  self.headmodel = "head_mp_milsim_navy_frogman_1_1";
  self setclothtype(#"vestlight");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_mp_milsim_navy_frogman_1_1");
  precachemodel("head_mp_milsim_navy_frogman_1_1");
}

function precache_cpmp() {
  precache();
}