/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1343.gsc
**************************************/

#using_animtree("generic_human");

main() {
  self setModel("body_un_crew_flight_deck_a_dropship_captain");
  scripts\code\character::attachhead("un_crew_flight_deck_heads_male_pt1", _id_09F9::main());
  self.hatmodel = "body_un_crew_flight_deck_helmet_a_dropship_captain";
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
  precachemodel("body_un_crew_flight_deck_a_dropship_captain");
  scripts\code\character::precachemodelarray(_id_09F9::main());
  precachemodel("body_un_crew_flight_deck_helmet_a_dropship_captain");
}