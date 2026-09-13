/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_loadout.gsc
***********************************************/

init() {
  level.available_player_characters = [];
  level.player_character_info = [];
  level.move_speed_scale = ::updatemovespeedscale;
  level.registerplayercharfunc = ::registerplayercharacter;
  init_core_mp_perks();

  if(!isDefined(level.loadoutsgroup))
    level.loadoutsgroup = scripts\cp\utility::getplayerdataloadoutgroup();

  _id_56EF8D52FE1B48A1::init_super();

  if(!isDefined(level.classmap))
    level.classmap = [];

  level.classmap["class0"] = 0;
  level.classmap["class1"] = 1;
  level.classmap["class2"] = 2;
  level.classmap["custom1"] = 0;
  level.classmap["custom2"] = 1;
  level.classmap["custom3"] = 2;
  level.classmap["custom4"] = 3;
  level.classmap["custom5"] = 4;
  level.classmap["custom6"] = 5;
  level.classmap["custom7"] = 6;
  level.classmap["custom8"] = 7;
  level.classmap["custom9"] = 8;
  level.classmap["custom10"] = 9;
  level.classmap["axis_recipe1"] = 0;
  level.classmap["axis_recipe2"] = 1;
  level.classmap["axis_recipe3"] = 2;
  level.classmap["axis_recipe4"] = 3;
  level.classmap["axis_recipe5"] = 4;
  level.classmap["axis_recipe6"] = 5;
  level.classmap["allies_recipe1"] = 0;
  level.classmap["allies_recipe2"] = 1;
  level.classmap["allies_recipe3"] = 2;
  level.classmap["allies_recipe4"] = 3;
  level.classmap["allies_recipe5"] = 4;
  level.classmap["allies_recipe6"] = 5;
  level.classmap["gamemode"] = 0;
  level.classmap["callback"] = 0;
  level.classmap["default1"] = 0;
  level.classmap["default2"] = 1;
  level.classmap["default3"] = 2;
  level.classmap["default4"] = 3;
  level.classmap["default5"] = 4;
  level.classmap["default6"] = 5;
  level.classmap["default7"] = 6;
  level.classmap["default8"] = 7;
  level.classmap["default9"] = 8;
  level.classmap["default10"] = 9;
  level.classmap["default11"] = 10;
  level.classmap["juggernaut"] = 0;
  level.defaultclass = "CLASS_ASSAULT";

  if(getdvarint("scr_test_loadouts", 0))
    level.classtablename = "classtable:classtable_test";
  else
    level.classtablename = "classtable:classtable";
}

getplayerbodymodel() {
  _id_56E7CF38A4910BA2 = scripts\cp\survival\survival_loadout::getoperatorcustomization();
  return _id_56E7CF38A4910BA2[0];
}

return_wbk_version_of_weapon(player, _id_EA6BEFBE838B7BE0, objweapon) {
  level endon("game_ended");
  player endon("disconnect");

  if(!istrue(player.weaponkitinitialized))
    player waittill("player_weapon_build_kit_initialized");

  if(isDefined(player.weapon_build_models[_id_EA6BEFBE838B7BE0]))
    return makeweaponfromstring(player.weapon_build_models[_id_EA6BEFBE838B7BE0]);
  else
    return objweapon;
}

delayreturningperks(player) {
  level endon("game_ended");
  player endon("disconnect");
  player waittill("spawned_player");
  wait 1;

  if(istrue(player.keep_perks)) {
    if(isDefined(player.zombies_perks)) {
      _id_37D6720284E968A1 = getarraykeys(player.zombies_perks);

      foreach(perk in _id_37D6720284E968A1) {
        if(isDefined(level.coop_perk_callbacks) && isDefined(level.coop_perk_callbacks[perk]) && isDefined(level.coop_perk_callbacks[perk].set))
          player[[level.coop_perk_callbacks[perk].set]]();
      }
    }

    player.keep_perks = undefined;
  }
}

release_character_number(player) {
  _id_74E9C58EF0ACED0C = player.player_character_num;

  if(!scripts\engine\utility::array_contains(level.available_player_characters, _id_74E9C58EF0ACED0C) && _id_74E9C58EF0ACED0C != 5)
    level.available_player_characters = scripts\engine\utility::array_add(level.available_player_characters, _id_74E9C58EF0ACED0C);
}

get_player_character_num() {
  if(isDefined(self.player_character_num))
    return self.player_character_num;

  _id_DC061F521C45D732 = scripts\engine\utility::random(level.available_player_characters);
  self.player_character_num = _id_DC061F521C45D732;
  return _id_DC061F521C45D732;
}

