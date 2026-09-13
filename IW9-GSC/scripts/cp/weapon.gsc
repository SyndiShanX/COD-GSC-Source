/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\weapon.gsc
***********************************************/

weaponsinit() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::_id_9BA246F8C51923DA);
  level.maxperplayerexplosives = max(scripts\cp\utility::getintproperty("scr_maxperplayerexplosives", 2), 4);
  level.riotshieldxpbullets = scripts\cp\utility::getintproperty("scr_riotshieldxpbullets", 15);
  level.build_weapon_name_func = ::_buildweaponcustom;
  level.has_weapon_variation = ::has_weapon_variation;
  level.get_weapon_level = ::get_weapon_level;
  level.can_upgrade = ::can_upgrade;
  level.weaponconfigs = [];
  level.pap = [];
  level.dropped_weapons = [];
  level.invalid_drop_weapons = ["iw9_sh_mbravo_mp", "iw9_pi_stimpistol_mp"];
  level.wavessurvivedthroughweapon = 0;
  level.weaponobtained = 0;
  level.downswithweapon = 0;
  level.weaponkills = 0;
  level.dropped_weapon_func = ::drop_script_weapon_from_ai;
  level.fnbuildweapon = _id_2669878CF5A1B6BC::buildweapon;
  level.fnscriptedweaponassignment = ::getscriptedweapon;
  _id_2669878CF5A1B6BC::buildweaponmap();
  _id_2669878CF5A1B6BC::buildattachmentmaps();
  _id_2669878CF5A1B6BC::_id_EE4A536A155313B7();
  _id_2D291CFD98FD0D8E();
  scripts\cp\cp_weapons::cp_weapons_init();
  level._id_F9E0E2877B743202 = makeweapon("iw9_me_diveknife_mp");

  if(getdvarint("r_reflectionprobegenerate", 0) == 0)
    level._id_A2DF868742D5F192 = _id_2669878CF5A1B6BC::buildweapon("iw9_me_climbfists");

  level.bot_smoke_sight_clip_large = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_large)) {}

  initeffects();
  setupminesettings();
  setupconfigs();
  level.custom_proj_func = [];
  level thread custom_gl_proj_func_init();
  level thread onplayerconnect();
  iteminits();
  scripts\cp\cp_outline_utility::initoutlineoccluders();
  scripts\engine\utility::array_thread(getEntArray("misc_turret", "classname"), ::turret_monitoruse);
  thread scripts\cp\powers\coop_molotov::molotov_init();

  if(isDefined(level.custom_initializeweaponpickups))
    [[level.custom_initializeweaponpickups]]();
  else
    initializeweaponpickups();

  thread scripts\cp\cp_claymore::claymore_init();
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_init();
  thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  thread scripts\cp\cp_accessories::init();
  thread _id_7B6642E374DC6E4C::decoy_init();
  thread _id_737F801E6BEB18C7::_id_69E63E3462F94600();

  if(getdvarint("r_reflectionprobegenerate", 0) == 0)
    level thread hackexclusionlist();
}

hackexclusionlist() {
  _id_ACD56378E87382DB = [makeweapon(level.sentrysettings["sentry_turret"].weaponinfo), makeweapon("tur_gun_decho_cp"), makeweapon("iw9_mg_jltv_mp"), makeweapon("iw8_gunless_infil"), makeweapon("deploy_manual_turret_mp"), makeweapon("manual_turret_mp"), makeweapon("deploy_tactical_cover_mp"), makeweapon("tac_cover_mp"), makeweapon("gunship_25mm_mp"), makeweapon("gunship_40mm_mp"), makeweapon("gunship_105mm_mp"), makeweapon("gunship_hellfire_mp"), makeweapon("iw8_ammo_marker_cp"), makeweapon("iw8_armor_marker_cp"), makeweapon("vip_carry_cp"), makeweapon("deploy_sentry_mp"), makeweapon("ks_generic_mp"), makeweapon("ks_remote_gauntlet_mp"), makeweapon("ks_remote_map_cp"), makeweapon("ks_remote_device_mp"), makeweapon("ks_remote_target_mp"), makeweapon("ks_gesture_generic_mp"), makeweapon("ks_gesture_phone_mp"), makeweapon("deploy_dronepackage_mp"), makeweapon("deploy_warden_mp"), makeweapon("deploy_box_marker_mp"), makeweapon("deploy_pac_sentry_mp"), makeweapon("iw8_nukecore_mp"), makeweapon("iw9_mg_light_tank_mp"), makeweapon("iw9_mg_mrap_mp"), makeweapon("iw9_tur_mrap_mp"), makeweapon("iw8_spotter_scope_mp"), makeweapon("iw9_la_mike32_mp"), makeweapon("iw8_green_beam_mp"), makeweapon("iw9_minigunksjugg_mp"), makeweapon("ks_remote_drone_mp"), makeweapon("ks_assault_drone_mp"), makeweapon("ks_assault_drone_cp"), level._id_F9E0E2877B743202, makeweapon("iw9_swimfists_mp"), makeweapon("iw8_gunless"), makeweapon("iw9_me_climbfists"), makeweapon("cluster_spike_mp"), makeweapon("iw9_pi_stimpistol_mp")];
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_combine(level.additional_laststand_weapon_exclusion, _id_ACD56378E87382DB);
}

_id_F2525BF18ABAD733(basename) {
  level.additional_laststand_weapon_exclusion[level.additional_laststand_weapon_exclusion.size] = makeweapon(basename);
}

blank(power) {}

initeffects() {
  level._effect["weap_blink_friend"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["weap_blink_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode_big"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion.vfx");
  level.kinetic_pulse_fx["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
  level._effect["gas_grenade_smoke_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_smoke_gren_mp");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["penetration_railgun_explosion"] = loadfx("vfx/iw7/core/expl/weap/chargeshot/vfx_expl_chargeshot.vfx");
  level._effect["flash_bang_explode"] = loadfx("vfx/iw8_mp/equipment/flashbang/vfx_flash_bang.vfx");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch.vfx");
  level._effect["xmike109ThermiteBounce"] = loadfx("vfx/iw8_mp/equipment/vfx_xmike109_thermite_bounce");
}

setupminesettings() {
  _id_1FCC848E179898EE = 70;
  level.claymoredetectiondot = cos(_id_1FCC848E179898EE);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;
  level.minedetectiongraceperiod = 0.3;
  level.minedetectionradius = 150;
  level.minedetectionheight = 20;
  level.minedamageradius = 256;
  level.minedamagemin = 600;
  level.minedamagemax = 1200;
  level.minedamagehalfheight = 300;
  level.mineselfdestructtime = 600;
  level.mine_launch = loadfx("vfx/core/impacts/bouncing_betty_launch_dirt");
  level.mine_explode = loadfx("vfx/core/expl/bouncing_betty_explosion.vfx");
  level.delayminetime = 1.5;
  level.c4explodethisframe = 0;
  level.mines = [];
}

setupconfigs() {
  config = spawnStruct();
  config.mine_beacon["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
  config.mine_beacon["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level.weaponconfigs["c4_mp"] = config;
  config = spawnStruct();
  config.armingdelay = 1.5;
  config.detectionradius = 232;
  config.detectionheight = 512;
  config.detectiongraceperiod = 1;
  config.headiconoffset = 20;
  config.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = config;
  config = spawnStruct();
  _id_504E2E39DFC3B1F9 = 800;
  _id_502B2039DF9D4B77 = 200;
  config.radius_max_sq = _id_504E2E39DFC3B1F9 * _id_504E2E39DFC3B1F9;
  config.radius_min_sq = _id_502B2039DF9D4B77 * _id_502B2039DF9D4B77;
  config.onexplodesfx = "iw9_flash_grenade_expl_trans";
  config.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = config;
}

iteminits() {
  clustergrenadeinit();
  throwingknifec4init();
}

throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_bio_spike_exp.vfx");
}

clustergrenadeinit() {
  level._effect["clusterGrenade_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_cluster_gren_single_runner.vfx");
}

getweapongunsmithattachmenttable(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  return "mp/gunsmith/" + getsubstr(_id_49E6EF3EDADD524E, 4) + "_attachments.csv";
}

getcompletenameforweapon(weapon, _id_C44A5D7D1F872568, _id_20D38453281F31FC, _id_B2EC7DAEBAAB7CAF, _id_FEDB77AAD2340743, _id_69416784E234E68F, _id_11852DA97169016B) {
  weaponname = weapon;
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  index = 0;

  if(_id_67F14F8315CB0F2F[0] == "alt")
    index++;

  if(_id_67F14F8315CB0F2F[index] == "iw7")
    return;
  else if(_id_67F14F8315CB0F2F[index] == "iw8") {
    _id_AB501F397D3CD312 = weapon;

    if(!isDefined(_id_C44A5D7D1F872568))
      attachments = ["none", "none", "none", "none", "none", "none"];
    else
      attachments = _id_C44A5D7D1F872568;

    if(!isDefined(_id_20D38453281F31FC))
      camo = "none";
    else
      camo = _id_20D38453281F31FC;

    if(!isDefined(_id_B2EC7DAEBAAB7CAF))
      reticle = "none";
    else
      reticle = _id_B2EC7DAEBAAB7CAF;

    if(!isDefined(_id_FEDB77AAD2340743))
      variantid = -1;
    else
      variantid = _id_FEDB77AAD2340743;

    if(!isDefined(_id_69416784E234E68F))
      _id_B022D4BB3C3772B3 = 0;
    else
      _id_B022D4BB3C3772B3 = _id_69416784E234E68F;

    if(!isDefined(_id_11852DA97169016B))
      cosmeticattachment = "none";
    else
      cosmeticattachment = _id_11852DA97169016B;

    return getcompleteweaponname(_id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, 1, 1, _id_B022D4BB3C3772B3, cosmeticattachment));
  }
}

turret_monitoruse() {
  for(;;) {
    self waittill("trigger", player);
    thread turret_playerthread(player);
  }
}

turret_playerthread(player) {
  player endon("death");
  player endon("disconnect");
  player notify("weapon_change", nullweapon());
  self waittill("turret_deactivate");
  player notify("weapon_change", player getcurrentweapon());
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.hits = 0;
    player thread onplayerspawned();
    player thread watchmissileusage();
    player thread sniperdustwatcher();
    player thread watchjavelinusage();
    player thread updatelastweapon();
    player thread scripts\cp\cp_achievement::_id_4D0A3CBA9DE1DB93();
    player thread _id_E690098D84B2F10E();
    player thread watchchangeweapon();
    player thread scripts\cp\equipment\cp_stinger::watchlauncherusage();
  }
}

_id_4D0A3CBA9DE1DB93() {
  _id_BBC24B1F18A9A23A = 3;
  _id_1A2ABCEA976D90AF = 0;

  while(_id_1A2ABCEA976D90AF < _id_BBC24B1F18A9A23A) {
    level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker);

    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(sweapon) && isDefined(sweapon.type) && sweapon.type == "riotshield")
        _id_1A2ABCEA976D90AF++;
    }
  }

  self giveachievement("wallofduty");
}

_id_E690098D84B2F10E() {
  self endon("kills_while_flashbanged_achievement_get");
  _id_F7A99A74FE828D31 = 2;

  for(;;) {
    self waittill("flashbang");
    thread _id_0F1BEFEF39D01C44(_id_F7A99A74FE828D31);

    while(scripts\engine\utility::isflashed())
      waitframe();

    self notify("flashbang_effect_over");
  }
}

_id_0F1BEFEF39D01C44(_id_F7A99A74FE828D31) {
  self endon("flashbang_effect_over");
  _id_74A4EC0D5A200638 = 0;

  while(_id_74A4EC0D5A200638 < _id_F7A99A74FE828D31) {
    level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker);

    if(isDefined(eattacker) && eattacker == self)
      _id_74A4EC0D5A200638++;
  }

  self giveachievement("daredevil");
  self notify("kills_while_flashbanged_achievement_get");
}

watchjavelinusage() {
  scripts\cp\equipment\cp_javelin::javelinusageloop();
}

watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      dochangeweapon(objweapon);

    self waittill("weapon_change");
  }
}

dochangeweapon(objweapon) {
  updateweaponspeed(objweapon);
  updatelastweaponobj(objweapon);
  updatelauncherusage();
  updatedragonsbreath(objweapon);
  updateweaponperks();
  updatedefaultflinchreduction();
  _id_293BC33BD79CABD1::updateweaponchangetime();
  riotshieldonweaponchange(objweapon);
}

updatedragonsbreath(objweapon) {
  self notify("end_dragBreath");

  if(getweapongroup(objweapon) == "weapon_shotgun") {
    if(isdragonsbreathweapon(objweapon))
      thread initdragonsbreathusage(objweapon);
  }
}

initdragonsbreathusage(objweapon) {
  objweapon.isdragonsbreath = 1;
  thread stopdragonsbreath(objweapon);
}

stopdragonsbreath(objweapon) {
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("end_dragBreath", "death");

  if(isDefined(objweapon))
    objweapon.isdragonsbreath = undefined;
}

isdragonsbreathweapon(objweapon) {
  ammotype = getweaponammopoolname(objweapon);
  return ammotype == "enum_2C53556F245BE704";
}

updateweaponspeed(_id_82533969B4683DE4) {
  if(_id_82533969B4683DE4.basename == "none")
    return;
  else if(scripts\cp\utility::issuperweapon(_id_82533969B4683DE4.basename)) {
    _id_12E2FB553EC1605E::updatemovespeedscale();
    return;
  } else if(_id_2669878CF5A1B6BC::iskillstreakweapon(_id_82533969B4683DE4.basename))
    return;
  else if(_id_82533969B4683DE4.basename == "iw9_me_fists_mp_ls") {
    _id_12E2FB553EC1605E::updatemovespeedscale();
    return;
  } else if(_id_82533969B4683DE4.inventorytype != "primary" && _id_82533969B4683DE4.inventorytype != "altmode") {
    return;
  }
  _id_12E2FB553EC1605E::updatemovespeedscale();
}

updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }
  scale = undefined;
  _id_6651DEF69449C4A3 = weapongetflinchtype(self.currentweapon);

  if(_id_6651DEF69449C4A3 == 4)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 3)
    scale = 1;
  else if(_id_6651DEF69449C4A3 == 1)
    scale = 1;
  else
    scale = 1;

  updateviewkickscale(scale);
}

updateviewkickscale(_id_072BC79F0750FCA9) {
  if(isDefined(_id_072BC79F0750FCA9))
    self.viewkickscale = _id_072BC79F0750FCA9;

  if(isDefined(self.overchargeviewkickscale))
    _id_072BC79F0750FCA9 = self.overchargeviewkickscale;
  else if(isDefined(self.overrideviewkickscale)) {
    _id_072BC79F0750FCA9 = self.overrideviewkickscale;
    _id_6651DEF69449C4A3 = weapongetflinchtype(self getcurrentweapon());

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

weapongetflinchtype(weaponobj) {
  class = "none";
  _id_6651DEF69449C4A3 = -1;

  if(isDefined(weaponobj) && !isnullweapon(weaponobj)) {
    class = weaponclass(weaponobj);

    switch (class) {
      case "pistol":
        _id_6651DEF69449C4A3 = 1;
        break;
      case "sniper":
        if(getweapongroup(weaponobj) == "weapon_dmr")
          _id_6651DEF69449C4A3 = 3;
        else
          _id_6651DEF69449C4A3 = 4;

        break;
      default:
        _id_6651DEF69449C4A3 = 0;
    }
  }

  return _id_6651DEF69449C4A3;
}

updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

doweaponperkupdate(prevweaponobj) {
  _id_4DA99B8AAFF6E52A = self getcurrentweapon();
  weaponattachmentperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj);
  weaponperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj);
  return _id_4DA99B8AAFF6E52A;
}

weaponperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj) {
  if(!isundefinedweapon(prevweaponobj)) {
    _id_9586602EBC60B765 = _id_2669878CF5A1B6BC::getweaponrootname(prevweaponobj.basename);
    _id_B46BA6B5339521F1 = weaponperkmap(_id_9586602EBC60B765);

    if(isDefined(_id_B46BA6B5339521F1))
      _id_6E09A830FAB9468F::removeperk(_id_B46BA6B5339521F1);
  }

  if(!isundefinedweapon(_id_4DA99B8AAFF6E52A)) {
    _id_98EFD9D21DA41D1A = _id_2669878CF5A1B6BC::getweaponrootname(_id_4DA99B8AAFF6E52A.basename);
    _id_CA1CCAC233079978 = weaponperkmap(_id_98EFD9D21DA41D1A);

    if(isDefined(_id_CA1CCAC233079978))
      scripts\cp\utility::giveperk(_id_CA1CCAC233079978);
  }
}

weaponperkmap(_id_4BB9768282D4260D) {
  if(isDefined(level.weaponmapdata[_id_4BB9768282D4260D]) && isDefined(level.weaponmapdata[_id_4BB9768282D4260D].perk))
    return level.weaponmapdata[_id_4BB9768282D4260D].perk;

  return undefined;
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
        _id_6E09A830FAB9468F::removeperk(perk);
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
        scripts\cp\utility::giveperk(perk);
      }
    }
  }
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

  if(iscacprimaryorsecondary(_id_82533969B4683DE4))
    self.lastcacweaponobj = _id_82533969B4683DE4;
}

setlastdroppableweaponobj(weaponobj) {
  self.lastdroppableweaponobj = weaponobj;

  if(isDefined(level.lastdroppableweaponchanged))
    self[[level.lastdroppableweaponchanged]]();
}

trackriotshield_grenadepullbackforc4() {
  for(;;) {
    self waittill("grenade_pullback", grenade);

    if(!isnullweapon(grenade) && grenade.basename == "c4_mp" && scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon()))
      self.onriotshieldstow_force = 1;
  }
}

trackriotshield_updateoffhandstowignorec4() {
  if(!istrue(self.onriotshieldstow_force)) {
    weaponobj = self getheldoffhand();

    if(!isnullweapon(weaponobj) && weaponobj.basename != "c4_mp" && scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon()) && scripts\cp\utility::istwohandedoffhand(weaponobj))
      self.onriotshieldstow_force = 1;
  }
}

trackriotshield_monitorshieldattach(wasinlaststand) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  childthread trackriotshield_grenadepullbackforc4();

  if(isDefined(wasinlaststand))
    self.wasinlaststand = wasinlaststand;
  else if(!isDefined(self.wasinlaststand))
    self.wasinlaststand = 0;

  while(scripts\cp\utility::riotshield_hasweapon()) {
    trackriotshield_updateoffhandstowignorec4();
    isinlaststand = _id_0AFB7E332AEE4BF2::player_in_laststand(self);

    if(!isinlaststand) {
      if(istrue(self.wasinlaststand)) {
        self.laststandforceback = 1;
        self.laststandforcebackendtime = gettime() + 1300;
      } else if(isDefined(self.laststandforcebackendtime) && gettime() >= self.laststandforcebackendtime) {
        self.laststandforceback = undefined;
        self.laststandforcebackendtime = undefined;
      }

      self.wasinlaststand = 0;
    } else {
      self.laststandforceback = undefined;
      self.laststandforcebackendtime = undefined;
      self.wasinlaststand = 1;
    }

    if(self isonladder())
      trackriotshield_tryback();
    else if(self isinexecutionattack())
      trackriotshield_tryback();
    else if(self isinexecutionvictim())
      trackriotshield_trydetach();
    else if(self isparachuting() || self isskydiving())
      trackriotshield_tryback();
    else if(istrue(self.laststandforceback))
      trackriotshield_tryback();
    else if(istrue(self.onriotshieldstow_force)) {
      if(isnullweapon(self getheldoffhand())) {
        self.onriotshieldstow_force = undefined;
        trackriotshield_tryreset();
      } else
        trackriotshield_tryback();
    } else
      trackriotshield_tryreset();

    waitframe();
  }

  trackriotshield_tryreset();
}

trackriotshield_tryback() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onback) {
    if(_id_F8EE3E194415C066)
      scripts\cp\utility::riotshield_move(1);
    else
      scripts\cp\utility::riotshield_attach(0, riotshield_getmodel());
  }
}

trackriotshield_tryarm() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!_id_F8EE3E194415C066) {
    if(onback)
      scripts\cp\utility::riotshield_move(0);
    else
      scripts\cp\utility::riotshield_attach(1, riotshield_getmodel());
  }
}

trackriotshield_trydetach() {
  _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(_id_F8EE3E194415C066)
    scripts\cp\utility::riotshield_detach(1);

  if(onback)
    scripts\cp\utility::riotshield_detach(0);
}

trackriotshield_tryreset() {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    _id_E04977FBA6749BED = scripts\cp_mp\utility\weapon_utility::isriotshield(self getcurrentweapon());

    if(_id_E04977FBA6749BED) {
      trackriotshield_tryarm();
      return;
    }

    trackriotshield_tryback();
    return;
  } else {
    _id_F8EE3E194415C066 = isDefined(self.riotshieldmodel);
    onback = isDefined(self.riotshieldmodelstowed);

    if(_id_F8EE3E194415C066)
      scripts\cp\utility::riotshield_detach(1);

    if(onback)
      scripts\cp\utility::riotshield_detach(0);
  }
}

riotshieldonweaponchange(objweapon) {
  if(scripts\cp\utility::riotshield_hasweapon())
    thread trackriotshield_monitorshieldattach();
  else {
    trackriotshield_tryreset();
    riotshieldclearvars();
    self notify("riotshield_detach");
  }
}

riotshieldclearvars(_id_FCEF8D217A441961) {
  self.laststandforceback = undefined;
  self.laststandforcebackendtime = undefined;
  self.wasinlaststand = undefined;

  if(istrue(_id_FCEF8D217A441961)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

sniperdustwatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  _id_1C3DD0EF777CF9B5 = undefined;

  for(;;) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }
    _id_DE88CD14114C1E24 = self getcurrentweapon();

    if(_id_DE88CD14114C1E24.classname != "weapon_sniper") {
      continue;
    }
    _id_20AF753DED3657E1 = anglesToForward(self.angles);

    if(!isDefined(_id_1C3DD0EF777CF9B5) || gettime() - _id_1C3DD0EF777CF9B5 > 2000) {
      _id_1C3DD0EF777CF9B5 = gettime();
      continue;
    }
  }
}

unset_scriptable_part_state_after_time(timer, player) {
  self endon("death");
  wait(timer);
  self setscriptablepartstate("projectile", "inactive");
  player notify("ranged_katana_missile_done");

  if(isDefined(self))
    self delete();
}

