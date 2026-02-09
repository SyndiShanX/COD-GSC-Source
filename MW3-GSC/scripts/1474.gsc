/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1474.gsc
**************************************/

#using_animtree("generic_human");

main() {
  if(isDefined(anim._id_0FAA)) {
    return;
  }
  if(!isDefined(level._id_2106)) {
    level._id_2106 = [];
  }
  level._id_2106["militia"] = ::_id_3AAA;
  anim._id_0FAA = spawnStruct();
  anim._id_0FAA._id_3AA3 = animscripts\utility::_id_0C6D(%favela_chaotic_cornerl_hop90, %favela_chaotic_cornerl_high90, %favela_chaotic_cornerl_mid90);
  anim._id_0FAA._id_3AA4 = animscripts\utility::_id_0C6D(%favela_chaotic_cornerl_high45, %favela_chaotic_cornerl_mid45);
  anim._id_0FAA._id_3AA5 = % favela_chaotic_cornerl_grenade;
  anim._id_0FAA._id_3AA6 = animscripts\utility::_id_0C6D(%favela_chaotic_cornerr_med90, %favela_chaotic_cornerr_low90, %favela_chaotic_cornerr_high90);
  anim._id_0FAA._id_3AA7 = animscripts\utility::_id_0C6D(%favela_chaotic_cornerr_med45, %favela_chaotic_cornerr_low45, %favela_chaotic_cornerr_high45);
  anim._id_0FAA._id_3AA8 = % favela_chaotic_cornerr_grenade;
  anim._id_0FAA._id_0FAF = animscripts\utility::_id_0C6D(%favela_chaotic_standcover_firea, %favela_chaotic_standcover_fireb, %favela_chaotic_standcover_firec);
  anim._id_0FAA._id_0FB0 = animscripts\utility::_id_0C6D(%favela_chaotic_standcover_gunjama, %favela_chaotic_standcover_gunjamb);
  anim._id_0FAA._id_0FB1 = animscripts\utility::_id_0C6D(%favela_chaotic_standcover_grenadefirea);
  anim._id_0FAA._id_0FAB = animscripts\utility::_id_0C6D(%favela_chaotic_crouchcover_firea, %favela_chaotic_crouchcover_fireb, %favela_chaotic_crouchcover_firec);
  anim._id_0FAA._id_0FAC = animscripts\utility::_id_0C6D(%favela_chaotic_crouchcover_gunjama, %favela_chaotic_crouchcover_gunjamb);
  anim._id_0FAA._id_0FAD = animscripts\utility::_id_0C6D(%favela_chaotic_crouchcover_grenadefirea);
  _id_3AA9();
}

_id_3AA9() {
  animscripts\combat_utility::_id_238B(%favela_chaotic_cornerr_grenade, (52.4535, 10.107, 64.2898));
  animscripts\combat_utility::_id_238B(%favela_chaotic_cornerl_grenade, (19.1753, -18.9954, 49.3355));
  animscripts\combat_utility::_id_238B(%favela_chaotic_standcover_grenadefirea, (6.66898, -0.135193, 72.117));
  animscripts\combat_utility::_id_238B(%favela_chaotic_crouchcover_grenadefirea, (4.53614, -10.4574, 59.7186));
}

_id_3AAA() {
  if(self.type == "dog") {
    return;
  }
  self._id_1099 = 1;
  self.maxfaceenemydist = 256;

  if(animscripts\combat_utility::_id_23BD()) {
    return;
  }
  if(animscripts\utility::_id_0CEA(self.weapon)) {
    return;
  }
  self._id_24C1 = undefined;
  self._id_0F4D = 1;
  self._id_0F84 = 0.9;
  self._id_2311 = 1.0;
  self._id_20AF = 0.75;
  self._id_0FD9 = undefined;
}

_id_3AAB() {
  self._id_0F4D = undefined;
  self._id_0F84 = undefined;
  self._id_1099 = 0;
  self.maxfaceenemydist = 512;
  self._id_2311 = undefined;
}