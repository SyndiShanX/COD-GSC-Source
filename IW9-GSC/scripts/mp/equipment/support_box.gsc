/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\support_box.gsc
************************************************/

supportbox_init() {
  level.allsupportboxes = [];
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_munitionsbox");
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_armorbox");
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_hauntedbox");
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_blastshieldbox");
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_leaderbox");
  scripts\common\interactive::interactive_addusedcallback(::supportbox_usedcallback, "equip_self_revive_box");
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::supportbox_updateheadicononjointeam);
  level._effect["vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx"] = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx");
  level._effect["vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx"] = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx");
  level._effect["vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx"] = loadfx("vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx");
  level._effect["vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx"] = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx");
}

supportbox_updateheadicononjointeam(player) {
  foreach(supportbox in level.allsupportboxes) {
    if(isDefined(supportbox))
      supportbox supportbox_updateheadicon(player);
  }
}

box_used_common_setup(grenade, _id_F4692D0892428480, superid, headicon) {
  grenade endon("death");
  grenade thread supportbox_watchdisownedtimeout();
  grenade thread supportbox_hideandshowaftertime();
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  grenade supportbox_handlemovingplatforms(stuckto);

  if(1)
    thread scripts\mp\weapons::outlineequipmentforowner(grenade);

  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata[superid].id;
  grenade._id_D442547D75DFFD09 = scripts\mp\supers::_id_BF9C7E9DD30180E3(superid);
  scripts\mp\weapons::onequipmentplanted(grenade, _id_F4692D0892428480, ::supportbox_destroy);
  level.allsupportboxes[grenade getentitynumber()] = grenade;
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::supportbox_empapplied);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_F7BD40787418DF02);
  grenade _id_49197CD063A740EA(::supportbox_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  if(!istrue(grenade.madedamageable))
    grenade supportbox_makedamageable();

  grenade.makedamageable = undefined;
  grenade setscriptablepartstate("visibility", "show", 0);
  wait 0.0;

  if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    grenade supportbox_addheadicon(headicon);

  wait 0.75;
  grenade setscriptablepartstate("effects", "plant", 0);
  grenade setscriptablepartstate("anims", "open", 0);
  wait(grenade supportbox_getdeployanimduration());
  grenade setscriptablepartstate("beacon", "active", 0);
  grenade setscriptablepartstate("anims", "openIdle", 0);
}

is_train_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == _id_1D9FB21B4F3023F3)
        return 1;
      else if(isDefined(ent.linked_model) && ent.linked_model == _id_1D9FB21B4F3023F3)
        return 1;
    }
  }

  return 0;
}