updatemovespeedscale() {
  _id_8F053B6F8634C100 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    _id_8F053B6F8634C100 = 1.0;
    _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.playerstreakspeedscale;
  } else {
    _id_8F053B6F8634C100 = getplayerspeedbyweapon(self);

    if(isDefined(self.chargemode_speedscale))
      _id_8F053B6F8634C100 = self.chargemode_speedscale;
    else if(isDefined(self.siege_speedscale))
      _id_8F053B6F8634C100 = self.siege_speedscale;

    _id_F30C40867C01E4F9 = self.chill_data;

    if(isDefined(_id_F30C40867C01E4F9) && isDefined(_id_F30C40867C01E4F9.speedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + _id_F30C40867C01E4F9.speedmod;

    if(isDefined(self.speedstripmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.speedstripmod;

    if(isDefined(self.phasespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.phasespeedmod;

    if(isDefined(self.weaponaffinityspeedboost))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponaffinityspeedboost;

    if(isDefined(self.weaponpassivespeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedmod;

    if(isDefined(self.weaponpassivespeedonkillmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.weaponpassivespeedonkillmod;

    _id_8F053B6F8634C100 = min(1.5, _id_8F053B6F8634C100);
  }

  self.weaponspeed = _id_8F053B6F8634C100;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  self setmovespeedscale(_id_8F053B6F8634C100 * self.movespeedscaler * self.combatspeedscalar);
}

getplayerspeedbyweapon(player) {
  weaponspeed = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(getDvar("normalize_movement_speed", "on") == "on")
    return 1.0;

  if(!self.weaponlist.size)
    weaponspeed = 0.9;
  else {
    weapon = self getcurrentweapon();

    if(scripts\cp\utility::issuperweapon(weapon))
      weaponspeed = level.superweapons[getcompleteweaponname(weapon)].movespeed;
    else {
      _id_A6852F8E66761E58 = weaponinventorytype(weapon);

      if(_id_A6852F8E66761E58 != "primary" && _id_A6852F8E66761E58 != "altmode") {
        if(isDefined(self.saved_lastweapon))
          weapon = self.saved_lastweapon;
        else
          weapon = undefined;
      }

      if(!isDefined(weapon) || !self hasweapon(weapon))
        weaponspeed = getweaponspeedslowest();
      else
        weaponspeed = getweaponspeed(weapon);
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

getweaponspeed(weapon) {
  rootweapon = scripts\cp\utility::getbaseweaponname(weapon);
  weaponspeed = level.weaponmapdata[rootweapon].speed;
  return weaponspeed;
}

getweaponspeedslowest() {
  _id_6155FF1652D3374F = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      weaponspeed = getweaponspeed(weapon);

      if(weaponspeed == 0) {
        continue;
      }
      if(weaponspeed < _id_6155FF1652D3374F)
        _id_6155FF1652D3374F = weaponspeed;
    }
  } else
    _id_6155FF1652D3374F = 0.9;

  _id_6155FF1652D3374F = clampweaponspeed(_id_6155FF1652D3374F);
  return _id_6155FF1652D3374F;
}

clampweaponspeed(value) {
  return clamp(value, 0.0, 1.0);
}

getweaponheaviestvalue() {
  _id_8A6F4E6A2246D381 = 1000;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      _id_40253EE32D687D41 = getweaponweight(weapon);

      if(_id_40253EE32D687D41 == 0) {
        continue;
      }
      if(_id_40253EE32D687D41 < _id_8A6F4E6A2246D381)
        _id_8A6F4E6A2246D381 = _id_40253EE32D687D41;
    }
  } else
    _id_8A6F4E6A2246D381 = 8;

  _id_8A6F4E6A2246D381 = clampweaponweightvalue(_id_8A6F4E6A2246D381);
  return _id_8A6F4E6A2246D381;
}

getweaponweight(weapon) {
  baseweapon = scripts\cp\utility::getbaseweaponname(weapon);
  weaponspeed = _id_2669878CF5A1B6BC::_id_B8811A0FC04E4B9D(baseweapon, "stat_BAA7982E38A124A2");

  if(!isDefined(weaponspeed) || weaponspeed < 1)
    weaponspeed = float(tablelookup(level.game_mode_statstable, 4, baseweapon, 8));

  if(!isDefined(weaponspeed) || weaponspeed < 1)
    weaponspeed = 10;

  return weaponspeed;
}

clampweaponweightvalue(value) {
  return clamp(value, 0.0, 11.0);
}

wait_and_force_weapon_switch(starting_weapon) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait 0.5;

  if(!self hasweapon(starting_weapon))
    starting_weapon = self getweaponslistprimaries()[0];

  self setspawnweapon(starting_weapon);
}

init_core_mp_perks() {
  level.perksetfuncs = [];
  level.scriptperks = [];
  level.perkunsetfuncs = [];
  level.scriptperks["specialty_falldamage"] = 1;
  level.scriptperks["specialty_armorpiercing"] = 1;
  level.scriptperks["specialty_gung_ho"] = 1;
  level.scriptperks["specialty_momentum"] = 1;
  level.perksetfuncs["specialty_momentum"] = ::setmomentum;
  level.perkunsetfuncs["specialty_momentum"] = ::unsetmomentum;
  level.perksetfuncs["specialty_falldamage"] = ::setfreefall;
  level.perkunsetfuncs["specialty_falldamage"] = ::unsetfreefall;
  level.perksetfuncs["specialty_lightweight"] = ::setlightweight;
  level.perkunsetfuncs["specialty_lightweight"] = ::unsetlightweight;
}

setmomentum() {
  thread runmomentum();
}

runmomentum() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(self issprinting()) {
      graduallyincreasespeed();
      self.movespeedscaler = 1;
      updatemovespeedscale();
    }

    wait 0.1;
  }
}

graduallyincreasespeed() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_reset");
  self endon("momentum_unset");
  thread momentum_monitormovement();
  thread momentum_monitordamage();

  for(_id_51438B11657961CC = 0; _id_51438B11657961CC < 0.08; _id_51438B11657961CC = _id_51438B11657961CC + 0.01) {
    self.movespeedscaler = self.movespeedscaler + 0.01;
    updatemovespeedscale();
    wait 0.4375;
  }

  self playlocalsound("ftl_phase_in");
  self notify("momentum_max_speed");
  thread momentum_endaftermax();
  self waittill("momentum_reset");
}

momentum_endaftermax() {
  self endon("momentum_unset");
  self waittill("momentum_reset");
  self playlocalsound("ftl_phase_out");
}

momentum_monitormovement() {
  self endon("death");
  self endon("disconnect");
  self endon("momentum_unset");

  for(;;) {
    if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
      wait 0.25;

      if(!self issprinting() || self issprintsliding() || !self isonground() || self iswallrunning()) {
        self notify("momentum_reset");
        break;
      }
    }

    waitframe();
  }
}

momentum_monitordamage() {
  self endon("death");
  self endon("disconnect");
  self waittill("damage");
  self notify("momentum_reset");
}

unsetmomentum() {
  self notify("momentum_unset");
}

setfreefall() {}

unsetfreefall() {}

setlightweight() {
  self.movespeedscaler = lightweightscalar();
  self[[level.move_speed_scale]]();
}

unsetlightweight() {
  self.movespeedscaler = 1;
  self[[level.move_speed_scale]]();
}

lightweightscalar() {
  return 1.12;
}

set_player_perks() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("force_bleed_out");
  self endon("last_stand");
  self endon("death");
  self endon("revive_success");

  if(game["state"] != "postgame") {
    wait 0.1;
    _id_0AD84ADCB356CFCE = 4;
    _id_97CA3D05716B420D = 0;
    _id_9CE56EBBDEC8A388 = 0;
    _id_9CE56EBBDEC8A388 = _id_0AD84ADCB356CFCE;

    if(isDefined(level.player_suit))
      scripts\cp\utility\player::_setsuit(level.player_suit);
    else
      scripts\cp\utility\player::_setsuit("iw9_suit_cp");

    self.suit = "iw9_suit_cp";
    self allowdoublejump(0);
    self allowslide(_id_9CE56EBBDEC8A388 &_id_0AD84ADCB356CFCE);
    self allowwallrun(0);
    self allowdodge(0);
  }

  self allowmantle(1);

  if(!scripts\cp\utility::is_consumable_active("grenade_cooldown")) {
    if(isDefined(level.power_modifycooldownrate))
      self[[level.power_modifycooldownrate]](0.0);
  }

  scripts\cp\utility::giveperk("specialty_throwback");
  self setscriptablepartstate("CompassIcon", "defaultIcon");
  self notify("set_player_perks");
}

registerplayercharacter(_id_F8892FD366226EB7, _id_80D695139E2AD462, body_model, view_model, head_model, hair_model, vo_prefix, vo_suffix, pap_gesture, revive_gesture, photo_index, fate_card_weapon, intro_music, intro_gesture, melee_weapon, post_setup_func, starting_weapon) {
  _id_0E060043AC076039 = spawnStruct();
  _id_0E060043AC076039.body_model = body_model;
  _id_0E060043AC076039.view_model = view_model;
  _id_0E060043AC076039.head_model = head_model;
  _id_0E060043AC076039.hair_model = hair_model;
  _id_0E060043AC076039.vo_prefix = vo_prefix;
  _id_0E060043AC076039.vo_suffix = vo_suffix;
  _id_0E060043AC076039.pap_gesture = pap_gesture;
  _id_0E060043AC076039.revive_gesture = revive_gesture;
  _id_0E060043AC076039.photo_index = photo_index;
  _id_0E060043AC076039.fate_card_weapon = fate_card_weapon;
  _id_0E060043AC076039.intro_music = intro_music;
  _id_0E060043AC076039.intro_gesture = intro_gesture;
  _id_0E060043AC076039.melee_weapon = makeweaponfromstring(melee_weapon);
  _id_0E060043AC076039.starting_weapon = makeweaponfromstring(starting_weapon);
  _id_0E060043AC076039.post_setup_func = post_setup_func;
  level.player_character_info[_id_F8892FD366226EB7] = _id_0E060043AC076039;

  if(!isDefined(level.available_player_characters))
    level.available_player_characters = [];

  if(_id_80D695139E2AD462 == "yes")
    level.available_player_characters[level.available_player_characters.size] = _id_F8892FD366226EB7;
}

loadout_updateclasscustom(struct, class) {
  _id_089688461C79EF11 = class;
  self.class_num = _id_089688461C79EF11;
  struct.loadoutprimary = cac_getweapon(_id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = cac_getweaponattachment(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
    struct.loadoutprimaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);
  }

  struct.loadoutprimarycamo = cac_getweaponcamo(_id_089688461C79EF11, 0);
  struct.loadoutprimaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 0);
  struct.loadoutprimarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 0);
  struct.loadoutprimaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 0);
  struct.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 0);

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 5; _id_36D2ABBDCBCB186C++)
    struct.loadoutprimarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 0, _id_36D2ABBDCBCB186C);

  struct.loadoutsecondary = cac_getweapon(_id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++) {
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = cac_getweaponattachment(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
    struct.loadoutsecondaryattachmentids[_id_DF6D8E005B4B8020] = cac_getweaponattachmentid(_id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);
  }

  struct.loadoutsecondarycamo = cac_getweaponcamo(_id_089688461C79EF11, 1);
  struct.loadoutsecondaryreticle = cac_getweaponreticle(_id_089688461C79EF11, 1);
  struct.loadoutsecondarylootitemid = cac_getweaponlootitemid(_id_089688461C79EF11, 1);
  struct.loadoutsecondaryvariantid = cac_getweaponvariantid(_id_089688461C79EF11, 1);
  struct.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(_id_089688461C79EF11, 1);

  for(_id_36D2ABBDCBCB186C = 0; _id_36D2ABBDCBCB186C < 4; _id_36D2ABBDCBCB186C++)
    struct.loadoutsecondarystickers[_id_36D2ABBDCBCB186C] = cac_getweaponsticker(_id_089688461C79EF11, 1, _id_36D2ABBDCBCB186C);

  struct.loadoutequipmentprimary = cac_getequipmentprimary(_id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = cac_getextraequipmentprimary(_id_089688461C79EF11);
  struct.loadoutequipmentsecondary = cac_getequipmentsecondary(_id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = cac_getextraequipmentsecondary(_id_089688461C79EF11);
  struct.loadoutgesture = cac_getgesture();
  struct.loadoutexecution = cac_getexecution();
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();
  _id_12E2FB553EC1605E::_id_2DAD855D27735128(struct);
  validateloadout(struct);
  return struct;
}

getclassindex(classname) {
  return level.classmap[classname];
}

validateloadout(loadout) {
  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutprimary))
    _id_35CCABD9AD4E542F = 1;

  if(weaponisrestricted(loadout.loadoutprimary)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutprimary = "iw8_ar_mike4";
    loadout.loadoutprimaryattachments = [];
    loadout.loadoutprimarycamo = "none";
    loadout.loadoutprimaryreticle = "none";
    loadout.loadoutprimaryvariantid = -1;
    loadout.loadoutprimaryattachmentids = [];
    loadout.loadoutprimarycosmeticattachment = "none";
    loadout.loadoutprimarystickers[0] = "none";
    loadout.loadoutprimarystickers[1] = "none";
    loadout.loadoutprimarystickers[2] = "none";
    loadout.loadoutprimarystickers[3] = "none";
    loadout.loadoutprimarystickers[4] = "none";
  } else {
    if(isweaponvariantlocked(loadout.loadoutprimary, loadout.loadoutprimaryvariantid))
      loadout.loadoutprimaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutprimaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8];
      _id_E7BA2038935530DB = loadout.loadoutprimaryattachmentids[_id_AC0E594AC96AA3A8];

      if(isattachmentvariantlocked(loadout.loadoutprimary, attachment, _id_E7BA2038935530DB))
        loadout.loadoutprimaryattachmentids[_id_AC0E594AC96AA3A8] = 0;

      if(attachment != "none" && (attachmentisrestricted(attachment, loadout.loadoutprimary) || !isvalidattachmentunlock(loadout.loadoutprimary, attachment))) {
        loadout.loadoutprimaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  _id_35CCABD9AD4E542F = 0;

  if(!_id_2669878CF5A1B6BC::_id_89497FA763D431C0(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;
  else if(isweaponuihidden(loadout.loadoutsecondary))
    _id_35CCABD9AD4E542F = 1;

  if(weaponisrestricted(loadout.loadoutsecondary)) {
    _id_35CCABD9AD4E542F = 1;
    _id_BC72F32B1575D517 = 1;
  }

  if(_id_35CCABD9AD4E542F) {
    loadout.loadoutsecondary = "iw8_pi_mike1911";
    loadout.loadoutsecondaryattachments = [];
    loadout.loadoutsecondarycamo = "none";
    loadout.loadoutsecondaryreticle = "none";
    loadout.loadoutsecondaryvariantid = -1;
    loadout.loadoutsecondaryattachmentids = [];
    loadout.loadoutsecondarycosmeticattachment = "none";
    loadout.loadoutsecondarystickers[0] = "none";
    loadout.loadoutsecondarystickers[1] = "none";
    loadout.loadoutsecondarystickers[2] = "none";
    loadout.loadoutsecondarystickers[3] = "none";
    loadout.loadoutsecondarystickers[4] = "none";
  } else {
    if(isweaponvariantlocked(loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid))
      loadout.loadoutsecondaryvariantid = -1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < loadout.loadoutsecondaryattachments.size; _id_AC0E594AC96AA3A8++) {
      attachment = loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8];
      _id_E7BA2038935530DB = loadout.loadoutsecondaryattachmentids[_id_AC0E594AC96AA3A8];

      if(isattachmentvariantlocked(loadout.loadoutsecondary, attachment, _id_E7BA2038935530DB))
        loadout.loadoutsecondaryattachmentids[_id_AC0E594AC96AA3A8] = 0;

      if(attachment != "none" && (attachmentisrestricted(attachment, loadout.loadoutsecondary) || !isvalidattachmentunlock(loadout.loadoutsecondary, attachment))) {
        loadout.loadoutsecondaryattachments[_id_AC0E594AC96AA3A8] = "none";
        _id_E1388376A5BE9B75 = 1;
      }
    }
  }

  return loadout;
}

isvalidattachmentunlock(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA) {
  _id_338C04A2F19BA8B6 = getdvarint("scr_checkvalidattachmentunlock", 0) == 1;

  if(_id_338C04A2F19BA8B6)
    return attachmentisselectablerootname(_id_49E6EF3EDADD524E, _id_55F8624E7216D9AA);

  return 1;
}

attachmentisselectablerootname(_id_49E6EF3EDADD524E, attachment) {
  if(isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E].assetname)) {
    slot = _func_6730D890F604CABE(level.weaponmapdata[_id_49E6EF3EDADD524E].assetname, attachment);

    if(isDefined(slot) && slot != -1)
      return isDefined(level.weaponattachments[attachment]);
  }

  return 0;
}

