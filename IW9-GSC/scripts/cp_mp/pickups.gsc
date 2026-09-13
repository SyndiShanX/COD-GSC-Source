/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\pickups.gsc
***********************************************/

issuperpickup(scriptablename) {
  return !isnonequippable(scriptablename) && (isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "super");
}

_id_D7C5786A0C42EF6C(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tactical";
}

isnonequippable(scriptablename) {
  return scriptablename == "br_loot_cache" || isquesttablet(scriptablename);
}

isquesttablet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "tablet";
}

isplunder(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "plunder";
}

_id_609BB538ED61B8D7(scriptablename) {
  return isDefined(scriptablename) && (scriptablename == "brloot_backpack" || scriptablename == "brloot_backpack_medium" || scriptablename == "brloot_backpack_large" || scriptablename == "brloot_backpack_player_small" || scriptablename == "brloot_backpack_player_medium" || scriptablename == "brloot_backpack_player_large");
}

isperkpointpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "perkpoint";
}

isammo(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "ammo";
}

_id_7897CA6463069464(scriptablename) {
  return isDefined(scriptablename) && scriptablename == "br_plunder_box";
}

_id_B904849EA30D653F(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "powerup";
}

isequipment(scriptablename) {
  return isarmorplate(scriptablename) || ishealitem(scriptablename) || isDefined(level.br_pickups.br_itemtype[scriptablename]) && (level.br_pickups.br_itemtype[scriptablename] == "lethal" || level.br_pickups.br_itemtype[scriptablename] == "tactical");
}

ishealitem(scriptablename) {
  return scriptablename == "brloot_health_bandages" || scriptablename == "brloot_health_firstaid" || scriptablename == "brloot_health_adrenaline";
}

isrevivepickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "revive";
}

isarmor(scriptablename) {
  return ishelmet(scriptablename);
}

ishelmet(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "armor" && issubstr(scriptablename, "helmet");
}

isarmorplate(scriptablename) {
  return scriptablename == "brloot_armor_plate";
}

_id_F262C137ED78E6EB(scriptablename) {
  return issubstr(scriptablename, "activity_starter");
}

_id_233D8364992B23B4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "attachment";
}

isaccesscard(scriptablename) {
  return issubstr(scriptablename, "access_card");
}

_id_E066D6B70DDA15F1(scriptablename) {
  return issubstr(scriptablename, "brloot_xp");
}

isgasmask(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gear" && issubstr(scriptablename, "gasmask");
}

iskillstreak(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "killstreak";
}

_id_4294E9B331377C31(scriptablename) {
  return scriptablename == "brloot_plate_carrier_high_capacity";
}

_id_7E2F2A69FC0C022B(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "valuable";
}

_id_EAC097CE4C683AB9(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "personal";
}

_id_CB1E30930C35F2E2(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "nvg";
}

_id_5449DA9D3D0358A4(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gascan";
}

_id_32125EBA262380C7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "mission";
}

_id_9E3428357E5DF2E3(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "dogtag";
}

_id_55F0DAEA8408E3A9(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "weaponCase";
}

_id_F92615E29AFF3602(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "questitem_misc";
}

isweaponpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "weapon";
}

_id_B989EDD9AF4F42C7(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "lethal";
}

_id_A45EE992E46A29F1(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "cache";
}

_id_4AA12E0ED3F6B745(scriptablename) {
  return scriptablename == "brloot_plate_carrier_2" || scriptablename == "brloot_plate_carrier_3";
}

_id_82D45592D750D388(scriptablename) {
  return issubstr(scriptablename, "loot_key") || issubstr(scriptablename, "loot_multi_key");
}

_id_692C3DF266580DF6(scriptablename) {
  if(scriptablename == "brloot_plate_carrier_2")
    return 2;

  if(scriptablename == "brloot_plate_carrier_3")
    return 3;

  return 1;
}

_id_7094C7010C5E3827(team) {
  return isDefined(level._id_41F4BC9EE8C7C9C6) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF) && isDefined(level._id_41F4BC9EE8C7C9C6._id_B6FAE9C9655C73BF[team]);
}

_id_6B5F3FB6550AE6D5(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "gear" && issubstr(scriptablename, "iodine_pills");
}

istokenpickup(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "token";
}

_id_362D5A8D49B93721(scriptablename) {
  return isDefined(level.br_pickups.br_itemtype[scriptablename]) && level.br_pickups.br_itemtype[scriptablename] == "note";
}

takegenericgrenadepickup(pickupent) {
  ammocount = _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");

  if(isDefined(ammocount) && ammocount < 2)
    _id_7EF95BBA57DC4B82::incrementequipmentslotammo("primary");

  ammocount = _id_7EF95BBA57DC4B82::getequipmentslotammo("secondary");

  if(isDefined(ammocount) && ammocount < 2)
    _id_7EF95BBA57DC4B82::incrementequipmentslotammo("secondary");
}

takerespawntokenpickup(pickupent) {
  if(!respawntokendisabled() && !hasrespawntoken()) {
    addrespawntoken();
    return 1;
  }

  return 0;
}

hasrespawntoken() {
  player = self;
  return istrue(player.hasrespawntoken);
}

respawntokendisabled() {
  return getdvarint("dvar_4D250E4873E1753E", 0) || !istrue(level.br_pickups.respawntokenenabled) || istrue(level.br_pickups.respawntokenclosewithgulag) && isDefined(level.gulag) && istrue(level.gulag.shutdown);
}

addrespawntoken(skipsplash) {
  player = self;
  player.hasrespawntoken = 1;
  player sethasrespawntokenextrainfo(1);

  if(!istrue(skipsplash))
    player thread scripts\cp\cp_hud_message::showsplash("br_respawn_token_pickup");
}

sethasrespawntokenextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 32768;
  else
    self.game_extrainfo = self.game_extrainfo &~32768;
}

fillmaxarmorplate() {
  player = self;
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = "brloot_armor_plate";
  _id_60227BFF1E9478CC.equipname = level.br_pickups.br_equipname[_id_60227BFF1E9478CC.scriptablename];
  _id_60227BFF1E9478CC.origin = self.origin;
  _id_60227BFF1E9478CC.maxcount = _id_7EF95BBA57DC4B82::getequipmentmaxammo(_id_60227BFF1E9478CC.equipname);
  _id_60227BFF1E9478CC.count = _id_60227BFF1E9478CC.maxcount;
  _id_60227BFF1E9478CC.stackable = level.br_pickups.stackable[_id_60227BFF1E9478CC.scriptablename];
  player _id_66122A002AFF5D57::takeequipmentpickup(_id_60227BFF1E9478CC);
}

addplatepouch(skipsplash) {
  player = self;

  if(getdvarint("scr_br_skiplegendarypickupsound", 0) == 0)
    self playsoundtoplayer("br_legendary_loot_pickup", self);

  player.hasplatepouch = 1;
  player setclientomnvar("ui_br_has_plate_pouch", 1);

  if(!istrue(skipsplash))
    player thread scripts\cp\cp_hud_message::showsplash("br_plate_pouch_pickup");
}

hasplatepouch() {
  player = self;
  return istrue(player.hasplatepouch);
}

takekillstreakpickup(pickupent, _id_7F437A5779C8787C, _id_DB943473454F6EA6) {}

_id_A7CC24F3A189746A(_id_A4E8372932B8612C) {}

_id_381D14FB6E6ACA9A(_id_A4E8372932B8612C) {}

playercanplaynotcriticalgesture() {
  if(self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]() || istrue(self.insertingarmorplate))
    return 0;

  _id_04A8F5643E919524 = self getcurrentweapon();

  if(isnullweapon(_id_04A8F5643E919524))
    return 0;

  return 1;
}

_id_F4361EA8CE0FBCA4() {
  _id_A7408DBFED49F3F9 = makeweapon("iw8_ges_plyr_loot_pickup");

  if(self hasweapon(_id_A7408DBFED49F3F9)) {
    if(self isgestureplaying("iw8_ges_pickup_br"))
      self stopgestureviewmodel("iw8_ges_pickup_br", 0, 1);

    self takeweapon(_id_A7408DBFED49F3F9);
    waitframe();
  }
}

