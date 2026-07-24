/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 1338.gsc
**************************************/

#using_animtree("generic_human");

main() {
  scripts\code\character::setmodelfromarray(_id_09D5::main());
  scripts\code\character::attachhead("un_crew_flight_deck_heads_female", _id_09F8::main());
  self.hatmodel = "body_un_crew_flight_deck_female_helmet_a_director";
  self attach(self.hatmodel);
  self._id_1FEC = "generic_human";
  self._id_1FA8 = "hero_salter";
  self.voice = "unitednationsfemale";
  self _meth_82C6("cloth");

  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable/ai_lochit_dmgtable");
  }

  self _meth_83D0(#animtree);
}

precache() {
  scripts\code\character::precachemodelarray(_id_09D5::main());
  scripts\code\character::precachemodelarray(_id_09F8::main());
  precachemodel("body_un_crew_flight_deck_female_helmet_a_director");
}