watchmissileusage() {
  self endon("disconnect");
  thread listen_for_custom_proj_dvar();

  for(;;) {
    missile = waittill_missile_fire();
    _id_6D87867F43E1D612 = undefined;

    switch (missile.weapon_name) {
      case "iw8_la_gromeoks_mp":
      case "iw8_la_gromeo_mp":
      case "iw9_la_gromeo_mp":
        _id_6D87867F43E1D612 = self.missilelaunchertarget;
        break;
      case "iw8_la_juliet_mp":
        _id_6D87867F43E1D612 = self.javelin.target;
        break;
      case "iw9_la_mike32_mp":
        missile thread launch_custom_gl_projectile(missile.owner);
        break;
      case "remotemissile_projectile_mp":
        missile thread grenade_earthquake();
        break;
      case "glsmoke":
        missile thread smokegrenadeused(1);
        break;
      case "glconc":
        missile thread watchconcussiongrenadeexplode();
        break;
      case "glflash":
        break;
      case "glincendiary":
        thread scripts\cp\equipment\cp_thermite::thermite_used(missile, 1);
        break;
      case "glsnap":
        thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(missile, 1);
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(missile.weapon_name) && isDefined(_id_6D87867F43E1D612)) {
      missile.lockontarget = _id_6D87867F43E1D612;
      level notify("stinger_fired", self, missile, _id_6D87867F43E1D612);
      thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(_id_6D87867F43E1D612, missile);

      if(isDefined(level._id_325647BB596F072C))
        level thread[[level._id_325647BB596F072C]](missile);
    }

    if(isPlayer(self) && isDefined(missile))
      missile.adsfire = scripts\cp\utility::isplayerads();
  }
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

listen_for_custom_proj_dvar() {
  self endon("disconnect");

  for(;;) {
    _id_93D22093DDEBD2CA = getDvar("dvar_25D23F0AAAED8D2E", "none");

    if(_id_93D22093DDEBD2CA != "none")
      self.gl_proj_override = _id_93D22093DDEBD2CA;

    wait 0.1;
  }
}

launch_custom_gl_projectile(_id_E4F9C58CBF80B3F7) {
  _id_AE593C6C69EF7D27 = get_custom_gl_projectile(_id_E4F9C58CBF80B3F7);

  if(isDefined(_id_AE593C6C69EF7D27)) {
    self delete();

    if(isDefined(level.custom_proj_func[_id_AE593C6C69EF7D27]))
      level thread[[level.custom_proj_func[_id_AE593C6C69EF7D27]]](_id_E4F9C58CBF80B3F7);
  }
}

get_custom_gl_projectile(_id_E4F9C58CBF80B3F7) {
  if(isDefined(_id_E4F9C58CBF80B3F7.gl_proj_override))
    return _id_E4F9C58CBF80B3F7.gl_proj_override;

  return undefined;
}

custom_gl_proj_func_init() {
  level.custom_proj_func["concertina"] = ::launchconcertinabomb;
  level.custom_proj_func["thermite"] = ::launchthermite;
  level.custom_proj_func["molotov"] = ::launchmolotov;
  level.custom_proj_func["semtex"] = ::launchstickytimedgrenade;
  level.custom_proj_func["c4"] = ::launchc4grenade;
}

create_new_projectile(weapon_name, _id_E4F9C58CBF80B3F7) {
  _id_06A3A1033FFC2699 = anglesToForward(_id_E4F9C58CBF80B3F7 getplayerangles());
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * 2000;

  if(_id_E4F9C58CBF80B3F7 tagexists("tag_flash"))
    _id_435A01FBCDF2D764 = _id_E4F9C58CBF80B3F7 gettagorigin("tag_flash");
  else
    _id_435A01FBCDF2D764 = _id_E4F9C58CBF80B3F7 getEye();

  _id_E020078567E41613 = _id_E4F9C58CBF80B3F7 launchgrenade(weapon_name, _id_435A01FBCDF2D764, _id_06A3A1033FFC2699);
  _id_E020078567E41613.owner = _id_E4F9C58CBF80B3F7;
  return _id_E020078567E41613;
}

launchthermite(_id_E4F9C58CBF80B3F7) {
  _id_E020078567E41613 = create_new_projectile("thermite_proj_cp", _id_E4F9C58CBF80B3F7);
  _id_E4F9C58CBF80B3F7 thread scripts\cp\equipment\cp_thermite::thermite_used(_id_E020078567E41613);
}

launchmolotov(_id_E4F9C58CBF80B3F7) {
  _id_E020078567E41613 = create_new_projectile("molotov_mp", _id_E4F9C58CBF80B3F7);
  _id_E4F9C58CBF80B3F7 thread scripts\cp\powers\coop_molotov::molotov_used(_id_E020078567E41613);
  self delete();
}

launchstickytimedgrenade(_id_E4F9C58CBF80B3F7) {
  _id_E020078567E41613 = create_new_projectile("semtex_mp", _id_E4F9C58CBF80B3F7);
  _id_E4F9C58CBF80B3F7 thread semtexused(_id_E020078567E41613);
  self delete();
}

launchc4grenade(_id_E4F9C58CBF80B3F7) {
  _id_E020078567E41613 = create_new_projectile("c4_mp", _id_E4F9C58CBF80B3F7);
  _id_E4F9C58CBF80B3F7 thread scripts\cp\cp_c4::c4_used(_id_E020078567E41613);
  self delete();
}

launchexplosivetiplogic(owner) {
  self waittill("explode", origin, normal, velocity, entity);
  owner endon("disconnect");
  owner endon("joined_team");
  owner endon("joined_spectators");
  model = spawn("script_model", origin);
  model setModel("offhand_wm_grenade_thermite");
  model setscriptablepartstate("effects", "impact", 0);
  model.trigger = spawn("trigger_radius", model.origin, 0, 125, 72);
  model.trigger thread watch_for_thermite_triggered(owner);
  wait 0.5;
  ticks = 1;

  while(ticks <= 10) {
    _id_6B3EE446F2845368 = ticks + 1;
    ticks = _id_6B3EE446F2845368;
    wait 0.5;
  }

  model thread bolt_destroy();
}

wait_for_crate_drop_to_ground(dropcrate) {
  ground_pos = scripts\engine\utility::drop_to_ground(dropcrate.origin + (0, 0, -100), 0, -5000);
  _id_6D3A9738E44F853D = 900;
  _id_1A352D2B513C6DA9 = 1000;
  _id_B497E19421070AE9 = 0;

  for(;;) {
    if(distancesquared(dropcrate.origin, ground_pos) <= _id_6D3A9738E44F853D)
      return ground_pos;

    if(_id_B497E19421070AE9 >= _id_1A352D2B513C6DA9)
      return ground_pos;

    _id_B497E19421070AE9 = _id_B497E19421070AE9 + 50;
    waitframe();
  }
}

watch_for_thermite_triggered(owner) {
  self endon("end_thermite_trigger");
  self endon("death");

  for(;;) {
    self waittill("trigger", victim);

    if(isPlayer(victim)) {
      continue;
    }
    if(!victim scripts\cp\utility::is_soldier_agent()) {
      continue;
    }
    if(isalive(victim) && !istrue(victim.marked_for_death)) {
      victim.marked_for_death = 1;
      thread watch_for_victim_death(victim);
      victim thread scripts\cp\utility::damage_over_time(victim, owner, 2.5, 100, "MOD_EXPLOSIVE");
    }
  }
}

watch_for_victim_death(victim) {
  self endon("death");
  victim waittill("death");
  victim.marked_for_death = undefined;
  playFX(level._effect["vfx_thermite_end"], victim.origin);
  self delete();
}

bolt_destroy() {
  self setscriptablepartstate("effects", "burnEnd", 0);
  self notify("end_thermite_trigger");

  if(isDefined(self.trigger))
    self.trigger delete();

  self delete();
}

waitfortriggernotify(player) {
  self endon("death");

  for(;;) {
    self waittill("trigger", victim);

    if(isPlayer(victim)) {
      continue;
    }
    if(!victim scripts\cp\utility::is_soldier_agent()) {
      continue;
    }
    if(isalive(victim) && !istrue(victim.marked_for_death)) {
      victim.marked_for_death = 1;
      victim thread scripts\cp\utility::damage_over_time(victim, player, 5, 100, "MOD_EXPLOSIVE");
    }
  }
}

launchconcertinabomb(player) {
  self waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);
  trigger = spawn("trigger_radius", self.origin, 0, 500, 72);
  trigger thread waitfortriggernotify(player);
  wait 6;
  trigger delete();
}

removelinkafterdelay(_id_C9C04A2E50ED1560, delay) {
  wait(delay);

  if(scripts\engine\utility::array_contains(level.strrazorlinks, _id_C9C04A2E50ED1560))
    level.strrazorlinks = scripts\engine\utility::array_remove(level.strrazorlinks, _id_C9C04A2E50ED1560);
}

lockonlaunchers_gettargetarray(_id_FE608D14719843BC) {
  targets = [];
  _id_E688B198AA9A4B3F = 0;

  if(level.teambased) {
    if(isDefined(_id_FE608D14719843BC) && _id_FE608D14719843BC == 1) {
      foreach(_id_B5517D24E9DC9A49 in level.characters) {
        if(isDefined(_id_B5517D24E9DC9A49) && isalive(_id_B5517D24E9DC9A49) && (_id_B5517D24E9DC9A49.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_B5517D24E9DC9A49;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
        if(isDefined(_id_153FDEE861E0F06F.affectedbylockon) && (_id_153FDEE861E0F06F.team != self.team || _id_E688B198AA9A4B3F))
          targets[targets.size] = _id_153FDEE861E0F06F;
      }
    }

    if(isDefined(level.special_lockon_target_list)) {
      foreach(_id_ACE5C2D0AE6B4A14 in level.special_lockon_target_list)
      targets[targets.size] = _id_ACE5C2D0AE6B4A14;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.team != self.team || _id_E688B198AA9A4B3F)
            targets[targets.size] = ac130;
        }
      }
    }

    foreach(_id_7731ADEF63E19B0C in scripts\cp_mp\vehicles\vehicle::_id_9005B7FC076293F8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(_id_7731ADEF63E19B0C);

      foreach(vehicle in vehicles) {
        if(!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, self) || _id_E688B198AA9A4B3F)
          targets[targets.size] = vehicle;
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
        if(!isDefined(vehicle.owner)) {
          targets[targets.size] = vehicle;
          continue;
        }

        if(vehicle.owner != self || _id_E688B198AA9A4B3F)
          targets[targets.size] = vehicle;
      }
    }
  }

  foreach(target in targets) {
    if(!isvector(target.origin))
      targets = scripts\engine\utility::array_remove(targets, target);
  }

  return targets;
}

add_to_special_lockon_target_list(target) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  if(!scripts\engine\utility::array_contains(level.special_lockon_target_list, target))
    level.special_lockon_target_list = scripts\engine\utility::array_add(level.special_lockon_target_list, target);
}

remove_from_special_lockon_target_list(target) {
  if(!isDefined(level.special_lockon_target_list))
    level.special_lockon_target_list = [];

  if(scripts\engine\utility::array_contains(level.special_lockon_target_list, target))
    level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, target);
}

getrandomdirection(startpoint, _id_349D8E7CD03AA703) {
  _id_0A788FB3849C0448 = anglestoup(_id_349D8E7CD03AA703);
  _id_EB1A50452E343BFD = anglestoright(_id_349D8E7CD03AA703);
  _id_D2AFE6F56551B342 = anglesToForward(_id_349D8E7CD03AA703);
  _id_9BAAAA8B62B09702 = randomint(360);
  _id_39CCAD51D40F1872 = randomint(360);
  x = cos(_id_39CCAD51D40F1872) * sin(_id_9BAAAA8B62B09702);
  y = sin(_id_39CCAD51D40F1872) * sin(_id_9BAAAA8B62B09702);
  z = cos(_id_9BAAAA8B62B09702);
  _id_3777ECE6A73EADA5 = (x * _id_EB1A50452E343BFD + y * _id_D2AFE6F56551B342 + z * _id_0A788FB3849C0448) / 0.33;
  return -1 * _id_3777ECE6A73EADA5;
}

waittill_missile_fire() {
  self waittill("missile_fire", missile, objweapon);

  if(isDefined(missile)) {
    if(!isDefined(missile.weapon_name)) {
      if(objweapon.isalternate)
        missile.weapon_name = objweapon.underbarrel;
      else
        missile.weapon_name = objweapon.basename;
    }

    if(!isDefined(missile.owner))
      missile.owner = self;

    if(!isDefined(missile.team))
      missile.team = self.team;
  }

  return missile;
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    self.currentweaponatspawn = self getcurrentweapon();
    self.empendtime = 0;
    self.concussionendtime = 0;
    self.hits = 0;

    if(!isDefined(self.trackingweapon)) {
      self.trackingweapon = nullweapon();
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self._id_E16D751A51153A7B = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    riotshieldclearvars(1);
    thread watchgrenadeusage();
    thread _id_57F5A8F25CD5DA9E();
    thread scripts\cp\equipment\cp_adrenaline::listen_for_adrenaline_use();
    thread stancerecoiladjuster();
    thread initlauncherlogic();
    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    self.tookweaponfrom = [];
    thread watchforweaponchange();
    thread watchforweapondropped();
    thread monitorlauncherspawnedgrenades();
    self.currentweaponatspawn = undefined;
    self.trophyremainingammo = undefined;
  }
}

initlauncherlogic() {
  weapon = self getcurrentweapon();

  switch (weapon.basename) {
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      thread scripts\cp\cp_missilelauncher::missilelauncherusageloop();
      break;
    case "iw9_la_juliet_mp":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
  }
}

updatelauncherusage() {
  weapon = self getcurrentweapon();

  switch (weapon.basename) {
    default:
      break;
    case "iw8_la_gromeo_cp_esc":
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      thread scripts\cp\cp_missilelauncher::initmissilelauncherusage();
      break;
    case "iw8_la_juliet_mp":
      thread scripts\cp\equipment\cp_javelin::javelin_reset();
      break;
    case "iw8_sn_crossbow_mp":
      thread scripts\cp_mp\crossbow::initcrossbowusage();
      break;
    case "iw8_sn_xmike109_mp":
      thread scripts\cp_mp\xmike109::initusage();
      break;
  }

  self notify("end_launcher");

  if(scripts\cp\utility::_hasperk("specialty_fastreload_launchers")) {
    _id_589C33F399FE5F5D = weaponclass(weapon.basename) == "rocketlauncher";

    if(_id_589C33F399FE5F5D && !istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::_unsetperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (weapon.basename) {
    default:
      break;
    case "iw8_sn_crossbow_mp":
      thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);
      break;
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      thread scripts\cp\cp_missilelauncher::missilelauncherusageloop();
      break;
    case "iw9_la_juliet_mp":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
    case "iw8_sn_xmike109_mp":
      thread scripts\cp_mp\xmike109::usageloop(weapon);
      break;
  }
}

watchforweapondropped() {
  self endon("disconnect");
  self notify("watchForWeaponDropped");
  self endon("watchForWeaponDropped");

  for(;;) {
    self waittill("weapon_dropped", _id_47DCFBC98E2103EE, objweapon);

    if(isDefined(_id_47DCFBC98E2103EE) && isDefined(objweapon))
      self.storedweapons[objweapon.basename] = undefined;
  }
}

monitorlauncherspawnedgrenades() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    grenade = waittill_grenade_fire();

    if(isDefined(grenade.weapon_name)) {
      if(glprox_trygetweaponname(grenade.weapon_name) == "stickglprox")
        semtexused(grenade);

      switch (grenade.weapon_name) {
        case "thermite_proj_cp":
        case "thermite_mp":
          thread scripts\cp\equipment\cp_thermite::thermite_used(grenade);
          break;
        case "throwingknife_fire_mp":
        case "throwingknife_mp":
          scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(grenade);
          break;
      }
    }
  }
}

glprox_trygetweaponname(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return weapon;

  if(isstring(weapon) && weapon == "none")
    return weapon;

  if(getweaponbasename(weapon) == "iw7_glprox_mp") {
    if(isstring(weapon) && scripts\cp\utility::isaltmodeweapon(weapon) || isweapon(weapon) && weapon.isalternate) {
      attachments = getweaponattachments(weapon);
      weapon = attachments[0];
    } else
      weapon = getweaponbasename(weapon);
  }

  return weapon;
}

stancerecoiladjuster() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  if(!isPlayer(self)) {
    return;
  }
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

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }
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
    _id_0DD6BF5F9DBA888C = weapon.classname;

    if(isDefined(_id_0DD6BF5F9DBA888C)) {
      if(_id_0DD6BF5F9DBA888C == "weapon_lmg") {
        setrecoilscale(0, 40);
        return;
      }

      if(_id_0DD6BF5F9DBA888C == "weapon_sniper") {
        if(weapon hasattachment("barrelbored")) {
          setrecoilscale(0, 20 + _id_8F7FAD0B4F9853BF);
          return;
        }

        setrecoilscale(0, 40 + _id_8F7FAD0B4F9853BF);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(stance == "crouch") {
    _id_0DD6BF5F9DBA888C = weapon.classname;

    if(isDefined(_id_0DD6BF5F9DBA888C)) {
      if(_id_0DD6BF5F9DBA888C == "weapon_lmg") {
        setrecoilscale(0, 10);
        return;
      }

      if(_id_0DD6BF5F9DBA888C == "weapon_sniper") {
        if(weapon hasattachment("barrelbored")) {
          setrecoilscale(0, 10 + _id_8F7FAD0B4F9853BF);
          return;
        }

        setrecoilscale(0, 20 + _id_8F7FAD0B4F9853BF);
        return;
        return;
      }

      return;
      return;
    }

    setrecoilscale();
    return;
  } else if(_id_8F7FAD0B4F9853BF > 0)
    setrecoilscale(0, _id_8F7FAD0B4F9853BF);
  else
    setrecoilscale();
}

setrecoilscale(_id_B7AB28868F552DF5, _id_01E913F08EA31C3D) {
  if(!isDefined(_id_B7AB28868F552DF5))
    _id_B7AB28868F552DF5 = 0;

  if(!isDefined(self.recoilscale))
    self.recoilscale = _id_B7AB28868F552DF5;
  else
    self.recoilscale = self.recoilscale + _id_B7AB28868F552DF5;

  if(isDefined(_id_01E913F08EA31C3D)) {
    if(isDefined(self.recoilscale) && _id_01E913F08EA31C3D < self.recoilscale)
      _id_01E913F08EA31C3D = self.recoilscale;

    scale = 100 - _id_01E913F08EA31C3D;
  } else
    scale = 100 - self.recoilscale;

  if(scale < 0)
    scale = 0;

  if(scale > 100)
    scale = 100;

  if(scale == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(scale);
}

isrecoilreducingweapon(weapon) {
  return 0;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"]))
    self.pers["recoilReduceKills"] = 0;

  return self.pers["recoilReduceKills"] * 40;
}

watchforweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchForWeaponChange");
  self endon("watchForWeaponChange");

  for(;;) {
    self waittill("weapon_change", objweapon);

    if(isnullweapon(objweapon)) {
      continue;
    }
    if(isvalidweapon(objweapon))
      self.last_valid_weapon = objweapon;

    if(!isDefined(self.storedweapons))
      self.storedweapons = [];

    if(!isDefined(self.storedweapons[objweapon.basename]))
      self.storedweapons[objweapon.basename] = getcompleteweaponname(objweapon);

    thread updatelauncherusage();

    if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon)) {
      continue;
    }
    if(is_launcher(objweapon) && !is_killstreak_weapon(objweapon)) {
      objweapon = remove_launcher_xmags(objweapon);

      if(isDefined(level.set_relics)) {
        if(isDefined(level.set_relics["relic_rocket_kill_ammo"]))
          self disableemptyclipweaponswitch(1);
      }

      continue;
    }

    if(isDefined(level.set_relics)) {
      if(isDefined(level.set_relics["relic_rocket_kill_ammo"]))
        self disableemptyclipweaponswitch(0);
    }
  }
}

drop_minigun(player) {
  player notify("dropping_minigun");
  _id_A8EF96B8F7B04EC5 = ["iw9_minigunksjugg_mp", "iw9_lm_dblmg2_cp"];
  _id_1EDB8D5C60B8182A = "iw9_lm_dblmg2_cp";

  foreach(_id_37EDE289A37EF621 in _id_A8EF96B8F7B04EC5) {
    if(player hasweapon(_id_37EDE289A37EF621))
      _id_1EDB8D5C60B8182A = _id_37EDE289A37EF621;
  }

  currentweapon = makeweapon(_id_1EDB8D5C60B8182A);
  _id_65B055C9A44990A9 = player dropitem(currentweapon);
  _id_65B055C9A44990A9 thread watchweaponpickup();
}

watch_minigun_ammo_depleted(player, objweapon) {
  player endon("death");
  player endon("disconnect");
  player endon("faux_spawn");
  player endon("dropping_minigun");
  player notify("watchMinigunAmmo");
  player endon("watchMinigunAmmo");

  for(;;) {
    _id_5831BA9BB12B4D9B = player getweaponammoclip(objweapon);

    if(_id_5831BA9BB12B4D9B <= 0) {
      player takeweapon(objweapon);
      return;
    }

    waitframe();
  }
}

picking_up_minigun(objweapon) {
  if(objweapon.basename == "iw9_lm_dblmg2_cp")
    return 1;

  if(objweapon.basename == "iw9_minigunksjugg_mp")
    return 1;

  return 0;
}

switch_weapon_from_minigun(player, objweapon) {
  if(objweapon.basename == "iw9_lm_dblmg2_cp")
    return 0;

  if(objweapon.basename == "iw9_minigunksjugg_mp")
    return 0;

  return player_has_minigun(player);
}

player_has_minigun(player) {
  _id_A8EF96B8F7B04EC5 = ["iw9_minigunksjugg_mp", "iw9_lm_dblmg2_cp"];

  foreach(_id_37EDE289A37EF621 in _id_A8EF96B8F7B04EC5) {
    if(player hasweapon(_id_37EDE289A37EF621))
      return 1;

    if(player getcurrentweapon().basename == _id_37EDE289A37EF621)
      return 1;
  }

  return 0;
}

is_launcher(weapon) {
  class = weaponclass(weapon);

  if(class == "rocketlauncher")
    return 1;

  switch (weapon.basename) {
    case "iw8_la_kgolf_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw9_la_gromeo_mp":
      return 1;
  }

  return 0;
}

is_killstreak_weapon(weapon) {
  switch (weapon.basename) {
    case "gunship_25mm_cp":
    case "gunship_40mm_cp":
      return 1;
    default:
      return 0;
  }
}

add_launcher_xmags(weapon) {
  attachment = "xmags_cp_gromeo";

  switch (weapon.basename) {
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      attachment = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      attachment = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      attachment = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      attachment = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(!weapon hasattachment(attachment))
    weapon = addattachmenttoweapon(weapon, attachment, 1);

  return weapon;
}

remove_launcher_xmags(weapon) {
  attachment = "xmags_cp_gromeo";

  switch (weapon.basename) {
    case "iw8_la_gromeo_mp":
    case "iw9_la_gromeo_mp":
      attachment = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      attachment = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      attachment = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      attachment = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(weapon hasattachment(attachment))
    remove_attachment(attachment, self, weapon);

  return weapon;
}

isfistweapon(weapon) {
  weapon = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  return weapon == "iw9_me_fists";
}

isgunlessweapon(weapon) {
  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw8_gunless" || _id_C27E2A04BAB78C1F == "iw8_gunless_infil" || _id_C27E2A04BAB78C1F == "iw8_gunless_last_stand_enter";
}

isvalidweapon(_id_DD515FCF025B2E79) {
  _id_CD71448FD6B9EB3F = level.additional_laststand_weapon_exclusion;
  _id_66B3DB972AC1531E = undefined;

  if(isweapon(_id_DD515FCF025B2E79))
    _id_66B3DB972AC1531E = _id_DD515FCF025B2E79;
  else
    _id_66B3DB972AC1531E = makeweaponfromstring(_id_DD515FCF025B2E79);

  if(isnullweapon(_id_66B3DB972AC1531E))
    return 0;
  else if(isDefined(_id_CD71448FD6B9EB3F) && scripts\engine\utility::array_contains(_id_CD71448FD6B9EB3F, _id_66B3DB972AC1531E))
    return 0;
  else if(scripts\cp\utility::is_melee_weapon(_id_66B3DB972AC1531E, 1))
    return 0;
  else
    return 1;
}

ai_offhandfiremanager() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", grenade, weapon);
    grenade.owner = self;

    switch (weapon.basename) {
      case "molotov_mp":
        level thread scripts\cp\powers\coop_molotov::ai_molotov_used(self, grenade);
        break;
      case "gas_mp":
        thread scripts\cp\equipment\cp_gas_grenade::gas_used(grenade);
        break;
      case "concussion_grenade_mp":
        grenade thread watchconcussiongrenadeexplode();
        break;
    }
  }
}

watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  self.throwinggrenade = undefined;
  self.gotpullbacknotify = 0;

  if(!isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = [];
    self.plantedtacticalequip = [];
  }

  for(;;) {
    self waittill("grenade_pullback", objweapon);
    _id_D9BCCCD17A53D67B = self getthrowbackweapon();

    if(!isnullweapon(_id_D9BCCCD17A53D67B)) {
      continue;
    }
    weaponname = objweapon.basename;
    thread watchoffhandcancel();
    self.throwinggrenade = weaponname;

    if(weaponname == "c4_mp")
      thread beginc4tracking();

    begingrenadetracking();
    thread _id_12E2FB553EC1605E::_id_48C0BDF6DD0F6DDE();
    self.throwinggrenade = undefined;
  }
}

watchoffhandcancel() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isDefined(self.changingweapon) && self.changingweapon != self getcurrentweapon())
    self.changingweapon = undefined;
}

beginc4tracking() {
  self notify("beginC4Tracking");
  self endon("beginC4Tracking");
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

dudgrenadeused(owner) {
  owner endon("disconnect");
  thread ownerdisconnectcleanup(owner);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", position);
  self delete();
}

begingrenadetracking() {
  self endon("offhand_end");
  starttime = gettime();
  grenade = waittill_grenade_fire();

  if(!isDefined(grenade)) {
    return;
  }
  if(!isDefined(grenade.weapon_name)) {
    return;
  }
  self.changingweapon = undefined;

  switch (grenade.weapon_name) {
    case "snapshot_grenade_cp":
    case "snapshot_grenade_mp":
      thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(grenade);
      break;
    case "iw8_molotov_zm":
    case "molotov_cp":
    case "molotov_mp":
      thread scripts\cp\powers\coop_molotov::molotov_used(grenade);
      self.last_molotov_throw_time = gettime();
      break;
    case "iw8_armor_marker_cp":
    case "iw8_ammo_marker_cp":
      _id_511E19D41C23E8AA::throwcrate(grenade);
      break;
    case "dud_grenade_zm":
      grenade thread dudgrenadeused(self);
      grenade thread grenade_earthquake();
      break;
    case "thermobaric_grenade_mp":
    case "frag_grenade_zm":
    case "frag_grenade_cp":
    case "frag_grenade_mp":
      if(gettime() - starttime > 1000)
        grenade.iscooked = 1;

      grenade thread watchfraggrenadeexplode();
      grenade.originalowner = self;
      break;
    case "cluster_grenade_zm":
      grenade.clusterticks = grenade.ticks;

      if(grenade.ticks >= 1)
        grenade.iscooked = 1;

      grenade.originalowner = self;
      grenade thread clustergrenadeused();
      grenade thread grenade_earthquake();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_zm":
    case "semtex_mp":
      thread semtexused(grenade);
      break;
    case "gas_grenade_cp":
    case "gas_grenade_mp":
      thread scripts\cp\equipment\cp_gas_grenade::gas_used(grenade);
      break;
    case "hb_sensor_mp":
      thread _id_0EC0F9AD939B29E0::hb_sensor_used(grenade);
      break;
    case "c4_mp":
      thread scripts\cp\cp_c4::c4_used(grenade);
      break;
    case "claymore_mp":
      thread scripts\cp\cp_claymore::claymore_use(grenade);
      break;
    case "at_mine_mp":
      thread scripts\cp\equipment\cp_at_mine::at_mine_use(grenade);
      break;
    case "trophy_cp":
    case "trophy_mp":
      thread scripts\cp\equipment\cp_trophy_system::trophy_used(grenade);
      break;
    case "flare_mp":
      break;
    case "concussion_grenade_mp":
      grenade thread watchconcussiongrenadeexplode();
      break;
    case "bouncing_betty_mp":
      thread mineused(grenade, ::spawnmine);
      break;
    case "throwingknifejugg_mp":
    case "throwingknifec4_mp":
    case "throwingknife_mp":
      level thread throwingknifeused(self, grenade, grenade.weapon_name);
      break;
    case "zom_repulsor_mp":
      grenade delete();
      break;
    case "smoke_grenade_mp":
      grenade thread smokegrenadeused();
      break;
    case "trip_mine_mp":
      break;
    case "flash_grenade_cp":
    case "flash_grenade_mp":
      grenade.ninebangticks = grenade.ticks;
      grenade thread watchflashgrenadeexplode();

      if(grenade.ticks >= 1)
        grenade.iscooked = 1;

      break;
    case "geiger_counter_mp":
      thread _id_3D5C1674387C936E(grenade);
      break;
    case "decoy_grenade_mp":
      thread _id_7B6642E374DC6E4C::decoy_used(grenade);
      break;
    case "shock_stick_mp":
      thread _id_37257C344663C658::_id_054655641D3957E3(grenade);
      break;
    case "sonar_pulse_mp":
      thread _id_14E0AEC82EF0352C::_id_2D117EEB564F6EA3(grenade);
      break;
    case "bunkerbuster_mp":
      thread _id_130B90141EB30189::_id_3D78DD516C25EF77(grenade);
      break;
    case "rock_mp":
      grenade makeunusable();
      thread rock_used(grenade);
      break;
  }

  if(isDefined(grenade)) {
    grenade thread scripts\cp\cp_player_battlechatter::grenadeproximitytracking();
    scripts\cp\cp_player_battlechatter::ongrenadeuse(grenade);
    _id_189B67B2735B981D::_id_0EF6885141252869(self, grenade);
  }
}

rock_used(grenade) {
  grenade scripts\engine\utility::waittill_notify_or_timeout("missile_stuck", 4);
  wait 2;

  if(isDefined(grenade))
    grenade delete();
}

_id_3D5C1674387C936E(grenade) {
  waitframe();

  if(isDefined(grenade))
    grenade delete();

  self notify("geigercounter_putaway");
}

rat_executevisuals(_id_31ED809382E5C603) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::waittill_any_timeout_2(_id_31ED809382E5C603, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

placeequipmentfailed(weapon, _id_DACCA504F8875146, position, angles) {
  if(isPlayer(self))
    self playlocalsound("scavenger_pack_pickup");

  if(istrue(_id_DACCA504F8875146)) {
    fxent = undefined;

    if(isPlayer(self)) {
      if(isDefined(angles))
        fxent = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), position, self, anglesToForward(angles), anglestoup(angles));
      else
        fxent = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), position, self);
    } else
      fxent = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), position);

    triggerfx(fxent);
    thread placeequipmentfailedcleanup(fxent);
  }
}

