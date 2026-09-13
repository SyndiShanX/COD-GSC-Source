/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3797b5e38af8666f.gsc
***********************************************/

_id_F044486D3882C43D(asmname, statename, params) {
  self animmode("noclip");
  self orientmode("face current");

  if(isDefined(self.scriptedarrivalent))
    self.scriptedarrivalent delete();
}

_id_912821ADBD16D04C() {}

_id_E3189C04775F3A0F() {}

_id_DC875C74AA7545F4(asmname, statename, params) {
  if(!isDefined(self._blackboard._id_40A41C70824FA4C4))
    self._blackboard._id_40A41C70824FA4C4 = "a";

  if(self._blackboard._id_40A41C70824FA4C4 == "b")
    return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, "a_to_b");
  else
    return _id_4E1D4DD23699A8A4::_id_A0DFEEA159AA7F64(asmname, statename, "b_to_a");
}

_id_E9F61F14D08FCD61(asmname, statename, params) {
  return 0;
}

_id_092087655510B0E0(asmname, statename, params) {
  return 0;
}

_id_6D55FDDF9C7024E2(asmname, statename, params) {
  if(isDefined(self._id_A70672E669CA7F00))
    self forceteleport(self.origin, self._id_A70672E669CA7F00);

  _id_4E1D4DD23699A8A4::_id_59308D53CABCDFDB(asmname, statename, params);
}

_id_56C32E6F7B6ED8ED(asmname, statename, params) {
  self._id_A70672E669CA7F00 = undefined;
  _id_4E1D4DD23699A8A4::_id_B6AF4ADE50626E90(asmname, statename, params);
}