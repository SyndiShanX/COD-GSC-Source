/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5db293683cd723be.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_6e9da066759ce6d6;

function private autoexec init() {
  character = #"hash_1bc97d5b4044f5f2";

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
  self setModel("body_sp_ally_mex_sf_tier_1_3_1");
  self attach("head_sp_ally_mex_sf_tier_1_3_1", "", 1);
  self.headmodel = "head_sp_ally_mex_sf_tier_1_3_1";
  self setclothtype(#"cloth");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_ally_mex_sf_tier_1_3_1");
  precachemodel("head_sp_ally_mex_sf_tier_1_3_1");
}

function precache_cpmp() {
  precache();
}