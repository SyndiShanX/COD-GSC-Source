/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hints.gsc
***********************************************/

_id_53D7DDA215345E9A(struct, func) {
  if(!isDefined(func))
    struct thread _id_5D7A5D368329104B();
  else
    struct thread[[func]]();
}

_id_5D7A5D368329104B() {
  while(!isDefined(level.players) || level.players.size == 0)
    wait 1;

  _id_465A06BAE1ABB77E = squared(self.radius);

  for(;;) {
    foreach(player in level.players) {
      if(istrue(player._id_2825B40BC5D1EE90)) {
        continue;
      }
      if(istrue(player._id_4D572A54ED8571C4)) {
        continue;
      }
      if(distancesquared(player.origin, self.origin) < _id_465A06BAE1ABB77E) {
        if(!player isnightvisionon() && !isDefined(player._id_B048AD4FDB04DD40))
          player thread _id_997763E2011CFF7A();
      }
    }

    wait 0.05;
  }
}

_id_1FFF43B972955992() {
  self endon("disconnect");
  self notify("show_third_person_hint");
  self endon("show_third_person_hint");
  self._id_59BE4F978F28AE72 = 1;

  if(self usinggamepad())
    self sethudtutorialmessage(&"COOP_GAME_PLAY/THIRD_PERSON_HINT", 1);
  else
    self sethudtutorialmessage(&"COOP_GAME_PLAY/THIRD_PERSON_HINT_PC", 1);

  for(time = 1; time < 7 && !self _meth_C1092F42B6BBE490(); time++)
    wait 1;

  self clearhudtutorialmessage();
  self._id_59BE4F978F28AE72 = undefined;
  self._id_4A92FA61D642BC3C = 1;
}

_id_997763E2011CFF7A() {
  self endon("disconnect");
  self notify("show_nvg_hint");
  self endon("show_nvg_hint");
  self._id_B048AD4FDB04DD40 = 1;

  if(self usinggamepad())
    self sethudtutorialmessage(&"COOP_GAME_PLAY/NVGS_HINT_GAMEPLAY", 1);
  else
    self sethudtutorialmessage(&"COOP_GAME_PLAY/NVGS_HINT_GAMEPLAY", 1);

  for(time = 1; time < 7 && !self isnightvisionon(); time++)
    wait 1;

  self clearhudtutorialmessage();
  self._id_B048AD4FDB04DD40 = undefined;
  self._id_2825B40BC5D1EE90 = 1;
}

_id_5F69C771ABBEC7B8() {
  self endon("disconnect");
  self notify("turn_nvgsOnOffDependingOnLight");
  self endon("turn_nvgsOnOffDependingOnLight");

  while(!isDefined(self.operatorcustomization))
    waitframe();

  for(;;) {
    if(self getplayerlightlevel() >= 0.15 || self isnightvisionon()) {
      wait 1;
      continue;
    } else {
      wait 2;

      if(self getplayerlightlevel() >= 0.15 || self isnightvisionon())
        continue;
      else
        _id_997763E2011CFF7A();
    }

    wait 0.25;
  }
}

_id_2248DE3565EED1D7() {
  self notify("nag_useArmor_handler");
  self endon("nag_useArmor_handler");
  self endon("disconnect");
  _id_1CD29382D1867470 = -1;
  _id_D96BE5D83DE1F615 = 0;
  delay = 30;

  for(;;) {
    wait(delay);

    if(istrue(self.inlaststand)) {
      continue;
    }
    _id_1CD29382D1867470 = _id_07C40FA80892A721::_id_0600F6CF462E983F();

    if(!_id_07C40FA80892A721::hasarmor() && _id_1CD29382D1867470 > 0 && _id_1CD29382D1867470 == _id_D96BE5D83DE1F615)
      thread _id_4DA770FC0303E7CD();

    _id_D96BE5D83DE1F615 = _id_1CD29382D1867470;
  }
}

_id_4DA770FC0303E7CD() {
  if(isDefined(self._id_D4850C224FA2C6AD))
    _id_C8A91E5582A5F256 = gettime() - self._id_D4850C224FA2C6AD;
  else
    _id_C8A91E5582A5F256 = 1000;

  str = &"EQUIPMENT_HINTS/ARMOR_USE_HINT";
  sound = "text_box_new";
  self playlocalsound(sound);
  thread scripts\cp\cp_hud_message::tutorialprint(str, 20);
  self._id_D4850C224FA2C6AD = gettime();
}