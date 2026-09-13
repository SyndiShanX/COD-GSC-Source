/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weapons.gsc
***********************************************/

attachmentgroup(_id_659F734FC2A248FF) {
  return tablelookup("mp/attachmenttable.csv", 4, _id_659F734FC2A248FF, 2);
}

_id_1228C18F9F40A227() {
  if(!isDefined(level._id_1D9816060754F796))
    level._id_1D9816060754F796 = [];

  if(!isDefined(level._id_20B06C3352BAB75E))
    level._id_20B06C3352BAB75E = [];
}

init() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.maxperplayerexplosives = max(scripts\mp\utility\dvars::getintproperty("scr_maxperplayerexplosives", 2), 1);
  level.riotshieldxpbullets = scripts\mp\utility\dvars::getintproperty("scr_riotshieldxpbullets", 15);
  level._id_34777CC7C85EDBE6 = getdvarint("scr_weapondeletedist", 96);

  switch (scripts\mp\utility\dvars::getintproperty("perk_scavengermode", 0)) {
    case 1:
      level.scavenger_altmode = 0;
      break;
    case 2:
      level.scavenger_secondary = 0;
      break;
    case 3:
      level.scavenger_altmode = 0;
      level.scavenger_secondary = 0;
      break;
  }

  _id_2669878CF5A1B6BC::buildweaponmap();
  _id_2669878CF5A1B6BC::buildattachmentmaps();
  _id_2669878CF5A1B6BC::_id_EE4A536A155313B7();
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch");
  level._effect["xmike109ThermiteBounce"] = loadfx("vfx/iw8_mp/equipment/vfx_xmike109_thermite_bounce");
  scripts\mp\utility\entity::placeequipmentfailedinit();
  level.weaponconfigs = [];

  if(!isDefined(level.weapondropfunction))
    level.weapondropfunction = ::dropweaponfordeath;

  level._id_20F39C8ACB381AD5["pi"] = "weap_drop_pistol";
  level._id_20F39C8ACB381AD5["sm"] = "weap_drop_small";
  level._id_20F39C8ACB381AD5["ar"] = "weap_drop_med";
  level._id_20F39C8ACB381AD5["sh"] = "weap_drop_med";
  level._id_20F39C8ACB381AD5["sn"] = "weap_drop_large";
  level._id_20F39C8ACB381AD5["lm"] = "weap_drop_xlarge";
  level._id_20F39C8ACB381AD5["la"] = "weap_drop_launcher";
  _id_07522D80D673F6F7 = 25;
  level.sticky_minedetectiondot = cos(_id_07522D80D673F6F7);
  level.sticky_minedetectionmindist = 15;
  level.sticky_minedetectiongraceperiod = 0.35;
  level.sticky_minedetonateradius = 256;
  level.minedetectiongraceperiod = 0.3;
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.missile_array = [];
  level.inventory_array = [];
  level.mines = [];
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level thread onplayerconnect();
  scripts\mp\utility\outline::initoutlineoccluders();
  init_function_refs();
  _id_1228C18F9F40A227();
  level.onweapondropcreated = scripts\cp_mp\utility\callback_group::callback_create();
  level.onweapondroppickedup = scripts\cp_mp\utility\callback_group::callback_create();

  if(getdvarint("perk_graverobber_enabled") == 1)
    level thread savegraverobberammo();
}

savegraverobberammo() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(!isDefined(player)) {
          continue;
        }
        if(player scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons")) {
          weapon = player getcurrentweapon();
          player getcurrentweapon();

          if(!isDefined(weapon)) {
            continue;
          }
          if(!isDefined(player.graverobberammo)) {
            player.graverobberammo = spawnStruct();
            player.graverobberammo = spawnStruct();
            player.graverobberammo = spawnStruct();
          }

          if(isDefined(player.graverobberammo.currentweapon) && player.graverobberammo.currentweapon.weapon.basename != "none" && player.graverobberammo.currentweapon.weapon != weapon) {
            player.graverobberammo.lastweapon = player.graverobberammo.currentweapon;
            player.graverobberammo.currentweapon = spawnStruct();
          }

          player.graverobberammo.currentweapon = spawnStruct();
          player.graverobberammo.currentweapon.weapon = weapon;
          player.graverobberammo.currentweapon.rightclip = player getweaponammoclip(weapon, "right");
          player.graverobberammo.currentweapon.leftclip = player getweaponammoclip(weapon, "left");
          player.graverobberammo.currentweapon.stock = player getweaponammostock(weapon);
          continue;
        }

        player.graverobberammo = undefined;
      }
    }

    waitframe();
  }
}

enablevisibilitycullingforclient(_id_2C6CA80E296FED3A) {
  self hudoutlinedisableforclient(_id_2C6CA80E296FED3A);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.hits = [];
    player._id_5FFAA0CEB1F66708 = [];
    player._id_C63A7F2980C7D596 = [];
    scripts\mp\gamelogic::sethasdonecombat(player, 0);
    player thread watchmissileusage();

    if(getdvarint("dvar_7A52196CE3C53C73", 0) && scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
      player thread _id_627ADF66CF046C65();
  }
}

_id_627ADF66CF046C65() {
  self endon("disconnect");
  logstring("watch_mobile_cheat_loadouts finished setup.");

  for(;;) {
    self waittill("luinotifyserver", message, _id_2150015540242E9E);

    if(message == "mobile_debug_give_killstreak") {
      _id_A4E8372932B8612C = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          _id_A4E8372932B8612C = "toma_strike";
          break;
        case 1:
          _id_A4E8372932B8612C = "precision_airstrike";
          break;
        case 2:
          _id_A4E8372932B8612C = "uav";
          break;
        case 4:
          _id_A4E8372932B8612C = "scrambler_drone_guard";
          break;
        case 5:
          _id_A4E8372932B8612C = "directional_uav";
          break;
        case 6:
          _id_A4E8372932B8612C = "assault_drone";
          break;
        case 7:
          _id_A4E8372932B8612C = "airdrop";
          break;
        case 8:
          _id_A4E8372932B8612C = "fuel_airstrike";
          break;
        case 9:
          _id_A4E8372932B8612C = "hover_jet";
          break;
        case 10:
          _id_A4E8372932B8612C = "airdrop_escort";
          break;
        case 11:
          _id_A4E8372932B8612C = "auto_drone";
          break;
        case 12:
          _id_A4E8372932B8612C = "chopper_gunner";
          break;
        case 13:
          _id_A4E8372932B8612C = "airdrop_multiple";
          break;
        case 14:
          _id_A4E8372932B8612C = "gunship";
          break;
        case 15:
          _id_A4E8372932B8612C = "juggernaut";
          break;
        case 16:
          _id_A4E8372932B8612C = "cruise_predator";
          break;
        case 17:
          _id_A4E8372932B8612C = "sentry_gun";
          break;
        case 18:
          _id_A4E8372932B8612C = "pac_sentry";
          break;
        case 19:
          _id_A4E8372932B8612C = "scrambler_drone_guard";
          break;
      }

      if(isDefined(_id_A4E8372932B8612C))
        scripts\mp\killstreaks\killstreaks::awardkillstreak(_id_A4E8372932B8612C, "other");

      continue;
    }

    if(message == "mobile_debug_give_fieldupgrade") {
      _id_D782E69CA6374BA6 = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          _id_D782E69CA6374BA6 = "super_tac_cover";
          break;
        case 1:
          _id_D782E69CA6374BA6 = "super_trophy";
          break;
        case 2:
          _id_D782E69CA6374BA6 = "super_deadsilence";
          break;
        case 3:
          _id_D782E69CA6374BA6 = "super_support_box";
          break;
        case 4:
          _id_D782E69CA6374BA6 = "super_ammo_drop";
          break;
        case 5:
          _id_D782E69CA6374BA6 = "super_armor_drop";
          break;
        case 6:
          _id_D782E69CA6374BA6 = "super_battlerage";
          break;
        case 7:
          _id_D782E69CA6374BA6 = "super_tac_camera";
          break;
        case 8:
          _id_D782E69CA6374BA6 = "super_deployed_decoy";
          break;
        case 9:
          _id_D782E69CA6374BA6 = "super_loadout_drop";
          break;
        case 10:
          _id_D782E69CA6374BA6 = "super_tac_insert";
          break;
        case 11:
          _id_D782E69CA6374BA6 = "super_sonar_pulse";
          break;
        case 12:
          _id_D782E69CA6374BA6 = "super_sound_veil";
          break;
        case 13:
          _id_D782E69CA6374BA6 = "super_recon_drone";
          break;
        case 14:
          _id_D782E69CA6374BA6 = "super_emp_pulse";
          break;
      }

      if(isDefined(_id_D782E69CA6374BA6))
        scripts\mp\supers::givesuper(_id_D782E69CA6374BA6, 0, 1);

      continue;
    }

    if(message == "mobile_debug_give_equipment") {
      equipmentref = undefined;

      switch (_id_2150015540242E9E) {
        case 0:
          equipmentref = "equip_frag";
          break;
        case 1:
          equipmentref = "equip_at_mine";
          break;
        case 2:
          equipmentref = "equip_claymore";
          break;
        case 3:
          equipmentref = "equip_molotov";
          break;
        case 4:
          equipmentref = "equip_semtex";
          break;
        case 5:
          equipmentref = "equip_thermite";
          break;
        case 6:
          equipmentref = "equip_throwing_knife";
          break;
        case 7:
          equipmentref = "equip_throwing_knife_fire";
          break;
        case 10:
          equipmentref = "equip_adrenaline";
          break;
        case 11:
          equipmentref = "equip_concussion";
          break;
        case 12:
          equipmentref = "equip_decoy";
          break;
        case 13:
          equipmentref = "equip_flash";
          break;
        case 14:
          equipmentref = "equip_gas_grenade";
          break;
        case 15:
          equipmentref = "equip_hb_sensor";
          break;
        case 16:
          equipmentref = "equip_smoke";
          break;
        case 17:
          equipmentref = "equip_snapshot_grenade";
          break;
        case 20:
          equipmentref = "equip_armorplate";
          break;
        case 21:
          equipmentref = "equip_binoculars";
          break;
        case 22:
          equipmentref = "equip_bunkerbuster";
          break;
        case 23:
          equipmentref = "equip_shockstick";
          break;
        case 24:
          equipmentref = "equip_c4";
          break;
      }

      if(isDefined(equipmentref)) {
        slot = scripts\mp\equipment::getdefaultslot(equipmentref);
        scripts\mp\equipment::giveequipment(equipmentref, slot);
      }
    }
  }
}

watchchangeweapon() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      dochangeweapon(objweapon);

    self waittill("weapon_change");
  }
}

dochangeweapon(objweapon) {
  logchangeweapon(objweapon);
  updateweaponspeed(objweapon);
  _id_C49A0D832ACE8E5E();
  updatelastweaponobj(objweapon);
  savealtstates();
  updatelauncherusage();
  updateweaponperks();
  updatesniperglint(objweapon);
  _id_0CBB0697DE4C5728::_id_B939BC4F3A6D4FDC(objweapon);
  _id_8A02236BFEED8A54(objweapon);
  scripts\mp\perks\perkfunctions::updatedefaultflinchreduction();
  scripts\mp\events::updateweaponchangetime();
  scripts\mp\class::riotshieldonweaponchange(objweapon);
  scripts\mp\perks\perkfunctions::updateweaponkick();
  thread scripts\cp_mp\gestures::tryreenablescriptablevfx();
  _id_82A0E6138BA06718(objweapon);
}

_id_8A02236BFEED8A54(objweapon) {
  if(istrue(level.disablemount)) {
    return;
  }
  if(_id_DD461671D4007C1F(objweapon)) {
    _id_3B64EB40368C1450::set("scriptedMountDisable", "mount_top", 0);
    _id_3B64EB40368C1450::set("scriptedMountDisable", "mount_side", 0);
    thread _id_5845DD5192F930B7();
  }
}

_id_5845DD5192F930B7() {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("death", "weapon_change");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("scriptedMountDisable");
}

_id_DD461671D4007C1F(objweapon) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);

  if(_id_AB501F397D3CD312 == "iw8_lm_sierrax" && objweapon hasattachment("stocksaw_sierrax"))
    return 1;

  return 0;
}

logchangeweapon(objweapon) {
  if(!istrue(self.canlogchangeweapon)) {
    self.canlogchangeweapon = 1;
    return;
  }

  _id_03549C153A27C9BD = objweapon.basename;
  _id_A39E6237E3F658CA = "none";

  if(!isDefined(_id_03549C153A27C9BD) || _id_03549C153A27C9BD == "none") {
    return;
  }
  if(isDefined(self.lastweaponobj) && objweapon == self.lastweaponobj) {
    return;
  }
  if(self.equippedweapons.size > 1) {
    _id_A39E6237E3F658CA = self.equippedweapons[1].basename;

    if(_id_A39E6237E3F658CA == _id_03549C153A27C9BD)
      _id_A39E6237E3F658CA = self.equippedweapons[0].basename;
  }

  if(isDefined(self.primaryweaponobj))
    self setclientweaponinfo(0, getcompleteweaponname(self.primaryweaponobj));

  if(isDefined(self.secondaryweaponobj))
    self setclientweaponinfo(1, getcompleteweaponname(self.secondaryweaponobj));

  if(getdvarint("dvar_4B12BCEACCF1E3BB", 0) == 1)
    self dlog_recordplayerevent("dlog_event_weapon_change", ["current_weapon", _id_03549C153A27C9BD, "secondary_weapon", _id_A39E6237E3F658CA]);
}

updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

updatesniperglint(objweapon) {
  if(sniperglint_supported(objweapon))
    childthread sniperglint_manage(objweapon);
}

_id_DAEF03172B217E78(objweapon) {
  if(1) {
    _id_1960B715ABE16306 = _id_B3E5F50A0D4A9C86(objweapon);
    _id_A7ADACDB4C7641C9(_id_1960B715ABE16306);
  }
}

updatelauncherusage() {
  weapon = self getcurrentweapon();
  _id_21C8AABCB09F7094 = isDefined(game["inLiveLobby"]);

  if(!_id_21C8AABCB09F7094 && !scripts\mp\flags::gameflag("prematch_done") && scripts\cp_mp\utility\weapon_utility::islockonlauncher(weapon))
    _id_3B64EB40368C1450::set("prematch", "ads", 0);

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon.basename);

  switch (_id_AB501F397D3CD312) {
    default:
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_1D9816060754F796.size; _id_AC0E594AC96AA3A8++) {
        _id_291A052755F9FA82 = level._id_1D9816060754F796[_id_AC0E594AC96AA3A8];
        self[[_id_291A052755F9FA82]](_id_AB501F397D3CD312);
      }

      break;
    case "iw9_la_gromeo":
      thread scripts\mp\missilelauncher::initmissilelauncherusage();
      break;
    case "iw9_la_juliet":
      thread scripts\mp\javelin::javelin_reset();
      break;
    case "iw9_dm_crossbow":
      thread scripts\cp_mp\crossbow::initcrossbowusage();
      break;
    case "iw9_dm_recondartcrossbow":
      thread _id_202D9F0EA7DB3A23::initcrossbowusage();
      break;
  }

  self notify("end_launcher");

  if(scripts\mp\utility\perk::_hasperk("specialty_fastreload_launchers")) {
    _id_589C33F399FE5F5D = weaponclass(weapon.basename) == "rocketlauncher" || weapon.basename == "iw8_la_kgolf_mp";

    if(_id_589C33F399FE5F5D && !istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::removeperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (weapon.basename) {
    default:
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_20B06C3352BAB75E.size; _id_AC0E594AC96AA3A8++) {
        _id_291A052755F9FA82 = level._id_20B06C3352BAB75E[_id_AC0E594AC96AA3A8];
        self[[_id_291A052755F9FA82]](weapon.basename);
      }

      break;
    case "iw9_la_gromeo_mp":
    case "iw8_la_gromeo_mp":
      thread scripts\mp\missilelauncher::missilelauncherusageloop();
      break;
    case "iw9_la_juliet_mp":
    case "iw8_la_juliet_mp":
      thread scripts\mp\javelin::javelinusageloop();
      break;
    case "iw8_sn_crossbow_mp":
    case "iw9_dm_crossbow_mp":
      thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);
      break;
    case "iw9_dm_recondartcrossbow_mp":
      thread _id_202D9F0EA7DB3A23::crossbowusageloop(weapon);
      break;
    case "iw8_sn_xmike109_mp":
      thread scripts\cp_mp\xmike109::usageloop(weapon);
      break;
  }
}

setlastdroppableweaponobj(weaponobj) {
  self.lastdroppableweaponobj = weaponobj;

  if(isDefined(level.lastdroppableweaponchanged))
    self[[level.lastdroppableweaponchanged]]();
}

updatelastweaponobj(_id_82533969B4683DE4) {
  _id_DD9181EB18C4DB69 = _id_82533969B4683DE4 getnoaltweapon();

  if(isnullweapon(_id_DD9181EB18C4DB69))
    _id_DD9181EB18C4DB69 = _id_82533969B4683DE4;

  self.lastweaponobj = _id_82533969B4683DE4;

  if(isnormallastweapon(_id_82533969B4683DE4))
    self.lastnormalweaponobj = _id_82533969B4683DE4;

  if(isdroppableweapon(_id_DD9181EB18C4DB69))
    setlastdroppableweaponobj(_id_DD9181EB18C4DB69);

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(_id_82533969B4683DE4))
    self.lastcacweaponobj = _id_82533969B4683DE4;
}

updateweaponspeed(_id_82533969B4683DE4) {
  _id_9085D7F0321EA2A4(_id_82533969B4683DE4);

  if(_id_82533969B4683DE4.basename == "none")
    return;
  else if(scripts\mp\utility\weapon::issuperweapon(_id_82533969B4683DE4.basename)) {
    updatemovespeedscale();
    return;
  } else if(_id_2669878CF5A1B6BC::iskillstreakweapon(_id_82533969B4683DE4.basename)) {
    updatemovespeedscale();
    return;
  } else if(_id_82533969B4683DE4.basename == "iw9_me_fists_mp_ls") {
    updatemovespeedscale();
    return;
  } else if(_id_82533969B4683DE4.inventorytype != "primary" && _id_82533969B4683DE4.inventorytype != "altmode") {
    return;
  }
  updatemovespeedscale();
}

_id_9085D7F0321EA2A4(objweapon) {
  _id_DE17420C437B06B3 = 1;

  if(scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename))
    _id_DE17420C437B06B3 = 0;

  _id_3B64EB40368C1450::set("weaponJogState", "jog", _id_DE17420C437B06B3);
}

_id_C49A0D832ACE8E5E() {
  if(isDefined(self.lastweaponobj)) {
    weaponname = self.lastweaponobj.basename;
    _id_33802B6339AD8B00 = getsubstr(weaponname, 0, 3);

    if(_id_33802B6339AD8B00 == "iw8" || _id_33802B6339AD8B00 == "s4_")
      weaponname = _id_2669878CF5A1B6BC::getweaponrootname(self.lastweaponobj);

    currenttime = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime()) / 1000;

    if(!isDefined(self.pers["currentWeaponStartTime"]))
      self.pers["currentWeaponStartTime"] = 0;

    totaltime = currenttime - self.pers["currentWeaponStartTime"];
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.weaponname = weaponname;
    _id_7E2C53B0BCF117D9.fullweaponname = getcompleteweaponname(self.lastweaponobj);
    _id_7E2C53B0BCF117D9._id_629757F5C9E770D8 = "timeUsed";
    _id_7E2C53B0BCF117D9._id_A1D4E7D5EF9DA660 = totaltime;
    _id_7E2C53B0BCF117D9.variantid = getweaponvariantindex(self.lastweaponobj);
    _id_7E2C53B0BCF117D9.weaponobj = self.lastweaponobj;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_update_weapon_stats", _id_7E2C53B0BCF117D9);
    self.pers["currentWeaponStartTime"] = currenttime;
  }
}

onplayerspawned() {
  scripts\mp\gamelogic::sethasdonecombat(self, 0);

  if(!isDefined(self.trackingweapon))
    scripts\mp\persistence::persclear_stats();

  if(!isDefined(self.plantedlethalequip))
    self.plantedlethalequip = [];

  if(!isDefined(self.plantedtacticalequip))
    self.plantedtacticalequip = [];

  if(!isDefined(self.plantedsuperequip))
    self.plantedsuperequip = [];

  if(!isDefined(self.plantedhackedequip))
    self.plantedhackedequip = [];

  self.prevweaponobj = undefined;
  thread watchchangeweapon();
  thread watchweaponusage();
  thread watchgrenadeusage();
  thread watchequipmentonspawn();

  if(scripts\mp\utility\game::onlinestatsenabled())
    thread watchfornearmisswhizby();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread watchdropweapons();

  self.lasthittime = [];
  self.droppeddeathweapon = undefined;
  self.tookweaponfrom = [];
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  setlastdroppableweaponobj(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon()));
  scripts\mp\gamescore::initassisttrackers();
  _id_B029006BEFA9CF56 = getweaponcamoname(self getcurrentweapon());
  thread runcamoscripts(_id_B029006BEFA9CF56);
}

savealtstates() {
  self.pers["altStates"] = [];
  weapons = self.primaryinventory;

  foreach(objweapon in weapons) {
    if(!isundefinedweapon(self.primaryweaponobj) && objweapon == self.primaryweaponobj || !isundefinedweapon(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      if(shouldweaponsavealtstate(objweapon) && self isalternatemode(objweapon, 1)) {
        _id_366B0ECC2F28AEAD = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);
        self.pers["altStates"][_id_366B0ECC2F28AEAD] = 1;
      }
    }
  }
}

savetogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  weapons = self.primaryinventory;

  foreach(objweapon in weapons) {
    if(!isundefinedweapon(self.primaryweaponobj) && objweapon == self.primaryweaponobj || !isundefinedweapon(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      if(isDefined(objweapon.scope) && istogglescope(objweapon, objweapon.scope)) {
        _id_366B0ECC2F28AEAD = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);
        self.pers["toggleScopeStates"][_id_366B0ECC2F28AEAD] = self gethybridscopestate(objweapon);
      }
    }
  }
}

updatetogglescopestate(objweapon) {
  _id_366B0ECC2F28AEAD = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);

  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][_id_366B0ECC2F28AEAD]))
    self sethybridscopestate(objweapon, self.pers["toggleScopeStates"][_id_366B0ECC2F28AEAD]);
  else if(_id_DAB7BC436F0B0BDE(objweapon))
    self sethybridscopestate(objweapon, 1);
}