_id_DB908ECACCBE933C(_id_EA3E3B2121E6713A, _id_421750C958BD3064) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "drop_item":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == _id_4967838290CB31B9(_id_3793828403C6873E)) {
          break;
        }

        if(isDefined(level._id_71AFB87754F28AF8)) {
          if(!self[[level._id_71AFB87754F28AF8]](itemtype, _id_3793828403C6873E))
            return;
        }

        if(!_id_AA47C359A5DB6132()) {
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANNOT_DROP_NOW");
          return;
        }

        _id_17A208DE8E7CD188 = _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();

        if(isDefined(_id_17A208DE8E7CD188) && _id_17A208DE8E7CD188 == "kitMedic" && itemtype == 7 && scripts\cp\utility::_id_138028CA2B958511()) {
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANNOT_DROP_NOW");
          return;
        }

        if(istrue(self._id_23A6763562820C70) && self _meth_E40102956C887F7C() && itemtype == 1) {
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          scripts\cp\cp_hud_message::showerrormessage("COOP_GAME_PLAY/CANT_DROP_WEAPON_WHILE_SWIMMING");
          return;
        }

        thread quickdropitem(itemtype, _id_3793828403C6873E);
        break;
      case "drop_stock_ammo":
        _id_3793828403C6873E = _id_421750C958BD3064;
        _id_DE88CD14114C1E24 = _id_13ECF3644442A3E7(self, _id_3793828403C6873E);

        if(!isDefined(_id_DE88CD14114C1E24)) {
          break;
        }

        ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

        if(isDefined(ammotype) && isDefined(self.br_ammo[ammotype]) && self.br_ammo[ammotype] > 0) {
          _id_CD87B28B548D9F4A = level.br_pickups.counts[ammotype];

          if(!isDefined(_id_CD87B28B548D9F4A)) {
            break;
          }

          _id_1F11155517C54C34 = int(min(self.br_ammo[ammotype], _id_CD87B28B548D9F4A));
          _id_74806F0C4CAA7E55 = _id_1F11155517C54C34;
          _id_975C95468376CEE8 = self getweaponammostock(_id_DE88CD14114C1E24);

          if(self.br_ammo[ammotype] > _id_975C95468376CEE8) {
            _id_74806F0C4CAA7E55 = _id_1F11155517C54C34 + self.br_ammo[ammotype] - _id_975C95468376CEE8;

            if(_id_74806F0C4CAA7E55 > self.br_ammo[ammotype]) {
              _id_1F11155517C54C34 = _id_975C95468376CEE8;
              _id_74806F0C4CAA7E55 = self.br_ammo[ammotype];
            }
          }

          if(_id_1F11155517C54C34 > 0)
            quickdropnewitem(10, ammotype, _id_1F11155517C54C34);

          br_ammo_take_type(self, ammotype, _id_74806F0C4CAA7E55);
        }

        break;
      case "drop_all_items":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == _id_4967838290CB31B9(_id_3793828403C6873E)) {
          break;
        }

        if(isDefined(level._id_71AFB87754F28AF8)) {
          if(!self[[level._id_71AFB87754F28AF8]](itemtype, _id_3793828403C6873E))
            return;
        }

        if(!_id_AA47C359A5DB6132()) {
          _id_66122A002AFF5D57::_id_F0A8D592BDDE9818();
          scripts\cp\cp_hud_message::showerrormessage("WEAPON/CANNOT_DROP_EQUIPMENT");
          return;
        }

        quickdropall(itemtype, _id_3793828403C6873E);
        break;
      case "backpack_equip":
        itemtype = _id_86081F65C04E8EBE(_id_421750C958BD3064);
        _id_3793828403C6873E = _id_AB41ACC7AC2F6642(_id_421750C958BD3064);

        if(istrue(self.insertingarmorplate) && itemtype == 2 && "health" == _id_4967838290CB31B9(_id_3793828403C6873E)) {
          break;
        }

        if(itemtype == 1 && _id_3793828403C6873E == 2)
          _id_F5A1A13F0181BB66(self);
        else
          thread _id_CAB3366841D709AA(_id_3793828403C6873E);

        break;
      default:
        break;
    }
  }
}

_id_AA47C359A5DB6132() {
  if(self isgestureplaying()) {
    if(!self isgestureplaying("iw9_vm_ges_quickdraw_lhand_offset"))
      return 1;
  }

  if(self isthrowinggrenade())
    return 0;
  else
    return 1;
}

_id_86081F65C04E8EBE(_id_421750C958BD3064) {
  return (_id_421750C958BD3064 & 65280) >> 8;
}

_id_AB41ACC7AC2F6642(_id_421750C958BD3064) {
  return _id_421750C958BD3064 & 255;
}

_id_CAB3366841D709AA(itemslotindex) {
  [lootid, quantity] = _id_6738846DA50730F1(itemslotindex);
  _id_CB325DDB4A764623 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(_id_CB325DDB4A764623 == "dmz_nvg") {
    if(self isnightvisionon())
      self nightvisionviewoff(1);
    else
      self nightvisionviewon(1);

    return;
  }

  if(!isDefined(_id_CB325DDB4A764623) || isDefined(_id_CB325DDB4A764623) && !isammo(_id_CB325DDB4A764623))
    _id_FE539E37B6579930(lootid, quantity, itemslotindex, undefined, 1);
}

_id_6738846DA50730F1(index) {
  lootid = _id_6196D9EA9A30E609(index);
  quantity = _id_897B29ADB37F06A7(index);
  return [lootid, quantity];
}

quickdropitem(itemtype, _id_3793828403C6873E, _id_180513E5B195F19A) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, 0, _id_180513E5B195F19A);
}

quickdropall(itemtype, _id_3793828403C6873E) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  _id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, 1);
}

_id_F95A2789CE5B15FF(itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  switch (itemtype) {
    case 0:
      _id_8AAB3CDA02F81C09(self, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 1:
      _id_62F068CEC343A111(self, itemtype, _id_3793828403C6873E, undefined, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 10:
      _id_6F62CB4FC113349C(self, itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 2:
      _id_B130392812B25580(self, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 3:
      _id_1503D0B5B4C9D010(self, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 4:
      _id_B15E36B7BC247DDB(self, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    case 6:
      _id_750E9A7F11BECD51(self, _id_180513E5B195F19A);
      break;
    case 7:
      _id_8F803EA058A13CBD(self, _id_180513E5B195F19A);
      break;
    case 5:
      _id_52DF07E94B3CE0DF(self, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A);
      break;
    default:
      return;
  }
}

_id_8AAB3CDA02F81C09(player, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_9BE70D6D4FF253A1 = getquickdropplundercount(_id_53AAAE2C915F815B);

  if(_id_9BE70D6D4FF253A1 == 0)
    return 0;

  player playerplunderdrop(_id_9BE70D6D4FF253A1);
  _id_8E5DD667F5BF1E1E = level.br_plunder.names[0];

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(_id_9BE70D6D4FF253A1 > level.br_plunder.quantity[_id_AC0E594AC96AA3A8])
      _id_8E5DD667F5BF1E1E = level.br_plunder.names[_id_AC0E594AC96AA3A8];
  }

  if(istrue(_id_180513E5B195F19A))
    return 1;

  if(_id_9BE70D6D4FF253A1 >= 2500) {
    for(_id_B72D8066EFDFD136 = _id_9BE70D6D4FF253A1; _id_B72D8066EFDFD136 > 0; _id_B72D8066EFDFD136 = _id_B72D8066EFDFD136 - _id_CFCB8FC02F9DB4DC) {
      _id_CFCB8FC02F9DB4DC = scripts\engine\utility::ter_op(_id_B72D8066EFDFD136 > 2000, 2000, _id_B72D8066EFDFD136);
      quickdropnewitem(itemtype, _id_8E5DD667F5BF1E1E, _id_CFCB8FC02F9DB4DC);
    }
  } else
    quickdropnewitem(itemtype, _id_8E5DD667F5BF1E1E, _id_9BE70D6D4FF253A1);

  return 1;
}

_id_62F068CEC343A111(player, itemtype, _id_3793828403C6873E, _id_9BE70D6D4FF253A1, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_0EC22A950F210E39 = _id_13ECF3644442A3E7(player, _id_3793828403C6873E);

  if(!isDefined(_id_0EC22A950F210E39) || _id_0D3C77884D93D850(_id_0EC22A950F210E39) || _id_DAACAC69B2A7457D(_id_0EC22A950F210E39) || _id_0DCC09902E277B83::_id_76CA0B3D8B2555CA(_id_0EC22A950F210E39)) {
    return;
  }
  _id_9BE70D6D4FF253A1 = 0;
  _id_59BD51AFC73DF2CD = 0;
  _id_DAB81EAD77442A10 = 0;
  weaponobj = undefined;

  if(!isDefined(_id_0EC22A950F210E39) || isnullweapon(_id_0EC22A950F210E39) || _id_0EC22A950F210E39 == makeweapon("iw9_me_fists_mp") || self isskydiving())
    return 0;
  else {
    _id_9BE70D6D4FF253A1 = player getweaponammoclip(_id_0EC22A950F210E39);
    _id_59BD51AFC73DF2CD = player getweaponammoclip(_id_0EC22A950F210E39, "left");

    if(_id_0EC22A950F210E39.hasalternate) {
      _id_6890A4CE965BBA99 = _id_0EC22A950F210E39 getaltweapon();
      _id_DAB81EAD77442A10 = player getweaponammoclip(_id_6890A4CE965BBA99);
    }

    weaponobj = _id_0EC22A950F210E39;
  }

  _id_62F068CEC343A111 = getquickdropweapon(_id_3793828403C6873E);

  if(_id_3793828403C6873E == 2)
    _id_590202DAF6A1D4D7(player);
  else
    _id_D655F2006CFE7789(_id_0EC22A950F210E39);

  if(istrue(_id_180513E5B195F19A))
    return 1;

  quickdropnewitem(itemtype, _id_62F068CEC343A111, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj);
  return 1;
}

_id_13ECF3644442A3E7(player, _id_3793828403C6873E) {
  if(_id_3793828403C6873E == 2)
    return _id_66122A002AFF5D57::_id_2985254128B1C262(player);

  weaponlist = player getweaponslistprimaries();
  _id_BE28C7BBF8BD3F10 = _id_3793828403C6873E == 0;

  foreach(weapon in weaponlist) {
    if(_id_0D3C77884D93D850(weapon))
      continue;
    else if(weaponinventorytype(weapon) == "altmode")
      continue;
    else if(_id_BE28C7BBF8BD3F10)
      return weapon;
    else
      _id_BE28C7BBF8BD3F10 = 1;
  }
}

_id_0D3C77884D93D850(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_me_diveknife_mp" || weaponname == "iw9_swimfists_mp";
}

_id_DAACAC69B2A7457D(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_me_climbfists_mp" || weaponname == "iw9_me_climbfists";
}

_id_590202DAF6A1D4D7(player) {
  player setplayerdata("cp", "dmzWeapon", "weapon", "none");
  player setplayerdata("cp", "dmzWeapon", "lootItemID", 0);
  player setplayerdata("cp", "dmzWeapon", "camo", "none");
  player setplayerdata("cp", "dmzWeapon", "reticle", "none");
  player setplayerdata("cp", "dmzWeapon", "cosmeticAttachment", "none");
  player setplayerdata("cp", "dmzWeapon", "variantID", 0);
  player setplayerdata("cp", "dmzWeapon", "blueprintName", "");

  for(_id_40E4B9C48B36C9EC = 0; _id_40E4B9C48B36C9EC < 5; _id_40E4B9C48B36C9EC++) {
    player setplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_40E4B9C48B36C9EC, "attachment", "none");
    player setplayerdata("cp", "dmzWeapon", "attachmentSetup", _id_40E4B9C48B36C9EC, "variantID", 0);
  }

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
    player setplayerdata("cp", "dmzWeapon", "sticker", _id_36D2ABBDCBCB186C, "none");
}

_id_D655F2006CFE7789(_id_0EC22A950F210E39) {
  _id_3184653FDF31DB44 = makeweapon("iw9_me_fists_mp");
  _id_102D661B1CAA8BC1 = _id_3184653FDF31DB44;
  primaryweapons = self getweaponslistprimaries();

  foreach(weapon in primaryweapons) {
    if(weapon.inventorytype != "primary") {
      continue;
    }
    if(weapon != _id_3184653FDF31DB44 && weapon != _id_0EC22A950F210E39 && !_id_74502A9E0EF1F19C::ismeleeoverrideweapon(weapon) && !_id_0D3C77884D93D850(weapon)) {
      _id_102D661B1CAA8BC1 = weapon;
      break;
    }
  }

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(_id_0EC22A950F210E39)) {
    _id_D1AD88BF84DAA67F = self getweaponammostock(_id_0EC22A950F210E39);
    _id_811ABFDB6C33F17F = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_0EC22A950F210E39);

    if(isDefined(_id_811ABFDB6C33F17F)) {
      self.br_ammo[_id_811ABFDB6C33F17F] = min(_id_D1AD88BF84DAA67F, level._id_E6EA72FC5E3FCD00[_id_811ABFDB6C33F17F]);
      self.br_ammo[_id_811ABFDB6C33F17F] = _id_66122A002AFF5D57::get_int_or_0(self.br_ammo[_id_811ABFDB6C33F17F]);
    }
  }

  if(_id_2669878CF5A1B6BC::isminigunweapon(_id_0EC22A950F210E39))
    self notify("dropped_minigun");

  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_0EC22A950F210E39);

  if(!self hasweapon(_id_3184653FDF31DB44))
    self giveweapon(_id_3184653FDF31DB44);

  _id_66122A002AFF5D57::br_ammo_update_weapons(self);

  if(_id_1B4114093CD44368::_id_23A6763562820C70()) {
    return;
  }
  self switchtoweaponimmediate(_id_102D661B1CAA8BC1);
}

_id_4967838290CB31B9(index) {
  switch (index) {
    case 0:
      return "primary";
    case 1:
      return "secondary";
    case 2:
      return "health";
    default:
  }
}

_id_F5A1A13F0181BB66(player) {
  _id_358E8D9068997399 = _id_66122A002AFF5D57::_id_D9B1550011525161(player);
  _id_280ABCD08CBDCC79 = _id_66122A002AFF5D57::_id_2985254128B1C262(player);

  if(isDefined(player._id_3EF503345DC57957))
    count = player._id_3EF503345DC57957;
  else
    count = weaponclipsize(_id_280ABCD08CBDCC79);

  _id_E97D731BEDD44C63 = undefined;

  if(_id_280ABCD08CBDCC79.hasalternate && isDefined(player._id_86B32AFF94B5714E))
    _id_E97D731BEDD44C63 = player._id_86B32AFF94B5714E;
  else
    _id_E97D731BEDD44C63 = weaponclipsize(_id_280ABCD08CBDCC79 getaltweapon());

  _id_590202DAF6A1D4D7(player);
  _id_FE539E37B6579930(_id_358E8D9068997399, count, undefined, _id_E97D731BEDD44C63);
}

_id_FE539E37B6579930(lootid, quantity, itemslotindex, _id_E97D731BEDD44C63, _id_44EE85DCF52B4001) {
  scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(scriptablename)) {
    return;
  }
  if(issuperpickup(scriptablename)) {
    if(_id_56EF8D52FE1B48A1::issuperinuse()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/SUPERS_UNAVAILABLE_EQUIP");

      return;
    }

    if(isDefined(self.equipment["super"])) {
      _id_57B0241752598E4A = scripts\engine\utility::array_find(level.br_pickups.br_equipname, self.equipment["super"]);

      if(_id_57B0241752598E4A == scriptablename)
        return;
    }
  }

  _id_BADA25504E8844D7 = spawnStruct();
  _id_BADA25504E8844D7.scriptablename = scriptablename;
  _id_BADA25504E8844D7.origin = self.origin;
  _id_BADA25504E8844D7.count = quantity;
  _id_BADA25504E8844D7.maxcount = level.br_pickups.maxcounts[scriptablename];
  _id_BADA25504E8844D7.stackable = level.br_pickups.stackable[scriptablename];

  if(isDefined(_id_E97D731BEDD44C63))
    _id_BADA25504E8844D7._id_E97D731BEDD44C63 = _id_E97D731BEDD44C63;

  _id_BADA25504E8844D7.countlefthand = 0;

  if(iskillstreak(scriptablename) || issuperpickup(scriptablename))
    _id_BADA25504E8844D7.count = 1;

  _id_66122A002AFF5D57::onusecompleted(_id_BADA25504E8844D7, undefined, 1, 0, itemslotindex, undefined, _id_44EE85DCF52B4001);
}

