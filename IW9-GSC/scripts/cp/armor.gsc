/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\armor.gsc
***********************************************/

init() {
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_FA0C918F6B87950D);
}

_id_FA0C918F6B87950D() {
  self.armorqueued = 0;
  self._id_4CB4A6EBD0885FFD = 150;
  self._id_C99DB8962A6B36BB = 0;
}

_id_8CE284D6441202B8(_id_15430B4BBD079285) {
  if(_id_15430B4BBD079285 == 0)
    self._id_4CB4A6EBD0885FFD = 150;
  else if(_id_15430B4BBD079285 == 1)
    self._id_4CB4A6EBD0885FFD = 200;
  else
    self._id_4CB4A6EBD0885FFD = 250;
}

show_damage_direction(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  original_health = player.health;
  player finishplayerdamage(einflictor, attacker, 1, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname);
  player.health = original_health;
}

_id_CA71EB8BE30F9E15(_id_7AEBECFC2EE6CF02) {
  _id_C791EAD1F39669F4 = self._id_4CB4A6EBD0885FFD;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  self.armor = _id_7AEBECFC2EE6CF02;
}

_id_62957C4B8E469641(_id_7AEBECFC2EE6CF02) {
  self._id_B5218CF00DAD94EF = _id_7AEBECFC2EE6CF02;
}

_id_D249004B747BF5B4(_id_893C26EA587CC273) {
  return isDefined(self.perk_data) && isDefined(self.perk_data[_id_893C26EA587CC273]);
}

_id_0D92D499C7600838(_id_893C26EA587CC273) {
  return self.perk_data[_id_893C26EA587CC273];
}

_id_47A88C4E1D36189A(_id_763565CB1EBE7F95, attacker) {
  _id_0563ABD1F0C73A53 = 1;
  _id_47BA9B9F5DFEF300 = 0;
  _id_971F0B9A323941B8 = getdvarint("dvar_4A9F73175B3308E4", 0);

  if(_id_971F0B9A323941B8)
    _id_47BA9B9F5DFEF300 = 25;

  _id_763565CB1EBE7F95 = _id_763565CB1EBE7F95 - _id_47BA9B9F5DFEF300;
  _id_019E04E90D1ACC0C = _id_3C53263A1EC58C23();
  _id_763565CB1EBE7F95 = _id_763565CB1EBE7F95 / _id_019E04E90D1ACC0C;

  if(_id_763565CB1EBE7F95 < _id_0563ABD1F0C73A53)
    _id_763565CB1EBE7F95 = _id_0563ABD1F0C73A53;

  return _id_763565CB1EBE7F95;
}

_id_270C9D76E9075AF8(_id_763565CB1EBE7F95, attacker) {
  _id_9D6D671926FB4E4A = _id_47A88C4E1D36189A(_id_763565CB1EBE7F95, attacker);
  _id_CDC6CC34B279F409 = _id_8E297D719D663B78();
  _id_FB6F10D7080ED490 = min(_id_CDC6CC34B279F409, _id_9D6D671926FB4E4A);
  _id_BAB6DC781BCDF7E6 = int(_id_9D6D671926FB4E4A - _id_FB6F10D7080ED490);
  _id_7AEBECFC2EE6CF02 = _id_CDC6CC34B279F409 - _id_FB6F10D7080ED490;
  _id_7AEBECFC2EE6CF02 = max(_id_7AEBECFC2EE6CF02, 0);

  if(isPlayer(self)) {
    if(isDefined(attacker) && isPlayer(attacker)) {
      _id_F53746730ACAD8A4 = max(_id_BAB6DC781BCDF7E6, 1);
      attacker _id_354C862768CFE202::updatehitmarker("cp_hitmarker_armor", 0, _id_F53746730ACAD8A4, 1, 0);
    }

    _id_07C40FA80892A721::_id_AC7803D45979135C(_id_7AEBECFC2EE6CF02);
    broadcast_armor(_id_7AEBECFC2EE6CF02);
    play_armor_sfx(attacker, _id_7AEBECFC2EE6CF02);

    if(_id_7AEBECFC2EE6CF02 <= 0)
      remove_player_armor(self);
  } else {
    if(isDefined(attacker) && isPlayer(attacker))
      _id_F53746730ACAD8A4 = max(_id_BAB6DC781BCDF7E6, 1);

    _id_62957C4B8E469641(_id_7AEBECFC2EE6CF02);
  }

  return _id_BAB6DC781BCDF7E6;
}