supportbox_used(grenade) {
  grenade endon("death");
  _id_1D40E40DAB99437E = "vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx";
  _id_1CB365D92187987B = "mp_equip_box_destroyed";
  equipname = "equip_munitionsbox";
  _id_5237A188CCDA4D7B = "super_ammo_drop";
  headicon = "hud_icon_fieldupgrade_ammo_box";
  _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/SUPPORT_BOX_USE";

  if(isDefined(grenade.equipmentref)) {
    switch (grenade.equipmentref) {
      case "equip_armorbox":
        _id_1D40E40DAB99437E = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
        _id_1CB365D92187987B = "mp_equip_box_destroyed";
        equipname = "equip_armorbox";
        _id_5237A188CCDA4D7B = "super_armor_drop";
        headicon = "hud_icon_fieldupgrade_armor_box";
        _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
        break;
      case "equip_hauntedbox":
        _id_1D40E40DAB99437E = "vfx/iw9_br/haunted_box/vfx_haunted_box_dest.vfx";
        _id_1CB365D92187987B = "eqp_haunted_box_destroy";
        equipname = "equip_hauntedbox";
        _id_5237A188CCDA4D7B = "super_haunted_drop";
        headicon = "hud_icon_fieldupgrade_haunted_box";
        _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/HAUNTED_BOX_USE";
        break;
      case "equip_blastshieldbox":
        _id_1D40E40DAB99437E = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
        _id_1CB365D92187987B = "mp_equip_box_destroyed";
        equipname = "equip_blastshieldbox";
        _id_5237A188CCDA4D7B = "super_blastshield_drop";
        headicon = "hud_icon_equipment_blastshield_box";
        _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/BLASTSHIELD_BOX_USE";
        break;
      case "equip_leaderbox":
        _id_1D40E40DAB99437E = "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx";
        _id_1CB365D92187987B = "mp_equip_box_destroyed";
        equipname = "equip_leaderbox";
        _id_5237A188CCDA4D7B = "super_leader_drop";
        headicon = "hud_icon_fieldupgrade_armor_box";
        _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/SELF_REVIVE_BOX_USE";
        self setclientomnvar("ui_squad_leader_pack_dropped", 1);
        _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 0);

        foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
        _id_F0EA4030349A33D5 setclientomnvar("ui_squad_leader_pack_dropped", 1);

        break;
      case "equip_self_revive_box":
        _id_1D40E40DAB99437E = "vfx/iw9/prop/scriptables/vfx_offhand_2h_vm_self_revive_box_v0_timeout.vfx";
        _id_1CB365D92187987B = "mp_equip_box_destroyed";
        equipname = "equip_self_revive_box";
        _id_5237A188CCDA4D7B = "super_self_revive_box";
        headicon = "hud_icon_fieldupgrade_self_revive_box";
        _id_598BA2BC14718181 = &"EQUIPMENT_HINTS/SELF_REVIVE_BOX_USE";
        break;
    }
  }

  grenade.timeoutvfxname = _id_1D40E40DAB99437E;
  grenade._id_F4556363AFB52110 = _id_1CB365D92187987B;
  box_used_common_setup(grenade, equipname, _id_5237A188CCDA4D7B, headicon);
  grenade thread supportbox_makeusable(equipname, _id_598BA2BC14718181);

  if(_id_5237A188CCDA4D7B == "super_armor_drop" || _id_5237A188CCDA4D7B == "super_ammo_drop")
    scripts\cp_mp\challenges::_id_D997435895422ECC(_id_5237A188CCDA4D7B, 0);
}