quickdropnewitem(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj) {
  _id_285B7129B392CF3D = quickdropaddtoexisting(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj);

  if(_id_285B7129B392CF3D) {
    return;
  }
  slot = _id_4F4D537C794B2BF5();
  thread _id_1E450ADBA8DDC914();
  _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(slot, self.origin, self.angles, self);
  _id_0E14905A4CDF3B12 = _id_66122A002AFF5D57::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_9BE70D6D4FF253A1, 1, weaponobj, 0, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
  quickdropaddtocache(scriptablename, slot, _id_0E14905A4CDF3B12, _id_CB4FAD49263E20C4.origin, _id_CB4FAD49263E20C4.angles);

  if(isDefined(weaponobj)) {
    level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0E14905A4CDF3B12, self, weaponobj);

    if(_id_66122A002AFF5D57::_id_B1DD9DCAE2F63965())
      _id_8E7E1DA48D7746E5(self, _id_0E14905A4CDF3B12);
  }

  if(isplunder(scriptablename))
    scriptablename = _id_66122A002AFF5D57::getplundernamebyamount(_id_9BE70D6D4FF253A1);

  scripts\cp_mp\calloutmarkerping::_id_1062F2AF5C7D843E(scriptablename, weaponobj);
  quickdropplaySound(itemtype, _id_CB4FAD49263E20C4.origin, scriptablename, _id_0E14905A4CDF3B12, weaponobj);
  return _id_0E14905A4CDF3B12;
}

quickdropaddtoexisting(itemtype, scriptablename, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10, weaponobj) {
  _id_9DC4EDEE6E76287A = quickdropfinditemincache(scriptablename);

  if(isDefined(_id_9DC4EDEE6E76287A)) {
    _id_B3CE3FBCFC181AEF = _id_9DC4EDEE6E76287A.ent;
    _id_E5D77BF46A926594 = _id_9DC4EDEE6E76287A.droporigin;
    _id_C36E41058FF56216 = _id_9DC4EDEE6E76287A.dropangles;
    _id_E669DCD7466F65D9 = _id_66122A002AFF5D57::loot_getitemcount(_id_B3CE3FBCFC181AEF);
    _id_74B23B8EEA29A555 = _id_66122A002AFF5D57::loot_getitemcountlefthand(_id_B3CE3FBCFC181AEF);
    _id_4FF1E9F60BCF8FE8 = _id_66122A002AFF5D57::_id_3A5F7703319142DD(_id_B3CE3FBCFC181AEF);

    if(!ispickupstackable(scriptablename) && !issubstr(_id_9DC4EDEE6E76287A.ent.type, "_cash"))
      return 0;

    _id_CFCB8FC02F9DB4DC = _id_E669DCD7466F65D9 + _id_9BE70D6D4FF253A1;

    if(issubstr(_id_9DC4EDEE6E76287A.ent.type, "_cash")) {
      if(_id_CFCB8FC02F9DB4DC >= 2500)
        return 0;
    }

    if(!isDefined(_id_59BD51AFC73DF2CD))
      _id_59BD51AFC73DF2CD = 0;

    _id_9E57DC7AFE8604C8 = _id_74B23B8EEA29A555 + _id_59BD51AFC73DF2CD;

    if(!isDefined(_id_DAB81EAD77442A10))
      _id_DAB81EAD77442A10 = 0;

    _id_A69B5A02FFAE97FF = _id_4FF1E9F60BCF8FE8 + _id_DAB81EAD77442A10;
    _id_A6717FAE5964E4C6 = calcscriptablepayloadgravityarc(_id_E5D77BF46A926594 + (0, 0, 12), _id_E5D77BF46A926594);
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_E5D77BF46A926594, _id_C36E41058FF56216, _id_A6717FAE5964E4C6);
    _id_0E14905A4CDF3B12 = _id_66122A002AFF5D57::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_CFCB8FC02F9DB4DC, 1, weaponobj, 0, _id_9E57DC7AFE8604C8, _id_A69B5A02FFAE97FF);

    if(isDefined(weaponobj))
      level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(_id_0E14905A4CDF3B12, self, weaponobj);

    _id_CB3339ECE72DBDEB = scriptablename;

    if(isplunder(scriptablename))
      _id_CB3339ECE72DBDEB = _id_66122A002AFF5D57::getplundernamebyamount(_id_CFCB8FC02F9DB4DC);

    quickdropplaySound(itemtype, _id_E5D77BF46A926594, _id_CB3339ECE72DBDEB, _id_0E14905A4CDF3B12);
    self.quickdropcache[scriptablename].ent = _id_0E14905A4CDF3B12;
    thread quickdropcleanupcache();
    _id_66122A002AFF5D57::deregisterscriptableinstance(_id_B3CE3FBCFC181AEF);

    if(isent(_id_B3CE3FBCFC181AEF))
      _id_B3CE3FBCFC181AEF delete();
    else
      _id_B3CE3FBCFC181AEF freescriptable();

    return 1;
  }

  return 0;
}