placeequipmentfailedcleanup(fxent) {
  wait 2;
  fxent delete();
}

spawnmine(origin, owner, weaponname, angles) {
  if(!isDefined(angles))
    angles = (0, randomfloat(360), 0);

  config = level.weaponconfigs[weaponname];
  mine = spawn("script_model", origin);
  mine.angles = angles;
  mine.owner = owner;
  mine.weapon_name = weaponname;
  mine.config = config;
  mine setModel(config.model);
  mine setotherent(owner);
  mine.killcamoffset = (0, 0, 4);
  mine.killcament = spawn("script_model", mine.origin + mine.killcamoffset);
  mine.killcament setscriptmoverkillcam("explosive");
  owner onlethalequipmentplanted(mine);

  if(isDefined(config.mine_beacon))
    mine thread doblinkinglight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);

  _id_088CCE618C00D03C = undefined;

  if(self != level)
    _id_088CCE618C00D03C = self getlinkedparent();

  mine explosivehandlemovers(_id_088CCE618C00D03C);
  mine thread mineproximitytrigger(_id_088CCE618C00D03C);
  mine thread grenade_earthquake();
  mine thread mineselfdestruct();
  mine thread mineexplodeonnotify();
  level thread monitordisownedequipment(owner, mine);
  return mine;
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
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(config.onexplodefunc))
    self thread[[config.onexplodefunc]]();

  if(isDefined(config.onexplodesfx))
    self playSound(config.onexplodesfx);

  onexplodevfx = scripts\engine\utility::ter_op(isDefined(config.onexplodevfx), config.onexplodevfx, level.mine_explode);
  minedamagemin = scripts\engine\utility::ter_op(isDefined(config.minedamagemin), config.minedamagemin, level.minedamagemin);
  minedamagemax = scripts\engine\utility::ter_op(isDefined(config.minedamagemax), config.minedamagemax, level.minedamagemax);
  minedamageradius = scripts\engine\utility::ter_op(isDefined(config.minedamageradius), config.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, minedamageradius, minedamagemax, minedamagemin, attacker, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

mineproximitytrigger(_id_088CCE618C00D03C) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  config = self.config;
  wait(config.armtime);

  if(isDefined(config.mine_beacon))
    thread doblinkinglight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);

  trigger = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  trigger.owner = self;
  trigger.team = trigger.owner.team;
  thread minedeletetrigger(trigger);

  if(isDefined(_id_088CCE618C00D03C)) {
    trigger enablelinkTo();
    trigger linkTo(_id_088CCE618C00D03C);
  }

  self.damagearea = trigger;

  for(;;) {
    trigger waittill("trigger", player);

    if(isPlayer(player)) {
      wait 0.05;
      continue;
    }

    if(player damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(player, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

minedeletetrigger(trigger) {
  scripts\engine\utility::waittill_any_4("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(trigger))
    trigger delete();
}

doblinkinglight(tagname, _id_A351267A57D8CC5A, _id_5E0E0D71B0B44F35) {
  if(!isDefined(_id_A351267A57D8CC5A))
    _id_A351267A57D8CC5A = scripts\engine\utility::getfx("weap_blink_friend");

  if(!isDefined(_id_5E0E0D71B0B44F35))
    _id_5E0E0D71B0B44F35 = scripts\engine\utility::getfx("weap_blink_enemy");

  self.blinkinglightfx["friendly"] = _id_A351267A57D8CC5A;
  self.blinkinglightfx["enemy"] = _id_5E0E0D71B0B44F35;
  self.blinkinglighttag = tagname;
  thread updateblinkinglight(_id_A351267A57D8CC5A, _id_5E0E0D71B0B44F35, tagname);
  self waittill("death");
  stopblinkinglight();
}

updateblinkinglight(_id_A351267A57D8CC5A, _id_5E0E0D71B0B44F35, tagname) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  _id_BBF1092520E9F019 = ::checkteam;

  if(!level.teambased)
    _id_BBF1092520E9F019 = ::checkplayer;

  delay = randomfloatrange(0.05, 0.25);
  wait(delay);
  childthread onjointeamblinkinglight(_id_A351267A57D8CC5A, _id_5E0E0D71B0B44F35, tagname, _id_BBF1092520E9F019);

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(self.owner[[_id_BBF1092520E9F019]](player))
        playfxontagforclients(_id_A351267A57D8CC5A, self, tagname, player);
      else
        playfxontagforclients(_id_5E0E0D71B0B44F35, self, tagname, player);

      wait 0.05;
    }
  }
}

checkplayer(other) {
  return self == other;
}

checkteam(other) {
  return self.team == other.team;
}

onjointeamblinkinglight(_id_A351267A57D8CC5A, _id_5E0E0D71B0B44F35, tagname, _id_BBF1092520E9F019) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", player);

    if(self.owner[[_id_BBF1092520E9F019]](player)) {
      playfxontagforclients(_id_A351267A57D8CC5A, self, tagname, player);
      continue;
    }

    playfxontagforclients(_id_5E0E0D71B0B44F35, self, tagname, player);
  }
}

stopblinkinglight() {
  if(isalive(self) && isDefined(self.blinkinglightfx)) {
    stopFXOnTag(self.blinkinglightfx["friendly"], self, self.blinkinglighttag);
    stopFXOnTag(self.blinkinglightfx["enemy"], self, self.blinkinglighttag);
    self.blinkinglightfx = undefined;
    self.blinkinglighttag = undefined;
  }
}

watchfraggrenadeexplode() {
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "frag_grenade_mp", grenade_owner_name);
}

watchflashgrenadeexplode() {
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "flash_grenade_mp", grenade_owner_name);
}

watchgasgrenadeexplode() {
  owner = self.owner;
  owner endon("disconnect");
  self waittill("explode", position);
  thread ongasgrenadeimpact(owner, position);
}

ongasgrenadeimpact(owner, position) {
  _id_5C50611FD0262121 = spawn("trigger_radius", position, 0, 128, 160);
  _id_5C50611FD0262121.owner = owner;
  _id_E3FA4A87D403BC5E = 128;
  vfx = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), position);
  triggerfx(vfx);
  wait 1.0;

  for(timeremaining = 8.0; timeremaining > 0.0; timeremaining = timeremaining - 0.2) {
    _id_DE491EE80FEED56E = undefined;

    if(isDefined(level.spawned_enemies))
      _id_DE491EE80FEED56E = level.spawned_enemies;
    else
      _id_DE491EE80FEED56E = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(_id_7DC3241E7F3C6B24 in _id_DE491EE80FEED56E) {
      if(isDefined(_id_7DC3241E7F3C6B24.agent_type) && (_id_7DC3241E7F3C6B24.agent_type == "zombie_brute" || _id_7DC3241E7F3C6B24.agent_type == "superslasher" || _id_7DC3241E7F3C6B24.agent_type == "slasher" || _id_7DC3241E7F3C6B24.agent_type == "zombie_grey")) {
        continue;
      }
      _id_6611564090223DAB = getdamagefromzombietype(_id_7DC3241E7F3C6B24);

      if(isalive(_id_7DC3241E7F3C6B24))
        _id_7DC3241E7F3C6B24 applygaseffect(owner, position, _id_5C50611FD0262121, _id_5C50611FD0262121, int(_id_6611564090223DAB));
    }

    wait 0.2;
  }

  vfx delete();
  wait 2.0;
  _id_5C50611FD0262121 delete();

  foreach(_id_7DC3241E7F3C6B24 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(_id_7DC3241E7F3C6B24))
      _id_7DC3241E7F3C6B24.flame_damage_time = undefined;
  }
}

getdamagefromzombietype(victim) {
  if(isalive(victim)) {
    if(istrue(victim.is_suicide_bomber))
      return int(min(1000, victim.maxhealth * 0.25));
    else
      return int(min(1000, victim.maxhealth * 0.1));
  } else
    return 150;
}

applygaseffect(attacker, position, trigger, inflictor, damage) {
  if(isalive(self) && self istouching(trigger)) {
    if(attacker scripts\cp\utility::isenemy(self)) {
      inflictor radiusdamage(self.origin, 1, damage, damage, attacker, "MOD_GRENADE_SPLASH", "gas_mp");
      self.flame_damage_time = gettime() + 200;
    }
  }
}

throwingknifeused(owner, grenade, weaponname) {
  if(weaponname == "throwingknifec4_mp") {
    grenade makeunusable();
    grenade thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(owner, grenade);
  stuckto = undefined;
  _id_16A48D7056E5C472 = undefined;
  grenade waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);
  _id_E13E382321A8580B = isDefined(_id_16A48D7056E5C472) && _id_16A48D7056E5C472 == "tag_flicker";
  _id_582286AF4FFE5B36 = isDefined(_id_16A48D7056E5C472) && _id_16A48D7056E5C472 == "tag_weapon";

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto)) && _id_E13E382321A8580B)
    stuckto notify("shield_hit", grenade);

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto)) && !_id_582286AF4FFE5B36 && !_id_E13E382321A8580B) {
    if(weaponname == "throwingknifec4_mp")
      throwingknifec4detonate(grenade, stuckto, owner);
  }

  grenade.equipmentref = "equip_throwing_knife";
  grenade thread watchgrenadedeath();

  for(;;) {
    grenade waittill("trigger", player);
    player _id_7EF95BBA57DC4B82::_id_91BD2A98062313CB("primary", 1);
  }
}

throwingknifedamagedvictim(attacker, knife) {
  knife endon("death");
  attacker endon("death");
  attacker endon("disconnect");

  for(;;) {
    attacker waittill("victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, sweapon);

    if(isDefined(einflictor) && einflictor == knife) {
      if(sweapon == "throwingknifeteleport_mp" && !isDefined(knife.knifeteleownerinvalid)) {
        throwingknifeteleport(knife, victim, attacker, 1);
        knife.giveknifeback = 1;
      }

      break;
    }
  }
}

watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();
}

throwingknifeteleport(knife, victim, attacker, lerp) {
  attacker playlocalsound("blinkknife_teleport");
  attacker playsoundonmovingent("blinkknife_teleport_npc");
  playsoundatpos(knife.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(attacker, victim);
  corpse = victim getcorpseentity();

  if(isDefined(corpse))
    corpse notsolid();

  _id_45A9094092727403 = [];

  foreach(_id_B5517D24E9DC9A49 in level.characters) {
    if(!isDefined(_id_B5517D24E9DC9A49) || !isalive(_id_B5517D24E9DC9A49) || _id_B5517D24E9DC9A49 == victim || _id_B5517D24E9DC9A49 == attacker || !attacker scripts\cp\utility::isenemy(_id_B5517D24E9DC9A49)) {
      continue;
    }
    _id_45A9094092727403[_id_45A9094092727403.size] = _id_B5517D24E9DC9A49;
  }

  _id_45A9094092727403 = sortbydistance(_id_45A9094092727403, victim.origin);
  _id_E898076217B2E8C3 = attacker gettagorigin("TAG_EYE");
  endpos = victim.origin;
  _id_8BB380999ECB6BD9 = victim.origin + (0, 0, _id_E898076217B2E8C3[2] - attacker.origin[2]);
  endangles = attacker.angles;

  foreach(e in _id_45A9094092727403) {
    _id_CC3FA02194191300 = (e.origin[0], e.origin[1], e gettagorigin("TAG_EYE")[2]);

    if(distancesquared(e.origin, victim.origin) < 230400 && sighttracepassed(_id_8BB380999ECB6BD9, _id_CC3FA02194191300, 0, undefined)) {
      endangles = vectortoangles(_id_CC3FA02194191300 - _id_8BB380999ECB6BD9);
      break;
    }
  }

  attacker setOrigin(victim.origin, !lerp);
  attacker setplayerangles(endangles);
  throwingknifeteleport_fxendburst(attacker, victim);
}

throwingknifeteleport_fxstartburst(player, victim) {
  _id_825A40A809006091 = victim.origin - player.origin;
  _id_A8C3FBFD6C157049 = player.origin + (0, 0, 32);
  forward = vectorNormalize(_id_825A40A809006091);
  right = vectorNormalize(vectorcross(_id_825A40A809006091, (0, 0, 1)));
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  _id_8CBEE39DE74C5DB1 = 0;

  if(_id_8CBEE39DE74C5DB1) {
    fxent = spawn("script_model", _id_A8C3FBFD6C157049);
    fxent.angles = angles;
    fxent setModel("tag_origin");
    fxent hidefromplayer(player);
    waitframe();
    playfxontagforteam(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), fxent, "tag_origin", player.team);
    wait 3.0;
    fxent delete();
  } else {
    _id_348DAF7AC25E8901 = spawn("script_model", _id_A8C3FBFD6C157049);
    _id_348DAF7AC25E8901.angles = angles;
    _id_348DAF7AC25E8901 setModel("tag_origin");
    _id_348DAF7AC25E8901 hidefromplayer(player);
    waitframe();

    foreach(_id_6EE5484560EC747C in level.players)
    _id_348DAF7AC25E8901 hidefromplayer(_id_6EE5484560EC747C);

    playFXOnTag(scripts\engine\utility::getfx("vfx_tele_start_friendly"), _id_348DAF7AC25E8901, "tag_origin");
    wait 3.0;
    _id_348DAF7AC25E8901 delete();
  }
}

recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  _id_23C058E984C5A869 = self.origin;

  for(;;) {
    _id_8BA7F531D6172745 = scripts\engine\utility::waittill_any_timeout_2(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }

    disttravelled = distance(_id_23C058E984C5A869, self.origin);
    self.disttravelled = self.disttravelled + disttravelled;
    _id_23C058E984C5A869 = self.origin;

    if(_id_8BA7F531D6172745 != "timeout") {
      break;
    }
  }
}

throwingknifeteleport_fxendburst(player, victim) {}

throwingknifec4detonate(knife, victim, attacker) {
  victim playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), knife.origin);
  knife radiusdamage(knife.origin, 180, 1200, 600, attacker, "MOD_EXPLOSIVE", knife.weapon_name);
  knife thread grenade_earthquake();
  knife notify("explode", knife.origin);
  knife delete();
}

watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "concussion_grenade_mp", grenade_owner_name);
  childthread stunenemiesinrange(position, self.owner);
  childthread stunplayersinrange(position, self.owner);
}

stunplayersinrange(position, owner) {
  players = level.players;
  _id_6D8E8725698EEFC2 = scripts\engine\utility::get_array_of_closest(position, players, undefined, 24, 256);

  foreach(victim in _id_6D8E8725698EEFC2) {
    if((scripts\cp\utility::is_friendly_damage(victim, owner) && victim != owner) == 0)
      victim thread stundamageonplayers(victim, owner, position);
  }
}

stundamageonplayers(victim, owner, position) {
  _id_73DC87C72D7F6C03 = 3;
  _id_0636C8BE8A25F3A8 = 3;

  if(victim == owner) {
    _id_73DC87C72D7F6C03 = 2;
    _id_0636C8BE8A25F3A8 = 2;
  }

  scale = 1 - distance(victim.origin, position) / 512;

  if(scale < 0)
    scale = 0;

  time = _id_73DC87C72D7F6C03 + _id_0636C8BE8A25F3A8 * scale;
  owner notify("stun_hit");
  victim notify("concussed", owner);
  victim scripts\cp\utility::setplayerstunned();
  victim thread cleanupconcussionstun(time);
  victim shellshock("concussion_grenade_mp", time);
  victim.concussionendtime = gettime() + time * 1000;
}

cleanupconcussionstun(time) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(time);
  scripts\cp\utility::setplayerunstunned();
}

stunenemiesinrange(position, owner) {
  enemies = scripts\engine\utility::array_combine(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), scripts\cp\cp_agent_utils::getaliveagentsofteam("team_three"));
  closestenemies = scripts\engine\utility::get_array_of_closest(position, enemies, undefined, 24, 500);

  foreach(victim in closestenemies) {
    if(isagent(victim))
      victim notify("flashbang", victim.origin, 1, 1, owner, "axis");

    victim thread fx_stun_damage(victim, owner);
  }
}

fx_stun_damage(victim, eattacker) {
  victim endon("death");

  if(isDefined(victim.stun_hit_time)) {
    if(gettime() > victim.stun_hit_time) {
      victim.allowpain = 1;
      victim.stun_hit_time = gettime() + 1000;
      victim.stunned = 1;
      victim thread reduce_accuracy_while_stunned();
    } else
      return;
  } else {
    victim.allowpain = 1;
    victim.stun_hit_time = gettime() + 1000;
    victim.stunned = 1;
    victim thread reduce_accuracy_while_stunned();
  }

  victim dodamage(1, victim.origin, eattacker, eattacker, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 10;
  victim.allowpain = 0;
  victim.stunned = undefined;
}

reduce_accuracy_while_stunned() {
  self endon("death");
  self notify("sturn_accuracy_reduction");
  self endon("sturn_accuracy_reduction");

  if(self.baseaccuracy != 0)
    self.old_accuracy = self.baseaccuracy;

  self.baseaccuracy = 0;

  while(istrue(self.stunned))
    waitframe();

  if(isDefined(self.old_accuracy))
    self.baseaccuracy = self.old_accuracy;
}

mineused(grenade, spawnfunc) {
  if(!isalive(self)) {
    grenade delete();
    return;
  }

  grenade thread minethrown(self, grenade.weapon_name, spawnfunc);
}

minethrown(owner, weaponname, spawnfunc, _id_FBF2BD8B1706FE46) {
  self.owner = owner;
  self waittill("missile_stuck", stuckto);

  if(!isDefined(owner)) {
    return;
  }
  if(weaponname != "trip_mine_mp") {
    if(isDefined(stuckto) && isDefined(stuckto.owner)) {
      if(isDefined(_id_FBF2BD8B1706FE46))
        self.owner[[_id_FBF2BD8B1706FE46]](self);

      self delete();
      return;
    }
  }

  trace = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  pos = trace["position"];

  if(trace["fraction"] == 1) {
    pos = getgroundposition(self.origin, 12, 0, 32);
    trace["normal"] = trace["normal"] * -1;
  }

  normal = vectorNormalize(trace["normal"]);
  _id_097019A6D379D522 = vectortoangles(normal);
  _id_097019A6D379D522 = _id_097019A6D379D522 + (90, 0, 0);
  mine = [[spawnfunc]](pos, owner, weaponname, _id_097019A6D379D522);
  mine thread minedamagemonitor();
  self delete();
}

minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(is_hive_explosion(attacker, type)) {
      break;
    }

    if(!isPlayer(attacker) && !isagent(attacker)) {
      if(!isDefined(attacker.owner) || !isPlayer(attacker.owner))
        continue;
      else
        attacker = attacker.owner;
    }

    if(isDefined(objweapon) && isendstr(objweapon.basename, "betty_mp")) {
      continue;
    }
    if(!_id_25845ACA699D038D::friendlyfirecheck(self.owner, attacker)) {
      continue;
    }
    if(isDefined(objweapon)) {
      switch (objweapon.basename) {
        case "smoke_grenadejugg_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE")))
    self.waschained = 1;

  if(isDefined(idflags) && idflags &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  self.wasdamaged = 1;

  if(isDefined(attacker))
    self.damagedby = attacker;

  self notify("detonateExplosive", attacker);
}

is_hive_explosion(attacker, type) {
  if(!isDefined(attacker) || !isDefined(attacker.classname))
    return 0;

  return attacker.classname == "scriptable" && type == "MOD_EXPLOSIVE";
}

explosivetrigger(target, graceperiod, _id_DEE1E90C5A8243B7) {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);

  if(isPlayer(target) && target scripts\cp\utility::_hasperk("specialty_delaymine")) {
    target notify("triggeredExpl", _id_DEE1E90C5A8243B7);
    graceperiod = level.delayminetime;
  }

  wait(graceperiod);
}

shouldaffectclaymore(_id_656F0AE440B1B5D5) {
  if(isDefined(_id_656F0AE440B1B5D5.disabled))
    return 0;

  pos = self.origin + (0, 0, 32);
  _id_43439C7867F57F5D = pos - _id_656F0AE440B1B5D5.origin;
  _id_3ED85F41DB72266A = anglesToForward(_id_656F0AE440B1B5D5.angles);
  dist = vectordot(_id_43439C7867F57F5D, _id_3ED85F41DB72266A);

  if(dist < level.claymoredetectionmindist)
    return 0;

  _id_43439C7867F57F5D = vectorNormalize(_id_43439C7867F57F5D);
  dot = vectordot(_id_43439C7867F57F5D, _id_3ED85F41DB72266A);
  return dot > level.claymoredetectiondot;
}

deleteondeath(ent) {
  self waittill("death");
  self setscriptablepartstate("destroy", "active", 0);
  wait 0.05;

  if(isDefined(ent)) {
    if(isDefined(ent.trigger))
      ent.trigger delete();

    ent delete();
  }
}

onlethalequipmentplanted(_id_40D7EA0D7A20A4E3, _id_DC34121B4BB07FB9, _id_959103EE6629EA1D) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(istrue(_id_959103EE6629EA1D))
        self.plantedlethalequip[0] notify("detonateExplosive");
      else
        self.plantedlethalequip[0] deleteexplosive();
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = _id_40D7EA0D7A20A4E3;
  entnum = _id_40D7EA0D7A20A4E3 getentitynumber();
  level.mines[entnum] = _id_40D7EA0D7A20A4E3;
  level notify("mine_planted");
}

add_to_mine_list(_id_40D7EA0D7A20A4E3) {
  entnum = _id_40D7EA0D7A20A4E3 getentitynumber();
  level.mines[entnum] = _id_40D7EA0D7A20A4E3;
}

clustergrenadeused() {
  owner = self.originalowner;
  owner endon("disconnect");
  thread ownerdisconnectcleanup(owner);
  _id_6ADA3242ACD08CF5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_6ADA3242ACD08CF5[_id_AC0E594AC96AA3A8] = 0.2;

  _id_3FAAD2422C09B784 = 0;

  foreach(delay in _id_6ADA3242ACD08CF5)
  _id_3FAAD2422C09B784 = _id_3FAAD2422C09B784 + delay;

  killcament = spawn("script_model", self.origin);
  killcament linkTo(self);
  killcament setModel("tag_origin");
  killcament setscriptmoverkillcam("explosive");
  killcament thread deathdelaycleanup(self, _id_3FAAD2422C09B784 + 5);
  killcament thread ownerdisconnectcleanup(self.owner);
  killcament.threwback = self.threwback;
  _id_D5EEAA5B2B8B2F6F = owner scripts\cp\utility::_launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  _id_D5EEAA5B2B8B2F6F linkTo(self);
  _id_D5EEAA5B2B8B2F6F thread deathdelaycleanup(self, _id_3FAAD2422C09B784);
  _id_D5EEAA5B2B8B2F6F thread ownerdisconnectcleanup(self.owner);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", position);
  thread clustergrenadeexplode(position, _id_6ADA3242ACD08CF5, owner, killcament);
}

clustergrenadeexplode(position, _id_6ADA3242ACD08CF5, owner, killcament) {
  owner endon("disconnect");
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  _id_3234DF3086482E07 = 0;
  start = position + (0, 0, 3);
  end = start + (0, 0, -5);
  _id_E021C2744CC7ED68 = physics_raycast(start, end, contents, undefined, 0, "physicsquery_closest");

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
    _id_3234DF3086482E07 = 1;

  _id_046E78EFB23851CA = scripts\engine\utility::ter_op(_id_3234DF3086482E07, (0, 0, 32), (0, 0, 2));
  _id_F0F1E7230EDECB24 = position + _id_046E78EFB23851CA;
  _id_39A64EF99549E28E = randomint(90) - 45;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    killcament.shellshockondamage = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 == 0, 1, undefined);
    killcament radiusdamage(position, 256, 800, 400, owner, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    yaw = scripts\engine\utility::ter_op(_id_AC0E594AC96AA3A8 < 4, 90 * _id_AC0E594AC96AA3A8 + _id_39A64EF99549E28E, randomint(360));
    _id_8870C770846C1A02 = scripts\engine\utility::ter_op(_id_3234DF3086482E07, 110, 90);
    _id_EC3409E80A52CF3A = scripts\engine\utility::ter_op(_id_3234DF3086482E07, 12, 45);
    pitch = _id_8870C770846C1A02 + randomint(_id_EC3409E80A52CF3A * 2) - _id_EC3409E80A52CF3A;
    dist = randomint(60) + 30;
    x = cos(yaw) * sin(pitch);
    y = sin(yaw) * sin(pitch);
    z = cos(pitch);
    offset = (x, y, z) * dist;
    start = _id_F0F1E7230EDECB24;
    end = _id_F0F1E7230EDECB24 + offset;
    _id_E021C2744CC7ED68 = physics_raycast(start, end, contents, undefined, 0, "physicsquery_closest");

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0)
      end = _id_E021C2744CC7ED68[0]["position"];

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), end);

    switch (_id_AC0E594AC96AA3A8) {
      case 0:
        playsoundatpos(end, "iw9_frag_grenade_expl_trans");
        break;
      case 3:
        playsoundatpos(end, "cluster_explode_end");
        break;
      default:
        playsoundatpos(end, "cluster_explode_mid");
    }

    wait(_id_6ADA3242ACD08CF5[_id_AC0E594AC96AA3A8]);
  }
}