isweaponuihidden(_id_49E6EF3EDADD524E) {
  return isDefined(level.weaponmapdata[_id_49E6EF3EDADD524E]) && istrue(level.weaponmapdata[_id_49E6EF3EDADD524E].uihidden);
}

isweaponvariantlocked(_id_49E6EF3EDADD524E, variantid) {
  if(!isDefined(variantid) || variantid <= 0)
    return 0;

  _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + variantid;
  return isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749]) && istrue(level.weaponlootmapdata[_id_A6ED1602A5107749].islocked);
}

isattachmentvariantlocked(_id_49E6EF3EDADD524E, attachment, _id_1708B873A34EEB50) {
  if(!isDefined(_id_1708B873A34EEB50) || _id_1708B873A34EEB50 == 0 || attachment == "none")
    return 0;

  _id_FFE43E0D1655060E = 0;
  _id_ABF526089D208196 = 1;

  for(;;) {
    _id_A6ED1602A5107749 = _id_49E6EF3EDADD524E + "|" + _id_ABF526089D208196;

    if(!isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749])) {
      break;
    }

    if(!level.weaponlootmapdata[_id_A6ED1602A5107749].islocked) {
      if(isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap)) {
        foreach(key, id in level.weaponlootmapdata[_id_A6ED1602A5107749].attachcustomtoidmap) {
          if(_id_1708B873A34EEB50 == id && attachment == key) {
            _id_FFE43E0D1655060E = 1;
            break;
          }
        }
      }

      if(_id_FFE43E0D1655060E) {
        break;
      }
    }

    _id_ABF526089D208196++;
  }

  return !_id_FFE43E0D1655060E;
}

