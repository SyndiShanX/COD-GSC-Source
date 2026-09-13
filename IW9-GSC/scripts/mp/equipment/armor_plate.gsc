/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\armor_plate.gsc
************************************************/

br_armor_plate_used() {
  _id_25959711EB415F96 = scripts\mp\equipment::getequipmentslotammo("health");

  if(_id_25959711EB415F96 <= 0) {
    return;
  }
  if(self isparachuting()) {
    self notify("br_try_armor_cancel");
    return;
  }

  if(isDefined(self.armorqueued))
    self.armorqueued--;

  _id_830009CEFCE35A66 = self.br_armorhealth + 5;
  _id_1C07EF7BC0E3723A = clamp(_id_830009CEFCE35A66, 0, self.br_maxarmorhealth);
  _id_43167C86311C997E = max(1, getdvarint("scr_br_armor_heal_amount", 50));
  _id_1C07EF7BC0E3723A = int(_id_1C07EF7BC0E3723A / _id_43167C86311C997E) * _id_43167C86311C997E + _id_43167C86311C997E;
  self.br_armorhealth = clamp(_id_1C07EF7BC0E3723A, 0, self.br_maxarmorhealth);
  br_armor_plate_amount_equipped_set(self.br_armorhealth);
  scripts\mp\equipment::decrementequipmentslotammo("health", 1);
  scripts\cp_mp\challenges::onuseitem("armor_plate");
  self notify("armor_plate_inserted");
}

br_armor_plate_broken_remove() {
  _id_830009CEFCE35A66 = self.br_armorhealth + 5;
  _id_1C07EF7BC0E3723A = clamp(_id_830009CEFCE35A66, 0, self.br_maxarmorhealth);
  _id_43167C86311C997E = max(1, getdvarint("scr_br_armor_heal_amount", 50));
  _id_1C07EF7BC0E3723A = int(_id_1C07EF7BC0E3723A / _id_43167C86311C997E) * _id_43167C86311C997E;
  _id_517C920EC0A48022 = clamp(_id_1C07EF7BC0E3723A, 0, self.br_maxarmorhealth);

  if(_id_517C920EC0A48022 >= self.br_armorhealth)
    return;
  else
    self.br_armorhealth = _id_517C920EC0A48022;

  br_armor_plate_amount_equipped_set(self.br_armorhealth);
}

br_armor_plate_amount_equipped_set(_id_D16569F10048FCE9) {
  self setclientomnvar("ui_armor_percent", int(_id_D16569F10048FCE9));
  _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("armorHealthRatio", int(_id_D16569F10048FCE9));
  squadmemberindex = self._id_3F78C6A0862F9E25;

  if(!isDefined(squadmemberindex) || !isDefined(self.team)) {
    return;
  }
  _id_607DA387F3617ED1 = level.teamdata[self.team]["players"];

  if(isDefined(level.squaddata) && isDefined(level.squaddata[self.team]) && isDefined(level.squaddata[self.team][self._id_0FF97225579DE16A]))
    _id_607DA387F3617ED1 = level.squaddata[self.team][self._id_0FF97225579DE16A].players;

  foreach(player in _id_607DA387F3617ED1)
  player setclientomnvar("ui_armor_squad_index_" + squadmemberindex, int(_id_D16569F10048FCE9));
}

br_use_armor_plate(item, _id_9BE70D6D4FF253A1) {
  self endon("disconnect");

  if(_id_9BE70D6D4FF253A1 == 0)
    return;
  else if(istrue(self.insertingarmorplate))
    return;
  else if(self isswitchingweapon()) {
    return;
  }
  if(!br_is_allowed_armor_insert()) {
    return;
  }
  weaponobj = makeweapon("armor_plate_deploy_mp");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("", self);
  streakinfo.armorweapon = weaponobj;
  br_toggle_armor_allows(1);
  thread br_watch_armor_cancel_notifys();
  _id_41BF9BF4918115AC = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon(weaponobj, streakinfo, ::br_insert_armor, undefined, undefined, undefined, undefined, 0);
}

br_watch_armor_cancel_notifys() {
  self endon("br_armor_repair_end");
  self endon("disconnect");
  br_add_player_commands();
  thread br_watch_armor_weapon();
  self.stoparmorinsert = 0;
  scripts\engine\utility::waittill_any_7("death", "mantle_start", "last_stand_start", "scr_change_swim_state", "special_weapon_fired", "br_try_armor_cancel", "br_armor_plate_done");
  self notify("cancel_all_killstreak_deployments");
  self.stoparmorinsert = 1;
  thread br_armor_repair_end();
}

br_watch_armor_weapon() {
  self endon("disconnect");
  self endon("br_armor_repair_end");

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename != "armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("br_try_armor_cancel");

    waitframe();
  }

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "armor_plate_deploy_mp") {
    if(self isonladder())
      self notify("br_try_armor_cancel");

    waitframe();
  }

  self notify("br_try_armor_cancel");
}

