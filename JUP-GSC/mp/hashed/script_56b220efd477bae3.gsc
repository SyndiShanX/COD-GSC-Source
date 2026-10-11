/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_56b220efd477bae3.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_a867838b0083b13b;

function private autoexec init() {
  character = #"hash_4e304a4bbd076697";

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
  self.animationarchetype = "zombie_disciple";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_disciple";
  self setModel("c_jup_zmb_disciple_body");
  self setclothtype(#"vestheavy");
  self setgeartype(#"millghtgr");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_disciple_body");
}

function precache_cpmp() {
  precache();
}