/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d9cc5fe77a75b8f.gsc
***********************************************/

init() {
  level.quests = spawnStruct();
  level.quests._id_E856A73FD8EA75DA = _id_1731CB5CD2622B1F::_id_94129D143415DD0E();
  level.quests._id_97F1446AD8A01074 = _id_2178FF9C3F4F4F8B::_id_9CA6FDFF29CB3A3C();
  level.quests._id_C22E153D16CA1626 = _id_4DEBCC95581D610D::_id_B39A7A6C96A23D5C();
  level.quests._id_2C0317E3678062DF = _id_358B671C486A99DC::_id_44A5E4D28D29988E();
  level.quests._id_32360833E6C9081E = _id_152C31A5F2F8EDCA::_id_7AB35048DB0724DA();
  level.quests.activequests = _id_ADBBB96DB579B77C();
  _id_376C76DF4DA58945::_id_8AE98122B56FD357();
  _id_4E62208288203484::_id_9DEA44768C803C6C();
  thread _id_53690C91DAF3814B();
}

_id_ADBBB96DB579B77C() {
  activequests = [];

  foreach(_id_12461E617D024EF9 in level.quests._id_32360833E6C9081E) {
    if(_id_70A505820CD4CC89(_id_12461E617D024EF9))
      activequests = scripts\engine\utility::array_add(activequests, _id_12461E617D024EF9.id);
  }

  return activequests;
}

_id_70A505820CD4CC89(_id_12461E617D024EF9) {
  return 1;
}

_id_53690C91DAF3814B() {
  level endon("game_ended");

  while(!isDefined(level.players))
    waitframe();

  level waittill("prematch_done");

  foreach(_id_29B3D4262D4B443C in level.quests.activequests) {
    _id_12461E617D024EF9 = level.quests._id_32360833E6C9081E[_id_29B3D4262D4B443C];

    if(isDefined(_id_12461E617D024EF9._id_4F068020AAD821EE))
      [[_id_12461E617D024EF9._id_4F068020AAD821EE]](_id_12461E617D024EF9);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(!isbot(level.players[_id_AC0E594AC96AA3A8])) {
      level.players[_id_AC0E594AC96AA3A8] _id_7FB1F8838C595FF8();
      level.players[_id_AC0E594AC96AA3A8] childthread _id_175F1B70B7237BF7();
    }
  }
}

_id_7FB1F8838C595FF8() {
  if(!isDefined(self._id_32360833E6C9081E)) {
    self._id_32360833E6C9081E = spawnStruct();
    self._id_32360833E6C9081E._id_09F335B3AD4D4029 = [];
    self._id_32360833E6C9081E._id_C23FF2437D207131 = [];
  }

  return self._id_32360833E6C9081E;
}

_id_175F1B70B7237BF7() {
  self endon("disconnect");

  for(;;) {
    foreach(_id_29B3D4262D4B443C in level.quests.activequests) {
      _id_12461E617D024EF9 = level.quests._id_32360833E6C9081E[_id_29B3D4262D4B443C];

      if(!_id_D36905DC2969016E(_id_12461E617D024EF9)) {
        continue;
      }
      if(self[[_id_12461E617D024EF9.trigger]](_id_12461E617D024EF9))
        thread _id_06E14FC2FBF823F4(_id_12461E617D024EF9);
    }

    waitframe();
  }
}

_id_D36905DC2969016E(_id_12461E617D024EF9) {
  if(scripts\engine\utility::array_contains(self._id_32360833E6C9081E._id_09F335B3AD4D4029, _id_12461E617D024EF9.id))
    return 0;

  if(scripts\engine\utility::array_contains(self._id_32360833E6C9081E._id_C23FF2437D207131, _id_12461E617D024EF9.id))
    return 0;

  return 1;
}

_id_06E14FC2FBF823F4(_id_12461E617D024EF9) {
  _id_BC982FE3C1CC3537(_id_12461E617D024EF9);

  if(self[[_id_12461E617D024EF9._id_ED9438247C546A7D]](_id_12461E617D024EF9)) {
    self[[_id_12461E617D024EF9.reward]](_id_12461E617D024EF9);
    _id_3A8B184766B2BF97(_id_12461E617D024EF9);
  } else {}

  _id_CCD6E7E84529B79A(_id_12461E617D024EF9);
}

_id_BC982FE3C1CC3537(_id_12461E617D024EF9) {
  self._id_32360833E6C9081E._id_09F335B3AD4D4029 = scripts\engine\utility::array_add(self._id_32360833E6C9081E._id_09F335B3AD4D4029, _id_12461E617D024EF9.id);
}

_id_CCD6E7E84529B79A(_id_12461E617D024EF9) {
  self._id_32360833E6C9081E._id_09F335B3AD4D4029 = scripts\engine\utility::array_remove(self._id_32360833E6C9081E._id_09F335B3AD4D4029, _id_12461E617D024EF9.id);
}

_id_3A8B184766B2BF97(_id_12461E617D024EF9) {
  self._id_32360833E6C9081E._id_C23FF2437D207131 = scripts\engine\utility::array_add(self._id_32360833E6C9081E._id_C23FF2437D207131, _id_12461E617D024EF9.id);
}

_id_AFCB965B9DAD91CA(_id_12461E617D024EF9) {
  self._id_32360833E6C9081E._id_C23FF2437D207131 = scripts\engine\utility::array_remove(self._id_32360833E6C9081E._id_C23FF2437D207131, _id_12461E617D024EF9.id);
}