deathdelaycleanup(grenade, duration) {
  self endon("death");
  grenade waittill("death");
  wait(duration);
  self delete();
}

ownerdisconnectcleanup(owner) {
  self endon("death");
  owner waittill("disconnect");
  self delete();
}

semtexused(grenade) {
  if(!isDefined(grenade)) {
    return;
  }
  grenade.originalowner = self;
  grenade setentityowner(self);
  grenade setotherent(self);
  grenade thread semtex_watch_cleanup();
  grenade thread semtex_watch_fuse();
  grenade_owner_name = grenade.owner.name;
  grenade waittill("missile_stuck", stuckto);

  if(isagent(stuckto) && !istrue(stuckto._id_274D3A7704E351EF)) {
    if(!isDefined(stuckto._id_F8ECC64162438D76))
      stuckto._id_F8ECC64162438D76 = [];
    else
      stuckto._id_F8ECC64162438D76 = scripts\engine\utility::array_removedead(stuckto._id_F8ECC64162438D76);

    stuckto._id_F8ECC64162438D76 = scripts\engine\utility::array_add(stuckto._id_F8ECC64162438D76, grenade);
    scripts\common\ai::_id_60DAA23100A2B874(grenade, stuckto);
  }

  level notify("grenade_exploded_during_stealth", grenade.origin, "semtex_mp", grenade_owner_name);
  grenade thread grenade_earthquake();
  grenade explosivehandlemovers(undefined);
}

semtex_watch_fuse() {
  self endon("death");
  wait 2;
  thread semtex_explode();
}

semtex_explode() {
  thread semtex_delete(0.1);
}

semtex_destroy() {
  thread semtex_delete(0.1);
}

semtex_delete(delay) {
  self notify("death");
  self.exploding = 1;
  wait(delay);
  self delete();
}

semtex_watch_cleanup() {
  self endon("death");
  semtex_watch_cleanup_end_early();

  if(isDefined(self))
    thread semtex_destroy();
}

semtex_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;)
    waitframe();
}

attachmentisdefault(_id_55F8624E7216D9AA) {
  return isDefined(_id_55F8624E7216D9AA) && (scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "rec") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "front") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "back") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "mag") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "guard") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "triggrip") || scripts\engine\utility::string_starts_with(_id_55F8624E7216D9AA, "toprail"));
}

remove_attachment(attachment, player, weapon) {
  if(!isDefined(attachment) && !isDefined(player)) {
    return;
  }
  weapons = [];
  _id_CEB40E0D9504F27A = undefined;
  _id_82533969B4683DE4 = undefined;

  if(isDefined(weapon)) {
    if(isweapon(weapon))
      weapons[weapons.size] = weapon;
    else
      weapons[weapons.size] = makeweaponfromstring(weapon);
  } else
    weapons = player getweaponslistall();

  foreach(item in weapons) {
    if(item hasattachment(attachment)) {
      _id_62E770EA80D43309 = scripts\cp\utility::getrawbaseweaponname(item);
      baseweapon = getweaponbasename(item);
      player takeweapon(item);
      attachments = getweaponattachments(item);

      foreach(_id_104A0214A4EEC589 in attachments) {
        if(issubstr(_id_104A0214A4EEC589, attachment)) {
          attachments = scripts\engine\utility::array_remove(attachments, _id_104A0214A4EEC589);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func))
        _id_82533969B4683DE4 = player[[level.build_weapon_name_func]](baseweapon, attachments);

      if(isDefined(_id_82533969B4683DE4)) {
        weapons = self getweaponslistprimaries();

        foreach(weapon in weapons) {
          if(issubstr(weapon.basename, _id_82533969B4683DE4.basename)) {
            if(weapon.isalternate) {
              baseweapon = getweaponbasename(weapon);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, baseweapon)) {
                _id_82533969B4683DE4 = _id_82533969B4683DE4 getaltweapon();
                break;
              }
            }
          }
        }

        player scripts\cp\utility::_giveweapon(_id_82533969B4683DE4, -1, -1, 1);
        player switchtoweapon(_id_82533969B4683DE4);
      }
    }
  }
}

has_weapon_variation(weapon) {
  _id_BC002676438672C9 = self getweaponslistall();
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  foreach(primaryweapon in _id_BC002676438672C9) {
    baseweapon = scripts\cp\utility::getrawbaseweaponname(weaponname);
    _id_442713EFDF839B74 = scripts\cp\utility::getrawbaseweaponname(primaryweapon);

    if(baseweapon == _id_442713EFDF839B74)
      return 1;
  }

  return 0;
}

get_weapon_variation_obj(weapon) {
  _id_BC002676438672C9 = self getweaponslistall();
  result = [];
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  foreach(primaryweapon in _id_BC002676438672C9) {
    baseweapon = scripts\cp\utility::getrawbaseweaponname(weaponname);
    _id_442713EFDF839B74 = scripts\cp\utility::getrawbaseweaponname(primaryweapon);

    if(baseweapon == _id_442713EFDF839B74)
      result[result.size] = primaryweapon;
  }

  return result;
}

grenade_earthquake(_id_7BB0EAC0599AA23D) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(_id_7BB0EAC0599AA23D) || _id_7BB0EAC0599AA23D)
    self waittill("explode", position);
  else
    position = self.origin;

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.5, 0.75, position, 800);

  foreach(player in level.players) {
    if(player scripts\cp\utility::isusingremote()) {
      continue;
    }
    if(distancesquared(position, player.origin) > 360000) {
      continue;
    }
    if(player damageconetrace(position))
      player thread dirteffect(position);

    player setclientomnvar("ui_hud_shake", 1);
  }
}

endondeath() {
  self waittill("death");
  waittillframeend;
  self notify("end_explode");
}

dirteffect(position) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  forwardvec = vectorNormalize(anglesToForward(self.angles));
  _id_6F0E7A5743E7A561 = vectorNormalize(anglestoright(self.angles));
  _id_2281000002D7B901 = vectorNormalize(position - self.origin);
  _id_C30A3F9960924930 = vectordot(_id_2281000002D7B901, forwardvec);
  _id_4946DDC5DDED5B64 = vectordot(_id_2281000002D7B901, _id_6F0E7A5743E7A561);
  _id_AB9868B0589A6052 = ["death", "damage"];
  currentweapon = self getcurrentweapon();

  if(_id_C30A3F9960924930 > 0 && _id_C30A3F9960924930 > 0.5 && currentweapon.basename != "iw6_riotshield_mp")
    scripts\engine\utility::waittill_any_in_array_or_timeout(_id_AB9868B0589A6052, 2.0);
  else if(abs(_id_C30A3F9960924930) < 0.866) {
    if(_id_4946DDC5DDED5B64 > 0)
      scripts\engine\utility::waittill_any_in_array_or_timeout(_id_AB9868B0589A6052, 2.0);
    else
      scripts\engine\utility::waittill_any_in_array_or_timeout(_id_AB9868B0589A6052, 2.0);
  }
}

shellshockondamage(cause, damage) {
  if(isflashbanged()) {
    return;
  }
  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction)
        self shellshock("damage_cp", self.shellshockreduction);
      else
        self shellshock("damage_cp", 0.5);
    }
  }
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

isakimbo(weapon) {
  if(isDefined(weapon.others)) {
    foreach(attachment in weapon.others) {
      if(issubstr(attachment, "akimbo"))
        return 1;
    }
  }

  return 0;
}

waittill_grenade_fire() {
  for(;;) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(isDefined(self.throwinggrenade) && objweapon.basename != self.throwinggrenade) {
      continue;
    }
    if(isDefined(grenade)) {
      if(!isDefined(grenade.weapon_obj))
        grenade.weapon_obj = objweapon;

      if(!isDefined(grenade.weapon_name))
        grenade.weapon_name = objweapon.basename;

      if(!isDefined(grenade.owner))
        grenade.owner = self;

      if(!isDefined(grenade.team))
        grenade.team = self.team;

      if(!isDefined(grenade.ticks) && isDefined(self.throwinggrenade))
        grenade.ticks = scripts\cp\utility::roundup(4 * tickpercent);
    }

    grenadeinitialize(grenade, objweapon, tickpercent, originalowner);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", grenade, objweapon.basename);
      self.throwndyinggrenade = 1;
    }

    if(istrue(grenade.threwback)) {
      slot = _id_7EF95BBA57DC4B82::getequipmentslotammo("primary");

      if(isDefined(slot) && slot >= 1)
        _id_7EF95BBA57DC4B82::_id_91BD2A98062313CB("primary", 1);
    }

    return grenade;
  }
}

grenadestuckto(grenade, stuckto, _id_05F6265D8D7EE3C8) {
  if(!isDefined(self)) {
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
  } else if(level.teambased && scripts\engine\utility::is_equal(stuckto.team, self.team))
    grenade.isstuck = "friendly";
  else {
    _id_D658F0B6BC4FD513 = undefined;
    _id_0D5F11D86F917656 = undefined;

    if(!isDefined(grenade.weapon_name)) {
      return;
    }
    switch (grenade.weapon_name) {
      case "semtex_mp":
        _id_D658F0B6BC4FD513 = "semtex_stuck";
        _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
        break;
      case "molotov_mp":
        _id_D658F0B6BC4FD513 = "molotov_stuck";
        _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
        break;
      case "pop_rocket_proj_mp":
        _id_D658F0B6BC4FD513 = "flare_gun_attacker_stuck";
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
        _id_D658F0B6BC4FD513 = "bunkerbuster_stuck";
        _id_0D5F11D86F917656 = "stat_CAFA7AD7442C35D5";
        break;
    }

    grenade.isstuck = "enemy";
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    self notify("grenade_stuck_enemy");

    if(!istrue(_id_05F6265D8D7EE3C8))
      grenadestucktosplash(_id_D658F0B6BC4FD513, stuckto);
  }
}

grenadestucktosplash(_id_D658F0B6BC4FD513, stuckto) {
  player = self;
  player thread _id_293BC33BD79CABD1::killeventtextpopup("stat_3B7863DCDFF98B13", 0);
}

get_possible_attachments_by_weaponclass(_id_0DD6BF5F9DBA888C, weapon, _id_EFFB4AE1788A8B10) {
  if(!isDefined(_id_0DD6BF5F9DBA888C))
    return 0;

  if(!isDefined(weapon))
    return 0;

  if(!isDefined(_id_EFFB4AE1788A8B10))
    return 0;

  return 1;
}

getattachmenttypeslist(weaponname, _id_2FBD0E943F095064) {
  attachments = scripts\cp\utility::getweaponattachmentarrayfromstats(weaponname);
  list = [];

  foreach(attachment in attachments) {
    _id_F98BAFD67872A38C = scripts\cp\utility::getattachmenttype(attachment);

    if(isDefined(_id_2FBD0E943F095064) && scripts\cp\utility::listhasattachment(_id_2FBD0E943F095064, attachment)) {
      continue;
    }
    if(!isDefined(list[_id_F98BAFD67872A38C]))
      list[_id_F98BAFD67872A38C] = [];

    _id_3A974E1DFD9D5CCC = list[_id_F98BAFD67872A38C];
    _id_3A974E1DFD9D5CCC[_id_3A974E1DFD9D5CCC.size] = attachment;
    list[_id_F98BAFD67872A38C] = _id_3A974E1DFD9D5CCC;
  }

  return list;
}

getattachmentlistbasenames() {
  _id_3A974E1DFD9D5CCC = [];
  _id_19B427D846597F48 = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(table in _id_19B427D846597F48) {
    _id_977F24E61599CBBA = tablelookupgetnumrows(table);

    for(index = 0; index < _id_977F24E61599CBBA; index++) {
      _id_659F734FC2A248FF = tablelookupbyrow(table, index, 5);
      group = tablelookupbyrow(table, index, 2);

      if(_id_659F734FC2A248FF != "" && group != "none" && !scripts\engine\utility::array_contains(_id_3A974E1DFD9D5CCC, _id_659F734FC2A248FF))
        _id_3A974E1DFD9D5CCC[_id_3A974E1DFD9D5CCC.size] = _id_659F734FC2A248FF;
    }
  }

  return _id_3A974E1DFD9D5CCC;
}

_id_9BA246F8C51923DA() {
  thread setweaponlaser_internal();
}

setweaponlaser_internal() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  weapon = self getcurrentweapon();

  for(;;) {
    setweaponlaser_waitforlaserweapon(weapon);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1.0);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", weapon);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      disableweaponlaser();
    }
  }
}

setweaponlaser_waitforlaserweapon(weapon) {
  for(;;) {
    if(isDefined(weapon) && (weapon.basename == "iw6_kac_mp" || weapon.basename == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", weapon);
  }
}

setweaponlaser_monitorads() {
  self endon("weapon_change");

  for(;;) {
    if(!isDefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0) {
      if(self playerads() > 0.6) {
        if(self.perkweaponlaseron == 1) {
          self.perkweaponlaseron = 0;
          disableweaponlaser();
        }
      } else if(self.perkweaponlaseron == 0) {
        self.perkweaponlaseron = 1;
        enableweaponlaser();
      }
    }

    waitframe();
  }
}

setweaponlaser_monitorweaponswitchstart(_id_57052F010A23838F) {
  self endon("weapon_change");

  for(;;) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(_id_57052F010A23838F);
  }
}

setweaponlaser_onweaponswitchstart(_id_57052F010A23838F) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait(_id_57052F010A23838F);
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls))
    self.weaponlasercalls = 0;

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

ondetonateexplosive(notifystring) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(notifystring))
    self.owner notify(notifystring, 1);
  else
    self.owner notify("powers_c4_used", 1);

  self detonate(self.owner);
}

cleanupexplosivesondeath() {
  self endon("deleted_equipment");
  level endon("game_ended");
  _id_3397EC8092BCDDE5 = self getentitynumber();
  _id_E9CAE9957EACB9FB = self.killcament;
  _id_63B78A72AA2DF5F9 = self.trigger;
  _id_150BC605DFCC72B9 = self.sensor;
  self waittill("death");
  cleanupequipment(_id_3397EC8092BCDDE5, _id_E9CAE9957EACB9FB, _id_63B78A72AA2DF5F9, _id_150BC605DFCC72B9);
}

cleanupequipment(_id_3397EC8092BCDDE5, _id_E9CAE9957EACB9FB, _id_63B78A72AA2DF5F9, _id_150BC605DFCC72B9) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "c4_mp")
      self.owner notify("c4_update", 0);
    else if(self.weapon_name == "bouncing_betty_mp")
      self.owner notify("bouncing_betty_update", 0);
    else if(self.weapon_name == "sticky_mine_mp")
      self.owner notify("sticky_mine_update", 0);
    else if(self.weapon_name == "trip_mine_mp")
      self.owner notify("trip_mine_update", 0);
    else if(self.weapon_name == "cryo_grenade_mp")
      self.owner notify("restart_cryo_grenade_cooldown", 0);
  }

  if(isDefined(_id_3397EC8092BCDDE5))
    level.mines[_id_3397EC8092BCDDE5] = undefined;

  if(isDefined(_id_E9CAE9957EACB9FB))
    _id_E9CAE9957EACB9FB delete();

  if(isDefined(_id_63B78A72AA2DF5F9))
    _id_63B78A72AA2DF5F9 delete();

  if(isDefined(_id_150BC605DFCC72B9))
    _id_150BC605DFCC72B9 delete();
}

monitordamage(maxhealth, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB, rumble) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(rumble))
    rumble = 0;

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = maxhealth;
  self.damagetaken = 0;

  if(!isDefined(_id_A1823AC1157568DB))
    _id_A1823AC1157568DB = 0;

  for(running = 1; running; running = monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(rumble)
      self playRumbleOnEntity("damage_light");

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers))
        self.attackers = [];

      uniqueid = "";

      if(isDefined(attacker) && isPlayer(attacker))
        uniqueid = attacker scripts\cp\utility::getuniqueid();

      if(isDefined(self.attackers[uniqueid]))
        self.attackers[uniqueid] = self.attackers[uniqueid] + damage;
      else
        self.attackers[uniqueid] = damage;
    }
  }
}

monitordamageend() {
  self notify("monitorDamageEnd");
  self.damagetaken = undefined;
  self.attackers = undefined;
  self.wasdamaged = undefined;
  self.wasdamagedfrombulletpenetration = undefined;
  self.wasdamagedfrombulletricochet = undefined;
  self setCanDamage(0);
}

monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, _id_C5D89C3A1224B118, _id_D7B6456018542238, _id_A1823AC1157568DB) {
  if(!isDefined(self))
    return 0;

  if(isDefined(attacker) && !_id_25845ACA699D038D::friendlyfirecheck(self.owner, attacker)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else
      return 1;
  }

  _id_702BFC08FABD86CB = damage;

  if(isDefined(objweapon)) {
    if(non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath))
      return 1;
  }

  damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

  if(!isDefined(_id_D7B6456018542238))
    _id_D7B6456018542238 = _id_25845ACA699D038D::modifydamage;

  _id_702BFC08FABD86CB = self[[_id_D7B6456018542238]](damagedata);

  if(_id_702BFC08FABD86CB <= 0)
    return 1;

  self.wasdamaged = 1;
  self.damagetaken = self.damagetaken + _id_702BFC08FABD86CB;
  self.health = 2147483647;

  if(istrue(_id_A1823AC1157568DB))
    scripts\cp\utility::killstreakhit(attacker, objweapon, self, meansofdeath, _id_702BFC08FABD86CB);

  if(isDefined(attacker)) {
    if(isPlayer(attacker))
      attacker _id_354C862768CFE202::updatedamagefeedback(damagefeedback);
  }

  if(self.damagetaken >= self.maxhealth) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);
    self thread[[_id_C5D89C3A1224B118]](damagedata);
    return 0;
  }

  return 1;
}

non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath) {
  if(non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath))
    return 1;

  if(isDefined(objweapon.basename)) {
    if(meansofdeath != "MOD_MELEE") {
      switch (objweapon.basename) {
        case "iw8_green_beam_mp":
        case "iw8_spotter_scope_mp":
          return 1;
      }
    }

    if(meansofdeath == "MOD_IMPACT") {
      switch (objweapon.basename) {
        case "semtex_mp":
        case "claymore_mp":
        case "at_mine_mp":
        case "c4_mp":
        case "thermite_mp":
          return 1;
      }
    } else {
      switch (objweapon.basename) {
        case "emp_drone_player_mp":
        case "claymore_radial_mp":
        case "snapshot_grenade_mp":
        case "flash_grenade_mp":
        case "concussion_grenade_mp":
        case "gas_mp":
        case "thermite_ap_mp":
          return 1;
      }
    }
  }

  return 0;
}

non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamagesignatures))
    return 0;

  if(isDefined(objweapon) && isstring(objweapon))
    objweapon = makeweapon(objweapon);

  foreach(_id_9A967AA676F4B959 in self.ignoredamagesignatures) {
    if(!isDefined(_id_9A967AA676F4B959))
      return 0;

    if(_id_9A967AA676F4B959.checkattacker) {
      if(!isDefined(_id_9A967AA676F4B959.attacker)) {
        non_player_remove_ignore_damage_signature(_id_9A967AA676F4B959.id);
        continue;
      } else if(!isDefined(attacker))
        continue;
      else if(attacker != _id_9A967AA676F4B959.attacker)
        continue;
    }

    if(_id_9A967AA676F4B959.checkobjweapon) {
      if(!isDefined(objweapon) || isnullweapon(objweapon))
        continue;
      else if(objweapon != _id_9A967AA676F4B959.objweapon)
        continue;
    }

    if(_id_9A967AA676F4B959.checkinflictor) {
      if(!isDefined(_id_9A967AA676F4B959.inflictor)) {
        non_player_remove_ignore_damage_signature(_id_9A967AA676F4B959.id);
        continue;
      } else if(!isDefined(inflictor))
        continue;
      else if(inflictor != _id_9A967AA676F4B959.inflictor)
        continue;
    }

    if(_id_9A967AA676F4B959.checkmeansofdeath) {
      if(!isDefined(meansofdeath))
        continue;
      else if(meansofdeath != _id_9A967AA676F4B959.meansofdeath)
        continue;
    }

    return 1;
  }

  return 0;
}

non_player_remove_ignore_damage_signature(id) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }
  self.ignoredamagesignatures[id] = undefined;
}

non_player_add_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamageid))
    self.ignoredamageid = 0;

  if(!isDefined(self.ignoredamagesignatures))
    self.ignoredamagesignatures = [];

  id = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(objweapon) && isstring(objweapon))
    objweapon = makeweapon(objweapon);

  _id_9A967AA676F4B959 = spawnStruct();
  _id_9A967AA676F4B959.id = id;
  _id_9A967AA676F4B959.attacker = attacker;
  _id_9A967AA676F4B959.objweapon = objweapon;
  _id_9A967AA676F4B959.inflictor = inflictor;
  _id_9A967AA676F4B959.meansofdeath = meansofdeath;
  _id_9A967AA676F4B959.checkattacker = isDefined(attacker);
  _id_9A967AA676F4B959.checkobjweapon = isDefined(objweapon) && !isnullweapon(objweapon);
  _id_9A967AA676F4B959.checkinflictor = isDefined(inflictor);
  _id_9A967AA676F4B959.checkmeansofdeath = isDefined(meansofdeath);
  self.ignoredamagesignatures[id] = _id_9A967AA676F4B959;
  return id;
}

explosivehandlemovers(parent, _id_B5F7C0806632D99B) {
  data = spawnStruct();
  data.linkparent = parent;
  data.deathoverridecallback = ::movingplatformdetonate;
  data.endonstring = "death";

  if(!isDefined(_id_B5F7C0806632D99B) || !_id_B5F7C0806632D99B)
    data.invalidparentoverridecallback = scripts\cp\cp_movers::moving_platform_empty_func;

  thread scripts\cp\cp_movers::handle_moving_platforms(data);
}

movingplatformdetonate(data) {
  if(!isDefined(data.lasttouchedplatform) || !isDefined(data.lasttouchedplatform.destroyexplosiveoncollision) || data.lasttouchedplatform.destroyexplosiveoncollision)
    self notify("detonateExplosive");
}

makeexplosiveusable() {
  if(self.owner scripts\cp_mp\utility\player_utility::_isalive()) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin + getexplosiveusableoffset());
    self.trigger.owner = self;
    thread equipmentwatchuse(self.owner, 1);
  }
}

isplantedequipment(ent) {
  return isDefined(level.mines[ent getentitynumber()]) || istrue(ent.planted);
}

equipmentwatchuse(owner, _id_51BAE54BDE94FB33) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setCursorHint("HINT_NOICON");
  self.trigger _id_1DB8D0E02A99C5E2::setexplosiveusablehintstring(self.weapon_name);
  self.trigger scripts\cp\utility::setselfusable(owner);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(owner);

  if(isDefined(_id_51BAE54BDE94FB33) && _id_51BAE54BDE94FB33)
    thread updatetriggerposition();

  for(;;) {
    self.trigger waittill("trigger", owner);
    owner notify("pickup_equipment", self.weapon_name);
    owner setweaponammostock(self.weapon_name, owner getweaponammostock(self.weapon_name) + 1);
    deleteexplosive();
    self notify("death");
  }
}

updatetriggerposition() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin + getexplosiveusableoffset();

      if(isDefined(self.bombsquadmodel))
        self.bombsquadmodel.origin = self.origin;
    } else
      return;

    wait 0.05;
  }
}

deleteexplosive(pickedup) {
  if(isDefined(self)) {
    if(isDefined(self.deletefunc)) {
      self thread[[self.deletefunc]]();
      self notify("deleted_equipment");
    } else {
      _id_3397EC8092BCDDE5 = self getentitynumber();
      _id_E9CAE9957EACB9FB = self.killcament;
      _id_63B78A72AA2DF5F9 = self.trigger;
      _id_150BC605DFCC72B9 = self.sensor;
      cleanupequipment(_id_3397EC8092BCDDE5, _id_E9CAE9957EACB9FB, _id_63B78A72AA2DF5F9, _id_150BC605DFCC72B9);
      self notify("deleted_equipment");
      self delete();
    }
  }
}

ontacticalequipmentplanted(_id_290D0681688FC94C, equipmentref, deletefunc) {
  _id_290D0681688FC94C.equipmentref = equipmentref;
  _id_290D0681688FC94C.deletefunc = deletefunc;
  _id_290D0681688FC94C.planted = 1;

  if(!istrue(_id_290D0681688FC94C.issuper)) {
    if(self.plantedtacticalequip.size) {
      self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

      if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= getmaxplantedtacticalequip(self))
        self.plantedtacticalequip[0] deleteexplosive();
    }

    self.plantedtacticalequip[self.plantedtacticalequip.size] = _id_290D0681688FC94C;
  }

  entnum = _id_290D0681688FC94C getentitynumber();
  level.mines[entnum] = _id_290D0681688FC94C;
  level notify("mine_planted");
}

getmaxplantedtacticalequip(player) {
  _id_30DC1C5E4B8568B0 = 0;
  _id_30DC1C5E4B8568B0 = 4;
  return _id_30DC1C5E4B8568B0;
}

equipmentdeathvfx(sfx) {
  fxent = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(fxent);

  if(!isDefined(sfx) || sfx == 0)
    self playSound("sentry_explode");

  fxent thread scripts\cp\utility::delayentdelete(1);
}

equipmentdeletevfx() {
  fxent = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(fxent);
  self playSound("mp_killstreak_disappear");
  fxent thread scripts\cp\utility::delayentdelete(1);
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

isprimaryweapon(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  if(weaponinventorytype(weapon) != "primary")
    return 0;

  switch (weaponclass(weapon)) {
    case "smg":
    case "rocketlauncher":
    case "sniper":
    case "rifle":
    case "pistol":
    case "spread":
    case "mg":
      return 1;
    default:
      return 0;
  }
}

getexplosiveusableoffset() {
  upvec = anglestoup(self.angles);
  return 10 * upvec;
}

is_incompatible_weapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, weaponname))
      return 1;
  }

  return 0;
}

get_weapon_level(weapon) {
  if(!isPlayer(self))
    return int(1);

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  if(isDefined(self.pap[weaponname]))
    return self.pap[weaponname].lvl;

  _id_9211CDAADB7BCA55 = scripts\cp\utility::getrawbaseweaponname(weaponname);

  if(isDefined(self.pap[_id_9211CDAADB7BCA55]))
    return self.pap[_id_9211CDAADB7BCA55].lvl;

  return int(1);
}

