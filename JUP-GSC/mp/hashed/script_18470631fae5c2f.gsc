/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_18470631fae5c2f.gsc
************************************************/

#using scripts\common\utility;
#namespace namespace_da34989bc6db10c1;

function private autoexec init() {
  character = #"hash_137166e713c3e7d";

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
  self.animationarchetype = "zombie_mimic";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_mimic";
  self setModel("c_jup_zmb_mimic_body");
  self attach("c_jup_zmb_mimic_head", "", 1);
  self.headmodel = "c_jup_zmb_mimic_head";
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
  precachemodel("c_jup_zmb_mimic_body");
  precachemodel("c_jup_zmb_mimic_head");
}

function precache_cpmp() {
  precache();
}