/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3874cfa9b4b053cf.gsc
*************************************************/

#using scripts\common\utility;
#namespace namespace_8be01b33c6501993;

function private autoexec init() {
  character = #"hash_41bf12cef4f8205f";

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
  self.animationarchetype = "juggernaut";
  self.voice = #"alqatala";
  self.bhasthighholster = 0;
  self.animtree = "generic_human";
  self setModel("body_sp_opforce_aq_jugg_basebody");
  self attach("head_sp_opforce_aq_jugg", "", 1);
  self.headmodel = "head_sp_opforce_aq_jugg";
  self setclothtype(#"vestheavy");
  self function_8abe5a968cc3c220(#"milhvygr");
  self function_1863f51c1339d80f(#"none");

  if(issentient(self)) {
    self sethitlocdamagetable(%"hash_635afa6edffbf00b");
  }
}

function precache() {}

function precache_sp() {
  precache();
  precachemodel("body_sp_opforce_aq_jugg_basebody");
  precachemodel("head_sp_opforce_aq_jugg");
}

function precache_cpmp() {
  precache();
}