_id_4F4D537C794B2BF5() {
  if(!isDefined(level._id_2DC1D82DA1DBFEAB))
    level._id_2DC1D82DA1DBFEAB = [0, 13, 1, 12, 2, 14, 27, 15, 26, 28, 41, 29, 40];

  if(!isDefined(self._id_1AC656BA9C98B8DB))
    self._id_1AC656BA9C98B8DB = 0;
  else
    self._id_1AC656BA9C98B8DB++;

  return level._id_2DC1D82DA1DBFEAB[self._id_1AC656BA9C98B8DB % level._id_2DC1D82DA1DBFEAB.size];
}

_id_1E450ADBA8DDC914() {
  if(isDefined(self._id_1AC656BA9C98B8DB) && self._id_1AC656BA9C98B8DB == 0) {
    startorigin = self.origin;
    startangles = self.angles;

    while(distancesquared(startorigin, self.origin) < 100 && anglesdelta(startangles, self.angles) < 10)
      wait 1;

    self._id_1AC656BA9C98B8DB = undefined;
    self notify("reset_slots");
  }
}

quickdropaddtocache(scriptablename, slot, ent, droporigin, dropangles) {
  if(!isDefined(self.quickdropcache))
    self.quickdropcache = [];

  _id_01315B36154A5E3E = spawnStruct();
  _id_01315B36154A5E3E.scriptablename = scriptablename;
  _id_01315B36154A5E3E.slot = slot;
  _id_01315B36154A5E3E.ent = ent;
  _id_01315B36154A5E3E.droporigin = droporigin;
  _id_01315B36154A5E3E.dropangles = dropangles;
  _id_01315B36154A5E3E.playerorigin = self.origin;
  _id_01315B36154A5E3E.playeryaw = self.angles[1];
  self.quickdropcache[scriptablename] = _id_01315B36154A5E3E;
  thread quickdropcleanupcache();
}

quickdropplaySound(itemtype, droporigin, scriptablename, _id_0E14905A4CDF3B12, weaponobj) {
  aliasname = undefined;

  switch (itemtype) {
    case 5:
      aliasname = "br_inventory_drop_ammo";
      break;
    case 0:
      if(scriptablename == "brloot_plunder_cash_uncommon_1")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_uncommon_2")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_uncommon_3")
        aliasname = "br_inventory_drop_plunder_sm";
      else if(scriptablename == "brloot_plunder_cash_rare_1")
        aliasname = "br_inventory_drop_plunder_med";
      else if(scriptablename == "brloot_plunder_cash_rare_2")
        aliasname = "br_inventory_drop_plunder_med";
      else if(scriptablename == "brloot_plunder_cash_epic_1")
        aliasname = "br_inventory_drop_plunder_lrg";
      else if(scriptablename == "brloot_plunder_cash_epic_2")
        aliasname = "br_inventory_drop_plunder_lrg";
      else if(scriptablename == "brloot_plunder_cash_legendary_1")
        aliasname = "br_inventory_drop_plunder_extra_lrg";
      else
        aliasname = "br_inventory_drop_plunder_med";

      break;
    case 1:
      if(isDefined(weaponobj)) {
        thread _id_AED7983CF10CA9E2(_id_0E14905A4CDF3B12, weaponobj);
        return;
      } else
        aliasname = "br_inventory_drop_weap";

      break;
    case 10:
    case 4:
    case 3:
    case 2:
      aliasname = _id_1CE1A3739DB60BFB(scriptablename);
      break;
    default:
  }

  if(isDefined(aliasname)) {
    if(isDefined(_id_0E14905A4CDF3B12) && isvector(_id_0E14905A4CDF3B12.origin))
      playsoundatpos(_id_0E14905A4CDF3B12.origin, aliasname);
    else
      self playSound(aliasname);
  }
}

_id_AED7983CF10CA9E2(_id_0E14905A4CDF3B12, weaponobj) {
  origin = self.origin;
  basename = scripts\engine\utility::_id_53C4C53197386572(weaponobj.basename, "");
  material = scripts\engine\utility::_id_53C4C53197386572(weaponobj.material, "");

  if(isDefined(_id_0E14905A4CDF3B12) && isvector(_id_0E14905A4CDF3B12.origin))
    origin = _id_0E14905A4CDF3B12.origin;
  else {
    _id_FBB5190911C15C1B = self getvieworigin();
    origin = _id_FBB5190911C15C1B + anglesToForward(self getplayerangles()) * 100.0;
    origin = (origin[0], origin[1], _id_FBB5190911C15C1B[2]);
  }

  self playSound("br_inventory_drop_weap_toss_only");
  wait 0.5;
  _id_F39A1ABBE4EC2B6F = origin + (0, 0, -120);
  trace = scripts\engine\trace::ray_trace(origin, _id_F39A1ABBE4EC2B6F, self, undefined, 1);
  surfacetype = trace["surfacetype"];
  waittillframeend;
  scripts\cp\cp_weapons::_id_E7DBBE9220D5E27B(surfacetype, basename, material);
}

_id_1CE1A3739DB60BFB(scriptablename) {
  if(isplunder(scriptablename))
    return "br_inventory_drop_plunder";
  else if(isammo(scriptablename))
    return "br_inventory_drop_ammo";
  else if(scriptablename == "brloot_offhand_throwingknife")
    return "iw9_br_inventory_drop_knife";
  else if(scriptablename == "brloot_gascan")
    return "iw9_br_inventory_gas_can";
  else if(_id_7EF95BBA57DC4B82::isequipmentlethal(scriptablename))
    return "iw9_br_inventory_drop_lethal";
  else if(_id_7EF95BBA57DC4B82::isequipmenttactical(scriptablename))
    return "iw9_br_inventory_drop_tactical";
  else if(isarmorplate(scriptablename))
    return "br_inventory_drop_armor";
  else
    return "br_inventory_drop_weap";
}

quickdropcleanupcache() {
  _id_1CA69EE8605FC45D = 120;
  self notify("quickDropCleanupCache");
  self endon("quickDropCleanupCache");
  wait(_id_1CA69EE8605FC45D);
  self.quickdropcache = undefined;
}

ispickupstackable(scriptablename) {
  return istrue(level.br_pickups.stackable[scriptablename]);
}

quickdropfinditemincache(scriptablename) {
  if(!isDefined(self.quickdropcache)) {
    return;
  }
  if(!isDefined(self.quickdropcache[scriptablename])) {
    return;
  }
  if(!isDefined(self.quickdropcache[scriptablename].ent))
    self.quickdropcache[scriptablename] = undefined;
  else if(distancesquared(self.quickdropcache[scriptablename].droporigin, self.origin) > 12000)
    return;
}

getquickdropweapon(_id_3793828403C6873E) {
  _id_0CB8FEA2B4525691 = _id_13ECF3644442A3E7(self, _id_3793828403C6873E);
  weaponname = getcompleteweaponname(_id_0CB8FEA2B4525691);
  return weaponname;
}

_id_52DF07E94B3CE0DF(player, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  ammotype = _id_5A80DBA504420037(_id_3793828403C6873E);
  ammocount = _id_1352197E2482F1CF(player, ammotype);

  if(!isDefined(ammocount) || ammocount == 0)
    return 0;

  if(!_id_53AAAE2C915F815B)
    ammocount = int(min(ammocount, _id_2BF8EAF550FBE399(ammotype)));

  br_ammo_take_type(player, ammotype, ammocount);

  if(!istrue(_id_180513E5B195F19A))
    quickdropnewitem(itemtype, ammotype, ammocount);

  return 1;
}

_id_5A80DBA504420037(index) {
  if(!isDefined(level.br_ammo_types)) {
    return;
  }
  if(isDefined(level.br_ammo_types[index]))
    return level.br_ammo_types[index];
  else {}
}

_id_1352197E2482F1CF(player, ammotype) {
  if(!isDefined(player) || !isDefined(player.br_ammo)) {
    return;
  }
  if(isDefined(player.br_ammo[ammotype]))
    return player.br_ammo[ammotype];
  else {}
}

br_ammo_take_type(player, ammotype, amount) {
  if(player.br_ammo[ammotype] <= 0)
    return 0;

  player.br_ammo[ammotype] = player.br_ammo[ammotype] - amount;

  if(player.br_ammo[ammotype] < 0)
    player.br_ammo[ammotype] = 0;

  player _id_66122A002AFF5D57::br_ammo_player_hud_update_ammotype(ammotype);
  _id_66122A002AFF5D57::br_ammo_update_weapons(player);
  return 1;
}

_id_2BF8EAF550FBE399(ammotype) {
  if(!isDefined(level.br_ammo_clipsize)) {
    return;
  }
  if(isDefined(level.br_ammo_clipsize[ammotype]))
    return level.br_ammo_clipsize[ammotype];
  else {}
}

_id_8F803EA058A13CBD(player, _id_180513E5B195F19A) {
  if(!istrue(_id_180513E5B195F19A)) {
    dropstruct = _id_7B9F3966A7A42003();
    player dropbrselfrevivetoken(dropstruct);

    if(scripts\common\utility::iscp())
      self.pers["dropped_initial_revive_token"] = 1;
  }

  return 1;
}