supportbox_hideandshowaftertime(time) {
  self endon("death");
  self endon("missile_stuck");
  _id_722684AF55E05749 = getdvarfloat("scr_support_box_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait(_id_722684AF55E05749);
  self.madedamageable = 1;
  supportbox_makedamageable();
  self setscriptablepartstate("visibility", "show", 0);
}

supportbox_unset() {
  if(0) {
    foreach(_id_6DC86F1EBED6034C in self.plantedsuperequip) {
      if(_id_6DC86F1EBED6034C.equipmentref == "equip_munitionsbox" || _id_6DC86F1EBED6034C.equipmentref == "equip_armorbox" || _id_6DC86F1EBED6034C.equipmentref == "equip_leaderbox") {
        _id_6DC86F1EBED6034C thread supportbox_destroy(1);
        scripts\mp\weapons::removeequip(_id_6DC86F1EBED6034C);
      }
    }
  }
}

supportbox_destroy(immediate, _id_4FAC8B8CE36E09F1, _id_D3F5CEB48370A22A) {
  if(!isDefined(immediate))
    immediate = !istrue(self.planted);

  timeoutvfxname = "vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx";

  if(isDefined(self.timeoutvfxname))
    timeoutvfxname = self.timeoutvfxname;

  _id_F4556363AFB52110 = "mp_equip_box_destroyed";

  if(isDefined(self._id_F4556363AFB52110))
    _id_F4556363AFB52110 = self._id_F4556363AFB52110;

  _id_C2D7D58BFAD1B1EE = 0;

  if(istrue(_id_D3F5CEB48370A22A))
    _id_C2D7D58BFAD1B1EE = supportbox_getcloseanimduration();

  _id_CBF7BE4F62A0DDB2 = 0;

  if(!istrue(immediate))
    _id_CBF7BE4F62A0DDB2 = 0.1;

  thread supportbox_delete(_id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1);
  moving_platform = undefined;
  _id_34A47D4B8F3A4596 = undefined;

  if(isDefined(self)) {
    fxorigin = self.origin;
    _id_92246546867D1D04 = anglesToForward(self.angles);
    _id_8BC9A39939178D82 = anglestoup(self.angles);
    _id_DFDFAA4E665B31FC = self getlinkedparent();

    if(isDefined(_id_DFDFAA4E665B31FC)) {
      moving_platform = _id_DFDFAA4E665B31FC;
      _id_34A47D4B8F3A4596 = moving_platform.origin - fxorigin;
    }

    self setscriptablepartstate("beacon", "neutral", 0);
    self setscriptablepartstate("hacked", "neutral", 0);

    if(istrue(_id_D3F5CEB48370A22A)) {
      self setscriptablepartstate("anims", "close", 0);
      wait(_id_C2D7D58BFAD1B1EE);
      self setscriptablepartstate("anims", "closedIdle", 0);
      wait 1;
    }

    if(isDefined(moving_platform) && isent(moving_platform))
      fxorigin = moving_platform.origin - _id_34A47D4B8F3A4596;

    playFX(scripts\engine\utility::getfx(timeoutvfxname), fxorigin, _id_92246546867D1D04, _id_8BC9A39939178D82);
    playsoundatpos(fxorigin, _id_F4556363AFB52110);
  }
}

supportbox_delete(_id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1) {
  self notify("death");
  self.isdestroyed = 1;
  self setCanDamage(0);

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  supportbox_removeheadicon();
  supportbox_makeunusable();
  _id_5237A188CCDA4D7B = "super_ammo_drop";

  if(isDefined(self.equipmentref) && self.equipmentref == "equip_armorbox")
    _id_5237A188CCDA4D7B = "super_armor_drop";
  else if(isDefined(self.equipmentref) && self.equipmentref == "equip_hauntedbox")
    _id_5237A188CCDA4D7B = "super_haunted_drop";
  else if(isDefined(self.equipmentref) && self.equipmentref == "equip_blastshieldbox")
    _id_5237A188CCDA4D7B = "super_blastshield_drop";
  else if(isDefined(self.equipmentref) && self.equipmentref == "equip_leaderbox")
    _id_5237A188CCDA4D7B = "super_leader_drop";

  if(_id_5237A188CCDA4D7B == "super_armor_drop" || _id_5237A188CCDA4D7B == "super_ammo_drop")
    self.owner scripts\cp_mp\challenges::_id_D997435895422ECC(_id_5237A188CCDA4D7B, 3, self.usedcount);

  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

supportbox_makeusable(_id_F4692D0892428480, hintstring) {
  scripts\common\interactive::interactive_addusedcallbacktoentity(_id_F4692D0892428480);
  self.playersused = [];
  self.usedcount = 0;
  self makeusable();
  self setusepriority(-1);
  self enablemissilehint(1);
  self setCursorHint("HINT_NOICON");
  self setHintString(hintstring);
  self setuserange(128);
  self setuseholdduration("duration_short");
  self sethintrequiresholding(0);
  self sethinttag("tag_use");
  thread supportbox_watchallplayeruse();
}

supportbox_makeunusable() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

supportbox_watchallplayeruse() {
  self endon("death");
  self endon("supportBox_makeUnusable");
  _id_47FACC6ABFF4FD71 = gettime();

  for(;;) {
    supportbox_updateplayersused();

    if(gettime() >= _id_47FACC6ABFF4FD71) {
      supportbox_updateplayerusevisibility();
      _id_47FACC6ABFF4FD71 = gettime() + 150;
    }

    waitframe();
  }
}

supportbox_updateplayerusevisibility() {
  _id_EF269077A28646EB = scripts\common\utility::playersnear(self.origin, 300);

  foreach(player in _id_EF269077A28646EB) {
    if(isDefined(player)) {
      if(!supportbox_playercanuse(player)) {
        self disableplayeruse(player);
        continue;
      }

      self enableplayeruse(player);
    }
  }
}

supportbox_updateplayersused() {
  foreach(player in self.playersused) {
    if(isDefined(player)) {
      entnum = player getentitynumber();

      if(!scripts\mp\utility\player::isreallyalive(player) && isDefined(self.playersused[entnum])) {
        self.playersused[entnum] = undefined;
        supportbox_updateheadicon(player);
      }
    }
  }
}

supportbox_playercanuse(player) {
  if(!scripts\mp\utility\player::isreallyalive(player))
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("crate_use"))
    return 0;

  if(player _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  if(isDefined(self.playersused[player getentitynumber()]))
    return 0;

  if(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))
    return 0;

  return 1;
}

supportbox_onplayeruse(player) {
  if(!isDefined(self.equipmentref)) {
    return;
  }
  if(self.equipmentref == "equip_blastshieldbox") {
    player scripts\mp\utility\perk::giveperk("specialty_blastshield");
    player _id_5762AC2F22202BA2::hudicontype("blastshield_box");
  } else {
    _id_12A372E8CAA042BB = player.primaryweapons;

    foreach(weaponobj in _id_12A372E8CAA042BB) {
      if(scripts\mp\utility\weapon::ismeleeonly(weaponobj) || scripts\mp\utility\weapon::issuperweapon(weaponobj) || _id_2669878CF5A1B6BC::iskillstreakweapon(weaponobj) || scripts\mp\utility\weapon::isgamemodeweapon(weaponobj)) {
        continue;
      }
      _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(weaponobj);
      _id_662B420C8B2FCB2D = undefined;

      if(scripts\mp\utility\weapon::issinglehitweapon(weaponobj))
        _id_662B420C8B2FCB2D = 1;
      else if(_id_CF4209C200F8BBF4 == "weapon_sniper")
        _id_662B420C8B2FCB2D = 1.5;
      else
        _id_662B420C8B2FCB2D = 3;

      if(istrue(weaponobj.hasalternate)) {
        _id_6890A4CE965BBA99 = weaponobj getaltweapon();
        _id_91093EF03654702C = weaponclass(_id_6890A4CE965BBA99);

        if(_id_91093EF03654702C == "grenade") {
          _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
          stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
          _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
          player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
        } else if(_id_6890A4CE965BBA99.type == "bullet") {
          if(_id_91093EF03654702C == "spread") {
            _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
            stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
            _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
            player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
          }
        } else {
          _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
          stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
          _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
          player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
        }
      }

      _id_2BE3302E3767CC7D = weaponclipsize(weaponobj);
      _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(weaponobj) * _id_662B420C8B2FCB2D;
      _id_26F669E2F4686446 = max(_id_2BE3302E3767CC7D, _id_26F669E2F4686446);
      stockammo = player getweaponammostock(weaponobj);
      _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);

      if(weaponmaxammo(weaponobj) <= player getweaponammostock(weaponobj)) {
        continue;
      }
      player setweaponammostock(weaponobj, _id_2AA9CAEF99C9AF77);
    }

    primary = player scripts\mp\equipment::getcurrentequipment("primary");

    if(isDefined(primary))
      player scripts\mp\equipment::incrementequipmentammo(primary, _id_BEA6F988C3FBB7A1(primary));

    _id_D7B9856A19F9B6B5 = player scripts\mp\equipment::getcurrentequipment("secondary");

    if(isDefined(_id_D7B9856A19F9B6B5))
      player scripts\mp\equipment::incrementequipmentammo(_id_D7B9856A19F9B6B5, _id_BEA6F988C3FBB7A1(_id_D7B9856A19F9B6B5));

    player _id_5762AC2F22202BA2::hudicontype("ammobox");
  }

  supportbox_playusesound(player);
  thread supportbox_onplayeruseanim();
  self._id_EE55BD57ABD7930B = 1;
  return 1;
}