_id_DAB7BC436F0B0BDE(objweapon) {
  if(isDefined(objweapon.scope) && (objweapon.scope == "hybrid03" || objweapon.scope == "hybridtherm01" || objweapon.scope == "hybridrange01"))
    return 1;

  return 0;
}

updatesavedaltstate(objweapon) {
  if(isDefined(self.pers["altStates"]) && istrue(objweapon.hasalternate)) {
    _id_366B0ECC2F28AEAD = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(objweapon);

    if(isDefined(self.pers["altStates"][_id_366B0ECC2F28AEAD]) && self.pers["altStates"][_id_366B0ECC2F28AEAD])
      objweapon = objweapon getaltweapon();
  }

  return objweapon;
}

istogglescope(weapon, attachment) {
  if(!isDefined(attachment))
    return 0;

  _id_1439F86640D42E34 = _func_7C612AC92BA98DCB(weapon, attachment);
  return _id_1439F86640D42E34 == "hybrid";
}

shouldweaponsavealtstate(objweapon) {
  if(istrue(objweapon.hasalternate)) {
    if(shouldattachmentsavealtstate(objweapon, objweapon.underbarrel))
      return 1;
  }

  return 0;
}

shouldattachmentsavealtstate(objweapon, _id_ACD3280C3E566807) {
  return isattachmentselectfire(objweapon, _id_ACD3280C3E566807);
}

isattachmentselectfire(weapon, attachment) {
  _id_1439F86640D42E34 = _func_7C612AC92BA98DCB(weapon, attachment);
  return _id_1439F86640D42E34 == "selectfire";
}

isattachmentgrenadelauncher(_id_ACD3280C3E566807) {
  return 0;
}

weaponperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj) {
  if(!isundefinedweapon(prevweaponobj)) {
    _id_9586602EBC60B765 = _id_2669878CF5A1B6BC::getweaponrootname(prevweaponobj.basename);
    _id_B46BA6B5339521F1 = scripts\mp\utility\weapon::weaponperkmap(_id_9586602EBC60B765);

    if(isDefined(_id_B46BA6B5339521F1))
      _id_EC132C173D4532EE(_id_B46BA6B5339521F1);
  }

  if(!isundefinedweapon(_id_4DA99B8AAFF6E52A)) {
    _id_98EFD9D21DA41D1A = _id_2669878CF5A1B6BC::getweaponrootname(_id_4DA99B8AAFF6E52A.basename);
    _id_CA1CCAC233079978 = scripts\mp\utility\weapon::weaponperkmap(_id_98EFD9D21DA41D1A);

    if(isDefined(_id_CA1CCAC233079978))
      _id_DD1698252C31D637(_id_CA1CCAC233079978);
  }
}

weaponattachmentperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj) {
  _id_503110DC18B08AB9 = undefined;
  _id_88C1658D6B22A174 = undefined;

  if(!isundefinedweapon(prevweaponobj)) {
    _id_88C1658D6B22A174 = getweaponattachments(prevweaponobj);

    if(isDefined(_id_88C1658D6B22A174) && _id_88C1658D6B22A174.size > 0) {
      foreach(_id_4B974A0C3AE8192B in _id_88C1658D6B22A174) {
        perks = _id_2669878CF5A1B6BC::attachmentperkmap(prevweaponobj, _id_4B974A0C3AE8192B);

        if(!isDefined(perks)) {
          continue;
        }
        foreach(perk in perks)
        _id_EC132C173D4532EE(perk);
      }
    }
  }

  if(!isundefinedweapon(_id_4DA99B8AAFF6E52A)) {
    _id_503110DC18B08AB9 = getweaponattachments(_id_4DA99B8AAFF6E52A);

    if(isDefined(_id_503110DC18B08AB9) && _id_503110DC18B08AB9.size > 0) {
      foreach(_id_8EC829625D9FFE8C in _id_503110DC18B08AB9) {
        perks = _id_2669878CF5A1B6BC::attachmentperkmap(_id_4DA99B8AAFF6E52A, _id_8EC829625D9FFE8C);

        if(!isDefined(perks)) {
          continue;
        }
        foreach(perk in perks)
        _id_DD1698252C31D637(perk);
      }
    }
  }
}

doweaponperkupdate(prevweaponobj) {
  _id_4DA99B8AAFF6E52A = self getcurrentweapon();
  weaponattachmentperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj);
  weaponperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj);
  return _id_4DA99B8AAFF6E52A;
}

watchweaponperkupdates() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  prevweaponobj = undefined;

  for(;;) {
    prevweaponobj = doweaponperkupdate(prevweaponobj);
    self waittill("weapon_change");
  }
}

_id_A7ADACDB4C7641C9(_id_89B8F50D9A20F2AB) {
  if(_id_89B8F50D9A20F2AB)
    self _meth_5762CF97C6F1A2C1("first_person");
  else
    self _meth_5762CF97C6F1A2C1("third_person");
}

sniperglint_supported(weapon) {
  if(isnullweapon(weapon) || !isDefined(weapon.scope) || weaponclass(weapon) == "rocketlauncher")
    return 0;

  class = weaponclass(weapon);

  if(self isalternatemode(weapon) && (class == "grenade" || class == "spread"))
    return 0;

  return _id_CB81EB90DDC79AB7();
}

_id_CB81EB90DDC79AB7() {
  if(scripts\mp\utility\perk::_hasperk("specialty_glintxsml") || scripts\mp\utility\perk::_hasperk("specialty_glintsml") || scripts\mp\utility\perk::_hasperk("specialty_glintmed") || scripts\mp\utility\perk::_hasperk("specialty_glintlrg") || scripts\mp\utility\perk::_hasperk("specialty_glintxlrg"))
    return 1;

  return 0;
}

_id_B3E5F50A0D4A9C86(weapon) {
  if(isnullweapon(weapon) || !isDefined(weapon.scope))
    return 0;

  if(issubstr(weapon.scope, "snprscope") || issubstr(weapon.scope, "vzscope") || issubstr(weapon.scope, "thermal"))
    return 1;

  return 0;
}

sniperglint_manage(objweapon) {
  self notify("manageSniperGlint");
  self endon("manageSniperGlint");
  self endon("weapon_change");
  waitframe();
  thread sniperglint_cleanup();
  self.glinton = 0;
  istogglescope = istogglescope(objweapon, objweapon.scope);

  for(;;) {
    if(self playerads() > 0.5 && self hasweapon(objweapon) && !(istogglescope && self gethybridscopestate(objweapon))) {
      if(!self.glinton)
        sniperglint_add();
    } else if(self.glinton)
      sniperglint_remove();

    waitframe();
  }
}

sniperglint_cleanup() {
  scripts\engine\utility::waittill_any_2("death_or_disconnect", "weapon_change");

  if(isDefined(self.glinton) && self.glinton) {
    sniperglint_remove();
    self.glinton = undefined;
  }
}

sniperglint_add() {
  if(scripts\mp\utility\perk::_hasperk("specialty_glintxsml"))
    self setscriptablepartstate("sniperGlint", "sniperGlintXsml", 0);
  else if(scripts\mp\utility\perk::_hasperk("specialty_glintsml"))
    self setscriptablepartstate("sniperGlint", "sniperGlintSml", 0);
  else if(scripts\mp\utility\perk::_hasperk("specialty_glintmed"))
    self setscriptablepartstate("sniperGlint", "sniperGlintMed", 0);
  else if(scripts\mp\utility\perk::_hasperk("specialty_glintlrg"))
    self setscriptablepartstate("sniperGlint", "sniperGlintLrg", 0);
  else if(scripts\mp\utility\perk::_hasperk("specialty_glintxlrg"))
    self setscriptablepartstate("sniperGlint", "sniperGlintXlrg", 0);

  self.glinton = 1;
}

sniperglint_remove() {
  if(isDefined(self)) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOff", 0);
    self.glinton = 0;
  }
}

sniperadsblur(weapon) {
  self endon("weapon_change");
  self.sniperblur = 0;

  for(;;) {
    if(self playerads() > 0.65 && !self.sniperblur)
      thread sniperadsblur_execute(weapon);
    else if(self playerads() <= 0.65)
      sniperadsblur_remove();

    waitframe();
  }
}

sniperadsblur_execute(weapon) {
  self notify("sniperBlurReset");
  self endon("sniperBlurReset");
  self.sniperblur = 1;
  self setblurforplayer(25, 0.1);
  wait 0.1;
  self setblurforplayer(0, getsniperadsblurtime(weapon));
}

sniperadsblur_remove() {
  self notify("sniperBlurReset");
  self setblurforplayer(0, 0);
  self.sniperblur = 0;
}

getsniperadsblurtime(weapon) {
  _id_6159317EB912F3E5 = 0.3;

  switch (weapon.basename) {
    case "iw8_sn_kilo98_mp":
      _id_6159317EB912F3E5 = 0.18;
      break;
    case "iw8_sn_mike14_mp":
      _id_6159317EB912F3E5 = 0.12;
      break;
    case "iw8_sn_sbeta_mp":
      _id_6159317EB912F3E5 = 0.12;
      break;
  }

  return _id_6159317EB912F3E5;
}

watchsniperboltactionkills() {
  self endon("death_or_disconnect");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["recoilReduceKills"]))
    self.pers["recoilReduceKills"] = 0;

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  for(;;) {
    self waittill("got_a_kill", victim, sweapon, meansofdeath);
    weapon = makeweaponfromstring(sweapon);

    if(isrecoilreducingweapon(weapon)) {
      kills = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(kills, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(kills <= 4)
        stancerecoilupdate(self getstance());
    }
  }
}

watchsniperboltactionkills_ondeath() {
  self notify("watchSniperBoltActionKills_onDeath");
  self endon("watchSniperBoltActionKills_onDeath");
  self endon("disconnect");
  self waittill("death");
  self.pers["recoilReduceKills"] = 0;
}

isrecoilreducingweapon(weapon) {
  return 0;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"]))
    self.pers["recoilReduceKills"] = 0;

  return self.pers["recoilReduceKills"] * 3;
}

ishackweapon(weapon) {
  if(weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp")
    return 1;

  if(weapon == "briefcase_bomb_mp")
    return 1;

  return 0;
}

isfistweapon(weapon) {
  weapon = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  return weapon == "iw9_me_fists";
}

isbombplantweapon(weapon) {
  return weapon == "briefcase_bomb_mp" || weapon == "briefcase_bomb_defuse_mp" || weapon == "briefcase_silent_mp" || weapon == "briefcase_defuse_silent_mp" || weapon == "briefcase_bomb_mp_nuke";
}

dropweaponfordeath(attacker, smeansofdeath, weaponoverride, damage) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  if(isDefined(attacker) && attacker == self || smeansofdeath == "MOD_SUICIDE") {
    return;
  }
  objweapon = self.lastdroppableweaponobj;

  if(isDefined(weaponoverride))
    objweapon = weaponoverride;

  if(!isDefined(objweapon)) {
    return;
  }
  if(objweapon.basename == "none") {
    return;
  }
  if(!self hasweapon(objweapon)) {
    return;
  }
  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](objweapon)) {
    return;
  }
  objweapon = objweapon getnoaltweapon();
  _id_E44EE9F7066F4D05 = 0;
  _id_E44EFBF7066F749B = 0;
  stockammo = 0;

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon)) {
      return;
    }
    _id_E44EE9F7066F4D05 = self getweaponammoclip(objweapon, "right");
    _id_E44EFBF7066F749B = self getweaponammoclip(objweapon, "left");

    if(!_id_E44EE9F7066F4D05 && !_id_E44EFBF7066F749B) {
      return;
    }
    stockammo = self getweaponammostock(objweapon);
    _id_CBC510A5CFA3D48D = weaponmaxammo(objweapon);

    if(stockammo > _id_CBC510A5CFA3D48D)
      stockammo = _id_CBC510A5CFA3D48D;

    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }
    if(istrue(level.clearstockondrop))
      stockammo = 0;

    item itemweaponsetammo(_id_E44EE9F7066F4D05, stockammo, _id_E44EFBF7066F749B);
    _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);

    if(smeansofdeath != "MOD_EXECUTION")
      thread scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(item, _id_CF4209C200F8BBF4, damage, self.angles);
  } else {
    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }
    item itemweaponsetammo(1, 1, 0);
  }

  item sethintdisplayrange(96);
  item setuserange(96);
  self.droppeddeathweapon = 1;
  item.owner = self;
  item.targetname = "dropped_weapon";
  item.objweapon = objweapon;
  item thread watchpickup(self);
  item thread deletepickupafterawhile();
  item thread _id_EA90A9BB06631B2B(self);
  item thread _id_AEABBB3B58E1D822(self);
}

_id_EA90A9BB06631B2B(player) {
  if(!isDefined(player)) {
    return;
  }
  if(!scripts\mp\utility\game::isteamreviveenabled()) {
    return;
  }
  self endon("death");
  player endon("disconnect");
  wait 2;
  distsq = distance2dsquared(player.origin, self.origin);
  _id_BE2072900A2685DA = level._id_34777CC7C85EDBE6;

  if(distsq < _id_BE2072900A2685DA * _id_BE2072900A2685DA)
    _id_3C4A286CB4CF549E(self);
}

forcedropweapon(weaponoverride) {
  if(isDefined(level.blockweapondrops))
    return 0;

  if(isDefined(self.droppeddeathweapon))
    return 0;

  objweapon = self.lastdroppableweaponobj;

  if(isDefined(weaponoverride))
    objweapon = weaponoverride;

  if(!isDefined(objweapon))
    return 0;

  if(objweapon.basename == "none")
    return 0;

  if(!self hasweapon(objweapon))
    return -1;

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](objweapon))
    return 0;

  objweapon = objweapon getnoaltweapon();
  _id_E44EE9F7066F4D05 = 0;
  _id_E44EFBF7066F749B = 0;
  stockammo = 0;

  if(!scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon))
      return 0;

    _id_E44EE9F7066F4D05 = self getweaponammoclip(objweapon, "right");
    _id_E44EFBF7066F749B = self getweaponammoclip(objweapon, "left");

    if(!_id_E44EE9F7066F4D05 && !_id_E44EFBF7066F749B)
      return 0;

    stockammo = self getweaponammostock(objweapon);
    _id_CBC510A5CFA3D48D = weaponmaxammo(objweapon);

    if(stockammo > _id_CBC510A5CFA3D48D)
      stockammo = _id_CBC510A5CFA3D48D;

    item = self dropitem(objweapon);

    if(!isDefined(item))
      return 0;

    if(istrue(level.clearstockondrop))
      stockammo = 0;

    item itemweaponsetammo(_id_E44EE9F7066F4D05, stockammo, _id_E44EFBF7066F749B);
  } else {
    item = self dropitem(objweapon);

    if(!isDefined(item))
      return 0;

    item itemweaponsetammo(1, 1, 0);
  }

  item sethintdisplayrange(96);
  item setuserange(96);
  item.owner = self;
  item.targetname = "dropped_weapon";
  item.objweapon = objweapon;
  item thread watchpickup(self);
  item thread deletepickupafterawhile();
  return 1;
}

detachifattached(model, _id_A666A0C4297F3F54) {
  _id_076651B5D03AD861 = self getattachsize();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++) {
    attach = self getattachmodelname(_id_AC0E594AC96AA3A8);

    if(attach != model) {
      continue;
    }
    tag = self getattachtagname(_id_AC0E594AC96AA3A8);
    self detach(model, tag);

    if(tag != _id_A666A0C4297F3F54) {
      _id_076651B5D03AD861 = self getattachsize();

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_076651B5D03AD861; _id_AC0E594AC96AA3A8++) {
        tag = self getattachtagname(_id_AC0E594AC96AA3A8);

        if(tag != _id_A666A0C4297F3F54) {
          continue;
        }
        model = self getattachmodelname(_id_AC0E594AC96AA3A8);
        self detach(model, tag);
        break;
      }
    }

    return 1;
  }

  return 0;
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;
  _id_3C4A286CB4CF549E(self);
}

_id_AEABBB3B58E1D822(player) {
  self endon("death");
  player endon("death_or_disconnect");
  player waittill("trigger_removed");
  _id_3C4A286CB4CF549E(self);
}

_id_3C4A286CB4CF549E(pickup) {
  if(!isDefined(pickup)) {
    return;
  }
  pickup notify("weapon_pickup_cancelled");
  pickup delete();
}

getitemweaponname() {
  classname = self.classname;
  _id_C27E2A04BAB78C1F = getsubstr(classname, 7);
  return _id_C27E2A04BAB78C1F;
}

watchpickup(_id_2CA201D5906CDBA5) {
  self endon("weapon_pickup_cancelled");
  _id_3F6103D9666B07CC = self.owner;
  weaponobj = self.objweapon;
  level.onweapondropcreated scripts\cp_mp\utility\callback_group::callback_trigger(self, _id_2CA201D5906CDBA5, weaponobj);
  _id_C27E2A04BAB78C1F = getitemweaponname();

  for(;;) {
    self waittill("trigger", player, _id_76F4143215683892);
    _id_17372FFC28DC7D78 = undefined;
    _id_70582DA4FF904336 = isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier) && level.cyberemp.carrier == player;
    _id_280079773A9459A5 = scripts\mp\utility\game::getgametype() == "cyber" && (isDefined(_id_76F4143215683892) || _id_70582DA4FF904336) && istrue(level._id_AE278016E96E91F8);

    if(_id_280079773A9459A5) {
      weapons = player scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

      if(weapons.size > 2) {
        _id_66C1BF2EADF04D65 = 0;
        _id_04819A5499215519 = 0;
        _id_FC41E0BC6C702A3A = 0;
        _id_964B30D2F3CDEDC4 = 0;
        _id_5B70A9307F104360 = 0;

        foreach(weapon in weapons) {
          if(weapon.basename == "iw9_cyberemp_mp")
            _id_66C1BF2EADF04D65 = 1;

          if(scripts\mp\utility\weapon::ismeleeoverrideweapon(weapon))
            _id_04819A5499215519 = 1;

          if(scripts\mp\utility\weapon::_id_0D3C77884D93D850(weapon))
            _id_FC41E0BC6C702A3A = 1;

          if(scripts\mp\utility\weapon::_id_3F15E5E526FF94CE(weapon))
            _id_964B30D2F3CDEDC4 = 1;

          if(weapon.basename == "iw8_lm_dblmg_mp")
            _id_5B70A9307F104360 = 1;
        }

        if(isDefined(player.primaryweapon) && player.primaryweapon != "iw9_cyberemp_mp")
          _id_17372FFC28DC7D78 = player.primaryweaponobj;
        else if(isDefined(player.secondaryweapon) && player.secondaryweapon != "iw9_cyberemp_mp")
          _id_17372FFC28DC7D78 = player.secondaryweaponobj;

        _id_BFBB389447A5262C = weapons.size;

        if(_id_04819A5499215519)
          _id_BFBB389447A5262C--;

        if(_id_5B70A9307F104360)
          _id_BFBB389447A5262C--;

        if(_id_FC41E0BC6C702A3A)
          _id_BFBB389447A5262C--;

        if(_id_964B30D2F3CDEDC4)
          _id_BFBB389447A5262C--;

        if(!_id_66C1BF2EADF04D65 || _id_BFBB389447A5262C > 3) {
          _id_AE8C4B58168DA1A2 = undefined;

          if(_id_17372FFC28DC7D78.basename != "none")
            _id_AE8C4B58168DA1A2 = _id_17372FFC28DC7D78;

          result = player forcedropweapon(_id_AE8C4B58168DA1A2);

          if(_id_70582DA4FF904336) {
            player _id_3B64EB40368C1450::set("cyber_emp", "weapon_switch", 0);
            player _id_3B64EB40368C1450::set("cyber_emp", "weapon_pickup", 0);
            player _id_3B64EB40368C1450::set("cyber_emp", "usability", 0);
            player thread waitthengivecyberweapon(result == 0);
          }

          if(result == 1) {} else if(result == 0) {
            player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cyber_emp");
            return;
          } else if(result == -1) {}
        }
      } else if(_id_70582DA4FF904336) {
        player _id_3B64EB40368C1450::set("cyber_emp", "weapon_switch", 0);
        player _id_3B64EB40368C1450::set("cyber_emp", "weapon_pickup", 0);
        player _id_3B64EB40368C1450::set("cyber_emp", "usability", 0);
        player thread waitthengivecyberweapon();
      } else if(isDefined(_id_76F4143215683892))
        _id_17372FFC28DC7D78 = player.lastdroppableweaponobj;
      else
        _id_17372FFC28DC7D78 = player getcurrentweapon();
    } else if(isDefined(_id_76F4143215683892))
      _id_17372FFC28DC7D78 = player.lastdroppableweaponobj;
    else
      _id_17372FFC28DC7D78 = player getcurrentweapon();

    _id_FEE12400D8814B47 = player scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons") && getdvarint("perk_graverobber_enabled") == 1;
    player thread watchpickupcomplete(weaponobj, _id_17372FFC28DC7D78, _id_FEE12400D8814B47);
    level.onweapondroppickedup scripts\cp_mp\utility\callback_group::callback_trigger(self, player, weaponobj);
    player notify("weapon_pickup", weaponobj, _id_76F4143215683892);

    if(isDefined(_id_76F4143215683892)) {
      player.lastweaponpickuptime = gettime();
      player scripts\mp\utility\stats::incpersstat("weaponPickups", 1);
    }

    dirty = fixupplayerweapons(player, _id_C27E2A04BAB78C1F);

    if(isDefined(_id_76F4143215683892) && _id_FEE12400D8814B47)
      _id_76F4143215683892 delete();

    if(isDefined(_id_76F4143215683892) || dirty) {
      break;
    }
  }

  if(isDefined(_id_76F4143215683892)) {
    _id_66DA0A5F69E8DD56 = _id_76F4143215683892 getitemweaponname();
    objweapon = makeweaponfromstring(_id_66DA0A5F69E8DD56);

    if(isDefined(player.tookweaponfrom[_id_66DA0A5F69E8DD56])) {
      _id_76F4143215683892.owner = player.tookweaponfrom[_id_66DA0A5F69E8DD56];
      player.tookweaponfrom[_id_66DA0A5F69E8DD56] = undefined;
    } else
      _id_76F4143215683892.owner = player;

    _id_76F4143215683892.objweapon = objweapon;
    _id_76F4143215683892.targetname = "dropped_weapon";
    _id_76F4143215683892 thread watchpickup(player);
  }

  player.tookweaponfrom[_id_C27E2A04BAB78C1F] = _id_3F6103D9666B07CC;
}

waitthengivecyberweapon(_id_8A5ABCCE61604B23) {
  self endon("death_or_disconnect");
  self notify("cancelGiveEmp");
  self endon("cancelGiveEmp");

  while(isDefined(self.currentweapon.basename) && self.currentweapon.basename == "none")
    waitframe();

  scripts\cp_mp\utility\inventory_utility::_giveweapon("iw9_cyberemp_mp");

  if(!istrue(_id_8A5ABCCE61604B23))
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cyber_emp");
}