loadout_updateclassdefault(struct, _id_089688461C79EF11) {
  self.class_num = _id_089688461C79EF11;
  struct.loadoutprimary = table_getweapon(level.classtablename, _id_089688461C79EF11, 0);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
    struct.loadoutprimaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 0, _id_DF6D8E005B4B8020);

  struct.loadoutprimarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutprimaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 0);
  struct.loadoutsecondary = table_getweapon(level.classtablename, _id_089688461C79EF11, 1);

  for(_id_DF6D8E005B4B8020 = 0; _id_DF6D8E005B4B8020 < 5; _id_DF6D8E005B4B8020++)
    struct.loadoutsecondaryattachments[_id_DF6D8E005B4B8020] = table_getweaponattachment(level.classtablename, _id_089688461C79EF11, 1, _id_DF6D8E005B4B8020);

  struct.loadoutsecondarycamo = table_getweaponcamo(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutsecondaryreticle = table_getweaponreticle(level.classtablename, _id_089688461C79EF11, 1);
  struct.loadoutequipmentprimary = table_getequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentprimary = table_getextraequipmentprimary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutequipmentsecondary = table_getequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutextraequipmentsecondary = table_getextraequipmentsecondary(level.classtablename, _id_089688461C79EF11);
  struct.loadoutgesture = table_getgesture(level.classtablename, _id_089688461C79EF11);
  struct.loadoutexecution = cac_getexecution();
  _id_12E2FB553EC1605E::_id_2DAD855D27735128(struct);
  struct.loadoutaccessoryweapon = cac_getaccessoryweapon();
  struct.loadoutaccessorydata = cac_getaccessorydata();
  struct.loadoutaccessorylogic = cac_getaccessorylogic();

  if(getdvarint("dvar_CEF27C8D9E5E0053", 0))
    struct.loadoutsuper = "super_bradley";

  return struct;
}

