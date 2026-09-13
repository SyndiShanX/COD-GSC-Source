/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3f770f4f52b1ecf6.gsc
***********************************************/

_id_1BDC76359002A87D() {}

_id_6C1E0EB333FEE7FE() {
  thread _id_D2C67316E3340D42();
  thread deathcleanup();
  self endon("death");
  self endon("disconnect");
  self endon("showing_final_killcam");
  childthread _id_6A4D394E7F9FC34E();
}

_id_6A4D394E7F9FC34E() {
  for(;;) {
    if(isDefined(self.currentweapon) && _id_A48875A04BEDE9A6(self.currentweapon)) {
      if(isDefined(level._id_CA0F41FE9610167A) && level._id_CA0F41FE9610167A)
        childthread _id_844DC249EF1B3A5E();
      else
        childthread _id_48C1BB804931BB07();

      childthread _id_808CD37A5A40862D();
    }

    self waittill("weapon_change");
  }
}

_id_A48875A04BEDE9A6(weaponobj) {
  if(isDefined(weaponobj) && isDefined(weaponobj.scope) && scripts\engine\utility::string_starts_with(weaponobj.scope, "snscope_drop"))
    return 1;

  return 0;
}

_id_48C1BB804931BB07() {
  self endon("weapon_change");
  contents = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  for(;;) {
    waitframe();

    if(!self playerads()) {
      continue;
    }
    start = self getEye();
    end = scripts\engine\trace::ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["position"];
    distance = length(start - end);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

_id_844DC249EF1B3A5E() {
  self endon("weapon_change");
  thread _id_46D948B40CC362DC();
  contents = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 0, 0, 0, 0);

  for(;;) {
    waitframe();

    while(isDefined(level._id_8D206297C3CB29D4))
      waitframe();

    thread _id_3E83A8605613947C(contents);

    while(!isDefined(level._id_8D206297C3CB29D4))
      waitframe();

    level notify("target_sighted");
  }
}

_id_3E83A8605613947C(contents) {
  level endon("target_sighted");

  for(;;) {
    waitframe();

    if(!self playerads()) {
      continue;
    }
    start = self getEye();
    end = scripts\engine\trace::ray_trace(start, start + anglesToForward(level.player getplayerangles()) * 99999, undefined, contents)["position"];
    distance = length(start - end);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

_id_46D948B40CC362DC() {
  _id_8963DF9EB4AA344B = undefined;
  thread _id_86DAE4285C17EBA2();

  for(;;) {
    waitframe();
    enemies = getaiarray("axis");

    if(enemies.size <= 0) {
      while(enemies.size <= 0) {
        waitframe();
        enemies = getaiarray("axis");
      }
    }

    _id_80C53303FB317FE2 = [[self._id_921001EC11DC92AB]](enemies);

    if(!isDefined(_id_80C53303FB317FE2)) {
      continue;
    }
    if(!isDefined(_id_8963DF9EB4AA344B) || _id_8963DF9EB4AA344B != _id_80C53303FB317FE2)
      level notify("target_changed");

    _id_8963DF9EB4AA344B = _id_80C53303FB317FE2;
    waittillframeend;
    thread _id_1E14956A236DA6D8(_id_80C53303FB317FE2);
  }
}

_id_86DAE4285C17EBA2() {
  for(_id_04899B13EEA0B6DB = undefined; !isDefined(_id_04899B13EEA0B6DB); _id_04899B13EEA0B6DB = getaiarray("axis"))
    waitframe();

  for(;;) {
    waitframe();
    _id_15415763F1DF3112 = getaiarray("axis");

    if(!isDefined(_id_15415763F1DF3112)) {
      continue;
    }
    if(_id_15415763F1DF3112.size < _id_04899B13EEA0B6DB.size) {
      _id_04899B13EEA0B6DB = _id_15415763F1DF3112;
      continue;
    }

    if(_id_15415763F1DF3112.size > _id_04899B13EEA0B6DB.size) {
      level notify("scope_timeout");
      _id_04899B13EEA0B6DB = _id_15415763F1DF3112;
    }
  }
}

_id_1E14956A236DA6D8(enemy) {
  enemy endon("death");
  level endon("target_changed");

  for(;;) {
    waitframe();

    if(!self playerads()) {
      continue;
    }
    start = self getEye();
    distance = length(start - enemy.origin);
    self setclientomnvar("ui_scope_range_finder_distance", int(distance * 0.0254));
  }
}

_id_808CD37A5A40862D() {
  self endon("weapon_change");

  for(;;) {
    if(isDefined(level._id_CA0F41FE9610167A) && level._id_CA0F41FE9610167A)
      _id_E8CA271588171C26();
    else if(self playerads() == 1 && self sprintbuttonPressed()) {
      _id_DE8C6EBEA5CAFECD = gettime();

      while(self playerads() == 1 && self sprintbuttonPressed())
        waitframe();

      if(self playerads() == 1) {
        _id_0A0CBA5C6F46200E = gettime() - _id_DE8C6EBEA5CAFECD;

        if(_id_0A0CBA5C6F46200E < 200)
          _id_E8CA271588171C26();
      }
    }

    waitframe();
  }
}

_id_E8CA271588171C26() {
  range = self getclientomnvar("ui_scope_range_finder_distance");

  if(range < 30)
    range = 0;

  self setclientomnvar("ui_scope_range_finder_distance_locked", int(range));
  _id_920F4173513EB6B8 = _id_621629ACA9BFB262(range);
  self setclientomnvar("ui_scope_range_finder_bulletdrop", int(_id_920F4173513EB6B8));
  self setclientomnvar("ui_scope_range_finder_bulletdrop_update", 1);
  waitframe();
  self setclientomnvar("ui_scope_range_finder_bulletdrop_update", 0);
}

_id_621629ACA9BFB262(range) {
  _id_920F4173513EB6B8 = scripts\engine\math::normalize_value(0, 2000, range);
  _id_CCBBA16287668F0A = scripts\engine\math::factor_value(0, 200, _id_920F4173513EB6B8);

  if(isDefined(level._id_27B61226A83766DF))
    _id_CCBBA16287668F0A = _id_CCBBA16287668F0A * 2.9;
  else
    _id_CCBBA16287668F0A = _id_CCBBA16287668F0A * 1.2;

  return _id_CCBBA16287668F0A;
}

_id_D2C67316E3340D42() {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "showing_final_killcam");
}

deathcleanup() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "showing_final_killcam");
}