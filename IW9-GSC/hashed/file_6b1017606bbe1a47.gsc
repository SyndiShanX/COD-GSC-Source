/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6b1017606bbe1a47.gsc
***********************************************/

_id_348924356F8BAD24() {
  self endon("disconnect");
  self._id_6C5A93F08DD4C17A = 0;

  while(!self issprinting())
    waitframe();

  self._id_6C5A93F08DD4C17A = 1;
}

_id_D4A746782D28E9AD() {
  self endon("disconnect");
  self._id_56E1F146CC6F124F = 0;

  while(!self issupersprinting())
    waitframe();

  self._id_56E1F146CC6F124F = 1;
}

_id_4CF7B50740F57F7B() {
  self endon("disconnect");
  self._id_F01DCAAB58C1AB99 = 0;

  while(!self _meth_038932CC1EF28756())
    waitframe();

  self._id_F01DCAAB58C1AB99 = 1;
}

_id_EE0F48A23C219539(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_6C5A93F08DD4C17A)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_4DFBC95B23A556F4(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_56E1F146CC6F124F)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_768AAA759077DF62(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_F01DCAAB58C1AB99)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_33749FEFAB503510(_id_847B006DECFBCE4F) {
  self endon("disconnect");
  self._id_7CC4914A032A2DF3 = 0;
  self.init_pos = self.origin;
  dist = 0;

  while(dist < _id_847B006DECFBCE4F * 10) {
    dist = distance(self.origin, self.init_pos);
    wait 0.5;
  }

  self._id_7CC4914A032A2DF3 = 1;
}

_id_87682C85D41C2E13(_id_7B59B41B01684053, _id_847B006DECFBCE4F) {
  self endon("disconnect");
  self._id_919769D433A608F3 = 0;
  dist = _id_847B006DECFBCE4F * 10;

  while(dist > _id_847B006DECFBCE4F) {
    dist = distance(self.origin, _id_7B59B41B01684053);
    wait 0.2;
  }

  self._id_919769D433A608F3 = 1;
  return;
}

_id_105BD25B72F6EA55(_id_077B9E4B599269EB) {
  self endon("disconnect");
  self._id_C3661355A5B3083D = 0;
  _id_DB1111B1B4C72B10 = anglesToForward(self getplayerangles(0));
  _id_DB1111B1B4C72B10 = vectorNormalize(_id_DB1111B1B4C72B10);

  for(;;) {
    _id_73D0C62EE90EF3C3 = anglesToForward(self getplayerangles(0));
    _id_73D0C62EE90EF3C3 = vectorNormalize(_id_73D0C62EE90EF3C3);
    _id_DA41DD6F879889D2 = scripts\engine\math::anglebetweenvectors(_id_73D0C62EE90EF3C3, _id_DB1111B1B4C72B10);

    if(isDefined(_id_DA41DD6F879889D2) && _id_DA41DD6F879889D2 >= _id_077B9E4B599269EB) {
      self._id_C3661355A5B3083D = 1;
      break;
    }

    waitframe();
  }

  return;
}

_id_4F94F7B207E54B3F(_id_847B006DECFBCE4F, _id_077B9E4B599269EB) {
  self endon("disconnect");
  self._id_E36371BC08C4F3E7 = 0;
  _id_A67DB5CF006FC19E(_id_847B006DECFBCE4F, _id_077B9E4B599269EB);
  return;
}

_id_A67DB5CF006FC19E(_id_847B006DECFBCE4F, _id_077B9E4B599269EB) {
  self endon("disconnect");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  self._id_E36371BC08C4F3E7 = 0;
  init_pos = self.origin;
  _id_DB1111B1B4C72B10 = anglesToForward(self getplayerangles(0));

  for(;;) {
    _id_B6C7F877FFDDE154 = distance(self.origin, init_pos);
    _id_73D0C62EE90EF3C3 = anglesToForward(self getplayerangles(0));

    if(_id_73D0C62EE90EF3C3 != _id_DB1111B1B4C72B10) {
      _id_DA41DD6F879889D2 = scripts\engine\math::anglebetweenvectorsunit(_id_73D0C62EE90EF3C3, _id_DB1111B1B4C72B10);

      if(isDefined(_id_DA41DD6F879889D2) && isDefined(_id_B6C7F877FFDDE154) && _id_DA41DD6F879889D2 >= _id_077B9E4B599269EB && _id_B6C7F877FFDDE154 > _id_847B006DECFBCE4F) {
        self._id_E36371BC08C4F3E7 = 1;
        break;
      }
    }

    waitframe();
  }
}

_id_7C4B6588A387E2D5(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_7CC4914A032A2DF3)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_E58BB74EC5F54731(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_C3661355A5B3083D)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_E7A33BFB4CBA7633(_id_A324C7CBBC4F2E30, _id_6E8B41E0A5648F49, _id_EECB169540A9F109) {
  self endon("disconnect");
  _id_72388592690A2F9E = gettime();
  _id_A324C7CBBC4F2E30 = _id_A324C7CBBC4F2E30 * 1000;

  while(!istrue(self._id_E36371BC08C4F3E7)) {
    if(gettime() - _id_72388592690A2F9E >= _id_A324C7CBBC4F2E30) {
      _id_72388592690A2F9E = gettime();
      [[_id_EECB169540A9F109]](self);
    }

    waitframe();
  }

  [[_id_6E8B41E0A5648F49]](self);
}

_id_F656AD666EDA6D08() {
  result = self isonground();
  return self isonground();
}