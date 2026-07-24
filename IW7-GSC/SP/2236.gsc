/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2236.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_marines_medium_d_mars_bloody");
  self attach("head_sc_male_12_bloody", "", 1);
  self.headmodel = "head_sc_male_12_bloody";
  self.hatmodel = "helmet_un_marines";
  self attach(self.hatmodel);
  self._id_A489 = "pack_un_jackal_pilots";
  self attach(self._id_A489);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "marine";
  self.voice = "unitednations";
  self _meth_82C6("vestlight");

  if(issentient(self))
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");

  self._id_8E1A = level._id_7649["iw7/core/human/helmet_un_marines_broken"];
  self _meth_83D0(#animtree);
}

precache() {
  precachemodel("body_un_marines_medium_d_mars_bloody");
  precachemodel("head_sc_male_12_bloody");
  precachemodel("helmet_un_marines");
  precachemodel("pack_un_jackal_pilots");
  level._id_7649["iw7/core/human/helmet_un_marines_broken"] = loadfx("vfx/iw7/core/human/helmet_un_marines_broken.vfx");
}