cac_getgesture() {
  _id_DA50F25E979BAB7D = "none";

  if(isDefined(self.changedarchetypeinfo)) {
    _id_6D1A148EFA806994 = level.archetypeids[self.changedarchetypeinfo.archetype];
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypePreferences", _id_6D1A148EFA806994, "gesture");
  } else
    _id_DA50F25E979BAB7D = self getplayerdata(level.loadoutsgroup, "squadMembers", "gesture");

  return scripts\cp_mp\gestures::getgesturedata(_id_DA50F25E979BAB7D);
}

cac_getaccessoryweapon() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessoryweaponbyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorydata() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorydatabyindex(_id_160F3CB2BB4232D3);
}

cac_getaccessorylogic() {
  _id_160F3CB2BB4232D3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorWatch");
  return scripts\cp\cp_accessories::getaccessorylogicbyindex(_id_160F3CB2BB4232D3);
}

cac_getexecution() {
  return "neck_stab";
}

cac_getweaponsticker(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_36D2ABBDCBCB186C) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "sticker", _id_36D2ABBDCBCB186C);
}

give_weapons_from_loadout(player, _id_7CB3CE39E2414126) {
  struct = spawnStruct();
  _id_D0EF877013D341AF = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();

  if(isDefined(_id_7CB3CE39E2414126))
    _id_D0EF877013D341AF = loadout_updateclassdefault(struct, _id_7CB3CE39E2414126);
  else
    _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);

  self.custom_loadout_index = _id_A52C671ACCA08378;
  self.classstruct = _id_D0EF877013D341AF;
  assign_loadout_weapons(player, _id_D0EF877013D341AF);
  _id_918C7D3ED87EA3E8 = get_num_of_charges_for_power(player, "primary");
  _id_F366AF1BB183316C = get_grenade_from_struct(_id_D0EF877013D341AF.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, _id_F366AF1BB183316C))
    _id_F366AF1BB183316C = "none";

  _id_DCA226EE1D93A538 = get_num_of_charges_for_power(player, "secondary");
  _id_5E7BDAD4B7D0C7AC = get_grenade_from_struct(_id_D0EF877013D341AF.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, _id_5E7BDAD4B7D0C7AC))
    _id_5E7BDAD4B7D0C7AC = "none";

  player _id_12E2FB553EC1605E::_id_9743C56A4D2DC135(_id_D0EF877013D341AF);
  _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");

  if(!istrue(self.changing_loadout)) {
    player _id_644C18834356D9DC::reset_munitions(self, _id_B8BA56B9EDD59CB7);
    player _id_644C18834356D9DC::assign_lowest_full_slot_to_active();
  }

  player thread scripts\cp\cp_powers::givepower(_id_F366AF1BB183316C, "primary", undefined, undefined, undefined, undefined, 1, _id_918C7D3ED87EA3E8);
  player thread scripts\cp\cp_powers::givepower(_id_5E7BDAD4B7D0C7AC, "secondary", undefined, undefined, undefined, undefined, 1, _id_DCA226EE1D93A538);
}

get_num_of_charges_for_power(player, _id_4EFDB87F020AAE7D) {
  if(isDefined(level.get_num_of_charges_for_power))
    return [[level.get_num_of_charges_for_power]](player);

  if(scripts\cp\utility::is_wave_gametype()) {
    perk = cac_getloadoutperk(undefined, 2);

    if(perk == "specialty_extra_shrapnel")
      scripts\cp\utility::giveperk("specialty_extra_deadly");
  }

  if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && _id_4EFDB87F020AAE7D == "primary")
    return 2;

  if(isDefined(self.perk_data["offhand_count"]))
    return self.perk_data["offhand_count"];

  return 1;
}

get_default_num_equipment_charges() {
  return 1;
}

give_equipment_from_loadout(player, _id_CBB2B3D05E48BD27, _id_7CB3CE39E2414126) {
  struct = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();

  if(isDefined(_id_7CB3CE39E2414126))
    _id_D0EF877013D341AF = loadout_updateclassdefault(struct, _id_7CB3CE39E2414126);
  else
    _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);

  _id_918C7D3ED87EA3E8 = get_num_of_charges_for_power(player, "primary");
  _id_F366AF1BB183316C = get_grenade_from_struct(_id_D0EF877013D341AF.loadoutequipmentprimary);

  if(!scripts\engine\utility::array_contains_key(level.powers, _id_F366AF1BB183316C))
    _id_F366AF1BB183316C = "none";

  _id_DCA226EE1D93A538 = get_num_of_charges_for_power(player, "secondary");
  _id_5E7BDAD4B7D0C7AC = get_grenade_from_struct(_id_D0EF877013D341AF.loadoutequipmentsecondary);

  if(!scripts\engine\utility::array_contains_key(level.powers, _id_5E7BDAD4B7D0C7AC))
    _id_5E7BDAD4B7D0C7AC = "none";

  if(!isDefined(_id_CBB2B3D05E48BD27)) {
    player thread scripts\cp\cp_powers::givepower(_id_F366AF1BB183316C, "primary", undefined, undefined, undefined, undefined, 1, _id_918C7D3ED87EA3E8);
    player thread scripts\cp\cp_powers::givepower(_id_5E7BDAD4B7D0C7AC, "secondary", undefined, undefined, undefined, undefined, 1, _id_DCA226EE1D93A538);
  } else if(_id_CBB2B3D05E48BD27 == 0)
    player thread scripts\cp\cp_powers::givepower(_id_F366AF1BB183316C, "primary", undefined, undefined, undefined, undefined, 1, _id_918C7D3ED87EA3E8);
  else if(_id_CBB2B3D05E48BD27 == 1)
    player thread scripts\cp\cp_powers::givepower(_id_5E7BDAD4B7D0C7AC, "secondary", undefined, undefined, undefined, undefined, 1, _id_DCA226EE1D93A538);
}

