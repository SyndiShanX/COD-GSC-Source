/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\adrenaline.gsc
***********************************************/

_id_22FD49689920FDB1() {
  level._id_0151DF843343D146 = 160;
  level._id_52A6B416B67AAD73 = 0;
  _id_6F4586DEECB9973A = scripts\mp\equipment::_id_2113B6F7CB462692("adrenaline_mp");

  if(isDefined(_id_6F4586DEECB9973A)) {
    level._id_0151DF843343D146 = scripts\engine\utility::_id_53C4C53197386572(_id_6F4586DEECB9973A._id_1B96072AC8B3137E, 120);
    level._id_52A6B416B67AAD73 = scripts\engine\utility::_id_53C4C53197386572(_id_6F4586DEECB9973A._id_603039D101D23221, 0);
  }

  _id_358D8A3D2C32CBE6 = getdvarint("dvar_3B85029CF1AF7129", -1);
  _id_2EB18ADA2BFE5EDB = getdvarint("dvar_D94CBA8F8128BA00", -1);

  if(_id_358D8A3D2C32CBE6 >= 0)
    level._id_0151DF843343D146 = _id_358D8A3D2C32CBE6;

  if(_id_2EB18ADA2BFE5EDB >= 0)
    level._id_52A6B416B67AAD73 = _id_2EB18ADA2BFE5EDB;
}

useadrenaline() {
  self endon("disconnect");
  self endon("removeAdrenaline");
  _id_189B67B2735B981D::_id_55B08D6D71B41402(self, "self_apply");
  wait(level._id_52A6B416B67AAD73);

  if(self.health != self.maxhealth) {
    _id_FFE0D0BDD9BD7D44 = 0;

    if(isDefined(self.attackers)) {
      foreach(attacker in self.attackers) {
        if(scripts\engine\utility::is_equal(attacker, self)) {
          continue;
        }
        _id_FFE0D0BDD9BD7D44 = 1;
        break;
      }
    }

    if(_id_FFE0D0BDD9BD7D44 && (!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || !_id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(self.origin)))
      _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "adrenalineHeal");
  }

  self notify("force_regeneration");
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  adrenaline_missiononuse();
  self.adrenalinepoweractive = 1;

  if(self.health > 0 && self.health < self.maxhealth * 0.5)
    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_adrenaline", self, undefined, 0);

  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();
  return 1;
}

removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("removeAdrenaline");
    self.adrenalinepoweractive = undefined;
  }
}

onequipmenttaken(equipmentref, slot) {
  removeadrenaline();
}

onequipmentfired(equipmentref, slot, objweapon) {
  if(self isthrowingbackgrenade()) {
    self _meth_9B5704D0633B87FA();

    if(isDefined(objweapon)) {
      ammo = self getweaponammoclip(objweapon);
      _id_2AA9CAEF99C9AF77 = int(max(ammo - 1, 0));
      self setweaponammoclip(objweapon, _id_2AA9CAEF99C9AF77);
    }
  }

  useadrenaline();
}

gethealthpersec() {
  return level._id_0151DF843343D146;
}

adrenaline_removeonplayernotifies() {
  scripts\engine\utility::waittill_any_2("death", "healed");
  thread removeadrenaline();
}

adrenaline_removeondamage() {
  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon);

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_UNKNOWN")) {
      continue;
    }
    thread removeadrenaline();
    return;
  }
}

adrenaline_removeongameend() {
  level waittill("game_ended");
  thread removeadrenaline();
}

adrenaline_missiononuse() {
  if(self.health >= self.maxhealth) {
    self.usedadrenalineatfullhp = 1;
    thread adrenaline_missionondeaththink();
  }
}

adrenaline_missionondeaththink() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("adrenaline_missionOnDeathThink");
  self endon("adrenaline_missionOnDeathThink");
  self waittill("death");
  self.usedadrenalineatfullhp = undefined;
}