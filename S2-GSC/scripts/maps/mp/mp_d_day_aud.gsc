/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_d_day_aud.gsc
********************************************/

main() {
  _id_7BBE();
}

_id_7BBE() {
  _id_0378::_id_8DC7("mp_intro_dday_plane_flyover", ::_id_64FF);
}

_id_64FF(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  waitframe();

  if(var_1 == 11) {
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_01_allies", "allies", var_2);
    wait 1.2;
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_01_axis", "axis", var_2);
  }

  if(var_1 == 101) {
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_02_allies", "allies", var_2);
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_02_axis", "axis");
  }

  if(var_1 == 105) {
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_03_allies", "allies", var_2);
  }

  if(var_1 == 104) {
    _id_0380::_id_6844("mp_dday_intro_fly_bombers_03_axis", "axis", var_2);
  }

  if(var_1 == 13) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_01_allies", "allies", var_2);
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_01_axis", "axis", var_2);
  }

  if(var_1 == 4) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_02_allies", "allies", var_2);
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_02_axis", "axis", var_2);
  }

  if(var_1 == 3) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_03_allies", "allies", var_2);
  }

  if(var_1 == 5) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_04_axis", "axis", var_2);
  }

  if(var_1 == 8) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_04_allies", "allies", var_2);
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_05_axis", "axis", var_2);
  }

  if(var_1 == 7) {
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_05_allies", "allies", var_2);
    _id_0380::_id_6844("mp_dday_intro_fly_fighters_03_axis", "axis", var_2);
  }
}