dropbrselfrevivetoken(dropstruct) {
  if(_id_0AFB7E332AEE4BF2::hasselfrevivetoken()) {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(dropstruct._id_DFBA5A2C3C6F0A07, self.origin, self.angles, self);
    item = _id_66122A002AFF5D57::spawnpickup("brloot_self_revive", _id_CB4FAD49263E20C4, 1, 1);
    _id_66122A002AFF5D57::_id_2F4E0022C686DBE6(item);
    _id_66122A002AFF5D57::removeselfrevivetoken();
  }
}

_id_750E9A7F11BECD51(player, _id_180513E5B195F19A) {
  if(!istrue(_id_180513E5B195F19A)) {
    dropstruct = _id_7B9F3966A7A42003();
    player dropbrgasmask(dropstruct);
  }

  return 1;
}

dropbrgasmask(dropstruct) {
  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    if(!isDefined(self.gasmasktype))
      self.gasmasktype = "brloot_equip_gasmask_durable";

    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, self.origin, self.angles, self);
    _id_1AD2DB70C8D01F51 = isalive(self) || getdvarint("dvar_4508C701F27F5496", 0);
    gasmask = _id_66122A002AFF5D57::spawnpickup(self.gasmasktype, _id_CB4FAD49263E20C4, int(self.gasmaskhealth), 1, undefined, _id_1AD2DB70C8D01F51);

    if(isDefined(gasmask))
      gasmask.gasmaskmaxhealth = self.gasmaskmaxhealth;

    _id_75520EA44545C906();

    if(isDefined(gasmask))
      _id_66122A002AFF5D57::_id_2F4E0022C686DBE6(gasmask);

    _id_777C89585478357B(self);
  }
}

_id_75520EA44545C906() {
  if(istrue(self.gasmaskequipped)) {
    self detach("hat_child_hadir_gas_mask_wm_br", "j_head");
    self.gasmaskequipped = 0;
  }

  self.gasmaskswapinprogress = 0;
  _id_04D16B9C52EFA3B8();
}

_id_04D16B9C52EFA3B8() {
  self.gasmaskmaxhealth = undefined;
  self.gasmaskhealth = undefined;
  self._id_FE63300B318B76B0 = undefined;
  self setclientomnvar("ui_gas_mask", 0);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

_id_777C89585478357B(player, _id_61F04DF489841F73) {
  if(!_id_E0FC1230452CF4E7()) {
    return;
  }
  _id_DC67872CC4CFAE72(player, 1, 10, _id_61F04DF489841F73);
}

_id_E0FC1230452CF4E7() {
  if(!isDefined(level._id_8F125BA0DC7C4B33))
    level._id_8F125BA0DC7C4B33 = getdvarint("dvar_0A31E837C3D3A9C9", 0);

  return level._id_8F125BA0DC7C4B33;
}

_id_DC67872CC4CFAE72(player, location, _id_FB6BAFB61D5C3D4A, _id_61F04DF489841F73) {
  instance = player _meth_644ED519CAC9722B(location, _id_FB6BAFB61D5C3D4A);

  if(instance._id_FB5FDFAFC29F4513 != "0")
    player _meth_DD5661EBE3C9A5A2(instance._id_FB5FDFAFC29F4513);
}

_id_7B9F3966A7A42003() {
  dropstruct = spawnStruct();
  dropstruct.dropcount = 0;
  dropstruct._id_DFBA5A2C3C6F0A07 = 0;
  return dropstruct;
}

_id_B15E36B7BC247DDB(player, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {}

_id_1503D0B5B4C9D010(player, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {}

_id_B130392812B25580(player, _id_3793828403C6873E, itemtype, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  _id_9BE70D6D4FF253A1 = player _id_7EF95BBA57DC4B82::getequipmentslotammo(_id_4967838290CB31B9(_id_3793828403C6873E));

  if(!isDefined(_id_9BE70D6D4FF253A1) || _id_9BE70D6D4FF253A1 == 0)
    return 0;

  if(!_id_53AAAE2C915F815B)
    _id_9BE70D6D4FF253A1 = 1;

  slot = _id_4967838290CB31B9(_id_3793828403C6873E);
  _id_7EF95BBA57DC4B82::decrementequipmentslotammo(slot, _id_9BE70D6D4FF253A1);

  if(!istrue(_id_180513E5B195F19A))
    player _id_66122A002AFF5D57::dropequipmentinslot(slot, 0, undefined, _id_9BE70D6D4FF253A1, undefined, 0, itemtype, 1);

  return 1;
}

_id_91C1BE871300A518(lootid) {
  _id_2713F4A3502D1624 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_2713F4A3502D1624))
    _id_2713F4A3502D1624 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  return _id_2713F4A3502D1624;
}

_id_15308562FDA076AA(lootid, pickup) {
  quantity = pickup.count;
  maxcount = level.br_pickups._id_04138F9DDC1CD22D[pickup.scriptablename];

  if(!isDefined(maxcount) || maxcount == 0)
    maxcount = level.br_pickups.maxcounts[pickup.scriptablename];

  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      _id_E30B916ADC1E2DC8 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "quantity");

      if(_id_E30B916ADC1E2DC8 + quantity <= maxcount) {
        _id_66122A002AFF5D57::_id_9F3A7767F1C1BD9E(lootid, _id_AC0E594AC96AA3A8, quantity);
        return 0;
      } else
        quantity = _id_66122A002AFF5D57::_id_91A0BAB850D7DB10(_id_AC0E594AC96AA3A8, lootid, maxcount, quantity, _id_E30B916ADC1E2DC8);
    }

    if(quantity <= 0)
      return 0;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == 0 && _id_EEEAE9DEFA0C1E95 != lootid) {
      if(quantity <= maxcount) {
        _id_66122A002AFF5D57::_id_9F3A7767F1C1BD9E(lootid, _id_AC0E594AC96AA3A8, quantity);
        return 0;
      } else
        quantity = _id_66122A002AFF5D57::_id_91A0BAB850D7DB10(_id_AC0E594AC96AA3A8, lootid, maxcount, quantity, 0);
    }

    if(quantity <= 0)
      return 0;
  }

  return quantity;
}

_id_6F62CB4FC113349C(player, itemtype, _id_3793828403C6873E, _id_53AAAE2C915F815B, _id_180513E5B195F19A) {
  [lootid, quantity] = _id_6738846DA50730F1(_id_3793828403C6873E);

  if(lootid == 0) {
    return;
  }
  _id_9BE70D6D4FF253A1 = undefined;
  _id_59BD51AFC73DF2CD = undefined;
  _id_DAB81EAD77442A10 = undefined;
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  _id_9E3428357E5DF2E3 = _id_66122A002AFF5D57::_id_03C17A26CE6A4668(lootid);

  if(_id_9E3428357E5DF2E3)
    [_id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10] = _id_379463A84ADB07B4(quantity);
  else if(_id_53AAAE2C915F815B || isammo(ref))
    _id_9BE70D6D4FF253A1 = quantity;
  else
    _id_9BE70D6D4FF253A1 = 1;

  player _id_DB1DD76061352E5B(_id_3793828403C6873E, scripts\engine\utility::ter_op(_id_9E3428357E5DF2E3, quantity, _id_9BE70D6D4FF253A1));

  if(istrue(_id_180513E5B195F19A))
    return 1;

  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  scriptable = undefined;

  if(isammo(ref))
    scriptable = ref;
  else
    scriptable = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  _id_76F4143215683892 = quickdropnewitem(itemtype, scriptable, _id_9BE70D6D4FF253A1, _id_59BD51AFC73DF2CD, _id_DAB81EAD77442A10);
  player notify("dropped_backpack_item", _id_76F4143215683892);
  return 1;
}

_id_379463A84ADB07B4(count) {
  if(!isDefined(count))
    return [61, 61, 0];

  return [count & 63, count >> 6, 0];
}

_id_DB1DD76061352E5B(index, _id_74806F0C4CAA7E55) {
  [lootid, _] = _id_6738846DA50730F1(index);
  _id_FF239359935AA777 = _id_897B29ADB37F06A7(index);
  thread _id_66122A002AFF5D57::_id_A0CCC23064473A05(index, lootid, int(max(0, _id_FF239359935AA777 - _id_74806F0C4CAA7E55)));
  _id_2713F4A3502D1624 = _id_91C1BE871300A518(lootid);

  if(isammo(_id_2713F4A3502D1624))
    _id_5143C54FB8C3C4FD(self, _id_2713F4A3502D1624);

  _id_6355A9DB4EA7AB55(lootid);
  return lootid;
}

_id_5143C54FB8C3C4FD(player, ammotype) {
  if(!isDefined(player) || !isDefined(ammotype)) {
    return;
  }
  _id_509D86412C9D7426 = self getweaponslistprimaries();
  _id_A9BC5314D494806D = 0;

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    _id_7CAC4FF8E11F1BCA = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(_id_7CAC4FF8E11F1BCA) && ammotype == _id_7CAC4FF8E11F1BCA) {
      _id_5B3F7D686C59AB97 = self.br_ammo[ammotype];

      if(_id_6B531C76815D77F3(ammotype)) {
        lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
        _id_5B3F7D686C59AB97 = _id_5B3F7D686C59AB97 + _id_B4BD198A25085E3E(lootid);
      }

      _id_5B3F7D686C59AB97 = _id_66122A002AFF5D57::get_int_or_0(_id_5B3F7D686C59AB97);
      player _id_66122A002AFF5D57::_id_4906C10C3FFDD4CA(_id_DE88CD14114C1E24, _id_5B3F7D686C59AB97);
    }
  }

  player notify("ammo_update");
}

_id_6B531C76815D77F3(scriptablename) {
  if(isammo(scriptablename))
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(scriptablename);
  else
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(scriptablename);

  if(isDefined(lootid))
    return _id_36B1968BFE78916B(lootid);

  return 0;
}

