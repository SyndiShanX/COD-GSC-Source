/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_sacrificial_heart.gsc
*************************************************/

initplayersacrificialheart() {
  setplayersacrificialheart(0);
}

updateplayersacrificialheartdisplay() {
  self setclientomnvar("zm_sacrificial_heart", int(getplayersacrificialheart()));
}

getplayersacrificialheart() {
  return self.n_sacrificial_heart;
}

setplayersacrificialheart(var_0) {
  self.n_sacrificial_heart = int(var_0);
  updateplayersacrificialheartdisplay();
}

giveplayersacrificialheart(var_0) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 1);
  self.n_sacrificial_heart = self.n_sacrificial_heart + var_0;
  updateplayersacrificialheartdisplay();
}

takeplayersacrificialheart(var_0) {
  var_0 = scripts\cp\utility::_id_459B(var_0, 1);
  self.n_sacrificial_heart = self.n_sacrificial_heart - var_0;
  updateplayersacrificialheartdisplay();
  _id_06FA::update_achievement_stat("ZM_BAKERS_DOZEN", "hearts_sacrificed", var_0);
}