_id_BEA6F988C3FBB7A1(_id_1189BD7FBE2861F8) {
  _id_930290D7F474A0AE = 1;

  switch (_id_1189BD7FBE2861F8) {
    case "equip_throwstar":
      _id_930290D7F474A0AE = 3;
      break;
    default:
      break;
  }

  return _id_930290D7F474A0AE;
}

supportbox_playusesound(player) {
  if(isDefined(player)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_armorbox" || self.equipmentref == "equip_blastshieldbox")
      player playsoundtoplayer("iw9_armor_crate_use", player);
    else if(isDefined(self.equipmentref) && self.equipmentref == "equip_leaderbox")
      player playsoundtoplayer("iw9_armor_crate_use", player);
    else
      player playsoundtoplayer("ammo_crate_use", player);
  }
}

supportbox_onplayeruseanim() {
  self endon("death");

  if(istrue(self.onuseanimplaying)) {
    return;
  }
  self setscriptablepartstate("anims", "openUse", 0);
  self.onuseanimplaying = 1;
  wait(supportbox_getuseanimduration());
  self setscriptablepartstate("anims", "openIdle", 0);
  self.onuseanimplaying = undefined;
}

supportbox_makedamageable() {
  if(isDefined(self.equipmentref)) {
    if(self.equipmentref == "equip_leaderbox")
      return;
  }

  _id_00B28C788C46E9A6 = scripts\engine\utility::_id_53C4C53197386572(self._id_D442547D75DFFD09._id_E53ECFD9F4FEF4FA, 100);
  thread scripts\mp\damage::monitordamage(_id_00B28C788C46E9A6, "hitequip", ::supportbox_handlefataldamage, ::supportbox_handledamage);
}

