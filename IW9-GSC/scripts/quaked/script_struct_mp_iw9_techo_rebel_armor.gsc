/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_techo_rebel_armor.gsc
*********************************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_techo_rebel_armor", ::_id_0C036143411F3540);
}

_id_0C036143411F3540() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_techo_rebel_armor")) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::_id_C1B385596F29457E;
  callbacks["armorShouldMitigateDamage"] = ::_id_96939D4C4815B891;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_techo_rebel_armor", callbacks);
  _id_1B72AFF42925D411();
}

_id_1B72AFF42925D411() {
  _id_0F18669893E89DD0 = undefined;
  _id_44EFE20B6FF851CB = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "armorDamageFeedback"))
    _id_0F18669893E89DD0 = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "armorDamageFeedback");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "armorDeathFeedback"))
    _id_44EFE20B6FF851CB = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "armorDeathFeedback");

  if(isDefined(_id_0F18669893E89DD0) || isDefined(_id_44EFE20B6FF851CB)) {
    foreach(_id_151B23F6C7D09CF8, data in scripts\cp_mp\vehicles\vehicle_damage::_id_870CBF6CA47076B6("veh9_techo_rebel_armor")) {
      if(issubstr(_id_151B23F6C7D09CF8, "tag_armor"))
        scripts\cp_mp\vehicles\vehicle_damage::_id_BC320CF9A1B27CB5("veh9_techo_rebel_armor", _id_151B23F6C7D09CF8, _id_44EFE20B6FF851CB, _id_0F18669893E89DD0);
    }
  }
}

_id_C1B385596F29457E(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_techo_rebel_armor", spawndata, _id_EE8DA5624236DC89);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh9_techo_rebel_armor", "armorDamageMitigation"))
    vehicle._id_7A646FF827387AC0 = scripts\cp_mp\utility\script_utility::getsharedfunc("veh9_techo_rebel_armor", "armorDamageMitigation");

  return vehicle;
}

_id_96939D4C4815B891(partname, meansofdeath, damagelocation, objweapon) {
  if(isDefined(partname) && partname != "tag_origin" && partname != "" && partname != "none")
    return 1;
  else if(isexplosivedamagemod(meansofdeath)) {
    dir = vectorNormalize((damagelocation - self.origin) * (1, 1, 0));
    fwd = anglestoright(self.angles);
    dot = vectordot(dir, fwd);
    pos = [];

    if(dot > 0) {
      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_15");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_12");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_07");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_14");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_08");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_17");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;
    } else if(dot < 0) {
      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_05");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_11");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_19");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_18");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_13");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;

      _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_16");

      if(isDefined(_id_B6919FDD59526F63))
        pos[pos.size] = _id_B6919FDD59526F63;
    }

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_01");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_02");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_B6919FDD59526F63 = _id_8A52A8AAB7E2B441("tag_armor_06");

    if(isDefined(_id_B6919FDD59526F63))
      pos[pos.size] = _id_B6919FDD59526F63;

    _id_F60270B9450BE387 = scripts\engine\utility::get_array_of_closest(damagelocation, pos, undefined, undefined, 250, 0);

    if(_id_F60270B9450BE387.size) {
      if(distancesquared(damagelocation, _id_F60270B9450BE387[0].origin) < 10000) {
        if(isDefined(self._id_AAB9695C92B0ED96) && isDefined(self._id_AAB9695C92B0ED96[_id_F60270B9450BE387[0].tagname]) && self._id_AAB9695C92B0ED96[_id_F60270B9450BE387[0].tagname]._id_A776F097EB36E500 < 1)
          return 0;

        return 1;
      }
    }
  }

  return 0;
}

_id_8A52A8AAB7E2B441(tagname) {
  if(self tagexists(tagname)) {
    info = spawnStruct();
    info.origin = self gettagorigin(tagname);
    info.tagname = tagname;
    return info;
  }

  return undefined;
}