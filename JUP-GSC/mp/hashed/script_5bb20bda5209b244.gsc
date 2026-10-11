/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5bb20bda5209b244.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_82a20a037e593160;

function private autoexec init() {
  character = #"hash_e66f7a7a7c98f67c";

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
  self setModel("body_sp_ally_mex_sf_b");
  self attach("head_sp_ally_mex_sf_b", "", 1);
  self.headmodel = "head_sp_ally_mex_sf_b";
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
  precachemodel("body_sp_ally_mex_sf_b");
  precachemodel("head_sp_ally_mex_sf_b");
}

function precache_cpmp() {
  precache();
}