give_and_switch_to_primary_weapon(player) {
  struct = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();
  _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);
  _id_D0EF877013D341AF.loadoutprimaryobject = player give_primary_weapon(player, _id_D0EF877013D341AF);
  _id_B56CA02611905136 = weaponclipsize(struct.loadoutprimaryobject);
  ammocount = weaponmaxammo(struct.loadoutprimaryobject);
  player giveweapon(struct.loadoutprimaryobject);
  player setweaponammoclip(struct.loadoutprimaryobject, _id_B56CA02611905136);
  player setweaponammostock(struct.loadoutprimaryobject, ammocount);
  player switchtoweapon(struct.loadoutprimaryobject);
}

give_primary_attachments_only(player, clipammo, stockammo) {
  struct = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();
  _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);
  _id_D0EF877013D341AF.loadoutprimaryobject = player give_primary_weapon(player, _id_D0EF877013D341AF);
  player giveweapon(struct.loadoutprimaryobject);
  player setweaponammoclip(struct.loadoutprimaryobject, clipammo);
  player setweaponammostock(struct.loadoutprimaryobject, stockammo);
  player switchtoweapon(struct.loadoutprimaryobject);
}

give_and_switch_to_secondary_weapon(player, struct) {
  struct = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();
  _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);
  _id_D0EF877013D341AF.loadoutsecondaryobject = player give_secondary_weapon(player, _id_D0EF877013D341AF);
  _id_B56CA02611905136 = weaponclipsize(_id_D0EF877013D341AF.loadoutsecondaryobject);
  ammocount = weaponmaxammo(_id_D0EF877013D341AF.loadoutsecondaryobject);
  player giveweapon(_id_D0EF877013D341AF.loadoutsecondaryobject);
  player setweaponammoclip(_id_D0EF877013D341AF.loadoutsecondaryobject, _id_B56CA02611905136);
  player setweaponammostock(_id_D0EF877013D341AF.loadoutsecondaryobject, ammocount);
  player switchtoweaponimmediate(_id_D0EF877013D341AF.loadoutsecondaryobject);
}

give_secondary_attachments_only(player, clipammo, stockammo) {
  struct = spawnStruct();
  _id_A52C671ACCA08378 = player cac_getloadoutselectedidx();
  _id_D0EF877013D341AF = loadout_updateclasscustom(struct, _id_A52C671ACCA08378);
  _id_D0EF877013D341AF.loadoutsecondaryobject = player give_secondary_weapon(player, _id_D0EF877013D341AF);
  player giveweapon(struct.loadoutsecondaryobject);
  player setweaponammoclip(struct.loadoutsecondaryobject, clipammo);
  player setweaponammostock(struct.loadoutsecondaryobject, stockammo);
  player switchtoweapon(struct.loadoutsecondaryobject);
}

change_loadout_watcher(player) {
  level endon("game_ended");
  player endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, value);

    if(_id_7148C1A6F25491F8 == "class_select" || _id_7148C1A6F25491F8 == "class_edit" || _id_7148C1A6F25491F8 == "class_menu_closed") {
      if(is_player_carrying_special_item())
        self notify("switched_from_core");

      if(_id_7148C1A6F25491F8 == "class_select") {
        if(value >= 100)
          _id_089688461C79EF11 = value - 100;
        else
          _id_089688461C79EF11 = undefined;

        if(_id_0AFB7E332AEE4BF2::player_in_laststand(self))
          self notify("loadout_menu_closed");
        else {
          self.changing_loadout = 1;
          self.defaultclassindex = _id_089688461C79EF11;

          if(scripts\engine\utility::ent_flag_exist("player_spawned_with_loadout") && scripts\engine\utility::ent_flag("player_spawned_with_loadout"))
            self[[level.custom_giveloadout]](0, undefined, _id_089688461C79EF11, 1);
          else
            self[[level.custom_giveloadout]](0, undefined, _id_089688461C79EF11);
        }

        thread display_relics_splash(self, 5);
      }

      if(_id_7148C1A6F25491F8 == "class_menu_closed") {
        self notify("loadout_menu_closed");

        if(scripts\cp\utility::is_wave_gametype())
          thread buy_menu_closed();
      }

      continue;
    }

    if(_id_7148C1A6F25491F8 == "update_super") {
      _id_56EF8D52FE1B48A1::give_player_super();
      continue;
    }

    if(_id_7148C1A6F25491F8 == "munitions_updated") {
      _id_B8BA56B9EDD59CB7 = self getplayerdata("cp", "inventorySlots", "totalSlots");
      _id_644C18834356D9DC::reset_munitions(self, _id_B8BA56B9EDD59CB7);

      if(scripts\cp\utility::is_wave_gametype()) {
        sync_currency();
        thread buy_menu_closed();
      }

      continue;
    }

    if(_id_7148C1A6F25491F8 == "weapon_purchased" && scripts\cp\utility::is_wave_gametype()) {
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      if(self getweaponslistprimaries().size > 1) {
        _id_986CBCEA81712875 = scripts\cp\utility::getvalidtakeweapon();
        self takeweapon(_id_986CBCEA81712875);
      }

      if(self.open_cac_slot == 0)
        give_and_switch_to_primary_weapon(self);
      else if(self.open_cac_slot == 1)
        give_and_switch_to_secondary_weapon(self);

      continue;
    }

    if(_id_7148C1A6F25491F8 == "attachment_purchased" && scripts\cp\utility::is_wave_gametype()) {
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      _id_986CBCEA81712875 = scripts\cp\utility::getvalidtakeweapon();
      _id_A3254571B0C90796 = self getweaponammoclip(_id_986CBCEA81712875);
      _id_9938D9499DF221D6 = self getweaponammostock(_id_986CBCEA81712875);
      self takeweapon(_id_986CBCEA81712875);

      if(self.open_cac_slot == 0)
        give_primary_attachments_only(self, _id_A3254571B0C90796, _id_9938D9499DF221D6);
      else if(self.open_cac_slot == 1)
        give_secondary_attachments_only(self, _id_A3254571B0C90796, _id_9938D9499DF221D6);

      continue;
    }

    if(_id_7148C1A6F25491F8 == "tactical_purchased" && scripts\cp\utility::is_wave_gametype()) {
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      give_equipment_from_loadout(self, 1, undefined);
      continue;
    }

    if(_id_7148C1A6F25491F8 == "lethal_purchased" && scripts\cp\utility::is_wave_gametype()) {
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      give_equipment_from_loadout(self, 0, undefined);
      continue;
    }

    if(_id_7148C1A6F25491F8 == "shrapnel_perk_purchased" && scripts\cp\utility::is_wave_gametype()) {
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      give_equipment_from_loadout(self, 0, undefined);
      continue;
    }

    if(_id_7148C1A6F25491F8 == "ammo_purchased" && scripts\cp\utility::is_wave_gametype()) {
      _id_986CBCEA81712875 = scripts\cp\utility::getvalidtakeweapon();
      sync_currency();

      if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
        player waittill("revive_success");
        waitframe();
      }

      self givemaxammo(_id_986CBCEA81712875);
      self setweaponammoclip(_id_986CBCEA81712875, weaponclipsize(_id_986CBCEA81712875));
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_7A11AF8950A9A3FA", undefined, 0.2);
    }
  }
}

