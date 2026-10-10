/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22f3c99d87eadd06.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_66efc78efb2e5a80;

function private autoexec init() {
  character = #"hash_de2da048d1847214";

  if(!isDefined(level.fncharacter)) {
    level.fncharacter = [];
  }

  if(!isDefined(level.var_7d97144daa7995cd)) {
    level.var_7d97144daa7995cd = [];
  }

  if(!isDefined(level.var_44bf7e31237b3073)) {
    level.var_44bf7e31237b3073 = [];
  }

  level.fncharacter[character] = &main;

  if(issp()) {
    level.var_7d97144daa7995cd[character] = &precache_sp;
    return;
  }

  level.var_7d97144daa7995cd[character] = &precache_cpmp;
}

function main() {
  level.var_7d97144daa7995cd = undefined;
  self.animationarchetype = "capture_bot";
  self.voice = #"unitednations";
  self.bhasthighholster = 0;
  self.animtree = "capture_bot";
  self setModel("tag_origin");
  self setclothtype(#"vestlight");
  self function_8abe5a968cc3c220(#"none");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("tag_origin");
}

function precache_cpmp() {
  precache();
}