_id_36B1968BFE78916B(lootid) {
  return isDefined(_id_821BFBA97B1251AC(lootid));
}

_id_821BFBA97B1251AC(lootid) {
  if(lootid == 0)
    return undefined;

  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(lootid == _id_EEEAE9DEFA0C1E95)
      return _id_AC0E594AC96AA3A8;
  }

  return undefined;
}

_id_B4BD198A25085E3E(lootid) {
  total = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B13E35608B336D65(self); _id_AC0E594AC96AA3A8++) {
    _id_F1CBC68C79EBF1EA = _id_6196D9EA9A30E609(_id_AC0E594AC96AA3A8);

    if(_id_F1CBC68C79EBF1EA == lootid)
      total = total + _id_897B29ADB37F06A7(_id_AC0E594AC96AA3A8);
  }

  return total;
}

_id_6196D9EA9A30E609(index) {
  return self getplayerdata("cp", "dmzBackpack", index, "lootID");
}

_id_897B29ADB37F06A7(index) {
  return self getplayerdata("cp", "dmzBackpack", index, "quantity");
}

_id_6355A9DB4EA7AB55(lootid) {
  if(!isDefined(lootid)) {
    return;
  }
  type = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  switch (type) {
    case "tactical":
    case "lethal":
    case "killstreak":
    case "equipment":
    case "field_upgrade":
    case "perk":
    case "super":
    case "secondary":
    case "primary":
    case "weapon":
      return;
    case "consumable":
      if(isDefined(level._id_B33C035C483C2893) && isDefined(level._id_B33C035C483C2893["onDrop"]) && isDefined(level._id_B33C035C483C2893["onDrop"][ref]))
        [[level._id_B33C035C483C2893["onDrop"][ref]]](self);

      return;
  }

  return;
}

_id_3AB0A87EEAA203BF() {
  if(!istrue(level._id_2C93542553C664F5))
    return 0;

  foreach(weaponobj in self.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp")
      return 0;
  }

  return 1;
}

_id_8E7E1DA48D7746E5(player, _id_0CC708B3BF7C11ED) {
  _id_66122A002AFF5D57::_id_B9DA718E50063452();
  _id_712A14F78C75A0C2 = level.br_pickups._id_C9015F26F73062A0[player.guid];

  if(!isDefined(_id_712A14F78C75A0C2)) {
    _id_712A14F78C75A0C2 = spawnStruct();
    _id_712A14F78C75A0C2.array = [];
    _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 = 0;
    _id_712A14F78C75A0C2._id_52FCFE909C72DB5B = 0;
    level.br_pickups._id_C9015F26F73062A0[player.guid] = _id_712A14F78C75A0C2;
  }

  _id_712A14F78C75A0C2.array[_id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7] = _id_0CC708B3BF7C11ED.index;
  _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 = scripts\engine\math::wrap(0, 4, _id_712A14F78C75A0C2._id_9A6BA9F5A0E705C7 + 1);
  _id_712A14F78C75A0C2._id_52FCFE909C72DB5B = gettime();
}

_id_823964AA15B30575() {
  _id_6FB2D8460BBFEABE = undefined;

  if(self _meth_0617199566A43446()) {
    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(_id_74502A9E0EF1F19C::iscacsecondaryweapon(_id_DE88CD14114C1E24)) {
        if(!isDefined(_id_6FB2D8460BBFEABE)) {
          _id_6FB2D8460BBFEABE = _id_DE88CD14114C1E24;
          continue;
        }

        _id_6FB2D8460BBFEABE = undefined;
        break;
      }
    }
  }

  if(!isDefined(_id_6FB2D8460BBFEABE) && self _meth_27BB46EAF2ECD374()) {
    currentweapon = self getcurrentweapon();

    foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
      if(!issameweapon(currentweapon, _id_DE88CD14114C1E24)) {
        _id_6FB2D8460BBFEABE = _id_DE88CD14114C1E24;
        break;
      }
    }
  }

  return _id_6FB2D8460BBFEABE;
}

_id_55C5D35C8C76A95B(pickupent) {
  if(!isDefined(pickupent.weapon)) {
    attachments = [];
    _id_DD515FCF025B2E79 = undefined;

    if(isDefined(pickupent.customweaponname)) {
      _id_A0CB84D50AFAAB7D = pickupent.customweaponname;
      _id_DD515FCF025B2E79 = makeweaponfromstring(_id_A0CB84D50AFAAB7D);
    } else if(!isDefined(pickupent.completeweapon)) {
      _id_DD515FCF025B2E79 = _id_66122A002AFF5D57::getfullweaponobjforpickup(pickupent);
      _id_A0CB84D50AFAAB7D = getcompleteweaponname(_id_DD515FCF025B2E79);
    } else {
      _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(pickupent.loadoutprimaryfullname, attachments, "none", "none", -1);
      _id_A0CB84D50AFAAB7D = pickupent.loadoutprimaryfullname;
    }

    _id_1C454AEE1C2A55DF = _id_2669878CF5A1B6BC::getweaponrootname(_id_A0CB84D50AFAAB7D);
    weaponname = _id_A0CB84D50AFAAB7D;
  } else {
    _id_DD515FCF025B2E79 = pickupent.weapon;

    if(isDefined(pickupent.loadoutprimaryfullname))
      weaponname = pickupent.loadoutprimaryfullname;
    else if(isDefined(pickupent.weapon.basename))
      weaponname = pickupent.weapon.basename;
    else
      weaponname = getsubstr(_id_DD515FCF025B2E79.classname, 7, _id_DD515FCF025B2E79.classname.size);

    _id_1C454AEE1C2A55DF = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  }

  return [_id_DD515FCF025B2E79, _id_1C454AEE1C2A55DF, weaponname];
}

_id_6F39F9916649AC48(lootid, quantity) {
  itemtype = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);

  if(itemtype == "weapon")
    _id_590202DAF6A1D4D7(self);
  else {
    index = _id_E05897F5D860188E(lootid, undefined, 1);

    if(!isDefined(index))
      return 0;

    _id_DB1DD76061352E5B(index, quantity);
  }
}

_id_E05897F5D860188E(lootid, quantity, _id_920F4173513EB6B8) {
  if(!isDefined(lootid))
    return undefined;

  _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

  if(!isDefined(_id_A1093166DE09E6B8))
    _id_A1093166DE09E6B8 = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  maxcount = level.br_pickups._id_04138F9DDC1CD22D[_id_A1093166DE09E6B8];

  if(!isDefined(maxcount))
    maxcount = level.br_pickups.maxcounts[_id_A1093166DE09E6B8];

  _id_342175A1B9F9067E = _id_B13E35608B336D65(self);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_342175A1B9F9067E; _id_AC0E594AC96AA3A8++) {
    _id_EEEAE9DEFA0C1E95 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "lootID");

    if(_id_EEEAE9DEFA0C1E95 == lootid) {
      if(istrue(_id_920F4173513EB6B8))
        return _id_AC0E594AC96AA3A8;

      _id_FF239359935AA777 = self getplayerdata("cp", "dmzBackpack", _id_AC0E594AC96AA3A8, "quantity");

      if(_id_FF239359935AA777 < maxcount)
        return _id_AC0E594AC96AA3A8;
    }
  }

  return undefined;
}

_id_F77406A45E988898(equipname) {
  if(!isDefined(equipname))
    return "br_ammo";

  switch (equipname) {
    case "equip_c4":
      return "c4";
    case "equip_claymore":
      return "claymore";
    case "equip_decoy":
      return "decoy";
    case "equip_flash":
      return "flash";
    case "equip_frag":
      return "frag";
    case "equip_geigercounter":
      return "geiger";
    case "equip_hb_sensor":
      return "hb_sensor";
    case "equip_iodine_pills":
      return "iodine_pills";
    case "equip_molotov":
      return "molotov";
    case "equip_shockstick":
      return "shockstick";
    case "equip_smoke":
      return "smoke";
    case "equip_adrenaline":
      return "stim";
    case "equip_concussion":
      return "stun";
    case "equip_thermite":
      return "thermite";
    case "equip_bunkerbuster":
      return "bunker_buster";
    case "equip_snapshot_grenade":
      return "snapshot";
    case "equip_at_mine":
      return "at_mine";
    case "equip_semtex":
      return "semtex";
    case "equip_binoculars":
      return "binoculars";
    default:
      return "br_ammo";
  }
}

_id_84772EBF836AF5DB(index, amount) {
  _id_E8DB6AFBF2180F7E = self getplayerdata("cp", "dmzBackpack", index, "quantity");
  _id_3FA041E4F059BC71 = int(max(0, _id_E8DB6AFBF2180F7E + amount));
  lootid = self getplayerdata("cp", "dmzBackpack", index, "lootID");
  _id_66122A002AFF5D57::_id_A0CCC23064473A05(index, lootid, _id_3FA041E4F059BC71);
}

pickupissameasequipmentslot(equipname, _id_CBB2B3D05E48BD27) {
  if(isDefined(self.equipment[_id_CBB2B3D05E48BD27]) && self.equipment[_id_CBB2B3D05E48BD27] == equipname)
    return 1;

  return 0;
}

equipmentslothasroom(scriptablename, _id_CBB2B3D05E48BD27) {
  _id_1C437E4320E43045 = level.br_pickups.br_equipname[scriptablename];

  if(isDefined(_id_1C437E4320E43045) && _id_7EF95BBA57DC4B82::getequipmentslotammo(_id_CBB2B3D05E48BD27) < _id_7EF95BBA57DC4B82::getequipmentmaxammo(_id_1C437E4320E43045))
    return 1;

  return 0;
}