watchpickupcomplete(_id_F42F309550E65575, _id_17372FFC28DC7D78, _id_FEE12400D8814B47) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  startingweapon = self.currentweapon;
  success = 0;

  if(startingweapon == _id_F42F309550E65575)
    success = 1;
  else {
    for(;;) {
      waitframe();
      currentweapon = self.currentweapon;

      if(issameweapon(startingweapon, currentweapon, 0)) {
        continue;
      }
      if(issameweapon(_id_F42F309550E65575, currentweapon, 0))
        success = 1;
      else
        success = 0;

      break;
    }
  }

  if(success) {
    if(_id_2669878CF5A1B6BC::isminigunweapon(_id_F42F309550E65575))
      scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(_id_F42F309550E65575, _id_17372FFC28DC7D78);

    thread notifyuiofpickedupweapon();

    if(isDefined(level.onweapontaken))
      [[level.onweapontaken]](_id_F42F309550E65575);
  }
}

getrandomgraverobberattachment(currentweapon, _id_79583F5B5010A954) {
  return undefined;
}

addattachmenttoweapon(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10) {
  variantid = getweaponvariantindex(_id_DD515FCF025B2E79);
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 getnoaltweapon();
  _id_91BBF8D2294A656E = _id_DD515FCF025B2E79.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in _id_91BBF8D2294A656E)
  attachments[attachments.size] = attachment;

  failed = 0;

  if(scripts\engine\utility::array_contains(attachments, _id_EFFB4AE1788A8B10))
    failed = 1;
  else if(!_id_DD515FCF025B2E79 canuseattachment(_id_EFFB4AE1788A8B10))
    failed = 1;

  if(failed)
    return undefined;

  attachments = scripts\mp\utility\weapon::weaponattachremoveextraattachments(attachments, _id_DD515FCF025B2E79);
  _id_7809AD191E44FE6A = [];

  foreach(_id_FE8F7703F6313ED4, attachment in attachments)
  _id_7809AD191E44FE6A[_id_FE8F7703F6313ED4] = _id_91BBF8D2294A656E[attachment];

  attachments[attachments.size] = _id_EFFB4AE1788A8B10;
  _id_7809AD191E44FE6A[_id_7809AD191E44FE6A.size] = 0;
  camo = _id_DD515FCF025B2E79.camo;
  stickers = [];

  if(isDefined(_id_DD515FCF025B2E79.stickerslot0))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot0;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot1))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot1;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot2))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot2;

  if(isDefined(_id_DD515FCF025B2E79.stickerslot3))
    stickers[stickers.size] = _id_DD515FCF025B2E79.stickerslot3;

  if(isDefined(_id_DD515FCF025B2E79._id_B39AC546CC8621F8))
    stickers[stickers.size] = _id_DD515FCF025B2E79._id_B39AC546CC8621F8;

  _id_11A1FA68AEB971C0 = scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4();
  _id_C1F45BF103F82583 = _func_4ADD228B999C26AA(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10);

  foreach(_id_FE8F7703F6313ED4, a in attachments) {
    _id_E571ECDD21DDCEE6 = _func_4ADD228B999C26AA(_id_DD515FCF025B2E79, attachments[_id_FE8F7703F6313ED4]);

    if(_id_C1F45BF103F82583 == _id_E571ECDD21DDCEE6 && _id_C1F45BF103F82583 != "other")
      attachments[_id_FE8F7703F6313ED4] = _id_EFFB4AE1788A8B10;
  }

  _id_DD515FCF025B2E79 = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79), attachments, camo, "none", variantid, _id_7809AD191E44FE6A, undefined, stickers, _id_11A1FA68AEB971C0);
  return _id_DD515FCF025B2E79;
}

_id_71DC088DC384EF8D(weaponname, _id_C8616C37BC30098B, _id_A4D5E0F6B90DF7EB) {
  _id_72672CD81EC1093D = weaponname;
  _id_66B3DB972AC1531E = undefined;

  if(!isweapon(weaponname))
    _id_72672CD81EC1093D = makeweapon(weaponname);

  attachments = _id_8DF87E6B1D13C15A(_id_72672CD81EC1093D, _id_C8616C37BC30098B, _id_A4D5E0F6B90DF7EB);

  foreach(attachment in attachments) {
    _id_66B3DB972AC1531E = addattachmenttoweapon(_id_72672CD81EC1093D, attachment);

    if(isDefined(_id_66B3DB972AC1531E))
      _id_72672CD81EC1093D = _id_66B3DB972AC1531E;
  }

  return _id_72672CD81EC1093D;
}

_id_8DF87E6B1D13C15A(weaponobj, _id_C8616C37BC30098B, _id_A4D5E0F6B90DF7EB, _id_2BA199C424905FB6, minpriority) {
  _id_D7CB31EA2A8B6E87 = [];
  _id_738063F99716D177 = _id_2669878CF5A1B6BC::_id_C471A035D22DF5EB();

  if(isDefined(_id_2BA199C424905FB6)) {
    foreach(slot in _id_2BA199C424905FB6) {
      if(scripts\engine\utility::array_contains(_id_738063F99716D177, slot))
        _id_738063F99716D177 = scripts\engine\utility::array_remove(_id_738063F99716D177, slot);
    }
  }

  _id_738063F99716D177 = scripts\engine\utility::array_randomize(_id_738063F99716D177);

  foreach(_id_BF0CC21ADE72123C in _id_738063F99716D177) {
    if(istrue(_id_A4D5E0F6B90DF7EB) && _id_BF0CC21ADE72123C == "scope") {
      continue;
    }
    _id_39ACC07A4F70F5CA = _func_75B035199842693D(weaponobj, _id_BF0CC21ADE72123C);

    if(_id_39ACC07A4F70F5CA.size > 0 && _id_D7CB31EA2A8B6E87.size < _id_C8616C37BC30098B) {
      if(isDefined(minpriority)) {
        _id_E4D2B96BEF75B948 = getcompleteweaponname(weaponobj);
        _id_6121D10DF35555A6 = [];

        foreach(attachment in _id_39ACC07A4F70F5CA) {
          _id_F875C9E7727E3228 = _func_1DD1F56BC3D72B7E(_id_E4D2B96BEF75B948, attachment);

          if(_id_F875C9E7727E3228 < minpriority) {
            continue;
          }
          _id_6121D10DF35555A6[_id_6121D10DF35555A6.size] = attachment;
        }

        _id_39ACC07A4F70F5CA = _id_6121D10DF35555A6;
      }

      if(_id_39ACC07A4F70F5CA.size > 0) {
        _id_109EBF347B2F2ECE = randomint(_id_39ACC07A4F70F5CA.size);
        _id_D7CB31EA2A8B6E87 = scripts\engine\utility::array_add(_id_D7CB31EA2A8B6E87, _id_39ACC07A4F70F5CA[_id_109EBF347B2F2ECE]);
      }
    }

    if(_id_D7CB31EA2A8B6E87.size >= _id_C8616C37BC30098B) {
      break;
    }
  }

  if(istrue(_id_A4D5E0F6B90DF7EB)) {
    _id_CBDD60DFEE68493D = _func_75B035199842693D(weaponobj, "scope");

    if(_id_CBDD60DFEE68493D.size > 0) {
      _id_109EBF347B2F2ECE = randomint(_id_CBDD60DFEE68493D.size);
      _id_D7CB31EA2A8B6E87 = scripts\engine\utility::array_add(_id_D7CB31EA2A8B6E87, _id_CBDD60DFEE68493D[_id_109EBF347B2F2ECE]);

      if(_id_D7CB31EA2A8B6E87.size > _id_C8616C37BC30098B)
        _id_D7CB31EA2A8B6E87 = scripts\engine\utility::array_remove_index(_id_D7CB31EA2A8B6E87, 0);
    }
  }

  return _id_D7CB31EA2A8B6E87;
}

getammooverride(weaponobj) {
  baseweapon = weaponobj getbaseweapon();
  _id_A7CF832E6613FC43 = weaponclipsize(baseweapon);
  _id_2BE3302E3767CC7D = weaponclipsize(weaponobj);
  clipsize = _id_A7CF832E6613FC43;

  if(_func_F30A6D3194F97C09(weaponobj, "specialty_smags"))
    clipsize = int(max(_id_A7CF832E6613FC43, _id_2BE3302E3767CC7D));

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  _id_6C79B6B69A253E2B = 30;

  if(weaponobj.isalternate) {} else {
    switch (weaponobj.classname) {
      case "spread":
        switch (_id_AB501F397D3CD312) {
          case "iw8_sh_charlie725":
            _id_6C79B6B69A253E2B = 6;
            break;
          case "iw8_sh_dpapa12":
            _id_6C79B6B69A253E2B = 8;
            break;
          default:
            _id_6C79B6B69A253E2B = int(min(clipsize, 30));
            break;
        }

        break;
      case "sniper":
        switch (_id_AB501F397D3CD312) {
          case "iw9_dm_crossbow":
            _id_6C79B6B69A253E2B = 3;
            break;
          default:
            _id_6C79B6B69A253E2B = int(min(clipsize, 30));
            break;
        }

        break;
      default:
        _id_6C79B6B69A253E2B = int(min(clipsize, 30));
    }
  }

  return _id_6C79B6B69A253E2B;
}

isgraverobberattachment(weapon, _id_55F8624E7216D9AA) {
  if(!scripts\mp\utility\weapon::attachmentisselectable(weapon, _id_55F8624E7216D9AA))
    return 0;

  switch (_id_55F8624E7216D9AA) {
    case "laserbalanced":
    case "laserrange":
    case "akimbo":
      return 0;
  }

  if(issubstr(_id_55F8624E7216D9AA, "thermal"))
    return 0;

  if(issubstr(_id_55F8624E7216D9AA, "burst"))
    return 0;

  if(getsubstr(_id_55F8624E7216D9AA, 0, 3) == "cal")
    return 0;

  return 1;
}

notifyuiofpickedupweapon() {}

fixupplayerweapons(player, weapon) {
  _id_E3B59C80BF16DE8C = player getweaponslistprimaries();
  _id_45005959354D69FF = 1;
  _id_39E00B498B7A3C1B = 1;
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = getcompleteweaponname(weapon);
  else
    weaponname = weapon;

  foreach(currentweapon in _id_E3B59C80BF16DE8C) {
    if(isDefined(player.primaryweaponobj) && player.primaryweaponobj == currentweapon) {
      _id_45005959354D69FF = 0;
      continue;
    }

    if(isDefined(player.secondaryweaponobj) && player.secondaryweaponobj == currentweapon)
      _id_39E00B498B7A3C1B = 0;
  }

  if(_id_45005959354D69FF) {
    player.primaryweapon = weaponname;
    player.primaryweaponobj = makeweaponfromstring(weaponname);
  } else if(_id_39E00B498B7A3C1B) {
    player.secondaryweapon = weaponname;
    player.secondaryweaponobj = makeweaponfromstring(weaponname);
  }

  return _id_45005959354D69FF || _id_39E00B498B7A3C1B;
}

itemremoveammofromaltmodes() {
  _id_B2CAC67DCE789126 = getitemweaponname();
  _id_F3A75B200CEDF31F = weaponaltweaponname(_id_B2CAC67DCE789126);

  for(_id_2B1A2FA844ACE41C = 1; _id_F3A75B200CEDF31F != "none" && _id_F3A75B200CEDF31F != _id_B2CAC67DCE789126; _id_2B1A2FA844ACE41C++) {
    self itemweaponsetammo(0, 0, 0, _id_2B1A2FA844ACE41C);
    _id_F3A75B200CEDF31F = weaponaltweaponname(_id_F3A75B200CEDF31F);
  }
}

onscavengerbagpickup(player) {
  if(isDefined(level.onscavengerbagpickup))
    [[level.onscavengerbagpickup]](player);
  else
    _id_071DAF3623150970(player);
}

_id_071DAF3623150970(player) {
  scavengergiveammo(player);

  if(_id_44E99168F6830136(player))
    player scripts\mp\equipment::givescavengerammo();
}

_id_44E99168F6830136(player) {
  _id_5153E7F029B5AC1E = 1;
  _id_21A4E3934B724B7E = getdvarint("t10", 0) > 0;
  _id_7E245BDD13045367 = player scripts\mp\utility\perk::_hasperk("specialty_scavenger_equipment");

  if(istrue(_id_21A4E3934B724B7E) && !istrue(_id_7E245BDD13045367))
    _id_5153E7F029B5AC1E = 0;

  return _id_5153E7F029B5AC1E;
}

handlescavengerbagpickup(_id_2A1C444DEF60A416) {
  self endon("scavengerBagRemoved");
  level endon("game_ended");
  player = undefined;

  for(;;) {
    self waittill("scavenger", player);

    if(!player scripts\cp_mp\utility\player_utility::isinvehicle()) {
      break;
    }
  }

  player notify("scavenger_pickup");
  onscavengerbagpickup(player);

  if(!isDefined(player.pers["scavengerPickedUp"]))
    player.pers["scavengerPickedUp"] = 0;

  player scripts\mp\utility\stats::incpersstat("scavengerPickedUp", 1);
  player scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_scavenger_plus");

  if(isDefined(self.useobj))
    self.useobj delete();

  self notify("death");
  self notify("scavengerBagRemoved");
}

_id_208E1193F12B970A() {
  self endon("scavengerBagRemoved");
  level endon("game_ended");
  self waittill("death");
  waittillframeend;
  self notify("scavengerBagRemoved");
}

scavengergiveammo(player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primary in primaryweapons)
  addscavengercliptoweapon(player, primary, 1);
}

addscavengercliptoweapon(player, weapon, _id_B153A3F2C4662B5E) {
  if(!scripts\mp\utility\weapon::iscacprimaryweapon(weapon) && !level.scavenger_secondary) {
    return;
  }
  if(weapon.isalternate) {
    return;
  }
  if(scripts\mp\utility\weapon::getweapongroup(weapon) == "weapon_projectile") {
    return;
  }
  if(weapon.basename == "iw9_pi_stimpistol_mp") {
    return;
  }
  _id_9938D9499DF221D6 = player getweaponammostock(weapon);
  _id_410E327689185850 = getammooverride(weapon);
  _id_410E327689185850 = int(ceil(_id_B153A3F2C4662B5E * _id_410E327689185850));

  if(weapon._id_318338AA880DFAC6)
    _id_410E327689185850 = _id_410E327689185850 * 1;

  player setweaponammostock(weapon, _id_9938D9499DF221D6 + _id_410E327689185850);
}

scavenger_budget_delete() {
  if(isDefined(self.useobj))
    self.useobj delete();

  self delete();
}

dropscavengerfordeath(attacker, meansofdeath) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!shoulddropscavengerbag(attacker, meansofdeath)) {
    return;
  }
  delay = 0;

  if(isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION")
    delay = 1.5;

  wait(delay);

  if(delay > 0 && !shoulddropscavengerbag(attacker, meansofdeath)) {
    return;
  }
  dropscavengerfordeathinternal(attacker);
}

dropscavengerfordeathinternal(attacker) {
  if(!isDefined(self)) {
    return;
  }
  _id_600FE02C99AEFBAE = self dropscavengerbag("scavenger_bag_mp", "j_head");

  if(!isDefined(_id_600FE02C99AEFBAE)) {
    return;
  }
  _id_600FE02C99AEFBAE scripts\cp_mp\ent_manager::registerspawn(2, ::scavenger_budget_delete);
  _id_600FE02C99AEFBAE _meth_DFB78B3E724AD620(0);
  _id_600FE02C99AEFBAE.owner = attacker;
  _id_600FE02C99AEFBAE.team = attacker.team;
  _id_600FE02C99AEFBAE thread handlescavengerbagpickup(self);
  _id_600FE02C99AEFBAE thread scavengerbagcleanupthink();
  _id_600FE02C99AEFBAE thread scavengerbagtimeoutthink();
  _id_600FE02C99AEFBAE thread _id_208E1193F12B970A();
  _id_653E9F15896017ED(self);

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_scavenger_bag"]))
    [[level.bot_funcs["bots_add_scavenger_bag"]]](_id_600FE02C99AEFBAE);
}

shoulddropscavengerbag(attacker, meansofdeath) {
  if(!isDefined(attacker))
    return 0;

  if(attacker == self)
    return 0;

  return 1;
}

scavengerbagcleanupthink() {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "bag_timeout");

  if(isDefined(self)) {
    if(isDefined(self.useobj))
      self.useobj delete();

    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
  }
}

scavengerbagtimeoutthink() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 20;

  if(isDefined(self))
    self.owner notify("bag_timeout");
}

scavengerbagusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  hintstring = &"PERKS/HOLD_TO_SCAVENGE";
  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 1, "HINT_BUTTON", undefined, hintstring, undefined, undefined, "show", 200, 160, 100, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(player in level.players)
  self.useobj disableplayeruse(player);

  thread scavengebagthink();
  thread scavengebagusemonitoring();

  for(;;) {
    self waittill("pickedUpScavengerBag", player);

    if(isPlayer(player)) {
      player notify("scavenger_pickup");
      onscavengerbagpickup(player);
      player scripts\mp\perks\perks::_id_5A3FEF8CB39336B8("specialty_scavenger_plus");

      if(isDefined(self.useobj))
        self.useobj delete();

      self notify("death");
    }
  }
}

scavengebagusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  _id_E82152475C1CA370 = 1;

  while(_id_E82152475C1CA370) {
    wait 0.1;

    foreach(player in level.players) {
      if(!isDefined(self)) {
        _id_E82152475C1CA370 = 0;
        continue;
      }

      if(player.team != self.team || player scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
        self.useobj disableplayeruse(player);
        continue;
      }

      self.useobj enableplayeruse(player);
    }
  }
}

scavengebagthink() {
  self endon("restarting_physics");
  _id_88032DC5704DA634 = self.useobj;
  _id_DBCE45A33308630D = undefined;

  if(istrue(level.gameended) && !isDefined(_id_88032DC5704DA634)) {
    return;
  }
  while(isDefined(self)) {
    _id_88032DC5704DA634 waittill("trigger", player);
    player.iscapturingcrate = 1;
    _id_DBCE45A33308630D = createuseent();
    _id_DBCE45A33308630D.id = "use";
    result = _id_DBCE45A33308630D useholdthink(player, getdvarfloat("perk_nonScavenger_scavenge_time"));

    if(!isDefined(player)) {
      return;
    }
    player.iscapturingcrate = 0;

    if(result)
      self notify("pickedUpScavengerBag", player);
  }
}

_id_653E9F15896017ED(victim) {
  if(!getdvarint("dvar_6225EC2A193F0934", 0)) {
    return;
  }
  if(isDefined(victim)) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(victim.origin);
    _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4);
  }
}

useholdthink(player, usetime) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = usetime;
  scripts\mp\movers::script_mover_link_to_use_object(player);
  player _id_3B64EB40368C1450::set("useHold", "weapon", 0);
  result = useholdthinkloop(player);

  if(isalive(player))
    player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("useHold");

  if(isDefined(player))
    scripts\mp\movers::script_mover_unlink_from_use_object(player);

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return result;
}

useholdthinkloop(player) {
  result = internal_useholdthinkloop(player);

  if(isDefined(self))
    player scripts\mp\gameobjects::updateuiprogress(self, 0);

  return istrue(result);
}

internal_useholdthinkloop(player) {
  self endon("endUseHoldThink");

  while(player isplayerusing(self)) {
    if(!player scripts\mp\movers::script_mover_use_can_link(self))
      return 0;

    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler))
      self.userate = 1 * self.objectivescaler;
    else
      self.userate = 1;

    player scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime)
      return scripts\mp\utility\player::isreallyalive(player);

    waitframe();
  }

  return 0;
}

createuseent() {
  _id_DBCE45A33308630D = spawn("script_origin", self.origin);
  _id_DBCE45A33308630D.curprogress = 0;
  _id_DBCE45A33308630D.usetime = 0;
  _id_DBCE45A33308630D.userate = 3000;
  _id_DBCE45A33308630D.inuse = 0;
  _id_DBCE45A33308630D.id = self.id;
  _id_DBCE45A33308630D linkTo(self);
  _id_DBCE45A33308630D thread deleteuseent(self);
  return _id_DBCE45A33308630D;
}

deleteuseent(owner) {
  self endon("death");
  owner waittill("death");

  if(isDefined(self.usedby)) {
    foreach(player in self.usedby) {
      player setclientomnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }
  }

  self delete();
}

isplayerusing(weapon) {
  return !level.gameended && isDefined(weapon) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && weapon.curprogress < weapon.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

weaponcanstoreaccuracystats(objweapon) {
  if(scripts\mp\utility\weapon::iscacmeleeweapon(objweapon.basename))
    return 0;

  return scripts\mp\utility\weapon::iscacprimaryweapon(objweapon.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon.basename);
}

setweaponstat(weapon, _id_A1D4E7D5EF9DA660, _id_629757F5C9E770D8, _id_AE9ACDDA1C693FA6) {
  scripts\mp\gamelogic::setweaponstat(weapon, _id_A1D4E7D5EF9DA660, _id_629757F5C9E770D8, _id_AE9ACDDA1C693FA6);
}

watchweaponusage(_id_E9A9DC280D811788) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(weaponclass(objweapon) == "rocketlauncher") {
      continue;
    }
    if(weaponclass(objweapon) == "grenade") {
      if(issubstr(objweapon.basename, "la_mike32"))
        continue;
    }

    onweaponfired(objweapon);
  }
}

onweaponfired(objweapon, _id_85FA2CDCB19D076C) {
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  self.lastshotfiredtime = gettime();
  scripts\mp\codcasterclientmatchdata::_id_1882F80B14421089(0, 1);

  if(!isDefined(self.pers["shotsFired"]))
    scripts\mp\utility\stats::initpersstat("shotsFired");

  if(isai(self)) {
    if(istrue(level._id_0C1D58BF29DCAE79))
      scripts\mp\utility\stats::incpersstat("shotsFired", 1);

    return;
  }

  thread _id_F092173E435BB0F1(objweapon, _id_85FA2CDCB19D076C);
}

