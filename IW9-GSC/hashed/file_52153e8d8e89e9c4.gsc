/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_52153e8d8e89e9c4.gsc
***********************************************/

_id_DB3156CAB6C25766(_id_EB8EB3B902492463) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("gulag_start", _id_0E73F82F58EB3128);
  self[[_id_EB8EB3B902492463]](_id_0E73F82F58EB3128);
}

_id_7F25D3119F627905(_id_5FE0EFC8A09CABE4) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("enter_gulag", _id_0E73F82F58EB3128);
  self[[_id_5FE0EFC8A09CABE4]](_id_0E73F82F58EB3128);
}

_id_B3E2A55102596658(_id_70FD3674CA1DF0D5) {
  self endon("disconnect");
  self endon("pull_out_of_gulag");
  self waittill("beginNewFight");
  self[[_id_70FD3674CA1DF0D5]]();
}

_id_8EFD0509E8D63CA9(_id_03A31777466550E0) {
  self endon("disconnect");
  msg = scripts\engine\utility::waittill_any_return_4("gulag_end", "pull_out_of_gulag", "gulagLost", "death");
  self[[_id_03A31777466550E0]](msg == "gulag_end" || msg == "pull_out_of_gulag");
}

_id_88B1AD5E2A6D9E6D(_id_E13F125AC9E102FC) {
  self endon("disconnect");
  self endon("beginNewFight");
  scripts\engine\utility::waittill_any_return_2("gulag_end", "pull_out_of_gulag");
  self[[_id_E13F125AC9E102FC]]();
}