display_relics_splash(player, time) {
  wait 1.5;

  if(level.set_relics.size > 0) {
    player setclientomnvar("ui_match_start_countdown", time);
    wait(time);
    player setclientomnvar("ui_match_start_countdown", -1);
  }
}

buy_menu_closed() {
  self clearsoundsubmix("cp_store_duck", 1);
}

sync_currency() {
  _id_D7FE0F139D9AC266 = self getplayerdata(level.loadoutsgroup, "squadMembers", "currencyWaveMode");
  scripts\cp\cp_persistence::set_player_currency(_id_D7FE0F139D9AC266);
}

get_grenade_from_struct(_id_019CD48B2DAF2547) {
  return _id_019CD48B2DAF2547;
}

cac_getloadoutselectedidx() {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "cpLoadoutSel");
}

cac_getloadoutperk(_id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", _id_2B8554E15B5C8E77);
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "loadoutPerks", _id_2B8554E15B5C8E77);
}

cac_getloadoutextraperk(_id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "extraPerks", _id_2B8554E15B5C8E77);
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "extraPerks", _id_2B8554E15B5C8E77);
}

cac_getweapon(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "weapon");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "weapon");
}

cac_getweaponattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_10DC579C373A93DD = undefined;
  weapon = cac_getweapon(_id_089688461C79EF11, _id_FE4048AD22C35D73);

  if(scripts\cp\utility::is_wave_gametype())
    _id_10DC579C373A93DD = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");
  else
    _id_10DC579C373A93DD = self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "attachment");

  _id_2669878CF5A1B6BC::_id_6E7BC1B23AFA0EA8(weapon, _id_10DC579C373A93DD);
}

cac_getweaponattachmentid(_id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "attachmentSetup", _id_DF6D8E005B4B8020, "variantID");
}

cac_getweaponlootitemid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "lootItemID");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "lootItemID");
}

cac_getweaponvariantid(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "variantID");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "variantID");
}

cac_getweaponcamo(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "camo");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "camo");
}

cac_getweaponreticle(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "reticle");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "reticle");
}

cac_getweaponcosmeticattachment(_id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "weaponSetups", _id_FE4048AD22C35D73, "cosmeticAttachment");
}

cac_checkoverkillperk(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "loadoutPerks", 0);
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "loadoutPerks", 0);
}

cac_getequipmentprimary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "equipment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "equipment");
}

cac_getextraequipmentprimary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 0, "extraCharge");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 0, "extraCharge");
}

cac_getequipmentsecondary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "equipment");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "equipment");
}

cac_getextraequipmentsecondary(_id_089688461C79EF11) {
  if(scripts\cp\utility::is_wave_gametype())
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadoutWaveMode", "equipmentSetups", 1, "extraCharge");
  else
    return self getplayerdata(level.loadoutsgroup, "squadMembers", "loadouts", _id_089688461C79EF11, "equipmentSetups", 1, "extraCharge");
}

assign_loadout_weapons(player, struct) {
  if(struct.loadoutprimary == "none") {
    struct.loadoutprimaryfullname = "none";
    struct.loadoutprimaryobject = undefined;
  } else {
    struct.loadoutprimaryobject = _id_2669878CF5A1B6BC::buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, struct.loadoutprimaryattachmentids, struct.loadoutprimarycosmeticattachment, struct.loadoutprimarystickers, istrue(struct.loadouthasnvg));
    struct.loadoutprimaryobject = give_weapon_alt_clip_ammo_hack(player, struct.loadoutprimaryobject);
    struct.loadoutprimaryfullname = getcompleteweaponname(struct.loadoutprimaryobject);
  }

  if(struct.loadoutsecondary == "none") {
    struct.loadoutsecondaryfullname = "none";
    struct.loadoutsecondaryobject = undefined;
  } else {
    struct.loadoutsecondaryobject = _id_2669878CF5A1B6BC::buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, struct.loadoutsecondaryattachmentids, struct.loadoutsecondarycosmeticattachment, struct.loadoutsecondarystickers, istrue(struct.loadouthasnvg));
    struct.loadoutsecondaryobject = give_weapon_alt_clip_ammo_hack(player, struct.loadoutsecondaryobject);
    struct.loadoutsecondaryfullname = getcompleteweaponname(struct.loadoutsecondaryobject);
  }

  player.starting_weapon = struct.loadoutprimaryobject;
  player.primaryweaponobj = player.starting_weapon;
  player.default_starting_pistol = struct.loadoutsecondaryobject;
  player.secondaryweaponobj = player.default_starting_pistol;
}

give_primary_weapon(player, struct) {
  return _id_2669878CF5A1B6BC::buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments);
}

give_secondary_weapon(player, struct) {
  return _id_2669878CF5A1B6BC::buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments);
}