br_toggle_armor_allows(_id_E12D78C11D85D9C2) {
  if(_id_E12D78C11D85D9C2) {
    _id_3B64EB40368C1450::set("using_armor", "melee", 0);
    _id_3B64EB40368C1450::set("using_armor", "killstreaks", 0);
    _id_3B64EB40368C1450::set("using_armor", "crate_use", 0);
    _id_3B64EB40368C1450::set("using_armor", "equipment_primary", 0);
    _id_3B64EB40368C1450::set("using_armor", "equipment_secondary", 0);
    _id_3B64EB40368C1450::set("using_armor", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("using_armor", "offhand_throwback", 0);
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("using_armor");

  self.insertingarmorplate = _id_E12D78C11D85D9C2;
}

br_insert_armor(streakinfo) {
  self endon("disconnect");
  self endon("br_armor_repair_end");

  if(!br_is_allowed_armor_insert() || istrue(self.stoparmorinsert)) {
    return;
  }
  currenttime = gettime();
  _id_796BA59FC6C2AC9B = currenttime + 1860.0;
  _id_3F536CBD3A3C3591 = 2000.0;
  _id_FD3A2BB4C34A405C = 1860.0;

  for(_id_48115C25C4A06354 = 0; currenttime < _id_796BA59FC6C2AC9B; currenttime = gettime()) {
    if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
      return;
    }
    waitframe();
  }

  br_armor_plate_used();
  _id_4D5F2C05F11DB0EC = (_id_3F536CBD3A3C3591 - _id_FD3A2BB4C34A405C) / 1000;
  wait(_id_4D5F2C05F11DB0EC);

  while(br_should_continue_adding_armor()) {
    itemname = self.equipment["health"];
    _id_9BE70D6D4FF253A1 = scripts\mp\equipment::getequipmentslotammo("health");

    if(isDefined(itemname) && isDefined(_id_9BE70D6D4FF253A1) && _id_9BE70D6D4FF253A1 > 0 && self.br_armorhealth < self.br_maxarmorhealth) {
      _id_BEF0447316D92BFD = gettime() + 1250.0;

      while(gettime() < _id_BEF0447316D92BFD) {
        if(!isDefined(streakinfo.armorweapon) || streakinfo.armorweapon != self getcurrentweapon()) {
          return;
        }
        waitframe();
      }

      br_armor_plate_used();
      _id_0CF97CAF9E7EC424 = 0.25;
      wait(_id_0CF97CAF9E7EC424);
      continue;
    }

    break;
  }

  self notify("br_armor_plate_done");
}

br_is_allowed_armor_insert() {
  if(isDefined(self.vehicle)) {
    seat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(self.vehicle, self);

    if(seat == "driver")
      return 0;
  }

  _id_3CE512F8AF7753D7 = self isskydiving() || self isonladder() || self _meth_E40102956C887F7C();
  _id_E5740A4D65964259 = scripts\cp_mp\utility\player_utility::_id_B7869F6D9D4242E3(self) || istrue(self.isjuggernaut) || scripts\mp\supers::issuperinuse() && self.super.staticdata.ref != "super_deadsilence";

  if(_id_3CE512F8AF7753D7 || _id_E5740A4D65964259)
    return 0;

  if(self.br_armorhealth == self.br_maxarmorhealth) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups.br_pickupdenyarmorfull);
    return 0;
  }

  return 1;
}

br_should_continue_adding_armor() {
  _id_A5EA2300EFAAA6A7 = scripts\engine\utility::is_player_gamepad_enabled() && self weaponswitchbuttonPressed();
  _id_1D20666098BAA9F9 = isDefined(self.armorqueued) && self.armorqueued > 0;
  return _id_A5EA2300EFAAA6A7 || _id_1D20666098BAA9F9;
}

br_add_player_commands() {
  self notifyonplayercommand("br_try_armor_cancel", "+weapnext");
  self notifyonplayercommand("br_try_armor_cancel", "+weapprev");
  self notifyonplayercommand("br_try_armor_cancel", "+attack");
  self notifyonplayercommand("br_try_armor_cancel", "+smoke");
  self notifyonplayercommand("br_try_armor_cancel", "+frag");
  self notifyonplayercommand("br_try_armor_cancel", "+melee_zoom");
}

br_remove_player_commands() {
  self notifyonplayercommandremove("br_try_armor_cancel", "+weapnext");
  self notifyonplayercommandremove("br_try_armor_cancel", "+weapprev");
  self notifyonplayercommandremove("br_try_armor_cancel", "+attack");
  self notifyonplayercommandremove("br_try_armor_cancel", "+smoke");
  self notifyonplayercommandremove("br_try_armor_cancel", "+frag");
  self notifyonplayercommandremove("br_try_armor_cancel", "+melee_zoom");
}

br_armor_repair_end() {
  self endon("disconnect");
  self notify("br_armor_repair_end");
  br_remove_player_commands();

  while(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename) && self.currentweapon.basename == "armor_plate_deploy_mp")
    waitframe();

  waitframe();

  if(istrue(self.armorqueued))
    self.armorqueued = 0;

  br_toggle_armor_allows(0);
}