getquickdropplundercount(_id_53AAAE2C915F815B) {
  _id_A77325CF77E1A9CC = 500;

  if(istrue(_id_53AAAE2C915F815B))
    return int(self.plundercount);

  return int(min(self.plundercount, _id_A77325CF77E1A9CC));
}

playerplunderdrop(amount, data) {
  return _id_66122A002AFF5D57::playerplunderevent(amount, 4, undefined, data);
}

modify_plunder_itemsinworld(itemname, _id_BC23CE7464AA4861) {
  if(level.br_plunder_enabled)
    level.br_plunder.itemsinworld[itemname] = level.br_plunder.itemsinworld[itemname] + _id_BC23CE7464AA4861;
}

_id_C8A5593CBB13F17C(pickup, weaponobj) {
  _id_FE4CD9DC9393409D = getdvarint("dvar_EF63562E5F3B14D0", 5000);
  currenttime = gettime();
  _id_C8A5593CBB13F17C = !isDefined(self._id_E7F6950DDC75EF66) || currenttime - self._id_E7F6950DDC75EF66 > _id_FE4CD9DC9393409D;

  if(_id_C8A5593CBB13F17C && self _meth_C3A5505BC8F25A14()) {
    _id_D05470192F5F4895 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; !_id_D05470192F5F4895 && _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++)
      _id_D05470192F5F4895 = isnullweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]) || _id_74502A9E0EF1F19C::isfistweapon(self.primaryweapons[_id_AC0E594AC96AA3A8]);

    _id_C8A5593CBB13F17C = _id_D05470192F5F4895;
  }

  if(_id_C8A5593CBB13F17C && self _meth_2EBB84EC61FCFAAF()) {}

  if(_id_C8A5593CBB13F17C && self _meth_113C9C35CAF6F029())
    _id_C8A5593CBB13F17C = _id_2B4B373533156A88(pickup, weaponobj);

  if(_id_C8A5593CBB13F17C) {
    if(self _meth_5329138A845B7AA6()) {
      _id_92FCE7B1696254E3 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
      _id_862E2D88178BC2C8 = 0;

      for(_id_AC0E594AC96AA3A8 = 0; !_id_862E2D88178BC2C8 && _id_AC0E594AC96AA3A8 < self.primaryweapons.size; _id_AC0E594AC96AA3A8++) {
        _id_E9094C47C8DBE268 = _id_2669878CF5A1B6BC::getweaponrootname(self.primaryweapons[_id_AC0E594AC96AA3A8]);

        if(_id_E9094C47C8DBE268 == _id_92FCE7B1696254E3) {
          _id_B68C8DFAC38718AB = _id_96B5A34CD1572D60(self.primaryweapons[_id_AC0E594AC96AA3A8]);
          _id_167E430A395B12BA = level.br_pickups.br_itemrarity[pickup.scriptablename];
          _id_862E2D88178BC2C8 = _id_B68C8DFAC38718AB < _id_167E430A395B12BA;
        }
      }

      _id_C8A5593CBB13F17C = _id_862E2D88178BC2C8;
    } else if(self _meth_362521BCB3A1BA25()) {
      if(!isDefined(level._id_81369E82645391F0))
        _id_66122A002AFF5D57::_id_F8B204E807CC62ED();

      currentweapon = self getcurrentweapon();
      _id_185D0D5E6E0BE607 = level._id_81369E82645391F0[weaponclass(currentweapon.basename)];
      _id_A6FB744F02D4FFB8 = level._id_81369E82645391F0[weaponclass(weaponobj.basename)];

      if(_id_185D0D5E6E0BE607 != _id_A6FB744F02D4FFB8) {
        _id_008FADDF4BE83922 = self _meth_337E400EAD27B7BD(_id_185D0D5E6E0BE607);
        _id_439466F5277EF2D9 = self _meth_337E400EAD27B7BD(_id_A6FB744F02D4FFB8);
        _id_C8A5593CBB13F17C = _id_439466F5277EF2D9 > _id_008FADDF4BE83922;
      } else
        _id_C8A5593CBB13F17C = 0;
    }
  }

  return _id_C8A5593CBB13F17C;
}

_id_2B4B373533156A88(pickup, weapon) {
  ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(weapon);
  _id_0F68FC94BC895254 = _id_088D62A65FF69EAC(self, ammotype);
  return _id_0F68FC94BC895254 > 0 || pickup.count > 0 || pickup.countlefthand > 0;
}

_id_088D62A65FF69EAC(player, ammotype) {
  _id_23C054F415636C51 = player.br_ammo[ammotype];

  if(_id_6B531C76815D77F3(ammotype)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
    _id_23C054F415636C51 = _id_23C054F415636C51 + _id_B4BD198A25085E3E(lootid);
  }

  return _id_23C054F415636C51;
}

_id_CBBF9BF3544DC456(pickup, isautouse) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
  result = _id_66122A002AFF5D57::_id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result))
    return 20;
  else if(istrue(isautouse))
    return 12;
  else
    return 4;
}

_id_96B5A34CD1572D60(weaponobj) {
  _id_1306AD638CEDC772 = 0;
  _id_878AB837C6FE40DF = getcompleteweaponname(weaponobj);

  if(isDefined(level.br_pickups.br_weapontoscriptable[_id_878AB837C6FE40DF])) {
    _id_C9C301A888170672 = level.br_pickups.br_weapontoscriptable[_id_878AB837C6FE40DF];
    _id_1306AD638CEDC772 = level.br_pickups.br_itemrarity[_id_C9C301A888170672];
  } else if(_id_66122A002AFF5D57::isvalidcustomweapon(weaponobj))
    _id_1306AD638CEDC772 = 10;

  return _id_1306AD638CEDC772;
}

_id_99AB09BA7022D107(pickup, isautouse) {
  lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);
  result = _id_66122A002AFF5D57::_id_E01D9736B2D100AC(lootid, pickup.count);

  if(istrue(result))
    return 1;
  else if(istrue(isautouse))
    return 12;
  else
    return 4;
}

_id_5E7049647595AB97() {
  if(!level._id_1D814F83596D0A02)
    return 0;

  return isDefined(self.equipment["super"]) && _id_7EF95BBA57DC4B82::getequipmentslotammo("super") > 0;
}

_id_D674D32C2D3BA5ED(player) {
  if(!istrue(level._id_472D7A6D15E57940))
    return 0;

  return isDefined(player.streakdata) && isDefined(player.streakdata.streaks) && self.streakdata.streaks.size > 0;
}

_id_08F0BD51F5C6108B(pickup, player, _id_A5B2C541413AA895, instance) {
  lootid = undefined;
  player _id_66122A002AFF5D57::_id_EFDDDF60C5DB058C(pickup, _id_A5B2C541413AA895);

  if(isammo(pickup.scriptablename))
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(pickup.scriptablename);
  else
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(pickup.scriptablename);

  if(isDefined(lootid)) {
    if(_id_66122A002AFF5D57::isweaponpickupitem(pickup))
      pickup.count = 1;

    if(_id_4294E9B331377C31(pickup.scriptablename)) {
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
      pickup.count = 8;
    }

    if(issubstr(pickup.scriptablename, "brloot_ammo"))
      player _id_66122A002AFF5D57::_id_10F6E537F1B5763C(lootid, pickup, undefined, 1);
    else
      player _id_66122A002AFF5D57::_id_10F6E537F1B5763C(lootid, pickup);

    if(isDefined(instance))
      _id_66122A002AFF5D57::loothide(instance);

    return 1;
  }
}

_id_60234AA487445085(pickup, player, _id_A5B2C541413AA895, instance) {
  _id_483AD0CAB6E25673 = isDefined(pickup.scriptablename) && _id_F262C137ED78E6EB(pickup.scriptablename);
  _id_10BBEACB1429824E = player _id_66122A002AFF5D57::onusecompleted(pickup, _id_483AD0CAB6E25673, _id_A5B2C541413AA895, undefined, undefined, instance);

  if(isDefined(instance) && _id_10BBEACB1429824E)
    _id_66122A002AFF5D57::loot_setitemcount(instance, pickup.count, pickup.countlefthand, pickup._id_E97D731BEDD44C63);

  if(!isDefined(instance) || _id_10BBEACB1429824E)
    return 1;

  if(!_id_483AD0CAB6E25673)
    _id_66122A002AFF5D57::loothide(instance);

  player setclientomnvar("ui_notify_show_minimal_hud", gettime());
  return 1;
}

_id_7F04A682872040DB(player) {
  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 50; _id_3793828403C6873E++)
    player setplayerdata("mp", "dmzInventory", _id_3793828403C6873E, "lootedQuantity", 0);
}

_id_F1F10297297D06C8() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 50; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata("mp", "dmzInventory", _id_AC0E594AC96AA3A8, "lootID");
    quantity = self getplayerdata("mp", "dmzInventory", _id_AC0E594AC96AA3A8, "quantity");
    ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  }
}