_id_8E297D719D663B78() {
  if(isPlayer(self))
    return _id_07C40FA80892A721::_id_AC266FC218266D08();
  else
    return self._id_B5218CF00DAD94EF;
}

_id_3C53263A1EC58C23() {
  if(isagent(self))
    return 1;

  if(getdvarint("dvar_3578DCB6790FCFEE", 0))
    return getdvarint("dvar_3578DCB6790FCFEE");

  return 3.0;
}

damage_armored_player(player, einflictor, attacker, _id_763565CB1EBE7F95, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, _id_CB96F01F01795373, modelindex, partname) {
  _id_5BAD2A552DA00704 = player _id_270C9D76E9075AF8(_id_763565CB1EBE7F95, attacker);
  return _id_5BAD2A552DA00704;
}

armor_resistance_to_type(type, objweapon, einflictor, eattacker) {
  if(type == "MOD_FALLING")
    return 0;

  if(type == "MOD_TRIGGER_HURT")
    return 0;

  if(type == "MOD_FIRE" && !istrue(einflictor.ignore_fire_armor_check))
    return 0;

  switch (objweapon.basename) {
    case "white_phosphorus_proj_mp":
    case "gunship_25mm_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "gunship_105mm_mp":
      return 0;
  }

  if(isDefined(self) && istrue(self._id_230A3287F9AD2965)) {
    self._id_230A3287F9AD2965 = undefined;
    return 0;
  }

  if(isDefined(eattacker) && istrue(eattacker.armor_piercing))
    return 0;

  return 1;
}

play_armor_sfx(attacker, _id_7AEBECFC2EE6CF02) {
  alias = "cp_hit_indication_armor";

  if(_id_7AEBECFC2EE6CF02 < 0)
    alias = "plr_armor_gone";

  if(isPlayer(self) && soundexists(alias))
    self playlocalsound(alias);

  if(isPlayer(attacker) && soundexists(alias))
    attacker playlocalsound(alias);
}

broadcast_armor(amount) {
  _id_1DAB4A6BAD01C509 = self getentitynumber();
  armor = int(amount);
  self setclientomnvar("ui_cp_armor_amount", armor);
  _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerArmor", armor);
}

_id_E0D47DE3DF5F23EA() {
  _id_1DAB4A6BAD01C509 = self getentitynumber();

  if(isDefined(self._id_C99DB8962A6B36BB))
    _id_3BCAA2CBAF54ABDD::setcoopplayerdata_for_everyone("EoGPlayer", _id_1DAB4A6BAD01C509, "playerArmorHardened", self._id_C99DB8962A6B36BB);
}

update_player_model(_id_AA796102B09BD2A7, player) {
  if(istrue(_id_AA796102B09BD2A7))
    player setcharactermodels("body_mp_western_fireteam_west_ar_1_1_lod1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
  else
    player setcharactermodels("head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_1_1", "viewhands_mp_base_iw8");
}

setcharactermodels(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2, hairmodel) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self.bodymodel = bodymodelname;
  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }

  if(isDefined(hairmodel)) {
    self attach(hairmodel, "", 1);
    self.hairmodel = hairmodel;
  }
}

pick_up_armor_vest(_id_DF071553D0996FF9, player) {
  if(player _id_07C40FA80892A721::_id_79E0AB2AA0304A2C()) {
    return;
  }
  _id_DF071553D0996FF9.model delete();
  _id_71332A5B74214116::remove_from_current_interaction_list(_id_DF071553D0996FF9);
  _id_C791EAD1F39669F4 = player._id_4CB4A6EBD0885FFD;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  givearmor(player, _id_C791EAD1F39669F4);
}

usearmorplate(item, _id_9BE70D6D4FF253A1) {
  self endon("disconnect");
  _id_9BE70D6D4FF253A1 = self.armorqueued;

  if(player_have_full_armor(self) || _id_0AFB7E332AEE4BF2::player_in_laststand(self)) {
    return;
  }
  if(!isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0)
    return;
  else if(istrue(self.insertingarmorplate))
    return 0;

  if(!_id_8B4861D7C2B23A5F()) {
    return;
  }
  if(self isgestureplaying()) {
    if(self isgestureplaying("ges_swipe")) {
      self stopgestureviewmodel("ges_swipe", 0, 1);
      wait 0.05;
    } else
      return;
  }

  weaponobj = makeweapon("iw9_armor_plate_deploy_mp");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", self);
  streakinfo.armorweapon = weaponobj;
  _id_44069CEC1CE1F09C(1);
  self._id_1D28F38751479256 = 0;
  thread _id_27850A781863BBDA();
  _id_41BF9BF4918115AC = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::_id_0A86A98DE3E7986B, undefined, ::_id_5428674B81737A6F, undefined, undefined, self._id_1D28F38751479256);
}