give_weapon_alt_clip_ammo_hack(player, weaponobj) {
  _id_6890A4CE965BBA99 = weaponobj getaltweapon();

  if(_id_6890A4CE965BBA99.basename != "none") {
    _id_91093EF03654702C = weaponclass(_id_6890A4CE965BBA99);

    if(_id_91093EF03654702C == "spread")
      player setweaponammoclip(_id_6890A4CE965BBA99, weaponclipsize(_id_6890A4CE965BBA99));
  }

  return weaponobj;
}

_id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50) {
  if(!isDefined(level._id_F64740277F13E29B) || level._id_F64740277F13E29B.id != _id_00CEBA6EC7E8CA50) {
    level._id_F64740277F13E29B = spawnStruct();
    level._id_F64740277F13E29B.id = _id_00CEBA6EC7E8CA50;
    level._id_F64740277F13E29B._id_92F35FCFAE58B4EB = [];
    level._id_F64740277F13E29B._id_09DDC180A1A5121D = getscriptbundle(_id_00CEBA6EC7E8CA50);
  }

  return level._id_F64740277F13E29B;
}

_id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);

  if(!isDefined(_id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11])) {
    _id_5FF608A2CF5C041B = _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3[_id_089688461C79EF11];
    _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11] = getscriptbundle("classtableentry:" + _id_5FF608A2CF5C041B._id_F90358454413407F);
  }

  return _id_F64740277F13E29B._id_92F35FCFAE58B4EB[_id_089688461C79EF11];
}

_id_DF2933F96D726D71(_id_00CEBA6EC7E8CA50) {
  _id_F64740277F13E29B = _id_ACAD491093697C6C(_id_00CEBA6EC7E8CA50);
  return _id_F64740277F13E29B._id_09DDC180A1A5121D._id_8D5460BE7DB831C3.size;
}

table_getweapon(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.weapon;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.weapon;
}

table_getweaponattachment(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73, _id_DF6D8E005B4B8020) {
  _id_AD6F9AC053FF4870 = "none";
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct.primaryweapon.attachments))
    classstruct.primaryweapon.attachments = [classstruct.primaryweapon._id_59F68715C04CE28F, classstruct.primaryweapon._id_59F68815C04CE4C2, classstruct.primaryweapon._id_59F68915C04CE6F5, classstruct.primaryweapon._id_59F68215C04CD790, classstruct.primaryweapon._id_59F68315C04CD9C3, classstruct.primaryweapon._id_59F68415C04CDBF6];

  if(!isDefined(classstruct.secondaryweapon.attachments))
    classstruct.secondaryweapon.attachments = [classstruct.secondaryweapon._id_59F68715C04CE28F, classstruct.secondaryweapon._id_59F68815C04CE4C2, classstruct.secondaryweapon._id_59F68915C04CE6F5, classstruct.secondaryweapon._id_59F68215C04CD790, classstruct.secondaryweapon._id_59F68315C04CD9C3];

  if(_id_FE4048AD22C35D73 == 0)
    _id_AD6F9AC053FF4870 = classstruct.primaryweapon.attachments[_id_DF6D8E005B4B8020];
  else
    _id_AD6F9AC053FF4870 = classstruct.secondaryweapon.attachments[_id_DF6D8E005B4B8020];

  if(!isDefined(_id_AD6F9AC053FF4870) || _id_AD6F9AC053FF4870 == "")
    return "none";
  else
    return _id_AD6F9AC053FF4870;
}

table_getweaponcamo(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.camo;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.camo;
}

table_getweaponreticle(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_FE4048AD22C35D73) {
  if(_id_FE4048AD22C35D73 == 0)
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).primaryweapon.reticle;
  else
    return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).secondaryweapon.reticle;
}

table_getperk(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct._id_77BC1C85DC4C173F))
    classstruct._id_77BC1C85DC4C173F = [classstruct.perks._id_16680ABD1742C050, classstruct.perks._id_16680DBD1742C6E9, classstruct.perks._id_16680CBD1742C4B6];

  return classstruct._id_77BC1C85DC4C173F[_id_2B8554E15B5C8E77];
}

table_getextraperk(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11, _id_2B8554E15B5C8E77) {
  classstruct = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11);

  if(!isDefined(classstruct._id_9E0A050F0398EDC3))
    classstruct._id_9E0A050F0398EDC3 = [classstruct._id_50D0559DCBA571E2._id_16680ABD1742C050, classstruct._id_50D0559DCBA571E2._id_16680DBD1742C6E9, classstruct._id_50D0559DCBA571E2._id_16680CBD1742C4B6];

  return classstruct._id_9E0A050F0398EDC3[_id_2B8554E15B5C8E77];
}

table_getequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment.primary;
}

table_getextraequipmentprimary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE.primary;
  return isDefined(value) && value == "1";
}

table_getequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).equipment._id_D7B9856A19F9B6B5;
}

table_getextraequipmentsecondary(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11)._id_AD6972268C86A2BE._id_D7B9856A19F9B6B5;
  return isDefined(value) && value == 1;
}

table_getsuper(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).super;
}

table_getspecialist(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  value = _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).specialist;
  return isDefined(value) && value == 1;
}

table_getgesture(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).gesture;
}

table_getexecution(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).execution;
}

table_getrole(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11) {
  return _id_0C7A0B640C398497(_id_00CEBA6EC7E8CA50, _id_089688461C79EF11).role;
}

getclasschoice(_id_3FD595213E78030A) {
  _id_3FD595213E78030A++;
  _id_2D36749FDFFC49B4 = undefined;

  if(_id_3FD595213E78030A > 100) {
    _id_089688461C79EF11 = _id_3FD595213E78030A - 100;
    _id_2D36749FDFFC49B4 = "default" + _id_089688461C79EF11;
  } else
    _id_2D36749FDFFC49B4 = "custom" + _id_3FD595213E78030A;

  return _id_2D36749FDFFC49B4;
}

is_player_carrying_special_item() {
  if(isDefined(level.nuclear_core_carrier) && level.nuclear_core_carrier == self)
    return 1;
  else if(_id_74502A9E0EF1F19C::player_has_minigun(self))
    return 1;
  else
    return 0;
}

drop_special_item() {
  if(_id_74502A9E0EF1F19C::player_has_minigun(self))
    _id_74502A9E0EF1F19C::drop_minigun(self);
}