_id_9CD290910C24D4D3() {
  items = [];
  _id_9FD35FFD09E2A230 = _id_57931A717F140EBE(self);

  foreach(weapon in _id_9FD35FFD09E2A230) {
    variantid = weapon.variantid;

    if(!isDefined(weapon.variantid))
      variantid = 0;

    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
    lootid = _id_2669878CF5A1B6BC::_id_79D6E6C22245687A(_id_AB501F397D3CD312, variantid);

    if(isDefined(lootid) && lootid > 0) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  ref = _id_7EF95BBA57DC4B82::getcurrentequipment("primary");
  _id_212E6B7D207A0089 = _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

  if(isDefined(lootid) && _id_212E6B7D207A0089 > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = _id_7EF95BBA57DC4B82::getcurrentequipment("secondary");
  _id_212E6B7D207A0089 = _id_7EF95BBA57DC4B82::getequipmentslotammo("secondary");
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

  if(isDefined(lootid) && _id_212E6B7D207A0089 > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = _id_7EF95BBA57DC4B82::getcurrentequipment("super");
  ref = _id_600B944A95C3A7BF::_id_151B82E1257F4CDE(ref);
  _id_212E6B7D207A0089 = getsuperweapondisabledammobr();
  lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref);

  if(isDefined(lootid) && _id_212E6B7D207A0089 > 0) {
    item = spawnStruct();
    item.lootid = lootid;
    item.quantity = 1;
    items[items.size] = item;
  }

  ref = undefined;

  if(isDefined(ref)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ref.streakname);

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(hasplatepouch()) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_satchel");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self)) {
    lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("gas_mask");

    if(isDefined(lootid)) {
      item = spawnStruct();
      item.lootid = lootid;
      item.quantity = 1;
      items[items.size] = item;
    }
  }

  itemname = self.equipment["health"];
  _id_9BE70D6D4FF253A1 = _id_7EF95BBA57DC4B82::getequipmentslotammo("health");

  if(isDefined(itemname) && isDefined(_id_9BE70D6D4FF253A1) && _id_9BE70D6D4FF253A1 > 0) {
    item = spawnStruct();
    item.lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("armor_plate");
    item.quantity = _id_9BE70D6D4FF253A1;
    items[items.size] = item;
  }

  return items;
}

_id_57931A717F140EBE(player) {
  weapons = [];

  foreach(weapon in player getweaponslistprimaries()) {
    if(_id_0D3C77884D93D850(weapon))
      continue;
    else if(weaponinventorytype(weapon) == "altmode")
      continue;
    else if(_id_74502A9E0EF1F19C::ismeleeoverrideweapon(weapon))
      continue;
    else
      weapons[weapons.size] = weapon;
  }

  return weapons;
}

getsuperweapondisabledammobr() {
  ammo = _id_7EF95BBA57DC4B82::getequipmentslotammo("super");

  if(!istrue(self.issuperdisabled))
    return ammo;

  if(istrue(self._id_1066FBD86C88A6DF))
    ammo = 1;

  return ammo;
}

playersetplundercount(plundercount, data) {
  if(!isDefined(self.plundercount))
    self.plundercount = 0;

  plunderdelta = plundercount - self.plundercount;

  if((!isDefined(data) || !istrue(data.setplunderifunchanged)) && plunderdelta == 0) {
    return;
  }
  self.plundercount = plundercount;

  if(self.plundercount > level.br_plunder.plunderlimit) {
    scripts\cp\cp_hud_message::showerrormessage("MP_BR_INGAME/PLUNDER_HELD_LIMIT_REACHED");
    self.plundercount = level.br_plunder.plunderlimit;
  }

  if(isDefined(self.petwatch))
    scripts\cp_mp\pet_watch::onplayergetsplunder();

  amount = self.plundercount;
  _id_3BCAA2CBAF54ABDD::set_player_currency(int(amount), 1);
  _id_66122A002AFF5D57::_id_46EE9182CF6872D5(amount);

  if(plundercount > 0) {
    return;
  }
  return;
}

_id_B13E35608B336D65(player) {
  if(istrue(level._id_A7F81DFDC88E53E6))
    return level._id_E247454AC2869696;

  return player getplayerdata("mp", level._id_342175A1B9F9067E);
}

br_forcegivecustompickupitem(player, scriptablename, _id_43FB3D97ABB79854, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585, _id_DB943473454F6EA6) {
  if(istrue(_id_1E736A37C3737585)) {
    player dropbrcustompickupitem(scriptablename, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585);
    return 1;
  }

  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = scriptablename;
  _id_60227BFF1E9478CC.origin = player.origin;
  _id_60227BFF1E9478CC.count = 0;
  _id_60227BFF1E9478CC.maxcount = level.br_pickups.maxcounts[_id_60227BFF1E9478CC.scriptablename];
  _id_60227BFF1E9478CC.stackable = level.br_pickups.stackable[_id_60227BFF1E9478CC.scriptablename];

  if(isDefined(_id_8E4538D786FB9418))
    _id_60227BFF1E9478CC.count = _id_8E4538D786FB9418;

  if(!_id_60227BFF1E9478CC.count && isDefined(level.br_pickups.counts[_id_60227BFF1E9478CC.scriptablename]))
    _id_60227BFF1E9478CC.count = level.br_pickups.counts[_id_60227BFF1E9478CC.scriptablename];

  results = player _id_66122A002AFF5D57::cantakepickup(_id_60227BFF1E9478CC);

  if(results == 1) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);
    player _id_66122A002AFF5D57::onusecompleted(_id_60227BFF1E9478CC, _id_43FB3D97ABB79854, undefined, _id_7F437A5779C8787C, _id_DB943473454F6EA6);
    return 1;
  } else if(results == 20) {
    lootid = undefined;

    if(isammo(_id_60227BFF1E9478CC.scriptablename))
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_60227BFF1E9478CC.scriptablename);
    else
      lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(_id_60227BFF1E9478CC.scriptablename);

    if(isDefined(lootid)) {
      if(_id_66122A002AFF5D57::isweaponpickupitem(_id_60227BFF1E9478CC))
        _id_60227BFF1E9478CC.count = 1;

      if(_id_4294E9B331377C31(_id_60227BFF1E9478CC.scriptablename)) {
        lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_armor_plate");
        _id_60227BFF1E9478CC.count = 8;
      }

      player _id_66122A002AFF5D57::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
      return 1;
    }
  }

  return 0;
}

dropbrcustompickupitem(scriptablename, _id_8E4538D786FB9418, _id_7F437A5779C8787C, _id_1E736A37C3737585) {
  _id_7FEBA4EC6C35D82D = istrue(_id_1E736A37C3737585) && isDefined(scriptablename);

  if(_id_7FEBA4EC6C35D82D) {
    _id_66122A002AFF5D57::_id_73FFC9BCD6D1E62D(_id_7F437A5779C8787C);
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, self.origin, self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
    item = _id_66122A002AFF5D57::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, _id_8E4538D786FB9418);
    _id_66122A002AFF5D57::_id_2F4E0022C686DBE6(item);
  }
}

br_ammo_player_is_maxed_out() {
  player = self;
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(ammotype)) {
      _id_E0116C5B8D303105 = player getweaponammoclip(_id_DE88CD14114C1E24, "right");
      _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);

      if(_id_E0116C5B8D303105 < _id_44C97DCE6932DE3C)
        return 0;

      if(_id_DE88CD14114C1E24._id_318338AA880DFAC6) {
        _id_734357A0B88E3A30 = player getweaponammoclip(_id_DE88CD14114C1E24, "left");

        if(_id_734357A0B88E3A30 < _id_44C97DCE6932DE3C)
          return 0;
      }

      if(!_id_66122A002AFF5D57::br_ammo_type_player_full(player, ammotype))
        return 0;
    }
  }

  return 1;
}

traceselectedmaplocation(location) {
  _id_5883D53023334465 = location + (0, 0, 10000);
  _id_3CB14AEA5687B8F6 = location - (0, 0, 10000);
  _id_F590BCBAFFB210C5 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
  _id_D4C559B594AD3DF9 = level.activekillstreaks;
  _id_B9D5783A4F34EFBC = scripts\engine\utility::array_combine(_id_F590BCBAFFB210C5, _id_D4C559B594AD3DF9);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0, 0, 0, 0);
  return scripts\engine\trace::ray_trace(_id_5883D53023334465, _id_3CB14AEA5687B8F6, _id_B9D5783A4F34EFBC, contentoverride, 0, 1);
}

br_ammo_player_max_out() {
  player = self;
  _id_F32522625B3C7CF9 = [];
  _id_509D86412C9D7426 = player getweaponslistprimaries();

  foreach(_id_DE88CD14114C1E24 in _id_509D86412C9D7426) {
    ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);

    if(isDefined(ammotype)) {
      _id_F32522625B3C7CF9[ammotype] = "dummy_value";
      _id_44C97DCE6932DE3C = weaponclipsize(_id_DE88CD14114C1E24);
      player setweaponammoclip(_id_DE88CD14114C1E24, _id_44C97DCE6932DE3C);
    }
  }

  foreach(ammotype, _id_97282C14346A7FCF in _id_F32522625B3C7CF9) {
    player.br_ammo[ammotype] = level._id_E6EA72FC5E3FCD00[ammotype];
    player _id_66122A002AFF5D57::br_ammo_player_hud_update_ammotype(ammotype);
  }

  _id_66122A002AFF5D57::br_ammo_update_weapons(player);
}

playerplunderkioskpurchase(amount, data) {
  return _id_66122A002AFF5D57::playerplunderevent(amount, 4, undefined, data);
}

br_give_weapon_clip(objweapon, _id_B153A3F2C4662B5E) {
  player = self;

  if(!isDefined(_id_B153A3F2C4662B5E))
    _id_B153A3F2C4662B5E = 1;

  ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(objweapon);

  if(isDefined(ammotype)) {
    _id_C1192C297BBF292F = int(level.br_ammo_clipsize[ammotype] * _id_B153A3F2C4662B5E);
    _id_237F7E1CA590E053 = level._id_E6EA72FC5E3FCD00[ammotype];

    if(_id_6B531C76815D77F3(ammotype)) {
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(ammotype);
      _id_237F7E1CA590E053 = _id_237F7E1CA590E053 + _id_B4BD198A25085E3E(lootid);
    }

    _id_7FF630BFBCA7B961 = int(clamp(player.br_ammo[ammotype] + _id_C1192C297BBF292F, 0, _id_237F7E1CA590E053));
    _id_66122A002AFF5D57::br_ammo_update_ammotype_weapons(player, ammotype, _id_7FF630BFBCA7B961);
  }
}