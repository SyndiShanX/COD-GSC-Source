/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_619b2bdd818c427d.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_de41a4e7c0568035;

function private autoexec init() {
  character = #"hash_6ab583060b8d75a9";

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
  self.animationarchetype = "zombie_disciple_pet";
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