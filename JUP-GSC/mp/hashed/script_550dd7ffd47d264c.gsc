/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_550dd7ffd47d264c.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_b4a777df1439f346;

function private autoexec init() {
  character = #"hash_f07993dc95ab63b2";

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
  self.animationarchetype = "zombie_abom_mega";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_abom";
  self setModel("c_jup_zmb_abomination_megabomb_body");
  self setclothtype(#"vestheavy");
  self setgeartype(#"none");
  self setbagtype(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_16c36cf98afe63cd");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("c_jup_zmb_abomination_megabomb_body");
}

function precache_cpmp() {
  precache();
}