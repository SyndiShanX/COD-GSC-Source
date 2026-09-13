/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_70f8c085c6bde77e.gsc
***********************************************/

_id_C238E4C6605E99F8() {}

_id_210B4D286FEAE145() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("br_spawned");
  thread _id_82E6F3BAC838A703();
}

_id_82E6F3BAC838A703() {
  self endon("disconnect");
  level endon("game_ended");

  if(!isbot(self) && !isagent(self)) {
    self notifyonplayercommand("tac_map_toggle", "togglemap");
    self notifyonplayercommand("menu_escape", "pause");
  }

  _id_9AF1C847B28AE3F8 = 0;
  _id_24D3CA04553DE080 = makeweapon("tac_map_toggle_mp");

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_4("tac_map_toggle", "death", "last_stand_start", "menu_escape");
    _id_F0DD765393870B60 = getdvarint("dvar_ED5DF81B887A95E2", 0);

    if(!_id_F0DD765393870B60) {
      self setclientomnvar("ui_tac_map_type", 0);
      waitframe();
      continue;
    }

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      continue;
    }
    _id_F13A4CDB3E525CC5 = _id_070722DE16841911();
    _id_C8EF56A28771BF53 = 1;

    if(result == "death" || result == "last_stand_start" || (result == "tac_map_toggle" || result == "menu_escape") && istrue(_id_9AF1C847B28AE3F8)) {
      if(self hasweapon(_id_24D3CA04553DE080))
        self takeweapon(_id_24D3CA04553DE080);

      if(isDefined(level._id_DC65C33DFDD9EFE8) && level._id_DC65C33DFDD9EFE8)
        self setcamerathirdperson(1);

      _id_9AF1C847B28AE3F8 = 0;
      continue;
    }

    if(!_id_F13A4CDB3E525CC5)
      _id_C8EF56A28771BF53 = 0;

    self setclientomnvar("ui_tac_map_type", _id_C8EF56A28771BF53);

    if(_id_F13A4CDB3E525CC5 && !self hasweapon(_id_24D3CA04553DE080)) {
      self giveandfireoffhand(_id_24D3CA04553DE080);

      if(isDefined(level._id_DC65C33DFDD9EFE8) && level._id_DC65C33DFDD9EFE8)
        self setcamerathirdperson(0);
    }

    _id_9AF1C847B28AE3F8 = 1;
  }
}

_id_39D8F11067A26610() {
  self endon("disconnect");
  level endon("game_ended");
  _id_494B59F9F8644A6C = 0;

  for(;;) {
    if(self isskydiving()) {
      if(!istrue(_id_494B59F9F8644A6C)) {
        self notify("tac_map_toggle");
        _id_494B59F9F8644A6C = 1;
      }
    } else if(istrue(_id_494B59F9F8644A6C))
      _id_494B59F9F8644A6C = 0;

    waitframe();
  }
}

_id_070722DE16841911() {
  _id_E55479EE6970B728 = 1;
  _id_F9C35103D1DC33E7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(self);
  _id_494B59F9F8644A6C = self isskydiving();
  _id_70E9109CCF3B3BC7 = istrue(self.plotarmor) && isDefined(self.c130);

  if(_id_F9C35103D1DC33E7 || _id_494B59F9F8644A6C || _id_70E9109CCF3B3BC7)
    _id_E55479EE6970B728 = 0;

  return _id_E55479EE6970B728;
}