_id_0A86A98DE3E7986B(streakinfo) {
  self endon("death_or_disconnect");
  self endon("armor_repair_end");

  if(!_id_8B4861D7C2B23A5F() || istrue(self.stoparmorinsert)) {
    return;
  }
  currenttime = gettime();

  if(istrue(self._id_1D28F38751479256)) {
    _id_796BA59FC6C2AC9B = currenttime + 2800.0;
    _id_3F536CBD3A3C3591 = 3000.0;
    _id_FD3A2BB4C34A405C = 2800.0;
    _id_48115C25C4A06354 = currenttime + 1125.0;
  } else {
    _id_796BA59FC6C2AC9B = currenttime + 1860.0;
    _id_3F536CBD3A3C3591 = 2000.0;
    _id_FD3A2BB4C34A405C = 1860.0;
    _id_48115C25C4A06354 = 0;
  }

  while(currenttime < _id_796BA59FC6C2AC9B) {
    if(istrue(self._id_1D28F38751479256) && currenttime > _id_48115C25C4A06354)
      self._id_1D28F38751479256 = 0;

    if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
      return;
    }
    waitframe();
    currenttime = gettime();
  }

  _id_4C0F32BF2E194901();
  _id_4D5F2C05F11DB0EC = (_id_3F536CBD3A3C3591 - _id_FD3A2BB4C34A405C) / 1000;
  wait(_id_4D5F2C05F11DB0EC);

  while(_id_71BFAFF2D0AA4165()) {
    itemname = "iw9_armor_plate_deploy_mp";
    _id_9BE70D6D4FF253A1 = self.armorqueued;

    if(isDefined(itemname) && isDefined(_id_9BE70D6D4FF253A1) && _id_9BE70D6D4FF253A1 > 0 && !player_have_full_armor(self)) {
      _id_BEF0447316D92BFD = gettime() + 1250.0;

      while(gettime() < _id_BEF0447316D92BFD) {
        if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
          return;
        }
        waitframe();
      }

      _id_4C0F32BF2E194901();
      _id_0CF97CAF9E7EC424 = 0.25;
      wait(_id_0CF97CAF9E7EC424);
      continue;
    }

    break;
  }

  self notify("armor_plate_done");
}

_id_865D357C1A33FD3B() {
  self.armorqueued = 0;
  self setclientomnvar("ui_equipment_id_health_numCharges", self.armorqueued);
}

_id_1258F8D2084A2CE7(num) {
  _id_984A6DF678D579CB = 5;

  if(scripts\cp\utility::_hasperk("specialty_armor_satchel"))
    _id_984A6DF678D579CB = 8;

  if(!isDefined(num))
    num = 1;
  else if(scripts\cp\utility::_hasperk("specialty_armor_satchel"))
    num = num + 3;

  if(!isDefined(self.armorqueued)) {
    _id_2CF7323DC1535B23 = num;
    self.armorqueued = num;
  } else {
    _id_2CF7323DC1535B23 = self.armorqueued + num;
    self.armorqueued = self.armorqueued + num;
  }

  _id_748A5B6E1EB008F5 = 0;

  if(_id_2CF7323DC1535B23 > _id_984A6DF678D579CB)
    _id_748A5B6E1EB008F5 = _id_2CF7323DC1535B23 - _id_984A6DF678D579CB;

  self.armorqueued = int(min(self.armorqueued, _id_984A6DF678D579CB));
  self setclientomnvar("ui_equipment_id_health", 27);
  self setclientomnvar("ui_equipment_id_health_numCharges", self.armorqueued);
  return _id_748A5B6E1EB008F5;
}

_id_6F49A313DAF71B39() {
  self setclientomnvar("ui_br_has_plate_pouch", 1);
  self._id_9C791A7A7FC6C7B5 = 1;
}