supportbox_handledamage(data) {
  if(data.meansofdeath == "MOD_IMPACT")
    return 0;

  _id_10D243B75EC6D6AE = !isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
  hits = undefined;

  if(isexplosivedamagemod(data.meansofdeath))
    hits = supportbox_explosivedamagetohits(data, _id_10D243B75EC6D6AE);
  else if(scripts\engine\utility::isbulletdamage(data.meansofdeath))
    hits = supportbox_bulletdamagetohits(data, _id_10D243B75EC6D6AE);

  if(isDefined(hits)) {
    hitstokill = scripts\engine\utility::_id_53C4C53197386572(self._id_D442547D75DFFD09._id_3B2A936A383DC038, 5);

    if(_id_10D243B75EC6D6AE)
      hitstokill = scripts\engine\utility::_id_53C4C53197386572(self._id_D442547D75DFFD09._id_363B330E28B6E214, 5);

    return int(ceil(min(1, hits / hitstokill) * self.maxhealth));
  }

  return data.damage;
}

supportbox_handlefataldamage(data) {
  supportbox_givepointsfordeath(data.attacker);
  thread supportbox_destroy(0, 1, 0);
}

supportbox_bulletdamagetohits(data, _id_10D243B75EC6D6AE) {
  _id_2DDCAF824AC5D676 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(data.objweapon, data.meansofdeath) && _id_10D243B75EC6D6AE, 2, 0);

  if(data.damage > 150)
    return _id_2DDCAF824AC5D676 + 10;

  if(data.damage >= 80)
    return _id_2DDCAF824AC5D676 + 5;
  else if(data.damage >= 30)
    return _id_2DDCAF824AC5D676 + 2;
  else
    return _id_2DDCAF824AC5D676 + 1;
}

supportbox_explosivedamagetohits(data, _id_10D243B75EC6D6AE) {
  if(data.damage > 200)
    return 20;

  if(data.damage > 70)
    return 10;
  else if(data.damage > 30)
    return 7;
  else
    return 2;
}

supportbox_removeowneroutline() {
  if(isDefined(self.outlineid))
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
}

supportbox_addheadicon(headicon) {
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], headicon, 20, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  supportbox_updateheadiconallplayers();
}

supportbox_removeheadicon() {
  if(isDefined(self.headiconbox)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconbox);
    self.headiconbox = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }
}

supportbox_givepointsfordeath(attacker) {
  if(!isDefined(self.owner) || istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");

    if(isDefined(self.weapon_name)) {
      if(self.weapon_name == "ammo_box_mp")
        attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_457FD36B5024C8F8");
      else
        attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_DE589684778B50E5");
    }
  }
}

supportbox_givexpforuse(player, eventname, _id_BF9F4947494D46BB, _id_5237A188CCDA4D7B) {
  if(isDefined(self.owner) && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
    if(self.owner != player)
      self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE(eventname);

    self.owner scripts\mp\utility\stats::incpersstat(_id_BF9F4947494D46BB, 1);
    self.owner scripts\mp\supers::combatrecordsupermisc(_id_5237A188CCDA4D7B);
    self.usedcount++;
  }
}

supportbox_onmovingplatformdeath(data) {
  supportbox_destroy(1);
}

_id_AB33FBBBB68EA535(data) {
  owner = self.owner;

  if(!isDefined(owner)) {
    return;
  }
  _id_19163E14365D9264 = owner scripts\mp\supers::getcurrentsuper();

  if(isDefined(_id_19163E14365D9264) && level.allowsupers) {
    if(!istrue(self._id_EE55BD57ABD7930B)) {
      _id_19163E14365D9264.wasrefunded = 1;
      owner scripts\mp\supers::setsuperbasepoints(owner scripts\mp\supers::getsuperpointsneeded());
    }
  }

  supportbox_destroy(1);
}