_id_F092173E435BB0F1(objweapon, _id_85FA2CDCB19D076C) {
  self endon("disconnect");
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
  self notify("processActiveShots_" + _id_366B0ECC2F28AEAD);
  self endon("processActiveShots_" + _id_366B0ECC2F28AEAD);

  if(!isDefined(self._id_F0006748B1B1EFB0))
    self._id_F0006748B1B1EFB0 = [];

  if(!isDefined(self._id_F0006748B1B1EFB0[_id_366B0ECC2F28AEAD]))
    self._id_F0006748B1B1EFB0[_id_366B0ECC2F28AEAD] = 0;

  self._id_F0006748B1B1EFB0[_id_366B0ECC2F28AEAD]++;

  if(!isDefined(self._id_3FEA9F1ABBE349E2))
    self._id_3FEA9F1ABBE349E2 = [];

  if(isDefined(_id_85FA2CDCB19D076C)) {
    if(!isDefined(self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD]))
      self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD] = [];

    self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD][self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD].size] = _id_85FA2CDCB19D076C;
  }

  setweaponstat(objweapon, 1, "shots");
  scripts\mp\utility\stats::incpersstat("shotsFired", 1);
  watchformiss(objweapon);
  _id_C1480A81B0387196 = self._id_F0006748B1B1EFB0[_id_366B0ECC2F28AEAD];
  _id_7EB0CCF010359357 = scripts\engine\utility::_id_53C4C53197386572(self.hits[_id_366B0ECC2F28AEAD], 0);
  _id_A35EA66201AC92E8 = scripts\engine\utility::_id_53C4C53197386572(self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD], 0);
  _id_0202ACCE87E9D7F6 = scripts\engine\utility::_id_53C4C53197386572(self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD], 0);
  _id_1F4904B24E56FAF5 = _id_C1480A81B0387196 - _id_7EB0CCF010359357;

  if(weaponcanstoreaccuracystats(objweapon)) {
    setweaponstat(objweapon, _id_7EB0CCF010359357, "hits");
    setweaponstat(objweapon, _id_A35EA66201AC92E8, "ai_hits");
    setweaponstat(objweapon, _id_0202ACCE87E9D7F6, "player_hits");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      _id_6D598F3A5A0C87F3 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
      _id_914ECBDE7394D0EF = scripts\mp\playerstats_interface::getplayerstat("combatStats", "misses");
      scripts\mp\playerstats_interface::setplayerstatbuffered(_id_6D598F3A5A0C87F3 + _id_C1480A81B0387196, "combatStats", "totalShots");
      scripts\mp\playerstats_interface::setplayerstatbuffered(_id_914ECBDE7394D0EF + _id_1F4904B24E56FAF5, "combatStats", "misses");
    }
  }

  scripts\mp\events::shotmissed(_id_C1480A81B0387196, _id_7EB0CCF010359357);
  scripts\mp\events::_id_CF1CFBBEC7D07D44(_id_C1480A81B0387196, _id_1F4904B24E56FAF5);
  self._id_F0006748B1B1EFB0[_id_366B0ECC2F28AEAD] = 0;
  self.hits[_id_366B0ECC2F28AEAD] = 0;
  self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 0;
  self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 0;

  if(isDefined(self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD]))
    self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD] = [];
}

watchformiss(objweapon) {
  self endon("disconnect");
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

  if(isDefined(self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD])) {
    for(;;) {
      _id_3FEA9F1ABBE349E2 = 0;

      foreach(missile in self._id_3FEA9F1ABBE349E2[_id_366B0ECC2F28AEAD]) {
        if(isDefined(missile))
          _id_3FEA9F1ABBE349E2++;
      }

      if(_id_3FEA9F1ABBE349E2 == 0) {
        break;
      }

      waitframe();
    }
  } else
    wait 6.0;
}

watchfornearmisswhizby() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("attackerbulletwhizby");
    scripts\mp\playerstats_interface::addtoplayerstatbuffered(1, "combatStats", "nearMisses");
  }
}

checkhit(objweapon, victim, shitloc, idamage) {
  self endon("disconnect");
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

  if(objweapon.isalternate) {
    attachments = getweaponattachments(objweapon);

    if(scripts\engine\utility::array_contains(attachments, "shotgun") || scripts\engine\utility::array_contains(attachments, "gl") || scripts\engine\utility::array_contains(attachments, "glsmoke") || scripts\engine\utility::array_contains(attachments, "glgas") || scripts\engine\utility::array_contains(attachments, "glconc") || scripts\engine\utility::array_contains(attachments, "glflash") || scripts\engine\utility::array_contains(attachments, "glincendiary") || scripts\engine\utility::array_contains(attachments, "glsemtex") || scripts\engine\utility::array_contains(attachments, "glsnap")) {
      self.hits[_id_366B0ECC2F28AEAD] = 1;

      if(isDefined(victim)) {
        if(isagent(victim))
          self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 1;
        else if(isPlayer(victim))
          self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 1;
      }
    }
  }

  if(!weaponcanstoreaccuracystats(objweapon)) {
    return;
  }
  _id_881576B7106F54CE = self meleeButtonPressed();

  if(_id_881576B7106F54CE && objweapon.basename != "iw8_knife_mp") {
    return;
  }
  if(!isDefined(self.hits[_id_366B0ECC2F28AEAD]))
    self.hits[_id_366B0ECC2F28AEAD] = 0;

  if(!isDefined(self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD]))
    self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 0;

  if(!isDefined(self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD]))
    self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 0;

  switch (weaponclass(objweapon)) {
    case "mg":
    case "sniper":
    case "rifle":
    case "pistol":
    case "smg":
      self.hits[_id_366B0ECC2F28AEAD]++;

      if(isagent(victim))
        self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD]++;
      else if(isPlayer(victim))
        self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD]++;

      break;
    case "spread":
      self.hits[_id_366B0ECC2F28AEAD] = 1;

      if(isagent(victim))
        self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 1;
      else if(isPlayer(victim))
        self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 1;

      break;
    case "rocketlauncher":
      self.hits[_id_366B0ECC2F28AEAD] = 1;

      if(isagent(victim))
        self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 1;
      else if(isPlayer(victim))
        self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 1;

      break;
    case "grenade":
      self.hits[_id_366B0ECC2F28AEAD] = 1;

      if(isagent(victim))
        self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 1;
      else if(isPlayer(victim))
        self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 1;

      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::isriotshield(objweapon.basename) || objweapon.basename == "iw8_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_366B0ECC2F28AEAD, self.hits[_id_366B0ECC2F28AEAD], "hits");
    self.hits[_id_366B0ECC2F28AEAD] = 0;
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_366B0ECC2F28AEAD, self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD], "ai_hits");
    self._id_5FFAA0CEB1F66708[_id_366B0ECC2F28AEAD] = 0;
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_366B0ECC2F28AEAD, self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD], "player_hits");
    self._id_C63A7F2980C7D596[_id_366B0ECC2F28AEAD] = 0;
  }

  if(!_id_881576B7106F54CE)
    scripts\mp\codcasterclientmatchdata::_id_1882F80B14421089(1, 1);

  if(!isDefined(self.lasthittime[_id_366B0ECC2F28AEAD]))
    self.lasthittime[_id_366B0ECC2F28AEAD] = 0;

  if(self.lasthittime[_id_366B0ECC2F28AEAD] == gettime()) {
    return;
  }
  self.lasthittime[_id_366B0ECC2F28AEAD] = gettime();

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    _id_C1480A81B0387196 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
    hits = scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

    if(hits <= _id_C1480A81B0387196) {
      scripts\mp\playerstats_interface::setplayerstatbuffered(hits, "combatStats", "hits");
      scripts\mp\playerstats_interface::setplayerstatbuffered(int(_id_C1480A81B0387196 - hits), "combatStats", "misses");
    }
  }

  thread scripts\cp_mp\challenges::onsuccessfulhit(objweapon);
  thread scripts\mp\events::shothit();
  thread scripts\mp\events::_id_2FCA19675EB69F1A(victim, shitloc, idamage);
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);

  if(_id_CF4209C200F8BBF4 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg))
      self.shotslandedlmg = 1;
    else
      self.shotslandedlmg++;
  }

  currenttime = gettime();
  self.pers["lastDamageTime"] = currenttime;

  if(isDefined(victim))
    victim.lasttimedamaged = currenttime;
}

friendlyfirecheck(owner, attacker, _id_361E36D990201511, _id_D4380FBE5B18F83C) {
  if(!isDefined(owner) || !isDefined(owner.team))
    return 1;

  if(!level.teambased)
    return 1;

  _id_EAF0A0E98E12BCD0 = level.friendlyfire;

  if(isDefined(_id_361E36D990201511))
    _id_EAF0A0E98E12BCD0 = _id_361E36D990201511;

  if(_id_EAF0A0E98E12BCD0 != 0)
    return 1;

  if(attacker == owner || isDefined(attacker.owner) && attacker.owner == owner)
    return 1;

  attackerteam = undefined;

  if(isDefined(attacker.owner))
    attackerteam = attacker.owner.team;
  else if(isDefined(attacker.team))
    attackerteam = attacker.team;

  if(!isDefined(attackerteam))
    return 1;

  if(attackerteam != owner.team)
    return 1;

  return 0;
}

watchequipmentonspawn() {
  self notify("watchEquipmentOnSpawn");
  self endon("watchEquipmentOnSpawn");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  deletedisparateplacedequipment();
  _id_7A9A49126147A952 = scripts\mp\utility\dvars::getintproperty("scr_deleteexplosivesonspawn", 1) && (!scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") || !checkequipforrugged());

  if(_id_7A9A49126147A952)
    deleteplacedequipment();

  _id_194EDBE6D906C4E6 = self.plantedtacticalequip.size;
  _id_C7E5188314606729 = self.plantedlethalequip.size;
  _id_9DF2225241E8340A = self.plantedsuperequip.size;
  _id_A81B9997DA958D97 = self.plantedhackedequip.size;
}

getallequip() {
  _id_7C3CE7FF13FBD7FC = [];

  if(isDefined(self.plantedlethalequip))
    _id_7C3CE7FF13FBD7FC = scripts\engine\utility::array_combine(_id_7C3CE7FF13FBD7FC, self.plantedlethalequip);

  if(isDefined(self.plantedtacticalequip))
    _id_7C3CE7FF13FBD7FC = scripts\engine\utility::array_combine(_id_7C3CE7FF13FBD7FC, self.plantedtacticalequip);

  if(isDefined(self.plantedsuperequip))
    _id_7C3CE7FF13FBD7FC = scripts\engine\utility::array_combine(_id_7C3CE7FF13FBD7FC, self.plantedsuperequip);

  if(isDefined(self.plantedhackedequip))
    _id_7C3CE7FF13FBD7FC = scripts\engine\utility::array_combine(_id_7C3CE7FF13FBD7FC, self.plantedhackedequip);

  return _id_7C3CE7FF13FBD7FC;
}

removeequip(_id_2EB789D043254817) {
  if(isDefined(self.plantedlethalequip))
    self.plantedlethalequip = scripts\engine\utility::array_remove(self.plantedlethalequip, _id_2EB789D043254817);

  if(isDefined(self.plantedtacticalequip))
    self.plantedtacticalequip = scripts\engine\utility::array_remove(self.plantedtacticalequip, _id_2EB789D043254817);

  if(isDefined(self.plantedsuperequip))
    self.plantedsuperequip = scripts\engine\utility::array_remove(self.plantedsuperequip, _id_2EB789D043254817);

  if(isDefined(self.plantedhackedequip))
    self.plantedhackedequip = scripts\engine\utility::array_remove(self.plantedhackedequip, _id_2EB789D043254817);
}

checkequipforrugged() {
  equipment = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(_id_2EB789D043254817 in equipment) {
    if(isDefined(_id_2EB789D043254817.hasruggedeqp))
      return 1;
  }

  return 0;
}

watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;)
    watchgrenadethrows();
}

watchgrenadethrows() {
  grenade = waittill_grenade_throw();
  _id_3FCE58C2642EBECC(grenade);

  if(isDefined(grenade))
    grenade _meth_5226227BCE83EBE9(3, self.team);
}

_id_3FCE58C2642EBECC(grenade) {
  if(!isDefined(grenade)) {
    return;
  }
  if(!isDefined(grenade.weapon_name)) {
    return;
  }
  _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(grenade.weapon_object);

  if(isPlayer(self)) {
    setweaponstat(grenade.weapon_object, 1, "shots");
    scripts\mp\battlechatter_mp::ongrenadeuse(grenade);
    scripts\mp\gamelogic::sethasdonecombat(self, 1);

    if(isDefined(grenade.equipmentref)) {
      _id_4918B66CEBC7FBE7 = scripts\mp\equipment::isequipmentlethal(grenade.equipmentref);
      istactical = scripts\mp\equipment::isequipmenttactical(grenade.equipmentref);
      scripts\mp\potg_events::grenadethrownevent(_id_4918B66CEBC7FBE7);

      if(isDefined(istactical) && self isthrowingbackgrenade() && getdvarint("dvar_61A8D5707F364581", 1)) {
        self _meth_9B5704D0633B87FA();
        objweapon = makeweapon(grenade.weapon_name);
        ammo = self getweaponammoclip(objweapon);
        _id_2AA9CAEF99C9AF77 = int(max(ammo - 1, 0));
        self setweaponammoclip(objweapon, _id_2AA9CAEF99C9AF77);
      }
    }

    _id_189B67B2735B981D::_id_0EF6885141252869(self, grenade);

    if(scripts\mp\utility\weapon::issuperweapon(grenade.weapon_object)) {
      if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers") || istrue(self._id_859654E0445A36D9)) {
        if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
          if(scripts\mp\utility\player::isinlaststand(self)) {
            _id_EBEC497FF8B18A45 = scripts\mp\supers::getsuperrefforsuperweapon(grenade.weapon_object);
            self._id_A188FBA649FFD953 = _id_EBEC497FF8B18A45;
          }
        }
      }
    }
  }

  if(scripts\mp\utility\weapon::isaxeweapon(grenade.weapon_name)) {
    grenade thread watchgrenadeaxepickup(self);
    return;
  }

  grenade thread scripts\mp\battlechatter_mp::grenadeproximitytracking();
  grenade.spawnpos = grenade.origin;
  _id_6A8EC730B2BFA844::ongrenadeused(grenade, self, _id_49E6EF3EDADD524E);

  switch (_id_49E6EF3EDADD524E) {
    case "frag_grenade":
      if(grenade.ticks >= 1)
        grenade.iscooked = 1;

      grenade.originalowner = self;
      grenade thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "pop_rocket":
      if(grenade.ticks >= 1)
        grenade.iscooked = 1;

      grenade.originalowner = self;
      thread scripts\mp\equipment\wristrocket::wristrocketused(grenade);
      grenade thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;
    case "semtex":
      thread semtex_used(grenade);
      grenade thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "c4":
      thread scripts\mp\equipment\c4::c4_used(grenade);
      break;
    case "emp_grenade":
      thread scripts\mp\equipment\emp_grenade::emp_grenade_used(grenade);
      break;
    case "snapshot_grenade":
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(grenade, 0);
      break;
    case "smoke_grenade":
      grenade thread _id_4B6CDCD3C396ABAB::smokegrenadeused(0);
      break;
    case "trophy":
      thread scripts\mp\equipment\trophy_system::trophy_used(grenade);
      break;
    case "claymore":
      if(isagent(self))
        thread _id_528B573C2E6FC70A::_id_0AF4EB22319AD376(grenade);
      else
        thread scripts\mp\equipment\claymore::claymore_use(grenade);

      break;
    case "at_mine":
      thread scripts\mp\equipment\at_mine::at_mine_use(grenade);
      break;
    case "shuriken":
    case "throwingknife":
      thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(grenade);
      break;
    case "molotov":
      grenade thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\molotov::molotov_used(grenade);
      break;
    case "thermite":
      thread scripts\mp\equipment\thermite::thermite_used(grenade);
      break;
    case "tac_ops_spawn_grenade":
      thread scripts\mp\supers\spawnbeacon::thrown(grenade);
      break;
    case "haunted_box":
    case "self_revive_box":
    case "leader_box":
    case "armor_box":
    case "ammo_box":
    case "blastshield_box":
      thread scripts\mp\equipment\support_box::supportbox_used(grenade);
      break;
    case "decoy_grenade":
      thread scripts\mp\equipment\decoy_grenade::decoy_used(grenade);
      break;
    case "gas":
      thread scripts\mp\equipment\gas_grenade::gas_used(grenade);
      break;
    case "hb_sensor":
      thread _id_0EC0F9AD939B29E0::hb_sensor_used(grenade);
      break;
    case "offhand_spotter_scope":
      thread scripts\mp\equipment\binoculars::binoculars_used(grenade);
      break;
    case "tac_cover":
      thread scripts\mp\equipment\tactical_cover::tac_cover_used(grenade);
      break;
    case "flare":
      thread scripts\mp\equipment\tac_insert::tacinsert_used(grenade);
      break;
    case "advanced_supply_drop_marker":
      thread scripts\mp\equipment\advanced_supply_drop::advanced_supply_drop_marker_used(grenade);
      break;
    case "deployable_kiosk_marker_mp":
      if(isDefined(level._id_FF4BBEB786042D78))
        self thread[[level._id_FF4BBEB786042D78]](grenade);

      break;
    case "deploy_weapondrop":
      thread scripts\mp\equipment\weapon_drop::weapondrop_used(grenade);
      break;
    case "concussion_grenade":
      grenade thread concussionused();
      break;
    case "tac_camera":
      thread _id_51F5154861435B1E::_id_DBECA4D95F44293D(grenade);
      break;
    case "sonar_pulse":
      thread _id_28B451B2EA6DAE46::_id_2D117EEB564F6EA3(grenade);
      break;
    case "sound_veil":
      if(isagent(self))
        thread _id_681C3DB54537AFA6::_id_7B988E1BB56CA747(grenade);
      else
        thread _id_45C10CA5CB8409BF::_id_06D91F8514005D18(grenade);

      break;
    case "geiger_counter":
      thread _id_479E458F6F530F0D::_id_3D5C1674387C936E(grenade);
      break;
    case "deployed_decoy":
      thread _id_1CF2ED809496BF4E::_id_255BED505249BC85(grenade);
      break;
    case "shock_stick":
      thread _id_0A35012B9B75A996::_id_054655641D3957E3(grenade, 0);
      break;
    case "bunkerbuster":
      thread _id_6E2BB9330396AFCB::_id_3D78DD516C25EF77(grenade);
      break;
    case "blinding_turret_device":
      thread _id_7EC79670452EC186::_id_B02438CF4822A79E(grenade);
      break;
    case "deploy_loadout_drop":
      thread _id_19818A4D668D8841::_id_4CA6B5FEBA808692(grenade);
      break;
    case "iodine_pills":
      thread _id_156835EF9924856A::_id_7214173379DA1591(grenade);
      break;
    case "decon_station":
    case "reinforcement_flare":
    case "magsnap":
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc(_id_49E6EF3EDADD524E, "grenadeUsed")]](grenade);
      break;
    case "throwstar":
      thread _id_52D91CB28006A5BD::_id_709581D70EBB07CD(grenade);
      break;
    case "thermal_phone":
      thread _id_13F9DDE7EECFBC71::_id_230403B8CF5EA1E8(grenade);
      break;
    case "flare_dmz_pmc":
      thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("pmc_missions", "onFlarePlaced", grenade);
      break;
    case "deploy_vehicle_drop":
      thread _id_676F8221E501BED1::_id_604ED6F2F8323EA6(grenade);
      break;
    default:
      if(isDefined(level.ongrenadeused))
        [[level.ongrenadeused]](grenade.weapon_name, grenade);

      break;
  }

  if(isPlayer(self))
    logequipmentuse(grenade);
}

logequipmentuse(grenade) {
  if(!isDefined(grenade)) {
    return;
  }
  _id_1E51A290CEA8B604 = scripts\mp\utility\weapon::getequipmenttype(grenade.weapon_object);

  if(!isDefined(_id_1E51A290CEA8B604))
    _id_1E51A290CEA8B604 = "none";

  self dlog_recordplayerevent("dlog_event_equipment_use", ["weapon_used", grenade.weapon_name, "equipment_type", _id_1E51A290CEA8B604]);
}

concussionused() {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  owner = self.owner;
  self waittill("explode", position);
  thread scripts\mp\equipment\concussion_grenade::onexplode(owner, position);
}

watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();

  if(isDefined(self.useobj_trigger))
    self.useobj_trigger delete();
}

_id_E00B77A9CB4D8322(target) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  level.special_lockon_target_list[level.special_lockon_target_list.size] = target;
}

_id_1A33BD42949CCBDA(target) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, target);
}

lockonlaunchers_gettargetarray(_id_FE608D14719843BC) {
  targets = [];
  _id_E688B198AA9A4B3F = 0;

  if(isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = scripts\engine\utility::array_removeundefined(level.special_lockon_target_list);

    foreach(_id_ACE5C2D0AE6B4A14 in level.special_lockon_target_list)
    targets[targets.size] = _id_ACE5C2D0AE6B4A14;
  }

  if(level.teambased) {
    if(isDefined(_id_FE608D14719843BC) && _id_FE608D14719843BC == 1) {
      foreach(_id_B5517D24E9DC9A49 in level.characters) {
        if(isDefined(_id_B5517D24E9DC9A49) && isalive(_id_B5517D24E9DC9A49) && (_id_B5517D24E9DC9A49.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_B5517D24E9DC9A49;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
        if(isDefined(_id_153FDEE861E0F06F) && isDefined(_id_153FDEE861E0F06F.affectedbylockon) && (_id_153FDEE861E0F06F.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_153FDEE861E0F06F;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(isDefined(ac130) && (ac130.team != self.team || _id_E688B198AA9A4B3F))
            targets[targets.size] = ac130;
        }
      }
    }

    foreach(_id_7731ADEF63E19B0C in scripts\cp_mp\vehicles\vehicle::_id_9005B7FC076293F8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(_id_7731ADEF63E19B0C);

      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && istrue(vehicle._id_0DEC9F9A032ECC02)) {
          continue;
        }
        if(isDefined(vehicle) && (!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, self) || _id_E688B198AA9A4B3F))
          targets[targets.size] = vehicle;
      }
    }

    if(isDefined(level.loot_choppers)) {
      foreach(_id_AD23E3D265548E7E in level.loot_choppers) {
        if(isDefined(_id_AD23E3D265548E7E))
          targets[targets.size] = _id_AD23E3D265548E7E;
      }
    }
  } else {
    if(isDefined(_id_FE608D14719843BC) && _id_FE608D14719843BC == 1) {
      foreach(_id_B5517D24E9DC9A49 in level.characters) {
        if((!isDefined(_id_B5517D24E9DC9A49) || !isalive(_id_B5517D24E9DC9A49)) && !_id_E688B198AA9A4B3F) {
          continue;
        }
        targets[targets.size] = _id_B5517D24E9DC9A49;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
        if(isDefined(_id_153FDEE861E0F06F.affectedbylockon) && (isDefined(_id_153FDEE861E0F06F.owner) && _id_153FDEE861E0F06F.owner != self || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_153FDEE861E0F06F;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.owner != self || _id_E688B198AA9A4B3F)
            targets[targets.size] = ac130;
        }
      }
    }

    foreach(_id_7731ADEF63E19B0C in scripts\cp_mp\vehicles\vehicle::_id_9005B7FC076293F8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(_id_7731ADEF63E19B0C);

      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && istrue(self._id_0DEC9F9A032ECC02)) {
          continue;
        }
        if(!isDefined(vehicle.owner)) {
          targets[targets.size] = vehicle;
          continue;
        }

        if(vehicle.owner != self || _id_E688B198AA9A4B3F)
          targets[targets.size] = vehicle;
      }
    }
  }

  return targets;
}

watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    [objweapon, missile] = waittill_missile_fire();
    updatemissilefire(missile);
    onweaponfired(objweapon, missile);
  }
}

updatemissilefire(missile) {
  _id_6D87867F43E1D612 = undefined;
  _id_54A24336CC9A143D = 0;

  switch (missile.weapon_name) {
    case "iw9_la_gromeo_mp":
      _id_6D87867F43E1D612 = self.missilelaunchertarget;
      level thread scripts\mp\battlechatter_mp::launcherfired(missile);
      break;
    case "iw9_la_juliet_mp":
      _id_6D87867F43E1D612 = self.javelin.target;
      level thread scripts\mp\battlechatter_mp::javelinfired(self.team, self.javelin.target.origin);
      break;
    case "ub_glmini01_xmags":
    case "ub_glmini01":
    case "ub_gl_scharlie":
    case "ub_gl_akilo":
    case "ub_gl01_xmags":
    case "ub_gl01_p01":
    case "ub_gl01":
      _id_54A24336CC9A143D = 1;
      break;
    case "ub_gl_smoke_scharlie":
    case "ub_gl_smoke_mini":
    case "ub_gl_smoke_akilo":
    case "ub_gl_smoke":
      _id_54A24336CC9A143D = 1;
      missile thread _id_4B6CDCD3C396ABAB::smokegrenadeused(1);
      break;
    case "ub_gl_gas_scharlie":
    case "ub_gl_gas_mini":
    case "ub_gl_gas_akilo":
    case "ub_gl_gas":
      _id_54A24336CC9A143D = 1;
      thread scripts\mp\equipment\gas_grenade::gas_used(missile);
      break;
    case "ub_gl_conc":
    case "ub_gl_flash_scharlie":
    case "ub_gl_flash_mini":
    case "ub_gl_flash_akilo":
    case "ub_gl_flash":
    case "ub_gl_conc_scharlie":
    case "ub_gl_conc_mini":
    case "ub_gl_conc_akilo":
      _id_54A24336CC9A143D = 1;
      break;
    case "ub_gl_db_scharlie":
    case "ub_gl_db_mini":
    case "ub_gl_db_akilo":
    case "ub_gl_db":
      _id_54A24336CC9A143D = 1;
      missile thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\thermite::thermite_used(missile, 1);
      break;
    case "ub_gl_semtex_akilo":
    case "ub_gl_semtex":
    case "ub_gl_semtex_scharlie":
    case "ub_gl_semtex_mini":
      _id_54A24336CC9A143D = 1;
      break;
    case "ub_gl_snap_scharlie":
    case "ub_gl_snap_mini":
    case "ub_gl_snap_akilo":
    case "ub_gl_snap":
      _id_54A24336CC9A143D = 1;
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(missile, _id_54A24336CC9A143D);
    case "ub_gl_drill_scharlie":
    case "ub_gl_drill_mini":
    case "ub_gl_drill_akilo":
    case "ub_gl_drill":
      _id_54A24336CC9A143D = 1;
      thread _id_6E2BB9330396AFCB::_id_D5FE78860931C577(missile);
      break;
    case "ub_gl_shock_scharlie":
    case "ub_gl_shock_mini":
    case "ub_gl_shock_akilo":
    case "ub_gl_shock":
      _id_54A24336CC9A143D = 1;
      thread _id_0A35012B9B75A996::_id_054655641D3957E3(missile, _id_54A24336CC9A143D);
      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(missile.weapon_name) && isDefined(_id_6D87867F43E1D612)) {
    missile.lockontarget = _id_6D87867F43E1D612;
    level notify("stinger_fired", self, missile, _id_6D87867F43E1D612);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(_id_6D87867F43E1D612, missile);
  }

  if(isPlayer(self))
    missile.adsfire = scripts\mp\utility\player::isplayerads();

  if(!_id_54A24336CC9A143D && isexplosivemissile(missile.weapon_name)) {
    scale = 1.0;

    if(issmallmissile(missile.weapon_name))
      scale = 0.65;

    missile thread scripts\mp\shellshock::grenade_earthquake(scale);
  }

  scripts\mp\events::missilefired(missile);
}

issmallmissile(weapon) {
  return 0;
}

isexplosivemissile(weapon) {
  _id_92FCE7B1696254E3 = getweaponbasename(weapon);

  switch (_id_92FCE7B1696254E3) {
    case "pop_rocket_proj_mp":
    case "gunship_25mm_mp":
    case "gunship_hellfire_mp":
    case "gunship_40mm_mp":
    case "gunship_105mm_mp":
      return 0;
  }

  return 1;
}

movingplatformdetonate(data) {
  if(!isDefined(data.lasttouchedplatform) || !isDefined(data.lasttouchedplatform.destroyexplosiveoncollision) || data.lasttouchedplatform.destroyexplosiveoncollision)
    self notify("detonateExplosive");
}

monitordisownedequipment(player, equipment, _id_93494D8D17D67D84) {
  level endon("game_ended");
  equipment endon("death");
  equipment notify("monitorDisownedEquipment()");
  equipment endon("monitorDisownedEquipment()");

  if(istrue(_id_93494D8D17D67D84))
    player scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  else
    player scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");

  equipment deleteexplosive();
}

monitordisownedgrenade(player, grenade) {
  level endon("game_ended");
  grenade endon("death");
  grenade endon("mine_planted");
  scripts\engine\utility::waittill_any_ents(player, "joined_team", player, "joined_spectators", player, "disconnect", level, "prematch_cleanup");

  if(isDefined(grenade))
    grenade delete();
}

isplantedequipment(ent) {
  return isDefined(level.mines[ent getentitynumber()]) || istrue(ent.planted);
}

getmaxplantedlethalequip(player) {
  _id_E416DE928081866D = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment"))
    _id_E416DE928081866D++;

  return _id_E416DE928081866D;
}

getmaxplantedtacticalequip(player) {
  _id_30DC1C5E4B8568B0 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment"))
    _id_30DC1C5E4B8568B0++;

  return _id_30DC1C5E4B8568B0;
}

getmaxplantedsuperequip(equipmentref) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 1;

  return 2;
}

_id_80809994F5A396D0() {
  return 2;
}

getmaxplantedhackedequip() {
  return 3;
}

onequipmentplanted(_id_FEBA29CE82D4980F, equipmentref, deletefunc, _id_E12DF308E25F92C3) {
  _id_FEBA29CE82D4980F.equipmentref = equipmentref;
  _id_FEBA29CE82D4980F.deletefunc = deletefunc;
  _id_FEBA29CE82D4980F.planted = 1;

  if(!istrue(_id_E12DF308E25F92C3))
    updateplantedarray(_id_FEBA29CE82D4980F);

  entnum = _id_FEBA29CE82D4980F getentitynumber();
  level.mines[entnum] = _id_FEBA29CE82D4980F;

  if(equipmentref != "equip_tac_cover") {
    _id_FEBA29CE82D4980F enableplayermarks("equipment");

    if(level.teambased)
      _id_FEBA29CE82D4980F filteroutplayermarks(self.team);
    else
      _id_FEBA29CE82D4980F filteroutplayermarks(self);
  }

  _id_FEBA29CE82D4980F notify("mine_planted");
}

updateplantedarray(equipment) {
  _id_749469570D9D7CBC = undefined;
  _id_20F2244C14CD5D6C = 0;
  slot = scripts\mp\equipment::findequipmentslot(equipment.equipmentref);

  if(istrue(equipment.ishacked)) {
    _id_749469570D9D7CBC = equipment.owner.plantedhackedequip;
    _id_20F2244C14CD5D6C = getmaxplantedhackedequip();
  } else if(istrue(equipment.issuper)) {
    if(equipment.equipmentref == "equip_tac_cover") {
      _id_20F2244C14CD5D6C = _id_80809994F5A396D0();
      _id_749469570D9D7CBC = equipment.owner.plantedsuperequip;
    } else {
      _id_749469570D9D7CBC = equipment.owner.plantedsuperequip;
      _id_20F2244C14CD5D6C = getmaxplantedsuperequip(equipment.equipmentref);
    }
  } else if(isDefined(slot) && slot == "primary" || scripts\mp\equipment::isequipmentlethal(equipment.equipmentref)) {
    _id_749469570D9D7CBC = equipment.owner.plantedlethalequip;
    _id_20F2244C14CD5D6C = getmaxplantedlethalequip(self);
  } else if(isDefined(slot) && slot == "secondary" || scripts\mp\equipment::isequipmenttactical(equipment.equipmentref)) {
    _id_749469570D9D7CBC = equipment.owner.plantedtacticalequip;
    _id_20F2244C14CD5D6C = getmaxplantedtacticalequip(self);
  }

  if(!isDefined(_id_749469570D9D7CBC)) {
    message = "isSuper: " + equipment.issuper + ", slot: " + slot + ", equipmentRef: " + equipment.equipmentref + ", allowed: " + scripts\mp\equipment::is_equipment_slot_allowed("super");
    scripts\mp\utility\script::demoforcesre(message);
  }

  if(_id_749469570D9D7CBC.size > 0) {
    if(_id_749469570D9D7CBC.size && _id_749469570D9D7CBC.size >= _id_20F2244C14CD5D6C) {
      _id_E472D6DEDB41ACFD = _id_749469570D9D7CBC[0];
      _id_749469570D9D7CBC = scripts\engine\utility::array_remove(_id_749469570D9D7CBC, _id_E472D6DEDB41ACFD);
      _id_E472D6DEDB41ACFD deleteexplosive();
    }
  }

  _id_749469570D9D7CBC[_id_749469570D9D7CBC.size] = equipment;

  if(istrue(equipment.ishacked))
    equipment.owner.plantedhackedequip = _id_749469570D9D7CBC;
  else if(istrue(equipment.issuper))
    equipment.owner.plantedsuperequip = _id_749469570D9D7CBC;
  else if(isDefined(slot) && slot == "primary" || scripts\mp\equipment::isequipmentlethal(equipment.equipmentref))
    equipment.owner.plantedlethalequip = _id_749469570D9D7CBC;
  else if(isDefined(slot) && slot == "secondary" || scripts\mp\equipment::isequipmenttactical(equipment.equipmentref))
    equipment.owner.plantedtacticalequip = _id_749469570D9D7CBC;
}

setplantedequipmentuse(enabled) {
  _id_7C3CE7FF13FBD7FC = getallequip();

  foreach(_id_2EB789D043254817 in _id_7C3CE7FF13FBD7FC) {
    if(isDefined(_id_2EB789D043254817.trigger) && isDefined(_id_2EB789D043254817.owner)) {
      if(enabled) {
        _id_2EB789D043254817.trigger enableplayeruse(_id_2EB789D043254817.owner);
        continue;
      }

      _id_2EB789D043254817.trigger disableplayeruse(_id_2EB789D043254817.owner);
    }
  }
}

cleanupequipment(_id_3397EC8092BCDDE5, _id_E9CAE9957EACB9FB, _id_63B78A72AA2DF5F9) {
  if(isDefined(_id_3397EC8092BCDDE5))
    level.mines[_id_3397EC8092BCDDE5] = undefined;

  if(isDefined(_id_E9CAE9957EACB9FB))
    _id_E9CAE9957EACB9FB delete();

  if(isDefined(_id_63B78A72AA2DF5F9))
    _id_63B78A72AA2DF5F9 delete();
}

equipmenthit(owner, attacker, objweapon, meansofdeath) {
  if(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, owner)) {
    if(!isDefined(objweapon)) {
      return;
    }
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename)) {
      return;
    }
    _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

    if(!isDefined(attacker.lasthittime))
      attacker.lasthittime = [];

    if(!isDefined(attacker.lasthittime[_id_366B0ECC2F28AEAD]))
      attacker.lasthittime[_id_366B0ECC2F28AEAD] = 0;

    if(attacker.lasthittime[_id_366B0ECC2F28AEAD] == gettime()) {
      return;
    }
    attacker.lasthittime[_id_366B0ECC2F28AEAD] = gettime();
    attacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(_id_366B0ECC2F28AEAD, 1, "hits");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      _id_C1480A81B0387196 = attacker scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
      hits = attacker scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

      if(hits <= _id_C1480A81B0387196) {
        scripts\mp\playerstats_interface::setplayerstatbuffered(hits, "combatStats", "hits");
        scripts\mp\playerstats_interface::setplayerstatbuffered(int(_id_C1480A81B0387196 - hits), "combatStats", "misses");
      }
    }

    if(isDefined(meansofdeath) && scripts\engine\utility::isbulletdamage(meansofdeath) || scripts\mp\utility\damage::isprojectiledamage(meansofdeath)) {
      attacker.pers["lastDamageTime"] = gettime();
      _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);

      if(_id_CF4209C200F8BBF4 == "weapon_lmg") {
        if(!isDefined(attacker.shotslandedlmg))
          attacker.shotslandedlmg = 1;
        else
          attacker.shotslandedlmg++;
      }
    }
  }
}

deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  _id_3397EC8092BCDDE5 = self getentitynumber();
  level.mines[_id_3397EC8092BCDDE5] = undefined;
  self disableplayermarks("equipment");

  if(isDefined(self.deletefunc)) {
    self thread[[self.deletefunc]]();
    self notify("deleted_equipment");
  } else {
    _id_E9CAE9957EACB9FB = self.killcament;
    _id_63B78A72AA2DF5F9 = self.trigger;
    cleanupequipment(_id_3397EC8092BCDDE5, _id_E9CAE9957EACB9FB, _id_63B78A72AA2DF5F9);
    self notify("deleted_equipment");
    self delete();
  }
}

makeexplosiveusable(offset) {
  self setotherent(self.owner);

  if(!isDefined(offset))
    offset = 10;

  trigger = spawn("script_origin", self.origin + offset * anglestoup(self.angles));
  trigger linkTo(self);
  self.trigger = trigger;
  trigger.owner = self;
  thread makeexplosiveusableinternal();
  return trigger;
}

makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  trigger = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    trigger = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(trigger))
    trigger delete();
}

makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  trigger = self.trigger;
  self.trigger = undefined;

  if(isDefined(trigger))
    trigger delete();
}

watchexplosiveusable() {
  owner = self.owner;
  trigger = self.trigger;
  self endon("death");
  trigger endon("death");
  owner endon("disconnect");
  level endon("game_ended");
  trigger setCursorHint("HINT_NOICON");
  trigger scripts\mp\utility\usability::setselfusable(owner);
  trigger childthread scripts\mp\utility\usability::notusableforjoiningplayers(owner);
  trigger childthread scripts\mp\utility\usability::notusableafterownerchange(owner, self);
  trigger setexplosiveusablehintstring(self.weapon_name);

  for(;;) {
    trigger waittillmatch("trigger", owner);

    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case "trophy_mp":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
      }

      owner thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    owner playlocalsound("scavenger_pack_pickup");
    owner notify("scavenged_ammo", self.weapon_name);
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon(makeweapon(self.weapon_name));

    if(isDefined(equipmentref) && self.owner scripts\mp\equipment::hasequipment(equipmentref))
      self.owner scripts\mp\equipment::incrementequipmentammo(equipmentref, 1);

    thread deleteexplosive();
    return;
  }
}

makeexplosiveusabletag(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;

  if(!isDefined(isgrenade))
    isgrenade = 0;

  scripts\mp\utility\usability::setselfusable(owner);

  if(isgrenade)
    self enablemissilehint(1);
  else
    self setCursorHint("HINT_NOICON");

  self sethinttag(tagname);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  childthread scripts\mp\utility\usability::notusableforjoiningplayers(owner);
  childthread scripts\mp\utility\usability::notusableafterownerchange(owner, self);

  for(;;) {
    self waittillmatch("trigger", owner);

    if(!isDefined(owner)) {
      continue;
    }
    if(istrue(owner.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");

      continue;
    }

    objweapon = undefined;

    if(isDefined(weaponname)) {
      switch (weaponname) {
        case "trophy_mp":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
      }

      owner thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
      owner notify("scavenged_ammo", weaponname);
      attachments = _func_6527364C1ECCA6C6(weaponname);
      objweapon = makeweapon(weaponname, attachments);
    }

    if(isDefined(objweapon)) {
      equipmentref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

      if(isDefined(equipmentref)) {
        if(owner scripts\mp\equipment::hasequipment(equipmentref)) {
          if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_2D9D24F7C63AC143::_id_7E103028C464AB9A(_id_600B944A95C3A7BF::_id_B88CFB4893CEEDAC(equipmentref)) && owner scripts\mp\equipment::getequipmentammo(equipmentref) >= owner scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
            lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(equipmentref);
            result = owner _id_2D9D24F7C63AC143::_id_E01D9736B2D100AC(lootid, 1);

            if(istrue(result)) {
              _id_60227BFF1E9478CC = spawnStruct();
              _id_60227BFF1E9478CC.scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
              _id_60227BFF1E9478CC.count = 1;
              owner _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
            }
          } else if(owner scripts\mp\equipment::getequipmentammo(equipmentref) < owner scripts\mp\equipment::getequipmentmaxammo(equipmentref))
            owner scripts\mp\equipment::incrementequipmentammo(equipmentref, 1);
          else {
            owner scripts\mp\hud_message::showerrormessage("MP/DENY_EQUIP_PICKUP");
            continue;
          }
        } else if(isDefined(level.onnewequipmentpickup))
          [[level.onnewequipmentpickup]](owner, equipmentref);
      }
    }

    if(isDefined(weaponname)) {
      switch (weaponname) {
        case "at_mine_mp":
          _id_09D5BC8E32EE3635 = "iw9_proximity_mine_pickup";
          break;
        case "c4_mp":
          _id_09D5BC8E32EE3635 = "iw9_c4_pickup";
          break;
        case "claymore_mp":
          _id_09D5BC8E32EE3635 = "iw9_claymore_pickup";
          break;
        default:
          _id_09D5BC8E32EE3635 = "scavenger_pack_pickup";
      }

      owner playlocalsound(_id_09D5BC8E32EE3635);
    }

    if(isDefined(self.useobj))
      self.useobj delete();

    thread deleteexplosive();
    return;
  }
}

makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

setexplosiveusablehintstring(weaponname) {
  switch (weaponname) {
    case "c4_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_C4");
      break;
    case "at_mine_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case "claymore_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case "gas_grenade_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case "trophy_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
  }
}

explosivehandlemovers(parent, _id_B5F7C0806632D99B) {
  data = spawnStruct();
  data.linkparent = parent;
  data.deathoverridecallback = ::movingplatformdetonate;
  data.endonstring = "death";

  if(scripts\cp_mp\utility\train_utility::is_train_ent(parent)) {
    data._id_49CB2C45D3230ED8 = 1;
    self _meth_7E73001E97FE87B9(1);
  }

  if(!isDefined(_id_B5F7C0806632D99B) || !_id_B5F7C0806632D99B)
    data.invalidparentoverridecallback = scripts\mp\movers::moving_platform_empty_func;

  thread scripts\mp\movers::handle_moving_platforms(data);
}

explosivetrigger(target, graceperiod, _id_DEE1E90C5A8243B7) {
  if(isPlayer(target) && target scripts\mp\utility\perk::_hasperk("specialty_delaymine")) {
    target thread scripts\cp_mp\challenges::triggereddelayedexplosion();
    graceperiod = level.delayminetime;
  }

  wait(graceperiod);
}

getdamageableents(pos, radius, _id_7C242DFB11E2E6E6, _id_ACC4F45C61ED5FF1) {
  ents = [];

  if(!isDefined(_id_7C242DFB11E2E6E6))
    _id_7C242DFB11E2E6E6 = 0;

  if(!isDefined(_id_ACC4F45C61ED5FF1))
    _id_ACC4F45C61ED5FF1 = 0;

  radiussq = radius * radius;
  players = level.players;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
    if(!isalive(players[_id_AC0E594AC96AA3A8]) || players[_id_AC0E594AC96AA3A8].sessionstate != "playing") {
      continue;
    }
    _id_1925D24D0AE333E6 = scripts\mp\utility\damage::get_damageable_player_pos(players[_id_AC0E594AC96AA3A8]);
    distsq = distancesquared(pos, _id_1925D24D0AE333E6);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_1925D24D0AE333E6, _id_ACC4F45C61ED5FF1, players[_id_AC0E594AC96AA3A8])))
      ents[ents.size] = scripts\mp\utility\damage::get_damageable_player(players[_id_AC0E594AC96AA3A8], _id_1925D24D0AE333E6);
  }

  grenades = getEntArray("grenade", "classname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < grenades.size; _id_AC0E594AC96AA3A8++) {
    _id_D3366E54CC41EA6C = scripts\mp\utility\damage::get_damageable_grenade_pos(grenades[_id_AC0E594AC96AA3A8]);
    distsq = distancesquared(pos, _id_D3366E54CC41EA6C);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_D3366E54CC41EA6C, _id_ACC4F45C61ED5FF1, grenades[_id_AC0E594AC96AA3A8])))
      ents[ents.size] = scripts\mp\utility\damage::get_damageable_grenade(grenades[_id_AC0E594AC96AA3A8], _id_D3366E54CC41EA6C);
  }

  destructibles = getEntArray("destructible", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < destructibles.size; _id_AC0E594AC96AA3A8++) {
    _id_D3366E54CC41EA6C = destructibles[_id_AC0E594AC96AA3A8].origin;
    distsq = distancesquared(pos, _id_D3366E54CC41EA6C);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_D3366E54CC41EA6C, _id_ACC4F45C61ED5FF1, destructibles[_id_AC0E594AC96AA3A8]))) {
      _id_0E14905A4CDF3B12 = spawnStruct();
      _id_0E14905A4CDF3B12.isplayer = 0;
      _id_0E14905A4CDF3B12.isadestructable = 0;
      _id_0E14905A4CDF3B12.entity = destructibles[_id_AC0E594AC96AA3A8];
      _id_0E14905A4CDF3B12.damagecenter = _id_D3366E54CC41EA6C;
      ents[ents.size] = _id_0E14905A4CDF3B12;
    }
  }

  _id_7DD6062F971AC3CC = getEntArray("destructable", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7DD6062F971AC3CC.size; _id_AC0E594AC96AA3A8++) {
    _id_D3366E54CC41EA6C = _id_7DD6062F971AC3CC[_id_AC0E594AC96AA3A8].origin;
    distsq = distancesquared(pos, _id_D3366E54CC41EA6C);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_D3366E54CC41EA6C, _id_ACC4F45C61ED5FF1, _id_7DD6062F971AC3CC[_id_AC0E594AC96AA3A8]))) {
      _id_0E14905A4CDF3B12 = spawnStruct();
      _id_0E14905A4CDF3B12.isplayer = 0;
      _id_0E14905A4CDF3B12.isadestructable = 1;
      _id_0E14905A4CDF3B12.entity = _id_7DD6062F971AC3CC[_id_AC0E594AC96AA3A8];
      _id_0E14905A4CDF3B12.damagecenter = _id_D3366E54CC41EA6C;
      ents[ents.size] = _id_0E14905A4CDF3B12;
    }
  }

  _id_B261B594E5C09A86 = getEntArray("misc_turret", "classname");

  foreach(sentry in _id_B261B594E5C09A86) {
    _id_D3366E54CC41EA6C = sentry.origin + (0, 0, 32);
    distsq = distancesquared(pos, _id_D3366E54CC41EA6C);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_D3366E54CC41EA6C, _id_ACC4F45C61ED5FF1, sentry))) {
      switch (sentry.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          ents[ents.size] = scripts\mp\utility\damage::get_damageable_sentry(sentry, _id_D3366E54CC41EA6C);
          break;
      }
    }
  }

  mines = getEntArray("script_model", "classname");

  foreach(mine in mines) {
    if(mine.model != "projectile_bouncing_betty_grenade" && mine.model != "ims_scorpion_body") {
      continue;
    }
    _id_D3366E54CC41EA6C = mine.origin + (0, 0, 32);
    distsq = distancesquared(pos, _id_D3366E54CC41EA6C);

    if(distsq < radiussq && (!_id_7C242DFB11E2E6E6 || weapondamagetracepassed(pos, _id_D3366E54CC41EA6C, _id_ACC4F45C61ED5FF1, mine)))
      ents[ents.size] = scripts\mp\utility\damage::get_damageable_mine(mine, _id_D3366E54CC41EA6C);
  }

  return ents;
}