_id_9A26BFC3788F86DC() {
  self setclientomnvar("ui_br_has_plate_pouch", 0);
  self._id_9C791A7A7FC6C7B5 = 0;
}

_id_71BFAFF2D0AA4165() {
  _id_A5EA2300EFAAA6A7 = scripts\engine\utility::is_player_gamepad_enabled() && self weaponswitchbuttonPressed();
  _id_1D20666098BAA9F9 = isDefined(self.armorqueued) && self.armorqueued > 0;
  return _id_A5EA2300EFAAA6A7 && _id_1D20666098BAA9F9;
}

_id_44069CEC1CE1F09C(_id_E12D78C11D85D9C2) {
  self allowmelee(!_id_E12D78C11D85D9C2);
  self.insertingarmorplate = _id_E12D78C11D85D9C2;
}

_id_5428674B81737A6F(streakinfo, _id_41BF9BF4918115AC) {
  if(!istrue(_id_41BF9BF4918115AC)) {
    _id_44069CEC1CE1F09C(0);
    return;
  }
}

_id_8B4861D7C2B23A5F() {
  if(isDefined(self.vehicle)) {
    seat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(self.vehicle, self);

    if(seat == "driver")
      return 0;
  }

  if(self isparachuting())
    return 0;

  return 1;
}

givearmor(player, armoramount, _id_CF0A9D02644669AC) {
  if(player_have_full_armor(player)) {
    return;
  }
  _id_DD1FA94E89403BA2 = player _id_07C40FA80892A721::_id_AC266FC218266D08();
  _id_1DAB4A6BAD01C509 = player getentitynumber();
  setomnvar("ui_armor_gained", _id_1DAB4A6BAD01C509);
  _id_7AEBECFC2EE6CF02 = min(_id_DD1FA94E89403BA2 + armoramount, player._id_4CB4A6EBD0885FFD);
  _id_CF0A9D02644669AC = istrue(_id_CF0A9D02644669AC);

  if(!_id_CF0A9D02644669AC) {
    player _id_3B64EB40368C1450::set("armor", "ads", 0);
    player _id_3B64EB40368C1450::set("armor", "fire", 0);
    player _id_3B64EB40368C1450::set("armor", "melee", 0);
    player cancelreload();
    _id_CF0A9D02644669AC = 1;
  }

  player broadcast_armor(_id_7AEBECFC2EE6CF02);

  if(!_id_CF0A9D02644669AC) {
    wait(player getgestureanimlength("ges_vest_replace"));
    player playlocalsound("plr_armor_salvage");
  }

  player notify("armorUseSuccess");

  if(!_id_CF0A9D02644669AC) {
    player stopgestureviewmodel("ges_vest_replace", 0.45);
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("armor");
  }

  player.armor = _id_7AEBECFC2EE6CF02;
}

player_have_armor(player) {
  return player.armor > 0;
}

player_have_full_armor(player) {
  _id_C791EAD1F39669F4 = self._id_4CB4A6EBD0885FFD;
  _id_971F0B9A323941B8 = getdvarint("dvar_E6924E7C0A5AAD1F", 0);

  if(_id_971F0B9A323941B8)
    _id_C791EAD1F39669F4 = _id_971F0B9A323941B8;

  return player.armor == _id_C791EAD1F39669F4;
}

_id_F9844E7B0CB6E736(player) {
  _id_984A6DF678D579CB = 5;

  if(scripts\cp\utility::_hasperk("specialty_armor_satchel"))
    _id_984A6DF678D579CB = 8;

  _id_FCE0AD4F666E56A1 = isDefined(self.armorqueued) && self.armorqueued >= _id_984A6DF678D579CB;
  return _id_FCE0AD4F666E56A1;
}

armor_vest_hint_func(_id_DF071553D0996FF9, player) {
  if(player_have_full_armor(player))
    return &"COOP_CRAFTING/ARMOR_FULL";
  else
    return &"COOP_CRAFTING/ARMOR_TAKE";
}

updatearmorvestmodel() {
  self endon("armorUseSuccess");
  self endon("disconnect");
  self endon("death");
  wait 0.5;
  model = spawn("script_model", self.origin);
  model setModel("loot_armor");
  model notsolid();
  self playerlinktodelta(model);
  scripts\engine\utility::waittill_notify_or_timeout("armorUseCancel", 1.2);
  self unlink();
  model delete();
}

