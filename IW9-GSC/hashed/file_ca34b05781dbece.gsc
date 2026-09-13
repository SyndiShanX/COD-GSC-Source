/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_ca34b05781dbece.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.result = [];
  event.radiussq = radius * radius;
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_EC10C084410E83FC = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_EC10C084410E83FC;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    _id_1D2BE7531AAF82AF = getEntArray("script_model", "classname");

    foreach(ent in _id_1D2BE7531AAF82AF) {
      if(isDefined(ent.cratetype) && ent.cratetype == "battle_royale_loadout" && ent.team == self.team && istrue(ent.isusable) && distancesquared(self.origin, ent.origin) < event.radiussq) {
        _id_F90358454413407F = spawnStruct();
        _id_F90358454413407F.type = "airdrop_loadout";
        _id_F90358454413407F.entity = ent;
        _id_F90358454413407F.entity.index = ent getentitynumber();
        event.result[event.result.size] = _id_F90358454413407F;
      }
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}