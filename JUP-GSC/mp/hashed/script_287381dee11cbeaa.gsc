/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_287381dee11cbeaa.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_34b26167a4b0587a;

function private autoexec init() {
  character = #"hash_7e214392e7d308c6";

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
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_c_jup_zmb_npc_fletcher");
  self attach("head_c_jup_zmb_fletcher", "", 1);
  self.headmodel = "head_c_jup_zmb_fletcher";
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
  precachemodel("body_c_jup_zmb_npc_fletcher");
  precachemodel("head_c_jup_zmb_fletcher");
}

function precache_cpmp() {
  precache();
}