armorbreak(point) {
  self shellshock("armor_gone", 2.5);
  earthquake(0.3, 0.65, point, 5000);
  self viewkick(127, self.origin, 0);
}

armorinit(player) {
  player.armor = 0;
}

remove_player_armor(player) {
  player.armor = 0;
  player playsoundtoplayer("hit_marker_armor_break_plr", player);
  player setscriptablepartstate("armor_break", "armor_break", 0);
}

can_update_player_armor_model(player) {
  if(isDefined(player.can_update_player_armor_model) && player.can_update_player_armor_model == 0)
    return 0;

  return 1;
}

set_can_update_player_armor_model(player, value) {
  player.can_update_player_armor_model = value;
}

_id_4C0F32BF2E194901() {
  _id_1D20666098BAA9F9 = isDefined(self.armorqueued) && self.armorqueued > 0;

  if(!_id_1D20666098BAA9F9) {
    return;
  }
  if(self isparachuting()) {
    self notify("try_armor_cancel", "parachuting");
    return;
  }

  if(isDefined(self.armorqueued))
    self.armorqueued--;

  self setclientomnvar("ui_equipment_id_health", 27);
  self setclientomnvar("ui_equipment_id_health_numCharges", self.armorqueued);
  givearmor(self, 50, 1);
  scripts\cp_mp\challenges::onuseitem("armor_plate");
  self notify("armor_plate_inserted");
}

_id_AB2214DEAE1E59B1(_id_A33039D2420867AD) {
  scripts\engine\utility::ent_flag_wait("player_spawned_with_loadout");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A33039D2420867AD; _id_AC0E594AC96AA3A8++) {
    self setclientomnvar("ui_equipment_id_health", 27);
    givearmor(self, 50, 1);
  }
}

_id_27850A781863BBDA() {
  self endon("armor_repair_end");
  self endon("disconnect");
  _id_C0F8E3D4ADC00C6B();
  thread _id_6240B67B26D79AC9();
  self.stoparmorinsert = 0;
  scripts\engine\utility::waittill_any_6("death", "mantle_start", "last_stand_start", "special_weapon_fired", "try_armor_cancel", "armor_plate_done");
  self.stoparmorinsert = 1;
  thread _id_9CAE5A8582BABAD6();
}

_id_9CAE5A8582BABAD6() {
  self endon("disconnect");
  self notify("armor_repair_end");
  _id_DCBE43EEC086BCFA();

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp")
    waitframe();

  waitframe();
  _id_44069CEC1CE1F09C(0);
}

_id_C0F8E3D4ADC00C6B() {
  self notifyonplayercommand("try_armor_cancel", "+weapnext");
  self notifyonplayercommand("try_armor_cancel", "+weapprev");
  self notifyonplayercommand("try_armor_cancel", "+attack");
  self notifyonplayercommand("try_armor_cancel", "+smoke");
  self notifyonplayercommand("try_armor_cancel", "+frag");
  self notifyonplayercommand("try_armor_cancel", "+melee_zoom");
}

_id_DCBE43EEC086BCFA() {
  self notifyonplayercommandremove("try_armor_cancel", "+weapnext");
  self notifyonplayercommandremove("try_armor_cancel", "+weapprev");
  self notifyonplayercommandremove("try_armor_cancel", "+attack");
  self notifyonplayercommandremove("try_armor_cancel", "+smoke");
  self notifyonplayercommandremove("try_armor_cancel", "+frag");
  self notifyonplayercommandremove("try_armor_cancel", "+melee_zoom");
}

_id_6240B67B26D79AC9() {
  self endon("disconnect");
  self endon("armor_repair_end");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename != "iw9_armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("try_armor_cancel", "ladder_used");

    waitframe();
  }

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("try_armor_cancel", "ladder_used");

    waitframe();
  }

  self notify("try_armor_cancel");
}

_id_6E9EE0DF5AB3C202() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / Give 3 Armor\" \"set scr_give_armor 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level thread _id_D251468D9C2FE73F();
}

_id_D251468D9C2FE73F() {
  level endon("game_ended");
  wait 10;

  for(;;) {
    while(getdvarint("dvar_5B9017DBF5C32C36", 0) == 0)
      wait 0.5;

    level.player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(3);
    setDvar("dvar_5B9017DBF5C32C36", 0);
    wait 0.5;
  }
}