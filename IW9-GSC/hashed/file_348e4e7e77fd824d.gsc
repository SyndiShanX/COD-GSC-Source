/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_348e4e7e77fd824d.gsc
***********************************************/

_id_1EFD3EF097BC71EF(player, _id_4FC3EBD0A2F2E41F, _id_4B930E7C10433564) {
  thread _id_52D6054E90ED0551(player, _id_4FC3EBD0A2F2E41F, _id_4B930E7C10433564);
}

_id_52D6054E90ED0551(player, _id_4FC3EBD0A2F2E41F, _id_4B930E7C10433564) {
  self endon("entitydeleted");
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);

    if((!_id_4FC3EBD0A2F2E41F || player scripts\mp\utility\player::isplayerads()) && attacker == player) {
      if(isDefined(_id_4B930E7C10433564))
        self[[_id_4B930E7C10433564]](player);

      return;
    }
  }
}

_id_C3D4E6976E184EC2(_id_B6024BB6422C13B9) {
  self notify("end_prev_track_damage_thread");
  thread _id_EB85B6162A88AC9E(_id_B6024BB6422C13B9);
}

_id_9D7F826BC4785692() {
  totalhealth = self.health;

  if(isDefined(self.armorhealth))
    totalhealth = totalhealth + self.armorhealth;

  return totalhealth;
}

_id_EB85B6162A88AC9E(_id_B6024BB6422C13B9) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_prev_track_damage_thread");
  _id_FF8B42CE299A8057 = _id_9D7F826BC4785692();
  self.wasdamaged = 0;
  _id_72388592690A2F9E = gettime();
  _id_B6024BB6422C13B9 = _id_B6024BB6422C13B9 * 1000;

  for(;;) {
    currenthealth = _id_9D7F826BC4785692();

    if(currenthealth < _id_FF8B42CE299A8057) {
      self.wasdamaged = 1;
      _id_72388592690A2F9E = gettime();
    } else if(gettime() - _id_72388592690A2F9E >= _id_B6024BB6422C13B9) {
      self.wasdamaged = 0;
      _id_72388592690A2F9E = gettime();
    }

    _id_FF8B42CE299A8057 = currenthealth;
    waitframe();
  }
}

_id_ECC429915026F615(_id_B6024BB6422C13B9) {
  self notify("end_prev_track_shooting_thread");
  thread _id_E85CB49DD16EC893(_id_B6024BB6422C13B9);
}

_id_E85CB49DD16EC893(_id_B6024BB6422C13B9) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_prev_track_shooting_thread");
  self._id_67E7C335D2E9F327 = 0;
  _id_72388592690A2F9E = gettime();
  _id_B6024BB6422C13B9 = _id_B6024BB6422C13B9 * 1000;

  for(;;) {
    if(self isshooting()) {
      self._id_67E7C335D2E9F327 = 1;
      _id_72388592690A2F9E = gettime();
    } else if(gettime() - _id_72388592690A2F9E >= _id_B6024BB6422C13B9) {
      self._id_67E7C335D2E9F327 = 0;
      _id_72388592690A2F9E = gettime();
    }

    waitframe();
  }
}