can_upgrade(weapon, _id_EB2E85B24C206EA5) {
  if(!isDefined(level.pap))
    return 0;

  if(isDefined(level.max_pap_func))
    return [[level.max_pap_func]](weapon, _id_EB2E85B24C206EA5);

  if(isDefined(weapon))
    baseweapon = scripts\cp\utility::getrawbaseweaponname(weapon);
  else
    return 0;

  if(!isDefined(baseweapon))
    return 0;

  if(!isDefined(level.pap[baseweapon])) {
    _id_DE88CD14114C1E24 = getsubstr(baseweapon, 0, baseweapon.size - 1);

    if(!isDefined(level.pap[_id_DE88CD14114C1E24]))
      return 0;
  }

  if(istrue(_id_EB2E85B24C206EA5) && isDefined(self.pap[baseweapon]) && self.pap[baseweapon].lvl <= min(level.pap_max + 1, 2))
    return 1;

  if(isDefined(self.pap[baseweapon]) && self.pap[baseweapon].lvl >= level.pap_max)
    return 0;
  else
    return 1;
}

get_pap_camo(_id_CEB40E0D9504F27A, baseweapon, currentweapon) {
  camo = undefined;

  if(isDefined(baseweapon)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, baseweapon))
      camo = undefined;
    else if(isDefined(level.pap_1_camo) && isDefined(_id_CEB40E0D9504F27A) && _id_CEB40E0D9504F27A == 2)
      camo = level.pap_1_camo;
    else if(isDefined(level.pap_2_camo) && isDefined(_id_CEB40E0D9504F27A) && _id_CEB40E0D9504F27A == 3)
      camo = level.pap_2_camo;

    switch (baseweapon) {
      case "dischord":
        currentweapon = "iw7_dischord_zm_pap1";
        camo = "camo20";
        break;
      case "facemelter":
        currentweapon = "iw7_facemelter_zm_pap1";
        camo = "camo22";
        break;
      case "headcutter":
        currentweapon = "iw7_headcutter_zm_pap1";
        camo = "camo21";
        break;
      case "forgefreeze":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_forgefreeze_zm_pap1";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_forgefreeze_zm_pap2";

        _id_7EE4989412443482 = 1;
        break;
      case "axe":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_axe_zm_pap1";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_axe_zm_pap2";

        _id_7EE4989412443482 = 1;
        break;
      case "shredder":
        currentweapon = "iw7_shredder_zm_pap1";
        camo = "camo23";
        break;
    }
  }

  return camo;
}

validate_current_weapon(_id_CEB40E0D9504F27A, baseweapon, currentweapon) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(currentweapon)]))
    currentweapon = level.weapon_upgrade_path[getweaponbasename(currentweapon)];
  else if(isDefined(baseweapon)) {
    switch (baseweapon) {
      case "two":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_two_headed_axe_mp";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_two_headed_axe_mp";

        break;
      case "golf":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_golf_club_mp";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_golf_club_mp";

        break;
      case "machete":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_machete_mp";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_machete_mp";

        break;
      case "spiked":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_spiked_bat_mp";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_spiked_bat_mp";

        break;
      case "axe":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_axe_zm_pap1";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_axe_zm_pap2";

        break;
      case "katana":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_katana_zm_pap1";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_katana_zm_pap2";

        break;
      case "nunchucks":
        if(_id_CEB40E0D9504F27A == 2)
          currentweapon = "iw7_nunchucks_zm_pap1";
        else if(_id_CEB40E0D9504F27A == 3)
          currentweapon = "iw7_nunchucks_zm_pap2";

        break;
      default:
        return currentweapon;
    }
  }

  return currentweapon;
}

getitemweaponname() {
  classname = self.classname;
  _id_C27E2A04BAB78C1F = getsubstr(classname, 7);
  return _id_C27E2A04BAB78C1F;
}

watchweaponpickup(clip, stockammo) {
  level endon("game_ended");
  _id_C27E2A04BAB78C1F = getitemweaponname();

  for(;;) {
    self waittill("trigger", player, _id_76F4143215683892);

    if(isDefined(player) && istestclient(player)) {
      continue;
    }
    _id_893FF9B814E04F95 = player getcurrentweapon();
    player thread watchpickupcomplete(_id_C27E2A04BAB78C1F, _id_893FF9B814E04F95, clip, stockammo);
    player notify("weapon_pickup", _id_C27E2A04BAB78C1F);
    dirty = fixupplayerweapons(player, _id_C27E2A04BAB78C1F);

    if(isDefined(_id_76F4143215683892) || dirty) {
      break;
    }
  }

  if(isDefined(_id_76F4143215683892)) {
    player notify("manual_switch_from_minigun");
    _id_66DA0A5F69E8DD56 = _id_76F4143215683892 getitemweaponname();
    objweapon = makeweaponfromstring(_id_66DA0A5F69E8DD56);

    if(isDefined(player.tookweaponfrom[_id_66DA0A5F69E8DD56])) {
      _id_76F4143215683892.owner = player.tookweaponfrom[_id_66DA0A5F69E8DD56];
      player.tookweaponfrom[_id_66DA0A5F69E8DD56] = undefined;
    }

    _id_76F4143215683892.objweapon = objweapon.basename;
    _id_76F4143215683892.targetname = "dropped_weapon";

    if(istrue(level.clearstockondrop))
      stockammo = 0;
    else
      stockammo = weaponstartammo(_id_76F4143215683892);

    _id_5C3F9357F11D2223 = getweaponbasename(objweapon);

    if(isDefined(player._id_7AA597D25DB76E44[_id_5C3F9357F11D2223])) {
      clip = player._id_7AA597D25DB76E44[_id_5C3F9357F11D2223];
      player._id_7AA597D25DB76E44[_id_5C3F9357F11D2223] = undefined;
    } else
      clip = weaponclipsize(_id_76F4143215683892);

    _id_76F4143215683892 itemweaponsetammo(clip, stockammo);
    _id_76F4143215683892 thread watchweaponpickup(clip, stockammo);
  }

  player.tookweaponfrom[_id_C27E2A04BAB78C1F] = self.owner;
}

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

watchpickupcomplete(_id_F42F309550E65575, _id_17372FFC28DC7D78, clip, stockammo) {
  self endon("death");
  self endon("disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  startingweapon = self.currentweapon;
  success = 0;

  if(isstring(_id_F42F309550E65575))
    _id_F42F309550E65575 = makeweaponfromstring(_id_F42F309550E65575);

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
    ammotype = _id_66122A002AFF5D57::br_ammo_type_for_weapon(_id_F42F309550E65575);

    if(isDefined(ammotype)) {
      if(isDefined(stockammo))
        stock = stockammo + _id_66122A002AFF5D57::get_int_or_0(self.br_ammo[ammotype]);
      else
        stock = _id_66122A002AFF5D57::get_int_or_0(self.br_ammo[ammotype]);

      self.br_ammo[ammotype] = stock;
      self setweaponammostock(_id_F42F309550E65575, stock);
    }

    if(_id_F42F309550E65575.basename == "iw9_lm_dblmg2_cp")
      scripts\cp\killstreaks\juggernaut_cp::juggernautweaponpickedup(_id_F42F309550E65575, _id_17372FFC28DC7D78);

    checkpoint = scripts\cp\cp_checkpoint::_id_9EED75023A958C18();

    if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint)
      thread _id_12E2FB553EC1605E::_id_7DA7BD24B280D295();

    _id_5C3F9357F11D2223 = getweaponbasename(_id_F42F309550E65575);
    self._id_7AA597D25DB76E44[_id_5C3F9357F11D2223] = self getweaponammoclip(_id_F42F309550E65575);
    thread notifyuiofpickedupweapon();
    self notify("finish_pickup_of_weapon", _id_F42F309550E65575, _id_17372FFC28DC7D78);
  }
}

notifyuiofpickedupweapon() {
  self setclientomnvar("ui_weapon_pickup", 0);
}

_id_57F5A8F25CD5DA9E() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("player_watchWeaponClip");
  self endon("player_watchWeaponClip");
  self._id_7AA597D25DB76E44 = [];

  for(;;) {
    self waittill("weapon_fired", objweapon);
    currentweapon = self getcurrentweapon();

    if(!isDefined(currentweapon) || isnullweapon(currentweapon)) {
      continue;
    }
    if(!scripts\cp\utility::isinventoryprimaryweapon(currentweapon)) {
      continue;
    }
    _id_5C3F9357F11D2223 = getweaponbasename(currentweapon);
    self._id_7AA597D25DB76E44[_id_5C3F9357F11D2223] = self getweaponammoclip(currentweapon);
  }
}

watchweaponusage(_id_E9A9DC280D811788) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("watchWeaponUsage");
  self endon("watchWeaponUsage");

  for(;;) {
    self waittill("weapon_fired", objweapon);
    currentweapon = self getcurrentweapon();

    if(!isDefined(currentweapon) || isnullweapon(currentweapon)) {
      continue;
    }
    if(!scripts\cp\utility::isinventoryprimaryweapon(currentweapon)) {
      continue;
    }
    if(isDefined(level.updateonusepassivesfunc))
      thread[[level.updateonusepassivesfunc]](self, getcompleteweaponname(currentweapon));

    _id_6B7BEE46F2C6DA28 = gettime();

    if(!isDefined(self.lastshotfiredtime))
      self.lastshotfiredtime = 0;

    _id_D6DF3D735D181A6E = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = _id_6B7BEE46F2C6DA28;

    if(isai(self)) {
      continue;
    }
    _id_5C3F9357F11D2223 = getweaponbasename(currentweapon);

    if(!isDefined(self.shotsfiredwithweapon[_id_5C3F9357F11D2223]))
      self.shotsfiredwithweapon[_id_5C3F9357F11D2223] = 1;
    else
      self.shotsfiredwithweapon[_id_5C3F9357F11D2223]++;

    self._id_7AA597D25DB76E44[_id_5C3F9357F11D2223] = self getweaponammoclip(currentweapon);

    if(!isDefined(self.accuracy_shots_fired))
      self.accuracy_shots_fired = 1;
    else
      self.accuracy_shots_fired++;

    _id_3BCAA2CBAF54ABDD::increment_player_career_shots_fired(self);

    if(isDefined(_id_5C3F9357F11D2223)) {
      if(isDefined(self.hitsthismag[_id_5C3F9357F11D2223]))
        thread hitsthismag_update(_id_5C3F9357F11D2223, currentweapon);
    }
  }
}

hitsthismag_update(_id_92FCE7B1696254E3, objweapon) {
  self endon("death");
  self endon("disconnect");
  _id_92FCE7B1696254E3 = objweapon.basename;
  self endon("updateMagShots_" + _id_92FCE7B1696254E3);
  self.hitsthismag[_id_92FCE7B1696254E3]--;
  wait 0.1;
  self notify("shot_missed", objweapon);
  self.consecutivehitsperweapon[_id_92FCE7B1696254E3] = 0;
  self.hitsthismag[_id_92FCE7B1696254E3] = weaponclipsize(objweapon);
}

watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponChange");
  self endon("watchWeaponChange");
  self.hitsthismag = [];
  weaponname = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(weaponname);

  for(;;) {
    self waittill("weapon_change", objweapon);
    weaponname = objweapon.basename;
    weapontracking_init(weaponname);

    if(isDefined(self.weapon_passives[objweapon.basename])) {} else {}

    hitsthismag_init(weaponname);
  }
}

harpoon_impale_additional_func(weapon, eattacker, victim, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {
  if(!issubstr(weapon, "harpoon"))
    return;
  else {
    victim startragdoll();
    contents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle"]);
    endpoint = vpoint + vdir * 4096;
    trace = scripts\engine\trace::ray_trace_detail(vpoint, endpoint, undefined, contents, undefined, 1);
    endpoint = trace["position"] - vdir * 12;
    _id_80C97B146B16BE3F = length(endpoint - vpoint);
    flighttime = _id_80C97B146B16BE3F / 1250;
    flighttime = clamp(flighttime, 0.05, 1);
    wait 0.05;
    _id_A0480A10EE4E345F = vdir;
    _id_C323F0CB880A051F = anglestoup(eattacker.angles);
    _id_C1148FF802BE2880 = vectorcross(_id_A0480A10EE4E345F, _id_C323F0CB880A051F);
    _id_483E4E4E5B094BE2 = scripts\engine\utility::spawn_tag_origin(vpoint, axistoangles(_id_A0480A10EE4E345F, _id_C1148FF802BE2880, _id_C323F0CB880A051F));
    _id_483E4E4E5B094BE2 moveTo(endpoint, flighttime);
    _id_D04F3DA69954A74E = spawnragdollconstraint(victim, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34);
    _id_D04F3DA69954A74E.origin = _id_483E4E4E5B094BE2.origin;
    _id_D04F3DA69954A74E.angles = _id_483E4E4E5B094BE2.angles;
    _id_D04F3DA69954A74E linkTo(_id_483E4E4E5B094BE2);
    thread play_explosion_post_impale(endpoint, eattacker);
    thread impale_cleanup(victim, _id_483E4E4E5B094BE2, flighttime + 0.05, _id_D04F3DA69954A74E);
  }
}

impale_cleanup(_id_E851FFA44B7E0D54, _id_483E4E4E5B094BE2, time, _id_D04F3DA69954A74E) {
  _id_E851FFA44B7E0D54 scripts\engine\utility::waittill_any_timeout_2(time, "death", "disconnect");
  _id_D04F3DA69954A74E delete();
  _id_483E4E4E5B094BE2 delete();
}

play_explosion_post_impale(_id_7CA9D4EE7D70F3E2, player) {
  wait 2;
  player radiusdamage(_id_7CA9D4EE7D70F3E2, 500, 1000, 500, player, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], _id_7CA9D4EE7D70F3E2);
}

weapontracking_init(weaponname) {
  if(!isDefined(weaponname) || weaponname == "none") {
    return;
  }
  if(!isDefined(self.shotsfiredwithweapon[weaponname]))
    self.shotsfiredwithweapon[weaponname] = 0;

  if(!isDefined(self.shotsontargetwithweapon[weaponname]))
    self.shotsontargetwithweapon[weaponname] = 0;

  if(!isDefined(self.headshots[weaponname]))
    self.headshots[weaponname] = 0;

  if(!isDefined(self.wavesheldwithweapon[weaponname]))
    self.wavesheldwithweapon[weaponname] = 1;

  if(!isDefined(self.downsperweaponlog[weaponname]))
    self.downsperweaponlog[weaponname] = 0;

  if(!isDefined(self.killsperweaponlog[weaponname]))
    self.killsperweaponlog[weaponname] = 0;
}

hitsthismag_init(weaponname) {
  if(!isDefined(weaponname) || weaponname == "none") {
    return;
  }
  if(scripts\cp\utility::isinventoryprimaryweapon(weaponname) && !isDefined(self.hitsthismag[weaponname]))
    self.hitsthismag[weaponname] = weaponclipsize(weaponname);
}

addattachmenttoweapon(_id_DD515FCF025B2E79, _id_EFFB4AE1788A8B10, maxammo) {
  currentweapon = self.currentweapon;
  weaponobj = currentweapon;
  _id_DD515FCF025B2E79 = undefined;
  _id_1C1A1A6F472D6E7A = 0;

  if(currentweapon.attachments.size == 0) {
    if(weaponobj canuseattachment(_id_EFFB4AE1788A8B10))
      _id_1C1A1A6F472D6E7A = 1;
    else
      _id_1C1A1A6F472D6E7A = 0;
  } else {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < currentweapon.attachments.size; _id_AC0E5C4AC96AAA41++) {
      if(weaponobj canuseattachment(_id_EFFB4AE1788A8B10) && _id_2669878CF5A1B6BC::attachmentsconflict(currentweapon.attachments[_id_AC0E5C4AC96AAA41], _id_EFFB4AE1788A8B10, weaponobj) == "") {
        _id_1C1A1A6F472D6E7A = 1;
        continue;
      }

      _id_1C1A1A6F472D6E7A = 0;
      break;
    }
  }

  if(_id_1C1A1A6F472D6E7A)
    _id_DD515FCF025B2E79 = weaponobj withattachment(_id_EFFB4AE1788A8B10);

  if(!isDefined(_id_DD515FCF025B2E79)) {
    if(!isbot(self)) {}

    return undefined;
  }

  clip_ammo = self getweaponammoclip(_id_DD515FCF025B2E79);
  stock_ammo = self getweaponammostock(_id_DD515FCF025B2E79);

  if(istrue(maxammo)) {
    clip_ammo = weaponclipsize(_id_DD515FCF025B2E79);
    stock_ammo = scripts\cp\utility::_id_ED18A118C6FA5C4F(_id_DD515FCF025B2E79);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
  self giveweapon(_id_DD515FCF025B2E79);
  self setweaponammoclip(_id_DD515FCF025B2E79, clip_ammo);
  self setweaponammostock(_id_DD515FCF025B2E79, stock_ammo);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DD515FCF025B2E79);
  fixupplayerweapons(self, _id_DD515FCF025B2E79);
  return _id_DD515FCF025B2E79;
}

_buildweaponcustom(weapon, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0) {
  weaponname = weapon;
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  index = 0;

  if(_id_67F14F8315CB0F2F[0] == "alt")
    index++;

  if(_id_67F14F8315CB0F2F[index] == "iw7")
    return;
  else if(_id_67F14F8315CB0F2F[index] == "iw8") {
    _id_AB501F397D3CD312 = weapon;

    if(!isDefined(attachments))
      attachments = [];

    if(!isDefined(camo))
      camo = "none";

    if(!isDefined(reticle))
      reticle = "none";

    if(!isDefined(variantid))
      variantid = -1;

    if(!isDefined(_id_F3464D71F01F614E))
      _id_F3464D71F01F614E = [];

    if(!isDefined(cosmeticattachment))
      cosmeticattachment = "none";

    if(!isDefined(stickers))
      stickers = [];

    if(!isDefined(_id_11A1FA68AEB971C0))
      _id_11A1FA68AEB971C0 = 0;

    if(!isPlayer(self))
      return _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
    else
      return _id_2669878CF5A1B6BC::buildweapon(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_F3464D71F01F614E, cosmeticattachment, stickers, _id_11A1FA68AEB971C0);
  }
}

checkforinvalidattachments(attachments, _id_C7BD95B10C89CFF8) {
  weaponobj = makeweapon(_id_C7BD95B10C89CFF8);
  _id_503110DC18B08AB9 = [];

  foreach(attachment in attachments) {
    if(weaponobj canuseattachment(attachment)) {
      _id_503110DC18B08AB9[_id_503110DC18B08AB9.size] = attachment;
      continue;
    }
  }

  return _id_503110DC18B08AB9;
}

_id_29BA39C7E2ADB57B(_id_AB501F397D3CD312, attachments, variantid) {
  if(isDefined(variantid) && variantid < 0)
    variantid = undefined;

  attachments = scripts\cp\utility::weaponattachremoveextraattachments(attachments, _id_AB501F397D3CD312);
  attachments = scripts\engine\utility::array_remove(attachments, "none");
  attachdefaults = scripts\cp\utility::weaponattachdefaultmap(_id_AB501F397D3CD312);
  _id_AC82E189F4D06152 = scripts\engine\utility::array_combine_unique(attachments, attachdefaults);
  _id_C7BD95B10C89CFF8 = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312, variantid);

  if(_id_AC82E189F4D06152.size > 0)
    _id_AC82E189F4D06152 = scripts\cp\utility::filterattachments(_id_AC82E189F4D06152);

  _id_8B1AA9931D355839 = [];

  foreach(a in _id_AC82E189F4D06152) {
    extra = _id_2669878CF5A1B6BC::attachmentmap_toextra(a);

    if(isDefined(extra)) {
      foreach(_id_DB701CDBDBE476AC in extra)
      _id_8B1AA9931D355839[_id_8B1AA9931D355839.size] = _id_DB701CDBDBE476AC;
    }
  }

  if(_id_8B1AA9931D355839.size > 0)
    _id_AC82E189F4D06152 = scripts\engine\utility::array_combine_unique(_id_AC82E189F4D06152, _id_8B1AA9931D355839);

  if(isDefined(variantid)) {
    _id_3482901E4B0E85E4 = scripts\cp\utility::getweaponvariantattachments(_id_C7BD95B10C89CFF8, variantid);

    foreach(_id_9AA34A1FE21F66FF in _id_3482901E4B0E85E4)
    _id_AC82E189F4D06152[_id_AC82E189F4D06152.size] = _id_9AA34A1FE21F66FF;
  }

  _id_580837BA9DE8F3D4 = undefined;
  return _id_AC82E189F4D06152;
}

applyflashfromdamage(victim, attacker, origin, _id_73C2061B38DC4D56) {
  victim endon("death");

  if(isDefined(victim.usingremote))
    return 0;

  if(isDefined(victim.vehicle))
    return 0;

  if(!victim scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(scripts\cp\utility::is_friendly_damage(victim, attacker) && victim != attacker)
    return 0;

  dist = distance(origin, victim.origin);
  _id_CB2D2CDF15DA89FF = 0;

  if(attacker == victim) {
    if(dist > 384)
      return 0;
    else
      _id_CB2D2CDF15DA89FF = 1;
  }

  _id_782C6796F4C5A826 = 0;
  _id_3BABA845EDBBE939 = 0;
  _id_04447761AE0FFF3F = isagent(attacker) || isPlayer(attacker);

  if(dist >= 512 || _id_04447761AE0FFF3F && !scripts\engine\utility::within_fov(attacker.origin, attacker getplayerangles(), origin, 0.5)) {
    _id_782C6796F4C5A826 = 3;
    _id_3BABA845EDBBE939 = 0.25;
  } else if(dist <= 256) {
    _id_782C6796F4C5A826 = 5;
    _id_3BABA845EDBBE939 = 0.75;
  } else {
    _id_6C8D21B2E54B2478 = 1 - (dist - 256) / 256;
    _id_782C6796F4C5A826 = 3 + _id_6C8D21B2E54B2478 * 2;
    _id_3BABA845EDBBE939 = 0.25 + _id_6C8D21B2E54B2478 * 0.5;
  }

  if(_id_73C2061B38DC4D56) {
    victim = attacker;
    _id_782C6796F4C5A826 = max(3, _id_782C6796F4C5A826 * 0.75);
    _id_3BABA845EDBBE939 = max(0.25, _id_3BABA845EDBBE939 * 0.75);
  } else if(_id_CB2D2CDF15DA89FF) {
    _id_782C6796F4C5A826 = max(3, _id_782C6796F4C5A826 * 0.75);
    _id_3BABA845EDBBE939 = max(0.25, _id_3BABA845EDBBE939 * 0.75);
  }

  if(isPlayer(victim)) {
    victim shellshock("flashbang_mp", _id_782C6796F4C5A826);
    victim.flashendtime = gettime() + int(_id_782C6796F4C5A826 * 1000);
    victim thread flashrumbleloop(_id_3BABA845EDBBE939);
  } else if(victim scripts\cp\utility::is_zombie_agent() || victim.agent_type == "soldier_agent" || victim.unittype == "soldier")
    stunenemiesinrange(origin, attacker);
  else {
    victim shellshock("flashbang_mp", _id_782C6796F4C5A826);
    victim.flashendtime = gettime() + int(_id_782C6796F4C5A826 * 1000);
    victim thread flashrumbleloop(_id_3BABA845EDBBE939);
  }

  return 1;
}

isflashgrenadedamage(objweapon, smeansofdeath) {
  _id_A62C0688FCAA530D = objweapon.basename == "flash_grenade_mp" || objweapon.basename == "flash_grenade_cp";
  return _id_A62C0688FCAA530D && smeansofdeath != "MOD_IMPACT";
}

flashrumbleloop(duration) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  goaltime = gettime() + duration * 1000;

  while(gettime() < goaltime) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

giveequipmentasaweapon(_id_F4692D0892428480) {
  switch (_id_F4692D0892428480) {
    case "molotov":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("iw8_molotov_zm");
      self switchtoweapon("iw8_molotov_zm");
      break;
    case "breach_charge":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("c4_mp");
      self switchtoweapon("c4_mp");
      break;
  }
}

watch_for_dropped_weapons() {
  for(;;) {
    level waittill("ai_weapon_dropped");
    dropped_weapons = getweaponarray();

    foreach(_id_DE88CD14114C1E24 in dropped_weapons)
    _id_DE88CD14114C1E24 setusepriority(1, 1);
  }
}

drop_script_weapon_from_ai(_id_0D2346943E5CB1F5, position) {
  if(istrue(level._id_624BA233506A543E) && !istrue(self._id_CED8415AAAD3FF6D)) {
    return;
  }
  name = _id_0D2346943E5CB1F5.basename;

  if(isDefined(self._id_857FF4A1E09042D4))
    name = self._id_857FF4A1E09042D4.basename;

  if(scripts\engine\utility::array_contains(level.invalid_drop_weapons, name)) {
    return;
  }
  attachments = _id_0D2346943E5CB1F5.attachments;

  if(scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4()) {
    if(_id_0D2346943E5CB1F5 canuseattachment("laserir_box"))
      _id_0D2346943E5CB1F5 = _id_0D2346943E5CB1F5 withattachment("laserir_box");

    if(_id_0D2346943E5CB1F5 canuseattachment("laserir_pstl"))
      _id_0D2346943E5CB1F5 = _id_0D2346943E5CB1F5 withattachment("laserir_pstl");
  }

  dvar = getDvar("dvar_F12CA0FA2674622F", "");

  if(dvar != "") {
    if(name == "iw8_sn_xmike109_mp") {} else
      attachments = scripts\engine\utility::array_add(attachments, dvar);
  }

  if(player_has_nvg())
    _id_6E9BBC4D48F38065 = 1;
  else
    _id_6E9BBC4D48F38065 = undefined;

  weapon = _id_66122A002AFF5D57::createspawnweaponatpos(self.origin + (0, 0, 32), self.angles, _id_0D2346943E5CB1F5);
  weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);

  if(!isDefined(weapon))
    return;
}

player_has_nvg() {
  if(istrue(level.nightmap))
    return 1;

  if(level.script == "cp_so_estate" || level.script == "cp_mission_bads")
    return 1;

  return 0;
}

delete_weapon_after_time() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");

  if(getdvarint("dvar_C564069EC13375CB", 0) != 0) {
    return;
  }
  if(isDefined(level._id_004B47EEDAC44A48))
    wait(level._id_004B47EEDAC44A48);
  else
    wait 30;

  remove_from_weapon_array(self);
  self delete();
}

