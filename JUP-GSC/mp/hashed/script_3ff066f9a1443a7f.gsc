/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3ff066f9a1443a7f.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_b3f671d851067611;

function private autoexec init() {
  character = #"hash_462b221d539098ad";

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
  self.animationarchetype = "zombie_mimic_hvt";
  self.voice = #"unitedstates";
  self.bhasthighholster = 0;
  self.animtree = "zombie_mimic";
  self setModel("c_jup_zmb_mimic_hvt_emp");
  self attach("c_jup_zmb_mimic_head_hvt_emp", "", 1);
  self.headmodel = "c_jup_zmb_mimic_head_hvt_emp";
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
  precachemodel("c_jup_zmb_mimic_hvt_emp");
  precachemodel("c_jup_zmb_mimic_head_hvt_emp");
}

function precache_cpmp() {
  precache();
}