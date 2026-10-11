/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c53c4276223d748.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_19618770ea797a04;

function private autoexec init() {
  character = #"hash_6ff7915d27301448";

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
  self.animationarchetype = "warlord_chemist";
  self.voice = #"unitednationsfemale";
  self.bhasthighholster = 1;
  self.animtree = "generic_human";
  self setModel("body_c_jup_ext_chemist");
  self attach("head_c_jup_ext_chemist", "", 1);
  self.headmodel = "head_c_jup_ext_chemist";
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
  precachemodel("body_c_jup_ext_chemist");
  precachemodel("head_c_jup_ext_chemist");
}

function precache_cpmp() {
  precache();
}