update_dropped_weapon_priorities() {
  self setusepriority(1, 1);
  self setuserange(72);
}

initializeweaponpickups() {
  if(isDefined(level.custom_allowedweaponnames))
    _id_0E6AA5314B387AE5 = level.custom_allowedweaponnames;
  else
    _id_0E6AA5314B387AE5 = ["iw8_ar_falpha", "iw8_sm_papa90", "iw8_sm_augolf", "iw8_lm_pkilo", "iw8_sn_alpha50", "iw8_pi_mike1911", "iw8_ar_mike4", "iw8_ar_akilo47", "iw8_sm_mpapa5", "iw8_sh_dpapa12", "iw8_lm_kilo121", "iw8_sn_mike14", "iw8_sn_kilo98", "iw8_pi_golf21", "iw8_sn_crossbow"];

  _id_BF8FE275EBA37CC1 = scripts\engine\utility::getStructArray("weapon_pickup", "script_noteworthy");

  foreach(_id_CDD12F78F51B56F6 in _id_BF8FE275EBA37CC1) {
    if(isDefined(_id_CDD12F78F51B56F6.script_parameters)) {
      name = getcompletenameforweapon(_id_CDD12F78F51B56F6.script_parameters + "_mp");
      weapon = spawn("weapon_" + name, _id_CDD12F78F51B56F6.origin);
      weapon itemweaponsetammo(weaponclipsize(name), scripts\cp\utility::_id_ED18A118C6FA5C4F(name));
      weapon thread watchweaponpickup();
      _id_BF8FE275EBA37CC1 = scripts\engine\utility::array_remove(_id_BF8FE275EBA37CC1, _id_CDD12F78F51B56F6);
    }
  }

  weapons = [];
  _id_7CE98C8199BE3D76 = [];

  foreach(root, data in level.weaponmapdata) {
    foreach(name in _id_0E6AA5314B387AE5) {
      if(root == name) {
        _id_52222E4FA76F795E = strtok(root, "_");

        if(_id_52222E4FA76F795E[0] == "iw8") {
          weapons[weapons.size] = root;
          level.attachmentmap[root] = pullattachmentsforweapon(root);
        }
      }
    }
  }

  weapons = eliminatenullweapons(weapons);
  _id_FE4048AD22C35D73 = 0;
  counter = 0;

  for(_id_CA5370D04FCE3797 = _id_BF8FE275EBA37CC1.size; counter < _id_CA5370D04FCE3797; counter++) {
    _id_FE4048AD22C35D73 = randomintrange(0, weapons.size);
    attachments = attachmentroll(weapons[_id_FE4048AD22C35D73]);

    foreach(attachment in attachments) {
      foreach(_id_8B4E3303A2005148 in attachments) {
        if(attachment == _id_8B4E3303A2005148) {
          continue;
        }
        if(_id_2669878CF5A1B6BC::attachmentsconflict(attachment, _id_8B4E3303A2005148, weapons[_id_FE4048AD22C35D73]))
          attachments = scripts\engine\utility::array_remove(attachments, _id_8B4E3303A2005148);
      }
    }

    name = getcompletenameforweapon(weapons[_id_FE4048AD22C35D73]);
    weapon = spawn("weapon_" + name, _id_BF8FE275EBA37CC1[counter].origin);

    if(isDefined(_id_BF8FE275EBA37CC1[counter].angles))
      weapon.angles = _id_BF8FE275EBA37CC1[counter].angles;
    else
      weapon.angles = (0, 0, 0);

    weapon itemweaponsetammo(weaponclipsize(name), scripts\cp\utility::_id_ED18A118C6FA5C4F(name));
    weapon thread watchweaponpickup();
  }
}

attachmentroll(_id_AB501F397D3CD312) {
  attachments = [];

  if(isDefined(level.attachmentmap[_id_AB501F397D3CD312])) {
    _id_D7AF4FFCC6535706 = scripts\engine\utility::array_randomize(level.attachmentmap[_id_AB501F397D3CD312]);
    _id_A8E6266C4ED31034 = attachmentrollcount();

    for(_id_FE8F7703F6313ED4 = 0; _id_FE8F7703F6313ED4 < _id_A8E6266C4ED31034 && _id_FE8F7703F6313ED4 < _id_D7AF4FFCC6535706.size; _id_FE8F7703F6313ED4++)
      attachments[attachments.size] = _id_D7AF4FFCC6535706[_id_FE8F7703F6313ED4];
  }

  return attachments;
}

attachmentrollcount() {
  roll = randomint(100);

  if(roll < 50)
    return 0;
  else if(roll < 80)
    return 1;
  else if(roll < 95)
    return 2;
  else if(roll < 100)
    return 3;

  return 0;
}

pullattachmentsforweapon(weaponname) {
  _id_564682A19504A711 = _id_2669878CF5A1B6BC::_id_C471A035D22DF5EB();
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponname);
  _id_C7BD95B10C89CFF8 = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312);

  foreach(_id_0CF52C7D54D715D8 in _id_564682A19504A711) {
    _id_800DFE719BF87A3F = _func_75B035199842693D(_id_C7BD95B10C89CFF8, _id_0CF52C7D54D715D8);
    return returnarraywithoutdefaults(_id_800DFE719BF87A3F, weaponname);
  }
}

returnarraywithoutdefaults(_id_18F0A5759A8E40D9, weaponname) {
  foreach(_id_AB501F397D3CD312, struct in level.weaponmapdata) {
    if(weaponname == _id_AB501F397D3CD312) {
      if(scripts\engine\utility::array_contains(_id_18F0A5759A8E40D9, "doubletap"))
        _id_18F0A5759A8E40D9 = scripts\engine\utility::array_remove(_id_18F0A5759A8E40D9, "doubletap");

      if(scripts\engine\utility::array_contains(_id_18F0A5759A8E40D9, "reconsilencer_cp"))
        _id_18F0A5759A8E40D9 = scripts\engine\utility::array_remove(_id_18F0A5759A8E40D9, "reconsilencer_cp");

      if(isDefined(struct.attachdefaults))
        return scripts\engine\utility::array_remove_array(_id_18F0A5759A8E40D9, struct.attachdefaults);
    }
  }
}

eliminatenullweapons(_id_D6E9347C3618A5BB) {
  array = ["iw8_knife", "iw9_me_fists", "iw9_knifestab", "none", "speciality_null", "iw8_ar_dummycp", "iw8_ar_dummycs", "iw8_me_riotshield"];
  _id_BFC65A378A6D8EFE = [];

  if(isstruct(scripts\engine\utility::random(_id_D6E9347C3618A5BB))) {
    foreach(basename, struct in _id_D6E9347C3618A5BB) {
      if(!scripts\engine\utility::array_contains(array, basename))
        _id_BFC65A378A6D8EFE[basename] = struct;
    }

    return _id_BFC65A378A6D8EFE;
  }

  return scripts\engine\utility::array_remove_array(_id_D6E9347C3618A5BB, array);
}

choosepassive() {
  for(;;) {
    _id_A6AF9F073D6E07C2 = scripts\engine\utility::random(level.lootpassivesstructs);

    foreach(_id_F8B2E6BF3F40AB02, struct in level.cp_weapon_passives) {
      if(_id_A6AF9F073D6E07C2.name == _id_F8B2E6BF3F40AB02)
        return _id_A6AF9F073D6E07C2;
      else
        continue;
    }

    waitframe();
  }
}

grenadeinpullback() {
  return !isnullweapon(self getheldoffhand());
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
    grenade.ticks = scripts\cp\utility::roundup(4 * tickpercent);

  equipmentref = _id_1DB8D0E02A99C5E2::getequipmentreffromweapon(weapon_object);

  if(isDefined(equipmentref)) {
    grenade.equipmentref = equipmentref;
    grenade.isequipment = 1;
  }

  grenade.threwback = isDefined(originalowner);
}

_id_F69ED22535D90B78() {
  self endon("death");
  level endon("game_ended");
  _id_A681B7890CD017C7 = spawnStruct();
  childthread _id_BDDE0931ACCF955B(_id_A681B7890CD017C7);
  childthread _id_449E67A68FA04968(_id_A681B7890CD017C7);
  self waittill("missile_impact");
  return _id_A681B7890CD017C7;
}

_id_BDDE0931ACCF955B(_id_A681B7890CD017C7) {
  self endon("missile_impact");
  self waittill("missile_stuck", stuckto);

  if(isDefined(stuckto))
    _id_A681B7890CD017C7.stuckto = stuckto;

  self notify("missile_impact");
}

_id_449E67A68FA04968(_id_A681B7890CD017C7) {
  self endon("missile_impact");
  self waittill("missile_water_impact");
  _id_A681B7890CD017C7._id_6150B9D03028F80C = 1;
  self notify("missile_impact");
}

_id_4AF015619E2534BA(stuckto, _id_4C663252DABD1483, _id_6A94CF09AA6E486E) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  stuckto scripts\engine\utility::waittill_any_2("death", "destroy");
  self thread[[_id_4C663252DABD1483]](_id_6A94CF09AA6E486E);
}

updatelastweapon() {
  self endon("disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastdroppableweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());

  for(;;) {
    self waittill("weapon_change", _id_82533969B4683DE4);
    self.lastweaponobj = _id_82533969B4683DE4;

    if(isnormallastweapon(_id_82533969B4683DE4))
      self.lastnormalweaponobj = _id_82533969B4683DE4;

    if(isdroppableweapon(_id_82533969B4683DE4))
      self.lastdroppableweaponobj = _id_82533969B4683DE4;

    if(iscacprimaryorsecondary(_id_82533969B4683DE4))
      self.lastcacweaponobj = _id_82533969B4683DE4;
  }
}

isnormallastweapon(objweapon) {
  if(objweapon.basename == "none")
    return 0;

  if(objweapon.classname == "turret")
    return 0;

  if(scripts\cp\utility::issuperweapon(objweapon.basename))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
    return 0;

  if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode")
    return 0;

  return 1;
}

getweapontype(weapon) {
  if(!isDefined(weapon)) {
    return;
  }
  if(iscacprimaryweapon(weapon))
    return "primary";

  if(iscacsecondaryweapon(weapon))
    return "secondary";

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
    return "killstreak";

  if(scripts\cp\utility::issuperweapon(weapon))
    return "super";

  if(weapon == "iw8_turret_50cal_mp")
    return "turret";

  if(weapon == "rock_mp")
    return "rock";

  if(scripts\engine\utility::string_starts_with(weapon, "destructible_"))
    return "destructible";

  if(isvehicleweapon(weapon))
    return "vehicle";

  if(isspecialmeleeweapon(weapon) || weapon == "iw8_defibrillator_mp")
    return "special_melee";

  if(scripts\cp\utility::isenvironmentweapon(weapon))
    return "environment";

  _id_11D2F075E9A0E643 = scripts\cp\utility::getequipmenttype(weapon);

  if(isDefined(_id_11D2F075E9A0E643))
    return _id_11D2F075E9A0E643;

  if(weapon == "none")
    return "worldspawn";

  if(weapon == "bomb_site_mp")
    return weapon;

  if(weapon == "iw9_racecar_mp")
    return weapon;

  if(weapon == "iw8_gunless")
    return "gunless";

  if(isstring(weapon) && (weapon == "iw8_armor_marker_cp" || weapon == "ks_assault_drone_mp" || weapon == "ks_assault_drone_cp" || weapon == "sonar_pulse_mp" || weapon == "ks_remote_drone_mp" || weapon == "deploy_sentry_mp"))
    return "super";
}

iscacprimaryweapon(weapon) {
  switch (getweapongroup(weapon)) {
    case "weapon_melee":
    case "weapon_battle":
    case "weapon_smg":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
    case "weapon_dmr":
    case "weapon_assault":
      return 1;
    default:
      return 0;
  }
}

isspecialmeleeweapon(weapon) {
  if(ismeleeoverrideweapon(weapon))
    return 1;

  _id_C27E2A04BAB78C1F = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon))
      return 0;

    _id_C27E2A04BAB78C1F = weapon.basename;
  } else {
    if(weapon == "none")
      return 0;

    _id_C27E2A04BAB78C1F = weapon;
  }

  return _id_C27E2A04BAB78C1F == "iw9_me_fists_mp_ls";
}

ismeleeoverrideweapon(weapon) {
  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  return weaponname == "iw9_knifestab_mp" || weaponname == "iw9_me_climbfists" || weaponname == "iw9_knifestab_mp" || weaponname == "iw8_throwingknife_fire_melee_mp" || weaponname == "iw8_throwingknife_electric_melee_mp";
}

getweapongroup(weapon) {
  if(!isDefined(weapon))
    return "other";

  if(isweapon(weapon) && isnullweapon(weapon))
    return "other";

  if(isstring(weapon) && (weapon == "none" || weapon == "alt_none"))
    return "other";

  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  group = _id_2669878CF5A1B6BC::weapongroupmap(_id_AB501F397D3CD312);

  if(!isDefined(group)) {
    if(scripts\cp\utility::issuperweapon(weapon))
      group = "super";
    else if(scripts\cp\utility::isenvironmentweapon(weapon))
      group = "weapon_mg";
    else if(_id_2669878CF5A1B6BC::iskillstreakweapon(weapon))
      group = "killstreak";
    else
      group = "other";
  }

  return group;
}

iscacsecondaryweapon(weapon) {
  switch (getweapongroup(weapon)) {
    case "weapon_rail":
    case "weapon_beam":
    case "weapon_machine_pistol":
    case "weapon_melee2":
    case "weapon_pistol":
    case "weapon_projectile":
      return 1;
    default:
      return 0;
  }
}

iscacprimaryorsecondary(weapon) {
  return iscacprimaryweapon(weapon) || iscacsecondaryweapon(weapon);
}

isdroppableweapon(objweapon) {
  if(objweapon.basename == "none")
    return 0;

  if(isfistweapon(objweapon.basename))
    return 0;

  if(isDefined(self) && istrue(self.inlaststand))
    return 0;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
    return 0;

  if(scripts\cp\utility::issuperweapon(objweapon.basename))
    return 0;

  if(objweapon.inventorytype != "primary")
    return 0;

  if(objweapon.classname == "turret")
    return 0;

  if(!iscacprimaryweapon(objweapon.basename) && !iscacsecondaryweapon(objweapon.basename))
    return 0;

  return 1;
}

gui_giveattachment() {
  _id_EFFB4AE1788A8B10 = getDvar("scr_giveattachment");

  if(isDefined(_id_EFFB4AE1788A8B10)) {
    foreach(player in level.players)
    gui_giveattachment_internal(player, _id_EFFB4AE1788A8B10);
  }
}

gui_giveattachment_internal(player, _id_EFFB4AE1788A8B10) {
  _id_DD515FCF025B2E79 = player.currentweapon;
  player dropitem(_id_DD515FCF025B2E79);
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 getnoaltweapon();
  _id_BE36140D4AD4C0B5 = getweaponattachments(_id_DD515FCF025B2E79);
  _id_A3A475E000C0FA3F = 0;

  if(scripts\engine\utility::array_contains(_id_BE36140D4AD4C0B5, _id_EFFB4AE1788A8B10))
    _id_A3A475E000C0FA3F = 1;
  else if(!_id_DD515FCF025B2E79 canuseattachment(_id_EFFB4AE1788A8B10)) {
    if(!isbot(player))
      player iprintlnbold("Invalid attachment for this weapon: " + _id_EFFB4AE1788A8B10);

    _id_A3A475E000C0FA3F = 1;
  }

  if(_id_A3A475E000C0FA3F) {
    player giveweapon(_id_DD515FCF025B2E79);
    return;
  }

  _id_503110DC18B08AB9 = _id_BE36140D4AD4C0B5;
  _id_503110DC18B08AB9[_id_503110DC18B08AB9.size] = _id_EFFB4AE1788A8B10;
  _id_98EFD9D21DA41D1A = _id_2669878CF5A1B6BC::getweaponrootname(_id_DD515FCF025B2E79.basename);
  _id_16D54486F31E87BB = _id_29BA39C7E2ADB57B(_id_98EFD9D21DA41D1A, _id_503110DC18B08AB9, -1);

  if(isDefined(_id_DD515FCF025B2E79.attachments)) {
    foreach(attachment in _id_DD515FCF025B2E79.attachments)
    _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 withoutattachment(attachment);
  }

  foreach(_id_B75325027BAAF52F in _id_16D54486F31E87BB)
  _id_DD515FCF025B2E79 = _id_DD515FCF025B2E79 withattachment(_id_B75325027BAAF52F);

  attachments = getweaponattachments(_id_DD515FCF025B2E79);

  if(attachments.size > 12) {
    player iprintlnbold("Player / Bot already has 12 attachments: " + getcompleteweaponname(_id_DD515FCF025B2E79));
    return;
  }

  player giveweapon(_id_DD515FCF025B2E79);
  player setweaponammoclip(_id_DD515FCF025B2E79, weaponclipsize(_id_DD515FCF025B2E79));
  player setweaponammostock(_id_DD515FCF025B2E79, scripts\cp\utility::_id_ED18A118C6FA5C4F(_id_DD515FCF025B2E79));
  player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(_id_DD515FCF025B2E79);
  fixupplayerweapons(player, _id_DD515FCF025B2E79);
}

watchgunsmithdebugui() {
  for(;;) {
    level waittill("connected", player);
    player thread watchplayergunsmithdebugui();
  }
}

watchplayergunsmithdebugui() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", message, lootid);

    if(message == "debug_attach_select") {
      ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
      gui_giveattachment_internal(self, ref);
    }
  }
}

create_weapon_pickups() {
  _id_E6191409B81F0BAC = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E6191409B81F0BAC.size; _id_AC0E594AC96AA3A8++) {
    _id_F077ADF688122C36 = strtok(_id_E6191409B81F0BAC[_id_AC0E594AC96AA3A8].script_noteworthy, "+");
    weapon = _id_F077ADF688122C36[0];
    attachments = [];

    if(_id_F077ADF688122C36.size > 1) {
      _id_0C0A8E96CE567D71 = strtok(_id_F077ADF688122C36[1], " ");

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_0C0A8E96CE567D71.size; _id_AC0E5C4AC96AAA41++)
        attachments[attachments.size] = _id_0C0A8E96CE567D71[_id_AC0E5C4AC96AAA41];
    }

    weapon = spawn_script_weapon(weapon, attachments, _id_E6191409B81F0BAC[_id_AC0E594AC96AA3A8].origin, _id_E6191409B81F0BAC[_id_AC0E594AC96AA3A8].angles);
  }
}

spawn_script_weapon(weapon_name, attachments, spawn_origin, _id_E21A7BAA6BA10015, _id_6E9BBC4D48F38065) {
  if(!isDefined(attachments))
    attachments = [];

  if(!isarray(attachments))
    attachments = [attachments];

  weapon_obj = undefined;

  if(getdvarint("dvar_4CA94EC2DBFB6D2F", 0) != 0)
    weapon_obj = buildweaponwithrandomattachments(weapon_name, attachments);
  else
    weapon_obj = _id_2669878CF5A1B6BC::buildweapon(weapon_name, attachments, "none", "none", -1, undefined, undefined, undefined, _id_6E9BBC4D48F38065);

  name = getcompleteweaponname(weapon_obj);
  weapon = spawn("weapon_" + name, spawn_origin);

  if(isDefined(weapon)) {
    if(scripts\cp\utility::is_wave_gametype())
      weapon itemweaponsetammo(weaponclipsize(weapon), 0);
    else
      weapon itemweaponsetammo(weaponclipsize(weapon), weaponclipsize(weapon));

    weapon.angles = _id_E21A7BAA6BA10015;
    add_to_weapon_array(weapon);
    weapon thread scripts\engine\utility::thread_on_notify_no_endon_death("death", ::remove_from_weapon_array);
  }

  return weapon;
}

add_to_weapon_array(weapon) {
  level.dropped_weapons[level.dropped_weapons.size] = weapon;
}

remove_from_weapon_array(weapon) {
  if(isDefined(weapon)) {
    if(scripts\engine\utility::array_contains(level.dropped_weapons, weapon))
      level.dropped_weapons = scripts\engine\utility::array_remove(level.dropped_weapons, weapon);
  }
}

smokegrenadeused(_id_E012E0B70D7D54FA) {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  thread _id_E4F6E856495DBAFB();

  if(istrue(_id_E012E0B70D7D54FA)) {
    self waittill("missile_stuck", position, stuckto, _id_1D9FB21B4F3023F3, surfacetype, velocity, normal);
    thread smokeglvfx(position);
  } else
    self waittill("explode", position);

  if(getdvarint("dvar_ABE45E35EF030A56") == 0)
    thread create_smoke_occluder(position);

  thread smokegrenadeexplode(position);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner)) {
    self.owner thread monitorsmokeactive();
    scripts\cp_mp\challenges::_id_B0F754C8A379154E("equip_smoke", self.owner, undefined, 0);
  }
}

create_smoke_occluder(origin) {
  if(isDefined(level.bot_smoke_sight_clip_large)) {
    occluder = spawn("script_model", origin);
    occluder show();
    wait 1;
    occluder clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
    occluder setmovertransparentvolume();
    wait 8.75;
    occluder delete();
  } else {
    occluder = spawn("script_model", origin);
    occluder setModel("ainosight256x256x256");
    occluder show();
    origin = occluder gettagorigin("tag_origin");
    thread scripts\engine\utility::draw_line_for_time(origin, origin + (0, 0, 128), 1, 0, 0, 8.75);
    wait 1;
    occluder setmovertransparentvolume();
    wait 8.75;
    occluder delete();
  }
}

_id_E4F6E856495DBAFB() {
  self endon("explode");
  self endon("death");
  self waittill("missile_water_impact", _id_7842E9E94384087B);
  self notify("end_explode");
  thread _id_9E58BAA59719D027();
}

_id_9E58BAA59719D027() {
  self endon("explode");
  self endon("death");
  self waittill("missile_stuck", _id_A681B7890CD017C7);
  position = self.origin;
  thread smokegrenadeexplode(position);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner))
    self.owner thread monitorsmokeactive();
}

smokegrenadeexplode(position) {
  level endon("game_ended");
  wait 1;
  thread smokegrenadegiveblindeye(position);

  if(getdvarint("dvar_ABE45E35EF030A56") == 1)
    scripts\common\ai::_id_8A09C0E5FA78A48C(position);

  id = scripts\cp\cp_outline_utility::addoutlineoccluder(position, 330);
  wait 8.25;
  scripts\cp\cp_outline_utility::removeoutlineoccluder(id);
}

smokegrenadegiveblindeye(position) {
  level endon("game_ended");
  struct = spawnStruct();
  struct.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(struct, position);

  foreach(_id_7217865F0CC39B1C in struct.blindeyerecipients) {
    if(isDefined(_id_7217865F0CC39B1C) && scripts\cp\utility\player::isreallyalive(_id_7217865F0CC39B1C))
      _id_7217865F0CC39B1C _id_6E09A830FAB9468F::removeperk("specialty_blindeye");
  }
}

smokegrenademonitorblindeyerecipients(struct, position) {
  level endon("game_ended");
  endtime = gettime() + 8250.0;
  players = [];

  while(gettime() < endtime) {
    players = scripts\cp\utility::getplayersinradius(position, 330);

    foreach(_id_6758A6F2FD1B6491, _id_7217865F0CC39B1C in struct.blindeyerecipients) {
      if(!isDefined(_id_7217865F0CC39B1C)) {
        struct.blindeyerecipients[_id_6758A6F2FD1B6491] = undefined;
        continue;
      }

      _id_44676E4D2A7FF788 = scripts\engine\utility::array_find(players, _id_7217865F0CC39B1C);

      if(!isDefined(_id_44676E4D2A7FF788) || !scripts\cp\utility\player::isreallyalive(_id_7217865F0CC39B1C)) {
        _id_7217865F0CC39B1C _id_6E09A830FAB9468F::removeperk("specialty_blindeye");
        struct.blindeyerecipients[_id_6758A6F2FD1B6491] = undefined;
      }

      if(isDefined(_id_44676E4D2A7FF788))
        players[_id_44676E4D2A7FF788] = undefined;
    }

    foreach(player in players) {
      if(!isDefined(player) || !isPlayer(player)) {
        continue;
      }
      player.lastinsmoketime = gettime();

      if(isDefined(struct.blindeyerecipients[player getentitynumber()])) {
        continue;
      }
      if(!scripts\cp\utility\player::isreallyalive(player)) {
        continue;
      }
      player scripts\cp\utility::giveperk("specialty_blindeye");

      if(isDefined(self) && isDefined(self.owner)) {}

      struct.blindeyerecipients[player getentitynumber()] = player;
    }

    waitframe();
  }
}

sfx_smoke_grenade_smoke(position) {
  wait 0.2;
  _id_4CF58793CC4F1AD6 = spawn("script_origin", position);
  _id_4CF58793CC4F1AD6 playLoopSound("smoke_grenade_smoke_lp");
  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_smoke_tail", position);
  wait 0.3;

  if(isDefined(_id_4CF58793CC4F1AD6))
    _id_4CF58793CC4F1AD6 stoploopsound();

  _id_4CF58793CC4F1AD6 scripts\cp_mp\ent_manager::deregisterspawn();
  _id_4CF58793CC4F1AD6 delete();
}

smokeglvfx(position, normal) {
  playFX(scripts\engine\utility::getfx("glsmoke"), position, anglestoup((0, 90, 0)));
}

monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\cp\utility::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  result = scripts\engine\utility::waittill_any_timeout_1(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\cp\utility::printgameaction("smoke grenade deactivated", self);
}

buildweaponwithrandomattachments(_id_AB501F397D3CD312, attachments, camo, reticle, variantid, _id_D1FD16429AB57618, _id_0FD85DA04B063943, _id_B022D4BB3C3772B3, cosmeticattachment, _id_11A1FA68AEB971C0, _id_341394BBCEB99516) {
  basename = _id_2669878CF5A1B6BC::getweaponrootname(_id_AB501F397D3CD312);

  if((!isDefined(_id_341394BBCEB99516) || _id_341394BBCEB99516) && !!isai(self)) {
    return;
  }
  return getweapon(basename, weaponclass(_id_AB501F397D3CD312));
}

