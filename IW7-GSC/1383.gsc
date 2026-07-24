/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1383.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09D3::main());
  scripts\code\character::attachhead("un_crew_flight_deck_heads_male_pt2", _id_09FA::main());
  self.hatmodel = "body_un_crew_flight_deck_helmet_a";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "soldier";
  self.voice = "unitednations";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09D3::main());
  scripts\code\character::precachemodelarray(_id_09FA::main());
  precachemodel("body_un_crew_flight_deck_helmet_a");
}