_id_225B99924F316BC1(dropstruct, player, scriptablename, _id_416102A18FC1FD69, weaponobj, _id_6D6F8D51A1B7B6CD) {
  if(!isDefined(self._id_74A4E2FA253C5BE8))
    self._id_74A4E2FA253C5BE8 = 50;

  _id_279A4854B51C5AF2 = (0, randomfloatrange(60, 90), 0);

  if(isDefined(_id_6D6F8D51A1B7B6CD))
    _id_279A4854B51C5AF2 = _id_6D6F8D51A1B7B6CD;

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles + _id_279A4854B51C5AF2, player, undefined, self._id_74A4E2FA253C5BE8);
  item = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_416102A18FC1FD69, 1, weaponobj, 0);
}

supportbox_handlemovingplatforms(stuckto) {
  data = spawnStruct();
  data.linkparent = stuckto;
  data.deathoverridecallback = ::supportbox_onmovingplatformdeath;
  data.invalidparentoverridecallback = ::_id_AB33FBBBB68EA535;
  data.endonstring = "death";
  data.validateaccuratetouching = 1;

  if(isDefined(stuckto) && scripts\cp_mp\utility\train_utility::is_train_ent(stuckto)) {
    data._id_49CB2C45D3230ED8 = 1;
    self _meth_7E73001E97FE87B9(1);
  }

  thread scripts\mp\movers::handle_moving_platforms(data);
}

supportbox_watchdisownedtimeout() {
  self endon("death");
  supportbox_watchdisownedtimeoutinternal();

  if(isDefined(self) && !istrue(self.isdestroyed))
    thread supportbox_destroy(1);
}

supportbox_watchdisownedtimeoutinternal() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(60);
}

supportbox_empapplied(data) {
  attacker = data.attacker;
  supportbox_givepointsfordeath(attacker);
  thread supportbox_destroy(1);
}

_id_F7BD40787418DF02(data) {
  attacker = data.attacker;
  supportbox_givepointsfordeath(attacker);
  thread supportbox_destroy(1);
}

supportbox_updateheadiconallplayers() {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }
    supportbox_updateheadicon(player);
  }
}

supportbox_updateheadicon(player) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  _id_E8333833A81B6F0D = self.headiconbox;

  if(!isDefined(_id_E8333833A81B6F0D)) {
    return;
  }
  _id_D39DEA1586E13C6C = self.headiconfaction;

  if(!isDefined(_id_D39DEA1586E13C6C)) {
    return;
  }
  isfriendly = scripts\mp\utility\player::isfriendly(self.owner.team, player);
  isused = isDefined(self.playersused) && isDefined(self.playersused[player getentitynumber()]);

  if(isfriendly && !isused) {
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_E8333833A81B6F0D, player);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_D39DEA1586E13C6C, player);
  } else if(isfriendly) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_E8333833A81B6F0D, player);
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_D39DEA1586E13C6C, player);
  } else {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_E8333833A81B6F0D, player);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_D39DEA1586E13C6C, player);
  }
}

#using_animtree("scriptables");

supportbox_getdeployanimduration() {
  switch (self.equipmentref) {
    case "equip_armorbox":
      return getanimlength(%wm_armor_box_ground_open);
    case "equip_hauntedbox":
      return getanimlength(%wm_hbox_ground_open);
    default:
      return getanimlength(%wm_support_box_ground_open);
  }
}

supportbox_getuseanimduration() {
  switch (self.equipmentref) {
    case "equip_hauntedbox":
      return getanimlength(%wm_hbox_ground_idle_open_use);
    default:
      return getanimlength(%wm_support_box_ground_idle_open_use);
  }
}

supportbox_getcloseanimduration() {
  switch (self.equipmentref) {
    case "equip_armorbox":
      return getanimlength(%wm_armor_box_ground_close);
    case "equip_hauntedbox":
      return getanimlength(%wm_hbox_ground_close);
    default:
      return getanimlength(%wm_support_box_ground_close);
  }
}