getweapon(weaponname, weapontype) {
  weaponarray = [];

  if(isarray(weaponname)) {
    weaponarray = weaponname;
    weaponname = weaponname[randomint(weaponname.size)];
  } else
    weaponarray = [weaponname];

  if(weaponname == "iw9_lm_dblmg2_cp") {}

  if(1)
    return getweapon_aq(weapontype, weaponname, weaponarray);

  if(issubstr(tolower(self.classname), "_alq_"))
    return getweapon_aq(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_rus_desert_"))
    return getweapon_ru(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_spetsnaz_"))
    return getweapon_ru(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_hero_"))
    return getweapon_hero(weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_villain_"))
    return getweapon_hero(weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_sas_"))
    return getweapon_sas(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_reb_"))
    return getweapon_reb(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_so15_"))
    return getweapon_so15(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_london_police_"))
    return getweapon_so15(weapontype, weaponname, weaponarray);
  else if(issubstr(tolower(self.classname), "_usmc_"))
    return getweapon_usmc(weapontype, weaponname, weaponarray);
  else
    return _id_2669878CF5A1B6BC::buildweapon(weaponname);

  return weaponname;
}

getweapon_hero(weaponname, weaponarray) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (weaponname) {
      case "iw8_pi_mike1911":
        return make_weapon_special("alex_pistol");
      case "iw8_sn_mike14":
        return make_weapon_special("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_hadir")) {
    switch (weaponname) {
      case "iw8_sm_augolf":
        return make_weapon_special("hadir_smg");
      case "iw8_sn_hdromeo":
        return make_weapon_special("hadir_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (weaponname) {
      case "iw8_ar_mcharlie":
        return make_weapon_special("kyle_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (weaponname) {
      case "iw8_pi_papa320":
        return make_weapon_special("papa320_black");
      case "iw8_ar_kilo433":
        return make_weapon_special("price_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (weaponname) {
      case "iw8_ar_akilo47":
        return make_weapon_special("farah_ar");
    }
  } else if(issubstr(tolower(self.classname), "_villain_barkov")) {
    switch (weaponname) {
      case "iw8_pi_golf21":
        return make_weapon_special("barkov_pistol");
    }
  }

  if(getdvarint("dvar_0045281F93550798"))
    iprintln("not whitelisted!skipping scripted build.");

  return make_weapon(weaponname, []);
}

getweapon_aq(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "ar":
    case "rifle":
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 45;
      _id_0F2D4826375B8590["iw8_ar_falima"] = 35;
      _id_0F2D4826375B8590["iw8_ar_falpha"] = 20;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh", "stockl", "stockno", "stockfold"];
          _id_0E052C0161D3EF54["mags"] = [50, "drums", "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlong"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "gl", "glsmoke", "glgas", "glconc"];
          break;
        case "iw8_ar_falpha":
          _id_0E052C0161D3EF54["scopes"] = [10, "acog2", "acog2light", "thermalvz"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh", "stockl", "stocks"];
          _id_0E052C0161D3EF54["mags"] = [20, "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlong"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "selectsemi"];
          break;
        case "iw8_ar_falima":
          _id_0E052C0161D3EF54["scopes"] = [20, "acog2"];
          _id_0E052C0161D3EF54["mags"] = [20, "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripang"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort", "barlong"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "ub_mike203", "selectauto"];
          break;
      }

      break;
    case "dmr":
      _id_0F2D4826375B8590["iw8_sn_kilo98"] = 50;
      _id_0F2D4826375B8590["iw8_ar_falima"] = 50;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sn_kilo98":
          _id_0E052C0161D3EF54["scopes"] = [75, "scope", "vzscope"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh", "stockl"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlong", "barmid", "barshort"];
          _id_0E052C0161D3EF54["laserir"] = [50, "laserir"];
          _id_0E052C0161D3EF54["mags"] = [35, "xmags"];
          break;
        case "iw8_ar_falima":
          _id_0E052C0161D3EF54["scopes"] = [20, "acog2"];
          _id_0E052C0161D3EF54["mags"] = [20, "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripang"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort", "barlong"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "ub_mike203", "selectauto"];
          break;
      }

      break;
    case "jugg":
      return "iw8_lm_dblmg";
    case "launcher":
      return "iw8_la_rpapa7";
    case "lmg":
      _id_0F2D4826375B8590["iw8_lm_pkilo"] = 50;
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 35;
      _id_0F2D4826375B8590["iw8_sm_augolf"] = 15;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_lm_pkilo":
          _id_0E052C0161D3EF54["bipods"] = [75, "bipod"];
          _id_0E052C0161D3EF54["mags"] = [100, "drums", "xmags"];
          break;
        case "iw8_sm_augolf":
          _id_0E052C0161D3EF54["barrels"] = [100, "barlong"];
          _id_0E052C0161D3EF54["mags"] = [100, "drums", "xmags"];
          break;
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh", "stockl", "stockno", "stockfold"];
          _id_0E052C0161D3EF54["mags"] = [50, "drums", "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlong"];
          break;
      }

      break;
    case "pistol":
      _id_0F2D4826375B8590["iw8_pi_mike1911"] = 50;
      _id_0F2D4826375B8590["iw8_pi_golf21"] = 35;

      switch (weaponname) {
        case "iw8_pi_mike1911":
          _id_0E052C0161D3EF54["mags"] = [35, "xmags"];
        case "iw8_pi_golf21":
          _id_0E052C0161D3EF54["mags"] = [35, "xmags"];
          break;
      }

      break;
    case "shotgun":
      _id_0F2D4826375B8590["iw8_sh_romeo870"] = 50;
      _id_0F2D4826375B8590["iw8_sh_charlie725"] = 35;

      switch (weaponname) {
        case "iw8_sh_romeo870":
          _id_0E052C0161D3EF54["stocks"] = [80, "stockno", "stockh", "stockl", "stocks"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort", "barlong"];
          break;
        case "iw8_sh_charlie725":
          _id_0E052C0161D3EF54["scopes"] = [100, "scope"];
          _id_0E052C0161D3EF54["stocks"] = [75, "stockno", "stockh", "stockl", "stocks"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort", "barlong"];
          break;
      }

      break;
    case "smg":
      _id_0F2D4826375B8590["iw8_sm_uzulu"] = 90;
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 10;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sm_uzulu":
          _id_0E052C0161D3EF54["scopes"] = [100, "reflex2"];
          break;
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["scopes"] = [50, "thermalvz", "acog", "acog2", "holo2"];
          _id_0E052C0161D3EF54["stocks"] = [100, "stockl"];
          _id_0E052C0161D3EF54["mags"] = [50, "xmags"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripcust", "guardrail"];
          _id_0E052C0161D3EF54["barrels"] = [100, "barshortnoguard"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "gl", "glsmoke", "glgas", "glconc"];
          break;
      }

      break;
    case "sniper":
      _id_0F2D4826375B8590["iw8_sn_delta"] = 50;
      _id_0F2D4826375B8590["iw8_sn_kilo98"] = 50;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sn_kilo98":
          _id_0E052C0161D3EF54["scopes"] = [100, "scope"];
          _id_0E052C0161D3EF54["laserir"] = [100, "laserir"];
          _id_0E052C0161D3EF54["mags"] = [35, "xmags"];
          break;
        case "iw8_sn_delta":
          _id_0E052C0161D3EF54["scopes"] = [100, "scope"];
          _id_0E052C0161D3EF54["laserir"] = [100, "laserir"];
          _id_0E052C0161D3EF54["mags"] = [35, "xmags"];
          break;
      }

      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

getweapon_ru(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "rifle":
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 70;
      _id_0F2D4826375B8590["iw8_ar_asierra12"] = 30;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["scopes"] = [70, "acogstable_east01", "holostable_east01", "reflexstable_east01", "reflexstable_east02"];
          _id_0E052C0161D3EF54["stocks"] = [100, "stocksmg_akilo47", "stockno_akilo47", "stockfold_akilo47", "stockcust_akilo47"];
          _id_0E052C0161D3EF54["mags"] = [20, "drums_akilo47"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert_akilo47", "griphip_akilo47", "gripvert_akilo47"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlmg_akilo47", "barcust_akilo47"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "ub_golf25"];
          _id_0E052C0161D3EF54["other"] = [15, "laserir_bar"];
          break;
        case "iw8_ar_asierra12":
          _id_0E052C0161D3EF54["scopes"] = [70, "reflex_east01", "reflex_east02", "holo_east01", "acog_east01_irons"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh_asierra12", "stockl_asierra12", "stocks_asierra12"];
          _id_0E052C0161D3EF54["mags"] = [20, "xmags_asierra12"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripang"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barcust_asierra12", "barshort_asierra12", "barlong_asierra12"];
          _id_0E052C0161D3EF54["other"] = [15, "laserir"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "selectsemi"];
          break;
      }

      break;
    case "dmr":
      switch (weaponname) {
        case "iw8_sn_mike14":
          _id_0E052C0161D3EF54["scopes"] = [50, "snprscope_mike14"];
          _id_0E052C0161D3EF54["other"] = [100, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (weaponname) {
        case "iw8_lm_pkilo":
          _id_0E052C0161D3EF54["other"] = [50, "bipod_pkilo"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      _id_0F2D4826375B8590["iw8_sh_romeo870"] = 50;
      _id_0F2D4826375B8590["iw8_sh_oscar12"] = 50;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sh_romeo870":
          _id_0E052C0161D3EF54["scopes"] = [50, "reflex_east01", "reflex_east02"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockno_romeo870"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          _id_0E052C0161D3EF54["grips"] = [25, "gripcust_romeo870"];
          _id_0E052C0161D3EF54["other"] = [50, "laserir_bar"];
          break;
        case "iw8_sh_oscar12":
          _id_0E052C0161D3EF54["scopes"] = [50, "reflex_east01", "reflex_east02"];
          _id_0E052C0161D3EF54["stocks"] = [75, "stockno_oscar12", "stockh_oscar12"];
          _id_0E052C0161D3EF54["mags"] = [75, "drums_oscar12"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort_oscar12", "barmid_oscar12", "barlong_oscar12"];
          _id_0E052C0161D3EF54["other"] = [50, "laserir"];
          break;
      }

      break;
    case "smg":
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 70;
      _id_0F2D4826375B8590["iw8_sm_augolf"] = 30;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sm_augolf":
          _id_0E052C0161D3EF54["scopes"] = [50, "reflex_east01", "reflex_east02", "holo_east01"];
          _id_0E052C0161D3EF54["mags"] = [30, "drums_augolf"];
          _id_0E052C0161D3EF54["other"] = [50, "laserirsmg"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort_augolf"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvertsmg", "gripangsmg"];
          break;
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["barrels"] = [100, "barcust_akilo47"];
          _id_0E052C0161D3EF54["stocks"] = [100, "stockcust_akilo47", "stocksmg_akilo47", "stockno_akilo47", "stockno_akilo47"];
          _id_0E052C0161D3EF54["mags"] = [100, "calsmg_akilo47", "calsmgdrums_akilo47"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          _id_0E052C0161D3EF54["other"] = [50, "laserir_bar"];
          _id_0E052C0161D3EF54["scopes"] = [70, "holostable_east01", "reflexstable_east01", "reflexstable_east02"];
          break;
      }

      break;
    case "sniper":
      switch (weaponname) {
        case "iw8_sn_delta":
          _id_0E052C0161D3EF54["other"] = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

getweapon_reb(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "rifle":
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 50;
      _id_0F2D4826375B8590["iw8_ar_falpha"] = 50;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["scopes"] = [10, "acogstable_east01"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stocklmg_akilo47", "stocksmg_akilo47", "stockno_akilo47", "stockfold_akilo47"];
          _id_0E052C0161D3EF54["mags"] = [20, "drums_akilo47", "mag_akilo47|1"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert_akilo47", "griphip_akilo47", "guard_akilo47|1"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlmg_akilo47", "front_akilo47|1"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "ub_golf25"];
          _id_0E052C0161D3EF54["other"] = [15, "rec_akilo47|1"];
          break;
        case "iw8_ar_falpha":
          _id_0E052C0161D3EF54["scopes"] = [15, "acog_east01_irons"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockh_falpha", "stockl_falpha", "stocks_falpha"];
          _id_0E052C0161D3EF54["mags"] = [20, "xmags_falpha"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripang"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barlong_falpha", "barcust_falpha", "barshort_falpha"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "selectsemi"];
          break;
      }

      break;
    case "dmr":
      switch (weaponname) {
        case "iw8_sn_kilo98":
          _id_0E052C0161D3EF54["scopes"] = [50, "snprscope_kilo98", "vzscope_kilo98"];
          _id_0E052C0161D3EF54["mags"] = [30, "xmags_kilo98"];
          _id_0E052C0161D3EF54["other"] = [40, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      _id_0F2D4826375B8590["iw8_lm_pkilo"] = 50;
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 35;
      _id_0F2D4826375B8590["iw8_sm_augolf"] = 15;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_lm_pkilo":
          _id_0E052C0161D3EF54["scopes"] = [50, "reflex_west01", "acog_east01_irons", "holo_east01"];
          _id_0E052C0161D3EF54["bipods"] = [75, "bipod_pkilo"];
          _id_0E052C0161D3EF54["mags"] = [35, "xmags_pkilo", "drums_pkilo"];
          break;
        case "iw8_sm_augolf":
          _id_0E052C0161D3EF54["scopes"] = [50, "reflex_west01", "acog_east01", "holo_east01"];
          _id_0E052C0161D3EF54["arrels"] = [100, "barlmg_augolf"];
          _id_0E052C0161D3EF54["ags"] = [100, "callmgdrums_augolf", "callmg_augolf"];
          _id_0E052C0161D3EF54["ther"] = [50, "rec_augolf|1"];
          break;
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["barrels"] = [100, "barlmg_akilo47"];
          _id_0E052C0161D3EF54["bipods"] = [50, "bipod_akilo47"];
          _id_0E052C0161D3EF54["mags"] = [100, "callmgdrums_akilo47", "callmg_akilo47"];
          _id_0E052C0161D3EF54["scopes"] = [50, "reflexstable_west01", "acogstable_east01", "holostable_east01"];
          _id_0E052C0161D3EF54["stocks"] = [75, "stocklmg_akilo47"];
          _id_0E052C0161D3EF54["grips"] = [50, "guard_akilo47|1"];
          _id_0E052C0161D3EF54["other"] = [50, "rec_akilo47|1"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      switch (weaponname) {
        case "iw8_sh_romeo870":
          _id_0E052C0161D3EF54["stocks"] = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      _id_0F2D4826375B8590["iw8_ar_akilo47"] = 70;
      _id_0F2D4826375B8590["iw8_sm_uzulu"] = 15;
      _id_0F2D4826375B8590["iw8_sm_mpapa5"] = 15;
      weaponname = scripts\common\utility::get_weapon_weighted(weaponarray, _id_0F2D4826375B8590);

      switch (weaponname) {
        case "iw8_sm_uzulu":
          _id_0E052C0161D3EF54["scopes"] = [50, "minireddot", "reflex_west01", "reflex_east01", "reflex_east02"];
          break;
        case "iw8_ar_akilo47":
          _id_0E052C0161D3EF54["barrels"] = [100, "barcust_akilo47"];
          _id_0E052C0161D3EF54["stocks"] = [100, "stockcust_akilo47", "stockno_akilo47", "stockno_akilo47"];
          _id_0E052C0161D3EF54["mags"] = [100, "calsmg_akilo47", "calsmgdrums_akilo47"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert_akilo47", "gripang_akilo47"];
          _id_0E052C0161D3EF54["scopes"] = [30, "reflexstable_west01", "reflexstable_west01", "reflexstable_east01"];
          break;
        case "iw8_sm_mpapa5":
          _id_0E052C0161D3EF54["stocks"] = [50, "stockno_mpapa5", "stockh_mpapa5", "stocks_mpapa5"];
          _id_0E052C0161D3EF54["mags"] = [35, "drums_mpapa5"];
          _id_0E052C0161D3EF54["grips"] = [35, "gripvertsmg"];
          _id_0E052C0161D3EF54["scopes"] = [30, "reflex_west01_irons", "reflex_east01", "reflex_east02", "minireddot"];
          break;
      }

      break;
    case "sniper":
      switch (weaponname) {
        case "iw8_sn_alpha50":
          _id_0E052C0161D3EF54["scopes"] = [100, "snprscope_alpha50", "vzscope_alpha50"];
          _id_0E052C0161D3EF54["barrels"] = [50, "barmid_alpha50", "barshort_alpha50"];
          _id_0E052C0161D3EF54["laserir"] = [100, "laserads"];
          _id_0E052C0161D3EF54["stocks"] = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          _id_0E052C0161D3EF54["other"] = [25, "bipodsnpr"];
          _id_0E052C0161D3EF54["mags"] = [35, "xmags_alpha50"];
          break;
      }

      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

getweapon_sas(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "rifle":
      return make_weapon_special("sas_ar");
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      return make_weapon_special("papa320_black");
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

getweapon_so15(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "rifle":
      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      if(level.script == "piccadilly" || level.script == "ai_aitypes_allies")
        return make_weapon_special("papa320_black_rain");
      else
        return make_weapon_special("papa320_black");
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

getweapon_usmc(type, weaponname, weaponarray) {
  _id_0E052C0161D3EF54 = [];
  _id_C8F4FE738C61245A = [];

  switch (type) {
    case "rifle":
      switch (weaponname) {
        case "iw8_ar_mike4":
          _id_0E052C0161D3EF54["scopes"] = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          _id_0E052C0161D3EF54["stocks"] = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          _id_0E052C0161D3EF54["mags"] = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          _id_0E052C0161D3EF54["grips"] = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          _id_0E052C0161D3EF54["barrels"] = [70, "barshort_mike4", "front_mike4|2"];
          _id_0E052C0161D3EF54["underbarrels"] = [15, "ub_mike203"];
          _id_0E052C0161D3EF54["endbarrel"] = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          _id_0E052C0161D3EF54["other"] = [50, "rec_mike4|1", "rec_mike4|2"];
          break;
      }

      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      break;
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
}

make_weapon_special(weapon) {
  switch (weapon) {
    case "farah_ar":
      weapon = make_weapon("iw8_ar_akilo47", ["rec_akilo47|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1", "guard_akilo47|1"]);
      break;
    case "alex_sniper":
      weapon = make_weapon("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "mag_mike14|1"]);
      break;
    case "alex_pistol":
      weapon = make_weapon("iw8_pi_mike1911", ["rec_mike1911|2", "mag_mike1911|2", "slide_mike1911|2"]);
      break;
    case "hadir_smg":
      weapon = make_weapon("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      weapon = make_weapon("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      weapon = make_weapon("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "price_ar":
      weapon = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      weapon = make_weapon("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "front_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      weapon = make_weapon("iw8_pi_papa320", ["rec_papa320|2", "mag_papa320|2", "slide_papa320|2"]);
      break;
    case "papa320_black_rain":
      weapon = make_weapon("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      weapon = make_weapon("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      weapon = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      weapon = make_weapon("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    default:
      weapon = undefined;
  }

  return weapon;
}

make_weapon(basename, attachments, reticle, camo, lootid, _id_CCBAB88FC1E2B3DA) {
  if(!isDefined(level._weapons))
    level._weapons = spawnStruct();

  if(!isDefined(attachments))
    attachments = [];

  if(!isweapon(basename)) {
    _id_E97377032A878881 = strtok(basename, "+");

    if(_id_E97377032A878881.size > 1) {
      basename = _id_E97377032A878881[0];
      attachments = scripts\engine\utility::array_combine(attachments, scripts\engine\utility::array_remove(_id_E97377032A878881, _id_E97377032A878881[0]));
    }
  } else {
    if(isnullweapon(basename))
      return basename;

    basename = getweaponbasename(basename);
  }

  if(istrue(_id_CCBAB88FC1E2B3DA))
    _id_8B5443598FC587BF = ::makealtweapon;
  else
    _id_8B5443598FC587BF = ::makeweapon;

  _id_AB501F397D3CD312 = basename;

  if(issubstr(basename, "_mp"))
    _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(basename);

  defaults = scripts\cp\utility::weaponattachdefaultmap(_id_AB501F397D3CD312);
  defaults = removeconflictingattachments(attachments, defaults);
  attachments = scripts\engine\utility::array_combine(attachments, defaults);
  _id_C7BD95B10C89CFF8 = _id_2669878CF5A1B6BC::weaponassetnamemap(_id_AB501F397D3CD312, lootid);
  _id_31792301AA1F7373 = [];

  foreach(attachment in attachments) {
    if(issubstr(attachment, "|")) {
      attachments = scripts\engine\utility::array_remove(attachments, attachment);
      attachments[attachments.size] = strtok(attachment, "|")[0];
      _id_31792301AA1F7373[_id_31792301AA1F7373.size] = attachment;
    }
  }

  _id_05B3BE55212A58FF = _id_29BA39C7E2ADB57B(_id_AB501F397D3CD312, attachments, lootid);
  _id_05B3BE55212A58FF = checkforinvalidattachments(_id_05B3BE55212A58FF, _id_C7BD95B10C89CFF8);
  attachments = _id_05B3BE55212A58FF;

  if(isDefined(lootid))
    weapon = call[[_id_8B5443598FC587BF]](_id_C7BD95B10C89CFF8, attachments, reticle, camo, lootid);
  else if(isDefined(camo))
    weapon = call[[_id_8B5443598FC587BF]](_id_C7BD95B10C89CFF8, attachments, reticle, camo);
  else if(isDefined(reticle))
    weapon = call[[_id_8B5443598FC587BF]](_id_C7BD95B10C89CFF8, attachments, reticle);
  else if(isDefined(attachments))
    weapon = call[[_id_8B5443598FC587BF]](_id_C7BD95B10C89CFF8, attachments);
  else
    weapon = call[[_id_8B5443598FC587BF]](_id_C7BD95B10C89CFF8);

  foreach(attachment in _id_31792301AA1F7373) {
    _id_E97377032A878881 = strtok(attachment, "|");
    weapon = weapon withattachment(_id_E97377032A878881[0], int(_id_E97377032A878881[1]));
  }

  return weapon;
}

removeconflictingattachments(attachments, defaults) {
  defaults = removeconflictingdefaultattachment(attachments, defaults, "bar", "front_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "barlong", "slide_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "barcust", "guard_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "stock", "back_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "cal", "mag_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "drums", "mag_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "xmags", "mag_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "mag_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "rack", "ammo_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "thermal", "scope");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "acog", "scope");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "reflex", "scope");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "holo", "scope");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "grip", "grip_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "rec_", "rec_");
  defaults = removeconflictingdefaultattachment(attachments, defaults, "toprail_", "toprail_");
  return defaults;
}

removeconflictingdefaultattachment(_id_39ACC07A4F70F5CA, _id_5EE0618A4ED56AE4, _id_88392C40E907845C, _id_2B1E423CC62C0FD2) {
  _id_58F169DC13811791 = undefined;

  foreach(attachment in _id_39ACC07A4F70F5CA) {
    if(issubstr(attachment, _id_2B1E423CC62C0FD2))
      _id_58F169DC13811791 = 1;

    if(isstartstr(attachment, _id_88392C40E907845C) || istrue(_id_58F169DC13811791)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5EE0618A4ED56AE4.size; _id_AC0E594AC96AA3A8++) {
        if(issubstr(_id_5EE0618A4ED56AE4[_id_AC0E594AC96AA3A8], _id_2B1E423CC62C0FD2)) {
          _id_5EE0618A4ED56AE4 = scripts\engine\utility::array_remove_index(_id_5EE0618A4ED56AE4, _id_AC0E594AC96AA3A8);
          return _id_5EE0618A4ED56AE4;
        }
      }
    }
  }

  return _id_5EE0618A4ED56AE4;
}

randomize_weapon(weaponname, _id_0E052C0161D3EF54, _id_C8F4FE738C61245A) {
  attachments = scripts\common\utility::get_random_attachments(_id_0E052C0161D3EF54, _id_C8F4FE738C61245A);
  weapon = make_weapon(weaponname, attachments);
  return weapon;
}

getscriptedweapon(weaponname, _id_E46130A1F1555462) {
  if(!isDefined(weaponname))
    return nullweapon();

  if(!isarray(weaponname) && weaponname == "")
    return nullweapon();

  if(isDefined(_id_E46130A1F1555462) && _id_E46130A1F1555462 == "sidearm")
    weapon = getweapon(weaponname, "pistol");
  else
    weapon = getweapon(weaponname, self.scriptedweaponclassprimary);

  return weapon;
}

printweapon() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    _id_544CB2E6005F5D27 = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      if(isDefined(self.weapon.basename)) {}

      if(isDefined(self.weapon.attachments)) {
        _id_627FB8865600BD0A = _id_544CB2E6005F5D27 - 1.5;

        foreach(_id_AC0E594AC96AA3A8, attachment in self.weapon.attachments)
        _id_627FB8865600BD0A = _id_627FB8865600BD0A - 1.4;
      }
    }

    waitframe();
  }
}

monitordisownedgrenade(player, grenade) {
  level endon("game_ended");
  grenade endon("death");
  grenade endon("mine_planted");
  player scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");

  if(isDefined(grenade))
    grenade delete();
}

riotshield_getmodel() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    switch (weapon.basename) {
      case "iw9_me_riotshield_mp":
        return "weapon_wm_riotshield_p34";
      case "iw8_me_riotshield_mpv7":
        return "weapon_wm_riotshield_v7";
      case "iw8_me_riotshield_mpv6":
        return "weapon_wm_riotshield_v6";
      case "iw8_me_riotshield_mpv5":
        return "weapon_wm_riotshield_v5";
      case "iw8_me_riotshield_mpv4":
        return "weapon_wm_riotshield_v4";
      case "iw8_me_riotshield_mpv3":
        return "weapon_wm_riotshield_v3";
      case "iw8_me_riotshield_mpv2":
        return "weapon_wm_riotshield_v2";
      case "iw8_me_riotshield_mp":
        return "weapon_wm_riotshield";
    }
  }
}

setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}

ispickedupweapon(weapon) {
  if(iscacprimaryweapon(weapon) || iscacsecondaryweapon(weapon)) {
    _id_C27E2A04BAB78C1F = undefined;

    if(isweapon(weapon))
      _id_C27E2A04BAB78C1F = getcompleteweaponname(weapon getnoaltweapon());
    else if(isstring(weapon)) {
      _id_C27E2A04BAB78C1F = weapon;

      if(issubstr(_id_C27E2A04BAB78C1F, "alt_"))
        _id_C27E2A04BAB78C1F = getsubstr(_id_C27E2A04BAB78C1F, 4, weapon.size);
    }

    _id_0D721C63A9570D5C = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == _id_C27E2A04BAB78C1F;
    _id_7DF1C1394810BF14 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == _id_C27E2A04BAB78C1F;

    if(!_id_0D721C63A9570D5C && !_id_7DF1C1394810BF14)
      return 1;
  }

  return 0;
}

isvehicleweapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  switch (weaponname) {
    case "hummer_mp":
    case "blima_mp":
    case "palfa_mp":
    case "pickup_2014_mp":
    case "techo_rebel_armor_mp":
    case "cougar_mp":
    case "pwc_mp":
    case "sedan_hatchback_1985_hsk_mp":
    case "sedan_hatchback_1985_mp":
    case "chopped_pickup_mp":
    case "overland_2016_mp":
    case "suv_1996_wkd_mp":
    case "suv_1996_mp":
    case "patrol_boat_wkd_mp":
    case "patrol_boat_mp":
    case "jltv_mg_hsk_mp":
    case "jltv_mg_mp":
    case "jltv_hsk_mp":
    case "jltv_mp":
    case "rhib_mp":
    case "tur_gun_little_bird_left_mp":
    case "tur_gun_little_bird_right_mp":
    case "tur_gun_fav_heavy_mp":
    case "tur_gun_cargo_truck_mp":
    case "bradley_tow_proj_mp":
    case "lighttank_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "mrap_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "cop_car_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
    case "iw9_mg_light_tank_mp":
    case "iw9_mg_jltv_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw9_tur_light_tank_mp":
    case "iw9_mg_cougar_mp":
    case "iw9_tur_cougar_mp":
    case "iw9_mg_patrol_boat_back_mp":
    case "iw9_mg_patrol_boat_front_mp":
      return 1;
    default:
      return 0;
  }
}

attachmentlogsstats(_id_E3F6CCA91074060E, weapon) {
  if(_id_2669878CF5A1B6BC::attachmentiscosmetic(_id_E3F6CCA91074060E))
    return 0;

  if(!attachmentisselectable(weapon, _id_E3F6CCA91074060E))
    return 0;

  if(scripts\engine\utility::string_starts_with(_id_E3F6CCA91074060E, "laststand_"))
    return 0;

  return 1;
}

attachmentisselectable(weaponobj, attachment) {
  _id_AB501F397D3CD312 = _id_2669878CF5A1B6BC::getweaponrootname(weaponobj);
  return scripts\cp\cp_loadout::attachmentisselectablerootname(_id_AB501F397D3CD312, attachment);
}

mapweapon(objweapon, inflictor, _id_0A2C7A399AE430EB) {
  _id_EEF5AD438E5FA0C2 = objweapon;

  if(!isDefined(objweapon))
    _id_EEF5AD438E5FA0C2 = makeweapon("none");

  _id_EA958BD2FA62A2FA = 0;

  if(_id_EEF5AD438E5FA0C2.basename != "none") {
    switch (_id_EEF5AD438E5FA0C2.basename) {
      case "pop_rocket_proj_mp":
        _id_EEF5AD438E5FA0C2 = makeweapon("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        _id_EEF5AD438E5FA0C2 = makeweapon("iw8_turret_50cal_mp");
        break;
      case "ks_remote_drone_mp":
        _id_EEF5AD438E5FA0C2 = makeweapon("none");
        break;
    }
  } else if(isDefined(inflictor)) {
    if(isDefined(inflictor.objweapon)) {
      _id_EEF5AD438E5FA0C2 = makeweapon(inflictor.objweapon.basename);
      _id_EA958BD2FA62A2FA = 1;
    } else if(isDefined(inflictor.weapon_name)) {
      _id_EEF5AD438E5FA0C2 = makeweapon(inflictor.weapon_name);
      _id_EA958BD2FA62A2FA = 1;
    }
  }

  if(_id_EA958BD2FA62A2FA && !istrue(_id_0A2C7A399AE430EB))
    _id_EEF5AD438E5FA0C2 = mapweapon(_id_EEF5AD438E5FA0C2, inflictor, 1);

  return _id_EEF5AD438E5FA0C2;
}

makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

attachmentsfilterforstats(attachments, weapon) {
  _id_7CB19F95DBC68942 = [];

  if(isDefined(attachments) && isarray(attachments)) {
    foreach(a in attachments) {
      if(attachmentlogsstats(a, weapon))
        _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = a;
    }
  }

  return _id_7CB19F95DBC68942;
}

_id_2F4D1CDA9BC48E6A(weaponobj) {
  _id_6E92BBBC0D0D8C94 = 0;
  currentweapon = weaponobj;
  _id_DD515FCF025B2E79 = undefined;
  _id_59F6B815C04D4E52 = _func_DDE0CCE873A8C5A2(getcompleteweaponname(currentweapon), "silencer")[0];

  for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < currentweapon.attachments.size; _id_AC0E5C4AC96AAA41++) {
    if(isDefined(_id_59F6B815C04D4E52) && weaponobj canuseattachment(_id_59F6B815C04D4E52) && _id_2669878CF5A1B6BC::attachmentsconflict(currentweapon.attachments[_id_AC0E5C4AC96AAA41], _id_59F6B815C04D4E52, weaponobj) == "") {
      _id_6E92BBBC0D0D8C94 = 1;
      continue;
    }

    _id_6E92BBBC0D0D8C94 = 0;
    break;
  }

  if(_id_6E92BBBC0D0D8C94)
    _id_DD515FCF025B2E79 = weaponobj withattachment(_id_59F6B815C04D4E52);

  if(!isDefined(_id_DD515FCF025B2E79))
    return weaponobj;

  return _id_DD515FCF025B2E79;
}

_id_40DA684343B2EAF8(attachment) {
  _id_C7DAC5E40890251A = 0;
  currentweapon = self;
  _id_66B3DB972AC1531E = undefined;

  if(self canuseattachment(attachment)) {
    _id_C7DAC5E40890251A = 1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < currentweapon.attachments.size; _id_AC0E594AC96AA3A8++) {
      if(_id_2669878CF5A1B6BC::attachmentsconflict(currentweapon.attachments[_id_AC0E594AC96AA3A8], attachment, self) != "")
        _id_66B3DB972AC1531E = self withoutattachment(currentweapon.attachments[_id_AC0E594AC96AA3A8]);
    }

    _id_66B3DB972AC1531E = self withattachment(attachment);
  }

  if(!isDefined(_id_66B3DB972AC1531E))
    return self;

  return _id_66B3DB972AC1531E;
}

_id_2D291CFD98FD0D8E() {
  level endon("game_ended");
  level._id_0BCD25CD23011249 = [];

  if(getdvarint("dvar_742CAA13B3C2E685", 0)) {
    return;
  }
  keys = getarraykeys(level.weapongroupdata);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.weapongroupdata[keys[_id_AC0E594AC96AA3A8]].size; _id_AC0E5C4AC96AAA41++)
      _id_41F42CDE8798905F(level.weapongroupdata[keys[_id_AC0E594AC96AA3A8]][_id_AC0E5C4AC96AAA41] + "_mp", keys[_id_AC0E594AC96AA3A8]);
  }

  _id_41F42CDE8798905F("iw9_ar_golf3_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_kilo53_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_mike4_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_mike16_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_akilo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_akilo105_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_akilo74_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_schotel_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_augolf_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_mcharlie_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_ar_scharlie_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_br_msecho_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_br_soscar14_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_aviktor_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_alpha57_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_mpapa5_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_mpapa7_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_beta_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_victor_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_apapa_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sm_papa90_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_pi_decho_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_pi_papa220_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_pi_golf17_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_pi_golf18_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sn_mromeo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sn_limax_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sn_india_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_kilo21_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_slima_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_foxtrot_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_rkilo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_ahotel_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_lm_ngolf7_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sh_mbravo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sh_charlie725_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sh_mike1014_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_sh_mviktor_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_mike24_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_sa700_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_la700_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_pgolf1_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_xmike2010_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_sbeta_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_mike14_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_dm_scromeo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_la_rpapa7_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_la_juliet_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_la_mike32_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_la_gromeo_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_la_kgolf_mp", undefined, 1);
  _id_41F42CDE8798905F("iw9_pi_stimpistol_mp", undefined, 1);
  level._id_0BCD25CD23011249["akilo"] = level._id_0BCD25CD23011249["iw9_ar_akilo_mp"];
  level._id_0BCD25CD23011249["mike4"] = level._id_0BCD25CD23011249["iw9_ar_mike4_mp"];
  level._id_0BCD25CD23011249["akilo105"] = level._id_0BCD25CD23011249["iw9_ar_akilo105_mp"];
  level._id_0BCD25CD23011249["akilo74"] = level._id_0BCD25CD23011249["iw9_ar_akilo74_mp"];
  level._id_0BCD25CD23011249["augolf"] = level._id_0BCD25CD23011249["iw9_ar_augolf_mp"];
  level._id_0BCD25CD23011249["kilo53"] = level._id_0BCD25CD23011249["iw9_ar_kilo53_mp"];
  level._id_0BCD25CD23011249["scharlie"] = level._id_0BCD25CD23011249["iw9_ar_scharlie_mp"];
  level._id_0BCD25CD23011249["mcharlie"] = level._id_0BCD25CD23011249["iw9_ar_mcharlie_mp"];
  level._id_0BCD25CD23011249["schotel"] = level._id_0BCD25CD23011249["iw9_ar_schotel_mp"];
  level._id_0BCD25CD23011249["decho"] = level._id_0BCD25CD23011249["iw9_pi_decho_mp"];
  level._id_0BCD25CD23011249["golf17"] = level._id_0BCD25CD23011249["iw9_pi_golf17_mp"];
  level._id_0BCD25CD23011249["golf18"] = level._id_0BCD25CD23011249["iw9_pi_golf18_mp"];
  level._id_0BCD25CD23011249["papa220"] = level._id_0BCD25CD23011249["iw9_pi_papa220_mp"];
  level._id_0BCD25CD23011249["aviktor"] = level._id_0BCD25CD23011249["iw9_sm_aviktor_mp"];
  level._id_0BCD25CD23011249["beta"] = level._id_0BCD25CD23011249["iw9_sm_beta_mp"];
  level._id_0BCD25CD23011249["mpapa5"] = level._id_0BCD25CD23011249["iw9_sm_mpapa5_mp"];
  level._id_0BCD25CD23011249["mpapa7"] = level._id_0BCD25CD23011249["iw9_sm_mpapa7_mp"];
  level._id_0BCD25CD23011249["victor"] = level._id_0BCD25CD23011249["iw9_sm_victor_mp"];
  level._id_0BCD25CD23011249["alpha57"] = level._id_0BCD25CD23011249["iw9_sm_alpha57_mp"];
  level._id_0BCD25CD23011249["charlie725"] = level._id_0BCD25CD23011249["iw9_sh_charlie725_mp"];
  level._id_0BCD25CD23011249["mbravo"] = level._id_0BCD25CD23011249["iw9_sh_mbravo_mp"];
  level._id_0BCD25CD23011249["mike1014"] = level._id_0BCD25CD23011249["iw9_sh_mike1014_mp"];
  level._id_0BCD25CD23011249["kilo21"] = level._id_0BCD25CD23011249["iw9_lm_kilo21_mp"];
  level._id_0BCD25CD23011249["slima"] = level._id_0BCD25CD23011249["iw9_lm_slima_mp"];
  level._id_0BCD25CD23011249["ngolf7"] = level._id_0BCD25CD23011249["iw9_lm_ngolf7_mp"];
  level._id_0BCD25CD23011249["la700"] = level._id_0BCD25CD23011249["iw9_dm_la700_mp"];
  level._id_0BCD25CD23011249["mike24"] = level._id_0BCD25CD23011249["iw9_dm_mike24_mp"];
  level._id_0BCD25CD23011249["mike14"] = level._id_0BCD25CD23011249["iw9_dm_mike14_mp"];
  level._id_0BCD25CD23011249["pgolf1"] = level._id_0BCD25CD23011249["iw9_dm_pgolf1_mp"];
  level._id_0BCD25CD23011249["sa700"] = level._id_0BCD25CD23011249["iw9_dm_sa700_mp"];
  level._id_0BCD25CD23011249["sbeta"] = level._id_0BCD25CD23011249["iw9_dm_sbeta_mp"];
  level._id_0BCD25CD23011249["xmike2010"] = level._id_0BCD25CD23011249["iw9_dm_xmike2010_mp"];
  level._id_0BCD25CD23011249["alpha50"] = level._id_0BCD25CD23011249["iw9_sn_alpha50_mp"];
  level._id_0BCD25CD23011249["limax"] = level._id_0BCD25CD23011249["iw9_sn_limax_mp"];
  level._id_0BCD25CD23011249["india"] = level._id_0BCD25CD23011249["iw9_sn_india_mp"];
  level._id_0BCD25CD23011249["mromeo"] = level._id_0BCD25CD23011249["iw9_sn_mromeo_mp"];
  level._id_0BCD25CD23011249["rpapa7"] = level._id_0BCD25CD23011249["iw9_la_rpapa7_mp"];
  level._id_0BCD25CD23011249["kgolf"] = level._id_0BCD25CD23011249["iw9_la_kgolf_mp"];
  level._id_0BCD25CD23011249["gromeo"] = level._id_0BCD25CD23011249["iw9_la_gromeo_mp"];
  level._id_0BCD25CD23011249["knife"] = makeweaponfromstring("iw9_me_knife_mp+iw9_me_knife");
  level._id_0BCD25CD23011249["super_stimpistol"] = makeweaponfromstring("iw9_pi_stimpistol_mp");
  level._id_0BCD25CD23011249["fists"] = makeweaponfromstring("iw9_me_fists_mp");

  if(getdvarint("dvar_7E7D59DF2E5DC031", 0)) {
    keys = getarraykeys(level._id_0BCD25CD23011249);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {}
  }
}

_id_6C30DE47F7BEFBAC() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level._id_BD8C1F8F6677E0EF = scripts\engine\utility::getStructArray("perm_wall_weapon", "targetname");
  scripts\engine\utility::flag_wait("default_weapons_created");
  keys = getarraykeys(level._id_0BCD25CD23011249);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_BD8C1F8F6677E0EF.size; _id_AC0E594AC96AA3A8++) {}
}

_id_7544739099D55631() {}

_id_41F42CDE8798905F(_id_132360A247A77FA7, weapon_class, _id_22C173E9283D2E0D, _id_7064974A67473784) {
  _id_51A91CEB6CC9AD2F = _id_132360A247A77FA7;
  attachments = _func_6527364C1ECCA6C6(_id_132360A247A77FA7);
  objweapon = makeweapon(_id_132360A247A77FA7, attachments);

  if(!istrue(_id_7064974A67473784))
    objweapon = objweapon _id_DCB52BCBBCB80B00("silencer");

  if(!isDefined(weapon_class))
    weapon_class = "No Class Assigned";

  if(weapon_class == "weapon_pistol")
    weaponobj = objweapon _id_DCB52BCBBCB80B00("pgrip_tac");

  level._id_0BCD25CD23011249[_id_51A91CEB6CC9AD2F] = objweapon;

  if(istrue(_id_22C173E9283D2E0D)) {
    return;
  }
  thread _id_8CFFC9416E0AB766(_id_51A91CEB6CC9AD2F, weapon_class);
  path = weapon_class + "/" + _id_51A91CEB6CC9AD2F + "/Default";
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Weapons /" + path + "\" \"set scr_debug debugGiveWeapon_+" + _id_51A91CEB6CC9AD2F + "\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_A5AD598DD7668B55() {
  level endon("game_ended");

  if(!getdvarint("dvar_CDFF493FB526772C", 0)) {
    return;
  }
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(!isDefined(level._id_6E48AEDC6BC2557F))
    level._id_6E48AEDC6BC2557F = scripts\engine\utility::getStructArray("perm_wall_weapon", "targetname");

  _id_5D99A225CB875DDA = level._id_6E48AEDC6BC2557F;
  keys = getarraykeys(level._id_0BCD25CD23011249);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5D99A225CB875DDA.size; _id_AC0E594AC96AA3A8++) {
    struct = _id_5D99A225CB875DDA[_id_AC0E594AC96AA3A8];
    weaponobj = level._id_0BCD25CD23011249[keys[_id_AC0E594AC96AA3A8]];
    weapon = _id_66122A002AFF5D57::createspawnweaponatpos(struct.origin + (5, 0, 0), (0, -90, -90), weaponobj, 1);

    if(isDefined(weapon)) {
      weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(1);
      weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
      continue;
    }
  }
}

_id_8CFFC9416E0AB766(default_weapon, weapon_class) {
  _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(default_weapon);
  index = 0;
  _id_928C1CAC31EA99E5 = _id_4BB9768282D4260D + "|" + index;
  _id_44482BF78727B6EA = [];
  _id_44482BF78727B6EA["iw9_lm_mkilo3"] = [2];
  _id_44482BF78727B6EA["iw9_ar_akilo"] = [2];
  _id_44482BF78727B6EA["iw9_pi_papa220"] = [2];
  _id_830C168BA5B1B399 = 1;

  while(_id_830C168BA5B1B399) {
    waitframe();

    if(isDefined(level.weaponlootmapdata[_id_928C1CAC31EA99E5])) {
      _id_6EEAEB3717F8724C = 0;

      if(isDefined(_id_44482BF78727B6EA[_id_4BB9768282D4260D])) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_44482BF78727B6EA[_id_4BB9768282D4260D].size; _id_AC0E594AC96AA3A8++) {
          if(_id_44482BF78727B6EA[_id_4BB9768282D4260D][_id_AC0E594AC96AA3A8] == index) {
            _id_6EEAEB3717F8724C = 1;
            break;
          }
        }
      }

      if(_id_6EEAEB3717F8724C) {
        index++;
        _id_928C1CAC31EA99E5 = _id_4BB9768282D4260D + "|" + index;
        continue;
      }

      weaponobj = _id_2669878CF5A1B6BC::buildweapon_blueprint(_id_4BB9768282D4260D, "none", "none", index);

      if(!isDefined(weaponobj)) {}

      level._id_0BCD25CD23011249[default_weapon + "|" + index] = weaponobj;
      path = weapon_class + "/" + default_weapon + "/Variants/" + index;
      _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Weapons /" + path + "\" \"set scr_debug debugGiveWeapon_+" + default_weapon + "|" + index + "\" \n";
      scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
      index++;
      _id_928C1CAC31EA99E5 = _id_4BB9768282D4260D + "|" + index;
      continue;
    }

    _id_830C168BA5B1B399 = 0;
  }
}

_id_F123CC18B09056D1(weapon) {
  _id_0441F289555E2CCF = [];
  attachments = _func_75B035199842693D(weapon, "frontpiece");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < attachments.size; _id_AC0E594AC96AA3A8++) {
    if(_id_2669878CF5A1B6BC::issilencerattach(weapon, attachments[_id_AC0E594AC96AA3A8]))
      _id_0441F289555E2CCF[_id_0441F289555E2CCF.size] = attachments[_id_AC0E594AC96AA3A8];
  }

  return _id_0441F289555E2CCF;
}

_id_B65AD646EB126204(_id_F82A37450B9DE94D) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  weapon_obj = level._id_0BCD25CD23011249[_id_F82A37450B9DE94D];

  if(isDefined(weapon_obj)) {
    currentweapon = self getcurrentprimaryweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon_obj);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon_obj);
  }
}

_id_768C9A047AED19F4(_id_F82A37450B9DE94D) {
  weapon_obj = level._id_0BCD25CD23011249[_id_F82A37450B9DE94D];

  if(isDefined(weapon_obj))
    return weapon_obj;
  else
    return undefined;
}

_id_9B46467A26F087EA(_id_F82A37450B9DE94D) {
  weapon_obj = level._id_0BCD25CD23011249[_id_F82A37450B9DE94D];

  if(isDefined(weapon_obj))
    return getcompleteweaponname(weapon_obj);
  else
    return undefined;
}

_id_DCB52BCBBCB80B00(_id_0C4D6B4CFA2D186C) {
  if(isDefined(_id_0C4D6B4CFA2D186C) && isstring(_id_0C4D6B4CFA2D186C))
    _id_0C4D6B4CFA2D186C = [_id_0C4D6B4CFA2D186C];

  weaponobj = self;
  _id_539CFFF6632D4FCE = _id_2669878CF5A1B6BC::_id_C471A035D22DF5EB();
  attachments = _id_2669878CF5A1B6BC::_id_91D352B50D9A0630(weaponobj);
  _id_BE5B251708F24AFD = getarraykeys(attachments);
  _id_952F1674FA8D734F = [];
  _id_2AE2FB154E39B67B = _id_2669878CF5A1B6BC::buildweapon(_id_2669878CF5A1B6BC::getweaponrootname(weaponobj));

  foreach(_id_121B7C7197B1C746 in _id_539CFFF6632D4FCE) {
    _id_7AD9EBA0904383B1 = _func_75B035199842693D(weaponobj, _id_121B7C7197B1C746);
    _id_2C68A0515F3CE810 = undefined;

    if(_id_7AD9EBA0904383B1.size == 0) {
      continue;
    }
    if(isDefined(_id_0C4D6B4CFA2D186C)) {
      foreach(_id_D9FDB7F121A35197 in _id_0C4D6B4CFA2D186C) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_7AD9EBA0904383B1.size; _id_AC0E594AC96AA3A8++) {
          if(issubstr(_id_7AD9EBA0904383B1[_id_AC0E594AC96AA3A8], _id_D9FDB7F121A35197)) {
            _id_2C68A0515F3CE810 = _id_AC0E594AC96AA3A8;
            break;
          }
        }

        if(isDefined(_id_2C68A0515F3CE810)) {
          break;
        }
      }
    }

    if(isDefined(_id_2C68A0515F3CE810) && isDefined(_id_7AD9EBA0904383B1[_id_2C68A0515F3CE810])) {
      _id_EFFB4AE1788A8B10 = _id_7AD9EBA0904383B1[_id_2C68A0515F3CE810];

      if(isDefined(_id_EFFB4AE1788A8B10))
        _id_952F1674FA8D734F[_id_952F1674FA8D734F.size] = _id_EFFB4AE1788A8B10;
    }
  }

  foreach(_id_931FB1B8D01470EC in _id_952F1674FA8D734F)
  _id_2AE2FB154E39B67B = _id_2AE2FB154E39B67B withattachment(_id_931FB1B8D01470EC);

  return _id_2AE2FB154E39B67B;
}

hb_sensor_used(grenade) {
  waitframe();

  if(isDefined(grenade))
    grenade delete();
}

ismeleeonly(weapon) {
  if(isstring(weapon)) {}

  return weapon.ismelee;
}

getammooverride(weaponobj) {
  baseweapon = weaponobj getbaseweapon();
  _id_A7CF832E6613FC43 = weaponclipsize(baseweapon);
  _id_2BE3302E3767CC7D = weaponclipsize(weaponobj);
  clipsize = _id_A7CF832E6613FC43;

  switch (weaponobj.basename) {
    case "iw8_lm_mkilo3_mp":
    case "iw8_sh_mike26_mp":
    case "iw8_sn_sksierra_mp":
      break;
    default:
      clipsize = int(min(_id_A7CF832E6613FC43, _id_2BE3302E3767CC7D));
  }

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
          case "iw8_sn_crossbow":
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

onequipmentplanted(_id_FEBA29CE82D4980F, equipmentref, deletefunc) {
  _id_FEBA29CE82D4980F.equipmentref = equipmentref;
  _id_FEBA29CE82D4980F.deletefunc = deletefunc;
  _id_FEBA29CE82D4980F.planted = 1;
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

issmallsplashdamage(objweapon) {
  if(objweapon.basename == "semtex_xmike109_splash_mp" || objweapon.basename == "thermite_xmike109_radius_mp" || objweapon.basename == "semtex_bolt_splash_mp" || objweapon.basename == "thermite_bolt_radius_mp")
    return 1;
  else
    return 0;
}

getweaponvariantids(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B) {
  if(!isDefined(_id_60EE6A5BAE11A91B))
    _id_60EE6A5BAE11A91B = [];

  id = 1;
  _id_C0AA7602B6BBC954 = [];

  for(;;) {
    _id_A6ED1602A5107749 = _id_4BB9768282D4260D + "|" + id;

    if(!isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749])) {
      break;
    }

    if(!level.weaponlootmapdata[_id_A6ED1602A5107749].islocked && !scripts\engine\utility::array_contains(_id_60EE6A5BAE11A91B, id))
      _id_C0AA7602B6BBC954[_id_C0AA7602B6BBC954.size] = id;

    id++;
  }

  return _id_C0AA7602B6BBC954;
}

getweaponrandomvariantid(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B) {
  if(!isDefined(_id_60EE6A5BAE11A91B))
    _id_60EE6A5BAE11A91B = [];

  id = 0;
  _id_7C7BEA4A64413C81 = getweaponvariantids(_id_4BB9768282D4260D, _id_60EE6A5BAE11A91B);

  if(_id_7C7BEA4A64413C81.size > 0)
    id = _id_7C7BEA4A64413C81[randomint(_id_7C7BEA4A64413C81.size)];

  return id;
}

weaponisValid(_id_4BB9768282D4260D, variantid) {
  _id_E2027D25381775DD = weaponexistsinstatstable(_id_4BB9768282D4260D);
  _id_36B5867A265820CE = 1;

  if(_id_E2027D25381775DD) {
    if(isDefined(isDefined(variantid)) && variantid > 0) {
      _id_A6ED1602A5107749 = _id_4BB9768282D4260D + "|" + variantid;
      _id_36B5867A265820CE = isDefined(level.weaponlootmapdata[_id_A6ED1602A5107749]) && !level.weaponlootmapdata[_id_A6ED1602A5107749].islocked;
    }
  }

  return _id_E2027D25381775DD && _id_36B5867A265820CE;
}

weaponexistsinstatstable(_id_4BB9768282D4260D) {
  return isDefined(level.weaponmapdata[_id_4BB9768282D4260D]);
}

getallselectableattachments(weapon) {
  weaponname = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  attachments = level.weaponattachments[weaponname];

  if(!isDefined(attachments))
    attachments = [];

  return attachments;
}