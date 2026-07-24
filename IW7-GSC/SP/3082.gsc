/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3082.gsc
**************************************/

_id_35A6(var_0) {
  self._id_10264 = 1;
  self.bt._id_E5FA = 1;
  _id_0A16::_id_98D2();
  _id_0C09::_id_97F9();
  _id_0C0B::_id_98DD();
  self._id_290A = 0;
  self.grenadeweapon = "c8_grenade";
  self.meleerangesq = 128;
  self.meleechargedist = 128;
  self.meleechargedistvsplayer = 128;
  self.meleechargedistreloadmultiplier = 1;
  self._id_B627 = 36;
  self.meleeactorboundsradius = 60;
  self.acceptablemeleefraction = 0.98;
  self._id_B5DA = 1;
  self._id_B64F = 400;
  self.fnismeleevalid = _id_0C08::_id_35AD;
  self.pushable = 0;
  _id_170A();
  return anim.success;
}

_id_170A() {
  self.bt._id_ACB4 = [];
  self.bt._id_ACB4[self.bt._id_ACB4.size] = _id_4911("j_clavicle_inner_ri");
  self.bt._id_ACB4[self.bt._id_ACB4.size] = _id_4911("j_clavicle_inner_le");
  self.bt._id_71C9 = ::_id_E138;
}

_id_4911(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1 linkTo(self, var_0, (10, 0, 0), (0, 0, 0));

  if(self.team == "axis")
    playFXOnTag(level._id_7649["c12_enemy_light"], var_1, "tag_origin");
  else
    playFXOnTag(level._id_7649["c12_ally_light"], var_1, "tag_origin");

  return var_1;
}

_id_E138() {
  if(isDefined(self.bt._id_ACB4)) {
    foreach(var_1 in self.bt._id_ACB4) {
      if(isDefined(var_1))
        var_1 delete();
    }
  }
}