weapondamagetracepassed(from, to, _id_ACC4F45C61ED5FF1, ent) {
  midpos = undefined;
  _id_4573A8725DD3748E = to - from;

  if(lengthsquared(_id_4573A8725DD3748E) < _id_ACC4F45C61ED5FF1 * _id_ACC4F45C61ED5FF1)
    return 1;

  dir = vectorNormalize(_id_4573A8725DD3748E);
  midpos = from + (dir[0] * _id_ACC4F45C61ED5FF1, dir[1] * _id_ACC4F45C61ED5FF1, dir[2] * _id_ACC4F45C61ED5FF1);
  trace = scripts\engine\trace::_bullet_trace(midpos, to, 0, ent);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugmines") != 0) {
    thread debugprint(from, ".dmg");

    if(isDefined(ent))
      thread debugprint(to, "." + ent.classname);
    else
      thread debugprint(to, ".undefined");

    if(trace["fraction"] == 1)
      thread debugline(midpos, to, (1, 1, 1));
    else {
      thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
      thread debugline(trace["position"], to, (1, 0.4, 0.3));
    }
  }

  return trace["fraction"] == 1;
}

damageent(einflictor, eattacker, idamage, smeansofdeath, objweapon, damagepos, damagedir) {
  if(self.isplayer) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, objweapon, damagepos, damagedir, "none", 0);
  } else {
    if(self.isadestructable && (objweapon.basename == "artillery_mp" || objweapon.basename == "claymore_mp" || objweapon.basename == "stealth_bomb_mp")) {
      return;
    }
    self.entity notify("damage", idamage, eattacker, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, objweapon);
  }
}

debugline(a, b, color) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 600; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}

debugcircle(center, radius, color, segments) {
  if(!isDefined(segments))
    segments = 16;

  _id_7062EA7309FA49C4 = 360 / segments;
  _id_8AF33769F877B5D6 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < segments; _id_AC0E594AC96AA3A8++) {
    angle = _id_7062EA7309FA49C4 * _id_AC0E594AC96AA3A8;
    _id_8A9F895755FD607E = cos(angle) * radius;
    _id_D867033AB311670B = sin(angle) * radius;
    x = center[0] + _id_8A9F895755FD607E;
    y = center[1] + _id_D867033AB311670B;
    z = center[2];
    _id_8AF33769F877B5D6[_id_8AF33769F877B5D6.size] = (x, y, z);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AF33769F877B5D6.size; _id_AC0E594AC96AA3A8++) {
    start = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8];

    if(_id_AC0E594AC96AA3A8 + 1 >= _id_8AF33769F877B5D6.size)
      end = _id_8AF33769F877B5D6[0];
    else
      end = _id_8AF33769F877B5D6[_id_AC0E594AC96AA3A8 + 1];

    thread debugline(start, end, color);
  }
}

debugprint(_id_CDCD3178F5176585, _id_E94B62032A5AE9C3) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 600; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}

onweapondamage(einflictor, objweapon, meansofdeath, damage, eattacker) {
  self endon("death_or_disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);

  switch (_id_49E6EF3EDADD524E) {
    case "pac_sentry_turret":
    case "chopper_gunner_turret":
    case "claymore_radial":
    case "flash_grenade":
    case "concussion_grenade":
    case "thermite_av":
    case "molotov":
    case "thermite_ap":
      break;
    case "thermite":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("thermite_mp", "explosion", 0.5);
      break;
    case "frag_grenade":
    case "at_mine":
    case "claymore":
    case "semtex":
    case "c4":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("frag_grenade_mp", "explosion", 2);
      break;
    default:
      scripts\mp\shellshock::shellshockondamage(meansofdeath, damage);
      break;
  }
}

updatelastweapon() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  setlastdroppableweaponobj(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon()));

  for(;;) {
    self waittill("weapon_change", _id_82533969B4683DE4);
    self.lastweaponobj = _id_82533969B4683DE4;

    if(isnormallastweapon(_id_82533969B4683DE4))
      self.lastnormalweaponobj = _id_82533969B4683DE4;

    if(isdroppableweapon(_id_82533969B4683DE4))
      setlastdroppableweaponobj(_id_82533969B4683DE4);

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(_id_82533969B4683DE4))
      self.lastcacweaponobj = _id_82533969B4683DE4;
  }
}

isnormallastweapon(objweapon) {
  if(objweapon.basename == "none")
    return 0;

  if(objweapon.classname == "turret")
    return 0;

  if(scripts\mp\utility\weapon::issuperweapon(objweapon.basename))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
    return 0;

  if(scripts\mp\utility\weapon::isspecialmeleeweapon(objweapon))
    return 0;

  if(scripts\mp\utility\weapon::isgunlessweapon(objweapon))
    return 0;

  if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode")
    return 0;

  return 1;
}

isdroppableweapon(objweapon) {
  if(objweapon.basename == "none")
    return 0;

  if(isfistweapon(objweapon.basename))
    return 0;

  if(isbombplantweapon(objweapon.basename))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
    return 0;

  if(scripts\mp\utility\weapon::issuperweapon(objweapon.basename))
    return 0;

  if(objweapon.inventorytype != "primary")
    return 0;

  if(objweapon.classname == "turret")
    return 0;

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(objweapon.basename) && !scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon.basename))
    return 0;

  return 1;
}

updatemovespeedonweaponchange() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", _id_82533969B4683DE4);

    if(_id_82533969B4683DE4.basename == "none")
      continue;
    else if(scripts\mp\utility\weapon::issuperweapon(_id_82533969B4683DE4.basename)) {
      updatemovespeedscale();
      continue;
    } else if(_id_2669878CF5A1B6BC::iskillstreakweapon(_id_82533969B4683DE4.basename))
      continue;
    else if(_id_82533969B4683DE4.basename == "iw9_me_fists_mp_ls") {
      updatemovespeedscale();
      continue;
    } else if(_id_82533969B4683DE4.inventorytype != "primary" && _id_82533969B4683DE4.inventorytype != "altmode") {
      continue;
    }
    updatemovespeedscale();
  }
}

getweaponspeedslowest() {
  _id_6155FF1652D3374F = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      if(scripts\mp\utility\weapon::issuperweapon(weapon))
        weaponspeed = scripts\mp\supers::getmovespeedforsuperweapon(weapon);
      else if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
        weaponspeed = scripts\cp_mp\utility\killstreak_utility::_id_3F76336D7D0B7587(weapon);
      else if(scripts\mp\utility\weapon::isgamemodeweapon(weapon))
        weaponspeed = getgamemodeweaponspeed(weapon);
      else
        weaponspeed = getweaponspeed(weapon);

      if(weaponspeed == 0) {
        continue;
      }
      if(weaponspeed < _id_6155FF1652D3374F)
        _id_6155FF1652D3374F = weaponspeed;
    }
  } else
    _id_6155FF1652D3374F = 0.85;

  _id_6155FF1652D3374F = clampweaponspeed(_id_6155FF1652D3374F);
  return _id_6155FF1652D3374F;
}

getweaponspeed(weapon) {
  rootweapon = _id_2669878CF5A1B6BC::getweaponrootname(weapon);

  if(!isDefined(rootweapon) || !isDefined(level.weaponmapdata[rootweapon]) || !isDefined(level.weaponmapdata[rootweapon].speed))
    return 1.0;

  return level.weaponmapdata[rootweapon].speed;
}

getgamemodeweaponspeed(weapon) {
  return 0.93;
}

clampweaponspeed(value) {
  return clamp(value, 0.0, 1.0);
}

updateviewkickscale(_id_072BC79F0750FCA9) {
  if(isDefined(_id_072BC79F0750FCA9))
    self.viewkickscale = _id_072BC79F0750FCA9;

  if(isDefined(self.overchargeviewkickscale))
    _id_072BC79F0750FCA9 = self.overchargeviewkickscale;
  else if(isDefined(self.overrideviewkickscale)) {
    _id_072BC79F0750FCA9 = self.overrideviewkickscale;
    _id_6651DEF69449C4A3 = scripts\mp\utility\weapon::weapongetflinchtype(self getcurrentweapon());

    if(_id_6651DEF69449C4A3 == 1)
      _id_072BC79F0750FCA9 = self.overrideviewkickscalepistol;
    else if(_id_6651DEF69449C4A3 == 3)
      _id_072BC79F0750FCA9 = self.overrideviewkickscaledmr;
    else if(_id_6651DEF69449C4A3 == 4)
      _id_072BC79F0750FCA9 = self.overrideviewkickscalesniper;
  } else if(isDefined(self.viewkickscale))
    _id_072BC79F0750FCA9 = self.viewkickscale;
  else
    _id_072BC79F0750FCA9 = 1.0;

  _id_072BC79F0750FCA9 = clamp(_id_072BC79F0750FCA9, 0.0, 1.0);
  self setviewkickscale(_id_072BC79F0750FCA9);
}

updatemovespeedscale() {
  _id_8F053B6F8634C100 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    _id_8F053B6F8634C100 = 1.0;
    _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.playerstreakspeedscale;
  } else {
    _id_8F053B6F8634C100 = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale))
      _id_8F053B6F8634C100 = self.overrideweaponspeed_speedscale;

    _id_F30C40867C01E4F9 = self.chill_data;

    if(isDefined(_id_F30C40867C01E4F9) && isDefined(_id_F30C40867C01E4F9.speedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + _id_F30C40867C01E4F9.speedmod;

    if(isDefined(self.gasspeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.gasspeedmod;

    if(isDefined(self._id_2CEB4AD39CF2F904))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self._id_2CEB4AD39CF2F904;

    if(isDefined(self.disabledspeedmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.disabledspeedmod;

    if(isDefined(self.speedonkillmod))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.speedonkillmod;

    if(isDefined(self.momentumspeedincrease))
      _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.momentumspeedincrease;
  }

  self.weaponspeed = _id_8F053B6F8634C100;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + (self.movespeedscaler - 1.0);
  _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + (self.combatspeedscalar - 1.0);
  _id_8F053B6F8634C100 = clamp(_id_8F053B6F8634C100, 0.0, 1.08);

  if(isDefined(self.fastcrouchspeedmod))
    _id_8F053B6F8634C100 = _id_8F053B6F8634C100 + self.fastcrouchspeedmod;

  self setmovespeedscale(_id_8F053B6F8634C100);
}

_id_E5642864900C1064() {}

_id_DD1698252C31D637(perkname) {
  if(!isDefined(self._id_B6AD5B4211ACA6F2))
    self._id_B6AD5B4211ACA6F2 = [];

  if(scripts\engine\utility::array_contains(self._id_B6AD5B4211ACA6F2, perkname)) {
    return;
  }
  scripts\mp\utility\perk::giveperk(perkname);
  self._id_B6AD5B4211ACA6F2[self._id_B6AD5B4211ACA6F2.size] = perkname;
}

_id_EC132C173D4532EE(perkname) {
  if(isDefined(self._id_B6AD5B4211ACA6F2)) {
    _id_5DE1358070F8DAAF = 0;
    _id_716F88EFB2A15BFD = [];

    foreach(_id_780BE7DAC4190BB5 in self._id_B6AD5B4211ACA6F2) {
      if(!_id_5DE1358070F8DAAF) {
        if(_id_780BE7DAC4190BB5 == perkname) {
          scripts\mp\utility\perk::removeperk(_id_780BE7DAC4190BB5);
          _id_5DE1358070F8DAAF = 1;
          continue;
        }
      }

      _id_716F88EFB2A15BFD[_id_716F88EFB2A15BFD.size] = _id_780BE7DAC4190BB5;
    }

    self._id_B6AD5B4211ACA6F2 = _id_716F88EFB2A15BFD;
  }
}

_id_4C614E296B3A410A(perkname) {
  if(!isDefined(self._id_B6AD5B4211ACA6F2))
    return 0;

  return scripts\engine\utility::array_contains(self._id_B6AD5B4211ACA6F2, perkname);
}

getplayerspeedbyweapon(player) {
  weaponspeed = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size)
    weaponspeed = 0.85;
  else {
    objweapon = self getcurrentweapon();

    if(!isDefined(objweapon))
      weaponspeed = getweaponspeedslowest();
    else if(scripts\mp\utility\weapon::issuperweapon(objweapon.basename))
      weaponspeed = scripts\mp\supers::getmovespeedforsuperweapon(objweapon);
    else if(scripts\mp\utility\weapon::isgamemodeweapon(objweapon.basename))
      weaponspeed = getgamemodeweaponspeed(objweapon);
    else if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
      weaponspeed = scripts\cp_mp\utility\killstreak_utility::_id_3F76336D7D0B7587(objweapon);
    else if(scripts\mp\utility\weapon::isgunlessweapon(objweapon.basename))
      weaponspeed = 0.85;
    else {
      if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode" || scripts\mp\utility\weapon::ismeleeoverrideweapon(objweapon)) {
        if(isDefined(self.lastnormalweaponobj))
          objweapon = self.lastnormalweaponobj;
        else
          objweapon = undefined;
      }

      if(!self hasweapon(objweapon))
        weaponspeed = getweaponspeedslowest();
      else {
        weaponspeed = getweaponspeed(objweapon);

        if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
          class = weaponclass(objweapon);

          if(isDefined(level._id_26109C02A53CEA84) && isDefined(level._id_26109C02A53CEA84[class]))
            weaponspeed = level._id_26109C02A53CEA84[class];
        }
      }
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

stancerecoiladjuster() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");

  if(!self isconsoleplayer() && !isai(self)) {
    self notifyonplayercommand("adjustedStance", "+togglecrouch");
    self notifyonplayercommand("adjustedStance", "toggleprone");
    self notifyonplayercommand("adjustedStance", "+movedown");
    self notifyonplayercommand("adjustedStance", "-movedown");
    self notifyonplayercommand("adjustedStance", "+prone");
    self notifyonplayercommand("adjustedStance", "-prone");
  }

  for(;;) {
    scripts\engine\utility::waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
    stance = self getstance();
    stancerecoilupdate(stance);
  }
}

stancerecoilupdate(stance) {
  weapon = self getcurrentprimaryweapon();
  _id_8F7FAD0B4F9853BF = 0;

  if(isrecoilreducingweapon(weapon))
    _id_8F7FAD0B4F9853BF = getrecoilreductionvalue();

  if(stance == "prone") {
    _id_3A88DF1A7869A537 = scripts\mp\utility\weapon::getweapongroup(weapon);

    if(_id_3A88DF1A7869A537 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(_id_3A88DF1A7869A537 == "weapon_sniper") {
      if(weapon hasattachment("barrelbored")) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + _id_8F7FAD0B4F9853BF);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + _id_8F7FAD0B4F9853BF);
      return;
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
    return;
  } else if(stance == "crouch") {
    _id_3A88DF1A7869A537 = scripts\mp\utility\weapon::getweapongroup(weapon);

    if(_id_3A88DF1A7869A537 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(_id_3A88DF1A7869A537 == "weapon_sniper") {
      if(weapon hasattachment("barrelbored")) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + _id_8F7FAD0B4F9853BF);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + _id_8F7FAD0B4F9853BF);
      return;
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
    return;
  } else if(_id_8F7FAD0B4F9853BF > 0)
    scripts\mp\utility\weapon::setrecoilscale(0, _id_8F7FAD0B4F9853BF);
  else
    scripts\mp\utility\weapon::setrecoilscale();
}

deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(grenade in level.grenades) {
      if(isDefined(grenade) && !istrue(grenade.exploding) && !isplantedequipment(grenade))
        grenade delete();
    }
  }

  if(isDefined(level.missiles)) {
    foreach(missile in level.missiles) {
      if(isDefined(missile) && !istrue(missile.exploding) && !isplantedequipment(missile))
        missile delete();
    }
  }
}

minegettwohitthreshold() {
  return 80;
}

minedamagemonitor(_id_ED674BB1196F8987) {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  hits = scripts\engine\utility::_id_53C4C53197386572(_id_ED674BB1196F8987, 1);
  damagefeedback = "hitequip";

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);
    _id_7A541E653B7997DB = attacker;

    if(!isPlayer(attacker) && !isagent(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner))
        _id_7A541E653B7997DB = attacker.owner;
    }

    if(!isPlayer(_id_7A541E653B7997DB) && !isagent(_id_7A541E653B7997DB)) {
      continue;
    }
    if(isDefined(objweapon) && isendstr(objweapon.basename, "betty_mp")) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, _id_7A541E653B7997DB)) {
      continue;
    }
    if(scripts\mp\utility\damage::non_player_should_ignore_damage(_id_7A541E653B7997DB, objweapon, inflictor, type)) {
      continue;
    }
    _id_8C97D5D29E3F5523 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(objweapon, type) || damage >= 80, 2, 1);
    hits = hits - _id_8C97D5D29E3F5523;
    equipmenthit(self.owner, _id_7A541E653B7997DB, objweapon, type);

    if(hits <= 0) {
      break;
    } else
      _id_7A541E653B7997DB _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);
  }

  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(idflags) && idflags &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(idflags) && idflags &level.idflags_ricochet)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;

  if(isDefined(_id_7A541E653B7997DB))
    self.damagedby = _id_7A541E653B7997DB;

  if(isDefined(self.killcament))
    self.killcament.damagedby = _id_7A541E653B7997DB;

  if(isPlayer(_id_7A541E653B7997DB)) {
    _id_7A541E653B7997DB _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);

    if(_id_7A541E653B7997DB != self.owner && _id_7A541E653B7997DB.team != self.owner.team) {
      _id_7A541E653B7997DB scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, objweapon);
      _id_7A541E653B7997DB scripts\mp\battlechatter_mp::equipmentdestroyed(self);
      scripts\cp_mp\challenges::equipmentdestroyed(inflictor, attacker, damage, idflags, undefined, objweapon, undefined, _id_7A541E653B7997DB.modifiers);
    }
  }

  if(level.teambased) {
    if(!istrue(self._id_E926ABD3E5970492) && isDefined(_id_7A541E653B7997DB) && isDefined(_id_7A541E653B7997DB.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(_id_7A541E653B7997DB.pers["team"] != self.owner.pers["team"])
        _id_7A541E653B7997DB notify("destroyed_equipment");
    }
  } else if(isDefined(self.owner) && isDefined(_id_7A541E653B7997DB) && _id_7A541E653B7997DB != self.owner)
    _id_7A541E653B7997DB notify("destroyed_equipment");

  scripts\cp_mp\challenges::minedestroyed(self, _id_7A541E653B7997DB, type);
  self notify("detonateExplosive", _id_7A541E653B7997DB);
}

mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait(level.mineselfdestructtime + randomfloat(0.4));
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", attacker);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(attacker))
    attacker = self.owner;

  config = self.config;
  vfxtag = config.vfxtag;

  if(!isDefined(vfxtag))
    vfxtag = "tag_fx";

  tagorigin = self gettagorigin(vfxtag);

  if(!isDefined(tagorigin))
    tagorigin = self gettagorigin("tag_origin");

  self notify("explode", tagorigin);
  waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(config.onexplodefunc))
    self thread[[config.onexplodefunc]]();

  if(isDefined(config.onexplodesfx))
    self playSound(config.onexplodesfx);

  onexplodevfx = scripts\engine\utility::ter_op(isDefined(config.onexplodevfx), config.onexplodevfx, level.mine_explode);
  playFX(onexplodevfx, tagorigin);
  minedamagemin = scripts\engine\utility::ter_op(isDefined(config.minedamagemin), config.minedamagemin, level.minedamagemin);
  minedamagemax = scripts\engine\utility::ter_op(isDefined(config.minedamagemax), config.minedamagemax, level.minedamagemax);
  minedamageradius = scripts\engine\utility::ter_op(isDefined(config.minedamageradius), config.minedamageradius, level.minedamageradius);

  if(minedamagemax > 0)
    self radiusdamage(self.origin, minedamageradius, minedamagemax, minedamagemin, attacker, "MOD_EXPLOSIVE", self.weapon_name);

  if(isDefined(self.owner))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);

  wait 0.2;
  deleteexplosive();
}