supportbox_usedcallback(entity, player) {
  if(istrue(player.isjuggernaut) && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");

    return;
  }

  if(entity supportbox_playercanuse(player)) {
    _id_53D437E6C2B6037E = 0;
    eventname = undefined;
    _id_BF9F4947494D46BB = undefined;
    _id_5237A188CCDA4D7B = undefined;

    if(isDefined(entity.equipmentref)) {
      switch (entity.equipmentref) {
        case "equip_munitionsbox":
          eventname = "stat_DECD39D6AECA5C6C";
          _id_BF9F4947494D46BB = "munitionsBoxUsed";
          _id_5237A188CCDA4D7B = "super_ammo_drop";

          if(isDefined(level.onsupportboxusedbyplayer))
            _id_53D437E6C2B6037E = entity[[level.onsupportboxusedbyplayer]](player);
          else
            _id_53D437E6C2B6037E = entity supportbox_onplayeruse(player);

          break;
        case "equip_armorbox":
          eventname = "stat_0511C5E7CABBCE4D";
          _id_BF9F4947494D46BB = "armorBoxUsed";
          _id_5237A188CCDA4D7B = "super_armor_drop";

          if(isDefined(level.onarmorboxusedbyplayer))
            _id_53D437E6C2B6037E = entity[[level.onarmorboxusedbyplayer]](player);

          break;
        case "equip_hauntedbox":
          eventname = "stat_DECD39D6AECA5C6C";
          _id_BF9F4947494D46BB = "hauntedBoxUsed";
          _id_5237A188CCDA4D7B = "super_haunted_drop";
          _id_8467CAAA6FE5FE32 = undefined;
          _id_AE6D0DFE3A2DBA21 = undefined;
          _id_4F91AE66BDDB86B4 = undefined;
          dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
          entity.dropstruct = dropstruct;

          if(isDefined(level.onarmorboxusedbyplayer))
            _id_8467CAAA6FE5FE32 = entity[[level.onarmorboxusedbyplayer]](player, dropstruct);

          if(isDefined(level.onsupportboxusedbyplayer))
            _id_AE6D0DFE3A2DBA21 = entity[[level.onsupportboxusedbyplayer]](player, dropstruct);

          if(isDefined(level._id_82DFE148CED1F477))
            _id_4F91AE66BDDB86B4 = entity[[level._id_82DFE148CED1F477]](player);

          _id_53D437E6C2B6037E = istrue(_id_8467CAAA6FE5FE32) && istrue(_id_AE6D0DFE3A2DBA21) && istrue(_id_4F91AE66BDDB86B4);
          break;
        case "equip_blastshieldbox":
          eventname = "stat_54106EC746CC7885";
          _id_BF9F4947494D46BB = "blastshieldBoxUsed";
          _id_5237A188CCDA4D7B = "super_blastshield_drop";
          _id_53D437E6C2B6037E = entity supportbox_onplayeruse(player);
          break;
        case "equip_leaderbox":
          eventname = "stat_07986E8DCCDEE31D";
          _id_BF9F4947494D46BB = "leaderBoxUsed";
          _id_5237A188CCDA4D7B = "super_leader_drop";

          if(isDefined(level._id_F24AE0993EFCA48F))
            _id_53D437E6C2B6037E = entity[[level._id_F24AE0993EFCA48F]](player);

          break;
        case "equip_self_revive_box":
          eventname = "stat_DD967DB653B981B4";
          _id_BF9F4947494D46BB = "selfReviveBoxUsed";
          _id_5237A188CCDA4D7B = "super_self_revive_box";

          if(isDefined(level._id_130BC3F5F33BB97D))
            _id_53D437E6C2B6037E = entity[[level._id_130BC3F5F33BB97D]](player);

          break;
        default:
          break;
      }

      if(_id_53D437E6C2B6037E) {
        entity.playersused[player getentitynumber()] = player;
        entity supportbox_updateheadicon(player);
        entity supportbox_givexpforuse(player, eventname, _id_BF9F4947494D46BB, _id_5237A188CCDA4D7B);

        if(isDefined(entity._id_74A4E2FA253C5BE8))
          entity._id_74A4E2FA253C5BE8 = entity._id_74A4E2FA253C5BE8 + 10;
      }
    }
  }
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}