deleteplacedequipment(_id_475474534FBA73EF) {
  if(isDefined(self.plantedlethalequip)) {
    foreach(_id_2EB789D043254817 in self.plantedlethalequip) {
      if(isDefined(_id_2EB789D043254817))
        _id_2EB789D043254817 deleteexplosive();
    }
  }

  self.plantedlethalequip = [];

  if(isDefined(self.plantedtacticalequip)) {
    foreach(_id_2EB789D043254817 in self.plantedtacticalequip) {
      if(isDefined(_id_2EB789D043254817))
        _id_2EB789D043254817 deleteexplosive();
    }
  }

  self.plantedtacticalequip = [];
  _id_8442DBB6E918259F = scripts\mp\utility\game::isanymlgmatch();

  if(isDefined(_id_475474534FBA73EF))
    _id_8442DBB6E918259F = _id_475474534FBA73EF;

  if(isDefined(self.plantedhackedequip)) {
    foreach(index, _id_2EB789D043254817 in self.plantedhackedequip) {
      if(isDefined(_id_2EB789D043254817) && (!_id_8442DBB6E918259F || !istrue(_id_2EB789D043254817.issuper))) {
        _id_2EB789D043254817 deleteexplosive();
        self.plantedhackedequip[index] = undefined;
      }
    }

    self.plantedhackedequip = scripts\engine\utility::array_removeundefined(self.plantedhackedequip);
  }

  if(_id_8442DBB6E918259F && isDefined(self.plantedsuperequip)) {
    foreach(index, _id_2EB789D043254817 in self.plantedsuperequip) {
      _id_2EB789D043254817 deleteexplosive();
      self.plantedsuperequip[index] = undefined;
    }

    self.plantedsuperequip = scripts\engine\utility::array_removeundefined(self.plantedsuperequip);
  }
}

deletedisparateplacedequipment() {
  _id_0E8F6FDB8F100FF7 = scripts\mp\equipment::getcurrentequipment("primary");

  foreach(_id_2EB789D043254817 in self.plantedlethalequip) {
    if(isDefined(_id_2EB789D043254817)) {
      if(!isDefined(_id_2EB789D043254817.equipmentref) || !isDefined(_id_0E8F6FDB8F100FF7) || _id_2EB789D043254817.equipmentref != _id_0E8F6FDB8F100FF7)
        _id_2EB789D043254817 deleteexplosive();
    }
  }

  tactical = scripts\mp\equipment::getcurrentequipment("secondary");

  foreach(_id_2EB789D043254817 in self.plantedtacticalequip) {
    if(isDefined(_id_2EB789D043254817)) {
      if(!isDefined(_id_2EB789D043254817.equipmentref) || !isDefined(tactical) || _id_2EB789D043254817.equipmentref != tactical)
        _id_2EB789D043254817 deleteexplosive();
    }
  }
}

equipmentdeletevfx(position, angles) {
  if(isDefined(position)) {
    if(isDefined(angles)) {
      forward = anglesToForward(angles);
      up = anglestoup(angles);
      playFX(scripts\engine\utility::getfx("equipment_explode"), position, forward, up);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), position, forward, up);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), position);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), position);
    }

    playsoundatpos(position, "mp_killstreak_disappear");
  } else if(isDefined(self)) {
    origin = self.origin;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), origin, forward, up);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), origin, forward, up);
    self playSound("mp_killstreak_disappear");
  }
}

grenadestuckto(grenade, stuckto, _id_05F6265D8D7EE3C8) {
  if(!isDefined(grenade)) {
    return;
  }
  if(!isDefined(self)) {
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    stuckto.stuckbygrenadeowner = grenade.owner;
  } else if(level.teambased && scripts\engine\utility::is_equal(stuckto.team, self.team))
    grenade.isstuck = "friendly";
  else {
    _id_D658F0B6BC4FD513 = undefined;
    _id_0D5F11D86F917656 = undefined;

    if(isDefined(grenade.weapon_name)) {
      switch (grenade.weapon_name) {
        case "semtex_mp":
          _id_D658F0B6BC4FD513 = "semtex_stuck";
          _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
          break;
        case "molotov_mp":
          _id_D658F0B6BC4FD513 = "molotov_stuck";
          _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
          break;
        case "thermite_mp":
          _id_D658F0B6BC4FD513 = "thermite_attacker_stuck";
          _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
          break;
        case "sonar_pulse_mp":
          _id_D658F0B6BC4FD513 = "sonar_pulse_stuck";
          break;
        case "shock_stick_mp":
          _id_D658F0B6BC4FD513 = "shock_stick_stuck";
          _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
          break;
        case "bunkerbuster_mp":
        case "bunkerbuster_burrowed_mp":
          _id_D658F0B6BC4FD513 = "bunkerbuster_stuck";
          _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
          break;
      }
    }

    grenade.isstuck = "enemy";
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    stuckto.stuckbygrenadeowner = grenade.owner;
    self notify("grenade_stuck_enemy");

    if(isDefined(_id_0D5F11D86F917656))
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(stuckto, _id_0D5F11D86F917656);

    if(!istrue(_id_05F6265D8D7EE3C8))
      grenadestucktosplash(_id_D658F0B6BC4FD513, stuckto);
  }
}

grenadestucktosplash(_id_D658F0B6BC4FD513, stuckto) {
  player = self;

  if((isPlayer(stuckto) || isagent(stuckto)) && isDefined(_id_D658F0B6BC4FD513)) {
    if(isDefined(player.owner))
      player = player.owner;

    player scripts\mp\hud_message::showsplash(_id_D658F0B6BC4FD513, undefined, undefined, undefined, 1, undefined, 1);
  }

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_3B7863DCDFF98B13");
}

outlineequipmentforowner(equipment) {}

outlinesuperequipment(equipment, player) {
  if(level.teambased)
    thread outlinesuperequipmentforteam(equipment, player);
  else
    thread outlinesuperequipmentforplayer(equipment, player);
}

outlinesuperequipmentforteam(equipment, player) {
  id = scripts\mp\utility\outline::outlineenableforteam(equipment, player.team, "outline_nodepth_cyan", "killstreak");
  equipment waittill("death");
  scripts\mp\utility\outline::outlinedisable(id, equipment);
}

outlinesuperequipmentforplayer(equipment, player) {
  id = scripts\mp\utility\outline::outlineenableforplayer(equipment, player, "outline_nodepth_cyan", "killstreak");
  equipment waittill("death");
  scripts\mp\utility\outline::outlinedisable(id, equipment);
}

grenadeheldatdeath() {
  return istrue(self.grenadeheldatdeath);
}

grenadehealthatdeathframeupdatecallback() {
  self.grenadeheldatdeath = !isnullweapon(self getheldoffhand());
}

trace_impale(vpoint, endpoint) {
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  trace = scripts\engine\trace::ray_trace_detail(vpoint, endpoint, level.players, contents, undefined, 1);
  return trace;
}

impale_endpoint(vpoint, vdir) {
  endpoint = vpoint + vdir * 4096;
  return endpoint;
}

impale(eattacker, _id_E851FFA44B7E0D54, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  _id_E851FFA44B7E0D54 endon("death_or_disconnect");

  if(!isDefined(_id_E851FFA44B7E0D54.body)) {
    return;
  }
  playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), vpoint);
  endpoint = impale_endpoint(vpoint, vdir);
  trace = trace_impale(vpoint, endpoint);
  endpoint = trace["position"] - vdir * 12;
  _id_80C97B146B16BE3F = length(endpoint - vpoint);
  flighttime = _id_80C97B146B16BE3F / 1000;
  flighttime = max(flighttime, 0.05);

  if(trace["hittype"] != "hittype_world")
    flighttime = 0;

  _id_6CB8A80078D195D0 = flighttime > 0.05;

  if(isDefined(_id_E851FFA44B7E0D54))
    _id_E851FFA44B7E0D54.body startragdoll();

  waitframe();

  if(_id_6CB8A80078D195D0) {
    _id_A0480A10EE4E345F = vdir;
    _id_C323F0CB880A051F = anglestoup(eattacker.angles);
    _id_C1148FF802BE2880 = vectorcross(_id_A0480A10EE4E345F, _id_C323F0CB880A051F);
    _id_483E4E4E5B094BE2 = scripts\engine\utility::spawn_tag_origin(vpoint, axistoangles(_id_A0480A10EE4E345F, _id_C1148FF802BE2880, _id_C323F0CB880A051F));
    _id_483E4E4E5B094BE2 moveTo(endpoint, flighttime);
    _id_D04F3DA69954A74E = spawnragdollconstraint(_id_E851FFA44B7E0D54.body, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
    _id_D04F3DA69954A74E.origin = _id_483E4E4E5B094BE2.origin;
    _id_D04F3DA69954A74E.angles = _id_483E4E4E5B094BE2.angles;
    _id_D04F3DA69954A74E linkTo(_id_483E4E4E5B094BE2);

    if(flighttime > 1)
      thread impale_detachaftertime(_id_D04F3DA69954A74E, 1);

    thread impale_cleanup(_id_E851FFA44B7E0D54, _id_483E4E4E5B094BE2, flighttime + 0.25);
    _id_483E4E4E5B094BE2 thread impale_effects(endpoint, flighttime);
  }
}

impale_detachaftertime(_id_D04F3DA69954A74E, time) {
  wait(time);

  if(isDefined(_id_D04F3DA69954A74E))
    _id_D04F3DA69954A74E delete();
}

impale_effects(endpoint, time) {
  wait(clamp(time - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), endpoint);
}

impale_cleanup(_id_E851FFA44B7E0D54, _id_483E4E4E5B094BE2, time) {
  if(isDefined(_id_E851FFA44B7E0D54))
    _id_E851FFA44B7E0D54 scripts\engine\utility::waittill_any_timeout_1(time, "death_or_disconnect");

  _id_483E4E4E5B094BE2 delete();
}

codecallback_getprojectilespeedscale(_id_CF87D5DCE2780061, objweapon) {
  return [1.0, 1.0];
}

setplayerstunned() {
  if(!isDefined(self.isstunned))
    self.isstunned = 1;
  else
    self.isstunned++;
}

setplayerunstunned() {
  self.isstunned--;
}

isstunned() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["concussion_grenade_mp"]);
}

setplayerblinded() {
  if(!isDefined(self.isblinded))
    self.isblinded = 1;
  else
    self.isblinded++;
}

setplayerunblinded() {
  self.isblinded--;
}

isblinded() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["flash_grenade_mp"]);
}

isblindedby(player) {
  if(!isDefined(player))
    return 0;

  weapon = "flash_grenade_mp";
  entnum = player getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[weapon]) && isDefined(self.debuffedbyplayers[weapon][entnum]))
    return 1;

  return 0;
}

isstunnedby(player) {
  if(!isDefined(player))
    return 0;

  weapon = "concussion_grenade_mp";
  entnum = player getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[weapon]) && isDefined(self.debuffedbyplayers[weapon][entnum]))
    return 1;

  return 0;
}

isstunnedorblinded() {
  return isblinded() || isstunned();
}

cleanupconcussionstun(time) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait(time);
  setplayerunstunned();
}

applyweaponsonicstun() {
  self endon("death_or_disconnect");
  wait 0.1;

  if(isDefined(self) && isPlayer(self) && !isbot(self)) {
    self playlocalsound("sonic_shotgun_debuff");
    self setsoundsubmix("sonic_shotgun_impact");
  }
}

watchinvalidweaponchange() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_switch_invalid", _id_DDF65301F7D23098);
    currentweapon = self getcurrentweapon();

    if(currentweapon.inventorytype == "item" || currentweapon.inventorytype == "exclusive")
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
  }
}

weaponhasselectableoptic(fullweaponname) {
  rootweapon = _id_2669878CF5A1B6BC::getweaponrootname(fullweaponname);
  attachments = getweaponattachments(fullweaponname);

  foreach(attachment in attachments) {
    group = attachmentgroup(attachment);

    if(group == "rail") {
      if(scripts\mp\utility\weapon::attachmentisselectable(rootweapon, attachment))
        return 1;
    }
  }

  return 0;
}

watchdropweapons() {
  self endon("disconnect");
  self notify("watchDropWeapons");
  self endon("watchDropWeapons");

  for(;;) {
    self waittill("weapon_dropped", _id_47DCFBC98E2103EE, objweapon);

    if(isDefined(_id_47DCFBC98E2103EE) && isDefined(objweapon) && (!scripts\mp\utility\weapon::ismeleeonly(objweapon) && !scripts\mp\utility\weapon::ismeleeoverrideweapon(objweapon) && !scripts\cp_mp\utility\weapon_utility::isknifeonly(objweapon) || scripts\cp_mp\utility\weapon_utility::_id_F0CF737B5D0CCDA5(objweapon))) {
      if(_id_47DCFBC98E2103EE physics_getnumbodies() > 0) {
        _id_47DCFBC98E2103EE physics_registerforcollisioncallback();
        _id_47DCFBC98E2103EE thread weapondrop_physics_callback_monitor();
      }
    }
  }
}

weapondrop_physics_callback_monitor() {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
  surfacetype = scripts\engine\utility::_id_53C4C53197386572(_id_895F3C282BC9FC68["name"], "");
  _id_D6AD99E9C47D89E6 = self.classname;
  _id_164379DA1F8761C0 = "";

  if(isDefined(self.objweapon) && isstring(self.objweapon.basename) && isstring(self.objweapon.material)) {
    _id_D6AD99E9C47D89E6 = self.objweapon.basename;
    _id_164379DA1F8761C0 = self.objweapon.material;
  }

  _id_E7DBBE9220D5E27B(surfacetype, _id_D6AD99E9C47D89E6, _id_164379DA1F8761C0);
}

_id_E7DBBE9220D5E27B(surfacetype, _id_D6AD99E9C47D89E6, _id_164379DA1F8761C0) {
  surfacetype = _func_2E84A570D6AF300A(surfacetype, "surftype_");
  _id_D6AD99E9C47D89E6 = _func_2E84A570D6AF300A(_id_D6AD99E9C47D89E6, "weapon_");

  if(isstartstr(surfacetype, "user_terrain")) {
    _id_09F558BB94AEC6F2 = _func_95C6391212A25F7C(_func_2E84A570D6AF300A(surfacetype, "user_terrain"), "_");
    surfacetype = "user_terrain_" + _id_09F558BB94AEC6F2;
  }

  _id_67F14F8315CB0F2F = strtok(_id_D6AD99E9C47D89E6, "_");
  _id_BDA0554655BFA690 = scripts\engine\utility::_id_53C4C53197386572(_id_67F14F8315CB0F2F[1], "");
  _id_DE509E292A5C1450 = scripts\engine\utility::_id_53C4C53197386572(level._id_20F39C8ACB381AD5[_id_BDA0554655BFA690], "weap_drop_med");
  _id_EE1BE0B772426CA7 = _id_BDA0554655BFA690 == "ar" || _id_BDA0554655BFA690 == "sm" || _id_BDA0554655BFA690 == "sh" || _id_BDA0554655BFA690 == "pi";
  _id_F4E5C6A725490A8D = _id_EE1BE0B772426CA7 && isstring(_id_164379DA1F8761C0) && _id_164379DA1F8761C0 == "polymer";

  if(istrue(_id_F4E5C6A725490A8D))
    _id_DE509E292A5C1450 = _id_DE509E292A5C1450 + "_poly";

  if(_id_67F14F8315CB0F2F[2] == "sword01" || _id_67F14F8315CB0F2F[2] == "kamas" || _id_67F14F8315CB0F2F[2] == "pickaxe")
    _id_DE509E292A5C1450 = "weap_drop_sword";

  if(soundexists(_id_DE509E292A5C1450))
    self playsurfacesound(_id_DE509E292A5C1450, surfacetype);
  else {}
}

weapondrop_physics_timeout(time) {
  wait(time);
  self notify("timeout");
}

watchgrenadeaxepickup(player, _id_B37714A572B93F0E) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.weapon_name) && isDefined(_id_B37714A572B93F0E))
    self.weapon_name = _id_B37714A572B93F0E;

  self waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto))) {
    _id_E24A4C740B224AA0 = _id_16A48D7056E5C472 == "tag_flicker";
    _id_853178727321999C = stuckto scripts\mp\utility\perk::_hasperk("specialty_rearguard") && _id_16A48D7056E5C472 == "tag_origin";
    _id_E13E382321A8580B = isDefined(_id_16A48D7056E5C472) && (_id_E24A4C740B224AA0 || _id_853178727321999C);
    _id_582286AF4FFE5B36 = isDefined(_id_16A48D7056E5C472) && _id_16A48D7056E5C472 == "tag_weapon";

    if(_id_E13E382321A8580B) {
      playFX(scripts\engine\utility::getfx("shield_metal_impact"), self.origin);

      if(isDefined(self.owner)) {
        _id_3F6103D9666B07CC = self.owner;
        relaunchaxe(self.weapon_name, _id_3F6103D9666B07CC);
        return;
      }
    } else if(!istrue(_id_E13E382321A8580B) && isPlayer(stuckto) && !scripts\mp\utility\player::isreallyalive(stuckto) && (level.mapname == "mp_neon" || istrue(level.ragdollzerog)))
      return;
  }

  _id_25E0203A75558ABA = 45;
  thread watchaxetimeout(_id_25E0203A75558ABA);
  thread watchgrenadedeath();
  objweapon = makeweaponfromstring(self.weapon_name);
  thread watchaxeuse(player, objweapon);
  thread watchaxeautopickup(player, objweapon);
}

axedetachfromcorpse(_id_B368413898131A3C) {
  level endon("game_ended");
  _id_BE8AC1D2583CAEF7 = _id_B368413898131A3C getlinkedchildren();

  foreach(ent in _id_BE8AC1D2583CAEF7) {
    if(!isDefined(ent)) {
      continue;
    }
    weaponname = ent.weapon_name;
    _id_3F6103D9666B07CC = ent.owner;
    _id_8802742623974077 = ent.origin;

    if(isDefined(weaponname) && scripts\mp\utility\weapon::isaxeweapon(weaponname))
      ent relaunchaxe(weaponname, _id_3F6103D9666B07CC);
  }
}

relaunchaxe(weaponname, _id_3F6103D9666B07CC) {
  self unlink();
  _id_8EE870EB33C71CD1 = scripts\mp\utility\weapon::getweaponbasenamescript(weaponname);
  _id_61D4C6A9EEE46112 = getsubstr(weaponname, _id_8EE870EB33C71CD1.size);
  _id_45D1215A74E32613 = _id_3F6103D9666B07CC scripts\mp\utility\weapon::_launchgrenade("iw7_axe_mp_dummy" + _id_61D4C6A9EEE46112, self.origin, (0, 0, 0), 100, 1, self);
  _id_45D1215A74E32613 setentityowner(_id_3F6103D9666B07CC);
  _id_45D1215A74E32613 thread watchgrenadeaxepickup(_id_3F6103D9666B07CC, self.weapon_name);
}

watchaxetimeout(timeoutduration) {
  self endon("death");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeoutduration);
  self delete();
}

watchaxeautopickup(player, weapon) {
  self endon("death");
  level endon("game_ended");
  trigger = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  trigger enablelinkTo();
  trigger linkTo(self);
  self.knife_trigger = trigger;
  trigger endon("death");

  for(;;) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player playercanautopickupaxe(self)) {
      player playerpickupaxe(weapon, 1);
      self delete();
      break;
    }
  }
}

watchaxeuse(player, weapon) {
  self endon("death");
  level endon("game_ended");
  useobj = spawn("script_model", self.origin);
  useobj linkTo(self);
  self.useobj_trigger = useobj;
  useobj makeusable();
  useobj setCursorHint("HINT_NOICON");
  useobj sethintonobstruction("show");
  useobj setHintString(&"WEAPON/PICKUP_AXE");
  useobj sethintdisplayfov(360);
  useobj setusefov(360);
  useobj sethintdisplayrange(64);
  useobj setuserange(64);
  useobj setusepriority(0);
  useobj waittill("trigger", player);
  player playerpickupaxe(weapon, 0);
  self delete();
}

playercanautopickupaxe(_id_44DE964E96E8EC24) {
  if(isDefined(_id_44DE964E96E8EC24.owner) && self != _id_44DE964E96E8EC24.owner)
    return 0;

  _id_849C1DF4114E0A37 = self getweaponslistprimaries();
  _id_D2472BB1C9E89DEE = 0;
  _id_D3CCA4D847BE4FA4 = 0;

  foreach(weapon in _id_849C1DF4114E0A37) {
    if(scripts\mp\utility\weapon::isaxeweapon(weapon) && self getweaponammoclip(weapon) == 0) {
      _id_D2472BB1C9E89DEE = 1;
      break;
    }

    if(issubstr(weapon.basename, "iw9_me_fists_mp")) {
      _id_D2472BB1C9E89DEE = 1;
      break;
    }

    if(!weapon.isalternate)
      _id_D3CCA4D847BE4FA4++;
  }

  if(_id_D3CCA4D847BE4FA4 < 2)
    _id_D2472BB1C9E89DEE = 1;

  return _id_D2472BB1C9E89DEE;
}

playerpickupaxe(objweapon, _id_796C07FE4C856A8E) {
  _id_AAA00E27A60773A1 = objweapon getnoaltweapon();
  currentweapon = self getcurrentweapon();
  _id_849C1DF4114E0A37 = self getweaponslistprimaries();

  if(self hasweapon(objweapon)) {
    _id_7EF185D0CBFCE036 = self getweaponammoclip(objweapon);

    if(!_id_796C07FE4C856A8E && _id_7EF185D0CBFCE036 > 0) {
      self dropitem(objweapon);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_AAA00E27A60773A1);
    } else if(!issubstr(currentweapon.basename, objweapon.basename)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(objweapon);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_AAA00E27A60773A1);
    }

    _id_3BCEDEE676D43CF1 = self getweaponammoclip(currentweapon) == 0 && scripts\mp\utility\weapon::isaxeweapon(currentweapon);
    _id_8A1EF5886931AF59 = issubstr(currentweapon.basename, "iw9_me_fists_mp");

    if(!_id_796C07FE4C856A8E || _id_8A1EF5886931AF59 || _id_3BCEDEE676D43CF1)
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_AAA00E27A60773A1);

    self setweaponammoclip(_id_AAA00E27A60773A1, 1);
    scripts\mp\hud_message::showmiscmessage("axe");
    return;
  }

  _id_53C6DCC71B89288F = undefined;
  _id_303858271584EB48 = 0;

  foreach(weapon in _id_849C1DF4114E0A37) {
    if(weapon.isalternate) {
      continue;
    }
    if(issubstr(weapon.basename, "uplinkball")) {
      continue;
    }
    _id_CB54202AF3C4E5B8 = self getweaponammoclip(weapon) == 0 && scripts\mp\utility\weapon::isaxeweapon(weapon);

    if(!isDefined(_id_53C6DCC71B89288F) && (weaponispreferreddrop(weapon) || _id_CB54202AF3C4E5B8))
      _id_53C6DCC71B89288F = weapon;

    _id_303858271584EB48++;
  }

  _id_0EC22A950F210E39 = undefined;

  if(isDefined(_id_53C6DCC71B89288F))
    _id_0EC22A950F210E39 = _id_53C6DCC71B89288F;
  else if(_id_303858271584EB48 >= 2)
    _id_0EC22A950F210E39 = currentweapon;

  _id_107F42911B64CCB4 = !_id_796C07FE4C856A8E || isDefined(_id_0EC22A950F210E39) && issubstr(currentweapon.basename, _id_0EC22A950F210E39.basename);

  if(isDefined(_id_0EC22A950F210E39)) {
    _id_CB54202AF3C4E5B8 = self getweaponammoclip(_id_0EC22A950F210E39) == 0 && scripts\mp\utility\weapon::isaxeweapon(_id_0EC22A950F210E39);
    _id_4DC7FA49D0968728 = _id_0EC22A950F210E39.basename == "iw9_me_fists_mp";
    candrop = weaponcandrop(_id_0EC22A950F210E39) && !_id_CB54202AF3C4E5B8;

    if(candrop) {
      _id_76F4143215683892 = self dropitem(_id_0EC22A950F210E39);

      if(isDefined(_id_76F4143215683892)) {
        _id_5454C4BDCBD350A7 = getcompleteweaponname(_id_0EC22A950F210E39);

        if(isDefined(self.tookweaponfrom[_id_5454C4BDCBD350A7])) {
          _id_76F4143215683892.owner = self.tookweaponfrom[_id_5454C4BDCBD350A7];
          self.tookweaponfrom[_id_5454C4BDCBD350A7] = undefined;
        } else
          _id_76F4143215683892.owner = self;

        _id_76F4143215683892.targetname = "dropped_weapon";
        _id_76F4143215683892.objweapon = _id_0EC22A950F210E39;
        _id_76F4143215683892 thread watchpickup(self);
        _id_76F4143215683892 thread deletepickupafterawhile();
      }
    } else if(!candrop && !(_id_4DC7FA49D0968728 && _id_303858271584EB48 < 2) && !(_id_CB54202AF3C4E5B8 && _id_303858271584EB48 < 2))
      self takeweapon(_id_0EC22A950F210E39);
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_AAA00E27A60773A1);
  self setweaponammoclip(_id_AAA00E27A60773A1, 1);

  if(_id_107F42911B64CCB4)
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_AAA00E27A60773A1);

  scripts\mp\hud_message::showmiscmessage("axe");
  fixupplayerweapons(self, _id_AAA00E27A60773A1);
}

callback_finishweaponchange(_id_82533969B4683DE4, _id_492B944276064F63, _id_6F14F21684B6976D, _id_14F4860C3D155D12) {
  updatecamoscripts(_id_82533969B4683DE4, _id_492B944276064F63);
  updateweaponscriptvfx(_id_82533969B4683DE4, _id_492B944276064F63, _id_6F14F21684B6976D, _id_14F4860C3D155D12);
  _id_BC42FC3407BF9B82 = self.weaponchangecallbacks;

  if(isDefined(_id_BC42FC3407BF9B82)) {
    foreach(callback in _id_BC42FC3407BF9B82.callbacks)
    self[[callback]](_id_82533969B4683DE4, _id_492B944276064F63);

    foreach(callback in _id_BC42FC3407BF9B82.oneshotcallbacks)
    self[[callback]](_id_82533969B4683DE4, _id_492B944276064F63);

    _id_BC42FC3407BF9B82.oneshotcallbacks = [];
  }
}

updateweaponscriptvfx(_id_DD515FCF025B2E79, _id_F0FFAFCA5D927A12, _id_6F14F21684B6976D, _id_14F4860C3D155D12) {
  if((_id_F0FFAFCA5D927A12.basename == "none" || _id_F0FFAFCA5D927A12.basename == "alt_none") && isDefined(self.lastdroppableweapon)) {
    if(_id_F0FFAFCA5D927A12 == "alt_none")
      _id_14F4860C3D155D12 = 1;
    else
      _id_14F4860C3D155D12 = 0;

    _id_F0FFAFCA5D927A12 = self.lastdroppableweapon;
  }

  clearweaponscriptvfx(_id_F0FFAFCA5D927A12, _id_14F4860C3D155D12);
  runweaponscriptvfx(_id_DD515FCF025B2E79, _id_6F14F21684B6976D);
}

runweaponscriptvfx(_id_DD515FCF025B2E79, _id_6F14F21684B6976D) {
  if(!isDefined(_id_DD515FCF025B2E79)) {
    return;
  }
  if(isDefined(_id_6F14F21684B6976D) && _id_6F14F21684B6976D == 1)
    _id_3ECEB0EB18D0E47B = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(_id_DD515FCF025B2E79);
  else
    _id_3ECEB0EB18D0E47B = scripts\mp\utility\weapon::getweaponbasenamescript(_id_DD515FCF025B2E79);
}

clearweaponscriptvfx(_id_F0FFAFCA5D927A12, _id_14F4860C3D155D12) {
  if(!isDefined(_id_F0FFAFCA5D927A12)) {
    return;
  }
  if(isDefined(_id_14F4860C3D155D12) && _id_14F4860C3D155D12 == 1)
    _id_BF67671CE57D3A6C = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(_id_F0FFAFCA5D927A12);
  else
    _id_BF67671CE57D3A6C = scripts\mp\utility\weapon::getweaponbasenamescript(_id_F0FFAFCA5D927A12);

  switch (_id_BF67671CE57D3A6C) {
    case "iw8_sn_delta_mp":
    case "iw8_sm_uzulu_mp":
    case "iw8_sm_mpapa7_mp":
    case "iw8_sm_beta_mp":
    case "iw8_sm_augolf_mp":
    case "iw8_sm_mpapa5_mp":
    case "iw8_sm_papa90_mp":
    case "iw8_sh_oscar12_mp":
    case "iw8_sh_charlie725_mp":
    case "iw8_sh_dpapa12_mp":
    case "iw8_pi_papa320_mp":
    case "iw8_pi_decho_mp":
    case "iw8_pi_cpapa_mp":
    case "iw8_pi_mike1911_mp":
    case "iw8_pi_golf21_mp":
    case "iw8_lm_pkilo_mp":
    case "iw8_lm_mgolf34_mp":
    case "iw8_lm_lima86_mp":
    case "iw8_lm_kilo121_mp":
    case "iw8_ar_scharlie_mp":
    case "iw8_ar_mcharlie_mp":
    case "iw8_ar_falpha_mp":
    case "iw8_ar_falima_mp":
    case "iw8_ar_asierra12_mp":
    case "iw8_sn_sbeta_mp":
    case "iw8_sn_mike14_mp":
    case "iw8_sn_kilo98_mp":
    case "iw8_sn_alpha50_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_ar_mike4_mp":
    case "iw8_la_mike32_mp":
    case "iw8_ar_akilo47_mp":
    case "iw9_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
      break;
  }
}

updatecamoscripts(_id_82533969B4683DE4, _id_492B944276064F63) {
  clearcamoscripts(getweaponcamoname(_id_492B944276064F63));
  runcamoscripts(getweaponcamoname(_id_82533969B4683DE4));
}

runcamoscripts(camo) {
  if(!isDefined(camo)) {
    return;
  }
  switch (camo) {
    case "camo84":
      thread blood_camo_84();
      break;
  }
}

clearcamoscripts(camo) {
  if(!isDefined(camo)) {
    return;
  }
  switch (camo) {
    case "camo84":
      self notify("blood_camo_84");
      break;
  }
}

blood_camo_84() {
  self endon("death_or_disconnect");
  self endon("blood_camo_84");

  if(isDefined(self.bloodcamokillcount))
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  else
    self.bloodcamokillcount = 0;

  while(self.bloodcamokillcount < 13) {
    self waittill("kill_event_buffered");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  }
}

getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

init_function_refs() {
  level.getactiveequipmentarray = ::getactiveequipmentarray;
}

doesshareammo(objweapon) {
  return objweapon.isalternate && !issubstr(objweapon.underbarrel, "gl") && issubstr(objweapon.underbarrel, "shotgun");
}

waittill_grenade_throw() {
  for(;;) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(!scripts\mp\utility\weapon::grenadethrown(grenade)) {
      continue;
    }
    grenadeinitialize(grenade, objweapon, tickpercent, originalowner);

    if(isDefined(originalowner) && originalowner != self)
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_84AFBF61450B581D");

    self._id_318E9ED18014AADA = gettime();
    self._id_9DF92C66C8402503 = grenade;
    self notify("grenade_thrown", grenade);
    return grenade;
  }
}

grenadeinitialize(grenade, weapon_object, tickpercent, originalowner) {
  if(!isDefined(grenade.weapon_object))
    grenade.weapon_object = weapon_object;

  if(!isDefined(grenade.weapon_name))
    grenade.weapon_name = weapon_object.basename;

  if(!isDefined(grenade.owner))
    grenade.owner = self;

  if(!isDefined(grenade.team))
    grenade.team = self.team;

  if(!isDefined(grenade.tickpercent))
    grenade.tickpercent = tickpercent;

  if(!isDefined(grenade.ticks) && isDefined(grenade.tickpercent))
    grenade.ticks = scripts\mp\utility\script::roundup(4 * tickpercent);

  equipmentref = scripts\mp\equipment::getequipmentreffromweapon(weapon_object);

  if(isDefined(equipmentref)) {
    grenade.equipmentref = equipmentref;
    grenade.isequipment = 1;
    grenade._id_D442547D75DFFD09 = scripts\mp\equipment::_id_2113B6F7CB462692(grenade.weapon_name);

    if(equipmentref == "equip_smoke")
      grenade.owner scripts\mp\utility\stats::incpersstat("smokesUsed", 1);
  }

  grenade.threwback = isDefined(originalowner);
}

waittill_missile_fire() {
  self waittill("missile_fire", missile, objweapon);

  if(isDefined(missile)) {
    if(!isDefined(missile.weapon_name)) {
      if(objweapon.isalternate) {
        missile.weapon_name = scripts\mp\utility\weapon::getaltmodeweapon(objweapon);
        missile._id_939636F512801E8E = scripts\mp\utility\weapon::_id_B53839DC08A64FDE(objweapon);
      } else
        missile.weapon_name = objweapon.basename;
    }

    if(!isDefined(missile.owner))
      missile.owner = self;

    if(!isDefined(missile.team))
      missile.team = self.team;
  }

  return [objweapon, missile];
}

enableburnfx(_id_0E63D4B8BBF87B92, _id_EE8FA35DAEDF8C6B) {
  if(!isDefined(self.burnfxstates))
    self.burnfxstates = [];

  if(!isDefined(_id_EE8FA35DAEDF8C6B))
    _id_EE8FA35DAEDF8C6B = "active";

  if(!istrue(_id_0E63D4B8BBF87B92))
    thread enableburnsfx();

  self.burnfxstates[getburnfxstatepriority(_id_EE8FA35DAEDF8C6B)] = _id_EE8FA35DAEDF8C6B;
  startburnfx();
}

getburnfxstatepriority(state) {
  switch (state) {
    case "nuke_active":
      return 3;
    case "wp_active":
      return 2;
    case "active":
      return 1;
    default:
      return 0;
  }
}

gethightestpriotiryactiveburnstate(burnfxstates) {
  _id_AC0E594AC96AA3A8 = 3;

  for(_id_045CF691069C4E2C = undefined; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    if(isDefined(burnfxstates[_id_AC0E594AC96AA3A8])) {
      _id_045CF691069C4E2C = burnfxstates[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return _id_045CF691069C4E2C;
}

enableburnsfx() {
  self notify("updateBurnSFX");
  self endon("death_or_disconnect");
  self endon("updateBurnSFX");

  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    if(isDefined(self.burnsfx)) {
      self.burnsfx playLoopSound("iw9_weap_molotov_fire_enemy_burn");
      self.burnsfxenabled = 1;
    }
  }
}

enableburnfxfortime(duration, _id_EE8FA35DAEDF8C6B) {
  if(!isDefined(_id_EE8FA35DAEDF8C6B))
    _id_EE8FA35DAEDF8C6B = "active";

  _id_67D4FCE90B90214A = "endon_burnfxForTime_" + _id_EE8FA35DAEDF8C6B;
  self notify(_id_67D4FCE90B90214A);
  self endon("disconnect");
  self endon("clearBurnFX");
  self endon(_id_67D4FCE90B90214A);
  thread enableburnfx(0, _id_EE8FA35DAEDF8C6B);
  wait(duration);
  thread disableburnfx(0, _id_EE8FA35DAEDF8C6B);
}

disableburnfx(_id_0E63D4B8BBF87B92, burningstate) {
  if(!isDefined(self.burnfxstates))
    self.burnfxstates = [];

  if(isDefined(burningstate)) {
    self.burnfxstates[getburnfxstatepriority(burningstate)] = undefined;
    self.burnfxstates = scripts\engine\utility::array_removeundefined(self.burnfxstates);
  } else
    self.burnfxstates = [];

  if(self.burnfxstates.size > 0)
    startburnfx();
  else {
    stopburnfx();

    if(!istrue(_id_0E63D4B8BBF87B92))
      thread disable_burnsfx();
  }
}

disable_burnsfx() {
  self notify("updateBurnSFX");
  self endon("death_or_disconnect");
  self endon("updateBurnSFX");
  wait 0.5;

  if(isDefined(self.burnsfxenabled) && self.burnsfxenabled == 1) {
    self playSound("iw9_weap_molotov_fire_enemy_burn_end");
    wait 0.15;
    _id_D9FCEBDB704A67FA();
  }
}

_id_6B4A68DBDAE21499(_id_F60EE8B9E17970E6) {
  scripts\cp_mp\dragonsbreath::_id_9FD9DC9D9D3A0BC4();
  scripts\cp_mp\dragonsbreath::_id_22D1FCED237D6878();
  clearburnfx(_id_F60EE8B9E17970E6);
  _id_D9FCEBDB704A67FA();
}

clearburnfx(_id_F60EE8B9E17970E6) {
  self notify("clearBurnFX");
  _id_11BC0D93953A155A();

  if(istrue(_id_F60EE8B9E17970E6)) {
    if(isDefined(self.corpsetablefuncs) && isDefined(self.corpsetablefuncs["burning"]))
      scripts\mp\damage::dequeuecorpsetablefunc("burning");

    _id_FC27C713595C6A00();
  }

  self.burnfxplaying = undefined;
  self.burnfxstates = undefined;
}

startburnfx() {
  _id_EE8FA35DAEDF8C6B = gethightestpriotiryactiveburnstate(self.burnfxstates);
  self setscriptablepartstate("burning", _id_EE8FA35DAEDF8C6B);
  self.burnfxplaying = _id_EE8FA35DAEDF8C6B;
  _id_FC27C713595C6A00(_id_EE8FA35DAEDF8C6B);

  if(!isDefined(self.corpsetablefuncs) || !isDefined(self.corpsetablefuncs["burning"]))
    scripts\mp\damage::enqueuecorpsetablefunc("burning", ::burnfxcorpstablefunc);

  thread _id_4A895AAFEC5DD891();
}

_id_4A895AAFEC5DD891() {
  self notify("stop_burnFxInfilCleanupThread");
  self endon("death_or_disconnect");
  self endon("stop_burnFxInfilCleanupThread");
  self waittill("beginC130");
  thread _id_6B4A68DBDAE21499(1);
}

_id_FC27C713595C6A00(_id_EE8FA35DAEDF8C6B) {
  if(isDefined(_id_EE8FA35DAEDF8C6B)) {
    if(_id_EE8FA35DAEDF8C6B == "nuke_active" || _id_EE8FA35DAEDF8C6B == "wp_active" || _id_EE8FA35DAEDF8C6B == "active")
      _id_EE8FA35DAEDF8C6B = "flareUp";
    else {
      switch (_id_EE8FA35DAEDF8C6B) {
        case "ar_lr":
          _id_EE8FA35DAEDF8C6B = "al_to_ar_";
          break;
        case "al_ll_":
          _id_EE8FA35DAEDF8C6B = "al_to_ll_";
          break;
        case "to_ar_":
        case "al_ar_":
        case "al_to_":
          _id_EE8FA35DAEDF8C6B = "to_ar_lr";
          break;
        case "ll_lr":
        case "to_lr":
        case "to_ll_":
          _id_EE8FA35DAEDF8C6B = "to_ll_lr";
          break;
        case "ar_ll_lr":
        case "to_ar_ll_":
        case "al_ll_lr":
        case "al_ar_lr":
        case "al_ar_ll_":
        case "al_to_lr":
          _id_EE8FA35DAEDF8C6B = "flareUp";
          break;
      }
    }
  }

  self._id_14D194D29991DF6B = _id_EE8FA35DAEDF8C6B;
}

stopburnfx() {
  if(isDefined(self.burnfxplaying)) {
    _id_11BC0D93953A155A();
    scripts\mp\damage::dequeuecorpsetablefunc("burning");
    _id_FC27C713595C6A00();
    self.burnfxplaying = undefined;
  }

  self notify("stop_burnFxInfilCleanupThread");
}

_id_11BC0D93953A155A() {
  if(self isscriptable())
    self setscriptablepartstate("burning", "neutral");
}

_id_D9FCEBDB704A67FA() {
  if(isDefined(self.burnsfxenabled) && self.burnsfxenabled == 1) {
    if(isDefined(self.burnsfx))
      self.burnsfx stoploopsound("iw9_weap_molotov_fire_enemy_burn");

    self.burnsfxenabled = 0;
  }

  if(isDefined(self.burnsfx)) {
    self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
    self.burnsfx delete();
  }
}

burnfxcorpstablefunc(_id_3741EA5B9FB53EC3) {
  burningstate = "flareUp";

  if(isDefined(self) && isDefined(self._id_14D194D29991DF6B))
    burningstate = self._id_14D194D29991DF6B;

  _id_3741EA5B9FB53EC3 setscriptablepartstate("burning", burningstate, 0);
}

semtex_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  grenade._id_D442547D75DFFD09 = scripts\mp\equipment::_id_2113B6F7CB462692(grenade.weapon_name);
  grenade waittill("missile_stuck", stuckto);

  if(isPlayer(stuckto) || isagent(stuckto)) {
    thread grenadestuckto(grenade, stuckto);

    if(isagent(stuckto) && !istrue(stuckto._id_274D3A7704E351EF)) {
      if(!isDefined(stuckto._id_F8ECC64162438D76))
        stuckto._id_F8ECC64162438D76 = [];
      else
        stuckto._id_F8ECC64162438D76 = scripts\engine\utility::array_removedead(stuckto._id_F8ECC64162438D76);

      stuckto._id_F8ECC64162438D76 = scripts\engine\utility::array_add(stuckto._id_F8ECC64162438D76, grenade);
      scripts\common\ai::_id_60DAA23100A2B874(grenade, stuckto);
    }
  }
}

semtex_stuckplayer(grenade, stuckto) {
  self endon("disconnect");
  grenade endon("end_explode");
  stuckto endon("death_or_disconnect");
  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  grenade waittill("explode", position);
  _id_33E2D54D8812E8CE = stuckto.maxhealth;

  if(isDefined(grenade._id_D442547D75DFFD09)) {
    _id_33E2D54D8812E8CE = scripts\engine\utility::_id_53C4C53197386572(grenade._id_D442547D75DFFD09._id_DC6074BF92AED826, stuckto.maxhealth);
    _id_33E2D54D8812E8CE = _id_33E2D54D8812E8CE * scripts\engine\utility::_id_53C4C53197386572(grenade._id_D442547D75DFFD09._id_43F9A1342DA4E1A0, 1);
  }

  thread _id_0C50CAF1F56ECF73(stuckto, position, _id_33E2D54D8812E8CE, grenade);
}

_id_0C50CAF1F56ECF73(stuckto, position, _id_33E2D54D8812E8CE, _id_68647A50E85E8152) {
  _id_31BBFFE8512C7C8A = distancesquared(position, stuckto.origin);
  _id_1C6CDB959BB1BF2A = 5000;

  if(_id_31BBFFE8512C7C8A > _id_1C6CDB959BB1BF2A) {
    return;
  }
  stuckto scripts\cp_mp\utility\damage_utility::forcestuckdamage();

  if(!isDefined(_id_68647A50E85E8152))
    _id_68647A50E85E8152 = self;

  stuckto dodamage(_id_33E2D54D8812E8CE, position, self, _id_68647A50E85E8152, "MOD_EXPLOSIVE", makeweapon("semtex_mp"));
  stuckto scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
}

_id_7A91162092CC11EC(lootid) {
  _id_093B3002EBEF628B = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  _id_7956CC8A3F6E983D = _id_2669878CF5A1B6BC::getweaponrootname(_id_093B3002EBEF628B);
  return _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(_id_7956CC8A3F6E983D);
}

_id_15ABE90BE101FFC8(_id_C7BD95B10C89CFF8, attachment, _id_D7305E20A538A9A1) {
  _id_4F62FB945AD6AF8D = _func_55DB7A4374ED4B1B(_id_C7BD95B10C89CFF8, attachment);

  foreach(_id_946152E4CD7CD90F, _id_ABF526089D208196 in _id_4F62FB945AD6AF8D) {
    _id_4F13B964AB82FE13 = level._id_8DD253609D606F1C[_id_946152E4CD7CD90F];

    if(isDefined(_id_4F13B964AB82FE13) && _id_D7305E20A538A9A1 == _id_4F13B964AB82FE13)
      return _id_ABF526089D208196;
  }

  return 0;
}

_id_1C6803F36C2EA0A6(_id_C7BD95B10C89CFF8, attachment, variantid) {
  _id_4F62FB945AD6AF8D = _func_55DB7A4374ED4B1B(_id_C7BD95B10C89CFF8, attachment);

  foreach(_id_946152E4CD7CD90F, _id_ABF526089D208196 in _id_4F62FB945AD6AF8D) {
    if(_id_ABF526089D208196 == variantid)
      return level._id_8DD253609D606F1C[_id_946152E4CD7CD90F];
  }

  return undefined;
}

_id_82A0E6138BA06718(objweapon) {
  self._id_888410F22DA94AD0 = undefined;

  if(objweapon hasattachment("trigger_heavy_p14"))
    thread _id_F0AB1405BEDDD91F();
}

_id_F0AB1405BEDDD91F() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_taken");
  self endon("weapon_change");

  for(;;) {
    if(self getcurrentweaponclipammo() == 1)
      self._id_888410F22DA94AD0 = 1;
    else
      self._id_888410F22DA94AD0 = undefined;

    self waittill("reload");
  }
}